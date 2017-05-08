#該程式未解開Section, 採用最新樣板產出!
{<section id="ainr520_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2016-07-04 11:14:49), PR版次:0002(2016-07-05 08:36:12)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000060
#+ Filename...: ainr520_g01
#+ Description: ...
#+ Creator....: 06137(2015-02-11 15:42:06)
#+ Modifier...: 06137 -SD/PR- 06137
 
{</section>}
 
{<section id="ainr520_g01.global" readonly="Y" >}
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
   inde001 LIKE inde_t.inde001, 
   inde002 LIKE inde_t.inde002, 
   inde003 LIKE inde_t.inde003, 
   inde004 LIKE inde_t.inde004, 
   inde005 LIKE inde_t.inde005, 
   inde006 LIKE inde_t.inde006, 
   indedocdt LIKE inde_t.indedocdt, 
   indedocno LIKE inde_t.indedocno, 
   indeent LIKE inde_t.indeent, 
   indesite LIKE inde_t.indesite, 
   indestus LIKE inde_t.indestus, 
   indeunit LIKE inde_t.indeunit, 
   indf001 LIKE indf_t.indf001, 
   indf002 LIKE indf_t.indf002, 
   indf003 LIKE indf_t.indf003, 
   indf004 LIKE indf_t.indf004, 
   indf005 LIKE indf_t.indf005, 
   indf006 LIKE indf_t.indf006, 
   indf007 LIKE indf_t.indf007, 
   indf008 LIKE indf_t.indf008, 
   indf020 LIKE indf_t.indf020, 
   indf021 LIKE indf_t.indf021, 
   indf022 LIKE indf_t.indf022, 
   indf023 LIKE indf_t.indf023, 
   indf024 LIKE indf_t.indf024, 
   indf030 LIKE indf_t.indf030, 
   indf031 LIKE indf_t.indf031, 
   indf032 LIKE indf_t.indf032, 
   indf033 LIKE indf_t.indf033, 
   indf034 LIKE indf_t.indf034, 
   indf040 LIKE indf_t.indf040, 
   indf041 LIKE indf_t.indf041, 
   indf042 LIKE indf_t.indf042, 
   indf043 LIKE indf_t.indf043, 
   indfseq LIKE indf_t.indfseq, 
   indfsite LIKE indf_t.indfsite, 
   indfunit LIKE indf_t.indfunit, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   t1_ooefl003 LIKE ooefl_t.ooefl003, 
   t2_ooefl003 LIKE ooefl_t.ooefl003, 
   inayl_t_inayl003 LIKE inayl_t.inayl003, 
   x_t3_inayl003 LIKE inayl_t.inayl003, 
   x_t5_inayl003 LIKE inayl_t.inayl003, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   x_oocal_t_oocal003 LIKE oocal_t.oocal003, 
   x_t6_oocal003 LIKE oocal_t.oocal003, 
   x_inab_t_inab003 LIKE inab_t.inab003, 
   x_t4_inab003 LIKE inab_t.inab003, 
   x_oocql_t_oocql004 LIKE oocql_t.oocql004, 
   l_indesite_ooefl003 LIKE type_t.chr1000, 
   l_inde002_ooag011 LIKE type_t.chr300, 
   l_inde003_ooefl003 LIKE type_t.chr1000, 
   l_inde004_ooefl003 LIKE type_t.chr1000, 
   l_inde005_inayl003 LIKE type_t.chr1000, 
   l_indf022_inayl003 LIKE type_t.chr1000, 
   l_indf033_inab003 LIKE type_t.chr1000, 
   l_indf023_inab003 LIKE type_t.chr1000, 
   l_indf032_inayl003 LIKE type_t.chr1000, 
   x_imaal_t_imaal004 LIKE imaal_t.imaal004, 
   l_indf042_oocql004 LIKE type_t.chr200, 
   l_inde101_ooefl003 LIKE type_t.chr200, 
   inde101 LIKE inde_t.inde101
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
 
{<section id="ainr520_g01.main" readonly="Y" >}
PUBLIC FUNCTION ainr520_g01(p_arg1)
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
   
   LET g_rep_code = "ainr520_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL ainr520_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL ainr520_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL ainr520_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="ainr520_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION ainr520_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   #160420-00039#14 Add By ken 160704(S)效能調整
   LET g_select = " SELECT inde001,inde002,inde003,inde004,inde005,inde006,indedocdt,indedocno,indeent, 
       indesite,indestus,indeunit,indf001,indf002,indf003,indf004,indf005,indf006,indf007,indf008,indf020, 
       indf021,indf022,indf023,indf024,indf030,indf031,indf032,indf033,indf034,indf040,indf041,indf042, 
       indf043,indfseq,indfsite,indfunit,ooag_t.ooag011,ooefl_t.ooefl003,t1.ooefl003,t2.ooefl003,inayl_t.inayl003, 
       x.t3_inayl003,x.t5_inayl003,x.imaal_t_imaal003,x.oocal_t_oocal003,x.t6_oocal003,x.inab_t_inab003, 
       x.t4_inab003,x.oocql_t_oocql004,trim(indesite)||'.'||trim(t1.ooefl003),trim(inde002)||'.'||trim(ooag_t.ooag011), 
       trim(inde003)||'.'||trim(ooefl_t.ooefl003),trim(inde004)||'.'||trim(t2.ooefl003),trim(inde005)||'.'||trim(inayl_t.inayl003), 
       trim(indf022)||'.'||trim(x.t5_inayl003),trim(indf033)||'.'||trim(x.t4_inab003),trim(indf023)||'.'||trim(x.inab_t_inab003), 
       trim(indf032)||'.'||trim(x.t3_inayl003),x.imaal_t_imaal004,trim(indf042)||'.'||trim(x.oocql_t_oocql004), 
       (SELECT trim(inde101)||'.'||trim(ooefl003)
          FROM ooefl_t WHERE ooeflent = indeent AND ooefl001 = inde101 AND ooefl002 = '",g_dlang,"') l_inde101_ooefl003,
       inde101"
   #160420-00039#14 Add By ken 160704(E)效能調整
   
   #160420-00039#14 Mark By ken 160704(S)效能調整
#   #end add-point
#   LET g_select = " SELECT inde001,inde002,inde003,inde004,inde005,inde006,indedocdt,indedocno,indeent, 
#       indesite,indestus,indeunit,indf001,indf002,indf003,indf004,indf005,indf006,indf007,indf008,indf020, 
#       indf021,indf022,indf023,indf024,indf030,indf031,indf032,indf033,indf034,indf040,indf041,indf042, 
#       indf043,indfseq,indfsite,indfunit,( SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = inde_t.inde002 AND ooag_t.ooagent = inde_t.indeent), 
#       ( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooeflent = inde_t.indeent AND ooefl_t.ooefl001 = inde_t.inde003 AND ooefl_t.ooefl002 = '" , 
#       g_dlang,"'" ,"),( SELECT ooefl003 FROM ooefl_t t1 WHERE t1.ooeflent = inde_t.indeent AND t1.ooefl001 = inde_t.indesite AND t1.ooefl002 = '" , 
#       g_dlang,"'" ,"),( SELECT ooefl003 FROM ooefl_t t2 WHERE t2.ooeflent = inde_t.indeent AND t2.ooefl001 = inde_t.inde004 AND t2.ooefl002 = '" , 
#       g_dlang,"'" ,"),( SELECT inayl003 FROM inayl_t WHERE inayl_t.inaylent = inde_t.indeent AND inayl_t.inayl001 = inde_t.inde005 AND inayl_t.inayl002 = '" , 
#       g_dlang,"'" ,"),x.t3_inayl003,x.t5_inayl003,x.imaal_t_imaal003,x.oocal_t_oocal003,x.t6_oocal003, 
#       x.inab_t_inab003,x.t4_inab003,x.oocql_t_oocql004,trim(indesite)||'.'||trim((SELECT ooefl003 FROM ooefl_t t1 WHERE t1.ooeflent = inde_t.indeent AND t1.ooefl001 = inde_t.indesite AND t1.ooefl002 = '" , 
#       g_dlang,"'" ,")),trim(inde002)||'.'||trim((SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = inde_t.inde002 AND ooag_t.ooagent = inde_t.indeent)), 
#       trim(inde003)||'.'||trim((SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooeflent = inde_t.indeent AND ooefl_t.ooefl001 = inde_t.inde003 AND ooefl_t.ooefl002 = '" , 
#       g_dlang,"'" ,")),trim(inde004)||'.'||trim((SELECT ooefl003 FROM ooefl_t t2 WHERE t2.ooeflent = inde_t.indeent AND t2.ooefl001 = inde_t.inde004 AND t2.ooefl002 = '" , 
#       g_dlang,"'" ,")),trim(inde005)||'.'||trim((SELECT inayl003 FROM inayl_t WHERE inayl_t.inaylent = inde_t.indeent AND inayl_t.inayl001 = inde_t.inde005 AND inayl_t.inayl002 = '" , 
#       g_dlang,"'" ,")),trim(indf022)||'.'||trim(x.t5_inayl003),trim(indf033)||'.'||trim(x.t4_inab003), 
#       trim(indf023)||'.'||trim(x.inab_t_inab003),trim(indf032)||'.'||trim(x.t3_inayl003),x.imaal_t_imaal004, 
#       trim(indf042)||'.'||trim(x.oocql_t_oocql004),NULL,inde101"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   #160420-00039#14 Mark By ken 160704(E)效能調整

   #end add-point
    LET g_from = " FROM inde_t LEFT OUTER JOIN ( SELECT indf_t.*,( SELECT inayl003 FROM inayl_t t3 WHERE t3.inaylent = indf_t.indfent AND t3.inayl001 = indf_t.indf032 AND t3.inayl002 = '" , 
        g_dlang,"'" ,") t3_inayl003,( SELECT inayl003 FROM inayl_t t5 WHERE t5.inaylent = indf_t.indfent AND t5.inayl001 = indf_t.indf022 AND t5.inayl002 = '" , 
        g_dlang,"'" ,") t5_inayl003,( SELECT imaal003 FROM imaal_t WHERE imaal_t.imaalent = indf_t.indfent AND imaal_t.imaal001 = indf_t.indf002 AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,") imaal_t_imaal003,( SELECT oocal003 FROM oocal_t WHERE oocal_t.oocalent = indf_t.indfent AND oocal_t.oocal001 = indf_t.indf007 AND oocal_t.oocal002 = '" , 
        g_dlang,"'" ,") oocal_t_oocal003,( SELECT oocal003 FROM oocal_t t6 WHERE t6.oocalent = indf_t.indfent AND t6.oocal001 = indf_t.indf006 AND t6.oocal002 = '" , 
        g_dlang,"'" ,") t6_oocal003,( SELECT inab003 FROM inab_t WHERE inab_t.inabent = indf_t.indfent AND inab_t.inab001 = indf_t.indf022 AND inab_t.inab002 = indf_t.indf023) inab_t_inab003, 
        ( SELECT inab003 FROM inab_t t4 WHERE t4.inabent = indf_t.indfent AND t4.inab001 = indf_t.indf032 AND t4.inab002 = indf_t.indf033) t4_inab003, 
        ( SELECT oocql004 FROM oocql_t WHERE oocql_t.oocqlent = indf_t.indfent AND oocql_t.oocql001 = '2102' AND oocql_t.oocql002 = indf_t.indf042 AND oocql_t.oocql003 = '" , 
        g_dlang,"'" ,") oocql_t_oocql004,( SELECT imaal004 FROM imaal_t WHERE imaal_t.imaalent = indf_t.indfent AND imaal_t.imaal001 = indf_t.indf002 AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,") imaal_t_imaal004 FROM indf_t ) x  ON inde_t.indeent = x.indfent AND inde_t.indedocno  
        = x.indfdocno"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
    LET g_order = " ORDER BY indedocno,indfseq"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("inde_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE ainr520_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE ainr520_g01_curs CURSOR FOR ainr520_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="ainr520_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION ainr520_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   inde001 LIKE inde_t.inde001, 
   inde002 LIKE inde_t.inde002, 
   inde003 LIKE inde_t.inde003, 
   inde004 LIKE inde_t.inde004, 
   inde005 LIKE inde_t.inde005, 
   inde006 LIKE inde_t.inde006, 
   indedocdt LIKE inde_t.indedocdt, 
   indedocno LIKE inde_t.indedocno, 
   indeent LIKE inde_t.indeent, 
   indesite LIKE inde_t.indesite, 
   indestus LIKE inde_t.indestus, 
   indeunit LIKE inde_t.indeunit, 
   indf001 LIKE indf_t.indf001, 
   indf002 LIKE indf_t.indf002, 
   indf003 LIKE indf_t.indf003, 
   indf004 LIKE indf_t.indf004, 
   indf005 LIKE indf_t.indf005, 
   indf006 LIKE indf_t.indf006, 
   indf007 LIKE indf_t.indf007, 
   indf008 LIKE indf_t.indf008, 
   indf020 LIKE indf_t.indf020, 
   indf021 LIKE indf_t.indf021, 
   indf022 LIKE indf_t.indf022, 
   indf023 LIKE indf_t.indf023, 
   indf024 LIKE indf_t.indf024, 
   indf030 LIKE indf_t.indf030, 
   indf031 LIKE indf_t.indf031, 
   indf032 LIKE indf_t.indf032, 
   indf033 LIKE indf_t.indf033, 
   indf034 LIKE indf_t.indf034, 
   indf040 LIKE indf_t.indf040, 
   indf041 LIKE indf_t.indf041, 
   indf042 LIKE indf_t.indf042, 
   indf043 LIKE indf_t.indf043, 
   indfseq LIKE indf_t.indfseq, 
   indfsite LIKE indf_t.indfsite, 
   indfunit LIKE indf_t.indfunit, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   t1_ooefl003 LIKE ooefl_t.ooefl003, 
   t2_ooefl003 LIKE ooefl_t.ooefl003, 
   inayl_t_inayl003 LIKE inayl_t.inayl003, 
   x_t3_inayl003 LIKE inayl_t.inayl003, 
   x_t5_inayl003 LIKE inayl_t.inayl003, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   x_oocal_t_oocal003 LIKE oocal_t.oocal003, 
   x_t6_oocal003 LIKE oocal_t.oocal003, 
   x_inab_t_inab003 LIKE inab_t.inab003, 
   x_t4_inab003 LIKE inab_t.inab003, 
   x_oocql_t_oocql004 LIKE oocql_t.oocql004, 
   l_indesite_ooefl003 LIKE type_t.chr1000, 
   l_inde002_ooag011 LIKE type_t.chr300, 
   l_inde003_ooefl003 LIKE type_t.chr1000, 
   l_inde004_ooefl003 LIKE type_t.chr1000, 
   l_inde005_inayl003 LIKE type_t.chr1000, 
   l_indf022_inayl003 LIKE type_t.chr1000, 
   l_indf033_inab003 LIKE type_t.chr1000, 
   l_indf023_inab003 LIKE type_t.chr1000, 
   l_indf032_inayl003 LIKE type_t.chr1000, 
   x_imaal_t_imaal004 LIKE imaal_t.imaal004, 
   l_indf042_oocql004 LIKE type_t.chr200, 
   l_inde101_ooefl003 LIKE type_t.chr200, 
   inde101 LIKE inde_t.inde101
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
    FOREACH ainr520_g01_curs INTO sr_s.*
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
       #160420-00039#14 Mark By Ken 160704(S)效能調整
       #調整部門說明
       #SELECT trim(inde101)||'.'||trim(ooefl003) INTO sr_s.l_inde101_ooefl003
       #  FROM inde_t
       #  LEFT OUTER JOIN ooefl_t ON ooefl_t.ooeflent = inde_t.indeent AND ooefl_t.ooefl001 = inde_t.inde101 AND ooefl_t.ooefl002 = g_dlang
       # WHERE indeent = g_enterprise
       #   AND indedocno = sr_s.indedocno 
       #160420-00039#14 Mark By Ken 160704(E)效能調整
  
       CALL ainr520_g01_initialize(sr_s.indesite,sr_s.l_indesite_ooefl003) RETURNING sr_s.l_indesite_ooefl003
       CALL ainr520_g01_initialize(sr_s.inde002,sr_s.l_inde002_ooag011) RETURNING sr_s.l_inde002_ooag011
       CALL ainr520_g01_initialize(sr_s.inde003,sr_s.l_inde003_ooefl003) RETURNING sr_s.l_inde003_ooefl003
       CALL ainr520_g01_initialize(sr_s.inde004,sr_s.l_inde004_ooefl003) RETURNING sr_s.l_inde004_ooefl003
       CALL ainr520_g01_initialize(sr_s.inde005,sr_s.l_inde005_inayl003) RETURNING sr_s.l_inde005_inayl003
       CALL ainr520_g01_initialize(sr_s.indf022,sr_s.l_indf022_inayl003) RETURNING sr_s.l_indf022_inayl003 
       CALL ainr520_g01_initialize(sr_s.indf033,sr_s.l_indf033_inab003) RETURNING sr_s.l_indf033_inab003 
       CALL ainr520_g01_initialize(sr_s.indf023,sr_s.l_indf023_inab003) RETURNING sr_s.l_indf023_inab003 
       CALL ainr520_g01_initialize(sr_s.indf032,sr_s.l_indf032_inayl003) RETURNING sr_s.l_indf032_inayl003 
       CALL ainr520_g01_initialize(sr_s.indf042,sr_s.l_indf042_oocql004) RETURNING sr_s.l_indf042_oocql004 
       CALL ainr520_g01_initialize(sr_s.inde101,sr_s.l_inde101_ooefl003) RETURNING sr_s.l_inde101_ooefl003 
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].inde001 = sr_s.inde001
       LET sr[l_cnt].inde002 = sr_s.inde002
       LET sr[l_cnt].inde003 = sr_s.inde003
       LET sr[l_cnt].inde004 = sr_s.inde004
       LET sr[l_cnt].inde005 = sr_s.inde005
       LET sr[l_cnt].inde006 = sr_s.inde006
       LET sr[l_cnt].indedocdt = sr_s.indedocdt
       LET sr[l_cnt].indedocno = sr_s.indedocno
       LET sr[l_cnt].indeent = sr_s.indeent
       LET sr[l_cnt].indesite = sr_s.indesite
       LET sr[l_cnt].indestus = sr_s.indestus
       LET sr[l_cnt].indeunit = sr_s.indeunit
       LET sr[l_cnt].indf001 = sr_s.indf001
       LET sr[l_cnt].indf002 = sr_s.indf002
       LET sr[l_cnt].indf003 = sr_s.indf003
       LET sr[l_cnt].indf004 = sr_s.indf004
       LET sr[l_cnt].indf005 = sr_s.indf005
       LET sr[l_cnt].indf006 = sr_s.indf006
       LET sr[l_cnt].indf007 = sr_s.indf007
       LET sr[l_cnt].indf008 = sr_s.indf008
       LET sr[l_cnt].indf020 = sr_s.indf020
       LET sr[l_cnt].indf021 = sr_s.indf021
       LET sr[l_cnt].indf022 = sr_s.indf022
       LET sr[l_cnt].indf023 = sr_s.indf023
       LET sr[l_cnt].indf024 = sr_s.indf024
       LET sr[l_cnt].indf030 = sr_s.indf030
       LET sr[l_cnt].indf031 = sr_s.indf031
       LET sr[l_cnt].indf032 = sr_s.indf032
       LET sr[l_cnt].indf033 = sr_s.indf033
       LET sr[l_cnt].indf034 = sr_s.indf034
       LET sr[l_cnt].indf040 = sr_s.indf040
       LET sr[l_cnt].indf041 = sr_s.indf041
       LET sr[l_cnt].indf042 = sr_s.indf042
       LET sr[l_cnt].indf043 = sr_s.indf043
       LET sr[l_cnt].indfseq = sr_s.indfseq
       LET sr[l_cnt].indfsite = sr_s.indfsite
       LET sr[l_cnt].indfunit = sr_s.indfunit
       LET sr[l_cnt].ooag_t_ooag011 = sr_s.ooag_t_ooag011
       LET sr[l_cnt].ooefl_t_ooefl003 = sr_s.ooefl_t_ooefl003
       LET sr[l_cnt].t1_ooefl003 = sr_s.t1_ooefl003
       LET sr[l_cnt].t2_ooefl003 = sr_s.t2_ooefl003
       LET sr[l_cnt].inayl_t_inayl003 = sr_s.inayl_t_inayl003
       LET sr[l_cnt].x_t3_inayl003 = sr_s.x_t3_inayl003
       LET sr[l_cnt].x_t5_inayl003 = sr_s.x_t5_inayl003
       LET sr[l_cnt].x_imaal_t_imaal003 = sr_s.x_imaal_t_imaal003
       LET sr[l_cnt].x_oocal_t_oocal003 = sr_s.x_oocal_t_oocal003
       LET sr[l_cnt].x_t6_oocal003 = sr_s.x_t6_oocal003
       LET sr[l_cnt].x_inab_t_inab003 = sr_s.x_inab_t_inab003
       LET sr[l_cnt].x_t4_inab003 = sr_s.x_t4_inab003
       LET sr[l_cnt].x_oocql_t_oocql004 = sr_s.x_oocql_t_oocql004
       LET sr[l_cnt].l_indesite_ooefl003 = sr_s.l_indesite_ooefl003
       LET sr[l_cnt].l_inde002_ooag011 = sr_s.l_inde002_ooag011
       LET sr[l_cnt].l_inde003_ooefl003 = sr_s.l_inde003_ooefl003
       LET sr[l_cnt].l_inde004_ooefl003 = sr_s.l_inde004_ooefl003
       LET sr[l_cnt].l_inde005_inayl003 = sr_s.l_inde005_inayl003
       LET sr[l_cnt].l_indf022_inayl003 = sr_s.l_indf022_inayl003
       LET sr[l_cnt].l_indf033_inab003 = sr_s.l_indf033_inab003
       LET sr[l_cnt].l_indf023_inab003 = sr_s.l_indf023_inab003
       LET sr[l_cnt].l_indf032_inayl003 = sr_s.l_indf032_inayl003
       LET sr[l_cnt].x_imaal_t_imaal004 = sr_s.x_imaal_t_imaal004
       LET sr[l_cnt].l_indf042_oocql004 = sr_s.l_indf042_oocql004
       LET sr[l_cnt].l_inde101_ooefl003 = sr_s.l_inde101_ooefl003
       LET sr[l_cnt].inde101 = sr_s.inde101
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="ainr520_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION ainr520_g01_rep_data()
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
          START REPORT ainr520_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT ainr520_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT ainr520_g01_rep
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
 
