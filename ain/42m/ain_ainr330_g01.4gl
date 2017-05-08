#該程式未解開Section, 採用最新樣板產出!
{<section id="ainr330_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:11(2016-10-31 21:58:57), PR版次:0011(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000150
#+ Filename...: ainr330_g01
#+ Description: ...
#+ Creator....: 05016(2014-06-25 18:39:32)
#+ Modifier...: 08734 -SD/PR- 00000
 
{</section>}
 
{<section id="ainr330_g01.global" readonly="Y" >}
#報表 g01 樣板自動產生(Version:13)
#add-point:填寫註解說明 name="global.memo"
#160112-00014#1  2016/03/22  By dorislai  修正檢驗方式(indc102)的SCC碼
#160315-00013#1  2016/03/28  By Sarah     抓取inao_t的SQL請加上inao005=撥出倉庫 AND inao006=撥出儲位
#160905-00007#4   2016/09/05  by 08172       调整系统中无ENT的SQL条件增加ent
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
   l_condition LIKE type_t.chr1000, 
   indc002 LIKE indc_t.indc002, 
   indc003 LIKE indc_t.indc003, 
   indc004 LIKE indc_t.indc004, 
   indc006 LIKE indc_t.indc006, 
   indc008 LIKE indc_t.indc008, 
   indc022 LIKE indc_t.indc022, 
   indc101 LIKE indc_t.indc101, 
   indc102 LIKE indc_t.indc102, 
   indc103 LIKE indc_t.indc103, 
   indc104 LIKE indc_t.indc104, 
   indc105 LIKE indc_t.indc105, 
   indc106 LIKE indc_t.indc106, 
   indc107 LIKE indc_t.indc107, 
   indc108 LIKE indc_t.indc108, 
   indc151 LIKE indc_t.indc151, 
   indcdocdt LIKE indc_t.indcdocdt, 
   indcdocno LIKE indc_t.indcdocno, 
   indcent LIKE indc_t.indcent, 
   indcsite LIKE indc_t.indcsite, 
   indcstus LIKE indc_t.indcstus, 
   indcunit LIKE indc_t.indcunit, 
   indd001 LIKE indd_t.indd001, 
   indd002 LIKE indd_t.indd002, 
   indd004 LIKE indd_t.indd004, 
   indd006 LIKE indd_t.indd006, 
   indd021 LIKE indd_t.indd021, 
   indd022 LIKE indd_t.indd022, 
   indd023 LIKE indd_t.indd023, 
   indd024 LIKE indd_t.indd024, 
   indd031 LIKE indd_t.indd031, 
   indd032 LIKE indd_t.indd032, 
   indd033 LIKE indd_t.indd033, 
   indd040 LIKE indd_t.indd040, 
   indd101 LIKE indd_t.indd101, 
   indd102 LIKE indd_t.indd102, 
   indd103 LIKE indd_t.indd103, 
   indd104 LIKE indd_t.indd104, 
   indd105 LIKE indd_t.indd105, 
   indd106 LIKE indd_t.indd106, 
   indd109 LIKE indd_t.indd109, 
   indd151 LIKE indd_t.indd151, 
   indd152 LIKE indd_t.indd152, 
   inddseq LIKE indd_t.inddseq, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   oofb_t_oofb011 LIKE oofb_t.oofb011, 
   oobxl_t_oobxl003 LIKE oobxl_t.oobxl003, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   x_t6_imaal004 LIKE imaal_t.imaal004, 
   x_oocal_t_oocal003 LIKE oocal_t.oocal003, 
   x_t5_oocal003 LIKE oocal_t.oocal003, 
   x_inab_t_inab003 LIKE inab_t.inab003, 
   x_t8_inab003 LIKE inab_t.inab003, 
   l_indc004_ooag011 LIKE type_t.chr300, 
   l_indcdocno_oobxl003 LIKE type_t.chr1000, 
   l_indd022_inayl003 LIKE type_t.chr1000, 
   l_indd032_inayl003 LIKE type_t.chr1000, 
   l_indd033_inab003 LIKE type_t.chr1000, 
   l_indd023_inab003 LIKE type_t.chr1000, 
   l_indc000_desc LIKE type_t.chr100, 
   l_indc002_desc LIKE type_t.chr100, 
   l_indc102_desc LIKE type_t.chr100, 
   l_indc06_ooefl003 LIKE type_t.chr100, 
   l_indc101_ooefl003 LIKE type_t.chr100, 
   l_in LIKE type_t.chr1000, 
   l_out LIKE type_t.chr1000, 
   indc000 LIKE indc_t.indc000, 
   indd034 LIKE indd_t.indd034, 
   indc001 LIKE indc_t.indc001
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING,                  #where condition 
       a1 LIKE type_t.chr1          #多倉儲批號
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

TYPE sr4_r RECORD
   inao008_1 LIKE inao_t.inao008,            #製造批號
   inao009_1 LIKE inao_t.inao009,            #製造序號
   inao008_2 LIKE inao_t.inao008,            #製造批號
   inao009_2 LIKE inao_t.inao009,            #製造序號
   inao008_3 LIKE inao_t.inao008,            #製造批號
   inao009_3 LIKE inao_t.inao009,            #製造序號 
   l_inao008_1_inao009_1 LIKE type_t.chr100, #批號/序號 1
   l_inao008_2_inao009_2 LIKE type_t.chr100, #批號/序號 2 
   l_inao008_3_inao009_3 LIKE type_t.chr100  #批號/序號 3   
   
END RECORD

TYPE sr5_r RECORD
   inao008 LIKE inao_t.inao008,          #製造批號
   inao009 LIKE inao_t.inao009           #製造序號
   END RECORD
   
TYPE sr6_r RECORD
   inao008_1 LIKE inao_t.inao008,            #製造批號
   inao012_1 LIKE inao_t.inao012,            #數量
   inao008_2 LIKE inao_t.inao008,            #製造批號
   inao012_2 LIKE inao_t.inao012,            #數量
   inao008_3 LIKE inao_t.inao008,            #製造批號
   inao012_3 LIKE inao_t.inao012,            #數量 
   l_inao008_1_inao012_1 LIKE type_t.chr100, #批號/數量 1
   l_inao008_2_inao012_2 LIKE type_t.chr100, #批號/數量 2 
   l_inao008_3_inao012_3 LIKE type_t.chr100  #批號/數量 3       
   
END RECORD 

TYPE sr7_r RECORD
   inao008 LIKE inao_t.inao008,          #製造批號
   inao012 LIKE inao_t.inao012           #數量
END RECORD
   

DEFINE sr5 DYNAMIC ARRAY OF sr5_r
DEFINE sr7 DYNAMIC ARRAY OF sr7_r

#str--add by yany 160720
TYPE sr8_r    RECORD
   indcdocno  LIKE indc_t.indcdocno,          #單號 
   item       LIKE imaa_t.imaa001,            #料件编号
   imaal003   LIKE imaal_t.imaal003,          #品名
   imaal004   LIKE imaal_t.imaal004,          #规格
   inam012    LIKE type_t.chr1000,            #特徵一值(顏色)
   inam014    LIKE type_t.chr1000,            #特徵二值(尺寸)
   inam018    LIKE type_t.chr1000,            #特徵四值(拉頭名稱)
   indd101    LIKE indd_t.indd101,            #来源单号
   indd006    LIKE indd_t.indd006,            #單位
   indd1031   LIKE indd_t.indd103,            #數量1
   indd1032   LIKE indd_t.indd103,            #數量2
   indd1033   LIKE indd_t.indd103,            #數量3
   indd1034   LIKE indd_t.indd103,            #數量4
   indd1035   LIKE indd_t.indd103,            #數量5
   indd1036   LIKE indd_t.indd103,            #數量6
   indd1037   LIKE indd_t.indd103,            #數量7
   indd1038   LIKE indd_t.indd103,            #數量8
   indd1039   LIKE indd_t.indd103,            #數量9
   indd1030   LIKE indd_t.indd103,            #數量10
   l_skip     LIKE type_t.chr1,
   condition  LIKE type_t.chr1000,            #分组条件
   indd002    LIKE indd_t.indd002             #料件编号
 END RECORD
DEFINE g_inam014        ARRAY[10] OF VARCHAR(1000)
DEFINE l_total          LIKE type_t.num10
TYPE r_sum   RECORD 
                 sum01  LIKE indd_t.indd103,
                 sum02  LIKE indd_t.indd103,
                 sum03  LIKE indd_t.indd103,
                 sum04  LIKE indd_t.indd103,
                 sum05  LIKE indd_t.indd103,
                 sum06  LIKE indd_t.indd103,
                 sum07  LIKE indd_t.indd103,
                 sum08  LIKE indd_t.indd103,
                 sum09  LIKE indd_t.indd103,
                 sum10  LIKE indd_t.indd103,
                 sum11  LIKE indd_t.indd103
             END RECORD
#end--add by yany 160720
#end add-point
 
{</section>}
 
{<section id="ainr330_g01.main" readonly="Y" >}
PUBLIC FUNCTION ainr330_g01(p_arg1,p_arg2)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr1         #tm.a1  多倉儲批號
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.a1 = p_arg2
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "ainr330_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL ainr330_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL ainr330_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL ainr330_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="ainr330_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION ainr330_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   LET g_select = " SELECT NULL,indc002,indc003,indc004,indc006,indc008,indc022,indc101,indc102,indc103,indc104, 
       indc105,indc106,indc107,indc108,indc151,indcdocdt,indcdocno,indcent,indcsite,indcstus,indcunit, 
       indd001,indd002,indd004,indd006,indd021,indd022,indd023,indd024,indd031,indd032,indd033,indd040, 
       indd101,indd102,indd103,indd104,indd105,indd106,indd109,indd151,indd152,inddseq,ooag_t.ooag011, 
       oofb_t.oofb011,oobxl_t.oobxl003,x.imaal_t_imaal003,x.t6_imaal004,x.oocal_t_oocal003,x.t5_oocal003, 
       x.inab_t_inab003,x.t8_inab003,trim(indc004)||'.'||trim(ooag_t.ooag011),trim(indcdocno)||'.'||trim(oobxl_t.oobxl003), 
       trim(indd022)||'.'||trim(x.t1_inayl003),trim(indd032)||'.'||trim(x.t2_inayl003),trim(indd033)||'.'||trim(x.inab_t_inab003),trim(indd023)||'.'||trim(x.t8_inab003),'','', 
       '','','','','',indc000,indd034,indc001"
#   #end add-point
#   LET g_select = " SELECT NULL,indc002,indc003,indc004,indc006,indc008,indc022,indc101,indc102,indc103, 
#       indc104,indc105,indc106,indc107,indc108,indc151,indcdocdt,indcdocno,indcent,indcsite,indcstus, 
#       indcunit,indd001,indd002,indd004,indd006,indd021,indd022,indd023,indd024,indd031,indd032,indd033, 
#       indd040,indd101,indd102,indd103,indd104,indd105,indd106,indd109,indd151,indd152,inddseq,( SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = indc_t.indc004 AND ooag_t.ooagent = indc_t.indcent), 
#       ( SELECT oofb011 FROM oofb_t WHERE oofb_t.oofb001 = indc_t.indc105 AND oofb_t.oofbent = indc_t.indcent), 
#       ( SELECT oobxl003 FROM oobxl_t WHERE oobxl_t.oobxl001 = indc_t.indcdocno AND oobxl_t.oobxlent = indc_t.indcent AND oobxl_t.oobxl002 = '" , 
#       g_dlang,"'" ,"),x.imaal_t_imaal003,x.t6_imaal004,x.oocal_t_oocal003,x.t5_oocal003,x.inab_t_inab003, 
#       x.t8_inab003,trim(indc004)||'.'||trim((SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = indc_t.indc004 AND ooag_t.ooagent = indc_t.indcent)), 
#       trim(indcdocno)||'.'||trim((SELECT oobxl003 FROM oobxl_t WHERE oobxl_t.oobxl001 = indc_t.indcdocno AND oobxl_t.oobxlent = indc_t.indcent AND oobxl_t.oobxl002 = '" , 
#       g_dlang,"'" ,")),'','',trim(indd033)||'.'||trim(x.inab_t_inab003),trim(indd023)||'.'||trim(x.t8_inab003), 
#       '','','','','','','',indc000,indd034,indc001"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
    LET g_from = " FROM indc_t LEFT OUTER JOIN ooag_t ON ooag_t.ooag001 = indc_t.indc004 AND ooag_t.ooagent = indc_t.indcent             LEFT OUTER JOIN oobxl_t ON oobxl_t.oobxl001 = indc_t.indcdocno AND oobxl_t.oobxlent = indc_t.indcent AND oobxl_t.oobxl002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN oofb_t ON oofb_t.oofb001 = indc_t.indc105 AND oofb_t.oofbent = indc_t.indcent LEFT OUTER JOIN ( SELECT indd_t.*, 
        imaal_t.imaal003 imaal_t_imaal003,t6.imaal004 t6_imaal004,oocal_t.oocal003 oocal_t_oocal003, 
        t5.oocal003 t5_oocal003,inab_t.inab003 inab_t_inab003,t1.inayl003 t1_inayl003,t2.inayl003 t2_inayl003,t8.inab003 t8_inab003 FROM indd_t LEFT OUTER JOIN oocal_t ON oocal_t.oocal001 = indd_t.indd104 AND oocal_t.oocalent = indd_t.inddent AND oocal_t.oocal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN imaal_t ON imaal_t.imaalent = indd_t.inddent AND imaal_t.imaal001 = indd_t.indd002 AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN inab_t ON inab_t.inabsite = indd_t.inddsite AND inab_t.inab001 = indd_t.indd032 AND inab_t.inab002 = indd_t.indd033 AND inab_t.inabent = indd_t.inddent             LEFT OUTER JOIN oocal_t t5 ON t5.oocalent = indd_t.inddent AND t5.oocal001 = indd_t.indd006 AND t5.oocal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN imaal_t t6 ON t6.imaal001 = indd_t.indd002 AND t6.imaalent = indd_t.inddent AND t6.imaal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN inayl_t t1 ON t1.inaylent = indd_t.inddent AND t1.inayl001 = indd_t.indd022 AND t1.inayl002 = '" ,
        g_dlang,"'" ,"             LEFT OUTER JOIN inayl_t t2 ON t2.inaylent = indd_t.inddent AND t2.inayl001 = indd_t.indd032 AND t2.inayl002 = '" ,
        g_dlang,"'" ,"             LEFT OUTER JOIN inab_t t8 ON t8.inabsite = indd_t.inddsite AND t8.inab001  
        = indd_t.indd022 AND t8.inab002 = indd_t.indd023 AND t8.inabent = indd_t.inddent ) x  ON indc_t.indcent  
        = x.inddent AND indc_t.indcdocno = x.indddocno"
