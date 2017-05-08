#該程式未解開Section, 採用最新樣板產出!
{<section id="apmr410_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:10(2017-02-13 13:12:15), PR版次:0010(2017-02-13 13:23:31)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000125
#+ Filename...: apmr410_g01
#+ Description: ...
#+ Creator....: 05229(2014-06-19 17:37:14)
#+ Modifier...: 05423 -SD/PR- 05423
 
{</section>}
 
{<section id="apmr410_g01.global" readonly="Y" >}
#報表 g01 樣板自動產生(Version:13)
#add-point:填寫註解說明 name="global.memo"
#160328-00003#1  2016/04/01  By  dorislai    增加表頭資訊呼叫
#161020-00013#1  2016/10/20  By  zhujing     g_select重写，配合g_from的子查询写法
#161031-00025#9  2017/02/13  By  zhujing     备注sql重写，ooff003 = 单号 AND ooff004 = 变更序 ...
#end add-point
#add-point:填寫註解說明 name="global.memo_customerization"

 
IMPORT os
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../cfg/top_report.inc"                  #報表使用的global
 
#報表 type 宣告
PRIVATE TYPE sr1_r RECORD
   pmdc001 LIKE pmdc_t.pmdc001, 
   pmdc002 LIKE pmdc_t.pmdc002, 
   pmdc003 LIKE pmdc_t.pmdc003, 
   pmdc004 LIKE pmdc_t.pmdc004, 
   pmdc005 LIKE pmdc_t.pmdc005, 
   pmdc006 LIKE pmdc_t.pmdc006, 
   pmdc007 LIKE pmdc_t.pmdc007, 
   pmdc010 LIKE pmdc_t.pmdc010, 
   pmdc011 LIKE pmdc_t.pmdc011, 
   pmdc012 LIKE pmdc_t.pmdc012, 
   pmdc020 LIKE pmdc_t.pmdc020, 
   pmdc021 LIKE pmdc_t.pmdc021, 
   pmdc022 LIKE pmdc_t.pmdc022, 
   pmdc900 LIKE pmdc_t.pmdc900, 
   pmdc901 LIKE pmdc_t.pmdc901, 
   pmdc902 LIKE pmdc_t.pmdc902, 
   pmdc905 LIKE pmdc_t.pmdc905, 
   pmdc906 LIKE pmdc_t.pmdc906, 
   pmdcacti LIKE pmdc_t.pmdcacti, 
   pmdcdocdt LIKE pmdc_t.pmdcdocdt, 
   pmdcdocno LIKE pmdc_t.pmdcdocno, 
   pmdcent LIKE pmdc_t.pmdcent, 
   pmdcsite LIKE pmdc_t.pmdcsite, 
   pmdcstus LIKE pmdc_t.pmdcstus, 
   pmdd001 LIKE pmdd_t.pmdd001, 
   pmdd002 LIKE pmdd_t.pmdd002, 
   pmdd003 LIKE pmdd_t.pmdd003, 
   pmdd004 LIKE pmdd_t.pmdd004, 
   pmdd005 LIKE pmdd_t.pmdd005, 
   pmdd006 LIKE pmdd_t.pmdd006, 
   pmdd007 LIKE pmdd_t.pmdd007, 
   pmdd008 LIKE pmdd_t.pmdd008, 
   pmdd009 LIKE pmdd_t.pmdd009, 
   pmdd010 LIKE pmdd_t.pmdd010, 
   pmdd011 LIKE pmdd_t.pmdd011, 
   pmdd012 LIKE pmdd_t.pmdd012, 
   pmdd014 LIKE pmdd_t.pmdd014, 
   pmdd015 LIKE pmdd_t.pmdd015, 
   pmdd016 LIKE pmdd_t.pmdd016, 
   pmdd017 LIKE pmdd_t.pmdd017, 
   pmdd018 LIKE pmdd_t.pmdd018, 
   pmdd019 LIKE pmdd_t.pmdd019, 
   pmdd020 LIKE pmdd_t.pmdd020, 
   pmdd021 LIKE pmdd_t.pmdd021, 
   pmdd030 LIKE pmdd_t.pmdd030, 
   pmdd031 LIKE pmdd_t.pmdd031, 
   pmdd032 LIKE pmdd_t.pmdd032, 
   pmdd033 LIKE pmdd_t.pmdd033, 
   pmdd034 LIKE pmdd_t.pmdd034, 
   pmdd035 LIKE pmdd_t.pmdd035, 
   pmdd036 LIKE pmdd_t.pmdd036, 
   pmdd037 LIKE pmdd_t.pmdd037, 
   pmdd038 LIKE pmdd_t.pmdd038, 
   pmdd039 LIKE pmdd_t.pmdd039, 
   pmdd040 LIKE pmdd_t.pmdd040, 
   pmdd041 LIKE pmdd_t.pmdd041, 
   pmdd042 LIKE pmdd_t.pmdd042, 
   pmdd043 LIKE pmdd_t.pmdd043, 
   pmdd044 LIKE pmdd_t.pmdd044, 
   pmdd045 LIKE pmdd_t.pmdd045, 
   pmdd046 LIKE pmdd_t.pmdd046, 
   pmdd048 LIKE pmdd_t.pmdd048, 
   pmdd049 LIKE pmdd_t.pmdd049, 
   pmdd050 LIKE pmdd_t.pmdd050, 
   pmdd901 LIKE pmdd_t.pmdd901, 
   pmdd902 LIKE pmdd_t.pmdd902, 
   pmdd903 LIKE pmdd_t.pmdd903, 
   pmddseq LIKE pmdd_t.pmddseq, 
   pmddsite LIKE pmdd_t.pmddsite, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   t2_ooefl003 LIKE ooefl_t.ooefl003, 
   x_t5_ooefl003 LIKE ooefl_t.ooefl003, 
   x_t6_ooefl003 LIKE ooefl_t.ooefl003, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   x_t10_imaal003 LIKE imaal_t.imaal003, 
   l_pmdc002_ooag011 LIKE type_t.chr300, 
   l_pmdc003_ooefl003 LIKE type_t.chr1000, 
   l_pmdc007_ooefl003 LIKE type_t.chr1000, 
   l_pmdd046_ooefl003 LIKE type_t.chr1000, 
   l_pmdd033_desc LIKE type_t.chr30, 
   x_t10_imaal004 LIKE imaal_t.imaal004, 
   pmdd900 LIKE pmdd_t.pmdd900, 
   l_pmdc010_desc LIKE type_t.chr100, 
   l_pmdc905_desc LIKE type_t.chr100, 
   l_pmdd014_desc LIKE type_t.chr100, 
   l_pmdd017_desc LIKE type_t.chr100, 
   l_pmdd016_desc LIKE type_t.chr100, 
   l_pmdd042_desc LIKE type_t.chr100, 
   l_pmdd041_desc LIKE type_t.chr100, 
   l_pmdd015_pmaal003 LIKE type_t.chr100, 
   l_order LIKE type_t.chr30
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING,                  #where condition 
       a1 LIKE type_t.chr1          #變更的資料
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
TYPE sr3_r RECORD
   pmde002_1      LIKE pmde_t.pmde002,   #欄位名稱(左)
   pmde002_1_desc LIKE dzeb_t.dzeb003,   #欄位名稱(左)
   pmde004_1      LIKE pmde_t.pmde004,   #變更前資料(左)
   pmde002_2      LIKE pmde_t.pmde002,   #欄位名稱(右)
   pmde002_2_desc LIKE dzeb_t.dzeb003,   #欄位名稱(右)
   pmde004_2      LIKE pmde_t.pmde004    #變更前資料(右)
END RECORD

TYPE sr4_r RECORD
   pmde002  LIKE pmde_t.pmde002,           #欄位名稱
   pmde004  LIKE pmde_t.pmde004            #變更前資料
END RECORD

TYPE sr5_r RECORD  #單身變更欄位
   pmddseq          LIKE pmdd_t.pmddseq,
   pmdd004          LIKE pmdd_t.pmdd004,     #料件編號
   imaal003         LIKE imaal_t.imaal003,   #品名
   imaal004         LIKE imaal_t.imaal004,   #規格
   pmdd005          LIKE pmdd_t.pmdd005,     #產品特徵
   pmdd006          LIKE pmdd_t.pmdd006,     #需求數量
   pmdd007          LIKE pmdd_t.pmdd007,     #單位
   pmdd030          LIKE pmdd_t.pmdd030,     #需求日期
   pmdd033          LIKE pmdd_t.pmdd033,     #緊急度
   pmdd033_desc     LIKE type_t.chr100,
   pmdd014          LIKE pmdd_t.pmdd014,     #供應商選擇方式
   pmdd014_desc     LIKE type_t.chr100,
   pmdd015          LIKE pmdd_t.pmdd015,     #供應商
   pmdd015_pmaal003 LIKE type_t.chr100,      #供應商說明
   pmdd016          LIKE pmdd_t.pmdd016,     #付款條件
   pmdd016_desc     LIKE type_t.chr100,      #付款說明
   pmdd017          LIKE pmdd_t.pmdd017,     #交易條件
   pmdd017_desc     LIKE type_t.chr100,     #交易說明
   pmdd042          LIKE pmdd_t.pmdd042,     #不允許提前交貨
   pmdd042_desc     LIKE type_t.chr100,
   pmdd041          LIKE pmdd_t.pmdd041,     #不允許部分交貨
   pmdd041_desc     LIKE type_t.chr100,
   pmdd005_show     LIKE type_t.chr1

END RECORD

DEFINE sr4 DYNAMIC ARRAY OF sr4_r

#end add-point
 
{</section>}
 
{<section id="apmr410_g01.main" readonly="Y" >}
PUBLIC FUNCTION apmr410_g01(p_arg1,p_arg2)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr1         #tm.a1  變更的資料
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.a1 = p_arg2
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "apmr410_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL apmr410_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL apmr410_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL apmr410_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="apmr410_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apmr410_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   #161020-00013#1 marked-S sql 改成子查询
#   LET g_select = " SELECT pmdc001,pmdc002,pmdc003,pmdc004,pmdc005,pmdc006,pmdc007,pmdc010,pmdc011,pmdc012, 
#       pmdc020,pmdc021,pmdc022,pmdc900,pmdc901,pmdc902,pmdc905,pmdc906,pmdcacti,pmdcdocdt,pmdcdocno, 
#       pmdcent,pmdcsite,pmdcstus,pmdd001,pmdd002,pmdd003,pmdd004,pmdd005,pmdd006,pmdd007,pmdd008,pmdd009, 
#       pmdd010,pmdd011,pmdd012,pmdd014,pmdd015,pmdd016,pmdd017,pmdd018,pmdd019,pmdd020,pmdd021,pmdd030, 
#       pmdd031,pmdd032,pmdd033,pmdd034,pmdd035,pmdd036,pmdd037,pmdd038,pmdd039,pmdd040,pmdd041,pmdd042, 
#       pmdd043,pmdd044,pmdd045,pmdd046,pmdd048,pmdd049,pmdd050,pmdd901,pmdd902,pmdd903,pmddseq,pmddsite, 
#       ooag_t.ooag011,ooefl_t.ooefl003,t2.ooefl003,x.t5_ooefl003,x.t6_ooefl003,x.imaal_t_imaal003,x.t10_imaal003, 
#       trim(pmdc002)||'.'||trim(ooag_t.ooag011),trim(pmdc003)||'.'||trim(t2.ooefl003),trim(pmdc007)||'.'||trim(ooefl_t.ooefl003), 
#       trim(pmdd046)||'.'||trim(x.t6_ooefl003),NULL,x.t10_imaal004,pmdd900,'','','','','','','','',trim(pmdcdocno)||trim(TO_CHAR(pmdc_t.pmdc900,'0000'))"
    #161020-00013#1 marked-E sql 改成子查询
    #161020-00013#1 mod-S sql 改成子查询
    LET g_select = " SELECT pmdc001,pmdc002,pmdc003,pmdc004,pmdc005,pmdc006,pmdc007,pmdc010,pmdc011,pmdc012, ",
       "pmdc020,pmdc021,pmdc022,pmdc900,pmdc901,pmdc902,pmdc905,pmdc906,pmdcacti,pmdcdocdt,pmdcdocno, ",
       "pmdcent,pmdcsite,pmdcstus,pmdd001,pmdd002,pmdd003,pmdd004,pmdd005,pmdd006,pmdd007,pmdd008,pmdd009, ",
       "pmdd010,pmdd011,pmdd012,pmdd014,pmdd015,pmdd016,pmdd017,pmdd018,pmdd019,pmdd020,pmdd021,pmdd030, ",
       "pmdd031,pmdd032,pmdd033,pmdd034,pmdd035,pmdd036,pmdd037,pmdd038,pmdd039,pmdd040,pmdd041,pmdd042, ",
       "pmdd043,pmdd044,pmdd045,pmdd046,pmdd048,pmdd049,pmdd050,pmdd901,pmdd902,pmdd903,pmddseq,pmddsite, ",
       "( SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = pmdc_t.pmdc002 AND ooag_t.ooagent = pmdc_t.pmdcent), ",
       "( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = pmdc_t.pmdc007 AND ooefl_t.ooeflent = pmdc_t.pmdcent AND ooefl_t.ooefl002 = '" , g_dlang,"'" ,"),",
       "( SELECT ooefl003 FROM ooefl_t t2 WHERE t2.ooefl001 = pmdc_t.pmdc003 AND t2.ooeflent = pmdc_t.pmdcent AND t2.ooefl002 = '" , g_dlang,"'" ,"),",
       "x.t5_ooefl003,x.t6_ooefl003,x.imaal_t_imaal003,x.t10_imaal003,",
       "trim(pmdc002)||'.'||trim((SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = pmdc_t.pmdc002 AND ooag_t.ooagent = pmdc_t.pmdcent)), ",
       "trim(pmdc003)||'.'||trim((SELECT ooefl003 FROM ooefl_t t2 WHERE t2.ooefl001 = pmdc_t.pmdc003 AND t2.ooeflent = pmdc_t.pmdcent AND t2.ooefl002 = '" , g_dlang,"'" ,")),",
       "trim(pmdc007)||'.'||trim((SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = pmdc_t.pmdc007 AND ooefl_t.ooeflent = pmdc_t.pmdcent AND ooefl_t.ooefl002 = '" , g_dlang,"'" ,")),",
       "trim(pmdd046)||'.'||trim(x.t6_ooefl003),NULL,x.t10_imaal004,pmdd900,'','','', ",
       "'','','','','',trim(pmdcdocno)||trim(TO_CHAR(pmdc_t.pmdc900,'0000'))"
    #161020-00013#1 mod-E
    
#   #end add-point
#   LET g_select = " SELECT pmdc001,pmdc002,pmdc003,pmdc004,pmdc005,pmdc006,pmdc007,pmdc010,pmdc011,pmdc012, 
#       pmdc020,pmdc021,pmdc022,pmdc900,pmdc901,pmdc902,pmdc905,pmdc906,pmdcacti,pmdcdocdt,pmdcdocno, 
#       pmdcent,pmdcsite,pmdcstus,pmdd001,pmdd002,pmdd003,pmdd004,pmdd005,pmdd006,pmdd007,pmdd008,pmdd009, 
#       pmdd010,pmdd011,pmdd012,pmdd014,pmdd015,pmdd016,pmdd017,pmdd018,pmdd019,pmdd020,pmdd021,pmdd030, 
#       pmdd031,pmdd032,pmdd033,pmdd034,pmdd035,pmdd036,pmdd037,pmdd038,pmdd039,pmdd040,pmdd041,pmdd042, 
#       pmdd043,pmdd044,pmdd045,pmdd046,pmdd048,pmdd049,pmdd050,pmdd901,pmdd902,pmdd903,pmddseq,pmddsite, 
#       ( SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = pmdc_t.pmdc002 AND ooag_t.ooagent = pmdc_t.pmdcent), 
#       ( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = pmdc_t.pmdc007 AND ooefl_t.ooeflent = pmdc_t.pmdcent AND ooefl_t.ooefl002 = '" , 
#       g_dlang,"'" ,"),( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = pmdc_t.pmdc003 AND ooefl_t.ooeflent = pmdc_t.pmdcent AND ooefl_t.ooefl002 = '" , 
#       g_dlang,"'" ,"),x.t5_ooefl003,x.t6_ooefl003,x.imaal_t_imaal003,x.t10_imaal003,trim(pmdc002)||'.'||trim((SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = pmdc_t.pmdc002 AND ooag_t.ooagent = pmdc_t.pmdcent)), 
#       trim(pmdc003)||'.'||trim((SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = pmdc_t.pmdc003 AND ooefl_t.ooeflent = pmdc_t.pmdcent AND ooefl_t.ooefl002 = '" , 
#       g_dlang,"'" ,")),trim(pmdc007)||'.'||trim((SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = pmdc_t.pmdc007 AND ooefl_t.ooeflent = pmdc_t.pmdcent AND ooefl_t.ooefl002 = '" , 
#       g_dlang,"'" ,")),trim(pmdd046)||'.'||trim(x.t6_ooefl003),NULL,x.t10_imaal004,pmdd900,'','','', 
#       '','','','','',NULL"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   
   #end add-point
    LET g_from = " FROM pmdc_t LEFT OUTER JOIN ( SELECT pmdd_t.*,( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = pmdd_t.pmdd037 AND ooefl_t.ooeflent = pmdd_t.pmddent AND ooefl_t.ooefl002 = '" , 
        g_dlang,"'" ,") t5_ooefl003,( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = pmdd_t.pmdd046 AND ooefl_t.ooeflent = pmdd_t.pmddent AND ooefl_t.ooefl002 = '" , 
        g_dlang,"'" ,") t6_ooefl003,( SELECT imaal003 FROM imaal_t WHERE imaal_t.imaal001 = pmdd_t.pmdd012 AND imaal_t.imaalent = pmdd_t.pmddent AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,") imaal_t_imaal003,( SELECT imaal003 FROM imaal_t WHERE imaal_t.imaal001 = pmdd_t.pmdd004 AND imaal_t.imaalent = pmdd_t.pmddent AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,") t10_imaal003,( SELECT imaal004 FROM imaal_t WHERE imaal_t.imaal001 = pmdd_t.pmdd004 AND imaal_t.imaalent = pmdd_t.pmddent AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,") t10_imaal004 FROM pmdd_t ) x  ON pmdc_t.pmdcent = x.pmddent AND pmdc_t.pmdcdocno  
        = x.pmdddocno AND pmdc_t.pmdc900 = x.pmdd900"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
    LET g_order = " ORDER BY pmdc900,pmddseq,pmdcdocno"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("pmdc_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE apmr410_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE apmr410_g01_curs CURSOR FOR apmr410_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="apmr410_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION apmr410_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   pmdc001 LIKE pmdc_t.pmdc001, 
   pmdc002 LIKE pmdc_t.pmdc002, 
   pmdc003 LIKE pmdc_t.pmdc003, 
   pmdc004 LIKE pmdc_t.pmdc004, 
   pmdc005 LIKE pmdc_t.pmdc005, 
   pmdc006 LIKE pmdc_t.pmdc006, 
   pmdc007 LIKE pmdc_t.pmdc007, 
   pmdc010 LIKE pmdc_t.pmdc010, 
   pmdc011 LIKE pmdc_t.pmdc011, 
   pmdc012 LIKE pmdc_t.pmdc012, 
   pmdc020 LIKE pmdc_t.pmdc020, 
   pmdc021 LIKE pmdc_t.pmdc021, 
   pmdc022 LIKE pmdc_t.pmdc022, 
   pmdc900 LIKE pmdc_t.pmdc900, 
   pmdc901 LIKE pmdc_t.pmdc901, 
   pmdc902 LIKE pmdc_t.pmdc902, 
   pmdc905 LIKE pmdc_t.pmdc905, 
   pmdc906 LIKE pmdc_t.pmdc906, 
   pmdcacti LIKE pmdc_t.pmdcacti, 
   pmdcdocdt LIKE pmdc_t.pmdcdocdt, 
   pmdcdocno LIKE pmdc_t.pmdcdocno, 
   pmdcent LIKE pmdc_t.pmdcent, 
   pmdcsite LIKE pmdc_t.pmdcsite, 
   pmdcstus LIKE pmdc_t.pmdcstus, 
   pmdd001 LIKE pmdd_t.pmdd001, 
   pmdd002 LIKE pmdd_t.pmdd002, 
   pmdd003 LIKE pmdd_t.pmdd003, 
   pmdd004 LIKE pmdd_t.pmdd004, 
   pmdd005 LIKE pmdd_t.pmdd005, 
   pmdd006 LIKE pmdd_t.pmdd006, 
   pmdd007 LIKE pmdd_t.pmdd007, 
   pmdd008 LIKE pmdd_t.pmdd008, 
   pmdd009 LIKE pmdd_t.pmdd009, 
   pmdd010 LIKE pmdd_t.pmdd010, 
   pmdd011 LIKE pmdd_t.pmdd011, 
   pmdd012 LIKE pmdd_t.pmdd012, 
   pmdd014 LIKE pmdd_t.pmdd014, 
   pmdd015 LIKE pmdd_t.pmdd015, 
   pmdd016 LIKE pmdd_t.pmdd016, 
   pmdd017 LIKE pmdd_t.pmdd017, 
   pmdd018 LIKE pmdd_t.pmdd018, 
   pmdd019 LIKE pmdd_t.pmdd019, 
   pmdd020 LIKE pmdd_t.pmdd020, 
   pmdd021 LIKE pmdd_t.pmdd021, 
   pmdd030 LIKE pmdd_t.pmdd030, 
   pmdd031 LIKE pmdd_t.pmdd031, 
   pmdd032 LIKE pmdd_t.pmdd032, 
   pmdd033 LIKE pmdd_t.pmdd033, 
   pmdd034 LIKE pmdd_t.pmdd034, 
   pmdd035 LIKE pmdd_t.pmdd035, 
   pmdd036 LIKE pmdd_t.pmdd036, 
   pmdd037 LIKE pmdd_t.pmdd037, 
   pmdd038 LIKE pmdd_t.pmdd038, 
   pmdd039 LIKE pmdd_t.pmdd039, 
   pmdd040 LIKE pmdd_t.pmdd040, 
   pmdd041 LIKE pmdd_t.pmdd041, 
   pmdd042 LIKE pmdd_t.pmdd042, 
   pmdd043 LIKE pmdd_t.pmdd043, 
   pmdd044 LIKE pmdd_t.pmdd044, 
   pmdd045 LIKE pmdd_t.pmdd045, 
   pmdd046 LIKE pmdd_t.pmdd046, 
   pmdd048 LIKE pmdd_t.pmdd048, 
   pmdd049 LIKE pmdd_t.pmdd049, 
   pmdd050 LIKE pmdd_t.pmdd050, 
   pmdd901 LIKE pmdd_t.pmdd901, 
   pmdd902 LIKE pmdd_t.pmdd902, 
   pmdd903 LIKE pmdd_t.pmdd903, 
   pmddseq LIKE pmdd_t.pmddseq, 
   pmddsite LIKE pmdd_t.pmddsite, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   t2_ooefl003 LIKE ooefl_t.ooefl003, 
   x_t5_ooefl003 LIKE ooefl_t.ooefl003, 
   x_t6_ooefl003 LIKE ooefl_t.ooefl003, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   x_t10_imaal003 LIKE imaal_t.imaal003, 
   l_pmdc002_ooag011 LIKE type_t.chr300, 
   l_pmdc003_ooefl003 LIKE type_t.chr1000, 
   l_pmdc007_ooefl003 LIKE type_t.chr1000, 
   l_pmdd046_ooefl003 LIKE type_t.chr1000, 
   l_pmdd033_desc LIKE type_t.chr30, 
   x_t10_imaal004 LIKE imaal_t.imaal004, 
   pmdd900 LIKE pmdd_t.pmdd900, 
   l_pmdc010_desc LIKE type_t.chr100, 
   l_pmdc905_desc LIKE type_t.chr100, 
   l_pmdd014_desc LIKE type_t.chr100, 
   l_pmdd017_desc LIKE type_t.chr100, 
   l_pmdd016_desc LIKE type_t.chr100, 
   l_pmdd042_desc LIKE type_t.chr100, 
   l_pmdd041_desc LIKE type_t.chr100, 
   l_pmdd015_pmaal003 LIKE type_t.chr100, 
   l_order LIKE type_t.chr30
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_gzcb008 LIKE gzcb_t.gzcb008
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH apmr410_g01_curs INTO sr_s.*
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
       
 
       #緊急度說明  
       CALL s_desc_gzcbl004_desc('2036',sr_s.pmdd033)RETURNING sr_s.l_pmdd033_desc   
       #稅別說明
       CALL apmr410_g01_oodc010_ref(sr_s.pmdc010)RETURNING sr_s.l_pmdc010_desc 
       #變更理由 
       LET l_gzcb008 = ''       
       SELECT gzcb008 INTO l_gzcb008
           FROM gzcb_t
          WHERE gzcb001 = '24'
            AND gzcb002 = 'apmt400'  
       IF NOT cl_null(l_gzcb008) THEN           
          CALL s_desc_get_acc_desc(l_gzcb008,sr_s.pmdc905)RETURNING sr_s.l_pmdc905_desc
       END IF
       #交易對象
       CALL s_desc_get_trading_partner_abbr_desc(sr_s.pmdd015)RETURNING sr_s.l_pmdd015_pmaal003
       #供應商選擇方式
       CALL s_desc_gzcbl004_desc(2037,sr_s.pmdd014)RETURNING sr_s.l_pmdd014_desc       
       LET sr_s.l_pmdd015_pmaal003 = '指定供應商:',sr_s.l_pmdd014_desc CLIPPED,'.',sr_s.pmdd015,'.',sr_s.l_pmdd015_pmaal003
       IF cl_null(sr_s.pmdd015) THEN
          LET sr_s.l_pmdd015_pmaal003 = '' 
       END IF
       #交易條件
       CALL s_desc_get_acc_desc(238,sr_s.pmdd017)RETURNING sr_s.l_pmdd017_desc
       LET sr_s.l_pmdd017_desc = '交易條件:',sr_s.l_pmdd017_desc       
       IF cl_null(sr_s.pmdd017) THEN
          LET sr_s.l_pmdd017_desc =' '
       END IF
       #付款條件
       CALL s_desc_get_ooib002_desc(sr_s.pmdd016)RETURNING sr_s.l_pmdd016_desc
       LET sr_s.l_pmdd016_desc = '付款條件:',sr_s.l_pmdd016_desc
       IF cl_null(sr_s.pmdd016) THEN
          LET sr_s.l_pmdd016_desc =' '
       END IF
       
       IF sr_s.pmdd042 = 'N' THEN
          LET sr_s.l_pmdd042_desc = '不允許提前交貨'
       ELSE
          LET sr_s.l_pmdd042_desc = ' '
       END IF
       
       IF sr_s.pmdd041 = 'N' THEN
          LET sr_s.l_pmdd041_desc = '不允許部分交貨'
       ELSE
          LET sr_s.l_pmdd041_desc = ' '
       END IF

       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].pmdc001 = sr_s.pmdc001
       LET sr[l_cnt].pmdc002 = sr_s.pmdc002
       LET sr[l_cnt].pmdc003 = sr_s.pmdc003
       LET sr[l_cnt].pmdc004 = sr_s.pmdc004
       LET sr[l_cnt].pmdc005 = sr_s.pmdc005
       LET sr[l_cnt].pmdc006 = sr_s.pmdc006
       LET sr[l_cnt].pmdc007 = sr_s.pmdc007
       LET sr[l_cnt].pmdc010 = sr_s.pmdc010
       LET sr[l_cnt].pmdc011 = sr_s.pmdc011
       LET sr[l_cnt].pmdc012 = sr_s.pmdc012
       LET sr[l_cnt].pmdc020 = sr_s.pmdc020
       LET sr[l_cnt].pmdc021 = sr_s.pmdc021
       LET sr[l_cnt].pmdc022 = sr_s.pmdc022
       LET sr[l_cnt].pmdc900 = sr_s.pmdc900
       LET sr[l_cnt].pmdc901 = sr_s.pmdc901
       LET sr[l_cnt].pmdc902 = sr_s.pmdc902
       LET sr[l_cnt].pmdc905 = sr_s.pmdc905
       LET sr[l_cnt].pmdc906 = sr_s.pmdc906
       LET sr[l_cnt].pmdcacti = sr_s.pmdcacti
       LET sr[l_cnt].pmdcdocdt = sr_s.pmdcdocdt
       LET sr[l_cnt].pmdcdocno = sr_s.pmdcdocno
       LET sr[l_cnt].pmdcent = sr_s.pmdcent
       LET sr[l_cnt].pmdcsite = sr_s.pmdcsite
       LET sr[l_cnt].pmdcstus = sr_s.pmdcstus
       LET sr[l_cnt].pmdd001 = sr_s.pmdd001
       LET sr[l_cnt].pmdd002 = sr_s.pmdd002
       LET sr[l_cnt].pmdd003 = sr_s.pmdd003
       LET sr[l_cnt].pmdd004 = sr_s.pmdd004
       LET sr[l_cnt].pmdd005 = sr_s.pmdd005
       LET sr[l_cnt].pmdd006 = sr_s.pmdd006
       LET sr[l_cnt].pmdd007 = sr_s.pmdd007
       LET sr[l_cnt].pmdd008 = sr_s.pmdd008
       LET sr[l_cnt].pmdd009 = sr_s.pmdd009
       LET sr[l_cnt].pmdd010 = sr_s.pmdd010
       LET sr[l_cnt].pmdd011 = sr_s.pmdd011
       LET sr[l_cnt].pmdd012 = sr_s.pmdd012
       LET sr[l_cnt].pmdd014 = sr_s.pmdd014
       LET sr[l_cnt].pmdd015 = sr_s.pmdd015
       LET sr[l_cnt].pmdd016 = sr_s.pmdd016
       LET sr[l_cnt].pmdd017 = sr_s.pmdd017
       LET sr[l_cnt].pmdd018 = sr_s.pmdd018
       LET sr[l_cnt].pmdd019 = sr_s.pmdd019
       LET sr[l_cnt].pmdd020 = sr_s.pmdd020
       LET sr[l_cnt].pmdd021 = sr_s.pmdd021
       LET sr[l_cnt].pmdd030 = sr_s.pmdd030
       LET sr[l_cnt].pmdd031 = sr_s.pmdd031
       LET sr[l_cnt].pmdd032 = sr_s.pmdd032
       LET sr[l_cnt].pmdd033 = sr_s.pmdd033
       LET sr[l_cnt].pmdd034 = sr_s.pmdd034
       LET sr[l_cnt].pmdd035 = sr_s.pmdd035
       LET sr[l_cnt].pmdd036 = sr_s.pmdd036
       LET sr[l_cnt].pmdd037 = sr_s.pmdd037
       LET sr[l_cnt].pmdd038 = sr_s.pmdd038
       LET sr[l_cnt].pmdd039 = sr_s.pmdd039
       LET sr[l_cnt].pmdd040 = sr_s.pmdd040
       LET sr[l_cnt].pmdd041 = sr_s.pmdd041
       LET sr[l_cnt].pmdd042 = sr_s.pmdd042
       LET sr[l_cnt].pmdd043 = sr_s.pmdd043
       LET sr[l_cnt].pmdd044 = sr_s.pmdd044
       LET sr[l_cnt].pmdd045 = sr_s.pmdd045
       LET sr[l_cnt].pmdd046 = sr_s.pmdd046
       LET sr[l_cnt].pmdd048 = sr_s.pmdd048
       LET sr[l_cnt].pmdd049 = sr_s.pmdd049
       LET sr[l_cnt].pmdd050 = sr_s.pmdd050
       LET sr[l_cnt].pmdd901 = sr_s.pmdd901
       LET sr[l_cnt].pmdd902 = sr_s.pmdd902
       LET sr[l_cnt].pmdd903 = sr_s.pmdd903
       LET sr[l_cnt].pmddseq = sr_s.pmddseq
       LET sr[l_cnt].pmddsite = sr_s.pmddsite
       LET sr[l_cnt].ooag_t_ooag011 = sr_s.ooag_t_ooag011
       LET sr[l_cnt].ooefl_t_ooefl003 = sr_s.ooefl_t_ooefl003
       LET sr[l_cnt].t2_ooefl003 = sr_s.t2_ooefl003
       LET sr[l_cnt].x_t5_ooefl003 = sr_s.x_t5_ooefl003
       LET sr[l_cnt].x_t6_ooefl003 = sr_s.x_t6_ooefl003
       LET sr[l_cnt].x_imaal_t_imaal003 = sr_s.x_imaal_t_imaal003
       LET sr[l_cnt].x_t10_imaal003 = sr_s.x_t10_imaal003
       LET sr[l_cnt].l_pmdc002_ooag011 = sr_s.l_pmdc002_ooag011
       LET sr[l_cnt].l_pmdc003_ooefl003 = sr_s.l_pmdc003_ooefl003
       LET sr[l_cnt].l_pmdc007_ooefl003 = sr_s.l_pmdc007_ooefl003
       LET sr[l_cnt].l_pmdd046_ooefl003 = sr_s.l_pmdd046_ooefl003
       LET sr[l_cnt].l_pmdd033_desc = sr_s.l_pmdd033_desc
       LET sr[l_cnt].x_t10_imaal004 = sr_s.x_t10_imaal004
       LET sr[l_cnt].pmdd900 = sr_s.pmdd900
       LET sr[l_cnt].l_pmdc010_desc = sr_s.l_pmdc010_desc
       LET sr[l_cnt].l_pmdc905_desc = sr_s.l_pmdc905_desc
       LET sr[l_cnt].l_pmdd014_desc = sr_s.l_pmdd014_desc
       LET sr[l_cnt].l_pmdd017_desc = sr_s.l_pmdd017_desc
       LET sr[l_cnt].l_pmdd016_desc = sr_s.l_pmdd016_desc
       LET sr[l_cnt].l_pmdd042_desc = sr_s.l_pmdd042_desc
       LET sr[l_cnt].l_pmdd041_desc = sr_s.l_pmdd041_desc
       LET sr[l_cnt].l_pmdd015_pmaal003 = sr_s.l_pmdd015_pmaal003
       LET sr[l_cnt].l_order = sr_s.l_order
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apmr410_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION apmr410_g01_rep_data()
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
          START REPORT apmr410_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT apmr410_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT apmr410_g01_rep
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
 
