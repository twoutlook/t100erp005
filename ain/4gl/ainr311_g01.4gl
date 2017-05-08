#該程式未解開Section, 採用最新樣板產出!
{<section id="ainr311_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:8(2016-10-31 21:40:58), PR版次:0008(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000117
#+ Filename...: ainr311_g01
#+ Description: ...
#+ Creator....: 05384(2014-06-13 17:31:02)
#+ Modifier...: 08734 -SD/PR- 00000
 
{</section>}
 
{<section id="ainr311_g01.global" readonly="Y" >}
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
   l_condition LIKE type_t.chr1000, 
   inbi000 LIKE inbi_t.inbi000, 
   inbi001 LIKE inbi_t.inbi001, 
   inbi002 LIKE inbi_t.inbi002, 
   inbi004 LIKE inbi_t.inbi004, 
   inbi007 LIKE inbi_t.inbi007, 
   inbi021 LIKE inbi_t.inbi021, 
   inbi031 LIKE inbi_t.inbi031, 
   inbi032 LIKE inbi_t.inbi032, 
   inbidocdt LIKE inbi_t.inbidocdt, 
   inbidocno LIKE inbi_t.inbidocno, 
   inbient LIKE inbi_t.inbient, 
   inbisite LIKE inbi_t.inbisite, 
   inbistus LIKE inbi_t.inbistus, 
   inbj001 LIKE inbj_t.inbj001, 
   inbj002 LIKE inbj_t.inbj002, 
   inbj003 LIKE inbj_t.inbj003, 
   inbj004 LIKE inbj_t.inbj004, 
   inbj005 LIKE inbj_t.inbj005, 
   inbj006 LIKE inbj_t.inbj006, 
   inbj007 LIKE inbj_t.inbj007, 
   inbj008 LIKE inbj_t.inbj008, 
   inbj009 LIKE inbj_t.inbj009, 
   inbj011 LIKE inbj_t.inbj011, 
   inbj012 LIKE inbj_t.inbj012, 
   inbj014 LIKE inbj_t.inbj014, 
   inbj015 LIKE inbj_t.inbj015, 
   inbj016 LIKE inbj_t.inbj016, 
   inbj017 LIKE inbj_t.inbj017, 
   inbj018 LIKE inbj_t.inbj018, 
   inbj031 LIKE inbj_t.inbj031, 
   inbjseq LIKE inbj_t.inbjseq, 
   inbjsite LIKE inbj_t.inbjsite, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   x_t1_ooefl003 LIKE ooefl_t.ooefl003, 
   oobxl_t_oobxl003 LIKE oobxl_t.oobxl003, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   x_inab_t_inab003 LIKE inab_t.inab003, 
   x_t2_inab003 LIKE inab_t.inab003, 
   x_oocql_t_oocql004 LIKE oocql_t.oocql004, 
   l_inbi002_ooefl003 LIKE type_t.chr1000, 
   l_inbidocno_oobxl003 LIKE type_t.chr1000, 
   l_inbi001_ooag011 LIKE type_t.chr300, 
   l_inbj017_ooefl003 LIKE type_t.chr1000, 
   l_inbj015_inab003 LIKE type_t.chr1000, 
   l_inbj006_inab003 LIKE type_t.chr1000, 
   l_inbj005_inayl003 LIKE type_t.chr1000, 
   inbjent LIKE inbj_t.inbjent, 
   inbjdocno LIKE inbj_t.inbjdocno, 
   x_imaal_t_imaal004 LIKE imaal_t.imaal004, 
   l_inbj016_desc LIKE oocql_t.oocql004, 
   l_inbi021_show LIKE type_t.chr1, 
   l_inbj031_show LIKE type_t.chr1, 
   l_inbj002_inbj003_show LIKE type_t.chr1, 
   l_imaal004_inbj007_show LIKE type_t.chr1, 
   l_imaal003_inbj006_show LIKE type_t.chr1, 
   l_inbj005_inayl003_show LIKE type_t.chr1, 
   l_inbj006_inab003_show LIKE type_t.chr1, 
   l_inbj017_ooefl003_show LIKE type_t.chr1, 
   l_inbj016_show LIKE type_t.chr1
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING,                  #where condition 
       a1 LIKE type_t.chr1          #製造批序號
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
   inaodocno LIKE inao_t.inaodocno,
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
   inaodocno LIKE inao_t.inaodocno,
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
TYPE sr6_r RECORD
   inaodocno LIKE inao_t.inaodocno,
   inao008   LIKE inao_t.inao008,          #製造批號
   inao009   LIKE inao_t.inao009           #製造序號
   END RECORD
TYPE sr7_r RECORD
   inaodocno LIKE inao_t.inaodocno,
   inao008   LIKE inao_t.inao008,          #製造批號
   inao012   LIKE inao_t.inao012           #數量
END RECORD
DEFINE sr6 DYNAMIC ARRAY OF sr6_r
DEFINE sr7 DYNAMIC ARRAY OF sr7_r
#add by liuxsa 160728-str
TYPE t_erwei RECORD
   docno      LIKE type_t.chr100,             #單號 
   item       LIKE imaa_t.imaa001,            #料件编号
   imaal003   LIKE imaal_t.imaal003,          #品名
   inam012    LIKE type_t.chr1000,            #特徵一值(顏色)
   inam014    LIKE type_t.chr1000,            #特徵二值(尺寸)
   inam018    LIKE type_t.chr1000,            #特徵四值(拉頭名稱)
   unit       LIKE type_t.chr10,              #單位
   qty001     LIKE type_t.num20_6,            #數量1
   qty002     LIKE type_t.num20_6,            #數量2
   qty003     LIKE type_t.num20_6,            #數量3
   qty004     LIKE type_t.num20_6,            #數量4
   qty005     LIKE type_t.num20_6,            #數量5
   qty006     LIKE type_t.num20_6,            #數量6
   qty007     LIKE type_t.num20_6,            #數量7
   qty008     LIKE type_t.num20_6,            #數量8
   qty009     LIKE type_t.num20_6,            #數量9
   qty010     LIKE type_t.num20_6,            #數量10
   l_skip     LIKE type_t.chr1,
   condition  LIKE type_t.chr1000,
   price      LIKE type_t.num20_6             #单价   
 END RECORD
DEFINE g_inam014        ARRAY[10] OF VARCHAR(1000)
DEFINE l_total LIKE type_t.num10
#纵向合计
TYPE r_sum   RECORD 
                 sum01  LIKE type_t.num20_6, 
                 sum02  LIKE type_t.num20_6,
                 sum03  LIKE type_t.num20_6,
                 sum04  LIKE type_t.num20_6,
                 sum05  LIKE type_t.num20_6,
                 sum06  LIKE type_t.num20_6,
                 sum07  LIKE type_t.num20_6,
                 sum08  LIKE type_t.num20_6,
                 sum09  LIKE type_t.num20_6,
                 sum10  LIKE type_t.num20_6,
                 sum11  LIKE type_t.num20_6
             END RECORD
#add by liuxsa 160728-end-
#end add-point
 
{</section>}
 
{<section id="ainr311_g01.main" readonly="Y" >}
PUBLIC FUNCTION ainr311_g01(p_arg1,p_arg2)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr1         #tm.a1  製造批序號
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
   
   LET g_rep_code = "ainr311_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL ainr311_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL ainr311_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL ainr311_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="ainr311_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION ainr311_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   LET g_select = " SELECT null,inbi000,inbi001,inbi002,inbi004,inbi007,inbi021,inbi031,inbi032,inbidocdt, 
       inbidocno,inbient,inbisite,inbistus,inbj001,inbj002,inbj003,inbj004,inbj005,inbj006,inbj007,inbj008, 
       inbj009,inbj011,inbj012,inbj014,inbj015,inbj016,inbj017,inbj018,inbj031,inbjseq,inbjsite,ooag_t.ooag011, 
       ooefl_t.ooefl003,x.t1_ooefl003,oobxl_t.oobxl003,x.imaal_t_imaal003,x.inab_t_inab003,x.t2_inab003, 
       x.oocql_t_oocql004,trim(inbi002)||'.'||trim(ooefl_t.ooefl003),trim(inbidocno)||'.'||trim(oobxl_t.oobxl003), 
       trim(inbi001)||'.'||trim(ooag_t.ooag011),trim(inbj017)||'.'||trim(x.t1_ooefl003),trim(inbj015)||'.'||trim(x.inab_t_inab003), 
       trim(inbj006)||'.'||trim(x.t2_inab003),trim(inbj005)||'.'||trim(x.inayl_t_inayl003),inbjent,inbjdocno,x.imaal_t_imaal004,'','','','','', 
       '','','','',''"
#   #end add-point
#   LET g_select = " SELECT NULL,inbi000,inbi001,inbi002,inbi004,inbi007,inbi021,inbi031,inbi032,inbidocdt, 
#       inbidocno,inbient,inbisite,inbistus,inbj001,inbj002,inbj003,inbj004,inbj005,inbj006,inbj007,inbj008, 
#       inbj009,inbj011,inbj012,inbj014,inbj015,inbj016,inbj017,inbj018,inbj031,inbjseq,inbjsite,( SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = inbi_t.inbi001 AND ooag_t.ooagent = inbi_t.inbient), 
#       ( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = inbi_t.inbi002 AND ooefl_t.ooeflent = inbi_t.inbient AND ooefl_t.ooefl002 = '" , 
#       g_dlang,"'" ,"),x.t1_ooefl003,( SELECT oobxl003 FROM oobxl_t WHERE oobxl_t.oobxl001 = inbi_t.inbidocno AND oobxl_t.oobxlent = inbi_t.inbient AND oobxl_t.oobxl002 = '" , 
#       g_dlang,"'" ,"),x.imaal_t_imaal003,x.inab_t_inab003,x.t2_inab003,x.oocql_t_oocql004,trim(inbi002)||'.'||trim((SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = inbi_t.inbi002 AND ooefl_t.ooeflent = inbi_t.inbient AND ooefl_t.ooefl002 = '" , 
#       g_dlang,"'" ,")),trim(inbidocno)||'.'||trim((SELECT oobxl003 FROM oobxl_t WHERE oobxl_t.oobxl001 = inbi_t.inbidocno AND oobxl_t.oobxlent = inbi_t.inbient AND oobxl_t.oobxl002 = '" , 
#       g_dlang,"'" ,")),trim(inbi001)||'.'||trim((SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = inbi_t.inbi001 AND ooag_t.ooagent = inbi_t.inbient)), 
#       trim(inbj017)||'.'||trim(x.t1_ooefl003),trim(inbj015)||'.'||trim(x.inab_t_inab003),trim(inbj006)||'.'||trim(x.t2_inab003), 
#       '',inbjent,inbjdocno,x.imaal_t_imaal004,'','','','','','','','','',''"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
LET g_from = " FROM inbi_t LEFT OUTER JOIN oobxl_t ON oobxl_t.oobxl001 = inbi_t.inbidocno AND oobxl_t.oobxlent = inbi_t.inbient AND oobxl_t.oobxl002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN ooag_t ON ooag_t.ooag001 = inbi_t.inbi001 AND ooag_t.ooagent = inbi_t.inbient             LEFT OUTER JOIN ooefl_t ON ooefl_t.ooefl001 = inbi_t.inbi002 AND ooefl_t.ooeflent = inbi_t.inbient AND ooefl_t.ooefl002 = '" , 
        g_dlang,"'" ," LEFT OUTER JOIN ( SELECT inbj_t.*,t1.ooefl003 t1_ooefl003,imaal_t.imaal003 imaal_t_imaal003, 
        inayl_t.inayl003 inayl_t_inayl003,inab_t.inab003 inab_t_inab003,t2.inab003 t2_inab003,oocql_t.oocql004 oocql_t_oocql004,imaal_t.imaal004 imaal_t_imaal004 FROM inbj_t LEFT OUTER JOIN oocql_t ON oocql_t.oocql001 = '302' AND oocql_t.oocql002 = inbj_t.inbj016 AND oocql_t.oocqlent = inbj_t.inbjent AND oocql_t.oocql003 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN ooefl_t t1 ON t1.ooefl001 = inbj_t.inbj017 AND t1.ooeflent = inbj_t.inbjent AND t1.ooefl002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN inayl_t ON inayl_t.inaylent = inbj_t.inbjent AND inayl_t.inayl001 = inbj_t.inbj005 AND inayl_t.inayl002 = '" ,
        g_dlang,"'" ,"             LEFT OUTER JOIN inab_t ON inab_t.inab001 = inbj_t.inbj014 AND inab_t.inab002 = inbj_t.inbj015 AND inab_t.inabent = inbj_t.inbjent             LEFT OUTER JOIN inab_t t2 ON t2.inab001 = inbj_t.inbj005 AND t2.inab002 = inbj_t.inbj006 AND t2.inabent = inbj_t.inbjent AND  t2.inabsite = inbj_t.inbjsite            LEFT OUTER JOIN imaal_t ON imaal_t.imaal001 = inbj_t.inbj001 AND imaal_t.imaalent = inbj_t.inbjent AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ," ) x  ON inbi_t.inbient = x.inbjent AND inbi_t.inbidocno = x.inbjdocno"
