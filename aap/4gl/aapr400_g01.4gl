#該程式未解開Section, 採用最新樣板產出!
{<section id="aapr400_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:13(2016-12-28 10:57:15), PR版次:0013(2016-12-28 11:28:07)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000115
#+ Filename...: aapr400_g01
#+ Description: ...
#+ Creator....: 05016(2014-11-14 18:06:15)
#+ Modifier...: 08732 -SD/PR- 08732
 
{</section>}
 
{<section id="aapr400_g01.global" readonly="Y" >}
#報表 g01 樣板自動產生(Version:13)
#add-point:填寫註解說明 name="global.memo"

#end add-point
#add-point:填寫註解說明 name="global.memo_customerization"

 
IMPORT os
#add-point:增加匯入項目 name="global.import"
#150622-00008#5  2015/07/14 by RayHuang 新增標準樣板(無表格)
#150622-00008#5  2015/07/14 by RayHuang A4直式列印(無表格)
#151028-00011#1  2015/10/25 By Reanna   金額C為正D為負/帳款明細增加發票號碼/業務部門改帳款對象/差異處理&付款明細合併/會計科目多放編號
#151013-00019#11 2015/11/11 By Reanna   第一單身增加原幣金額合計/金額C為負D為正/資料太多筆第一頁會空白/本幣金額合計拿掉幣別
#151117          2015/11/17 By Hans     單頭受款對象 核銷對象 改大寫 單身增加受款人全名 apde041
#160122-00001#3  2016/02/22 By 07673    添加交易账户编号用户权限控管
#160414-00018#15 2016/05/05 By Hans     效能優化
#161227-00040#1  2016/12/28 By 08732    一次性交易對象有值的話，受款對象說明抓取一次性交易對象的說明
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../cfg/top_report.inc"                  #報表使用的global
 
#報表 type 宣告
PRIVATE TYPE sr1_r RECORD
   apda001 LIKE apda_t.apda001, 
   apda003 LIKE apda_t.apda003, 
   apda005 LIKE apda_t.apda005, 
   apda007 LIKE apda_t.apda007, 
   apda008 LIKE apda_t.apda008, 
   apda009 LIKE apda_t.apda009, 
   apda010 LIKE apda_t.apda010, 
   apda014 LIKE apda_t.apda014, 
   apda015 LIKE apda_t.apda015, 
   apda016 LIKE apda_t.apda016, 
   apda018 LIKE apda_t.apda018, 
   apdacomp LIKE apda_t.apdacomp, 
   apdadocdt LIKE apda_t.apdadocdt, 
   apdadocno LIKE apda_t.apdadocno, 
   apdaent LIKE apda_t.apdaent, 
   apdald LIKE apda_t.apdald, 
   apdasite LIKE apda_t.apdasite, 
   apce001 LIKE apce_t.apce001, 
   apce002 LIKE apce_t.apce002, 
   apce003 LIKE apce_t.apce003, 
   apce004 LIKE apce_t.apce004, 
   apce005 LIKE apce_t.apce005, 
   apce015 LIKE apce_t.apce015, 
   apce016 LIKE apce_t.apce016, 
   apce017 LIKE apce_t.apce017, 
   apce018 LIKE apce_t.apce018, 
   apce019 LIKE apce_t.apce019, 
   apce020 LIKE apce_t.apce020, 
   apce022 LIKE apce_t.apce022, 
   apce023 LIKE apce_t.apce023, 
   apce024 LIKE apce_t.apce024, 
   apce031 LIKE apce_t.apce031, 
   apce035 LIKE apce_t.apce035, 
   apce036 LIKE apce_t.apce036, 
   apce038 LIKE apce_t.apce038, 
   apce044 LIKE apce_t.apce044, 
   apce045 LIKE apce_t.apce045, 
   apce046 LIKE apce_t.apce046, 
   apce048 LIKE apce_t.apce048, 
   apce049 LIKE apce_t.apce049, 
   apce051 LIKE apce_t.apce051, 
   apce052 LIKE apce_t.apce052, 
   apce053 LIKE apce_t.apce053, 
   apce054 LIKE apce_t.apce054, 
   apce055 LIKE apce_t.apce055, 
   apce056 LIKE apce_t.apce056, 
   apce057 LIKE apce_t.apce057, 
   apce058 LIKE apce_t.apce058, 
   apce059 LIKE apce_t.apce059, 
   apce060 LIKE apce_t.apce060, 
   apce100 LIKE apce_t.apce100, 
   apce101 LIKE apce_t.apce101, 
   apce109 LIKE apce_t.apce109, 
   apce119 LIKE apce_t.apce119, 
   apce120 LIKE apce_t.apce120, 
   apce121 LIKE apce_t.apce121, 
   apce129 LIKE apce_t.apce129, 
   apce130 LIKE apce_t.apce130, 
   apce131 LIKE apce_t.apce131, 
   apce139 LIKE apce_t.apce139, 
   apcecomp LIKE apce_t.apcecomp, 
   apceorga LIKE apce_t.apceorga, 
   apceseq LIKE apce_t.apceseq, 
   apcesite LIKE apce_t.apcesite, 
   l_apda003_ooag011 LIKE type_t.chr100, 
   l_apdasite_ooefl003 LIKE type_t.chr30, 
   l_apad005_pmaal004 LIKE type_t.chr100, 
   apda004 LIKE apda_t.apda004, 
   l_apda004_pmaal004 LIKE type_t.chr100, 
   apce047 LIKE apce_t.apce047, 
   l_apce002_apce048 LIKE type_t.chr100, 
   apda017 LIKE apda_t.apda017, 
   l_apce003_apce004_apce005 LIKE type_t.chr200, 
   apce025 LIKE apce_t.apce025, 
   l_apce024_apce025 LIKE type_t.chr100, 
   l_apce018_ooefl003 LIKE type_t.chr100, 
   l_apce016_glacl004 LIKE type_t.chr100, 
   l_oobxl003_desc LIKE type_t.chr100, 
   apce010 LIKE apce_t.apce010, 
   l_apce038_desc LIKE type_t.chr100
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING                   #where condition
       END RECORD
DEFINE sr DYNAMIC ARRAY OF sr1_r                   #宣告sr為sr1_t資料結構的動態陣列
DEFINE g_select        STRING
DEFINE g_from          STRING
DEFINE g_where         STRING
DEFINE g_order         STRING
DEFINE g_sql           STRING                         #report_select_prep,REPORT段使用
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
TYPE sr3_r RECORD #子報表05帳款明細幣別/總計
   sum_apce100   LIKE apce_t.apce100,
   sum_apce109   LIKE apce_t.apce109,
   apce100_show  LIKE type_t.chr1
END RECORD

TYPE sr4_r RECORD # 差異調整明細
   apde015        LIKE apde_t.apde015,
   apde002        LIKE apde_t.apde002,
   apde002_desc   LIKE type_t.chr100,
   apde010        LIKE apde_t.apde010,
   apde016        LIKE apde_t.apde016,
   apde016_desc   LIKE type_t.chr100,
   apde014        LIKE apde_t.apde014,
   apde013        LIKE apde_t.apde013,
   apde013_desc   LIKE type_t.chr100,
   apde100        LIKE apde_t.apde100,
   apde101        LIKE apde_t.apde101,
   apde109        LIKE apde_t.apde109,
   apde119        LIKE apde_t.apde119
END RECORD

TYPE sr5_r RECORD   # 差異調整明細/幣別合計
  sum_apde100    LIKE apde_t.apde100,
  sum_apde109    LIKE apde_t.apde109,
  apde100_show   LIKE type_t.chr1,
  apde109_show   LIKE type_t.chr1
END RECORD

TYPE sr6_r RECORD #付款明細
   apde015           LIKE apde_t.apde015,
   apde006           LIKE apde_t.apde006,
   apde006_desc      LIKE type_t.chr100,
   apde041           LIKE apde_t.apde041,
   apde041_desc      LIKE type_t.chr100,
   apde039_apde040   LIKE apde_t.apde039,
   apde008           LIKE apde_t.apde008,
   apde008_desc      LIKE type_t.chr100,
   apde032           LIKE apde_t.apde032,
   apde100           LIKE apde_t.apde100,
   apde101           LIKE apde_t.apde101,
   apde109           LIKE apde_t.apde109,
   apde119           LIKE apde_t.apde119,
   apde010           LIKE apde_t.apde010,
   apde002           LIKE apde_t.apde002, #151028-00011#1
   apde016           LIKE apde_t.apde016, #151028-00011#1
   apde016_desc      LIKE type_t.chr100   #151028-00011#1
END RECORD

TYPE sr7_r RECORD # 付款明細/幣別合計
   sum_apde100    LIKE apde_t.apde100,
   sum_apde109    LIKE apde_t.apde109,
   apde100_show   LIKE type_t.chr1,
   apde109_show   LIKE type_t.chr1
END RECORD

DEFINE g_sql_bank       STRING #160122-00001#3 add
#end add-point
 
{</section>}
 
{<section id="aapr400_g01.main" readonly="Y" >}
PUBLIC FUNCTION aapr400_g01(p_arg1)
DEFINE  p_arg1 STRING                  #tm.wc  where condition
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"

#end add-point
 
   LET tm.wc = p_arg1
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   #160122-00001#3--add--str--
   LET g_sql_bank=NULL
   CALL s_anmi120_get_bank_account_sql(g_user,g_dept) RETURNING g_sub_success,g_sql_bank
   #160122-00001#3--add--end
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "aapr400_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL aapr400_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL aapr400_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL aapr400_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="aapr400_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aapr400_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
      LET g_select = " SELECT apda001,apda003,apda005,apda007,apda008,apda009,apda010,apda014,apda015,apda016,                 ",
                  "        apda018,apdacomp,apdadocdt,apdadocno,apdaent,apdald,apdasite,apdastus,apce001,apce002,apce003,   ",
                  "        apce004,apce005,apce015,apce016,apce017,apce018,apce019,apce020,apce022,apce023,apce024,apce031, ",
                  "        apce035,apce036,apce038,apce044,apce045,apce046,apce048,apce049,apce051,apce052,apce053,apce054, ",
                  "        apce055,apce056,apce057,apce058,apce059,apce060,apce100,apce101,apce109,apce119,apce120,apce121, ",
                  "        apce129,apce130,apce131,apce139,apcecomp,apceorga,apceseq,apcesite,                              ",
                  #帳務人員
                  " CASE WHEN (SELECT ooag011 FROM ooag_t WHERE ooag001 = apda003 AND ooagent = apdaent ) ",
                  " IS NUlL THEN apda003 ELSE ",
                  "          (SELECT apda003||'.'||ooag011 FROM ooag_t WHERE ooag001 = apda003 AND ooagent = apdaent) END, ",
                  #帳務中心
                  " CASE WHEN (SELECT ooefl003 FROM ooefl_t WHERE ooeflent = apdaent AND ooefl001 = apdasite AND ooefl002 ='",g_dlang,"')  ",                
                  " IS NULL THEN apdasite ELSE ",
                  "           (SELECT apdasite||'.'||ooefl003 FROM ooefl_t WHERE ooeflent = apdaent AND ooefl001 = apdasite AND ooefl002 ='",g_dlang,"') END, ",
                  #受款對象
                  " CASE WHEN (SELECT pmaal004 FROM pmaal_t WHERE pmaalent = apdaent AND pmaal001 = apda005 AND pmaal002 = '",g_dlang,"')  ",
                  " IS NULL THEN apda005 ELSE ",
                  "           (SELECT apda005||'.'||pmaal004 FROM pmaal_t WHERE pmaalent = apdaent AND pmaal001 = apda005 AND pmaal002 = '",g_dlang,"') END, ", 
                  #核銷對象
                  " apda004, ",
                  " CASE WHEN (SELECT pmaal004 FROM pmaal_t WHERE pmaalent = apdaent AND pmaal001 = apda004 AND pmaal002 = '",g_dlang,"')  ",
                  " IS NULL THEN apda004 ELSE ",
                  "           (SELECT apda004||'.'||pmaal004 FROM pmaal_t WHERE pmaalent = apdaent AND pmaal001 = apda004 AND pmaal002 = '",g_dlang,"') END, ",
                  " apce047, ",
                  #類別
                  " (SELECT gzcbl004 FROM gzcb_t,gzcbl_t WHERE gzcb001 = '8506' AND gzcb002 =apce002 AND gzcb001 = gzcbl001  AND gzcb002 = gzcbl002 AND gzcbl003 = '",g_dlang,"'    ), ",
                  " apda017 ,",
                  #帳款單號 
                  " CASE WHEN apce004 IS NULL THEN apce003 ELSE (apce003||'-'||apce004||'-'||apce005) END ,apce025, ",
                  #交易單號
                  " CASE WHEN apce025 IS NULL THEN apce024 ELSE (apce024||'-'||apce025) END, ",                  
                  #業務部門
                  " CASE WHEN (SELECT ooefl003 FROM ooefl_t WHERE ooeflent = apdaent AND ooefl001 = apce018 AND ooefl002 ='",g_dlang,"')  ",                
                  " IS NULL THEN apce018 ELSE ",
                  "           (SELECT apce018||'.'||ooefl003 FROM ooefl_t WHERE ooeflent = apdaent AND ooefl001 = apce018 AND ooefl002 ='",g_dlang,"') END,  ",
                  #會計科目
                  " CASE WHEN (SELECT glacl004 FROM glacl_t,glaa_t WHERE glaclent = apceent AND glaclent = glaaent AND glacl001 = glaa004     ", 
                  "               AND glacl002 = apce016 AND glaald = apceld    AND glacl003 ='",g_dlang,"') IS NULL THEN apce016 ELSE        ",
                  "           (SELECT apce016||'.'||glacl004 FROM glacl_t,glaa_t WHERE glaclent = apceent AND glaclent = glaaent              ",
                  "               AND glacl001 = glaa004 AND glacl002 = apce016 AND glaald = apceld  AND glacl003 ='",g_dlang,"' ) END ,      ",
                  " '',apce010, ",
                  #帳款對象
                  " CASE WHEN apce038 = 'EMPL' THEN (SELECT apca057||'.'||ooag011 FROM apca_t,ooag_t WHERE apcaent = ooagent AND apcaent ='",g_enterprise,"' ",
                  "                                     AND apceld = apcald  AND apce003 = apcadocno AND ooag001   = apca057 ) ELSE                            ",
                  "(SELECT apce038||'.'||pmaal004 FROM pmaal_t WHERE pmaalent = apceent AND pmaal001 = apce038 AND pmaal002 = '",g_dlang,"') END             " 
        
#   #end add-point
#   LET g_select = " SELECT apda001,apda003,apda005,apda007,apda008,apda009,apda010,apda014,apda015,apda016, 
#       apda018,apdacomp,apdadocdt,apdadocno,apdaent,apdald,apdasite,apdastus,apce001,apce002,apce003, 
#       apce004,apce005,apce015,apce016,apce017,apce018,apce019,apce020,apce022,apce023,apce024,apce031, 
#       apce035,apce036,apce038,apce044,apce045,apce046,apce048,apce049,apce051,apce052,apce053,apce054, 
#       apce055,apce056,apce057,apce058,apce059,apce060,apce100,apce101,apce109,apce119,apce120,apce121, 
#       apce129,apce130,apce131,apce139,apcecomp,apceorga,apceseq,apcesite,'','','',apda004,'',apce047, 
#       '',apda017,'',apce025,'','','','',apce010,NULL"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_from = " FROM  apda_t  LEFT OUTER JOIN ( SELECT apce_t.* FROM apce_t WHERE apceent = '",g_enterprise,"' ) x  ON apda_t.apdaent 
                       = x.apceent AND apda_t.apdald = x.apceld AND apda_t.apdadocno = x.apcedocno"
#   #end add-point
#    LET g_from = " FROM  apda_t  LEFT OUTER JOIN ( SELECT apce_t.* FROM apce_t  ) x  ON apda_t.apdaent  
#        = x.apceent AND apda_t.apdald = x.apceld AND apda_t.apdadocno = x.apcedocno"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET g_where = " WHERE apdaent = '",g_enterprise,"' AND " ,tm.wc CLIPPED 
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED 
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
    LET g_order = " ORDER BY apdadocno,apceseq"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("apda_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE aapr400_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE aapr400_g01_curs CURSOR FOR aapr400_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="aapr400_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION aapr400_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   apda001 LIKE apda_t.apda001, 
   apda003 LIKE apda_t.apda003, 
   apda005 LIKE apda_t.apda005, 
   apda007 LIKE apda_t.apda007, 
   apda008 LIKE apda_t.apda008, 
   apda009 LIKE apda_t.apda009, 
   apda010 LIKE apda_t.apda010, 
   apda014 LIKE apda_t.apda014, 
   apda015 LIKE apda_t.apda015, 
   apda016 LIKE apda_t.apda016, 
   apda018 LIKE apda_t.apda018, 
   apdacomp LIKE apda_t.apdacomp, 
   apdadocdt LIKE apda_t.apdadocdt, 
   apdadocno LIKE apda_t.apdadocno, 
   apdaent LIKE apda_t.apdaent, 
   apdald LIKE apda_t.apdald, 
   apdasite LIKE apda_t.apdasite, 
   apdastus LIKE apda_t.apdastus, 
   apce001 LIKE apce_t.apce001, 
   apce002 LIKE apce_t.apce002, 
   apce003 LIKE apce_t.apce003, 
   apce004 LIKE apce_t.apce004, 
   apce005 LIKE apce_t.apce005, 
   apce015 LIKE apce_t.apce015, 
   apce016 LIKE apce_t.apce016, 
   apce017 LIKE apce_t.apce017, 
   apce018 LIKE apce_t.apce018, 
   apce019 LIKE apce_t.apce019, 
   apce020 LIKE apce_t.apce020, 
   apce022 LIKE apce_t.apce022, 
   apce023 LIKE apce_t.apce023, 
   apce024 LIKE apce_t.apce024, 
   apce031 LIKE apce_t.apce031, 
   apce035 LIKE apce_t.apce035, 
   apce036 LIKE apce_t.apce036, 
   apce038 LIKE apce_t.apce038, 
   apce044 LIKE apce_t.apce044, 
   apce045 LIKE apce_t.apce045, 
   apce046 LIKE apce_t.apce046, 
   apce048 LIKE apce_t.apce048, 
   apce049 LIKE apce_t.apce049, 
   apce051 LIKE apce_t.apce051, 
   apce052 LIKE apce_t.apce052, 
   apce053 LIKE apce_t.apce053, 
   apce054 LIKE apce_t.apce054, 
   apce055 LIKE apce_t.apce055, 
   apce056 LIKE apce_t.apce056, 
   apce057 LIKE apce_t.apce057, 
   apce058 LIKE apce_t.apce058, 
   apce059 LIKE apce_t.apce059, 
   apce060 LIKE apce_t.apce060, 
   apce100 LIKE apce_t.apce100, 
   apce101 LIKE apce_t.apce101, 
   apce109 LIKE apce_t.apce109, 
   apce119 LIKE apce_t.apce119, 
   apce120 LIKE apce_t.apce120, 
   apce121 LIKE apce_t.apce121, 
   apce129 LIKE apce_t.apce129, 
   apce130 LIKE apce_t.apce130, 
   apce131 LIKE apce_t.apce131, 
   apce139 LIKE apce_t.apce139, 
   apcecomp LIKE apce_t.apcecomp, 
   apceorga LIKE apce_t.apceorga, 
   apceseq LIKE apce_t.apceseq, 
   apcesite LIKE apce_t.apcesite, 
   l_apda003_ooag011 LIKE type_t.chr100, 
   l_apdasite_ooefl003 LIKE type_t.chr30, 
   l_apad005_pmaal004 LIKE type_t.chr100, 
   apda004 LIKE apda_t.apda004, 
   l_apda004_pmaal004 LIKE type_t.chr100, 
   apce047 LIKE apce_t.apce047, 
   l_apce002_apce048 LIKE type_t.chr100, 
   apda017 LIKE apda_t.apda017, 
   l_apce003_apce004_apce005 LIKE type_t.chr200, 
   apce025 LIKE apce_t.apce025, 
   l_apce024_apce025 LIKE type_t.chr100, 
   l_apce018_ooefl003 LIKE type_t.chr100, 
   l_apce016_glacl004 LIKE type_t.chr100, 
   l_oobxl003_desc LIKE type_t.chr100, 
   apce010 LIKE apce_t.apce010, 
   l_apce038_desc LIKE type_t.chr100
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_slip          LIKE type_t.chr100
DEFINE l_apda006       LIKE apda_t.apda006   #一次性交易對象
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
 
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH aapr400_g01_curs INTO sr_s.*
       IF STATUS THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = 'foreach:'
          LET g_errparam.code   = STATUS
          LET g_errparam.popup  = TRUE
          CALL cl_err()       
          LET g_rep_success = 'N'    
          EXIT FOREACH
       END IF
 
       #add-point:ins_data段foreach name="ins_data.foreach"
       #截取单别
       CALL s_aooi200_fin_get_slip(sr_s.apdadocno)RETURNING g_sub_success,l_slip
       IF NOT cl_null(l_slip)THEN
          SELECT oobxl003 INTO sr_s.l_oobxl003_desc
            FROM oobxl_t
           WHERE oobxlent = g_enterprise
             AND oobxl001 = l_slip
             AND oobxl002 = g_dlang
       END IF
       
       #帳務人員
       #IF NOT cl_null(sr_s.apda003) THEN
       #   LET sr_s.l_apda003_ooag011 = sr_s.apda003 CLIPPED,".",s_desc_get_person_desc(sr_s.apda003) CLIPPED
       #END IF
       ##帳務中心
       #IF NOT cl_null(sr_s.apdasite) THEN
       #   LET sr_s.l_apdasite_ooefl003 = sr_s.apdasite CLIPPED,".",s_desc_get_department_desc(sr_s.apdasite) CLIPPED
       #END IF
       ##受款對象
       #IF NOT cl_null(sr_s.apda005) THEN
       #   #LET sr_s.l_apad005_pmaal004 = sr_s.apda005 CLIPPED,".",s_desc_get_trading_partner_abbr_desc(sr_s.apda005) CLIPPED
       #   LET sr_s.l_apad005_pmaal004 = sr_s.apda005 CLIPPED,".",s_desc_get_trading_partner_full_desc(sr_s.apda005) CLIPPED #151117
       #END IF
       ##核銷對象
       #IF NOT cl_null(sr_s.apda004) THEN
       #   #LET sr_s.l_apda004_pmaal004 = sr_s.apda004 CLIPPED,".",s_desc_get_trading_partner_abbr_desc(sr_s.apda004) CLIPPED
       #   LET sr_s.l_apda004_pmaal004 = sr_s.apda004 CLIPPED,".",s_desc_get_trading_partner_full_desc(sr_s.apda004) CLIPPED  #151117   
       #END IF
       
       #類別
       #LET sr_s.l_apce002_apce048 = s_desc_gzcbl004_desc('8506',sr_s.apce002) 
#       IF NOT cl_null(sr_s.apce002) THEN
#          LET sr_s.l_apce002_apce048 = sr_s.apce002 CLIPPED,".",s_desc_gzcbl004_desc('8506',sr_s.apce002) CLIPPED
#       END IF
       #帳款單號      
       #IF NOT cl_null(sr_s.apce004) THEN
       #   LET sr_s.l_apce003_apce004_apce005 = sr_s.apce003||"-"||sr_s.apce004||"-"||sr_s.apce005
       #ELSE
       #   LET sr_s.l_apce003_apce004_apce005 = sr_s.apce003
       #END IF
       ##交易單號
       #IF cl_null(sr_s.apce025) THEN 
       #   LET sr_s.l_apce024_apce025 = sr_s.apce024||"-"||sr_s.apce025
       #ELSE
       #   LET sr_s.l_apce024_apce025 = sr_s.apce024
       #END IF
       
       #業務部門
       #LET sr_s.l_apce018_ooefl003 = s_desc_get_department_desc(sr_s.apce018 )
#       IF NOT cl_null(sr_s.apce018) THEN
#          LET sr_s.l_apce018_ooefl003 = sr_s.apce018 CLIPPED,".",s_desc_get_department_desc(sr_s.apce018 ) CLIPPED
#       END IF

       #151028-00011#1 add ------
       #帳款對象
      # IF NOT cl_null(sr_s.apce038) THEN
      #    IF sr_s.apce038 = "EMPL" THEN
      #       #如果是員工就要改抓交易對象
      #       SELECT apca057 INTO sr_s.apce038
      #         FROM apca_t
      #        WHERE apcaent = g_enterprise
      #          AND apcadocno = sr_s.apce003
      #       IF NOT cl_null(sr_s.apce038) THEN
      #          LET sr_s.l_apce038_desc = sr_s.apce038 CLIPPED,".",s_desc_get_person_desc(sr_s.apce038) CLIPPED
      #       END IF
      #    ELSE
      #       LET sr_s.l_apce038_desc = sr_s.apce038 CLIPPED,".",s_desc_get_trading_partner_abbr_desc(sr_s.apce038) CLIPPED
      #    END IF
      # END IF
       #151028-00011#1 add end---

       #會計科目
       #LET sr_s.l_apce016_glacl004 = s_desc_get_account_desc(sr_s.apdald,sr_s.apce016) #150828-00001#6 mark
       #150828-00001#6 remark ------
       #IF NOT cl_null(sr_s.apce016) THEN
       #   LET sr_s.l_apce016_glacl004 = sr_s.apce016 CLIPPED,".",s_desc_get_account_desc(sr_s.apdald,sr_s.apce016) CLIPPED
       #END IF
       ##150828-00001#6 remark end---
       IF sr_s.apce015 ='C' THEN
          LET sr_s.apce109 = sr_s.apce109 * -1 
          LET sr_s.apce119 = sr_s.apce119 * -1
       END IF
       
       #161227-00040#1   add---s
       SELECT apda006 INTO l_apda006
         FROM apda_t
        WHERE apdaent = g_enterprise
          AND apdald = sr_s.apdald
          AND apdadocno = sr_s.apdadocno
          
       IF NOT cl_null(l_apda006) THEN
          CALL s_axrt300_xrca_ref('xrca057',l_apda006,'','') RETURNING g_sub_success,sr_s.l_apad005_pmaal004
          LET sr_s.l_apad005_pmaal004 = sr_s.apda005 CLIPPED,".",sr_s.l_apad005_pmaal004
       END IF
       #161227-00040#1   add---e
      
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].apda001 = sr_s.apda001
       LET sr[l_cnt].apda003 = sr_s.apda003
       LET sr[l_cnt].apda005 = sr_s.apda005
       LET sr[l_cnt].apda007 = sr_s.apda007
       LET sr[l_cnt].apda008 = sr_s.apda008
       LET sr[l_cnt].apda009 = sr_s.apda009
       LET sr[l_cnt].apda010 = sr_s.apda010
       LET sr[l_cnt].apda014 = sr_s.apda014
       LET sr[l_cnt].apda015 = sr_s.apda015
       LET sr[l_cnt].apda016 = sr_s.apda016
       LET sr[l_cnt].apda018 = sr_s.apda018
       LET sr[l_cnt].apdacomp = sr_s.apdacomp
       LET sr[l_cnt].apdadocdt = sr_s.apdadocdt
       LET sr[l_cnt].apdadocno = sr_s.apdadocno
       LET sr[l_cnt].apdaent = sr_s.apdaent
       LET sr[l_cnt].apdald = sr_s.apdald
       LET sr[l_cnt].apdasite = sr_s.apdasite
       LET sr[l_cnt].apce001 = sr_s.apce001
       LET sr[l_cnt].apce002 = sr_s.apce002
       LET sr[l_cnt].apce003 = sr_s.apce003
       LET sr[l_cnt].apce004 = sr_s.apce004
       LET sr[l_cnt].apce005 = sr_s.apce005
       LET sr[l_cnt].apce015 = sr_s.apce015
       LET sr[l_cnt].apce016 = sr_s.apce016
       LET sr[l_cnt].apce017 = sr_s.apce017
       LET sr[l_cnt].apce018 = sr_s.apce018
       LET sr[l_cnt].apce019 = sr_s.apce019
       LET sr[l_cnt].apce020 = sr_s.apce020
       LET sr[l_cnt].apce022 = sr_s.apce022
       LET sr[l_cnt].apce023 = sr_s.apce023
       LET sr[l_cnt].apce024 = sr_s.apce024
       LET sr[l_cnt].apce031 = sr_s.apce031
       LET sr[l_cnt].apce035 = sr_s.apce035
       LET sr[l_cnt].apce036 = sr_s.apce036
       LET sr[l_cnt].apce038 = sr_s.apce038
       LET sr[l_cnt].apce044 = sr_s.apce044
       LET sr[l_cnt].apce045 = sr_s.apce045
       LET sr[l_cnt].apce046 = sr_s.apce046
       LET sr[l_cnt].apce048 = sr_s.apce048
       LET sr[l_cnt].apce049 = sr_s.apce049
       LET sr[l_cnt].apce051 = sr_s.apce051
       LET sr[l_cnt].apce052 = sr_s.apce052
       LET sr[l_cnt].apce053 = sr_s.apce053
       LET sr[l_cnt].apce054 = sr_s.apce054
       LET sr[l_cnt].apce055 = sr_s.apce055
       LET sr[l_cnt].apce056 = sr_s.apce056
       LET sr[l_cnt].apce057 = sr_s.apce057
       LET sr[l_cnt].apce058 = sr_s.apce058
       LET sr[l_cnt].apce059 = sr_s.apce059
       LET sr[l_cnt].apce060 = sr_s.apce060
       LET sr[l_cnt].apce100 = sr_s.apce100
       LET sr[l_cnt].apce101 = sr_s.apce101
       LET sr[l_cnt].apce109 = sr_s.apce109
       LET sr[l_cnt].apce119 = sr_s.apce119
       LET sr[l_cnt].apce120 = sr_s.apce120
       LET sr[l_cnt].apce121 = sr_s.apce121
       LET sr[l_cnt].apce129 = sr_s.apce129
       LET sr[l_cnt].apce130 = sr_s.apce130
       LET sr[l_cnt].apce131 = sr_s.apce131
       LET sr[l_cnt].apce139 = sr_s.apce139
       LET sr[l_cnt].apcecomp = sr_s.apcecomp
       LET sr[l_cnt].apceorga = sr_s.apceorga
       LET sr[l_cnt].apceseq = sr_s.apceseq
       LET sr[l_cnt].apcesite = sr_s.apcesite
       LET sr[l_cnt].l_apda003_ooag011 = sr_s.l_apda003_ooag011
       LET sr[l_cnt].l_apdasite_ooefl003 = sr_s.l_apdasite_ooefl003
       LET sr[l_cnt].l_apad005_pmaal004 = sr_s.l_apad005_pmaal004
       LET sr[l_cnt].apda004 = sr_s.apda004
       LET sr[l_cnt].l_apda004_pmaal004 = sr_s.l_apda004_pmaal004
       LET sr[l_cnt].apce047 = sr_s.apce047
       LET sr[l_cnt].l_apce002_apce048 = sr_s.l_apce002_apce048
       LET sr[l_cnt].apda017 = sr_s.apda017
       LET sr[l_cnt].l_apce003_apce004_apce005 = sr_s.l_apce003_apce004_apce005
       LET sr[l_cnt].apce025 = sr_s.apce025
       LET sr[l_cnt].l_apce024_apce025 = sr_s.l_apce024_apce025
       LET sr[l_cnt].l_apce018_ooefl003 = sr_s.l_apce018_ooefl003
       LET sr[l_cnt].l_apce016_glacl004 = sr_s.l_apce016_glacl004
       LET sr[l_cnt].l_oobxl003_desc = sr_s.l_oobxl003_desc
       LET sr[l_cnt].apce010 = sr_s.apce010
       LET sr[l_cnt].l_apce038_desc = sr_s.l_apce038_desc
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
        
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    LET g_sql = " SELECT apce100,(SUM(CASE apce015 WHEN 'C' THEN apce109*-1 ELSE 0 END) + SUM(CASE apce015 WHEN 'D' THEN apce109 ELSE 0 END)) ",
                "   FROM apce_t                          ",
                "  WHERE apcedocno = ? AND apceld    = ? ",
                "    AND apceent   = '",g_enterprise,"'  ",
                "    GROUP BY apce100                    ",
                "    ORDER BY apce100                    "                       
    PREPARE aapr400_g01_reppre05 FROM g_sql
    DECLARE aapr400_g01_repcur05 CURSOR FOR aapr400_g01_reppre05
    LET g_sql = " SELECT COUNT(*) FROM (",g_sql,")"
    PREPARE aapr400_g01_subrep05_cnt_pre FROM g_sql     
    #差異調整明細
    LET g_sql =  " SELECT apde015,                          ",
                  #沖銷類別
                 "  apde002,(SELECT gzcbl004 FROM gzcb_t,gzcbl_t                                  ",
                 "            WHERE gzcb001 = '8506' AND gzcb002 =apde002 AND gzcb001 = gzcbl001  ", 
                 "              AND gzcb002 = gzcbl002 AND gzcbl003 = '",g_dlang,"'    ),         ",
                 "  apde010,apde016, ",
                 #會計科目
                 " CASE WHEN (SELECT glacl004 FROM glacl_t,glaa_t WHERE glaclent = apdeent AND glaclent = glaaent AND glacl001 = glaa004        ", 
                 "               AND glacl002 = apde016 AND glaald = apdeld AND glacl003 ='",g_dlang,"')                              ",
                 " IS NULL THEN apde016 ELSE    ",
                 "           (SELECT glacl004 FROM glacl_t,glaa_t WHERE glaclent = apdeent AND glaclent = glaaent AND glacl001 = glaa004        ",
                 "               AND glacl002 = apde016 AND glaald = apdeld AND glacl003 ='",g_dlang,"' ) END  ",                        
                 "  apde014,apde013, ",
                 #供應商
                 " CASE WHEN (SELECT pmaal004 FROM pmaal_t WHERE pmaalent = apdeent AND pmaal001 = apde013 AND pmaal002 = '",g_dlang,"')  ",
                 " IS NULL THEN apde013 ELSE ",
                 "           (SELECT pmaal004 FROM pmaal_t WHERE pmaalent = apdeent AND pmaal001 = apde013 AND pmaal002 = '",g_dlang,"') END, ",      
                 "        apde100,apde101, ",
                 "  CASE WHEN apde015 = 'C' THEN apde109 * - 1 ELSE apde109 END, ",
                 "  CASE WHEN apde015 = 'C' THEN apde119 * - 1 ELSE apde119 END  ",
                 "   FROM apde_t                                          ",
                 "  WHERE apdedocno =  ?                                  ",
                 "    AND apdeent   = '",g_enterprise,"'                  ",
                 "    AND apdeld    = ?                                   ",
                 "    AND apde002  <> '10'                                ",
                 "    ORDER BY apdeseq                                    "             
    PREPARE aapr400_g01_reppre06 FROM g_sql
    DECLARE aapr400_g01_repcur06 CURSOR FOR aapr400_g01_reppre06                      
    LET g_sql = " SELECT COUNT(*) FROM  ",
                "  (SELECT apde015,apde002,apde010,apde016,apde014,apde013,apde100,apde101,apde109,apde119 ", 
                "     FROM apde_t                                          ",                          
                "    WHERE apdedocno = ?                                   ",
                "      AND apdeent   = '",g_enterprise,"'                  ",
                "      AND apdeld    = ?                                   ",
                "      AND apde002  <> '10'  )                             "   
    PREPARE aapr400_g01_subrep06_cnt_pre FROM g_sql                       
    
    #差異處理及匯差明細/幣別合計                  
    LET g_sql = " SELECT apde100,(SUM(CASE apde015 WHEN 'C' THEN apde109*-1 ELSE 0 END) + SUM(CASE apde015 WHEN 'D' THEN apde109 ELSE 0 END)) ",
                "   FROM apde_t                          ",
                "  WHERE apdedocno = ?                   ",
                "    AND apdeent   = '",g_enterprise,"'  ",
                "    AND apdeld    = ?                   ",
                "    AND apde002  <> '10'                ",
                "    GROUP BY apde100                    ",
                "    ORDER BY apde100                    "
    PREPARE aapr400_g01_reppre07 FROM g_sql             
    DECLARE aapr400_g01_repcur07 CURSOR FOR  aapr400_g01_reppre07
    
    LET g_sql =  " SELECT apde015,apde006, ",
                   #沖銷類別
                   "  CASE WHEN apde002 <> '10' THEN (SELECT gzcbl004 FROM gzcb_t,gzcbl_t                                   ",
                   "                                   WHERE gzcb001 = '8506' AND gzcb002 = apde002 AND gzcb001 = gzcbl001  ", 
                   "                                     AND gzcb002 = gzcbl002 AND gzcbl003 = '",g_dlang,"'    )           ",
                   "                            ELSE (SELECT gzcbl004 FROM gzcb_t,gzcbl_t                                   ",
                   "                                   WHERE gzcb001 = '8310' AND gzcb002 = apde006 AND gzcb001 = gzcbl001  ", 
                   "                                     AND gzcb002 = gzcbl002 AND gzcbl003 = '",g_dlang,"'    ) END,      ",
                   #受款人
                   " apde041,apde041,(CASE WHEN apde040 IS NOT NULL THEN apde039||'-'||apde040 ELSE apde039 END),           ",
                   #支付帳戶
                   " apde008,CASE WHEN (SELECT nmaal003  ", 
                   "                     FROM nmas_t LEFT OUTER JOIN nmaal_t ON nmasent = nmaalent AND nmas001 = nmaal001 AND nmaal002 = '",g_dlang,"' ", 
                   "                    WHERE nmasent = '",g_enterprise,"' AND nmas002 = apde008)                                                      ",
                   "         IS NULL THEN apde008 ELSE  ",
                   "                   (SELECT nmaal003 ", 
                   "                      FROM nmas_t LEFT OUTER JOIN nmaal_t ON nmasent = nmaalent AND nmas001 = nmaal001 AND nmaal002 = '",g_dlang,"' ",
                   "                      WHERE nmasent = '",g_enterprise,"' AND nmas002 = apde008) END,                                                ",
                   " apde032,apde100,apde101, ",
                   " CASE WHEN apde015 = 'D' THEN apde109 * - 1 ELSE apde109 END,CASE WHEN apde015 = 'D' THEN apde119 * - 1 ELSE apde119 END,  ",                                                
                   " apde010,apde002,apde016, ",
                   #會計科目
                   " CASE WHEN (SELECT glacl004 FROM glacl_t,glaa_t WHERE glaclent = glaaent AND glaaent = '",g_enterprise,"'      ",
                   "               AND glacl001 = glaa004 AND glacl002 = apde016 AND glaald = apdeld  AND glacl003 ='",g_dlang,"') ",
                   " IS NULL THEN apde016 ELSE          ",
                   "           (SELECT apde016||'.'||glacl004 FROM glacl_t,glaa_t WHERE glaclent = glaaent AND glaaent = '",g_enterprise,"'    ",
                   "               AND glacl001 = glaa004 AND glacl002 = apde016 AND glaald = apdeld  AND glacl003 ='",g_dlang,"' ) END        ",
                   "   FROM apde_t",
                   "  WHERE apdedocno = ?                     ",
                   "    AND apdeent = '",g_enterprise,"'      ",
                   "    AND apdeld =  ?                       ",
                   "    AND (apde008 IN (",g_sql_bank,")  OR TRIM(apde008) IS NULL)",              
                   "    ORDER BY apdeseq"        
    PREPARE aapr400_g01_reppre08 FROM g_sql                      
    DECLARE aapr400_g01_repcur08 CURSOR FOR aapr400_g01_reppre08
     
    LET g_sql =   " SELECT COUNT(*) FROM  ",
                  "  (SELECT apdedocno,apdeld FROM apde_t ",     
                  "   WHERE apdedocno = ?                ",
                  "     AND apdeent   = '",g_enterprise,"'                   ",
                  "     AND (apde008 IN (",g_sql_bank,")  OR TRIM(apde008) IS NULL)",
                  "     AND apdeld    = ?  )                  "                                    
    
    PREPARE aapr400_g01_subrep08_cnt_pre FROM g_sql
    #付款明細/幣別合計
    LET g_sql = " SELECT apde100,(SUM(CASE apde015 WHEN 'D' THEN apde109*-1 ELSE 0 END) + SUM(CASE apde015 WHEN 'C' THEN apde109 ELSE 0 END))",
                "   FROM apde_t",
                "  WHERE apdedocno = ?   ",
                "    AND apdeent = '",g_enterprise,"'",
                "    AND apdeld  = ?     ",
                "    AND (apde008 IN (",g_sql_bank,")  OR TRIM(apde008) IS NULL)",                                                             
                "    GROUP BY apde100",
                "    ORDER BY apde100"
    PREPARE aapr400_g01_reppre09 FROM g_sql
    DECLARE aapr400_g01_repcur09 CURSOR FOR aapr400_g01_reppre09
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aapr400_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION aapr400_g01_rep_data()
   DEFINE HANDLER         om.SaxDocumentHandler
   DEFINE l_i             INTEGER
 
    #判斷是否有報表資料，若回彈出訊息視窗
    IF sr.getLength() = 0 THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = "adz-00285"
       LET g_errparam.extend = NULL
       LET g_errparam.popup  = FALSE
       LET g_errparam.replace[1] = ''
       CALL cl_err()  
       RETURN 
    END IF
    WHILE TRUE   
       #add-point:rep_data段印前 name="rep_data.before"
      
       #end add-point     
       LET handler = cl_gr_handler()
       IF handler IS NOT NULL THEN
          START REPORT aapr400_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT aapr400_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT aapr400_g01_rep
       END IF
       #add-point:rep_data段印完 name="rep_data.after"
       
       #end add-point       
       IF g_rep_flag = TRUE THEN
          LET g_rep_flag = FALSE
          EXIT WHILE
       END IF
    END WHILE
    #add-point:rep_data段離開while印完前 name="rep_data.end.before"
    
    #end add-point
    CALL cl_gr_close_report()
    #add-point:rep_data段離開while印完後 name="rep_data.end.after"
    
    #end add-point    
END FUNCTION
 
{</section>}
 
{<section id="aapr400_g01.rep" readonly="Y" >}
PRIVATE REPORT aapr400_g01_rep(sr1)
DEFINE sr1 sr1_r
DEFINE sr2 sr2_r
DEFINE l_subrep01_show  LIKE type_t.chr1,
       l_subrep02_show  LIKE type_t.chr1,
       l_subrep03_show  LIKE type_t.chr1,
       l_subrep04_show  LIKE type_t.chr1
DEFINE l_cnt           LIKE type_t.num10
DEFINE l_sub_sql       STRING
#add-point:rep段define  (客製用) name="rep.define_customerization"

#end add-point
#add-point:rep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="rep.define"
DEFINE sr3       sr3_r
DEFINE sr4       sr4_r
DEFINE sr5       sr5_r
DEFINE sr6       sr6_r
DEFINE sr7       sr7_r
DEFINE l_sql_cnt   STRING
DEFINE l_count            LIKE type_t.num5
DEFINE l_apce_show        LIKE type_t.chr1
DEFINE l_subrep05_show    LIKE type_t.chr5
DEFINE l_subrep06_show    LIKE type_t.chr5 #差異調整明細：
DEFINE l_subrep08_show    LIKE type_t.chr5 #付款明細
DEFINE l_apda017_show     LIKE type_t.chr1 #papda017 備註 單頭
DEFINE l_apce109_sum      LIKE apce_t.apce109  #151013-00019#11
DEFINE l_apce119_sum      LIKE apce_t.apce119
DEFINE l_glaa001          LIKE glaa_t.glaa001
DEFINE l_curr_show        LIKE type_t.chr1 #原幣不顯示之flag
DEFINE l_apce010_show     LIKE type_t.chr1
DEFINE l_oobxl003         LIKE oobxl_t.oobxl003  #161104-00049#4 add
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER EXTERNAL BY sr1.apdadocno,sr1.apceseq
    #add-point:rep段ORDER_after name="rep.order.after"
    
    #end add-point
    
    FORMAT
       FIRST PAGE HEADER          
          PRINTX g_user,g_pdate,g_rep_code,g_company,g_ptime,g_user_name,g_date_fmt
          PRINTX tm.*
          PRINTX g_grNumFmt.*
          PRINTX g_rep_wcchp
 
          #讀取beforeGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.apdadocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            #單頭說明
            CALL s_desc_gzcbl004_desc(8507,sr1.apda001) RETURNING g_grPageHeader.title0201
            CALL s_aooi200_fin_get_slip_desc(sr1.apdadocno) RETURNING l_oobxl003 #161104-00049#4 add
            LET g_grPageHeader.title0201 = l_oobxl003                            #161104-00049#4 add
            #end add-point:rep.header 
            LET g_rep_docno = sr1.apdadocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'apdaent=' ,sr1.apdaent,'{+}apdald=' ,sr1.apdald,'{+}apdadocno=' ,sr1.apdadocno         
            CALL cl_gr_init_apr(sr1.apdadocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.apdadocno.before name="rep.b_group.apdadocno.before"
           LET l_apce010_show = ''
           IF cl_null(sr1.apce010) THEN
              LET l_apce010_show = "N"
           ELSE
              LET l_apce010_show = "Y"
           END IF
           PRINTX l_apce010_show
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.apdaent CLIPPED ,"'", " AND  ooff003 = '", sr1.apdadocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aapr400_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE aapr400_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT aapr400_g01_subrep01
           DECLARE aapr400_g01_repcur01 CURSOR FROM g_sql
           FOREACH aapr400_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aapr400_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT aapr400_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT aapr400_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.apdadocno.after name="rep.b_group.apdadocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.apceseq
 
           #add-point:rep.b_group.apceseq.before name="rep.b_group.apceseq.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.apceseq.after name="rep.b_group.apceseq.after"
           
           #end add-point:
 
 
 
 
       ON EVERY ROW
          #add-point:rep.everyrow.before name="rep.everyrow.before"
          
          #end add-point:rep.everyrow.before
 
          #單身前備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub02.before name="rep.sub02.before"
           
           #end add-point:rep.sub02.before
 
           #add-point:rep.sub02.sql name="rep.sub02.sql"
           
           #end add-point:rep.sub02.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='2' AND ooffent = '", 
                sr1.apdaent CLIPPED ,"'", " AND  ooff003 = '", sr1.apdadocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.apceseq CLIPPED ,""
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aapr400_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE aapr400_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT aapr400_g01_subrep02
           DECLARE aapr400_g01_repcur02 CURSOR FROM g_sql
           FOREACH aapr400_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aapr400_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT aapr400_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT aapr400_g01_subrep02
           #add-point:rep.sub02.after name="rep.sub02.after"
           
           #end add-point:rep.sub02.after
 
 
 
          #add-point:rep.everyrow.beforerow name="rep.everyrow.beforerow"
          #單頭備註隱藏
          INITIALIZE l_apda017_show TO NULL
          IF cl_null(sr1.apda017) THEN
             LET l_apda017_show = 'N'
          ELSE 
             LET l_apda017_show = 'Y'
          END IF
          PRINTX l_apda017_show
          
          INITIALIZE l_apce_show TO NULL
          IF cl_null(sr1.apceseq) THEN
             LET l_apce_show = 'N'
          ELSE
             LET l_apce_show = 'Y'
          END IF
            PRINTX l_apce_show
            
          LET l_curr_show = 'N' #樣板二原幣不顯示
          PRINTX l_curr_show
          #end add-point:rep.everyrow.beforerow
            
          PRINTX sr1.*
 
          #add-point:rep.everyrow.afterrow name="rep.everyrow.afterrow"
                      
          #end add-point:rep.everyrow.afterrow
 
          #單身後備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub03.before name="rep.sub03.before"
           
           #end add-point:rep.sub03.before
 
           #add-point:rep.sub03.sql name="rep.sub03.sql"
           
           #end add-point:rep.sub03.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooffent = '", 
                sr1.apdaent CLIPPED ,"'", " AND  ooff003 = '", sr1.apdadocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.apceseq CLIPPED ,""
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aapr400_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE aapr400_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT aapr400_g01_subrep03
           DECLARE aapr400_g01_repcur03 CURSOR FROM g_sql
           FOREACH aapr400_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aapr400_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT aapr400_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT aapr400_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.apdadocno
 
           #add-point:rep.a_group.apdadocno.before name="rep.a_group.apdadocno.before"
           #單身金額合計
           LET l_subrep05_show = 'N'
           LET l_count = 0  
           #160414-00018#15 ---s---     
           #LET g_sql = " SELECT apce100,(SUM(CASE apce015 WHEN 'C' THEN apce109*-1 ELSE 0 END) + SUM(CASE apce015 WHEN 'D' THEN apce109 ELSE 0 END)) ",
           #            "   FROM apce_t                          ",
           #            "  WHERE apcedocno = '",sr1.apdadocno,"' ",
           #            "    AND apceent   = '",sr1.apdaent,"'   ",
           #            "    AND apceld    = '",sr1.apdald,"'    ",
           #            "    GROUP BY apce100                    ",
           #            "    ORDER BY apce100                    "
           #LET l_sql_cnt = " SELECT COUNT(*) FROM (",g_sql,")"
           #PREPARE aapr400_g01_subrep05_cnt_pre FROM l_sql_cnt          
           EXECUTE aapr400_g01_subrep05_cnt_pre INTO l_count USING sr1.apdadocno,sr1.apdald
           #FREE aapr400_g01_subrep05_cnt_pre 
           #160414-00018#15 ---e---                
           IF l_count > 0 THEN 
              LET l_subrep05_show = 'Y' 
           END IF  
           LET l_count  = 1
           START REPORT aapr400_g01_subrep05           
           #DECLARE aapr400_g01_repcur05 CURSOR FROM g_sql
           FOREACH aapr400_g01_repcur05 USING sr1.apdadocno,sr1.apdald INTO sr3.*
              #合計金額只顯示一次     
              IF l_count = 1 THEN LET sr3.apce100_show = 'Y' ELSE LET sr3.apce100_show = 'N' END IF
              OUTPUT TO REPORT aapr400_g01_subrep05(sr3.*)
              LET l_count = l_count + 1              
           END FOREACH                    
           FINISH REPORT aapr400_g01_subrep05
           
           #本幣金額合計
           SELECT glaa001  INTO l_glaa001
             FROM glaa_t
             WHERE glaaent = g_enterprise AND glaald = sr1.apdald           
           LET l_apce109_sum = GROUP SUM(sr1.apce109)    #151013-00019#11
           LET l_apce119_sum = GROUP SUM(sr1.apce119)
          #PRINTX l_apce119_sum,l_glaa001                #151013-00019#11 mark
           PRINTX l_apce109_sum,l_apce119_sum,l_glaa001  #151013-00019#11
           
           #差異調整明細
           LET l_subrep06_show = 'N'    
           LET l_count = 0       
           #160414-00018#15 ---s---
           #LET g_sql =  " SELECT apde015,apde002,'',apde010,apde016,'',apde014,  ",
           #             "        apde013,'',apde100,apde101,apde109,apde119      ",
           #             "   FROM apde_t                                          ",
           #             "  WHERE apdedocno = '",sr1.apdadocno,"'                 ",
           #             "    AND apdeent   = '",sr1.apdaent,"'                   ",
           #             "    AND apdeld    = '",sr1.apdald,"'                    ",
           #             "    AND apde002  <> '10'                                ",
           #             "    ORDER BY apdeseq                                    "                                        
           #LET l_sql_cnt = " SELECT COUNT(*) FROM (",g_sql,")"
           #PREPARE aapr400_g01_subrep06_cnt_pre FROM l_sql_cnt          
           EXECUTE aapr400_g01_subrep06_cnt_pre  USING sr1.apdadocno,sr1.apdald INTO l_count 
           #FREE aapr400_g01_subrep06_cnt_pre          
           #160414-00018#15 ---e---     
           IF l_count > 0 THEN 
              LET l_subrep06_show = 'Y'
           END IF          
           #DECLARE aapr400_g01_repcur06 CURSOR FROM g_sql
           START REPORT aapr400_g01_subrep06
           FOREACH aapr400_g01_repcur06 USING sr1.apdadocno,sr1.apdald INTO sr4.*            
              #沖銷類別
              #LET sr4.apde002_desc = s_desc_gzcbl004_desc('8506',sr4.apde002)  
              #IF NOT cl_null(sr4.apde002) THEN
              #   LET sr4.apde002_desc = sr4.apde002 CLIPPED,".",s_desc_gzcbl004_desc('8506',sr4.apde002) CLIPPED               
              #END IF               
              #會計科目
              #LET sr4.apde016_desc = s_desc_get_account_desc(sr1.apdald,sr4.apde016)
              #IF NOT cl_null(sr4.apde016) THEN
              #   LET sr4.apde016_desc = sr4.apde016 CLIPPED,".",s_desc_get_account_desc(sr1.apdald,sr4.apde016) CLIPPED
              #END IF              
              #供應商
              #LET sr4.apde013_desc = s_desc_get_trading_partner_abbr_desc(sr4.apde013) 
              #IF NOT cl_null(sr4.apde013) THEN
              #   LET sr4.apde013_desc = sr4.apde013 CLIPPED,".",s_desc_get_trading_partner_abbr_desc(sr4.apde013) CLIPPED
              #END IF   
              
              # IF sr4.apde015 = 'C' THEN 
              #    LET sr4.apde109 = sr4.apde109 * -1
              #    LET sr4.apde119 = sr4.apde119 * -1
              # END IF   
              LET l_count = l_count +1
              OUTPUT TO REPORT aapr400_g01_subrep06(sr4.*)
           END FOREACH     
           FINISH REPORT aapr400_g01_subrep06   
          
           #差異處理及匯差明細/幣別合計                  
           #LET g_sql = " SELECT apde100,(SUM(CASE apde015 WHEN 'C' THEN apde109*-1 ELSE 0 END) + SUM(CASE apde015 WHEN 'D' THEN apde109 ELSE 0 END)) ",
           #            "   FROM apde_t                          ",
           #            "  WHERE apdedocno = '",sr1.apdadocno,"' ",
           #            "    AND apdeent   = '",sr1.apdaent,"'   ",
           #            "    AND apdeld    = '",sr1.apdald,"'    ",
           #            "    AND apde002  <> '10'                ",
           #            "    GROUP BY apde100                    ",
           #            "    ORDER BY apde100                    "
           LET l_count = 1
           LET sr5.apde109_show ='N'
           START REPORT aapr400_g01_subrep07
           #DECLARE aapr400_g01_repcur07 CURSOR FROM g_sql
           FOREACH aapr400_g01_repcur07 USING sr1.apdadocno,sr1.apdald INTO sr5.*
              #合計金額只顯示一次
              IF l_count = 1 THEN LET sr5.apde100_show = 'Y' ELSE LET sr5.apde100_show = 'N' END IF
              OUTPUT TO REPORT aapr400_g01_subrep07(sr5.*,sr1.apdadocno,sr1.apdald)
              LET l_count = l_count +1
           END FOREACH
           FINISH REPORT aapr400_g01_subrep07
           
           #付款明細：
           LET l_subrep08_show = 'N'
           LET l_count = 0
           #160414-00018#15 ---s---
           #LET g_sql =  " SELECT apde015,apde006,'',apde041,'',",
           #             "        (CASE WHEN apde040 IS NOT NULL THEN apde039||'-'||apde040 ELSE apde039 END),",
           #             "        apde008,'',apde032,apde100,",
           #            #"        apde101,apde109,apde119,apde010",          #151028-00011#1 mark
           #             "        apde101,apde109,apde119,apde010,apde002,", #151028-00011#1
           #             "        apde016,''",                               #151028-00011#1
           #             "   FROM apde_t",
           #             "  WHERE apdedocno = '",sr1.apdadocno,"'",
           #             "    AND apdeent = '",sr1.apdaent,"'",
           #             "    AND apdeld = '",sr1.apdald,"'",
           #            #"    AND apde002 = '10'", #151028-00011#1 mark
           #            #"    AND (apde008 IN(SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = ",g_enterprise," AND nmll002 = '",g_user,"') OR apde008 IS NULL) " ,#160122-00001#3 -add
           #             "    AND (apde008 IN (",g_sql_bank,")  OR TRIM(apde008) IS NULL)",    #160122-00001#3 -add            
           #             "    ORDER BY apdeseq"          
           #PREPARE aapr400_g01_subrep08_cnt_pre FROM l_sql_cnt
           EXECUTE aapr400_g01_subrep08_cnt_pre INTO l_count USING sr1.apdadocno,sr1.apdald
           #FREE aapr400_g01_subrep08_cnt_pre
           #160414-00018#15 ---e---   
           IF l_count > 0 THEN 
              LET l_subrep08_show = 'Y'  
           END IF
           START REPORT aapr400_g01_subrep08
           #DECLARE aapr400_g01_repcur08 CURSOR FROM g_sql
           FOREACH aapr400_g01_repcur08 USING sr1.apdadocno,sr1.apdald INTO sr6.*
              #160414-00018#15 ---s---
              #沖銷類別
              ##151028-00011#1 add ------
              #IF sr6.apde002 <> '10' THEN
              #   LET sr6.apde006_desc = s_desc_gzcbl004_desc('8506',sr6.apde002)
              #ELSE
              ##151028-00011#1 add end---
              #   LET sr6.apde006_desc = s_desc_gzcbl004_desc('8310',sr6.apde006)
              #END IF #151028-00011#1
              #
              ##151028-00011#1 add ------
              ##會計科目
              #LET sr6.apde016_desc = s_desc_get_account_desc(sr1.apdald,sr6.apde016)
              #IF NOT cl_null(sr6.apde016) THEN
              #   LET sr6.apde016_desc = sr6.apde016 CLIPPED,".",s_desc_get_account_desc(sr1.apdald,sr6.apde016) CLIPPED
              #END IF
              ##151028-00011#1 add end---
              #
#             # IF NOT cl_null(sr6.apde006) THEN
#             #    LET sr6.apde006_desc = sr6.apde006 CLIPPED,".",s_desc_gzcbl004_desc('8310',sr6.apde006) CLIPPED
#             # END IF
              ##受款人
              #LET sr6.apde041_desc = s_desc_get_trading_partner_abbr_desc(sr6.apde041)
#             # IF NOT cl_null(sr6.apde041) THEN
#             #    LET sr6.apde041_desc = sr6.apde041 CLIPPED,".",s_desc_get_trading_partner_abbr_desc(sr6.apde041) CLIPPED
#             # END IF
              ##支付帳戶
              #LET sr6.apde008_desc = s_desc_get_nmas002_desc(sr6.apde008)
#             # IF NOT cl_null(sr6.apde008) THEN
#             #    LET sr6.apde008_desc = sr6.apde008 CLIPPED,".",s_desc_get_nmas002_desc(sr6.apde008) CLIPPED
#             # END IF
              #
             #IF sr6.apde015 = 'C' THEN  #151028-00011#1 mark
              #IF sr6.apde015 = 'D' THEN  #151028-00011#1
              #   LET sr6.apde109 = sr6.apde109 * -1
              #   LET sr6.apde119 = sr6.apde119 * -1
              #END IF
              #160414-00018#15 ---e---
              OUTPUT TO REPORT aapr400_g01_subrep08(sr6.*)
           END FOREACH
           FINISH REPORT aapr400_g01_subrep08
           
           #付款明細/幣別合計
          #LET g_sql = " SELECT apde100,(SUM(CASE apde015 WHEN 'C' THEN apde109*-1 ELSE 0 END) + SUM(CASE apde015 WHEN 'D' THEN apde109 ELSE 0 END))",  #151028-00011#1 mark
          # LET g_sql = " SELECT apde100,(SUM(CASE apde015 WHEN 'D' THEN apde109*-1 ELSE 0 END) + SUM(CASE apde015 WHEN 'D' THEN apde109 ELSE 0 END))",  #151028-00011#1
          # LET g_sql = " SELECT apde100,(SUM(CASE apde015 WHEN 'D' THEN apde109*-1 ELSE 0 END) + SUM(CASE apde015 WHEN 'C' THEN apde109 ELSE 0 END))",  #160414-00018#15 
          #             "   FROM apde_t",
          #             "  WHERE apdedocno = '",sr1.apdadocno,"'",
          #             "    AND apdeent = '",sr1.apdaent,"'",
          #             "    AND apdeld  = '",sr1.apdald,"'",
          #             "    AND (apde008 IN (",g_sql_bank,")  OR TRIM(apde008) IS NULL)",                                                               #160414-00018#15
          #            #"    AND apde002 = '10'",  #151028-00011#1 mark                       
          #             "    GROUP BY apde100",
          #             "    ORDER BY apde100"
           LET l_count = 1
           LET sr7.apde109_show ='N'
           START REPORT aapr400_g01_subrep09
          # DECLARE aapr400_g01_repcur09 CURSOR FROM g_sql
           FOREACH aapr400_g01_repcur09 USING sr1.apdadocno,sr1.apdald  INTO sr7.*
              IF l_count = 1 THEN LET sr7.apde100_show = 'Y' ELSE LET sr7.apde100_show = 'N' END IF
              OUTPUT TO REPORT aapr400_g01_subrep09(sr7.*,sr1.apdadocno,sr1.apdald)
              LET l_count = l_count + 1
           END FOREACH
           FINISH REPORT aapr400_g01_subrep09
           
           PRINTX l_subrep05_show
           LET l_subrep06_show = "N"  #151028-00011#1
           PRINTX l_subrep06_show
           PRINTX l_subrep08_show
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.apdaent CLIPPED ,"'", " AND  ooff003 = '", sr1.apdadocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aapr400_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE aapr400_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT aapr400_g01_subrep04
           DECLARE aapr400_g01_repcur04 CURSOR FROM g_sql
           FOREACH aapr400_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aapr400_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT aapr400_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT aapr400_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.apdadocno.after name="rep.a_group.apdadocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.apceseq
 
           #add-point:rep.a_group.apceseq.before name="rep.a_group.apceseq.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.apceseq.after name="rep.a_group.apceseq.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="aapr400_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT aapr400_g01_subrep01(sr2)
DEFINE  sr2  sr2_r
#add-point:query段define(客製用) name="sub01.define_customerization" 

#end add-point
#add-point:sub01.define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sub01.define" 

#end add-point:sub01.define
 
    #add-point:sub01.order.before name="sub01.order.before" 
    
    #end add-point:sub01.order.before
 
 
 
    FORMAT
 
 
 
       ON EVERY ROW
            #add-point:sub01.everyrow.before name="sub01.everyrow.before" 
                          
            #end add-point:sub01.everyrow.before
 
            PRINTX sr2.*
 
            #add-point:sub01.everyrow.after name="sub01.everyrow.after" 
            
            #end add-point:sub01.everyrow.after
 
 
END REPORT
 
 
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT aapr400_g01_subrep02(sr2)
DEFINE  sr2  sr2_r
#add-point:query段define(客製用) name="sub02.define_customerization" 

#end add-point
#add-point:sub02.define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sub02.define" 

#end add-point:sub02.define
 
    #add-point:sub02.order.before name="sub02.order.before" 
    
    #end add-point:sub02.order.before
 
 
 
    FORMAT
 
 
 
       ON EVERY ROW
            #add-point:sub02.everyrow.before name="sub02.everyrow.before" 
                          
            #end add-point:sub02.everyrow.before
 
            PRINTX sr2.*
 
            #add-point:sub02.everyrow.after name="sub02.everyrow.after" 
            
            #end add-point:sub02.everyrow.after
 
 
END REPORT
 
 
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT aapr400_g01_subrep03(sr2)
DEFINE  sr2  sr2_r
#add-point:query段define(客製用) name="sub03.define_customerization" 

#end add-point
#add-point:sub03.define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sub03.define" 

#end add-point:sub03.define
 
    #add-point:sub03.order.before name="sub03.order.before" 
    
    #end add-point:sub03.order.before
 
 
 
    FORMAT
 
 
 
       ON EVERY ROW
            #add-point:sub03.everyrow.before name="sub03.everyrow.before" 
                          
            #end add-point:sub03.everyrow.before
 
            PRINTX sr2.*
 
            #add-point:sub03.everyrow.after name="sub03.everyrow.after" 
            
            #end add-point:sub03.everyrow.after
 
 
END REPORT
 
 
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT aapr400_g01_subrep04(sr2)
DEFINE  sr2  sr2_r
#add-point:query段define(客製用) name="sub04.define_customerization" 

#end add-point
#add-point:sub04.define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sub04.define" 

#end add-point:sub04.define
 
    #add-point:sub04.order.before name="sub04.order.before" 
    
    #end add-point:sub04.order.before
 
 
 
    FORMAT
 
 
 
       ON EVERY ROW
            #add-point:sub04.everyrow.before name="sub04.everyrow.before" 
                          
            #end add-point:sub04.everyrow.before
 
            PRINTX sr2.*
 
            #add-point:sub04.everyrow.after name="sub04.everyrow.after" 
            
            #end add-point:sub04.everyrow.after
 
 
END REPORT
 
 
 
 
{</section>}
 
{<section id="aapr400_g01.other_function" readonly="Y" >}

 
{</section>}
 
{<section id="aapr400_g01.other_report" readonly="Y" >}

################################################################################
# Descriptions...: 帳款明細幣別合計
# Memo...........:
# Usage..........: CALL aapr400_g01_subrep05(sr3)
# Date & Author..: 2014/11/18 By Hans
# Modify.........:
################################################################################
REPORT aapr400_g01_subrep05(sr3)
DEFINE sr3 sr3_r
    
    FORMAT 
           
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr3.*
END REPORT

################################################################################
# Descriptions...: 差異調整明細
# Memo...........:
# Usage..........: CALL aapr400_g01_subrep06(sr4)
# Date & Author..: 2014/11/18 By Hans
# Modify.........:
################################################################################
REPORT aapr400_g01_subrep06(sr4)
DEFINE sr4 sr4_r   
    FORMAT
           
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr4.*
         
END REPORT

################################################################################
# Descriptions...: 差異調整明細幣別合計：
# Memo...........:
# Usage..........: CALL aapr400_g01_subrep07(sr5)
# Date & Author..: 2014/11/18 By Hans
# Modify.........:
################################################################################
REPORT aapr400_g01_subrep07(sr5,p_docno,p_ld)
DEFINE sr5 sr5_r   
DEFINE l_glaa001      LIKE glaa_t.glaa001
DEFINE l_apde119_sum  LIKE apde_t.apde119
DEFINE p_docno        LIKE apda_t.apdadocno
DEFINE p_ld           LIKE apda_t.apdald
    FORMAT
           
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr5.*
        ON LAST ROW
         #本幣幣別
          CALL s_ld_sel_glaa(p_ld,'glaa001') RETURNING  g_sub_success,l_glaa001
        #本幣金額
        SELECT (SUM(CASE apde015 WHEN 'C' THEN apde119*-1 ELSE apde119 END))
          INTO l_apde119_sum
          FROM apde_t
         WHERE apdeent = g_enterprise
           AND apdeld = p_ld
           AND apdedocno = p_docno
           AND apde002  <> '10'
                      
         
         PRINTX l_apde119_sum,l_glaa001
         
END REPORT

################################################################################
# Descriptions...: 付款明細
# Memo...........:
# Usage..........: CALL aapr400_g01_subrep08(sr6)
# Date & Author..: 2014/11/18 By Hans
# Modify.........:
################################################################################
PRIVATE REPORT aapr400_g01_subrep08(sr6)
DEFINE sr6 sr6_r       
    FORMAT
           
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr6.*
END REPORT

################################################################################
# Descriptions...: 付款明細幣別合計
# Memo...........:
# Usage..........: CALL aapr400_g01_subrep09(sr7)
# Date & Author..: 2014/11/18 By Hans
# Modify.........:
################################################################################
PRIVATE REPORT aapr400_g01_subrep09(sr7,p_docno,p_ld)
DEFINE sr7 sr7_r
DEFINE l_glaa001      LIKE glaa_t.glaa001
DEFINE l_apde119_sum  LIKE apde_t.apde119
DEFINE p_docno        LIKE apda_t.apdadocno
DEFINE p_ld           LIKE apda_t.apdald

   FORMAT
      ON EVERY ROW
         PRINTX g_grNumFmt.*
         PRINTX sr7.*
      ON LAST ROW
         #本幣幣別
         CALL s_ld_sel_glaa(p_ld,'glaa001') RETURNING  g_sub_success,l_glaa001
         #本幣金額
        #SELECT SUM(CASE apde015 WHEN 'C' THEN apde119*-1 ELSE apde119 END) #151028-00011#1 mark
         SELECT SUM(CASE apde015 WHEN 'D' THEN apde119*-1 ELSE apde119 END) #151028-00011#1
          INTO l_apde119_sum
          FROM apde_t
         WHERE apdeent = g_enterprise
           AND apdeld = p_ld
           AND apdedocno = p_docno
          #AND apde002  = '10' #151028-00011#1 mark
   PRINTX l_apde119_sum,l_glaa001
END REPORT

 
{</section>}
 