{<section id="apmr410_g01.rep" readonly="Y" >}
PRIVATE REPORT apmr410_g01_rep(sr1)
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
DEFINE sr3 sr3_r
DEFINE sr5 sr5_r

DEFINE l_pmdd042_show  LIKE type_t.chr10      #允許提前交貨
DEFINE l_pmdd041_show  LIKE type_t.chr10      #允許部分交貨
DEFINE l_subrep05_show LIKE type_t.chr5       #單頭變更前子報表
DEFINE l_subrep06_show LIKE type_t.chr5       #單身變更前子報表
DEFINE l_pmdd_show     LIKE type_t.chr5       #選項打勾時單身隱藏
DEFINE l_pmdc906_show  LIKE type_t.chr5 
DEFINE l_pmdd005_show  LIKE type_t.chr5  
DEFINE l_pmdd903_show  LIKE type_t.chr5 

DEFINE l_ac            INTEGER
DEFINE l_i             INTEGER
DEFINE l_count         LIKE type_t.num5

DEFINE l_pmdc002_btl   LIKE type_t.num20_6
DEFINE l_pmdc003_btl   LIKE type_t.num20_6
DEFINE l_pmdc006_btl   LIKE type_t.num20_6
DEFINE l_pmdc007_btl   LIKE type_t.num20_6
DEFINE l_pmdc005_btl   LIKE type_t.num20_6
DEFINE l_pmdc010_btl   LIKE type_t.num20_6
DEFINE l_pmdc002       LIKE type_t.num20_6
DEFINE l_pmdc003       LIKE type_t.num20_6
DEFINE l_pmdc006       LIKE type_t.num20_6
DEFINE l_pmdc007       LIKE type_t.num20_6
DEFINE l_pmdc005       LIKE type_t.num20_6
DEFINE l_pmdc010       LIKE type_t.num20_6