#   #end add-point
#    LET g_from = " FROM indc_t LEFT OUTER JOIN ( SELECT indd_t.*,( SELECT imaal003 FROM imaal_t WHERE imaal_t.imaalent = indd_t.inddent AND imaal_t.imaal001 = indd_t.indd002 AND imaal_t.imaal002 = '" , 
#        g_dlang,"'" ,") imaal_t_imaal003,( SELECT imaal004 FROM imaal_t WHERE imaal_t.imaal001 = indd_t.indd002 AND imaal_t.imaalent = indd_t.inddent AND imaal_t.imaal002 = '" , 
#        g_dlang,"'" ,") t6_imaal004,( SELECT oocal003 FROM oocal_t WHERE oocal_t.oocal001 = indd_t.indd104 AND oocal_t.oocalent = indd_t.inddent AND oocal_t.oocal002 = '" , 
#        g_dlang,"'" ,") oocal_t_oocal003,( SELECT oocal003 FROM oocal_t WHERE oocal_t.oocalent = indd_t.inddent AND oocal_t.oocal001 = indd_t.indd006 AND oocal_t.oocal002 = '" , 
#        g_dlang,"'" ,") t5_oocal003,( SELECT inab003 FROM inab_t WHERE inab_t.inabsite = indd_t.inddsite AND inab_t.inab001 = indd_t.indd032 AND inab_t.inab002 = indd_t.indd033 AND inab_t.inabent = indd_t.inddent) inab_t_inab003, 
#        ( SELECT inab003 FROM inab_t WHERE inab_t.inabsite = indd_t.inddsite AND inab_t.inab001 = indd_t.indd022  
#        AND inab_t.inab002 = indd_t.indd023 AND inab_t.inabent = indd_t.inddent) t8_inab003 FROM indd_t  
#        ) x  ON indc_t.indcent = x.inddent AND indc_t.indcdocno = x.indddocno"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
    LET g_order = " ORDER BY indcdocno,indd002,inddseq"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("indc_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE ainr330_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE ainr330_g01_curs CURSOR FOR ainr330_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="ainr330_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION ainr330_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   l_condition LIKE type_t.chr1000, 
   indc002 LIKE indc_t.indc002, 
   indc003 LIKE indc_t.indc003, 
   indc004 LIKE indc_t.indc004, 
   indc006 LIKE indc_t.indc006, 
   indc008 LIKE indc_t.indc008, 
   indc022 LIKE indc_t.indc022, 
   indc101 LIKE indc_t.indc101, 
   indc102 LIKE indc_t.indc102, 
   indc103 LIKE indc_t.indc103, 
   indc104 LIKE indc_t.indc104, 
   indc105 LIKE indc_t.indc105, 
   indc106 LIKE indc_t.indc106, 
   indc107 LIKE indc_t.indc107, 
   indc108 LIKE indc_t.indc108, 
   indc151 LIKE indc_t.indc151, 
   indcdocdt LIKE indc_t.indcdocdt, 
   indcdocno LIKE indc_t.indcdocno, 
   indcent LIKE indc_t.indcent, 
   indcsite LIKE indc_t.indcsite, 
   indcstus LIKE indc_t.indcstus, 
   indcunit LIKE indc_t.indcunit, 
   indd001 LIKE indd_t.indd001, 
   indd002 LIKE indd_t.indd002, 
   indd004 LIKE indd_t.indd004, 
   indd006 LIKE indd_t.indd006, 
   indd021 LIKE indd_t.indd021, 
   indd022 LIKE indd_t.indd022, 
   indd023 LIKE indd_t.indd023, 
   indd024 LIKE indd_t.indd024, 
   indd031 LIKE indd_t.indd031, 
   indd032 LIKE indd_t.indd032, 
   indd033 LIKE indd_t.indd033, 
   indd040 LIKE indd_t.indd040, 
   indd101 LIKE indd_t.indd101, 
   indd102 LIKE indd_t.indd102, 
   indd103 LIKE indd_t.indd103, 
   indd104 LIKE indd_t.indd104, 
   indd105 LIKE indd_t.indd105, 
   indd106 LIKE indd_t.indd106, 
   indd109 LIKE indd_t.indd109, 
   indd151 LIKE indd_t.indd151, 
   indd152 LIKE indd_t.indd152, 
   inddseq LIKE indd_t.inddseq, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   oofb_t_oofb011 LIKE oofb_t.oofb011, 
   oobxl_t_oobxl003 LIKE oobxl_t.oobxl003, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   x_t6_imaal004 LIKE imaal_t.imaal004, 
   x_oocal_t_oocal003 LIKE oocal_t.oocal003, 
   x_t5_oocal003 LIKE oocal_t.oocal003, 
   x_inab_t_inab003 LIKE inab_t.inab003, 
   x_t8_inab003 LIKE inab_t.inab003, 
   l_indc004_ooag011 LIKE type_t.chr300, 
   l_indcdocno_oobxl003 LIKE type_t.chr1000, 
   l_indd022_inayl003 LIKE type_t.chr1000, 
   l_indd032_inayl003 LIKE type_t.chr1000, 
   l_indd033_inab003 LIKE type_t.chr1000, 
   l_indd023_inab003 LIKE type_t.chr1000, 
   l_indc000_desc LIKE type_t.chr100, 
   l_indc002_desc LIKE type_t.chr100, 
   l_indc102_desc LIKE type_t.chr100, 
   l_indc06_ooefl003 LIKE type_t.chr100, 
   l_indc101_ooefl003 LIKE type_t.chr100, 
   l_in LIKE type_t.chr1000, 
   l_out LIKE type_t.chr1000, 
   indc000 LIKE indc_t.indc000, 
   indd034 LIKE indd_t.indd034, 
   indc001 LIKE indc_t.indc001
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
#str--add by yany 2016/07/20
DEFINE l_colorsize      LIKE type_t.chr100
DEFINE l_indd004_desc   LIKE type_t.chr100
DEFINE l_inam012        LIKE type_t.chr1000
DEFINE l_inam014        LIKE type_t.chr1000
DEFINE l_inam018        LIKE type_t.chr1000
DEFINE l_inam012_desc   LIKE type_t.chr100
DEFINE l_inam014_desc   LIKE type_t.chr100
DEFINE l_inam018_desc   LIKE type_t.chr100
DEFINE l_imec003        LIKE imec_t.imec003
DEFINE l_imaa005        LIKE imaa_t.imaa005
DEFINE l_imeb012        LIKE imeb_t.imeb012
DEFINE l_imecl005       LIKE imecl_t.imecl005
DEFINE tok              base.StringTokenizer
DEFINE l_cnt2           LIKE type_t.num10
DEFINE l_success        LIKE type_t.num5
#end--add by yany 2016/07/20
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    #str--add by yany 2016/07/20
    CALL ainr330_g01_erwei_tmp_table()   
    LET g_sql = " INSERT INTO ainr330_g01_temp01(indcdocno,item,imaal003,imaal004,inam012,inam014,inam018,indd101,indd006,indd103,condition) VALUES (?,?,?,?,?,?,?,?,?,?,?) "              
    PREPARE master_tmp FROM g_sql   
    #end--add by yany 2016/07/20
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH ainr330_g01_curs INTO sr_s.*
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
       #調撥類型
       CALL s_desc_gzcbl004_desc('2082',sr_s.indc000) RETURNING sr_s.l_indc000_desc
        
       #來源類型  
       CALL s_desc_gzcbl004_desc('6016',sr_s.indc002) RETURNING sr_s.l_indc002_desc
       
       #檢驗方式
       #160112-00014#1-mod-(S)
#       CALL s_desc_gzcbl004_desc('6016',sr_s.indc102) RETURNING sr_s.l_indc102_desc
       CALL s_desc_gzcbl004_desc('2081',sr_s.indc102) RETURNING sr_s.l_indc102_desc
       #160112-00014#1-mod-(E)   
       
       #撥入據點 
       INITIALIZE sr_s.l_indc06_ooefl003  TO NULL
       CALL s_desc_get_department_desc(sr_s.indc006) RETURNING sr_s.l_indc06_ooefl003
       LET sr_s.l_indc06_ooefl003 = sr_s.indc006,".",sr_s.l_indc06_ooefl003
       
       #調撥部門 
       INITIALIZE sr_s.l_indc101_ooefl003  TO NULL
       CALL s_desc_get_department_desc(sr_s.indc101) RETURNING sr_s.l_indc101_ooefl003
       LET sr_s.l_indc101_ooefl003 = sr_s.indc101,".",sr_s.l_indc101_ooefl003
       
       #二階段調撥的撥入倉儲批
       IF sr_s.indc000 = '2' THEN
          SELECT indd032,indd033,indd034 
            INTO sr_s.indd032,sr_s.indd033,sr_s.indd034
            FROM indd_t
           WHERE indddocno = sr_s.indc001
             AND inddseq = sr_s.inddseq
             AND inddent = g_enterprise   #160905-00007#4 by 08172
       
          CALL s_desc_get_stock_desc(sr_s.indcsite,sr_s.indd032) RETURNING sr_s.l_indd032_inayl003
             
          SELECT inab003 INTO sr_s.l_indd033_inab003 
            FROM inab_t
           WHERE inabent = sr_s.indcent        
             AND inabsite =sr_s.indcsite
             AND inab002 = sr_s.indd032    
                      
          CALL s_desc_get_locator_desc(sr_s.indcsite,sr_s.indd032,sr_s.indd033) RETURNING sr_s.l_indd033_inab003
          LET sr_s.l_indd032_inayl003 = sr_s.indd032,'.',sr_s.l_indd032_inayl003
          LET sr_s.l_indd033_inab003 = sr_s.indd033,'.',sr_s.l_indd033_inab003
       
       END IF
       
       #modify--2015/02/04 By Shiun--(S)
       #當前面編號為空時，清空編號.說明的字串(避免編號為空會只顯示一個 .)
       CALL ainr330_g01_initialize(sr_s.indd022,sr_s.l_indd022_inayl003) RETURNING sr_s.l_indd022_inayl003
       CALL ainr330_g01_initialize(sr_s.indd032,sr_s.l_indd032_inayl003) RETURNING sr_s.l_indd032_inayl003
       CALL ainr330_g01_initialize(sr_s.indd023,sr_s.l_indd023_inab003) RETURNING sr_s.l_indd023_inab003
       CALL ainr330_g01_initialize(sr_s.indd033,sr_s.l_indd033_inab003) RETURNING sr_s.l_indd033_inab003
       CALL ainr330_g01_initialize(sr_s.indc004,sr_s.l_indc004_ooag011) RETURNING sr_s.l_indc004_ooag011
       CALL ainr330_g01_initialize(sr_s.indc101,sr_s.l_indc101_ooefl003) RETURNING sr_s.l_indc101_ooefl003
       #modify--2015/02/04 By Shiun--(E)
       
       LET sr_s.l_out = sr_s.l_indd022_inayl003,'/',sr_s.l_indd023_inab003,'/',sr_s.indd024,'/',sr_s.indd102   
       LET sr_s.l_in = sr_s.l_indd032_inayl003,'/',sr_s.l_indd033_inab003,'/',sr_s.indd034,'/',sr_s.indd102 
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       #str--add by yany 2016/07/20
       #取特征值（颜色+尺码）
       CALL s_feature_description(sr_s.indd002,sr_s.indd004) RETURNING l_success,l_colorsize
       LET l_indd004_desc = l_colorsize
       #若品名为空，赋值料件编号
       IF cl_null(sr_s.x_imaal_t_imaal003) THEN
          LET sr_s.x_imaal_t_imaal003 = sr_s.indd002
       END IF 
       #end--add by yany 2016/07/20
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].l_condition = sr_s.l_condition
       LET sr[l_cnt].indc002 = sr_s.indc002
       LET sr[l_cnt].indc003 = sr_s.indc003
       LET sr[l_cnt].indc004 = sr_s.indc004
       LET sr[l_cnt].indc006 = sr_s.indc006
       LET sr[l_cnt].indc008 = sr_s.indc008
       LET sr[l_cnt].indc022 = sr_s.indc022
       LET sr[l_cnt].indc101 = sr_s.indc101
       LET sr[l_cnt].indc102 = sr_s.indc102
       LET sr[l_cnt].indc103 = sr_s.indc103
       LET sr[l_cnt].indc104 = sr_s.indc104
       LET sr[l_cnt].indc105 = sr_s.indc105
       LET sr[l_cnt].indc106 = sr_s.indc106
       LET sr[l_cnt].indc107 = sr_s.indc107
       LET sr[l_cnt].indc108 = sr_s.indc108
       LET sr[l_cnt].indc151 = sr_s.indc151
       LET sr[l_cnt].indcdocdt = sr_s.indcdocdt
       LET sr[l_cnt].indcdocno = sr_s.indcdocno
       LET sr[l_cnt].indcent = sr_s.indcent
       LET sr[l_cnt].indcsite = sr_s.indcsite
       LET sr[l_cnt].indcstus = sr_s.indcstus
       LET sr[l_cnt].indcunit = sr_s.indcunit
       LET sr[l_cnt].indd001 = sr_s.indd001
       LET sr[l_cnt].indd002 = sr_s.indd002
       LET sr[l_cnt].indd004 = sr_s.indd004
       LET sr[l_cnt].indd006 = sr_s.indd006
       LET sr[l_cnt].indd021 = sr_s.indd021
       LET sr[l_cnt].indd022 = sr_s.indd022
       LET sr[l_cnt].indd023 = sr_s.indd023
       LET sr[l_cnt].indd024 = sr_s.indd024
       LET sr[l_cnt].indd031 = sr_s.indd031
       LET sr[l_cnt].indd032 = sr_s.indd032
       LET sr[l_cnt].indd033 = sr_s.indd033
       LET sr[l_cnt].indd040 = sr_s.indd040
       LET sr[l_cnt].indd101 = sr_s.indd101
       LET sr[l_cnt].indd102 = sr_s.indd102
       LET sr[l_cnt].indd103 = sr_s.indd103
       LET sr[l_cnt].indd104 = sr_s.indd104
       LET sr[l_cnt].indd105 = sr_s.indd105
       LET sr[l_cnt].indd106 = sr_s.indd106
       LET sr[l_cnt].indd109 = sr_s.indd109
       LET sr[l_cnt].indd151 = sr_s.indd151
       LET sr[l_cnt].indd152 = sr_s.indd152
       LET sr[l_cnt].inddseq = sr_s.inddseq
       LET sr[l_cnt].ooag_t_ooag011 = sr_s.ooag_t_ooag011
       LET sr[l_cnt].oofb_t_oofb011 = sr_s.oofb_t_oofb011
       LET sr[l_cnt].oobxl_t_oobxl003 = sr_s.oobxl_t_oobxl003
       LET sr[l_cnt].x_imaal_t_imaal003 = sr_s.x_imaal_t_imaal003
       LET sr[l_cnt].x_t6_imaal004 = sr_s.x_t6_imaal004
       LET sr[l_cnt].x_oocal_t_oocal003 = sr_s.x_oocal_t_oocal003
       LET sr[l_cnt].x_t5_oocal003 = sr_s.x_t5_oocal003
       LET sr[l_cnt].x_inab_t_inab003 = sr_s.x_inab_t_inab003
       LET sr[l_cnt].x_t8_inab003 = sr_s.x_t8_inab003
       LET sr[l_cnt].l_indc004_ooag011 = sr_s.l_indc004_ooag011
       LET sr[l_cnt].l_indcdocno_oobxl003 = sr_s.l_indcdocno_oobxl003
       LET sr[l_cnt].l_indd022_inayl003 = sr_s.l_indd022_inayl003
       LET sr[l_cnt].l_indd032_inayl003 = sr_s.l_indd032_inayl003
       LET sr[l_cnt].l_indd033_inab003 = sr_s.l_indd033_inab003
       LET sr[l_cnt].l_indd023_inab003 = sr_s.l_indd023_inab003
       LET sr[l_cnt].l_indc000_desc = sr_s.l_indc000_desc
       LET sr[l_cnt].l_indc002_desc = sr_s.l_indc002_desc
       LET sr[l_cnt].l_indc102_desc = sr_s.l_indc102_desc
       LET sr[l_cnt].l_indc06_ooefl003 = sr_s.l_indc06_ooefl003
       LET sr[l_cnt].l_indc101_ooefl003 = sr_s.l_indc101_ooefl003
       LET sr[l_cnt].l_in = sr_s.l_in
       LET sr[l_cnt].l_out = sr_s.l_out
       LET sr[l_cnt].indc000 = sr_s.indc000
       LET sr[l_cnt].indd034 = sr_s.indd034
       LET sr[l_cnt].indc001 = sr_s.indc001
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       #str--add by yany 2016/07/20
       LET sr_s.l_condition="-",sr_s.indd022,"-",sr_s.indd023,"-",sr_s.indd024,"-",sr_s.indd032,"-",sr_s.indd033,"-",sr_s.indd034,"-"
       LET sr[l_cnt].l_condition = sr_s.l_condition
       IF NOT cl_null(sr_s.indd004) THEN   #存在特征值
          LET l_imaa005 = NULL
          SELECT imaa005 INTO l_imaa005 FROM imaa_t 
           WHERE imaaent = g_enterprise 
             and imaa001 = sr_s.indd002
          LET l_inam012 = NULL
          LET l_inam014 = NULL
          LET l_inam018 = NULL
       
       #分别取颜色和尺码特征值
       LET l_cnt2 = 1
       LET tok = base.StringTokenizer.createExt(sr_s.indd004,'_','',TRUE)
       WHILE tok.hasMoreTokens()
           LET l_imec003 = tok.nextToken()
           LET l_imeb012 = 'N'
           SELECT imeb012 INTO l_imeb012 FROM imeb_t
            WHERE imebent = g_enterprise 
              AND imeb002 = l_cnt2
              AND imeb001 = l_imaa005
           case l_imeb012
              #纵向
              when 'N'
                 LET l_imecl005=NULL
                 SELECT imecl005 INTO l_imecl005 FROM imec_t LEFT OUTER JOIN imecl_t 
                     ON imecent=imeclent AND imec001=imecl001 AND imec002=imecl002 AND imec003=imecl003  AND imecl004=g_lang
                  WHERE imecent=g_enterprise AND imec001=l_imaa005 AND imec002=l_cnt2
                    AND imec003=l_imec003 AND imecstus = 'Y'
                 IF cl_null(l_inam012) THEN
                    LET l_inam012 = l_imec003,'·',l_imecl005
                 ELSE
                    LET l_inam012 = l_inam012,'/',l_imec003,'·',l_imecl005
                 END IF 
              #横向
              when 'Y'
                 LET l_imecl005 = NULL
                 SELECT imecl005 INTO l_imecl005 FROM imec_t
                   LEFT OUTER JOIN imecl_t
                     ON imecent=imeclent AND imec001=imecl001 AND imec002=imecl002 AND imec003=imecl003  AND imecl004=g_lang
                  WHERE imecent=g_enterprise AND imec001=l_imaa005 AND imec002=l_cnt2
                    AND imec003=l_imec003 AND imecstus = 'Y'
                 LET l_inam014 = l_imec003,'-',l_imecl005
              otherwise
                 exit while
           end case 
           LET l_cnt2 = l_cnt2 + 1
       END WHILE
        
       IF NOT cl_null(l_inam012) AND cl_null(l_inam014) THEN
           LET l_inam014 = "t-*"
       END IF
       IF NOT cl_null(l_inam012) AND NOT cl_null(l_inam014) THEN
           EXECUTE master_tmp USING sr_s.indcdocno,sr_s.indd002,sr_s.x_imaal_t_imaal003,sr_s.x_t6_imaal004,l_inam012,l_inam014,
                                    l_inam018,sr_s.indd101,sr_s.indd006,sr_s.indd103,sr_s.l_condition       
       END IF
       END IF
       #end--add by yany 2016/07/20
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="ainr330_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION ainr330_g01_rep_data()
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
          START REPORT ainr330_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT ainr330_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT ainr330_g01_rep
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
 