#   #end add-point
#    LET g_from = " FROM inbi_t LEFT OUTER JOIN ( SELECT inbj_t.*,( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = inbj_t.inbj017 AND ooefl_t.ooeflent = inbj_t.inbjent AND ooefl_t.ooefl002 = '" , 
#        g_dlang,"'" ,") t1_ooefl003,( SELECT imaal003 FROM imaal_t WHERE imaal_t.imaal001 = inbj_t.inbj001 AND imaal_t.imaalent = inbj_t.inbjent AND imaal_t.imaal002 = '" , 
#        g_dlang,"'" ,") imaal_t_imaal003,( SELECT inab003 FROM inab_t WHERE inab_t.inab001 = inbj_t.inbj014 AND inab_t.inab002 = inbj_t.inbj015 AND inab_t.inabsite = inbj_t.inbjsite AND inab_t.inabent = inbj_t.inbjent) inab_t_inab003, 
#        ( SELECT inab003 FROM inab_t WHERE inab_t.inab001 = inbj_t.inbj005 AND inab_t.inab002 = inbj_t.inbj006 AND inab_t.inabsite = inbj_t.inbjsite AND inab_t.inabent = inbj_t.inbjent) t2_inab003, 
#        ( SELECT oocql004 FROM oocql_t WHERE oocql_t.oocql001 = '302' AND oocql_t.oocql002 = inbj_t.inbj016 AND oocql_t.oocqlent = inbj_t.inbjent AND oocql_t.oocql003 = '" , 
#        g_dlang,"'" ,") oocql_t_oocql004,( SELECT imaal004 FROM imaal_t WHERE imaal_t.imaal001 = inbj_t.inbj001 AND imaal_t.imaalent = inbj_t.inbjent AND imaal_t.imaal002 = '" , 
#        g_dlang,"'" ,") imaal_t_imaal004 FROM inbj_t ) x  ON inbi_t.inbient = x.inbjent AND inbi_t.inbidocno  
#        = x.inbjdocno"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE inbi_t.inbi000 = '2' AND " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
    LET g_order = " ORDER BY inbidocno,inbj001,inbjseq"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("inbi_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE ainr311_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE ainr311_g01_curs CURSOR FOR ainr311_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="ainr311_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION ainr311_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   l_condition LIKE type_t.chr1000, 
   inbi000 LIKE inbi_t.inbi000, 
   inbi001 LIKE inbi_t.inbi001, 
   inbi002 LIKE inbi_t.inbi002, 
   inbi004 LIKE inbi_t.inbi004, 
   inbi007 LIKE inbi_t.inbi007, 
   inbi021 LIKE inbi_t.inbi021, 
   inbi031 LIKE inbi_t.inbi031, 
   inbi032 LIKE inbi_t.inbi032, 
   inbidocdt LIKE inbi_t.inbidocdt, 
   inbidocno LIKE inbi_t.inbidocno, 
   inbient LIKE inbi_t.inbient, 
   inbisite LIKE inbi_t.inbisite, 
   inbistus LIKE inbi_t.inbistus, 
   inbj001 LIKE inbj_t.inbj001, 
   inbj002 LIKE inbj_t.inbj002, 
   inbj003 LIKE inbj_t.inbj003, 
   inbj004 LIKE inbj_t.inbj004, 
   inbj005 LIKE inbj_t.inbj005, 
   inbj006 LIKE inbj_t.inbj006, 
   inbj007 LIKE inbj_t.inbj007, 
   inbj008 LIKE inbj_t.inbj008, 
   inbj009 LIKE inbj_t.inbj009, 
   inbj011 LIKE inbj_t.inbj011, 
   inbj012 LIKE inbj_t.inbj012, 
   inbj014 LIKE inbj_t.inbj014, 
   inbj015 LIKE inbj_t.inbj015, 
   inbj016 LIKE inbj_t.inbj016, 
   inbj017 LIKE inbj_t.inbj017, 
   inbj018 LIKE inbj_t.inbj018, 
   inbj031 LIKE inbj_t.inbj031, 
   inbjseq LIKE inbj_t.inbjseq, 
   inbjsite LIKE inbj_t.inbjsite, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   x_t1_ooefl003 LIKE ooefl_t.ooefl003, 
   oobxl_t_oobxl003 LIKE oobxl_t.oobxl003, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   x_inab_t_inab003 LIKE inab_t.inab003, 
   x_t2_inab003 LIKE inab_t.inab003, 
   x_oocql_t_oocql004 LIKE oocql_t.oocql004, 
   l_inbi002_ooefl003 LIKE type_t.chr1000, 
   l_inbidocno_oobxl003 LIKE type_t.chr1000, 
   l_inbi001_ooag011 LIKE type_t.chr300, 
   l_inbj017_ooefl003 LIKE type_t.chr1000, 
   l_inbj015_inab003 LIKE type_t.chr1000, 
   l_inbj006_inab003 LIKE type_t.chr1000, 
   l_inbj005_inayl003 LIKE type_t.chr1000, 
   inbjent LIKE inbj_t.inbjent, 
   inbjdocno LIKE inbj_t.inbjdocno, 
   x_imaal_t_imaal004 LIKE imaal_t.imaal004, 
   l_inbj016_desc LIKE oocql_t.oocql004, 
   l_inbi021_show LIKE type_t.chr1, 
   l_inbj031_show LIKE type_t.chr1, 
   l_inbj002_inbj003_show LIKE type_t.chr1, 
   l_imaal004_inbj007_show LIKE type_t.chr1, 
   l_imaal003_inbj006_show LIKE type_t.chr1, 
   l_inbj005_inayl003_show LIKE type_t.chr1, 
   l_inbj006_inab003_show LIKE type_t.chr1, 
   l_inbj017_ooefl003_show LIKE type_t.chr1, 
   l_inbj016_show LIKE type_t.chr1
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
#add by liuxsa 160728-str-
DEFINE l_colorsize    LIKE type_t.chr100
DEFINE l_pmdn002_desc LIKE type_t.chr100
DEFINE l_inam012   LIKE type_t.chr1000
DEFINE l_inam014   LIKE type_t.chr1000
DEFINE l_inam018   LIKE type_t.chr1000
DEFINE l_inam012_desc   LIKE type_t.chr100
DEFINE l_inam014_desc   LIKE type_t.chr100
DEFINE l_inam018_desc   LIKE type_t.chr100
DEFINE tok         base.StringTokenizer
DEFINE l_cnt2      LIKE type_t.num10
DEFINE l_imec003       LIKE imec_t.imec003
DEFINE l_imaa005       LIKE imaa_t.imaa005
DEFINE l_imeb012    LIKE imeb_t.imeb012
DEFINE l_imecl005   LIKE imecl_t.imecl005
#add by liuxsa 160728-end-
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    #add by liuxsa 160728-str-  
    CALL ainr311_g01_erwei_tmp_table()   
    LET g_sql = " INSERT INTO erwei_temp(docno,item,imaal003,inam012,inam014,inam018,unit,qty,condition) ",
                " VALUES (?,?,?,?,?,?,?,?,?) "
    PREPARE master_tmp FROM g_sql   
    #add by liuxsa 160728-end-
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH ainr311_g01_curs INTO sr_s.*
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
       #報廢由碼(應用碼轉換)
       CALL s_desc_get_acc_desc('302',sr_s.inbj016) RETURNING sr_s.l_inbj016_desc
       #單頭備註顯是否
       CALL ainr311_g01_show(sr_s.inbi021,'','') 
       RETURNING sr_s.l_inbi021_show
       #單身備註顯是否(單身5)
       CALL ainr311_g01_show(sr_s.inbj031,'','') 
       RETURNING sr_s.l_inbj031_show
       #產品特徵/庫存管理特徵顯示否(單身4)
       CALL ainr311_g01_show(sr_s.inbj002,sr_s.inbj003,'') 
       RETURNING sr_s.l_inbj002_inbj003_show
       #產品規格/批號/報廢由碼顯示否(單身3)
       CALL ainr311_g01_show(sr_s.x_imaal_t_imaal004,sr_s.inbj007,sr_s.inbj016) 
       RETURNING sr_s.l_imaal004_inbj007_show
       #產品品名/儲位顯示否(單身2)
       CALL ainr311_g01_show(sr_s.x_imaal_t_imaal003,sr_s.inbj006,sr_s.inbj018) 
       RETURNING sr_s.l_imaal003_inbj006_show
       #庫位.名稱顯示否(單身1)
       CALL ainr311_g01_show(sr_s.inbj005,'','') 
       RETURNING sr_s.l_inbj005_inayl003_show
       #儲位.名稱顯示否(單身2)
       CALL ainr311_g01_show(sr_s.inbj006,sr_s.x_inab_t_inab003,'') 
       RETURNING sr_s.l_inbj006_inab003_show
       #歸屬部門.名稱顯示否(單身1)
       CALL ainr311_g01_show(sr_s.inbj017,'','') 
       RETURNING sr_s.l_inbj017_ooefl003_show
       #報廢由碼顯示否(單身3)
       CALL ainr311_g01_show(sr_s.inbj016,'','') 
       RETURNING sr_s.l_inbj016_show
       #當前面編號為空時，清空編號.說明的字串(避免編號為空會只顯示一個 .)
       CALL ainr311_g01_initialize(sr_s.inbi001,sr_s.l_inbi001_ooag011) RETURNING sr_s.l_inbi001_ooag011
       CALL ainr311_g01_initialize(sr_s.inbi002,sr_s.l_inbi002_ooefl003) RETURNING sr_s.l_inbi002_ooefl003
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       #add by liuxsa 160728-str-
       IF cl_null(sr_s.x_imaal_t_imaal003) THEN
          LET sr_s.x_imaal_t_imaal003= sr_s.inbj001
       END IF  
       #add by liuxsa 160728-end- 
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].l_condition = sr_s.l_condition
       LET sr[l_cnt].inbi000 = sr_s.inbi000
       LET sr[l_cnt].inbi001 = sr_s.inbi001
       LET sr[l_cnt].inbi002 = sr_s.inbi002
       LET sr[l_cnt].inbi004 = sr_s.inbi004
       LET sr[l_cnt].inbi007 = sr_s.inbi007
       LET sr[l_cnt].inbi021 = sr_s.inbi021
       LET sr[l_cnt].inbi031 = sr_s.inbi031
       LET sr[l_cnt].inbi032 = sr_s.inbi032
       LET sr[l_cnt].inbidocdt = sr_s.inbidocdt
       LET sr[l_cnt].inbidocno = sr_s.inbidocno
       LET sr[l_cnt].inbient = sr_s.inbient
       LET sr[l_cnt].inbisite = sr_s.inbisite
       LET sr[l_cnt].inbistus = sr_s.inbistus
       LET sr[l_cnt].inbj001 = sr_s.inbj001
       LET sr[l_cnt].inbj002 = sr_s.inbj002
       LET sr[l_cnt].inbj003 = sr_s.inbj003
       LET sr[l_cnt].inbj004 = sr_s.inbj004
       LET sr[l_cnt].inbj005 = sr_s.inbj005
       LET sr[l_cnt].inbj006 = sr_s.inbj006
       LET sr[l_cnt].inbj007 = sr_s.inbj007
       LET sr[l_cnt].inbj008 = sr_s.inbj008
       LET sr[l_cnt].inbj009 = sr_s.inbj009
       LET sr[l_cnt].inbj011 = sr_s.inbj011
       LET sr[l_cnt].inbj012 = sr_s.inbj012
       LET sr[l_cnt].inbj014 = sr_s.inbj014
       LET sr[l_cnt].inbj015 = sr_s.inbj015
       LET sr[l_cnt].inbj016 = sr_s.inbj016
       LET sr[l_cnt].inbj017 = sr_s.inbj017
       LET sr[l_cnt].inbj018 = sr_s.inbj018
       LET sr[l_cnt].inbj031 = sr_s.inbj031
       LET sr[l_cnt].inbjseq = sr_s.inbjseq
       LET sr[l_cnt].inbjsite = sr_s.inbjsite
       LET sr[l_cnt].ooag_t_ooag011 = sr_s.ooag_t_ooag011
       LET sr[l_cnt].ooefl_t_ooefl003 = sr_s.ooefl_t_ooefl003
       LET sr[l_cnt].x_t1_ooefl003 = sr_s.x_t1_ooefl003
       LET sr[l_cnt].oobxl_t_oobxl003 = sr_s.oobxl_t_oobxl003
       LET sr[l_cnt].x_imaal_t_imaal003 = sr_s.x_imaal_t_imaal003
       LET sr[l_cnt].x_inab_t_inab003 = sr_s.x_inab_t_inab003
       LET sr[l_cnt].x_t2_inab003 = sr_s.x_t2_inab003
       LET sr[l_cnt].x_oocql_t_oocql004 = sr_s.x_oocql_t_oocql004
       LET sr[l_cnt].l_inbi002_ooefl003 = sr_s.l_inbi002_ooefl003
       LET sr[l_cnt].l_inbidocno_oobxl003 = sr_s.l_inbidocno_oobxl003
       LET sr[l_cnt].l_inbi001_ooag011 = sr_s.l_inbi001_ooag011
       LET sr[l_cnt].l_inbj017_ooefl003 = sr_s.l_inbj017_ooefl003
       LET sr[l_cnt].l_inbj015_inab003 = sr_s.l_inbj015_inab003
       LET sr[l_cnt].l_inbj006_inab003 = sr_s.l_inbj006_inab003
       LET sr[l_cnt].l_inbj005_inayl003 = sr_s.l_inbj005_inayl003
       LET sr[l_cnt].inbjent = sr_s.inbjent
       LET sr[l_cnt].inbjdocno = sr_s.inbjdocno
       LET sr[l_cnt].x_imaal_t_imaal004 = sr_s.x_imaal_t_imaal004
       LET sr[l_cnt].l_inbj016_desc = sr_s.l_inbj016_desc
       LET sr[l_cnt].l_inbi021_show = sr_s.l_inbi021_show
       LET sr[l_cnt].l_inbj031_show = sr_s.l_inbj031_show
       LET sr[l_cnt].l_inbj002_inbj003_show = sr_s.l_inbj002_inbj003_show
       LET sr[l_cnt].l_imaal004_inbj007_show = sr_s.l_imaal004_inbj007_show
       LET sr[l_cnt].l_imaal003_inbj006_show = sr_s.l_imaal003_inbj006_show
       LET sr[l_cnt].l_inbj005_inayl003_show = sr_s.l_inbj005_inayl003_show
       LET sr[l_cnt].l_inbj006_inab003_show = sr_s.l_inbj006_inab003_show
       LET sr[l_cnt].l_inbj017_ooefl003_show = sr_s.l_inbj017_ooefl003_show
       LET sr[l_cnt].l_inbj016_show = sr_s.l_inbj016_show
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       #add by liuxsa 160728-str
       LET sr[l_cnt].inbjseq = l_cnt
       LET sr_s.l_condition="-",sr_s.inbj005 CLIPPED,"-",sr_s.inbj006 CLIPPED,"-",sr_s.inbj007 CLIPPED,"-",sr_s.inbj016 CLIPPED,"-"
       LET sr[l_cnt].l_condition = sr_s.l_condition
       IF NOT cl_null(sr_s.inbj002) THEN
         LET l_imaa005=NULL
         SELECT imaa005 INTO l_imaa005 FROM imaa_t WHERE imaaent=g_enterprise and imaa001=sr_s.inbj001
         LET l_inam012=NULL
         LET l_inam014=NULL
         LET l_inam018=NULL
       
         LET l_cnt2=1
         LET tok = base.StringTokenizer.createExt(sr_s.inbj002,'_','',TRUE)
         WHILE tok.hasMoreTokens()
            LET l_imec003=tok.nextToken()
            LET l_imeb012='N'
            SELECT imeb012 INTO l_imeb012 FROM imeb_t
             WHERE imebent=g_enterprise AND imeb002=l_cnt2
               AND imeb001=l_imaa005
               
            CASE l_imeb012
            #纵向
            WHEN 'N'
              LET l_imecl005=NULL
              SELECT imecl005 INTO l_imecl005
                FROM imec_t LEFT OUTER JOIN imecl_t ON imecent=imeclent AND imec001=imecl001 
                            AND imec002=imecl002 AND imec003=imecl003  AND imecl004=g_lang
               WHERE imecent=g_enterprise AND imec001=l_imaa005 AND imec002=l_cnt2
                 AND imec003=l_imec003 AND imecstus = 'Y'
              IF cl_null(l_inam012) THEN
                LET l_inam012=l_imec003,'·',l_imecl005
              ELSE
                 LET l_inam012=l_inam012,'/',l_imec003,'·',l_imecl005
              END IF 
            #横向
            WHEN 'Y'
              LET l_imecl005=NULL
              SELECT imecl005 INTO l_imecl005
                FROM imec_t LEFT OUTER JOIN imecl_t ON imecent=imeclent AND imec001=imecl001 
                            AND imec002=imecl002 AND imec003=imecl003  AND imecl004=g_lang
               WHERE imecent=g_enterprise AND imec001=l_imaa005 AND imec002=l_cnt2
                 AND imec003=l_imec003 AND imecstus = 'Y'
               LET l_inam014=l_imec003,'-',l_imecl005
            otherwise
              exit while
            end case 
            LET l_cnt2=l_cnt2+1
         END WHILE
        
          IF NOT cl_null(l_inam012) AND cl_null(l_inam014) THEN
            LET l_inam014="t-*"
          END IF 
          IF NOT cl_null(l_inam012) AND NOT cl_null(l_inam014) THEN
            EXECUTE master_tmp USING sr_s.inbidocno,sr_s.inbj001,sr_s.x_imaal_t_imaal003,l_inam012,l_inam014,
                                     l_inam018,sr_s.inbj008,sr_s.inbj009,sr_s.l_condition 
          END IF 
        END IF 
        #add by liuxsa 160728-end-
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="ainr311_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION ainr311_g01_rep_data()
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
          START REPORT ainr311_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT ainr311_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT ainr311_g01_rep
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
 