DEFINE l_pmdd004_btl   LIKE type_t.num20_6
DEFINE l_pmdd005_btl   LIKE type_t.num20_6
DEFINE l_pmdd006_btl   LIKE type_t.num20_6
DEFINE l_pmdd007_btl   LIKE type_t.num20_6
DEFINE l_pmdd030_btl   LIKE type_t.num20_6
DEFINE l_pmdd033_btl   LIKE type_t.num20_6
DEFINE l_pmdd014_btl   LIKE type_t.num20_6
DEFINE l_pmdd015_btl   LIKE type_t.num20_6
DEFINE l_pmdd016_btl   LIKE type_t.num20_6
DEFINE l_pmdd017_btl   LIKE type_t.num20_6
DEFINE l_pmdd042_btl   LIKE type_t.num20_6
DEFINE l_pmdd041_btl   LIKE type_t.num20_6
DEFINE l_ooef019       LIKE ooef_t.ooef019 #稅區

#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER  BY sr1.l_order,sr1.pmddseq
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
        BEFORE GROUP OF sr1.l_order
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            CALL cl_gr_init_pageheader() #表頭資訊   #160328-00003#1-add
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*   #add--2015/11/03 By shiun
            CALL cl_gr_init_apr(sr1.pmdcdocno)
#            #end add-point:rep.header 
#            LET g_rep_docno = sr1.l_order
#            CALL cl_gr_init_pageheader() #表頭資訊
#            PRINTX g_grPageHeader.*
#            PRINTX g_grPageFooter.*
#            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'pmdcent=' ,sr1.pmdcent,'{+}pmdcdocno=' ,sr1.pmdcdocno,'{+}pmdc900=' ,sr1.pmdc900         
            CALL cl_gr_init_apr(sr1.l_order)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.l_order.before name="rep.b_group.l_order.before"
           #取的所屬稅區
            SELECT ooef019 INTO l_ooef019 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site            
           #單頭變更子報表
           LET l_subrep05_show = "N"
           LET l_pmdc002_btl = 0
           LET l_pmdc003_btl = 0
           LET l_pmdc006_btl = 0
           LET l_pmdc007_btl = 0
           LET l_pmdc005_btl = 0
           LET l_pmdc010_btl = 0
           LET l_pmdc002 = 0
           LET l_pmdc003 = 0
           LET l_pmdc006 = 0
           LET l_pmdc007 = 0
           LET l_pmdc005 = 0
           LET l_pmdc010 = 0
                      
           START REPORT apmr410_g01_subrep05
              LET g_sql = "SELECT pmde002,pmde004 ",
                          "  FROM pmde_t ",
                          " WHERE pmdedocno  = '",sr1.pmdcdocno CLIPPED,"'",
                          "   AND pmdeent    = '",sr1.pmdcent   CLIPPED,"'",
                          "   AND pmde001    = '",sr1.pmdc900   CLIPPED,"'",
                          "   AND pmdeseq    = 0 "
                   
              LET l_ac = 1
              CALL sr4.clear()
              DECLARE apmr410_g01_repcur05 CURSOR FROM g_sql
              FOREACH apmr410_g01_repcur05 INTO sr4[l_ac].*
                 IF STATUS THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.extend = "apmr410_g01_repcur05:"
                    LET g_errparam.code   = SQLCA.sqlcode
                    LET g_errparam.popup  = FALSE
                    CALL cl_err()
                    EXIT FOREACH
                 END IF                                                                             
              LET l_ac = l_ac + 1
              END FOREACH
              LET l_ac = l_ac-1            #最後多加了一次
              LET l_i = 1                  #目前筆數              
              IF l_ac > 0 THEN
                 LET l_subrep05_show = "Y"
                 WHILE TRUE
                    INITIALIZE sr3.* TO NULL
                    LET sr3.pmde002_1 = sr4[l_i].pmde002
                    LET sr3.pmde004_1 = sr4[l_i].pmde004
                    CASE 
                       WHEN sr3.pmde002_1 = 'pmda002' #請購人員
                          CALL s_desc_get_person_desc(sr3.pmde004_1) RETURNING sr3.pmde004_1
                       WHEN sr3.pmde002_1 = 'pmda004' #請購部門
                          CALL s_desc_get_department_desc(sr3.pmde004_1)RETURNING sr3.pmde004_1 
                       WHEN sr3.pmde002_1 = 'pmda007' #費用部門    
                          CALL s_desc_get_department_desc(sr3.pmde004_1)RETURNING sr3.pmde004_1
                       WHEN sr3.pmde002_1 = 'pmda010' #稅別    
                          CALL s_desc_get_tax_desc(l_ooef019,sr3.pmde004_1)RETURNING sr3.pmde004_1                          
                    END CASE   
                    CALL apmr410_g01_pmde002_ref(sr3.pmde002_1)RETURNING sr3.pmde002_1_desc                      
                    IF (l_i + 1) <= l_ac THEN
                        LET sr3.pmde002_2 = sr4[l_i+1].pmde002
                        LET sr3.pmde004_2 = sr4[l_i+1].pmde004
                        CASE 
                          WHEN sr3.pmde002_2 = 'pmda002' #請購人員
                             CALL s_desc_get_person_desc(sr3.pmde004_2) RETURNING sr3.pmde004_2
                          WHEN sr3.pmde002_2 = 'pmda004' #請購部門
                             CALL s_desc_get_department_desc(sr3.pmde004_2)RETURNING sr3.pmde004_2 
                          WHEN sr3.pmde002_2 = 'pmda007' #費用部門    
                             CALL s_desc_get_department_desc(sr3.pmde004_2)RETURNING sr3.pmde004_2  
                          WHEN sr3.pmde002_2 = 'pmda010' #稅別
                             CALL s_desc_get_tax_desc(l_ooef019,sr3.pmde004_2)RETURNING sr3.pmde004_2                          
                        END CASE                
                        CALL apmr410_g01_pmde002_ref(sr3.pmde002_2)RETURNING sr3.pmde002_2_desc                                            
                    END IF
                                       
                    CALL apmr410_g01_pmdc_chg(sr3.pmde002_1,sr3.pmde002_2,'pmda002')RETURNING l_pmdc002 #如果相等表示有變更
                    CALL apmr410_g01_pmdc_chg(sr3.pmde002_1,sr3.pmde002_2,'pmda003')RETURNING l_pmdc003 
                    CALL apmr410_g01_pmdc_chg(sr3.pmde002_1,sr3.pmde002_2,'pmda006')RETURNING l_pmdc006 
                    CALL apmr410_g01_pmdc_chg(sr3.pmde002_1,sr3.pmde002_2,'pmda007')RETURNING l_pmdc007 
                    CALL apmr410_g01_pmdc_chg(sr3.pmde002_1,sr3.pmde002_2,'pmda005')RETURNING l_pmdc005 
                    CALL apmr410_g01_pmdc_chg(sr3.pmde002_1,sr3.pmde002_2,'pmda010')RETURNING l_pmdc010 
                   
                    IF l_pmdc002 != 0 THEN LET l_pmdc002_btl = 0.5 END IF
                    IF l_pmdc003 != 0 THEN LET l_pmdc003_btl = 0.5 END IF
                    IF l_pmdc006 != 0 THEN LET l_pmdc006_btl = 0.5 END IF 
                    IF l_pmdc007 != 0 THEN LET l_pmdc007_btl = 0.5 END IF                    
                    IF l_pmdc005 != 0 THEN LET l_pmdc005_btl = 0.5 END IF #幣別         
                    IF l_pmdc010 != 0 THEN LET l_pmdc010_btl = 0.5 END IF
                                    
                    OUTPUT TO REPORT apmr410_g01_subrep05(sr3.*)
                    
                    LET l_i = l_i + 2
                    IF l_i > l_ac THEN
                       EXIT WHILE
                    END IF
                 END  WHILE
              END IF
           FINISH REPORT apmr410_g01_subrep05
           PRINTX l_subrep05_show
           PRINTX l_pmdc002_btl
           PRINTX l_pmdc003_btl
           PRINTX l_pmdc006_btl
           PRINTX l_pmdc007_btl
           PRINTX l_pmdc005_btl
           PRINTX l_pmdc010_btl
     
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           #161031-00025#9 mod-S
#           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooffent = '", 
#                        sr1.pmdcent CLIPPED ,"'", " AND  ooff002 = '", sr1.pmdcdocno CLIPPED ,"'"," AND ooff003 = '",sr1.pmdc900 CLIPPED,"' "
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooffent = '", 
                        sr1.pmdcent CLIPPED ,"'", " AND  ooff003 = '", sr1.pmdcdocno CLIPPED ,"'"," AND ooff004 = ",sr1.pmdc900 CLIPPED
           #161031-00025#9 mod-E
