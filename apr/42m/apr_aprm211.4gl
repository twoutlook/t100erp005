#該程式未解開Section, 採用最新樣板產出!
{<section id="aprm211.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0016(2016-10-14 08:22:46), PR版次:0016(2016-11-14 09:34:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000212
#+ Filename...: aprm211
#+ Description: 一般促銷規則主檔
#+ Creator....: 02482(2014-03-27 00:00:00)
#+ Modifier...: 02749 -SD/PR- 02481
 
{</section>}
 
{<section id="aprm211.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160318-00005#38  2016/03/29 By 07900   重复错误讯息修改
#160318-00025#31  2016/04/11 By 07959   將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160503-00039#1   2016/05/04 by 08172   规则说明带出
#160905-00007#12  2016/09/05 by 08742   调整系统中无ENT的SQL条件增加ent
#160819-00054#16  2016/10/13   by lori  1.屬性：SCC=6517, 新增 15.商品編號+單位
#                                       2.當屬性="15.商品編號+單位"時,商品條碼才可維護
#161024-00025#8   2016/10/26  by 08742  组织开窗修改
#161111-00028#2   2016/11/11  BY 02481    标准程式定义采用宣告模式,弃用.*写法
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
   prdl010 LIKE prdl_t.prdl010, 
   prdl011 LIKE prdl_t.prdl011, 
   prdl012 LIKE prdl_t.prdl012, 
   prdl013 LIKE prdl_t.prdl013, 
   prdl038 LIKE prdl_t.prdl038, 
   prdl024 LIKE prdl_t.prdl024, 
   prdl025 LIKE prdl_t.prdl025, 
   prdl026 LIKE prdl_t.prdl026, 
   l_prdo003_1 LIKE type_t.dat, 
   l_prdo004_1 LIKE type_t.dat, 
   prdl098 LIKE prdl_t.prdl098, 
   prdl037 LIKE prdl_t.prdl037, 
   prdl034 LIKE prdl_t.prdl034, 
   prdl042 LIKE prdl_t.prdl042, 
   prdl004 LIKE prdl_t.prdl004, 
   prdl004_desc LIKE type_t.chr80, 
   prdl005 LIKE prdl_t.prdl005, 
   prdl005_desc LIKE type_t.chr80, 
   prdb005_1 LIKE type_t.num20_6, 
   prdo005_1 LIKE type_t.chr8, 
   prdo006_1 LIKE type_t.chr8, 
   prdl003 LIKE prdl_t.prdl003, 
   prdl033 LIKE prdl_t.prdl033, 
   prdl033_desc LIKE type_t.chr80, 
   prdl008 LIKE prdl_t.prdl008, 
   prdl008_desc LIKE type_t.chr80, 
   prdl009 LIKE prdl_t.prdl009, 
   prdl009_desc LIKE type_t.chr80, 
   prdb005_2 LIKE type_t.num20_6, 
   prdo007_1 LIKE type_t.chr10, 
   prdo008_1 LIKE type_t.chr1, 
   prdlsite LIKE prdl_t.prdlsite, 
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
   prdlcnfdt LIKE prdl_t.prdlcnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_prdp_d        RECORD
       prdp002 LIKE prdp_t.prdp002, 
   prdpstus LIKE prdp_t.prdpstus, 
   prdp003 LIKE prdp_t.prdp003, 
   prdp004 LIKE prdp_t.prdp004, 
   prdp004_desc LIKE type_t.chr500, 
   prdpsite LIKE prdp_t.prdpsite, 
   prdpunit LIKE prdp_t.prdpunit
       END RECORD
PRIVATE TYPE type_g_prdp2_d RECORD
       prdrstus LIKE prdr_t.prdrstus, 
   prdr002 LIKE prdr_t.prdr002, 
   prdr011 LIKE prdr_t.prdr011, 
   prdr003 LIKE prdr_t.prdr003, 
   prdr004 LIKE prdr_t.prdr004, 
   prdr004_desc LIKE type_t.chr500, 
   prdr005 LIKE prdr_t.prdr005, 
   prdr006 LIKE prdr_t.prdr006, 
   prdr006_desc LIKE type_t.chr500, 
   prdr007 LIKE prdr_t.prdr007, 
   prdrsite LIKE prdr_t.prdrsite, 
   prdrunit LIKE prdr_t.prdrunit, 
   prdr010 LIKE prdr_t.prdr010
       END RECORD
PRIVATE TYPE type_g_prdp3_d RECORD
       prdqstus LIKE prdq_t.prdqstus, 
   prdq003 LIKE prdq_t.prdq003, 
   prdq003_desc LIKE type_t.chr500, 
   prdq004 LIKE prdq_t.prdq004, 
   prdq004_desc LIKE type_t.chr500, 
   prdq002 LIKE prdq_t.prdq002, 
   prdqsite LIKE prdq_t.prdqsite, 
   prdqunit LIKE prdq_t.prdqunit
       END RECORD
PRIVATE TYPE type_g_prdp4_d RECORD
       prdostus LIKE prdo_t.prdostus, 
   prdo002 LIKE prdo_t.prdo002, 
   prdo003 LIKE prdo_t.prdo003, 
   prdo004 LIKE prdo_t.prdo004, 
   prdo005 LIKE prdo_t.prdo005, 
   prdo006 LIKE prdo_t.prdo006, 
   prdo007 LIKE prdo_t.prdo007, 
   prdo008 LIKE prdo_t.prdo008, 
   prdosite LIKE prdo_t.prdosite, 
   prdounit LIKE prdo_t.prdounit
       END RECORD
PRIVATE TYPE type_g_prdp5_d RECORD
       prdmstus LIKE prdm_t.prdmstus, 
   prdm004 LIKE prdm_t.prdm004, 
   prdm002 LIKE prdm_t.prdm002, 
   prdm003 LIKE prdm_t.prdm003, 
   prdm005 LIKE prdm_t.prdm005, 
   prdmsite LIKE prdm_t.prdmsite, 
   prdmunit LIKE prdm_t.prdmunit
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
DEFINE g_wc2_table6          STRING
 TYPE type_g_prdp6_d RECORD
       prdnstus LIKE prdn_t.prdnstus,
       prdn002 LIKE prdn_t.prdn002, 
       prdn003 LIKE prdn_t.prdn003, 
       prdn004 LIKE prdn_t.prdn004, 
       prdn004_desc LIKE type_t.chr500, 
       prdnsite LIKE prdn_t.prdnsite, 
       prdnunit LIKE prdn_t.prdnunit
       END RECORD
DEFINE g_prdp6_d          DYNAMIC ARRAY OF type_g_prdp6_d
DEFINE g_prdp6_d_t        type_g_prdp6_d
DEFINE g_prdp6_d_o        type_g_prdp6_d
DEFINE g_prdp6_d_mask_o   DYNAMIC ARRAY OF type_g_prdp6_d #轉換遮罩前資料
DEFINE g_prdp6_d_mask_n   DYNAMIC ARRAY OF type_g_prdp6_d #轉換遮罩後資料     
DEFINE l_exeprog          LIKE type_t.chr80               #160318-00005#38  By 07900 --add
#end add-point
       
#模組變數(Module Variables)
DEFINE g_prdl_m          type_g_prdl_m
DEFINE g_prdl_m_t        type_g_prdl_m
DEFINE g_prdl_m_o        type_g_prdl_m
DEFINE g_prdl_m_mask_o   type_g_prdl_m #轉換遮罩前資料
DEFINE g_prdl_m_mask_n   type_g_prdl_m #轉換遮罩後資料
 
   DEFINE g_prdl001_t LIKE prdl_t.prdl001
 
 
DEFINE g_prdp_d          DYNAMIC ARRAY OF type_g_prdp_d
DEFINE g_prdp_d_t        type_g_prdp_d
DEFINE g_prdp_d_o        type_g_prdp_d
DEFINE g_prdp_d_mask_o   DYNAMIC ARRAY OF type_g_prdp_d #轉換遮罩前資料
DEFINE g_prdp_d_mask_n   DYNAMIC ARRAY OF type_g_prdp_d #轉換遮罩後資料
DEFINE g_prdp2_d          DYNAMIC ARRAY OF type_g_prdp2_d
DEFINE g_prdp2_d_t        type_g_prdp2_d
DEFINE g_prdp2_d_o        type_g_prdp2_d
DEFINE g_prdp2_d_mask_o   DYNAMIC ARRAY OF type_g_prdp2_d #轉換遮罩前資料
DEFINE g_prdp2_d_mask_n   DYNAMIC ARRAY OF type_g_prdp2_d #轉換遮罩後資料
DEFINE g_prdp3_d          DYNAMIC ARRAY OF type_g_prdp3_d
DEFINE g_prdp3_d_t        type_g_prdp3_d
DEFINE g_prdp3_d_o        type_g_prdp3_d
DEFINE g_prdp3_d_mask_o   DYNAMIC ARRAY OF type_g_prdp3_d #轉換遮罩前資料
DEFINE g_prdp3_d_mask_n   DYNAMIC ARRAY OF type_g_prdp3_d #轉換遮罩後資料
DEFINE g_prdp4_d          DYNAMIC ARRAY OF type_g_prdp4_d
DEFINE g_prdp4_d_t        type_g_prdp4_d
DEFINE g_prdp4_d_o        type_g_prdp4_d
DEFINE g_prdp4_d_mask_o   DYNAMIC ARRAY OF type_g_prdp4_d #轉換遮罩前資料
DEFINE g_prdp4_d_mask_n   DYNAMIC ARRAY OF type_g_prdp4_d #轉換遮罩後資料
DEFINE g_prdp5_d          DYNAMIC ARRAY OF type_g_prdp5_d
DEFINE g_prdp5_d_t        type_g_prdp5_d
DEFINE g_prdp5_d_o        type_g_prdp5_d
DEFINE g_prdp5_d_mask_o   DYNAMIC ARRAY OF type_g_prdp5_d #轉換遮罩前資料
DEFINE g_prdp5_d_mask_n   DYNAMIC ARRAY OF type_g_prdp5_d #轉換遮罩後資料
 
 
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
 
DEFINE g_wc2_table4   STRING
 
DEFINE g_wc2_table5   STRING
 
 
 
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
 
{<section id="aprm211.main" >}
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
   LET g_forupd_sql = " SELECT prdlunit,'',prdl001,prdl002,'',prdl006,'',prdl007,'',prdl027,prdl099, 
       prdl100,prdlstus,prdl010,prdl011,prdl012,prdl013,prdl038,prdl024,prdl025,prdl026,'','',prdl098, 
       prdl037,prdl034,prdl042,prdl004,'',prdl005,'','','','',prdl003,prdl033,'',prdl008,'',prdl009, 
       '','','','',prdlsite,prdlcrtid,'',prdlcrtdp,'',prdlcrtdt,prdlownid,'',prdlowndp,'',prdlmodid, 
       '',prdlmoddt,prdlcnfid,'',prdlcnfdt", 
                      " FROM prdl_t",
                      " WHERE prdlent= ? AND prdl001=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aprm211_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.prdlunit,t0.prdl001,t0.prdl002,t0.prdl006,t0.prdl007,t0.prdl027, 
       t0.prdl099,t0.prdl100,t0.prdlstus,t0.prdl010,t0.prdl011,t0.prdl012,t0.prdl013,t0.prdl038,t0.prdl024, 
       t0.prdl025,t0.prdl026,t0.prdl098,t0.prdl037,t0.prdl034,t0.prdl042,t0.prdl004,t0.prdl005,t0.prdl003, 
       t0.prdl033,t0.prdl008,t0.prdl009,t0.prdlsite,t0.prdlcrtid,t0.prdlcrtdp,t0.prdlcrtdt,t0.prdlownid, 
       t0.prdlowndp,t0.prdlmodid,t0.prdlmoddt,t0.prdlcnfid,t0.prdlcnfdt,t1.ooefl003 ,t2.prcfl003 ,t3.prcdl003 , 
       t4.ooag011 ,t5.ooefl003 ,t6.oocql004 ,t7.oocql004 ,t8.oocql004 ,t9.ooag011 ,t10.ooefl003 ,t11.ooag011 , 
       t12.ooefl003 ,t13.ooag011 ,t14.ooag011",
               " FROM prdl_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.prdlunit AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN prcfl_t t2 ON t2.prcflent="||g_enterprise||" AND t2.prcfl001=t0.prdl006 AND t2.prcfl002='"||g_dlang||"' ",
               " LEFT JOIN prcdl_t t3 ON t3.prcdlent="||g_enterprise||" AND t3.prcdl001=t0.prdl007 AND t3.prcdl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.prdl004  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.prdl005 AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t6 ON t6.oocqlent="||g_enterprise||" AND t6.oocql001='2135' AND t6.oocql002=t0.prdl033 AND t6.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t7 ON t7.oocqlent="||g_enterprise||" AND t7.oocql001='2100' AND t7.oocql002=t0.prdl008 AND t7.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t8 ON t8.oocqlent="||g_enterprise||" AND t8.oocql001='2101' AND t8.oocql002=t0.prdl009 AND t8.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.prdlcrtid  ",
               " LEFT JOIN ooefl_t t10 ON t10.ooeflent="||g_enterprise||" AND t10.ooefl001=t0.prdlcrtdp AND t10.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t11 ON t11.ooagent="||g_enterprise||" AND t11.ooag001=t0.prdlownid  ",
               " LEFT JOIN ooefl_t t12 ON t12.ooeflent="||g_enterprise||" AND t12.ooefl001=t0.prdlowndp AND t12.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t13 ON t13.ooagent="||g_enterprise||" AND t13.ooag001=t0.prdlmodid  ",
               " LEFT JOIN ooag_t t14 ON t14.ooagent="||g_enterprise||" AND t14.ooag001=t0.prdlcnfid  ",
 
               " WHERE t0.prdlent = " ||g_enterprise|| " AND t0.prdl001 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aprm211_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aprm211 WITH FORM cl_ap_formpath("apr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aprm211_init()   
 
      #進入選單 Menu (="N")
      CALL aprm211_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aprm211
      
   END IF 
   
   CLOSE aprm211_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success   #150308-00001#3 150309 pomelo add
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aprm211.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aprm211_init()
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
   LET g_detail_idx_list[2] = 1
   LET g_detail_idx_list[3] = 1
   LET g_detail_idx_list[4] = 1
   LET g_detail_idx_list[5] = 1
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('prdlstus','50','N,Y,X')
 
      CALL cl_set_combo_scc('prdl024','6564') 
   CALL cl_set_combo_scc('prdl025','6565') 
   CALL cl_set_combo_scc('prdl026','6566') 
   CALL cl_set_combo_scc('prdp003','6560') 
   CALL cl_set_combo_scc('prdr011','6761') 
   CALL cl_set_combo_scc('prdr003','6517') 
   CALL cl_set_combo_scc('prdo007','6520') 
   CALL cl_set_combo_scc('prdo008','30') 
   CALL cl_set_combo_scc('prdm003','6567') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
   CALL g_idx_group.addAttribute("'3',","1")
   CALL g_idx_group.addAttribute("'4',","1")
   CALL g_idx_group.addAttribute("'5',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_comp_visible('prdm004',FALSE)
   CALL aprm211_prdn003_display()  
   CALL cl_set_combo_scc('prdo007_1','6520') 
   CALL cl_set_combo_scc('prdo008_1','30') 
   CALL cl_set_combo_scc('b_prdl000','32') 
   CALL cl_set_combo_scc_part('prdl024','6564','2,3') 
   CALL cl_set_combo_scc_part('prdr003','6517','4,5,6,7,8,9,14,A,B,C,D,E,F,G,H,I,J,K,L,15')   #160819-00054#16 161013 by lori add:15
   CALL aprm211_set_comp_visible()
   CALL aprm211_set_comp_att_text()
   CALL s_aooi500_create_temp() RETURNING l_success   #150308-00001#3 150309 pomelo add
   
     
   #end add-point
   
   #初始化搜尋條件
   CALL aprm211_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="aprm211.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION aprm211_ui_dialog()
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
         CALL g_prdp_d.clear()
         CALL g_prdp2_d.clear()
         CALL g_prdp3_d.clear()
         CALL g_prdp4_d.clear()
         CALL g_prdp5_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aprm211_init()
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
               
               CALL aprm211_fetch('') # reload data
               LET l_ac = 1
               CALL aprm211_ui_detailshow() #Setting the current row 
         
               CALL aprm211_idx_chk()
               #NEXT FIELD prdp002
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_prdp_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aprm211_idx_chk()
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
               CALL aprm211_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_prdp2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aprm211_idx_chk()
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
               CALL aprm211_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_prdp3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aprm211_idx_chk()
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
               CALL aprm211_idx_chk()
               #add-point:page3自定義行為 name="ui_dialog.body3.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
         
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_prdp4_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aprm211_idx_chk()
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
               CALL aprm211_idx_chk()
               #add-point:page4自定義行為 name="ui_dialog.body4.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_4)
            
         
            #add-point:page4自定義行為 name="ui_dialog.body4.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_prdp5_d TO s_detail5.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aprm211_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail5")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[5] = l_ac
               CALL g_idx_group.addAttribute("'5',",l_ac)
               
               #add-point:page5, before row動作 name="ui_dialog.body5.before_row"
               IF g_prdp5_d[g_detail_idx].prdm003 = '2' THEN
                  CALL aprm211_prdn003_display()                     
               END IF
               IF g_prdp5_d[g_detail_idx].prdm003 = '3' THEN
                  CALL cl_set_combo_scc('prdn003','6035')
               END IF
               CALL aprm211_b6_fill() 
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'5',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail5")
               LET g_current_page = 5
               #顯示單身筆數
               CALL aprm211_idx_chk()
               #add-point:page5自定義行為 name="ui_dialog.body5.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_5)
            
         
            #add-point:page5自定義行為 name="ui_dialog.body5.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_prdp6_d TO s_detail6.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aprm211_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail6")
               LET g_detail_idx = l_ac
               
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail6")
               LET g_current_page = 6
               #顯示單身筆數
               CALL aprm211_idx_chk()
        
         END DISPLAY
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL aprm211_browser_fill("")
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
               CALL aprm211_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aprm211_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL aprm211_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL aprm211_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL aprm211_set_act_visible()   
            CALL aprm211_set_act_no_visible()
            IF NOT (g_prdl_m.prdl001 IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " prdlent = " ||g_enterprise|| " AND",
                                  " prdl001 = '", g_prdl_m.prdl001, "' "
 
               #填到對應位置
               CALL aprm211_browser_fill("")
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
 
               INITIALIZE g_wc2_table5 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "prdl_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "prdp_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "prdr_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "prdq_t" 
                        LET g_wc2_table3 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "prdo_t" 
                        LET g_wc2_table4 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "prdm_t" 
                        LET g_wc2_table5 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
                  OR NOT cl_null(g_wc2_table2)
 
                  OR NOT cl_null(g_wc2_table3)
 
                  OR NOT cl_null(g_wc2_table4)
 
                  OR NOT cl_null(g_wc2_table5)
 
 
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
 
                  IF g_wc2_table5 <> " 1=1" AND NOT cl_null(g_wc2_table5) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table5
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
 
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
               END IF
               CALL aprm211_browser_fill("F")   #browser_fill()會將notice區塊清空
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
 
               INITIALIZE g_wc2_table4 TO NULL
 
               INITIALIZE g_wc2_table5 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "prdl_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "prdp_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "prdr_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "prdq_t" 
                        LET g_wc2_table3 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "prdo_t" 
                        LET g_wc2_table4 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "prdm_t" 
                        LET g_wc2_table5 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1)
                  OR NOT cl_null(g_wc2_table2)
 
                  OR NOT cl_null(g_wc2_table3)
 
                  OR NOT cl_null(g_wc2_table4)
 
                  OR NOT cl_null(g_wc2_table5)
 
 
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
 
                  IF g_wc2_table5 <> " 1=1" AND NOT cl_null(g_wc2_table5) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table5
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL aprm211_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aprm211_fetch("F")
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
               CALL aprm211_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL aprm211_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprm211_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL aprm211_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprm211_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL aprm211_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprm211_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL aprm211_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprm211_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL aprm211_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprm211_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_prdp_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_prdp2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_prdp3_d)
                  LET g_export_id[3]   = "s_detail3"
                  LET g_export_node[4] = base.typeInfo.create(g_prdp4_d)
                  LET g_export_id[4]   = "s_detail4"
                  LET g_export_node[5] = base.typeInfo.create(g_prdp5_d)
                  LET g_export_id[5]   = "s_detail5"
 
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
               NEXT FIELD prdp002
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
               CALL aprm211_query()
               #add-point:ON ACTION query name="menu.query"
                LET g_current_row = g_current_idx
                LET g_curr_diag = ui.DIALOG.getCurrent()
                CALL aprm211_idx_chk()
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
               CALL g_curr_diag.setCurrentRow("s_detail4",1)
               CALL g_curr_diag.setCurrentRow("s_detail5",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION object
            LET g_action_choice="object"
            IF cl_auth_chk_act("object") THEN
               
               #add-point:ON ACTION object name="menu.object"
               IF NOT cl_null(g_prdl_m.prdl001) THEN
                  IF g_prdl_m.prdl026 = '4' THEN
                     CALL aprm211_01(g_prdl_m.prdl001,'N','N')
                  END IF
               END IF
               LET  g_action_choice=''
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION release
            LET g_action_choice="release"
            IF cl_auth_chk_act("release") THEN
               
               #add-point:ON ACTION release name="menu.release"
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
                    ELSE
                       SELECT prdl099,prdl100 INTO g_prdl_m.prdl099,g_prdl_m.prdl100
                         FROM prdl_t
                        WHERE prdlent=g_enterprise
                          AND prdl001=g_prdl_m.prdl001
                       DISPLAY BY NAME g_prdl_m.prdl099
                       DISPLAY BY NAME g_prdl_m.prdl100
                       IF g_prdl_m.prdl099 = 'Y' THEN
                          CALL cl_set_act_visible("release", FALSE)
                       ELSE
                          CALL cl_set_act_visible("release", TRUE)
                       END IF                       
                    
                    END IF
                  END IF
               END IF
               CALL s_transaction_end('Y','0')
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aprm211_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aprm211_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aprm211_set_pk_array()
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
 
{<section id="aprm211.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION aprm211_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   DEFINE l_where           STRING       #161024-00025#8   2016/10/26  by 08742       add
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
    LET l_wc  = l_wc CLIPPED," AND prdl003 = '1' AND prdl098 = '1'"
    LET g_wc  = g_wc CLIPPED," AND prdl003 = '1' AND prdl098 = '1'"
   #161024-00025#8   2016/10/26  by 08742  -S
   LET l_where = ''
   CALL s_aooi500_sql_where(g_prog,'prdlunit') RETURNING l_where
   LET l_wc = l_wc," AND ",l_where
   #161024-00025#8   2016/10/26  by 08742   -E
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT prdl001 ",
                      " FROM prdl_t ",
                      " ",
                      " LEFT JOIN prdp_t ON prdpent = prdlent AND prdl001 = prdp001 ", "  ",
                      #add-point:browser_fill段sql(prdp_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
                      " LEFT JOIN prdr_t ON prdrent = prdlent AND prdl001 = prdr001", "  ",
                      #add-point:browser_fill段sql(prdr_t1) name="browser_fill.cnt.join.prdr_t1"
                      
                      #end add-point
 
                      " LEFT JOIN prdq_t ON prdqent = prdlent AND prdl001 = prdq001", "  ",
                      #add-point:browser_fill段sql(prdq_t1) name="browser_fill.cnt.join.prdq_t1"
                      
                      #end add-point
 
                      " LEFT JOIN prdo_t ON prdoent = prdlent AND prdl001 = prdo001", "  ",
                      #add-point:browser_fill段sql(prdo_t1) name="browser_fill.cnt.join.prdo_t1"
                      
                      #end add-point
 
                      " LEFT JOIN prdm_t ON prdment = prdlent AND prdl001 = prdm001", "  ",
                      #add-point:browser_fill段sql(prdm_t1) name="browser_fill.cnt.join.prdm_t1"
                      " LEFT JOIN prdn_t ON prdnent = prdlent AND prdn001 = prdl001 AND prdn002 = prdm002", "  ",
                      #end add-point
 
 
 
                      " LEFT JOIN prdll_t ON prdllent = "||g_enterprise||" AND prdl001 = prdll001 AND prdll002 = '",g_dlang,"' ", 
                      " ", 
                      " ",                      
 
                      " ",                      
 
                      " ",                      
 
                      " ",                      
 
 
 
                      " WHERE prdlent = " ||g_enterprise|| " AND prdpent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("prdl_t")
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
   #IF g_wc2 <> " 1=1" THEN
   #   #單身有輸入搜尋條件                      
   #   LET l_sub_sql = " SELECT UNIQUE prdl001 ",
   #
   #                     " FROM prdl_t ",
   #                           " ",
   #                           " LEFT JOIN prdp_t ON prdpent = prdlent AND prdl001 = prdp001 ",
   #                           " LEFT JOIN prdr_t ON prdrent = prdlent AND prdl001 = prdr001", 
   #
   #                           " LEFT JOIN prdq_t ON prdqent = prdlent AND prdl001 = prdq001", 
   #
   #                           " LEFT JOIN prdo_t ON prdoent = prdlent AND prdl001 = prdo001",
   #                           " LEFT JOIN prdm_t ON prdment = prdlent AND prdl001 = prdm001",                              
   #                           " LEFT JOIN prdn_t ON prdnent = prdlent AND prdn001 = prdl001 AND prdn002 = prdm002",
   #
   #
   #
   #                           " LEFT JOIN prdll_t ON prdl001 = prdll001 AND prdll002 = '",g_lang,"' ", 
   #                           " ", 
   #                    " WHERE prdlent = '" ||g_enterprise|| "' AND prdpent = '" ||g_enterprise|| "' AND prdl003 = '1' AND ",l_wc, " AND ", l_wc2
   #
   #ELSE
   #   #單身未輸入搜尋條件
   #   LET l_sub_sql = " SELECT UNIQUE prdl001 ",
   #
   #                     " FROM prdl_t ", 
   #                           " ",
   #                           " LEFT JOIN prdll_t ON prdl001 = prdll001 AND prdll002 = '",g_lang,"' ",
   #                     "WHERE prdlent = '" ||g_enterprise|| "' AND prdl003 = '1' AND ",l_wc CLIPPED
   #
   #END IF
   #
   #LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"
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
      CALL g_prdp_d.clear()        
      CALL g_prdp2_d.clear() 
      CALL g_prdp3_d.clear() 
      CALL g_prdp4_d.clear() 
      CALL g_prdp5_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      CALL g_prdp6_d.clear()
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
                  "  LEFT JOIN prdp_t ON prdpent = prdlent AND prdl001 = prdp001 ", "  ", 
                  #add-point:browser_fill段sql(prdp_t1) name="browser_fill.join.prdp_t1"
                  
                  #end add-point
                  "  LEFT JOIN prdr_t ON prdrent = prdlent AND prdl001 = prdr001", "  ", 
                  #add-point:browser_fill段sql(prdr_t1) name="browser_fill.join.prdr_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN prdq_t ON prdqent = prdlent AND prdl001 = prdq001", "  ", 
                  #add-point:browser_fill段sql(prdq_t1) name="browser_fill.join.prdq_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN prdo_t ON prdoent = prdlent AND prdl001 = prdo001", "  ", 
                  #add-point:browser_fill段sql(prdo_t1) name="browser_fill.join.prdo_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN prdm_t ON prdment = prdlent AND prdl001 = prdm001", "  ", 
                  #add-point:browser_fill段sql(prdm_t1) name="browser_fill.join.prdm_t1"
               " LEFT JOIN prdn_t ON prdnent = prdlent AND prdn001 = prdl001 AND prdn002 = prdm002", "  ",
                  #end add-point
 
 
 
                  " ", 
                  " ",                      
 
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
#   IF g_wc2 <> " 1=1" AND NOT cl_null(g_wc2) THEN 
#      #依照prdlunit,'',prdl001,prdl002,prdl006,'',prdl007,'',prdl027 Browser欄位定義(取代原本bs_sql功能)
#      LET l_sql_rank = "SELECT DISTINCT prdlstus,prdlunit,'',prdl001,prdl002,prdl006,'',prdl007,'',prdl027, 
#          DENSE_RANK() OVER(ORDER BY prdl001 ",g_order,") AS RANK ",
#                        " FROM prdl_t ",
#                              " ",
#                              " LEFT JOIN prdp_t ON prdpent = prdlent AND prdl001 = prdp001 ",
#                              " LEFT JOIN prdr_t ON prdrent = prdlent AND prdl001 = prdr001",
# 
#                              " LEFT JOIN prdq_t ON prdqent = prdlent AND prdl001 = prdq001",
# 
#                              " LEFT JOIN prdo_t ON prdoent = prdlent AND prdl001 = prdo001",
# 
# 
# 
#                              " LEFT JOIN prdll_t ON prdl001 = prdll001 AND prdll002 = '",g_lang,"' ",
#                              " ",
#                       " ",
#                       " WHERE prdlent = '" ||g_enterprise|| "' AND prdl003 = '1'  AND ",g_wc," AND ",g_wc2
#   ELSE
#      #單身無輸入資料
#      LET l_sql_rank = "SELECT DISTINCT prdlstus,prdlunit,'',prdl001,prdl002,prdl006,'',prdl007,'',prdl027, 
#          DENSE_RANK() OVER(ORDER BY prdl001 ",g_order,") AS RANK ",
#                       " FROM prdl_t ",
#                            "  ",
#                            "  LEFT JOIN prdll_t ON prdl001 = prdll001 AND prdll002 = '",g_lang,"' ",
#                       " WHERE prdlent = '" ||g_enterprise|| "' AND prdl003 = '1' AND ", g_wc
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
         CALL aprm211_browser_mask()
      
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
 
{<section id="aprm211.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION aprm211_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_prdl_m.prdl001 = g_browser[g_current_idx].b_prdl001   
 
   EXECUTE aprm211_master_referesh USING g_prdl_m.prdl001 INTO g_prdl_m.prdlunit,g_prdl_m.prdl001,g_prdl_m.prdl002, 
       g_prdl_m.prdl006,g_prdl_m.prdl007,g_prdl_m.prdl027,g_prdl_m.prdl099,g_prdl_m.prdl100,g_prdl_m.prdlstus, 
       g_prdl_m.prdl010,g_prdl_m.prdl011,g_prdl_m.prdl012,g_prdl_m.prdl013,g_prdl_m.prdl038,g_prdl_m.prdl024, 
       g_prdl_m.prdl025,g_prdl_m.prdl026,g_prdl_m.prdl098,g_prdl_m.prdl037,g_prdl_m.prdl034,g_prdl_m.prdl042, 
       g_prdl_m.prdl004,g_prdl_m.prdl005,g_prdl_m.prdl003,g_prdl_m.prdl033,g_prdl_m.prdl008,g_prdl_m.prdl009, 
       g_prdl_m.prdlsite,g_prdl_m.prdlcrtid,g_prdl_m.prdlcrtdp,g_prdl_m.prdlcrtdt,g_prdl_m.prdlownid, 
       g_prdl_m.prdlowndp,g_prdl_m.prdlmodid,g_prdl_m.prdlmoddt,g_prdl_m.prdlcnfid,g_prdl_m.prdlcnfdt, 
       g_prdl_m.prdlunit_desc,g_prdl_m.prdl006_desc,g_prdl_m.prdl007_desc,g_prdl_m.prdl004_desc,g_prdl_m.prdl005_desc, 
       g_prdl_m.prdl033_desc,g_prdl_m.prdl008_desc,g_prdl_m.prdl009_desc,g_prdl_m.prdlcrtid_desc,g_prdl_m.prdlcrtdp_desc, 
       g_prdl_m.prdlownid_desc,g_prdl_m.prdlowndp_desc,g_prdl_m.prdlmodid_desc,g_prdl_m.prdlcnfid_desc 
 
   
   CALL aprm211_prdl_t_mask()
   CALL aprm211_show()
      
END FUNCTION
 
{</section>}
 
{<section id="aprm211.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION aprm211_ui_detailshow()
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
      CALL g_curr_diag.setCurrentRow("s_detail5",g_detail_idx)
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aprm211.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aprm211_ui_browser_refresh()
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
 
{<section id="aprm211.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aprm211_construct()
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
   INITIALIZE g_prdl_m.* TO NULL
   CALL g_prdp_d.clear()        
   CALL g_prdp2_d.clear() 
   CALL g_prdp3_d.clear() 
   CALL g_prdp4_d.clear() 
   CALL g_prdp5_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
   INITIALIZE g_wc2_table2 TO NULL
 
   INITIALIZE g_wc2_table3 TO NULL
 
   INITIALIZE g_wc2_table4 TO NULL
 
   INITIALIZE g_wc2_table5 TO NULL
 
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   CALL g_prdp6_d.clear()
   INITIALIZE g_wc2_table6 TO NULL
   CALL cl_set_comp_visible("page_2", TRUE)
   
   CALL cl_set_comp_visible('bpage2',TRUE)
   CALL cl_set_comp_visible('bpage3',TRUE)
   CALL cl_set_comp_visible('bpage4',TRUE)
   CALL cl_set_comp_visible('lbl_prdo003',TRUE)
   CALL cl_set_comp_visible('l_prdo003_1',TRUE)
   CALL cl_set_comp_visible('lbl_prdo004',TRUE)
   CALL cl_set_comp_visible('l_prdo004_1',TRUE)
   CALL cl_set_comp_visible('lbl_prdo005',TRUE)
   CALL cl_set_comp_visible('prdo005_1',TRUE)
   CALL cl_set_comp_visible('lbl_prdo006',TRUE)
   CALL cl_set_comp_visible('prdo006_1',TRUE)
   CALL cl_set_comp_visible('lbl_prdo007',TRUE)
   CALL cl_set_comp_visible('prdo007_1',TRUE)
   CALL cl_set_comp_visible('lbl_prdo008',TRUE)
   CALL cl_set_comp_visible('prdo008_1',TRUE)
   CALL cl_set_comp_visible('lbl_prdb005_1',TRUE)
   CALL cl_set_comp_visible('lbl_prdb005_2',TRUE)
   CALL cl_set_comp_visible('prdb005_1',TRUE)
   CALL cl_set_comp_visible('prdb005_2',TRUE)
   CALL cl_set_comp_visible('lbl_3',FALSE)
   CALL cl_set_comp_visible('lbl_4',FALSE)
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON prdlunit,prdl001,prdl002,prdll003,prdl006,prdl007,prdl027,prdl099,prdl100, 
          prdlstus,prdl010,prdl011,prdl012,prdl013,prdl038,prdl024,prdl025,prdl026,prdl098,prdl037,prdl034, 
          prdl042,prdl004,prdl005,prdl003,prdl033,prdl008,prdl009,prdlsite,prdlcrtid,prdlcrtdp,prdlcrtdt, 
          prdlownid,prdlowndp,prdlmodid,prdlmoddt,prdlcnfid,prdlcnfdt
 
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
            #sakura---add---str
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'prdlunit',g_site,'c') #150308-00001#3 150309 pomelo add 'c'
            CALL q_ooef001_24()                           #呼叫開窗         
            #sakura---add---end			   
            #CALL q_ooef001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdlunit  #顯示到畫面上
            #DISPLAY g_qryparam.return2 TO ooefl003 #說明(簡稱) 

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
			LET g_qryparam.arg1 = '1'
			LET g_qryparam.arg2 = '1'
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
			   LET g_qryparam.arg1 = '1'
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
			   LET g_qryparam.arg1 = '1'
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
         BEFORE FIELD prdl038
            #add-point:BEFORE FIELD prdl038 name="construct.b.prdl038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl038
            
            #add-point:AFTER FIELD prdl038 name="construct.a.prdl038"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prdl038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl038
            #add-point:ON ACTION controlp INFIELD prdl038 name="construct.c.prdl038"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl024
            #add-point:BEFORE FIELD prdl024 name="construct.b.prdl024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl024
            
            #add-point:AFTER FIELD prdl024 name="construct.a.prdl024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prdl024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl024
            #add-point:ON ACTION controlp INFIELD prdl024 name="construct.c.prdl024"
            
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
         BEFORE FIELD prdl037
            #add-point:BEFORE FIELD prdl037 name="construct.b.prdl037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl037
            
            #add-point:AFTER FIELD prdl037 name="construct.a.prdl037"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prdl037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl037
            #add-point:ON ACTION controlp INFIELD prdl037 name="construct.c.prdl037"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl034
            #add-point:BEFORE FIELD prdl034 name="construct.b.prdl034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl034
            
            #add-point:AFTER FIELD prdl034 name="construct.a.prdl034"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prdl034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl034
            #add-point:ON ACTION controlp INFIELD prdl034 name="construct.c.prdl034"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl042
            #add-point:BEFORE FIELD prdl042 name="construct.b.prdl042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl042
            
            #add-point:AFTER FIELD prdl042 name="construct.a.prdl042"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prdl042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl042
            #add-point:ON ACTION controlp INFIELD prdl042 name="construct.c.prdl042"
            
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
               #DISPLAY g_qryparam.return2 TO ooeg001 #部門編號 

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
 
 
         #Ctrlp:construct.c.prdl033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl033
            #add-point:ON ACTION controlp INFIELD prdl033 name="construct.c.prdl033"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2135'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdl033  #顯示到畫面上
            NEXT FIELD prdl033                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl033
            #add-point:BEFORE FIELD prdl033 name="construct.b.prdl033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl033
            
            #add-point:AFTER FIELD prdl033 name="construct.a.prdl033"
            
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
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON prdp002,prdpstus,prdp003,prdp004,prdpsite,prdpunit
           FROM s_detail1[1].prdp002,s_detail1[1].prdpstus,s_detail1[1].prdp003,s_detail1[1].prdp004, 
               s_detail1[1].prdpsite,s_detail1[1].prdpunit
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<prdpcrtdt>>----
 
         #----<<prdpmoddt>>----
         
         #----<<prdpcnfdt>>----
         
         #----<<prdppstdt>>----
 
 
 
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdp002
            #add-point:BEFORE FIELD prdp002 name="construct.b.page1.prdp002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdp002
            
            #add-point:AFTER FIELD prdp002 name="construct.a.page1.prdp002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prdp002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdp002
            #add-point:ON ACTION controlp INFIELD prdp002 name="construct.c.page1.prdp002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdpstus
            #add-point:BEFORE FIELD prdpstus name="construct.b.page1.prdpstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdpstus
            
            #add-point:AFTER FIELD prdpstus name="construct.a.page1.prdpstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prdpstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdpstus
            #add-point:ON ACTION controlp INFIELD prdpstus name="construct.c.page1.prdpstus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdp003
            #add-point:BEFORE FIELD prdp003 name="construct.b.page1.prdp003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdp003
            
            #add-point:AFTER FIELD prdp003 name="construct.a.page1.prdp003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prdp003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdp003
            #add-point:ON ACTION controlp INFIELD prdp003 name="construct.c.page1.prdp003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.prdp004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdp004
            #add-point:ON ACTION controlp INFIELD prdp004 name="construct.c.page1.prdp004"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = '1'
            LET g_qryparam.arg2 = '1'
            CALL q_prdp004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdp004  #顯示到畫面上

            NEXT FIELD prdp004                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdp004
            #add-point:BEFORE FIELD prdp004 name="construct.b.page1.prdp004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdp004
            
            #add-point:AFTER FIELD prdp004 name="construct.a.page1.prdp004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdpsite
            #add-point:BEFORE FIELD prdpsite name="construct.b.page1.prdpsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdpsite
            
            #add-point:AFTER FIELD prdpsite name="construct.a.page1.prdpsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prdpsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdpsite
            #add-point:ON ACTION controlp INFIELD prdpsite name="construct.c.page1.prdpsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdpunit
            #add-point:BEFORE FIELD prdpunit name="construct.b.page1.prdpunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdpunit
            
            #add-point:AFTER FIELD prdpunit name="construct.a.page1.prdpunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prdpunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdpunit
            #add-point:ON ACTION controlp INFIELD prdpunit name="construct.c.page1.prdpunit"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON prdrstus,prdr002,prdr011,prdr003,prdr004,prdr005,prdr006,prdr007,prdrsite, 
          prdrunit,prdr010
           FROM s_detail2[1].prdrstus,s_detail2[1].prdr002,s_detail2[1].prdr011,s_detail2[1].prdr003, 
               s_detail2[1].prdr004,s_detail2[1].prdr005,s_detail2[1].prdr006,s_detail2[1].prdr007,s_detail2[1].prdrsite, 
               s_detail2[1].prdrunit,s_detail2[1].prdr010
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<prdrcrtdt>>----
 
         #----<<prdrmoddt>>----
         
         #----<<prdrcnfdt>>----
         
         #----<<prdrpstdt>>----
 
 
 
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdrstus
            #add-point:BEFORE FIELD prdrstus name="construct.b.page2.prdrstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdrstus
            
            #add-point:AFTER FIELD prdrstus name="construct.a.page2.prdrstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prdrstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdrstus
            #add-point:ON ACTION controlp INFIELD prdrstus name="construct.c.page2.prdrstus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdr002
            #add-point:BEFORE FIELD prdr002 name="construct.b.page2.prdr002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdr002
            
            #add-point:AFTER FIELD prdr002 name="construct.a.page2.prdr002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prdr002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdr002
            #add-point:ON ACTION controlp INFIELD prdr002 name="construct.c.page2.prdr002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdr011
            #add-point:BEFORE FIELD prdr011 name="construct.b.page2.prdr011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdr011
            
            #add-point:AFTER FIELD prdr011 name="construct.a.page2.prdr011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prdr011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdr011
            #add-point:ON ACTION controlp INFIELD prdr011 name="construct.c.page2.prdr011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdr003
            #add-point:BEFORE FIELD prdr003 name="construct.b.page2.prdr003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdr003
            
            #add-point:AFTER FIELD prdr003 name="construct.a.page2.prdr003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prdr003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdr003
            #add-point:ON ACTION controlp INFIELD prdr003 name="construct.c.page2.prdr003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.prdr004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdr004
            #add-point:ON ACTION controlp INFIELD prdr004 name="construct.c.page2.prdr004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = '1'
            LET g_qryparam.arg2 = '1'
            CALL q_prdr004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdr004  #顯示到畫面上

            NEXT FIELD prdr004                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdr004
            #add-point:BEFORE FIELD prdr004 name="construct.b.page2.prdr004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdr004
            
            #add-point:AFTER FIELD prdr004 name="construct.a.page2.prdr004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prdr005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdr005
            #add-point:ON ACTION controlp INFIELD prdr005 name="construct.c.page2.prdr005"
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
            #add-point:BEFORE FIELD prdr005 name="construct.b.page2.prdr005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdr005
            
            #add-point:AFTER FIELD prdr005 name="construct.a.page2.prdr005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prdr006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdr006
            #add-point:ON ACTION controlp INFIELD prdr006 name="construct.c.page2.prdr006"
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
            #add-point:BEFORE FIELD prdr006 name="construct.b.page2.prdr006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdr006
            
            #add-point:AFTER FIELD prdr006 name="construct.a.page2.prdr006"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdr007
            #add-point:BEFORE FIELD prdr007 name="construct.b.page2.prdr007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdr007
            
            #add-point:AFTER FIELD prdr007 name="construct.a.page2.prdr007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prdr007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdr007
            #add-point:ON ACTION controlp INFIELD prdr007 name="construct.c.page2.prdr007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdrsite
            #add-point:BEFORE FIELD prdrsite name="construct.b.page2.prdrsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdrsite
            
            #add-point:AFTER FIELD prdrsite name="construct.a.page2.prdrsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prdrsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdrsite
            #add-point:ON ACTION controlp INFIELD prdrsite name="construct.c.page2.prdrsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdrunit
            #add-point:BEFORE FIELD prdrunit name="construct.b.page2.prdrunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdrunit
            
            #add-point:AFTER FIELD prdrunit name="construct.a.page2.prdrunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prdrunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdrunit
            #add-point:ON ACTION controlp INFIELD prdrunit name="construct.c.page2.prdrunit"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdr010
            #add-point:BEFORE FIELD prdr010 name="construct.b.page2.prdr010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdr010
            
            #add-point:AFTER FIELD prdr010 name="construct.a.page2.prdr010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prdr010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdr010
            #add-point:ON ACTION controlp INFIELD prdr010 name="construct.c.page2.prdr010"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table3 ON prdqstus,prdq003,prdq004,prdq002,prdqsite,prdqunit
           FROM s_detail3[1].prdqstus,s_detail3[1].prdq003,s_detail3[1].prdq004,s_detail3[1].prdq002, 
               s_detail3[1].prdqsite,s_detail3[1].prdqunit
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body3.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 3)
       #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<prdqcrtdt>>----
 
         #----<<prdqmoddt>>----
         
         #----<<prdqcnfdt>>----
         
         #----<<prdqpstdt>>----
 
 
 
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdqstus
            #add-point:BEFORE FIELD prdqstus name="construct.b.page3.prdqstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdqstus
            
            #add-point:AFTER FIELD prdqstus name="construct.a.page3.prdqstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.prdqstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdqstus
            #add-point:ON ACTION controlp INFIELD prdqstus name="construct.c.page3.prdqstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.prdq003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdq003
            #add-point:ON ACTION controlp INFIELD prdq003 name="construct.c.page3.prdq003"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooia001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdq003  #顯示到畫面上
            
            NEXT FIELD prdq003                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdq003
            #add-point:BEFORE FIELD prdq003 name="construct.b.page3.prdq003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdq003
            
            #add-point:AFTER FIELD prdq003 name="construct.a.page3.prdq003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.prdq004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdq004
            #add-point:ON ACTION controlp INFIELD prdq004 name="construct.c.page3.prdq004"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = '1'
            LET g_qryparam.arg2 = '1'
            CALL q_prdq004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdq004  #顯示到畫面上

            NEXT FIELD prdq004                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdq004
            #add-point:BEFORE FIELD prdq004 name="construct.b.page3.prdq004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdq004
            
            #add-point:AFTER FIELD prdq004 name="construct.a.page3.prdq004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdq002
            #add-point:BEFORE FIELD prdq002 name="construct.b.page3.prdq002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdq002
            
            #add-point:AFTER FIELD prdq002 name="construct.a.page3.prdq002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.prdq002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdq002
            #add-point:ON ACTION controlp INFIELD prdq002 name="construct.c.page3.prdq002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdqsite
            #add-point:BEFORE FIELD prdqsite name="construct.b.page3.prdqsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdqsite
            
            #add-point:AFTER FIELD prdqsite name="construct.a.page3.prdqsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.prdqsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdqsite
            #add-point:ON ACTION controlp INFIELD prdqsite name="construct.c.page3.prdqsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdqunit
            #add-point:BEFORE FIELD prdqunit name="construct.b.page3.prdqunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdqunit
            
            #add-point:AFTER FIELD prdqunit name="construct.a.page3.prdqunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.prdqunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdqunit
            #add-point:ON ACTION controlp INFIELD prdqunit name="construct.c.page3.prdqunit"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table4 ON prdostus,prdo002,prdo003,prdo004,prdo005,prdo006,prdo007,prdo008,prdosite, 
          prdounit
           FROM s_detail4[1].prdostus,s_detail4[1].prdo002,s_detail4[1].prdo003,s_detail4[1].prdo004, 
               s_detail4[1].prdo005,s_detail4[1].prdo006,s_detail4[1].prdo007,s_detail4[1].prdo008,s_detail4[1].prdosite, 
               s_detail4[1].prdounit
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body4.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 4)
       #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<prdocrtdt>>----
 
         #----<<prdomoddt>>----
         
         #----<<prdocnfdt>>----
         
         #----<<prdopstdt>>----
 
 
 
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdostus
            #add-point:BEFORE FIELD prdostus name="construct.b.page4.prdostus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdostus
            
            #add-point:AFTER FIELD prdostus name="construct.a.page4.prdostus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.prdostus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdostus
            #add-point:ON ACTION controlp INFIELD prdostus name="construct.c.page4.prdostus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdo002
            #add-point:BEFORE FIELD prdo002 name="construct.b.page4.prdo002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdo002
            
            #add-point:AFTER FIELD prdo002 name="construct.a.page4.prdo002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.prdo002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdo002
            #add-point:ON ACTION controlp INFIELD prdo002 name="construct.c.page4.prdo002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdo003
            #add-point:BEFORE FIELD prdo003 name="construct.b.page4.prdo003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdo003
            
            #add-point:AFTER FIELD prdo003 name="construct.a.page4.prdo003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.prdo003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdo003
            #add-point:ON ACTION controlp INFIELD prdo003 name="construct.c.page4.prdo003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdo004
            #add-point:BEFORE FIELD prdo004 name="construct.b.page4.prdo004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdo004
            
            #add-point:AFTER FIELD prdo004 name="construct.a.page4.prdo004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.prdo004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdo004
            #add-point:ON ACTION controlp INFIELD prdo004 name="construct.c.page4.prdo004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdo005
            #add-point:BEFORE FIELD prdo005 name="construct.b.page4.prdo005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdo005
            
            #add-point:AFTER FIELD prdo005 name="construct.a.page4.prdo005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.prdo005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdo005
            #add-point:ON ACTION controlp INFIELD prdo005 name="construct.c.page4.prdo005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdo006
            #add-point:BEFORE FIELD prdo006 name="construct.b.page4.prdo006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdo006
            
            #add-point:AFTER FIELD prdo006 name="construct.a.page4.prdo006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.prdo006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdo006
            #add-point:ON ACTION controlp INFIELD prdo006 name="construct.c.page4.prdo006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdo007
            #add-point:BEFORE FIELD prdo007 name="construct.b.page4.prdo007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdo007
            
            #add-point:AFTER FIELD prdo007 name="construct.a.page4.prdo007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.prdo007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdo007
            #add-point:ON ACTION controlp INFIELD prdo007 name="construct.c.page4.prdo007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdo008
            #add-point:BEFORE FIELD prdo008 name="construct.b.page4.prdo008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdo008
            
            #add-point:AFTER FIELD prdo008 name="construct.a.page4.prdo008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.prdo008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdo008
            #add-point:ON ACTION controlp INFIELD prdo008 name="construct.c.page4.prdo008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdosite
            #add-point:BEFORE FIELD prdosite name="construct.b.page4.prdosite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdosite
            
            #add-point:AFTER FIELD prdosite name="construct.a.page4.prdosite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.prdosite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdosite
            #add-point:ON ACTION controlp INFIELD prdosite name="construct.c.page4.prdosite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdounit
            #add-point:BEFORE FIELD prdounit name="construct.b.page4.prdounit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdounit
            
            #add-point:AFTER FIELD prdounit name="construct.a.page4.prdounit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.prdounit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdounit
            #add-point:ON ACTION controlp INFIELD prdounit name="construct.c.page4.prdounit"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table5 ON prdmstus,prdm004,prdm002,prdm003,prdm005,prdmsite,prdmunit
           FROM s_detail5[1].prdmstus,s_detail5[1].prdm004,s_detail5[1].prdm002,s_detail5[1].prdm003, 
               s_detail5[1].prdm005,s_detail5[1].prdmsite,s_detail5[1].prdmunit
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body5.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 5)
       #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<prdmcrtdt>>----
 
         #----<<prdmmoddt>>----
         
         #----<<prdmcnfdt>>----
         
         #----<<prdmpstdt>>----
 
 
 
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdmstus
            #add-point:BEFORE FIELD prdmstus name="construct.b.page5.prdmstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdmstus
            
            #add-point:AFTER FIELD prdmstus name="construct.a.page5.prdmstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.prdmstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdmstus
            #add-point:ON ACTION controlp INFIELD prdmstus name="construct.c.page5.prdmstus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdm004
            #add-point:BEFORE FIELD prdm004 name="construct.b.page5.prdm004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdm004
            
            #add-point:AFTER FIELD prdm004 name="construct.a.page5.prdm004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.prdm004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdm004
            #add-point:ON ACTION controlp INFIELD prdm004 name="construct.c.page5.prdm004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdm002
            #add-point:BEFORE FIELD prdm002 name="construct.b.page5.prdm002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdm002
            
            #add-point:AFTER FIELD prdm002 name="construct.a.page5.prdm002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.prdm002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdm002
            #add-point:ON ACTION controlp INFIELD prdm002 name="construct.c.page5.prdm002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdm003
            #add-point:BEFORE FIELD prdm003 name="construct.b.page5.prdm003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdm003
            
            #add-point:AFTER FIELD prdm003 name="construct.a.page5.prdm003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.prdm003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdm003
            #add-point:ON ACTION controlp INFIELD prdm003 name="construct.c.page5.prdm003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdm005
            #add-point:BEFORE FIELD prdm005 name="construct.b.page5.prdm005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdm005
            
            #add-point:AFTER FIELD prdm005 name="construct.a.page5.prdm005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.prdm005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdm005
            #add-point:ON ACTION controlp INFIELD prdm005 name="construct.c.page5.prdm005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdmsite
            #add-point:BEFORE FIELD prdmsite name="construct.b.page5.prdmsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdmsite
            
            #add-point:AFTER FIELD prdmsite name="construct.a.page5.prdmsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.prdmsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdmsite
            #add-point:ON ACTION controlp INFIELD prdmsite name="construct.c.page5.prdmsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdmunit
            #add-point:BEFORE FIELD prdmunit name="construct.b.page5.prdmunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdmunit
            
            #add-point:AFTER FIELD prdmunit name="construct.a.page5.prdmunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.prdmunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdmunit
            #add-point:ON ACTION controlp INFIELD prdmunit name="construct.c.page5.prdmunit"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
     CONSTRUCT g_wc2_table6 ON prdn002,prdn003,prdn004,prdnstus,prdnsite,prdnunit
           FROM s_detail6[1].prdn002,s_detail6[1].prdn003,s_detail6[1].prdn004,s_detail6[1].prdnstus, 
               s_detail6[1].prdnsite,s_detail6[1].prdnunit
                      
         BEFORE CONSTRUCT

         BEFORE FIELD prdn002

 

         AFTER FIELD prdn002

 

         ON ACTION controlp INFIELD prdn002

         BEFORE FIELD prdn003

         AFTER FIELD prdn003
            

         ON ACTION controlp INFIELD prdn003

         ON ACTION controlp INFIELD prdn004
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = '1'
			   LET g_qryparam.arg2 = '1'
            CALL q_prdn004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdn004  #顯示到畫面上
            
            NEXT FIELD prdn004                     #返回原欄位


         BEFORE FIELD prdn004

         AFTER FIELD prdn004
            

         BEFORE FIELD prdnstus

         AFTER FIELD prdnstus
            

         ON ACTION controlp INFIELD prdnstus

         BEFORE FIELD prdnsite

         AFTER FIELD prdnsite
            

         ON ACTION controlp INFIELD prdnsite


         BEFORE FIELD prdnunit

         AFTER FIELD prdnunit
            

         ON ACTION controlp INFIELD prdnunit
       
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
 
            INITIALIZE g_wc2_table4 TO NULL
 
            INITIALIZE g_wc2_table5 TO NULL
 
 
            FOR li_idx = 1 TO la_wc.getLength()
               CASE
                  WHEN la_wc[li_idx].tableid = "prdl_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "prdp_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "prdr_t" 
                     LET g_wc2_table2 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "prdq_t" 
                     LET g_wc2_table3 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "prdo_t" 
                     LET g_wc2_table4 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "prdm_t" 
                     LET g_wc2_table5 = la_wc[li_idx].wc
 
 
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
 
   IF g_wc2_table5 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table5
   END IF
 
 
 
 
   
   #add-point:cs段結束前 name="cs.after_construct"
   IF g_wc2_table6 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table6
   END IF
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aprm211.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION aprm211_filter()
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
               DISPLAY aprm211_filter_parser('prdlunit') TO s_browse[1].b_prdlunit
            DISPLAY aprm211_filter_parser('prdl001') TO s_browse[1].b_prdl001
            DISPLAY aprm211_filter_parser('prdl002') TO s_browse[1].b_prdl002
            DISPLAY aprm211_filter_parser('prdl006') TO s_browse[1].b_prdl006
            DISPLAY aprm211_filter_parser('prdl007') TO s_browse[1].b_prdl007
            DISPLAY aprm211_filter_parser('prdl027') TO s_browse[1].b_prdl027
      
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
 
      CALL aprm211_filter_show('prdlunit')
   CALL aprm211_filter_show('prdl001')
   CALL aprm211_filter_show('prdl002')
   CALL aprm211_filter_show('prdl006')
   CALL aprm211_filter_show('prdl007')
   CALL aprm211_filter_show('prdl027')
 
END FUNCTION
 
{</section>}
 
{<section id="aprm211.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aprm211_filter_parser(ps_field)
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
 
{<section id="aprm211.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aprm211_filter_show(ps_field)
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
   LET ls_condition = aprm211_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aprm211.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aprm211_query()
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
   CALL g_prdp_d.clear()
   CALL g_prdp2_d.clear()
   CALL g_prdp3_d.clear()
   CALL g_prdp4_d.clear()
   CALL g_prdp5_d.clear()
 
   
   #add-point:query段other name="query.other"
   CALL g_prdp6_d.clear()
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL aprm211_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aprm211_browser_fill("")
      CALL aprm211_fetch("")
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
   LET g_detail_idx_list[5] = 1
 
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
      CALL aprm211_filter_show('prdlunit')
   CALL aprm211_filter_show('prdl001')
   CALL aprm211_filter_show('prdl002')
   CALL aprm211_filter_show('prdl006')
   CALL aprm211_filter_show('prdl007')
   CALL aprm211_filter_show('prdl027')
   CALL aprm211_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL aprm211_fetch("F") 
      #顯示單身筆數
      CALL aprm211_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aprm211.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aprm211_fetch(p_flag)
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
   EXECUTE aprm211_master_referesh USING g_prdl_m.prdl001 INTO g_prdl_m.prdlunit,g_prdl_m.prdl001,g_prdl_m.prdl002, 
       g_prdl_m.prdl006,g_prdl_m.prdl007,g_prdl_m.prdl027,g_prdl_m.prdl099,g_prdl_m.prdl100,g_prdl_m.prdlstus, 
       g_prdl_m.prdl010,g_prdl_m.prdl011,g_prdl_m.prdl012,g_prdl_m.prdl013,g_prdl_m.prdl038,g_prdl_m.prdl024, 
       g_prdl_m.prdl025,g_prdl_m.prdl026,g_prdl_m.prdl098,g_prdl_m.prdl037,g_prdl_m.prdl034,g_prdl_m.prdl042, 
       g_prdl_m.prdl004,g_prdl_m.prdl005,g_prdl_m.prdl003,g_prdl_m.prdl033,g_prdl_m.prdl008,g_prdl_m.prdl009, 
       g_prdl_m.prdlsite,g_prdl_m.prdlcrtid,g_prdl_m.prdlcrtdp,g_prdl_m.prdlcrtdt,g_prdl_m.prdlownid, 
       g_prdl_m.prdlowndp,g_prdl_m.prdlmodid,g_prdl_m.prdlmoddt,g_prdl_m.prdlcnfid,g_prdl_m.prdlcnfdt, 
       g_prdl_m.prdlunit_desc,g_prdl_m.prdl006_desc,g_prdl_m.prdl007_desc,g_prdl_m.prdl004_desc,g_prdl_m.prdl005_desc, 
       g_prdl_m.prdl033_desc,g_prdl_m.prdl008_desc,g_prdl_m.prdl009_desc,g_prdl_m.prdlcrtid_desc,g_prdl_m.prdlcrtdp_desc, 
       g_prdl_m.prdlownid_desc,g_prdl_m.prdlowndp_desc,g_prdl_m.prdlmodid_desc,g_prdl_m.prdlcnfid_desc 
 
   
   #遮罩相關處理
   LET g_prdl_m_mask_o.* =  g_prdl_m.*
   CALL aprm211_prdl_t_mask()
   LET g_prdl_m_mask_n.* =  g_prdl_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aprm211_set_act_visible()   
   CALL aprm211_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
#   IF g_prdl_m.prdlstus = 'N' THEN
#      CALL cl_set_act_visible("modify,modify_detail,delete", TRUE)
#   ELSE
#      CALL cl_set_act_visible("modify,modify_detail,delete", FALSE)
#   END IF
   IF g_prdl_m.prdl026 <> '4' THEN
      CALL cl_set_comp_visible("page_2", FALSE)
   ELSE
      CALL cl_set_comp_visible("page_2", TRUE)
   END IF
   CALL cl_set_act_visible("statechange", FALSE)
   IF g_prdl_m.prdl099 = 'Y' THEN
      CALL cl_set_act_visible("release", FALSE)
   ELSE
      CALL cl_set_act_visible("release", TRUE)
   END IF
   CALL aprm211_set_comp_att_text()
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
 
   #end add-point
   
   #保存單頭舊值
   LET g_prdl_m_t.* = g_prdl_m.*
   LET g_prdl_m_o.* = g_prdl_m.*
   
   LET g_data_owner = g_prdl_m.prdlownid      
   LET g_data_dept  = g_prdl_m.prdlowndp
   
   #重新顯示   
   CALL aprm211_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="aprm211.insert" >}
#+ 資料新增
PRIVATE FUNCTION aprm211_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_prdp_d.clear()   
   CALL g_prdp2_d.clear()  
   CALL g_prdp3_d.clear()  
   CALL g_prdp4_d.clear()  
   CALL g_prdp5_d.clear()  
 
 
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
            LET g_prdl_m.prdlstus = "N"
      LET g_prdl_m.prdl010 = "N"
      LET g_prdl_m.prdl011 = "N"
      LET g_prdl_m.prdl012 = "N"
      LET g_prdl_m.prdl013 = "N"
      LET g_prdl_m.prdl038 = "N"
      LET g_prdl_m.prdl024 = "2"
      LET g_prdl_m.prdl025 = "1"
      LET g_prdl_m.prdl026 = "3"
      LET g_prdl_m.prdl037 = "0"
      LET g_prdl_m.prdl034 = "N"
      LET g_prdl_m.prdb005_1 = "0"
      LET g_prdl_m.prdb005_2 = "0"
 
  
      #add-point:單頭預設值 name="insert.default"
      LET g_prdl_m.prdlunit = g_site
      LET g_prdl_m.prdlsite = g_site
      LET g_prdl_m.prdl003 = '1'
      LET g_prdl_m.prdl004 = g_user
      LET g_prdl_m.prdl005 = g_dept
      LET g_prdl_m.prdl002 = 1
      LET g_prdl_m.prdl098 = '1'
      LET g_prdl_m.prdo005_1 = '00:00:00'
      LET g_prdl_m.prdo006_1 = '23:59:59'
      CALL aprm211_desc()
      CALL aprm211_set_comp_visible()
      LET g_prdl_m_t.* = g_prdl_m.*
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
 
 
 
    
      CALL aprm211_input("a")
      
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
         INITIALIZE g_prdp_d TO NULL
         INITIALIZE g_prdp2_d TO NULL
         INITIALIZE g_prdp3_d TO NULL
         INITIALIZE g_prdp4_d TO NULL
         INITIALIZE g_prdp5_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL aprm211_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_prdp_d.clear()
      #CALL g_prdp2_d.clear()
      #CALL g_prdp3_d.clear()
      #CALL g_prdp4_d.clear()
      #CALL g_prdp5_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aprm211_set_act_visible()   
   CALL aprm211_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_prdl001_t = g_prdl_m.prdl001
 
   
   #組合新增資料的條件
   LET g_add_browse = " prdlent = " ||g_enterprise|| " AND",
                      " prdl001 = '", g_prdl_m.prdl001, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aprm211_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE aprm211_cl
   
   CALL aprm211_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aprm211_master_referesh USING g_prdl_m.prdl001 INTO g_prdl_m.prdlunit,g_prdl_m.prdl001,g_prdl_m.prdl002, 
       g_prdl_m.prdl006,g_prdl_m.prdl007,g_prdl_m.prdl027,g_prdl_m.prdl099,g_prdl_m.prdl100,g_prdl_m.prdlstus, 
       g_prdl_m.prdl010,g_prdl_m.prdl011,g_prdl_m.prdl012,g_prdl_m.prdl013,g_prdl_m.prdl038,g_prdl_m.prdl024, 
       g_prdl_m.prdl025,g_prdl_m.prdl026,g_prdl_m.prdl098,g_prdl_m.prdl037,g_prdl_m.prdl034,g_prdl_m.prdl042, 
       g_prdl_m.prdl004,g_prdl_m.prdl005,g_prdl_m.prdl003,g_prdl_m.prdl033,g_prdl_m.prdl008,g_prdl_m.prdl009, 
       g_prdl_m.prdlsite,g_prdl_m.prdlcrtid,g_prdl_m.prdlcrtdp,g_prdl_m.prdlcrtdt,g_prdl_m.prdlownid, 
       g_prdl_m.prdlowndp,g_prdl_m.prdlmodid,g_prdl_m.prdlmoddt,g_prdl_m.prdlcnfid,g_prdl_m.prdlcnfdt, 
       g_prdl_m.prdlunit_desc,g_prdl_m.prdl006_desc,g_prdl_m.prdl007_desc,g_prdl_m.prdl004_desc,g_prdl_m.prdl005_desc, 
       g_prdl_m.prdl033_desc,g_prdl_m.prdl008_desc,g_prdl_m.prdl009_desc,g_prdl_m.prdlcrtid_desc,g_prdl_m.prdlcrtdp_desc, 
       g_prdl_m.prdlownid_desc,g_prdl_m.prdlowndp_desc,g_prdl_m.prdlmodid_desc,g_prdl_m.prdlcnfid_desc 
 
   
   
   #遮罩相關處理
   LET g_prdl_m_mask_o.* =  g_prdl_m.*
   CALL aprm211_prdl_t_mask()
   LET g_prdl_m_mask_n.* =  g_prdl_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_prdl_m.prdlunit,g_prdl_m.prdlunit_desc,g_prdl_m.prdl001,g_prdl_m.prdl002,g_prdl_m.prdll003, 
       g_prdl_m.prdl006,g_prdl_m.prdl006_desc,g_prdl_m.prdl007,g_prdl_m.prdl007_desc,g_prdl_m.prdl027, 
       g_prdl_m.prdl099,g_prdl_m.prdl100,g_prdl_m.prdlstus,g_prdl_m.prdl010,g_prdl_m.prdl011,g_prdl_m.prdl012, 
       g_prdl_m.prdl013,g_prdl_m.prdl038,g_prdl_m.prdl024,g_prdl_m.prdl025,g_prdl_m.prdl026,g_prdl_m.l_prdo003_1, 
       g_prdl_m.l_prdo004_1,g_prdl_m.prdl098,g_prdl_m.prdl037,g_prdl_m.prdl034,g_prdl_m.prdl042,g_prdl_m.prdl004, 
       g_prdl_m.prdl004_desc,g_prdl_m.prdl005,g_prdl_m.prdl005_desc,g_prdl_m.prdb005_1,g_prdl_m.prdo005_1, 
       g_prdl_m.prdo006_1,g_prdl_m.prdl003,g_prdl_m.prdl033,g_prdl_m.prdl033_desc,g_prdl_m.prdl008,g_prdl_m.prdl008_desc, 
       g_prdl_m.prdl009,g_prdl_m.prdl009_desc,g_prdl_m.prdb005_2,g_prdl_m.prdo007_1,g_prdl_m.prdo008_1, 
       g_prdl_m.prdlsite,g_prdl_m.prdlcrtid,g_prdl_m.prdlcrtid_desc,g_prdl_m.prdlcrtdp,g_prdl_m.prdlcrtdp_desc, 
       g_prdl_m.prdlcrtdt,g_prdl_m.prdlownid,g_prdl_m.prdlownid_desc,g_prdl_m.prdlowndp,g_prdl_m.prdlowndp_desc, 
       g_prdl_m.prdlmodid,g_prdl_m.prdlmodid_desc,g_prdl_m.prdlmoddt,g_prdl_m.prdlcnfid,g_prdl_m.prdlcnfid_desc, 
       g_prdl_m.prdlcnfdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_prdl_m.prdlownid      
   LET g_data_dept  = g_prdl_m.prdlowndp
   
   #功能已完成,通報訊息中心
   CALL aprm211_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aprm211.modify" >}
#+ 資料修改
PRIVATE FUNCTION aprm211_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
   DEFINE l_wc2_table2   STRING
 
   DEFINE l_wc2_table3   STRING
 
   DEFINE l_wc2_table4   STRING
 
   DEFINE l_wc2_table5   STRING
 
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
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
   
   OPEN aprm211_cl USING g_enterprise,g_prdl_m.prdl001
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aprm211_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aprm211_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aprm211_master_referesh USING g_prdl_m.prdl001 INTO g_prdl_m.prdlunit,g_prdl_m.prdl001,g_prdl_m.prdl002, 
       g_prdl_m.prdl006,g_prdl_m.prdl007,g_prdl_m.prdl027,g_prdl_m.prdl099,g_prdl_m.prdl100,g_prdl_m.prdlstus, 
       g_prdl_m.prdl010,g_prdl_m.prdl011,g_prdl_m.prdl012,g_prdl_m.prdl013,g_prdl_m.prdl038,g_prdl_m.prdl024, 
       g_prdl_m.prdl025,g_prdl_m.prdl026,g_prdl_m.prdl098,g_prdl_m.prdl037,g_prdl_m.prdl034,g_prdl_m.prdl042, 
       g_prdl_m.prdl004,g_prdl_m.prdl005,g_prdl_m.prdl003,g_prdl_m.prdl033,g_prdl_m.prdl008,g_prdl_m.prdl009, 
       g_prdl_m.prdlsite,g_prdl_m.prdlcrtid,g_prdl_m.prdlcrtdp,g_prdl_m.prdlcrtdt,g_prdl_m.prdlownid, 
       g_prdl_m.prdlowndp,g_prdl_m.prdlmodid,g_prdl_m.prdlmoddt,g_prdl_m.prdlcnfid,g_prdl_m.prdlcnfdt, 
       g_prdl_m.prdlunit_desc,g_prdl_m.prdl006_desc,g_prdl_m.prdl007_desc,g_prdl_m.prdl004_desc,g_prdl_m.prdl005_desc, 
       g_prdl_m.prdl033_desc,g_prdl_m.prdl008_desc,g_prdl_m.prdl009_desc,g_prdl_m.prdlcrtid_desc,g_prdl_m.prdlcrtdp_desc, 
       g_prdl_m.prdlownid_desc,g_prdl_m.prdlowndp_desc,g_prdl_m.prdlmodid_desc,g_prdl_m.prdlcnfid_desc 
 
   
   #檢查是否允許此動作
   IF NOT aprm211_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_prdl_m_mask_o.* =  g_prdl_m.*
   CALL aprm211_prdl_t_mask()
   LET g_prdl_m_mask_n.* =  g_prdl_m.*
   
   
   
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
 
   #LET l_wc2_table5 = g_wc2_table5
   #LET l_wc2_table5 = " 1=1"
 
 
 
   
   CALL aprm211_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
   #LET  g_wc2_table3 = l_wc2_table3 
 
   #LET  g_wc2_table4 = l_wc2_table4 
 
   #LET  g_wc2_table5 = l_wc2_table5 
 
 
 
    
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
      CALL aprm211_input("u")
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
            CALL aprm211_show()
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
         UPDATE prdp_t SET prdp001 = g_prdl_m.prdl001
 
          WHERE prdpent = g_enterprise AND prdp001 = g_prdl_m_t.prdl001
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "prdp_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "prdp_t:",SQLERRMESSAGE 
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
         
         UPDATE prdr_t
            SET prdr001 = g_prdl_m.prdl001
 
          WHERE prdrent = g_enterprise AND
                prdr001 = g_prdl001_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
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
         #add-point:單身fk修改後 name="modify.body.a_fk_update2"
         
         #end add-point
 
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update3"
         
         #end add-point
         
         UPDATE prdq_t
            SET prdq001 = g_prdl_m.prdl001
 
          WHERE prdqent = g_enterprise AND
                prdq001 = g_prdl001_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update3"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "prdq_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "prdq_t:",SQLERRMESSAGE 
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
         
         UPDATE prdo_t
            SET prdo001 = g_prdl_m.prdl001
 
          WHERE prdoent = g_enterprise AND
                prdo001 = g_prdl001_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update4"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "prdo_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "prdo_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update4"
         
         #end add-point
 
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update5"
         
         #end add-point
         
         UPDATE prdm_t
            SET prdm001 = g_prdl_m.prdl001
 
          WHERE prdment = g_enterprise AND
                prdm001 = g_prdl001_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update5"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "prdm_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "prdm_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update5"
         
         #end add-point
 
 
         
 
         
         #UPDATE 多語言table key值
         
         
         
         
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aprm211_set_act_visible()   
   CALL aprm211_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " prdlent = " ||g_enterprise|| " AND",
                      " prdl001 = '", g_prdl_m.prdl001, "' "
 
   #填到對應位置
   CALL aprm211_browser_fill("")
 
   CLOSE aprm211_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aprm211_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="aprm211.input" >}
#+ 資料輸入
PRIVATE FUNCTION aprm211_input(p_cmd)
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
   DEFINE  l_prdl001             LIKE prdl_t.prdl001
   DEFINE  l_n1                  LIKE type_t.num5
   DEFINE  l_ooia002             LIKE ooia_t.ooia002
   DEFINE  l_time                DATETIME YEAR TO SECOND
   DEFINE  l_prdl002             LIKE type_t.num5
   DEFINE  l_prdr004             LIKE prdr_t.prdr004
   DEFINE  l_prdr006             LIKE prdr_t.prdr006    #160819-00054#16 161013 by lori add
   DEFINE  l_where               STRING                 #160819-00054#16 161013 by lori add
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
       g_prdl_m.prdl099,g_prdl_m.prdl100,g_prdl_m.prdlstus,g_prdl_m.prdl010,g_prdl_m.prdl011,g_prdl_m.prdl012, 
       g_prdl_m.prdl013,g_prdl_m.prdl038,g_prdl_m.prdl024,g_prdl_m.prdl025,g_prdl_m.prdl026,g_prdl_m.l_prdo003_1, 
       g_prdl_m.l_prdo004_1,g_prdl_m.prdl098,g_prdl_m.prdl037,g_prdl_m.prdl034,g_prdl_m.prdl042,g_prdl_m.prdl004, 
       g_prdl_m.prdl004_desc,g_prdl_m.prdl005,g_prdl_m.prdl005_desc,g_prdl_m.prdb005_1,g_prdl_m.prdo005_1, 
       g_prdl_m.prdo006_1,g_prdl_m.prdl003,g_prdl_m.prdl033,g_prdl_m.prdl033_desc,g_prdl_m.prdl008,g_prdl_m.prdl008_desc, 
       g_prdl_m.prdl009,g_prdl_m.prdl009_desc,g_prdl_m.prdb005_2,g_prdl_m.prdo007_1,g_prdl_m.prdo008_1, 
       g_prdl_m.prdlsite,g_prdl_m.prdlcrtid,g_prdl_m.prdlcrtid_desc,g_prdl_m.prdlcrtdp,g_prdl_m.prdlcrtdp_desc, 
       g_prdl_m.prdlcrtdt,g_prdl_m.prdlownid,g_prdl_m.prdlownid_desc,g_prdl_m.prdlowndp,g_prdl_m.prdlowndp_desc, 
       g_prdl_m.prdlmodid,g_prdl_m.prdlmodid_desc,g_prdl_m.prdlmoddt,g_prdl_m.prdlcnfid,g_prdl_m.prdlcnfid_desc, 
       g_prdl_m.prdlcnfdt
   
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
   LET g_forupd_sql = "SELECT prdp002,prdpstus,prdp003,prdp004,prdpsite,prdpunit FROM prdp_t WHERE prdpent=?  
       AND prdp001=? AND prdp002=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aprm211_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point    
   LET g_forupd_sql = "SELECT prdrstus,prdr002,prdr011,prdr003,prdr004,prdr005,prdr006,prdr007,prdrsite, 
       prdrunit,prdr010 FROM prdr_t WHERE prdrent=? AND prdr001=? AND prdr002=? AND prdr003=? AND prdr004=?  
       FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aprm211_bcl2 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql3"
   
   #end add-point    
   LET g_forupd_sql = "SELECT prdqstus,prdq003,prdq004,prdq002,prdqsite,prdqunit FROM prdq_t WHERE prdqent=?  
       AND prdq001=? AND prdq002=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql3"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aprm211_bcl3 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql4"
   
   #end add-point    
   LET g_forupd_sql = "SELECT prdostus,prdo002,prdo003,prdo004,prdo005,prdo006,prdo007,prdo008,prdosite, 
       prdounit FROM prdo_t WHERE prdoent=? AND prdo001=? AND prdo002=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql4"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aprm211_bcl4 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql5"
   
   #end add-point    
   LET g_forupd_sql = "SELECT prdmstus,prdm004,prdm002,prdm003,prdm005,prdmsite,prdmunit FROM prdm_t  
       WHERE prdment=? AND prdm001=? AND prdm002=? AND prdm004=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql5"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aprm211_bcl5 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL aprm211_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   CALL aprm211_set_no_required(p_cmd)
   CALL aprm211_set_required(p_cmd) 
   #end add-point
   CALL aprm211_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_prdl_m.prdlunit,g_prdl_m.prdl001,g_prdl_m.prdl002,g_prdl_m.prdll003,g_prdl_m.prdl006, 
       g_prdl_m.prdl007,g_prdl_m.prdl027,g_prdl_m.prdl099,g_prdl_m.prdl100,g_prdl_m.prdlstus,g_prdl_m.prdl010, 
       g_prdl_m.prdl011,g_prdl_m.prdl012,g_prdl_m.prdl013,g_prdl_m.prdl038,g_prdl_m.prdl024,g_prdl_m.prdl025, 
       g_prdl_m.prdl026,g_prdl_m.l_prdo003_1,g_prdl_m.l_prdo004_1,g_prdl_m.prdl098,g_prdl_m.prdl037, 
       g_prdl_m.prdl034,g_prdl_m.prdl042,g_prdl_m.prdl004,g_prdl_m.prdl005,g_prdl_m.prdb005_1,g_prdl_m.prdo005_1, 
       g_prdl_m.prdo006_1,g_prdl_m.prdl003,g_prdl_m.prdl033,g_prdl_m.prdl008,g_prdl_m.prdl009,g_prdl_m.prdb005_2, 
       g_prdl_m.prdo007_1,g_prdl_m.prdo008_1,g_prdl_m.prdlsite
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   LET g_errshow = 1
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="aprm211.input.head" >}
      #單頭段
      INPUT BY NAME g_prdl_m.prdlunit,g_prdl_m.prdl001,g_prdl_m.prdl002,g_prdl_m.prdll003,g_prdl_m.prdl006, 
          g_prdl_m.prdl007,g_prdl_m.prdl027,g_prdl_m.prdl099,g_prdl_m.prdl100,g_prdl_m.prdlstus,g_prdl_m.prdl010, 
          g_prdl_m.prdl011,g_prdl_m.prdl012,g_prdl_m.prdl013,g_prdl_m.prdl038,g_prdl_m.prdl024,g_prdl_m.prdl025, 
          g_prdl_m.prdl026,g_prdl_m.l_prdo003_1,g_prdl_m.l_prdo004_1,g_prdl_m.prdl098,g_prdl_m.prdl037, 
          g_prdl_m.prdl034,g_prdl_m.prdl042,g_prdl_m.prdl004,g_prdl_m.prdl005,g_prdl_m.prdb005_1,g_prdl_m.prdo005_1, 
          g_prdl_m.prdo006_1,g_prdl_m.prdl003,g_prdl_m.prdl033,g_prdl_m.prdl008,g_prdl_m.prdl009,g_prdl_m.prdb005_2, 
          g_prdl_m.prdo007_1,g_prdl_m.prdo008_1,g_prdl_m.prdlsite 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item name="input.master_input.update_item"
 
               #END add-point
            END IF
 
 
 
 
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN aprm211_cl USING g_enterprise,g_prdl_m.prdl001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aprm211_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aprm211_cl
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
            CALL aprm211_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL aprm211_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdlunit
            
            #add-point:AFTER FIELD prdlunit name="input.a.prdlunit"
 
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
#            IF g_prdl_m.prda000 = 'I' AND p_cmd = 'a' THEN
#               LET l_n1 = 0
#               SELECT COUNT(*) INTO l_n1
#                 FROM oofg_t
#                WHERE oofgent = g_enterprise
#                  AND oofg002 = '21'
#                  AND oofgstus = 'Y'
#               IF l_n1 > 0 THEN
#                  CALL s_aooi390('21') RETURNING l_success,l_prdl001
#                  IF l_success THEN
#                     LET g_prdl_m.prdl001 = l_prdl001
#                  END IF 
#                  IF NOT cl_null(g_prdl_m.prdl001) THEN
#                     CALL aprm211_chk_prdl001()
#                     IF NOT cl_null(g_errno) THEN
#                        CALL cl_err(g_prdl_m.prdl001,g_errno,1)
#                        LET g_prdl_m.prdl001 = g_prdl_m_t.prdl001
#                        NEXT FIELD prdl001
#                     END IF
##                     CALL cl_set_comp_entry("prdl001",FALSE)
##                  ELSE
##                     NEXT FIELD prda000
#                  END IF
#               END IF
#            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl001
            
            #add-point:AFTER FIELD prdl001 name="input.a.prdl001"
#            IF NOT cl_null(g_prdl_m.prdl001) THEN
#               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prdl_m.prdl001 != g_prdl_m_t.prdl001 )) THEN 
#                  CALL aprm211_chk_prdl001()
#                  IF NOT cl_null(g_errno) THEN
#                     CALL cl_err(g_prdl_m.prdl001,g_errno,1)
#                     LET g_prdl_m.prdl001 = g_prdl_m_t.prdl001
#                     NEXT FIELD prdl001
#                  END IF
#               END IF
#               IF g_prdl_m.prda000 = 'U' THEN   
#                  SELECT MAX(to_number(prdl002)) +1 INTO l_prdl002
#                       FROM prdl_t
#                      WHERE prdlent = g_enterprise
#                        AND prdl001 = g_prdl_m.prdl001
#                     IF cl_null(l_prdl002) THEN
#                        LET g_prdl_m.prdl002 = 1
#                     ELSE
#                        LET g_prdl_m.prdl002 = l_prdl002
#                     END IF
#               END IF
#            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdl001
            #add-point:ON CHANGE prdl001 name="input.g.prdl001"
            
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
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl010
            #add-point:BEFORE FIELD prdl010 name="input.b.prdl010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl010
            
            #add-point:AFTER FIELD prdl010 name="input.a.prdl010"
#            CALL aprm211_set_comp_visible()
#            IF g_prdl_m.prdl010 = 'Y' THEN
#               DELETE FROM prdr_t WHERE prdrent = g_enterprise AND prdgdocno = g_prdl_m.prdadocno
#               CALL aprm211_b_fill()
#            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdl010
            #add-point:ON CHANGE prdl010 name="input.g.prdl010"
#            CALL aprm211_set_comp_visible()
#            IF g_prdl_m.prdl010 = 'Y' THEN
#               DELETE FROM prdr_t WHERE prdrent = g_enterprise AND prdgdocno = g_prdl_m.prdadocno
#               CALL aprm211_b_fill()
#            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl011
            #add-point:BEFORE FIELD prdl011 name="input.b.prdl011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl011
            
            #add-point:AFTER FIELD prdl011 name="input.a.prdl011"
            CALL aprm211_set_comp_visible()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdl011
            #add-point:ON CHANGE prdl011 name="input.g.prdl011"
            CALL aprm211_set_comp_visible()
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
         BEFORE FIELD prdl013
            #add-point:BEFORE FIELD prdl013 name="input.b.prdl013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl013
            
            #add-point:AFTER FIELD prdl013 name="input.a.prdl013"
            CALL aprm211_set_comp_visible()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdl013
            #add-point:ON CHANGE prdl013 name="input.g.prdl013"
            IF g_prdl_m.prdl013 = 'N' THEN
               LET g_prdl_m.prdo005_1 = '00:00:00'
               LET g_prdl_m.prdo006_1 = '23:59:59'
            END IF
            CALL aprm211_set_comp_visible()
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl038
            #add-point:BEFORE FIELD prdl038 name="input.b.prdl038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl038
            
            #add-point:AFTER FIELD prdl038 name="input.a.prdl038"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdl038
            #add-point:ON CHANGE prdl038 name="input.g.prdl038"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl024
            #add-point:BEFORE FIELD prdl024 name="input.b.prdl024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl024
            
            #add-point:AFTER FIELD prdl024 name="input.a.prdl024"
            IF NOT cl_null(g_prdl_m.prdl024) THEN
               IF g_prdl_m.prdl024 = '2' THEN
                  IF g_prdl_m.prdb005_1 < 0 OR g_prdl_m.prdb005_1 > 100 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apr-00077'
                     LET g_errparam.extend = g_prdl_m.prdb005_1
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_prdl_m.prdl024 = g_prdl_m_t.prdl024
                     NEXT FIELD prdl024
                  END IF
                  IF g_prdl_m.prdb005_2 < 0 OR g_prdl_m.prdb005_2 > 100 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apr-00077'
                     LET g_errparam.extend = g_prdl_m.prdb005_2
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_prdl_m.prdl024 = g_prdl_m_t.prdl024
                     NEXT FIELD prdl024
                  END IF
               END IF
               IF g_prdl_m.prdl024 = '3' THEN
                  IF g_prdl_m.prdb005_1 <= 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apr-00078'
                     LET g_errparam.extend = g_prdl_m.prdb005_1
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_prdl_m.prdl024 = g_prdl_m_t.prdl024
                     NEXT FIELD prdl024
                  END IF
                  IF g_prdl_m.prdb005_2 <= 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apr-00078'
                     LET g_errparam.extend = g_prdl_m.prdb005_2
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_prdl_m.prdl024 = g_prdl_m_t.prdl024
                     NEXT FIELD prdl024
                  END IF
               END IF
            END IF
            CALL aprm211_set_comp_att_text()
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdl024
            #add-point:ON CHANGE prdl024 name="input.g.prdl024"
            CALL aprm211_set_comp_att_text()
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
         BEFORE FIELD prdl026
            #add-point:BEFORE FIELD prdl026 name="input.b.prdl026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl026
            
            #add-point:AFTER FIELD prdl026 name="input.a.prdl026"
#            CALL aprm211_set_entry(p_cmd)
#            CALL aprm211_set_no_entry(p_cmd)
#            CALL aprm211_set_comp_visible()
#            IF g_prdl_m.prdl026 <> '4' THEN
#               CALL cl_set_act_visible("object", FALSE)
#               DELETE FROM prdb_t WHERE prdbent = g_enterprise AND prdbdocno = g_prdl_m.prdadocno
#               DELETE FROM prdc_t WHERE prdcent = g_enterprise AND prdcdocno = g_prdl_m.prdadocno
#            ELSE
#               CALL cl_set_act_visible("object", TRUE)
#            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdl026
            #add-point:ON CHANGE prdl026 name="input.g.prdl026"
#            CALL aprm211_set_entry(p_cmd)
#            CALL aprm211_set_no_entry(p_cmd)
#            CALL aprm211_set_comp_visible()
#            IF g_prdl_m.prdl026 <> '4' THEN
#               CALL cl_set_act_visible("object", FALSE)
#               DELETE FROM prdb_t WHERE prdbent = g_enterprise AND prdbdocno = g_prdl_m.prdadocno
#               DELETE FROM prdc_t WHERE prdcent = g_enterprise AND prdcdocno = g_prdl_m.prdadocno
#            ELSE
#               CALL cl_set_act_visible("object", TRUE)
#            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_prdo003_1
            #add-point:BEFORE FIELD l_prdo003_1 name="input.b.l_prdo003_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_prdo003_1
            
            #add-point:AFTER FIELD l_prdo003_1 name="input.a.l_prdo003_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_prdo003_1
            #add-point:ON CHANGE l_prdo003_1 name="input.g.l_prdo003_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_prdo004_1
            #add-point:BEFORE FIELD l_prdo004_1 name="input.b.l_prdo004_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_prdo004_1
            
            #add-point:AFTER FIELD l_prdo004_1 name="input.a.l_prdo004_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_prdo004_1
            #add-point:ON CHANGE l_prdo004_1 name="input.g.l_prdo004_1"
            
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
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl037
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prdl_m.prdl037,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prdl037
            END IF 
 
 
 
            #add-point:AFTER FIELD prdl037 name="input.a.prdl037"
            IF NOT cl_null(g_prdl_m.prdl037) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl037
            #add-point:BEFORE FIELD prdl037 name="input.b.prdl037"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdl037
            #add-point:ON CHANGE prdl037 name="input.g.prdl037"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl034
            #add-point:BEFORE FIELD prdl034 name="input.b.prdl034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl034
            
            #add-point:AFTER FIELD prdl034 name="input.a.prdl034"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdl034
            #add-point:ON CHANGE prdl034 name="input.g.prdl034"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl042
            #add-point:BEFORE FIELD prdl042 name="input.b.prdl042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl042
            
            #add-point:AFTER FIELD prdl042 name="input.a.prdl042"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdl042
            #add-point:ON CHANGE prdl042 name="input.g.prdl042"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl004
            
            #add-point:AFTER FIELD prdl004 name="input.a.prdl004"
            CALL aprm211_desc()
            IF NOT cl_null(g_prdl_m.prdl004) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗 #160318-00025#31  add
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_prdl_m.prdl004
               LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130" #160318-00025#31  add
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_ooag001") THEN
                  LET g_prdl_m.prdl004 = g_prdl_m_t.prdl004
                  CALL aprm211_desc()
                  NEXT FIELD CURRENT
               END IF
               SELECT ooag003 INTO g_prdl_m.prdl005
                 FROM ooag_t
                WHERE ooagent = g_enterprise
                  AND ooag001 = g_prdl_m.prdl004
               CALL aprm211_desc()
            END IF 
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
            CALL aprm211_desc()
            IF NOT cl_null(g_prdl_m.prdl005) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗 #160318-00025#31  add
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_prdl_m.prdl005
               LET g_chkparam.arg2 = g_today
               LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"#要執行的建議程式待補 #160318-00025#31  add
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_ooeg001") THEN
                  LET g_prdl_m.prdl005 = g_prdl_m_t.prdl005
                  CALL aprm211_desc()
                  NEXT FIELD CURRENT
               END IF
            END IF 
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
         BEFORE FIELD prdb005_1
            #add-point:BEFORE FIELD prdb005_1 name="input.b.prdb005_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdb005_1
            
            #add-point:AFTER FIELD prdb005_1 name="input.a.prdb005_1"
            IF NOT cl_null(g_prdl_m.prdl024) THEN
               IF g_prdl_m.prdl024 = '2' THEN
                  IF g_prdl_m.prdb005_1 < 0 OR g_prdl_m.prdb005_1 > 100 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apr-00077'
                     LET g_errparam.extend = g_prdl_m.prdb005_1
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_prdl_m.prdb005_1 = g_prdl_m_t.prdb005_1
                     NEXT FIELD prdb005_1
                  END IF
               END IF
               IF g_prdl_m.prdl024 = '3' THEN
                  IF g_prdl_m.prdb005_1 <= 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apr-00078'
                     LET g_errparam.extend = g_prdl_m.prdb005_1
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_prdl_m.prdb005_1 = g_prdl_m_t.prdb005_1
                     NEXT FIELD prdb005_1
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdb005_1
            #add-point:ON CHANGE prdb005_1 name="input.g.prdb005_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdo005_1
            #add-point:BEFORE FIELD prdo005_1 name="input.b.prdo005_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdo005_1
            
            #add-point:AFTER FIELD prdo005_1 name="input.a.prdo005_1"
            IF NOT cl_null(g_prdl_m.prdo005_1) AND NOT cl_null(g_prdl_m.prdo006_1) THEN
               IF g_prdl_m.prdo005_1 > g_prdl_m.prdo006_1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apr-00091'
                  LET g_errparam.extend = g_prdl_m.prdo005_1
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_prdl_m.prdo005_1 = g_prdl_m_t.prdo005_1
                  NEXT FIELD prdo005_1
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdo005_1
            #add-point:ON CHANGE prdo005_1 name="input.g.prdo005_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdo006_1
            #add-point:BEFORE FIELD prdo006_1 name="input.b.prdo006_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdo006_1
            
            #add-point:AFTER FIELD prdo006_1 name="input.a.prdo006_1"
            IF NOT cl_null(g_prdl_m.prdo005_1) AND NOT cl_null(g_prdl_m.prdo006_1) THEN
               IF g_prdl_m.prdo005_1 > g_prdl_m.prdo006_1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apr-00091'
                  LET g_errparam.extend = g_prdl_m.prdo006_1
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_prdl_m.prdo006_1 = g_prdl_m_t.prdo006_1
                  NEXT FIELD prdo006_1
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdo006_1
            #add-point:ON CHANGE prdo006_1 name="input.g.prdo006_1"
            
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
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl033
            
            #add-point:AFTER FIELD prdl033 name="input.a.prdl033"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prdl_m.prdl033
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2135' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prdl_m.prdl033_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prdl_m.prdl033_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl033
            #add-point:BEFORE FIELD prdl033 name="input.b.prdl033"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdl033
            #add-point:ON CHANGE prdl033 name="input.g.prdl033"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl008
            
            #add-point:AFTER FIELD prdl008 name="input.a.prdl008"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prdl_m.prdl008
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND '2100'=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
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
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND '2101'=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
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
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdb005_2
            #add-point:BEFORE FIELD prdb005_2 name="input.b.prdb005_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdb005_2
            
            #add-point:AFTER FIELD prdb005_2 name="input.a.prdb005_2"
            IF NOT cl_null(g_prdl_m.prdl024) THEN
               IF g_prdl_m.prdl024 = '2' THEN
                  IF g_prdl_m.prdb005_2 < 0 OR g_prdl_m.prdb005_2 > 100 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apr-00077'
                     LET g_errparam.extend = g_prdl_m.prdb005_2
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_prdl_m.prdb005_2 = g_prdl_m_t.prdb005_2
                     NEXT FIELD prdb005_2
                  END IF
               END IF
               IF g_prdl_m.prdl024 = '3' THEN
                  IF g_prdl_m.prdb005_2 <= 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apr-00078'
                     LET g_errparam.extend = g_prdl_m.prdb005_2
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_prdl_m.prdb005_2 = g_prdl_m_t.prdb005_2
                     NEXT FIELD prdb005_2
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdb005_2
            #add-point:ON CHANGE prdb005_2 name="input.g.prdb005_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdo007_1
            #add-point:BEFORE FIELD prdo007_1 name="input.b.prdo007_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdo007_1
            
            #add-point:AFTER FIELD prdo007_1 name="input.a.prdo007_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdo007_1
            #add-point:ON CHANGE prdo007_1 name="input.g.prdo007_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdo008_1
            #add-point:BEFORE FIELD prdo008_1 name="input.b.prdo008_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdo008_1
            
            #add-point:AFTER FIELD prdo008_1 name="input.a.prdo008_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdo008_1
            #add-point:ON CHANGE prdo008_1 name="input.g.prdo008_1"
            
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
 
 
 #欄位檢查
                  #Ctrlp:input.c.prdlunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdlunit
            #add-point:ON ACTION controlp INFIELD prdlunit name="input.c.prdlunit"
            
            #END add-point
 
 
         #Ctrlp:input.c.prdl001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl001
            #add-point:ON ACTION controlp INFIELD prdl001 name="input.c.prdl001"
 
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
            LET g_qryparam.arg1 = '1'
            CALL q_prcf001()                                #呼叫開窗

            LET g_prdl_m.prdl006 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_prdl_m.prdl006 TO prdl006              #顯示到畫面上
            CALL aprm211_desc()
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
            LET g_qryparam.arg1 = '1'
            CALL q_prcd001_1()                                #呼叫開窗

            LET g_prdl_m.prdl007 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_prdl_m.prdl007 TO prdl007              #顯示到畫面上
            CALL aprm211_desc()
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
 
 
         #Ctrlp:input.c.prdl010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl010
            #add-point:ON ACTION controlp INFIELD prdl010 name="input.c.prdl010"
            
            #END add-point
 
 
         #Ctrlp:input.c.prdl011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl011
            #add-point:ON ACTION controlp INFIELD prdl011 name="input.c.prdl011"
            
            #END add-point
 
 
         #Ctrlp:input.c.prdl012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl012
            #add-point:ON ACTION controlp INFIELD prdl012 name="input.c.prdl012"
            
            #END add-point
 
 
         #Ctrlp:input.c.prdl013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl013
            #add-point:ON ACTION controlp INFIELD prdl013 name="input.c.prdl013"
            
            #END add-point
 
 
         #Ctrlp:input.c.prdl038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl038
            #add-point:ON ACTION controlp INFIELD prdl038 name="input.c.prdl038"
            
            #END add-point
 
 
         #Ctrlp:input.c.prdl024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl024
            #add-point:ON ACTION controlp INFIELD prdl024 name="input.c.prdl024"
            
            #END add-point
 
 
         #Ctrlp:input.c.prdl025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl025
            #add-point:ON ACTION controlp INFIELD prdl025 name="input.c.prdl025"
            
            #END add-point
 
 
         #Ctrlp:input.c.prdl026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl026
            #add-point:ON ACTION controlp INFIELD prdl026 name="input.c.prdl026"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_prdo003_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_prdo003_1
            #add-point:ON ACTION controlp INFIELD l_prdo003_1 name="input.c.l_prdo003_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_prdo004_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_prdo004_1
            #add-point:ON ACTION controlp INFIELD l_prdo004_1 name="input.c.l_prdo004_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.prdl098
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl098
            #add-point:ON ACTION controlp INFIELD prdl098 name="input.c.prdl098"
            
            #END add-point
 
 
         #Ctrlp:input.c.prdl037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl037
            #add-point:ON ACTION controlp INFIELD prdl037 name="input.c.prdl037"
            
            #END add-point
 
 
         #Ctrlp:input.c.prdl034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl034
            #add-point:ON ACTION controlp INFIELD prdl034 name="input.c.prdl034"
            
            #END add-point
 
 
         #Ctrlp:input.c.prdl042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl042
            #add-point:ON ACTION controlp INFIELD prdl042 name="input.c.prdl042"
            
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

            CALL q_ooag001()                                #呼叫開窗

            LET g_prdl_m.prdl004 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_prdl_m.prdl004 TO prdl004              #顯示到畫面上
            CALL aprm211_desc()
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

            #給予arg
            LET g_qryparam.arg1 = g_today #

            CALL q_ooeg001()                                #呼叫開窗

            LET g_prdl_m.prdl005 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_prdl_m.prdl005 TO prdl005              #顯示到畫面上
            CALL aprm211_desc()
            NEXT FIELD prdl005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prdb005_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdb005_1
            #add-point:ON ACTION controlp INFIELD prdb005_1 name="input.c.prdb005_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.prdo005_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdo005_1
            #add-point:ON ACTION controlp INFIELD prdo005_1 name="input.c.prdo005_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.prdo006_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdo006_1
            #add-point:ON ACTION controlp INFIELD prdo006_1 name="input.c.prdo006_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.prdl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl003
            #add-point:ON ACTION controlp INFIELD prdl003 name="input.c.prdl003"
            
            #END add-point
 
 
         #Ctrlp:input.c.prdl033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl033
            #add-point:ON ACTION controlp INFIELD prdl033 name="input.c.prdl033"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prdl_m.prdl033             #給予default值
            LET g_qryparam.default2 = "" #g_prdl_m.oocql004 #說明
            #給予arg
            LET g_qryparam.arg1 = "2135" #s


            CALL q_oocq002()                                #呼叫開窗

            LET g_prdl_m.prdl033 = g_qryparam.return1              
            #LET g_prdl_m.oocql004 = g_qryparam.return2 
            DISPLAY g_prdl_m.prdl033 TO prdl033              #
            #DISPLAY g_prdl_m.oocql004 TO oocql004 #說明
            NEXT FIELD prdl033                          #返回原欄位


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
 
 
         #Ctrlp:input.c.prdb005_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdb005_2
            #add-point:ON ACTION controlp INFIELD prdb005_2 name="input.c.prdb005_2"
            
            #END add-point
 
 
         #Ctrlp:input.c.prdo007_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdo007_1
            #add-point:ON ACTION controlp INFIELD prdo007_1 name="input.c.prdo007_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.prdo008_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdo008_1
            #add-point:ON ACTION controlp INFIELD prdo008_1 name="input.c.prdo008_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.prdlsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdlsite
            #add-point:ON ACTION controlp INFIELD prdlsite name="input.c.prdlsite"
            
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
                   prdl100,prdlstus,prdl010,prdl011,prdl012,prdl013,prdl038,prdl024,prdl025,prdl026, 
                   prdl098,prdl037,prdl034,prdl042,prdl004,prdl005,prdl003,prdl033,prdl008,prdl009,prdlsite, 
                   prdlcrtid,prdlcrtdp,prdlcrtdt,prdlownid,prdlowndp,prdlmodid,prdlmoddt,prdlcnfid,prdlcnfdt) 
 
               VALUES (g_enterprise,g_prdl_m.prdlunit,g_prdl_m.prdl001,g_prdl_m.prdl002,g_prdl_m.prdl006, 
                   g_prdl_m.prdl007,g_prdl_m.prdl027,g_prdl_m.prdl099,g_prdl_m.prdl100,g_prdl_m.prdlstus, 
                   g_prdl_m.prdl010,g_prdl_m.prdl011,g_prdl_m.prdl012,g_prdl_m.prdl013,g_prdl_m.prdl038, 
                   g_prdl_m.prdl024,g_prdl_m.prdl025,g_prdl_m.prdl026,g_prdl_m.prdl098,g_prdl_m.prdl037, 
                   g_prdl_m.prdl034,g_prdl_m.prdl042,g_prdl_m.prdl004,g_prdl_m.prdl005,g_prdl_m.prdl003, 
                   g_prdl_m.prdl033,g_prdl_m.prdl008,g_prdl_m.prdl009,g_prdl_m.prdlsite,g_prdl_m.prdlcrtid, 
                   g_prdl_m.prdlcrtdp,g_prdl_m.prdlcrtdt,g_prdl_m.prdlownid,g_prdl_m.prdlowndp,g_prdl_m.prdlmodid, 
                   g_prdl_m.prdlmoddt,g_prdl_m.prdlcnfid,g_prdl_m.prdlcnfdt) 
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
               IF NOT aprm211_master_def() THEN
                  CALL s_transaction_end('N','0')
                  CONTINUE DIALOG
               END IF
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL aprm211_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL aprm211_b_fill()
                  CALL aprm211_b_fill2('0')
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
               CALL aprm211_prdl_t_mask_restore('restore_mask_o')
               
               UPDATE prdl_t SET (prdlunit,prdl001,prdl002,prdl006,prdl007,prdl027,prdl099,prdl100,prdlstus, 
                   prdl010,prdl011,prdl012,prdl013,prdl038,prdl024,prdl025,prdl026,prdl098,prdl037,prdl034, 
                   prdl042,prdl004,prdl005,prdl003,prdl033,prdl008,prdl009,prdlsite,prdlcrtid,prdlcrtdp, 
                   prdlcrtdt,prdlownid,prdlowndp,prdlmodid,prdlmoddt,prdlcnfid,prdlcnfdt) = (g_prdl_m.prdlunit, 
                   g_prdl_m.prdl001,g_prdl_m.prdl002,g_prdl_m.prdl006,g_prdl_m.prdl007,g_prdl_m.prdl027, 
                   g_prdl_m.prdl099,g_prdl_m.prdl100,g_prdl_m.prdlstus,g_prdl_m.prdl010,g_prdl_m.prdl011, 
                   g_prdl_m.prdl012,g_prdl_m.prdl013,g_prdl_m.prdl038,g_prdl_m.prdl024,g_prdl_m.prdl025, 
                   g_prdl_m.prdl026,g_prdl_m.prdl098,g_prdl_m.prdl037,g_prdl_m.prdl034,g_prdl_m.prdl042, 
                   g_prdl_m.prdl004,g_prdl_m.prdl005,g_prdl_m.prdl003,g_prdl_m.prdl033,g_prdl_m.prdl008, 
                   g_prdl_m.prdl009,g_prdl_m.prdlsite,g_prdl_m.prdlcrtid,g_prdl_m.prdlcrtdp,g_prdl_m.prdlcrtdt, 
                   g_prdl_m.prdlownid,g_prdl_m.prdlowndp,g_prdl_m.prdlmodid,g_prdl_m.prdlmoddt,g_prdl_m.prdlcnfid, 
                   g_prdl_m.prdlcnfdt)
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
               IF NOT aprm211_master_upd() THEN
                  CALL s_transaction_end('N','0')
                  CONTINUE DIALOG
               END IF
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
               CALL aprm211_prdl_t_mask_restore('restore_mask_n')
               
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
 
{<section id="aprm211.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_prdp_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_prdp_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aprm211_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_prdp_d.getLength()
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
            OPEN aprm211_cl USING g_enterprise,g_prdl_m.prdl001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aprm211_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aprm211_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_prdp_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_prdp_d[l_ac].prdp002 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_prdp_d_t.* = g_prdp_d[l_ac].*  #BACKUP
               LET g_prdp_d_o.* = g_prdp_d[l_ac].*  #BACKUP
               CALL aprm211_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL aprm211_set_no_entry_b(l_cmd)
               IF NOT aprm211_lock_b("prdp_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aprm211_bcl INTO g_prdp_d[l_ac].prdp002,g_prdp_d[l_ac].prdpstus,g_prdp_d[l_ac].prdp003, 
                      g_prdp_d[l_ac].prdp004,g_prdp_d[l_ac].prdpsite,g_prdp_d[l_ac].prdpunit
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_prdp_d_t.prdp002,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_prdp_d_mask_o[l_ac].* =  g_prdp_d[l_ac].*
                  CALL aprm211_prdp_t_mask()
                  LET g_prdp_d_mask_n[l_ac].* =  g_prdp_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aprm211_show()
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
            INITIALIZE g_prdp_d[l_ac].* TO NULL 
            INITIALIZE g_prdp_d_t.* TO NULL 
            INITIALIZE g_prdp_d_o.* TO NULL 
            #公用欄位給值(單身)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_prdp_d[l_ac].prdpstus = 'N'
 
 
 
            #自定義預設值
            
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_prdp_d_t.* = g_prdp_d[l_ac].*     #新輸入資料
            LET g_prdp_d_o.* = g_prdp_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aprm211_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL aprm211_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_prdp_d[li_reproduce_target].* = g_prdp_d[li_reproduce].*
 
               LET g_prdp_d[li_reproduce_target].prdp002 = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
#            SELECT MAX(prdp002)+1 INTO g_prdp_d[l_ac].prdp002
#              FROM prdp_t
#             WHERE prdpent = g_enterprise
#               AND prdedocno = g_prdl_m.prdadocno
#            IF cl_null(g_prdp_d[l_ac].prdp002) THEN
#               LET g_prdp_d[l_ac].prdp002 = 1
#            END IF
#            LET g_prdp_d[l_ac].prdp001 = g_prdl_m.prdl001
#            LET g_prdp_d[l_ac].prdpunit = g_site
#            LET g_prdp_d[l_ac].prdpsite = g_site
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
            SELECT COUNT(1) INTO l_count FROM prdp_t 
             WHERE prdpent = g_enterprise AND prdp001 = g_prdl_m.prdl001
 
               AND prdp002 = g_prdp_d[l_ac].prdp002
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prdl_m.prdl001
               LET gs_keys[2] = g_prdp_d[g_detail_idx].prdp002
               CALL aprm211_insert_b('prdp_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_prdp_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "prdp_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aprm211_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
#               IF p_cmd = 'u' THEN
#                  LET l_time = cl_get_current()
#                  UPDATE prdl_t SET prdlmodid = g_user,
#                                    prdlmoddt = l_time
#                   WHERE prdlent = g_enterprise
#                     AND prdadocno = g_prdl_m.prdadocno
#                  IF SQLCA.SQLcode  THEN
#                     CALL cl_err("upd prdl_t",SQLCA.sqlcode,1)
#                     CALL s_transaction_end('N','0')
#                     CANCEL INSERT
#                  END IF
#               END IF
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
 
               LET gs_keys[gs_keys.getLength()+1] = g_prdp_d_t.prdp002
 
            
               #刪除同層單身
               IF NOT aprm211_delete_b('prdp_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aprm211_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aprm211_key_delete_b(gs_keys,'prdp_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aprm211_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE aprm211_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_prdp_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_prdp_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdp002
            #add-point:BEFORE FIELD prdp002 name="input.b.page1.prdp002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdp002
            
            #add-point:AFTER FIELD prdp002 name="input.a.page1.prdp002"
#            #此段落由子樣板a05產生
#            IF  g_prdl_m.prdadocno IS NOT NULL AND g_prdp_d[g_detail_idx].prdp002 IS NOT NULL THEN 
#               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_prdl_m.prdadocno != g_prdldocno_t OR g_prdp_d[g_detail_idx].prdp002 != g_prdp_d_t.prdp002)) THEN 
#                  IF NOT ap_chk_notDup(g_prdp_d[l_ac].prdp002,"SELECT COUNT(*) FROM prdp_t WHERE "||"prdpent = '" ||g_enterprise|| "' AND "||"prdedocno = '"||g_prdl_m.prdadocno ||"' AND "|| "prdp002 = '"||g_prdp_d[g_detail_idx].prdp002 ||"'",'std-00004',1) THEN 
#                     LET g_prdp_d[l_ac].prdp002 = g_prdp_d_t.prdp002
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdp002
            #add-point:ON CHANGE prdp002 name="input.g.page1.prdp002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdpstus
            #add-point:BEFORE FIELD prdpstus name="input.b.page1.prdpstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdpstus
            
            #add-point:AFTER FIELD prdpstus name="input.a.page1.prdpstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdpstus
            #add-point:ON CHANGE prdpstus name="input.g.page1.prdpstus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdp003
            #add-point:BEFORE FIELD prdp003 name="input.b.page1.prdp003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdp003
            
            #add-point:AFTER FIELD prdp003 name="input.a.page1.prdp003"
            IF NOT cl_null(g_prdp_d[l_ac].prdp003) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND g_prdp_d[l_ac].prdp003 <>　g_prdp_d_t.prdp003) THEN
                  LET g_prdp_d[l_ac].prdp004 = ''
                  LET g_prdp_d[l_ac].prdp004_desc = ''
                  DISPLAY BY NAME g_prdp_d[l_ac].prdp004
                  DISPLAY BY NAME g_prdp_d[l_ac].prdp004_desc
#                  CALL aprm211_chk_prdp004()
#                  IF NOT cl_null(g_errno) THEN
#                     CALL cl_err(g_prdp_d[l_ac].prdp003,g_errno,1)
#                     LET g_prdp_d[l_ac].prdp003 = g_prdp_d_t.prdp003
#                     NEXT FIELD CURRENT
#                  END IF
#                  IF g_prdp_d[l_ac].prdp003 = '2' THEN
#                     INITIALIZE g_chkparam.* TO NULL
#                     LET g_chkparam.arg1 = g_prdp_d[l_ac].prdp004
#                     LET g_chkparam.arg2 = '2'
#                     LET g_chkparam.arg3 = g_site
#                     IF NOT cl_chk_exist("v_ooed004") THEN
#                        LET g_prdp_d[l_ac].prdp003 = g_prdp_d_t.prdp003
#                        NEXT FIELD CURRENT
#                     END IF
#                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdp003
            #add-point:ON CHANGE prdp003 name="input.g.page1.prdp003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdp004
            
            #add-point:AFTER FIELD prdp004 name="input.a.page1.prdp004"
#            CALL aprm211_prdp_desc()
#            IF NOT cl_null(g_prdp_d[l_ac].prdp004) THEN
#               IF l_cmd = 'a' OR (l_cmd = 'u' AND g_prdp_d[l_ac].prdp004 <>　g_prdp_d_t.prdp004) THEN
#                  IF NOT ap_chk_notDup(g_prdp_d[l_ac].prdp004,"SELECT COUNT(*) FROM prdp_t WHERE "||"prdpent = '" ||g_enterprise|| "' AND "||"prdedocno = '"||g_prdl_m.prdadocno ||"'  AND "||"prdp004 = '"||g_prdp_d[l_ac].prdp004 ||"' ",'std-00004',1) THEN
#                     LET g_prdp_d[l_ac].prdp004 = g_prdp_d_t.prdp004
#                     CALL aprm211_prdp_desc()
#                     NEXT FIELD CURRENT
#                  END IF
#                  CALL aprm211_chk_prdp004()
#                  IF NOT cl_null(g_errno) THEN
#                     CALL cl_err(g_prdp_d[l_ac].prdp004,g_errno,1)
#                     LET g_prdp_d[l_ac].prdp004 = g_prdp_d_t.prdp004
#                     CALL aprm211_prdp_desc()
#                     NEXT FIELD CURRENT
#                  END IF
#                  IF g_prdp_d[l_ac].prdp003 = '2' THEN
#                     INITIALIZE g_chkparam.* TO NULL
#                     LET g_chkparam.arg1 = g_prdp_d[l_ac].prdp004
#                     LET g_chkparam.arg2 = '2'
#                     LET g_chkparam.arg3 = g_site
#                     IF NOT cl_chk_exist("v_ooed004") THEN
#                        LET g_prdp_d[l_ac].prdp004 = g_prdp_d_t.prdp004
#                        CALL aprm211_prdp_desc()
#                        NEXT FIELD CURRENT
#                     END IF
#                  END IF
#               END IF
#            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdp004
            #add-point:BEFORE FIELD prdp004 name="input.b.page1.prdp004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdp004
            #add-point:ON CHANGE prdp004 name="input.g.page1.prdp004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdpsite
            #add-point:BEFORE FIELD prdpsite name="input.b.page1.prdpsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdpsite
            
            #add-point:AFTER FIELD prdpsite name="input.a.page1.prdpsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdpsite
            #add-point:ON CHANGE prdpsite name="input.g.page1.prdpsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdpunit
            #add-point:BEFORE FIELD prdpunit name="input.b.page1.prdpunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdpunit
            
            #add-point:AFTER FIELD prdpunit name="input.a.page1.prdpunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdpunit
            #add-point:ON CHANGE prdpunit name="input.g.page1.prdpunit"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.prdp002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdp002
            #add-point:ON ACTION controlp INFIELD prdp002 name="input.c.page1.prdp002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prdpstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdpstus
            #add-point:ON ACTION controlp INFIELD prdpstus name="input.c.page1.prdpstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prdp003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdp003
            #add-point:ON ACTION controlp INFIELD prdp003 name="input.c.page1.prdp003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prdp004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdp004
            #add-point:ON ACTION controlp INFIELD prdp004 name="input.c.page1.prdp004"
                                                                                                                        #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_prdp_d[l_ac].prdp004   #給予default值
            #給予arg
            IF g_prdp_d[l_ac].prdp003 = '1' THEN
               LET g_qryparam.arg1 = '4'
               LET g_qryparam.arg2 = g_site
               LET g_qryparam.arg3 = '8'
               CALL q_rtaa001_5()
            ELSE
               LET g_qryparam.arg1 = g_site
               LET g_qryparam.arg2 = '8'
               CALL q_ooed004()                                #呼叫開窗
            END IF

            LET g_prdp_d[l_ac].prdp004  = g_qryparam.return1   #將開窗取得的值回傳到變數
            DISPLAY g_prdp_d[l_ac].prdp004  TO prdp004         #顯示到畫面上
            CALL aprm211_prdp_desc()
            NEXT FIELD prdp004                                 #返回原欄位                                                  
            #END add-point
 
 
         #Ctrlp:input.c.page1.prdpsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdpsite
            #add-point:ON ACTION controlp INFIELD prdpsite name="input.c.page1.prdpsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prdpunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdpunit
            #add-point:ON ACTION controlp INFIELD prdpunit name="input.c.page1.prdpunit"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_prdp_d[l_ac].* = g_prdp_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aprm211_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_prdp_d[l_ac].prdp002 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_prdp_d[l_ac].* = g_prdp_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
      
               #將遮罩欄位還原
               CALL aprm211_prdp_t_mask_restore('restore_mask_o')
      
               UPDATE prdp_t SET (prdp001,prdp002,prdpstus,prdp003,prdp004,prdpsite,prdpunit) = (g_prdl_m.prdl001, 
                   g_prdp_d[l_ac].prdp002,g_prdp_d[l_ac].prdpstus,g_prdp_d[l_ac].prdp003,g_prdp_d[l_ac].prdp004, 
                   g_prdp_d[l_ac].prdpsite,g_prdp_d[l_ac].prdpunit)
                WHERE prdpent = g_enterprise AND prdp001 = g_prdl_m.prdl001 
 
                  AND prdp002 = g_prdp_d_t.prdp002 #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_prdp_d[l_ac].* = g_prdp_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "prdp_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_prdp_d[l_ac].* = g_prdp_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "prdp_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prdl_m.prdl001
               LET gs_keys_bak[1] = g_prdl001_t
               LET gs_keys[2] = g_prdp_d[g_detail_idx].prdp002
               LET gs_keys_bak[2] = g_prdp_d_t.prdp002
               CALL aprm211_update_b('prdp_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL aprm211_prdp_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_prdp_d[g_detail_idx].prdp002 = g_prdp_d_t.prdp002 
 
                  ) THEN
                  LET gs_keys[01] = g_prdl_m.prdl001
 
                  LET gs_keys[gs_keys.getLength()+1] = g_prdp_d_t.prdp002
 
                  CALL aprm211_key_update_b(gs_keys,'prdp_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_prdl_m),util.JSON.stringify(g_prdp_d_t)
               LET g_log2 = util.JSON.stringify(g_prdl_m),util.JSON.stringify(g_prdp_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
#               IF p_cmd = 'u' THEN
#                  LET l_time = cl_get_current()
#                  UPDATE prdl_t SET prdlmodid = g_user,
#                                    prdlmoddt = l_time
#                   WHERE prdlent = g_enterprise
#                     AND prdadocno = g_prdl_m.prdadocno
#                  IF SQLCA.SQLcode  THEN
#                     CALL cl_err("upd prdl_t",SQLCA.sqlcode,1)
#                     CALL s_transaction_end('N','0')
#                  END IF
#               END IF
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL aprm211_unlock_b("prdp_t","'1'")
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
               LET g_prdp_d[li_reproduce_target].* = g_prdp_d[li_reproduce].*
 
               LET g_prdp_d[li_reproduce_target].prdp002 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_prdp_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_prdp_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_prdp2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body2.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_prdp2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aprm211_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_prdp2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_prdp2_d[l_ac].* TO NULL 
            INITIALIZE g_prdp2_d_t.* TO NULL 
            INITIALIZE g_prdp2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_prdp2_d[l_ac].prdrstus = 'N'
 
 
 
            #自定義預設值(單身2)
                  LET g_prdp2_d[l_ac].prdr003 = "4"
      LET g_prdp2_d[l_ac].prdr007 = "0"
 
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            
            #end add-point
            LET g_prdp2_d_t.* = g_prdp2_d[l_ac].*     #新輸入資料
            LET g_prdp2_d_o.* = g_prdp2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aprm211_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
            
            #end add-point
            CALL aprm211_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_prdp2_d[li_reproduce_target].* = g_prdp2_d[li_reproduce].*
 
               LET g_prdp2_d[li_reproduce_target].prdr002 = NULL
               LET g_prdp2_d[li_reproduce_target].prdr003 = NULL
               LET g_prdp2_d[li_reproduce_target].prdr004 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body2.before_insert"
#            SELECT MAX(prdr002)+1 INTO g_prdp2_d[l_ac].prdr002
#              FROM prdr_t
#             WHERE prdrent = g_enterprise
#               AND prdgdocno = g_prdl_m.prdadocno
#            IF cl_null(g_prdp2_d[l_ac].prdr002) THEN
#               LET g_prdp2_d[l_ac].prdr002 = 1
#            END IF
#            LET g_prdp2_d[l_ac].prdr001 = g_prdl_m.prdl001
#            LET g_prdp2_d[l_ac].prdrunit = g_site
#            LET g_prdp2_d[l_ac].prdrsite = g_site
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
            OPEN aprm211_cl USING g_enterprise,g_prdl_m.prdl001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aprm211_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aprm211_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_prdp2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_prdp2_d[l_ac].prdr002 IS NOT NULL
               AND g_prdp2_d[l_ac].prdr003 IS NOT NULL
               AND g_prdp2_d[l_ac].prdr004 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_prdp2_d_t.* = g_prdp2_d[l_ac].*  #BACKUP
               LET g_prdp2_d_o.* = g_prdp2_d[l_ac].*  #BACKUP
               CALL aprm211_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
               
               #end add-point  
               CALL aprm211_set_no_entry_b(l_cmd)
               IF NOT aprm211_lock_b("prdr_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aprm211_bcl2 INTO g_prdp2_d[l_ac].prdrstus,g_prdp2_d[l_ac].prdr002,g_prdp2_d[l_ac].prdr011, 
                      g_prdp2_d[l_ac].prdr003,g_prdp2_d[l_ac].prdr004,g_prdp2_d[l_ac].prdr005,g_prdp2_d[l_ac].prdr006, 
                      g_prdp2_d[l_ac].prdr007,g_prdp2_d[l_ac].prdrsite,g_prdp2_d[l_ac].prdrunit,g_prdp2_d[l_ac].prdr010 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_prdp2_d_mask_o[l_ac].* =  g_prdp2_d[l_ac].*
                  CALL aprm211_prdr_t_mask()
                  LET g_prdp2_d_mask_n[l_ac].* =  g_prdp2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aprm211_show()
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
               LET gs_keys[01] = g_prdl_m.prdl001
               LET gs_keys[gs_keys.getLength()+1] = g_prdp2_d_t.prdr002
               LET gs_keys[gs_keys.getLength()+1] = g_prdp2_d_t.prdr003
               LET gs_keys[gs_keys.getLength()+1] = g_prdp2_d_t.prdr004
            
               #刪除同層單身
               IF NOT aprm211_delete_b('prdr_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aprm211_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aprm211_key_delete_b(gs_keys,'prdr_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aprm211_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身2刪除中 name="input.body2.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE aprm211_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body2.a_delete"
               
               #end add-point
               LET l_count = g_prdp_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_prdp2_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM prdr_t 
             WHERE prdrent = g_enterprise AND prdr001 = g_prdl_m.prdl001
               AND prdr002 = g_prdp2_d[l_ac].prdr002
               AND prdr003 = g_prdp2_d[l_ac].prdr003
               AND prdr004 = g_prdp2_d[l_ac].prdr004
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prdl_m.prdl001
               LET gs_keys[2] = g_prdp2_d[g_detail_idx].prdr002
               LET gs_keys[3] = g_prdp2_d[g_detail_idx].prdr003
               LET gs_keys[4] = g_prdp2_d[g_detail_idx].prdr004
               CALL aprm211_insert_b('prdr_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_prdp_d[l_ac].* TO NULL
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
               #CALL aprm211_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body2.after_insert"
#               IF p_cmd = 'u' THEN
#                  LET l_time = cl_get_current()
#                  UPDATE prdl_t SET prdlmodid = g_user,
#                                    prdlmoddt = l_time
#                   WHERE prdlent = g_enterprise
#                     AND prdadocno = g_prdl_m.prdadocno
#                  IF SQLCA.SQLcode  THEN
#                     CALL cl_err("upd prdl_t",SQLCA.sqlcode,1)
#                     CALL s_transaction_end('N','0')
#                     CANCEL INSERT
#                  END IF
#               END IF
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_prdp2_d[l_ac].* = g_prdp2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aprm211_bcl2
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
               LET g_prdp2_d[l_ac].* = g_prdp2_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body2.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               #將遮罩欄位還原
               CALL aprm211_prdr_t_mask_restore('restore_mask_o')
                              
               UPDATE prdr_t SET (prdr001,prdrstus,prdr002,prdr011,prdr003,prdr004,prdr005,prdr006,prdr007, 
                   prdrsite,prdrunit,prdr010) = (g_prdl_m.prdl001,g_prdp2_d[l_ac].prdrstus,g_prdp2_d[l_ac].prdr002, 
                   g_prdp2_d[l_ac].prdr011,g_prdp2_d[l_ac].prdr003,g_prdp2_d[l_ac].prdr004,g_prdp2_d[l_ac].prdr005, 
                   g_prdp2_d[l_ac].prdr006,g_prdp2_d[l_ac].prdr007,g_prdp2_d[l_ac].prdrsite,g_prdp2_d[l_ac].prdrunit, 
                   g_prdp2_d[l_ac].prdr010) #自訂欄位頁簽
                WHERE prdrent = g_enterprise AND prdr001 = g_prdl_m.prdl001
                  AND prdr002 = g_prdp2_d_t.prdr002 #項次 
                  AND prdr003 = g_prdp2_d_t.prdr003
                  AND prdr004 = g_prdp2_d_t.prdr004
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_prdp2_d[l_ac].* = g_prdp2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "prdr_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_prdp2_d[l_ac].* = g_prdp2_d_t.*
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
               LET gs_keys[2] = g_prdp2_d[g_detail_idx].prdr002
               LET gs_keys_bak[2] = g_prdp2_d_t.prdr002
               LET gs_keys[3] = g_prdp2_d[g_detail_idx].prdr003
               LET gs_keys_bak[3] = g_prdp2_d_t.prdr003
               LET gs_keys[4] = g_prdp2_d[g_detail_idx].prdr004
               LET gs_keys_bak[4] = g_prdp2_d_t.prdr004
               CALL aprm211_update_b('prdr_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aprm211_prdr_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_prdp2_d[g_detail_idx].prdr002 = g_prdp2_d_t.prdr002 
                  AND g_prdp2_d[g_detail_idx].prdr003 = g_prdp2_d_t.prdr003 
                  AND g_prdp2_d[g_detail_idx].prdr004 = g_prdp2_d_t.prdr004 
                  ) THEN
                  LET gs_keys[01] = g_prdl_m.prdl001
                  LET gs_keys[gs_keys.getLength()+1] = g_prdp2_d_t.prdr002
                  LET gs_keys[gs_keys.getLength()+1] = g_prdp2_d_t.prdr003
                  LET gs_keys[gs_keys.getLength()+1] = g_prdp2_d_t.prdr004
                  CALL aprm211_key_update_b(gs_keys,'prdr_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_prdl_m),util.JSON.stringify(g_prdp2_d_t)
               LET g_log2 = util.JSON.stringify(g_prdl_m),util.JSON.stringify(g_prdp2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"
#               IF p_cmd = 'u' THEN
#                  LET l_time = cl_get_current()
#                  UPDATE prdl_t SET prdlmodid = g_user,
#                                    prdlmoddt = l_time
#                   WHERE prdlent = g_enterprise
#                     AND prdadocno = g_prdl_m.prdadocno
#                  IF SQLCA.SQLcode  THEN
#                     CALL cl_err("upd prdl_t",SQLCA.sqlcode,1)
#                     CALL s_transaction_end('N','0')
#                  END IF
#               END IF
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdrstus
            #add-point:BEFORE FIELD prdrstus name="input.b.page2.prdrstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdrstus
            
            #add-point:AFTER FIELD prdrstus name="input.a.page2.prdrstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdrstus
            #add-point:ON CHANGE prdrstus name="input.g.page2.prdrstus"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdr002
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prdp2_d[l_ac].prdr002,"0","0","","","azz-00079",1) THEN
               NEXT FIELD prdr002
            END IF 
 
 
 
            #add-point:AFTER FIELD prdr002 name="input.a.page2.prdr002"
            #此段落由子樣板a05產生
#            IF g_prdl_m.prdadocno IS NOT NULL AND g_prdp2_d[g_detail_idx].prdr002 IS NOT NULL AND g_prdp2_d[g_detail_idx].prdr003 IS NOT NULL AND g_prdp2_d[g_detail_idx].prdr004 IS NOT NULL THEN 
#               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_prdl_m.prdadocno != g_prdldocno_t OR g_prdp2_d[g_detail_idx].prdr002 != g_prdp2_d_t.prdr002 OR g_prdp2_d[g_detail_idx].prdr003 != g_prdp2_d_t.prdr003 OR g_prdp2_d[g_detail_idx].prdr004 != g_prdp2_d_t.prdr004)) THEN 
#                  IF NOT ap_chk_notDup(g_prdp2_d[l_ac].prdr002,"SELECT COUNT(*) FROM prdr_t WHERE "||"prdrent = '" ||g_enterprise|| "' AND "||"prdgdocno = '"||g_prdl_m.prdadocno ||"' AND "|| "prdr002 = '"||g_prdp2_d[g_detail_idx].prdr002 ||"' AND "|| "prdr003 = '"||g_prdp2_d[g_detail_idx].prdr003 ||"' AND "|| "prdr004 = '"||g_prdp2_d[g_detail_idx].prdr004 ||"' ",'std-00004',1) THEN 
#                     LET g_prdp2_d[l_ac].prdr002 = g_prdp2_d_t.prdr002
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdr002
            #add-point:BEFORE FIELD prdr002 name="input.b.page2.prdr002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdr002
            #add-point:ON CHANGE prdr002 name="input.g.page2.prdr002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdr011
            #add-point:BEFORE FIELD prdr011 name="input.b.page2.prdr011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdr011
            
            #add-point:AFTER FIELD prdr011 name="input.a.page2.prdr011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdr011
            #add-point:ON CHANGE prdr011 name="input.g.page2.prdr011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdr003
            #add-point:BEFORE FIELD prdr003 name="input.b.page2.prdr003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdr003
            
            #add-point:AFTER FIELD prdr003 name="input.a.page2.prdr003"
            #此段落由子樣板a05產生
#            IF g_prdl_m.prdadocno IS NOT NULL AND g_prdp2_d[g_detail_idx].prdr002 IS NOT NULL AND g_prdp2_d[g_detail_idx].prdr003 IS NOT NULL AND g_prdp2_d[g_detail_idx].prdr004 IS NOT NULL THEN 
#               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_prdl_m.prdadocno != g_prdldocno_t OR g_prdp2_d[g_detail_idx].prdr002 != g_prdp2_d_t.prdr002 OR g_prdp2_d[g_detail_idx].prdr003 != g_prdp2_d_t.prdr003 OR g_prdp2_d[g_detail_idx].prdr004 != g_prdp2_d_t.prdr004)) THEN 
#                  IF NOT ap_chk_notDup(g_prdp2_d[l_ac].prdr003,"SELECT COUNT(*) FROM prdr_t WHERE "||"prdrent = '" ||g_enterprise|| "' AND "||"prdgdocno = '"||g_prdl_m.prdadocno ||"' AND "|| "prdr002 = '"||g_prdp2_d[g_detail_idx].prdr002 ||"' AND "|| "prdr003 = '"||g_prdp2_d[g_detail_idx].prdr003 ||"' AND "|| "prdr004 = '"||g_prdp2_d[g_detail_idx].prdr004 ||"' ",'std-00004',1) THEN 
#                     LET g_prdp2_d[l_ac].prdr003 = g_prdp2_d_t.prdr003
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF
#            IF NOT cl_null(g_prdp2_d[l_ac].prdr003) THEN
#               IF l_cmd = 'a' THEN
#                  LET g_prdp2_d[l_ac].prdr004 = ""
#                  DISPLAY BY NAME g_prdp2_d[l_ac].prdr004
#               END IF
#               IF NOT cl_null(g_prdp2_d[l_ac].prdr004) THEN
#                  IF NOT aprm211_chk_prdr004() THEN
#                     LET g_prdp2_d[l_ac].prdr003 = g_prdp2_d_t.prdr003
#                     NEXT FIELD prdr003
#                  END IF
#               END IF   
#            END IF
#            CALL aprm211_set_entry_b(l_cmd)
#            CALL aprm211_set_no_entry_b(l_cmd)

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdr003
            #add-point:ON CHANGE prdr003 name="input.g.page2.prdr003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdr004
            
            #add-point:AFTER FIELD prdr004 name="input.a.page2.prdr004"
            #此段落由子樣板a05產生
#            CALL aprm211_prdr_desc()
#            IF g_prdl_m.prdadocno IS NOT NULL AND g_prdp2_d[g_detail_idx].prdr002 IS NOT NULL AND g_prdp2_d[g_detail_idx].prdr003 IS NOT NULL AND g_prdp2_d[g_detail_idx].prdr004 IS NOT NULL THEN 
#               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_prdl_m.prdadocno != g_prdldocno_t OR g_prdp2_d[g_detail_idx].prdr002 != g_prdp2_d_t.prdr002 OR g_prdp2_d[g_detail_idx].prdr003 != g_prdp2_d_t.prdr003 OR g_prdp2_d[g_detail_idx].prdr004 != g_prdp2_d_t.prdr004)) THEN 
#                  IF NOT ap_chk_notDup(g_prdp2_d[l_ac].prdr004,"SELECT COUNT(*) FROM prdr_t WHERE "||"prdrent = '" ||g_enterprise|| "' AND "||"prdgdocno = '"||g_prdl_m.prdadocno ||"' AND "|| "prdr002 = '"||g_prdp2_d[g_detail_idx].prdr002 ||"' AND "|| "prdr003 = '"||g_prdp2_d[g_detail_idx].prdr003 ||"' AND "|| "prdr004 = '"||g_prdp2_d[g_detail_idx].prdr004 ||"' ",'std-00004',1) THEN 
#                     LET g_prdp2_d[l_ac].prdr004 = g_prdp2_d_t.prdr004
#                     CALL aprm211_prdr_desc()
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF
#            IF NOT cl_null(g_prdp2_d[l_ac].prdr004) THEN
#               IF NOT cl_null(g_prdp2_d[l_ac].prdr003) THEN
#                  IF NOT aprm211_chk_prdr004() THEN
#                     LET g_prdp2_d[l_ac].prdr004 = g_prdp2_d_t.prdr004
#                     CALL aprm211_prdr_desc()
#                     NEXT FIELD CURRENT
#                  END IF
#                  IF g_prdp2_d[l_ac].prdr003 = '4' THEN
#                     CALL aprm211_prdr004_def()
#                  END IF
#               END IF   
#            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdr004
            #add-point:BEFORE FIELD prdr004 name="input.b.page2.prdr004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdr004
            #add-point:ON CHANGE prdr004 name="input.g.page2.prdr004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdr005
            #add-point:BEFORE FIELD prdr005 name="input.b.page2.prdr005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdr005
            
            #add-point:AFTER FIELD prdr005 name="input.a.page2.prdr005"
#            IF NOT cl_null(g_prdp2_d[l_ac].prdr005) THEN
#               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#               INITIALIZE g_chkparam.* TO NULL
#
#               #設定g_chkparam.*的參數
#               LET g_chkparam.arg1 = g_prdp2_d[l_ac].prdr005
#               #呼叫檢查存在並帶值的library
#               IF NOT cl_chk_exist("v_imay003_1") THEN
#                  LET g_prdp2_d[l_ac].prdr005 = g_prdp2_d_t.prdr005
#                  NEXT FIELD CURRENT
#               END IF
#               IF g_prdp2_d[l_ac].prdr003 = '4' THEN
#                  LET l_n1 = 0
#                  SELECT COUNT(*) INTO l_n1
#                    FROM imay_t
#                   WHERE imayent = g_enterprise
#                     AND imay003 = g_prdp2_d[l_ac].prdr005
#                  IF l_n1 = 1 THEN
#                     SELECT imay001 INTO l_prdr004
#                       FROM imay_t
#                      WHERE imayent = g_enterprise
#                        AND imay003 = g_prdp2_d[l_ac].prdr005
#                     IF NOT cl_null(l_prdr004) THEN
#                        LET l_n1 = 0
#                        SELECT COUNT(*) INTO l_n1
#                          FROM prdr_t
#                         WHERE prdrent = g_enterprise
#                           AND prdgdocno = g_prdl_m.prdadocno
#                           AND prdr004 = l_prdr004
#                           AND prdr002 <> g_prdp2_d[l_ac].prdr002
#                        IF l_n1 > 0 THEN
#                           CALL cl_err(l_prdr004,'apr-00197',1)
#                           LET g_prdp2_d[l_ac].prdr005 = g_prdp2_d_t.prdr005
#                           NEXT FIELD CURRENT
#                        END IF
#                     END IF
#                     LET g_prdp2_d[l_ac].prdr004 = l_prdr004
#                     CALL aprm211_prdr004_def() 
#                  END IF
#               END IF
#               CALL aprm211_prdr_desc()   
#            END IF               
#                
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdr005
            #add-point:ON CHANGE prdr005 name="input.g.page2.prdr005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdr006
            
            #add-point:AFTER FIELD prdr006 name="input.a.page2.prdr006"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdr006
            #add-point:BEFORE FIELD prdr006 name="input.b.page2.prdr006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdr006
            #add-point:ON CHANGE prdr006 name="input.g.page2.prdr006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdr007
            #add-point:BEFORE FIELD prdr007 name="input.b.page2.prdr007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdr007
            
            #add-point:AFTER FIELD prdr007 name="input.a.page2.prdr007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdr007
            #add-point:ON CHANGE prdr007 name="input.g.page2.prdr007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdrsite
            #add-point:BEFORE FIELD prdrsite name="input.b.page2.prdrsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdrsite
            
            #add-point:AFTER FIELD prdrsite name="input.a.page2.prdrsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdrsite
            #add-point:ON CHANGE prdrsite name="input.g.page2.prdrsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdrunit
            #add-point:BEFORE FIELD prdrunit name="input.b.page2.prdrunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdrunit
            
            #add-point:AFTER FIELD prdrunit name="input.a.page2.prdrunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdrunit
            #add-point:ON CHANGE prdrunit name="input.g.page2.prdrunit"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdr010
            #add-point:BEFORE FIELD prdr010 name="input.b.page2.prdr010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdr010
            
            #add-point:AFTER FIELD prdr010 name="input.a.page2.prdr010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdr010
            #add-point:ON CHANGE prdr010 name="input.g.page2.prdr010"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.prdrstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdrstus
            #add-point:ON ACTION controlp INFIELD prdrstus name="input.c.page2.prdrstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.prdr002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdr002
            #add-point:ON ACTION controlp INFIELD prdr002 name="input.c.page2.prdr002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.prdr011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdr011
            #add-point:ON ACTION controlp INFIELD prdr011 name="input.c.page2.prdr011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.prdr003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdr003
            #add-point:ON ACTION controlp INFIELD prdr003 name="input.c.page2.prdr003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.prdr004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdr004
            #add-point:ON ACTION controlp INFIELD prdr004 name="input.c.page2.prdr004"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_prdp2_d[l_ac].prdr004             #給予default值

            IF g_prdp2_d[l_ac].prdr003 = '4' OR g_prdp2_d[l_ac].prdr003 = '15' THEN   #160819-00054#16 161013 by lori add:prdr003=15
               LET g_qryparam.arg1 = g_site
               CALL q_rtdx001_12()
            END IF 
            
            IF g_prdp2_d[l_ac].prdr003 = '5' THEN
               CALL q_rtax001()
            END IF
            IF g_prdp2_d[l_ac].prdr003 = '6' THEN
               LET g_qryparam.arg1 = '2000'
               CALL q_oocq002()
            END IF
            IF g_prdp2_d[l_ac].prdr003 = '7' THEN
               LET g_qryparam.arg1 = '2001'
               CALL q_oocq002()
            END IF
            IF g_prdp2_d[l_ac].prdr003 = '8' THEN
               LET g_qryparam.arg1 = '2002'
               CALL q_oocq002()
            END IF
            IF g_prdp2_d[l_ac].prdr003 = '9' THEN
               LET g_qryparam.arg1 = '2003'
               CALL q_oocq002()
            END IF
            IF g_prdp2_d[l_ac].prdr003 = 'A' THEN
               LET g_qryparam.arg1 = '2004'
               CALL q_oocq002()
            END IF
            IF g_prdp2_d[l_ac].prdr003 = 'B' THEN
               LET g_qryparam.arg1 = '2005'
               CALL q_oocq002()
            END IF
            IF g_prdp2_d[l_ac].prdr003 = 'C' THEN
               LET g_qryparam.arg1 = '2006'
               CALL q_oocq002()
            END IF
            IF g_prdp2_d[l_ac].prdr003 = 'D' THEN
               LET g_qryparam.arg1 = '2007'
               CALL q_oocq002()
            END IF
            IF g_prdp2_d[l_ac].prdr003 = 'E' THEN
               LET g_qryparam.arg1 = '2008'
               CALL q_oocq002()
            END IF
            IF g_prdp2_d[l_ac].prdr003 = 'F' THEN
               LET g_qryparam.arg1 = '2009'
               CALL q_oocq002()
            END IF
            IF g_prdp2_d[l_ac].prdr003 = 'G' THEN
               LET g_qryparam.arg1 = '2010'
               CALL q_oocq002()
            END IF
            IF g_prdp2_d[l_ac].prdr003 = 'H' THEN
               LET g_qryparam.arg1 = '2011'
               CALL q_oocq002()
            END IF
            IF g_prdp2_d[l_ac].prdr003 = 'I' THEN
               LET g_qryparam.arg1 = '2012'
               CALL q_oocq002()
            END IF
            IF g_prdp2_d[l_ac].prdr003 = 'J' THEN
               LET g_qryparam.arg1 = '2013'
               CALL q_oocq002()
            END IF
            IF g_prdp2_d[l_ac].prdr003 = 'K' THEN
               LET g_qryparam.arg1 = '2014'
               CALL q_oocq002()
            END IF
            IF g_prdp2_d[l_ac].prdr003 = 'L' THEN
               LET g_qryparam.arg1 = '2015'
               CALL q_oocq002()
            END IF
             ##add by zn --str  #160728-00006#24
            IF g_prdp2_d[l_ac].prdr003 = '14' THEN
               CALL q_mhbc001_1()
            END IF
            ##add by zn  --str
            LET g_prdp2_d[l_ac].prdr004 = g_qryparam.return1        #將開窗取得的值回傳到變數
            DISPLAY g_prdp2_d[l_ac].prdr004 TO prdr004              #顯示到畫面上
            CALL aprm211_prdr_desc()
            NEXT FIELD prdr004                                      #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page2.prdr005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdr005
            #add-point:ON ACTION controlp INFIELD prdr005 name="input.c.page2.prdr005"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_prdp2_d[l_ac].prdr005  
            
            #CALL q_imay003_2()  #160819-00054#16 161013 by lori mark                          

            #160819-00054#16 161013 by lori add---(S)
            LET l_where = " imay001 IN(SELECT rtdx001 FROM rtdx_t WHERE rtdxent = '",g_enterprise,"' AND rtdxsite = '",g_site,"' AND rtdxstus = 'Y')"
            CASE g_prdp2_d[l_ac].prdr003    
               WHEN '4' 
                  LET g_qryparam.where = l_where
                  CALL q_imay003_2()                                
               WHEN '15'
                  IF NOT cl_null(g_prdp2_d[l_ac].prdr004) THEN
                     LET l_where = l_where,
                                   " AND imay001 = '",g_prdp2_d[l_ac].prdr004,"' "
                  END IF
                  LET g_qryparam.where = l_where
                  CALL q_imay003_12()
                  LET l_prdr006 = g_qryparam.return2  #回傳的包裝單位不使用                  
            END CASE
            #160819-00054#16 161013 by lori add---(E)
            
            LET g_prdp2_d[l_ac].prdr005 = g_qryparam.return1 
            DISPLAY g_prdp2_d[l_ac].prdr005 TO prdr005   
            
            NEXT FIELD prdr005                     
            #END add-point
 
 
         #Ctrlp:input.c.page2.prdr006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdr006
            #add-point:ON ACTION controlp INFIELD prdr006 name="input.c.page2.prdr006"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prdp2_d[l_ac].prdr006             #給予default值

            #給予arg

            CALL q_ooca001_1()                                #呼叫開窗

            LET g_prdp2_d[l_ac].prdr006 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_prdp2_d[l_ac].prdr006 TO prdr006              #顯示到畫面上

            NEXT FIELD prdr006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.prdr007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdr007
            #add-point:ON ACTION controlp INFIELD prdr007 name="input.c.page2.prdr007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.prdrsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdrsite
            #add-point:ON ACTION controlp INFIELD prdrsite name="input.c.page2.prdrsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.prdrunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdrunit
            #add-point:ON ACTION controlp INFIELD prdrunit name="input.c.page2.prdrunit"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.prdr010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdr010
            #add-point:ON ACTION controlp INFIELD prdr010 name="input.c.page2.prdr010"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body2.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_prdp2_d[l_ac].* = g_prdp2_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aprm211_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL aprm211_unlock_b("prdr_t","'2'")
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
               LET g_prdp2_d[li_reproduce_target].* = g_prdp2_d[li_reproduce].*
 
               LET g_prdp2_d[li_reproduce_target].prdr002 = NULL
               LET g_prdp2_d[li_reproduce_target].prdr003 = NULL
               LET g_prdp2_d[li_reproduce_target].prdr004 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_prdp2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_prdp2_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_prdp3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_3)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body3.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_prdp3_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aprm211_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_prdp3_d.getLength()
            #add-point:資料輸入前 name="input.body3.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_prdp3_d[l_ac].* TO NULL 
            INITIALIZE g_prdp3_d_t.* TO NULL 
            INITIALIZE g_prdp3_d_o.* TO NULL 
            #公用欄位給值(單身3)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_prdp3_d[l_ac].prdqstus = 'N'
 
 
 
            #自定義預設值(單身3)
            
            #add-point:modify段before備份 name="input.body3.insert.before_bak"
            
            #end add-point
            LET g_prdp3_d_t.* = g_prdp3_d[l_ac].*     #新輸入資料
            LET g_prdp3_d_o.* = g_prdp3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aprm211_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body3.insert.after_set_entry_b"
            
            #end add-point
            CALL aprm211_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_prdp3_d[li_reproduce_target].* = g_prdp3_d[li_reproduce].*
 
               LET g_prdp3_d[li_reproduce_target].prdq002 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body3.before_insert"
#            SELECT MAX(prdq002)+1 INTO g_prdp3_d[l_ac].prdq002
#              FROM prdq_t
#             WHERE prdqent = g_enterprise
#               AND prdfdocno = g_prdl_m.prdadocno
#            IF cl_null(g_prdp3_d[l_ac].prdq002) THEN
#               LET g_prdp3_d[l_ac].prdq002 = 1
#            END IF
#            LET g_prdp3_d[l_ac].prdq001 = g_prdl_m.prdl001
#            LET g_prdp3_d[l_ac].prdqunit = g_site
#            LET g_prdp3_d[l_ac].prdqsite = g_site
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
            OPEN aprm211_cl USING g_enterprise,g_prdl_m.prdl001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aprm211_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aprm211_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_prdp3_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_prdp3_d[l_ac].prdq002 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_prdp3_d_t.* = g_prdp3_d[l_ac].*  #BACKUP
               LET g_prdp3_d_o.* = g_prdp3_d[l_ac].*  #BACKUP
               CALL aprm211_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body3.after_set_entry_b"
               
               #end add-point  
               CALL aprm211_set_no_entry_b(l_cmd)
               IF NOT aprm211_lock_b("prdq_t","'3'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aprm211_bcl3 INTO g_prdp3_d[l_ac].prdqstus,g_prdp3_d[l_ac].prdq003,g_prdp3_d[l_ac].prdq004, 
                      g_prdp3_d[l_ac].prdq002,g_prdp3_d[l_ac].prdqsite,g_prdp3_d[l_ac].prdqunit
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_prdp3_d_mask_o[l_ac].* =  g_prdp3_d[l_ac].*
                  CALL aprm211_prdq_t_mask()
                  LET g_prdp3_d_mask_n[l_ac].* =  g_prdp3_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aprm211_show()
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
               LET gs_keys[gs_keys.getLength()+1] = g_prdp3_d_t.prdq002
            
               #刪除同層單身
               IF NOT aprm211_delete_b('prdq_t',gs_keys,"'3'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aprm211_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aprm211_key_delete_b(gs_keys,'prdq_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aprm211_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身3刪除中 name="input.body3.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE aprm211_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身3刪除後 name="input.body3.a_delete"
               
               #end add-point
               LET l_count = g_prdp_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body3.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_prdp3_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM prdq_t 
             WHERE prdqent = g_enterprise AND prdq001 = g_prdl_m.prdl001
               AND prdq002 = g_prdp3_d[l_ac].prdq002
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身3新增前 name="input.body3.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prdl_m.prdl001
               LET gs_keys[2] = g_prdp3_d[g_detail_idx].prdq002
               CALL aprm211_insert_b('prdq_t',gs_keys,"'3'")
                           
               #add-point:單身新增後3 name="input.body3.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_prdp_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "prdq_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aprm211_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body3.after_insert"
#               IF p_cmd = 'u' THEN
#                  LET l_time = cl_get_current()
#                  UPDATE prdl_t SET prdlmodid = g_user,
#                                    prdlmoddt = l_time
#                   WHERE prdlent = g_enterprise
#                     AND prdadocno = g_prdl_m.prdadocno
#                  IF SQLCA.SQLcode  THEN
#                     CALL cl_err("upd prdl_t",SQLCA.sqlcode,1)
#                     CALL s_transaction_end('N','0')
#                     CANCEL INSERT
#                  END IF
#               END IF
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_prdp3_d[l_ac].* = g_prdp3_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aprm211_bcl3
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
               LET g_prdp3_d[l_ac].* = g_prdp3_d_t.*
            ELSE
               #add-point:單身page3修改前 name="input.body3.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身3)
               
               #將遮罩欄位還原
               CALL aprm211_prdq_t_mask_restore('restore_mask_o')
                              
               UPDATE prdq_t SET (prdq001,prdqstus,prdq003,prdq004,prdq002,prdqsite,prdqunit) = (g_prdl_m.prdl001, 
                   g_prdp3_d[l_ac].prdqstus,g_prdp3_d[l_ac].prdq003,g_prdp3_d[l_ac].prdq004,g_prdp3_d[l_ac].prdq002, 
                   g_prdp3_d[l_ac].prdqsite,g_prdp3_d[l_ac].prdqunit) #自訂欄位頁簽
                WHERE prdqent = g_enterprise AND prdq001 = g_prdl_m.prdl001
                  AND prdq002 = g_prdp3_d_t.prdq002 #項次 
                  
               #add-point:單身page3修改中 name="input.body3.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_prdp3_d[l_ac].* = g_prdp3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "prdq_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_prdp3_d[l_ac].* = g_prdp3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "prdq_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prdl_m.prdl001
               LET gs_keys_bak[1] = g_prdl001_t
               LET gs_keys[2] = g_prdp3_d[g_detail_idx].prdq002
               LET gs_keys_bak[2] = g_prdp3_d_t.prdq002
               CALL aprm211_update_b('prdq_t',gs_keys,gs_keys_bak,"'3'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aprm211_prdq_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_prdp3_d[g_detail_idx].prdq002 = g_prdp3_d_t.prdq002 
                  ) THEN
                  LET gs_keys[01] = g_prdl_m.prdl001
                  LET gs_keys[gs_keys.getLength()+1] = g_prdp3_d_t.prdq002
                  CALL aprm211_key_update_b(gs_keys,'prdq_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_prdl_m),util.JSON.stringify(g_prdp3_d_t)
               LET g_log2 = util.JSON.stringify(g_prdl_m),util.JSON.stringify(g_prdp3_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page3修改後 name="input.body3.a_update"
#               IF p_cmd = 'u' THEN
#                  LET l_time = cl_get_current()
#                  UPDATE prdl_t SET prdlmodid = g_user,
#                                    prdlmoddt = l_time
#                   WHERE prdlent = g_enterprise
#                     AND prdadocno = g_prdl_m.prdadocno
#                  IF SQLCA.SQLcode  THEN
#                     CALL cl_err("upd prdl_t",SQLCA.sqlcode,1)
#                     CALL s_transaction_end('N','0')
#                  END IF
#               END IF
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdqstus
            #add-point:BEFORE FIELD prdqstus name="input.b.page3.prdqstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdqstus
            
            #add-point:AFTER FIELD prdqstus name="input.a.page3.prdqstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdqstus
            #add-point:ON CHANGE prdqstus name="input.g.page3.prdqstus"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdq003
            
            #add-point:AFTER FIELD prdq003 name="input.a.page3.prdq003"
            CALL aprm211_prdq_desc()
            IF NOT cl_null(g_prdp3_d[l_ac].prdq003) THEN
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗 #160318-00025#31  add
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_prdp3_d[l_ac].prdq003
               LET g_chkparam.err_str[1] = "aoo-00196:sub-01302|aooi713|",cl_get_progname("aooi713",g_lang,"2"),"|:EXEPROGaooi713"#要執行的建議程式待補 #160318-00025#31  add
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_ooia001_2") THEN
                  LET g_prdp3_d[l_ac].prdq003 = g_prdp3_d_t.prdq003
                  CALL aprm211_prdq_desc()
                  NEXT FIELD CURRENT
               END IF
               CALL aprm211_set_entry_b(l_cmd)
               CALL aprm211_set_no_entry_b(l_cmd)
               LET g_errparam.exeprog = ''  #160318-00005#38 by 07900 add
               LET l_exeprog = ''           #160318-00005#38 by 07900 add
               IF NOT cl_null(g_prdp3_d[l_ac].prdq004) THEN
                  CALL aprm211_chk_prdq004()
                  IF NOT cl_null(g_errparam.exeprog)THEN LET l_exeprog = g_errparam.exeprog END IF #160318-00005#38 by 07900 add
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_prdp3_d[l_ac].prdq003
                     #160318-00005#38 2016/03/29 By 07900 --add-str
                     IF NOT cl_null(l_exeprog) THEN
                        CASE g_errno
                            WHEN 'sub-01307'
                                 LET g_errparam.replace[1] = l_exeprog
                                 LET g_errparam.replace[2] = cl_get_progname(l_exeprog,g_lang,"2")
                                 LET g_errparam.exeprog = l_exeprog
                            WHEN 'sub-01302'   
                                 LET g_errparam.replace[1] = l_exeprog
                                 LET g_errparam.replace[2] = cl_get_progname(l_exeprog,g_lang,"2")
                                 LET g_errparam.exeprog = l_exeprog
                        END CASE  
                     END IF                         
                     #160318-00005#38 2016/03/29 By 07900 --add-end
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_prdp3_d[l_ac].prdq003 = g_prdp3_d_t.prdq003
                     NEXT FIELD prdq003
                  END IF   
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdq003
            #add-point:BEFORE FIELD prdq003 name="input.b.page3.prdq003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdq003
            #add-point:ON CHANGE prdq003 name="input.g.page3.prdq003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdq004
            
            #add-point:AFTER FIELD prdq004 name="input.a.page3.prdq004"
            CALL aprm211_prdq_desc()
            IF NOT cl_null(g_prdp3_d[l_ac].prdq004) THEN
               LET g_errparam.exeprog = ''  #160318-00005#38 by 07900 add
               LET l_exeprog = ''           #160318-00005#38 by 07900 add
               IF NOT cl_null(g_prdp3_d[l_ac].prdq003) THEN
                  CALL aprm211_chk_prdq004()
                  IF NOT cl_null(g_errparam.exeprog)THEN LET l_exeprog = g_errparam.exeprog END IF #160318-00005#38 by 07900 add
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_prdp3_d[l_ac].prdq004
                    #160318-00005#38 2016/03/29 By 07900 --add-str
                     IF NOT cl_null(l_exeprog) THEN
                        CASE g_errno
                            WHEN 'sub-01307'
                                 LET g_errparam.replace[1] = l_exeprog
                                 LET g_errparam.replace[2] = cl_get_progname(l_exeprog,g_lang,"2")
                                 LET g_errparam.exeprog = l_exeprog
                            WHEN 'sub-01302'   
                                 LET g_errparam.replace[1] = l_exeprog
                                 LET g_errparam.replace[2] = cl_get_progname(l_exeprog,g_lang,"2")
                                 LET g_errparam.exeprog = l_exeprog
                        END CASE  
                     END IF                         
                     #160318-00005#38 2016/03/29 By 07900 --add-end
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_prdp3_d[l_ac].prdq004 = g_prdp3_d_t.prdq004
                     CALL aprm211_prdq_desc()
                     NEXT FIELD prdq004
                  END IF   
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdq004
            #add-point:BEFORE FIELD prdq004 name="input.b.page3.prdq004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdq004
            #add-point:ON CHANGE prdq004 name="input.g.page3.prdq004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdq002
            #add-point:BEFORE FIELD prdq002 name="input.b.page3.prdq002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdq002
            
            #add-point:AFTER FIELD prdq002 name="input.a.page3.prdq002"
            #此段落由子樣板a05產生
#            IF  g_prdl_m.prdadocno IS NOT NULL AND g_prdp3_d[g_detail_idx].prdq002 IS NOT NULL THEN 
#               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_prdl_m.prdadocno != g_prdldocno_t OR g_prdp3_d[g_detail_idx].prdq002 != g_prdp3_d_t.prdq002)) THEN 
#                  IF NOT ap_chk_notDup(g_prdp3_d[l_ac].prdq002,"SELECT COUNT(*) FROM prdq_t WHERE "||"prdqent = '" ||g_enterprise|| "' AND "||"prdfdocno = '"||g_prdl_m.prdadocno ||"' AND "|| "prdq002 = '"||g_prdp3_d[g_detail_idx].prdq002 ||"'",'std-00004',1) THEN 
#                     LET g_prdp3_d[l_ac].prdq002 = g_prdp3_d_t.prdq002
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF
#
#
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdq002
            #add-point:ON CHANGE prdq002 name="input.g.page3.prdq002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdqsite
            #add-point:BEFORE FIELD prdqsite name="input.b.page3.prdqsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdqsite
            
            #add-point:AFTER FIELD prdqsite name="input.a.page3.prdqsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdqsite
            #add-point:ON CHANGE prdqsite name="input.g.page3.prdqsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdqunit
            #add-point:BEFORE FIELD prdqunit name="input.b.page3.prdqunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdqunit
            
            #add-point:AFTER FIELD prdqunit name="input.a.page3.prdqunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdqunit
            #add-point:ON CHANGE prdqunit name="input.g.page3.prdqunit"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.prdqstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdqstus
            #add-point:ON ACTION controlp INFIELD prdqstus name="input.c.page3.prdqstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.prdq003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdq003
            #add-point:ON ACTION controlp INFIELD prdq003 name="input.c.page3.prdq003"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prdp3_d[l_ac].prdq003             #給予default值

            #給予arg

            CALL q_ooia001()                                #呼叫開窗

            LET g_prdp3_d[l_ac].prdq003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_prdp3_d[l_ac].prdq003 TO prdq003              #顯示到畫面上
            CALL aprm211_prdq_desc()
            NEXT FIELD prdq003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page3.prdq004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdq004
            #add-point:ON ACTION controlp INFIELD prdq004 name="input.c.page3.prdq004"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_prdp3_d[l_ac].prdq004   #給予default值
            #給予arg
            IF NOT cl_null(g_prdp3_d[l_ac].prdq003) THEN
               LET l_ooia002 = ''
               SELECT ooia002 INTO l_ooia002
                 FROM ooia_t
                WHERE ooiaent = g_enterprise
                  AND ooia001 = g_prdp3_d[l_ac].prdq003
               IF l_ooia002 = '40' THEN
                  CALL q_gcaf001_4()
               END IF
               IF l_ooia002 = '60' THEN
                  CALL q_mman001_7()
               END IF
            END IF

            LET g_prdp3_d[l_ac].prdq004  = g_qryparam.return1   #將開窗取得的值回傳到變數
            DISPLAY g_prdp3_d[l_ac].prdq004  TO prdq004         #顯示到畫面上
            CALL aprm211_prdq_desc()
            NEXT FIELD prdq004      
            #END add-point
 
 
         #Ctrlp:input.c.page3.prdq002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdq002
            #add-point:ON ACTION controlp INFIELD prdq002 name="input.c.page3.prdq002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.prdqsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdqsite
            #add-point:ON ACTION controlp INFIELD prdqsite name="input.c.page3.prdqsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.prdqunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdqunit
            #add-point:ON ACTION controlp INFIELD prdqunit name="input.c.page3.prdqunit"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page3 after_row name="input.body3.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_prdp3_d[l_ac].* = g_prdp3_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aprm211_bcl3
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL aprm211_unlock_b("prdq_t","'3'")
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
               LET g_prdp3_d[li_reproduce_target].* = g_prdp3_d[li_reproduce].*
 
               LET g_prdp3_d[li_reproduce_target].prdq002 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_prdp3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_prdp3_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_prdp4_d FROM s_detail4.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_4)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body4.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_prdp4_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aprm211_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'4',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_prdp4_d.getLength()
            #add-point:資料輸入前 name="input.body4.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_prdp4_d[l_ac].* TO NULL 
            INITIALIZE g_prdp4_d_t.* TO NULL 
            INITIALIZE g_prdp4_d_o.* TO NULL 
            #公用欄位給值(單身4)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_prdp4_d[l_ac].prdostus = 'N'
 
 
 
            #自定義預設值(單身4)
            
            #add-point:modify段before備份 name="input.body4.insert.before_bak"
            
            #end add-point
            LET g_prdp4_d_t.* = g_prdp4_d[l_ac].*     #新輸入資料
            LET g_prdp4_d_o.* = g_prdp4_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aprm211_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body4.insert.after_set_entry_b"
            
            #end add-point
            CALL aprm211_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_prdp4_d[li_reproduce_target].* = g_prdp4_d[li_reproduce].*
 
               LET g_prdp4_d[li_reproduce_target].prdo002 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body4.before_insert"
#            SELECT MAX(prdo002)+1 INTO g_prdp4_d[l_ac].prdo002
#              FROM prdo_t
#             WHERE prdoent = g_enterprise
#               AND prdddocno = g_prdl_m.prdadocno
            IF cl_null(g_prdp4_d[l_ac].prdo002) THEN
               LET g_prdp4_d[l_ac].prdo002 = 1
            END IF
#            LET g_prdp4_d[l_ac].prdo001 = g_prdl_m.prdl001
            LET g_prdp4_d[l_ac].prdounit = g_site
            LET g_prdp4_d[l_ac].prdosite = g_site
            LET g_prdp4_d[l_ac].prdo005 = '00:00:00'
            LET g_prdp4_d[l_ac].prdo006 = '23:59:59'
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
            OPEN aprm211_cl USING g_enterprise,g_prdl_m.prdl001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aprm211_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aprm211_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_prdp4_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_prdp4_d[l_ac].prdo002 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_prdp4_d_t.* = g_prdp4_d[l_ac].*  #BACKUP
               LET g_prdp4_d_o.* = g_prdp4_d[l_ac].*  #BACKUP
               CALL aprm211_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body4.after_set_entry_b"
               
               #end add-point  
               CALL aprm211_set_no_entry_b(l_cmd)
               IF NOT aprm211_lock_b("prdo_t","'4'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aprm211_bcl4 INTO g_prdp4_d[l_ac].prdostus,g_prdp4_d[l_ac].prdo002,g_prdp4_d[l_ac].prdo003, 
                      g_prdp4_d[l_ac].prdo004,g_prdp4_d[l_ac].prdo005,g_prdp4_d[l_ac].prdo006,g_prdp4_d[l_ac].prdo007, 
                      g_prdp4_d[l_ac].prdo008,g_prdp4_d[l_ac].prdosite,g_prdp4_d[l_ac].prdounit
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_prdp4_d_mask_o[l_ac].* =  g_prdp4_d[l_ac].*
                  CALL aprm211_prdo_t_mask()
                  LET g_prdp4_d_mask_n[l_ac].* =  g_prdp4_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aprm211_show()
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
               LET gs_keys[01] = g_prdl_m.prdl001
               LET gs_keys[gs_keys.getLength()+1] = g_prdp4_d_t.prdo002
            
               #刪除同層單身
               IF NOT aprm211_delete_b('prdo_t',gs_keys,"'4'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aprm211_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aprm211_key_delete_b(gs_keys,'prdo_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aprm211_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身4刪除中 name="input.body4.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE aprm211_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身4刪除後 name="input.body4.a_delete"
               
               #end add-point
               LET l_count = g_prdp_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body4.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_prdp4_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM prdo_t 
             WHERE prdoent = g_enterprise AND prdo001 = g_prdl_m.prdl001
               AND prdo002 = g_prdp4_d[l_ac].prdo002
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身4新增前 name="input.body4.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prdl_m.prdl001
               LET gs_keys[2] = g_prdp4_d[g_detail_idx].prdo002
               CALL aprm211_insert_b('prdo_t',gs_keys,"'4'")
                           
               #add-point:單身新增後4 name="input.body4.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_prdp_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "prdo_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aprm211_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body4.after_insert"
#               IF p_cmd = 'u' THEN
#                  LET l_time = cl_get_current()
#                  UPDATE prdl_t SET prdlmodid = g_user,
#                                    prdlmoddt = l_time
#                   WHERE prdlent = g_enterprise
#                     AND prdadocno = g_prdl_m.prdadocno
#                  IF SQLCA.SQLcode  THEN
#                     CALL cl_err("upd prdl_t",SQLCA.sqlcode,1)
#                     CALL s_transaction_end('N','0')
#                     CANCEL INSERT
#                  END IF
#               END IF
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_prdp4_d[l_ac].* = g_prdp4_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aprm211_bcl4
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
               LET g_prdp4_d[l_ac].* = g_prdp4_d_t.*
            ELSE
               #add-point:單身page4修改前 name="input.body4.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身4)
               
               #將遮罩欄位還原
               CALL aprm211_prdo_t_mask_restore('restore_mask_o')
                              
               UPDATE prdo_t SET (prdo001,prdostus,prdo002,prdo003,prdo004,prdo005,prdo006,prdo007,prdo008, 
                   prdosite,prdounit) = (g_prdl_m.prdl001,g_prdp4_d[l_ac].prdostus,g_prdp4_d[l_ac].prdo002, 
                   g_prdp4_d[l_ac].prdo003,g_prdp4_d[l_ac].prdo004,g_prdp4_d[l_ac].prdo005,g_prdp4_d[l_ac].prdo006, 
                   g_prdp4_d[l_ac].prdo007,g_prdp4_d[l_ac].prdo008,g_prdp4_d[l_ac].prdosite,g_prdp4_d[l_ac].prdounit)  
                   #自訂欄位頁簽
                WHERE prdoent = g_enterprise AND prdo001 = g_prdl_m.prdl001
                  AND prdo002 = g_prdp4_d_t.prdo002 #項次 
                  
               #add-point:單身page4修改中 name="input.body4.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_prdp4_d[l_ac].* = g_prdp4_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "prdo_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_prdp4_d[l_ac].* = g_prdp4_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "prdo_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prdl_m.prdl001
               LET gs_keys_bak[1] = g_prdl001_t
               LET gs_keys[2] = g_prdp4_d[g_detail_idx].prdo002
               LET gs_keys_bak[2] = g_prdp4_d_t.prdo002
               CALL aprm211_update_b('prdo_t',gs_keys,gs_keys_bak,"'4'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aprm211_prdo_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_prdp4_d[g_detail_idx].prdo002 = g_prdp4_d_t.prdo002 
                  ) THEN
                  LET gs_keys[01] = g_prdl_m.prdl001
                  LET gs_keys[gs_keys.getLength()+1] = g_prdp4_d_t.prdo002
                  CALL aprm211_key_update_b(gs_keys,'prdo_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_prdl_m),util.JSON.stringify(g_prdp4_d_t)
               LET g_log2 = util.JSON.stringify(g_prdl_m),util.JSON.stringify(g_prdp4_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page4修改後 name="input.body4.a_update"
#               IF p_cmd = 'u' THEN
#                  LET l_time = cl_get_current()
#                  UPDATE prdl_t SET prdlmodid = g_user,
#                                    prdlmoddt = l_time
#                   WHERE prdlent = g_enterprise
#                     AND prdadocno = g_prdl_m.prdadocno
#                  IF SQLCA.SQLcode  THEN
#                     CALL cl_err("upd prdl_t",SQLCA.sqlcode,1)
#                     CALL s_transaction_end('N','0')
#                  END IF
#               END IF
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdostus
            #add-point:BEFORE FIELD prdostus name="input.b.page4.prdostus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdostus
            
            #add-point:AFTER FIELD prdostus name="input.a.page4.prdostus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdostus
            #add-point:ON CHANGE prdostus name="input.g.page4.prdostus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdo002
            #add-point:BEFORE FIELD prdo002 name="input.b.page4.prdo002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdo002
            
            #add-point:AFTER FIELD prdo002 name="input.a.page4.prdo002"
            #此段落由子樣板a05產生
#            IF  g_prdl_m.prdadocno IS NOT NULL AND g_prdp4_d[g_detail_idx].prdo002 IS NOT NULL THEN 
#               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_prdl_m.prdadocno != g_prdldocno_t OR g_prdp4_d[g_detail_idx].prdo002 != g_prdp4_d_t.prdo002)) THEN 
#                  IF NOT ap_chk_notDup(g_prdp4_d[l_ac].prdo002,"SELECT COUNT(*) FROM prdo_t WHERE "||"prdoent = '" ||g_enterprise|| "' AND "||"prdddocno = '"||g_prdl_m.prdadocno ||"' AND "|| "prdo002 = '"||g_prdp4_d[g_detail_idx].prdo002 ||"'",'std-00004',1) THEN 
#                     LET g_prdp4_d[l_ac].prdo002 = g_prdp4_d_t.prdo002
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF
#
#
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdo002
            #add-point:ON CHANGE prdo002 name="input.g.page4.prdo002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdo003
            #add-point:BEFORE FIELD prdo003 name="input.b.page4.prdo003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdo003
            
            #add-point:AFTER FIELD prdo003 name="input.a.page4.prdo003"
            IF NOT cl_null(g_prdp4_d[l_ac].prdo003) AND NOT cl_null(g_prdp4_d[l_ac].prdo004) THEN
               IF g_prdp4_d[l_ac].prdo003 > g_prdp4_d[l_ac].prdo004 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'amm-00080'
                  LET g_errparam.extend = g_prdp4_d[l_ac].prdo003
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_prdp4_d[l_ac].prdo003 = g_prdp4_d_t.prdo003
                  NEXT FIELD prdo003
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdo003
            #add-point:ON CHANGE prdo003 name="input.g.page4.prdo003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdo004
            #add-point:BEFORE FIELD prdo004 name="input.b.page4.prdo004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdo004
            
            #add-point:AFTER FIELD prdo004 name="input.a.page4.prdo004"
            IF NOT cl_null(g_prdp4_d[l_ac].prdo003) AND NOT cl_null(g_prdp4_d[l_ac].prdo004) THEN
               IF g_prdp4_d[l_ac].prdo003 > g_prdp4_d[l_ac].prdo004 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'amm-00081'
                  LET g_errparam.extend = g_prdp4_d[l_ac].prdo003
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_prdp4_d[l_ac].prdo004 = g_prdp4_d_t.prdo004
                  NEXT FIELD prdo004
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdo004
            #add-point:ON CHANGE prdo004 name="input.g.page4.prdo004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdo005
            #add-point:BEFORE FIELD prdo005 name="input.b.page4.prdo005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdo005
            
            #add-point:AFTER FIELD prdo005 name="input.a.page4.prdo005"
            IF NOT cl_null(g_prdp4_d[l_ac].prdo005) AND NOT cl_null(g_prdp4_d[l_ac].prdo006) THEN
               IF g_prdp4_d[l_ac].prdo005 > g_prdp4_d[l_ac].prdo006 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apr-00091'
                  LET g_errparam.extend = g_prdp4_d[l_ac].prdo005
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_prdp4_d[l_ac].prdo005 = g_prdp4_d_t.prdo005
                  NEXT FIELD prdo005
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdo005
            #add-point:ON CHANGE prdo005 name="input.g.page4.prdo005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdo006
            #add-point:BEFORE FIELD prdo006 name="input.b.page4.prdo006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdo006
            
            #add-point:AFTER FIELD prdo006 name="input.a.page4.prdo006"
            IF NOT cl_null(g_prdp4_d[l_ac].prdo005) AND NOT cl_null(g_prdp4_d[l_ac].prdo006) THEN
               IF g_prdp4_d[l_ac].prdo005 > g_prdp4_d[l_ac].prdo006 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apr-00091'
                  LET g_errparam.extend = g_prdp4_d[l_ac].prdo006
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_prdp4_d[l_ac].prdo006 = g_prdp4_d_t.prdo006
                  NEXT FIELD prdo006
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdo006
            #add-point:ON CHANGE prdo006 name="input.g.page4.prdo006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdo007
            #add-point:BEFORE FIELD prdo007 name="input.b.page4.prdo007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdo007
            
            #add-point:AFTER FIELD prdo007 name="input.a.page4.prdo007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdo007
            #add-point:ON CHANGE prdo007 name="input.g.page4.prdo007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdo008
            #add-point:BEFORE FIELD prdo008 name="input.b.page4.prdo008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdo008
            
            #add-point:AFTER FIELD prdo008 name="input.a.page4.prdo008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdo008
            #add-point:ON CHANGE prdo008 name="input.g.page4.prdo008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdosite
            #add-point:BEFORE FIELD prdosite name="input.b.page4.prdosite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdosite
            
            #add-point:AFTER FIELD prdosite name="input.a.page4.prdosite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdosite
            #add-point:ON CHANGE prdosite name="input.g.page4.prdosite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdounit
            #add-point:BEFORE FIELD prdounit name="input.b.page4.prdounit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdounit
            
            #add-point:AFTER FIELD prdounit name="input.a.page4.prdounit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdounit
            #add-point:ON CHANGE prdounit name="input.g.page4.prdounit"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page4.prdostus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdostus
            #add-point:ON ACTION controlp INFIELD prdostus name="input.c.page4.prdostus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.prdo002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdo002
            #add-point:ON ACTION controlp INFIELD prdo002 name="input.c.page4.prdo002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.prdo003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdo003
            #add-point:ON ACTION controlp INFIELD prdo003 name="input.c.page4.prdo003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.prdo004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdo004
            #add-point:ON ACTION controlp INFIELD prdo004 name="input.c.page4.prdo004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.prdo005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdo005
            #add-point:ON ACTION controlp INFIELD prdo005 name="input.c.page4.prdo005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.prdo006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdo006
            #add-point:ON ACTION controlp INFIELD prdo006 name="input.c.page4.prdo006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.prdo007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdo007
            #add-point:ON ACTION controlp INFIELD prdo007 name="input.c.page4.prdo007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.prdo008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdo008
            #add-point:ON ACTION controlp INFIELD prdo008 name="input.c.page4.prdo008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.prdosite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdosite
            #add-point:ON ACTION controlp INFIELD prdosite name="input.c.page4.prdosite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.prdounit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdounit
            #add-point:ON ACTION controlp INFIELD prdounit name="input.c.page4.prdounit"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page4 after_row name="input.body4.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_prdp4_d[l_ac].* = g_prdp4_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aprm211_bcl4
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL aprm211_unlock_b("prdo_t","'4'")
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
               LET g_prdp4_d[li_reproduce_target].* = g_prdp4_d[li_reproduce].*
 
               LET g_prdp4_d[li_reproduce_target].prdo002 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_prdp4_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_prdp4_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_prdp5_d FROM s_detail5.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_5)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body5.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_prdp5_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aprm211_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'5',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_prdp5_d.getLength()
            #add-point:資料輸入前 name="input.body5.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_prdp5_d[l_ac].* TO NULL 
            INITIALIZE g_prdp5_d_t.* TO NULL 
            INITIALIZE g_prdp5_d_o.* TO NULL 
            #公用欄位給值(單身5)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_prdp5_d[l_ac].prdmstus = 'N'
 
 
 
            #自定義預設值(單身5)
                  LET g_prdp5_d[l_ac].prdmstus = "Y"
      LET g_prdp5_d[l_ac].prdm005 = "0"
 
            #add-point:modify段before備份 name="input.body5.insert.before_bak"
            
            #end add-point
            LET g_prdp5_d_t.* = g_prdp5_d[l_ac].*     #新輸入資料
            LET g_prdp5_d_o.* = g_prdp5_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aprm211_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body5.insert.after_set_entry_b"
            
            #end add-point
            CALL aprm211_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_prdp5_d[li_reproduce_target].* = g_prdp5_d[li_reproduce].*
 
               LET g_prdp5_d[li_reproduce_target].prdm002 = NULL
               LET g_prdp5_d[li_reproduce_target].prdm004 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body5.before_insert"
            
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body5.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[5] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 5
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN aprm211_cl USING g_enterprise,g_prdl_m.prdl001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aprm211_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aprm211_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_prdp5_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_prdp5_d[l_ac].prdm002 IS NOT NULL
               AND g_prdp5_d[l_ac].prdm004 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_prdp5_d_t.* = g_prdp5_d[l_ac].*  #BACKUP
               LET g_prdp5_d_o.* = g_prdp5_d[l_ac].*  #BACKUP
               CALL aprm211_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body5.after_set_entry_b"
               
               #end add-point  
               CALL aprm211_set_no_entry_b(l_cmd)
               IF NOT aprm211_lock_b("prdm_t","'5'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aprm211_bcl5 INTO g_prdp5_d[l_ac].prdmstus,g_prdp5_d[l_ac].prdm004,g_prdp5_d[l_ac].prdm002, 
                      g_prdp5_d[l_ac].prdm003,g_prdp5_d[l_ac].prdm005,g_prdp5_d[l_ac].prdmsite,g_prdp5_d[l_ac].prdmunit 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_prdp5_d_mask_o[l_ac].* =  g_prdp5_d[l_ac].*
                  CALL aprm211_prdm_t_mask()
                  LET g_prdp5_d_mask_n[l_ac].* =  g_prdp5_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aprm211_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body5.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body5.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body5.b_delete_ask"
               
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
               
               #add-point:單身5刪除前 name="input.body5.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_prdl_m.prdl001
               LET gs_keys[gs_keys.getLength()+1] = g_prdp5_d_t.prdm002
               LET gs_keys[gs_keys.getLength()+1] = g_prdp5_d_t.prdm004
            
               #刪除同層單身
               IF NOT aprm211_delete_b('prdm_t',gs_keys,"'5'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aprm211_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aprm211_key_delete_b(gs_keys,'prdm_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aprm211_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身5刪除中 name="input.body5.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE aprm211_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身5刪除後 name="input.body5.a_delete"
               
               #end add-point
               LET l_count = g_prdp_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body5.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_prdp5_d.getLength() + 1) THEN
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
               
            #add-point:單身5新增前 name="input.body5.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM prdm_t 
             WHERE prdment = g_enterprise AND prdm001 = g_prdl_m.prdl001
               AND prdm002 = g_prdp5_d[l_ac].prdm002
               AND prdm004 = g_prdp5_d[l_ac].prdm004
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身5新增前 name="input.body5.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prdl_m.prdl001
               LET gs_keys[2] = g_prdp5_d[g_detail_idx].prdm002
               LET gs_keys[3] = g_prdp5_d[g_detail_idx].prdm004
               CALL aprm211_insert_b('prdm_t',gs_keys,"'5'")
                           
               #add-point:單身新增後5 name="input.body5.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_prdp_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "prdm_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aprm211_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body5.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_prdp5_d[l_ac].* = g_prdp5_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aprm211_bcl5
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
               LET g_prdp5_d[l_ac].* = g_prdp5_d_t.*
            ELSE
               #add-point:單身page5修改前 name="input.body5.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身5)
               
               #將遮罩欄位還原
               CALL aprm211_prdm_t_mask_restore('restore_mask_o')
                              
               UPDATE prdm_t SET (prdm001,prdmstus,prdm004,prdm002,prdm003,prdm005,prdmsite,prdmunit) = (g_prdl_m.prdl001, 
                   g_prdp5_d[l_ac].prdmstus,g_prdp5_d[l_ac].prdm004,g_prdp5_d[l_ac].prdm002,g_prdp5_d[l_ac].prdm003, 
                   g_prdp5_d[l_ac].prdm005,g_prdp5_d[l_ac].prdmsite,g_prdp5_d[l_ac].prdmunit) #自訂欄位頁簽 
 
                WHERE prdment = g_enterprise AND prdm001 = g_prdl_m.prdl001
                  AND prdm002 = g_prdp5_d_t.prdm002 #項次 
                  AND prdm004 = g_prdp5_d_t.prdm004
                  
               #add-point:單身page5修改中 name="input.body5.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_prdp5_d[l_ac].* = g_prdp5_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "prdm_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_prdp5_d[l_ac].* = g_prdp5_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "prdm_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prdl_m.prdl001
               LET gs_keys_bak[1] = g_prdl001_t
               LET gs_keys[2] = g_prdp5_d[g_detail_idx].prdm002
               LET gs_keys_bak[2] = g_prdp5_d_t.prdm002
               LET gs_keys[3] = g_prdp5_d[g_detail_idx].prdm004
               LET gs_keys_bak[3] = g_prdp5_d_t.prdm004
               CALL aprm211_update_b('prdm_t',gs_keys,gs_keys_bak,"'5'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aprm211_prdm_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_prdp5_d[g_detail_idx].prdm002 = g_prdp5_d_t.prdm002 
                  AND g_prdp5_d[g_detail_idx].prdm004 = g_prdp5_d_t.prdm004 
                  ) THEN
                  LET gs_keys[01] = g_prdl_m.prdl001
                  LET gs_keys[gs_keys.getLength()+1] = g_prdp5_d_t.prdm002
                  LET gs_keys[gs_keys.getLength()+1] = g_prdp5_d_t.prdm004
                  CALL aprm211_key_update_b(gs_keys,'prdm_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_prdl_m),util.JSON.stringify(g_prdp5_d_t)
               LET g_log2 = util.JSON.stringify(g_prdl_m),util.JSON.stringify(g_prdp5_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page5修改後 name="input.body5.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdmstus
            #add-point:BEFORE FIELD prdmstus name="input.b.page5.prdmstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdmstus
            
            #add-point:AFTER FIELD prdmstus name="input.a.page5.prdmstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdmstus
            #add-point:ON CHANGE prdmstus name="input.g.page5.prdmstus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdm004
            #add-point:BEFORE FIELD prdm004 name="input.b.page5.prdm004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdm004
            
            #add-point:AFTER FIELD prdm004 name="input.a.page5.prdm004"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_prdl_m.prdl001 IS NOT NULL AND g_prdp5_d[g_detail_idx].prdm002 IS NOT NULL AND g_prdp5_d[g_detail_idx].prdm004 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_prdl_m.prdl001 != g_prdl001_t OR g_prdp5_d[g_detail_idx].prdm002 != g_prdp5_d_t.prdm002 OR g_prdp5_d[g_detail_idx].prdm004 != g_prdp5_d_t.prdm004)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM prdm_t WHERE "||"prdment = '" ||g_enterprise|| "' AND "||"prdm001 = '"||g_prdl_m.prdl001 ||"' AND "|| "prdm002 = '"||g_prdp5_d[g_detail_idx].prdm002 ||"' AND "|| "prdm004 = '"||g_prdp5_d[g_detail_idx].prdm004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdm004
            #add-point:ON CHANGE prdm004 name="input.g.page5.prdm004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdm002
            #add-point:BEFORE FIELD prdm002 name="input.b.page5.prdm002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdm002
            
            #add-point:AFTER FIELD prdm002 name="input.a.page5.prdm002"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_prdl_m.prdl001 IS NOT NULL AND g_prdp5_d[g_detail_idx].prdm002 IS NOT NULL AND g_prdp5_d[g_detail_idx].prdm004 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_prdl_m.prdl001 != g_prdl001_t OR g_prdp5_d[g_detail_idx].prdm002 != g_prdp5_d_t.prdm002 OR g_prdp5_d[g_detail_idx].prdm004 != g_prdp5_d_t.prdm004)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM prdm_t WHERE "||"prdment = '" ||g_enterprise|| "' AND "||"prdm001 = '"||g_prdl_m.prdl001 ||"' AND "|| "prdm002 = '"||g_prdp5_d[g_detail_idx].prdm002 ||"' AND "|| "prdm004 = '"||g_prdp5_d[g_detail_idx].prdm004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdm002
            #add-point:ON CHANGE prdm002 name="input.g.page5.prdm002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdm003
            #add-point:BEFORE FIELD prdm003 name="input.b.page5.prdm003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdm003
            
            #add-point:AFTER FIELD prdm003 name="input.a.page5.prdm003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdm003
            #add-point:ON CHANGE prdm003 name="input.g.page5.prdm003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdm005
            #add-point:BEFORE FIELD prdm005 name="input.b.page5.prdm005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdm005
            
            #add-point:AFTER FIELD prdm005 name="input.a.page5.prdm005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdm005
            #add-point:ON CHANGE prdm005 name="input.g.page5.prdm005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdmsite
            #add-point:BEFORE FIELD prdmsite name="input.b.page5.prdmsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdmsite
            
            #add-point:AFTER FIELD prdmsite name="input.a.page5.prdmsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdmsite
            #add-point:ON CHANGE prdmsite name="input.g.page5.prdmsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdmunit
            #add-point:BEFORE FIELD prdmunit name="input.b.page5.prdmunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdmunit
            
            #add-point:AFTER FIELD prdmunit name="input.a.page5.prdmunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdmunit
            #add-point:ON CHANGE prdmunit name="input.g.page5.prdmunit"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page5.prdmstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdmstus
            #add-point:ON ACTION controlp INFIELD prdmstus name="input.c.page5.prdmstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.prdm004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdm004
            #add-point:ON ACTION controlp INFIELD prdm004 name="input.c.page5.prdm004"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prdp5_d[l_ac].prdm004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_prdh002()                                #呼叫開窗

            LET g_prdp5_d[l_ac].prdm004 = g_qryparam.return1              

            DISPLAY g_prdp5_d[l_ac].prdm004 TO prdm004              #

            NEXT FIELD prdm004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page5.prdm002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdm002
            #add-point:ON ACTION controlp INFIELD prdm002 name="input.c.page5.prdm002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.prdm003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdm003
            #add-point:ON ACTION controlp INFIELD prdm003 name="input.c.page5.prdm003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.prdm005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdm005
            #add-point:ON ACTION controlp INFIELD prdm005 name="input.c.page5.prdm005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.prdmsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdmsite
            #add-point:ON ACTION controlp INFIELD prdmsite name="input.c.page5.prdmsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.prdmunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdmunit
            #add-point:ON ACTION controlp INFIELD prdmunit name="input.c.page5.prdmunit"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page5 after_row name="input.body5.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_prdp5_d[l_ac].* = g_prdp5_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aprm211_bcl5
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL aprm211_unlock_b("prdm_t","'5'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page5 after_row2 name="input.body5.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body5.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_prdp5_d[li_reproduce_target].* = g_prdp5_d[li_reproduce].*
 
               LET g_prdp5_d[li_reproduce_target].prdm002 = NULL
               LET g_prdp5_d[li_reproduce_target].prdm004 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_prdp5_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_prdp5_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
 
 
 
{</section>}
 
{<section id="aprm211.input.other" >}
      
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
         CALL DIALOG.setCurrentRow("s_detail5",g_idx_group.getValue("'5',"))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD prdl001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD prdp002
               WHEN "s_detail2"
                  NEXT FIELD prdrstus
               WHEN "s_detail3"
                  NEXT FIELD prdqstus
               WHEN "s_detail4"
                  NEXT FIELD prdostus
               WHEN "s_detail5"
                  NEXT FIELD prdmstus
 
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
         LET g_detail_idx_list[5] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
         CALL g_curr_diag.setCurrentRow("s_detail4",1)
         CALL g_curr_diag.setCurrentRow("s_detail5",1)
 
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
         LET g_detail_idx_list[5] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
         CALL g_curr_diag.setCurrentRow("s_detail4",1)
         CALL g_curr_diag.setCurrentRow("s_detail5",1)
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
     
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="aprm211.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION aprm211_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
 
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL aprm211_b_fill() #單身填充
      CALL aprm211_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aprm211_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"

            CALL aprm211_desc()

            CALL aprm211_master_show()
            CALL aprm211_set_comp_visible()
            #160503-00039#1 by 08171
            SELECT prdll003 INTO g_prdl_m.prdll003 FROM prdll_t WHERE prdllent=g_enterprise AND prdll001=g_prdl_m.prdl001 AND prdll002=g_dlang
   #end add-point
   
   #遮罩相關處理
   LET g_prdl_m_mask_o.* =  g_prdl_m.*
   CALL aprm211_prdl_t_mask()
   LET g_prdl_m_mask_n.* =  g_prdl_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_prdl_m.prdlunit,g_prdl_m.prdlunit_desc,g_prdl_m.prdl001,g_prdl_m.prdl002,g_prdl_m.prdll003, 
       g_prdl_m.prdl006,g_prdl_m.prdl006_desc,g_prdl_m.prdl007,g_prdl_m.prdl007_desc,g_prdl_m.prdl027, 
       g_prdl_m.prdl099,g_prdl_m.prdl100,g_prdl_m.prdlstus,g_prdl_m.prdl010,g_prdl_m.prdl011,g_prdl_m.prdl012, 
       g_prdl_m.prdl013,g_prdl_m.prdl038,g_prdl_m.prdl024,g_prdl_m.prdl025,g_prdl_m.prdl026,g_prdl_m.l_prdo003_1, 
       g_prdl_m.l_prdo004_1,g_prdl_m.prdl098,g_prdl_m.prdl037,g_prdl_m.prdl034,g_prdl_m.prdl042,g_prdl_m.prdl004, 
       g_prdl_m.prdl004_desc,g_prdl_m.prdl005,g_prdl_m.prdl005_desc,g_prdl_m.prdb005_1,g_prdl_m.prdo005_1, 
       g_prdl_m.prdo006_1,g_prdl_m.prdl003,g_prdl_m.prdl033,g_prdl_m.prdl033_desc,g_prdl_m.prdl008,g_prdl_m.prdl008_desc, 
       g_prdl_m.prdl009,g_prdl_m.prdl009_desc,g_prdl_m.prdb005_2,g_prdl_m.prdo007_1,g_prdl_m.prdo008_1, 
       g_prdl_m.prdlsite,g_prdl_m.prdlcrtid,g_prdl_m.prdlcrtid_desc,g_prdl_m.prdlcrtdp,g_prdl_m.prdlcrtdp_desc, 
       g_prdl_m.prdlcrtdt,g_prdl_m.prdlownid,g_prdl_m.prdlownid_desc,g_prdl_m.prdlowndp,g_prdl_m.prdlowndp_desc, 
       g_prdl_m.prdlmodid,g_prdl_m.prdlmodid_desc,g_prdl_m.prdlmoddt,g_prdl_m.prdlcnfid,g_prdl_m.prdlcnfid_desc, 
       g_prdl_m.prdlcnfdt
   
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
   FOR l_ac = 1 TO g_prdp_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      CALL aprm211_prdp_desc()
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_prdp2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
      
      CALL aprm211_prdr_desc()
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_prdp3_d.getLength()
      #add-point:show段單身reference name="show.body3.reference"
      CALL aprm211_prdq_desc()     

      #end add-point
   END FOR
   FOR l_ac = 1 TO g_prdp4_d.getLength()
      #add-point:show段單身reference name="show.body4.reference"
 
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_prdp5_d.getLength()
      #add-point:show段單身reference name="show.body5.reference"
      
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   FOR l_ac = 1 TO g_prdp6_d.getLength()
       CALL aprm211_prdn_desc()
   END FOR
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL aprm211_detail_show()
 
   #add-point:show段之後 name="show.after"
  
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aprm211.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION aprm211_detail_show()
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
 
{<section id="aprm211.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aprm211_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE prdl_t.prdl001 
   DEFINE l_oldno     LIKE prdl_t.prdl001 
 
   DEFINE l_master    RECORD LIKE prdl_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE prdp_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE prdr_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE prdq_t.* #此變數樣板目前無使用
 
   DEFINE l_detail4    RECORD LIKE prdo_t.* #此變數樣板目前無使用
 
   DEFINE l_detail5    RECORD LIKE prdm_t.* #此變數樣板目前無使用
 
 
 
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
   CALL aprm211_set_entry('a')
   CALL aprm211_set_no_required('a')
   CALL aprm211_set_required('a')
   CALL aprm211_set_no_entry('a')               
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
   
   
   CALL aprm211_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_prdl_m.* TO NULL
      INITIALIZE g_prdp_d TO NULL
      INITIALIZE g_prdp2_d TO NULL
      INITIALIZE g_prdp3_d TO NULL
      INITIALIZE g_prdp4_d TO NULL
      INITIALIZE g_prdp5_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL aprm211_show()
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
   CALL aprm211_set_act_visible()   
   CALL aprm211_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_prdl001_t = g_prdl_m.prdl001
 
   
   #組合新增資料的條件
   LET g_add_browse = " prdlent = " ||g_enterprise|| " AND",
                      " prdl001 = '", g_prdl_m.prdl001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aprm211_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL aprm211_idx_chk()
   
   LET g_data_owner = g_prdl_m.prdlownid      
   LET g_data_dept  = g_prdl_m.prdlowndp
   
   #功能已完成,通報訊息中心
   CALL aprm211_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="aprm211.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION aprm211_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE prdp_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE prdr_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE prdq_t.* #此變數樣板目前無使用
 
   DEFINE l_detail4    RECORD LIKE prdo_t.* #此變數樣板目前無使用
 
   DEFINE l_detail5    RECORD LIKE prdm_t.* #此變數樣板目前無使用
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE aprm211_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM prdp_t
    WHERE prdpent = g_enterprise AND prdp001 = g_prdl001_t
 
    INTO TEMP aprm211_detail
 
   #將key修正為調整後   
   UPDATE aprm211_detail 
      #更新key欄位
      SET prdp001 = g_prdl_m.prdl001
 
      #更新共用欄位
      #應用 a13 樣板自動產生(Version:4)
      #, prdpstus = "Y" 
 
 
#應用 a13 樣板自動產生(Version:4)
      #, prdrstus = "Y" 
 
 
#應用 a13 樣板自動產生(Version:4)
      #, prdqstus = "Y" 
 
 
#應用 a13 樣板自動產生(Version:4)
      #, prdostus = "Y" 
 
 
#應用 a13 樣板自動產生(Version:4)
      #, prdmstus = "Y" 
 
 
 
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO prdp_t SELECT * FROM aprm211_detail
   
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
   DROP TABLE aprm211_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM prdr_t 
    WHERE prdrent = g_enterprise AND prdr001 = g_prdl001_t
 
    INTO TEMP aprm211_detail
 
   #將key修正為調整後   
   UPDATE aprm211_detail SET prdr001 = g_prdl_m.prdl001
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO prdr_t SELECT * FROM aprm211_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aprm211_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table3.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM prdq_t 
    WHERE prdqent = g_enterprise AND prdq001 = g_prdl001_t
 
    INTO TEMP aprm211_detail
 
   #將key修正為調整後   
   UPDATE aprm211_detail SET prdq001 = g_prdl_m.prdl001
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table3.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO prdq_t SELECT * FROM aprm211_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table3.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aprm211_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table3.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table4.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM prdo_t 
    WHERE prdoent = g_enterprise AND prdo001 = g_prdl001_t
 
    INTO TEMP aprm211_detail
 
   #將key修正為調整後   
   UPDATE aprm211_detail SET prdo001 = g_prdl_m.prdl001
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table4.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO prdo_t SELECT * FROM aprm211_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table4.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aprm211_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table4.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table5.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM prdm_t 
    WHERE prdment = g_enterprise AND prdm001 = g_prdl001_t
 
    INTO TEMP aprm211_detail
 
   #將key修正為調整後   
   UPDATE aprm211_detail SET prdm001 = g_prdl_m.prdl001
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table5.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO prdm_t SELECT * FROM aprm211_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table5.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aprm211_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table5.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_prdl001_t = g_prdl_m.prdl001
 
   
END FUNCTION
 
{</section>}
 
{<section id="aprm211.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aprm211_delete()
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
 
   OPEN aprm211_cl USING g_enterprise,g_prdl_m.prdl001
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aprm211_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aprm211_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aprm211_master_referesh USING g_prdl_m.prdl001 INTO g_prdl_m.prdlunit,g_prdl_m.prdl001,g_prdl_m.prdl002, 
       g_prdl_m.prdl006,g_prdl_m.prdl007,g_prdl_m.prdl027,g_prdl_m.prdl099,g_prdl_m.prdl100,g_prdl_m.prdlstus, 
       g_prdl_m.prdl010,g_prdl_m.prdl011,g_prdl_m.prdl012,g_prdl_m.prdl013,g_prdl_m.prdl038,g_prdl_m.prdl024, 
       g_prdl_m.prdl025,g_prdl_m.prdl026,g_prdl_m.prdl098,g_prdl_m.prdl037,g_prdl_m.prdl034,g_prdl_m.prdl042, 
       g_prdl_m.prdl004,g_prdl_m.prdl005,g_prdl_m.prdl003,g_prdl_m.prdl033,g_prdl_m.prdl008,g_prdl_m.prdl009, 
       g_prdl_m.prdlsite,g_prdl_m.prdlcrtid,g_prdl_m.prdlcrtdp,g_prdl_m.prdlcrtdt,g_prdl_m.prdlownid, 
       g_prdl_m.prdlowndp,g_prdl_m.prdlmodid,g_prdl_m.prdlmoddt,g_prdl_m.prdlcnfid,g_prdl_m.prdlcnfdt, 
       g_prdl_m.prdlunit_desc,g_prdl_m.prdl006_desc,g_prdl_m.prdl007_desc,g_prdl_m.prdl004_desc,g_prdl_m.prdl005_desc, 
       g_prdl_m.prdl033_desc,g_prdl_m.prdl008_desc,g_prdl_m.prdl009_desc,g_prdl_m.prdlcrtid_desc,g_prdl_m.prdlcrtdp_desc, 
       g_prdl_m.prdlownid_desc,g_prdl_m.prdlowndp_desc,g_prdl_m.prdlmodid_desc,g_prdl_m.prdlcnfid_desc 
 
   
   
   #檢查是否允許此動作
   IF NOT aprm211_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_prdl_m_mask_o.* =  g_prdl_m.*
   CALL aprm211_prdl_t_mask()
   LET g_prdl_m_mask_n.* =  g_prdl_m.*
   
   CALL aprm211_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aprm211_set_pk_array()
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
      
      DELETE FROM prdp_t
       WHERE prdpent = g_enterprise AND prdp001 = g_prdl_m.prdl001
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prdp_t:",SQLERRMESSAGE 
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
      DELETE FROM prdr_t
       WHERE prdrent = g_enterprise AND
             prdr001 = g_prdl_m.prdl001
      #add-point:單身刪除中 name="delete.body.m_delete2"
      
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
 
      #add-point:單身刪除後 name="delete.body.a_delete2"
      
      #end add-point
 
      #add-point:單身刪除前 name="delete.body.b_delete3"
      
      #end add-point
      DELETE FROM prdq_t
       WHERE prdqent = g_enterprise AND
             prdq001 = g_prdl_m.prdl001
      #add-point:單身刪除中 name="delete.body.m_delete3"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prdq_t:",SQLERRMESSAGE 
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
      DELETE FROM prdo_t
       WHERE prdoent = g_enterprise AND
             prdo001 = g_prdl_m.prdl001
      #add-point:單身刪除中 name="delete.body.m_delete4"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prdo_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete4"
      
      #end add-point
 
      #add-point:單身刪除前 name="delete.body.b_delete5"
      
      #end add-point
      DELETE FROM prdm_t
       WHERE prdment = g_enterprise AND
             prdm001 = g_prdl_m.prdl001
      #add-point:單身刪除中 name="delete.body.m_delete5"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prdm_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete5"
      
      #end add-point
 
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_prdl_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE aprm211_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_prdp_d.clear() 
      CALL g_prdp2_d.clear()       
      CALL g_prdp3_d.clear()       
      CALL g_prdp4_d.clear()       
      CALL g_prdp5_d.clear()       
 
     
      CALL aprm211_ui_browser_refresh()  
      #CALL aprm211_ui_headershow()  
      #CALL aprm211_ui_detailshow()
 
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
         #CALL aprm211_browser_fill("")
         CALL aprm211_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aprm211_cl
 
   #功能已完成,通報訊息中心
   CALL aprm211_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="aprm211.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aprm211_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_prdp_d.clear()
   CALL g_prdp2_d.clear()
   CALL g_prdp3_d.clear()
   CALL g_prdp4_d.clear()
   CALL g_prdp5_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL g_prdp6_d.clear()
   #end add-point
   
   #判斷是否填充
   IF aprm211_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT prdp002,prdpstus,prdp003,prdp004,prdpsite,prdpunit ,t1.ooefl003 FROM prdp_t", 
                
                     " INNER JOIN prdl_t ON prdlent = " ||g_enterprise|| " AND prdl001 = prdp001 ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=prdp004 AND t1.ooefl002='"||g_dlang||"' ",
 
                     " WHERE prdpent=? AND prdp001=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY prdp_t.prdp002"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aprm211_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR aprm211_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_prdl_m.prdl001   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_prdl_m.prdl001 INTO g_prdp_d[l_ac].prdp002,g_prdp_d[l_ac].prdpstus, 
          g_prdp_d[l_ac].prdp003,g_prdp_d[l_ac].prdp004,g_prdp_d[l_ac].prdpsite,g_prdp_d[l_ac].prdpunit, 
          g_prdp_d[l_ac].prdp004_desc   #(ver:78)
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
   IF aprm211_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT prdrstus,prdr002,prdr011,prdr003,prdr004,prdr005,prdr006,prdr007, 
             prdrsite,prdrunit,prdr010 ,t2.oocql004 ,t3.oocal003 FROM prdr_t",   
                     " INNER JOIN  prdl_t ON prdlent = " ||g_enterprise|| " AND prdl001 = prdr001 ",
 
                     "",
                     
                                    " LEFT JOIN oocql_t t2 ON t2.oocqlent="||g_enterprise||" AND t2.oocql002=prdr004 AND t2.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t3 ON t3.oocalent="||g_enterprise||" AND t3.oocal001=prdr006 AND t3.oocal002='"||g_dlang||"' ",
 
                     " WHERE prdrent=? AND prdr001=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"
         LET g_sql = "SELECT  UNIQUE prdrstus,prdr002,prdr011,prdr003,prdr004,prdr005,prdr006,prdr007, 
             prdrsite,prdrunit,prdr010 ,'',t3.oocal003 FROM prdr_t",   
                     " INNER JOIN prdl_t ON prdl001 = prdr001 ",
               " LEFT JOIN oocal_t t3 ON t3.oocalent='"||g_enterprise||"' AND t3.oocal001=prdr006 AND t3.oocal002='"||g_dlang||"' ",
 
                     " WHERE prdrent=? AND prdr001=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY prdr_t.prdr002,prdr_t.prdr003,prdr_t.prdr004"
         
         #add-point:單身填充控制 name="b_fill.sql2"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aprm211_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR aprm211_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_enterprise,g_prdl_m.prdl001   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_enterprise,g_prdl_m.prdl001 INTO g_prdp2_d[l_ac].prdrstus,g_prdp2_d[l_ac].prdr002, 
          g_prdp2_d[l_ac].prdr011,g_prdp2_d[l_ac].prdr003,g_prdp2_d[l_ac].prdr004,g_prdp2_d[l_ac].prdr005, 
          g_prdp2_d[l_ac].prdr006,g_prdp2_d[l_ac].prdr007,g_prdp2_d[l_ac].prdrsite,g_prdp2_d[l_ac].prdrunit, 
          g_prdp2_d[l_ac].prdr010,g_prdp2_d[l_ac].prdr004_desc,g_prdp2_d[l_ac].prdr006_desc   #(ver:78) 
 
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
   IF aprm211_fill_chk(3) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body3.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT prdqstus,prdq003,prdq004,prdq002,prdqsite,prdqunit ,t4.ooial003 , 
             t5.mmanl003 FROM prdq_t",   
                     " INNER JOIN  prdl_t ON prdlent = " ||g_enterprise|| " AND prdl001 = prdq001 ",
 
                     "",
                     
                                    " LEFT JOIN ooial_t t4 ON t4.ooialent="||g_enterprise||" AND t4.ooial001=prdq003 AND t4.ooial002='"||g_dlang||"' ",
               " LEFT JOIN mmanl_t t5 ON t5.mmanlent="||g_enterprise||" AND t5.mmanl001=prdq004 AND t5.mmanl002='"||g_dlang||"' ",
 
                     " WHERE prdqent=? AND prdq001=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body3.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table3) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY prdq_t.prdq002"
         
         #add-point:單身填充控制 name="b_fill.sql3"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aprm211_pb3 FROM g_sql
         DECLARE b_fill_cs3 CURSOR FOR aprm211_pb3
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs3 USING g_enterprise,g_prdl_m.prdl001   #(ver:78)
                                               
      FOREACH b_fill_cs3 USING g_enterprise,g_prdl_m.prdl001 INTO g_prdp3_d[l_ac].prdqstus,g_prdp3_d[l_ac].prdq003, 
          g_prdp3_d[l_ac].prdq004,g_prdp3_d[l_ac].prdq002,g_prdp3_d[l_ac].prdqsite,g_prdp3_d[l_ac].prdqunit, 
          g_prdp3_d[l_ac].prdq003_desc,g_prdp3_d[l_ac].prdq004_desc   #(ver:78)
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
   IF aprm211_fill_chk(4) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body4.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT prdostus,prdo002,prdo003,prdo004,prdo005,prdo006,prdo007,prdo008, 
             prdosite,prdounit  FROM prdo_t",   
                     " INNER JOIN  prdl_t ON prdlent = " ||g_enterprise|| " AND prdl001 = prdo001 ",
 
                     "",
                     
                     
                     " WHERE prdoent=? AND prdo001=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body4.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table4) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table4 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY prdo_t.prdo002"
         
         #add-point:單身填充控制 name="b_fill.sql4"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aprm211_pb4 FROM g_sql
         DECLARE b_fill_cs4 CURSOR FOR aprm211_pb4
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs4 USING g_enterprise,g_prdl_m.prdl001   #(ver:78)
                                               
      FOREACH b_fill_cs4 USING g_enterprise,g_prdl_m.prdl001 INTO g_prdp4_d[l_ac].prdostus,g_prdp4_d[l_ac].prdo002, 
          g_prdp4_d[l_ac].prdo003,g_prdp4_d[l_ac].prdo004,g_prdp4_d[l_ac].prdo005,g_prdp4_d[l_ac].prdo006, 
          g_prdp4_d[l_ac].prdo007,g_prdp4_d[l_ac].prdo008,g_prdp4_d[l_ac].prdosite,g_prdp4_d[l_ac].prdounit  
            #(ver:78)
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
 
   #判斷是否填充
   IF aprm211_fill_chk(5) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body5.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT prdmstus,prdm004,prdm002,prdm003,prdm005,prdmsite,prdmunit  FROM prdm_t", 
                
                     " INNER JOIN  prdl_t ON prdlent = " ||g_enterprise|| " AND prdl001 = prdm001 ",
 
                     "",
                     
                     
                     " WHERE prdment=? AND prdm001=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body5.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table5) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table5 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY prdm_t.prdm002,prdm_t.prdm004"
         
         #add-point:單身填充控制 name="b_fill.sql5"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aprm211_pb5 FROM g_sql
         DECLARE b_fill_cs5 CURSOR FOR aprm211_pb5
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs5 USING g_enterprise,g_prdl_m.prdl001   #(ver:78)
                                               
      FOREACH b_fill_cs5 USING g_enterprise,g_prdl_m.prdl001 INTO g_prdp5_d[l_ac].prdmstus,g_prdp5_d[l_ac].prdm004, 
          g_prdp5_d[l_ac].prdm002,g_prdp5_d[l_ac].prdm003,g_prdp5_d[l_ac].prdm005,g_prdp5_d[l_ac].prdmsite, 
          g_prdp5_d[l_ac].prdmunit   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill5.fill"
         
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
   #判斷是否填充
  
   CALL aprm211_b6_fill()    
   #end add-point
   
   CALL g_prdp_d.deleteElement(g_prdp_d.getLength())
   CALL g_prdp2_d.deleteElement(g_prdp2_d.getLength())
   CALL g_prdp3_d.deleteElement(g_prdp3_d.getLength())
   CALL g_prdp4_d.deleteElement(g_prdp4_d.getLength())
   CALL g_prdp5_d.deleteElement(g_prdp5_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE aprm211_pb
   FREE aprm211_pb2
 
   FREE aprm211_pb3
 
   FREE aprm211_pb4
 
   FREE aprm211_pb5
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_prdp_d.getLength()
      LET g_prdp_d_mask_o[l_ac].* =  g_prdp_d[l_ac].*
      CALL aprm211_prdp_t_mask()
      LET g_prdp_d_mask_n[l_ac].* =  g_prdp_d[l_ac].*
   END FOR
   
   LET g_prdp2_d_mask_o.* =  g_prdp2_d.*
   FOR l_ac = 1 TO g_prdp2_d.getLength()
      LET g_prdp2_d_mask_o[l_ac].* =  g_prdp2_d[l_ac].*
      CALL aprm211_prdr_t_mask()
      LET g_prdp2_d_mask_n[l_ac].* =  g_prdp2_d[l_ac].*
   END FOR
   LET g_prdp3_d_mask_o.* =  g_prdp3_d.*
   FOR l_ac = 1 TO g_prdp3_d.getLength()
      LET g_prdp3_d_mask_o[l_ac].* =  g_prdp3_d[l_ac].*
      CALL aprm211_prdq_t_mask()
      LET g_prdp3_d_mask_n[l_ac].* =  g_prdp3_d[l_ac].*
   END FOR
   LET g_prdp4_d_mask_o.* =  g_prdp4_d.*
   FOR l_ac = 1 TO g_prdp4_d.getLength()
      LET g_prdp4_d_mask_o[l_ac].* =  g_prdp4_d[l_ac].*
      CALL aprm211_prdo_t_mask()
      LET g_prdp4_d_mask_n[l_ac].* =  g_prdp4_d[l_ac].*
   END FOR
   LET g_prdp5_d_mask_o.* =  g_prdp5_d.*
   FOR l_ac = 1 TO g_prdp5_d.getLength()
      LET g_prdp5_d_mask_o[l_ac].* =  g_prdp5_d[l_ac].*
      CALL aprm211_prdm_t_mask()
      LET g_prdp5_d_mask_n[l_ac].* =  g_prdp5_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="aprm211.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aprm211_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM prdp_t
       WHERE prdpent = g_enterprise AND
         prdp001 = ps_keys_bak[1] AND prdp002 = ps_keys_bak[2]
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
         CALL g_prdp_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM prdr_t
       WHERE prdrent = g_enterprise AND
             prdr001 = ps_keys_bak[1] AND prdr002 = ps_keys_bak[2] AND prdr003 = ps_keys_bak[3] AND prdr004 = ps_keys_bak[4]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
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
      IF ps_page <> "'2'" THEN 
         CALL g_prdp2_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete3"
      
      #end add-point    
      DELETE FROM prdq_t
       WHERE prdqent = g_enterprise AND
             prdq001 = ps_keys_bak[1] AND prdq002 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete3"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prdq_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_prdp3_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete3"
      
      #end add-point    
   END IF
 
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete4"
      
      #end add-point    
      DELETE FROM prdo_t
       WHERE prdoent = g_enterprise AND
             prdo001 = ps_keys_bak[1] AND prdo002 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete4"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prdo_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'4'" THEN 
         CALL g_prdp4_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete4"
      
      #end add-point    
   END IF
 
   LET ls_group = "'5',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete5"
      
      #end add-point    
      DELETE FROM prdm_t
       WHERE prdment = g_enterprise AND
             prdm001 = ps_keys_bak[1] AND prdm002 = ps_keys_bak[2] AND prdm004 = ps_keys_bak[3]
      #add-point:delete_b段刪除中 name="delete_b.m_delete5"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prdm_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'5'" THEN 
         CALL g_prdp5_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete5"
      
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aprm211.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aprm211_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO prdp_t
                  (prdpent,
                   prdp001,
                   prdp002
                   ,prdpstus,prdp003,prdp004,prdpsite,prdpunit) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_prdp_d[g_detail_idx].prdpstus,g_prdp_d[g_detail_idx].prdp003,g_prdp_d[g_detail_idx].prdp004, 
                       g_prdp_d[g_detail_idx].prdpsite,g_prdp_d[g_detail_idx].prdpunit)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prdp_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_prdp_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      
      #end add-point 
      INSERT INTO prdr_t
                  (prdrent,
                   prdr001,
                   prdr002,prdr003,prdr004
                   ,prdrstus,prdr011,prdr005,prdr006,prdr007,prdrsite,prdrunit,prdr010) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
                   ,g_prdp2_d[g_detail_idx].prdrstus,g_prdp2_d[g_detail_idx].prdr011,g_prdp2_d[g_detail_idx].prdr005, 
                       g_prdp2_d[g_detail_idx].prdr006,g_prdp2_d[g_detail_idx].prdr007,g_prdp2_d[g_detail_idx].prdrsite, 
                       g_prdp2_d[g_detail_idx].prdrunit,g_prdp2_d[g_detail_idx].prdr010)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prdr_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_prdp2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert3"
      
      #end add-point 
      INSERT INTO prdq_t
                  (prdqent,
                   prdq001,
                   prdq002
                   ,prdqstus,prdq003,prdq004,prdqsite,prdqunit) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_prdp3_d[g_detail_idx].prdqstus,g_prdp3_d[g_detail_idx].prdq003,g_prdp3_d[g_detail_idx].prdq004, 
                       g_prdp3_d[g_detail_idx].prdqsite,g_prdp3_d[g_detail_idx].prdqunit)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert3"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prdq_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_prdp3_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert3"
      
      #end add-point
   END IF
 
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert4"
      
      #end add-point 
      INSERT INTO prdo_t
                  (prdoent,
                   prdo001,
                   prdo002
                   ,prdostus,prdo003,prdo004,prdo005,prdo006,prdo007,prdo008,prdosite,prdounit) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_prdp4_d[g_detail_idx].prdostus,g_prdp4_d[g_detail_idx].prdo003,g_prdp4_d[g_detail_idx].prdo004, 
                       g_prdp4_d[g_detail_idx].prdo005,g_prdp4_d[g_detail_idx].prdo006,g_prdp4_d[g_detail_idx].prdo007, 
                       g_prdp4_d[g_detail_idx].prdo008,g_prdp4_d[g_detail_idx].prdosite,g_prdp4_d[g_detail_idx].prdounit) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert4"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prdo_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'4'" THEN 
         CALL g_prdp4_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert4"
      
      #end add-point
   END IF
 
   LET ls_group = "'5',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert5"
      
      #end add-point 
      INSERT INTO prdm_t
                  (prdment,
                   prdm001,
                   prdm002,prdm004
                   ,prdmstus,prdm003,prdm005,prdmsite,prdmunit) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_prdp5_d[g_detail_idx].prdmstus,g_prdp5_d[g_detail_idx].prdm003,g_prdp5_d[g_detail_idx].prdm005, 
                       g_prdp5_d[g_detail_idx].prdmsite,g_prdp5_d[g_detail_idx].prdmunit)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert5"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prdm_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'5'" THEN 
         CALL g_prdp5_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert5"
      
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="aprm211.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aprm211_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "prdp_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL aprm211_prdp_t_mask_restore('restore_mask_o')
               
      UPDATE prdp_t 
         SET (prdp001,
              prdp002
              ,prdpstus,prdp003,prdp004,prdpsite,prdpunit) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_prdp_d[g_detail_idx].prdpstus,g_prdp_d[g_detail_idx].prdp003,g_prdp_d[g_detail_idx].prdp004, 
                  g_prdp_d[g_detail_idx].prdpsite,g_prdp_d[g_detail_idx].prdpunit) 
         WHERE prdpent = g_enterprise AND prdp001 = ps_keys_bak[1] AND prdp002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "prdp_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "prdp_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aprm211_prdp_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "prdr_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL aprm211_prdr_t_mask_restore('restore_mask_o')
               
      UPDATE prdr_t 
         SET (prdr001,
              prdr002,prdr003,prdr004
              ,prdrstus,prdr011,prdr005,prdr006,prdr007,prdrsite,prdrunit,prdr010) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
              ,g_prdp2_d[g_detail_idx].prdrstus,g_prdp2_d[g_detail_idx].prdr011,g_prdp2_d[g_detail_idx].prdr005, 
                  g_prdp2_d[g_detail_idx].prdr006,g_prdp2_d[g_detail_idx].prdr007,g_prdp2_d[g_detail_idx].prdrsite, 
                  g_prdp2_d[g_detail_idx].prdrunit,g_prdp2_d[g_detail_idx].prdr010) 
         WHERE prdrent = g_enterprise AND prdr001 = ps_keys_bak[1] AND prdr002 = ps_keys_bak[2] AND prdr003 = ps_keys_bak[3] AND prdr004 = ps_keys_bak[4]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
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
      CALL aprm211_prdr_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update2"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "prdq_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update3"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL aprm211_prdq_t_mask_restore('restore_mask_o')
               
      UPDATE prdq_t 
         SET (prdq001,
              prdq002
              ,prdqstus,prdq003,prdq004,prdqsite,prdqunit) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_prdp3_d[g_detail_idx].prdqstus,g_prdp3_d[g_detail_idx].prdq003,g_prdp3_d[g_detail_idx].prdq004, 
                  g_prdp3_d[g_detail_idx].prdqsite,g_prdp3_d[g_detail_idx].prdqunit) 
         WHERE prdqent = g_enterprise AND prdq001 = ps_keys_bak[1] AND prdq002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update3"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "prdq_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "prdq_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aprm211_prdq_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update3"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "prdo_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update4"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL aprm211_prdo_t_mask_restore('restore_mask_o')
               
      UPDATE prdo_t 
         SET (prdo001,
              prdo002
              ,prdostus,prdo003,prdo004,prdo005,prdo006,prdo007,prdo008,prdosite,prdounit) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_prdp4_d[g_detail_idx].prdostus,g_prdp4_d[g_detail_idx].prdo003,g_prdp4_d[g_detail_idx].prdo004, 
                  g_prdp4_d[g_detail_idx].prdo005,g_prdp4_d[g_detail_idx].prdo006,g_prdp4_d[g_detail_idx].prdo007, 
                  g_prdp4_d[g_detail_idx].prdo008,g_prdp4_d[g_detail_idx].prdosite,g_prdp4_d[g_detail_idx].prdounit)  
 
         WHERE prdoent = g_enterprise AND prdo001 = ps_keys_bak[1] AND prdo002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update4"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "prdo_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "prdo_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aprm211_prdo_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update4"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'5',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "prdm_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update5"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL aprm211_prdm_t_mask_restore('restore_mask_o')
               
      UPDATE prdm_t 
         SET (prdm001,
              prdm002,prdm004
              ,prdmstus,prdm003,prdm005,prdmsite,prdmunit) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_prdp5_d[g_detail_idx].prdmstus,g_prdp5_d[g_detail_idx].prdm003,g_prdp5_d[g_detail_idx].prdm005, 
                  g_prdp5_d[g_detail_idx].prdmsite,g_prdp5_d[g_detail_idx].prdmunit) 
         WHERE prdment = g_enterprise AND prdm001 = ps_keys_bak[1] AND prdm002 = ps_keys_bak[2] AND prdm004 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update5"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "prdm_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "prdm_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aprm211_prdm_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update5"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
 
   
 
   
   #add-point:update_b段other name="update_b.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aprm211.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION aprm211_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="aprm211.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION aprm211_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="aprm211.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aprm211_lock_b(ps_table,ps_page)
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
   #CALL aprm211_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "prdp_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN aprm211_bcl USING g_enterprise,
                                       g_prdl_m.prdl001,g_prdp_d[g_detail_idx].prdp002     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aprm211_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "prdr_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aprm211_bcl2 USING g_enterprise,
                                             g_prdl_m.prdl001,g_prdp2_d[g_detail_idx].prdr002,g_prdp2_d[g_detail_idx].prdr003, 
                                                 g_prdp2_d[g_detail_idx].prdr004
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aprm211_bcl2:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'3',"
   #僅鎖定自身table
   LET ls_group = "prdq_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aprm211_bcl3 USING g_enterprise,
                                             g_prdl_m.prdl001,g_prdp3_d[g_detail_idx].prdq002
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aprm211_bcl3:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'4',"
   #僅鎖定自身table
   LET ls_group = "prdo_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aprm211_bcl4 USING g_enterprise,
                                             g_prdl_m.prdl001,g_prdp4_d[g_detail_idx].prdo002
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aprm211_bcl4:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'5',"
   #僅鎖定自身table
   LET ls_group = "prdm_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aprm211_bcl5 USING g_enterprise,
                                             g_prdl_m.prdl001,g_prdp5_d[g_detail_idx].prdm002,g_prdp5_d[g_detail_idx].prdm004 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aprm211_bcl5:",SQLERRMESSAGE 
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
 
{<section id="aprm211.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aprm211_unlock_b(ps_table,ps_page)
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
      CLOSE aprm211_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aprm211_bcl2
   END IF
 
   LET ls_group = "'3',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aprm211_bcl3
   END IF
 
   LET ls_group = "'4',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aprm211_bcl4
   END IF
 
   LET ls_group = "'5',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aprm211_bcl5
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="aprm211.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aprm211_set_entry(p_cmd)
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
   CALL cl_set_comp_entry("prdl001",TRUE)
   CALL cl_set_comp_entry("prdb005_1",TRUE)
   CALL cl_set_comp_entry("prdb005_2",TRUE)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aprm211.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aprm211_set_no_entry(p_cmd)
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
   IF g_prdl_m.prdl026 = '1' THEN
      CALL cl_set_comp_entry("prdb005_2",FALSE)
      LET g_prdl_m.prdb005_2 = ''
   END IF
   IF g_prdl_m.prdl026 = '2' THEN
      CALL cl_set_comp_entry("prdb005_1",FALSE)
      LET g_prdl_m.prdb005_1 = ''
   END IF
#   IF NOT cl_null(g_prdl_m.prdl001) AND g_prdl_m.prda000 = 'I' THEN
#      CALL cl_set_comp_entry("prdl001",FALSE)
#   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aprm211.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aprm211_set_entry_b(p_cmd)
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
   CALL cl_set_comp_entry("prdq004",TRUE)
   CALL cl_set_comp_entry("prdr005",TRUE)
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="aprm211.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aprm211_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point    
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   DEFINE l_ooia002       LIKE ooia_t.ooia002
   #end add-point    
   
   #add-point:Function前置處理  name="set_no_entry_b.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("",FALSE)
      #add-point:set_no_entry_b段欄位控制 name="set_no_entry_b.field_control"
      
      #end add-point 
   END IF 
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b"
   LET l_ooia002 = ''
   IF NOT cl_null(g_prdp3_d[l_ac].prdq003) THEN
      SELECT ooia002 INTO l_ooia002
        FROM ooia_t
       WHERE ooiaent = g_enterprise
         AND ooia001 = g_prdp3_d[l_ac].prdq003
   END IF
   IF l_ooia002 <> '40' AND l_ooia002 <> '60' THEN
      CALL cl_set_comp_entry("prdq004",FALSE)
      LET g_prdp3_d[l_ac].prdq004 = ""
   END IF    
  #IF g_prdp2_d[l_ac].prdr003 <> '4' THEN        #160819-00054#16 161013 by lori mark
   IF g_prdp2_d[l_ac].prdr003 <> '15' THEN       #160819-00054#16 161013 by lori add
      CALL cl_set_comp_entry("prdr005",FALSE)
      LET g_prdp2_d[l_ac].prdr005 = ""
   END IF
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="aprm211.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aprm211_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aprm211.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aprm211_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   CALL cl_set_act_visible("object", FALSE)
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aprm211.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION aprm211_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aprm211.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION aprm211_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aprm211.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aprm211_default_search()
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
 
         INITIALIZE g_wc2_table4 TO NULL
 
         INITIALIZE g_wc2_table5 TO NULL
 
 
         FOR li_idx = 1 TO la_wc.getLength()
            CASE
               WHEN la_wc[li_idx].tableid = "prdl_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "prdp_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "prdr_t" 
                  LET g_wc2_table2 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "prdq_t" 
                  LET g_wc2_table3 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "prdo_t" 
                  LET g_wc2_table4 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "prdm_t" 
                  LET g_wc2_table5 = la_wc[li_idx].wc
 
 
               WHEN la_wc[li_idx].tableid = "EXTENDWC"
                  LET g_wc2_extend = la_wc[li_idx].wc
            END CASE
         END FOR
         IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
            OR NOT cl_null(g_wc2_table2)
 
            OR NOT cl_null(g_wc2_table3)
 
            OR NOT cl_null(g_wc2_table4)
 
            OR NOT cl_null(g_wc2_table5)
 
 
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
 
            IF g_wc2_table5 <> " 1=1" AND NOT cl_null(g_wc2_table5) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table5
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
 
{<section id="aprm211.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION aprm211_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
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
   
   OPEN aprm211_cl USING g_enterprise,g_prdl_m.prdl001
   IF STATUS THEN
      CLOSE aprm211_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aprm211_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE aprm211_master_referesh USING g_prdl_m.prdl001 INTO g_prdl_m.prdlunit,g_prdl_m.prdl001,g_prdl_m.prdl002, 
       g_prdl_m.prdl006,g_prdl_m.prdl007,g_prdl_m.prdl027,g_prdl_m.prdl099,g_prdl_m.prdl100,g_prdl_m.prdlstus, 
       g_prdl_m.prdl010,g_prdl_m.prdl011,g_prdl_m.prdl012,g_prdl_m.prdl013,g_prdl_m.prdl038,g_prdl_m.prdl024, 
       g_prdl_m.prdl025,g_prdl_m.prdl026,g_prdl_m.prdl098,g_prdl_m.prdl037,g_prdl_m.prdl034,g_prdl_m.prdl042, 
       g_prdl_m.prdl004,g_prdl_m.prdl005,g_prdl_m.prdl003,g_prdl_m.prdl033,g_prdl_m.prdl008,g_prdl_m.prdl009, 
       g_prdl_m.prdlsite,g_prdl_m.prdlcrtid,g_prdl_m.prdlcrtdp,g_prdl_m.prdlcrtdt,g_prdl_m.prdlownid, 
       g_prdl_m.prdlowndp,g_prdl_m.prdlmodid,g_prdl_m.prdlmoddt,g_prdl_m.prdlcnfid,g_prdl_m.prdlcnfdt, 
       g_prdl_m.prdlunit_desc,g_prdl_m.prdl006_desc,g_prdl_m.prdl007_desc,g_prdl_m.prdl004_desc,g_prdl_m.prdl005_desc, 
       g_prdl_m.prdl033_desc,g_prdl_m.prdl008_desc,g_prdl_m.prdl009_desc,g_prdl_m.prdlcrtid_desc,g_prdl_m.prdlcrtdp_desc, 
       g_prdl_m.prdlownid_desc,g_prdl_m.prdlowndp_desc,g_prdl_m.prdlmodid_desc,g_prdl_m.prdlcnfid_desc 
 
   
 
   #檢查是否允許此動作
   IF NOT aprm211_action_chk() THEN
      CLOSE aprm211_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_prdl_m.prdlunit,g_prdl_m.prdlunit_desc,g_prdl_m.prdl001,g_prdl_m.prdl002,g_prdl_m.prdll003, 
       g_prdl_m.prdl006,g_prdl_m.prdl006_desc,g_prdl_m.prdl007,g_prdl_m.prdl007_desc,g_prdl_m.prdl027, 
       g_prdl_m.prdl099,g_prdl_m.prdl100,g_prdl_m.prdlstus,g_prdl_m.prdl010,g_prdl_m.prdl011,g_prdl_m.prdl012, 
       g_prdl_m.prdl013,g_prdl_m.prdl038,g_prdl_m.prdl024,g_prdl_m.prdl025,g_prdl_m.prdl026,g_prdl_m.l_prdo003_1, 
       g_prdl_m.l_prdo004_1,g_prdl_m.prdl098,g_prdl_m.prdl037,g_prdl_m.prdl034,g_prdl_m.prdl042,g_prdl_m.prdl004, 
       g_prdl_m.prdl004_desc,g_prdl_m.prdl005,g_prdl_m.prdl005_desc,g_prdl_m.prdb005_1,g_prdl_m.prdo005_1, 
       g_prdl_m.prdo006_1,g_prdl_m.prdl003,g_prdl_m.prdl033,g_prdl_m.prdl033_desc,g_prdl_m.prdl008,g_prdl_m.prdl008_desc, 
       g_prdl_m.prdl009,g_prdl_m.prdl009_desc,g_prdl_m.prdb005_2,g_prdl_m.prdo007_1,g_prdl_m.prdo008_1, 
       g_prdl_m.prdlsite,g_prdl_m.prdlcrtid,g_prdl_m.prdlcrtid_desc,g_prdl_m.prdlcrtdp,g_prdl_m.prdlcrtdp_desc, 
       g_prdl_m.prdlcrtdt,g_prdl_m.prdlownid,g_prdl_m.prdlownid_desc,g_prdl_m.prdlowndp,g_prdl_m.prdlowndp_desc, 
       g_prdl_m.prdlmodid,g_prdl_m.prdlmodid_desc,g_prdl_m.prdlmoddt,g_prdl_m.prdlcnfid,g_prdl_m.prdlcnfid_desc, 
       g_prdl_m.prdlcnfdt
 
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
      CLOSE aprm211_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
#   LET l_success = TRUE
#   CALL s_transaction_begin()
#   IF lc_state = 'Y' THEN
#      CALL s_aprt211_conf_chk(g_prdl_m.prdadocno,g_prdl_m.prdlstus) RETURNING l_success,g_errno
#      IF NOT l_success THEN
#         CALL cl_err(g_prdl_m.prdadocno,g_errno,1)
#         CALL s_transaction_end('N','0')
#         RETURN
#      ELSE
#         IF NOT cl_ask_confirm('aim-00108') THEN
#            CALL s_transaction_end('N','0')
#            RETURN
#         ELSE
#            CALL s_aprt211_conf_upd(g_prdl_m.prdadocno,g_prdl_m.prdlstus) RETURNING l_success
#            IF NOT l_success THEN
#               CALL s_transaction_end('N','0')
#               RETURN
#            END IF
#         END IF
#      END IF
#   END IF
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
      EXECUTE aprm211_master_referesh USING g_prdl_m.prdl001 INTO g_prdl_m.prdlunit,g_prdl_m.prdl001, 
          g_prdl_m.prdl002,g_prdl_m.prdl006,g_prdl_m.prdl007,g_prdl_m.prdl027,g_prdl_m.prdl099,g_prdl_m.prdl100, 
          g_prdl_m.prdlstus,g_prdl_m.prdl010,g_prdl_m.prdl011,g_prdl_m.prdl012,g_prdl_m.prdl013,g_prdl_m.prdl038, 
          g_prdl_m.prdl024,g_prdl_m.prdl025,g_prdl_m.prdl026,g_prdl_m.prdl098,g_prdl_m.prdl037,g_prdl_m.prdl034, 
          g_prdl_m.prdl042,g_prdl_m.prdl004,g_prdl_m.prdl005,g_prdl_m.prdl003,g_prdl_m.prdl033,g_prdl_m.prdl008, 
          g_prdl_m.prdl009,g_prdl_m.prdlsite,g_prdl_m.prdlcrtid,g_prdl_m.prdlcrtdp,g_prdl_m.prdlcrtdt, 
          g_prdl_m.prdlownid,g_prdl_m.prdlowndp,g_prdl_m.prdlmodid,g_prdl_m.prdlmoddt,g_prdl_m.prdlcnfid, 
          g_prdl_m.prdlcnfdt,g_prdl_m.prdlunit_desc,g_prdl_m.prdl006_desc,g_prdl_m.prdl007_desc,g_prdl_m.prdl004_desc, 
          g_prdl_m.prdl005_desc,g_prdl_m.prdl033_desc,g_prdl_m.prdl008_desc,g_prdl_m.prdl009_desc,g_prdl_m.prdlcrtid_desc, 
          g_prdl_m.prdlcrtdp_desc,g_prdl_m.prdlownid_desc,g_prdl_m.prdlowndp_desc,g_prdl_m.prdlmodid_desc, 
          g_prdl_m.prdlcnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_prdl_m.prdlunit,g_prdl_m.prdlunit_desc,g_prdl_m.prdl001,g_prdl_m.prdl002,g_prdl_m.prdll003, 
          g_prdl_m.prdl006,g_prdl_m.prdl006_desc,g_prdl_m.prdl007,g_prdl_m.prdl007_desc,g_prdl_m.prdl027, 
          g_prdl_m.prdl099,g_prdl_m.prdl100,g_prdl_m.prdlstus,g_prdl_m.prdl010,g_prdl_m.prdl011,g_prdl_m.prdl012, 
          g_prdl_m.prdl013,g_prdl_m.prdl038,g_prdl_m.prdl024,g_prdl_m.prdl025,g_prdl_m.prdl026,g_prdl_m.l_prdo003_1, 
          g_prdl_m.l_prdo004_1,g_prdl_m.prdl098,g_prdl_m.prdl037,g_prdl_m.prdl034,g_prdl_m.prdl042,g_prdl_m.prdl004, 
          g_prdl_m.prdl004_desc,g_prdl_m.prdl005,g_prdl_m.prdl005_desc,g_prdl_m.prdb005_1,g_prdl_m.prdo005_1, 
          g_prdl_m.prdo006_1,g_prdl_m.prdl003,g_prdl_m.prdl033,g_prdl_m.prdl033_desc,g_prdl_m.prdl008, 
          g_prdl_m.prdl008_desc,g_prdl_m.prdl009,g_prdl_m.prdl009_desc,g_prdl_m.prdb005_2,g_prdl_m.prdo007_1, 
          g_prdl_m.prdo008_1,g_prdl_m.prdlsite,g_prdl_m.prdlcrtid,g_prdl_m.prdlcrtid_desc,g_prdl_m.prdlcrtdp, 
          g_prdl_m.prdlcrtdp_desc,g_prdl_m.prdlcrtdt,g_prdl_m.prdlownid,g_prdl_m.prdlownid_desc,g_prdl_m.prdlowndp, 
          g_prdl_m.prdlowndp_desc,g_prdl_m.prdlmodid,g_prdl_m.prdlmodid_desc,g_prdl_m.prdlmoddt,g_prdl_m.prdlcnfid, 
          g_prdl_m.prdlcnfid_desc,g_prdl_m.prdlcnfdt
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
 
   CLOSE aprm211_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aprm211_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aprm211.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION aprm211_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_prdp_d.getLength() THEN
         LET g_detail_idx = g_prdp_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_prdp_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_prdp_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_prdp2_d.getLength() THEN
         LET g_detail_idx = g_prdp2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_prdp2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_prdp2_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_prdp3_d.getLength() THEN
         LET g_detail_idx = g_prdp3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_prdp3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_prdp3_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 4 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail4")
      IF g_detail_idx > g_prdp4_d.getLength() THEN
         LET g_detail_idx = g_prdp4_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_prdp4_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_prdp4_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 5 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail5")
      IF g_detail_idx > g_prdp5_d.getLength() THEN
         LET g_detail_idx = g_prdp5_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_prdp5_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_prdp5_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   IF g_current_page = 6 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail6")
      IF g_detail_idx > g_prdp6_d.getLength() THEN
         LET g_detail_idx = g_prdp6_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_prdp6_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_prdp6_d.getLength() TO FORMONLY.cnt
   END IF
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aprm211.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aprm211_b_fill2(pi_idx)
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
   
   CALL aprm211_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="aprm211.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION aprm211_fill_chk(ps_idx)
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
      (cl_null(g_wc2_table4) OR g_wc2_table4.trim() = '1=1')  AND 
      (cl_null(g_wc2_table5) OR g_wc2_table5.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk name="fill_chk.other_chk"
      
      #end add-point
      RETURN TRUE
   END IF
   
   #add-point:fill_chk段after_chk name="fill_chk.after_chk"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aprm211.status_show" >}
PRIVATE FUNCTION aprm211_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aprm211.mask_functions" >}
&include "erp/apr/aprm211_mask.4gl"
 
{</section>}
 
{<section id="aprm211.signature" >}
   
 
{</section>}
 
{<section id="aprm211.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aprm211_set_pk_array()
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
 
{<section id="aprm211.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="aprm211.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aprm211_msgcentre_notify(lc_state)
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
   CALL aprm211_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_prdl_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aprm211.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION aprm211_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aprm211.other_function" readonly="Y" >}
################################################################################
# Descriptions...: 單頭帶值欄位顯示
# Memo...........:
# Usage..........: CALL aprm211_desc()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/13 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aprm211_desc()
  
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
   LET g_ref_fields[1] = g_prdl_m.prdl033
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '2135' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prdl_m.prdl033_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prdl_m.prdl033_desc

   
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
################################################################################
# Descriptions...: prde單身帶值欄位顯示
# Memo...........:
# Usage..........: CALL aprm211_prdp_desc()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/13 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aprm211_prdp_desc()
   
   LET g_prdp_d[l_ac].prdp004_desc = ''
   IF g_prdp_d[l_ac].prdp003 = '1' THEN
      SELECT rtaal003 INTO g_prdp_d[l_ac].prdp004_desc
        FROM rtaal_t
       WHERE rtaalent = g_enterprise
         AND rtaal001 = g_prdp_d[l_ac].prdp004
         AND rtaal002 = g_dlang
   ELSE
      SELECT ooefl003 INTO g_prdp_d[l_ac].prdp004_desc
        FROM ooefl_t
       WHERE ooeflent = g_enterprise
         AND ooefl001 = g_prdp_d[l_ac].prdp004
         AND ooefl002 = g_dlang
   END IF
   
END FUNCTION
################################################################################
# Descriptions...: prdg單身帶值欄位顯示
# Memo...........:
# Usage..........: CALL aprm211_prdr_desc()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/13 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aprm211_prdr_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prdp2_d[l_ac].prdr006
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prdp2_d[l_ac].prdr006_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prdp2_d[l_ac].prdr006_desc
   
   IF g_prdp2_d[l_ac].prdr003 = '4' OR g_prdp2_d[l_ac].prdr003 = '15' THEN   #160819-00054#16 161013 by lori add:prdr003=15
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prdp2_d[l_ac].prdr004
      CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prdp2_d[l_ac].prdr004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prdp2_d[l_ac].prdr004_desc
   END IF
   IF g_prdp2_d[l_ac].prdr003 = '5' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prdp2_d[l_ac].prdr004
      CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prdp2_d[l_ac].prdr004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prdp2_d[l_ac].prdr004_desc
   END IF
   IF g_prdp2_d[l_ac].prdr003 = '6' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prdp2_d[l_ac].prdr004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2000' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prdp2_d[l_ac].prdr004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prdp2_d[l_ac].prdr004_desc
   END IF
   IF g_prdp2_d[l_ac].prdr003 = '7' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prdp2_d[l_ac].prdr004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2001' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prdp2_d[l_ac].prdr004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prdp2_d[l_ac].prdr004_desc
   END IF
   IF g_prdp2_d[l_ac].prdr003 = '8' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prdp2_d[l_ac].prdr004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2002' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prdp2_d[l_ac].prdr004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prdp2_d[l_ac].prdr004_desc
   END IF
   IF g_prdp2_d[l_ac].prdr003 = '9' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prdp2_d[l_ac].prdr004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2003' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prdp2_d[l_ac].prdr004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prdp2_d[l_ac].prdr004_desc
   END IF
   IF g_prdp2_d[l_ac].prdr003 = 'A' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prdp2_d[l_ac].prdr004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2004' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prdp2_d[l_ac].prdr004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prdp2_d[l_ac].prdr004_desc
   END IF
   IF g_prdp2_d[l_ac].prdr003 = 'B' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prdp2_d[l_ac].prdr004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2005' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prdp2_d[l_ac].prdr004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prdp2_d[l_ac].prdr004_desc
   END IF
   IF g_prdp2_d[l_ac].prdr003 = 'C' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prdp2_d[l_ac].prdr004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2006' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prdp2_d[l_ac].prdr004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prdp2_d[l_ac].prdr004_desc
   END IF
   IF g_prdp2_d[l_ac].prdr003 = 'D' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prdp2_d[l_ac].prdr004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2007' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prdp2_d[l_ac].prdr004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prdp2_d[l_ac].prdr004_desc
   END IF
   IF g_prdp2_d[l_ac].prdr003 = 'E' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prdp2_d[l_ac].prdr004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2008' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prdp2_d[l_ac].prdr004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prdp2_d[l_ac].prdr004_desc
   END IF
   IF g_prdp2_d[l_ac].prdr003 = 'F' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prdp2_d[l_ac].prdr004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2009' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prdp2_d[l_ac].prdr004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prdp2_d[l_ac].prdr004_desc
   END IF
   IF g_prdp2_d[l_ac].prdr003 = 'G' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prdp2_d[l_ac].prdr004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2010' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prdp2_d[l_ac].prdr004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prdp2_d[l_ac].prdr004_desc
   END IF
   IF g_prdp2_d[l_ac].prdr003 = 'H' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prdp2_d[l_ac].prdr004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2011' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prdp2_d[l_ac].prdr004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prdp2_d[l_ac].prdr004_desc
   END IF
   IF g_prdp2_d[l_ac].prdr003 = 'I' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prdp2_d[l_ac].prdr004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2012' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prdp2_d[l_ac].prdr004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prdp2_d[l_ac].prdr004_desc
   END IF
   IF g_prdp2_d[l_ac].prdr003 = 'J' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prdp2_d[l_ac].prdr004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2013' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prdp2_d[l_ac].prdr004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prdp2_d[l_ac].prdr004_desc
   END IF
   IF g_prdp2_d[l_ac].prdr003 = 'K' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prdp2_d[l_ac].prdr004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2014' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prdp2_d[l_ac].prdr004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prdp2_d[l_ac].prdr004_desc
   END IF
   IF g_prdp2_d[l_ac].prdr003 = 'L' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prdp2_d[l_ac].prdr004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2015' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prdp2_d[l_ac].prdr004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prdp2_d[l_ac].prdr004_desc
   END IF
    ##add by zn --str #160728-00006#24
   IF  g_prdp2_d[l_ac].prdr003 = '14' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prdp2_d[l_ac].prdr004
      CALL ap_ref_array2(g_ref_fields,"SELECT mhbel003 FROM mhbel_t WHERE mhbelent="||g_enterprise||" AND mhbel001=? AND mhbel002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prdp2_d[l_ac].prdr004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prdp2_d[l_ac].prdr004_desc
   END IF   
   ##add by zn --end
END FUNCTION
################################################################################
# Descriptions...: prdf單身帶值欄位顯示
# Memo...........:
# Usage..........: CALL aprm211_prdq_desc()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/13 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aprm211_prdq_desc()
DEFINE l_ooia002     LIKE ooia_t.ooia002

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prdp3_d[l_ac].prdq003
   CALL ap_ref_array2(g_ref_fields,"SELECT ooial003 FROM ooial_t WHERE ooialent='"||g_enterprise||"' AND ooial001=? AND ooial002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prdp3_d[l_ac].prdq003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prdp3_d[l_ac].prdq003_desc
   
   IF NOT cl_null(g_prdp3_d[l_ac].prdq003) THEN
      SELECT ooia002 INTO l_ooia002
        FROM ooia_t
       WHERE ooiaent = g_enterprise
         AND ooia001 = g_prdp3_d[l_ac].prdq003
      IF l_ooia002 = '40' THEN #券
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prdp3_d[l_ac].prdq004
         CALL ap_ref_array2(g_ref_fields,"SELECT gcafl003 FROM gcafl_t WHERE gcaflent='"||g_enterprise||"' AND gcafl001=? AND gcafl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prdp3_d[l_ac].prdq004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prdp3_d[l_ac].prdq004_desc
      END IF
      IF l_ooia002 = '60' THEN #卡
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prdp3_d[l_ac].prdq004
         CALL ap_ref_array2(g_ref_fields,"SELECT mmanl003 FROM mmanl_t WHERE mmanlent='"||g_enterprise||"' AND mmanl001=? AND mmanl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prdp3_d[l_ac].prdq004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prdp3_d[l_ac].prdq004_desc
      END IF
   END IF
END FUNCTION
################################################################################
# Descriptions...: 促銷方案帶值
# Memo...........:
# Usage..........: CALL aprm211_prdl006_def()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/14 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aprm211_prdl006_def()
DEFINE l_sql             STRING
DEFINE l_prdp002         LIKE prdp_t.prdp002
#DEFINE l_prce            RECORD LIKE prce_t.*  161111-00028#2-mark
#161111-00028#2---add----begin-----------
DEFINE l_prce RECORD  #活動計劃生效組織資料檔
       prceent LIKE prce_t.prceent, #企業編號
       prceunit LIKE prce_t.prceunit, #應用組織
       prcesite LIKE prce_t.prcesite, #營運據點
       prce001 LIKE prce_t.prce001, #活動計劃
       prce002 LIKE prce_t.prce002, #類型
       prce003 LIKE prce_t.prce003, #店群/門店
       prceacti LIKE prce_t.prceacti #有效否
END RECORD
#161111-00028#2---add----end-----------


   SELECT prcf002,prcf007,prcf008,prcf009,prcf010
     INTO g_prdl_m.prdl007,g_prdl_m.prdl008,g_prdl_m.prdl009,g_prdl_m.l_prdo003_1,g_prdl_m.l_prdo004_1
     FROM prcf_t
    WHERE prcfent = g_enterprise
      AND prcf001 = g_prdl_m.prdl006
   DISPLAY BY NAME g_prdl_m.prdl007,g_prdl_m.prdl008,g_prdl_m.prdl009,g_prdl_m.l_prdo003_1,g_prdl_m.l_prdo004_1
   IF NOT cl_null(g_prdl_m.prdl007) THEN
#      DELETE FROM prdp_t WHERE prdpent = g_enterprise AND prdedocno = g_prdl_m.prdadocno
      LET l_prdp002 = 1
     #LET l_sql = " SELECT * FROM prce_t",   161111-00028#2-mark
      LET l_sql = " SELECT prceent,prceunit,prcesite,prce001,prce002,prce003,prceacti FROM prce_t",   #161111-00028#2-add
                  "  WHERE prceent = '",g_enterprise,"'",
                  "    AND prce001 = '",g_prdl_m.prdl007,"'"
      PREPARE aprm211_sel_prce_pre FROM l_sql
      DECLARE aprm211_sel_prce_cur CURSOR FOR aprm211_sel_prce_pre
      FOREACH aprm211_sel_prce_cur INTO l_prce.*
#         INSERT INTO prdp_t(prdpent,prdpunit,prdpsite,prdedocno,prdp001,prdp002,prdp003,prdp004,prdeacti)
#                     VALUES(g_enterprise,g_site,g_site,g_prdl_m.prdadocno,g_prdl_m.prdl001,l_prdp002,l_prce.prce002,l_prce.prce003,l_prce.prceacti)
         LET l_prdp002 = l_prdp002+1            
      END FOREACH
      CALL aprm211_b_fill() 
   END IF
END FUNCTION
################################################################################
# Descriptions...: 活动方案帶值
# Memo...........:
# Usage..........: CALL aprm211_prdl007_def()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/14 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aprm211_prdl007_def()
DEFINE l_sql             STRING
DEFINE l_prdp002         LIKE prdp_t.prdp002
#DEFINE l_prce            RECORD LIKE prce_t.*  161111-00028#2-mark
#161111-00028#2---add----begin-----------
DEFINE l_prce RECORD  #活動計劃生效組織資料檔
       prceent LIKE prce_t.prceent, #企業編號
       prceunit LIKE prce_t.prceunit, #應用組織
       prcesite LIKE prce_t.prcesite, #營運據點
       prce001 LIKE prce_t.prce001, #活動計劃
       prce002 LIKE prce_t.prce002, #類型
       prce003 LIKE prce_t.prce003, #店群/門店
       prceacti LIKE prce_t.prceacti #有效否
END RECORD
#161111-00028#2---add----end-----------



   IF cl_null(g_prdl_m.prdl006) THEN
      SELECT prcd002,prcd003,prcd004,prcd005 
        INTO g_prdl_m.prdl008,g_prdl_m.prdl009,g_prdl_m.l_prdo003_1,g_prdl_m.l_prdo004_1
        FROM prcd_t
       WHERE prcdent = g_enterprise
         AND prcd001 = g_prdl_m.prdl007
      DISPLAY BY NAME g_prdl_m.prdl008,g_prdl_m.prdl009,g_prdl_m.l_prdo003_1,g_prdl_m.l_prdo004_1
#      DELETE FROM prdp_t WHERE prdpent = g_enterprise AND prdedocno = g_prdl_m.prdadocno
      LET l_prdp002 = 1
      #LET l_sql = " SELECT * FROM prce_t",   161111-00028#2-mark
      LET l_sql = " SELECT prceent,prceunit,prcesite,prce001,prce002,prce003,prceacti FROM prce_t",   #161111-00028#2-add
                  "  WHERE prceent = '",g_enterprise,"'",
                  "    AND prce001 = '",g_prdl_m.prdl007,"'"
      PREPARE aprm211_sel_prce_pre1 FROM l_sql
      DECLARE aprm211_sel_prce_cur1 CURSOR FOR aprm211_sel_prce_pre1
      FOREACH aprm211_sel_prce_cur1 INTO l_prce.*
#         INSERT INTO prdp_t(prdpent,prdpunit,prdpsite,prdedocno,prdp001,prdp002,prdp003,prdp004,prdeacti)
#                     VALUES(g_enterprise,g_site,g_site,g_prdl_m.prdadocno,g_prdl_m.prdl001,l_prdp002,l_prce.prce002,l_prce.prce003,l_prce.prceacti)
         LET l_prdp002 = l_prdp002+1            
      END FOREACH
      CALL aprm211_b_fill()  
   END IF
END FUNCTION
################################################################################
# Descriptions...: 单头栏位必输关闭
# Memo...........:
# Usage..........: CALL aprm211_set_no_required(p_cmd)
# Input parameter: p_cmd          新增/修改标识符
# Return code....: 無
# Date & Author..: 2014/03/14 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aprm211_set_no_required(p_cmd)
DEFINE p_cmd   LIKE type_t.chr1

   CALL cl_set_comp_required("prdl006",FALSE)
END FUNCTION
###############################################################################
# Descriptions...: 单头栏位必输
# Memo...........:
# Usage..........: CALL aprm211_set_required(p_cmd)
# Input parameter: p_cmd          新增/修改标识符
# Return code....: 無
# Date & Author..: 2014/03/14 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aprm211_set_required(p_cmd)
DEFINE p_cmd        LIKE type_t.chr1
DEFINE l_prcd006    LIKE prcd_t.prcd006  

   IF NOT cl_null(g_prdl_m.prdl007) THEN  
      LET l_prcd006 = ''
      SELECT prcd006 INTO l_prcd006
        FROM prcd_t
       WHERE prcdent = g_enterprise
         AND prcd001 = g_prdl_m.prdl007
      IF l_prcd006 = 'Y' THEN
         CALL cl_set_comp_required("prdl006",TRUE)
      END IF
   END IF   
END FUNCTION
################################################################################
# Descriptions...: 檢查促銷方案對應的活動計劃是否和現在的活動計劃相同
# Memo...........:
# Usage..........: CALL aprm211_chk_prdl006_007()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/14 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aprm211_chk_prdl006_007()
DEFINE l_prcf002        LIKE prcf_t.prcf002

   LET g_errno = ''
   SELECT prcf002 INTO l_prcf002
     FROM prcf_t
    WHERE prcfent = g_enterprise
      AND prcf001 = g_prdl_m.prdl006
   IF l_prcf002 <> g_prdl_m.prdl007 THEN
      LET g_errno = 'apr-00065'
   END IF
END FUNCTION
################################################################################
# Descriptions...: 畫面UI的呈現方式
# Memo...........:
# Usage..........: CALL aprm211_set_comp_visible()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/14 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aprm211_set_comp_visible()
   CALL cl_set_comp_visible('bpage2',TRUE)
   IF g_prdl_m.prdl010 = 'Y' THEN
      CALL cl_set_comp_visible('bpage2',FALSE)
   END IF
   CALL cl_set_comp_visible('bpage3',FALSE)
   IF g_prdl_m.prdl011 = 'Y' THEN
      CALL cl_set_comp_visible('bpage3',TRUE)
   END IF
   CALL cl_set_comp_visible('bpage4',TRUE)
   CALL cl_set_comp_visible('lbl_prdo003',TRUE)
   CALL cl_set_comp_visible('l_prdo003_1',TRUE)
   CALL cl_set_comp_visible('lbl_prdo004',TRUE)
   CALL cl_set_comp_visible('l_prdo004_1',TRUE)
   CALL cl_set_comp_visible('lbl_prdo005',TRUE)
   CALL cl_set_comp_visible('prdo005_1',TRUE)
   CALL cl_set_comp_visible('lbl_prdo006',TRUE)
   CALL cl_set_comp_visible('prdo006_1',TRUE)
   CALL cl_set_comp_visible('lbl_prdo007',TRUE)
   CALL cl_set_comp_visible('prdo007_1',TRUE)
   CALL cl_set_comp_visible('lbl_prdo008',TRUE)
   CALL cl_set_comp_visible('prdo008_1',TRUE)
   IF g_prdl_m.prdl013 = 'Y' THEN
      CALL cl_set_comp_visible('lbl_prdo003',FALSE)
      CALL cl_set_comp_visible('l_prdo003_1',FALSE)
      LET g_prdl_m.l_prdo003_1 = ''
      CALL cl_set_comp_visible('lbl_prdo004',FALSE)
      CALL cl_set_comp_visible('l_prdo004_1',FALSE)
      LET g_prdl_m.l_prdo004_1 = ''
      CALL cl_set_comp_visible('lbl_prdo005',FALSE)
      CALL cl_set_comp_visible('prdo005_1',FALSE)
      LET g_prdl_m.prdo005_1 = ''
      CALL cl_set_comp_visible('lbl_prdo006',FALSE)
      CALL cl_set_comp_visible('prdo006_1',FALSE)
      LET g_prdl_m.prdo006_1 = ''
      CALL cl_set_comp_visible('lbl_prdo007',FALSE)
      CALL cl_set_comp_visible('prdo007_1',FALSE)
      LET g_prdl_m.prdo007_1 = ''
      CALL cl_set_comp_visible('lbl_prdo008',FALSE)
      CALL cl_set_comp_visible('prdo008_1',FALSE)
      LET g_prdl_m.prdo008_1 = ''
   ELSE
      CALL cl_set_comp_visible('bpage4',FALSE)
   END IF
   CALL cl_set_comp_visible('lbl_prdb005_1',TRUE)
   CALL cl_set_comp_visible('lbl_prdb005_2',TRUE)
   CALL cl_set_comp_visible('prdb005_1',TRUE)
   CALL cl_set_comp_visible('prdb005_2',TRUE)
   CALL cl_set_comp_visible('lbl_3',FALSE)
   CALL cl_set_comp_visible('lbl_4',FALSE)
   IF g_prdl_m.prdl026 = '1' THEN
      CALL cl_set_comp_visible('lbl_prdb005_2',FALSE)
      CALL cl_set_comp_visible('prdb005_2',FALSE)
      LET g_prdl_m.prdb005_2 = ''
      CALL cl_set_comp_visible('lbl_4',TRUE)
   END IF
   IF g_prdl_m.prdl026 = '2' THEN
      CALL cl_set_comp_visible('lbl_prdb005_1',FALSE)
      CALL cl_set_comp_visible('prdb005_1',FALSE)
      LET g_prdl_m.prdb005_1 = ''
      CALL cl_set_comp_visible('lbl_3',TRUE)
   END IF
   IF g_prdl_m.prdl026 = '4' THEN
      CALL cl_set_comp_visible('lbl_prdb005_1',FALSE)
      CALL cl_set_comp_visible('lbl_prdb005_2',FALSE)
      CALL cl_set_comp_visible('prdb005_1',FALSE)
      LET g_prdl_m.prdb005_1 = ''
      CALL cl_set_comp_visible('prdb005_2',FALSE)
      LET g_prdl_m.prdb005_2 = ''
      CALL cl_set_comp_visible('lbl_3',TRUE)
      CALL cl_set_comp_visible('lbl_4',TRUE)
   END IF
END FUNCTION
################################################################################
# Descriptions...: 根據不同的條件欄位顯示名稱不同
# Memo...........:
# Usage..........: CALL aprm211_set_comp_att_text()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/14 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aprm211_set_comp_att_text()
DEFINE l_msg      STRING 

   CALL cl_getmsg('apr-00184',g_lang) RETURNING l_msg
   CALL cl_set_comp_att_text("lbl_prdb005_1",l_msg)
   CALL cl_getmsg('apr-00185',g_lang) RETURNING l_msg
   CALL cl_set_comp_att_text("lbl_prdb005_2",l_msg)
   IF g_prdl_m.prdl024 = '3' THEN
      CALL cl_getmsg('apr-00070',g_lang) RETURNING l_msg
      CALL cl_set_comp_att_text("lbl_prdb005_1",l_msg)
      CALL cl_getmsg('apr-00072',g_lang) RETURNING l_msg
      CALL cl_set_comp_att_text("lbl_prdb005_2",l_msg)
   END IF
   IF g_prdl_m.prdl024 = '3' THEN
      CALL cl_getmsg('apr-00095',g_lang) RETURNING l_msg
      CALL cl_set_comp_att_text("prdm005",l_msg)
   END IF
   IF g_prdl_m.prdl024 = '1' THEN
      CALL cl_getmsg('apr-00146',g_lang) RETURNING l_msg
      CALL cl_set_comp_att_text("prdm005",l_msg)
   END IF   
   IF g_prdl_m.prdl024 = '2' THEN
      CALL cl_getmsg('apr-00369',g_lang) RETURNING l_msg
      CALL cl_set_comp_att_text("prdm005",l_msg)      
   END IF    
END FUNCTION
################################################################################
# Descriptions...: 單頭日期+參考對象新增
# Memo...........:
# Usage..........: CALL aprm211_master_def()
# Input parameter: 無
# Return code....: TRUE/FALSE
# Date & Author..: 2014/03/14 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aprm211_master_def()
#   DELETE FROM prdb_t WHERE prdbent = g_enterprise AND prdbdocno = g_prdl_m.prdadocno
   IF g_prdl_m.prdl026 = '1'  OR g_prdl_m.prdl026 = '3'  THEN
      #散客
      IF NOT cl_null(g_prdl_m.prdb005_1) THEN
#         INSERT INTO prdb_t(prdbent,prdbunit,prdbsite,prdbdocno,prdb001,prdb002,prdb003,prdb004,prdb005,prdbacti)
#                     VALUES(g_enterprise,g_site,g_site,g_prdl_m.prdadocno,g_prdl_m.prdl001,1,'1',0,g_prdl_m.prdb005_1,'Y')         
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'ins prdb'
            LET g_errparam.popup = TRUE
            CALL cl_err()

            RETURN FALSE
         END IF
      END IF
   END IF
   IF g_prdl_m.prdl026 = '2'  OR g_prdl_m.prdl026 = '3'  THEN
      #會員
      IF NOT cl_null(g_prdl_m.prdb005_2) THEN
#         INSERT INTO prdb_t(prdbent,prdbunit,prdbsite,prdbdocno,prdb001,prdb002,prdb003,prdb004,prdb005,prdbacti)
#                     VALUES(g_enterprise,g_site,g_site,g_prdl_m.prdadocno,g_prdl_m.prdl001,2,'2',0,g_prdl_m.prdb005_2,'Y')         
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'ins prdb'
            LET g_errparam.popup = TRUE
            CALL cl_err()

            RETURN FALSE
         END IF
      END IF
   END IF
#   DELETE FROM prdo_t WHERE prdoent = g_enterprise AND prdddocno = g_prdl_m.prdadocno
   #日期
   IF g_prdl_m.prdl013 = 'N' THEN
#      INSERT INTO prdo_t(prdoent,prdounit,prdosite,prdddocno,prdo001,prdo002,prdo003,prdo004,prdo005,prdo006,prdo007,prdo008,prddacti)
#                  VALUES(g_enterprise,g_site,g_site,g_prdl_m.prdadocno,g_prdl_m.prdl001,1,g_prdl_m.l_prdo003_1,g_prdl_m.l_prdo004_1,g_prdl_m.prdo005_1,g_prdl_m.prdo006_1,g_prdl_m.prdo007_1,g_prdl_m.prdo008_1,'Y')
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'ins prdd'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   END IF
   RETURN TRUE
END FUNCTION
################################################################################
# Descriptions...: 單頭日期+參考對象更新
# Memo...........:
# Usage..........: CALL aprm211_master_upd()
# Input parameter: 無
# Return code....: TRUE/FALSE
# Date & Author..: 2014/03/14 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aprm211_master_upd()
DEFINE l_n           LIKE type_t.num5


#   IF g_prdl_m.prdl026 = '1'  OR g_prdl_m.prdl026 = '3'  THEN
#      #散客
#      IF NOT cl_null(g_prdl_m.prdb005_1) THEN
#         LET l_n = 0
#         SELECT COUNT(*) INTO l_n
#           FROM prdb_t
#          WHERE prdbent = g_enterprise
#            AND prdbdocno = g_prdl_m.prdadocno
#            AND prdb002 = 1
#         IF l_n = 0 THEN
#            INSERT INTO prdb_t(prdbent,prdbunit,prdbsite,prdbdocno,prdb001,prdb002,prdb003,prdb004,prdb005,prdbacti)
#                        VALUES(g_enterprise,g_site,g_site,g_prdl_m.prdadocno,g_prdl_m.prdl001,1,'1',0,g_prdl_m.prdb005_1,'Y')         
#            IF SQLCA.sqlcode THEN
#               CALL cl_err('ins prdb',SQLCA.sqlcode,1)
#               RETURN FALSE
#            END IF
#         ELSE
#            UPDATE prdb_t SET prdb001 = g_prdl_m.prdl001,
#                              prdb003 = '1',
#                              prdb004 = 0,
#                              prdb005 = g_prdl_m.prdb005_1,
#                              prdbacti = 'Y'
#            WHERE prdbent = g_enterprise
#              AND prdbdocno = g_prdl_m.prdadocno
#              AND prdb002 = 1  
#            IF SQLCA.sqlcode THEN
#               CALL cl_err('upd prdb',SQLCA.sqlcode,1)
#               RETURN FALSE
#            END IF     
#         END IF
#      END IF
#   END IF
#   IF g_prdl_m.prdl026 = '2'  OR g_prdl_m.prdl026 = '3'  THEN
#      #散客
#      IF NOT cl_null(g_prdl_m.prdb005_2) THEN
#         LET l_n = 0
#         SELECT COUNT(*) INTO l_n
#           FROM prdb_t
#          WHERE prdbent = g_enterprise
#            AND prdbdocno = g_prdl_m.prdadocno
#            AND prdb002 = 2
#         IF l_n = 0 THEN
#            INSERT INTO prdb_t(prdbent,prdbunit,prdbsite,prdbdocno,prdb001,prdb002,prdb003,prdb004,prdb005,prdbacti)
#                        VALUES(g_enterprise,g_site,g_site,g_prdl_m.prdadocno,g_prdl_m.prdl001,2,'2',0,g_prdl_m.prdb005_2,'Y')         
#            IF SQLCA.sqlcode THEN
#               CALL cl_err('ins prdb',SQLCA.sqlcode,1)
#               RETURN FALSE
#            END IF
#         ELSE
#            UPDATE prdb_t SET prdb001 = g_prdl_m.prdl001,
#                              prdb003 = '2',
#                              prdb004 = 0,
#                              prdb005 = g_prdl_m.prdb005_2,
#                              prdbacti = 'Y'
#            WHERE prdbent = g_enterprise
#              AND prdbdocno = g_prdl_m.prdadocno
#              AND prdb002 = 2  
#            IF SQLCA.sqlcode THEN
#               CALL cl_err('upd prdb',SQLCA.sqlcode,1)
#               RETURN FALSE
#            END IF  
#         END IF
#      END IF
#   END IF
#   #日期
#   IF g_prdl_m.prdl013 = 'N' THEN
#      LET l_n = 0
#      SELECT COUNT(*) INTO l_n
#        FROM prdo_t
#       WHERE prdoent = g_enterprise
#         AND prdddocno = g_prdl_m.prdadocno
#         AND prdo002 = 1
#      IF l_n = 0 THEN   
#         INSERT INTO prdo_t(prdoent,prdounit,prdosite,prdddocno,prdo001,prdo002,prdo003,prdo004,prdo005,prdo006,prdo007,prdo008,prddacti)
#                     VALUES(g_enterprise,g_site,g_site,g_prdl_m.prdadocno,g_prdl_m.prdl001,1,g_prdl_m.l_prdo003_1,g_prdl_m.l_prdo004_1,g_prdl_m.prdo005_1,g_prdl_m.prdo006_1,g_prdl_m.prdo007_1,g_prdl_m.prdo008_1,'Y')
#         IF SQLCA.sqlcode THEN
#            CALL cl_err('ins prdd',SQLCA.sqlcode,1)
#            RETURN FALSE
#         END IF
#      ELSE
#         UPDATE prdo_t SET prdo001 = g_prdl_m.prdl001,
#                           prdo003 = g_prdl_m.l_prdo003_1,
#                           prdo004 = g_prdl_m.l_prdo004_1,
#                           prdo005 = g_prdl_m.prdo005_1,
#                           prdo006 = g_prdl_m.prdo006_1,
#                           prdo007 = g_prdl_m.prdo007_1,
#                           prdo008 = g_prdl_m.prdo008_1,
#                           prddacti = 'Y'
#         WHERE prdoent = g_enterprise
#           AND prdddocno = g_prdl_m.prdadocno
#           AND prdo002 = 1  
#         IF SQLCA.sqlcode THEN
#            CALL cl_err('upd prdd',SQLCA.sqlcode,1)
#            RETURN FALSE
#         END IF  
#      END IF
#   END IF
   RETURN TRUE
END FUNCTION
################################################################################
# Descriptions...: 規則編號檢查
# Memo...........:
# Usage..........: CALL aprm211_chk_prdl001()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/17 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aprm211_chk_prdl001()
DEFINE l_n              LIKE type_t.num5
DEFINE l_prdlstus       LIKE prdl_t.prdlstus

   LET g_errno = ""
   
#   IF g_prdl_m.prda000 = 'I' THEN
#      LET l_n = 0
#      SELECT COUNT(*) INTO l_n
#        FROM prdl_t
#       WHERE prdlent = g_enterprise
#         AND prdl001 = g_prdl_m.prdl001
#      IF l_n > 0 THEN
#         LET g_errno = 'apr-00080'
#         RETURN
#      END IF
#   END IF
#   IF g_prdl_m.prda000 = 'U' THEN
#      LET l_n = 0
#      SELECT COUNT(*) INTO l_n
#        FROM prdl_t
#       WHERE prdlent = g_enterprise
#         AND prdl001 = g_prdl_m.prdl001
#      IF l_n = 0 THEN
#         LET g_errno = 'apr-00081'
#         RETURN
#      END IF
#      LET l_prdlstus = ''
#      SELECT prdlstus INTO l_prdlstus
#        FROM prdl_t
#       WHERE prdlent = g_enterprise
#         AND prdl001 = g_prdl_m.prdl001
#      IF l_prdlstus = 'X' THEN
#         LET g_errno = 'apr-00082'
#         RETURN
#      END IF
#      IF l_prdlstus = 'N' THEN
#         LET g_errno = 'apr-00083'
#         RETURN
#      END IF
#   END IF
END FUNCTION
################################################################################
# Descriptions...: 店群/門店檢查
# Memo...........:
# Usage..........: CALL aprm211_chk_prdp004()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/17 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aprm211_chk_prdp004()
DEFINE l_n       LIKE type_t.num5
DEFINE l_sql     STRING

   LET g_errno = ''
   IF g_prdp_d[l_ac].prdp003 = '1' THEN
      LET l_n = 0
      SELECT COUNT(*) INTO l_n
        FROM rtaa_t
       WHERE rtaaent = g_enterprise
         AND rtaa001 = g_prdp_d[l_ac].prdp004
      IF l_n = 0 THEN
         LET g_errno = 'apr-00006'
         RETURN
      END IF
      LET l_n = 0
      SELECT COUNT(*) INTO l_n
        FROM rtaa_t
       WHERE rtaaent = g_enterprise
         AND rtaa001 = g_prdp_d[l_ac].prdp004
         AND rtaastus = 'Y'
      IF l_n = 0 THEN
         LET g_errno = 'apr-00007'
         RETURN
      END IF
      LET l_n = 0
      #huangrh add rtak_t ----20150603
      SELECT COUNT(*) INTO l_n
        FROM rtaa_t,rtak_t
       WHERE rtaaent = g_enterprise
         AND rtaa001 = g_prdp_d[l_ac].prdp004
         AND rtaastus = 'Y'
         AND rtakent=rtaaent
         AND rtak001=rtaa001
         AND rtak002='4'
         AND rtak003='Y'
      IF l_n = 0 THEN
         LET g_errno = 'apr-00008'
         RETURN
      END IF
      LET l_n = 0
      #huangrh add rtak_t ----20150603
      LET l_sql = "SELECT COUNT(*) ",
                  "  FROM rtaa_t,rtab_t,rtak_t",
                  " WHERE rtaaent = '",g_enterprise,"'",
                  "   AND rtaa001 = '",g_prdp_d[l_ac].prdp004,"'",
                  "   AND rtaastus = 'Y'",
                  "   AND rtakent=rtaaent",
                  "   AND rtak001=rtaa001",
                  "   AND rtak002='4'",
                  "   AND rtak003='Y'",
                  "   AND rtaaent = rtabent",
                  "   AND rtaa001 = rtab001",
                  #"   AND rtab002 IN (SELECT ooed004 FROM ooed_t ",  #160905-00007#12  mark
                  "   AND rtab002 IN (SELECT ooed004 FROM ooed_t WHERE ooedent=",g_enterprise,  #160905-00007#12  add
                  "                    START WITH ooed005 = '",g_site,"'",
                  "                      AND ooed001='8'",
                  "                      AND ooed006<= '",g_today,"'",
                  "                      AND (ooed007>= '",g_today,"' OR ooed007 IS NULL)",
                  "                    CONNECT BY  nocycle PRIOR ooed004=ooed005 ",
                  "                      AND ooed001='8' ",
                  "                      AND ooed006<= '",g_today,"'",
                  "                      AND (ooed007>= '",g_today,"' OR ooed007 IS NULL)",
                 # "                    UNION SELECT ooed004 FROM ooed_t WHERE ooed004 = '",g_site,"' )"   #160905-00007#12  mark
                  "                    UNION SELECT ooed004 FROM ooed_t WHERE ooedent =  ",g_enterprise," AND ooed004 = '",g_site,"' )"   #160905-00007#12  add
      PREPARE aprm211_sel_rtaa_pr FROM l_sql
      EXECUTE aprm211_sel_rtaa_pr INTO l_n
      IF l_n = 0 THEN
         LET g_errno = 'apr-00066'
         RETURN
      END IF
   END IF
#   IF g_prdp_d[l_ac].prdp003 = '1' THEN
#      LET l_n = 0
#      SELECT COUNT(*) INTO l_n
#        FROM rtab_t
#       WHERE rtabent = g_enterprise
#         AND rtab002 IN (SELECT prdp004 FROM prdp_t
#                          WHERE prdpent = g_enterprise
#                            AND prdedocno = g_prdl_m.prdadocno
#                            AND prdp003 = '2')
#         AND rtab001 = g_prdp_d[l_ac].prdp004
#      IF l_n > 0 THEN
#         LET g_errno = 'apr-00013'
#         RETURN
#      END IF
#   END IF
#   IF g_prdp_d[l_ac].prdp003 = '2' THEN
#      LET l_n = 0
#      SELECT COUNT(*) INTO l_n
#        FROM prdp_t
#       WHERE prdpent = g_enterprise
#         AND prdedocno = g_prdl_m.prdadocno
#         AND prdp004 IN (SELECT rtab001 FROM rtab_t
#                          WHERE rtabent = g_enterprise
#                            AND rtab002 = g_prdp_d[l_ac].prdp004)
#         AND prdp003 = '1'
#      IF l_n > 0 THEN
#         LET g_errno = 'apr-00014'
#         RETURN
#      END IF
#   END IF
END FUNCTION
################################################################################
# Descriptions...: 检查款别资料
# Memo...........:
# Usage..........: CALL aprm211_chk_prdq004()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/17 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aprm211_chk_prdq004()
DEFINE l_ooia002       LIKE ooia_t.ooia002
DEFINE l_gcafstus      LIKE gcaf_t.gcafstus
DEFINE l_mmanstus      LIKE mman_t.mmanstus
DEFINE l_n             LIKE type_t.num5

   LET g_errno = ""
   SELECT ooia002 INTO l_ooia002
     FROM ooia_t
    WHERE ooiaent = g_enterprise
      AND ooia001 = g_prdp3_d[l_ac].prdq003
   IF l_ooia002 = '40' THEN #券
      SELECT gcafstus INTO l_gcafstus
        FROM gcaf_t
       WHERE gcafent = g_enterprise
         AND gcaf001 = g_prdp3_d[l_ac].prdq004
      CASE 
         WHEN SQLCA.sqlcode = 100
              LET g_errno = 'apr-00085'
              RETURN
         WHEN l_gcafstus = 'X'
              LET g_errno = 'sub-01307'            #apr-00086  #160318-00005#38  By 07900--mod
              LET g_errparam.exeprog = 'agcm300'   #160318-00005#38  By 07900--add
              RETURN
         WHEN l_gcafstus = 'N'
              LET g_errno = 'sub-01302'   #apr-00087  #160318-00005#38  By 07900--mod
              LET g_errparam.exeprog = 'agcm300'   #160318-00005#38  By 07900--add
              RETURN
      END CASE   
      LET l_n = 0
      SELECT COUNT(*) INTO l_n
        FROM mmap_t
       WHERE mmapent = g_enterprise
         AND mmap001 = 'agcm300'
         AND mmap002 = g_prdp3_d[l_ac].prdq004
         AND mmap003 = g_site
         AND mmapstus = 'Y'
      IF l_n = 0 THEN
         LET g_errno = 'apr-00092'
         RETURN
      END IF
   END IF
   IF l_ooia002 = '60' THEN #卡
      SELECT mmanstus INTO l_mmanstus
        FROM mman_t
       WHERE mmanent = g_enterprise
         AND mman001 = g_prdp3_d[l_ac].prdq004
      CASE 
         WHEN SQLCA.sqlcode = 100
              LET g_errno = 'apr-00088'
              RETURN
         WHEN l_mmanstus = 'X'
              LET g_errno = 'sub-01307'  #apr-00089  #160318-00005#38  By 07900--mod
              LET g_errparam.exeprog = 'ammm320'     #160318-00005#38  By 07900--add
              RETURN
         WHEN l_mmanstus = 'N'
              LET g_errno = 'sub-01302'  #apr-00090  #160318-00005#38  By 07900--mod
              LET g_errparam.exeprog = 'ammm320'     #160318-00005#38  By 07900--add
              RETURN
      END CASE 
      LET l_n = 0
      SELECT COUNT(*) INTO l_n
        FROM mmap_t
       WHERE mmapent = g_enterprise
         AND mmap001 = 'ammm320'
         AND mmap002 = g_prdp3_d[l_ac].prdq004
         AND mmap003 = g_site
         AND mmapstus = 'Y'
      IF l_n = 0 THEN
         LET g_errno = 'apr-00092'
         RETURN
      END IF
   END IF
END FUNCTION
################################################################################
# Descriptions...: 屬性代碼檢查
# Memo...........:
# Usage..........: CALL aprm211_chk_prdr004()
#                  RETURNING TRUE/FALSE
# Input parameter: 無
# Return code....: TRUE/FALSE
# Date & Author..: 2014/03/17 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aprm211_chk_prdr004()
   IF g_prdp2_d[l_ac].prdr003 = '4' OR g_prdp2_d[l_ac].prdr003 = '15' THEN    #160819-00054#16 161013 by lori add:prdr003=15
      #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
      INITIALIZE g_chkparam.* TO NULL
      #設定g_chkparam.*的參數
      LET g_chkparam.arg1 = g_prdp2_d[l_ac].prdr004
      LET g_chkparam.arg2 = g_site
      #呼叫檢查存在並帶值的library
      IF NOT cl_chk_exist("v_rtdx001_1") THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prdp2_d[l_ac].prdr003 = '5' THEN
      #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
      INITIALIZE g_chkparam.* TO NULL
      #設定g_chkparam.*的參數
      LET g_chkparam.arg1 = g_prdp2_d[l_ac].prdr004
      #呼叫檢查存在並帶值的library
      IF NOT cl_chk_exist("v_rtax001_1") THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prdp2_d[l_ac].prdr003 = '6' THEN
      IF NOT s_azzi650_chk_exist('2000',g_prdp2_d[l_ac].prdr004) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prdp2_d[l_ac].prdr003 = '7' THEN
      IF NOT s_azzi650_chk_exist('2001',g_prdp2_d[l_ac].prdr004) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prdp2_d[l_ac].prdr003 = '8' THEN
      IF NOT s_azzi650_chk_exist('2002',g_prdp2_d[l_ac].prdr004) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prdp2_d[l_ac].prdr003 = '9' THEN
      IF NOT s_azzi650_chk_exist('2003',g_prdp2_d[l_ac].prdr004) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prdp2_d[l_ac].prdr003 = 'A' THEN
      IF NOT s_azzi650_chk_exist('2004',g_prdp2_d[l_ac].prdr004) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prdp2_d[l_ac].prdr003 = 'B' THEN
      IF NOT s_azzi650_chk_exist('2005',g_prdp2_d[l_ac].prdr004) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prdp2_d[l_ac].prdr003 = 'C' THEN
      IF NOT s_azzi650_chk_exist('2006',g_prdp2_d[l_ac].prdr004) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prdp2_d[l_ac].prdr003 = 'D' THEN
      IF NOT s_azzi650_chk_exist('2007',g_prdp2_d[l_ac].prdr004) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prdp2_d[l_ac].prdr003 = 'E' THEN
      IF NOT s_azzi650_chk_exist('2008',g_prdp2_d[l_ac].prdr004) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prdp2_d[l_ac].prdr003 = 'F' THEN
      IF NOT s_azzi650_chk_exist('2009',g_prdp2_d[l_ac].prdr004) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prdp2_d[l_ac].prdr003 = 'G' THEN
      IF NOT s_azzi650_chk_exist('2010',g_prdp2_d[l_ac].prdr004) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prdp2_d[l_ac].prdr003 = 'H' THEN
      IF NOT s_azzi650_chk_exist('2011',g_prdp2_d[l_ac].prdr004) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prdp2_d[l_ac].prdr003 = 'I' THEN
      IF NOT s_azzi650_chk_exist('2012',g_prdp2_d[l_ac].prdr004) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prdp2_d[l_ac].prdr003 = 'J' THEN
      IF NOT s_azzi650_chk_exist('2013',g_prdp2_d[l_ac].prdr004) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prdp2_d[l_ac].prdr003 = 'K' THEN
      IF NOT s_azzi650_chk_exist('2014',g_prdp2_d[l_ac].prdr004) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prdp2_d[l_ac].prdr003 = 'L' THEN
      IF NOT s_azzi650_chk_exist('2015',g_prdp2_d[l_ac].prdr004) THEN
         RETURN FALSE
      END IF
   END IF
   RETURN TRUE
END FUNCTION
################################################################################
# Descriptions...: 商品編號帶值
# Memo...........:
# Usage..........: CALL aprm211_prdr004_def()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/17 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aprm211_prdr004_def()
   #150312-00002#6 Modify-S By Ken 150319 原rtdx033改抓imaa106
   SELECT rtdx002   #,rtdx033 
     INTO g_prdp2_d[l_ac].prdr005   #,g_prdp2_d[l_ac].prdr006
     FROM rtdx_t
    WHERE rtdxent = g_enterprise
      AND rtdxsite = g_site
      AND rtdx001 = g_prdp2_d[l_ac].prdr004

   SELECT imaa106 
     INTO g_prdp2_d[l_ac].prdr006
     FROM imaa_t
    WHERE imaaent = g_enterprise
      AND imaa001 = g_prdp2_d[l_ac].prdr004
   #150312-00002#6 Modify-E
   
   CALL aprm211_prdr_desc()
END FUNCTION
################################################################################
# Descriptions...: 單頭其他表欄位顯示
# Memo...........:
# Usage..........: CALL　aprm211_master_show()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/18 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aprm211_master_show()
   IF g_prdl_m.prdl026 = '1'  OR g_prdl_m.prdl026 = '3'  THEN
      #散客
      SELECT prdm005 INTO g_prdl_m.prdb005_1
        FROM prdm_t
       WHERE prdment = g_enterprise
         AND prdm001 = g_prdl_m.prdl001
         AND prdm002 = 1
   END IF
   IF g_prdl_m.prdl026 = '2'  OR g_prdl_m.prdl026 = '3'  THEN
      #會員
      SELECT prdm005 INTO g_prdl_m.prdb005_2
        FROM prdm_t
       WHERE prdment = g_enterprise
         AND prdm001 = g_prdl_m.prdl001
         AND prdm002 = 2
   END IF
   
   #日期
   IF g_prdl_m.prdl013 = 'N' THEN
      SELECT prdo003,prdo004,prdo005,prdo006,prdo007,prdo008 
        INTO g_prdl_m.l_prdo003_1,g_prdl_m.l_prdo004_1,g_prdl_m.prdo005_1,g_prdl_m.prdo006_1,g_prdl_m.prdo007_1,g_prdl_m.prdo008_1
        FROM prdo_t
       WHERE prdoent = g_enterprise
         AND prdo001 = g_prdl_m.prdl001
         AND prdo002 = 1
   END IF
END FUNCTION

################################################################################
# Descriptions...: 屬性名稱帶值
# Memo...........:
# Usage..........: CALL aprm211_prdn_desc()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/04/15 By huangrh
# Modify.........:
################################################################################
PRIVATE FUNCTION aprm211_prdn_desc()
DEFINE l_oocq004      LIKE oocq_t.oocq004

   IF g_prdp5_d[g_detail_idx].prdm003 = '2' THEN
      SELECT oocq004 INTO l_oocq004
        FROM oocq_t
       WHERE oocqent = g_enterprise
         AND oocq001 = '2049'
         AND oocq002 = g_prdp6_d[l_ac].prdn003
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_oocq004
      LET g_ref_fields[2] = g_prdp6_d[l_ac].prdn004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prdp6_d[l_ac].prdn004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prdp6_d[l_ac].prdn004_desc
      #150324-00004#1--add by dongsz--end---
   END IF
   
   IF g_prdp5_d[g_detail_idx].prdm003 = '3' THEN
      IF g_prdp6_d[l_ac].prdn003 = '1' THEN #客戶編號
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prdp6_d[l_ac].prdn004
         CALL ap_ref_array2(g_ref_fields,"SELECT pmaal003 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prdp6_d[l_ac].prdn004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prdp6_d[l_ac].prdn004_desc
      END IF
      
      IF g_prdp6_d[l_ac].prdn003 = '2' THEN #客戶分類
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prdp6_d[l_ac].prdn004
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='281' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prdp6_d[l_ac].prdn004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prdp6_d[l_ac].prdn004_desc
      END IF 
      
      IF g_prdp6_d[l_ac].prdn003 = '3' THEN 
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prdp6_d[l_ac].prdn004
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2061' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prdp6_d[l_ac].prdn004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prdp6_d[l_ac].prdn004_desc
      END IF
      
      IF g_prdp6_d[l_ac].prdn003 = '4' THEN
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prdp6_d[l_ac].prdn004
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2062' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prdp6_d[l_ac].prdn004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prdp6_d[l_ac].prdn004_desc
      END IF     

      IF g_prdp6_d[l_ac].prdn003 = '5' THEN
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prdp6_d[l_ac].prdn004
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2063' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prdp6_d[l_ac].prdn004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prdp6_d[l_ac].prdn004_desc
      END IF  
      
      IF g_prdp6_d[l_ac].prdn003 = '6' THEN
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prdp6_d[l_ac].prdn004
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2064' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prdp6_d[l_ac].prdn004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prdp6_d[l_ac].prdn004_desc
      END IF  
      
      IF g_prdp6_d[l_ac].prdn003 = '7' THEN
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prdp6_d[l_ac].prdn004
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2065' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prdp6_d[l_ac].prdn004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prdp6_d[l_ac].prdn004_desc
      END IF  
      
      IF g_prdp6_d[l_ac].prdn003 = '8' THEN
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prdp6_d[l_ac].prdn004
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2066' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prdp6_d[l_ac].prdn004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prdp6_d[l_ac].prdn004_desc
      END IF  
      
      IF g_prdp6_d[l_ac].prdn003 = '9' THEN
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prdp6_d[l_ac].prdn004
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2067' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prdp6_d[l_ac].prdn004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prdp6_d[l_ac].prdn004_desc
      END IF  
      
      
      IF g_prdp6_d[l_ac].prdn003 = '10' THEN
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prdp6_d[l_ac].prdn004
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2068' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prdp6_d[l_ac].prdn004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prdp6_d[l_ac].prdn004_desc
      END IF  
      
      IF g_prdp6_d[l_ac].prdn003 = '11' THEN
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prdp6_d[l_ac].prdn004
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2069' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prdp6_d[l_ac].prdn004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prdp6_d[l_ac].prdn004_desc
      END IF  
      
      IF g_prdp6_d[l_ac].prdn003 = '12' THEN
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prdp6_d[l_ac].prdn004
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2070' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prdp6_d[l_ac].prdn004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prdp6_d[l_ac].prdn004_desc
      END IF  
      
   END IF  



END FUNCTION

################################################################################
# Descriptions...: 單身填充
# Memo...........:
# Usage..........: CALL aprm211_b6_fill()
# Input parameter: 
# Return code....: 
# Date & Author..: 20150415 By huangrh
# Modify.........:
################################################################################
PRIVATE FUNCTION aprm211_b6_fill()
DEFINE l_msg      STRING
DEFINE l_i        LIKE type_t.num5

      CALL g_prdp6_d.clear()
      IF g_detail_idx <= 0 THEN
         RETURN
      END IF
      IF g_prdp5_d.getLength() = 0 THEN
         RETURN
      END IF


      LET g_sql = "SELECT  UNIQUE prdnstus,prdn002,prdn003,prdn004,'',prdnsite,prdnunit FROM prdn_t",   
            
                  "",
                  " WHERE prdnent=? AND prdn001=? AND prdn002=?"
      
      IF NOT cl_null(g_wc2_table6) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table6 CLIPPED
      END IF
      
      LET g_sql = g_sql, " ORDER BY prdn_t.prdn003,prdn_t.prdn004" 
            
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE aprm211_pb6 FROM g_sql
      DECLARE b_fill_cs6 CURSOR FOR aprm211_pb6
  
      LET l_ac = 1
      
      OPEN b_fill_cs6 USING g_enterprise,g_prdl_m.prdl001,g_prdp5_d[g_detail_idx].prdm002

      FOREACH  b_fill_cs6 INTO g_prdp6_d[l_ac].prdnstus,g_prdp6_d[l_ac].prdn002,g_prdp6_d[l_ac].prdn003,g_prdp6_d[l_ac].prdn004, 
          g_prdp6_d[l_ac].prdn004_desc,g_prdp6_d[l_ac].prdnsite,g_prdp6_d[l_ac].prdnunit 
      
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
      
            EXIT FOREACH
         END IF

         CALL aprm211_prdn_desc()

         
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            EXIT FOREACH
         END IF
         
      END FOREACH
      CALL g_prdp6_d.deleteElement(g_prdp6_d.getLength())
      FREE aprm211_pb6      


END FUNCTION

################################################################################
# Descriptions...: 顯示會員的對象屬性
# Memo...........:
# Usage..........: CALL aprm211_prdn003_display()
# Date & Author..: 20150415 By huangrh
# Modify.........:
################################################################################
PRIVATE FUNCTION aprm211_prdn003_display()
DEFINE l_oocq002      LIKE oocq_t.oocq002
DEFINE l_oocql004     LIKE oocql_t.oocql004
DEFINE l_cnt          LIKE type_t.num5
DEFINE l_sql          STRING
DEFINE cb004          ui.ComboBox
   
   LET cb004 = ui.ComboBox.forName('prdn003')
   CALL cb004.clear()
   
   LET l_cnt = 0
   LET l_sql = " SELECT DISTINCT oocq002,oocql004 ",
               "   FROM oocq_t LEFT JOIN oocql_t ON oocqent = oocqlent AND oocq001 = oocql001 AND oocq002 = oocql002 AND oocql003 = '",g_dlang,"' ",
               "  WHERE oocqent = ",g_enterprise," ",
               "    AND oocq001 = '2049' ",
               "    AND oocqstus = 'Y' ",
               "  ORDER BY oocq002 "
   PREPARE sel_oocq_pre FROM l_sql
   DECLARE sel_oocq_cs  CURSOR FOR sel_oocq_pre
   LET l_cnt = 1
   FOREACH sel_oocq_cs  INTO l_oocq002,l_oocql004
      LET l_oocql004 = l_oocq002,':',l_oocql004
      IF cl_null(l_oocql004) THEN
         CALL cb004.addItem(l_oocq002,l_oocq002)
      ELSE
         CALL cb004.addItem(l_oocq002,l_oocql004)
      END IF
      LET l_cnt = l_cnt+1
   END FOREACH
   
END FUNCTION

 
{</section>}
 
