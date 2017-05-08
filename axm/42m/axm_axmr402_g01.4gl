{<section id="axmr402_g01.description" >}
#+ Version..: T100-ERP-1.00.00(SD版次:1,PD版次:) Build-000072
#+ 
#+ Filename...: axmr402_g01
#+ Description: 客戶訂單明細表
#+ Creator....: 02716(2014/03/04)
#+ Modifier...: 02716(2014/04/21)
#+ Buildtype..: 應用 g01 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="axmr402_g01.global" >}
 
IMPORT os
#add-point:增加匯入項目

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../cfg/top_report.inc"                  #報表使用的global
 
#報表 type 宣告
PRIVATE TYPE sr1_r RECORD
   apca001 LIKE apca_t.apca001, 
   apca003 LIKE apca_t.apca003, 
   apca004 LIKE apca_t.apca004, 
   apca005 LIKE apca_t.apca005, 
   apca006 LIKE apca_t.apca006, 
   apca007 LIKE apca_t.apca007, 
   apca008 LIKE apca_t.apca008, 
   apca009 LIKE apca_t.apca009, 
   apca010 LIKE apca_t.apca010, 
   apca011 LIKE apca_t.apca011, 
   apca012 LIKE apca_t.apca012, 
   apca013 LIKE apca_t.apca013, 
   apca014 LIKE apca_t.apca014, 
   apca015 LIKE apca_t.apca015, 
   apca016 LIKE apca_t.apca016, 
   apca017 LIKE apca_t.apca017, 
   apca018 LIKE apca_t.apca018, 
   apca019 LIKE apca_t.apca019, 
   apca020 LIKE apca_t.apca020, 
   apca021 LIKE apca_t.apca021, 
   apca022 LIKE apca_t.apca022, 
   apca025 LIKE apca_t.apca025, 
   apca026 LIKE apca_t.apca026, 
   apca027 LIKE apca_t.apca027, 
   apca028 LIKE apca_t.apca028, 
   apca029 LIKE apca_t.apca029, 
   apca030 LIKE apca_t.apca030, 
   apca031 LIKE apca_t.apca031, 
   apca033 LIKE apca_t.apca033, 
   apca034 LIKE apca_t.apca034, 
   apca035 LIKE apca_t.apca035, 
   apca036 LIKE apca_t.apca036, 
   apca037 LIKE apca_t.apca037, 
   apca038 LIKE apca_t.apca038, 
   apca039 LIKE apca_t.apca039, 
   apca046 LIKE apca_t.apca046, 
   apca047 LIKE apca_t.apca047, 
   apca048 LIKE apca_t.apca048, 
   apca049 LIKE apca_t.apca049, 
   apca050 LIKE apca_t.apca050, 
   apca051 LIKE apca_t.apca051, 
   apca052 LIKE apca_t.apca052, 
   apca053 LIKE apca_t.apca053, 
   apca054 LIKE apca_t.apca054, 
   apca055 LIKE apca_t.apca055, 
   apca056 LIKE apca_t.apca056, 
   apca057 LIKE apca_t.apca057, 
   apca058 LIKE apca_t.apca058, 
   apca059 LIKE apca_t.apca059, 
   apca060 LIKE apca_t.apca060, 
   apca061 LIKE apca_t.apca061, 
   apca062 LIKE apca_t.apca062, 
   apca063 LIKE apca_t.apca063, 
   apca100 LIKE apca_t.apca100, 
   apca101 LIKE apca_t.apca101, 
   apca103 LIKE apca_t.apca103, 
   apca104 LIKE apca_t.apca104, 
   apca106 LIKE apca_t.apca106, 
   apca107 LIKE apca_t.apca107, 
   apca108 LIKE apca_t.apca108, 
   apca113 LIKE apca_t.apca113, 
   apca114 LIKE apca_t.apca114, 
   apca116 LIKE apca_t.apca116, 
   apca117 LIKE apca_t.apca117, 
   apca118 LIKE apca_t.apca118, 
   apca120 LIKE apca_t.apca120, 
   apca121 LIKE apca_t.apca121, 
   apca123 LIKE apca_t.apca123, 
   apca124 LIKE apca_t.apca124, 
   apca126 LIKE apca_t.apca126, 
   apca127 LIKE apca_t.apca127, 
   apca128 LIKE apca_t.apca128, 
   apca130 LIKE apca_t.apca130, 
   apca131 LIKE apca_t.apca131, 
   apca133 LIKE apca_t.apca133, 
   apca134 LIKE apca_t.apca134, 
   apca136 LIKE apca_t.apca136, 
   apca137 LIKE apca_t.apca137, 
   apca138 LIKE apca_t.apca138, 
   apcacomp LIKE apca_t.apcacomp, 
   apcadocdt LIKE apca_t.apcadocdt, 
   apcadocno LIKE apca_t.apcadocno, 
   apcaent LIKE apca_t.apcaent, 
   apcald LIKE apca_t.apcald, 
   apcasite LIKE apca_t.apcasite, 
   apcastus LIKE apca_t.apcastus, 
   apcb001 LIKE apcb_t.apcb001, 
   apcb002 LIKE apcb_t.apcb002, 
   apcb003 LIKE apcb_t.apcb003, 
   apcb004 LIKE apcb_t.apcb004, 
   apcb005 LIKE apcb_t.apcb005, 
   apcb006 LIKE apcb_t.apcb006, 
   apcb007 LIKE apcb_t.apcb007, 
   apcb008 LIKE apcb_t.apcb008, 
   apcb009 LIKE apcb_t.apcb009, 
   apcb010 LIKE apcb_t.apcb010, 
   apcb011 LIKE apcb_t.apcb011, 
   apcb012 LIKE apcb_t.apcb012, 
   apcb013 LIKE apcb_t.apcb013, 
   apcb014 LIKE apcb_t.apcb014, 
   apcb015 LIKE apcb_t.apcb015, 
   apcb016 LIKE apcb_t.apcb016, 
   apcb017 LIKE apcb_t.apcb017, 
   apcb018 LIKE apcb_t.apcb018, 
   apcb019 LIKE apcb_t.apcb019, 
   apcb020 LIKE apcb_t.apcb020, 
   apcb021 LIKE apcb_t.apcb021, 
   apcb022 LIKE apcb_t.apcb022, 
   apcb023 LIKE apcb_t.apcb023, 
   apcb024 LIKE apcb_t.apcb024, 
   apcb025 LIKE apcb_t.apcb025, 
   apcb026 LIKE apcb_t.apcb026, 
   apcb028 LIKE apcb_t.apcb028, 
   apcb029 LIKE apcb_t.apcb029, 
   apcb100 LIKE apcb_t.apcb100, 
   apcb101 LIKE apcb_t.apcb101, 
   apcb103 LIKE apcb_t.apcb103, 
   apcb104 LIKE apcb_t.apcb104, 
   apcb105 LIKE apcb_t.apcb105, 
   apcb106 LIKE apcb_t.apcb106, 
   apcb108 LIKE apcb_t.apcb108, 
   apcb111 LIKE apcb_t.apcb111, 
   apcb113 LIKE apcb_t.apcb113, 
   apcb114 LIKE apcb_t.apcb114, 
   apcb115 LIKE apcb_t.apcb115, 
   apcb116 LIKE apcb_t.apcb116, 
   apcb117 LIKE apcb_t.apcb117, 
   apcb118 LIKE apcb_t.apcb118, 
   apcb119 LIKE apcb_t.apcb119, 
   apcb123 LIKE apcb_t.apcb123, 
   apcb124 LIKE apcb_t.apcb124, 
   apcb125 LIKE apcb_t.apcb125, 
   apcb126 LIKE apcb_t.apcb126, 
   apcb128 LIKE apcb_t.apcb128, 
   apcb133 LIKE apcb_t.apcb133, 
   apcb134 LIKE apcb_t.apcb134, 
   apcb135 LIKE apcb_t.apcb135, 
   apcb136 LIKE apcb_t.apcb136, 
   apcb138 LIKE apcb_t.apcb138, 
   apcblegl LIKE apcb_t.apcblegl, 
   apcborga LIKE apcb_t.apcborga, 
   apcbseq LIKE apcb_t.apcbseq, 
   apcbsite LIKE apcb_t.apcbsite, 
   oofa_t_oofa011 LIKE oofa_t.oofa011, 
   t1_oofa011 LIKE oofa_t.oofa011, 
   pmaal_t_pmaal004 LIKE pmaal_t.pmaal004, 
   t8_pmaal004 LIKE pmaal_t.pmaal004, 
   oocql_t_oocql004 LIKE oocql_t.oocql004, 
   t5_oocql004 LIKE oocql_t.oocql004, 
   t6_oocql004 LIKE oocql_t.oocql004, 
   ooibl_t_ooibl004 LIKE ooibl_t.ooibl004, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   t2_ooefl003 LIKE ooefl_t.ooefl003, 
   t3_ooefl003 LIKE ooefl_t.ooefl003, 
   t7_ooefl003 LIKE ooefl_t.ooefl003, 
   glacl_t_glacl004 LIKE glacl_t.glacl004, 
   t4_glacl004 LIKE glacl_t.glacl004, 
   ooidl_t_ooidl003 LIKE ooidl_t.ooidl003, 
   bgaal_t_bgaal003 LIKE bgaal_t.bgaal003, 
   glaal_t_glaal002 LIKE glaal_t.glaal002, 
   x_oodbl_t_oodbl004 LIKE oodbl_t.oodbl004
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
 