#           #end add-point:rep.sub01.sql
# 
#           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
#                sr1.pmdcent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_order CLIPPED ,"'"
# 
#           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE apmr410_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE apmr410_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT apmr410_g01_subrep01
           DECLARE apmr410_g01_repcur01 CURSOR FROM g_sql
           FOREACH apmr410_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "apmr410_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT apmr410_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT apmr410_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.l_order.after name="rep.b_group.l_order.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.pmddseq
 
           #add-point:rep.b_group.pmddseq.before name="rep.b_group.pmddseq.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.pmddseq.after name="rep.b_group.pmddseq.after"
           
           #end add-point:
 
 
 
 
       ON EVERY ROW
          #add-point:rep.everyrow.before name="rep.everyrow.before"
          #若允許提前交貨(pmdd042='N')時，則列印'不允許提前交貨'
          IF sr1.pmdd042 = 'N' THEN
              LET l_pmdd042_show = "Y"
          ELSE
              LET l_pmdd042_show = "N"
          END IF
        
          #若允許提前交貨(pmdd041='N')時，則列印'不允許部分交貨'
          IF sr1.pmdd041 = 'N' THEN
              LET l_pmdd041_show = "Y"
          ELSE
              LET l_pmdd041_show = "N"
          END IF
          
          PRINTX l_pmdd042_show,l_pmdd041_show
          #end add-point:rep.everyrow.before
 
          #單身前備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub02.before name="rep.sub02.before"
           
           #end add-point:rep.sub02.before
 
           #add-point:rep.sub02.sql name="rep.sub02.sql"
           #161031-00025#9 mod-S
