#該程式未解開Section, 採用最新樣板產出!
{<section id="apmm101.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0027(2017-01-10 15:29:11), PR版次:0027(2017-02-08 10:48:43)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000439
#+ Filename...: apmm101
#+ Description: 集團預設交易對象資料維護作業
#+ Creator....: 02294(2013-09-06 11:10:19)
#+ Modifier...: 01996 -SD/PR- 06814
 
{</section>}
 
{<section id="apmm101.global" >}
#應用 i01 樣板自動產生(Version:50)
#add-point:填寫註解說明 name="global.memo"
#160318-00005#34  16/03/18   By Hans      將重複內容的錯誤訊息置換為公用錯誤訊息 
#160318-00025#37  16/03/19   By pengxin   將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160705-00042#10  16/07/13   By sakura    程式中寫死g_prog部分改寫MATCHES方式
#160816-00042#1   2016/08/18   By xianghui s_azzi610_check检查时增加据点参数
#160905-00007#11  2016/09/05 By 01727     调整系统中无ENT的SQL条件增加ent
#161212-00009#1   2016/12/12 By catmoon 編碼(pmab001)的開窗由q_pmaa001_4改q_pmab001_2
#161216-00024#1   2016/12/19 By Ann_Huang 修正切換據點時,需重新取得發票類型(g_ooef019)
#161231-00008#1   2016/12/31 By wuxja     当交运方式为空的时候，交运起点终点不可输入
#160617-00003#1   2017/01/10 By xujing    额度交易对象预设为自己
#170120-00047#1   2017/01/20 By lixiang   sql条件中增加ent条件
#170203-00002#12  2017/02/08 By 06814     新舊值寫法調整
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
PRIVATE TYPE type_g_pmab_m RECORD
       pmab001 LIKE pmab_t.pmab001, 
   pmaal004 LIKE pmaal_t.pmaal004, 
   pmaal005 LIKE pmaal_t.pmaal005, 
   pmaa003 LIKE pmaa_t.pmaa003, 
   pmaa002 LIKE pmaa_t.pmaa002, 
   pmaal003 LIKE pmaal_t.pmaal003, 
   pmaal006 LIKE pmaal_t.pmaal006, 
   status1 LIKE type_t.chr500, 
   pmab080 LIKE pmab_t.pmab080, 
   pmab081 LIKE pmab_t.pmab081, 
   pmab081_desc LIKE type_t.chr80, 
   pmab109 LIKE pmab_t.pmab109, 
   pmab109_desc LIKE type_t.chr80, 
   pmab082 LIKE pmab_t.pmab082, 
   pmab111 LIKE pmab_t.pmab111, 
   pmab083 LIKE pmab_t.pmab083, 
   pmab083_desc LIKE type_t.chr80, 
   pmab084 LIKE pmab_t.pmab084, 
   pmab084_desc LIKE type_t.chr80, 
   pmab103 LIKE pmab_t.pmab103, 
   pmab103_desc LIKE type_t.chr80, 
   pmab104 LIKE pmab_t.pmab104, 
   pmab104_desc LIKE type_t.chr80, 
   pmab085 LIKE pmab_t.pmab085, 
   pmab086 LIKE pmab_t.pmab086, 
   pmab106 LIKE pmab_t.pmab106, 
   pmab106_desc LIKE type_t.chr80, 
   pmab087 LIKE pmab_t.pmab087, 
   pmab087_desc LIKE type_t.chr80, 
   pmab105 LIKE pmab_t.pmab105, 
   pmab105_desc LIKE type_t.chr80, 
   pmab088 LIKE pmab_t.pmab088, 
   pmab088_desc LIKE type_t.chr80, 
   pmab089 LIKE pmab_t.pmab089, 
   pmab089_desc LIKE type_t.chr80, 
   pmab107 LIKE pmab_t.pmab107, 
   pmab108 LIKE pmab_t.pmab108, 
   pmab090 LIKE pmab_t.pmab090, 
   pmab090_desc LIKE type_t.chr80, 
   pmab091 LIKE pmab_t.pmab091, 
   pmab091_desc LIKE type_t.chr80, 
   pmab092 LIKE pmab_t.pmab092, 
   pmab092_desc LIKE type_t.chr80, 
   pmab093 LIKE pmab_t.pmab093, 
   pmab093_desc LIKE type_t.chr80, 
   pmab094 LIKE pmab_t.pmab094, 
   pmab095 LIKE pmab_t.pmab095, 
   pmab096 LIKE pmab_t.pmab096, 
   pmab097 LIKE pmab_t.pmab097, 
   pmab097_desc LIKE type_t.chr80, 
   pmab098 LIKE pmab_t.pmab098, 
   pmab099 LIKE pmab_t.pmab099, 
   pmab100 LIKE pmab_t.pmab100, 
   pmab101 LIKE pmab_t.pmab101, 
   pmab102 LIKE pmab_t.pmab102, 
   pmab030 LIKE pmab_t.pmab030, 
   pmab031 LIKE pmab_t.pmab031, 
   pmab031_desc LIKE type_t.chr80, 
   pmab059 LIKE pmab_t.pmab059, 
   pmab059_desc LIKE type_t.chr80, 
   pmab032 LIKE pmab_t.pmab032, 
   pmab110 LIKE pmab_t.pmab110, 
   pmab033 LIKE pmab_t.pmab033, 
   pmab033_desc LIKE type_t.chr80, 
   pmab034 LIKE pmab_t.pmab034, 
   pmab034_desc LIKE type_t.chr80, 
   pmab053 LIKE pmab_t.pmab053, 
   pmab053_desc LIKE type_t.chr80, 
   pmab054 LIKE pmab_t.pmab054, 
   pmab054_desc LIKE type_t.chr80, 
   pmab035 LIKE pmab_t.pmab035, 
   pmab036 LIKE pmab_t.pmab036, 
   pmab056 LIKE pmab_t.pmab056, 
   pmab056_desc LIKE type_t.chr80, 
   pmab037 LIKE pmab_t.pmab037, 
   pmab037_desc LIKE type_t.chr80, 
   pmab055 LIKE pmab_t.pmab055, 
   pmab055_desc LIKE type_t.chr80, 
   pmab038 LIKE pmab_t.pmab038, 
   pmab038_desc LIKE type_t.chr80, 
   pmab039 LIKE pmab_t.pmab039, 
   pmab039_desc LIKE type_t.chr80, 
   pmab057 LIKE pmab_t.pmab057, 
   pmab058 LIKE pmab_t.pmab058, 
   pmab040 LIKE pmab_t.pmab040, 
   pmab040_desc LIKE type_t.chr80, 
   pmab041 LIKE pmab_t.pmab041, 
   pmab041_desc LIKE type_t.chr80, 
   pmab042 LIKE pmab_t.pmab042, 
   pmab042_desc LIKE type_t.chr80, 
   pmab043 LIKE pmab_t.pmab043, 
   pmab043_desc LIKE type_t.chr80, 
   pmab044 LIKE pmab_t.pmab044, 
   pmab045 LIKE pmab_t.pmab045, 
   pmab046 LIKE pmab_t.pmab046, 
   pmab047 LIKE pmab_t.pmab047, 
   pmab047_desc LIKE type_t.chr80, 
   pmab048 LIKE pmab_t.pmab048, 
   pmab049 LIKE pmab_t.pmab049, 
   pmab050 LIKE pmab_t.pmab050, 
   pmab051 LIKE pmab_t.pmab051, 
   pmab052 LIKE pmab_t.pmab052, 
   pmab071 LIKE pmab_t.pmab071, 
   pmab072 LIKE pmab_t.pmab072, 
   pmab073 LIKE pmab_t.pmab073, 
   pmab060 LIKE pmab_t.pmab060, 
   pmab061 LIKE pmab_t.pmab061, 
   pmab066 LIKE pmab_t.pmab066, 
   pmab062 LIKE pmab_t.pmab062, 
   pmab067 LIKE pmab_t.pmab067, 
   pmab063 LIKE pmab_t.pmab063, 
   pmab068 LIKE pmab_t.pmab068, 
   pmab064 LIKE pmab_t.pmab064, 
   pmab069 LIKE pmab_t.pmab069, 
   pmab065 LIKE pmab_t.pmab065, 
   pmab070 LIKE pmab_t.pmab070, 
   l_total LIKE type_t.chr500, 
   pmab002 LIKE pmab_t.pmab002, 
   pmab003 LIKE pmab_t.pmab003, 
   pmab003_desc LIKE type_t.chr80, 
   pmab004 LIKE pmab_t.pmab004, 
   pmab004_desc LIKE type_t.chr80, 
   pmab005 LIKE pmab_t.pmab005, 
   pmab005_desc LIKE type_t.chr80, 
   pmab006 LIKE pmab_t.pmab006, 
   pmab007 LIKE pmab_t.pmab007, 
   pmab008 LIKE pmab_t.pmab008, 
   pmab009 LIKE pmab_t.pmab009, 
   pmab019 LIKE pmab_t.pmab019, 
   pmab010 LIKE pmab_t.pmab010, 
   pmab020 LIKE pmab_t.pmab020, 
   pmab011 LIKE pmab_t.pmab011, 
   pmab012 LIKE pmab_t.pmab012, 
   pmab013 LIKE pmab_t.pmab013, 
   pmab014 LIKE pmab_t.pmab014, 
   pmab015 LIKE pmab_t.pmab015, 
   pmab016 LIKE pmab_t.pmab016, 
   pmab017 LIKE pmab_t.pmab017, 
   pmab018 LIKE pmab_t.pmab018, 
   ooff013 LIKE type_t.chr500, 
   pmabownid LIKE pmab_t.pmabownid, 
   pmabownid_desc LIKE type_t.chr80, 
   pmabowndp LIKE pmab_t.pmabowndp, 
   pmabowndp_desc LIKE type_t.chr80, 
   pmabcrtid LIKE pmab_t.pmabcrtid, 
   pmabcrtid_desc LIKE type_t.chr80, 
   pmabcrtdp LIKE pmab_t.pmabcrtdp, 
   pmabcrtdp_desc LIKE type_t.chr80, 
   pmabcrtdt LIKE pmab_t.pmabcrtdt, 
   pmabmodid LIKE pmab_t.pmabmodid, 
   pmabmodid_desc LIKE type_t.chr80, 
   pmabmoddt LIKE pmab_t.pmabmoddt
       END RECORD
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD  #查詢方案用陣列 
         b_statepic     LIKE type_t.chr50,
            b_pmab001 LIKE pmab_t.pmab001,
   b_pmab001_desc LIKE type_t.chr80,
   b_pmaal003 LIKE pmaal_t.pmaal003,
   b_pmaal006 LIKE pmaal_t.pmaal006,
   b_pmaa002 LIKE pmaa_t.pmaa002,
   b_pmaa004 LIKE pmaa_t.pmaa004,
   b_pmaa005 LIKE pmaa_t.pmaa005,
   b_pmaa026 LIKE pmaa_t.pmaa026,
   b_pmaa006 LIKE pmaa_t.pmaa006
      END RECORD 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_flag1               LIKE type_t.num5     #判斷是否是由apmm100串apmm101走的新增 是，則值為'1'
DEFINE g_site_t              LIKE type_t.chr10   #一開始進入作業的營運據點
DEFINE g_flag2               LIKE type_t.num5     #判斷是否是由apmm100串apmm101 是，則值為'1'
DEFINE g_ooef019             LIKE ooef_t.ooef019
#end add-point
 
#模組變數(Module Variables)
DEFINE g_pmab_m        type_g_pmab_m  #單頭變數宣告
DEFINE g_pmab_m_t      type_g_pmab_m  #單頭舊值宣告(系統還原用)
DEFINE g_pmab_m_o      type_g_pmab_m  #單頭舊值宣告(其他用途)
DEFINE g_pmab_m_mask_o type_g_pmab_m  #轉換遮罩前資料
DEFINE g_pmab_m_mask_n type_g_pmab_m  #轉換遮罩後資料
 
   DEFINE g_pmab001_t LIKE pmab_t.pmab001
 
   
 
   
 
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
 
{<section id="apmm101.main" >}
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
   LET g_site_t = g_site     #記錄當前登入的營運據點
   
   IF NOT cl_null(g_argv[02]) THEN
      LET g_site = g_argv[02]     
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_pmab_m.pmab001 = g_argv[03]
   END IF
   #161216-00024#1-(S)-mark
   #LET g_ooef019 = ''
   #SELECT ooef019 INTO g_ooef019 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site_t
   #161216-00024#1-(E)-mark
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT pmab001,'','','','','','','',pmab080,pmab081,'',pmab109,'',pmab082,pmab111, 
       pmab083,'',pmab084,'',pmab103,'',pmab104,'',pmab085,pmab086,pmab106,'',pmab087,'',pmab105,'', 
       pmab088,'',pmab089,'',pmab107,pmab108,pmab090,'',pmab091,'',pmab092,'',pmab093,'',pmab094,pmab095, 
       pmab096,pmab097,'',pmab098,pmab099,pmab100,pmab101,pmab102,pmab030,pmab031,'',pmab059,'',pmab032, 
       pmab110,pmab033,'',pmab034,'',pmab053,'',pmab054,'',pmab035,pmab036,pmab056,'',pmab037,'',pmab055, 
       '',pmab038,'',pmab039,'',pmab057,pmab058,pmab040,'',pmab041,'',pmab042,'',pmab043,'',pmab044, 
       pmab045,pmab046,pmab047,'',pmab048,pmab049,pmab050,pmab051,pmab052,pmab071,pmab072,pmab073,pmab060, 
       pmab061,pmab066,pmab062,pmab067,pmab063,pmab068,pmab064,pmab069,pmab065,pmab070,'',pmab002,pmab003, 
       '',pmab004,'',pmab005,'',pmab006,pmab007,pmab008,pmab009,pmab019,pmab010,pmab020,pmab011,pmab012, 
       pmab013,pmab014,pmab015,pmab016,pmab017,pmab018,'',pmabownid,'',pmabowndp,'',pmabcrtid,'',pmabcrtdp, 
       '',pmabcrtdt,pmabmodid,'',pmabmoddt", 
                      " FROM pmab_t",
                      " WHERE pmabent= ? AND pmabsite= ? AND pmab001=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apmm101_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.pmab001,t0.pmab080,t0.pmab081,t0.pmab109,t0.pmab082,t0.pmab111,t0.pmab083, 
       t0.pmab084,t0.pmab103,t0.pmab104,t0.pmab085,t0.pmab086,t0.pmab106,t0.pmab087,t0.pmab105,t0.pmab088, 
       t0.pmab089,t0.pmab107,t0.pmab108,t0.pmab090,t0.pmab091,t0.pmab092,t0.pmab093,t0.pmab094,t0.pmab095, 
       t0.pmab096,t0.pmab097,t0.pmab098,t0.pmab099,t0.pmab100,t0.pmab101,t0.pmab102,t0.pmab030,t0.pmab031, 
       t0.pmab059,t0.pmab032,t0.pmab110,t0.pmab033,t0.pmab034,t0.pmab053,t0.pmab054,t0.pmab035,t0.pmab036, 
       t0.pmab056,t0.pmab037,t0.pmab055,t0.pmab038,t0.pmab039,t0.pmab057,t0.pmab058,t0.pmab040,t0.pmab041, 
       t0.pmab042,t0.pmab043,t0.pmab044,t0.pmab045,t0.pmab046,t0.pmab047,t0.pmab048,t0.pmab049,t0.pmab050, 
       t0.pmab051,t0.pmab052,t0.pmab071,t0.pmab072,t0.pmab073,t0.pmab060,t0.pmab061,t0.pmab066,t0.pmab062, 
       t0.pmab067,t0.pmab063,t0.pmab068,t0.pmab064,t0.pmab069,t0.pmab065,t0.pmab070,t0.pmab002,t0.pmab003, 
       t0.pmab004,t0.pmab005,t0.pmab006,t0.pmab007,t0.pmab008,t0.pmab009,t0.pmab019,t0.pmab010,t0.pmab020, 
       t0.pmab011,t0.pmab012,t0.pmab013,t0.pmab014,t0.pmab015,t0.pmab016,t0.pmab017,t0.pmab018,t0.pmabownid, 
       t0.pmabowndp,t0.pmabcrtid,t0.pmabcrtdp,t0.pmabcrtdt,t0.pmabmodid,t0.pmabmoddt,t1.ooag011 ,t2.ooefl003 , 
       t3.ooail003 ,t4.oocql004 ,t5.xmahl003 ,t6.ooibl004 ,t7.oocql004 ,t8.oojdl003 ,t9.oocql004 ,t10.oocql004 , 
       t11.oocql004 ,t12.oocql004 ,t13.oocql004 ,t14.pmaal004 ,t15.ooag011 ,t16.ooefl003 ,t17.ooail003 , 
       t18.oocql004 ,t19.pmaml003 ,t20.ooibl004 ,t21.oocql004 ,t22.oojdl003 ,t23.oocql004 ,t24.oocql004 , 
       t25.oocql004 ,t26.oocql004 ,t27.oocql004 ,t28.pmaal004 ,t29.pmaal004 ,t30.xmajl003 ,t31.ooail003 , 
       t32.ooag011 ,t33.ooefl003 ,t34.ooag011 ,t35.ooefl003 ,t36.ooag011",
               " FROM pmab_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.pmab081  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.pmab109 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t3 ON t3.ooailent="||g_enterprise||" AND t3.ooail001=t0.pmab083 AND t3.ooail002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t4 ON t4.oocqlent="||g_enterprise||" AND t4.oocql001='238' AND t4.oocql002=t0.pmab103 AND t4.oocql003='"||g_dlang||"' ",
               " LEFT JOIN xmahl_t t5 ON t5.xmahlent="||g_enterprise||" AND t5.xmahl001=t0.pmab104 AND t5.xmahl002='"||g_dlang||"' ",
               " LEFT JOIN ooibl_t t6 ON t6.ooiblent="||g_enterprise||" AND t6.ooibl002=t0.pmab087 AND t6.ooibl003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t7 ON t7.oocqlent="||g_enterprise||" AND t7.oocql001='3111' AND t7.oocql002=t0.pmab105 AND t7.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oojdl_t t8 ON t8.oojdlent="||g_enterprise||" AND t8.oojdl001=t0.pmab088 AND t8.oojdl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t9 ON t9.oocqlent="||g_enterprise||" AND t9.oocql001='295' AND t9.oocql002=t0.pmab089 AND t9.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t10 ON t10.oocqlent="||g_enterprise||" AND t10.oocql001='263' AND t10.oocql002=t0.pmab090 AND t10.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t11 ON t11.oocqlent="||g_enterprise||" AND t11.oocql001='262' AND t11.oocql002=t0.pmab091 AND t11.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t12 ON t12.oocqlent="||g_enterprise||" AND t12.oocql001='262' AND t12.oocql002=t0.pmab092 AND t12.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t13 ON t13.oocqlent="||g_enterprise||" AND t13.oocql001='262' AND t13.oocql002=t0.pmab093 AND t13.oocql003='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t14 ON t14.pmaalent="||g_enterprise||" AND t14.pmaal001=t0.pmab097 AND t14.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t15 ON t15.ooagent="||g_enterprise||" AND t15.ooag001=t0.pmab031  ",
               " LEFT JOIN ooefl_t t16 ON t16.ooeflent="||g_enterprise||" AND t16.ooefl001=t0.pmab059 AND t16.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t17 ON t17.ooailent="||g_enterprise||" AND t17.ooail001=t0.pmab033 AND t17.ooail002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t18 ON t18.oocqlent="||g_enterprise||" AND t18.oocql001='238' AND t18.oocql002=t0.pmab053 AND t18.oocql003='"||g_dlang||"' ",
               " LEFT JOIN pmaml_t t19 ON t19.pmamlent="||g_enterprise||" AND t19.pmaml001=t0.pmab054 AND t19.pmaml002='"||g_dlang||"' ",
               " LEFT JOIN ooibl_t t20 ON t20.ooiblent="||g_enterprise||" AND t20.ooibl002=t0.pmab037 AND t20.ooibl003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t21 ON t21.oocqlent="||g_enterprise||" AND t21.oocql001='3211' AND t21.oocql002=t0.pmab055 AND t21.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oojdl_t t22 ON t22.oojdlent="||g_enterprise||" AND t22.oojdl001=t0.pmab038 AND t22.oojdl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t23 ON t23.oocqlent="||g_enterprise||" AND t23.oocql001='264' AND t23.oocql002=t0.pmab039 AND t23.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t24 ON t24.oocqlent="||g_enterprise||" AND t24.oocql001='263' AND t24.oocql002=t0.pmab040 AND t24.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t25 ON t25.oocqlent="||g_enterprise||" AND t25.oocql001='262' AND t25.oocql002=t0.pmab041 AND t25.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t26 ON t26.oocqlent="||g_enterprise||" AND t26.oocql001='262' AND t26.oocql002=t0.pmab042 AND t26.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t27 ON t27.oocqlent="||g_enterprise||" AND t27.oocql001='262' AND t27.oocql002=t0.pmab043 AND t27.oocql003='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t28 ON t28.pmaalent="||g_enterprise||" AND t28.pmaal001=t0.pmab047 AND t28.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t29 ON t29.pmaalent="||g_enterprise||" AND t29.pmaal001=t0.pmab003 AND t29.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN xmajl_t t30 ON t30.xmajlent="||g_enterprise||" AND t30.xmajl001=t0.pmab004 AND t30.xmajl002='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t31 ON t31.ooailent="||g_enterprise||" AND t31.ooail001=t0.pmab005 AND t31.ooail002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t32 ON t32.ooagent="||g_enterprise||" AND t32.ooag001=t0.pmabownid  ",
               " LEFT JOIN ooefl_t t33 ON t33.ooeflent="||g_enterprise||" AND t33.ooefl001=t0.pmabowndp AND t33.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t34 ON t34.ooagent="||g_enterprise||" AND t34.ooag001=t0.pmabcrtid  ",
               " LEFT JOIN ooefl_t t35 ON t35.ooeflent="||g_enterprise||" AND t35.ooefl001=t0.pmabcrtdp AND t35.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t36 ON t36.ooagent="||g_enterprise||" AND t36.ooag001=t0.pmabmodid  ",
 
               " WHERE t0.pmabent = " ||g_enterprise|| " AND t0.pmabsite = ? AND t0.pmab001 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE apmm101_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apmm101 WITH FORM cl_ap_formpath("apm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apmm101_init()   
 
      #進入選單 Menu (="N")
      CALL apmm101_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_apmm101
      
   END IF 
   
   CLOSE apmm101_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="apmm101.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION apmm101_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
DEFINE l_n   LIKE type_t.num5
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   #定義combobox狀態
   
      CALL cl_set_combo_scc('pmaa002','2014') 
   CALL cl_set_combo_scc('pmab080','36') 
   CALL cl_set_combo_scc('pmab085','8322') 
   CALL cl_set_combo_scc('pmab086','8334') 
   CALL cl_set_combo_scc('pmab107','2085') 
   CALL cl_set_combo_scc('pmab108','2084') 
   CALL cl_set_combo_scc('pmab030','36') 
   CALL cl_set_combo_scc('pmab035','8322') 
   CALL cl_set_combo_scc('pmab036','9936') 
   CALL cl_set_combo_scc('pmab057','2087') 
   CALL cl_set_combo_scc('pmab058','2086') 
   CALL cl_set_combo_scc('pmab071','5051') 
   CALL cl_set_combo_scc('pmab072','5052') 
   CALL cl_set_combo_scc('pmab073','5053') 
   CALL cl_set_combo_scc('pmab002','2033') 
   CALL cl_set_combo_scc('pmab012','2034') 
   CALL cl_set_combo_scc('pmab014','2034') 
   CALL cl_set_combo_scc('pmab016','2034') 
   CALL cl_set_combo_scc('pmab018','2034') 
 
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('status1','50')
   CALL cl_set_combo_scc('b_pmaa002','2014')
   CALL cl_set_combo_scc('b_pmaa004','2015') 
   
   CALL cl_set_combo_lang("pmab082")
   CALL cl_set_combo_lang("pmab032")
   
   CALL cl_set_combo_scc('pmaa002','2014')
   
   CALL apmm101_set_visible()
   
   #若傳入參數交易對象編號不存在對應的資料時，直接進入新增狀態
   IF NOT cl_null(g_argv[03]) THEN
      LET l_n = 0
      SELECT COUNT(*) INTO l_n FROM pmab_t WHERE pmabent = g_enterprise
           AND pmabsite = g_site AND pmab001 = g_pmab_m.pmab001
      IF l_n = 0 THEN
         #進入新增
         LET gwin_curr = ui.Window.getCurrent()
         LET gfrm_curr = gwin_curr.getForm()
         LET g_main_hidden = 1
         LET g_flag1 = 1
         CALL apmm101_insert()
      END IF
      LET g_flag2 = 1
   END IF
   
   #161216-00024#1-(S)-add
   #切換據點需重新取得所屬稅區編號(ooef019)
   LET g_ooef019 = ''
   IF g_site = 'ALL' THEN
      SELECT ooef019 INTO g_ooef019 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site_t
   ELSE
      SELECT ooef019 INTO g_ooef019 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
   END IF
   #161216-00024#1-(E)-add
   #end add-point
   
   #根據外部參數進行搜尋
   CALL apmm101_default_search()
 
END FUNCTION
 
{</section>}
 
{<section id="apmm101.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apmm101_ui_dialog() 
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
   DEFINE l_pmaa027 LIKE pmaa_t.pmaa027
   DEFINE l_pmaa002 LIKE pmaa_t.pmaa002
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
   #應用 a42 樣板自動產生(Version:3)
   #進入程式時預設執行的動作
   CASE g_actdefault
      WHEN "insert"
         LET g_action_choice="insert"
         LET g_actdefault = ""
         IF cl_auth_chk_act("insert") THEN
            CALL apmm101_insert()
            #add-point:ON ACTION insert name="menu.default.insert"
            
            #END add-point
         END IF
 
      #add-point:action default自訂 name="ui_dialog.action_default"
      
      #end add-point
      OTHERWISE
   END CASE
 
 
 
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   #傳入參數，直接顯示主畫面
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
         INITIALIZE g_pmab_m.* TO NULL
         LET g_wc  = ' 1=2'
         LET g_action_choice = ""
         CALL apmm101_init()
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
               CALL apmm101_browser_fill(g_wc,"")
               CALL cl_navigator_setting(g_current_idx, g_current_cnt)
               
               #還原為原本指定筆數
               IF g_current_row > 0 THEN
                  LET g_current_idx = g_current_row
               END IF
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL apmm101_fetch("")   
               END IF               
               #add-point:ui_dialog段 before menu name="ui_dialog.before_menu"
               #若執行集團級程式，則不開放切換營運中心的功能
               #--20150615--POLLY-MOD-執行集團級程式，信用額度不可維護
               #IF g_prog = 'apmm101' OR g_prog = 'apmm201' OR g_prog = 'axmm201' THEN                    #160705-00042#10 160713 by sakura mark      
               IF g_prog MATCHES 'apmm101' OR g_prog MATCHES 'apmm201' OR g_prog MATCHES 'axmm201' THEN   #160705-00042#10 160713 by sakura add
                  CALL cl_set_act_visible("logistics,jdsz", FALSE)
               ELSE
                  CALL cl_set_act_visible("logistics,jdsz", TRUE)
               END IF
               #end add-point
            
 
 
               
            #第一筆資料
            ON ACTION first
               CALL apmm101_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL apmm101_fetch("N")
               LET g_current_row = g_current_idx
            
            #指定筆資料
            ON ACTION jump
               CALL apmm101_fetch("/")
               LET g_current_row = g_current_idx
            
            #上一筆資料
            ON ACTION previous
               CALL apmm101_fetch("P")
               LET g_current_row = g_current_idx
            
            #最後筆資料
            ON ACTION last 
               CALL apmm101_fetch("L")  
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
                  CALL apmm101_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL apmm101_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL apmm101_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
            
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL apmm101_modify()
               #add-point:ON ACTION modify name="menu2.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION jdsz
            LET g_action_choice="jdsz"
            IF cl_auth_chk_act("jdsz") THEN
               
               #add-point:ON ACTION jdsz name="menu2.jdsz"
               IF NOT cl_null(g_pmab_m.pmab001) THEN
                  CALL apmm101_jdsz()
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL apmm101_delete()
               #add-point:ON ACTION delete name="menu2.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL apmm101_insert()
               #add-point:ON ACTION insert name="menu2.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu2.output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu2.quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL apmm101_reproduce()
               #add-point:ON ACTION reproduce name="menu2.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL apmm101_query()
               #add-point:ON ACTION query name="menu2.query"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION aooi350_01
            LET g_action_choice="aooi350_01"
            IF cl_auth_chk_act("aooi350_01") THEN
               
               #add-point:ON ACTION aooi350_01 name="menu2.aooi350_01"
               IF NOT cl_null(g_pmab_m.pmab001) THEN
                  LET l_pmaa027 = ' '
                  SELECT pmaa027 INTO l_pmaa027 FROM pmaa_t WHERE pmaaent = g_enterprise AND pmaa001 = g_pmab_m.pmab001
                  CALL aooi350_01(l_pmaa027)
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION aooi350_02
            LET g_action_choice="aooi350_02"
            IF cl_auth_chk_act("aooi350_02") THEN
               
               #add-point:ON ACTION aooi350_02 name="menu2.aooi350_02"
               IF NOT cl_null(g_pmab_m.pmab001) THEN
                  LET l_pmaa027 = ' '
                  SELECT pmaa027 INTO l_pmaa027 FROM pmaa_t WHERE pmaaent = g_enterprise AND pmaa001 = g_pmab_m.pmab001
                  CALL aooi350_02(l_pmaa027)
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_apmi005
            LET g_action_choice="open_apmi005"
            IF cl_auth_chk_act("open_apmi005") THEN
               
               #add-point:ON ACTION open_apmi005 name="menu2.open_apmi005"
               IF NOT cl_null(g_pmab_m.pmab001) THEN
                  SELECT pmaa002 INTO l_pmaa002 FROM pmaa_t WHERE pmaaent = g_enterprise AND pmaa001 = g_pmab_m.pmab001
                  CASE l_pmaa002
                     WHEN '1' LET la_param.prog = 'apmi100'
                              LET la_param.param[1] = g_pmab_m.pmab001
                              LET ls_js = util.JSON.stringify( la_param )                      
                     WHEN '2' LET la_param.prog = 'axmi100'
                              LET la_param.param[1] = g_pmab_m.pmab001
                              LET ls_js = util.JSON.stringify( la_param )
                     WHEN '3' LET la_param.prog = 'apmi005'
                              LET la_param.param[1] = g_pmab_m.pmab001
                              LET ls_js = util.JSON.stringify( la_param )
                  END CASE
                  #CALL cl_cmdrun_wait(l_cmd)
                  CALL cl_cmdrun(ls_js)
               END IF
               #END add-point
               
            END IF
 
 
 
 
            
            
            
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL apmm101_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.menu.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL apmm101_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.menu.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL apmm101_set_pk_array()
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
                  CALL apmm101_fetch("")
 
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
                  CALL apmm101_browser_fill(g_wc,"")
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
                  CALL apmm101_fetch("")   
               END IF          
               CALL cl_notice()
               
               #add-point:ui_dialog段before name="ui_dialog.b_dialog"
               #若執行集團級程式，則不開放切換營運中心的功能
               #--20150615--POLLY-MOD-執行集團級程式，信用額度不可維護
               #IF g_prog = 'apmm101' OR g_prog = 'apmm201' OR g_prog = 'axmm201' THEN                    #160705-00042#10 160713 by sakura mark     
               IF g_prog MATCHES 'apmm101' OR g_prog MATCHES 'apmm201' OR g_prog MATCHES 'axmm201' THEN   #160705-00042#10 160713 by sakura add
                  CALL cl_set_act_visible("logistics,jdsz", FALSE)
               ELSE
                  CALL cl_set_act_visible("logistics,jdsz", TRUE)
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
               CALL apmm101_filter()
               EXIT DIALOG
 
 
 
            
            #第一筆資料
            ON ACTION first
               CALL apmm101_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL apmm101_fetch("N")
               LET g_current_row = g_current_idx
         
            #指定筆資料
            ON ACTION jump
               CALL apmm101_fetch("/")
               LET g_current_row = g_current_idx
         
            #上一筆資料
            ON ACTION previous
               CALL apmm101_fetch("P")
               LET g_current_row = g_current_idx
          
            #最後筆資料
            ON ACTION last 
               CALL apmm101_fetch("L")  
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
                  CALL apmm101_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL apmm101_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL apmm101_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
               
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL apmm101_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION jdsz
            LET g_action_choice="jdsz"
            IF cl_auth_chk_act("jdsz") THEN
               
               #add-point:ON ACTION jdsz name="menu.jdsz"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL apmm101_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL apmm101_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
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
               CALL apmm101_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL apmm101_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION aooi350_01
            LET g_action_choice="aooi350_01"
            IF cl_auth_chk_act("aooi350_01") THEN
               
               #add-point:ON ACTION aooi350_01 name="menu.aooi350_01"
               IF NOT cl_null(g_pmab_m.pmab001) THEN
                  LET l_pmaa027 = ' '
                  SELECT pmaa027 INTO l_pmaa027 FROM pmaa_t WHERE pmaaent = g_enterprise AND pmaa001 = g_pmab_m.pmab001
                  CALL aooi350_01(l_pmaa027)
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION aooi350_02
            LET g_action_choice="aooi350_02"
            IF cl_auth_chk_act("aooi350_02") THEN
               
               #add-point:ON ACTION aooi350_02 name="menu.aooi350_02"
               IF NOT cl_null(g_pmab_m.pmab001) THEN
                  LET l_pmaa027 = ' '
                  SELECT pmaa027 INTO l_pmaa027 FROM pmaa_t WHERE pmaaent = g_enterprise AND pmaa001 = g_pmab_m.pmab001
                  CALL aooi350_02(l_pmaa027)
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_apmi005
            LET g_action_choice="open_apmi005"
            IF cl_auth_chk_act("open_apmi005") THEN
               
               #add-point:ON ACTION open_apmi005 name="menu.open_apmi005"
               IF NOT cl_null(g_pmab_m.pmab001) THEN
                  SELECT pmaa002 INTO l_pmaa002 FROM pmaa_t WHERE pmaaent = g_enterprise AND pmaa001 = g_pmab_m.pmab001
                  CASE l_pmaa002
                     WHEN '1' LET la_param.prog = 'apmi100'
                              LET la_param.param[1] = g_pmab_m.pmab001
                              LET ls_js = util.JSON.stringify( la_param )                      
                     WHEN '2' LET la_param.prog = 'axmi100'
                              LET la_param.param[1] = g_pmab_m.pmab001
                              LET ls_js = util.JSON.stringify( la_param )
                     WHEN '3' LET la_param.prog = 'apmi005'
                              LET la_param.param[1] = g_pmab_m.pmab001
                              LET ls_js = util.JSON.stringify( la_param )
                  END CASE
                  #CALL cl_cmdrun_wait(l_cmd)
                  CALL cl_cmdrun(ls_js)
               END IF
               #END add-point
               
            END IF
 
 
 
 
            
            
 
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL apmm101_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL apmm101_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL apmm101_set_pk_array()
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
 
{<section id="apmm101.browser_fill" >}
#應用 a29 樣板自動產生(Version:15)
#+ 瀏覽頁簽資料填充(一般單檔)
PRIVATE FUNCTION apmm101_browser_fill(p_wc,ps_page_action) 
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
   
   LET l_searchcol = "pmab001"
 
   LET p_wc = p_wc.trim() #當查詢按下Q時 按下放棄 g_wc = "  " 所以要清掉空白
   IF cl_null(p_wc) THEN  #p_wc 查詢條件
      LET p_wc = " 1=1 " 
   END IF
   #add-point:browser_fill段wc控制 name="browser_fill.wc"
   LET p_wc = cl_replace_str(p_wc, 'status1', 'pmaastus')
   IF NOT cl_null(g_argv[1]) THEN
      CASE g_argv[1] 
         WHEN '1' LET p_wc = p_wc," AND pmab001 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaa002 = '1' OR pmaa002 = '3' AND pmaaent = ",g_enterprise,") " #160905-00007#11 Add
         WHEN '2' LET p_wc = p_wc," AND pmab001 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaa002 = '2' OR pmaa002 = '3' AND pmaaent = ",g_enterprise,") " #160905-00007#11 Add
         #WHEN '3' LET p_wc = p_wc," AND pmab001 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaa002 = '1' OR pmaa002 = '2' OR pmaa002 = '3' ) "
      END CASE
   END IF
   #end add-point
 
   LET g_sql = " SELECT COUNT(1) FROM pmab_t ",
               "  ",
               "  ",
               " WHERE pmabent = " ||g_enterprise|| " AND pmabsite = '" ||g_site|| "' AND ", 
               p_wc CLIPPED, cl_sql_add_filter("pmab_t")
                
   #add-point:browser_fill段cnt_sql name="browser_fill.cnt_sql"
   LET g_sql = " SELECT COUNT(*) FROM pmab_t,pmaa_t ",
               "  ",
               "  ",
               " WHERE pmaaent = pmabetn AND pmaa001 = pmab001 AND pmabent = '" ||g_enterprise|| "' AND pmabsite = '" ||g_site|| "' AND ", 
               p_wc CLIPPED, cl_sql_add_filter("pmab_t")
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
      INITIALIZE g_pmab_m.* TO NULL
      CALL g_browser.clear()
      LET g_cnt = 1
      LET ls_wc = p_wc
   ELSE
      LET ls_wc = g_add_browse
      LET g_cnt = g_current_idx
   END IF
   
   LET g_sql = " SELECT t0.pmabstus,t0.pmab001,t1.pmaal004",
               " FROM pmab_t t0 ",
               "  ",
                              " LEFT JOIN pmaal_t t1 ON t1.pmaalent="||g_enterprise||" AND t1.pmaal001=t0.pmab001 AND t1.pmaal002='"||g_dlang||"' ",
 
               " WHERE t0.pmabent = " ||g_enterprise|| " AND t0.pmabsite = '" ||g_site|| "' AND ", ls_wc, cl_sql_add_filter("pmab_t")
   #add-point:browser_fill段fill_wc name="browser_fill.fill_wc"
   LET g_sql = " SELECT t0.pmabstus,t0.pmab001,t1.pmaal004",
               " FROM pmab_t t0 ",
               "  ",
                              " LEFT JOIN pmaal_t t1 ON t1.pmaalent='"||g_enterprise||"' AND t1.pmaal001=t0.pmab001 AND t1.pmaal002='"||g_lang||"' ,",
               "pmaa_t t2",   
               " WHERE t0.pmabent = t2.pmaaent AND t0.pmab001 = t2.pmaa001 AND t0.pmabent = '" ||g_enterprise|| "' AND t0.pmabsite = '" ||g_site|| "' AND ", ls_wc, cl_sql_add_filter("pmab_t")
   #end add-point 
   LET g_sql = g_sql, " ORDER BY ",l_searchcol," ",g_order
   #add-point:browser_fill段before_pre name="browser_fill.before_pre"
   
   #end add-point                    
 
   #LET g_sql = cl_sql_add_tabid(g_sql,"pmab_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_pmab001,g_browser[g_cnt].b_pmab001_desc 
 
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
      LET g_ref_fields[1] = g_browser[g_cnt].b_pmab001
      #modify--2015/06/25 By shiun--(S)
      CALL ap_ref_array2(g_ref_fields,"SELECT pmaal003,pmaal006 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_lang||"'","") RETURNING g_rtn_fields
      LET g_browser[g_cnt].b_pmaal003 = '', g_rtn_fields[1] , ''
      LET g_browser[g_cnt].b_pmaal006 = '', g_rtn_fields[2] , ''
      DISPLAY BY NAME g_browser[g_cnt].b_pmaal003
      DISPLAY BY NAME g_browser[g_cnt].b_pmaal006
      #modify--2015/06/25 By shiun--(E)
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_browser[g_cnt].b_pmab001
      CALL ap_ref_array2(g_ref_fields,"SELECT pmaa002,pmaa004,pmaa005,pmaa026,pmaa006 FROM pmaa_t WHERE pmaaent='"||g_enterprise||"' AND pmaa001=? ","") RETURNING g_rtn_fields
      LET g_browser[g_cnt].b_pmaa002 = '', g_rtn_fields[1] , ''
      LET g_browser[g_cnt].b_pmaa004 = '', g_rtn_fields[2] , ''
      LET g_browser[g_cnt].b_pmaa005 = '', g_rtn_fields[3] , ''
      LET g_browser[g_cnt].b_pmaa026 = '', g_rtn_fields[4] , ''
      LET g_browser[g_cnt].b_pmaa006 = '', g_rtn_fields[5] , ''
      DISPLAY BY NAME g_browser[g_cnt].b_pmaa002,g_browser[g_cnt].b_pmaa004,g_browser[g_cnt].b_pmaa005,g_browser[g_cnt].b_pmaa026,g_browser[g_cnt].b_pmaa006
         #end add-point
         
         #遮罩相關處理
         CALL apmm101_browser_mask()
         
         
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
   
   IF cl_null(g_browser[g_cnt].b_pmab001) THEN
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
   CALL apmm101_set_act_visible()
   CALL apmm101_set_act_no_visible()
   #end add-point   
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apmm101.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION apmm101_construct()
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
   INITIALIZE g_pmab_m.* TO NULL
   INITIALIZE g_wc TO NULL
   LET g_current_row = 1
 
   LET g_qryparam.state = "c"
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #螢幕上取條件
      CONSTRUCT BY NAME g_wc ON pmab001,pmaal004,pmaal005,pmaa003,pmaal003,pmaal006,status1,pmab080, 
          pmab081,pmab109,pmab082,pmab111,pmab083,pmab084,pmab103,pmab104,pmab085,pmab086,pmab106,pmab087, 
          pmab105,pmab088,pmab089,pmab107,pmab108,pmab090,pmab091,pmab092,pmab093,pmab094,pmab095,pmab096, 
          pmab097,pmab098,pmab099,pmab100,pmab101,pmab102,pmab030,pmab031,pmab059,pmab032,pmab110,pmab033, 
          pmab034,pmab053,pmab054,pmab035,pmab036,pmab056,pmab037,pmab055,pmab038,pmab039,pmab057,pmab058, 
          pmab040,pmab041,pmab042,pmab043,pmab044,pmab045,pmab046,pmab047,pmab048,pmab049,pmab050,pmab051, 
          pmab052,pmab071,pmab072,pmab073,pmab060,pmab061,pmab066,pmab062,pmab067,pmab063,pmab068,pmab064, 
          pmab069,pmab065,pmab070,l_total,pmab002,pmab003,pmab004,pmab005,pmab006,pmab007,pmab008,pmab009, 
          pmab019,pmab010,pmab020,pmab011,pmab012,pmab013,pmab014,pmab015,pmab016,pmab017,pmab018,pmabownid, 
          pmabowndp,pmabcrtid,pmabcrtdp,pmabcrtdt,pmabmodid,pmabmoddt
      
         BEFORE CONSTRUCT                                    
            #add-point:cs段more_construct name="cs.before_construct"
            
            #end add-point             
      
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<pmabcrtdt>>----
         AFTER FIELD pmabcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<pmabmoddt>>----
         AFTER FIELD pmabmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<pmabcnfdt>>----
         
         #----<<pmabpstdt>>----
 
 
 
      
         #一般欄位
                  #Ctrlp:construct.c.pmab001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab001
            #add-point:ON ACTION controlp INFIELD pmab001 name="construct.c.pmab001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL   #15/08/12 Sarah add
            LET g_qryparam.state = 'c'        #15/08/12 Sarah add
            LET g_qryparam.reqry = FALSE
            CASE g_argv[1] 
               WHEN '1' LET g_qryparam.where=" (pmaa002 = '1' OR pmaa002 = '3') "
               WHEN '2' LET g_qryparam.where=" (pmaa002 = '2' OR pmaa002 = '3') "
            END CASE
            LET g_qryparam.arg1 = g_site                     #161212-00009#1 add
           #CALL q_pmaa001_4()                   #呼叫開窗   #161212-00009#1 mark
            CALL q_pmab001_2()                   #呼叫開窗   #161212-00009#1 add
            LET g_qryparam.where=" "
            DISPLAY g_qryparam.return1 TO pmab001  #顯示到畫面上

            NEXT FIELD pmab001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab001
            #add-point:BEFORE FIELD pmab001 name="construct.b.pmab001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab001
            
            #add-point:AFTER FIELD pmab001 name="construct.a.pmab001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaal004
            #add-point:BEFORE FIELD pmaal004 name="construct.b.pmaal004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaal004
            
            #add-point:AFTER FIELD pmaal004 name="construct.a.pmaal004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaal004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaal004
            #add-point:ON ACTION controlp INFIELD pmaal004 name="construct.c.pmaal004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaal005
            #add-point:BEFORE FIELD pmaal005 name="construct.b.pmaal005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaal005
            
            #add-point:AFTER FIELD pmaal005 name="construct.a.pmaal005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaal005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaal005
            #add-point:ON ACTION controlp INFIELD pmaal005 name="construct.c.pmaal005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa003
            #add-point:BEFORE FIELD pmaa003 name="construct.b.pmaa003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa003
            
            #add-point:AFTER FIELD pmaa003 name="construct.a.pmaa003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa003
            #add-point:ON ACTION controlp INFIELD pmaa003 name="construct.c.pmaa003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaal003
            #add-point:BEFORE FIELD pmaal003 name="construct.b.pmaal003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaal003
            
            #add-point:AFTER FIELD pmaal003 name="construct.a.pmaal003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaal003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaal003
            #add-point:ON ACTION controlp INFIELD pmaal003 name="construct.c.pmaal003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaal006
            #add-point:BEFORE FIELD pmaal006 name="construct.b.pmaal006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaal006
            
            #add-point:AFTER FIELD pmaal006 name="construct.a.pmaal006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaal006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaal006
            #add-point:ON ACTION controlp INFIELD pmaal006 name="construct.c.pmaal006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD status1
            #add-point:BEFORE FIELD status1 name="construct.b.status1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD status1
            
            #add-point:AFTER FIELD status1 name="construct.a.status1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.status1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD status1
            #add-point:ON ACTION controlp INFIELD status1 name="construct.c.status1"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab080
            #add-point:BEFORE FIELD pmab080 name="construct.b.pmab080"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab080
            
            #add-point:AFTER FIELD pmab080 name="construct.a.pmab080"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab080
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab080
            #add-point:ON ACTION controlp INFIELD pmab080 name="construct.c.pmab080"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmab081
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab081
            #add-point:ON ACTION controlp INFIELD pmab081 name="construct.c.pmab081"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL   #15/08/12 Sarah add
            LET g_qryparam.state = 'c'        #15/08/12 Sarah add
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmab081  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO oofa011 #全名 

            NEXT FIELD pmab081                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab081
            #add-point:BEFORE FIELD pmab081 name="construct.b.pmab081"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab081
            
            #add-point:AFTER FIELD pmab081 name="construct.a.pmab081"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab109
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab109
            #add-point:ON ACTION controlp INFIELD pmab109 name="construct.c.pmab109"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmab109  #顯示到畫面上
            NEXT FIELD pmab109                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab109
            #add-point:BEFORE FIELD pmab109 name="construct.b.pmab109"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab109
            
            #add-point:AFTER FIELD pmab109 name="construct.a.pmab109"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab082
            #add-point:BEFORE FIELD pmab082 name="construct.b.pmab082"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab082
            
            #add-point:AFTER FIELD pmab082 name="construct.a.pmab082"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab082
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab082
            #add-point:ON ACTION controlp INFIELD pmab082 name="construct.c.pmab082"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab111
            #add-point:BEFORE FIELD pmab111 name="construct.b.pmab111"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab111
            
            #add-point:AFTER FIELD pmab111 name="construct.a.pmab111"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab111
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab111
            #add-point:ON ACTION controlp INFIELD pmab111 name="construct.c.pmab111"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmab083
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab083
            #add-point:ON ACTION controlp INFIELD pmab083 name="construct.c.pmab083"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL   #15/08/12 Sarah add
            LET g_qryparam.state = 'c'        #15/08/12 Sarah add
            LET g_qryparam.reqry = FALSE
            IF g_site = 'ALL' THEN
               LET g_qryparam.arg1 = g_site_t
            ELSE
               LET g_qryparam.arg1 = g_site
            END IF
            
            CALL q_ooaj002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmab083  #顯示到畫面上

            NEXT FIELD pmab083                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab083
            #add-point:BEFORE FIELD pmab083 name="construct.b.pmab083"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab083
            
            #add-point:AFTER FIELD pmab083 name="construct.a.pmab083"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab084
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab084
            #add-point:ON ACTION controlp INFIELD pmab084 name="construct.c.pmab084"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL   #15/08/12 Sarah add
            LET g_qryparam.state = 'c'        #15/08/12 Sarah add
            LET g_qryparam.reqry = FALSE
            IF g_site = 'ALL' THEN 
               LET g_qryparam.arg1 = g_site_t
            ELSE
               LET g_qryparam.arg1 = g_site
            END IF
            CALL q_oodb002_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmab084  #顯示到畫面上
            LET g_qryparam.arg1 = ''

            NEXT FIELD pmab084                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab084
            #add-point:BEFORE FIELD pmab084 name="construct.b.pmab084"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab084
            
            #add-point:AFTER FIELD pmab084 name="construct.a.pmab084"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab103
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab103
            #add-point:ON ACTION controlp INFIELD pmab103 name="construct.c.pmab103"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL   #15/08/12 Sarah add
            LET g_qryparam.state = 'c'        #15/08/12 Sarah add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '238'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmab103  #顯示到畫面上

            NEXT FIELD pmab103                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab103
            #add-point:BEFORE FIELD pmab103 name="construct.b.pmab103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab103
            
            #add-point:AFTER FIELD pmab103 name="construct.a.pmab103"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab104
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab104
            #add-point:ON ACTION controlp INFIELD pmab104 name="construct.c.pmab104"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_xmah001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmab104  #顯示到畫面上

            NEXT FIELD pmab104                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab104
            #add-point:BEFORE FIELD pmab104 name="construct.b.pmab104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab104
            
            #add-point:AFTER FIELD pmab104 name="construct.a.pmab104"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab085
            #add-point:BEFORE FIELD pmab085 name="construct.b.pmab085"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab085
            
            #add-point:AFTER FIELD pmab085 name="construct.a.pmab085"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab085
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab085
            #add-point:ON ACTION controlp INFIELD pmab085 name="construct.c.pmab085"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab086
            #add-point:BEFORE FIELD pmab086 name="construct.b.pmab086"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab086
            
            #add-point:AFTER FIELD pmab086 name="construct.a.pmab086"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab086
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab086
            #add-point:ON ACTION controlp INFIELD pmab086 name="construct.c.pmab086"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmab106
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab106
            #add-point:ON ACTION controlp INFIELD pmab106 name="construct.c.pmab106"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
		 	   #給予arg
            LET g_qryparam.arg1 = g_ooef019 #
            LET g_qryparam.arg2 = "2" 
            CALL q_isac002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmab106  #顯示到畫面上

            NEXT FIELD pmab106                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab106
            #add-point:BEFORE FIELD pmab106 name="construct.b.pmab106"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab106
            
            #add-point:AFTER FIELD pmab106 name="construct.a.pmab106"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab087
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab087
            #add-point:ON ACTION controlp INFIELD pmab087 name="construct.c.pmab087"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = '2'
            CALL q_pmad002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmab087  #顯示到畫面上
            
            NEXT FIELD pmab087                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab087
            #add-point:BEFORE FIELD pmab087 name="construct.b.pmab087"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab087
            
            #add-point:AFTER FIELD pmab087 name="construct.a.pmab087"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab105
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab105
            #add-point:ON ACTION controlp INFIELD pmab105 name="construct.c.pmab105"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = "3111"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmab105  #顯示到畫面上

            NEXT FIELD pmab105                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab105
            #add-point:BEFORE FIELD pmab105 name="construct.b.pmab105"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab105
            
            #add-point:AFTER FIELD pmab105 name="construct.a.pmab105"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab088
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab088
            #add-point:ON ACTION controlp INFIELD pmab088 name="construct.c.pmab088"
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
            DISPLAY g_qryparam.return1 TO pmab088  #顯示到畫面上

            NEXT FIELD pmab088                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab088
            #add-point:BEFORE FIELD pmab088 name="construct.b.pmab088"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab088
            
            #add-point:AFTER FIELD pmab088 name="construct.a.pmab088"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab089
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab089
            #add-point:ON ACTION controlp INFIELD pmab089 name="construct.c.pmab089"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL   #15/08/12 Sarah add
            LET g_qryparam.state = 'c'        #15/08/12 Sarah add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '295'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmab089  #顯示到畫面上

            NEXT FIELD pmab089                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab089
            #add-point:BEFORE FIELD pmab089 name="construct.b.pmab089"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab089
            
            #add-point:AFTER FIELD pmab089 name="construct.a.pmab089"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab107
            #add-point:BEFORE FIELD pmab107 name="construct.b.pmab107"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab107
            
            #add-point:AFTER FIELD pmab107 name="construct.a.pmab107"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab107
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab107
            #add-point:ON ACTION controlp INFIELD pmab107 name="construct.c.pmab107"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab108
            #add-point:BEFORE FIELD pmab108 name="construct.b.pmab108"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab108
            
            #add-point:AFTER FIELD pmab108 name="construct.a.pmab108"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab108
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab108
            #add-point:ON ACTION controlp INFIELD pmab108 name="construct.c.pmab108"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmab090
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab090
            #add-point:ON ACTION controlp INFIELD pmab090 name="construct.c.pmab090"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL   #15/08/12 Sarah add
            LET g_qryparam.state = 'c'        #15/08/12 Sarah add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '263'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmab090  #顯示到畫面上

            NEXT FIELD pmab090                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab090
            #add-point:BEFORE FIELD pmab090 name="construct.b.pmab090"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab090
            
            #add-point:AFTER FIELD pmab090 name="construct.a.pmab090"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab091
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab091
            #add-point:ON ACTION controlp INFIELD pmab091 name="construct.c.pmab091"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL   #15/08/12 Sarah add
            LET g_qryparam.state = 'c'        #15/08/12 Sarah add
            LET g_qryparam.reqry = FALSE
            CALL q_pmab091()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmab091  #顯示到畫面上

            NEXT FIELD pmab091                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab091
            #add-point:BEFORE FIELD pmab091 name="construct.b.pmab091"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab091
            
            #add-point:AFTER FIELD pmab091 name="construct.a.pmab091"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab092
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab092
            #add-point:ON ACTION controlp INFIELD pmab092 name="construct.c.pmab092"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL   #15/08/12 Sarah add
            LET g_qryparam.state = 'c'        #15/08/12 Sarah add
            LET g_qryparam.reqry = FALSE
            CALL q_pmab092()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmab092  #顯示到畫面上

            NEXT FIELD pmab092                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab092
            #add-point:BEFORE FIELD pmab092 name="construct.b.pmab092"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab092
            
            #add-point:AFTER FIELD pmab092 name="construct.a.pmab092"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab093
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab093
            #add-point:ON ACTION controlp INFIELD pmab093 name="construct.c.pmab093"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL   #15/08/12 Sarah add
            LET g_qryparam.state = 'c'        #15/08/12 Sarah add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '262'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmab093  #顯示到畫面上

            NEXT FIELD pmab093                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab093
            #add-point:BEFORE FIELD pmab093 name="construct.b.pmab093"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab093
            
            #add-point:AFTER FIELD pmab093 name="construct.a.pmab093"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab094
            #add-point:BEFORE FIELD pmab094 name="construct.b.pmab094"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab094
            
            #add-point:AFTER FIELD pmab094 name="construct.a.pmab094"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab094
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab094
            #add-point:ON ACTION controlp INFIELD pmab094 name="construct.c.pmab094"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab095
            #add-point:BEFORE FIELD pmab095 name="construct.b.pmab095"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab095
            
            #add-point:AFTER FIELD pmab095 name="construct.a.pmab095"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab095
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab095
            #add-point:ON ACTION controlp INFIELD pmab095 name="construct.c.pmab095"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab096
            #add-point:BEFORE FIELD pmab096 name="construct.b.pmab096"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab096
            
            #add-point:AFTER FIELD pmab096 name="construct.a.pmab096"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab096
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab096
            #add-point:ON ACTION controlp INFIELD pmab096 name="construct.c.pmab096"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmab097
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab097
            #add-point:ON ACTION controlp INFIELD pmab097 name="construct.c.pmab097"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL   #15/08/12 Sarah add
            LET g_qryparam.state = 'c'        #15/08/12 Sarah add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where=" (pmaa002 = '1' OR pmaa002 = '3') "
            CALL q_pmaa001_4()                           #呼叫開窗
            LET g_qryparam.where=" "
            DISPLAY g_qryparam.return1 TO pmab097  #顯示到畫面上

            NEXT FIELD pmab097                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab097
            #add-point:BEFORE FIELD pmab097 name="construct.b.pmab097"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab097
            
            #add-point:AFTER FIELD pmab097 name="construct.a.pmab097"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab098
            #add-point:BEFORE FIELD pmab098 name="construct.b.pmab098"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab098
            
            #add-point:AFTER FIELD pmab098 name="construct.a.pmab098"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab098
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab098
            #add-point:ON ACTION controlp INFIELD pmab098 name="construct.c.pmab098"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab099
            #add-point:BEFORE FIELD pmab099 name="construct.b.pmab099"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab099
            
            #add-point:AFTER FIELD pmab099 name="construct.a.pmab099"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab099
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab099
            #add-point:ON ACTION controlp INFIELD pmab099 name="construct.c.pmab099"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab100
            #add-point:BEFORE FIELD pmab100 name="construct.b.pmab100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab100
            
            #add-point:AFTER FIELD pmab100 name="construct.a.pmab100"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab100
            #add-point:ON ACTION controlp INFIELD pmab100 name="construct.c.pmab100"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab101
            #add-point:BEFORE FIELD pmab101 name="construct.b.pmab101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab101
            
            #add-point:AFTER FIELD pmab101 name="construct.a.pmab101"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab101
            #add-point:ON ACTION controlp INFIELD pmab101 name="construct.c.pmab101"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab102
            #add-point:BEFORE FIELD pmab102 name="construct.b.pmab102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab102
            
            #add-point:AFTER FIELD pmab102 name="construct.a.pmab102"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab102
            #add-point:ON ACTION controlp INFIELD pmab102 name="construct.c.pmab102"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab030
            #add-point:BEFORE FIELD pmab030 name="construct.b.pmab030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab030
            
            #add-point:AFTER FIELD pmab030 name="construct.a.pmab030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab030
            #add-point:ON ACTION controlp INFIELD pmab030 name="construct.c.pmab030"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmab031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab031
            #add-point:ON ACTION controlp INFIELD pmab031 name="construct.c.pmab031"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL   #15/08/12 Sarah add
            LET g_qryparam.state = 'c'        #15/08/12 Sarah add
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmab031  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO oofa011 #全名 

            NEXT FIELD pmab031                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab031
            #add-point:BEFORE FIELD pmab031 name="construct.b.pmab031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab031
            
            #add-point:AFTER FIELD pmab031 name="construct.a.pmab031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab059
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab059
            #add-point:ON ACTION controlp INFIELD pmab059 name="construct.c.pmab059"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmab059  #顯示到畫面上
            NEXT FIELD pmab059                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab059
            #add-point:BEFORE FIELD pmab059 name="construct.b.pmab059"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab059
            
            #add-point:AFTER FIELD pmab059 name="construct.a.pmab059"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab032
            #add-point:BEFORE FIELD pmab032 name="construct.b.pmab032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab032
            
            #add-point:AFTER FIELD pmab032 name="construct.a.pmab032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab032
            #add-point:ON ACTION controlp INFIELD pmab032 name="construct.c.pmab032"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab110
            #add-point:BEFORE FIELD pmab110 name="construct.b.pmab110"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab110
            
            #add-point:AFTER FIELD pmab110 name="construct.a.pmab110"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab110
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab110
            #add-point:ON ACTION controlp INFIELD pmab110 name="construct.c.pmab110"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmab033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab033
            #add-point:ON ACTION controlp INFIELD pmab033 name="construct.c.pmab033"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL   #15/08/12 Sarah add
            LET g_qryparam.state = 'c'        #15/08/12 Sarah add
            LET g_qryparam.reqry = FALSE
            IF g_site = 'ALL' THEN
               LET g_qryparam.arg1 = g_site_t
            ELSE
               LET g_qryparam.arg1 = g_site
            END IF
            CALL q_ooaj002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmab033  #顯示到畫面上

            NEXT FIELD pmab033                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab033
            #add-point:BEFORE FIELD pmab033 name="construct.b.pmab033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab033
            
            #add-point:AFTER FIELD pmab033 name="construct.a.pmab033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab034
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab034
            #add-point:ON ACTION controlp INFIELD pmab034 name="construct.c.pmab034"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL   #15/08/12 Sarah add
            LET g_qryparam.state = 'c'        #15/08/12 Sarah add
            LET g_qryparam.reqry = FALSE
            IF g_site = 'ALL' THEN 
               LET g_qryparam.arg1 = g_site_t
            ELSE
               LET g_qryparam.arg1 = g_site
            END IF
            CALL q_oodb002_3()                                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmab034  #顯示到畫面上
            LET g_qryparam.arg1 = ''

            NEXT FIELD pmab034                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab034
            #add-point:BEFORE FIELD pmab034 name="construct.b.pmab034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab034
            
            #add-point:AFTER FIELD pmab034 name="construct.a.pmab034"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab053
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab053
            #add-point:ON ACTION controlp INFIELD pmab053 name="construct.c.pmab053"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL   #15/08/12 Sarah add
            LET g_qryparam.state = 'c'        #15/08/12 Sarah add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '238'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmab053  #顯示到畫面上

            NEXT FIELD pmab053                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab053
            #add-point:BEFORE FIELD pmab053 name="construct.b.pmab053"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab053
            
            #add-point:AFTER FIELD pmab053 name="construct.a.pmab053"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab054
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab054
            #add-point:ON ACTION controlp INFIELD pmab054 name="construct.c.pmab054"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_pmam001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmab054  #顯示到畫面上

            NEXT FIELD pmab054                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab054
            #add-point:BEFORE FIELD pmab054 name="construct.b.pmab054"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab054
            
            #add-point:AFTER FIELD pmab054 name="construct.a.pmab054"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab035
            #add-point:BEFORE FIELD pmab035 name="construct.b.pmab035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab035
            
            #add-point:AFTER FIELD pmab035 name="construct.a.pmab035"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab035
            #add-point:ON ACTION controlp INFIELD pmab035 name="construct.c.pmab035"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab036
            #add-point:BEFORE FIELD pmab036 name="construct.b.pmab036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab036
            
            #add-point:AFTER FIELD pmab036 name="construct.a.pmab036"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab036
            #add-point:ON ACTION controlp INFIELD pmab036 name="construct.c.pmab036"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmab056
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab056
            #add-point:ON ACTION controlp INFIELD pmab056 name="construct.c.pmab056"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   #給予arg
            LET g_qryparam.arg1 = g_ooef019 #
            LET g_qryparam.arg2 = "1" 
            CALL q_isac002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmab056  #顯示到畫面上

            NEXT FIELD pmab056                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab056
            #add-point:BEFORE FIELD pmab056 name="construct.b.pmab056"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab056
            
            #add-point:AFTER FIELD pmab056 name="construct.a.pmab056"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab037
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab037
            #add-point:ON ACTION controlp INFIELD pmab037 name="construct.c.pmab037"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = '1'
            CALL q_pmad002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmab037  #顯示到畫面上

            NEXT FIELD pmab037                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab037
            #add-point:BEFORE FIELD pmab037 name="construct.b.pmab037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab037
            
            #add-point:AFTER FIELD pmab037 name="construct.a.pmab037"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab055
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab055
            #add-point:ON ACTION controlp INFIELD pmab055 name="construct.c.pmab055"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.arg1 = '3211'
			   LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmab055  #顯示到畫面上

            NEXT FIELD pmab055                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab055
            #add-point:BEFORE FIELD pmab055 name="construct.b.pmab055"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab055
            
            #add-point:AFTER FIELD pmab055 name="construct.a.pmab055"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab038
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab038
            #add-point:ON ACTION controlp INFIELD pmab038 name="construct.c.pmab038"
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
            DISPLAY g_qryparam.return1 TO pmab038  #顯示到畫面上

            NEXT FIELD pmab038                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab038
            #add-point:BEFORE FIELD pmab038 name="construct.b.pmab038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab038
            
            #add-point:AFTER FIELD pmab038 name="construct.a.pmab038"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab039
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab039
            #add-point:ON ACTION controlp INFIELD pmab039 name="construct.c.pmab039"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL   #15/08/12 Sarah add
            LET g_qryparam.state = 'c'        #15/08/12 Sarah add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '264'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmab039  #顯示到畫面上

            NEXT FIELD pmab039                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab039
            #add-point:BEFORE FIELD pmab039 name="construct.b.pmab039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab039
            
            #add-point:AFTER FIELD pmab039 name="construct.a.pmab039"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab057
            #add-point:BEFORE FIELD pmab057 name="construct.b.pmab057"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab057
            
            #add-point:AFTER FIELD pmab057 name="construct.a.pmab057"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab057
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab057
            #add-point:ON ACTION controlp INFIELD pmab057 name="construct.c.pmab057"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab058
            #add-point:BEFORE FIELD pmab058 name="construct.b.pmab058"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab058
            
            #add-point:AFTER FIELD pmab058 name="construct.a.pmab058"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab058
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab058
            #add-point:ON ACTION controlp INFIELD pmab058 name="construct.c.pmab058"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmab040
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab040
            #add-point:ON ACTION controlp INFIELD pmab040 name="construct.c.pmab040"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL   #15/08/12 Sarah add
            LET g_qryparam.state = 'c'        #15/08/12 Sarah add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '263'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmab040  #顯示到畫面上

            NEXT FIELD pmab040                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab040
            #add-point:BEFORE FIELD pmab040 name="construct.b.pmab040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab040
            
            #add-point:AFTER FIELD pmab040 name="construct.a.pmab040"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab041
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab041
            #add-point:ON ACTION controlp INFIELD pmab041 name="construct.c.pmab041"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL   #15/08/12 Sarah add
            LET g_qryparam.state = 'c'        #15/08/12 Sarah add
            LET g_qryparam.reqry = FALSE
            CALL q_pmab041()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmab041  #顯示到畫面上

            NEXT FIELD pmab041                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab041
            #add-point:BEFORE FIELD pmab041 name="construct.b.pmab041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab041
            
            #add-point:AFTER FIELD pmab041 name="construct.a.pmab041"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab042
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab042
            #add-point:ON ACTION controlp INFIELD pmab042 name="construct.c.pmab042"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL   #15/08/12 Sarah add
            LET g_qryparam.state = 'c'        #15/08/12 Sarah add
            LET g_qryparam.reqry = FALSE
            CALL q_pmab042()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmab042  #顯示到畫面上

            NEXT FIELD pmab042                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab042
            #add-point:BEFORE FIELD pmab042 name="construct.b.pmab042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab042
            
            #add-point:AFTER FIELD pmab042 name="construct.a.pmab042"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab043
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab043
            #add-point:ON ACTION controlp INFIELD pmab043 name="construct.c.pmab043"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL   #15/08/12 Sarah add
            LET g_qryparam.state = 'c'        #15/08/12 Sarah add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '262'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmab043  #顯示到畫面上

            NEXT FIELD pmab043                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab043
            #add-point:BEFORE FIELD pmab043 name="construct.b.pmab043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab043
            
            #add-point:AFTER FIELD pmab043 name="construct.a.pmab043"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab044
            #add-point:BEFORE FIELD pmab044 name="construct.b.pmab044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab044
            
            #add-point:AFTER FIELD pmab044 name="construct.a.pmab044"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab044
            #add-point:ON ACTION controlp INFIELD pmab044 name="construct.c.pmab044"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab045
            #add-point:BEFORE FIELD pmab045 name="construct.b.pmab045"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab045
            
            #add-point:AFTER FIELD pmab045 name="construct.a.pmab045"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab045
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab045
            #add-point:ON ACTION controlp INFIELD pmab045 name="construct.c.pmab045"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab046
            #add-point:BEFORE FIELD pmab046 name="construct.b.pmab046"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab046
            
            #add-point:AFTER FIELD pmab046 name="construct.a.pmab046"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab046
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab046
            #add-point:ON ACTION controlp INFIELD pmab046 name="construct.c.pmab046"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmab047
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab047
            #add-point:ON ACTION controlp INFIELD pmab047 name="construct.c.pmab047"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL   #15/08/12 Sarah add
            LET g_qryparam.state = 'c'        #15/08/12 Sarah add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where=" (pmaa002 = '1' OR pmaa002 = '3') "
            CALL q_pmaa001_4()                           #呼叫開窗
            LET g_qryparam.where=" "
            DISPLAY g_qryparam.return1 TO pmab047  #顯示到畫面上

            NEXT FIELD pmab047                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab047
            #add-point:BEFORE FIELD pmab047 name="construct.b.pmab047"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab047
            
            #add-point:AFTER FIELD pmab047 name="construct.a.pmab047"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab048
            #add-point:BEFORE FIELD pmab048 name="construct.b.pmab048"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab048
            
            #add-point:AFTER FIELD pmab048 name="construct.a.pmab048"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab048
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab048
            #add-point:ON ACTION controlp INFIELD pmab048 name="construct.c.pmab048"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab049
            #add-point:BEFORE FIELD pmab049 name="construct.b.pmab049"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab049
            
            #add-point:AFTER FIELD pmab049 name="construct.a.pmab049"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab049
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab049
            #add-point:ON ACTION controlp INFIELD pmab049 name="construct.c.pmab049"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab050
            #add-point:BEFORE FIELD pmab050 name="construct.b.pmab050"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab050
            
            #add-point:AFTER FIELD pmab050 name="construct.a.pmab050"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab050
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab050
            #add-point:ON ACTION controlp INFIELD pmab050 name="construct.c.pmab050"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab051
            #add-point:BEFORE FIELD pmab051 name="construct.b.pmab051"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab051
            
            #add-point:AFTER FIELD pmab051 name="construct.a.pmab051"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab051
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab051
            #add-point:ON ACTION controlp INFIELD pmab051 name="construct.c.pmab051"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab052
            #add-point:BEFORE FIELD pmab052 name="construct.b.pmab052"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab052
            
            #add-point:AFTER FIELD pmab052 name="construct.a.pmab052"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab052
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab052
            #add-point:ON ACTION controlp INFIELD pmab052 name="construct.c.pmab052"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab071
            #add-point:BEFORE FIELD pmab071 name="construct.b.pmab071"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab071
            
            #add-point:AFTER FIELD pmab071 name="construct.a.pmab071"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab071
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab071
            #add-point:ON ACTION controlp INFIELD pmab071 name="construct.c.pmab071"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab072
            #add-point:BEFORE FIELD pmab072 name="construct.b.pmab072"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab072
            
            #add-point:AFTER FIELD pmab072 name="construct.a.pmab072"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab072
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab072
            #add-point:ON ACTION controlp INFIELD pmab072 name="construct.c.pmab072"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab073
            #add-point:BEFORE FIELD pmab073 name="construct.b.pmab073"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab073
            
            #add-point:AFTER FIELD pmab073 name="construct.a.pmab073"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab073
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab073
            #add-point:ON ACTION controlp INFIELD pmab073 name="construct.c.pmab073"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab060
            #add-point:BEFORE FIELD pmab060 name="construct.b.pmab060"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab060
            
            #add-point:AFTER FIELD pmab060 name="construct.a.pmab060"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab060
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab060
            #add-point:ON ACTION controlp INFIELD pmab060 name="construct.c.pmab060"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab061
            #add-point:BEFORE FIELD pmab061 name="construct.b.pmab061"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab061
            
            #add-point:AFTER FIELD pmab061 name="construct.a.pmab061"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab061
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab061
            #add-point:ON ACTION controlp INFIELD pmab061 name="construct.c.pmab061"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab066
            #add-point:BEFORE FIELD pmab066 name="construct.b.pmab066"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab066
            
            #add-point:AFTER FIELD pmab066 name="construct.a.pmab066"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab066
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab066
            #add-point:ON ACTION controlp INFIELD pmab066 name="construct.c.pmab066"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab062
            #add-point:BEFORE FIELD pmab062 name="construct.b.pmab062"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab062
            
            #add-point:AFTER FIELD pmab062 name="construct.a.pmab062"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab062
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab062
            #add-point:ON ACTION controlp INFIELD pmab062 name="construct.c.pmab062"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab067
            #add-point:BEFORE FIELD pmab067 name="construct.b.pmab067"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab067
            
            #add-point:AFTER FIELD pmab067 name="construct.a.pmab067"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab067
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab067
            #add-point:ON ACTION controlp INFIELD pmab067 name="construct.c.pmab067"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab063
            #add-point:BEFORE FIELD pmab063 name="construct.b.pmab063"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab063
            
            #add-point:AFTER FIELD pmab063 name="construct.a.pmab063"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab063
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab063
            #add-point:ON ACTION controlp INFIELD pmab063 name="construct.c.pmab063"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab068
            #add-point:BEFORE FIELD pmab068 name="construct.b.pmab068"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab068
            
            #add-point:AFTER FIELD pmab068 name="construct.a.pmab068"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab068
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab068
            #add-point:ON ACTION controlp INFIELD pmab068 name="construct.c.pmab068"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab064
            #add-point:BEFORE FIELD pmab064 name="construct.b.pmab064"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab064
            
            #add-point:AFTER FIELD pmab064 name="construct.a.pmab064"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab064
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab064
            #add-point:ON ACTION controlp INFIELD pmab064 name="construct.c.pmab064"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab069
            #add-point:BEFORE FIELD pmab069 name="construct.b.pmab069"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab069
            
            #add-point:AFTER FIELD pmab069 name="construct.a.pmab069"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab069
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab069
            #add-point:ON ACTION controlp INFIELD pmab069 name="construct.c.pmab069"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab065
            #add-point:BEFORE FIELD pmab065 name="construct.b.pmab065"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab065
            
            #add-point:AFTER FIELD pmab065 name="construct.a.pmab065"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab065
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab065
            #add-point:ON ACTION controlp INFIELD pmab065 name="construct.c.pmab065"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab070
            #add-point:BEFORE FIELD pmab070 name="construct.b.pmab070"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab070
            
            #add-point:AFTER FIELD pmab070 name="construct.a.pmab070"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab070
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab070
            #add-point:ON ACTION controlp INFIELD pmab070 name="construct.c.pmab070"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_total
            #add-point:BEFORE FIELD l_total name="construct.b.l_total"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_total
            
            #add-point:AFTER FIELD l_total name="construct.a.l_total"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.l_total
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_total
            #add-point:ON ACTION controlp INFIELD l_total name="construct.c.l_total"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab002
            #add-point:BEFORE FIELD pmab002 name="construct.b.pmab002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab002
            
            #add-point:AFTER FIELD pmab002 name="construct.a.pmab002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab002
            #add-point:ON ACTION controlp INFIELD pmab002 name="construct.c.pmab002"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmab003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab003
            #add-point:ON ACTION controlp INFIELD pmab003 name="construct.c.pmab003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL   #15/08/12 Sarah add
            LET g_qryparam.state = 'c'        #15/08/12 Sarah add
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmab003  #顯示到畫面上

            NEXT FIELD pmab003                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab003
            #add-point:BEFORE FIELD pmab003 name="construct.b.pmab003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab003
            
            #add-point:AFTER FIELD pmab003 name="construct.a.pmab003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab004
            #add-point:ON ACTION controlp INFIELD pmab004 name="construct.c.pmab004"
            #ming 20140817 add ------------------------------------(S) 
            #補上信用評等的開窗 
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            ##供應商評核等級
            #IF g_argv[01] = '1' THEN
            #   LET g_qryparam.arg1 = g_site_t
            #   CALL q_pmbk001_2()
            #END IF
            #IF g_argv[01] = '2' THEN   
            #   CALL q_xmaj001()                                #呼叫開窗
            #END IF
            #IF g_argv[01] = '3' THEN
            #   CALL q_pmab004() +
            #END IF                          #呼叫開窗
            CALL q_xmaj001()  
            DISPLAY g_qryparam.return1 TO pmab004  #顯示到畫面上
            NEXT FIELD pmab004                     #返回原欄位
            #ming 20140817 add ------------------------------------(E) 
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab004
            #add-point:BEFORE FIELD pmab004 name="construct.b.pmab004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab004
            
            #add-point:AFTER FIELD pmab004 name="construct.a.pmab004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab005
            #add-point:ON ACTION controlp INFIELD pmab005 name="construct.c.pmab005"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL   #15/08/12 Sarah add
            LET g_qryparam.state = 'c'        #15/08/12 Sarah add
            LET g_qryparam.reqry = FALSE
            IF g_site = 'ALL' THEN
               LET g_qryparam.arg1 = g_site_t
            ELSE
               LET g_qryparam.arg1 = g_site
            END IF
            CALL q_ooaj002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmab005  #顯示到畫面上

            NEXT FIELD pmab005                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab005
            #add-point:BEFORE FIELD pmab005 name="construct.b.pmab005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab005
            
            #add-point:AFTER FIELD pmab005 name="construct.a.pmab005"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab006
            #add-point:BEFORE FIELD pmab006 name="construct.b.pmab006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab006
            
            #add-point:AFTER FIELD pmab006 name="construct.a.pmab006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab006
            #add-point:ON ACTION controlp INFIELD pmab006 name="construct.c.pmab006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab007
            #add-point:BEFORE FIELD pmab007 name="construct.b.pmab007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab007
            
            #add-point:AFTER FIELD pmab007 name="construct.a.pmab007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab007
            #add-point:ON ACTION controlp INFIELD pmab007 name="construct.c.pmab007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab008
            #add-point:BEFORE FIELD pmab008 name="construct.b.pmab008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab008
            
            #add-point:AFTER FIELD pmab008 name="construct.a.pmab008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab008
            #add-point:ON ACTION controlp INFIELD pmab008 name="construct.c.pmab008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab009
            #add-point:BEFORE FIELD pmab009 name="construct.b.pmab009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab009
            
            #add-point:AFTER FIELD pmab009 name="construct.a.pmab009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab009
            #add-point:ON ACTION controlp INFIELD pmab009 name="construct.c.pmab009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab019
            #add-point:BEFORE FIELD pmab019 name="construct.b.pmab019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab019
            
            #add-point:AFTER FIELD pmab019 name="construct.a.pmab019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab019
            #add-point:ON ACTION controlp INFIELD pmab019 name="construct.c.pmab019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab010
            #add-point:BEFORE FIELD pmab010 name="construct.b.pmab010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab010
            
            #add-point:AFTER FIELD pmab010 name="construct.a.pmab010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab010
            #add-point:ON ACTION controlp INFIELD pmab010 name="construct.c.pmab010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab020
            #add-point:BEFORE FIELD pmab020 name="construct.b.pmab020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab020
            
            #add-point:AFTER FIELD pmab020 name="construct.a.pmab020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab020
            #add-point:ON ACTION controlp INFIELD pmab020 name="construct.c.pmab020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab011
            #add-point:BEFORE FIELD pmab011 name="construct.b.pmab011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab011
            
            #add-point:AFTER FIELD pmab011 name="construct.a.pmab011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab011
            #add-point:ON ACTION controlp INFIELD pmab011 name="construct.c.pmab011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab012
            #add-point:BEFORE FIELD pmab012 name="construct.b.pmab012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab012
            
            #add-point:AFTER FIELD pmab012 name="construct.a.pmab012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab012
            #add-point:ON ACTION controlp INFIELD pmab012 name="construct.c.pmab012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab013
            #add-point:BEFORE FIELD pmab013 name="construct.b.pmab013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab013
            
            #add-point:AFTER FIELD pmab013 name="construct.a.pmab013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab013
            #add-point:ON ACTION controlp INFIELD pmab013 name="construct.c.pmab013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab014
            #add-point:BEFORE FIELD pmab014 name="construct.b.pmab014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab014
            
            #add-point:AFTER FIELD pmab014 name="construct.a.pmab014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab014
            #add-point:ON ACTION controlp INFIELD pmab014 name="construct.c.pmab014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab015
            #add-point:BEFORE FIELD pmab015 name="construct.b.pmab015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab015
            
            #add-point:AFTER FIELD pmab015 name="construct.a.pmab015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab015
            #add-point:ON ACTION controlp INFIELD pmab015 name="construct.c.pmab015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab016
            #add-point:BEFORE FIELD pmab016 name="construct.b.pmab016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab016
            
            #add-point:AFTER FIELD pmab016 name="construct.a.pmab016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab016
            #add-point:ON ACTION controlp INFIELD pmab016 name="construct.c.pmab016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab017
            #add-point:BEFORE FIELD pmab017 name="construct.b.pmab017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab017
            
            #add-point:AFTER FIELD pmab017 name="construct.a.pmab017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab017
            #add-point:ON ACTION controlp INFIELD pmab017 name="construct.c.pmab017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab018
            #add-point:BEFORE FIELD pmab018 name="construct.b.pmab018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab018
            
            #add-point:AFTER FIELD pmab018 name="construct.a.pmab018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmab018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab018
            #add-point:ON ACTION controlp INFIELD pmab018 name="construct.c.pmab018"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmabownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmabownid
            #add-point:ON ACTION controlp INFIELD pmabownid name="construct.c.pmabownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL   #15/08/12 Sarah add
            LET g_qryparam.state = 'c'        #15/08/12 Sarah add
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmabownid  #顯示到畫面上

            NEXT FIELD pmabownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmabownid
            #add-point:BEFORE FIELD pmabownid name="construct.b.pmabownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmabownid
            
            #add-point:AFTER FIELD pmabownid name="construct.a.pmabownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmabowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmabowndp
            #add-point:ON ACTION controlp INFIELD pmabowndp name="construct.c.pmabowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL   #15/08/12 Sarah add
            LET g_qryparam.state = 'c'        #15/08/12 Sarah add
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmabowndp  #顯示到畫面上

            NEXT FIELD pmabowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmabowndp
            #add-point:BEFORE FIELD pmabowndp name="construct.b.pmabowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmabowndp
            
            #add-point:AFTER FIELD pmabowndp name="construct.a.pmabowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmabcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmabcrtid
            #add-point:ON ACTION controlp INFIELD pmabcrtid name="construct.c.pmabcrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL   #15/08/12 Sarah add
            LET g_qryparam.state = 'c'        #15/08/12 Sarah add
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmabcrtid  #顯示到畫面上

            NEXT FIELD pmabcrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmabcrtid
            #add-point:BEFORE FIELD pmabcrtid name="construct.b.pmabcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmabcrtid
            
            #add-point:AFTER FIELD pmabcrtid name="construct.a.pmabcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmabcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmabcrtdp
            #add-point:ON ACTION controlp INFIELD pmabcrtdp name="construct.c.pmabcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL   #15/08/12 Sarah add
            LET g_qryparam.state = 'c'        #15/08/12 Sarah add
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmabcrtdp  #顯示到畫面上

            NEXT FIELD pmabcrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmabcrtdp
            #add-point:BEFORE FIELD pmabcrtdp name="construct.b.pmabcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmabcrtdp
            
            #add-point:AFTER FIELD pmabcrtdp name="construct.a.pmabcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmabcrtdt
            #add-point:BEFORE FIELD pmabcrtdt name="construct.b.pmabcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmabmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmabmodid
            #add-point:ON ACTION controlp INFIELD pmabmodid name="construct.c.pmabmodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL   #15/08/12 Sarah add
            LET g_qryparam.state = 'c'        #15/08/12 Sarah add
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmabmodid  #顯示到畫面上

            NEXT FIELD pmabmodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmabmodid
            #add-point:BEFORE FIELD pmabmodid name="construct.b.pmabmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmabmodid
            
            #add-point:AFTER FIELD pmabmodid name="construct.a.pmabmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmabmoddt
            #add-point:BEFORE FIELD pmabmoddt name="construct.b.pmabmoddt"
            
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
 
{<section id="apmm101.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION apmm101_filter()
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
      CONSTRUCT g_wc_filter ON pmab001
                          FROM s_browse[1].b_pmab001
 
         BEFORE CONSTRUCT
               DISPLAY apmm101_filter_parser('pmab001') TO s_browse[1].b_pmab001
      
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
 
      CALL apmm101_filter_show('pmab001')
 
END FUNCTION
 
{</section>}
 
{<section id="apmm101.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION apmm101_filter_parser(ps_field)
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
 
{<section id="apmm101.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION apmm101_filter_show(ps_field)
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
   LET ls_condition = apmm101_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="apmm101.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION apmm101_query()
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
 
   INITIALIZE g_pmab_m.* TO NULL
   ERROR ""
 
   DISPLAY " " TO FORMONLY.b_count
   DISPLAY " " TO FORMONLY.h_count
   CALL apmm101_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL apmm101_browser_fill(g_wc,"F")
      CALL apmm101_fetch("")
      RETURN
   ELSE
      LET g_current_row = 1
      LET g_current_cnt = 0
   END IF
   
   #根據條件從新抓取資料
   LET g_error_show = 1
   CALL apmm101_browser_fill(g_wc,"F")   # 移到第一頁
   
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
      CALL apmm101_fetch("F") 
   END IF
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="apmm101.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION apmm101_fetch(p_fl)
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
   LET g_pmab_m.pmab001 = g_browser[g_current_idx].b_pmab001
 
                       
   #讀取單頭所有欄位資料
   EXECUTE apmm101_master_referesh USING g_site,g_pmab_m.pmab001 INTO g_pmab_m.pmab001,g_pmab_m.pmab080, 
       g_pmab_m.pmab081,g_pmab_m.pmab109,g_pmab_m.pmab082,g_pmab_m.pmab111,g_pmab_m.pmab083,g_pmab_m.pmab084, 
       g_pmab_m.pmab103,g_pmab_m.pmab104,g_pmab_m.pmab085,g_pmab_m.pmab086,g_pmab_m.pmab106,g_pmab_m.pmab087, 
       g_pmab_m.pmab105,g_pmab_m.pmab088,g_pmab_m.pmab089,g_pmab_m.pmab107,g_pmab_m.pmab108,g_pmab_m.pmab090, 
       g_pmab_m.pmab091,g_pmab_m.pmab092,g_pmab_m.pmab093,g_pmab_m.pmab094,g_pmab_m.pmab095,g_pmab_m.pmab096, 
       g_pmab_m.pmab097,g_pmab_m.pmab098,g_pmab_m.pmab099,g_pmab_m.pmab100,g_pmab_m.pmab101,g_pmab_m.pmab102, 
       g_pmab_m.pmab030,g_pmab_m.pmab031,g_pmab_m.pmab059,g_pmab_m.pmab032,g_pmab_m.pmab110,g_pmab_m.pmab033, 
       g_pmab_m.pmab034,g_pmab_m.pmab053,g_pmab_m.pmab054,g_pmab_m.pmab035,g_pmab_m.pmab036,g_pmab_m.pmab056, 
       g_pmab_m.pmab037,g_pmab_m.pmab055,g_pmab_m.pmab038,g_pmab_m.pmab039,g_pmab_m.pmab057,g_pmab_m.pmab058, 
       g_pmab_m.pmab040,g_pmab_m.pmab041,g_pmab_m.pmab042,g_pmab_m.pmab043,g_pmab_m.pmab044,g_pmab_m.pmab045, 
       g_pmab_m.pmab046,g_pmab_m.pmab047,g_pmab_m.pmab048,g_pmab_m.pmab049,g_pmab_m.pmab050,g_pmab_m.pmab051, 
       g_pmab_m.pmab052,g_pmab_m.pmab071,g_pmab_m.pmab072,g_pmab_m.pmab073,g_pmab_m.pmab060,g_pmab_m.pmab061, 
       g_pmab_m.pmab066,g_pmab_m.pmab062,g_pmab_m.pmab067,g_pmab_m.pmab063,g_pmab_m.pmab068,g_pmab_m.pmab064, 
       g_pmab_m.pmab069,g_pmab_m.pmab065,g_pmab_m.pmab070,g_pmab_m.pmab002,g_pmab_m.pmab003,g_pmab_m.pmab004, 
       g_pmab_m.pmab005,g_pmab_m.pmab006,g_pmab_m.pmab007,g_pmab_m.pmab008,g_pmab_m.pmab009,g_pmab_m.pmab019, 
       g_pmab_m.pmab010,g_pmab_m.pmab020,g_pmab_m.pmab011,g_pmab_m.pmab012,g_pmab_m.pmab013,g_pmab_m.pmab014, 
       g_pmab_m.pmab015,g_pmab_m.pmab016,g_pmab_m.pmab017,g_pmab_m.pmab018,g_pmab_m.pmabownid,g_pmab_m.pmabowndp, 
       g_pmab_m.pmabcrtid,g_pmab_m.pmabcrtdp,g_pmab_m.pmabcrtdt,g_pmab_m.pmabmodid,g_pmab_m.pmabmoddt, 
       g_pmab_m.pmab081_desc,g_pmab_m.pmab109_desc,g_pmab_m.pmab083_desc,g_pmab_m.pmab103_desc,g_pmab_m.pmab104_desc, 
       g_pmab_m.pmab087_desc,g_pmab_m.pmab105_desc,g_pmab_m.pmab088_desc,g_pmab_m.pmab089_desc,g_pmab_m.pmab090_desc, 
       g_pmab_m.pmab091_desc,g_pmab_m.pmab092_desc,g_pmab_m.pmab093_desc,g_pmab_m.pmab097_desc,g_pmab_m.pmab031_desc, 
       g_pmab_m.pmab059_desc,g_pmab_m.pmab033_desc,g_pmab_m.pmab053_desc,g_pmab_m.pmab054_desc,g_pmab_m.pmab037_desc, 
       g_pmab_m.pmab055_desc,g_pmab_m.pmab038_desc,g_pmab_m.pmab039_desc,g_pmab_m.pmab040_desc,g_pmab_m.pmab041_desc, 
       g_pmab_m.pmab042_desc,g_pmab_m.pmab043_desc,g_pmab_m.pmab047_desc,g_pmab_m.pmab003_desc,g_pmab_m.pmab004_desc, 
       g_pmab_m.pmab005_desc,g_pmab_m.pmabownid_desc,g_pmab_m.pmabowndp_desc,g_pmab_m.pmabcrtid_desc, 
       g_pmab_m.pmabcrtdp_desc,g_pmab_m.pmabmodid_desc
   
   #遮罩相關處理
   LET g_pmab_m_mask_o.* =  g_pmab_m.*
   CALL apmm101_pmab_t_mask()
   LET g_pmab_m_mask_n.* =  g_pmab_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL apmm101_set_act_visible()
   CALL apmm101_set_act_no_visible()
 
   #add-point:fetch段action控制 name="fetch.action_control"
 
   #end add-point  
   
   
   
   #保存單頭舊值
   LET g_pmab_m_t.* = g_pmab_m.*
   LET g_pmab_m_o.* = g_pmab_m.*
   
   LET g_data_owner = g_pmab_m.pmabownid      
   LET g_data_dept  = g_pmab_m.pmabowndp
   
   #重新顯示
   CALL apmm101_show()
   
 
END FUNCTION
 
{</section>}
 
{<section id="apmm101.insert" >}
#+ 資料新增
PRIVATE FUNCTION apmm101_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   CLEAR FORM #清畫面欄位內容
   INITIALIZE g_pmab_m.* TO NULL             #DEFAULT 設定
   LET g_pmab001_t = NULL
 
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   
   WHILE TRUE
      
      #公用欄位給值
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_pmab_m.pmabownid = g_user
      LET g_pmab_m.pmabowndp = g_dept
      LET g_pmab_m.pmabcrtid = g_user
      LET g_pmab_m.pmabcrtdp = g_dept 
      LET g_pmab_m.pmabcrtdt = cl_get_current()
      LET g_pmab_m.pmabmodid = g_user
      LET g_pmab_m.pmabmoddt = cl_get_current()
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_pmab_m.pmab080 = "A"
      LET g_pmab_m.pmab085 = "10"
      LET g_pmab_m.pmab086 = "1"
      LET g_pmab_m.pmab107 = "1"
      LET g_pmab_m.pmab108 = "2"
      LET g_pmab_m.pmab099 = "Y"
      LET g_pmab_m.pmab101 = "Y"
      LET g_pmab_m.pmab030 = "A"
      LET g_pmab_m.pmab110 = "0"
      LET g_pmab_m.pmab035 = "10"
      LET g_pmab_m.pmab036 = "1"
      LET g_pmab_m.pmab057 = "1"
      LET g_pmab_m.pmab058 = "1"
      LET g_pmab_m.pmab049 = "Y"
      LET g_pmab_m.pmab051 = "Y"
      LET g_pmab_m.pmab071 = "N"
      LET g_pmab_m.pmab072 = "1"
      LET g_pmab_m.pmab073 = "1"
      LET g_pmab_m.pmab002 = "1"
      LET g_pmab_m.pmab006 = "0"
      LET g_pmab_m.pmab009 = "0"
      LET g_pmab_m.pmab019 = "0"
      LET g_pmab_m.pmab010 = "0"
      LET g_pmab_m.pmab012 = "1"
      LET g_pmab_m.pmab014 = "1"
      LET g_pmab_m.pmab016 = "1"
      LET g_pmab_m.pmab017 = "N"
      LET g_pmab_m.pmab018 = "1"
 
 
      #add-point:單頭預設值 name="insert.default"
      LET g_pmab_m.pmab032 = g_dlang
      LET g_pmab_m.pmab082 = g_dlang
      
      IF NOT cl_null(g_argv[03]) THEN
         LET g_pmab_m.pmab001 = g_argv[03]
         #modify--2015/06/25 By shiun--(S)
         CALL apmm101_pmab001_ref(g_pmab_m.pmab001) 
               RETURNING g_pmab_m.pmaa002,g_pmab_m.pmaal004,g_pmab_m.pmaal003,g_pmab_m.pmaal006,g_pmab_m.pmaal005,g_pmab_m.pmaa003,g_pmab_m.status1
         DISPLAY BY NAME g_pmab_m.pmab001,g_pmab_m.pmaa002,g_pmab_m.pmaal004,g_pmab_m.pmaal003,g_pmab_m.pmaal006,g_pmab_m.pmaal005,g_pmab_m.pmaa003,g_pmab_m.status1           
         #modify--2015/06/25 By shiun--(E)
      END IF
      
      INITIALIZE g_pmab_m_t.* TO NULL
      LET g_pmab_m_t.* = g_pmab_m.*       
      #end add-point   
     
      #顯示狀態(stus)圖片
      
     
      #資料輸入
      CALL apmm101_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG THEN
         #取消
         LET INT_FLAG = 0
         DISPLAY g_current_cnt TO FORMONLY.h_count     #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index     #當下筆數
         INITIALIZE g_pmab_m.* TO NULL
         CALL apmm101_show()
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
   CALL apmm101_set_act_visible()
   CALL apmm101_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_pmab001_t = g_pmab_m.pmab001
 
   
   #組合新增資料的條件
   LET g_add_browse = " pmabent = " ||g_enterprise|| " AND pmabsite = '" ||g_site|| "' AND",
                      " pmab001 = '", g_pmab_m.pmab001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL apmm101_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
 
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE apmm101_master_referesh USING g_site,g_pmab_m.pmab001 INTO g_pmab_m.pmab001,g_pmab_m.pmab080, 
       g_pmab_m.pmab081,g_pmab_m.pmab109,g_pmab_m.pmab082,g_pmab_m.pmab111,g_pmab_m.pmab083,g_pmab_m.pmab084, 
       g_pmab_m.pmab103,g_pmab_m.pmab104,g_pmab_m.pmab085,g_pmab_m.pmab086,g_pmab_m.pmab106,g_pmab_m.pmab087, 
       g_pmab_m.pmab105,g_pmab_m.pmab088,g_pmab_m.pmab089,g_pmab_m.pmab107,g_pmab_m.pmab108,g_pmab_m.pmab090, 
       g_pmab_m.pmab091,g_pmab_m.pmab092,g_pmab_m.pmab093,g_pmab_m.pmab094,g_pmab_m.pmab095,g_pmab_m.pmab096, 
       g_pmab_m.pmab097,g_pmab_m.pmab098,g_pmab_m.pmab099,g_pmab_m.pmab100,g_pmab_m.pmab101,g_pmab_m.pmab102, 
       g_pmab_m.pmab030,g_pmab_m.pmab031,g_pmab_m.pmab059,g_pmab_m.pmab032,g_pmab_m.pmab110,g_pmab_m.pmab033, 
       g_pmab_m.pmab034,g_pmab_m.pmab053,g_pmab_m.pmab054,g_pmab_m.pmab035,g_pmab_m.pmab036,g_pmab_m.pmab056, 
       g_pmab_m.pmab037,g_pmab_m.pmab055,g_pmab_m.pmab038,g_pmab_m.pmab039,g_pmab_m.pmab057,g_pmab_m.pmab058, 
       g_pmab_m.pmab040,g_pmab_m.pmab041,g_pmab_m.pmab042,g_pmab_m.pmab043,g_pmab_m.pmab044,g_pmab_m.pmab045, 
       g_pmab_m.pmab046,g_pmab_m.pmab047,g_pmab_m.pmab048,g_pmab_m.pmab049,g_pmab_m.pmab050,g_pmab_m.pmab051, 
       g_pmab_m.pmab052,g_pmab_m.pmab071,g_pmab_m.pmab072,g_pmab_m.pmab073,g_pmab_m.pmab060,g_pmab_m.pmab061, 
       g_pmab_m.pmab066,g_pmab_m.pmab062,g_pmab_m.pmab067,g_pmab_m.pmab063,g_pmab_m.pmab068,g_pmab_m.pmab064, 
       g_pmab_m.pmab069,g_pmab_m.pmab065,g_pmab_m.pmab070,g_pmab_m.pmab002,g_pmab_m.pmab003,g_pmab_m.pmab004, 
       g_pmab_m.pmab005,g_pmab_m.pmab006,g_pmab_m.pmab007,g_pmab_m.pmab008,g_pmab_m.pmab009,g_pmab_m.pmab019, 
       g_pmab_m.pmab010,g_pmab_m.pmab020,g_pmab_m.pmab011,g_pmab_m.pmab012,g_pmab_m.pmab013,g_pmab_m.pmab014, 
       g_pmab_m.pmab015,g_pmab_m.pmab016,g_pmab_m.pmab017,g_pmab_m.pmab018,g_pmab_m.pmabownid,g_pmab_m.pmabowndp, 
       g_pmab_m.pmabcrtid,g_pmab_m.pmabcrtdp,g_pmab_m.pmabcrtdt,g_pmab_m.pmabmodid,g_pmab_m.pmabmoddt, 
       g_pmab_m.pmab081_desc,g_pmab_m.pmab109_desc,g_pmab_m.pmab083_desc,g_pmab_m.pmab103_desc,g_pmab_m.pmab104_desc, 
       g_pmab_m.pmab087_desc,g_pmab_m.pmab105_desc,g_pmab_m.pmab088_desc,g_pmab_m.pmab089_desc,g_pmab_m.pmab090_desc, 
       g_pmab_m.pmab091_desc,g_pmab_m.pmab092_desc,g_pmab_m.pmab093_desc,g_pmab_m.pmab097_desc,g_pmab_m.pmab031_desc, 
       g_pmab_m.pmab059_desc,g_pmab_m.pmab033_desc,g_pmab_m.pmab053_desc,g_pmab_m.pmab054_desc,g_pmab_m.pmab037_desc, 
       g_pmab_m.pmab055_desc,g_pmab_m.pmab038_desc,g_pmab_m.pmab039_desc,g_pmab_m.pmab040_desc,g_pmab_m.pmab041_desc, 
       g_pmab_m.pmab042_desc,g_pmab_m.pmab043_desc,g_pmab_m.pmab047_desc,g_pmab_m.pmab003_desc,g_pmab_m.pmab004_desc, 
       g_pmab_m.pmab005_desc,g_pmab_m.pmabownid_desc,g_pmab_m.pmabowndp_desc,g_pmab_m.pmabcrtid_desc, 
       g_pmab_m.pmabcrtdp_desc,g_pmab_m.pmabmodid_desc
   
   
   #遮罩相關處理
   LET g_pmab_m_mask_o.* =  g_pmab_m.*
   CALL apmm101_pmab_t_mask()
   LET g_pmab_m_mask_n.* =  g_pmab_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_pmab_m.pmab001,g_pmab_m.pmaal004,g_pmab_m.pmaal005,g_pmab_m.pmaa003,g_pmab_m.pmaa002, 
       g_pmab_m.pmaal003,g_pmab_m.pmaal006,g_pmab_m.status1,g_pmab_m.pmab080,g_pmab_m.pmab081,g_pmab_m.pmab081_desc, 
       g_pmab_m.pmab109,g_pmab_m.pmab109_desc,g_pmab_m.pmab082,g_pmab_m.pmab111,g_pmab_m.pmab083,g_pmab_m.pmab083_desc, 
       g_pmab_m.pmab084,g_pmab_m.pmab084_desc,g_pmab_m.pmab103,g_pmab_m.pmab103_desc,g_pmab_m.pmab104, 
       g_pmab_m.pmab104_desc,g_pmab_m.pmab085,g_pmab_m.pmab086,g_pmab_m.pmab106,g_pmab_m.pmab106_desc, 
       g_pmab_m.pmab087,g_pmab_m.pmab087_desc,g_pmab_m.pmab105,g_pmab_m.pmab105_desc,g_pmab_m.pmab088, 
       g_pmab_m.pmab088_desc,g_pmab_m.pmab089,g_pmab_m.pmab089_desc,g_pmab_m.pmab107,g_pmab_m.pmab108, 
       g_pmab_m.pmab090,g_pmab_m.pmab090_desc,g_pmab_m.pmab091,g_pmab_m.pmab091_desc,g_pmab_m.pmab092, 
       g_pmab_m.pmab092_desc,g_pmab_m.pmab093,g_pmab_m.pmab093_desc,g_pmab_m.pmab094,g_pmab_m.pmab095, 
       g_pmab_m.pmab096,g_pmab_m.pmab097,g_pmab_m.pmab097_desc,g_pmab_m.pmab098,g_pmab_m.pmab099,g_pmab_m.pmab100, 
       g_pmab_m.pmab101,g_pmab_m.pmab102,g_pmab_m.pmab030,g_pmab_m.pmab031,g_pmab_m.pmab031_desc,g_pmab_m.pmab059, 
       g_pmab_m.pmab059_desc,g_pmab_m.pmab032,g_pmab_m.pmab110,g_pmab_m.pmab033,g_pmab_m.pmab033_desc, 
       g_pmab_m.pmab034,g_pmab_m.pmab034_desc,g_pmab_m.pmab053,g_pmab_m.pmab053_desc,g_pmab_m.pmab054, 
       g_pmab_m.pmab054_desc,g_pmab_m.pmab035,g_pmab_m.pmab036,g_pmab_m.pmab056,g_pmab_m.pmab056_desc, 
       g_pmab_m.pmab037,g_pmab_m.pmab037_desc,g_pmab_m.pmab055,g_pmab_m.pmab055_desc,g_pmab_m.pmab038, 
       g_pmab_m.pmab038_desc,g_pmab_m.pmab039,g_pmab_m.pmab039_desc,g_pmab_m.pmab057,g_pmab_m.pmab058, 
       g_pmab_m.pmab040,g_pmab_m.pmab040_desc,g_pmab_m.pmab041,g_pmab_m.pmab041_desc,g_pmab_m.pmab042, 
       g_pmab_m.pmab042_desc,g_pmab_m.pmab043,g_pmab_m.pmab043_desc,g_pmab_m.pmab044,g_pmab_m.pmab045, 
       g_pmab_m.pmab046,g_pmab_m.pmab047,g_pmab_m.pmab047_desc,g_pmab_m.pmab048,g_pmab_m.pmab049,g_pmab_m.pmab050, 
       g_pmab_m.pmab051,g_pmab_m.pmab052,g_pmab_m.pmab071,g_pmab_m.pmab072,g_pmab_m.pmab073,g_pmab_m.pmab060, 
       g_pmab_m.pmab061,g_pmab_m.pmab066,g_pmab_m.pmab062,g_pmab_m.pmab067,g_pmab_m.pmab063,g_pmab_m.pmab068, 
       g_pmab_m.pmab064,g_pmab_m.pmab069,g_pmab_m.pmab065,g_pmab_m.pmab070,g_pmab_m.l_total,g_pmab_m.pmab002, 
       g_pmab_m.pmab003,g_pmab_m.pmab003_desc,g_pmab_m.pmab004,g_pmab_m.pmab004_desc,g_pmab_m.pmab005, 
       g_pmab_m.pmab005_desc,g_pmab_m.pmab006,g_pmab_m.pmab007,g_pmab_m.pmab008,g_pmab_m.pmab009,g_pmab_m.pmab019, 
       g_pmab_m.pmab010,g_pmab_m.pmab020,g_pmab_m.pmab011,g_pmab_m.pmab012,g_pmab_m.pmab013,g_pmab_m.pmab014, 
       g_pmab_m.pmab015,g_pmab_m.pmab016,g_pmab_m.pmab017,g_pmab_m.pmab018,g_pmab_m.ooff013,g_pmab_m.pmabownid, 
       g_pmab_m.pmabownid_desc,g_pmab_m.pmabowndp,g_pmab_m.pmabowndp_desc,g_pmab_m.pmabcrtid,g_pmab_m.pmabcrtid_desc, 
       g_pmab_m.pmabcrtdp,g_pmab_m.pmabcrtdp_desc,g_pmab_m.pmabcrtdt,g_pmab_m.pmabmodid,g_pmab_m.pmabmodid_desc, 
       g_pmab_m.pmabmoddt
 
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
 
   LET g_data_owner = g_pmab_m.pmabownid      
   LET g_data_dept  = g_pmab_m.pmabowndp
 
   #功能已完成,通報訊息中心
   CALL apmm101_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="apmm101.modify" >}
#+ 資料修改
PRIVATE FUNCTION apmm101_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="modify.pre_function"
   
   #end add-point
   
   #先確定key值無遺漏
   IF g_pmab_m.pmab001 IS NULL
 
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
   LET g_pmab001_t = g_pmab_m.pmab001
 
   
   CALL s_transaction_begin()
   
   #先lock資料
   OPEN apmm101_cl USING g_enterprise, g_site,g_pmab_m.pmab001
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apmm101_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE apmm101_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE apmm101_master_referesh USING g_site,g_pmab_m.pmab001 INTO g_pmab_m.pmab001,g_pmab_m.pmab080, 
       g_pmab_m.pmab081,g_pmab_m.pmab109,g_pmab_m.pmab082,g_pmab_m.pmab111,g_pmab_m.pmab083,g_pmab_m.pmab084, 
       g_pmab_m.pmab103,g_pmab_m.pmab104,g_pmab_m.pmab085,g_pmab_m.pmab086,g_pmab_m.pmab106,g_pmab_m.pmab087, 
       g_pmab_m.pmab105,g_pmab_m.pmab088,g_pmab_m.pmab089,g_pmab_m.pmab107,g_pmab_m.pmab108,g_pmab_m.pmab090, 
       g_pmab_m.pmab091,g_pmab_m.pmab092,g_pmab_m.pmab093,g_pmab_m.pmab094,g_pmab_m.pmab095,g_pmab_m.pmab096, 
       g_pmab_m.pmab097,g_pmab_m.pmab098,g_pmab_m.pmab099,g_pmab_m.pmab100,g_pmab_m.pmab101,g_pmab_m.pmab102, 
       g_pmab_m.pmab030,g_pmab_m.pmab031,g_pmab_m.pmab059,g_pmab_m.pmab032,g_pmab_m.pmab110,g_pmab_m.pmab033, 
       g_pmab_m.pmab034,g_pmab_m.pmab053,g_pmab_m.pmab054,g_pmab_m.pmab035,g_pmab_m.pmab036,g_pmab_m.pmab056, 
       g_pmab_m.pmab037,g_pmab_m.pmab055,g_pmab_m.pmab038,g_pmab_m.pmab039,g_pmab_m.pmab057,g_pmab_m.pmab058, 
       g_pmab_m.pmab040,g_pmab_m.pmab041,g_pmab_m.pmab042,g_pmab_m.pmab043,g_pmab_m.pmab044,g_pmab_m.pmab045, 
       g_pmab_m.pmab046,g_pmab_m.pmab047,g_pmab_m.pmab048,g_pmab_m.pmab049,g_pmab_m.pmab050,g_pmab_m.pmab051, 
       g_pmab_m.pmab052,g_pmab_m.pmab071,g_pmab_m.pmab072,g_pmab_m.pmab073,g_pmab_m.pmab060,g_pmab_m.pmab061, 
       g_pmab_m.pmab066,g_pmab_m.pmab062,g_pmab_m.pmab067,g_pmab_m.pmab063,g_pmab_m.pmab068,g_pmab_m.pmab064, 
       g_pmab_m.pmab069,g_pmab_m.pmab065,g_pmab_m.pmab070,g_pmab_m.pmab002,g_pmab_m.pmab003,g_pmab_m.pmab004, 
       g_pmab_m.pmab005,g_pmab_m.pmab006,g_pmab_m.pmab007,g_pmab_m.pmab008,g_pmab_m.pmab009,g_pmab_m.pmab019, 
       g_pmab_m.pmab010,g_pmab_m.pmab020,g_pmab_m.pmab011,g_pmab_m.pmab012,g_pmab_m.pmab013,g_pmab_m.pmab014, 
       g_pmab_m.pmab015,g_pmab_m.pmab016,g_pmab_m.pmab017,g_pmab_m.pmab018,g_pmab_m.pmabownid,g_pmab_m.pmabowndp, 
       g_pmab_m.pmabcrtid,g_pmab_m.pmabcrtdp,g_pmab_m.pmabcrtdt,g_pmab_m.pmabmodid,g_pmab_m.pmabmoddt, 
       g_pmab_m.pmab081_desc,g_pmab_m.pmab109_desc,g_pmab_m.pmab083_desc,g_pmab_m.pmab103_desc,g_pmab_m.pmab104_desc, 
       g_pmab_m.pmab087_desc,g_pmab_m.pmab105_desc,g_pmab_m.pmab088_desc,g_pmab_m.pmab089_desc,g_pmab_m.pmab090_desc, 
       g_pmab_m.pmab091_desc,g_pmab_m.pmab092_desc,g_pmab_m.pmab093_desc,g_pmab_m.pmab097_desc,g_pmab_m.pmab031_desc, 
       g_pmab_m.pmab059_desc,g_pmab_m.pmab033_desc,g_pmab_m.pmab053_desc,g_pmab_m.pmab054_desc,g_pmab_m.pmab037_desc, 
       g_pmab_m.pmab055_desc,g_pmab_m.pmab038_desc,g_pmab_m.pmab039_desc,g_pmab_m.pmab040_desc,g_pmab_m.pmab041_desc, 
       g_pmab_m.pmab042_desc,g_pmab_m.pmab043_desc,g_pmab_m.pmab047_desc,g_pmab_m.pmab003_desc,g_pmab_m.pmab004_desc, 
       g_pmab_m.pmab005_desc,g_pmab_m.pmabownid_desc,g_pmab_m.pmabowndp_desc,g_pmab_m.pmabcrtid_desc, 
       g_pmab_m.pmabcrtdp_desc,g_pmab_m.pmabmodid_desc
 
   #檢查是否允許此動作
   IF NOT apmm101_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_pmab_m_mask_o.* =  g_pmab_m.*
   CALL apmm101_pmab_t_mask()
   LET g_pmab_m_mask_n.* =  g_pmab_m.*
   
   
 
   #顯示資料
   CALL apmm101_show()
   
   WHILE TRUE
      LET g_pmab_m.pmab001 = g_pmab001_t
 
      
      #寫入修改者/修改日期資訊
      LET g_pmab_m.pmabmodid = g_user 
LET g_pmab_m.pmabmoddt = cl_get_current()
LET g_pmab_m.pmabmodid_desc = cl_get_username(g_pmab_m.pmabmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
 
      #資料輸入
      CALL apmm101_input("u")     
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_pmab_m.* = g_pmab_m_t.*
         CALL apmm101_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
 
      #若有modid跟moddt則進行update
      UPDATE pmab_t SET (pmabmodid,pmabmoddt) = (g_pmab_m.pmabmodid,g_pmab_m.pmabmoddt)
       WHERE pmabent = g_enterprise AND pmabsite = g_site AND pmab001 = g_pmab001_t
 
 
      EXIT WHILE
      
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL apmm101_set_act_visible()
   CALL apmm101_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " pmabent = " ||g_enterprise|| " AND pmabsite = '" ||g_site|| "' AND",
                      " pmab001 = '", g_pmab_m.pmab001, "' "
 
   #填到對應位置
   CALL apmm101_browser_fill(g_wc,"")
 
   CLOSE apmm101_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL apmm101_msgcentre_notify('modify')
   
   LET g_worksheet_hidden = 0
   
END FUNCTION   
 
{</section>}
 
{<section id="apmm101.input" >}
#+ 資料輸入
PRIVATE FUNCTION apmm101_input(p_cmd)
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
   DISPLAY BY NAME g_pmab_m.pmab001,g_pmab_m.pmaal004,g_pmab_m.pmaal005,g_pmab_m.pmaa003,g_pmab_m.pmaa002, 
       g_pmab_m.pmaal003,g_pmab_m.pmaal006,g_pmab_m.status1,g_pmab_m.pmab080,g_pmab_m.pmab081,g_pmab_m.pmab081_desc, 
       g_pmab_m.pmab109,g_pmab_m.pmab109_desc,g_pmab_m.pmab082,g_pmab_m.pmab111,g_pmab_m.pmab083,g_pmab_m.pmab083_desc, 
       g_pmab_m.pmab084,g_pmab_m.pmab084_desc,g_pmab_m.pmab103,g_pmab_m.pmab103_desc,g_pmab_m.pmab104, 
       g_pmab_m.pmab104_desc,g_pmab_m.pmab085,g_pmab_m.pmab086,g_pmab_m.pmab106,g_pmab_m.pmab106_desc, 
       g_pmab_m.pmab087,g_pmab_m.pmab087_desc,g_pmab_m.pmab105,g_pmab_m.pmab105_desc,g_pmab_m.pmab088, 
       g_pmab_m.pmab088_desc,g_pmab_m.pmab089,g_pmab_m.pmab089_desc,g_pmab_m.pmab107,g_pmab_m.pmab108, 
       g_pmab_m.pmab090,g_pmab_m.pmab090_desc,g_pmab_m.pmab091,g_pmab_m.pmab091_desc,g_pmab_m.pmab092, 
       g_pmab_m.pmab092_desc,g_pmab_m.pmab093,g_pmab_m.pmab093_desc,g_pmab_m.pmab094,g_pmab_m.pmab095, 
       g_pmab_m.pmab096,g_pmab_m.pmab097,g_pmab_m.pmab097_desc,g_pmab_m.pmab098,g_pmab_m.pmab099,g_pmab_m.pmab100, 
       g_pmab_m.pmab101,g_pmab_m.pmab102,g_pmab_m.pmab030,g_pmab_m.pmab031,g_pmab_m.pmab031_desc,g_pmab_m.pmab059, 
       g_pmab_m.pmab059_desc,g_pmab_m.pmab032,g_pmab_m.pmab110,g_pmab_m.pmab033,g_pmab_m.pmab033_desc, 
       g_pmab_m.pmab034,g_pmab_m.pmab034_desc,g_pmab_m.pmab053,g_pmab_m.pmab053_desc,g_pmab_m.pmab054, 
       g_pmab_m.pmab054_desc,g_pmab_m.pmab035,g_pmab_m.pmab036,g_pmab_m.pmab056,g_pmab_m.pmab056_desc, 
       g_pmab_m.pmab037,g_pmab_m.pmab037_desc,g_pmab_m.pmab055,g_pmab_m.pmab055_desc,g_pmab_m.pmab038, 
       g_pmab_m.pmab038_desc,g_pmab_m.pmab039,g_pmab_m.pmab039_desc,g_pmab_m.pmab057,g_pmab_m.pmab058, 
       g_pmab_m.pmab040,g_pmab_m.pmab040_desc,g_pmab_m.pmab041,g_pmab_m.pmab041_desc,g_pmab_m.pmab042, 
       g_pmab_m.pmab042_desc,g_pmab_m.pmab043,g_pmab_m.pmab043_desc,g_pmab_m.pmab044,g_pmab_m.pmab045, 
       g_pmab_m.pmab046,g_pmab_m.pmab047,g_pmab_m.pmab047_desc,g_pmab_m.pmab048,g_pmab_m.pmab049,g_pmab_m.pmab050, 
       g_pmab_m.pmab051,g_pmab_m.pmab052,g_pmab_m.pmab071,g_pmab_m.pmab072,g_pmab_m.pmab073,g_pmab_m.pmab060, 
       g_pmab_m.pmab061,g_pmab_m.pmab066,g_pmab_m.pmab062,g_pmab_m.pmab067,g_pmab_m.pmab063,g_pmab_m.pmab068, 
       g_pmab_m.pmab064,g_pmab_m.pmab069,g_pmab_m.pmab065,g_pmab_m.pmab070,g_pmab_m.l_total,g_pmab_m.pmab002, 
       g_pmab_m.pmab003,g_pmab_m.pmab003_desc,g_pmab_m.pmab004,g_pmab_m.pmab004_desc,g_pmab_m.pmab005, 
       g_pmab_m.pmab005_desc,g_pmab_m.pmab006,g_pmab_m.pmab007,g_pmab_m.pmab008,g_pmab_m.pmab009,g_pmab_m.pmab019, 
       g_pmab_m.pmab010,g_pmab_m.pmab020,g_pmab_m.pmab011,g_pmab_m.pmab012,g_pmab_m.pmab013,g_pmab_m.pmab014, 
       g_pmab_m.pmab015,g_pmab_m.pmab016,g_pmab_m.pmab017,g_pmab_m.pmab018,g_pmab_m.ooff013,g_pmab_m.pmabownid, 
       g_pmab_m.pmabownid_desc,g_pmab_m.pmabowndp,g_pmab_m.pmabowndp_desc,g_pmab_m.pmabcrtid,g_pmab_m.pmabcrtid_desc, 
       g_pmab_m.pmabcrtdp,g_pmab_m.pmabcrtdp_desc,g_pmab_m.pmabcrtdt,g_pmab_m.pmabmodid,g_pmab_m.pmabmodid_desc, 
       g_pmab_m.pmabmoddt
   
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
   CALL apmm101_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL apmm101_set_no_entry(p_cmd)
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   #add-point:資料輸入前 name="input.before_input"
   LET g_errshow = 1
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #單頭段
      INPUT BY NAME g_pmab_m.pmab001,g_pmab_m.pmaal003,g_pmab_m.pmaal006,g_pmab_m.pmab080,g_pmab_m.pmab081, 
          g_pmab_m.pmab109,g_pmab_m.pmab082,g_pmab_m.pmab111,g_pmab_m.pmab083,g_pmab_m.pmab084,g_pmab_m.pmab103, 
          g_pmab_m.pmab104,g_pmab_m.pmab085,g_pmab_m.pmab086,g_pmab_m.pmab106,g_pmab_m.pmab087,g_pmab_m.pmab105, 
          g_pmab_m.pmab088,g_pmab_m.pmab089,g_pmab_m.pmab107,g_pmab_m.pmab108,g_pmab_m.pmab090,g_pmab_m.pmab091, 
          g_pmab_m.pmab092,g_pmab_m.pmab093,g_pmab_m.pmab094,g_pmab_m.pmab095,g_pmab_m.pmab096,g_pmab_m.pmab097, 
          g_pmab_m.pmab098,g_pmab_m.pmab099,g_pmab_m.pmab100,g_pmab_m.pmab101,g_pmab_m.pmab102,g_pmab_m.pmab030, 
          g_pmab_m.pmab031,g_pmab_m.pmab059,g_pmab_m.pmab032,g_pmab_m.pmab110,g_pmab_m.pmab033,g_pmab_m.pmab034, 
          g_pmab_m.pmab053,g_pmab_m.pmab054,g_pmab_m.pmab035,g_pmab_m.pmab036,g_pmab_m.pmab056,g_pmab_m.pmab037, 
          g_pmab_m.pmab055,g_pmab_m.pmab038,g_pmab_m.pmab039,g_pmab_m.pmab057,g_pmab_m.pmab058,g_pmab_m.pmab040, 
          g_pmab_m.pmab041,g_pmab_m.pmab042,g_pmab_m.pmab043,g_pmab_m.pmab044,g_pmab_m.pmab045,g_pmab_m.pmab046, 
          g_pmab_m.pmab047,g_pmab_m.pmab048,g_pmab_m.pmab049,g_pmab_m.pmab050,g_pmab_m.pmab051,g_pmab_m.pmab052, 
          g_pmab_m.pmab071,g_pmab_m.pmab072,g_pmab_m.pmab073,g_pmab_m.pmab060,g_pmab_m.pmab061,g_pmab_m.pmab066, 
          g_pmab_m.pmab062,g_pmab_m.pmab067,g_pmab_m.pmab063,g_pmab_m.pmab068,g_pmab_m.pmab064,g_pmab_m.pmab069, 
          g_pmab_m.pmab065,g_pmab_m.pmab070,g_pmab_m.l_total,g_pmab_m.pmab002,g_pmab_m.pmab003,g_pmab_m.pmab004, 
          g_pmab_m.pmab005,g_pmab_m.pmab006,g_pmab_m.pmab007,g_pmab_m.pmab008,g_pmab_m.pmab009,g_pmab_m.pmab019, 
          g_pmab_m.pmab010,g_pmab_m.pmab020,g_pmab_m.pmab011,g_pmab_m.pmab012,g_pmab_m.pmab013,g_pmab_m.pmab014, 
          g_pmab_m.pmab015,g_pmab_m.pmab016,g_pmab_m.pmab017,g_pmab_m.pmab018,g_pmab_m.ooff013 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            #其他table資料備份(確定是否更改用)
            
            #add-point:input開始前 name="input.before.input"
            
            #end add-point
   
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab001
            #add-point:BEFORE FIELD pmab001 name="input.b.pmab001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab001
            
            #add-point:AFTER FIELD pmab001 name="input.a.pmab001"
            #此段落由子樣板a05產生
            #modify--2015/06/25 By shiun--(S)
            CALL apmm101_pmab001_ref(g_pmab_m.pmab001) 
               RETURNING g_pmab_m.pmaa002,g_pmab_m.pmaal004,g_pmab_m.pmaal003,g_pmab_m.pmaal006,g_pmab_m.pmaal005,g_pmab_m.pmaa003,g_pmab_m.status1
            DISPLAY BY NAME g_pmab_m.pmaa002,g_pmab_m.pmaal004,g_pmab_m.pmaal003,g_pmab_m.pmaal006,g_pmab_m.pmaal005,g_pmab_m.pmaa003,g_pmab_m.status1
            #modify--2015/06/25 By shiun--(E)
            IF  NOT cl_null(g_pmab_m.pmab001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_pmab_m.pmab001 != g_pmab001_t ))) THEN 
                  IF NOT apmm101_pmab001_chk(g_pmab_m.pmab001) THEN
                     LET g_pmab_m.pmab001 = g_pmab_m_t.pmab001
                     #modify--2015/06/25 By shiun--(S)
                     CALL apmm101_pmab001_ref(g_pmab_m.pmab001) 
                        RETURNING g_pmab_m.pmaa002,g_pmab_m.pmaal004,g_pmab_m.pmaal003,g_pmab_m.pmaal006,g_pmab_m.pmaal005,g_pmab_m.pmaa003,g_pmab_m.status1
                     DISPLAY BY NAME g_pmab_m.pmaa002,g_pmab_m.pmaal004,g_pmab_m.pmaal003,g_pmab_m.pmaal006,g_pmab_m.pmaal005,g_pmab_m.pmaa003,g_pmab_m.status1
                     #modify--2015/06/25 By shiun--(E)
                     NEXT FIELD CURRENT
                  END IF
               END IF
              
            END IF
            
            #新增狀態:
            #1.新增時p_site若不等於'ALL'或為NULL時，則pmab_t所有欄位值預設為'ALL'的那一筆資料
            IF p_cmd = 'a' THEN
               IF cl_null(g_argv[02]) OR g_argv[02] != 'ALL' THEN
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n FROM pmab_t WHERE pmabent = g_enterprise AND pmabsite = 'ALL' AND pmab001 = g_pmab_m.pmab001
                  IF l_n > 0 THEN
                     CALL apmm101_pmab001_show()
                     DISPLAY BY NAME g_pmab_m.pmab001,g_pmab_m.pmaal004,g_pmab_m.pmaal005,g_pmab_m.status1,g_pmab_m.pmaa002,g_pmab_m.pmaal003,g_pmab_m.pmaa003,g_pmab_m.pmab080,g_pmab_m.pmab081,g_pmab_m.pmab081_desc,g_pmab_m.pmab082,g_pmab_m.pmab083,g_pmab_m.pmab083_desc,g_pmab_m.pmab084,g_pmab_m.pmab084_desc,g_pmab_m.pmab103,g_pmab_m.pmab103_desc,g_pmab_m.pmab104,g_pmab_m.pmab085,g_pmab_m.pmab087,g_pmab_m.pmab088,g_pmab_m.pmab089,g_pmab_m.pmab089_desc,g_pmab_m.pmab090,g_pmab_m.pmab090_desc,g_pmab_m.pmab091,g_pmab_m.pmab091_desc,g_pmab_m.pmab092,g_pmab_m.pmab092_desc,g_pmab_m.pmab093,g_pmab_m.pmab093_desc,g_pmab_m.pmab094,g_pmab_m.pmab095,g_pmab_m.pmab096,g_pmab_m.pmab097,g_pmab_m.pmab097_desc,g_pmab_m.pmab098,g_pmab_m.pmab099,g_pmab_m.pmab100,g_pmab_m.pmab101,g_pmab_m.pmab102,g_pmab_m.pmab030,g_pmab_m.pmab031,g_pmab_m.pmab031_desc,g_pmab_m.pmab032,g_pmab_m.pmab033,g_pmab_m.pmab033_desc,g_pmab_m.pmab034,g_pmab_m.pmab034_desc,g_pmab_m.pmab053,g_pmab_m.pmab053_desc,g_pmab_m.pmab054,g_pmab_m.pmab035,g_pmab_m.pmab037,g_pmab_m.pmab038,g_pmab_m.pmab039,g_pmab_m.pmab039_desc,g_pmab_m.pmab040,g_pmab_m.pmab040_desc,g_pmab_m.pmab041,g_pmab_m.pmab041_desc,g_pmab_m.pmab042,g_pmab_m.pmab042_desc,g_pmab_m.pmab043,g_pmab_m.pmab043_desc,g_pmab_m.pmab044,g_pmab_m.pmab045,g_pmab_m.pmab046,g_pmab_m.pmab047,g_pmab_m.pmab047_desc,g_pmab_m.pmab048,g_pmab_m.pmab049,g_pmab_m.pmab050,g_pmab_m.pmab051,g_pmab_m.pmab052,g_pmab_m.pmab071,g_pmab_m.pmab072,g_pmab_m.pmab073,g_pmab_m.pmab060,g_pmab_m.pmab061,g_pmab_m.pmab066,g_pmab_m.pmab062,g_pmab_m.pmab067,g_pmab_m.pmab063,g_pmab_m.pmab068,g_pmab_m.pmab064,g_pmab_m.pmab069,g_pmab_m.pmab065,g_pmab_m.pmab070,g_pmab_m.l_total,g_pmab_m.pmab002,g_pmab_m.pmab003,g_pmab_m.pmab003_desc,g_pmab_m.pmab004,g_pmab_m.pmab005,g_pmab_m.pmab005_desc,g_pmab_m.pmab006,g_pmab_m.pmab007,g_pmab_m.pmab008,g_pmab_m.pmab009,g_pmab_m.pmab019,g_pmab_m.pmab010,g_pmab_m.pmab020,g_pmab_m.pmab011,g_pmab_m.pmab012,g_pmab_m.pmab013,g_pmab_m.pmab014,g_pmab_m.pmab015,g_pmab_m.pmab016,g_pmab_m.pmab017,g_pmab_m.pmab018,g_pmab_m.ooff013,g_pmab_m.pmabownid,g_pmab_m.pmabownid_desc,g_pmab_m.pmabowndp,g_pmab_m.pmabowndp_desc,g_pmab_m.pmabcrtid,g_pmab_m.pmabcrtid_desc,g_pmab_m.pmabcrtdt,g_pmab_m.pmabcrtdp,g_pmab_m.pmabcrtdp_desc,g_pmab_m.pmabmodid,g_pmab_m.pmabmodid_desc,g_pmab_m.pmabmoddt
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab001
            #add-point:ON CHANGE pmab001 name="input.g.pmab001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaal003
            #add-point:BEFORE FIELD pmaal003 name="input.b.pmaal003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaal003
            
            #add-point:AFTER FIELD pmaal003 name="input.a.pmaal003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaal003
            #add-point:ON CHANGE pmaal003 name="input.g.pmaal003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaal006
            #add-point:BEFORE FIELD pmaal006 name="input.b.pmaal006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaal006
            
            #add-point:AFTER FIELD pmaal006 name="input.a.pmaal006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaal006
            #add-point:ON CHANGE pmaal006 name="input.g.pmaal006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab080
            #add-point:BEFORE FIELD pmab080 name="input.b.pmab080"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab080
            
            #add-point:AFTER FIELD pmab080 name="input.a.pmab080"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab080
            #add-point:ON CHANGE pmab080 name="input.g.pmab080"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab081
            
            #add-point:AFTER FIELD pmab081 name="input.a.pmab081"
            CALL apmm101_pmab081_ref(g_pmab_m.pmab081) RETURNING g_pmab_m.pmab081_desc
            DISPLAY BY NAME g_pmab_m.pmab081_desc
            IF NOT cl_null(g_pmab_m.pmab081) THEN
            #150304---earl---add---s
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmab_m.pmab081 != g_pmab_m_t.pmab081 OR cl_null(g_pmab_m_t.pmab081))) THEN 
               IF g_pmab_m.pmab081 <> g_pmab_m_o.pmab081 OR cl_null(g_pmab_m_o.pmab081) THEN
                  IF NOT apmm101_pmab081_chk(g_pmab_m.pmab081) THEN
                     #LET g_pmab_m.pmab081 = g_pmab_m_t.pmab081
                     LET g_pmab_m.pmab081 = g_pmab_m_o.pmab081
                     CALL apmm101_pmab081_ref(g_pmab_m.pmab081) RETURNING g_pmab_m.pmab081_desc
                     DISPLAY BY NAME g_pmab_m.pmab081_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  #帶出部門
                  CALL s_employee_get_dept(g_pmab_m.pmab081) RETURNING l_success,l_errno,g_pmab_m.pmab109,g_pmab_m.pmab109_desc
                  DISPLAY BY NAME g_pmab_m.pmab109
                  DISPLAY BY NAME g_pmab_m.pmab109_desc
                  LET g_pmab_m_o.pmab109 = g_pmab_m.pmab109
                  
               END IF
            END IF
            
            LET g_pmab_m_o.pmab081 = g_pmab_m.pmab081
            #150304---earl---add---e
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab081
            #add-point:BEFORE FIELD pmab081 name="input.b.pmab081"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab081
            #add-point:ON CHANGE pmab081 name="input.g.pmab081"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab109
            
            #add-point:AFTER FIELD pmab109 name="input.a.pmab109"
            CALL s_desc_get_department_desc(g_pmab_m.pmab109) RETURNING g_pmab_m.pmab109_desc
            DISPLAY BY NAME g_pmab_m.pmab109_desc

            IF NOT cl_null(g_pmab_m.pmab109) THEN 
               IF g_pmab_m.pmab109 <> g_pmab_m_o.pmab109 OR cl_null(g_pmab_m_o.pmab109) THEN 
                  IF NOT s_department_chk(g_pmab_m.pmab109,g_today) THEN
                     LET g_pmab_m.pmab109 = g_pmab_m_o.pmab109

                     CALL s_desc_get_department_desc(g_pmab_m.pmab109) RETURNING g_pmab_m.pmab109_desc
                     DISPLAY BY NAME g_pmab_m.pmab109_desc

                     NEXT FIELD CURRENT
                  END IF
               END IF               
            END IF
            
            LET g_pmab_m_o.pmab109 = g_pmab_m.pmab109
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab109
            #add-point:BEFORE FIELD pmab109 name="input.b.pmab109"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab109
            #add-point:ON CHANGE pmab109 name="input.g.pmab109"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab082
            #add-point:BEFORE FIELD pmab082 name="input.b.pmab082"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab082
            
            #add-point:AFTER FIELD pmab082 name="input.a.pmab082"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab082
            #add-point:ON CHANGE pmab082 name="input.g.pmab082"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab111
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmab_m.pmab111,"1","1","","","azz-00079",1) THEN
               NEXT FIELD pmab111
            END IF 
 
 
 
            #add-point:AFTER FIELD pmab111 name="input.a.pmab111"
            IF NOT cl_null(g_pmab_m.pmab111) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab111
            #add-point:BEFORE FIELD pmab111 name="input.b.pmab111"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab111
            #add-point:ON CHANGE pmab111 name="input.g.pmab111"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab083
            
            #add-point:AFTER FIELD pmab083 name="input.a.pmab083"
            CALL apmm101_pmab083_ref(g_pmab_m.pmab083) RETURNING g_pmab_m.pmab083_desc
            DISPLAY BY NAME g_pmab_m.pmab083_desc
            
            IF  NOT cl_null(g_pmab_m.pmab083) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmab_m.pmab083 != g_pmab_m_t.pmab083 OR cl_null(g_pmab_m_t.pmab083))) THEN 
                  IF NOT apmm101_pmab083_chk(g_pmab_m.pmab083) THEN
                     LET g_pmab_m.pmab083 = g_pmab_m_t.pmab083
                     CALL apmm101_pmab083_ref(g_pmab_m.pmab083) RETURNING g_pmab_m.pmab083_desc
                     DISPLAY BY NAME g_pmab_m.pmab083_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab083
            #add-point:BEFORE FIELD pmab083 name="input.b.pmab083"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab083
            #add-point:ON CHANGE pmab083 name="input.g.pmab083"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab084
            
            #add-point:AFTER FIELD pmab084 name="input.a.pmab084"
            CALL apmm101_pmab084_ref(g_pmab_m.pmab084) RETURNING g_pmab_m.pmab084_desc
            DISPLAY BY NAME g_pmab_m.pmab084_desc
            
            IF  NOT cl_null(g_pmab_m.pmab084) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmab_m.pmab084 != g_pmab_m_t.pmab084 OR cl_null(g_pmab_m_t.pmab084))) THEN 
                  IF NOT apmm101_pmab084_chk(g_pmab_m.pmab084) THEN
                     LET g_pmab_m.pmab084 = g_pmab_m_t.pmab084
                     CALL apmm101_pmab084_ref(g_pmab_m.pmab084) RETURNING g_pmab_m.pmab084_desc
                     DISPLAY BY NAME g_pmab_m.pmab084_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab084
            #add-point:BEFORE FIELD pmab084 name="input.b.pmab084"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab084
            #add-point:ON CHANGE pmab084 name="input.g.pmab084"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab103
            
            #add-point:AFTER FIELD pmab103 name="input.a.pmab103"
            CALL apmm101_pmab103_ref(g_pmab_m.pmab103) RETURNING g_pmab_m.pmab103_desc
            DISPLAY BY NAME g_pmab_m.pmab103_desc
            
            IF  NOT cl_null(g_pmab_m.pmab103) THEN 
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmab_m.pmab103 != g_pmab_m_t.pmab103 OR cl_null(g_pmab_m_t.pmab103))) THEN   #170203-00002#12 20170208 mark by beckxie
               IF g_pmab_m.pmab103 != g_pmab_m_o.pmab103 OR cl_null(g_pmab_m_o.pmab103) THEN   #170203-00002#12 20170208 add by beckxie
                  IF NOT apmm101_pmab103_chk(g_pmab_m.pmab103) THEN
                     #LET g_pmab_m.pmab103 = g_pmab_m_t.pmab103    #170203-00002#12 20170208 mark by beckxie
                     #170203-00002#12 20170208 add by beckxie---S
                     LET g_pmab_m.pmab103 = g_pmab_m_o.pmab103
                     LET g_pmab_m.pmab104 = g_pmab_m_o.pmab104
                     CALL apmm101_pmab104_ref(g_pmab_m.pmab104) RETURNING g_pmab_m.pmab104_desc
                     DISPLAY BY NAME g_pmab_m.pmab104,g_pmab_m.pmab104_desc
                     #170203-00002#12 20170208 add by beckxie---E
                     CALL apmm101_pmab103_ref(g_pmab_m.pmab103) RETURNING g_pmab_m.pmab103_desc
                     DISPLAY BY NAME g_pmab_m.pmab103_desc
                     NEXT FIELD CURRENT
                  END IF
                  IF cl_null(g_pmab_m.pmab104) THEN  #151202-00025 by whitney add
                     SELECT oocq005 INTO g_pmab_m.pmab104 FROM oocq_t WHERE oocqent = g_enterprise AND oocq001 = '238' AND oocq002 = g_pmab_m.pmab103
                     CALL apmm101_pmab104_ref(g_pmab_m.pmab104) RETURNING g_pmab_m.pmab104_desc
                     DISPLAY BY NAME g_pmab_m.pmab104_desc
                  END IF  #151202-00025 by whitney add
               END IF
            END IF
            LET g_pmab_m_o.* = g_pmab_m.*   #170203-00002#12 20170208 add by beckxie
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab103
            #add-point:BEFORE FIELD pmab103 name="input.b.pmab103"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab103
            #add-point:ON CHANGE pmab103 name="input.g.pmab103"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab104
            
            #add-point:AFTER FIELD pmab104 name="input.a.pmab104"
            CALL apmm101_pmab104_ref(g_pmab_m.pmab104) RETURNING g_pmab_m.pmab104_desc
            DISPLAY BY NAME g_pmab_m.pmab104_desc
            
            IF  NOT cl_null(g_pmab_m.pmab104) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmab_m.pmab104 != g_pmab_m_t.pmab104 OR cl_null(g_pmab_m_t.pmab104))) THEN 
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL

                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_pmab_m.pmab104
                  
                  #160318-00025#37  2016/04/19  by pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "axm-00026:sub-01302|axmi130|",cl_get_progname("axmi130",g_lang,"2"),"|:EXEPROGaxmi130"
                  #160318-00025#37  2016/04/19  by pengxin  add(E)
                  
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_xmah001") THEN
                     LET g_pmab_m.pmab104 = g_pmab_m_t.pmab104
                     CALL apmm101_pmab104_ref(g_pmab_m.pmab104) RETURNING g_pmab_m.pmab104_desc
                     DISPLAY BY NAME g_pmab_m.pmab104_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_pmab_m_o.* = g_pmab_m.*   #170203-00002#12 20170208 add by beckxie
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab104
            #add-point:BEFORE FIELD pmab104 name="input.b.pmab104"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab104
            #add-point:ON CHANGE pmab104 name="input.g.pmab104"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab085
            #add-point:BEFORE FIELD pmab085 name="input.b.pmab085"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab085
            
            #add-point:AFTER FIELD pmab085 name="input.a.pmab085"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab085
            #add-point:ON CHANGE pmab085 name="input.g.pmab085"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab086
            #add-point:BEFORE FIELD pmab086 name="input.b.pmab086"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab086
            
            #add-point:AFTER FIELD pmab086 name="input.a.pmab086"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab086
            #add-point:ON CHANGE pmab086 name="input.g.pmab086"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab106
            
            #add-point:AFTER FIELD pmab106 name="input.a.pmab106"
            CALL apmm101_pmab106_ref(g_pmab_m.pmab106) RETURNING g_pmab_m.pmab106_desc
            DISPLAY BY NAME g_pmab_m.pmab106_desc
            IF NOT cl_null(g_pmab_m.pmab106) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_ooef019
               LET g_chkparam.arg2 = g_pmab_m.pmab106

               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_isac002") THEN
                  LET g_pmab_m.pmab106 = g_pmab_m_t.pmab106
                  CALL apmm101_pmab106_ref(g_pmab_m.pmab106) RETURNING g_pmab_m.pmab106_desc
                  DISPLAY BY NAME g_pmab_m.pmab106_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab106
            #add-point:BEFORE FIELD pmab106 name="input.b.pmab106"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab106
            #add-point:ON CHANGE pmab106 name="input.g.pmab106"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab087
            
            #add-point:AFTER FIELD pmab087 name="input.a.pmab087"
            CALL apmm101_pmab087_ref(g_pmab_m.pmab087) RETURNING g_pmab_m.pmab087_desc
            DISPLAY BY NAME g_pmab_m.pmab087_desc
            
            IF NOT cl_null(g_pmab_m.pmab087) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmab_m.pmab087 != g_pmab_m_t.pmab087 OR cl_null(g_pmab_m_t.pmab087))) THEN 
                  IF NOT apmm101_pmab087_chk(g_pmab_m.pmab087,'2') THEN
                     LET g_pmab_m.pmab087 = g_pmab_m_t.pmab087
                     CALL apmm101_pmab087_ref(g_pmab_m.pmab087) RETURNING g_pmab_m.pmab087_desc
                     DISPLAY BY NAME g_pmab_m.pmab087_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab087
            #add-point:BEFORE FIELD pmab087 name="input.b.pmab087"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab087
            #add-point:ON CHANGE pmab087 name="input.g.pmab087"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab105
            
            #add-point:AFTER FIELD pmab105 name="input.a.pmab105"
            CALL apmm101_pmab105_ref(g_pmab_m.pmab105) RETURNING g_pmab_m.pmab105_desc
            DISPLAY BY NAME g_pmab_m.pmab105_desc
            
            IF  NOT cl_null(g_pmab_m.pmab105) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmab_m.pmab105 != g_pmab_m_t.pmab105 OR cl_null(g_pmab_m_t.pmab105))) THEN 
                  #IF NOT ap_chk_isExist(g_pmab_m.pmab105,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '3111' AND oocq002 = ? ","apm-00181",1 ) THEN         #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmab_m.pmab105,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '3111' AND oocq002 = ? ","sub-01303",'axri010') THEN   #160318-00005#34
                     LET g_pmab_m.pmab105 = g_pmab_m_t.pmab105
                     CALL apmm101_pmab105_ref(g_pmab_m.pmab105) RETURNING g_pmab_m.pmab105_desc
                     DISPLAY BY NAME g_pmab_m.pmab105_desc 
                     NEXT FIELD CURRENT
                  END IF
                  #IF NOT ap_chk_isExist(g_pmab_m.pmab105,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '3111' AND oocq002 = ? AND oocqstus = 'Y' ","apm-00182",1 ) THEN            #160318-00005#34
                   IF NOT ap_chk_isExist(g_pmab_m.pmab105,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '3111' AND oocq002 = ? AND oocqstus = 'Y' ","sub-01302",'axri010' ) THEN    #160318-00005#34
                     LET g_pmab_m.pmab105 = g_pmab_m_t.pmab105
                     CALL apmm101_pmab105_ref(g_pmab_m.pmab105) RETURNING g_pmab_m.pmab105_desc
                     DISPLAY BY NAME g_pmab_m.pmab105_desc 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
           
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab105
            #add-point:BEFORE FIELD pmab105 name="input.b.pmab105"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab105
            #add-point:ON CHANGE pmab105 name="input.g.pmab105"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab088
            
            #add-point:AFTER FIELD pmab088 name="input.a.pmab088"
            CALL apmm101_pmab088_ref(g_pmab_m.pmab088) RETURNING g_pmab_m.pmab088_desc
            DISPLAY BY NAME g_pmab_m.pmab088_desc
            IF NOT cl_null(g_pmab_m.pmab088) THEN
               #160621-00003#3 20160627 modify by beckxie---S
               #IF NOT s_azzi650_chk_exist('275',g_pmab_m.pmab088) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_pmab_m.pmab088
               LET g_chkparam.arg2 = '1'
               LET g_chkparam.err_str[1] = "aoo-00299|",l_msg1
               IF NOT cl_chk_exist("v_oojd001") THEN
               #160621-00003#3 20160627 modify by beckxie---E
                  LET g_pmab_m.pmab088 = g_pmab_m_t.pmab088
                  CALL apmm101_pmab088_ref(g_pmab_m.pmab088) RETURNING g_pmab_m.pmab088_desc
                  DISPLAY BY NAME g_pmab_m.pmab088_desc
                  NEXT FIELD CURRENT
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab088
            #add-point:BEFORE FIELD pmab088 name="input.b.pmab088"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab088
            #add-point:ON CHANGE pmab088 name="input.g.pmab088"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab089
            
            #add-point:AFTER FIELD pmab089 name="input.a.pmab089"
            CALL apmm101_pmab089_ref(g_pmab_m.pmab089) RETURNING g_pmab_m.pmab089_desc
            DISPLAY BY NAME g_pmab_m.pmab089_desc
            
            IF  NOT cl_null(g_pmab_m.pmab089) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmab_m.pmab089 != g_pmab_m_t.pmab089 OR cl_null(g_pmab_m_t.pmab089))) THEN 
                  #IF NOT ap_chk_isExist(g_pmab_m.pmab089,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '295' AND oocq002 = ? ","apm-00168",1 ) THEN                         #160318-00005#3
                  IF NOT ap_chk_isExist(g_pmab_m.pmab089,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '295' AND oocq002 = ? ","sub-01303",'axmi035' ) THEN                  #160318-00005#3
                     LET g_pmab_m.pmab089 = g_pmab_m_t.pmab089
                     CALL apmm101_pmab089_ref(g_pmab_m.pmab089) RETURNING g_pmab_m.pmab089_desc
                     DISPLAY BY NAME g_pmab_m.pmab089_desc 
                     NEXT FIELD CURRENT
                  END IF
                  #IF NOT ap_chk_isExist(g_pmab_m.pmab089,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '295' AND oocq002 = ? AND oocqstus = 'Y' ","apm-00169",1 ) THEN          #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmab_m.pmab089,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '295' AND oocq002 = ? AND oocqstus = 'Y' ","sub-01302",'axmi035' ) THEN   #160318-00005#34
                     LET g_pmab_m.pmab089 = g_pmab_m_t.pmab089
                     CALL apmm101_pmab089_ref(g_pmab_m.pmab089) RETURNING g_pmab_m.pmab089_desc
                     DISPLAY BY NAME g_pmab_m.pmab089_desc 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
           

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab089
            #add-point:BEFORE FIELD pmab089 name="input.b.pmab089"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab089
            #add-point:ON CHANGE pmab089 name="input.g.pmab089"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab107
            #add-point:BEFORE FIELD pmab107 name="input.b.pmab107"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab107
            
            #add-point:AFTER FIELD pmab107 name="input.a.pmab107"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab107
            #add-point:ON CHANGE pmab107 name="input.g.pmab107"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab108
            #add-point:BEFORE FIELD pmab108 name="input.b.pmab108"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab108
            
            #add-point:AFTER FIELD pmab108 name="input.a.pmab108"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab108
            #add-point:ON CHANGE pmab108 name="input.g.pmab108"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab090
            
            #add-point:AFTER FIELD pmab090 name="input.a.pmab090"
            CALL apmm101_pmab090_ref(g_pmab_m.pmab090) RETURNING g_pmab_m.pmab090_desc
            DISPLAY BY NAME g_pmab_m.pmab090_desc
            
            IF  NOT cl_null(g_pmab_m.pmab090) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmab_m.pmab090 != g_pmab_m_t.pmab090 OR cl_null(g_pmab_m_t.pmab090))) THEN 
                  IF NOT apmm101_pmab090_chk(g_pmab_m.pmab090) THEN
                     LET g_pmab_m.pmab090 = g_pmab_m_t.pmab090
                     CALL apmm101_pmab090_ref(g_pmab_m.pmab090) RETURNING g_pmab_m.pmab090_desc
                     DISPLAY BY NAME g_pmab_m.pmab090_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            #161231-00008#1 add  --begin--
               CALL cl_set_comp_entry("pmab091,pmab092",TRUE)
            ELSE
               CALL cl_set_comp_entry("pmab091,pmab092",FALSE)
            #161231-00008#1 add  --end--
            END IF
            
            
           
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab090
            #add-point:BEFORE FIELD pmab090 name="input.b.pmab090"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab090
            #add-point:ON CHANGE pmab090 name="input.g.pmab090"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab091
            
            #add-point:AFTER FIELD pmab091 name="input.a.pmab091"
            CALL s_apmi011_location_ref(g_pmab_m.pmab090,g_pmab_m.pmab091) RETURNING g_pmab_m.pmab091_desc
            DISPLAY BY NAME g_pmab_m.pmab091_desc
            
            IF  NOT cl_null(g_pmab_m.pmab091) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmab_m.pmab091 != g_pmab_m_t.pmab091 OR cl_null(g_pmab_m_t.pmab091))) THEN 
                  IF NOT s_apmi011_check_location(g_pmab_m.pmab090,g_pmab_m.pmab091) THEN
                     LET g_pmab_m.pmab091 = g_pmab_m_t.pmab091
                     CALL s_apmi011_location_ref(g_pmab_m.pmab090,g_pmab_m.pmab091) RETURNING g_pmab_m.pmab091_desc
                     DISPLAY BY NAME g_pmab_m.pmab091_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab091
            #add-point:BEFORE FIELD pmab091 name="input.b.pmab091"
            IF cl_null(g_pmab_m.pmab090) THEN  #運輸類型
            #161231-00008#1 mark --begin--
            #  INITIALIZE g_errparam TO NULL
            #  LET g_errparam.code = 'axm-00085'
            #  LET g_errparam.extend = ''
            #  LET g_errparam.popup = TRUE
            #  CALL cl_err()
            #  #請先輸入運輸方式
            #  NEXT FIELD pmab090
            #161231-00008#1 mark --end--
            #161231-00008#1 add  --begin--
               CALL cl_set_comp_entry("pmab091",FALSE)
            ELSE
               CALL cl_set_comp_entry("pmab091",TRUE)
            #161231-00008#1 add  --end--           
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab091
            #add-point:ON CHANGE pmab091 name="input.g.pmab091"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab092
            
            #add-point:AFTER FIELD pmab092 name="input.a.pmab092"
            CALL s_apmi011_location_ref(g_pmab_m.pmab090,g_pmab_m.pmab092) RETURNING g_pmab_m.pmab092_desc
            DISPLAY BY NAME g_pmab_m.pmab092_desc
            
            IF  NOT cl_null(g_pmab_m.pmab092) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmab_m.pmab092 != g_pmab_m_t.pmab092 OR cl_null(g_pmab_m_t.pmab092))) THEN 
                  IF NOT s_apmi011_check_location(g_pmab_m.pmab090,g_pmab_m.pmab092) THEN
                     LET g_pmab_m.pmab092 = g_pmab_m_t.pmab092
                     CALL s_apmi011_location_ref(g_pmab_m.pmab090,g_pmab_m.pmab092) RETURNING g_pmab_m.pmab092_desc
                     DISPLAY BY NAME g_pmab_m.pmab092_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab092
            #add-point:BEFORE FIELD pmab092 name="input.b.pmab092"
            IF cl_null(g_pmab_m.pmab090) THEN  #運輸類型
            #161231-00008#1 mark --begin--
            #  INITIALIZE g_errparam TO NULL
            #  LET g_errparam.code = 'axm-00085'
            #  LET g_errparam.extend = ''
            #  LET g_errparam.popup = TRUE
            #  CALL cl_err()
            #  #請先輸入運輸方式
            #  NEXT FIELD pmab090
            #161231-00008#1 mark --end--
            #161231-00008#1 add  --begin--
               CALL cl_set_comp_entry("pmab092",FALSE)
            ELSE
               CALL cl_set_comp_entry("pmab092",TRUE)
            #161231-00008#1 add  --end--    
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab092
            #add-point:ON CHANGE pmab092 name="input.g.pmab092"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab093
            
            #add-point:AFTER FIELD pmab093 name="input.a.pmab093"
            CALL apmm101_pmab091_ref(g_pmab_m.pmab093) RETURNING g_pmab_m.pmab093_desc
            DISPLAY BY NAME g_pmab_m.pmab093_desc
            
            IF  NOT cl_null(g_pmab_m.pmab093) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmab_m.pmab093 != g_pmab_m_t.pmab093 OR cl_null(g_pmab_m_t.pmab093))) THEN 
                  IF NOT apmm101_pmab091_chk(g_pmab_m.pmab093) THEN
                     LET g_pmab_m.pmab093 = g_pmab_m_t.pmab093
                     CALL apmm101_pmab091_ref(g_pmab_m.pmab093) RETURNING g_pmab_m.pmab093_desc
                     DISPLAY BY NAME g_pmab_m.pmab093_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
           
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab093
            #add-point:BEFORE FIELD pmab093 name="input.b.pmab093"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab093
            #add-point:ON CHANGE pmab093 name="input.g.pmab093"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab094
            #add-point:BEFORE FIELD pmab094 name="input.b.pmab094"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab094
            
            #add-point:AFTER FIELD pmab094 name="input.a.pmab094"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab094
            #add-point:ON CHANGE pmab094 name="input.g.pmab094"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab095
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmab_m.pmab095,"0.000","1","100.000","1","azz-00087",1) THEN
               NEXT FIELD pmab095
            END IF 
 
 
 
            #add-point:AFTER FIELD pmab095 name="input.a.pmab095"
            IF NOT cl_null(g_pmab_m.pmab095) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab095
            #add-point:BEFORE FIELD pmab095 name="input.b.pmab095"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab095
            #add-point:ON CHANGE pmab095 name="input.g.pmab095"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab096
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmab_m.pmab096,"0.000","1","100.000","1","azz-00087",1) THEN
               NEXT FIELD pmab096
            END IF 
 
 
 
            #add-point:AFTER FIELD pmab096 name="input.a.pmab096"
            IF NOT cl_null(g_pmab_m.pmab096) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab096
            #add-point:BEFORE FIELD pmab096 name="input.b.pmab096"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab096
            #add-point:ON CHANGE pmab096 name="input.g.pmab096"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab097
            
            #add-point:AFTER FIELD pmab097 name="input.a.pmab097"
            CALL apmm101_pmab003_ref(g_pmab_m.pmab097) RETURNING g_pmab_m.pmab097_desc
            DISPLAY BY NAME g_pmab_m.pmab097_desc
            
            IF  NOT cl_null(g_pmab_m.pmab097) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmab_m.pmab097 != g_pmab_m_t.pmab097 OR cl_null(g_pmab_m_t.pmab097))) THEN 
                  IF NOT apmm101_pmab097_chk(g_pmab_m.pmab097) THEN
                     LET g_pmab_m.pmab097 = g_pmab_m_t.pmab097
                     CALL apmm101_pmab003_ref(g_pmab_m.pmab097) RETURNING g_pmab_m.pmab097_desc
                     DISPLAY BY NAME g_pmab_m.pmab097_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab097
            #add-point:BEFORE FIELD pmab097 name="input.b.pmab097"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab097
            #add-point:ON CHANGE pmab097 name="input.g.pmab097"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab098
            #add-point:BEFORE FIELD pmab098 name="input.b.pmab098"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab098
            
            #add-point:AFTER FIELD pmab098 name="input.a.pmab098"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab098
            #add-point:ON CHANGE pmab098 name="input.g.pmab098"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab099
            #add-point:BEFORE FIELD pmab099 name="input.b.pmab099"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab099
            
            #add-point:AFTER FIELD pmab099 name="input.a.pmab099"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab099
            #add-point:ON CHANGE pmab099 name="input.g.pmab099"
            CALL apmm101_set_entry(p_cmd)
            CALL apmm101_set_no_entry(p_cmd)
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab100
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmab_m.pmab100,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD pmab100
            END IF 
 
 
 
            #add-point:AFTER FIELD pmab100 name="input.a.pmab100"
            IF NOT cl_null(g_pmab_m.pmab100) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab100
            #add-point:BEFORE FIELD pmab100 name="input.b.pmab100"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab100
            #add-point:ON CHANGE pmab100 name="input.g.pmab100"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab101
            #add-point:BEFORE FIELD pmab101 name="input.b.pmab101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab101
            
            #add-point:AFTER FIELD pmab101 name="input.a.pmab101"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab101
            #add-point:ON CHANGE pmab101 name="input.g.pmab101"
            CALL apmm101_set_entry(p_cmd)
            CALL apmm101_set_no_entry(p_cmd)
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab102
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmab_m.pmab102,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD pmab102
            END IF 
 
 
 
            #add-point:AFTER FIELD pmab102 name="input.a.pmab102"
            IF NOT cl_null(g_pmab_m.pmab102) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab102
            #add-point:BEFORE FIELD pmab102 name="input.b.pmab102"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab102
            #add-point:ON CHANGE pmab102 name="input.g.pmab102"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab030
            #add-point:BEFORE FIELD pmab030 name="input.b.pmab030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab030
            
            #add-point:AFTER FIELD pmab030 name="input.a.pmab030"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab030
            #add-point:ON CHANGE pmab030 name="input.g.pmab030"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab031
            
            #add-point:AFTER FIELD pmab031 name="input.a.pmab031"
            CALL apmm101_pmab081_ref(g_pmab_m.pmab031) RETURNING g_pmab_m.pmab031_desc
            DISPLAY BY NAME g_pmab_m.pmab031_desc
            IF NOT cl_null(g_pmab_m.pmab031) THEN
            #150304---earl---add---s
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmab_m.pmab031 != g_pmab_m_t.pmab031 OR cl_null(g_pmab_m_t.pmab031))) THEN 
               IF g_pmab_m.pmab031 <> g_pmab_m_o.pmab031 OR cl_null(g_pmab_m_o.pmab031) THEN
                  IF NOT apmm101_pmab081_chk(g_pmab_m.pmab031) THEN
                     #LET g_pmab_m.pmab031 = g_pmab_m_t.pmab031
                     LET g_pmab_m.pmab031 = g_pmab_m_o.pmab031
                     CALL apmm101_pmab081_ref(g_pmab_m.pmab031) RETURNING g_pmab_m.pmab031_desc
                     DISPLAY BY NAME g_pmab_m.pmab031_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  #帶出部門
                  CALL s_employee_get_dept(g_pmab_m.pmab031) RETURNING l_success,l_errno,g_pmab_m.pmab059,g_pmab_m.pmab059_desc
                  DISPLAY BY NAME g_pmab_m.pmab059
                  DISPLAY BY NAME g_pmab_m.pmab059_desc
                  LET g_pmab_m_o.pmab059 = g_pmab_m.pmab059
                  
               END IF
            END IF
           
            LET g_pmab_m_o.pmab031 = g_pmab_m.pmab031
            #150304---earl---add---e
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab031
            #add-point:BEFORE FIELD pmab031 name="input.b.pmab031"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab031
            #add-point:ON CHANGE pmab031 name="input.g.pmab031"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab059
            
            #add-point:AFTER FIELD pmab059 name="input.a.pmab059"
            CALL s_desc_get_department_desc(g_pmab_m.pmab059) RETURNING g_pmab_m.pmab059_desc
            DISPLAY BY NAME g_pmab_m.pmab059_desc

            IF NOT cl_null(g_pmab_m.pmab059) THEN 
               IF g_pmab_m.pmab059 <> g_pmab_m_o.pmab059 OR cl_null(g_pmab_m_o.pmab059) THEN 
                  IF NOT s_department_chk(g_pmab_m.pmab059,g_today) THEN
                     LET g_pmab_m.pmab059 = g_pmab_m_o.pmab059

                     CALL s_desc_get_department_desc(g_pmab_m.pmab059) RETURNING g_pmab_m.pmab059_desc
                     DISPLAY BY NAME g_pmab_m.pmab059_desc

                     NEXT FIELD CURRENT
                  END IF
               END IF               
            END IF
            
            LET g_pmab_m_o.pmab059 = g_pmab_m.pmab059
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab059
            #add-point:BEFORE FIELD pmab059 name="input.b.pmab059"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab059
            #add-point:ON CHANGE pmab059 name="input.g.pmab059"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab032
            #add-point:BEFORE FIELD pmab032 name="input.b.pmab032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab032
            
            #add-point:AFTER FIELD pmab032 name="input.a.pmab032"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab032
            #add-point:ON CHANGE pmab032 name="input.g.pmab032"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab110
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmab_m.pmab110,"0","1","","","azz-00079",1) THEN
               NEXT FIELD pmab110
            END IF 
 
 
 
            #add-point:AFTER FIELD pmab110 name="input.a.pmab110"
            IF NOT cl_null(g_pmab_m.pmab110) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab110
            #add-point:BEFORE FIELD pmab110 name="input.b.pmab110"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab110
            #add-point:ON CHANGE pmab110 name="input.g.pmab110"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab033
            
            #add-point:AFTER FIELD pmab033 name="input.a.pmab033"
            CALL apmm101_pmab083_ref(g_pmab_m.pmab033) RETURNING g_pmab_m.pmab033_desc
            DISPLAY BY NAME g_pmab_m.pmab033_desc
            
            IF  NOT cl_null(g_pmab_m.pmab033) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmab_m.pmab033 != g_pmab_m_t.pmab033 OR cl_null(g_pmab_m_t.pmab033))) THEN 
                  IF NOT apmm101_pmab083_chk(g_pmab_m.pmab033) THEN
                     LET g_pmab_m.pmab033 = g_pmab_m_t.pmab033
                     CALL apmm101_pmab083_ref(g_pmab_m.pmab033) RETURNING g_pmab_m.pmab033_desc
                     DISPLAY BY NAME g_pmab_m.pmab033_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
           
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab033
            #add-point:BEFORE FIELD pmab033 name="input.b.pmab033"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab033
            #add-point:ON CHANGE pmab033 name="input.g.pmab033"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab034
            
            #add-point:AFTER FIELD pmab034 name="input.a.pmab034"
            CALL apmm101_pmab084_ref(g_pmab_m.pmab034) RETURNING g_pmab_m.pmab034_desc
            DISPLAY BY NAME g_pmab_m.pmab034_desc
            
            IF  NOT cl_null(g_pmab_m.pmab034) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmab_m.pmab034 != g_pmab_m_t.pmab034 OR cl_null(g_pmab_m_t.pmab034))) THEN 
                  IF NOT apmm101_pmab084_chk(g_pmab_m.pmab034) THEN
                     LET g_pmab_m.pmab034 = g_pmab_m_t.pmab034
                     CALL apmm101_pmab084_ref(g_pmab_m.pmab034) RETURNING g_pmab_m.pmab034_desc
                     DISPLAY BY NAME g_pmab_m.pmab034_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab034
            #add-point:BEFORE FIELD pmab034 name="input.b.pmab034"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab034
            #add-point:ON CHANGE pmab034 name="input.g.pmab034"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab053
            
            #add-point:AFTER FIELD pmab053 name="input.a.pmab053"
            CALL apmm101_pmab103_ref(g_pmab_m.pmab053) RETURNING g_pmab_m.pmab053_desc
            DISPLAY BY NAME g_pmab_m.pmab053_desc
            
            IF  NOT cl_null(g_pmab_m.pmab053) THEN 
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmab_m.pmab053 != g_pmab_m_t.pmab053 OR cl_null(g_pmab_m_t.pmab053))) THEN   #170203-00002#12 20170208 mark by beckxie
               IF g_pmab_m.pmab053 != g_pmab_m_o.pmab053 OR cl_null(g_pmab_m_o.pmab053) THEN   #170203-00002#12 20170208 add by beckxie
                  IF NOT apmm101_pmab103_chk(g_pmab_m.pmab053) THEN
                     #LET g_pmab_m.pmab053 = g_pmab_m_t.pmab053   #170203-00002#12 20170208 mark by beckxie
                     #170203-00002#12 20170208 add by beckxie---S
                     LET g_pmab_m.pmab053 = g_pmab_m_o.pmab053
                     LET g_pmab_m.pmab054 = g_pmab_m_o.pmab054
                     #170203-00002#12 20170208 add by beckxie---E
                     CALL apmm101_pmab103_ref(g_pmab_m.pmab053) RETURNING g_pmab_m.pmab053_desc
                     DISPLAY BY NAME g_pmab_m.pmab053_desc
                     NEXT FIELD CURRENT
                  END IF
                  SELECT oocq004 INTO g_pmab_m.pmab054 FROM oocq_t WHERE oocqent = g_enterprise AND oocq001 = '238' AND oocq002 = g_pmab_m.pmab053
               END IF
            END IF
            LET g_pmab_m_o.* = g_pmab_m.*   #170203-00002#12 20170208 add by beckxie
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab053
            #add-point:BEFORE FIELD pmab053 name="input.b.pmab053"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab053
            #add-point:ON CHANGE pmab053 name="input.g.pmab053"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab054
            
            #add-point:AFTER FIELD pmab054 name="input.a.pmab054"
            CALL apmm101_pmab054_ref(g_pmab_m.pmab054) RETURNING g_pmab_m.pmab054_desc
            DISPLAY BY NAME g_pmab_m.pmab054_desc
            
            IF  NOT cl_null(g_pmab_m.pmab054) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmab_m.pmab054 != g_pmab_m_t.pmab054 OR cl_null(g_pmab_m_t.pmab054))) THEN 
                  IF NOT apmm101_pmab054_chk(g_pmab_m.pmab054) THEN
                     LET g_pmab_m.pmab054 = g_pmab_m_t.pmab054
                     CALL apmm101_pmab054_ref(g_pmab_m.pmab054) RETURNING g_pmab_m.pmab054_desc
                     DISPLAY BY NAME g_pmab_m.pmab054_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_pmab_m_o.* = g_pmab_m.*   #170203-00002#12 20170208 add by beckxie
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab054
            #add-point:BEFORE FIELD pmab054 name="input.b.pmab054"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab054
            #add-point:ON CHANGE pmab054 name="input.g.pmab054"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab035
            #add-point:BEFORE FIELD pmab035 name="input.b.pmab035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab035
            
            #add-point:AFTER FIELD pmab035 name="input.a.pmab035"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab035
            #add-point:ON CHANGE pmab035 name="input.g.pmab035"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab036
            #add-point:BEFORE FIELD pmab036 name="input.b.pmab036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab036
            
            #add-point:AFTER FIELD pmab036 name="input.a.pmab036"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab036
            #add-point:ON CHANGE pmab036 name="input.g.pmab036"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab056
            
            #add-point:AFTER FIELD pmab056 name="input.a.pmab056"
            CALL apmm101_pmab106_ref(g_pmab_m.pmab056) RETURNING g_pmab_m.pmab056_desc
            DISPLAY BY NAME g_pmab_m.pmab056_desc
            IF NOT cl_null(g_pmab_m.pmab056) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_ooef019
               LET g_chkparam.arg2 = g_pmab_m.pmab056

               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_isac002_1") THEN
                  LET g_pmab_m.pmab056 = g_pmab_m_t.pmab056
                  CALL apmm101_pmab106_ref(g_pmab_m.pmab056) RETURNING g_pmab_m.pmab056_desc
                  DISPLAY BY NAME g_pmab_m.pmab056_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab056
            #add-point:BEFORE FIELD pmab056 name="input.b.pmab056"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab056
            #add-point:ON CHANGE pmab056 name="input.g.pmab056"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab037
            
            #add-point:AFTER FIELD pmab037 name="input.a.pmab037"
            CALL apmm101_pmab087_ref(g_pmab_m.pmab037) RETURNING g_pmab_m.pmab037_desc
            DISPLAY BY NAME g_pmab_m.pmab037_desc
            
            IF NOT cl_null(g_pmab_m.pmab037) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmab_m.pmab037 != g_pmab_m_t.pmab037 OR cl_null(g_pmab_m_t.pmab037))) THEN 
                  IF NOT apmm101_pmab087_chk(g_pmab_m.pmab037,'1') THEN
                     LET g_pmab_m.pmab037 = g_pmab_m_t.pmab037
                     CALL apmm101_pmab087_ref(g_pmab_m.pmab037) RETURNING g_pmab_m.pmab037_desc
                     DISPLAY BY NAME g_pmab_m.pmab037_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab037
            #add-point:BEFORE FIELD pmab037 name="input.b.pmab037"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab037
            #add-point:ON CHANGE pmab037 name="input.g.pmab037"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab055
            
            #add-point:AFTER FIELD pmab055 name="input.a.pmab055"
            CALL apmm101_pmab055_ref(g_pmab_m.pmab055) RETURNING g_pmab_m.pmab055_desc
            DISPLAY BY NAME g_pmab_m.pmab055_desc
            
            IF  NOT cl_null(g_pmab_m.pmab055) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmab_m.pmab055 != g_pmab_m_t.pmab055 OR cl_null(g_pmab_m_t.pmab055))) THEN 
                  #IF NOT ap_chk_isExist(g_pmab_m.pmab055,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '3211' AND oocq002 = ? ","apm-00179",1 ) THEN          #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmab_m.pmab055,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '3211' AND oocq002 = ? ","sub-01303",'aapi010' ) THEN   #160318-00005#34
                     LET g_pmab_m.pmab055 = g_pmab_m_t.pmab055
                     CALL apmm101_pmab055_ref(g_pmab_m.pmab055) RETURNING g_pmab_m.pmab055_desc
                     DISPLAY BY NAME g_pmab_m.pmab055_desc 
                     NEXT FIELD CURRENT
                  END IF
                  #IF NOT ap_chk_isExist(g_pmab_m.pmab055,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '3211' AND oocq002 = ? AND oocqstus = 'Y' ","apm-00180",1 ) THEN          #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmab_m.pmab055,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '3211' AND oocq002 = ? AND oocqstus = 'Y' ","sub-01302",'aapi010' ) THEN   #160318-00005#34
                     LET g_pmab_m.pmab055 = g_pmab_m_t.pmab055
                     CALL apmm101_pmab055_ref(g_pmab_m.pmab055) RETURNING g_pmab_m.pmab055_desc
                     DISPLAY BY NAME g_pmab_m.pmab055_desc 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab055
            #add-point:BEFORE FIELD pmab055 name="input.b.pmab055"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab055
            #add-point:ON CHANGE pmab055 name="input.g.pmab055"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab038
            
            #add-point:AFTER FIELD pmab038 name="input.a.pmab038"
            CALL apmm101_pmab088_ref(g_pmab_m.pmab038) RETURNING g_pmab_m.pmab038_desc
            DISPLAY BY NAME g_pmab_m.pmab038_desc
            IF NOT cl_null(g_pmab_m.pmab038) THEN
               #160621-00003#3 20160627 modify by beckxie---S
               #IF NOT s_azzi650_chk_exist('275',g_pmab_m.pmab038) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_pmab_m.pmab038
               LET g_chkparam.arg2 = '2'
               LET g_chkparam.err_str[1] = "aoo-00299|",l_msg2
               IF NOT cl_chk_exist("v_oojd001") THEN
               #160621-00003#3 20160627 modify by beckxie---E
                  LET g_pmab_m.pmab038 = g_pmab_m_t.pmab038
                  CALL apmm101_pmab088_ref(g_pmab_m.pmab038) RETURNING g_pmab_m.pmab038_desc
                  DISPLAY BY NAME g_pmab_m.pmab038_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab038
            #add-point:BEFORE FIELD pmab038 name="input.b.pmab038"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab038
            #add-point:ON CHANGE pmab038 name="input.g.pmab038"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab039
            
            #add-point:AFTER FIELD pmab039 name="input.a.pmab039"
            CALL apmm101_pmab039_ref(g_pmab_m.pmab039) RETURNING g_pmab_m.pmab039_desc
            DISPLAY BY NAME g_pmab_m.pmab039_desc
            
            IF  NOT cl_null(g_pmab_m.pmab039) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmab_m.pmab039 != g_pmab_m_t.pmab039 OR cl_null(g_pmab_m_t.pmab039))) THEN 
                  #IF NOT ap_chk_isExist(g_pmab_m.pmab039,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '264' AND oocq002 = ? ","apm-00071",1 ) THEN             #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmab_m.pmab039,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '264' AND oocq002 = ? ","sub-01303",'apmi029' ) THEN      #160318-00005#34
                     LET g_pmab_m.pmab039 = g_pmab_m_t.pmab039
                     CALL apmm101_pmab039_ref(g_pmab_m.pmab039) RETURNING g_pmab_m.pmab039_desc
                     DISPLAY BY NAME g_pmab_m.pmab039_desc 
                     NEXT FIELD CURRENT
                  END IF
                  #IF NOT ap_chk_isExist(g_pmab_m.pmab039,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '264' AND oocq002 = ? AND oocqstus = 'Y' ","apm-00072",1 ) THEN        #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmab_m.pmab039,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '264' AND oocq002 = ? AND oocqstus = 'Y' ","sub-01302",'apmi029' ) THEN #160318-00005#34
                     LET g_pmab_m.pmab039 = g_pmab_m_t.pmab039
                     CALL apmm101_pmab039_ref(g_pmab_m.pmab039) RETURNING g_pmab_m.pmab039_desc
                     DISPLAY BY NAME g_pmab_m.pmab039_desc 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
           

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab039
            #add-point:BEFORE FIELD pmab039 name="input.b.pmab039"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab039
            #add-point:ON CHANGE pmab039 name="input.g.pmab039"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab057
            #add-point:BEFORE FIELD pmab057 name="input.b.pmab057"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab057
            
            #add-point:AFTER FIELD pmab057 name="input.a.pmab057"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab057
            #add-point:ON CHANGE pmab057 name="input.g.pmab057"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab058
            #add-point:BEFORE FIELD pmab058 name="input.b.pmab058"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab058
            
            #add-point:AFTER FIELD pmab058 name="input.a.pmab058"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab058
            #add-point:ON CHANGE pmab058 name="input.g.pmab058"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab040
            
            #add-point:AFTER FIELD pmab040 name="input.a.pmab040"
            CALL apmm101_pmab090_ref(g_pmab_m.pmab040) RETURNING g_pmab_m.pmab040_desc
            DISPLAY BY NAME g_pmab_m.pmab040_desc
            
            IF  NOT cl_null(g_pmab_m.pmab040) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmab_m.pmab040 != g_pmab_m_t.pmab040 OR cl_null(g_pmab_m_t.pmab040))) THEN 
                  IF NOT apmm101_pmab090_chk(g_pmab_m.pmab040) THEN
                     LET g_pmab_m.pmab040 = g_pmab_m_t.pmab040
                     CALL apmm101_pmab090_ref(g_pmab_m.pmab040) RETURNING g_pmab_m.pmab040_desc
                     DISPLAY BY NAME g_pmab_m.pmab040_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            #161231-00008#1 add  --begin--
               CALL cl_set_comp_entry("pmab041,pmab042",TRUE)
            ELSE
               CALL cl_set_comp_entry("pmab041,pmab042",FALSE)
            #161231-00008#1 add  --end--
            END IF
           
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab040
            #add-point:BEFORE FIELD pmab040 name="input.b.pmab040"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab040
            #add-point:ON CHANGE pmab040 name="input.g.pmab040"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab041
            
            #add-point:AFTER FIELD pmab041 name="input.a.pmab041"
            CALL s_apmi011_location_ref(g_pmab_m.pmab040,g_pmab_m.pmab041) RETURNING g_pmab_m.pmab041_desc
            DISPLAY BY NAME g_pmab_m.pmab041_desc
            
            IF  NOT cl_null(g_pmab_m.pmab041) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmab_m.pmab041 != g_pmab_m_t.pmab041 OR cl_null(g_pmab_m_t.pmab041))) THEN 
                  IF NOT s_apmi011_check_location(g_pmab_m.pmab040,g_pmab_m.pmab041) THEN
                     LET g_pmab_m.pmab041 = g_pmab_m_t.pmab041
                     CALL s_apmi011_location_ref(g_pmab_m.pmab040,g_pmab_m.pmab041) RETURNING g_pmab_m.pmab041_desc
                     DISPLAY BY NAME g_pmab_m.pmab041_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab041
            #add-point:BEFORE FIELD pmab041 name="input.b.pmab041"
            IF cl_null(g_pmab_m.pmab040) THEN  #運輸類型
            #161231-00008#1 mark --begin--
            #  INITIALIZE g_errparam TO NULL
            #  LET g_errparam.code = 'axm-00085'
            #  LET g_errparam.extend = ''
            #  LET g_errparam.popup = TRUE
            #  CALL cl_err()
            #  #請先輸入運輸方式
            #  NEXT FIELD pmab040
            #161231-00008#1 mark --end--
            #161231-00008#1 add  --begin--
               CALL cl_set_comp_entry("pmab041",FALSE)
            ELSE
               CALL cl_set_comp_entry("pmab041",TRUE)
            #161231-00008#1 add  --end--    
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab041
            #add-point:ON CHANGE pmab041 name="input.g.pmab041"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab042
            
            #add-point:AFTER FIELD pmab042 name="input.a.pmab042"
            CALL s_apmi011_location_ref(g_pmab_m.pmab040,g_pmab_m.pmab042) RETURNING g_pmab_m.pmab042_desc
            DISPLAY BY NAME g_pmab_m.pmab042_desc
            
            IF  NOT cl_null(g_pmab_m.pmab042) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmab_m.pmab042 != g_pmab_m_t.pmab042 OR cl_null(g_pmab_m_t.pmab042))) THEN 
                  IF NOT s_apmi011_check_location(g_pmab_m.pmab040,g_pmab_m.pmab042) THEN
                     LET g_pmab_m.pmab042 = g_pmab_m_t.pmab042
                     CALL s_apmi011_location_ref(g_pmab_m.pmab040,g_pmab_m.pmab042) RETURNING g_pmab_m.pmab042_desc
                     DISPLAY BY NAME g_pmab_m.pmab042_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
           
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab042
            #add-point:BEFORE FIELD pmab042 name="input.b.pmab042"
            IF cl_null(g_pmab_m.pmab040) THEN  #運輸類型
            #161231-00008#1 mark --begin--
            #  INITIALIZE g_errparam TO NULL
            #  LET g_errparam.code = 'axm-00085'
            #  LET g_errparam.extend = ''
            #  LET g_errparam.popup = TRUE
            #  CALL cl_err()
            #  #請先輸入運輸方式
            #  NEXT FIELD pmab040
            #161231-00008#1 mark --end--
            #161231-00008#1 add  --begin--
               CALL cl_set_comp_entry("pmab042",FALSE)
            ELSE
               CALL cl_set_comp_entry("pmab042",TRUE)
            #161231-00008#1 add  --end--  
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab042
            #add-point:ON CHANGE pmab042 name="input.g.pmab042"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab043
            
            #add-point:AFTER FIELD pmab043 name="input.a.pmab043"
            CALL apmm101_pmab091_ref(g_pmab_m.pmab043) RETURNING g_pmab_m.pmab043_desc
            DISPLAY BY NAME g_pmab_m.pmab043_desc
            
            IF  NOT cl_null(g_pmab_m.pmab043) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmab_m.pmab043 != g_pmab_m_t.pmab043 OR cl_null(g_pmab_m_t.pmab043))) THEN 
                  IF NOT apmm101_pmab091_chk(g_pmab_m.pmab043) THEN
                     LET g_pmab_m.pmab043 = g_pmab_m_t.pmab043
                     CALL apmm101_pmab091_ref(g_pmab_m.pmab043) RETURNING g_pmab_m.pmab043_desc
                     DISPLAY BY NAME g_pmab_m.pmab043_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab043
            #add-point:BEFORE FIELD pmab043 name="input.b.pmab043"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab043
            #add-point:ON CHANGE pmab043 name="input.g.pmab043"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab044
            #add-point:BEFORE FIELD pmab044 name="input.b.pmab044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab044
            
            #add-point:AFTER FIELD pmab044 name="input.a.pmab044"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab044
            #add-point:ON CHANGE pmab044 name="input.g.pmab044"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab045
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmab_m.pmab045,"0.000","1","100.000","1","azz-00087",1) THEN
               NEXT FIELD pmab045
            END IF 
 
 
 
            #add-point:AFTER FIELD pmab045 name="input.a.pmab045"
            IF NOT cl_null(g_pmab_m.pmab045) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab045
            #add-point:BEFORE FIELD pmab045 name="input.b.pmab045"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab045
            #add-point:ON CHANGE pmab045 name="input.g.pmab045"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab046
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmab_m.pmab046,"0.000","1","100.000","1","azz-00087",1) THEN
               NEXT FIELD pmab046
            END IF 
 
 
 
            #add-point:AFTER FIELD pmab046 name="input.a.pmab046"
            IF NOT cl_null(g_pmab_m.pmab046) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab046
            #add-point:BEFORE FIELD pmab046 name="input.b.pmab046"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab046
            #add-point:ON CHANGE pmab046 name="input.g.pmab046"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab047
            
            #add-point:AFTER FIELD pmab047 name="input.a.pmab047"
            CALL apmm101_pmab003_ref(g_pmab_m.pmab047) RETURNING g_pmab_m.pmab047_desc
            DISPLAY BY NAME g_pmab_m.pmab047_desc
            
            IF  NOT cl_null(g_pmab_m.pmab047) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmab_m.pmab047 != g_pmab_m_t.pmab047 OR cl_null(g_pmab_m_t.pmab047))) THEN 
                  IF NOT apmm101_pmab097_chk(g_pmab_m.pmab047) THEN
                     LET g_pmab_m.pmab047 = g_pmab_m_t.pmab047
                     CALL apmm101_pmab003_ref(g_pmab_m.pmab047) RETURNING g_pmab_m.pmab047_desc
                     DISPLAY BY NAME g_pmab_m.pmab047_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
           
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab047
            #add-point:BEFORE FIELD pmab047 name="input.b.pmab047"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab047
            #add-point:ON CHANGE pmab047 name="input.g.pmab047"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab048
            #add-point:BEFORE FIELD pmab048 name="input.b.pmab048"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab048
            
            #add-point:AFTER FIELD pmab048 name="input.a.pmab048"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab048
            #add-point:ON CHANGE pmab048 name="input.g.pmab048"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab049
            #add-point:BEFORE FIELD pmab049 name="input.b.pmab049"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab049
            
            #add-point:AFTER FIELD pmab049 name="input.a.pmab049"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab049
            #add-point:ON CHANGE pmab049 name="input.g.pmab049"
            CALL apmm101_set_entry(p_cmd)
            CALL apmm101_set_no_entry(p_cmd)
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab050
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmab_m.pmab050,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD pmab050
            END IF 
 
 
 
            #add-point:AFTER FIELD pmab050 name="input.a.pmab050"
            IF NOT cl_null(g_pmab_m.pmab050) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab050
            #add-point:BEFORE FIELD pmab050 name="input.b.pmab050"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab050
            #add-point:ON CHANGE pmab050 name="input.g.pmab050"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab051
            #add-point:BEFORE FIELD pmab051 name="input.b.pmab051"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab051
            
            #add-point:AFTER FIELD pmab051 name="input.a.pmab051"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab051
            #add-point:ON CHANGE pmab051 name="input.g.pmab051"
            CALL apmm101_set_entry(p_cmd)
            CALL apmm101_set_no_entry(p_cmd)
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab052
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmab_m.pmab052,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD pmab052
            END IF 
 
 
 
            #add-point:AFTER FIELD pmab052 name="input.a.pmab052"
            IF NOT cl_null(g_pmab_m.pmab052) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab052
            #add-point:BEFORE FIELD pmab052 name="input.b.pmab052"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab052
            #add-point:ON CHANGE pmab052 name="input.g.pmab052"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab071
            #add-point:BEFORE FIELD pmab071 name="input.b.pmab071"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab071
            
            #add-point:AFTER FIELD pmab071 name="input.a.pmab071"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab071
            #add-point:ON CHANGE pmab071 name="input.g.pmab071"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab072
            #add-point:BEFORE FIELD pmab072 name="input.b.pmab072"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab072
            
            #add-point:AFTER FIELD pmab072 name="input.a.pmab072"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab072
            #add-point:ON CHANGE pmab072 name="input.g.pmab072"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab073
            #add-point:BEFORE FIELD pmab073 name="input.b.pmab073"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab073
            
            #add-point:AFTER FIELD pmab073 name="input.a.pmab073"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab073
            #add-point:ON CHANGE pmab073 name="input.g.pmab073"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab060
            #add-point:BEFORE FIELD pmab060 name="input.b.pmab060"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab060
            
            #add-point:AFTER FIELD pmab060 name="input.a.pmab060"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab060
            #add-point:ON CHANGE pmab060 name="input.g.pmab060"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab061
            #add-point:BEFORE FIELD pmab061 name="input.b.pmab061"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab061
            
            #add-point:AFTER FIELD pmab061 name="input.a.pmab061"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab061
            #add-point:ON CHANGE pmab061 name="input.g.pmab061"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab066
            #add-point:BEFORE FIELD pmab066 name="input.b.pmab066"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab066
            
            #add-point:AFTER FIELD pmab066 name="input.a.pmab066"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab066
            #add-point:ON CHANGE pmab066 name="input.g.pmab066"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab062
            #add-point:BEFORE FIELD pmab062 name="input.b.pmab062"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab062
            
            #add-point:AFTER FIELD pmab062 name="input.a.pmab062"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab062
            #add-point:ON CHANGE pmab062 name="input.g.pmab062"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab067
            #add-point:BEFORE FIELD pmab067 name="input.b.pmab067"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab067
            
            #add-point:AFTER FIELD pmab067 name="input.a.pmab067"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab067
            #add-point:ON CHANGE pmab067 name="input.g.pmab067"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab063
            #add-point:BEFORE FIELD pmab063 name="input.b.pmab063"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab063
            
            #add-point:AFTER FIELD pmab063 name="input.a.pmab063"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab063
            #add-point:ON CHANGE pmab063 name="input.g.pmab063"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab068
            #add-point:BEFORE FIELD pmab068 name="input.b.pmab068"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab068
            
            #add-point:AFTER FIELD pmab068 name="input.a.pmab068"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab068
            #add-point:ON CHANGE pmab068 name="input.g.pmab068"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab064
            #add-point:BEFORE FIELD pmab064 name="input.b.pmab064"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab064
            
            #add-point:AFTER FIELD pmab064 name="input.a.pmab064"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab064
            #add-point:ON CHANGE pmab064 name="input.g.pmab064"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab069
            #add-point:BEFORE FIELD pmab069 name="input.b.pmab069"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab069
            
            #add-point:AFTER FIELD pmab069 name="input.a.pmab069"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab069
            #add-point:ON CHANGE pmab069 name="input.g.pmab069"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab065
            #add-point:BEFORE FIELD pmab065 name="input.b.pmab065"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab065
            
            #add-point:AFTER FIELD pmab065 name="input.a.pmab065"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab065
            #add-point:ON CHANGE pmab065 name="input.g.pmab065"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab070
            #add-point:BEFORE FIELD pmab070 name="input.b.pmab070"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab070
            
            #add-point:AFTER FIELD pmab070 name="input.a.pmab070"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab070
            #add-point:ON CHANGE pmab070 name="input.g.pmab070"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_total
            #add-point:BEFORE FIELD l_total name="input.b.l_total"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_total
            
            #add-point:AFTER FIELD l_total name="input.a.l_total"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_total
            #add-point:ON CHANGE l_total name="input.g.l_total"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab002
            #add-point:BEFORE FIELD pmab002 name="input.b.pmab002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab002
            
            #add-point:AFTER FIELD pmab002 name="input.a.pmab002"
            CALL apmm101_set_required()
            CALL apmm101_set_no_required()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab002
            #add-point:ON CHANGE pmab002 name="input.g.pmab002"
            CALL apmm101_set_required()
            CALL apmm101_set_no_required()
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab003
            
            #add-point:AFTER FIELD pmab003 name="input.a.pmab003"
            CALL apmm101_pmab003_ref(g_pmab_m.pmab003) RETURNING g_pmab_m.pmab003_desc
            DISPLAY BY NAME g_pmab_m.pmab003_desc
            
            IF NOT cl_null(g_pmab_m.pmab003) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmab_m.pmab003 != g_pmab_m_t.pmab003 OR cl_null(g_pmab_m_t.pmab003))) THEN       
                  IF NOT ap_chk_isExist(g_pmab_m.pmab003,"SELECT COUNT(*) FROM pmaa_t WHERE pmaaent = '" ||g_enterprise||"' AND pmaa001 = ? ","apm-00028",1) THEN
                     LET g_pmab_m.pmab003 = g_pmab_m_t.pmab003
                     CALL apmm101_pmab003_ref(g_pmab_m.pmab003) RETURNING g_pmab_m.pmab003_desc
                     DISPLAY BY NAME g_pmab_m.pmab003_desc 
                     NEXT FIELD CURRENT
                  END IF
                  #IF NOT ap_chk_isExist(g_pmab_m.pmab003,"SELECT COUNT(*) FROM pmaa_t WHERE pmaaent = '" ||g_enterprise||"' AND pmaa001 = ? AND pmaastus != 'X' ","apm-00029",1 ) THEN         #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmab_m.pmab003,"SELECT COUNT(*) FROM pmaa_t WHERE pmaaent = '" ||g_enterprise||"' AND pmaa001 = ? AND pmaastus != 'X' ","sub-01302",'apmm100' ) THEN  #160318-00005#34
                     LET g_pmab_m.pmab003 = g_pmab_m_t.pmab003
                     CALL apmm101_pmab003_ref(g_pmab_m.pmab003) RETURNING g_pmab_m.pmab003_desc
                     DISPLAY BY NAME g_pmab_m.pmab003_desc 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
          

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab003
            #add-point:BEFORE FIELD pmab003 name="input.b.pmab003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab003
            #add-point:ON CHANGE pmab003 name="input.g.pmab003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab004
            
            #add-point:AFTER FIELD pmab004 name="input.a.pmab004"
            #ming 2014/08/17 add -----------------------------------------------------------(S) 
            #補上信用評等的校驗
            LET g_pmab_m.pmab004_desc = ' '
            CALL apmm101_pmab004_ref(g_pmab_m.pmab004) RETURNING g_pmab_m.pmab004_desc
            DISPLAY BY NAME g_pmab_m.pmab004_desc

            IF NOT cl_null(g_pmab_m.pmab004) THEN
               #此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_pmab_m.pmab004


               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_xmaj001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_pmab_m.pmab004 = g_pmab_m_t.pmab004
                  CALL apmm101_pmab004_ref(g_pmab_m.pmab004) RETURNING g_pmab_m.pmab004_desc
                  DISPLAY BY NAME g_pmab_m.pmab004_desc
                  NEXT FIELD CURRENT
               END IF 
            END IF

            CALL apmm101_pmab004_ref(g_pmab_m.pmab004) RETURNING g_pmab_m.pmab004_desc
            DISPLAY BY NAME g_pmab_m.pmab004_desc

            #ming 2014/08/17 add -----------------------------------------------------------(E) 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab004
            #add-point:BEFORE FIELD pmab004 name="input.b.pmab004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab004
            #add-point:ON CHANGE pmab004 name="input.g.pmab004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab005
            
            #add-point:AFTER FIELD pmab005 name="input.a.pmab005"
            CALL apmm101_pmab083_ref(g_pmab_m.pmab005) RETURNING g_pmab_m.pmab005_desc
            DISPLAY BY NAME g_pmab_m.pmab005_desc
            
            IF  NOT cl_null(g_pmab_m.pmab005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmab_m.pmab005 != g_pmab_m_t.pmab005 OR cl_null(g_pmab_m_t.pmab005))) THEN 
                  IF NOT apmm101_pmab083_chk(g_pmab_m.pmab005) THEN
                     LET g_pmab_m.pmab005 = g_pmab_m_t.pmab005
                     CALL apmm101_pmab083_ref(g_pmab_m.pmab005) RETURNING g_pmab_m.pmab005_desc
                     DISPLAY BY NAME g_pmab_m.pmab005_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
          
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab005
            #add-point:BEFORE FIELD pmab005 name="input.b.pmab005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab005
            #add-point:ON CHANGE pmab005 name="input.g.pmab005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab006
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmab_m.pmab006,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD pmab006
            END IF 
 
 
 
            #add-point:AFTER FIELD pmab006 name="input.a.pmab006"
            IF NOT cl_null(g_pmab_m.pmab006) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab006
            #add-point:BEFORE FIELD pmab006 name="input.b.pmab006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab006
            #add-point:ON CHANGE pmab006 name="input.g.pmab006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab007
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmab_m.pmab007,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD pmab007
            END IF 
 
 
 
            #add-point:AFTER FIELD pmab007 name="input.a.pmab007"
            IF NOT cl_null(g_pmab_m.pmab007) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab007
            #add-point:BEFORE FIELD pmab007 name="input.b.pmab007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab007
            #add-point:ON CHANGE pmab007 name="input.g.pmab007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab008
            #add-point:BEFORE FIELD pmab008 name="input.b.pmab008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab008
            
            #add-point:AFTER FIELD pmab008 name="input.a.pmab008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab008
            #add-point:ON CHANGE pmab008 name="input.g.pmab008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab009
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmab_m.pmab009,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD pmab009
            END IF 
 
 
 
            #add-point:AFTER FIELD pmab009 name="input.a.pmab009"
            IF NOT cl_null(g_pmab_m.pmab009) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab009
            #add-point:BEFORE FIELD pmab009 name="input.b.pmab009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab009
            #add-point:ON CHANGE pmab009 name="input.g.pmab009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab019
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmab_m.pmab019,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD pmab019
            END IF 
 
 
 
            #add-point:AFTER FIELD pmab019 name="input.a.pmab019"
            IF NOT cl_null(g_pmab_m.pmab019) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab019
            #add-point:BEFORE FIELD pmab019 name="input.b.pmab019"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab019
            #add-point:ON CHANGE pmab019 name="input.g.pmab019"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab010
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmab_m.pmab010,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD pmab010
            END IF 
 
 
 
            #add-point:AFTER FIELD pmab010 name="input.a.pmab010"
            IF NOT cl_null(g_pmab_m.pmab010) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab010
            #add-point:BEFORE FIELD pmab010 name="input.b.pmab010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab010
            #add-point:ON CHANGE pmab010 name="input.g.pmab010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab020
            #add-point:BEFORE FIELD pmab020 name="input.b.pmab020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab020
            
            #add-point:AFTER FIELD pmab020 name="input.a.pmab020"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab020
            #add-point:ON CHANGE pmab020 name="input.g.pmab020"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab011
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmab_m.pmab011,"0.000","1","100.000","1","azz-00087",1) THEN
               NEXT FIELD pmab011
            END IF 
 
 
 
            #add-point:AFTER FIELD pmab011 name="input.a.pmab011"
            IF NOT cl_null(g_pmab_m.pmab011) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab011
            #add-point:BEFORE FIELD pmab011 name="input.b.pmab011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab011
            #add-point:ON CHANGE pmab011 name="input.g.pmab011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab012
            #add-point:BEFORE FIELD pmab012 name="input.b.pmab012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab012
            
            #add-point:AFTER FIELD pmab012 name="input.a.pmab012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab012
            #add-point:ON CHANGE pmab012 name="input.g.pmab012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab013
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmab_m.pmab013,"0.000","1","100.000","1","azz-00087",1) THEN
               NEXT FIELD pmab013
            END IF 
 
 
 
            #add-point:AFTER FIELD pmab013 name="input.a.pmab013"
            IF NOT cl_null(g_pmab_m.pmab013) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab013
            #add-point:BEFORE FIELD pmab013 name="input.b.pmab013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab013
            #add-point:ON CHANGE pmab013 name="input.g.pmab013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab014
            #add-point:BEFORE FIELD pmab014 name="input.b.pmab014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab014
            
            #add-point:AFTER FIELD pmab014 name="input.a.pmab014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab014
            #add-point:ON CHANGE pmab014 name="input.g.pmab014"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab015
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmab_m.pmab015,"0.000","1","100.000","1","azz-00087",1) THEN
               NEXT FIELD pmab015
            END IF 
 
 
 
            #add-point:AFTER FIELD pmab015 name="input.a.pmab015"
            IF NOT cl_null(g_pmab_m.pmab015) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab015
            #add-point:BEFORE FIELD pmab015 name="input.b.pmab015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab015
            #add-point:ON CHANGE pmab015 name="input.g.pmab015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab016
            #add-point:BEFORE FIELD pmab016 name="input.b.pmab016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab016
            
            #add-point:AFTER FIELD pmab016 name="input.a.pmab016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab016
            #add-point:ON CHANGE pmab016 name="input.g.pmab016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab017
            #add-point:BEFORE FIELD pmab017 name="input.b.pmab017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab017
            
            #add-point:AFTER FIELD pmab017 name="input.a.pmab017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab017
            #add-point:ON CHANGE pmab017 name="input.g.pmab017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmab018
            #add-point:BEFORE FIELD pmab018 name="input.b.pmab018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmab018
            
            #add-point:AFTER FIELD pmab018 name="input.a.pmab018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmab018
            #add-point:ON CHANGE pmab018 name="input.g.pmab018"
            
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
                  #Ctrlp:input.c.pmab001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab001
            #add-point:ON ACTION controlp INFIELD pmab001 name="input.c.pmab001"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL   #15/08/12 Sarah add
            LET g_qryparam.state = 'i'        #15/08/12 Sarah add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmab_m.pmab001  #給予default值
            CASE g_argv[1] 
               WHEN '1' LET g_qryparam.where = " (pmaa002 = '1' OR pmaa002 = '3') "
               WHEN '2' LET g_qryparam.where = " (pmaa002 = '2' OR pmaa002 = '3') "
            END CASE
            LET g_qryparam.arg1 = g_site                    #161212-00009#1 add
           #CALL q_pmaa001_4()                   #呼叫開窗   #161212-00009#1 mark
            CALL q_pmab001_2()                   #呼叫開窗   #161212-00009#1 add
            LET g_qryparam.where = " "
            LET g_pmab_m.pmab001 = g_qryparam.return1   #將開窗取得的值回傳到變數
            DISPLAY g_pmab_m.pmab001 TO pmab001         #顯示到畫面上
            
            #modify--2015/06/25 By shiun--(S)
            CALL apmm101_pmab001_ref(g_pmab_m.pmab001) 
               RETURNING g_pmab_m.pmaa002,g_pmab_m.pmaal004,g_pmab_m.pmaal003,g_pmab_m.pmaal006,g_pmab_m.pmaal005,g_pmab_m.pmaa003,g_pmab_m.status1
            DISPLAY BY NAME g_pmab_m.pmaa002,g_pmab_m.pmaal004,g_pmab_m.pmaal003,g_pmab_m.pmaal006,g_pmab_m.pmaal005,g_pmab_m.pmaa003,g_pmab_m.status1
            #modify--2015/06/25 By shiun--(E)
            
            NEXT FIELD pmab001                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.pmaal003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaal003
            #add-point:ON ACTION controlp INFIELD pmaal003 name="input.c.pmaal003"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaal006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaal006
            #add-point:ON ACTION controlp INFIELD pmaal006 name="input.c.pmaal006"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmab080
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab080
            #add-point:ON ACTION controlp INFIELD pmab080 name="input.c.pmab080"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmab081
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab081
            #add-point:ON ACTION controlp INFIELD pmab081 name="input.c.pmab081"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL   #15/08/12 Sarah add
            LET g_qryparam.state = 'i'        #15/08/12 Sarah add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmab_m.pmab081        #給予default值
            #LET g_qryparam.default2 = "" #g_pmab_m.oofa011   #全名
            CALL q_ooag001_2()                                #呼叫開窗
            LET g_pmab_m.pmab081 = g_qryparam.return1         #將開窗取得的值回傳到變數
            #LET g_pmab_m.oofa011 = g_qryparam.return2        #全名
            DISPLAY g_pmab_m.pmab081 TO pmab081               #顯示到畫面上
            
            CALL apmm101_pmab081_ref(g_pmab_m.pmab081) RETURNING g_pmab_m.pmab081_desc
            DISPLAY BY NAME g_pmab_m.pmab081_desc
            #DISPLAY g_pmab_m.oofa011 TO oofa011 #全名
            
            NEXT FIELD pmab081                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.pmab109
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab109
            #add-point:ON ACTION controlp INFIELD pmab109 name="input.c.pmab109"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmab_m.pmab109             #給予default值
            LET g_qryparam.default2 = "" #g_pmab_m.ooeg001 #部門編號
            #給予arg
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001()                                #呼叫開窗
            LET g_pmab_m.pmab109 = g_qryparam.return1              
            #LET g_pmab_m.ooeg001 = g_qryparam.return2 
            DISPLAY g_pmab_m.pmab109 TO pmab109              #
            #DISPLAY g_pmab_m.ooeg001 TO ooeg001 #部門編號

            CALL s_desc_get_department_desc(g_pmab_m.pmab109) RETURNING g_pmab_m.pmab109_desc
            DISPLAY BY NAME g_pmab_m.pmab109_desc
            
            NEXT FIELD pmab109                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.pmab082
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab082
            #add-point:ON ACTION controlp INFIELD pmab082 name="input.c.pmab082"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmab111
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab111
            #add-point:ON ACTION controlp INFIELD pmab111 name="input.c.pmab111"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmab083
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab083
            #add-point:ON ACTION controlp INFIELD pmab083 name="input.c.pmab083"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL   #15/08/12 Sarah add
            LET g_qryparam.state = 'i'        #15/08/12 Sarah add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmab_m.pmab083       #給予default值
            #給予arg
            IF g_site = 'ALL' THEN
               LET g_qryparam.arg1 = g_site_t
            ELSE
               LET g_qryparam.arg1 = g_site
            END IF
            CALL q_ooaj002_1()                               #呼叫開窗
            LET g_pmab_m.pmab083 = g_qryparam.return1        #將開窗取得的值回傳到變數
            DISPLAY g_pmab_m.pmab083 TO pmab083              #顯示到畫面上
            
            CALL apmm101_pmab083_ref(g_pmab_m.pmab083) RETURNING g_pmab_m.pmab083_desc
            DISPLAY BY NAME g_pmab_m.pmab083_desc

            NEXT FIELD pmab083                               #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.pmab084
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab084
            #add-point:ON ACTION controlp INFIELD pmab084 name="input.c.pmab084"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL   #15/08/12 Sarah add
            LET g_qryparam.state = 'i'        #15/08/12 Sarah add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmab_m.pmab084       #給予default值
            #給予arg
            IF g_site = 'ALL' THEN 
               LET g_qryparam.arg1 = g_site_t
            ELSE
               LET g_qryparam.arg1 = g_site
            END IF
            CALL q_oodb002_3()                               #呼叫開窗
            LET g_pmab_m.pmab084 = g_qryparam.return1        #將開窗取得的值回傳到變數
            DISPLAY g_pmab_m.pmab084 TO pmab084              #顯示到畫面上
            
            CALL apmm101_pmab084_ref(g_pmab_m.pmab084) RETURNING g_pmab_m.pmab084_desc
            DISPLAY BY NAME g_pmab_m.pmab084_desc
            LET g_qryparam.arg1 = ''

            NEXT FIELD pmab084                               #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.pmab103
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab103
            #add-point:ON ACTION controlp INFIELD pmab103 name="input.c.pmab103"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL   #15/08/12 Sarah add
            LET g_qryparam.state = 'i'        #15/08/12 Sarah add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmab_m.pmab103      #給予default值
            #給予arg
            LET g_qryparam.arg1 = "238" #應用分類
            CALL q_oocq002()                                #呼叫開窗
            LET g_pmab_m.pmab103 = g_qryparam.return1       #將開窗取得的值回傳到變數
            DISPLAY g_pmab_m.pmab103 TO pmab103             #顯示到畫面上
            
            CALL apmm101_pmab103_ref(g_pmab_m.pmab103) RETURNING g_pmab_m.pmab103_desc
            DISPLAY BY NAME g_pmab_m.pmab103_desc

            NEXT FIELD pmab103                              #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.pmab104
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab104
            #add-point:ON ACTION controlp INFIELD pmab104 name="input.c.pmab104"
#此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmab_m.pmab104       #給予default值
            CALL q_xmah001()                                 #呼叫開窗
            LET g_pmab_m.pmab104 = g_qryparam.return1        #將開窗取得的值回傳到變數
            DISPLAY g_pmab_m.pmab104 TO pmab104              #顯示到畫面上
            
            CALL apmm101_pmab104_ref(g_pmab_m.pmab104) RETURNING g_pmab_m.pmab104_desc
            DISPLAY BY NAME g_pmab_m.pmab104_desc

            NEXT FIELD pmab104                               #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.pmab085
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab085
            #add-point:ON ACTION controlp INFIELD pmab085 name="input.c.pmab085"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmab086
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab086
            #add-point:ON ACTION controlp INFIELD pmab086 name="input.c.pmab086"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmab106
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab106
            #add-point:ON ACTION controlp INFIELD pmab106 name="input.c.pmab106"
#此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmab_m.pmab106       #給予default值
            #給予arg
            LET g_qryparam.arg1 = g_ooef019
            LET g_qryparam.arg2 = "2"
            CALL q_isac002_1()                               #呼叫開窗
            LET g_pmab_m.pmab106 = g_qryparam.return1        #將開窗取得的值回傳到變數
            DISPLAY g_pmab_m.pmab106 TO pmab106              #顯示到畫面上
            
            CALL apmm101_pmab106_ref(g_pmab_m.pmab106) RETURNING g_pmab_m.pmab106_desc
            DISPLAY BY NAME g_pmab_m.pmab106_desc

            NEXT FIELD pmab106                               #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.pmab087
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab087
            #add-point:ON ACTION controlp INFIELD pmab087 name="input.c.pmab087"
#此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmab_m.pmab087       #給予default值
            #給予arg
            LET g_qryparam.arg1 = g_pmab_m.pmab001
            LET g_qryparam.arg2 = "2"
            CALL q_pmad002()                                 #呼叫開窗
            LET g_pmab_m.pmab087 = g_qryparam.return1        #將開窗取得的值回傳到變數
            DISPLAY g_pmab_m.pmab087 TO pmab087              #顯示到畫面上
            
            CALL apmm101_pmab087_ref(g_pmab_m.pmab087) RETURNING g_pmab_m.pmab087_desc
            DISPLAY BY NAME g_pmab_m.pmab087_desc

            NEXT FIELD pmab087                               #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.pmab105
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab105
            #add-point:ON ACTION controlp INFIELD pmab105 name="input.c.pmab105"
#此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmab_m.pmab105       #給予default值
            #給予arg
            LET g_qryparam.arg1 = "3111"
            CALL q_oocq002()                                 #呼叫開窗
            LET g_pmab_m.pmab105 = g_qryparam.return1        #將開窗取得的值回傳到變數
            DISPLAY g_pmab_m.pmab105 TO pmab105              #顯示到畫面上
            
            CALL apmm101_pmab105_ref(g_pmab_m.pmab105) RETURNING g_pmab_m.pmab105_desc
            DISPLAY BY NAME g_pmab_m.pmab105_desc
             
            NEXT FIELD pmab105                               #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.pmab088
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab088
            #add-point:ON ACTION controlp INFIELD pmab088 name="input.c.pmab088"
#此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmab_m.pmab088       #給予default值
            #給予arg
            #160621-00003#3 20160627 modify by beckxie---S
			   #LET g_qryparam.arg1 = "275"
            #CALL q_oocq002()                           #呼叫開窗
            LET g_qryparam.arg1 = '1'
            CALL q_oojd001_1()
            #160621-00003#3 20160627 modify by beckxie---E
            LET g_pmab_m.pmab088 = g_qryparam.return1        #將開窗取得的值回傳到變數
            DISPLAY g_pmab_m.pmab088 TO pmab088              #顯示到畫面上
            
            CALL apmm101_pmab088_ref(g_pmab_m.pmab088) RETURNING g_pmab_m.pmab088_desc
            DISPLAY BY NAME g_pmab_m.pmab088_desc

            NEXT FIELD pmab088                               #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.pmab089
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab089
            #add-point:ON ACTION controlp INFIELD pmab089 name="input.c.pmab089"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL   #15/08/12 Sarah add
            LET g_qryparam.state = 'i'        #15/08/12 Sarah add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmab_m.pmab089       #給予default值
            #給予arg
            LET g_qryparam.arg1 = "295" #應用分類
            CALL q_oocq002()                                 #呼叫開窗
            LET g_pmab_m.pmab089 = g_qryparam.return1        #將開窗取得的值回傳到變數
            DISPLAY g_pmab_m.pmab089 TO pmab089              #顯示到畫面上
            
            CALL apmm101_pmab089_ref(g_pmab_m.pmab089) RETURNING g_pmab_m.pmab089_desc
            DISPLAY BY NAME g_pmab_m.pmab089_desc

            NEXT FIELD pmab089                               #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.pmab107
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab107
            #add-point:ON ACTION controlp INFIELD pmab107 name="input.c.pmab107"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmab108
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab108
            #add-point:ON ACTION controlp INFIELD pmab108 name="input.c.pmab108"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmab090
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab090
            #add-point:ON ACTION controlp INFIELD pmab090 name="input.c.pmab090"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL   #15/08/12 Sarah add
            LET g_qryparam.state = 'i'        #15/08/12 Sarah add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmab_m.pmab090       #給予default值
            #給予arg
            LET g_qryparam.arg1 = "263" #應用分類
            CALL q_oocq002()                                 #呼叫開窗
            LET g_pmab_m.pmab090 = g_qryparam.return1        #將開窗取得的值回傳到變數
            DISPLAY g_pmab_m.pmab090 TO pmab090              #顯示到畫面上
            
            CALL apmm101_pmab090_ref(g_pmab_m.pmab090) RETURNING g_pmab_m.pmab090_desc
            DISPLAY BY NAME g_pmab_m.pmab090_desc

            NEXT FIELD pmab090                               #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.pmab091
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab091
            #add-point:ON ACTION controlp INFIELD pmab091 name="input.c.pmab091"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL   #15/08/12 Sarah add
            LET g_qryparam.state = 'i'        #15/08/12 Sarah add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmab_m.pmab091       #給予default值
            CALL apmm101_get_oocq019(g_pmab_m.pmab090) RETURNING l_oocq019  #運輸類型
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
            LET g_pmab_m.pmab091 = g_qryparam.return1        #將開窗取得的值回傳到變數
            DISPLAY g_pmab_m.pmab091 TO pmab091              #顯示到畫面上
            
            CALL s_apmi011_location_ref(g_pmab_m.pmab090,g_pmab_m.pmab091) RETURNING g_pmab_m.pmab091_desc
            DISPLAY BY NAME g_pmab_m.pmab091_desc

            NEXT FIELD pmab091                               #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.pmab092
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab092
            #add-point:ON ACTION controlp INFIELD pmab092 name="input.c.pmab092"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL   #15/08/12 Sarah add
            LET g_qryparam.state = 'i'        #15/08/12 Sarah add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmab_m.pmab092       #給予default值
            CALL apmm101_get_oocq019(g_pmab_m.pmab090) RETURNING l_oocq019  #運輸類型
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
            LET g_pmab_m.pmab092 = g_qryparam.return1        #將開窗取得的值回傳到變數
            DISPLAY g_pmab_m.pmab092 TO pmab092              #顯示到畫面上
            
            CALL s_apmi011_location_ref(g_pmab_m.pmab090,g_pmab_m.pmab092) RETURNING g_pmab_m.pmab092_desc
            DISPLAY BY NAME g_pmab_m.pmab092_desc

            NEXT FIELD pmab092                               #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.pmab093
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab093
            #add-point:ON ACTION controlp INFIELD pmab093 name="input.c.pmab093"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL   #15/08/12 Sarah add
            LET g_qryparam.state = 'i'        #15/08/12 Sarah add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmab_m.pmab093       #給予default值
            #給予arg
            LET g_qryparam.arg1 = "262" #應用分類
            CALL q_oocq002()                                 #呼叫開窗
            LET g_pmab_m.pmab093 = g_qryparam.return1        #將開窗取得的值回傳到變數
            DISPLAY g_pmab_m.pmab093 TO pmab093              #顯示到畫面上
            
            CALL apmm101_pmab091_ref(g_pmab_m.pmab093) RETURNING g_pmab_m.pmab093_desc
            DISPLAY BY NAME g_pmab_m.pmab093_desc

            NEXT FIELD pmab093                               #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.pmab094
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab094
            #add-point:ON ACTION controlp INFIELD pmab094 name="input.c.pmab094"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmab095
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab095
            #add-point:ON ACTION controlp INFIELD pmab095 name="input.c.pmab095"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmab096
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab096
            #add-point:ON ACTION controlp INFIELD pmab096 name="input.c.pmab096"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmab097
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab097
            #add-point:ON ACTION controlp INFIELD pmab097 name="input.c.pmab097"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL   #15/08/12 Sarah add
            LET g_qryparam.state = 'i'        #15/08/12 Sarah add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmab_m.pmab097       #給予default值
            LET g_qryparam.where = " (pmaa002 = '1' OR pmaa002 = '3') "
            CALL q_pmaa001_4()                               #呼叫開窗
            LET g_qryparam.where = " "
            LET g_pmab_m.pmab097 = g_qryparam.return1        #將開窗取得的值回傳到變數
            DISPLAY g_pmab_m.pmab097 TO pmab097              #顯示到畫面上
            
            CALL apmm101_pmab003_ref(g_pmab_m.pmab097) RETURNING g_pmab_m.pmab097_desc
            DISPLAY BY NAME g_pmab_m.pmab097_desc

            NEXT FIELD pmab097                               #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.pmab098
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab098
            #add-point:ON ACTION controlp INFIELD pmab098 name="input.c.pmab098"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmab099
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab099
            #add-point:ON ACTION controlp INFIELD pmab099 name="input.c.pmab099"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmab100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab100
            #add-point:ON ACTION controlp INFIELD pmab100 name="input.c.pmab100"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmab101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab101
            #add-point:ON ACTION controlp INFIELD pmab101 name="input.c.pmab101"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmab102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab102
            #add-point:ON ACTION controlp INFIELD pmab102 name="input.c.pmab102"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmab030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab030
            #add-point:ON ACTION controlp INFIELD pmab030 name="input.c.pmab030"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmab031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab031
            #add-point:ON ACTION controlp INFIELD pmab031 name="input.c.pmab031"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL   #15/08/12 Sarah add
            LET g_qryparam.state = 'i'        #15/08/12 Sarah add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmab_m.pmab031        #給予default值
            LET g_qryparam.default2 = "" #g_pmab_m.oofa011 #全名
            CALL q_ooag001_2()                                #呼叫開窗
            LET g_pmab_m.pmab031 = g_qryparam.return1         #將開窗取得的值回傳到變數
            #LET g_pmab_m.oofa011 = g_qryparam.return2 #全名
            DISPLAY g_pmab_m.pmab031 TO pmab031               #顯示到畫面上
            
            CALL apmm101_pmab081_ref(g_pmab_m.pmab031) RETURNING g_pmab_m.pmab031_desc
            DISPLAY BY NAME g_pmab_m.pmab031_desc
            #DISPLAY g_pmab_m.oofa011 TO oofa011 #全名

            NEXT FIELD pmab031                                #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.pmab059
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab059
            #add-point:ON ACTION controlp INFIELD pmab059 name="input.c.pmab059"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmab_m.pmab059        #給予default值
            LET g_qryparam.default2 = "" #g_pmab_m.ooeg001 #部門編號
            #給予arg
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001()                                  #呼叫開窗
            LET g_pmab_m.pmab059 = g_qryparam.return1              
            #LET g_pmab_m.ooeg001 = g_qryparam.return2 
            DISPLAY g_pmab_m.pmab059 TO pmab059
            #DISPLAY g_pmab_m.ooeg001 TO ooeg001 #部門編號
            
            CALL s_desc_get_department_desc(g_pmab_m.pmab059) RETURNING g_pmab_m.pmab059_desc
            DISPLAY BY NAME g_pmab_m.pmab059_desc
            
            NEXT FIELD pmab059                                #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.pmab032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab032
            #add-point:ON ACTION controlp INFIELD pmab032 name="input.c.pmab032"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmab110
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab110
            #add-point:ON ACTION controlp INFIELD pmab110 name="input.c.pmab110"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmab033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab033
            #add-point:ON ACTION controlp INFIELD pmab033 name="input.c.pmab033"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL   #15/08/12 Sarah add
            LET g_qryparam.state = 'i'        #15/08/12 Sarah add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmab_m.pmab033        #給予default值
            #給予arg
            IF g_site = 'ALL' THEN
               LET g_qryparam.arg1 = g_site_t
            ELSE
               LET g_qryparam.arg1 = g_site
            END IF
            CALL q_ooaj002_1()                                #呼叫開窗
            LET g_pmab_m.pmab033 = g_qryparam.return1         #將開窗取得的值回傳到變數
            DISPLAY g_pmab_m.pmab033 TO pmab033               #顯示到畫面上
            
            CALL apmm101_pmab083_ref(g_pmab_m.pmab033) RETURNING g_pmab_m.pmab033_desc
            DISPLAY BY NAME g_pmab_m.pmab033_desc

            NEXT FIELD pmab033                                #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.pmab034
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab034
            #add-point:ON ACTION controlp INFIELD pmab034 name="input.c.pmab034"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL   #15/08/12 Sarah add
            LET g_qryparam.state = 'i'        #15/08/12 Sarah add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmab_m.pmab034       #給予default值
            #給予arg
            IF g_site = 'ALL' THEN 
               LET g_qryparam.arg1 = g_site_t
            ELSE
               LET g_qryparam.arg1 = g_site
            END IF            
            CALL q_oodb002_3()                               #呼叫開窗
            LET g_pmab_m.pmab034 = g_qryparam.return1        #將開窗取得的值回傳到變數
            DISPLAY g_pmab_m.pmab034 TO pmab034              #顯示到畫面上

            CALL apmm101_pmab084_ref(g_pmab_m.pmab034) RETURNING g_pmab_m.pmab034_desc
            DISPLAY BY NAME g_pmab_m.pmab034_desc
            LET g_qryparam.arg1 = ''

            NEXT FIELD pmab034                               #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.pmab053
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab053
            #add-point:ON ACTION controlp INFIELD pmab053 name="input.c.pmab053"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL   #15/08/12 Sarah add
            LET g_qryparam.state = 'i'        #15/08/12 Sarah add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmab_m.pmab053       #給予default值
            #給予arg
            LET g_qryparam.arg1 = "238" #應用分類
            CALL q_oocq002()                                 #呼叫開窗
            LET g_pmab_m.pmab053 = g_qryparam.return1        #將開窗取得的值回傳到變數
            DISPLAY g_pmab_m.pmab053 TO pmab053              #顯示到畫面上
            
            CALL apmm101_pmab103_ref(g_pmab_m.pmab053) RETURNING g_pmab_m.pmab053_desc
            DISPLAY BY NAME g_pmab_m.pmab053_desc

            NEXT FIELD pmab053                               #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.pmab054
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab054
            #add-point:ON ACTION controlp INFIELD pmab054 name="input.c.pmab054"
#此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmab_m.pmab054       #給予default值
            CALL q_pmam001()                                 #呼叫開窗
            LET g_pmab_m.pmab054 = g_qryparam.return1        #將開窗取得的值回傳到變數
            DISPLAY g_pmab_m.pmab054 TO pmab054              #顯示到畫面上
            
            CALL apmm101_pmab054_ref(g_pmab_m.pmab054) RETURNING g_pmab_m.pmab054_desc
            DISPLAY BY NAME g_pmab_m.pmab054_desc

            NEXT FIELD pmab054                               #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.pmab035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab035
            #add-point:ON ACTION controlp INFIELD pmab035 name="input.c.pmab035"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmab036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab036
            #add-point:ON ACTION controlp INFIELD pmab036 name="input.c.pmab036"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmab056
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab056
            #add-point:ON ACTION controlp INFIELD pmab056 name="input.c.pmab056"
#此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmab_m.pmab056       #給予default值
            #給予arg
            LET g_qryparam.arg1 = g_ooef019
            LET g_qryparam.arg2 = "1"
            CALL q_isac002_1()                               #呼叫開窗
            LET g_pmab_m.pmab056 = g_qryparam.return1        #將開窗取得的值回傳到變數
            DISPLAY g_pmab_m.pmab056 TO pmab056              #顯示到畫面上
            
            CALL apmm101_pmab106_ref(g_pmab_m.pmab056) RETURNING g_pmab_m.pmab056_desc
            DISPLAY BY NAME g_pmab_m.pmab056_desc

            NEXT FIELD pmab056                               #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.pmab037
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab037
            #add-point:ON ACTION controlp INFIELD pmab037 name="input.c.pmab037"
#此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmab_m.pmab037       #給予default值
            #給予arg
            LET g_qryparam.arg1 = g_pmab_m.pmab001
            LET g_qryparam.arg2 = "1"
            CALL q_pmad002()                                 #呼叫開窗
            LET g_pmab_m.pmab037 = g_qryparam.return1        #將開窗取得的值回傳到變數           
            DISPLAY g_pmab_m.pmab037 TO pmab037              #顯示到畫面上
            
            CALL apmm101_pmab087_ref(g_pmab_m.pmab037) RETURNING g_pmab_m.pmab037_desc
            DISPLAY BY NAME g_pmab_m.pmab037_desc
            
            NEXT FIELD pmab037                               #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.pmab055
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab055
            #add-point:ON ACTION controlp INFIELD pmab055 name="input.c.pmab055"
#此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmab_m.pmab055       #給予default值
            #給予arg
            LET g_qryparam.arg1 = "3211"
            CALL q_oocq002()                                 #呼叫開窗
            LET g_pmab_m.pmab055 = g_qryparam.return1        #將開窗取得的值回傳到變數
            DISPLAY g_pmab_m.pmab055 TO pmab055              #顯示到畫面上
            
            CALL apmm101_pmab055_ref(g_pmab_m.pmab055) RETURNING g_pmab_m.pmab055_desc
            DISPLAY BY NAME g_pmab_m.pmab055_desc

            NEXT FIELD pmab055                               #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.pmab038
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab038
            #add-point:ON ACTION controlp INFIELD pmab038 name="input.c.pmab038"
#此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmab_m.pmab038       #給予default值
            #給予arg
            #160621-00003#3 20160627 modify by beckxie---S
			   #LET g_qryparam.arg1 = "275"
            #CALL q_oocq002()                           #呼叫開窗
            LET g_qryparam.arg1 = '2'
            CALL q_oojd001_1()
            #160621-00003#3 20160627 modify by beckxie---E
            LET g_pmab_m.pmab038 = g_qryparam.return1        #將開窗取得的值回傳到變數
            DISPLAY g_pmab_m.pmab038 TO pmab038              #顯示到畫面上
            
            CALL apmm101_pmab088_ref(g_pmab_m.pmab038) RETURNING g_pmab_m.pmab038_desc
            DISPLAY BY NAME g_pmab_m.pmab038_desc
            
            NEXT FIELD pmab038                               #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.pmab039
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab039
            #add-point:ON ACTION controlp INFIELD pmab039 name="input.c.pmab039"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL   #15/08/12 Sarah add
            LET g_qryparam.state = 'i'        #15/08/12 Sarah add 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmab_m.pmab039       #給予default值
            #給予arg
            LET g_qryparam.arg1 = "264" #應用分類
            CALL q_oocq002()                                 #呼叫開窗
            LET g_pmab_m.pmab039 = g_qryparam.return1        #將開窗取得的值回傳到變數
            DISPLAY g_pmab_m.pmab039 TO pmab039              #顯示到畫面上
            
            CALL apmm101_pmab039_ref(g_pmab_m.pmab039) RETURNING g_pmab_m.pmab039_desc
            DISPLAY BY NAME g_pmab_m.pmab039_desc

            NEXT FIELD pmab039                               #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.pmab057
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab057
            #add-point:ON ACTION controlp INFIELD pmab057 name="input.c.pmab057"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmab058
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab058
            #add-point:ON ACTION controlp INFIELD pmab058 name="input.c.pmab058"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmab040
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab040
            #add-point:ON ACTION controlp INFIELD pmab040 name="input.c.pmab040"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL   #15/08/12 Sarah add
            LET g_qryparam.state = 'i'        #15/08/12 Sarah add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmab_m.pmab040      #給予default值
            #給予arg
            LET g_qryparam.arg1 = "263" #應用分類
            CALL q_oocq002()                                #呼叫開窗
            LET g_pmab_m.pmab040 = g_qryparam.return1       #將開窗取得的值回傳到變數
            DISPLAY g_pmab_m.pmab040 TO pmab040             #顯示到畫面上
            
            CALL apmm101_pmab090_ref(g_pmab_m.pmab040) RETURNING g_pmab_m.pmab040_desc
            DISPLAY BY NAME g_pmab_m.pmab040_desc

            NEXT FIELD pmab040                              #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.pmab041
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab041
            #add-point:ON ACTION controlp INFIELD pmab041 name="input.c.pmab041"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL   #15/08/12 Sarah add
            LET g_qryparam.state = 'i'        #15/08/12 Sarah add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmab_m.pmab041             #給予default值
            CALL apmm101_get_oocq019(g_pmab_m.pmab040) RETURNING l_oocq019  #運輸類型
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
            LET g_pmab_m.pmab041 = g_qryparam.return1        #將開窗取得的值回傳到變數
            DISPLAY g_pmab_m.pmab041 TO pmab041              #顯示到畫面上
            
            CALL s_apmi011_location_ref(g_pmab_m.pmab040,g_pmab_m.pmab041) RETURNING g_pmab_m.pmab041_desc
            DISPLAY BY NAME g_pmab_m.pmab041_desc

            NEXT FIELD pmab041                               #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.pmab042
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab042
            #add-point:ON ACTION controlp INFIELD pmab042 name="input.c.pmab042"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL   #15/08/12 Sarah add
            LET g_qryparam.state = 'i'        #15/08/12 Sarah add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmab_m.pmab042       #給予default值
            CALL apmm101_get_oocq019(g_pmab_m.pmab040) RETURNING l_oocq019  #運輸類型
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
            LET g_pmab_m.pmab042 = g_qryparam.return1        #將開窗取得的值回傳到變數
            DISPLAY g_pmab_m.pmab042 TO pmab042              #顯示到畫面上
            
            CALL s_apmi011_location_ref(g_pmab_m.pmab040,g_pmab_m.pmab042) RETURNING g_pmab_m.pmab042_desc
            DISPLAY BY NAME g_pmab_m.pmab042_desc

            NEXT FIELD pmab042                               #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.pmab043
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab043
            #add-point:ON ACTION controlp INFIELD pmab043 name="input.c.pmab043"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL   #15/08/12 Sarah add
            LET g_qryparam.state = 'i'        #15/08/12 Sarah add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmab_m.pmab043      #給予default值
            #給予arg
            LET g_qryparam.arg1 = "262" #應用分類
            CALL q_oocq002()                                #呼叫開窗
            LET g_pmab_m.pmab043 = g_qryparam.return1       #將開窗取得的值回傳到變數
            DISPLAY g_pmab_m.pmab043 TO pmab043             #顯示到畫面上
            
            CALL apmm101_pmab091_ref(g_pmab_m.pmab043) RETURNING g_pmab_m.pmab043_desc
            DISPLAY BY NAME g_pmab_m.pmab043_desc

            NEXT FIELD pmab043                              #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.pmab044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab044
            #add-point:ON ACTION controlp INFIELD pmab044 name="input.c.pmab044"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmab045
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab045
            #add-point:ON ACTION controlp INFIELD pmab045 name="input.c.pmab045"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmab046
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab046
            #add-point:ON ACTION controlp INFIELD pmab046 name="input.c.pmab046"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmab047
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab047
            #add-point:ON ACTION controlp INFIELD pmab047 name="input.c.pmab047"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL   #15/08/12 Sarah add
            LET g_qryparam.state = 'i'        #15/08/12 Sarah add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmab_m.pmab047       #給予default值
            LET g_qryparam.where = " (pmaa002 = '1' OR pmaa002 = '3') "
            CALL q_pmaa001_4()                               #呼叫開窗
            LET g_qryparam.where = " "
            LET g_pmab_m.pmab047 = g_qryparam.return1        #將開窗取得的值回傳到變數
            DISPLAY g_pmab_m.pmab047 TO pmab047              #顯示到畫面上
            
            CALL apmm101_pmab003_ref(g_pmab_m.pmab047) RETURNING g_pmab_m.pmab047_desc
            DISPLAY BY NAME g_pmab_m.pmab047_desc

            NEXT FIELD pmab047                               #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.pmab048
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab048
            #add-point:ON ACTION controlp INFIELD pmab048 name="input.c.pmab048"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmab049
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab049
            #add-point:ON ACTION controlp INFIELD pmab049 name="input.c.pmab049"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmab050
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab050
            #add-point:ON ACTION controlp INFIELD pmab050 name="input.c.pmab050"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmab051
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab051
            #add-point:ON ACTION controlp INFIELD pmab051 name="input.c.pmab051"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmab052
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab052
            #add-point:ON ACTION controlp INFIELD pmab052 name="input.c.pmab052"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmab071
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab071
            #add-point:ON ACTION controlp INFIELD pmab071 name="input.c.pmab071"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmab072
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab072
            #add-point:ON ACTION controlp INFIELD pmab072 name="input.c.pmab072"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmab073
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab073
            #add-point:ON ACTION controlp INFIELD pmab073 name="input.c.pmab073"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmab060
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab060
            #add-point:ON ACTION controlp INFIELD pmab060 name="input.c.pmab060"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmab061
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab061
            #add-point:ON ACTION controlp INFIELD pmab061 name="input.c.pmab061"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmab066
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab066
            #add-point:ON ACTION controlp INFIELD pmab066 name="input.c.pmab066"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmab062
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab062
            #add-point:ON ACTION controlp INFIELD pmab062 name="input.c.pmab062"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmab067
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab067
            #add-point:ON ACTION controlp INFIELD pmab067 name="input.c.pmab067"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmab063
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab063
            #add-point:ON ACTION controlp INFIELD pmab063 name="input.c.pmab063"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmab068
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab068
            #add-point:ON ACTION controlp INFIELD pmab068 name="input.c.pmab068"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmab064
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab064
            #add-point:ON ACTION controlp INFIELD pmab064 name="input.c.pmab064"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmab069
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab069
            #add-point:ON ACTION controlp INFIELD pmab069 name="input.c.pmab069"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmab065
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab065
            #add-point:ON ACTION controlp INFIELD pmab065 name="input.c.pmab065"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmab070
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab070
            #add-point:ON ACTION controlp INFIELD pmab070 name="input.c.pmab070"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_total
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_total
            #add-point:ON ACTION controlp INFIELD l_total name="input.c.l_total"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmab002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab002
            #add-point:ON ACTION controlp INFIELD pmab002 name="input.c.pmab002"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmab003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab003
            #add-point:ON ACTION controlp INFIELD pmab003 name="input.c.pmab003"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL   #15/08/12 Sarah add
            LET g_qryparam.state = 'i'        #15/08/12 Sarah add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmab_m.pmab003       #給予default值
            CALL q_pmaa001_4()                               #呼叫開窗
            LET g_pmab_m.pmab003 = g_qryparam.return1        #將開窗取得的值回傳到變數
            DISPLAY g_pmab_m.pmab003 TO pmab003              #顯示到畫面上
            
            CALL apmm101_pmab003_ref(g_pmab_m.pmab003) RETURNING g_pmab_m.pmab003_desc
            DISPLAY BY NAME g_pmab_m.pmab003_desc

            NEXT FIELD pmab003                               #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.pmab004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab004
            #add-point:ON ACTION controlp INFIELD pmab004 name="input.c.pmab004"
            #ming 20140817 add -------------------------------------------(S) 
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmab_m.pmab004       #給予default值
            #給予arg
            LET g_qryparam.arg1 = ""
            CALL q_xmaj001()                                 #呼叫開窗
            LET g_pmab_m.pmab004 = g_qryparam.return1
            DISPLAY g_pmab_m.pmab004 TO pmab004
            
            CALL apmm101_pmab004_ref(g_pmab_m.pmab004) RETURNING g_pmab_m.pmab004_desc
            DISPLAY BY NAME g_pmab_m.pmab004_desc

            NEXT FIELD pmab004                               #返回原欄位
            #ming 20140817 add -------------------------------------------(E)
            #END add-point
 
 
         #Ctrlp:input.c.pmab005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab005
            #add-point:ON ACTION controlp INFIELD pmab005 name="input.c.pmab005"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL   #15/08/12 Sarah add
            LET g_qryparam.state = 'i'        #15/08/12 Sarah add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmab_m.pmab005       #給予default值
            #給予arg
            IF g_site = 'ALL' THEN
               LET g_qryparam.arg1 = g_site_t
            ELSE
               LET g_qryparam.arg1 = g_site
            END IF
            CALL q_ooaj002_1()                               #呼叫開窗
            LET g_pmab_m.pmab005 = g_qryparam.return1        #將開窗取得的值回傳到變數
            DISPLAY g_pmab_m.pmab005 TO pmab005              #顯示到畫面上
            
            CALL apmm101_pmab083_ref(g_pmab_m.pmab005) RETURNING g_pmab_m.pmab005_desc
            DISPLAY BY NAME g_pmab_m.pmab005_desc

            NEXT FIELD pmab005                               #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.pmab006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab006
            #add-point:ON ACTION controlp INFIELD pmab006 name="input.c.pmab006"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmab007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab007
            #add-point:ON ACTION controlp INFIELD pmab007 name="input.c.pmab007"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmab008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab008
            #add-point:ON ACTION controlp INFIELD pmab008 name="input.c.pmab008"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmab009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab009
            #add-point:ON ACTION controlp INFIELD pmab009 name="input.c.pmab009"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmab019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab019
            #add-point:ON ACTION controlp INFIELD pmab019 name="input.c.pmab019"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmab010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab010
            #add-point:ON ACTION controlp INFIELD pmab010 name="input.c.pmab010"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmab020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab020
            #add-point:ON ACTION controlp INFIELD pmab020 name="input.c.pmab020"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmab011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab011
            #add-point:ON ACTION controlp INFIELD pmab011 name="input.c.pmab011"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmab012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab012
            #add-point:ON ACTION controlp INFIELD pmab012 name="input.c.pmab012"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmab013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab013
            #add-point:ON ACTION controlp INFIELD pmab013 name="input.c.pmab013"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmab014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab014
            #add-point:ON ACTION controlp INFIELD pmab014 name="input.c.pmab014"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmab015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab015
            #add-point:ON ACTION controlp INFIELD pmab015 name="input.c.pmab015"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmab016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab016
            #add-point:ON ACTION controlp INFIELD pmab016 name="input.c.pmab016"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmab017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab017
            #add-point:ON ACTION controlp INFIELD pmab017 name="input.c.pmab017"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmab018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmab018
            #add-point:ON ACTION controlp INFIELD pmab018 name="input.c.pmab018"
            
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
               SELECT COUNT(1) INTO l_count FROM pmab_t
                WHERE pmabent = g_enterprise AND pmabsite = g_site AND pmab001 = g_pmab_m.pmab001
 
               IF l_count = 0 THEN
               
                  #add-point:單頭新增前 name="input.head.b_insert"
                  
                  #end add-point
               
                  #將新增的單頭資料寫入資料庫
                  INSERT INTO pmab_t (pmabent, pmabsite,pmab001,pmab080,pmab081,pmab109,pmab082,pmab111, 
                      pmab083,pmab084,pmab103,pmab104,pmab085,pmab086,pmab106,pmab087,pmab105,pmab088, 
                      pmab089,pmab107,pmab108,pmab090,pmab091,pmab092,pmab093,pmab094,pmab095,pmab096, 
                      pmab097,pmab098,pmab099,pmab100,pmab101,pmab102,pmab030,pmab031,pmab059,pmab032, 
                      pmab110,pmab033,pmab034,pmab053,pmab054,pmab035,pmab036,pmab056,pmab037,pmab055, 
                      pmab038,pmab039,pmab057,pmab058,pmab040,pmab041,pmab042,pmab043,pmab044,pmab045, 
                      pmab046,pmab047,pmab048,pmab049,pmab050,pmab051,pmab052,pmab071,pmab072,pmab073, 
                      pmab060,pmab061,pmab066,pmab062,pmab067,pmab063,pmab068,pmab064,pmab069,pmab065, 
                      pmab070,pmab002,pmab003,pmab004,pmab005,pmab006,pmab007,pmab008,pmab009,pmab019, 
                      pmab010,pmab020,pmab011,pmab012,pmab013,pmab014,pmab015,pmab016,pmab017,pmab018, 
                      pmabownid,pmabowndp,pmabcrtid,pmabcrtdp,pmabcrtdt,pmabmodid,pmabmoddt)
                  VALUES (g_enterprise, g_site,g_pmab_m.pmab001,g_pmab_m.pmab080,g_pmab_m.pmab081,g_pmab_m.pmab109, 
                      g_pmab_m.pmab082,g_pmab_m.pmab111,g_pmab_m.pmab083,g_pmab_m.pmab084,g_pmab_m.pmab103, 
                      g_pmab_m.pmab104,g_pmab_m.pmab085,g_pmab_m.pmab086,g_pmab_m.pmab106,g_pmab_m.pmab087, 
                      g_pmab_m.pmab105,g_pmab_m.pmab088,g_pmab_m.pmab089,g_pmab_m.pmab107,g_pmab_m.pmab108, 
                      g_pmab_m.pmab090,g_pmab_m.pmab091,g_pmab_m.pmab092,g_pmab_m.pmab093,g_pmab_m.pmab094, 
                      g_pmab_m.pmab095,g_pmab_m.pmab096,g_pmab_m.pmab097,g_pmab_m.pmab098,g_pmab_m.pmab099, 
                      g_pmab_m.pmab100,g_pmab_m.pmab101,g_pmab_m.pmab102,g_pmab_m.pmab030,g_pmab_m.pmab031, 
                      g_pmab_m.pmab059,g_pmab_m.pmab032,g_pmab_m.pmab110,g_pmab_m.pmab033,g_pmab_m.pmab034, 
                      g_pmab_m.pmab053,g_pmab_m.pmab054,g_pmab_m.pmab035,g_pmab_m.pmab036,g_pmab_m.pmab056, 
                      g_pmab_m.pmab037,g_pmab_m.pmab055,g_pmab_m.pmab038,g_pmab_m.pmab039,g_pmab_m.pmab057, 
                      g_pmab_m.pmab058,g_pmab_m.pmab040,g_pmab_m.pmab041,g_pmab_m.pmab042,g_pmab_m.pmab043, 
                      g_pmab_m.pmab044,g_pmab_m.pmab045,g_pmab_m.pmab046,g_pmab_m.pmab047,g_pmab_m.pmab048, 
                      g_pmab_m.pmab049,g_pmab_m.pmab050,g_pmab_m.pmab051,g_pmab_m.pmab052,g_pmab_m.pmab071, 
                      g_pmab_m.pmab072,g_pmab_m.pmab073,g_pmab_m.pmab060,g_pmab_m.pmab061,g_pmab_m.pmab066, 
                      g_pmab_m.pmab062,g_pmab_m.pmab067,g_pmab_m.pmab063,g_pmab_m.pmab068,g_pmab_m.pmab064, 
                      g_pmab_m.pmab069,g_pmab_m.pmab065,g_pmab_m.pmab070,g_pmab_m.pmab002,g_pmab_m.pmab003, 
                      g_pmab_m.pmab004,g_pmab_m.pmab005,g_pmab_m.pmab006,g_pmab_m.pmab007,g_pmab_m.pmab008, 
                      g_pmab_m.pmab009,g_pmab_m.pmab019,g_pmab_m.pmab010,g_pmab_m.pmab020,g_pmab_m.pmab011, 
                      g_pmab_m.pmab012,g_pmab_m.pmab013,g_pmab_m.pmab014,g_pmab_m.pmab015,g_pmab_m.pmab016, 
                      g_pmab_m.pmab017,g_pmab_m.pmab018,g_pmab_m.pmabownid,g_pmab_m.pmabowndp,g_pmab_m.pmabcrtid, 
                      g_pmab_m.pmabcrtdp,g_pmab_m.pmabcrtdt,g_pmab_m.pmabmodid,g_pmab_m.pmabmoddt) 
                  
                  #add-point:單頭新增中 name="input.head.m_insert"
                  
                  #end add-point
                  
                  #若寫入錯誤則提示錯誤訊息並返回輸入頁面
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pmab_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
                  
                  
                  
                  #資料多語言用-增/改
                  
                  
                  #add-point:單頭新增後 name="input.head.a_insert"
                  #傳入參數，直接進入的新增狀態，新增完成後，顯示主畫面
                  #由apmm100串apmm101新增完成時請自動複製一筆當下g_site的據點資料
                  IF g_flag1 THEN
                     LET l_count = 1  
 
                     SELECT COUNT(*) INTO l_count FROM pmab_t
                      WHERE pmabent = g_enterprise AND pmabsite = g_site_t AND pmab001 = g_pmab_m.pmab001
      
                     IF l_count = 0 THEN
  
                        INSERT INTO pmab_t (pmabent,pmabsite,pmab001,pmab080,pmab081,pmab082,pmab083,pmab084,pmab103,pmab104,pmab085,pmab086,
                                            pmab087,pmab105,pmab088,pmab089,pmab090,pmab091,pmab092,pmab093,pmab094,pmab095,pmab096,pmab097,
                                            pmab098,pmab099,pmab100,pmab101,pmab102,pmab030,pmab031,pmab032,pmab033,pmab034,pmab053,pmab054,
                                            pmab035,pmab036,pmab037,pmab055,pmab038,pmab039,pmab040,pmab041,pmab042,pmab043,pmab044,pmab045,
                                            pmab046,pmab047,pmab048,pmab049,pmab050,pmab051,pmab052,pmab071,pmab072,pmab073,pmab060,pmab061,
                                            pmab066,pmab062,pmab067,pmab063,pmab068,pmab064,pmab069,pmab065,pmab070,pmab002,pmab003,pmab004,
                                            pmab005,pmab006,pmab007,pmab008,pmab009,pmab019,pmab010,pmab020,pmab011,pmab012,pmab013,pmab014,pmab015,pmab016,
                                            pmab017,pmab018,pmab056,pmab057,pmab058,pmab106,pmab107,pmab108,pmabownid,pmabowndp,pmabcrtid,
                                            pmabcrtdp,pmabcrtdt,pmabmodid,pmabmoddt)
                        VALUES (g_enterprise,g_site_t,g_pmab_m.pmab001,g_pmab_m.pmab080,g_pmab_m.pmab081,g_pmab_m.pmab082,g_pmab_m.pmab083,
                                g_pmab_m.pmab084,g_pmab_m.pmab103,g_pmab_m.pmab104,g_pmab_m.pmab085,g_pmab_m.pmab086,g_pmab_m.pmab087,
                                g_pmab_m.pmab105,g_pmab_m.pmab088,g_pmab_m.pmab089,g_pmab_m.pmab090,g_pmab_m.pmab091,g_pmab_m.pmab092,
                                g_pmab_m.pmab093,g_pmab_m.pmab094,g_pmab_m.pmab095,g_pmab_m.pmab096,g_pmab_m.pmab097,g_pmab_m.pmab098,
                                g_pmab_m.pmab099,g_pmab_m.pmab100,g_pmab_m.pmab101,g_pmab_m.pmab102,g_pmab_m.pmab030,g_pmab_m.pmab031,
                                g_pmab_m.pmab032,g_pmab_m.pmab033,g_pmab_m.pmab034,g_pmab_m.pmab053,g_pmab_m.pmab054,g_pmab_m.pmab035,
                                g_pmab_m.pmab036,g_pmab_m.pmab037,g_pmab_m.pmab055,g_pmab_m.pmab038,g_pmab_m.pmab039,g_pmab_m.pmab040,
                                g_pmab_m.pmab041,g_pmab_m.pmab042,g_pmab_m.pmab043,g_pmab_m.pmab044,g_pmab_m.pmab045,g_pmab_m.pmab046,
                                g_pmab_m.pmab047,g_pmab_m.pmab048,g_pmab_m.pmab049,g_pmab_m.pmab050,g_pmab_m.pmab051,g_pmab_m.pmab052,
                                g_pmab_m.pmab071,g_pmab_m.pmab072,g_pmab_m.pmab073,g_pmab_m.pmab060,g_pmab_m.pmab061,g_pmab_m.pmab066,
                                g_pmab_m.pmab062,g_pmab_m.pmab067,g_pmab_m.pmab063,g_pmab_m.pmab068,g_pmab_m.pmab064,g_pmab_m.pmab069,
                                g_pmab_m.pmab065,g_pmab_m.pmab070,g_pmab_m.pmab002,g_pmab_m.pmab003,g_pmab_m.pmab004,g_pmab_m.pmab005,
                                g_pmab_m.pmab006,g_pmab_m.pmab007,g_pmab_m.pmab008,g_pmab_m.pmab009,g_pmab_m.pmab019,g_pmab_m.pmab010,g_pmab_m.pmab020,
                                g_pmab_m.pmab011,
                                g_pmab_m.pmab012,g_pmab_m.pmab013,g_pmab_m.pmab014,g_pmab_m.pmab015,g_pmab_m.pmab016,g_pmab_m.pmab017,
                                g_pmab_m.pmab018,g_pmab_m.pmab056,g_pmab_m.pmab057,g_pmab_m.pmab058,g_pmab_m.pmab106,g_pmab_m.pmab107,
                                g_pmab_m.pmab108,g_pmab_m.pmabownid,g_pmab_m.pmabowndp,g_pmab_m.pmabcrtid,g_pmab_m.pmabcrtdp,g_pmab_m.pmabcrtdt,
                                g_pmab_m.pmabmodid,g_pmab_m.pmabmoddt) # DISK WRITE
                         
                        IF SQLCA.sqlcode THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = SQLCA.sqlcode
                           LET g_errparam.extend = "pmab_t"
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
  
                           CONTINUE DIALOG
                        END IF
                     END IF
                  END IF
   
                  #新增到ooff_t 備註
                  IF NOT cl_null(g_pmab_m.ooff013) THEN
                     LET l_success = ''
                     CALL s_aooi360_gen('2',g_pmab_m.pmab001,g_site,'','','','','','','','','4',g_pmab_m.ooff013) RETURNING l_success
                     IF NOT l_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "ooff_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        CONTINUE DIALOG
                     END IF
                  ELSE
                     CALL s_aooi360_del('2',g_pmab_m.pmab001,g_site,'','','','','','','','','4') RETURNING l_success
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
                  LET g_errparam.extend = g_pmab_m.pmab001
                  LET g_errparam.code   = "std-00006" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
               END IF 
            ELSE
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL apmm101_pmab_t_mask_restore('restore_mask_o')
               
               UPDATE pmab_t SET (pmab001,pmab080,pmab081,pmab109,pmab082,pmab111,pmab083,pmab084,pmab103, 
                   pmab104,pmab085,pmab086,pmab106,pmab087,pmab105,pmab088,pmab089,pmab107,pmab108,pmab090, 
                   pmab091,pmab092,pmab093,pmab094,pmab095,pmab096,pmab097,pmab098,pmab099,pmab100,pmab101, 
                   pmab102,pmab030,pmab031,pmab059,pmab032,pmab110,pmab033,pmab034,pmab053,pmab054,pmab035, 
                   pmab036,pmab056,pmab037,pmab055,pmab038,pmab039,pmab057,pmab058,pmab040,pmab041,pmab042, 
                   pmab043,pmab044,pmab045,pmab046,pmab047,pmab048,pmab049,pmab050,pmab051,pmab052,pmab071, 
                   pmab072,pmab073,pmab060,pmab061,pmab066,pmab062,pmab067,pmab063,pmab068,pmab064,pmab069, 
                   pmab065,pmab070,pmab002,pmab003,pmab004,pmab005,pmab006,pmab007,pmab008,pmab009,pmab019, 
                   pmab010,pmab020,pmab011,pmab012,pmab013,pmab014,pmab015,pmab016,pmab017,pmab018,pmabownid, 
                   pmabowndp,pmabcrtid,pmabcrtdp,pmabcrtdt,pmabmodid,pmabmoddt) = (g_pmab_m.pmab001, 
                   g_pmab_m.pmab080,g_pmab_m.pmab081,g_pmab_m.pmab109,g_pmab_m.pmab082,g_pmab_m.pmab111, 
                   g_pmab_m.pmab083,g_pmab_m.pmab084,g_pmab_m.pmab103,g_pmab_m.pmab104,g_pmab_m.pmab085, 
                   g_pmab_m.pmab086,g_pmab_m.pmab106,g_pmab_m.pmab087,g_pmab_m.pmab105,g_pmab_m.pmab088, 
                   g_pmab_m.pmab089,g_pmab_m.pmab107,g_pmab_m.pmab108,g_pmab_m.pmab090,g_pmab_m.pmab091, 
                   g_pmab_m.pmab092,g_pmab_m.pmab093,g_pmab_m.pmab094,g_pmab_m.pmab095,g_pmab_m.pmab096, 
                   g_pmab_m.pmab097,g_pmab_m.pmab098,g_pmab_m.pmab099,g_pmab_m.pmab100,g_pmab_m.pmab101, 
                   g_pmab_m.pmab102,g_pmab_m.pmab030,g_pmab_m.pmab031,g_pmab_m.pmab059,g_pmab_m.pmab032, 
                   g_pmab_m.pmab110,g_pmab_m.pmab033,g_pmab_m.pmab034,g_pmab_m.pmab053,g_pmab_m.pmab054, 
                   g_pmab_m.pmab035,g_pmab_m.pmab036,g_pmab_m.pmab056,g_pmab_m.pmab037,g_pmab_m.pmab055, 
                   g_pmab_m.pmab038,g_pmab_m.pmab039,g_pmab_m.pmab057,g_pmab_m.pmab058,g_pmab_m.pmab040, 
                   g_pmab_m.pmab041,g_pmab_m.pmab042,g_pmab_m.pmab043,g_pmab_m.pmab044,g_pmab_m.pmab045, 
                   g_pmab_m.pmab046,g_pmab_m.pmab047,g_pmab_m.pmab048,g_pmab_m.pmab049,g_pmab_m.pmab050, 
                   g_pmab_m.pmab051,g_pmab_m.pmab052,g_pmab_m.pmab071,g_pmab_m.pmab072,g_pmab_m.pmab073, 
                   g_pmab_m.pmab060,g_pmab_m.pmab061,g_pmab_m.pmab066,g_pmab_m.pmab062,g_pmab_m.pmab067, 
                   g_pmab_m.pmab063,g_pmab_m.pmab068,g_pmab_m.pmab064,g_pmab_m.pmab069,g_pmab_m.pmab065, 
                   g_pmab_m.pmab070,g_pmab_m.pmab002,g_pmab_m.pmab003,g_pmab_m.pmab004,g_pmab_m.pmab005, 
                   g_pmab_m.pmab006,g_pmab_m.pmab007,g_pmab_m.pmab008,g_pmab_m.pmab009,g_pmab_m.pmab019, 
                   g_pmab_m.pmab010,g_pmab_m.pmab020,g_pmab_m.pmab011,g_pmab_m.pmab012,g_pmab_m.pmab013, 
                   g_pmab_m.pmab014,g_pmab_m.pmab015,g_pmab_m.pmab016,g_pmab_m.pmab017,g_pmab_m.pmab018, 
                   g_pmab_m.pmabownid,g_pmab_m.pmabowndp,g_pmab_m.pmabcrtid,g_pmab_m.pmabcrtdp,g_pmab_m.pmabcrtdt, 
                   g_pmab_m.pmabmodid,g_pmab_m.pmabmoddt)
                WHERE pmabent = g_enterprise AND pmabsite = g_site AND pmab001 = g_pmab001_t #
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pmab_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pmab_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  OTHERWISE
                     
                     #資料多語言用-增/改
                     
                     
                     #將遮罩欄位進行遮蔽
                     CALL apmm101_pmab_t_mask_restore('restore_mask_n')
                     
                     #add-point:單頭修改後 name="input.head.a_update"
                     IF NOT cl_null(g_pmab_m.ooff013) THEN
                        LET l_success = ''
                        CALL s_aooi360_gen('2',g_pmab_m.pmab001,g_site,'','','','','','','','','4',g_pmab_m.ooff013) RETURNING l_success
                        IF NOT l_success THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = SQLCA.sqlcode
                           LET g_errparam.extend = "ooff_t"
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                     
                           CALL s_transaction_end('N','0')
                        END IF
                     ELSE
                        CALL s_aooi360_del('2',g_pmab_m.pmab001,g_site,'','','','','','','','','4') RETURNING l_success
                        IF NOT l_success THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = SQLCA.sqlcode
                           LET g_errparam.extend = "ooff_t"
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                     
                           CALL s_transaction_end('N','0')
                        END IF
                     END IF
                     
                     #若g_site='ALL'，則呼叫s_aooi090_upd_fields，將有設定為集團一致的欄位資料一併更新
                     IF g_site = 'ALL' THEN
                        IF NOT s_aooi090_upd_fields('4',g_pmab001_t) THEN #'1' 據點進銷存資料
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = SQLCA.sqlcode
                           LET g_errparam.extend = "pmab_t"
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           CALL s_transaction_end('N','0')
                        END IF 
                     END IF
                     #end add-point
                     #修改歷程記錄(單頭修改)
                     LET g_log1 = util.JSON.stringify(g_pmab_m_t)
                     LET g_log2 = util.JSON.stringify(g_pmab_m)
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
 
{<section id="apmm101.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION apmm101_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE pmab_t.pmab001 
   DEFINE l_oldno     LIKE pmab_t.pmab001 
 
   DEFINE l_master    RECORD LIKE pmab_t.* #此變數樣板目前無使用
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
   IF g_pmab_m.pmab001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   #備份key值
   LET g_pmab001_t = g_pmab_m.pmab001
 
   
   #清空key值
   LET g_pmab_m.pmab001 = ""
 
    
   CALL apmm101_set_entry("a")
   CALL apmm101_set_no_entry("a")
   
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_pmab_m.pmabownid = g_user
      LET g_pmab_m.pmabowndp = g_dept
      LET g_pmab_m.pmabcrtid = g_user
      LET g_pmab_m.pmabcrtdp = g_dept 
      LET g_pmab_m.pmabcrtdt = cl_get_current()
      LET g_pmab_m.pmabmodid = g_user
      LET g_pmab_m.pmabmoddt = cl_get_current()
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
   
   
   #清空key欄位的desc
   
   
   #資料輸入
   CALL apmm101_input("r")
   
   IF INT_FLAG THEN
      #取消
      INITIALIZE g_pmab_m.* TO NULL
      CALL apmm101_show()
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
      LET g_errparam.extend = "pmab_t:",SQLERRMESSAGE 
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
   CALL apmm101_set_act_visible()
   CALL apmm101_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_pmab001_t = g_pmab_m.pmab001
 
   
   #組合新增資料的條件
   LET g_add_browse = " pmabent = " ||g_enterprise|| " AND pmabsite = '" ||g_site|| "' AND",
                      " pmab001 = '", g_pmab_m.pmab001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL apmm101_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
              
   LET g_data_owner = g_pmab_m.pmabownid      
   LET g_data_dept  = g_pmab_m.pmabowndp
              
   #功能已完成,通報訊息中心
   CALL apmm101_msgcentre_notify('reproduce')
                 
END FUNCTION
 
{</section>}
 
{<section id="apmm101.show" >}
#+ 資料顯示 
PRIVATE FUNCTION apmm101_show()
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
   CALL apmm101_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
            
            #modify--2015/06/25 By shiun--(S)
            CALL apmm101_pmab001_ref(g_pmab_m.pmab001) 
               RETURNING g_pmab_m.pmaa002,g_pmab_m.pmaal004,g_pmab_m.pmaal003,g_pmab_m.pmaal006,g_pmab_m.pmaal005,g_pmab_m.pmaa003,g_pmab_m.status1
            DISPLAY BY NAME g_pmab_m.pmaa002,g_pmab_m.pmaal004,g_pmab_m.pmaal003,g_pmab_m.pmaal006,g_pmab_m.pmaal005,g_pmab_m.pmaa003,g_pmab_m.status1
            #modify--2015/06/25 By shiun--(E)
            
            #CALL apmm101_pmab081_ref(g_pmab_m.pmab081) RETURNING g_pmab_m.pmab081_desc
            #DISPLAY BY NAME g_pmab_m.pmab081_desc 
            #
            #CALL apmm101_pmab083_ref(g_pmab_m.pmab083) RETURNING g_pmab_m.pmab083_desc
            #DISPLAY BY NAME g_pmab_m.pmab083_desc
            
            CALL apmm101_pmab084_ref(g_pmab_m.pmab084) RETURNING g_pmab_m.pmab084_desc
            DISPLAY BY NAME g_pmab_m.pmab084_desc
            
            #CALL apmm101_pmab103_ref(g_pmab_m.pmab103) RETURNING g_pmab_m.pmab103_desc
            #DISPLAY BY NAME g_pmab_m.pmab103_desc          
            #
            #CALL apmm101_pmab104_ref(g_pmab_m.pmab104) RETURNING g_pmab_m.pmab104_desc
            #DISPLAY BY NAME g_pmab_m.pmab104_desc
            #
            #CALL apmm101_pmab087_ref(g_pmab_m.pmab087) RETURNING g_pmab_m.pmab087_desc
            #DISPLAY BY NAME g_pmab_m.pmab087_desc
            #
            #CALL apmm101_pmab089_ref(g_pmab_m.pmab089) RETURNING g_pmab_m.pmab089_desc
            #DISPLAY BY NAME g_pmab_m.pmab089_desc
            #
            #CALL apmm101_pmab090_ref(g_pmab_m.pmab090) RETURNING g_pmab_m.pmab090_desc
            #DISPLAY BY NAME g_pmab_m.pmab090_desc
            #
            CALL s_apmi011_location_ref(g_pmab_m.pmab090,g_pmab_m.pmab091) RETURNING g_pmab_m.pmab091_desc
            DISPLAY BY NAME g_pmab_m.pmab091_desc
            
            CALL s_apmi011_location_ref(g_pmab_m.pmab090,g_pmab_m.pmab092) RETURNING g_pmab_m.pmab092_desc
            DISPLAY BY NAME g_pmab_m.pmab092_desc
            
            #CALL apmm101_pmab091_ref(g_pmab_m.pmab093) RETURNING g_pmab_m.pmab093_desc
            #DISPLAY BY NAME g_pmab_m.pmab093_desc
            #
            #CALL apmm101_pmab003_ref(g_pmab_m.pmab097) RETURNING g_pmab_m.pmab097_desc
            #DISPLAY BY NAME g_pmab_m.pmab097_desc
            #
            #CALL apmm101_pmab081_ref(g_pmab_m.pmab031) RETURNING g_pmab_m.pmab031_desc
            #DISPLAY BY NAME g_pmab_m.pmab031_desc
            #
            #CALL apmm101_pmab083_ref(g_pmab_m.pmab033) RETURNING g_pmab_m.pmab033_desc
            #DISPLAY BY NAME g_pmab_m.pmab033_desc
            
            CALL apmm101_pmab084_ref(g_pmab_m.pmab034) RETURNING g_pmab_m.pmab034_desc
            DISPLAY BY NAME g_pmab_m.pmab034_desc
            
            #CALL apmm101_pmab087_ref(g_pmab_m.pmab037) RETURNING g_pmab_m.pmab037_desc
            #DISPLAY BY NAME g_pmab_m.pmab037_desc
            #
            #CALL apmm101_pmab103_ref(g_pmab_m.pmab053) RETURNING g_pmab_m.pmab053_desc
            #DISPLAY BY NAME g_pmab_m.pmab053_desc
            #
            #CALL apmm101_pmab054_ref(g_pmab_m.pmab054) RETURNING g_pmab_m.pmab054_desc
            #DISPLAY BY NAME g_pmab_m.pmab054_desc
            #
            #CALL apmm101_pmab039_ref(g_pmab_m.pmab039) RETURNING g_pmab_m.pmab039_desc
            #DISPLAY BY NAME g_pmab_m.pmab039_desc
            #
            #CALL apmm101_pmab090_ref(g_pmab_m.pmab040) RETURNING g_pmab_m.pmab040_desc
            #DISPLAY BY NAME g_pmab_m.pmab040_desc
            #
            CALL s_apmi011_location_ref(g_pmab_m.pmab040,g_pmab_m.pmab041) RETURNING g_pmab_m.pmab041_desc
            DISPLAY BY NAME g_pmab_m.pmab041_desc
            
            CALL s_apmi011_location_ref(g_pmab_m.pmab040,g_pmab_m.pmab042) RETURNING g_pmab_m.pmab042_desc
            DISPLAY BY NAME g_pmab_m.pmab042_desc
            
            #CALL apmm101_pmab091_ref(g_pmab_m.pmab043) RETURNING g_pmab_m.pmab043_desc
            #DISPLAY BY NAME g_pmab_m.pmab043_desc
            #
            #CALL apmm101_pmab003_ref(g_pmab_m.pmab047) RETURNING g_pmab_m.pmab047_desc
            #DISPLAY BY NAME g_pmab_m.pmab047_desc
            #
            CALL apmm101_pmab004_ref(g_pmab_m.pmab004) RETURNING g_pmab_m.pmab004_desc
            DISPLAY BY NAME g_pmab_m.pmab004_desc
            #
            #CALL apmm101_pmab083_ref(g_pmab_m.pmab005) RETURNING g_pmab_m.pmab005_desc
            #DISPLAY BY NAME g_pmab_m.pmab005_desc
            #
            #CALL apmm101_pmab055_ref(g_pmab_m.pmab055) RETURNING g_pmab_m.pmab055_desc
            #DISPLAY BY NAME g_pmab_m.pmab055_desc
            #
            #CALL apmm101_pmab105_ref(g_pmab_m.pmab105) RETURNING g_pmab_m.pmab105_desc
            #DISPLAY BY NAME g_pmab_m.pmab105_desc
            #
            CALL apmm101_pmab106_ref(g_pmab_m.pmab106) RETURNING g_pmab_m.pmab106_desc
            DISPLAY BY NAME g_pmab_m.pmab106_desc
            
            CALL apmm101_pmab106_ref(g_pmab_m.pmab056) RETURNING g_pmab_m.pmab056_desc
            DISPLAY BY NAME g_pmab_m.pmab056_desc
            
            IF NOT cl_null(g_pmab_m.pmab001) THEN
               CALL s_aooi360_sel('2',g_pmab_m.pmab001,g_site,'','','','','','','','','4') RETURNING l_success,g_pmab_m.ooff013
            END IF
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmab_m.pmabownid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_pmab_m.pmabownid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmab_m.pmabownid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmab_m.pmabowndp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pmab_m.pmabowndp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmab_m.pmabowndp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmab_m.pmabcrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_pmab_m.pmabcrtid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmab_m.pmabcrtid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmab_m.pmabcrtdp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pmab_m.pmabcrtdp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmab_m.pmabcrtdp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmab_m.pmabmodid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_pmab_m.pmabmodid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmab_m.pmabmodid_desc

            #INITIALIZE g_ref_fields TO NULL
            #LET g_ref_fields[1] = g_pmab_m.pmabcnfid
            #CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            #LET g_pmab_m.pmabcnfid_desc = '', g_rtn_fields[1] , ''
            #DISPLAY BY NAME g_pmab_m.pmabcnfid_desc

   #end add-point
 
   #將資料輸出到畫面上
   DISPLAY BY NAME g_pmab_m.pmab001,g_pmab_m.pmaal004,g_pmab_m.pmaal005,g_pmab_m.pmaa003,g_pmab_m.pmaa002, 
       g_pmab_m.pmaal003,g_pmab_m.pmaal006,g_pmab_m.status1,g_pmab_m.pmab080,g_pmab_m.pmab081,g_pmab_m.pmab081_desc, 
       g_pmab_m.pmab109,g_pmab_m.pmab109_desc,g_pmab_m.pmab082,g_pmab_m.pmab111,g_pmab_m.pmab083,g_pmab_m.pmab083_desc, 
       g_pmab_m.pmab084,g_pmab_m.pmab084_desc,g_pmab_m.pmab103,g_pmab_m.pmab103_desc,g_pmab_m.pmab104, 
       g_pmab_m.pmab104_desc,g_pmab_m.pmab085,g_pmab_m.pmab086,g_pmab_m.pmab106,g_pmab_m.pmab106_desc, 
       g_pmab_m.pmab087,g_pmab_m.pmab087_desc,g_pmab_m.pmab105,g_pmab_m.pmab105_desc,g_pmab_m.pmab088, 
       g_pmab_m.pmab088_desc,g_pmab_m.pmab089,g_pmab_m.pmab089_desc,g_pmab_m.pmab107,g_pmab_m.pmab108, 
       g_pmab_m.pmab090,g_pmab_m.pmab090_desc,g_pmab_m.pmab091,g_pmab_m.pmab091_desc,g_pmab_m.pmab092, 
       g_pmab_m.pmab092_desc,g_pmab_m.pmab093,g_pmab_m.pmab093_desc,g_pmab_m.pmab094,g_pmab_m.pmab095, 
       g_pmab_m.pmab096,g_pmab_m.pmab097,g_pmab_m.pmab097_desc,g_pmab_m.pmab098,g_pmab_m.pmab099,g_pmab_m.pmab100, 
       g_pmab_m.pmab101,g_pmab_m.pmab102,g_pmab_m.pmab030,g_pmab_m.pmab031,g_pmab_m.pmab031_desc,g_pmab_m.pmab059, 
       g_pmab_m.pmab059_desc,g_pmab_m.pmab032,g_pmab_m.pmab110,g_pmab_m.pmab033,g_pmab_m.pmab033_desc, 
       g_pmab_m.pmab034,g_pmab_m.pmab034_desc,g_pmab_m.pmab053,g_pmab_m.pmab053_desc,g_pmab_m.pmab054, 
       g_pmab_m.pmab054_desc,g_pmab_m.pmab035,g_pmab_m.pmab036,g_pmab_m.pmab056,g_pmab_m.pmab056_desc, 
       g_pmab_m.pmab037,g_pmab_m.pmab037_desc,g_pmab_m.pmab055,g_pmab_m.pmab055_desc,g_pmab_m.pmab038, 
       g_pmab_m.pmab038_desc,g_pmab_m.pmab039,g_pmab_m.pmab039_desc,g_pmab_m.pmab057,g_pmab_m.pmab058, 
       g_pmab_m.pmab040,g_pmab_m.pmab040_desc,g_pmab_m.pmab041,g_pmab_m.pmab041_desc,g_pmab_m.pmab042, 
       g_pmab_m.pmab042_desc,g_pmab_m.pmab043,g_pmab_m.pmab043_desc,g_pmab_m.pmab044,g_pmab_m.pmab045, 
       g_pmab_m.pmab046,g_pmab_m.pmab047,g_pmab_m.pmab047_desc,g_pmab_m.pmab048,g_pmab_m.pmab049,g_pmab_m.pmab050, 
       g_pmab_m.pmab051,g_pmab_m.pmab052,g_pmab_m.pmab071,g_pmab_m.pmab072,g_pmab_m.pmab073,g_pmab_m.pmab060, 
       g_pmab_m.pmab061,g_pmab_m.pmab066,g_pmab_m.pmab062,g_pmab_m.pmab067,g_pmab_m.pmab063,g_pmab_m.pmab068, 
       g_pmab_m.pmab064,g_pmab_m.pmab069,g_pmab_m.pmab065,g_pmab_m.pmab070,g_pmab_m.l_total,g_pmab_m.pmab002, 
       g_pmab_m.pmab003,g_pmab_m.pmab003_desc,g_pmab_m.pmab004,g_pmab_m.pmab004_desc,g_pmab_m.pmab005, 
       g_pmab_m.pmab005_desc,g_pmab_m.pmab006,g_pmab_m.pmab007,g_pmab_m.pmab008,g_pmab_m.pmab009,g_pmab_m.pmab019, 
       g_pmab_m.pmab010,g_pmab_m.pmab020,g_pmab_m.pmab011,g_pmab_m.pmab012,g_pmab_m.pmab013,g_pmab_m.pmab014, 
       g_pmab_m.pmab015,g_pmab_m.pmab016,g_pmab_m.pmab017,g_pmab_m.pmab018,g_pmab_m.ooff013,g_pmab_m.pmabownid, 
       g_pmab_m.pmabownid_desc,g_pmab_m.pmabowndp,g_pmab_m.pmabowndp_desc,g_pmab_m.pmabcrtid,g_pmab_m.pmabcrtid_desc, 
       g_pmab_m.pmabcrtdp,g_pmab_m.pmabcrtdp_desc,g_pmab_m.pmabcrtdt,g_pmab_m.pmabmodid,g_pmab_m.pmabmodid_desc, 
       g_pmab_m.pmabmoddt
   
   #儲存PK
   LET l_ac = g_current_idx
   CALL apmm101_set_pk_array()
   
   #顯示狀態(stus)圖片
   
 
   #顯示有特殊格式設定的欄位或說明
   CALL cl_show_fld_cont()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apmm101.delete" >}
#+ 資料刪除 
PRIVATE FUNCTION apmm101_delete()
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
   IF g_pmab_m.pmab001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
    
   LET g_pmab001_t = g_pmab_m.pmab001
 
   
   
 
   OPEN apmm101_cl USING g_enterprise, g_site,g_pmab_m.pmab001
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apmm101_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE apmm101_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE apmm101_master_referesh USING g_site,g_pmab_m.pmab001 INTO g_pmab_m.pmab001,g_pmab_m.pmab080, 
       g_pmab_m.pmab081,g_pmab_m.pmab109,g_pmab_m.pmab082,g_pmab_m.pmab111,g_pmab_m.pmab083,g_pmab_m.pmab084, 
       g_pmab_m.pmab103,g_pmab_m.pmab104,g_pmab_m.pmab085,g_pmab_m.pmab086,g_pmab_m.pmab106,g_pmab_m.pmab087, 
       g_pmab_m.pmab105,g_pmab_m.pmab088,g_pmab_m.pmab089,g_pmab_m.pmab107,g_pmab_m.pmab108,g_pmab_m.pmab090, 
       g_pmab_m.pmab091,g_pmab_m.pmab092,g_pmab_m.pmab093,g_pmab_m.pmab094,g_pmab_m.pmab095,g_pmab_m.pmab096, 
       g_pmab_m.pmab097,g_pmab_m.pmab098,g_pmab_m.pmab099,g_pmab_m.pmab100,g_pmab_m.pmab101,g_pmab_m.pmab102, 
       g_pmab_m.pmab030,g_pmab_m.pmab031,g_pmab_m.pmab059,g_pmab_m.pmab032,g_pmab_m.pmab110,g_pmab_m.pmab033, 
       g_pmab_m.pmab034,g_pmab_m.pmab053,g_pmab_m.pmab054,g_pmab_m.pmab035,g_pmab_m.pmab036,g_pmab_m.pmab056, 
       g_pmab_m.pmab037,g_pmab_m.pmab055,g_pmab_m.pmab038,g_pmab_m.pmab039,g_pmab_m.pmab057,g_pmab_m.pmab058, 
       g_pmab_m.pmab040,g_pmab_m.pmab041,g_pmab_m.pmab042,g_pmab_m.pmab043,g_pmab_m.pmab044,g_pmab_m.pmab045, 
       g_pmab_m.pmab046,g_pmab_m.pmab047,g_pmab_m.pmab048,g_pmab_m.pmab049,g_pmab_m.pmab050,g_pmab_m.pmab051, 
       g_pmab_m.pmab052,g_pmab_m.pmab071,g_pmab_m.pmab072,g_pmab_m.pmab073,g_pmab_m.pmab060,g_pmab_m.pmab061, 
       g_pmab_m.pmab066,g_pmab_m.pmab062,g_pmab_m.pmab067,g_pmab_m.pmab063,g_pmab_m.pmab068,g_pmab_m.pmab064, 
       g_pmab_m.pmab069,g_pmab_m.pmab065,g_pmab_m.pmab070,g_pmab_m.pmab002,g_pmab_m.pmab003,g_pmab_m.pmab004, 
       g_pmab_m.pmab005,g_pmab_m.pmab006,g_pmab_m.pmab007,g_pmab_m.pmab008,g_pmab_m.pmab009,g_pmab_m.pmab019, 
       g_pmab_m.pmab010,g_pmab_m.pmab020,g_pmab_m.pmab011,g_pmab_m.pmab012,g_pmab_m.pmab013,g_pmab_m.pmab014, 
       g_pmab_m.pmab015,g_pmab_m.pmab016,g_pmab_m.pmab017,g_pmab_m.pmab018,g_pmab_m.pmabownid,g_pmab_m.pmabowndp, 
       g_pmab_m.pmabcrtid,g_pmab_m.pmabcrtdp,g_pmab_m.pmabcrtdt,g_pmab_m.pmabmodid,g_pmab_m.pmabmoddt, 
       g_pmab_m.pmab081_desc,g_pmab_m.pmab109_desc,g_pmab_m.pmab083_desc,g_pmab_m.pmab103_desc,g_pmab_m.pmab104_desc, 
       g_pmab_m.pmab087_desc,g_pmab_m.pmab105_desc,g_pmab_m.pmab088_desc,g_pmab_m.pmab089_desc,g_pmab_m.pmab090_desc, 
       g_pmab_m.pmab091_desc,g_pmab_m.pmab092_desc,g_pmab_m.pmab093_desc,g_pmab_m.pmab097_desc,g_pmab_m.pmab031_desc, 
       g_pmab_m.pmab059_desc,g_pmab_m.pmab033_desc,g_pmab_m.pmab053_desc,g_pmab_m.pmab054_desc,g_pmab_m.pmab037_desc, 
       g_pmab_m.pmab055_desc,g_pmab_m.pmab038_desc,g_pmab_m.pmab039_desc,g_pmab_m.pmab040_desc,g_pmab_m.pmab041_desc, 
       g_pmab_m.pmab042_desc,g_pmab_m.pmab043_desc,g_pmab_m.pmab047_desc,g_pmab_m.pmab003_desc,g_pmab_m.pmab004_desc, 
       g_pmab_m.pmab005_desc,g_pmab_m.pmabownid_desc,g_pmab_m.pmabowndp_desc,g_pmab_m.pmabcrtid_desc, 
       g_pmab_m.pmabcrtdp_desc,g_pmab_m.pmabmodid_desc
   
   
   #檢查是否允許此動作
   IF NOT apmm101_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_pmab_m_mask_o.* =  g_pmab_m.*
   CALL apmm101_pmab_t_mask()
   LET g_pmab_m_mask_n.* =  g_pmab_m.*
   
   #將最新資料顯示到畫面上
   CALL apmm101_show()
   
   IF cl_ask_delete() THEN
 
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point
 
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL apmm101_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
 
      DELETE FROM pmab_t 
       WHERE pmabent = g_enterprise AND pmabsite = g_site AND pmab001 = g_pmab_m.pmab001 
 
 
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "pmab_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
  
      
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      LET l_success = ''
      CALL s_aooi360_del('2',g_pmab_m.pmab001,g_site,'','','','','','','','','4') RETURNING l_success
      IF NOT l_success THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ooff_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #end add-point
      
       
 
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_pmab_m)   #(ver:49)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:49)
         CLOSE apmm101_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      CLEAR FORM
      CALL apmm101_ui_browser_refresh()
      
      #確保畫面上保有資料
      IF g_browser_cnt > 0 THEN
         #CALL apmm101_browser_fill(g_wc,"")
         CALL apmm101_fetch("P")
      ELSE
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE    
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE apmm101_cl
 
   #功能已完成,通報訊息中心
   CALL apmm101_msgcentre_notify('delete')
 
   #add-point:單頭刪除完成後 name="delete.a_delete"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apmm101.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION apmm101_ui_browser_refresh()
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
      IF g_browser[l_i].b_pmab001 = g_pmab_m.pmab001
 
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
 
{<section id="apmm101.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION apmm101_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization" 
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point     
    
   #add-point:Function前置處理 name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("pmab001",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("pmab050,pmab052,pmab100,pmab102",TRUE)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="apmm101.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION apmm101_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("pmab001",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF NOT cl_null(g_argv[03]) THEN
      CALL cl_set_comp_entry("pmab001",FALSE)
   END IF 
   CALL cl_set_comp_entry("pmab002,pmab003,pmab004,pmab005,pmab006,pmab007,pmab008,pmab009,pmab019,pmab010,pmab020,pmab011,
                           pmab012,pmab013,pmab014,pmab015,pmab016,pmab017,pmab018",FALSE)
   IF g_pmab_m.pmab049 = 'N' THEN
      LET g_pmab_m.pmab050 = 0
      CALL cl_set_comp_entry("pmab050",FALSE)
   END IF
   IF g_pmab_m.pmab051 = 'N' THEN
      LET g_pmab_m.pmab052 = 0
      CALL cl_set_comp_entry("pmab052",FALSE)
   END IF
   IF g_pmab_m.pmab099 = 'N' THEN
      LET g_pmab_m.pmab100 = 0
      CALL cl_set_comp_entry("pmab100",FALSE)
   END IF
   IF g_pmab_m.pmab101 = 'N' THEN
      LET g_pmab_m.pmab102 = 0
      CALL cl_set_comp_entry("pmab102",FALSE)
   END IF
   
  #151210-00021#2 add -----(S)
   #若g_site<>'ALL'，則呼叫s_aooi090_set_no_entry，設定為集團一致的欄位不可輸入
   IF g_site <> 'ALL' THEN
      CALL s_aooi090_set_no_entry('4')  #'1' 交易對象資料
   END IF
  #151210-00021#2 add -----(E)   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="apmm101.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION apmm101_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization" 
   
   #end add-point  
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   CALL cl_set_act_visible("insert,modify,delete,query,reproduce",TRUE)

   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apmm101.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION apmm101_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   DEFINE l_pmaasuts  LIKE pmaa_t.pmaastus
   #end add-point
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #據點要應該用拋轉方式產生,不可手動新增
   IF g_argv[01] MATCHES '[123]' AND cl_null(g_argv[02]) THEN
      CALL cl_set_act_visible("insert",FALSE)
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      CALL cl_set_act_visible("insert,query,reproduce",FALSE)
   END IF
   LET l_pmaasuts = ''
   SELECT pmaastus INTO l_pmaasuts FROM pmaa_t WHERE pmaaent=g_enterprise AND pmaa001 = g_pmab_m.pmab001
   #IF NOT (g_prog = 'apmm102' OR g_prog = 'apmm202' OR g_prog = 'axmm202') THEN  #151210-00017 by whitney add   #160705-00042#10 160713 by sakura mark
   IF NOT (g_prog MATCHES 'apmm102' OR g_prog MATCHES 'apmm202' OR g_prog MATCHES 'axmm202') THEN                #160705-00042#10 160713 by sakura add
      IF l_pmaasuts = 'Y' THEN
         CALL cl_set_act_visible("delete", FALSE)
      END IF
   END IF  #151210-00017 by whitney add
   IF l_pmaasuts = 'X' THEN
      CALL cl_set_act_visible("modify,delete", FALSE)
   END IF
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apmm101.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION apmm101_default_search()
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
      LET ls_wc = ls_wc, " pmab001 = '", g_argv[01], "' AND "
   END IF
   
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   LET ls_wc = ''
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = " pmab001 = '", g_argv[03], "' AND "
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
         WHEN '1' LET g_wc = g_wc , " AND pmab001 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise," AND (pmaa002 = '1' OR pmaa002 = '3') ) "  #170120-00047#1 add ent
         WHEN '2' LET g_wc = g_wc , " AND pmab001 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise," AND (pmaa002 = '2' OR pmaa002 = '3') ) "  #170120-00047#1 add ent
         WHEN '3' LET g_wc = g_wc , " AND 1=1"
      END CASE
   END IF
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="apmm101.mask_functions" >}
&include "erp/apm/apmm101_mask.4gl"
 
{</section>}
 
{<section id="apmm101.state_change" >}
   
 
{</section>}
 
{<section id="apmm101.signature" >}
   
 
{</section>}
 
{<section id="apmm101.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION apmm101_set_pk_array()
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
   LET g_pk_array[1].values = g_pmab_m.pmab001
   LET g_pk_array[1].column = 'pmab001'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apmm101.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="apmm101.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION apmm101_msgcentre_notify(lc_state)
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
   CALL apmm101_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_pmab_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apmm101.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION apmm101_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization" 
   
   #end add-point
   #add-point:action_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   #151210-00017 by whitney add start
   DEFINE l_success        LIKE type_t.num5
   DEFINE l_use            LIKE type_t.num5
   #151210-00017 by whitney add end

   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #151210-00017 by whitney add start
   IF g_action_choice = "delete" THEN
      #IF g_prog = 'apmm102' OR g_prog = 'apmm202' OR g_prog = 'axmm202' THEN                    #160705-00042#10 160713 by sakura mark
      IF g_prog MATCHES 'apmm102' OR g_prog MATCHES 'apmm202' OR g_prog MATCHES 'axmm202' THEN   #160705-00042#10 160713 by sakura add
         #檢查基礎資料是否在azzi610設定的欄位內已有使用
         #CALL s_azzi610_check('2',g_pmab_m.pmab001)   #160816-00042#1
         CALL s_azzi610_check('2',g_pmab_m.pmab001,g_site)   #160816-00042#1
              RETURNING l_success,l_use
         IF NOT l_success THEN
            RETURN FALSE
         END IF
         IF l_use THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = g_pmab_m.pmab001
            LET g_errparam.code   = "aim-00248"
            LET g_errparam.replace[1] = s_desc_gzcbl004_desc('189','2')
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            RETURN FALSE
         END IF
      END IF
   END IF
   #151210-00017 by whitney add end
   
   #end add-point
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="apmm101.other_function" readonly="Y" >}
#################################################################################
#1.當傳入參數p_type = '1'(供應商維護作業)時
#  1-1."客戶資料"頁籤必須隱藏頁籤需隱藏不可以維護
#  1-2.畫面上是交易對象的名稱均改為供應商
#2.當傳入參數p_type = '2'(客戶維護作業)時，
#  2-1."供應商資料"、"供應商評鑑"頁籤需隱藏不可維護
#  2-2.畫面上是交易對象的名稱均改為客戶
#################################################################################
PRIVATE FUNCTION apmm101_set_visible()
    #供應商
    IF g_argv[1] = '1' THEN
       CALL cl_set_comp_visible("master_Folder_page",FALSE)
       CALL apmm101_set_title_visible('1')
    END IF
    #客戶    
    IF g_argv[1] = '2' THEN
       CALL cl_set_comp_visible("page_2,page_3",FALSE)
       CALL apmm101_set_title_visible('2')
    END IF   
END FUNCTION
#+
PRIVATE FUNCTION apmm101_set_title_visible(p_pmaa002)
DEFINE p_pmaa002  LIKE pmaa_t.pmaa002
DEFINE l_gzze003  LIKE gzze_t.gzze003
DEFINE l_ooef006  LIKE ooef_t.ooef006

       IF NOT cl_null(p_pmaa002) THEN
          #供應商
          IF p_pmaa002 = '1' THEN
             LET l_gzze003 = ' '
             SELECT gzze003 INTO l_gzze003 FROM gzze_t WHERE gzze001 = 'apm-00050' AND gzze002 = g_dlang
             CALL cl_set_comp_att_text('pmab001',l_gzze003)
             CALL cl_set_comp_att_text('b_pmab001',l_gzze003)
             LET l_gzze003 = ' '
             SELECT gzze003 INTO l_gzze003 FROM gzze_t WHERE gzze001 = 'apm-00051' AND gzze002 = g_dlang
             CALL cl_set_comp_att_text('pmaal004',l_gzze003)
             CALL cl_set_comp_att_text('b_pmab001_desc',l_gzze003)
             LET l_gzze003 = ' '
             SELECT gzze003 INTO l_gzze003 FROM gzze_t WHERE gzze001 = 'apm-00077' AND gzze002 = g_dlang
             CALL cl_set_comp_att_text('pmaal003',l_gzze003)
             CALL cl_set_comp_att_text('b_pmaal003',l_gzze003)
             #add--2015/06/25 By shiun--(S)
             LET l_gzze003 = ' '
             SELECT gzze003 INTO l_gzze003 FROM gzze_t WHERE gzze001 = 'apm-00962' AND gzze002 = g_dlang
             CALL cl_set_comp_att_text('pmaal006',l_gzze003)
             CALL cl_set_comp_att_text('b_pmaal006',l_gzze003)
             #add--2015/06/25 By shiun--(E)
             LET l_gzze003 = ' '
             SELECT gzze003 INTO l_gzze003 FROM gzze_t WHERE gzze001 = 'apm-00078' AND gzze002 = g_dlang
             CALL cl_set_comp_att_text('pmaa003',l_gzze003)
          END IF
          #客戶 
          IF p_pmaa002 = '2' THEN
             LET l_gzze003 = ' '
             SELECT gzze003 INTO l_gzze003 FROM gzze_t WHERE gzze001 = 'apm-00052' AND gzze002 = g_dlang
             CALL cl_set_comp_att_text('pmab001',l_gzze003)
             CALL cl_set_comp_att_text('b_pmab001',l_gzze003)
             LET l_gzze003 = ' '
             SELECT gzze003 INTO l_gzze003 FROM gzze_t WHERE gzze001 = 'apm-00053' AND gzze002 = g_dlang
             CALL cl_set_comp_att_text('pmaal004',l_gzze003)
             CALL cl_set_comp_att_text('b_pmab001_desc',l_gzze003)
             LET l_gzze003 = ' '
             SELECT gzze003 INTO l_gzze003 FROM gzze_t WHERE gzze001 = 'apm-00079' AND gzze002 = g_dlang
             CALL cl_set_comp_att_text('pmaal003',l_gzze003)
             CALL cl_set_comp_att_text('b_pmaal003',l_gzze003)
             #add--2015/06/25 By shiun--(S)
             LET l_gzze003 = ' '
             SELECT gzze003 INTO l_gzze003 FROM gzze_t WHERE gzze001 = 'apm-00963' AND gzze002 = g_dlang
             CALL cl_set_comp_att_text('pmaal006',l_gzze003)
             CALL cl_set_comp_att_text('b_pmaal006',l_gzze003)
             #add--2015/06/25 By shiun--(E)
             LET l_gzze003 = ' '
             SELECT gzze003 INTO l_gzze003 FROM gzze_t WHERE gzze001 = 'apm-00080' AND gzze002 = g_dlang
             CALL cl_set_comp_att_text('pmaa003',l_gzze003)
          END IF
       END IF
       
       #[T:營運據點資料檔].[C:專屬國家地區功能]為"台灣"畫面顯示"統一編號"
       LET l_ooef006 = ' '
       SELECT ooef006 INTO l_ooef006 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
       IF l_ooef006 = 'TW' OR l_ooef006 = 'tw' THEN
          LET l_gzze003 = ' '
          SELECT gzze003 INTO l_gzze003 FROM gzze_t WHERE gzze001 = 'apm-00084' AND gzze002 = g_dlang
          CALL cl_set_comp_att_text('pmaa003',l_gzze003)
       END IF
END FUNCTION
#+
PRIVATE FUNCTION apmm101_pmab001_ref(p_pmab001)
DEFINE p_pmab001      LIKE pmab_t.pmab001
DEFINE r_pmaa002      LIKE pmaa_t.pmaa002
DEFINE r_pmaal003     LIKE pmaal_t.pmaal003
DEFINE r_pmaal004     LIKE pmaal_t.pmaal004
DEFINE r_pmaal005     LIKE pmaal_t.pmaal005
DEFINE r_pmaa003      LIKE pmaal_t.pmaal003
DEFINE r_pmaastus     LIKE pmaa_t.pmaastus
DEFINE r_pmaal006     LIKE pmaal_t.pmaal006  #add--2015/06/25 By shiun

      LET r_pmaa002 = ''
      LET r_pmaal003 = ''
      LET r_pmaal004 = ''
      LET r_pmaal005 = ''
      LET r_pmaal006 = ''  #add--2015/06/25 By shiun
      LET r_pmaa003 = ''
      LET r_pmaastus = ''

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = p_pmab001
      CALL ap_ref_array2(g_ref_fields,"SELECT pmaal003,pmaal004,pmaal005,pmaal006 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields #modify--2015/06/25 By shiun
      LET r_pmaal003 = g_rtn_fields[1]
      LET r_pmaal004 = g_rtn_fields[2]
      LET r_pmaal005 = g_rtn_fields[3]
      LET r_pmaal006 = g_rtn_fields[4] #add--2015/06/25 By shiun
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = p_pmab001
      CALL ap_ref_array2(g_ref_fields,"SELECT pmaa002,pmaa003,pmaastus FROM pmaa_t WHERE pmaaent='"||g_enterprise||"' AND pmaa001=? ","") RETURNING g_rtn_fields
      LET r_pmaa002 = g_rtn_fields[1]
      LET r_pmaa003 = g_rtn_fields[2]
      LET r_pmaastus = g_rtn_fields[3]
      RETURN r_pmaa002,r_pmaal004,r_pmaal003,r_pmaal006,r_pmaal005,r_pmaa003,r_pmaastus
      
END FUNCTION
#+
PRIVATE FUNCTION apmm101_pmab001_chk(p_pmab001)
DEFINE p_pmab001    LIKE pmab_t.pmab001
DEFINE r_success    LIKE type_t.num5

      LET r_success = TRUE
      
      IF g_argv[1] = '1' THEN     
         IF NOT ap_chk_isExist(p_pmab001,"SELECT COUNT(*) FROM pmaa_t WHERE pmaaent = '" ||g_enterprise||"' AND pmaa001 = ? AND (pmaa002 = '1' OR pmaa002 = '3') ","apm-00024",1 ) THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
         IF NOT ap_chk_isExist(p_pmab001,"SELECT COUNT(*) FROM pmaa_t WHERE pmaaent = '" ||g_enterprise||"' AND pmaa001 = ? AND pmaastus != 'X' AND (pmaa002 = '1' OR pmaa002 = '3') ","apm-00025",1 ) THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
      END IF
      IF g_argv[1] = '2' THEN
         IF NOT ap_chk_isExist(p_pmab001,"SELECT COUNT(*) FROM pmaa_t WHERE pmaaent = '" ||g_enterprise||"' AND pmaa001 = ? AND (pmaa002 = '2' OR pmaa002 = '3') ","apm-00026",1 ) THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
         IF NOT ap_chk_isExist(p_pmab001,"SELECT COUNT(*) FROM pmaa_t WHERE pmaaent = '" ||g_enterprise||"' AND pmaa001 = ? AND pmaastus != 'X' AND (pmaa002 = '2' OR pmaa002 = '3') ","apm-00027",1 ) THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
      END IF
      IF g_argv[1] = '3' THEN
         IF NOT ap_chk_isExist(p_pmab001,"SELECT COUNT(*) FROM pmaa_t WHERE pmaaent = '" ||g_enterprise||"' AND pmaa001 = ? ","apm-00028",1 ) THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
         #IF NOT ap_chk_isExist(p_pmab001,"SELECT COUNT(*) FROM pmaa_t WHERE pmaaent = '" ||g_enterprise||"' AND pmaa001 = ? AND pmaastus != 'X' ","apm-00029",1 ) THEN         #160318-00005#34
         IF NOT ap_chk_isExist(p_pmab001,"SELECT COUNT(*) FROM pmaa_t WHERE pmaaent = '" ||g_enterprise||"' AND pmaa001 = ? AND pmaastus != 'X' ","sub-01302",'apmm100' ) THEN  #160318-00005#34
            LET r_success = FALSE
            RETURN r_success
         END IF
      END IF
      
      IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pmab_t WHERE pmabent = '" ||g_enterprise|| "' AND pmabsite = '" ||g_site|| "' AND pmab001 = '"||p_pmab001 ||"'",'std-00004',1) THEN 
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      RETURN r_success
      
END FUNCTION
#+
PRIVATE FUNCTION apmm101_pmab081_chk(p_pmab081)
DEFINE p_pmab081      LIKE pmab_t.pmab081
DEFINE r_success      LIKE type_t.num5

       LET r_success = TRUE
       
       IF NOT ap_chk_isExist(p_pmab081,"SELECT COUNT(*) FROM ooag_t WHERE ooagent = '" ||g_enterprise||"' AND ooag001 = ? ","aoo-00074",1 ) THEN
          LET r_success = FALSE
          RETURN r_success
       END IF
       #IF NOT ap_chk_isExist(p_pmab081,"SELECT COUNT(*) FROM ooag_t WHERE ooagent = '" ||g_enterprise||"' AND ooag001 = ? AND ooagstus = 'Y' ","aoo-00071",1 ) THEN         #160318-00005#34
       IF NOT ap_chk_isExist(p_pmab081,"SELECT COUNT(*) FROM ooag_t WHERE ooagent = '" ||g_enterprise||"' AND ooag001 = ? AND ooagstus = 'Y' ","sub-01302",'aooi130' ) THEN  #160318-00005#34
          LET r_success = FALSE
          RETURN r_success
       END IF
       RETURN r_success
       
END FUNCTION
#+
PRIVATE FUNCTION apmm101_pmab083_chk(p_pmab083)
DEFINE p_pmab083  LIKE pmab_t.pmab083
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
      LET g_chkparam.arg2 = p_pmab083

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
PRIVATE FUNCTION apmm101_pmab083_ref(p_pmab083)
DEFINE p_pmab083      LIKE pmab_t.pmab083
DEFINE r_pmab083_desc LIKE ooail_t.ooail003

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmab083
       CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001 = ? AND ooail002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmab083_desc = g_rtn_fields[1]
       RETURN r_pmab083_desc
       
END FUNCTION
#+
PRIVATE FUNCTION apmm101_pmab103_chk(p_pmab103)
DEFINE p_pmab103  LIKE pmab_t.pmab103
DEFINE r_success  LIKE type_t.num5

       LET r_success = TRUE
       
       #IF NOT ap_chk_isExist(p_pmab103,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '238' AND oocq002 = ? ","apm-00069",1 ) THEN          #160318-00005#34
       IF NOT ap_chk_isExist(p_pmab103,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '238' AND oocq002 = ? ","sub-01303",'apmi012' ) THEN   #160318-00005#34
          LET r_success = FALSE
          RETURN r_success
       END IF
       #IF NOT ap_chk_isExist(p_pmab103,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '238' AND oocq002 = ? AND oocqstus = 'Y' ","apm-00070",1 ) THEN         #160318-00005#34
       IF NOT ap_chk_isExist(p_pmab103,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '238' AND oocq002 = ? AND oocqstus = 'Y' ","sub-01302",'apmi012' ) THEN  #160318-00005#34
          LET r_success = FALSE
          RETURN r_success
       END IF
       RETURN r_success
       
END FUNCTION
#+
PRIVATE FUNCTION apmm101_pmab103_ref(p_pmab103)
DEFINE p_pmab103      LIKE pmab_t.pmab103
DEFINE r_pmab103_desc LIKE oocql_t.oocql004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmab103
       CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='238' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmab103_desc = g_rtn_fields[1]
       RETURN r_pmab103_desc
       
END FUNCTION
#+
PRIVATE FUNCTION apmm101_pmab090_chk(p_pmab090)
DEFINE p_pmab090  LIKE pmab_t.pmab090
DEFINE r_success  LIKE type_t.num5

       LET r_success = TRUE
       
       #IF NOT ap_chk_isExist(p_pmab090,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '263' AND oocq002 = ? ","apm-00073",1 ) THEN                #160318-00005#34
       IF NOT ap_chk_isExist(p_pmab090,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '263' AND oocq002 = ? ","sub-01303",'apmi011' ) THEN         #160318-00005#34
          LET r_success = FALSE
          RETURN r_success
       END IF
       #IF NOT ap_chk_isExist(p_pmab090,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '263' AND oocq002 = ? AND oocqstus = 'Y' ","apm-00074",1 ) THEN         #160318-00005#34
       IF NOT ap_chk_isExist(p_pmab090,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '263' AND oocq002 = ? AND oocqstus = 'Y' ","sub-01302",'apmi011' ) THEN  #160318-00005#34
          LET r_success = FALSE
          RETURN r_success
       END IF
       RETURN r_success
      
END FUNCTION
#+
PRIVATE FUNCTION apmm101_pmab090_ref(p_pmab090)
DEFINE p_pmab090      LIKE pmab_t.pmab090
DEFINE r_pmab090_desc LIKE oocql_t.oocql004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmab090
       CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='263' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmab090_desc = g_rtn_fields[1]
       RETURN r_pmab090_desc
       
END FUNCTION
#+
PRIVATE FUNCTION apmm101_pmab089_ref(p_pmab089)
DEFINE p_pmab089      LIKE pmab_t.pmab080
DEFINE r_pmab089_desc LIKE oocql_t.oocql004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmab089
       CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='295' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmab089_desc = g_rtn_fields[1]
       RETURN r_pmab089_desc
       
END FUNCTION
#+
PRIVATE FUNCTION apmm101_pmab091_chk(p_pmab091)
DEFINE p_pmab091    LIKE pmab_t.pmab091
DEFINE r_success    LIKE type_t.num5

       LET r_success = TRUE
       
       IF NOT cl_null(p_pmab091) THEN 
          #IF NOT ap_chk_isExist(p_pmab091,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '262' AND oocq002 = ? ","apm-00075",1 ) THEN                #160318-00005#34
          IF NOT ap_chk_isExist(p_pmab091,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '262' AND oocq002 = ? ","sub-01303",'apmi010' ) THEN         #160318-00005#34
             LET r_success = FALSE
             RETURN r_success
          END IF
          #IF NOT ap_chk_isExist(p_pmab091,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '262' AND oocq002 = ? AND oocqstus = 'Y' ","apm-00076",1 ) THEN           #160318-00005#34
           IF NOT ap_chk_isExist(p_pmab091,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '262' AND oocq002 = ? AND oocqstus = 'Y' ","sub-01302",'apmi010' ) THEN   #160318-00005#34
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF
       RETURN r_success
       
END FUNCTION
#+
PRIVATE FUNCTION apmm101_pmab091_ref(p_pmab091)
DEFINE p_pmab091      LIKE pmab_t.pmab091
DEFINE r_pmab091_desc LIKE oocql_t.oocql004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmab091
       CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='262' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmab091_desc = g_rtn_fields[1]
       RETURN r_pmab091_desc
    
END FUNCTION
#+
PRIVATE FUNCTION apmm101_pmab081_ref(p_pmab081)
DEFINE p_pmab081      LIKE pmab_t.pmab081
DEFINE r_pmab081_desc LIKE oofa_t.oofa011

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmab081
       CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
       LET r_pmab081_desc = g_rtn_fields[1]
       RETURN r_pmab081_desc
       
END FUNCTION
#+
PRIVATE FUNCTION apmm101_pmab039_ref(p_pmab039)
DEFINE p_pmab039      LIKE pmab_t.pmab039
DEFINE r_pmab039_desc LIKE oocql_t.oocql004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmab039
       CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='264' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmab039_desc = g_rtn_fields[1]
       RETURN r_pmab039_desc
       
END FUNCTION
#+
PRIVATE FUNCTION apmm101_jdsz()
DEFINE l_sql     STRING
DEFINE l_n       LIKE type_t.num5

       LET l_sql = "SELECT pmab001,'','','','','','','',pmab080,pmab081,'',pmab082,pmab083,'',pmab084,'',pmab103,'',pmab104,'',pmab085,pmab087,'',pmab105,'',pmab088,pmab089,'',pmab090,'',pmab091,'',pmab092,'',pmab093,'',pmab094,pmab095,pmab096,pmab097,'',pmab098,pmab099,pmab100,pmab101,pmab102,pmab030,pmab031,'',pmab032,pmab033,'',pmab034,'',pmab053,'',pmab054,'',pmab035,pmab037,'',pmab055,'',pmab038,pmab039,'',pmab040,'',pmab041,'',pmab042,'',pmab043,'',pmab044,pmab045,pmab046,pmab047,'',pmab048,pmab049,pmab050,pmab051,pmab052,pmab071,pmab072,pmab073,pmab060,pmab061,pmab066,pmab062,pmab067,pmab063,pmab068,pmab064,pmab069,pmab065,pmab070,'',pmab002,pmab003,'',pmab004,pmab005,'',pmab006,pmab007,pmab008,pmab009,pmab019,pmab010,pmab020,pmab011,pmab012,pmab013,pmab014,pmab015,pmab016,pmab017,pmab018,'',pmabownid,'',pmabowndp,'',pmabcrtid,'',pmabcrtdp,'',pmabcrtdt,pmabmodid,'',pmabmoddt FROM pmab_t WHERE pmabent= ? AND pmabsite= ? AND pmab001=? FOR UPDATE"

       LET l_sql = cl_sql_forupd(l_sql)                #轉換不同資料庫語法
       DECLARE apmm101_cl2 CURSOR FROM l_sql
       
       CALL cl_set_comp_entry("pmab002,pmab003,pmab004,pmab005,pmab006,pmab007,pmab008,pmab009,pmab019,pmab010,pmab020,pmab011,
                               pmab012,pmab013,pmab014,pmab015,pmab016,pmab017,pmab018",TRUE)
        
       CALL s_transaction_begin()
       
       OPEN apmm101_cl2 USING g_enterprise, g_site,g_pmab_m.pmab001
       IF STATUS THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code =  STATUS
          LET g_errparam.extend = "OPEN apmm101_cl2:"
          LET g_errparam.popup = TRUE
          CALL cl_err()

          CLOSE apmm101_cl2
          CALL s_transaction_end('N','0')
          RETURN
       END IF
       
        #鎖住將被更改或取消的資料
        FETCH apmm101_cl2 INTO g_pmab_m.pmab001,g_pmab_m.pmaal004,g_pmab_m.pmaal005,g_pmab_m.status1,g_pmab_m.pmaa002,g_pmab_m.pmaal003,g_pmab_m.pmaal006,g_pmab_m.pmaa003,g_pmab_m.pmab080,g_pmab_m.pmab081,g_pmab_m.pmab081_desc,g_pmab_m.pmab082,g_pmab_m.pmab083,g_pmab_m.pmab083_desc,g_pmab_m.pmab084,g_pmab_m.pmab084_desc,g_pmab_m.pmab103,g_pmab_m.pmab103_desc,g_pmab_m.pmab104,g_pmab_m.pmab104_desc,g_pmab_m.pmab085,g_pmab_m.pmab087,g_pmab_m.pmab087_desc,g_pmab_m.pmab105,g_pmab_m.pmab105_desc,g_pmab_m.pmab088,g_pmab_m.pmab089,g_pmab_m.pmab089_desc,g_pmab_m.pmab090,g_pmab_m.pmab090_desc,g_pmab_m.pmab091,g_pmab_m.pmab091_desc,g_pmab_m.pmab092,g_pmab_m.pmab092_desc,g_pmab_m.pmab093,g_pmab_m.pmab093_desc,g_pmab_m.pmab094,g_pmab_m.pmab095,g_pmab_m.pmab096,g_pmab_m.pmab097,g_pmab_m.pmab097_desc,g_pmab_m.pmab098,g_pmab_m.pmab099,g_pmab_m.pmab100,g_pmab_m.pmab101,g_pmab_m.pmab102,g_pmab_m.pmab030,g_pmab_m.pmab031,g_pmab_m.pmab031_desc,g_pmab_m.pmab032,g_pmab_m.pmab033,g_pmab_m.pmab033_desc,g_pmab_m.pmab034,g_pmab_m.pmab034_desc,g_pmab_m.pmab053,g_pmab_m.pmab053_desc,g_pmab_m.pmab054,g_pmab_m.pmab054_desc,g_pmab_m.pmab035,g_pmab_m.pmab037,g_pmab_m.pmab037_desc,g_pmab_m.pmab055,g_pmab_m.pmab055_desc,g_pmab_m.pmab038,g_pmab_m.pmab039,g_pmab_m.pmab039_desc,g_pmab_m.pmab040,g_pmab_m.pmab040_desc,g_pmab_m.pmab041,g_pmab_m.pmab041_desc,g_pmab_m.pmab042,g_pmab_m.pmab042_desc,g_pmab_m.pmab043,g_pmab_m.pmab043_desc,g_pmab_m.pmab044,g_pmab_m.pmab045,g_pmab_m.pmab046,g_pmab_m.pmab047,g_pmab_m.pmab047_desc,g_pmab_m.pmab048,g_pmab_m.pmab049,g_pmab_m.pmab050,g_pmab_m.pmab051,g_pmab_m.pmab052,g_pmab_m.pmab071,g_pmab_m.pmab072,g_pmab_m.pmab073,g_pmab_m.pmab060,g_pmab_m.pmab061,g_pmab_m.pmab066,g_pmab_m.pmab062,g_pmab_m.pmab067,g_pmab_m.pmab063,g_pmab_m.pmab068,g_pmab_m.pmab064,g_pmab_m.pmab069,g_pmab_m.pmab065,g_pmab_m.pmab070,g_pmab_m.l_total,g_pmab_m.pmab002,g_pmab_m.pmab003,g_pmab_m.pmab003_desc,g_pmab_m.pmab004,g_pmab_m.pmab005,g_pmab_m.pmab005_desc,g_pmab_m.pmab006,g_pmab_m.pmab007,g_pmab_m.pmab008,g_pmab_m.pmab009,g_pmab_m.pmab019,g_pmab_m.pmab010,g_pmab_m.pmab020,g_pmab_m.pmab011,g_pmab_m.pmab012,g_pmab_m.pmab013,g_pmab_m.pmab014,g_pmab_m.pmab015,g_pmab_m.pmab016,g_pmab_m.pmab017,g_pmab_m.pmab018,g_pmab_m.ooff013,g_pmab_m.pmabownid,g_pmab_m.pmabownid_desc,g_pmab_m.pmabowndp,g_pmab_m.pmabowndp_desc,g_pmab_m.pmabcrtid,g_pmab_m.pmabcrtid_desc,g_pmab_m.pmabcrtdp,g_pmab_m.pmabcrtdp_desc,g_pmab_m.pmabcrtdt,g_pmab_m.pmabmodid,g_pmab_m.pmabmodid_desc,g_pmab_m.pmabmoddt   #modifu--2015/06/25 By shiun
 
       #資料被他人LOCK, 或是sql執行時出現錯誤
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = "pmab_t"
          LET g_errparam.popup = FALSE
          CALL cl_err()

          CLOSE apmm101_cl2
          CALL s_transaction_end('N','0')
          RETURN
       END IF
   
   
       LET g_pmab_m.pmabmodid = g_user 
       LET g_pmab_m.pmabmoddt = cl_get_current()
       
       DISPLAY BY NAME g_pmab_m.pmab001,g_pmab_m.pmaal004,g_pmab_m.pmaal005,g_pmab_m.status1,g_pmab_m.pmaa002,g_pmab_m.pmaal003,g_pmab_m.pmaal006,g_pmab_m.pmaa003,g_pmab_m.pmab080,g_pmab_m.pmab081,g_pmab_m.pmab081_desc,g_pmab_m.pmab082,g_pmab_m.pmab083,g_pmab_m.pmab083_desc,g_pmab_m.pmab084,g_pmab_m.pmab084_desc,g_pmab_m.pmab103,g_pmab_m.pmab103_desc,g_pmab_m.pmab104,g_pmab_m.pmab104_desc,g_pmab_m.pmab085,g_pmab_m.pmab087,g_pmab_m.pmab087_desc,g_pmab_m.pmab105,g_pmab_m.pmab105_desc,g_pmab_m.pmab088,g_pmab_m.pmab089,g_pmab_m.pmab089_desc,g_pmab_m.pmab090,g_pmab_m.pmab090_desc,g_pmab_m.pmab091,g_pmab_m.pmab091_desc,g_pmab_m.pmab092,g_pmab_m.pmab092_desc,g_pmab_m.pmab093,g_pmab_m.pmab093_desc,g_pmab_m.pmab094,g_pmab_m.pmab095,g_pmab_m.pmab096,g_pmab_m.pmab097,g_pmab_m.pmab097_desc,g_pmab_m.pmab098,g_pmab_m.pmab099,g_pmab_m.pmab100,g_pmab_m.pmab101,g_pmab_m.pmab102,g_pmab_m.pmab030,g_pmab_m.pmab031,g_pmab_m.pmab031_desc,g_pmab_m.pmab032,g_pmab_m.pmab033,g_pmab_m.pmab033_desc,g_pmab_m.pmab034,g_pmab_m.pmab034_desc,g_pmab_m.pmab053,g_pmab_m.pmab053_desc,g_pmab_m.pmab054,g_pmab_m.pmab054_desc,g_pmab_m.pmab035,g_pmab_m.pmab037,g_pmab_m.pmab037_desc,g_pmab_m.pmab055,g_pmab_m.pmab055_desc,g_pmab_m.pmab038,g_pmab_m.pmab039,g_pmab_m.pmab039_desc,g_pmab_m.pmab040,g_pmab_m.pmab040_desc,g_pmab_m.pmab041,g_pmab_m.pmab041_desc,g_pmab_m.pmab042,g_pmab_m.pmab042_desc,g_pmab_m.pmab043,g_pmab_m.pmab043_desc,g_pmab_m.pmab044,g_pmab_m.pmab045,g_pmab_m.pmab046,g_pmab_m.pmab047,g_pmab_m.pmab047_desc,g_pmab_m.pmab048,g_pmab_m.pmab049,g_pmab_m.pmab050,g_pmab_m.pmab051,g_pmab_m.pmab052,g_pmab_m.pmab071,g_pmab_m.pmab072,g_pmab_m.pmab073,g_pmab_m.pmab060,g_pmab_m.pmab061,g_pmab_m.pmab066,g_pmab_m.pmab062,g_pmab_m.pmab067,g_pmab_m.pmab063,g_pmab_m.pmab068,g_pmab_m.pmab064,g_pmab_m.pmab069,g_pmab_m.pmab065,g_pmab_m.pmab070,g_pmab_m.l_total,g_pmab_m.pmab002,g_pmab_m.pmab003,g_pmab_m.pmab003_desc,g_pmab_m.pmab004,g_pmab_m.pmab005,g_pmab_m.pmab005_desc,g_pmab_m.pmab006,g_pmab_m.pmab007,g_pmab_m.pmab008,g_pmab_m.pmab009,g_pmab_m.pmab019,g_pmab_m.pmab010,g_pmab_m.pmab020,g_pmab_m.pmab011,g_pmab_m.pmab012,g_pmab_m.pmab013,g_pmab_m.pmab014,g_pmab_m.pmab015,g_pmab_m.pmab016,g_pmab_m.pmab017,g_pmab_m.pmab018,g_pmab_m.ooff013,g_pmab_m.pmabownid,g_pmab_m.pmabownid_desc,g_pmab_m.pmabowndp,g_pmab_m.pmabowndp_desc,g_pmab_m.pmabcrtid,g_pmab_m.pmabcrtid_desc,g_pmab_m.pmabcrtdp,g_pmab_m.pmabcrtdp_desc,g_pmab_m.pmabcrtdt,g_pmab_m.pmabmodid,g_pmab_m.pmabmodid_desc,g_pmab_m.pmabmoddt   #modifu--2015/06/25 By shiun
       #160617-00003#1 add(s)
       IF cl_null(g_pmab_m.pmab003) THEN
          LET g_pmab_m.pmab003 = g_pmab_m.pmab001
          CALL apmm101_pmab003_ref(g_pmab_m.pmab003) RETURNING g_pmab_m.pmab003_desc
          DISPLAY BY NAME g_pmab_m.pmab003_desc
       END IF
       #160617-00003#1 add(e)
       LET g_errshow = 1
       
       INPUT BY NAME g_pmab_m.pmab002,g_pmab_m.pmab003,g_pmab_m.pmab004,g_pmab_m.pmab005,g_pmab_m.pmab006,
                     g_pmab_m.pmab007,g_pmab_m.pmab008,g_pmab_m.pmab009,g_pmab_m.pmab019,g_pmab_m.pmab010,g_pmab_m.pmab020,g_pmab_m.pmab011,
                     g_pmab_m.pmab012,g_pmab_m.pmab013,g_pmab_m.pmab014,g_pmab_m.pmab015,g_pmab_m.pmab016,
                     g_pmab_m.pmab017,g_pmab_m.pmab018  
               WITHOUT DEFAULTS
         #150930-00021#5 20151002 add by beckxie---S
         BEFORE INPUT
            IF g_pmab_m.pmab003 <> g_pmab_m.pmab001 THEN
               CALL cl_set_comp_entry("pmab004,pmab005,pmab006,pmab007,pmab008,pmab009,pmab019,pmab010,pmab020",FALSE)
            ELSE
               CALL cl_set_comp_entry("pmab004,pmab005,pmab006,pmab007,pmab008,pmab009,pmab019,pmab010,pmab020",TRUE)
            END IF 
            LET g_pmab_m_o.* = g_pmab_m.*
            LET g_pmab_m_t.* = g_pmab_m.*
         #150930-00021#5 20151002 add by beckxie---E
         AFTER FIELD pmab002
            CALL apmm101_set_required()
            CALL apmm101_set_no_required()
            
         ON CHANGE pmab002
            CALL apmm101_set_required()
            CALL apmm101_set_no_required()

         AFTER FIELD pmab003
            LET g_pmab_m.pmab003_desc = ''
            IF NOT cl_null(g_pmab_m.pmab003) THEN
               IF g_pmab_m.pmab003 != g_pmab_m_o.pmab003 OR cl_null(g_pmab_m_o.pmab003) THEN 
                  IF NOT ap_chk_isExist(g_pmab_m.pmab003,"SELECT COUNT(*) FROM pmaa_t WHERE pmaaent = '" ||g_enterprise||"' AND pmaa001 = ? ","apm-00028",1 ) THEN
                     LET g_pmab_m.pmab003 = g_pmab_m_o.pmab003
                     CALL apmm101_pmab003_ref(g_pmab_m.pmab003) RETURNING g_pmab_m.pmab003_desc
                     DISPLAY BY NAME g_pmab_m.pmab003,g_pmab_m.pmab003_desc
                     NEXT FIELD CURRENT
                  END IF
                  #IF NOT ap_chk_isExist(g_pmab_m.pmab003,"SELECT COUNT(*) FROM pmaa_t WHERE pmaaent = '" ||g_enterprise||"' AND pmaa001 = ? AND pmaastus != 'X' ","apm-00029",1 ) THEN        #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmab_m.pmab003,"SELECT COUNT(*) FROM pmaa_t WHERE pmaaent = '" ||g_enterprise||"' AND pmaa001 = ? AND pmaastus != 'X' ","sub-01302",'apmm100' ) THEN #160318-00005#34
                     LET g_pmab_m.pmab003 = g_pmab_m_o.pmab003
                     CALL apmm101_pmab003_ref(g_pmab_m.pmab003) RETURNING g_pmab_m.pmab003_desc
                     DISPLAY BY NAME g_pmab_m.pmab003,g_pmab_m.pmab003_desc
                     NEXT FIELD CURRENT
                  END IF
                  #150930-00021#5 20151002 add by beckxie---S
                  IF g_pmab_m.pmab003 <> g_pmab_m.pmab001 THEN
                     CALL cl_set_comp_entry("pmab004,pmab005,pmab006,pmab007,pmab008,pmab009,pmab019,pmab010,pmab020",FALSE)
                  ELSE
                     CALL cl_set_comp_entry("pmab004,pmab005,pmab006,pmab007,pmab008,pmab009,pmab019,pmab010,pmab020",TRUE)
                  END IF
                  #150930-00021#5 20151002 add by beckxie---E               
               END IF
            END IF
            LET g_pmab_m_o.pmab003 = g_pmab_m.pmab003
            CALL apmm101_pmab003_ref(g_pmab_m.pmab003) RETURNING g_pmab_m.pmab003_desc
            DISPLAY BY NAME g_pmab_m.pmab003_desc
            
         AFTER FIELD pmab004
            LET g_pmab_m.pmab004_desc = ''
            IF NOT cl_null(g_pmab_m.pmab004) THEN
               IF g_pmab_m.pmab004 != g_pmab_m_o.pmab004 OR cl_null(g_pmab_m_o.pmab004) THEN 
               ##供應商評核等級
               #IF g_argv[01] = '1' THEN
               #   #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影>
               #   INITIALIZE g_chkparam.* TO NULL
               #   
               #   #設定g_chkparam.*的參數
               #   LET g_chkparam.arg1 = g_site_t
               #   LET g_chkparam.arg2 = g_pmab_m.pmab004
               #   #呼叫檢查存在並帶值的library
               #   IF NOT cl_chk_exist("v_pmbk001_1") THEN
               #      LET g_pmab_m.pmab004 = g_pmab_m_t.pmab004
               #      CALL apmm101_pmab004_ref(g_pmab_m.pmab004) RETURNING g_pmab_m.pmab004_desc
               #      DISPLAY BY NAME g_pmab_m.pmab004_desc
               #      NEXT FIELD CURRENT
               #   END IF
               #END IF
               ##客戶評核等級
               #IF g_argv[01] = '2' THEN
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影>
                  INITIALIZE g_chkparam.* TO NULL
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_pmab_m.pmab004
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_xmaj001") THEN
                     LET g_pmab_m.pmab004 = g_pmab_m_o.pmab004
                     CALL apmm101_pmab004_ref(g_pmab_m.pmab004) RETURNING g_pmab_m.pmab004_desc
                     DISPLAY BY NAME g_pmab_m.pmab004,g_pmab_m.pmab004_desc
                     NEXT FIELD CURRENT
                  END IF
               #END IF
               ##交易對象評核等級
               #IF g_argv[01] = '3' THEN
               #   #先判斷是否存在供應商中
               #   LET l_n = 0
               #   SELECT COUNT(*) INTO l_n FROM pmbk_t WHERE pmbkent = g_enterprise AND pmbksite = g_site_t AND pmbk001 = g_pmab_m.pmab004 AND pmbkstus = 'Y'
               #   IF l_n = 0 THEN
               #      SELECT COUNT(*) INTO l_n FROM xmaj_t WHERE xmajent = g_enterprise AND xmaj001= g_pmab_m.pmab004
               #      IF l_n = 0 THEN        
               #         INITIALIZE g_errparam TO NULL
               #         LET g_errparam.extend = g_pmab_m.pmab004
               #         LET g_errparam.code   = 'apm-00887'
               #         LET g_errparam.popup  = TRUE
               #         CALL cl_err()
               #         LET g_pmab_m.pmab004 = g_pmab_m_t.pmab004
               #         CALL apmm101_pmab004_ref(g_pmab_m.pmab004) RETURNING g_pmab_m.pmab004_desc
               #         DISPLAY BY NAME g_pmab_m.pmab004_desc
               #         NEXT FIELD CURRENT
               #      END IF
               #   END IF
               #END IF
               END IF
            END IF
            LET g_pmab_m_o.pmab004 = g_pmab_m.pmab004
            CALL apmm101_pmab004_ref(g_pmab_m.pmab004) RETURNING g_pmab_m.pmab004_desc
            DISPLAY BY NAME g_pmab_m.pmab004_desc

         AFTER FIELD pmab005
            LET g_pmab_m.pmab005_desc = ''
            IF NOT cl_null(g_pmab_m.pmab005) THEN
               IF g_pmab_m.pmab005 != g_pmab_m_o.pmab005 OR cl_null(g_pmab_m_o.pmab005) THEN 
                  IF NOT apmm101_pmab083_chk(g_pmab_m.pmab005) THEN
                     LET g_pmab_m.pmab005 = g_pmab_m_o.pmab005
                     CALL apmm101_pmab083_ref(g_pmab_m.pmab005) RETURNING g_pmab_m.pmab005_desc
                     DISPLAY BY NAME g_pmab_m.pmab005,g_pmab_m.pmab005_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_pmab_m_o.pmab005 = g_pmab_m.pmab005
            CALL apmm101_pmab083_ref(g_pmab_m.pmab005) RETURNING g_pmab_m.pmab005_desc
            DISPLAY BY NAME g_pmab_m.pmab005_desc

         AFTER FIELD pmab006
            IF NOT cl_null(g_pmab_m.pmab006) THEN
               IF g_pmab_m.pmab006 != g_pmab_m_o.pmab006 OR cl_null(g_pmab_m_o.pmab006) THEN 
                  IF NOT cl_ap_chk_range(g_pmab_m.pmab006,"0.000","1","","","azz-00079",1) THEN
                     LET g_pmab_m.pmab006 = g_pmab_m_o.pmab006
                     DISPLAY BY NAME g_pmab_m.pmab006
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_pmab_m_o.pmab006 = g_pmab_m.pmab006

         AFTER FIELD pmab007
            IF NOT cl_null(g_pmab_m.pmab007) THEN
               IF g_pmab_m.pmab007 != g_pmab_m_o.pmab007 OR cl_null(g_pmab_m_o.pmab007) THEN 
                  IF NOT cl_ap_chk_range(g_pmab_m.pmab007,"0.000","1","","","azz-00079",1) THEN
                     LET g_pmab_m.pmab007 = g_pmab_m_o.pmab007
                     DISPLAY BY NAME g_pmab_m.pmab007
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_pmab_m_o.pmab007 = g_pmab_m.pmab007

         AFTER FIELD pmab009
            IF NOT cl_null(g_pmab_m.pmab009) THEN
               IF g_pmab_m.pmab009 != g_pmab_m_o.pmab009 OR cl_null(g_pmab_m_o.pmab009) THEN 
                  IF NOT cl_ap_chk_range(g_pmab_m.pmab009,"0.000","1","","","azz-00079",1) THEN
                     LET g_pmab_m.pmab009 = g_pmab_m_o.pmab009
                     DISPLAY BY NAME g_pmab_m.pmab009
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_pmab_m_o.pmab009 = g_pmab_m.pmab009
         
         AFTER FIELD pmab019
            IF NOT cl_null(g_pmab_m.pmab019) THEN
               IF g_pmab_m.pmab019 != g_pmab_m_o.pmab019 OR cl_null(g_pmab_m_o.pmab019) THEN 
                  IF NOT cl_ap_chk_range(g_pmab_m.pmab019,"0.000","1","","","azz-00079",1) THEN
                     LET g_pmab_m.pmab019 = g_pmab_m_o.pmab019
                     DISPLAY BY NAME g_pmab_m.pmab019
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_pmab_m_o.pmab019 = g_pmab_m.pmab019
            
         AFTER FIELD pmab010
            IF NOT cl_null(g_pmab_m.pmab010) THEN
               IF g_pmab_m.pmab010 != g_pmab_m_o.pmab010 OR cl_null(g_pmab_m_o.pmab010) THEN 
                  IF NOT cl_ap_chk_range(g_pmab_m.pmab010,"0.000","1","","","azz-00079",1) THEN
                     LET g_pmab_m.pmab010 = g_pmab_m_o.pmab010
                     DISPLAY BY NAME g_pmab_m.pmab010
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_pmab_m_o.pmab010 = g_pmab_m.pmab010

         AFTER FIELD pmab011
            IF NOT cl_null(g_pmab_m.pmab011) THEN
               IF g_pmab_m.pmab011 != g_pmab_m_o.pmab011 OR cl_null(g_pmab_m_o.pmab011) THEN 
                  IF NOT cl_ap_chk_range(g_pmab_m.pmab011,"0.000","1","100.000","1","azz-00079",1) THEN
                     LET g_pmab_m.pmab011 = g_pmab_m_o.pmab011
                     DISPLAY BY NAME g_pmab_m.pmab011
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_pmab_m_o.pmab011 = g_pmab_m.pmab011

         AFTER FIELD pmab013
            IF NOT cl_null(g_pmab_m.pmab013) THEN
               IF g_pmab_m.pmab013 != g_pmab_m_o.pmab013 OR cl_null(g_pmab_m_o.pmab013) THEN 
                  IF NOT cl_ap_chk_range(g_pmab_m.pmab013,"0.000","1","100.000","1","azz-00079",1) THEN
                     LET g_pmab_m.pmab013 = g_pmab_m_o.pmab013
                     DISPLAY BY NAME g_pmab_m.pmab013
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_pmab_m_o.pmab013 = g_pmab_m.pmab013

         AFTER FIELD pmab015
            IF NOT cl_null(g_pmab_m.pmab015) THEN
               IF g_pmab_m.pmab015 != g_pmab_m_o.pmab015 OR cl_null(g_pmab_m_o.pmab015) THEN 
                  IF NOT cl_ap_chk_range(g_pmab_m.pmab015,"0.000","1","100.000","1","azz-00079",1) THEN
                     LET g_pmab_m.pmab015 = g_pmab_m_o.pmab015
                     DISPLAY BY NAME g_pmab_m.pmab015
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_pmab_m_o.pmab015 = g_pmab_m.pmab015

         ON ACTION controlp INFIELD pmab003
            INITIALIZE g_qryparam.* TO NULL   #15/08/12 Sarah add
            LET g_qryparam.state = "i"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmab_m.pmab003             #給予default值
            CALL q_pmaa001_4()                                #呼叫開窗
            LET g_pmab_m.pmab003 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_pmab_m.pmab003 TO pmab003              #顯示到畫面上
            CALL apmm101_pmab003_ref(g_pmab_m.pmab003) RETURNING g_pmab_m.pmab003_desc
            DISPLAY BY NAME g_pmab_m.pmab003_desc
            NEXT FIELD pmab003                          #返回原欄位
            
         ON ACTION controlp INFIELD pmab004
            #開窗i段
            IF g_argv[01] = '3' THEN
               MENU "" ATTRIBUTE (STYLE="popup", IMAGE="question")
                  ON ACTION open_pmbk   #供應商
                     LET g_bgjob = '1'
                     EXIT MENU
               
                  ON ACTION open_xmaj   #客戶
                     LET g_bgjob = '2'
                     EXIT MENU
               END MENU
            END IF
            INITIALIZE g_qryparam.* TO NULL   #15/08/12 Sarah add
            LET g_qryparam.state = "i"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmab_m.pmab004             #給予default值
            ##供應商評核等級
            #IF g_argv[01] = '1' THEN
            #   LET g_qryparam.arg1 = g_site_t
            #   CALL q_pmbk001_2()
            #END IF
            #IF g_argv[01] = '2' THEN   
            #   CALL q_xmaj001()                                #呼叫開窗
            #END IF
            #IF g_argv[01] = '3' THEN
            #   IF g_bgjob = '1' THEN
            #      LET g_qryparam.arg1 = g_site_t
            #      CALL q_pmbk001_2()
            #   ELSE
            #      CALL q_xmaj001() 
            #   END IF
            #END IF
            CALL q_xmaj001()  
            LET g_pmab_m.pmab004 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_pmab_m.pmab004 TO pmab004              #顯示到畫面上
            CALL apmm101_pmab004_ref(g_pmab_m.pmab004) RETURNING g_pmab_m.pmab004_desc
            DISPLAY BY NAME g_pmab_m.pmab004_desc
            NEXT FIELD pmab004                          #返回原欄位

         ON ACTION controlp INFIELD pmab005
            INITIALIZE g_qryparam.* TO NULL   #15/08/12 Sarah add
            LET g_qryparam.state = "i"
            LET g_qryparam.reqry = FALSE
            IF g_site = 'ALL' THEN
               LET g_qryparam.arg1 = g_site_t
            ELSE
               LET g_qryparam.arg1 = g_site
            END IF
            LET g_qryparam.default1 = g_pmab_m.pmab005             #給予default值
            CALL q_ooaj002_1()                                #呼叫開窗
            LET g_pmab_m.pmab005 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_pmab_m.pmab005 TO pmab005              #顯示到畫面上
            CALL apmm101_pmab083_ref(g_pmab_m.pmab005) RETURNING g_pmab_m.pmab005_desc
            DISPLAY BY NAME g_pmab_m.pmab005_desc
            NEXT FIELD pmab005                          #返回原欄位
            
       
         AFTER INPUT
            IF INT_FLAG THEN
               CALL s_transaction_end('N','0')
               EXIT INPUT
            END IF
            UPDATE pmab_t SET (pmab002,pmab003,pmab004,pmab005,pmab006,pmab007,pmab008,pmab009,pmab019,pmab010,pmab020,pmab011,
                               pmab012,pmab013,pmab014,pmab015,pmab016,pmab017,pmab018,pmabmodid,pmabmoddt) 
                            = (g_pmab_m.pmab002,g_pmab_m.pmab003,g_pmab_m.pmab004,g_pmab_m.pmab005,g_pmab_m.pmab006,
                               g_pmab_m.pmab007,g_pmab_m.pmab008,g_pmab_m.pmab009,g_pmab_m.pmab019,g_pmab_m.pmab010,g_pmab_m.pmab020,
                               g_pmab_m.pmab011,
                               g_pmab_m.pmab012,g_pmab_m.pmab013,g_pmab_m.pmab014,g_pmab_m.pmab015,g_pmab_m.pmab016,
                               g_pmab_m.pmab017,g_pmab_m.pmab018,g_pmab_m.pmabmodid,g_pmab_m.pmabmoddt)
                WHERE pmabent = g_enterprise AND pmab001 = g_pmab_m.pmab001
                  AND pmabsite = g_site                    #20150420 POLLY ADD   
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "g_pmaa_m"
               LET g_errparam.popup = TRUE
               CALL cl_err()
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
               #150930-00021#5 20151002 add by beckxie---S
               IF (g_pmab_m.pmab003 != g_pmab_m_t.pmab003 OR g_pmab_m.pmab005 != g_pmab_m_t.pmab005) THEN
                  CALL cl_ask_confirm3('axm-00728',"")
                  IF g_pmab_m.pmab003 != g_pmab_m_t.pmab003 THEN          #異動額度客戶
                     CALL s_apmm100_call_axmp140_bg(g_pmab_m_t.pmab003)   #變更前的額度客戶
                     CALL s_apmm100_call_axmp140_bg(g_pmab_m.pmab003)     #變更後的額度客戶
                  ELSE
                     CALL s_apmm100_call_axmp140_bg(g_pmab_m.pmab003) 
                  END IF
                  CALL cl_ask_confirm3("axm-00729","")
               END IF
               #150930-00021#5 20151002 add by beckxie---E
            END IF
            
      END INPUT
      LET INT_FLAG = FALSE
      CLOSE apmm101_cl2
#      CALL apmm101_show()  160617-00003#1 mark
      CALL apmm101_fetch('')  #160617-00003#1 add 刷新画面
      
END FUNCTION
#+
PRIVATE FUNCTION apmm101_pmab003_ref(p_pmab003)
DEFINE p_pmab003      LIKE pmab_t.pmab003
DEFINE r_pmab003_desc LIKE pmaal_t.pmaal004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmab003
       CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmab003_desc = '', g_rtn_fields[1] , ''
       RETURN r_pmab003_desc
       
END FUNCTION
#+
PRIVATE FUNCTION apmm101_pmab097_chk(p_pmab097)
DEFINE p_pmab097    LIKE pmab_t.pmab097
DEFINE r_success    LIKE type_t.num5

      LET r_success = TRUE
      
      IF NOT ap_chk_isExist(p_pmab097,"SELECT COUNT(*) FROM pmaa_t WHERE pmaaent = '" ||g_enterprise||"' AND pmaa001 = ? AND (pmaa002 = '1' OR pmaa002 = '3') ","apm-00024",1 ) THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
      IF NOT ap_chk_isExist(p_pmab097,"SELECT COUNT(*) FROM pmaa_t WHERE pmaaent = '" ||g_enterprise||"' AND pmaa001 = ? AND pmaastus != 'X' AND (pmaa002 = '1' OR pmaa002 = '3') ","apm-00025",1 ) THEN
         LET r_success = FALSE
         RETURN r_success
      END IF

      RETURN r_success
END FUNCTION
#+
PRIVATE FUNCTION apmm101_pmab001_show()
      SELECT UNIQUE pmab001,pmab080,pmab081,pmab082,pmab083,pmab084,pmab103,pmab104,pmab085,pmab087,pmab088,pmab089,pmab090,pmab091,pmab092,pmab093,pmab094,pmab095,pmab096,pmab097,pmab098,pmab099,pmab100,pmab101,pmab102,pmab030,pmab031,pmab032,pmab033,pmab034,pmab053,pmab054,pmab035,pmab037,pmab038,pmab039,pmab040,pmab041,pmab042,pmab043,pmab044,pmab045,pmab046,pmab047,pmab048,pmab049,pmab050,pmab051,pmab052,pmab071,pmab072,pmab073,pmab060,pmab061,pmab066,pmab062,pmab067,pmab063,pmab068,pmab064,pmab069,pmab065,pmab070,pmab002,pmab003,pmab004,pmab005,pmab006,pmab007,pmab008,pmab009,pmab019,pmab010,pmab020,pmab011,pmab012,pmab013,pmab014,pmab015,pmab016,pmab017,pmab018,pmabownid,pmabowndp,pmabcrtid,pmabcrtdt,pmabcrtdp,pmabmodid,pmabmoddt
         INTO g_pmab_m.pmab001,g_pmab_m.pmab080,g_pmab_m.pmab081,g_pmab_m.pmab082,g_pmab_m.pmab083,g_pmab_m.pmab084,g_pmab_m.pmab103,g_pmab_m.pmab104,g_pmab_m.pmab085,g_pmab_m.pmab087,g_pmab_m.pmab088,g_pmab_m.pmab089,g_pmab_m.pmab090,g_pmab_m.pmab091,g_pmab_m.pmab092,g_pmab_m.pmab093,g_pmab_m.pmab094,g_pmab_m.pmab095,g_pmab_m.pmab096,g_pmab_m.pmab097,g_pmab_m.pmab098,g_pmab_m.pmab099,g_pmab_m.pmab100,g_pmab_m.pmab101,g_pmab_m.pmab102,g_pmab_m.pmab030,g_pmab_m.pmab031,g_pmab_m.pmab032,g_pmab_m.pmab033,g_pmab_m.pmab034,g_pmab_m.pmab053,g_pmab_m.pmab054,g_pmab_m.pmab035,g_pmab_m.pmab037,g_pmab_m.pmab038,g_pmab_m.pmab039,g_pmab_m.pmab040,g_pmab_m.pmab041,g_pmab_m.pmab042,g_pmab_m.pmab043,g_pmab_m.pmab044,g_pmab_m.pmab045,g_pmab_m.pmab046,g_pmab_m.pmab047,g_pmab_m.pmab048,g_pmab_m.pmab049,g_pmab_m.pmab050,g_pmab_m.pmab051,g_pmab_m.pmab052,g_pmab_m.pmab071,g_pmab_m.pmab072,g_pmab_m.pmab073,g_pmab_m.pmab060,g_pmab_m.pmab061,g_pmab_m.pmab066,g_pmab_m.pmab062,g_pmab_m.pmab067,g_pmab_m.pmab063,g_pmab_m.pmab068,g_pmab_m.pmab064,g_pmab_m.pmab069,g_pmab_m.pmab065,g_pmab_m.pmab070,g_pmab_m.pmab002,g_pmab_m.pmab003,g_pmab_m.pmab004,g_pmab_m.pmab005,g_pmab_m.pmab006,g_pmab_m.pmab007,g_pmab_m.pmab008,g_pmab_m.pmab009,g_pmab_m.pmab019,g_pmab_m.pmab010,g_pmab_m.pmab020,g_pmab_m.pmab011,g_pmab_m.pmab012,g_pmab_m.pmab013,g_pmab_m.pmab014,g_pmab_m.pmab015,g_pmab_m.pmab016,g_pmab_m.pmab017,g_pmab_m.pmab018,g_pmab_m.pmabownid,g_pmab_m.pmabowndp,g_pmab_m.pmabcrtid,g_pmab_m.pmabcrtdt,g_pmab_m.pmabcrtdp,g_pmab_m.pmabmodid,g_pmab_m.pmabmoddt
       FROM pmab_t
       WHERE pmabent = g_enterprise AND pmabsite = 'ALL' AND pmab001 = g_pmab_m.pmab001
        
       CALL apmm101_show() 
END FUNCTION
#+
PRIVATE FUNCTION apmm101_set_no_required()
      IF g_pmab_m.pmab002 NOT MATCHES '[23]' THEN
         CALL cl_set_comp_required("pmab004,pmab005,pmab006",FALSE)
      END IF
END FUNCTION
#+
PRIVATE FUNCTION apmm101_set_required()
      IF g_pmab_m.pmab002 MATCHES '[23]' THEN
         CALL cl_set_comp_required("pmab004,pmab005,pmab006",TRUE)
      END IF
END FUNCTION
#+
PRIVATE FUNCTION apmm101_pmab105_ref(p_pmab105)
DEFINE p_pmab105      LIKE pmab_t.pmab105
DEFINE r_pmab105_desc LIKE oocql_t.oocql004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmab105
       CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='3111' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmab105_desc = g_rtn_fields[1]
       RETURN r_pmab105_desc
    
END FUNCTION
#+
PRIVATE FUNCTION apmm101_pmab055_ref(p_pmab055)
DEFINE p_pmab055      LIKE pmab_t.pmab055
DEFINE r_pmab055_desc LIKE oocql_t.oocql004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmab055
       CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='3211' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmab055_desc = g_rtn_fields[1]
       RETURN r_pmab055_desc
    
END FUNCTION
#+
PRIVATE FUNCTION apmm101_pmab084_ref(p_pmab084)
DEFINE p_pmab084      LIKE pmab_t.pmab084
DEFINE l_ooef019      LIKE ooef_t.ooef019
DEFINE r_pmab084_desc LIKE oodbl_t.oodbl004

       LET l_ooef019 = ''
       IF g_site = 'ALL' THEN 
          SELECT ooef019 INTO l_ooef019 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site_t
       ELSE
          SELECT ooef019 INTO l_ooef019 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
       END IF
       
       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmab084
       CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl001='"||l_ooef019||"' AND oodbl002=? AND oodbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmab084_desc = g_rtn_fields[1]
       RETURN r_pmab084_desc
    
END FUNCTION
#+
PRIVATE FUNCTION apmm101_pmab084_chk(p_pmab084)
DEFINE p_pmab084  LIKE pmab_t.pmab084
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
      LET g_chkparam.arg2 = p_pmab084

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
#輸入的值必須存在[T:交易對象允許收付款條件檔].[C:交易條件編號]，且[C:狀態] =有效
PRIVATE FUNCTION apmm101_pmab087_chk(p_pmab087,p_pmad003)
DEFINE p_pmab087   LIKE pmab_t.pmab087
DEFINE p_pmad003   LIKE pmad_t.pmad003
DEFINE r_success   LIKE type_t.num5

      LET r_success = TRUE
      
      IF NOT ap_chk_isExist(p_pmab087,"SELECT COUNT(*) FROM pmad_t WHERE pmadent = '" ||g_enterprise||"' AND pmad001='"||g_pmab_m.pmab001||"' AND pmad002=? AND pmad003='"||p_pmad003||"' ","apm-00191",1 ) THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
      #IF NOT ap_chk_isExist(p_pmab087,"SELECT COUNT(*) FROM pmad_t WHERE pmadent = '" ||g_enterprise||"' AND pmad001='"||g_pmab_m.pmab001||"' AND pmad002=?  AND pmad003='"||p_pmad003||"' AND pmadstus = 'Y' ","apm-00192",1 ) THEN        #160318-00005#34
      IF NOT ap_chk_isExist(p_pmab087,"SELECT COUNT(*) FROM pmad_t WHERE pmadent = '" ||g_enterprise||"' AND pmad001='"||g_pmab_m.pmab001||"' AND pmad002=?  AND pmad003='"||p_pmad003||"' AND pmadstus = 'Y' ","sub-01302",'apmm100' ) THEN #160318-00005#34
         LET r_success = FALSE
         RETURN r_success
      END IF
      RETURN r_success
      
END FUNCTION

PRIVATE FUNCTION apmm101_pmab054_chk(p_pmab054)
DEFINE p_pmab054   LIKE pmab_t.pmab054
DEFINE r_success   LIKE type_t.num5

      LET r_success = TRUE
      
      IF NOT ap_chk_isExist(p_pmab054,"SELECT COUNT(*) FROM pmam_t WHERE pmament = '" ||g_enterprise||"' AND pmam001=?  ","apm-00209",1 ) THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
      #IF NOT ap_chk_isExist(p_pmab054,"SELECT COUNT(*) FROM pmam_t WHERE pmament = '" ||g_enterprise||"' AND pmam001=? AND pmamstus = 'Y' ","apm-00210",1 ) THEN           #160318-00005#34
       IF NOT ap_chk_isExist(p_pmab054,"SELECT COUNT(*) FROM pmam_t WHERE pmament = '" ||g_enterprise||"' AND pmam001=? AND pmamstus = 'Y' ","sub-01302",'apmi130' ) THEN   #160318-00005#34
         LET r_success = FALSE
         RETURN r_success
      END IF
      RETURN r_success
      
END FUNCTION
#+
PRIVATE FUNCTION apmm101_pmab087_ref(p_pmab087)
DEFINE p_pmab087      LIKE pmab_t.pmab087
DEFINE r_pmab087_desc LIKE ooibl_t.ooibl004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmab087
       CALL ap_ref_array2(g_ref_fields,"SELECT ooibl004 FROM ooibl_t WHERE ooiblent='"||g_enterprise||"' AND ooibl002=? AND ooibl003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmab087_desc = g_rtn_fields[1]
       RETURN r_pmab087_desc
    
END FUNCTION

PRIVATE FUNCTION apmm101_pmab104_ref(p_pmab104)
DEFINE p_pmab104      LIKE pmab_t.pmab104
DEFINE r_pmab104_desc LIKE xmahl_t.xmahl003

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmab104
       CALL ap_ref_array2(g_ref_fields,"SELECT xmahl003 FROM xmahl_t WHERE xmahlent='"||g_enterprise||"' AND xmahl001=? AND xmahl002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmab104_desc = g_rtn_fields[1]
       RETURN r_pmab104_desc
    
END FUNCTION

PRIVATE FUNCTION apmm101_pmab106_ref(p_pmab106)
DEFINE p_pmab106      LIKE pmab_t.pmab106
DEFINE r_isacl004     LIKE isacl_t.isacl004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmab106
       CALL ap_ref_array2(g_ref_fields,"SELECT isacl004 FROM isacl_t WHERE isaclent='"||g_enterprise||"' AND isacl001='"||g_ooef019||"' AND isacl002=? AND isacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_isacl004 = '', g_rtn_fields[1] , ''
       RETURN r_isacl004

END FUNCTION

PRIVATE FUNCTION apmm101_pmab088_ref(p_pmab088)
DEFINE p_pmab088      LIKE pmab_t.pmab088
DEFINE r_oocql004     LIKE oocql_t.oocql004

         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = p_pmab088
         #160621-00003#3 20160627 modify by beckxie---S
         #CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='275' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         CALL ap_ref_array2(g_ref_fields,"SELECT oojdl003 FROM oojdl_t WHERE oojdlent='"||g_enterprise||"' AND oojdl001=? AND oojdl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         #160621-00003#3 20160627 modify by beckxie---E
         LET r_oocql004 = '', g_rtn_fields[1] , ''
         RETURN r_oocql004

END FUNCTION

PRIVATE FUNCTION apmm101_pmab054_ref(p_pmab054)
DEFINE p_pmab054      LIKE pmab_t.pmab054
DEFINE r_pmab054_desc LIKE pmaml_t.pmaml003

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmab054
       CALL ap_ref_array2(g_ref_fields,"SELECT pmaml003 FROM pmaml_t WHERE pmamlent='"||g_enterprise||"' AND pmaml001=? AND pmaml002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmab054_desc = g_rtn_fields[1]
       RETURN r_pmab054_desc
    
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apmm101_pmab004_ref(p_pmab004)
#                  RETURNING r_pmbk002
# Input parameter: p_pmab004
# Return code....: r_pmbk002
# Date & Author..: 2014/08/17 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION apmm101_pmab004_ref(p_pmab004)
   DEFINE p_pmab004     LIKE pmab_t.pmab004
   DEFINE r_pmbk002     LIKE pmbk_t.pmbk002

   LET r_pmbk002 = ''
   IF g_argv[01] = '1' THEN
      SELECT pmbk002 INTO r_pmbk002 FROM pmbk_t
       WHERE pmbkent = g_enterprise
         AND pmbksite = g_site_t
         AND pmbk001 = p_pmab004
   END IF
   IF g_argv[01] = '2' THEN
      SELECT xmajl003 INTO r_pmbk002 FROM xmajl_t
       WHERE xmajlent = g_enterprise
         AND xmajl001 = p_pmab004
         AND xmajl002 = g_dlang
   END IF
   IF g_argv[01] = '3' THEN
      SELECT pmbk002 INTO r_pmbk002 FROM pmbk_t
       WHERE pmbkent = g_enterprise
         AND pmbksite = g_site_t
         AND pmbk001 = p_pmab004
      IF cl_null(r_pmbk002) THEN
         SELECT xmajl003 INTO r_pmbk002 FROM xmajl_t
          WHERE xmajlent = g_enterprise
            AND xmajl001 = p_pmab004
            AND xmajl002 = g_dlang
      END IF
   END IF
   
   RETURN r_pmbk002
   
END FUNCTION

#取得運輸類型
PRIVATE FUNCTION apmm101_get_oocq019(p_pmab090)
DEFINE p_pmab090 LIKE pmab_t.pmab090
DEFINE r_oocq019 LIKE oocq_t.oocq019

   LET r_oocq019 = ''
   SELECT oocq019 INTO r_oocq019
     FROM oocq_t
    WHERE oocqent = g_enterprise
      AND oocq001='263'
      AND oocq002= p_pmab090

   RETURN r_oocq019

END FUNCTION

 
{</section>}
 