#add-point:自定義環境變數(Global Variable)

#end add-point
 
{</section>}
 
{<section id="axmr402_g01.main" >}
PUBLIC FUNCTION axmr402_g01(--)
   #add-point:component段變數傳入
p_arg1
   #end add-point
   )
DEFINE  p_arg1 STRING                  #tm.wc  where condition
#add-point:init段define

#end add-point
 
   LET tm.wc = p_arg1
 
   #add-point:報表元件參數準備
   
   #end add-point
   #報表元件代號
   LET g_rep_code = "axmr402_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL axmr402_g01_sel_prep()
 
   #將資料存入array
   CALL axmr402_g01_ins_data()
 
   #將資料印出
   CALL axmr402_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="axmr402_g01.sel_prep" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axmr402_g01_sel_prep()
   #add-point:sel_prep段define
   
   #end add-point
 
   #add-point:sel_prep before
   
   #end add-point
   
   #add-point:sel_prep g_select
   
   #end add-point
   LET g_select = " SELECT apca001,apca003,apca004,apca005,apca006,apca007,apca008,apca009,apca010,apca011, 
       apca012,apca013,apca014,apca015,apca016,apca017,apca018,apca019,apca020,apca021,apca022,apca025, 
       apca026,apca027,apca028,apca029,apca030,apca031,apca033,apca034,apca035,apca036,apca037,apca038, 
       apca039,apca046,apca047,apca048,apca049,apca050,apca051,apca052,apca053,apca054,apca055,apca056, 
       apca057,apca058,apca059,apca060,apca061,apca062,apca063,apca100,apca101,apca103,apca104,apca106, 
       apca107,apca108,apca113,apca114,apca116,apca117,apca118,apca120,apca121,apca123,apca124,apca126, 
       apca127,apca128,apca130,apca131,apca133,apca134,apca136,apca137,apca138,apcacomp,apcadocdt,apcadocno, 
       apcaent,apcald,apcasite,apcastus,apcb001,apcb002,apcb003,apcb004,apcb005,apcb006,apcb007,apcb008, 
       apcb009,apcb010,apcb011,apcb012,apcb013,apcb014,apcb015,apcb016,apcb017,apcb018,apcb019,apcb020, 
       apcb021,apcb022,apcb023,apcb024,apcb025,apcb026,apcb028,apcb029,apcb100,apcb101,apcb103,apcb104, 
       apcb105,apcb106,apcb108,apcb111,apcb113,apcb114,apcb115,apcb116,apcb117,apcb118,apcb119,apcb123, 
       apcb124,apcb125,apcb126,apcb128,apcb133,apcb134,apcb135,apcb136,apcb138,apcblegl,apcborga,apcbseq, 
       apcbsite,oofa_t.oofa011,t1.oofa011,pmaal_t.pmaal004,t8.pmaal004,oocql_t.oocql004,t5.oocql004, 
       t6.oocql004,ooibl_t.ooibl004,ooefl_t.ooefl003,t2.ooefl003,t3.ooefl003,t7.ooefl003,glacl_t.glacl004, 
       t4.glacl004,ooidl_t.ooidl003,bgaal_t.bgaal003,glaal_t.glaal002,x.oodbl_t_oodbl004"
 
   #add-point:sel_prep g_from
   
   #end add-point
    LET g_from = " FROM apca_t LEFT OUTER JOIN pmaal_t ON pmaal_t.pmaalent = apca_t.apcaent AND pmaal_t.pmaal001 = apca_t.apca004 AND pmaal_t.pmaal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN oofa_t ON oofa_t.oofa002 = '2' AND oofa_t.oofa003 = apca_t.apca003 AND oofa_t.oofaent = apca_t.apcaent             LEFT OUTER JOIN oocql_t ON oocql_t.oocqlent = apca_t.apcaent AND oocql_t.oocql001 = '3211' AND oocql_t.oocql002 = apca_t.apca007 AND oocql_t.oocql003 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN ooibl_t ON ooibl_t.ooiblent = apca_t.apcaent AND ooibl_t.ooibl002 = apca_t.apca008 AND ooibl_t.ooibl003 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN oofa_t t1 ON t1.oofa002 = '2' AND t1.oofa003 = apca_t.apca014 AND t1.oofaent = apca_t.apcaent             LEFT OUTER JOIN ooefl_t ON ooefl_t.ooeflent = apca_t.apcaent AND ooefl_t.ooefl001 = apca_t.apca015 AND ooefl_t.ooefl002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN glacl_t ON glacl_t.glaclent = apca_t.apcaent AND glacl_t.glacl001 = ' ' AND glacl_t.glacl002 = apca_t.apca030 AND glacl_t.glacl003 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN ooefl_t t2 ON t2.ooeflent = apca_t.apcaent AND t2.ooefl001 = apca_t.apca033 AND t2.ooefl002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN ooefl_t t3 ON t3.ooeflent = apca_t.apcaent AND t3.ooefl001 = apca_t.apca034 AND t3.ooefl002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN glacl_t t4 ON t4.glaclent = apca_t.apcaent AND t4.glacl001 = ' ' AND t4.glacl002 = apca_t.apca036 AND t4.glacl003 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN oocql_t t5 ON t5.oocqlent = apca_t.apcaent AND t5.oocql001 = '3114' AND t5.oocql002 = apca_t.apca054 AND t5.oocql003 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN ooidl_t ON ooidl_t.ooidlent = apca_t.apcaent AND ooidl_t.ooidl001 = apca_t.apca055 AND ooidl_t.ooidl002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN oocql_t t6 ON t6.oocqlent = apca_t.apcaent AND t6.oocql001 = '264' AND t6.oocql002 = apca_t.apca058 AND t6.oocql003 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN bgaal_t ON bgaal_t.bgaalent = apca_t.apcaent AND bgaal_t.bgaal001 = apca_t.apca059 AND bgaal_t.bgaal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN glaal_t ON glaal_t.glaalent = apca_t.apcaent AND glaal_t.glaalld = apca_t.apcald AND glaal_t.glaal001 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN ooefl_t t7 ON t7.ooeflent = apca_t.apcaent AND t7.ooefl001 = apca_t.apcasite AND t7.ooefl002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN pmaal_t t8 ON t8.pmaalent = apca_t.apcaent AND t8.pmaal001 = apca_t.apca005 AND t8.pmaal002 = '" , 
        g_dlang,"'" ," LEFT OUTER JOIN ( SELECT apcb_t.*,oodbl_t.oodbl004 oodbl_t_oodbl004 FROM apcb_t             LEFT OUTER JOIN oodbl_t ON oodbl_t.oodblent = apcb_t.apcbent AND oodbl_t.oodbl001 = ' ' AND oodbl_t.oodbl002 = apcb_t.apcb020 AND oodbl_t.oodbl003 = '" , 
        g_dlang,"'" ," ) x  ON apca_t.apcaent = x.apcbent AND apca_t.apcald = x.apcbld AND apca_t.apcadocno  
        = x.apcbdocno AND apca_t.apcasite = x.apcbsite"
 
   #add-point:sel_prep g_where
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order
   
   #end add-point
    LET g_order = " ORDER BY apcadocno,apcbseq"
 
   #add-point:sel_prep.sql.before
   
   #end add-point:sel_prep.sql.before
 
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED 
 
   #add-point:sel_prep.sql.after
   
   #end add-point
   PREPARE axmr402_g01_prepare FROM g_sql
   IF STATUS THEN
      CALL cl_err('prepare:',STATUS,1)
      CALL cl_ap_exitprogram("0")
   END IF
   DECLARE axmr402_g01_curs CURSOR FOR axmr402_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="axmr402_g01.ins_data" >}