#           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='2' AND ooffent = '", 
#                sr1.pmdcent CLIPPED ,"'"," AND  ooff002 = '", sr1.pmdcdocno CLIPPED ,"'", " AND  ooff003 = '", sr1.pmdc900 CLIPPED ,"'",
#                 "AND ooff004 = '", sr1.pmddseq CLIPPED ,"' "
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='2' AND ooffent = '", 
                sr1.pmdcent CLIPPED ,"'"," AND  ooff003 = '", sr1.pmdcdocno CLIPPED ,"'", " AND  ooff004 = ", sr1.pmdc900 CLIPPED ,
                 "AND ooff005 = ", sr1.pmddseq CLIPPED 
           #161031-00025#9 mod-E
#           #end add-point:rep.sub02.sql
# 
#           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='2' AND ooffent = '", 
#                sr1.pmdcent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_order CLIPPED ,"'", " AND  ooff004 = ", 
#                sr1.pmddseq CLIPPED ,""
# 
#           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE apmr410_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE apmr410_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT apmr410_g01_subrep02
           DECLARE apmr410_g01_repcur02 CURSOR FROM g_sql
           FOREACH apmr410_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "apmr410_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT apmr410_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT apmr410_g01_subrep02
           #add-point:rep.sub02.after name="rep.sub02.after"
           
           #end add-point:rep.sub02.after
 
 
 
          #add-point:rep.everyrow.beforerow name="rep.everyrow.beforerow"
          #單頭變更備註隱藏
          CALL apmr410_g01_show(sr1.pmdc906,'','') RETURNING l_pmdc906_show
          #單身產品特徵
          CALL apmr410_g01_show(sr1.pmdd005,'','') RETURNING l_pmdd005_show        
          #單身變更備註
          CALL apmr410_g01_show(sr1.pmdd903,'','') RETURNING l_pmdd903_show
                   
          PRINTX l_pmdc906_show
          PRINTX l_pmdd005_show
          PRINTX l_pmdd903_show

          #end add-point:rep.everyrow.beforerow
            
          PRINTX sr1.*
 
          #add-point:rep.everyrow.afterrow name="rep.everyrow.afterrow"
          #單身子報表
          START REPORT apmr410_g01_subrep06 
             LET l_subrep06_show ='Y' 
             LET l_pmdd_show ='Y'             
             LET l_count = 0
         
             #料號 
             CALL apmr410_g01_chg(sr1.pmdcent,sr1.pmdcdocno,sr1.pmddseq,sr1.pmdc900,'pmdb004') RETURNING sr5.pmdd004,l_cnt                                              
             LET l_pmdd004_btl = 0.5             
             IF l_cnt = 0 THEN 
                LET l_pmdd004_btl = 0
                LET sr5.pmdd004 = sr1.pmdd004
                LET sr5.imaal003 = sr1.x_t10_imaal003
                LET sr5.imaal004 = sr1.x_t10_imaal004  
                LET l_count = l_count + 1
             ELSE
                CALL s_desc_get_item_desc(sr5.pmdd004)RETURNING sr5.imaal003,sr5.imaal004
             END IF          
             #產品特徵
             CALL apmr410_g01_chg(sr1.pmdcent,sr1.pmdcdocno,sr1.pmddseq,sr1.pmdc900,'pmdb005') RETURNING sr5.pmdd005,l_cnt
             CALL apmr410_g01_show(sr5.pmdd005,'','') RETURNING sr5.pmdd005_show  
             LET l_pmdd005_btl = 0.5              
             IF l_cnt = 0 THEN 
                LET l_pmdd005_btl = 0
                LET sr5.pmdd005 = sr1.pmdd005 
                LET l_count = l_count + 1  
                CALL apmr410_g01_show(sr5.pmdd005,'','') RETURNING sr5.pmdd005_show                
             END IF
             #需求數量
             CALL apmr410_g01_chg(sr1.pmdcent,sr1.pmdcdocno,sr1.pmddseq,sr1.pmdc900,'pmdb006') RETURNING sr5.pmdd006,l_cnt
             LET l_pmdd006_btl = 0.5              
             IF l_cnt = 0 THEN 
                LET l_pmdd006_btl = 0
                LET sr5.pmdd006 = sr1.pmdd006 
                LET l_count = l_count + 1            
             END IF
             #單位
             CALL apmr410_g01_chg(sr1.pmdcent,sr1.pmdcdocno,sr1.pmddseq,sr1.pmdc900,'pmdb007') RETURNING sr5.pmdd007,l_cnt
             LET l_pmdd007_btl = 0.5              
             IF l_cnt = 0 THEN
                LET l_pmdd007_btl = 0
                LET sr5.pmdd007 = sr1.pmdd007 
                LET l_count = l_count + 1            
             END IF
             #需求日期
             CALL apmr410_g01_chg(sr1.pmdcent,sr1.pmdcdocno,sr1.pmddseq,sr1.pmdc900,'pmdb030') RETURNING sr5.pmdd030,l_cnt
             LET l_pmdd030_btl = 0.5              
             IF l_cnt = 0 THEN
                LET l_pmdd030_btl = 0
                LET sr5.pmdd030 = sr1.pmdd030 
                LET l_count = l_count + 1            
             END IF
             #緊急度
             CALL apmr410_g01_chg(sr1.pmdcent,sr1.pmdcdocno,sr1.pmddseq,sr1.pmdc900,'pmdb033') RETURNING sr5.pmdd033,l_cnt
             LET l_pmdd033_btl = 0.5              
             IF l_cnt = 0 THEN
                LET l_pmdd033_btl = 0
                LET sr5.pmdd033 = sr1.pmdd033
                LET sr5.pmdd033_desc = sr1.l_pmdd033_desc                  
                LET l_count = l_count + 1  
             ELSE
                CALL s_desc_gzcbl004_desc('2036',sr5.pmdd033)RETURNING sr5.pmdd033_desc    #緊急度說明            
             END IF   
             #供應商選擇             
             CALL apmr410_g01_chg(sr1.pmdcent,sr1.pmdcdocno,sr1.pmddseq,sr1.pmdc900,'pmdb014') RETURNING sr5.pmdd014,l_cnt      
             LET  l_pmdd014_btl = 0.5             
             IF l_cnt = 0 THEN
                LET l_pmdd014_btl = 0
                LET sr5.pmdd014 = sr1.pmdd014
                CALL s_desc_gzcbl004_desc(2037,sr5.pmdd014)RETURNING sr5.pmdd014_desc                   
                LET l_count = l_count + 1               
             ELSE 
                CALL s_desc_gzcbl004_desc(2037,sr5.pmdd014)RETURNING sr5.pmdd014_desc                  
             END IF 
             #供應商名稱             
             CALL apmr410_g01_chg(sr1.pmdcent,sr1.pmdcdocno,sr1.pmddseq,sr1.pmdc900,'pmdb015') RETURNING sr5.pmdd015,l_cnt       
             LET  l_pmdd015_btl = 0.5             
             IF l_cnt = 0 THEN
                LET l_pmdd015_btl = 0
                LET sr5.pmdd015 = sr1.pmdd015
                LET sr5.pmdd015_pmaal003 = sr1.l_pmdd015_pmaal003            
                LET l_count = l_count + 1    
             ELSE
                CALL s_desc_get_trading_partner_abbr_desc(sr5.pmdd015)RETURNING sr5.pmdd015_pmaal003
                LET sr5.pmdd015_pmaal003 = '指定供應商:',sr5.pmdd014_desc CLIPPED,'.',sr5.pmdd015,'.',sr5.pmdd015_pmaal003
                IF cl_null(sr5.pmdd015) THEN
                   LET sr5.pmdd015_pmaal003 = ' '
                END IF                 
             END IF                                     
            
             
             #付款條件 
             CALL apmr410_g01_chg(sr1.pmdcent,sr1.pmdcdocno,sr1.pmddseq,sr1.pmdc900,'pmdb016') RETURNING sr5.pmdd016,l_cnt            
             LET l_pmdd016_btl = 0.5              
             IF l_cnt = 0 THEN
                LET l_pmdd016_btl = 0
                LET sr5.pmdd016 = sr1.pmdd016
                LET sr5.pmdd016_desc = sr1.l_pmdd016_desc                      
                LET l_count = l_count + 1 
             ELSE
                CALL s_desc_get_ooib002_desc(sr5.pmdd016)RETURNING sr5.pmdd016_desc
                LET sr5.pmdd016_desc = '付款條件',sr5.pmdd016_desc  
                IF cl_null(sr5.pmdd016) THEN 
                   LET sr5.pmdd016_desc =' '
                END IF                   
             END IF      
             #交易條件 
             CALL apmr410_g01_chg(sr1.pmdcent,sr1.pmdcdocno,sr1.pmddseq,sr1.pmdc900,'pmdb017') RETURNING sr5.pmdd017,l_cnt
             LET l_pmdd017_btl = 0.5              
             IF l_cnt = 0 THEN
                LET l_pmdd017_btl = 0
                LET sr5.pmdd017 = sr1.pmdd017
                LET sr5.pmdd017_desc = sr1.l_pmdd017_desc                 
                LET l_count = l_count + 1 
             ELSE
                CALL s_desc_get_acc_desc(238,sr5.pmdd017)RETURNING sr5.pmdd017_desc  
                LET sr5.pmdd017_desc = '交易條件',sr5.pmdd017_desc 
                IF cl_null(sr5.pmdd017) THEN 
                   LET sr5.pmdd017_desc =' '
                END IF                
             END IF 
             #不允許提前交貨
             CALL apmr410_g01_chg(sr1.pmdcent,sr1.pmdcdocno,sr1.pmddseq,sr1.pmdc900,'pmdb042') RETURNING sr5.pmdd042,l_cnt
             IF sr5.pmdd042 = 'N' THEN
                   LET sr5.pmdd042_desc = '不允許提前交貨'
                ELSE
                   LET sr5.pmdd042_desc = ' '
                END IF        
             LET l_pmdd042_btl = 0.5               
             IF l_cnt = 0 THEN
                LET l_pmdd042_btl = 0
                LET sr5.pmdd042 = sr1.pmdd042 
                LET sr5.pmdd042_desc = sr1.l_pmdd042_desc                    
                LET l_count = l_count + 1                  
             END IF
             #不允許部分交貨             
             CALL apmr410_g01_chg(sr1.pmdcent,sr1.pmdcdocno,sr1.pmddseq,sr1.pmdc900,'pmdb041') RETURNING sr5.pmdd041,l_cnt
             IF sr5.pmdd041 = 'N' THEN
                LET sr5.pmdd041_desc = '不允許部分交貨'
             ELSE
                LET sr5.pmdd041_desc = ' '
             END IF
             LET l_pmdd041_btl = 0.5              
             IF l_cnt = 0 THEN
                LET l_pmdd041_btl = 0
                LET sr5.pmdd041 = sr1.pmdd041 
                LET sr5.pmdd041_desc = sr1.l_pmdd041_desc                   
                LET l_count = l_count + 1                                  
             END IF 
             IF l_count = 12 THEN
                LET l_subrep06_show ='N'
                IF tm.a1 = 'Y' THEN
                   LET l_pmdd_show ='N'
                END IF
             END IF                
          OUTPUT TO REPORT apmr410_g01_subrep06(sr5.*)
          FINISH REPORT apmr410_g01_subrep06
          PRINTX l_subrep06_show
          PRINTX l_pmdd_show
          PRINTX l_pmdd004_btl
          PRINTX l_pmdd005_btl
          PRINTX l_pmdd006_btl
          PRINTX l_pmdd007_btl
          PRINTX l_pmdd030_btl
          PRINTX l_pmdd033_btl
          PRINTX l_pmdd015_btl
          PRINTX l_pmdd016_btl
          PRINTX l_pmdd017_btl
          PRINTX l_pmdd042_btl
          PRINTX l_pmdd041_btl
          #end add-point:rep.everyrow.afterrow
 
          #單身後備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub03.before name="rep.sub03.before"
           
           #end add-point:rep.sub03.before
 
           #add-point:rep.sub03.sql name="rep.sub03.sql"
           #161031-00025#9 mod-S
