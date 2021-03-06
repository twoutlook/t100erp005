#該程式未解開Section, 採用最新樣板產出!
{<section id="apmt101.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0021(2017-02-07 17:13:10), PR版次:0021(2017-02-20 11:28:46)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000276
#+ Filename...: apmt101
#+ Description: 交易對象集團預設資料申請作業
#+ Creator....: 02294(2013-10-23 11:07:57)
#+ Modifier...: 06948 -SD/PR- 08734
 
{</section>}
 
{<section id="apmt101.global" >}
#應用 i01 樣板自動產生(Version:50)
#add-point:填寫註解說明 name="global.memo"
#160303-00018#1     2016/03/03  By dorislai      增加列印條件
#160318-00005#36    2016/03/28  By 07900         重复错误信息修改
#160318-00025#37    2016/04/19  By 07959         將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160531-00033#1     2016/06/01  By lixiang       apmt201发票类型开窗，改成按当前登录据点的预设税区去取
#160705-00042#11    2016/07/13  By sakura        程式中寫死g_prog部分改寫MATCHES方式
#160810-00016#1     2016/08/10  By dorislai      修改apmt200列印時，發票類型抓不到說明的問題(g_site_t放錯位子)
#160905-00007#11    2016/09/05  By 01727         调整系统中无ENT的SQL条件增加ent
#160920-00003#1     2016/09/20  By fionchen      若是由apmt100呼叫新增時,將apmt100允許收款條件頁籤中主要收款條件預設至慣用收款條件欄位         
#160824-00007#335   2017/01/06  By 06137         修正舊值備份寫法
#170120-00047#1     2017/01/20  By lixiang       sql条件中增加ent条件
#170213-00038#2     2017/02/17  By 08734         修改惯用交易条件栏位,应付账款类别栏位,惯用采购分类栏位,惯用交易方式栏位,惯用卸货港栏位开窗
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
PRIVATE TYPE type_g_pmbb_m RECORD
       pmbbdocno LIKE pmbb_t.pmbbdocno, 
   pmbb001 LIKE pmbb_t.pmbb001, 
   pmba002 LIKE pmba_t.pmba002, 
   status1 LIKE type_t.chr500, 
   pmbbdocno_desc LIKE type_t.chr80, 
   pmbal003 LIKE pmbal_t.pmbal003, 
   pmba003 LIKE pmba_t.pmba003, 
   pmbb080 LIKE pmbb_t.pmbb080, 
   pmbb081 LIKE pmbb_t.pmbb081, 
   pmbb081_desc LIKE type_t.chr80, 
   pmbb109 LIKE pmbb_t.pmbb109, 
   pmbb109_desc LIKE type_t.chr80, 
   pmbb082 LIKE pmbb_t.pmbb082, 
   pmbb083 LIKE pmbb_t.pmbb083, 
   pmbb083_desc LIKE type_t.chr80, 
   pmbb084 LIKE pmbb_t.pmbb084, 
   pmbb084_desc LIKE type_t.chr80, 
   pmbb103 LIKE pmbb_t.pmbb103, 
   pmbb103_desc LIKE type_t.chr80, 
   pmbb104 LIKE pmbb_t.pmbb104, 
   pmbb104_desc LIKE type_t.chr80, 
   pmbb085 LIKE pmbb_t.pmbb085, 
   pmbb086 LIKE pmbb_t.pmbb086, 
   pmbb106 LIKE pmbb_t.pmbb106, 
   pmbb106_desc LIKE type_t.chr80, 
   pmbb087 LIKE pmbb_t.pmbb087, 
   pmbb087_desc LIKE type_t.chr80, 
   pmbb105 LIKE pmbb_t.pmbb105, 
   pmbb105_desc LIKE type_t.chr80, 
   pmbb088 LIKE pmbb_t.pmbb088, 
   pmbb088_desc LIKE type_t.chr80, 
   pmbb089 LIKE pmbb_t.pmbb089, 
   pmbb089_desc LIKE type_t.chr80, 
   pmbb107 LIKE pmbb_t.pmbb107, 
   pmbb108 LIKE pmbb_t.pmbb108, 
   pmbb090 LIKE pmbb_t.pmbb090, 
   pmbb090_desc LIKE type_t.chr80, 
   pmbb091 LIKE pmbb_t.pmbb091, 
   pmbb091_desc LIKE type_t.chr80, 
   pmbb092 LIKE pmbb_t.pmbb092, 
   pmbb092_desc LIKE type_t.chr80, 
   pmbb093 LIKE pmbb_t.pmbb093, 
   pmbb093_desc LIKE type_t.chr80, 
   pmbb094 LIKE pmbb_t.pmbb094, 
   pmbb095 LIKE pmbb_t.pmbb095, 
   pmbb096 LIKE pmbb_t.pmbb096, 
   pmbb097 LIKE pmbb_t.pmbb097, 
   pmbb097_desc LIKE type_t.chr80, 
   pmbb098 LIKE pmbb_t.pmbb098, 
   pmbb099 LIKE pmbb_t.pmbb099, 
   pmbb100 LIKE pmbb_t.pmbb100, 
   pmbb101 LIKE pmbb_t.pmbb101, 
   pmbb102 LIKE pmbb_t.pmbb102, 
   pmbb030 LIKE pmbb_t.pmbb030, 
   pmbb031 LIKE pmbb_t.pmbb031, 
   pmbb031_desc LIKE type_t.chr80, 
   pmbb059 LIKE pmbb_t.pmbb059, 
   pmbb059_desc LIKE type_t.chr80, 
   pmbb032 LIKE pmbb_t.pmbb032, 
   pmbb033 LIKE pmbb_t.pmbb033, 
   pmbb033_desc LIKE type_t.chr80, 
   pmbb034 LIKE pmbb_t.pmbb034, 
   pmbb034_desc LIKE type_t.chr80, 
   pmbb053 LIKE pmbb_t.pmbb053, 
   pmbb053_desc LIKE type_t.chr80, 
   pmbb054 LIKE pmbb_t.pmbb054, 
   pmbb054_desc LIKE type_t.chr80, 
   pmbb035 LIKE pmbb_t.pmbb035, 
   pmbb036 LIKE pmbb_t.pmbb036, 
   pmbb056 LIKE pmbb_t.pmbb056, 
   pmbb056_desc LIKE type_t.chr80, 
   pmbb037 LIKE pmbb_t.pmbb037, 
   pmbb037_desc LIKE type_t.chr80, 
   pmbb055 LIKE pmbb_t.pmbb055, 
   pmbb055_desc LIKE type_t.chr80, 
   pmbb038 LIKE pmbb_t.pmbb038, 
   pmbb038_desc LIKE type_t.chr80, 
   pmbb039 LIKE pmbb_t.pmbb039, 
   pmbb039_desc LIKE type_t.chr80, 
   pmbb057 LIKE pmbb_t.pmbb057, 
   pmbb058 LIKE pmbb_t.pmbb058, 
   pmbb040 LIKE pmbb_t.pmbb040, 
   pmbb040_desc LIKE type_t.chr80, 
   pmbb041 LIKE pmbb_t.pmbb041, 
   pmbb041_desc LIKE type_t.chr80, 
   pmbb042 LIKE pmbb_t.pmbb042, 
   pmbb042_desc LIKE type_t.chr80, 
   pmbb043 LIKE pmbb_t.pmbb043, 
   pmbb043_desc LIKE type_t.chr80, 
   pmbb044 LIKE pmbb_t.pmbb044, 
   pmbb045 LIKE pmbb_t.pmbb045, 
   pmbb046 LIKE pmbb_t.pmbb046, 
   pmbb047 LIKE pmbb_t.pmbb047, 
   pmbb047_desc LIKE type_t.chr80, 
   pmbb048 LIKE pmbb_t.pmbb048, 
   pmbb049 LIKE pmbb_t.pmbb049, 
   pmbb050 LIKE pmbb_t.pmbb050, 
   pmbb051 LIKE pmbb_t.pmbb051, 
   pmbb052 LIKE pmbb_t.pmbb052, 
   pmbb071 LIKE pmbb_t.pmbb071, 
   pmbb072 LIKE pmbb_t.pmbb072, 
   pmbb073 LIKE pmbb_t.pmbb073, 
   pmbb060 LIKE pmbb_t.pmbb060, 
   pmbb061 LIKE pmbb_t.pmbb061, 
   pmbb066 LIKE pmbb_t.pmbb066, 
   pmbb062 LIKE pmbb_t.pmbb062, 
   pmbb067 LIKE pmbb_t.pmbb067, 
   pmbb063 LIKE pmbb_t.pmbb063, 
   pmbb068 LIKE pmbb_t.pmbb068, 
   pmbb064 LIKE pmbb_t.pmbb064, 
   pmbb069 LIKE pmbb_t.pmbb069, 
   pmbb065 LIKE pmbb_t.pmbb065, 
   pmbb070 LIKE pmbb_t.pmbb070, 
   total LIKE type_t.chr500, 
   pmbb002 LIKE pmbb_t.pmbb002, 
   pmbb003 LIKE pmbb_t.pmbb003, 
   pmbb003_desc LIKE type_t.chr80, 
   pmbb004 LIKE pmbb_t.pmbb004, 
   pmbb004_desc LIKE type_t.chr80, 
   pmbb005 LIKE pmbb_t.pmbb005, 
   pmbb005_desc LIKE type_t.chr80, 
   pmbb006 LIKE pmbb_t.pmbb006, 
   pmbb007 LIKE pmbb_t.pmbb007, 
   pmbb008 LIKE pmbb_t.pmbb008, 
   pmbb009 LIKE pmbb_t.pmbb009, 
   pmbb019 LIKE pmbb_t.pmbb019, 
   pmbb010 LIKE pmbb_t.pmbb010, 
   pmbb020 LIKE pmbb_t.pmbb020, 
   pmbb011 LIKE pmbb_t.pmbb011, 
   pmbb012 LIKE pmbb_t.pmbb012, 
   pmbb013 LIKE pmbb_t.pmbb013, 
   pmbb014 LIKE pmbb_t.pmbb014, 
   pmbb015 LIKE pmbb_t.pmbb015, 
   pmbb016 LIKE pmbb_t.pmbb016, 
   pmbb017 LIKE pmbb_t.pmbb017, 
   pmbb018 LIKE pmbb_t.pmbb018, 
   ooff013 LIKE type_t.chr500, 
   pmbbownid LIKE pmbb_t.pmbbownid, 
   pmbbownid_desc LIKE type_t.chr80, 
   pmbbowndp LIKE pmbb_t.pmbbowndp, 
   pmbbowndp_desc LIKE type_t.chr80, 
   pmbbcrtid LIKE pmbb_t.pmbbcrtid, 
   pmbbcrtid_desc LIKE type_t.chr80, 
   pmbbcrtdp LIKE pmbb_t.pmbbcrtdp, 
   pmbbcrtdp_desc LIKE type_t.chr80, 
   pmbbcrtdt LIKE pmbb_t.pmbbcrtdt, 
   pmbbmodid LIKE pmbb_t.pmbbmodid, 
   pmbbmodid_desc LIKE type_t.chr80, 
   pmbbmoddt LIKE pmbb_t.pmbbmoddt
       END RECORD
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD  #查詢方案用陣列 
         b_statepic     LIKE type_t.chr50,
            b_pmbbdocno LIKE pmbb_t.pmbbdocno,
      b_pmbb001 LIKE pmbb_t.pmbb001,
   b_pmbbdocno_desc LIKE type_t.chr80,
   b_pmbal002 LIKE type_t.chr80,
   b_pmba002 LIKE pmba_t.pmba002,
   b_pmba004 LIKE pmba_t.pmba004,
   b_pmba005 LIKE pmba_t.pmba005,
   b_pmba026 LIKE pmba_t.pmba026,
   b_pmba006 LIKE pmba_t.pmba006
      END RECORD 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_flag1               LIKE type_t.num5     #判斷是否是由apmm100串apmm101走的新增 是，則值為'1'
DEFINE g_site_t              LIKE type_t.chr10   #一開始進入作業的營運據點
DEFINE g_flag2               LIKE type_t.num5     #判斷是否是由apmm100串apmm101 是，則值為'1'
DEFINE g_ooef019             LIKE ooef_t.ooef019
#end add-point
 
#模組變數(Module Variables)
DEFINE g_pmbb_m        type_g_pmbb_m  #單頭變數宣告
DEFINE g_pmbb_m_t      type_g_pmbb_m  #單頭舊值宣告(系統還原用)
DEFINE g_pmbb_m_o      type_g_pmbb_m  #單頭舊值宣告(其他用途)
DEFINE g_pmbb_m_mask_o type_g_pmbb_m  #轉換遮罩前資料
DEFINE g_pmbb_m_mask_n type_g_pmbb_m  #轉換遮罩後資料
 
   DEFINE g_pmbbdocno_t LIKE pmbb_t.pmbbdocno
 
   
 
   
 
DEFINE g_wc                  STRING                        #儲存查詢條件
DEFINE g_wc_t                STRING                        #備份查詢條件
DEFINE g_wc_filter           STRING                        #儲存過濾查詢條件
DEFINE g_wc_filter_t         STRING                        #備份過濾查詢條件
DEFINE g_sql                 STRING                        #資料撈取用SQL(含reference)
DEFINE g_forupd_sql          STRING                        #資料鎖定用SQL
DEFINE g_cnt                 LIKE type_t.num10             #指標/統計用變數
DEFINE g_jump                LIKE type_t.num10             #查詢指定的筆數 
DEFINE g_no_ask              LIKE type_t.num5              #是否開啟指定筆視窗 
DEFINE g_rec_b               LIKE type_t.num10             #單身筆數                         
DEFINE l_ac                  LIKE type_t.num10             #目前處理的ARRAY CNT 
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog     
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_pagestart           LIKE type_t.num10             #page起始筆數
DEFINE g_page_action         STRING                        #page action
DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
DEFINE g_page                STRING                        #第幾頁
DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
DEFINE g_ch                  base.Channel                  #外串程式用
DEFINE g_state               STRING                        #確認前一個動作是否為新增/複製
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #reference用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #reference用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #reference用陣列
DEFINE g_error_show          LIKE type_t.num5              #是否顯示資料過多的錯誤訊息
DEFINE g_aw                  STRING                        #確定當下點擊的單身(modify_detail用)
DEFINE g_chk                 BOOLEAN                       #助記碼判斷用
DEFINE g_default             BOOLEAN                       #是否有外部參數查詢
DEFINE g_log1                STRING                        #cl_log_modified_record用(舊值)
DEFINE g_log2                STRING                        #cl_log_modified_record用(新值)
 
#快速搜尋用
DEFINE g_searchcol           STRING                        #查詢欄位代碼
DEFINE g_searchstr           STRING                        #查詢欄位字串
DEFINE g_order               STRING                        #查詢排序模式
 
#Browser用
DEFINE g_current_idx         LIKE type_t.num10             #Browser 所在筆數(當下page)
DEFINE g_current_row         LIKE type_t.num10             #Browser 所在筆數(暫存用)
DEFINE g_current_cnt         LIKE type_t.num10             #Browser 總筆數(當下page)
DEFINE g_browser_idx         LIKE type_t.num10             #Browser 所在筆數(所有資料)
DEFINE g_browser_cnt         LIKE type_t.num10             #Browser 總筆數(所有資料)
DEFINE g_row_index           LIKE type_t.num10             #階層樹狀用指標
DEFINE g_add_browse          STRING                        #新增填充用WC
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization" 

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="apmt101.main" >}
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
   CALL cl_ap_init("apm","")
 
   #add-point:作業初始化 name="main.init"
   LET g_flag1 = 0           #判斷是否是由apmm100串apmm101走的新增
   LET g_flag2 = 0           #判斷是否是由apmm100串apmm101
#   LET g_site_t = g_site    #記錄當前登入的營運據點   #160810-00016#1-mark 放錯位子了，移到下面
   
   
   IF NOT cl_null(g_argv[02]) THEN
      LET g_site = g_argv[02]     
   END IF
   LET g_site_t = g_site     #記錄當前登入的營運據點   #160810-00016#1-add
   
   IF NOT cl_null(g_argv[03]) THEN
      LET g_pmbb_m.pmbbdocno = g_argv[03]
   ELSE
      #CALL cl_err('','sub-00228',1)
      #CALL cl_ap_exitprogram("0") 
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_pmbb_m.pmbb001 = g_argv[04]
   ELSE
      #CALL cl_err('','sub-00177',1)
      #CALL cl_ap_exitprogram("0")
   END IF
   LET g_ooef019 = ''
   #SELECT ooef019 INTO g_ooef019 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site  #160531-00033#1 
   SELECT ooef019 INTO g_ooef019 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site_t #160531-00033#1 
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT pmbbdocno,pmbb001,'','','','','',pmbb080,pmbb081,'',pmbb109,'',pmbb082, 
       pmbb083,'',pmbb084,'',pmbb103,'',pmbb104,'',pmbb085,pmbb086,pmbb106,'',pmbb087,'',pmbb105,'', 
       pmbb088,'',pmbb089,'',pmbb107,pmbb108,pmbb090,'',pmbb091,'',pmbb092,'',pmbb093,'',pmbb094,pmbb095, 
       pmbb096,pmbb097,'',pmbb098,pmbb099,pmbb100,pmbb101,pmbb102,pmbb030,pmbb031,'',pmbb059,'',pmbb032, 
       pmbb033,'',pmbb034,'',pmbb053,'',pmbb054,'',pmbb035,pmbb036,pmbb056,'',pmbb037,'',pmbb055,'', 
       pmbb038,'',pmbb039,'',pmbb057,pmbb058,pmbb040,'',pmbb041,'',pmbb042,'',pmbb043,'',pmbb044,pmbb045, 
       pmbb046,pmbb047,'',pmbb048,pmbb049,pmbb050,pmbb051,pmbb052,pmbb071,pmbb072,pmbb073,pmbb060,pmbb061, 
       pmbb066,pmbb062,pmbb067,pmbb063,pmbb068,pmbb064,pmbb069,pmbb065,pmbb070,'',pmbb002,pmbb003,'', 
       pmbb004,'',pmbb005,'',pmbb006,pmbb007,pmbb008,pmbb009,pmbb019,pmbb010,pmbb020,pmbb011,pmbb012, 
       pmbb013,pmbb014,pmbb015,pmbb016,pmbb017,pmbb018,'',pmbbownid,'',pmbbowndp,'',pmbbcrtid,'',pmbbcrtdp, 
       '',pmbbcrtdt,pmbbmodid,'',pmbbmoddt", 
                      " FROM pmbb_t",
                      " WHERE pmbbent= ? AND pmbbsite= ? AND pmbbdocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apmt101_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.pmbbdocno,t0.pmbb001,t0.pmbb080,t0.pmbb081,t0.pmbb109,t0.pmbb082, 
       t0.pmbb083,t0.pmbb084,t0.pmbb103,t0.pmbb104,t0.pmbb085,t0.pmbb086,t0.pmbb106,t0.pmbb087,t0.pmbb105, 
       t0.pmbb088,t0.pmbb089,t0.pmbb107,t0.pmbb108,t0.pmbb090,t0.pmbb091,t0.pmbb092,t0.pmbb093,t0.pmbb094, 
       t0.pmbb095,t0.pmbb096,t0.pmbb097,t0.pmbb098,t0.pmbb099,t0.pmbb100,t0.pmbb101,t0.pmbb102,t0.pmbb030, 
       t0.pmbb031,t0.pmbb059,t0.pmbb032,t0.pmbb033,t0.pmbb034,t0.pmbb053,t0.pmbb054,t0.pmbb035,t0.pmbb036, 
       t0.pmbb056,t0.pmbb037,t0.pmbb055,t0.pmbb038,t0.pmbb039,t0.pmbb057,t0.pmbb058,t0.pmbb040,t0.pmbb041, 
       t0.pmbb042,t0.pmbb043,t0.pmbb044,t0.pmbb045,t0.pmbb046,t0.pmbb047,t0.pmbb048,t0.pmbb049,t0.pmbb050, 
       t0.pmbb051,t0.pmbb052,t0.pmbb071,t0.pmbb072,t0.pmbb073,t0.pmbb060,t0.pmbb061,t0.pmbb066,t0.pmbb062, 
       t0.pmbb067,t0.pmbb063,t0.pmbb068,t0.pmbb064,t0.pmbb069,t0.pmbb065,t0.pmbb070,t0.pmbb002,t0.pmbb003, 
       t0.pmbb004,t0.pmbb005,t0.pmbb006,t0.pmbb007,t0.pmbb008,t0.pmbb009,t0.pmbb019,t0.pmbb010,t0.pmbb020, 
       t0.pmbb011,t0.pmbb012,t0.pmbb013,t0.pmbb014,t0.pmbb015,t0.pmbb016,t0.pmbb017,t0.pmbb018,t0.pmbbownid, 
       t0.pmbbowndp,t0.pmbbcrtid,t0.pmbbcrtdp,t0.pmbbcrtdt,t0.pmbbmodid,t0.pmbbmoddt,t1.ooag011 ,t2.ooefl003 , 
       t3.ooail003 ,t4.oocql004 ,t5.pmaml003 ,t6.ooibl004 ,t7.oocql004 ,t8.oojdl003 ,t9.oocql004 ,t10.oocql004 , 
       t11.oocql004 ,t12.oocql004 ,t13.oocql004 ,t14.pmaal004 ,t15.ooag011 ,t16.ooefl003 ,t17.ooail003 , 
       t18.oocql004 ,t19.pmaml003 ,t20.ooibl004 ,t21.oocql004 ,t22.oojdl003 ,t23.oocql004 ,t24.oocql004 , 
       t25.oocql004 ,t26.oocql004 ,t27.oocql004 ,t28.pmaal004 ,t29.pmaal003 ,t30.xmajl003 ,t31.ooail003 , 
       t32.ooag011 ,t33.ooefl003 ,t34.ooag011 ,t35.ooefl003 ,t36.ooag011",
               " FROM pmbb_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.pmbb081  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.pmbb109 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t3 ON t3.ooailent="||g_enterprise||" AND t3.ooail001=t0.pmbb083 AND t3.ooail002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t4 ON t4.oocqlent="||g_enterprise||" AND t4.oocql001='238' AND t4.oocql002=t0.pmbb103 AND t4.oocql003='"||g_dlang||"' ",
               " LEFT JOIN pmaml_t t5 ON t5.pmamlent="||g_enterprise||" AND t5.pmaml001=t0.pmbb104 AND t5.pmaml002='"||g_dlang||"' ",
               " LEFT JOIN ooibl_t t6 ON t6.ooiblent="||g_enterprise||" AND t6.ooibl002=t0.pmbb087 AND t6.ooibl003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t7 ON t7.oocqlent="||g_enterprise||" AND t7.oocql001='3111' AND t7.oocql002=t0.pmbb105 AND t7.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oojdl_t t8 ON t8.oojdlent="||g_enterprise||" AND t8.oojdl001=t0.pmbb088 AND t8.oojdl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t9 ON t9.oocqlent="||g_enterprise||" AND t9.oocql001='295' AND t9.oocql002=t0.pmbb089 AND t9.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t10 ON t10.oocqlent="||g_enterprise||" AND t10.oocql001='263' AND t10.oocql002=t0.pmbb090 AND t10.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t11 ON t11.oocqlent="||g_enterprise||" AND t11.oocql001='262' AND t11.oocql002=t0.pmbb091 AND t11.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t12 ON t12.oocqlent="||g_enterprise||" AND t12.oocql001='262' AND t12.oocql002=t0.pmbb092 AND t12.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t13 ON t13.oocqlent="||g_enterprise||" AND t13.oocql001='262' AND t13.oocql002=t0.pmbb093 AND t13.oocql003='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t14 ON t14.pmaalent="||g_enterprise||" AND t14.pmaal001=t0.pmbb097 AND t14.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t15 ON t15.ooagent="||g_enterprise||" AND t15.ooag001=t0.pmbb031  ",
               " LEFT JOIN ooefl_t t16 ON t16.ooeflent="||g_enterprise||" AND t16.ooefl001=t0.pmbb059 AND t16.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t17 ON t17.ooailent="||g_enterprise||" AND t17.ooail001=t0.pmbb033 AND t17.ooail002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t18 ON t18.oocqlent="||g_enterprise||" AND t18.oocql001='238' AND t18.oocql002=t0.pmbb053 AND t18.oocql003='"||g_dlang||"' ",
               " LEFT JOIN pmaml_t t19 ON t19.pmamlent="||g_enterprise||" AND t19.pmaml001=t0.pmbb054 AND t19.pmaml002='"||g_dlang||"' ",
               " LEFT JOIN ooibl_t t20 ON t20.ooiblent="||g_enterprise||" AND t20.ooibl002=t0.pmbb037 AND t20.ooibl003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t21 ON t21.oocqlent="||g_enterprise||" AND t21.oocql001='3211' AND t21.oocql002=t0.pmbb055 AND t21.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oojdl_t t22 ON t22.oojdlent="||g_enterprise||" AND t22.oojdl001=t0.pmbb038 AND t22.oojdl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t23 ON t23.oocqlent="||g_enterprise||" AND t23.oocql001='264' AND t23.oocql002=t0.pmbb039 AND t23.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t24 ON t24.oocqlent="||g_enterprise||" AND t24.oocql001='263' AND t24.oocql002=t0.pmbb040 AND t24.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t25 ON t25.oocqlent="||g_enterprise||" AND t25.oocql001='262' AND t25.oocql002=t0.pmbb041 AND t25.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t26 ON t26.oocqlent="||g_enterprise||" AND t26.oocql001='262' AND t26.oocql002=t0.pmbb042 AND t26.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t27 ON t27.oocqlent="||g_enterprise||" AND t27.oocql001='262' AND t27.oocql002=t0.pmbb043 AND t27.oocql003='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t28 ON t28.pmaalent="||g_enterprise||" AND t28.pmaal001=t0.pmbb047 AND t28.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t29 ON t29.pmaalent="||g_enterprise||" AND t29.pmaal001=t0.pmbb003 AND t29.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN xmajl_t t30 ON t30.xmajlent="||g_enterprise||" AND t30.xmajl001=t0.pmbb004 AND t30.xmajl002='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t31 ON t31.ooailent="||g_enterprise||" AND t31.ooail001=t0.pmbb005 AND t31.ooail002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t32 ON t32.ooagent="||g_enterprise||" AND t32.ooag001=t0.pmbbownid  ",
               " LEFT JOIN ooefl_t t33 ON t33.ooeflent="||g_enterprise||" AND t33.ooefl001=t0.pmbbowndp AND t33.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t34 ON t34.ooagent="||g_enterprise||" AND t34.ooag001=t0.pmbbcrtid  ",
               " LEFT JOIN ooefl_t t35 ON t35.ooeflent="||g_enterprise||" AND t35.ooefl001=t0.pmbbcrtdp AND t35.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t36 ON t36.ooagent="||g_enterprise||" AND t36.ooag001=t0.pmbbmodid  ",
 
               " WHERE t0.pmbbent = " ||g_enterprise|| " AND t0.pmbbsite = ? AND t0.pmbbdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE apmt101_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
 
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apmt101 WITH FORM cl_ap_formpath("apm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apmt101_init()   
 
      #進入選單 Menu (="N")
      CALL apmt101_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_apmt101
      
   END IF 
   
   CLOSE apmt101_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="apmt101.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION apmt101_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_n   LIKE type_t.num5
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   #定義combobox狀態
   
      CALL cl_set_combo_scc('pmba002','2014') 
   CALL cl_set_combo_scc('pmbb080','36') 
   CALL cl_set_combo_scc('pmbb085','8322') 
   CALL cl_set_combo_scc('pmbb086','8334') 
   CALL cl_set_combo_scc('pmbb107','2085') 
   CALL cl_set_combo_scc('pmbb108','2084') 
   CALL cl_set_combo_scc('pmbb030','36') 
   CALL cl_set_combo_scc('pmbb035','8322') 
   CALL cl_set_combo_scc('pmbb036','9936') 
   CALL cl_set_combo_scc('pmbb057','2087') 
   CALL cl_set_combo_scc('pmbb058','2086') 
   CALL cl_set_combo_scc('pmbb071','5051') 
   CALL cl_set_combo_scc('pmbb072','5052') 
   CALL cl_set_combo_scc('pmbb073','5053') 
   CALL cl_set_combo_scc('pmbb002','2033') 
   CALL cl_set_combo_scc('pmbb012','2034') 
   CALL cl_set_combo_scc('pmbb014','2034') 
   CALL cl_set_combo_scc('pmbb016','2034') 
   CALL cl_set_combo_scc('pmbb018','2034') 
 
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('status1','13')
   CALL cl_set_combo_scc('b_pmba002','2014')
   CALL cl_set_combo_scc('b_pmba004','2015') 
   
   CALL cl_set_combo_lang("pmbb082")
   CALL cl_set_combo_lang("pmbb032")
   
   CALL apmt101_set_visible()
  

   #傳入參數p_pmbbdocno與p_pmbb001在[T:交易對象據點申請檔]中有對應資料時，則將該筆資料抓出顯示在畫面直接供維護
   #若[T:交易對象據點申請檔]沒有對應資料時，則程式直接進入新增狀態且[C:申請單號]=p_pmbbdocno [C:交易對象編號]=p_pmbb001
   #IF (NOT cl_null(g_argv[03])) AND (NOT cl_null(g_argv[04])) THEN
    IF NOT cl_null(g_argv[03]) THEN
      LET l_n = 0 
      SELECT COUNT(*) INTO l_n FROM pmbb_t WHERE pmbbent = g_enterprise 
           AND pmbbdocno = g_pmbb_m.pmbbdocno AND pmbbsite = g_site  #AND pmbb001 = g_pmbb_m.pmbb001
      IF l_n = 0 THEN
         #進入新增
         LET gwin_curr = ui.Window.getCurrent()
         LET gfrm_curr = gwin_curr.getForm()
         LET g_main_hidden = 1         
         LET g_flag1 = 1
         CALL apmt101_insert()       
      END IF
      LET g_flag2 = 1
   END IF
   #end add-point
   
   #根據外部參數進行搜尋
   CALL apmt101_default_search()
 
END FUNCTION
 
{</section>}
 
{<section id="apmt101.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apmt101_ui_dialog() 
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit   LIKE type_t.num10       #判別是否為離開作業
   DEFINE li_idx    LIKE type_t.num10       #指標變數
   DEFINE ls_wc     STRING                  #wc用
   DEFINE la_param  RECORD                  #程式串查用變數
          prog       STRING,
          actionid   STRING,
          background LIKE type_t.chr1,
          param      DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING                  #轉換後的json字串
   DEFINE l_cmd_token           base.StringTokenizer   #報表作業cmdrun使用 
   DEFINE l_cmd_next            STRING                 #報表作業cmdrun使用
   DEFINE l_cmd_cnt             LIKE type_t.num5       #報表作業cmdrun使用
   DEFINE l_cmd_prog_arg        STRING                 #報表作業cmdrun使用
   DEFINE l_cmd_arg             STRING                 #報表作業cmdrun使用
   #add-point:ui_dialog段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
 
   #end add-point
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   LET li_exit = FALSE
   LET g_current_row = 0
   LET g_current_idx = 0
 
   #若有外部參數查詢, 則直接顯示資料(隱藏查詢方案)
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
   
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   #傳入參數，直接進入的新增狀態，新增完成後，顯示主畫面
   IF g_flag2 THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
   #end add-point
 
   WHILE li_exit = FALSE
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_pmbb_m.* TO NULL
         LET g_wc  = ' 1=2'
         LET g_action_choice = ""
         CALL apmt101_init()
      END IF
      
      CALL lib_cl_dlg.cl_dlg_before_display()
      CALL cl_notice()
    
      #確保g_current_idx位於正常區間內
      #小於,等於0則指到第1筆
      IF g_current_idx <= 0 THEN
         LET g_current_idx = 1
      END IF
               
      IF g_main_hidden = 0 THEN
         MENU
            BEFORE MENU 
               #先填充browser資料
               CALL apmt101_browser_fill(g_wc,"")
               CALL cl_navigator_setting(g_current_idx, g_current_cnt)
               
               #還原為原本指定筆數
               IF g_current_row > 0 THEN
                  LET g_current_idx = g_current_row
               END IF
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL apmt101_fetch("")   
               END IF               
               #add-point:ui_dialog段 before menu name="ui_dialog.before_menu"
               #若執行集團級程式，則不開放切換營運中心的功能
               #IF g_prog = 'apmt101' OR g_prog = 'apmt201' OR g_prog = 'axmt201' THEN                    #160705-00042#11 160713 by sakura mark
               IF g_prog MATCHES 'apmt101' OR g_prog MATCHES 'apmt201' OR g_prog MATCHES 'axmt201' THEN   #160705-00042#11 160713 by sakura add
                  CALL cl_set_act_visible("logistics", FALSE)
               ELSE
                  CALL cl_set_act_visible("logistics", TRUE)
               END IF
               #end add-point
            
 
 
               
            #第一筆資料
            ON ACTION first
               CALL apmt101_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL apmt101_fetch("N")
               LET g_current_row = g_current_idx
            
            #指定筆資料
            ON ACTION jump
               CALL apmt101_fetch("/")
               LET g_current_row = g_current_idx
            
            #上一筆資料
            ON ACTION previous
               CALL apmt101_fetch("P")
               LET g_current_row = g_current_idx
            
            #最後筆資料
            ON ACTION last 
               CALL apmt101_fetch("L")  
               LET g_current_row = g_current_idx
            
            #離開程式
            ON ACTION exit
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT MENU 
            
            #離開程式
            ON ACTION close
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT MENU
            
            #主頁摺疊
            ON ACTION mainhidden   
               LET g_action_choice = "mainhidden"            
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
               EXIT MENU
               
            ON ACTION worksheethidden   #瀏覽頁折疊
               IF g_main_hidden THEN
                  CALL gfrm_curr.setElementHidden("mainlayout",0)
                  CALL gfrm_curr.setElementHidden("worksheet",1)
                  LET g_main_hidden = 0
               ELSE
                  CALL gfrm_curr.setElementHidden("mainlayout",1)
                  CALL gfrm_curr.setElementHidden("worksheet",0)
                  LET g_main_hidden = 1
               END IF
               EXIT MENU
            
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
          
            #查詢方案用
            ON ACTION queryplansel
               CALL cl_dlg_qryplan_select() RETURNING ls_wc
               #不是空條件才寫入g_wc跟重新找資料
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  CALL apmt101_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL apmt101_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL apmt101_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
            
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL apmt101_modify()
               #add-point:ON ACTION modify name="menu2.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION demo
            LET g_action_choice="demo"
            IF cl_auth_chk_act("demo") THEN
               
               #add-point:ON ACTION demo name="menu2.demo"
               CALL aooi360_02('6',g_prog,g_pmbb_m.pmbbdocno,'','','','','','','','','')
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL apmt101_delete()
               #add-point:ON ACTION delete name="menu2.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu2.output"
               
               #END add-point
               &include "erp/apm/apmt101_rep.4gl"
               #add-point:ON ACTION output.after name="menu2.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu2.quickprint"
               
               #END add-point
               &include "erp/apm/apmt101_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu2.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL apmt101_reproduce()
               #add-point:ON ACTION reproduce name="menu2.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL apmt101_query()
               #add-point:ON ACTION query name="menu2.query"
               
               #END add-point
               
            END IF
 
 
 
 
            
            
            
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL apmt101_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.menu.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL apmt101_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.menu.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL apmt101_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.menu.followup"
            
            #END add-point
            CALL cl_user_overview_follow('')
 
 
 
            
            #主選單用ACTION
            &include "main_menu_exit_menu.4gl"
            &include "relating_action.4gl"
            #交談指令共用ACTION
            &include "common_action.4gl"
            
         END MENU
      
      ELSE
      
         DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
           
      
            #左側瀏覽頁簽
            DISPLAY ARRAY g_browser TO s_browse.* ATTRIBUTE(COUNT=g_rec_b)
            
               BEFORE ROW
                  #回歸舊筆數位置 (回到當時異動的筆數)
                  LET g_current_idx = DIALOG.getCurrentRow("s_browse")
                  IF g_current_idx = 0 THEN
                     LET g_current_idx = 1
                  END IF
                  LET g_current_row = g_current_idx  #目前指標
                  LET g_current_sw = TRUE
                  CALL cl_show_fld_cont()     
                  
                  #當每次點任一筆資料都會需要用到               
                  CALL apmt101_fetch("")
 
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
    
               
            
            END DISPLAY
 
            #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
            
            #end add-point
 
            #查詢方案用
            SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
            SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
         
            BEFORE DIALOG
               #先填充browser資料
               IF g_action_choice <> "mainhidden" THEN
                  CALL apmt101_browser_fill(g_wc,"")
               END IF
               CALL cl_navigator_setting(g_current_idx, g_current_cnt)
               LET g_curr_diag = ui.DIALOG.getCurrent()
               #還原為原本指定筆數
               IF g_current_row > 1 THEN
                  #當刪除最後一筆資料時可能產生錯誤, 進行額外判斷
                  IF g_current_row > g_browser.getLength() THEN
                     LET g_current_row = g_browser.getLength()
                  END IF 
                  LET g_current_idx = g_current_row
                  CALL DIALOG.setCurrentRow("s_browse",g_current_idx)
               END IF
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL apmt101_fetch("")   
               END IF          
               CALL cl_notice()
               
               #add-point:ui_dialog段before name="ui_dialog.b_dialog"
               #若執行集團級程式，則不開放切換營運中心的功能
               #IF g_prog = 'apmt101' OR g_prog = 'apmt201' OR g_prog = 'axmt201' THEN                    #160705-00042#11 160713 by sakura mark      
               IF g_prog MATCHES 'apmt101' OR g_prog MATCHES 'apmt201' OR g_prog MATCHES 'axmt201' THEN   #160705-00042#11 160713 by sakura add
                  CALL cl_set_act_visible("logistics", FALSE)
               ELSE
                  CALL cl_set_act_visible("logistics", TRUE)
               END IF
               #end add-point  
            
            AFTER DIALOG
               #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"
               
               #end add-point
            
 
 
         
            #應用 a49 樣板自動產生(Version:4)
            #過濾瀏覽頁資料
            ON ACTION filter
               LET g_action_choice = "fetch"
               #add-point:filter action name="ui_dialog.action.filter"
               
               #end add-point
               CALL apmt101_filter()
               EXIT DIALOG
 
 
 
            
            #第一筆資料
            ON ACTION first
               CALL apmt101_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL apmt101_fetch("N")
               LET g_current_row = g_current_idx
         
            #指定筆資料
            ON ACTION jump
               CALL apmt101_fetch("/")
               LET g_current_row = g_current_idx
         
            #上一筆資料
            ON ACTION previous
               CALL apmt101_fetch("P")
               LET g_current_row = g_current_idx
          
            #最後筆資料
            ON ACTION last 
               CALL apmt101_fetch("L")  
               LET g_current_row = g_current_idx
         
            #離開程式
            ON ACTION exit
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT DIALOG 
         
            #離開程式
            ON ACTION close
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT DIALOG 
    
            #主頁摺疊
            ON ACTION mainhidden 
               LET g_action_choice = "mainhidden"                
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
               #EXIT DIALOG
               
            ON ACTION worksheethidden   #瀏覽頁折疊
               IF g_main_hidden THEN
                  CALL gfrm_curr.setElementHidden("mainlayout",0)
                  CALL gfrm_curr.setElementHidden("worksheet",1)
                  LET g_main_hidden = 0
               ELSE
                  CALL gfrm_curr.setElementHidden("mainlayout",1)
                  CALL gfrm_curr.setElementHidden("worksheet",0)
                  LET g_main_hidden = 1
               END IF
               #EXIT DIALOG
         
            ON ACTION exporttoexcel
               LET g_action_choice="exporttoexcel"
               IF cl_auth_chk_act("exporttoexcel") THEN
                  #browser
                  CALL g_export_node.clear()
                  LET g_export_node[1] = base.typeInfo.create(g_browser)
                  LET g_export_id[1]   = "s_browse"
                  CALL cl_export_to_excel()
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
 
            
            #查詢方案用
            ON ACTION queryplansel
               CALL cl_dlg_qryplan_select() RETURNING ls_wc
               #不是空條件才寫入g_wc跟重新找資料
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  CALL apmt101_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL apmt101_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL apmt101_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
               
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL apmt101_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION demo
            LET g_action_choice="demo"
            IF cl_auth_chk_act("demo") THEN
               
               #add-point:ON ACTION demo name="menu.demo"
               CALL aooi360_02('6',g_prog,g_pmbb_m.pmbbdocno,'','','','','','','','','')
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL apmt101_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               LET g_rep_wc = "pmbadocno = '",g_pmbb_m.pmbbdocno,"' AND pmbaent='",g_enterprise,"'" #160303-00018#1-add
               #END add-point
               &include "erp/apm/apmt101_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               LET g_rep_wc = "pmbadocno = '",g_pmbb_m.pmbbdocno,"' AND pmbaent='",g_enterprise,"'" #160303-00018#1-add
               #END add-point
               &include "erp/apm/apmt101_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL apmt101_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL apmt101_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               
            END IF
 
 
 
 
            
            
 
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL apmt101_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL apmt101_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL apmt101_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow('')
 
 
 
 
            #主選單用ACTION
            &include "main_menu_exit_dialog.4gl"
            &include "relating_action.4gl"
            #交談指令共用ACTION
            &include "common_action.4gl"
            
         END DIALOG 
      
      END IF
      
      #add-point:ui_dialog段 after dialog name="ui_dialog.exit_dialog"
      
      #end add-point
      
      #(ver:50) ---start---
      IF li_exit THEN
         #add-point:ui_dialog段離開dialog前 name="ui_dialog.b_exit"
         
         #end add-point
         EXIT WHILE
      END IF
      #(ver:50) --- end ---
 
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="apmt101.browser_fill" >}
#應用 a29 樣板自動產生(Version:15)
#+ 瀏覽頁簽資料填充(一般單檔)
PRIVATE FUNCTION apmt101_browser_fill(p_wc,ps_page_action) 
   #add-point:browser_fill段define name="browser_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc              STRING
   DEFINE ls_wc             STRING
   DEFINE ps_page_action    STRING
   DEFINE l_searchcol       STRING
   DEFINE l_sql             STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="browser_fill.pre_function"
   
   #end add-point
   
   LET l_searchcol = "pmbbdocno"
 
   LET p_wc = p_wc.trim() #當查詢按下Q時 按下放棄 g_wc = "  " 所以要清掉空白
   IF cl_null(p_wc) THEN  #p_wc 查詢條件
      LET p_wc = " 1=1 " 
   END IF
   #add-point:browser_fill段wc控制 name="browser_fill.wc"
   IF NOT cl_null(g_argv[1]) THEN
      CASE g_argv[1] 
         WHEN '1' LET p_wc = p_wc, " AND pmbbdocno IN (SELECT pmbadocno FROM pmba_t WHERE pmba002 = '1' OR pmba002 = '3' AND pmbaent = ",g_enterprise,") "   #160905-00007#11 Add
         WHEN '2' LET p_wc = p_wc, " AND pmbbdocno IN (SELECT pmbadocno FROM pmba_t WHERE pmba002 = '2' OR pmba002 = '3' AND pmbaent = ",g_enterprise,") "   #160905-00007#11 Add
      END CASE
   END IF
   #end add-point
 
   LET g_sql = " SELECT COUNT(1) FROM pmbb_t ",
               "  ",
               "  ",
               " WHERE pmbbent = " ||g_enterprise|| " AND pmbbsite = '" ||g_site|| "' AND ", 
               p_wc CLIPPED, cl_sql_add_filter("pmbb_t")
                
   #add-point:browser_fill段cnt_sql name="browser_fill.cnt_sql"
   
   #end add-point
                
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE header_cnt_pre FROM g_sql
      EXECUTE header_cnt_pre INTO g_browser_cnt
      FREE header_cnt_pre 
   END IF
   
   #若超過最大顯示筆數
   IF g_browser_cnt > g_max_browse THEN
      IF g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_browser_cnt 
         LET g_errparam.code   = 9035
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
      END IF
   END IF
   
   LET g_error_show = 0
   
   IF ps_page_action = "F" OR
      ps_page_action = "P"  OR
      ps_page_action = "N"  OR
      ps_page_action = "L"  THEN
      LET g_page_action = ps_page_action
   END IF
   
   IF cl_null(g_add_browse) THEN
      #清除畫面
      CLEAR FORM
      INITIALIZE g_pmbb_m.* TO NULL
      CALL g_browser.clear()
      LET g_cnt = 1
      LET ls_wc = p_wc
   ELSE
      LET ls_wc = g_add_browse
      LET g_cnt = g_current_idx
   END IF
   
   LET g_sql = " SELECT t0.pmbbstus,t0.pmbbdocno,t0.pmbb001,t1.pmbal003",
               " FROM pmbb_t t0 ",
               "  ",
                              " LEFT JOIN pmbal_t t1 ON t1.pmbalent="||g_enterprise||" AND t1.pmbaldocno=t0.pmbbdocno AND t1.pmbal001='"||g_dlang||"' ",
 
               " WHERE t0.pmbbent = " ||g_enterprise|| " AND t0.pmbbsite = '" ||g_site|| "' AND ", ls_wc, cl_sql_add_filter("pmbb_t")
   #add-point:browser_fill段fill_wc name="browser_fill.fill_wc"
   
   #end add-point 
   LET g_sql = g_sql, " ORDER BY ",l_searchcol," ",g_order
   #add-point:browser_fill段before_pre name="browser_fill.before_pre"
   
   #end add-point                    
 
   #LET g_sql = cl_sql_add_tabid(g_sql,"pmbb_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_pmbbdocno,g_browser[g_cnt].b_pmbb001, 
          g_browser[g_cnt].b_pmbbdocno_desc
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "foreach:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
         
         
         #add-point:browser_fill段reference name="browser_fill.reference"
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_browser[g_cnt].b_pmbbdocno
      CALL ap_ref_array2(g_ref_fields,"SELECT pmbal002 FROM pmbal_t WHERE pmbalent='"||g_enterprise||"' AND pmbaldocno = ? AND pmbal001='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_browser[g_cnt].b_pmbal002 = g_rtn_fields[1]
      DISPLAY BY NAME g_browser[g_cnt].b_pmbal002
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_browser[g_cnt].b_pmbbdocno
      CALL ap_ref_array2(g_ref_fields,"SELECT pmba002,pmba004,pmba005,pmba026,pmba006 FROM pmba_t WHERE pmbaent='"||g_enterprise||"' AND pmbadocno=? ","") RETURNING g_rtn_fields
      LET g_browser[g_cnt].b_pmba002 = '', g_rtn_fields[1] , ''
      LET g_browser[g_cnt].b_pmba004 = '', g_rtn_fields[2] , ''
      LET g_browser[g_cnt].b_pmba005 = '', g_rtn_fields[3] , ''
      LET g_browser[g_cnt].b_pmba026 = '', g_rtn_fields[4] , ''
      LET g_browser[g_cnt].b_pmba006 = '', g_rtn_fields[5] , ''
      DISPLAY BY NAME g_browser[g_cnt].b_pmba002,g_browser[g_cnt].b_pmba004,g_browser[g_cnt].b_pmba005,g_browser[g_cnt].b_pmba026,g_browser[g_cnt].b_pmba006
         #end add-point
         
         #遮罩相關處理
         CALL apmt101_browser_mask()
         
         
         LET g_cnt = g_cnt + 1
         IF g_cnt > g_max_rec THEN
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
   
   IF cl_null(g_browser[g_cnt].b_pmbbdocno) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_current_cnt = g_browser.getLength()
   LET g_browser_cnt = g_browser.getLength()
   LET g_rec_b = g_browser.getLength()
   LET g_cnt = 0
   DISPLAY g_browser_cnt TO FORMONLY.b_count
   DISPLAY g_browser_cnt TO FORMONLY.h_count
   
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
   
   #add-point:browser_fill段結束前 name="browser_fill.after"
   
   #end add-point   
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apmt101.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION apmt101_construct()
   #add-point:cs段define(客製用) name="cs.define_customerization"
   
   #end add-point
   DEFINE ls_return      STRING
   DEFINE ls_result      STRING 
   DEFINE ls_wc          STRING 
   #add-point:cs段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
   
   #清空畫面&資料初始化
   CLEAR FORM
   INITIALIZE g_pmbb_m.* TO NULL
   INITIALIZE g_wc TO NULL
   LET g_current_row = 1
 
   LET g_qryparam.state = "c"
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #螢幕上取條件
      CONSTRUCT BY NAME g_wc ON pmbbdocno,pmbb001,pmbbdocno_desc,pmbb080,pmbb081,pmbb109,pmbb082,pmbb083, 
          pmbb084,pmbb103,pmbb104,pmbb085,pmbb086,pmbb106,pmbb087,pmbb105,pmbb088,pmbb089,pmbb107,pmbb108, 
          pmbb090,pmbb091,pmbb092,pmbb093,pmbb094,pmbb095,pmbb096,pmbb097,pmbb098,pmbb099,pmbb100,pmbb101, 
          pmbb102,pmbb030,pmbb031,pmbb059,pmbb032,pmbb033,pmbb034,pmbb053,pmbb054,pmbb035,pmbb036,pmbb056, 
          pmbb037,pmbb055,pmbb038,pmbb039,pmbb057,pmbb058,pmbb040,pmbb041,pmbb042,pmbb043,pmbb044,pmbb045, 
          pmbb046,pmbb047,pmbb048,pmbb049,pmbb050,pmbb051,pmbb052,pmbb071,pmbb072,pmbb073,pmbb060,pmbb061, 
          pmbb066,pmbb062,pmbb067,pmbb063,pmbb068,pmbb064,pmbb069,pmbb065,pmbb070,total,pmbb002,pmbb003, 
          pmbb004,pmbb005,pmbb006,pmbb007,pmbb008,pmbb009,pmbb019,pmbb010,pmbb020,pmbb011,pmbb012,pmbb013, 
          pmbb014,pmbb015,pmbb016,pmbb017,pmbb018,pmbbownid,pmbbowndp,pmbbcrtid,pmbbcrtdp,pmbbcrtdt, 
          pmbbmodid,pmbbmoddt
      
         BEFORE CONSTRUCT                                    
            #add-point:cs段more_construct name="cs.before_construct"
            
            #end add-point             
      
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<pmbbcrtdt>>----
         AFTER FIELD pmbbcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<pmbbmoddt>>----
         AFTER FIELD pmbbmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<pmbbcnfdt>>----
         
         #----<<pmbbpstdt>>----
 
 
 
      
         #一般欄位
                  #Ctrlp:construct.c.pmbbdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbbdocno
            #add-point:ON ACTION controlp INFIELD pmbbdocno name="construct.c.pmbbdocno"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_pmbadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmbbdocno  #顯示到畫面上

            NEXT FIELD pmbbdocno                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbbdocno
            #add-point:BEFORE FIELD pmbbdocno name="construct.b.pmbbdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbbdocno
            
            #add-point:AFTER FIELD pmbbdocno name="construct.a.pmbbdocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb001
            #add-point:ON ACTION controlp INFIELD pmbb001 name="construct.c.pmbb001"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			CASE g_argv[1] 
               WHEN '1' LET g_qryparam.where=" (pmaa002 = '1' OR pmaa002 = '3') "
               WHEN '2' LET g_qryparam.where=" (pmaa002 = '2' OR pmaa002 = '3') "
            END CASE
            CALL q_pmaa001_4()                           #呼叫開窗
            LET g_qryparam.where=" "
            DISPLAY g_qryparam.return1 TO pmbb001  #顯示到畫面上

            NEXT FIELD pmbb001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb001
            #add-point:BEFORE FIELD pmbb001 name="construct.b.pmbb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb001
            
            #add-point:AFTER FIELD pmbb001 name="construct.a.pmbb001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbbdocno_desc
            #add-point:BEFORE FIELD pmbbdocno_desc name="construct.b.pmbbdocno_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbbdocno_desc
            
            #add-point:AFTER FIELD pmbbdocno_desc name="construct.a.pmbbdocno_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbbdocno_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbbdocno_desc
            #add-point:ON ACTION controlp INFIELD pmbbdocno_desc name="construct.c.pmbbdocno_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb080
            #add-point:BEFORE FIELD pmbb080 name="construct.b.pmbb080"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb080
            
            #add-point:AFTER FIELD pmbb080 name="construct.a.pmbb080"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb080
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb080
            #add-point:ON ACTION controlp INFIELD pmbb080 name="construct.c.pmbb080"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmbb081
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb081
            #add-point:ON ACTION controlp INFIELD pmbb081 name="construct.c.pmbb081"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmbb081  #顯示到畫面上

            NEXT FIELD pmbb081                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb081
            #add-point:BEFORE FIELD pmbb081 name="construct.b.pmbb081"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb081
            
            #add-point:AFTER FIELD pmbb081 name="construct.a.pmbb081"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb109
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb109
            #add-point:ON ACTION controlp INFIELD pmbb109 name="construct.c.pmbb109"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmbb109  #顯示到畫面上
            NEXT FIELD pmbb109                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb109
            #add-point:BEFORE FIELD pmbb109 name="construct.b.pmbb109"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb109
            
            #add-point:AFTER FIELD pmbb109 name="construct.a.pmbb109"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb082
            #add-point:BEFORE FIELD pmbb082 name="construct.b.pmbb082"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb082
            
            #add-point:AFTER FIELD pmbb082 name="construct.a.pmbb082"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb082
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb082
            #add-point:ON ACTION controlp INFIELD pmbb082 name="construct.c.pmbb082"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmbb083
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb083
            #add-point:ON ACTION controlp INFIELD pmbb083 name="construct.c.pmbb083"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			
            IF g_site = 'ALL' THEN
               LET g_qryparam.arg1 = g_site_t
            ELSE
               LET g_qryparam.arg1 = g_site
            END IF
            
            CALL q_ooaj002_1()                            #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmbb083  #顯示到畫面上

            NEXT FIELD pmbb083                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb083
            #add-point:BEFORE FIELD pmbb083 name="construct.b.pmbb083"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb083
            
            #add-point:AFTER FIELD pmbb083 name="construct.a.pmbb083"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb084
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb084
            #add-point:ON ACTION controlp INFIELD pmbb084 name="construct.c.pmbb084"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			#LET g_qryparam.arg1 = g_site
            IF g_site = 'ALL' THEN 
               LET g_qryparam.arg1 = g_site_t
            ELSE
               LET g_qryparam.arg1 = g_site
            END IF
            CALL q_oodb002_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmbb084  #顯示到畫面上
            LET g_qryparam.arg1 = ''

            NEXT FIELD pmbb084                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb084
            #add-point:BEFORE FIELD pmbb084 name="construct.b.pmbb084"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb084
            
            #add-point:AFTER FIELD pmbb084 name="construct.a.pmbb084"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb103
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb103
            #add-point:ON ACTION controlp INFIELD pmbb103 name="construct.c.pmbb103"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = '238'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmbb103  #顯示到畫面上

            NEXT FIELD pmbb103                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb103
            #add-point:BEFORE FIELD pmbb103 name="construct.b.pmbb103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb103
            
            #add-point:AFTER FIELD pmbb103 name="construct.a.pmbb103"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb104
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb104
            #add-point:ON ACTION controlp INFIELD pmbb104 name="construct.c.pmbb104"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_xmah001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmbb104  #顯示到畫面上

            NEXT FIELD pmbb104                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb104
            #add-point:BEFORE FIELD pmbb104 name="construct.b.pmbb104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb104
            
            #add-point:AFTER FIELD pmbb104 name="construct.a.pmbb104"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb085
            #add-point:BEFORE FIELD pmbb085 name="construct.b.pmbb085"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb085
            
            #add-point:AFTER FIELD pmbb085 name="construct.a.pmbb085"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb085
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb085
            #add-point:ON ACTION controlp INFIELD pmbb085 name="construct.c.pmbb085"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb086
            #add-point:BEFORE FIELD pmbb086 name="construct.b.pmbb086"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb086
            
            #add-point:AFTER FIELD pmbb086 name="construct.a.pmbb086"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb086
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb086
            #add-point:ON ACTION controlp INFIELD pmbb086 name="construct.c.pmbb086"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmbb106
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb106
            #add-point:ON ACTION controlp INFIELD pmbb106 name="construct.c.pmbb106"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			#給予arg
            LET g_qryparam.arg1 = g_ooef019 #
            LET g_qryparam.arg2 = "2" #
            
            CALL q_isac002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmbb106  #顯示到畫面上

            NEXT FIELD pmbb106                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb106
            #add-point:BEFORE FIELD pmbb106 name="construct.b.pmbb106"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb106
            
            #add-point:AFTER FIELD pmbb106 name="construct.a.pmbb106"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb087
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb087
            #add-point:ON ACTION controlp INFIELD pmbb087 name="construct.c.pmbb087"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = '2'
            CALL q_pmbd002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmbb087  #顯示到畫面上

            NEXT FIELD pmbb087                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb087
            #add-point:BEFORE FIELD pmbb087 name="construct.b.pmbb087"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb087
            
            #add-point:AFTER FIELD pmbb087 name="construct.a.pmbb087"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb105
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb105
            #add-point:ON ACTION controlp INFIELD pmbb105 name="construct.c.pmbb105"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = "3111"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmbb105  #顯示到畫面上

            NEXT FIELD pmbb105                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb105
            #add-point:BEFORE FIELD pmbb105 name="construct.b.pmbb105"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb105
            
            #add-point:AFTER FIELD pmbb105 name="construct.a.pmbb105"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb088
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb088
            #add-point:ON ACTION controlp INFIELD pmbb088 name="construct.c.pmbb088"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			  #160621-00003#3 20160627 modify by beckxie---S
			   #LET g_qryparam.arg1 = "275"
            #CALL q_oocq002()                           #呼叫開窗
            LET g_qryparam.arg1 = '1'
            CALL q_oojd001_1()
            #160621-00003#3 20160627 modify by beckxie---E
            DISPLAY g_qryparam.return1 TO pmbb088  #顯示到畫面上

            NEXT FIELD pmbb088                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb088
            #add-point:BEFORE FIELD pmbb088 name="construct.b.pmbb088"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb088
            
            #add-point:AFTER FIELD pmbb088 name="construct.a.pmbb088"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb089
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb089
            #add-point:ON ACTION controlp INFIELD pmbb089 name="construct.c.pmbb089"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = '295'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmbb089  #顯示到畫面上

            NEXT FIELD pmbb089                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb089
            #add-point:BEFORE FIELD pmbb089 name="construct.b.pmbb089"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb089
            
            #add-point:AFTER FIELD pmbb089 name="construct.a.pmbb089"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb107
            #add-point:BEFORE FIELD pmbb107 name="construct.b.pmbb107"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb107
            
            #add-point:AFTER FIELD pmbb107 name="construct.a.pmbb107"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb107
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb107
            #add-point:ON ACTION controlp INFIELD pmbb107 name="construct.c.pmbb107"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb108
            #add-point:BEFORE FIELD pmbb108 name="construct.b.pmbb108"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb108
            
            #add-point:AFTER FIELD pmbb108 name="construct.a.pmbb108"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb108
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb108
            #add-point:ON ACTION controlp INFIELD pmbb108 name="construct.c.pmbb108"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmbb090
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb090
            #add-point:ON ACTION controlp INFIELD pmbb090 name="construct.c.pmbb090"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = '263'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmbb090  #顯示到畫面上

            NEXT FIELD pmbb090                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb090
            #add-point:BEFORE FIELD pmbb090 name="construct.b.pmbb090"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb090
            
            #add-point:AFTER FIELD pmbb090 name="construct.a.pmbb090"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb091
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb091
            #add-point:ON ACTION controlp INFIELD pmbb091 name="construct.c.pmbb091"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_pmbb091()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmbb091  #顯示到畫面上

            NEXT FIELD pmbb091                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb091
            #add-point:BEFORE FIELD pmbb091 name="construct.b.pmbb091"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb091
            
            #add-point:AFTER FIELD pmbb091 name="construct.a.pmbb091"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb092
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb092
            #add-point:ON ACTION controlp INFIELD pmbb092 name="construct.c.pmbb092"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_pmbb092()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmbb092  #顯示到畫面上

            NEXT FIELD pmbb092                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb092
            #add-point:BEFORE FIELD pmbb092 name="construct.b.pmbb092"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb092
            
            #add-point:AFTER FIELD pmbb092 name="construct.a.pmbb092"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb093
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb093
            #add-point:ON ACTION controlp INFIELD pmbb093 name="construct.c.pmbb093"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = '262'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmbb093  #顯示到畫面上

            NEXT FIELD pmbb093                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb093
            #add-point:BEFORE FIELD pmbb093 name="construct.b.pmbb093"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb093
            
            #add-point:AFTER FIELD pmbb093 name="construct.a.pmbb093"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb094
            #add-point:BEFORE FIELD pmbb094 name="construct.b.pmbb094"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb094
            
            #add-point:AFTER FIELD pmbb094 name="construct.a.pmbb094"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb094
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb094
            #add-point:ON ACTION controlp INFIELD pmbb094 name="construct.c.pmbb094"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb095
            #add-point:BEFORE FIELD pmbb095 name="construct.b.pmbb095"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb095
            
            #add-point:AFTER FIELD pmbb095 name="construct.a.pmbb095"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb095
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb095
            #add-point:ON ACTION controlp INFIELD pmbb095 name="construct.c.pmbb095"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb096
            #add-point:BEFORE FIELD pmbb096 name="construct.b.pmbb096"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb096
            
            #add-point:AFTER FIELD pmbb096 name="construct.a.pmbb096"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb096
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb096
            #add-point:ON ACTION controlp INFIELD pmbb096 name="construct.c.pmbb096"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmbb097
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb097
            #add-point:ON ACTION controlp INFIELD pmbb097 name="construct.c.pmbb097"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.where=" (pmaa002 = '1' OR pmaa002 = '3') "
            CALL q_pmaa001_4()                           #呼叫開窗
            LET g_qryparam.where=" "
            DISPLAY g_qryparam.return1 TO pmbb097  #顯示到畫面上

            NEXT FIELD pmbb097                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb097
            #add-point:BEFORE FIELD pmbb097 name="construct.b.pmbb097"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb097
            
            #add-point:AFTER FIELD pmbb097 name="construct.a.pmbb097"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb098
            #add-point:BEFORE FIELD pmbb098 name="construct.b.pmbb098"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb098
            
            #add-point:AFTER FIELD pmbb098 name="construct.a.pmbb098"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb098
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb098
            #add-point:ON ACTION controlp INFIELD pmbb098 name="construct.c.pmbb098"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb099
            #add-point:BEFORE FIELD pmbb099 name="construct.b.pmbb099"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb099
            
            #add-point:AFTER FIELD pmbb099 name="construct.a.pmbb099"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb099
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb099
            #add-point:ON ACTION controlp INFIELD pmbb099 name="construct.c.pmbb099"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb100
            #add-point:BEFORE FIELD pmbb100 name="construct.b.pmbb100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb100
            
            #add-point:AFTER FIELD pmbb100 name="construct.a.pmbb100"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb100
            #add-point:ON ACTION controlp INFIELD pmbb100 name="construct.c.pmbb100"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb101
            #add-point:BEFORE FIELD pmbb101 name="construct.b.pmbb101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb101
            
            #add-point:AFTER FIELD pmbb101 name="construct.a.pmbb101"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb101
            #add-point:ON ACTION controlp INFIELD pmbb101 name="construct.c.pmbb101"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb102
            #add-point:BEFORE FIELD pmbb102 name="construct.b.pmbb102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb102
            
            #add-point:AFTER FIELD pmbb102 name="construct.a.pmbb102"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb102
            #add-point:ON ACTION controlp INFIELD pmbb102 name="construct.c.pmbb102"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb030
            #add-point:BEFORE FIELD pmbb030 name="construct.b.pmbb030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb030
            
            #add-point:AFTER FIELD pmbb030 name="construct.a.pmbb030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb030
            #add-point:ON ACTION controlp INFIELD pmbb030 name="construct.c.pmbb030"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmbb031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb031
            #add-point:ON ACTION controlp INFIELD pmbb031 name="construct.c.pmbb031"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmbb031  #顯示到畫面上

            NEXT FIELD pmbb031                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb031
            #add-point:BEFORE FIELD pmbb031 name="construct.b.pmbb031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb031
            
            #add-point:AFTER FIELD pmbb031 name="construct.a.pmbb031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb059
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb059
            #add-point:ON ACTION controlp INFIELD pmbb059 name="construct.c.pmbb059"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmbb059  #顯示到畫面上
            NEXT FIELD pmbb059                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb059
            #add-point:BEFORE FIELD pmbb059 name="construct.b.pmbb059"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb059
            
            #add-point:AFTER FIELD pmbb059 name="construct.a.pmbb059"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb032
            #add-point:BEFORE FIELD pmbb032 name="construct.b.pmbb032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb032
            
            #add-point:AFTER FIELD pmbb032 name="construct.a.pmbb032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb032
            #add-point:ON ACTION controlp INFIELD pmbb032 name="construct.c.pmbb032"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmbb033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb033
            #add-point:ON ACTION controlp INFIELD pmbb033 name="construct.c.pmbb033"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            IF g_site = 'ALL' THEN
               LET g_qryparam.arg1 = g_site_t
            ELSE
               LET g_qryparam.arg1 = g_site
            END IF
            
            CALL q_ooaj002_1()                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmbb033  #顯示到畫面上

            NEXT FIELD pmbb033                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb033
            #add-point:BEFORE FIELD pmbb033 name="construct.b.pmbb033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb033
            
            #add-point:AFTER FIELD pmbb033 name="construct.a.pmbb033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb034
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb034
            #add-point:ON ACTION controlp INFIELD pmbb034 name="construct.c.pmbb034"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			#LET g_qryparam.arg1 = g_site
            IF g_site = 'ALL' THEN 
               LET g_qryparam.arg1 = g_site_t
            ELSE
               LET g_qryparam.arg1 = g_site
            END IF
            CALL q_oodb002_3()                         #呼叫開窗
            LET g_qryparam.arg1 = ''
            DISPLAY g_qryparam.return1 TO pmbb034  #顯示到畫面上

            NEXT FIELD pmbb034                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb034
            #add-point:BEFORE FIELD pmbb034 name="construct.b.pmbb034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb034
            
            #add-point:AFTER FIELD pmbb034 name="construct.a.pmbb034"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb053
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb053
            #add-point:ON ACTION controlp INFIELD pmbb053 name="construct.c.pmbb053"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			#LET g_qryparam.arg1 = '238'   #170213-00038#2   mark
            #CALL q_oocq002()                           #呼叫開窗  #170213-00038#2   mark
            CALL q_oocq002_238()   #170213-00038#2   add
            DISPLAY g_qryparam.return1 TO pmbb053  #顯示到畫面上

            NEXT FIELD pmbb053                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb053
            #add-point:BEFORE FIELD pmbb053 name="construct.b.pmbb053"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb053
            
            #add-point:AFTER FIELD pmbb053 name="construct.a.pmbb053"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb054
            #add-point:BEFORE FIELD pmbb054 name="construct.b.pmbb054"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb054
            
            #add-point:AFTER FIELD pmbb054 name="construct.a.pmbb054"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb054
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb054
            #add-point:ON ACTION controlp INFIELD pmbb054 name="construct.c.pmbb054"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_pmam001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmbb054  #顯示到畫面上

            NEXT FIELD pmbb054                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb035
            #add-point:BEFORE FIELD pmbb035 name="construct.b.pmbb035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb035
            
            #add-point:AFTER FIELD pmbb035 name="construct.a.pmbb035"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb035
            #add-point:ON ACTION controlp INFIELD pmbb035 name="construct.c.pmbb035"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb036
            #add-point:BEFORE FIELD pmbb036 name="construct.b.pmbb036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb036
            
            #add-point:AFTER FIELD pmbb036 name="construct.a.pmbb036"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb036
            #add-point:ON ACTION controlp INFIELD pmbb036 name="construct.c.pmbb036"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmbb056
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb056
            #add-point:ON ACTION controlp INFIELD pmbb056 name="construct.c.pmbb056"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			#給予arg
            LET g_qryparam.arg1 = g_ooef019 #
            LET g_qryparam.arg2 = "1" #
            CALL q_isac002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmbb056  #顯示到畫面上

            NEXT FIELD pmbb056                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb056
            #add-point:BEFORE FIELD pmbb056 name="construct.b.pmbb056"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb056
            
            #add-point:AFTER FIELD pmbb056 name="construct.a.pmbb056"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb037
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb037
            #add-point:ON ACTION controlp INFIELD pmbb037 name="construct.c.pmbb037"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = '1'
            CALL q_pmbd002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmbb037  #顯示到畫面上

            NEXT FIELD pmbb037                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb037
            #add-point:BEFORE FIELD pmbb037 name="construct.b.pmbb037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb037
            
            #add-point:AFTER FIELD pmbb037 name="construct.a.pmbb037"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb055
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb055
            #add-point:ON ACTION controlp INFIELD pmbb055 name="construct.c.pmbb055"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			#LET g_qryparam.arg1 = '3211'   #170213-00038#2   mark
         #   CALL q_oocq002()                           #呼叫開窗  #170213-00038#2   mark
            CALL q_oocq002_3211()  #170213-00038#2   add
            DISPLAY g_qryparam.return1 TO pmbb055  #顯示到畫面上

            NEXT FIELD pmbb055                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb055
            #add-point:BEFORE FIELD pmbb055 name="construct.b.pmbb055"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb055
            
            #add-point:AFTER FIELD pmbb055 name="construct.a.pmbb055"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb038
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb038
            #add-point:ON ACTION controlp INFIELD pmbb038 name="construct.c.pmbb038"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			   #160621-00003#3 20160627 modify by beckxie---S
			   #LET g_qryparam.arg1 = "275"
            #CALL q_oocq002()                           #呼叫開窗
            LET g_qryparam.arg1 = '2'
            CALL q_oojd001_1()
            #160621-00003#3 20160627 modify by beckxie---E
            DISPLAY g_qryparam.return1 TO pmbb038  #顯示到畫面上

            NEXT FIELD pmbb038                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb038
            #add-point:BEFORE FIELD pmbb038 name="construct.b.pmbb038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb038
            
            #add-point:AFTER FIELD pmbb038 name="construct.a.pmbb038"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb039
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb039
            #add-point:ON ACTION controlp INFIELD pmbb039 name="construct.c.pmbb039"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			#LET g_qryparam.arg1 = '264'  #170213-00038#2   mark
         #   CALL q_oocq002()                           #呼叫開窗  #170213-00038#2   mark
            CALL q_oocq002_264()  #170213-00038#2   add
            DISPLAY g_qryparam.return1 TO pmbb039  #顯示到畫面上

            NEXT FIELD pmbb039                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb039
            #add-point:BEFORE FIELD pmbb039 name="construct.b.pmbb039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb039
            
            #add-point:AFTER FIELD pmbb039 name="construct.a.pmbb039"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb057
            #add-point:BEFORE FIELD pmbb057 name="construct.b.pmbb057"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb057
            
            #add-point:AFTER FIELD pmbb057 name="construct.a.pmbb057"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb057
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb057
            #add-point:ON ACTION controlp INFIELD pmbb057 name="construct.c.pmbb057"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb058
            #add-point:BEFORE FIELD pmbb058 name="construct.b.pmbb058"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb058
            
            #add-point:AFTER FIELD pmbb058 name="construct.a.pmbb058"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb058
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb058
            #add-point:ON ACTION controlp INFIELD pmbb058 name="construct.c.pmbb058"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmbb040
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb040
            #add-point:ON ACTION controlp INFIELD pmbb040 name="construct.c.pmbb040"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			#LET g_qryparam.arg1 = '263'  #170213-00038#2   mark
          #  CALL q_oocq002()                           #呼叫開窗  #170213-00038#2   mark
            CALL q_oocq002_263()  #170213-00038#2   add
            DISPLAY g_qryparam.return1 TO pmbb040  #顯示到畫面上

            NEXT FIELD pmbb040                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb040
            #add-point:BEFORE FIELD pmbb040 name="construct.b.pmbb040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb040
            
            #add-point:AFTER FIELD pmbb040 name="construct.a.pmbb040"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb041
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb041
            #add-point:ON ACTION controlp INFIELD pmbb041 name="construct.c.pmbb041"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_pmbb041()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmbb041  #顯示到畫面上

            NEXT FIELD pmbb041                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb041
            #add-point:BEFORE FIELD pmbb041 name="construct.b.pmbb041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb041
            
            #add-point:AFTER FIELD pmbb041 name="construct.a.pmbb041"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb042
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb042
            #add-point:ON ACTION controlp INFIELD pmbb042 name="construct.c.pmbb042"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_pmbb042()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmbb042  #顯示到畫面上

            NEXT FIELD pmbb042                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb042
            #add-point:BEFORE FIELD pmbb042 name="construct.b.pmbb042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb042
            
            #add-point:AFTER FIELD pmbb042 name="construct.a.pmbb042"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb043
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb043
            #add-point:ON ACTION controlp INFIELD pmbb043 name="construct.c.pmbb043"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			#LET g_qryparam.arg1 = '262'  #170213-00038#2   mark
          #  CALL q_oocq002()                           #呼叫開窗  #170213-00038#2   mark
            CALL q_oocq002_262()  #170213-00038#2   add
            DISPLAY g_qryparam.return1 TO pmbb043  #顯示到畫面上

            NEXT FIELD pmbb043                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb043
            #add-point:BEFORE FIELD pmbb043 name="construct.b.pmbb043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb043
            
            #add-point:AFTER FIELD pmbb043 name="construct.a.pmbb043"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb044
            #add-point:BEFORE FIELD pmbb044 name="construct.b.pmbb044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb044
            
            #add-point:AFTER FIELD pmbb044 name="construct.a.pmbb044"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb044
            #add-point:ON ACTION controlp INFIELD pmbb044 name="construct.c.pmbb044"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb045
            #add-point:BEFORE FIELD pmbb045 name="construct.b.pmbb045"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb045
            
            #add-point:AFTER FIELD pmbb045 name="construct.a.pmbb045"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb045
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb045
            #add-point:ON ACTION controlp INFIELD pmbb045 name="construct.c.pmbb045"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb046
            #add-point:BEFORE FIELD pmbb046 name="construct.b.pmbb046"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb046
            
            #add-point:AFTER FIELD pmbb046 name="construct.a.pmbb046"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb046
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb046
            #add-point:ON ACTION controlp INFIELD pmbb046 name="construct.c.pmbb046"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmbb047
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb047
            #add-point:ON ACTION controlp INFIELD pmbb047 name="construct.c.pmbb047"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.where=" (pmaa002 = '1' OR pmaa002 = '3') "
            CALL q_pmaa001_4()                           #呼叫開窗
            LET g_qryparam.where=" "
            DISPLAY g_qryparam.return1 TO pmbb047  #顯示到畫面上

            NEXT FIELD pmbb047                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb047
            #add-point:BEFORE FIELD pmbb047 name="construct.b.pmbb047"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb047
            
            #add-point:AFTER FIELD pmbb047 name="construct.a.pmbb047"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb048
            #add-point:BEFORE FIELD pmbb048 name="construct.b.pmbb048"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb048
            
            #add-point:AFTER FIELD pmbb048 name="construct.a.pmbb048"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb048
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb048
            #add-point:ON ACTION controlp INFIELD pmbb048 name="construct.c.pmbb048"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb049
            #add-point:BEFORE FIELD pmbb049 name="construct.b.pmbb049"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb049
            
            #add-point:AFTER FIELD pmbb049 name="construct.a.pmbb049"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb049
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb049
            #add-point:ON ACTION controlp INFIELD pmbb049 name="construct.c.pmbb049"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb050
            #add-point:BEFORE FIELD pmbb050 name="construct.b.pmbb050"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb050
            
            #add-point:AFTER FIELD pmbb050 name="construct.a.pmbb050"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb050
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb050
            #add-point:ON ACTION controlp INFIELD pmbb050 name="construct.c.pmbb050"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb051
            #add-point:BEFORE FIELD pmbb051 name="construct.b.pmbb051"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb051
            
            #add-point:AFTER FIELD pmbb051 name="construct.a.pmbb051"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb051
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb051
            #add-point:ON ACTION controlp INFIELD pmbb051 name="construct.c.pmbb051"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb052
            #add-point:BEFORE FIELD pmbb052 name="construct.b.pmbb052"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb052
            
            #add-point:AFTER FIELD pmbb052 name="construct.a.pmbb052"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb052
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb052
            #add-point:ON ACTION controlp INFIELD pmbb052 name="construct.c.pmbb052"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb071
            #add-point:BEFORE FIELD pmbb071 name="construct.b.pmbb071"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb071
            
            #add-point:AFTER FIELD pmbb071 name="construct.a.pmbb071"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb071
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb071
            #add-point:ON ACTION controlp INFIELD pmbb071 name="construct.c.pmbb071"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb072
            #add-point:BEFORE FIELD pmbb072 name="construct.b.pmbb072"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb072
            
            #add-point:AFTER FIELD pmbb072 name="construct.a.pmbb072"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb072
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb072
            #add-point:ON ACTION controlp INFIELD pmbb072 name="construct.c.pmbb072"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb073
            #add-point:BEFORE FIELD pmbb073 name="construct.b.pmbb073"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb073
            
            #add-point:AFTER FIELD pmbb073 name="construct.a.pmbb073"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb073
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb073
            #add-point:ON ACTION controlp INFIELD pmbb073 name="construct.c.pmbb073"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb060
            #add-point:BEFORE FIELD pmbb060 name="construct.b.pmbb060"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb060
            
            #add-point:AFTER FIELD pmbb060 name="construct.a.pmbb060"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb060
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb060
            #add-point:ON ACTION controlp INFIELD pmbb060 name="construct.c.pmbb060"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb061
            #add-point:BEFORE FIELD pmbb061 name="construct.b.pmbb061"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb061
            
            #add-point:AFTER FIELD pmbb061 name="construct.a.pmbb061"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb061
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb061
            #add-point:ON ACTION controlp INFIELD pmbb061 name="construct.c.pmbb061"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb066
            #add-point:BEFORE FIELD pmbb066 name="construct.b.pmbb066"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb066
            
            #add-point:AFTER FIELD pmbb066 name="construct.a.pmbb066"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb066
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb066
            #add-point:ON ACTION controlp INFIELD pmbb066 name="construct.c.pmbb066"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb062
            #add-point:BEFORE FIELD pmbb062 name="construct.b.pmbb062"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb062
            
            #add-point:AFTER FIELD pmbb062 name="construct.a.pmbb062"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb062
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb062
            #add-point:ON ACTION controlp INFIELD pmbb062 name="construct.c.pmbb062"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb067
            #add-point:BEFORE FIELD pmbb067 name="construct.b.pmbb067"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb067
            
            #add-point:AFTER FIELD pmbb067 name="construct.a.pmbb067"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb067
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb067
            #add-point:ON ACTION controlp INFIELD pmbb067 name="construct.c.pmbb067"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb063
            #add-point:BEFORE FIELD pmbb063 name="construct.b.pmbb063"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb063
            
            #add-point:AFTER FIELD pmbb063 name="construct.a.pmbb063"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb063
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb063
            #add-point:ON ACTION controlp INFIELD pmbb063 name="construct.c.pmbb063"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb068
            #add-point:BEFORE FIELD pmbb068 name="construct.b.pmbb068"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb068
            
            #add-point:AFTER FIELD pmbb068 name="construct.a.pmbb068"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb068
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb068
            #add-point:ON ACTION controlp INFIELD pmbb068 name="construct.c.pmbb068"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb064
            #add-point:BEFORE FIELD pmbb064 name="construct.b.pmbb064"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb064
            
            #add-point:AFTER FIELD pmbb064 name="construct.a.pmbb064"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb064
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb064
            #add-point:ON ACTION controlp INFIELD pmbb064 name="construct.c.pmbb064"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb069
            #add-point:BEFORE FIELD pmbb069 name="construct.b.pmbb069"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb069
            
            #add-point:AFTER FIELD pmbb069 name="construct.a.pmbb069"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb069
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb069
            #add-point:ON ACTION controlp INFIELD pmbb069 name="construct.c.pmbb069"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb065
            #add-point:BEFORE FIELD pmbb065 name="construct.b.pmbb065"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb065
            
            #add-point:AFTER FIELD pmbb065 name="construct.a.pmbb065"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb065
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb065
            #add-point:ON ACTION controlp INFIELD pmbb065 name="construct.c.pmbb065"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb070
            #add-point:BEFORE FIELD pmbb070 name="construct.b.pmbb070"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb070
            
            #add-point:AFTER FIELD pmbb070 name="construct.a.pmbb070"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb070
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb070
            #add-point:ON ACTION controlp INFIELD pmbb070 name="construct.c.pmbb070"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD total
            #add-point:BEFORE FIELD total name="construct.b.total"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD total
            
            #add-point:AFTER FIELD total name="construct.a.total"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.total
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD total
            #add-point:ON ACTION controlp INFIELD total name="construct.c.total"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb002
            #add-point:BEFORE FIELD pmbb002 name="construct.b.pmbb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb002
            
            #add-point:AFTER FIELD pmbb002 name="construct.a.pmbb002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb002
            #add-point:ON ACTION controlp INFIELD pmbb002 name="construct.c.pmbb002"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmbb003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb003
            #add-point:ON ACTION controlp INFIELD pmbb003 name="construct.c.pmbb003"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmbb003  #顯示到畫面上

            NEXT FIELD pmbb003                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb003
            #add-point:BEFORE FIELD pmbb003 name="construct.b.pmbb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb003
            
            #add-point:AFTER FIELD pmbb003 name="construct.a.pmbb003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb004
            #add-point:ON ACTION controlp INFIELD pmbb004 name="construct.c.pmbb004"
            #ming 20140817 add --------------------------------------(S) 
            #信用評等的開窗與校驗都從xmaa_t改成xmaj_t 
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xmaj001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmbb004  #顯示到畫面上
            NEXT FIELD pmbb004                     #返回原欄位
            #ming 20140817 add --------------------------------------(E)


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb004
            #add-point:BEFORE FIELD pmbb004 name="construct.b.pmbb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb004
            
            #add-point:AFTER FIELD pmbb004 name="construct.a.pmbb004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb005
            #add-point:ON ACTION controlp INFIELD pmbb005 name="construct.c.pmbb005"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            IF g_site = 'ALL' THEN
               LET g_qryparam.arg1 = g_site_t
            ELSE
               LET g_qryparam.arg1 = g_site
            END IF
            
            CALL q_ooaj002_1()                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmbb005  #顯示到畫面上

            NEXT FIELD pmbb005                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb005
            #add-point:BEFORE FIELD pmbb005 name="construct.b.pmbb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb005
            
            #add-point:AFTER FIELD pmbb005 name="construct.a.pmbb005"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb006
            #add-point:BEFORE FIELD pmbb006 name="construct.b.pmbb006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb006
            
            #add-point:AFTER FIELD pmbb006 name="construct.a.pmbb006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb006
            #add-point:ON ACTION controlp INFIELD pmbb006 name="construct.c.pmbb006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb007
            #add-point:BEFORE FIELD pmbb007 name="construct.b.pmbb007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb007
            
            #add-point:AFTER FIELD pmbb007 name="construct.a.pmbb007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb007
            #add-point:ON ACTION controlp INFIELD pmbb007 name="construct.c.pmbb007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb008
            #add-point:BEFORE FIELD pmbb008 name="construct.b.pmbb008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb008
            
            #add-point:AFTER FIELD pmbb008 name="construct.a.pmbb008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb008
            #add-point:ON ACTION controlp INFIELD pmbb008 name="construct.c.pmbb008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb009
            #add-point:BEFORE FIELD pmbb009 name="construct.b.pmbb009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb009
            
            #add-point:AFTER FIELD pmbb009 name="construct.a.pmbb009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb009
            #add-point:ON ACTION controlp INFIELD pmbb009 name="construct.c.pmbb009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb019
            #add-point:BEFORE FIELD pmbb019 name="construct.b.pmbb019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb019
            
            #add-point:AFTER FIELD pmbb019 name="construct.a.pmbb019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb019
            #add-point:ON ACTION controlp INFIELD pmbb019 name="construct.c.pmbb019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb010
            #add-point:BEFORE FIELD pmbb010 name="construct.b.pmbb010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb010
            
            #add-point:AFTER FIELD pmbb010 name="construct.a.pmbb010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb010
            #add-point:ON ACTION controlp INFIELD pmbb010 name="construct.c.pmbb010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb020
            #add-point:BEFORE FIELD pmbb020 name="construct.b.pmbb020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb020
            
            #add-point:AFTER FIELD pmbb020 name="construct.a.pmbb020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb020
            #add-point:ON ACTION controlp INFIELD pmbb020 name="construct.c.pmbb020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb011
            #add-point:BEFORE FIELD pmbb011 name="construct.b.pmbb011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb011
            
            #add-point:AFTER FIELD pmbb011 name="construct.a.pmbb011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb011
            #add-point:ON ACTION controlp INFIELD pmbb011 name="construct.c.pmbb011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb012
            #add-point:BEFORE FIELD pmbb012 name="construct.b.pmbb012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb012
            
            #add-point:AFTER FIELD pmbb012 name="construct.a.pmbb012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb012
            #add-point:ON ACTION controlp INFIELD pmbb012 name="construct.c.pmbb012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb013
            #add-point:BEFORE FIELD pmbb013 name="construct.b.pmbb013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb013
            
            #add-point:AFTER FIELD pmbb013 name="construct.a.pmbb013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb013
            #add-point:ON ACTION controlp INFIELD pmbb013 name="construct.c.pmbb013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb014
            #add-point:BEFORE FIELD pmbb014 name="construct.b.pmbb014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb014
            
            #add-point:AFTER FIELD pmbb014 name="construct.a.pmbb014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb014
            #add-point:ON ACTION controlp INFIELD pmbb014 name="construct.c.pmbb014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb015
            #add-point:BEFORE FIELD pmbb015 name="construct.b.pmbb015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb015
            
            #add-point:AFTER FIELD pmbb015 name="construct.a.pmbb015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb015
            #add-point:ON ACTION controlp INFIELD pmbb015 name="construct.c.pmbb015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb016
            #add-point:BEFORE FIELD pmbb016 name="construct.b.pmbb016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb016
            
            #add-point:AFTER FIELD pmbb016 name="construct.a.pmbb016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb016
            #add-point:ON ACTION controlp INFIELD pmbb016 name="construct.c.pmbb016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb017
            #add-point:BEFORE FIELD pmbb017 name="construct.b.pmbb017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb017
            
            #add-point:AFTER FIELD pmbb017 name="construct.a.pmbb017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb017
            #add-point:ON ACTION controlp INFIELD pmbb017 name="construct.c.pmbb017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb018
            #add-point:BEFORE FIELD pmbb018 name="construct.b.pmbb018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb018
            
            #add-point:AFTER FIELD pmbb018 name="construct.a.pmbb018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbb018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb018
            #add-point:ON ACTION controlp INFIELD pmbb018 name="construct.c.pmbb018"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmbbownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbbownid
            #add-point:ON ACTION controlp INFIELD pmbbownid name="construct.c.pmbbownid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmbbownid  #顯示到畫面上

            NEXT FIELD pmbbownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbbownid
            #add-point:BEFORE FIELD pmbbownid name="construct.b.pmbbownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbbownid
            
            #add-point:AFTER FIELD pmbbownid name="construct.a.pmbbownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbbowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbbowndp
            #add-point:ON ACTION controlp INFIELD pmbbowndp name="construct.c.pmbbowndp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmbbowndp  #顯示到畫面上

            NEXT FIELD pmbbowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbbowndp
            #add-point:BEFORE FIELD pmbbowndp name="construct.b.pmbbowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbbowndp
            
            #add-point:AFTER FIELD pmbbowndp name="construct.a.pmbbowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbbcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbbcrtid
            #add-point:ON ACTION controlp INFIELD pmbbcrtid name="construct.c.pmbbcrtid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmbbcrtid  #顯示到畫面上

            NEXT FIELD pmbbcrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbbcrtid
            #add-point:BEFORE FIELD pmbbcrtid name="construct.b.pmbbcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbbcrtid
            
            #add-point:AFTER FIELD pmbbcrtid name="construct.a.pmbbcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbbcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbbcrtdp
            #add-point:ON ACTION controlp INFIELD pmbbcrtdp name="construct.c.pmbbcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmbbcrtdp  #顯示到畫面上

            NEXT FIELD pmbbcrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbbcrtdp
            #add-point:BEFORE FIELD pmbbcrtdp name="construct.b.pmbbcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbbcrtdp
            
            #add-point:AFTER FIELD pmbbcrtdp name="construct.a.pmbbcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbbcrtdt
            #add-point:BEFORE FIELD pmbbcrtdt name="construct.b.pmbbcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmbbmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbbmodid
            #add-point:ON ACTION controlp INFIELD pmbbmodid name="construct.c.pmbbmodid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmbbmodid  #顯示到畫面上

            NEXT FIELD pmbbmodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbbmodid
            #add-point:BEFORE FIELD pmbbmodid name="construct.b.pmbbmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbbmodid
            
            #add-point:AFTER FIELD pmbbmodid name="construct.a.pmbbmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbbmoddt
            #add-point:BEFORE FIELD pmbbmoddt name="construct.b.pmbbmoddt"
            
            #END add-point
 
 
 
           
      END CONSTRUCT
      
      #add-point:cs段more_construct name="cs.more_construct"
      
      #end add-point   
      
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog name="cs.b_dialog"
         
         #end add-point  
      
      ON ACTION accept
         ACCEPT DIALOG
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
 
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
    
      #條件儲存為方案
      ON ACTION qbe_save
         CALL cl_qbe_save()
 
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
   END DIALOG
  
   #add-point:cs段after_construct name="cs.after_construct"
   
   #end add-point
  
END FUNCTION
 
{</section>}
 
{<section id="apmt101.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION apmt101_filter()
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
      CONSTRUCT g_wc_filter ON pmbbdocno,pmbb001
                          FROM s_browse[1].b_pmbbdocno,s_browse[1].b_pmbb001
 
         BEFORE CONSTRUCT
               DISPLAY apmt101_filter_parser('pmbbdocno') TO s_browse[1].b_pmbbdocno
            DISPLAY apmt101_filter_parser('pmbb001') TO s_browse[1].b_pmbb001
      
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
 
      CALL apmt101_filter_show('pmbbdocno')
   CALL apmt101_filter_show('pmbb001')
 
END FUNCTION
 
{</section>}
 
{<section id="apmt101.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION apmt101_filter_parser(ps_field)
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
 
{<section id="apmt101.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION apmt101_filter_show(ps_field)
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
   LET ls_condition = apmt101_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="apmt101.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION apmt101_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point
   DEFINE ls_wc STRING
   #add-point:query段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="query.pre_function"
   
   #end add-point
   
   LET INT_FLAG = 0
   LET ls_wc = g_wc
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
 
   CALL g_browser.clear() 
 
   #browser panel折疊
   IF g_worksheet_hidden THEN
      CALL gfrm_curr.setElementHidden("worksheet_vbox",0)
      CALL gfrm_curr.setElementImage("worksheethidden","worksheethidden-24.png")
      LET g_worksheet_hidden = 0
   END IF
   
   #單頭折疊
   IF g_header_hidden THEN
      CALL gfrm_curr.setElementHidden("vb_master",0)
      CALL gfrm_curr.setElementImage("controls","headerhidden-24")
      LET g_header_hidden = 0
   END IF
 
   INITIALIZE g_pmbb_m.* TO NULL
   ERROR ""
 
   DISPLAY " " TO FORMONLY.b_count
   DISPLAY " " TO FORMONLY.h_count
   CALL apmt101_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL apmt101_browser_fill(g_wc,"F")
      CALL apmt101_fetch("")
      RETURN
   ELSE
      LET g_current_row = 1
      LET g_current_cnt = 0
   END IF
   
   #根據條件從新抓取資料
   LET g_error_show = 1
   CALL apmt101_browser_fill(g_wc,"F")   # 移到第一頁
   
   #儲存WC資訊
   CALL cl_dlg_save_user_latestqry("("||g_wc||")")
   
   #備份搜尋條件
   LET ls_wc = g_wc
   
   IF g_browser.getLength() = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "-100" 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   ELSE
      CALL apmt101_fetch("F") 
   END IF
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="apmt101.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION apmt101_fetch(p_fl)
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE p_fl       LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
 
   #end add-point  
   
   #add-point:Function前置處理  name="fetch.pre_function"
   
   #end add-point
   
   #根據傳入的條件決定抓取的資料
   CASE p_fl
      WHEN "F" 
         LET g_current_idx = 1
      WHEN "P"
         IF g_current_idx > 1 THEN               
            LET g_current_idx = g_current_idx - 1
         END IF 
      WHEN "N"
         IF g_current_idx < g_header_cnt THEN
            LET g_current_idx =  g_current_idx + 1
         END IF        
      WHEN "L" 
         #LET g_current_idx = g_header_cnt        
         LET g_current_idx = g_browser.getLength()    
      WHEN "/"
         #詢問要指定的筆數
         IF (NOT g_no_ask) THEN      
            CALL cl_getmsg("fetch", g_lang) RETURNING ls_msg
            LET INT_FLAG = 0
 
            PROMPT ls_msg CLIPPED,": " FOR g_jump
               #交談指令共用ACTION
               &include "common_action.4gl"
            END PROMPT
            
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               EXIT CASE  
            END IF           
         END IF
         IF g_jump > 0 THEN
            LET g_current_idx = g_jump
         END IF
         LET g_no_ask = FALSE     
   END CASE
 
   #筆數顯示
   LET g_browser_idx = g_current_idx 
   IF g_browser_cnt > 0 THEN
      DISPLAY g_browser_idx TO FORMONLY.b_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.b_count #總筆數
      DISPLAY g_browser_idx TO FORMONLY.h_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.h_count #總筆數
   ELSE
      DISPLAY '' TO FORMONLY.b_index #當下筆數
      DISPLAY '' TO FORMONLY.b_count #總筆數
      DISPLAY '' TO FORMONLY.h_index #當下筆數
      DISPLAY '' TO FORMONLY.h_count #總筆數
   END IF
   
   
   
   #避免超出browser資料筆數上限
   IF g_current_idx > g_browser.getLength() THEN
      LET g_browser_idx = g_browser.getLength()
      LET g_current_idx = g_browser.getLength() 
   END IF
   
   # 設定browse索引
   CALL g_curr_diag.setCurrentRow("s_browse", g_current_idx)
   CALL cl_navigator_setting(g_browser_idx, g_browser_cnt) 
 
   #代表沒有資料, 無需做後續資料撈取之動作
   IF g_current_idx = 0 THEN
      RETURN
   END IF
 
   #根據選定的筆數給予key欄位值
   LET g_pmbb_m.pmbbdocno = g_browser[g_current_idx].b_pmbbdocno
 
                       
   #讀取單頭所有欄位資料
   EXECUTE apmt101_master_referesh USING g_site,g_pmbb_m.pmbbdocno INTO g_pmbb_m.pmbbdocno,g_pmbb_m.pmbb001, 
       g_pmbb_m.pmbb080,g_pmbb_m.pmbb081,g_pmbb_m.pmbb109,g_pmbb_m.pmbb082,g_pmbb_m.pmbb083,g_pmbb_m.pmbb084, 
       g_pmbb_m.pmbb103,g_pmbb_m.pmbb104,g_pmbb_m.pmbb085,g_pmbb_m.pmbb086,g_pmbb_m.pmbb106,g_pmbb_m.pmbb087, 
       g_pmbb_m.pmbb105,g_pmbb_m.pmbb088,g_pmbb_m.pmbb089,g_pmbb_m.pmbb107,g_pmbb_m.pmbb108,g_pmbb_m.pmbb090, 
       g_pmbb_m.pmbb091,g_pmbb_m.pmbb092,g_pmbb_m.pmbb093,g_pmbb_m.pmbb094,g_pmbb_m.pmbb095,g_pmbb_m.pmbb096, 
       g_pmbb_m.pmbb097,g_pmbb_m.pmbb098,g_pmbb_m.pmbb099,g_pmbb_m.pmbb100,g_pmbb_m.pmbb101,g_pmbb_m.pmbb102, 
       g_pmbb_m.pmbb030,g_pmbb_m.pmbb031,g_pmbb_m.pmbb059,g_pmbb_m.pmbb032,g_pmbb_m.pmbb033,g_pmbb_m.pmbb034, 
       g_pmbb_m.pmbb053,g_pmbb_m.pmbb054,g_pmbb_m.pmbb035,g_pmbb_m.pmbb036,g_pmbb_m.pmbb056,g_pmbb_m.pmbb037, 
       g_pmbb_m.pmbb055,g_pmbb_m.pmbb038,g_pmbb_m.pmbb039,g_pmbb_m.pmbb057,g_pmbb_m.pmbb058,g_pmbb_m.pmbb040, 
       g_pmbb_m.pmbb041,g_pmbb_m.pmbb042,g_pmbb_m.pmbb043,g_pmbb_m.pmbb044,g_pmbb_m.pmbb045,g_pmbb_m.pmbb046, 
       g_pmbb_m.pmbb047,g_pmbb_m.pmbb048,g_pmbb_m.pmbb049,g_pmbb_m.pmbb050,g_pmbb_m.pmbb051,g_pmbb_m.pmbb052, 
       g_pmbb_m.pmbb071,g_pmbb_m.pmbb072,g_pmbb_m.pmbb073,g_pmbb_m.pmbb060,g_pmbb_m.pmbb061,g_pmbb_m.pmbb066, 
       g_pmbb_m.pmbb062,g_pmbb_m.pmbb067,g_pmbb_m.pmbb063,g_pmbb_m.pmbb068,g_pmbb_m.pmbb064,g_pmbb_m.pmbb069, 
       g_pmbb_m.pmbb065,g_pmbb_m.pmbb070,g_pmbb_m.pmbb002,g_pmbb_m.pmbb003,g_pmbb_m.pmbb004,g_pmbb_m.pmbb005, 
       g_pmbb_m.pmbb006,g_pmbb_m.pmbb007,g_pmbb_m.pmbb008,g_pmbb_m.pmbb009,g_pmbb_m.pmbb019,g_pmbb_m.pmbb010, 
       g_pmbb_m.pmbb020,g_pmbb_m.pmbb011,g_pmbb_m.pmbb012,g_pmbb_m.pmbb013,g_pmbb_m.pmbb014,g_pmbb_m.pmbb015, 
       g_pmbb_m.pmbb016,g_pmbb_m.pmbb017,g_pmbb_m.pmbb018,g_pmbb_m.pmbbownid,g_pmbb_m.pmbbowndp,g_pmbb_m.pmbbcrtid, 
       g_pmbb_m.pmbbcrtdp,g_pmbb_m.pmbbcrtdt,g_pmbb_m.pmbbmodid,g_pmbb_m.pmbbmoddt,g_pmbb_m.pmbb081_desc, 
       g_pmbb_m.pmbb109_desc,g_pmbb_m.pmbb083_desc,g_pmbb_m.pmbb103_desc,g_pmbb_m.pmbb104_desc,g_pmbb_m.pmbb087_desc, 
       g_pmbb_m.pmbb105_desc,g_pmbb_m.pmbb088_desc,g_pmbb_m.pmbb089_desc,g_pmbb_m.pmbb090_desc,g_pmbb_m.pmbb091_desc, 
       g_pmbb_m.pmbb092_desc,g_pmbb_m.pmbb093_desc,g_pmbb_m.pmbb097_desc,g_pmbb_m.pmbb031_desc,g_pmbb_m.pmbb059_desc, 
       g_pmbb_m.pmbb033_desc,g_pmbb_m.pmbb053_desc,g_pmbb_m.pmbb054_desc,g_pmbb_m.pmbb037_desc,g_pmbb_m.pmbb055_desc, 
       g_pmbb_m.pmbb038_desc,g_pmbb_m.pmbb039_desc,g_pmbb_m.pmbb040_desc,g_pmbb_m.pmbb041_desc,g_pmbb_m.pmbb042_desc, 
       g_pmbb_m.pmbb043_desc,g_pmbb_m.pmbb047_desc,g_pmbb_m.pmbb003_desc,g_pmbb_m.pmbb004_desc,g_pmbb_m.pmbb005_desc, 
       g_pmbb_m.pmbbownid_desc,g_pmbb_m.pmbbowndp_desc,g_pmbb_m.pmbbcrtid_desc,g_pmbb_m.pmbbcrtdp_desc, 
       g_pmbb_m.pmbbmodid_desc
   
   #遮罩相關處理
   LET g_pmbb_m_mask_o.* =  g_pmbb_m.*
   CALL apmt101_pmbb_t_mask()
   LET g_pmbb_m_mask_n.* =  g_pmbb_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL apmt101_set_act_visible()
   CALL apmt101_set_act_no_visible()
 
   #add-point:fetch段action控制 name="fetch.action_control"
 
   #end add-point  
   
   
   
   #保存單頭舊值
   LET g_pmbb_m_t.* = g_pmbb_m.*
   LET g_pmbb_m_o.* = g_pmbb_m.*
   
   LET g_data_owner = g_pmbb_m.pmbbownid      
   LET g_data_dept  = g_pmbb_m.pmbbowndp
   
   #重新顯示
   CALL apmt101_show()
   
 
END FUNCTION
 
{</section>}
 
{<section id="apmt101.insert" >}
#+ 資料新增
PRIVATE FUNCTION apmt101_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   CLEAR FORM #清畫面欄位內容
   INITIALIZE g_pmbb_m.* TO NULL             #DEFAULT 設定
   LET g_pmbbdocno_t = NULL
 
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   
   WHILE TRUE
      
      #公用欄位給值
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_pmbb_m.pmbbownid = g_user
      LET g_pmbb_m.pmbbowndp = g_dept
      LET g_pmbb_m.pmbbcrtid = g_user
      LET g_pmbb_m.pmbbcrtdp = g_dept 
      LET g_pmbb_m.pmbbcrtdt = cl_get_current()
      LET g_pmbb_m.pmbbmodid = g_user
      LET g_pmbb_m.pmbbmoddt = cl_get_current()
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_pmbb_m.pmbb080 = "A"
      LET g_pmbb_m.pmbb085 = "10"
      LET g_pmbb_m.pmbb086 = "1"
      LET g_pmbb_m.pmbb107 = "1"
      LET g_pmbb_m.pmbb108 = "2"
      LET g_pmbb_m.pmbb099 = "Y"
      LET g_pmbb_m.pmbb101 = "Y"
      LET g_pmbb_m.pmbb030 = "A"
      LET g_pmbb_m.pmbb035 = "10"
      LET g_pmbb_m.pmbb036 = "1"
      LET g_pmbb_m.pmbb057 = "1"
      LET g_pmbb_m.pmbb058 = "2"
      LET g_pmbb_m.pmbb049 = "Y"
      LET g_pmbb_m.pmbb051 = "Y"
      LET g_pmbb_m.pmbb071 = "N"
      LET g_pmbb_m.pmbb072 = "1"
      LET g_pmbb_m.pmbb073 = "1"
      LET g_pmbb_m.pmbb002 = "1"
      LET g_pmbb_m.pmbb006 = "0"
      LET g_pmbb_m.pmbb009 = "0"
      LET g_pmbb_m.pmbb019 = "0"
      LET g_pmbb_m.pmbb010 = "0"
      LET g_pmbb_m.pmbb012 = "1"
      LET g_pmbb_m.pmbb014 = "1"
      LET g_pmbb_m.pmbb016 = "1"
      LET g_pmbb_m.pmbb017 = "N"
      LET g_pmbb_m.pmbb018 = "1"
 
 
      #add-point:單頭預設值 name="insert.default"
      IF NOT cl_null(g_argv[03]) THEN
         LET g_pmbb_m.pmbbdocno = g_argv[03]
         CALL apmt101_pmbbdocno_desc(g_pmbb_m.pmbbdocno) RETURNING g_pmbb_m.pmbbdocno_desc
         DISPLAY BY NAME g_pmbb_m.pmbbdocno_desc
         CALL apmt101_pmbbdocno_ref(g_pmbb_m.pmbbdocno) 
               RETURNING g_pmbb_m.pmbb001,g_pmbb_m.pmbal003,g_pmbb_m.pmba002,g_pmbb_m.pmba003,g_pmbb_m.status1
         DISPLAY BY NAME g_pmbb_m.pmbb001,g_pmbb_m.pmbal003,g_pmbb_m.pmba002,g_pmbb_m.pmba003,g_pmbb_m.status1
         #160920-00003#1 add (S) -------------
         #IF g_flag1 THEN
            SELECT pmbd002 INTO g_pmbb_m.pmbb087
              FROM pmbd_t
             WHERE pmbdent   = g_enterprise
               AND pmbddocno = g_pmbb_m.pmbbdocno
               AND pmbd001   = g_pmbb_m.pmbb001
               AND pmbd004   = 'Y'
               ANd pmbdstus  = 'Y'
            DISPLAY BY NAME g_pmbb_m.pmbb087               
         #ENd IF
         #160920-00003#1 add (E) -------------
      END IF
      IF NOT cl_null(g_argv[04]) THEN
         LET g_pmbb_m.pmbb001 = g_argv[04] 
      END IF
      
      #160920-00003#1 add (S) -------------
         #IF g_flag1 THEN
            SELECT pmbd002 INTO g_pmbb_m.pmbb087
              FROM pmbd_t
             WHERE pmbdent   = g_enterprise
               AND pmbddocno = g_pmbb_m.pmbbdocno
               AND pmbd001   = g_pmbb_m.pmbb001
               AND pmbd004   = 'Y'
               ANd pmbdstus  = 'Y'
            DISPLAY BY NAME g_pmbb_m.pmbb087               
         #ENd IF
         #160920-00003#1 add (E) -------------
      
      LET g_pmbb_m.pmbb032 = g_dlang
      LET g_pmbb_m.pmbb082 = g_dlang
      
      INITIALIZE g_pmbb_m_t.* TO NULL
      LET g_pmbb_m_t.* = g_pmbb_m.*
      #end add-point   
     
      #顯示狀態(stus)圖片
      
     
      #資料輸入
      CALL apmt101_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG THEN
         #取消
         LET INT_FLAG = 0
         DISPLAY g_current_cnt TO FORMONLY.h_count     #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index     #當下筆數
         INITIALIZE g_pmbb_m.* TO NULL
         CALL apmt101_show()
         CALL s_transaction_end('N','0')
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
 
      LET g_rec_b = 0
      EXIT WHILE
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL apmt101_set_act_visible()
   CALL apmt101_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_pmbbdocno_t = g_pmbb_m.pmbbdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " pmbbent = " ||g_enterprise|| " AND pmbbsite = '" ||g_site|| "' AND",
                      " pmbbdocno = '", g_pmbb_m.pmbbdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL apmt101_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
 
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE apmt101_master_referesh USING g_site,g_pmbb_m.pmbbdocno INTO g_pmbb_m.pmbbdocno,g_pmbb_m.pmbb001, 
       g_pmbb_m.pmbb080,g_pmbb_m.pmbb081,g_pmbb_m.pmbb109,g_pmbb_m.pmbb082,g_pmbb_m.pmbb083,g_pmbb_m.pmbb084, 
       g_pmbb_m.pmbb103,g_pmbb_m.pmbb104,g_pmbb_m.pmbb085,g_pmbb_m.pmbb086,g_pmbb_m.pmbb106,g_pmbb_m.pmbb087, 
       g_pmbb_m.pmbb105,g_pmbb_m.pmbb088,g_pmbb_m.pmbb089,g_pmbb_m.pmbb107,g_pmbb_m.pmbb108,g_pmbb_m.pmbb090, 
       g_pmbb_m.pmbb091,g_pmbb_m.pmbb092,g_pmbb_m.pmbb093,g_pmbb_m.pmbb094,g_pmbb_m.pmbb095,g_pmbb_m.pmbb096, 
       g_pmbb_m.pmbb097,g_pmbb_m.pmbb098,g_pmbb_m.pmbb099,g_pmbb_m.pmbb100,g_pmbb_m.pmbb101,g_pmbb_m.pmbb102, 
       g_pmbb_m.pmbb030,g_pmbb_m.pmbb031,g_pmbb_m.pmbb059,g_pmbb_m.pmbb032,g_pmbb_m.pmbb033,g_pmbb_m.pmbb034, 
       g_pmbb_m.pmbb053,g_pmbb_m.pmbb054,g_pmbb_m.pmbb035,g_pmbb_m.pmbb036,g_pmbb_m.pmbb056,g_pmbb_m.pmbb037, 
       g_pmbb_m.pmbb055,g_pmbb_m.pmbb038,g_pmbb_m.pmbb039,g_pmbb_m.pmbb057,g_pmbb_m.pmbb058,g_pmbb_m.pmbb040, 
       g_pmbb_m.pmbb041,g_pmbb_m.pmbb042,g_pmbb_m.pmbb043,g_pmbb_m.pmbb044,g_pmbb_m.pmbb045,g_pmbb_m.pmbb046, 
       g_pmbb_m.pmbb047,g_pmbb_m.pmbb048,g_pmbb_m.pmbb049,g_pmbb_m.pmbb050,g_pmbb_m.pmbb051,g_pmbb_m.pmbb052, 
       g_pmbb_m.pmbb071,g_pmbb_m.pmbb072,g_pmbb_m.pmbb073,g_pmbb_m.pmbb060,g_pmbb_m.pmbb061,g_pmbb_m.pmbb066, 
       g_pmbb_m.pmbb062,g_pmbb_m.pmbb067,g_pmbb_m.pmbb063,g_pmbb_m.pmbb068,g_pmbb_m.pmbb064,g_pmbb_m.pmbb069, 
       g_pmbb_m.pmbb065,g_pmbb_m.pmbb070,g_pmbb_m.pmbb002,g_pmbb_m.pmbb003,g_pmbb_m.pmbb004,g_pmbb_m.pmbb005, 
       g_pmbb_m.pmbb006,g_pmbb_m.pmbb007,g_pmbb_m.pmbb008,g_pmbb_m.pmbb009,g_pmbb_m.pmbb019,g_pmbb_m.pmbb010, 
       g_pmbb_m.pmbb020,g_pmbb_m.pmbb011,g_pmbb_m.pmbb012,g_pmbb_m.pmbb013,g_pmbb_m.pmbb014,g_pmbb_m.pmbb015, 
       g_pmbb_m.pmbb016,g_pmbb_m.pmbb017,g_pmbb_m.pmbb018,g_pmbb_m.pmbbownid,g_pmbb_m.pmbbowndp,g_pmbb_m.pmbbcrtid, 
       g_pmbb_m.pmbbcrtdp,g_pmbb_m.pmbbcrtdt,g_pmbb_m.pmbbmodid,g_pmbb_m.pmbbmoddt,g_pmbb_m.pmbb081_desc, 
       g_pmbb_m.pmbb109_desc,g_pmbb_m.pmbb083_desc,g_pmbb_m.pmbb103_desc,g_pmbb_m.pmbb104_desc,g_pmbb_m.pmbb087_desc, 
       g_pmbb_m.pmbb105_desc,g_pmbb_m.pmbb088_desc,g_pmbb_m.pmbb089_desc,g_pmbb_m.pmbb090_desc,g_pmbb_m.pmbb091_desc, 
       g_pmbb_m.pmbb092_desc,g_pmbb_m.pmbb093_desc,g_pmbb_m.pmbb097_desc,g_pmbb_m.pmbb031_desc,g_pmbb_m.pmbb059_desc, 
       g_pmbb_m.pmbb033_desc,g_pmbb_m.pmbb053_desc,g_pmbb_m.pmbb054_desc,g_pmbb_m.pmbb037_desc,g_pmbb_m.pmbb055_desc, 
       g_pmbb_m.pmbb038_desc,g_pmbb_m.pmbb039_desc,g_pmbb_m.pmbb040_desc,g_pmbb_m.pmbb041_desc,g_pmbb_m.pmbb042_desc, 
       g_pmbb_m.pmbb043_desc,g_pmbb_m.pmbb047_desc,g_pmbb_m.pmbb003_desc,g_pmbb_m.pmbb004_desc,g_pmbb_m.pmbb005_desc, 
       g_pmbb_m.pmbbownid_desc,g_pmbb_m.pmbbowndp_desc,g_pmbb_m.pmbbcrtid_desc,g_pmbb_m.pmbbcrtdp_desc, 
       g_pmbb_m.pmbbmodid_desc
   
   
   #遮罩相關處理
   LET g_pmbb_m_mask_o.* =  g_pmbb_m.*
   CALL apmt101_pmbb_t_mask()
   LET g_pmbb_m_mask_n.* =  g_pmbb_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_pmbb_m.pmbbdocno,g_pmbb_m.pmbb001,g_pmbb_m.pmba002,g_pmbb_m.status1,g_pmbb_m.pmbbdocno_desc, 
       g_pmbb_m.pmbal003,g_pmbb_m.pmba003,g_pmbb_m.pmbb080,g_pmbb_m.pmbb081,g_pmbb_m.pmbb081_desc,g_pmbb_m.pmbb109, 
       g_pmbb_m.pmbb109_desc,g_pmbb_m.pmbb082,g_pmbb_m.pmbb083,g_pmbb_m.pmbb083_desc,g_pmbb_m.pmbb084, 
       g_pmbb_m.pmbb084_desc,g_pmbb_m.pmbb103,g_pmbb_m.pmbb103_desc,g_pmbb_m.pmbb104,g_pmbb_m.pmbb104_desc, 
       g_pmbb_m.pmbb085,g_pmbb_m.pmbb086,g_pmbb_m.pmbb106,g_pmbb_m.pmbb106_desc,g_pmbb_m.pmbb087,g_pmbb_m.pmbb087_desc, 
       g_pmbb_m.pmbb105,g_pmbb_m.pmbb105_desc,g_pmbb_m.pmbb088,g_pmbb_m.pmbb088_desc,g_pmbb_m.pmbb089, 
       g_pmbb_m.pmbb089_desc,g_pmbb_m.pmbb107,g_pmbb_m.pmbb108,g_pmbb_m.pmbb090,g_pmbb_m.pmbb090_desc, 
       g_pmbb_m.pmbb091,g_pmbb_m.pmbb091_desc,g_pmbb_m.pmbb092,g_pmbb_m.pmbb092_desc,g_pmbb_m.pmbb093, 
       g_pmbb_m.pmbb093_desc,g_pmbb_m.pmbb094,g_pmbb_m.pmbb095,g_pmbb_m.pmbb096,g_pmbb_m.pmbb097,g_pmbb_m.pmbb097_desc, 
       g_pmbb_m.pmbb098,g_pmbb_m.pmbb099,g_pmbb_m.pmbb100,g_pmbb_m.pmbb101,g_pmbb_m.pmbb102,g_pmbb_m.pmbb030, 
       g_pmbb_m.pmbb031,g_pmbb_m.pmbb031_desc,g_pmbb_m.pmbb059,g_pmbb_m.pmbb059_desc,g_pmbb_m.pmbb032, 
       g_pmbb_m.pmbb033,g_pmbb_m.pmbb033_desc,g_pmbb_m.pmbb034,g_pmbb_m.pmbb034_desc,g_pmbb_m.pmbb053, 
       g_pmbb_m.pmbb053_desc,g_pmbb_m.pmbb054,g_pmbb_m.pmbb054_desc,g_pmbb_m.pmbb035,g_pmbb_m.pmbb036, 
       g_pmbb_m.pmbb056,g_pmbb_m.pmbb056_desc,g_pmbb_m.pmbb037,g_pmbb_m.pmbb037_desc,g_pmbb_m.pmbb055, 
       g_pmbb_m.pmbb055_desc,g_pmbb_m.pmbb038,g_pmbb_m.pmbb038_desc,g_pmbb_m.pmbb039,g_pmbb_m.pmbb039_desc, 
       g_pmbb_m.pmbb057,g_pmbb_m.pmbb058,g_pmbb_m.pmbb040,g_pmbb_m.pmbb040_desc,g_pmbb_m.pmbb041,g_pmbb_m.pmbb041_desc, 
       g_pmbb_m.pmbb042,g_pmbb_m.pmbb042_desc,g_pmbb_m.pmbb043,g_pmbb_m.pmbb043_desc,g_pmbb_m.pmbb044, 
       g_pmbb_m.pmbb045,g_pmbb_m.pmbb046,g_pmbb_m.pmbb047,g_pmbb_m.pmbb047_desc,g_pmbb_m.pmbb048,g_pmbb_m.pmbb049, 
       g_pmbb_m.pmbb050,g_pmbb_m.pmbb051,g_pmbb_m.pmbb052,g_pmbb_m.pmbb071,g_pmbb_m.pmbb072,g_pmbb_m.pmbb073, 
       g_pmbb_m.pmbb060,g_pmbb_m.pmbb061,g_pmbb_m.pmbb066,g_pmbb_m.pmbb062,g_pmbb_m.pmbb067,g_pmbb_m.pmbb063, 
       g_pmbb_m.pmbb068,g_pmbb_m.pmbb064,g_pmbb_m.pmbb069,g_pmbb_m.pmbb065,g_pmbb_m.pmbb070,g_pmbb_m.total, 
       g_pmbb_m.pmbb002,g_pmbb_m.pmbb003,g_pmbb_m.pmbb003_desc,g_pmbb_m.pmbb004,g_pmbb_m.pmbb004_desc, 
       g_pmbb_m.pmbb005,g_pmbb_m.pmbb005_desc,g_pmbb_m.pmbb006,g_pmbb_m.pmbb007,g_pmbb_m.pmbb008,g_pmbb_m.pmbb009, 
       g_pmbb_m.pmbb019,g_pmbb_m.pmbb010,g_pmbb_m.pmbb020,g_pmbb_m.pmbb011,g_pmbb_m.pmbb012,g_pmbb_m.pmbb013, 
       g_pmbb_m.pmbb014,g_pmbb_m.pmbb015,g_pmbb_m.pmbb016,g_pmbb_m.pmbb017,g_pmbb_m.pmbb018,g_pmbb_m.ooff013, 
       g_pmbb_m.pmbbownid,g_pmbb_m.pmbbownid_desc,g_pmbb_m.pmbbowndp,g_pmbb_m.pmbbowndp_desc,g_pmbb_m.pmbbcrtid, 
       g_pmbb_m.pmbbcrtid_desc,g_pmbb_m.pmbbcrtdp,g_pmbb_m.pmbbcrtdp_desc,g_pmbb_m.pmbbcrtdt,g_pmbb_m.pmbbmodid, 
       g_pmbb_m.pmbbmodid_desc,g_pmbb_m.pmbbmoddt
 
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
 
   LET g_data_owner = g_pmbb_m.pmbbownid      
   LET g_data_dept  = g_pmbb_m.pmbbowndp
 
   #功能已完成,通報訊息中心
   CALL apmt101_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="apmt101.modify" >}
#+ 資料修改
PRIVATE FUNCTION apmt101_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="modify.pre_function"
   
   #end add-point
   
   #先確定key值無遺漏
   IF g_pmbb_m.pmbbdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF 
 
   ERROR ""
  
   #備份key值
   LET g_pmbbdocno_t = g_pmbb_m.pmbbdocno
 
   
   CALL s_transaction_begin()
   
   #先lock資料
   OPEN apmt101_cl USING g_enterprise, g_site,g_pmbb_m.pmbbdocno
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apmt101_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE apmt101_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE apmt101_master_referesh USING g_site,g_pmbb_m.pmbbdocno INTO g_pmbb_m.pmbbdocno,g_pmbb_m.pmbb001, 
       g_pmbb_m.pmbb080,g_pmbb_m.pmbb081,g_pmbb_m.pmbb109,g_pmbb_m.pmbb082,g_pmbb_m.pmbb083,g_pmbb_m.pmbb084, 
       g_pmbb_m.pmbb103,g_pmbb_m.pmbb104,g_pmbb_m.pmbb085,g_pmbb_m.pmbb086,g_pmbb_m.pmbb106,g_pmbb_m.pmbb087, 
       g_pmbb_m.pmbb105,g_pmbb_m.pmbb088,g_pmbb_m.pmbb089,g_pmbb_m.pmbb107,g_pmbb_m.pmbb108,g_pmbb_m.pmbb090, 
       g_pmbb_m.pmbb091,g_pmbb_m.pmbb092,g_pmbb_m.pmbb093,g_pmbb_m.pmbb094,g_pmbb_m.pmbb095,g_pmbb_m.pmbb096, 
       g_pmbb_m.pmbb097,g_pmbb_m.pmbb098,g_pmbb_m.pmbb099,g_pmbb_m.pmbb100,g_pmbb_m.pmbb101,g_pmbb_m.pmbb102, 
       g_pmbb_m.pmbb030,g_pmbb_m.pmbb031,g_pmbb_m.pmbb059,g_pmbb_m.pmbb032,g_pmbb_m.pmbb033,g_pmbb_m.pmbb034, 
       g_pmbb_m.pmbb053,g_pmbb_m.pmbb054,g_pmbb_m.pmbb035,g_pmbb_m.pmbb036,g_pmbb_m.pmbb056,g_pmbb_m.pmbb037, 
       g_pmbb_m.pmbb055,g_pmbb_m.pmbb038,g_pmbb_m.pmbb039,g_pmbb_m.pmbb057,g_pmbb_m.pmbb058,g_pmbb_m.pmbb040, 
       g_pmbb_m.pmbb041,g_pmbb_m.pmbb042,g_pmbb_m.pmbb043,g_pmbb_m.pmbb044,g_pmbb_m.pmbb045,g_pmbb_m.pmbb046, 
       g_pmbb_m.pmbb047,g_pmbb_m.pmbb048,g_pmbb_m.pmbb049,g_pmbb_m.pmbb050,g_pmbb_m.pmbb051,g_pmbb_m.pmbb052, 
       g_pmbb_m.pmbb071,g_pmbb_m.pmbb072,g_pmbb_m.pmbb073,g_pmbb_m.pmbb060,g_pmbb_m.pmbb061,g_pmbb_m.pmbb066, 
       g_pmbb_m.pmbb062,g_pmbb_m.pmbb067,g_pmbb_m.pmbb063,g_pmbb_m.pmbb068,g_pmbb_m.pmbb064,g_pmbb_m.pmbb069, 
       g_pmbb_m.pmbb065,g_pmbb_m.pmbb070,g_pmbb_m.pmbb002,g_pmbb_m.pmbb003,g_pmbb_m.pmbb004,g_pmbb_m.pmbb005, 
       g_pmbb_m.pmbb006,g_pmbb_m.pmbb007,g_pmbb_m.pmbb008,g_pmbb_m.pmbb009,g_pmbb_m.pmbb019,g_pmbb_m.pmbb010, 
       g_pmbb_m.pmbb020,g_pmbb_m.pmbb011,g_pmbb_m.pmbb012,g_pmbb_m.pmbb013,g_pmbb_m.pmbb014,g_pmbb_m.pmbb015, 
       g_pmbb_m.pmbb016,g_pmbb_m.pmbb017,g_pmbb_m.pmbb018,g_pmbb_m.pmbbownid,g_pmbb_m.pmbbowndp,g_pmbb_m.pmbbcrtid, 
       g_pmbb_m.pmbbcrtdp,g_pmbb_m.pmbbcrtdt,g_pmbb_m.pmbbmodid,g_pmbb_m.pmbbmoddt,g_pmbb_m.pmbb081_desc, 
       g_pmbb_m.pmbb109_desc,g_pmbb_m.pmbb083_desc,g_pmbb_m.pmbb103_desc,g_pmbb_m.pmbb104_desc,g_pmbb_m.pmbb087_desc, 
       g_pmbb_m.pmbb105_desc,g_pmbb_m.pmbb088_desc,g_pmbb_m.pmbb089_desc,g_pmbb_m.pmbb090_desc,g_pmbb_m.pmbb091_desc, 
       g_pmbb_m.pmbb092_desc,g_pmbb_m.pmbb093_desc,g_pmbb_m.pmbb097_desc,g_pmbb_m.pmbb031_desc,g_pmbb_m.pmbb059_desc, 
       g_pmbb_m.pmbb033_desc,g_pmbb_m.pmbb053_desc,g_pmbb_m.pmbb054_desc,g_pmbb_m.pmbb037_desc,g_pmbb_m.pmbb055_desc, 
       g_pmbb_m.pmbb038_desc,g_pmbb_m.pmbb039_desc,g_pmbb_m.pmbb040_desc,g_pmbb_m.pmbb041_desc,g_pmbb_m.pmbb042_desc, 
       g_pmbb_m.pmbb043_desc,g_pmbb_m.pmbb047_desc,g_pmbb_m.pmbb003_desc,g_pmbb_m.pmbb004_desc,g_pmbb_m.pmbb005_desc, 
       g_pmbb_m.pmbbownid_desc,g_pmbb_m.pmbbowndp_desc,g_pmbb_m.pmbbcrtid_desc,g_pmbb_m.pmbbcrtdp_desc, 
       g_pmbb_m.pmbbmodid_desc
 
   #檢查是否允許此動作
   IF NOT apmt101_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_pmbb_m_mask_o.* =  g_pmbb_m.*
   CALL apmt101_pmbb_t_mask()
   LET g_pmbb_m_mask_n.* =  g_pmbb_m.*
   
   
 
   #顯示資料
   CALL apmt101_show()
   
   WHILE TRUE
      LET g_pmbb_m.pmbbdocno = g_pmbbdocno_t
 
      
      #寫入修改者/修改日期資訊
      LET g_pmbb_m.pmbbmodid = g_user 
LET g_pmbb_m.pmbbmoddt = cl_get_current()
LET g_pmbb_m.pmbbmodid_desc = cl_get_username(g_pmbb_m.pmbbmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
 
      #資料輸入
      CALL apmt101_input("u")     
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_pmbb_m.* = g_pmbb_m_t.*
         CALL apmt101_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
 
      #若有modid跟moddt則進行update
      UPDATE pmbb_t SET (pmbbmodid,pmbbmoddt) = (g_pmbb_m.pmbbmodid,g_pmbb_m.pmbbmoddt)
       WHERE pmbbent = g_enterprise AND pmbbsite = g_site AND pmbbdocno = g_pmbbdocno_t
 
 
      EXIT WHILE
      
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL apmt101_set_act_visible()
   CALL apmt101_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " pmbbent = " ||g_enterprise|| " AND pmbbsite = '" ||g_site|| "' AND",
                      " pmbbdocno = '", g_pmbb_m.pmbbdocno, "' "
 
   #填到對應位置
   CALL apmt101_browser_fill(g_wc,"")
 
   CLOSE apmt101_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL apmt101_msgcentre_notify('modify')
   
   LET g_worksheet_hidden = 0
   
END FUNCTION   
 
{</section>}
 
{<section id="apmt101.input" >}
#+ 資料輸入
PRIVATE FUNCTION apmt101_input(p_cmd)
   #add-point:input段define(客製用) name="input.define_customerization"
   
   #end add-point
   DEFINE p_cmd           LIKE type_t.chr1
   DEFINE l_ac_t          LIKE type_t.num10       #未取消的ARRAY CNT 
   DEFINE l_n             LIKE type_t.num10       #檢查重複用  
   DEFINE l_cnt           LIKE type_t.num10       #檢查重複用  
   DEFINE l_lock_sw       LIKE type_t.chr1        #單身鎖住否  
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num10
   DEFINE l_i             LIKE type_t.num10
   DEFINE l_insert        LIKE type_t.num10
   DEFINE ls_return       STRING
   DEFINE l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak  DYNAMIC ARRAY OF STRING
   DEFINE l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE l_vars          DYNAMIC ARRAY OF STRING
   DEFINE l_fields        DYNAMIC ARRAY OF STRING
   #add-point:input段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_oocq019       LIKE oocq_t.oocq019
   
   DEFINE l_errno         LIKE gzze_t.gzze001  #150304---earl---add
   DEFINE l_msg1          LIKE gzze_t.gzze003   #160621-00003#3 20160629 add by beckxie
   DEFINE l_msg2          LIKE gzze_t.gzze003   #160621-00003#3 20160629 add by beckxie
   #end add-point
   
   #add-point:Function前置處理  name="input.pre_function"
   #160621-00003#3 20160629 add by beckxie---S
   LET l_msg1 = ''
   LET l_msg2 = ''
   SELECT gzze003 INTO l_msg1 FROM gzze_t WHERE gzze001 = 'aoo-00708' AND gzze002 = g_dlang 
   SELECT gzze003 INTO l_msg2 FROM gzze_t WHERE gzze001 = 'aoo-00309' AND gzze002 = g_dlang
   #160621-00003#3 20160629 add by beckxie---E
   #end add-point
   
   #切換至輸入畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_pmbb_m.pmbbdocno,g_pmbb_m.pmbb001,g_pmbb_m.pmba002,g_pmbb_m.status1,g_pmbb_m.pmbbdocno_desc, 
       g_pmbb_m.pmbal003,g_pmbb_m.pmba003,g_pmbb_m.pmbb080,g_pmbb_m.pmbb081,g_pmbb_m.pmbb081_desc,g_pmbb_m.pmbb109, 
       g_pmbb_m.pmbb109_desc,g_pmbb_m.pmbb082,g_pmbb_m.pmbb083,g_pmbb_m.pmbb083_desc,g_pmbb_m.pmbb084, 
       g_pmbb_m.pmbb084_desc,g_pmbb_m.pmbb103,g_pmbb_m.pmbb103_desc,g_pmbb_m.pmbb104,g_pmbb_m.pmbb104_desc, 
       g_pmbb_m.pmbb085,g_pmbb_m.pmbb086,g_pmbb_m.pmbb106,g_pmbb_m.pmbb106_desc,g_pmbb_m.pmbb087,g_pmbb_m.pmbb087_desc, 
       g_pmbb_m.pmbb105,g_pmbb_m.pmbb105_desc,g_pmbb_m.pmbb088,g_pmbb_m.pmbb088_desc,g_pmbb_m.pmbb089, 
       g_pmbb_m.pmbb089_desc,g_pmbb_m.pmbb107,g_pmbb_m.pmbb108,g_pmbb_m.pmbb090,g_pmbb_m.pmbb090_desc, 
       g_pmbb_m.pmbb091,g_pmbb_m.pmbb091_desc,g_pmbb_m.pmbb092,g_pmbb_m.pmbb092_desc,g_pmbb_m.pmbb093, 
       g_pmbb_m.pmbb093_desc,g_pmbb_m.pmbb094,g_pmbb_m.pmbb095,g_pmbb_m.pmbb096,g_pmbb_m.pmbb097,g_pmbb_m.pmbb097_desc, 
       g_pmbb_m.pmbb098,g_pmbb_m.pmbb099,g_pmbb_m.pmbb100,g_pmbb_m.pmbb101,g_pmbb_m.pmbb102,g_pmbb_m.pmbb030, 
       g_pmbb_m.pmbb031,g_pmbb_m.pmbb031_desc,g_pmbb_m.pmbb059,g_pmbb_m.pmbb059_desc,g_pmbb_m.pmbb032, 
       g_pmbb_m.pmbb033,g_pmbb_m.pmbb033_desc,g_pmbb_m.pmbb034,g_pmbb_m.pmbb034_desc,g_pmbb_m.pmbb053, 
       g_pmbb_m.pmbb053_desc,g_pmbb_m.pmbb054,g_pmbb_m.pmbb054_desc,g_pmbb_m.pmbb035,g_pmbb_m.pmbb036, 
       g_pmbb_m.pmbb056,g_pmbb_m.pmbb056_desc,g_pmbb_m.pmbb037,g_pmbb_m.pmbb037_desc,g_pmbb_m.pmbb055, 
       g_pmbb_m.pmbb055_desc,g_pmbb_m.pmbb038,g_pmbb_m.pmbb038_desc,g_pmbb_m.pmbb039,g_pmbb_m.pmbb039_desc, 
       g_pmbb_m.pmbb057,g_pmbb_m.pmbb058,g_pmbb_m.pmbb040,g_pmbb_m.pmbb040_desc,g_pmbb_m.pmbb041,g_pmbb_m.pmbb041_desc, 
       g_pmbb_m.pmbb042,g_pmbb_m.pmbb042_desc,g_pmbb_m.pmbb043,g_pmbb_m.pmbb043_desc,g_pmbb_m.pmbb044, 
       g_pmbb_m.pmbb045,g_pmbb_m.pmbb046,g_pmbb_m.pmbb047,g_pmbb_m.pmbb047_desc,g_pmbb_m.pmbb048,g_pmbb_m.pmbb049, 
       g_pmbb_m.pmbb050,g_pmbb_m.pmbb051,g_pmbb_m.pmbb052,g_pmbb_m.pmbb071,g_pmbb_m.pmbb072,g_pmbb_m.pmbb073, 
       g_pmbb_m.pmbb060,g_pmbb_m.pmbb061,g_pmbb_m.pmbb066,g_pmbb_m.pmbb062,g_pmbb_m.pmbb067,g_pmbb_m.pmbb063, 
       g_pmbb_m.pmbb068,g_pmbb_m.pmbb064,g_pmbb_m.pmbb069,g_pmbb_m.pmbb065,g_pmbb_m.pmbb070,g_pmbb_m.total, 
       g_pmbb_m.pmbb002,g_pmbb_m.pmbb003,g_pmbb_m.pmbb003_desc,g_pmbb_m.pmbb004,g_pmbb_m.pmbb004_desc, 
       g_pmbb_m.pmbb005,g_pmbb_m.pmbb005_desc,g_pmbb_m.pmbb006,g_pmbb_m.pmbb007,g_pmbb_m.pmbb008,g_pmbb_m.pmbb009, 
       g_pmbb_m.pmbb019,g_pmbb_m.pmbb010,g_pmbb_m.pmbb020,g_pmbb_m.pmbb011,g_pmbb_m.pmbb012,g_pmbb_m.pmbb013, 
       g_pmbb_m.pmbb014,g_pmbb_m.pmbb015,g_pmbb_m.pmbb016,g_pmbb_m.pmbb017,g_pmbb_m.pmbb018,g_pmbb_m.ooff013, 
       g_pmbb_m.pmbbownid,g_pmbb_m.pmbbownid_desc,g_pmbb_m.pmbbowndp,g_pmbb_m.pmbbowndp_desc,g_pmbb_m.pmbbcrtid, 
       g_pmbb_m.pmbbcrtid_desc,g_pmbb_m.pmbbcrtdp,g_pmbb_m.pmbbcrtdp_desc,g_pmbb_m.pmbbcrtdt,g_pmbb_m.pmbbmodid, 
       g_pmbb_m.pmbbmodid_desc,g_pmbb_m.pmbbmoddt
   
   CALL cl_set_head_visible("","YES")  
   
   #a-新增,r-複製,u-修改
   IF p_cmd = 'r' THEN
      #此段落的r動作等同於a
      LET p_cmd = 'a'
   END IF
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   LET g_qryparam.state = "i"
   
   #控制key欄位可否輸入
   CALL apmt101_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL apmt101_set_no_entry(p_cmd)
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   #add-point:資料輸入前 name="input.before_input"
   LET g_errshow = 1
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #單頭段
      INPUT BY NAME g_pmbb_m.pmbbdocno,g_pmbb_m.pmbb001,g_pmbb_m.pmbb080,g_pmbb_m.pmbb081,g_pmbb_m.pmbb109, 
          g_pmbb_m.pmbb082,g_pmbb_m.pmbb083,g_pmbb_m.pmbb084,g_pmbb_m.pmbb103,g_pmbb_m.pmbb104,g_pmbb_m.pmbb085, 
          g_pmbb_m.pmbb086,g_pmbb_m.pmbb106,g_pmbb_m.pmbb087,g_pmbb_m.pmbb105,g_pmbb_m.pmbb088,g_pmbb_m.pmbb089, 
          g_pmbb_m.pmbb107,g_pmbb_m.pmbb108,g_pmbb_m.pmbb090,g_pmbb_m.pmbb091,g_pmbb_m.pmbb092,g_pmbb_m.pmbb093, 
          g_pmbb_m.pmbb094,g_pmbb_m.pmbb095,g_pmbb_m.pmbb096,g_pmbb_m.pmbb097,g_pmbb_m.pmbb098,g_pmbb_m.pmbb099, 
          g_pmbb_m.pmbb100,g_pmbb_m.pmbb101,g_pmbb_m.pmbb102,g_pmbb_m.pmbb030,g_pmbb_m.pmbb031,g_pmbb_m.pmbb059, 
          g_pmbb_m.pmbb032,g_pmbb_m.pmbb033,g_pmbb_m.pmbb034,g_pmbb_m.pmbb053,g_pmbb_m.pmbb054,g_pmbb_m.pmbb035, 
          g_pmbb_m.pmbb036,g_pmbb_m.pmbb056,g_pmbb_m.pmbb037,g_pmbb_m.pmbb055,g_pmbb_m.pmbb038,g_pmbb_m.pmbb039, 
          g_pmbb_m.pmbb057,g_pmbb_m.pmbb058,g_pmbb_m.pmbb040,g_pmbb_m.pmbb041,g_pmbb_m.pmbb042,g_pmbb_m.pmbb043, 
          g_pmbb_m.pmbb044,g_pmbb_m.pmbb045,g_pmbb_m.pmbb046,g_pmbb_m.pmbb047,g_pmbb_m.pmbb048,g_pmbb_m.pmbb049, 
          g_pmbb_m.pmbb050,g_pmbb_m.pmbb051,g_pmbb_m.pmbb052,g_pmbb_m.pmbb071,g_pmbb_m.pmbb072,g_pmbb_m.pmbb073, 
          g_pmbb_m.pmbb060,g_pmbb_m.pmbb061,g_pmbb_m.pmbb066,g_pmbb_m.pmbb062,g_pmbb_m.pmbb067,g_pmbb_m.pmbb063, 
          g_pmbb_m.pmbb068,g_pmbb_m.pmbb064,g_pmbb_m.pmbb069,g_pmbb_m.pmbb065,g_pmbb_m.pmbb070,g_pmbb_m.total, 
          g_pmbb_m.pmbb002,g_pmbb_m.pmbb003,g_pmbb_m.pmbb004,g_pmbb_m.pmbb005,g_pmbb_m.pmbb006,g_pmbb_m.pmbb007, 
          g_pmbb_m.pmbb008,g_pmbb_m.pmbb009,g_pmbb_m.pmbb019,g_pmbb_m.pmbb010,g_pmbb_m.pmbb020,g_pmbb_m.pmbb011, 
          g_pmbb_m.pmbb012,g_pmbb_m.pmbb013,g_pmbb_m.pmbb014,g_pmbb_m.pmbb015,g_pmbb_m.pmbb016,g_pmbb_m.pmbb017, 
          g_pmbb_m.pmbb018,g_pmbb_m.ooff013 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            #其他table資料備份(確定是否更改用)
            
            #add-point:input開始前 name="input.before.input"
            
            #end add-point
   
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbbdocno
            
            #add-point:AFTER FIELD pmbbdocno name="input.a.pmbbdocno"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_pmbb_m.pmbbdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_pmbb_m.pmbbdocno != g_pmbbdocno_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pmbb_t WHERE "||"pmbbent = '" ||g_enterprise|| "' AND pmbbsite = '" ||g_site|| "' AND "||"pmbbdocno = '"||g_pmbb_m.pmbbdocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbbdocno
            #add-point:BEFORE FIELD pmbbdocno name="input.b.pmbbdocno"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbbdocno
            #add-point:ON CHANGE pmbbdocno name="input.g.pmbbdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb001
            #add-point:BEFORE FIELD pmbb001 name="input.b.pmbb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb001
            
            #add-point:AFTER FIELD pmbb001 name="input.a.pmbb001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb001
            #add-point:ON CHANGE pmbb001 name="input.g.pmbb001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb080
            #add-point:BEFORE FIELD pmbb080 name="input.b.pmbb080"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb080
            
            #add-point:AFTER FIELD pmbb080 name="input.a.pmbb080"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb080
            #add-point:ON CHANGE pmbb080 name="input.g.pmbb080"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb081
            
            #add-point:AFTER FIELD pmbb081 name="input.a.pmbb081"
            CALL apmt101_pmbb081_ref(g_pmbb_m.pmbb081) RETURNING g_pmbb_m.pmbb081_desc
            DISPLAY BY NAME g_pmbb_m.pmbb081_desc
            IF NOT cl_null(g_pmbb_m.pmbb081) THEN
            #150304---earl---mod---s
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmbb_m.pmbb081 != g_pmbb_m_t.pmbb081 OR cl_null(g_pmbb_m_t.pmbb081))) THEN 
               IF g_pmbb_m.pmbb081 <> g_pmbb_m_o.pmbb081 OR cl_null(g_pmbb_m_o.pmbb081) THEN
                  IF NOT apmt101_pmbb081_chk(g_pmbb_m.pmbb081) THEN
                     #LET g_pmbb_m.pmbb081 = g_pmbb_m_t.pmbb081
                     LET g_pmbb_m.pmbb081 = g_pmbb_m_o.pmbb081
                     CALL apmt101_pmbb081_ref(g_pmbb_m.pmbb081) RETURNING g_pmbb_m.pmbb081_desc
                     DISPLAY BY NAME g_pmbb_m.pmbb081_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  #帶出部門
                  CALL s_employee_get_dept(g_pmbb_m.pmbb081) RETURNING l_success,l_errno,g_pmbb_m.pmbb109,g_pmbb_m.pmbb109_desc
                  DISPLAY BY NAME g_pmbb_m.pmbb109
                  DISPLAY BY NAME g_pmbb_m.pmbb109_desc
                  
                  LET g_pmbb_m_o.pmbb109 = g_pmbb_m.pmbb109
                  
               END IF
            END IF

            LET g_pmbb_m_o.pmbb081 = g_pmbb_m.pmbb081

            #150304---earl---mod---e
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb081
            #add-point:BEFORE FIELD pmbb081 name="input.b.pmbb081"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb081
            #add-point:ON CHANGE pmbb081 name="input.g.pmbb081"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb109
            
            #add-point:AFTER FIELD pmbb109 name="input.a.pmbb109"
            CALL s_desc_get_department_desc(g_pmbb_m.pmbb109) RETURNING g_pmbb_m.pmbb109_desc
            DISPLAY BY NAME g_pmbb_m.pmbb109_desc

            IF NOT cl_null(g_pmbb_m.pmbb109) THEN 
               IF g_pmbb_m.pmbb109 <> g_pmbb_m_o.pmbb109 OR cl_null(g_pmbb_m_o.pmbb109) THEN
                  IF NOT s_department_chk(g_pmbb_m.pmbb109,g_today) THEN
                     LET g_pmbb_m.pmbb109 = g_pmbb_m_o.pmbb109

                     CALL s_desc_get_department_desc(g_pmbb_m.pmbb109) RETURNING g_pmbb_m.pmbb109_desc
                     DISPLAY BY NAME g_pmbb_m.pmbb109_desc

                     NEXT FIELD CURRENT
                  END IF
               END IF               
            END IF

            LET g_pmbb_m_o.pmbb109 = g_pmbb_m.pmbb109
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb109
            #add-point:BEFORE FIELD pmbb109 name="input.b.pmbb109"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb109
            #add-point:ON CHANGE pmbb109 name="input.g.pmbb109"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb082
            #add-point:BEFORE FIELD pmbb082 name="input.b.pmbb082"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb082
            
            #add-point:AFTER FIELD pmbb082 name="input.a.pmbb082"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb082
            #add-point:ON CHANGE pmbb082 name="input.g.pmbb082"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb083
            
            #add-point:AFTER FIELD pmbb083 name="input.a.pmbb083"
            CALL apmt101_pmbb083_ref(g_pmbb_m.pmbb083) RETURNING g_pmbb_m.pmbb083_desc
            DISPLAY BY NAME g_pmbb_m.pmbb083_desc
            
            IF  NOT cl_null(g_pmbb_m.pmbb083) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmbb_m.pmbb083 != g_pmbb_m_t.pmbb083 OR cl_null(g_pmbb_m_t.pmbb083))) THEN 
                  IF NOT apmt101_pmbb083_chk(g_pmbb_m.pmbb083) THEN
                     LET g_pmbb_m.pmbb083 = g_pmbb_m_t.pmbb083
                     CALL apmt101_pmbb083_ref(g_pmbb_m.pmbb083) RETURNING g_pmbb_m.pmbb083_desc
                     DISPLAY BY NAME g_pmbb_m.pmbb083_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb083
            #add-point:BEFORE FIELD pmbb083 name="input.b.pmbb083"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb083
            #add-point:ON CHANGE pmbb083 name="input.g.pmbb083"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb084
            
            #add-point:AFTER FIELD pmbb084 name="input.a.pmbb084"
            CALL apmt101_pmbb084_ref(g_pmbb_m.pmbb084) RETURNING g_pmbb_m.pmbb084_desc
            DISPLAY BY NAME g_pmbb_m.pmbb084_desc
            
            IF  NOT cl_null(g_pmbb_m.pmbb084) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmbb_m.pmbb084 != g_pmbb_m_t.pmbb084 OR cl_null(g_pmbb_m_t.pmbb084))) THEN 
                  IF NOT apmt101_pmbb084_chk(g_pmbb_m.pmbb084) THEN
                     LET g_pmbb_m.pmbb084 = g_pmbb_m_t.pmbb084
                     CALL apmt101_pmbb084_ref(g_pmbb_m.pmbb084) RETURNING g_pmbb_m.pmbb084_desc
                     DISPLAY BY NAME g_pmbb_m.pmbb084_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb084
            #add-point:BEFORE FIELD pmbb084 name="input.b.pmbb084"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb084
            #add-point:ON CHANGE pmbb084 name="input.g.pmbb084"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb103
            
            #add-point:AFTER FIELD pmbb103 name="input.a.pmbb103"
            CALL apmt101_pmbb103_ref(g_pmbb_m.pmbb103) RETURNING g_pmbb_m.pmbb103_desc
            DISPLAY BY NAME g_pmbb_m.pmbb103_desc
            
            IF  NOT cl_null(g_pmbb_m.pmbb103) THEN 
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmbb_m.pmbb103 != g_pmbb_m_t.pmbb103 OR cl_null(g_pmbb_m_t.pmbb103))) THEN   #160824-00007#335 Mark By Ken 170106
               IF (g_pmbb_m.pmbb103 != g_pmbb_m_o.pmbb103 OR cl_null(g_pmbb_m_o.pmbb103)) THEN    #160824-00007#335 Add By Ken 170106
                  IF NOT apmt101_pmbb103_chk(g_pmbb_m.pmbb103) THEN
                     #LET g_pmbb_m.pmbb103 = g_pmbb_m_t.pmbb103  #160824-00007#335 Mark By Ken 170106
                     LET g_pmbb_m.pmbb103 = g_pmbb_m_o.pmbb103   #160824-00007#335 Add By Ken 170106
                     CALL apmt101_pmbb103_ref(g_pmbb_m.pmbb103) RETURNING g_pmbb_m.pmbb103_desc
                     DISPLAY BY NAME g_pmbb_m.pmbb103_desc
                     NEXT FIELD CURRENT
                  END IF
                  SELECT oocq005 INTO g_pmbb_m.pmbb104 FROM oocq_t WHERE oocqent = g_enterprise AND oocq001 = '238' AND oocq002 = g_pmbb_m.pmbb103
                  CALL apmt101_pmbb104_ref(g_pmbb_m.pmbb104) RETURNING g_pmbb_m.pmbb104_desc
                  DISPLAY BY NAME g_pmbb_m.pmbb104_desc
               END IF
            END IF
            LET g_pmbb_m_o.* = g_pmbb_m.*    #160824-00007#335 Add By Ken 170106
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb103
            #add-point:BEFORE FIELD pmbb103 name="input.b.pmbb103"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb103
            #add-point:ON CHANGE pmbb103 name="input.g.pmbb103"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb104
            
            #add-point:AFTER FIELD pmbb104 name="input.a.pmbb104"
            CALL apmt101_pmbb104_ref(g_pmbb_m.pmbb104) RETURNING g_pmbb_m.pmbb104_desc
            DISPLAY BY NAME g_pmbb_m.pmbb104_desc
            
            IF  NOT cl_null(g_pmbb_m.pmbb104) THEN 
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmbb_m.pmbb104 != g_pmbb_m_t.pmbb104 OR cl_null(g_pmbb_m_t.pmbb104))) THEN   #160824-00007#335 Mark By Ken 170106
               IF (g_pmbb_m.pmbb104 != g_pmbb_m_o.pmbb104 OR cl_null(g_pmbb_m_o.pmbb104)) THEN    #160824-00007#335 Add By Ken 170106
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL

                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_pmbb_m.pmbb104
                  
                  #160318-00025#37  2016/04/19  by pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "axm-00026:sub-01302|axmi130|",cl_get_progname("axmi130",g_lang,"2"),"|:EXEPROGaxmi130"
                  #160318-00025#37  2016/04/19  by pengxin  add(E)
               
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_xmah001") THEN
                     #LET g_pmbb_m.pmbb104 = g_pmbb_m_t.pmbb104   #160824-00007#335 Mark By Ken 170106
                     LET g_pmbb_m.pmbb104 = g_pmbb_m_o.pmbb104    #160824-00007#335 Add By Ken 170106
                     CALL apmt101_pmbb104_ref(g_pmbb_m.pmbb104) RETURNING g_pmbb_m.pmbb104_desc
                     DISPLAY BY NAME g_pmbb_m.pmbb104_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_pmbb_m_o.* = g_pmbb_m.*    #160824-00007#335 Add By Ken 170106
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb104
            #add-point:BEFORE FIELD pmbb104 name="input.b.pmbb104"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb104
            #add-point:ON CHANGE pmbb104 name="input.g.pmbb104"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb085
            #add-point:BEFORE FIELD pmbb085 name="input.b.pmbb085"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb085
            
            #add-point:AFTER FIELD pmbb085 name="input.a.pmbb085"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb085
            #add-point:ON CHANGE pmbb085 name="input.g.pmbb085"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb086
            #add-point:BEFORE FIELD pmbb086 name="input.b.pmbb086"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb086
            
            #add-point:AFTER FIELD pmbb086 name="input.a.pmbb086"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb086
            #add-point:ON CHANGE pmbb086 name="input.g.pmbb086"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb106
            
            #add-point:AFTER FIELD pmbb106 name="input.a.pmbb106"
            CALL apmt101_pmbb106_ref(g_pmbb_m.pmbb106) RETURNING g_pmbb_m.pmbb106_desc
            DISPLAY BY NAME g_pmbb_m.pmbb106_desc
            IF NOT cl_null(g_pmbb_m.pmbb106) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_ooef019
               LET g_chkparam.arg2 = g_pmbb_m.pmbb106

                  
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_isac002") THEN
                  LET g_pmbb_m.pmbb106 = g_pmbb_m_t.pmbb106
                  CALL apmt101_pmbb106_ref(g_pmbb_m.pmbb106) RETURNING g_pmbb_m.pmbb106_desc
                  DISPLAY BY NAME g_pmbb_m.pmbb106_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb106
            #add-point:BEFORE FIELD pmbb106 name="input.b.pmbb106"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb106
            #add-point:ON CHANGE pmbb106 name="input.g.pmbb106"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb087
            
            #add-point:AFTER FIELD pmbb087 name="input.a.pmbb087"
            CALL apmt101_pmbb087_ref(g_pmbb_m.pmbb087) RETURNING g_pmbb_m.pmbb087_desc
            DISPLAY BY NAME g_pmbb_m.pmbb087_desc
            
            IF NOT cl_null(g_pmbb_m.pmbb087) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmbb_m.pmbb087 != g_pmbb_m_t.pmbb087 OR cl_null(g_pmbb_m_t.pmbb087))) THEN 
                  IF NOT apmt101_pmbb087_chk(g_pmbb_m.pmbb087,'2') THEN
                     LET g_pmbb_m.pmbb087 = g_pmbb_m_t.pmbb087
                     CALL apmt101_pmbb087_ref(g_pmbb_m.pmbb087) RETURNING g_pmbb_m.pmbb087_desc
                     DISPLAY BY NAME g_pmbb_m.pmbb087_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb087
            #add-point:BEFORE FIELD pmbb087 name="input.b.pmbb087"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb087
            #add-point:ON CHANGE pmbb087 name="input.g.pmbb087"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb105
            
            #add-point:AFTER FIELD pmbb105 name="input.a.pmbb105"
            CALL apmt101_pmbb105_ref(g_pmbb_m.pmbb105) RETURNING g_pmbb_m.pmbb105_desc
            DISPLAY BY NAME g_pmbb_m.pmbb105_desc
            
            IF  NOT cl_null(g_pmbb_m.pmbb105) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmbb_m.pmbb105 != g_pmbb_m_t.pmbb105 OR cl_null(g_pmbb_m_t.pmbb105))) THEN 
                  IF NOT ap_chk_isExist(g_pmbb_m.pmbb105,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '3111' AND oocq002 = ? ","sub-01303","axri010") THEN  #apm-00181   #160318-00005#36  By 07900 --mod
                     LET g_pmbb_m.pmbb105 = g_pmbb_m_t.pmbb105
                     CALL apmt101_pmbb105_ref(g_pmbb_m.pmbb105) RETURNING g_pmbb_m.pmbb105_desc
                     DISPLAY BY NAME g_pmbb_m.pmbb105_desc 
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT ap_chk_isExist(g_pmbb_m.pmbb105,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '3111' AND oocq002 = ? AND oocqstus = 'Y' ","sub-01302","axri010") THEN  #apm-00182  #160318-00005#36  By 07900 --mod
                     LET g_pmbb_m.pmbb105 = g_pmbb_m_t.pmbb105
                     CALL apmt101_pmbb105_ref(g_pmbb_m.pmbb105) RETURNING g_pmbb_m.pmbb105_desc
                     DISPLAY BY NAME g_pmbb_m.pmbb105_desc 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb105
            #add-point:BEFORE FIELD pmbb105 name="input.b.pmbb105"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb105
            #add-point:ON CHANGE pmbb105 name="input.g.pmbb105"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb088
            
            #add-point:AFTER FIELD pmbb088 name="input.a.pmbb088"
            CALL apmt101_pmbb088_ref(g_pmbb_m.pmbb088) RETURNING g_pmbb_m.pmbb088_desc
            DISPLAY BY NAME g_pmbb_m.pmbb088_desc
            IF NOT cl_null(g_pmbb_m.pmbb088) THEN
               #160621-00003#3 20160627 modify by beckxie---S
               #IF NOT s_azzi650_chk_exist('275',g_pmbb_m.pmbb088) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_pmbb_m.pmbb088
               LET g_chkparam.arg2 = '1'
               LET g_chkparam.err_str[1] = "aoo-00299|",l_msg1
               IF NOT cl_chk_exist("v_oojd001") THEN
               #160621-00003#3 20160627 modify by beckxie---E
                  LET g_pmbb_m.pmbb088 = g_pmbb_m_t.pmbb088
                  CALL apmt101_pmbb088_ref(g_pmbb_m.pmbb088) RETURNING g_pmbb_m.pmbb088_desc
                  DISPLAY BY NAME g_pmbb_m.pmbb088_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb088
            #add-point:BEFORE FIELD pmbb088 name="input.b.pmbb088"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb088
            #add-point:ON CHANGE pmbb088 name="input.g.pmbb088"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb089
            
            #add-point:AFTER FIELD pmbb089 name="input.a.pmbb089"
            CALL apmt101_pmbb089_ref(g_pmbb_m.pmbb089) RETURNING g_pmbb_m.pmbb089_desc
            DISPLAY BY NAME g_pmbb_m.pmbb089_desc
            
            IF  NOT cl_null(g_pmbb_m.pmbb089) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmbb_m.pmbb089 != g_pmbb_m_t.pmbb089 OR cl_null(g_pmbb_m_t.pmbb089))) THEN 
                  IF NOT ap_chk_isExist(g_pmbb_m.pmbb089,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '295' AND oocq002 = ? ","sub-01303","axmi035" ) THEN  #apm-00168  #160318-00005#36  By 07900 --mod 
                     LET g_pmbb_m.pmbb089 = g_pmbb_m_t.pmbb089
                     CALL apmt101_pmbb089_ref(g_pmbb_m.pmbb089) RETURNING g_pmbb_m.pmbb089_desc
                     DISPLAY BY NAME g_pmbb_m.pmbb089_desc 
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT ap_chk_isExist(g_pmbb_m.pmbb089,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '295' AND oocq002 = ? AND oocqstus = 'Y' ","sub-01302","axmi035") THEN   #apm-00169  #160318-00005#36  By 07900 --mod
                     LET g_pmbb_m.pmbb089 = g_pmbb_m_t.pmbb089
                     CALL apmt101_pmbb089_ref(g_pmbb_m.pmbb089) RETURNING g_pmbb_m.pmbb089_desc
                     DISPLAY BY NAME g_pmbb_m.pmbb089_desc 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb089
            #add-point:BEFORE FIELD pmbb089 name="input.b.pmbb089"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb089
            #add-point:ON CHANGE pmbb089 name="input.g.pmbb089"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb107
            #add-point:BEFORE FIELD pmbb107 name="input.b.pmbb107"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb107
            
            #add-point:AFTER FIELD pmbb107 name="input.a.pmbb107"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb107
            #add-point:ON CHANGE pmbb107 name="input.g.pmbb107"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb108
            #add-point:BEFORE FIELD pmbb108 name="input.b.pmbb108"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb108
            
            #add-point:AFTER FIELD pmbb108 name="input.a.pmbb108"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb108
            #add-point:ON CHANGE pmbb108 name="input.g.pmbb108"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb090
            
            #add-point:AFTER FIELD pmbb090 name="input.a.pmbb090"
            CALL apmt101_pmbb090_ref(g_pmbb_m.pmbb090) RETURNING g_pmbb_m.pmbb090_desc
            DISPLAY BY NAME g_pmbb_m.pmbb090_desc
            
            IF  NOT cl_null(g_pmbb_m.pmbb090) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmbb_m.pmbb090 != g_pmbb_m_t.pmbb090 OR cl_null(g_pmbb_m_t.pmbb090))) THEN 
                  IF NOT apmt101_pmbb090_chk(g_pmbb_m.pmbb090) THEN
                     LET g_pmbb_m.pmbb090 = g_pmbb_m_t.pmbb090
                     CALL apmt101_pmbb090_ref(g_pmbb_m.pmbb090) RETURNING g_pmbb_m.pmbb090_desc
                     DISPLAY BY NAME g_pmbb_m.pmbb090_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb090
            #add-point:BEFORE FIELD pmbb090 name="input.b.pmbb090"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb090
            #add-point:ON CHANGE pmbb090 name="input.g.pmbb090"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb091
            
            #add-point:AFTER FIELD pmbb091 name="input.a.pmbb091"
            CALL s_apmi011_location_ref(g_pmbb_m.pmbb090,g_pmbb_m.pmbb091) RETURNING g_pmbb_m.pmbb091_desc
            DISPLAY BY NAME g_pmbb_m.pmbb091_desc
            
            IF  NOT cl_null(g_pmbb_m.pmbb091) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmbb_m.pmbb091 != g_pmbb_m_t.pmbb091 OR cl_null(g_pmbb_m_t.pmbb091))) THEN 
                  IF NOT s_apmi011_check_location(g_pmbb_m.pmbb090,g_pmbb_m.pmbb091) THEN
                     LET g_pmbb_m.pmbb091 = g_pmbb_m_t.pmbb091
                     CALL s_apmi011_location_ref(g_pmbb_m.pmbb090,g_pmbb_m.pmbb091) RETURNING g_pmbb_m.pmbb091_desc
                     DISPLAY BY NAME g_pmbb_m.pmbb091_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb091
            #add-point:BEFORE FIELD pmbb091 name="input.b.pmbb091"
            IF cl_null(g_pmbb_m.pmbb090) THEN  #運輸類型
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axm-00085'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               #請先輸入運輸方式
               NEXT FIELD pmbb090
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb091
            #add-point:ON CHANGE pmbb091 name="input.g.pmbb091"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb092
            
            #add-point:AFTER FIELD pmbb092 name="input.a.pmbb092"
            CALL s_apmi011_location_ref(g_pmbb_m.pmbb090,g_pmbb_m.pmbb092) RETURNING g_pmbb_m.pmbb092_desc
            DISPLAY BY NAME g_pmbb_m.pmbb092_desc
            
            IF  NOT cl_null(g_pmbb_m.pmbb092) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmbb_m.pmbb092 != g_pmbb_m_t.pmbb092 OR cl_null(g_pmbb_m_t.pmbb092))) THEN 
                  IF NOT s_apmi011_check_location(g_pmbb_m.pmbb090,g_pmbb_m.pmbb092) THEN
                     LET g_pmbb_m.pmbb092 = g_pmbb_m_t.pmbb092
                     CALL s_apmi011_location_ref(g_pmbb_m.pmbb090,g_pmbb_m.pmbb092) RETURNING g_pmbb_m.pmbb092_desc
                     DISPLAY BY NAME g_pmbb_m.pmbb092_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb092
            #add-point:BEFORE FIELD pmbb092 name="input.b.pmbb092"
            IF cl_null(g_pmbb_m.pmbb090) THEN  #運輸類型
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axm-00085'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               #請先輸入運輸方式
               NEXT FIELD pmbb090
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb092
            #add-point:ON CHANGE pmbb092 name="input.g.pmbb092"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb093
            
            #add-point:AFTER FIELD pmbb093 name="input.a.pmbb093"
            CALL apmt101_pmbb091_ref(g_pmbb_m.pmbb093) RETURNING g_pmbb_m.pmbb093_desc
            DISPLAY BY NAME g_pmbb_m.pmbb093_desc
            
            IF  NOT cl_null(g_pmbb_m.pmbb093) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmbb_m.pmbb093 != g_pmbb_m_t.pmbb093 OR cl_null(g_pmbb_m_t.pmbb093))) THEN 
                  IF NOT apmt101_pmbb091_chk(g_pmbb_m.pmbb093) THEN
                     LET g_pmbb_m.pmbb093 = g_pmbb_m_t.pmbb093
                     CALL apmt101_pmbb091_ref(g_pmbb_m.pmbb093) RETURNING g_pmbb_m.pmbb093_desc
                     DISPLAY BY NAME g_pmbb_m.pmbb093_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb093
            #add-point:BEFORE FIELD pmbb093 name="input.b.pmbb093"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb093
            #add-point:ON CHANGE pmbb093 name="input.g.pmbb093"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb094
            #add-point:BEFORE FIELD pmbb094 name="input.b.pmbb094"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb094
            
            #add-point:AFTER FIELD pmbb094 name="input.a.pmbb094"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb094
            #add-point:ON CHANGE pmbb094 name="input.g.pmbb094"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb095
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmbb_m.pmbb095,"0.000","1","100.000","1","azz-00087",1) THEN
               NEXT FIELD pmbb095
            END IF 
 
 
 
            #add-point:AFTER FIELD pmbb095 name="input.a.pmbb095"
            IF NOT cl_null(g_pmbb_m.pmbb095) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb095
            #add-point:BEFORE FIELD pmbb095 name="input.b.pmbb095"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb095
            #add-point:ON CHANGE pmbb095 name="input.g.pmbb095"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb096
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmbb_m.pmbb096,"0.000","1","100.000","1","azz-00087",1) THEN
               NEXT FIELD pmbb096
            END IF 
 
 
 
            #add-point:AFTER FIELD pmbb096 name="input.a.pmbb096"
            IF NOT cl_null(g_pmbb_m.pmbb096) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb096
            #add-point:BEFORE FIELD pmbb096 name="input.b.pmbb096"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb096
            #add-point:ON CHANGE pmbb096 name="input.g.pmbb096"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb097
            
            #add-point:AFTER FIELD pmbb097 name="input.a.pmbb097"
            CALL apmt101_pmbb003_ref(g_pmbb_m.pmbb097_desc) RETURNING g_pmbb_m.pmbb097_desc
            DISPLAY BY NAME g_pmbb_m.pmbb097_desc
            
            IF  NOT cl_null(g_pmbb_m.pmbb097) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmbb_m.pmbb097 != g_pmbb_m_t.pmbb097 OR cl_null(g_pmbb_m_t.pmbb097))) THEN 
                  IF NOT apmt101_pmbb097_chk(g_pmbb_m.pmbb097) THEN
                     LET g_pmbb_m.pmbb097 = g_pmbb_m_t.pmbb097
                     CALL apmt101_pmbb003_ref(g_pmbb_m.pmbb097) RETURNING g_pmbb_m.pmbb097_desc
                     DISPLAY BY NAME g_pmbb_m.pmbb097_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb097
            #add-point:BEFORE FIELD pmbb097 name="input.b.pmbb097"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb097
            #add-point:ON CHANGE pmbb097 name="input.g.pmbb097"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb098
            #add-point:BEFORE FIELD pmbb098 name="input.b.pmbb098"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb098
            
            #add-point:AFTER FIELD pmbb098 name="input.a.pmbb098"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb098
            #add-point:ON CHANGE pmbb098 name="input.g.pmbb098"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb099
            #add-point:BEFORE FIELD pmbb099 name="input.b.pmbb099"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb099
            
            #add-point:AFTER FIELD pmbb099 name="input.a.pmbb099"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb099
            #add-point:ON CHANGE pmbb099 name="input.g.pmbb099"
            CALL apmt101_set_entry(p_cmd)
            CALL apmt101_set_no_entry(p_cmd)
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb100
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmbb_m.pmbb100,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD pmbb100
            END IF 
 
 
 
            #add-point:AFTER FIELD pmbb100 name="input.a.pmbb100"
            IF NOT cl_null(g_pmbb_m.pmbb100) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb100
            #add-point:BEFORE FIELD pmbb100 name="input.b.pmbb100"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb100
            #add-point:ON CHANGE pmbb100 name="input.g.pmbb100"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb101
            #add-point:BEFORE FIELD pmbb101 name="input.b.pmbb101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb101
            
            #add-point:AFTER FIELD pmbb101 name="input.a.pmbb101"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb101
            #add-point:ON CHANGE pmbb101 name="input.g.pmbb101"
            CALL apmt101_set_entry(p_cmd)
            CALL apmt101_set_no_entry(p_cmd)
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb102
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmbb_m.pmbb102,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD pmbb102
            END IF 
 
 
 
            #add-point:AFTER FIELD pmbb102 name="input.a.pmbb102"
            IF NOT cl_null(g_pmbb_m.pmbb102) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb102
            #add-point:BEFORE FIELD pmbb102 name="input.b.pmbb102"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb102
            #add-point:ON CHANGE pmbb102 name="input.g.pmbb102"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb030
            #add-point:BEFORE FIELD pmbb030 name="input.b.pmbb030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb030
            
            #add-point:AFTER FIELD pmbb030 name="input.a.pmbb030"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb030
            #add-point:ON CHANGE pmbb030 name="input.g.pmbb030"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb031
            
            #add-point:AFTER FIELD pmbb031 name="input.a.pmbb031"
            CALL apmt101_pmbb081_ref(g_pmbb_m.pmbb031) RETURNING g_pmbb_m.pmbb031_desc
            DISPLAY BY NAME g_pmbb_m.pmbb031_desc
            IF NOT cl_null(g_pmbb_m.pmbb031) THEN
            #150304---earl---mod---s
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmbb_m.pmbb031 != g_pmbb_m_t.pmbb031 OR cl_null(g_pmbb_m_t.pmbb031))) THEN 
               IF g_pmbb_m.pmbb031 <> g_pmbb_m_o.pmbb031 OR cl_null(g_pmbb_m_o.pmbb031) THEN
                  IF NOT apmt101_pmbb081_chk(g_pmbb_m.pmbb031) THEN
                     #LET g_pmbb_m.pmbb031 = g_pmbb_m_t.pmbb031
                     LET g_pmbb_m.pmbb031 = g_pmbb_m_o.pmbb031
                     CALL apmt101_pmbb081_ref(g_pmbb_m.pmbb031) RETURNING g_pmbb_m.pmbb031_desc
                     DISPLAY BY NAME g_pmbb_m.pmbb031_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  #帶出部門
                  CALL s_employee_get_dept(g_pmbb_m.pmbb031) RETURNING l_success,l_errno,g_pmbb_m.pmbb059,g_pmbb_m.pmbb059_desc
                  DISPLAY BY NAME g_pmbb_m.pmbb059
                  DISPLAY BY NAME g_pmbb_m.pmbb059_desc
                  
                  LET g_pmbb_m_o.pmbb059 = g_pmbb_m.pmbb059
                  
               END IF
            END IF

            LET g_pmbb_m_o.pmbb031 = g_pmbb_m.pmbb031
            #150304---earl---mod---e
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb031
            #add-point:BEFORE FIELD pmbb031 name="input.b.pmbb031"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb031
            #add-point:ON CHANGE pmbb031 name="input.g.pmbb031"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb059
            
            #add-point:AFTER FIELD pmbb059 name="input.a.pmbb059"
            CALL s_desc_get_department_desc(g_pmbb_m.pmbb059) RETURNING g_pmbb_m.pmbb059_desc
            DISPLAY BY NAME g_pmbb_m.pmbb059_desc

            IF NOT cl_null(g_pmbb_m.pmbb059) THEN 
               IF g_pmbb_m.pmbb059 <> g_pmbb_m_o.pmbb059 OR cl_null(g_pmbb_m_o.pmbb059) THEN
                  IF NOT s_department_chk(g_pmbb_m.pmbb059,g_today) THEN
                     LET g_pmbb_m.pmbb059 = g_pmbb_m_o.pmbb059

                     CALL s_desc_get_department_desc(g_pmbb_m.pmbb059) RETURNING g_pmbb_m.pmbb059_desc
                     DISPLAY BY NAME g_pmbb_m.pmbb059_desc

                     NEXT FIELD CURRENT
                  END IF
               END IF               
            END IF

            LET g_pmbb_m_o.pmbb059 = g_pmbb_m.pmbb059
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb059
            #add-point:BEFORE FIELD pmbb059 name="input.b.pmbb059"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb059
            #add-point:ON CHANGE pmbb059 name="input.g.pmbb059"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb032
            #add-point:BEFORE FIELD pmbb032 name="input.b.pmbb032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb032
            
            #add-point:AFTER FIELD pmbb032 name="input.a.pmbb032"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb032
            #add-point:ON CHANGE pmbb032 name="input.g.pmbb032"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb033
            
            #add-point:AFTER FIELD pmbb033 name="input.a.pmbb033"
            CALL apmt101_pmbb083_ref(g_pmbb_m.pmbb033) RETURNING g_pmbb_m.pmbb033_desc
            DISPLAY BY NAME g_pmbb_m.pmbb033_desc
            
            IF  NOT cl_null(g_pmbb_m.pmbb033) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmbb_m.pmbb033 != g_pmbb_m_t.pmbb033 OR cl_null(g_pmbb_m_t.pmbb033))) THEN 
                  IF NOT apmt101_pmbb083_chk(g_pmbb_m.pmbb033) THEN
                     LET g_pmbb_m.pmbb033 = g_pmbb_m_t.pmbb033
                     CALL apmt101_pmbb083_ref(g_pmbb_m.pmbb033) RETURNING g_pmbb_m.pmbb033_desc
                     DISPLAY BY NAME g_pmbb_m.pmbb033_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb033
            #add-point:BEFORE FIELD pmbb033 name="input.b.pmbb033"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb033
            #add-point:ON CHANGE pmbb033 name="input.g.pmbb033"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb034
            
            #add-point:AFTER FIELD pmbb034 name="input.a.pmbb034"
            CALL apmt101_pmbb084_ref(g_pmbb_m.pmbb034) RETURNING g_pmbb_m.pmbb034_desc
            DISPLAY BY NAME g_pmbb_m.pmbb034_desc
            
            IF  NOT cl_null(g_pmbb_m.pmbb034) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmbb_m.pmbb034 != g_pmbb_m_t.pmbb034 OR cl_null(g_pmbb_m_t.pmbb034))) THEN 
                  IF NOT apmt101_pmbb084_chk(g_pmbb_m.pmbb034) THEN
                     LET g_pmbb_m.pmbb034 = g_pmbb_m_t.pmbb034
                     CALL apmt101_pmbb084_ref(g_pmbb_m.pmbb034) RETURNING g_pmbb_m.pmbb034_desc
                     DISPLAY BY NAME g_pmbb_m.pmbb034_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb034
            #add-point:BEFORE FIELD pmbb034 name="input.b.pmbb034"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb034
            #add-point:ON CHANGE pmbb034 name="input.g.pmbb034"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb053
            
            #add-point:AFTER FIELD pmbb053 name="input.a.pmbb053"
            CALL apmt101_pmbb103_ref(g_pmbb_m.pmbb053) RETURNING g_pmbb_m.pmbb053_desc
            DISPLAY BY NAME g_pmbb_m.pmbb053_desc
            
            IF  NOT cl_null(g_pmbb_m.pmbb053) THEN 
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmbb_m.pmbb053 != g_pmbb_m_t.pmbb053 OR cl_null(g_pmbb_m_t.pmbb053))) THEN  #160824-00007#335 Mark By Ken 170106
               IF (g_pmbb_m.pmbb053 != g_pmbb_m_o.pmbb053 OR cl_null(g_pmbb_m_o.pmbb053)) THEN   #160824-00007#335 Add By Ken 170106
                  IF NOT apmt101_pmbb103_chk(g_pmbb_m.pmbb053) THEN
                     #LET g_pmbb_m.pmbb053 = g_pmbb_m_t.pmbb053  #160824-00007#335 Mark By Ken 170106
                     LET g_pmbb_m.pmbb053 = g_pmbb_m_o.pmbb053   #160824-00007#335 Add By Ken 170106
                     CALL apmt101_pmbb103_ref(g_pmbb_m.pmbb053) RETURNING g_pmbb_m.pmbb053_desc
                     DISPLAY BY NAME g_pmbb_m.pmbb053_desc
                     NEXT FIELD CURRENT
                  END IF
                  SELECT oocq004 INTO g_pmbb_m.pmbb054 FROM oocq_t WHERE oocqent = g_enterprise AND oocq001 = '238' AND oocq002 = g_pmbb_m.pmbb053
                  CALL apmt101_pmbb054_ref(g_pmbb_m.pmbb054) RETURNING g_pmbb_m.pmbb054_desc
                  DISPLAY BY NAME g_pmbb_m.pmbb054_desc
               END IF
            END IF
            LET g_pmbb_m_o.* = g_pmbb_m.*    #160824-00007#335 Add By Ken 170106
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb053
            #add-point:BEFORE FIELD pmbb053 name="input.b.pmbb053"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb053
            #add-point:ON CHANGE pmbb053 name="input.g.pmbb053"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb054
            
            #add-point:AFTER FIELD pmbb054 name="input.a.pmbb054"
            CALL apmt101_pmbb054_ref(g_pmbb_m.pmbb054) RETURNING g_pmbb_m.pmbb054_desc
            DISPLAY BY NAME g_pmbb_m.pmbb054_desc
            
            IF  NOT cl_null(g_pmbb_m.pmbb054) THEN 
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmbb_m.pmbb054 != g_pmbb_m_t.pmbb054 OR cl_null(g_pmbb_m_t.pmbb054))) THEN  #160824-00007#335 Add By Ken 170106
               IF (g_pmbb_m.pmbb054 != g_pmbb_m_o.pmbb054 OR cl_null(g_pmbb_m_o.pmbb054)) THEN   #160824-00007#335 Mark By Ken 170106
                  IF NOT apmt101_pmbb054_chk(g_pmbb_m.pmbb054) THEN
                     #LET g_pmbb_m.pmbb054 = g_pmbb_m_t.pmbb054  #160824-00007#335 Mark By Ken 170106
                     LET g_pmbb_m.pmbb054 = g_pmbb_m_o.pmbb054   #160824-00007#335 Add By Ken 170106
                     CALL apmt101_pmbb054_ref(g_pmbb_m.pmbb054) RETURNING g_pmbb_m.pmbb054_desc
                     DISPLAY BY NAME g_pmbb_m.pmbb054_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_pmbb_m_o.* = g_pmbb_m.*    #160824-00007#335 Add By Ken 170106
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb054
            #add-point:BEFORE FIELD pmbb054 name="input.b.pmbb054"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb054
            #add-point:ON CHANGE pmbb054 name="input.g.pmbb054"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb035
            #add-point:BEFORE FIELD pmbb035 name="input.b.pmbb035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb035
            
            #add-point:AFTER FIELD pmbb035 name="input.a.pmbb035"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb035
            #add-point:ON CHANGE pmbb035 name="input.g.pmbb035"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb036
            #add-point:BEFORE FIELD pmbb036 name="input.b.pmbb036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb036
            
            #add-point:AFTER FIELD pmbb036 name="input.a.pmbb036"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb036
            #add-point:ON CHANGE pmbb036 name="input.g.pmbb036"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb056
            
            #add-point:AFTER FIELD pmbb056 name="input.a.pmbb056"
            CALL apmt101_pmbb106_ref(g_pmbb_m.pmbb056) RETURNING g_pmbb_m.pmbb056_desc
            DISPLAY BY NAME g_pmbb_m.pmbb056_desc
            IF NOT cl_null(g_pmbb_m.pmbb056) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_ooef019
               LET g_chkparam.arg2 = g_pmbb_m.pmbb056

               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_isac002_1") THEN
                  LET g_pmbb_m.pmbb056 = g_pmbb_m_t.pmbb056
                  CALL apmt101_pmbb106_ref(g_pmbb_m.pmbb056) RETURNING g_pmbb_m.pmbb056_desc
                  DISPLAY BY NAME g_pmbb_m.pmbb056_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb056
            #add-point:BEFORE FIELD pmbb056 name="input.b.pmbb056"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb056
            #add-point:ON CHANGE pmbb056 name="input.g.pmbb056"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb037
            
            #add-point:AFTER FIELD pmbb037 name="input.a.pmbb037"
            CALL apmt101_pmbb087_ref(g_pmbb_m.pmbb037) RETURNING g_pmbb_m.pmbb037_desc
            DISPLAY BY NAME g_pmbb_m.pmbb037_desc
            
            IF NOT cl_null(g_pmbb_m.pmbb037) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmbb_m.pmbb037 != g_pmbb_m_t.pmbb037 OR cl_null(g_pmbb_m_t.pmbb037))) THEN 
                  IF NOT apmt101_pmbb087_chk(g_pmbb_m.pmbb037,'1') THEN
                     LET g_pmbb_m.pmbb037 = g_pmbb_m_t.pmbb037
                     CALL apmt101_pmbb087_ref(g_pmbb_m.pmbb037) RETURNING g_pmbb_m.pmbb037_desc
                     DISPLAY BY NAME g_pmbb_m.pmbb037_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb037
            #add-point:BEFORE FIELD pmbb037 name="input.b.pmbb037"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb037
            #add-point:ON CHANGE pmbb037 name="input.g.pmbb037"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb055
            
            #add-point:AFTER FIELD pmbb055 name="input.a.pmbb055"
            CALL apmt101_pmbb055_ref(g_pmbb_m.pmbb055) RETURNING g_pmbb_m.pmbb055_desc
            DISPLAY BY NAME g_pmbb_m.pmbb055_desc
            
            IF  NOT cl_null(g_pmbb_m.pmbb055) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmbb_m.pmbb055 != g_pmbb_m_t.pmbb055 OR cl_null(g_pmbb_m_t.pmbb055))) THEN 
                  IF NOT ap_chk_isExist(g_pmbb_m.pmbb055,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '3211' AND oocq002 = ? ","sub-01303","aapi010" ) THEN  #apm-00179  #160318-00005#36  By 07900 --mod 
                     LET g_pmbb_m.pmbb055 = g_pmbb_m_t.pmbb055
                     CALL apmt101_pmbb055_ref(g_pmbb_m.pmbb055) RETURNING g_pmbb_m.pmbb055_desc
                     DISPLAY BY NAME g_pmbb_m.pmbb055_desc 
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT ap_chk_isExist(g_pmbb_m.pmbb055,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '3211' AND oocq002 = ? AND oocqstus = 'Y' ","sub-01302","aapi010") THEN  #apm-00180  #160318-00005#36  By 07900 --mod
                     LET g_pmbb_m.pmbb055 = g_pmbb_m_t.pmbb055
                     CALL apmt101_pmbb055_ref(g_pmbb_m.pmbb055) RETURNING g_pmbb_m.pmbb055_desc
                     DISPLAY BY NAME g_pmbb_m.pmbb055_desc 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb055
            #add-point:BEFORE FIELD pmbb055 name="input.b.pmbb055"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb055
            #add-point:ON CHANGE pmbb055 name="input.g.pmbb055"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb038
            
            #add-point:AFTER FIELD pmbb038 name="input.a.pmbb038"
            CALL apmt101_pmbb088_ref(g_pmbb_m.pmbb038) RETURNING g_pmbb_m.pmbb038_desc
            DISPLAY BY NAME g_pmbb_m.pmbb038_desc
            IF NOT cl_null(g_pmbb_m.pmbb038) THEN
               #160621-00003#3 20160627 modify by beckxie---S
               #IF NOT s_azzi650_chk_exist('275',g_pmab_m.pmab088) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_pmbb_m.pmbb038
               LET g_chkparam.arg2 = '2'
               LET g_chkparam.err_str[1] = "aoo-00299|",l_msg2
               IF NOT cl_chk_exist("v_oojd001") THEN
               #160621-00003#3 20160627 modify by beckxie---E
                  LET g_pmbb_m.pmbb038 = g_pmbb_m_t.pmbb038
                  CALL apmt101_pmbb088_ref(g_pmbb_m.pmbb038) RETURNING g_pmbb_m.pmbb038_desc
                  DISPLAY BY NAME g_pmbb_m.pmbb038_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb038
            #add-point:BEFORE FIELD pmbb038 name="input.b.pmbb038"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb038
            #add-point:ON CHANGE pmbb038 name="input.g.pmbb038"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb039
            
            #add-point:AFTER FIELD pmbb039 name="input.a.pmbb039"
            CALL apmt101_pmbb039_ref(g_pmbb_m.pmbb039) RETURNING g_pmbb_m.pmbb039_desc
            DISPLAY BY NAME g_pmbb_m.pmbb039_desc
            
            IF  NOT cl_null(g_pmbb_m.pmbb039) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmbb_m.pmbb039 != g_pmbb_m_t.pmbb039 OR cl_null(g_pmbb_m_t.pmbb039))) THEN 
                  IF NOT ap_chk_isExist(g_pmbb_m.pmbb039,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '264' AND oocq002 = ? ","sub-01303","apmi029" ) THEN  #apm-00071  #160318-00005#36  By 07900 --mod 
                     LET g_pmbb_m.pmbb039 = g_pmbb_m_t.pmbb039
                     CALL apmt101_pmbb039_ref(g_pmbb_m.pmbb039) RETURNING g_pmbb_m.pmbb039_desc
                     DISPLAY BY NAME g_pmbb_m.pmbb039_desc 
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT ap_chk_isExist(g_pmbb_m.pmbb039,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '264' AND oocq002 = ? AND oocqstus = 'Y' ","sub-01302","apmi029") THEN  #apm-00072  #160318-00005#36  By 07900 --mod
                     LET g_pmbb_m.pmbb039 = g_pmbb_m_t.pmbb039
                     CALL apmt101_pmbb039_ref(g_pmbb_m.pmbb039) RETURNING g_pmbb_m.pmbb039_desc
                     DISPLAY BY NAME g_pmbb_m.pmbb039_desc 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb039
            #add-point:BEFORE FIELD pmbb039 name="input.b.pmbb039"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb039
            #add-point:ON CHANGE pmbb039 name="input.g.pmbb039"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb057
            #add-point:BEFORE FIELD pmbb057 name="input.b.pmbb057"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb057
            
            #add-point:AFTER FIELD pmbb057 name="input.a.pmbb057"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb057
            #add-point:ON CHANGE pmbb057 name="input.g.pmbb057"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb058
            #add-point:BEFORE FIELD pmbb058 name="input.b.pmbb058"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb058
            
            #add-point:AFTER FIELD pmbb058 name="input.a.pmbb058"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb058
            #add-point:ON CHANGE pmbb058 name="input.g.pmbb058"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb040
            
            #add-point:AFTER FIELD pmbb040 name="input.a.pmbb040"
            CALL apmt101_pmbb090_ref(g_pmbb_m.pmbb040) RETURNING g_pmbb_m.pmbb040_desc
            DISPLAY BY NAME g_pmbb_m.pmbb040_desc
            
            IF  NOT cl_null(g_pmbb_m.pmbb040) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmbb_m.pmbb040 != g_pmbb_m_t.pmbb040 OR cl_null(g_pmbb_m_t.pmbb040))) THEN 
                  IF NOT apmt101_pmbb090_chk(g_pmbb_m.pmbb040) THEN
                     LET g_pmbb_m.pmbb040 = g_pmbb_m_t.pmbb040
                     CALL apmt101_pmbb090_ref(g_pmbb_m.pmbb040) RETURNING g_pmbb_m.pmbb040_desc
                     DISPLAY BY NAME g_pmbb_m.pmbb040_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb040
            #add-point:BEFORE FIELD pmbb040 name="input.b.pmbb040"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb040
            #add-point:ON CHANGE pmbb040 name="input.g.pmbb040"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb041
            
            #add-point:AFTER FIELD pmbb041 name="input.a.pmbb041"
            CALL s_apmi011_location_ref(g_pmbb_m.pmbb040,g_pmbb_m.pmbb041) RETURNING g_pmbb_m.pmbb041_desc
            DISPLAY BY NAME g_pmbb_m.pmbb041_desc
            
            IF  NOT cl_null(g_pmbb_m.pmbb041) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmbb_m.pmbb041 != g_pmbb_m_t.pmbb041 OR cl_null(g_pmbb_m_t.pmbb041))) THEN 
                  IF NOT s_apmi011_check_location(g_pmbb_m.pmbb040,g_pmbb_m.pmbb041) THEN
                     LET g_pmbb_m.pmbb041 = g_pmbb_m_t.pmbb041
                     CALL s_apmi011_location_ref(g_pmbb_m.pmbb040,g_pmbb_m.pmbb041) RETURNING g_pmbb_m.pmbb041_desc
                     DISPLAY BY NAME g_pmbb_m.pmbb041_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb041
            #add-point:BEFORE FIELD pmbb041 name="input.b.pmbb041"
            IF cl_null(g_pmbb_m.pmbb040) THEN  #運輸類型
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axm-00085'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               #請先輸入運輸方式
               NEXT FIELD pmbb040
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb041
            #add-point:ON CHANGE pmbb041 name="input.g.pmbb041"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb042
            
            #add-point:AFTER FIELD pmbb042 name="input.a.pmbb042"
            CALL s_apmi011_location_ref(g_pmbb_m.pmbb040,g_pmbb_m.pmbb042) RETURNING g_pmbb_m.pmbb042_desc
            DISPLAY BY NAME g_pmbb_m.pmbb042_desc
            
            IF  NOT cl_null(g_pmbb_m.pmbb042) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmbb_m.pmbb042 != g_pmbb_m_t.pmbb042 OR cl_null(g_pmbb_m_t.pmbb042))) THEN 
                  IF NOT s_apmi011_check_location(g_pmbb_m.pmbb040,g_pmbb_m.pmbb042) THEN
                     LET g_pmbb_m.pmbb042 = g_pmbb_m_t.pmbb042
                     CALL s_apmi011_location_ref(g_pmbb_m.pmbb040,g_pmbb_m.pmbb042) RETURNING g_pmbb_m.pmbb042_desc
                     DISPLAY BY NAME g_pmbb_m.pmbb042_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb042
            #add-point:BEFORE FIELD pmbb042 name="input.b.pmbb042"
            IF cl_null(g_pmbb_m.pmbb040) THEN  #運輸類型
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axm-00085'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               #請先輸入運輸方式
               NEXT FIELD pmbb040
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb042
            #add-point:ON CHANGE pmbb042 name="input.g.pmbb042"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb043
            
            #add-point:AFTER FIELD pmbb043 name="input.a.pmbb043"
            CALL apmt101_pmbb091_ref(g_pmbb_m.pmbb043) RETURNING g_pmbb_m.pmbb043_desc
            DISPLAY BY NAME g_pmbb_m.pmbb043_desc
            
            IF  NOT cl_null(g_pmbb_m.pmbb043) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmbb_m.pmbb043 != g_pmbb_m_t.pmbb043 OR cl_null(g_pmbb_m_t.pmbb043))) THEN 
                  IF NOT apmt101_pmbb091_chk(g_pmbb_m.pmbb043) THEN
                     LET g_pmbb_m.pmbb043 = g_pmbb_m_t.pmbb043
                     CALL apmt101_pmbb091_ref(g_pmbb_m.pmbb043) RETURNING g_pmbb_m.pmbb043_desc
                     DISPLAY BY NAME g_pmbb_m.pmbb043_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb043
            #add-point:BEFORE FIELD pmbb043 name="input.b.pmbb043"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb043
            #add-point:ON CHANGE pmbb043 name="input.g.pmbb043"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb044
            #add-point:BEFORE FIELD pmbb044 name="input.b.pmbb044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb044
            
            #add-point:AFTER FIELD pmbb044 name="input.a.pmbb044"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb044
            #add-point:ON CHANGE pmbb044 name="input.g.pmbb044"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb045
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmbb_m.pmbb045,"0.000","1","100.000","1","azz-00087",1) THEN
               NEXT FIELD pmbb045
            END IF 
 
 
 
            #add-point:AFTER FIELD pmbb045 name="input.a.pmbb045"
            IF NOT cl_null(g_pmbb_m.pmbb045) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb045
            #add-point:BEFORE FIELD pmbb045 name="input.b.pmbb045"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb045
            #add-point:ON CHANGE pmbb045 name="input.g.pmbb045"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb046
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmbb_m.pmbb046,"0.000","1","100.000","1","azz-00087",1) THEN
               NEXT FIELD pmbb046
            END IF 
 
 
 
            #add-point:AFTER FIELD pmbb046 name="input.a.pmbb046"
            IF NOT cl_null(g_pmbb_m.pmbb046) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb046
            #add-point:BEFORE FIELD pmbb046 name="input.b.pmbb046"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb046
            #add-point:ON CHANGE pmbb046 name="input.g.pmbb046"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb047
            
            #add-point:AFTER FIELD pmbb047 name="input.a.pmbb047"
            CALL apmt101_pmbb003_ref(g_pmbb_m.pmbb047) RETURNING g_pmbb_m.pmbb047_desc
            DISPLAY BY NAME g_pmbb_m.pmbb047_desc
            
            IF  NOT cl_null(g_pmbb_m.pmbb047) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmbb_m.pmbb047 != g_pmbb_m_t.pmbb047 OR cl_null(g_pmbb_m_t.pmbb047))) THEN 
                  IF NOT apmt101_pmbb097_chk(g_pmbb_m.pmbb047) THEN
                     LET g_pmbb_m.pmbb047 = g_pmbb_m_t.pmbb047
                     CALL apmt101_pmbb003_ref(g_pmbb_m.pmbb047) RETURNING g_pmbb_m.pmbb047_desc
                     DISPLAY BY NAME g_pmbb_m.pmbb047_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb047
            #add-point:BEFORE FIELD pmbb047 name="input.b.pmbb047"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb047
            #add-point:ON CHANGE pmbb047 name="input.g.pmbb047"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb048
            #add-point:BEFORE FIELD pmbb048 name="input.b.pmbb048"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb048
            
            #add-point:AFTER FIELD pmbb048 name="input.a.pmbb048"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb048
            #add-point:ON CHANGE pmbb048 name="input.g.pmbb048"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb049
            #add-point:BEFORE FIELD pmbb049 name="input.b.pmbb049"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb049
            
            #add-point:AFTER FIELD pmbb049 name="input.a.pmbb049"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb049
            #add-point:ON CHANGE pmbb049 name="input.g.pmbb049"
            CALL apmt101_set_entry(p_cmd)
            CALL apmt101_set_no_entry(p_cmd)
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb050
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmbb_m.pmbb050,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD pmbb050
            END IF 
 
 
 
            #add-point:AFTER FIELD pmbb050 name="input.a.pmbb050"
            IF NOT cl_null(g_pmbb_m.pmbb050) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb050
            #add-point:BEFORE FIELD pmbb050 name="input.b.pmbb050"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb050
            #add-point:ON CHANGE pmbb050 name="input.g.pmbb050"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb051
            #add-point:BEFORE FIELD pmbb051 name="input.b.pmbb051"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb051
            
            #add-point:AFTER FIELD pmbb051 name="input.a.pmbb051"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb051
            #add-point:ON CHANGE pmbb051 name="input.g.pmbb051"
            CALL apmt101_set_entry(p_cmd)
            CALL apmt101_set_no_entry(p_cmd)
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb052
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmbb_m.pmbb052,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD pmbb052
            END IF 
 
 
 
            #add-point:AFTER FIELD pmbb052 name="input.a.pmbb052"
            IF NOT cl_null(g_pmbb_m.pmbb052) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb052
            #add-point:BEFORE FIELD pmbb052 name="input.b.pmbb052"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb052
            #add-point:ON CHANGE pmbb052 name="input.g.pmbb052"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb071
            #add-point:BEFORE FIELD pmbb071 name="input.b.pmbb071"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb071
            
            #add-point:AFTER FIELD pmbb071 name="input.a.pmbb071"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb071
            #add-point:ON CHANGE pmbb071 name="input.g.pmbb071"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb072
            #add-point:BEFORE FIELD pmbb072 name="input.b.pmbb072"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb072
            
            #add-point:AFTER FIELD pmbb072 name="input.a.pmbb072"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb072
            #add-point:ON CHANGE pmbb072 name="input.g.pmbb072"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb073
            #add-point:BEFORE FIELD pmbb073 name="input.b.pmbb073"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb073
            
            #add-point:AFTER FIELD pmbb073 name="input.a.pmbb073"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb073
            #add-point:ON CHANGE pmbb073 name="input.g.pmbb073"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb060
            #add-point:BEFORE FIELD pmbb060 name="input.b.pmbb060"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb060
            
            #add-point:AFTER FIELD pmbb060 name="input.a.pmbb060"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb060
            #add-point:ON CHANGE pmbb060 name="input.g.pmbb060"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb061
            #add-point:BEFORE FIELD pmbb061 name="input.b.pmbb061"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb061
            
            #add-point:AFTER FIELD pmbb061 name="input.a.pmbb061"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb061
            #add-point:ON CHANGE pmbb061 name="input.g.pmbb061"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb066
            #add-point:BEFORE FIELD pmbb066 name="input.b.pmbb066"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb066
            
            #add-point:AFTER FIELD pmbb066 name="input.a.pmbb066"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb066
            #add-point:ON CHANGE pmbb066 name="input.g.pmbb066"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb062
            #add-point:BEFORE FIELD pmbb062 name="input.b.pmbb062"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb062
            
            #add-point:AFTER FIELD pmbb062 name="input.a.pmbb062"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb062
            #add-point:ON CHANGE pmbb062 name="input.g.pmbb062"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb067
            #add-point:BEFORE FIELD pmbb067 name="input.b.pmbb067"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb067
            
            #add-point:AFTER FIELD pmbb067 name="input.a.pmbb067"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb067
            #add-point:ON CHANGE pmbb067 name="input.g.pmbb067"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb063
            #add-point:BEFORE FIELD pmbb063 name="input.b.pmbb063"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb063
            
            #add-point:AFTER FIELD pmbb063 name="input.a.pmbb063"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb063
            #add-point:ON CHANGE pmbb063 name="input.g.pmbb063"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb068
            #add-point:BEFORE FIELD pmbb068 name="input.b.pmbb068"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb068
            
            #add-point:AFTER FIELD pmbb068 name="input.a.pmbb068"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb068
            #add-point:ON CHANGE pmbb068 name="input.g.pmbb068"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb064
            #add-point:BEFORE FIELD pmbb064 name="input.b.pmbb064"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb064
            
            #add-point:AFTER FIELD pmbb064 name="input.a.pmbb064"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb064
            #add-point:ON CHANGE pmbb064 name="input.g.pmbb064"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb069
            #add-point:BEFORE FIELD pmbb069 name="input.b.pmbb069"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb069
            
            #add-point:AFTER FIELD pmbb069 name="input.a.pmbb069"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb069
            #add-point:ON CHANGE pmbb069 name="input.g.pmbb069"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb065
            #add-point:BEFORE FIELD pmbb065 name="input.b.pmbb065"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb065
            
            #add-point:AFTER FIELD pmbb065 name="input.a.pmbb065"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb065
            #add-point:ON CHANGE pmbb065 name="input.g.pmbb065"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb070
            #add-point:BEFORE FIELD pmbb070 name="input.b.pmbb070"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb070
            
            #add-point:AFTER FIELD pmbb070 name="input.a.pmbb070"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb070
            #add-point:ON CHANGE pmbb070 name="input.g.pmbb070"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD total
            #add-point:BEFORE FIELD total name="input.b.total"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD total
            
            #add-point:AFTER FIELD total name="input.a.total"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE total
            #add-point:ON CHANGE total name="input.g.total"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb002
            #add-point:BEFORE FIELD pmbb002 name="input.b.pmbb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb002
            
            #add-point:AFTER FIELD pmbb002 name="input.a.pmbb002"
            CALL apmt101_set_no_required()
            CALL apmt101_set_required()
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb002
            #add-point:ON CHANGE pmbb002 name="input.g.pmbb002"
 
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb003
            
            #add-point:AFTER FIELD pmbb003 name="input.a.pmbb003"
            CALL apmt101_pmbb003_ref(g_pmbb_m.pmbb003) RETURNING g_pmbb_m.pmbb003_desc
            DISPLAY BY NAME g_pmbb_m.pmbb003_desc
            
            IF NOT cl_null(g_pmbb_m.pmbb003) THEN
               IF g_pmbb_m.pmbb003 != g_pmbb_m_t.pmbb003 OR cl_null(g_pmbb_m_t.pmbb003) THEN 
                  IF NOT ap_chk_isExist(g_pmbb_m.pmbb003,"SELECT COUNT(*) FROM pmaa_t WHERE pmaaent = '" ||g_enterprise||"' AND pmaa001 = ? ","apm-00028",1 ) THEN
                     LET g_pmbb_m.pmbb003 = g_pmbb_m_t.pmbb003
                     CALL apmt101_pmbb003_ref(g_pmbb_m.pmbb003) RETURNING g_pmbb_m.pmbb003_desc
                     DISPLAY BY NAME g_pmbb_m.pmbb003_desc
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT ap_chk_isExist(g_pmbb_m.pmbb003,"SELECT COUNT(*) FROM pmaa_t WHERE pmaaent = '" ||g_enterprise||"' AND pmaa001 = ? AND pmaastus != 'X' ","sub-01302","apmm100") THEN  #apm-00029  #160318-00005#36  By 07900 --mod  
                     LET g_pmbb_m.pmbb003 = g_pmbb_m_t.pmbb003
                     CALL apmt101_pmbb003_ref(g_pmbb_m.pmbb003) RETURNING g_pmbb_m.pmbb003_desc
                     DISPLAY BY NAME g_pmbb_m.pmbb003_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb003
            #add-point:BEFORE FIELD pmbb003 name="input.b.pmbb003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb003
            #add-point:ON CHANGE pmbb003 name="input.g.pmbb003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb004
            
            #add-point:AFTER FIELD pmbb004 name="input.a.pmbb004"
            #ming 20140817 add -----------------------------------------------------(S) 
            #信用評核的開窗與校驗都從xmaa_t 改成xmaj_t             
            LET g_pmbb_m.pmbb004_desc = ' '
            CALL apmt101_pmbb004_ref(g_pmbb_m.pmbb004) RETURNING g_pmbb_m.pmbb004_desc
            DISPLAY BY NAME g_pmbb_m.pmbb004_desc

            IF NOT cl_null(g_pmbb_m.pmbb004) THEN
               #此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_pmbb_m.pmbb004


               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_xmaj001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_pmbb_m.pmbb004 = g_pmbb_m_t.pmbb004
                  CALL apmt101_pmbb004_ref(g_pmbb_m.pmbb004) RETURNING g_pmbb_m.pmbb004_desc
                  DISPLAY BY NAME g_pmbb_m.pmbb004_desc
                  NEXT FIELD CURRENT
               END IF


            END IF 
            CALL apmt101_pmbb004_ref(g_pmbb_m.pmbb004) RETURNING g_pmbb_m.pmbb004_desc
            DISPLAY BY NAME g_pmbb_m.pmbb004_desc
            #ming 20140817 add -----------------------------------------------------(E) 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb004
            #add-point:BEFORE FIELD pmbb004 name="input.b.pmbb004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb004
            #add-point:ON CHANGE pmbb004 name="input.g.pmbb004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb005
            
            #add-point:AFTER FIELD pmbb005 name="input.a.pmbb005"
            CALL apmt101_pmbb083_ref(g_pmbb_m.pmbb005) RETURNING g_pmbb_m.pmbb005_desc
            DISPLAY BY NAME g_pmbb_m.pmbb005_desc
            
            IF NOT cl_null(g_pmbb_m.pmbb005) THEN
               IF g_pmbb_m.pmbb005 != g_pmbb_m_t.pmbb005 OR cl_null(g_pmbb_m_t.pmbb005) THEN 
                  IF NOT apmt101_pmbb083_chk(g_pmbb_m.pmbb005) THEN
                     LET g_pmbb_m.pmbb005 = g_pmbb_m_t.pmbb005
                     CALL apmt101_pmbb083_ref(g_pmbb_m.pmbb005) RETURNING g_pmbb_m.pmbb005_desc
                     DISPLAY BY NAME g_pmbb_m.pmbb005_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb005
            #add-point:BEFORE FIELD pmbb005 name="input.b.pmbb005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb005
            #add-point:ON CHANGE pmbb005 name="input.g.pmbb005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb006
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmbb_m.pmbb006,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD pmbb006
            END IF 
 
 
 
            #add-point:AFTER FIELD pmbb006 name="input.a.pmbb006"
            IF NOT cl_null(g_pmbb_m.pmbb006) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb006
            #add-point:BEFORE FIELD pmbb006 name="input.b.pmbb006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb006
            #add-point:ON CHANGE pmbb006 name="input.g.pmbb006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb007
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmbb_m.pmbb007,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD pmbb007
            END IF 
 
 
 
            #add-point:AFTER FIELD pmbb007 name="input.a.pmbb007"
            IF NOT cl_null(g_pmbb_m.pmbb007) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb007
            #add-point:BEFORE FIELD pmbb007 name="input.b.pmbb007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb007
            #add-point:ON CHANGE pmbb007 name="input.g.pmbb007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb008
            #add-point:BEFORE FIELD pmbb008 name="input.b.pmbb008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb008
            
            #add-point:AFTER FIELD pmbb008 name="input.a.pmbb008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb008
            #add-point:ON CHANGE pmbb008 name="input.g.pmbb008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb009
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmbb_m.pmbb009,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD pmbb009
            END IF 
 
 
 
            #add-point:AFTER FIELD pmbb009 name="input.a.pmbb009"
            IF NOT cl_null(g_pmbb_m.pmbb009) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb009
            #add-point:BEFORE FIELD pmbb009 name="input.b.pmbb009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb009
            #add-point:ON CHANGE pmbb009 name="input.g.pmbb009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb019
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmbb_m.pmbb019,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD pmbb019
            END IF 
 
 
 
            #add-point:AFTER FIELD pmbb019 name="input.a.pmbb019"
            IF NOT cl_null(g_pmbb_m.pmbb019) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb019
            #add-point:BEFORE FIELD pmbb019 name="input.b.pmbb019"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb019
            #add-point:ON CHANGE pmbb019 name="input.g.pmbb019"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb010
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmbb_m.pmbb010,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD pmbb010
            END IF 
 
 
 
            #add-point:AFTER FIELD pmbb010 name="input.a.pmbb010"
            IF NOT cl_null(g_pmbb_m.pmbb010) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb010
            #add-point:BEFORE FIELD pmbb010 name="input.b.pmbb010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb010
            #add-point:ON CHANGE pmbb010 name="input.g.pmbb010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb020
            #add-point:BEFORE FIELD pmbb020 name="input.b.pmbb020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb020
            
            #add-point:AFTER FIELD pmbb020 name="input.a.pmbb020"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb020
            #add-point:ON CHANGE pmbb020 name="input.g.pmbb020"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb011
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmbb_m.pmbb011,"0.000","1","100.000","1","azz-00087",1) THEN
               NEXT FIELD pmbb011
            END IF 
 
 
 
            #add-point:AFTER FIELD pmbb011 name="input.a.pmbb011"
            IF NOT cl_null(g_pmbb_m.pmbb011) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb011
            #add-point:BEFORE FIELD pmbb011 name="input.b.pmbb011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb011
            #add-point:ON CHANGE pmbb011 name="input.g.pmbb011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb012
            #add-point:BEFORE FIELD pmbb012 name="input.b.pmbb012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb012
            
            #add-point:AFTER FIELD pmbb012 name="input.a.pmbb012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb012
            #add-point:ON CHANGE pmbb012 name="input.g.pmbb012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb013
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmbb_m.pmbb013,"0.000","1","100.000","1","azz-00087",1) THEN
               NEXT FIELD pmbb013
            END IF 
 
 
 
            #add-point:AFTER FIELD pmbb013 name="input.a.pmbb013"
            IF NOT cl_null(g_pmbb_m.pmbb013) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb013
            #add-point:BEFORE FIELD pmbb013 name="input.b.pmbb013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb013
            #add-point:ON CHANGE pmbb013 name="input.g.pmbb013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb014
            #add-point:BEFORE FIELD pmbb014 name="input.b.pmbb014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb014
            
            #add-point:AFTER FIELD pmbb014 name="input.a.pmbb014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb014
            #add-point:ON CHANGE pmbb014 name="input.g.pmbb014"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb015
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmbb_m.pmbb015,"0.000","1","100.000","1","azz-00087",1) THEN
               NEXT FIELD pmbb015
            END IF 
 
 
 
            #add-point:AFTER FIELD pmbb015 name="input.a.pmbb015"
            IF NOT cl_null(g_pmbb_m.pmbb015) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb015
            #add-point:BEFORE FIELD pmbb015 name="input.b.pmbb015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb015
            #add-point:ON CHANGE pmbb015 name="input.g.pmbb015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb016
            #add-point:BEFORE FIELD pmbb016 name="input.b.pmbb016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb016
            
            #add-point:AFTER FIELD pmbb016 name="input.a.pmbb016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb016
            #add-point:ON CHANGE pmbb016 name="input.g.pmbb016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb017
            #add-point:BEFORE FIELD pmbb017 name="input.b.pmbb017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb017
            
            #add-point:AFTER FIELD pmbb017 name="input.a.pmbb017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb017
            #add-point:ON CHANGE pmbb017 name="input.g.pmbb017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbb018
            #add-point:BEFORE FIELD pmbb018 name="input.b.pmbb018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbb018
            
            #add-point:AFTER FIELD pmbb018 name="input.a.pmbb018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbb018
            #add-point:ON CHANGE pmbb018 name="input.g.pmbb018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooff013
            #add-point:BEFORE FIELD ooff013 name="input.b.ooff013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooff013
            
            #add-point:AFTER FIELD ooff013 name="input.a.ooff013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooff013
            #add-point:ON CHANGE ooff013 name="input.g.ooff013"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.pmbbdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbbdocno
            #add-point:ON ACTION controlp INFIELD pmbbdocno name="input.c.pmbbdocno"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmbb001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb001
            #add-point:ON ACTION controlp INFIELD pmbb001 name="input.c.pmbb001"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmbb080
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb080
            #add-point:ON ACTION controlp INFIELD pmbb080 name="input.c.pmbb080"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmbb081
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb081
            #add-point:ON ACTION controlp INFIELD pmbb081 name="input.c.pmbb081"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmbb_m.pmbb081             #給予default值

            #給予arg

            CALL q_ooag001_4()                                #呼叫開窗

            LET g_pmbb_m.pmbb081 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmbb_m.pmbb081 TO pmbb081              #顯示到畫面上
            CALL apmt101_pmbb081_ref(g_pmbb_m.pmbb081) RETURNING g_pmbb_m.pmbb081_desc
            DISPLAY BY NAME g_pmbb_m.pmbb081_desc

            NEXT FIELD pmbb081                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmbb109
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb109
            #add-point:ON ACTION controlp INFIELD pmbb109 name="input.c.pmbb109"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmbb_m.pmbb109             #給予default值
            LET g_qryparam.default2 = "" #g_pmbb_m.ooeg001 #部門編號
            #給予arg
            LET g_qryparam.arg1 = g_today


            CALL q_ooeg001()                                #呼叫開窗

            LET g_pmbb_m.pmbb109 = g_qryparam.return1              
            #LET g_pmbb_m.ooeg001 = g_qryparam.return2 
            DISPLAY g_pmbb_m.pmbb109 TO pmbb109              #
            #DISPLAY g_pmbb_m.ooeg001 TO ooeg001 #部門編號
            
            CALL s_desc_get_department_desc(g_pmbb_m.pmbb109) RETURNING g_pmbb_m.pmbb109_desc
            DISPLAY BY NAME g_pmbb_m.pmbb109_desc
            
            NEXT FIELD pmbb109                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmbb082
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb082
            #add-point:ON ACTION controlp INFIELD pmbb082 name="input.c.pmbb082"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmbb083
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb083
            #add-point:ON ACTION controlp INFIELD pmbb083 name="input.c.pmbb083"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmbb_m.pmbb083             #給予default值

            #給予arg

            IF g_site = 'ALL' THEN
               LET g_qryparam.arg1 = g_site_t
            ELSE
               LET g_qryparam.arg1 = g_site
            END IF
            
            CALL q_ooaj002_1()                         #呼叫開窗

            LET g_pmbb_m.pmbb083 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmbb_m.pmbb083 TO pmbb083              #顯示到畫面上
            CALL apmt101_pmbb083_ref(g_pmbb_m.pmbb083) RETURNING g_pmbb_m.pmbb083_desc
            DISPLAY BY NAME g_pmbb_m.pmbb083_desc

            NEXT FIELD pmbb083                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmbb084
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb084
            #add-point:ON ACTION controlp INFIELD pmbb084 name="input.c.pmbb084"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmbb_m.pmbb084             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = g_site

            IF g_site = 'ALL' THEN 
               LET g_qryparam.arg1 = g_site_t
            ELSE
               LET g_qryparam.arg1 = g_site
            END IF
            CALL q_oodb002_3()                                 #呼叫開窗

            LET g_pmbb_m.pmbb084 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmbb_m.pmbb084 TO pmbb084              #顯示到畫面上
            CALL apmt101_pmbb084_ref(g_pmbb_m.pmbb084) RETURNING g_pmbb_m.pmbb084_desc
            DISPLAY BY NAME g_pmbb_m.pmbb084_desc

            NEXT FIELD pmbb084                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmbb103
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb103
            #add-point:ON ACTION controlp INFIELD pmbb103 name="input.c.pmbb103"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmbb_m.pmbb103             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "238"   #170213-00038#2   mark

            #CALL q_oocq002()                                #呼叫開窗  #170213-00038#2   mark
            CALL q_oocq002_238()   #170213-00038#2   add

            LET g_pmbb_m.pmbb103 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmbb_m.pmbb103 TO pmbb103              #顯示到畫面上
            CALL apmt101_pmbb103_ref(g_pmbb_m.pmbb103) RETURNING g_pmbb_m.pmbb103_desc
            DISPLAY BY NAME g_pmbb_m.pmbb103_desc

            NEXT FIELD pmbb103                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmbb104
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb104
            #add-point:ON ACTION controlp INFIELD pmbb104 name="input.c.pmbb104"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmbb_m.pmbb104             #給予default值

            #給予arg

            CALL q_xmah001()                                #呼叫開窗

            LET g_pmbb_m.pmbb104 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmbb_m.pmbb104 TO pmbb104              #顯示到畫面上
            CALL apmt101_pmbb104_ref(g_pmbb_m.pmbb104) RETURNING g_pmbb_m.pmbb104_desc
            DISPLAY BY NAME g_pmbb_m.pmbb104_desc

            NEXT FIELD pmbb104                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmbb085
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb085
            #add-point:ON ACTION controlp INFIELD pmbb085 name="input.c.pmbb085"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmbb086
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb086
            #add-point:ON ACTION controlp INFIELD pmbb086 name="input.c.pmbb086"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmbb106
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb106
            #add-point:ON ACTION controlp INFIELD pmbb106 name="input.c.pmbb106"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmbb_m.pmbb106             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_ooef019 #
            LET g_qryparam.arg2 = "2" #

            CALL q_isac002_1()                                #呼叫開窗

            LET g_pmbb_m.pmbb106 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmbb_m.pmbb106 TO pmbb106              #顯示到畫面上
            CALL apmt101_pmbb106_ref(g_pmbb_m.pmbb106) RETURNING g_pmbb_m.pmbb106_desc
            DISPLAY BY NAME g_pmbb_m.pmbb106_desc
            NEXT FIELD pmbb106                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmbb087
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb087
            #add-point:ON ACTION controlp INFIELD pmbb087 name="input.c.pmbb087"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmbb_m.pmbb087             #給予default值
            LET g_qryparam.default2 = "" #g_pmbb_m.ooibl004 #說明

            #給予arg
            LET g_qryparam.arg1 = g_pmbb_m.pmbbdocno
            LET g_qryparam.arg2 = "2" #

            CALL q_pmbd002()                                #呼叫開窗

            LET g_pmbb_m.pmbb087 = g_qryparam.return1              #將開窗取得的值回傳到變數
            #LET g_pmbb_m.ooibl004 = g_qryparam.return2 #說明

            DISPLAY g_pmbb_m.pmbb087 TO pmbb087              #顯示到畫面上
            #DISPLAY g_pmbb_m.ooibl004 TO ooibl004 #說明
            CALL apmt101_pmbb087_ref(g_pmbb_m.pmbb087) RETURNING g_pmbb_m.pmbb087_desc
            DISPLAY BY NAME g_pmbb_m.pmbb087_desc

            NEXT FIELD pmbb087                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmbb105
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb105
            #add-point:ON ACTION controlp INFIELD pmbb105 name="input.c.pmbb105"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmbb_m.pmbb105             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "3111" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmbb_m.pmbb105 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmbb_m.pmbb105 TO pmbb105              #顯示到畫面上
            CALL apmt101_pmbb105_ref(g_pmbb_m.pmbb105) RETURNING g_pmbb_m.pmbb105_desc
            DISPLAY BY NAME g_pmbb_m.pmbb105_desc

            NEXT FIELD pmbb105                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmbb088
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb088
            #add-point:ON ACTION controlp INFIELD pmbb088 name="input.c.pmbb088"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmbb_m.pmbb088             #給予default值

            #給予arg
            #160621-00003#3 20160627 modify by beckxie---S
			   #LET g_qryparam.arg1 = "275"
            #CALL q_oocq002()                           #呼叫開窗
            LET g_qryparam.arg1 = '1'
            CALL q_oojd001_1()
            #160621-00003#3 20160627 modify by beckxie---E

            LET g_pmbb_m.pmbb088 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmbb_m.pmbb088 TO pmbb088              #顯示到畫面上
            CALL apmt101_pmbb088_ref(g_pmbb_m.pmbb088) RETURNING g_pmbb_m.pmbb088_desc
            DISPLAY BY NAME g_pmbb_m.pmbb088_desc
            NEXT FIELD pmbb088                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmbb089
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb089
            #add-point:ON ACTION controlp INFIELD pmbb089 name="input.c.pmbb089"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmbb_m.pmbb089             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "295" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmbb_m.pmbb089 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmbb_m.pmbb089 TO pmbb089              #顯示到畫面上
            CALL apmt101_pmbb089_ref(g_pmbb_m.pmbb089) RETURNING g_pmbb_m.pmbb089_desc
            DISPLAY BY NAME g_pmbb_m.pmbb089_desc

            NEXT FIELD pmbb089                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmbb107
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb107
            #add-point:ON ACTION controlp INFIELD pmbb107 name="input.c.pmbb107"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmbb108
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb108
            #add-point:ON ACTION controlp INFIELD pmbb108 name="input.c.pmbb108"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmbb090
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb090
            #add-point:ON ACTION controlp INFIELD pmbb090 name="input.c.pmbb090"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmbb_m.pmbb090             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "263" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmbb_m.pmbb090 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmbb_m.pmbb090 TO pmbb090              #顯示到畫面上
            CALL apmt101_pmbb090_ref(g_pmbb_m.pmbb090) RETURNING g_pmbb_m.pmbb090_desc
            DISPLAY BY NAME g_pmbb_m.pmbb090_desc

            NEXT FIELD pmbb090                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmbb091
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb091
            #add-point:ON ACTION controlp INFIELD pmbb091 name="input.c.pmbb091"
#此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmbb_m.pmbb091             #給予default值

            CALL apmt101_get_oocq019(g_pmbb_m.pmbb090) RETURNING l_oocq019  #運輸類型
            IF NOT cl_null(l_oocq019) THEN
               CASE
                  WHEN l_oocq019 ='1' OR l_oocq019='4'
                     LET g_qryparam.arg1 = "315"
                     CALL q_oocq002()
                  WHEN l_oocq019 ='2'
                     CALL q_oocq002_10()
                  WHEN l_oocq019 ='3'
                     CALL q_oocq002_12()
                  OTHERWISE EXIT CASE
               END CASE
            END IF  

            LET g_pmbb_m.pmbb091 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmbb_m.pmbb091 TO pmbb091              #顯示到畫面上
            CALL s_apmi011_location_ref(g_pmbb_m.pmbb090,g_pmbb_m.pmbb091) RETURNING g_pmbb_m.pmbb091_desc
            DISPLAY BY NAME g_pmbb_m.pmbb091_desc

            NEXT FIELD pmbb091                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmbb092
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb092
            #add-point:ON ACTION controlp INFIELD pmbb092 name="input.c.pmbb092"
#此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmbb_m.pmbb092             #給予default值

            CALL apmt101_get_oocq019(g_pmbb_m.pmbb090) RETURNING l_oocq019  #運輸類型
            IF NOT cl_null(l_oocq019) THEN
               CASE
                  WHEN l_oocq019 ='1' OR l_oocq019='4'
                     LET g_qryparam.arg1 = "315"
                     CALL q_oocq002()
                  WHEN l_oocq019 ='2'
                     CALL q_oocq002_10()
                  WHEN l_oocq019 ='3'
                     CALL q_oocq002_12()
                  OTHERWISE EXIT CASE
               END CASE
            END IF  
            
            LET g_pmbb_m.pmbb092 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmbb_m.pmbb092 TO pmbb092              #顯示到畫面上
            CALL s_apmi011_location_ref(g_pmbb_m.pmbb090,g_pmbb_m.pmbb092) RETURNING g_pmbb_m.pmbb092_desc
            DISPLAY BY NAME g_pmbb_m.pmbb092_desc

            NEXT FIELD pmbb092                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmbb093
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb093
            #add-point:ON ACTION controlp INFIELD pmbb093 name="input.c.pmbb093"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmbb_m.pmbb093             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "262" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmbb_m.pmbb093 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmbb_m.pmbb093 TO pmbb093              #顯示到畫面上
            CALL apmt101_pmbb091_ref(g_pmbb_m.pmbb093) RETURNING g_pmbb_m.pmbb093_desc
            DISPLAY BY NAME g_pmbb_m.pmbb093_desc

            NEXT FIELD pmbb093                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmbb094
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb094
            #add-point:ON ACTION controlp INFIELD pmbb094 name="input.c.pmbb094"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmbb095
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb095
            #add-point:ON ACTION controlp INFIELD pmbb095 name="input.c.pmbb095"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmbb096
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb096
            #add-point:ON ACTION controlp INFIELD pmbb096 name="input.c.pmbb096"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmbb097
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb097
            #add-point:ON ACTION controlp INFIELD pmbb097 name="input.c.pmbb097"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.where = " (pmaa002 = '1' OR pmaa002 = '3') "

            LET g_qryparam.default1 = g_pmbb_m.pmbb097             #給予default值

            #給予arg

            CALL q_pmaa001_4()                                #呼叫開窗

            LET g_pmbb_m.pmbb097 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmbb_m.pmbb097 TO pmbb097              #顯示到畫面上
            CALL apmt101_pmbb003_ref(g_pmbb_m.pmbb097_desc) RETURNING g_pmbb_m.pmbb097_desc
            DISPLAY BY NAME g_pmbb_m.pmbb097_desc

            NEXT FIELD pmbb097                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmbb098
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb098
            #add-point:ON ACTION controlp INFIELD pmbb098 name="input.c.pmbb098"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmbb099
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb099
            #add-point:ON ACTION controlp INFIELD pmbb099 name="input.c.pmbb099"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmbb100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb100
            #add-point:ON ACTION controlp INFIELD pmbb100 name="input.c.pmbb100"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmbb101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb101
            #add-point:ON ACTION controlp INFIELD pmbb101 name="input.c.pmbb101"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmbb102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb102
            #add-point:ON ACTION controlp INFIELD pmbb102 name="input.c.pmbb102"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmbb030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb030
            #add-point:ON ACTION controlp INFIELD pmbb030 name="input.c.pmbb030"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmbb031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb031
            #add-point:ON ACTION controlp INFIELD pmbb031 name="input.c.pmbb031"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmbb_m.pmbb031             #給予default值

            #給予arg

            CALL q_ooag001_4()                                #呼叫開窗

            LET g_pmbb_m.pmbb031 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmbb_m.pmbb031 TO pmbb031              #顯示到畫面上
            CALL apmt101_pmbb081_ref(g_pmbb_m.pmbb031) RETURNING g_pmbb_m.pmbb031_desc
            DISPLAY BY NAME g_pmbb_m.pmbb031_desc

            NEXT FIELD pmbb031                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmbb059
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb059
            #add-point:ON ACTION controlp INFIELD pmbb059 name="input.c.pmbb059"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmbb_m.pmbb059             #給予default值
            LET g_qryparam.default2 = "" #g_pmbb_m.ooeg001 #部門編號
            #給予arg
            LET g_qryparam.arg1 = g_today


            CALL q_ooeg001()                                #呼叫開窗

            LET g_pmbb_m.pmbb059 = g_qryparam.return1              
            #LET g_pmbb_m.ooeg001 = g_qryparam.return2 
            DISPLAY g_pmbb_m.pmbb059 TO pmbb059              #
            #DISPLAY g_pmbb_m.ooeg001 TO ooeg001 #部門編號
            
            CALL s_desc_get_department_desc(g_pmbb_m.pmbb059) RETURNING g_pmbb_m.pmbb059_desc
            DISPLAY BY NAME g_pmbb_m.pmbb059_desc
            
            NEXT FIELD pmbb059                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmbb032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb032
            #add-point:ON ACTION controlp INFIELD pmbb032 name="input.c.pmbb032"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmbb033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb033
            #add-point:ON ACTION controlp INFIELD pmbb033 name="input.c.pmbb033"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmbb_m.pmbb033             #給予default值

            #給予arg

            IF g_site = 'ALL' THEN
               LET g_qryparam.arg1 = g_site_t
            ELSE
               LET g_qryparam.arg1 = g_site
            END IF
            
            CALL q_ooaj002_1()                              #呼叫開窗

            LET g_pmbb_m.pmbb033 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmbb_m.pmbb033 TO pmbb033              #顯示到畫面上
            CALL apmt101_pmbb083_ref(g_pmbb_m.pmbb033) RETURNING g_pmbb_m.pmbb033_desc
            DISPLAY BY NAME g_pmbb_m.pmbb033_desc

            NEXT FIELD pmbb033                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmbb034
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb034
            #add-point:ON ACTION controlp INFIELD pmbb034 name="input.c.pmbb034"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmbb_m.pmbb034             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = g_site

            IF g_site = 'ALL' THEN 
               LET g_qryparam.arg1 = g_site_t
            ELSE
               LET g_qryparam.arg1 = g_site
            END IF
            CALL q_oodb002_3()                                #呼叫開窗

            LET g_pmbb_m.pmbb034 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmbb_m.pmbb034 TO pmbb034              #顯示到畫面上
            CALL apmt101_pmbb084_ref(g_pmbb_m.pmbb034) RETURNING g_pmbb_m.pmbb034_desc
            DISPLAY BY NAME g_pmbb_m.pmbb034_desc

            NEXT FIELD pmbb034                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmbb053
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb053
            #add-point:ON ACTION controlp INFIELD pmbb053 name="input.c.pmbb053"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmbb_m.pmbb053             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "238"  #170213-00038#2 mark

            #CALL q_oocq002()                                #呼叫開窗  #170213-00038#2 mark
            CALL q_oocq002_238()   #170213-00038#2   add

            LET g_pmbb_m.pmbb053 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmbb_m.pmbb053 TO pmbb053              #顯示到畫面上
            CALL apmt101_pmbb103_ref(g_pmbb_m.pmbb053) RETURNING g_pmbb_m.pmbb053_desc
            DISPLAY BY NAME g_pmbb_m.pmbb053_desc

            NEXT FIELD pmbb053                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmbb054
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb054
            #add-point:ON ACTION controlp INFIELD pmbb054 name="input.c.pmbb054"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmbb_m.pmbb054             #給予default值

            #給予arg

            CALL q_pmam001()                                #呼叫開窗

            LET g_pmbb_m.pmbb054 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmbb_m.pmbb054 TO pmbb054              #顯示到畫面上
            CALL apmt101_pmbb054_ref(g_pmbb_m.pmbb054) RETURNING g_pmbb_m.pmbb054_desc
            DISPLAY BY NAME g_pmbb_m.pmbb054_desc

            NEXT FIELD pmbb054                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmbb035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb035
            #add-point:ON ACTION controlp INFIELD pmbb035 name="input.c.pmbb035"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmbb036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb036
            #add-point:ON ACTION controlp INFIELD pmbb036 name="input.c.pmbb036"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmbb056
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb056
            #add-point:ON ACTION controlp INFIELD pmbb056 name="input.c.pmbb056"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmbb_m.pmbb056             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_ooef019 #
            LET g_qryparam.arg2 = "1" #

            CALL q_isac002_1()                                #呼叫開窗

            LET g_pmbb_m.pmbb056 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmbb_m.pmbb056 TO pmbb056              #顯示到畫面上
            CALL apmt101_pmbb106_ref(g_pmbb_m.pmbb056) RETURNING g_pmbb_m.pmbb056_desc
            DISPLAY BY NAME g_pmbb_m.pmbb056_desc
            NEXT FIELD pmbb056                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmbb037
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb037
            #add-point:ON ACTION controlp INFIELD pmbb037 name="input.c.pmbb037"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmbb_m.pmbb037             #給予default值
            LET g_qryparam.default2 = "" #g_pmbb_m.ooibl004 #說明

            #給予arg
            LET g_qryparam.arg1 = g_pmbb_m.pmbbdocno
            LET g_qryparam.arg2 = "1" #

            CALL q_pmbd002()                                #呼叫開窗

            LET g_pmbb_m.pmbb037 = g_qryparam.return1              #將開窗取得的值回傳到變數
            #LET g_pmbb_m.ooibl004 = g_qryparam.return2 #說明

            DISPLAY g_pmbb_m.pmbb037 TO pmbb037              #顯示到畫面上
            #DISPLAY g_pmbb_m.ooibl004 TO ooibl004 #說明
            CALL apmt101_pmbb087_ref(g_pmbb_m.pmbb037) RETURNING g_pmbb_m.pmbb037_desc
            DISPLAY BY NAME g_pmbb_m.pmbb037_desc

            NEXT FIELD pmbb037                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmbb055
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb055
            #add-point:ON ACTION controlp INFIELD pmbb055 name="input.c.pmbb055"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmbb_m.pmbb055             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "3211"   #170213-00038#2  mark
 
            #CALL q_oocq002()                                #呼叫開窗  #170213-00038#2 mark
            CALL q_oocq002_3211()  #170213-00038#2   add

            LET g_pmbb_m.pmbb055 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmbb_m.pmbb055 TO pmbb055              #顯示到畫面上
            CALL apmt101_pmbb055_ref(g_pmbb_m.pmbb055) RETURNING g_pmbb_m.pmbb055_desc
            DISPLAY BY NAME g_pmbb_m.pmbb055_desc

            NEXT FIELD pmbb055                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmbb038
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb038
            #add-point:ON ACTION controlp INFIELD pmbb038 name="input.c.pmbb038"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmbb_m.pmbb038             #給予default值

            #給予arg
            #160621-00003#3 20160627 modify by beckxie---S
			   #LET g_qryparam.arg1 = "275"
            #CALL q_oocq002()                           #呼叫開窗
            LET g_qryparam.arg1 = '2'
            CALL q_oojd001_1()
            #160621-00003#3 20160627 modify by beckxie---E

            LET g_pmbb_m.pmbb038 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmbb_m.pmbb038 TO pmbb038              #顯示到畫面上
            CALL apmt101_pmbb088_ref(g_pmbb_m.pmbb038) RETURNING g_pmbb_m.pmbb038_desc
            DISPLAY BY NAME g_pmbb_m.pmbb038_desc
            NEXT FIELD pmbb038                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmbb039
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb039
            #add-point:ON ACTION controlp INFIELD pmbb039 name="input.c.pmbb039"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmbb_m.pmbb039             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "264"   #170213-00038#2 mark

            #CALL q_oocq002()                                #呼叫開窗  #170213-00038#2 mark
            CALL q_oocq002_264()  #170213-00038#2   add

            LET g_pmbb_m.pmbb039 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmbb_m.pmbb039 TO pmbb039              #顯示到畫面上
            CALL apmt101_pmbb039_ref(g_pmbb_m.pmbb039) RETURNING g_pmbb_m.pmbb039_desc
            DISPLAY BY NAME g_pmbb_m.pmbb039_desc

            NEXT FIELD pmbb039                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmbb057
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb057
            #add-point:ON ACTION controlp INFIELD pmbb057 name="input.c.pmbb057"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmbb058
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb058
            #add-point:ON ACTION controlp INFIELD pmbb058 name="input.c.pmbb058"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmbb040
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb040
            #add-point:ON ACTION controlp INFIELD pmbb040 name="input.c.pmbb040"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmbb_m.pmbb040             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "263"   #170213-00038#2 mark

            #CALL q_oocq002()                                #呼叫開窗  #170213-00038#2 mark
            CALL q_oocq002_263()  #170213-00038#2   add

            LET g_pmbb_m.pmbb040 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmbb_m.pmbb040 TO pmbb040              #顯示到畫面上
            CALL apmt101_pmbb090_ref(g_pmbb_m.pmbb040) RETURNING g_pmbb_m.pmbb040_desc
            DISPLAY BY NAME g_pmbb_m.pmbb040_desc

            NEXT FIELD pmbb040                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmbb041
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb041
            #add-point:ON ACTION controlp INFIELD pmbb041 name="input.c.pmbb041"
#此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmbb_m.pmbb041             #給予default值

            CALL apmt101_get_oocq019(g_pmbb_m.pmbb040) RETURNING l_oocq019  #運輸類型
            IF NOT cl_null(l_oocq019) THEN
               CASE
                  WHEN l_oocq019 ='1' OR l_oocq019='4'
                     LET g_qryparam.arg1 = "315"
                     CALL q_oocq002()
                  WHEN l_oocq019 ='2'
                     CALL q_oocq002_10()
                  WHEN l_oocq019 ='3'
                     CALL q_oocq002_12()
                  OTHERWISE EXIT CASE
               END CASE
            END IF  

            LET g_pmbb_m.pmbb041 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmbb_m.pmbb041 TO pmbb041              #顯示到畫面上
            CALL s_apmi011_location_ref(g_pmbb_m.pmbb040,g_pmbb_m.pmbb041) RETURNING g_pmbb_m.pmbb041_desc
            DISPLAY BY NAME g_pmbb_m.pmbb041_desc

            NEXT FIELD pmbb041                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmbb042
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb042
            #add-point:ON ACTION controlp INFIELD pmbb042 name="input.c.pmbb042"
#此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmbb_m.pmbb042             #給予default值

            CALL apmt101_get_oocq019(g_pmbb_m.pmbb040) RETURNING l_oocq019  #運輸類型
            IF NOT cl_null(l_oocq019) THEN
               CASE
                  WHEN l_oocq019 ='1' OR l_oocq019='4'
                     LET g_qryparam.arg1 = "315"
                     CALL q_oocq002()
                  WHEN l_oocq019 ='2'
                     CALL q_oocq002_10()
                  WHEN l_oocq019 ='3'
                     CALL q_oocq002_12()
                  OTHERWISE EXIT CASE
               END CASE
            END IF  

            LET g_pmbb_m.pmbb042 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmbb_m.pmbb042 TO pmbb042              #顯示到畫面上
            CALL s_apmi011_location_ref(g_pmbb_m.pmbb040,g_pmbb_m.pmbb042) RETURNING g_pmbb_m.pmbb042_desc
            DISPLAY BY NAME g_pmbb_m.pmbb042_desc

            NEXT FIELD pmbb042                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmbb043
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb043
            #add-point:ON ACTION controlp INFIELD pmbb043 name="input.c.pmbb043"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmbb_m.pmbb043             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "262"   #170213-00038#2 mark

            #CALL q_oocq002()                                #呼叫開窗  #170213-00038#2 mark
            CALL q_oocq002_262()  #170213-00038#2   add

            LET g_pmbb_m.pmbb043 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmbb_m.pmbb043 TO pmbb043              #顯示到畫面上
            CALL apmt101_pmbb091_ref(g_pmbb_m.pmbb043) RETURNING g_pmbb_m.pmbb043_desc
            DISPLAY BY NAME g_pmbb_m.pmbb043_desc

            NEXT FIELD pmbb043                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmbb044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb044
            #add-point:ON ACTION controlp INFIELD pmbb044 name="input.c.pmbb044"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmbb045
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb045
            #add-point:ON ACTION controlp INFIELD pmbb045 name="input.c.pmbb045"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmbb046
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb046
            #add-point:ON ACTION controlp INFIELD pmbb046 name="input.c.pmbb046"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmbb047
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb047
            #add-point:ON ACTION controlp INFIELD pmbb047 name="input.c.pmbb047"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.where = " (pmaa002 = '1' OR pmaa002 = '3') "

            LET g_qryparam.default1 = g_pmbb_m.pmbb047             #給予default值

            #給予arg

            CALL q_pmaa001_4()                                #呼叫開窗

            LET g_pmbb_m.pmbb047 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmbb_m.pmbb047 TO pmbb047              #顯示到畫面上
            CALL apmt101_pmbb003_ref(g_pmbb_m.pmbb047) RETURNING g_pmbb_m.pmbb047_desc
            DISPLAY BY NAME g_pmbb_m.pmbb047_desc

            NEXT FIELD pmbb047                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmbb048
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb048
            #add-point:ON ACTION controlp INFIELD pmbb048 name="input.c.pmbb048"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmbb049
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb049
            #add-point:ON ACTION controlp INFIELD pmbb049 name="input.c.pmbb049"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmbb050
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb050
            #add-point:ON ACTION controlp INFIELD pmbb050 name="input.c.pmbb050"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmbb051
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb051
            #add-point:ON ACTION controlp INFIELD pmbb051 name="input.c.pmbb051"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmbb052
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb052
            #add-point:ON ACTION controlp INFIELD pmbb052 name="input.c.pmbb052"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmbb071
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb071
            #add-point:ON ACTION controlp INFIELD pmbb071 name="input.c.pmbb071"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmbb072
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb072
            #add-point:ON ACTION controlp INFIELD pmbb072 name="input.c.pmbb072"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmbb073
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb073
            #add-point:ON ACTION controlp INFIELD pmbb073 name="input.c.pmbb073"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmbb060
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb060
            #add-point:ON ACTION controlp INFIELD pmbb060 name="input.c.pmbb060"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmbb061
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb061
            #add-point:ON ACTION controlp INFIELD pmbb061 name="input.c.pmbb061"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmbb066
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb066
            #add-point:ON ACTION controlp INFIELD pmbb066 name="input.c.pmbb066"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmbb062
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb062
            #add-point:ON ACTION controlp INFIELD pmbb062 name="input.c.pmbb062"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmbb067
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb067
            #add-point:ON ACTION controlp INFIELD pmbb067 name="input.c.pmbb067"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmbb063
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb063
            #add-point:ON ACTION controlp INFIELD pmbb063 name="input.c.pmbb063"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmbb068
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb068
            #add-point:ON ACTION controlp INFIELD pmbb068 name="input.c.pmbb068"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmbb064
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb064
            #add-point:ON ACTION controlp INFIELD pmbb064 name="input.c.pmbb064"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmbb069
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb069
            #add-point:ON ACTION controlp INFIELD pmbb069 name="input.c.pmbb069"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmbb065
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb065
            #add-point:ON ACTION controlp INFIELD pmbb065 name="input.c.pmbb065"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmbb070
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb070
            #add-point:ON ACTION controlp INFIELD pmbb070 name="input.c.pmbb070"
            
            #END add-point
 
 
         #Ctrlp:input.c.total
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD total
            #add-point:ON ACTION controlp INFIELD total name="input.c.total"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmbb002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb002
            #add-point:ON ACTION controlp INFIELD pmbb002 name="input.c.pmbb002"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmbb003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb003
            #add-point:ON ACTION controlp INFIELD pmbb003 name="input.c.pmbb003"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmbb_m.pmbb003             #給予default值

            #給予arg

            CALL q_pmaa001_4()                                #呼叫開窗

            LET g_pmbb_m.pmbb003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmbb_m.pmbb003 TO pmbb003              #顯示到畫面上
            CALL apmt101_pmbb003_ref(g_pmbb_m.pmbb003) RETURNING g_pmbb_m.pmbb003_desc
            DISPLAY BY NAME g_pmbb_m.pmbb003_desc

            NEXT FIELD pmbb003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmbb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb004
            #add-point:ON ACTION controlp INFIELD pmbb004 name="input.c.pmbb004"
            #ming 20140817 add ----------------------------------------------(S) 
            #信用評等的開窗與校驗都從xmaa_t改成xmaj_t 
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmbb_m.pmbb004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #


            CALL q_xmaj001()                                #呼叫開窗

            LET g_pmbb_m.pmbb004 = g_qryparam.return1

            DISPLAY g_pmbb_m.pmbb004 TO pmbb004              #
            CALL apmt101_pmbb004_ref(g_pmbb_m.pmbb004) RETURNING g_pmbb_m.pmbb004_desc
            DISPLAY BY NAME g_pmbb_m.pmbb004_desc

            NEXT FIELD pmbb004                          #返回原欄位

            #ming 20140817 add ----------------------------------------------(E) 

            #END add-point
 
 
         #Ctrlp:input.c.pmbb005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb005
            #add-point:ON ACTION controlp INFIELD pmbb005 name="input.c.pmbb005"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmbb_m.pmbb005             #給予default值

            #給予arg

            IF g_site = 'ALL' THEN
               LET g_qryparam.arg1 = g_site_t
            ELSE
               LET g_qryparam.arg1 = g_site
            END IF
            
            CALL q_ooaj002_1()                           #呼叫開窗

            LET g_pmbb_m.pmbb005 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmbb_m.pmbb005 TO pmbb005              #顯示到畫面上
            CALL apmt101_pmbb083_ref(g_pmbb_m.pmbb005) RETURNING g_pmbb_m.pmbb005_desc
            DISPLAY BY NAME g_pmbb_m.pmbb005_desc

            NEXT FIELD pmbb005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmbb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb006
            #add-point:ON ACTION controlp INFIELD pmbb006 name="input.c.pmbb006"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmbb007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb007
            #add-point:ON ACTION controlp INFIELD pmbb007 name="input.c.pmbb007"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmbb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb008
            #add-point:ON ACTION controlp INFIELD pmbb008 name="input.c.pmbb008"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmbb009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb009
            #add-point:ON ACTION controlp INFIELD pmbb009 name="input.c.pmbb009"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmbb019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb019
            #add-point:ON ACTION controlp INFIELD pmbb019 name="input.c.pmbb019"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmbb010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb010
            #add-point:ON ACTION controlp INFIELD pmbb010 name="input.c.pmbb010"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmbb020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb020
            #add-point:ON ACTION controlp INFIELD pmbb020 name="input.c.pmbb020"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmbb011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb011
            #add-point:ON ACTION controlp INFIELD pmbb011 name="input.c.pmbb011"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmbb012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb012
            #add-point:ON ACTION controlp INFIELD pmbb012 name="input.c.pmbb012"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmbb013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb013
            #add-point:ON ACTION controlp INFIELD pmbb013 name="input.c.pmbb013"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmbb014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb014
            #add-point:ON ACTION controlp INFIELD pmbb014 name="input.c.pmbb014"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmbb015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb015
            #add-point:ON ACTION controlp INFIELD pmbb015 name="input.c.pmbb015"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmbb016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb016
            #add-point:ON ACTION controlp INFIELD pmbb016 name="input.c.pmbb016"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmbb017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb017
            #add-point:ON ACTION controlp INFIELD pmbb017 name="input.c.pmbb017"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmbb018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbb018
            #add-point:ON ACTION controlp INFIELD pmbb018 name="input.c.pmbb018"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooff013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooff013
            #add-point:ON ACTION controlp INFIELD ooff013 name="input.c.ooff013"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #若點選cancel則離開dialog
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
            
            #錯誤訊息統整顯示
            #CALL cl_err_collect_show()
            #CALL cl_showmsg()
  
            IF p_cmd <> "u" THEN
               #當p_cmd不為u代表為新增/複製
               LET l_count = 1  
 
               #確定新增的資料不存在(不重複)
               SELECT COUNT(1) INTO l_count FROM pmbb_t
                WHERE pmbbent = g_enterprise AND pmbbsite = g_site AND pmbbdocno = g_pmbb_m.pmbbdocno
 
               IF l_count = 0 THEN
               
                  #add-point:單頭新增前 name="input.head.b_insert"
                  
                  #end add-point
               
                  #將新增的單頭資料寫入資料庫
                  INSERT INTO pmbb_t (pmbbent, pmbbsite,pmbbdocno,pmbb001,pmbb080,pmbb081,pmbb109,pmbb082, 
                      pmbb083,pmbb084,pmbb103,pmbb104,pmbb085,pmbb086,pmbb106,pmbb087,pmbb105,pmbb088, 
                      pmbb089,pmbb107,pmbb108,pmbb090,pmbb091,pmbb092,pmbb093,pmbb094,pmbb095,pmbb096, 
                      pmbb097,pmbb098,pmbb099,pmbb100,pmbb101,pmbb102,pmbb030,pmbb031,pmbb059,pmbb032, 
                      pmbb033,pmbb034,pmbb053,pmbb054,pmbb035,pmbb036,pmbb056,pmbb037,pmbb055,pmbb038, 
                      pmbb039,pmbb057,pmbb058,pmbb040,pmbb041,pmbb042,pmbb043,pmbb044,pmbb045,pmbb046, 
                      pmbb047,pmbb048,pmbb049,pmbb050,pmbb051,pmbb052,pmbb071,pmbb072,pmbb073,pmbb060, 
                      pmbb061,pmbb066,pmbb062,pmbb067,pmbb063,pmbb068,pmbb064,pmbb069,pmbb065,pmbb070, 
                      pmbb002,pmbb003,pmbb004,pmbb005,pmbb006,pmbb007,pmbb008,pmbb009,pmbb019,pmbb010, 
                      pmbb020,pmbb011,pmbb012,pmbb013,pmbb014,pmbb015,pmbb016,pmbb017,pmbb018,pmbbownid, 
                      pmbbowndp,pmbbcrtid,pmbbcrtdp,pmbbcrtdt,pmbbmodid,pmbbmoddt)
                  VALUES (g_enterprise, g_site,g_pmbb_m.pmbbdocno,g_pmbb_m.pmbb001,g_pmbb_m.pmbb080, 
                      g_pmbb_m.pmbb081,g_pmbb_m.pmbb109,g_pmbb_m.pmbb082,g_pmbb_m.pmbb083,g_pmbb_m.pmbb084, 
                      g_pmbb_m.pmbb103,g_pmbb_m.pmbb104,g_pmbb_m.pmbb085,g_pmbb_m.pmbb086,g_pmbb_m.pmbb106, 
                      g_pmbb_m.pmbb087,g_pmbb_m.pmbb105,g_pmbb_m.pmbb088,g_pmbb_m.pmbb089,g_pmbb_m.pmbb107, 
                      g_pmbb_m.pmbb108,g_pmbb_m.pmbb090,g_pmbb_m.pmbb091,g_pmbb_m.pmbb092,g_pmbb_m.pmbb093, 
                      g_pmbb_m.pmbb094,g_pmbb_m.pmbb095,g_pmbb_m.pmbb096,g_pmbb_m.pmbb097,g_pmbb_m.pmbb098, 
                      g_pmbb_m.pmbb099,g_pmbb_m.pmbb100,g_pmbb_m.pmbb101,g_pmbb_m.pmbb102,g_pmbb_m.pmbb030, 
                      g_pmbb_m.pmbb031,g_pmbb_m.pmbb059,g_pmbb_m.pmbb032,g_pmbb_m.pmbb033,g_pmbb_m.pmbb034, 
                      g_pmbb_m.pmbb053,g_pmbb_m.pmbb054,g_pmbb_m.pmbb035,g_pmbb_m.pmbb036,g_pmbb_m.pmbb056, 
                      g_pmbb_m.pmbb037,g_pmbb_m.pmbb055,g_pmbb_m.pmbb038,g_pmbb_m.pmbb039,g_pmbb_m.pmbb057, 
                      g_pmbb_m.pmbb058,g_pmbb_m.pmbb040,g_pmbb_m.pmbb041,g_pmbb_m.pmbb042,g_pmbb_m.pmbb043, 
                      g_pmbb_m.pmbb044,g_pmbb_m.pmbb045,g_pmbb_m.pmbb046,g_pmbb_m.pmbb047,g_pmbb_m.pmbb048, 
                      g_pmbb_m.pmbb049,g_pmbb_m.pmbb050,g_pmbb_m.pmbb051,g_pmbb_m.pmbb052,g_pmbb_m.pmbb071, 
                      g_pmbb_m.pmbb072,g_pmbb_m.pmbb073,g_pmbb_m.pmbb060,g_pmbb_m.pmbb061,g_pmbb_m.pmbb066, 
                      g_pmbb_m.pmbb062,g_pmbb_m.pmbb067,g_pmbb_m.pmbb063,g_pmbb_m.pmbb068,g_pmbb_m.pmbb064, 
                      g_pmbb_m.pmbb069,g_pmbb_m.pmbb065,g_pmbb_m.pmbb070,g_pmbb_m.pmbb002,g_pmbb_m.pmbb003, 
                      g_pmbb_m.pmbb004,g_pmbb_m.pmbb005,g_pmbb_m.pmbb006,g_pmbb_m.pmbb007,g_pmbb_m.pmbb008, 
                      g_pmbb_m.pmbb009,g_pmbb_m.pmbb019,g_pmbb_m.pmbb010,g_pmbb_m.pmbb020,g_pmbb_m.pmbb011, 
                      g_pmbb_m.pmbb012,g_pmbb_m.pmbb013,g_pmbb_m.pmbb014,g_pmbb_m.pmbb015,g_pmbb_m.pmbb016, 
                      g_pmbb_m.pmbb017,g_pmbb_m.pmbb018,g_pmbb_m.pmbbownid,g_pmbb_m.pmbbowndp,g_pmbb_m.pmbbcrtid, 
                      g_pmbb_m.pmbbcrtdp,g_pmbb_m.pmbbcrtdt,g_pmbb_m.pmbbmodid,g_pmbb_m.pmbbmoddt) 
                  
                  #add-point:單頭新增中 name="input.head.m_insert"
                  
                  #end add-point
                  
                  #若寫入錯誤則提示錯誤訊息並返回輸入頁面
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pmbb_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
                  
                  
                  
                  #資料多語言用-增/改
                  
                  
                  #add-point:單頭新增後 name="input.head.a_insert"
                  #傳入參數，直接進入的新增狀態，新增完成後，顯示主畫面
                  #由apmt100串apmt101新增完成時請自動複製一筆當下g_site的據點資料
                  IF g_flag1 THEN
                     LET l_count = 1  
 
                     SELECT COUNT(*) INTO l_count FROM pmbb_t
                      WHERE pmbbent = g_enterprise AND pmbbsite = g_site_t #AND pmbb001 = g_pmbb_m.pmbb001
      
                     IF l_count = 0 THEN
  
                        INSERT INTO pmbb_t (pmbbent, pmbbsite,pmbbdocno,pmbb001,pmbb080,pmbb081,pmbb082,pmbb083,pmbb084,pmbb103,pmbb104,
                                            pmbb085,pmbb086,pmbb087,pmbb105,pmbb088,pmbb089,pmbb090,pmbb091,pmbb092,pmbb093,pmbb094,
                                            pmbb095,pmbb096,pmbb097,pmbb098,pmbb099,pmbb100,pmbb101,pmbb102,pmbb030,pmbb031,pmbb032,
                                            pmbb033,pmbb034,pmbb053,pmbb054,pmbb035,pmbb036,pmbb037,pmbb055,pmbb038,pmbb039,pmbb040,
                                            pmbb041,pmbb042,pmbb043,pmbb044,pmbb045,pmbb046,pmbb047,pmbb048,pmbb049,pmbb050,pmbb051,
                                            pmbb052,pmbb071,pmbb072,pmbb073,pmbb060,pmbb061,pmbb066,pmbb062,pmbb067,pmbb063,pmbb068,
                                            pmbb064,pmbb069,pmbb065,pmbb070,pmbb002,pmbb003,pmbb004,pmbb005,pmbb006,pmbb007,pmbb008,
                                            pmbb009,pmbb019,pmbb010,pmbb020,pmbb011,pmbb012,pmbb013,pmbb014,pmbb015,pmbb016,pmbb017,pmbb018,pmbb056,
                                            pmbb057,pmbb058,pmbb106,pmbb107,pmbb108,pmbbownid,pmbbowndp,pmbbcrtid,pmbbcrtdp,pmbbcrtdt,
                                            pmbbmodid,pmbbmoddt)
                         VALUES (g_enterprise, g_site_t,g_pmbb_m.pmbbdocno,g_pmbb_m.pmbb001,g_pmbb_m.pmbb080,g_pmbb_m.pmbb081,
                                 g_pmbb_m.pmbb082,g_pmbb_m.pmbb083,g_pmbb_m.pmbb084,g_pmbb_m.pmbb103,g_pmbb_m.pmbb104,g_pmbb_m.pmbb085,
                                 g_pmbb_m.pmbb086,g_pmbb_m.pmbb087,g_pmbb_m.pmbb105,g_pmbb_m.pmbb088,g_pmbb_m.pmbb089,g_pmbb_m.pmbb090,
                                 g_pmbb_m.pmbb091,g_pmbb_m.pmbb092,g_pmbb_m.pmbb093,g_pmbb_m.pmbb094,g_pmbb_m.pmbb095,g_pmbb_m.pmbb096,
                                 g_pmbb_m.pmbb097,g_pmbb_m.pmbb098,g_pmbb_m.pmbb099,g_pmbb_m.pmbb100,g_pmbb_m.pmbb101,g_pmbb_m.pmbb102,
                                 g_pmbb_m.pmbb030,g_pmbb_m.pmbb031,g_pmbb_m.pmbb032,g_pmbb_m.pmbb033,g_pmbb_m.pmbb034,g_pmbb_m.pmbb053,
                                 g_pmbb_m.pmbb054,g_pmbb_m.pmbb035,g_pmbb_m.pmbb036,g_pmbb_m.pmbb037,g_pmbb_m.pmbb055,g_pmbb_m.pmbb038,
                                 g_pmbb_m.pmbb039,g_pmbb_m.pmbb040,g_pmbb_m.pmbb041,g_pmbb_m.pmbb042,g_pmbb_m.pmbb043,g_pmbb_m.pmbb044,
                                 g_pmbb_m.pmbb045,g_pmbb_m.pmbb046,g_pmbb_m.pmbb047,g_pmbb_m.pmbb048,g_pmbb_m.pmbb049,g_pmbb_m.pmbb050,
                                 g_pmbb_m.pmbb051,g_pmbb_m.pmbb052,g_pmbb_m.pmbb071,g_pmbb_m.pmbb072,g_pmbb_m.pmbb073,g_pmbb_m.pmbb060,
                                 g_pmbb_m.pmbb061,g_pmbb_m.pmbb066,g_pmbb_m.pmbb062,g_pmbb_m.pmbb067,g_pmbb_m.pmbb063,g_pmbb_m.pmbb068,
                                 g_pmbb_m.pmbb064,g_pmbb_m.pmbb069,g_pmbb_m.pmbb065,g_pmbb_m.pmbb070,g_pmbb_m.pmbb002,g_pmbb_m.pmbb003,
                                 g_pmbb_m.pmbb004,g_pmbb_m.pmbb005,g_pmbb_m.pmbb006,g_pmbb_m.pmbb007,g_pmbb_m.pmbb008,g_pmbb_m.pmbb009,g_pmbb_m.pmbb019,
                                 g_pmbb_m.pmbb010,g_pmbb_m.pmbb020,g_pmbb_m.pmbb011,g_pmbb_m.pmbb012,g_pmbb_m.pmbb013,g_pmbb_m.pmbb014,g_pmbb_m.pmbb015,
                                 g_pmbb_m.pmbb016,g_pmbb_m.pmbb017,g_pmbb_m.pmbb018,g_pmbb_m.pmbb056,g_pmbb_m.pmbb057,g_pmbb_m.pmbb058,
                                 g_pmbb_m.pmbb106,g_pmbb_m.pmbb107,g_pmbb_m.pmbb108,g_pmbb_m.pmbbownid,g_pmbb_m.pmbbowndp,
                                 g_pmbb_m.pmbbcrtid,g_pmbb_m.pmbbcrtdp,g_pmbb_m.pmbbcrtdt,g_pmbb_m.pmbbmodid,g_pmbb_m.pmbbmoddt) # DISK WRITE

                        IF SQLCA.sqlcode THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = SQLCA.sqlcode
                           LET g_errparam.extend = "pmbb_t"
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
  
                           CONTINUE DIALOG
                        END IF
                     END IF
                  END IF
                  
                  IF NOT cl_null(g_pmbb_m.ooff013) THEN
                     LET l_success = ''
                     CALL s_aooi360_gen('2',g_pmbb_m.pmbbdocno,g_site,'','','','','','','','','4',g_pmbb_m.ooff013) RETURNING l_success
                     IF NOT l_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "ooff_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        CONTINUE DIALOG
                     END IF
                  ELSE
                     CALL s_aooi360_del('2',g_pmbb_m.pmbbdocno,g_site,'','','','','','','','','4') RETURNING l_success
                     IF NOT l_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "ooff_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        CONTINUE DIALOG
                     END IF
                  END IF
                  #end add-point
                  
                  CALL s_transaction_end('Y','0')
               ELSE
                  CALL s_transaction_end('N','0')
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_pmbb_m.pmbbdocno
                  LET g_errparam.code   = "std-00006" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
               END IF 
            ELSE
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL apmt101_pmbb_t_mask_restore('restore_mask_o')
               
               UPDATE pmbb_t SET (pmbbdocno,pmbb001,pmbb080,pmbb081,pmbb109,pmbb082,pmbb083,pmbb084, 
                   pmbb103,pmbb104,pmbb085,pmbb086,pmbb106,pmbb087,pmbb105,pmbb088,pmbb089,pmbb107,pmbb108, 
                   pmbb090,pmbb091,pmbb092,pmbb093,pmbb094,pmbb095,pmbb096,pmbb097,pmbb098,pmbb099,pmbb100, 
                   pmbb101,pmbb102,pmbb030,pmbb031,pmbb059,pmbb032,pmbb033,pmbb034,pmbb053,pmbb054,pmbb035, 
                   pmbb036,pmbb056,pmbb037,pmbb055,pmbb038,pmbb039,pmbb057,pmbb058,pmbb040,pmbb041,pmbb042, 
                   pmbb043,pmbb044,pmbb045,pmbb046,pmbb047,pmbb048,pmbb049,pmbb050,pmbb051,pmbb052,pmbb071, 
                   pmbb072,pmbb073,pmbb060,pmbb061,pmbb066,pmbb062,pmbb067,pmbb063,pmbb068,pmbb064,pmbb069, 
                   pmbb065,pmbb070,pmbb002,pmbb003,pmbb004,pmbb005,pmbb006,pmbb007,pmbb008,pmbb009,pmbb019, 
                   pmbb010,pmbb020,pmbb011,pmbb012,pmbb013,pmbb014,pmbb015,pmbb016,pmbb017,pmbb018,pmbbownid, 
                   pmbbowndp,pmbbcrtid,pmbbcrtdp,pmbbcrtdt,pmbbmodid,pmbbmoddt) = (g_pmbb_m.pmbbdocno, 
                   g_pmbb_m.pmbb001,g_pmbb_m.pmbb080,g_pmbb_m.pmbb081,g_pmbb_m.pmbb109,g_pmbb_m.pmbb082, 
                   g_pmbb_m.pmbb083,g_pmbb_m.pmbb084,g_pmbb_m.pmbb103,g_pmbb_m.pmbb104,g_pmbb_m.pmbb085, 
                   g_pmbb_m.pmbb086,g_pmbb_m.pmbb106,g_pmbb_m.pmbb087,g_pmbb_m.pmbb105,g_pmbb_m.pmbb088, 
                   g_pmbb_m.pmbb089,g_pmbb_m.pmbb107,g_pmbb_m.pmbb108,g_pmbb_m.pmbb090,g_pmbb_m.pmbb091, 
                   g_pmbb_m.pmbb092,g_pmbb_m.pmbb093,g_pmbb_m.pmbb094,g_pmbb_m.pmbb095,g_pmbb_m.pmbb096, 
                   g_pmbb_m.pmbb097,g_pmbb_m.pmbb098,g_pmbb_m.pmbb099,g_pmbb_m.pmbb100,g_pmbb_m.pmbb101, 
                   g_pmbb_m.pmbb102,g_pmbb_m.pmbb030,g_pmbb_m.pmbb031,g_pmbb_m.pmbb059,g_pmbb_m.pmbb032, 
                   g_pmbb_m.pmbb033,g_pmbb_m.pmbb034,g_pmbb_m.pmbb053,g_pmbb_m.pmbb054,g_pmbb_m.pmbb035, 
                   g_pmbb_m.pmbb036,g_pmbb_m.pmbb056,g_pmbb_m.pmbb037,g_pmbb_m.pmbb055,g_pmbb_m.pmbb038, 
                   g_pmbb_m.pmbb039,g_pmbb_m.pmbb057,g_pmbb_m.pmbb058,g_pmbb_m.pmbb040,g_pmbb_m.pmbb041, 
                   g_pmbb_m.pmbb042,g_pmbb_m.pmbb043,g_pmbb_m.pmbb044,g_pmbb_m.pmbb045,g_pmbb_m.pmbb046, 
                   g_pmbb_m.pmbb047,g_pmbb_m.pmbb048,g_pmbb_m.pmbb049,g_pmbb_m.pmbb050,g_pmbb_m.pmbb051, 
                   g_pmbb_m.pmbb052,g_pmbb_m.pmbb071,g_pmbb_m.pmbb072,g_pmbb_m.pmbb073,g_pmbb_m.pmbb060, 
                   g_pmbb_m.pmbb061,g_pmbb_m.pmbb066,g_pmbb_m.pmbb062,g_pmbb_m.pmbb067,g_pmbb_m.pmbb063, 
                   g_pmbb_m.pmbb068,g_pmbb_m.pmbb064,g_pmbb_m.pmbb069,g_pmbb_m.pmbb065,g_pmbb_m.pmbb070, 
                   g_pmbb_m.pmbb002,g_pmbb_m.pmbb003,g_pmbb_m.pmbb004,g_pmbb_m.pmbb005,g_pmbb_m.pmbb006, 
                   g_pmbb_m.pmbb007,g_pmbb_m.pmbb008,g_pmbb_m.pmbb009,g_pmbb_m.pmbb019,g_pmbb_m.pmbb010, 
                   g_pmbb_m.pmbb020,g_pmbb_m.pmbb011,g_pmbb_m.pmbb012,g_pmbb_m.pmbb013,g_pmbb_m.pmbb014, 
                   g_pmbb_m.pmbb015,g_pmbb_m.pmbb016,g_pmbb_m.pmbb017,g_pmbb_m.pmbb018,g_pmbb_m.pmbbownid, 
                   g_pmbb_m.pmbbowndp,g_pmbb_m.pmbbcrtid,g_pmbb_m.pmbbcrtdp,g_pmbb_m.pmbbcrtdt,g_pmbb_m.pmbbmodid, 
                   g_pmbb_m.pmbbmoddt)
                WHERE pmbbent = g_enterprise AND pmbbsite = g_site AND pmbbdocno = g_pmbbdocno_t #
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pmbb_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pmbb_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  OTHERWISE
                     
                     #資料多語言用-增/改
                     
                     
                     #將遮罩欄位進行遮蔽
                     CALL apmt101_pmbb_t_mask_restore('restore_mask_n')
                     
                     #add-point:單頭修改後 name="input.head.a_update"
                  IF NOT cl_null(g_pmbb_m.ooff013) THEN
                     LET l_success = ''
                     CALL s_aooi360_gen('2',g_pmbb_m.pmbbdocno,g_site,'','','','','','','','','4',g_pmbb_m.ooff013) RETURNING l_success
                     IF NOT l_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "ooff_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        CONTINUE DIALOG
                     END IF
                  ELSE
                     CALL s_aooi360_del('2',g_pmbb_m.pmbbdocno,g_site,'','','','','','','','','4') RETURNING l_success
                     IF NOT l_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "ooff_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        CONTINUE DIALOG
                     END IF
                  END IF
                     #end add-point
                     #修改歷程記錄(單頭修改)
                     LET g_log1 = util.JSON.stringify(g_pmbb_m_t)
                     LET g_log2 = util.JSON.stringify(g_pmbb_m)
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     ELSE
                        CALL s_transaction_end('Y','0')
                     END IF
               END CASE
               
            END IF
           #controlp
      END INPUT
      
      #add-point:input段more input  name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG
         #CALL cl_err_collect_init()
         #add-point:input段before_dialog  name="input.before_dialog"
         
         #end add-point
          
      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name, g_fld_name, g_lang)
 
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
         ACCEPT DIALOG
         
      #放棄輸入
      ON ACTION cancel
         LET g_action_choice=""
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      #在dialog 右上角 (X)
      ON ACTION close 
         LET INT_FLAG = TRUE 
         EXIT DIALOG
    
      #toolbar 離開
      ON ACTION exit
         LET INT_FLAG = TRUE 
         EXIT DIALOG
   
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
   
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="apmt101.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION apmt101_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE pmbb_t.pmbbdocno 
   DEFINE l_oldno     LIKE pmbb_t.pmbbdocno 
 
   DEFINE l_master    RECORD LIKE pmbb_t.* #此變數樣板目前無使用
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
   
   #先確定key值無遺漏
   IF g_pmbb_m.pmbbdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   #備份key值
   LET g_pmbbdocno_t = g_pmbb_m.pmbbdocno
 
   
   #清空key值
   LET g_pmbb_m.pmbbdocno = ""
 
    
   CALL apmt101_set_entry("a")
   CALL apmt101_set_no_entry("a")
   
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_pmbb_m.pmbbownid = g_user
      LET g_pmbb_m.pmbbowndp = g_dept
      LET g_pmbb_m.pmbbcrtid = g_user
      LET g_pmbb_m.pmbbcrtdp = g_dept 
      LET g_pmbb_m.pmbbcrtdt = cl_get_current()
      LET g_pmbb_m.pmbbmodid = g_user
      LET g_pmbb_m.pmbbmoddt = cl_get_current()
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
   
   
   #清空key欄位的desc
      LET g_pmbb_m.pmbbdocno_desc = ''
   DISPLAY BY NAME g_pmbb_m.pmbbdocno_desc
 
   
   #資料輸入
   CALL apmt101_input("r")
   
   IF INT_FLAG THEN
      #取消
      INITIALIZE g_pmbb_m.* TO NULL
      CALL apmt101_show()
      CALL s_transaction_end('N','0')
      LET INT_FLAG = 0
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = 9001 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   CALL s_transaction_begin()
   
   #add-point:單頭複製前 name="reproduce.head.b_insert"
   
   #end add-point
   
   #add-point:單頭複製中 name="reproduce.head.m_insert"
   
   #end add-point
   
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "pmbb_t:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單頭複製後 name="reproduce.head.a_insert"
   
   #end add-point
   
   CALL s_transaction_end('Y','0')
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL apmt101_set_act_visible()
   CALL apmt101_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_pmbbdocno_t = g_pmbb_m.pmbbdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " pmbbent = " ||g_enterprise|| " AND pmbbsite = '" ||g_site|| "' AND",
                      " pmbbdocno = '", g_pmbb_m.pmbbdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL apmt101_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
              
   LET g_data_owner = g_pmbb_m.pmbbownid      
   LET g_data_dept  = g_pmbb_m.pmbbowndp
              
   #功能已完成,通報訊息中心
   CALL apmt101_msgcentre_notify('reproduce')
                 
END FUNCTION
 
{</section>}
 
{<section id="apmt101.show" >}
#+ 資料顯示 
PRIVATE FUNCTION apmt101_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:show段Function前置處理  name="show.before"
   DEFINE  l_success       LIKE type_t.num5
   #end add-point
   
   
   
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
    
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL apmt101_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
            CALL apmt101_pmbbdocno_desc(g_pmbb_m.pmbbdocno) RETURNING g_pmbb_m.pmbbdocno_desc
            DISPLAY BY NAME g_pmbb_m.pmbbdocno_desc

            CALL apmt101_pmbbdocno_ref(g_pmbb_m.pmbbdocno) 
               RETURNING g_pmbb_m.pmbb001,g_pmbb_m.pmbal003,g_pmbb_m.pmba002,g_pmbb_m.pmba003,g_pmbb_m.status1
            DISPLAY BY NAME g_pmbb_m.pmbb001,g_pmbb_m.pmbal003,g_pmbb_m.pmba002,g_pmbb_m.pmba003,g_pmbb_m.status1
            
            #CALL apmt101_pmbb081_ref(g_pmbb_m.pmbb081) RETURNING g_pmbb_m.pmbb081_desc
            #DISPLAY BY NAME g_pmbb_m.pmbb081_desc 
            #
            #CALL apmt101_pmbb083_ref(g_pmbb_m.pmbb083) RETURNING g_pmbb_m.pmbb083_desc
            #DISPLAY BY NAME g_pmbb_m.pmbb083_desc
            
            CALL apmt101_pmbb084_ref(g_pmbb_m.pmbb084) RETURNING g_pmbb_m.pmbb084_desc
            DISPLAY BY NAME g_pmbb_m.pmbb084_desc
            
            #CALL apmt101_pmbb103_ref(g_pmbb_m.pmbb103) RETURNING g_pmbb_m.pmbb103_desc
            #DISPLAY BY NAME g_pmbb_m.pmbb103_desc
            #
            #CALL apmt101_pmbb104_ref(g_pmbb_m.pmbb104) RETURNING g_pmbb_m.pmbb104_desc
            #DISPLAY BY NAME g_pmbb_m.pmbb104_desc
            #
            #CALL apmt101_pmbb087_ref(g_pmbb_m.pmbb087) RETURNING g_pmbb_m.pmbb087_desc
            #DISPLAY BY NAME g_pmbb_m.pmbb087_desc
            #
            #CALL apmt101_pmbb089_ref(g_pmbb_m.pmbb089) RETURNING g_pmbb_m.pmbb089_desc
            #DISPLAY BY NAME g_pmbb_m.pmbb089_desc
            #
            #CALL apmt101_pmbb090_ref(g_pmbb_m.pmbb090) RETURNING g_pmbb_m.pmbb090_desc
            #DISPLAY BY NAME g_pmbb_m.pmbb090_desc
            #
            CALL s_apmi011_location_ref(g_pmbb_m.pmbb090,g_pmbb_m.pmbb091) RETURNING g_pmbb_m.pmbb091_desc
            DISPLAY BY NAME g_pmbb_m.pmbb091_desc
            
            CALL s_apmi011_location_ref(g_pmbb_m.pmbb090,g_pmbb_m.pmbb092) RETURNING g_pmbb_m.pmbb092_desc
            DISPLAY BY NAME g_pmbb_m.pmbb092_desc
            
            #CALL apmt101_pmbb091_ref(g_pmbb_m.pmbb093) RETURNING g_pmbb_m.pmbb093_desc
            #DISPLAY BY NAME g_pmbb_m.pmbb093_desc
            #
            #CALL apmt101_pmbb003_ref(g_pmbb_m.pmbb097) RETURNING g_pmbb_m.pmbb097_desc
            #DISPLAY BY NAME g_pmbb_m.pmbb097_desc
            #
            #CALL apmt101_pmbb081_ref(g_pmbb_m.pmbb031) RETURNING g_pmbb_m.pmbb031_desc
            #DISPLAY BY NAME g_pmbb_m.pmbb031_desc
            #
            #CALL apmt101_pmbb083_ref(g_pmbb_m.pmbb033) RETURNING g_pmbb_m.pmbb033_desc
            #DISPLAY BY NAME g_pmbb_m.pmbb033_desc
            
            CALL apmt101_pmbb084_ref(g_pmbb_m.pmbb034) RETURNING g_pmbb_m.pmbb034_desc
            DISPLAY BY NAME g_pmbb_m.pmbb034_desc
            
            #CALL apmt101_pmbb087_ref(g_pmbb_m.pmbb037) RETURNING g_pmbb_m.pmbb037_desc
            #DISPLAY BY NAME g_pmbb_m.pmbb037_desc
            #
            #CALL apmt101_pmbb103_ref(g_pmbb_m.pmbb053) RETURNING g_pmbb_m.pmbb053_desc
            #DISPLAY BY NAME g_pmbb_m.pmbb053_desc
            #
            #CALL apmt101_pmbb054_ref(g_pmbb_m.pmbb054) RETURNING g_pmbb_m.pmbb054_desc
            #DISPLAY BY NAME g_pmbb_m.pmbb054_desc
            #
            #CALL apmt101_pmbb039_ref(g_pmbb_m.pmbb039) RETURNING g_pmbb_m.pmbb039_desc
            #DISPLAY BY NAME g_pmbb_m.pmbb039_desc
            #
            #CALL apmt101_pmbb090_ref(g_pmbb_m.pmbb040) RETURNING g_pmbb_m.pmbb040_desc
            #DISPLAY BY NAME g_pmbb_m.pmbb040_desc
            #
            CALL s_apmi011_location_ref(g_pmbb_m.pmbb040,g_pmbb_m.pmbb041) RETURNING g_pmbb_m.pmbb041_desc
            DISPLAY BY NAME g_pmbb_m.pmbb041_desc
            
            CALL s_apmi011_location_ref(g_pmbb_m.pmbb040,g_pmbb_m.pmbb042) RETURNING g_pmbb_m.pmbb042_desc
            DISPLAY BY NAME g_pmbb_m.pmbb042_desc
            
            #CALL apmt101_pmbb091_ref(g_pmbb_m.pmbb043) RETURNING g_pmbb_m.pmbb043_desc
            #DISPLAY BY NAME g_pmbb_m.pmbb043_desc
            #
            #CALL apmt101_pmbb003_ref(g_pmbb_m.pmbb047) RETURNING g_pmbb_m.pmbb047_desc
            #DISPLAY BY NAME g_pmbb_m.pmbb047_desc
            #
            #CALL apmt101_pmbb003_ref(g_pmbb_m.pmbb003) RETURNING g_pmbb_m.pmbb003_desc
            #DISPLAY BY NAME g_pmbb_m.pmbb003_desc
            #
            #CALL apmt101_pmbb083_ref(g_pmbb_m.pmbb005) RETURNING g_pmbb_m.pmbb005_desc
            #DISPLAY BY NAME g_pmbb_m.pmbb005_desc
            #
            #CALL apmt101_pmbb055_ref(g_pmbb_m.pmbb055) RETURNING g_pmbb_m.pmbb055_desc
            #DISPLAY BY NAME g_pmbb_m.pmbb055_desc
            #
            #CALL apmt101_pmbb105_ref(g_pmbb_m.pmbb105) RETURNING g_pmbb_m.pmbb105_desc
            #DISPLAY BY NAME g_pmbb_m.pmbb105_desc
            
            CALL apmt101_pmbb106_ref(g_pmbb_m.pmbb106) RETURNING g_pmbb_m.pmbb106_desc
            DISPLAY BY NAME g_pmbb_m.pmbb106_desc
            
            CALL apmt101_pmbb106_ref(g_pmbb_m.pmbb056) RETURNING g_pmbb_m.pmbb056_desc
            DISPLAY BY NAME g_pmbb_m.pmbb056_desc
            
            IF NOT cl_null(g_pmbb_m.pmbb001) THEN
               CALL s_aooi360_sel('2',g_pmbb_m.pmbbdocno,g_site,'','','','','','','','','4') RETURNING l_success,g_pmbb_m.ooff013
            END IF
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmbb_m.pmbbownid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_pmbb_m.pmbbownid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmbb_m.pmbbownid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmbb_m.pmbbowndp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pmbb_m.pmbbowndp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmbb_m.pmbbowndp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmbb_m.pmbbcrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_pmbb_m.pmbbcrtid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmbb_m.pmbbcrtid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmbb_m.pmbbcrtdp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pmbb_m.pmbbcrtdp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmbb_m.pmbbcrtdp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmbb_m.pmbbmodid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_pmbb_m.pmbbmodid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmbb_m.pmbbmodid_desc

   #end add-point
 
   #將資料輸出到畫面上
   DISPLAY BY NAME g_pmbb_m.pmbbdocno,g_pmbb_m.pmbb001,g_pmbb_m.pmba002,g_pmbb_m.status1,g_pmbb_m.pmbbdocno_desc, 
       g_pmbb_m.pmbal003,g_pmbb_m.pmba003,g_pmbb_m.pmbb080,g_pmbb_m.pmbb081,g_pmbb_m.pmbb081_desc,g_pmbb_m.pmbb109, 
       g_pmbb_m.pmbb109_desc,g_pmbb_m.pmbb082,g_pmbb_m.pmbb083,g_pmbb_m.pmbb083_desc,g_pmbb_m.pmbb084, 
       g_pmbb_m.pmbb084_desc,g_pmbb_m.pmbb103,g_pmbb_m.pmbb103_desc,g_pmbb_m.pmbb104,g_pmbb_m.pmbb104_desc, 
       g_pmbb_m.pmbb085,g_pmbb_m.pmbb086,g_pmbb_m.pmbb106,g_pmbb_m.pmbb106_desc,g_pmbb_m.pmbb087,g_pmbb_m.pmbb087_desc, 
       g_pmbb_m.pmbb105,g_pmbb_m.pmbb105_desc,g_pmbb_m.pmbb088,g_pmbb_m.pmbb088_desc,g_pmbb_m.pmbb089, 
       g_pmbb_m.pmbb089_desc,g_pmbb_m.pmbb107,g_pmbb_m.pmbb108,g_pmbb_m.pmbb090,g_pmbb_m.pmbb090_desc, 
       g_pmbb_m.pmbb091,g_pmbb_m.pmbb091_desc,g_pmbb_m.pmbb092,g_pmbb_m.pmbb092_desc,g_pmbb_m.pmbb093, 
       g_pmbb_m.pmbb093_desc,g_pmbb_m.pmbb094,g_pmbb_m.pmbb095,g_pmbb_m.pmbb096,g_pmbb_m.pmbb097,g_pmbb_m.pmbb097_desc, 
       g_pmbb_m.pmbb098,g_pmbb_m.pmbb099,g_pmbb_m.pmbb100,g_pmbb_m.pmbb101,g_pmbb_m.pmbb102,g_pmbb_m.pmbb030, 
       g_pmbb_m.pmbb031,g_pmbb_m.pmbb031_desc,g_pmbb_m.pmbb059,g_pmbb_m.pmbb059_desc,g_pmbb_m.pmbb032, 
       g_pmbb_m.pmbb033,g_pmbb_m.pmbb033_desc,g_pmbb_m.pmbb034,g_pmbb_m.pmbb034_desc,g_pmbb_m.pmbb053, 
       g_pmbb_m.pmbb053_desc,g_pmbb_m.pmbb054,g_pmbb_m.pmbb054_desc,g_pmbb_m.pmbb035,g_pmbb_m.pmbb036, 
       g_pmbb_m.pmbb056,g_pmbb_m.pmbb056_desc,g_pmbb_m.pmbb037,g_pmbb_m.pmbb037_desc,g_pmbb_m.pmbb055, 
       g_pmbb_m.pmbb055_desc,g_pmbb_m.pmbb038,g_pmbb_m.pmbb038_desc,g_pmbb_m.pmbb039,g_pmbb_m.pmbb039_desc, 
       g_pmbb_m.pmbb057,g_pmbb_m.pmbb058,g_pmbb_m.pmbb040,g_pmbb_m.pmbb040_desc,g_pmbb_m.pmbb041,g_pmbb_m.pmbb041_desc, 
       g_pmbb_m.pmbb042,g_pmbb_m.pmbb042_desc,g_pmbb_m.pmbb043,g_pmbb_m.pmbb043_desc,g_pmbb_m.pmbb044, 
       g_pmbb_m.pmbb045,g_pmbb_m.pmbb046,g_pmbb_m.pmbb047,g_pmbb_m.pmbb047_desc,g_pmbb_m.pmbb048,g_pmbb_m.pmbb049, 
       g_pmbb_m.pmbb050,g_pmbb_m.pmbb051,g_pmbb_m.pmbb052,g_pmbb_m.pmbb071,g_pmbb_m.pmbb072,g_pmbb_m.pmbb073, 
       g_pmbb_m.pmbb060,g_pmbb_m.pmbb061,g_pmbb_m.pmbb066,g_pmbb_m.pmbb062,g_pmbb_m.pmbb067,g_pmbb_m.pmbb063, 
       g_pmbb_m.pmbb068,g_pmbb_m.pmbb064,g_pmbb_m.pmbb069,g_pmbb_m.pmbb065,g_pmbb_m.pmbb070,g_pmbb_m.total, 
       g_pmbb_m.pmbb002,g_pmbb_m.pmbb003,g_pmbb_m.pmbb003_desc,g_pmbb_m.pmbb004,g_pmbb_m.pmbb004_desc, 
       g_pmbb_m.pmbb005,g_pmbb_m.pmbb005_desc,g_pmbb_m.pmbb006,g_pmbb_m.pmbb007,g_pmbb_m.pmbb008,g_pmbb_m.pmbb009, 
       g_pmbb_m.pmbb019,g_pmbb_m.pmbb010,g_pmbb_m.pmbb020,g_pmbb_m.pmbb011,g_pmbb_m.pmbb012,g_pmbb_m.pmbb013, 
       g_pmbb_m.pmbb014,g_pmbb_m.pmbb015,g_pmbb_m.pmbb016,g_pmbb_m.pmbb017,g_pmbb_m.pmbb018,g_pmbb_m.ooff013, 
       g_pmbb_m.pmbbownid,g_pmbb_m.pmbbownid_desc,g_pmbb_m.pmbbowndp,g_pmbb_m.pmbbowndp_desc,g_pmbb_m.pmbbcrtid, 
       g_pmbb_m.pmbbcrtid_desc,g_pmbb_m.pmbbcrtdp,g_pmbb_m.pmbbcrtdp_desc,g_pmbb_m.pmbbcrtdt,g_pmbb_m.pmbbmodid, 
       g_pmbb_m.pmbbmodid_desc,g_pmbb_m.pmbbmoddt
   
   #儲存PK
   LET l_ac = g_current_idx
   CALL apmt101_set_pk_array()
   
   #顯示狀態(stus)圖片
   
 
   #顯示有特殊格式設定的欄位或說明
   CALL cl_show_fld_cont()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apmt101.delete" >}
#+ 資料刪除 
PRIVATE FUNCTION apmt101_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE  l_success       LIKE type_t.num5
   #end add-point  
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   #先確定key值無遺漏
   IF g_pmbb_m.pmbbdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
    
   LET g_pmbbdocno_t = g_pmbb_m.pmbbdocno
 
   
   
 
   OPEN apmt101_cl USING g_enterprise, g_site,g_pmbb_m.pmbbdocno
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apmt101_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE apmt101_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE apmt101_master_referesh USING g_site,g_pmbb_m.pmbbdocno INTO g_pmbb_m.pmbbdocno,g_pmbb_m.pmbb001, 
       g_pmbb_m.pmbb080,g_pmbb_m.pmbb081,g_pmbb_m.pmbb109,g_pmbb_m.pmbb082,g_pmbb_m.pmbb083,g_pmbb_m.pmbb084, 
       g_pmbb_m.pmbb103,g_pmbb_m.pmbb104,g_pmbb_m.pmbb085,g_pmbb_m.pmbb086,g_pmbb_m.pmbb106,g_pmbb_m.pmbb087, 
       g_pmbb_m.pmbb105,g_pmbb_m.pmbb088,g_pmbb_m.pmbb089,g_pmbb_m.pmbb107,g_pmbb_m.pmbb108,g_pmbb_m.pmbb090, 
       g_pmbb_m.pmbb091,g_pmbb_m.pmbb092,g_pmbb_m.pmbb093,g_pmbb_m.pmbb094,g_pmbb_m.pmbb095,g_pmbb_m.pmbb096, 
       g_pmbb_m.pmbb097,g_pmbb_m.pmbb098,g_pmbb_m.pmbb099,g_pmbb_m.pmbb100,g_pmbb_m.pmbb101,g_pmbb_m.pmbb102, 
       g_pmbb_m.pmbb030,g_pmbb_m.pmbb031,g_pmbb_m.pmbb059,g_pmbb_m.pmbb032,g_pmbb_m.pmbb033,g_pmbb_m.pmbb034, 
       g_pmbb_m.pmbb053,g_pmbb_m.pmbb054,g_pmbb_m.pmbb035,g_pmbb_m.pmbb036,g_pmbb_m.pmbb056,g_pmbb_m.pmbb037, 
       g_pmbb_m.pmbb055,g_pmbb_m.pmbb038,g_pmbb_m.pmbb039,g_pmbb_m.pmbb057,g_pmbb_m.pmbb058,g_pmbb_m.pmbb040, 
       g_pmbb_m.pmbb041,g_pmbb_m.pmbb042,g_pmbb_m.pmbb043,g_pmbb_m.pmbb044,g_pmbb_m.pmbb045,g_pmbb_m.pmbb046, 
       g_pmbb_m.pmbb047,g_pmbb_m.pmbb048,g_pmbb_m.pmbb049,g_pmbb_m.pmbb050,g_pmbb_m.pmbb051,g_pmbb_m.pmbb052, 
       g_pmbb_m.pmbb071,g_pmbb_m.pmbb072,g_pmbb_m.pmbb073,g_pmbb_m.pmbb060,g_pmbb_m.pmbb061,g_pmbb_m.pmbb066, 
       g_pmbb_m.pmbb062,g_pmbb_m.pmbb067,g_pmbb_m.pmbb063,g_pmbb_m.pmbb068,g_pmbb_m.pmbb064,g_pmbb_m.pmbb069, 
       g_pmbb_m.pmbb065,g_pmbb_m.pmbb070,g_pmbb_m.pmbb002,g_pmbb_m.pmbb003,g_pmbb_m.pmbb004,g_pmbb_m.pmbb005, 
       g_pmbb_m.pmbb006,g_pmbb_m.pmbb007,g_pmbb_m.pmbb008,g_pmbb_m.pmbb009,g_pmbb_m.pmbb019,g_pmbb_m.pmbb010, 
       g_pmbb_m.pmbb020,g_pmbb_m.pmbb011,g_pmbb_m.pmbb012,g_pmbb_m.pmbb013,g_pmbb_m.pmbb014,g_pmbb_m.pmbb015, 
       g_pmbb_m.pmbb016,g_pmbb_m.pmbb017,g_pmbb_m.pmbb018,g_pmbb_m.pmbbownid,g_pmbb_m.pmbbowndp,g_pmbb_m.pmbbcrtid, 
       g_pmbb_m.pmbbcrtdp,g_pmbb_m.pmbbcrtdt,g_pmbb_m.pmbbmodid,g_pmbb_m.pmbbmoddt,g_pmbb_m.pmbb081_desc, 
       g_pmbb_m.pmbb109_desc,g_pmbb_m.pmbb083_desc,g_pmbb_m.pmbb103_desc,g_pmbb_m.pmbb104_desc,g_pmbb_m.pmbb087_desc, 
       g_pmbb_m.pmbb105_desc,g_pmbb_m.pmbb088_desc,g_pmbb_m.pmbb089_desc,g_pmbb_m.pmbb090_desc,g_pmbb_m.pmbb091_desc, 
       g_pmbb_m.pmbb092_desc,g_pmbb_m.pmbb093_desc,g_pmbb_m.pmbb097_desc,g_pmbb_m.pmbb031_desc,g_pmbb_m.pmbb059_desc, 
       g_pmbb_m.pmbb033_desc,g_pmbb_m.pmbb053_desc,g_pmbb_m.pmbb054_desc,g_pmbb_m.pmbb037_desc,g_pmbb_m.pmbb055_desc, 
       g_pmbb_m.pmbb038_desc,g_pmbb_m.pmbb039_desc,g_pmbb_m.pmbb040_desc,g_pmbb_m.pmbb041_desc,g_pmbb_m.pmbb042_desc, 
       g_pmbb_m.pmbb043_desc,g_pmbb_m.pmbb047_desc,g_pmbb_m.pmbb003_desc,g_pmbb_m.pmbb004_desc,g_pmbb_m.pmbb005_desc, 
       g_pmbb_m.pmbbownid_desc,g_pmbb_m.pmbbowndp_desc,g_pmbb_m.pmbbcrtid_desc,g_pmbb_m.pmbbcrtdp_desc, 
       g_pmbb_m.pmbbmodid_desc
   
   
   #檢查是否允許此動作
   IF NOT apmt101_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_pmbb_m_mask_o.* =  g_pmbb_m.*
   CALL apmt101_pmbb_t_mask()
   LET g_pmbb_m_mask_n.* =  g_pmbb_m.*
   
   #將最新資料顯示到畫面上
   CALL apmt101_show()
   
   IF cl_ask_delete() THEN
 
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point
 
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL apmt101_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
 
      DELETE FROM pmbb_t 
       WHERE pmbbent = g_enterprise AND pmbbsite = g_site AND pmbbdocno = g_pmbb_m.pmbbdocno 
 
 
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "pmbb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
  
      
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      LET l_success = ''
      CALL s_aooi360_del('2',g_pmbb_m.pmbbdocno,g_site,'','','','','','','','','4') RETURNING l_success
      IF NOT l_success THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ooff_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN
      END IF
      IF NOT s_aooi360_del('6',g_prog,g_pmbb_m.pmbbdocno,'','','','','','','','','4') THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF  
      #end add-point
      
       
 
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_pmbb_m)   #(ver:49)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:49)
         CLOSE apmt101_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      CLEAR FORM
      CALL apmt101_ui_browser_refresh()
      
      #確保畫面上保有資料
      IF g_browser_cnt > 0 THEN
         #CALL apmt101_browser_fill(g_wc,"")
         CALL apmt101_fetch("P")
      ELSE
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE    
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE apmt101_cl
 
   #功能已完成,通報訊息中心
   CALL apmt101_msgcentre_notify('delete')
 
   #add-point:單頭刪除完成後 name="delete.a_delete"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apmt101.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION apmt101_ui_browser_refresh()
   #add-point:ui_browser_refresh段define(客製用) name="ui_browser_refresh.define_customerization"
   
   #end add-point
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_browser_refresh.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="ui_browser_refresh.pre_function"
   
   #end add-point
   
   LET g_browser_cnt = g_browser.getLength()
   LET g_header_cnt  = g_browser.getLength()
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_pmbbdocno = g_pmbb_m.pmbbdocno
 
         THEN
         CALL g_browser.deleteElement(l_i)
       END IF
   END FOR
   LET g_browser_cnt = g_browser_cnt - 1
   LET g_header_cnt = g_header_cnt - 1
   
   DISPLAY g_browser_cnt TO FORMONLY.b_count     #page count
   DISPLAY g_header_cnt  TO FORMONLY.h_count     #page count
  
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
      CLEAR FORM
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
  
END FUNCTION
 
{</section>}
 
{<section id="apmt101.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION apmt101_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization" 
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point     
    
   #add-point:Function前置處理 name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("pmbbdocno",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
 
      #end add-point 
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("pmbb050,pmbb052,pmbb100,pmbb102",TRUE)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="apmt101.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION apmt101_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("pmbbdocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF NOT cl_null(g_argv[03]) THEN
      CALL cl_set_comp_entry("pmbbdocno",FALSE)
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      CALL cl_set_comp_entry("pmbb001",FALSE)
   END IF

   IF g_pmbb_m.pmbb049 = 'N' THEN
      LET g_pmbb_m.pmbb050 = 0
      CALL cl_set_comp_entry("pmbb050",FALSE)
   END IF
   IF g_pmbb_m.pmbb051 = 'N' THEN
      LET g_pmbb_m.pmbb052 = 0
      CALL cl_set_comp_entry("pmbb052",FALSE)
   END IF
   IF g_pmbb_m.pmbb099 = 'N' THEN
      LET g_pmbb_m.pmbb100 = 0
      CALL cl_set_comp_entry("pmbb100",FALSE)
   END IF
   IF g_pmbb_m.pmbb101 = 'N' THEN
      LET g_pmbb_m.pmbb102 = 0
      CALL cl_set_comp_entry("pmbb102",FALSE)
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="apmt101.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION apmt101_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization" 
   
   #end add-point  
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   CALL cl_set_act_visible("insert,modify,delete,reproduce,query", TRUE)

   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apmt101.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION apmt101_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   DEFINE l_pmbasuts  LIKE pmba_t.pmbastus
   #end add-point
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   IF cl_null(g_argv[03]) OR cl_null(g_argv[04]) THEN
      CALL cl_set_act_visible("insert,reproduce", FALSE)
   ELSE
      CALL cl_set_act_visible("insert,query,reproduce", FALSE)
   END IF
   
   LET l_pmbasuts = ''
   SELECT pmbastus INTO l_pmbasuts FROM pmba_t WHERE pmbaent=g_enterprise AND pmbadocno=g_pmbb_m.pmbbdocno
   IF l_pmbasuts != 'N' THEN
      CALL cl_set_act_visible("modify,delete", FALSE)
   END IF
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apmt101.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION apmt101_default_search()
   #add-point:default_search段define(客製用) name="default_search.define_customerization" 
   
   #end add-point
   DEFINE li_idx  LIKE type_t.num10
   DEFINE li_cnt  LIKE type_t.num10
   DEFINE ls_wc   STRING
   #add-point:default_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="default_search.pre_function"
   
   #end add-point
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point  
   
   #根據外部參數(g_argv)組合wc
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " pmbbdocno = '", g_argv[01], "' AND "
   END IF
   
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   LET ls_wc = ''
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = " pmbbdocno = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc," pmbb001 = '",g_argv[04], "' AND "
   END IF
   #end add-point  
   
   IF NOT cl_null(ls_wc) THEN
      #若有外部參數則根據該參數組合
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_default = TRUE
   ELSE
      #若無外部參數則預設為1=2
      LET g_default = FALSE
      #預設查詢條件
      LET g_wc = cl_qbe_get_default_qryplan()
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=2"
      END IF
   END IF
   
   #add-point:default_search段結束前 name="default_search.after"
   IF NOT cl_null(g_argv[01]) THEN
      CASE g_argv[01] 
         WHEN '1' LET g_wc = g_wc , " AND pmbbdocno IN (SELECT pmbadocno FROM pmba_t WHERE pmbaent = ",g_enterprise," AND (pmba002 = '1' OR pmba002 = '3') ) "  #170120-00047#1 add ent
         WHEN '2' LET g_wc = g_wc , " AND pmbbdocno IN (SELECT pmbadocno FROM pmba_t WHERE pmbaent = ",g_enterprise," AND (pmba002 = '2' OR pmba002 = '3') ) "  #170120-00047#1 add ent
         WHEN '3' LET g_wc = g_wc , " AND 1=1"
      END CASE
   END IF
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="apmt101.mask_functions" >}
&include "erp/apm/apmt101_mask.4gl"
 
{</section>}
 
{<section id="apmt101.state_change" >}
   
 
{</section>}
 
{<section id="apmt101.signature" >}
   
 
{</section>}
 
{<section id="apmt101.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION apmt101_set_pk_array()
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
   LET g_pk_array[1].values = g_pmbb_m.pmbbdocno
   LET g_pk_array[1].column = 'pmbbdocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apmt101.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="apmt101.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION apmt101_msgcentre_notify(lc_state)
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
   CALL apmt101_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_pmbb_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apmt101.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION apmt101_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization" 
   
   #end add-point
   #add-point:action_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="apmt101.other_function" readonly="Y" >}
##################################################################################
#1.當傳入參數p_type = '1'(供應商維護作業)時
#  1-1."客戶資料"頁籤必須隱藏頁籤需隱藏不可以維護
#  1-2.畫面上是交易對象的名稱均改為供應商
#2.當傳入參數p_type = '2'(客戶維護作業)時，
#  2-1."供應商資料"、"供應商評鑑"頁籤需隱藏不可維護
#  2-2.畫面上是交易對象的名稱均改為客戶
#################################################################################
PRIVATE FUNCTION apmt101_set_visible()
    #供應商
    IF g_argv[1] = '1' THEN
       CALL cl_set_comp_visible("master_Folder_page",FALSE)
       CALL apmt101_set_title_visible('1')
    END IF
    #客戶    
    IF g_argv[1] = '2' THEN
       CALL cl_set_comp_visible("page_2,page_3",FALSE)
       CALL apmt101_set_title_visible('2')
    END IF 
    
END FUNCTION
#+
PRIVATE FUNCTION apmt101_set_title_visible(p_pmba002)
DEFINE p_pmba002  LIKE pmba_t.pmba002
DEFINE l_gzze003  LIKE gzze_t.gzze003
DEFINE l_ooef006  LIKE ooef_t.ooef006

       IF NOT cl_null(p_pmba002) THEN
          #供應商
          IF p_pmba002 = '1' THEN
             LET l_gzze003 = ' '
             SELECT gzze003 INTO l_gzze003 FROM gzze_t WHERE gzze001 = 'apm-00050' AND gzze002 = g_dlang
             CALL cl_set_comp_att_text('pmbb001',l_gzze003)
             CALL cl_set_comp_att_text('b_pmbb001',l_gzze003)
             LET l_gzze003 = ' '
             SELECT gzze003 INTO l_gzze003 FROM gzze_t WHERE gzze001 = 'apm-00051' AND gzze002 = g_dlang
             CALL cl_set_comp_att_text('pmbal004',l_gzze003)
             CALL cl_set_comp_att_text('b_pmbb001_desc',l_gzze003)
             LET l_gzze003 = ' '
             SELECT gzze003 INTO l_gzze003 FROM gzze_t WHERE gzze001 = 'apm-00077' AND gzze002 = g_dlang
             CALL cl_set_comp_att_text('pmbal003',l_gzze003)
             CALL cl_set_comp_att_text('b_pmbal003',l_gzze003)
             LET l_gzze003 = ' '
             SELECT gzze003 INTO l_gzze003 FROM gzze_t WHERE gzze001 = 'apm-00078' AND gzze002 = g_dlang
             CALL cl_set_comp_att_text('pmba003',l_gzze003)
          END IF
          #客戶 
          IF p_pmba002 = '2' THEN
             LET l_gzze003 = ' '
             SELECT gzze003 INTO l_gzze003 FROM gzze_t WHERE gzze001 = 'apm-00052' AND gzze002 = g_dlang
             CALL cl_set_comp_att_text('pmbb001',l_gzze003)
             CALL cl_set_comp_att_text('b_pmbb001',l_gzze003)
             LET l_gzze003 = ' '
             SELECT gzze003 INTO l_gzze003 FROM gzze_t WHERE gzze001 = 'apm-00053' AND gzze002 = g_dlang
             CALL cl_set_comp_att_text('pmbal004',l_gzze003)
             CALL cl_set_comp_att_text('b_pmbb001_desc',l_gzze003)
             LET l_gzze003 = ' '
             SELECT gzze003 INTO l_gzze003 FROM gzze_t WHERE gzze001 = 'apm-00079' AND gzze002 = g_dlang
             CALL cl_set_comp_att_text('pmbal003',l_gzze003)
             CALL cl_set_comp_att_text('b_pmbal003',l_gzze003)
             LET l_gzze003 = ' '
             SELECT gzze003 INTO l_gzze003 FROM gzze_t WHERE gzze001 = 'apm-00080' AND gzze002 = g_dlang
             CALL cl_set_comp_att_text('pmba003',l_gzze003)
          END IF
       END IF
       
       #[T:營運據點資料檔].[C:專屬國家地區功能]為"台灣"畫面顯示"統一編號"
       LET l_ooef006 = ' '
       SELECT ooef006 INTO l_ooef006 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
       IF l_ooef006 = 'TW' OR l_ooef006 = 'tw' THEN
          LET l_gzze003 = ' '
          SELECT gzze003 INTO l_gzze003 FROM gzze_t WHERE gzze001 = 'apm-00084' AND gzze002 = g_dlang
          CALL cl_set_comp_att_text('pmba003',l_gzze003)
       END IF
       
END FUNCTION
#+
PRIVATE FUNCTION apmt101_set_no_required()
   CALL cl_set_comp_required("pmbb004,pmbb005,pmbb006",FALSE)
      
END FUNCTION
#+
PRIVATE FUNCTION apmt101_set_required()
      IF g_pmbb_m.pmbb002 MATCHES '[23]' THEN
         CALL cl_set_comp_required("pmbb004,pmbb005,pmbb006",TRUE)
      END IF
END FUNCTION
#+
PRIVATE FUNCTION apmt101_pmbbdocno_desc(p_pmbadocno)
DEFINE p_pmbadocno    LIKE pmba_t.pmbadocno
DEFINE l_oobal002     LIKE oobal_t.oobal002
DEFINE l_ooef004      LIKE ooef_t.ooef004
DEFINE r_pmbadocno_desc  LIKE oobal_t.oobal004
DEFINE l_flag          LIKE type_t.num5          #标识符，TRUE/FALSE
DEFINE l_flag1         LIKE type_t.num5          #标识符，TRUE/FALSE
DEFINE l_site          LIKE type_t.chr20


      LET l_flag = TRUE
      LET l_flag1 = TRUE
      LET l_ooef004 = NULL
      LET l_oobal002 = NULL
      IF NOT cl_null(p_pmbadocno) THEN
         CALL s_aooi200_get_site(p_pmbadocno) RETURNING l_flag,l_site
         IF l_flag THEN
            SELECT ooef004 INTO l_ooef004 FROM ooef_t
             WHERE ooef005 = l_site
               AND ooefent = g_enterprise
         END IF
         CALL s_aooi200_get_slip(p_pmbadocno) RETURNING l_flag1,l_oobal002
         IF l_flag1 THEN
            IF NOT cl_null(l_oobal002) AND NOT cl_null(l_ooef004) THEN
               SELECT oobal004 INTO r_pmbadocno_desc FROM oobal_t
                WHERE oobal001 = l_ooef004
                  AND oobal002 = l_oobal002
                  AND oobal003 = g_dlang
                  AND oobalent = g_enterprise
            ELSE
               LET r_pmbadocno_desc = ""
            END IF
         END IF
      ELSE
         LET r_pmbadocno_desc = ""
      END IF

      RETURN r_pmbadocno_desc
      
END FUNCTION
#+
PRIVATE FUNCTION apmt101_pmbbdocno_ref(p_pmbbdocno)
DEFINE p_pmbbdocno    LIKE pmbb_t.pmbbdocno
DEFINE r_pmba001      LIKE pmba_t.pmba001
DEFINE r_pmbal003     LIKE pmbal_t.pmbal003
DEFINE r_pmba002      LIKE pmba_t.pmba002
DEFINE r_pmba003      LIKE pmba_t.pmba003
DEFINE r_pmbastus     LIKE pmba_t.pmbastus

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = p_pmbbdocno
      CALL ap_ref_array2(g_ref_fields,"SELECT pmbal003 FROM pmbal_t WHERE pmbalent='"||g_enterprise||"' AND pmbaldocno = ? AND pmbal001='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET r_pmbal003 = g_rtn_fields[1]
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = p_pmbbdocno
      CALL ap_ref_array2(g_ref_fields,"SELECT pmba001,pmba002,pmba003,pmbastus FROM pmba_t WHERE pmbaent='"||g_enterprise||"' AND pmbadocno=? ","") RETURNING g_rtn_fields
      LET r_pmba001 = g_rtn_fields[1]
      LET r_pmba002 = g_rtn_fields[2]
      LET r_pmba003 = g_rtn_fields[3]
      LET r_pmbastus = g_rtn_fields[4]
      RETURN r_pmba001,r_pmbal003,r_pmba002,r_pmba003,r_pmbastus
      
END FUNCTION
#+
PRIVATE FUNCTION apmt101_pmbb081_chk(p_pmbb081)
DEFINE p_pmbb081      LIKE pmbb_t.pmbb081
DEFINE r_success      LIKE type_t.num5

       LET r_success = TRUE
       
       IF NOT ap_chk_isExist(p_pmbb081,"SELECT COUNT(*) FROM ooag_t WHERE ooagent = '" ||g_enterprise||"' AND ooag001 = ? ","aoo-00074",1 ) THEN
          LET r_success = FALSE
          RETURN r_success
       END IF
       IF NOT ap_chk_isExist(p_pmbb081,"SELECT COUNT(*) FROM ooag_t WHERE ooagent = '" ||g_enterprise||"' AND ooag001 = ? AND ooagstus = 'Y' ","sub-01302","aooi130" ) THEN  #aoo-00071  #160318-00005#36  By 07900 --mod  
          LET r_success = FALSE
          RETURN r_success
       END IF
       RETURN r_success
       
END FUNCTION
#+
PRIVATE FUNCTION apmt101_pmbb083_chk(p_pmbb083)
DEFINE p_pmbb083  LIKE pmbb_t.pmbb083
DEFINE r_success  LIKE type_t.num5

      LET r_success = TRUE
      
      #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
      INITIALIZE g_chkparam.* TO NULL

      #設定g_chkparam.*的參數
      IF g_site = 'ALL' THEN
         LET g_chkparam.arg1 = g_site_t
      ELSE
         LET g_chkparam.arg1 = g_site
      END IF
      LET g_chkparam.arg2 = p_pmbb083

      #160318-00025#37  2016/04/19  by pengxin  add(S)
      LET g_errshow = TRUE #是否開窗 
      LET g_chkparam.err_str[1] = "aoo-00176:sub-01302|aooi150|",cl_get_progname("aooi150",g_lang,"2"),"|:EXEPROGaooi150"
      #160318-00025#37  2016/04/19  by pengxin  add(E)
      
      #呼叫檢查存在並帶值的library
      IF NOT cl_chk_exist("v_ooaj002") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
      RETURN r_success
      
END FUNCTION
#+
PRIVATE FUNCTION apmt101_pmbb083_ref(p_pmbb083)
DEFINE p_pmbb083      LIKE pmbb_t.pmbb083
DEFINE r_pmbb083_desc LIKE ooail_t.ooail003

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmbb083
       CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001 = ? AND ooail002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmbb083_desc = g_rtn_fields[1]
       RETURN r_pmbb083_desc
       
END FUNCTION
#+
PRIVATE FUNCTION apmt101_pmbb103_chk(p_pmbb103)
DEFINE p_pmbb103  LIKE pmbb_t.pmbb103
DEFINE r_success  LIKE type_t.num5

       LET r_success = TRUE
       
       IF NOT ap_chk_isExist(p_pmbb103,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '238' AND oocq002 = ? ","sub-01303","apmi012") THEN  #apm-00069  #160318-00005#36  By 07900 --mod 
          LET r_success = FALSE
          RETURN r_success
       END IF
       IF NOT ap_chk_isExist(p_pmbb103,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '238' AND oocq002 = ? AND oocqstus = 'Y' ","sub-01302","apmi012") THEN #apm-00070  #160318-00005#36  By 07900 --mod
          LET r_success = FALSE
          RETURN r_success
       END IF
       RETURN r_success
       
END FUNCTION
#+
PRIVATE FUNCTION apmt101_pmbb103_ref(p_pmbb103)
DEFINE p_pmbb103      LIKE pmbb_t.pmbb103
DEFINE r_pmbb103_desc LIKE oocql_t.oocql004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmbb103
       CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='238' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmbb103_desc = g_rtn_fields[1]
       RETURN r_pmbb103_desc
       
END FUNCTION
#+
PRIVATE FUNCTION apmt101_pmbb090_chk(p_pmbb090)
DEFINE p_pmbb090  LIKE pmab_t.pmab090
DEFINE r_success  LIKE type_t.num5

       LET r_success = TRUE
       
       IF NOT ap_chk_isExist(p_pmbb090,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '263' AND oocq002 = ? ","sub-01303","apmi011" ) THEN  #apm-00073  #160318-00005#36  By 07900 --mod 
          LET r_success = FALSE
          RETURN r_success
       END IF
       IF NOT ap_chk_isExist(p_pmbb090,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '263' AND oocq002 = ? AND oocqstus = 'Y' ","sub-01302","apmi011") THEN  #apm-00074  #160318-00005#36  By 07900 --mod
          LET r_success = FALSE
          RETURN r_success
       END IF
       RETURN r_success
    
END FUNCTION
#+
PRIVATE FUNCTION apmt101_pmbb090_ref(p_pmbb090)
DEFINE p_pmbb090      LIKE pmbb_t.pmbb090
DEFINE r_pmbb090_desc LIKE oocql_t.oocql004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmbb090
       CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='263' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmbb090_desc = g_rtn_fields[1]
       RETURN r_pmbb090_desc
       
END FUNCTION
#+
PRIVATE FUNCTION apmt101_pmbb089_ref(p_pmbb089)
DEFINE p_pmbb089      LIKE pmbb_t.pmbb080
DEFINE r_pmbb089_desc LIKE oocql_t.oocql004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmbb089
       CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='295' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmbb089_desc = g_rtn_fields[1]
       RETURN r_pmbb089_desc
       
END FUNCTION
#+
PRIVATE FUNCTION apmt101_pmbb091_chk(p_pmbb091)
DEFINE p_pmbb091    LIKE pmbb_t.pmbb091
DEFINE r_success    LIKE type_t.num5

       LET r_success = TRUE
       
       IF NOT cl_null(p_pmbb091) THEN 
          IF NOT ap_chk_isExist(p_pmbb091,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '262' AND oocq002 = ? ","sub-01303","apmi010" ) THEN  #apm-00075  #160318-00005#36  By 07900 --mod 
             LET r_success = FALSE
             RETURN r_success
          END IF
          IF NOT ap_chk_isExist(p_pmbb091,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '262' AND oocq002 = ? AND oocqstus = 'Y' ","sub-01302","apmi010") THEN #apm-00076  #160318-00005#36  By 07900 --mod
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF
       RETURN r_success
       
END FUNCTION
#+
PRIVATE FUNCTION apmt101_pmbb091_ref(p_pmbb091)
DEFINE p_pmbb091      LIKE pmbb_t.pmbb091
DEFINE r_pmbb091_desc LIKE oocql_t.oocql004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmbb091
       CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='262' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmbb091_desc = g_rtn_fields[1]
       RETURN r_pmbb091_desc
    
END FUNCTION
#+
PRIVATE FUNCTION apmt101_pmbb081_ref(p_pmbb081)
DEFINE p_pmbb081      LIKE pmbb_t.pmbb081
DEFINE r_pmbb081_desc LIKE oofa_t.oofa011

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmbb081
       CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
       LET r_pmbb081_desc = g_rtn_fields[1]
       RETURN r_pmbb081_desc
 
END FUNCTION
#+
PRIVATE FUNCTION apmt101_pmbb039_ref(p_pmbb039)
DEFINE p_pmbb039      LIKE pmbb_t.pmbb039
DEFINE r_pmbb039_desc LIKE oocql_t.oocql004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmbb039
       CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='264' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmbb039_desc = g_rtn_fields[1]
       RETURN r_pmbb039_desc
 
END FUNCTION
#+
PRIVATE FUNCTION apmt101_pmbb003_ref(p_pmbb003)
DEFINE p_pmbb003      LIKE pmbb_t.pmbb003
DEFINE r_pmbb003_desc LIKE pmaal_t.pmaal004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmbb003
       CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmbb003_desc = '', g_rtn_fields[1] , ''
       RETURN r_pmbb003_desc
      
END FUNCTION
#+
PRIVATE FUNCTION apmt101_pmbb097_chk(p_pmbb097)
DEFINE p_pmbb097    LIKE pmbb_t.pmbb097
DEFINE r_success    LIKE type_t.num5

      LET r_success = TRUE
      
      IF NOT ap_chk_isExist(p_pmbb097,"SELECT COUNT(*) FROM pmaa_t WHERE pmaaent = '" ||g_enterprise||"' AND pmaa001 = ? AND (pmaa002 = '1' OR pmaa002 = '3') ","apm-00024",1 ) THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
      IF NOT ap_chk_isExist(p_pmbb097,"SELECT COUNT(*) FROM pmaa_t WHERE pmaaent = '" ||g_enterprise||"' AND pmaa001 = ? AND pmaastus != 'X' AND (pmaa002 = '1' OR pmaa002 = '3') ","apm-00025",1 ) THEN
         LET r_success = FALSE
         RETURN r_success
      END IF

      RETURN r_success
      
END FUNCTION
#+
PRIVATE FUNCTION apmt101_pmbb105_ref(p_pmbb105)
DEFINE p_pmbb105      LIKE pmbb_t.pmbb105
DEFINE r_pmbb105_desc LIKE oocql_t.oocql004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmbb105
       CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='3111' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmbb105_desc = g_rtn_fields[1]
       RETURN r_pmbb105_desc
    
END FUNCTION
#+
PRIVATE FUNCTION apmt101_pmbb055_ref(p_pmbb055)
DEFINE p_pmbb055      LIKE pmbb_t.pmbb055
DEFINE r_pmbb055_desc LIKE oocql_t.oocql004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmbb055
       CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='3211' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmbb055_desc = g_rtn_fields[1]
       RETURN r_pmbb055_desc
    
END FUNCTION
#+
PRIVATE FUNCTION apmt101_pmbb084_chk(p_pmbb084)
DEFINE p_pmbb084  LIKE pmbb_t.pmbb084
DEFINE r_success  LIKE type_t.num5

      LET r_success = TRUE
      #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
      INITIALIZE g_chkparam.* TO NULL

      #設定g_chkparam.*的參數
      IF g_site = 'ALL' THEN
         LET g_chkparam.arg1 = g_site_t
      ELSE
         LET g_chkparam.arg1 = g_site
      END IF
      LET g_chkparam.arg2 = p_pmbb084

      #160318-00025#37  2016/04/19  by pengxin  add(S)
      LET g_errshow = TRUE #是否開窗 
      LET g_chkparam.err_str[1] = "aoo-00223:sub-01302|aooi610|",cl_get_progname("aooi610",g_lang,"2"),"|:EXEPROGaooi610"
      #160318-00025#37  2016/04/19  by pengxin  add(E)
      
      #呼叫檢查存在並帶值的library
      IF NOT cl_chk_exist("v_oodb002") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
      RETURN r_success
      
END FUNCTION
#+
PRIVATE FUNCTION apmt101_pmbb084_ref(p_pmbb084)
DEFINE p_pmbb084      LIKE pmbb_t.pmbb084
DEFINE l_ooef019      LIKE ooef_t.ooef019
DEFINE r_pmbb084_desc LIKE oodbl_t.oodbl004

       LET l_ooef019 = ''
       IF g_site = 'ALL' THEN 
          SELECT ooef019 INTO l_ooef019 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site_t
       ELSE
          SELECT ooef019 INTO l_ooef019 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
       END IF
       
       
       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmbb084
       CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl001='"||l_ooef019||"' AND oodbl002=? AND oodbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmbb084_desc = g_rtn_fields[1]
       RETURN r_pmbb084_desc
    
END FUNCTION
#+
PRIVATE FUNCTION apmt101_pmbb087_chk(p_pmbb087,p_pmad003)
DEFINE p_pmbb087   LIKE pmbb_t.pmbb087
DEFINE p_pmad003   LIKE pmad_t.pmad003
DEFINE r_success   LIKE type_t.num5

      LET r_success = TRUE
      
      IF NOT ap_chk_isExist(p_pmbb087,"SELECT COUNT(*) FROM pmbd_t WHERE pmbdent = '" ||g_enterprise||"' AND pmbddocno='"||g_pmbb_m.pmbbdocno||"' AND pmbd002=? AND pmbd003='"||p_pmad003||"' ","apm-00191",1 ) THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
      IF NOT ap_chk_isExist(p_pmbb087,"SELECT COUNT(*) FROM pmbd_t WHERE pmbdent = '" ||g_enterprise||"' AND pmbddocno='"||g_pmbb_m.pmbbdocno||"' AND pmbd002=?  AND pmbd003='"||p_pmad003||"' AND pmbdstus = 'Y' ","sub-01302","apmm100") THEN  #apm-00192  #160318-00005#36  By 07900 --mod
         LET r_success = FALSE
         RETURN r_success
      END IF
      RETURN r_success
      
END FUNCTION

PRIVATE FUNCTION apmt101_pmbb054_chk(p_pmbb054)
DEFINE p_pmbb054   LIKE pmbb_t.pmbb054
DEFINE r_success   LIKE type_t.num5

      LET r_success = TRUE
      
      IF NOT ap_chk_isExist(p_pmbb054,"SELECT COUNT(*) FROM pmam_t WHERE pmament = '" ||g_enterprise||"' AND pmam001=?  ","apm-00209",1 ) THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
      IF NOT ap_chk_isExist(p_pmbb054,"SELECT COUNT(*) FROM pmam_t WHERE pmament = '" ||g_enterprise||"' AND pmam001=? AND pmamstus = 'Y' ","sub-01302","apmi130") THEN  #apm-00210  #160318-00005#36  By 07900 --mod  
         LET r_success = FALSE
         RETURN r_success
      END IF
      RETURN r_success
      
END FUNCTION
#+
PRIVATE FUNCTION apmt101_pmbb087_ref(p_pmbb087)
DEFINE p_pmbb087      LIKE pmbb_t.pmbb087
DEFINE r_pmbb087_desc LIKE ooibl_t.ooibl004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmbb087
       CALL ap_ref_array2(g_ref_fields,"SELECT ooibl004 FROM ooibl_t WHERE ooiblent='"||g_enterprise||"' AND ooibl002=? AND ooibl003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmbb087_desc = g_rtn_fields[1]
       RETURN r_pmbb087_desc
    
END FUNCTION

PRIVATE FUNCTION apmt101_pmbb104_ref(p_pmbb104)
DEFINE p_pmbb104      LIKE pmbb_t.pmbb104
DEFINE r_pmbb104_desc LIKE xmahl_t.xmahl003

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmbb104
       CALL ap_ref_array2(g_ref_fields,"SELECT xmahl003 FROM xmahl_t WHERE xmahlent='"||g_enterprise||"' AND xmahl001=? AND xmahl002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmbb104_desc = g_rtn_fields[1]
       RETURN r_pmbb104_desc
    
END FUNCTION

PRIVATE FUNCTION apmt101_pmbb106_ref(p_pmbb106)
DEFINE p_pmbb106      LIKE pmbb_t.pmbb106
DEFINE r_isacl004     LIKE isacl_t.isacl004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmbb106
       CALL ap_ref_array2(g_ref_fields,"SELECT isacl004 FROM isacl_t WHERE isaclent='"||g_enterprise||"' AND isacl001='"||g_ooef019||"' AND isacl002=? AND isacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_isacl004 = '', g_rtn_fields[1] , ''
       RETURN r_isacl004

END FUNCTION

PRIVATE FUNCTION apmt101_pmbb088_ref(p_pmbb088)
DEFINE p_pmbb088      LIKE pmbb_t.pmbb088
DEFINE r_oocql004     LIKE oocql_t.oocql004

         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = p_pmbb088
         #160621-00003#3 20160627 modify by beckxie---S
         #CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='275' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         CALL ap_ref_array2(g_ref_fields,"SELECT oojdl003 FROM oojdl_t WHERE oojdlent='"||g_enterprise||"' AND oojdl001=? AND oojdl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         #160621-00003#3 20160627 modify by beckxie---E
         LET r_oocql004 = '', g_rtn_fields[1] , ''
         RETURN r_oocql004

END FUNCTION

PRIVATE FUNCTION apmt101_pmbb054_ref(p_pmbb054)
DEFINE p_pmbb054      LIKE pmbb_t.pmbb054
DEFINE r_pmbb054_desc LIKE pmaml_t.pmaml003

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmbb054
       CALL ap_ref_array2(g_ref_fields,"SELECT pmaml003 FROM pmaml_t WHERE pmamlent='"||g_enterprise||"' AND pmaml001=? AND pmaml002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmbb054_desc = g_rtn_fields[1]
       RETURN r_pmbb054_desc
    
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apmt101_pmbb004_ref(p_xmajl001)
#                  RETURNING r_xmajl003
# Input parameter: p_xmajl001
# Return code....: r_xmajl003
# Date & Author..: 2014/08/17 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt101_pmbb004_ref(p_xmajl001)
   DEFINE p_xmajl001     LIKE xmajl_t.xmajl001
   DEFINE r_xmajl003     LIKE xmajl_t.xmajl003

   LET r_xmajl003 = ''
   SELECT xmajl003 INTO r_xmajl003
     FROM xmajl_t
    WHERE xmajlent = g_enterprise
      AND xmajl001 = p_xmajl001
      AND xmajl002 = g_dlang

   RETURN r_xmajl003
END FUNCTION

#取得運輸類型
PRIVATE FUNCTION apmt101_get_oocq019(p_pmbb090)
DEFINE p_pmbb090 LIKE pmbb_t.pmbb090
DEFINE r_oocq019 LIKE oocq_t.oocq019

   LET r_oocq019 = ''
   SELECT oocq019 INTO r_oocq019
     FROM oocq_t
    WHERE oocqent = g_enterprise
      AND oocq001='263'
      AND oocq002= p_pmbb090

   RETURN r_oocq019

END FUNCTION

 
{</section>}
 