{<section id="ainr520_g01.rep" readonly="Y" >}
PRIVATE REPORT ainr520_g01_rep(sr1)
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
DEFINE l_ooef012         LIKE ooef_t.ooef012   #聯絡對象識別碼
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER EXTERNAL BY sr1.indedocno,sr1.indfseq
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
        BEFORE GROUP OF sr1.indedocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"

            #取法人對內名稱
            SELECT ooef017 INTO l_ooef017 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = sr1.indesite               
            LET l_g_site_t = g_site #備份g_site預設值
            LET g_site = l_ooef017  #抓法人資料
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.indedocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"

            LET g_site = l_g_site_t #恢復原g_site值
            
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'indeent=' ,sr1.indeent,'{+}indedocno=' ,sr1.indedocno         
            CALL cl_gr_init_apr(sr1.indedocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.indedocno.before name="rep.b_group.indedocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.indeent CLIPPED ,"'", " AND  ooff003 = '", sr1.indedocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE ainr520_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE ainr520_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT ainr520_g01_subrep01
           DECLARE ainr520_g01_repcur01 CURSOR FROM g_sql
           FOREACH ainr520_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "ainr520_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT ainr520_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT ainr520_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.indedocno.after name="rep.b_group.indedocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.indfseq
 
           #add-point:rep.b_group.indfseq.before name="rep.b_group.indfseq.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.indfseq.after name="rep.b_group.indfseq.after"
           
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
                sr1.indeent CLIPPED ,"'", " AND  ooff003 = '", sr1.indedocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.indfseq CLIPPED ,""
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE ainr520_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE ainr520_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT ainr520_g01_subrep02
           DECLARE ainr520_g01_repcur02 CURSOR FROM g_sql
           FOREACH ainr520_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "ainr520_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT ainr520_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT ainr520_g01_subrep02
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
                sr1.indeent CLIPPED ,"'", " AND  ooff003 = '", sr1.indedocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.indfseq CLIPPED ,""
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE ainr520_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE ainr520_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT ainr520_g01_subrep03
           DECLARE ainr520_g01_repcur03 CURSOR FROM g_sql
           FOREACH ainr520_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "ainr520_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT ainr520_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT ainr520_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.indedocno
 
           #add-point:rep.a_group.indedocno.before name="rep.a_group.indedocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.indeent CLIPPED ,"'", " AND  ooff003 = '", sr1.indedocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE ainr520_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE ainr520_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT ainr520_g01_subrep04
           DECLARE ainr520_g01_repcur04 CURSOR FROM g_sql
           FOREACH ainr520_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "ainr520_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT ainr520_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT ainr520_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.indedocno.after name="rep.a_group.indedocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.indfseq
 
           #add-point:rep.a_group.indfseq.before name="rep.a_group.indfseq.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.indfseq.after name="rep.a_group.indfseq.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="ainr520_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT ainr520_g01_subrep01(sr2)
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
PRIVATE REPORT ainr520_g01_subrep02(sr2)
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
PRIVATE REPORT ainr520_g01_subrep03(sr2)
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
PRIVATE REPORT ainr520_g01_subrep04(sr2)
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
 
{<section id="ainr520_g01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 
# Memo...........:
# Usage..........: CALL ainr520_g01_initialize(p_arg,p_exp)
#                  RETURNING r_exp
# Input parameter: p_arg    編號
#                : p_exp    說明
# Return code....: r_exp    顯示值
# Date & Author..: 2015/02/11 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION ainr520_g01_initialize(p_arg,p_exp)
DEFINE p_arg   STRING
DEFINE p_exp   STRING
DEFINE r_exp   STRING
   INITIALIZE r_exp TO NULL
   IF cl_null(p_arg) OR p_exp = '.' THEN
      #INITIALIZE r_exp TO NULL
      LET r_exp = p_arg
   ELSE
      LET r_exp = p_exp
   END IF
   RETURN r_exp
END FUNCTION

 
{</section>}
 
{<section id="ainr520_g01.other_report" readonly="Y" >}
{<point name="other.report"/>}
 
{</section>}
 
