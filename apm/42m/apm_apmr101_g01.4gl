#該程式未解開Section, 採用最新樣板產出!
{<section id="apmr101_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:4(2016-11-01 20:46:19), PR版次:0004(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000051
#+ Filename...: apmr101_g01
#+ Description: ...
#+ Creator....: 01996(2015-07-14 16:43:24)
#+ Modifier...: 08734 -SD/PR- 00000
 
{</section>}
 
{<section id="apmr101_g01.global" readonly="Y" >}
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
   pmbaent LIKE pmba_t.pmbaent, 
   pmbb054 LIKE pmbb_t.pmbb054, 
   pmbb088 LIKE pmbb_t.pmbb088, 
   l_pmbb107_desc LIKE type_t.chr1000, 
   pmbb107 LIKE pmbb_t.pmbb107, 
   l_pmbb106_desc LIKE type_t.chr1000, 
   pmbb106 LIKE pmbb_t.pmbb106, 
   l_pmbb104_desc LIKE type_t.chr1000, 
   pmbb104 LIKE pmbb_t.pmbb104, 
   l_pmbb103_desc LIKE type_t.chr1000, 
   pmbb103 LIKE pmbb_t.pmbb103, 
   l_pmbb105_desc LIKE type_t.chr1000, 
   pmbb105 LIKE pmbb_t.pmbb105, 
   l_pmbb085_desc LIKE type_t.chr1000, 
   pmbb085 LIKE pmbb_t.pmbb085, 
   l_pmbb087_desc LIKE type_t.chr1000, 
   pmbb087 LIKE pmbb_t.pmbb087, 
   l_pmbb084_desc LIKE type_t.chr1000, 
   pmbb084 LIKE pmbb_t.pmbb084, 
   l_pmbb086_desc LIKE type_t.chr1000, 
   pmbb086 LIKE pmbb_t.pmbb086, 
   l_pmbb089_desc LIKE type_t.chr1000, 
   pmbb089 LIKE pmbb_t.pmbb089, 
   l_pmbb088_desc LIKE type_t.chr1000, 
   l_pmbb083_desc LIKE type_t.chr1000, 
   pmbb083 LIKE pmbb_t.pmbb083, 
   l_pmbb057_desc LIKE type_t.chr1000, 
   pmbb057 LIKE pmbb_t.pmbb057, 
   l_pmbb056_desc LIKE type_t.chr1000, 
   pmbb056 LIKE pmbb_t.pmbb056, 
   l_pmbb054_desc LIKE type_t.chr1000, 
   l_pmbb053_desc LIKE type_t.chr1000, 
   pmbb053 LIKE pmbb_t.pmbb053, 
   l_pmbb055_desc LIKE type_t.chr1000, 
   pmbb055 LIKE pmbb_t.pmbb055, 
   l_pmbb035_desc LIKE type_t.chr1000, 
   pmbb035 LIKE pmbb_t.pmbb035, 
   l_pmbb037_desc LIKE type_t.chr1000, 
   pmbb037 LIKE pmbb_t.pmbb037, 
   l_pmbb034_desc LIKE type_t.chr1000, 
   pmbb034 LIKE pmbb_t.pmbb034, 
   l_pmbb036_desc LIKE type_t.chr1000, 
   pmbb036 LIKE pmbb_t.pmbb036, 
   l_pmbb039_desc LIKE type_t.chr1000, 
   pmbb039 LIKE pmbb_t.pmbb039, 
   l_pmbb038_desc LIKE type_t.chr1000, 
   pmbb038 LIKE pmbb_t.pmbb038, 
   l_pmbb033_desc LIKE type_t.chr1000, 
   pmbb033 LIKE pmbb_t.pmbb033, 
   pmba056 LIKE pmba_t.pmba056, 
   l_pmba053_desc LIKE type_t.chr1000, 
   pmba053 LIKE pmba_t.pmba053, 
   pmba055 LIKE pmba_t.pmba055, 
   l_pmba052_desc LIKE type_t.chr1000, 
   pmba052 LIKE pmba_t.pmba052, 
   l_pmba054_desc LIKE type_t.chr1000, 
   pmba054 LIKE pmba_t.pmba054, 
   l_pmba051_desc LIKE type_t.chr1000, 
   pmba051 LIKE pmba_t.pmba051, 
   l_pmba094_desc LIKE type_t.chr1000, 
   pmba094 LIKE pmba_t.pmba094, 
   l_pmba091_desc LIKE type_t.chr1000, 
   pmba091 LIKE pmba_t.pmba091, 
   l_pmba084_desc LIKE type_t.chr1000, 
   pmba084 LIKE pmba_t.pmba084, 
   l_pmba081_desc LIKE type_t.chr1000, 
   pmba081 LIKE pmba_t.pmba081, 
   l_pmba005_desc LIKE type_t.chr1000, 
   pmba005 LIKE pmba_t.pmba005, 
   pmba003 LIKE pmba_t.pmba003, 
   l_pmaal004 LIKE type_t.chr1000, 
   l_pmaal006_desc LIKE type_t.chr1000, 
   l_pmaal003_desc LIKE type_t.chr1000, 
   pmba001 LIKE pmba_t.pmba001, 
   l_pmba093_desc LIKE type_t.chr1000, 
   pmba093 LIKE pmba_t.pmba093, 
   l_pmba090_desc LIKE type_t.chr1000, 
   pmba090 LIKE pmba_t.pmba090, 
   l_pmba083_desc LIKE type_t.chr1000, 
   pmba083 LIKE pmba_t.pmba083, 
   l_pmba080_desc LIKE type_t.chr1000, 
   pmba080 LIKE pmba_t.pmba080, 
   l_pmba004_desc LIKE type_t.chr1000, 
   pmba004 LIKE pmba_t.pmba004, 
   l_pmba000_desc LIKE type_t.chr1000, 
   pmba000 LIKE pmba_t.pmba000, 
   l_pmba901_desc LIKE type_t.chr1000, 
   pmba901 LIKE pmba_t.pmba901, 
   l_pmba900_desc LIKE type_t.chr1000, 
   pmba900 LIKE pmba_t.pmba900, 
   pmbadocdt LIKE pmba_t.pmbadocdt, 
   pmbadocno LIKE pmba_t.pmbadocno
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING,                  #where codition 
       cod1 STRING,                  #列印交易夥伴 
       cod2 STRING,                  #列印聯絡地址 
       cod3 STRING,                  #列印通訊方式 
       cod4 STRING,                  #列印銀行資料 
       cod5 STRING,                  #列印允許收付 
       argv1 STRING                   #程式分類
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
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #reference用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #reference用陣列
 TYPE sr3_r RECORD
   pmbc003 LIKE gzcbl_t.gzcbl004,
   pmbc002 LIKE pmbc_t.pmbc002,
   pmaal004 LIKE pmaal_t.pmaal004,
   pmbc004  LIKE pmbc_t.pmbc004
END RECORD

 TYPE sr4_r RECORD
   nmabl003 LIKE nmabl_t.nmabl003,
   pmbf003 LIKE pmbf_t.pmbf003,
   pmbf004 LIKE pmbf_t.pmbf004,
   pmbf005 LIKE pmbf_t.pmbf005,
   pmbf007 LIKE pmbf_t.pmbf007,
   pmbf009 LIKE pmbf_t.pmbf009
END RECORD

 TYPE sr5_r RECORD
   pmbd002 LIKE pmbd_t.pmbd002,
   ooibl004 LIKE ooibl_t.ooibl004,
   pmbd004 LIKE pmbd_t.pmbd004
END RECORD

 TYPE sr6_r RECORD
   pmbd002 LIKE pmbd_t.pmbd002,
   ooibl004 LIKE ooibl_t.ooibl004,
   pmbd004 LIKE pmbd_t.pmbd004
END RECORD

 TYPE sr7_r RECORD
   oofb019  LIKE oofb_t.oofb019,
   oofb011  LIKE oofb_t.oofb011,
   oofb008  LIKE gzcbl_t.gzcbl004,
   oofb010  LIKE oofb_t.oofb010,
   oofb017  LIKE oofb_t.oofb017
 END RECORD
 
 TYPE sr8_r RECORD
    oofc008 LIKE gzcbl_t.gzcbl004,
    oofc009 LIKE oocql_t.oocql004,
    oofc012 LIKE oofc_t.oofc012,
    oofc010 LIKE oofc_t.oofc010,
    oofc014 LIKE oofc_t.oofc014,
    oodc011 LIKE oofc_t.oofc011
 END RECORD
#end add-point
 
{</section>}
 
{<section id="apmr101_g01.main" readonly="Y" >}
PUBLIC FUNCTION apmr101_g01(p_arg1,p_arg2,p_arg3,p_arg4,p_arg5,p_arg6,p_arg7)
DEFINE  p_arg1 STRING                  #tm.wc  where codition 
DEFINE  p_arg2 STRING                  #tm.cod1  列印交易夥伴 
DEFINE  p_arg3 STRING                  #tm.cod2  列印聯絡地址 
DEFINE  p_arg4 STRING                  #tm.cod3  列印通訊方式 
DEFINE  p_arg5 STRING                  #tm.cod4  列印銀行資料 
DEFINE  p_arg6 STRING                  #tm.cod5  列印允許收付 
DEFINE  p_arg7 STRING                  #tm.argv1  程式分類
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.cod1 = p_arg2
   LET tm.cod2 = p_arg3
   LET tm.cod3 = p_arg4
   LET tm.cod4 = p_arg5
   LET tm.cod5 = p_arg6
   LET tm.argv1 = p_arg7
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   IF cl_null(tm.cod1) THEN
      LET tm.cod1 = 'Y'
   END IF
   IF cl_null(tm.cod2) THEN
      LET tm.cod2 = 'Y'
   END IF
   IF cl_null(tm.cod3) THEN
      LET tm.cod3 = 'Y'
   END IF
   IF cl_null(tm.cod4) THEN
      LET tm.cod4 = 'Y'
   END IF
   IF cl_null(tm.cod5) THEN
      LET tm.cod5 = 'Y'
   END IF
   IF cl_null(tm.argv1) THEN
      LET tm.argv1 = '3'
   END IF
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "apmr101_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL apmr101_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL apmr101_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL apmr101_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="apmr101_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apmr101_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   DEFINE l_ooef019 LIKE ooef_t.ooef019
   DEFINE l_ooef019_2 LIKE ooef_t.ooef019
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   SELECT ooef019 INTO l_ooef019 FROM ooef_t 
    WHERE ooefent = g_enterprise AND ooef001 = g_site
   SELECT ooef019 INTO l_ooef019_2 FROM ooef_t
    WHERE ooefent = g_enterprise AND ooef001 = 'ALL'
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   LET g_select = " SELECT pmbaent,pmbb054,pmbb088,t1.gzcbl004,pmbb107,t2.isacl004,pmbb106,t3.pmaml003,pmbb104,t4.oocql004,pmbb103,t5.oocql004,pmbb105,t6.gzcbl004,", 
                  #160621-00003#3 20160627 modify by beckxie---S
                  #"pmbb085,t7.ooibl004,pmbb087,t8.oodbl004,pmbb084,t9.gzcbl004,pmbb086,t10.oocql004,pmbb089,t11.oocql004,t12.ooail003,pmbb083,t13.gzcbl004,pmbb057,t14.isacl004,pmbb056,t15.pmaml003,t16.oocql004,", 
                  #"pmbb053,t17.oocql004,pmbb055,t18.gzcbl004,pmbb035,t19.ooibl004,pmbb037,t20.oodbl004,pmbb034,t21.gzcbl004,pmbb036,t22.oocql004,pmbb039,t23.oocql004,pmbb038,t24.ooail003,pmbb033," ,
                  "pmbb085,t7.ooibl004,pmbb087,t8.oodbl004,pmbb084,t9.gzcbl004,pmbb086,t10.oocql004,pmbb089,t11.oojdl003,t12.ooail003,pmbb083,t13.gzcbl004,pmbb057,t14.isacl004,pmbb056,t15.pmaml003,t16.oocql004,", 
                  "pmbb053,t17.oocql004,pmbb055,t18.gzcbl004,pmbb035,t19.ooibl004,pmbb037,t20.oodbl004,pmbb034,t21.gzcbl004,pmbb036,t22.oocql004,pmbb039,t23.oojdl003,pmbb038,t24.ooail003,pmbb033," ,
                  #160621-00003#3 20160627 modify by beckxie---E
                  "pmba056,trim(pmba053)||'.'||trim(t25.xmajl003),pmba053,pmba055,trim(pmba052)||'.'||trim(t26.pmaal004),pmba052,trim(pmba054)||'.'||trim(t27.ooail003),pmba054,t28.gzcbl004,pmba051,t36.oocql004,pmba094,t37.oocql004,pmba091,t38.oocql004,pmba084,t39.oocql004,pmba081,''," ,
                  "pmba005,pmba003,t29.pmbal003,t29.pmbal005,t29.pmbal002,pmba001,t30.oocql004,pmba093,t31.oocql004,pmba090,t32.oocql004,pmba083,t33.oocql004,pmba080,t34.gzcbl004,pmba004,t35.gzcbl004,pmba000,", 
                  "ooefl003,pmba901,ooag011,pmba900,pmbadocdt,pmbadocno"
#   #end add-point
#   LET g_select = " SELECT pmbaent,pmbb054,pmbb088,'',pmbb107,'',pmbb106,'',pmbb104,'',pmbb103,'',pmbb105, 
#       '',pmbb085,'',pmbb087,'',pmbb084,'',pmbb086,'',pmbb089,'','',pmbb083,'',pmbb057,'',pmbb056,'', 
#       '',pmbb053,'',pmbb055,'',pmbb035,'',pmbb037,'',pmbb034,'',pmbb036,'',pmbb039,'',pmbb038,'',pmbb033, 
#       pmba056,'',pmba053,pmba055,'',pmba052,'',pmba054,'',pmba051,'',pmba094,'',pmba091,'',pmba084, 
#       '',pmba081,'',pmba005,pmba003,'','','',pmba001,'',pmba093,'',pmba090,'',pmba083,'',pmba080,'', 
#       pmba004,'',pmba000,'',pmba901,'',pmba900,pmbadocdt,pmbadocno"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
    LET g_from = " FROM pmba_t LEFT OUTER JOIN xmajl_t t25 ON pmbaent = t25.xmajlent AND t25.xmajl001 = pmba053 AND t25.xmajl002 = '",g_dlang,"'",
                 "             LEFT OUTER JOIN pmaal_t t26 ON pmbaent = t26.pmaalent AND t26.pmaal001 = pmba052 AND t26.pmaal002 = '",g_dlang,"'",
                 "             LEFT OUTER JOIN ooail_t t27 ON pmbaent = t27.ooailent AND t27.ooail001 = pmba054 AND t27.ooail002 = '",g_dlang,"'",
                 "             LEFT OUTER JOIN gzcbl_t t28 ON t28.gzcbl001 = 2033 AND t28.gzcbl002 = pmba051 AND t28.gzcbl003 = '",g_dlang,"'",
                 "             LEFT OUTER JOIN pmbal_t t29 ON pmbaent = t29.pmbalent AND t29.pmbaldocno = pmbadocno AND t29.pmbal001 = '",g_dlang,"'",
                 "             LEFT OUTER JOIN oocql_t t30 ON pmbaent = t30.oocqlent AND t30.oocql001 = 285 AND t30.oocql002 = pmba093 AND t30.oocql003 = '",g_dlang,"'",
                 "             LEFT OUTER JOIN oocql_t t31 ON pmbaent = t31.oocqlent AND t31.oocql001 = 281 AND t31.oocql002 = pmba090 AND t31.oocql003 = '",g_dlang,"'",
                 "             LEFT OUTER JOIN oocql_t t32 ON pmbaent = t32.oocqlent AND t32.oocql001 = 255 AND t32.oocql002 = pmba083 AND t32.oocql003 = '",g_dlang,"'",
                 "             LEFT OUTER JOIN oocql_t t33 ON pmbaent = t33.oocqlent AND t33.oocql001 = 251 AND t33.oocql002 = pmba080 AND t33.oocql003 = '",g_dlang,"'",
                 "             LEFT OUTER JOIN oocql_t t36 ON pmbaent = t36.oocqlent AND t36.oocql001 = 286 AND t36.oocql002 = pmba094 AND t36.oocql003 = '",g_dlang,"'",
                 "             LEFT OUTER JOIN oocql_t t37 ON pmbaent = t37.oocqlent AND t37.oocql001 = 283 AND t37.oocql002 = pmba091 AND t37.oocql003 = '",g_dlang,"'",
                 "             LEFT OUTER JOIN oocql_t t38 ON pmbaent = t38.oocqlent AND t38.oocql001 = 256 AND t38.oocql002 = pmba084 AND t38.oocql003 = '",g_dlang,"'",
                 "             LEFT OUTER JOIN oocql_t t39 ON pmbaent = t39.oocqlent AND t39.oocql001 = 253 AND t38.oocql002 = pmba081 AND t39.oocql003 = '",g_dlang,"'",
                 "             LEFT OUTER JOIN gzcbl_t t34 ON t34.gzcbl001 = 2015 AND t34.gzcbl002 = pmba004 AND t34.gzcbl003 = '",g_dlang,"'",
                 "             LEFT OUTER JOIN gzcbl_t t35 ON t35.gzcbl001 = 32 AND t35.gzcbl002 = pmba000 AND t35.gzcbl003 = '",g_dlang,"'", 
                 "             LEFT OUTER JOIN ooag_t ON pmbaent = ooagent AND ooag001 = pmba900",
                 "             LEFT OUTER JOIN ooefl_t ON pmbaent = ooeflent AND ooefl001 = pmba901 AND ooefl002 = '",g_dlang,"'",
                 "             LEFT OUTER JOIN pmbb_t ON pmbaent = pmbbent AND pmbadocno = pmbbdocno AND pmbbsite = 'ALL'",#,g_site,"'",
                 
                 "             LEFT OUTER JOIN gzcbl_t t1  ON t1.gzcbl001  = 2085 AND t1.gzcbl002 = pmbb107 AND t1.gzcbl003 = '",g_dlang,"'",
                 "             LEFT OUTER JOIN isacl_t t2  ON pmbbent = t2.isaclent  AND t2.isacl001  = '",l_ooef019_2,"' AND t2.isacl002 = pmbb106 AND t2.isacl003 = '",g_dlang,"'",
                 "             LEFT OUTER JOIN pmaml_t t3  ON pmbbent = t3.pmamlent  AND t3.pmaml001  = pmbb104 AND t3.pmaml002 = '",g_dlang,"'",
                 "             LEFT OUTER JOIN oocql_t t4  ON pmbbent = t4.oocqlent  AND t4.oocql001  = 238  AND t4.oocql002 = pmbb103 AND t4.oocql003 = '",g_dlang,"'",
                 "             LEFT OUTER JOIN oocql_t t5  ON pmbbent = t5.oocqlent  AND t5.oocql001  = 3111 AND t5.oocql002 = pmbb105 AND t5.oocql003 = '",g_dlang,"'",   
                 "             LEFT OUTER JOIN gzcbl_t t6  ON t6.gzcbl001  = 8322 AND t6.gzcbl002 = pmbb085 AND t6.gzcbl003 = '",g_dlang,"'",   
                 "             LEFT OUTER JOIN ooibl_t t7  ON pmbbent = t7.ooiblent  AND t7.ooibl002  = pmbb087 AND t7.ooibl003 = '",g_dlang,"'",
                 "             LEFT OUTER JOIN oodbl_t t8  ON pmbbent = t8.oodblent  AND t8.oodbl001  = '",l_ooef019,"' AND t8.oodbl002 = pmbb084 AND t8.oodbl003 = '",g_dlang,"'",
                 "             LEFT OUTER JOIN gzcbl_t t9  ON t9.gzcbl001  = 8334 AND t9.gzcbl002 = pmbb086 AND t9.gzcbl003 = '",g_dlang,"'",
                 "             LEFT OUTER JOIN oocql_t t10 ON pmbbent = t10.oocqlent AND t10.oocql001 = 295 AND t10.oocql002 = pmbb089 AND t10.oocql003 = '",g_dlang,"'",
                 #160621-00003#3 20160627 modify by beckxie---S
                 #"            LEFT OUTER JOIN oocql_t t11 ON pmbbent = t11.oocqlent AND t11.oocql001 = 275 AND t11.oocql002 = pmbb088 AND t11.oocql003 = '",g_dlang,"'",
                 "             LEFT JOIN oojdl_t t11 ON t11.oojdlent='"||g_enterprise||"' AND t11.oojdl001= pmbb088 AND t11.oojdl002='"||g_dlang||"' ",
                 #160621-00003#3 20160627 modify by beckxie---E
                 "             LEFT OUTER JOIN ooail_t t12 ON pmbbent = t12.ooailent AND t12.ooail001 = pmbb083 AND t12.ooail002 = '",g_dlang,"'",
                 "             LEFT OUTER JOIN gzcbl_t t13 ON t13.gzcbl001 = 2087 AND t13.gzcbl002 = pmbb057 AND t13.gzcbl003 = '",g_dlang,"'",
                 "             LEFT OUTER JOIN isacl_t t14 ON pmbbent = t14.isaclent AND t14.isacl001 = '",l_ooef019_2,"' AND t14.isacl002 = pmbb056 AND t14.isacl003 = '",g_dlang,"'",
                 "             LEFT OUTER JOIN pmaml_t t15 ON pmbbent = t15.pmamlent AND t15.pmaml001 = pmbb054 AND t15.pmaml002 = '",g_dlang,"'",
                 "             LEFT OUTER JOIN oocql_t t16 ON pmbbent = t16.oocqlent AND t16.oocql001 = 238  AND t16.oocql002 = pmbb053 AND t16.oocql003 = '",g_dlang,"'",
                 "             LEFT OUTER JOIN oocql_t t17 ON pmbbent = t17.oocqlent AND t17.oocql001 = 3211 AND t17.oocql002 = pmbb055 AND t17.oocql003 = '",g_dlang,"'",
                 "             LEFT OUTER JOIN gzcbl_t t18 ON t18.gzcbl001 = 8322 AND t18.gzcbl002 = pmbb035 AND t18.gzcbl003 = '",g_dlang,"'", 
                 "             LEFT OUTER JOIN ooibl_t t19 ON pmbbent = t19.ooiblent AND t19.ooibl002 = pmbb037 AND t19.ooibl003 = '",g_dlang,"'",
                 "             LEFT OUTER JOIN oodbl_t t20 ON pmbbent = t20.oodblent AND t20.oodbl001 = '",l_ooef019,"' AND t20.oodbl002 = pmbb034 AND t20.oodbl003 = '",g_dlang,"'",
                 "             LEFT OUTER JOIN gzcbl_t t21 ON t21.gzcbl001 = 9936 AND t21.gzcbl002 = pmbb036 AND t21.gzcbl003 = '",g_dlang,"'", 
                 "             LEFT OUTER JOIN oocql_t t22 ON pmbbent = t22.oocqlent AND t22.oocql001 = 264  AND t22.oocql002 = pmbb039 AND t22.oocql003 = '",g_dlang,"'",
                 #160621-00003#3 20160627 modify by beckxie---S
                 #"             LEFT OUTER JOIN oocql_t t23 ON pmbbent = t23.oocqlent AND t23.oocql001 = 275 AND t23.oocql002 = pmbb038 AND t23.oocql003 = '",g_dlang,"'",
                 "             LEFT OUTER JOIN oojdl_t t23 ON t23.oojdlent='"||g_enterprise||"' AND t23.oojdl001= pmbb038 AND t23.oojdl002='"||g_dlang||"' ",
                 #160621-00003#3 20160627 modify by beckxie---E
                 "             LEFT OUTER JOIN ooail_t t24 ON pmbbent = t24.ooailent AND t24.ooail001 = pmbb033 AND t24.ooail002 = '",g_dlang,"'"
#   #end add-point
#    LET g_from = " FROM pmba_t,pmbb_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
    #LET g_where = " WHERE pmbaent = pmbbent AND pmbadocno = pmbbdocno AND pmbbsite = '",g_site,"' AND ",tm.wc CLIPPED
    LET g_where = " WHERE ",tm.wc CLIPPED
    CASE tm.argv1
       WHEN '1'
          LET g_where = g_where," AND pmba002 IN ('1','3')"
       WHEN '2' 
          LET g_where = g_where," AND pmba002 IN ('2','3')"
    END CASE
    
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED 
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
    LET g_order = " ORDER BY pmbadocno"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("pmba_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE apmr101_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE apmr101_g01_curs CURSOR FOR apmr101_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="apmr101_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION apmr101_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   pmbaent LIKE pmba_t.pmbaent, 
   pmbb054 LIKE pmbb_t.pmbb054, 
   pmbb088 LIKE pmbb_t.pmbb088, 
   l_pmbb107_desc LIKE type_t.chr1000, 
   pmbb107 LIKE pmbb_t.pmbb107, 
   l_pmbb106_desc LIKE type_t.chr1000, 
   pmbb106 LIKE pmbb_t.pmbb106, 
   l_pmbb104_desc LIKE type_t.chr1000, 
   pmbb104 LIKE pmbb_t.pmbb104, 
   l_pmbb103_desc LIKE type_t.chr1000, 
   pmbb103 LIKE pmbb_t.pmbb103, 
   l_pmbb105_desc LIKE type_t.chr1000, 
   pmbb105 LIKE pmbb_t.pmbb105, 
   l_pmbb085_desc LIKE type_t.chr1000, 
   pmbb085 LIKE pmbb_t.pmbb085, 
   l_pmbb087_desc LIKE type_t.chr1000, 
   pmbb087 LIKE pmbb_t.pmbb087, 
   l_pmbb084_desc LIKE type_t.chr1000, 
   pmbb084 LIKE pmbb_t.pmbb084, 
   l_pmbb086_desc LIKE type_t.chr1000, 
   pmbb086 LIKE pmbb_t.pmbb086, 
   l_pmbb089_desc LIKE type_t.chr1000, 
   pmbb089 LIKE pmbb_t.pmbb089, 
   l_pmbb088_desc LIKE type_t.chr1000, 
   l_pmbb083_desc LIKE type_t.chr1000, 
   pmbb083 LIKE pmbb_t.pmbb083, 
   l_pmbb057_desc LIKE type_t.chr1000, 
   pmbb057 LIKE pmbb_t.pmbb057, 
   l_pmbb056_desc LIKE type_t.chr1000, 
   pmbb056 LIKE pmbb_t.pmbb056, 
   l_pmbb054_desc LIKE type_t.chr1000, 
   l_pmbb053_desc LIKE type_t.chr1000, 
   pmbb053 LIKE pmbb_t.pmbb053, 
   l_pmbb055_desc LIKE type_t.chr1000, 
   pmbb055 LIKE pmbb_t.pmbb055, 
   l_pmbb035_desc LIKE type_t.chr1000, 
   pmbb035 LIKE pmbb_t.pmbb035, 
   l_pmbb037_desc LIKE type_t.chr1000, 
   pmbb037 LIKE pmbb_t.pmbb037, 
   l_pmbb034_desc LIKE type_t.chr1000, 
   pmbb034 LIKE pmbb_t.pmbb034, 
   l_pmbb036_desc LIKE type_t.chr1000, 
   pmbb036 LIKE pmbb_t.pmbb036, 
   l_pmbb039_desc LIKE type_t.chr1000, 
   pmbb039 LIKE pmbb_t.pmbb039, 
   l_pmbb038_desc LIKE type_t.chr1000, 
   pmbb038 LIKE pmbb_t.pmbb038, 
   l_pmbb033_desc LIKE type_t.chr1000, 
   pmbb033 LIKE pmbb_t.pmbb033, 
   pmba056 LIKE pmba_t.pmba056, 
   l_pmba053_desc LIKE type_t.chr1000, 
   pmba053 LIKE pmba_t.pmba053, 
   pmba055 LIKE pmba_t.pmba055, 
   l_pmba052_desc LIKE type_t.chr1000, 
   pmba052 LIKE pmba_t.pmba052, 
   l_pmba054_desc LIKE type_t.chr1000, 
   pmba054 LIKE pmba_t.pmba054, 
   l_pmba051_desc LIKE type_t.chr1000, 
   pmba051 LIKE pmba_t.pmba051, 
   l_pmba094_desc LIKE type_t.chr1000, 
   pmba094 LIKE pmba_t.pmba094, 
   l_pmba091_desc LIKE type_t.chr1000, 
   pmba091 LIKE pmba_t.pmba091, 
   l_pmba084_desc LIKE type_t.chr1000, 
   pmba084 LIKE pmba_t.pmba084, 
   l_pmba081_desc LIKE type_t.chr1000, 
   pmba081 LIKE pmba_t.pmba081, 
   l_pmba005_desc LIKE type_t.chr1000, 
   pmba005 LIKE pmba_t.pmba005, 
   pmba003 LIKE pmba_t.pmba003, 
   l_pmaal004 LIKE type_t.chr1000, 
   l_pmaal006_desc LIKE type_t.chr1000, 
   l_pmaal003_desc LIKE type_t.chr1000, 
   pmba001 LIKE pmba_t.pmba001, 
   l_pmba093_desc LIKE type_t.chr1000, 
   pmba093 LIKE pmba_t.pmba093, 
   l_pmba090_desc LIKE type_t.chr1000, 
   pmba090 LIKE pmba_t.pmba090, 
   l_pmba083_desc LIKE type_t.chr1000, 
   pmba083 LIKE pmba_t.pmba083, 
   l_pmba080_desc LIKE type_t.chr1000, 
   pmba080 LIKE pmba_t.pmba080, 
   l_pmba004_desc LIKE type_t.chr1000, 
   pmba004 LIKE pmba_t.pmba004, 
   l_pmba000_desc LIKE type_t.chr1000, 
   pmba000 LIKE pmba_t.pmba000, 
   l_pmba901_desc LIKE type_t.chr1000, 
   pmba901 LIKE pmba_t.pmba901, 
   l_pmba900_desc LIKE type_t.chr1000, 
   pmba900 LIKE pmba_t.pmba900, 
   pmbadocdt LIKE pmba_t.pmbadocdt, 
   pmbadocno LIKE pmba_t.pmbadocno
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_n  LIKE type_t.num5
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH apmr101_g01_curs INTO sr_s.*
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
       
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       LET l_n = 0
       
       SELECT COUNT(*) INTO l_n FROM pmbal_t WHERE pmbalent = g_enterprise AND pmbaldocno = sr_s.pmbadocno
       IF l_n > 0 THEN
          INITIALIZE g_ref_fields TO NULL
          LET g_ref_fields[1] = sr_s.pmbadocno
          CALL ap_ref_array2(g_ref_fields,"SELECT pmbal003 FROM pmbal_t WHERE pmbalent='"||g_enterprise||"' AND pmbaldocno=? AND pmbal001='"||g_dlang||"'","") RETURNING g_rtn_fields
          IF NOT cl_null(sr_s.pmba001) THEN
             IF NOT cl_null(g_rtn_fields[1]) THEN
                LET sr_s.l_pmba005_desc = sr_s.pmba001,".", g_rtn_fields[1] , ''
             ELSE
                LET sr_s.l_pmba005_desc = sr_s.pmba001
             END IF
          END IF
       ELSE
          INITIALIZE g_ref_fields TO NULL
          LET g_ref_fields[1] = sr_s.pmba005
          CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
          IF NOT cl_null(sr_s.pmba005) THEN
             IF NOT cl_null(g_rtn_fields[1]) THEN
                LET sr_s.l_pmba005_desc = sr_s.pmba005,".", g_rtn_fields[1] , ''
             ELSE
                LET sr_s.l_pmba005_desc = sr_s.pmba005
             END IF
          END IF
       END IF
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].pmbaent = sr_s.pmbaent
       LET sr[l_cnt].pmbb054 = sr_s.pmbb054
       LET sr[l_cnt].pmbb088 = sr_s.pmbb088
       LET sr[l_cnt].l_pmbb107_desc = sr_s.l_pmbb107_desc
       LET sr[l_cnt].pmbb107 = sr_s.pmbb107
       LET sr[l_cnt].l_pmbb106_desc = sr_s.l_pmbb106_desc
       LET sr[l_cnt].pmbb106 = sr_s.pmbb106
       LET sr[l_cnt].l_pmbb104_desc = sr_s.l_pmbb104_desc
       LET sr[l_cnt].pmbb104 = sr_s.pmbb104
       LET sr[l_cnt].l_pmbb103_desc = sr_s.l_pmbb103_desc
       LET sr[l_cnt].pmbb103 = sr_s.pmbb103
       LET sr[l_cnt].l_pmbb105_desc = sr_s.l_pmbb105_desc
       LET sr[l_cnt].pmbb105 = sr_s.pmbb105
       LET sr[l_cnt].l_pmbb085_desc = sr_s.l_pmbb085_desc
       LET sr[l_cnt].pmbb085 = sr_s.pmbb085
       LET sr[l_cnt].l_pmbb087_desc = sr_s.l_pmbb087_desc
       LET sr[l_cnt].pmbb087 = sr_s.pmbb087
       LET sr[l_cnt].l_pmbb084_desc = sr_s.l_pmbb084_desc
       LET sr[l_cnt].pmbb084 = sr_s.pmbb084
       LET sr[l_cnt].l_pmbb086_desc = sr_s.l_pmbb086_desc
       LET sr[l_cnt].pmbb086 = sr_s.pmbb086
       LET sr[l_cnt].l_pmbb089_desc = sr_s.l_pmbb089_desc
       LET sr[l_cnt].pmbb089 = sr_s.pmbb089
       LET sr[l_cnt].l_pmbb088_desc = sr_s.l_pmbb088_desc
       LET sr[l_cnt].l_pmbb083_desc = sr_s.l_pmbb083_desc
       LET sr[l_cnt].pmbb083 = sr_s.pmbb083
       LET sr[l_cnt].l_pmbb057_desc = sr_s.l_pmbb057_desc
       LET sr[l_cnt].pmbb057 = sr_s.pmbb057
       LET sr[l_cnt].l_pmbb056_desc = sr_s.l_pmbb056_desc
       LET sr[l_cnt].pmbb056 = sr_s.pmbb056
       LET sr[l_cnt].l_pmbb054_desc = sr_s.l_pmbb054_desc
       LET sr[l_cnt].l_pmbb053_desc = sr_s.l_pmbb053_desc
       LET sr[l_cnt].pmbb053 = sr_s.pmbb053
       LET sr[l_cnt].l_pmbb055_desc = sr_s.l_pmbb055_desc
       LET sr[l_cnt].pmbb055 = sr_s.pmbb055
       LET sr[l_cnt].l_pmbb035_desc = sr_s.l_pmbb035_desc
       LET sr[l_cnt].pmbb035 = sr_s.pmbb035
       LET sr[l_cnt].l_pmbb037_desc = sr_s.l_pmbb037_desc
       LET sr[l_cnt].pmbb037 = sr_s.pmbb037
       LET sr[l_cnt].l_pmbb034_desc = sr_s.l_pmbb034_desc
       LET sr[l_cnt].pmbb034 = sr_s.pmbb034
       LET sr[l_cnt].l_pmbb036_desc = sr_s.l_pmbb036_desc
       LET sr[l_cnt].pmbb036 = sr_s.pmbb036
       LET sr[l_cnt].l_pmbb039_desc = sr_s.l_pmbb039_desc
       LET sr[l_cnt].pmbb039 = sr_s.pmbb039
       LET sr[l_cnt].l_pmbb038_desc = sr_s.l_pmbb038_desc
       LET sr[l_cnt].pmbb038 = sr_s.pmbb038
       LET sr[l_cnt].l_pmbb033_desc = sr_s.l_pmbb033_desc
       LET sr[l_cnt].pmbb033 = sr_s.pmbb033
       LET sr[l_cnt].pmba056 = sr_s.pmba056
       LET sr[l_cnt].l_pmba053_desc = sr_s.l_pmba053_desc
       LET sr[l_cnt].pmba053 = sr_s.pmba053
       LET sr[l_cnt].pmba055 = sr_s.pmba055
       LET sr[l_cnt].l_pmba052_desc = sr_s.l_pmba052_desc
       LET sr[l_cnt].pmba052 = sr_s.pmba052
       LET sr[l_cnt].l_pmba054_desc = sr_s.l_pmba054_desc
       LET sr[l_cnt].pmba054 = sr_s.pmba054
       LET sr[l_cnt].l_pmba051_desc = sr_s.l_pmba051_desc
       LET sr[l_cnt].pmba051 = sr_s.pmba051
       LET sr[l_cnt].l_pmba094_desc = sr_s.l_pmba094_desc
       LET sr[l_cnt].pmba094 = sr_s.pmba094
       LET sr[l_cnt].l_pmba091_desc = sr_s.l_pmba091_desc
       LET sr[l_cnt].pmba091 = sr_s.pmba091
       LET sr[l_cnt].l_pmba084_desc = sr_s.l_pmba084_desc
       LET sr[l_cnt].pmba084 = sr_s.pmba084
       LET sr[l_cnt].l_pmba081_desc = sr_s.l_pmba081_desc
       LET sr[l_cnt].pmba081 = sr_s.pmba081
       LET sr[l_cnt].l_pmba005_desc = sr_s.l_pmba005_desc
       LET sr[l_cnt].pmba005 = sr_s.pmba005
       LET sr[l_cnt].pmba003 = sr_s.pmba003
       LET sr[l_cnt].l_pmaal004 = sr_s.l_pmaal004
       LET sr[l_cnt].l_pmaal006_desc = sr_s.l_pmaal006_desc
       LET sr[l_cnt].l_pmaal003_desc = sr_s.l_pmaal003_desc
       LET sr[l_cnt].pmba001 = sr_s.pmba001
       LET sr[l_cnt].l_pmba093_desc = sr_s.l_pmba093_desc
       LET sr[l_cnt].pmba093 = sr_s.pmba093
       LET sr[l_cnt].l_pmba090_desc = sr_s.l_pmba090_desc
       LET sr[l_cnt].pmba090 = sr_s.pmba090
       LET sr[l_cnt].l_pmba083_desc = sr_s.l_pmba083_desc
       LET sr[l_cnt].pmba083 = sr_s.pmba083
       LET sr[l_cnt].l_pmba080_desc = sr_s.l_pmba080_desc
       LET sr[l_cnt].pmba080 = sr_s.pmba080
       LET sr[l_cnt].l_pmba004_desc = sr_s.l_pmba004_desc
       LET sr[l_cnt].pmba004 = sr_s.pmba004
       LET sr[l_cnt].l_pmba000_desc = sr_s.l_pmba000_desc
       LET sr[l_cnt].pmba000 = sr_s.pmba000
       LET sr[l_cnt].l_pmba901_desc = sr_s.l_pmba901_desc
       LET sr[l_cnt].pmba901 = sr_s.pmba901
       LET sr[l_cnt].l_pmba900_desc = sr_s.l_pmba900_desc
       LET sr[l_cnt].pmba900 = sr_s.pmba900
       LET sr[l_cnt].pmbadocdt = sr_s.pmbadocdt
       LET sr[l_cnt].pmbadocno = sr_s.pmbadocno
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       IF sr[l_cnt].l_pmba052_desc = "." THEN
          INITIALIZE sr[l_cnt].l_pmba052_desc TO NULL
       END IF
       
       IF sr[l_cnt].l_pmba053_desc = "." THEN
          INITIALIZE sr[l_cnt].l_pmba053_desc TO NULL
       END IF
       
       IF sr[l_cnt].l_pmba054_desc = "." THEN
          INITIALIZE sr[l_cnt].l_pmba054_desc TO NULL
       END IF
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apmr101_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION apmr101_g01_rep_data()
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
          START REPORT apmr101_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT apmr101_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT apmr101_g01_rep
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
 
{<section id="apmr101_g01.rep" readonly="Y" >}
PRIVATE REPORT apmr101_g01_rep(sr1)
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
DEFINE sr5 sr5_r
DEFINE sr6 sr6_r
DEFINE sr7 sr7_r
DEFINE sr8 sr8_r
DEFINE l_subrep05_show  LIKE type_t.chr1,
       l_subrep06_show  LIKE type_t.chr1,
       l_subrep07_show  LIKE type_t.chr1,
       l_subrep08_show  LIKE type_t.chr1,
       l_subrep09_show  LIKE type_t.chr1,
       l_subrep10_show  LIKE type_t.chr1
DEFINE l_pmba001_show LIKE type_t.chr1
DEFINE l_pmba027  LIKE pmba_t.pmba027
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER  BY sr1.pmbadocno
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
        BEFORE GROUP OF sr1.pmbadocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.pmbadocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'pmbaent=' ,sr1.pmbaent,'{+}pmbadocno=' ,sr1.pmbadocno         
            CALL cl_gr_init_apr(sr1.pmbadocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.pmbadocno.before name="rep.b_group.pmbadocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.pmbaent CLIPPED ,"'", " AND  ooff003 = '", sr1.pmbadocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE apmr101_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE apmr101_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT apmr101_g01_subrep01
           DECLARE apmr101_g01_repcur01 CURSOR FROM g_sql
           FOREACH apmr101_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "apmr101_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT apmr101_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT apmr101_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.pmbadocno.after name="rep.b_group.pmbadocno.after"
 
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
                sr1.pmbaent CLIPPED ,"'", " AND  ooff003 = '", sr1.pmbadocno CLIPPED ,"'"
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE apmr101_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE apmr101_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT apmr101_g01_subrep02
           DECLARE apmr101_g01_repcur02 CURSOR FROM g_sql
           FOREACH apmr101_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "apmr101_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT apmr101_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT apmr101_g01_subrep02
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
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooff003 = '", 
                sr1.pmbaent CLIPPED ,"'"
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE apmr101_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE apmr101_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT apmr101_g01_subrep03
           DECLARE apmr101_g01_repcur03 CURSOR FROM g_sql
           FOREACH apmr101_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "apmr101_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT apmr101_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT apmr101_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.pmbadocno
 
           #add-point:rep.a_group.pmbadocno.before name="rep.a_group.pmbadocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.pmbaent CLIPPED ,"'", " AND  ooff003 = '", sr1.pmbadocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE apmr101_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE apmr101_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT apmr101_g01_subrep04
           DECLARE apmr101_g01_repcur04 CURSOR FROM g_sql
           FOREACH apmr101_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "apmr101_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT apmr101_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT apmr101_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.pmbadocno.after name="rep.a_group.pmbadocno.after"
           LET g_sql = " SELECT gzcbl004,pmbc002,pmaal004,pmbc004", 
                       "   FROM pmbc_t LEFT OUTER JOIN pmaal_t ON pmaalent = pmbcent AND pmaal001 = pmbc002 AND pmaal002 = '",g_dlang,"'",
                       "               LEFT OUTER JOIN gzcbl_t ON gzcbl001 = '2013' AND gzcbl002 = pmbc003 AND gzcbl003 = '",g_dlang,"'",
                       "  WHERE pmbcent = ",sr1.pmbaent CLIPPED," AND pmbcdocno = '",sr1.pmbadocno CLIPPED,"' ORDER BY pmbc003"     
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep05_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE apmr101_g01_repcur05_cnt_pre FROM l_sub_sql
           EXECUTE apmr101_g01_repcur05_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep05_show ="Y"
           END IF
           PRINTX l_subrep05_show
           START REPORT apmr101_g01_subrep05
           DECLARE apmr101_g01_repcur05 CURSOR FROM g_sql
           FOREACH apmr101_g01_repcur05 INTO sr3.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "apmr101_g01_repcur05:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach

              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT apmr101_g01_subrep05(sr3.*)
           END FOREACH
           FINISH REPORT apmr101_g01_subrep05
           
           SELECT pmba027 INTO l_pmba027 FROM pmba_t 
            WHERE pmbaent = g_enterprise AND pmbadocno = sr1.pmbadocno
           LET g_sql = " SELECT oofb019,oofb011,gzcbl004,oofb010,''", 
                       "   FROM oofb_t LEFT OUTER JOIN gzcbl_t ON gzcbl001 = 9 AND gzcbl002 = oofb008 AND gzcbl003 = '",g_dlang,"'",
                       "  WHERE oofbent = ",sr1.pmbaent CLIPPED," AND oofb002 = '",l_pmba027 CLIPPED,"'"     
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep09_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE apmr101_g01_repcur09_cnt_pre FROM l_sub_sql
           EXECUTE apmr101_g01_repcur09_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep09_show ="Y"
           END IF
           PRINTX l_subrep09_show
           START REPORT apmr101_g01_subrep09
           DECLARE apmr101_g01_repcur09 CURSOR FROM g_sql
           FOREACH apmr101_g01_repcur09 INTO sr7.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "apmr101_g01_repcur09:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach
              CALL s_aooi350_get_address(l_pmba027,sr7.oofb019,g_dlang) RETURNING g_success,sr7.oofb017
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT apmr101_g01_subrep09(sr7.*)
           END FOREACH
           FINISH REPORT apmr101_g01_subrep09
           
           SELECT pmba027 INTO l_pmba027 FROM pmba_t 
            WHERE pmbaent = g_enterprise AND pmbadocno = sr1.pmbadocno
           LET g_sql = " SELECT gzcbl004,trim(oofc009)||'.'||trim(oocql004),oofc012,oofc010,oofc014,oofc011", 
                       "   FROM oofc_t LEFT OUTER JOIN gzcbl_t ON gzcbl001 = 6 AND gzcbl002 = oofc008 AND gzcbl003 = '",g_dlang,"'",
                       "               LEFT OUTER JOIN oocql_t ON oocqlent = oofcent AND oocql001 = 3 AND oocql002 = oofc009 AND oocql003 = '",g_dlang,"'",
                       "  WHERE oofcent = ",sr1.pmbaent CLIPPED," AND oofc002 = '",l_pmba027 CLIPPED,"'"     
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep10_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE apmr101_g01_repcur10_cnt_pre FROM l_sub_sql
           EXECUTE apmr101_g01_repcur10_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep10_show ="Y"
           END IF
           PRINTX l_subrep10_show
           START REPORT apmr101_g01_subrep10
           DECLARE apmr101_g01_repcur10 CURSOR FROM g_sql
           FOREACH apmr101_g01_repcur10 INTO sr8.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "apmr101_g01_repcur10:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT apmr101_g01_subrep10(sr8.*)
           END FOREACH
           FINISH REPORT apmr101_g01_subrep10
           
           LET g_sql = " SELECT nmabl003,pmbf003,pmbf004,pmbf005,pmbf007,pmbf009", 
                       "   FROM pmbf_t LEFT OUTER JOIN nmabl_t ON nmablent = pmbfent AND nmabl001 = pmbf002 AND nmabl002 = '",g_dlang,"'",
                       "  WHERE pmbfent = ",sr1.pmbaent CLIPPED," AND pmbfdocno = '",sr1.pmbadocno CLIPPED,"'"     
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep06_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE apmr101_g01_repcur06_cnt_pre FROM l_sub_sql
           EXECUTE apmr101_g01_repcur06_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep06_show ="Y"
           END IF
           PRINTX l_subrep06_show
           START REPORT apmr101_g01_subrep06
           DECLARE apmr101_g01_repcur06 CURSOR FROM g_sql
           FOREACH apmr101_g01_repcur06 INTO sr4.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "apmr101_g01_repcur06:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach

              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT apmr101_g01_subrep06(sr4.*)
           END FOREACH
           FINISH REPORT apmr101_g01_subrep06
           
           
           LET g_sql = " SELECT pmbd002,ooibl004,pmbd004", 
                       "   FROM pmbd_t LEFT OUTER JOIN ooibl_t ON ooiblent = pmbdent AND ooibl002 = pmbd002 AND ooibl003 = '",g_dlang,"'",
                       "  WHERE pmbdent = ",sr1.pmbaent CLIPPED," AND pmbddocno = '",sr1.pmbadocno CLIPPED,"' AND pmbd003 = '1'"     
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep07_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE apmr101_g01_repcur07_cnt_pre FROM l_sub_sql
           EXECUTE apmr101_g01_repcur07_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep07_show ="Y"
           END IF
           PRINTX l_subrep07_show
           START REPORT apmr101_g01_subrep07
           DECLARE apmr101_g01_repcur07 CURSOR FROM g_sql
           FOREACH apmr101_g01_repcur07 INTO sr5.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "apmr101_g01_repcur07:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach

              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT apmr101_g01_subrep07(sr5.*)
           END FOREACH
           FINISH REPORT apmr101_g01_subrep07
           
           LET g_sql = " SELECT pmbd002,ooibl004,pmbd004", 
                       "   FROM pmbd_t LEFT OUTER JOIN ooibl_t ON ooiblent = pmbdent AND ooibl002 = pmbd002 AND ooibl003 = '",g_dlang,"'",
                       "  WHERE pmbdent = ",sr1.pmbaent CLIPPED," AND pmbddocno = '",sr1.pmbadocno CLIPPED,"' AND pmbd003 = '2'"     
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep08_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE apmr101_g01_repcur08_cnt_pre FROM l_sub_sql
           EXECUTE apmr101_g01_repcur08_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep08_show ="Y"
           END IF
           PRINTX l_subrep08_show
           START REPORT apmr101_g01_subrep08
           DECLARE apmr101_g01_repcur08 CURSOR FROM g_sql
           FOREACH apmr101_g01_repcur08 INTO sr6.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "apmr101_g01_repcur08:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach

              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT apmr101_g01_subrep08(sr6.*)
           END FOREACH
           FINISH REPORT apmr101_g01_subrep08
           
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="apmr101_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT apmr101_g01_subrep01(sr2)
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
PRIVATE REPORT apmr101_g01_subrep02(sr2)
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
PRIVATE REPORT apmr101_g01_subrep03(sr2)
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
PRIVATE REPORT apmr101_g01_subrep04(sr2)
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
 
{<section id="apmr101_g01.other_function" readonly="Y" >}

 
{</section>}
 
{<section id="apmr101_g01.other_report" readonly="Y" >}

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
PRIVATE REPORT apmr101_g01_subrep05(sr3)
DEFINE  sr3  sr3_r    
DEFINE l_block_width  LIKE type_t.num5
    FORMAT
           
        ON EVERY ROW
            LET l_block_width = 2
            PRINTX g_grNumFmt.*
            PRINTX sr3.*
            PRINTX l_block_width
END REPORT

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
PRIVATE REPORT apmr101_g01_subrep06(sr4)
DEFINE  sr4  sr4_r        
    FORMAT
           
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr4.*
END REPORT

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
PRIVATE REPORT apmr101_g01_subrep07(sr5)
DEFINE  sr5  sr5_r    
DEFINE l_block_width  LIKE type_t.num5
    FORMAT
           
        ON EVERY ROW
            LET l_block_width = 2
            PRINTX g_grNumFmt.*
            PRINTX sr5.*
            PRINTX l_block_width
END REPORT

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
PRIVATE REPORT apmr101_g01_subrep08(sr6)
DEFINE  sr6  sr6_r      
DEFINE l_block_width  LIKE type_t.num5
    FORMAT
           
        ON EVERY ROW
            LET l_block_width = 2
            PRINTX g_grNumFmt.*
            PRINTX sr6.*
            PRINTX l_block_width
END REPORT
#子报表9
PRIVATE REPORT apmr101_g01_subrep09(sr7)
DEFINE  sr7  sr7_r       
    FORMAT
           
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr7.*
END REPORT
#子报表10
PRIVATE REPORT apmr101_g01_subrep10(sr8)
DEFINE  sr8  sr8_r      
    FORMAT
           
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr8.*
END REPORT

 
{</section>}
 
