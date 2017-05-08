#該程式未解開Section, 採用最新樣板產出!
{<section id="asfr300_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:10(2017-02-20 10:42:48), PR版次:0010(2017-02-21 15:49:59)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000300
#+ Filename...: asfr300_g01
#+ Description: ...
#+ Creator....: 05384(2014-05-22 16:08:56)
#+ Modifier...: 08992 -SD/PR- 08992
 
{</section>}
 
{<section id="asfr300_g01.global" readonly="Y" >}
#報表 g01 樣板自動產生(Version:13)
#add-point:填寫註解說明 name="global.memo"
#160727-00025#7   2016/08/22   By zhujing       模具生產功能開發
#161024-00057#4   2016/10/31   By shiun         刪除sfae_t相關程式
#161031-00025#17  2017/02/19   By 08992         修改列印備註SQL條件
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
   sfaa005 LIKE sfaa_t.sfaa005, 
   sfaa015 LIKE sfaa_t.sfaa015, 
   sfaa029 LIKE sfaa_t.sfaa029, 
   sfaa036 LIKE sfaa_t.sfaa036, 
   sfaa043 LIKE sfaa_t.sfaa043, 
   sfaa048 LIKE sfaa_t.sfaa048, 
   sfba006 LIKE sfba_t.sfba006, 
   sfba012 LIKE sfba_t.sfba012, 
   sfba014 LIKE sfba_t.sfba014, 
   sfba021 LIKE sfba_t.sfba021, 
   sfba023 LIKE sfba_t.sfba023, 
   sfba025 LIKE sfba_t.sfba025, 
   sfba027 LIKE sfba_t.sfba027, 
   sfaa012 LIKE sfaa_t.sfaa012, 
   sfaa013 LIKE sfaa_t.sfaa013, 
   sfaa016 LIKE sfaa_t.sfaa016, 
   sfaa030 LIKE sfaa_t.sfaa030, 
   sfaa034 LIKE sfaa_t.sfaa034, 
   sfaa042 LIKE sfaa_t.sfaa042, 
   sfaa045 LIKE sfaa_t.sfaa045, 
   sfaa049 LIKE sfaa_t.sfaa049, 
   sfaa058 LIKE sfaa_t.sfaa058, 
   sfaa060 LIKE sfaa_t.sfaa060, 
   sfba018 LIKE sfba_t.sfba018, 
   sfaa003 LIKE sfaa_t.sfaa003, 
   sfaa007 LIKE sfaa_t.sfaa007, 
   sfaa014 LIKE sfaa_t.sfaa014, 
   sfaa025 LIKE sfaa_t.sfaa025, 
   sfaa026 LIKE sfaa_t.sfaa026, 
   sfaa046 LIKE sfaa_t.sfaa046, 
   sfaa050 LIKE sfaa_t.sfaa050, 
   sfba015 LIKE sfba_t.sfba015, 
   sfba017 LIKE sfba_t.sfba017, 
   sfaa004 LIKE sfaa_t.sfaa004, 
   sfaa006 LIKE sfaa_t.sfaa006, 
   sfaa009 LIKE sfaa_t.sfaa009, 
   sfaa020 LIKE sfaa_t.sfaa020, 
   sfaa022 LIKE sfaa_t.sfaa022, 
   sfaa037 LIKE sfaa_t.sfaa037, 
   sfaa039 LIKE sfaa_t.sfaa039, 
   sfaa040 LIKE sfaa_t.sfaa040, 
   sfaa055 LIKE sfaa_t.sfaa055, 
   sfaastus LIKE sfaa_t.sfaastus, 
   sfba004 LIKE sfba_t.sfba004, 
   sfba009 LIKE sfba_t.sfba009, 
   sfba022 LIKE sfba_t.sfba022, 
   sfbaseq1 LIKE sfba_t.sfbaseq1, 
   sfaa001 LIKE sfaa_t.sfaa001, 
   sfaa057 LIKE sfaa_t.sfaa057, 
   sfaadocdt LIKE sfaa_t.sfaadocdt, 
   sfaadocno LIKE sfaa_t.sfaadocno, 
   sfaa008 LIKE sfaa_t.sfaa008, 
   sfaa011 LIKE sfaa_t.sfaa011, 
   sfaa017 LIKE sfaa_t.sfaa017, 
   sfaa018 LIKE sfaa_t.sfaa018, 
   sfaa024 LIKE sfaa_t.sfaa024, 
   sfaa031 LIKE sfaa_t.sfaa031, 
   sfaa047 LIKE sfaa_t.sfaa047, 
   sfaa051 LIKE sfaa_t.sfaa051, 
   sfaa059 LIKE sfaa_t.sfaa059, 
   sfaa061 LIKE sfaa_t.sfaa061, 
   sfaa062 LIKE sfaa_t.sfaa062, 
   sfba001 LIKE sfba_t.sfba001, 
   sfba008 LIKE sfba_t.sfba008, 
   sfba024 LIKE sfba_t.sfba024, 
   sfaa019 LIKE sfaa_t.sfaa019, 
   sfaa038 LIKE sfaa_t.sfaa038, 
   sfaa041 LIKE sfaa_t.sfaa041, 
   sfaa056 LIKE sfaa_t.sfaa056, 
   sfba011 LIKE sfba_t.sfba011, 
   sfaa010 LIKE sfaa_t.sfaa010, 
   sfaa021 LIKE sfaa_t.sfaa021, 
   sfaa028 LIKE sfaa_t.sfaa028, 
   sfaa032 LIKE sfaa_t.sfaa032, 
   sfaa035 LIKE sfaa_t.sfaa035, 
   sfaa064 LIKE sfaa_t.sfaa064, 
   sfba003 LIKE sfba_t.sfba003, 
   sfba005 LIKE sfba_t.sfba005, 
   sfba007 LIKE sfba_t.sfba007, 
   sfba010 LIKE sfba_t.sfba010, 
   sfbaseq LIKE sfba_t.sfbaseq, 
   sfaa002 LIKE sfaa_t.sfaa002, 
   sfaa023 LIKE sfaa_t.sfaa023, 
   sfaa033 LIKE sfaa_t.sfaa033, 
   sfaa044 LIKE sfaa_t.sfaa044, 
   sfaa063 LIKE sfaa_t.sfaa063, 
   sfba002 LIKE sfba_t.sfba002, 
   sfba013 LIKE sfba_t.sfba013, 
   sfba016 LIKE sfba_t.sfba016, 
   sfba019 LIKE sfba_t.sfba019, 
   sfba020 LIKE sfba_t.sfba020, 
   sfba026 LIKE sfba_t.sfba026, 
   sfba028 LIKE sfba_t.sfba028, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   pmaal_t_pmaal004 LIKE pmaal_t.pmaal004, 
   ecba_t_ecba003 LIKE ecba_t.ecba003, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   imaal_t_imaal003 LIKE imaal_t.imaal003, 
   oocal_t_oocal003 LIKE oocal_t.oocal003, 
   t1_oocal003 LIKE oocal_t.oocal003, 
   t2_ooefl003 LIKE ooefl_t.ooefl003, 
   pjbal_t_pjbal003 LIKE pjbal_t.pjbal003, 
   pjbbl_t_pjbbl004 LIKE pjbbl_t.pjbbl004, 
   oocql_t_oocql004 LIKE oocql_t.oocql004, 
   x_t4_imaal003 LIKE imaal_t.imaal003, 
   x_t5_imaal003 LIKE imaal_t.imaal003, 
   x_t3_oocql004 LIKE oocql_t.oocql004, 
   x_t8_oocql004 LIKE oocql_t.oocql004, 
   x_t7_oocal003 LIKE oocal_t.oocal003, 
   x_t9_imaal003 LIKE imaal_t.imaal003, 
   l_sfaa028_pjbal003 LIKE type_t.chr1000, 
   l_sfaa018_ooefl003 LIKE type_t.chr1000, 
   l_sfaa009_pmaal004 LIKE type_t.chr100, 
   l_sfaa017_ooefl003 LIKE type_t.chr1000, 
   l_sfaa029_pjbbl004 LIKE type_t.chr1000, 
   l_sfaa002_ooag011 LIKE type_t.chr300, 
   sfbadocno LIKE sfba_t.sfbadocno, 
   sfbaent LIKE sfba_t.sfbaent, 
   sfbasite LIKE sfba_t.sfbasite, 
   sfaaent LIKE sfaa_t.sfaaent, 
   sfaasite LIKE sfaa_t.sfaasite, 
   l_sfaa006_label LIKE type_t.chr1000, 
   l_sfaa017_label LIKE type_t.chr1000, 
   l_sfac006 LIKE sfac_t.sfac006, 
   l_count LIKE type_t.num5, 
   l_sfac006_show LIKE type_t.chr1, 
   l_sfac001 LIKE sfac_t.sfac001, 
   l_sfba021_show LIKE type_t.chr1, 
   l_sfba008_desc LIKE gzcbl_t.gzcbl004, 
   l_imaal003_imaal004 LIKE type_t.chr1000, 
   l_imaal003_imaal004_b LIKE type_t.chr1000, 
   imaal_t_imaal004 LIKE imaal_t.imaal004, 
   x_t4_imaal004 LIKE imaal_t.imaal004, 
   x_t5_imaal004 LIKE imaal_t.imaal004, 
   x_t9_imaal004 LIKE imaal_t.imaal004, 
   l_ooff013_show LIKE type_t.chr1, 
   l_sfac006_desc LIKE type_t.chr1000, 
   l_sfba021_desc LIKE type_t.chr1000
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING,                  #where condition 
       a1 LIKE type_t.chr1,         #工單備註 
       a2 LIKE type_t.chr1          #聯產品/多產
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
TYPE sr3_r RECORD  #子報表01
   sfabdocno LIKE sfab_t.sfabdocno, #單號
   sfab001 LIKE sfab_t.sfab001,  #來源
   sfab006 LIKE sfab_t.sfab006,  #優先序
   sfab002 LIKE sfab_t.sfab002,  #來源單號
   sfab003 LIKE sfab_t.sfab003,  #項次
   sfab004 LIKE sfab_t.sfab004,  #項序
   sfab007 LIKE sfab_t.sfab007,  #數量
   l_sfab002_sfab003_sfab004 LIKE type_t.chr100,  #單號/項次/項序
   l_sfab001_desc LIKE gzcbl_t.gzcbl004,  #來源說明
   l_xmda004 LIKE xmda_t.xmda004, #客戶(編號)
   l_count LIKE type_t.num5      #計數
END RECORD
TYPE sr4_r RECORD  #子報表02
   sfacdocno LIKE sfac_t.sfacdocno, #單號
   sfac002 LIKE sfac_t.sfac002,  #產出類型
   sfac001 LIKE sfac_t.sfac001,  #料號
   sfac003 LIKE sfac_t.sfac003,  #預計產出量
   sfac004 LIKE sfac_t.sfac004,  #產出單位
   l_sfac002_desc LIKE gzcbl_t.gzcbl004,  #產出類型(說明)
   l_imaal003 LIKE imaal_t.imaal003,  #品名
   l_imaal004 LIKE imaal_t.imaal004,  #規格
   l_imaal003_imaal004 LIKE type_t.chr100,  #品名/規格
   l_count LIKE type_t.num5      #計數
END RECORD
TYPE sr5_r RECORD  #子報表03
   sfacdocno LIKE sfac_t.sfacdocno, #單號
   sfac001 LIKE sfac_t.sfac001,  #料號
   sfac003 LIKE sfac_t.sfac003,  #數量
   sfac006 LIKE sfac_t.sfac006,  #特徵
   sfacseq LIKE sfac_t.sfacseq,  #項次 
   l_count LIKE type_t.num5,     #計數
   l_sfac006_desc LIKE type_t.chr1000 #特徵說明
END RECORD
#mark--161024-00057#4 By shiun--(S)
#TYPE sr6_r RECORD  #子報表04
#   sfaedocno LIKE sfae_t.sfaedocno, #單號
#   sfae002 LIKE sfae_t.sfae002,  #預計完工日
#   sfae001 LIKE sfae_t.sfae001,  #數量
#   sfaeseq LIKE sfae_t.sfaeseq,  #項次
#   l_count LIKE type_t.num5      #計數
#END RECORD
#mark--161024-00057#4 By shiun--(E)
#160727-00025#7 add-S
TYPE sr7_r RECORD  #子报表05 模具
   sfaidocno   LIKE sfai_t.sfaidocno,
   sfai001     LIKE sfai_t.sfai001,
   l_sfai001   LIKE imaal_t.imaal003,
   l_sfai001_1 LIKE imaal_t.imaal004,
   sfai002     LIKE sfai_t.sfai002,
   sfai004     LIKE sfai_t.sfai004,
   sfai003     LIKE sfai_t.sfai003,
   sfai005     LIKE sfai_t.sfai005
END RECORD
#160727-00025#7 add-E
#end add-point
 
{</section>}
 
{<section id="asfr300_g01.main" readonly="Y" >}
PUBLIC FUNCTION asfr300_g01(p_arg1,p_arg2,p_arg3)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr1         #tm.a1  工單備註 
DEFINE  p_arg3 LIKE type_t.chr1         #tm.a2  聯產品/多產
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.a1 = p_arg2
   LET tm.a2 = p_arg3
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "asfr300_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL asfr300_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL asfr300_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL asfr300_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="asfr300_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION asfr300_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   
   #end add-point
   LET g_select = " SELECT sfaa005,sfaa015,sfaa029,sfaa036,sfaa043,sfaa048,sfba006,sfba012,sfba014,sfba021, 
       sfba023,sfba025,sfba027,sfaa012,sfaa013,sfaa016,sfaa030,sfaa034,sfaa042,sfaa045,sfaa049,sfaa058, 
       sfaa060,sfba018,sfaa003,sfaa007,sfaa014,sfaa025,sfaa026,sfaa046,sfaa050,sfba015,sfba017,sfaa004, 
       sfaa006,sfaa009,sfaa020,sfaa022,sfaa037,sfaa039,sfaa040,sfaa055,sfaastus,sfba004,sfba009,sfba022, 
       sfbaseq1,sfaa001,sfaa057,sfaadocdt,sfaadocno,sfaa008,sfaa011,sfaa017,sfaa018,sfaa024,sfaa031, 
       sfaa047,sfaa051,sfaa059,sfaa061,sfaa062,sfba001,sfba008,sfba024,sfaa019,sfaa038,sfaa041,sfaa056, 
       sfba011,sfaa010,sfaa021,sfaa028,sfaa032,sfaa035,sfaa064,sfba003,sfba005,sfba007,sfba010,sfbaseq, 
       sfaa002,sfaa023,sfaa033,sfaa044,sfaa063,sfba002,sfba013,sfba016,sfba019,sfba020,sfba026,sfba028, 
       ( SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = sfaa_t.sfaa002 AND ooag_t.ooagent = sfaa_t.sfaaent), 
       ( SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = sfaa_t.sfaa009 AND pmaal_t.pmaalent = sfaa_t.sfaaent AND pmaal_t.pmaal002 = '" , 
       g_dlang,"'" ,"),( SELECT ecba003 FROM ecba_t WHERE ecba_t.ecba001 = sfaa_t.sfaa010 AND ecba_t.ecba002 = sfaa_t.sfaa016 AND ecba_t.ecbasite = sfaa_t.sfaasite AND ecba_t.ecbaent = sfaa_t.sfaaent), 
       ( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = sfaa_t.sfaa018 AND ooefl_t.ooeflent = sfaa_t.sfaaent AND ooefl_t.ooefl002 = '" , 
       g_dlang,"'" ,"),( SELECT imaal003 FROM imaal_t WHERE imaal_t.imaal001 = sfaa_t.sfaa010 AND imaal_t.imaalent = sfaa_t.sfaaent AND imaal_t.imaal002 = '" , 
       g_dlang,"'" ,"),( SELECT oocal003 FROM oocal_t WHERE oocal_t.oocal001 = sfaa_t.sfaa060 AND oocal_t.oocalent = sfaa_t.sfaaent AND oocal_t.oocal002 = '" , 
       g_dlang,"'" ,"),( SELECT oocal003 FROM oocal_t WHERE oocal_t.oocal001 = sfaa_t.sfaa013 AND oocal_t.oocalent = sfaa_t.sfaaent AND oocal_t.oocal002 = '" , 
       g_dlang,"'" ,"),( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = sfaa_t.sfaa017 AND ooefl_t.ooeflent = sfaa_t.sfaaent AND ooefl_t.ooefl002 = '" , 
       g_dlang,"'" ,"),( SELECT pjbal003 FROM pjbal_t WHERE pjbal_t.pjbal001 = sfaa_t.sfaa028 AND pjbal_t.pjbalent = sfaa_t.sfaaent AND pjbal_t.pjbal002 = '" , 
       g_dlang,"'" ,"),( SELECT pjbbl004 FROM pjbbl_t WHERE pjbbl_t.pjbbl001 = sfaa_t.sfaa028 AND pjbbl_t.pjbbl002 = sfaa_t.sfaa029 AND pjbbl_t.pjbblent = sfaa_t.sfaaent AND pjbbl_t.pjbbl003 = '" , 
       g_dlang,"'" ,"),( SELECT oocql004 FROM oocql_t WHERE oocql_t.oocql001 = '225' AND oocql_t.oocql002 = sfaa_t.sfaa031 AND oocql_t.oocqlent = sfaa_t.sfaaent AND oocql_t.oocql003 = '" , 
       g_dlang,"'" ,"),x.t4_imaal003,x.t5_imaal003,x.t3_oocql004,x.t8_oocql004,x.t7_oocal003,x.t9_imaal003, 
       trim(sfaa028)||'.'||trim((SELECT pjbal003 FROM pjbal_t WHERE pjbal_t.pjbal001 = sfaa_t.sfaa028 AND pjbal_t.pjbalent = sfaa_t.sfaaent AND pjbal_t.pjbal002 = '" , 
       g_dlang,"'" ,")),trim(sfaa018)||'.'||trim((SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = sfaa_t.sfaa018 AND ooefl_t.ooeflent = sfaa_t.sfaaent AND ooefl_t.ooefl002 = '" , 
       g_dlang,"'" ,")),trim(sfaa009)||'.'||trim((SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = sfaa_t.sfaa009 AND pmaal_t.pmaalent = sfaa_t.sfaaent AND pmaal_t.pmaal002 = '" , 
       g_dlang,"'" ,")),trim(sfaa017)||'.'||trim((SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = sfaa_t.sfaa017 AND ooefl_t.ooeflent = sfaa_t.sfaaent AND ooefl_t.ooefl002 = '" , 
       g_dlang,"'" ,")),trim(sfaa029)||'.'||trim((SELECT pjbbl004 FROM pjbbl_t WHERE pjbbl_t.pjbbl001 = sfaa_t.sfaa028 AND pjbbl_t.pjbbl002 = sfaa_t.sfaa029 AND pjbbl_t.pjbblent = sfaa_t.sfaaent AND pjbbl_t.pjbbl003 = '" , 
       g_dlang,"'" ,")),trim(sfaa002)||'.'||trim((SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = sfaa_t.sfaa002 AND ooag_t.ooagent = sfaa_t.sfaaent)), 
       sfbadocno,sfbaent,sfbasite,sfaaent,sfaasite,'','','','','','','','','','',( SELECT imaal004 FROM imaal_t WHERE imaal_t.imaal001 = sfaa_t.sfaa010 AND imaal_t.imaalent = sfaa_t.sfaaent AND imaal_t.imaal002 = '" , 
       g_dlang,"'" ,"),x.t4_imaal004,x.t5_imaal004,x.t9_imaal004,'','',''"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   
   #end add-point
    LET g_from = " FROM sfaa_t LEFT OUTER JOIN ( SELECT sfba_t.*,( SELECT imaal003 FROM imaal_t WHERE imaal_t.imaal001 = sfba_t.sfba001 AND imaal_t.imaalent = sfba_t.sfbaent AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,") t4_imaal003,( SELECT imaal003 FROM imaal_t WHERE imaal_t.imaal001 = sfba_t.sfba005 AND imaal_t.imaalent = sfba_t.sfbaent AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,") t5_imaal003,( SELECT oocql004 FROM oocql_t WHERE oocql_t.oocql001 = '215' AND oocql_t.oocql002 = sfba_t.sfba002 AND oocql_t.oocqlent = sfba_t.sfbaent AND oocql_t.oocql003 = '" , 
        g_dlang,"'" ,") t3_oocql004,( SELECT oocql004 FROM oocql_t WHERE oocql_t.oocql001 = '221' AND oocql_t.oocql002 = sfba_t.sfba003 AND oocql_t.oocqlent = sfba_t.sfbaent AND oocql_t.oocql003 = '" , 
        g_dlang,"'" ,") t8_oocql004,( SELECT oocal003 FROM oocal_t WHERE oocal_t.oocal001 = sfba_t.sfba014 AND oocal_t.oocalent = sfba_t.sfbaent AND oocal_t.oocal002 = '" , 
        g_dlang,"'" ,") t7_oocal003,( SELECT imaal003 FROM imaal_t WHERE imaal_t.imaal001 = sfba_t.sfba006 AND imaal_t.imaalent = sfba_t.sfbaent AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,") t9_imaal003,( SELECT imaal004 FROM imaal_t WHERE imaal_t.imaal001 = sfba_t.sfba001 AND imaal_t.imaalent = sfba_t.sfbaent AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,") t4_imaal004,( SELECT imaal004 FROM imaal_t WHERE imaal_t.imaal001 = sfba_t.sfba005 AND imaal_t.imaalent = sfba_t.sfbaent AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,") t5_imaal004,( SELECT imaal004 FROM imaal_t WHERE imaal_t.imaal001 = sfba_t.sfba006 AND imaal_t.imaalent = sfba_t.sfbaent AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,") t9_imaal004 FROM sfba_t ) x  ON sfaa_t.sfaaent = x.sfbaent AND sfaa_t.sfaasite  
        = x.sfbasite AND sfaa_t.sfaadocno = x.sfbadocno"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
    LET g_order = " ORDER BY sfaadocno,sfbaseq"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("sfaa_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE asfr300_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE asfr300_g01_curs CURSOR FOR asfr300_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="asfr300_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION asfr300_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   sfaa005 LIKE sfaa_t.sfaa005, 
   sfaa015 LIKE sfaa_t.sfaa015, 
   sfaa029 LIKE sfaa_t.sfaa029, 
   sfaa036 LIKE sfaa_t.sfaa036, 
   sfaa043 LIKE sfaa_t.sfaa043, 
   sfaa048 LIKE sfaa_t.sfaa048, 
   sfba006 LIKE sfba_t.sfba006, 
   sfba012 LIKE sfba_t.sfba012, 
   sfba014 LIKE sfba_t.sfba014, 
   sfba021 LIKE sfba_t.sfba021, 
   sfba023 LIKE sfba_t.sfba023, 
   sfba025 LIKE sfba_t.sfba025, 
   sfba027 LIKE sfba_t.sfba027, 
   sfaa012 LIKE sfaa_t.sfaa012, 
   sfaa013 LIKE sfaa_t.sfaa013, 
   sfaa016 LIKE sfaa_t.sfaa016, 
   sfaa030 LIKE sfaa_t.sfaa030, 
   sfaa034 LIKE sfaa_t.sfaa034, 
   sfaa042 LIKE sfaa_t.sfaa042, 
   sfaa045 LIKE sfaa_t.sfaa045, 
   sfaa049 LIKE sfaa_t.sfaa049, 
   sfaa058 LIKE sfaa_t.sfaa058, 
   sfaa060 LIKE sfaa_t.sfaa060, 
   sfba018 LIKE sfba_t.sfba018, 
   sfaa003 LIKE sfaa_t.sfaa003, 
   sfaa007 LIKE sfaa_t.sfaa007, 
   sfaa014 LIKE sfaa_t.sfaa014, 
   sfaa025 LIKE sfaa_t.sfaa025, 
   sfaa026 LIKE sfaa_t.sfaa026, 
   sfaa046 LIKE sfaa_t.sfaa046, 
   sfaa050 LIKE sfaa_t.sfaa050, 
   sfba015 LIKE sfba_t.sfba015, 
   sfba017 LIKE sfba_t.sfba017, 
   sfaa004 LIKE sfaa_t.sfaa004, 
   sfaa006 LIKE sfaa_t.sfaa006, 
   sfaa009 LIKE sfaa_t.sfaa009, 
   sfaa020 LIKE sfaa_t.sfaa020, 
   sfaa022 LIKE sfaa_t.sfaa022, 
   sfaa037 LIKE sfaa_t.sfaa037, 
   sfaa039 LIKE sfaa_t.sfaa039, 
   sfaa040 LIKE sfaa_t.sfaa040, 
   sfaa055 LIKE sfaa_t.sfaa055, 
   sfaastus LIKE sfaa_t.sfaastus, 
   sfba004 LIKE sfba_t.sfba004, 
   sfba009 LIKE sfba_t.sfba009, 
   sfba022 LIKE sfba_t.sfba022, 
   sfbaseq1 LIKE sfba_t.sfbaseq1, 
   sfaa001 LIKE sfaa_t.sfaa001, 
   sfaa057 LIKE sfaa_t.sfaa057, 
   sfaadocdt LIKE sfaa_t.sfaadocdt, 
   sfaadocno LIKE sfaa_t.sfaadocno, 
   sfaa008 LIKE sfaa_t.sfaa008, 
   sfaa011 LIKE sfaa_t.sfaa011, 
   sfaa017 LIKE sfaa_t.sfaa017, 
   sfaa018 LIKE sfaa_t.sfaa018, 
   sfaa024 LIKE sfaa_t.sfaa024, 
   sfaa031 LIKE sfaa_t.sfaa031, 
   sfaa047 LIKE sfaa_t.sfaa047, 
   sfaa051 LIKE sfaa_t.sfaa051, 
   sfaa059 LIKE sfaa_t.sfaa059, 
   sfaa061 LIKE sfaa_t.sfaa061, 
   sfaa062 LIKE sfaa_t.sfaa062, 
   sfba001 LIKE sfba_t.sfba001, 
   sfba008 LIKE sfba_t.sfba008, 
   sfba024 LIKE sfba_t.sfba024, 
   sfaa019 LIKE sfaa_t.sfaa019, 
   sfaa038 LIKE sfaa_t.sfaa038, 
   sfaa041 LIKE sfaa_t.sfaa041, 
   sfaa056 LIKE sfaa_t.sfaa056, 
   sfba011 LIKE sfba_t.sfba011, 
   sfaa010 LIKE sfaa_t.sfaa010, 
   sfaa021 LIKE sfaa_t.sfaa021, 
   sfaa028 LIKE sfaa_t.sfaa028, 
   sfaa032 LIKE sfaa_t.sfaa032, 
   sfaa035 LIKE sfaa_t.sfaa035, 
   sfaa064 LIKE sfaa_t.sfaa064, 
   sfba003 LIKE sfba_t.sfba003, 
   sfba005 LIKE sfba_t.sfba005, 
   sfba007 LIKE sfba_t.sfba007, 
   sfba010 LIKE sfba_t.sfba010, 
   sfbaseq LIKE sfba_t.sfbaseq, 
   sfaa002 LIKE sfaa_t.sfaa002, 
   sfaa023 LIKE sfaa_t.sfaa023, 
   sfaa033 LIKE sfaa_t.sfaa033, 
   sfaa044 LIKE sfaa_t.sfaa044, 
   sfaa063 LIKE sfaa_t.sfaa063, 
   sfba002 LIKE sfba_t.sfba002, 
   sfba013 LIKE sfba_t.sfba013, 
   sfba016 LIKE sfba_t.sfba016, 
   sfba019 LIKE sfba_t.sfba019, 
   sfba020 LIKE sfba_t.sfba020, 
   sfba026 LIKE sfba_t.sfba026, 
   sfba028 LIKE sfba_t.sfba028, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   pmaal_t_pmaal004 LIKE pmaal_t.pmaal004, 
   ecba_t_ecba003 LIKE ecba_t.ecba003, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   imaal_t_imaal003 LIKE imaal_t.imaal003, 
   oocal_t_oocal003 LIKE oocal_t.oocal003, 
   t1_oocal003 LIKE oocal_t.oocal003, 
   t2_ooefl003 LIKE ooefl_t.ooefl003, 
   pjbal_t_pjbal003 LIKE pjbal_t.pjbal003, 
   pjbbl_t_pjbbl004 LIKE pjbbl_t.pjbbl004, 
   oocql_t_oocql004 LIKE oocql_t.oocql004, 
   x_t4_imaal003 LIKE imaal_t.imaal003, 
   x_t5_imaal003 LIKE imaal_t.imaal003, 
   x_t3_oocql004 LIKE oocql_t.oocql004, 
   x_t8_oocql004 LIKE oocql_t.oocql004, 
   x_t7_oocal003 LIKE oocal_t.oocal003, 
   x_t9_imaal003 LIKE imaal_t.imaal003, 
   l_sfaa028_pjbal003 LIKE type_t.chr1000, 
   l_sfaa018_ooefl003 LIKE type_t.chr1000, 
   l_sfaa009_pmaal004 LIKE type_t.chr100, 
   l_sfaa017_ooefl003 LIKE type_t.chr1000, 
   l_sfaa029_pjbbl004 LIKE type_t.chr1000, 
   l_sfaa002_ooag011 LIKE type_t.chr300, 
   sfbadocno LIKE sfba_t.sfbadocno, 
   sfbaent LIKE sfba_t.sfbaent, 
   sfbasite LIKE sfba_t.sfbasite, 
   sfaaent LIKE sfaa_t.sfaaent, 
   sfaasite LIKE sfaa_t.sfaasite, 
   l_sfaa006_label LIKE type_t.chr1000, 
   l_sfaa017_label LIKE type_t.chr1000, 
   l_sfac006 LIKE sfac_t.sfac006, 
   l_count LIKE type_t.num5, 
   l_sfac006_show LIKE type_t.chr1, 
   l_sfac001 LIKE sfac_t.sfac001, 
   l_sfba021_show LIKE type_t.chr1, 
   l_sfba008_desc LIKE gzcbl_t.gzcbl004, 
   l_imaal003_imaal004 LIKE type_t.chr1000, 
   l_imaal003_imaal004_b LIKE type_t.chr1000, 
   imaal_t_imaal004 LIKE imaal_t.imaal004, 
   x_t4_imaal004 LIKE imaal_t.imaal004, 
   x_t5_imaal004 LIKE imaal_t.imaal004, 
   x_t9_imaal004 LIKE imaal_t.imaal004, 
   l_ooff013_show LIKE type_t.chr1, 
   l_sfac006_desc LIKE type_t.chr1000, 
   l_sfba021_desc LIKE type_t.chr1000
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_count   LIKE type_t.num5
DEFINE l_success LIKE type_t.num5
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH asfr300_g01_curs INTO sr_s.*
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
       #備註顯示否
       LET sr_s.l_ooff013_show = tm.a1
       #單身"料件特徵"顯是否
       IF cl_null(sr_s.sfba021) THEN
          LET sr_s.l_sfba021_show = 'N'
       ELSE
          LET sr_s.l_sfba021_show = 'Y'
          CALL s_feature_description(sr_s.sfba006,sr_s.sfba021) RETURNING l_success,sr_s.l_sfba021_desc
       END IF
       #單頭產品特徵顯示否
       SELECT COUNT (DISTINCT sfac006) INTO sr_s.l_count 
         FROM sfac_t
        WHERE sfacdocno = sr_s.sfaadocno
          AND sfacent = sr_s.sfaaent
       IF sr_s.l_count = 1 THEN
          SELECT sfac001,sfac006 INTO sr_s.l_sfac001,sr_s.l_sfac006
            FROM sfac_t
           WHERE sfacdocno = sr_s.sfaadocno
             AND sfacent = sr_s.sfaaent
          IF sr_s.l_sfac001 = sr_s.sfaa010 THEN
             LET sr_s.l_sfac006_show = "Y"
             CALL s_feature_description(sr_s.l_sfac001,sr_s.l_sfac006) RETURNING l_success,sr_s.l_sfac006_desc
          ELSE
             LET sr_s.l_sfac006_show = "N"
          END IF
       ELSE
          LET sr_s.l_sfac006_show = "N"
       END IF
       #必要特性分類碼轉換
        SELECT gzcbl004 INTO sr_s.l_sfba008_desc
          FROM gzcbl_t
         WHERE gzcbl001 = 1101 
           AND gzcbl002 = sr_s.sfba008 
           AND gzcbl003 = g_dlang
       #組合品名/規格
       IF cl_null(sr_s.imaal_t_imaal003) OR cl_null(sr_s.imaal_t_imaal004) THEN
          LET sr_s.l_imaal003_imaal004 = sr_s.imaal_t_imaal003 , "/" , sr_s.imaal_t_imaal004
       ELSE
          LET sr_s.l_imaal003_imaal004 = sr_s.imaal_t_imaal003 || "/" || sr_s.imaal_t_imaal004
       END IF
       #mark--161024-00057#4 By shiun--(S)
#       #計畫完工日選擇(sfaa020 or sfae002)
#       LET l_count = 0
#       SELECT COUNT(sfaeseq) INTO l_count
#          FROM sfae_t
#         WHERE sfaedocno = sr_s.sfaadocno
#           AND sfaeent = g_enterprise
#       IF l_count = 1 THEN
#          SELECT sfae002 INTO sr_s.sfae002
#          FROM sfae_t
#         WHERE sfaedocno = sr_s.sfaadocno
#           AND sfaeent = sr_s.sfaaent
#          IF sr_s.sfae002 <> sr_s.sfaa020 THEN    
#             LET sr_s.sfaa020 = sr_s.sfae002
#          END IF
#       END IF
       #mark--161024-00057#4 By shiun--(E)
       CASE sr_s.sfaa005
          WHEN '2'
             CALL cl_getmsg('asf-00346',g_lang) RETURNING sr_s.l_sfaa006_label
          WHEN '3'
             CALL cl_getmsg('asf-00347',g_lang) RETURNING sr_s.l_sfaa006_label
          WHEN '4'
             CALL cl_getmsg('asf-00348',g_lang) RETURNING sr_s.l_sfaa006_label
       END CASE
       IF sr_s.sfaa057 = '2' THEN
          CALL cl_getmsg('asf-00349',g_lang) RETURNING sr_s.l_sfaa017_label
          CALL s_desc_get_trading_partner_abbr_desc(sr_s.sfaa017) RETURNING sr_s.l_sfaa017_ooefl003
          LET sr_s.l_sfaa017_ooefl003 = sr_s.sfaa017,".",sr_s.l_sfaa017_ooefl003
       ELSE
          CALL cl_getmsg('asf-00350',g_lang) RETURNING sr_s.l_sfaa017_label
       END IF
       #當前面編號為空時，清空編號.說明的字串(避免編號為空會只顯示一個 .)
       CALL asfr300_g01_initialize(sr_s.sfaa002,sr_s.l_sfaa002_ooag011) RETURNING sr_s.l_sfaa002_ooag011
       CALL asfr300_g01_initialize(sr_s.sfaa017,sr_s.l_sfaa017_ooefl003) RETURNING sr_s.l_sfaa017_ooefl003
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].sfaa005 = sr_s.sfaa005
       LET sr[l_cnt].sfaa015 = sr_s.sfaa015
       LET sr[l_cnt].sfaa029 = sr_s.sfaa029
       LET sr[l_cnt].sfaa036 = sr_s.sfaa036
       LET sr[l_cnt].sfaa043 = sr_s.sfaa043
       LET sr[l_cnt].sfaa048 = sr_s.sfaa048
       LET sr[l_cnt].sfba006 = sr_s.sfba006
       LET sr[l_cnt].sfba012 = sr_s.sfba012
       LET sr[l_cnt].sfba014 = sr_s.sfba014
       LET sr[l_cnt].sfba021 = sr_s.sfba021
       LET sr[l_cnt].sfba023 = sr_s.sfba023
       LET sr[l_cnt].sfba025 = sr_s.sfba025
       LET sr[l_cnt].sfba027 = sr_s.sfba027
       LET sr[l_cnt].sfaa012 = sr_s.sfaa012
       LET sr[l_cnt].sfaa013 = sr_s.sfaa013
       LET sr[l_cnt].sfaa016 = sr_s.sfaa016
       LET sr[l_cnt].sfaa030 = sr_s.sfaa030
       LET sr[l_cnt].sfaa034 = sr_s.sfaa034
       LET sr[l_cnt].sfaa042 = sr_s.sfaa042
       LET sr[l_cnt].sfaa045 = sr_s.sfaa045
       LET sr[l_cnt].sfaa049 = sr_s.sfaa049
       LET sr[l_cnt].sfaa058 = sr_s.sfaa058
       LET sr[l_cnt].sfaa060 = sr_s.sfaa060
       LET sr[l_cnt].sfba018 = sr_s.sfba018
       LET sr[l_cnt].sfaa003 = sr_s.sfaa003
       LET sr[l_cnt].sfaa007 = sr_s.sfaa007
       LET sr[l_cnt].sfaa014 = sr_s.sfaa014
       LET sr[l_cnt].sfaa025 = sr_s.sfaa025
       LET sr[l_cnt].sfaa026 = sr_s.sfaa026
       LET sr[l_cnt].sfaa046 = sr_s.sfaa046
       LET sr[l_cnt].sfaa050 = sr_s.sfaa050
       LET sr[l_cnt].sfba015 = sr_s.sfba015
       LET sr[l_cnt].sfba017 = sr_s.sfba017
       LET sr[l_cnt].sfaa004 = sr_s.sfaa004
       LET sr[l_cnt].sfaa006 = sr_s.sfaa006
       LET sr[l_cnt].sfaa009 = sr_s.sfaa009
       LET sr[l_cnt].sfaa020 = sr_s.sfaa020
       LET sr[l_cnt].sfaa022 = sr_s.sfaa022
       LET sr[l_cnt].sfaa037 = sr_s.sfaa037
       LET sr[l_cnt].sfaa039 = sr_s.sfaa039
       LET sr[l_cnt].sfaa040 = sr_s.sfaa040
       LET sr[l_cnt].sfaa055 = sr_s.sfaa055
       LET sr[l_cnt].sfaastus = sr_s.sfaastus
       LET sr[l_cnt].sfba004 = sr_s.sfba004
       LET sr[l_cnt].sfba009 = sr_s.sfba009
       LET sr[l_cnt].sfba022 = sr_s.sfba022
       LET sr[l_cnt].sfbaseq1 = sr_s.sfbaseq1
       LET sr[l_cnt].sfaa001 = sr_s.sfaa001
       LET sr[l_cnt].sfaa057 = sr_s.sfaa057
       LET sr[l_cnt].sfaadocdt = sr_s.sfaadocdt
       LET sr[l_cnt].sfaadocno = sr_s.sfaadocno
       LET sr[l_cnt].sfaa008 = sr_s.sfaa008
       LET sr[l_cnt].sfaa011 = sr_s.sfaa011
       LET sr[l_cnt].sfaa017 = sr_s.sfaa017
       LET sr[l_cnt].sfaa018 = sr_s.sfaa018
       LET sr[l_cnt].sfaa024 = sr_s.sfaa024
       LET sr[l_cnt].sfaa031 = sr_s.sfaa031
       LET sr[l_cnt].sfaa047 = sr_s.sfaa047
       LET sr[l_cnt].sfaa051 = sr_s.sfaa051
       LET sr[l_cnt].sfaa059 = sr_s.sfaa059
       LET sr[l_cnt].sfaa061 = sr_s.sfaa061
       LET sr[l_cnt].sfaa062 = sr_s.sfaa062
       LET sr[l_cnt].sfba001 = sr_s.sfba001
       LET sr[l_cnt].sfba008 = sr_s.sfba008
       LET sr[l_cnt].sfba024 = sr_s.sfba024
       LET sr[l_cnt].sfaa019 = sr_s.sfaa019
       LET sr[l_cnt].sfaa038 = sr_s.sfaa038
       LET sr[l_cnt].sfaa041 = sr_s.sfaa041
       LET sr[l_cnt].sfaa056 = sr_s.sfaa056
       LET sr[l_cnt].sfba011 = sr_s.sfba011
       LET sr[l_cnt].sfaa010 = sr_s.sfaa010
       LET sr[l_cnt].sfaa021 = sr_s.sfaa021
       LET sr[l_cnt].sfaa028 = sr_s.sfaa028
       LET sr[l_cnt].sfaa032 = sr_s.sfaa032
       LET sr[l_cnt].sfaa035 = sr_s.sfaa035
       LET sr[l_cnt].sfaa064 = sr_s.sfaa064
       LET sr[l_cnt].sfba003 = sr_s.sfba003
       LET sr[l_cnt].sfba005 = sr_s.sfba005
       LET sr[l_cnt].sfba007 = sr_s.sfba007
       LET sr[l_cnt].sfba010 = sr_s.sfba010
       LET sr[l_cnt].sfbaseq = sr_s.sfbaseq
       LET sr[l_cnt].sfaa002 = sr_s.sfaa002
       LET sr[l_cnt].sfaa023 = sr_s.sfaa023
       LET sr[l_cnt].sfaa033 = sr_s.sfaa033
       LET sr[l_cnt].sfaa044 = sr_s.sfaa044
       LET sr[l_cnt].sfaa063 = sr_s.sfaa063
       LET sr[l_cnt].sfba002 = sr_s.sfba002
       LET sr[l_cnt].sfba013 = sr_s.sfba013
       LET sr[l_cnt].sfba016 = sr_s.sfba016
       LET sr[l_cnt].sfba019 = sr_s.sfba019
       LET sr[l_cnt].sfba020 = sr_s.sfba020
       LET sr[l_cnt].sfba026 = sr_s.sfba026
       LET sr[l_cnt].sfba028 = sr_s.sfba028
       LET sr[l_cnt].ooag_t_ooag011 = sr_s.ooag_t_ooag011
       LET sr[l_cnt].pmaal_t_pmaal004 = sr_s.pmaal_t_pmaal004
       LET sr[l_cnt].ecba_t_ecba003 = sr_s.ecba_t_ecba003
       LET sr[l_cnt].ooefl_t_ooefl003 = sr_s.ooefl_t_ooefl003
       LET sr[l_cnt].imaal_t_imaal003 = sr_s.imaal_t_imaal003
       LET sr[l_cnt].oocal_t_oocal003 = sr_s.oocal_t_oocal003
       LET sr[l_cnt].t1_oocal003 = sr_s.t1_oocal003
       LET sr[l_cnt].t2_ooefl003 = sr_s.t2_ooefl003
       LET sr[l_cnt].pjbal_t_pjbal003 = sr_s.pjbal_t_pjbal003
       LET sr[l_cnt].pjbbl_t_pjbbl004 = sr_s.pjbbl_t_pjbbl004
       LET sr[l_cnt].oocql_t_oocql004 = sr_s.oocql_t_oocql004
       LET sr[l_cnt].x_t4_imaal003 = sr_s.x_t4_imaal003
       LET sr[l_cnt].x_t5_imaal003 = sr_s.x_t5_imaal003
       LET sr[l_cnt].x_t3_oocql004 = sr_s.x_t3_oocql004
       LET sr[l_cnt].x_t8_oocql004 = sr_s.x_t8_oocql004
       LET sr[l_cnt].x_t7_oocal003 = sr_s.x_t7_oocal003
       LET sr[l_cnt].x_t9_imaal003 = sr_s.x_t9_imaal003
       LET sr[l_cnt].l_sfaa028_pjbal003 = sr_s.l_sfaa028_pjbal003
       LET sr[l_cnt].l_sfaa018_ooefl003 = sr_s.l_sfaa018_ooefl003
       LET sr[l_cnt].l_sfaa009_pmaal004 = sr_s.l_sfaa009_pmaal004
       LET sr[l_cnt].l_sfaa017_ooefl003 = sr_s.l_sfaa017_ooefl003
       LET sr[l_cnt].l_sfaa029_pjbbl004 = sr_s.l_sfaa029_pjbbl004
       LET sr[l_cnt].l_sfaa002_ooag011 = sr_s.l_sfaa002_ooag011
       LET sr[l_cnt].sfbadocno = sr_s.sfbadocno
       LET sr[l_cnt].sfbaent = sr_s.sfbaent
       LET sr[l_cnt].sfbasite = sr_s.sfbasite
       LET sr[l_cnt].sfaaent = sr_s.sfaaent
       LET sr[l_cnt].sfaasite = sr_s.sfaasite
       LET sr[l_cnt].l_sfaa006_label = sr_s.l_sfaa006_label
       LET sr[l_cnt].l_sfaa017_label = sr_s.l_sfaa017_label
       LET sr[l_cnt].l_sfac006 = sr_s.l_sfac006
       LET sr[l_cnt].l_count = sr_s.l_count
       LET sr[l_cnt].l_sfac006_show = sr_s.l_sfac006_show
       LET sr[l_cnt].l_sfac001 = sr_s.l_sfac001
       LET sr[l_cnt].l_sfba021_show = sr_s.l_sfba021_show
       LET sr[l_cnt].l_sfba008_desc = sr_s.l_sfba008_desc
       LET sr[l_cnt].l_imaal003_imaal004 = sr_s.l_imaal003_imaal004
       LET sr[l_cnt].l_imaal003_imaal004_b = sr_s.l_imaal003_imaal004_b
       LET sr[l_cnt].imaal_t_imaal004 = sr_s.imaal_t_imaal004
       LET sr[l_cnt].x_t4_imaal004 = sr_s.x_t4_imaal004
       LET sr[l_cnt].x_t5_imaal004 = sr_s.x_t5_imaal004
       LET sr[l_cnt].x_t9_imaal004 = sr_s.x_t9_imaal004
       LET sr[l_cnt].l_ooff013_show = sr_s.l_ooff013_show
       LET sr[l_cnt].l_sfac006_desc = sr_s.l_sfac006_desc
       LET sr[l_cnt].l_sfba021_desc = sr_s.l_sfba021_desc
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
 
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
 
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="asfr300_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION asfr300_g01_rep_data()
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
          START REPORT asfr300_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT asfr300_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT asfr300_g01_rep
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
 
{<section id="asfr300_g01.rep" readonly="Y" >}
PRIVATE REPORT asfr300_g01_rep(sr1)
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
#DEFINE sr6       sr6_r   #mark--161024-00057#4 By shiun
DEFINE l_success LIKE type_t.num5
DEFINE sr7       sr7_r                       #160727-00025#7 add
DEFINE l_subrep09_show  LIKE type_t.chr1     #160727-00025#7 add
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER EXTERNAL BY sr1.sfaadocno,sr1.sfbaseq
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
        BEFORE GROUP OF sr1.sfaadocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
 
            #end add-point:rep.header 
            LET g_rep_docno = sr1.sfaadocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'sfaaent=' ,sr1.sfaaent,'{+}sfaadocno=' ,sr1.sfaadocno         
            CALL cl_gr_init_apr(sr1.sfaadocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
            #160727-00025#7 add-S
            SELECT COUNT(1) INTO l_cnt
              FROM sfaa_t 
             WHERE sfaaent = g_enterprise
               AND sfaadocno = sr1.sfaadocno
               AND sfaa003 = '5'
            IF l_cnt > 0 AND NOT cl_null(l_cnt)THEN
               LET l_subrep09_show = 'Y'
            ELSE
               LET l_subrep09_show = 'N'
            END IF
            #160727-00025#7 add-E
            #160727-00025#7 add-S
            LET g_sql = " SELECT DISTINCT sfaidocno,sfai001,imaal003,imaal004,sfai002,sfai004,sfai003,sfai005 ",
                        "   FROM sfai_t LEFT OUTER JOIN imaal_t ON imaal001 = sfai001 AND imaalent = sfaient AND imaal002 = '",g_dlang,"' ",
                        "  WHERE sfaient = ",g_enterprise,
                        "    AND sfaisite = '",g_site,"' ",
                        "    AND sfaidocno = '",sr1.sfaadocno,"' ",
                        "  ORDER BY sfai001 "
            LET l_cnt = 0
            LET l_sub_sql = ""
            LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
            PREPARE asfr300_g01_repcur09_cnt_pre FROM l_sub_sql
            EXECUTE asfr300_g01_repcur09_cnt_pre INTO l_cnt
#            IF l_cnt > 0 THEN       #模具工单需要显示单头，不管有没有资料
#               LET l_subrep09_show ="Y"
#            END IF
            PRINTX l_subrep09_show
#            START REPORT asfr300_g01_subrep09
            DECLARE asfr300_g01_repcur09 CURSOR FROM g_sql
            INITIALIZE sr7 TO NULL
            FOREACH asfr300_g01_repcur09 INTO sr7.*
               IF STATUS THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = "asfr300_g01_repcur09:"
                  LET g_errparam.code   = SQLCA.sqlcode
                  LET g_errparam.popup  = FALSE
                  CALL cl_err()                  
                  EXIT FOREACH 
               END IF
               #add-point:rep.sub01.foreach name="rep.sub01.foreach"
               IF NOT cl_null(sr7.l_sfai001) AND NOT cl_null(sr7.l_sfai001_1) THEN
                  LET sr7.l_sfai001 = sr7.l_sfai001,'/',sr7.l_sfai001_1
               END IF
               #end add-point:rep.sub01.foreach
#               OUTPUT TO REPORT asfr300_g01_subrep09(sr7.*)
            END FOREACH
#            FINISH REPORT asfr300_g01_subrep09
            PRINTX sr7.*
            #160727-00025#7 add-E
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.sfaadocno.before name="rep.b_group.sfaadocno.before"
 
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           #161031-00025#17-s mark
#           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooffent = '", 
#                sr1.sfaaent CLIPPED ,"'", " AND  ooff002 = '", sr1.sfaasite CLIPPED ,"'", " AND  ooff003 = '", sr1.sfaadocno CLIPPED ,"'"
           #161031-00025#17-e mark    
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.sfaaent CLIPPED ,"'", " AND  ooff003 = '", sr1.sfaadocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE asfr300_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE asfr300_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT asfr300_g01_subrep01
           DECLARE asfr300_g01_repcur01 CURSOR FROM g_sql
           FOREACH asfr300_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "asfr300_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT asfr300_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT asfr300_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.sfaadocno.after name="rep.b_group.sfaadocno.after"
           START REPORT asfr300_g01_subrep05
              SELECT COUNT (1) INTO sr3.l_count
                FROM sfab_t
               WHERE sfabdocno = sr1.sfaadocno
                 AND sfabent = sr1.sfaaent
              IF sr1.sfaa005 = '1' AND sr3.l_count > 1 THEN
                 LET g_sql = "SELECT sfabdocno,sfab001,sfab006,sfab002,sfab003,sfab004,sfab007 ",
                             "  FROM sfab_t ",
                             " WHERE sfabdocno = '",sr1.sfaadocno CLIPPED,"'",
                             "   AND sfabent   = '",sr1.sfaaent   CLIPPED,"'",                             
                             "   ORDER BY sfabseq "                                       
   
                 DECLARE asfr300_g01_repcur05 CURSOR FROM g_sql
                 FOREACH asfr300_g01_repcur05 INTO sr3.*
                    #來源(系統分類碼轉換)
                    CALL s_desc_gzcbl004_desc('4009',sr3.sfab001) RETURNING sr3.l_sfab001_desc
                    #當來源為訂單時帶入客戶編號   
                    IF sr3.sfab001 = 2 THEN   
                       SELECT xmda004 INTO sr3.l_xmda004
                         FROM xmda_t
                        WHERE xmdaent = sr1.sfaaent
                          AND xmdadocno = sr1.sfaadocno
                    END IF
                    #組合來源單號/項次/項序
                    IF cl_null(sr3.sfab002) OR cl_null(sr3.sfab003) OR cl_null(sr3.sfab004) THEN
                       LET sr3.l_sfab002_sfab003_sfab004 = sr3.sfab002 , "/" , sr3.sfab003 , "/" , sr3.sfab004
                    ELSE
                       LET sr3.l_sfab002_sfab003_sfab004 = sr3.sfab002 || "/" || sr3.sfab003 || "/" || sr3.sfab004
                    END IF
                    OUTPUT TO REPORT asfr300_g01_subrep05(sr3.*)
                 END FOREACH
              END IF
           FINISH REPORT asfr300_g01_subrep05
       
           START REPORT asfr300_g01_subrep06 
                 LET g_sql = "SELECT sfacdocno,sfac002,sfac001,sfac003,sfac004 ",
                             "  FROM sfac_t ",
                             " WHERE sfacdocno = '",sr1.sfaadocno CLIPPED,"'",
                             "   AND sfacent   = '",sr1.sfaaent   CLIPPED,"'",                             
                             "   ORDER BY sfacseq "                                       
   
                 DECLARE asfr300_g01_repcur06 CURSOR FROM g_sql
                 FOREACH asfr300_g01_repcur06 INTO sr4.*
                    SELECT COUNT (DISTINCT sfac001) INTO sr4.l_count
                      FROM sfac_t
                     WHERE sfacdocno = sr1.sfaadocno
                       AND sfacent = sr1.sfaaent
                    IF sr4.l_count = 1 AND sr4.sfac001 = sr1.sfaa010 THEN
                     CONTINUE FOREACH
                    END IF
                    
                    #來源(系統分類碼轉換)
                    CALL s_desc_gzcbl004_desc('4019',sr4.sfac002) RETURNING sr4.l_sfac002_desc                   
                    #帶入品名/規格
                    CALL s_desc_get_item_desc(sr4.sfac001) RETURNING sr4.l_imaal003,sr4.l_imaal004
   
                 #組合品名/規格
                 IF cl_null(sr4.l_imaal003) OR cl_null(sr4.l_imaal004) THEN
                    LET sr4.l_imaal003_imaal004 = sr4.l_imaal003 , "/" , sr4.l_imaal004
                 ELSE
                    LET sr4.l_imaal003_imaal004 = sr4.l_imaal003 || "/" || sr4.l_imaal004
                 END IF
   
                 OUTPUT TO REPORT asfr300_g01_subrep06(sr4.*)
                END FOREACH
           FINISH REPORT asfr300_g01_subrep06
               
   
           START REPORT asfr300_g01_subrep07 
              SELECT COUNT (DISTINCT sfac006) INTO sr5.l_count
                FROM sfac_t
               WHERE sfacdocno = sr1.sfaadocno
                 AND sfacent = sr1.sfaaent
              IF sr5.l_count > 1 THEN
                 LET g_sql = "SELECT sfacdocno,sfac001,sfac003,sfac006 ",
                             "  FROM sfac_t ",
                             " WHERE sfacdocno = '",sr1.sfaadocno CLIPPED,"'",
                             "   AND sfacent   = '",sr1.sfaaent   CLIPPED,"'",                 
                             "   ORDER BY sfacseq "                                       
                       
                 
                 DECLARE asfr300_g01_repcur07 CURSOR FROM g_sql
                 FOREACH asfr300_g01_repcur07 INTO sr5.*
                     CALL s_feature_description(sr5.sfac001,sr5.sfac006) RETURNING l_success,sr5.l_sfac006_desc
                     OUTPUT TO REPORT asfr300_g01_subrep07(sr5.*)
                 END FOREACH
              END IF
           FINISH REPORT asfr300_g01_subrep07     
           #mark--161024-00057#4 By shiun--(S)           
#           START REPORT asfr300_g01_subrep08              
#              SELECT COUNT (1) INTO sr6.l_count
#                FROM sfae_t
#               WHERE sfaedocno = sr1.sfaadocno
#                 AND sfaeent = sr1.sfaaent
#              IF sr6.l_count > 1 THEN
#                 LET g_sql = "SELECT sfaedocno,sfae002,sfae001 ",
#                             "  FROM sfae_t ",
#                             " WHERE sfaedocno = '",sr1.sfaadocno CLIPPED,"'",
#                             "   AND sfaeent   = '",sr1.sfaaent   CLIPPED,"'",     
#                             "   ORDER BY sfaeseq "                                       
#                       
#                 
#                 DECLARE asfr300_g01_repcur08 CURSOR FROM g_sql
#                 FOREACH asfr300_g01_repcur08 INTO sr6.*             
#                     OUTPUT TO REPORT asfr300_g01_subrep08(sr6.*)
#                 END FOREACH 
#              END IF
#           FINISH REPORT asfr300_g01_subrep08
           #mark--161024-00057#4 By shiun--(E)
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.sfbaseq
 
           #add-point:rep.b_group.sfbaseq.before name="rep.b_group.sfbaseq.before"
 
           #end add-point:
 
 
           #add-point:rep.b_group.sfbaseq.after name="rep.b_group.sfbaseq.after"
           
           #end add-point:
 
 
 
 
       ON EVERY ROW
          #add-point:rep.everyrow.before name="rep.everyrow.before"
          
          #end add-point:rep.everyrow.before
 
          #單身前備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub02.before name="rep.sub02.before"
           
           #end add-point:rep.sub02.before
 
           #add-point:rep.sub02.sql name="rep.sub02.sql"
           #161031-00025#17-s
#           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='2' AND ooffent = '", 
#                sr1.sfaaent CLIPPED ,"'", " AND  ooff002 = '", sr1.sfaasite CLIPPED ,"'", " AND  ooff003 = '", sr1.sfaadocno CLIPPED ,"'",
#                " AND  ooff004 = '", sr1.sfbaseq CLIPPED ,"'"
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='2' AND ooffent = '", 
                sr1.sfaaent CLIPPED ,"'", " AND  ooff003 = '", sr1.sfaadocno CLIPPED ,"'", " AND  ooff004 = '"||sr1.sfbaseq CLIPPED||"'",
                "AND  ooff005 = TO_CHAR('"||sr1.sfbaseq1 CLIPPED||"')"
           #161031-00025#17-e            
#           #end add-point:rep.sub02.sql
# 
#           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='2' AND ooffent = '", 
#                sr1.sfaaent CLIPPED ,"'", " AND  ooff003 = '", sr1.sfaadocno CLIPPED ,"'", " AND  ooff004 = ", 
#                sr1.sfbaseq CLIPPED ,""
# 
#           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE asfr300_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE asfr300_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT asfr300_g01_subrep02
           DECLARE asfr300_g01_repcur02 CURSOR FROM g_sql
           FOREACH asfr300_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "asfr300_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT asfr300_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT asfr300_g01_subrep02
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
           #161031-00025#17-s
#           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooffent = '", 
#                sr1.sfaaent CLIPPED ,"'", " AND  ooff002 = '", sr1.sfaasite CLIPPED ,"'", " AND  ooff003 = '", sr1.sfaadocno CLIPPED ,"'",
#                " AND  ooff004 = '", sr1.sfbaseq CLIPPED ,"'"
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooffent = '", 
                sr1.sfaaent CLIPPED ,"'", " AND  ooff003 = '", sr1.sfaadocno CLIPPED ,"'", " AND  ooff004 = '"||sr1.sfbaseq CLIPPED||"'",
                "AND  ooff005 = TO_CHAR('"||sr1.sfbaseq1 CLIPPED||"')"
           #161031-00025#17-e   
#           #end add-point:rep.sub03.sql
# 
#           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooffent = '", 
#                sr1.sfaaent CLIPPED ,"'", " AND  ooff003 = '", sr1.sfaadocno CLIPPED ,"'", " AND  ooff004 = ", 
#                sr1.sfbaseq CLIPPED ,""
# 
#           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE asfr300_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE asfr300_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT asfr300_g01_subrep03
           DECLARE asfr300_g01_repcur03 CURSOR FROM g_sql
           FOREACH asfr300_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "asfr300_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT asfr300_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT asfr300_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.sfaadocno
 
           #add-point:rep.a_group.sfaadocno.before name="rep.a_group.sfaadocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           #161031-00025#17-s mark
#           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooffent = '", 
#                sr1.sfaaent CLIPPED ,"'", " AND  ooff002 = '", sr1.sfaasite CLIPPED ,"'", " AND  ooff003 = '", sr1.sfaadocno CLIPPED ,"'"
           #161031-00025#17-e mark                
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.sfaaent CLIPPED ,"'", " AND  ooff003 = '", sr1.sfaadocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE asfr300_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE asfr300_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT asfr300_g01_subrep04
           DECLARE asfr300_g01_repcur04 CURSOR FROM g_sql
           FOREACH asfr300_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "asfr300_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT asfr300_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT asfr300_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.sfaadocno.after name="rep.a_group.sfaadocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.sfbaseq
 
           #add-point:rep.a_group.sfbaseq.before name="rep.a_group.sfbaseq.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.sfbaseq.after name="rep.a_group.sfbaseq.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="asfr300_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT asfr300_g01_subrep01(sr2)
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
PRIVATE REPORT asfr300_g01_subrep02(sr2)
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
PRIVATE REPORT asfr300_g01_subrep03(sr2)
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
PRIVATE REPORT asfr300_g01_subrep04(sr2)
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
 
{<section id="asfr300_g01.other_function" readonly="Y" >}

PRIVATE FUNCTION asfr300_g01_initialize(p_arg,p_exp)
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
 
{<section id="asfr300_g01.other_report" readonly="Y" >}

PRIVATE REPORT asfr300_g01_subrep05(sr3)
     DEFINE sr3 sr3_r
     ORDER EXTERNAL BY sr3.sfabdocno     
     FORMAT
        ON EVERY ROW       
        PRINTX g_grNumFmt.*  
        PRINTX sr3.*
END REPORT

PRIVATE REPORT asfr300_g01_subrep06(sr4)
     DEFINE sr4 sr4_r
     ORDER EXTERNAL BY sr4.sfacdocno     
     FORMAT
        ON EVERY ROW       
        PRINTX g_grNumFmt.*  
        PRINTX sr4.*
END REPORT

PRIVATE REPORT asfr300_g01_subrep07(sr5)
     DEFINE sr5 sr5_r
     ORDER EXTERNAL BY sr5.sfacdocno     
     FORMAT
        ON EVERY ROW       
        PRINTX g_grNumFmt.*
        PRINTX sr5.*
END REPORT

 
{</section>}
 
