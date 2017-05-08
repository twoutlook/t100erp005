#該程式未解開Section, 採用最新樣板產出!
{<section id="apmr836_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2016-06-24 19:26:04), PR版次:0003(2016-06-27 11:30:44)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000045
#+ Filename...: apmr836_g01
#+ Description: ...
#+ Creator....: 02159(2015-03-30 18:02:08)
#+ Modifier...: 02159 -SD/PR- 02159
 
{</section>}
 
{<section id="apmr836_g01.global" readonly="Y" >}
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
   pmda006 LIKE pmda_t.pmda006, 
   pmda007 LIKE pmda_t.pmda007, 
   pmda020 LIKE pmda_t.pmda020, 
   pmda021 LIKE pmda_t.pmda021, 
   pmda022 LIKE pmda_t.pmda022, 
   pmda200 LIKE pmda_t.pmda200, 
   pmda201 LIKE pmda_t.pmda201, 
   pmda202 LIKE pmda_t.pmda202, 
   pmda203 LIKE pmda_t.pmda203, 
   pmda204 LIKE pmda_t.pmda204, 
   pmda205 LIKE pmda_t.pmda205, 
   pmda206 LIKE pmda_t.pmda206, 
   pmda207 LIKE pmda_t.pmda207, 
   pmda208 LIKE pmda_t.pmda208, 
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
   pmdb015 LIKE pmdb_t.pmdb015, 
   pmdb030 LIKE pmdb_t.pmdb030, 
   pmdb032 LIKE pmdb_t.pmdb032, 
   pmdb037 LIKE pmdb_t.pmdb037, 
   pmdb038 LIKE pmdb_t.pmdb038, 
   pmdb048 LIKE pmdb_t.pmdb048, 
   pmdb049 LIKE pmdb_t.pmdb049, 
   pmdb051 LIKE pmdb_t.pmdb051, 
   pmdb200 LIKE pmdb_t.pmdb200, 
   pmdb201 LIKE pmdb_t.pmdb201, 
   pmdb202 LIKE pmdb_t.pmdb202, 
   pmdb203 LIKE pmdb_t.pmdb203, 
   pmdb204 LIKE pmdb_t.pmdb204, 
   pmdb205 LIKE pmdb_t.pmdb205, 
   pmdb206 LIKE pmdb_t.pmdb206, 
   pmdb207 LIKE pmdb_t.pmdb207, 
   pmdb208 LIKE pmdb_t.pmdb208, 
   pmdb209 LIKE pmdb_t.pmdb209, 
   pmdb210 LIKE pmdb_t.pmdb210, 
   pmdb211 LIKE pmdb_t.pmdb211, 
   pmdb212 LIKE pmdb_t.pmdb212, 
   pmdb252 LIKE pmdb_t.pmdb252, 
   pmdb253 LIKE pmdb_t.pmdb253, 
   pmdb254 LIKE pmdb_t.pmdb254, 
   pmdb255 LIKE pmdb_t.pmdb255, 
   pmdb256 LIKE pmdb_t.pmdb256, 
   pmdb257 LIKE pmdb_t.pmdb257, 
   pmdb258 LIKE pmdb_t.pmdb258, 
   pmdb259 LIKE pmdb_t.pmdb259, 
   pmdb260 LIKE pmdb_t.pmdb260, 
   pmdbseq LIKE pmdb_t.pmdbseq, 
   pmdbsite LIKE pmdb_t.pmdbsite, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   x_t5_ooag011 LIKE ooag_t.ooag011, 
   t2_ooefl003 LIKE ooefl_t.ooefl003, 
   t3_ooefl003 LIKE ooefl_t.ooefl003, 
   t4_ooefl003 LIKE ooefl_t.ooefl003, 
   x_t6_ooefl003 LIKE ooefl_t.ooefl003, 
   x_t7_ooefl003 LIKE ooefl_t.ooefl003, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   x_t8_ooefl003 LIKE ooefl_t.ooefl003, 
   x_t10_ooefl003 LIKE ooefl_t.ooefl003, 
   x_t15_ooefl003 LIKE ooefl_t.ooefl003, 
   t1_ooefl003 LIKE ooefl_t.ooefl003, 
   oocql_t_oocql004 LIKE oocql_t.oocql004, 
   x_t11_oocql004 LIKE oocql_t.oocql004, 
   x_t12_oocql004 LIKE oocql_t.oocql004, 
   rtaxl_t_rtaxl003 LIKE rtaxl_t.rtaxl003, 
   inaa_t_inaa002 LIKE inaa_t.inaa002, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   x_imaal_t_imaal004 LIKE imaal_t.imaal004, 
   x_oocal_t_oocal003 LIKE oocal_t.oocal003, 
   x_t14_oocal003 LIKE oocal_t.oocal003, 
   x_pmaal_t_pmaal004 LIKE pmaal_t.pmaal004, 
   x_staal_t_staal003 LIKE staal_t.staal003, 
   l_pmdasite_ooefl003 LIKE type_t.chr1000, 
   l_pmda204_ooefl003 LIKE type_t.chr1000, 
   l_pmda203_ooefl003 LIKE type_t.chr1000, 
   l_pmda003_ooefl003 LIKE type_t.chr1000, 
   l_pmda002_ooag011 LIKE type_t.chr300, 
   l_pmda206_inaa002 LIKE type_t.chr1000, 
   l_pmda205_ooefl003 LIKE type_t.chr1000, 
   l_pmdb015_pmaal004 LIKE type_t.chr100, 
   l_pmdb037_ooefl003 LIKE type_t.chr1000, 
   l_pmdb203_ooefl003 LIKE type_t.chr1000, 
   l_pmdb205_ooefl003 LIKE type_t.chr1000, 
   l_pmdbsite_ooefl003 LIKE type_t.chr1000, 
   l_pmdb260_ooefl003 LIKE type_t.chr1000, 
   l_pmdb206_ooag011 LIKE type_t.chr300, 
   l_pmdb007_oocal003 LIKE type_t.chr100, 
   l_imaal003 LIKE imaal_t.imaal003, 
   l_imaal004 LIKE imaal_t.imaal004, 
   l_pmdb048_desc LIKE type_t.chr100, 
   l_pmda021_desc LIKE type_t.chr100, 
   l_pmda201_desc LIKE type_t.chr1000, 
   l_out1 LIKE type_t.chr1000, 
   l_out2 LIKE type_t.chr1000, 
   l_pmdb207_desc LIKE type_t.chr100, 
   pmdb213 LIKE pmdb_t.pmdb213
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
 
{<section id="apmr836_g01.main" readonly="Y" >}
PUBLIC FUNCTION apmr836_g01(p_arg1)
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
   
   LET g_rep_code = "apmr836_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL apmr836_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL apmr836_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL apmr836_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="apmr836_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apmr836_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   #160420-00039#21 160627 by sakura add(S)
   LET g_select = " SELECT pmda001,pmda002,pmda003,pmda004,pmda006,pmda007,pmda020,pmda021,pmda022,pmda200, 
       pmda201,pmda202,pmda203,pmda204,pmda205,pmda206,pmda207,pmda208,pmdadocdt,pmdadocno,pmdaent,pmdasite, 
       pmdastus,pmdb001,pmdb002,pmdb003,pmdb004,pmdb005,pmdb006,pmdb007,pmdb015,pmdb030,pmdb032,pmdb037, 
       pmdb038,pmdb048,pmdb049,pmdb051,pmdb200,pmdb201,pmdb202,pmdb203,pmdb204,pmdb205,pmdb206,pmdb207, 
       pmdb208,pmdb209,pmdb210,pmdb211,pmdb212,pmdb252,pmdb253,pmdb254,pmdb255,pmdb256,pmdb257,pmdb258, 
       pmdb259,pmdb260,pmdbseq,pmdbsite,ooag_t.ooag011,x.t5_ooag011,t2.ooefl003,t3.ooefl003,t4.ooefl003, 
       x.t6_ooefl003,x.t7_ooefl003,ooefl_t.ooefl003,x.t8_ooefl003,x.t10_ooefl003,x.t15_ooefl003,t1.ooefl003, 
       oocql_t.oocql004,x.t11_oocql004,x.t12_oocql004,rtaxl_t.rtaxl003,inaa_t.inaa002,x.imaal_t_imaal003, 
       x.imaal_t_imaal004,x.oocal_t_oocal003,x.t14_oocal003,x.pmaal_t_pmaal004,x.staal_t_staal003,trim(pmdasite)||'.'||trim(t4.ooefl003), 
       trim(pmda204)||'.'||trim(ooefl_t.ooefl003),trim(pmda203)||'.'||trim(t1.ooefl003),trim(pmda003)||'.'||trim(t3.ooefl003), 
       trim(pmda002)||'.'||trim(ooag_t.ooag011),trim(pmda206)||'.'||trim(inaa_t.inaa002),trim(pmda205)||'.'||trim(t2.ooefl003), 
       trim(pmdb015)||'.'||trim(x.pmaal_t_pmaal004),trim(pmdb037)||'.'||trim(x.t15_ooefl003),trim(pmdb203)||'.'||trim(x.t10_ooefl003), 
       trim(pmdb205)||'.'||trim(x.t8_ooefl003),trim(pmdbsite)||'.'||trim(x.t7_ooefl003),trim(pmdb260)||'.'||trim(x.t6_ooefl003), 
       trim(pmdb206)||'.'||trim(x.t5_ooag011),trim(pmdb007)||'.'||trim(x.oocal_t_oocal003),
       NULL,
       NULL, 
       (SELECT oocql004  FROM oocql_t
         WHERE oocqlent = ",g_enterprise,"
           AND oocql001 = '274'
           AND oocql002 = pmdb048
           AND oocql003 = '",g_dlang,"'),       
       (SELECT oocql004  FROM oocql_t
         WHERE oocqlent = ",g_enterprise,"
           AND oocql001 = '263'
           AND oocql002 = pmda021
           AND oocql003 = '",g_dlang,"'),       
       (SELECT gzcbl004
          FROM gzcb_t,gzcbl_t
         WHERE gzcb001 = '6014' AND gzcb002 = pmda201
           AND gzcb001 = gzcbl001 AND gzcb002 = gzcbl002
           AND gzcbl003 = '",g_dlang,"'),
       '','',
       (SELECT gzcbl004
          FROM gzcb_t,gzcbl_t
         WHERE gzcb001 = '6014' AND gzcb002 = pmdb207
           AND gzcb001 = gzcbl001 AND gzcb002 = gzcbl002
           AND gzcbl003 = '",g_dlang,"'),
       pmdb213"
       #160420-00039#21 160627 by sakura add(E)
#   #end add-point
#   LET g_select = " SELECT pmda001,pmda002,pmda003,pmda004,pmda006,pmda007,pmda020,pmda021,pmda022,pmda200, 
#       pmda201,pmda202,pmda203,pmda204,pmda205,pmda206,pmda207,pmda208,pmdadocdt,pmdadocno,pmdaent,pmdasite, 
#       pmdastus,pmdb001,pmdb002,pmdb003,pmdb004,pmdb005,pmdb006,pmdb007,pmdb015,pmdb030,pmdb032,pmdb037, 
#       pmdb038,pmdb048,pmdb049,pmdb051,pmdb200,pmdb201,pmdb202,pmdb203,pmdb204,pmdb205,pmdb206,pmdb207, 
#       pmdb208,pmdb209,pmdb210,pmdb211,pmdb212,pmdb252,pmdb253,pmdb254,pmdb255,pmdb256,pmdb257,pmdb258, 
#       pmdb259,pmdb260,pmdbseq,pmdbsite,( SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = pmda_t.pmda002 AND ooag_t.ooagent = pmda_t.pmdaent), 
#       x.t5_ooag011,( SELECT ooefl003 FROM ooefl_t t2 WHERE t2.ooeflent = pmda_t.pmdaent AND t2.ooefl001 = pmda_t.pmda205 AND t2.ooefl002 = '" , 
#       g_dlang,"'" ,"),( SELECT ooefl003 FROM ooefl_t t3 WHERE t3.ooefl001 = pmda_t.pmda003 AND t3.ooeflent = pmda_t.pmdaent AND t3.ooefl002 = '" , 
#       g_dlang,"'" ,"),( SELECT ooefl003 FROM ooefl_t t4 WHERE t4.ooeflent = pmda_t.pmdaent AND t4.ooefl001 = pmda_t.pmdasite AND t4.ooefl002 = '" , 
#       g_dlang,"'" ,"),x.t6_ooefl003,x.t7_ooefl003,( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooeflent = pmda_t.pmdaent AND ooefl_t.ooefl001 = pmda_t.pmda204 AND ooefl_t.ooefl002 = '" , 
#       g_dlang,"'" ,"),x.t8_ooefl003,x.t10_ooefl003,x.t15_ooefl003,( SELECT ooefl003 FROM ooefl_t t1 WHERE t1.ooeflent = pmda_t.pmdaent AND t1.ooefl001 = pmda_t.pmda203 AND t1.ooefl002 = '" , 
#       g_dlang,"'" ,"),( SELECT oocql004 FROM oocql_t WHERE oocql_t.oocql001 = '263' AND oocql_t.oocql002 = pmda_t.pmda021 AND oocql_t.oocqlent = pmda_t.pmdaent AND oocql_t.oocql003 = '" , 
#       g_dlang,"'" ,"),x.t11_oocql004,x.t12_oocql004,( SELECT rtaxl003 FROM rtaxl_t WHERE rtaxl_t.rtaxlent = pmda_t.pmdaent AND rtaxl_t.rtaxl001 = pmda_t.pmda202 AND rtaxl_t.rtaxl002 = '" , 
#       g_dlang,"'" ,"),( SELECT inaa002 FROM inaa_t WHERE inaa_t.inaaent = pmda_t.pmdaent AND inaa_t.inaa001 = pmda_t.pmda206), 
#       x.imaal_t_imaal003,x.imaal_t_imaal004,x.oocal_t_oocal003,x.t14_oocal003,x.pmaal_t_pmaal004,x.staal_t_staal003, 
#       trim(pmdasite)||'.'||trim((SELECT ooefl003 FROM ooefl_t t4 WHERE t4.ooeflent = pmda_t.pmdaent AND t4.ooefl001 = pmda_t.pmdasite AND t4.ooefl002 = '" , 
#       g_dlang,"'" ,")),trim(pmda204)||'.'||trim((SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooeflent = pmda_t.pmdaent AND ooefl_t.ooefl001 = pmda_t.pmda204 AND ooefl_t.ooefl002 = '" , 
#       g_dlang,"'" ,")),trim(pmda203)||'.'||trim((SELECT ooefl003 FROM ooefl_t t1 WHERE t1.ooeflent = pmda_t.pmdaent AND t1.ooefl001 = pmda_t.pmda203 AND t1.ooefl002 = '" , 
#       g_dlang,"'" ,")),trim(pmda003)||'.'||trim((SELECT ooefl003 FROM ooefl_t t3 WHERE t3.ooefl001 = pmda_t.pmda003 AND t3.ooeflent = pmda_t.pmdaent AND t3.ooefl002 = '" , 
#       g_dlang,"'" ,")),trim(pmda002)||'.'||trim((SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = pmda_t.pmda002 AND ooag_t.ooagent = pmda_t.pmdaent)), 
#       trim(pmda206)||'.'||trim((SELECT inaa002 FROM inaa_t WHERE inaa_t.inaaent = pmda_t.pmdaent AND inaa_t.inaa001 = pmda_t.pmda206)), 
#       trim(pmda205)||'.'||trim((SELECT ooefl003 FROM ooefl_t t2 WHERE t2.ooeflent = pmda_t.pmdaent AND t2.ooefl001 = pmda_t.pmda205 AND t2.ooefl002 = '" , 
#       g_dlang,"'" ,")),trim(pmdb015)||'.'||trim(x.pmaal_t_pmaal004),trim(pmdb037)||'.'||trim(x.t15_ooefl003), 
#       trim(pmdb203)||'.'||trim(x.t10_ooefl003),trim(pmdb205)||'.'||trim(x.t8_ooefl003),trim(pmdbsite)||'.'||trim(x.t7_ooefl003), 
#       trim(pmdb260)||'.'||trim(x.t6_ooefl003),trim(pmdb206)||'.'||trim(x.t5_ooag011),trim(pmdb007)||'.'||trim(x.oocal_t_oocal003), 
#       NULL,NULL,'','','','','','',pmdb213"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
    #160420-00039#21 160627 by sakura add(S)
    LET g_from = " FROM pmda_t LEFT OUTER JOIN ooefl_t ON ooefl_t.ooeflent = pmda_t.pmdaent AND ooefl_t.ooefl001 = pmda_t.pmda204 AND ooefl_t.ooefl002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN ooefl_t t1 ON t1.ooeflent = pmda_t.pmdaent AND t1.ooefl001 = pmda_t.pmda203 AND t1.ooefl002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN ooag_t ON ooag_t.ooag001 = pmda_t.pmda002 AND ooag_t.ooagent = pmda_t.pmdaent             LEFT OUTER JOIN rtaxl_t ON rtaxl_t.rtaxlent = pmda_t.pmdaent AND rtaxl_t.rtaxl001 = pmda_t.pmda202 AND rtaxl_t.rtaxl002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN ooefl_t t2 ON t2.ooeflent = pmda_t.pmdaent AND t2.ooefl001 = pmda_t.pmda205 AND t2.ooefl002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN ooefl_t t3 ON t3.ooefl001 = pmda_t.pmda003 AND t3.ooeflent = pmda_t.pmdaent AND t3.ooefl002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN ooefl_t t4 ON t4.ooeflent = pmda_t.pmdaent AND t4.ooefl001 = pmda_t.pmdasite AND t4.ooefl002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN inaa_t ON inaa_t.inaaent = pmda_t.pmdaent AND inaa_t.inaa001 = pmda_t.pmda206 AND inaa_t.inaasite = pmda_t.pmda205 LEFT OUTER JOIN oocql_t ON oocql_t.oocql001 = '263' AND oocql_t.oocql002 = pmda_t.pmda021 AND oocql_t.oocqlent = pmda_t.pmdaent AND oocql_t.oocql003 = '" , 
        g_dlang,"'" ," LEFT OUTER JOIN ( SELECT pmdb_t.*,t5.ooag011 t5_ooag011,t6.ooefl003 t6_ooefl003, 
        t7.ooefl003 t7_ooefl003,t8.ooefl003 t8_ooefl003,t10.ooefl003 t10_ooefl003,t15.ooefl003 t15_ooefl003, 
        t11.oocql004 t11_oocql004,t12.oocql004 t12_oocql004,imaal_t.imaal003 imaal_t_imaal003,imaal_t.imaal004 imaal_t_imaal004, 
        oocal_t.oocal003 oocal_t_oocal003,t14.oocal003 t14_oocal003,pmaal_t.pmaal004 pmaal_t_pmaal004, 
        staal_t.staal003 staal_t_staal003 FROM pmdb_t LEFT OUTER JOIN ooag_t t5 ON t5.ooag001 = pmdb_t.pmdb206 AND t5.ooagent = pmdb_t.pmdbent             LEFT OUTER JOIN staal_t ON staal_t.staalent = pmdb_t.pmdbent AND staal_t.staal001 = pmdb_t.pmdb209 AND staal_t.staal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN ooefl_t t6 ON t6.ooefl001 = pmdb_t.pmdb260 AND t6.ooeflent = pmdb_t.pmdbent AND t6.ooefl002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN ooefl_t t7 ON t7.ooeflent = pmdb_t.pmdbent AND t7.ooefl001 = pmdb_t.pmdbsite AND t7.ooefl002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN ooefl_t t8 ON t8.ooeflent = pmdb_t.pmdbent AND t8.ooefl001 = pmdb_t.pmdb205 AND t8.ooefl002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN ooefl_t t10 ON t10.ooeflent = pmdb_t.pmdbent AND t10.ooefl001 = pmdb_t.pmdb203 AND t10.ooefl002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN oocal_t ON oocal_t.oocal001 = pmdb_t.pmdb201 AND oocal_t.oocalent = pmdb_t.pmdbent AND oocal_t.oocal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN oocql_t t11 ON t11.oocql001 = '265' AND t11.oocql002 = pmdb_t.pmdb051 AND t11.oocqlent = pmdb_t.pmdbent AND t11.oocql003 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN oocql_t t12 ON t12.oocql001 = '274' AND t12.oocql002 = pmdb_t.pmdb048 AND t12.oocqlent = pmdb_t.pmdbent AND t12.oocql003 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN pmaal_t ON pmaal_t.pmaal001 = pmdb_t.pmdb015 AND pmaal_t.pmaalent = pmdb_t.pmdbent AND pmaal_t.pmaal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN oocal_t t14 ON t14.oocal001 = pmdb_t.pmdb007 AND t14.oocalent = pmdb_t.pmdbent AND t14.oocal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN imaal_t ON imaal_t.imaal001 = pmdb_t.pmdb004 AND imaal_t.imaalent = pmdb_t.pmdbent AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN ooefl_t t15 ON t15.ooefl001 = pmdb_t.pmdb037 AND t15.ooeflent = pmdb_t.pmdbent AND t15.ooefl002 = '" , 
        g_dlang,"'" ," ) x  ON pmda_t.pmdaent = x.pmdbent AND pmda_t.pmdadocno = x.pmdbdocno"
        #160420-00039#21 160627 by sakura add(E)
#   #end add-point
#    LET g_from = " FROM pmda_t LEFT OUTER JOIN ( SELECT pmdb_t.*,( SELECT ooag011 FROM ooag_t t5 WHERE t5.ooag001 = pmdb_t.pmdb206 AND t5.ooagent = pmdb_t.pmdbent) t5_ooag011, 
#        ( SELECT ooefl003 FROM ooefl_t t6 WHERE t6.ooefl001 = pmdb_t.pmdb260 AND t6.ooeflent = pmdb_t.pmdbent AND t6.ooefl002 = '" , 
#        g_dlang,"'" ,") t6_ooefl003,( SELECT ooefl003 FROM ooefl_t t7 WHERE t7.ooeflent = pmdb_t.pmdbent AND t7.ooefl001 = pmdb_t.pmdbsite AND t7.ooefl002 = '" , 
#        g_dlang,"'" ,") t7_ooefl003,( SELECT ooefl003 FROM ooefl_t t8 WHERE t8.ooeflent = pmdb_t.pmdbent AND t8.ooefl001 = pmdb_t.pmdb205 AND t8.ooefl002 = '" , 
#        g_dlang,"'" ,") t8_ooefl003,( SELECT ooefl003 FROM ooefl_t t10 WHERE t10.ooeflent = pmdb_t.pmdbent AND t10.ooefl001 = pmdb_t.pmdb203 AND t10.ooefl002 = '" , 
#        g_dlang,"'" ,") t10_ooefl003,( SELECT ooefl003 FROM ooefl_t t15 WHERE t15.ooefl001 = pmdb_t.pmdb037 AND t15.ooeflent = pmdb_t.pmdbent AND t15.ooefl002 = '" , 
#        g_dlang,"'" ,") t15_ooefl003,( SELECT oocql004 FROM oocql_t t11 WHERE t11.oocql001 = '265' AND t11.oocql002 = pmdb_t.pmdb051 AND t11.oocqlent = pmdb_t.pmdbent AND t11.oocql003 = '" , 
#        g_dlang,"'" ,") t11_oocql004,( SELECT oocql004 FROM oocql_t t12 WHERE t12.oocql001 = '274' AND t12.oocql002 = pmdb_t.pmdb048 AND t12.oocqlent = pmdb_t.pmdbent AND t12.oocql003 = '" , 
#        g_dlang,"'" ,") t12_oocql004,( SELECT imaal003 FROM imaal_t WHERE imaal_t.imaal001 = pmdb_t.pmdb004 AND imaal_t.imaalent = pmdb_t.pmdbent AND imaal_t.imaal002 = '" , 
#        g_dlang,"'" ,") imaal_t_imaal003,( SELECT imaal004 FROM imaal_t WHERE imaal_t.imaal001 = pmdb_t.pmdb004 AND imaal_t.imaalent = pmdb_t.pmdbent AND imaal_t.imaal002 = '" , 
#        g_dlang,"'" ,") imaal_t_imaal004,( SELECT oocal003 FROM oocal_t WHERE oocal_t.oocal001 = pmdb_t.pmdb201 AND oocal_t.oocalent = pmdb_t.pmdbent AND oocal_t.oocal002 = '" , 
#        g_dlang,"'" ,") oocal_t_oocal003,( SELECT oocal003 FROM oocal_t t14 WHERE t14.oocal001 = pmdb_t.pmdb007 AND t14.oocalent = pmdb_t.pmdbent AND t14.oocal002 = '" , 
#        g_dlang,"'" ,") t14_oocal003,( SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = pmdb_t.pmdb015 AND pmaal_t.pmaalent = pmdb_t.pmdbent AND pmaal_t.pmaal002 = '" , 
#        g_dlang,"'" ,") pmaal_t_pmaal004,( SELECT staal003 FROM staal_t WHERE staal_t.staalent = pmdb_t.pmdbent AND staal_t.staal001 = pmdb_t.pmdb209 AND staal_t.staal002 = '" , 
#        g_dlang,"'" ,") staal_t_staal003 FROM pmdb_t ) x  ON pmda_t.pmdaent = x.pmdbent AND pmda_t.pmdadocno  
#        = x.pmdbdocno"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
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
   PREPARE apmr836_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE apmr836_g01_curs CURSOR FOR apmr836_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="apmr836_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION apmr836_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   pmda001 LIKE pmda_t.pmda001, 
   pmda002 LIKE pmda_t.pmda002, 
   pmda003 LIKE pmda_t.pmda003, 
   pmda004 LIKE pmda_t.pmda004, 
   pmda006 LIKE pmda_t.pmda006, 
   pmda007 LIKE pmda_t.pmda007, 
   pmda020 LIKE pmda_t.pmda020, 
   pmda021 LIKE pmda_t.pmda021, 
   pmda022 LIKE pmda_t.pmda022, 
   pmda200 LIKE pmda_t.pmda200, 
   pmda201 LIKE pmda_t.pmda201, 
   pmda202 LIKE pmda_t.pmda202, 
   pmda203 LIKE pmda_t.pmda203, 
   pmda204 LIKE pmda_t.pmda204, 
   pmda205 LIKE pmda_t.pmda205, 
   pmda206 LIKE pmda_t.pmda206, 
   pmda207 LIKE pmda_t.pmda207, 
   pmda208 LIKE pmda_t.pmda208, 
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
   pmdb015 LIKE pmdb_t.pmdb015, 
   pmdb030 LIKE pmdb_t.pmdb030, 
   pmdb032 LIKE pmdb_t.pmdb032, 
   pmdb037 LIKE pmdb_t.pmdb037, 
   pmdb038 LIKE pmdb_t.pmdb038, 
   pmdb048 LIKE pmdb_t.pmdb048, 
   pmdb049 LIKE pmdb_t.pmdb049, 
   pmdb051 LIKE pmdb_t.pmdb051, 
   pmdb200 LIKE pmdb_t.pmdb200, 
   pmdb201 LIKE pmdb_t.pmdb201, 
   pmdb202 LIKE pmdb_t.pmdb202, 
   pmdb203 LIKE pmdb_t.pmdb203, 
   pmdb204 LIKE pmdb_t.pmdb204, 
   pmdb205 LIKE pmdb_t.pmdb205, 
   pmdb206 LIKE pmdb_t.pmdb206, 
   pmdb207 LIKE pmdb_t.pmdb207, 
   pmdb208 LIKE pmdb_t.pmdb208, 
   pmdb209 LIKE pmdb_t.pmdb209, 
   pmdb210 LIKE pmdb_t.pmdb210, 
   pmdb211 LIKE pmdb_t.pmdb211, 
   pmdb212 LIKE pmdb_t.pmdb212, 
   pmdb252 LIKE pmdb_t.pmdb252, 
   pmdb253 LIKE pmdb_t.pmdb253, 
   pmdb254 LIKE pmdb_t.pmdb254, 
   pmdb255 LIKE pmdb_t.pmdb255, 
   pmdb256 LIKE pmdb_t.pmdb256, 
   pmdb257 LIKE pmdb_t.pmdb257, 
   pmdb258 LIKE pmdb_t.pmdb258, 
   pmdb259 LIKE pmdb_t.pmdb259, 
   pmdb260 LIKE pmdb_t.pmdb260, 
   pmdbseq LIKE pmdb_t.pmdbseq, 
   pmdbsite LIKE pmdb_t.pmdbsite, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   x_t5_ooag011 LIKE ooag_t.ooag011, 
   t2_ooefl003 LIKE ooefl_t.ooefl003, 
   t3_ooefl003 LIKE ooefl_t.ooefl003, 
   t4_ooefl003 LIKE ooefl_t.ooefl003, 
   x_t6_ooefl003 LIKE ooefl_t.ooefl003, 
   x_t7_ooefl003 LIKE ooefl_t.ooefl003, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   x_t8_ooefl003 LIKE ooefl_t.ooefl003, 
   x_t10_ooefl003 LIKE ooefl_t.ooefl003, 
   x_t15_ooefl003 LIKE ooefl_t.ooefl003, 
   t1_ooefl003 LIKE ooefl_t.ooefl003, 
   oocql_t_oocql004 LIKE oocql_t.oocql004, 
   x_t11_oocql004 LIKE oocql_t.oocql004, 
   x_t12_oocql004 LIKE oocql_t.oocql004, 
   rtaxl_t_rtaxl003 LIKE rtaxl_t.rtaxl003, 
   inaa_t_inaa002 LIKE inaa_t.inaa002, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   x_imaal_t_imaal004 LIKE imaal_t.imaal004, 
   x_oocal_t_oocal003 LIKE oocal_t.oocal003, 
   x_t14_oocal003 LIKE oocal_t.oocal003, 
   x_pmaal_t_pmaal004 LIKE pmaal_t.pmaal004, 
   x_staal_t_staal003 LIKE staal_t.staal003, 
   l_pmdasite_ooefl003 LIKE type_t.chr1000, 
   l_pmda204_ooefl003 LIKE type_t.chr1000, 
   l_pmda203_ooefl003 LIKE type_t.chr1000, 
   l_pmda003_ooefl003 LIKE type_t.chr1000, 
   l_pmda002_ooag011 LIKE type_t.chr300, 
   l_pmda206_inaa002 LIKE type_t.chr1000, 
   l_pmda205_ooefl003 LIKE type_t.chr1000, 
   l_pmdb015_pmaal004 LIKE type_t.chr100, 
   l_pmdb037_ooefl003 LIKE type_t.chr1000, 
   l_pmdb203_ooefl003 LIKE type_t.chr1000, 
   l_pmdb205_ooefl003 LIKE type_t.chr1000, 
   l_pmdbsite_ooefl003 LIKE type_t.chr1000, 
   l_pmdb260_ooefl003 LIKE type_t.chr1000, 
   l_pmdb206_ooag011 LIKE type_t.chr300, 
   l_pmdb007_oocal003 LIKE type_t.chr100, 
   l_imaal003 LIKE imaal_t.imaal003, 
   l_imaal004 LIKE imaal_t.imaal004, 
   l_pmdb048_desc LIKE type_t.chr100, 
   l_pmda021_desc LIKE type_t.chr100, 
   l_pmda201_desc LIKE type_t.chr1000, 
   l_out1 LIKE type_t.chr1000, 
   l_out2 LIKE type_t.chr1000, 
   l_pmdb207_desc LIKE type_t.chr100, 
   pmdb213 LIKE pmdb_t.pmdb213
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
    FOREACH apmr836_g01_curs INTO sr_s.*
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
       #160420-00039#21 160627 by sakura mark(S)
       ##單頭:採購方式
       #CALL s_desc_gzcbl004_desc('6014',sr_s.pmda201) RETURNING sr_s.l_pmda201_desc
	    #
	    ##運送方式
       #CALL s_desc_get_acc_desc('263',sr_s.pmda021) RETURNING sr_s.l_pmda021_desc
	    #
	    ##收貨時段
	    #CALL s_desc_get_acc_desc('274',sr_s.pmdb048) RETURNING sr_s.l_pmdb048_desc
       #
       ##單身:採購方式
       #CALL s_desc_gzcbl004_desc('6014',sr_s.pmdb207) RETURNING sr_s.l_pmdb207_desc
       #
       ##品名,規格
       #SELECT imaal003,imaal004 INTO sr_s.l_imaal003,sr_s.l_imaal004
       #  FROM imaal_t
       # WHERE imaalent = g_enterprise
       #   AND imaal001 = sr_s.pmdb004      
       #   AND imaal002 = g_dlang
       #160420-00039#21 160627 by sakura mark(E)
       
       #160420-00039#21 160627 by sakura add(S)
       LET sr_s.l_imaal003 = sr_s.x_imaal_t_imaal003
       LET sr_s.l_imaal004 = sr_s.x_imaal_t_imaal004
       #160420-00039#21 160627 by sakura add(E)
       LET sr_s.l_imaal003 = sr_s.l_imaal003,'\n',sr_s.l_imaal004
          
       #當前面編號為空時，清空編號.說明的字串(避免編號為空會只顯示一個 .)
       CALL apmr836_g01_initialize(sr_s.pmda002,sr_s.l_pmda002_ooag011) RETURNING sr_s.l_pmda002_ooag011
       CALL apmr836_g01_initialize(sr_s.pmda003,sr_s.l_pmda003_ooefl003) RETURNING sr_s.l_pmda003_ooefl003
	    CALL apmr836_g01_initialize(sr_s.pmda204,sr_s.l_pmda204_ooefl003) RETURNING sr_s.l_pmda204_ooefl003
	    CALL apmr836_g01_initialize(sr_s.pmda205,sr_s.l_pmda205_ooefl003) RETURNING sr_s.l_pmda205_ooefl003
	    CALL apmr836_g01_initialize(sr_s.pmdb205,sr_s.l_pmdb205_ooefl003) RETURNING sr_s.l_pmdb205_ooefl003
	    CALL apmr836_g01_initialize(sr_s.pmdb203,sr_s.l_pmdb203_ooefl003) RETURNING sr_s.l_pmdb203_ooefl003
	    CALL apmr836_g01_initialize(sr_s.pmdbsite,sr_s.l_pmdbsite_ooefl003) RETURNING sr_s.l_pmdbsite_ooefl003	   
	    CALL apmr836_g01_initialize(sr_s.pmdb037,sr_s.l_pmdb037_ooefl003) RETURNING sr_s.l_pmdb037_ooefl003
	    CALL apmr836_g01_initialize(sr_s.pmdb260,sr_s.l_pmdb260_ooefl003) RETURNING sr_s.l_pmdb260_ooefl003
	    
	    #採購中心/配送中心
	    IF cl_null(sr_s.l_pmda205_ooefl003) AND cl_null(sr_s.l_pmdb203_ooefl003) THEN
	       LET sr_s.l_out1 = ''
       ELSE	    
	       LET sr_s.l_out1 = sr_s.l_pmda205_ooefl003,'/','\n',sr_s.l_pmdb203_ooefl003
	    END IF
	    #需求組織/收貨組織/收貨部門
	    IF cl_null(sr_s.l_pmdbsite_ooefl003) AND cl_null(sr_s.l_pmdb037_ooefl003) AND cl_null(sr_s.l_pmdb260_ooefl003) THEN
	       LET sr_s.l_out2 = ''
	    ELSE
          LET sr_s.l_out2 = sr_s.l_pmdbsite_ooefl003,'/','\n',sr_s.l_pmdb037_ooefl003,'/','\n',sr_s.l_pmdb260_ooefl003	    
	    END IF
	    
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].pmda001 = sr_s.pmda001
       LET sr[l_cnt].pmda002 = sr_s.pmda002
       LET sr[l_cnt].pmda003 = sr_s.pmda003
       LET sr[l_cnt].pmda004 = sr_s.pmda004
       LET sr[l_cnt].pmda006 = sr_s.pmda006
       LET sr[l_cnt].pmda007 = sr_s.pmda007
       LET sr[l_cnt].pmda020 = sr_s.pmda020
       LET sr[l_cnt].pmda021 = sr_s.pmda021
       LET sr[l_cnt].pmda022 = sr_s.pmda022
       LET sr[l_cnt].pmda200 = sr_s.pmda200
       LET sr[l_cnt].pmda201 = sr_s.pmda201
       LET sr[l_cnt].pmda202 = sr_s.pmda202
       LET sr[l_cnt].pmda203 = sr_s.pmda203
       LET sr[l_cnt].pmda204 = sr_s.pmda204
       LET sr[l_cnt].pmda205 = sr_s.pmda205
       LET sr[l_cnt].pmda206 = sr_s.pmda206
       LET sr[l_cnt].pmda207 = sr_s.pmda207
       LET sr[l_cnt].pmda208 = sr_s.pmda208
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
       LET sr[l_cnt].pmdb015 = sr_s.pmdb015
       LET sr[l_cnt].pmdb030 = sr_s.pmdb030
       LET sr[l_cnt].pmdb032 = sr_s.pmdb032
       LET sr[l_cnt].pmdb037 = sr_s.pmdb037
       LET sr[l_cnt].pmdb038 = sr_s.pmdb038
       LET sr[l_cnt].pmdb048 = sr_s.pmdb048
       LET sr[l_cnt].pmdb049 = sr_s.pmdb049
       LET sr[l_cnt].pmdb051 = sr_s.pmdb051
       LET sr[l_cnt].pmdb200 = sr_s.pmdb200
       LET sr[l_cnt].pmdb201 = sr_s.pmdb201
       LET sr[l_cnt].pmdb202 = sr_s.pmdb202
       LET sr[l_cnt].pmdb203 = sr_s.pmdb203
       LET sr[l_cnt].pmdb204 = sr_s.pmdb204
       LET sr[l_cnt].pmdb205 = sr_s.pmdb205
       LET sr[l_cnt].pmdb206 = sr_s.pmdb206
       LET sr[l_cnt].pmdb207 = sr_s.pmdb207
       LET sr[l_cnt].pmdb208 = sr_s.pmdb208
       LET sr[l_cnt].pmdb209 = sr_s.pmdb209
       LET sr[l_cnt].pmdb210 = sr_s.pmdb210
       LET sr[l_cnt].pmdb211 = sr_s.pmdb211
       LET sr[l_cnt].pmdb212 = sr_s.pmdb212
       LET sr[l_cnt].pmdb252 = sr_s.pmdb252
       LET sr[l_cnt].pmdb253 = sr_s.pmdb253
       LET sr[l_cnt].pmdb254 = sr_s.pmdb254
       LET sr[l_cnt].pmdb255 = sr_s.pmdb255
       LET sr[l_cnt].pmdb256 = sr_s.pmdb256
       LET sr[l_cnt].pmdb257 = sr_s.pmdb257
       LET sr[l_cnt].pmdb258 = sr_s.pmdb258
       LET sr[l_cnt].pmdb259 = sr_s.pmdb259
       LET sr[l_cnt].pmdb260 = sr_s.pmdb260
       LET sr[l_cnt].pmdbseq = sr_s.pmdbseq
       LET sr[l_cnt].pmdbsite = sr_s.pmdbsite
       LET sr[l_cnt].ooag_t_ooag011 = sr_s.ooag_t_ooag011
       LET sr[l_cnt].x_t5_ooag011 = sr_s.x_t5_ooag011
       LET sr[l_cnt].t2_ooefl003 = sr_s.t2_ooefl003
       LET sr[l_cnt].t3_ooefl003 = sr_s.t3_ooefl003
       LET sr[l_cnt].t4_ooefl003 = sr_s.t4_ooefl003
       LET sr[l_cnt].x_t6_ooefl003 = sr_s.x_t6_ooefl003
       LET sr[l_cnt].x_t7_ooefl003 = sr_s.x_t7_ooefl003
       LET sr[l_cnt].ooefl_t_ooefl003 = sr_s.ooefl_t_ooefl003
       LET sr[l_cnt].x_t8_ooefl003 = sr_s.x_t8_ooefl003
       LET sr[l_cnt].x_t10_ooefl003 = sr_s.x_t10_ooefl003
       LET sr[l_cnt].x_t15_ooefl003 = sr_s.x_t15_ooefl003
       LET sr[l_cnt].t1_ooefl003 = sr_s.t1_ooefl003
       LET sr[l_cnt].oocql_t_oocql004 = sr_s.oocql_t_oocql004
       LET sr[l_cnt].x_t11_oocql004 = sr_s.x_t11_oocql004
       LET sr[l_cnt].x_t12_oocql004 = sr_s.x_t12_oocql004
       LET sr[l_cnt].rtaxl_t_rtaxl003 = sr_s.rtaxl_t_rtaxl003
       LET sr[l_cnt].inaa_t_inaa002 = sr_s.inaa_t_inaa002
       LET sr[l_cnt].x_imaal_t_imaal003 = sr_s.x_imaal_t_imaal003
       LET sr[l_cnt].x_imaal_t_imaal004 = sr_s.x_imaal_t_imaal004
       LET sr[l_cnt].x_oocal_t_oocal003 = sr_s.x_oocal_t_oocal003
       LET sr[l_cnt].x_t14_oocal003 = sr_s.x_t14_oocal003
       LET sr[l_cnt].x_pmaal_t_pmaal004 = sr_s.x_pmaal_t_pmaal004
       LET sr[l_cnt].x_staal_t_staal003 = sr_s.x_staal_t_staal003
       LET sr[l_cnt].l_pmdasite_ooefl003 = sr_s.l_pmdasite_ooefl003
       LET sr[l_cnt].l_pmda204_ooefl003 = sr_s.l_pmda204_ooefl003
       LET sr[l_cnt].l_pmda203_ooefl003 = sr_s.l_pmda203_ooefl003
       LET sr[l_cnt].l_pmda003_ooefl003 = sr_s.l_pmda003_ooefl003
       LET sr[l_cnt].l_pmda002_ooag011 = sr_s.l_pmda002_ooag011
       LET sr[l_cnt].l_pmda206_inaa002 = sr_s.l_pmda206_inaa002
       LET sr[l_cnt].l_pmda205_ooefl003 = sr_s.l_pmda205_ooefl003
       LET sr[l_cnt].l_pmdb015_pmaal004 = sr_s.l_pmdb015_pmaal004
       LET sr[l_cnt].l_pmdb037_ooefl003 = sr_s.l_pmdb037_ooefl003
       LET sr[l_cnt].l_pmdb203_ooefl003 = sr_s.l_pmdb203_ooefl003
       LET sr[l_cnt].l_pmdb205_ooefl003 = sr_s.l_pmdb205_ooefl003
       LET sr[l_cnt].l_pmdbsite_ooefl003 = sr_s.l_pmdbsite_ooefl003
       LET sr[l_cnt].l_pmdb260_ooefl003 = sr_s.l_pmdb260_ooefl003
       LET sr[l_cnt].l_pmdb206_ooag011 = sr_s.l_pmdb206_ooag011
       LET sr[l_cnt].l_pmdb007_oocal003 = sr_s.l_pmdb007_oocal003
       LET sr[l_cnt].l_imaal003 = sr_s.l_imaal003
       LET sr[l_cnt].l_imaal004 = sr_s.l_imaal004
       LET sr[l_cnt].l_pmdb048_desc = sr_s.l_pmdb048_desc
       LET sr[l_cnt].l_pmda021_desc = sr_s.l_pmda021_desc
       LET sr[l_cnt].l_pmda201_desc = sr_s.l_pmda201_desc
       LET sr[l_cnt].l_out1 = sr_s.l_out1
       LET sr[l_cnt].l_out2 = sr_s.l_out2
       LET sr[l_cnt].l_pmdb207_desc = sr_s.l_pmdb207_desc
       LET sr[l_cnt].pmdb213 = sr_s.pmdb213
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apmr836_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION apmr836_g01_rep_data()
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
          START REPORT apmr836_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT apmr836_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT apmr836_g01_rep
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
 
