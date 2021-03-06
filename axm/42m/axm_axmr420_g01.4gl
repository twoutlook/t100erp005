#該程式未解開Section, 採用最新樣板產出!
{<section id="axmr420_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:5(2016-11-09 12:30:56), PR版次:0005(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000275
#+ Filename...: axmr420_g01
#+ Description: ...
#+ Creator....: 05229(2014-04-24 16:52:31)
#+ Modifier...: 08992 -SD/PR- 00000
 
{</section>}
 
{<section id="axmr420_g01.global" readonly="Y" >}
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
   xmdt001 LIKE xmdt_t.xmdt001, 
   xmdt002 LIKE xmdt_t.xmdt002, 
   xmdt003 LIKE xmdt_t.xmdt003, 
   xmdt004 LIKE xmdt_t.xmdt004, 
   xmdt005 LIKE xmdt_t.xmdt005, 
   xmdt006 LIKE xmdt_t.xmdt006, 
   xmdt007 LIKE xmdt_t.xmdt007, 
   xmdt008 LIKE xmdt_t.xmdt008, 
   xmdt009 LIKE xmdt_t.xmdt009, 
   xmdt010 LIKE xmdt_t.xmdt010, 
   xmdt011 LIKE xmdt_t.xmdt011, 
   xmdt012 LIKE xmdt_t.xmdt012, 
   xmdt013 LIKE xmdt_t.xmdt013, 
   xmdt014 LIKE xmdt_t.xmdt014, 
   xmdt015 LIKE xmdt_t.xmdt015, 
   xmdt016 LIKE xmdt_t.xmdt016, 
   xmdt017 LIKE xmdt_t.xmdt017, 
   xmdt018 LIKE xmdt_t.xmdt018, 
   xmdt019 LIKE xmdt_t.xmdt019, 
   xmdt020 LIKE xmdt_t.xmdt020, 
   xmdt030 LIKE xmdt_t.xmdt030, 
   xmdtdocdt LIKE xmdt_t.xmdtdocdt, 
   xmdtdocno LIKE xmdt_t.xmdtdocno, 
   xmdtent LIKE xmdt_t.xmdtent, 
   xmdtsite LIKE xmdt_t.xmdtsite, 
   xmdtstus LIKE xmdt_t.xmdtstus, 
   xmdu001 LIKE xmdu_t.xmdu001, 
   xmdu002 LIKE xmdu_t.xmdu002, 
   xmdu003 LIKE xmdu_t.xmdu003, 
   xmdu004 LIKE xmdu_t.xmdu004, 
   xmdu005 LIKE xmdu_t.xmdu005, 
   xmdu006 LIKE xmdu_t.xmdu006, 
   xmdu007 LIKE xmdu_t.xmdu007, 
   xmdu008 LIKE xmdu_t.xmdu008, 
   xmdu009 LIKE xmdu_t.xmdu009, 
   xmdu010 LIKE xmdu_t.xmdu010, 
   xmdu011 LIKE xmdu_t.xmdu011, 
   xmdu012 LIKE xmdu_t.xmdu012, 
   xmdu013 LIKE xmdu_t.xmdu013, 
   xmdu014 LIKE xmdu_t.xmdu014, 
   xmdu015 LIKE xmdu_t.xmdu015, 
   xmdu030 LIKE xmdu_t.xmdu030, 
   xmduseq LIKE xmdu_t.xmduseq, 
   ooail_t_ooail003 LIKE ooail_t.ooail003, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   pmaal_t_pmaal004 LIKE pmaal_t.pmaal004, 
   oocql_t_oocql004 LIKE oocql_t.oocql004, 
   t1_oocql004 LIKE oocql_t.oocql004, 
   x_t2_oocql004 LIKE oocql_t.oocql004, 
   x_t3_oocql004 LIKE oocql_t.oocql004, 
   x_t4_oocql004 LIKE oocql_t.oocql004, 
   x_oocal_t_oocal003 LIKE oocal_t.oocal003, 
   l_xmdtdocno_desc LIKE type_t.chr80, 
   l_xmdt009_desc LIKE type_t.chr80, 
   l_xmdt006_desc LIKE type_t.chr80, 
   l_imaal004 LIKE type_t.chr300, 
   l_xmdt003_ooefl003 LIKE type_t.chr80, 
   l_xmdt002_ooag011 LIKE type_t.chr80, 
   l_xmdt004_pmaal004 LIKE type_t.chr80, 
   l_xmdtdocno_oobal004 LIKE type_t.chr80
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
TYPE sr3_r RECORD 
   xmdvdocno     LIKE xmdv_t.xmdvdocno,
   xmdv001       LIKE xmdv_t.xmdv001,
   xmdv002       LIKE xmdv_t.xmdv002,
   xmdv003       LIKE xmdv_t.xmdv003,
   xmdv004       LIKE xmdv_t.xmdv004

END RECORD
#end add-point
 
{</section>}
 
{<section id="axmr420_g01.main" readonly="Y" >}
PUBLIC FUNCTION axmr420_g01(p_arg1)
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
   
   LET g_rep_code = "axmr420_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL axmr420_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL axmr420_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL axmr420_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="axmr420_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axmr420_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   
   #end add-point
   LET g_select = " SELECT xmdt001,xmdt002,xmdt003,xmdt004,xmdt005,xmdt006,xmdt007,xmdt008,xmdt009,xmdt010, 
       xmdt011,xmdt012,xmdt013,xmdt014,xmdt015,xmdt016,xmdt017,xmdt018,xmdt019,xmdt020,xmdt030,xmdtdocdt, 
       xmdtdocno,xmdtent,xmdtsite,xmdtstus,xmdu001,xmdu002,xmdu003,xmdu004,xmdu005,xmdu006,xmdu007,xmdu008, 
       xmdu009,xmdu010,xmdu011,xmdu012,xmdu013,xmdu014,xmdu015,xmdu030,xmduseq,( SELECT ooail003 FROM ooail_t WHERE ooail_t.ooail001 = xmdt_t.xmdt005 AND ooail_t.ooailent = xmdt_t.xmdtent AND ooail_t.ooail002 = '" , 
       g_dlang,"'" ,"),x.imaal_t_imaal003,( SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = xmdt_t.xmdt002 AND ooag_t.ooagent = xmdt_t.xmdtent), 
       ( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = xmdt_t.xmdt003 AND ooefl_t.ooeflent = xmdt_t.xmdtent AND ooefl_t.ooefl002 = '" , 
       g_dlang,"'" ,"),( SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmdt_t.xmdt004 AND pmaal_t.pmaalent = xmdt_t.xmdtent AND pmaal_t.pmaal002 = '" , 
       g_dlang,"'" ,"),( SELECT oocql004 FROM oocql_t WHERE oocql_t.oocql001 = '238' AND oocql_t.oocql002 = xmdt_t.xmdt011 AND oocql_t.oocqlent = xmdt_t.xmdtent AND oocql_t.oocql003 = '" , 
       g_dlang,"'" ,"),( SELECT oocql004 FROM oocql_t WHERE oocql_t.oocql001 = '275' AND oocql_t.oocql002 = xmdt_t.xmdt019 AND oocql_t.oocqlent = xmdt_t.xmdtent AND oocql_t.oocql003 = '" , 
       g_dlang,"'" ,"),x.t2_oocql004,x.t3_oocql004,x.t4_oocql004,x.oocal_t_oocal003,NULL,NULL,NULL,'', 
       trim(xmdt003)||'.'||trim((SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = xmdt_t.xmdt003 AND ooefl_t.ooeflent = xmdt_t.xmdtent AND ooefl_t.ooefl002 = '" , 
       g_dlang,"'" ,")),trim(xmdt002)||'.'||trim((SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = xmdt_t.xmdt002 AND ooag_t.ooagent = xmdt_t.xmdtent)), 
       trim(xmdt004)||'.'||trim((SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmdt_t.xmdt004 AND pmaal_t.pmaalent = xmdt_t.xmdtent AND pmaal_t.pmaal002 = '" , 
       g_dlang,"'" ,")),NULL"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   #160621-00003#6 160629 by lori add---(S)
   #t1.oocql004改t1.oojdl003 
   LET g_select = " SELECT xmdt001,xmdt002,xmdt003,xmdt004,xmdt005,xmdt006,xmdt007,xmdt008,xmdt009,xmdt010, 
       xmdt011,xmdt012,xmdt013,xmdt014,xmdt015,xmdt016,xmdt017,xmdt018,xmdt019,xmdt020,xmdt030,xmdtdocdt, 
       xmdtdocno,xmdtent,xmdtsite,xmdtstus,xmdu001,xmdu002,xmdu003,xmdu004,xmdu005,xmdu006,xmdu007,xmdu008, 
       xmdu009,xmdu010,xmdu011,xmdu012,xmdu013,xmdu014,xmdu015,xmdu030,xmduseq,ooail_t.ooail003,x.imaal_t_imaal003, 
       ooag_t.ooag011,ooefl_t.ooefl003,pmaal_t.pmaal004,oocql_t.oocql004,t1.oojdl003,x.t2_oocql004,x.t3_oocql004, 
       x.t4_oocql004,x.oocal_t_oocal003,NULL,NULL,NULL,'',trim(xmdt003)||'.'||trim(ooefl_t.ooefl003), 
       trim(xmdt002)||'.'||trim(ooag_t.ooag011),trim(xmdt004)||'.'||trim(pmaal_t.pmaal004),NULL"   
   #160621-00003#6 160629 by lori add---(E)
   #end add-point
    LET g_from = " FROM xmdt_t LEFT OUTER JOIN ( SELECT xmdu_t.*,( SELECT imaal003 FROM imaal_t WHERE imaal_t.imaal001 = xmdu_t.xmdu002 AND imaal_t.imaalent = xmdu_t.xmduent AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,") imaal_t_imaal003,( SELECT oocql004 FROM oocql_t WHERE oocql_t.oocql001 = '221' AND oocql_t.oocql002 = xmdu_t.xmdu006 AND oocql_t.oocqlent = xmdu_t.xmduent AND oocql_t.oocql003 = '" , 
        g_dlang,"'" ,") t2_oocql004,( SELECT oocql004 FROM oocql_t WHERE oocql_t.oocql002 = xmdu_t.xmdu015 AND oocql_t.oocqlent = xmdu_t.xmduent AND oocql_t.oocql003 = '" , 
        g_dlang,"'" ,") t3_oocql004,( SELECT oocql004 FROM oocql_t WHERE oocql_t.oocql001 = '263' AND oocql_t.oocql002 = xmdu_t.xmdu014 AND oocql_t.oocqlent = xmdu_t.xmduent AND oocql_t.oocql003 = '" , 
        g_dlang,"'" ,") t4_oocql004,( SELECT oocal003 FROM oocal_t WHERE oocal_t.oocal001 = xmdu_t.xmdu008 AND oocal_t.oocalent = xmdu_t.xmduent AND oocal_t.oocal002 = '" , 
        g_dlang,"'" ,") oocal_t_oocal003 FROM xmdu_t ) x  ON xmdt_t.xmdtdocno = x.xmdudocno AND xmdt_t.xmdtent  
        = x.xmduent AND xmdt_t.xmdtsite = x.xmdusite"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   #160621-00003#6 160629 by lori add---(S)
   #mod:xmdt019=oojdl001
    LET g_from = " FROM xmdt_t LEFT OUTER JOIN oocql_t ON oocql_t.oocql001 = '238' AND oocql_t.oocql002 = xmdt_t.xmdt011 AND oocql_t.oocqlent = xmdt_t.xmdtent AND oocql_t.oocql003 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN oojdl_t t1 ON t1.oojdl001 = xmdt_t.xmdt019 AND t1.oojdlent = xmdt_t.xmdtent AND t1.oojdl002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN pmaal_t ON pmaal_t.pmaal001 = xmdt_t.xmdt004 AND pmaal_t.pmaalent = xmdt_t.xmdtent AND pmaal_t.pmaal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN ooefl_t ON ooefl_t.ooefl001 = xmdt_t.xmdt003 AND ooefl_t.ooeflent = xmdt_t.xmdtent AND ooefl_t.ooefl002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN ooag_t ON ooag_t.ooag001 = xmdt_t.xmdt002 AND ooag_t.ooagent = xmdt_t.xmdtent             LEFT OUTER JOIN ooail_t ON ooail_t.ooail001 = xmdt_t.xmdt005 AND ooail_t.ooailent = xmdt_t.xmdtent AND ooail_t.ooail002 = '" , 
        g_dlang,"'" ," LEFT OUTER JOIN ( SELECT xmdu_t.*,imaal_t.imaal003 imaal_t_imaal003,t2.oocql004 t2_oocql004, 
        t3.oocql004 t3_oocql004,t4.oocql004 t4_oocql004,oocal_t.oocal003 oocal_t_oocal003 FROM xmdu_t LEFT OUTER JOIN oocal_t ON oocal_t.oocal001 = xmdu_t.xmdu008 AND oocal_t.oocalent = xmdu_t.xmduent AND oocal_t.oocal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN oocql_t t2 ON t2.oocql001 = '221' AND t2.oocql002 = xmdu_t.xmdu006 AND t2.oocqlent = xmdu_t.xmduent AND t2.oocql003 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN oocql_t t3 ON t3.oocql002 = xmdu_t.xmdu015 AND t3.oocqlent = xmdu_t.xmduent AND t3.oocql003 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN imaal_t ON imaal_t.imaal001 = xmdu_t.xmdu002 AND imaal_t.imaalent = xmdu_t.xmduent AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN oocql_t t4 ON t4.oocql001 = '263' AND t4.oocql002 = xmdu_t.xmdu014 AND t4.oocqlent = xmdu_t.xmduent AND t4.oocql003 = '" , 
        g_dlang,"'" ," ) x  ON xmdt_t.xmdtdocno = x.xmdudocno AND xmdt_t.xmdtent = x.xmduent AND xmdt_t.xmdtsite  
        = x.xmdusite"   
   #160621-00003#6 160629 by lori add---(E)
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
           
   #end add-point
    LET g_order = " ORDER BY xmdtdocno,xmduseq"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("xmdt_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE axmr420_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE axmr420_g01_curs CURSOR FOR axmr420_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="axmr420_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION axmr420_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   xmdt001 LIKE xmdt_t.xmdt001, 
   xmdt002 LIKE xmdt_t.xmdt002, 
   xmdt003 LIKE xmdt_t.xmdt003, 
   xmdt004 LIKE xmdt_t.xmdt004, 
   xmdt005 LIKE xmdt_t.xmdt005, 
   xmdt006 LIKE xmdt_t.xmdt006, 
   xmdt007 LIKE xmdt_t.xmdt007, 
   xmdt008 LIKE xmdt_t.xmdt008, 
   xmdt009 LIKE xmdt_t.xmdt009, 
   xmdt010 LIKE xmdt_t.xmdt010, 
   xmdt011 LIKE xmdt_t.xmdt011, 
   xmdt012 LIKE xmdt_t.xmdt012, 
   xmdt013 LIKE xmdt_t.xmdt013, 
   xmdt014 LIKE xmdt_t.xmdt014, 
   xmdt015 LIKE xmdt_t.xmdt015, 
   xmdt016 LIKE xmdt_t.xmdt016, 
   xmdt017 LIKE xmdt_t.xmdt017, 
   xmdt018 LIKE xmdt_t.xmdt018, 
   xmdt019 LIKE xmdt_t.xmdt019, 
   xmdt020 LIKE xmdt_t.xmdt020, 
   xmdt030 LIKE xmdt_t.xmdt030, 
   xmdtdocdt LIKE xmdt_t.xmdtdocdt, 
   xmdtdocno LIKE xmdt_t.xmdtdocno, 
   xmdtent LIKE xmdt_t.xmdtent, 
   xmdtsite LIKE xmdt_t.xmdtsite, 
   xmdtstus LIKE xmdt_t.xmdtstus, 
   xmdu001 LIKE xmdu_t.xmdu001, 
   xmdu002 LIKE xmdu_t.xmdu002, 
   xmdu003 LIKE xmdu_t.xmdu003, 
   xmdu004 LIKE xmdu_t.xmdu004, 
   xmdu005 LIKE xmdu_t.xmdu005, 
   xmdu006 LIKE xmdu_t.xmdu006, 
   xmdu007 LIKE xmdu_t.xmdu007, 
   xmdu008 LIKE xmdu_t.xmdu008, 
   xmdu009 LIKE xmdu_t.xmdu009, 
   xmdu010 LIKE xmdu_t.xmdu010, 
   xmdu011 LIKE xmdu_t.xmdu011, 
   xmdu012 LIKE xmdu_t.xmdu012, 
   xmdu013 LIKE xmdu_t.xmdu013, 
   xmdu014 LIKE xmdu_t.xmdu014, 
   xmdu015 LIKE xmdu_t.xmdu015, 
   xmdu030 LIKE xmdu_t.xmdu030, 
   xmduseq LIKE xmdu_t.xmduseq, 
   ooail_t_ooail003 LIKE ooail_t.ooail003, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   pmaal_t_pmaal004 LIKE pmaal_t.pmaal004, 
   oocql_t_oocql004 LIKE oocql_t.oocql004, 
   t1_oocql004 LIKE oocql_t.oocql004, 
   x_t2_oocql004 LIKE oocql_t.oocql004, 
   x_t3_oocql004 LIKE oocql_t.oocql004, 
   x_t4_oocql004 LIKE oocql_t.oocql004, 
   x_oocal_t_oocal003 LIKE oocal_t.oocal003, 
   l_xmdtdocno_desc LIKE type_t.chr80, 
   l_xmdt009_desc LIKE type_t.chr80, 
   l_xmdt006_desc LIKE type_t.chr80, 
   l_imaal004 LIKE type_t.chr300, 
   l_xmdt003_ooefl003 LIKE type_t.chr80, 
   l_xmdt002_ooag011 LIKE type_t.chr80, 
   l_xmdt004_pmaal004 LIKE type_t.chr80, 
   l_xmdtdocno_oobal004 LIKE type_t.chr80
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_desc          LIKE type_t.chr300
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
 
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH axmr420_g01_curs INTO sr_s.*
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
       
       #規格說明
       CALL axmr420_g01_xmdu002_ref(sr_s.xmdtent,sr_s.xmdu002)
            RETURNING sr_s.l_imaal004
            
       #核價單號.說明
       LET l_desc = ''
       CALL s_aooi200_get_slip_desc(sr_s.xmdtdocno) 
            RETURNING l_desc
       CALL axmr420_g01_combination(sr_s.xmdtdocno,l_desc)
            RETURNING sr_s.l_xmdtdocno_oobal004
       
       #稅別
       CALL axmr420_g01_xmdt006_ref(sr_s.xmdtent,sr_s.xmdtsite,sr_s.xmdt006)
            RETURNING sr_s.l_xmdt006_desc
       LET sr_s.l_xmdt006_desc = sr_s.l_xmdt006_desc CLIPPED,sr_s.xmdt007 USING '<<<<<','%'      
       
       #收款條件
       CALL axmr420_g01_xmdt009_ref(sr_s.xmdtent,sr_s.xmdt009)
            RETURNING sr_s.l_xmdt009_desc 
            
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].xmdt001 = sr_s.xmdt001
       LET sr[l_cnt].xmdt002 = sr_s.xmdt002
       LET sr[l_cnt].xmdt003 = sr_s.xmdt003
       LET sr[l_cnt].xmdt004 = sr_s.xmdt004
       LET sr[l_cnt].xmdt005 = sr_s.xmdt005
       LET sr[l_cnt].xmdt006 = sr_s.xmdt006
       LET sr[l_cnt].xmdt007 = sr_s.xmdt007
       LET sr[l_cnt].xmdt008 = sr_s.xmdt008
       LET sr[l_cnt].xmdt009 = sr_s.xmdt009
       LET sr[l_cnt].xmdt010 = sr_s.xmdt010
       LET sr[l_cnt].xmdt011 = sr_s.xmdt011
       LET sr[l_cnt].xmdt012 = sr_s.xmdt012
       LET sr[l_cnt].xmdt013 = sr_s.xmdt013
       LET sr[l_cnt].xmdt014 = sr_s.xmdt014
       LET sr[l_cnt].xmdt015 = sr_s.xmdt015
       LET sr[l_cnt].xmdt016 = sr_s.xmdt016
       LET sr[l_cnt].xmdt017 = sr_s.xmdt017
       LET sr[l_cnt].xmdt018 = sr_s.xmdt018
       LET sr[l_cnt].xmdt019 = sr_s.xmdt019
       LET sr[l_cnt].xmdt020 = sr_s.xmdt020
       LET sr[l_cnt].xmdt030 = sr_s.xmdt030
       LET sr[l_cnt].xmdtdocdt = sr_s.xmdtdocdt
       LET sr[l_cnt].xmdtdocno = sr_s.xmdtdocno
       LET sr[l_cnt].xmdtent = sr_s.xmdtent
       LET sr[l_cnt].xmdtsite = sr_s.xmdtsite
       LET sr[l_cnt].xmdtstus = sr_s.xmdtstus
       LET sr[l_cnt].xmdu001 = sr_s.xmdu001
       LET sr[l_cnt].xmdu002 = sr_s.xmdu002
       LET sr[l_cnt].xmdu003 = sr_s.xmdu003
       LET sr[l_cnt].xmdu004 = sr_s.xmdu004
       LET sr[l_cnt].xmdu005 = sr_s.xmdu005
       LET sr[l_cnt].xmdu006 = sr_s.xmdu006
       LET sr[l_cnt].xmdu007 = sr_s.xmdu007
       LET sr[l_cnt].xmdu008 = sr_s.xmdu008
       LET sr[l_cnt].xmdu009 = sr_s.xmdu009
       LET sr[l_cnt].xmdu010 = sr_s.xmdu010
       LET sr[l_cnt].xmdu011 = sr_s.xmdu011
       LET sr[l_cnt].xmdu012 = sr_s.xmdu012
       LET sr[l_cnt].xmdu013 = sr_s.xmdu013
       LET sr[l_cnt].xmdu014 = sr_s.xmdu014
       LET sr[l_cnt].xmdu015 = sr_s.xmdu015
       LET sr[l_cnt].xmdu030 = sr_s.xmdu030
       LET sr[l_cnt].xmduseq = sr_s.xmduseq
       LET sr[l_cnt].ooail_t_ooail003 = sr_s.ooail_t_ooail003
       LET sr[l_cnt].x_imaal_t_imaal003 = sr_s.x_imaal_t_imaal003
       LET sr[l_cnt].ooag_t_ooag011 = sr_s.ooag_t_ooag011
       LET sr[l_cnt].ooefl_t_ooefl003 = sr_s.ooefl_t_ooefl003
       LET sr[l_cnt].pmaal_t_pmaal004 = sr_s.pmaal_t_pmaal004
       LET sr[l_cnt].oocql_t_oocql004 = sr_s.oocql_t_oocql004
       LET sr[l_cnt].t1_oocql004 = sr_s.t1_oocql004
       LET sr[l_cnt].x_t2_oocql004 = sr_s.x_t2_oocql004
       LET sr[l_cnt].x_t3_oocql004 = sr_s.x_t3_oocql004
       LET sr[l_cnt].x_t4_oocql004 = sr_s.x_t4_oocql004
       LET sr[l_cnt].x_oocal_t_oocal003 = sr_s.x_oocal_t_oocal003
       LET sr[l_cnt].l_xmdtdocno_desc = sr_s.l_xmdtdocno_desc
       LET sr[l_cnt].l_xmdt009_desc = sr_s.l_xmdt009_desc
       LET sr[l_cnt].l_xmdt006_desc = sr_s.l_xmdt006_desc
       LET sr[l_cnt].l_imaal004 = sr_s.l_imaal004
       LET sr[l_cnt].l_xmdt003_ooefl003 = sr_s.l_xmdt003_ooefl003
       LET sr[l_cnt].l_xmdt002_ooag011 = sr_s.l_xmdt002_ooag011
       LET sr[l_cnt].l_xmdt004_pmaal004 = sr_s.l_xmdt004_pmaal004
       LET sr[l_cnt].l_xmdtdocno_oobal004 = sr_s.l_xmdtdocno_oobal004
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axmr420_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION axmr420_g01_rep_data()
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
          START REPORT axmr420_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT axmr420_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT axmr420_g01_rep
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
 
{<section id="axmr420_g01.rep" readonly="Y" >}
PRIVATE REPORT axmr420_g01_rep(sr1)
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
DEFINE l_xmdu013_rate  LIKE type_t.chr10    #折扣率
DEFINE l_xmdu030_show  LIKE type_t.chr10    #備註
DEFINE l_xmdu003_show  LIKE type_t.chr10    #產品特徵
DEFINE l_xmdu005_show  LIKE type_t.chr10    #客戶料號
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER EXTERNAL BY sr1.xmdtdocno,sr1.xmduseq
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
        BEFORE GROUP OF sr1.xmdtdocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.xmdtdocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'xmdtent=' ,sr1.xmdtent,'{+}xmdtdocno=' ,sr1.xmdtdocno         
            CALL cl_gr_init_apr(sr1.xmdtdocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.xmdtdocno.before name="rep.b_group.xmdtdocno.before"
 
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.xmdtent CLIPPED ,"'", " AND  ooff003 = '", sr1.xmdtdocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE axmr420_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE axmr420_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT axmr420_g01_subrep01
           DECLARE axmr420_g01_repcur01 CURSOR FROM g_sql
           FOREACH axmr420_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "axmr420_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT axmr420_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT axmr420_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.xmdtdocno.after name="rep.b_group.xmdtdocno.after"
 
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.xmduseq
 
           #add-point:rep.b_group.xmduseq.before name="rep.b_group.xmduseq.before"
          
           #end add-point:
 
 
           #add-point:rep.b_group.xmduseq.after name="rep.b_group.xmduseq.after"
           
           #end add-point:
 
 
 
 
       ON EVERY ROW
          #add-point:rep.everyrow.before name="rep.everyrow.before"

       #若稅率為null，則將後面的%隱藏
       IF cl_null(sr1.xmdu013) THEN        
       
          LET l_xmdu013_rate = "N"
       ELSE
          LET l_xmdu013_rate = "Y"
  
       END IF
       
       #若產品特徵為null，將會隱藏
       IF cl_null(sr1.xmdu003) THEN
           LET l_xmdu003_show = "N"
       ELSE
           LET l_xmdu003_show = "Y"
       END IF
       
       #若備註為null，將會隱藏
       IF cl_null(sr1.xmdu030) THEN  
           LET l_xmdu030_show = "N"
       ELSE
           LET l_xmdu030_show = "Y"
       END IF
       
       #若客戶料號為null，將會隱藏
       IF cl_null(sr1.xmdu005) THEN  
           LET l_xmdu005_show = "N"
       ELSE
           LET l_xmdu005_show = "Y"
       END IF       
       
       PRINTX l_xmdu013_rate,l_xmdu003_show,l_xmdu030_show,l_xmdu005_show     
          #end add-point:rep.everyrow.before
 
          #單身前備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub02.before name="rep.sub02.before"
           
           #end add-point:rep.sub02.before
 
           #add-point:rep.sub02.sql name="rep.sub02.sql"
           
           #end add-point:rep.sub02.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='2' AND ooffent = '", 
                sr1.xmdtent CLIPPED ,"'", " AND  ooff003 = '", sr1.xmdtdocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.xmduseq CLIPPED ,""
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE axmr420_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE axmr420_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT axmr420_g01_subrep02
           DECLARE axmr420_g01_repcur02 CURSOR FROM g_sql
           FOREACH axmr420_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "axmr420_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT axmr420_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT axmr420_g01_subrep02
           #add-point:rep.sub02.after name="rep.sub02.after"
           
           #end add-point:rep.sub02.after
 
 
 
          #add-point:rep.everyrow.beforerow name="rep.everyrow.beforerow"
 
          #end add-point:rep.everyrow.beforerow
            
          PRINTX sr1.*
 
          #add-point:rep.everyrow.afterrow name="rep.everyrow.afterrow"
            START REPORT axmr420_g01_subrep05
            IF NOT cl_null(sr1.xmduseq) THEN   
               LET g_sql = " SELECT xmdvdocno,xmdv001,xmdv002,xmdv003,xmdv004 ",
                           "  FROM xmdv_t ",  
                           "  WHERE xmdvent = '",sr1.xmdtent,"' ",
                           "    AND xmdvdocno = '",sr1.xmdtdocno CLIPPED,"'",
                           "    AND xmdvseq = '",sr1.xmduseq CLIPPED,"' ",
                           "  ORDER BY xmdv001 "                                       
               DECLARE axmr420_g01_repcur05 CURSOR FROM g_sql
               FOREACH axmr420_g01_repcur05 INTO sr3.*
                  OUTPUT TO REPORT axmr420_g01_subrep05(sr3.*)
               END FOREACH   
            END IF               
            FINISH REPORT axmr420_g01_subrep05   
          #end add-point:rep.everyrow.afterrow
 
          #單身後備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub03.before name="rep.sub03.before"
 
           #end add-point:rep.sub03.before
 
           #add-point:rep.sub03.sql name="rep.sub03.sql"
           
           #end add-point:rep.sub03.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooffent = '", 
                sr1.xmdtent CLIPPED ,"'", " AND  ooff003 = '", sr1.xmdtdocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.xmduseq CLIPPED ,""
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE axmr420_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE axmr420_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT axmr420_g01_subrep03
           DECLARE axmr420_g01_repcur03 CURSOR FROM g_sql
           FOREACH axmr420_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "axmr420_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT axmr420_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT axmr420_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.xmdtdocno
 
           #add-point:rep.a_group.xmdtdocno.before name="rep.a_group.xmdtdocno.before"
 
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.xmdtent CLIPPED ,"'", " AND  ooff003 = '", sr1.xmdtdocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE axmr420_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE axmr420_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT axmr420_g01_subrep04
           DECLARE axmr420_g01_repcur04 CURSOR FROM g_sql
           FOREACH axmr420_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "axmr420_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT axmr420_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT axmr420_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.xmdtdocno.after name="rep.a_group.xmdtdocno.after"
 
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.xmduseq
 
           #add-point:rep.a_group.xmduseq.before name="rep.a_group.xmduseq.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.xmduseq.after name="rep.a_group.xmduseq.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="axmr420_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT axmr420_g01_subrep01(sr2)
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
PRIVATE REPORT axmr420_g01_subrep02(sr2)
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
PRIVATE REPORT axmr420_g01_subrep03(sr2)
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
PRIVATE REPORT axmr420_g01_subrep04(sr2)
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
 
{<section id="axmr420_g01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 抓取單別說明
# Memo...........:
# Usage..........: CALL axmr420_g01_xmdtdocno_ref(p_xmdtdocno)
#                  RETURNING r_xmdtdocno_desc
# Input parameter: p_xmdtdocno    核價單號
#                : 
# Return code....: r_xmdtdocno_desc 核價單號說明
#                : 
# Date & Author..: 140425 By Zechs
# Modify.........:
################################################################################
PRIVATE FUNCTION axmr420_g01_xmdtdocno_ref(p_xmdtdocno)
DEFINE p_xmdtdocno       LIKE xmdt_t.xmdtdocno
DEFINE r_xmdtdocno_desc  LIKE oobal_t.oobal004

   CALL s_aooi200_get_slip_desc(p_xmdtdocno) RETURNING r_xmdtdocno_desc

   RETURN r_xmdtdocno_desc
 
END FUNCTION

################################################################################
# Descriptions...: 代號跟說明組合
# Memo...........:
# Usage..........: CALL axmr420_g01_combination(p_value,p_desc)
#                  RETURNING r_combination
# Input parameter: p_value        代號
#                : p_desc         說明
# Return code....: r_combination  代號.說明
#                : 
# Date & Author..: 2014/05/06 By zechs
# Modify.........:
################################################################################
PRIVATE FUNCTION axmr420_g01_combination(p_value,p_desc)
DEFINE p_value           LIKE type_t.chr80
DEFINE p_desc            LIKE type_t.chr80
DEFINE r_combination     LIKE type_t.chr80

   LET r_combination = p_value CLIPPED,".",p_desc CLIPPED
   
   RETURN r_combination
END FUNCTION

################################################################################
# Descriptions...: 抓取稅別說明
# Memo...........:
# Usage..........: CALL axmr420_g01_xmdt006_ref(p_xmdtent,p_xmdtsite,p_xmdt006)
#                  RETURNING r_xmdt006_desc
# Input parameter: p_xmdtent  企業編號
#                : p_xmdtsite 營運據點
#                : p_xmdt006  稅別
# Return code....: r_xmdt006_desc 稅別說明
#                : 
# Date & Author..: 2014/05/06 By zechs
# Modify.........:
################################################################################
PRIVATE FUNCTION axmr420_g01_xmdt006_ref(p_xmdtent,p_xmdtsite,p_xmdt006)
DEFINE p_xmdtent         LIKE xmdt_t.xmdtent 
DEFINE p_xmdtsite        LIKE xmdt_t.xmdtsite
DEFINE p_xmdt006         LIKE xmdt_t.xmdt006
DEFINE r_xmdt006_desc    LIKE oodbl_t.oodbl004
DEFINE l_ooef019         LIKE ooef_t.ooef019


   #稅區
   SELECT ooef019 INTO l_ooef019 
     FROM ooef_t
    WHERE ooefent = p_xmdtent
      AND ooef001 = p_xmdtsite
   
   #稅別說明
   LET r_xmdt006_desc = ''
   SELECT oodbl004 INTO r_xmdt006_desc
     FROM oodbl_t
    WHERE oodblent = p_xmdtent
      AND oodbl001 = l_ooef019       
      AND oodbl002 = p_xmdt006
      AND oodbl003 = g_dlang

   RETURN r_xmdt006_desc
END FUNCTION

################################################################################
# Descriptions...: 抓取收款條件
# Memo...........:
# Usage..........: CALL axmr420_g01_xmdt009_ref(p_xmdtent,p_xmdt009)
#                  RETURNING r_xmdt009_desc
# Input parameter: p_xmdtent 企業編號
#                : p_xmdt009 收款條件
# Return code....: r_xmdt009_desc 收款條件說明
#                : 
# Date & Author..: 2014/05/06 By zechs
# Modify.........:
################################################################################
PRIVATE FUNCTION axmr420_g01_xmdt009_ref(p_xmdtent,p_xmdt009)
DEFINE p_xmdt009         LIKE xmdt_t.xmdt009
DEFINE p_xmdtent         LIKE xmdt_t.xmdtent
DEFINE r_xmdt009_desc    LIKE ooibl_t.ooibl004

   #收款說明
   LET r_xmdt009_desc = ''
   SELECT ooibl004 INTO r_xmdt009_desc
     FROM ooibl_t
    WHERE ooiblent = p_xmdtent
      AND ooibl002 = p_xmdt009
      AND ooibl003 = g_dlang
   
   RETURN r_xmdt009_desc
END FUNCTION

################################################################################
# Descriptions...: 規格说明
# Memo...........:
# Usage..........: CALL axmr420_g01_xmdu002_ref(p_xmdtent,p_xmdu002)
#                  RETURNING r_xmdu002_desc
# Input parameter: p_xmdtent 企業編號
#                : p_xmdu002 料件
# Return code....: r_xmdu002_desc 規格
#                : 
# Date & Author..: 2014/05/06 By zechs
# Modify.........:
################################################################################
PRIVATE FUNCTION axmr420_g01_xmdu002_ref(p_xmdtent,p_xmdu002)
DEFINE p_xmdu002         LIKE xmdu_t.xmdu002
DEFINE r_xmdu002_desc    LIKE imaal_t.imaal004   
DEFINE p_xmdtent         LIKE xmdt_t.xmdtent
   
   #規格說明
   LET r_xmdu002_desc = ''
   SELECT imaal004 INTO r_xmdu002_desc
     FROM imaal_t   
    WHERE imaalent = p_xmdtent
      AND imaal001 = p_xmdu002
      AND imaal002 = g_dlang
    
   RETURN r_xmdu002_desc
   
END FUNCTION

 
{</section>}
 
{<section id="axmr420_g01.other_report" readonly="Y" >}

################################################################################
# Descriptions...: 分量計價子報表
# Memo...........:
# Usage..........: CALL axmr420_g01_subrep05(sr3)
#                  
# Input parameter: sr3            資料RECORD
#                : 
# Return code....: 
#                : 
# Date & Author..: 2014/04/29 By zechs
# Modify.........:
################################################################################
PRIVATE REPORT axmr420_g01_subrep05(sr3)
DEFINE sr3             sr3_r

   ORDER EXTERNAL BY sr3.xmdvdocno
      FORMAT
           
        ON EVERY ROW
           PRINTX g_grNumFmt.*
           PRINTX sr3.*
END REPORT

 
{</section>}
 
