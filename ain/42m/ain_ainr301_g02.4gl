#該程式未解開Section, 採用最新樣板產出!
{<section id="ainr301_g02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2016-11-07 16:58:02), PR版次:0002(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: ainr301_g02
#+ Description: ...
#+ Creator....: 02346(2016-10-21 14:46:10)
#+ Modifier...: 08734 -SD/PR- 00000
 
{</section>}
 
{<section id="ainr301_g02.global" readonly="Y" >}
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
   inba002 LIKE inba_t.inba002, 
   inba003 LIKE inba_t.inba003, 
   inba004 LIKE inba_t.inba004, 
   inba005 LIKE inba_t.inba005, 
   inba006 LIKE inba_t.inba006, 
   inba007 LIKE inba_t.inba007, 
   inba008 LIKE inba_t.inba008, 
   inbadocdt LIKE inba_t.inbadocdt, 
   inbadocno LIKE inba_t.inbadocno, 
   inbaent LIKE inba_t.inbaent, 
   inbasite LIKE inba_t.inbasite, 
   inbastus LIKE inba_t.inbastus, 
   inbb001 LIKE inbb_t.inbb001, 
   inbb002 LIKE inbb_t.inbb002, 
   inbb003 LIKE inbb_t.inbb003, 
   inbb004 LIKE inbb_t.inbb004, 
   inbb007 LIKE inbb_t.inbb007, 
   inbb008 LIKE inbb_t.inbb008, 
   inbb009 LIKE inbb_t.inbb009, 
   inbb010 LIKE inbb_t.inbb010, 
   inbb011 LIKE inbb_t.inbb011, 
   inbb012 LIKE inbb_t.inbb012, 
   inbb013 LIKE inbb_t.inbb013, 
   inbb014 LIKE inbb_t.inbb014, 
   inbb015 LIKE inbb_t.inbb015, 
   inbb016 LIKE inbb_t.inbb016, 
   inbb017 LIKE inbb_t.inbb017, 
   inbb018 LIKE inbb_t.inbb018, 
   inbb020 LIKE inbb_t.inbb020, 
   inbb021 LIKE inbb_t.inbb021, 
   inbb022 LIKE inbb_t.inbb022, 
   inbbseq LIKE inbb_t.inbbseq, 
   inbbsite LIKE inbb_t.inbbsite, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   x_oocal_t_oocal003 LIKE oocal_t.oocal003, 
   x_t1_oocal003 LIKE oocal_t.oocal003, 
   x_imaal_t_imaal004 LIKE imaal_t.imaal004, 
   inbbent LIKE inbb_t.inbbent, 
   inbbdocno LIKE inbb_t.inbbdocno, 
   l_inbb016_desc LIKE type_t.chr30, 
   l_inba003_ooag011 LIKE type_t.chr30, 
   l_inba004_ooefl003 LIKE type_t.chr30, 
   l_inbb007_inayl003 LIKE type_t.chr30, 
   l_inbb008_inab003 LIKE type_t.chr30
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING,                  #where condition 
       pr1 STRING,                  #print subrep01 
       pr2 STRING                   #print subrep02
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
   inbcdocno LIKE inbc_t.inbcdocno,
   l_inbc005_inayl003 LIKE type_t.chr30,              #庫位
   l_inbc006_inab003 LIKE type_t.chr30,              #儲位
   inbc007 LIKE inbc_t.inbc007,              #批號
   inbc003 LIKE inbc_t.inbc003,              #庫存管理特徵
   inbc010 LIKE inbc_t.inbc010,              #數量
   inbc009 LIKE inbc_t.inbc009               #單位

END RECORD
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
   inao008 LIKE inao_t.inao008,          #製造批號
   inao009 LIKE inao_t.inao009           #製造序號
   END RECORD
TYPE sr7_r RECORD
   inaodocno LIKE inao_t.inaodocno,
   inao008 LIKE inao_t.inao008,          #製造批號
   inao012 LIKE inao_t.inao012           #數量
END RECORD
DEFINE sr6 DYNAMIC ARRAY OF sr6_r
DEFINE sr7 DYNAMIC ARRAY OF sr7_r

#add by tangyi 160720-str
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
#add by tangyi 160720-end-
#end add-point
 
{</section>}
 
{<section id="ainr301_g02.main" readonly="Y" >}
PUBLIC FUNCTION ainr301_g02(p_arg1,p_arg2,p_arg3)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 STRING                  #tm.pr1  print subrep01 
DEFINE  p_arg3 STRING                  #tm.pr2  print subrep02
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.pr1 = p_arg2
   LET tm.pr2 = p_arg3
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "ainr301_g02"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL ainr301_g02_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL ainr301_g02_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL ainr301_g02_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="ainr301_g02.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION ainr301_g02_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   LET g_select = " SELECT DISTINCT NULL,inba002,inba003,inba004,inba005,inba006,inba007,inba008,inbadocdt,inbadocno, 
       inbaent,inbasite,inbastus,inbb001,inbb002,inbb003,inbb004,inbb007,inbb008,inbb009,inbb010,inbb011, 
       inbb012,inbb013,inbb014,inbb015,inbb016,inbb017,inbb018,inbb020,inbb021,inbb022,inbbseq,inbbsite, 
       ooag_t.ooag011,ooefl_t.ooefl003,imaal_t.imaal003,oocal_t.oocal003,t1.oocal003,imaal_t.imaal004, 
       inbbent,inbbdocno,oocql_t.oocql004,trim(inba003)||'.'||trim(ooag_t.ooag011),trim(inba004)||'.'||trim(ooefl_t.ooefl003), 
       trim(inbb007)||'.'||trim(inayl_t.inayl003),trim(inbb008)||'.'||trim(inab_t.inab003)"
 
#   #end add-point
#   LET g_select = " SELECT NULL,inba002,inba003,inba004,inba005,inba006,inba007,inba008,inbadocdt,inbadocno, 
#       inbaent,inbasite,inbastus,inbb001,inbb002,inbb003,inbb004,inbb007,inbb008,inbb009,inbb010,inbb011, 
#       inbb012,inbb013,inbb014,inbb015,inbb016,inbb017,inbb018,inbb020,inbb021,inbb022,inbbseq,inbbsite, 
#       ( SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = inba_t.inba003 AND ooag_t.ooagent = inba_t.inbaent), 
#       ( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = inba_t.inba004 AND ooefl_t.ooeflent = inba_t.inbaent AND ooefl_t.ooefl002 = '" , 
#       g_dlang,"'" ,"),x.imaal_t_imaal003,x.oocal_t_oocal003,x.t1_oocal003,x.imaal_t_imaal004,inbbent, 
#       inbbdocno,NULL,trim(inba003)||'.'||trim((SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = inba_t.inba003 AND ooag_t.ooagent = inba_t.inbaent)), 
#       trim(inba004)||'.'||trim((SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = inba_t.inba004 AND ooefl_t.ooeflent = inba_t.inbaent AND ooefl_t.ooefl002 = '" , 
#       g_dlang,"'" ,")),NULL,NULL"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
    LET g_from = " FROM inba_t LEFT OUTER JOIN ooag_t ON ooag_t.ooag001 = inba_t.inba003 AND ooag_t.ooagent = inba_t.inbaent             
                               LEFT OUTER JOIN ooefl_t ON ooefl_t.ooefl001 = inba_t.inba004 AND ooefl_t.ooeflent = inba_t.inbaent AND ooefl_t.ooefl002 = '", g_dlang,"' 
                               LEFT OUTER JOIN inbb_t ON inba_t.inbaent = inbbent AND inba_t.inbadocno = inbbdocno
                               LEFT OUTER JOIN imaal_t ON imaal_t.imaal001 = inbb_t.inbb001 AND imaal_t.imaalent = inbb_t.inbbent AND imaal_t.imaal002 = '", g_dlang,"'            
                               LEFT OUTER JOIN oocal_t ON oocal_t.oocal001 = inbb_t.inbb010 AND oocal_t.oocalent = inbb_t.inbbent AND oocal_t.oocal002 = '", g_dlang,"'              
                               LEFT OUTER JOIN oocal_t t1 ON t1.oocal001 = inbb_t.inbb013 AND t1.oocalent = inbb_t.inbbent AND t1.oocal002 = '",g_dlang,"'   
                               LEFT OUTER JOIN oocql_t ON oocql001 = '216' and oocqlent=inbbent AND oocql002 = inbb016 AND oocql003 = '",g_dlang,"' 
                               LEFT OUTER JOIN inayl_t ON inayl001 = inbb007 AND inaylent = inbbent AND inayl002 = '",g_dlang,"' 
                               LEFT OUTER JOIN inab_t ON inab001 = inbb007 AND inab002 = inbb008 AND inabent = inbbent AND inbbsite = inabsite       "
 

#   #end add-point
#    LET g_from = " FROM inba_t LEFT OUTER JOIN ( SELECT inbb_t.*,( SELECT imaal003 FROM imaal_t WHERE imaal_t.imaal001 = inbb_t.inbb001 AND imaal_t.imaalent = inbb_t.inbbent AND imaal_t.imaal002 = '" , 
#        g_dlang,"'" ,") imaal_t_imaal003,( SELECT oocal003 FROM oocal_t WHERE oocal_t.oocal001 = inbb_t.inbb013 AND oocal_t.oocalent = inbb_t.inbbent AND oocal_t.oocal002 = '" , 
#        g_dlang,"'" ,") oocal_t_oocal003,( SELECT oocal003 FROM oocal_t WHERE oocal_t.oocal001 = inbb_t.inbb010 AND oocal_t.oocalent = inbb_t.inbbent AND oocal_t.oocal002 = '" , 
#        g_dlang,"'" ,") t1_oocal003,( SELECT imaal004 FROM imaal_t WHERE imaal_t.imaal001 = inbb_t.inbb001 AND imaal_t.imaalent = inbb_t.inbbent AND imaal_t.imaal002 = '" , 
#        g_dlang,"'" ,") imaal_t_imaal004 FROM inbb_t ) x  ON inba_t.inbaent = x.inbbent AND inba_t.inbadocno  
#        = x.inbbdocno"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
 
   #end add-point
    LET g_order = " ORDER BY inbadocno,inbb001"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("inba_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE ainr301_g02_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE ainr301_g02_curs CURSOR FOR ainr301_g02_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="ainr301_g02.ins_data" readonly="Y" >}
PRIVATE FUNCTION ainr301_g02_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   l_condition LIKE type_t.chr1000, 
   inba002 LIKE inba_t.inba002, 
   inba003 LIKE inba_t.inba003, 
   inba004 LIKE inba_t.inba004, 
   inba005 LIKE inba_t.inba005, 
   inba006 LIKE inba_t.inba006, 
   inba007 LIKE inba_t.inba007, 
   inba008 LIKE inba_t.inba008, 
   inbadocdt LIKE inba_t.inbadocdt, 
   inbadocno LIKE inba_t.inbadocno, 
   inbaent LIKE inba_t.inbaent, 
   inbasite LIKE inba_t.inbasite, 
   inbastus LIKE inba_t.inbastus, 
   inbb001 LIKE inbb_t.inbb001, 
   inbb002 LIKE inbb_t.inbb002, 
   inbb003 LIKE inbb_t.inbb003, 
   inbb004 LIKE inbb_t.inbb004, 
   inbb007 LIKE inbb_t.inbb007, 
   inbb008 LIKE inbb_t.inbb008, 
   inbb009 LIKE inbb_t.inbb009, 
   inbb010 LIKE inbb_t.inbb010, 
   inbb011 LIKE inbb_t.inbb011, 
   inbb012 LIKE inbb_t.inbb012, 
   inbb013 LIKE inbb_t.inbb013, 
   inbb014 LIKE inbb_t.inbb014, 
   inbb015 LIKE inbb_t.inbb015, 
   inbb016 LIKE inbb_t.inbb016, 
   inbb017 LIKE inbb_t.inbb017, 
   inbb018 LIKE inbb_t.inbb018, 
   inbb020 LIKE inbb_t.inbb020, 
   inbb021 LIKE inbb_t.inbb021, 
   inbb022 LIKE inbb_t.inbb022, 
   inbbseq LIKE inbb_t.inbbseq, 
   inbbsite LIKE inbb_t.inbbsite, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   x_oocal_t_oocal003 LIKE oocal_t.oocal003, 
   x_t1_oocal003 LIKE oocal_t.oocal003, 
   x_imaal_t_imaal004 LIKE imaal_t.imaal004, 
   inbbent LIKE inbb_t.inbbent, 
   inbbdocno LIKE inbb_t.inbbdocno, 
   l_inbb016_desc LIKE type_t.chr30, 
   l_inba003_ooag011 LIKE type_t.chr30, 
   l_inba004_ooefl003 LIKE type_t.chr30, 
   l_inbb007_inayl003 LIKE type_t.chr30, 
   l_inbb008_inab003 LIKE type_t.chr30
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
#add by tangyi 160720-str-
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
#add by tangyi 160720-end-
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    #add by tangyi 160720-str-  
    CALL ainr301_g02_erwei_tmp_table()   
    LET g_sql = " INSERT INTO erwei_temp(docno,item,imaal003,inam012,inam014,inam018,unit,qty,condition) VALUES (?,?,?,?,?,?,?,?,?) "
    PREPARE master_tmp FROM g_sql   
    #add by tangyi 160720-end-
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH ainr301_g02_curs INTO sr_s.*
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
       IF sr_s.l_inbb007_inayl003 = '.' THEN
         LET sr_s.l_inbb007_inayl003 = NULL
       END IF
       IF sr_s.l_inbb008_inab003 = '.' THEN
         LET sr_s.l_inbb008_inab003 = NULL
       END IF
       IF sr_s.inbb020 = ' ' THEN
         LET sr_s.inbb020 = NULL
       END IF
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       #add by tangyi 160720-str-
       IF cl_null(sr_s.x_imaal_t_imaal003) THEN
          LET sr_s.x_imaal_t_imaal003= sr_s.inbb001
       END IF  
       #add by tangyi 160720-end- 
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].l_condition = sr_s.l_condition
       LET sr[l_cnt].inba002 = sr_s.inba002
       LET sr[l_cnt].inba003 = sr_s.inba003
       LET sr[l_cnt].inba004 = sr_s.inba004
       LET sr[l_cnt].inba005 = sr_s.inba005
       LET sr[l_cnt].inba006 = sr_s.inba006
       LET sr[l_cnt].inba007 = sr_s.inba007
       LET sr[l_cnt].inba008 = sr_s.inba008
       LET sr[l_cnt].inbadocdt = sr_s.inbadocdt
       LET sr[l_cnt].inbadocno = sr_s.inbadocno
       LET sr[l_cnt].inbaent = sr_s.inbaent
       LET sr[l_cnt].inbasite = sr_s.inbasite
       LET sr[l_cnt].inbastus = sr_s.inbastus
       LET sr[l_cnt].inbb001 = sr_s.inbb001
       LET sr[l_cnt].inbb002 = sr_s.inbb002
       LET sr[l_cnt].inbb003 = sr_s.inbb003
       LET sr[l_cnt].inbb004 = sr_s.inbb004
       LET sr[l_cnt].inbb007 = sr_s.inbb007
       LET sr[l_cnt].inbb008 = sr_s.inbb008
       LET sr[l_cnt].inbb009 = sr_s.inbb009
       LET sr[l_cnt].inbb010 = sr_s.inbb010
       LET sr[l_cnt].inbb011 = sr_s.inbb011
       LET sr[l_cnt].inbb012 = sr_s.inbb012
       LET sr[l_cnt].inbb013 = sr_s.inbb013
       LET sr[l_cnt].inbb014 = sr_s.inbb014
       LET sr[l_cnt].inbb015 = sr_s.inbb015
       LET sr[l_cnt].inbb016 = sr_s.inbb016
       LET sr[l_cnt].inbb017 = sr_s.inbb017
       LET sr[l_cnt].inbb018 = sr_s.inbb018
       LET sr[l_cnt].inbb020 = sr_s.inbb020
       LET sr[l_cnt].inbb021 = sr_s.inbb021
       LET sr[l_cnt].inbb022 = sr_s.inbb022
       LET sr[l_cnt].inbbseq = sr_s.inbbseq
       LET sr[l_cnt].inbbsite = sr_s.inbbsite
       LET sr[l_cnt].ooag_t_ooag011 = sr_s.ooag_t_ooag011
       LET sr[l_cnt].ooefl_t_ooefl003 = sr_s.ooefl_t_ooefl003
       LET sr[l_cnt].x_imaal_t_imaal003 = sr_s.x_imaal_t_imaal003
       LET sr[l_cnt].x_oocal_t_oocal003 = sr_s.x_oocal_t_oocal003
       LET sr[l_cnt].x_t1_oocal003 = sr_s.x_t1_oocal003
       LET sr[l_cnt].x_imaal_t_imaal004 = sr_s.x_imaal_t_imaal004
       LET sr[l_cnt].inbbent = sr_s.inbbent
       LET sr[l_cnt].inbbdocno = sr_s.inbbdocno
       LET sr[l_cnt].l_inbb016_desc = sr_s.l_inbb016_desc
       LET sr[l_cnt].l_inba003_ooag011 = sr_s.l_inba003_ooag011
       LET sr[l_cnt].l_inba004_ooefl003 = sr_s.l_inba004_ooefl003
       LET sr[l_cnt].l_inbb007_inayl003 = sr_s.l_inbb007_inayl003
       LET sr[l_cnt].l_inbb008_inab003 = sr_s.l_inbb008_inab003
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       #add by tangyi 160720-str
       #LET sr_s.l_condition="-",sr_s.inbb007 CLIPPED,"-",sr_s.inbb008 CLIPPED,"-",sr_s.inbb009 CLIPPED,"-",sr_s.inbb016 CLIPPED,"-"
       SELECT imaa005 INTO sr_s.l_condition FROM imaa_t
        WHERE imaa001=sr_s.inbb001
          AND imaaent=g_enterprise
       IF cl_null(sr_s.l_condition) THEN
         LET sr_s.l_condition='TMP'
       END IF 
       LET sr[l_cnt].l_condition = sr_s.l_condition
       IF NOT cl_null(sr_s.inbb002) THEN
         LET l_imaa005=NULL
         SELECT imaa005 INTO l_imaa005 FROM imaa_t WHERE imaaent=g_enterprise and imaa001=sr_s.inbb001
         LET l_inam012=NULL
         LET l_inam014=NULL
         LET l_inam018=NULL
       
         LET l_cnt2=1
         LET tok = base.StringTokenizer.createExt(sr_s.inbb002,'_','',TRUE)
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
            EXECUTE master_tmp USING sr_s.inbadocno,sr_s.inbb001,sr_s.x_imaal_t_imaal003,
                                     l_inam012,l_inam014,l_inam018,sr_s.inbb010,sr_s.inbb011,sr_s.l_condition  
          END IF 
        ELSE         
          LET l_inam012='-'
          LET l_inam014='-'
          LET l_inam018=''
          EXECUTE master_tmp USING sr_s.inbadocno,sr_s.inbb001,sr_s.x_imaal_t_imaal003,
                                   l_inam012,l_inam014,l_inam018,sr_s.inbb010,sr_s.inbb011,sr_s.l_condition  
       
        END IF 
        #add by tangyi 160720-end-
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="ainr301_g02.rep_data" readonly="Y" >}
PRIVATE FUNCTION ainr301_g02_rep_data()
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
          START REPORT ainr301_g02_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT ainr301_g02_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT ainr301_g02_rep
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
 