PRIVATE FUNCTION axmr402_g01_ins_data()
#主報表record(用於select子句)
DEFINE sr_s RECORD 
   apca001 LIKE apca_t.apca001, 
   apca003 LIKE apca_t.apca003, 
   apca004 LIKE apca_t.apca004, 
   apca005 LIKE apca_t.apca005, 
   apca006 LIKE apca_t.apca006, 
   apca007 LIKE apca_t.apca007, 
   apca008 LIKE apca_t.apca008, 
   apca009 LIKE apca_t.apca009, 
   apca010 LIKE apca_t.apca010, 
   apca011 LIKE apca_t.apca011, 
   apca012 LIKE apca_t.apca012, 
   apca013 LIKE apca_t.apca013, 
   apca014 LIKE apca_t.apca014, 
   apca015 LIKE apca_t.apca015, 
   apca016 LIKE apca_t.apca016, 
   apca017 LIKE apca_t.apca017, 
   apca018 LIKE apca_t.apca018, 
   apca019 LIKE apca_t.apca019, 
   apca020 LIKE apca_t.apca020, 
   apca021 LIKE apca_t.apca021, 
   apca022 LIKE apca_t.apca022, 
   apca025 LIKE apca_t.apca025, 
   apca026 LIKE apca_t.apca026, 
   apca027 LIKE apca_t.apca027, 
   apca028 LIKE apca_t.apca028, 
   apca029 LIKE apca_t.apca029, 
   apca030 LIKE apca_t.apca030, 
   apca031 LIKE apca_t.apca031, 
   apca033 LIKE apca_t.apca033, 
   apca034 LIKE apca_t.apca034, 
   apca035 LIKE apca_t.apca035, 
   apca036 LIKE apca_t.apca036, 
   apca037 LIKE apca_t.apca037, 
   apca038 LIKE apca_t.apca038, 
   apca039 LIKE apca_t.apca039, 
   apca046 LIKE apca_t.apca046, 
   apca047 LIKE apca_t.apca047, 
   apca048 LIKE apca_t.apca048, 
   apca049 LIKE apca_t.apca049, 
   apca050 LIKE apca_t.apca050, 
   apca051 LIKE apca_t.apca051, 
   apca052 LIKE apca_t.apca052, 
   apca053 LIKE apca_t.apca053, 
   apca054 LIKE apca_t.apca054, 
   apca055 LIKE apca_t.apca055, 
   apca056 LIKE apca_t.apca056, 
   apca057 LIKE apca_t.apca057, 
   apca058 LIKE apca_t.apca058, 
   apca059 LIKE apca_t.apca059, 
   apca060 LIKE apca_t.apca060, 
   apca061 LIKE apca_t.apca061, 
   apca062 LIKE apca_t.apca062, 
   apca063 LIKE apca_t.apca063, 
   apca100 LIKE apca_t.apca100, 
   apca101 LIKE apca_t.apca101, 
   apca103 LIKE apca_t.apca103, 
   apca104 LIKE apca_t.apca104, 
   apca106 LIKE apca_t.apca106, 
   apca107 LIKE apca_t.apca107, 
   apca108 LIKE apca_t.apca108, 
   apca113 LIKE apca_t.apca113, 
   apca114 LIKE apca_t.apca114, 
   apca116 LIKE apca_t.apca116, 
   apca117 LIKE apca_t.apca117, 
   apca118 LIKE apca_t.apca118, 
   apca120 LIKE apca_t.apca120, 
   apca121 LIKE apca_t.apca121, 
   apca123 LIKE apca_t.apca123, 
   apca124 LIKE apca_t.apca124, 
   apca126 LIKE apca_t.apca126, 
   apca127 LIKE apca_t.apca127, 
   apca128 LIKE apca_t.apca128, 
   apca130 LIKE apca_t.apca130, 
   apca131 LIKE apca_t.apca131, 
   apca133 LIKE apca_t.apca133, 
   apca134 LIKE apca_t.apca134, 
   apca136 LIKE apca_t.apca136, 
   apca137 LIKE apca_t.apca137, 
   apca138 LIKE apca_t.apca138, 
   apcacomp LIKE apca_t.apcacomp, 
   apcadocdt LIKE apca_t.apcadocdt, 
   apcadocno LIKE apca_t.apcadocno, 
   apcaent LIKE apca_t.apcaent, 
   apcald LIKE apca_t.apcald, 
   apcasite LIKE apca_t.apcasite, 
   apcastus LIKE apca_t.apcastus, 
   apcb001 LIKE apcb_t.apcb001, 
   apcb002 LIKE apcb_t.apcb002, 
   apcb003 LIKE apcb_t.apcb003, 
   apcb004 LIKE apcb_t.apcb004, 
   apcb005 LIKE apcb_t.apcb005, 
   apcb006 LIKE apcb_t.apcb006, 
   apcb007 LIKE apcb_t.apcb007, 
   apcb008 LIKE apcb_t.apcb008, 
   apcb009 LIKE apcb_t.apcb009, 
   apcb010 LIKE apcb_t.apcb010, 
   apcb011 LIKE apcb_t.apcb011, 
   apcb012 LIKE apcb_t.apcb012, 
   apcb013 LIKE apcb_t.apcb013, 
   apcb014 LIKE apcb_t.apcb014, 
   apcb015 LIKE apcb_t.apcb015, 
   apcb016 LIKE apcb_t.apcb016, 
   apcb017 LIKE apcb_t.apcb017, 
   apcb018 LIKE apcb_t.apcb018, 
   apcb019 LIKE apcb_t.apcb019, 
   apcb020 LIKE apcb_t.apcb020, 
   apcb021 LIKE apcb_t.apcb021, 
   apcb022 LIKE apcb_t.apcb022, 
   apcb023 LIKE apcb_t.apcb023, 
   apcb024 LIKE apcb_t.apcb024, 
   apcb025 LIKE apcb_t.apcb025, 
   apcb026 LIKE apcb_t.apcb026, 
   apcb028 LIKE apcb_t.apcb028, 
   apcb029 LIKE apcb_t.apcb029, 
   apcb100 LIKE apcb_t.apcb100, 
   apcb101 LIKE apcb_t.apcb101, 
   apcb103 LIKE apcb_t.apcb103, 
   apcb104 LIKE apcb_t.apcb104, 
   apcb105 LIKE apcb_t.apcb105, 
   apcb106 LIKE apcb_t.apcb106, 
   apcb108 LIKE apcb_t.apcb108, 
   apcb111 LIKE apcb_t.apcb111, 
   apcb113 LIKE apcb_t.apcb113, 
   apcb114 LIKE apcb_t.apcb114, 
   apcb115 LIKE apcb_t.apcb115, 
   apcb116 LIKE apcb_t.apcb116, 
   apcb117 LIKE apcb_t.apcb117, 
   apcb118 LIKE apcb_t.apcb118, 
   apcb119 LIKE apcb_t.apcb119, 
   apcb123 LIKE apcb_t.apcb123, 
   apcb124 LIKE apcb_t.apcb124, 
   apcb125 LIKE apcb_t.apcb125, 
   apcb126 LIKE apcb_t.apcb126, 
   apcb128 LIKE apcb_t.apcb128, 
   apcb133 LIKE apcb_t.apcb133, 
   apcb134 LIKE apcb_t.apcb134, 
   apcb135 LIKE apcb_t.apcb135, 
   apcb136 LIKE apcb_t.apcb136, 
   apcb138 LIKE apcb_t.apcb138, 
   apcblegl LIKE apcb_t.apcblegl, 
   apcborga LIKE apcb_t.apcborga, 
   apcbseq LIKE apcb_t.apcbseq, 
   apcbsite LIKE apcb_t.apcbsite, 
   oofa_t_oofa011 LIKE oofa_t.oofa011, 
   t1_oofa011 LIKE oofa_t.oofa011, 
   pmaal_t_pmaal004 LIKE pmaal_t.pmaal004, 
   t8_pmaal004 LIKE pmaal_t.pmaal004, 
   oocql_t_oocql004 LIKE oocql_t.oocql004, 
   t5_oocql004 LIKE oocql_t.oocql004, 
   t6_oocql004 LIKE oocql_t.oocql004, 
   ooibl_t_ooibl004 LIKE ooibl_t.ooibl004, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   t2_ooefl003 LIKE ooefl_t.ooefl003, 
   t3_ooefl003 LIKE ooefl_t.ooefl003, 
   t7_ooefl003 LIKE ooefl_t.ooefl003, 
   glacl_t_glacl004 LIKE glacl_t.glacl004, 
   t4_glacl004 LIKE glacl_t.glacl004, 
   ooidl_t_ooidl003 LIKE ooidl_t.ooidl003, 
   bgaal_t_bgaal003 LIKE bgaal_t.bgaal003, 
   glaal_t_glaal002 LIKE glaal_t.glaal002, 
   x_oodbl_t_oodbl004 LIKE oodbl_t.oodbl004
 END RECORD
