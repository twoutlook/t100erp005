#該程式未解開Section, 採用最新樣板產出!
{<section id="axmr440_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:5(2016-11-09 12:46:17), PR版次:0005(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000138
#+ Filename...: axmr440_g01
#+ Description: ...
#+ Creator....: 05229(2014-05-05 14:25:32)
#+ Modifier...: 08992 -SD/PR- 00000
 
{</section>}
 
{<section id="axmr440_g01.global" readonly="Y" >}
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
   xmdx000 LIKE xmdx_t.xmdx000, 
   xmdx001 LIKE xmdx_t.xmdx001, 
   xmdx002 LIKE xmdx_t.xmdx002, 
   xmdx003 LIKE xmdx_t.xmdx003, 
   xmdx004 LIKE xmdx_t.xmdx004, 
   xmdx005 LIKE xmdx_t.xmdx005, 
   xmdx006 LIKE xmdx_t.xmdx006, 
   xmdx007 LIKE xmdx_t.xmdx007, 
   xmdx008 LIKE xmdx_t.xmdx008, 
   xmdx009 LIKE xmdx_t.xmdx009, 
   xmdx010 LIKE xmdx_t.xmdx010, 
   xmdx011 LIKE xmdx_t.xmdx011, 
   xmdx012 LIKE xmdx_t.xmdx012, 
   xmdx014 LIKE xmdx_t.xmdx014, 
   xmdx015 LIKE xmdx_t.xmdx015, 
   xmdx016 LIKE xmdx_t.xmdx016, 
   xmdx017 LIKE xmdx_t.xmdx017, 
   xmdx018 LIKE xmdx_t.xmdx018, 
   xmdx019 LIKE xmdx_t.xmdx019, 
   xmdx020 LIKE xmdx_t.xmdx020, 
   xmdx030 LIKE xmdx_t.xmdx030, 
   xmdxdocdt LIKE xmdx_t.xmdxdocdt, 
   xmdxdocno LIKE xmdx_t.xmdxdocno, 
   xmdxent LIKE xmdx_t.xmdxent, 
   xmdxsite LIKE xmdx_t.xmdxsite, 
   xmdxstus LIKE xmdx_t.xmdxstus, 
   xmdy001 LIKE xmdy_t.xmdy001, 
   xmdy002 LIKE xmdy_t.xmdy002, 
   xmdy003 LIKE xmdy_t.xmdy003, 
   xmdy004 LIKE xmdy_t.xmdy004, 
   xmdy005 LIKE xmdy_t.xmdy005, 
   xmdy006 LIKE xmdy_t.xmdy006, 
   xmdy007 LIKE xmdy_t.xmdy007, 
   xmdy008 LIKE xmdy_t.xmdy008, 
   xmdy009 LIKE xmdy_t.xmdy009, 
   xmdy010 LIKE xmdy_t.xmdy010, 
   xmdy011 LIKE xmdy_t.xmdy011, 
   xmdy012 LIKE xmdy_t.xmdy012, 
   xmdy013 LIKE xmdy_t.xmdy013, 
   xmdy014 LIKE xmdy_t.xmdy014, 
   xmdy017 LIKE xmdy_t.xmdy017, 
   xmdy018 LIKE xmdy_t.xmdy018, 
   xmdy019 LIKE xmdy_t.xmdy019, 
   xmdy020 LIKE xmdy_t.xmdy020, 
   xmdy021 LIKE xmdy_t.xmdy021, 
   xmdy022 LIKE xmdy_t.xmdy022, 
   xmdy023 LIKE xmdy_t.xmdy023, 
   xmdy024 LIKE xmdy_t.xmdy024, 
   xmdy030 LIKE xmdy_t.xmdy030, 
   xmdyseq LIKE xmdy_t.xmdyseq, 
   xmdysite LIKE xmdy_t.xmdysite, 
   t3_oofa011 LIKE oofa_t.oofa011, 
   oofa_t_oofa011 LIKE oofa_t.oofa011, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   t1_ooefl003 LIKE ooefl_t.ooefl003, 
   pmaal_t_pmaal004 LIKE pmaal_t.pmaal004, 
   t2_pmaal004 LIKE pmaal_t.pmaal004, 
   ooail_t_ooail003 LIKE ooail_t.ooail003, 
   oodbl_t_oodbl004 LIKE oodbl_t.oodbl004, 
   x_t5_oodbl004 LIKE oodbl_t.oodbl004, 
   ooibl_t_ooibl004 LIKE ooibl_t.ooibl004, 
   oocql_t_oocql004 LIKE oocql_t.oocql004, 
   x_t4_oocql004 LIKE oocql_t.oocql004, 
   x_t6_oocql004 LIKE oocql_t.oocql004, 
   x_t8_oocql004 LIKE oocql_t.oocql004, 
   oobxl_t_oobxl003 LIKE oobxl_t.oobxl003, 
   x_t7_imaal003 LIKE imaal_t.imaal003, 
   x_imaal_t_imaal004 LIKE imaal_t.imaal004, 
   l_xmdxdocno_oobxl003 LIKE type_t.chr1000, 
   l_xmdx004_ooefl003 LIKE type_t.chr1000, 
   l_xmdx003_pmaal004 LIKE type_t.chr100, 
   l_xmdx003_ooefl003 LIKE type_t.chr1000, 
   l_xmdx004_pmaal004 LIKE type_t.chr100, 
   l_xmdx002_oofa011 LIKE type_t.chr300, 
   l_xmdx002_oofa_t_oofa011 LIKE type_t.chr300, 
   l_xmdx009_desc LIKE type_t.chr80, 
   l_xmdx006_desc LIKE type_t.chr80, 
   x_t7_imaal004 LIKE imaal_t.imaal004
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
   xmdzdocno     LIKE xmdz_t.xmdzdocno,
   xmdzseq1      LIKE xmdz_t.xmdzseq1,
   xmdz001       LIKE xmdz_t.xmdz001,
   xmdz002       LIKE xmdz_t.xmdz002,
   xmdz003       LIKE xmdz_t.xmdz003

END RECORD
#end add-point
 
{</section>}
 
{<section id="axmr440_g01.main" readonly="Y" >}
PUBLIC FUNCTION axmr440_g01(p_arg1)
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
   
   LET g_rep_code = "axmr440_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL axmr440_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL axmr440_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL axmr440_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="axmr440_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axmr440_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   #20151027 by stellar modify ----- (S)
   #stellar modify:oofa011改成ooag011
   LET g_select = " SELECT xmdx000,xmdx001,xmdx002,xmdx003,xmdx004,xmdx005,xmdx006,xmdx007,xmdx008,xmdx009, 
       xmdx010,xmdx011,xmdx012,xmdx014,xmdx015,xmdx016,xmdx017,xmdx018,xmdx019,xmdx020,xmdx030,xmdxdocdt, 
       xmdxdocno,xmdxent,xmdxsite,xmdxstus,xmdy001,xmdy002,xmdy003,xmdy004,xmdy005,xmdy006,xmdy007,xmdy008, 
       xmdy009,xmdy010,xmdy011,xmdy012,xmdy013,xmdy014,xmdy017,xmdy018,xmdy019,xmdy020,xmdy021,xmdy022, 
       xmdy023,xmdy024,xmdy030,xmdyseq,xmdysite,t3.ooag011,ooag_t.ooag011,ooefl_t.ooefl003,t1.ooefl003, 
       pmaal_t.pmaal004,t2.pmaal004,ooail_t.ooail003,oodbl_t.oodbl004,x.t5_oodbl004,ooibl_t.ooibl004, 
       oocql_t.oocql004,x.t4_oocql004,x.t6_oocql004,x.t8_oocql004,oobxl_t.oobxl003,x.t7_imaal003,x.imaal_t_imaal004, 
       trim(xmdxdocno)||'.'||trim(oobxl_t.oobxl003),trim(xmdx004)||'.'||trim(ooefl_t.ooefl003),trim(xmdx003)||'.'||trim(pmaal_t.pmaal004), 
       trim(xmdx003)||'.'||trim(t1.ooefl003),trim(xmdx004)||'.'||trim(t2.pmaal004),trim(xmdx002)||'.'||trim(t3.ooag011), 
       trim(xmdx002)||'.'||trim(ooag_t.ooag011),NULL,NULL,x.t7_imaal004"
    #20151027 by stellar modify ----- (E)
#   #end add-point
#   LET g_select = " SELECT xmdx000,xmdx001,xmdx002,xmdx003,xmdx004,xmdx005,xmdx006,xmdx007,xmdx008,xmdx009, 
#       xmdx010,xmdx011,xmdx012,xmdx014,xmdx015,xmdx016,xmdx017,xmdx018,xmdx019,xmdx020,xmdx030,xmdxdocdt, 
#       xmdxdocno,xmdxent,xmdxsite,xmdxstus,xmdy001,xmdy002,xmdy003,xmdy004,xmdy005,xmdy006,xmdy007,xmdy008, 
#       xmdy009,xmdy010,xmdy011,xmdy012,xmdy013,xmdy014,xmdy017,xmdy018,xmdy019,xmdy020,xmdy021,xmdy022, 
#       xmdy023,xmdy024,xmdy030,xmdyseq,xmdysite,( SELECT oofa011 FROM oofa_t WHERE oofa_t.oofaent = xmdx_t.xmdxent AND oofa_t.oofa001 = xmdx_t.xmdx002), 
#       ( SELECT oofa011 FROM oofa_t WHERE oofa_t.oofaent = xmdx_t.xmdxent AND oofa_t.oofa003 = xmdx_t.xmdx002), 
#       ( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooeflent = xmdx_t.xmdxent AND ooefl_t.ooefl001 = xmdx_t.xmdx004 AND ooefl_t.ooefl002 = '" , 
#       g_dlang,"'" ,"),( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooeflent = xmdx_t.xmdxent AND ooefl_t.ooefl001 = xmdx_t.xmdx003 AND ooefl_t.ooefl002 = '" , 
#       g_dlang,"'" ,"),( SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaalent = xmdx_t.xmdxent AND pmaal_t.pmaal001 = xmdx_t.xmdx003 AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,"),( SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaalent = xmdx_t.xmdxent AND pmaal_t.pmaal001 = xmdx_t.xmdx004 AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,"),( SELECT ooail003 FROM ooail_t WHERE ooail_t.ooailent = xmdx_t.xmdxent AND ooail_t.ooail001 = xmdx_t.xmdx005 AND ooail_t.ooail002 = '" , 
#       g_dlang,"'" ,"),( SELECT oodbl004 FROM oodbl_t WHERE oodbl_t.oodblent = xmdx_t.xmdxent AND oodbl_t.oodbl001 = ' ' AND oodbl_t.oodbl002 = xmdx_t.xmdx006 AND oodbl_t.oodbl003 = '" , 
#       g_dlang,"'" ,"),x.t5_oodbl004,( SELECT ooibl004 FROM ooibl_t WHERE ooibl_t.ooiblent = xmdx_t.xmdxent AND ooibl_t.ooibl002 = xmdx_t.xmdx009 AND ooibl_t.ooibl003 = '" , 
#       g_dlang,"'" ,"),( SELECT oocql004 FROM oocql_t WHERE oocql_t.oocqlent = xmdx_t.xmdxent AND oocql_t.oocql001 = '238' AND oocql_t.oocql002 = xmdx_t.xmdx011 AND oocql_t.oocql003 = '" , 
#       g_dlang,"'" ,"),x.t4_oocql004,x.t6_oocql004,x.t8_oocql004,( SELECT oobxl003 FROM oobxl_t WHERE oobxl_t.oobxl001 = xmdx_t.xmdxdocno AND oobxl_t.oobxlent = xmdx_t.xmdxent AND oobxl_t.oobxl002 = '" , 
#       g_dlang,"'" ,"),x.t7_imaal003,x.imaal_t_imaal004,trim(xmdxdocno)||'.'||trim((SELECT oobxl003 FROM oobxl_t WHERE oobxl_t.oobxl001 = xmdx_t.xmdxdocno AND oobxl_t.oobxlent = xmdx_t.xmdxent AND oobxl_t.oobxl002 = '" , 
#       g_dlang,"'" ,")),trim(xmdx004)||'.'||trim((SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooeflent = xmdx_t.xmdxent AND ooefl_t.ooefl001 = xmdx_t.xmdx004 AND ooefl_t.ooefl002 = '" , 
#       g_dlang,"'" ,")),trim(xmdx003)||'.'||trim((SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaalent = xmdx_t.xmdxent AND pmaal_t.pmaal001 = xmdx_t.xmdx003 AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,")),trim(xmdx003)||'.'||trim((SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooeflent = xmdx_t.xmdxent AND ooefl_t.ooefl001 = xmdx_t.xmdx003 AND ooefl_t.ooefl002 = '" , 
#       g_dlang,"'" ,")),trim(xmdx004)||'.'||trim((SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaalent = xmdx_t.xmdxent AND pmaal_t.pmaal001 = xmdx_t.xmdx004 AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,")),trim(xmdx002)||'.'||trim((SELECT oofa011 FROM oofa_t WHERE oofa_t.oofaent = xmdx_t.xmdxent AND oofa_t.oofa001 = xmdx_t.xmdx002)), 
#       trim(xmdx002)||'.'||trim((SELECT oofa011 FROM oofa_t WHERE oofa_t.oofaent = xmdx_t.xmdxent AND oofa_t.oofa003 = xmdx_t.xmdx002)), 
#       NULL,NULL,x.t7_imaal004"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   #20151027 by stellar modify ----- (S)
   #stellar modify:oofa011改成ooag011
   LET g_from = " FROM xmdx_t LEFT OUTER JOIN ooag_t ON ooag_t.ooagent = xmdx_t.xmdxent AND ooag_t.ooag001 = xmdx_t.xmdx002             LEFT OUTER JOIN oobxl_t ON oobxl_t.oobxl001 = xmdx_t.xmdxdocno AND oobxl_t.oobxlent = xmdx_t.xmdxent AND oobxl_t.oobxl002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN oocql_t ON oocql_t.oocqlent = xmdx_t.xmdxent AND oocql_t.oocql001 = '238' AND oocql_t.oocql002 = xmdx_t.xmdx011 AND oocql_t.oocql003 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN ooibl_t ON ooibl_t.ooiblent = xmdx_t.xmdxent AND ooibl_t.ooibl002 = xmdx_t.xmdx009 AND ooibl_t.ooibl003 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN oodbl_t ON oodbl_t.oodblent = xmdx_t.xmdxent AND oodbl_t.oodbl001 = ' ' AND oodbl_t.oodbl002 = xmdx_t.xmdx006 AND oodbl_t.oodbl003 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN ooefl_t ON ooefl_t.ooeflent = xmdx_t.xmdxent AND ooefl_t.ooefl001 = xmdx_t.xmdx004 AND ooefl_t.ooefl002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN pmaal_t ON pmaal_t.pmaalent = xmdx_t.xmdxent AND pmaal_t.pmaal001 = xmdx_t.xmdx003 AND pmaal_t.pmaal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN ooefl_t t1 ON t1.ooeflent = xmdx_t.xmdxent AND t1.ooefl001 = xmdx_t.xmdx003 AND t1.ooefl002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN pmaal_t t2 ON t2.pmaalent = xmdx_t.xmdxent AND t2.pmaal001 = xmdx_t.xmdx004 AND t2.pmaal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN ooail_t ON ooail_t.ooailent = xmdx_t.xmdxent AND ooail_t.ooail001 = xmdx_t.xmdx005 AND ooail_t.ooail002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN ooag_t t3 ON t3.ooagent = xmdx_t.xmdxent AND t3.ooag001 = xmdx_t.xmdx002 LEFT OUTER JOIN ( SELECT xmdy_t.*, 
        t5.oodbl004 t5_oodbl004,t4.oocql004 t4_oocql004,t6.oocql004 t6_oocql004,t8.oocql004 t8_oocql004, 
        t7.imaal003 t7_imaal003,imaal_t.imaal004 imaal_t_imaal004,t7.imaal004 t7_imaal004 FROM xmdy_t LEFT OUTER JOIN oocql_t t4 ON t4.oocqlent = xmdy_t.xmdyent AND t4.oocql001 = '263' AND t4.oocql002 = xmdy_t.xmdy013 AND t4.oocql003 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN oodbl_t t5 ON t5.oodbl001 = ' ' AND t5.oodbl002 = xmdy_t.xmdy011 AND t5.oodblent = xmdy_t.xmdyent AND t5.oodbl003 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN oocql_t t6 ON t6.oocqlent = xmdy_t.xmdyent AND t6.oocql001 = '221' AND t6.oocql002 = xmdy_t.xmdy006 AND t6.oocql003 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN imaal_t ON imaal_t.imaalent = xmdy_t.xmdyent AND imaal_t.imaal001 = xmdy_t.xmdy001 AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN imaal_t t7 ON t7.imaalent = xmdy_t.xmdyent AND t7.imaal001 = xmdy_t.xmdy002 AND t7.imaal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN oocql_t t8 ON t8.oocqlent = xmdy_t.xmdyent AND t8.oocql001 = '277' AND t8.oocql002 = xmdy_t.xmdy014 AND t8.oocql003 = '" , 
        g_dlang,"'" ," ) x  ON xmdx_t.xmdxdocno = x.xmdydocno AND xmdx_t.xmdxent = x.xmdyent AND xmdx_t.xmdxsite  
        = x.xmdysite"
    #20151027 by stellar modify ----- (E)
#   #end add-point
#    LET g_from = " FROM xmdx_t LEFT OUTER JOIN ( SELECT xmdy_t.*,( SELECT oodbl004 FROM oodbl_t WHERE oodbl_t.oodbl001 = ' ' AND oodbl_t.oodbl002 = xmdy_t.xmdy011 AND oodbl_t.oodblent = xmdy_t.xmdyent AND oodbl_t.oodbl003 = '" , 
#        g_dlang,"'" ,") t5_oodbl004,( SELECT oocql004 FROM oocql_t WHERE oocql_t.oocqlent = xmdy_t.xmdyent AND oocql_t.oocql001 = '263' AND oocql_t.oocql002 = xmdy_t.xmdy013 AND oocql_t.oocql003 = '" , 
#        g_dlang,"'" ,") t4_oocql004,( SELECT oocql004 FROM oocql_t WHERE oocql_t.oocqlent = xmdy_t.xmdyent AND oocql_t.oocql001 = '221' AND oocql_t.oocql002 = xmdy_t.xmdy006 AND oocql_t.oocql003 = '" , 
#        g_dlang,"'" ,") t6_oocql004,( SELECT oocql004 FROM oocql_t WHERE oocql_t.oocqlent = xmdy_t.xmdyent AND oocql_t.oocql001 = '277' AND oocql_t.oocql002 = xmdy_t.xmdy014 AND oocql_t.oocql003 = '" , 
#        g_dlang,"'" ,") t8_oocql004,( SELECT imaal003 FROM imaal_t WHERE imaal_t.imaalent = xmdy_t.xmdyent AND imaal_t.imaal001 = xmdy_t.xmdy002 AND imaal_t.imaal002 = '" , 
#        g_dlang,"'" ,") t7_imaal003,( SELECT imaal004 FROM imaal_t WHERE imaal_t.imaalent = xmdy_t.xmdyent AND imaal_t.imaal001 = xmdy_t.xmdy001 AND imaal_t.imaal002 = '" , 
#        g_dlang,"'" ,") imaal_t_imaal004,( SELECT imaal004 FROM imaal_t WHERE imaal_t.imaalent = xmdy_t.xmdyent AND imaal_t.imaal001 = xmdy_t.xmdy002 AND imaal_t.imaal002 = '" , 
#        g_dlang,"'" ,") t7_imaal004 FROM xmdy_t ) x  ON xmdx_t.xmdxdocno = x.xmdydocno AND xmdx_t.xmdxent  
#        = x.xmdyent AND xmdx_t.xmdxsite = x.xmdysite"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
    LET g_order = " ORDER BY xmdxdocno,xmdyseq"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("xmdx_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE axmr440_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE axmr440_g01_curs CURSOR FOR axmr440_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="axmr440_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION axmr440_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   xmdx000 LIKE xmdx_t.xmdx000, 
   xmdx001 LIKE xmdx_t.xmdx001, 
   xmdx002 LIKE xmdx_t.xmdx002, 
   xmdx003 LIKE xmdx_t.xmdx003, 
   xmdx004 LIKE xmdx_t.xmdx004, 
   xmdx005 LIKE xmdx_t.xmdx005, 
   xmdx006 LIKE xmdx_t.xmdx006, 
   xmdx007 LIKE xmdx_t.xmdx007, 
   xmdx008 LIKE xmdx_t.xmdx008, 
   xmdx009 LIKE xmdx_t.xmdx009, 
   xmdx010 LIKE xmdx_t.xmdx010, 
   xmdx011 LIKE xmdx_t.xmdx011, 
   xmdx012 LIKE xmdx_t.xmdx012, 
   xmdx014 LIKE xmdx_t.xmdx014, 
   xmdx015 LIKE xmdx_t.xmdx015, 
   xmdx016 LIKE xmdx_t.xmdx016, 
   xmdx017 LIKE xmdx_t.xmdx017, 
   xmdx018 LIKE xmdx_t.xmdx018, 
   xmdx019 LIKE xmdx_t.xmdx019, 
   xmdx020 LIKE xmdx_t.xmdx020, 
   xmdx030 LIKE xmdx_t.xmdx030, 
   xmdxdocdt LIKE xmdx_t.xmdxdocdt, 
   xmdxdocno LIKE xmdx_t.xmdxdocno, 
   xmdxent LIKE xmdx_t.xmdxent, 
   xmdxsite LIKE xmdx_t.xmdxsite, 
   xmdxstus LIKE xmdx_t.xmdxstus, 
   xmdy001 LIKE xmdy_t.xmdy001, 
   xmdy002 LIKE xmdy_t.xmdy002, 
   xmdy003 LIKE xmdy_t.xmdy003, 
   xmdy004 LIKE xmdy_t.xmdy004, 
   xmdy005 LIKE xmdy_t.xmdy005, 
   xmdy006 LIKE xmdy_t.xmdy006, 
   xmdy007 LIKE xmdy_t.xmdy007, 
   xmdy008 LIKE xmdy_t.xmdy008, 
   xmdy009 LIKE xmdy_t.xmdy009, 
   xmdy010 LIKE xmdy_t.xmdy010, 
   xmdy011 LIKE xmdy_t.xmdy011, 
   xmdy012 LIKE xmdy_t.xmdy012, 
   xmdy013 LIKE xmdy_t.xmdy013, 
   xmdy014 LIKE xmdy_t.xmdy014, 
   xmdy017 LIKE xmdy_t.xmdy017, 
   xmdy018 LIKE xmdy_t.xmdy018, 
   xmdy019 LIKE xmdy_t.xmdy019, 
   xmdy020 LIKE xmdy_t.xmdy020, 
   xmdy021 LIKE xmdy_t.xmdy021, 
   xmdy022 LIKE xmdy_t.xmdy022, 
   xmdy023 LIKE xmdy_t.xmdy023, 
   xmdy024 LIKE xmdy_t.xmdy024, 
   xmdy030 LIKE xmdy_t.xmdy030, 
   xmdyseq LIKE xmdy_t.xmdyseq, 
   xmdysite LIKE xmdy_t.xmdysite, 
   t3_oofa011 LIKE oofa_t.oofa011, 
   oofa_t_oofa011 LIKE oofa_t.oofa011, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   t1_ooefl003 LIKE ooefl_t.ooefl003, 
   pmaal_t_pmaal004 LIKE pmaal_t.pmaal004, 
   t2_pmaal004 LIKE pmaal_t.pmaal004, 
   ooail_t_ooail003 LIKE ooail_t.ooail003, 
   oodbl_t_oodbl004 LIKE oodbl_t.oodbl004, 
   x_t5_oodbl004 LIKE oodbl_t.oodbl004, 
   ooibl_t_ooibl004 LIKE ooibl_t.ooibl004, 
   oocql_t_oocql004 LIKE oocql_t.oocql004, 
   x_t4_oocql004 LIKE oocql_t.oocql004, 
   x_t6_oocql004 LIKE oocql_t.oocql004, 
   x_t8_oocql004 LIKE oocql_t.oocql004, 
   oobxl_t_oobxl003 LIKE oobxl_t.oobxl003, 
   x_t7_imaal003 LIKE imaal_t.imaal003, 
   x_imaal_t_imaal004 LIKE imaal_t.imaal004, 
   l_xmdxdocno_oobxl003 LIKE type_t.chr1000, 
   l_xmdx004_ooefl003 LIKE type_t.chr1000, 
   l_xmdx003_pmaal004 LIKE type_t.chr100, 
   l_xmdx003_ooefl003 LIKE type_t.chr1000, 
   l_xmdx004_pmaal004 LIKE type_t.chr100, 
   l_xmdx002_oofa011 LIKE type_t.chr300, 
   l_xmdx002_oofa_t_oofa011 LIKE type_t.chr300, 
   l_xmdx009_desc LIKE type_t.chr80, 
   l_xmdx006_desc LIKE type_t.chr80, 
   x_t7_imaal004 LIKE imaal_t.imaal004
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
    FOREACH axmr440_g01_curs INTO sr_s.*
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

       #代號跟說明組合     
       CALL axmr440_g01_combination(sr_s.xmdxdocno,l_desc)
            RETURNING sr_s.l_xmdxdocno_oobxl003
            
       #稅別
       CALL axmr440_g01_xmdx006_ref(sr_s.xmdxent,sr_s.xmdxsite,sr_s.xmdx006)
            RETURNING sr_s.l_xmdx006_desc
       LET sr_s.l_xmdx006_desc = sr_s.l_xmdx006_desc CLIPPED,sr_s.xmdx007 USING '<<<<<','%' 
       
       #收款條件
       CALL axmr440_g01_xmdx009_ref(sr_s.xmdxent,sr_s.xmdx009)
            RETURNING sr_s.l_xmdx009_desc        
            
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].xmdx000 = sr_s.xmdx000
       LET sr[l_cnt].xmdx001 = sr_s.xmdx001
       LET sr[l_cnt].xmdx002 = sr_s.xmdx002
       LET sr[l_cnt].xmdx003 = sr_s.xmdx003
       LET sr[l_cnt].xmdx004 = sr_s.xmdx004
       LET sr[l_cnt].xmdx005 = sr_s.xmdx005
       LET sr[l_cnt].xmdx006 = sr_s.xmdx006
       LET sr[l_cnt].xmdx007 = sr_s.xmdx007
       LET sr[l_cnt].xmdx008 = sr_s.xmdx008
       LET sr[l_cnt].xmdx009 = sr_s.xmdx009
       LET sr[l_cnt].xmdx010 = sr_s.xmdx010
       LET sr[l_cnt].xmdx011 = sr_s.xmdx011
       LET sr[l_cnt].xmdx012 = sr_s.xmdx012
       LET sr[l_cnt].xmdx014 = sr_s.xmdx014
       LET sr[l_cnt].xmdx015 = sr_s.xmdx015
       LET sr[l_cnt].xmdx016 = sr_s.xmdx016
       LET sr[l_cnt].xmdx017 = sr_s.xmdx017
       LET sr[l_cnt].xmdx018 = sr_s.xmdx018
       LET sr[l_cnt].xmdx019 = sr_s.xmdx019
       LET sr[l_cnt].xmdx020 = sr_s.xmdx020
       LET sr[l_cnt].xmdx030 = sr_s.xmdx030
       LET sr[l_cnt].xmdxdocdt = sr_s.xmdxdocdt
       LET sr[l_cnt].xmdxdocno = sr_s.xmdxdocno
       LET sr[l_cnt].xmdxent = sr_s.xmdxent
       LET sr[l_cnt].xmdxsite = sr_s.xmdxsite
       LET sr[l_cnt].xmdxstus = sr_s.xmdxstus
       LET sr[l_cnt].xmdy001 = sr_s.xmdy001
       LET sr[l_cnt].xmdy002 = sr_s.xmdy002
       LET sr[l_cnt].xmdy003 = sr_s.xmdy003
       LET sr[l_cnt].xmdy004 = sr_s.xmdy004
       LET sr[l_cnt].xmdy005 = sr_s.xmdy005
       LET sr[l_cnt].xmdy006 = sr_s.xmdy006
       LET sr[l_cnt].xmdy007 = sr_s.xmdy007
       LET sr[l_cnt].xmdy008 = sr_s.xmdy008
       LET sr[l_cnt].xmdy009 = sr_s.xmdy009
       LET sr[l_cnt].xmdy010 = sr_s.xmdy010
       LET sr[l_cnt].xmdy011 = sr_s.xmdy011
       LET sr[l_cnt].xmdy012 = sr_s.xmdy012
       LET sr[l_cnt].xmdy013 = sr_s.xmdy013
       LET sr[l_cnt].xmdy014 = sr_s.xmdy014
       LET sr[l_cnt].xmdy017 = sr_s.xmdy017
       LET sr[l_cnt].xmdy018 = sr_s.xmdy018
       LET sr[l_cnt].xmdy019 = sr_s.xmdy019
       LET sr[l_cnt].xmdy020 = sr_s.xmdy020
       LET sr[l_cnt].xmdy021 = sr_s.xmdy021
       LET sr[l_cnt].xmdy022 = sr_s.xmdy022
       LET sr[l_cnt].xmdy023 = sr_s.xmdy023
       LET sr[l_cnt].xmdy024 = sr_s.xmdy024
       LET sr[l_cnt].xmdy030 = sr_s.xmdy030
       LET sr[l_cnt].xmdyseq = sr_s.xmdyseq
       LET sr[l_cnt].xmdysite = sr_s.xmdysite
       LET sr[l_cnt].t3_oofa011 = sr_s.t3_oofa011
       LET sr[l_cnt].oofa_t_oofa011 = sr_s.oofa_t_oofa011
       LET sr[l_cnt].ooefl_t_ooefl003 = sr_s.ooefl_t_ooefl003
       LET sr[l_cnt].t1_ooefl003 = sr_s.t1_ooefl003
       LET sr[l_cnt].pmaal_t_pmaal004 = sr_s.pmaal_t_pmaal004
       LET sr[l_cnt].t2_pmaal004 = sr_s.t2_pmaal004
       LET sr[l_cnt].ooail_t_ooail003 = sr_s.ooail_t_ooail003
       LET sr[l_cnt].oodbl_t_oodbl004 = sr_s.oodbl_t_oodbl004
       LET sr[l_cnt].x_t5_oodbl004 = sr_s.x_t5_oodbl004
       LET sr[l_cnt].ooibl_t_ooibl004 = sr_s.ooibl_t_ooibl004
       LET sr[l_cnt].oocql_t_oocql004 = sr_s.oocql_t_oocql004
       LET sr[l_cnt].x_t4_oocql004 = sr_s.x_t4_oocql004
       LET sr[l_cnt].x_t6_oocql004 = sr_s.x_t6_oocql004
       LET sr[l_cnt].x_t8_oocql004 = sr_s.x_t8_oocql004
       LET sr[l_cnt].oobxl_t_oobxl003 = sr_s.oobxl_t_oobxl003
       LET sr[l_cnt].x_t7_imaal003 = sr_s.x_t7_imaal003
       LET sr[l_cnt].x_imaal_t_imaal004 = sr_s.x_imaal_t_imaal004
       LET sr[l_cnt].l_xmdxdocno_oobxl003 = sr_s.l_xmdxdocno_oobxl003
       LET sr[l_cnt].l_xmdx004_ooefl003 = sr_s.l_xmdx004_ooefl003
       LET sr[l_cnt].l_xmdx003_pmaal004 = sr_s.l_xmdx003_pmaal004
       LET sr[l_cnt].l_xmdx003_ooefl003 = sr_s.l_xmdx003_ooefl003
       LET sr[l_cnt].l_xmdx004_pmaal004 = sr_s.l_xmdx004_pmaal004
       LET sr[l_cnt].l_xmdx002_oofa011 = sr_s.l_xmdx002_oofa011
       LET sr[l_cnt].l_xmdx002_oofa_t_oofa011 = sr_s.l_xmdx002_oofa_t_oofa011
       LET sr[l_cnt].l_xmdx009_desc = sr_s.l_xmdx009_desc
       LET sr[l_cnt].l_xmdx006_desc = sr_s.l_xmdx006_desc
       LET sr[l_cnt].x_t7_imaal004 = sr_s.x_t7_imaal004
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axmr440_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION axmr440_g01_rep_data()
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
          START REPORT axmr440_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT axmr440_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT axmr440_g01_rep
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
 
{<section id="axmr440_g01.rep" readonly="Y" >}
PRIVATE REPORT axmr440_g01_rep(sr1)
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
DEFINE l_xmdy030_show  LIKE type_t.chr10      #備註
DEFINE l_xmdy003_show  LIKE type_t.chr10      #產品特徵
DEFINE l_xmdy005_show  LIKE type_t.chr10      #客戶料號
DEFINE l_xmdy017_sum   LIKE xmdy_t.xmdy017    #未稅總金額  
DEFINE l_xmdy018_sum   LIKE xmdy_t.xmdy018    #含稅總金額
DEFINE l_xmdy019_sum   LIKE xmdy_t.xmdy019    #總稅額
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER EXTERNAL BY sr1.xmdxdocno,sr1.xmdyseq
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
        BEFORE GROUP OF sr1.xmdxdocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.xmdxdocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'xmdxent=' ,sr1.xmdxent,'{+}xmdxdocno=' ,sr1.xmdxdocno         
            CALL cl_gr_init_apr(sr1.xmdxdocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.xmdxdocno.before name="rep.b_group.xmdxdocno.before"
           LET l_xmdy017_sum = 0    #金額清空 
           LET l_xmdy018_sum = 0
           LET l_xmdy019_sum = 0
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.xmdxent CLIPPED ,"'", " AND  ooff003 = '", sr1.xmdxdocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE axmr440_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE axmr440_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT axmr440_g01_subrep01
           DECLARE axmr440_g01_repcur01 CURSOR FROM g_sql
           FOREACH axmr440_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "axmr440_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT axmr440_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT axmr440_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.xmdxdocno.after name="rep.b_group.xmdxdocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.xmdyseq
 
           #add-point:rep.b_group.xmdyseq.before name="rep.b_group.xmdyseq.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.xmdyseq.after name="rep.b_group.xmdyseq.after"
           
           #end add-point:
 
 
 
 
       ON EVERY ROW
          #add-point:rep.everyrow.before name="rep.everyrow.before"
       #若產品特徵為null，將會隱藏
       IF cl_null(sr1.xmdy003) THEN
           LET l_xmdy003_show = "N"
       ELSE
           LET l_xmdy003_show = "Y"
       END IF
       
      #若備註為null，將會隱藏
       IF cl_null(sr1.xmdy030) THEN  
           LET l_xmdy030_show = "N"
       ELSE
           LET l_xmdy030_show = "Y"
       END IF
       
       #若客戶料號為null，將會隱藏
       IF cl_null(sr1.xmdy005) THEN  
           LET l_xmdy005_show = "N"
       ELSE
           LET l_xmdy005_show = "Y"
       END IF
       
       PRINTX l_xmdy003_show,l_xmdy030_show,l_xmdy005_show      
          #end add-point:rep.everyrow.before
 
          #單身前備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub02.before name="rep.sub02.before"
           
           #end add-point:rep.sub02.before
 
           #add-point:rep.sub02.sql name="rep.sub02.sql"
           
           #end add-point:rep.sub02.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='2' AND ooffent = '", 
                sr1.xmdxent CLIPPED ,"'", " AND  ooff003 = '", sr1.xmdxdocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.xmdyseq CLIPPED ,""
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE axmr440_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE axmr440_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT axmr440_g01_subrep02
           DECLARE axmr440_g01_repcur02 CURSOR FROM g_sql
           FOREACH axmr440_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "axmr440_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT axmr440_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT axmr440_g01_subrep02
           #add-point:rep.sub02.after name="rep.sub02.after"
           
           #end add-point:rep.sub02.after
 
 
 
          #add-point:rep.everyrow.beforerow name="rep.everyrow.beforerow"
          
          #end add-point:rep.everyrow.beforerow
            
          PRINTX sr1.*
 
          #add-point:rep.everyrow.afterrow name="rep.everyrow.afterrow"
       
            START REPORT axmr440_g01_subrep05
            IF NOT cl_null(sr1.xmdyseq) THEN   
               LET g_sql = " SELECT xmdzdocno,xmdzseq1,xmdz001,xmdz002,xmdz003 ",
                           "  FROM xmdz_t ",  
                           "  WHERE xmdzent = '",sr1.xmdxent,"' ",
                           "    AND xmdzdocno = '",sr1.xmdxdocno CLIPPED,"'",
                           "    AND xmdzseq = '",sr1.xmdyseq CLIPPED,"' ",
                           "  ORDER BY xmdzseq1 "                                       
               DECLARE axmr440_g01_repcur05 CURSOR FROM g_sql
               FOREACH axmr440_g01_repcur05 INTO sr3.*
                  OUTPUT TO REPORT axmr440_g01_subrep05(sr3.*)
               END FOREACH   
            END IF               
            FINISH REPORT axmr440_g01_subrep05             
          #end add-point:rep.everyrow.afterrow
 
          #單身後備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub03.before name="rep.sub03.before"
           
           #end add-point:rep.sub03.before
 
           #add-point:rep.sub03.sql name="rep.sub03.sql"
           
           #end add-point:rep.sub03.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooffent = '", 
                sr1.xmdxent CLIPPED ,"'", " AND  ooff003 = '", sr1.xmdxdocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.xmdyseq CLIPPED ,""
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE axmr440_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE axmr440_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT axmr440_g01_subrep03
           DECLARE axmr440_g01_repcur03 CURSOR FROM g_sql
           FOREACH axmr440_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "axmr440_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT axmr440_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT axmr440_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.xmdxdocno
 
           #add-point:rep.a_group.xmdxdocno.before name="rep.a_group.xmdxdocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.xmdxent CLIPPED ,"'", " AND  ooff003 = '", sr1.xmdxdocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE axmr440_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE axmr440_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT axmr440_g01_subrep04
           DECLARE axmr440_g01_repcur04 CURSOR FROM g_sql
           FOREACH axmr440_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "axmr440_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT axmr440_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT axmr440_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.xmdxdocno.after name="rep.a_group.xmdxdocno.after"
           LET l_xmdy017_sum = GROUP SUM(sr1.xmdy017)    #未稅總金額加總
           LET l_xmdy018_sum = GROUP SUM(sr1.xmdy018)    #含稅總金額加總 
           LET l_xmdy019_sum = GROUP SUM(sr1.xmdy019)    #總稅額加總
           PRINTX l_xmdy017_sum,l_xmdy018_sum,l_xmdy019_sum
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.xmdyseq
 
           #add-point:rep.a_group.xmdyseq.before name="rep.a_group.xmdyseq.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.xmdyseq.after name="rep.a_group.xmdyseq.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="axmr440_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT axmr440_g01_subrep01(sr2)
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
PRIVATE REPORT axmr440_g01_subrep02(sr2)
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
PRIVATE REPORT axmr440_g01_subrep03(sr2)
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
PRIVATE REPORT axmr440_g01_subrep04(sr2)
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
 
{<section id="axmr440_g01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 抓取合約單號
# Memo...........:
# Usage..........: CALL axmr420_g01_xmdxdocno_ref(p_xmdxdocno)
#                  RETURNING r_xmdtdocno_desc
# Input parameter: p_xmdxdocno    合約單號
#                : 
# Return code....: r_xmdxdocno_desc 合約單號說明
#                : 
# Date & Author..: 140509 By zechs
# Modify.........:
################################################################################
PRIVATE FUNCTION axmr440_g01_xmdxdocno_ref(p_xmdxdocno)
DEFINE p_xmdxdocno       LIKE xmdx_t.xmdxdocno
DEFINE r_xmdxdocno_desc  LIKE oobxl_t.oobxl003
#
#   CALL s_aooi200_get_slip_desc(p_xmdxdocno) RETURNING r_xmdxdocno_desc
#
#   RETURN r_xmdxdocno_desc
# 
END FUNCTION

################################################################################
# Descriptions...: 代號跟說明組合
# Memo...........:
# Usage..........: CALL axmr440_g01_combination(p_value,p_desc)
#                  RETURNING r_combination
# Input parameter: p_value        代號
#                : p_desc         說明
# Return code....: r_combination  代號.說明
#                : 
# Date & Author..: 140509 By zechs
# Modify.........:
################################################################################
PRIVATE FUNCTION axmr440_g01_combination(p_value,p_desc)
DEFINE p_value           LIKE type_t.chr80
DEFINE p_desc            LIKE type_t.chr80
DEFINE r_combination     LIKE type_t.chr80

   LET r_combination = p_value CLIPPED,".",p_desc CLIPPED
   
   RETURN r_combination
END FUNCTION

################################################################################
# Descriptions...: 抓取稅別說明
# Memo...........:
# Usage..........: CALL axmr440_g01_xmdx006_ref(p_xmdxent,p_xmdxsite,p_xmdx006)
#                  RETURNING  r_xmdx007_desc
# Input parameter: p_xmdxent  企業編號
#                : p_xmdxsite 營運據點
#                : p_xmdx006  稅別
# Return code....: r_xmdx006_desc 稅別說明
#                : 
# Date & Author..: 140509 By zechs
# Modify.........:
################################################################################
PRIVATE FUNCTION axmr440_g01_xmdx006_ref(p_xmdxent,p_xmdxsite,p_xmdx006)
DEFINE p_xmdxent         LIKE xmdx_t.xmdxent 
DEFINE p_xmdxsite        LIKE xmdx_t.xmdxsite
DEFINE p_xmdx006         LIKE xmdx_t.xmdx006
DEFINE r_xmdx006_desc    LIKE oodbl_t.oodbl004
DEFINE l_ooef019         LIKE ooef_t.ooef019

   #稅區
   SELECT ooef019 INTO l_ooef019 
     FROM ooef_t
    WHERE ooefent = p_xmdxent
      AND ooef001 = p_xmdxsite
   
   #稅別說明
   LET r_xmdx006_desc = ''
   SELECT oodbl004 INTO r_xmdx006_desc
     FROM oodbl_t
    WHERE oodblent = p_xmdxent
      AND oodbl001 = l_ooef019       
      AND oodbl002 = p_xmdx006
      AND oodbl003 = g_dlang

   RETURN r_xmdx006_desc
END FUNCTION

################################################################################
# Descriptions...: 抓取收款條件
# Memo...........:
# Usage..........: CALL axmr440_g01_xmdx009_ref(p_xmdxent,p_xmdx009)
#                  RETURNING r_xmdx009_desc
# Input parameter: p_xmdtent 企業編號
#                : p_xmdt009 收款條件
# Return code....: r_xmdt009_desc 收款條件說明
#                :
# Date & Author..: 140509 By zechs
# Modify.........:
################################################################################
PRIVATE FUNCTION axmr440_g01_xmdx009_ref(p_xmdxent,p_xmdx009)
DEFINE p_xmdx009         LIKE xmdx_t.xmdx009
DEFINE p_xmdxent         LIKE xmdx_t.xmdxent
DEFINE r_xmdx009_desc    LIKE ooibl_t.ooibl004

   #收款說明
   LET r_xmdx009_desc = ''
   SELECT ooibl004 INTO r_xmdx009_desc
     FROM ooibl_t
    WHERE ooiblent = p_xmdxent
      AND ooibl002 = p_xmdx009
      AND ooibl003 = g_dlang
   
   RETURN r_xmdx009_desc
END FUNCTION

 
{</section>}
 
{<section id="axmr440_g01.other_report" readonly="Y" >}

################################################################################
# Descriptions...: 累計量定價子報表
# Memo...........:
# Usage..........: CALL axmr440_g01_subrep05(sr3)
#                
# Input parameter: sr3            資料RECORD
#                : 
# Return code....: 
#                : 
# Date & Author..: 2014/05/09 By zechs
# Modify.........:
################################################################################
PRIVATE REPORT axmr440_g01_subrep05(sr3)
DEFINE sr3             sr3_r

   ORDER EXTERNAL BY sr3.xmdzdocno
      FORMAT
           
        ON EVERY ROW
           PRINTX g_grNumFmt.*
           PRINTX sr3.*
END REPORT

 
{</section>}
 