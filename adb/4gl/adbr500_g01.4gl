#該程式未解開Section, 採用最新樣板產出!
{<section id="adbr500_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2016-06-28 11:30:39), PR版次:0003(2016-06-28 16:26:46)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000067
#+ Filename...: adbr500_g01
#+ Description: ...
#+ Creator....: 02159(2015-01-26 15:21:49)
#+ Modifier...: 06137 -SD/PR- 06137
 
{</section>}
 
{<section id="adbr500_g01.global" readonly="Y" >}
#報表 g01 樣板自動產生(Version:13)
#add-point:填寫註解說明 name="global.memo"

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
   xmda001 LIKE xmda_t.xmda001, 
   xmda002 LIKE xmda_t.xmda002, 
   xmda003 LIKE xmda_t.xmda003, 
   xmda004 LIKE xmda_t.xmda004, 
   xmda005 LIKE xmda_t.xmda005, 
   xmda006 LIKE xmda_t.xmda006, 
   xmda007 LIKE xmda_t.xmda007, 
   xmda008 LIKE xmda_t.xmda008, 
   xmda009 LIKE xmda_t.xmda009, 
   xmda010 LIKE xmda_t.xmda010, 
   xmda011 LIKE xmda_t.xmda011, 
   xmda012 LIKE xmda_t.xmda012, 
   xmda013 LIKE xmda_t.xmda013, 
   xmda015 LIKE xmda_t.xmda015, 
   xmda016 LIKE xmda_t.xmda016, 
   xmda017 LIKE xmda_t.xmda017, 
   xmda018 LIKE xmda_t.xmda018, 
   xmda019 LIKE xmda_t.xmda019, 
   xmda020 LIKE xmda_t.xmda020, 
   xmda021 LIKE xmda_t.xmda021, 
   xmda022 LIKE xmda_t.xmda022, 
   xmda023 LIKE xmda_t.xmda023, 
   xmda024 LIKE xmda_t.xmda024, 
   xmda025 LIKE xmda_t.xmda025, 
   xmda026 LIKE xmda_t.xmda026, 
   xmda027 LIKE xmda_t.xmda027, 
   xmda028 LIKE xmda_t.xmda028, 
   xmda030 LIKE xmda_t.xmda030, 
   xmda031 LIKE xmda_t.xmda031, 
   xmda032 LIKE xmda_t.xmda032, 
   xmda033 LIKE xmda_t.xmda033, 
   xmda034 LIKE xmda_t.xmda034, 
   xmda035 LIKE xmda_t.xmda035, 
   xmda036 LIKE xmda_t.xmda036, 
   xmda039 LIKE xmda_t.xmda039, 
   xmda041 LIKE xmda_t.xmda041, 
   xmda042 LIKE xmda_t.xmda042, 
   xmda043 LIKE xmda_t.xmda043, 
   xmda045 LIKE xmda_t.xmda045, 
   xmda046 LIKE xmda_t.xmda046, 
   xmda047 LIKE xmda_t.xmda047, 
   xmda048 LIKE xmda_t.xmda048, 
   xmda049 LIKE xmda_t.xmda049, 
   xmda071 LIKE xmda_t.xmda071, 
   xmda200 LIKE xmda_t.xmda200, 
   xmda201 LIKE xmda_t.xmda201, 
   xmda202 LIKE xmda_t.xmda202, 
   xmda203 LIKE xmda_t.xmda203, 
   xmda204 LIKE xmda_t.xmda204, 
   xmda205 LIKE xmda_t.xmda205, 
   xmda206 LIKE xmda_t.xmda206, 
   xmda207 LIKE xmda_t.xmda207, 
   xmda208 LIKE xmda_t.xmda208, 
   xmda209 LIKE xmda_t.xmda209, 
   xmda210 LIKE xmda_t.xmda210, 
   xmda211 LIKE xmda_t.xmda211, 
   xmda213 LIKE xmda_t.xmda213, 
   xmdadocdt LIKE xmda_t.xmdadocdt, 
   xmdadocno LIKE xmda_t.xmdadocno, 
   xmdaent LIKE xmda_t.xmdaent, 
   xmdasite LIKE xmda_t.xmdasite, 
   xmdastus LIKE xmda_t.xmdastus, 
   xmdaunit LIKE xmda_t.xmdaunit, 
   xmja001 LIKE xmja_t.xmja001, 
   xmja002 LIKE xmja_t.xmja002, 
   xmja003 LIKE xmja_t.xmja003, 
   xmja004 LIKE xmja_t.xmja004, 
   xmja005 LIKE xmja_t.xmja005, 
   xmja006 LIKE xmja_t.xmja006, 
   xmja007 LIKE xmja_t.xmja007, 
   xmja008 LIKE xmja_t.xmja008, 
   xmja009 LIKE xmja_t.xmja009, 
   xmja010 LIKE xmja_t.xmja010, 
   xmja011 LIKE xmja_t.xmja011, 
   xmja012 LIKE xmja_t.xmja012, 
   xmja013 LIKE xmja_t.xmja013, 
   xmja014 LIKE xmja_t.xmja014, 
   xmja015 LIKE xmja_t.xmja015, 
   xmja016 LIKE xmja_t.xmja016, 
   xmja017 LIKE xmja_t.xmja017, 
   xmja018 LIKE xmja_t.xmja018, 
   xmja019 LIKE xmja_t.xmja019, 
   xmja020 LIKE xmja_t.xmja020, 
   xmja021 LIKE xmja_t.xmja021, 
   xmja022 LIKE xmja_t.xmja022, 
   xmja024 LIKE xmja_t.xmja024, 
   xmja025 LIKE xmja_t.xmja025, 
   xmja026 LIKE xmja_t.xmja026, 
   xmja027 LIKE xmja_t.xmja027, 
   xmja028 LIKE xmja_t.xmja028, 
   xmja029 LIKE xmja_t.xmja029, 
   xmja030 LIKE xmja_t.xmja030, 
   xmja031 LIKE xmja_t.xmja031, 
   xmja032 LIKE xmja_t.xmja032, 
   xmja033 LIKE xmja_t.xmja033, 
   xmja034 LIKE xmja_t.xmja034, 
   xmja037 LIKE xmja_t.xmja037, 
   xmja038 LIKE xmja_t.xmja038, 
   xmja039 LIKE xmja_t.xmja039, 
   xmja040 LIKE xmja_t.xmja040, 
   xmjaseq LIKE xmja_t.xmjaseq, 
   xmjasite LIKE xmja_t.xmjasite, 
   xmjaunit LIKE xmja_t.xmjaunit, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   t2_ooefl003 LIKE ooefl_t.ooefl003, 
   t3_ooefl003 LIKE ooefl_t.ooefl003, 
   t8_ooefl003 LIKE ooefl_t.ooefl003, 
   x_t27_ooefl003 LIKE ooefl_t.ooefl003, 
   t14_pmaal003 LIKE pmaal_t.pmaal003, 
   t1_pmaal004 LIKE pmaal_t.pmaal004, 
   t7_pmaal004 LIKE pmaal_t.pmaal004, 
   t10_pmaal004 LIKE pmaal_t.pmaal004, 
   t11_pmaal004 LIKE pmaal_t.pmaal004, 
   pmaal_t_pmaal004 LIKE pmaal_t.pmaal004, 
   t17_pmaal004 LIKE pmaal_t.pmaal004, 
   t15_pmaal004 LIKE pmaal_t.pmaal004, 
   t16_pmaal004 LIKE pmaal_t.pmaal004, 
   x_t22_pmaal004 LIKE pmaal_t.pmaal004, 
   x_t23_pmaal004 LIKE pmaal_t.pmaal004, 
   ooibl_t_ooibl004 LIKE ooibl_t.ooibl004, 
   oocql_t_oocql004 LIKE oocql_t.oocql004, 
   t9_oocql004 LIKE oocql_t.oocql004, 
   t12_oocql004 LIKE oocql_t.oocql004, 
   t13_oocql004 LIKE oocql_t.oocql004, 
   ooail_t_ooail003 LIKE ooail_t.ooail003, 
   pmaml_t_pmaml003 LIKE pmaml_t.pmaml003, 
   ooidl_t_ooidl003 LIKE ooidl_t.ooidl003, 
   oojdl_t_oojdl003 LIKE oojdl_t.oojdl003, 
   oofa_t_oofa011 LIKE oofa_t.oofa011, 
   prcfl_t_prcfl003 LIKE prcfl_t.prcfl003, 
   x_t18_prcfl003 LIKE prcfl_t.prcfl003, 
   dbadl_t_dbadl003 LIKE dbadl_t.dbadl003, 
   x_t21_dbadl003 LIKE dbadl_t.dbadl003, 
   dbabl_t_dbabl003 LIKE dbabl_t.dbabl003, 
   dbaal_t_dbaal003 LIKE dbaal_t.dbaal003, 
   t4_dbaal003 LIKE dbaal_t.dbaal003, 
   t5_dbaal003 LIKE dbaal_t.dbaal003, 
   t6_dbaal003 LIKE dbaal_t.dbaal003, 
   x_t19_dbaal003 LIKE dbaal_t.dbaal003, 
   x_t20_dbaal003 LIKE dbaal_t.dbaal003, 
   x_t28_dbaal003 LIKE dbaal_t.dbaal003, 
   x_t29_dbaal003 LIKE dbaal_t.dbaal003, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   x_oocal_t_oocal003 LIKE oocal_t.oocal003, 
   x_t24_oocal003 LIKE oocal_t.oocal003, 
   x_t25_oocal003 LIKE oocal_t.oocal003, 
   x_t26_oocal003 LIKE oocal_t.oocal003, 
   l_xmdaunit_ooefl003 LIKE type_t.chr1000, 
   l_xmda200_pmaal004 LIKE type_t.chr100, 
   l_xmda036_pmaal004 LIKE type_t.chr100, 
   l_xmda201_pmaal004 LIKE type_t.chr100, 
   l_xmda004_pmaal004 LIKE type_t.chr100, 
   l_xmda034_pmaal003 LIKE type_t.chr300, 
   l_xmda022_pmaal004 LIKE type_t.chr100, 
   l_xmda021_pmaal004 LIKE type_t.chr100, 
   l_xmda004_t1_pmaal004 LIKE type_t.chr100, 
   l_xmda003_ooefl003 LIKE type_t.chr1000, 
   l_xmdasite_ooefl003 LIKE type_t.chr1000, 
   l_xmda002_ooag011 LIKE type_t.chr300, 
   l_xmda204_prcfl003 LIKE type_t.chr1000, 
   l_xmda203_pmaal004 LIKE type_t.chr100, 
   l_xmda202_ooefl003 LIKE type_t.chr1000, 
   l_xmja005_prcfl003 LIKE type_t.chr1000, 
   l_xmja024_pmaal004 LIKE type_t.chr100, 
   l_xmja025_pmaal004 LIKE type_t.chr100, 
   l_xmjasite_ooefl003 LIKE type_t.chr1000, 
   l_imaal003 LIKE imaal_t.imaal003, 
   l_imaal004 LIKE imaal_t.imaal004, 
   l_xmja025_desc LIKE type_t.chr1000, 
   l_xmdc007 LIKE xmdc_t.xmdc007, 
   l_xmdc006 LIKE xmdc_t.xmdc006, 
   l_xmdc015 LIKE xmdc_t.xmdc015, 
   l_xmda023_oojdl003 LIKE type_t.chr100
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING,                  #where condition 
       a2 LIKE type_t.chr1,         #分批交期明細 
       a3 LIKE type_t.chr1          #顯示訂單備註
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
   xmdbdocno      LIKE xmdb_t.xmdbdocno,
   xmdb001        LIKE xmdb_t.xmdb001,
   xmdb002        LIKE xmdb_t.xmdb002,
   l_xmdb002_desc LIKE ooibl_t.ooibl004,
   xmdb003        LIKE xmdb_t.xmdb003,
   xmdb004        LIKE xmdb_t.xmdb004,
   xmdb005        LIKE xmdb_t.xmdb005,
   xmdb006        LIKE xmdb_t.xmdb006
END RECORD
 TYPE sr4_r RECORD
   xmdddocno      LIKE xmdd_t.xmdddocno,
   xmddseq        LIKE xmdd_t.xmddseq,
   xmddseq1       LIKE xmdd_t.xmddseq1,
   xmddseq2       LIKE xmdd_t.xmddseq2,
   xmdd001        LIKE xmdd_t.xmdd001,
   xmdd002        LIKE xmdd_t.xmdd002,
   xmdd003        LIKE xmdd_t.xmdd003,
   xmdd004        LIKE xmdd_t.xmdd004,
   xmdd006        LIKE xmdd_t.xmdd006,
   xmdd011        LIKE xmdd_t.xmdd011,
   imaal003       LIKE imaal_t.imaal003,
   imaal004       LIKE imaal_t.imaal004,
   l_xmdd003_desc LIKE type_t.chr80,
   l_item_show    LIKE type_t.chr1
END RECORD
DEFINE g_sql_cnt  STRING
DEFINE g_cnt      LIKE type_t.num5
#end add-point
 
{</section>}
 
{<section id="adbr500_g01.main" readonly="Y" >}
PUBLIC FUNCTION adbr500_g01(p_arg1,p_arg2,p_arg3)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr1         #tm.a2  分批交期明細 
DEFINE  p_arg3 LIKE type_t.chr1         #tm.a3  顯示訂單備註
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.a2 = p_arg2
   LET tm.a3 = p_arg3
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "adbr500_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL adbr500_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL adbr500_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL adbr500_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="adbr500_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION adbr500_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   LET g_select = " SELECT xmda001,xmda002,xmda003,xmda004,xmda005,xmda006,xmda007,xmda008,xmda009,xmda010, 
       xmda011,xmda012,xmda013,xmda015,xmda016,xmda017,xmda018,xmda019,xmda020,xmda021,xmda022,xmda023, 
       xmda024,xmda025,xmda026,xmda027,xmda028,xmda030,xmda031,xmda032,xmda033,xmda034,xmda035,xmda036, 
       xmda039,xmda041,xmda042,xmda043,xmda045,xmda046,xmda047,xmda048,xmda049,xmda071,xmda200,xmda201, 
       xmda202,xmda203,xmda204,xmda205,xmda206,xmda207,xmda208,xmda209,xmda210,xmda211,xmda213,xmdadocdt, 
       xmdadocno,xmdaent,xmdasite,xmdastus,xmdaunit,xmja001,xmja002,xmja003,xmja004,xmja005,xmja006, 
       xmja007,xmja008,xmja009,xmja010,xmja011,xmja012,xmja013,xmja014,xmja015,xmja016,xmja017,xmja018, 
       xmja019,xmja020,xmja021,xmja022,xmja024,xmja025,xmja026,xmja027,xmja028,xmja029,xmja030,xmja031, 
       xmja032,xmja033,xmja034,xmja037,xmja038,xmja039,xmja040,xmjaseq,xmjasite,xmjaunit,ooag_t.ooag011, 
       ooefl_t.ooefl003,t2.ooefl003,t3.ooefl003,t8.ooefl003,x.t27_ooefl003,t14.pmaal003,t1.pmaal004, 
       t7.pmaal004,t10.pmaal004,t11.pmaal004,pmaal_t.pmaal004,t17.pmaal004,t15.pmaal004,t16.pmaal004, 
       x.t22_pmaal004,x.t23_pmaal004,ooibl_t.ooibl004,oocql_t.oocql004,t9.oocql004,t12.oocql004,t13.oocql004, 
       ooail_t.ooail003,pmaml_t.pmaml003,ooidl_t.ooidl003,oojdl_t.oojdl003,oofa_t.oofa011,prcfl_t.prcfl003, 
       x.t18_prcfl003,dbadl_t.dbadl003,x.t21_dbadl003,dbabl_t.dbabl003,dbaal_t.dbaal003,t4.dbaal003, 
       t5.dbaal003,t6.dbaal003,x.t19_dbaal003,x.t20_dbaal003,x.t28_dbaal003,x.t29_dbaal003,x.imaal_t_imaal003, 
       x.oocal_t_oocal003,x.t24_oocal003,x.t25_oocal003,x.t26_oocal003,trim(xmdaunit)||'.'||trim(ooefl_t.ooefl003), 
       trim(xmda200)||'.'||trim(t16.pmaal004),trim(xmda036)||'.'||trim(t15.pmaal004),trim(xmda201)||'.'||trim(t17.pmaal004), 
       trim(xmda004)||'.'||trim(pmaal_t.pmaal004),trim(xmda034)||'.'||trim(t14.pmaal003),trim(xmda022)||'.'||trim(t11.pmaal004), 
       trim(xmda021)||'.'||trim(t10.pmaal004),trim(xmda004)||'.'||trim(t1.pmaal004),trim(xmda003)||'.'||trim(t2.ooefl003), 
       trim(xmdasite)||'.'||trim(t3.ooefl003),trim(xmda002)||'.'||trim(ooag_t.ooag011),trim(xmda204)||'.'||trim(prcfl_t.prcfl003), 
       trim(xmda203)||'.'||trim(t7.pmaal004),trim(xmda202)||'.'||trim(t8.ooefl003),trim(xmja005)||'.'||trim(x.t18_prcfl003), 
       trim(xmja024)||'.'||trim(x.t23_pmaal004),trim(xmja025)||'.'||trim(x.t22_pmaal004),trim(xmjasite)||'.'||trim(x.t27_ooefl003), 
       x.imaal_t_imaal003,x.imaal_t_imaal004,'',x.l_xmdc007,x.l_xmdc006,x.l_xmdc015,NULL,trim(xmda023)||'.'||trim(oojdl_t.oojdl003)"  #160420-00039#2 Modify By Ken 160628 效能調整 加imaal003,imaal004,xmdc007,xmdc006,xmdc015
       
#   #end add-point
#   LET g_select = " SELECT xmda001,xmda002,xmda003,xmda004,xmda005,xmda006,xmda007,xmda008,xmda009,xmda010, 
#       xmda011,xmda012,xmda013,xmda015,xmda016,xmda017,xmda018,xmda019,xmda020,xmda021,xmda022,xmda023, 
#       xmda024,xmda025,xmda026,xmda027,xmda028,xmda030,xmda031,xmda032,xmda033,xmda034,xmda035,xmda036, 
#       xmda039,xmda041,xmda042,xmda043,xmda045,xmda046,xmda047,xmda048,xmda049,xmda071,xmda200,xmda201, 
#       xmda202,xmda203,xmda204,xmda205,xmda206,xmda207,xmda208,xmda209,xmda210,xmda211,xmda213,xmdadocdt, 
#       xmdadocno,xmdaent,xmdasite,xmdastus,xmdaunit,xmja001,xmja002,xmja003,xmja004,xmja005,xmja006, 
#       xmja007,xmja008,xmja009,xmja010,xmja011,xmja012,xmja013,xmja014,xmja015,xmja016,xmja017,xmja018, 
#       xmja019,xmja020,xmja021,xmja022,xmja024,xmja025,xmja026,xmja027,xmja028,xmja029,xmja030,xmja031, 
#       xmja032,xmja033,xmja034,xmja037,xmja038,xmja039,xmja040,xmjaseq,xmjasite,xmjaunit,( SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = xmda_t.xmda002 AND ooag_t.ooagent = xmda_t.xmdaent), 
#       ( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooeflent = xmda_t.xmdaent AND ooefl_t.ooefl001 = xmda_t.xmdaunit AND ooefl_t.ooefl002 = '" , 
#       g_dlang,"'" ,"),( SELECT ooefl003 FROM ooefl_t t2 WHERE t2.ooefl001 = xmda_t.xmda003 AND t2.ooeflent = xmda_t.xmdaent AND t2.ooefl002 = '" , 
#       g_dlang,"'" ,"),( SELECT ooefl003 FROM ooefl_t t3 WHERE t3.ooeflent = xmda_t.xmdaent AND t3.ooefl001 = xmda_t.xmdasite AND t3.ooefl002 = '" , 
#       g_dlang,"'" ,"),( SELECT ooefl003 FROM ooefl_t t8 WHERE t8.ooeflent = xmda_t.xmdaent AND t8.ooefl001 = xmda_t.xmda202 AND t8.ooefl002 = '" , 
#       g_dlang,"'" ,"),x.t27_ooefl003,( SELECT pmaal003 FROM pmaal_t t14 WHERE t14.pmaal001 = xmda_t.xmda034 AND t14.pmaalent = xmda_t.xmdaent AND t14.pmaal002 = '" , 
#       g_dlang,"'" ,"),( SELECT pmaal004 FROM pmaal_t t1 WHERE t1.pmaal001 = xmda_t.xmda004 AND t1.pmaalent = xmda_t.xmdaent AND t1.pmaal002 = '" , 
#       g_dlang,"'" ,"),( SELECT pmaal004 FROM pmaal_t t7 WHERE t7.pmaalent = xmda_t.xmdaent AND t7.pmaal001 = xmda_t.xmda203 AND t7.pmaal002 = '" , 
#       g_dlang,"'" ,"),( SELECT pmaal004 FROM pmaal_t t10 WHERE t10.pmaalent = xmda_t.xmdaent AND t10.pmaal001 = xmda_t.xmda021 AND t10.pmaal002 = '" , 
#       g_dlang,"'" ,"),( SELECT pmaal004 FROM pmaal_t t11 WHERE t11.pmaalent = xmda_t.xmdaent AND t11.pmaal001 = xmda_t.xmda022 AND t11.pmaal002 = '" , 
#       g_dlang,"'" ,"),( SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaalent = xmda_t.xmdaent AND pmaal_t.pmaal001 = xmda_t.xmda004 AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,"),( SELECT pmaal004 FROM pmaal_t t17 WHERE t17.pmaalent = xmda_t.xmdaent AND t17.pmaal001 = xmda_t.xmda201 AND t17.pmaal002 = '" , 
#       g_dlang,"'" ,"),( SELECT pmaal004 FROM pmaal_t t15 WHERE t15.pmaal001 = xmda_t.xmda036 AND t15.pmaalent = xmda_t.xmdaent AND t15.pmaal002 = '" , 
#       g_dlang,"'" ,"),( SELECT pmaal004 FROM pmaal_t t16 WHERE t16.pmaalent = xmda_t.xmdaent AND t16.pmaal001 = xmda_t.xmda200 AND t16.pmaal002 = '" , 
#       g_dlang,"'" ,"),x.t22_pmaal004,x.t23_pmaal004,( SELECT ooibl004 FROM ooibl_t WHERE ooibl_t.ooibl002 = xmda_t.xmda009 AND ooibl_t.ooiblent = xmda_t.xmdaent AND ooibl_t.ooibl003 = '" , 
#       g_dlang,"'" ,"),( SELECT oocql004 FROM oocql_t WHERE oocql_t.oocql001 = '238' AND oocql_t.oocql002 = xmda_t.xmda010 AND oocql_t.oocqlent = xmda_t.xmdaent AND oocql_t.oocql003 = '" , 
#       g_dlang,"'" ,"),( SELECT oocql004 FROM oocql_t t9 WHERE t9.oocql001 = '263' AND t9.oocql002 = xmda_t.xmda020 AND t9.oocqlent = xmda_t.xmdaent AND t9.oocql003 = '" , 
#       g_dlang,"'" ,"),( SELECT oocql004 FROM oocql_t t12 WHERE t12.oocql001 = '295' AND t12.oocql002 = xmda_t.xmda024 AND t12.oocqlent = xmda_t.xmdaent AND t12.oocql003 = '" , 
#       g_dlang,"'" ,"),( SELECT oocql004 FROM oocql_t t13 WHERE t13.oocql001 = '297' AND t13.oocql002 = xmda_t.xmda032 AND t13.oocqlent = xmda_t.xmdaent AND t13.oocql003 = '" , 
#       g_dlang,"'" ,"),( SELECT ooail003 FROM ooail_t WHERE ooail_t.ooail001 = xmda_t.xmda015 AND ooail_t.ooailent = xmda_t.xmdaent AND ooail_t.ooail002 = '" , 
#       g_dlang,"'" ,"),( SELECT pmaml003 FROM pmaml_t WHERE pmaml_t.pmaml001 = xmda_t.xmda017 AND pmaml_t.pmamlent = xmda_t.xmdaent AND pmaml_t.pmaml002 = '" , 
#       g_dlang,"'" ,"),( SELECT ooidl003 FROM ooidl_t WHERE ooidl_t.ooidl001 = xmda_t.xmda018 AND ooidl_t.ooidlent = xmda_t.xmdaent AND ooidl_t.ooidl002 = '" , 
#       g_dlang,"'" ,"),( SELECT oojdl003 FROM oojdl_t WHERE oojdl_t.oojdlent = xmda_t.xmdaent AND oojdl_t.oojdl001 = xmda_t.xmda023 AND oojdl_t.oojdl002 = '" , 
#       g_dlang,"'" ,"),( SELECT oofa011 FROM oofa_t WHERE oofa_t.oofa001 = xmda_t.xmda027 AND oofa_t.oofaent = xmda_t.xmdaent), 
#       ( SELECT prcfl003 FROM prcfl_t WHERE prcfl_t.prcflent = xmda_t.xmdaent AND prcfl_t.prcfl001 = xmda_t.xmda204 AND prcfl_t.prcfl002 = '" , 
#       g_dlang,"'" ,"),x.t18_prcfl003,( SELECT dbadl003 FROM dbadl_t WHERE dbadl_t.dbadlent = xmda_t.xmdaent AND dbadl_t.dbadl001 = xmda_t.xmda206 AND dbadl_t.dbadl002 = '" , 
#       g_dlang,"'" ,"),x.t21_dbadl003,( SELECT dbabl003 FROM dbabl_t WHERE dbabl_t.dbablent = xmda_t.xmdaent AND dbabl_t.dbabl001 = xmda_t.xmda207 AND dbabl_t.dbabl002 = '" , 
#       g_dlang,"'" ,"),( SELECT dbaal003 FROM dbaal_t WHERE dbaal_t.dbaal001 = xmda_t.xmda211 AND dbaal_t.dbaalent = xmda_t.xmdaent AND dbaal_t.dbaal002 = '" , 
#       g_dlang,"'" ,"),( SELECT dbaal003 FROM dbaal_t t4 WHERE t4.dbaal001 = xmda_t.xmda210 AND t4.dbaalent = xmda_t.xmdaent AND t4.dbaal002 = '" , 
#       g_dlang,"'" ,"),( SELECT dbaal003 FROM dbaal_t t5 WHERE t5.dbaal001 = xmda_t.xmda209 AND t5.dbaalent = xmda_t.xmdaent AND t5.dbaal002 = '" , 
#       g_dlang,"'" ,"),( SELECT dbaal003 FROM dbaal_t t6 WHERE t6.dbaal001 = xmda_t.xmda208 AND t6.dbaalent = xmda_t.xmdaent AND t6.dbaal002 = '" , 
#       g_dlang,"'" ,"),x.t19_dbaal003,x.t20_dbaal003,x.t28_dbaal003,x.t29_dbaal003,x.imaal_t_imaal003, 
#       x.oocal_t_oocal003,x.t24_oocal003,x.t25_oocal003,x.t26_oocal003,trim(xmdaunit)||'.'||trim((SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooeflent = xmda_t.xmdaent AND ooefl_t.ooefl001 = xmda_t.xmdaunit AND ooefl_t.ooefl002 = '" , 
#       g_dlang,"'" ,")),trim(xmda200)||'.'||trim((SELECT pmaal004 FROM pmaal_t t16 WHERE t16.pmaalent = xmda_t.xmdaent AND t16.pmaal001 = xmda_t.xmda200 AND t16.pmaal002 = '" , 
#       g_dlang,"'" ,")),trim(xmda036)||'.'||trim((SELECT pmaal004 FROM pmaal_t t15 WHERE t15.pmaal001 = xmda_t.xmda036 AND t15.pmaalent = xmda_t.xmdaent AND t15.pmaal002 = '" , 
#       g_dlang,"'" ,")),trim(xmda201)||'.'||trim((SELECT pmaal004 FROM pmaal_t t17 WHERE t17.pmaalent = xmda_t.xmdaent AND t17.pmaal001 = xmda_t.xmda201 AND t17.pmaal002 = '" , 
#       g_dlang,"'" ,")),trim(xmda004)||'.'||trim((SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaalent = xmda_t.xmdaent AND pmaal_t.pmaal001 = xmda_t.xmda004 AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,")),trim(xmda034)||'.'||trim((SELECT pmaal003 FROM pmaal_t t14 WHERE t14.pmaal001 = xmda_t.xmda034 AND t14.pmaalent = xmda_t.xmdaent AND t14.pmaal002 = '" , 
#       g_dlang,"'" ,")),trim(xmda022)||'.'||trim((SELECT pmaal004 FROM pmaal_t t11 WHERE t11.pmaalent = xmda_t.xmdaent AND t11.pmaal001 = xmda_t.xmda022 AND t11.pmaal002 = '" , 
#       g_dlang,"'" ,")),trim(xmda021)||'.'||trim((SELECT pmaal004 FROM pmaal_t t10 WHERE t10.pmaalent = xmda_t.xmdaent AND t10.pmaal001 = xmda_t.xmda021 AND t10.pmaal002 = '" , 
#       g_dlang,"'" ,")),trim(xmda004)||'.'||trim((SELECT pmaal004 FROM pmaal_t t1 WHERE t1.pmaal001 = xmda_t.xmda004 AND t1.pmaalent = xmda_t.xmdaent AND t1.pmaal002 = '" , 
#       g_dlang,"'" ,")),trim(xmda003)||'.'||trim((SELECT ooefl003 FROM ooefl_t t2 WHERE t2.ooefl001 = xmda_t.xmda003 AND t2.ooeflent = xmda_t.xmdaent AND t2.ooefl002 = '" , 
#       g_dlang,"'" ,")),trim(xmdasite)||'.'||trim((SELECT ooefl003 FROM ooefl_t t3 WHERE t3.ooeflent = xmda_t.xmdaent AND t3.ooefl001 = xmda_t.xmdasite AND t3.ooefl002 = '" , 
#       g_dlang,"'" ,")),trim(xmda002)||'.'||trim((SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = xmda_t.xmda002 AND ooag_t.ooagent = xmda_t.xmdaent)), 
#       trim(xmda204)||'.'||trim((SELECT prcfl003 FROM prcfl_t WHERE prcfl_t.prcflent = xmda_t.xmdaent AND prcfl_t.prcfl001 = xmda_t.xmda204 AND prcfl_t.prcfl002 = '" , 
#       g_dlang,"'" ,")),trim(xmda203)||'.'||trim((SELECT pmaal004 FROM pmaal_t t7 WHERE t7.pmaalent = xmda_t.xmdaent AND t7.pmaal001 = xmda_t.xmda203 AND t7.pmaal002 = '" , 
#       g_dlang,"'" ,")),trim(xmda202)||'.'||trim((SELECT ooefl003 FROM ooefl_t t8 WHERE t8.ooeflent = xmda_t.xmdaent AND t8.ooefl001 = xmda_t.xmda202 AND t8.ooefl002 = '" , 
#       g_dlang,"'" ,")),trim(xmja005)||'.'||trim(x.t18_prcfl003),trim(xmja024)||'.'||trim(x.t23_pmaal004), 
#       trim(xmja025)||'.'||trim(x.t22_pmaal004),trim(xmjasite)||'.'||trim(x.t27_ooefl003),'','','',NULL, 
#       '',NULL,trim(xmda023)||'.'||trim((SELECT oojdl003 FROM oojdl_t WHERE oojdl_t.oojdlent = xmda_t.xmdaent AND oojdl_t.oojdl001 = xmda_t.xmda023 AND oojdl_t.oojdl002 = '" , 
#       g_dlang,"'" ,"))"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
#
    LET g_from = " FROM xmda_t LEFT OUTER JOIN pmaal_t ON pmaal_t.pmaalent = xmda_t.xmdaent AND pmaal_t.pmaal001 = xmda_t.xmda004 AND pmaal_t.pmaal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN ooibl_t ON ooibl_t.ooibl002 = xmda_t.xmda009 AND ooibl_t.ooiblent = xmda_t.xmdaent AND ooibl_t.ooibl003 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN dbaal_t ON dbaal_t.dbaal001 = xmda_t.xmda211 AND dbaal_t.dbaalent = xmda_t.xmdaent AND dbaal_t.dbaal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN ooefl_t ON ooefl_t.ooeflent = xmda_t.xmdaent AND ooefl_t.ooefl001 = xmda_t.xmdaunit AND ooefl_t.ooefl002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN pmaal_t t1 ON t1.pmaal001 = xmda_t.xmda004 AND t1.pmaalent = xmda_t.xmdaent AND t1.pmaal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN ooefl_t t2 ON t2.ooefl001 = xmda_t.xmda003 AND t2.ooeflent = xmda_t.xmdaent AND t2.ooefl002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN ooefl_t t3 ON t3.ooeflent = xmda_t.xmdaent AND t3.ooefl001 = xmda_t.xmdasite AND t3.ooefl002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN ooag_t ON ooag_t.ooag001 = xmda_t.xmda002 AND ooag_t.ooagent = xmda_t.xmdaent             LEFT OUTER JOIN dbaal_t t4 ON t4.dbaal001 = xmda_t.xmda210 AND t4.dbaalent = xmda_t.xmdaent AND t4.dbaal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN dbaal_t t5 ON t5.dbaal001 = xmda_t.xmda209 AND t5.dbaalent = xmda_t.xmdaent AND t5.dbaal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN dbaal_t t6 ON t6.dbaal001 = xmda_t.xmda208 AND t6.dbaalent = xmda_t.xmdaent AND t6.dbaal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN dbabl_t ON dbabl_t.dbablent = xmda_t.xmdaent AND dbabl_t.dbabl001 = xmda_t.xmda207 AND dbabl_t.dbabl002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN dbadl_t ON dbadl_t.dbadlent = xmda_t.xmdaent AND dbadl_t.dbadl001 = xmda_t.xmda206 AND dbadl_t.dbadl002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN prcfl_t ON prcfl_t.prcflent = xmda_t.xmdaent AND prcfl_t.prcfl001 = xmda_t.xmda204 AND prcfl_t.prcfl002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN pmaal_t t7 ON t7.pmaalent = xmda_t.xmdaent AND t7.pmaal001 = xmda_t.xmda203 AND t7.pmaal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN ooefl_t t8 ON t8.ooeflent = xmda_t.xmdaent AND t8.ooefl001 = xmda_t.xmda202 AND t8.ooefl002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN oocql_t ON oocql_t.oocql001 = '238' AND oocql_t.oocql002 = xmda_t.xmda010 AND oocql_t.oocqlent = xmda_t.xmdaent AND oocql_t.oocql003 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN ooail_t ON ooail_t.ooail001 = xmda_t.xmda015 AND ooail_t.ooailent = xmda_t.xmdaent AND ooail_t.ooail002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN pmaml_t ON pmaml_t.pmaml001 = xmda_t.xmda017 AND pmaml_t.pmamlent = xmda_t.xmdaent AND pmaml_t.pmaml002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN ooidl_t ON ooidl_t.ooidl001 = xmda_t.xmda018 AND ooidl_t.ooidlent = xmda_t.xmdaent AND ooidl_t.ooidl002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN oocql_t t9 ON t9.oocql001 = '263' AND t9.oocql002 = xmda_t.xmda020 AND t9.oocqlent = xmda_t.xmdaent AND t9.oocql003 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN pmaal_t t10 ON t10.pmaalent = xmda_t.xmdaent AND t10.pmaal001 = xmda_t.xmda021 AND t10.pmaal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN pmaal_t t11 ON t11.pmaalent = xmda_t.xmdaent AND t11.pmaal001 = xmda_t.xmda022 AND t11.pmaal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN oojdl_t ON oojdl_t.oojdlent = xmda_t.xmdaent AND oojdl_t.oojdl001 = xmda_t.xmda023 AND oojdl_t.oojdl002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN oocql_t t12 ON t12.oocql001 = '295' AND t12.oocql002 = xmda_t.xmda024 AND t12.oocqlent = xmda_t.xmdaent AND t12.oocql003 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN oofa_t ON oofa_t.oofa001 = xmda_t.xmda027 AND oofa_t.oofaent = xmda_t.xmdaent             LEFT OUTER JOIN oocql_t t13 ON t13.oocql001 = '297' AND t13.oocql002 = xmda_t.xmda032 AND t13.oocqlent = xmda_t.xmdaent AND t13.oocql003 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN pmaal_t t14 ON t14.pmaal001 = xmda_t.xmda034 AND t14.pmaalent = xmda_t.xmdaent AND t14.pmaal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN pmaal_t t15 ON t15.pmaal001 = xmda_t.xmda036 AND t15.pmaalent = xmda_t.xmdaent AND t15.pmaal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN pmaal_t t16 ON t16.pmaalent = xmda_t.xmdaent AND t16.pmaal001 = xmda_t.xmda200 AND t16.pmaal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN pmaal_t t17 ON t17.pmaalent = xmda_t.xmdaent AND t17.pmaal001 = xmda_t.xmda201 AND t17.pmaal002 = '" , 
        #160420-00039#2 Modify By Ken 160628(S) 調整效能
        #g_dlang,"'" ," LEFT OUTER JOIN ( SELECT xmja_t.*,t27.ooefl003 t27_ooefl003,t22.pmaal004 t22_pmaal004, 
        #t23.pmaal004 t23_pmaal004,t18.prcfl003 t18_prcfl003,t21.dbadl003 t21_dbadl003,t19.dbaal003 t19_dbaal003, 
        #t20.dbaal003 t20_dbaal003,t28.dbaal003 t28_dbaal003,t29.dbaal003 t29_dbaal003,imaal_t.imaal003 imaal_t_imaal003, 
        #oocal_t.oocal003 oocal_t_oocal003,t24.oocal003 t24_oocal003,t25.oocal003 t25_oocal003,t26.oocal003 t26_oocal003 FROM xmja_t LEFT OUTER JOIN prcfl_t t18 ON t18.prcflent = xmja_t.xmjaent AND t18.prcfl001 = xmja_t.xmja005 AND t18.prcfl002 = '" , 
        g_dlang,"'" ," LEFT OUTER JOIN ( SELECT xmja_t.*,t27.ooefl003 t27_ooefl003,t22.pmaal004 t22_pmaal004, 
        t23.pmaal004 t23_pmaal004,t18.prcfl003 t18_prcfl003,t21.dbadl003 t21_dbadl003,t19.dbaal003 t19_dbaal003, 
        t20.dbaal003 t20_dbaal003,t28.dbaal003 t28_dbaal003,t29.dbaal003 t29_dbaal003,imaal_t.imaal003 imaal_t_imaal003,imaal_t.imaal004 imaal_t_imaal004,
        xmdc007 l_xmdc007,xmdc006 l_xmdc006,xmdc015 l_xmdc015,        
        oocal_t.oocal003 oocal_t_oocal003,t24.oocal003 t24_oocal003,t25.oocal003 t25_oocal003,t26.oocal003 t26_oocal003 FROM xmja_t LEFT OUTER JOIN prcfl_t t18 ON t18.prcflent = xmja_t.xmjaent AND t18.prcfl001 = xmja_t.xmja005 AND t18.prcfl002 = '" ,         
        #160420-00039#2 Modify By Ken 160628(E) 調整效能
        g_dlang,"'" ,"             LEFT OUTER JOIN dbaal_t t19 ON t19.dbaal001 = xmja_t.xmja038 AND t19.dbaalent = xmja_t.xmjaent AND t19.dbaal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN dbaal_t t20 ON t20.dbaal001 = xmja_t.xmja037 AND t20.dbaalent = xmja_t.xmjaent AND t20.dbaal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN dbadl_t t21 ON t21.dbadlent = xmja_t.xmjaent AND t21.dbadl001 = xmja_t.xmja027 AND t21.dbadl002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN pmaal_t t22 ON t22.pmaal001 = xmja_t.xmja025 AND t22.pmaalent = xmja_t.xmjaent AND t22.pmaal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN pmaal_t t23 ON t23.pmaalent = xmja_t.xmjaent AND t23.pmaal001 = xmja_t.xmja024 AND t23.pmaal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN oocal_t ON oocal_t.oocalent = xmja_t.xmjaent AND oocal_t.oocal001 = xmja_t.xmja017 AND oocal_t.oocal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN oocal_t t24 ON t24.oocalent = xmja_t.xmjaent AND t24.oocal001 = xmja_t.xmja015 AND t24.oocal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN oocal_t t25 ON t25.oocalent = xmja_t.xmjaent AND t25.oocal001 = xmja_t.xmja013 AND t25.oocal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN oocal_t t26 ON t26.oocalent = xmja_t.xmjaent AND t26.oocal001 = xmja_t.xmja011 AND t26.oocal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN ooefl_t t27 ON t27.ooeflent = xmja_t.xmjaent AND t27.ooefl001 = xmja_t.xmjasite AND t27.ooefl002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN dbaal_t t28 ON t28.dbaal001 = xmja_t.xmja040 AND t28.dbaalent = xmja_t.xmjaent AND t28.dbaal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN dbaal_t t29 ON t29.dbaal001 = xmja_t.xmja039 AND t29.dbaalent = xmja_t.xmjaent AND t29.dbaal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN imaal_t ON imaal_t.imaalent = xmja_t.xmjaent AND imaal_t.imaal001 = xmja_t.xmja003 AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN xmdc_t  ON xmdcent = xmjaent AND xmdcdocno = xmjadocno AND xmdcseq = xmjaseq) x  ON xmda_t.xmdaent = x.xmjaent AND xmda_t.xmdadocno = x.xmjadocno"  #加上LEFT JOIN xmdc_t
#
#   #end add-point
#    LET g_from = " FROM xmda_t LEFT OUTER JOIN ( SELECT xmja_t.*,( SELECT ooefl003 FROM ooefl_t t27 WHERE t27.ooeflent = xmja_t.xmjaent AND t27.ooefl001 = xmja_t.xmjasite AND t27.ooefl002 = '" , 
#        g_dlang,"'" ,") t27_ooefl003,( SELECT pmaal004 FROM pmaal_t t22 WHERE t22.pmaal001 = xmja_t.xmja025 AND t22.pmaalent = xmja_t.xmjaent AND t22.pmaal002 = '" , 
#        g_dlang,"'" ,") t22_pmaal004,( SELECT pmaal004 FROM pmaal_t t23 WHERE t23.pmaalent = xmja_t.xmjaent AND t23.pmaal001 = xmja_t.xmja024 AND t23.pmaal002 = '" , 
#        g_dlang,"'" ,") t23_pmaal004,( SELECT prcfl003 FROM prcfl_t t18 WHERE t18.prcflent = xmja_t.xmjaent AND t18.prcfl001 = xmja_t.xmja005 AND t18.prcfl002 = '" , 
#        g_dlang,"'" ,") t18_prcfl003,( SELECT dbadl003 FROM dbadl_t t21 WHERE t21.dbadlent = xmja_t.xmjaent AND t21.dbadl001 = xmja_t.xmja027 AND t21.dbadl002 = '" , 
#        g_dlang,"'" ,") t21_dbadl003,( SELECT dbaal003 FROM dbaal_t t19 WHERE t19.dbaal001 = xmja_t.xmja038 AND t19.dbaalent = xmja_t.xmjaent AND t19.dbaal002 = '" , 
#        g_dlang,"'" ,") t19_dbaal003,( SELECT dbaal003 FROM dbaal_t t20 WHERE t20.dbaal001 = xmja_t.xmja037 AND t20.dbaalent = xmja_t.xmjaent AND t20.dbaal002 = '" , 
#        g_dlang,"'" ,") t20_dbaal003,( SELECT dbaal003 FROM dbaal_t t28 WHERE t28.dbaal001 = xmja_t.xmja040 AND t28.dbaalent = xmja_t.xmjaent AND t28.dbaal002 = '" , 
#        g_dlang,"'" ,") t28_dbaal003,( SELECT dbaal003 FROM dbaal_t t29 WHERE t29.dbaal001 = xmja_t.xmja039 AND t29.dbaalent = xmja_t.xmjaent AND t29.dbaal002 = '" , 
#        g_dlang,"'" ,") t29_dbaal003,( SELECT imaal003 FROM imaal_t WHERE imaal_t.imaalent = xmja_t.xmjaent AND imaal_t.imaal001 = xmja_t.xmja003 AND imaal_t.imaal002 = '" , 
#        g_dlang,"'" ,") imaal_t_imaal003,( SELECT oocal003 FROM oocal_t WHERE oocal_t.oocalent = xmja_t.xmjaent AND oocal_t.oocal001 = xmja_t.xmja017 AND oocal_t.oocal002 = '" , 
#        g_dlang,"'" ,") oocal_t_oocal003,( SELECT oocal003 FROM oocal_t t24 WHERE t24.oocalent = xmja_t.xmjaent AND t24.oocal001 = xmja_t.xmja015 AND t24.oocal002 = '" , 
#        g_dlang,"'" ,") t24_oocal003,( SELECT oocal003 FROM oocal_t t25 WHERE t25.oocalent = xmja_t.xmjaent AND t25.oocal001 = xmja_t.xmja013 AND t25.oocal002 = '" , 
#        g_dlang,"'" ,") t25_oocal003,( SELECT oocal003 FROM oocal_t t26 WHERE t26.oocalent = xmja_t.xmjaent AND t26.oocal001 = xmja_t.xmja011 AND t26.oocal002 = '" , 
#        g_dlang,"'" ,") t26_oocal003 FROM xmja_t ) x  ON xmda_t.xmdaent = x.xmjaent AND xmda_t.xmdadocno  
#        = x.xmjadocno"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
    LET g_where = g_where CLIPPED," AND xmda005 IN ('1','2','3','6') AND xmda007 IN ('1','5','8') " 
   #end add-point
    LET g_order = " ORDER BY xmdadocno,xmjaseq"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("xmda_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE adbr500_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE adbr500_g01_curs CURSOR FOR adbr500_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="adbr500_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION adbr500_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   xmda001 LIKE xmda_t.xmda001, 
   xmda002 LIKE xmda_t.xmda002, 
   xmda003 LIKE xmda_t.xmda003, 
   xmda004 LIKE xmda_t.xmda004, 
   xmda005 LIKE xmda_t.xmda005, 
   xmda006 LIKE xmda_t.xmda006, 
   xmda007 LIKE xmda_t.xmda007, 
   xmda008 LIKE xmda_t.xmda008, 
   xmda009 LIKE xmda_t.xmda009, 
   xmda010 LIKE xmda_t.xmda010, 
   xmda011 LIKE xmda_t.xmda011, 
   xmda012 LIKE xmda_t.xmda012, 
   xmda013 LIKE xmda_t.xmda013, 
   xmda015 LIKE xmda_t.xmda015, 
   xmda016 LIKE xmda_t.xmda016, 
   xmda017 LIKE xmda_t.xmda017, 
   xmda018 LIKE xmda_t.xmda018, 
   xmda019 LIKE xmda_t.xmda019, 
   xmda020 LIKE xmda_t.xmda020, 
   xmda021 LIKE xmda_t.xmda021, 
   xmda022 LIKE xmda_t.xmda022, 
   xmda023 LIKE xmda_t.xmda023, 
   xmda024 LIKE xmda_t.xmda024, 
   xmda025 LIKE xmda_t.xmda025, 
   xmda026 LIKE xmda_t.xmda026, 
   xmda027 LIKE xmda_t.xmda027, 
   xmda028 LIKE xmda_t.xmda028, 
   xmda030 LIKE xmda_t.xmda030, 
   xmda031 LIKE xmda_t.xmda031, 
   xmda032 LIKE xmda_t.xmda032, 
   xmda033 LIKE xmda_t.xmda033, 
   xmda034 LIKE xmda_t.xmda034, 
   xmda035 LIKE xmda_t.xmda035, 
   xmda036 LIKE xmda_t.xmda036, 
   xmda039 LIKE xmda_t.xmda039, 
   xmda041 LIKE xmda_t.xmda041, 
   xmda042 LIKE xmda_t.xmda042, 
   xmda043 LIKE xmda_t.xmda043, 
   xmda045 LIKE xmda_t.xmda045, 
   xmda046 LIKE xmda_t.xmda046, 
   xmda047 LIKE xmda_t.xmda047, 
   xmda048 LIKE xmda_t.xmda048, 
   xmda049 LIKE xmda_t.xmda049, 
   xmda071 LIKE xmda_t.xmda071, 
   xmda200 LIKE xmda_t.xmda200, 
   xmda201 LIKE xmda_t.xmda201, 
   xmda202 LIKE xmda_t.xmda202, 
   xmda203 LIKE xmda_t.xmda203, 
   xmda204 LIKE xmda_t.xmda204, 
   xmda205 LIKE xmda_t.xmda205, 
   xmda206 LIKE xmda_t.xmda206, 
   xmda207 LIKE xmda_t.xmda207, 
   xmda208 LIKE xmda_t.xmda208, 
   xmda209 LIKE xmda_t.xmda209, 
   xmda210 LIKE xmda_t.xmda210, 
   xmda211 LIKE xmda_t.xmda211, 
   xmda213 LIKE xmda_t.xmda213, 
   xmdadocdt LIKE xmda_t.xmdadocdt, 
   xmdadocno LIKE xmda_t.xmdadocno, 
   xmdaent LIKE xmda_t.xmdaent, 
   xmdasite LIKE xmda_t.xmdasite, 
   xmdastus LIKE xmda_t.xmdastus, 
   xmdaunit LIKE xmda_t.xmdaunit, 
   xmja001 LIKE xmja_t.xmja001, 
   xmja002 LIKE xmja_t.xmja002, 
   xmja003 LIKE xmja_t.xmja003, 
   xmja004 LIKE xmja_t.xmja004, 
   xmja005 LIKE xmja_t.xmja005, 
   xmja006 LIKE xmja_t.xmja006, 
   xmja007 LIKE xmja_t.xmja007, 
   xmja008 LIKE xmja_t.xmja008, 
   xmja009 LIKE xmja_t.xmja009, 
   xmja010 LIKE xmja_t.xmja010, 
   xmja011 LIKE xmja_t.xmja011, 
   xmja012 LIKE xmja_t.xmja012, 
   xmja013 LIKE xmja_t.xmja013, 
   xmja014 LIKE xmja_t.xmja014, 
   xmja015 LIKE xmja_t.xmja015, 
   xmja016 LIKE xmja_t.xmja016, 
   xmja017 LIKE xmja_t.xmja017, 
   xmja018 LIKE xmja_t.xmja018, 
   xmja019 LIKE xmja_t.xmja019, 
   xmja020 LIKE xmja_t.xmja020, 
   xmja021 LIKE xmja_t.xmja021, 
   xmja022 LIKE xmja_t.xmja022, 
   xmja024 LIKE xmja_t.xmja024, 
   xmja025 LIKE xmja_t.xmja025, 
   xmja026 LIKE xmja_t.xmja026, 
   xmja027 LIKE xmja_t.xmja027, 
   xmja028 LIKE xmja_t.xmja028, 
   xmja029 LIKE xmja_t.xmja029, 
   xmja030 LIKE xmja_t.xmja030, 
   xmja031 LIKE xmja_t.xmja031, 
   xmja032 LIKE xmja_t.xmja032, 
   xmja033 LIKE xmja_t.xmja033, 
   xmja034 LIKE xmja_t.xmja034, 
   xmja037 LIKE xmja_t.xmja037, 
   xmja038 LIKE xmja_t.xmja038, 
   xmja039 LIKE xmja_t.xmja039, 
   xmja040 LIKE xmja_t.xmja040, 
   xmjaseq LIKE xmja_t.xmjaseq, 
   xmjasite LIKE xmja_t.xmjasite, 
   xmjaunit LIKE xmja_t.xmjaunit, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   t2_ooefl003 LIKE ooefl_t.ooefl003, 
   t3_ooefl003 LIKE ooefl_t.ooefl003, 
   t8_ooefl003 LIKE ooefl_t.ooefl003, 
   x_t27_ooefl003 LIKE ooefl_t.ooefl003, 
   t14_pmaal003 LIKE pmaal_t.pmaal003, 
   t1_pmaal004 LIKE pmaal_t.pmaal004, 
   t7_pmaal004 LIKE pmaal_t.pmaal004, 
   t10_pmaal004 LIKE pmaal_t.pmaal004, 
   t11_pmaal004 LIKE pmaal_t.pmaal004, 
   pmaal_t_pmaal004 LIKE pmaal_t.pmaal004, 
   t17_pmaal004 LIKE pmaal_t.pmaal004, 
   t15_pmaal004 LIKE pmaal_t.pmaal004, 
   t16_pmaal004 LIKE pmaal_t.pmaal004, 
   x_t22_pmaal004 LIKE pmaal_t.pmaal004, 
   x_t23_pmaal004 LIKE pmaal_t.pmaal004, 
   ooibl_t_ooibl004 LIKE ooibl_t.ooibl004, 
   oocql_t_oocql004 LIKE oocql_t.oocql004, 
   t9_oocql004 LIKE oocql_t.oocql004, 
   t12_oocql004 LIKE oocql_t.oocql004, 
   t13_oocql004 LIKE oocql_t.oocql004, 
   ooail_t_ooail003 LIKE ooail_t.ooail003, 
   pmaml_t_pmaml003 LIKE pmaml_t.pmaml003, 
   ooidl_t_ooidl003 LIKE ooidl_t.ooidl003, 
   oojdl_t_oojdl003 LIKE oojdl_t.oojdl003, 
   oofa_t_oofa011 LIKE oofa_t.oofa011, 
   prcfl_t_prcfl003 LIKE prcfl_t.prcfl003, 
   x_t18_prcfl003 LIKE prcfl_t.prcfl003, 
   dbadl_t_dbadl003 LIKE dbadl_t.dbadl003, 
   x_t21_dbadl003 LIKE dbadl_t.dbadl003, 
   dbabl_t_dbabl003 LIKE dbabl_t.dbabl003, 
   dbaal_t_dbaal003 LIKE dbaal_t.dbaal003, 
   t4_dbaal003 LIKE dbaal_t.dbaal003, 
   t5_dbaal003 LIKE dbaal_t.dbaal003, 
   t6_dbaal003 LIKE dbaal_t.dbaal003, 
   x_t19_dbaal003 LIKE dbaal_t.dbaal003, 
   x_t20_dbaal003 LIKE dbaal_t.dbaal003, 
   x_t28_dbaal003 LIKE dbaal_t.dbaal003, 
   x_t29_dbaal003 LIKE dbaal_t.dbaal003, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   x_oocal_t_oocal003 LIKE oocal_t.oocal003, 
   x_t24_oocal003 LIKE oocal_t.oocal003, 
   x_t25_oocal003 LIKE oocal_t.oocal003, 
   x_t26_oocal003 LIKE oocal_t.oocal003, 
   l_xmdaunit_ooefl003 LIKE type_t.chr1000, 
   l_xmda200_pmaal004 LIKE type_t.chr100, 
   l_xmda036_pmaal004 LIKE type_t.chr100, 
   l_xmda201_pmaal004 LIKE type_t.chr100, 
   l_xmda004_pmaal004 LIKE type_t.chr100, 
   l_xmda034_pmaal003 LIKE type_t.chr300, 
   l_xmda022_pmaal004 LIKE type_t.chr100, 
   l_xmda021_pmaal004 LIKE type_t.chr100, 
   l_xmda004_t1_pmaal004 LIKE type_t.chr100, 
   l_xmda003_ooefl003 LIKE type_t.chr1000, 
   l_xmdasite_ooefl003 LIKE type_t.chr1000, 
   l_xmda002_ooag011 LIKE type_t.chr300, 
   l_xmda204_prcfl003 LIKE type_t.chr1000, 
   l_xmda203_pmaal004 LIKE type_t.chr100, 
   l_xmda202_ooefl003 LIKE type_t.chr1000, 
   l_xmja005_prcfl003 LIKE type_t.chr1000, 
   l_xmja024_pmaal004 LIKE type_t.chr100, 
   l_xmja025_pmaal004 LIKE type_t.chr100, 
   l_xmjasite_ooefl003 LIKE type_t.chr1000, 
   l_imaal003 LIKE imaal_t.imaal003, 
   l_imaal004 LIKE imaal_t.imaal004, 
   l_xmja025_desc LIKE type_t.chr1000, 
   l_xmdc007 LIKE xmdc_t.xmdc007, 
   l_xmdc006 LIKE xmdc_t.xmdc006, 
   l_xmdc015 LIKE xmdc_t.xmdc015, 
   l_xmda023_oojdl003 LIKE type_t.chr100
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
 
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH adbr500_g01_curs INTO sr_s.*
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
       #160420-00039#2 Mark By ken 160628(S)效能調整
       ##品名,規格
       #SELECT imaal003,imaa004 INTO sr_s.l_imaal003,sr_s.l_imaal004
       #  FROM imaalt
       # WHERE imaalent = g_enterprise
       #   AND imaal001 = sr_s.xmja003       
       #   AND imaal002 = g_dlang
       ##訂單數量,單位,單價
       #SELECT xmdc007,xmdc006,xmdc015 INTO sr_s.l_xmdc007,sr_s.l_xmdc006,sr_s.l_xmdc015
       #  FROM xmdc_t
       # WHERE xmdcent = g_enterprise
       #   AND xmdcdocno = sr_s.xmdadocno       
       #   AND xmdcseq = sr_s.xmjaseq
       #160420-00039#2 Mark By ken 160628(E)效能調整
       
       #當前面編號為空時，清空編號.說明的字串(避免編號為空會只顯示一個 .)
       CALL adbr500_g01_initialize(sr_s.xmda004,sr_s.l_xmda004_pmaal004) RETURNING sr_s.l_xmda004_pmaal004
       CALL adbr500_g01_initialize(sr_s.xmda021,sr_s.l_xmda021_pmaal004) RETURNING sr_s.l_xmda021_pmaal004
       CALL adbr500_g01_initialize(sr_s.xmda200,sr_s.l_xmda200_pmaal004) RETURNING sr_s.l_xmda200_pmaal004
       CALL adbr500_g01_initialize(sr_s.xmda201,sr_s.l_xmda201_pmaal004) RETURNING sr_s.l_xmda201_pmaal004
       CALL adbr500_g01_initialize(sr_s.xmda023,sr_s.l_xmda023_oojdl003) RETURNING sr_s.l_xmda023_oojdl003
       CALL adbr500_g01_initialize(sr_s.xmda202,sr_s.l_xmda202_ooefl003) RETURNING sr_s.l_xmda202_ooefl003
       CALL adbr500_g01_initialize(sr_s.xmda002,sr_s.l_xmda002_ooag011) RETURNING sr_s.l_xmda002_ooag011
       CALL adbr500_g01_initialize(sr_s.xmda003,sr_s.l_xmda003_ooefl003) RETURNING sr_s.l_xmda003_ooefl003
       CALL adbr500_g01_initialize(sr_s.xmja025,sr_s.l_xmja025_pmaal004) RETURNING sr_s.l_xmja025_pmaal004
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].xmda001 = sr_s.xmda001
       LET sr[l_cnt].xmda002 = sr_s.xmda002
       LET sr[l_cnt].xmda003 = sr_s.xmda003
       LET sr[l_cnt].xmda004 = sr_s.xmda004
       LET sr[l_cnt].xmda005 = sr_s.xmda005
       LET sr[l_cnt].xmda006 = sr_s.xmda006
       LET sr[l_cnt].xmda007 = sr_s.xmda007
       LET sr[l_cnt].xmda008 = sr_s.xmda008
       LET sr[l_cnt].xmda009 = sr_s.xmda009
       LET sr[l_cnt].xmda010 = sr_s.xmda010
       LET sr[l_cnt].xmda011 = sr_s.xmda011
       LET sr[l_cnt].xmda012 = sr_s.xmda012
       LET sr[l_cnt].xmda013 = sr_s.xmda013
       LET sr[l_cnt].xmda015 = sr_s.xmda015
       LET sr[l_cnt].xmda016 = sr_s.xmda016
       LET sr[l_cnt].xmda017 = sr_s.xmda017
       LET sr[l_cnt].xmda018 = sr_s.xmda018
       LET sr[l_cnt].xmda019 = sr_s.xmda019
       LET sr[l_cnt].xmda020 = sr_s.xmda020
       LET sr[l_cnt].xmda021 = sr_s.xmda021
       LET sr[l_cnt].xmda022 = sr_s.xmda022
       LET sr[l_cnt].xmda023 = sr_s.xmda023
       LET sr[l_cnt].xmda024 = sr_s.xmda024
       LET sr[l_cnt].xmda025 = sr_s.xmda025
       LET sr[l_cnt].xmda026 = sr_s.xmda026
       LET sr[l_cnt].xmda027 = sr_s.xmda027
       LET sr[l_cnt].xmda028 = sr_s.xmda028
       LET sr[l_cnt].xmda030 = sr_s.xmda030
       LET sr[l_cnt].xmda031 = sr_s.xmda031
       LET sr[l_cnt].xmda032 = sr_s.xmda032
       LET sr[l_cnt].xmda033 = sr_s.xmda033
       LET sr[l_cnt].xmda034 = sr_s.xmda034
       LET sr[l_cnt].xmda035 = sr_s.xmda035
       LET sr[l_cnt].xmda036 = sr_s.xmda036
       LET sr[l_cnt].xmda039 = sr_s.xmda039
       LET sr[l_cnt].xmda041 = sr_s.xmda041
       LET sr[l_cnt].xmda042 = sr_s.xmda042
       LET sr[l_cnt].xmda043 = sr_s.xmda043
       LET sr[l_cnt].xmda045 = sr_s.xmda045
       LET sr[l_cnt].xmda046 = sr_s.xmda046
       LET sr[l_cnt].xmda047 = sr_s.xmda047
       LET sr[l_cnt].xmda048 = sr_s.xmda048
       LET sr[l_cnt].xmda049 = sr_s.xmda049
       LET sr[l_cnt].xmda071 = sr_s.xmda071
       LET sr[l_cnt].xmda200 = sr_s.xmda200
       LET sr[l_cnt].xmda201 = sr_s.xmda201
       LET sr[l_cnt].xmda202 = sr_s.xmda202
       LET sr[l_cnt].xmda203 = sr_s.xmda203
       LET sr[l_cnt].xmda204 = sr_s.xmda204
       LET sr[l_cnt].xmda205 = sr_s.xmda205
       LET sr[l_cnt].xmda206 = sr_s.xmda206
       LET sr[l_cnt].xmda207 = sr_s.xmda207
       LET sr[l_cnt].xmda208 = sr_s.xmda208
       LET sr[l_cnt].xmda209 = sr_s.xmda209
       LET sr[l_cnt].xmda210 = sr_s.xmda210
       LET sr[l_cnt].xmda211 = sr_s.xmda211
       LET sr[l_cnt].xmda213 = sr_s.xmda213
       LET sr[l_cnt].xmdadocdt = sr_s.xmdadocdt
       LET sr[l_cnt].xmdadocno = sr_s.xmdadocno
       LET sr[l_cnt].xmdaent = sr_s.xmdaent
       LET sr[l_cnt].xmdasite = sr_s.xmdasite
       LET sr[l_cnt].xmdastus = sr_s.xmdastus
       LET sr[l_cnt].xmdaunit = sr_s.xmdaunit
       LET sr[l_cnt].xmja001 = sr_s.xmja001
       LET sr[l_cnt].xmja002 = sr_s.xmja002
       LET sr[l_cnt].xmja003 = sr_s.xmja003
       LET sr[l_cnt].xmja004 = sr_s.xmja004
       LET sr[l_cnt].xmja005 = sr_s.xmja005
       LET sr[l_cnt].xmja006 = sr_s.xmja006
       LET sr[l_cnt].xmja007 = sr_s.xmja007
       LET sr[l_cnt].xmja008 = sr_s.xmja008
       LET sr[l_cnt].xmja009 = sr_s.xmja009
       LET sr[l_cnt].xmja010 = sr_s.xmja010
       LET sr[l_cnt].xmja011 = sr_s.xmja011
       LET sr[l_cnt].xmja012 = sr_s.xmja012
       LET sr[l_cnt].xmja013 = sr_s.xmja013
       LET sr[l_cnt].xmja014 = sr_s.xmja014
       LET sr[l_cnt].xmja015 = sr_s.xmja015
       LET sr[l_cnt].xmja016 = sr_s.xmja016
       LET sr[l_cnt].xmja017 = sr_s.xmja017
       LET sr[l_cnt].xmja018 = sr_s.xmja018
       LET sr[l_cnt].xmja019 = sr_s.xmja019
       LET sr[l_cnt].xmja020 = sr_s.xmja020
       LET sr[l_cnt].xmja021 = sr_s.xmja021
       LET sr[l_cnt].xmja022 = sr_s.xmja022
       LET sr[l_cnt].xmja024 = sr_s.xmja024
       LET sr[l_cnt].xmja025 = sr_s.xmja025
       LET sr[l_cnt].xmja026 = sr_s.xmja026
       LET sr[l_cnt].xmja027 = sr_s.xmja027
       LET sr[l_cnt].xmja028 = sr_s.xmja028
       LET sr[l_cnt].xmja029 = sr_s.xmja029
       LET sr[l_cnt].xmja030 = sr_s.xmja030
       LET sr[l_cnt].xmja031 = sr_s.xmja031
       LET sr[l_cnt].xmja032 = sr_s.xmja032
       LET sr[l_cnt].xmja033 = sr_s.xmja033
       LET sr[l_cnt].xmja034 = sr_s.xmja034
       LET sr[l_cnt].xmja037 = sr_s.xmja037
       LET sr[l_cnt].xmja038 = sr_s.xmja038
       LET sr[l_cnt].xmja039 = sr_s.xmja039
       LET sr[l_cnt].xmja040 = sr_s.xmja040
       LET sr[l_cnt].xmjaseq = sr_s.xmjaseq
       LET sr[l_cnt].xmjasite = sr_s.xmjasite
       LET sr[l_cnt].xmjaunit = sr_s.xmjaunit
       LET sr[l_cnt].ooag_t_ooag011 = sr_s.ooag_t_ooag011
       LET sr[l_cnt].ooefl_t_ooefl003 = sr_s.ooefl_t_ooefl003
       LET sr[l_cnt].t2_ooefl003 = sr_s.t2_ooefl003
       LET sr[l_cnt].t3_ooefl003 = sr_s.t3_ooefl003
       LET sr[l_cnt].t8_ooefl003 = sr_s.t8_ooefl003
       LET sr[l_cnt].x_t27_ooefl003 = sr_s.x_t27_ooefl003
       LET sr[l_cnt].t14_pmaal003 = sr_s.t14_pmaal003
       LET sr[l_cnt].t1_pmaal004 = sr_s.t1_pmaal004
       LET sr[l_cnt].t7_pmaal004 = sr_s.t7_pmaal004
       LET sr[l_cnt].t10_pmaal004 = sr_s.t10_pmaal004
       LET sr[l_cnt].t11_pmaal004 = sr_s.t11_pmaal004
       LET sr[l_cnt].pmaal_t_pmaal004 = sr_s.pmaal_t_pmaal004
       LET sr[l_cnt].t17_pmaal004 = sr_s.t17_pmaal004
       LET sr[l_cnt].t15_pmaal004 = sr_s.t15_pmaal004
       LET sr[l_cnt].t16_pmaal004 = sr_s.t16_pmaal004
       LET sr[l_cnt].x_t22_pmaal004 = sr_s.x_t22_pmaal004
       LET sr[l_cnt].x_t23_pmaal004 = sr_s.x_t23_pmaal004
       LET sr[l_cnt].ooibl_t_ooibl004 = sr_s.ooibl_t_ooibl004
       LET sr[l_cnt].oocql_t_oocql004 = sr_s.oocql_t_oocql004
       LET sr[l_cnt].t9_oocql004 = sr_s.t9_oocql004
       LET sr[l_cnt].t12_oocql004 = sr_s.t12_oocql004
       LET sr[l_cnt].t13_oocql004 = sr_s.t13_oocql004
       LET sr[l_cnt].ooail_t_ooail003 = sr_s.ooail_t_ooail003
       LET sr[l_cnt].pmaml_t_pmaml003 = sr_s.pmaml_t_pmaml003
       LET sr[l_cnt].ooidl_t_ooidl003 = sr_s.ooidl_t_ooidl003
       LET sr[l_cnt].oojdl_t_oojdl003 = sr_s.oojdl_t_oojdl003
       LET sr[l_cnt].oofa_t_oofa011 = sr_s.oofa_t_oofa011
       LET sr[l_cnt].prcfl_t_prcfl003 = sr_s.prcfl_t_prcfl003
       LET sr[l_cnt].x_t18_prcfl003 = sr_s.x_t18_prcfl003
       LET sr[l_cnt].dbadl_t_dbadl003 = sr_s.dbadl_t_dbadl003
       LET sr[l_cnt].x_t21_dbadl003 = sr_s.x_t21_dbadl003
       LET sr[l_cnt].dbabl_t_dbabl003 = sr_s.dbabl_t_dbabl003
       LET sr[l_cnt].dbaal_t_dbaal003 = sr_s.dbaal_t_dbaal003
       LET sr[l_cnt].t4_dbaal003 = sr_s.t4_dbaal003
       LET sr[l_cnt].t5_dbaal003 = sr_s.t5_dbaal003
       LET sr[l_cnt].t6_dbaal003 = sr_s.t6_dbaal003
       LET sr[l_cnt].x_t19_dbaal003 = sr_s.x_t19_dbaal003
       LET sr[l_cnt].x_t20_dbaal003 = sr_s.x_t20_dbaal003
       LET sr[l_cnt].x_t28_dbaal003 = sr_s.x_t28_dbaal003
       LET sr[l_cnt].x_t29_dbaal003 = sr_s.x_t29_dbaal003
       LET sr[l_cnt].x_imaal_t_imaal003 = sr_s.x_imaal_t_imaal003
       LET sr[l_cnt].x_oocal_t_oocal003 = sr_s.x_oocal_t_oocal003
       LET sr[l_cnt].x_t24_oocal003 = sr_s.x_t24_oocal003
       LET sr[l_cnt].x_t25_oocal003 = sr_s.x_t25_oocal003
       LET sr[l_cnt].x_t26_oocal003 = sr_s.x_t26_oocal003
       LET sr[l_cnt].l_xmdaunit_ooefl003 = sr_s.l_xmdaunit_ooefl003
       LET sr[l_cnt].l_xmda200_pmaal004 = sr_s.l_xmda200_pmaal004
       LET sr[l_cnt].l_xmda036_pmaal004 = sr_s.l_xmda036_pmaal004
       LET sr[l_cnt].l_xmda201_pmaal004 = sr_s.l_xmda201_pmaal004
       LET sr[l_cnt].l_xmda004_pmaal004 = sr_s.l_xmda004_pmaal004
       LET sr[l_cnt].l_xmda034_pmaal003 = sr_s.l_xmda034_pmaal003
       LET sr[l_cnt].l_xmda022_pmaal004 = sr_s.l_xmda022_pmaal004
       LET sr[l_cnt].l_xmda021_pmaal004 = sr_s.l_xmda021_pmaal004
       LET sr[l_cnt].l_xmda004_t1_pmaal004 = sr_s.l_xmda004_t1_pmaal004
       LET sr[l_cnt].l_xmda003_ooefl003 = sr_s.l_xmda003_ooefl003
       LET sr[l_cnt].l_xmdasite_ooefl003 = sr_s.l_xmdasite_ooefl003
       LET sr[l_cnt].l_xmda002_ooag011 = sr_s.l_xmda002_ooag011
       LET sr[l_cnt].l_xmda204_prcfl003 = sr_s.l_xmda204_prcfl003
       LET sr[l_cnt].l_xmda203_pmaal004 = sr_s.l_xmda203_pmaal004
       LET sr[l_cnt].l_xmda202_ooefl003 = sr_s.l_xmda202_ooefl003
       LET sr[l_cnt].l_xmja005_prcfl003 = sr_s.l_xmja005_prcfl003
       LET sr[l_cnt].l_xmja024_pmaal004 = sr_s.l_xmja024_pmaal004
       LET sr[l_cnt].l_xmja025_pmaal004 = sr_s.l_xmja025_pmaal004
       LET sr[l_cnt].l_xmjasite_ooefl003 = sr_s.l_xmjasite_ooefl003
       LET sr[l_cnt].l_imaal003 = sr_s.l_imaal003
       LET sr[l_cnt].l_imaal004 = sr_s.l_imaal004
       LET sr[l_cnt].l_xmja025_desc = sr_s.l_xmja025_desc
       LET sr[l_cnt].l_xmdc007 = sr_s.l_xmdc007
       LET sr[l_cnt].l_xmdc006 = sr_s.l_xmdc006
       LET sr[l_cnt].l_xmdc015 = sr_s.l_xmdc015
       LET sr[l_cnt].l_xmda023_oojdl003 = sr_s.l_xmda023_oojdl003
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="adbr500_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION adbr500_g01_rep_data()
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
          START REPORT adbr500_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT adbr500_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT adbr500_g01_rep
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
 
{<section id="adbr500_g01.rep" readonly="Y" >}
PRIVATE REPORT adbr500_g01_rep(sr1)
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
DEFINE sr4 sr4_r
DEFINE l_xmddseq1_o      LIKE xmdd_t.xmddseq1
DEFINE l_xmja004_show    LIKE type_t.chr1
DEFINE l_xmda071_show    LIKE type_t.chr1
DEFINE l_xmja034_show    LIKE type_t.chr1
DEFINE l_subrep05_show   LIKE type_t.chr1
DEFINE l_subrep06_show   LIKE type_t.chr1
DEFINE l_ooef017         LIKE ooef_t.ooef017   #法人
DEFINE l_g_site_t        LIKE ooef_t.ooef001   #儲存g_site值
DEFINE l_ooef012         LIKE ooef_t.ooef012   #聯絡對象識別碼
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER EXTERNAL BY sr1.xmdadocno,sr1.xmjaseq
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
        BEFORE GROUP OF sr1.xmdadocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            #取法人對內名稱
            SELECT ooef017 INTO l_ooef017 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = sr1.xmdasite               
            LET l_g_site_t = g_site #備份g_site預設值
            LET g_site = l_ooef017  #抓法人資料
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.xmdadocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
            
            LET g_site = l_g_site_t #恢復原g_site值
            
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'xmdaent=' ,sr1.xmdaent,'{+}xmdadocno=' ,sr1.xmdadocno         
            CALL cl_gr_init_apr(sr1.xmdadocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
 
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.xmdadocno.before name="rep.b_group.xmdadocno.before"
           #單頭備註若為空，則整行隱藏
           IF tm.a3 = 'Y' THEN
              IF cl_null(sr1.xmda071) THEN
                 LET l_xmda071_show = 'N'
              ELSE
                 LET l_xmda071_show = 'Y'
              END IF             
           ELSE
              LET l_xmda071_show = 'N'
           END IF
           PRINTX l_xmda071_show        
           
           #LET l_subrep05_show = 'N'
           START REPORT adbr500_g01_subrep05
              #LET l_subrep05_show = 'Y'
              LET g_sql = " SELECT xmdbdocno,xmdb001,xmdb002,NULL,xmdb003,xmdb004,xmdb005,xmdb006 ",
                          "   FROM xmdb_t ",
                          "  WHERE xmdbent = '",sr1.xmdaent,"' ",
                          "    AND xmdbdocno = '",sr1.xmdadocno CLIPPED,"'",
                          "  ORDER BY xmdb001 "
              DECLARE adbr500_g01_repcur05 CURSOR FROM g_sql
              FOREACH adbr500_g01_repcur05 INTO sr3.*
                 IF STATUS THEN INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = STATUS
                    LET g_errparam.extend = 'adbr500_g01_repcur05:'
                    LET g_errparam.popup = TRUE
                    CALL cl_err()
                    EXIT FOREACH 
                 END IF
                 CALL s_desc_get_ooib002_desc(sr3.xmdb002) RETURNING sr3.l_xmdb002_desc
                 
                 OUTPUT TO REPORT adbr500_g01_subrep05(sr3.*)
              END FOREACH
           FINISH REPORT adbr500_g01_subrep05
           PRINTX l_subrep05_show
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.xmdaent CLIPPED ,"'", " AND  ooff003 = '", sr1.xmdadocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE adbr500_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE adbr500_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT adbr500_g01_subrep01
           DECLARE adbr500_g01_repcur01 CURSOR FROM g_sql
           FOREACH adbr500_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "adbr500_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT adbr500_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT adbr500_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.xmdadocno.after name="rep.b_group.xmdadocno.after"
 
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.xmjaseq
 
           #add-point:rep.b_group.xmjaseq.before name="rep.b_group.xmjaseq.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.xmjaseq.after name="rep.b_group.xmjaseq.after"
           
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
                sr1.xmdaent CLIPPED ,"'", " AND  ooff003 = '", sr1.xmdadocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.xmjaseq CLIPPED ,""
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE adbr500_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE adbr500_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT adbr500_g01_subrep02
           DECLARE adbr500_g01_repcur02 CURSOR FROM g_sql
           FOREACH adbr500_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "adbr500_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT adbr500_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT adbr500_g01_subrep02
           #add-point:rep.sub02.after name="rep.sub02.after"
           
           #end add-point:rep.sub02.after
 
 
 
          #add-point:rep.everyrow.beforerow name="rep.everyrow.beforerow"
          #特徵碼若無值，則整行隱藏
          IF cl_null(sr1.xmja004) THEN
             LET l_xmja004_show = 'N'
          ELSE
             LET l_xmja004_show = 'Y'
          END IF
          PRINTX l_xmja004_show
          #單頭備註若為空，則整行隱藏
          IF tm.a3 = 'Y' THEN
             IF cl_null(sr1.xmja034) THEN
                LET l_xmja034_show = 'N'
             ELSE
                LET l_xmja034_show = 'Y'
             END IF             
          ELSE
             LET l_xmja034_show = 'N'
          END IF
          PRINTX l_xmja034_show            
          #end add-point:rep.everyrow.beforerow
            
          PRINTX sr1.*
 
          #add-point:rep.everyrow.afterrow name="rep.everyrow.afterrow"
            LET l_subrep06_show ='N'
            START REPORT adbr500_g01_subrep06            
            IF tm.a2 = 'Y' THEN
               LET l_subrep06_show ='Y'
               IF NOT cl_null(sr1.xmjaseq) AND sr1.xmjaseq > 0 THEN
                  LET g_sql = "SELECT xmdddocno,xmddseq,xmddseq1,xmddseq2,xmdd001,xmdd002,xmdd003, ",
                              "       xmdd004,xmdd006,xmdd011,NULL,NULL,NULL,'0' ",
                              "  FROM xmdd_t ",
                              " WHERE xmddent = '",sr1.xmdaent,"'",
                              "   AND xmdddocno = '",sr1.xmdadocno CLIPPED,"' ",
                              "   AND xmddseq = ",sr1.xmjaseq CLIPPED,
                              " ORDER BY xmddseq1,xmddseq2 "
                  LET g_sql_cnt = " SELECT COUNT(*) FROM (",g_sql,")"
                  PREPARE adbr500_g01_subrep06_cnt_pre FROM g_sql_cnt
                  
                  LET g_cnt = 0
                  EXECUTE adbr500_g01_subrep06_cnt_pre INTO g_cnt
                  FREE adbr500_g01_subrep06_cnt_pre
                  
                  IF g_cnt > 1 THEN
                     PREPARE adbr500_g01_subrep06_cnt_pre01 FROM g_sql_cnt
                     LET g_cnt = 0
                     EXECUTE adbr500_g01_subrep06_cnt_pre01 INTO g_cnt
                     FREE adbr500_g01_subrep06_cnt_pre01
                     
                     LET l_xmddseq1_o = 0                  
                     
                     DECLARE adbr500_g01_repcur06 CURSOR FROM g_sql
                     FOREACH adbr500_g01_repcur06 INTO sr4.*
                        IF STATUS THEN INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = STATUS
                           LET g_errparam.extend = 'adbr500_g01_repcur03:'
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           EXIT FOREACH 
                       END IF
                     
                        #子件特性
                        CALL s_desc_gzcbl004_desc('2055',sr4.xmdd003) RETURNING sr4.l_xmdd003_desc
                        LET sr4.l_xmdd003_desc = sr4.xmdd003 CLIPPED,'.',sr4.l_xmdd003_desc CLIPPED
                        OUTPUT TO REPORT adbr500_g01_subrep06(sr4.*)
                        LET l_xmddseq1_o = sr4.xmddseq1
                     END FOREACH
                  END IF
               END IF
            END IF
            FINISH REPORT adbr500_g01_subrep06
            PRINTX l_subrep06_show
          #end add-point:rep.everyrow.afterrow
 
          #單身後備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub03.before name="rep.sub03.before"
           
           #end add-point:rep.sub03.before
 
           #add-point:rep.sub03.sql name="rep.sub03.sql"
           
           #end add-point:rep.sub03.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooffent = '", 
                sr1.xmdaent CLIPPED ,"'", " AND  ooff003 = '", sr1.xmdadocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.xmjaseq CLIPPED ,""
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE adbr500_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE adbr500_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT adbr500_g01_subrep03
           DECLARE adbr500_g01_repcur03 CURSOR FROM g_sql
           FOREACH adbr500_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "adbr500_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT adbr500_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT adbr500_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.xmdadocno
 
           #add-point:rep.a_group.xmdadocno.before name="rep.a_group.xmdadocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.xmdaent CLIPPED ,"'", " AND  ooff003 = '", sr1.xmdadocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE adbr500_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE adbr500_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT adbr500_g01_subrep04
           DECLARE adbr500_g01_repcur04 CURSOR FROM g_sql
           FOREACH adbr500_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "adbr500_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT adbr500_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT adbr500_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.xmdadocno.after name="rep.a_group.xmdadocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.xmjaseq
 
           #add-point:rep.a_group.xmjaseq.before name="rep.a_group.xmjaseq.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.xmjaseq.after name="rep.a_group.xmjaseq.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="adbr500_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT adbr500_g01_subrep01(sr2)
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
PRIVATE REPORT adbr500_g01_subrep02(sr2)
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
PRIVATE REPORT adbr500_g01_subrep03(sr2)
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
PRIVATE REPORT adbr500_g01_subrep04(sr2)
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
 
{<section id="adbr500_g01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL adbr500_g01_initialize(p_arg,p_exp)
#                  RETURNING r_exp
# Input parameter: p_arg    編號
#                : p_exp    說明
# Return code....: r_exp    顯示值
# Date & Author..: 2015/03/30 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION adbr500_g01_initialize(p_arg,p_exp)
DEFINE p_arg   STRING
DEFINE p_exp   STRING
DEFINE r_exp   STRING
   INITIALIZE r_exp TO NULL
   IF cl_null(p_arg) OR p_exp = '.' THEN
      #INITIALIZE r_exp TO NULL
      LET r_exp = p_arg
   ELSE
      LET r_exp = p_exp
   END IF
RETURN r_exp
END FUNCTION

 
{</section>}
 
{<section id="adbr500_g01.other_report" readonly="Y" >}

################################################################################
# Descriptions...: 多帳期子報表
# Memo...........:
# Usage..........: CALL adbr500_g01_subrep05(sr3)
# Input parameter: sr3            資料RECORD
# Return code....: 無
# Date & Author..: 2015/01/29 By sakura
# Modify.........:
################################################################################
PRIVATE REPORT adbr500_g01_subrep05(sr3)
DEFINE sr3     sr3_r

   ORDER EXTERNAL BY sr3.xmdbdocno
      FORMAT
   
         ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr3.*
END REPORT

################################################################################
# Descriptions...: 多交期報表
# Memo...........:
# Usage..........: CALL adbr500_g01_subrep06(sr4)
# Input parameter: sr4            資料RECORD
# Return code....: 無
# Date & Author..: 2015/01/29 By sakura
# Modify.........:
################################################################################
PRIVATE REPORT adbr500_g01_subrep06(sr4)
DEFINE sr4             sr4_r

   ORDER EXTERNAL BY sr4.xmdddocno,sr4.xmddseq
      FORMAT
   
         ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr4.*
END REPORT

 
{</section>}
 