DEFINE l_cnt           INTEGER
#add-point:ins_data段define

#end add-point
 
    #add-point:ins_data段before
    
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH axmr402_g01_curs INTO sr_s.*
       IF STATUS THEN
          CALL cl_err('foreach:',STATUS,1)
          EXIT FOREACH
       END IF
 
       #add-point:ins_data段foreach
       
       #end add-point
 
       #add-point:ins_data段before_arr
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].apca001 = sr_s.apca001
       LET sr[l_cnt].apca003 = sr_s.apca003
       LET sr[l_cnt].apca004 = sr_s.apca004
       LET sr[l_cnt].apca005 = sr_s.apca005
       LET sr[l_cnt].apca006 = sr_s.apca006
       LET sr[l_cnt].apca007 = sr_s.apca007
       LET sr[l_cnt].apca008 = sr_s.apca008
       LET sr[l_cnt].apca009 = sr_s.apca009
       LET sr[l_cnt].apca010 = sr_s.apca010
       LET sr[l_cnt].apca011 = sr_s.apca011
       LET sr[l_cnt].apca012 = sr_s.apca012
       LET sr[l_cnt].apca013 = sr_s.apca013
       LET sr[l_cnt].apca014 = sr_s.apca014
       LET sr[l_cnt].apca015 = sr_s.apca015
       LET sr[l_cnt].apca016 = sr_s.apca016
       LET sr[l_cnt].apca017 = sr_s.apca017
       LET sr[l_cnt].apca018 = sr_s.apca018
       LET sr[l_cnt].apca019 = sr_s.apca019
       LET sr[l_cnt].apca020 = sr_s.apca020
       LET sr[l_cnt].apca021 = sr_s.apca021
       LET sr[l_cnt].apca022 = sr_s.apca022
       LET sr[l_cnt].apca025 = sr_s.apca025
       LET sr[l_cnt].apca026 = sr_s.apca026
       LET sr[l_cnt].apca027 = sr_s.apca027
       LET sr[l_cnt].apca028 = sr_s.apca028
       LET sr[l_cnt].apca029 = sr_s.apca029
       LET sr[l_cnt].apca030 = sr_s.apca030
       LET sr[l_cnt].apca031 = sr_s.apca031
       LET sr[l_cnt].apca033 = sr_s.apca033
       LET sr[l_cnt].apca034 = sr_s.apca034
       LET sr[l_cnt].apca035 = sr_s.apca035
       LET sr[l_cnt].apca036 = sr_s.apca036
       LET sr[l_cnt].apca037 = sr_s.apca037
       LET sr[l_cnt].apca038 = sr_s.apca038
       LET sr[l_cnt].apca039 = sr_s.apca039
       LET sr[l_cnt].apca046 = sr_s.apca046
       LET sr[l_cnt].apca047 = sr_s.apca047
       LET sr[l_cnt].apca048 = sr_s.apca048
       LET sr[l_cnt].apca049 = sr_s.apca049
       LET sr[l_cnt].apca050 = sr_s.apca050
       LET sr[l_cnt].apca051 = sr_s.apca051
       LET sr[l_cnt].apca052 = sr_s.apca052
       LET sr[l_cnt].apca053 = sr_s.apca053
       LET sr[l_cnt].apca054 = sr_s.apca054
       LET sr[l_cnt].apca055 = sr_s.apca055
       LET sr[l_cnt].apca056 = sr_s.apca056
       LET sr[l_cnt].apca057 = sr_s.apca057
       LET sr[l_cnt].apca058 = sr_s.apca058
       LET sr[l_cnt].apca059 = sr_s.apca059
       LET sr[l_cnt].apca060 = sr_s.apca060
       LET sr[l_cnt].apca061 = sr_s.apca061
       LET sr[l_cnt].apca062 = sr_s.apca062
       LET sr[l_cnt].apca063 = sr_s.apca063
       LET sr[l_cnt].apca100 = sr_s.apca100
       LET sr[l_cnt].apca101 = sr_s.apca101
       LET sr[l_cnt].apca103 = sr_s.apca103
       LET sr[l_cnt].apca104 = sr_s.apca104
       LET sr[l_cnt].apca106 = sr_s.apca106
       LET sr[l_cnt].apca107 = sr_s.apca107
       LET sr[l_cnt].apca108 = sr_s.apca108
       LET sr[l_cnt].apca113 = sr_s.apca113
       LET sr[l_cnt].apca114 = sr_s.apca114
       LET sr[l_cnt].apca116 = sr_s.apca116
       LET sr[l_cnt].apca117 = sr_s.apca117
       LET sr[l_cnt].apca118 = sr_s.apca118
       LET sr[l_cnt].apca120 = sr_s.apca120
       LET sr[l_cnt].apca121 = sr_s.apca121
       LET sr[l_cnt].apca123 = sr_s.apca123
       LET sr[l_cnt].apca124 = sr_s.apca124
       LET sr[l_cnt].apca126 = sr_s.apca126
       LET sr[l_cnt].apca127 = sr_s.apca127
       LET sr[l_cnt].apca128 = sr_s.apca128
       LET sr[l_cnt].apca130 = sr_s.apca130
       LET sr[l_cnt].apca131 = sr_s.apca131
       LET sr[l_cnt].apca133 = sr_s.apca133
       LET sr[l_cnt].apca134 = sr_s.apca134
       LET sr[l_cnt].apca136 = sr_s.apca136
       LET sr[l_cnt].apca137 = sr_s.apca137
       LET sr[l_cnt].apca138 = sr_s.apca138
       LET sr[l_cnt].apcacomp = sr_s.apcacomp
       LET sr[l_cnt].apcadocdt = sr_s.apcadocdt
       LET sr[l_cnt].apcadocno = sr_s.apcadocno
       LET sr[l_cnt].apcaent = sr_s.apcaent
       LET sr[l_cnt].apcald = sr_s.apcald
       LET sr[l_cnt].apcasite = sr_s.apcasite
       LET sr[l_cnt].apcastus = sr_s.apcastus
       LET sr[l_cnt].apcb001 = sr_s.apcb001
       LET sr[l_cnt].apcb002 = sr_s.apcb002
       LET sr[l_cnt].apcb003 = sr_s.apcb003
       LET sr[l_cnt].apcb004 = sr_s.apcb004
       LET sr[l_cnt].apcb005 = sr_s.apcb005
       LET sr[l_cnt].apcb006 = sr_s.apcb006
       LET sr[l_cnt].apcb007 = sr_s.apcb007
       LET sr[l_cnt].apcb008 = sr_s.apcb008
       LET sr[l_cnt].apcb009 = sr_s.apcb009
       LET sr[l_cnt].apcb010 = sr_s.apcb010
       LET sr[l_cnt].apcb011 = sr_s.apcb011
       LET sr[l_cnt].apcb012 = sr_s.apcb012
       LET sr[l_cnt].apcb013 = sr_s.apcb013
       LET sr[l_cnt].apcb014 = sr_s.apcb014
       LET sr[l_cnt].apcb015 = sr_s.apcb015
       LET sr[l_cnt].apcb016 = sr_s.apcb016
       LET sr[l_cnt].apcb017 = sr_s.apcb017
       LET sr[l_cnt].apcb018 = sr_s.apcb018
       LET sr[l_cnt].apcb019 = sr_s.apcb019
       LET sr[l_cnt].apcb020 = sr_s.apcb020
       LET sr[l_cnt].apcb021 = sr_s.apcb021
       LET sr[l_cnt].apcb022 = sr_s.apcb022
       LET sr[l_cnt].apcb023 = sr_s.apcb023
       LET sr[l_cnt].apcb024 = sr_s.apcb024
       LET sr[l_cnt].apcb025 = sr_s.apcb025
       LET sr[l_cnt].apcb026 = sr_s.apcb026
       LET sr[l_cnt].apcb028 = sr_s.apcb028
       LET sr[l_cnt].apcb029 = sr_s.apcb029
       LET sr[l_cnt].apcb100 = sr_s.apcb100
       LET sr[l_cnt].apcb101 = sr_s.apcb101
       LET sr[l_cnt].apcb103 = sr_s.apcb103
       LET sr[l_cnt].apcb104 = sr_s.apcb104
       LET sr[l_cnt].apcb105 = sr_s.apcb105
       LET sr[l_cnt].apcb106 = sr_s.apcb106
       LET sr[l_cnt].apcb108 = sr_s.apcb108
       LET sr[l_cnt].apcb111 = sr_s.apcb111
       LET sr[l_cnt].apcb113 = sr_s.apcb113
       LET sr[l_cnt].apcb114 = sr_s.apcb114
       LET sr[l_cnt].apcb115 = sr_s.apcb115
       LET sr[l_cnt].apcb116 = sr_s.apcb116
       LET sr[l_cnt].apcb117 = sr_s.apcb117
       LET sr[l_cnt].apcb118 = sr_s.apcb118
       LET sr[l_cnt].apcb119 = sr_s.apcb119
       LET sr[l_cnt].apcb123 = sr_s.apcb123
       LET sr[l_cnt].apcb124 = sr_s.apcb124
       LET sr[l_cnt].apcb125 = sr_s.apcb125
       LET sr[l_cnt].apcb126 = sr_s.apcb126
       LET sr[l_cnt].apcb128 = sr_s.apcb128
       LET sr[l_cnt].apcb133 = sr_s.apcb133
       LET sr[l_cnt].apcb134 = sr_s.apcb134
       LET sr[l_cnt].apcb135 = sr_s.apcb135
       LET sr[l_cnt].apcb136 = sr_s.apcb136
       LET sr[l_cnt].apcb138 = sr_s.apcb138
       LET sr[l_cnt].apcblegl = sr_s.apcblegl
       LET sr[l_cnt].apcborga = sr_s.apcborga
       LET sr[l_cnt].apcbseq = sr_s.apcbseq
       LET sr[l_cnt].apcbsite = sr_s.apcbsite
       LET sr[l_cnt].oofa_t_oofa011 = sr_s.oofa_t_oofa011
       LET sr[l_cnt].t1_oofa011 = sr_s.t1_oofa011
       LET sr[l_cnt].pmaal_t_pmaal004 = sr_s.pmaal_t_pmaal004
       LET sr[l_cnt].t8_pmaal004 = sr_s.t8_pmaal004
       LET sr[l_cnt].oocql_t_oocql004 = sr_s.oocql_t_oocql004
       LET sr[l_cnt].t5_oocql004 = sr_s.t5_oocql004
       LET sr[l_cnt].t6_oocql004 = sr_s.t6_oocql004
       LET sr[l_cnt].ooibl_t_ooibl004 = sr_s.ooibl_t_ooibl004
       LET sr[l_cnt].ooefl_t_ooefl003 = sr_s.ooefl_t_ooefl003
       LET sr[l_cnt].t2_ooefl003 = sr_s.t2_ooefl003
       LET sr[l_cnt].t3_ooefl003 = sr_s.t3_ooefl003
       LET sr[l_cnt].t7_ooefl003 = sr_s.t7_ooefl003
       LET sr[l_cnt].glacl_t_glacl004 = sr_s.glacl_t_glacl004
       LET sr[l_cnt].t4_glacl004 = sr_s.t4_glacl004
       LET sr[l_cnt].ooidl_t_ooidl003 = sr_s.ooidl_t_ooidl003
       LET sr[l_cnt].bgaal_t_bgaal003 = sr_s.bgaal_t_bgaal003
       LET sr[l_cnt].glaal_t_glaal002 = sr_s.glaal_t_glaal002
       LET sr[l_cnt].x_oodbl_t_oodbl004 = sr_s.x_oodbl_t_oodbl004
 
 
       #add-point:ins_data段after_arr
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axmr402_g01.rep_data" >}
PRIVATE FUNCTION axmr402_g01_rep_data()
DEFINE HANDLER         om.SaxDocumentHandler
DEFINE l_cnt           LIKE type_t.num10
DEFINE l_i             INTEGER
 
    LET l_cnt = sr.getLength()
    IF l_cnt <= 0 THEN RETURN END IF
    #CALL cl_gr_init_apr()                          #t100先不用
    WHILE TRUE
        CALL cl_gr_init_pageheader()               
        LET handler = cl_gr_handler()
        IF handler IS NOT NULL THEN
            START REPORT axmr402_g01_rep TO XML HANDLER handler
            FOR l_i = 1 TO sr.getLength()
                OUTPUT TO REPORT axmr402_g01_rep(sr[l_i].*)
            END FOR
            FINISH REPORT axmr402_g01_rep
        END IF
        IF INT_FLAG = TRUE THEN
            LET INT_FLAG = FALSE
            EXIT WHILE
        END IF
    END WHILE
