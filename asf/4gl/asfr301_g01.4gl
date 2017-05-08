#該程式未解開Section, 採用最新樣板產出!
{<section id="asfr301_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2016-04-08 11:37:47), PR版次:0002(2016-04-08 11:39:52)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000090
#+ Filename...: asfr301_g01
#+ Description: ...
#+ Creator....: 05384(2014-07-02 10:38:05)
#+ Modifier...: 04441 -SD/PR- 04441
 
{</section>}
 
{<section id="asfr301_g01.global" readonly="Y" >}
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
   sfca004 LIKE sfca_t.sfca004, 
   sfcb012 LIKE sfcb_t.sfcb012, 
   sfcb032 LIKE sfcb_t.sfcb032, 
   sfca002 LIKE sfca_t.sfca002, 
   sfcb011 LIKE sfcb_t.sfcb011, 
   sfcb017 LIKE sfcb_t.sfcb017, 
   sfcb018 LIKE sfcb_t.sfcb018, 
   sfcb009 LIKE sfcb_t.sfcb009, 
   sfcb016 LIKE sfcb_t.sfcb016, 
   sfcb023 LIKE sfcb_t.sfcb023, 
   sfcb043 LIKE sfcb_t.sfcb043, 
   sfcb026 LIKE sfcb_t.sfcb026, 
   sfcb006 LIKE sfcb_t.sfcb006, 
   sfca005 LIKE sfca_t.sfca005, 
   sfcb003 LIKE sfcb_t.sfcb003, 
   sfcb041 LIKE sfcb_t.sfcb041, 
   sfcb042 LIKE sfcb_t.sfcb042, 
   sfcb045 LIKE sfcb_t.sfcb045, 
   sfcb048 LIKE sfcb_t.sfcb048, 
   sfca003 LIKE sfca_t.sfca003, 
   sfcb004 LIKE sfcb_t.sfcb004, 
   sfcb007 LIKE sfcb_t.sfcb007, 
   sfcb010 LIKE sfcb_t.sfcb010, 
   sfcb019 LIKE sfcb_t.sfcb019, 
   sfcb028 LIKE sfcb_t.sfcb028, 
   sfcb031 LIKE sfcb_t.sfcb031, 
   sfcb033 LIKE sfcb_t.sfcb033, 
   sfcb039 LIKE sfcb_t.sfcb039, 
   sfcb050 LIKE sfcb_t.sfcb050, 
   sfcb021 LIKE sfcb_t.sfcb021, 
   sfcb052 LIKE sfcb_t.sfcb052, 
   sfca001 LIKE sfca_t.sfca001, 
   sfcasite LIKE sfca_t.sfcasite, 
   sfcb005 LIKE sfcb_t.sfcb005, 
   sfcb008 LIKE sfcb_t.sfcb008, 
   sfcb029 LIKE sfcb_t.sfcb029, 
   sfcb047 LIKE sfcb_t.sfcb047, 
   sfcb055 LIKE sfcb_t.sfcb055, 
   sfcb054 LIKE sfcb_t.sfcb054, 
   sfcadocno LIKE sfca_t.sfcadocno, 
   sfcb002 LIKE sfcb_t.sfcb002, 
   sfcb014 LIKE sfcb_t.sfcb014, 
   sfcb024 LIKE sfcb_t.sfcb024, 
   sfcb025 LIKE sfcb_t.sfcb025, 
   sfcb027 LIKE sfcb_t.sfcb027, 
   sfcb034 LIKE sfcb_t.sfcb034, 
   sfcb040 LIKE sfcb_t.sfcb040, 
   sfcb049 LIKE sfcb_t.sfcb049, 
   sfcb051 LIKE sfcb_t.sfcb051, 
   sfcb020 LIKE sfcb_t.sfcb020, 
   sfcb015 LIKE sfcb_t.sfcb015, 
   sfcb030 LIKE sfcb_t.sfcb030, 
   sfcb036 LIKE sfcb_t.sfcb036, 
   sfcb046 LIKE sfcb_t.sfcb046, 
   sfcb044 LIKE sfcb_t.sfcb044, 
   sfcb053 LIKE sfcb_t.sfcb053, 
   sfcb013 LIKE sfcb_t.sfcb013, 
   sfcb035 LIKE sfcb_t.sfcb035, 
   sfcb037 LIKE sfcb_t.sfcb037, 
   sfcb038 LIKE sfcb_t.sfcb038, 
   sfcb022 LIKE sfcb_t.sfcb022, 
   x_oocql_t_oocql004 LIKE oocql_t.oocql004, 
   x_t1_oocql004 LIKE oocql_t.oocql004, 
   x_t3_oocql004 LIKE oocql_t.oocql004, 
   x_ecaa_t_ecaa002 LIKE ecaa_t.ecaa002, 
   x_pmaal_t_pmaal004 LIKE pmaal_t.pmaal004, 
   x_oocal_t_oocal003 LIKE oocal_t.oocal003, 
   x_t2_oocal003 LIKE oocal_t.oocal003, 
   l_sfcb013_pmaal004 LIKE type_t.chr100, 
   sfcbdocno LIKE sfcb_t.sfcbdocno, 
   sfcbent LIKE sfcb_t.sfcbent, 
   sfcbsite LIKE sfcb_t.sfcbsite, 
   sfcaent LIKE sfca_t.sfcaent, 
   l_sfcb003_desc LIKE type_t.chr1000, 
   l_sfaa010 LIKE sfaa_t.sfaa010, 
   l_imaal003 LIKE imaal_t.imaal003, 
   l_imaal004 LIKE imaal_t.imaal004, 
   l_imaal003_imaal004 LIKE type_t.chr1000, 
   l_sfaa013 LIKE sfaa_t.sfaa013, 
   l_order LIKE type_t.chr30
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
 
{<section id="asfr301_g01.main" readonly="Y" >}
PUBLIC FUNCTION asfr301_g01(p_arg1)
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
   
   LET g_rep_code = "asfr301_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL asfr301_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL asfr301_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL asfr301_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="asfr301_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION asfr301_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
LET g_select = " SELECT sfca004,sfcb012,sfcb032,sfca002,sfcb011,sfcb017,sfcb018,sfcb009,sfcb016,sfcb023, 
       sfcb043,sfcb026,sfcb006,sfca005,sfcb003,sfcb041,sfcb042,sfcb045,sfcb048,sfca003,sfcb004,sfcb007, 
       sfcb010,sfcb019,sfcb028,sfcb031,sfcb033,sfcb039,sfcb050,sfcb021,sfcb052,sfca001,sfcasite,sfcb005, 
       sfcb008,sfcb029,sfcb047,sfcb055,sfcb054,sfcadocno,sfcb002,sfcb014,sfcb024,sfcb025,sfcb027,sfcb034, 
       sfcb040,sfcb049,sfcb051,sfcb020,sfcb015,sfcb030,sfcb036,sfcb046,sfcb044,sfcb053,sfcb013,sfcb035, 
       sfcb037,sfcb038,sfcb022,x.oocql_t_oocql004,x.t1_oocql004,x.t3_oocql004,x.ecaa_t_ecaa002,x.pmaal_t_pmaal004, 
       x.oocal_t_oocal003,x.t2_oocal003,trim(sfcb013)||'.'||trim(x.pmaal_t_pmaal004),sfcbdocno,sfcbent, 
       sfcbsite,sfcaent,'','','','','','',trim(sfcadocno)||trim(TO_CHAR(sfca_t.sfca001,'0000'))"
#   #end add-point
#   LET g_select = " SELECT sfca004,sfcb012,sfcb032,sfca002,sfcb011,sfcb017,sfcb018,sfcb009,sfcb016,sfcb023, 
#       sfcb043,sfcb026,sfcb006,sfca005,sfcb003,sfcb041,sfcb042,sfcb045,sfcb048,sfca003,sfcb004,sfcb007, 
#       sfcb010,sfcb019,sfcb028,sfcb031,sfcb033,sfcb039,sfcb050,sfcb021,sfcb052,sfca001,sfcasite,sfcb005, 
#       sfcb008,sfcb029,sfcb047,sfcb055,sfcb054,sfcadocno,sfcb002,sfcb014,sfcb024,sfcb025,sfcb027,sfcb034, 
#       sfcb040,sfcb049,sfcb051,sfcb020,sfcb015,sfcb030,sfcb036,sfcb046,sfcb044,sfcb053,sfcb013,sfcb035, 
#       sfcb037,sfcb038,sfcb022,x.oocql_t_oocql004,x.t1_oocql004,x.t3_oocql004,x.ecaa_t_ecaa002,x.pmaal_t_pmaal004, 
#       x.oocal_t_oocal003,x.t2_oocal003,trim(sfcb013)||'.'||trim(x.pmaal_t_pmaal004),sfcbdocno,sfcbent, 
#       sfcbsite,sfcaent,'','','','','','',''"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
    LET g_from = " FROM  sfca_t  LEFT OUTER JOIN sfaa_t ON sfaa_t.sfaaent = sfca_t.sfcaent AND sfaa_t.sfaadocno = sfca_t.sfcadocno ",
                 "               LEFT OUTER JOIN ( SELECT sfcb_t.*,oocql_t.oocql004 oocql_t_oocql004, 
        t1.oocql004 t1_oocql004,t3.oocql004 t3_oocql004,ecaa_t.ecaa002 ecaa_t_ecaa002,pmaal_t.pmaal004 pmaal_t_pmaal004, 
        oocal_t.oocal003 oocal_t_oocal003,t2.oocal003 t2_oocal003 FROM sfcb_t             LEFT OUTER JOIN oocql_t ON oocql_t.oocql001 = '221' AND oocql_t.oocql002 = sfcb_t.sfcb003 AND oocql_t.oocqlent = sfcb_t.sfcbent AND oocql_t.oocql003 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN oocql_t t1 ON t1.oocql001 = '221' AND t1.oocql002 = sfcb_t.sfcb007 AND t1.oocqlent = sfcb_t.sfcbent AND t1.oocql003 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN oocal_t ON oocal_t.oocal001 = sfcb_t.sfcb052 AND oocal_t.oocalent = sfcb_t.sfcbent AND oocal_t.oocal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN ecaa_t ON ecaa_t.ecaa001 = sfcb_t.sfcb011 AND ecaa_t.ecaaent = sfcb_t.sfcbent             LEFT OUTER JOIN pmaal_t ON pmaal_t.pmaal001 = sfcb_t.sfcb013 AND pmaal_t.pmaalent = sfcb_t.sfcbent AND pmaal_t.pmaal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN oocal_t t2 ON t2.oocal001 = sfcb_t.sfcb020 AND t2.oocalent = sfcb_t.sfcbent AND t2.oocal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN oocql_t t3 ON t3.oocql001 = '221' AND t3.oocql002 = sfcb_t.sfcb009 AND t3.oocqlent = sfcb_t.sfcbent AND t3.oocql003 = '" , 
        g_dlang,"'" ," ) x  ON sfca_t.sfcaent = x.sfcbent AND sfca_t.sfcasite = x.sfcbsite AND sfca_t.sfcadocno  
        = x.sfcbdocno AND sfca_t.sfca001 = x.sfcb001"
#   #end add-point
#    LET g_from = " FROM  sfca_t  LEFT OUTER JOIN ( SELECT sfcb_t.*,( SELECT oocql004 FROM oocql_t WHERE oocql_t.oocql001 = '221' AND oocql_t.oocql002 = sfcb_t.sfcb003 AND oocql_t.oocqlent = sfcb_t.sfcbent AND oocql_t.oocql003 = '" , 
#        g_dlang,"'" ,") oocql_t_oocql004,( SELECT oocql004 FROM oocql_t t1 WHERE t1.oocql001 = '221' AND t1.oocql002 = sfcb_t.sfcb007 AND t1.oocqlent = sfcb_t.sfcbent AND t1.oocql003 = '" , 
#        g_dlang,"'" ,") t1_oocql004,( SELECT oocql004 FROM oocql_t t3 WHERE t3.oocql001 = '221' AND t3.oocql002 = sfcb_t.sfcb009 AND t3.oocqlent = sfcb_t.sfcbent AND t3.oocql003 = '" , 
#        g_dlang,"'" ,") t3_oocql004,( SELECT ecaa002 FROM ecaa_t WHERE ecaa_t.ecaa001 = sfcb_t.sfcb011 AND ecaa_t.ecaaent = sfcb_t.sfcbent) ecaa_t_ecaa002, 
#        ( SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = sfcb_t.sfcb013 AND pmaal_t.pmaalent = sfcb_t.sfcbent AND pmaal_t.pmaal002 = '" , 
#        g_dlang,"'" ,") pmaal_t_pmaal004,( SELECT oocal003 FROM oocal_t WHERE oocal_t.oocal001 = sfcb_t.sfcb052 AND oocal_t.oocalent = sfcb_t.sfcbent AND oocal_t.oocal002 = '" , 
#        g_dlang,"'" ,") oocal_t_oocal003,( SELECT oocal003 FROM oocal_t t2 WHERE t2.oocal001 = sfcb_t.sfcb020 AND t2.oocalent = sfcb_t.sfcbent AND t2.oocal002 = '" , 
#        g_dlang,"'" ,") t2_oocal003 FROM sfcb_t ) x  ON sfca_t.sfcaent = x.sfcbent AND sfca_t.sfcasite  
#        = x.sfcbsite AND sfca_t.sfcadocno = x.sfcbdocno AND sfca_t.sfca001 = x.sfcb001"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
    LET g_order = " ORDER BY sfcadocno,sfca001,sfcb002"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("sfca_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE asfr301_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE asfr301_g01_curs CURSOR FOR asfr301_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="asfr301_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION asfr301_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   sfca004 LIKE sfca_t.sfca004, 
   sfcb012 LIKE sfcb_t.sfcb012, 
   sfcb032 LIKE sfcb_t.sfcb032, 
   sfca002 LIKE sfca_t.sfca002, 
   sfcb011 LIKE sfcb_t.sfcb011, 
   sfcb017 LIKE sfcb_t.sfcb017, 
   sfcb018 LIKE sfcb_t.sfcb018, 
   sfcb009 LIKE sfcb_t.sfcb009, 
   sfcb016 LIKE sfcb_t.sfcb016, 
   sfcb023 LIKE sfcb_t.sfcb023, 
   sfcb043 LIKE sfcb_t.sfcb043, 
   sfcb026 LIKE sfcb_t.sfcb026, 
   sfcb006 LIKE sfcb_t.sfcb006, 
   sfca005 LIKE sfca_t.sfca005, 
   sfcb003 LIKE sfcb_t.sfcb003, 
   sfcb041 LIKE sfcb_t.sfcb041, 
   sfcb042 LIKE sfcb_t.sfcb042, 
   sfcb045 LIKE sfcb_t.sfcb045, 
   sfcb048 LIKE sfcb_t.sfcb048, 
   sfca003 LIKE sfca_t.sfca003, 
   sfcb004 LIKE sfcb_t.sfcb004, 
   sfcb007 LIKE sfcb_t.sfcb007, 
   sfcb010 LIKE sfcb_t.sfcb010, 
   sfcb019 LIKE sfcb_t.sfcb019, 
   sfcb028 LIKE sfcb_t.sfcb028, 
   sfcb031 LIKE sfcb_t.sfcb031, 
   sfcb033 LIKE sfcb_t.sfcb033, 
   sfcb039 LIKE sfcb_t.sfcb039, 
   sfcb050 LIKE sfcb_t.sfcb050, 
   sfcb021 LIKE sfcb_t.sfcb021, 
   sfcb052 LIKE sfcb_t.sfcb052, 
   sfca001 LIKE sfca_t.sfca001, 
   sfcasite LIKE sfca_t.sfcasite, 
   sfcb005 LIKE sfcb_t.sfcb005, 
   sfcb008 LIKE sfcb_t.sfcb008, 
   sfcb029 LIKE sfcb_t.sfcb029, 
   sfcb047 LIKE sfcb_t.sfcb047, 
   sfcb055 LIKE sfcb_t.sfcb055, 
   sfcb054 LIKE sfcb_t.sfcb054, 
   sfcadocno LIKE sfca_t.sfcadocno, 
   sfcb002 LIKE sfcb_t.sfcb002, 
   sfcb014 LIKE sfcb_t.sfcb014, 
   sfcb024 LIKE sfcb_t.sfcb024, 
   sfcb025 LIKE sfcb_t.sfcb025, 
   sfcb027 LIKE sfcb_t.sfcb027, 
   sfcb034 LIKE sfcb_t.sfcb034, 
   sfcb040 LIKE sfcb_t.sfcb040, 
   sfcb049 LIKE sfcb_t.sfcb049, 
   sfcb051 LIKE sfcb_t.sfcb051, 
   sfcb020 LIKE sfcb_t.sfcb020, 
   sfcb015 LIKE sfcb_t.sfcb015, 
   sfcb030 LIKE sfcb_t.sfcb030, 
   sfcb036 LIKE sfcb_t.sfcb036, 
   sfcb046 LIKE sfcb_t.sfcb046, 
   sfcb044 LIKE sfcb_t.sfcb044, 
   sfcb053 LIKE sfcb_t.sfcb053, 
   sfcb013 LIKE sfcb_t.sfcb013, 
   sfcb035 LIKE sfcb_t.sfcb035, 
   sfcb037 LIKE sfcb_t.sfcb037, 
   sfcb038 LIKE sfcb_t.sfcb038, 
   sfcb022 LIKE sfcb_t.sfcb022, 
   x_oocql_t_oocql004 LIKE oocql_t.oocql004, 
   x_t1_oocql004 LIKE oocql_t.oocql004, 
   x_t3_oocql004 LIKE oocql_t.oocql004, 
   x_ecaa_t_ecaa002 LIKE ecaa_t.ecaa002, 
   x_pmaal_t_pmaal004 LIKE pmaal_t.pmaal004, 
   x_oocal_t_oocal003 LIKE oocal_t.oocal003, 
   x_t2_oocal003 LIKE oocal_t.oocal003, 
   l_sfcb013_pmaal004 LIKE type_t.chr100, 
   sfcbdocno LIKE sfcb_t.sfcbdocno, 
   sfcbent LIKE sfcb_t.sfcbent, 
   sfcbsite LIKE sfcb_t.sfcbsite, 
   sfcaent LIKE sfca_t.sfcaent, 
   l_sfcb003_desc LIKE type_t.chr1000, 
   l_sfaa010 LIKE sfaa_t.sfaa010, 
   l_imaal003 LIKE imaal_t.imaal003, 
   l_imaal004 LIKE imaal_t.imaal004, 
   l_imaal003_imaal004 LIKE type_t.chr1000, 
   l_sfaa013 LIKE sfaa_t.sfaa013, 
   l_order LIKE type_t.chr30
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
    FOREACH asfr301_g01_curs INTO sr_s.*
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
       CALL asfr301_g01_assemble(sr_s.sfcb003,sr_s.x_oocql_t_oocql004,':') RETURNING sr_s.l_sfcb003_desc
       SELECT sfaa010,sfaa013 INTO sr_s.l_sfaa010,sr_s.l_sfaa013
         FROM sfaa_t
        WHERE sfaaent = sr_s.sfcaent
          AND sfaasite = sr_s.sfcasite
          AND sfaadocno = sr_s.sfcadocno
       SELECT imaal003,imaal004 INTO sr_s.l_imaal003,sr_s.l_imaal004
         FROM imaal_t
        WHERE imaal001 = sr_s.l_sfaa010
          AND imaal002 = g_dlang
          AND imaalent = sr_s.sfcaent
       CALL asfr301_g01_assemble(sr_s.l_imaal003,sr_s.l_imaal004,'/') RETURNING sr_s.l_imaal003_imaal004
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].sfca004 = sr_s.sfca004
       LET sr[l_cnt].sfcb012 = sr_s.sfcb012
       LET sr[l_cnt].sfcb032 = sr_s.sfcb032
       LET sr[l_cnt].sfca002 = sr_s.sfca002
       LET sr[l_cnt].sfcb011 = sr_s.sfcb011
       LET sr[l_cnt].sfcb017 = sr_s.sfcb017
       LET sr[l_cnt].sfcb018 = sr_s.sfcb018
       LET sr[l_cnt].sfcb009 = sr_s.sfcb009
       LET sr[l_cnt].sfcb016 = sr_s.sfcb016
       LET sr[l_cnt].sfcb023 = sr_s.sfcb023
       LET sr[l_cnt].sfcb043 = sr_s.sfcb043
       LET sr[l_cnt].sfcb026 = sr_s.sfcb026
       LET sr[l_cnt].sfcb006 = sr_s.sfcb006
       LET sr[l_cnt].sfca005 = sr_s.sfca005
       LET sr[l_cnt].sfcb003 = sr_s.sfcb003
       LET sr[l_cnt].sfcb041 = sr_s.sfcb041
       LET sr[l_cnt].sfcb042 = sr_s.sfcb042
       LET sr[l_cnt].sfcb045 = sr_s.sfcb045
       LET sr[l_cnt].sfcb048 = sr_s.sfcb048
       LET sr[l_cnt].sfca003 = sr_s.sfca003
       LET sr[l_cnt].sfcb004 = sr_s.sfcb004
       LET sr[l_cnt].sfcb007 = sr_s.sfcb007
       LET sr[l_cnt].sfcb010 = sr_s.sfcb010
       LET sr[l_cnt].sfcb019 = sr_s.sfcb019
       LET sr[l_cnt].sfcb028 = sr_s.sfcb028
       LET sr[l_cnt].sfcb031 = sr_s.sfcb031
       LET sr[l_cnt].sfcb033 = sr_s.sfcb033
       LET sr[l_cnt].sfcb039 = sr_s.sfcb039
       LET sr[l_cnt].sfcb050 = sr_s.sfcb050
       LET sr[l_cnt].sfcb021 = sr_s.sfcb021
       LET sr[l_cnt].sfcb052 = sr_s.sfcb052
       LET sr[l_cnt].sfca001 = sr_s.sfca001
       LET sr[l_cnt].sfcasite = sr_s.sfcasite
       LET sr[l_cnt].sfcb005 = sr_s.sfcb005
       LET sr[l_cnt].sfcb008 = sr_s.sfcb008
       LET sr[l_cnt].sfcb029 = sr_s.sfcb029
       LET sr[l_cnt].sfcb047 = sr_s.sfcb047
       LET sr[l_cnt].sfcb055 = sr_s.sfcb055
       LET sr[l_cnt].sfcb054 = sr_s.sfcb054
       LET sr[l_cnt].sfcadocno = sr_s.sfcadocno
       LET sr[l_cnt].sfcb002 = sr_s.sfcb002
       LET sr[l_cnt].sfcb014 = sr_s.sfcb014
       LET sr[l_cnt].sfcb024 = sr_s.sfcb024
       LET sr[l_cnt].sfcb025 = sr_s.sfcb025
       LET sr[l_cnt].sfcb027 = sr_s.sfcb027
       LET sr[l_cnt].sfcb034 = sr_s.sfcb034
       LET sr[l_cnt].sfcb040 = sr_s.sfcb040
       LET sr[l_cnt].sfcb049 = sr_s.sfcb049
       LET sr[l_cnt].sfcb051 = sr_s.sfcb051
       LET sr[l_cnt].sfcb020 = sr_s.sfcb020
       LET sr[l_cnt].sfcb015 = sr_s.sfcb015
       LET sr[l_cnt].sfcb030 = sr_s.sfcb030
       LET sr[l_cnt].sfcb036 = sr_s.sfcb036
       LET sr[l_cnt].sfcb046 = sr_s.sfcb046
       LET sr[l_cnt].sfcb044 = sr_s.sfcb044
       LET sr[l_cnt].sfcb053 = sr_s.sfcb053
       LET sr[l_cnt].sfcb013 = sr_s.sfcb013
       LET sr[l_cnt].sfcb035 = sr_s.sfcb035
       LET sr[l_cnt].sfcb037 = sr_s.sfcb037
       LET sr[l_cnt].sfcb038 = sr_s.sfcb038
       LET sr[l_cnt].sfcb022 = sr_s.sfcb022
       LET sr[l_cnt].x_oocql_t_oocql004 = sr_s.x_oocql_t_oocql004
       LET sr[l_cnt].x_t1_oocql004 = sr_s.x_t1_oocql004
       LET sr[l_cnt].x_t3_oocql004 = sr_s.x_t3_oocql004
       LET sr[l_cnt].x_ecaa_t_ecaa002 = sr_s.x_ecaa_t_ecaa002
       LET sr[l_cnt].x_pmaal_t_pmaal004 = sr_s.x_pmaal_t_pmaal004
       LET sr[l_cnt].x_oocal_t_oocal003 = sr_s.x_oocal_t_oocal003
       LET sr[l_cnt].x_t2_oocal003 = sr_s.x_t2_oocal003
       LET sr[l_cnt].l_sfcb013_pmaal004 = sr_s.l_sfcb013_pmaal004
       LET sr[l_cnt].sfcbdocno = sr_s.sfcbdocno
       LET sr[l_cnt].sfcbent = sr_s.sfcbent
       LET sr[l_cnt].sfcbsite = sr_s.sfcbsite
       LET sr[l_cnt].sfcaent = sr_s.sfcaent
       LET sr[l_cnt].l_sfcb003_desc = sr_s.l_sfcb003_desc
       LET sr[l_cnt].l_sfaa010 = sr_s.l_sfaa010
       LET sr[l_cnt].l_imaal003 = sr_s.l_imaal003
       LET sr[l_cnt].l_imaal004 = sr_s.l_imaal004
       LET sr[l_cnt].l_imaal003_imaal004 = sr_s.l_imaal003_imaal004
       LET sr[l_cnt].l_sfaa013 = sr_s.l_sfaa013
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
 
{<section id="asfr301_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION asfr301_g01_rep_data()
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
          START REPORT asfr301_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT asfr301_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT asfr301_g01_rep
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
 
{<section id="asfr301_g01.rep" readonly="Y" >}
PRIVATE REPORT asfr301_g01_rep(sr1)
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

#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER  BY sr1.l_order,sr1.sfcb002
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
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            CALL cl_gr_init_apr(sr1.sfcadocno)
#            #end add-point:rep.header 
#            LET g_rep_docno = sr1.l_order
#            CALL cl_gr_init_pageheader() #表頭資訊
#            PRINTX g_grPageHeader.*
#            PRINTX g_grPageFooter.*
#            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'sfcaent=' ,sr1.sfcaent,'{+}sfcadocno=' ,sr1.sfcadocno,'{+}sfca001=' ,sr1.sfca001         
            CALL cl_gr_init_apr(sr1.l_order)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.l_order.before name="rep.b_group.l_order.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooffent = '", 
                sr1.sfcaent CLIPPED ,"'", " AND  ooff002 = '", sr1.sfcadocno CLIPPED ,"'", " AND  ooff003 = '", sr1.sfca001 CLIPPED ,"'"
#           #end add-point:rep.sub01.sql
# 
#           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
#                sr1.sfcaent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_order CLIPPED ,"'"
# 
#           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE asfr301_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE asfr301_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT asfr301_g01_subrep01
           DECLARE asfr301_g01_repcur01 CURSOR FROM g_sql
           FOREACH asfr301_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "asfr301_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT asfr301_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT asfr301_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.l_order.after name="rep.b_group.l_order.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.sfcb002
 
           #add-point:rep.b_group.sfcb002.before name="rep.b_group.sfcb002.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.sfcb002.after name="rep.b_group.sfcb002.after"
           
           #end add-point:
 
 
 
 
       ON EVERY ROW
          #add-point:rep.everyrow.before name="rep.everyrow.before"
          
          #end add-point:rep.everyrow.before
 
          #單身前備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub02.before name="rep.sub02.before"
           
           #end add-point:rep.sub02.before
 
           #add-point:rep.sub02.sql name="rep.sub02.sql"
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='2' AND ooffent = '", 
                sr1.sfcaent CLIPPED ,"'", " AND  ooff002 = '", sr1.sfcadocno CLIPPED ,"'", " AND  ooff003 = '", 
                sr1.sfca001 CLIPPED ,"'", " AND  ooff004 = '", sr1.sfcb002 CLIPPED ,"'"
#           #end add-point:rep.sub02.sql
# 
#           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='2' AND ooffent = '", 
#                sr1.sfcaent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_order CLIPPED ,"'", " AND  ooff004 = ", 
#                sr1.sfcb002 CLIPPED ,""
# 
#           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE asfr301_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE asfr301_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT asfr301_g01_subrep02
           DECLARE asfr301_g01_repcur02 CURSOR FROM g_sql
           FOREACH asfr301_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "asfr301_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT asfr301_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT asfr301_g01_subrep02
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
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooffent = '", 
                sr1.sfcaent CLIPPED ,"'", " AND  ooff002 = '", sr1.sfcadocno CLIPPED ,"'", " AND  ooff003 = '", 
                sr1.sfca001 CLIPPED ,"'", " AND  ooff004 = '", sr1.sfcb002 CLIPPED ,"'"
#           #end add-point:rep.sub03.sql
# 
#           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooffent = '", 
#                sr1.sfcaent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_order CLIPPED ,"'", " AND  ooff004 = ", 
#                sr1.sfcb002 CLIPPED ,""
# 
#           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE asfr301_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE asfr301_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT asfr301_g01_subrep03
           DECLARE asfr301_g01_repcur03 CURSOR FROM g_sql
           FOREACH asfr301_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "asfr301_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT asfr301_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT asfr301_g01_subrep03
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
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooffent = '", 
                sr1.sfcaent CLIPPED ,"'", " AND  ooff002 = '", sr1.sfcadocno CLIPPED ,"'", " AND  ooff003 = '", sr1.sfca001 CLIPPED ,"'"
#           #end add-point:rep.sub04.sql
# 
#           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
#                sr1.sfcaent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_order CLIPPED ,"'"
# 
#           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE asfr301_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE asfr301_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT asfr301_g01_subrep04
           DECLARE asfr301_g01_repcur04 CURSOR FROM g_sql
           FOREACH asfr301_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "asfr301_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT asfr301_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT asfr301_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.l_order.after name="rep.a_group.l_order.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.sfcb002
 
           #add-point:rep.a_group.sfcb002.before name="rep.a_group.sfcb002.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.sfcb002.after name="rep.a_group.sfcb002.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="asfr301_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT asfr301_g01_subrep01(sr2)
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
PRIVATE REPORT asfr301_g01_subrep02(sr2)
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
PRIVATE REPORT asfr301_g01_subrep03(sr2)
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
PRIVATE REPORT asfr301_g01_subrep04(sr2)
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
 
{<section id="asfr301_g01.other_function" readonly="Y" >}

PRIVATE FUNCTION asfr301_g01_assemble(p_str1,p_str2,p_mid)
DEFINE p_str1  STRING
DEFINE p_str2  STRING
DEFINE r_assemble STRING
DEFINE p_mid   LIKE type_t.chr1
   IF cl_null(p_str1) OR cl_null(p_str2) THEN
      LET r_assemble = p_str1 , p_mid , p_str2
   ELSE
      LET r_assemble = p_str1 || p_mid || p_str2
   END IF
   IF cl_null(p_str1) AND cl_null(p_str2) THEN
      INITIALIZE r_assemble TO NULL
   END IF
   RETURN r_assemble
END FUNCTION

 
{</section>}
 
{<section id="asfr301_g01.other_report" readonly="Y" >}
{<point name="other.report"/>}
 
{</section>}
 
