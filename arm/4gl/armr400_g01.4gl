#該程式未解開Section, 採用最新樣板產出!
{<section id="armr400_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2015-08-07 16:48:50), PR版次:0001(2015-12-14 17:30:44)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000038
#+ Filename...: armr400_g01
#+ Description: ...
#+ Creator....: 05423(2015-08-07 10:15:32)
#+ Modifier...: 05423 -SD/PR- 05423
 
{</section>}
 
{<section id="armr400_g01.global" readonly="Y" >}
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
   rmda001 LIKE rmda_t.rmda001, 
   rmda002 LIKE rmda_t.rmda002, 
   rmda003 LIKE rmda_t.rmda003, 
   rmda004 LIKE rmda_t.rmda004, 
   rmda005 LIKE rmda_t.rmda005, 
   rmda006 LIKE rmda_t.rmda006, 
   rmda007 LIKE rmda_t.rmda007, 
   rmda008 LIKE rmda_t.rmda008, 
   rmda009 LIKE rmda_t.rmda009, 
   rmda010 LIKE rmda_t.rmda010, 
   rmda011 LIKE rmda_t.rmda011, 
   rmda012 LIKE rmda_t.rmda012, 
   rmda013 LIKE rmda_t.rmda013, 
   rmda014 LIKE rmda_t.rmda014, 
   rmda015 LIKE rmda_t.rmda015, 
   rmda016 LIKE rmda_t.rmda016, 
   rmda017 LIKE rmda_t.rmda017, 
   rmda018 LIKE rmda_t.rmda018, 
   rmda019 LIKE rmda_t.rmda019, 
   rmdadocdt LIKE rmda_t.rmdadocdt, 
   rmdadocno LIKE rmda_t.rmdadocno, 
   rmdaent LIKE rmda_t.rmdaent, 
   rmdasite LIKE rmda_t.rmdasite, 
   rmdastus LIKE rmda_t.rmdastus, 
   rmdb001 LIKE rmdb_t.rmdb001, 
   rmdb002 LIKE rmdb_t.rmdb002, 
   rmdb003 LIKE rmdb_t.rmdb003, 
   rmdb004 LIKE rmdb_t.rmdb004, 
   rmdb005 LIKE rmdb_t.rmdb005, 
   rmdb006 LIKE rmdb_t.rmdb006, 
   rmdb007 LIKE rmdb_t.rmdb007, 
   rmdb008 LIKE rmdb_t.rmdb008, 
   rmdb009 LIKE rmdb_t.rmdb009, 
   rmdb010 LIKE rmdb_t.rmdb010, 
   rmdb011 LIKE rmdb_t.rmdb011, 
   rmdb012 LIKE rmdb_t.rmdb012, 
   rmdbseq LIKE rmdb_t.rmdbseq, 
   rmdbsite LIKE rmdb_t.rmdbsite, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   t1_pmaal003 LIKE pmaal_t.pmaal003, 
   t3_pmaal003 LIKE pmaal_t.pmaal003, 
   pmaal_t_pmaal004 LIKE pmaal_t.pmaal004, 
   t2_pmaal004 LIKE pmaal_t.pmaal004, 
   t4_pmaal004 LIKE pmaal_t.pmaal004, 
   oocql_t_oocql004 LIKE oocql_t.oocql004, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   x_imaal_t_imaal004 LIKE imaal_t.imaal004, 
   x_inayl_t_inayl003 LIKE inayl_t.inayl003, 
   x_inab_t_inab003 LIKE inab_t.inab003, 
   l_rmda007_pmaal004 LIKE type_t.chr100, 
   l_rmda015_pmaal003 LIKE type_t.chr300, 
   l_rmda008_pmaal004 LIKE type_t.chr100, 
   l_rmda002_ooag011 LIKE type_t.chr300, 
   l_rmda003_ooefl003 LIKE type_t.chr1000, 
   l_rmda006_pmaal004 LIKE type_t.chr100, 
   l_rmda005_pmaal003 LIKE type_t.chr300, 
   l_rmdb007_inayl003 LIKE type_t.chr1000, 
   l_rmdb008_inab003 LIKE type_t.chr1000, 
   l_rmda011_desc LIKE type_t.chr100, 
   l_rmdb004_desc LIKE type_t.chr50, 
   l_rmdb001_rmdb002 LIKE type_t.chr50
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING,                  #where condition 
       pr LIKE type_t.chr1          #列印多庫儲批
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
   rmdcseq1       LIKE rmdc_t.rmdcseq1,
   rmdc005        LIKE rmdc_t.rmdc005,
   l_rmdc005_desc LIKE inayl_t.inayl003,
   rmdc006        LIKE rmdc_t.rmdc006,
   l_rmdc006_desc LIKE inab_t.inab003,
   rmdc007        LIKE rmdc_t.rmdc007,
   rmdc004        LIKE rmdc_t.rmdc004,
   rmdc003        LIKE rmdc_t.rmdc003
END RECORD
#end add-point
 
{</section>}
 
{<section id="armr400_g01.main" readonly="Y" >}
PUBLIC FUNCTION armr400_g01(p_arg1,p_arg2)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr1         #tm.pr  列印多庫儲批
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.pr = p_arg2
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "armr400_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL armr400_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL armr400_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL armr400_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="armr400_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION armr400_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   
   #end add-point
   LET g_select = " SELECT rmda001,rmda002,rmda003,rmda004,rmda005,rmda006,rmda007,rmda008,rmda009,rmda010, 
       rmda011,rmda012,rmda013,rmda014,rmda015,rmda016,rmda017,rmda018,rmda019,rmdadocdt,rmdadocno,rmdaent, 
       rmdasite,rmdastus,rmdb001,rmdb002,rmdb003,rmdb004,rmdb005,rmdb006,rmdb007,rmdb008,rmdb009,rmdb010, 
       rmdb011,rmdb012,rmdbseq,rmdbsite,( SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = rmda_t.rmda002 AND ooag_t.ooagent = rmda_t.rmdaent), 
       ( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = rmda_t.rmda003 AND ooefl_t.ooeflent = rmda_t.rmdaent AND ooefl_t.ooefl002 = '" , 
       g_dlang,"'" ,"),( SELECT pmaal003 FROM pmaal_t t1 WHERE t1.pmaal001 = rmda_t.rmda015 AND t1.pmaalent = rmda_t.rmdaent AND t1.pmaal002 = '" , 
       g_dlang,"'" ,"),( SELECT pmaal003 FROM pmaal_t t3 WHERE t3.pmaal001 = rmda_t.rmda005 AND t3.pmaalent = rmda_t.rmdaent AND t3.pmaal002 = '" , 
       g_dlang,"'" ,"),( SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = rmda_t.rmda007 AND pmaal_t.pmaalent = rmda_t.rmdaent AND pmaal_t.pmaal002 = '" , 
       g_dlang,"'" ,"),( SELECT pmaal004 FROM pmaal_t t2 WHERE t2.pmaal001 = rmda_t.rmda008 AND t2.pmaalent = rmda_t.rmdaent AND t2.pmaal002 = '" , 
       g_dlang,"'" ,"),( SELECT pmaal004 FROM pmaal_t t4 WHERE t4.pmaal001 = rmda_t.rmda006 AND t4.pmaalent = rmda_t.rmdaent AND t4.pmaal002 = '" , 
       g_dlang,"'" ,"),( SELECT oocql004 FROM oocql_t WHERE oocql_t.oocql001 = '263' AND oocql_t.oocql002 = rmda_t.rmda012 AND oocql_t.oocqlent = rmda_t.rmdaent AND oocql_t.oocql003 = '" , 
       g_dlang,"'" ,"),x.imaal_t_imaal003,x.imaal_t_imaal004,x.inayl_t_inayl003,x.inab_t_inab003,trim(rmda007)||'.'||trim((SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = rmda_t.rmda007 AND pmaal_t.pmaalent = rmda_t.rmdaent AND pmaal_t.pmaal002 = '" , 
       g_dlang,"'" ,")),trim(rmda015)||'.'||trim((SELECT pmaal003 FROM pmaal_t t1 WHERE t1.pmaal001 = rmda_t.rmda015 AND t1.pmaalent = rmda_t.rmdaent AND t1.pmaal002 = '" , 
       g_dlang,"'" ,")),trim(rmda008)||'.'||trim((SELECT pmaal004 FROM pmaal_t t2 WHERE t2.pmaal001 = rmda_t.rmda008 AND t2.pmaalent = rmda_t.rmdaent AND t2.pmaal002 = '" , 
       g_dlang,"'" ,")),trim(rmda002)||'.'||trim((SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = rmda_t.rmda002 AND ooag_t.ooagent = rmda_t.rmdaent)), 
       trim(rmda003)||'.'||trim((SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = rmda_t.rmda003 AND ooefl_t.ooeflent = rmda_t.rmdaent AND ooefl_t.ooefl002 = '" , 
       g_dlang,"'" ,")),trim(rmda006)||'.'||trim((SELECT pmaal004 FROM pmaal_t t4 WHERE t4.pmaal001 = rmda_t.rmda006 AND t4.pmaalent = rmda_t.rmdaent AND t4.pmaal002 = '" , 
       g_dlang,"'" ,")),trim(rmda005)||'.'||trim((SELECT pmaal003 FROM pmaal_t t3 WHERE t3.pmaal001 = rmda_t.rmda005 AND t3.pmaalent = rmda_t.rmdaent AND t3.pmaal002 = '" , 
       g_dlang,"'" ,")),trim(rmdb007)||'.'||trim(x.inayl_t_inayl003),trim(rmdb008)||'.'||trim(x.inab_t_inab003), 
       NULL,NULL,(trim(rmdb001)||'/'||trim(rmdb002))"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   
   #end add-point
    LET g_from = " FROM rmda_t LEFT OUTER JOIN ( SELECT rmdb_t.*,( SELECT imaal003 FROM imaal_t WHERE imaal_t.imaal001 = rmdb_t.rmdb003 AND imaal_t.imaalent = rmdb_t.rmdbent AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,") imaal_t_imaal003,( SELECT imaal004 FROM imaal_t WHERE imaal_t.imaal001 = rmdb_t.rmdb003 AND imaal_t.imaalent = rmdb_t.rmdbent AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,") imaal_t_imaal004,( SELECT inayl003 FROM inayl_t WHERE inayl_t.inayl001 = rmdb_t.rmdb007 AND inayl_t.inaylent = rmdb_t.rmdbent AND inayl_t.inayl002 = '" , 
        g_dlang,"'" ,") inayl_t_inayl003,( SELECT inab003 FROM inab_t WHERE inab_t.inabsite = rmdb_t.rmdbsite  
        AND inab_t.inab001 = rmdb_t.rmdb007 AND inab_t.inab002 = rmdb_t.rmdb008 AND inab_t.inabent =  
        rmdb_t.rmdbent) inab_t_inab003 FROM rmdb_t ) x  ON rmda_t.rmdaent = x.rmdbent AND rmda_t.rmdadocno  
        = x.rmdbdocno"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
    LET g_order = " ORDER BY rmdadocno,rmdbseq"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("rmda_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE armr400_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE armr400_g01_curs CURSOR FOR armr400_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="armr400_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION armr400_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   rmda001 LIKE rmda_t.rmda001, 
   rmda002 LIKE rmda_t.rmda002, 
   rmda003 LIKE rmda_t.rmda003, 
   rmda004 LIKE rmda_t.rmda004, 
   rmda005 LIKE rmda_t.rmda005, 
   rmda006 LIKE rmda_t.rmda006, 
   rmda007 LIKE rmda_t.rmda007, 
   rmda008 LIKE rmda_t.rmda008, 
   rmda009 LIKE rmda_t.rmda009, 
   rmda010 LIKE rmda_t.rmda010, 
   rmda011 LIKE rmda_t.rmda011, 
   rmda012 LIKE rmda_t.rmda012, 
   rmda013 LIKE rmda_t.rmda013, 
   rmda014 LIKE rmda_t.rmda014, 
   rmda015 LIKE rmda_t.rmda015, 
   rmda016 LIKE rmda_t.rmda016, 
   rmda017 LIKE rmda_t.rmda017, 
   rmda018 LIKE rmda_t.rmda018, 
   rmda019 LIKE rmda_t.rmda019, 
   rmdadocdt LIKE rmda_t.rmdadocdt, 
   rmdadocno LIKE rmda_t.rmdadocno, 
   rmdaent LIKE rmda_t.rmdaent, 
   rmdasite LIKE rmda_t.rmdasite, 
   rmdastus LIKE rmda_t.rmdastus, 
   rmdb001 LIKE rmdb_t.rmdb001, 
   rmdb002 LIKE rmdb_t.rmdb002, 
   rmdb003 LIKE rmdb_t.rmdb003, 
   rmdb004 LIKE rmdb_t.rmdb004, 
   rmdb005 LIKE rmdb_t.rmdb005, 
   rmdb006 LIKE rmdb_t.rmdb006, 
   rmdb007 LIKE rmdb_t.rmdb007, 
   rmdb008 LIKE rmdb_t.rmdb008, 
   rmdb009 LIKE rmdb_t.rmdb009, 
   rmdb010 LIKE rmdb_t.rmdb010, 
   rmdb011 LIKE rmdb_t.rmdb011, 
   rmdb012 LIKE rmdb_t.rmdb012, 
   rmdbseq LIKE rmdb_t.rmdbseq, 
   rmdbsite LIKE rmdb_t.rmdbsite, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   t1_pmaal003 LIKE pmaal_t.pmaal003, 
   t3_pmaal003 LIKE pmaal_t.pmaal003, 
   pmaal_t_pmaal004 LIKE pmaal_t.pmaal004, 
   t2_pmaal004 LIKE pmaal_t.pmaal004, 
   t4_pmaal004 LIKE pmaal_t.pmaal004, 
   oocql_t_oocql004 LIKE oocql_t.oocql004, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   x_imaal_t_imaal004 LIKE imaal_t.imaal004, 
   x_inayl_t_inayl003 LIKE inayl_t.inayl003, 
   x_inab_t_inab003 LIKE inab_t.inab003, 
   l_rmda007_pmaal004 LIKE type_t.chr100, 
   l_rmda015_pmaal003 LIKE type_t.chr300, 
   l_rmda008_pmaal004 LIKE type_t.chr100, 
   l_rmda002_ooag011 LIKE type_t.chr300, 
   l_rmda003_ooefl003 LIKE type_t.chr1000, 
   l_rmda006_pmaal004 LIKE type_t.chr100, 
   l_rmda005_pmaal003 LIKE type_t.chr300, 
   l_rmdb007_inayl003 LIKE type_t.chr1000, 
   l_rmdb008_inab003 LIKE type_t.chr1000, 
   l_rmda011_desc LIKE type_t.chr100, 
   l_rmdb004_desc LIKE type_t.chr50, 
   l_rmdb001_rmdb002 LIKE type_t.chr50
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
   DEFINE  r_success   LIKE type_t.num5
   DEFINE l_pmaa027    LIKE pmaa_t.pmaa027  #聯絡對象識別碼
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH armr400_g01_curs INTO sr_s.*
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
       IF cl_null(sr_s.rmdb001) AND cl_null(sr_s.rmdb002) THEN
          INITIALIZE sr_s.l_rmdb001_rmdb002 TO NULL
       END IF
       #檢查判別人員、部門、客戶編號是否為空
       IF cl_null(sr_s.rmda002) THEN
          LET sr_s.l_rmda002_ooag011 = sr_s.rmda002
       END IF
       IF cl_null(sr_s.rmda003) THEN
          LET sr_s.l_rmda003_ooefl003 = sr_s.rmda003
       END IF
       IF cl_null(sr_s.rmda005) THEN
          LET sr_s.l_rmda005_pmaal003 = sr_s.rmda005
       END IF
       IF cl_null(sr_s.rmda006) THEN
          LET sr_s.l_rmda006_pmaal004 = sr_s.rmda006
       END IF
       IF cl_null(sr_s.rmdb007) THEN
          LET sr_s.l_rmdb007_inayl003 = sr_s.rmdb007
       END IF
       IF cl_null(sr_s.rmdb008) THEN
          LET sr_s.l_rmdb008_inab003 = sr_s.rmdb008
       END IF
       #獲取料件特征
       IF NOT cl_null(sr_s.rmdb004) THEN
         CALL s_feature_description(sr_s.rmdb003,sr_s.rmdb004) RETURNING r_success,sr_s.l_rmdb004_desc
       END IF
       #送貨地址
       CALL s_axmt500_get_pmaa027(sr_s.rmda006) RETURNING l_pmaa027
       #組合地址
       LET sr_s.l_rmda011_desc = ''
       IF NOT cl_null(sr_s.rmda006) AND NOT cl_null(sr_s.rmda011) THEN         
          
          IF NOT cl_null(l_pmaa027) THEN
             CALL s_aooi350_get_address(l_pmaa027,sr_s.rmda011,g_dlang) RETURNING r_success,sr_s.l_rmda011_desc
             IF NOT r_success THEN
                LET sr_s.l_rmda011_desc = ''
             END IF   
          END IF      
       END IF
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].rmda001 = sr_s.rmda001
       LET sr[l_cnt].rmda002 = sr_s.rmda002
       LET sr[l_cnt].rmda003 = sr_s.rmda003
       LET sr[l_cnt].rmda004 = sr_s.rmda004
       LET sr[l_cnt].rmda005 = sr_s.rmda005
       LET sr[l_cnt].rmda006 = sr_s.rmda006
       LET sr[l_cnt].rmda007 = sr_s.rmda007
       LET sr[l_cnt].rmda008 = sr_s.rmda008
       LET sr[l_cnt].rmda009 = sr_s.rmda009
       LET sr[l_cnt].rmda010 = sr_s.rmda010
       LET sr[l_cnt].rmda011 = sr_s.rmda011
       LET sr[l_cnt].rmda012 = sr_s.rmda012
       LET sr[l_cnt].rmda013 = sr_s.rmda013
       LET sr[l_cnt].rmda014 = sr_s.rmda014
       LET sr[l_cnt].rmda015 = sr_s.rmda015
       LET sr[l_cnt].rmda016 = sr_s.rmda016
       LET sr[l_cnt].rmda017 = sr_s.rmda017
       LET sr[l_cnt].rmda018 = sr_s.rmda018
       LET sr[l_cnt].rmda019 = sr_s.rmda019
       LET sr[l_cnt].rmdadocdt = sr_s.rmdadocdt
       LET sr[l_cnt].rmdadocno = sr_s.rmdadocno
       LET sr[l_cnt].rmdaent = sr_s.rmdaent
       LET sr[l_cnt].rmdasite = sr_s.rmdasite
       LET sr[l_cnt].rmdastus = sr_s.rmdastus
       LET sr[l_cnt].rmdb001 = sr_s.rmdb001
       LET sr[l_cnt].rmdb002 = sr_s.rmdb002
       LET sr[l_cnt].rmdb003 = sr_s.rmdb003
       LET sr[l_cnt].rmdb004 = sr_s.rmdb004
       LET sr[l_cnt].rmdb005 = sr_s.rmdb005
       LET sr[l_cnt].rmdb006 = sr_s.rmdb006
       LET sr[l_cnt].rmdb007 = sr_s.rmdb007
       LET sr[l_cnt].rmdb008 = sr_s.rmdb008
       LET sr[l_cnt].rmdb009 = sr_s.rmdb009
       LET sr[l_cnt].rmdb010 = sr_s.rmdb010
       LET sr[l_cnt].rmdb011 = sr_s.rmdb011
       LET sr[l_cnt].rmdb012 = sr_s.rmdb012
       LET sr[l_cnt].rmdbseq = sr_s.rmdbseq
       LET sr[l_cnt].rmdbsite = sr_s.rmdbsite
       LET sr[l_cnt].ooag_t_ooag011 = sr_s.ooag_t_ooag011
       LET sr[l_cnt].ooefl_t_ooefl003 = sr_s.ooefl_t_ooefl003
       LET sr[l_cnt].t1_pmaal003 = sr_s.t1_pmaal003
       LET sr[l_cnt].t3_pmaal003 = sr_s.t3_pmaal003
       LET sr[l_cnt].pmaal_t_pmaal004 = sr_s.pmaal_t_pmaal004
       LET sr[l_cnt].t2_pmaal004 = sr_s.t2_pmaal004
       LET sr[l_cnt].t4_pmaal004 = sr_s.t4_pmaal004
       LET sr[l_cnt].oocql_t_oocql004 = sr_s.oocql_t_oocql004
       LET sr[l_cnt].x_imaal_t_imaal003 = sr_s.x_imaal_t_imaal003
       LET sr[l_cnt].x_imaal_t_imaal004 = sr_s.x_imaal_t_imaal004
       LET sr[l_cnt].x_inayl_t_inayl003 = sr_s.x_inayl_t_inayl003
       LET sr[l_cnt].x_inab_t_inab003 = sr_s.x_inab_t_inab003
       LET sr[l_cnt].l_rmda007_pmaal004 = sr_s.l_rmda007_pmaal004
       LET sr[l_cnt].l_rmda015_pmaal003 = sr_s.l_rmda015_pmaal003
       LET sr[l_cnt].l_rmda008_pmaal004 = sr_s.l_rmda008_pmaal004
       LET sr[l_cnt].l_rmda002_ooag011 = sr_s.l_rmda002_ooag011
       LET sr[l_cnt].l_rmda003_ooefl003 = sr_s.l_rmda003_ooefl003
       LET sr[l_cnt].l_rmda006_pmaal004 = sr_s.l_rmda006_pmaal004
       LET sr[l_cnt].l_rmda005_pmaal003 = sr_s.l_rmda005_pmaal003
       LET sr[l_cnt].l_rmdb007_inayl003 = sr_s.l_rmdb007_inayl003
       LET sr[l_cnt].l_rmdb008_inab003 = sr_s.l_rmdb008_inab003
       LET sr[l_cnt].l_rmda011_desc = sr_s.l_rmda011_desc
       LET sr[l_cnt].l_rmdb004_desc = sr_s.l_rmdb004_desc
       LET sr[l_cnt].l_rmdb001_rmdb002 = sr_s.l_rmdb001_rmdb002
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="armr400_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION armr400_g01_rep_data()
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
          START REPORT armr400_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT armr400_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT armr400_g01_rep
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
 
{<section id="armr400_g01.rep" readonly="Y" >}
PRIVATE REPORT armr400_g01_rep(sr1)
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
DEFINE l_subrep05_show  LIKE type_t.chr1
DEFINE l_show           LIKE type_t.chr1
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER EXTERNAL BY sr1.rmdadocno,sr1.rmdbseq
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
        BEFORE GROUP OF sr1.rmdadocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.rmdadocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'rmdaent=' ,sr1.rmdaent,'{+}rmdadocno=' ,sr1.rmdadocno         
            CALL cl_gr_init_apr(sr1.rmdadocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.rmdadocno.before name="rep.b_group.rmdadocno.before"
           LET l_show = 'Y'
           LET l_cnt = 0
           SELECT COUNT(*) INTO l_cnt
             FROM rmdb_t
            WHERE rmdbdocno = sr1.rmdadocno
              AND rmdbent = sr1.rmdaent
              AND rmdbsite = sr1.rmdasite
           IF l_cnt = 0 THEN
              LET l_show = 'N'
           END IF
           PRINTX l_show
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.rmdaent CLIPPED ,"'", " AND  ooff003 = '", sr1.rmdadocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE armr400_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE armr400_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT armr400_g01_subrep01
           DECLARE armr400_g01_repcur01 CURSOR FROM g_sql
           FOREACH armr400_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "armr400_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT armr400_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT armr400_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.rmdadocno.after name="rep.b_group.rmdadocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.rmdbseq
 
           #add-point:rep.b_group.rmdbseq.before name="rep.b_group.rmdbseq.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.rmdbseq.after name="rep.b_group.rmdbseq.after"
           
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
                sr1.rmdaent CLIPPED ,"'", " AND  ooff003 = '", sr1.rmdadocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.rmdbseq CLIPPED ,""
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE armr400_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE armr400_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT armr400_g01_subrep02
           DECLARE armr400_g01_repcur02 CURSOR FROM g_sql
           FOREACH armr400_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "armr400_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT armr400_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT armr400_g01_subrep02
           #add-point:rep.sub02.after name="rep.sub02.after"
           
           #end add-point:rep.sub02.after
 
 
 
          #add-point:rep.everyrow.beforerow name="rep.everyrow.beforerow"
          
          #end add-point:rep.everyrow.beforerow
            
          PRINTX sr1.*
 
          #add-point:rep.everyrow.afterrow name="rep.everyrow.afterrow"
          LET g_sql = " SELECT DISTINCT rmdcseq1,rmdc005,trim(rmdc005)||'.'||trim(inayl003),rmdc006,trim(rmdc006)||'.'||trim(inab003),",
                      " rmdc007,rmdc004,rmdc003 ",
                      " FROM rmdc_t LEFT OUTER JOIN inayl_t ON rmdc005 = inayl001 AND rmdcent = inaylent AND inayl002 = '",g_dlang,"' ",
                      "             LEFT OUTER JOIN inab_t ON rmdc005 = inab001 AND rmdc006 = inab002 AND rmdcent = inabent ",
                      " WHERE rmdcdocno = '",sr1.rmdadocno,"' AND rmdcent = ",sr1.rmdaent,
                      " AND rmdcsite = '",g_site,"' AND rmdcseq = '",sr1.rmdbseq,"' ",
                      " ORDER BY rmdcseq1 "
 
           #add-point:rep.sub02.afsql

           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep05_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE armr400_g01_repcur05_cnt_pre FROM l_sub_sql
           EXECUTE armr400_g01_repcur05_cnt_pre INTO l_cnt
           IF l_cnt > 0 AND tm.pr = 'Y' THEN 
              LET l_subrep05_show ="Y"
           END IF
           PRINTX l_subrep05_show
           START REPORT armr400_g01_subrep05
           DECLARE armr400_g01_repcur05 CURSOR FROM g_sql
           FOREACH armr400_g01_repcur05 INTO sr3.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "armr400_g01_repcur05:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach
              IF cl_null(sr3.rmdc005) THEN
                 INITIALIZE sr3.l_rmdc005_desc TO NULL
              END IF
              IF cl_null(sr3.rmdc006) THEN
                 INITIALIZE sr3.l_rmdc006_desc TO NULL
              END IF
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT armr400_g01_subrep05(sr3.*)
           END FOREACH
           FINISH REPORT armr400_g01_subrep05
          #end add-point:rep.everyrow.afterrow
 
          #單身後備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub03.before name="rep.sub03.before"
           
           #end add-point:rep.sub03.before
 
           #add-point:rep.sub03.sql name="rep.sub03.sql"
           
           #end add-point:rep.sub03.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooffent = '", 
                sr1.rmdaent CLIPPED ,"'", " AND  ooff003 = '", sr1.rmdadocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.rmdbseq CLIPPED ,""
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE armr400_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE armr400_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT armr400_g01_subrep03
           DECLARE armr400_g01_repcur03 CURSOR FROM g_sql
           FOREACH armr400_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "armr400_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT armr400_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT armr400_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.rmdadocno
 
           #add-point:rep.a_group.rmdadocno.before name="rep.a_group.rmdadocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.rmdaent CLIPPED ,"'", " AND  ooff003 = '", sr1.rmdadocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE armr400_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE armr400_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT armr400_g01_subrep04
           DECLARE armr400_g01_repcur04 CURSOR FROM g_sql
           FOREACH armr400_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "armr400_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT armr400_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT armr400_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.rmdadocno.after name="rep.a_group.rmdadocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.rmdbseq
 
           #add-point:rep.a_group.rmdbseq.before name="rep.a_group.rmdbseq.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.rmdbseq.after name="rep.a_group.rmdbseq.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="armr400_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT armr400_g01_subrep01(sr2)
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
PRIVATE REPORT armr400_g01_subrep02(sr2)
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
PRIVATE REPORT armr400_g01_subrep03(sr2)
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
PRIVATE REPORT armr400_g01_subrep04(sr2)
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
 
{<section id="armr400_g01.other_function" readonly="Y" >}

 
{</section>}
 
{<section id="armr400_g01.other_report" readonly="Y" >}
#多庫儲批出貨資料
PRIVATE REPORT armr400_g01_subrep05(sr3)
DEFINE sr3  sr3_r
    ORDER EXTERNAL BY sr3.rmdcseq1    
    FORMAT
           
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr3.*
END REPORT

 
{</section>}
 