END FUNCTION
 
{</section>}
 
{<section id="axmr402_g01.rep" >}
PRIVATE REPORT axmr402_g01_rep(sr1)
DEFINE sr1 sr1_r
DEFINE sr2 sr2_r
#add-point:rep段define

#end add-point
 
    ORDER  BY sr1.apcadocno,sr1.apcbseq
    
    FORMAT
        FIRST PAGE HEADER
 
            #add-point:rep.header  #公司資訊(不在公用變數內)
            
            #end add-point:rep.header
            PRINTX g_grPageHeader.*
            PRINTX g_user,g_pdate,g_prog,g_company,g_ptime,g_user_name
            PRINTX tm.*
 
            #讀取beforeGrup子樣板+子報表樣板
        BEFORE GROUP OF sr1.apcadocno
            CALL cl_gr_init_apr(sr1.apcadocno)
            #add-point:rep.apr.signstr
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.apcadocno.before
           
           #end add-point:
 
           #add-point:rep.sub01.before
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooffent = '", 
                sr1.apcaent CLIPPED ,"'", " AND  ooff002 = '", sr1.apcadocno CLIPPED ,"'"
 
           START REPORT axmr402_g01_subrep01
           DECLARE axmr402_g01_repcur01 CURSOR FROM g_sql
           FOREACH axmr402_g01_repcur01 INTO sr2.*
              IF STATUS THEN CALL cl_err('axmr402_g01_repcur01:',STATUS,1) EXIT FOREACH END IF
              #add-point:rep.sub01.foreach
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT axmr402_g01_subrep01(sr2.*)
              END FOREACH
           FINISH REPORT axmr402_g01_subrep01
           #add-point:rep.sub01.after
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.apcadocno.after
           
           #end add-point:
 
 
        BEFORE GROUP OF sr1.apcbseq
 
           #add-point:rep.b_group.apcbseq.before
           
           #end add-point:
 
 
           #add-point:rep.b_group.apcbseq.after
           
           #end add-point:
 
 
 
 
        ON EVERY ROW
            #add-point:rep.everyrow.before
            
            #end add-point:rep.everyrow.before
 
             #單身前備註
             #add-point:rep.sub02.before
           
           #end add-point:rep.sub02.before
 
           #add-point:rep.sub02.sql
           
           #end add-point:rep.sub02.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='2' AND ooffent = '", 
                sr1.apcaent CLIPPED ,"'", " AND  ooff002 = '", sr1.apcadocno CLIPPED ,"'", " AND  ooff003 = '", 
                sr1.apcbseq CLIPPED ,"'"
 
           START REPORT axmr402_g01_subrep02
           DECLARE axmr402_g01_repcur02 CURSOR FROM g_sql
           FOREACH axmr402_g01_repcur02 INTO sr2.*
              IF STATUS THEN CALL cl_err('axmr402_g01_repcur02:',STATUS,1) EXIT FOREACH END IF
              #add-point:rep.sub02.foreach
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT axmr402_g01_subrep02(sr2.*)
              END FOREACH
           FINISH REPORT axmr402_g01_subrep02
           #add-point:rep.sub02.after
           
           #end add-point:rep.sub02.after
 
 
 
            #add-point:rep.everyrow.beforerow
            
            #end add-point:rep.everyrow.beforerow
 
            PRINTX sr1.*
 
            #add-point:rep.everyrow.afterrow
            
            #end add-point:rep.everyrow.afterrow
 
             #單身後備註
             #add-point:rep.sub03.before
           
           #end add-point:rep.sub03.before
 
           #add-point:rep.sub03.sql
           
           #end add-point:rep.sub03.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooffent = '", 
                sr1.apcaent CLIPPED ,"'", " AND  ooff002 = '", sr1.apcadocno CLIPPED ,"'", " AND  ooff003 = '", 
                sr1.apcbseq CLIPPED ,"'"
 
           START REPORT axmr402_g01_subrep03
           DECLARE axmr402_g01_repcur03 CURSOR FROM g_sql
           FOREACH axmr402_g01_repcur03 INTO sr2.*
              IF STATUS THEN CALL cl_err('axmr402_g01_repcur03:',STATUS,1) EXIT FOREACH END IF
              #add-point:rep.sub03.foreach
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT axmr402_g01_subrep03(sr2.*)
              END FOREACH
           FINISH REPORT axmr402_g01_subrep03
           #add-point:rep.sub03.after
           
           #end add-point:rep.sub03.after
 
 
 
            #add-point:rep.everyrow.after
            
            #end add-point:rep.everyrow.after        
 
        #讀取afterGrup子樣板+子報表樣板
        AFTER GROUP OF sr1.apcadocno
 
           #add-point:rep.a_group.apcadocno.before
           
           #end add-point:
 
           #add-point:rep.sub04.before
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooffent = '", 
                sr1.apcaent CLIPPED ,"'", " AND  ooff002 = '", sr1.apcadocno CLIPPED ,"'"
 
           START REPORT axmr402_g01_subrep04
           DECLARE axmr402_g01_repcur04 CURSOR FROM g_sql
           FOREACH axmr402_g01_repcur04 INTO sr2.*
              IF STATUS THEN CALL cl_err('axmr402_g01_repcur04:',STATUS,1) EXIT FOREACH END IF
              #add-point:rep.sub04.foreach
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT axmr402_g01_subrep04(sr2.*)
              END FOREACH
           FINISH REPORT axmr402_g01_subrep04
           #add-point:rep.sub04.after
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.apcadocno.after
           
           #end add-point:
 
 
        AFTER GROUP OF sr1.apcbseq
 
           #add-point:rep.a_group.apcbseq.before
           
           #end add-point:
 
 
           #add-point:rep.a_group.apcbseq.after
           
           #end add-point:
 
 
 
        ON LAST ROW
            #add-point:rep.lastrow.before  
                    
            #edn add point :rep.lastrow.before
 
            #add-point:rep.lastrow.after
            
            #edn add point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="axmr402_g01.subrep_str" >}