{<section id="ainr301_g02.rep" readonly="Y" >}
PRIVATE REPORT ainr301_g02_rep(sr1)
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
DEFINE l_ac              INTEGER
DEFINE l_i               INTEGER
DEFINE l_count           INTEGER
DEFINE l_subrep05_show   LIKE type_t.chr1
DEFINE l_subrep06_show   LIKE type_t.chr1
DEFINE l_subrep07_show   LIKE type_t.chr1

#add by tangyi 160720-str-
DEFINE sr_erwei        t_erwei
DEFINE l_sql           STRING      
DEFINE l_inam014_cnt   LIKE type_t.num10
DEFINE l_pageno        LIKE type_t.num10
DEFINE l_ii            LIKE type_t.num10
DEFINE l_inam014       LIKE type_t.chr1000 
DEFINE l_erwei_show    LIKE type_t.chr1
DEFINE l_item          LIKE type_t.chr1000
DEFINE l_qty_sum   LIKE pmdn_t.pmdn007
#add by tangyi 160720-end-
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER  BY sr1.inbadocno,sr1.l_condition
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
        BEFORE GROUP OF sr1.inbadocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.inbadocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'inbaent=' ,sr1.inbaent,'{+}inbadocno=' ,sr1.inbadocno         
            CALL cl_gr_init_apr(sr1.inbadocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.inbadocno.before name="rep.b_group.inbadocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.inbaent CLIPPED ,"'", " AND  ooff003 = '", sr1.inbadocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE ainr301_g02_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE ainr301_g02_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT ainr301_g02_subrep01
           DECLARE ainr301_g02_repcur01 CURSOR FROM g_sql
           FOREACH ainr301_g02_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "ainr301_g02_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT ainr301_g02_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT ainr301_g02_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.inbadocno.after name="rep.b_group.inbadocno.after"
           
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
                sr1.inbaent CLIPPED ,"'", " AND  ooff003 = '", sr1.inbadocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.l_condition CLIPPED ,""
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE ainr301_g02_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE ainr301_g02_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT ainr301_g02_subrep02
           DECLARE ainr301_g02_repcur02 CURSOR FROM g_sql
           FOREACH ainr301_g02_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "ainr301_g02_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT ainr301_g02_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT ainr301_g02_subrep02
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
                sr1.inbaent CLIPPED ,"'", " AND  ooff003 = '", sr1.inbadocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.l_condition CLIPPED ,""
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE ainr301_g02_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE ainr301_g02_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT ainr301_g02_subrep03
           DECLARE ainr301_g02_repcur03 CURSOR FROM g_sql
           FOREACH ainr301_g02_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "ainr301_g02_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT ainr301_g02_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT ainr301_g02_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
            START REPORT ainr301_g02_subrep05
            IF tm.pr1 ="Y" THEN
               IF NOT cl_null(sr1.inbbseq) THEN
                  LET g_sql = "SELECT inbcdocno,trim(inbc005)||'.'||trim(inayl_t.inayl003),trim(inbc006)||'.'||trim(inab_t.inab003),inbc007,inbc003,inbc010,inbc009 ",
                              "  FROM inbc_t LEFT OUTER JOIN inayl_t ON inayl001 = inbc006 AND inaylent = inbcent AND inayl002 = '",g_dlang,"' ",
                              "              LEFT OUTER JOIN inab_t ON inab001 = inbc006 AND inab002 = inbc007 AND inabent = inbcent AND inbcsite = inabsite ",
                              " WHERE inbcdocno = '",sr1.inbbdocno CLIPPED,"'",
                              "   AND inbcent   = '",sr1.inbbent   CLIPPED,"'",
                              "   AND inbcseq   = '",sr1.inbbseq   CLIPPED,"' ",                         
                              "   ORDER BY inbcseq "
                                     
                  DECLARE ainr301_g02_repcur05 CURSOR FROM g_sql
                  FOREACH ainr301_g02_repcur05 INTO sr3.*
                     IF sr3.l_inbc005_inayl003 = '.' THEN
                        LET sr3.l_inbc005_inayl003 = NULL
                     END IF                    
                     IF sr3.l_inbc006_inab003 = '.' THEN
                        LET sr3.l_inbc006_inab003 = NULL
                     END IF 
                     OUTPUT TO REPORT ainr301_g02_subrep05(sr3.*)
                  END FOREACH 
               END IF
            END IF
            FINISH REPORT ainr301_g02_subrep05
#            
            
            START REPORT ainr301_g02_subrep06           
            IF tm.pr2 ="Y" THEN                     
               LET g_sql = "SELECT inaodocno,inao008,inao009",
                           "  FROM inao_t ",
                           " WHERE inaoent     = '",sr1.inbbent      CLIPPED,"'",                                               
                           "   AND inaosite    = '",sr1.inbbsite     CLIPPED,"'",
                           "   AND inaodocno   = '",sr1.inbadocno    CLIPPED,"'",                    
                           "   AND inaoseq     = '",sr1.inbbseq      CLIPPED,"'",
                           "   AND inao000     = '2'",
                           "   AND inao008 IS NOT NULL  ",
                           "   AND inao009 IS NOT NULL  "                        
                       
            
               LET l_ac = 1                              
               CALL sr6.clear()                 
               DECLARE ainr301_g02_repcur06 CURSOR FROM g_sql
               FOREACH ainr301_g02_repcur06 INTO sr6[l_ac].*  
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
                            
                     OUTPUT TO REPORT ainr301_g02_subrep06(sr4.*)              
                     LET l_i = l_i + 3
                     IF l_i > l_ac THEN  
                        EXIT WHILE
                     END IF                     
                  END  WHILE                                                
               END IF                    
            END IF                      
            FINISH REPORT ainr301_g02_subrep06               
# 
            START REPORT ainr301_g02_subrep07           
            IF tm.pr2 ="Y" THEN          
               LET g_sql = "SELECT inaodocno,inao008,inao012",
                           "  FROM inao_t ",
                           " WHERE inaoent     = '",sr1.inbbent      CLIPPED,"'",                                               
                           "   AND inaosite    = '",sr1.inbbsite     CLIPPED,"'",
                           "   AND inaodocno   = '",sr1.inbadocno    CLIPPED,"'",                    
                           "   AND inaoseq     = '",sr1.inbbseq      CLIPPED,"'",                          
                           "   AND inao000     = '1'",
                           "   AND inao008 IS NOT NULL ",
                           "   AND inao009 IS NULL "  
                              
               LET l_ac = 1                              
               CALL sr7.clear()                 
               DECLARE ainr301_g02_repcur07 CURSOR FROM g_sql
               FOREACH ainr301_g02_repcur07 INTO sr7[l_ac].*
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
                            
                     OUTPUT TO REPORT ainr301_g02_subrep07(sr5.*)              
                     LET l_i = l_i + 3
                     IF l_i > l_ac THEN  
                        EXIT WHILE
                     END IF                     
                  END  WHILE 
               END IF                    
            END IF
                       
            FINISH REPORT ainr301_g02_subrep07  
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.inbadocno
 
           #add-point:rep.a_group.inbadocno.before name="rep.a_group.inbadocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.inbaent CLIPPED ,"'", " AND  ooff003 = '", sr1.inbadocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE ainr301_g02_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE ainr301_g02_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT ainr301_g02_subrep04
           DECLARE ainr301_g02_repcur04 CURSOR FROM g_sql
           FOREACH ainr301_g02_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "ainr301_g02_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT ainr301_g02_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT ainr301_g02_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.inbadocno.after name="rep.a_group.inbadocno.after"
          
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.l_condition
 
           #add-point:rep.a_group.l_condition.before name="rep.a_group.l_condition.before"
          #add by tangyi 160720-str-
          DROP TABLE inam014_tmp
          CREATE TEMP TABLE inam014_tmp
          (
           i          decimal(5,0),
           inam014     VARCHAR(1000)
           )

          DROP TABLE erwei_print_tmp         
          CREATE TEMP TABLE erwei_print_tmp
          (
           docno       VARCHAR(100),                  #單號 
           item        VARCHAR(100),
           imaal003    VARCHAR(255),               #品名
           inam012     VARCHAR(1000),                 #特徵一值(顏色)
           inam014     VARCHAR(1000),                 #特徵二值(尺寸)
           inam018     VARCHAR(1000),                 #特徵四值(拉頭名稱)
           unit        VARCHAR(10),                   #單位
           qty001      DECIMAL(20,6),                 #數量1
           qty002      DECIMAL(20,6),                 #數量2
           qty003      DECIMAL(20,6),                 #數量3
           qty004      DECIMAL(20,6),                 #數量4
           qty005      DECIMAL(20,6),                 #數量5
           qty006      DECIMAL(20,6),                 #數量6
           qty007      DECIMAL(20,6),                 #數量7
           qty008      DECIMAL(20,6),                 #數量8
           qty009      DECIMAL(20,6),                 #數量9
           qty010      DECIMAL(20,6),                 #數量10
           l_skip      VARCHAR(1),
           condition   VARCHAR(1000)
          )
          
         
          LET l_sub_sql = " SELECT DISTINCT inam014 FROM erwei_temp ",
                      #" WHERE docno=? and imaal003=? and condition=? and item=?",
                      " WHERE docno=?  and  condition=? ",
                      " ORDER BY inam014"
          PREPARE inam014_ins FROM l_sub_sql
          DECLARE inam014_ins_cs CURSOR FOR inam014_ins

          #計算橫軸個數
          LET l_sql = "SELECT COUNT(1) FROM (",l_sub_sql,")"
          PREPARE inam014_cnt_pre FROM l_sql            
          
          #EXECUTE inam014_cnt_pre INTO l_inam014_cnt USING sr1.inbadocno,sr1.x_imaal_t_imaal003,sr1.l_condition,sr1.inbb001
          EXECUTE inam014_cnt_pre INTO l_inam014_cnt USING sr1.inbadocno,sr1.l_condition
          FREE inam014_cnt_pre
             
           --总合计          
          LET l_sub_sql = " SELECT SUM(qty) FROM erwei_temp ",
                      " WHERE docno=? "
          PREPARE qty_total_sum FROM l_sub_sql        
          
          #總計(合計)   
          LET l_sub_sql = " SELECT SUM(qty) FROM erwei_temp ",
                      " WHERE docno=? and imaal003=? and condition=? and item=? "
          PREPARE qty_total FROM l_sub_sql
       
              
          IF NOT cl_null(l_inam014_cnt) THEN
             LET l_pageno = (l_inam014_cnt -1)/10   #每頁10筆
             LET l_pageno = l_pageno +1
         
             DELETE FROM inam014_tmp WHERE 1=1
             #OPEN inam014_ins_cs USING sr1.inbadocno,sr1.x_imaal_t_imaal003,sr1.l_condition,sr1.inbb001
             OPEN inam014_ins_cs USING sr1.inbadocno,sr1.l_condition
             LET l_ii=1
             FOREACH inam014_ins_cs INTO l_inam014
                INSERT INTO inam014_tmp VALUES(l_ii,l_inam014)
                LET l_ii=l_ii+1
             END FOREACH
          
             FOR l_ii = 1 to l_pageno
               LET g_sql=" SELECT DISTINCT docno,imaal003 ,condition,item FROM erwei_temp ",
                         "  where  docno='",sr1.inbadocno,"'  and condition='",sr1.l_condition,"'"
               PREPARE inam014_xxx_ins FROM g_sql
               DECLARE inam014_xxx_ins_cs CURSOR FOR inam014_xxx_ins
               FOREACH inam014_xxx_ins_cs into sr1.inbadocno,sr1.x_imaal_t_imaal003,sr1.l_condition,sr1.inbb001
                  CALL ainr301_g02_ins_erwei_temp(sr1.inbadocno,sr1.x_imaal_t_imaal003,l_ii,sr1.l_condition,sr1.inbb001)
               END FOREACH 
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
          START REPORT ainr301_g02_subrep08
          LET g_sql=g_sql," ORDER BY 1,4,5 "
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
             
             OUTPUT TO REPORT ainr301_g02_subrep08(sr_erwei.*) --subrep08中印出
          END FOREACH
          FINISH REPORT ainr301_g02_subrep08  
          
          --打印总合计
          LET l_qty_sum=0
          LET l_total=0
          EXECUTE qty_total INTO l_qty_sum USING sr1.inbadocno,sr1.x_imaal_t_imaal003,sr1.l_condition,sr1.inbb001
          EXECUTE qty_total_sum INTO l_total USING sr1.inbadocno
 
          PRINTX l_qty_sum
          PRINTX l_total   
           #add by tangyi 160720-end-
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
 
{<section id="ainr301_g02.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT ainr301_g02_subrep01(sr2)
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
PRIVATE REPORT ainr301_g02_subrep02(sr2)
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
PRIVATE REPORT ainr301_g02_subrep03(sr2)
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
PRIVATE REPORT ainr301_g02_subrep04(sr2)
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
 
{<section id="ainr301_g02.other_function" readonly="Y" >}

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
PRIVATE FUNCTION ainr301_g02_erwei_tmp_table()
#add by tangyi 160720
   
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
                   docno       VARCHAR(20),               #單號  
                   item        VARCHAR(100),                  #料件编号
                   imaal003    VARCHAR(255),               #品名
                   inam012     VARCHAR(1000),                 #特徵一值(顏色)
                   inam014     VARCHAR(1000),                 #特徵二值(尺寸)
                   inam018     VARCHAR(1000),                 #特徵四值(拉頭名稱)
                   unit        VARCHAR(10),                 #單位                  
                   qty         DECIMAL(20,6),                  #數量 
                   condition   VARCHAR(1000)     #分组条件                    
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
PRIVATE FUNCTION ainr301_g02_ins_erwei_temp(p_docno,p_imaal003,p_i,p_condition,p_item)
#add by tangyi 160720
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
   # WHERE docno=p_docno AND imaal003 = p_imaal003 AND item = p_item AND condition=p_condition
    WHERE docno=p_docno  AND condition=p_condition
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
   
   LET l_sql = " INSERT INTO erwei_print_tmp(docno,item,imaal003,inam012,inam014,inam018,unit,condition  "
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
   
   LET l_sql = l_sql," ) SELECT docno,item,imaal003,inam012,'','',unit,condition "
   FOR i=1 to l_max2
      LET l_vi = i
      LET l_sql = l_sql," ,sum(A",l_vi,")"
   END FOR
   LET l_sql = l_sql,"  FROM ( SELECT docno,item,imaal003,inam012,inam014,inam018,unit,condition "
 
   FOR i=1 to l_max2
      LET l_vi = i
      LET l_sql = l_sql,",CASE WHEN inam014 = '",g_inam014[i],"'",
                        " THEN qty ELSE 0 END A",l_vi
   END FOR
   LET l_sql = l_sql,  "  FROM erwei_temp ",
               " WHERE docno='",p_docno,"'",
               "   AND imaal003 = '",p_imaal003,"'",
               "   AND item = '",p_item,"'",
               "   AND condition='",p_condition,"'",
               "   ) "
               ," GROUP BY docno,imaal003,inam012,unit,item,condition "
                              
   PREPARE erwei_print_pr FROM l_sql
   
   #DELETE FROM erwei_print_tmp WHERE 1=1
   EXECUTE erwei_print_pr
   
  UPDATE erwei_print_tmp 
      SET l_skip = "N"
      WHERE docno = p_docno AND imaal003 = p_imaal003 AND inam014 = g_inam014[l_max2]  AND item = p_item
END FUNCTION

 
{</section>}
 
{<section id="ainr301_g02.other_report" readonly="Y" >}

PRIVATE REPORT ainr301_g02_subrep05(sr3)
   DEFINE sr3 sr3_r
   ORDER EXTERNAL BY sr3.inbcdocno
   FORMAT        
      ON EVERY ROW
         PRINTX g_grNumFmt.*
         PRINTX sr3.*
END REPORT

PRIVATE REPORT ainr301_g02_subrep06(sr4)
   DEFINE sr4 sr4_r
   ORDER EXTERNAL BY sr4.inaodocno
   FORMAT        
      ON EVERY ROW
         PRINTX g_grNumFmt.*
         PRINTX sr4.*
END REPORT

PRIVATE REPORT ainr301_g02_subrep07(sr5)
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
PRIVATE REPORT ainr301_g02_subrep08(sr_erwei)
   #add by tangyi 160720
DEFINE sr_erwei  t_erwei
DEFINE sr3       sr3_r
DEFINE sr4       sr4_r
DEFINE sr5       sr5_r
DEFINE l_ac            INTEGER
DEFINE l_i             INTEGER
DEFINE l_count         INTEGER
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
DEFINE l_old_item      LIKE type_t.chr100

    #ORDER EXTERNAL BY sr_erwei.docno ,sr_erwei.item
    ORDER BY sr_erwei.docno ,sr_erwei.item
    
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
           
           IF cl_null(l_inam0141) THEN
             LET l_inam0141='数量'
           END IF           
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
#           
#           IF tm.pr1 ="Y" THEN
#                  LET g_sql = "SELECT inbcdocno,trim(inbc005)||'.'||trim(inayl_t.inayl003),trim(inbc006)||'.'||trim(inab_t.inab003),inbc007,inbc003,SUM(inbc010),inbc009 ",
#                              "  FROM inbb_t,inbc_t LEFT OUTER JOIN inayl_t ON inayl001 = inbc006 AND inaylent = inbcent AND inayl002 = '",g_dlang,"' ",
#                              "              LEFT OUTER JOIN inab_t ON inab001 = inbc006 AND inab002 = inbc007 AND inabent = inbcent AND inbcsite = inabsite ",                                                                                            
#                              " WHERE inbcdocno = '",sr_erwei.docno CLIPPED,"'",
#                              "   AND inbcent   = '",g_enterprise   CLIPPED,"'",
#                              "   AND inbcseq   = inbbseq and inbcdocno=inbbdocno AND inbcent=inbbent AND inbbseq is not null",   
#                              "   AND inbb001='",sr_erwei.item,"'",
#                              "   AND '-'||trim(inbb007)||'-'||trim(inbb008)||'-'||trim(inbb009)||'-'||trim(inbb016)||'-' = '",sr_erwei.condition,"'",                             
#                              "   group BY  inbcdocno,inbc005,inbc006,inbc007,inbc009,inbc003,inayl003,inayl003,inab003  "                                                                
#                  DECLARE ainr301_g02_repcur05_1 CURSOR FROM g_sql
#                  FOREACH ainr301_g02_repcur05_1 INTO sr3.*
#                     IF sr3.l_inbc005_inayl003 = '.' THEN
#                        LET sr3.l_inbc005_inayl003 = NULL
#                     END IF                    
#                     IF sr3.l_inbc006_inab003 = '.' THEN
#                        LET sr3.l_inbc006_inab003 = NULL
#                     END IF 
#                     PRINTX sr3.*
#                  END FOREACH 
#            END IF
#                
#            IF tm.pr2 ="Y" THEN                     
#               LET g_sql = "SELECT inaodocno,inao008,inao009",
#                           "  FROM inao_t,inbb_t ",
#                           " WHERE inaoent     = '",g_enterprise      CLIPPED,"'",                                               
#                           "   AND inaosite    = '",g_site     CLIPPED,"'",
#                           "   AND inaodocno   = '",sr_erwei.docno    CLIPPED,"'",                    
#                           "   AND inaoseq= inbbseq and inaodocno=inbbdocno AND inaoent=inbbent and inaosite=inbbsite",
#                           "   AND inbb001='",sr_erwei.item,"'",
#                           "   AND '-'||trim(inbb007)||'-'||trim(inbb008)||'-'||trim(inbb009)||'-'||trim(inbb016)||'-' = '",sr_erwei.condition,"'",                              
#                           "   AND inao000     = '2'",
#                           "   AND inao008 IS NOT NULL  ",
#                           "   AND inao009 IS NOT NULL  "                    
#                                  
#               LET l_ac = 1                              
#               CALL sr6.clear()                 
#               DECLARE ainr301_g02_repcur06_1 CURSOR FROM g_sql
#               FOREACH ainr301_g02_repcur06_1 INTO sr6[l_ac].*  
#                  LET l_ac = l_ac+1                                
#               END FOREACH      
#               LET l_ac = l_ac-1               
#               LET l_i = 1                       
#               IF l_ac > 0 THEN      
#                  WHILE TRUE                         
#                     INITIALIZE sr4.* TO NULL
#                     LET sr4.inaodocno = sr6[l_i].inaodocno
#                     LET sr4.inao008_1 = sr6[l_i].inao008
#                     LET sr4.inao009_1 = sr6[l_i].inao009
#                     LET sr4.l_inao008_1_inao009_1  = sr4.inao008_1  , "/" , sr4.inao009_1                                                                                         
#                     IF l_i+1 <= l_ac THEN    
#                        LET sr4.inaodocno = sr6[l_i+1].inaodocno
#                        LET sr4.inao008_2 = sr6[l_i+1].inao008
#                        LET sr4.inao009_2 = sr6[l_i+1].inao009
#                        LET sr4.l_inao008_2_inao009_2 =  sr4.inao008_2 , "/" , sr4.inao009_2                              
#                     END IF
#                     
#                     IF l_i+2 <= l_ac THEN    
#                        LET sr4.inaodocno = sr6[l_i+2].inaodocno
#                        LET sr4.inao008_3 = sr6[l_i+2].inao008
#                        LET sr4.inao009_3 = sr6[l_i+2].inao009                  
#                        LET sr4.l_inao008_3_inao009_3 = sr4.inao008_3 , "/" , sr4.inao009_3
#                     END IF              
#                            
#                     PRINTX sr4.*              
#                     LET l_i = l_i + 3
#                     IF l_i > l_ac THEN  
#                        EXIT WHILE
#                     END IF                     
#                  END  WHILE                                                
#               END IF 
#               LET g_sql = "SELECT inaodocno,inao008,inao012",
#                           "  FROM inao_t,inbb_t ",
#                          " WHERE inaoent     = '",g_enterprise      CLIPPED,"'",                                               
#                           "   AND inaosite    = '",g_site     CLIPPED,"'",
#                           "   AND inaodocno   = '",sr_erwei.docno    CLIPPED,"'",                    
#                           "   AND inaoseq= inbbseq and inaodocno=inbbdocno AND inaoent=inbbent and inaosite=inbbsite",
#                           "   AND inbb001='",sr_erwei.item,"'",
#                           "   AND '-'||trim(inbb007)||'-'||trim(inbb008)||'-'||trim(inbb009)||'-'||trim(inbb016)||'-' = '",sr_erwei.condition,"'",                                                    
#                           "   AND inao000     = '2'",
#                           "   AND inao008 IS NOT NULL ",
#                           "   AND inao009 IS NULL "  
#                             
#               LET l_ac = 1                              
#               CALL sr7.clear()                 
#               DECLARE ainr301_g02_repcur07_1 CURSOR FROM g_sql
#               FOREACH ainr301_g02_repcur07_1 INTO sr7[l_ac].*
#                   LET l_ac = l_ac+1                                
#               END FOREACH      
#               LET l_ac = l_ac-1               
#               LET l_i = 1                           
#               IF l_ac > 0 THEN
#                  WHILE TRUE                         
#                     INITIALIZE sr5.* TO NULL
#                     LET sr5.inaodocno = sr7[l_i].inaodocno
#                     LET sr5.inao008_1 = sr7[l_i].inao008
#                     LET sr5.inao012_1 = sr7[l_i].inao012
#                     LET sr5.l_inao008_1_inao012_1  = sr5.inao008_1  , "/" , sr5.inao012_1                                                                                         
#                     IF l_i+1 <= l_ac THEN    
#                        LET sr5.inaodocno = sr7[l_i].inaodocno
#                        LET sr5.inao008_2 = sr7[l_i+1].inao008
#                        LET sr5.inao012_2 = sr7[l_i+1].inao012
#                        LET sr5.l_inao008_2_inao012_2 =  sr5.inao008_2 , "/" , sr5.inao012_2                              
#                     END IF
#                     
#                     IF l_i+2 <= l_ac THEN    
#                        LET sr5.inaodocno = sr7[l_i].inaodocno
#                        LET sr5.inao008_3 = sr7[l_i+2].inao008
#                        LET sr5.inao012_3 = sr7[l_i+2].inao012                  
#                        LET sr5.l_inao008_3_inao012_3 = sr5.inao008_3 , "/" , sr5.inao012_3
#                     END IF              
#                            
#                     PRINTX sr5.*              
#                     LET l_i = l_i + 3
#                     IF l_i > l_ac THEN  
#                        EXIT WHILE
#                     END IF                     
#                  END  WHILE 
#               END IF                             
#            END IF 
            
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
        
        BEFORE GROUP OF sr_erwei.item
          
           
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
            LET l_qty_sum = sr_erwei.qty001+sr_erwei.qty002+sr_erwei.qty003+sr_erwei.qty004+sr_erwei.qty005
                           +sr_erwei.qty006+sr_erwei.qty007+sr_erwei.qty008+sr_erwei.qty009+sr_erwei.qty010
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
            IF l_old_item is not null and l_old_item<> sr_erwei.item THEN
              LET l_sum.sum01=0
              LET l_sum.sum02=0
              LET l_sum.sum03=0 
              LET l_sum.sum04=0 
              LET l_sum.sum05=0
              LET l_sum.sum06=0 
              LET l_sum.sum07=0
              LET l_sum.sum08=0 
              LET l_sum.sum09=0 
              LET l_sum.sum10=0 
            END IF 
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
            LET l_old_item= sr_erwei.item           
 
        AFTER GROUP OF sr_erwei.item
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
            
            
        AFTER GROUP OF sr_erwei.docno
           # #横向总计
           # EXECUTE qty_total INTO l_qty_total USING sr_erwei.docno,sr_erwei.imaal003,sr_erwei.condition,sr_erwei.item
           # IF cl_null(l_qty_total) THEN LET l_qty_total = 0 END IF
           # PRINTX l_qty_total                   
          #  #总数量
          #  EXECUTE qty_total_sum INTO l_total USING sr_erwei.docno
          #  IF cl_null(l_total) THEN LET l_total = 0 END IF
          #  #纵向小计
          #  LET l_sum.sum11=l_sum.sum01+l_sum.sum02+l_sum.sum03+l_sum.sum04+l_sum.sum05+l_sum.sum06+l_sum.sum07+l_sum.sum08+l_sum.sum09+l_sum.sum10
          #  PRINTX l_sum.*
            
END REPORT

 
{</section>}
 