#           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooffent = '", 
#                sr1.pmdcent CLIPPED ,"'"," AND  ooff002 = '", sr1.pmdcdocno CLIPPED ,"'", " AND  ooff003 = '", sr1.pmdc900 CLIPPED ,"'",
#                 "AND ooff004 = '", sr1.pmddseq CLIPPED ,"' "
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooffent = '", 
                sr1.pmdcent CLIPPED ,"'"," AND  ooff003 = '", sr1.pmdcdocno CLIPPED ,"'", " AND  ooff004 = ", sr1.pmdc900 CLIPPED ,
                 "AND ooff005 = ", sr1.pmddseq CLIPPED 
           #161031-00025#9 mod-E
#           #end add-point:rep.sub03.sql
# 
#           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooffent = '", 
#                sr1.pmdcent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_order CLIPPED ,"'", " AND  ooff004 = ", 
#                sr1.pmddseq CLIPPED ,""
# 
#           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE apmr410_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE apmr410_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT apmr410_g01_subrep03
           DECLARE apmr410_g01_repcur03 CURSOR FROM g_sql
           FOREACH apmr410_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "apmr410_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT apmr410_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT apmr410_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.l_order
 
           #add-point:rep.a_group.l_order.before name="rep.a_group.l_order.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           #161031-00025#9 mod-S