{<section id="apmr836_g01.rep" readonly="Y" >}
PRIVATE REPORT apmr836_g01_rep(sr1)
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
DEFINE l_ooef017         LIKE ooef_t.ooef017   #法人
DEFINE l_g_site_t        LIKE ooef_t.ooef001   #儲存g_site值
DEFINE l_success         LIKE type_t.num5
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
            
            #取法人對內名稱
            CALL s_aooi100_get_comp(sr1.pmdasite) RETURNING l_success,l_ooef017
            LET l_g_site_t = g_site #備份g_site預設值
            LET g_site = l_ooef017  #抓法人資料
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.pmdadocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
            
            LET g_site = l_g_site_t #恢復原g_site值
            
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'pmdaent=' ,sr1.pmdaent,'{+}pmdadocno=' ,sr1.pmdadocno         
            CALL cl_gr_init_apr(sr1.pmdadocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.pmdadocno.before name="rep.b_group.pmdadocno.before"
           
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
           PREPARE apmr836_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE apmr836_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT apmr836_g01_subrep01
           DECLARE apmr836_g01_repcur01 CURSOR FROM g_sql
           FOREACH apmr836_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "apmr836_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT apmr836_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT apmr836_g01_subrep01
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
           PREPARE apmr836_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE apmr836_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT apmr836_g01_subrep02
           DECLARE apmr836_g01_repcur02 CURSOR FROM g_sql
           FOREACH apmr836_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "apmr836_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT apmr836_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT apmr836_g01_subrep02
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
                sr1.pmdaent CLIPPED ,"'", " AND  ooff003 = '", sr1.pmdadocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.pmdbseq CLIPPED ,""
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE apmr836_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE apmr836_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT apmr836_g01_subrep03
           DECLARE apmr836_g01_repcur03 CURSOR FROM g_sql
           FOREACH apmr836_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "apmr836_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT apmr836_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT apmr836_g01_subrep03
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
           PREPARE apmr836_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE apmr836_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT apmr836_g01_subrep04
           DECLARE apmr836_g01_repcur04 CURSOR FROM g_sql
           FOREACH apmr836_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "apmr836_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT apmr836_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT apmr836_g01_subrep04
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
 
{<section id="apmr836_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT apmr836_g01_subrep01(sr2)
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
PRIVATE REPORT apmr836_g01_subrep02(sr2)
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
PRIVATE REPORT apmr836_g01_subrep03(sr2)
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
PRIVATE REPORT apmr836_g01_subrep04(sr2)
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
 
{<section id="apmr836_g01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 是否要顯示.說明
# Memo...........:
# Usage..........: CALL apmr836_g01_initialize(p_arg,p_exp)
#                  RETURNING r_exp
# Input parameter: p_arg    編號
#                : p_exp    說明
# Return code....: r_exp    顯示值
# Date & Author..: 2015/03/30 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION apmr836_g01_initialize(p_arg,p_exp)
DEFINE p_arg   STRING
DEFINE p_exp   STRING
DEFINE r_exp   STRING

 INITIALIZE r_exp TO NULL
   IF cl_null(p_arg) OR p_exp = '.' THEN
      LET r_exp = p_arg
   ELSE
      LET r_exp = p_exp
   END IF
 RETURN r_exp

END FUNCTION

 
{</section>}
 
{<section id="apmr836_g01.other_report" readonly="Y" >}
{<point name="other.report"/>}
 
{</section>}
 
