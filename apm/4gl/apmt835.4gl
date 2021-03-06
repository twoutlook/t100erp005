#該程式未解開Section, 採用最新樣板產出!
{<section id="apmt835.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0011(2015-08-18 19:37:22), PR版次:0011(2016-11-10 15:55:50)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000259
#+ Filename...: apmt835
#+ Description: 要貨單變更維護作業
#+ Creator....: 02159(2015-03-20 18:03:27)
#+ Modifier...: 02159 -SD/PR- 00700
 
{</section>}
 
{<section id="apmt835.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#151224-00025#3   2015/12/24  By fionchen  產品特徵欄位若無開窗輸入反而自行手動輸入時,則無法新增至inam_t
#160314-00009#3   2016/03/17  By zhujing   各程式增加产品特征是否需要自动开窗的程式段处理
#160318-00025#21  2016/04/19  BY 07900     校验代码重复错误讯息的修改
#160816-00001#9   2016/08/17  By 08734     抓取理由碼改CALL sub
#160816-00068#15  2016/08/22  By earl      調整transaction
#160818-00017#28  2016/08/30  By 08742     删除修改未重新判断状态码
#160824-00007#20  2016/09/19  By 06814     舊值備份處理
#161104-00002#11  2016/11/10  By Rainy     將程式中 *寫法改掉
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
PRIVATE type type_g_pmdc_m        RECORD
       pmdcsite LIKE pmdc_t.pmdcsite, 
   pmdcsite_desc LIKE type_t.chr80, 
   pmdc902 LIKE pmdc_t.pmdc902, 
   pmdcdocno LIKE pmdc_t.pmdcdocno, 
   pmdc900 LIKE pmdc_t.pmdc900, 
   pmdc001 LIKE pmdc_t.pmdc001, 
   pmdc002 LIKE pmdc_t.pmdc002, 
   pmdc002_desc LIKE type_t.chr80, 
   pmdc003 LIKE pmdc_t.pmdc003, 
   pmdc003_desc LIKE type_t.chr80, 
   pmdcstus LIKE pmdc_t.pmdcstus, 
   pmdcacti LIKE pmdc_t.pmdcacti, 
   pmdc200 LIKE pmdc_t.pmdc200, 
   pmdc202 LIKE pmdc_t.pmdc202, 
   pmdc202_desc LIKE type_t.chr80, 
   pmdc201 LIKE pmdc_t.pmdc201, 
   pmdc203 LIKE pmdc_t.pmdc203, 
   pmdc203_desc LIKE type_t.chr80, 
   pmdc207 LIKE pmdc_t.pmdc207, 
   pmdc204 LIKE pmdc_t.pmdc204, 
   pmdc204_desc LIKE type_t.chr80, 
   pmdc205 LIKE pmdc_t.pmdc205, 
   pmdc205_desc LIKE type_t.chr80, 
   pmdc206 LIKE pmdc_t.pmdc206, 
   pmdc206_desc LIKE type_t.chr80, 
   pmdc021 LIKE pmdc_t.pmdc021, 
   pmdc021_desc LIKE type_t.chr80, 
   pmdc208 LIKE pmdc_t.pmdc208, 
   pmdc022 LIKE pmdc_t.pmdc022, 
   pmdc905 LIKE pmdc_t.pmdc905, 
   pmdc905_desc LIKE type_t.chr80, 
   pmdc901 LIKE pmdc_t.pmdc901, 
   pmdc906 LIKE pmdc_t.pmdc906, 
   pmdcdocdt LIKE pmdc_t.pmdcdocdt, 
   pmdcownid LIKE pmdc_t.pmdcownid, 
   pmdcownid_desc LIKE type_t.chr80, 
   pmdcowndp LIKE pmdc_t.pmdcowndp, 
   pmdcowndp_desc LIKE type_t.chr80, 
   pmdccrtid LIKE pmdc_t.pmdccrtid, 
   pmdccrtid_desc LIKE type_t.chr80, 
   pmdccrtdp LIKE pmdc_t.pmdccrtdp, 
   pmdccrtdp_desc LIKE type_t.chr80, 
   pmdccrtdt LIKE pmdc_t.pmdccrtdt, 
   pmdcmodid LIKE pmdc_t.pmdcmodid, 
   pmdcmodid_desc LIKE type_t.chr80, 
   pmdcmoddt LIKE pmdc_t.pmdcmoddt, 
   pmdccnfid LIKE pmdc_t.pmdccnfid, 
   pmdccnfid_desc LIKE type_t.chr80, 
   pmdccnfdt LIKE pmdc_t.pmdccnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_pmdd_d        RECORD
       pmddseq LIKE pmdd_t.pmddseq, 
   pmdd001 LIKE pmdd_t.pmdd001, 
   pmdd002 LIKE pmdd_t.pmdd002, 
   pmdd003 LIKE pmdd_t.pmdd003, 
   pmddsite LIKE pmdd_t.pmddsite, 
   pmddsite_desc LIKE type_t.chr500, 
   pmdd200 LIKE pmdd_t.pmdd200, 
   pmdd004 LIKE pmdd_t.pmdd004, 
   pmdd004_desc LIKE type_t.chr500, 
   pmdd004_desc_desc LIKE type_t.chr500, 
   pmdd005 LIKE pmdd_t.pmdd005, 
   pmdd005_desc LIKE type_t.chr500, 
   imaa009 LIKE type_t.chr500, 
   imaa009_desc LIKE type_t.chr500, 
   pmdd033 LIKE pmdd_t.pmdd033, 
   pmdd037 LIKE pmdd_t.pmdd037, 
   pmdd037_desc LIKE type_t.chr500, 
   pmdd260 LIKE pmdd_t.pmdd260, 
   pmdd260_desc LIKE type_t.chr500, 
   pmdd038 LIKE pmdd_t.pmdd038, 
   pmdd038_desc LIKE type_t.chr500, 
   pmdd227 LIKE pmdd_t.pmdd227, 
   pmdd201 LIKE pmdd_t.pmdd201, 
   pmdd201_desc LIKE type_t.chr500, 
   pmdd202 LIKE pmdd_t.pmdd202, 
   pmdd212 LIKE pmdd_t.pmdd212, 
   pmdd007 LIKE pmdd_t.pmdd007, 
   pmdd007_desc LIKE type_t.chr500, 
   pmdd006 LIKE pmdd_t.pmdd006, 
   pmdd253 LIKE pmdd_t.pmdd253, 
   pmdd258 LIKE pmdd_t.pmdd258, 
   pmdd254 LIKE pmdd_t.pmdd254, 
   pmdd255 LIKE pmdd_t.pmdd255, 
   pmdd256 LIKE pmdd_t.pmdd256, 
   pmdd257 LIKE pmdd_t.pmdd257, 
   pmdd259 LIKE pmdd_t.pmdd259, 
   pmdd252 LIKE pmdd_t.pmdd252, 
   pmdd207 LIKE pmdd_t.pmdd207, 
   pmdd015 LIKE pmdd_t.pmdd015, 
   pmdd015_desc LIKE type_t.chr500, 
   pmdd049 LIKE pmdd_t.pmdd049, 
   pmdd030 LIKE pmdd_t.pmdd030, 
   pmdd048 LIKE pmdd_t.pmdd048, 
   pmdd048_desc LIKE type_t.chr500, 
   pmdd208 LIKE pmdd_t.pmdd208, 
   pmdd209 LIKE pmdd_t.pmdd209, 
   pmdd209_desc LIKE type_t.chr500, 
   pmdd206 LIKE pmdd_t.pmdd206, 
   pmdd206_desc LIKE type_t.chr500, 
   pmdd210 LIKE pmdd_t.pmdd210, 
   pmdd211 LIKE pmdd_t.pmdd211, 
   pmdd205 LIKE pmdd_t.pmdd205, 
   pmdd205_desc LIKE type_t.chr500, 
   pmdd203 LIKE pmdd_t.pmdd203, 
   pmdd203_desc LIKE type_t.chr500, 
   pmdd204 LIKE pmdd_t.pmdd204, 
   pmdd204_desc LIKE type_t.chr500, 
   l_pmdb032 LIKE type_t.chr500, 
   pmdd032 LIKE pmdd_t.pmdd032, 
   pmdd901 LIKE pmdd_t.pmdd901, 
   pmdd902 LIKE pmdd_t.pmdd902, 
   pmdd902_desc LIKE type_t.chr500, 
   pmdd903 LIKE pmdd_t.pmdd903
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_pmdcsite LIKE pmdc_t.pmdcsite,
   b_pmdcsite_desc LIKE type_t.chr80,
      b_pmdc902 LIKE pmdc_t.pmdc902,
      b_pmdcdocno LIKE pmdc_t.pmdcdocno,
      b_pmdc900 LIKE pmdc_t.pmdc900,
      b_pmdc001 LIKE pmdc_t.pmdc001,
      b_pmdc002 LIKE pmdc_t.pmdc002,
   b_pmdc002_desc LIKE type_t.chr80,
      b_pmdc003 LIKE pmdc_t.pmdc003,
   b_pmdc003_desc LIKE type_t.chr80,
      b_pmdcacti LIKE pmdc_t.pmdcacti,
      b_pmdc200 LIKE pmdc_t.pmdc200,
      b_pmdc202 LIKE pmdc_t.pmdc202,
   b_pmdc202_desc LIKE type_t.chr80,
      b_pmdc201 LIKE pmdc_t.pmdc201,
      b_pmdc203 LIKE pmdc_t.pmdc203,
   b_pmdc203_desc LIKE type_t.chr80,
      b_pmdc207 LIKE pmdc_t.pmdc207,
      b_pmdc204 LIKE pmdc_t.pmdc204,
   b_pmdc204_desc LIKE type_t.chr80,
      b_pmdc205 LIKE pmdc_t.pmdc205,
   b_pmdc205_desc LIKE type_t.chr80,
      b_pmdc206 LIKE pmdc_t.pmdc206,
   b_pmdc206_desc LIKE type_t.chr80,
      b_pmdc021 LIKE pmdc_t.pmdc021,
   b_pmdc021_desc LIKE type_t.chr80,
      b_pmdc208 LIKE pmdc_t.pmdc208,
      b_pmdc022 LIKE pmdc_t.pmdc022,
      b_pmdc905 LIKE pmdc_t.pmdc905,
   b_pmdc905_desc LIKE type_t.chr80,
      b_pmdc906 LIKE pmdc_t.pmdc906,
      b_pmdc901 LIKE pmdc_t.pmdc901,
      b_pmdcdocdt LIKE pmdc_t.pmdcdocdt
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_pmdc905_acc      LIKE type_t.chr10
DEFINE g_pmdc021_acc      LIKE type_t.chr10
DEFINE g_pmdd902_acc      LIKE type_t.chr10
DEFINE g_pmdd048_acc      LIKE type_t.chr10
DEFINE g_set_pmdcsite_entry LIKE type_t.num5
#請購變更歷程檔變數宣告
DEFINE g_pmde007          LIKE pmde_t.pmde007
#顏色處理
DEFINE g_pmdd_d_color     DYNAMIC ARRAY OF RECORD
   pmddseq             STRING,
   pmdd001             STRING,
   pmdd002             STRING,
   pmdd003             STRING,
   pmddsite            STRING,
   pmddsite_desc       STRING,
   pmdd200             STRING,
   pmdd004             STRING,
   pmdd004_desc        STRING,
   pmdd004_desc_desc   STRING,
   pmdd005             STRING,
   pmdd005_desc        STRING,
   imaa009             STRING,
   imaa009_desc        STRING,
   pmdd037             STRING,
   pmdd037_desc        STRING,
   pmdd260             STRING,
   pmdd260_desc        STRING,
   pmdd038             STRING,
   pmdd038_desc        STRING,
   pmdd201             STRING,
   pmdd201_desc        STRING,
   pmdd202             STRING,
   pmdd212             STRING,
   pmdd006             STRING,
   pmdd007             STRING,
   pmdd007_desc        STRING,
   pmdd253             STRING,
   pmdd258             STRING,
   pmdd254             STRING,
   pmdd255             STRING,
   pmdd256             STRING,
   pmdd257             STRING,
   pmdd259             STRING,
   pmdd252             STRING,
   pmdd207             STRING,
   pmdd015             STRING,
   pmdd015_desc        STRING,
   pmdd049             STRING,
   pmdd030             STRING,
   pmdd048             STRING,
   pmdd048_desc        STRING,
   pmdd208             STRING,
   pmdd209             STRING,
   pmdd209_desc        STRING,
   pmdd206             STRING,
   pmdd206_desc        STRING,
   pmdd210             STRING,
   pmdd211             STRING,
   pmdd205             STRING,
   pmdd205_desc        STRING,
   pmdd203             STRING,
   pmdd203_desc        STRING,
   pmdd204             STRING,
   pmdd204_desc        STRING,
   l_pmdb032           STRING,
   pmdd032             STRING,
   pmdd901             STRING,
   pmdd902             STRING,
   pmdd902_desc        STRING,
   pmdd903             STRING
       END RECORD
DEFINE g_para_pro      LIKE rtaz_t.rtaz001 #160118-00013#6 20160118 by s983961--add 
DEFINE g_acc                LIKE gzcb_t.gzcb008           #變更理由碼
#end add-point
       
#模組變數(Module Variables)
DEFINE g_pmdc_m          type_g_pmdc_m
DEFINE g_pmdc_m_t        type_g_pmdc_m
DEFINE g_pmdc_m_o        type_g_pmdc_m
DEFINE g_pmdc_m_mask_o   type_g_pmdc_m #轉換遮罩前資料
DEFINE g_pmdc_m_mask_n   type_g_pmdc_m #轉換遮罩後資料
 
   DEFINE g_pmdcdocno_t LIKE pmdc_t.pmdcdocno
DEFINE g_pmdc900_t LIKE pmdc_t.pmdc900
 
 
DEFINE g_pmdd_d          DYNAMIC ARRAY OF type_g_pmdd_d
DEFINE g_pmdd_d_t        type_g_pmdd_d
DEFINE g_pmdd_d_o        type_g_pmdd_d
DEFINE g_pmdd_d_mask_o   DYNAMIC ARRAY OF type_g_pmdd_d #轉換遮罩前資料
DEFINE g_pmdd_d_mask_n   DYNAMIC ARRAY OF type_g_pmdd_d #轉換遮罩後資料
 
 
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
 
{<section id="apmt835.main" >}
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
   CALL cl_ap_init("apm","")
 
   #add-point:作業初始化 name="main.init"
 
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT pmdcsite,'',pmdc902,pmdcdocno,pmdc900,pmdc001,pmdc002,'',pmdc003,'',pmdcstus, 
       pmdcacti,pmdc200,pmdc202,'',pmdc201,pmdc203,'',pmdc207,pmdc204,'',pmdc205,'',pmdc206,'',pmdc021, 
       '',pmdc208,pmdc022,pmdc905,'',pmdc901,pmdc906,pmdcdocdt,pmdcownid,'',pmdcowndp,'',pmdccrtid,'', 
       pmdccrtdp,'',pmdccrtdt,pmdcmodid,'',pmdcmoddt,pmdccnfid,'',pmdccnfdt", 
                      " FROM pmdc_t",
                      " WHERE pmdcent= ? AND pmdcdocno=? AND pmdc900=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apmt835_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.pmdcsite,t0.pmdc902,t0.pmdcdocno,t0.pmdc900,t0.pmdc001,t0.pmdc002, 
       t0.pmdc003,t0.pmdcstus,t0.pmdcacti,t0.pmdc200,t0.pmdc202,t0.pmdc201,t0.pmdc203,t0.pmdc207,t0.pmdc204, 
       t0.pmdc205,t0.pmdc206,t0.pmdc021,t0.pmdc208,t0.pmdc022,t0.pmdc905,t0.pmdc901,t0.pmdc906,t0.pmdcdocdt, 
       t0.pmdcownid,t0.pmdcowndp,t0.pmdccrtid,t0.pmdccrtdp,t0.pmdccrtdt,t0.pmdcmodid,t0.pmdcmoddt,t0.pmdccnfid, 
       t0.pmdccnfdt,t1.ooefl003 ,t2.ooag011 ,t3.ooefl003 ,t4.rtaxl003 ,t5.ooefl003 ,t6.ooefl003 ,t7.ooefl003 , 
       t8.ooefl003 ,t9.oocql004 ,t10.oocql004 ,t11.ooag011 ,t12.ooefl003 ,t13.ooag011 ,t14.ooefl003 , 
       t15.ooag011 ,t16.ooag011",
               " FROM pmdc_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.pmdcsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.pmdc002  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.pmdc003 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN rtaxl_t t4 ON t4.rtaxlent="||g_enterprise||" AND t4.rtaxl001=t0.pmdc202 AND t4.rtaxl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.pmdc203 AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.pmdc204 AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.pmdc205 AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t8 ON t8.ooeflent="||g_enterprise||" AND t8.ooefl001=t0.pmdc206 AND t8.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t9 ON t9.oocqlent="||g_enterprise||" AND t9.oocql001='263' AND t9.oocql002=t0.pmdc021 AND t9.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t10 ON t10.oocqlent="||g_enterprise||" AND t10.oocql001='267' AND t10.oocql002=t0.pmdc905 AND t10.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t11 ON t11.ooagent="||g_enterprise||" AND t11.ooag001=t0.pmdcownid  ",
               " LEFT JOIN ooefl_t t12 ON t12.ooeflent="||g_enterprise||" AND t12.ooefl001=t0.pmdcowndp AND t12.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t13 ON t13.ooagent="||g_enterprise||" AND t13.ooag001=t0.pmdccrtid  ",
               " LEFT JOIN ooefl_t t14 ON t14.ooeflent="||g_enterprise||" AND t14.ooefl001=t0.pmdccrtdp AND t14.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t15 ON t15.ooagent="||g_enterprise||" AND t15.ooag001=t0.pmdcmodid  ",
               " LEFT JOIN ooag_t t16 ON t16.ooagent="||g_enterprise||" AND t16.ooag001=t0.pmdccnfid  ",
 
               " WHERE t0.pmdcent = " ||g_enterprise|| " AND t0.pmdcdocno = ? AND t0.pmdc900 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE apmt835_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apmt835 WITH FORM cl_ap_formpath("apm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apmt835_init()   
 
      #進入選單 Menu (="N")
      CALL apmt835_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
   CALL s_aooi500_drop_temp() RETURNING l_success      #150308-00001#2  By sakura 150309      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_apmt835
      
   END IF 
   
   CLOSE apmt835_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="apmt835.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION apmt835_init()
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
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('pmdcstus','13','N,Y,A,D,R,W,X')
 
      CALL cl_set_combo_scc('pmdc200','6552') 
   CALL cl_set_combo_scc('pmdc201','6014') 
   CALL cl_set_combo_scc('pmdd033','2036') 
   CALL cl_set_combo_scc('pmdd207','6014') 
   CALL cl_set_combo_scc('pmdd208','6013') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   #CALL cl_set_combo_scc('pmdd901','5443') #ken---add 暫用5443 #先mark
   LET g_prog = 'apmt835' #暫時使用
   CALL cl_set_comp_visible("pmdd032，pmdc901",FALSE)
   CALL cl_set_combo_scc('l_pmdb032','2035')
   CALL s_aooi500_create_temp() RETURNING l_success    #150308-00001#2  By sakura 150309      
   #ACC代碼
   LET g_pmdc905_acc = ''    #單頭變更理由
   LET g_pmdd902_acc = ''    #單身變更理由
   LET g_pmdc021_acc = '263' #運送方式
   LET g_pmdd048_acc = '274' #收貨時段  
   #抓取[T:系統分類值檔].[C:系統分類碼]=24且[T:系統分類值檔].[C:系統分類碼]=g_prog 的[T:系統分類值檔].[C:系統應用欄位六]
  # SELECT gzcb008 INTO g_pmdc905_acc FROM gzcb_t WHERE gzcb001 = '24' AND gzcb002 = 'apmt830'   #160816-00001#9  2016/08/17  By 08734 Mark
   LET g_acc = s_fin_get_scc_value('24','apmt830','6')  #160816-00001#9  2016/08/17  By 08734 add  
   LET g_pmdd902_acc = g_pmdc905_acc
   LET g_para_pro = 'apmt830'  #變更單與來源同設定 #160118-00013#6 20160118 by s983961--add 
   #160314-00009#3 zhujing add 2016-3-17---(S)
   #判斷據點參數若不使用產品特徵時，則產品特徵需隱藏不可以維護(據點參數:S-BAS-0036)
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'N' THEN
      CALL cl_set_comp_visible("pmdd005,pmdd005_desc",FALSE)
   END IF
   #160314-00009#3 zhujing add 2016-3-17---(E)
   #end add-point
   
   #初始化搜尋條件
   CALL apmt835_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="apmt835.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION apmt835_ui_dialog()
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
            CALL apmt835_insert()
            #add-point:ON ACTION insert name="menu.default.insert"
            
            #END add-point
         END IF
 
      #add-point:action default自訂 name="ui_dialog.action_default"
      
      #end add-point
      OTHERWISE
   END CASE
 
 
 
   
   LET lb_first = TRUE
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   #150324-00006#14 2015/04/09 By pomelo add(S)
   LET g_forupd_sql = "SELECT pmddseq,pmdd001,pmdd002,pmdd003,pmddsite,pmdd200,pmdd004,pmdd005,pmdd033, 
       pmdd037,pmdd260,pmdd038,pmdd201,pmdd202,pmdd212,pmdd007,pmdd006,pmdd253,pmdd258,pmdd254,pmdd255, 
       pmdd256,pmdd257,pmdd259,pmdd252,pmdd207,pmdd015,pmdd049,pmdd030,pmdd048,pmdd208,pmdd209,pmdd206, 
       pmdd210,pmdd211,pmdd205,pmdd203,pmdd204,pmdd032,pmdd901,pmdd902,pmdd903 FROM pmdd_t WHERE pmddent=?  
       AND pmdddocno=? AND pmdd900=? AND pmddseq=? FOR UPDATE"
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apmt835_upd_pmdd033 CURSOR FROM g_forupd_sql
   #150324-00006#14 2015/04/09 By pomelo add(E)
   #end add-point
   
   WHILE TRUE 
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_pmdc_m.* TO NULL
         CALL g_pmdd_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL apmt835_init()
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
               
               CALL apmt835_fetch('') # reload data
               LET l_ac = 1
               CALL apmt835_ui_detailshow() #Setting the current row 
         
               CALL apmt835_idx_chk()
               #NEXT FIELD pmddseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_pmdd_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL apmt835_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1',",l_ac)
               
               #add-point:page1, before row動作 name="ui_dialog.page1.before_row"
               CALL s_hint_show('pmde_t','pmdd_t','pmdb_t',g_pmdc_m.pmdcdocno,g_pmdc_m.pmdc900,g_pmdd_d[g_detail_idx].pmddseq,'','')
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
               CALL apmt835_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               #150416-00001#1 150818 by sakura add(S)
               CALL apmt835_set_act_visible_b()
               CALL apmt835_set_act_no_visible_b()               
               #150416-00001#1 150818 by sakura add(E)
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION detail_qrystr
               MENU "" ATTRIBUTE(STYLE="popup")
                  #add-point:ON ACTION detail_qrystr相關動作 name="menu.detail_show.page1_sub.detail_qrystr"
                  #150416-00001#1 150818 by sakura add(S)
                  BEFORE MENU
                    IF g_detail_idx = 0 THEN
                       HIDE OPTION "prog_artt770"
                       EXIT MENU
                    ELSE
					   IF cl_null(g_pmdd_d[g_detail_idx].pmdd001) THEN
                          HIDE OPTION "prog_artt770"
                          EXIT MENU
                       END IF                                         
                    END IF                  
                  #150416-00001#1 150818 by sakura add(E)
                  #END add-point
                                 #應用 a43 樣板自動產生(Version:4)
               ON ACTION prog_artt770
                  LET g_action_choice="prog_artt770"
                  IF cl_auth_chk_act("prog_artt770") THEN
                     
                     #add-point:ON ACTION prog_artt770 name="menu.detail_show.page1_sub.prog_artt770"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               #150416-00001#1 150818 by sakura add(S)
               CASE g_pmdc_m.pmdc200
                  WHEN '1'
                     LET la_param.prog     = 'artt770'
                  WHEN '2'
                     LET la_param.prog     = 'adbt500'
                  WHEN '4'
                     LET la_param.prog     = 'apmt832'
                  WHEN '6'
                     LET la_param.prog     = 'artt405'
                  OTHERWISE
                     EXIT DIALOG                     
               END CASE               
               #150416-00001#1 150818 by sakura add(E)
               LET la_param.param[1] = g_pmdd_d[l_ac].pmdd001

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
 


                     #END add-point
                     
                  END IF
 
 
 
 
               END MENU
 
 
 
               #add-point:ON ACTION detail_qrystr name="menu.detail_show.page1.detail_qrystr"
               
               #END add-point
 
 
 
 
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            CALL DIALOG.setCellAttributes(g_pmdd_d_color) 
            #end add-point
               
         END DISPLAY
        
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL apmt835_browser_fill("")
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
               CALL apmt835_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL apmt835_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL apmt835_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            #單身變色導回單身
            IF lb_first THEN
               LET lb_first = FALSE
            END IF
            NEXT FIELD pmddseq
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL apmt835_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL apmt835_set_act_visible()   
            CALL apmt835_set_act_no_visible()
            IF NOT (g_pmdc_m.pmdcdocno IS NULL
              OR g_pmdc_m.pmdc900 IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " pmdcent = " ||g_enterprise|| " AND",
                                  " pmdcdocno = '", g_pmdc_m.pmdcdocno, "' "
                                  ," AND pmdc900 = '", g_pmdc_m.pmdc900, "' "
 
               #填到對應位置
               CALL apmt835_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "pmdc_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "pmdd_t" 
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
               CALL apmt835_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "pmdc_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "pmdd_t" 
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
                  CALL apmt835_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL apmt835_fetch("F")
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
               CALL apmt835_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL apmt835_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apmt835_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL apmt835_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apmt835_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL apmt835_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apmt835_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL apmt835_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apmt835_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL apmt835_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apmt835_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_pmdd_d)
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
               NEXT FIELD pmddseq
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
               CALL apmt835_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL apmt835_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL apmt835_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL apmt835_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION upd_pmdd033
            LET g_action_choice="upd_pmdd033"
            IF cl_auth_chk_act("upd_pmdd033") THEN
               
               #add-point:ON ACTION upd_pmdd033 name="menu.upd_pmdd033"
               #150324-00006#14 2015/04/09 By pomelo add(S)
               CALL apmt835_upd_pmdd033()
               #150324-00006#14 2015/04/09 By pomelo add(E)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/apm/apmt835_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/apm/apmt835_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL apmt835_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL apmt835_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_apmt830
            LET g_action_choice="prog_apmt830"
            IF cl_auth_chk_act("prog_apmt830") THEN
               
               #add-point:ON ACTION prog_apmt830 name="menu.prog_apmt830"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'apmt830'
               LET la_param.param[1] = g_pmdc_m.pmdcdocno

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
 


               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_pmdc002
            LET g_action_choice="prog_pmdc002"
            IF cl_auth_chk_act("prog_pmdc002") THEN
               
               #add-point:ON ACTION prog_pmdc002 name="menu.prog_pmdc002"
               #應用 a45 樣板自動產生(Version:2)
               CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_pmdc_m.pmdc002)
 


               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL apmt835_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL apmt835_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL apmt835_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_pmdc_m.pmdcdocdt)
 
 
 
         
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
 
{<section id="apmt835.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION apmt835_browser_fill(ps_page_action)
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
   CALL s_aooi500_sql_where(g_prog,'pmdcsite') RETURNING l_where
   LET g_wc = g_wc," AND ",l_where
   LET l_wc  = g_wc.trim()
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT pmdcdocno,pmdc900 ",
                      " FROM pmdc_t ",
                      " ",
                      " LEFT JOIN pmdd_t ON pmddent = pmdcent AND pmdcdocno = pmdddocno AND pmdc900 = pmdd900 ", "  ",
                      #add-point:browser_fill段sql(pmdd_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE pmdcent = " ||g_enterprise|| " AND pmddent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("pmdc_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT pmdcdocno,pmdc900 ",
                      " FROM pmdc_t ", 
                      "  ",
                      "  ",
                      " WHERE pmdcent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("pmdc_t")
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
      INITIALIZE g_pmdc_m.* TO NULL
      CALL g_pmdd_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.pmdcsite,t0.pmdc902,t0.pmdcdocno,t0.pmdc900,t0.pmdc001,t0.pmdc002,t0.pmdc003,t0.pmdcacti,t0.pmdc200,t0.pmdc202,t0.pmdc201,t0.pmdc203,t0.pmdc207,t0.pmdc204,t0.pmdc205,t0.pmdc206,t0.pmdc021,t0.pmdc208,t0.pmdc022,t0.pmdc905,t0.pmdc906,t0.pmdc901,t0.pmdcdocdt Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.pmdcstus,t0.pmdcsite,t0.pmdc902,t0.pmdcdocno,t0.pmdc900,t0.pmdc001, 
          t0.pmdc002,t0.pmdc003,t0.pmdcacti,t0.pmdc200,t0.pmdc202,t0.pmdc201,t0.pmdc203,t0.pmdc207,t0.pmdc204, 
          t0.pmdc205,t0.pmdc206,t0.pmdc021,t0.pmdc208,t0.pmdc022,t0.pmdc905,t0.pmdc906,t0.pmdc901,t0.pmdcdocdt, 
          t1.ooefl003 ,t2.ooag011 ,t3.ooefl003 ,t4.rtaxl003 ,t5.ooefl003 ,t6.ooefl003 ,t7.ooefl003 , 
          t8.ooefl003 ,t9.oocql004 ,t10.oocql004 ",
                  " FROM pmdc_t t0",
                  "  ",
                  "  LEFT JOIN pmdd_t ON pmddent = pmdcent AND pmdcdocno = pmdddocno AND pmdc900 = pmdd900 ", "  ", 
                  #add-point:browser_fill段sql(pmdd_t1) name="browser_fill.join.pmdd_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.pmdcsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.pmdc002  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.pmdc003 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN rtaxl_t t4 ON t4.rtaxlent="||g_enterprise||" AND t4.rtaxl001=t0.pmdc202 AND t4.rtaxl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.pmdc203 AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.pmdc204 AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.pmdc205 AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t8 ON t8.ooeflent="||g_enterprise||" AND t8.ooefl001=t0.pmdc206 AND t8.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t9 ON t9.oocqlent="||g_enterprise||" AND t9.oocql001='263' AND t9.oocql002=t0.pmdc021 AND t9.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t10 ON t10.oocqlent="||g_enterprise||" AND t10.oocql001='267' AND t10.oocql002=t0.pmdc905 AND t10.oocql003='"||g_dlang||"' ",
 
                  " WHERE t0.pmdcent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("pmdc_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.pmdcstus,t0.pmdcsite,t0.pmdc902,t0.pmdcdocno,t0.pmdc900,t0.pmdc001, 
          t0.pmdc002,t0.pmdc003,t0.pmdcacti,t0.pmdc200,t0.pmdc202,t0.pmdc201,t0.pmdc203,t0.pmdc207,t0.pmdc204, 
          t0.pmdc205,t0.pmdc206,t0.pmdc021,t0.pmdc208,t0.pmdc022,t0.pmdc905,t0.pmdc906,t0.pmdc901,t0.pmdcdocdt, 
          t1.ooefl003 ,t2.ooag011 ,t3.ooefl003 ,t4.rtaxl003 ,t5.ooefl003 ,t6.ooefl003 ,t7.ooefl003 , 
          t8.ooefl003 ,t9.oocql004 ,t10.oocql004 ",
                  " FROM pmdc_t t0",
                  "  ",
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.pmdcsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.pmdc002  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.pmdc003 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN rtaxl_t t4 ON t4.rtaxlent="||g_enterprise||" AND t4.rtaxl001=t0.pmdc202 AND t4.rtaxl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.pmdc203 AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.pmdc204 AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.pmdc205 AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t8 ON t8.ooeflent="||g_enterprise||" AND t8.ooefl001=t0.pmdc206 AND t8.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t9 ON t9.oocqlent="||g_enterprise||" AND t9.oocql001='263' AND t9.oocql002=t0.pmdc021 AND t9.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t10 ON t10.oocqlent="||g_enterprise||" AND t10.oocql001='267' AND t10.oocql002=t0.pmdc905 AND t10.oocql003='"||g_dlang||"' ",
 
                  " WHERE t0.pmdcent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("pmdc_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY pmdcdocno,pmdc900 ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"pmdc_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_pmdcsite,g_browser[g_cnt].b_pmdc902, 
          g_browser[g_cnt].b_pmdcdocno,g_browser[g_cnt].b_pmdc900,g_browser[g_cnt].b_pmdc001,g_browser[g_cnt].b_pmdc002, 
          g_browser[g_cnt].b_pmdc003,g_browser[g_cnt].b_pmdcacti,g_browser[g_cnt].b_pmdc200,g_browser[g_cnt].b_pmdc202, 
          g_browser[g_cnt].b_pmdc201,g_browser[g_cnt].b_pmdc203,g_browser[g_cnt].b_pmdc207,g_browser[g_cnt].b_pmdc204, 
          g_browser[g_cnt].b_pmdc205,g_browser[g_cnt].b_pmdc206,g_browser[g_cnt].b_pmdc021,g_browser[g_cnt].b_pmdc208, 
          g_browser[g_cnt].b_pmdc022,g_browser[g_cnt].b_pmdc905,g_browser[g_cnt].b_pmdc906,g_browser[g_cnt].b_pmdc901, 
          g_browser[g_cnt].b_pmdcdocdt,g_browser[g_cnt].b_pmdcsite_desc,g_browser[g_cnt].b_pmdc002_desc, 
          g_browser[g_cnt].b_pmdc003_desc,g_browser[g_cnt].b_pmdc202_desc,g_browser[g_cnt].b_pmdc203_desc, 
          g_browser[g_cnt].b_pmdc204_desc,g_browser[g_cnt].b_pmdc205_desc,g_browser[g_cnt].b_pmdc206_desc, 
          g_browser[g_cnt].b_pmdc021_desc,g_browser[g_cnt].b_pmdc905_desc
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
         CALL apmt835_browser_mask()
      
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
   
   IF cl_null(g_browser[g_cnt].b_pmdcdocno) THEN
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
 
{<section id="apmt835.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION apmt835_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_pmdc_m.pmdcdocno = g_browser[g_current_idx].b_pmdcdocno   
   LET g_pmdc_m.pmdc900 = g_browser[g_current_idx].b_pmdc900   
 
   EXECUTE apmt835_master_referesh USING g_pmdc_m.pmdcdocno,g_pmdc_m.pmdc900 INTO g_pmdc_m.pmdcsite, 
       g_pmdc_m.pmdc902,g_pmdc_m.pmdcdocno,g_pmdc_m.pmdc900,g_pmdc_m.pmdc001,g_pmdc_m.pmdc002,g_pmdc_m.pmdc003, 
       g_pmdc_m.pmdcstus,g_pmdc_m.pmdcacti,g_pmdc_m.pmdc200,g_pmdc_m.pmdc202,g_pmdc_m.pmdc201,g_pmdc_m.pmdc203, 
       g_pmdc_m.pmdc207,g_pmdc_m.pmdc204,g_pmdc_m.pmdc205,g_pmdc_m.pmdc206,g_pmdc_m.pmdc021,g_pmdc_m.pmdc208, 
       g_pmdc_m.pmdc022,g_pmdc_m.pmdc905,g_pmdc_m.pmdc901,g_pmdc_m.pmdc906,g_pmdc_m.pmdcdocdt,g_pmdc_m.pmdcownid, 
       g_pmdc_m.pmdcowndp,g_pmdc_m.pmdccrtid,g_pmdc_m.pmdccrtdp,g_pmdc_m.pmdccrtdt,g_pmdc_m.pmdcmodid, 
       g_pmdc_m.pmdcmoddt,g_pmdc_m.pmdccnfid,g_pmdc_m.pmdccnfdt,g_pmdc_m.pmdcsite_desc,g_pmdc_m.pmdc002_desc, 
       g_pmdc_m.pmdc003_desc,g_pmdc_m.pmdc202_desc,g_pmdc_m.pmdc203_desc,g_pmdc_m.pmdc204_desc,g_pmdc_m.pmdc205_desc, 
       g_pmdc_m.pmdc206_desc,g_pmdc_m.pmdc021_desc,g_pmdc_m.pmdc905_desc,g_pmdc_m.pmdcownid_desc,g_pmdc_m.pmdcowndp_desc, 
       g_pmdc_m.pmdccrtid_desc,g_pmdc_m.pmdccrtdp_desc,g_pmdc_m.pmdcmodid_desc,g_pmdc_m.pmdccnfid_desc 
 
   
   CALL apmt835_pmdc_t_mask()
   CALL apmt835_show()
      
END FUNCTION
 
{</section>}
 
{<section id="apmt835.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION apmt835_ui_detailshow()
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
 
{<section id="apmt835.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION apmt835_ui_browser_refresh()
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
      IF g_browser[l_i].b_pmdcdocno = g_pmdc_m.pmdcdocno 
         AND g_browser[l_i].b_pmdc900 = g_pmdc_m.pmdc900 
 
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
 
{<section id="apmt835.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION apmt835_construct()
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
   DEFINE l_sys       LIKE type_t.num5
   #end add-point    
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_pmdc_m.* TO NULL
   CALL g_pmdd_d.clear()        
 
   
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
      CONSTRUCT BY NAME g_wc ON pmdcsite,pmdc902,pmdcdocno,pmdc900,pmdc001,pmdc002,pmdc003,pmdcstus, 
          pmdcacti,pmdc200,pmdc202,pmdc201,pmdc203,pmdc207,pmdc204,pmdc205,pmdc206,pmdc021,pmdc208,pmdc022, 
          pmdc905,pmdc901,pmdc906,pmdcdocdt,pmdcownid,pmdcowndp,pmdccrtid,pmdccrtdp,pmdccrtdt,pmdcmodid, 
          pmdcmoddt,pmdccnfid,pmdccnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<pmdccrtdt>>----
         AFTER FIELD pmdccrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<pmdcmoddt>>----
         AFTER FIELD pmdcmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<pmdccnfdt>>----
         AFTER FIELD pmdccnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<pmdcpstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.pmdcsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdcsite
            #add-point:ON ACTION controlp INFIELD pmdcsite name="construct.c.pmdcsite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmdcsite',g_site,'c') #150308-00001#2  By sakura add 'c'            
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdcsite  #顯示到畫面上
            NEXT FIELD pmdcsite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdcsite
            #add-point:BEFORE FIELD pmdcsite name="construct.b.pmdcsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdcsite
            
            #add-point:AFTER FIELD pmdcsite name="construct.a.pmdcsite"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdc902
            #add-point:BEFORE FIELD pmdc902 name="construct.b.pmdc902"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdc902
            
            #add-point:AFTER FIELD pmdc902 name="construct.a.pmdc902"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdc902
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdc902
            #add-point:ON ACTION controlp INFIELD pmdc902 name="construct.c.pmdc902"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmdcdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdcdocno
            #add-point:ON ACTION controlp INFIELD pmdcdocno name="construct.c.pmdcdocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmdadocno()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdcdocno  #顯示到畫面上
            NEXT FIELD pmdcdocno                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdcdocno
            #add-point:BEFORE FIELD pmdcdocno name="construct.b.pmdcdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdcdocno
            
            #add-point:AFTER FIELD pmdcdocno name="construct.a.pmdcdocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdc900
            #add-point:BEFORE FIELD pmdc900 name="construct.b.pmdc900"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdc900
            
            #add-point:AFTER FIELD pmdc900 name="construct.a.pmdc900"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdc900
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdc900
            #add-point:ON ACTION controlp INFIELD pmdc900 name="construct.c.pmdc900"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdc001
            #add-point:BEFORE FIELD pmdc001 name="construct.b.pmdc001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdc001
            
            #add-point:AFTER FIELD pmdc001 name="construct.a.pmdc001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdc001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdc001
            #add-point:ON ACTION controlp INFIELD pmdc001 name="construct.c.pmdc001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmdc002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdc002
            #add-point:ON ACTION controlp INFIELD pmdc002 name="construct.c.pmdc002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdc002  #顯示到畫面上
            NEXT FIELD pmdc002                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdc002
            #add-point:BEFORE FIELD pmdc002 name="construct.b.pmdc002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdc002
            
            #add-point:AFTER FIELD pmdc002 name="construct.a.pmdc002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdc003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdc003
            #add-point:ON ACTION controlp INFIELD pmdc003 name="construct.c.pmdc003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdc003  #顯示到畫面上
            NEXT FIELD pmdc003                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdc003
            #add-point:BEFORE FIELD pmdc003 name="construct.b.pmdc003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdc003
            
            #add-point:AFTER FIELD pmdc003 name="construct.a.pmdc003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdcstus
            #add-point:BEFORE FIELD pmdcstus name="construct.b.pmdcstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdcstus
            
            #add-point:AFTER FIELD pmdcstus name="construct.a.pmdcstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdcstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdcstus
            #add-point:ON ACTION controlp INFIELD pmdcstus name="construct.c.pmdcstus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdcacti
            #add-point:BEFORE FIELD pmdcacti name="construct.b.pmdcacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdcacti
            
            #add-point:AFTER FIELD pmdcacti name="construct.a.pmdcacti"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdcacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdcacti
            #add-point:ON ACTION controlp INFIELD pmdcacti name="construct.c.pmdcacti"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdc200
            #add-point:BEFORE FIELD pmdc200 name="construct.b.pmdc200"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdc200
            
            #add-point:AFTER FIELD pmdc200 name="construct.a.pmdc200"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdc200
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdc200
            #add-point:ON ACTION controlp INFIELD pmdc200 name="construct.c.pmdc200"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmdc202
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdc202
            #add-point:ON ACTION controlp INFIELD pmdc202 name="construct.c.pmdc202"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL cl_get_para(g_enterprise,g_site,'E-CIR-0001') RETURNING l_sys
            LET g_qryparam.arg1 = l_sys
            CALL q_rtax001_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdc202  #顯示到畫面上
            NEXT FIELD pmdc202                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdc202
            #add-point:BEFORE FIELD pmdc202 name="construct.b.pmdc202"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdc202
            
            #add-point:AFTER FIELD pmdc202 name="construct.a.pmdc202"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdc201
            #add-point:BEFORE FIELD pmdc201 name="construct.b.pmdc201"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdc201
            
            #add-point:AFTER FIELD pmdc201 name="construct.a.pmdc201"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdc201
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdc201
            #add-point:ON ACTION controlp INFIELD pmdc201 name="construct.c.pmdc201"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmdc203
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdc203
            #add-point:ON ACTION controlp INFIELD pmdc203 name="construct.c.pmdc203"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE          

            LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmddsite',g_site,'c')
            CALL q_ooef001_24()                              #呼叫開窗

            DISPLAY g_qryparam.return1 TO pmdc203  #顯示到畫面上
            NEXT FIELD pmdc203                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdc203
            #add-point:BEFORE FIELD pmdc203 name="construct.b.pmdc203"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdc203
            
            #add-point:AFTER FIELD pmdc203 name="construct.a.pmdc203"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdc207
            #add-point:BEFORE FIELD pmdc207 name="construct.b.pmdc207"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdc207
            
            #add-point:AFTER FIELD pmdc207 name="construct.a.pmdc207"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdc207
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdc207
            #add-point:ON ACTION controlp INFIELD pmdc207 name="construct.c.pmdc207"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdc204
            #add-point:BEFORE FIELD pmdc204 name="construct.b.pmdc204"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdc204
            
            #add-point:AFTER FIELD pmdc204 name="construct.a.pmdc204"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdc204
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdc204
            #add-point:ON ACTION controlp INFIELD pmdc204 name="construct.c.pmdc204"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            IF s_aooi500_setpoint(g_prog,'pmdc204') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmdc204',g_site,'c')
               CALL q_ooef001_24()
            ELSE    
               LET g_qryparam.where = "ooef303 = 'Y'"
               CALL q_ooef001()  
            END IF
            DISPLAY g_qryparam.return1 TO pmdc204  #顯示到畫面上
            NEXT FIELD pmdc204                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdc205
            #add-point:BEFORE FIELD pmdc205 name="construct.b.pmdc205"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdc205
            
            #add-point:AFTER FIELD pmdc205 name="construct.a.pmdc205"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdc205
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdc205
            #add-point:ON ACTION controlp INFIELD pmdc205 name="construct.c.pmdc205"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            IF s_aooi500_setpoint(g_prog,'pmdc205') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmdc205',g_site,'c')
               CALL q_ooef001_24()
            ELSE    
               LET g_qryparam.where = "ooef302 = 'Y'"
               CALL q_ooef001()  
            END IF            
            DISPLAY g_qryparam.return1 TO pmdc205  #顯示到畫面上
            NEXT FIELD pmdc205                     #返回原欄位
            #END add-point
 
 
         #Ctrlp:construct.c.pmdc206
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdc206
            #add-point:ON ACTION controlp INFIELD pmdc206 name="construct.c.pmdc206"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdc206  #顯示到畫面上
            NEXT FIELD pmdc206                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdc206
            #add-point:BEFORE FIELD pmdc206 name="construct.b.pmdc206"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdc206
            
            #add-point:AFTER FIELD pmdc206 name="construct.a.pmdc206"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdc021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdc021
            #add-point:ON ACTION controlp INFIELD pmdc021 name="construct.c.pmdc021"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_pmdc021_acc
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdc021  #顯示到畫面上
            NEXT FIELD pmdc021                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdc021
            #add-point:BEFORE FIELD pmdc021 name="construct.b.pmdc021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdc021
            
            #add-point:AFTER FIELD pmdc021 name="construct.a.pmdc021"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdc208
            #add-point:BEFORE FIELD pmdc208 name="construct.b.pmdc208"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdc208
            
            #add-point:AFTER FIELD pmdc208 name="construct.a.pmdc208"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdc208
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdc208
            #add-point:ON ACTION controlp INFIELD pmdc208 name="construct.c.pmdc208"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdc022
            #add-point:BEFORE FIELD pmdc022 name="construct.b.pmdc022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdc022
            
            #add-point:AFTER FIELD pmdc022 name="construct.a.pmdc022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdc022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdc022
            #add-point:ON ACTION controlp INFIELD pmdc022 name="construct.c.pmdc022"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmdc905
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdc905
            #add-point:ON ACTION controlp INFIELD pmdc905 name="construct.c.pmdc905"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_pmdc905_acc
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdc905  #顯示到畫面上
            NEXT FIELD pmdc905                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdc905
            #add-point:BEFORE FIELD pmdc905 name="construct.b.pmdc905"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdc905
            
            #add-point:AFTER FIELD pmdc905 name="construct.a.pmdc905"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdc901
            #add-point:BEFORE FIELD pmdc901 name="construct.b.pmdc901"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdc901
            
            #add-point:AFTER FIELD pmdc901 name="construct.a.pmdc901"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdc901
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdc901
            #add-point:ON ACTION controlp INFIELD pmdc901 name="construct.c.pmdc901"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdc906
            #add-point:BEFORE FIELD pmdc906 name="construct.b.pmdc906"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdc906
            
            #add-point:AFTER FIELD pmdc906 name="construct.a.pmdc906"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdc906
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdc906
            #add-point:ON ACTION controlp INFIELD pmdc906 name="construct.c.pmdc906"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdcdocdt
            #add-point:BEFORE FIELD pmdcdocdt name="construct.b.pmdcdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdcdocdt
            
            #add-point:AFTER FIELD pmdcdocdt name="construct.a.pmdcdocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdcdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdcdocdt
            #add-point:ON ACTION controlp INFIELD pmdcdocdt name="construct.c.pmdcdocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmdcownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdcownid
            #add-point:ON ACTION controlp INFIELD pmdcownid name="construct.c.pmdcownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdcownid  #顯示到畫面上
            NEXT FIELD pmdcownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdcownid
            #add-point:BEFORE FIELD pmdcownid name="construct.b.pmdcownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdcownid
            
            #add-point:AFTER FIELD pmdcownid name="construct.a.pmdcownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdcowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdcowndp
            #add-point:ON ACTION controlp INFIELD pmdcowndp name="construct.c.pmdcowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdcowndp  #顯示到畫面上
            NEXT FIELD pmdcowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdcowndp
            #add-point:BEFORE FIELD pmdcowndp name="construct.b.pmdcowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdcowndp
            
            #add-point:AFTER FIELD pmdcowndp name="construct.a.pmdcowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdccrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdccrtid
            #add-point:ON ACTION controlp INFIELD pmdccrtid name="construct.c.pmdccrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdccrtid  #顯示到畫面上
            NEXT FIELD pmdccrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdccrtid
            #add-point:BEFORE FIELD pmdccrtid name="construct.b.pmdccrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdccrtid
            
            #add-point:AFTER FIELD pmdccrtid name="construct.a.pmdccrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdccrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdccrtdp
            #add-point:ON ACTION controlp INFIELD pmdccrtdp name="construct.c.pmdccrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdccrtdp  #顯示到畫面上
            NEXT FIELD pmdccrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdccrtdp
            #add-point:BEFORE FIELD pmdccrtdp name="construct.b.pmdccrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdccrtdp
            
            #add-point:AFTER FIELD pmdccrtdp name="construct.a.pmdccrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdccrtdt
            #add-point:BEFORE FIELD pmdccrtdt name="construct.b.pmdccrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmdcmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdcmodid
            #add-point:ON ACTION controlp INFIELD pmdcmodid name="construct.c.pmdcmodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdcmodid  #顯示到畫面上
            NEXT FIELD pmdcmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdcmodid
            #add-point:BEFORE FIELD pmdcmodid name="construct.b.pmdcmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdcmodid
            
            #add-point:AFTER FIELD pmdcmodid name="construct.a.pmdcmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdcmoddt
            #add-point:BEFORE FIELD pmdcmoddt name="construct.b.pmdcmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmdccnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdccnfid
            #add-point:ON ACTION controlp INFIELD pmdccnfid name="construct.c.pmdccnfid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdccnfid  #顯示到畫面上
            NEXT FIELD pmdccnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdccnfid
            #add-point:BEFORE FIELD pmdccnfid name="construct.b.pmdccnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdccnfid
            
            #add-point:AFTER FIELD pmdccnfid name="construct.a.pmdccnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdccnfdt
            #add-point:BEFORE FIELD pmdccnfdt name="construct.b.pmdccnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON pmddseq,pmdd001,pmdd002,pmdd003,pmddsite,pmdd200,pmdd004,pmdd005,pmdd005_desc, 
          pmdd033,pmdd037,pmdd260,pmdd038,pmdd227,pmdd201,pmdd202,pmdd212,pmdd007,pmdd006,pmdd253,pmdd258, 
          pmdd254,pmdd255,pmdd256,pmdd257,pmdd259,pmdd252,pmdd207,pmdd015,pmdd049,pmdd030,pmdd048,pmdd208, 
          pmdd209,pmdd206,pmdd210,pmdd211,pmdd205,pmdd203,pmdd204,l_pmdb032,pmdd032,pmdd901,pmdd902, 
          pmdd903
           FROM s_detail1[1].pmddseq,s_detail1[1].pmdd001,s_detail1[1].pmdd002,s_detail1[1].pmdd003, 
               s_detail1[1].pmddsite,s_detail1[1].pmdd200,s_detail1[1].pmdd004,s_detail1[1].pmdd005, 
               s_detail1[1].pmdd005_desc,s_detail1[1].pmdd033,s_detail1[1].pmdd037,s_detail1[1].pmdd260, 
               s_detail1[1].pmdd038,s_detail1[1].pmdd227,s_detail1[1].pmdd201,s_detail1[1].pmdd202,s_detail1[1].pmdd212, 
               s_detail1[1].pmdd007,s_detail1[1].pmdd006,s_detail1[1].pmdd253,s_detail1[1].pmdd258,s_detail1[1].pmdd254, 
               s_detail1[1].pmdd255,s_detail1[1].pmdd256,s_detail1[1].pmdd257,s_detail1[1].pmdd259,s_detail1[1].pmdd252, 
               s_detail1[1].pmdd207,s_detail1[1].pmdd015,s_detail1[1].pmdd049,s_detail1[1].pmdd030,s_detail1[1].pmdd048, 
               s_detail1[1].pmdd208,s_detail1[1].pmdd209,s_detail1[1].pmdd206,s_detail1[1].pmdd210,s_detail1[1].pmdd211, 
               s_detail1[1].pmdd205,s_detail1[1].pmdd203,s_detail1[1].pmdd204,s_detail1[1].l_pmdb032, 
               s_detail1[1].pmdd032,s_detail1[1].pmdd901,s_detail1[1].pmdd902,s_detail1[1].pmdd903
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmddseq
            #add-point:BEFORE FIELD pmddseq name="construct.b.page1.pmddseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmddseq
            
            #add-point:AFTER FIELD pmddseq name="construct.a.page1.pmddseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmddseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmddseq
            #add-point:ON ACTION controlp INFIELD pmddseq name="construct.c.page1.pmddseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd001
            #add-point:BEFORE FIELD pmdd001 name="construct.b.page1.pmdd001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd001
            
            #add-point:AFTER FIELD pmdd001 name="construct.a.page1.pmdd001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdd001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd001
            #add-point:ON ACTION controlp INFIELD pmdd001 name="construct.c.page1.pmdd001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd002
            #add-point:BEFORE FIELD pmdd002 name="construct.b.page1.pmdd002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd002
            
            #add-point:AFTER FIELD pmdd002 name="construct.a.page1.pmdd002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdd002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd002
            #add-point:ON ACTION controlp INFIELD pmdd002 name="construct.c.page1.pmdd002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd003
            #add-point:BEFORE FIELD pmdd003 name="construct.b.page1.pmdd003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd003
            
            #add-point:AFTER FIELD pmdd003 name="construct.a.page1.pmdd003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdd003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd003
            #add-point:ON ACTION controlp INFIELD pmdd003 name="construct.c.page1.pmdd003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.pmddsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmddsite
            #add-point:ON ACTION controlp INFIELD pmddsite name="construct.c.page1.pmddsite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmddsite',g_site,'c') #150308-00001#1  By Ken add 'c' 150309
            CALL q_ooef001_24()                              #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmddsite  #顯示到畫面上
            NEXT FIELD pmddsite                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmddsite
            #add-point:BEFORE FIELD pmddsite name="construct.b.page1.pmddsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmddsite
            
            #add-point:AFTER FIELD pmddsite name="construct.a.page1.pmddsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdd200
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd200
            #add-point:ON ACTION controlp INFIELD pmdd200 name="construct.c.page1.pmdd200"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imay003_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdd200  #顯示到畫面上
            NEXT FIELD pmdd200                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd200
            #add-point:BEFORE FIELD pmdd200 name="construct.b.page1.pmdd200"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd200
            
            #add-point:AFTER FIELD pmdd200 name="construct.a.page1.pmdd200"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdd004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd004
            #add-point:ON ACTION controlp INFIELD pmdd004 name="construct.c.page1.pmdd004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdd004  #顯示到畫面上
            NEXT FIELD pmdd004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd004
            #add-point:BEFORE FIELD pmdd004 name="construct.b.page1.pmdd004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd004
            
            #add-point:AFTER FIELD pmdd004 name="construct.a.page1.pmdd004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd005
            #add-point:BEFORE FIELD pmdd005 name="construct.b.page1.pmdd005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd005
            
            #add-point:AFTER FIELD pmdd005 name="construct.a.page1.pmdd005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdd005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd005
            #add-point:ON ACTION controlp INFIELD pmdd005 name="construct.c.page1.pmdd005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd005_desc
            #add-point:BEFORE FIELD pmdd005_desc name="construct.b.page1.pmdd005_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd005_desc
            
            #add-point:AFTER FIELD pmdd005_desc name="construct.a.page1.pmdd005_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdd005_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd005_desc
            #add-point:ON ACTION controlp INFIELD pmdd005_desc name="construct.c.page1.pmdd005_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd033
            #add-point:BEFORE FIELD pmdd033 name="construct.b.page1.pmdd033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd033
            
            #add-point:AFTER FIELD pmdd033 name="construct.a.page1.pmdd033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdd033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd033
            #add-point:ON ACTION controlp INFIELD pmdd033 name="construct.c.page1.pmdd033"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.pmdd037
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd037
            #add-point:ON ACTION controlp INFIELD pmdd037 name="construct.c.page1.pmdd037"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            
            #判斷aooi500是否有設定
            IF s_aooi500_setpoint(g_prog,'pmdd037') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmdd037',g_site,'c')
               CALL q_ooef001_24()
            ELSE    
               LET g_qryparam.arg1 = g_pmdd_d[l_ac].pmddsite
               LET g_qryparam.arg2 = 8
               CALL q_ooed004_3()
            END IF   

            DISPLAY g_qryparam.return1 TO pmdd037  #顯示到畫面上
            NEXT FIELD pmdd037                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd037
            #add-point:BEFORE FIELD pmdd037 name="construct.b.page1.pmdd037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd037
            
            #add-point:AFTER FIELD pmdd037 name="construct.a.page1.pmdd037"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdd260
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd260
            #add-point:ON ACTION controlp INFIELD pmdd260 name="construct.c.page1.pmdd260"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            
            LET g_qryparam.arg1 = g_pmdc_m.pmdc902 #
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdd260  #顯示到畫面上
            NEXT FIELD pmdd260                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd260
            #add-point:BEFORE FIELD pmdd260 name="construct.b.page1.pmdd260"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd260
            
            #add-point:AFTER FIELD pmdd260 name="construct.a.page1.pmdd260"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdd038
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd038
            #add-point:ON ACTION controlp INFIELD pmdd038 name="construct.c.page1.pmdd038"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdd038  #顯示到畫面上
            NEXT FIELD pmdd038                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd038
            #add-point:BEFORE FIELD pmdd038 name="construct.b.page1.pmdd038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd038
            
            #add-point:AFTER FIELD pmdd038 name="construct.a.page1.pmdd038"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd227
            #add-point:BEFORE FIELD pmdd227 name="construct.b.page1.pmdd227"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd227
            
            #add-point:AFTER FIELD pmdd227 name="construct.a.page1.pmdd227"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdd227
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd227
            #add-point:ON ACTION controlp INFIELD pmdd227 name="construct.c.page1.pmdd227"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.pmdd201
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd201
            #add-point:ON ACTION controlp INFIELD pmdd201 name="construct.c.page1.pmdd201"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdd201  #顯示到畫面上
            NEXT FIELD pmdd201                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd201
            #add-point:BEFORE FIELD pmdd201 name="construct.b.page1.pmdd201"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd201
            
            #add-point:AFTER FIELD pmdd201 name="construct.a.page1.pmdd201"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd202
            #add-point:BEFORE FIELD pmdd202 name="construct.b.page1.pmdd202"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd202
            
            #add-point:AFTER FIELD pmdd202 name="construct.a.page1.pmdd202"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdd202
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd202
            #add-point:ON ACTION controlp INFIELD pmdd202 name="construct.c.page1.pmdd202"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd212
            #add-point:BEFORE FIELD pmdd212 name="construct.b.page1.pmdd212"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd212
            
            #add-point:AFTER FIELD pmdd212 name="construct.a.page1.pmdd212"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdd212
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd212
            #add-point:ON ACTION controlp INFIELD pmdd212 name="construct.c.page1.pmdd212"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.pmdd007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd007
            #add-point:ON ACTION controlp INFIELD pmdd007 name="construct.c.page1.pmdd007"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdd007  #顯示到畫面上
            NEXT FIELD pmdd007                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd007
            #add-point:BEFORE FIELD pmdd007 name="construct.b.page1.pmdd007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd007
            
            #add-point:AFTER FIELD pmdd007 name="construct.a.page1.pmdd007"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd006
            #add-point:BEFORE FIELD pmdd006 name="construct.b.page1.pmdd006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd006
            
            #add-point:AFTER FIELD pmdd006 name="construct.a.page1.pmdd006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdd006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd006
            #add-point:ON ACTION controlp INFIELD pmdd006 name="construct.c.page1.pmdd006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd253
            #add-point:BEFORE FIELD pmdd253 name="construct.b.page1.pmdd253"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd253
            
            #add-point:AFTER FIELD pmdd253 name="construct.a.page1.pmdd253"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdd253
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd253
            #add-point:ON ACTION controlp INFIELD pmdd253 name="construct.c.page1.pmdd253"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd258
            #add-point:BEFORE FIELD pmdd258 name="construct.b.page1.pmdd258"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd258
            
            #add-point:AFTER FIELD pmdd258 name="construct.a.page1.pmdd258"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdd258
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd258
            #add-point:ON ACTION controlp INFIELD pmdd258 name="construct.c.page1.pmdd258"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd254
            #add-point:BEFORE FIELD pmdd254 name="construct.b.page1.pmdd254"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd254
            
            #add-point:AFTER FIELD pmdd254 name="construct.a.page1.pmdd254"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdd254
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd254
            #add-point:ON ACTION controlp INFIELD pmdd254 name="construct.c.page1.pmdd254"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd255
            #add-point:BEFORE FIELD pmdd255 name="construct.b.page1.pmdd255"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd255
            
            #add-point:AFTER FIELD pmdd255 name="construct.a.page1.pmdd255"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdd255
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd255
            #add-point:ON ACTION controlp INFIELD pmdd255 name="construct.c.page1.pmdd255"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd256
            #add-point:BEFORE FIELD pmdd256 name="construct.b.page1.pmdd256"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd256
            
            #add-point:AFTER FIELD pmdd256 name="construct.a.page1.pmdd256"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdd256
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd256
            #add-point:ON ACTION controlp INFIELD pmdd256 name="construct.c.page1.pmdd256"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd257
            #add-point:BEFORE FIELD pmdd257 name="construct.b.page1.pmdd257"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd257
            
            #add-point:AFTER FIELD pmdd257 name="construct.a.page1.pmdd257"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdd257
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd257
            #add-point:ON ACTION controlp INFIELD pmdd257 name="construct.c.page1.pmdd257"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd259
            #add-point:BEFORE FIELD pmdd259 name="construct.b.page1.pmdd259"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd259
            
            #add-point:AFTER FIELD pmdd259 name="construct.a.page1.pmdd259"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdd259
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd259
            #add-point:ON ACTION controlp INFIELD pmdd259 name="construct.c.page1.pmdd259"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd252
            #add-point:BEFORE FIELD pmdd252 name="construct.b.page1.pmdd252"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd252
            
            #add-point:AFTER FIELD pmdd252 name="construct.a.page1.pmdd252"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdd252
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd252
            #add-point:ON ACTION controlp INFIELD pmdd252 name="construct.c.page1.pmdd252"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd207
            #add-point:BEFORE FIELD pmdd207 name="construct.b.page1.pmdd207"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd207
            
            #add-point:AFTER FIELD pmdd207 name="construct.a.page1.pmdd207"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdd207
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd207
            #add-point:ON ACTION controlp INFIELD pmdd207 name="construct.c.page1.pmdd207"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.pmdd015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd015
            #add-point:ON ACTION controlp INFIELD pmdd015 name="construct.c.page1.pmdd015"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdd015  #顯示到畫面上
            NEXT FIELD pmdd015                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd015
            #add-point:BEFORE FIELD pmdd015 name="construct.b.page1.pmdd015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd015
            
            #add-point:AFTER FIELD pmdd015 name="construct.a.page1.pmdd015"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd049
            #add-point:BEFORE FIELD pmdd049 name="construct.b.page1.pmdd049"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd049
            
            #add-point:AFTER FIELD pmdd049 name="construct.a.page1.pmdd049"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdd049
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd049
            #add-point:ON ACTION controlp INFIELD pmdd049 name="construct.c.page1.pmdd049"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd030
            #add-point:BEFORE FIELD pmdd030 name="construct.b.page1.pmdd030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd030
            
            #add-point:AFTER FIELD pmdd030 name="construct.a.page1.pmdd030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdd030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd030
            #add-point:ON ACTION controlp INFIELD pmdd030 name="construct.c.page1.pmdd030"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.pmdd048
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd048
            #add-point:ON ACTION controlp INFIELD pmdd048 name="construct.c.page1.pmdd048"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_pmdd048_acc
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdd048  #顯示到畫面上
            NEXT FIELD pmdd048                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd048
            #add-point:BEFORE FIELD pmdd048 name="construct.b.page1.pmdd048"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd048
            
            #add-point:AFTER FIELD pmdd048 name="construct.a.page1.pmdd048"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd208
            #add-point:BEFORE FIELD pmdd208 name="construct.b.page1.pmdd208"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd208
            
            #add-point:AFTER FIELD pmdd208 name="construct.a.page1.pmdd208"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdd208
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd208
            #add-point:ON ACTION controlp INFIELD pmdd208 name="construct.c.page1.pmdd208"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.pmdd209
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd209
            #add-point:ON ACTION controlp INFIELD pmdd209 name="construct.c.page1.pmdd209"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_staa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdd209  #顯示到畫面上
            NEXT FIELD pmdd209                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd209
            #add-point:BEFORE FIELD pmdd209 name="construct.b.page1.pmdd209"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd209
            
            #add-point:AFTER FIELD pmdd209 name="construct.a.page1.pmdd209"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdd206
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd206
            #add-point:ON ACTION controlp INFIELD pmdd206 name="construct.c.page1.pmdd206"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdd206  #顯示到畫面上
            NEXT FIELD pmdd206                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd206
            #add-point:BEFORE FIELD pmdd206 name="construct.b.page1.pmdd206"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd206
            
            #add-point:AFTER FIELD pmdd206 name="construct.a.page1.pmdd206"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd210
            #add-point:BEFORE FIELD pmdd210 name="construct.b.page1.pmdd210"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd210
            
            #add-point:AFTER FIELD pmdd210 name="construct.a.page1.pmdd210"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdd210
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd210
            #add-point:ON ACTION controlp INFIELD pmdd210 name="construct.c.page1.pmdd210"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd211
            #add-point:BEFORE FIELD pmdd211 name="construct.b.page1.pmdd211"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd211
            
            #add-point:AFTER FIELD pmdd211 name="construct.a.page1.pmdd211"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdd211
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd211
            #add-point:ON ACTION controlp INFIELD pmdd211 name="construct.c.page1.pmdd211"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd205
            #add-point:BEFORE FIELD pmdd205 name="construct.b.page1.pmdd205"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd205
            
            #add-point:AFTER FIELD pmdd205 name="construct.a.page1.pmdd205"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdd205
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd205
            #add-point:ON ACTION controlp INFIELD pmdd205 name="construct.c.page1.pmdd205"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
           
            #判斷aooi500是否有設定
            IF s_aooi500_setpoint(g_prog,'pmdd205') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmdd205',g_site,'c') #150308-00001#1  By Ken add 'c' 150309
               CALL q_ooef001_24()
            ELSE    
               LET g_qryparam.where = "ooef303 = 'Y'" #採購中心
               CALL q_ooef001()  
            END IF            
            DISPLAY g_qryparam.return1 TO pmdd205  #顯示到畫面上

            NEXT FIELD pmdd205                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd203
            #add-point:BEFORE FIELD pmdd203 name="construct.b.page1.pmdd203"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd203
            
            #add-point:AFTER FIELD pmdd203 name="construct.a.page1.pmdd203"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdd203
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd203
            #add-point:ON ACTION controlp INFIELD pmdd203 name="construct.c.page1.pmdd203"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE        
            
            #判斷aooi500是否有設定
            IF s_aooi500_setpoint(g_prog,'pmdd203') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmdd203',g_site,'c') #150308-00001#1  By Ken add 'c' 150309
               CALL q_ooef001_24()
            ELSE    
               LET g_qryparam.where = "ooef302 = 'Y'" #配送中心
               CALL q_ooef001()  
            END IF   
            DISPLAY g_qryparam.return1 TO pmdd203  #顯示到畫面上

            NEXT FIELD pmdd203                     #返回原欄位
            #END add-point
 
 
         #Ctrlp:construct.c.page1.pmdd204
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd204
            #add-point:ON ACTION controlp INFIELD pmdd204 name="construct.c.page1.pmdd204"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_pmdd_d[l_ac].pmdd203
            CALL q_inaa001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdd204  #顯示到畫面上
            NEXT FIELD pmdd204                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd204
            #add-point:BEFORE FIELD pmdd204 name="construct.b.page1.pmdd204"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd204
            
            #add-point:AFTER FIELD pmdd204 name="construct.a.page1.pmdd204"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_pmdb032
            #add-point:BEFORE FIELD l_pmdb032 name="construct.b.page1.l_pmdb032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_pmdb032
            
            #add-point:AFTER FIELD l_pmdb032 name="construct.a.page1.l_pmdb032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_pmdb032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_pmdb032
            #add-point:ON ACTION controlp INFIELD l_pmdb032 name="construct.c.page1.l_pmdb032"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd032
            #add-point:BEFORE FIELD pmdd032 name="construct.b.page1.pmdd032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd032
            
            #add-point:AFTER FIELD pmdd032 name="construct.a.page1.pmdd032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdd032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd032
            #add-point:ON ACTION controlp INFIELD pmdd032 name="construct.c.page1.pmdd032"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd901
            #add-point:BEFORE FIELD pmdd901 name="construct.b.page1.pmdd901"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd901
            
            #add-point:AFTER FIELD pmdd901 name="construct.a.page1.pmdd901"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdd901
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd901
            #add-point:ON ACTION controlp INFIELD pmdd901 name="construct.c.page1.pmdd901"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.pmdd902
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd902
            #add-point:ON ACTION controlp INFIELD pmdd902 name="construct.c.page1.pmdd902"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_pmdd902_acc           
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdd902  #顯示到畫面上
            NEXT FIELD pmdd902                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd902
            #add-point:BEFORE FIELD pmdd902 name="construct.b.page1.pmdd902"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd902
            
            #add-point:AFTER FIELD pmdd902 name="construct.a.page1.pmdd902"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd903
            #add-point:BEFORE FIELD pmdd903 name="construct.b.page1.pmdd903"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd903
            
            #add-point:AFTER FIELD pmdd903 name="construct.a.page1.pmdd903"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdd903
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd903
            #add-point:ON ACTION controlp INFIELD pmdd903 name="construct.c.page1.pmdd903"
            
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
                  WHEN la_wc[li_idx].tableid = "pmdc_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "pmdd_t" 
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
 
{<section id="apmt835.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION apmt835_filter()
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
      CONSTRUCT g_wc_filter ON pmdcsite,pmdc902,pmdcdocno,pmdc900,pmdc001,pmdc002,pmdc003,pmdcacti,pmdc200, 
          pmdc202,pmdc201,pmdc203,pmdc207,pmdc204,pmdc205,pmdc206,pmdc021,pmdc208,pmdc022,pmdc905,pmdc906, 
          pmdc901,pmdcdocdt
                          FROM s_browse[1].b_pmdcsite,s_browse[1].b_pmdc902,s_browse[1].b_pmdcdocno, 
                              s_browse[1].b_pmdc900,s_browse[1].b_pmdc001,s_browse[1].b_pmdc002,s_browse[1].b_pmdc003, 
                              s_browse[1].b_pmdcacti,s_browse[1].b_pmdc200,s_browse[1].b_pmdc202,s_browse[1].b_pmdc201, 
                              s_browse[1].b_pmdc203,s_browse[1].b_pmdc207,s_browse[1].b_pmdc204,s_browse[1].b_pmdc205, 
                              s_browse[1].b_pmdc206,s_browse[1].b_pmdc021,s_browse[1].b_pmdc208,s_browse[1].b_pmdc022, 
                              s_browse[1].b_pmdc905,s_browse[1].b_pmdc906,s_browse[1].b_pmdc901,s_browse[1].b_pmdcdocdt 
 
 
         BEFORE CONSTRUCT
               DISPLAY apmt835_filter_parser('pmdcsite') TO s_browse[1].b_pmdcsite
            DISPLAY apmt835_filter_parser('pmdc902') TO s_browse[1].b_pmdc902
            DISPLAY apmt835_filter_parser('pmdcdocno') TO s_browse[1].b_pmdcdocno
            DISPLAY apmt835_filter_parser('pmdc900') TO s_browse[1].b_pmdc900
            DISPLAY apmt835_filter_parser('pmdc001') TO s_browse[1].b_pmdc001
            DISPLAY apmt835_filter_parser('pmdc002') TO s_browse[1].b_pmdc002
            DISPLAY apmt835_filter_parser('pmdc003') TO s_browse[1].b_pmdc003
            DISPLAY apmt835_filter_parser('pmdcacti') TO s_browse[1].b_pmdcacti
            DISPLAY apmt835_filter_parser('pmdc200') TO s_browse[1].b_pmdc200
            DISPLAY apmt835_filter_parser('pmdc202') TO s_browse[1].b_pmdc202
            DISPLAY apmt835_filter_parser('pmdc201') TO s_browse[1].b_pmdc201
            DISPLAY apmt835_filter_parser('pmdc203') TO s_browse[1].b_pmdc203
            DISPLAY apmt835_filter_parser('pmdc207') TO s_browse[1].b_pmdc207
            DISPLAY apmt835_filter_parser('pmdc204') TO s_browse[1].b_pmdc204
            DISPLAY apmt835_filter_parser('pmdc205') TO s_browse[1].b_pmdc205
            DISPLAY apmt835_filter_parser('pmdc206') TO s_browse[1].b_pmdc206
            DISPLAY apmt835_filter_parser('pmdc021') TO s_browse[1].b_pmdc021
            DISPLAY apmt835_filter_parser('pmdc208') TO s_browse[1].b_pmdc208
            DISPLAY apmt835_filter_parser('pmdc022') TO s_browse[1].b_pmdc022
            DISPLAY apmt835_filter_parser('pmdc905') TO s_browse[1].b_pmdc905
            DISPLAY apmt835_filter_parser('pmdc906') TO s_browse[1].b_pmdc906
            DISPLAY apmt835_filter_parser('pmdc901') TO s_browse[1].b_pmdc901
            DISPLAY apmt835_filter_parser('pmdcdocdt') TO s_browse[1].b_pmdcdocdt
      
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
 
      CALL apmt835_filter_show('pmdcsite')
   CALL apmt835_filter_show('pmdc902')
   CALL apmt835_filter_show('pmdcdocno')
   CALL apmt835_filter_show('pmdc900')
   CALL apmt835_filter_show('pmdc001')
   CALL apmt835_filter_show('pmdc002')
   CALL apmt835_filter_show('pmdc003')
   CALL apmt835_filter_show('pmdcacti')
   CALL apmt835_filter_show('pmdc200')
   CALL apmt835_filter_show('pmdc202')
   CALL apmt835_filter_show('pmdc201')
   CALL apmt835_filter_show('pmdc203')
   CALL apmt835_filter_show('pmdc207')
   CALL apmt835_filter_show('pmdc204')
   CALL apmt835_filter_show('pmdc205')
   CALL apmt835_filter_show('pmdc206')
   CALL apmt835_filter_show('pmdc021')
   CALL apmt835_filter_show('pmdc208')
   CALL apmt835_filter_show('pmdc022')
   CALL apmt835_filter_show('pmdc905')
   CALL apmt835_filter_show('pmdc906')
   CALL apmt835_filter_show('pmdc901')
   CALL apmt835_filter_show('pmdcdocdt')
 
END FUNCTION
 
{</section>}
 
{<section id="apmt835.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION apmt835_filter_parser(ps_field)
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
 
{<section id="apmt835.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION apmt835_filter_show(ps_field)
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
   LET ls_condition = apmt835_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="apmt835.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION apmt835_query()
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
   CALL g_pmdd_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL apmt835_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL apmt835_browser_fill("")
      CALL apmt835_fetch("")
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
      CALL apmt835_filter_show('pmdcsite')
   CALL apmt835_filter_show('pmdc902')
   CALL apmt835_filter_show('pmdcdocno')
   CALL apmt835_filter_show('pmdc900')
   CALL apmt835_filter_show('pmdc001')
   CALL apmt835_filter_show('pmdc002')
   CALL apmt835_filter_show('pmdc003')
   CALL apmt835_filter_show('pmdcacti')
   CALL apmt835_filter_show('pmdc200')
   CALL apmt835_filter_show('pmdc202')
   CALL apmt835_filter_show('pmdc201')
   CALL apmt835_filter_show('pmdc203')
   CALL apmt835_filter_show('pmdc207')
   CALL apmt835_filter_show('pmdc204')
   CALL apmt835_filter_show('pmdc205')
   CALL apmt835_filter_show('pmdc206')
   CALL apmt835_filter_show('pmdc021')
   CALL apmt835_filter_show('pmdc208')
   CALL apmt835_filter_show('pmdc022')
   CALL apmt835_filter_show('pmdc905')
   CALL apmt835_filter_show('pmdc906')
   CALL apmt835_filter_show('pmdc901')
   CALL apmt835_filter_show('pmdcdocdt')
   CALL apmt835_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL apmt835_fetch("F") 
      #顯示單身筆數
      CALL apmt835_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="apmt835.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION apmt835_fetch(p_flag)
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
   
   LET g_pmdc_m.pmdcdocno = g_browser[g_current_idx].b_pmdcdocno
   LET g_pmdc_m.pmdc900 = g_browser[g_current_idx].b_pmdc900
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE apmt835_master_referesh USING g_pmdc_m.pmdcdocno,g_pmdc_m.pmdc900 INTO g_pmdc_m.pmdcsite, 
       g_pmdc_m.pmdc902,g_pmdc_m.pmdcdocno,g_pmdc_m.pmdc900,g_pmdc_m.pmdc001,g_pmdc_m.pmdc002,g_pmdc_m.pmdc003, 
       g_pmdc_m.pmdcstus,g_pmdc_m.pmdcacti,g_pmdc_m.pmdc200,g_pmdc_m.pmdc202,g_pmdc_m.pmdc201,g_pmdc_m.pmdc203, 
       g_pmdc_m.pmdc207,g_pmdc_m.pmdc204,g_pmdc_m.pmdc205,g_pmdc_m.pmdc206,g_pmdc_m.pmdc021,g_pmdc_m.pmdc208, 
       g_pmdc_m.pmdc022,g_pmdc_m.pmdc905,g_pmdc_m.pmdc901,g_pmdc_m.pmdc906,g_pmdc_m.pmdcdocdt,g_pmdc_m.pmdcownid, 
       g_pmdc_m.pmdcowndp,g_pmdc_m.pmdccrtid,g_pmdc_m.pmdccrtdp,g_pmdc_m.pmdccrtdt,g_pmdc_m.pmdcmodid, 
       g_pmdc_m.pmdcmoddt,g_pmdc_m.pmdccnfid,g_pmdc_m.pmdccnfdt,g_pmdc_m.pmdcsite_desc,g_pmdc_m.pmdc002_desc, 
       g_pmdc_m.pmdc003_desc,g_pmdc_m.pmdc202_desc,g_pmdc_m.pmdc203_desc,g_pmdc_m.pmdc204_desc,g_pmdc_m.pmdc205_desc, 
       g_pmdc_m.pmdc206_desc,g_pmdc_m.pmdc021_desc,g_pmdc_m.pmdc905_desc,g_pmdc_m.pmdcownid_desc,g_pmdc_m.pmdcowndp_desc, 
       g_pmdc_m.pmdccrtid_desc,g_pmdc_m.pmdccrtdp_desc,g_pmdc_m.pmdcmodid_desc,g_pmdc_m.pmdccnfid_desc 
 
   
   #遮罩相關處理
   LET g_pmdc_m_mask_o.* =  g_pmdc_m.*
   CALL apmt835_pmdc_t_mask()
   LET g_pmdc_m_mask_n.* =  g_pmdc_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL apmt835_set_act_visible()   
   CALL apmt835_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
 
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_pmdc_m_t.* = g_pmdc_m.*
   LET g_pmdc_m_o.* = g_pmdc_m.*
   
   LET g_data_owner = g_pmdc_m.pmdcownid      
   LET g_data_dept  = g_pmdc_m.pmdcowndp
   
   #重新顯示   
   CALL apmt835_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="apmt835.insert" >}
#+ 資料新增
PRIVATE FUNCTION apmt835_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE l_insert  LIKE type_t.num5
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_pmdd_d.clear()   
 
 
   INITIALIZE g_pmdc_m.* TO NULL             #DEFAULT 設定
   
   LET g_pmdcdocno_t = NULL
   LET g_pmdc900_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_pmdc_m.pmdcownid = g_user
      LET g_pmdc_m.pmdcowndp = g_dept
      LET g_pmdc_m.pmdccrtid = g_user
      LET g_pmdc_m.pmdccrtdp = g_dept 
      LET g_pmdc_m.pmdccrtdt = cl_get_current()
      LET g_pmdc_m.pmdcmodid = g_user
      LET g_pmdc_m.pmdcmoddt = cl_get_current()
      LET g_pmdc_m.pmdcstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_pmdc_m.pmdc900 = "0"
      LET g_pmdc_m.pmdc001 = "0"
      LET g_pmdc_m.pmdcstus = "N"
      LET g_pmdc_m.pmdcacti = "N"
      LET g_pmdc_m.pmdc208 = "0"
      LET g_pmdc_m.pmdc901 = "N"
 
  
      #add-point:單頭預設值 name="insert.default"
      CALL s_hint_show('pmde_t','pmdc_t','pmda_t',' ',' ','','','')
      CALL s_hint_show('pmde_t','pmdd_t','pmdb_t',' ',' ','','','')
      #變更日期
      LET g_pmdc_m.pmdc902 = g_today
      #要貨組織
      CALL s_aooi500_default(g_prog,'pmdcsite',g_pmdc_m.pmdcsite) RETURNING l_insert,g_pmdc_m.pmdcsite
      IF NOT l_insert THEN
         RETURN
      END IF
      CALL s_desc_get_department_desc(g_pmdc_m.pmdcsite) RETURNING g_pmdc_m.pmdcsite_desc
      DISPLAY BY NAME g_pmdc_m.pmdcsite,g_pmdc_m.pmdcsite_desc      
      #單頭變更類型
      LET g_pmdc_m.pmdc901 = 'N'
      
      INITIALIZE g_pmdc_m_t.* TO NULL
      LET g_pmdc_m_t.* = g_pmdc_m.* 
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_pmdc_m_t.* = g_pmdc_m.*
      LET g_pmdc_m_o.* = g_pmdc_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_pmdc_m.pmdcstus 
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
 
 
 
    
      CALL apmt835_input("a")
      
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
         INITIALIZE g_pmdc_m.* TO NULL
         INITIALIZE g_pmdd_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL apmt835_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_pmdd_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL apmt835_set_act_visible()   
   CALL apmt835_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_pmdcdocno_t = g_pmdc_m.pmdcdocno
   LET g_pmdc900_t = g_pmdc_m.pmdc900
 
   
   #組合新增資料的條件
   LET g_add_browse = " pmdcent = " ||g_enterprise|| " AND",
                      " pmdcdocno = '", g_pmdc_m.pmdcdocno, "' "
                      ," AND pmdc900 = '", g_pmdc_m.pmdc900, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL apmt835_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE apmt835_cl
   
   CALL apmt835_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE apmt835_master_referesh USING g_pmdc_m.pmdcdocno,g_pmdc_m.pmdc900 INTO g_pmdc_m.pmdcsite, 
       g_pmdc_m.pmdc902,g_pmdc_m.pmdcdocno,g_pmdc_m.pmdc900,g_pmdc_m.pmdc001,g_pmdc_m.pmdc002,g_pmdc_m.pmdc003, 
       g_pmdc_m.pmdcstus,g_pmdc_m.pmdcacti,g_pmdc_m.pmdc200,g_pmdc_m.pmdc202,g_pmdc_m.pmdc201,g_pmdc_m.pmdc203, 
       g_pmdc_m.pmdc207,g_pmdc_m.pmdc204,g_pmdc_m.pmdc205,g_pmdc_m.pmdc206,g_pmdc_m.pmdc021,g_pmdc_m.pmdc208, 
       g_pmdc_m.pmdc022,g_pmdc_m.pmdc905,g_pmdc_m.pmdc901,g_pmdc_m.pmdc906,g_pmdc_m.pmdcdocdt,g_pmdc_m.pmdcownid, 
       g_pmdc_m.pmdcowndp,g_pmdc_m.pmdccrtid,g_pmdc_m.pmdccrtdp,g_pmdc_m.pmdccrtdt,g_pmdc_m.pmdcmodid, 
       g_pmdc_m.pmdcmoddt,g_pmdc_m.pmdccnfid,g_pmdc_m.pmdccnfdt,g_pmdc_m.pmdcsite_desc,g_pmdc_m.pmdc002_desc, 
       g_pmdc_m.pmdc003_desc,g_pmdc_m.pmdc202_desc,g_pmdc_m.pmdc203_desc,g_pmdc_m.pmdc204_desc,g_pmdc_m.pmdc205_desc, 
       g_pmdc_m.pmdc206_desc,g_pmdc_m.pmdc021_desc,g_pmdc_m.pmdc905_desc,g_pmdc_m.pmdcownid_desc,g_pmdc_m.pmdcowndp_desc, 
       g_pmdc_m.pmdccrtid_desc,g_pmdc_m.pmdccrtdp_desc,g_pmdc_m.pmdcmodid_desc,g_pmdc_m.pmdccnfid_desc 
 
   
   
   #遮罩相關處理
   LET g_pmdc_m_mask_o.* =  g_pmdc_m.*
   CALL apmt835_pmdc_t_mask()
   LET g_pmdc_m_mask_n.* =  g_pmdc_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_pmdc_m.pmdcsite,g_pmdc_m.pmdcsite_desc,g_pmdc_m.pmdc902,g_pmdc_m.pmdcdocno,g_pmdc_m.pmdc900, 
       g_pmdc_m.pmdc001,g_pmdc_m.pmdc002,g_pmdc_m.pmdc002_desc,g_pmdc_m.pmdc003,g_pmdc_m.pmdc003_desc, 
       g_pmdc_m.pmdcstus,g_pmdc_m.pmdcacti,g_pmdc_m.pmdc200,g_pmdc_m.pmdc202,g_pmdc_m.pmdc202_desc,g_pmdc_m.pmdc201, 
       g_pmdc_m.pmdc203,g_pmdc_m.pmdc203_desc,g_pmdc_m.pmdc207,g_pmdc_m.pmdc204,g_pmdc_m.pmdc204_desc, 
       g_pmdc_m.pmdc205,g_pmdc_m.pmdc205_desc,g_pmdc_m.pmdc206,g_pmdc_m.pmdc206_desc,g_pmdc_m.pmdc021, 
       g_pmdc_m.pmdc021_desc,g_pmdc_m.pmdc208,g_pmdc_m.pmdc022,g_pmdc_m.pmdc905,g_pmdc_m.pmdc905_desc, 
       g_pmdc_m.pmdc901,g_pmdc_m.pmdc906,g_pmdc_m.pmdcdocdt,g_pmdc_m.pmdcownid,g_pmdc_m.pmdcownid_desc, 
       g_pmdc_m.pmdcowndp,g_pmdc_m.pmdcowndp_desc,g_pmdc_m.pmdccrtid,g_pmdc_m.pmdccrtid_desc,g_pmdc_m.pmdccrtdp, 
       g_pmdc_m.pmdccrtdp_desc,g_pmdc_m.pmdccrtdt,g_pmdc_m.pmdcmodid,g_pmdc_m.pmdcmodid_desc,g_pmdc_m.pmdcmoddt, 
       g_pmdc_m.pmdccnfid,g_pmdc_m.pmdccnfid_desc,g_pmdc_m.pmdccnfdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_pmdc_m.pmdcownid      
   LET g_data_dept  = g_pmdc_m.pmdcowndp
   
   #功能已完成,通報訊息中心
   CALL apmt835_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="apmt835.modify" >}
#+ 資料修改
PRIVATE FUNCTION apmt835_modify()
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
   LET g_pmdc_m_t.* = g_pmdc_m.*
   LET g_pmdc_m_o.* = g_pmdc_m.*
   
   IF g_pmdc_m.pmdcdocno IS NULL
   OR g_pmdc_m.pmdc900 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_pmdcdocno_t = g_pmdc_m.pmdcdocno
   LET g_pmdc900_t = g_pmdc_m.pmdc900
 
   CALL s_transaction_begin()
   
   OPEN apmt835_cl USING g_enterprise,g_pmdc_m.pmdcdocno,g_pmdc_m.pmdc900
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apmt835_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE apmt835_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE apmt835_master_referesh USING g_pmdc_m.pmdcdocno,g_pmdc_m.pmdc900 INTO g_pmdc_m.pmdcsite, 
       g_pmdc_m.pmdc902,g_pmdc_m.pmdcdocno,g_pmdc_m.pmdc900,g_pmdc_m.pmdc001,g_pmdc_m.pmdc002,g_pmdc_m.pmdc003, 
       g_pmdc_m.pmdcstus,g_pmdc_m.pmdcacti,g_pmdc_m.pmdc200,g_pmdc_m.pmdc202,g_pmdc_m.pmdc201,g_pmdc_m.pmdc203, 
       g_pmdc_m.pmdc207,g_pmdc_m.pmdc204,g_pmdc_m.pmdc205,g_pmdc_m.pmdc206,g_pmdc_m.pmdc021,g_pmdc_m.pmdc208, 
       g_pmdc_m.pmdc022,g_pmdc_m.pmdc905,g_pmdc_m.pmdc901,g_pmdc_m.pmdc906,g_pmdc_m.pmdcdocdt,g_pmdc_m.pmdcownid, 
       g_pmdc_m.pmdcowndp,g_pmdc_m.pmdccrtid,g_pmdc_m.pmdccrtdp,g_pmdc_m.pmdccrtdt,g_pmdc_m.pmdcmodid, 
       g_pmdc_m.pmdcmoddt,g_pmdc_m.pmdccnfid,g_pmdc_m.pmdccnfdt,g_pmdc_m.pmdcsite_desc,g_pmdc_m.pmdc002_desc, 
       g_pmdc_m.pmdc003_desc,g_pmdc_m.pmdc202_desc,g_pmdc_m.pmdc203_desc,g_pmdc_m.pmdc204_desc,g_pmdc_m.pmdc205_desc, 
       g_pmdc_m.pmdc206_desc,g_pmdc_m.pmdc021_desc,g_pmdc_m.pmdc905_desc,g_pmdc_m.pmdcownid_desc,g_pmdc_m.pmdcowndp_desc, 
       g_pmdc_m.pmdccrtid_desc,g_pmdc_m.pmdccrtdp_desc,g_pmdc_m.pmdcmodid_desc,g_pmdc_m.pmdccnfid_desc 
 
   
   #檢查是否允許此動作
   IF NOT apmt835_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_pmdc_m_mask_o.* =  g_pmdc_m.*
   CALL apmt835_pmdc_t_mask()
   LET g_pmdc_m_mask_n.* =  g_pmdc_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL apmt835_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_pmdcdocno_t = g_pmdc_m.pmdcdocno
      LET g_pmdc900_t = g_pmdc_m.pmdc900
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_pmdc_m.pmdcmodid = g_user 
LET g_pmdc_m.pmdcmoddt = cl_get_current()
LET g_pmdc_m.pmdcmodid_desc = cl_get_username(g_pmdc_m.pmdcmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      #「D抽單 / R已拒絕」狀況碼更改資料後，需還原為「N未確認」
      IF g_pmdc_m.pmdcstus MATCHES "[DR]" THEN
         LET g_pmdc_m.pmdcstus = "N"
      END IF
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL apmt835_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      #160307-00002#1 20160315 add by beckxie---S
      #因變更單輸入完單號,會直接離開input("a")的DIALOG，
      #改CALL modify進入 input("u") 
      #導致這個變數沒有經過input("a") 的AFTER INPUT 將此變數改為 TRUE
      LET g_master_insert = TRUE
      #160307-00002#1 20160315 add by beckxie---E
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE pmdc_t SET (pmdcmodid,pmdcmoddt) = (g_pmdc_m.pmdcmodid,g_pmdc_m.pmdcmoddt)
          WHERE pmdcent = g_enterprise AND pmdcdocno = g_pmdcdocno_t
            AND pmdc900 = g_pmdc900_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_pmdc_m.* = g_pmdc_m_t.*
            CALL apmt835_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_pmdc_m.pmdcdocno != g_pmdc_m_t.pmdcdocno
      OR g_pmdc_m.pmdc900 != g_pmdc_m_t.pmdc900
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE pmdd_t SET pmdddocno = g_pmdc_m.pmdcdocno
                                       ,pmdd900 = g_pmdc_m.pmdc900
 
          WHERE pmddent = g_enterprise AND pmdddocno = g_pmdc_m_t.pmdcdocno
            AND pmdd900 = g_pmdc_m_t.pmdc900
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "pmdd_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "pmdd_t:",SQLERRMESSAGE 
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
   CALL apmt835_set_act_visible()   
   CALL apmt835_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " pmdcent = " ||g_enterprise|| " AND",
                      " pmdcdocno = '", g_pmdc_m.pmdcdocno, "' "
                      ," AND pmdc900 = '", g_pmdc_m.pmdc900, "' "
 
   #填到對應位置
   CALL apmt835_browser_fill("")
 
   CLOSE apmt835_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL apmt835_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="apmt835.input" >}
#+ 資料輸入
PRIVATE FUNCTION apmt835_input(p_cmd)
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
   DEFINE  l_sys                 LIKE type_t.num5 
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_errno               LIKE type_t.chr10
   DEFINE  l_flag                LIKE type_t.num5
   DEFINE  l_imaa005             LIKE imaa_t.imaa005     #ken---add
   DEFINE  l_pmdd004             LIKE pmdb_t.pmdb004
   #ken-----------------------------s
   DEFINE l_pmdd006       LIKE pmdd_t.pmdd006
   DEFINE l_pmdd212       LIKE pmdd_t.pmdd212
   
   DEFINE  l_inam       DYNAMIC ARRAY OF RECORD   #記錄產品特徵
           inam001      LIKE inam_t.inam001,
           inam002      LIKE inam_t.inam002,
           inam004      LIKE inam_t.inam004
                        END RECORD
                        
   DEFINE  l_pmddseq    LIKE pmdd_t.pmddseq
   DEFINE  l_pmdd       RECORD
           pmddent      LIKE pmdd_t.pmddent,
           pmdddocno    LIKE pmdd_t.pmdddocno,
           pmddseq      LIKE pmdd_t.pmddseq,    #項次
           pmddsite     LIKE pmdd_t.pmddsite,   #需求組織
           pmdd001      LIKE pmdd_t.pmdd001,    #來源單號
           pmdd002      LIKE pmdd_t.pmdd002,    #來源項次
           pmdd003      LIKE pmdd_t.pmdd003,    #來源項序
           pmdd200      LIKE pmdd_t.pmdd200,    #商品條碼
           pmdd004      LIKE pmdd_t.pmdd004,    #商品編號
           pmdd005      LIKE pmdd_t.pmdd005,    #產品特徵
           pmdd037      LIKE pmdd_t.pmdd037,    #收貨組織
           pmdd260      LIKE pmdd_t.pmdd260,   #收貨部門
           pmdd038      LIKE pmdd_t.pmdd038,    #庫位編號
           pmdd201      LIKE pmdd_t.pmdd201,    #包裝單位
           pmdd202      LIKE pmdd_t.pmdd202,    #件裝數
           pmdd212      LIKE pmdd_t.pmdd212,    #要貨件數
           pmdd007      LIKE pmdd_t.pmdd007,    #要貨單位
           pmdd006      LIKE pmdd_t.pmdd006,    #要貨數量
           pmdd253      LIKE pmdd_t.pmdd253,    #入庫在途量
           pmdd258      LIKE pmdd_t.pmdd258,    #要貨在途量
           pmdd254      LIKE pmdd_t.pmdd254,    #前一週銷量
           pmdd255      LIKE pmdd_t.pmdd255,    #前二週銷量
           pmdd256      LIKE pmdd_t.pmdd256,    #前三週銷量
           pmdd257      LIKE pmdd_t.pmdd257,    #前四周銷量
           pmdd259      LIKE pmdd_t.pmdd259,    #周平均銷量
           pmdd252      LIKE pmdd_t.pmdd252,    #現有庫存
           pmdd207      LIKE pmdd_t.pmdd207,    #採購方式
           pmdd015      LIKE pmdd_t.pmdd015,    #供應商編號
           pmdd049      LIKE pmdd_t.pmdd049,    #已轉採購量/配送量
           pmdd030      LIKE pmdd_t.pmdd030,    #需求日期
           pmdd048      LIKE pmdd_t.pmdd048,    #收貨時段
           pmdd208      LIKE pmdd_t.pmdd208,    #經營方式
           pmdd209      LIKE pmdd_t.pmdd209,    #結算方式
           pmdd206      LIKE pmdd_t.pmdd206,    #採購員
           pmdd210      LIKE pmdd_t.pmdd210,    #促銷開始日
           pmdd211      LIKE pmdd_t.pmdd211,    #促銷結束日
           pmdd205      LIKE pmdd_t.pmdd205,    #採購中心
           pmdd203      LIKE pmdd_t.pmdd203,    #配送中心
           pmdd204      LIKE pmdd_t.pmdd204,    #配送倉庫
           pmdd032      LIKE pmdd_t.pmdd032,    #行狀態
           pmdd900      LIKE pmdd_t.pmdd900,    #變更序 sakura add
           pmdd033      LIKE pmdd_t.pmdd033,    #緊急度 sakura add
           pmdd227      LIKE pmdd_t.pmdd227     #補貨規格說明   #150710-00016#4 Add By Ken 150714
                        END RECORD                        
   #ken-----------------------------e 
   DEFINE r_success     LIKE type_t.num5    #2015/03/19  geza
   DEFINE l_where       STRING #150504-00025#1 150506 by sakura add
   #DEFINE l_sys2       LIKE type_t.num5       #150521-00015#2 15/06/08 s983961---add 補貨規格級
   #DEFINE l_imaz003     LIKE imaz_t.imaz003   #150521-00015#2 15/06/08 s983961---add 補貨規格級條碼
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
   DISPLAY BY NAME g_pmdc_m.pmdcsite,g_pmdc_m.pmdcsite_desc,g_pmdc_m.pmdc902,g_pmdc_m.pmdcdocno,g_pmdc_m.pmdc900, 
       g_pmdc_m.pmdc001,g_pmdc_m.pmdc002,g_pmdc_m.pmdc002_desc,g_pmdc_m.pmdc003,g_pmdc_m.pmdc003_desc, 
       g_pmdc_m.pmdcstus,g_pmdc_m.pmdcacti,g_pmdc_m.pmdc200,g_pmdc_m.pmdc202,g_pmdc_m.pmdc202_desc,g_pmdc_m.pmdc201, 
       g_pmdc_m.pmdc203,g_pmdc_m.pmdc203_desc,g_pmdc_m.pmdc207,g_pmdc_m.pmdc204,g_pmdc_m.pmdc204_desc, 
       g_pmdc_m.pmdc205,g_pmdc_m.pmdc205_desc,g_pmdc_m.pmdc206,g_pmdc_m.pmdc206_desc,g_pmdc_m.pmdc021, 
       g_pmdc_m.pmdc021_desc,g_pmdc_m.pmdc208,g_pmdc_m.pmdc022,g_pmdc_m.pmdc905,g_pmdc_m.pmdc905_desc, 
       g_pmdc_m.pmdc901,g_pmdc_m.pmdc906,g_pmdc_m.pmdcdocdt,g_pmdc_m.pmdcownid,g_pmdc_m.pmdcownid_desc, 
       g_pmdc_m.pmdcowndp,g_pmdc_m.pmdcowndp_desc,g_pmdc_m.pmdccrtid,g_pmdc_m.pmdccrtid_desc,g_pmdc_m.pmdccrtdp, 
       g_pmdc_m.pmdccrtdp_desc,g_pmdc_m.pmdccrtdt,g_pmdc_m.pmdcmodid,g_pmdc_m.pmdcmodid_desc,g_pmdc_m.pmdcmoddt, 
       g_pmdc_m.pmdccnfid,g_pmdc_m.pmdccnfid_desc,g_pmdc_m.pmdccnfdt
   
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
   LET g_forupd_sql = "SELECT pmddseq,pmdd001,pmdd002,pmdd003,pmddsite,pmdd200,pmdd004,pmdd005,pmdd033, 
       pmdd037,pmdd260,pmdd038,pmdd227,pmdd201,pmdd202,pmdd212,pmdd007,pmdd006,pmdd253,pmdd258,pmdd254, 
       pmdd255,pmdd256,pmdd257,pmdd259,pmdd252,pmdd207,pmdd015,pmdd049,pmdd030,pmdd048,pmdd208,pmdd209, 
       pmdd206,pmdd210,pmdd211,pmdd205,pmdd203,pmdd204,pmdd032,pmdd901,pmdd902,pmdd903 FROM pmdd_t WHERE  
       pmddent=? AND pmdddocno=? AND pmdd900=? AND pmddseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apmt835_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL apmt835_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL apmt835_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_pmdc_m.pmdcsite,g_pmdc_m.pmdc902,g_pmdc_m.pmdcdocno,g_pmdc_m.pmdc900,g_pmdc_m.pmdc001, 
       g_pmdc_m.pmdc002,g_pmdc_m.pmdc003,g_pmdc_m.pmdcstus,g_pmdc_m.pmdcacti,g_pmdc_m.pmdc200,g_pmdc_m.pmdc202, 
       g_pmdc_m.pmdc201,g_pmdc_m.pmdc203,g_pmdc_m.pmdc207,g_pmdc_m.pmdc204,g_pmdc_m.pmdc205,g_pmdc_m.pmdc206, 
       g_pmdc_m.pmdc021,g_pmdc_m.pmdc208,g_pmdc_m.pmdc022,g_pmdc_m.pmdc905,g_pmdc_m.pmdc901,g_pmdc_m.pmdc906, 
       g_pmdc_m.pmdcdocdt
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   LET g_set_pmdcsite_entry = FALSE
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="apmt835.input.head" >}
      #單頭段
      INPUT BY NAME g_pmdc_m.pmdcsite,g_pmdc_m.pmdc902,g_pmdc_m.pmdcdocno,g_pmdc_m.pmdc900,g_pmdc_m.pmdc001, 
          g_pmdc_m.pmdc002,g_pmdc_m.pmdc003,g_pmdc_m.pmdcstus,g_pmdc_m.pmdcacti,g_pmdc_m.pmdc200,g_pmdc_m.pmdc202, 
          g_pmdc_m.pmdc201,g_pmdc_m.pmdc203,g_pmdc_m.pmdc207,g_pmdc_m.pmdc204,g_pmdc_m.pmdc205,g_pmdc_m.pmdc206, 
          g_pmdc_m.pmdc021,g_pmdc_m.pmdc208,g_pmdc_m.pmdc022,g_pmdc_m.pmdc905,g_pmdc_m.pmdc901,g_pmdc_m.pmdc906, 
          g_pmdc_m.pmdcdocdt 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN apmt835_cl USING g_enterprise,g_pmdc_m.pmdcdocno,g_pmdc_m.pmdc900
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN apmt835_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE apmt835_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL apmt835_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL apmt835_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdcsite
            
            #add-point:AFTER FIELD pmdcsite name="input.a.pmdcsite"
            LET g_pmdc_m.pmdcsite_desc = ' '
            DISPLAY BY NAME g_pmdc_m.pmdcsite_desc
            IF NOT cl_null(g_pmdc_m.pmdcsite) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_pmdc_m.pmdcsite != g_pmdc_m_t.pmdcsite OR g_pmdc_m_t.pmdcsite IS NULL)) THEN   #160824-00007#20 20160919 mark by beckxie
               IF g_pmdc_m.pmdcsite != g_pmdc_m_o.pmdcsite OR cl_null(g_pmdc_m_o.pmdcsite) THEN   #160824-00007#20 20160919 add by beckxie
                  CALL s_aooi500_chk(g_prog,'pmdcsite',g_pmdc_m.pmdcsite,g_pmdc_m.pmdcsite)
                     RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = l_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()

                     #LET g_pmdc_m.pmdcsite = g_pmdc_m_t.pmdcsite   #160824-00007#20 20160919 mark by beckxie
                     LET g_pmdc_m.pmdcsite = g_pmdc_m_o.pmdcsite   #160824-00007#20 20160919 add by beckxie
                     CALL s_desc_get_department_desc(g_pmdc_m.pmdcsite)
                        RETURNING g_pmdc_m.pmdcsite_desc
                     DISPLAY BY NAME g_pmdc_m.pmdcsite_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ''
               LET g_errparam.code   = 'axc-00120'
               LET g_errparam.popup  = TRUE
               CALL cl_err()

               #LET g_pmdc_m.pmdcsite = g_pmdc_m_t.pmdcsite   #160824-00007#20 20160919 mark by beckxie
               LET g_pmdc_m.pmdcsite = g_pmdc_m_o.pmdcsite   #160824-00007#20 20160919 add by beckxie
               CALL s_desc_get_department_desc(g_pmdc_m.pmdcsite) RETURNING g_pmdc_m.pmdcsite_desc
               DISPLAY BY NAME g_pmdc_m.pmdcsite_desc
               NEXT FIELD CURRENT            
            END IF
            LET g_set_pmdcsite_entry = TRUE
            CALL apmt835_set_entry(p_cmd)			   
            CALL apmt835_set_no_entry(p_cmd)			   
            CALL s_desc_get_department_desc(g_pmdc_m.pmdcsite)
               RETURNING g_pmdc_m.pmdcsite_desc
            DISPLAY BY NAME g_pmdc_m.pmdcsite_desc
            #LET g_pmdc_m_t.pmdcsite = g_pmdc_m.pmdcsite   #160824-00007#20 20160919 mark by beckxie
            
            LET g_pmdc_m_o.pmdcsite = g_pmdc_m.pmdcsite    #160824-00007#20 20160919 add by beckxie
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdcsite
            #add-point:BEFORE FIELD pmdcsite name="input.b.pmdcsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdcsite
            #add-point:ON CHANGE pmdcsite name="input.g.pmdcsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdc902
            #add-point:BEFORE FIELD pmdc902 name="input.b.pmdc902"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdc902
            
            #add-point:AFTER FIELD pmdc902 name="input.a.pmdc902"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdc902
            #add-point:ON CHANGE pmdc902 name="input.g.pmdc902"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdcdocno
            #add-point:BEFORE FIELD pmdcdocno name="input.b.pmdcdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdcdocno
            
            #add-point:AFTER FIELD pmdcdocno name="input.a.pmdcdocno"
              IF NOT cl_null(g_pmdc_m.pmdcdocno) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmdc_m.pmdcdocno != g_pmdcdocno_t)) THEN
                  IF NOT apmt835_pmdcdocno_chk(g_pmdc_m.pmdcdocno) THEN
                     #LET g_pmdc_m.pmdcdocno = g_pmdc_m_t.pmdcdocno   #160824-00007#20 20160919 mark by beckxie
                     LET g_pmdc_m.pmdcdocno = g_pmdc_m_o.pmdcdocno    #160824-00007#20 20160919 add by beckxie
                     NEXT FIELD CURRENT
                  END IF
                  
                  IF NOT apmt835_pmdcdocno_other() THEN  #根據單號帶出請購單的值(單頭)
                     #LET g_pmdc_m.pmdcdocno = g_pmdc_m_t.pmdcdocno   #160824-00007#20 20160919 mark by beckxie
                     LET g_pmdc_m.pmdcdocno = g_pmdc_m_o.pmdcdocno    #160824-00007#20 20160919 add by beckxie
                     NEXT FIELD CURRENT
                  ELSE
                     IF NOT apmt835_pmdcdocno_pmdd() THEN  #根據單號帶出請購單的值(單身)
                        #LET g_pmdc_m.pmdcdocno = g_pmdc_m_t.pmdcdocno   #160824-00007#20 20160919 mark by beckxie
                        LET g_pmdc_m.pmdcdocno = g_pmdc_m_o.pmdcdocno    #160824-00007#20 20160919 add by beckxie
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  LET l_flag = TRUE   #帶值成功，重新進入單身，進入修改狀態
                  EXIT DIALOG                 
               END IF 
            END IF
            CALL apmt835_set_entry(p_cmd)
            CALL apmt835_set_no_entry(p_cmd)
            
            #LET g_pmdc_m_t.pmdcdocno = g_pmdc_m.pmdcdocno   #160824-00007#20 20160919 mark by beckxie
            #LET g_pmdc_m_t.pmdc900 = g_pmdc_m.pmdc900       #160824-00007#20 20160919 mark by beckxie
            LET g_pmdc_m_o.pmdcdocno = g_pmdc_m.pmdcdocno    #160824-00007#20 20160919 add by beckxie
            LET g_pmdc_m_o.pmdc900 = g_pmdc_m.pmdc900        #160824-00007#20 20160919 add by beckxie
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdcdocno
            #add-point:ON CHANGE pmdcdocno name="input.g.pmdcdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdc900
            #add-point:BEFORE FIELD pmdc900 name="input.b.pmdc900"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdc900
            
            #add-point:AFTER FIELD pmdc900 name="input.a.pmdc900"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_pmdc_m.pmdcdocno) AND NOT cl_null(g_pmdc_m.pmdc900) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmdc_m.pmdcdocno != g_pmdcdocno_t  OR g_pmdc_m.pmdc900 != g_pmdc900_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pmdc_t WHERE "||"pmdcent = '" ||g_enterprise|| "' AND "||"pmdcdocno = '"||g_pmdc_m.pmdcdocno ||"' AND "|| "pmdc900 = '"||g_pmdc_m.pmdc900 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdc900
            #add-point:ON CHANGE pmdc900 name="input.g.pmdc900"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdc001
            #add-point:BEFORE FIELD pmdc001 name="input.b.pmdc001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdc001
            
            #add-point:AFTER FIELD pmdc001 name="input.a.pmdc001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdc001
            #add-point:ON CHANGE pmdc001 name="input.g.pmdc001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdc002
            
            #add-point:AFTER FIELD pmdc002 name="input.a.pmdc002"
            IF NOT cl_null(g_pmdc_m.pmdc002) THEN
               IF g_pmdc_m.pmdc002 != g_pmdc_m_o.pmdc002 OR cl_null(g_pmdc_m_o.pmdc002) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_pmdc_m.pmdc002
                  #160318-00025#21  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
                 #160318-00025#21  by 07900 --add-end 
                  IF NOT cl_chk_exist("v_ooag001") THEN
                     LET g_pmdc_m.pmdc002 = g_pmdc_m_o.pmdc002 
                     CALL s_desc_get_person_desc(g_pmdc_m.pmdc002) RETURNING g_pmdc_m.pmdc002_desc
                     DISPLAY BY NAME g_pmdc_m.pmdc002_desc 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_pmdc_m_o.pmdc002 = g_pmdc_m.pmdc002            
            CALL s_desc_get_person_desc(g_pmdc_m.pmdc002) RETURNING g_pmdc_m.pmdc002_desc
            DISPLAY BY NAME g_pmdc_m.pmdc002_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdc002
            #add-point:BEFORE FIELD pmdc002 name="input.b.pmdc002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdc002
            #add-point:ON CHANGE pmdc002 name="input.g.pmdc002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdc003
            
            #add-point:AFTER FIELD pmdc003 name="input.a.pmdc003"
            IF NOT cl_null(g_pmdc_m.pmdc003) THEN
               IF g_pmdc_m.pmdc003 != g_pmdc_m_o.pmdc003 OR cl_null(g_pmdc_m_o.pmdc003) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_pmdc_m.pmdc003
                  LET g_chkparam.arg2 = g_pmdc_m.pmdc902
                  #160318-00025#21  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                 #160318-00025#21  by 07900 --add-end
                  IF NOT cl_chk_exist("v_ooeg001") THEN
                     LET g_pmdc_m.pmdc003 = g_pmdc_m_o.pmdc003
                     CALL s_desc_get_department_desc(g_pmdc_m.pmdc003) RETURNING g_pmdc_m.pmdc003_desc 
                     DISPLAY BY NAME g_pmdc_m.pmdc003_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_pmdc_m_o.pmdc003 = g_pmdc_m.pmdc003            
            CALL s_desc_get_department_desc(g_pmdc_m.pmdc003) RETURNING g_pmdc_m.pmdc003_desc
            DISPLAY BY NAME g_pmdc_m.pmdc003_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdc003
            #add-point:BEFORE FIELD pmdc003 name="input.b.pmdc003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdc003
            #add-point:ON CHANGE pmdc003 name="input.g.pmdc003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdcstus
            #add-point:BEFORE FIELD pmdcstus name="input.b.pmdcstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdcstus
            
            #add-point:AFTER FIELD pmdcstus name="input.a.pmdcstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdcstus
            #add-point:ON CHANGE pmdcstus name="input.g.pmdcstus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdcacti
            #add-point:BEFORE FIELD pmdcacti name="input.b.pmdcacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdcacti
            
            #add-point:AFTER FIELD pmdcacti name="input.a.pmdcacti"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdcacti
            #add-point:ON CHANGE pmdcacti name="input.g.pmdcacti"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdc200
            #add-point:BEFORE FIELD pmdc200 name="input.b.pmdc200"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdc200
            
            #add-point:AFTER FIELD pmdc200 name="input.a.pmdc200"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdc200
            #add-point:ON CHANGE pmdc200 name="input.g.pmdc200"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdc202
            
            #add-point:AFTER FIELD pmdc202 name="input.a.pmdc202"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdc202
            #add-point:BEFORE FIELD pmdc202 name="input.b.pmdc202"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdc202
            #add-point:ON CHANGE pmdc202 name="input.g.pmdc202"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdc201
            #add-point:BEFORE FIELD pmdc201 name="input.b.pmdc201"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdc201
            
            #add-point:AFTER FIELD pmdc201 name="input.a.pmdc201"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdc201
            #add-point:ON CHANGE pmdc201 name="input.g.pmdc201"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdc203
            
            #add-point:AFTER FIELD pmdc203 name="input.a.pmdc203"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdc203
            #add-point:BEFORE FIELD pmdc203 name="input.b.pmdc203"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdc203
            #add-point:ON CHANGE pmdc203 name="input.g.pmdc203"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdc207
            #add-point:BEFORE FIELD pmdc207 name="input.b.pmdc207"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdc207
            
            #add-point:AFTER FIELD pmdc207 name="input.a.pmdc207"
            IF NOT cl_null(g_pmdc_m.pmdc207) THEN
               IF NOT apmt835_pmdc207_chk() THEN
                  LET g_pmdc_m.pmdc207 = g_pmdc_m_t.pmdc207
                  NEXT FIELD pmdc207
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdc207
            #add-point:ON CHANGE pmdc207 name="input.g.pmdc207"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdc204
            
            #add-point:AFTER FIELD pmdc204 name="input.a.pmdc204"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdc204
            #add-point:BEFORE FIELD pmdc204 name="input.b.pmdc204"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdc204
            #add-point:ON CHANGE pmdc204 name="input.g.pmdc204"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdc205
            
            #add-point:AFTER FIELD pmdc205 name="input.a.pmdc205"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdc205
            #add-point:BEFORE FIELD pmdc205 name="input.b.pmdc205"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdc205
            #add-point:ON CHANGE pmdc205 name="input.g.pmdc205"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdc206
            
            #add-point:AFTER FIELD pmdc206 name="input.a.pmdc206"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdc206
            #add-point:BEFORE FIELD pmdc206 name="input.b.pmdc206"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdc206
            #add-point:ON CHANGE pmdc206 name="input.g.pmdc206"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdc021
            
            #add-point:AFTER FIELD pmdc021 name="input.a.pmdc021"
            LET g_pmdc_m.pmdc021_desc = ''
            DISPLAY BY NAME g_pmdc_m.pmdc021_desc
            IF NOT cl_null(g_pmdc_m.pmdc021) THEN
               IF g_pmdc_m.pmdc021 != g_pmdc_m_o.pmdc021 OR cl_null(g_pmdc_m_o.pmdc021) THEN
                  IF NOT s_azzi650_chk_exist(g_pmdc021_acc,g_pmdc_m.pmdc021) THEN
                     LET g_pmdc_m.pmdc021 = g_pmdc_m_o.pmdc021
                     CALL s_desc_get_acc_desc(g_pmdc021_acc,g_pmdc_m.pmdc021) RETURNING g_pmdc_m.pmdc021_desc
                     DISPLAY BY NAME g_pmdc_m.pmdc021_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_pmdc_m_o.pmdc021 = g_pmdc_m.pmdc021
            CALL s_desc_get_acc_desc(g_pmdc021_acc,g_pmdc_m.pmdc021) RETURNING g_pmdc_m.pmdc021_desc
            DISPLAY BY NAME g_pmdc_m.pmdc021_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdc021
            #add-point:BEFORE FIELD pmdc021 name="input.b.pmdc021"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdc021
            #add-point:ON CHANGE pmdc021 name="input.g.pmdc021"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdc208
            #add-point:BEFORE FIELD pmdc208 name="input.b.pmdc208"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdc208
            
            #add-point:AFTER FIELD pmdc208 name="input.a.pmdc208"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdc208
            #add-point:ON CHANGE pmdc208 name="input.g.pmdc208"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdc022
            #add-point:BEFORE FIELD pmdc022 name="input.b.pmdc022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdc022
            
            #add-point:AFTER FIELD pmdc022 name="input.a.pmdc022"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdc022
            #add-point:ON CHANGE pmdc022 name="input.g.pmdc022"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdc905
            
            #add-point:AFTER FIELD pmdc905 name="input.a.pmdc905"
            LET g_pmdc_m.pmdc905_desc = ''
		      DISPLAY BY NAME g_pmdc_m.pmdc905_desc
            IF NOT cl_null(g_pmdc_m.pmdc905) THEN
		         IF g_pmdc_m.pmdc905 != g_pmdc_m_o.pmdc902 OR cl_null(g_pmdc_m_o.pmdc902) THEN
                  IF NOT s_azzi650_chk_exist(g_pmdc905_acc,g_pmdc_m.pmdc905) THEN
                     LET g_pmdc_m.pmdc905 = g_pmdc_m_o.pmdc905        
                     CALL s_desc_get_acc_desc(g_pmdc905_acc,g_pmdc_m.pmdc905) RETURNING g_pmdc_m.pmdc905_desc
                     DISPLAY BY NAME g_pmdc_m.pmdc905_desc
                     NEXT FIELD CURRENT            
                  END IF 
               END IF
            END IF
            LET g_pmdc_m_o.pmdc905 = g_pmdc_m.pmdc905             
            CALL s_desc_get_acc_desc(g_pmdc905_acc,g_pmdc_m.pmdc905) RETURNING g_pmdc_m.pmdc905_desc
            DISPLAY BY NAME g_pmdc_m.pmdc905_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdc905
            #add-point:BEFORE FIELD pmdc905 name="input.b.pmdc905"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdc905
            #add-point:ON CHANGE pmdc905 name="input.g.pmdc905"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdc901
            #add-point:BEFORE FIELD pmdc901 name="input.b.pmdc901"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdc901
            
            #add-point:AFTER FIELD pmdc901 name="input.a.pmdc901"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdc901
            #add-point:ON CHANGE pmdc901 name="input.g.pmdc901"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdc906
            #add-point:BEFORE FIELD pmdc906 name="input.b.pmdc906"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdc906
            
            #add-point:AFTER FIELD pmdc906 name="input.a.pmdc906"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdc906
            #add-point:ON CHANGE pmdc906 name="input.g.pmdc906"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdcdocdt
            #add-point:BEFORE FIELD pmdcdocdt name="input.b.pmdcdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdcdocdt
            
            #add-point:AFTER FIELD pmdcdocdt name="input.a.pmdcdocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdcdocdt
            #add-point:ON CHANGE pmdcdocdt name="input.g.pmdcdocdt"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.pmdcsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdcsite
            #add-point:ON ACTION controlp INFIELD pmdcsite name="input.c.pmdcsite"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdc_m.pmdcsite   #給予default值
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmdcsite',g_pmdc_m.pmdcsite,'i') #150308-00001#2  By sakura add 'i'
            CALL q_ooef001_24()
            LET g_pmdc_m.pmdcsite = g_qryparam.return1   #將開窗取得的值回傳到變數
            DISPLAY g_pmdc_m.pmdcsite TO pmdcsite        #顯示到畫面上
            CALL s_desc_get_department_desc(g_pmdc_m.pmdcsite) RETURNING g_pmdc_m.pmdcsite_desc
            DISPLAY BY NAME g_pmdc_m.pmdcsite_desc            
            NEXT FIELD pmdcsite                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.pmdc902
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdc902
            #add-point:ON ACTION controlp INFIELD pmdc902 name="input.c.pmdc902"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmdcdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdcdocno
            #add-point:ON ACTION controlp INFIELD pmdcdocno name="input.c.pmdcdocno"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdc_m.pmdcdocno             #給予default值
            #150504-00025#1 150506 by sakura add---STR
            LET l_where = " pmdasite = '",g_pmdc_m.pmdcsite,"' AND pmdastus = 'Y' ",
                          " AND NOT EXISTS (SELECT 1 ",
                                             "FROM pmdl_t,pmdn_t,pmdp_t,pmdb_t ",
                                            "WHERE pmdlent = pmdnent ",
                                             " AND pmdldocno = pmdndocno ",
                                             " AND pmdnent = pmdpent ",
                                             " AND pmdndocno = pmdpdocno ",
                                             " AND pmdnseq = pmdpseq ",
                                             " AND pmdlent = ",g_enterprise,
                                             " AND pmdlstus != 'X' ",
                                             " AND pmdpent = pmdbent ",
                                             " AND pmdp003 = pmdbdocno ",
                                             " AND pmdp004 = pmdbseq ",
                                             " AND pmdbdocno= pmdadocno)"
            LET g_qryparam.where = l_where
            #150504-00025#1 150506 by sakura add---END            
            #LET g_qryparam.where = " pmdasite = '",g_pmdc_m.pmdcsite,"' AND pmdastus = 'Y' " #150504-00025#1 150506 by sakura mark
            CALL q_pmdadocno()                                #呼叫開窗
            LET g_pmdc_m.pmdcdocno = g_qryparam.return1       #將開窗取得的值回傳到變數
            DISPLAY g_pmdc_m.pmdcdocno TO pmdcdocno           #顯示到畫面上
            NEXT FIELD pmdcdocno                              #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmdc900
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdc900
            #add-point:ON ACTION controlp INFIELD pmdc900 name="input.c.pmdc900"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmdc001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdc001
            #add-point:ON ACTION controlp INFIELD pmdc001 name="input.c.pmdc001"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmdc002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdc002
            #add-point:ON ACTION controlp INFIELD pmdc002 name="input.c.pmdc002"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdc_m.pmdc002             #給予default值
            #給予arg
            CALL q_ooag001()                            #呼叫開窗
            LET g_pmdc_m.pmdc002 = g_qryparam.return1              
            DISPLAY g_pmdc_m.pmdc002 TO pmdc002         #
            CALL s_desc_get_person_desc(g_pmdc_m.pmdc002) RETURNING g_pmdc_m.pmdc002_desc
            DISPLAY BY NAME g_pmdc_m.pmdc002_desc            
            NEXT FIELD pmdc002                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.pmdc003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdc003
            #add-point:ON ACTION controlp INFIELD pmdc003 name="input.c.pmdc003"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdc_m.pmdc003             #給予default值          
            LET g_qryparam.arg1 = g_pmdc_m.pmdc902
            CALL q_ooeg001()                                #呼叫開窗
            LET g_pmdc_m.pmdc003 = g_qryparam.return1
            DISPLAY g_pmdc_m.pmdc003 TO pmdc003
            CALL s_desc_get_department_desc(g_pmdc_m.pmdc003) RETURNING g_pmdc_m.pmdc003_desc
            DISPLAY BY NAME g_pmdc_m.pmdc003_desc
            NEXT FIELD pmdc003                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.pmdcstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdcstus
            #add-point:ON ACTION controlp INFIELD pmdcstus name="input.c.pmdcstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmdcacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdcacti
            #add-point:ON ACTION controlp INFIELD pmdcacti name="input.c.pmdcacti"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmdc200
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdc200
            #add-point:ON ACTION controlp INFIELD pmdc200 name="input.c.pmdc200"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmdc202
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdc202
            #add-point:ON ACTION controlp INFIELD pmdc202 name="input.c.pmdc202"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmdc201
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdc201
            #add-point:ON ACTION controlp INFIELD pmdc201 name="input.c.pmdc201"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmdc203
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdc203
            #add-point:ON ACTION controlp INFIELD pmdc203 name="input.c.pmdc203"
 
            #END add-point
 
 
         #Ctrlp:input.c.pmdc207
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdc207
            #add-point:ON ACTION controlp INFIELD pmdc207 name="input.c.pmdc207"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmdc204
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdc204
            #add-point:ON ACTION controlp INFIELD pmdc204 name="input.c.pmdc204"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            #END add-point
 
 
         #Ctrlp:input.c.pmdc205
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdc205
            #add-point:ON ACTION controlp INFIELD pmdc205 name="input.c.pmdc205"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            #END add-point
 
 
         #Ctrlp:input.c.pmdc206
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdc206
            #add-point:ON ACTION controlp INFIELD pmdc206 name="input.c.pmdc206"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            #END add-point
 
 
         #Ctrlp:input.c.pmdc021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdc021
            #add-point:ON ACTION controlp INFIELD pmdc021 name="input.c.pmdc021"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdc_m.pmdc021             #給予default值
            #給予arg
            LET g_qryparam.arg1 = g_pmdc021_acc
            CALL q_oocq002()                            #呼叫開窗
            LET g_pmdc_m.pmdc021 = g_qryparam.return1              
            DISPLAY g_pmdc_m.pmdc021 TO pmdc021         #
            CALL s_desc_get_acc_desc(g_pmdc021_acc,g_pmdc_m.pmdc021) RETURNING g_pmdc_m.pmdc021_desc
            DISPLAY BY NAME g_pmdc_m.pmdc021_desc            
            NEXT FIELD pmdc021                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.pmdc208
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdc208
            #add-point:ON ACTION controlp INFIELD pmdc208 name="input.c.pmdc208"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmdc022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdc022
            #add-point:ON ACTION controlp INFIELD pmdc022 name="input.c.pmdc022"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmdc905
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdc905
            #add-point:ON ACTION controlp INFIELD pmdc905 name="input.c.pmdc905"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdc_m.pmdc905             #給予default值
            #給予arg
            LET g_qryparam.arg1 = g_pmdc905_acc
            CALL q_oocq002()                            #呼叫開窗
            LET g_pmdc_m.pmdc905 = g_qryparam.return1              
            DISPLAY g_pmdc_m.pmdc905 TO pmdc905         
            CALL s_desc_get_acc_desc(g_pmdc905_acc,g_pmdc_m.pmdc905) RETURNING g_pmdc_m.pmdc905_desc
            DISPLAY BY NAME g_pmdc_m.pmdc905_desc             
            NEXT FIELD pmdc905                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmdc901
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdc901
            #add-point:ON ACTION controlp INFIELD pmdc901 name="input.c.pmdc901"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmdc906
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdc906
            #add-point:ON ACTION controlp INFIELD pmdc906 name="input.c.pmdc906"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmdcdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdcdocdt
            #add-point:ON ACTION controlp INFIELD pmdcdocdt name="input.c.pmdcdocdt"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_pmdc_m.pmdcdocno,g_pmdc_m.pmdc900
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               
               #end add-point
               
               INSERT INTO pmdc_t (pmdcent,pmdcsite,pmdc902,pmdcdocno,pmdc900,pmdc001,pmdc002,pmdc003, 
                   pmdcstus,pmdcacti,pmdc200,pmdc202,pmdc201,pmdc203,pmdc207,pmdc204,pmdc205,pmdc206, 
                   pmdc021,pmdc208,pmdc022,pmdc905,pmdc901,pmdc906,pmdcdocdt,pmdcownid,pmdcowndp,pmdccrtid, 
                   pmdccrtdp,pmdccrtdt,pmdcmodid,pmdcmoddt,pmdccnfid,pmdccnfdt)
               VALUES (g_enterprise,g_pmdc_m.pmdcsite,g_pmdc_m.pmdc902,g_pmdc_m.pmdcdocno,g_pmdc_m.pmdc900, 
                   g_pmdc_m.pmdc001,g_pmdc_m.pmdc002,g_pmdc_m.pmdc003,g_pmdc_m.pmdcstus,g_pmdc_m.pmdcacti, 
                   g_pmdc_m.pmdc200,g_pmdc_m.pmdc202,g_pmdc_m.pmdc201,g_pmdc_m.pmdc203,g_pmdc_m.pmdc207, 
                   g_pmdc_m.pmdc204,g_pmdc_m.pmdc205,g_pmdc_m.pmdc206,g_pmdc_m.pmdc021,g_pmdc_m.pmdc208, 
                   g_pmdc_m.pmdc022,g_pmdc_m.pmdc905,g_pmdc_m.pmdc901,g_pmdc_m.pmdc906,g_pmdc_m.pmdcdocdt, 
                   g_pmdc_m.pmdcownid,g_pmdc_m.pmdcowndp,g_pmdc_m.pmdccrtid,g_pmdc_m.pmdccrtdp,g_pmdc_m.pmdccrtdt, 
                   g_pmdc_m.pmdcmodid,g_pmdc_m.pmdcmoddt,g_pmdc_m.pmdccnfid,g_pmdc_m.pmdccnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_pmdc_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               IF g_pmdc_m.pmdcacti = 'Y' THEN
                  UPDATE pmdd_t SET pmdd901 = '4',
                                    pmdd032 = 'Y' 
                     WHERE pmddent = g_enterprise 
                       AND pmdddocno = g_pmdc_m.pmdcdocno 
                       AND pmdd900 = g_pmdc_m.pmdc900
                       
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "g_pmdd_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
  
                     CONTINUE DIALOG
                  END IF
               END IF
               
               IF NOT apmt835_upd_pmdc901() THEN #新增請購變更歷程檔並修改單頭變更否欄位
                  CONTINUE DIALOG
               END IF
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL apmt835_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL apmt835_b_fill()
                  CALL apmt835_b_fill2('0')
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
               CALL apmt835_pmdc_t_mask_restore('restore_mask_o')
               
               UPDATE pmdc_t SET (pmdcsite,pmdc902,pmdcdocno,pmdc900,pmdc001,pmdc002,pmdc003,pmdcstus, 
                   pmdcacti,pmdc200,pmdc202,pmdc201,pmdc203,pmdc207,pmdc204,pmdc205,pmdc206,pmdc021, 
                   pmdc208,pmdc022,pmdc905,pmdc901,pmdc906,pmdcdocdt,pmdcownid,pmdcowndp,pmdccrtid,pmdccrtdp, 
                   pmdccrtdt,pmdcmodid,pmdcmoddt,pmdccnfid,pmdccnfdt) = (g_pmdc_m.pmdcsite,g_pmdc_m.pmdc902, 
                   g_pmdc_m.pmdcdocno,g_pmdc_m.pmdc900,g_pmdc_m.pmdc001,g_pmdc_m.pmdc002,g_pmdc_m.pmdc003, 
                   g_pmdc_m.pmdcstus,g_pmdc_m.pmdcacti,g_pmdc_m.pmdc200,g_pmdc_m.pmdc202,g_pmdc_m.pmdc201, 
                   g_pmdc_m.pmdc203,g_pmdc_m.pmdc207,g_pmdc_m.pmdc204,g_pmdc_m.pmdc205,g_pmdc_m.pmdc206, 
                   g_pmdc_m.pmdc021,g_pmdc_m.pmdc208,g_pmdc_m.pmdc022,g_pmdc_m.pmdc905,g_pmdc_m.pmdc901, 
                   g_pmdc_m.pmdc906,g_pmdc_m.pmdcdocdt,g_pmdc_m.pmdcownid,g_pmdc_m.pmdcowndp,g_pmdc_m.pmdccrtid, 
                   g_pmdc_m.pmdccrtdp,g_pmdc_m.pmdccrtdt,g_pmdc_m.pmdcmodid,g_pmdc_m.pmdcmoddt,g_pmdc_m.pmdccnfid, 
                   g_pmdc_m.pmdccnfdt)
                WHERE pmdcent = g_enterprise AND pmdcdocno = g_pmdcdocno_t
                  AND pmdc900 = g_pmdc900_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "pmdc_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
                IF g_pmdc_m.pmdcacti = 'Y' THEN
                   UPDATE pmdd_t SET pmdd901 = '4',
                                     pmdd032 = 'Y' 
                      WHERE pmddent = g_enterprise 
                        AND pmdddocno = g_pmdc_m.pmdcdocno 
                        AND pmdd900 = g_pmdc_m.pmdc900
                        
                   IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = SQLCA.sqlcode
                      LET g_errparam.extend = "pmdd_t"
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
  
                      CALL s_transaction_end('N','0')
                      CONTINUE DIALOG
                   END IF
                END IF
                IF g_pmdc_m.pmdcacti != g_pmdc_m_t.pmdcacti THEN
                   IF g_pmdc_m.pmdcacti = 'Y' THEN
                   
                      UPDATE pmdd_t SET pmdd901 = '4',
                                        pmdd032 = 'Y' 
                        WHERE pmddent = g_enterprise 
                          AND pmdddocno = g_pmdc_m.pmdcdocno 
                          AND pmdd900 = g_pmdc_m.pmdc900
                          
                      IF SQLCA.sqlcode THEN
                         INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = SQLCA.sqlcode
                      LET g_errparam.extend = "pmdd_t"
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
  
                         CALL s_transaction_end('N','0')
                         CONTINUE DIALOG
                      END IF
                   END IF
                   IF g_pmdc_m.pmdcacti = 'N' THEN
                      LET l_n = 0
                      SELECT COUNT(*) INTO l_n FROM pmdb_t WHERE pmdbent = g_enterprise AND pmdbdocno = g_pmdc_m.pmdcdocno
                      IF l_n > 0 THEN
                         #資料本身就存在請購單中，且行狀態不是結案狀態，則更新為單身修改
                         UPDATE pmdd_t SET pmdd901 = '2',
                                           pmdd032 = 'N' 
                           WHERE pmddent = g_enterprise 
                             AND pmdddocno = g_pmdc_m.pmdcdocno 
                             AND pmdd900 = g_pmdc_m.pmdc900
                             AND pmddseq IN (SELECT pmdbseq
                                               FROM pmdb_t
                                              WHERE pmdbent = g_enterprise
                                                AND pmdbdocno = g_pmdc_m.pmdcdocno
                                                AND pmdb032 = '1')
                      ELSE
                         #不存在於請購單中，即是變更單中新增的
                         UPDATE pmdd_t SET pmdd901 = '3',
                                           pmdd032 = 'N' 
                           WHERE pmddent = g_enterprise 
                             AND pmdddocno = g_pmdc_m.pmdcdocno 
                             AND pmdd900 = g_pmdc_m.pmdc900
                      END IF
                      IF SQLCA.sqlcode THEN
                         INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = SQLCA.sqlcode
                      LET g_errparam.extend = "pmdd_t"
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
  
                         CALL s_transaction_end('N','0')
                         CONTINUE DIALOG
                      END IF
                   END IF
                END IF
                
                IF NOT apmt835_upd_pmdc901() THEN #新增請購變更歷程檔並修改單頭變更否欄位
                   CALL s_transaction_end('N','0')
                   CONTINUE DIALOG
                END IF 
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL apmt835_pmdc_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_pmdc_m_t)
               LET g_log2 = util.JSON.stringify(g_pmdc_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_pmdcdocno_t = g_pmdc_m.pmdcdocno
            LET g_pmdc900_t = g_pmdc_m.pmdc900
 
            
      END INPUT
   
 
{</section>}
 
{<section id="apmt835.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_pmdd_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_pmdd_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL apmt835_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_pmdd_d.getLength()
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
            OPEN apmt835_cl USING g_enterprise,g_pmdc_m.pmdcdocno,g_pmdc_m.pmdc900
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN apmt835_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE apmt835_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_pmdd_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_pmdd_d[l_ac].pmddseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_pmdd_d_t.* = g_pmdd_d[l_ac].*  #BACKUP
               LET g_pmdd_d_o.* = g_pmdd_d[l_ac].*  #BACKUP
               CALL apmt835_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               #add-S By Ken 150318
               CALL apmt835_set_no_required_b(l_cmd)
               CALL apmt835_set_required_b(l_cmd)
               #add-E
               #end add-point  
               CALL apmt835_set_no_entry_b(l_cmd)
               IF NOT apmt835_lock_b("pmdd_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH apmt835_bcl INTO g_pmdd_d[l_ac].pmddseq,g_pmdd_d[l_ac].pmdd001,g_pmdd_d[l_ac].pmdd002, 
                      g_pmdd_d[l_ac].pmdd003,g_pmdd_d[l_ac].pmddsite,g_pmdd_d[l_ac].pmdd200,g_pmdd_d[l_ac].pmdd004, 
                      g_pmdd_d[l_ac].pmdd005,g_pmdd_d[l_ac].pmdd033,g_pmdd_d[l_ac].pmdd037,g_pmdd_d[l_ac].pmdd260, 
                      g_pmdd_d[l_ac].pmdd038,g_pmdd_d[l_ac].pmdd227,g_pmdd_d[l_ac].pmdd201,g_pmdd_d[l_ac].pmdd202, 
                      g_pmdd_d[l_ac].pmdd212,g_pmdd_d[l_ac].pmdd007,g_pmdd_d[l_ac].pmdd006,g_pmdd_d[l_ac].pmdd253, 
                      g_pmdd_d[l_ac].pmdd258,g_pmdd_d[l_ac].pmdd254,g_pmdd_d[l_ac].pmdd255,g_pmdd_d[l_ac].pmdd256, 
                      g_pmdd_d[l_ac].pmdd257,g_pmdd_d[l_ac].pmdd259,g_pmdd_d[l_ac].pmdd252,g_pmdd_d[l_ac].pmdd207, 
                      g_pmdd_d[l_ac].pmdd015,g_pmdd_d[l_ac].pmdd049,g_pmdd_d[l_ac].pmdd030,g_pmdd_d[l_ac].pmdd048, 
                      g_pmdd_d[l_ac].pmdd208,g_pmdd_d[l_ac].pmdd209,g_pmdd_d[l_ac].pmdd206,g_pmdd_d[l_ac].pmdd210, 
                      g_pmdd_d[l_ac].pmdd211,g_pmdd_d[l_ac].pmdd205,g_pmdd_d[l_ac].pmdd203,g_pmdd_d[l_ac].pmdd204, 
                      g_pmdd_d[l_ac].pmdd032,g_pmdd_d[l_ac].pmdd901,g_pmdd_d[l_ac].pmdd902,g_pmdd_d[l_ac].pmdd903 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_pmdd_d_t.pmddseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_pmdd_d_mask_o[l_ac].* =  g_pmdd_d[l_ac].*
                  CALL apmt835_pmdd_t_mask()
                  LET g_pmdd_d_mask_n[l_ac].* =  g_pmdd_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL apmt835_show()
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
            INITIALIZE g_pmdd_d[l_ac].* TO NULL 
            INITIALIZE g_pmdd_d_t.* TO NULL 
            INITIALIZE g_pmdd_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_pmdd_d[l_ac].pmdd033 = "1"
      LET g_pmdd_d[l_ac].pmdd202 = "0"
      LET g_pmdd_d[l_ac].pmdd212 = "0"
      LET g_pmdd_d[l_ac].pmdd006 = "0"
      LET g_pmdd_d[l_ac].pmdd253 = "0"
      LET g_pmdd_d[l_ac].pmdd258 = "0"
      LET g_pmdd_d[l_ac].pmdd254 = "0"
      LET g_pmdd_d[l_ac].pmdd255 = "0"
      LET g_pmdd_d[l_ac].pmdd256 = "0"
      LET g_pmdd_d[l_ac].pmdd257 = "0"
      LET g_pmdd_d[l_ac].pmdd259 = "0"
      LET g_pmdd_d[l_ac].pmdd252 = "0"
      LET g_pmdd_d[l_ac].pmdd049 = "0"
      LET g_pmdd_d[l_ac].pmdd032 = "N"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_pmdd_d_t.* = g_pmdd_d[l_ac].*     #新輸入資料
            LET g_pmdd_d_o.* = g_pmdd_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL apmt835_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            #add-S By Ken 150318
            CALL apmt835_set_no_required_b(l_cmd)
            CALL apmt835_set_required_b(l_cmd)
            #add-E
            #end add-point
            CALL apmt835_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_pmdd_d[li_reproduce_target].* = g_pmdd_d[li_reproduce].*
 
               LET g_pmdd_d[li_reproduce_target].pmddseq = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            #項次加1
            SELECT MAX(pmddseq)+1 INTO g_pmdd_d[l_ac].pmddseq
               FROM pmdd_t 
              WHERE pmddent = g_enterprise 
                AND pmdddocno = g_pmdc_m.pmdcdocno 
                AND pmdd900 = g_pmdc_m.pmdc900
                
            #單頭需求組織(pmdc203)非空白時，Default = pmdc203，且不可修改           
            IF NOT cl_null(g_pmdc_m.pmdc203) THEN
               LET g_pmdd_d[l_ac].pmddsite = g_pmdc_m.pmdc203
            ELSE
               LET g_pmdd_d[l_ac].pmddsite =g_pmdc_m.pmdcsite
            END IF
            CALL s_desc_get_department_desc(g_pmdd_d[l_ac].pmddsite) RETURNING g_pmdd_d[l_ac].pmddsite_desc
            
            #收貨組織預設(pmdd037) = 需求組織(pmddsite)
            LET g_pmdd_d[l_ac].pmdd037 = g_pmdd_d[l_ac].pmddsite
            CALL s_desc_get_department_desc(g_pmdd_d[l_ac].pmdd037) RETURNING g_pmdd_d[l_ac].pmdd037_desc
            
            #當單頭有指定配送倉時，單身等於單頭的配送倉
            IF NOT cl_null(g_pmdc_m.pmdc206) THEN
               LET g_pmdd_d[l_ac].pmdd204 = g_pmdc_m.pmdc206
            END IF
            CALL s_desc_get_stock_desc('',g_pmdd_d[l_ac].pmdd204) RETURNING  g_pmdd_d[l_ac].pmdd204_desc
            
            LET g_pmdd_d[l_ac].pmdd901 = '3'  #單身變更類型 = 3(單身新增)
            CALL cl_set_comp_required("pmdd210,pmdd211",FALSE)  
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
            #ken---add---s
            #料件有使用產品特徴則不可空白
            LET l_imaa005 = ''
            CALL apmt835_get_imaa005(g_pmdd_d[l_ac].pmdd004) RETURNING l_imaa005
            IF NOT cl_null(l_imaa005) THEN
               IF cl_null(g_pmdd_d[l_ac].pmdd005) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'sub-00124'
                  LET g_errparam.extend = g_pmdc_m.pmdcdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD pmdd005               
               END IF
            ELSE 
               IF cl_null(g_pmdd_d[l_ac].pmdd005) THEN
                  LET g_pmdd_d[l_ac].pmdd005 = ' ' 
               END IF          
            END IF      
            #ken---add---e 
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM pmdd_t 
             WHERE pmddent = g_enterprise AND pmdddocno = g_pmdc_m.pmdcdocno
               AND pmdd900 = g_pmdc_m.pmdc900
 
               AND pmddseq = g_pmdd_d[l_ac].pmddseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_pmdc_m.pmdcdocno
               LET gs_keys[2] = g_pmdc_m.pmdc900
               LET gs_keys[3] = g_pmdd_d[g_detail_idx].pmddseq
               CALL apmt835_insert_b('pmdd_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_pmdd_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "pmdd_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL apmt835_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               IF NOT apmt835_pmdd_ins_pmde(g_pmdd_d[l_ac].pmdd901) THEN   #'3' 單身新增  '2' 單身修改
                  CALL s_transaction_end('N','0')
                  CANCEL INSERT
               END IF
               IF NOT apmt835_upd_pmdc208() THEN
                  CALL s_transaction_end('N','0')
                  CANCEL INSERT
               END IF
               CALL apmt835_pmdd212_sum()
               #ken---add---s
               INITIALIZE l_pmdd.* TO NULL               
               SELECT pmddent, pmddsite,pmdd001, pmdd002, 
                      pmdd003, pmdd200, pmdd004, pmdd005,
                      pmdd037, pmdd260, pmdd038, pmdd201,
                      pmdd202, pmdd212, pmdd007, pmdd006,         
                      pmdd253, pmdd258, pmdd254, pmdd255,         
                      pmdd256, pmdd257, pmdd259, pmdd252,         
                      pmdd207, pmdd015, pmdd049, pmdd030,         
                      pmdd048, pmdd208, pmdd209, pmdd206,         
                      pmdd210, pmdd211, pmdd205, pmdd203,         
                      pmdd204, pmdd032, pmdddocno,pmdd900,
                      pmdd033, pmdd227  #補貨規格說明   #150710-00016#4 Add By Ken 150714                      
                INTO  l_pmdd.pmddent, l_pmdd.pmddsite,l_pmdd.pmdd001, l_pmdd.pmdd002,  
                      l_pmdd.pmdd003, l_pmdd.pmdd200, l_pmdd.pmdd004, l_pmdd.pmdd005,  
                      l_pmdd.pmdd037, l_pmdd.pmdd260,l_pmdd.pmdd038, l_pmdd.pmdd201,  
                      l_pmdd.pmdd202, l_pmdd.pmdd212, l_pmdd.pmdd007, l_pmdd.pmdd006,  
                      l_pmdd.pmdd253, l_pmdd.pmdd258, l_pmdd.pmdd254, l_pmdd.pmdd255,  
                      l_pmdd.pmdd256, l_pmdd.pmdd257, l_pmdd.pmdd259, l_pmdd.pmdd252,  
                      l_pmdd.pmdd207, l_pmdd.pmdd015, l_pmdd.pmdd049, l_pmdd.pmdd030,  
                      l_pmdd.pmdd048, l_pmdd.pmdd208, l_pmdd.pmdd209, l_pmdd.pmdd206,  
                      l_pmdd.pmdd210, l_pmdd.pmdd211, l_pmdd.pmdd205, l_pmdd.pmdd203,  
                      l_pmdd.pmdd204, l_pmdd.pmdd032, l_pmdd.pmdddocno,l_pmdd.pmdd900,
                      l_pmdd.pmdd033, l_pmdd.pmdd227  #補貨規格說明   #150710-00016#4 Add By Ken 150714
                 FROM pmdd_t 
                WHERE pmddent = g_enterprise
                  AND pmdddocno = g_pmdc_m.pmdcdocno
                  AND pmddseq = g_pmdd_d[l_ac].pmddseq
                  
               IF l_inam.getLength() > 1 THEN  #因為第一筆資料已呈現在畫面並寫入DB, 從第二筆開始處理           
                  LET l_pmddseq = ''
                  SELECT MAX(pmddseq) INTO l_pmddseq
                    FROM pmdd_t
                   WHERE pmddent   = g_enterprise
                     AND pmdddocno = g_pmdc_m.pmdcdocno
                  
                  FOR l_i = 2 TO l_inam.getLength() 
                     IF cl_null(l_pmddseq) OR l_pmddseq = 0 THEN
                        LET l_pmddseq = 1
                     ELSE
                        LET l_pmddseq = l_pmddseq + 1             
                     END IF                   
                     LET l_pmdd.pmdd005 = l_inam[l_i].inam002
                     LET l_pmdd.pmdd006 = l_inam[l_i].inam004
                     
                     #LET g_pmdd_d[l_ac].pmdd006 = l_pmdd.pmdd006
                     ##單位間的轉換數量
                     #CALL apmt835_num_change()                     
                     #LET l_pmdd.pmdd212 = g_pmdd_d[l_ac].pmdd212
                     #
                     ##要貨在途量計算
                     #CALL s_apmt830_sum_pmdb258(g_pmdd_d[l_ac].pmddsite,g_pmdd_d[l_ac].pmdd004,g_pmdd_d[l_ac].pmdd005)
                     #   RETURNING g_pmdd_d[l_ac].pmdd258  
                     #
                     #前一、二、三、四週銷量及週平均銷量計算
                     #CALL apmt835_daily_sale_all(g_pmdb_d[l_ac].pmdbsite,g_pmdc_m.pmdc902,g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb005)
                     #   RETURNING g_pmdb_d[l_ac].pmdb254,g_pmdb_d[l_ac].pmdb255,g_pmdb_d[l_ac].pmdb256,g_pmdb_d[l_ac].pmdb257,g_pmdb_d[l_ac].pmdb259
                        
                     #現有庫存計算
                     #CALL s_inventory_get_inag008_2(g_pmdd_d[l_ac].pmddsite,g_pmdd_d[l_ac].pmdd004,g_pmdd_d[l_ac].pmdd005,'','','','',g_pmdd_d[l_ac].pmdd007)
                     #   RETURNING l_success,g_pmdd_d[l_ac].pmdd252
                     #IF NOT l_success THEN
                     #   NEXT FIELD pmdd005
                     #END IF
                     
                     #單位間的轉換數量
                     #由要貨數量轉換成包裝數量(要貨件數)
                     CALL s_aooi250_convert_qty(l_pmdd.pmdd004,l_pmdd.pmdd007,l_pmdd.pmdd201,l_pmdd.pmdd006)
                         RETURNING l_success,l_pmdd.pmdd212
                     
                     #要貨在途量計算
                     CALL s_apmt830_sum_pmdb258(l_pmdd.pmddsite,l_pmdd.pmdd004,l_pmdd.pmdd005)
                        RETURNING l_pmdd.pmdd258
                     
                     #前一、二、三、四週銷量及週平均銷量計算
                     CALL apmt835_daily_sale_all(l_pmdd.pmddsite,g_pmdc_m.pmdcdocdt,l_pmdd.pmdd004,l_pmdd.pmdd005)
                        RETURNING l_pmdd.pmdd254,l_pmdd.pmdd255,l_pmdd.pmdd256,l_pmdd.pmdd257,l_pmdd.pmdd259                     
                     
                     #可用庫存量
                     CALL s_apmt840_sum_inag008(l_pmdd.pmddsite,l_pmdd.pmdd004,l_pmdd.pmdd005) #150401-00005#3 sakura add pmdd005
                        RETURNING l_pmdd.pmdd252
                      
                     #150413-00018#1 20150414 pomelo add(S)
                     #入庫在途量計算
                     CALL s_apmt840_sum_in_way(l_pmdd.pmddsite,l_pmdd.pmdd004,l_pmdd.pmdd005)
                        RETURNING l_pmdd.pmdd253
                     #150413-00018#1 20150414 pomelo add(E)
                     
                     INSERT INTO pmdd_t (pmddent, pmddsite,pmdd001, pmdd002, 
                                         pmdd003, pmdd200, pmdd004, pmdd005,
                                         pmdd037, pmdd260, pmdd038, pmdd201,
                                         pmdd202, pmdd212, pmdd007, pmdd006,         
                                         pmdd253, pmdd258, pmdd254, pmdd255,         
                                         pmdd256, pmdd257, pmdd259, pmdd252,         
                                         pmdd207, pmdd015, pmdd049, pmdd030,         
                                         pmdd048, pmdd208, pmdd209, pmdd206,         
                                         pmdd210, pmdd211, pmdd205, pmdd203,         
                                         pmdd204, pmdd032, pmdddocno, pmddseq,
                                         pmdd900, pmdd033, pmdd227)  #補貨規格說明   #150710-00016#4 Add By Ken 150714
                         VALUES(l_pmdd.pmddent, l_pmdd.pmddsite,l_pmdd.pmdd001, l_pmdd.pmdd002,  
                                l_pmdd.pmdd003, l_pmdd.pmdd200, l_pmdd.pmdd004, l_pmdd.pmdd005,  
                                l_pmdd.pmdd037, l_pmdd.pmdd260, l_pmdd.pmdd038, l_pmdd.pmdd201,  
                                l_pmdd.pmdd202, l_pmdd.pmdd212, l_pmdd.pmdd007, l_pmdd.pmdd006,  
                                l_pmdd.pmdd253, l_pmdd.pmdd258, l_pmdd.pmdd254, l_pmdd.pmdd255,  
                                l_pmdd.pmdd256, l_pmdd.pmdd257, l_pmdd.pmdd259, l_pmdd.pmdd252,  
                                l_pmdd.pmdd207, l_pmdd.pmdd015, l_pmdd.pmdd049, l_pmdd.pmdd030,  
                                l_pmdd.pmdd048, l_pmdd.pmdd208, l_pmdd.pmdd209, l_pmdd.pmdd206,  
                                l_pmdd.pmdd210, l_pmdd.pmdd211, l_pmdd.pmdd205, l_pmdd.pmdd203,  
                                l_pmdd.pmdd204, l_pmdd.pmdd032, l_pmdd.pmdddocno, l_pmddseq,
                                l_pmdd.pmdd900, l_pmdd.pmdd033, l_pmdd.pmdd227)  #補貨規格說明   #150710-00016#4 Add By Ken 150714
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "pmdb_t"
                        LET g_errparam.popup = FALSE
                        CALL cl_err()
                     END IF
                  END FOR
                  LET g_rec_b = l_inam.getLength() - 1
                  CALL l_inam.clear() #150416-00013#2 2015/04/29 sakura add
               END IF
               CALL apmt835_b_fill() 
               #ken---add---e         
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
               LET gs_keys[01] = g_pmdc_m.pmdcdocno
               LET gs_keys[gs_keys.getLength()+1] = g_pmdc_m.pmdc900
 
               LET gs_keys[gs_keys.getLength()+1] = g_pmdd_d_t.pmddseq
 
            
               #刪除同層單身
               IF NOT apmt835_delete_b('pmdd_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE apmt835_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT apmt835_key_delete_b(gs_keys,'pmdd_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE apmt835_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE apmt835_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_pmdd_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_pmdd_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmddseq
            #add-point:BEFORE FIELD pmddseq name="input.b.page1.pmddseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmddseq
            
            #add-point:AFTER FIELD pmddseq name="input.a.page1.pmddseq"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_pmdc_m.pmdcdocno IS NOT NULL AND g_pmdc_m.pmdc900 IS NOT NULL AND g_pmdd_d[g_detail_idx].pmddseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pmdc_m.pmdcdocno != g_pmdcdocno_t OR g_pmdc_m.pmdc900 != g_pmdc900_t OR g_pmdd_d[g_detail_idx].pmddseq != g_pmdd_d_t.pmddseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pmdd_t WHERE "||"pmddent = '" ||g_enterprise|| "' AND "||"pmdddocno = '"||g_pmdc_m.pmdcdocno ||"' AND "|| "pmdd900 = '"||g_pmdc_m.pmdc900 ||"' AND "|| "pmddseq = '"||g_pmdd_d[g_detail_idx].pmddseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmddseq
            #add-point:ON CHANGE pmddseq name="input.g.page1.pmddseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd001
            #add-point:BEFORE FIELD pmdd001 name="input.b.page1.pmdd001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd001
            
            #add-point:AFTER FIELD pmdd001 name="input.a.page1.pmdd001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdd001
            #add-point:ON CHANGE pmdd001 name="input.g.page1.pmdd001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd002
            #add-point:BEFORE FIELD pmdd002 name="input.b.page1.pmdd002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd002
            
            #add-point:AFTER FIELD pmdd002 name="input.a.page1.pmdd002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdd002
            #add-point:ON CHANGE pmdd002 name="input.g.page1.pmdd002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd003
            #add-point:BEFORE FIELD pmdd003 name="input.b.page1.pmdd003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd003
            
            #add-point:AFTER FIELD pmdd003 name="input.a.page1.pmdd003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdd003
            #add-point:ON CHANGE pmdd003 name="input.g.page1.pmdd003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmddsite
            
            #add-point:AFTER FIELD pmddsite name="input.a.page1.pmddsite"
            LET g_pmdd_d[l_ac].pmddsite_desc = ''          
            IF NOT cl_null(g_pmdd_d[l_ac].pmddsite) THEN           
             # IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_pmdd_d[l_ac].pmddsite != g_pmdd_d_o.pmddsite OR g_pmdd_d_o.pmddsite IS NULL )) THEN    #150427-00012#05 2015/05/25 by s983961 mark             
               IF g_pmdd_d[l_ac].pmddsite != g_pmdd_d_o.pmddsite OR cl_null(g_pmdd_d_o.pmddsite)   THEN    #150427-00012#05 2015/0604 by s983961---add                 
                 CALL s_aooi500_chk(g_prog,'pmddsite',g_pmdd_d[l_ac].pmddsite,g_pmdc_m.pmdcsite) RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = l_errno
                     LET g_errparam.popup  = TRUE
                     
                     CALL cl_err()
                  
                     LET g_pmdd_d[l_ac].pmddsite = g_pmdd_d_o.pmddsite
                     CALL s_desc_get_department_desc(g_pmdd_d[l_ac].pmddsite) RETURNING g_pmdd_d[l_ac].pmddsite_desc
                     NEXT FIELD CURRENT
                  END IF
                  #150413-00018#1 20150414 pomelo add(S)
                  #要貨在途量計算
                  CALL s_apmt830_sum_pmdb258(g_pmdd_d[l_ac].pmddsite,g_pmdd_d[l_ac].pmdd004,g_pmdd_d[l_ac].pmdd005)
                     RETURNING g_pmdd_d[l_ac].pmdd258
                  
                  #前一、二、三、四週銷量及週平均銷量計算
                  CALL apmt835_daily_sale_all(g_pmdd_d[l_ac].pmddsite,g_pmdc_m.pmdcdocdt,g_pmdd_d[l_ac].pmdd004,g_pmdd_d[l_ac].pmdd005)
                     RETURNING g_pmdd_d[l_ac].pmdd254,g_pmdd_d[l_ac].pmdd255,g_pmdd_d[l_ac].pmdd256,g_pmdd_d[l_ac].pmdd257,g_pmdd_d[l_ac].pmdd259
                  
                  #入庫在途量計算
                  CALL s_apmt840_sum_in_way(g_pmdd_d[l_ac].pmddsite,g_pmdd_d[l_ac].pmdd004,g_pmdd_d[l_ac].pmdd005)
                     RETURNING g_pmdd_d[l_ac].pmdd253
                  #150413-00018#1 20150414 pomelo add(E)
               END IF               
            END IF   
            LET g_pmdd_d_o.pmddsite = g_pmdd_d[l_ac].pmddsite
            #150427-00012#05 2015/06/03 by s983961---add(s)
            LET g_pmdd_d_o.pmdd258  = g_pmdd_d[l_ac].pmdd258   
            LET g_pmdd_d_o.pmdd254  = g_pmdd_d[l_ac].pmdd254
            LET g_pmdd_d_o.pmdd255  = g_pmdd_d[l_ac].pmdd255
            LET g_pmdd_d_o.pmdd256  = g_pmdd_d[l_ac].pmdd256
            LET g_pmdd_d_o.pmdd257  = g_pmdd_d[l_ac].pmdd257
            LET g_pmdd_d_o.pmdd259  = g_pmdd_d[l_ac].pmdd259
            LET g_pmdd_d_o.pmdd253  = g_pmdd_d[l_ac].pmdd253   
            #150427-00012#05 2015/06/03 by s983961---add(e)
            CALL s_desc_get_department_desc(g_pmdd_d[l_ac].pmddsite) RETURNING g_pmdd_d[l_ac].pmddsite_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmddsite
            #add-point:BEFORE FIELD pmddsite name="input.b.page1.pmddsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmddsite
            #add-point:ON CHANGE pmddsite name="input.g.page1.pmddsite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd200
            
            #add-point:AFTER FIELD pmdd200 name="input.a.page1.pmdd200"
           IF NOT cl_null(g_pmdd_d[l_ac].pmdd200) THEN            
            # IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_pmdd_d[l_ac].pmdd200 != g_pmdd_d_o.pmdd200 OR g_pmdd_d_o.pmdd200 IS NULL )) THEN   #150427-00012#05 2015/05/25 by s983961 mark
              IF g_pmdd_d[l_ac].pmdd200 != g_pmdd_d_o.pmdd200 OR cl_null(g_pmdd_d_o.pmdd200)  THEN   #150427-00012#05 2015/0604 by s983961---add
                 INITIALIZE g_chkparam.* TO NULL
                 LET g_chkparam.arg1 = g_pmdd_d[l_ac].pmdd200
                 IF NOT cl_chk_exist("v_imay003_1") THEN  #條碼校驗  原不排除非主條碼
                 #IF NOT cl_chk_exist("v_imay003") THEN
                    LET g_pmdd_d[l_ac].pmdd200 = g_pmdd_d_o.pmdd200 
                    NEXT FIELD pmdd200 
                 ELSE   
                    SELECT  imay001 INTO  g_pmdd_d[l_ac].pmdd004 FROM imay_t
                     WHERE  imayent = g_enterprise AND imay003 =  g_pmdd_d[l_ac].pmdd200                  
                    IF NOT apmt835_pmdd004_chk() THEN
                       LET g_pmdd_d[l_ac].pmdd200 = g_pmdd_d_o.pmdd200
                       LET g_pmdd_d[l_ac].pmdd004 = g_pmdd_d_o.pmdd004            
                       NEXT FIELD pmdd200 
                    END IF                     
                 END IF 

                 #商品生命周期的判断  2015/03/19  geza
                 #CALL s_life_cycle_chk(g_prog,g_pmdc_m.pmdcsite,'1',g_pmdd_d[l_ac].pmdd004) RETURNING r_success   #150616-00035#78-mark by dongsz
                 CALL s_life_cycle_chk(g_prog,g_pmdc_m.pmdcsite,'1',g_pmdd_d[l_ac].pmdd004,'','') RETURNING r_success   #150616-00035#78-add by dongsz
                 IF r_success = FALSE THEN 
                    LET g_pmdd_d[l_ac].pmdd200 = g_pmdd_d_o.pmdd200
                    LET g_pmdd_d[l_ac].pmdd004 = g_pmdd_d_o.pmdd004 
                    NEXT FIELD CURRENT
                 END IF

                 #可用庫存量
                 CALL s_apmt840_sum_inag008(g_pmdd_d[l_ac].pmddsite,g_pmdd_d[l_ac].pmdd004,g_pmdd_d[l_ac].pmdd005) #150401-00005#3 sakura add pmdd005
                    RETURNING g_pmdd_d[l_ac].pmdd252  
                 
                 #入庫在途量計算
                 #CALL s_apmt840_sum_in_way(g_pmdd_d[l_ac].pmddsite,g_pmdd_d[l_ac].pmdd200) #150413-00018#1 sakura mark
                 CALL s_apmt840_sum_in_way(g_pmdd_d[l_ac].pmddsite,g_pmdd_d[l_ac].pmdd004,g_pmdd_d[l_ac].pmdd005) #150413-00018#1 sakura add
                    RETURNING g_pmdd_d[l_ac].pmdd253
                                 
                 #要貨在途量計算
                 CALL s_apmt830_sum_pmdb258(g_pmdd_d[l_ac].pmddsite,g_pmdd_d[l_ac].pmdd004,g_pmdd_d[l_ac].pmdd005)
                    RETURNING g_pmdd_d[l_ac].pmdd258  
                    
                 #前一、二、三、四週銷量及週平均銷量計算
                 CALL apmt835_daily_sale_all(g_pmdd_d[l_ac].pmddsite,g_pmdc_m.pmdc902,g_pmdd_d[l_ac].pmdd004,g_pmdd_d[l_ac].pmdd005)
                    RETURNING g_pmdd_d[l_ac].pmdd254,g_pmdd_d[l_ac].pmdd255,g_pmdd_d[l_ac].pmdd256,g_pmdd_d[l_ac].pmdd257,g_pmdd_d[l_ac].pmdd259      
                                  
                 #取得商品編號相關資訊
                 CALL apmt835_pmdd004_other()               
              END IF
            END IF
            LET g_pmdd_d_o.pmdd200 = g_pmdd_d[l_ac].pmdd200
            LET g_pmdd_d_o.pmdd004 = g_pmdd_d[l_ac].pmdd004
            #150427-00012#05 2015/06/03 by s983961---add(s)
            LET g_pmdd_d_o.pmdd258 = g_pmdd_d[l_ac].pmdd258   
            LET g_pmdd_d_o.pmdd254 = g_pmdd_d[l_ac].pmdd254
            LET g_pmdd_d_o.pmdd255 = g_pmdd_d[l_ac].pmdd255
            LET g_pmdd_d_o.pmdd256 = g_pmdd_d[l_ac].pmdd256
            LET g_pmdd_d_o.pmdd257 = g_pmdd_d[l_ac].pmdd257
            LET g_pmdd_d_o.pmdd259 = g_pmdd_d[l_ac].pmdd259
            LET g_pmdd_d_o.pmdd252 = g_pmdd_d[l_ac].pmdd252
            LET g_pmdd_d_o.pmdd253 = g_pmdd_d[l_ac].pmdd253  
            #150427-00012#05 2015/06/03 by s983961---add(e)
            CALL s_desc_get_item_desc(g_pmdd_d[l_ac].pmdd004) RETURNING g_pmdd_d[l_ac].pmdd004_desc,g_pmdd_d[l_ac].pmdd004_desc_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd200
            #add-point:BEFORE FIELD pmdd200 name="input.b.page1.pmdd200"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdd200
            #add-point:ON CHANGE pmdd200 name="input.g.page1.pmdd200"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd004
            
            #add-point:AFTER FIELD pmdd004 name="input.a.page1.pmdd004"
            LET g_pmdd_d[l_ac].pmdd004_desc= ''          #品名
            LET g_pmdd_d[l_ac].pmdd004_desc_desc = ''    #規格
            IF NOT cl_null(g_pmdd_d[l_ac].pmdd004) THEN 
              #IF (g_pmdd_d[l_ac].pmdd004 != g_pmdd_d_o.pmdd004 OR g_pmdd_d_o.pmdd004 IS NULL ) THEN  #150427-00012#05 2015/06/04 by s983961---mark
               IF g_pmdd_d[l_ac].pmdd004 != g_pmdd_d_o.pmdd004 OR cl_null(g_pmdd_d_o.pmdd004) THEN    #150427-00012#05 2015/06/04 by s983961---add              
                 IF g_pmdc_m.pmdc201 = '' THEN
                    LET g_pmdd_d[l_ac].pmdd207 = ''
                 ELSE
                    CALL apmt835_get_rtdx027(g_pmdd_d[l_ac].pmddsite,g_pmdd_d[l_ac].pmdd004) 
                       RETURNING g_pmdd_d[l_ac].pmdd207                       
                 END IF

                 #商品生命周期的判断  2015/03/19  geza
                 #CALL s_life_cycle_chk(g_prog,g_pmdc_m.pmdcsite,'1',g_pmdd_d[l_ac].pmdd004) RETURNING r_success   #150616-00035#78-mark by dongsz
                 CALL s_life_cycle_chk(g_prog,g_pmdc_m.pmdcsite,'1',g_pmdd_d[l_ac].pmdd004,'','') RETURNING r_success   #150616-00035#78-add by dongsz
                 IF r_success = FALSE THEN 
                    LET g_pmdd_d[l_ac].pmdd004 = g_pmdd_d_o.pmdd004
                    #品名、規格
                    CALL s_desc_get_item_desc(g_pmdd_d[l_ac].pmdd004) 
                       RETURNING g_pmdd_d[l_ac].pmdd004_desc,g_pmdd_d[l_ac].pmdd004_desc_desc                      
                    NEXT FIELD CURRENT
                 END IF
                 
                 IF NOT apmt835_pmdd004_chk() THEN  
                    LET g_pmdd_d[l_ac].pmdd004 = g_pmdd_d_o.pmdd004
                    #品名、規格
                    CALL s_desc_get_item_desc(g_pmdd_d[l_ac].pmdd004) RETURNING g_pmdd_d[l_ac].pmdd004_desc,g_pmdd_d[l_ac].pmdd004_desc_desc
                    NEXT FIELD pmdd004
                 ELSE
                    CALL apmt835_get_pmdd200(g_pmdd_d[l_ac].pmdd004) 
                       RETURNING g_pmdd_d[l_ac].pmdd200    
                 END IF
 
                 #可用庫存量
                 CALL s_apmt840_sum_inag008(g_pmdd_d[l_ac].pmddsite,g_pmdd_d[l_ac].pmdd004,g_pmdd_d[l_ac].pmdd005) #150401-00005#3 sakura add pmdd005
                    RETURNING g_pmdd_d[l_ac].pmdd252  
                 
                 #入庫在途量計算
                 #CALL s_apmt840_sum_in_way(g_pmdd_d[l_ac].pmddsite,g_pmdd_d[l_ac].pmdd200) #150413-00018#1 sakura add mark
                 CALL s_apmt840_sum_in_way(g_pmdd_d[l_ac].pmddsite,g_pmdd_d[l_ac].pmdd004,g_pmdd_d[l_ac].pmdd005) #150413-00018#1 sakura add add
                    RETURNING g_pmdd_d[l_ac].pmdd253
                                 
                 #要貨在途量計算
                 CALL s_apmt830_sum_pmdb258(g_pmdd_d[l_ac].pmddsite,g_pmdd_d[l_ac].pmdd004,' ')
                    RETURNING g_pmdd_d[l_ac].pmdd258  
                    
                 #前一、二、三、四週銷量及週平均銷量計算
                 CALL apmt835_daily_sale_all(g_pmdd_d[l_ac].pmddsite,g_pmdc_m.pmdc902,g_pmdd_d[l_ac].pmdd004,' ')
                    RETURNING g_pmdd_d[l_ac].pmdd254,g_pmdd_d[l_ac].pmdd255,g_pmdd_d[l_ac].pmdd256,g_pmdd_d[l_ac].pmdd257,g_pmdd_d[l_ac].pmdd259      
                 
                 #取得商品編號相關資訊
                  #150527 s983961---add s                
                  #CALL cl_get_para(g_enterprise,g_pmdd_d[l_ac].pmddsite,'S-CIR-1001') RETURNING l_sys2
                  #
                  #SELECT imaz003 INTO l_imaz003  
                  #    FROM imaz_t
                  #WHERE   imazent = g_enterprise                       
                  #     AND imaz001 =  g_pmdd_d[l_ac].pmdd004 
                  #     AND imaz002 = l_sys2  
                  #IF NOT cl_null(l_imaz003) THEN                #06/08 先判斷是否有 補貨規格級別 條碼  
                  #     LET g_pmdd_d[l_ac].pmdd200 = l_imaz003   #06/08 有抓到再更新 g_pmdb_d[l_ac].pmdb200
                  #END IF      
                  #150527 s983961---add e
                 CALL apmt835_pmdd004_other()                 
              END IF
            END IF      
            LET g_pmdd_d_o.pmdd200 = g_pmdd_d[l_ac].pmdd200
            LET g_pmdd_d_o.pmdd004 = g_pmdd_d[l_ac].pmdd004  
            #150427-00012#05 2015/06/04 by s983961---add(s)
            LET g_pmdd_d_o.pmdd258 = g_pmdd_d[l_ac].pmdd258  
            LET g_pmdd_d_o.pmdd254 = g_pmdd_d[l_ac].pmdd254
            LET g_pmdd_d_o.pmdd255 = g_pmdd_d[l_ac].pmdd255
            LET g_pmdd_d_o.pmdd256 = g_pmdd_d[l_ac].pmdd256
            LET g_pmdd_d_o.pmdd257 = g_pmdd_d[l_ac].pmdd257
            LET g_pmdd_d_o.pmdd259 = g_pmdd_d[l_ac].pmdd259
            LET g_pmdd_d_o.pmdd259 = g_pmdd_d[l_ac].pmdd252
            LET g_pmdd_d_o.pmdd253 = g_pmdd_d[l_ac].pmdd253  
            #150427-00012#05 2015/06/04 by s983961---add(e)                    
            #品名、規格
            CALL s_desc_get_item_desc(g_pmdd_d[l_ac].pmdd004) RETURNING g_pmdd_d[l_ac].pmdd004_desc,g_pmdd_d[l_ac].pmdd004_desc_desc
            CALL apmt835_set_entry_b(l_cmd)
            #add-S By Ken 150318
            CALL apmt835_set_no_required_b(l_cmd)
            CALL apmt835_set_required_b(l_cmd)
            #add-E            
            CALL apmt835_set_no_entry_b(l_cmd) 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd004
            #add-point:BEFORE FIELD pmdd004 name="input.b.page1.pmdd004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdd004
            #add-point:ON CHANGE pmdd004 name="input.g.page1.pmdd004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd005
            
            #add-point:AFTER FIELD pmdd005 name="input.a.page1.pmdd005"
            #ken---add---s 產品特徵
            LET g_pmdd_d[l_ac].pmdd005_desc = ''           
            IF NOT cl_null(g_pmdd_d[l_ac].pmdd005) THEN 
               #IF g_pmdd_d[l_ac].pmdd005 != g_pmdd_d_o.pmdd005 OR cl_null(g_pmdd_d_o.pmdd005) THEN  #150427-00012#05 2015/06/04 by s983961---mark
                IF g_pmdd_d[l_ac].pmdd005 != g_pmdd_d_o.pmdd005 OR g_pmdd_d_o.pmdd005 IS NULL THEN   #150427-00012#05 2015/06/04 by s983961---add              
                  IF NOT s_feature_check(g_pmdd_d[l_ac].pmdd004,g_pmdd_d[l_ac].pmdd005) THEN
                     LET g_pmdd_d[l_ac].pmdd005 = g_pmdd_d_o.pmdd005
                     CALL s_feature_description(g_pmdd_d[l_ac].pmdd004,g_pmdd_d[l_ac].pmdd005) 
                        RETURNING l_success,g_pmdd_d[l_ac].pmdd005_desc
                     NEXT FIELD CURRENT
                  END IF
                  #151224-00025#3 add start ------------------------
                  IF NOT s_feature_direct_input(g_pmdd_d[l_ac].pmdd004,g_pmdd_d[l_ac].pmdd005,g_pmdd_d_o.pmdd005,g_pmdc_m.pmdcdocno,g_pmdc_m.pmdcsite) THEN
                     NEXT FIELD CURRENT
                  END IF
                  #151224-00025#3 add end   ------------------------ 
               END IF
            ELSE
               IF NOT cl_null(l_imaa005) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  'sub-00124'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               ELSE
                  LET g_pmdd_d[l_ac].pmdd005 = ' '
               END IF
            END IF
         
            #要貨在途量計算
            CALL s_apmt830_sum_pmdb258(g_pmdd_d[l_ac].pmddsite,g_pmdd_d[l_ac].pmdd004,g_pmdd_d[l_ac].pmdd005)
               RETURNING g_pmdd_d[l_ac].pmdd258  
            
            #前一、二、三、四週銷量及週平均銷量計算
            CALL apmt835_daily_sale_all(g_pmdd_d[l_ac].pmddsite,g_pmdc_m.pmdc902,g_pmdd_d[l_ac].pmdd004,g_pmdd_d[l_ac].pmdd005)
               RETURNING g_pmdd_d[l_ac].pmdd254,g_pmdd_d[l_ac].pmdd255,g_pmdd_d[l_ac].pmdd256,g_pmdd_d[l_ac].pmdd257,g_pmdd_d[l_ac].pmdd259
            
            #可用庫存量
            CALL s_apmt840_sum_inag008(g_pmdd_d[l_ac].pmddsite,g_pmdd_d[l_ac].pmdd004,g_pmdd_d[l_ac].pmdd005) #150401-00005#3 sakura add pmdd005
               RETURNING g_pmdd_d[l_ac].pmdd252              
           
           #150413-00018#1 20150414 pomelo add(S)
           #入庫在途量計算
           CALL s_apmt840_sum_in_way(g_pmdd_d[l_ac].pmddsite,g_pmdd_d[l_ac].pmdd004,g_pmdd_d[l_ac].pmdd005)
              RETURNING g_pmdd_d[l_ac].pmdd253
           #150413-00018#1 20150414 pomelo add(E)
            ##現有庫存計算
            #CALL s_inventory_get_inag008_2(g_pmdd_d[l_ac].pmddsite,g_pmdd_d[l_ac].pmdd004,g_pmdd_d[l_ac].pmdd005,'','','','',g_pmdd_d[l_ac].pmdd007)
            #   RETURNING l_success,g_pmdd_d[l_ac].pmdd252
            #IF NOT l_success THEN
            #   NEXT FIELD pmdd005
            #END IF

            LET g_pmdd_d_o.pmdd005 = g_pmdd_d[l_ac].pmdd005
            #150427-00012#05 2015/06/04 by s983961---add(s)
            LET g_pmdd_d_o.pmdd258 = g_pmdd_d[l_ac].pmdd258   
            LET g_pmdd_d_o.pmdd254 = g_pmdd_d[l_ac].pmdd254
            LET g_pmdd_d_o.pmdd255 = g_pmdd_d[l_ac].pmdd255
            LET g_pmdd_d_o.pmdd256 = g_pmdd_d[l_ac].pmdd256
            LET g_pmdd_d_o.pmdd257 = g_pmdd_d[l_ac].pmdd257
            LET g_pmdd_d_o.pmdd259 = g_pmdd_d[l_ac].pmdd259
            LET g_pmdd_d_o.pmdd259 = g_pmdd_d[l_ac].pmdd252
            LET g_pmdd_d_o.pmdd253 = g_pmdd_d[l_ac].pmdd253   
            #150427-00012#05 2015/06/04 by s983961---add(e)                 
            CALL s_feature_description(g_pmdd_d[l_ac].pmdd004,g_pmdd_d[l_ac].pmdd005) 
               RETURNING l_success,g_pmdd_d[l_ac].pmdd005_desc          
            #ken---add---e
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd005
            #add-point:BEFORE FIELD pmdd005 name="input.b.page1.pmdd005"
            #160314-00009#3   marked by zhujing 2016-3-17-----(S) 元件中有判断
            #ken---add---s 產品特徵
#            LET l_imaa005 = ''
#            CALL apmt835_get_imaa005(g_pmdd_d[l_ac].pmdd004) RETURNING l_imaa005
            #160314-00009#3   marked by zhujing 2016-3-17-----(E) 
            #使用產品特徵 
            IF cl_get_para(g_enterprise,g_pmdd_d[l_ac].pmddsite,'S-BAS-0036') = 'Y' THEN 
#               IF NOT cl_null(l_imaa005) THEN      #160314-00009#3   marked by zhujing 2016-3-17
               IF s_feature_auto_chk(g_pmdd_d[l_ac].pmdd004) AND cl_null(g_pmdd_d[l_ac].pmdd005) THEN      #160314-00009#3   mod by zhujing 2016-3-17
                  CALL l_inam.clear()            
                  CALL s_feature(l_cmd,g_pmdd_d[l_ac].pmdd004,'','',g_pmdd_d[l_ac].pmddsite,g_pmdc_m.pmdcdocno) RETURNING l_success,l_inam
                  LET g_pmdd_d[l_ac].pmdd005 = l_inam[1].inam002
                  LET g_pmdd_d[l_ac].pmdd006 = l_inam[1].inam004
                  #單位間的轉換數量
                  CALL apmt835_num_change()  
                  #150413-00018#1 20150414 pomelo add(S)
                  #可用庫存量
                  CALL s_apmt840_sum_inag008(g_pmdd_d[l_ac].pmddsite,g_pmdd_d[l_ac].pmdd004,g_pmdd_d[l_ac].pmdd005)
                     RETURNING g_pmdd_d[l_ac].pmdd252
                     
                  #要貨在途量計算
                  CALL s_apmt830_sum_pmdb258(g_pmdd_d[l_ac].pmddsite,g_pmdd_d[l_ac].pmdd004,g_pmdd_d[l_ac].pmdd005)
                     RETURNING g_pmdd_d[l_ac].pmdd258
                  
                  #前一、二、三、四週銷量及週平均銷量計算
                  CALL apmt835_daily_sale_all(g_pmdd_d[l_ac].pmddsite,g_pmdc_m.pmdcdocdt,g_pmdd_d[l_ac].pmdd004,g_pmdd_d[l_ac].pmdd005)
                     RETURNING g_pmdd_d[l_ac].pmdd254,g_pmdd_d[l_ac].pmdd255,g_pmdd_d[l_ac].pmdd256,g_pmdd_d[l_ac].pmdd257,g_pmdd_d[l_ac].pmdd259
                  
                  #入庫在途量計算
                  CALL s_apmt840_sum_in_way(g_pmdd_d[l_ac].pmddsite,g_pmdd_d[l_ac].pmdd004,g_pmdd_d[l_ac].pmdd005)
                     RETURNING g_pmdd_d[l_ac].pmdd253
                  #150413-00018#1 20150414 pomelo add(E)
               END IF
            END IF            
            #ken---add---e
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdd005
            #add-point:ON CHANGE pmdd005 name="input.g.page1.pmdd005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd005_desc
            #add-point:BEFORE FIELD pmdd005_desc name="input.b.page1.pmdd005_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd005_desc
            
            #add-point:AFTER FIELD pmdd005_desc name="input.a.page1.pmdd005_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdd005_desc
            #add-point:ON CHANGE pmdd005_desc name="input.g.page1.pmdd005_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd033
            #add-point:BEFORE FIELD pmdd033 name="input.b.page1.pmdd033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd033
            
            #add-point:AFTER FIELD pmdd033 name="input.a.page1.pmdd033"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdd033
            #add-point:ON CHANGE pmdd033 name="input.g.page1.pmdd033"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd037
            
            #add-point:AFTER FIELD pmdd037 name="input.a.page1.pmdd037"
            LET g_pmdd_d[l_ac].pmdd037_desc = ' '

            IF NOT cl_null(g_pmdd_d[l_ac].pmdd037) THEN            
            #  IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_pmdd_d[l_ac].pmdd037 != g_pmdd_d_o.pmdd037 OR g_pmdd_d_o.pmdd037 IS NULL )) THEN    #150427-00012#05 2015/05/26 by s983961---mark
               IF g_pmdd_d[l_ac].pmdd037 != g_pmdd_d_o.pmdd037 OR cl_null(g_pmdd_d_o.pmdd037)  THEN    #150427-00012#05 2015/0604 by s983961---add
                  IF s_aooi500_setpoint(g_prog,'pmdd037') THEN
                     CALL s_aooi500_chk(g_prog,'pmdd037',g_pmdd_d[l_ac].pmdd037,g_pmdc_m.pmdcsite)
                        RETURNING l_success,l_errno
                     IF NOT l_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ""
                        LET g_errparam.code   = l_errno
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        LET g_pmdd_d[l_ac].pmdd037 = g_pmdd_d_o.pmdd037
                        CALL s_desc_get_department_desc(g_pmdd_d[l_ac].pmdd037)
                          RETURNING g_pmdd_d[l_ac].pmdd037_desc
                        NEXT FIELD CURRENT
                     END IF
                  ELSE
                     #此段落由子樣板a19產生
                     #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                     INITIALIZE g_chkparam.* TO NULL
                     LET g_errshow = '1'
                     LET g_chkparam.arg1 = g_pmdd_d[l_ac].pmdd037
                     LET g_chkparam.arg2 = '8'
                     LET g_chkparam.arg3 = g_pmdd_d[l_ac].pmddsite
                     IF NOT cl_chk_exist("v_ooed004") THEN
                        LET g_pmdd_d[l_ac].pmdd037 = g_pmdd_d_o.pmdd037
                        CALL s_desc_get_department_desc(g_pmdd_d[l_ac].pmdd037)
                          RETURNING g_pmdd_d[l_ac].pmdd037_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF                  
            ELSE
               LET g_pmdd_d[l_ac].pmdd038 = ''
               LET g_pmdd_d[l_ac].pmdd038_desc = ''
            END IF 
            LET g_pmdd_d_o.pmdd037 = g_pmdd_d[l_ac].pmdd037 
            CALL s_desc_get_department_desc(g_pmdd_d[l_ac].pmdd037)
              RETURNING g_pmdd_d[l_ac].pmdd037_desc 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd037
            #add-point:BEFORE FIELD pmdd037 name="input.b.page1.pmdd037"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdd037
            #add-point:ON CHANGE pmdd037 name="input.g.page1.pmdd037"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd260
            
            #add-point:AFTER FIELD pmdd260 name="input.a.page1.pmdd260"
            LET g_pmdd_d[l_ac].pmdd260_desc = ''

            IF NOT cl_null(g_pmdd_d[l_ac].pmdd260) THEN            
            #  IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_pmdd_d[l_ac].pmdd260 != g_pmdd_d_o.pmdd260 OR g_pmdd_d_o.pmdd260 IS NULL )) THEN   #150427-00012#05 2015/05/25 by s983961 mark
               IF g_pmdd_d[l_ac].pmdd260 != g_pmdd_d_o.pmdd260 OR cl_null(g_pmdd_d_o.pmdd260)  THEN   #150427-00012#05 2015/0604 by s983961---addd
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_pmdd_d[l_ac].pmdd260
                  LET g_chkparam.arg2 = g_pmdc_m.pmdc902
                  #160318-00025#21  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                 #160318-00025#21  by 07900 --add-end
                  IF NOT cl_chk_exist("v_ooeg001") THEN
                     LET g_pmdd_d[l_ac].pmdd260 = g_pmdd_d_o.pmdd260
                     CALL s_desc_get_department_desc(g_pmdd_d[l_ac].pmdd260)
                        RETURNING g_pmdd_d[l_ac].pmdd260_desc
                     #檢查失敗時後續處理
                     NEXT FIELD CURRENT
                  END IF       
               END IF                  
            END IF
            LET g_pmdd_d_o.pmdd260 = g_pmdd_d[l_ac].pmdd260 
            CALL s_desc_get_department_desc(g_pmdd_d[l_ac].pmdd260)
               RETURNING g_pmdd_d[l_ac].pmdd260_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd260
            #add-point:BEFORE FIELD pmdd260 name="input.b.page1.pmdd260"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdd260
            #add-point:ON CHANGE pmdd260 name="input.g.page1.pmdd260"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd038
            
            #add-point:AFTER FIELD pmdd038 name="input.a.page1.pmdd038"
            LET g_pmdd_d[l_ac].pmdd038_desc = ' '
            
            IF NOT cl_null(g_pmdd_d[l_ac].pmdd038) THEN
               IF g_pmdd_d[l_ac].pmdd038 != g_pmdd_d_o.pmdd038 OR cl_null(g_pmdd_d_o.pmdd038) THEN             
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_pmdd_d[l_ac].pmdd037
                  LET g_chkparam.arg2 = g_pmdd_d[l_ac].pmdd038
                     
                  IF NOT cl_chk_exist("v_inaa001_1") THEN
                     LET g_pmdd_d[l_ac].pmdd038 = g_pmdd_d_o.pmdd038
                     CALL s_desc_get_stock_desc('',g_pmdd_d[l_ac].pmdd038) RETURNING  g_pmdd_d[l_ac].pmdd038_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_pmdd_d_o.pmdd038 = g_pmdd_d[l_ac].pmdd038
            CALL s_desc_get_stock_desc('',g_pmdd_d[l_ac].pmdd038) RETURNING  g_pmdd_d[l_ac].pmdd038_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd038
            #add-point:BEFORE FIELD pmdd038 name="input.b.page1.pmdd038"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdd038
            #add-point:ON CHANGE pmdd038 name="input.g.page1.pmdd038"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd227
            #add-point:BEFORE FIELD pmdd227 name="input.b.page1.pmdd227"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd227
            
            #add-point:AFTER FIELD pmdd227 name="input.a.page1.pmdd227"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdd227
            #add-point:ON CHANGE pmdd227 name="input.g.page1.pmdd227"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd201
            
            #add-point:AFTER FIELD pmdd201 name="input.a.page1.pmdd201"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd201
            #add-point:BEFORE FIELD pmdd201 name="input.b.page1.pmdd201"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdd201
            #add-point:ON CHANGE pmdd201 name="input.g.page1.pmdd201"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd202
            #add-point:BEFORE FIELD pmdd202 name="input.b.page1.pmdd202"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd202
            
            #add-point:AFTER FIELD pmdd202 name="input.a.page1.pmdd202"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdd202
            #add-point:ON CHANGE pmdd202 name="input.g.page1.pmdd202"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd212
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmdd_d[l_ac].pmdd212,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD pmdd212
            END IF 
 
 
 
            #add-point:AFTER FIELD pmdd212 name="input.a.page1.pmdd212"
            IF NOT cl_null(g_pmdd_d[l_ac].pmdd212) THEN
               IF g_pmdd_d[l_ac].pmdd212 != g_pmdd_d_o.pmdd212 OR cl_null(g_pmdd_d_o.pmdd212) THEN 
                  #對要貨件數進行取位
                  CALL s_aooi250_take_decimals(g_pmdd_d[l_ac].pmdd201,g_pmdd_d[l_ac].pmdd212) 
                     RETURNING l_success,g_pmdd_d[l_ac].pmdd212
                  #換算要貨數量
                  IF NOT cl_null(g_pmdd_d[l_ac].pmdd007) THEN
                     CALL s_aooi250_convert_qty(g_pmdd_d[l_ac].pmdd004,g_pmdd_d[l_ac].pmdd201,g_pmdd_d[l_ac].pmdd007,g_pmdd_d[l_ac].pmdd212)
                        RETURNING l_success,g_pmdd_d[l_ac].pmdd006
                  END IF                  
               END IF 
            END IF
            LET g_pmdd_d_o.pmdd212 = g_pmdd_d[l_ac].pmdd212
            LET g_pmdd_d_o.pmdd212 = g_pmdd_d[l_ac].pmdd006   #150427-00012#05 2015/06/04 by s983961---add
            CALL apmt835_set_entry_b(l_cmd)
            #add-S By Ken 150318
            CALL apmt835_set_no_required_b(l_cmd)
            CALL apmt835_set_required_b(l_cmd)
            #add-E            
            CALL apmt835_set_no_entry_b(l_cmd)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd212
            #add-point:BEFORE FIELD pmdd212 name="input.b.page1.pmdd212"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdd212
            #add-point:ON CHANGE pmdd212 name="input.g.page1.pmdd212"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd007
            
            #add-point:AFTER FIELD pmdd007 name="input.a.page1.pmdd007"
            LET g_pmdd_d[l_ac].pmdd007_desc = ''
            IF NOT cl_null(g_pmdd_d[l_ac].pmdd007) THEN    
               IF g_pmdd_d[l_ac].pmdd007 != g_pmdd_d_o.pmdd007 OR cl_null(g_pmdd_d_o.pmdd007) THEN                
                  INITIALIZE g_chkparam.* TO NULL                
                  LET g_chkparam.arg1 = g_pmdd_d[l_ac].pmdd007
                  #160318-00025#21  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
                  #160318-00025#21  by 07900 --add-end                  
                  IF NOT cl_chk_exist("v_ooca001") THEN
                     LET g_pmdd_d[l_ac].pmdd007 = g_pmdd_d_o.pmdd007 
                     CALL s_desc_get_unit_desc(g_pmdd_d[l_ac].pmdd007) RETURNING g_pmdd_d[l_ac].pmdd007_desc     
                     NEXT FIELD CURRENT
                  ELSE
                     IF NOT cl_null(g_pmdd_d[l_ac].pmdd212) THEN
                        #對要貨件數進行取位
                        CALL s_aooi250_take_decimals(g_pmdd_d[l_ac].pmdd201,g_pmdd_d[l_ac].pmdd212) RETURNING l_success,g_pmdd_d[l_ac].pmdd212
                        #換算要貨數量
                        CALL s_aooi250_convert_qty(g_pmdd_d[l_ac].pmdd004,g_pmdd_d[l_ac].pmdd201,g_pmdd_d[l_ac].pmdd007,g_pmdd_d[l_ac].pmdd212)
                            RETURNING l_success,g_pmdd_d[l_ac].pmdd006                         
                     END IF                                              
                  END IF
               END IF
            END IF
            LET g_pmdd_d_o.pmdd007 = g_pmdd_d[l_ac].pmdd007
            LET g_pmdd_d_o.pmdd006 = g_pmdd_d[l_ac].pmdd006   #150427-00012#05 2015/06/04 by s983961---add
            LET g_pmdd_d_o.pmdd212 = g_pmdd_d[l_ac].pmdd212   #150427-00012#05 2015/06/04 by s983961---add            
            CALL s_desc_get_unit_desc(g_pmdd_d[l_ac].pmdd007) RETURNING g_pmdd_d[l_ac].pmdd007_desc
            CALL apmt835_set_entry_b(l_cmd)
            #add-S By Ken 150318
            CALL apmt835_set_no_required_b(l_cmd)
            CALL apmt835_set_required_b(l_cmd)
            #add-E            
            CALL apmt835_set_no_entry_b(l_cmd)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd007
            #add-point:BEFORE FIELD pmdd007 name="input.b.page1.pmdd007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdd007
            #add-point:ON CHANGE pmdd007 name="input.g.page1.pmdd007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd006
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmdd_d[l_ac].pmdd006,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD pmdd006
            END IF 
 
 
 
            #add-point:AFTER FIELD pmdd006 name="input.a.page1.pmdd006"
            IF NOT cl_null(g_pmdd_d[l_ac].pmdd006) THEN
               IF g_pmdd_d[l_ac].pmdd006 != g_pmdd_d_o.pmdd006 OR cl_null(g_pmdd_d_o.pmdd006) THEN               
                  #對要貨數量進行取位
                  CALL s_aooi250_take_decimals(g_pmdd_d[l_ac].pmdd007,g_pmdd_d[l_ac].pmdd006) 
                     RETURNING l_success,g_pmdd_d[l_ac].pmdd006
                  #換算要貨件數
                  IF NOT cl_null(g_pmdd_d[l_ac].pmdd007) THEN
                     CALL s_aooi250_convert_qty(g_pmdd_d[l_ac].pmdd004,g_pmdd_d[l_ac].pmdd007,g_pmdd_d[l_ac].pmdd201,g_pmdd_d[l_ac].pmdd006)
                         RETURNING l_success,g_pmdd_d[l_ac].pmdd212
                  END IF
               END IF                  
            END IF
            LET g_pmdd_d_o.pmdd006 = g_pmdd_d[l_ac].pmdd006
            IF cl_null(g_pmdd_d[l_ac].pmdd006) THEN
               LET g_pmdd_d[l_ac].pmdd212 = null
            END IF            
            CALL apmt835_set_entry_b(l_cmd)
            #add-S By Ken 150318
            CALL apmt835_set_no_required_b(l_cmd)
            CALL apmt835_set_required_b(l_cmd)
            #add-E            
            CALL apmt835_set_no_entry_b(l_cmd)
            LET g_pmdd_d_o.pmdd212 = g_pmdd_d[l_ac].pmdd212   #150427-00012#05 2015/06/04 by s983961---add         
            LET g_pmdd_d_o.pmdd006 = g_pmdd_d[l_ac].pmdd006   #150427-00012#05 2015/06/04 by s983961---add         
            IF cl_null(g_pmdd_d[l_ac].pmdd006) THEN
               NEXT FIELD pmdd212
            END IF            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd006
            #add-point:BEFORE FIELD pmdd006 name="input.b.page1.pmdd006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdd006
            #add-point:ON CHANGE pmdd006 name="input.g.page1.pmdd006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd253
            #add-point:BEFORE FIELD pmdd253 name="input.b.page1.pmdd253"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd253
            
            #add-point:AFTER FIELD pmdd253 name="input.a.page1.pmdd253"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdd253
            #add-point:ON CHANGE pmdd253 name="input.g.page1.pmdd253"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd258
            #add-point:BEFORE FIELD pmdd258 name="input.b.page1.pmdd258"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd258
            
            #add-point:AFTER FIELD pmdd258 name="input.a.page1.pmdd258"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdd258
            #add-point:ON CHANGE pmdd258 name="input.g.page1.pmdd258"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd254
            #add-point:BEFORE FIELD pmdd254 name="input.b.page1.pmdd254"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd254
            
            #add-point:AFTER FIELD pmdd254 name="input.a.page1.pmdd254"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdd254
            #add-point:ON CHANGE pmdd254 name="input.g.page1.pmdd254"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd255
            #add-point:BEFORE FIELD pmdd255 name="input.b.page1.pmdd255"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd255
            
            #add-point:AFTER FIELD pmdd255 name="input.a.page1.pmdd255"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdd255
            #add-point:ON CHANGE pmdd255 name="input.g.page1.pmdd255"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd256
            #add-point:BEFORE FIELD pmdd256 name="input.b.page1.pmdd256"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd256
            
            #add-point:AFTER FIELD pmdd256 name="input.a.page1.pmdd256"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdd256
            #add-point:ON CHANGE pmdd256 name="input.g.page1.pmdd256"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd257
            #add-point:BEFORE FIELD pmdd257 name="input.b.page1.pmdd257"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd257
            
            #add-point:AFTER FIELD pmdd257 name="input.a.page1.pmdd257"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdd257
            #add-point:ON CHANGE pmdd257 name="input.g.page1.pmdd257"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd259
            #add-point:BEFORE FIELD pmdd259 name="input.b.page1.pmdd259"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd259
            
            #add-point:AFTER FIELD pmdd259 name="input.a.page1.pmdd259"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdd259
            #add-point:ON CHANGE pmdd259 name="input.g.page1.pmdd259"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd252
            #add-point:BEFORE FIELD pmdd252 name="input.b.page1.pmdd252"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd252
            
            #add-point:AFTER FIELD pmdd252 name="input.a.page1.pmdd252"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdd252
            #add-point:ON CHANGE pmdd252 name="input.g.page1.pmdd252"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd207
            #add-point:BEFORE FIELD pmdd207 name="input.b.page1.pmdd207"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd207
            
            #add-point:AFTER FIELD pmdd207 name="input.a.page1.pmdd207"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdd207
            #add-point:ON CHANGE pmdd207 name="input.g.page1.pmdd207"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd015
            
            #add-point:AFTER FIELD pmdd015 name="input.a.page1.pmdd015"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd015
            #add-point:BEFORE FIELD pmdd015 name="input.b.page1.pmdd015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdd015
            #add-point:ON CHANGE pmdd015 name="input.g.page1.pmdd015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd049
            #add-point:BEFORE FIELD pmdd049 name="input.b.page1.pmdd049"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd049
            
            #add-point:AFTER FIELD pmdd049 name="input.a.page1.pmdd049"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdd049
            #add-point:ON CHANGE pmdd049 name="input.g.page1.pmdd049"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd030
            #add-point:BEFORE FIELD pmdd030 name="input.b.page1.pmdd030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd030
            
            #add-point:AFTER FIELD pmdd030 name="input.a.page1.pmdd030"
            IF NOT cl_null(g_pmdd_d[l_ac].pmdd030) THEN
               IF g_pmdd_d[l_ac].pmdd030 != g_pmdd_d_o.pmdd030 OR cl_null(g_pmdd_d_o.pmdd030) THEN                                                     
                  IF NOT cl_null(g_pmdc_m.pmdc207) AND g_pmdd_d[l_ac].pmdd030 > g_pmdc_m.pmdc207 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apm-00346'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  
                     LET g_pmdd_d[l_ac].pmdd030 = g_pmdd_d_o.pmdd030
                     NEXT FIELD pmdd030
                  END IF
                  IF NOT cl_null(g_pmdd_d[l_ac].pmdd210) AND g_pmdd_d[l_ac].pmdd030 >g_pmdd_d[l_ac].pmdd210  THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = 'apm-00347'
                      LET g_errparam.extend = ''
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                  
                      LET g_pmdd_d[l_ac].pmdd030 = g_pmdd_d_o.pmdd030
                     NEXT FIELD pmdd030
                  END IF
               END IF
            END IF
			   LET g_pmdd_d_o.pmdd030 = g_pmdd_d[l_ac].pmdd030
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdd030
            #add-point:ON CHANGE pmdd030 name="input.g.page1.pmdd030"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd048
            
            #add-point:AFTER FIELD pmdd048 name="input.a.page1.pmdd048"
            LET g_pmdd_d[l_ac].pmdd048_desc = ''
             
            IF NOT cl_null(g_pmdd_d[l_ac].pmdd048) THEN
              IF g_pmdd_d[l_ac].pmdd048 != g_pmdd_d_o.pmdd048 OR cl_null(g_pmdd_d_o.pmdd048) THEN      
                 IF NOT s_azzi650_chk_exist(g_pmdd048_acc,g_pmdd_d[l_ac].pmdd048) THEN
                     LET g_pmdd_d[l_ac].pmdd048 = g_pmdd_d_o.pmdd048
                     CALL s_desc_get_acc_desc(g_pmdd048_acc,g_pmdd_d[l_ac].pmdd048) RETURNING g_pmdd_d[l_ac].pmdd048_desc
                     NEXT FIELD pmdd048
                 END IF
              END IF              
            END IF
            LET g_pmdd_d_o.pmdd048 = g_pmdd_d[l_ac].pmdd048            
            CALL s_desc_get_acc_desc(g_pmdd048_acc,g_pmdd_d[l_ac].pmdd048) RETURNING g_pmdd_d[l_ac].pmdd048_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd048
            #add-point:BEFORE FIELD pmdd048 name="input.b.page1.pmdd048"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdd048
            #add-point:ON CHANGE pmdd048 name="input.g.page1.pmdd048"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd208
            #add-point:BEFORE FIELD pmdd208 name="input.b.page1.pmdd208"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd208
            
            #add-point:AFTER FIELD pmdd208 name="input.a.page1.pmdd208"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdd208
            #add-point:ON CHANGE pmdd208 name="input.g.page1.pmdd208"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd209
            
            #add-point:AFTER FIELD pmdd209 name="input.a.page1.pmdd209"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd209
            #add-point:BEFORE FIELD pmdd209 name="input.b.page1.pmdd209"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdd209
            #add-point:ON CHANGE pmdd209 name="input.g.page1.pmdd209"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd206
            
            #add-point:AFTER FIELD pmdd206 name="input.a.page1.pmdd206"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd206
            #add-point:BEFORE FIELD pmdd206 name="input.b.page1.pmdd206"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdd206
            #add-point:ON CHANGE pmdd206 name="input.g.page1.pmdd206"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd210
            #add-point:BEFORE FIELD pmdd210 name="input.b.page1.pmdd210"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd210
            
            #add-point:AFTER FIELD pmdd210 name="input.a.page1.pmdd210"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdd210
            #add-point:ON CHANGE pmdd210 name="input.g.page1.pmdd210"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd211
            #add-point:BEFORE FIELD pmdd211 name="input.b.page1.pmdd211"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd211
            
            #add-point:AFTER FIELD pmdd211 name="input.a.page1.pmdd211"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdd211
            #add-point:ON CHANGE pmdd211 name="input.g.page1.pmdd211"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd205
            
            #add-point:AFTER FIELD pmdd205 name="input.a.page1.pmdd205"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd205
            #add-point:BEFORE FIELD pmdd205 name="input.b.page1.pmdd205"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdd205
            #add-point:ON CHANGE pmdd205 name="input.g.page1.pmdd205"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd203
            
            #add-point:AFTER FIELD pmdd203 name="input.a.page1.pmdd203"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd203
            #add-point:BEFORE FIELD pmdd203 name="input.b.page1.pmdd203"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdd203
            #add-point:ON CHANGE pmdd203 name="input.g.page1.pmdd203"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd204
            
            #add-point:AFTER FIELD pmdd204 name="input.a.page1.pmdd204"
            LET g_pmdd_d[l_ac].pmdd204_desc = ''
            
            IF NOT cl_null(g_pmdd_d[l_ac].pmdd204) THEN
               IF g_pmdd_d[l_ac].pmdd204 != g_pmdd_d_o.pmdd204 OR cl_null(g_pmdd_d_o.pmdd204) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_pmdd_d[l_ac].pmdd203
                  LET g_chkparam.arg2 = g_pmdd_d[l_ac].pmdd204
                  IF NOT cl_chk_exist("v_inaa001_1") THEN
                     LET g_pmdd_d[l_ac].pmdd204 = g_pmdd_d_o.pmdd204
                     CALL s_desc_get_stock_desc('',g_pmdd_d[l_ac].pmdd204) RETURNING  g_pmdd_d[l_ac].pmdd204_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_pmdd_d_o.pmdd204 = g_pmdd_d[l_ac].pmdd204
            CALL s_desc_get_stock_desc('',g_pmdd_d[l_ac].pmdd204) RETURNING  g_pmdd_d[l_ac].pmdd204_desc 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd204
            #add-point:BEFORE FIELD pmdd204 name="input.b.page1.pmdd204"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdd204
            #add-point:ON CHANGE pmdd204 name="input.g.page1.pmdd204"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_pmdb032
            #add-point:BEFORE FIELD l_pmdb032 name="input.b.page1.l_pmdb032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_pmdb032
            
            #add-point:AFTER FIELD l_pmdb032 name="input.a.page1.l_pmdb032"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_pmdb032
            #add-point:ON CHANGE l_pmdb032 name="input.g.page1.l_pmdb032"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd032
            #add-point:BEFORE FIELD pmdd032 name="input.b.page1.pmdd032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd032
            
            #add-point:AFTER FIELD pmdd032 name="input.a.page1.pmdd032"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdd032
            #add-point:ON CHANGE pmdd032 name="input.g.page1.pmdd032"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd901
            #add-point:BEFORE FIELD pmdd901 name="input.b.page1.pmdd901"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd901
            
            #add-point:AFTER FIELD pmdd901 name="input.a.page1.pmdd901"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdd901
            #add-point:ON CHANGE pmdd901 name="input.g.page1.pmdd901"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd902
            
            #add-point:AFTER FIELD pmdd902 name="input.a.page1.pmdd902"
            LET g_pmdd_d[l_ac].pmdd902_desc = ''

            IF NOT cl_null(g_pmdd_d[l_ac].pmdd902) THEN
		         IF g_pmdd_d[l_ac].pmdd902 != g_pmdd_d_o.pmdd902 OR cl_null(g_pmdd_d_o.pmdd902) THEN
                  IF NOT s_azzi650_chk_exist(g_pmdd902_acc,g_pmdd_d[l_ac].pmdd902) THEN
                     LET g_pmdd_d[l_ac].pmdd902 = g_pmdd_d_o.pmdd902
                     CALL s_desc_get_acc_desc(g_pmdd902_acc,g_pmdd_d[l_ac].pmdd902) RETURNING g_pmdd_d[l_ac].pmdd902_desc
                     NEXT FIELD CURRENT            
                  END IF 
               END IF
		      END IF
		      LET g_pmdd_d_o.pmdd902 = g_pmdd_d[l_ac].pmdd902
            CALL s_desc_get_acc_desc(g_pmdd902_acc,g_pmdd_d[l_ac].pmdd902) RETURNING g_pmdd_d[l_ac].pmdd902_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd902
            #add-point:BEFORE FIELD pmdd902 name="input.b.page1.pmdd902"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdd902
            #add-point:ON CHANGE pmdd902 name="input.g.page1.pmdd902"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdd903
            #add-point:BEFORE FIELD pmdd903 name="input.b.page1.pmdd903"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdd903
            
            #add-point:AFTER FIELD pmdd903 name="input.a.page1.pmdd903"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdd903
            #add-point:ON CHANGE pmdd903 name="input.g.page1.pmdd903"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.pmddseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmddseq
            #add-point:ON ACTION controlp INFIELD pmddseq name="input.c.page1.pmddseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdd001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd001
            #add-point:ON ACTION controlp INFIELD pmdd001 name="input.c.page1.pmdd001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdd002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd002
            #add-point:ON ACTION controlp INFIELD pmdd002 name="input.c.page1.pmdd002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdd003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd003
            #add-point:ON ACTION controlp INFIELD pmdd003 name="input.c.page1.pmdd003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmddsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmddsite
            #add-point:ON ACTION controlp INFIELD pmddsite name="input.c.page1.pmddsite"
		      INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdd_d[l_ac].pmddsite             #給予default值                             #呼叫開窗
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmddsite',g_pmdc_m.pmdcsite,'i') #150308-00001#2  By sakura add 'i'
            CALL q_ooef001_24()
            LET g_pmdd_d[l_ac].pmddsite = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_pmdd_d[l_ac].pmddsite TO pmddsite              #顯示到畫面上
            CALL s_desc_get_department_desc(g_pmdd_d[l_ac].pmddsite) RETURNING g_pmdd_d[l_ac].pmddsite_desc
            NEXT FIELD pmddsite                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdd200
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd200
            #add-point:ON ACTION controlp INFIELD pmdd200 name="input.c.page1.pmdd200"
			   INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmdd_d[l_ac].pmdd200             #給予default值
            LET g_qryparam.arg1 =  g_pmdd_d[l_ac].pmddsite
            LET g_qryparam.arg2 =  g_pmdc_m.pmdcdocdt 
            #給予arg
            IF NOT cl_null(g_pmdc_m.pmdc202) THEN
               CALL cl_get_para(g_enterprise,g_site,'E-CIR-0001') RETURNING l_sys
               LET g_qryparam.where = " imaa009 IN (SELECT DISTINCT rtax001 FROM rtax_t ",
                                      "              WHERE rtaxent ='",g_enterprise,"' AND rtax004 >='",l_sys,"' AND rtaxstus = 'Y'",
                                      "              START WITH rtax003 = '",g_pmdc_m.pmdc202,"' AND rtaxstus = 'Y' CONNECT BY nocycle PRIOR rtax001 = rtax003 )"                                        
            END IF
            IF NOT cl_null(g_pmdc_m.pmdc201) THEN
               IF NOT cl_null(g_qryparam.where) THEN
                  LET g_qryparam.where = g_qryparam.where," AND rtdx027 = '",g_pmdc_m.pmdc201,"'"
               ELSE
                  LET g_qryparam.where = " rtdx027 = '",g_pmdc_m.pmdc201,"'"
               END IF
            END IF 
            
             IF NOT cl_null(g_pmdc_m.pmdc204) THEN
               IF NOT cl_null(g_qryparam.where) THEN
                  LET g_qryparam.where = g_qryparam.where," AND rtdx028 = '",g_pmdc_m.pmdc204,"'"
               ELSE
                  LET g_qryparam.where = " rtdx028 = '",g_pmdc_m.pmdc204,"'"
               END IF
            END IF            
            IF NOT cl_null(g_pmdc_m.pmdc205) THEN
               IF NOT cl_null(g_qryparam.where) THEN
                  LET g_qryparam.where = g_qryparam.where," AND rtdx029 = '",g_pmdc_m.pmdc205,"'"
               ELSE
                  LET g_qryparam.where = " rtdx029 = '",g_pmdc_m.pmdc205,"'"
               END IF
            END IF             
            #150126-00028#14 By benson ---- S
            IF cl_null(g_qryparam.where) THEN
               #LET g_qryparam.where = s_arti204_control_where(g_prog,g_pmdc_m.pmdc003,'1')   #160118-00013#6 20160118 by s983961--mark
               LET g_qryparam.where = s_arti204_control_where(g_para_pro,g_pmdc_m.pmdc003,'1') #160118-00013#6 20160118 by s983961--add
            ELSE
               #LET g_qryparam.where = g_qryparam.where CLIPPED," AND ",s_arti204_control_where(g_prog,g_pmdc_m.pmdc003,'1')    #160118-00013#6 20160118 by s983961--mark
               LET g_qryparam.where = g_qryparam.where CLIPPED," AND ",s_arti204_control_where(g_para_pro,g_pmdc_m.pmdc003,'1')  #160118-00013#6 20160118 by s983961--mark
            END IF           
            #150126-00028#14 By benson ---- E        
            #加上協議日期條件
            #150424-00021#1 Modify-S By Ken 150430
            #Mark 150521
            #LET g_qryparam.where = g_qryparam.where CLIPPED," AND (imaf153 IS NULL OR  EXISTS(SELECT 1 FROM stan_t,star_t,stas_t WHERE stan001 = star004 AND star001 = stas001
            #   AND stas003 =rtdx001 AND star003 = imaf153 AND starstus = 'Y' AND to_date('", g_pmdc_m.pmdcdocdt ,"','YYYY/MM/DD') between stan017 AND stan018 AND imaf153 IS NOT NULL  )) "                        
            #Mark 150521
            #LET g_qryparam.where = g_qryparam.where CLIPPED," AND (rtdx031 IS NULL OR  EXISTS(SELECT 1 FROM stan_t,star_t,stas_t WHERE stan001 = star004 AND star001 = stas001
            #   AND stas003 =rtdx001 AND star003 = rtdx031 AND starstus = 'Y' AND to_date('", g_pmdc_m.pmdcdocdt ,"','YYYY/MM/DD') between stan017 AND stan018 AND rtdx031 IS NOT NULL  )) "            
            #150424-00021#1 Modify-E
            CALL q_imay003_5()                              #呼叫開窗
            #CALL q_rtdx002()
            LET g_pmdd_d[l_ac].pmdd200 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmdd_d[l_ac].pmdd200 TO pmdd200              #顯示到畫面上

            NEXT FIELD pmdd200                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdd004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd004
            #add-point:ON ACTION controlp INFIELD pmdd004 name="input.c.page1.pmdd004"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdd_d[l_ac].pmdd004             #給予default值
            #給予arg
            LET g_qryparam.arg1 =  g_pmdd_d[l_ac].pmddsite
            LET g_qryparam.arg2 = g_pmdc_m.pmdcdocdt
            IF NOT cl_null(g_pmdc_m.pmdc202) THEN
               CALL cl_get_para(g_enterprise,g_site,'E-CIR-0001') RETURNING l_sys
               LET g_qryparam.where = " imaa009 IN (SELECT DISTINCT rtax001 FROM rtax_t ",
                                      "              WHERE rtaxent ='",g_enterprise,"' AND rtax004 >='",l_sys,"' AND rtaxstus = 'Y'",
                                      "              START WITH rtax003 = '",g_pmdc_m.pmdc202,"' AND rtaxstus = 'Y' CONNECT BY nocycle PRIOR rtax001 = rtax003 )"                                             
            END IF
            IF NOT cl_null(g_pmdc_m.pmdc201) THEN
               IF NOT cl_null(g_qryparam.where) THEN
                  LET g_qryparam.where = g_qryparam.where," AND rtdx027 = '",g_pmdc_m.pmdc201,"'"
               ELSE
                  LET g_qryparam.where = " rtdx027 = '",g_pmdc_m.pmdc201,"'"
               END IF
            END IF 
            
             IF NOT cl_null(g_pmdc_m.pmdc204) THEN
               IF NOT cl_null(g_qryparam.where) THEN
                  LET g_qryparam.where = g_qryparam.where," AND rtdx028 = '",g_pmdc_m.pmdc204,"'"
               ELSE
                  LET g_qryparam.where = " rtdx028 = '",g_pmdc_m.pmdc204,"'"
               END IF
            END IF            
            IF NOT cl_null(g_pmdc_m.pmdc205) THEN
               IF NOT cl_null(g_qryparam.where) THEN
                  LET g_qryparam.where = g_qryparam.where," AND rtdx029 = '",g_pmdc_m.pmdc205,"'"
               ELSE
                  LET g_qryparam.where = " rtdx029 = '",g_pmdc_m.pmdc205,"'"
               END IF
            END IF 
            #150126-00028#14 By benson ---- S
            IF cl_null(g_qryparam.where) THEN
               #LET g_qryparam.where = s_arti204_control_where(g_prog,g_pmdc_m.pmdc003,'1')    #160118-00013#6 20160118 by s983961--mark
               LET g_qryparam.where = s_arti204_control_where(g_para_pro,g_pmdc_m.pmdc003,'1')  #160118-00013#6 20160118 by s983961--add
            ELSE
               #LET g_qryparam.where = g_qryparam.where CLIPPED," AND ",s_arti204_control_where(g_prog,g_pmdc_m.pmdc003,'1')   #160118-00013#6 20160118 by s983961--mark
               LET g_qryparam.where = g_qryparam.where CLIPPED," AND ",s_arti204_control_where(g_para_pro,g_pmdc_m.pmdc003,'1') #160118-00013#6 20160118 by s983961--add
            END IF
            #150126-00028#14 By benson ---- E
            CALL q_rtdx001_15()                                #呼叫開窗
            LET g_pmdd_d[l_ac].pmdd004 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_pmdd_d[l_ac].pmdd004 TO pmdd004              #顯示到畫面上
            #品名、規格
            CALL s_desc_get_item_desc(g_pmdd_d[l_ac].pmdd004) 
               RETURNING g_pmdd_d[l_ac].pmdd004_desc,g_pmdd_d[l_ac].pmdd004_desc_desc 
            NEXT FIELD pmdd004                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdd005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd005
            #add-point:ON ACTION controlp INFIELD pmdd005 name="input.c.page1.pmdd005"
            #ken---add---s
            LET l_imaa005 = ''
            CALL apmt835_get_imaa005(g_pmdd_d[l_ac].pmdd004) RETURNING l_imaa005
               
            IF NOT cl_null(l_imaa005) THEN
               IF l_cmd = 'a' THEN            
                  CALL l_inam.clear()            
                  CALL s_feature(l_cmd,g_pmdd_d[l_ac].pmdd004,'','',g_site,g_pmdc_m.pmdcdocno) RETURNING l_success,l_inam
                  LET g_pmdd_d[l_ac].pmdd005 = l_inam[1].inam002
                  LET g_pmdd_d[l_ac].pmdd006 = l_inam[1].inam004
                  #單位間的轉換數量
                  CALL apmt835_num_change()
               END IF
               IF l_cmd = 'u' THEN
                  CALL s_feature_single(g_pmdd_d[l_ac].pmdd004,g_pmdd_d[l_ac].pmdd005,g_site,g_pmdc_m.pmdcdocno)
                     RETURNING l_success,g_pmdd_d[l_ac].pmdd005
                  CALL s_feature_description(g_pmdd_d[l_ac].pmdd004,g_pmdd_d[l_ac].pmdd005) RETURNING l_success,g_pmdd_d[l_ac].pmdd005_desc
               END IF
            END IF                          
            #ken---add---e	
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdd005_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd005_desc
            #add-point:ON ACTION controlp INFIELD pmdd005_desc name="input.c.page1.pmdd005_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdd033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd033
            #add-point:ON ACTION controlp INFIELD pmdd033 name="input.c.page1.pmdd033"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdd037
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd037
            #add-point:ON ACTION controlp INFIELD pmdd037 name="input.c.page1.pmdd037"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdd_d[l_ac].pmdd037             #給予default值
            #ken---add---S aooi500
            IF s_aooi500_setpoint(g_prog,'pmdd037') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmdd037',g_pmdc_m.pmdcsite,'i')
               CALL q_ooef001_24()
            ELSE    
               LET g_qryparam.arg1 = g_pmdd_d[l_ac].pmddsite
               LET g_qryparam.arg2 = 8
               CALL q_ooed004_3()
            END IF   
            #ken---add---E            
            LET g_pmdd_d[l_ac].pmdd037 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_pmdd_d[l_ac].pmdd037 TO pmdd037              #顯示到畫面上
            CALL s_desc_get_department_desc(g_pmdd_d[l_ac].pmdd037) RETURNING g_pmdd_d[l_ac].pmdd037_desc
            NEXT FIELD pmdd037                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdd260
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd260
            #add-point:ON ACTION controlp INFIELD pmdd260 name="input.c.page1.pmdd260"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdd_d[l_ac].pmdd260             #給予default值
            #給予arg
            LET g_qryparam.arg1 = g_pmdc_m.pmdc902 #
            CALL q_ooeg001()                                #呼叫開窗
            LET g_pmdd_d[l_ac].pmdd260 = g_qryparam.return1              
            DISPLAY g_pmdd_d[l_ac].pmdd260 TO pmdd260              #
            CALL s_desc_get_department_desc(g_pmdd_d[l_ac].pmdd260)
               RETURNING g_pmdd_d[l_ac].pmdd260_desc
            NEXT FIELD pmdd260                          #返回原欄位 
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdd038
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd038
            #add-point:ON ACTION controlp INFIELD pmdd038 name="input.c.page1.pmdd038"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdd_d[l_ac].pmdd038             #給予default值
            #給予arg
            LET g_qryparam.arg1 = g_pmdd_d[l_ac].pmdd037
            CALL q_inaa001_6()                                #呼叫開窗

            LET g_pmdd_d[l_ac].pmdd038 = g_qryparam.return1               
            DISPLAY g_pmdd_d[l_ac].pmdd038 TO pmdd038
            CALL s_desc_get_stock_desc('',g_pmdd_d[l_ac].pmdd038) RETURNING  g_pmdd_d[l_ac].pmdd038_desc            
            NEXT FIELD pmdd038                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdd227
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd227
            #add-point:ON ACTION controlp INFIELD pmdd227 name="input.c.page1.pmdd227"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdd201
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd201
            #add-point:ON ACTION controlp INFIELD pmdd201 name="input.c.page1.pmdd201"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            #INITIALIZE g_qryparam.* TO NULL
            #LET g_qryparam.state = 'i'
            #LET g_qryparam.reqry = FALSE
            #LET g_qryparam.default1 = g_pmdd_d[l_ac].pmdd201             #給予default值
            ##給予arg
            #LET g_qryparam.arg1 = "" #s
            #CALL q_ooca001_1()                                #呼叫開窗
            #LET g_pmdd_d[l_ac].pmdd201 = g_qryparam.return1              
            #DISPLAY g_pmdd_d[l_ac].pmdd201 TO pmdd201              #
            #NEXT FIELD pmdd201                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdd202
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd202
            #add-point:ON ACTION controlp INFIELD pmdd202 name="input.c.page1.pmdd202"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdd212
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd212
            #add-point:ON ACTION controlp INFIELD pmdd212 name="input.c.page1.pmdd212"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdd007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd007
            #add-point:ON ACTION controlp INFIELD pmdd007 name="input.c.page1.pmdd007"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdd_d[l_ac].pmdd007  #給予default值
            #給予arg
            CALL q_ooca001_1()                                #呼叫開窗
            LET g_pmdd_d[l_ac].pmdd007 = g_qryparam.return1   #將開窗取得的值回傳到變數
            DISPLAY g_pmdd_d[l_ac].pmdd007 TO pmdd007         #顯示到畫面上
            CALL s_desc_get_unit_desc(g_pmdd_d[l_ac].pmdd007) RETURNING g_pmdd_d[l_ac].pmdd007_desc
            DISPLAY BY NAME g_pmdd_d[l_ac].pmdd007_desc
            NEXT FIELD pmdd007                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdd006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd006
            #add-point:ON ACTION controlp INFIELD pmdd006 name="input.c.page1.pmdd006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdd253
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd253
            #add-point:ON ACTION controlp INFIELD pmdd253 name="input.c.page1.pmdd253"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdd258
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd258
            #add-point:ON ACTION controlp INFIELD pmdd258 name="input.c.page1.pmdd258"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdd254
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd254
            #add-point:ON ACTION controlp INFIELD pmdd254 name="input.c.page1.pmdd254"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdd255
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd255
            #add-point:ON ACTION controlp INFIELD pmdd255 name="input.c.page1.pmdd255"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdd256
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd256
            #add-point:ON ACTION controlp INFIELD pmdd256 name="input.c.page1.pmdd256"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdd257
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd257
            #add-point:ON ACTION controlp INFIELD pmdd257 name="input.c.page1.pmdd257"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdd259
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd259
            #add-point:ON ACTION controlp INFIELD pmdd259 name="input.c.page1.pmdd259"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdd252
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd252
            #add-point:ON ACTION controlp INFIELD pmdd252 name="input.c.page1.pmdd252"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdd207
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd207
            #add-point:ON ACTION controlp INFIELD pmdd207 name="input.c.page1.pmdd207"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdd015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd015
            #add-point:ON ACTION controlp INFIELD pmdd015 name="input.c.page1.pmdd015"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            #INITIALIZE g_qryparam.* TO NULL
            #LET g_qryparam.state = 'i'
            #LET g_qryparam.reqry = FALSE
            #LET g_qryparam.default1 = g_pmdd_d[l_ac].pmdd015             #給予default值
            ##給予arg
            #LET g_qryparam.arg1 = "" #s
            #CALL q_pmaa001_3()                                #呼叫開窗
            #LET g_pmdd_d[l_ac].pmdd015 = g_qryparam.return1              
            #DISPLAY g_pmdd_d[l_ac].pmdd015 TO pmdd015              #
            #NEXT FIELD pmdd015                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdd049
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd049
            #add-point:ON ACTION controlp INFIELD pmdd049 name="input.c.page1.pmdd049"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdd030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd030
            #add-point:ON ACTION controlp INFIELD pmdd030 name="input.c.page1.pmdd030"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdd048
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd048
            #add-point:ON ACTION controlp INFIELD pmdd048 name="input.c.page1.pmdd048"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdd_d[l_ac].pmdd048             #給予default值
            LET g_qryparam.default2 = "" #g_pmdd_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = g_pmdd048_acc
            CALL q_oocq002()                                #呼叫開窗
            LET g_pmdd_d[l_ac].pmdd048 = g_qryparam.return1              
            DISPLAY g_pmdd_d[l_ac].pmdd048 TO pmdd048              #
            CALL s_desc_get_acc_desc(g_pmdd048_acc,g_pmdd_d[l_ac].pmdd048) RETURNING g_pmdd_d[l_ac].pmdd048_desc
            NEXT FIELD pmdd048                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdd208
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd208
            #add-point:ON ACTION controlp INFIELD pmdd208 name="input.c.page1.pmdd208"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdd209
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd209
            #add-point:ON ACTION controlp INFIELD pmdd209 name="input.c.page1.pmdd209"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdd206
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd206
            #add-point:ON ACTION controlp INFIELD pmdd206 name="input.c.page1.pmdd206"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            #INITIALIZE g_qryparam.* TO NULL
            #LET g_qryparam.state = 'i'
            #LET g_qryparam.reqry = FALSE
            #LET g_qryparam.default1 = g_pmdd_d[l_ac].pmdd206             #給予default值
            ##給予arg
            #LET g_qryparam.arg1 = "" #s
            #CALL q_ooag001()                                #呼叫開窗
            #LET g_pmdd_d[l_ac].pmdd206 = g_qryparam.return1              
            #DISPLAY g_pmdd_d[l_ac].pmdd206 TO pmdd206              #
            #NEXT FIELD pmdd206                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdd210
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd210
            #add-point:ON ACTION controlp INFIELD pmdd210 name="input.c.page1.pmdd210"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdd211
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd211
            #add-point:ON ACTION controlp INFIELD pmdd211 name="input.c.page1.pmdd211"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdd205
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd205
            #add-point:ON ACTION controlp INFIELD pmdd205 name="input.c.page1.pmdd205"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdd203
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd203
            #add-point:ON ACTION controlp INFIELD pmdd203 name="input.c.page1.pmdd203"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdd204
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd204
            #add-point:ON ACTION controlp INFIELD pmdd204 name="input.c.page1.pmdd204"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdd_d[l_ac].pmdd204             #給予default值
            #給予arg
            LET g_qryparam.arg1 = g_pmdd_d[l_ac].pmdd203 #
            CALL q_inaa001_6()                                #呼叫開窗
            LET g_pmdd_d[l_ac].pmdd204 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_pmdd_d[l_ac].pmdd204 TO pmdd204              #顯示到畫面上
            CALL s_desc_get_stock_desc('',g_pmdd_d[l_ac].pmdd204) RETURNING  g_pmdd_d[l_ac].pmdd204_desc
            DISPLAY BY NAME g_pmdd_d[l_ac].pmdd204_desc
            CALL s_desc_get_stock_desc('',g_pmdd_d[l_ac].pmdd204) RETURNING  g_pmdd_d[l_ac].pmdd204_desc
            NEXT FIELD pmdd204                          #返回原欄位 


            #END add-point
 
 
         #Ctrlp:input.c.page1.l_pmdb032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_pmdb032
            #add-point:ON ACTION controlp INFIELD l_pmdb032 name="input.c.page1.l_pmdb032"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdd032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd032
            #add-point:ON ACTION controlp INFIELD pmdd032 name="input.c.page1.pmdd032"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdd901
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd901
            #add-point:ON ACTION controlp INFIELD pmdd901 name="input.c.page1.pmdd901"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdd902
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd902
            #add-point:ON ACTION controlp INFIELD pmdd902 name="input.c.page1.pmdd902"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdd_d[l_ac].pmdd902             #給予default值
            LET g_qryparam.default2 = ""
            #給予arg
            LET g_qryparam.arg1 = g_pmdd902_acc
            CALL q_oocq002()                                #呼叫開窗
            LET g_pmdd_d[l_ac].pmdd902 = g_qryparam.return1              
            DISPLAY g_pmdd_d[l_ac].pmdd902 TO pmdd902              #
            CALL s_desc_get_acc_desc(g_pmdd902_acc,g_pmdd_d[l_ac].pmdd902) RETURNING g_pmdd_d[l_ac].pmdd902_desc
            NEXT FIELD pmdd902                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdd903
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdd903
            #add-point:ON ACTION controlp INFIELD pmdd903 name="input.c.page1.pmdd903"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_pmdd_d[l_ac].* = g_pmdd_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE apmt835_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_pmdd_d[l_ac].pmddseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_pmdd_d[l_ac].* = g_pmdd_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               IF g_pmdd_d[l_ac].pmdd901 = '1' THEN  #如果是請購單中帶出的資料，則單身類型為單身修改
                  LET g_pmdd_d[l_ac].pmdd901 = '2'
               END IF
               IF g_pmdd_d[l_ac].pmdd032 = 'Y' THEN  #如果單身結案勾選，則類型變更為單身結案
                  LET g_pmdd_d[l_ac].pmdd901 = '4'
               END IF
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL apmt835_pmdd_t_mask_restore('restore_mask_o')
      
               UPDATE pmdd_t SET (pmdddocno,pmdd900,pmddseq,pmdd001,pmdd002,pmdd003,pmddsite,pmdd200, 
                   pmdd004,pmdd005,pmdd033,pmdd037,pmdd260,pmdd038,pmdd227,pmdd201,pmdd202,pmdd212,pmdd007, 
                   pmdd006,pmdd253,pmdd258,pmdd254,pmdd255,pmdd256,pmdd257,pmdd259,pmdd252,pmdd207,pmdd015, 
                   pmdd049,pmdd030,pmdd048,pmdd208,pmdd209,pmdd206,pmdd210,pmdd211,pmdd205,pmdd203,pmdd204, 
                   pmdd032,pmdd901,pmdd902,pmdd903) = (g_pmdc_m.pmdcdocno,g_pmdc_m.pmdc900,g_pmdd_d[l_ac].pmddseq, 
                   g_pmdd_d[l_ac].pmdd001,g_pmdd_d[l_ac].pmdd002,g_pmdd_d[l_ac].pmdd003,g_pmdd_d[l_ac].pmddsite, 
                   g_pmdd_d[l_ac].pmdd200,g_pmdd_d[l_ac].pmdd004,g_pmdd_d[l_ac].pmdd005,g_pmdd_d[l_ac].pmdd033, 
                   g_pmdd_d[l_ac].pmdd037,g_pmdd_d[l_ac].pmdd260,g_pmdd_d[l_ac].pmdd038,g_pmdd_d[l_ac].pmdd227, 
                   g_pmdd_d[l_ac].pmdd201,g_pmdd_d[l_ac].pmdd202,g_pmdd_d[l_ac].pmdd212,g_pmdd_d[l_ac].pmdd007, 
                   g_pmdd_d[l_ac].pmdd006,g_pmdd_d[l_ac].pmdd253,g_pmdd_d[l_ac].pmdd258,g_pmdd_d[l_ac].pmdd254, 
                   g_pmdd_d[l_ac].pmdd255,g_pmdd_d[l_ac].pmdd256,g_pmdd_d[l_ac].pmdd257,g_pmdd_d[l_ac].pmdd259, 
                   g_pmdd_d[l_ac].pmdd252,g_pmdd_d[l_ac].pmdd207,g_pmdd_d[l_ac].pmdd015,g_pmdd_d[l_ac].pmdd049, 
                   g_pmdd_d[l_ac].pmdd030,g_pmdd_d[l_ac].pmdd048,g_pmdd_d[l_ac].pmdd208,g_pmdd_d[l_ac].pmdd209, 
                   g_pmdd_d[l_ac].pmdd206,g_pmdd_d[l_ac].pmdd210,g_pmdd_d[l_ac].pmdd211,g_pmdd_d[l_ac].pmdd205, 
                   g_pmdd_d[l_ac].pmdd203,g_pmdd_d[l_ac].pmdd204,g_pmdd_d[l_ac].pmdd032,g_pmdd_d[l_ac].pmdd901, 
                   g_pmdd_d[l_ac].pmdd902,g_pmdd_d[l_ac].pmdd903)
                WHERE pmddent = g_enterprise AND pmdddocno = g_pmdc_m.pmdcdocno 
                  AND pmdd900 = g_pmdc_m.pmdc900 
 
                  AND pmddseq = g_pmdd_d_t.pmddseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_pmdd_d[l_ac].* = g_pmdd_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pmdd_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_pmdd_d[l_ac].* = g_pmdd_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pmdd_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_pmdc_m.pmdcdocno
               LET gs_keys_bak[1] = g_pmdcdocno_t
               LET gs_keys[2] = g_pmdc_m.pmdc900
               LET gs_keys_bak[2] = g_pmdc900_t
               LET gs_keys[3] = g_pmdd_d[g_detail_idx].pmddseq
               LET gs_keys_bak[3] = g_pmdd_d_t.pmddseq
               CALL apmt835_update_b('pmdd_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL apmt835_pmdd_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_pmdd_d[g_detail_idx].pmddseq = g_pmdd_d_t.pmddseq 
 
                  ) THEN
                  LET gs_keys[01] = g_pmdc_m.pmdcdocno
                  LET gs_keys[gs_keys.getLength()+1] = g_pmdc_m.pmdc900
 
                  LET gs_keys[gs_keys.getLength()+1] = g_pmdd_d_t.pmddseq
 
                  CALL apmt835_key_update_b(gs_keys,'pmdd_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_pmdc_m),util.JSON.stringify(g_pmdd_d_t)
               LET g_log2 = util.JSON.stringify(g_pmdc_m),util.JSON.stringify(g_pmdd_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               IF NOT apmt835_pmdd_ins_pmde(g_pmdd_d[l_ac].pmdd901) THEN   #'3' 單身新增  '2' 單身修改
                  LET g_pmdd_d[l_ac].* = g_pmdd_d_t.*
                  CALL s_transaction_end('N','0')
               END IF
               IF NOT apmt835_upd_pmdc208() THEN
                  LET g_pmdd_d[l_ac].* = g_pmdd_d_t.*
                  CALL s_transaction_end('N','0')
               END IF
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            #單頭包裝總數量更新
            CALL apmt835_pmdd212_sum()
            
            UPDATE pmdc_t SET pmdc208 = g_pmdc_m.pmdc208      
              WHERE pmdcent = g_enterprise 
			       AND pmdcdocno = g_pmdc_m.pmdcdocno
			  
            IF SQLCA.sqlcode THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = SQLCA.sqlcode
              LET g_errparam.extend = "pmdc_t"
              LET g_errparam.popup = FALSE
              CALL cl_err()
            END IF
            #end add-point
            CALL apmt835_unlock_b("pmdd_t","'1'")
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
               LET g_pmdd_d[li_reproduce_target].* = g_pmdd_d[li_reproduce].*
 
               LET g_pmdd_d[li_reproduce_target].pmddseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_pmdd_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_pmdd_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="apmt835.input.other" >}
      
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
            NEXT FIELD pmdcsite
            #end add-point  
            NEXT FIELD pmdcdocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD pmddseq
 
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
   IF l_flag THEN
      LET l_flag = FALSE
      CALL apmt835_modify()
   END IF
   CALL apmt835_show()
   CALL apmt835_b_fill()
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="apmt835.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION apmt835_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL apmt835_b_fill() #單身填充
      CALL apmt835_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL apmt835_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   ##單身要貨件數加總 Update到單頭包裝總數量
   #CALL apmt835_pmdd212_sum()
   #end add-point
   
   #遮罩相關處理
   LET g_pmdc_m_mask_o.* =  g_pmdc_m.*
   CALL apmt835_pmdc_t_mask()
   LET g_pmdc_m_mask_n.* =  g_pmdc_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_pmdc_m.pmdcsite,g_pmdc_m.pmdcsite_desc,g_pmdc_m.pmdc902,g_pmdc_m.pmdcdocno,g_pmdc_m.pmdc900, 
       g_pmdc_m.pmdc001,g_pmdc_m.pmdc002,g_pmdc_m.pmdc002_desc,g_pmdc_m.pmdc003,g_pmdc_m.pmdc003_desc, 
       g_pmdc_m.pmdcstus,g_pmdc_m.pmdcacti,g_pmdc_m.pmdc200,g_pmdc_m.pmdc202,g_pmdc_m.pmdc202_desc,g_pmdc_m.pmdc201, 
       g_pmdc_m.pmdc203,g_pmdc_m.pmdc203_desc,g_pmdc_m.pmdc207,g_pmdc_m.pmdc204,g_pmdc_m.pmdc204_desc, 
       g_pmdc_m.pmdc205,g_pmdc_m.pmdc205_desc,g_pmdc_m.pmdc206,g_pmdc_m.pmdc206_desc,g_pmdc_m.pmdc021, 
       g_pmdc_m.pmdc021_desc,g_pmdc_m.pmdc208,g_pmdc_m.pmdc022,g_pmdc_m.pmdc905,g_pmdc_m.pmdc905_desc, 
       g_pmdc_m.pmdc901,g_pmdc_m.pmdc906,g_pmdc_m.pmdcdocdt,g_pmdc_m.pmdcownid,g_pmdc_m.pmdcownid_desc, 
       g_pmdc_m.pmdcowndp,g_pmdc_m.pmdcowndp_desc,g_pmdc_m.pmdccrtid,g_pmdc_m.pmdccrtid_desc,g_pmdc_m.pmdccrtdp, 
       g_pmdc_m.pmdccrtdp_desc,g_pmdc_m.pmdccrtdt,g_pmdc_m.pmdcmodid,g_pmdc_m.pmdcmodid_desc,g_pmdc_m.pmdcmoddt, 
       g_pmdc_m.pmdccnfid,g_pmdc_m.pmdccnfid_desc,g_pmdc_m.pmdccnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_pmdc_m.pmdcstus 
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
   FOR l_ac = 1 TO g_pmdd_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL apmt835_detail_show()
 
   #add-point:show段之後 name="show.after"
   CALL apmt835_head_color()   #存在請購變更歷程檔中的欄位，單頭文字顏色顯示
   CALL s_hint_show('pmde_t','pmdc_t','pmda_t',g_pmdc_m.pmdcdocno,g_pmdc_m.pmdc900,0,'','')
   IF g_detail_idx > 0 THEN
      CALL s_hint_show('pmde_t','pmdd_t','pmdb_t',g_pmdc_m.pmdcdocno,g_pmdc_m.pmdc900,g_pmdd_d[g_detail_idx].pmddseq,'','')
   END IF
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="apmt835.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION apmt835_detail_show()
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
 
{<section id="apmt835.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION apmt835_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE pmdc_t.pmdcdocno 
   DEFINE l_oldno     LIKE pmdc_t.pmdcdocno 
   DEFINE l_newno02     LIKE pmdc_t.pmdc900 
   DEFINE l_oldno02     LIKE pmdc_t.pmdc900 
 
   DEFINE l_master    RECORD LIKE pmdc_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE pmdd_t.* #此變數樣板目前無使用
 
 
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
   
   IF g_pmdc_m.pmdcdocno IS NULL
   OR g_pmdc_m.pmdc900 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_pmdcdocno_t = g_pmdc_m.pmdcdocno
   LET g_pmdc900_t = g_pmdc_m.pmdc900
 
    
   LET g_pmdc_m.pmdcdocno = ""
   LET g_pmdc_m.pmdc900 = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_pmdc_m.pmdcownid = g_user
      LET g_pmdc_m.pmdcowndp = g_dept
      LET g_pmdc_m.pmdccrtid = g_user
      LET g_pmdc_m.pmdccrtdp = g_dept 
      LET g_pmdc_m.pmdccrtdt = cl_get_current()
      LET g_pmdc_m.pmdcmodid = g_user
      LET g_pmdc_m.pmdcmoddt = cl_get_current()
      LET g_pmdc_m.pmdcstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_pmdc_m.pmdcstus 
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
   
   
   CALL apmt835_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_pmdc_m.* TO NULL
      INITIALIZE g_pmdd_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL apmt835_show()
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
   CALL apmt835_set_act_visible()   
   CALL apmt835_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_pmdcdocno_t = g_pmdc_m.pmdcdocno
   LET g_pmdc900_t = g_pmdc_m.pmdc900
 
   
   #組合新增資料的條件
   LET g_add_browse = " pmdcent = " ||g_enterprise|| " AND",
                      " pmdcdocno = '", g_pmdc_m.pmdcdocno, "' "
                      ," AND pmdc900 = '", g_pmdc_m.pmdc900, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL apmt835_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL apmt835_idx_chk()
   
   LET g_data_owner = g_pmdc_m.pmdcownid      
   LET g_data_dept  = g_pmdc_m.pmdcowndp
   
   #功能已完成,通報訊息中心
   CALL apmt835_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="apmt835.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION apmt835_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE pmdd_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE apmt835_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM pmdd_t
    WHERE pmddent = g_enterprise AND pmdddocno = g_pmdcdocno_t
     AND pmdd900 = g_pmdc900_t
 
    INTO TEMP apmt835_detail
 
   #將key修正為調整後   
   UPDATE apmt835_detail 
      #更新key欄位
      SET pmdddocno = g_pmdc_m.pmdcdocno
          , pmdd900 = g_pmdc_m.pmdc900
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO pmdd_t SELECT * FROM apmt835_detail
   
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
   DROP TABLE apmt835_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_pmdcdocno_t = g_pmdc_m.pmdcdocno
   LET g_pmdc900_t = g_pmdc_m.pmdc900
 
   
END FUNCTION
 
{</section>}
 
{<section id="apmt835.delete" >}
#+ 資料刪除
PRIVATE FUNCTION apmt835_delete()
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
   
   IF g_pmdc_m.pmdcdocno IS NULL
   OR g_pmdc_m.pmdc900 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN apmt835_cl USING g_enterprise,g_pmdc_m.pmdcdocno,g_pmdc_m.pmdc900
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apmt835_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE apmt835_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE apmt835_master_referesh USING g_pmdc_m.pmdcdocno,g_pmdc_m.pmdc900 INTO g_pmdc_m.pmdcsite, 
       g_pmdc_m.pmdc902,g_pmdc_m.pmdcdocno,g_pmdc_m.pmdc900,g_pmdc_m.pmdc001,g_pmdc_m.pmdc002,g_pmdc_m.pmdc003, 
       g_pmdc_m.pmdcstus,g_pmdc_m.pmdcacti,g_pmdc_m.pmdc200,g_pmdc_m.pmdc202,g_pmdc_m.pmdc201,g_pmdc_m.pmdc203, 
       g_pmdc_m.pmdc207,g_pmdc_m.pmdc204,g_pmdc_m.pmdc205,g_pmdc_m.pmdc206,g_pmdc_m.pmdc021,g_pmdc_m.pmdc208, 
       g_pmdc_m.pmdc022,g_pmdc_m.pmdc905,g_pmdc_m.pmdc901,g_pmdc_m.pmdc906,g_pmdc_m.pmdcdocdt,g_pmdc_m.pmdcownid, 
       g_pmdc_m.pmdcowndp,g_pmdc_m.pmdccrtid,g_pmdc_m.pmdccrtdp,g_pmdc_m.pmdccrtdt,g_pmdc_m.pmdcmodid, 
       g_pmdc_m.pmdcmoddt,g_pmdc_m.pmdccnfid,g_pmdc_m.pmdccnfdt,g_pmdc_m.pmdcsite_desc,g_pmdc_m.pmdc002_desc, 
       g_pmdc_m.pmdc003_desc,g_pmdc_m.pmdc202_desc,g_pmdc_m.pmdc203_desc,g_pmdc_m.pmdc204_desc,g_pmdc_m.pmdc205_desc, 
       g_pmdc_m.pmdc206_desc,g_pmdc_m.pmdc021_desc,g_pmdc_m.pmdc905_desc,g_pmdc_m.pmdcownid_desc,g_pmdc_m.pmdcowndp_desc, 
       g_pmdc_m.pmdccrtid_desc,g_pmdc_m.pmdccrtdp_desc,g_pmdc_m.pmdcmodid_desc,g_pmdc_m.pmdccnfid_desc 
 
   
   
   #檢查是否允許此動作
   IF NOT apmt835_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_pmdc_m_mask_o.* =  g_pmdc_m.*
   CALL apmt835_pmdc_t_mask()
   LET g_pmdc_m_mask_n.* =  g_pmdc_m.*
   
   CALL apmt835_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL apmt835_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_pmdcdocno_t = g_pmdc_m.pmdcdocno
      LET g_pmdc900_t = g_pmdc_m.pmdc900
 
 
      DELETE FROM pmdc_t
       WHERE pmdcent = g_enterprise AND pmdcdocno = g_pmdc_m.pmdcdocno
         AND pmdc900 = g_pmdc_m.pmdc900
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_pmdc_m.pmdcdocno,":",SQLERRMESSAGE  
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
      
      DELETE FROM pmdd_t
       WHERE pmddent = g_enterprise AND pmdddocno = g_pmdc_m.pmdcdocno
         AND pmdd900 = g_pmdc_m.pmdc900
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "pmdd_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_pmdc_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE apmt835_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_pmdd_d.clear() 
 
     
      CALL apmt835_ui_browser_refresh()  
      #CALL apmt835_ui_headershow()  
      #CALL apmt835_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL apmt835_browser_fill("")
         CALL apmt835_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE apmt835_cl
 
   #功能已完成,通報訊息中心
   CALL apmt835_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="apmt835.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION apmt835_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_success     LIKE type_t.num5
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_pmdd_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF apmt835_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT pmddseq,pmdd001,pmdd002,pmdd003,pmddsite,pmdd200,pmdd004,pmdd005, 
             pmdd033,pmdd037,pmdd260,pmdd038,pmdd227,pmdd201,pmdd202,pmdd212,pmdd007,pmdd006,pmdd253, 
             pmdd258,pmdd254,pmdd255,pmdd256,pmdd257,pmdd259,pmdd252,pmdd207,pmdd015,pmdd049,pmdd030, 
             pmdd048,pmdd208,pmdd209,pmdd206,pmdd210,pmdd211,pmdd205,pmdd203,pmdd204,pmdd032,pmdd901, 
             pmdd902,pmdd903 ,t1.ooefl003 ,t2.imaal003 ,t3.imaal004 ,t5.ooefl003 ,t6.ooefl003 ,t7.inayl003 , 
             t8.oocal003 ,t9.oocal003 ,t10.pmaal004 ,t11.oocql004 ,t12.staal003 ,t13.ooag011 ,t14.ooefl003 , 
             t15.ooefl003 ,t16.inayl003 ,t17.oocql004 FROM pmdd_t",   
                     " INNER JOIN pmdc_t ON pmdcent = " ||g_enterprise|| " AND pmdcdocno = pmdddocno ",
                     " AND pmdc900 = pmdd900 ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=pmddsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent="||g_enterprise||" AND t2.imaal001=pmdd004 AND t2.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t3 ON t3.imaalent="||g_enterprise||" AND t3.imaal001=pmdd004 AND t3.imaal002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=pmdd037 AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=pmdd260 AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t7 ON t7.inaylent="||g_enterprise||" AND t7.inayl001=pmdd038 AND t7.inayl002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t8 ON t8.oocalent="||g_enterprise||" AND t8.oocal001=pmdd201 AND t8.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t9 ON t9.oocalent="||g_enterprise||" AND t9.oocal001=pmdd007 AND t9.oocal002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t10 ON t10.pmaalent="||g_enterprise||" AND t10.pmaal001=pmdd015 AND t10.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t11 ON t11.oocqlent="||g_enterprise||" AND t11.oocql001='274' AND t11.oocql002=pmdd048 AND t11.oocql003='"||g_dlang||"' ",
               " LEFT JOIN staal_t t12 ON t12.staalent="||g_enterprise||" AND t12.staal001=pmdd209 AND t12.staal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t13 ON t13.ooagent="||g_enterprise||" AND t13.ooag001=pmdd206  ",
               " LEFT JOIN ooefl_t t14 ON t14.ooeflent="||g_enterprise||" AND t14.ooefl001=pmdd205 AND t14.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t15 ON t15.ooeflent="||g_enterprise||" AND t15.ooefl001=pmdd203 AND t15.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t16 ON t16.inaylent="||g_enterprise||" AND t16.inayl001=pmdd204 AND t16.inayl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t17 ON t17.oocqlent="||g_enterprise||" AND t17.oocql001='267' AND t17.oocql002=pmdd902 AND t17.oocql003='"||g_dlang||"' ",
 
                     " WHERE pmddent=? AND pmdddocno=? AND pmdd900=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY pmdd_t.pmddseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE apmt835_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR apmt835_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_pmdc_m.pmdcdocno,g_pmdc_m.pmdc900   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_pmdc_m.pmdcdocno,g_pmdc_m.pmdc900 INTO g_pmdd_d[l_ac].pmddseq, 
          g_pmdd_d[l_ac].pmdd001,g_pmdd_d[l_ac].pmdd002,g_pmdd_d[l_ac].pmdd003,g_pmdd_d[l_ac].pmddsite, 
          g_pmdd_d[l_ac].pmdd200,g_pmdd_d[l_ac].pmdd004,g_pmdd_d[l_ac].pmdd005,g_pmdd_d[l_ac].pmdd033, 
          g_pmdd_d[l_ac].pmdd037,g_pmdd_d[l_ac].pmdd260,g_pmdd_d[l_ac].pmdd038,g_pmdd_d[l_ac].pmdd227, 
          g_pmdd_d[l_ac].pmdd201,g_pmdd_d[l_ac].pmdd202,g_pmdd_d[l_ac].pmdd212,g_pmdd_d[l_ac].pmdd007, 
          g_pmdd_d[l_ac].pmdd006,g_pmdd_d[l_ac].pmdd253,g_pmdd_d[l_ac].pmdd258,g_pmdd_d[l_ac].pmdd254, 
          g_pmdd_d[l_ac].pmdd255,g_pmdd_d[l_ac].pmdd256,g_pmdd_d[l_ac].pmdd257,g_pmdd_d[l_ac].pmdd259, 
          g_pmdd_d[l_ac].pmdd252,g_pmdd_d[l_ac].pmdd207,g_pmdd_d[l_ac].pmdd015,g_pmdd_d[l_ac].pmdd049, 
          g_pmdd_d[l_ac].pmdd030,g_pmdd_d[l_ac].pmdd048,g_pmdd_d[l_ac].pmdd208,g_pmdd_d[l_ac].pmdd209, 
          g_pmdd_d[l_ac].pmdd206,g_pmdd_d[l_ac].pmdd210,g_pmdd_d[l_ac].pmdd211,g_pmdd_d[l_ac].pmdd205, 
          g_pmdd_d[l_ac].pmdd203,g_pmdd_d[l_ac].pmdd204,g_pmdd_d[l_ac].pmdd032,g_pmdd_d[l_ac].pmdd901, 
          g_pmdd_d[l_ac].pmdd902,g_pmdd_d[l_ac].pmdd903,g_pmdd_d[l_ac].pmddsite_desc,g_pmdd_d[l_ac].pmdd004_desc, 
          g_pmdd_d[l_ac].pmdd004_desc_desc,g_pmdd_d[l_ac].pmdd037_desc,g_pmdd_d[l_ac].pmdd260_desc,g_pmdd_d[l_ac].pmdd038_desc, 
          g_pmdd_d[l_ac].pmdd201_desc,g_pmdd_d[l_ac].pmdd007_desc,g_pmdd_d[l_ac].pmdd015_desc,g_pmdd_d[l_ac].pmdd048_desc, 
          g_pmdd_d[l_ac].pmdd209_desc,g_pmdd_d[l_ac].pmdd206_desc,g_pmdd_d[l_ac].pmdd205_desc,g_pmdd_d[l_ac].pmdd203_desc, 
          g_pmdd_d[l_ac].pmdd204_desc,g_pmdd_d[l_ac].pmdd902_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
          #品類編號
          CALL apmt835_get_imaa009(g_pmdd_d[l_ac].pmdd004) RETURNING g_pmdd_d[l_ac].imaa009
          DISPLAY BY NAME g_pmdd_d[l_ac].imaa009
          #品類說明
          CALL s_desc_get_rtaxl003_desc(g_pmdd_d[l_ac].imaa009) RETURNING g_pmdd_d[l_ac].imaa009_desc
          DISPLAY BY NAME g_pmdd_d[l_ac].imaa009_desc                  
          
          #變更類型
          IF g_pmdd_d[l_ac].pmdd901 = '3' THEN
             LET g_pmdd_d[l_ac].l_pmdb032 = 1
          ELSE
             #取要貨單單身行狀態
             CALL apmt835_get_pmdb032(g_pmdc_m.pmdcdocno,g_pmdd_d[l_ac].pmddseq) RETURNING g_pmdd_d[l_ac].l_pmdb032  #ken---add
          END IF
          #單身要貨明細頁籤文字的顏色顯示          
          CALL apmt835_detail_color(g_pmdd_d[l_ac].pmdd901)
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
   
   CALL g_pmdd_d.deleteElement(g_pmdd_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE apmt835_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_pmdd_d.getLength()
      LET g_pmdd_d_mask_o[l_ac].* =  g_pmdd_d[l_ac].*
      CALL apmt835_pmdd_t_mask()
      LET g_pmdd_d_mask_n[l_ac].* =  g_pmdd_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="apmt835.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION apmt835_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM pmdd_t
       WHERE pmddent = g_enterprise AND
         pmdddocno = ps_keys_bak[1] AND pmdd900 = ps_keys_bak[2] AND pmddseq = ps_keys_bak[3]
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
         CALL g_pmdd_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="apmt835.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION apmt835_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO pmdd_t
                  (pmddent,
                   pmdddocno,pmdd900,
                   pmddseq
                   ,pmdd001,pmdd002,pmdd003,pmddsite,pmdd200,pmdd004,pmdd005,pmdd033,pmdd037,pmdd260,pmdd038,pmdd227,pmdd201,pmdd202,pmdd212,pmdd007,pmdd006,pmdd253,pmdd258,pmdd254,pmdd255,pmdd256,pmdd257,pmdd259,pmdd252,pmdd207,pmdd015,pmdd049,pmdd030,pmdd048,pmdd208,pmdd209,pmdd206,pmdd210,pmdd211,pmdd205,pmdd203,pmdd204,pmdd032,pmdd901,pmdd902,pmdd903) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_pmdd_d[g_detail_idx].pmdd001,g_pmdd_d[g_detail_idx].pmdd002,g_pmdd_d[g_detail_idx].pmdd003, 
                       g_pmdd_d[g_detail_idx].pmddsite,g_pmdd_d[g_detail_idx].pmdd200,g_pmdd_d[g_detail_idx].pmdd004, 
                       g_pmdd_d[g_detail_idx].pmdd005,g_pmdd_d[g_detail_idx].pmdd033,g_pmdd_d[g_detail_idx].pmdd037, 
                       g_pmdd_d[g_detail_idx].pmdd260,g_pmdd_d[g_detail_idx].pmdd038,g_pmdd_d[g_detail_idx].pmdd227, 
                       g_pmdd_d[g_detail_idx].pmdd201,g_pmdd_d[g_detail_idx].pmdd202,g_pmdd_d[g_detail_idx].pmdd212, 
                       g_pmdd_d[g_detail_idx].pmdd007,g_pmdd_d[g_detail_idx].pmdd006,g_pmdd_d[g_detail_idx].pmdd253, 
                       g_pmdd_d[g_detail_idx].pmdd258,g_pmdd_d[g_detail_idx].pmdd254,g_pmdd_d[g_detail_idx].pmdd255, 
                       g_pmdd_d[g_detail_idx].pmdd256,g_pmdd_d[g_detail_idx].pmdd257,g_pmdd_d[g_detail_idx].pmdd259, 
                       g_pmdd_d[g_detail_idx].pmdd252,g_pmdd_d[g_detail_idx].pmdd207,g_pmdd_d[g_detail_idx].pmdd015, 
                       g_pmdd_d[g_detail_idx].pmdd049,g_pmdd_d[g_detail_idx].pmdd030,g_pmdd_d[g_detail_idx].pmdd048, 
                       g_pmdd_d[g_detail_idx].pmdd208,g_pmdd_d[g_detail_idx].pmdd209,g_pmdd_d[g_detail_idx].pmdd206, 
                       g_pmdd_d[g_detail_idx].pmdd210,g_pmdd_d[g_detail_idx].pmdd211,g_pmdd_d[g_detail_idx].pmdd205, 
                       g_pmdd_d[g_detail_idx].pmdd203,g_pmdd_d[g_detail_idx].pmdd204,g_pmdd_d[g_detail_idx].pmdd032, 
                       g_pmdd_d[g_detail_idx].pmdd901,g_pmdd_d[g_detail_idx].pmdd902,g_pmdd_d[g_detail_idx].pmdd903) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "pmdd_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_pmdd_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="apmt835.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION apmt835_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "pmdd_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL apmt835_pmdd_t_mask_restore('restore_mask_o')
               
      UPDATE pmdd_t 
         SET (pmdddocno,pmdd900,
              pmddseq
              ,pmdd001,pmdd002,pmdd003,pmddsite,pmdd200,pmdd004,pmdd005,pmdd033,pmdd037,pmdd260,pmdd038,pmdd227,pmdd201,pmdd202,pmdd212,pmdd007,pmdd006,pmdd253,pmdd258,pmdd254,pmdd255,pmdd256,pmdd257,pmdd259,pmdd252,pmdd207,pmdd015,pmdd049,pmdd030,pmdd048,pmdd208,pmdd209,pmdd206,pmdd210,pmdd211,pmdd205,pmdd203,pmdd204,pmdd032,pmdd901,pmdd902,pmdd903) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_pmdd_d[g_detail_idx].pmdd001,g_pmdd_d[g_detail_idx].pmdd002,g_pmdd_d[g_detail_idx].pmdd003, 
                  g_pmdd_d[g_detail_idx].pmddsite,g_pmdd_d[g_detail_idx].pmdd200,g_pmdd_d[g_detail_idx].pmdd004, 
                  g_pmdd_d[g_detail_idx].pmdd005,g_pmdd_d[g_detail_idx].pmdd033,g_pmdd_d[g_detail_idx].pmdd037, 
                  g_pmdd_d[g_detail_idx].pmdd260,g_pmdd_d[g_detail_idx].pmdd038,g_pmdd_d[g_detail_idx].pmdd227, 
                  g_pmdd_d[g_detail_idx].pmdd201,g_pmdd_d[g_detail_idx].pmdd202,g_pmdd_d[g_detail_idx].pmdd212, 
                  g_pmdd_d[g_detail_idx].pmdd007,g_pmdd_d[g_detail_idx].pmdd006,g_pmdd_d[g_detail_idx].pmdd253, 
                  g_pmdd_d[g_detail_idx].pmdd258,g_pmdd_d[g_detail_idx].pmdd254,g_pmdd_d[g_detail_idx].pmdd255, 
                  g_pmdd_d[g_detail_idx].pmdd256,g_pmdd_d[g_detail_idx].pmdd257,g_pmdd_d[g_detail_idx].pmdd259, 
                  g_pmdd_d[g_detail_idx].pmdd252,g_pmdd_d[g_detail_idx].pmdd207,g_pmdd_d[g_detail_idx].pmdd015, 
                  g_pmdd_d[g_detail_idx].pmdd049,g_pmdd_d[g_detail_idx].pmdd030,g_pmdd_d[g_detail_idx].pmdd048, 
                  g_pmdd_d[g_detail_idx].pmdd208,g_pmdd_d[g_detail_idx].pmdd209,g_pmdd_d[g_detail_idx].pmdd206, 
                  g_pmdd_d[g_detail_idx].pmdd210,g_pmdd_d[g_detail_idx].pmdd211,g_pmdd_d[g_detail_idx].pmdd205, 
                  g_pmdd_d[g_detail_idx].pmdd203,g_pmdd_d[g_detail_idx].pmdd204,g_pmdd_d[g_detail_idx].pmdd032, 
                  g_pmdd_d[g_detail_idx].pmdd901,g_pmdd_d[g_detail_idx].pmdd902,g_pmdd_d[g_detail_idx].pmdd903)  
 
         WHERE pmddent = g_enterprise AND pmdddocno = ps_keys_bak[1] AND pmdd900 = ps_keys_bak[2] AND pmddseq = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "pmdd_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "pmdd_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL apmt835_pmdd_t_mask_restore('restore_mask_n')
               
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
 
{<section id="apmt835.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION apmt835_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="apmt835.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION apmt835_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="apmt835.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION apmt835_lock_b(ps_table,ps_page)
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
   #CALL apmt835_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "pmdd_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN apmt835_bcl USING g_enterprise,
                                       g_pmdc_m.pmdcdocno,g_pmdc_m.pmdc900,g_pmdd_d[g_detail_idx].pmddseq  
                                               
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apmt835_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
 
   
 
   
   #add-point:lock_b段other name="lock_b.other"
   #150324-00006#14 2015/04/09 By pomelo add(S)
   LET ls_group = "pmdd_t1"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN apmt835_upd_pmdd033 USING g_enterprise,g_pmdc_m.pmdcdocno,g_pmdc_m.pmdc900,g_pmdd_d[g_detail_idx].pmddseq  
                                               
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apmt835_bcl" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
   #150324-00006#14 2015/04/09 By pomelo add(E)
   #end add-point  
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="apmt835.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION apmt835_unlock_b(ps_table,ps_page)
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
      CLOSE apmt835_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   #150324-00006#14 2015/04/09 By pomelo add(S)
   LET ls_group = "'1',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE apmt835_upd_pmdd033
   END IF
   #150324-00006#14 2015/04/09 By pomelo add(E)
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="apmt835.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION apmt835_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("pmdcdocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("pmdcdocno,pmdc900",TRUE)
      CALL cl_set_comp_entry("pmdcdocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("pmdcsite",TRUE)
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="apmt835.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION apmt835_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("pmdcdocno,pmdc900",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      CALL cl_set_comp_entry("pmdcsite",FALSE)
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("pmdcdocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("pmdcdocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("pmdc900",FALSE)
   END IF
   IF p_cmd = 'a' AND g_set_pmdcsite_entry THEN
      CALL cl_set_comp_entry("pmdcsite",FALSE)
   END IF
   IF NOT s_aooi500_comp_entry(g_prog,'pmdcsite') THEN
      CALL cl_set_comp_entry("pmdcsite",FALSE)
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="apmt835.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION apmt835_set_entry_b(p_cmd)
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
   IF cl_null(g_pmdc_m.pmdc206) THEN
      CALL cl_set_comp_entry("pmdd204",TRUE)
   END IF
   IF g_pmdd_d[l_ac].pmdd032 <> 'Y' THEN
      CALL cl_set_comp_entry("pmddseq,pmddsite,pmdd200,pmdd004,pmdd037,pmdd038,
                              pmdd202,pmdd212,pmdd006,pmdd007,pmdd030,pmdd048,
                              pmdd210,pmdd211,pmdd204,pmdd032,pmdd902",TRUE)
      CALL cl_set_comp_entry("pmdd212",TRUE)   #ken
      CALL cl_set_comp_entry("pmdd005",TRUE)   #產品特徵 ken                              
   END IF
   
   #150324-00006#14 2015/04/09 By pomelo add(S)
   IF g_action_choice = 'upd_pmdd033' THEN
      CALL cl_set_comp_entry("pmddseq",TRUE)     #項次
      CALL cl_set_comp_entry("pmddsite",TRUE)    #要貨組織
      CALL cl_set_comp_entry("pmdd200",TRUE)     #商品條碼
      CALL cl_set_comp_entry("pmdd004",TRUE)     #商品編號
      CALL cl_set_comp_entry("pmdd005",TRUE)     #產品特徵
      CALL cl_set_comp_entry("pmdd037",TRUE)     #收貨組織
      CALL cl_set_comp_entry("pmdd260",TRUE)     #收貨部門
      CALL cl_set_comp_entry("pmdd038",TRUE)     #庫位
      CALL cl_set_comp_entry("pmdd201",TRUE)     #包裝單位
      CALL cl_set_comp_entry("pmdd212",TRUE)     #包裝數量
      CALL cl_set_comp_entry("pmdd007",TRUE)     #要貨單位
      CALL cl_set_comp_entry("pmdd006",TRUE)     #要貨數量
      CALL cl_set_comp_entry("pmdd030",TRUE)     #需求數量
      CALL cl_set_comp_entry("pmdd048",TRUE)     #收貨時段
      CALL cl_set_comp_entry("pmdd206",TRUE)     #採購員
      CALL cl_set_comp_entry("pmdd210",TRUE)     #促銷開始日
      CALL cl_set_comp_entry("pmdd211",TRUE)     #促銷結束日
      CALL cl_set_comp_entry("pmdd204",TRUE)     #配送倉庫
      CALL cl_set_comp_entry("pmdd032",TRUE)     #單身結案
      CALL cl_set_comp_entry("pmdd902",TRUE)     #變更理由
      CALL cl_set_comp_entry("pmdd903",TRUE)     #變更備註
      CALL cl_set_comp_entry("pmdd033",TRUE)     #緊急度
   END IF
   #150324-00006#14 2015/04/09 By pomelo add(E)
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="apmt835.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION apmt835_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point    
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   DEFINE l_imaa005   LIKE inaa_t.inaa005 #ken---add 
   #end add-point    
   
   #add-point:Function前置處理  name="set_no_entry_b.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("",FALSE)
      #add-point:set_no_entry_b段欄位控制 name="set_no_entry_b.field_control"
      
      #end add-point 
   END IF 
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b"
   IF g_pmdd_d[l_ac].pmdd032 = 'Y' THEN
      CALL cl_set_comp_entry("pmddseq,pmdd001,pmdd002,pmdd003,pmddsite,pmdd200,pmdd004,pmdd037,pmdd260,pmdd038,
                              pmdd201,pmdd202,pmdd212,pmdd006,pmdd007,pmdd030,pmdd048,pmdd206,
                              pmdd210,pmdd211,pmdd204,pmdd032,pmdd902",FALSE)
      CALL cl_set_comp_entry("pmdd212",FALSE)
      CALL cl_set_comp_entry("pmdd005",FALSE)
   END IF
   #ken------------------------------------s
   IF NOT cl_null(g_pmdd_d[l_ac].pmdd006)  THEN
     CALL cl_set_comp_entry("pmdd212",FALSE)
   END IF
   IF NOT cl_null(g_pmdc_m.pmdc206) THEN
      CALL cl_set_comp_entry("pmdd204",FALSE)
   END IF   
   IF NOT cl_null(g_pmdc_m.pmdc203)  THEN
     CALL cl_set_comp_entry("pmddsite",FALSE)
   END IF
   #ken------------------------------------e 
   #ken---add---s
   #料件不使用產品特徵時，產品特徵欄位不可錄入
   LET l_imaa005 = ''
   CALL apmt835_get_imaa005(g_pmdd_d[l_ac].pmdd004) RETURNING l_imaa005
   IF cl_null(l_imaa005) THEN
      CALL cl_set_comp_entry("pmdd005",FALSE)
      LET g_pmdd_d[l_ac].pmdd005 = ' '
   ELSE
      IF cl_null(g_pmdd_d[l_ac].pmdd005) THEN
         LET g_pmdd_d[l_ac].pmdd005 = ''
      END IF
   END IF
   #ken---add---e
   #150324-00006#14 2015/04/09 By pomelo add(S)
   IF g_action_choice = 'upd_pmdd033' THEN
      CALL cl_set_comp_entry("pmddseq",FALSE)     #項次
      CALL cl_set_comp_entry("pmddsite",FALSE)    #要貨組織
      CALL cl_set_comp_entry("pmdd200",FALSE)     #商品條碼
      CALL cl_set_comp_entry("pmdd004",FALSE)     #商品編號
      CALL cl_set_comp_entry("pmdd005",FALSE)     #產品特徵
      CALL cl_set_comp_entry("pmdd037",FALSE)     #收貨組織
      CALL cl_set_comp_entry("pmdd260",FALSE)     #收貨部門
      CALL cl_set_comp_entry("pmdd038",FALSE)     #庫位
      CALL cl_set_comp_entry("pmdd201",FALSE)     #包裝單位
      CALL cl_set_comp_entry("pmdd212",FALSE)     #包裝數量
      CALL cl_set_comp_entry("pmdd007",FALSE)     #要貨單位
      CALL cl_set_comp_entry("pmdd006",FALSE)     #要貨數量
      CALL cl_set_comp_entry("pmdd030",FALSE)     #需求數量
      CALL cl_set_comp_entry("pmdd048",FALSE)     #收貨時段
      CALL cl_set_comp_entry("pmdd206",FALSE)     #採購員
      CALL cl_set_comp_entry("pmdd210",FALSE)     #促銷開始日
      CALL cl_set_comp_entry("pmdd211",FALSE)     #促銷結束日
      CALL cl_set_comp_entry("pmdd204",FALSE)     #配送倉庫
      CALL cl_set_comp_entry("pmdd032",FALSE)     #單身結案
      CALL cl_set_comp_entry("pmdd902",FALSE)     #變更理由
      CALL cl_set_comp_entry("pmdd903",FALSE)     #變更備註
   ELSE
      CALL cl_set_comp_entry("pmdd033",FALSE)     #緊急度
   END IF
   #150324-00006#14 2015/04/09 By pomelo add(E)
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="apmt835.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION apmt835_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   CALL cl_set_act_visible("reproduce", TRUE)
   CALL cl_set_act_visible("upd_pmdd033",TRUE)  #150324-00006#14 2015/04/09 By pomelo add
   CALL apmt835_set_act_visible_b()   #150416-00001#1 150818 by sakura add
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="apmt835.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION apmt835_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   #150324-00006#14 2015/04/09 By pomelo add(S)
   DEFINE l_cnt          LIKE type_t.num5
   DEFINE l_pmdb032      LIKE pmdb_t.pmdb032
   #150324-00006#14 2015/04/09 By pomelo add(E)
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_pmdc_m.pmdcstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   CALL cl_set_act_visible("reproduce", FALSE)
   
   LET l_cnt = 0
   SELECT COUNT(pmddseq) INTO l_cnt
     FROM pmdd_t
    WHERE pmddent = g_enterprise
      AND pmdddocno = g_pmdc_m.pmdcdocno 
      AND pmdd900 = g_pmdc_m.pmdc900
      AND COALESCE(pmdd032,'N') = 'N'
      
   IF l_cnt = 0 OR g_pmdc_m.pmdcstus != 'N' OR g_pmdc_m.pmdcacti = 'Y' THEN
      CALL cl_set_act_visible("upd_pmdd033",FALSE)
   END IF
   CALL apmt835_set_act_no_visible_b()   #150416-00001#1 150818 by sakura add
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="apmt835.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION apmt835_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
 
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   CALL cl_set_act_visible("detail_qrystr",TRUE)   #150416-00001#1 150818 by sakura add
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="apmt835.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION apmt835_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   DEFINE l_cnt          LIKE type_t.num5   #150416-00001#1 150818 by sakura add
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   #150416-00001#1 150818 by sakura add(S)
   LET l_cnt = 0
   SELECT COUNT(pmdd001) INTO l_cnt
     FROM pmdd_t
    WHERE pmddent = g_enterprise
      AND pmdddocno = g_pmdc_m.pmdcdocno
   IF l_cnt = 0 THEN
      CALL cl_set_act_visible("detail_qrystr",FALSE)
   END IF
   #150416-00001#1 150818 by sakura add(E)
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="apmt835.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION apmt835_default_search()
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
      LET ls_wc = ls_wc, " pmdcdocno = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " pmdc900 = '", g_argv[02], "' AND "
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
               WHEN la_wc[li_idx].tableid = "pmdc_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "pmdd_t" 
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
 
{<section id="apmt835.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION apmt835_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success   LIKE type_t.num5
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_pmdc_m.pmdcdocno IS NULL
      OR g_pmdc_m.pmdc900 IS NULL
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN apmt835_cl USING g_enterprise,g_pmdc_m.pmdcdocno,g_pmdc_m.pmdc900
   IF STATUS THEN
      CLOSE apmt835_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apmt835_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE apmt835_master_referesh USING g_pmdc_m.pmdcdocno,g_pmdc_m.pmdc900 INTO g_pmdc_m.pmdcsite, 
       g_pmdc_m.pmdc902,g_pmdc_m.pmdcdocno,g_pmdc_m.pmdc900,g_pmdc_m.pmdc001,g_pmdc_m.pmdc002,g_pmdc_m.pmdc003, 
       g_pmdc_m.pmdcstus,g_pmdc_m.pmdcacti,g_pmdc_m.pmdc200,g_pmdc_m.pmdc202,g_pmdc_m.pmdc201,g_pmdc_m.pmdc203, 
       g_pmdc_m.pmdc207,g_pmdc_m.pmdc204,g_pmdc_m.pmdc205,g_pmdc_m.pmdc206,g_pmdc_m.pmdc021,g_pmdc_m.pmdc208, 
       g_pmdc_m.pmdc022,g_pmdc_m.pmdc905,g_pmdc_m.pmdc901,g_pmdc_m.pmdc906,g_pmdc_m.pmdcdocdt,g_pmdc_m.pmdcownid, 
       g_pmdc_m.pmdcowndp,g_pmdc_m.pmdccrtid,g_pmdc_m.pmdccrtdp,g_pmdc_m.pmdccrtdt,g_pmdc_m.pmdcmodid, 
       g_pmdc_m.pmdcmoddt,g_pmdc_m.pmdccnfid,g_pmdc_m.pmdccnfdt,g_pmdc_m.pmdcsite_desc,g_pmdc_m.pmdc002_desc, 
       g_pmdc_m.pmdc003_desc,g_pmdc_m.pmdc202_desc,g_pmdc_m.pmdc203_desc,g_pmdc_m.pmdc204_desc,g_pmdc_m.pmdc205_desc, 
       g_pmdc_m.pmdc206_desc,g_pmdc_m.pmdc021_desc,g_pmdc_m.pmdc905_desc,g_pmdc_m.pmdcownid_desc,g_pmdc_m.pmdcowndp_desc, 
       g_pmdc_m.pmdccrtid_desc,g_pmdc_m.pmdccrtdp_desc,g_pmdc_m.pmdcmodid_desc,g_pmdc_m.pmdccnfid_desc 
 
   
 
   #檢查是否允許此動作
   IF NOT apmt835_action_chk() THEN
      CLOSE apmt835_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_pmdc_m.pmdcsite,g_pmdc_m.pmdcsite_desc,g_pmdc_m.pmdc902,g_pmdc_m.pmdcdocno,g_pmdc_m.pmdc900, 
       g_pmdc_m.pmdc001,g_pmdc_m.pmdc002,g_pmdc_m.pmdc002_desc,g_pmdc_m.pmdc003,g_pmdc_m.pmdc003_desc, 
       g_pmdc_m.pmdcstus,g_pmdc_m.pmdcacti,g_pmdc_m.pmdc200,g_pmdc_m.pmdc202,g_pmdc_m.pmdc202_desc,g_pmdc_m.pmdc201, 
       g_pmdc_m.pmdc203,g_pmdc_m.pmdc203_desc,g_pmdc_m.pmdc207,g_pmdc_m.pmdc204,g_pmdc_m.pmdc204_desc, 
       g_pmdc_m.pmdc205,g_pmdc_m.pmdc205_desc,g_pmdc_m.pmdc206,g_pmdc_m.pmdc206_desc,g_pmdc_m.pmdc021, 
       g_pmdc_m.pmdc021_desc,g_pmdc_m.pmdc208,g_pmdc_m.pmdc022,g_pmdc_m.pmdc905,g_pmdc_m.pmdc905_desc, 
       g_pmdc_m.pmdc901,g_pmdc_m.pmdc906,g_pmdc_m.pmdcdocdt,g_pmdc_m.pmdcownid,g_pmdc_m.pmdcownid_desc, 
       g_pmdc_m.pmdcowndp,g_pmdc_m.pmdcowndp_desc,g_pmdc_m.pmdccrtid,g_pmdc_m.pmdccrtid_desc,g_pmdc_m.pmdccrtdp, 
       g_pmdc_m.pmdccrtdp_desc,g_pmdc_m.pmdccrtdt,g_pmdc_m.pmdcmodid,g_pmdc_m.pmdcmodid_desc,g_pmdc_m.pmdcmoddt, 
       g_pmdc_m.pmdccnfid,g_pmdc_m.pmdccnfid_desc,g_pmdc_m.pmdccnfdt
 
   CASE g_pmdc_m.pmdcstus
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
         CASE g_pmdc_m.pmdcstus
            
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
         CALL cl_set_act_visible("signing,withdraw",FALSE)
         CASE g_pmdc_m.pmdcstus  
            WHEN "N"
               CALL cl_set_act_visible("unconfirmed,hold",FALSE)
               #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
               IF cl_bpm_chk() THEN
                  CALL cl_set_act_visible("signing",TRUE)
                  CALL cl_set_act_visible("confirmed",FALSE)
               END IF
            WHEN "R"    #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
               CALL cl_set_act_visible("confirmed,unconfirmed,hold",FALSE)
            WHEN "D"    #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
               CALL cl_set_act_visible("confirmed,unconfirmed,hold",FALSE)
            WHEN "X"
               HIDE OPTION "unconfirmed"
               HIDE OPTION "confirmed"
               CALL s_transaction_end('N','0')   #160816-00068#15 add
               RETURN
            WHEN "Y"
               HIDE OPTION "unconfirmed"
               HIDE OPTION "invalid"
               CALL s_transaction_end('N','0')   #160816-00068#15 add
               RETURN
            WHEN "W"    #只能顯示抽單;其餘應用功能皆隱藏
               CALL cl_set_act_visible("withdraw",TRUE)
               CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold",FALSE)
            WHEN "A"    #只能顯示確認; 其餘應用功能皆隱藏
               CALL cl_set_act_visible("confirmed",TRUE)
               CALL cl_set_act_visible("unconfirmed,invalid,hold",FALSE)
         END CASE
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT apmt835_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE apmt835_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT apmt835_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE apmt835_cl
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
      g_pmdc_m.pmdcstus = lc_state OR cl_null(lc_state) THEN
      CLOSE apmt835_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   CALL s_transaction_begin()
   #確認
   IF lc_state = 'Y' THEN
      CALL s_apmt835_conf_chk(g_pmdc_m.pmdcdocno,g_pmdc_m.pmdc900) RETURNING l_success
      IF NOT l_success THEN
         CALL s_transaction_end('N','0')   #160816-00068#15 add
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00108') THEN
            CALL s_transaction_end('N','0')   #160816-00068#15 add
            RETURN
         ELSE
            CALL s_apmt835_conf_upd(g_pmdc_m.pmdcdocno,g_pmdc_m.pmdc900) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
         END IF
      END IF
   END IF
   #作廢
   IF lc_state = 'X' THEN
      CALL s_apmt835_invalid_chk(g_pmdc_m.pmdcdocno,g_pmdc_m.pmdc900) RETURNING l_success
      IF NOT l_success THEN
         CALL s_transaction_end('N','0')   #160816-00068#15 add
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00109') THEN
            CALL s_transaction_end('N','0')   #160816-00068#15 add
            RETURN
         ELSE
            CALL s_apmt835_invalid_upd(g_pmdc_m.pmdcdocno,g_pmdc_m.pmdc900) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
         END IF
      END IF
   END IF   
   #end add-point
   
   LET g_pmdc_m.pmdcmodid = g_user
   LET g_pmdc_m.pmdcmoddt = cl_get_current()
   LET g_pmdc_m.pmdcstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE pmdc_t 
      SET (pmdcstus,pmdcmodid,pmdcmoddt) 
        = (g_pmdc_m.pmdcstus,g_pmdc_m.pmdcmodid,g_pmdc_m.pmdcmoddt)     
    WHERE pmdcent = g_enterprise AND pmdcdocno = g_pmdc_m.pmdcdocno
      AND pmdc900 = g_pmdc_m.pmdc900
    
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
      EXECUTE apmt835_master_referesh USING g_pmdc_m.pmdcdocno,g_pmdc_m.pmdc900 INTO g_pmdc_m.pmdcsite, 
          g_pmdc_m.pmdc902,g_pmdc_m.pmdcdocno,g_pmdc_m.pmdc900,g_pmdc_m.pmdc001,g_pmdc_m.pmdc002,g_pmdc_m.pmdc003, 
          g_pmdc_m.pmdcstus,g_pmdc_m.pmdcacti,g_pmdc_m.pmdc200,g_pmdc_m.pmdc202,g_pmdc_m.pmdc201,g_pmdc_m.pmdc203, 
          g_pmdc_m.pmdc207,g_pmdc_m.pmdc204,g_pmdc_m.pmdc205,g_pmdc_m.pmdc206,g_pmdc_m.pmdc021,g_pmdc_m.pmdc208, 
          g_pmdc_m.pmdc022,g_pmdc_m.pmdc905,g_pmdc_m.pmdc901,g_pmdc_m.pmdc906,g_pmdc_m.pmdcdocdt,g_pmdc_m.pmdcownid, 
          g_pmdc_m.pmdcowndp,g_pmdc_m.pmdccrtid,g_pmdc_m.pmdccrtdp,g_pmdc_m.pmdccrtdt,g_pmdc_m.pmdcmodid, 
          g_pmdc_m.pmdcmoddt,g_pmdc_m.pmdccnfid,g_pmdc_m.pmdccnfdt,g_pmdc_m.pmdcsite_desc,g_pmdc_m.pmdc002_desc, 
          g_pmdc_m.pmdc003_desc,g_pmdc_m.pmdc202_desc,g_pmdc_m.pmdc203_desc,g_pmdc_m.pmdc204_desc,g_pmdc_m.pmdc205_desc, 
          g_pmdc_m.pmdc206_desc,g_pmdc_m.pmdc021_desc,g_pmdc_m.pmdc905_desc,g_pmdc_m.pmdcownid_desc, 
          g_pmdc_m.pmdcowndp_desc,g_pmdc_m.pmdccrtid_desc,g_pmdc_m.pmdccrtdp_desc,g_pmdc_m.pmdcmodid_desc, 
          g_pmdc_m.pmdccnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_pmdc_m.pmdcsite,g_pmdc_m.pmdcsite_desc,g_pmdc_m.pmdc902,g_pmdc_m.pmdcdocno,g_pmdc_m.pmdc900, 
          g_pmdc_m.pmdc001,g_pmdc_m.pmdc002,g_pmdc_m.pmdc002_desc,g_pmdc_m.pmdc003,g_pmdc_m.pmdc003_desc, 
          g_pmdc_m.pmdcstus,g_pmdc_m.pmdcacti,g_pmdc_m.pmdc200,g_pmdc_m.pmdc202,g_pmdc_m.pmdc202_desc, 
          g_pmdc_m.pmdc201,g_pmdc_m.pmdc203,g_pmdc_m.pmdc203_desc,g_pmdc_m.pmdc207,g_pmdc_m.pmdc204, 
          g_pmdc_m.pmdc204_desc,g_pmdc_m.pmdc205,g_pmdc_m.pmdc205_desc,g_pmdc_m.pmdc206,g_pmdc_m.pmdc206_desc, 
          g_pmdc_m.pmdc021,g_pmdc_m.pmdc021_desc,g_pmdc_m.pmdc208,g_pmdc_m.pmdc022,g_pmdc_m.pmdc905, 
          g_pmdc_m.pmdc905_desc,g_pmdc_m.pmdc901,g_pmdc_m.pmdc906,g_pmdc_m.pmdcdocdt,g_pmdc_m.pmdcownid, 
          g_pmdc_m.pmdcownid_desc,g_pmdc_m.pmdcowndp,g_pmdc_m.pmdcowndp_desc,g_pmdc_m.pmdccrtid,g_pmdc_m.pmdccrtid_desc, 
          g_pmdc_m.pmdccrtdp,g_pmdc_m.pmdccrtdp_desc,g_pmdc_m.pmdccrtdt,g_pmdc_m.pmdcmodid,g_pmdc_m.pmdcmodid_desc, 
          g_pmdc_m.pmdcmoddt,g_pmdc_m.pmdccnfid,g_pmdc_m.pmdccnfid_desc,g_pmdc_m.pmdccnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE apmt835_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL apmt835_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apmt835.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION apmt835_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_pmdd_d.getLength() THEN
         LET g_detail_idx = g_pmdd_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_pmdd_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_pmdd_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="apmt835.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION apmt835_b_fill2(pi_idx)
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
   
   CALL apmt835_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="apmt835.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION apmt835_fill_chk(ps_idx)
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
 
{<section id="apmt835.status_show" >}
PRIVATE FUNCTION apmt835_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apmt835.mask_functions" >}
&include "erp/apm/apmt835_mask.4gl"
 
{</section>}
 
{<section id="apmt835.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION apmt835_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   DEFINE l_success LIKE type_t.chr2
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL apmt835_show()
   CALL apmt835_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   CALL s_apmt835_conf_chk(g_pmdc_m.pmdcdocno,g_pmdc_m.pmdc900) RETURNING l_success
   IF NOT l_success THEN
      CLOSE apmt835_cl
      CALL s_transaction_end('N','0')
      RETURN FALSE
   END IF
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_pmdc_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_pmdd_d))
 
 
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
   #CALL apmt835_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL apmt835_ui_headershow()
   CALL apmt835_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION apmt835_draw_out()
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
   CALL apmt835_ui_headershow()  
   CALL apmt835_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="apmt835.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION apmt835_set_pk_array()
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
   LET g_pk_array[1].values = g_pmdc_m.pmdcdocno
   LET g_pk_array[1].column = 'pmdcdocno'
   LET g_pk_array[2].values = g_pmdc_m.pmdc900
   LET g_pk_array[2].column = 'pmdc900'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apmt835.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="apmt835.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION apmt835_msgcentre_notify(lc_state)
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
   CALL apmt835_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_pmdc_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apmt835.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION apmt835_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#28 add-S
   SELECT pmdcstus  INTO g_pmdc_m.pmdcstus
     FROM pmdc_t
    WHERE pmdcent = g_enterprise
      AND pmdcdocno = g_pmdc_m.pmdcdocno
      AND pmdc900 = g_pmdc_m.pmdc900
      

  IF(g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_pmdc_m.pmdcstus
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
        LET g_errparam.extend = g_pmdc_m.pmdcdocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL apmt835_set_act_visible()
        CALL apmt835_set_act_no_visible()
        CALL apmt835_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#28 add-E
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="apmt835.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 要貨單號檢查
# Memo...........: 檢查是否可填變更單
# Usage..........: CALL apmt835_pmdcdocno_chk(p_pmdcdocno)
#                  RETURNING r_success
# Input parameter: p_pmdcdocno   要貨單號
# Return code....: r_success     TRUE(FALSE) 
# Date & Author..: 2015/03/13 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt835_pmdcdocno_chk(p_pmdcdocno)
DEFINE p_pmdcdocno    LIKE pmdc_t.pmdcdocno
DEFINE l_n            LIKE type_t.num5
DEFINE r_success      LIKE type_t.num5
DEFINE l_pmdasite     LIKE pmda_t.pmdasite

       LET r_success = TRUE
       
       IF NOT cl_null(p_pmdcdocno) THEN 
          #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
          INITIALIZE g_chkparam.* TO NULL
          
          #設定g_chkparam.*的參數
          LET g_chkparam.arg1 = p_pmdcdocno
             
          #呼叫檢查存在並帶值的library
          #輸入的請購單號需存在[T:請購單單頭當]中，且單據狀態為(Y:已確認)，且不能結案
          IF NOT cl_chk_exist("v_pmdadocno_01") THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
       
          #同一張請購單不能同時有兩張以上未確認的變更單存在
          LET l_n = 0
          SELECT COUNT(pmdcdocno) INTO l_n FROM pmdc_t WHERE pmdcent = g_enterprise AND pmdcdocno = p_pmdcdocno AND pmdcstus = 'N'
          IF l_n > 0 THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'apm-00395'
             LET g_errparam.extend = p_pmdcdocno
             LET g_errparam.popup = TRUE
             CALL cl_err()

             LET r_success = FALSE
             RETURN r_success
          END IF
          #要貨單單的組織要跟要貨組織一致
          SELECT pmdasite INTO l_pmdasite FROM pmda_t
           WHERE pmdaent = g_enterprise AND pmdadocno = p_pmdcdocno
          IF l_pmdasite <> g_pmdc_m.pmdcsite THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'apm-00804'
             LET g_errparam.extend = p_pmdcdocno
             LET g_errparam.popup = TRUE
             CALL cl_err()

             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF
       #150504-00025#1 150506 by sakura add---STR
       #已轉採購單則不能新增要貨變更單
       LET l_n = 0
       SELECT COUNT(pmdldocno) INTO l_n
         FROM pmdl_t,pmdn_t,pmdp_t,pmdb_t
        WHERE pmdlent = pmdnent
           AND pmdldocno = pmdndocno
           AND pmdnent = pmdpent
           AND pmdndocno = pmdpdocno
           AND pmdnseq = pmdpseq
           AND pmdlent = g_enterprise
           AND pmdlstus != 'X'
           AND pmdpent = pmdbent
           AND pmdp003 = pmdbdocno
           AND pmdp004 = pmdbseq
           AND pmdbdocno = p_pmdcdocno
       IF l_n > 0 THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = 'apm-00897'
          LET g_errparam.extend = p_pmdcdocno
          LET g_errparam.popup = TRUE
          CALL cl_err()

          LET r_success = FALSE
          RETURN r_success
       END IF           
       #150504-00025#1 150506 by sakura add---END       
       RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 根據單號帶出請購單的值(單頭)
# Memo...........:
# Usage..........: CALL apmt835_pmdcdocno_other()
#                  RETURNING r_success
# Input parameter: 無
# Return code....: r_success TRUE(FALSE)
# Date & Author..: 2015/03/13 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt835_pmdcdocno_other()
DEFINE l_n       LIKE type_t.num5
DEFINE r_success  LIKE type_t.num5

    LET r_success = TRUE
    
    #版本 = 目前[T:請購單單頭檔].[C:版本]加1
    SELECT NVL(MAX(pmda001)+1,1) INTO g_pmdc_m.pmdc001 FROM pmda_t WHERE pmdaent = g_enterprise AND pmdadocno = g_pmdc_m.pmdcdocno
    
    #[C:變更序] = [T:請購變更單單頭檔].[C:變更序]在加1
    SELECT NVL(MAX(pmdc900)+1,1) INTO g_pmdc_m.pmdc900 FROM pmdc_t WHERE pmdcent = g_enterprise AND pmdcdocno = g_pmdc_m.pmdcdocno
    IF cl_null(g_pmdc_m.pmdc900) OR g_pmdc_m.pmdc900 = 0 THEN
       LET g_pmdc_m.pmdc900 = 1
    END IF
    
    #帶出請購單單頭值
    LET g_pmdc_m.pmdcdocdt = ''
    LET g_pmdc_m.pmdc002 = ''
    LET g_pmdc_m.pmdc003 = ''
    LET g_pmdc_m.pmdc200 = ''
    LET g_pmdc_m.pmdc202 = ''
    LET g_pmdc_m.pmdc201 = ''
    LET g_pmdc_m.pmdc203 = ''
    LET g_pmdc_m.pmdc207 = ''
    LET g_pmdc_m.pmdc204 = ''
    LET g_pmdc_m.pmdc205 = ''
    LET g_pmdc_m.pmdc206 = ''
    LET g_pmdc_m.pmdc021 = ''
    LET g_pmdc_m.pmdc208 = ''
    LET g_pmdc_m.pmdc022 = ''
    
   
    
    SELECT UNIQUE pmdadocdt,pmda002,pmda003,pmda200,pmda202,
                  pmda201,pmda203,pmda207,pmda204,pmda205,
                  pmda206,pmda021,pmda208,pmda022
      INTO g_pmdc_m.pmdcdocdt,g_pmdc_m.pmdc002,g_pmdc_m.pmdc003,g_pmdc_m.pmdc200,g_pmdc_m.pmdc202,
           g_pmdc_m.pmdc201,g_pmdc_m.pmdc203,g_pmdc_m.pmdc207,g_pmdc_m.pmdc204,g_pmdc_m.pmdc205,
           g_pmdc_m.pmdc206,g_pmdc_m.pmdc021,g_pmdc_m.pmdc208,g_pmdc_m.pmdc022
    FROM pmda_t
    WHERE pmdaent = g_enterprise AND pmdadocno = g_pmdc_m.pmdcdocno
    
    DISPLAY BY NAME g_pmdc_m.pmdcdocdt,g_pmdc_m.pmdc002,g_pmdc_m.pmdc003,g_pmdc_m.pmdc200,
                    g_pmdc_m.pmdc202,g_pmdc_m.pmdc201,g_pmdc_m.pmdc203,g_pmdc_m.pmdc207,
                    g_pmdc_m.pmdc204,g_pmdc_m.pmdc205,g_pmdc_m.pmdc206,g_pmdc_m.pmdc021,
                    g_pmdc_m.pmdc208,g_pmdc_m.pmdc022     
    
     INSERT INTO pmdc_t (pmdcent,pmdcsite,pmdcdocdt,pmdc901,pmdcdocno,
                         pmdc900,pmdc902,pmdc002,pmdc001,pmdc003,
                         pmdcstus,pmdcacti,pmdc200,pmdc202,pmdc201,
                         pmdc203,pmdc207,pmdc204,pmdc205,pmdc206,
                         pmdc021,pmdc208,pmdc022,pmdc905,pmdc906,
                         pmdcownid,pmdcowndp,pmdccrtid,pmdccrtdp,pmdccrtdt,
                         pmdcmodid,pmdcmoddt,pmdccnfid,pmdccnfdt)
         VALUES (g_enterprise,g_pmdc_m.pmdcsite,g_pmdc_m.pmdcdocdt,g_pmdc_m.pmdc901,g_pmdc_m.pmdcdocno,
         g_pmdc_m.pmdc900,g_pmdc_m.pmdc902,g_pmdc_m.pmdc002,g_pmdc_m.pmdc001,g_pmdc_m.pmdc003,
         g_pmdc_m.pmdcstus,g_pmdc_m.pmdcacti,g_pmdc_m.pmdc200,g_pmdc_m.pmdc202,g_pmdc_m.pmdc201,
         g_pmdc_m.pmdc203,g_pmdc_m.pmdc207,g_pmdc_m.pmdc204,g_pmdc_m.pmdc205,g_pmdc_m.pmdc206,
         g_pmdc_m.pmdc021,g_pmdc_m.pmdc208,g_pmdc_m.pmdc022,g_pmdc_m.pmdc905,g_pmdc_m.pmdc906,
         g_pmdc_m.pmdcownid,g_pmdc_m.pmdcowndp,g_pmdc_m.pmdccrtid,g_pmdc_m.pmdccrtdp,g_pmdc_m.pmdccrtdt,
         g_pmdc_m.pmdcmodid,g_pmdc_m.pmdcmoddt,g_pmdc_m.pmdccnfid,g_pmdc_m.pmdccnfdt) # DISK WRITE
                  
    IF SQLCA.sqlcode THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = SQLCA.sqlcode
       LET g_errparam.extend = "g_pmdc_m"
       LET g_errparam.popup = TRUE
       CALL cl_err()
  
       LET r_success = FALSE
       RETURN r_success
    END IF
    RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 根據單號帶出請購單的值(單身)
# Memo...........:
# Usage..........: CALL apmt835_pmdcdocno_pmdd()
#                  RETURNING r_success
# Input parameter: 無
# Return code....: r_success   成功/失敗
# Date & Author..: 2015/03/13 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt835_pmdcdocno_pmdd()
DEFINE l_sql      STRING
DEFINE l_pmdb032  LIKE type_t.num5
DEFINE r_success  LIKE type_t.num5

       LET r_success = TRUE

       LET l_sql = "SELECT  UNIQUE pmdbseq,pmdb001,pmdb002,pmdbsite,pmdb200,pmdb004,pmdb037,pmdb260,pmdb038,",
                   #"pmdb201,pmdb202,pmdb006,pmdb007,pmdb207,pmdb015,pmdb049,pmdb030,pmdb048,pmdb208,pmdb209,pmdb206,",
                   "pmdb201,pmdb202,pmdb212,pmdb006,pmdb007,pmdb207,pmdb015,pmdb049,pmdb030,pmdb048,pmdb208,pmdb209,pmdb206,", #ken---add pmdb212
                   "pmdb210,pmdb211,pmdb205,pmdb203,pmdb204,pmdb032",
       #ken---add---s 需求單號：141224-00013 項次：7
                   ",pmdb252,pmdb253,pmdb254,pmdb255,pmdb256,pmdb257,pmdb258,pmdb259", #現有庫存,入庫在途量,前一週銷量,前二週銷量,前三週銷量,前四周銷量,要貨在途量,周平均銷量
       #ken---add---e                        
       #ken---add---s 需求單號： 項次：
                   ",pmdb005,",   #產品特徵
       #ken---add---e
                   " pmdb033,",    #緊急度   150324-00006#14 2015/04/09 By pomelo add
                   " pmdb227",    #補貨規格說明  #150710-00016#4 Add By Ken 150713
                   " FROM pmdb_t",                                                     
                   " INNER JOIN pmda_t ON pmdadocno = pmdbdocno ",
                   " WHERE pmdbent='",g_enterprise,"' AND pmdbdocno='",g_pmdc_m.pmdcdocno,"' ",
	 	          " ORDER BY pmdb_t.pmdbseq"
 
       PREPARE apmt835_pmdb_pb FROM l_sql
       DECLARE apmt835_pmdb_cs CURSOR FOR apmt835_pmdb_pb
 
       LET l_ac = 1
       
       INITIALIZE g_pmdd_d[l_ac].* TO NULL
       LET l_pmdb032 = ''  
 
       FOREACH apmt835_pmdb_cs INTO g_pmdd_d[l_ac].pmddseq,g_pmdd_d[l_ac].pmdd001,g_pmdd_d[l_ac].pmdd002,
                                    g_pmdd_d[l_ac].pmddsite,g_pmdd_d[l_ac].pmdd200,g_pmdd_d[l_ac].pmdd004,
                                    g_pmdd_d[l_ac].pmdd037,g_pmdd_d[l_ac].pmdd260,g_pmdd_d[l_ac].pmdd038,g_pmdd_d[l_ac].pmdd201,
                                    #g_pmdd_d[l_ac].pmdd202,g_pmdd_d[l_ac].pmdd006,g_pmdd_d[l_ac].pmdd007,
                                    g_pmdd_d[l_ac].pmdd202,g_pmdd_d[l_ac].pmdd212,g_pmdd_d[l_ac].pmdd006,g_pmdd_d[l_ac].pmdd007, #ken---add g_pmdd_d[l_ac].pmdd212,
                                    g_pmdd_d[l_ac].pmdd207,g_pmdd_d[l_ac].pmdd015,g_pmdd_d[l_ac].pmdd049,
                                    g_pmdd_d[l_ac].pmdd030,g_pmdd_d[l_ac].pmdd048,g_pmdd_d[l_ac].pmdd208,
                                    g_pmdd_d[l_ac].pmdd209,g_pmdd_d[l_ac].pmdd206,g_pmdd_d[l_ac].pmdd210,
                                    g_pmdd_d[l_ac].pmdd211,g_pmdd_d[l_ac].pmdd205,g_pmdd_d[l_ac].pmdd203,
                                    g_pmdd_d[l_ac].pmdd204,l_pmdb032
                                    #ken---add---s 需求單號：141224-00013 項次：7
                                    ,g_pmdd_d[l_ac].pmdd252,g_pmdd_d[l_ac].pmdd253,g_pmdd_d[l_ac].pmdd254 #現有庫存,入庫在途量,前一週銷量
                                    ,g_pmdd_d[l_ac].pmdd255,g_pmdd_d[l_ac].pmdd256,g_pmdd_d[l_ac].pmdd257 #前二週銷量,前三週銷量,前四周銷量
                                    ,g_pmdd_d[l_ac].pmdd258,g_pmdd_d[l_ac].pmdd259                        #要貨在途量,周平均銷量
                                    #ken---add---e
                                    #ken---add---s 需求單號： 項次：
                                    ,g_pmdd_d[l_ac].pmdd005,
                                    #ken---add---e
                                    g_pmdd_d[l_ac].pmdd033,     #150324-00006#14 2015/04/09 By pomelo add
                                    g_pmdd_d[l_ac].pmdd227 #補貨規格說明  #150710-00016#4 Add By Ken 150713
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = "FOREACH:"
             LET g_errparam.popup = TRUE
             CALL cl_err()

             EXIT FOREACH
          END IF
 
	      #LET g_pmdd_d[l_ac].pmddsite = g_site
          LET g_pmdd_d[l_ac].pmdd901 = '1'   #單身變更類型   
          LET g_pmdd_d[l_ac].pmdd032 = 'N'     
          #若原請購單上該項次的[C:行狀態]的值為2、3、4時，
          #則將單身的pmdd901(單身變更類型)預設值"4:單身已經結案"，且pmdd032(單身結案否)的值預設為Y
          IF l_pmdb032 MATCHES '[234]' THEN
             LET g_pmdd_d[l_ac].pmdd901 = '4'   #單身變更類型
             LET g_pmdd_d[l_ac].pmdd032 = 'Y'
          END IF
          LET l_pmdb032 = ''  
          
          INSERT INTO pmdd_t
                  (pmddent,pmdddocno,pmdd900,pmddseq,pmdd001,pmdd002,
                  pmddsite,pmdd200,pmdd004,pmdd037,pmdd260,pmdd038,
                  #pmdd201,pmdd202,pmdd006,pmdd007,pmdd207,
                  pmdd201,pmdd202,pmdd212,pmdd006,pmdd007,pmdd207,#ken---add pmdd212
                  pmdd015,pmdd049,pmdd030,pmdd048,pmdd208,
                  pmdd209,pmdd206,pmdd210,pmdd211,pmdd205,
                  pmdd203,pmdd204,pmdd901,pmdd902,pmdd903,pmdd032, # )
                  pmdd033           #150324-00006#14 2015/04/09 By pomelo add
                  #ken---add---s 需求單號：141224-00013 項次：7
                  ,pmdd252,pmdd253,pmdd254 #現有庫存,入庫在途量,前一週銷量
                  ,pmdd255,pmdd256,pmdd257 #前二週銷量,前三週銷量,前四周銷量
                  ,pmdd258,pmdd259 #)        #要貨在途量,周平均銷量
                  #ken---add---e
                  #ken---add---s 需求單號： 項次：
                  ,pmdd005,pmdd227) #產品特徵  #補貨規格說明  #150710-00016#4 Add By Ken 150713
                  #ken---add---e
            VALUES(g_enterprise,g_pmdc_m.pmdcdocno,g_pmdc_m.pmdc900,g_pmdd_d[l_ac].pmddseq,g_pmdd_d[l_ac].pmdd001,g_pmdd_d[l_ac].pmdd002,
                   g_pmdd_d[l_ac].pmddsite,g_pmdd_d[l_ac].pmdd200,g_pmdd_d[l_ac].pmdd004,
                   g_pmdd_d[l_ac].pmdd037,g_pmdd_d[l_ac].pmdd260,g_pmdd_d[l_ac].pmdd038,g_pmdd_d[l_ac].pmdd201,
                   #g_pmdd_d[l_ac].pmdd202,g_pmdd_d[l_ac].pmdd006,g_pmdd_d[l_ac].pmdd007,
                   g_pmdd_d[l_ac].pmdd202,g_pmdd_d[l_ac].pmdd212,g_pmdd_d[l_ac].pmdd006,g_pmdd_d[l_ac].pmdd007,#ken---add g_pmdd_d[l_ac].pmdd212
                   g_pmdd_d[l_ac].pmdd207,g_pmdd_d[l_ac].pmdd015,g_pmdd_d[l_ac].pmdd049,
                   g_pmdd_d[l_ac].pmdd030,g_pmdd_d[l_ac].pmdd048,g_pmdd_d[l_ac].pmdd208,
                   g_pmdd_d[l_ac].pmdd209,g_pmdd_d[l_ac].pmdd206,g_pmdd_d[l_ac].pmdd210,
                   g_pmdd_d[l_ac].pmdd211,g_pmdd_d[l_ac].pmdd205,g_pmdd_d[l_ac].pmdd203,
                   g_pmdd_d[l_ac].pmdd204,g_pmdd_d[l_ac].pmdd901,g_pmdd_d[l_ac].pmdd902,
                   g_pmdd_d[l_ac].pmdd903,g_pmdd_d[l_ac].pmdd032,   #)
                   g_pmdd_d[l_ac].pmdd033               #150324-00006#14 2015/04/09 By pomelo add
                   #ken---add---s 需求單號：141224-00013 項次：7
                   ,g_pmdd_d[l_ac].pmdd252,g_pmdd_d[l_ac].pmdd253,g_pmdd_d[l_ac].pmdd254 #現有庫存,入庫在途量,前一週銷量
                   ,g_pmdd_d[l_ac].pmdd255,g_pmdd_d[l_ac].pmdd256,g_pmdd_d[l_ac].pmdd257 #前二週銷量,前三週銷量,前四周銷量
                   ,g_pmdd_d[l_ac].pmdd258,g_pmdd_d[l_ac].pmdd259 #)                       #要貨在途量,周平均銷量
                   #ken---add---e 
                   #ken---add---s 需求單號： 項次：
                   ,g_pmdd_d[l_ac].pmdd005,g_pmdd_d[l_ac].pmdd227)  #補貨規格說明  #150710-00016#4 Add By Ken 150713
                   #ken---add---e

          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = "pmdd_t"
             LET g_errparam.popup = FALSE
             CALL cl_err()

             LET r_success = FALSE
             RETURN r_success
          END IF 
          
         
 
          LET l_ac = l_ac + 1
	      INITIALIZE g_pmdd_d[l_ac].* TO NULL
          
       END FOREACH
       RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 取得產品特徵類別
# Memo...........:
# Usage..........: CALL apmt835_get_imaa005(p_imaa001)
#                  RETURNING r_imaa005
# Input parameter: p_imaa001   商品編號
# Return code....: r_imaa005   產品特徵類別
# Date & Author..: 2015/02/10 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt835_get_imaa005(p_imaa001)
DEFINE p_imaa001      LIKE imaa_t.imaa001
DEFINE r_imaa005      LIKE imaa_t.imaa005

   LET r_imaa005 = ''
   SELECT imaa005 INTO r_imaa005 
     FROM imaa_t 
    WHERE imaaent = g_enterprise 
      AND imaa001 = p_imaa001
      
   RETURN r_imaa005 
END FUNCTION

################################################################################
# Descriptions...: 到貨日期必須小於單身項次需求日期
# Memo...........:
# Usage..........: CALL apmt835_pmdc207_chk
#                  RETURNING TRUE(FALSE)
# Input parameter: 無
# Return code....: TRUE(FALSE)   
# Date & Author..: 2015/03/16 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt835_pmdc207_chk()
DEFINE  l_n LIKE type_t.num5

   SELECT COUNT(*) INTO l_n FROM pmdd_t
    WHERE pmdddocno = g_pmdc_m.pmdcdocno AND pmddent = g_enterprise AND pmdd030 <  g_pmdc_m.pmdc207 
      AND pmdd900  = g_pmdc_m.pmdc900
    
   IF l_n > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apm-00368'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF
   RETURN TRUE
   
END FUNCTION

################################################################################
# Descriptions...: 檢查商品編號是否符合相關條件
# Memo...........: 
# Usage..........: CALL apmt835_pmdd004_chk()
#                  RETURNING TRUE(FALSE)
# Input parameter: 無
# Return code....: TRUE(FALSE)
# Date & Author..: 2015/03/16 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt835_pmdd004_chk()
DEFINE l_n        LIKE type_t.num5
DEFINE l_sys      LIKE type_t.num5
DEFINE l_pmdd015  LIKE pmdd_t.pmdd015
DEFINE l_star004  LIKE star_t.star004
DEFINE l_stan017  LIKE stan_t.stan017
DEFINE l_stan018  LIKE stan_t.stan018
DEFINE l_starstus LIKE star_t.starstus
DEFINE l_rtdxstus LIKE rtdx_t.rtdxstus
DEFINE l_pmdd004  LIKE pmdd_t.pmdd004
DEFINE l_sql      STRING
DEFINE l_rtdx027  LIKE rtdx_t.rtdx027  #採購方式 #150416-00013#2 2015/04/29 sakura add

#.輸入值須存在[T:料件基本資料檔].[C:料件編號]，且[C:資料狀態]為確認
#检查是否存在门店清单是否有效
#检查条码是否有效
   #INITIALIZE g_chkparam.* TO NULL
   #LET g_errshow = '1'
   #LET g_chkparam.arg1 = g_pmdd_d[l_ac].pmdd004
   #LET g_chkparam.arg1 = g_pmdd_d[l_ac].pmddsite
   #IF NOT cl_chk_exist("v_rtdx001_1") THEN
   #   RETURN FALSE
   #END IF


   SELECT rtdxstus  INTO l_rtdxstus 
     FROM rtdx_t 
	 LEFT JOIN imaa_t ON rtdx001 = imaa001 AND rtdxent = imaaent  
	 LEFT JOIN imay_t ON rtdx002 = imay003 AND imay001 = rtdx001 AND imayent = rtdxent 
    WHERE rtdx001 = g_pmdd_d[l_ac].pmdd004 
	  AND rtdxsite = g_pmdd_d[l_ac].pmddsite  
	  AND rtdxent = g_enterprise 
   #檢查輸入的商品編號存不存在相應門店的[門店清單檔rtdx_t]中!
   IF STATUS = 100 OR cl_null(l_rtdxstus) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'art-00151'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   ELSE
      #檢查輸入的商品編號在相應門店的[門店清單檔rtdx_t]中是否有效!  
      IF l_rtdxstus <>'Y' THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'art-00156'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   END IF  
   
   SELECT COUNT(*) INTO l_n  
     FROM rtdx_t 
	 LEFT JOIN imaa_t ON rtdx001 = imaa001 AND rtdxent = imaaent  
	 LEFT JOIN imay_t ON rtdx002 = imay003 AND imay001 = rtdx001 AND imayent = rtdxent 
    WHERE rtdx001 = g_pmdd_d[l_ac].pmdd004 
	  AND rtdxsite = g_pmdd_d[l_ac].pmddsite  
	  AND rtdxent = g_enterprise 
      AND imaastus <> 'Y' 
   IF l_n > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'art-00126'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE  
   END IF 
     
 
   SELECT COUNT(*) INTO l_n  
     FROM rtdx_t 
	 LEFT JOIN imaa_t ON rtdx001 = imaa001 AND rtdxent = imaaent  
	 LEFT JOIN imay_t ON rtdx002 = imay003 AND imay001 = rtdx001 AND imayent = rtdxent 
    WHERE rtdx001 = g_pmdd_d[l_ac].pmdd004 
	 AND rtdxsite = g_pmdd_d[l_ac].pmddsite  
	 AND rtdxent = g_enterprise 
     AND imaystus <> 'Y'
     
   IF l_n > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'art-00262'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE  
   END IF
   
   #若單頭有指定"採購類型"時，輸入的商品對應的採購類型應等於單頭的採購類型(由門店清單中抓取採購類型)
   IF NOT cl_null(g_pmdc_m.pmdc201) THEN    
      SELECT COUNT(*) INTO l_n 
	    FROM rtdx_t 
       WHERE rtdxent = g_enterprise 
	     AND rtdx001 = g_pmdd_d[l_ac].pmdd004 
		 AND rtdx027 = g_pmdc_m.pmdc201 
		 AND rtdxsite = g_pmdd_d[l_ac].pmddsite
      IF l_n = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'apm-00327'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   END IF

   #若單頭有指定"採購中心"時，輸入商品對應的採購中心應等於單頭的採購中心(由門店清單中抓取採購中心)
   IF NOT cl_null(g_pmdc_m.pmdc204) THEN
      SELECT COUNT(*) INTO l_n 
	    FROM rtdx_t 
       WHERE rtdxent = g_enterprise 
	     AND rtdx001 = g_pmdd_d[l_ac].pmdd004 
		 AND rtdx028 = g_pmdc_m.pmdc204
      IF l_n = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'apm-00328'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   END IF

   #若單頭有指定"配送中心"時，輸入商品對應的配送中心應等於單頭的配送中心(由門店清單中抓取配送中心)
   IF NOT cl_null(g_pmdc_m.pmdc205) THEN
      SELECT COUNT(*) INTO l_n 
	    FROM rtdx_t 
       WHERE rtdxent = g_enterprise 
	     AND rtdx001 = g_pmdd_d[l_ac].pmdd004 
		 AND rtdx029 = g_pmdc_m.pmdc205
      IF l_n = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'apm-00329'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   END IF

   #若單頭有指定所屬品類。輸入商品必須存在所屬品類或者其下級
   CALL cl_get_para(g_enterprise,g_site,'E-CIR-0001') RETURNING l_sys
   IF NOT cl_null(g_pmdc_m.pmdc202) THEN
      LET l_sql = " SELECT COUNT(*) FROM imaa_t ",
                 "  WHERE imaaent = '",g_enterprise,"' AND imaa001 = '",g_pmdd_d[l_ac].pmdd004,"'",
                 "   AND imaa009 IN (SELECT DISTINCT rtax001 FROM rtax_t",
                 "                    WHERE rtaxent = '",g_enterprise,"' AND rtax004 >='",l_sys,"' AND rtaxstus = 'Y'",
                 #"                    START WITH rtax003 = '", g_pmdc_m.pmdc202,"' AND  rtaxstus = 'Y' CONNECT BY nocycle PRIOR rtax001 = rtax003 )" #151211-00004#1 Mark By Ken 160304
                 #151211-00004#1 Add By Ken 160304(S)
                 "                    START WITH rtax003 = '", g_pmdc_m.pmdc202,"' ",   
                 "                    CONNECT BY NOCYCLE PRIOR rtax001 = rtax003 ",     
                 "                    UNION ",
                 "                   SELECT DISTINCT rtax001",
                 "                              FROM rtax_t ",
                 "                             WHERE rtaxent =",g_enterprise,
                 "                               AND rtax004 = ",l_sys,
                 "                               AND rtax005 = 0 ",
                 "                               AND rtaxstus = 'Y' ",
                 "                               AND rtax001 = '",g_pmdc_m.pmdc202,"' )"  
                 #151211-00004#1 Add By Ken 160304(E)
      #SELECT COUNT(*) INTO l_n FROM imaa_t 
      # WHERE imaaent = g_enterprise AND imaa001 = g_pmdd_d[l_ac].pmdd004
      #   AND imaa009 IN (SELECT DISTINCT rtax001 FROM rtax_t 
      #                    WHERE rtaxent =g_enterprise AND rtax004 >=l_sys AND rtaxstus = 'Y' 
      #                     START WITH rtax003 = g_pmdc_m.pmdc202 AND rtaxstus = 'Y' CONNECT BY nocycle PRIOR rtax001 = rtax003 )
      
      PREPARE sel_cnt FROM l_sql
      EXECUTE sel_cnt INTO l_n
      IF l_n = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'apm-00331'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   END IF

   #150416-00013#2 2015/04/29 sakura add---S
   #先抓取採購方式; rtdx027 用來判斷是否需要有主供應商(採購方式為2:統採配送時主供應商可為空)
   SELECT rtdx027  INTO l_rtdx027 FROM rtdx_t
    WHERE rtdxent = g_enterprise AND rtdxsite = g_pmdd_d[l_ac].pmddsite AND rtdx001 =  g_pmdd_d[l_ac].pmdd004
   #150416-00013#2 2015/04/29 sakura add---E

   ##先抓取供應商; rtdx031 已改no use
   #SELECT rtdx031  INTO  l_pmdd015 FROM rtdx_t 
   # WHERE rtdxent = g_enterprise AND rtdxsite = g_pmdd_d[l_ac].pmddsite AND rtdx001 =  g_pmdd_d[l_ac].pmdd004
 
    #先抓取供應商 
   SELECT imaf153 INTO l_pmdd015 
     FROM imaf_t 
    WHERE imafent = g_enterprise 
	  AND imafsite = g_pmdd_d[l_ac].pmddsite 
	  AND imaf001 = g_pmdd_d[l_ac].pmdd004
 
   IF NOT cl_null(l_pmdd015) THEN
     #根據根據供應商+商品 和單據日期抓取屬於哪個區間的合同    
     SELECT COUNT(*) INTO l_n 
	   FROM  stan_t,star_t,stas_t 
      WHERE starent = stasent 
	    AND star001 = stas001 
		AND stan001 = star004 
	   AND starsite = stassite    #150529 by s983961 add
        AND stanent = starent 
		AND stanent = g_enterprise 
		AND starsite = g_pmdd_d[l_ac].pmddsite #150603 by geza add
        AND stas003 = g_pmdd_d[l_ac].pmdd004 
		AND star003 = l_pmdd015
		
     IF l_n = 0 THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = 'apm-00468'
        LET g_errparam.extend = ''
        LET g_errparam.popup = TRUE
        CALL cl_err()
        #不存在采购协议
        RETURN FALSE  
     END IF
     
     SELECT DISTINCT star004,starstus INTO l_star004,l_starstus 
	   FROM stan_t,star_t,stas_t 
      WHERE starent = stasent 
	     AND star001 = stas001 
		  AND stan001 = star004 
		  AND starsite = stassite     #150529 by s983961 add
        AND stanent = starent 
		  AND stanent = g_enterprise 
        AND stas003 = g_pmdd_d[l_ac].pmdd004
        AND starsite = g_pmdd_d[l_ac].pmddsite #150603 by geza add        
		  AND star003 = l_pmdd015 
        #AND g_pmdc_m.pmdcdocdt BETWEEN stan017 AND stan018   #160104-00014#1 20160105 mark by beckxie
        AND g_pmdc_m.pmdcdocdt BETWEEN stas018 AND stas019    #160104-00014#1 20160105  add by beckxie
     
     IF cl_null(l_star004) THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = 'apm-00333'
        LET g_errparam.extend = ''
        LET g_errparam.popup = TRUE
        CALL cl_err()
        #不在生效範圍之內
        RETURN FALSE
     END IF 
     IF l_starstus <> 'Y' THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = 'apm-00334'
        LET g_errparam.extend = ''
        LET g_errparam.popup = TRUE
        CALL cl_err()
       #作廢
        RETURN FALSE
     END IF
   ELSE
      #150416-00013#2 2015/04/29 sakura modify---S
      #用來判斷是否需要有主供應商(採購方式為2:統採配送時主供應商可為空)
      #artq400 主要供應商找不到
      IF l_rtdx027 <> '2' THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'apm-00846'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN FALSE
      END IF      
      #150416-00013#2 2015/04/29 sakura modify---E
   END IF
   
   #IF NOT cl_null(g_pmdd_d[l_ac].pmdd200) THEN
   #   SELECT DISTINCT imay001 INTO l_pmdd004 
	#    FROM imay_t
   #    WHERE imayent = g_enterprise 
	#     AND imay003 = g_pmdd_d[l_ac].pmdd200
   #         
   #   IF g_pmdd_d[l_ac].pmdd004 <> l_pmdd004 THEN
   #      INITIALIZE g_errparam TO NULL
   #      LET g_errparam.code = 'art-00274'
   #      LET g_errparam.extend = ''
   #      LET g_errparam.popup = TRUE
   #      CALL cl_err()
   #
   #      RETURN FALSE
   #   END IF
   #END IF
   
   #150126-00028#14 By benson ---- S
   #IF NOT s_arti204_control_check(g_prog,g_pmdc_m.pmdc003,g_pmdd_d[l_ac].pmdd004,'') THEN  #160118-00013#6 20160118 by s983961--mark
   IF NOT s_arti204_control_check('apmt830',g_pmdc_m.pmdc003,g_pmdd_d[l_ac].pmdd004,'') THEN  #160118-00013#6 20160118 by s983961--add   
      RETURN FALSE
   END IF
   #150126-00028#14 By benson ---- E
   RETURN TRUE
   
END FUNCTION

################################################################################
# Descriptions...: 取得商品編號相關資訊
# Memo...........:
# Usage..........: CALL apmt835_pmdd004_other()
# Input parameter: 
# Return code....: 無
# Date & Author..: 2015/03/16 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt835_pmdd004_other()
DEFINE l_sys2         LIKE type_t.num5    #補貨規格的參數
DEFINE l_imaz004      LIKE imaz_t.imaz004
DEFINE l_imaz005      LIKE imaz_t.imaz005
DEFINE l_imaz006      LIKE imaz_t.imaz006

   #先清空原本帶值欄位資料
   LET g_pmdd_d[l_ac].imaa009 = ''     #品類
   LET g_pmdd_d[l_ac].imaa009_desc=''  #品類說明
   LET g_pmdd_d[l_ac].pmdd201 = ''     #包裝單位
   LET g_pmdd_d[l_ac].pmdd202 = ''     #件裝數
   LET g_pmdd_d[l_ac].pmdd015 = ''     #供應商 
   LET g_pmdd_d[l_ac].pmdd015_desc = ''#供應商說明 
   LET g_pmdd_d[l_ac].pmdd208 = ''     #經營方式
   LET g_pmdd_d[l_ac].pmdd209 =''      #結算方式
   LET g_pmdd_d[l_ac].pmdd209_desc ='' #結算方式說明
   LET g_pmdd_d[l_ac].pmdd206 =''      #採購員
   LET g_pmdd_d[l_ac].pmdd206_desc ='' #採購員全名
   LET g_pmdd_d[l_ac].pmdd205 =''      #採購中心
   LET g_pmdd_d[l_ac].pmdd205_desc ='' #採購中心說明
   LET g_pmdd_d[l_ac].pmdd203 =''      #配送中心
   LET g_pmdd_d[l_ac].pmdd203_desc ='' #配送中心說明
   LET g_pmdd_d[l_ac].pmdd212 = ''     #要貨件數
   LET g_pmdd_d[l_ac].pmdd006 = ''     #需求數量 
   LET g_pmdd_d[l_ac].pmdd007 = ''     #單位
   LET g_pmdd_d[l_ac].pmdd005 = ''     #產品特徵
   LET g_pmdd_d[l_ac].pmdd005_desc = ''#產品特徵說明
   LET g_pmdd_d[l_ac].pmdd227 = ''  #補貨規格說明   
   
   #150710-00016#4 Add By Ken 150713(S) 取商品符合補貨規格的包裝單位、件裝數、補貨規格
   CALL cl_get_para(g_enterprise,g_pmdd_d[l_ac].pmddsite,'S-CIR-1001') RETURNING l_sys2
   SELECT imaz004,imaz005,imaz006 INTO l_imaz004,l_imaz005,l_imaz006
     FROM imaz_t
    WHERE imazent = g_enterprise 
      AND imaz001 = g_pmdd_d[l_ac].pmdd004
      AND imaz002 = l_sys2   
   #150710-00016#4 Add By Ken 150713(E) 
      
   IF cl_null(g_pmdd_d[l_ac].pmdd200) THEN
        #帶出條碼       
      SELECT rtdx002 INTO g_pmdd_d[l_ac].pmdd200  
  	     FROM rtdx_t 
       WHERE rtdxent = g_enterprise 
  	      AND rtdxsite = g_pmdd_d[l_ac].pmddsite 
  	      AND rtdx001 = g_pmdd_d[l_ac].pmdd004 
       #SELECT imay003 INTO g_pmdd_d[l_ac].pmdd200 FROM imay_t WHERE imayent= g_enterprise AND imay001 = g_pmdd_d[l_ac].pmdd004 AND imay006 = 'Y'   
   END IF
   #品類編號
   CALL apmt835_get_imaa009(g_pmdd_d[l_ac].pmdd004) RETURNING g_pmdd_d[l_ac].imaa009
   DISPLAY BY NAME g_pmdd_d[l_ac].imaa009                    
   
   #品類說明
   CALL s_desc_get_rtaxl003_desc(g_pmdd_d[l_ac].imaa009) RETURNING g_pmdd_d[l_ac].imaa009_desc
   DISPLAY BY NAME g_pmdd_d[l_ac].imaa009_desc   
   
   #150710-00016#4 Add By Ken 150713(S) 如補貨規格有符合 則使用補貨規格的包裝單位、件裝數、補貨規格，沒有的話則帶主條碼的包裝單位、件裝數
   IF NOT cl_null(l_imaz004) THEN
      LET g_pmdd_d[l_ac].pmdd201 = l_imaz004
      LET g_pmdd_d[l_ac].pmdd202 = l_imaz005
      LET g_pmdd_d[l_ac].pmdd227 = l_imaz006
   ELSE
      SELECT imay004,imay005 
        INTO g_pmdd_d[l_ac].pmdd201,g_pmdd_d[l_ac].pmdd202 
        FROM imay_t 
       WHERE imayent= g_enterprise 
         AND imay001 = g_pmdd_d[l_ac].pmdd004 
         AND imay003 = g_pmdd_d[l_ac].pmdd200   
   END IF
   #150710-00016#4 Add By Ken 150713 (E)   
   
   #带包裝單位,件裝數
   #150521-00015#2 15/05/28 s983961---add(S)
   #IF NOT cl_null(l_imaz003) THEN   #06/08先判斷是否有 補貨規格級別 條碼
   #抓取大補貨規格的包裝單位,件裝數
   #  SELECT imaz004,imaz005 INTO g_pmdd_d[l_ac].pmdd201,g_pmdd_d[l_ac].pmdd202 FROM imaz_t WHERE imazent= g_enterprise AND imaz001 = g_pmdd_d[l_ac].pmdd004 AND imaz003 = g_pmdd_d[l_ac].pmdd200
   #ELSE        
   #抓取主條碼的包裝單位,件裝數   
   #150521-00015#2 15/05/28 s983961---add(E)
   #  SELECT imay004,imay005 INTO g_pmdd_d[l_ac].pmdd201,g_pmdd_d[l_ac].pmdd202 FROM imay_t WHERE imayent= g_enterprise AND imay001 = g_pmdd_d[l_ac].pmdd004 AND imay003 = g_pmdd_d[l_ac].pmdd200   
   #SELECT rtdx004,rtdx005 INTO g_pmdd_d[l_ac].pmdd201,g_pmdd_d[l_ac].pmdd202 
   #  FROM rtdx_t 
   # WHERE rtdxent = g_enterprise
	#  AND rtdxsite = g_pmdd_d[l_ac].pmddsite 
	#  AND rtdx001 =  g_pmdd_d[l_ac].pmdd004
   #END IF
   
   
   #包裝單位說明
   CALL s_desc_get_unit_desc(g_pmdd_d[l_ac].pmdd201) RETURNING g_pmdd_d[l_ac].pmdd201_desc
   DISPLAY BY NAME g_pmdd_d[l_ac].pmdd201_desc  

   #要貨單位預設抓 庫存單位
   SELECT imaa104 INTO  g_pmdd_d[l_ac].pmdd007 
     FROM imaa_t 
	WHERE imaaent = g_enterprise 
	AND imaa001 = g_pmdd_d[l_ac].pmdd004
   
   #要貨單位說明
   CALL s_desc_get_unit_desc(g_pmdd_d[l_ac].pmdd007) RETURNING g_pmdd_d[l_ac].pmdd007_desc
   DISPLAY BY NAME g_pmdd_d[l_ac].pmdd007_desc 
   
    
   #帶出採購類型，經營方式，採購中心，配送中心
   SELECT rtdx027,rtdx003,rtdx028,rtdx029 
    INTO g_pmdd_d[l_ac].pmdd207,g_pmdd_d[l_ac].pmdd208,g_pmdd_d[l_ac].pmdd205,g_pmdd_d[l_ac].pmdd203 
	  FROM rtdx_t 
    WHERE rtdxent = g_enterprise 
	  AND rtdxsite = g_pmdd_d[l_ac].pmddsite 
	  AND rtdx001 = g_pmdd_d[l_ac].pmdd004
   
   #帶出採購中心名稱
   CALL s_desc_get_department_desc(g_pmdd_d[l_ac].pmdd205) RETURNING g_pmdd_d[l_ac].pmdd205_desc
   DISPLAY BY NAME g_pmdd_d[l_ac].pmdd205_desc  
   
   #帶出配送中心名稱
   CALL s_desc_get_department_desc(g_pmdd_d[l_ac].pmdd203) RETURNING g_pmdd_d[l_ac].pmdd203_desc
   DISPLAY BY NAME g_pmdd_d[l_ac].pmdd203_desc
    
   #帶出供應商
   SELECT imaf153 INTO g_pmdd_d[l_ac].pmdd015 
	FROM imaf_t 
    WHERE imafent = g_enterprise 
	  AND imafsite = g_pmdd_d[l_ac].pmddsite 
	  AND imaf001 =  g_pmdd_d[l_ac].pmdd004
   
   #帶出供應商名稱
   CALL s_desc_get_trading_partner_abbr_desc(g_pmdd_d[l_ac].pmdd015) RETURNING g_pmdd_d[l_ac].pmdd015_desc
   DISPLAY BY NAME g_pmdd_d[l_ac].pmdd015_desc
      
   IF NOT cl_null(g_pmdd_d[l_ac].pmdd015) THEN   
      #[C:結算方式]= [T:採購協議單頭檔].[C:結算方式](由單身生效的商品回找單頭)

      SELECT DISTINCT star006,stas009 INTO g_pmdd_d[l_ac].pmdd209,g_pmdd_d[l_ac].pmdd206 
	     FROM stan_t,star_t,stas_t 
       WHERE starent = stasent 
	      AND star001 = stas001 
         AND stanent = starent 
		   AND stan001 = star004 
		   AND starsite = stassite   #150529 by s983961 add
		   AND stanent = g_enterprise
         AND stas003 = g_pmdd_d[l_ac].pmdd004
         AND starsite = g_pmdd_d[l_ac].pmddsite #150603 by geza add           
		   AND star003 = g_pmdd_d[l_ac].pmdd015 
		   AND starstus = 'Y'
         #AND g_pmdc_m.pmdcdocdt BETWEEN stan017 AND stan018   #160104-00014#1 20160105 mark by beckxie
         AND g_pmdc_m.pmdcdocdt BETWEEN stas018 AND stas019    #160104-00014#1 20160105  add by beckxie
      
      SELECT staal003 INTO g_pmdd_d[l_ac].pmdd209_desc 
	    FROM staal_t
       WHERE staalent = g_enterprise 
	     AND staal001 = g_pmdd_d[l_ac].pmdd209 
		 AND staal002 = g_dlang
    
     #[C:採購員]=[T:採購協議單身檔].[C:採購員] (抓取生效的協議資料)並自動帶出姓名
     CALL s_desc_get_person_desc(g_pmdd_d[l_ac].pmdd206) RETURNING g_pmdd_d[l_ac].pmdd206_desc
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 取得品類編號
# Memo...........:
# Usage..........: CALL apmt835_get_imaa009(p_pmdd004)
#                  RETURNING r_imaa009
# Input parameter: p_pmdd004      商品編號
# Return code....: r_imaa009      品類編號
# Date & Author..: 2015/03/16 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt835_get_imaa009(p_pmdd004)
DEFINE p_pmdd004      LIKE pmdd_t.pmdd004
DEFINE r_imaa009      LIKE imaa_t.imaa009

   LET r_imaa009 = ''
   SELECT imaa009 INTO r_imaa009 
     FROM imaa_t 
    WHERE imaaent = g_enterprise 
      AND imaa001 = p_pmdd004
              
   RETURN r_imaa009
   
END FUNCTION

################################################################################
# Descriptions...: 取得商品採購方式
# Memo...........:
# Usage..........: CALL apmt835_get_rtdx027(p_pmddsite,p_pmdd004)
#                  RETURNING r_rtdx027
# Input parameter: p_pmddsite     需求組織
#                : p_pmdd004      商品編號
# Return code....: r_rtdx027      採購方式
# Date & Author..: 2015/03/16 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt835_get_rtdx027(p_pmddsite,p_pmdd004)
DEFINE p_pmddsite      LIKE pmdd_t.pmddsite
DEFINE p_pmdd004       LIKE pmdd_t.pmdd004
DEFINE r_rtdx027       LIKE rtdx_t.rtdx027

   LET r_rtdx027 = ''
   SELECT rtdx027 INTO r_rtdx027 
     FROM rtdx_t 
    WHERE rtdxent  = g_enterprise 
      AND rtdxsite = p_pmddsite
      AND rtdx001  = p_pmdd004
      
   RETURN r_rtdx027
END FUNCTION

################################################################################
# Descriptions...: 計算前一、二、三、四週銷量及周平均銷量
# Memo...........: 使用 CALL s_daily_sale(p_debasite,p_date,p_s_days,p_e_days,p_deba009,p_deba043) 計算各週銷量
# Usage..........: CALL apmt835_daily_sale_all(p_pmddsite,p_date,p_pmdd004,p_pmdd005)
#                  RETURNING r_pmdd254,r_pmdd255,r_pmdd256,r_pmdd257,r_pmdd259
# Input parameter: p_pmddsite   需求組織
#                : p_date       單據日期
#                : p_pmdd004    商品編號
#                : p_pmdd005    產品特徵
# Return code....: r_pmdd254    前一週銷量
#                : r_pmdd255    前二週銷量
#                : r_pmdd256    前三週銷量
#                : r_pmdd257    前四週銷量
#                : r_pmdd259    週平均銷量
# Date & Author..: 2015/03/16 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt835_daily_sale_all(p_pmddsite,p_date,p_pmdd004,p_pmdd005)
   DEFINE p_pmddsite     LIKE pmdd_t.pmddsite    #需求組織
   DEFINE p_date         LIKE pmda_t.pmdadocdt   #單據日期
   DEFINE p_pmdd004      LIKE pmdd_t.pmdd004     #商品編號
   DEFINE p_pmdd005      LIKE pmdd_t.pmdd005     #產品特徵
   DEFINE r_pmdd254      LIKE pmdd_t.pmdd254     #前一週銷量
   DEFINE r_pmdd255      LIKE pmdd_t.pmdd255     #前二週銷量
   DEFINE r_pmdd256      LIKE pmdd_t.pmdd256     #前三週銷量
   DEFINE r_pmdd257      LIKE pmdd_t.pmdd257     #前四週銷量
   DEFINE r_pmdd259      LIKE pmdd_t.pmdd259     #週平均銷量
   
   LET r_pmdd254 = 0
   LET r_pmdd255 = 0
   LET r_pmdd256 = 0
   LET r_pmdd257 = 0
   LET r_pmdd259 = 0
   
   IF p_pmdd004 IS NOT NULL THEN
      CALL s_daily_sale(p_pmddsite,p_date,1,7,p_pmdd004,p_pmdd005)
         RETURNING r_pmdd254
      CALL s_daily_sale(p_pmddsite,p_date,8,14,p_pmdd004,p_pmdd005)
         RETURNING r_pmdd255
      CALL s_daily_sale(p_pmddsite,p_date,15,21,p_pmdd004,p_pmdd005)
         RETURNING r_pmdd256
      CALL s_daily_sale(p_pmddsite,p_date,22,28,p_pmdd004,p_pmdd005)
         RETURNING r_pmdd257
      
      LET r_pmdd259 = (r_pmdd254 + r_pmdd255 + r_pmdd256 + r_pmdd257)/4
   END IF 
   RETURN r_pmdd254,r_pmdd255,r_pmdd256,r_pmdd257,r_pmdd259 
   
END FUNCTION

################################################################################
# Descriptions...: 更新單頭包裝總數量(pmdc208)
# Memo...........:
# Usage..........: CALL apmt835_upd_pmdc208()
#                  RETURNING r_success
# Input parameter: 無
# Return code....: r_success   TRUE(FALSE)
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt835_upd_pmdc208()
 DEFINE r_success     LIKE type_t.num5
 
   SELECT SUM(pmdd212) INTO g_pmdc_m.pmdc208 
     FROM pmdd_t
    WHERE pmddent = g_enterprise
      AND pmdddocno = g_pmdc_m.pmdcdocno
	  
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "upd_pmdc208"
      LET g_errparam.popup = TRUE
      CALL cl_err()
  
      LET r_success = FALSE
      RETURN r_success
   END IF
   DISPLAY BY NAME g_pmdc_m.pmdc208

   LET r_success = TRUE
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 刪除請購變更歷程檔
# Memo...........:
# Usage..........: CALL apmt835_del_pmde(p_pmdeseq,p_pmde002)
#                  RETURNING r_success
# Input parameter: p_pmdeseq   請購項次
#                : p_pmde002   變更欄位
# Return code....: r_success   TRUE(FALSE)
# Date & Author..: 2015/03/16 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt835_del_pmde(p_pmdeseq,p_pmde002)
DEFINE p_pmdeseq   LIKE pmde_t.pmdeseq   #請購項次
DEFINE p_pmde002   LIKE pmde_t.pmde002   #變更欄位
DEFINE r_success   LIKE type_t.num5

       LET r_success = TRUE
       
       DELETE FROM pmde_t 
	     WHERE pmdeent = g_enterprise 
		   AND pmdedocno = g_pmdc_m.pmdcdocno 
		   AND pmde001 = g_pmdc_m.pmdc900 
		   AND pmdeseq = p_pmdeseq 
		   AND pmde002 = p_pmde002

       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = "pmde_t"
          LET g_errparam.popup = TRUE
          CALL cl_err()
  
          LET r_success = FALSE
          RETURN r_success
       END IF
       RETURN r_success
       
END FUNCTION

################################################################################
# Descriptions...: 單頭資料有異動時,將pmdc901異動類型新增為'Y'
# Memo...........:
# Usage..........: CALL apmt835_upd_pmdc901()
#                  RETURNING r_success
# Input parameter: 無
# Return code....: r_success   TRUE(FALSE)
# Date & Author..: 2015/03/16 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt835_upd_pmdc901()
#161104-00002#11 161110 By rainy mod---(S) 
#調整*寫法   
#DEFINE l_pmda     RECORD LIKE pmda_t.*
DEFINE l_pmda RECORD  #請購單單頭頭檔
       pmdaent LIKE pmda_t.pmdaent, #企業編號
       pmdaownid LIKE pmda_t.pmdaownid, #資料所有者
       pmdaowndp LIKE pmda_t.pmdaowndp, #資料所屬部門
       pmdacrtid LIKE pmda_t.pmdacrtid, #資料建立者
       pmdacrtdp LIKE pmda_t.pmdacrtdp, #資料建立部門
       pmdacrtdt LIKE pmda_t.pmdacrtdt, #資料創建日
       pmdamodid LIKE pmda_t.pmdamodid, #資料修改者
       pmdamoddt LIKE pmda_t.pmdamoddt, #最近修改日
       pmdacnfid LIKE pmda_t.pmdacnfid, #資料確認者
       pmdacnfdt LIKE pmda_t.pmdacnfdt, #資料確認日
       pmdapstid LIKE pmda_t.pmdapstid, #資料過帳者
       pmdapstdt LIKE pmda_t.pmdapstdt, #資料過帳日
       pmdastus LIKE pmda_t.pmdastus, #狀態碼
       pmdasite LIKE pmda_t.pmdasite, #營運據點
       pmdadocno LIKE pmda_t.pmdadocno, #請購單號
       pmdadocdt LIKE pmda_t.pmdadocdt, #請購日期
       pmda001 LIKE pmda_t.pmda001, #版次
       pmda002 LIKE pmda_t.pmda002, #請購人員
       pmda003 LIKE pmda_t.pmda003, #請購部門
       pmda004 LIKE pmda_t.pmda004, #單價為必要輸入
       pmda005 LIKE pmda_t.pmda005, #幣別
       pmda006 LIKE pmda_t.pmda006, #No Use
       pmda007 LIKE pmda_t.pmda007, #費用部門
       pmda008 LIKE pmda_t.pmda008, #請購總未稅金額
       pmda009 LIKE pmda_t.pmda009, #請購總含稅金額
       pmda010 LIKE pmda_t.pmda010, #稅別
       pmda011 LIKE pmda_t.pmda011, #稅率
       pmda012 LIKE pmda_t.pmda012, #單價含稅否
       pmda020 LIKE pmda_t.pmda020, #納入APS計算
       pmda021 LIKE pmda_t.pmda021, #運送方式
       pmda022 LIKE pmda_t.pmda022, #備註
       pmda200 LIKE pmda_t.pmda200, #來源類型
       pmda201 LIKE pmda_t.pmda201, #採購方式
       pmda202 LIKE pmda_t.pmda202, #所屬品類
       pmda203 LIKE pmda_t.pmda203, #需求組織
       pmda204 LIKE pmda_t.pmda204, #採購中心
       pmda205 LIKE pmda_t.pmda205, #配送中心
       pmda206 LIKE pmda_t.pmda206, #配送倉
       pmda207 LIKE pmda_t.pmda207, #到貨日期
       pmda208 LIKE pmda_t.pmda208, #包裝總數量
       pmda900 LIKE pmda_t.pmda900, #保留欄位str
       pmda999 LIKE pmda_t.pmda999, #保留欄位end
       pmdaud001 LIKE pmda_t.pmdaud001, #自定義欄位(文字)001
       pmdaud002 LIKE pmda_t.pmdaud002, #自定義欄位(文字)002
       pmdaud003 LIKE pmda_t.pmdaud003, #自定義欄位(文字)003
       pmdaud004 LIKE pmda_t.pmdaud004, #自定義欄位(文字)004
       pmdaud005 LIKE pmda_t.pmdaud005, #自定義欄位(文字)005
       pmdaud006 LIKE pmda_t.pmdaud006, #自定義欄位(文字)006
       pmdaud007 LIKE pmda_t.pmdaud007, #自定義欄位(文字)007
       pmdaud008 LIKE pmda_t.pmdaud008, #自定義欄位(文字)008
       pmdaud009 LIKE pmda_t.pmdaud009, #自定義欄位(文字)009
       pmdaud010 LIKE pmda_t.pmdaud010, #自定義欄位(文字)010
       pmdaud011 LIKE pmda_t.pmdaud011, #自定義欄位(數字)011
       pmdaud012 LIKE pmda_t.pmdaud012, #自定義欄位(數字)012
       pmdaud013 LIKE pmda_t.pmdaud013, #自定義欄位(數字)013
       pmdaud014 LIKE pmda_t.pmdaud014, #自定義欄位(數字)014
       pmdaud015 LIKE pmda_t.pmdaud015, #自定義欄位(數字)015
       pmdaud016 LIKE pmda_t.pmdaud016, #自定義欄位(數字)016
       pmdaud017 LIKE pmda_t.pmdaud017, #自定義欄位(數字)017
       pmdaud018 LIKE pmda_t.pmdaud018, #自定義欄位(數字)018
       pmdaud019 LIKE pmda_t.pmdaud019, #自定義欄位(數字)019
       pmdaud020 LIKE pmda_t.pmdaud020, #自定義欄位(數字)020
       pmdaud021 LIKE pmda_t.pmdaud021, #自定義欄位(日期時間)021
       pmdaud022 LIKE pmda_t.pmdaud022, #自定義欄位(日期時間)022
       pmdaud023 LIKE pmda_t.pmdaud023, #自定義欄位(日期時間)023
       pmdaud024 LIKE pmda_t.pmdaud024, #自定義欄位(日期時間)024
       pmdaud025 LIKE pmda_t.pmdaud025, #自定義欄位(日期時間)025
       pmdaud026 LIKE pmda_t.pmdaud026, #自定義欄位(日期時間)026
       pmdaud027 LIKE pmda_t.pmdaud027, #自定義欄位(日期時間)027
       pmdaud028 LIKE pmda_t.pmdaud028, #自定義欄位(日期時間)028
       pmdaud029 LIKE pmda_t.pmdaud029, #自定義欄位(日期時間)029
       pmdaud030 LIKE pmda_t.pmdaud030, #自定義欄位(日期時間)030
       pmda023 LIKE pmda_t.pmda023, #留置原因
       pmda024 LIKE pmda_t.pmda024, #送貨地址
       pmda025 LIKE pmda_t.pmda025, #帳款地址
       pmda209 LIKE pmda_t.pmda209, #包裝總金額
       pmda210 LIKE pmda_t.pmda210, #品種數
       pmda211 LIKE pmda_t.pmda211, #需求時間
       pmda027 LIKE pmda_t.pmda027, #前端單號
       pmda028 LIKE pmda_t.pmda028  #前端類型
END RECORD
#161104-00002#11 161110 By rainy mod---(E) 
DEFINE l_flag     LIKE type_t.num5   #記錄是否有欄位變更
DEFINE r_success  LIKE type_t.num5

       LET r_success = TRUE
       LET l_flag = FALSE
       
       #帶出請購單單頭值
       INITIALIZE l_pmda.* TO NULL
       
       SELECT UNIQUE pmdadocdt,pmdasite,pmdadocno,pmda001,pmda002,pmda003,
	                  pmda200,pmda202,pmda201,pmda203,pmda207,pmda204,
					      pmda205,pmda206,pmda021,pmda208,pmda022
                INTO l_pmda.pmdadocdt,l_pmda.pmdasite,l_pmda.pmdadocno,l_pmda.pmda201,l_pmda.pmda002,l_pmda.pmda003,
				         l_pmda.pmda200,l_pmda.pmda202,l_pmda.pmda201,l_pmda.pmda203,l_pmda.pmda207,l_pmda.pmda204,
					      l_pmda.pmda205,l_pmda.pmda206,l_pmda.pmda021,l_pmda.pmda208,l_pmda.pmda022
         FROM pmda_t 
        WHERE pmdaent = g_enterprise 
		  AND pmdadocno = g_pmdc_m.pmdcdocno
       
       #請購人員
       IF (NOT cl_null(g_pmdc_m.pmdc002) AND (g_pmdc_m.pmdc002 != l_pmda.pmda002 OR cl_null(l_pmda.pmda002)))
          OR (cl_null(g_pmdc_m.pmdc002) AND NOT cl_null(l_pmda.pmda002))   THEN
          LET g_pmde007 = "SELECT oofa011 FROM oofa_t WHERE oofaent='"||g_enterprise||"' AND oofa002='2' AND oofa003='"||l_pmda.pmda002||"' "
          IF NOT apmt835_ins_pmde(0,"pmda002",'1',l_pmda.pmda002,g_pmdc_m.pmdc002) THEN
             LET r_success = FALSE
             RETURN r_success
          ELSE
             LET l_flag = TRUE   #有欄位變更，則更新為'Y'
          END IF
       ELSE
          IF NOT apmt835_del_pmde(0,"pmda002") THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF
        
       #請購部門 
       IF (NOT cl_null(g_pmdc_m.pmdc003) AND (g_pmdc_m.pmdc003 != l_pmda.pmda003 OR cl_null(l_pmda.pmda003)))
          OR (cl_null(g_pmdc_m.pmdc003) AND NOT cl_null(l_pmda.pmda003))   THEN
          LET g_pmde007 = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001='"||l_pmda.pmda003||"' AND ooefl002=?"
          IF NOT apmt835_ins_pmde(0,"pmda003",'1',l_pmda.pmda003,g_pmdc_m.pmdc003) THEN
             LET r_success = FALSE
             RETURN r_success
          ELSE
             LET l_flag = TRUE   #有欄位變更，則更新為'Y'
          END IF
       ELSE
          IF NOT apmt835_del_pmde(0,"pmda003") THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF
       
     
      #來源類型
      IF (NOT cl_null(g_pmdc_m.pmdc200) AND (g_pmdc_m.pmdc200 != l_pmda.pmda200 OR cl_null(l_pmda.pmda200)))
          OR (cl_null(g_pmdc_m.pmdc200) AND NOT cl_null(l_pmda.pmda200))   THEN
          IF NOT apmt835_ins_pmde(0,"pmda200",'1',l_pmda.pmda200,g_pmdc_m.pmdc200) THEN
             LET r_success = FALSE
             RETURN r_success
          ELSE
             LET l_flag = TRUE   #有欄位變更，則更新為'Y'
          END IF
       ELSE
          IF NOT apmt835_del_pmde(0,"pmda200") THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF
      
      
      #所屬品類
      IF (NOT cl_null(g_pmdc_m.pmdc202) AND (g_pmdc_m.pmdc202 != l_pmda.pmda202 OR cl_null(l_pmda.pmda202)))
          OR (cl_null(g_pmdc_m.pmdc202) AND NOT cl_null(l_pmda.pmda202))   THEN
          IF NOT apmt835_ins_pmde(0,"pmda202",'1',l_pmda.pmda202,g_pmdc_m.pmdc202) THEN
             LET r_success = FALSE
             RETURN r_success
          ELSE
             LET l_flag = TRUE   #有欄位變更，則更新為'Y'
          END IF
       ELSE
          IF NOT apmt835_del_pmde(0,"pmda202") THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF
       
       
       #採購類型
        IF (NOT cl_null(g_pmdc_m.pmdc201) AND (g_pmdc_m.pmdc201 != l_pmda.pmda201 OR cl_null(l_pmda.pmda201)))
          OR (cl_null(g_pmdc_m.pmdc201) AND NOT cl_null(l_pmda.pmda201))   THEN
          IF NOT apmt835_ins_pmde(0,"pmda201",'1',l_pmda.pmda201,g_pmdc_m.pmdc201) THEN
             LET r_success = FALSE
             RETURN r_success
          ELSE
             LET l_flag = TRUE   #有欄位變更，則更新為'Y'
          END IF
       ELSE
          IF NOT apmt835_del_pmde(0,"pmda201") THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF
      
       #需求組織
       IF (NOT cl_null(g_pmdc_m.pmdc203) AND (g_pmdc_m.pmdc203 != l_pmda.pmda203 OR cl_null(l_pmda.pmda203)))
          OR (cl_null(g_pmdc_m.pmdc203) AND NOT cl_null(l_pmda.pmda203))   THEN
          LET g_pmde007 = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001='"||l_pmda.pmda203||"' AND ooefl002=?"
          IF NOT apmt835_ins_pmde(0,"pmda203",'1',l_pmda.pmda203,g_pmdc_m.pmdc203) THEN
             LET r_success = FALSE
             RETURN r_success
          ELSE
             LET l_flag = TRUE   #有欄位變更，則更新為'Y'
          END IF
       ELSE
          IF NOT apmt835_del_pmde(0,"pmda203") THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF
     
      #到貨日期
       IF (NOT cl_null(g_pmdc_m.pmdc207) AND (g_pmdc_m.pmdc207 != l_pmda.pmda207 OR cl_null(l_pmda.pmda207)))
          OR (cl_null(g_pmdc_m.pmdc207) AND NOT cl_null(l_pmda.pmda207))   THEN
          IF NOT apmt835_ins_pmde(0,"pmda207",'1',l_pmda.pmda207,g_pmdc_m.pmdc207) THEN
             LET r_success = FALSE
             RETURN r_success
          ELSE
             LET l_flag = TRUE   #有欄位變更，則更新為'Y'
          END IF
       ELSE
          IF NOT apmt835_del_pmde(0,"pmda207") THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF
       
       #採購中心
       IF (NOT cl_null(g_pmdc_m.pmdc204) AND (g_pmdc_m.pmdc204 != l_pmda.pmda204 OR cl_null(l_pmda.pmda204)))
          OR (cl_null(g_pmdc_m.pmdc204) AND NOT cl_null(l_pmda.pmda204))   THEN
          LET g_pmde007 = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001='"||l_pmda.pmda204||"' AND ooefl002=?"
          IF NOT apmt835_ins_pmde(0,"pmda204",'1',l_pmda.pmda204,g_pmdc_m.pmdc204) THEN
             LET r_success = FALSE
             RETURN r_success
          ELSE
             LET l_flag = TRUE   #有欄位變更，則更新為'Y'
          END IF
       ELSE
          IF NOT apmt835_del_pmde(0,"pmda204") THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF
     
      #配送中心
       IF (NOT cl_null(g_pmdc_m.pmdc205) AND (g_pmdc_m.pmdc205 != l_pmda.pmda205 OR cl_null(l_pmda.pmda205)))
          OR (cl_null(g_pmdc_m.pmdc205) AND NOT cl_null(l_pmda.pmda205))   THEN
          LET g_pmde007 = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001='"||l_pmda.pmda205||"' AND ooefl002=?"
          IF NOT apmt835_ins_pmde(0,"pmda205",'1',l_pmda.pmda205,g_pmdc_m.pmdc205) THEN
             LET r_success = FALSE
             RETURN r_success
          ELSE
             LET l_flag = TRUE   #有欄位變更，則更新為'Y'
          END IF
       ELSE
          IF NOT apmt835_del_pmde(0,"pmda205") THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF
       
       #配送倉
        IF (NOT cl_null(g_pmdc_m.pmdc206) AND (g_pmdc_m.pmdc206 != l_pmda.pmda206 OR cl_null(l_pmda.pmda206)))
          OR (cl_null(g_pmdc_m.pmdc206) AND NOT cl_null(l_pmda.pmda206))   THEN
          LET g_pmde007 = "SELECT inayl003 FROM inayl_t WHERE inaylent='"||g_enterprise||"' AND inayl001='"||l_pmda.pmda206||"' AND inayl002 = ?"
          IF NOT apmt835_ins_pmde(0,"pmda206",'1',l_pmda.pmda206,g_pmdc_m.pmdc206) THEN
             LET r_success = FALSE
             RETURN r_success
          ELSE
             LET l_flag = TRUE   #有欄位變更，則更新為'Y'
          END IF
       ELSE
          IF NOT apmt835_del_pmde(0,"pmda206") THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF
     
       
       #運送方式
       IF (NOT cl_null(g_pmdc_m.pmdc021) AND (g_pmdc_m.pmdc021 != l_pmda.pmda021 OR cl_null(l_pmda.pmda021)))
          OR (cl_null(g_pmdc_m.pmdc021) AND NOT cl_null(l_pmda.pmda021))   THEN
          LET g_pmde007 = "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='263' AND oocql002 ='"||l_pmda.pmda021||"' AND oocql003=?"
          IF NOT apmt835_ins_pmde(0,"pmda021",'1',l_pmda.pmda021,g_pmdc_m.pmdc021) THEN
             LET r_success = FALSE
             RETURN r_success
          ELSE
             LET l_flag = TRUE   #有欄位變更，則更新為'Y'
          END IF
       ELSE
          IF NOT apmt835_del_pmde(0,"pmda021") THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF
       
       #包裝總數量
        IF (NOT cl_null(g_pmdc_m.pmdc208) AND (g_pmdc_m.pmdc208 != l_pmda.pmda208 OR cl_null(l_pmda.pmda208)))
          OR (cl_null(g_pmdc_m.pmdc208) AND NOT cl_null(l_pmda.pmda208))   THEN
          IF NOT apmt835_ins_pmde(0,"pmda208",'1',l_pmda.pmda208,g_pmdc_m.pmdc208) THEN
             LET r_success = FALSE
             RETURN r_success
          ELSE
             LET l_flag = TRUE   #有欄位變更，則更新為'Y'
          END IF
       ELSE
          IF NOT apmt835_del_pmde(0,"pmda208") THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF
       
       
       #請購備註
       IF (NOT cl_null(g_pmdc_m.pmdc022) AND (g_pmdc_m.pmdc022 != l_pmda.pmda022 OR cl_null(l_pmda.pmda022)))
          OR (cl_null(g_pmdc_m.pmdc022) AND NOT cl_null(l_pmda.pmda022))   THEN
          IF NOT apmt835_ins_pmde(0,"pmda022",'1',l_pmda.pmda022,g_pmdc_m.pmdc022) THEN
             LET r_success = FALSE
             RETURN r_success
          ELSE
             LET l_flag = TRUE   #有欄位變更，則更新為'Y'
          END IF
       ELSE
          IF NOT apmt835_del_pmde(0,"pmda022") THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF
       
       IF l_flag THEN   #有欄位變更，則更新為'Y'
          UPDATE pmdc_t SET pmdc901 = 'Y' 
            WHERE pmdcent = g_enterprise 
              AND pmdcdocno = g_pmdc_m.pmdcdocno 
              AND pmdc900 = g_pmdc_m.pmdc900
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = "upd_pmdc901"
             LET g_errparam.popup = TRUE
             CALL cl_err()
  
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF
       
       RETURN r_success
       
END FUNCTION

################################################################################
# Descriptions...: 單位與要貨數量轉換
# Memo...........: 當要貨數量有值，由要貨數量轉換成包裝數量(要貨件數)
#                  當要貨數量為空，由包裝數量(要貨件數)轉換成要貨數量
# Usage..........: CALL apmt835_num_change()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/02/10 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt835_num_change()
DEFINE l_success        LIKE type_t.num5

    #當包裝單位或要貨單位都為空，表示無法轉換
    IF cl_null(g_pmdd_d[l_ac].pmdd201) OR cl_null(g_pmdd_d[l_ac].pmdd007) THEN
       RETURN
    END IF
    
    #當要貨數量為空
    IF cl_null(g_pmdd_d[l_ac].pmdd006) THEN
       #當包裝數量(要貨件數)為空
       IF cl_null(g_pmdd_d[l_ac].pmdd212) THEN
          RETURN
       ELSE
          #當要貨數量為空，由包裝數量(要貨件數)轉換成要貨數量
          CALL s_aooi250_convert_qty(g_pmdd_d[l_ac].pmdd004,g_pmdd_d[l_ac].pmdd201,g_pmdd_d[l_ac].pmdd007,g_pmdd_d[l_ac].pmdd212)
              RETURNING l_success,g_pmdd_d[l_ac].pmdd006
       END IF
    ELSE
       #當要貨數量有值，由要貨數量轉換成包裝數量(要貨件數)
       CALL s_aooi250_convert_qty(g_pmdd_d[l_ac].pmdd004,g_pmdd_d[l_ac].pmdd007,g_pmdd_d[l_ac].pmdd201,g_pmdd_d[l_ac].pmdd006)
           RETURNING l_success,g_pmdd_d[l_ac].pmdd212
    END IF
END FUNCTION

################################################################################
# Descriptions...: 取apmt830單身行狀態
# Memo...........:
# Usage..........: CALL apmt835_get_pmdb032(p_pmdcdocno,p_pmddseq)
#                  RETURNING r_pmdb032
# Input parameter: p_pmdcdocno   要貨單單號
#                : p_pmddseq     要貨單項次
# Return code....: r_pmdb032     要貨單單身行狀態
# Date & Author..: 2015/02/10 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt835_get_pmdb032(p_pmdcdocno,p_pmddseq)
DEFINE p_pmdcdocno    LIKE pmdc_t.pmdcdocno
DEFINE p_pmddseq      LIKE pmdd_t.pmddseq
DEFINE r_pmdb032      LIKE imaa_t.imaa005

   LET r_pmdb032 = ''
   SELECT pmdb032 INTO r_pmdb032 
     FROM pmdb_t 
    WHERE pmdbent = g_enterprise 
      AND pmdbdocno = p_pmdcdocno
      AND pmdbseq = p_pmddseq
      
   RETURN r_pmdb032
   
END FUNCTION

################################################################################
# Descriptions...: 由商品編號取得條碼(主條碼)
# Memo...........:
# Usage..........: CALL apmt835_get_pmdd200(p_pmdd004)
#                  RETURNING r_pmdd200
# Input parameter: p_pmdd004        商品編號
# Return code....: r_pmdd200        商品條碼   
# Date & Author..: 2015/06/17 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt835_get_pmdd200(p_pmdd004)
DEFINE p_pmdd004      LIKE pmdd_t.pmdd004
DEFINE r_pmdd200      LIKE pmdd_t.pmdd200

   LET r_pmdd200 = ''
   SELECT imaa014 INTO r_pmdd200 
     FROM imaa_t 
    WHERE imaaent = g_enterprise 
      AND imaa001 = p_pmdd004
      
   RETURN r_pmdd200
   
END FUNCTION

################################################################################
# Descriptions...: 單身要貨件數加總 顯示到單頭包裝總數量
# Memo...........:
# Usage..........: CALL apmt835_pmdd212_sum()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/03/17 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt835_pmdd212_sum()
   
   SELECT SUM(pmdd212) INTO g_pmdc_m.pmdc208 FROM pmdd_t  
    WHERE pmddent = g_enterprise 
	  AND pmdddocno = g_pmdc_m.pmdcdocno
     AND pmdd900 = g_pmdc_m.pmdc900
     
   DISPLAY BY NAME g_pmdc_m.pmdc208
   
END FUNCTION

################################################################################
# Descriptions...: 新增pmde異動資料
# Memo...........:
# Usage..........: CALL apmt835_pmdd_ins_pmde(p_pmdd901)
#                  RETURNING r_success
# Input parameter: p_pmdd901   單身變更類型
# Return code....: r_success   TRUE(FALSE) 
# Date & Author..: 2015/03/18 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt835_pmdd_ins_pmde(p_pmdd901)
DEFINE p_pmdd901  LIKE pmdd_t.pmdd901  #單身變更類型 1.未變更  2.單身修改 3.單身新增 4.單身已經結案不可變更
#161104-00002#11 161110 By rainy mod---(S) 
 #調整*寫法   
#DEFINE l_pmdb     RECORD LIKE pmdb_t.*
DEFINE l_pmdb RECORD  #請購單明細檔
       pmdbent LIKE pmdb_t.pmdbent, #企業編號
       pmdbsite LIKE pmdb_t.pmdbsite, #營運據點
       pmdbdocno LIKE pmdb_t.pmdbdocno, #請購單號
       pmdbseq LIKE pmdb_t.pmdbseq, #項次
       pmdb001 LIKE pmdb_t.pmdb001, #來源單號
       pmdb002 LIKE pmdb_t.pmdb002, #來源項次
       pmdb003 LIKE pmdb_t.pmdb003, #來源項序
       pmdb004 LIKE pmdb_t.pmdb004, #料件編號
       pmdb005 LIKE pmdb_t.pmdb005, #產品特徵
       pmdb006 LIKE pmdb_t.pmdb006, #需求數量
       pmdb007 LIKE pmdb_t.pmdb007, #單位
       pmdb008 LIKE pmdb_t.pmdb008, #參考數量
       pmdb009 LIKE pmdb_t.pmdb009, #參考單位
       pmdb010 LIKE pmdb_t.pmdb010, #計價數量
       pmdb011 LIKE pmdb_t.pmdb011, #計價單位
       pmdb012 LIKE pmdb_t.pmdb012, #包裝容器
       pmdb014 LIKE pmdb_t.pmdb014, #供應商選擇
       pmdb015 LIKE pmdb_t.pmdb015, #供應商編號
       pmdb016 LIKE pmdb_t.pmdb016, #付款條件
       pmdb017 LIKE pmdb_t.pmdb017, #交易條件
       pmdb018 LIKE pmdb_t.pmdb018, #稅率
       pmdb019 LIKE pmdb_t.pmdb019, #參考單價
       pmdb020 LIKE pmdb_t.pmdb020, #參考未稅金額
       pmdb021 LIKE pmdb_t.pmdb021, #參考含稅金額
       pmdb030 LIKE pmdb_t.pmdb030, #需求日期
       pmdb031 LIKE pmdb_t.pmdb031, #理由碼
       pmdb032 LIKE pmdb_t.pmdb032, #行狀態
       pmdb033 LIKE pmdb_t.pmdb033, #緊急度
       pmdb034 LIKE pmdb_t.pmdb034, #專案編號
       pmdb035 LIKE pmdb_t.pmdb035, #WBS
       pmdb036 LIKE pmdb_t.pmdb036, #活動編號
       pmdb037 LIKE pmdb_t.pmdb037, #收貨據點
       pmdb038 LIKE pmdb_t.pmdb038, #收貨庫位
       pmdb039 LIKE pmdb_t.pmdb039, #收貨儲位
       pmdb040 LIKE pmdb_t.pmdb040, #no use
       pmdb041 LIKE pmdb_t.pmdb041, #允許部份交貨
       pmdb042 LIKE pmdb_t.pmdb042, #允許提前交貨
       pmdb043 LIKE pmdb_t.pmdb043, #保稅
       pmdb044 LIKE pmdb_t.pmdb044, #納入APS
       pmdb045 LIKE pmdb_t.pmdb045, #交期凍結否
       pmdb046 LIKE pmdb_t.pmdb046, #費用部門
       pmdb048 LIKE pmdb_t.pmdb048, #收貨時段
       pmdb049 LIKE pmdb_t.pmdb049, #已轉採購量
       pmdb050 LIKE pmdb_t.pmdb050, #備註
       pmdb051 LIKE pmdb_t.pmdb051, #結案/留置理由碼
       pmdb200 LIKE pmdb_t.pmdb200, #商品條碼
       pmdb201 LIKE pmdb_t.pmdb201, #包裝單位
       pmdb202 LIKE pmdb_t.pmdb202, #件裝數
       pmdb203 LIKE pmdb_t.pmdb203, #配送中心
       pmdb204 LIKE pmdb_t.pmdb204, #配送倉庫
       pmdb205 LIKE pmdb_t.pmdb205, #採購中心
       pmdb206 LIKE pmdb_t.pmdb206, #採購員
       pmdb207 LIKE pmdb_t.pmdb207, #採購方式
       pmdb208 LIKE pmdb_t.pmdb208, #經營方式
       pmdb209 LIKE pmdb_t.pmdb209, #結算方式
       pmdb210 LIKE pmdb_t.pmdb210, #促銷開始日
       pmdb211 LIKE pmdb_t.pmdb211, #促銷結束日
       pmdb212 LIKE pmdb_t.pmdb212, #要貨件數
       pmdb250 LIKE pmdb_t.pmdb250, #合理庫存
       pmdb251 LIKE pmdb_t.pmdb251, #最高庫存
       pmdb252 LIKE pmdb_t.pmdb252, #現有庫存
       pmdb253 LIKE pmdb_t.pmdb253, #入庫在途量
       pmdb254 LIKE pmdb_t.pmdb254, #前一週銷量
       pmdb255 LIKE pmdb_t.pmdb255, #前二週銷量
       pmdb256 LIKE pmdb_t.pmdb256, #前三週銷量
       pmdb257 LIKE pmdb_t.pmdb257, #前四週銷量
       pmdb258 LIKE pmdb_t.pmdb258, #要貨在途量
       pmdb259 LIKE pmdb_t.pmdb259, #週平均銷量
       pmdb900 LIKE pmdb_t.pmdb900, #保留欄位str
       pmdb999 LIKE pmdb_t.pmdb999, #保留欄位end
       pmdbud001 LIKE pmdb_t.pmdbud001, #自定義欄位(文字)001
       pmdbud002 LIKE pmdb_t.pmdbud002, #自定義欄位(文字)002
       pmdbud003 LIKE pmdb_t.pmdbud003, #自定義欄位(文字)003
       pmdbud004 LIKE pmdb_t.pmdbud004, #自定義欄位(文字)004
       pmdbud005 LIKE pmdb_t.pmdbud005, #自定義欄位(文字)005
       pmdbud006 LIKE pmdb_t.pmdbud006, #自定義欄位(文字)006
       pmdbud007 LIKE pmdb_t.pmdbud007, #自定義欄位(文字)007
       pmdbud008 LIKE pmdb_t.pmdbud008, #自定義欄位(文字)008
       pmdbud009 LIKE pmdb_t.pmdbud009, #自定義欄位(文字)009
       pmdbud010 LIKE pmdb_t.pmdbud010, #自定義欄位(文字)010
       pmdbud011 LIKE pmdb_t.pmdbud011, #自定義欄位(數字)011
       pmdbud012 LIKE pmdb_t.pmdbud012, #自定義欄位(數字)012
       pmdbud013 LIKE pmdb_t.pmdbud013, #自定義欄位(數字)013
       pmdbud014 LIKE pmdb_t.pmdbud014, #自定義欄位(數字)014
       pmdbud015 LIKE pmdb_t.pmdbud015, #自定義欄位(數字)015
       pmdbud016 LIKE pmdb_t.pmdbud016, #自定義欄位(數字)016
       pmdbud017 LIKE pmdb_t.pmdbud017, #自定義欄位(數字)017
       pmdbud018 LIKE pmdb_t.pmdbud018, #自定義欄位(數字)018
       pmdbud019 LIKE pmdb_t.pmdbud019, #自定義欄位(數字)019
       pmdbud020 LIKE pmdb_t.pmdbud020, #自定義欄位(數字)020
       pmdbud021 LIKE pmdb_t.pmdbud021, #自定義欄位(日期時間)021
       pmdbud022 LIKE pmdb_t.pmdbud022, #自定義欄位(日期時間)022
       pmdbud023 LIKE pmdb_t.pmdbud023, #自定義欄位(日期時間)023
       pmdbud024 LIKE pmdb_t.pmdbud024, #自定義欄位(日期時間)024
       pmdbud025 LIKE pmdb_t.pmdbud025, #自定義欄位(日期時間)025
       pmdbud026 LIKE pmdb_t.pmdbud026, #自定義欄位(日期時間)026
       pmdbud027 LIKE pmdb_t.pmdbud027, #自定義欄位(日期時間)027
       pmdbud028 LIKE pmdb_t.pmdbud028, #自定義欄位(日期時間)028
       pmdbud029 LIKE pmdb_t.pmdbud029, #自定義欄位(日期時間)029
       pmdbud030 LIKE pmdb_t.pmdbud030, #自定義欄位(日期時間)030
       pmdb260 LIKE pmdb_t.pmdb260, #收貨部門
       pmdb052 LIKE pmdb_t.pmdb052, #來源分批序
       pmdb227 LIKE pmdb_t.pmdb227, #補貨規格說明
       pmdb053 LIKE pmdb_t.pmdb053, #預算細項
       pmdb213 LIKE pmdb_t.pmdb213, #參考進價
       pmdb054 LIKE pmdb_t.pmdb054, #庫存管理特徵
       pmdb214 LIKE pmdb_t.pmdb214  #需求時間
END RECORD
#161104-00002#11 161110 By rainy mod---(E) 
DEFINE r_success  LIKE type_t.num5


       LET r_success = TRUE
       
       INITIALIZE l_pmdb.* TO NULL
       
       #類型為'3':單身新增或'2':單身修改
       IF p_pmdd901 = '2' OR p_pmdd901 = '4' THEN    
           SELECT pmdbseq,pmdb001,pmdb002,pmdb003,pmdbsite,pmdb200,
                  pmdb004,pmdb037,pmdb260,pmdb038,pmdb201,pmdb202,pmdb212,
                  pmdb006,pmdb007,pmdb207,pmdb015,pmdb049,pmdb030,
                  pmdb048,pmdb208,pmdb209,pmdb206,pmdb210,pmdb211,
                  pmdb205,pmdb203,pmdb204,
                  pmdb005,pmdb253,pmdb258, #sakura add
                  pmdb254,pmdb255,pmdb256,pmdb257,pmdb259,pmdb252, #sakura add
                  pmdb033                  #150324-00006#14 2015/04/09 By pomelo add
            INTO  l_pmdb.pmdbseq,l_pmdb.pmdb001,l_pmdb.pmdb002,l_pmdb.pmdb003,l_pmdb.pmdbsite,l_pmdb.pmdb200,
                  l_pmdb.pmdb004,l_pmdb.pmdb037,l_pmdb.pmdb260,l_pmdb.pmdb038,l_pmdb.pmdb201,l_pmdb.pmdb202,l_pmdb.pmdb212,
                  l_pmdb.pmdb006,l_pmdb.pmdb007,l_pmdb.pmdb207,l_pmdb.pmdb015,l_pmdb.pmdb049,l_pmdb.pmdb030,
                  l_pmdb.pmdb048,l_pmdb.pmdb208,l_pmdb.pmdb209,l_pmdb.pmdb206,l_pmdb.pmdb210,l_pmdb.pmdb211,
                  l_pmdb.pmdb205,l_pmdb.pmdb203,l_pmdb.pmdb204,
                  l_pmdb.pmdb005,l_pmdb.pmdb253,l_pmdb.pmdb258, #sakura add
                  l_pmdb.pmdb254,l_pmdb.pmdb255,l_pmdb.pmdb256,l_pmdb.pmdb257,l_pmdb.pmdb259,l_pmdb.pmdb252, #sakura add
                  l_pmdb.pmdb033            #150324-00006#14 2015/04/09 By pomelo add
             FROM pmdb_t
              WHERE pmdbent = g_enterprise 
                AND pmdbdocno = g_pmdc_m.pmdcdocno 
                AND pmdbseq = g_pmdd_d[l_ac].pmddseq
       END IF
       
      #針對該項次所有單身欄位同步新增[T:請購變更歷程檔]
	    #類型為'3':單身新增
       IF p_pmdd901 = '3' THEN
          IF NOT apmt835_ins_pmde(g_pmdd_d[l_ac].pmddseq,"pmddseq",p_pmdd901,NULL,g_pmdd_d[l_ac].pmddseq) THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF
       
       #來源單號
       IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd001) AND (g_pmdd_d[l_ac].pmdd001 != l_pmdb.pmdb001 OR cl_null(l_pmdb.pmdb001))) OR (cl_null(g_pmdd_d[l_ac].pmdd001) AND NOT cl_null(l_pmdb.pmdb001)))) THEN
          IF NOT apmt835_ins_pmde(g_pmdd_d[l_ac].pmddseq,"pmdb001",p_pmdd901,l_pmdb.pmdb001,g_pmdd_d[l_ac].pmdd001) THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF
       
       #來源項次
       IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd002) AND (g_pmdd_d[l_ac].pmdd002 != l_pmdb.pmdb002 OR cl_null(l_pmdb.pmdb002))) OR (cl_null(g_pmdd_d[l_ac].pmdd002) AND NOT cl_null(l_pmdb.pmdb002)))) THEN
          IF NOT apmt835_ins_pmde(g_pmdd_d[l_ac].pmddseq,"pmdb002",p_pmdd901,l_pmdb.pmdb002,g_pmdd_d[l_ac].pmdd002) THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF
      
       #來源項序
       IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd003) AND (g_pmdd_d[l_ac].pmdd003 != l_pmdb.pmdb003 OR cl_null(l_pmdb.pmdb003))) OR (cl_null(g_pmdd_d[l_ac].pmdd003) AND NOT cl_null(l_pmdb.pmdb003)))) THEN
          IF NOT apmt835_ins_pmde(g_pmdd_d[l_ac].pmddseq,"pmdb003",p_pmdd901,l_pmdb.pmdb003,g_pmdd_d[l_ac].pmdd003) THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF
      
      
       #需求組織
       IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmddsite) AND (g_pmdd_d[l_ac].pmddsite != l_pmdb.pmdbsite OR cl_null(l_pmdb.pmdbsite))) OR (cl_null(g_pmdd_d[l_ac].pmddsite) AND NOT cl_null(l_pmdb.pmdbsite)))) THEN
          IF NOT apmt835_ins_pmde(g_pmdd_d[l_ac].pmddseq,"pmdbsite",p_pmdd901,l_pmdb.pmdbsite,g_pmdd_d[l_ac].pmddsite) THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF
       
       #商品條碼
       IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd200) AND (g_pmdd_d[l_ac].pmdd200 != l_pmdb.pmdb200 OR cl_null(l_pmdb.pmdb200))) OR (cl_null(g_pmdd_d[l_ac].pmdd200) AND NOT cl_null(l_pmdb.pmdb200)))) THEN
          IF NOT apmt835_ins_pmde(g_pmdd_d[l_ac].pmddseq,"pmdb200",p_pmdd901,l_pmdb.pmdb200,g_pmdd_d[l_ac].pmdd200) THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF
      
      
       #商品編號
       IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd004) AND (g_pmdd_d[l_ac].pmdd004 != l_pmdb.pmdb004 OR cl_null(l_pmdb.pmdb004))) OR (cl_null(g_pmdd_d[l_ac].pmdd004) AND NOT cl_null(l_pmdb.pmdb004)))) THEN
          LET g_pmde007 = "SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001='"||l_pmdb.pmdb004||"' AND imaal002=?"
          IF NOT apmt835_ins_pmde(g_pmdd_d[l_ac].pmddseq,"pmdb004",p_pmdd901,l_pmdb.pmdb004,g_pmdd_d[l_ac].pmdd004) THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF
       
     
       #收貨組織
       IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd037) AND (g_pmdd_d[l_ac].pmdd037 != l_pmdb.pmdb037 OR cl_null(l_pmdb.pmdb037))) OR (cl_null(g_pmdd_d[l_ac].pmdd037) AND NOT cl_null(l_pmdb.pmdb037)))) THEN
          LET g_pmde007 = "SELECT ooefl004 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001='"||l_pmdb.pmdb037||"' AND ooefl002=?"
          IF NOT apmt835_ins_pmde(g_pmdd_d[l_ac].pmddseq,"pmdb037",p_pmdd901,l_pmdb.pmdb037,g_pmdd_d[l_ac].pmdd037) THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF
       
       #收貨部門
       IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd260) AND (g_pmdd_d[l_ac].pmdd260 != l_pmdb.pmdb260 OR cl_null(l_pmdb.pmdb260))) OR (cl_null(g_pmdd_d[l_ac].pmdd260) AND NOT cl_null(l_pmdb.pmdb260)))) THEN
          LET g_pmde007 = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001='"||l_pmdb.pmdb260||"' AND ooefl002=?"
          IF NOT apmt835_ins_pmde(g_pmdd_d[l_ac].pmddseq,"pmdb260",p_pmdd901,l_pmdb.pmdb260,g_pmdd_d[l_ac].pmdd260) THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF      

       #庫位編號
       IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd038) AND (g_pmdd_d[l_ac].pmdd038 != l_pmdb.pmdb038 OR cl_null(l_pmdb.pmdb038))) OR (cl_null(g_pmdd_d[l_ac].pmdd038) AND NOT cl_null(l_pmdb.pmdb038)))) THEN
          LET g_pmde007 = "SELECT inayl003 FROM inayl_t WHERE inaylent='"||g_enterprise||"' AND inayl002 = ? AND inayl001='"||l_pmdb.pmdb038||"' "
          IF NOT apmt835_ins_pmde(g_pmdd_d[l_ac].pmddseq,"pmdb038",p_pmdd901,l_pmdb.pmdb038,g_pmdd_d[l_ac].pmdd038) THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF
       


       #包裝單位
        IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd201) AND (g_pmdd_d[l_ac].pmdd201 != l_pmdb.pmdb201 OR cl_null(l_pmdb.pmdb201))) OR (cl_null(g_pmdd_d[l_ac].pmdd201) AND NOT cl_null(l_pmdb.pmdb201)))) THEN
          IF NOT apmt835_ins_pmde(g_pmdd_d[l_ac].pmddseq,"pmdb201",p_pmdd901,l_pmdb.pmdb201,g_pmdd_d[l_ac].pmdd201) THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF
       
       #件裝數
       IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd202) AND (g_pmdd_d[l_ac].pmdd202 != l_pmdb.pmdb202 OR cl_null(l_pmdb.pmdb202))) OR (cl_null(g_pmdd_d[l_ac].pmdd202) AND NOT cl_null(l_pmdb.pmdb202)))) THEN
          IF NOT apmt835_ins_pmde(g_pmdd_d[l_ac].pmddseq,"pmdb202",p_pmdd901,l_pmdb.pmdb202,g_pmdd_d[l_ac].pmdd202) THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF
       
       #要貨件數
        IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd212) AND (g_pmdd_d[l_ac].pmdd212 != l_pmdb.pmdb212 OR cl_null(l_pmdb.pmdb212))) OR (cl_null(g_pmdd_d[l_ac].pmdd212) AND NOT cl_null(l_pmdb.pmdb212)))) THEN
          IF NOT apmt835_ins_pmde(g_pmdd_d[l_ac].pmddseq,"pmdb212",p_pmdd901,l_pmdb.pmdb212,g_pmdd_d[l_ac].pmdd212) THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF
       
       #要貨數量
        IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd006) AND (g_pmdd_d[l_ac].pmdd006 != l_pmdb.pmdb006 OR cl_null(l_pmdb.pmdb006))) OR (cl_null(g_pmdd_d[l_ac].pmdd006) AND NOT cl_null(l_pmdb.pmdb006)))) THEN
          IF NOT apmt835_ins_pmde(g_pmdd_d[l_ac].pmddseq,"pmdb006",p_pmdd901,l_pmdb.pmdb006,g_pmdd_d[l_ac].pmdd006) THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF 
        
       #單位
       IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd007) AND (g_pmdd_d[l_ac].pmdd007 != l_pmdb.pmdb007 OR cl_null(l_pmdb.pmdb007))) OR (cl_null(g_pmdd_d[l_ac].pmdd007) AND NOT cl_null(l_pmdb.pmdb007)))) THEN
          LET g_pmde007 = "SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001='"||l_pmdb.pmdb007||"' AND oocal002=?"
          IF NOT apmt835_ins_pmde(g_pmdd_d[l_ac].pmddseq,"pmdb007",p_pmdd901,l_pmdb.pmdb007,g_pmdd_d[l_ac].pmdd007) THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF
       
       #採購類型
        IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd207) AND (g_pmdd_d[l_ac].pmdd207 != l_pmdb.pmdb207 OR cl_null(l_pmdb.pmdb207))) OR (cl_null(g_pmdd_d[l_ac].pmdd207) AND NOT cl_null(l_pmdb.pmdb207)))) THEN
          IF NOT apmt835_ins_pmde(g_pmdd_d[l_ac].pmddseq,"pmdb207",p_pmdd901,l_pmdb.pmdb207,g_pmdd_d[l_ac].pmdd207) THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF 
       
       #供應商編號
       IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd015) AND (g_pmdd_d[l_ac].pmdd015 != l_pmdb.pmdb015 OR cl_null(l_pmdb.pmdb015))) OR (cl_null(g_pmdd_d[l_ac].pmdd015) AND NOT cl_null(l_pmdb.pmdb015)))) THEN
          LET g_pmde007 = "SELECT pmaal003 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001='"||l_pmdb.pmdb015||"' AND pmaal002=?"
          IF NOT apmt835_ins_pmde(g_pmdd_d[l_ac].pmddseq,"pmdb015",p_pmdd901,l_pmdb.pmdb015,g_pmdd_d[l_ac].pmdd015) THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF 
       
       #已轉採購量
        IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd049) AND (g_pmdd_d[l_ac].pmdd049 != l_pmdb.pmdb049 OR cl_null(l_pmdb.pmdb049))) OR (cl_null(g_pmdd_d[l_ac].pmdd049) AND NOT cl_null(l_pmdb.pmdb049)))) THEN
          IF NOT apmt835_ins_pmde(g_pmdd_d[l_ac].pmddseq,"pmdb049",p_pmdd901,l_pmdb.pmdb049,g_pmdd_d[l_ac].pmdd049) THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF
       
      #需求日期
       IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd030) AND (g_pmdd_d[l_ac].pmdd030 != l_pmdb.pmdb030 OR cl_null(l_pmdb.pmdb030))) OR (cl_null(g_pmdd_d[l_ac].pmdd030) AND NOT cl_null(l_pmdb.pmdb030)))) THEN
          IF NOT apmt835_ins_pmde(g_pmdd_d[l_ac].pmddseq,"pmdb030",p_pmdd901,l_pmdb.pmdb030,g_pmdd_d[l_ac].pmdd030) THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF
       
       #收貨時段
       IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd048) AND (g_pmdd_d[l_ac].pmdd048 != l_pmdb.pmdb048 OR cl_null(l_pmdb.pmdb048))) OR (cl_null(g_pmdd_d[l_ac].pmdd048) AND NOT cl_null(l_pmdb.pmdb048)))) THEN
         LET g_pmde007 = "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='"||l_pmdb.pmdb048||"' AND oocql002='274' AND oocql003 = ?" 
         IF NOT apmt835_ins_pmde(g_pmdd_d[l_ac].pmddseq,"pmdb048",p_pmdd901,l_pmdb.pmdb048,g_pmdd_d[l_ac].pmdd048) THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF
      
       #經營方式
        IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd208) AND (g_pmdd_d[l_ac].pmdd208 != l_pmdb.pmdb208 OR cl_null(l_pmdb.pmdb208))) OR (cl_null(g_pmdd_d[l_ac].pmdd208) AND NOT cl_null(l_pmdb.pmdb208)))) THEN
         IF NOT apmt835_ins_pmde(g_pmdd_d[l_ac].pmddseq,"pmdb208",p_pmdd901,l_pmdb.pmdb208,g_pmdd_d[l_ac].pmdd208) THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF
      
       #結算方式
        IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd209) AND (g_pmdd_d[l_ac].pmdd209 != l_pmdb.pmdb209 OR cl_null(l_pmdb.pmdb209))) OR (cl_null(g_pmdd_d[l_ac].pmdd209) AND NOT cl_null(l_pmdb.pmdb209)))) THEN
         LET g_pmde007 = "SELECT staal003 FROM staal_t WHERE staalent='"||g_enterprise||"' AND staal001='"||l_pmdb.pmdb209||"' AND staal002= ?" 
         IF NOT apmt835_ins_pmde(g_pmdd_d[l_ac].pmddseq,"pmdb209",p_pmdd901,l_pmdb.pmdb209,g_pmdd_d[l_ac].pmdd209) THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF
      
       #採購員
        IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd206) AND (g_pmdd_d[l_ac].pmdd206 != l_pmdb.pmdb206 OR cl_null(l_pmdb.pmdb206))) OR (cl_null(g_pmdd_d[l_ac].pmdd206) AND NOT cl_null(l_pmdb.pmdb206)))) THEN
         LET g_pmde007 = "SELECT oofa011 FROM oofa_t WHERE oofaent='"||g_enterprise||"' AND oofa003='"||l_pmdb.pmdb206||"' AND oofa002='2'" 
         IF NOT apmt835_ins_pmde(g_pmdd_d[l_ac].pmddseq,"pmdb206",p_pmdd901,l_pmdb.pmdb206,g_pmdd_d[l_ac].pmdd206) THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF
       
       
       #促銷開始日
       IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd210) AND (g_pmdd_d[l_ac].pmdd210 != l_pmdb.pmdb210 OR cl_null(l_pmdb.pmdb210))) OR (cl_null(g_pmdd_d[l_ac].pmdd210) AND NOT cl_null(l_pmdb.pmdb210)))) THEN   
         IF NOT apmt835_ins_pmde(g_pmdd_d[l_ac].pmddseq,"pmdb210",p_pmdd901,l_pmdb.pmdb210,g_pmdd_d[l_ac].pmdd210) THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF
       
       #促銷結束日
        IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd211) AND (g_pmdd_d[l_ac].pmdd211 != l_pmdb.pmdb211 OR cl_null(l_pmdb.pmdb211))) OR (cl_null(g_pmdd_d[l_ac].pmdd211) AND NOT cl_null(l_pmdb.pmdb211)))) THEN   
         IF NOT apmt835_ins_pmde(g_pmdd_d[l_ac].pmddseq,"pmdb211",p_pmdd901,l_pmdb.pmdb211,g_pmdd_d[l_ac].pmdd211) THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF
       
       #採購中心
       IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd205) AND (g_pmdd_d[l_ac].pmdd205 != l_pmdb.pmdb205 OR cl_null(l_pmdb.pmdb205))) OR (cl_null(g_pmdd_d[l_ac].pmdd205) AND NOT cl_null(l_pmdb.pmdb205)))) THEN   
          LET g_pmde007 = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001='"||l_pmdb.pmdb205||"' AND ooefl002= ?" 
          IF NOT apmt835_ins_pmde(g_pmdd_d[l_ac].pmddseq,"pmdb205",p_pmdd901,l_pmdb.pmdb205,g_pmdd_d[l_ac].pmdd205) THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF
       
       #配送中心
        IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd203) AND (g_pmdd_d[l_ac].pmdd203 != l_pmdb.pmdb203 OR cl_null(l_pmdb.pmdb203))) OR (cl_null(g_pmdd_d[l_ac].pmdd203) AND NOT cl_null(l_pmdb.pmdb203)))) THEN   
          LET g_pmde007 = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001='"||l_pmdb.pmdb203||"' AND ooefl002= ?" 
          IF NOT apmt835_ins_pmde(g_pmdd_d[l_ac].pmddseq,"pmdb203",p_pmdd901,l_pmdb.pmdb203,g_pmdd_d[l_ac].pmdd203) THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF
       
       #配送倉庫
        IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd204) AND (g_pmdd_d[l_ac].pmdd204 != l_pmdb.pmdb204 OR cl_null(l_pmdb.pmdb204))) OR (cl_null(g_pmdd_d[l_ac].pmdd204) AND NOT cl_null(l_pmdb.pmdb204)))) THEN
          LET g_pmde007 = "SELECT inayl003 FROM inayl_t WHERE inaylent='"||g_enterprise||"' AND inayl002= ? AND inayl001='"||l_pmdb.pmdb204||"' "
          IF NOT apmt835_ins_pmde(g_pmdd_d[l_ac].pmddseq,"pmdb204",p_pmdd901,l_pmdb.pmdb204,g_pmdd_d[l_ac].pmdd204) THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF

       #產品特徵
        IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd005) AND (g_pmdd_d[l_ac].pmdd005 != l_pmdb.pmdb005 OR cl_null(l_pmdb.pmdb005))) OR (cl_null(g_pmdd_d[l_ac].pmdd005) AND NOT cl_null(l_pmdb.pmdb005)))) THEN
          IF NOT apmt835_ins_pmde(g_pmdd_d[l_ac].pmddseq,"pmdb005",p_pmdd901,l_pmdb.pmdb005,g_pmdd_d[l_ac].pmdd005) THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF
       
       #入庫在途量
        IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd253) AND (g_pmdd_d[l_ac].pmdd253 != l_pmdb.pmdb253 OR cl_null(l_pmdb.pmdb253))) OR (cl_null(g_pmdd_d[l_ac].pmdd253) AND NOT cl_null(l_pmdb.pmdb253)))) THEN
          IF NOT apmt835_ins_pmde(g_pmdd_d[l_ac].pmddseq,"pmdb253",p_pmdd901,l_pmdb.pmdb253,g_pmdd_d[l_ac].pmdd253) THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF
       #要貨在途量
        IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd258) AND (g_pmdd_d[l_ac].pmdd258 != l_pmdb.pmdb258 OR cl_null(l_pmdb.pmdb258))) OR (cl_null(g_pmdd_d[l_ac].pmdd258) AND NOT cl_null(l_pmdb.pmdb258)))) THEN
          IF NOT apmt835_ins_pmde(g_pmdd_d[l_ac].pmddseq,"pmdb258",p_pmdd901,l_pmdb.pmdb258,g_pmdd_d[l_ac].pmdd258) THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF
       #前一週銷量
        IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd254) AND (g_pmdd_d[l_ac].pmdd254 != l_pmdb.pmdb254 OR cl_null(l_pmdb.pmdb254))) OR (cl_null(g_pmdd_d[l_ac].pmdd254) AND NOT cl_null(l_pmdb.pmdb254)))) THEN
          IF NOT apmt835_ins_pmde(g_pmdd_d[l_ac].pmddseq,"pmdb254",p_pmdd901,l_pmdb.pmdb254,g_pmdd_d[l_ac].pmdd254) THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF       
       #前二週銷量
        IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd255) AND (g_pmdd_d[l_ac].pmdd255 != l_pmdb.pmdb255 OR cl_null(l_pmdb.pmdb255))) OR (cl_null(g_pmdd_d[l_ac].pmdd255) AND NOT cl_null(l_pmdb.pmdb255)))) THEN
          IF NOT apmt835_ins_pmde(g_pmdd_d[l_ac].pmddseq,"pmdb255",p_pmdd901,l_pmdb.pmdb255,g_pmdd_d[l_ac].pmdd255) THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF
       #前三週銷量
        IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd256) AND (g_pmdd_d[l_ac].pmdd256 != l_pmdb.pmdb256 OR cl_null(l_pmdb.pmdb256))) OR (cl_null(g_pmdd_d[l_ac].pmdd256) AND NOT cl_null(l_pmdb.pmdb256)))) THEN
          IF NOT apmt835_ins_pmde(g_pmdd_d[l_ac].pmddseq,"pmdb256",p_pmdd901,l_pmdb.pmdb256,g_pmdd_d[l_ac].pmdd256) THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF
       #前四週銷量
        IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd257) AND (g_pmdd_d[l_ac].pmdd257 != l_pmdb.pmdb257 OR cl_null(l_pmdb.pmdb257))) OR (cl_null(g_pmdd_d[l_ac].pmdd257) AND NOT cl_null(l_pmdb.pmdb257)))) THEN
          IF NOT apmt835_ins_pmde(g_pmdd_d[l_ac].pmddseq,"pmdb257",p_pmdd901,l_pmdb.pmdb257,g_pmdd_d[l_ac].pmdd257) THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF
       #週平均銷量
        IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd259) AND (g_pmdd_d[l_ac].pmdd259 != l_pmdb.pmdb259 OR cl_null(l_pmdb.pmdb259))) OR (cl_null(g_pmdd_d[l_ac].pmdd259) AND NOT cl_null(l_pmdb.pmdb259)))) THEN
          IF NOT apmt835_ins_pmde(g_pmdd_d[l_ac].pmddseq,"pmdb259",p_pmdd901,l_pmdb.pmdb259,g_pmdd_d[l_ac].pmdd259) THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF
       #現有庫存
        IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd252) AND (g_pmdd_d[l_ac].pmdd252 != l_pmdb.pmdb252 OR cl_null(l_pmdb.pmdb252))) OR (cl_null(g_pmdd_d[l_ac].pmdd252) AND NOT cl_null(l_pmdb.pmdb252)))) THEN
          IF NOT apmt835_ins_pmde(g_pmdd_d[l_ac].pmddseq,"pmdb252",p_pmdd901,l_pmdb.pmdb252,g_pmdd_d[l_ac].pmdd252) THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF       
       
       RETURN r_success
       
END FUNCTION

################################################################################
# Descriptions...: 新增異動檔
# Memo...........:
# Usage..........: CALL apmt835_ins_pmde(p_pmdeseq,p_pmde002,p_pmde003,p_pmde004,p_pmde005)
#                  RETURNING r_success
# Input parameter: p_pmdeseq   變更歷程:請購項次
#                : p_pmde002   變更歷程:變更欄位
#                : p_pmde003   變更歷程:變更類型
#                : p_pmde004   變更歷程:變更前內容
#                : p_pmde005   變更歷程:變更後內容
# Return code....: r_success   TRUE(FALSE)
# Date & Author..: 2015/03/16 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt835_ins_pmde(p_pmdeseq,p_pmde002,p_pmde003,p_pmde004,p_pmde005)
DEFINE p_pmdeseq   LIKE pmde_t.pmdeseq   #請購項次
DEFINE p_pmde002   LIKE pmde_t.pmde002   #變更欄位
DEFINE p_pmde003   LIKE pmde_t.pmde003   #變更類型
DEFINE p_pmde004   LIKE pmde_t.pmde004   #變更前內容
DEFINE p_pmde005   LIKE pmde_t.pmde005   #變更後內容
DEFINE l_pmde006   LIKE pmde_t.pmde006   #最後變更時間
DEFINE r_success   LIKE type_t.num5

       LET r_success = TRUE
       
       LET l_pmde006 = cl_get_current()
       
       DELETE FROM pmde_t 
          WHERE pmdeent = g_enterprise 
	         AND pmdedocno = g_pmdc_m.pmdcdocno 
				AND pmde001 = g_pmdc_m.pmdc900 
				AND pmdeseq = p_pmdeseq 
				AND pmde002 = p_pmde002
       
       INSERT INTO pmde_t (pmdeent,pmdesite,pmdedocno,pmdeseq,
                           pmde001,pmde002,pmde003,pmde004,
                           pmde005,pmde006,pmde007,pmdeownid,
						         pmdeowndp,pmdecrtid,pmdecrtdp,pmdecrtdt)
                   VALUES (g_enterprise,g_pmdc_m.pmdcsite,g_pmdc_m.pmdcdocno,p_pmdeseq,
                           g_pmdc_m.pmdc900,p_pmde002,p_pmde003,p_pmde004,p_pmde005,
                           l_pmde006,g_pmde007,g_user,g_dept,g_user,g_dept,l_pmde006)       
       
       LET g_pmde007 = NULL
       
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = "pmde_t"
          LET g_errparam.popup = TRUE
          CALL cl_err()
  
          LET r_success = FALSE
          RETURN r_success
       END IF
       RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 單身文字的顏色顯示
# Memo...........:
# Usage..........: CALL apmt835_detail_color(p_pmdd901)
# Input parameter: p_pmdd901 單身變更類型
# Return code....: 無
# Date & Author..: 2015/03/16 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt835_detail_color(p_pmdd901)
DEFINE p_pmdd901  LIKE pmdd_t.pmdd901  #單身變更類型
#161104-00002#11 161110 By rainy mod---(S) 
 #調整*寫法   
#DEFINE l_pmdb     RECORD LIKE pmdb_t.*
DEFINE l_pmdb RECORD  #請購單明細檔
       pmdbent LIKE pmdb_t.pmdbent, #企業編號
       pmdbsite LIKE pmdb_t.pmdbsite, #營運據點
       pmdbdocno LIKE pmdb_t.pmdbdocno, #請購單號
       pmdbseq LIKE pmdb_t.pmdbseq, #項次
       pmdb001 LIKE pmdb_t.pmdb001, #來源單號
       pmdb002 LIKE pmdb_t.pmdb002, #來源項次
       pmdb003 LIKE pmdb_t.pmdb003, #來源項序
       pmdb004 LIKE pmdb_t.pmdb004, #料件編號
       pmdb005 LIKE pmdb_t.pmdb005, #產品特徵
       pmdb006 LIKE pmdb_t.pmdb006, #需求數量
       pmdb007 LIKE pmdb_t.pmdb007, #單位
       pmdb008 LIKE pmdb_t.pmdb008, #參考數量
       pmdb009 LIKE pmdb_t.pmdb009, #參考單位
       pmdb010 LIKE pmdb_t.pmdb010, #計價數量
       pmdb011 LIKE pmdb_t.pmdb011, #計價單位
       pmdb012 LIKE pmdb_t.pmdb012, #包裝容器
       pmdb014 LIKE pmdb_t.pmdb014, #供應商選擇
       pmdb015 LIKE pmdb_t.pmdb015, #供應商編號
       pmdb016 LIKE pmdb_t.pmdb016, #付款條件
       pmdb017 LIKE pmdb_t.pmdb017, #交易條件
       pmdb018 LIKE pmdb_t.pmdb018, #稅率
       pmdb019 LIKE pmdb_t.pmdb019, #參考單價
       pmdb020 LIKE pmdb_t.pmdb020, #參考未稅金額
       pmdb021 LIKE pmdb_t.pmdb021, #參考含稅金額
       pmdb030 LIKE pmdb_t.pmdb030, #需求日期
       pmdb031 LIKE pmdb_t.pmdb031, #理由碼
       pmdb032 LIKE pmdb_t.pmdb032, #行狀態
       pmdb033 LIKE pmdb_t.pmdb033, #緊急度
       pmdb034 LIKE pmdb_t.pmdb034, #專案編號
       pmdb035 LIKE pmdb_t.pmdb035, #WBS
       pmdb036 LIKE pmdb_t.pmdb036, #活動編號
       pmdb037 LIKE pmdb_t.pmdb037, #收貨據點
       pmdb038 LIKE pmdb_t.pmdb038, #收貨庫位
       pmdb039 LIKE pmdb_t.pmdb039, #收貨儲位
       pmdb040 LIKE pmdb_t.pmdb040, #no use
       pmdb041 LIKE pmdb_t.pmdb041, #允許部份交貨
       pmdb042 LIKE pmdb_t.pmdb042, #允許提前交貨
       pmdb043 LIKE pmdb_t.pmdb043, #保稅
       pmdb044 LIKE pmdb_t.pmdb044, #納入APS
       pmdb045 LIKE pmdb_t.pmdb045, #交期凍結否
       pmdb046 LIKE pmdb_t.pmdb046, #費用部門
       pmdb048 LIKE pmdb_t.pmdb048, #收貨時段
       pmdb049 LIKE pmdb_t.pmdb049, #已轉採購量
       pmdb050 LIKE pmdb_t.pmdb050, #備註
       pmdb051 LIKE pmdb_t.pmdb051, #結案/留置理由碼
       pmdb200 LIKE pmdb_t.pmdb200, #商品條碼
       pmdb201 LIKE pmdb_t.pmdb201, #包裝單位
       pmdb202 LIKE pmdb_t.pmdb202, #件裝數
       pmdb203 LIKE pmdb_t.pmdb203, #配送中心
       pmdb204 LIKE pmdb_t.pmdb204, #配送倉庫
       pmdb205 LIKE pmdb_t.pmdb205, #採購中心
       pmdb206 LIKE pmdb_t.pmdb206, #採購員
       pmdb207 LIKE pmdb_t.pmdb207, #採購方式
       pmdb208 LIKE pmdb_t.pmdb208, #經營方式
       pmdb209 LIKE pmdb_t.pmdb209, #結算方式
       pmdb210 LIKE pmdb_t.pmdb210, #促銷開始日
       pmdb211 LIKE pmdb_t.pmdb211, #促銷結束日
       pmdb212 LIKE pmdb_t.pmdb212, #要貨件數
       pmdb250 LIKE pmdb_t.pmdb250, #合理庫存
       pmdb251 LIKE pmdb_t.pmdb251, #最高庫存
       pmdb252 LIKE pmdb_t.pmdb252, #現有庫存
       pmdb253 LIKE pmdb_t.pmdb253, #入庫在途量
       pmdb254 LIKE pmdb_t.pmdb254, #前一週銷量
       pmdb255 LIKE pmdb_t.pmdb255, #前二週銷量
       pmdb256 LIKE pmdb_t.pmdb256, #前三週銷量
       pmdb257 LIKE pmdb_t.pmdb257, #前四週銷量
       pmdb258 LIKE pmdb_t.pmdb258, #要貨在途量
       pmdb259 LIKE pmdb_t.pmdb259, #週平均銷量
       pmdb900 LIKE pmdb_t.pmdb900, #保留欄位str
       pmdb999 LIKE pmdb_t.pmdb999, #保留欄位end
       pmdbud001 LIKE pmdb_t.pmdbud001, #自定義欄位(文字)001
       pmdbud002 LIKE pmdb_t.pmdbud002, #自定義欄位(文字)002
       pmdbud003 LIKE pmdb_t.pmdbud003, #自定義欄位(文字)003
       pmdbud004 LIKE pmdb_t.pmdbud004, #自定義欄位(文字)004
       pmdbud005 LIKE pmdb_t.pmdbud005, #自定義欄位(文字)005
       pmdbud006 LIKE pmdb_t.pmdbud006, #自定義欄位(文字)006
       pmdbud007 LIKE pmdb_t.pmdbud007, #自定義欄位(文字)007
       pmdbud008 LIKE pmdb_t.pmdbud008, #自定義欄位(文字)008
       pmdbud009 LIKE pmdb_t.pmdbud009, #自定義欄位(文字)009
       pmdbud010 LIKE pmdb_t.pmdbud010, #自定義欄位(文字)010
       pmdbud011 LIKE pmdb_t.pmdbud011, #自定義欄位(數字)011
       pmdbud012 LIKE pmdb_t.pmdbud012, #自定義欄位(數字)012
       pmdbud013 LIKE pmdb_t.pmdbud013, #自定義欄位(數字)013
       pmdbud014 LIKE pmdb_t.pmdbud014, #自定義欄位(數字)014
       pmdbud015 LIKE pmdb_t.pmdbud015, #自定義欄位(數字)015
       pmdbud016 LIKE pmdb_t.pmdbud016, #自定義欄位(數字)016
       pmdbud017 LIKE pmdb_t.pmdbud017, #自定義欄位(數字)017
       pmdbud018 LIKE pmdb_t.pmdbud018, #自定義欄位(數字)018
       pmdbud019 LIKE pmdb_t.pmdbud019, #自定義欄位(數字)019
       pmdbud020 LIKE pmdb_t.pmdbud020, #自定義欄位(數字)020
       pmdbud021 LIKE pmdb_t.pmdbud021, #自定義欄位(日期時間)021
       pmdbud022 LIKE pmdb_t.pmdbud022, #自定義欄位(日期時間)022
       pmdbud023 LIKE pmdb_t.pmdbud023, #自定義欄位(日期時間)023
       pmdbud024 LIKE pmdb_t.pmdbud024, #自定義欄位(日期時間)024
       pmdbud025 LIKE pmdb_t.pmdbud025, #自定義欄位(日期時間)025
       pmdbud026 LIKE pmdb_t.pmdbud026, #自定義欄位(日期時間)026
       pmdbud027 LIKE pmdb_t.pmdbud027, #自定義欄位(日期時間)027
       pmdbud028 LIKE pmdb_t.pmdbud028, #自定義欄位(日期時間)028
       pmdbud029 LIKE pmdb_t.pmdbud029, #自定義欄位(日期時間)029
       pmdbud030 LIKE pmdb_t.pmdbud030, #自定義欄位(日期時間)030
       pmdb260 LIKE pmdb_t.pmdb260, #收貨部門
       pmdb052 LIKE pmdb_t.pmdb052, #來源分批序
       pmdb227 LIKE pmdb_t.pmdb227, #補貨規格說明
       pmdb053 LIKE pmdb_t.pmdb053, #預算細項
       pmdb213 LIKE pmdb_t.pmdb213, #參考進價
       pmdb054 LIKE pmdb_t.pmdb054, #庫存管理特徵
       pmdb214 LIKE pmdb_t.pmdb214  #需求時間
END RECORD
#161104-00002#11 161110 By rainy mod---(E) 
DEFINE r_success  LIKE type_t.num5
DEFINE l_imaa009  LIKE type_t.chr500

       LET r_success = TRUE
       
       INITIALIZE l_pmdb.* TO NULL
       INITIALIZE l_imaa009 TO NULL
       
       INITIALIZE g_pmdd_d_color[l_ac].* TO NULL
  
       
       #類型為'3':單身新增或'2':單身修改
       IF p_pmdd901 = '2' OR p_pmdd901 = '4' THEN
          SELECT pmdbseq,pmdb001,pmdb002,pmdb003,pmdbsite,
                 pmdb200,pmdb004,pmdb037,pmdb260,pmdb038,pmdb201,
                 pmdb202,pmdb212,pmdb006,pmdb007,pmdb207,
                 pmdb015,pmdb049,pmdb030,pmdb048,pmdb208,
                 pmdb209,pmdb206,pmdb210,pmdb211,pmdb205,
                 pmdb203,pmdb204,
                 pmdb005,pmdb253,pmdb258, #sakura add
                 pmdb254,pmdb255,pmdb256,pmdb257,pmdb259,pmdb252,pmdb032 #sakura add
            INTO l_pmdb.pmdbseq,l_pmdb.pmdb001,l_pmdb.pmdb002,l_pmdb.pmdb003,l_pmdb.pmdbsite,
                 l_pmdb.pmdb200,l_pmdb.pmdb004,l_pmdb.pmdb037,l_pmdb.pmdb260,l_pmdb.pmdb038,l_pmdb.pmdb201,
                 l_pmdb.pmdb202,l_pmdb.pmdb212,l_pmdb.pmdb006,l_pmdb.pmdb007,l_pmdb.pmdb207,
                 l_pmdb.pmdb015,l_pmdb.pmdb049,l_pmdb.pmdb030,l_pmdb.pmdb048,l_pmdb.pmdb208,
                 l_pmdb.pmdb209,l_pmdb.pmdb206,l_pmdb.pmdb210,l_pmdb.pmdb211,l_pmdb.pmdb205,
                 l_pmdb.pmdb203,l_pmdb.pmdb204,
                 l_pmdb.pmdb005,l_pmdb.pmdb253,l_pmdb.pmdb258, #sakura add
                 l_pmdb.pmdb254,l_pmdb.pmdb255,l_pmdb.pmdb256,l_pmdb.pmdb257,l_pmdb.pmdb259,l_pmdb.pmdb252,l_pmdb.pmdb032 #sakura add 
           FROM pmdb_t
           WHERE pmdbent = g_enterprise AND pmdbdocno = g_pmdc_m.pmdcdocno AND pmdbseq = g_pmdd_d[l_ac].pmddseq
          #品類編號
          CALL apmt835_get_imaa009(l_pmdb.pmdb004) RETURNING l_imaa009
       END IF
       #針對該項次所有單身欄位同步新增[T:請購變更歷程檔]
       IF p_pmdd901 = '3' THEN
          LET g_pmdd_d_color[l_ac].pmdd901 = 'red'
       END IF       

       #請購項次
       IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmddseq) AND (g_pmdd_d[l_ac].pmddseq != l_pmdb.pmdbseq OR cl_null(l_pmdb.pmdbseq))) OR (cl_null(g_pmdd_d[l_ac].pmddseq) AND NOT cl_null(l_pmdb.pmdbseq)))) THEN
          LET g_pmdd_d_color[l_ac].pmddseq = 'red'
       END IF
       
       #來源單號
       IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd001) AND (g_pmdd_d[l_ac].pmdd001 != l_pmdb.pmdb001 OR cl_null(l_pmdb.pmdb001))) OR (cl_null(g_pmdd_d[l_ac].pmdd001) AND NOT cl_null(l_pmdb.pmdb001)))) THEN
          LET g_pmdd_d_color[l_ac].pmdd001 = 'red'
       END IF
       
       #來源項次
       IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd002) AND (g_pmdd_d[l_ac].pmdd002 != l_pmdb.pmdb002 OR cl_null(l_pmdb.pmdb002))) OR (cl_null(g_pmdd_d[l_ac].pmdd002) AND NOT cl_null(l_pmdb.pmdb002)))) THEN
          LET g_pmdd_d_color[l_ac].pmdd002 = 'red'
       END IF
      
       #來源項序
       IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd003) AND (g_pmdd_d[l_ac].pmdd003 != l_pmdb.pmdb003 OR cl_null(l_pmdb.pmdb003))) OR (cl_null(g_pmdd_d[l_ac].pmdd003) AND NOT cl_null(l_pmdb.pmdb003)))) THEN
          LET g_pmdd_d_color[l_ac].pmdd003 = 'red'
       END IF
      
      
       #需求組織
       IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmddsite) AND (g_pmdd_d[l_ac].pmddsite != l_pmdb.pmdbsite OR cl_null(l_pmdb.pmdbsite))) OR (cl_null(g_pmdd_d[l_ac].pmddsite) AND NOT cl_null(l_pmdb.pmdbsite)))) THEN
          LET g_pmdd_d_color[l_ac].pmddsite = 'red'
          LET g_pmdd_d_color[l_ac].pmddsite_desc = 'red'
       END IF 
       
       #商品條碼
       IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd200) AND (g_pmdd_d[l_ac].pmdd200 != l_pmdb.pmdb200 OR cl_null(l_pmdb.pmdb200))) OR (cl_null(g_pmdd_d[l_ac].pmdd200) AND NOT cl_null(l_pmdb.pmdb200)))) THEN
          LET g_pmdd_d_color[l_ac].pmdd200 = 'red'
       END IF  
       
       
       #商品編號
       IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd004) AND (g_pmdd_d[l_ac].pmdd004 != l_pmdb.pmdb004 OR cl_null(l_pmdb.pmdb004))) OR (cl_null(g_pmdd_d[l_ac].pmdd004) AND NOT cl_null(l_pmdb.pmdb004)))) THEN
          LET g_pmdd_d_color[l_ac].pmdd004 = 'red'
          LET g_pmdd_d_color[l_ac].pmdd004_desc = 'red'
          LET g_pmdd_d_color[l_ac].pmdd004_desc_desc = 'red'

       END IF
       
       #產品特徵
       IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd005) AND (g_pmdd_d[l_ac].pmdd005 != l_pmdb.pmdb005 OR cl_null(l_pmdb.pmdb005))) OR (cl_null(g_pmdd_d[l_ac].pmdd005) AND NOT cl_null(l_pmdb.pmdb005)))) THEN
          LET g_pmdd_d_color[l_ac].pmdd005 = 'red'
          LET g_pmdd_d_color[l_ac].pmdd005_desc = 'red'

       END IF
       
       #品類編號
       IF p_pmdd901 = '3' OR
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].imaa009) AND (g_pmdd_d[l_ac].imaa009 != l_imaa009 OR cl_null(l_imaa009))) OR (cl_null(g_pmdd_d[l_ac].imaa009) AND NOT cl_null(l_imaa009)))) THEN
          LET g_pmdd_d_color[l_ac].imaa009 = 'red'
          LET g_pmdd_d_color[l_ac].imaa009_desc = 'red'
       END IF

       #收貨組織
       IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd037) AND (g_pmdd_d[l_ac].pmdd037 != l_pmdb.pmdb037 OR cl_null(l_pmdb.pmdb037))) OR (cl_null(g_pmdd_d[l_ac].pmdd037) AND NOT cl_null(l_pmdb.pmdb037)))) THEN
          LET g_pmdd_d_color[l_ac].pmdd037 = 'red'
          LET g_pmdd_d_color[l_ac].pmdd037_desc = 'red'
       END IF

       #收貨部門
       IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd260) AND (g_pmdd_d[l_ac].pmdd260 != l_pmdb.pmdb260 OR cl_null(l_pmdb.pmdb260))) OR (cl_null(g_pmdd_d[l_ac].pmdd260) AND NOT cl_null(l_pmdb.pmdb260)))) THEN
          LET g_pmdd_d_color[l_ac].pmdd260 = 'red'
          LET g_pmdd_d_color[l_ac].pmdd260_desc = 'red'
       END IF

       #庫位編號
       IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd038) AND (g_pmdd_d[l_ac].pmdd038 != l_pmdb.pmdb038 OR cl_null(l_pmdb.pmdb038))) OR (cl_null(g_pmdd_d[l_ac].pmdd038) AND NOT cl_null(l_pmdb.pmdb038)))) THEN
          LET g_pmdd_d_color[l_ac].pmdd038 = 'red'
          LET g_pmdd_d_color[l_ac].pmdd038_desc = 'red'
       END IF

      #包装单位
       IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd201) AND (g_pmdd_d[l_ac].pmdd201 != l_pmdb.pmdb201 OR cl_null(l_pmdb.pmdb201))) OR (cl_null(g_pmdd_d[l_ac].pmdd201) AND NOT cl_null(l_pmdb.pmdb201)))) THEN
          LET g_pmdd_d_color[l_ac].pmdd201 = 'red'
          LET g_pmdd_d_color[l_ac].pmdd201_desc = 'red'
       END IF
      
      
       #件裝數
       IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd202) AND (g_pmdd_d[l_ac].pmdd202 != l_pmdb.pmdb202 OR cl_null(l_pmdb.pmdb202))) OR (cl_null(g_pmdd_d[l_ac].pmdd202) AND NOT cl_null(l_pmdb.pmdb202)))) THEN
          LET g_pmdd_d_color[l_ac].pmdd202 = 'red'
       END IF

       #要貨件數
       IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd212) AND (g_pmdd_d[l_ac].pmdd212 != l_pmdb.pmdb212 OR cl_null(l_pmdb.pmdb212))) OR (cl_null(g_pmdd_d[l_ac].pmdd212) AND NOT cl_null(l_pmdb.pmdb212)))) THEN
          LET g_pmdd_d_color[l_ac].pmdd212 = 'red'
       END IF

       #要貨數量
       IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd006) AND (g_pmdd_d[l_ac].pmdd006 != l_pmdb.pmdb006 OR cl_null(l_pmdb.pmdb006))) OR (cl_null(g_pmdd_d[l_ac].pmdd006) AND NOT cl_null(l_pmdb.pmdb006)))) THEN
          LET g_pmdd_d_color[l_ac].pmdd006 = 'red'
       END IF

       #要貨單位
       IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd007) AND (g_pmdd_d[l_ac].pmdd007 != l_pmdb.pmdb007 OR cl_null(l_pmdb.pmdb007))) OR (cl_null(g_pmdd_d[l_ac].pmdd007) AND NOT cl_null(l_pmdb.pmdb007)))) THEN
          LET g_pmdd_d_color[l_ac].pmdd007 = 'red'
          LET g_pmdd_d_color[l_ac].pmdd007_desc = 'red'
       END IF
       
       #入庫在途量
       IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd253) AND (g_pmdd_d[l_ac].pmdd253 != l_pmdb.pmdb253 OR cl_null(l_pmdb.pmdb253))) OR (cl_null(g_pmdd_d[l_ac].pmdd253) AND NOT cl_null(l_pmdb.pmdb253)))) THEN
          LET g_pmdd_d_color[l_ac].pmdd253 = 'red'
       END IF
       #要貨在途量(pmdd258)
       IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd258) AND (g_pmdd_d[l_ac].pmdd258 != l_pmdb.pmdb258 OR cl_null(l_pmdb.pmdb258))) OR (cl_null(g_pmdd_d[l_ac].pmdd258) AND NOT cl_null(l_pmdb.pmdb258)))) THEN
          LET g_pmdd_d_color[l_ac].pmdd258 = 'red'
       END IF	
       #前一週銷量(pmdd254)
       IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd254) AND (g_pmdd_d[l_ac].pmdd254 != l_pmdb.pmdb254 OR cl_null(l_pmdb.pmdb254))) OR (cl_null(g_pmdd_d[l_ac].pmdd254) AND NOT cl_null(l_pmdb.pmdb254)))) THEN
          LET g_pmdd_d_color[l_ac].pmdd254 = 'red'
       END IF
       #前二週銷量(pmdd255)
       IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd255) AND (g_pmdd_d[l_ac].pmdd255 != l_pmdb.pmdb255 OR cl_null(l_pmdb.pmdb255))) OR (cl_null(g_pmdd_d[l_ac].pmdd255) AND NOT cl_null(l_pmdb.pmdb255)))) THEN
          LET g_pmdd_d_color[l_ac].pmdd255 = 'red'
       END IF
       #前三週銷量(pmdd256)
       IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd256) AND (g_pmdd_d[l_ac].pmdd256 != l_pmdb.pmdb256 OR cl_null(l_pmdb.pmdb256))) OR (cl_null(g_pmdd_d[l_ac].pmdd256) AND NOT cl_null(l_pmdb.pmdb256)))) THEN
          LET g_pmdd_d_color[l_ac].pmdd256 = 'red'
       END IF	
       #前四週銷量(pmdd257)
       IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd257) AND (g_pmdd_d[l_ac].pmdd257 != l_pmdb.pmdb257 OR cl_null(l_pmdb.pmdb257))) OR (cl_null(g_pmdd_d[l_ac].pmdd257) AND NOT cl_null(l_pmdb.pmdb257)))) THEN
          LET g_pmdd_d_color[l_ac].pmdd257 = 'red'
       END IF
       #週平均銷量(pmdd259)
       IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd259) AND (g_pmdd_d[l_ac].pmdd259 != l_pmdb.pmdb259 OR cl_null(l_pmdb.pmdb259))) OR (cl_null(g_pmdd_d[l_ac].pmdd259) AND NOT cl_null(l_pmdb.pmdb259)))) THEN
          LET g_pmdd_d_color[l_ac].pmdd259 = 'red'
       END IF
       #現有庫存(pmdd252)
       IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd252) AND (g_pmdd_d[l_ac].pmdd252 != l_pmdb.pmdb252 OR cl_null(l_pmdb.pmdb252))) OR (cl_null(g_pmdd_d[l_ac].pmdd252) AND NOT cl_null(l_pmdb.pmdb252)))) THEN
          LET g_pmdd_d_color[l_ac].pmdd252 = 'red'
       END IF	
      

       #採購類型
       IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd207) AND (g_pmdd_d[l_ac].pmdd207 != l_pmdb.pmdb207 OR cl_null(l_pmdb.pmdb207))) OR (cl_null(g_pmdd_d[l_ac].pmdd207) AND NOT cl_null(l_pmdb.pmdb207)))) THEN
          LET g_pmdd_d_color[l_ac].pmdd207 = 'red'
       END IF


       #供应商编号
       IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd015) AND (g_pmdd_d[l_ac].pmdd015 != l_pmdb.pmdb015 OR cl_null(l_pmdb.pmdb015))) OR (cl_null(g_pmdd_d[l_ac].pmdd015) AND NOT cl_null(l_pmdb.pmdb015)))) THEN
          LET g_pmdd_d_color[l_ac].pmdd015 = 'red'
          LET g_pmdd_d_color[l_ac].pmdd015_desc = 'red'
       END IF
       
       #已轉採購量
       IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd049) AND (g_pmdd_d[l_ac].pmdd049 != l_pmdb.pmdb049 OR cl_null(l_pmdb.pmdb049))) OR (cl_null(g_pmdd_d[l_ac].pmdd049) AND NOT cl_null(l_pmdb.pmdb049)))) THEN
          LET g_pmdd_d_color[l_ac].pmdd049 = 'red'
       END IF
       

       #需求日期
       IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd030) AND (g_pmdd_d[l_ac].pmdd030 != l_pmdb.pmdb030 OR cl_null(l_pmdb.pmdb030))) OR (cl_null(g_pmdd_d[l_ac].pmdd030) AND NOT cl_null(l_pmdb.pmdb030)))) THEN
          LET g_pmdd_d_color[l_ac].pmdd030 = 'red'
       END IF
       
       #收貨時段
       IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd048) AND (g_pmdd_d[l_ac].pmdd048 != l_pmdb.pmdb048 OR cl_null(l_pmdb.pmdb048))) OR (cl_null(g_pmdd_d[l_ac].pmdd048) AND NOT cl_null(l_pmdb.pmdb048)))) THEN
          LET g_pmdd_d_color[l_ac].pmdd048 = 'red'
          LET g_pmdd_d_color[l_ac].pmdd048_desc = 'red'
       END IF
       
       #經營方式
       IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd208) AND (g_pmdd_d[l_ac].pmdd208 != l_pmdb.pmdb208 OR cl_null(l_pmdb.pmdb208))) OR (cl_null(g_pmdd_d[l_ac].pmdd208) AND NOT cl_null(l_pmdb.pmdb208)))) THEN
          LET g_pmdd_d_color[l_ac].pmdd208 = 'red'
       END IF
       
       #結算方式
       IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd209) AND (g_pmdd_d[l_ac].pmdd209 != l_pmdb.pmdb209 OR cl_null(l_pmdb.pmdb209))) OR (cl_null(g_pmdd_d[l_ac].pmdd209) AND NOT cl_null(l_pmdb.pmdb209)))) THEN
          LET g_pmdd_d_color[l_ac].pmdd209 = 'red'
          LET g_pmdd_d_color[l_ac].pmdd209_desc = 'red'
       END IF

       #採購員
       IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd206) AND (g_pmdd_d[l_ac].pmdd206 != l_pmdb.pmdb206 OR cl_null(l_pmdb.pmdb206))) OR (cl_null(g_pmdd_d[l_ac].pmdd206) AND NOT cl_null(l_pmdb.pmdb206)))) THEN
          LET g_pmdd_d_color[l_ac].pmdd206 = 'red'
          LET g_pmdd_d_color[l_ac].pmdd206_desc = 'red'
       END IF
       
       #促銷開始日
       IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd210) AND (g_pmdd_d[l_ac].pmdd210 != l_pmdb.pmdb210 OR cl_null(l_pmdb.pmdb210))) OR (cl_null(g_pmdd_d[l_ac].pmdd210) AND NOT cl_null(l_pmdb.pmdb210)))) THEN
          LET g_pmdd_d_color[l_ac].pmdd210 = 'red'
       END IF
       

       #促銷結束日
       IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd211) AND (g_pmdd_d[l_ac].pmdd211 != l_pmdb.pmdb211 OR cl_null(l_pmdb.pmdb211))) OR (cl_null(g_pmdd_d[l_ac].pmdd211) AND NOT cl_null(l_pmdb.pmdb211)))) THEN
          LET g_pmdd_d_color[l_ac].pmdd211 = 'red'
       END IF
       
       #採購中心
       IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd205) AND (g_pmdd_d[l_ac].pmdd205 != l_pmdb.pmdb205 OR cl_null(l_pmdb.pmdb205))) OR (cl_null(g_pmdd_d[l_ac].pmdd205) AND NOT cl_null(l_pmdb.pmdb205)))) THEN
          LET g_pmdd_d_color[l_ac].pmdd205 = 'red'
          LET g_pmdd_d_color[l_ac].pmdd205_desc = 'red'
       END IF
       
       #配送中心
       IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd203) AND (g_pmdd_d[l_ac].pmdd203 != l_pmdb.pmdb203 OR cl_null(l_pmdb.pmdb203))) OR (cl_null(g_pmdd_d[l_ac].pmdd203) AND NOT cl_null(l_pmdb.pmdb203)))) THEN
          LET g_pmdd_d_color[l_ac].pmdd203 = 'red'
          LET g_pmdd_d_color[l_ac].pmdd203_desc = 'red'
       END IF

       #配送倉庫
       IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].pmdd204) AND (g_pmdd_d[l_ac].pmdd204 != l_pmdb.pmdb204 OR cl_null(l_pmdb.pmdb204))) OR (cl_null(g_pmdd_d[l_ac].pmdd204) AND NOT cl_null(l_pmdb.pmdb204)))) THEN
          LET g_pmdd_d_color[l_ac].pmdd204 = 'red'
          LET g_pmdd_d_color[l_ac].pmdd204_desc = 'red'
       END IF
       
       #行狀態
       IF p_pmdd901 = '3' OR 
          ((p_pmdd901 = '2' OR p_pmdd901 = '4') AND ((NOT cl_null(g_pmdd_d[l_ac].l_pmdb032) AND (g_pmdd_d[l_ac].l_pmdb032 != l_pmdb.pmdb032 OR cl_null(l_pmdb.pmdb032))) OR (cl_null(g_pmdd_d[l_ac].l_pmdb032) AND NOT cl_null(l_pmdb.pmdb032)))) THEN
          LET g_pmdd_d_color[l_ac].l_pmdb032 = 'red'
       END IF
       
END FUNCTION

################################################################################
# Descriptions...: 單頭文字顏色顯示
# Memo...........:
# Usage..........: CALL apmt835_head_color()
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 2015/03/18 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt835_head_color()
DEFINE l_pmde002      LIKE pmde_t.pmde002

   #單頭文字顯示初始化
   CALL cl_set_comp_font_color("pmdcsite,pmdc902,pmdcdocdt,pmdcdocno,pmdc900,pmdc001,pmdc002,pmdc003,pmdcstus,pmdcacti,pmdc200,pmdc202,pmdc201,pmdc203,pmdc207,pmdc204,pmdc205,pmdc206,pmdc021,pmdc022,pmdc208,pmdc901,pmdc905,pmdc906","black")

   DECLARE sel_pmde_cs1 CURSOR FOR
    SELECT pmde002 FROM pmde_t
     WHERE pmdeent = g_enterprise
       AND pmdesite = g_pmdc_m.pmdcsite
       AND pmdedocno = g_pmdc_m.pmdcdocno
       AND pmde001 = g_pmdc_m.pmdc900
       AND pmdeseq = 0

   FOREACH sel_pmde_cs1 INTO l_pmde002
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      LET l_pmde002 = cl_replace_str(l_pmde002,'pmda','pmdc')

      CALL cl_set_comp_font_color(l_pmde002,"red")

   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 控制單身欄位為必填
# Memo...........:
# Usage..........: apmt835_set_required_b(p_cmd)
# Input parameter: p_cmd          單身輸入狀態
# Return code....: 無
# Date & Author..: 2015/03/20 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt835_set_required_b(p_cmd)
DEFINE p_cmd     LIKE type_t.chr1
   IF NOT cl_null(g_pmdd_d[l_ac].pmdd210) THEN  #(當促銷開始日期非空白時，促銷結束日不可空白)
      CALL cl_set_comp_required("pmdd211",TRUE)
   END IF
   IF NOT cl_null(g_pmdd_d[l_ac].pmdd211) THEN  #(當促銷結束日期非空白時，促銷開始日不可空白)
      CALL cl_set_comp_required("pmdd210",TRUE)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 控制單身欄位為非必填
# Memo...........:
# Usage..........: apmt835_set_no_required_b(p_cmd)
# Input parameter: p_cmd          單身輸入狀態
# Return code....: 無
# Date & Author..: 2015/03/20 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt835_set_no_required_b(p_cmd)
DEFINE p_cmd     LIKE type_t.chr1
   CALL cl_set_comp_required("pmdd211",FALSE) 
   CALL cl_set_comp_required("pmdd210",FALSE) 
END FUNCTION

################################################################################
# Descriptions...: 維護緊急度
# Memo...........:
# Usage..........: CALL apmt835_upd_pmdd033()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/04/09 By pomelo 150324-00006#14
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt835_upd_pmdd033()
DEFINE l_insert      BOOLEAN
DEFINE l_lock_sw     LIKE type_t.chr1                #單身鎖住否
DEFINE ls_keys       DYNAMIC ARRAY OF VARCHAR(500)
DEFINE l_n           LIKE type_t.num5
DEFINE l_cmd         LIKE type_t.chr1
DEFINE l_pmdb032     LIKE pmdb_t.pmdb032

   IF g_pmdc_m.pmdcdocno IS NULL OR g_pmdc_m.pmdc900 IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = "std-00003"
      LET g_errparam.popup  = FALSE
      CALL cl_err()
      RETURN
   END IF
   
   CALL apmt835_show()
   
   LET g_pmdcdocno_t = g_pmdc_m.pmdcdocno
   LET g_pmdc900_t = g_pmdc_m.pmdc900
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      INPUT ARRAY g_pmdd_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = FALSE,
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
      
         BEFORE INPUT
            CALL apmt835_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_detail_idx)
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_pmdd_d.getLength()
         
         BEFORE ROW
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN apmt835_cl USING g_enterprise,g_pmdc_m.pmdcdocno,g_pmdc_m.pmdc900
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN apmt835_cl:" 
               LET g_errparam.code   = STATUS 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CLOSE apmt835_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            LET g_rec_b = g_pmdd_d.getLength()
            
            IF g_rec_b >= l_ac AND g_pmdd_d[l_ac].pmddseq IS NOT NULL THEN
               LET l_cmd='u'
               LET g_pmdd_d_t.* = g_pmdd_d[l_ac].*  #BACKUP
               LET g_pmdd_d_o.* = g_pmdd_d[l_ac].*  #BACKUP
               CALL apmt835_set_entry_b(l_cmd)
               CALL apmt835_set_no_entry_b(l_cmd)
               IF NOT apmt835_lock_b("pmdd_t1","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH apmt835_upd_pmdd033 INTO g_pmdd_d[l_ac].pmddseq,g_pmdd_d[l_ac].pmdd001,g_pmdd_d[l_ac].pmdd002, 
                      g_pmdd_d[l_ac].pmdd003,g_pmdd_d[l_ac].pmddsite,g_pmdd_d[l_ac].pmdd200,g_pmdd_d[l_ac].pmdd004, 
                      g_pmdd_d[l_ac].pmdd005,g_pmdd_d[l_ac].pmdd033,g_pmdd_d[l_ac].pmdd037,g_pmdd_d[l_ac].pmdd260, 
                      g_pmdd_d[l_ac].pmdd038,g_pmdd_d[l_ac].pmdd201,g_pmdd_d[l_ac].pmdd202,g_pmdd_d[l_ac].pmdd212, 
                      g_pmdd_d[l_ac].pmdd007,g_pmdd_d[l_ac].pmdd006,g_pmdd_d[l_ac].pmdd253,g_pmdd_d[l_ac].pmdd258, 
                      g_pmdd_d[l_ac].pmdd254,g_pmdd_d[l_ac].pmdd255,g_pmdd_d[l_ac].pmdd256,g_pmdd_d[l_ac].pmdd257, 
                      g_pmdd_d[l_ac].pmdd259,g_pmdd_d[l_ac].pmdd252,g_pmdd_d[l_ac].pmdd207,g_pmdd_d[l_ac].pmdd015, 
                      g_pmdd_d[l_ac].pmdd049,g_pmdd_d[l_ac].pmdd030,g_pmdd_d[l_ac].pmdd048,g_pmdd_d[l_ac].pmdd208, 
                      g_pmdd_d[l_ac].pmdd209,g_pmdd_d[l_ac].pmdd206,g_pmdd_d[l_ac].pmdd210,g_pmdd_d[l_ac].pmdd211, 
                      g_pmdd_d[l_ac].pmdd205,g_pmdd_d[l_ac].pmdd203,g_pmdd_d[l_ac].pmdd204,g_pmdd_d[l_ac].pmdd032, 
                      g_pmdd_d[l_ac].pmdd901,g_pmdd_d[l_ac].pmdd902,g_pmdd_d[l_ac].pmdd903
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_pmdd_d_t.pmddseq 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_pmdd_d_mask_o[l_ac].* =  g_pmdd_d[l_ac].*
                  CALL apmt835_pmdd_t_mask()
                  LET g_pmdd_d_mask_n[l_ac].* =  g_pmdd_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL apmt835_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
         
         BEFORE FIELD pmdd033
            LET l_pmdb032 = apmt835_get_pmdb032(g_pmdc_m.pmdcdocno,g_pmdd_d[l_ac].pmddseq)
            
         ON CHANGE pmdd033
            IF (NOT cl_null(l_pmdb032) AND l_pmdb032 != '1') OR
               g_pmdd_d[l_ac].pmdd032 = 'Y' THEN
               #此項次的單身結案 = 'Y' 或對應到要貨單的行狀態 != 1.一般，不可以修改緊急度！
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "apm-00881"
               LET g_errparam.extend = ""
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_pmdd_d[l_ac].pmdd033 = g_pmdd_d_t.pmdd033
               NEXT FIELD CURRENT
            END IF
         
         AFTER FIELD pmdd033
         
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_pmdd_d[l_ac].* = g_pmdd_d_t.*
               CLOSE apmt835_upd_pmdd033
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_pmdd_d[l_ac].pmddseq 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_pmdd_d[l_ac].* = g_pmdd_d_t.*
            ELSE
               IF g_pmdd_d[l_ac].pmdd901 = '1' THEN  #如果是請購單中帶出的資料，則單身類型為單身修改
                  LET g_pmdd_d[l_ac].pmdd901 = '2'
               END IF
               IF g_pmdd_d[l_ac].pmdd032 = 'Y' THEN  #如果單身結案勾選，則類型變更為單身結案
                  LET g_pmdd_d[l_ac].pmdd901 = '4'
               END IF
               #寫入修改者/修改日期資訊(單身)      
               #將遮罩欄位還原
               CALL apmt835_pmdd_t_mask_restore('restore_mask_o')
      
               UPDATE pmdd_t SET (pmdddocno,pmdd900,pmddseq,pmdd001,pmdd002,pmdd003,pmddsite,pmdd200, 
                   pmdd004,pmdd005,pmdd033,pmdd037,pmdd260,pmdd038,pmdd201,pmdd202,pmdd212,pmdd007,pmdd006, 
                   pmdd253,pmdd258,pmdd254,pmdd255,pmdd256,pmdd257,pmdd259,pmdd252,pmdd207,pmdd015,pmdd049, 
                   pmdd030,pmdd048,pmdd208,pmdd209,pmdd206,pmdd210,pmdd211,pmdd205,pmdd203,pmdd204,pmdd032, 
                   pmdd901,pmdd902,pmdd903) = (g_pmdc_m.pmdcdocno,g_pmdc_m.pmdc900,g_pmdd_d[l_ac].pmddseq, 
                   g_pmdd_d[l_ac].pmdd001,g_pmdd_d[l_ac].pmdd002,g_pmdd_d[l_ac].pmdd003,g_pmdd_d[l_ac].pmddsite, 
                   g_pmdd_d[l_ac].pmdd200,g_pmdd_d[l_ac].pmdd004,g_pmdd_d[l_ac].pmdd005,g_pmdd_d[l_ac].pmdd033, 
                   g_pmdd_d[l_ac].pmdd037,g_pmdd_d[l_ac].pmdd260,g_pmdd_d[l_ac].pmdd038,g_pmdd_d[l_ac].pmdd201, 
                   g_pmdd_d[l_ac].pmdd202,g_pmdd_d[l_ac].pmdd212,g_pmdd_d[l_ac].pmdd007,g_pmdd_d[l_ac].pmdd006, 
                   g_pmdd_d[l_ac].pmdd253,g_pmdd_d[l_ac].pmdd258,g_pmdd_d[l_ac].pmdd254,g_pmdd_d[l_ac].pmdd255, 
                   g_pmdd_d[l_ac].pmdd256,g_pmdd_d[l_ac].pmdd257,g_pmdd_d[l_ac].pmdd259,g_pmdd_d[l_ac].pmdd252, 
                   g_pmdd_d[l_ac].pmdd207,g_pmdd_d[l_ac].pmdd015,g_pmdd_d[l_ac].pmdd049,g_pmdd_d[l_ac].pmdd030, 
                   g_pmdd_d[l_ac].pmdd048,g_pmdd_d[l_ac].pmdd208,g_pmdd_d[l_ac].pmdd209,g_pmdd_d[l_ac].pmdd206, 
                   g_pmdd_d[l_ac].pmdd210,g_pmdd_d[l_ac].pmdd211,g_pmdd_d[l_ac].pmdd205,g_pmdd_d[l_ac].pmdd203, 
                   g_pmdd_d[l_ac].pmdd204,g_pmdd_d[l_ac].pmdd032,g_pmdd_d[l_ac].pmdd901,g_pmdd_d[l_ac].pmdd902, 
                   g_pmdd_d[l_ac].pmdd903)
                WHERE pmddent = g_enterprise AND pmdddocno = g_pmdc_m.pmdcdocno 
                  AND pmdd900 = g_pmdc_m.pmdc900 
 
                  AND pmddseq = g_pmdd_d_t.pmddseq #項次   
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pmdd_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_pmdd_d[l_ac].* = g_pmdd_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pmdd_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()                   
                     CALL s_transaction_end('N','0')
                     LET g_pmdd_d[l_ac].* = g_pmdd_d_t.*  
                  OTHERWISE
                     INITIALIZE gs_keys TO NULL 
                     LET gs_keys[1] = g_pmdc_m.pmdcdocno
                     LET gs_keys_bak[1] = g_pmdcdocno_t
                     LET gs_keys[2] = g_pmdc_m.pmdc900
                     LET gs_keys_bak[2] = g_pmdc900_t
                     LET gs_keys[3] = g_pmdd_d[g_detail_idx].pmddseq
                     LET gs_keys_bak[3] = g_pmdd_d_t.pmddseq
                     CALL apmt835_update_b('pmdd_t1',gs_keys,gs_keys_bak,"'1'")
                     
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL apmt835_pmdd_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_pmdd_d[g_detail_idx].pmddseq = g_pmdd_d_t.pmddseq ) THEN
                  LET gs_keys[01] = g_pmdc_m.pmdcdocno
                  LET gs_keys[gs_keys.getLength()+1] = g_pmdc_m.pmdc900
 
                  LET gs_keys[gs_keys.getLength()+1] = g_pmdd_d_t.pmddseq
 
                  CALL apmt835_key_update_b(gs_keys,'pmdd_t1')
               END IF
               
               #修改歷程記錄
               LET g_log1 = util.JSON.stringify(g_pmdc_m),util.JSON.stringify(g_pmdd_d_t)
               LET g_log2 = util.JSON.stringify(g_pmdc_m),util.JSON.stringify(g_pmdd_d[l_ac])
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               IF NOT apmt835_pmdd_ins_pmde(g_pmdd_d[l_ac].pmdd901) THEN   #'3' 單身新增  '2' 單身修改
                  LET g_pmdd_d[l_ac].* = g_pmdd_d_t.*
                  CALL s_transaction_end('N','0')
               END IF
               IF NOT apmt835_upd_pmdc208() THEN
                  LET g_pmdd_d[l_ac].* = g_pmdd_d_t.*
                  CALL s_transaction_end('N','0')
               END IF
            END IF
         
         AFTER ROW
            CALL apmt835_unlock_b("pmdd_t1","'1'")
            CALL s_transaction_end('Y','0')
              
         AFTER INPUT
         
      END INPUT
   
      ON ACTION accept
         ACCEPT DIALOG

      ON ACTION cancel      #在dialog button (放棄)
         LET INT_FLAG = TRUE
         EXIT DIALOG

      ON ACTION close       #在dialog 右上角 (X)
         LET INT_FLAG = TRUE
         EXIT DIALOG

      ON ACTION exit        #toolbar 離開
         LET INT_FLAG = TRUE
         EXIT DIALOG

      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG

   END DIALOG
   
   CALL apmt835_b_fill()
   CLOSE apmt835_cl
   LET INT_FLAG = FALSE
END FUNCTION

 
{</section>}
 