#           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooffent = '", 
#                sr1.pmdcent CLIPPED ,"'", " AND  ooff002 = '", sr1.pmdcdocno CLIPPED ,"'", " AND ooff003 ='",sr1.pmdc900 CLIPPED,"' "
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooffent = '", 
                sr1.pmdcent CLIPPED ,"'", " AND  ooff003 = '", sr1.pmdcdocno CLIPPED ,"'", " AND ooff004 = ",sr1.pmdc900 CLIPPED," "
           #161031-00025#9 mod-E
#           #end add-point:rep.sub04.sql
# 
#           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
#                sr1.pmdcent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_order CLIPPED ,"'"
# 
#           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE apmr410_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE apmr410_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT apmr410_g01_subrep04
           DECLARE apmr410_g01_repcur04 CURSOR FROM g_sql
           FOREACH apmr410_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "apmr410_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT apmr410_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT apmr410_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.l_order.after name="rep.a_group.l_order.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.pmddseq
 
           #add-point:rep.a_group.pmddseq.before name="rep.a_group.pmddseq.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.pmddseq.after name="rep.a_group.pmddseq.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="apmr410_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT apmr410_g01_subrep01(sr2)
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
PRIVATE REPORT apmr410_g01_subrep02(sr2)
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
PRIVATE REPORT apmr410_g01_subrep03(sr2)
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
PRIVATE REPORT apmr410_g01_subrep04(sr2)
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
 