{<section id="ainr311_g01.rep" readonly="Y" >}
PRIVATE REPORT ainr311_g01_rep(sr1)
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
DEFINE sr4       sr4_r
DEFINE sr5       sr5_r
DEFINE l_ac              INTEGER
DEFINE l_i               INTEGER
DEFINE l_count           INTEGER
#add by liuxsa 160728-str-
DEFINE sr_erwei        t_erwei
DEFINE l_sql           STRING      
DEFINE l_inam014_cnt   LIKE type_t.num10
DEFINE l_pageno        LIKE type_t.num10
DEFINE l_ii            LIKE type_t.num10
DEFINE l_inam014       LIKE type_t.chr1000 
DEFINE l_erwei_show    LIKE type_t.chr1
DEFINE l_item          LIKE type_t.chr1000
DEFINE l_qty_sum   LIKE pmdn_t.pmdn007
#add by liuxsa 160728-end-
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER EXTERNAL BY sr1.inbidocno,sr1.inbj001,sr1.l_condition
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
        BEFORE GROUP OF sr1.inbidocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.inbidocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'inbient=' ,sr1.inbient,'{+}inbidocno=' ,sr1.inbidocno         
            CALL cl_gr_init_apr(sr1.inbidocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.inbidocno.before name="rep.b_group.inbidocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.inbient CLIPPED ,"'", " AND  ooff003 = '", sr1.inbidocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE ainr311_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE ainr311_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT ainr311_g01_subrep01
           DECLARE ainr311_g01_repcur01 CURSOR FROM g_sql
           FOREACH ainr311_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "ainr311_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT ainr311_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT ainr311_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.inbidocno.after name="rep.b_group.inbidocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.inbj001
 
           #add-point:rep.b_group.inbj001.before name="rep.b_group.inbj001.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.inbj001.after name="rep.b_group.inbj001.after"
           
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
                sr1.inbient CLIPPED ,"'", " AND  ooff003 = '", sr1.inbidocno CLIPPED ,"'"
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE ainr311_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE ainr311_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT ainr311_g01_subrep02
           DECLARE ainr311_g01_repcur02 CURSOR FROM g_sql
           FOREACH ainr311_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "ainr311_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT ainr311_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT ainr311_g01_subrep02
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
                sr1.inbient CLIPPED ,"'"
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE ainr311_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE ainr311_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT ainr311_g01_subrep03
           DECLARE ainr311_g01_repcur03 CURSOR FROM g_sql
           FOREACH ainr311_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "ainr311_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT ainr311_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT ainr311_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
            #製造批號/序號子報表
            START REPORT ainr311_g01_subrep05           
            IF tm.a1 ="Y" THEN                     
               LET g_sql = "SELECT inaodocno,inao008,inao009",
                           "  FROM inao_t ",
                           " WHERE inaoent     = '",sr1.inbjent      CLIPPED,"'",                                               
                           "   AND inaosite    = '",sr1.inbjsite     CLIPPED,"'",
                           "   AND inaodocno   = '",sr1.inbidocno    CLIPPED,"'",                    
                           "   AND inaoseq     = '",sr1.inbjseq      CLIPPED,"'",
                           "   AND inao000     ='1'",
                           "   AND inao008 IS NOT NULL  ",
                           "   AND inao009 IS NOT NULL  "                        
               LET l_ac = 1                              
               CALL sr6.clear()                 
               DECLARE ainr311_g01_repcur05 CURSOR FROM g_sql
               FOREACH ainr311_g01_repcur05 INTO sr6[l_ac].*  
                  LET l_ac = l_ac+1                                
               END FOREACH      
               LET l_ac = l_ac-1               
               LET l_i = 1                       
               IF l_ac > 0 THEN
                  WHILE TRUE                         
                     INITIALIZE sr4.* TO NULL
                     LET sr4.inaodocno = sr6[l_i].inaodocno
                     LET sr4.inao008_1 = sr6[l_i].inao008
                     LET sr4.inao009_1 = sr6[l_i].inao009
                     LET sr4.l_inao008_1_inao009_1  = sr4.inao008_1  , "/" , sr4.inao009_1                                                                                         
                     IF l_i+1 <= l_ac THEN    
                        LET sr4.inaodocno = sr6[l_i+1].inaodocno
                        LET sr4.inao008_2 = sr6[l_i+1].inao008
                        LET sr4.inao009_2 = sr6[l_i+1].inao009
                        LET sr4.l_inao008_2_inao009_2 =  sr4.inao008_2 , "/" , sr4.inao009_2                              
                     END IF
                     
                     IF l_i+2 <= l_ac THEN    
                        LET sr4.inaodocno = sr6[l_i+2].inaodocno
                        LET sr4.inao008_3 = sr6[l_i+2].inao008
                        LET sr4.inao009_3 = sr6[l_i+2].inao009                  
                        LET sr4.l_inao008_3_inao009_3 = sr4.inao008_3 , "/" , sr4.inao009_3
                     END IF                    
                     OUTPUT TO REPORT ainr311_g01_subrep05(sr4.*)              
                     LET l_i = l_i + 3
                     IF l_i > l_ac THEN  
                        EXIT WHILE
                     END IF                     
                  END  WHILE                                                
               END IF                    
            END IF                      
            FINISH REPORT ainr311_g01_subrep05
            #製造批號/數量子報表
            START REPORT ainr311_g01_subrep06           
            IF tm.a1 ="Y" THEN    
               LET g_sql = "SELECT inaodocno,inao008,inao012",
                           "  FROM inao_t ",
                           " WHERE inaoent     = '",sr1.inbjent      CLIPPED,"'",                                               
                           "   AND inaosite    = '",sr1.inbjsite     CLIPPED,"'",
                           "   AND inaodocno   = '",sr1.inbidocno    CLIPPED,"'",                    
                           "   AND inaoseq     = '",sr1.inbjseq      CLIPPED,"'",
                           "   AND inao000     ='1'",
                           "   AND inao008 IS NOT NULL ",
                           "   AND inao009 IS NULL "                    
               LET l_ac = 1                              
               CALL sr7.clear()                 
               DECLARE ainr311_g01_repcur06 CURSOR FROM g_sql
               FOREACH ainr311_g01_repcur06 INTO sr7[l_ac].*
                  LET l_ac = l_ac+1                                
               END FOREACH      
               LET l_ac = l_ac-1               
               LET l_i = 1                           
               IF l_ac > 0 THEN
                  WHILE TRUE                         
                     INITIALIZE sr5.* TO NULL
                     LET sr5.inaodocno = sr7[l_i].inaodocno
                     LET sr5.inao008_1 = sr7[l_i].inao008
                     LET sr5.inao012_1 = sr7[l_i].inao012
                     LET sr5.l_inao008_1_inao012_1  = sr5.inao008_1  , "/" , sr5.inao012_1                                                                                         
                     IF l_i+1 <= l_ac THEN    
                        LET sr5.inaodocno = sr7[l_i+1].inaodocno
                        LET sr5.inao008_2 = sr7[l_i+1].inao008
                        LET sr5.inao012_2 = sr7[l_i+1].inao012
                        LET sr5.l_inao008_2_inao012_2 =  sr5.inao008_2 , "/" , sr5.inao012_2                              
                     END IF
                     IF l_i+2 <= l_ac THEN    
                        LET sr5.inaodocno = sr7[l_i+2].inaodocno
                        LET sr5.inao008_3 = sr7[l_i+2].inao008
                        LET sr5.inao012_3 = sr7[l_i+2].inao012                  
                        LET sr5.l_inao008_3_inao012_3 = sr5.inao008_3 , "/" , sr5.inao012_3
                     END IF                
                     OUTPUT TO REPORT ainr311_g01_subrep06(sr5.*)              
                     LET l_i = l_i + 3
                     IF l_i > l_ac THEN  
                        EXIT WHILE
                     END IF                     
                  END  WHILE 
               END IF                    
            END IF
                       
            FINISH REPORT ainr311_g01_subrep06
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.inbidocno
 
           #add-point:rep.a_group.inbidocno.before name="rep.a_group.inbidocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.inbient CLIPPED ,"'", " AND  ooff003 = '", sr1.inbidocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE ainr311_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE ainr311_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT ainr311_g01_subrep04
           DECLARE ainr311_g01_repcur04 CURSOR FROM g_sql
           FOREACH ainr311_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "ainr311_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT ainr311_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT ainr311_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.inbidocno.after name="rep.a_group.inbidocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.inbj001
 
           #add-point:rep.a_group.inbj001.before name="rep.a_group.inbj001.before"
 
           #end add-point:
 
 
           #add-point:rep.a_group.inbj001.after name="rep.a_group.inbj001.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.l_condition
 
           #add-point:rep.a_group.l_condition.before name="rep.a_group.l_condition.before"
           #add by liuxsa 160728-str-         
           DROP TABLE inam014_tmp
          CREATE TEMP TABLE inam014_tmp
          (
           i          decimal(5,0),
           inam014    LIKE type_t.chr1000
           )

          DROP TABLE erwei_print_tmp         
          CREATE TEMP TABLE erwei_print_tmp
          (
           docno      LIKE type_t.chr100,             #單號 
           item       LIKE type_t.chr100,
           imaal003   LIKE imaal_t.imaal003,          #品名
           inam012    LIKE type_t.chr1000,            #特徵一值(顏色)
           inam014    LIKE type_t.chr1000,            #特徵二值(尺寸)
           inam018    LIKE type_t.chr1000,            #特徵四值(拉頭名稱)
           unit       LIKE type_t.chr10,              #單位
           qty001     LIKE type_t.num20_6,            #數量1
           qty002     LIKE type_t.num20_6,            #數量2
           qty003     LIKE type_t.num20_6,            #數量3
           qty004     LIKE type_t.num20_6,            #數量4
           qty005     LIKE type_t.num20_6,            #數量5
           qty006     LIKE type_t.num20_6,            #數量6
           qty007     LIKE type_t.num20_6,            #數量7
           qty008     LIKE type_t.num20_6,            #數量8
           qty009     LIKE type_t.num20_6,            #數量9
           qty010     LIKE type_t.num20_6,            #數量10
           l_skip     LIKE type_t.chr1,
           condition  LIKE type_t.chr1000
          )
   
          LET l_sub_sql = " SELECT DISTINCT inam014 FROM erwei_temp ",
                      " WHERE docno=? and imaal003=? and condition=? and item=?",
                      " ORDER BY inam014"
          PREPARE inam014_ins FROM l_sub_sql
          DECLARE inam014_ins_cs CURSOR FOR inam014_ins

          #計算橫軸個數
          LET l_sql = "SELECT COUNT(1) FROM (",l_sub_sql,")"
          PREPARE inam014_cnt_pre FROM l_sql            
          
          EXECUTE inam014_cnt_pre INTO l_inam014_cnt USING sr1.inbidocno,sr1.x_imaal_t_imaal003,sr1.l_condition,sr1.inbj001
          FREE inam014_cnt_pre
             
           --总合计          
          LET l_sub_sql = " SELECT SUM(qty) FROM erwei_temp ",
                      " WHERE docno=? "
          PREPARE qty_total_sum FROM l_sub_sql        
          
          #總計(合計)   
          LET l_sub_sql = " SELECT SUM(qty) FROM erwei_temp ",
                      " WHERE docno=? and imaal003=? and condition=? and item=?"
          PREPARE qty_total FROM l_sub_sql
       
              
          IF NOT cl_null(l_inam014_cnt) THEN
             LET l_pageno = (l_inam014_cnt -1)/10   #每頁10筆
             LET l_pageno = l_pageno +1
         
             DELETE FROM inam014_tmp WHERE 1=1
             OPEN inam014_ins_cs USING sr1.inbidocno,sr1.x_imaal_t_imaal003,sr1.l_condition,sr1.inbj001
             LET l_ii=1
             FOREACH inam014_ins_cs INTO l_inam014
                INSERT INTO inam014_tmp VALUES(l_ii,l_inam014)
                LET l_ii=l_ii+1
             END FOREACH
          
             FOR l_ii = 1 to l_pageno
                CALL ainr311_g01_ins_erwei_temp(sr1.inbidocno,sr1.x_imaal_t_imaal003,l_ii,sr1.l_condition,sr1.inbj001)
             END FOR  
          END IF           
                   
          LET g_sql = " SELECT A.*,0 FROM erwei_print_tmp A WHERE 1=1 "
          LET l_cnt = 0
          LET l_sub_sql = ""
          LET l_erwei_show ="N"
          LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
          PREPARE subrep_erwei_cnt_pre FROM l_sub_sql
          EXECUTE subrep_erwei_cnt_pre INTO l_cnt
          IF l_cnt > 0 THEN 
              LET l_erwei_show ="Y"
          END IF
          --调用子报表
          PRINTX l_erwei_show 
          START REPORT ainr311_g01_subrep07
          LET g_sql=g_sql," ORDER BY 1,2,4,5 "
          DECLARE subrep_erwei_pre CURSOR FROM g_sql
          FOREACH subrep_erwei_pre INTO sr_erwei.*
             IF STATUS THEN 
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = "subrep_erwei_pre:"
                LET g_errparam.code   = SQLCA.sqlcode
                LET g_errparam.popup  = FALSE
                CALL cl_err()                  
                EXIT FOREACH 
             END IF
             
             OUTPUT TO REPORT ainr311_g01_subrep07(sr_erwei.*) --subrep07中印出
          END FOREACH
          FINISH REPORT ainr311_g01_subrep07  
          
          --打印总合计
          LET l_qty_sum=0
          LET l_total=0
          EXECUTE qty_total INTO l_qty_sum USING sr1.inbidocno,sr1.x_imaal_t_imaal003,sr1.l_condition,sr1.inbj001
          LET l_total=l_qty_sum*0
          PRINTX l_qty_sum
          PRINTX l_total   
           #add by liuxsa 160728-end-
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
 
{<section id="ainr311_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT ainr311_g01_subrep01(sr2)
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
PRIVATE REPORT ainr311_g01_subrep02(sr2)
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
PRIVATE REPORT ainr311_g01_subrep03(sr2)
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
PRIVATE REPORT ainr311_g01_subrep04(sr2)
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
 
{<section id="ainr311_g01.other_function" readonly="Y" >}

PRIVATE FUNCTION ainr311_g01_show(p_arg1,p_arg2,p_arg3)
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

PRIVATE FUNCTION ainr311_g01_initialize(p_arg,p_exp)
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
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION ainr311_g01_erwei_tmp_table()
  #add by liuxsa 160728
   
   DROP TABLE erwei_temp;

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'erwei_temp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_rep_success = 'N'
      RETURN
   END IF
   CREATE TEMP TABLE erwei_temp(  
                   docno      LIKE pmdl_t.pmdldocno,          #單號  
                   item       LIKE type_t.chr100,             #料件编号
                   imaal003   LIKE imaal_t.imaal003,          #品名
                   inam012    LIKE type_t.chr1000,            #特徵一值(顏色)
                   inam014    LIKE type_t.chr1000,            #特徵二值(尺寸)
                   inam018    LIKE type_t.chr1000,            #特徵四值(拉頭名稱)
                   unit       LIKE pmdn_t.pmdn006,            #單位                  
                   qty        LIKE pmdn_t.pmdn007,            #數量 
                   condition  LIKE type_t.chr1000             #分组条件                       
                   )

   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create erwei_temp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_rep_success = 'N'
      RETURN
   END IF
   
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
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION ainr311_g01_ins_erwei_temp(p_docno,p_imaal003,p_i,p_condition,p_item)
#add by liuxsa 160728
--計算交叉表數值區資料總和
DEFINE p_docno      LIKE pmdl_t.pmdldocno
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
DEFINE l_pmdn007    STRING
DEFINE l_vi         varchar(3)
DEFINE i            LIKE type_t.num5

   CALL g_inam014.clear()

   SELECT COUNT(DISTINCT inam014) INTO l_n FROM erwei_temp
         WHERE docno=p_docno AND item = p_item AND condition=p_condition
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
               " WHERE i >=? and i<=? ",
               " ORDER BY i"
   PREPARE inam014_pr FROM l_sql
   DECLARE inam014_cs CURSOR FOR inam014_pr
   OPEN inam014_cs USING l_a,l_b
   LET i=1
   FOREACH inam014_cs INTO g_inam014[i]
      IF i = l_max2 THEN
         EXIT FOREACH
      ELSE
         LET i=i+1
      END IF
   END FOREACH
   
   LET l_sql = " INSERT INTO erwei_print_tmp(docno,item,imaal003,inam012,inam014,inam018,unit,condition   "
   FOR i=1 to l_max2
      CASE i WHEN 1 LET l_pmdn007 = 'qty001'
             WHEN 2 LET l_pmdn007 = 'qty002'
             WHEN 3 LET l_pmdn007 = 'qty003'
             WHEN 4 LET l_pmdn007 = 'qty004'
             WHEN 5 LET l_pmdn007 = 'qty005'
             WHEN 6 LET l_pmdn007 = 'qty006'
             WHEN 7 LET l_pmdn007 = 'qty007'
             WHEN 8 LET l_pmdn007 = 'qty008'
             WHEN 9 LET l_pmdn007 = 'qty009'           
            WHEN 10 LET l_pmdn007 = 'qty010'
      END CASE
      LET l_sql = l_sql , ",",l_pmdn007
   END FOR
   
   LET l_sql = l_sql," ) SELECT docno,item,imaal003,inam012,'','',unit,condition  "
   FOR i=1 to l_max2
      LET l_vi = i
      LET l_sql = l_sql," ,sum(A",l_vi,")"
   END FOR
   LET l_sql = l_sql,"  FROM ( SELECT docno,item,imaal003,inam012,inam014,inam018,unit,condition  "
 
   FOR i=1 to l_max2
      LET l_vi = i
      LET l_sql = l_sql,",CASE WHEN inam014 = '",g_inam014[i],"'",
                        " THEN qty ELSE 0 END A",l_vi
   END FOR
   LET l_sql = l_sql,  "  FROM erwei_temp ",
               " WHERE docno='",p_docno,"'",
               "   AND item = '",p_item,"'",
               "   AND condition='",p_condition,"'",
               "   ) "
               ," GROUP BY docno,imaal003,inam012,unit,condition,item "
                              
   PREPARE erwei_print_pr FROM l_sql
   
   DELETE FROM erwei_print_tmp WHERE 1=1
   EXECUTE erwei_print_pr
   
  UPDATE erwei_print_tmp 
      SET l_skip = "N"
      WHERE docno = p_docno AND item = p_item AND inam014 = g_inam014[l_max2] 
      
END FUNCTION

 
{</section>}
 
{<section id="ainr311_g01.other_report" readonly="Y" >}

PRIVATE REPORT ainr311_g01_subrep05(sr4)
   DEFINE sr4 sr4_r
   ORDER EXTERNAL BY sr4.inaodocno
   FORMAT        
      ON EVERY ROW
         PRINTX g_grNumFmt.*
         PRINTX sr4.*
END REPORT

PRIVATE REPORT ainr311_g01_subrep06(sr5)
   DEFINE sr5 sr5_r
   ORDER EXTERNAL BY sr5.inaodocno
   FORMAT        
      ON EVERY ROW
         PRINTX g_grNumFmt.*
         PRINTX sr5.*
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
PRIVATE REPORT ainr311_g01_subrep07(sr_erwei)
#add by liuxsa 160728
DEFINE sr_erwei  t_erwei
DEFINE sr4       sr4_r
DEFINE sr5       sr5_r
DEFINE l_ac              INTEGER
DEFINE l_i               INTEGER
DEFINE l_count           INTEGER
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
DEFINE l_qty_sum       LIKE type_t.num15_3
DEFINE l_qty_total     LIKE type_t.num15_3
DEFINE l_price_total   LIKE type_t.num20_6
DEFINE l_sum r_sum
DEFINE l_title         LIKE type_t.chr1000
DEFINE l_sql           LIKE type_t.chr1000

    ORDER EXTERNAL BY sr_erwei.docno
    FORMAT
        BEFORE GROUP OF sr_erwei.docno  --子報表中動態顯示title及計算總和
           SELECT substr(g_inam014[1],instr(g_inam014[1],'-')+1,Length(g_inam014[1])) INTO l_inam0141 from dual         
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
           LET l_title=NULL
           LET l_sql=
           "select  listagg(oocql004,'/') within group(order by imeb001,imeb002) ",
           "  from imeb_t,oocql_t ",
           " where imebent=oocqlent ",
           "   and oocql001='273' ",
           "   and oocql002=imeb004 ",
           "   and imeb001=(SELECT DISTINCT imaa005 FROM imaa_t WHERE imaaent='",g_enterprise,"' AND imaa001='",sr_erwei.item,"') ",
           "   and imebent='",g_enterprise,"' ",
           "   and imeb012='N'",
           "   and oocql003='",g_dlang,"'"
           PREPARE erwei_title_pre FROM l_sql
           EXECUTE erwei_title_pre into l_title
                   
            IF tm.a1 ="Y" THEN      
                LET g_sql = "SELECT inaodocno,inao008,inao009",
                           "  FROM inao_t,inbj_t ",
                           " WHERE inaoent     = '",g_enterprise      CLIPPED,"'",                                               
                           "   AND inaosite    = '",g_site     CLIPPED,"'",
                           "   AND inaodocno   = '",sr_erwei.docno    CLIPPED,"'",                    
                           "   AND inaoseq= inbjseq and inaodocno=inbjdocno AND inaoent=inbjent and inaosite=inbjsite",
                           "   AND inbj001='",sr_erwei.item,"'",
                           "   AND '-'||trim(inbj005)||'-'||trim(inbj006)||'-'||trim(inbj007)||'-'||trim(inbj016)||'-' = '",sr_erwei.condition,"'",                              
                           "   AND inao000     = '1'",
                           "   AND inao008 IS NOT NULL  ",
                           "   AND inao009 IS NOT NULL  "                                             
            
               LET l_ac = 1                              
               CALL sr6.clear()                 
               DECLARE ainr302_g01_repcur06_2 CURSOR FROM g_sql
               FOREACH ainr302_g01_repcur06_2 INTO sr6[l_ac].*  
                  LET l_ac = l_ac+1                                
               END FOREACH      
               LET l_ac = l_ac-1               
               LET l_i = 1                       
               IF l_ac > 0 THEN      
                  WHILE TRUE                         
                     INITIALIZE sr4.* TO NULL
                     LET sr4.inaodocno = sr6[l_i].inaodocno
                     LET sr4.inao008_1 = sr6[l_i].inao008
                     LET sr4.inao009_1 = sr6[l_i].inao009
                     LET sr4.l_inao008_1_inao009_1  = sr4.inao008_1  , "/" , sr4.inao009_1                                                                                         
                     IF l_i+1 <= l_ac THEN    
                        LET sr4.inaodocno = sr6[l_i+1].inaodocno
                        LET sr4.inao008_2 = sr6[l_i+1].inao008
                        LET sr4.inao009_2 = sr6[l_i+1].inao009
                        LET sr4.l_inao008_2_inao009_2 =  sr4.inao008_2 , "/" , sr4.inao009_2                              
                     END IF
                     
                     IF l_i+2 <= l_ac THEN    
                        LET sr4.inaodocno = sr6[l_i+2].inaodocno
                        LET sr4.inao008_3 = sr6[l_i+2].inao008
                        LET sr4.inao009_3 = sr6[l_i+2].inao009                  
                        LET sr4.l_inao008_3_inao009_3 = sr4.inao008_3 , "/" , sr4.inao009_3
                     END IF              
                            
                     PRINTX sr4.*              
                     LET l_i = l_i + 3
                     IF l_i > l_ac THEN  
                        EXIT WHILE
                     END IF                     
                  END  WHILE                                                
               END IF  
                                
               LET g_sql = "SELECT inaodocno,inao008,inao012",
                           "  FROM inao_t ",
                           " WHERE inaoent     = '",g_enterprise      CLIPPED,"'",                                               
                           "   AND inaosite    = '",g_site     CLIPPED,"'",
                           "   AND inaodocno   = '",sr_erwei.docno    CLIPPED,"'",                    
                           "   AND inaoseq= inbjseq and inaodocno=inbjdocno AND inaoent=inbjent and inaosite=inbjsite",
                           "   AND inbj001='",sr_erwei.item,"'",
                           "   AND '-'||trim(inbj005)||'-'||trim(inbj006)||'-'||trim(inbj007)||'-'||trim(inbj016)||'-' = '",sr_erwei.condition,"'",                                                    
                           "   AND inao000     = '1'",
                           "   AND inao008 IS NOT NULL ",
                           "   AND inao009 IS NULL "  
                             
               LET l_ac = 1                              
               CALL sr7.clear()                 
               DECLARE ainr302_g01_repcur07_2 CURSOR FROM g_sql
               FOREACH ainr302_g01_repcur07_2 INTO sr7[l_ac].*
                   LET l_ac = l_ac+1                                
               END FOREACH      
               LET l_ac = l_ac-1               
               LET l_i = 1                           
               IF l_ac > 0 THEN
                  WHILE TRUE                         
                     INITIALIZE sr5.* TO NULL
                     LET sr5.inaodocno = sr7[l_i].inaodocno
                     LET sr5.inao008_1 = sr7[l_i].inao008
                     LET sr5.inao012_1 = sr7[l_i].inao012
                     LET sr5.l_inao008_1_inao012_1  = sr5.inao008_1  , "/" , sr5.inao012_1                                                                                         
                     IF l_i+1 <= l_ac THEN    
                        LET sr5.inaodocno = sr7[l_i].inaodocno
                        LET sr5.inao008_2 = sr7[l_i+1].inao008
                        LET sr5.inao012_2 = sr7[l_i+1].inao012
                        LET sr5.l_inao008_2_inao012_2 =  sr5.inao008_2 , "/" , sr5.inao012_2                              
                     END IF
                     
                     IF l_i+2 <= l_ac THEN    
                        LET sr5.inaodocno = sr7[l_i].inaodocno
                        LET sr5.inao008_3 = sr7[l_i+2].inao008
                        LET sr5.inao012_3 = sr7[l_i+2].inao012                  
                        LET sr5.l_inao008_3_inao012_3 = sr5.inao008_3 , "/" , sr5.inao012_3
                     END IF              
                            
                     PRINTX sr5.*              
                     LET l_i = l_i + 3
                     IF l_i > l_ac THEN  
                        EXIT WHILE
                     END IF                     
                  END  WHILE 
               END IF                    
            END IF
            
            
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
            #SELECT substr(sr_erwei.inam012,instr(sr_erwei.inam012,'-')+1,Length(sr_erwei.inam012)) INTO sr_erwei.inam012  FROM DUAL 
            PRINTX sr_erwei.*
            LET l_qty_sum = 0
            IF cl_null(sr_erwei.qty001) THEN LET sr_erwei.qty001 = 0 END IF            
            IF cl_null(sr_erwei.qty002) THEN LET sr_erwei.qty002 = 0 END IF            
            IF cl_null(sr_erwei.qty003) THEN LET sr_erwei.qty003 = 0 END IF           
            IF cl_null(sr_erwei.qty004) THEN LET sr_erwei.qty004 = 0 END IF            
            IF cl_null(sr_erwei.qty005) THEN LET sr_erwei.qty005 = 0 END IF            
            IF cl_null(sr_erwei.qty006) THEN LET sr_erwei.qty006 = 0 END IF          
            IF cl_null(sr_erwei.qty007) THEN LET sr_erwei.qty007 = 0 END IF            
            IF cl_null(sr_erwei.qty008) THEN LET sr_erwei.qty008 = 0 END IF            
            IF cl_null(sr_erwei.qty009) THEN LET sr_erwei.qty009 = 0 END IF           
            IF cl_null(sr_erwei.qty010) THEN LET sr_erwei.qty010 = 0 END IF              
            
            #横向小計
            LET l_qty_sum=0
            LET l_qty_sum = sr_erwei.qty001+sr_erwei.qty002+sr_erwei.qty003+sr_erwei.qty004+sr_erwei.qty005+sr_erwei.qty006+sr_erwei.qty007+sr_erwei.qty008+sr_erwei.qty009+sr_erwei.qty010
            PRINTX l_qty_sum  
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
            LET l_sum.sum01=l_sum.sum01+ sr_erwei.qty001 
            LET l_sum.sum02=l_sum.sum02+ sr_erwei.qty002 
            LET l_sum.sum03=l_sum.sum03+ sr_erwei.qty003 
            LET l_sum.sum04=l_sum.sum04+ sr_erwei.qty004 
            LET l_sum.sum05=l_sum.sum05+ sr_erwei.qty005 
            LET l_sum.sum06=l_sum.sum06+ sr_erwei.qty006 
            LET l_sum.sum07=l_sum.sum07+ sr_erwei.qty007 
            LET l_sum.sum08=l_sum.sum08+ sr_erwei.qty008 
            LET l_sum.sum09=l_sum.sum09+ sr_erwei.qty009 
            LET l_sum.sum10=l_sum.sum10+ sr_erwei.qty010 
                                  
            #金额
            LET l_price_total=l_qty_sum*sr_erwei.price
            PRINTX l_price_total
            
            
        AFTER GROUP OF sr_erwei.docno
            #横向总计
            EXECUTE qty_total INTO l_qty_total USING sr_erwei.docno,sr_erwei.imaal003,sr_erwei.condition,sr_erwei.item
            IF cl_null(l_qty_total) THEN LET l_qty_total = 0 END IF
            PRINTX l_qty_total                   
            #总数量
            EXECUTE qty_total_sum INTO l_total USING sr_erwei.docno
            IF cl_null(l_total) THEN LET l_total = 0 END IF
            #纵向小计
            LET l_sum.sum11=l_sum.sum01+l_sum.sum02+l_sum.sum03+l_sum.sum04+l_sum.sum05+l_sum.sum06+l_sum.sum07+l_sum.sum08+l_sum.sum09+l_sum.sum10
            PRINTX l_sum.*
            
END REPORT

 
{</section>}
 