{<section id="ainr330_g01.rep" readonly="Y" >}
PRIVATE REPORT ainr330_g01_rep(sr1)
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
#DEFINE sr3       sr3_r
DEFINE sr4       sr4_r
DEFINE sr6       sr6_r
DEFINE l_indc008_show           LIKE type_t.chr1  #單頭備註
DEFINE l_indd152_show           LIKE type_t.chr1  #單身備註
DEFINE l_indd004_show           LIKE type_t.chr1  #料件管理特徵
DEFINE l_subrep06_show          LIKE type_t.chr5
DEFINE l_subrep07_show          LIKE type_t.chr5
DEFINE l_ac            INTEGER
#DEFINE l_i             INTEGER

#str--add by yany 2016/07/20
DEFINE sr8              sr8_r
DEFINE l_sql            STRING      
DEFINE l_inam014_cnt    LIKE type_t.num10
DEFINE l_pageno         LIKE type_t.num10
DEFINE l_i              LIKE type_t.num10
DEFINE l_inam014        LIKE type_t.chr1000 
DEFINE l_subrep08_show  LIKE type_t.chr1
DEFINE l_item           LIKE type_t.chr1000
DEFINE l_indd103_sum    LIKE indd_t.indd103
#end--add by yany 2016/07/20

#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER EXTERNAL BY sr1.indcdocno,sr1.indd002,sr1.l_condition
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
        BEFORE GROUP OF sr1.indcdocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.indcdocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'indcent=' ,sr1.indcent,'{+}indcdocno=' ,sr1.indcdocno         
            CALL cl_gr_init_apr(sr1.indcdocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.indcdocno.before name="rep.b_group.indcdocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.indcent CLIPPED ,"'", " AND  ooff003 = '", sr1.indcdocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE ainr330_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE ainr330_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT ainr330_g01_subrep01
           DECLARE ainr330_g01_repcur01 CURSOR FROM g_sql
           FOREACH ainr330_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "ainr330_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT ainr330_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT ainr330_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.indcdocno.after name="rep.b_group.indcdocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.indd002
 
           #add-point:rep.b_group.indd002.before name="rep.b_group.indd002.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.indd002.after name="rep.b_group.indd002.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.l_condition
 
           #add-point:rep.b_group.l_condition.before name="rep.b_group.l_condition.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.l_condition.after name="rep.b_group.l_condition.after"
           
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
                sr1.indcent CLIPPED ,"'", " AND  ooff003 = '", sr1.indcdocno CLIPPED ,"'"
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE ainr330_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE ainr330_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT ainr330_g01_subrep02
           DECLARE ainr330_g01_repcur02 CURSOR FROM g_sql
           FOREACH ainr330_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "ainr330_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT ainr330_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT ainr330_g01_subrep02
           #add-point:rep.sub02.after name="rep.sub02.after"
           
           #end add-point:rep.sub02.after
 
 
 
          #add-point:rep.everyrow.beforerow name="rep.everyrow.beforerow"
            #單頭備註是否隱藏
            CALL ainr330_g01_show(sr1.indc008,'','') RETURNING l_indc008_show
            PRINTX l_indc008_show
            #單身備註是否隱藏
            CALL ainr330_g01_show(sr1.indd152,'','') RETURNING l_indd152_show
            PRINTX l_indd152_show
            #料件管理特徵隱藏
            CALL ainr330_g01_show(sr1.indd004,'','') RETURNING l_indd004_show
            PRINTX l_indd004_show
            
          #end add-point:rep.everyrow.beforerow
            
          PRINTX sr1.*
 
          #add-point:rep.everyrow.afterrow name="rep.everyrow.afterrow"
          INITIALIZE l_subrep06_show TO NULL
          LET l_subrep06_show = "N"            
          START REPORT ainr330_g01_subrep06                   
          IF tm.a1 ="Y" AND NOT cl_null(sr1.inddseq) THEN
             IF cl_null(sr1.indd023) THEN LET sr1.indd023 = ' ' END IF   #160315-00013#1 add
             LET g_sql = "SELECT inao008,inao009",
                         "  FROM inao_t",
                         " WHERE inaoent = '",sr1.indcent CLIPPED,"'",
                         "   AND inaosite = '",sr1.indcsite CLIPPED,"'",
                         "   AND inaodocno = '",sr1.indcdocno CLIPPED,"'",
                         "   AND inaoseq = '",sr1.inddseq CLIPPED,"'",
                         "   AND inao008 IS NOT NULL",
                         "   AND inao009 IS NOT NULL",
                         "   AND inao005 = '",sr1.indd022,"'",  #160315-00013#1 add
                         "   AND inao006 = '",sr1.indd023,"'"   #160315-00013#1 add
             LET l_ac = 1                              
             CALL sr5.clear()                 
             DECLARE ainr330_g01_repcur06 CURSOR FROM g_sql
             FOREACH ainr330_g01_repcur06 INTO sr5[l_ac].*  
                 LET l_ac = l_ac+1                                
             END FOREACH      
             LET l_ac = l_ac-1               
             LET l_i = 1
                                     
             IF l_ac > 0 THEN  
                LET l_subrep06_show = "Y"                
                WHILE TRUE                         
                   INITIALIZE sr4.* TO NULL
                   LET sr4.inao008_1 = sr5[l_i].inao008
                   LET sr4.inao009_1 = sr5[l_i].inao009
                   LET sr4.l_inao008_1_inao009_1  = sr4.inao008_1  , "/" , sr4.inao009_1                                                                                         
                   IF l_i+1 <= l_ac THEN    
                      LET sr4.inao008_2 = sr5[l_i+1].inao008
                      LET sr4.inao009_2 = sr5[l_i+1].inao009
                      LET sr4.l_inao008_2_inao009_2 =  sr4.inao008_2 , "/" , sr4.inao009_2                              
                   END IF
                    
                   IF l_i+2 <= l_ac THEN    
                      LET sr4.inao008_3 = sr5[l_i+2].inao008
                      LET sr4.inao009_3 = sr5[l_i+2].inao009                  
                      LET sr4.l_inao008_3_inao009_3 = sr4.inao008_3 , "/" , sr4.inao009_3
                   END IF              
                          
                   OUTPUT TO REPORT ainr330_g01_subrep06(sr4.*)              
                   LET l_i = l_i + 3
                   IF l_i > l_ac THEN  
                      EXIT WHILE
                   END IF                     
                END WHILE                                                
             END IF                    
          END IF                      
          FINISH REPORT ainr330_g01_subrep06
          PRINTX l_subrep06_show                     
            
          #######################################################################################
          INITIALIZE l_subrep07_show TO NULL
          LET l_subrep07_show = "N"
          START REPORT ainr330_g01_subrep07            
          IF tm.a1 ="Y" AND NOT cl_null(sr1.inddseq) THEN                          
             IF cl_null(sr1.indd023) THEN LET sr1.indd023 = ' ' END IF   #160315-00013#1 add
             LET g_sql = "SELECT inao008,inao012",
                         "  FROM inao_t ",
                         " WHERE inaoent = '",sr1.indcent CLIPPED,"'",
                         "   AND inaosite = '",sr1.indcsite CLIPPED,"'",
                         "   AND inaodocno = '",sr1.indcdocno CLIPPED,"'",
                         "   AND inaoseq = '",sr1.inddseq CLIPPED,"'",
                         "   AND inao008 IS NOT NULL ",
                         "   AND inao009 IS NULL ",
                         "   AND inao005 = '",sr1.indd022,"'",  #160315-00013#1 add
                         "   AND inao006 = '",sr1.indd023,"'"   #160315-00013#1 add
             LET l_ac = 1                              
             CALL sr7.clear()                 
             DECLARE ainr330_g01_repcur07 CURSOR FROM g_sql
             FOREACH ainr330_g01_repcur07 INTO sr7[l_ac].*  
                 LET l_ac = l_ac+1                                
             END FOREACH      
             LET l_ac = l_ac-1               
             LET l_i = 1             
            
             IF l_ac > 0 THEN
                LET l_subrep07_show = "Y"
                WHILE TRUE                         
                   INITIALIZE sr6.* TO NULL
                   LET sr6.inao008_1 = sr7[l_i].inao008
                   LET sr6.inao012_1 = sr7[l_i].inao012
                   LET sr6.l_inao008_1_inao012_1  = sr6.inao008_1  , "/" , sr6.inao012_1                                                                                         
                   IF l_i+1 <= l_ac THEN    
                      LET sr6.inao008_2 = sr7[l_i+1].inao008
                      LET sr6.inao012_2 = sr7[l_i+1].inao012
                      LET sr6.l_inao008_2_inao012_2 =  sr6.inao008_2 , "/" , sr6.inao012_2                              
                   END IF
                   
                   IF l_i+2 <= l_ac THEN    
                      LET sr6.inao008_3 = sr7[l_i+2].inao008
                      LET sr6.inao012_3 = sr7[l_i+2].inao012                  
                      LET sr6.l_inao008_3_inao012_3 = sr6.inao008_3 , "/" , sr6.inao012_3
                   END IF              
                          
                   OUTPUT TO REPORT ainr330_g01_subrep07(sr6.*)              
                   LET l_i = l_i + 3
                   IF l_i > l_ac THEN  
                      EXIT WHILE
                   END IF                     
                END  WHILE 
             END IF                    
          END IF
                     
                     
          FINISH REPORT ainr330_g01_subrep07  
          PRINTX l_subrep07_show
          #end add-point:rep.everyrow.afterrow
 
          #單身後備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub03.before name="rep.sub03.before"
           
           #end add-point:rep.sub03.before
 
           #add-point:rep.sub03.sql name="rep.sub03.sql"
           
           #end add-point:rep.sub03.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooff003 = '", 
                sr1.indcent CLIPPED ,"'"
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE ainr330_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE ainr330_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT ainr330_g01_subrep03
           DECLARE ainr330_g01_repcur03 CURSOR FROM g_sql
           FOREACH ainr330_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "ainr330_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT ainr330_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT ainr330_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.indcdocno
 
           #add-point:rep.a_group.indcdocno.before name="rep.a_group.indcdocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.indcent CLIPPED ,"'", " AND  ooff003 = '", sr1.indcdocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE ainr330_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE ainr330_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT ainr330_g01_subrep04
           DECLARE ainr330_g01_repcur04 CURSOR FROM g_sql
           FOREACH ainr330_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "ainr330_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT ainr330_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT ainr330_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.indcdocno.after name="rep.a_group.indcdocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.indd002
 
           #add-point:rep.a_group.indd002.before name="rep.a_group.indd002.before"
          
           #end add-point:
 
 
           #add-point:rep.a_group.indd002.after name="rep.a_group.indd002.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.l_condition
 
           #add-point:rep.a_group.l_condition.before name="rep.a_group.l_condition.before"
           #str--add by yany 2016/07/20
           DROP TABLE inam014_tmp
           CREATE TEMP TABLE inam014_tmp
           (
              i          decimal(5,0),
              inam014     VARCHAR(1000)
           )

           DROP TABLE indd_print_tmp         
           CREATE TEMP TABLE indd_print_tmp
           (
           indcdocno   VARCHAR(20),               #單號 
           item        VARCHAR(40),                 #料件编号
           imaal003    VARCHAR(255),               #品名
           imaal004    VARCHAR(255),               #规格
           inam012     VARCHAR(1000),                 #特徵一值(顏色)
           inam014     VARCHAR(1000),                 #特徵二值(尺寸)
           inam018     VARCHAR(1000),                 #特徵四值(拉頭名稱)           
           indd101     VARCHAR(20),                 #来源单号
           indd006     VARCHAR(10),                 #單位
           indd1031    DECIMAL(20,6),                 #數量1
           indd1032    DECIMAL(20,6),                 #數量2
           indd1033    DECIMAL(20,6),                 #數量3
           indd1034    DECIMAL(20,6),                 #數量4
           indd1035    DECIMAL(20,6),                 #數量5
           indd1036    DECIMAL(20,6),                 #數量6
           indd1037    DECIMAL(20,6),                 #數量7
           indd1038    DECIMAL(20,6),                 #數量8
           indd1039    DECIMAL(20,6),                 #數量9
           indd1030    DECIMAL(20,6),                 #數量10
           l_skip      VARCHAR(1),
           condition   VARCHAR(1000)     #分组条件           
           )
   
           LET l_sub_sql = " SELECT DISTINCT inam014 FROM ainr330_g01_temp01 ",
                           "  WHERE indcdocno=? and imaal003=? and condition =? and item =? ",
                           "  ORDER BY inam014"
           PREPARE inam014_ins FROM l_sub_sql
           DECLARE inam014_ins_cs CURSOR FOR inam014_ins

           #計算橫軸個數
           LET l_sql = "SELECT COUNT(1) FROM (",l_sub_sql,")"
           PREPARE inam014_cnt_pre FROM l_sql            
           
           EXECUTE inam014_cnt_pre INTO l_inam014_cnt USING sr1.indcdocno,sr1.x_imaal_t_imaal003,sr1.l_condition,sr1.indd002  
           FREE inam014_cnt_pre
             
           --总合计
           
           LET l_sub_sql = " SELECT SUM(indd103) FROM ainr330_g01_temp01 ",
                           "  WHERE indcdocno = ? "
           PREPARE indd103_total_sum FROM l_sub_sql        
          
           #總計(合計)   
           LET l_sub_sql = " SELECT SUM(indd103) FROM ainr330_g01_temp01 ",
                           "  WHERE indcdocno =? and imaal003 =?  and condition =? and item =? "
           PREPARE indd103_total FROM l_sub_sql
       
              
           IF NOT cl_null(l_inam014_cnt) THEN
              LET l_pageno = (l_inam014_cnt -1)/10   #每頁10筆
              LET l_pageno = l_pageno +1
         
              DELETE FROM inam014_tmp WHERE 1=1
              OPEN inam014_ins_cs USING sr1.indcdocno,sr1.x_imaal_t_imaal003,sr1.l_condition,sr1.indd002  
              LET l_i =1
              FOREACH inam014_ins_cs INTO l_inam014
                 INSERT INTO inam014_tmp VALUES(l_i,l_inam014)
                 LET l_i=l_i+1
              END FOREACH
          
              FOR l_i = 1 to l_pageno
                 CALL ainr330_g01_ins_erwei_temp(sr1.indcdocno,sr1.x_imaal_t_imaal003,l_i,sr1.l_condition,sr1.indd002)
              END FOR  
           END IF           
          
           
           LET g_sql = " SELECT A.*,'",sr1.indd002,"' FROM indd_print_tmp A WHERE 1=1 "
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep08_show = "N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE ainr330_g01_repcur08_cnt_pre FROM l_sub_sql
           EXECUTE ainr330_g01_repcur08_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep08_show = "Y"
           END IF
           --调用子报表
           PRINTX l_subrep08_show 
           START REPORT ainr330_g01_subrep08
           LET g_sql = g_sql, " ORDER BY 1,3,4 "
           DECLARE ainr330_g01_repcur08 CURSOR FROM g_sql
           FOREACH ainr330_g01_repcur08 INTO sr8.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "ainr330_g01_repcur08:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
             
              OUTPUT TO REPORT ainr330_g01_subrep08(sr8.*) --subrep08中印出
           END FOREACH
           FINISH REPORT ainr330_g01_subrep08 
          
           --打印总合计
           LET l_indd103_sum = 0
           EXECUTE indd103_total INTO l_indd103_sum USING sr1.indcdocno,sr1.x_imaal_t_imaal003,sr1.l_condition,sr1.indd002  
           PRINTX l_indd103_sum  
           #end--add by yany 2016/07/20
           #end add-point:
 
 
           #add-point:rep.a_group.l_condition.after name="rep.a_group.l_condition.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="ainr330_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT ainr330_g01_subrep01(sr2)
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
PRIVATE REPORT ainr330_g01_subrep02(sr2)
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
PRIVATE REPORT ainr330_g01_subrep03(sr2)
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
PRIVATE REPORT ainr330_g01_subrep04(sr2)
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
 
{<section id="ainr330_g01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 欄位隱藏
# Memo...........:
# Usage..........: ainr330_g01_show()
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION ainr330_g01_show(p_arg1,p_arg2,p_arg3)
   DEFINE p_arg1 LIKE type_t.chr1000
   DEFINE p_arg2 LIKE type_t.chr1000
   DEFINE p_arg3 LIKE type_t.chr1000
   DEFINE r_show LIKE type_t.chr1

      IF cl_null(p_arg1) AND cl_null(p_arg2) AND cl_null(p_arg3) THEN
         LET r_show = "N"
      ELSE
         LET r_show = "Y"
      END IF
      RETURN r_show
END FUNCTION

################################################################################
# Descriptions...: 當編號為空時清空編號.說明字串
# Usage..........: CALL ainr330_g01_initialize(p_arg,p_exp)
#                  RETURNING r_exp
# Input parameter: p_arg   編號
#                : p_exp   編號.說明
# Return code....: r_exp   編號.說明
# Date & Author..: 2015/02/04 By Shiun
################################################################################
PRIVATE FUNCTION ainr330_g01_initialize(p_arg,p_exp)
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

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/07/20 By yany
# Modify.........:
################################################################################
PRIVATE FUNCTION ainr330_g01_erwei_tmp_table()
   #str--add by yany 2016/07/20
   DROP TABLE ainr330_g01_temp01;

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ainr330_g01_temp01'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_rep_success = 'N'
      RETURN
   END IF
   CREATE TEMP TABLE ainr330_g01_temp01(  
                   indcdocno   VARCHAR(20),               #單號  
                   item        VARCHAR(40),                 #料件编号
                   imaal003    VARCHAR(255),               #品名
                   imaal004    VARCHAR(255),               #规格
                   inam012     VARCHAR(1000),                 #特徵一值(顏色)
                   inam014     VARCHAR(1000),                 #特徵二值(尺寸)
                   inam018     VARCHAR(1000),                 #特徵四值(拉頭名稱)
                   indd101     VARCHAR(20),                 #来源单号
                   indd006     VARCHAR(10),                 #單位                  
                   indd103     DECIMAL(20,6),                 #數量  
                   condition   VARCHAR(1000)
                   )

   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create ainr330_g01_temp01'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_rep_success = 'N'
      RETURN
   END IF
   #end--add by yany 2016/07/20
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/07/20 By yany
# Modify.........:
################################################################################
PRIVATE FUNCTION ainr330_g01_ins_erwei_temp(p_indcdocno,p_imaal003,p_i,p_condition,p_item)
#str--add by yany 2016/07/20
#--計算交叉表數值區資料總和--
DEFINE p_indcdocno  LIKE indc_t.indcdocno
DEFINE p_imaal003   LIKE imaal_t.imaal003
DEFINE p_condition  LIKE type_t.chr1000
DEFINE p_item       LIKE type_t.chr100
DEFINE p_i          LIKE type_t.num5
DEFINE l_n          LIKE type_t.num5
DEFINE l_i          LIKE type_t.num5
DEFINE l_max        LIKE type_t.num5
DEFINE l_max2       LIKE type_t.num5
DEFINE l_a          LIKE type_t.num5
DEFINE l_b          LIKE type_t.num5
DEFINE l_sql        STRING
DEFINE l_indd103    STRING
DEFINE l_vi         varchar(3)
DEFINE i            LIKE type_t.num5

   CALL g_inam014.clear()
   
   LET l_n = 0
   SELECT COUNT(DISTINCT inam014) INTO l_n FROM ainr330_g01_temp01
    WHERE indcdocno = p_indcdocno 
      AND imaal003 = p_imaal003
      AND item = p_item 
      AND condition = p_condition
   LET l_i = (l_n-1)/10
   LET l_i = l_i +1
   IF l_i = p_i THEN
      LET l_max = l_n
   ELSE
      LET l_max = p_i*10
   END IF

   IF l_max mod 10 = 0 THEN 
      LET l_max2 = 10
   ELSE
      LET l_max2 = l_max mod 10
   END IF

   LET l_a = p_i*10-9
   LET l_b = p_i*10
   LET l_sql = " SELECT inam014 FROM inam014_tmp",
               "  WHERE i >=? and i<=? ",
               "  ORDER BY i "
   PREPARE inam014_pr FROM l_sql
   DECLARE inam014_cs CURSOR FOR inam014_pr
   OPEN inam014_cs USING l_a,l_b
   LET i = 1
   FOREACH inam014_cs INTO g_inam014[i]
      IF i = l_max2 THEN
         EXIT FOREACH
      ELSE
         LET i = i +1
      END IF
   END FOREACH
   
   LET l_sql = " INSERT INTO indd_print_tmp(indcdocno,item,imaal003,imaal004,inam012,inam014,inam018,indd101,indd006,condition "
   FOR i=1 to l_max2
      CASE i WHEN 1  LET l_indd103 = 'indd1031'
             WHEN 2  LET l_indd103 = 'indd1032'
             WHEN 3  LET l_indd103 = 'indd1033'
             WHEN 4  LET l_indd103 = 'indd1034'
             WHEN 5  LET l_indd103 = 'indd1035'
             WHEN 6  LET l_indd103 = 'indd1036'
             WHEN 7  LET l_indd103 = 'indd1037'
             WHEN 8  LET l_indd103 = 'indd1038'
             WHEN 9  LET l_indd103 = 'indd1039'           
             WHEN 10 LET l_indd103 = 'indd1030'
      END CASE
      LET l_sql = l_sql , ",",l_indd103
   END FOR
   
   LET l_sql = l_sql," ) SELECT indcdocno,item,imaal003,imaal004,inam012,'','',indd101,indd006,condition "
   FOR i=1 to l_max2
      LET l_vi = i
      LET l_sql = l_sql," ,sum(A",l_vi,")"
   END FOR
   LET l_sql = l_sql,"  FROM ( SELECT indcdocno,item,imaal003,imaal004,inam012,inam014,inam018,indd101,indd006,condition "
 
   FOR i=1 to l_max2
      LET l_vi = i
      LET l_sql = l_sql,",CASE WHEN inam014 = '",g_inam014[i],"'",
                        " THEN indd103 ELSE 0 END A",l_vi
   END FOR
   LET l_sql = l_sql,  "  FROM ainr330_g01_temp01 ",
                       " WHERE indcdocno='",p_indcdocno,"'",
                       "   AND imaal003 = '",p_imaal003,"'",
                       "   AND item = '",p_item,"'",
                       "   AND condition ='",p_condition,"'",
                       "   ) ",
                       " GROUP BY indcdocno,item,imaal003,imaal004,inam012,indd101,indd006,condition "
                              
   PREPARE indd_print_pr FROM l_sql
   DELETE FROM indd_print_tmp WHERE 1=1
   EXECUTE indd_print_pr
   
   UPDATE indd_print_tmp  SET l_skip = "N"
    WHERE indcdocno = p_indcdocno 
      AND imaal003 = p_imaal003 
      AND item = p_item
      AND inam014 = g_inam014[l_max2] 
      
#end--add by yany 2016/07/20
END FUNCTION

 
{</section>}
 
{<section id="ainr330_g01.other_report" readonly="Y" >}

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
PRIVATE REPORT ainr330_g01_subrep06(sr4)
DEFINE sr4 sr4_r     
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
REPORT ainr330_g01_subrep07(sr6)
DEFINE sr6 sr6_r
   FORMAT           
      ON EVERY ROW
         PRINTX g_grNumFmt.*
         PRINTX sr6.*
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
# Date & Author..: 2016/07/20 By yany
# Modify.........:
################################################################################
PRIVATE REPORT ainr330_g01_subrep08(sr8)
#str--add by yany 2016/07/20
DEFINE sr8             sr8_r
DEFINE sr4             sr4_r
DEFINE sr6             sr6_r
DEFINE l_sum           r_sum
DEFINE l_ac            INTEGER
DEFINE l_i             INTEGER
DEFINE l_count         INTEGER
DEFINE l_subrep06_show     LIKE type_t.chr5
DEFINE l_subrep07_show     LIKE type_t.chr5
DEFINE l_inam0141      LIKE type_t.chr1000
DEFINE l_inam0142      LIKE type_t.chr1000
DEFINE l_inam0143      LIKE type_t.chr1000
DEFINE l_inam0144      LIKE type_t.chr1000
DEFINE l_inam0145      LIKE type_t.chr1000
DEFINE l_inam0146      LIKE type_t.chr1000
DEFINE l_inam0147      LIKE type_t.chr1000
DEFINE l_inam0148      LIKE type_t.chr1000
DEFINE l_inam0149      LIKE type_t.chr1000
DEFINE l_inam01410     LIKE type_t.chr1000
DEFINE l_indd103_sum   LIKE type_t.num15_3
DEFINE l_indd103_total LIKE type_t.num15_3
DEFINE l_title         LIKE type_t.chr1000
DEFINE l_sql           LIKE type_t.chr1000

    ORDER EXTERNAL BY sr8.indcdocno
    FORMAT
       BEFORE GROUP OF sr8.indcdocno  --子報表中動態顯示title及計算總和
           SELECT substr(g_inam014[1],instr(g_inam014[1],'-')+1,Length(g_inam014[1])) INTO l_inam0141  FROM DUAL         
           SELECT substr(g_inam014[2],instr(g_inam014[2],'-')+1,Length(g_inam014[2])) INTO l_inam0142  FROM DUAL 
           SELECT substr(g_inam014[3],instr(g_inam014[3],'-')+1,Length(g_inam014[3])) INTO l_inam0143  FROM DUAL 
           SELECT substr(g_inam014[4],instr(g_inam014[4],'-')+1,Length(g_inam014[4])) INTO l_inam0144  FROM DUAL 
           SELECT substr(g_inam014[5],instr(g_inam014[5],'-')+1,Length(g_inam014[5])) INTO l_inam0145  FROM DUAL 
           SELECT substr(g_inam014[6],instr(g_inam014[6],'-')+1,Length(g_inam014[6])) INTO l_inam0146  FROM DUAL 
           SELECT substr(g_inam014[7],instr(g_inam014[7],'-')+1,Length(g_inam014[7])) INTO l_inam0147  FROM DUAL 
           SELECT substr(g_inam014[8],instr(g_inam014[8],'-')+1,Length(g_inam014[8])) INTO l_inam0148  FROM DUAL 
           SELECT substr(g_inam014[9],instr(g_inam014[9],'-')+1,Length(g_inam014[9])) INTO l_inam0149  FROM DUAL 
           SELECT substr(g_inam014[10],instr(g_inam014[10],'-')+1,Length(g_inam014[10])) INTO l_inam01410  FROM DUAL 
           INITIALIZE l_sum.* TO NULL
           LET l_title = NULL
           LET l_sql= " select listagg(oocql004,'/') within group(order by imeb001,imeb002) ",
                      "   from imeb_t,oocql_t ",
                      " where imebent = oocqlent ",
                      "   and oocql001 = '273' ",
                      "   and oocql002 = imeb004 ",
                      "   and imeb001=(SELECT DISTINCT imaa005 FROM imaa_t WHERE imaaent='",g_enterprise,"' AND imaa001='",sr8.item,"') ",
                      "   and imebent='",g_enterprise,"' ",
                      "   and imeb012='N'",
                      "   and oocql003='",g_dlang,"'"
           PREPARE ainr330_g01_title_pre FROM l_sql
           EXECUTE ainr330_g01_title_pre into l_title
           PRINTX tm.*
           
           INITIALIZE l_subrep06_show TO NULL
           INITIALIZE l_subrep07_show TO NULL
           LET l_subrep06_show = "N"   
           IF tm.a1 = "Y"  THEN
#              IF cl_null(sr1.indd023) THEN LET sr1.indd023 = ' ' END IF 
              LET g_sql = "SELECT inao008,inao009",
                         "  FROM inao_t,indd_t ",
                         " WHERE inaoent = '",g_enterprise CLIPPED,"'",
                         "   AND inaosite = '",g_site CLIPPED,"'",
                         "   AND inaodocno = '",sr8.indcdocno CLIPPED,"'",
                         "   AND indd002 = '",sr8.item CLIPPED,"'",
                         "   AND inaoent = inddent AND inaosite = inddsite AND inaodocno = indddocno AND inaoseq = inddseq",
                         "   AND '-'||indd022||'-'||indd023||'-'||indd024||'-'||indd032||'-'||indd033||'-'||indd034||'-' = '",sr8.condition,"'", 
                         "   AND inao008 IS NOT NULL",
                         "   AND inao009 IS NOT NULL"
#                         "   AND inao005 = '",sr1.indd022,"'",  #160315-00013#1 add
#                         "   AND inao006 = '",sr1.indd023,"'"   #160315-00013#1 add
             LET l_ac = 1                              
             CALL sr5.clear()              
             DECLARE ainr330_g01_2_repcur06 CURSOR FROM g_sql
             FOREACH ainr330_g01_2_repcur06 INTO sr5[l_ac].*  
                 LET l_ac = l_ac+1                                
             END FOREACH      
             LET l_ac = l_ac-1               
             LET l_i = 1
                                     
             IF l_ac > 0 THEN  
                LET l_subrep06_show = "Y"                
                WHILE TRUE                         
                   INITIALIZE sr4.* TO NULL
                   LET sr4.inao008_1 = sr5[l_i].inao008
                   LET sr4.inao009_1 = sr5[l_i].inao009
                   LET sr4.l_inao008_1_inao009_1  = sr4.inao008_1  , "/" , sr4.inao009_1                                                                                         
                   IF l_i+1 <= l_ac THEN    
                      LET sr4.inao008_2 = sr5[l_i+1].inao008
                      LET sr4.inao009_2 = sr5[l_i+1].inao009
                      LET sr4.l_inao008_2_inao009_2 =  sr4.inao008_2 , "/" , sr4.inao009_2                              
                   END IF
                    
                   IF l_i+2 <= l_ac THEN    
                      LET sr4.inao008_3 = sr5[l_i+2].inao008
                      LET sr4.inao009_3 = sr5[l_i+2].inao009                  
                      LET sr4.l_inao008_3_inao009_3 = sr4.inao008_3 , "/" , sr4.inao009_3
                   END IF              
                          
                   PRINTX sr4.*             
                   LET l_i = l_i + 3
                   IF l_i > l_ac THEN  
                      EXIT WHILE
                   END IF                     
                END WHILE                                                
             END IF                    
             PRINTX l_subrep06_show
             
             
             LET l_subrep07_show = "N"   
             LET g_sql = "SELECT inao008,inao012",
                         "  FROM inao_t,indd_t ",
                         " WHERE inaoent = '",g_enterprise CLIPPED,"'",
                         "   AND inaosite = '",g_site CLIPPED,"'",
                         "   AND inaodocno = '",sr8.indcdocno CLIPPED,"'",
                         "   AND indd002 = '",sr8.item,"'",
                         "   AND inaoent = inddent AND inaosite = inddsite AND inaodocno = indddocno AND inaoseq = inddseq",
                         "   AND '-'||indd022||'-'||indd023||'-'||indd024||'-'||indd032||'-'||indd033||'-'||indd034||'-' = '",sr8.condition,"'", 
                         "   AND inao008 IS NOT NULL ",
                         "   AND inao009 IS NULL "
#                         "   AND inao005 = '",sr1.indd022,"'",  #160315-00013#1 add
#                         "   AND inao006 = '",sr1.indd023,"'"   #160315-00013#1 add
             LET l_ac = 1                              
             CALL sr7.clear()            
             DECLARE ainr330_g01_2_repcur07 CURSOR FROM g_sql
             FOREACH ainr330_g01_2_repcur07 INTO sr7[l_ac].*  
                 LET l_ac = l_ac+1                                
             END FOREACH      
             LET l_ac = l_ac-1               
             LET l_i = 1             
            
             IF l_ac > 0 THEN
                LET l_subrep07_show = "Y"
                WHILE TRUE                         
                   INITIALIZE sr6.* TO NULL
                   LET sr6.inao008_1 = sr7[l_i].inao008
                   LET sr6.inao012_1 = sr7[l_i].inao012
                   LET sr6.l_inao008_1_inao012_1  = sr6.inao008_1  , "/" , sr6.inao012_1                                                                                         
                   IF l_i+1 <= l_ac THEN    
                      LET sr6.inao008_2 = sr7[l_i+1].inao008
                      LET sr6.inao012_2 = sr7[l_i+1].inao012
                      LET sr6.l_inao008_2_inao012_2 =  sr6.inao008_2 , "/" , sr6.inao012_2                              
                   END IF
                   
                   IF l_i+2 <= l_ac THEN    
                      LET sr6.inao008_3 = sr7[l_i+2].inao008
                      LET sr6.inao012_3 = sr7[l_i+2].inao012                  
                      LET sr6.l_inao008_3_inao012_3 = sr6.inao008_3 , "/" , sr6.inao012_3
                   END IF              
                          
                   PRINTX sr6.*             
                   LET l_i = l_i + 3
                   IF l_i > l_ac THEN  
                      EXIT WHILE
                   END IF                     
                END  WHILE 
             END IF           
          END IF
          PRINTX l_subrep07_show
          
           PRINTX l_inam0141
           PRINTX l_inam0142
           PRINTX l_inam0143
           PRINTX l_inam0144
           PRINTX l_inam0145
           PRINTX l_inam0146
           PRINTX l_inam0147
           PRINTX l_inam0148
           PRINTX l_inam0149
           PRINTX l_inam01410  
           PRINTX l_title
           
        ON EVERY ROW
            PRINTX g_grNumFmt.*
#            SELECT substr(sr8.inam012,instr(sr8.inam012,'-')+1,Length(sr8.inam012)) INTO sr8.inam012  FROM DUAL 
            PRINTX sr8.*
            LET l_indd103_sum = 0
            IF cl_null(sr8.indd1031) THEN LET sr8.indd1031 = 0 END IF            
            IF cl_null(sr8.indd1032) THEN LET sr8.indd1032 = 0 END IF            
            IF cl_null(sr8.indd1033) THEN LET sr8.indd1033 = 0 END IF           
            IF cl_null(sr8.indd1034) THEN LET sr8.indd1034 = 0 END IF            
            IF cl_null(sr8.indd1035) THEN LET sr8.indd1035 = 0 END IF            
            IF cl_null(sr8.indd1036) THEN LET sr8.indd1036 = 0 END IF          
            IF cl_null(sr8.indd1037) THEN LET sr8.indd1037 = 0 END IF            
            IF cl_null(sr8.indd1038) THEN LET sr8.indd1038 = 0 END IF            
            IF cl_null(sr8.indd1039) THEN LET sr8.indd1039 = 0 END IF           
            IF cl_null(sr8.indd1030) THEN LET sr8.indd1030 = 0 END IF              
            
            #横向小計
            LET l_indd103_sum = sr8.indd1031+sr8.indd1032+sr8.indd1033+sr8.indd1034+sr8.indd1035
                               +sr8.indd1036+sr8.indd1037+sr8.indd1038+sr8.indd1039+sr8.indd1030
            PRINTX l_indd103_sum   
            #纵向小计
            IF cl_null(l_sum.sum01) THEN LET  l_sum.sum01= 0 END IF            
            IF cl_null(l_sum.sum02) THEN LET  l_sum.sum02= 0 END IF            
            IF cl_null(l_sum.sum03) THEN LET  l_sum.sum03= 0 END IF           
            IF cl_null(l_sum.sum04) THEN LET  l_sum.sum04= 0 END IF            
            IF cl_null(l_sum.sum05) THEN LET  l_sum.sum05= 0 END IF            
            IF cl_null(l_sum.sum06) THEN LET  l_sum.sum06= 0 END IF          
            IF cl_null(l_sum.sum07) THEN LET  l_sum.sum07= 0 END IF            
            IF cl_null(l_sum.sum08) THEN LET  l_sum.sum08= 0 END IF            
            IF cl_null(l_sum.sum09) THEN LET  l_sum.sum09= 0 END IF           
            IF cl_null(l_sum.sum10) THEN LET  l_sum.sum10= 0 END IF
            IF cl_null(l_sum.sum11) THEN LET  l_sum.sum11= 0 END IF
            LET l_sum.sum01=l_sum.sum01+ sr8.indd1031 
            LET l_sum.sum02=l_sum.sum02+ sr8.indd1032 
            LET l_sum.sum03=l_sum.sum03+ sr8.indd1033 
            LET l_sum.sum04=l_sum.sum04+ sr8.indd1034 
            LET l_sum.sum05=l_sum.sum05+ sr8.indd1035 
            LET l_sum.sum06=l_sum.sum06+ sr8.indd1036 
            LET l_sum.sum07=l_sum.sum07+ sr8.indd1037 
            LET l_sum.sum08=l_sum.sum08+ sr8.indd1038 
            LET l_sum.sum09=l_sum.sum09+ sr8.indd1039 
            LET l_sum.sum10=l_sum.sum10+ sr8.indd1030 
                     
        
        AFTER GROUP OF sr8.indcdocno
            #横向总计
            EXECUTE indd103_total INTO l_indd103_total USING sr8.indcdocno,sr8.imaal003,sr8.condition,sr8.item
            IF cl_null(l_indd103_total) THEN LET l_indd103_total = 0 END IF
            PRINTX l_indd103_total  
            
            --总合计mxh
            LET l_total = 0
            EXECUTE indd103_total_sum INTO l_total USING sr8.indcdocno
            IF cl_null(l_total) THEN LET l_total = 0 END IF
            
            #纵向小计
            LET l_sum.sum11 = l_sum.sum01+l_sum.sum02+l_sum.sum03+l_sum.sum04+l_sum.sum05
                             +l_sum.sum06+l_sum.sum07+l_sum.sum08+l_sum.sum09+l_sum.sum10
            PRINTX l_sum.*
            
#end--add by yany 2016/07/20
END REPORT

 
{</section>}
 