{<section id="apmr410_g01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 稅別說明
# Memo...........:
# Usage..........: apmr410_g01_oodc010_ref(p_oodbl002)
# Input parameter: p_oodbl002 稅別編號
# Return code....: r_oodbl004 稅別說明
# Date & Author..: 20140730 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION apmr410_g01_oodc010_ref(p_oodbl002)
DEFINE r_oodbl004 LIKE oodbl_t.oodbl004 #說明
DEFINE p_oodbl002 LIKE oodbl_t.oodbl002 #代碼
  
   SELECT oodbl004 INTO r_oodbl004
     FROM oodbl_t,ooef_t
    WHERE ooef001 = g_site 
     AND oodblent = g_enterprise
     AND oodbl001 = ooef019
     AND oodbl002 = p_oodbl002
     AND oodbl003 = g_dlang
  
   RETURN  r_oodbl004

END FUNCTION

################################################################################
# Descriptions...: 欄位說明
# Memo...........:
# Usage..........: CALL apmr410_g01_pmde002_ref(p_pmde002)
# Input parameter: p_pmde002  欄位
# Return code....: r_pmde002_desc 說明
# Date & Author..: 20140801 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION apmr410_g01_pmde002_ref(p_pmde002)
DEFINE p_pmde002         LIKE pmde_t.pmde002
DEFINE r_pmde002_desc    LIKE dzeb_t.dzeb003
   
 SELECT dzebl003 INTO r_pmde002_desc
     FROM dzebl_t
    WHERE dzebl001 = p_pmde002    
      AND dzebl002 = g_dlang
   RETURN r_pmde002_desc


END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION apmr410_g01_chg(p_pmdeent,p_pmdedocno,p_pmdeseq,p_pmde001,p_pmde002)
DEFINE r_pmde004   LIKE pmde_t.pmde004   #變更前內容
DEFINE p_pmdeent   LIKE pmde_t.pmdeent   
DEFINE p_pmdedocno LIKE pmde_t.pmdedocno #單號
DEFINE p_pmdeseq   LIKE pmde_t.pmdeseq   #請購項次
DEFINE p_pmde001   LIKE pmde_t.pmde001   #變更序
DEFINE p_pmde002   LIKE pmde_t.pmde002   #變更欄位
DEFINE r_cnt       LIKE type_t.num5

   LET r_pmde004  = ''
   LET r_cnt = 0
   
   SELECT COUNT(*) INTO r_cnt
     FROM pmde_t 
    WHERE pmdeent    = p_pmdeent
      AND pmdedocno  = p_pmdedocno
      AND pmdeseq    = p_pmdeseq
      AND pmde001    = p_pmde001 
      AND pmde002    = p_pmde002
      
   IF r_cnt ! =0 THEN 
      SELECT pmde004 INTO r_pmde004 
        FROM pmde_t 
       WHERE pmdeent    = p_pmdeent
         AND pmdedocno  = p_pmdedocno
         AND pmdeseq    = p_pmdeseq
         AND pmde001    = p_pmde001
         AND pmde002    = p_pmde002
   END IF

      RETURN r_pmde004,r_cnt
END FUNCTION

################################################################################
# Descriptions...: 單頭變更底線
# Memo...........:
# Usage..........: CALL apmr410_g01_pmdc_chg(p_pmde002,p_pmde002_2,p_pmde002_3)
# Input parameter: p_pmde002    變更欄位
#                  p_pmde002_2  變更欄位
#                  p_pmde002_3  訂單欄位
# Return code....: 0/0.5
# Date & Author..: 2014/07/30 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION apmr410_g01_pmdc_chg(p_pmde002,p_pmde002_2,p_pmde002_3)
DEFINE p_pmde002   LIKE pmde_t.pmde002
DEFINE p_pmde002_2 LIKE pmde_t.pmde002
DEFINE p_pmde002_3 LIKE pmde_t.pmde002

 IF p_pmde002 = p_pmde002_3 OR p_pmde002_2 = p_pmde002_3 THEN
    RETURN 0.5
 ELSE
    RETURN 0
 END IF
END FUNCTION

################################################################################
# Descriptions...: 欄位隱藏
# Memo...........:
# Usage..........: CALL apmr410_g01_show(p_arg1,p_arg2,p_arg3)
# Input parameter: p_arg1
#                  p_arg2
#                  p_arg3
# Return code....: r_show
# Date & Author..: 20140801 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION apmr410_g01_show(p_arg1,p_arg2,p_arg3)
   DEFINE p_arg1 LIKE type_t.chr1000
   DEFINE p_arg2 LIKE type_t.chr1000
   DEFINE p_arg3 LIKE type_t.chr1000
   DEFINE r_show LIKE type_t.chr1

     IF cl_null(p_arg1) AND cl_null(p_arg2) AND cl_null(p_arg3) THEN
        LET r_show = "N"
     ELSE
        LET r_show = "Y"
     END IF
     RETURN r_show
     
END FUNCTION

 
{</section>}
 
{<section id="apmr410_g01.other_report" readonly="Y" >}
################################################################################
# Descriptions...: 變更資料子報表
# Memo...........:
# Usage..........: CALL apmr410_g01_subrep05(sr3)
#                
# Input parameter: sr3            資料RECORD
#                : 
# Return code....: 
#                : 
# Date & Author..: 2014/06/20 By zechs
# Modify.........:
################################################################################
PRIVATE REPORT apmr410_g01_subrep05(sr3)
DEFINE sr3             sr3_r
   FORMAT 
        ON EVERY ROW
           PRINTX g_grNumFmt.*
           PRINTX sr3.*
END REPORT

################################################################################
# Descriptions...: 單身子報表
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
# Date & Author..: 20140730 By Hans
# Modify.........:
################################################################################
PRIVATE REPORT apmr410_g01_subrep06(sr5)
DEFINE sr5             sr5_r    
    FORMAT
           
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr5.*
END REPORT

 
{</section>}
 
