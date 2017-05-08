#該程式未解開Section, 採用最新樣板產出!
{<section id="aapr120_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2017-01-05 09:39:21), PR版次:0003(2017-01-05 09:45:45)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: aapr120_g01
#+ Description: ...
#+ Creator....: 08729(2016-11-11 14:30:41)
#+ Modifier...: 03080 -SD/PR- 03080
 
{</section>}
 
{<section id="aapr120_g01.global" readonly="Y" >}
#報表 g01 樣板自動產生(Version:13)
#add-point:填寫註解說明 name="global.memo"
#161122-00010#1      2016/11/24  By  08729  增加apba019欄位
#161229-00019#2      170105      By albireo 增加對象識別碼處理
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
   apbb002 LIKE apbb_t.apbb002, 
   apbb003 LIKE apbb_t.apbb003, 
   apbb004 LIKE apbb_t.apbb004, 
   apbb008 LIKE apbb_t.apbb008, 
   apbb009 LIKE apbb_t.apbb009, 
   apbb010 LIKE apbb_t.apbb010, 
   apbb011 LIKE apbb_t.apbb011, 
   apbb012 LIKE apbb_t.apbb012, 
   apbb0121 LIKE apbb_t.apbb0121, 
   apbb013 LIKE apbb_t.apbb013, 
   apbb014 LIKE apbb_t.apbb014, 
   apbb015 LIKE apbb_t.apbb015, 
   apbb016 LIKE apbb_t.apbb016, 
   apbb017 LIKE apbb_t.apbb017, 
   apbb018 LIKE apbb_t.apbb018, 
   apbb019 LIKE apbb_t.apbb019, 
   apbb020 LIKE apbb_t.apbb020, 
   apbb021 LIKE apbb_t.apbb021, 
   apbb023 LIKE apbb_t.apbb023, 
   apbb024 LIKE apbb_t.apbb024, 
   apbb025 LIKE apbb_t.apbb025, 
   apbb026 LIKE apbb_t.apbb026, 
   apbb027 LIKE apbb_t.apbb027, 
   apbb028 LIKE apbb_t.apbb028, 
   apbb029 LIKE apbb_t.apbb029, 
   apbb030 LIKE apbb_t.apbb030, 
   apbb031 LIKE apbb_t.apbb031, 
   apbb032 LIKE apbb_t.apbb032, 
   apbb033 LIKE apbb_t.apbb033, 
   apbb034 LIKE apbb_t.apbb034, 
   apbb036 LIKE apbb_t.apbb036, 
   apbb037 LIKE apbb_t.apbb037, 
   apbb038 LIKE apbb_t.apbb038, 
   apbb039 LIKE apbb_t.apbb039, 
   apbb040 LIKE apbb_t.apbb040, 
   apbb041 LIKE apbb_t.apbb041, 
   apbb042 LIKE apbb_t.apbb042, 
   apbb049 LIKE apbb_t.apbb049, 
   apbb050 LIKE apbb_t.apbb050, 
   apbb051 LIKE apbb_t.apbb051, 
   apbb052 LIKE apbb_t.apbb052, 
   apbb053 LIKE apbb_t.apbb053, 
   apbb054 LIKE apbb_t.apbb054, 
   apbb055 LIKE apbb_t.apbb055, 
   apbb056 LIKE apbb_t.apbb056, 
   apbb107 LIKE apbb_t.apbb107, 
   apbb108 LIKE apbb_t.apbb108, 
   apbb117 LIKE apbb_t.apbb117, 
   apbb118 LIKE apbb_t.apbb118, 
   apbb200 LIKE apbb_t.apbb200, 
   apbb202 LIKE apbb_t.apbb202, 
   apbb203 LIKE apbb_t.apbb203, 
   apbb204 LIKE apbb_t.apbb204, 
   apbb205 LIKE apbb_t.apbb205, 
   apbb206 LIKE apbb_t.apbb206, 
   apbb207 LIKE apbb_t.apbb207, 
   apbb208 LIKE apbb_t.apbb208, 
   apbb209 LIKE apbb_t.apbb209, 
   apbb210 LIKE apbb_t.apbb210, 
   apbbcomp LIKE apbb_t.apbbcomp, 
   apbbdocdt LIKE apbb_t.apbbdocdt, 
   apbbdocno LIKE apbb_t.apbbdocno, 
   apbbent LIKE apbb_t.apbbent, 
   apbbstus LIKE apbb_t.apbbstus, 
   apba004 LIKE apba_t.apba004, 
   apba005 LIKE apba_t.apba005, 
   apba006 LIKE apba_t.apba006, 
   apba007 LIKE apba_t.apba007, 
   apba008 LIKE apba_t.apba008, 
   apba009 LIKE apba_t.apba009, 
   apba010 LIKE apba_t.apba010, 
   apba012 LIKE apba_t.apba012, 
   apba013 LIKE apba_t.apba013, 
   apba014 LIKE apba_t.apba014, 
   apba015 LIKE apba_t.apba015, 
   apba016 LIKE apba_t.apba016, 
   apba017 LIKE apba_t.apba017, 
   apba019 LIKE apba_t.apba019, 
   apba020 LIKE apba_t.apba020, 
   apba100 LIKE apba_t.apba100, 
   apba103 LIKE apba_t.apba103, 
   apba104 LIKE apba_t.apba104, 
   apba105 LIKE apba_t.apba105, 
   apba111 LIKE apba_t.apba111, 
   apba113 LIKE apba_t.apba113, 
   apba114 LIKE apba_t.apba114, 
   apba115 LIKE apba_t.apba115, 
   apbaorga LIKE apba_t.apbaorga, 
   apbaseq LIKE apba_t.apbaseq, 
   pmaal_t_pmaal003 LIKE pmaal_t.pmaal003, 
   isacl_t_isacl004 LIKE isacl_t.isacl004, 
   t2_ooefl003 LIKE ooefl_t.ooefl003, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   oocql_t_oocql004 LIKE oocql_t.oocql004, 
   t1_oocql004 LIKE oocql_t.oocql004, 
   t3_oocql004 LIKE oocql_t.oocql004, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   l_apbb041_ooag011 LIKE type_t.chr300, 
   l_apbb002_pmaal003 LIKE type_t.chr300, 
   l_apbbcomp_ooefl003 LIKE type_t.chr1000, 
   l_apbb004_ooefl003 LIKE type_t.chr1000, 
   l_apbb051_desc LIKE type_t.chr100, 
   l_apbb052_desc LIKE type_t.chr100, 
   l_apbb054_desc LIKE type_t.chr100, 
   l_apbb014_desc LIKE type_t.chr100, 
   l_apbb012_desc LIKE type_t.chr100, 
   l_apba004_desc LIKE type_t.chr100, 
   l_apbb003_desc LIKE type_t.chr100, 
   l_apba019_desc LIKE type_t.chr100, 
   apbb059 LIKE apbb_t.apbb059
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING                   #where.condition
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
TYPE sr5_r RECORD
     isamdocno        LIKE isam_t.isamdocno,
     isamseq          LIKE isam_t.isamseq,
     isam008          LIKE isam_t.isam008,
     isam009          LIKE isam_t.isam009,
     isam010          LIKE isam_t.isam010,
     isam030          LIKE isam_t.isam030,
     isam011          LIKE isam_t.isam011,
     isam013          LIKE isam_t.isam013,
     isam023          LIKE isam_t.isam023,
     isam024          LIKE isam_t.isam024,
     isam025          LIKE isam_t.isam025,
     isam026          LIKE isam_t.isam026,
     isam027          LIKE isam_t.isam027,
     isam028          LIKE isam_t.isam028,
     l_isam008_desc   LIKE type_t.chr100,
     l_isam009        LIKE isam_t.isam009,
     l_pmaa001        LIKE pmaa_t.pmaa001,
     l_pmaa001_desc   LIKE type_t.chr100,
     l_isai002        LIKE isai_t.isai002,
     l_isam013_desc   LIKE type_t.chr100
     END RECORD
#end add-point
 
{</section>}
 
{<section id="aapr120_g01.main" readonly="Y" >}
PUBLIC FUNCTION aapr120_g01(p_arg1)
DEFINE  p_arg1 STRING                  #tm.wc  where.condition
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
   
   LET g_rep_code = "aapr120_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL aapr120_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL aapr120_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL aapr120_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="aapr120_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aapr120_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   
   #end add-point
   LET g_select = " SELECT apbb002,apbb003,apbb004,apbb008,apbb009,apbb010,apbb011,apbb012,apbb0121, 
       apbb013,apbb014,apbb015,apbb016,apbb017,apbb018,apbb019,apbb020,apbb021,apbb023,apbb024,apbb025, 
       apbb026,apbb027,apbb028,apbb029,apbb030,apbb031,apbb032,apbb033,apbb034,apbb036,apbb037,apbb038, 
       apbb039,apbb040,apbb041,apbb042,apbb049,apbb050,apbb051,apbb052,apbb053,apbb054,apbb055,apbb056, 
       apbb107,apbb108,apbb117,apbb118,apbb200,apbb202,apbb203,apbb204,apbb205,apbb206,apbb207,apbb208, 
       apbb209,apbb210,apbbcomp,apbbdocdt,apbbdocno,apbbent,apbbstus,apba004,apba005,apba006,apba007, 
       apba008,apba009,apba010,apba012,apba013,apba014,apba015,apba016,apba017,apba019,apba020,apba100, 
       apba103,apba104,apba105,apba111,apba113,apba114,apba115,apbaorga,apbaseq,( SELECT pmaal003 FROM pmaal_t WHERE pmaal_t.pmaalent = apbb_t.apbbent AND pmaal_t.pmaal001 = apbb_t.apbb002 AND pmaal_t.pmaal002 = '" , 
       g_dlang,"'" ,"),( SELECT isacl004 FROM isacl_t WHERE isacl_t.isaclent = apbb_t.apbbent AND isacl_t.isacl001 = apbb_t.apbbcomp AND isacl_t.isacl002 = apbb_t.apbb008 AND isacl_t.isacl003 = '" , 
       g_dlang,"'" ,"),( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooeflent = apbb_t.apbbent AND ooefl_t.ooefl001 = apbb_t.apbbcomp AND ooefl_t.ooefl002 = '" , 
       g_dlang,"'" ,"),( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooeflent = apbb_t.apbbent AND ooefl_t.ooefl001 = apbb_t.apbb004 AND ooefl_t.ooefl002 = '" , 
       g_dlang,"'" ,"),( SELECT oocql004 FROM oocql_t WHERE oocql_t.oocql001 = '3804' AND oocql_t.oocql002 = apbb_t.apbb038 AND oocql_t.oocqlent = apbb_t.apbbent AND oocql_t.oocql003 = '" , 
       g_dlang,"'" ,"),( SELECT oocql004 FROM oocql_t WHERE oocql_t.oocql001 = '3803' AND oocql_t.oocql002 = apbb_t.apbb207 AND oocql_t.oocqlent = apbb_t.apbbent AND oocql_t.oocql003 = '" , 
       g_dlang,"'" ,"),( SELECT oocql004 FROM oocql_t WHERE oocql_t.oocql001 = '3802' AND oocql_t.oocql002 = apbb_t.apbb202 AND oocql_t.oocqlent = apbb_t.apbbent AND oocql_t.oocql003 = '" , 
       g_dlang,"'" ,"),( SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = apbb_t.apbb041 AND ooag_t.ooagent = apbb_t.apbbent), 
       trim(apbb041)||'.'||trim((SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = apbb_t.apbb041 AND ooag_t.ooagent = apbb_t.apbbent)), 
       trim(apbb002)||'.'||trim((SELECT pmaal003 FROM pmaal_t WHERE pmaal_t.pmaalent = apbb_t.apbbent AND pmaal_t.pmaal001 = apbb_t.apbb002 AND pmaal_t.pmaal002 = '" , 
       g_dlang,"'" ,")),trim(apbbcomp)||'.'||trim((SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooeflent = apbb_t.apbbent AND ooefl_t.ooefl001 = apbb_t.apbbcomp AND ooefl_t.ooefl002 = '" , 
       g_dlang,"'" ,")),trim(apbb004)||'.'||trim((SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooeflent = apbb_t.apbbent AND ooefl_t.ooefl001 = apbb_t.apbb004 AND ooefl_t.ooefl002 = '" , 
       g_dlang,"'" ,")),'','','','','','','','',apbb059"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   
   #end add-point
    LET g_from = " FROM apbb_t LEFT OUTER JOIN ( SELECT apba_t.* FROM apba_t  ) x  ON apbb_t.apbbent  
        = x.apbaent AND apbb_t.apbbdocno = x.apbadocno"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
    LET g_order = " ORDER BY apbbdocno,apbaseq"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("apbb_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE aapr120_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE aapr120_g01_curs CURSOR FOR aapr120_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="aapr120_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION aapr120_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   apbb002 LIKE apbb_t.apbb002, 
   apbb003 LIKE apbb_t.apbb003, 
   apbb004 LIKE apbb_t.apbb004, 
   apbb008 LIKE apbb_t.apbb008, 
   apbb009 LIKE apbb_t.apbb009, 
   apbb010 LIKE apbb_t.apbb010, 
   apbb011 LIKE apbb_t.apbb011, 
   apbb012 LIKE apbb_t.apbb012, 
   apbb0121 LIKE apbb_t.apbb0121, 
   apbb013 LIKE apbb_t.apbb013, 
   apbb014 LIKE apbb_t.apbb014, 
   apbb015 LIKE apbb_t.apbb015, 
   apbb016 LIKE apbb_t.apbb016, 
   apbb017 LIKE apbb_t.apbb017, 
   apbb018 LIKE apbb_t.apbb018, 
   apbb019 LIKE apbb_t.apbb019, 
   apbb020 LIKE apbb_t.apbb020, 
   apbb021 LIKE apbb_t.apbb021, 
   apbb023 LIKE apbb_t.apbb023, 
   apbb024 LIKE apbb_t.apbb024, 
   apbb025 LIKE apbb_t.apbb025, 
   apbb026 LIKE apbb_t.apbb026, 
   apbb027 LIKE apbb_t.apbb027, 
   apbb028 LIKE apbb_t.apbb028, 
   apbb029 LIKE apbb_t.apbb029, 
   apbb030 LIKE apbb_t.apbb030, 
   apbb031 LIKE apbb_t.apbb031, 
   apbb032 LIKE apbb_t.apbb032, 
   apbb033 LIKE apbb_t.apbb033, 
   apbb034 LIKE apbb_t.apbb034, 
   apbb036 LIKE apbb_t.apbb036, 
   apbb037 LIKE apbb_t.apbb037, 
   apbb038 LIKE apbb_t.apbb038, 
   apbb039 LIKE apbb_t.apbb039, 
   apbb040 LIKE apbb_t.apbb040, 
   apbb041 LIKE apbb_t.apbb041, 
   apbb042 LIKE apbb_t.apbb042, 
   apbb049 LIKE apbb_t.apbb049, 
   apbb050 LIKE apbb_t.apbb050, 
   apbb051 LIKE apbb_t.apbb051, 
   apbb052 LIKE apbb_t.apbb052, 
   apbb053 LIKE apbb_t.apbb053, 
   apbb054 LIKE apbb_t.apbb054, 
   apbb055 LIKE apbb_t.apbb055, 
   apbb056 LIKE apbb_t.apbb056, 
   apbb107 LIKE apbb_t.apbb107, 
   apbb108 LIKE apbb_t.apbb108, 
   apbb117 LIKE apbb_t.apbb117, 
   apbb118 LIKE apbb_t.apbb118, 
   apbb200 LIKE apbb_t.apbb200, 
   apbb202 LIKE apbb_t.apbb202, 
   apbb203 LIKE apbb_t.apbb203, 
   apbb204 LIKE apbb_t.apbb204, 
   apbb205 LIKE apbb_t.apbb205, 
   apbb206 LIKE apbb_t.apbb206, 
   apbb207 LIKE apbb_t.apbb207, 
   apbb208 LIKE apbb_t.apbb208, 
   apbb209 LIKE apbb_t.apbb209, 
   apbb210 LIKE apbb_t.apbb210, 
   apbbcomp LIKE apbb_t.apbbcomp, 
   apbbdocdt LIKE apbb_t.apbbdocdt, 
   apbbdocno LIKE apbb_t.apbbdocno, 
   apbbent LIKE apbb_t.apbbent, 
   apbbstus LIKE apbb_t.apbbstus, 
   apba004 LIKE apba_t.apba004, 
   apba005 LIKE apba_t.apba005, 
   apba006 LIKE apba_t.apba006, 
   apba007 LIKE apba_t.apba007, 
   apba008 LIKE apba_t.apba008, 
   apba009 LIKE apba_t.apba009, 
   apba010 LIKE apba_t.apba010, 
   apba012 LIKE apba_t.apba012, 
   apba013 LIKE apba_t.apba013, 
   apba014 LIKE apba_t.apba014, 
   apba015 LIKE apba_t.apba015, 
   apba016 LIKE apba_t.apba016, 
   apba017 LIKE apba_t.apba017, 
   apba019 LIKE apba_t.apba019, 
   apba020 LIKE apba_t.apba020, 
   apba100 LIKE apba_t.apba100, 
   apba103 LIKE apba_t.apba103, 
   apba104 LIKE apba_t.apba104, 
   apba105 LIKE apba_t.apba105, 
   apba111 LIKE apba_t.apba111, 
   apba113 LIKE apba_t.apba113, 
   apba114 LIKE apba_t.apba114, 
   apba115 LIKE apba_t.apba115, 
   apbaorga LIKE apba_t.apbaorga, 
   apbaseq LIKE apba_t.apbaseq, 
   pmaal_t_pmaal003 LIKE pmaal_t.pmaal003, 
   isacl_t_isacl004 LIKE isacl_t.isacl004, 
   t2_ooefl003 LIKE ooefl_t.ooefl003, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   oocql_t_oocql004 LIKE oocql_t.oocql004, 
   t1_oocql004 LIKE oocql_t.oocql004, 
   t3_oocql004 LIKE oocql_t.oocql004, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   l_apbb041_ooag011 LIKE type_t.chr300, 
   l_apbb002_pmaal003 LIKE type_t.chr300, 
   l_apbbcomp_ooefl003 LIKE type_t.chr1000, 
   l_apbb004_ooefl003 LIKE type_t.chr1000, 
   l_apbb051_desc LIKE type_t.chr100, 
   l_apbb052_desc LIKE type_t.chr100, 
   l_apbb054_desc LIKE type_t.chr100, 
   l_apbb014_desc LIKE type_t.chr100, 
   l_apbb012_desc LIKE type_t.chr100, 
   l_apba004_desc LIKE type_t.chr100, 
   l_apbb003_desc LIKE type_t.chr100, 
   l_apba019_desc LIKE type_t.chr100, 
   apbb059 LIKE apbb_t.apbb059
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE g_ooef019          LIKE ooef_t.ooef019
DEFINE l_docno_str        STRING
DEFINE l_n                LIKE type_t.num10
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH aapr120_g01_curs INTO sr_s.*
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
       #抓取稅區
       SELECT ooef019 INTO g_ooef019
         FROM ooef_t
        WHERE ooefent = g_enterprise
          AND ooef001 = sr_s.apbbcomp
           
       LET sr_s.l_apbb003_desc =''
       CALL s_desc_gzcbl004_desc('8522',sr_s.apbb003) RETURNING sr_s.l_apbb003_desc
       CASE sr_s.apbb003
          WHEN '2'
                LET sr_s.l_apbb003_desc = sr_s.apbb003,' ',sr_s.l_apbb003_desc
          WHEN '5'
                LET sr_s.l_apbb003_desc = sr_s.apbb003,' ',sr_s.l_apbb003_desc
          WHEN '7'
                LET sr_s.l_apbb003_desc = sr_s.apbb003,' ',sr_s.l_apbb003_desc
          WHEN '8'
                LET sr_s.l_apbb003_desc = sr_s.apbb003,' ',sr_s.l_apbb003_desc
          WHEN '9'
                LET sr_s.l_apbb003_desc = sr_s.apbb003,' ',sr_s.l_apbb003_desc
       END CASE              
       
       LET sr_s.l_apbb051_desc =''
       LET sr_s.l_apbb051_desc = s_desc_get_person_desc(sr_s.apbb051)
       IF NOT cl_null(sr_s.l_apbb051_desc) THEN
          LET sr_s.l_apbb051_desc = sr_s.apbb051,' ',sr_s.l_apbb051_desc
       ELSE
          LET sr_s.l_apbb051_desc = sr_s.apbb051
       END IF
       
       LET sr_s.l_apbb052_desc =''
       LET sr_s.l_apbb052_desc = s_desc_get_department_desc(sr_s.apbb052)
       IF NOT cl_null(sr_s.l_apbb052_desc) THEN
          LET sr_s.l_apbb052_desc = sr_s.apbb052,' ',sr_s.l_apbb052_desc
       ELSE
          LET sr_s.l_apbb052_desc = sr_s.apbb052
       END IF
       
       LET sr_s.l_apbb012_desc =''
       LET sr_s.l_apbb012_desc = s_desc_get_tax_desc(g_ooef019,sr_s.apbb012)
       IF NOT cl_null(sr_s.l_apbb012_desc) THEN
          LET sr_s.l_apbb012_desc = sr_s.apbb012,' ',sr_s.l_apbb012_desc,'',sr_s.apbb013,"%" 
       ELSE
          LET sr_s.l_apbb012_desc = sr_s.apbb012
       END IF
       
       LET sr_s.l_apbb002_pmaal003 =''
       LET sr_s.l_apbb002_pmaal003 = s_desc_get_trading_partner_abbr_desc(sr_s.apbb002)
       #161229-00019#2-----s
       IF NOT cl_null(sr_s.apbb059)THEN
          CALL s_axrt300_xrca_ref('xrca057',sr_s.apbb059,'','') RETURNING g_sub_success,sr_s.l_apbb002_pmaal003
       END IF
       #161229-00019#2-----e
       IF NOT cl_null(sr_s.l_apbb002_pmaal003) THEN
          LET sr_s.l_apbb002_pmaal003 = sr_s.apbb002,' ',sr_s.l_apbb002_pmaal003
       ELSE
          LET sr_s.l_apbb002_pmaal003 = sr_s.apbb002
       END IF
       
       LET sr_s.l_apbb054_desc =''
       LET sr_s.l_apbb054_desc = s_desc_get_ooib002_desc(sr_s.apbb054)
       IF NOT cl_null(sr_s.l_apbb054_desc) THEN
          LET sr_s.l_apbb054_desc = sr_s.apbb054,' ',sr_s.l_apbb054_desc
       ELSE
          LET sr_s.l_apbb054_desc = sr_s.apbb054
       END IF
       
       LET sr_s.l_apbb014_desc =''
       LET sr_s.l_apbb014_desc = s_desc_get_currency_desc(sr_s.apbb014)
       IF NOT cl_null(sr_s.l_apbb014_desc) THEN
          LET sr_s.l_apbb014_desc = sr_s.apbb014,' ',sr_s.l_apbb014_desc
       ELSE
          LET sr_s.l_apbb014_desc = sr_s.apbb014
       END IF   
       
       LET sr_s.l_apba004_desc =''
       CALL s_desc_gzcbl004_desc('8541',sr_s.apba004) RETURNING sr_s.l_apba004_desc
       CASE sr_s.apba004
          WHEN '10'
                LET sr_s.l_apba004_desc = sr_s.apba004,' ',sr_s.l_apba004_desc
          WHEN '11'
                LET sr_s.l_apba004_desc = sr_s.apba004,' ',sr_s.l_apba004_desc
          WHEN '12'
                LET sr_s.l_apba004_desc = sr_s.apba004,' ',sr_s.l_apba004_desc
          WHEN '13'
                LET sr_s.l_apba004_desc = sr_s.apba004,' ',sr_s.l_apba004_desc
          WHEN '16'
                LET sr_s.l_apba004_desc = sr_s.apba004,' ',sr_s.l_apba004_desc
          WHEN '17'
                LET sr_s.l_apba004_desc = sr_s.apba004,' ',sr_s.l_apba004_desc
          WHEN '19'
                LET sr_s.l_apba004_desc = sr_s.apba004,' ',sr_s.l_apba004_desc
          WHEN '20'
                LET sr_s.l_apba004_desc = sr_s.apba004,' ',sr_s.l_apba004_desc
          WHEN '21'
                LET sr_s.l_apba004_desc = sr_s.apba004,' ',sr_s.l_apba004_desc
          WHEN '23'
                LET sr_s.l_apba004_desc = sr_s.apba004,' ',sr_s.l_apba004_desc
          WHEN '26'
                LET sr_s.l_apba004_desc = sr_s.apba004,' ',sr_s.l_apba004_desc
          WHEN '27'
                LET sr_s.l_apba004_desc = sr_s.apba004,' ',sr_s.l_apba004_desc
          WHEN '29'
                LET sr_s.l_apba004_desc = sr_s.apba004,' ',sr_s.l_apba004_desc
       END CASE   
       #161122-00010#1-(s)
       #預付已開發票
       LET sr_s.l_apba019_desc = ''
       IF sr_s.apba019 = 'Y' THEN
          LET sr_s.l_apba019_desc = 'Y'
       END IF
       IF sr_s.apba019 = 'N' THEN
          LET sr_s.l_apba019_desc = 'N'
       END IF
       IF cl_null(sr_s.apba019) THEN
          LET sr_s.l_apba019_desc = 'NULL'
       END IF
       #161122-00010#1-add(e)
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].apbb002 = sr_s.apbb002
       LET sr[l_cnt].apbb003 = sr_s.apbb003
       LET sr[l_cnt].apbb004 = sr_s.apbb004
       LET sr[l_cnt].apbb008 = sr_s.apbb008
       LET sr[l_cnt].apbb009 = sr_s.apbb009
       LET sr[l_cnt].apbb010 = sr_s.apbb010
       LET sr[l_cnt].apbb011 = sr_s.apbb011
       LET sr[l_cnt].apbb012 = sr_s.apbb012
       LET sr[l_cnt].apbb0121 = sr_s.apbb0121
       LET sr[l_cnt].apbb013 = sr_s.apbb013
       LET sr[l_cnt].apbb014 = sr_s.apbb014
       LET sr[l_cnt].apbb015 = sr_s.apbb015
       LET sr[l_cnt].apbb016 = sr_s.apbb016
       LET sr[l_cnt].apbb017 = sr_s.apbb017
       LET sr[l_cnt].apbb018 = sr_s.apbb018
       LET sr[l_cnt].apbb019 = sr_s.apbb019
       LET sr[l_cnt].apbb020 = sr_s.apbb020
       LET sr[l_cnt].apbb021 = sr_s.apbb021
       LET sr[l_cnt].apbb023 = sr_s.apbb023
       LET sr[l_cnt].apbb024 = sr_s.apbb024
       LET sr[l_cnt].apbb025 = sr_s.apbb025
       LET sr[l_cnt].apbb026 = sr_s.apbb026
       LET sr[l_cnt].apbb027 = sr_s.apbb027
       LET sr[l_cnt].apbb028 = sr_s.apbb028
       LET sr[l_cnt].apbb029 = sr_s.apbb029
       LET sr[l_cnt].apbb030 = sr_s.apbb030
       LET sr[l_cnt].apbb031 = sr_s.apbb031
       LET sr[l_cnt].apbb032 = sr_s.apbb032
       LET sr[l_cnt].apbb033 = sr_s.apbb033
       LET sr[l_cnt].apbb034 = sr_s.apbb034
       LET sr[l_cnt].apbb036 = sr_s.apbb036
       LET sr[l_cnt].apbb037 = sr_s.apbb037
       LET sr[l_cnt].apbb038 = sr_s.apbb038
       LET sr[l_cnt].apbb039 = sr_s.apbb039
       LET sr[l_cnt].apbb040 = sr_s.apbb040
       LET sr[l_cnt].apbb041 = sr_s.apbb041
       LET sr[l_cnt].apbb042 = sr_s.apbb042
       LET sr[l_cnt].apbb049 = sr_s.apbb049
       LET sr[l_cnt].apbb050 = sr_s.apbb050
       LET sr[l_cnt].apbb051 = sr_s.apbb051
       LET sr[l_cnt].apbb052 = sr_s.apbb052
       LET sr[l_cnt].apbb053 = sr_s.apbb053
       LET sr[l_cnt].apbb054 = sr_s.apbb054
       LET sr[l_cnt].apbb055 = sr_s.apbb055
       LET sr[l_cnt].apbb056 = sr_s.apbb056
       LET sr[l_cnt].apbb107 = sr_s.apbb107
       LET sr[l_cnt].apbb108 = sr_s.apbb108
       LET sr[l_cnt].apbb117 = sr_s.apbb117
       LET sr[l_cnt].apbb118 = sr_s.apbb118
       LET sr[l_cnt].apbb200 = sr_s.apbb200
       LET sr[l_cnt].apbb202 = sr_s.apbb202
       LET sr[l_cnt].apbb203 = sr_s.apbb203
       LET sr[l_cnt].apbb204 = sr_s.apbb204
       LET sr[l_cnt].apbb205 = sr_s.apbb205
       LET sr[l_cnt].apbb206 = sr_s.apbb206
       LET sr[l_cnt].apbb207 = sr_s.apbb207
       LET sr[l_cnt].apbb208 = sr_s.apbb208
       LET sr[l_cnt].apbb209 = sr_s.apbb209
       LET sr[l_cnt].apbb210 = sr_s.apbb210
       LET sr[l_cnt].apbbcomp = sr_s.apbbcomp
       LET sr[l_cnt].apbbdocdt = sr_s.apbbdocdt
       LET sr[l_cnt].apbbdocno = sr_s.apbbdocno
       LET sr[l_cnt].apbbent = sr_s.apbbent
       LET sr[l_cnt].apbbstus = sr_s.apbbstus
       LET sr[l_cnt].apba004 = sr_s.apba004
       LET sr[l_cnt].apba005 = sr_s.apba005
       LET sr[l_cnt].apba006 = sr_s.apba006
       LET sr[l_cnt].apba007 = sr_s.apba007
       LET sr[l_cnt].apba008 = sr_s.apba008
       LET sr[l_cnt].apba009 = sr_s.apba009
       LET sr[l_cnt].apba010 = sr_s.apba010
       LET sr[l_cnt].apba012 = sr_s.apba012
       LET sr[l_cnt].apba013 = sr_s.apba013
       LET sr[l_cnt].apba014 = sr_s.apba014
       LET sr[l_cnt].apba015 = sr_s.apba015
       LET sr[l_cnt].apba016 = sr_s.apba016
       LET sr[l_cnt].apba017 = sr_s.apba017
       LET sr[l_cnt].apba019 = sr_s.apba019
       LET sr[l_cnt].apba020 = sr_s.apba020
       LET sr[l_cnt].apba100 = sr_s.apba100
       LET sr[l_cnt].apba103 = sr_s.apba103
       LET sr[l_cnt].apba104 = sr_s.apba104
       LET sr[l_cnt].apba105 = sr_s.apba105
       LET sr[l_cnt].apba111 = sr_s.apba111
       LET sr[l_cnt].apba113 = sr_s.apba113
       LET sr[l_cnt].apba114 = sr_s.apba114
       LET sr[l_cnt].apba115 = sr_s.apba115
       LET sr[l_cnt].apbaorga = sr_s.apbaorga
       LET sr[l_cnt].apbaseq = sr_s.apbaseq
       LET sr[l_cnt].pmaal_t_pmaal003 = sr_s.pmaal_t_pmaal003
       LET sr[l_cnt].isacl_t_isacl004 = sr_s.isacl_t_isacl004
       LET sr[l_cnt].t2_ooefl003 = sr_s.t2_ooefl003
       LET sr[l_cnt].ooefl_t_ooefl003 = sr_s.ooefl_t_ooefl003
       LET sr[l_cnt].oocql_t_oocql004 = sr_s.oocql_t_oocql004
       LET sr[l_cnt].t1_oocql004 = sr_s.t1_oocql004
       LET sr[l_cnt].t3_oocql004 = sr_s.t3_oocql004
       LET sr[l_cnt].ooag_t_ooag011 = sr_s.ooag_t_ooag011
       LET sr[l_cnt].l_apbb041_ooag011 = sr_s.l_apbb041_ooag011
       LET sr[l_cnt].l_apbb002_pmaal003 = sr_s.l_apbb002_pmaal003
       LET sr[l_cnt].l_apbbcomp_ooefl003 = sr_s.l_apbbcomp_ooefl003
       LET sr[l_cnt].l_apbb004_ooefl003 = sr_s.l_apbb004_ooefl003
       LET sr[l_cnt].l_apbb051_desc = sr_s.l_apbb051_desc
       LET sr[l_cnt].l_apbb052_desc = sr_s.l_apbb052_desc
       LET sr[l_cnt].l_apbb054_desc = sr_s.l_apbb054_desc
       LET sr[l_cnt].l_apbb014_desc = sr_s.l_apbb014_desc
       LET sr[l_cnt].l_apbb012_desc = sr_s.l_apbb012_desc
       LET sr[l_cnt].l_apba004_desc = sr_s.l_apba004_desc
       LET sr[l_cnt].l_apbb003_desc = sr_s.l_apbb003_desc
       LET sr[l_cnt].l_apba019_desc = sr_s.l_apba019_desc
       LET sr[l_cnt].apbb059 = sr_s.apbb059
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    IF sr.getLength() > 0 THEN
       FOR l_n = 1 TO sr.getLength()
         IF cl_null(l_docno_str)THEN
            LET l_docno_str = sr[l_n].apbbdocno CLIPPED
         ELSE
            LET l_docno_str = l_docno_str CLIPPED,",",sr[l_n].apbbdocno CLIPPED,""
         END IF
       END FOR
       
       CALL s_fin_get_wc_str(l_docno_str) RETURNING l_docno_str
       
       LET g_print_cnt_sql = "UPDATE apbb_t SET apbb044 = (CASE WHEN apbb044 IS NULL THEN 1 ELSE apbb044 +1 END)", 
                             " WHERE apbbent = ",g_enterprise,
                             "   AND apbbcomp = '",sr[1].apbbcomp,"'",
                             "   AND apbbdocno IN ",l_docno_str
    END IF
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aapr120_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION aapr120_g01_rep_data()
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
          START REPORT aapr120_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT aapr120_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT aapr120_g01_rep
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
 
{<section id="aapr120_g01.rep" readonly="Y" >}
PRIVATE REPORT aapr120_g01_rep(sr1)
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
DEFINE l_apba103_sum    LIKE type_t.num20_6
DEFINE l_apba105_sum    LIKE type_t.num20_6
DEFINE l_apba113_sum    LIKE type_t.num20_6
DEFINE l_apba115_sum    LIKE type_t.num20_6
DEFINE l_apba010_sum    LIKE type_t.num20_6
DEFINE sr5      sr5_r 
DEFINE l_subrep05_show  LIKE type_t.chr1
DEFINE l_count          LIKE type_t.num5
DEFINE l_ooef019        LIKE ooef_t.ooef019
DEFINE l_isam023_sum    LIKE type_t.num20_6
DEFINE l_isam024_sum    LIKE type_t.num20_6
DEFINE l_isam025_sum    LIKE type_t.num20_6
DEFINE l_isam026_sum    LIKE type_t.num20_6
DEFINE l_isam027_sum    LIKE type_t.num20_6
DEFINE l_isam028_sum    LIKE type_t.num20_6
DEFINE l_isam010_show   LIKE type_t.chr10
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER  BY sr1.apbbdocno,sr1.apbaseq
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
        BEFORE GROUP OF sr1.apbbdocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.apbbdocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'apbbent=' ,sr1.apbbent,'{+}apbbdocno=' ,sr1.apbbdocno         
            CALL cl_gr_init_apr(sr1.apbbdocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.apbbdocno.before name="rep.b_group.apbbdocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.apbbent CLIPPED ,"'", " AND  ooff003 = '", sr1.apbbdocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aapr120_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE aapr120_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT aapr120_g01_subrep01
           DECLARE aapr120_g01_repcur01 CURSOR FROM g_sql
           FOREACH aapr120_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aapr120_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT aapr120_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT aapr120_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.apbbdocno.after name="rep.b_group.apbbdocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.apbaseq
 
           #add-point:rep.b_group.apbaseq.before name="rep.b_group.apbaseq.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.apbaseq.after name="rep.b_group.apbaseq.after"
           
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
                sr1.apbbent CLIPPED ,"'", " AND  ooff003 = '", sr1.apbbdocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.apbaseq CLIPPED ,""
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aapr120_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE aapr120_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT aapr120_g01_subrep02
           DECLARE aapr120_g01_repcur02 CURSOR FROM g_sql
           FOREACH aapr120_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aapr120_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT aapr120_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT aapr120_g01_subrep02
           #add-point:rep.sub02.after name="rep.sub02.after"
           
           #end add-point:rep.sub02.after
 
 
 
          #add-point:rep.everyrow.beforerow name="rep.everyrow.beforerow"
         
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
                sr1.apbbent CLIPPED ,"'", " AND  ooff003 = '", sr1.apbbdocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.apbaseq CLIPPED ,""
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aapr120_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE aapr120_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT aapr120_g01_subrep03
           DECLARE aapr120_g01_repcur03 CURSOR FROM g_sql
           FOREACH aapr120_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aapr120_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT aapr120_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT aapr120_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.apbbdocno
 
           #add-point:rep.a_group.apbbdocno.before name="rep.a_group.apbbdocno.before"
           #計算總額
           SELECT SUM(CASE WHEN apba012 = -1 THEN apba103 * -1 ELSE apba103 end),
                  SUM(CASE WHEN apba012 = -1 THEN apba105 * -1 ELSE apba105 end),
                  SUM(CASE WHEN apba012 = -1 THEN apba113 * -1 ELSE apba113 end),
                  SUM(CASE WHEN apba012 = -1 THEN apba115 * -1 ELSE apba115 end)
             INTO l_apba103_sum,l_apba105_sum,l_apba113_sum,l_apba115_sum
             FROM apba_t
            WHERE apbaent = g_enterprise AND apbadocno = sr1.apbbdocno
              AND (apba019 = 'Y' OR apba019 IS NULL)          #161122-00010#1-add
              #161122-00010#1 mark(s)
              #LET l_apba103_sum = l_apba103_sum * sr1.apba012  
              #LET l_apba105_sum = l_apba105_sum * sr1.apba012
              #LET l_apba113_sum = l_apba113_sum * sr1.apba012
              #LET l_apba115_sum = l_apba115_sum * sr1.apba012
              #161122-00010#1 mark(s)
           PRINTX l_apba103_sum
           PRINTX l_apba105_sum
           PRINTX l_apba113_sum
           PRINTX l_apba115_sum
           #數量合計
           LET l_apba010_sum = GROUP SUM(sr1.apba010)
           PRINTX l_apba010_sum
           ############################################
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.apbbent CLIPPED ,"'", " AND  ooff003 = '", sr1.apbbdocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aapr120_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE aapr120_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT aapr120_g01_subrep04
           DECLARE aapr120_g01_repcur04 CURSOR FROM g_sql
           FOREACH aapr120_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aapr120_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT aapr120_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT aapr120_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.apbbdocno.after name="rep.a_group.apbbdocno.after"
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep05_show ="N"
           LET g_sql = "SELECT isamdocno,isamseq,isam008,isam009,isam010,",   
                       "       isam030,isam011,isam013,isam023,isam024,",        
                       "       isam025,isam026,isam027,isam028,'','', ", 
                       "       '','','','' ",                                          
                       "  FROM isam_t ",
                       " WHERE isamdocno =  '",sr1.apbbdocno CLIPPED,"'",
                       "   AND isament   = '",sr1.apbbent   CLIPPED,"'",
                       "   AND isamcomp = '",sr1.apbbcomp CLIPPED,"' ",
                       " ORDER BY isamseq"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aapr120_g01_repcur05_cnt_pre FROM l_sub_sql
           EXECUTE aapr120_g01_repcur05_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep05_show ="Y"
           END IF
           PRINTX l_subrep05_show
           START REPORT aapr120_g01_subrep05
           DECLARE aapr120_g01_repcur05 CURSOR FROM g_sql
           FOREACH aapr120_g01_repcur05 INTO sr5.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aapr120_g01_repcur05:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
            
           #取得稅區
           SELECT ooef019 INTO l_ooef019
             FROM ooef_t
            WHERE ooefent = g_enterprise
              AND ooef001 = sr1.apbb004
           #取得發票編碼方式
           SELECT isai002 INTO sr5.l_isai002
             FROM isai_t
            WHERE isaient = g_enterprise
              AND isai001 = l_ooef019
           
           SELECT isam008 INTO sr5.isam008
             FROM isam_t
            WHERE isament = sr1.apbbent
              AND isamdocno =  sr1.apbbdocno    
              AND isamcomp = sr1.apbbcomp                 
           CALL s_desc_get_invoice_type_desc1(sr1.apbb004,sr5.isam008) RETURNING sr5.l_isam008_desc
           IF NOT cl_null(sr5.l_isam008_desc) THEN
              LET sr5.l_isam008_desc = sr5.isam008,sr5.l_isam008_desc
           ELSE
              LET sr5.l_isam008_desc = sr5.isam008
           END IF   
              
           #稅率串上百分比
           IF NOT cl_null(sr5.isam013) THEN
              LET sr5.l_isam013_desc = sr5.isam013,"%"
           ELSE
              LET sr5.l_isam013_desc = sr5.isam013
           END IF   
              OUTPUT TO REPORT aapr120_g01_subrep05(sr5.*)
           END FOREACH
           FINISH REPORT aapr120_g01_subrep05
           PRINTX l_subrep05_show
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.apbaseq
 
           #add-point:rep.a_group.apbaseq.before name="rep.a_group.apbaseq.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.apbaseq.after name="rep.a_group.apbaseq.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="aapr120_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT aapr120_g01_subrep01(sr2)
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
PRIVATE REPORT aapr120_g01_subrep02(sr2)
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
PRIVATE REPORT aapr120_g01_subrep03(sr2)
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
PRIVATE REPORT aapr120_g01_subrep04(sr2)
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
 
{<section id="aapr120_g01.other_function" readonly="Y" >}

 
{</section>}
 
{<section id="aapr120_g01.other_report" readonly="Y" >}

################################################################################
# Descriptions...: 發票細項子報表
# Memo...........:
# Usage..........: CALL aapr120_g01_subrep05(sr5)
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2016/11/15 By 08729
# Modify.........:
################################################################################
PRIVATE REPORT aapr120_g01_subrep05(sr5)
DEFINE sr5  sr5_r
DEFINE l_isam023_sum  LIKE isam_t.isam023  
DEFINE l_isam024_sum  LIKE isam_t.isam024
DEFINE l_isam025_sum  LIKE isam_t.isam025 
DEFINE l_isam026_sum  LIKE isam_t.isam026
DEFINE l_isam027_sum  LIKE isam_t.isam027 
DEFINE l_isam028_sum  LIKE isam_t.isam028 
DEFINE l_isam009_show LIKE type_t.chr1
DEFINE l_isam013_show LIKE type_t.chr1
DEFINE l_isam010_show LIKE type_t.chr10
    
    ORDER EXTERNAL BY sr5.isamdocno
    FORMAT
           
        ON EVERY ROW
           
           IF cl_null(sr5.isam013) THEN
              LET l_isam013_show = "N"
           ELSE
              LET l_isam013_show = "Y"
           END IF  
           IF sr5.l_isai002 = '2' THEN
              LET l_isam009_show = 'Y'
           ELSE
              LET l_isam009_show = 'N'
           END IF
           
           PRINTX l_isam013_show
           PRINTX l_isam009_show 
           PRINTX sr5.isam023
           PRINTX sr5.isam024
           PRINTX sr5.isam025
           PRINTX sr5.isam026
           PRINTX sr5.isam027
           PRINTX sr5.isam028
           PRINTX g_grNumFmt.*
           PRINTX sr5.*
        AFTER GROUP OF sr5.isamdocno      
              
           LET l_isam023_sum = GROUP SUM(sr5.isam023)
           LET l_isam024_sum = GROUP SUM(sr5.isam024)
           LET l_isam025_sum = GROUP SUM(sr5.isam025)
           LET l_isam026_sum = GROUP SUM(sr5.isam026)
           LET l_isam027_sum = GROUP SUM(sr5.isam027)
           LET l_isam028_sum = GROUP SUM(sr5.isam028)
           
           PRINTX l_isam023_sum 
           PRINTX l_isam024_sum
           PRINTX l_isam025_sum
           PRINTX l_isam026_sum
           PRINTX l_isam027_sum
           PRINTX l_isam028_sum    
END REPORT

 
{</section>}
 