#讀取子報表樣板
PRIVATE REPORT axmr402_g01_subrep01(sr2)
DEFINE  sr2  sr2_r
#add-point:sub01.define

#end add-point:sub01.define
 
    #add-point:sub01.order.before
    
    #end add-point:sub01.order.before
 
 
 
    FORMAT
 
 
 
       ON EVERY ROW
            #add-point:sub01.everyrow.before
                          
            #end add-point:sub01.everyrow.before
 
            PRINTX sr2.*
 
            #add-point:sub01.everyrow.after
            
            #end add-point:sub01.everyrow.after
 
 
END REPORT
 
 
PRIVATE REPORT axmr402_g01_subrep02(sr2)
DEFINE  sr2  sr2_r
#add-point:sub02.define

#end add-point:sub02.define
 
    #add-point:sub02.order.before
    
    #end add-point:sub02.order.before
 
 
 
    FORMAT
 
 
 
       ON EVERY ROW
            #add-point:sub02.everyrow.before
                          
            #end add-point:sub02.everyrow.before
 
            PRINTX sr2.*
 
            #add-point:sub02.everyrow.after
            
            #end add-point:sub02.everyrow.after
 
 
END REPORT
 
 
PRIVATE REPORT axmr402_g01_subrep03(sr2)
DEFINE  sr2  sr2_r
#add-point:sub03.define

#end add-point:sub03.define
 
    #add-point:sub03.order.before
    
    #end add-point:sub03.order.before
 
 
 
    FORMAT
 
 
 
       ON EVERY ROW
            #add-point:sub03.everyrow.before
                          
            #end add-point:sub03.everyrow.before
 
            PRINTX sr2.*
 
            #add-point:sub03.everyrow.after
            
            #end add-point:sub03.everyrow.after
 
 
END REPORT
 
 
PRIVATE REPORT axmr402_g01_subrep04(sr2)
DEFINE  sr2  sr2_r
#add-point:sub04.define

#end add-point:sub04.define
 
    #add-point:sub04.order.before
    
    #end add-point:sub04.order.before
 
 
 
    FORMAT
 
 
 
       ON EVERY ROW
            #add-point:sub04.everyrow.before
                          
            #end add-point:sub04.everyrow.before
 
            PRINTX sr2.*
 
            #add-point:sub04.everyrow.after
            
            #end add-point:sub04.everyrow.after
 
 
END REPORT
 
 
 
 
{</section>}
 
{<section id="axmr402_g01.other_function" >}

 
{</section>}
 
{<section id="axmr402_g01.other_report" >}

 
{</section>}
 
