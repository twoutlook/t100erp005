#該程式未解開Section, 採用最新樣板產出!
{<section id="apmr400_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:6(2016-11-01 20:48:05), PR版次:0006(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000314
#+ Filename...: apmr400_g01
#+ Description: ...
#+ Creator....: 05231(2014-04-24 13:50:43)
#+ Modifier...: 08734 -SD/PR- 00000
 
{</section>}
 
{<section id="apmr400_g01.global" readonly="Y" >}
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
   pmda001 LIKE pmda_t.pmda001, 
   pmda002 LIKE pmda_t.pmda002, 
   pmda003 LIKE pmda_t.pmda003, 
   pmda004 LIKE pmda_t.pmda004, 
   pmda005 LIKE pmda_t.pmda005, 
   pmda006 LIKE pmda_t.pmda006, 
   pmda007 LIKE pmda_t.pmda007, 
   pmda008 LIKE pmda_t.pmda008, 
   pmda009 LIKE pmda_t.pmda009, 
   pmda010 LIKE pmda_t.pmda010, 
   pmda011 LIKE pmda_t.pmda011, 
   pmda012 LIKE pmda_t.pmda012, 
   pmda020 LIKE pmda_t.pmda020, 
   pmda021 LIKE pmda_t.pmda021, 
   pmda022 LIKE pmda_t.pmda022, 
   pmdadocdt LIKE pmda_t.pmdadocdt, 
   pmdadocno LIKE pmda_t.pmdadocno, 
   pmdaent LIKE pmda_t.pmdaent, 
   pmdasite LIKE pmda_t.pmdasite, 
   pmdastus LIKE pmda_t.pmdastus, 
   pmdb001 LIKE pmdb_t.pmdb001, 
   pmdb002 LIKE pmdb_t.pmdb002, 
   pmdb003 LIKE pmdb_t.pmdb003, 
   pmdb004 LIKE pmdb_t.pmdb004, 
   pmdb005 LIKE pmdb_t.pmdb005, 
   pmdb006 LIKE pmdb_t.pmdb006, 
   pmdb007 LIKE pmdb_t.pmdb007, 
   pmdb008 LIKE pmdb_t.pmdb008, 
   pmdb009 LIKE pmdb_t.pmdb009, 
   pmdb010 LIKE pmdb_t.pmdb010, 
   pmdb011 LIKE pmdb_t.pmdb011, 
   pmdb012 LIKE pmdb_t.pmdb012, 
   pmdb014 LIKE pmdb_t.pmdb014, 
   pmdb015 LIKE pmdb_t.pmdb015, 
   pmdb016 LIKE pmdb_t.pmdb016, 
   pmdb017 LIKE pmdb_t.pmdb017, 
   pmdb018 LIKE pmdb_t.pmdb018, 
   pmdb019 LIKE pmdb_t.pmdb019, 
   pmdb020 LIKE pmdb_t.pmdb020, 
   pmdb021 LIKE pmdb_t.pmdb021, 
   pmdb030 LIKE pmdb_t.pmdb030, 
   pmdb031 LIKE pmdb_t.pmdb031, 
   pmdb032 LIKE pmdb_t.pmdb032, 
   pmdb033 LIKE pmdb_t.pmdb033, 
   pmdb034 LIKE pmdb_t.pmdb034, 
   pmdb035 LIKE pmdb_t.pmdb035, 
   pmdb036 LIKE pmdb_t.pmdb036, 
   pmdb037 LIKE pmdb_t.pmdb037, 
   pmdb038 LIKE pmdb_t.pmdb038, 
   pmdb039 LIKE pmdb_t.pmdb039, 
   pmdb040 LIKE pmdb_t.pmdb040, 
   pmdb041 LIKE pmdb_t.pmdb041, 
   pmdb042 LIKE pmdb_t.pmdb042, 
   pmdb043 LIKE pmdb_t.pmdb043, 
   pmdb044 LIKE pmdb_t.pmdb044, 
   pmdb045 LIKE pmdb_t.pmdb045, 
   pmdb046 LIKE pmdb_t.pmdb046, 
   pmdb048 LIKE pmdb_t.pmdb048, 
   pmdb049 LIKE pmdb_t.pmdb049, 
   pmdb050 LIKE pmdb_t.pmdb050, 
   pmdb051 LIKE pmdb_t.pmdb051, 
   pmdbseq LIKE pmdb_t.pmdbseq, 
   pmdbsite LIKE pmdb_t.pmdbsite, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   t1_ooefl003 LIKE ooefl_t.ooefl003, 
   x_t4_ooefl003 LIKE ooefl_t.ooefl003, 
   x_t5_ooefl003 LIKE ooefl_t.ooefl003, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   ooail_t_ooail003 LIKE ooail_t.ooail003, 
   oocql_t_oocql004 LIKE oocql_t.oocql004, 
   x_t2_oocql004 LIKE oocql_t.oocql004, 
   x_t3_oocql004 LIKE oocql_t.oocql004, 
   x_t6_oocql004 LIKE oocql_t.oocql004, 
   x_t7_oocql004 LIKE oocql_t.oocql004, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   x_t10_imaal003 LIKE imaal_t.imaal003, 
   x_oocal_t_oocal003 LIKE oocal_t.oocal003, 
   x_t8_oocal003 LIKE oocal_t.oocal003, 
   x_t9_oocal003 LIKE oocal_t.oocal003, 
   x_pmaal_t_pmaal004 LIKE pmaal_t.pmaal004, 
   x_ooibl_t_ooibl004 LIKE ooibl_t.ooibl004, 
   l_pmdb014_pmdb015 LIKE type_t.chr20, 
   x_t10_imaal004 LIKE imaal_t.imaal004, 
   l_pmda002_ooag011 LIKE type_t.chr20, 
   l_pmda010_desc LIKE type_t.chr80, 
   l_pmdb033_desc LIKE type_t.chr30, 
   l_pmda003_ooefl003 LIKE type_t.chr80, 
   l_pmda007_ooefl003 LIKE type_t.chr80, 
   l_pmdb014_desc LIKE type_t.chr200, 
   l_pmdb015_pmaal004 LIKE type_t.chr200
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
 
#end add-point
 
{</section>}
 
{<section id="apmr400_g01.main" readonly="Y" >}
PUBLIC FUNCTION apmr400_g01(p_arg1)
DEFINE  p_arg1 STRING                  #tm.wc  where condition
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"

#end add-point
 
   LET tm.wc = p_arg1
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "apmr400_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL apmr400_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL apmr400_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL apmr400_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="apmr400_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apmr400_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
 
   #end add-point
   LET g_select = " SELECT pmda001,pmda002,pmda003,pmda004,pmda005,pmda006,pmda007,pmda008,pmda009,pmda010, 
       pmda011,pmda012,pmda020,pmda021,pmda022,pmdadocdt,pmdadocno,pmdaent,pmdasite,pmdastus,pmdb001, 
       pmdb002,pmdb003,pmdb004,pmdb005,pmdb006,pmdb007,pmdb008,pmdb009,pmdb010,pmdb011,pmdb012,pmdb014, 
       pmdb015,pmdb016,pmdb017,pmdb018,pmdb019,pmdb020,pmdb021,pmdb030,pmdb031,pmdb032,pmdb033,pmdb034, 
       pmdb035,pmdb036,pmdb037,pmdb038,pmdb039,pmdb040,pmdb041,pmdb042,pmdb043,pmdb044,pmdb045,pmdb046, 
       pmdb048,pmdb049,pmdb050,pmdb051,pmdbseq,pmdbsite,( SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = pmda_t.pmda002 AND ooag_t.ooagent = pmda_t.pmdaent), 
       ( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = pmda_t.pmda003 AND ooefl_t.ooeflent = pmda_t.pmdaent AND ooefl_t.ooefl002 = '" , 
       g_dlang,"'" ,"),x.t4_ooefl003,x.t5_ooefl003,( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = pmda_t.pmda007 AND ooefl_t.ooeflent = pmda_t.pmdaent AND ooefl_t.ooefl002 = '" , 
       g_dlang,"'" ,"),( SELECT ooail003 FROM ooail_t WHERE ooail_t.ooail001 = pmda_t.pmda005 AND ooail_t.ooailent = pmda_t.pmdaent AND ooail_t.ooail002 = '" , 
       g_dlang,"'" ,"),( SELECT oocql004 FROM oocql_t WHERE oocql_t.oocql001 = '263' AND oocql_t.oocql002 = pmda_t.pmda021 AND oocql_t.oocqlent = pmda_t.pmdaent AND oocql_t.oocql003 = '" , 
       g_dlang,"'" ,"),x.t2_oocql004,x.t3_oocql004,x.t6_oocql004,x.t7_oocql004,x.imaal_t_imaal003,x.t10_imaal003, 
       x.oocal_t_oocal003,x.t8_oocal003,x.t9_oocal003,x.pmaal_t_pmaal004,x.ooibl_t_ooibl004,trim(pmdb014)||'.'||trim(pmdb015), 
       x.t10_imaal004,trim(pmda002)||'.'||trim((SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = pmda_t.pmda002 AND ooag_t.ooagent = pmda_t.pmdaent)), 
       '','',trim(pmda003)||'.'||trim((SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = pmda_t.pmda003 AND ooefl_t.ooeflent = pmda_t.pmdaent AND ooefl_t.ooefl002 = '" , 
       g_dlang,"'" ,")),trim(pmda007)||'.'||trim((SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = pmda_t.pmda007 AND ooefl_t.ooeflent = pmda_t.pmdaent AND ooefl_t.ooefl002 = '" , 
       g_dlang,"'" ,")),'',trim(pmdb015)||'.'||trim(x.pmaal_t_pmaal004)"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
 
   #end add-point
    LET g_from = " FROM pmda_t LEFT OUTER JOIN ( SELECT pmdb_t.*,( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = pmdb_t.pmdb037 AND ooefl_t.ooeflent = pmdb_t.pmdbent AND ooefl_t.ooefl002 = '" , 
        g_dlang,"'" ,") t4_ooefl003,( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = pmdb_t.pmdb046 AND ooefl_t.ooeflent = pmdb_t.pmdbent AND ooefl_t.ooefl002 = '" , 
        g_dlang,"'" ,") t5_ooefl003,( SELECT oocql004 FROM oocql_t WHERE oocql_t.oocql001 = '238' AND oocql_t.oocql002 = pmdb_t.pmdb017 AND oocql_t.oocqlent = pmdb_t.pmdbent AND oocql_t.oocql003 = '" , 
        g_dlang,"'" ,") t2_oocql004,( SELECT oocql004 FROM oocql_t WHERE oocql_t.oocql001 = '265' AND oocql_t.oocql002 = pmdb_t.pmdb031 AND oocql_t.oocqlent = pmdb_t.pmdbent AND oocql_t.oocql003 = '" , 
        g_dlang,"'" ,") t3_oocql004,( SELECT oocql004 FROM oocql_t WHERE oocql_t.oocql001 = '274' AND oocql_t.oocql002 = pmdb_t.pmdb048 AND oocql_t.oocqlent = pmdb_t.pmdbent AND oocql_t.oocql003 = '" , 
        g_dlang,"'" ,") t6_oocql004,( SELECT oocql004 FROM oocql_t WHERE oocql_t.oocql001 = '265' AND oocql_t.oocql002 = pmdb_t.pmdb051 AND oocql_t.oocqlent = pmdb_t.pmdbent AND oocql_t.oocql003 = '" , 
        g_dlang,"'" ,") t7_oocql004,( SELECT imaal003 FROM imaal_t WHERE imaal_t.imaal001 = pmdb_t.pmdb012 AND imaal_t.imaalent = pmdb_t.pmdbent AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,") imaal_t_imaal003,( SELECT imaal003 FROM imaal_t WHERE imaal_t.imaal001 = pmdb_t.pmdb004 AND imaal_t.imaalent = pmdb_t.pmdbent AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,") t10_imaal003,( SELECT oocal003 FROM oocal_t WHERE oocal_t.oocal001 = pmdb_t.pmdb011 AND oocal_t.oocalent = pmdb_t.pmdbent AND oocal_t.oocal002 = '" , 
        g_dlang,"'" ,") oocal_t_oocal003,( SELECT oocal003 FROM oocal_t WHERE oocal_t.oocal001 = pmdb_t.pmdb009 AND oocal_t.oocalent = pmdb_t.pmdbent AND oocal_t.oocal002 = '" , 
        g_dlang,"'" ,") t8_oocal003,( SELECT oocal003 FROM oocal_t WHERE oocal_t.oocal001 = pmdb_t.pmdb007 AND oocal_t.oocalent = pmdb_t.pmdbent AND oocal_t.oocal002 = '" , 
        g_dlang,"'" ,") t9_oocal003,( SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = pmdb_t.pmdb015 AND pmaal_t.pmaalent = pmdb_t.pmdbent AND pmaal_t.pmaal002 = '" , 
        g_dlang,"'" ,") pmaal_t_pmaal004,( SELECT ooibl004 FROM ooibl_t WHERE ooibl_t.ooibl002 = pmdb_t.pmdb016 AND ooibl_t.ooiblent = pmdb_t.pmdbent AND ooibl_t.ooibl003 = '" , 
        g_dlang,"'" ,") ooibl_t_ooibl004,( SELECT imaal004 FROM imaal_t WHERE imaal_t.imaal001 = pmdb_t.pmdb004 AND imaal_t.imaalent = pmdb_t.pmdbent AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,") t10_imaal004 FROM pmdb_t ) x  ON pmda_t.pmdaent = x.pmdbent AND pmda_t.pmdadocno  
        = x.pmdbdocno AND pmda_t.pmdasite = x.pmdbsite"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
     
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
    LET g_order = " ORDER BY pmdadocno,pmdbseq"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("pmda_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE apmr400_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE apmr400_g01_curs CURSOR FOR apmr400_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="apmr400_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION apmr400_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   pmda001 LIKE pmda_t.pmda001, 
   pmda002 LIKE pmda_t.pmda002, 
   pmda003 LIKE pmda_t.pmda003, 
   pmda004 LIKE pmda_t.pmda004, 
   pmda005 LIKE pmda_t.pmda005, 
   pmda006 LIKE pmda_t.pmda006, 
   pmda007 LIKE pmda_t.pmda007, 
   pmda008 LIKE pmda_t.pmda008, 
   pmda009 LIKE pmda_t.pmda009, 
   pmda010 LIKE pmda_t.pmda010, 
   pmda011 LIKE pmda_t.pmda011, 
   pmda012 LIKE pmda_t.pmda012, 
   pmda020 LIKE pmda_t.pmda020, 
   pmda021 LIKE pmda_t.pmda021, 
   pmda022 LIKE pmda_t.pmda022, 
   pmdadocdt LIKE pmda_t.pmdadocdt, 
   pmdadocno LIKE pmda_t.pmdadocno, 
   pmdaent LIKE pmda_t.pmdaent, 
   pmdasite LIKE pmda_t.pmdasite, 
   pmdastus LIKE pmda_t.pmdastus, 
   pmdb001 LIKE pmdb_t.pmdb001, 
   pmdb002 LIKE pmdb_t.pmdb002, 
   pmdb003 LIKE pmdb_t.pmdb003, 
   pmdb004 LIKE pmdb_t.pmdb004, 
   pmdb005 LIKE pmdb_t.pmdb005, 
   pmdb006 LIKE pmdb_t.pmdb006, 
   pmdb007 LIKE pmdb_t.pmdb007, 
   pmdb008 LIKE pmdb_t.pmdb008, 
   pmdb009 LIKE pmdb_t.pmdb009, 
   pmdb010 LIKE pmdb_t.pmdb010, 
   pmdb011 LIKE pmdb_t.pmdb011, 
   pmdb012 LIKE pmdb_t.pmdb012, 
   pmdb014 LIKE pmdb_t.pmdb014, 
   pmdb015 LIKE pmdb_t.pmdb015, 
   pmdb016 LIKE pmdb_t.pmdb016, 
   pmdb017 LIKE pmdb_t.pmdb017, 
   pmdb018 LIKE pmdb_t.pmdb018, 
   pmdb019 LIKE pmdb_t.pmdb019, 
   pmdb020 LIKE pmdb_t.pmdb020, 
   pmdb021 LIKE pmdb_t.pmdb021, 
   pmdb030 LIKE pmdb_t.pmdb030, 
   pmdb031 LIKE pmdb_t.pmdb031, 
   pmdb032 LIKE pmdb_t.pmdb032, 
   pmdb033 LIKE pmdb_t.pmdb033, 
   pmdb034 LIKE pmdb_t.pmdb034, 
   pmdb035 LIKE pmdb_t.pmdb035, 
   pmdb036 LIKE pmdb_t.pmdb036, 
   pmdb037 LIKE pmdb_t.pmdb037, 
   pmdb038 LIKE pmdb_t.pmdb038, 
   pmdb039 LIKE pmdb_t.pmdb039, 
   pmdb040 LIKE pmdb_t.pmdb040, 
   pmdb041 LIKE pmdb_t.pmdb041, 
   pmdb042 LIKE pmdb_t.pmdb042, 
   pmdb043 LIKE pmdb_t.pmdb043, 
   pmdb044 LIKE pmdb_t.pmdb044, 
   pmdb045 LIKE pmdb_t.pmdb045, 
   pmdb046 LIKE pmdb_t.pmdb046, 
   pmdb048 LIKE pmdb_t.pmdb048, 
   pmdb049 LIKE pmdb_t.pmdb049, 
   pmdb050 LIKE pmdb_t.pmdb050, 
   pmdb051 LIKE pmdb_t.pmdb051, 
   pmdbseq LIKE pmdb_t.pmdbseq, 
   pmdbsite LIKE pmdb_t.pmdbsite, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   t1_ooefl003 LIKE ooefl_t.ooefl003, 
   x_t4_ooefl003 LIKE ooefl_t.ooefl003, 
   x_t5_ooefl003 LIKE ooefl_t.ooefl003, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   ooail_t_ooail003 LIKE ooail_t.ooail003, 
   oocql_t_oocql004 LIKE oocql_t.oocql004, 
   x_t2_oocql004 LIKE oocql_t.oocql004, 
   x_t3_oocql004 LIKE oocql_t.oocql004, 
   x_t6_oocql004 LIKE oocql_t.oocql004, 
   x_t7_oocql004 LIKE oocql_t.oocql004, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   x_t10_imaal003 LIKE imaal_t.imaal003, 
   x_oocal_t_oocal003 LIKE oocal_t.oocal003, 
   x_t8_oocal003 LIKE oocal_t.oocal003, 
   x_t9_oocal003 LIKE oocal_t.oocal003, 
   x_pmaal_t_pmaal004 LIKE pmaal_t.pmaal004, 
   x_ooibl_t_ooibl004 LIKE ooibl_t.ooibl004, 
   l_pmdb014_pmdb015 LIKE type_t.chr20, 
   x_t10_imaal004 LIKE imaal_t.imaal004, 
   l_pmda002_ooag011 LIKE type_t.chr20, 
   l_pmda010_desc LIKE type_t.chr80, 
   l_pmdb033_desc LIKE type_t.chr30, 
   l_pmda003_ooefl003 LIKE type_t.chr80, 
   l_pmda007_ooefl003 LIKE type_t.chr80, 
   l_pmdb014_desc LIKE type_t.chr200, 
   l_pmdb015_pmaal004 LIKE type_t.chr200
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"

DEFINE l_gzcbl004     LIKE gzcbl_t.gzcbl004
DEFINE l_ooef019      LIKE ooef_t.ooef019

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
 
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH apmr400_g01_curs INTO sr_s.*
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
       #稅別說明
       INITIALIZE l_ooef019 TO NULL 
       SELECT ooef019 INTO l_ooef019
         FROM ooef_t
        WHERE ooef001=sr_s.pmdasite
          AND ooefent=sr_s.pmdaent 
       
       SELECT oodbl004 INTO sr_s.l_pmda010_desc
         FROM oodbl_t y
        WHERE sr_s.pmda010 = y.oodbl002
          AND l_ooef019    = y.oodbl001
          AND g_dlang      = y.oodbl003
          AND sr_s.pmdaent = y.oodblent
       #緊急度SCC              
       CALL s_desc_gzcbl004_desc('2036',sr_s.pmdb033) RETURNING sr_s.l_pmdb033_desc
       #供應商SCC
       INITIALIZE l_gzcbl004 TO NULL   
       CALL s_desc_gzcbl004_desc('2037',sr_s.pmdb014) RETURNING l_gzcbl004         
       LET sr_s.l_pmdb014_desc = l_gzcbl004,":   ",sr_s.l_pmdb015_pmaal004

       #modify--2015/02/04 By Shiun--(S)
       #當前面編號為空時，清空編號.說明的字串(避免編號為空會只顯示一個 .)
       CALL apmr400_g01_initialize(sr_s.pmda002,sr_s.l_pmda002_ooag011) RETURNING sr_s.l_pmda002_ooag011
       CALL apmr400_g01_initialize(sr_s.pmda003,sr_s.l_pmda003_ooefl003) RETURNING sr_s.l_pmda003_ooefl003
       CALL apmr400_g01_initialize(sr_s.pmda007,sr_s.l_pmda007_ooefl003) RETURNING sr_s.l_pmda007_ooefl003
       #modify--2015/02/04 By Shiun--(E)
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
 
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].pmda001 = sr_s.pmda001
       LET sr[l_cnt].pmda002 = sr_s.pmda002
       LET sr[l_cnt].pmda003 = sr_s.pmda003
       LET sr[l_cnt].pmda004 = sr_s.pmda004
       LET sr[l_cnt].pmda005 = sr_s.pmda005
       LET sr[l_cnt].pmda006 = sr_s.pmda006
       LET sr[l_cnt].pmda007 = sr_s.pmda007
       LET sr[l_cnt].pmda008 = sr_s.pmda008
       LET sr[l_cnt].pmda009 = sr_s.pmda009
       LET sr[l_cnt].pmda010 = sr_s.pmda010
       LET sr[l_cnt].pmda011 = sr_s.pmda011
       LET sr[l_cnt].pmda012 = sr_s.pmda012
       LET sr[l_cnt].pmda020 = sr_s.pmda020
       LET sr[l_cnt].pmda021 = sr_s.pmda021
       LET sr[l_cnt].pmda022 = sr_s.pmda022
       LET sr[l_cnt].pmdadocdt = sr_s.pmdadocdt
       LET sr[l_cnt].pmdadocno = sr_s.pmdadocno
       LET sr[l_cnt].pmdaent = sr_s.pmdaent
       LET sr[l_cnt].pmdasite = sr_s.pmdasite
       LET sr[l_cnt].pmdastus = sr_s.pmdastus
       LET sr[l_cnt].pmdb001 = sr_s.pmdb001
       LET sr[l_cnt].pmdb002 = sr_s.pmdb002
       LET sr[l_cnt].pmdb003 = sr_s.pmdb003
       LET sr[l_cnt].pmdb004 = sr_s.pmdb004
       LET sr[l_cnt].pmdb005 = sr_s.pmdb005
       LET sr[l_cnt].pmdb006 = sr_s.pmdb006
       LET sr[l_cnt].pmdb007 = sr_s.pmdb007
       LET sr[l_cnt].pmdb008 = sr_s.pmdb008
       LET sr[l_cnt].pmdb009 = sr_s.pmdb009
       LET sr[l_cnt].pmdb010 = sr_s.pmdb010
       LET sr[l_cnt].pmdb011 = sr_s.pmdb011
       LET sr[l_cnt].pmdb012 = sr_s.pmdb012
       LET sr[l_cnt].pmdb014 = sr_s.pmdb014
       LET sr[l_cnt].pmdb015 = sr_s.pmdb015
       LET sr[l_cnt].pmdb016 = sr_s.pmdb016
       LET sr[l_cnt].pmdb017 = sr_s.pmdb017
       LET sr[l_cnt].pmdb018 = sr_s.pmdb018
       LET sr[l_cnt].pmdb019 = sr_s.pmdb019
       LET sr[l_cnt].pmdb020 = sr_s.pmdb020
       LET sr[l_cnt].pmdb021 = sr_s.pmdb021
       LET sr[l_cnt].pmdb030 = sr_s.pmdb030
       LET sr[l_cnt].pmdb031 = sr_s.pmdb031
       LET sr[l_cnt].pmdb032 = sr_s.pmdb032
       LET sr[l_cnt].pmdb033 = sr_s.pmdb033
       LET sr[l_cnt].pmdb034 = sr_s.pmdb034
       LET sr[l_cnt].pmdb035 = sr_s.pmdb035
       LET sr[l_cnt].pmdb036 = sr_s.pmdb036
       LET sr[l_cnt].pmdb037 = sr_s.pmdb037
       LET sr[l_cnt].pmdb038 = sr_s.pmdb038
       LET sr[l_cnt].pmdb039 = sr_s.pmdb039
       LET sr[l_cnt].pmdb040 = sr_s.pmdb040
       LET sr[l_cnt].pmdb041 = sr_s.pmdb041
       LET sr[l_cnt].pmdb042 = sr_s.pmdb042
       LET sr[l_cnt].pmdb043 = sr_s.pmdb043
       LET sr[l_cnt].pmdb044 = sr_s.pmdb044
       LET sr[l_cnt].pmdb045 = sr_s.pmdb045
       LET sr[l_cnt].pmdb046 = sr_s.pmdb046
       LET sr[l_cnt].pmdb048 = sr_s.pmdb048
       LET sr[l_cnt].pmdb049 = sr_s.pmdb049
       LET sr[l_cnt].pmdb050 = sr_s.pmdb050
       LET sr[l_cnt].pmdb051 = sr_s.pmdb051
       LET sr[l_cnt].pmdbseq = sr_s.pmdbseq
       LET sr[l_cnt].pmdbsite = sr_s.pmdbsite
       LET sr[l_cnt].ooag_t_ooag011 = sr_s.ooag_t_ooag011
       LET sr[l_cnt].t1_ooefl003 = sr_s.t1_ooefl003
       LET sr[l_cnt].x_t4_ooefl003 = sr_s.x_t4_ooefl003
       LET sr[l_cnt].x_t5_ooefl003 = sr_s.x_t5_ooefl003
       LET sr[l_cnt].ooefl_t_ooefl003 = sr_s.ooefl_t_ooefl003
       LET sr[l_cnt].ooail_t_ooail003 = sr_s.ooail_t_ooail003
       LET sr[l_cnt].oocql_t_oocql004 = sr_s.oocql_t_oocql004
       LET sr[l_cnt].x_t2_oocql004 = sr_s.x_t2_oocql004
       LET sr[l_cnt].x_t3_oocql004 = sr_s.x_t3_oocql004
       LET sr[l_cnt].x_t6_oocql004 = sr_s.x_t6_oocql004
       LET sr[l_cnt].x_t7_oocql004 = sr_s.x_t7_oocql004
       LET sr[l_cnt].x_imaal_t_imaal003 = sr_s.x_imaal_t_imaal003
       LET sr[l_cnt].x_t10_imaal003 = sr_s.x_t10_imaal003
       LET sr[l_cnt].x_oocal_t_oocal003 = sr_s.x_oocal_t_oocal003
       LET sr[l_cnt].x_t8_oocal003 = sr_s.x_t8_oocal003
       LET sr[l_cnt].x_t9_oocal003 = sr_s.x_t9_oocal003
       LET sr[l_cnt].x_pmaal_t_pmaal004 = sr_s.x_pmaal_t_pmaal004
       LET sr[l_cnt].x_ooibl_t_ooibl004 = sr_s.x_ooibl_t_ooibl004
       LET sr[l_cnt].l_pmdb014_pmdb015 = sr_s.l_pmdb014_pmdb015
       LET sr[l_cnt].x_t10_imaal004 = sr_s.x_t10_imaal004
       LET sr[l_cnt].l_pmda002_ooag011 = sr_s.l_pmda002_ooag011
       LET sr[l_cnt].l_pmda010_desc = sr_s.l_pmda010_desc
       LET sr[l_cnt].l_pmdb033_desc = sr_s.l_pmdb033_desc
       LET sr[l_cnt].l_pmda003_ooefl003 = sr_s.l_pmda003_ooefl003
       LET sr[l_cnt].l_pmda007_ooefl003 = sr_s.l_pmda007_ooefl003
       LET sr[l_cnt].l_pmdb014_desc = sr_s.l_pmdb014_desc
       LET sr[l_cnt].l_pmdb015_pmaal004 = sr_s.l_pmdb015_pmaal004
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
     
       
     
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apmr400_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION apmr400_g01_rep_data()
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
          START REPORT apmr400_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT apmr400_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT apmr400_g01_rep
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
 
{<section id="apmr400_g01.rep" readonly="Y" >}
PRIVATE REPORT apmr400_g01_rep(sr1)
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
DEFINE l_pmda022_show  LIKE type_t.chr10
DEFINE l_pmdb014_show  LIKE type_t.chr10
DEFINE l_pmdb016_show  LIKE type_t.chr10
DEFINE l_pmdb017_show  LIKE type_t.chr10
DEFINE l_detail04_show LIKE type_t.chr10
DEFINE l_detail05_show LIKE type_t.chr10
DEFINE l_pmdb041_show  LIKE type_t.chr10
DEFINE l_pmdb042_show  LIKE type_t.chr10

#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER EXTERNAL BY sr1.pmdadocno,sr1.pmdbseq
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
        BEFORE GROUP OF sr1.pmdadocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.pmdadocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'pmdaent=' ,sr1.pmdaent,'{+}pmdadocno=' ,sr1.pmdadocno         
            CALL cl_gr_init_apr(sr1.pmdadocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.pmdadocno.before name="rep.b_group.pmdadocno.before"
           #單頭備註隱藏
           INITIALIZE l_pmda022_show TO NULL
           IF cl_null(sr1.pmda022) THEN
              LET l_pmda022_show = "N"
           ELSE
              LET l_pmda022_show = "Y"
           END IF
           PRINTX l_pmda022_show
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.pmdaent CLIPPED ,"'", " AND  ooff003 = '", sr1.pmdadocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE apmr400_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE apmr400_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT apmr400_g01_subrep01
           DECLARE apmr400_g01_repcur01 CURSOR FROM g_sql
           FOREACH apmr400_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "apmr400_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT apmr400_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT apmr400_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.pmdadocno.after name="rep.b_group.pmdadocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.pmdbseq
 
           #add-point:rep.b_group.pmdbseq.before name="rep.b_group.pmdbseq.before"
         
          
        
                 
           
           
           #end add-point:
 
 
           #add-point:rep.b_group.pmdbseq.after name="rep.b_group.pmdbseq.after"
           
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
                sr1.pmdaent CLIPPED ,"'", " AND  ooff003 = '", sr1.pmdadocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.pmdbseq CLIPPED ,""
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE apmr400_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE apmr400_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT apmr400_g01_subrep02
           DECLARE apmr400_g01_repcur02 CURSOR FROM g_sql
           FOREACH apmr400_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "apmr400_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT apmr400_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT apmr400_g01_subrep02
           #add-point:rep.sub02.after name="rep.sub02.after"
           
           #end add-point:rep.sub02.after
 
 
 
          #add-point:rep.everyrow.beforerow name="rep.everyrow.beforerow"
          
          #end add-point:rep.everyrow.beforerow
            
          PRINTX sr1.*
 
          #add-point:rep.everyrow.afterrow name="rep.everyrow.afterrow"
            
            #單身備註隱藏
            INITIALIZE l_detail05_show TO NULL
            IF cl_null(sr1.pmdb050 CLIPPED)  THEN
               LET l_detail05_show = "N"
            ELSE
               LET l_detail05_show = "Y"
            END IF
            #單身付款條件隱藏
            INITIALIZE l_pmdb016_show TO NULL
            IF cl_null(sr1.pmdb016) THEN
               LET l_pmdb016_show = "N"
            ELSE
               LET l_pmdb016_show = "Y"
            END IF
            #單身產品特徵與付款條件隱藏
            INITIALIZE l_detail04_show TO NULL
            IF cl_null(sr1.pmdb005) AND cl_null(sr1.pmdb016) THEN
               LET l_detail04_show = "N"
            ELSE
               LET l_detail04_show = "Y"
            END IF
            #單身指定供應商隱藏
            INITIALIZE l_pmdb014_show TO NULL          
            IF sr1.pmdb014 = 1 OR cl_null(sr1.pmdb014) THEN
               LET l_pmdb014_show = "N"             
            ELSE
               LET l_pmdb014_show = "Y"           
            END IF
            #單身交易條件隱藏
            INITIALIZE l_pmdb017_show TO NULL          
            IF cl_null(sr1.pmdb017) THEN
               LET l_pmdb017_show = "N"             
            ELSE
               LET l_pmdb017_show = "Y"           
            END IF
            #單身不允許提前交貨隱藏        
            INITIALIZE l_pmdb042_show TO NULL
            IF sr1.pmdb042="N" THEN
               LET l_pmdb042_show = "Y"             
            ELSE
               LET l_pmdb042_show = "N"     
            END IF
            #單身不允許部份交貨隱藏 
            INITIALIZE l_pmdb041_show TO NULL
            IF sr1.pmdb041="N" THEN
               LET l_pmdb041_show = "Y"             
            ELSE
               LET l_pmdb041_show = "N"     
            END IF
          
            PRINTX l_detail05_show,l_pmdb016_show,l_pmdb014_show,l_pmdb017_show,
                   l_pmdb042_show,l_pmdb041_show,l_detail04_show
          #end add-point:rep.everyrow.afterrow
 
          #單身後備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub03.before name="rep.sub03.before"
           
           #end add-point:rep.sub03.before
 
           #add-point:rep.sub03.sql name="rep.sub03.sql"
           
           #end add-point:rep.sub03.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooffent = '", 
                sr1.pmdaent CLIPPED ,"'", " AND  ooff003 = '", sr1.pmdadocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.pmdbseq CLIPPED ,""
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE apmr400_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE apmr400_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT apmr400_g01_subrep03
           DECLARE apmr400_g01_repcur03 CURSOR FROM g_sql
           FOREACH apmr400_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "apmr400_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT apmr400_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT apmr400_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.pmdadocno
 
           #add-point:rep.a_group.pmdadocno.before name="rep.a_group.pmdadocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.pmdaent CLIPPED ,"'", " AND  ooff003 = '", sr1.pmdadocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE apmr400_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE apmr400_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT apmr400_g01_subrep04
           DECLARE apmr400_g01_repcur04 CURSOR FROM g_sql
           FOREACH apmr400_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "apmr400_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT apmr400_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT apmr400_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.pmdadocno.after name="rep.a_group.pmdadocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.pmdbseq
 
           #add-point:rep.a_group.pmdbseq.before name="rep.a_group.pmdbseq.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.pmdbseq.after name="rep.a_group.pmdbseq.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="apmr400_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT apmr400_g01_subrep01(sr2)
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
PRIVATE REPORT apmr400_g01_subrep02(sr2)
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
PRIVATE REPORT apmr400_g01_subrep03(sr2)
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
PRIVATE REPORT apmr400_g01_subrep04(sr2)
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
 
{<section id="apmr400_g01.other_function" readonly="Y" >}
################################################################################
# Descriptions...: 當編號為空時清空編號.說明字串
# Usage..........: CALL apmr400_g01_initialize(p_arg,p_exp)
#                  RETURNING r_exp
# Input parameter: p_arg   編號
#                : p_exp   編號.說明
# Return code....: r_exp   編號.說明
# Date & Author..: 2015/02/04 By Shiun
################################################################################
PRIVATE FUNCTION apmr400_g01_initialize(p_arg,p_exp)
DEFINE p_arg   STRING
DEFINE p_exp   STRING
DEFINE r_exp   STRING
   IF cl_null(p_arg) THEN
      INITIALIZE r_exp TO NULL
   ELSE
      LET r_exp = p_exp
   END IF
RETURN r_exp
END FUNCTION

 
{</section>}
 
{<section id="apmr400_g01.other_report" readonly="Y" >}
{<point name="other.report"/>}
 
{</section>}
 
