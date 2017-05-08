#該程式未解開Section, 採用最新樣板產出!
{<section id="asfr335_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:7(2016-11-09 14:36:20), PR版次:0007(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000229
#+ Filename...: asfr335_g01
#+ Description: ...
#+ Creator....: 05384(2014-05-27 11:08:06)
#+ Modifier...: 08993 -SD/PR- 00000
 
{</section>}
 
{<section id="asfr335_g01.global" readonly="Y" >}
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
   sffbseq LIKE sffb_t.sffbseq, 
   sffbstus LIKE sffb_t.sffbstus, 
   sffb013 LIKE sffb_t.sffb013, 
   sffb016 LIKE sffb_t.sffb016, 
   sffc002 LIKE sffc_t.sffc002, 
   sffb008 LIKE sffb_t.sffb008, 
   sffbdocdt LIKE sffb_t.sffbdocdt, 
   sffb010 LIKE sffb_t.sffb010, 
   sffb014 LIKE sffb_t.sffb014, 
   sffb015 LIKE sffb_t.sffb015, 
   sffb017 LIKE sffb_t.sffb017, 
   sffb018 LIKE sffb_t.sffb018, 
   sffb001 LIKE sffb_t.sffb001, 
   sffb005 LIKE sffb_t.sffb005, 
   sffb009 LIKE sffb_t.sffb009, 
   sffc003 LIKE sffc_t.sffc003, 
   sffb002 LIKE sffb_t.sffb002, 
   sffb003 LIKE sffb_t.sffb003, 
   sffbsite LIKE sffb_t.sffbsite, 
   sffc004 LIKE sffc_t.sffc004, 
   sffc006 LIKE sffc_t.sffc006, 
   sffbdocno LIKE sffb_t.sffbdocno, 
   sffb004 LIKE sffb_t.sffb004, 
   sffb019 LIKE sffb_t.sffb019, 
   sffb024 LIKE sffb_t.sffb024, 
   sffc001 LIKE sffc_t.sffc001, 
   sffb006 LIKE sffb_t.sffb006, 
   sffb007 LIKE sffb_t.sffb007, 
   sffb012 LIKE sffb_t.sffb012, 
   sffb011 LIKE sffb_t.sffb011, 
   sffb020 LIKE sffb_t.sffb020, 
   sffc005 LIKE sffc_t.sffc005, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   oogd_t_oogd002 LIKE oogd_t.oogd002, 
   x_t1_oocql004 LIKE oocql_t.oocql004, 
   ecaa_t_ecaa002 LIKE ecaa_t.ecaa002, 
   mrba_t_mrba004 LIKE mrba_t.mrba004, 
   ooge_t_ooge002 LIKE ooge_t.ooge002, 
   oocql_t_oocql004 LIKE oocql_t.oocql004, 
   sffbent LIKE sffb_t.sffbent, 
   sffcdocno LIKE sffc_t.sffcdocno, 
   sffcent LIKE sffc_t.sffcent, 
   sffcseq LIKE sffc_t.sffcseq, 
   sffcsite LIKE sffc_t.sffcsite, 
   l_sffbdocno_oobal004 LIKE type_t.chr200, 
   l_imaal003 LIKE imaal_t.imaal003, 
   l_imaal004 LIKE imaal_t.imaal004, 
   l_sfaa010 LIKE sfaa_t.sfaa010, 
   l_sffb001_desc LIKE gzcbl_t.gzcbl004, 
   l_sfia007 LIKE sfia_t.sfia007, 
   l_sfcbnum LIKE sfcb_t.sfcb046, 
   l_sfcb003 LIKE sfcb_t.sfcb003, 
   l_sfcb004 LIKE sfcb_t.sfcb004, 
   l_count LIKE type_t.num5, 
   l_sffcseq_show LIKE type_t.chr1, 
   l_sffb014 LIKE type_t.chr20, 
   l_sffb015 LIKE type_t.chr20, 
   l_sffb002_ooag011 LIKE type_t.chr30, 
   l_sfcb003_desc LIKE oocql_t.oocql004, 
   l_sfcb003_sfcb004 LIKE type_t.chr1000, 
   l_sffb007_sffb008 LIKE type_t.chr1000, 
   l_imaal003_imaal004 LIKE type_t.chr1000, 
   l_sffb009_ecaa002 LIKE type_t.chr1000, 
   l_sffb004_oogd002 LIKE type_t.chr1000, 
   l_sffb010_mrba004 LIKE type_t.chr1000, 
   l_sffb024_ooge002 LIKE type_t.chr1000, 
   l_sffb003_ooefl003 LIKE type_t.chr1000
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
TYPE sr3_r RECORD  #子報表(不良原因)
   sffddocno LIKE sffd_t.sffddocno, #單號
   sffd001 LIKE sffd_t.sffd001,  #異常項目
   sffd002 LIKE sffd_t.sffd002,  #數量
   sffd003 LIKE sffd_t.sffd003,  #備註
   l_sffd001_desc LIKE oocql_t.oocql004 #異常項目說明
END RECORD
DEFINE l_tmp LIKE type_t.num5
#end add-point
 
{</section>}
 
{<section id="asfr335_g01.main" readonly="Y" >}
PUBLIC FUNCTION asfr335_g01(p_arg1)
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
   
   LET g_rep_code = "asfr335_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL asfr335_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL asfr335_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL asfr335_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="asfr335_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION asfr335_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   
   #end add-point
   LET g_select = " SELECT sffbseq,sffbstus,sffb013,sffb016,sffc002,sffb008,sffbdocdt,sffb010,sffb014, 
       sffb015,sffb017,sffb018,sffb001,sffb005,sffb009,sffc003,sffb002,sffb003,sffbsite,sffc004,sffc006, 
       sffbdocno,sffb004,sffb019,sffb024,sffc001,sffb006,sffb007,sffb012,sffb011,sffb020,sffc005,( SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = sffb_t.sffb002 AND ooag_t.ooagent = sffb_t.sffbent), 
       ( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = sffb_t.sffb003 AND ooefl_t.ooeflent = sffb_t.sffbent AND ooefl_t.ooefl002 = '" , 
       g_dlang,"'" ,"),( SELECT oogd002 FROM oogd_t WHERE oogd_t.oogdsite = sffb_t.sffbsite AND oogd_t.oogd001 = sffb_t.sffb004 AND oogd_t.oogdent = sffb_t.sffbent), 
       x.t1_oocql004,( SELECT ecaa002 FROM ecaa_t WHERE ecaa_t.ecaasite = sffb_t.sffbsite AND ecaa_t.ecaa001 = sffb_t.sffb009 AND ecaa_t.ecaaent = sffb_t.sffbent), 
       ( SELECT mrba004 FROM mrba_t WHERE mrba_t.mrbasite = sffb_t.sffbsite AND mrba_t.mrba001 = sffb_t.sffb010 AND mrba_t.mrbaent = sffb_t.sffbent), 
       ( SELECT ooge002 FROM ooge_t WHERE ooge_t.oogesite = sffb_t.sffbsite AND ooge_t.ooge001 = sffb_t.sffb024 AND ooge_t.oogeent = sffb_t.sffbent), 
       ( SELECT oocql004 FROM oocql_t WHERE oocql_t.oocql001 = '221' AND oocql_t.oocql002 = sffb_t.sffb007 AND oocql_t.oocqlent = sffb_t.sffbent AND oocql_t.oocql003 = '" , 
       g_dlang,"'" ,"),sffbent,sffcdocno,sffcent,sffcseq,sffcsite,'','','','','','','','','','','','', 
       '',trim(sffb002)||'.'||trim((SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = sffb_t.sffb002 AND ooag_t.ooagent = sffb_t.sffbent)), 
       '','','','',trim(sffb009)||'.'||trim((SELECT ecaa002 FROM ecaa_t WHERE ecaa_t.ecaasite = sffb_t.sffbsite AND ecaa_t.ecaa001 = sffb_t.sffb009 AND ecaa_t.ecaaent = sffb_t.sffbent)), 
       trim(sffb004)||'.'||trim((SELECT oogd002 FROM oogd_t WHERE oogd_t.oogdsite = sffb_t.sffbsite AND oogd_t.oogd001 = sffb_t.sffb004 AND oogd_t.oogdent = sffb_t.sffbent)), 
       trim(sffb010)||'.'||trim((SELECT mrba004 FROM mrba_t WHERE mrba_t.mrbasite = sffb_t.sffbsite AND mrba_t.mrba001 = sffb_t.sffb010 AND mrba_t.mrbaent = sffb_t.sffbent)), 
       trim(sffb024)||'.'||trim((SELECT ooge002 FROM ooge_t WHERE ooge_t.oogesite = sffb_t.sffbsite AND ooge_t.ooge001 = sffb_t.sffb024 AND ooge_t.oogeent = sffb_t.sffbent)), 
       trim(sffb003)||'.'||trim((SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = sffb_t.sffb003 AND ooefl_t.ooeflent = sffb_t.sffbent AND ooefl_t.ooefl002 = '" , 
       g_dlang,"'" ,"))"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
 
   #end add-point
    LET g_from = " FROM sffb_t LEFT OUTER JOIN ( SELECT sffc_t.*,( SELECT oocql004 FROM oocql_t WHERE oocql_t.oocql001 = '223' AND oocql_t.oocql002 = sffc_t.sffc001 AND oocql_t.oocqlent = sffc_t.sffcent AND oocql_t.oocql003 = '" , 
        g_dlang,"'" ,") t1_oocql004 FROM sffc_t ) x  ON sffb_t.sffbent = x.sffcent AND sffb_t.sffbdocno  
        = x.sffcdocno AND sffb_t.sffbseq = x.sffcseq"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
    LET g_order = " ORDER BY sffbdocno,sffcseq"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("sffb_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE asfr335_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE asfr335_g01_curs CURSOR FOR asfr335_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="asfr335_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION asfr335_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   sffbseq LIKE sffb_t.sffbseq, 
   sffbstus LIKE sffb_t.sffbstus, 
   sffb013 LIKE sffb_t.sffb013, 
   sffb016 LIKE sffb_t.sffb016, 
   sffc002 LIKE sffc_t.sffc002, 
   sffb008 LIKE sffb_t.sffb008, 
   sffbdocdt LIKE sffb_t.sffbdocdt, 
   sffb010 LIKE sffb_t.sffb010, 
   sffb014 LIKE sffb_t.sffb014, 
   sffb015 LIKE sffb_t.sffb015, 
   sffb017 LIKE sffb_t.sffb017, 
   sffb018 LIKE sffb_t.sffb018, 
   sffb001 LIKE sffb_t.sffb001, 
   sffb005 LIKE sffb_t.sffb005, 
   sffb009 LIKE sffb_t.sffb009, 
   sffc003 LIKE sffc_t.sffc003, 
   sffb002 LIKE sffb_t.sffb002, 
   sffb003 LIKE sffb_t.sffb003, 
   sffbsite LIKE sffb_t.sffbsite, 
   sffc004 LIKE sffc_t.sffc004, 
   sffc006 LIKE sffc_t.sffc006, 
   sffbdocno LIKE sffb_t.sffbdocno, 
   sffb004 LIKE sffb_t.sffb004, 
   sffb019 LIKE sffb_t.sffb019, 
   sffb024 LIKE sffb_t.sffb024, 
   sffc001 LIKE sffc_t.sffc001, 
   sffb006 LIKE sffb_t.sffb006, 
   sffb007 LIKE sffb_t.sffb007, 
   sffb012 LIKE sffb_t.sffb012, 
   sffb011 LIKE sffb_t.sffb011, 
   sffb020 LIKE sffb_t.sffb020, 
   sffc005 LIKE sffc_t.sffc005, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   oogd_t_oogd002 LIKE oogd_t.oogd002, 
   x_t1_oocql004 LIKE oocql_t.oocql004, 
   ecaa_t_ecaa002 LIKE ecaa_t.ecaa002, 
   mrba_t_mrba004 LIKE mrba_t.mrba004, 
   ooge_t_ooge002 LIKE ooge_t.ooge002, 
   oocql_t_oocql004 LIKE oocql_t.oocql004, 
   sffbent LIKE sffb_t.sffbent, 
   sffcdocno LIKE sffc_t.sffcdocno, 
   sffcent LIKE sffc_t.sffcent, 
   sffcseq LIKE sffc_t.sffcseq, 
   sffcsite LIKE sffc_t.sffcsite, 
   l_sffbdocno_oobal004 LIKE type_t.chr200, 
   l_imaal003 LIKE imaal_t.imaal003, 
   l_imaal004 LIKE imaal_t.imaal004, 
   l_sfaa010 LIKE sfaa_t.sfaa010, 
   l_sffb001_desc LIKE gzcbl_t.gzcbl004, 
   l_sfia007 LIKE sfia_t.sfia007, 
   l_sfcbnum LIKE sfcb_t.sfcb046, 
   l_sfcb003 LIKE sfcb_t.sfcb003, 
   l_sfcb004 LIKE sfcb_t.sfcb004, 
   l_count LIKE type_t.num5, 
   l_sffcseq_show LIKE type_t.chr1, 
   l_sffb014 LIKE type_t.chr20, 
   l_sffb015 LIKE type_t.chr20, 
   l_sffb002_ooag011 LIKE type_t.chr30, 
   l_sfcb003_desc LIKE oocql_t.oocql004, 
   l_sfcb003_sfcb004 LIKE type_t.chr1000, 
   l_sffb007_sffb008 LIKE type_t.chr1000, 
   l_imaal003_imaal004 LIKE type_t.chr1000, 
   l_sffb009_ecaa002 LIKE type_t.chr1000, 
   l_sffb004_oogd002 LIKE type_t.chr1000, 
   l_sffb010_mrba004 LIKE type_t.chr1000, 
   l_sffb024_ooge002 LIKE type_t.chr1000, 
   l_sffb003_ooefl003 LIKE type_t.chr1000
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_sffb001_desc LIKE gzcbl_t.gzcbl004
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH asfr335_g01_curs INTO sr_s.*
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
       #建立暫時存取轉入作業/作業序的temp table及為後續查找上下站定義cursor
       IF s_asft335_cre_tmp_table() THEN
          CALL s_asft335_declare_sfcb()
          #先找到所有的下一站（但數量檔位都是原始未修改過的，最後計算了才累加）
          DELETE FROM s_asft335_tmp01
          IF s_asft335_get_next_station(sr_s.sffb001,sr_s.sffb005,sr_s.sffb006,sr_s.sffb007,sr_s.sffb008) THEN
             #刪除重複站點
             INSERT INTO s_asft335_tmp01
             SELECT DISTINCT 'Y',sfcbdocno,sfcb001,sfcb003,sfcb004,sfcb005,sfcb006,type,sfcb021,sfcb022,amt,sfcb053,sfcb054
               FROM s_asft335_tmp01
             DELETE FROM s_asft335_tmp01 WHERE chk = 'N'
          END IF
       END IF
       LET g_sql = "SELECT sfcb003,sfcb004",
                   "  FROM s_asft335_tmp01 ",                           
                   "  ORDER BY sfcb003 " 
       LET sr_s.l_count = 0                          

       DECLARE asfr335_g01_sfcb CURSOR FROM g_sql
       FOREACH asfr335_g01_sfcb INTO sr_s.l_sfcb003,sr_s.l_sfcb004
       INITIALIZE sr_s.l_sfcb003_desc TO NULL
       INITIALIZE sr_s.l_sfcb003_sfcb004 TO NULL
       #組合轉入作業/作業序
       SELECT oocql004 INTO sr_s.l_sfcb003_desc
         FROM oocql_t
        WHERE oocql001 = 221
          AND oocql002 = sr_s.l_sfcb003
          AND oocql003 = g_dlang
          AND oocqlent = sr_s.sffbent
       IF sr_s.l_count = 0 THEN
          LET sr_s.l_count = 1
          IF cl_null(sr_s.l_sfcb003) OR cl_null(sr_s.l_sfcb004) THEN
             LET sr_s.l_sfcb003_sfcb004 = sr_s.l_sfcb003_desc , "/" , sr_s.l_sfcb004 , '\n'
          ELSE
             LET sr_s.l_sfcb003_sfcb004 = sr_s.l_sfcb003_desc || "/" || sr_s.l_sfcb004 , '\n'
          END IF
       ELSE
          IF cl_null(sr_s.l_sfcb003) OR cl_null(sr_s.l_sfcb004) THEN
             LET sr_s.l_sfcb003_sfcb004 = sr_s.l_sfcb003_sfcb004 , sr_s.l_sfcb003_desc , "/" , sr_s.l_sfcb004 , '\n'
          ELSE
             LET sr_s.l_sfcb003_sfcb004 = sr_s.l_sfcb003_sfcb004 , sr_s.l_sfcb003_desc || "/" || sr_s.l_sfcb004 , '\n'
          END IF
       END IF
       END FOREACH             
           CALL s_asft335_drop_tmp_table()
     #類別(系統分類碼轉換)
     SELECT gzcbl004 INTO sr_s.l_sffb001_desc
       FROM gzcbl_t
      WHERE gzcbl001 = 4020 
        AND gzcbl002 = sr_s.sffb001 
        AND gzcbl003 = g_dlang
     #生產料號
     SELECT sfaa010 INTO sr_s.l_sfaa010
       FROM sfaa_t
      WHERE sfaaent  = sr_s.sffbent
        AND sfaasite = sr_s.sffbsite
        AND sfaadocno= sr_s.sffb005
     
     #品名、規格
     SELECT imaal003,imaal004 INTO sr_s.l_imaal003,sr_s.l_imaal004
       FROM imaal_t
      WHERE imaalent = sr_s.sffbent
        AND imaal002 = g_dlang
        AND imaal001 = sr_s.l_sfaa010
     #待處理數量
     CALL s_asft335_set_qty(sr_s.sffbdocno,sr_s.sffbseq,sr_s.sffb001,sr_s.sffb005,sr_s.sffb006,sr_s.sffb007,sr_s.sffb008)
     RETURNING sr_s.l_sfcbnum,sr_s.sffb016

     #重工轉出數量
     INITIALIZE sr_s.l_sfia007 TO NULL
     SELECT SUM(sfia007) INTO sr_s.l_sfia007
       FROM sfia_t
      WHERE sfiaent = sr_s.sffbent
        AND sfiadocno = sr_s.sffbdocno
        AND sfia003 = sr_s.sffb005
        AND sfia003 = sr_s.sffb006
        AND sr_s.sffb001 = '3'
     IF cl_null(sr_s.l_sfia007) THEN
        LET sr_s.l_sfia007 = 0
     END IF
     CALL asfr335_g01_initialize(sr_s.sffb009,sr_s.l_sffb009_ecaa002) RETURNING sr_s.l_sffb009_ecaa002
     CALL asfr335_g01_initialize(sr_s.sffb004,sr_s.l_sffb004_oogd002) RETURNING sr_s.l_sffb004_oogd002 
     CALL asfr335_g01_initialize(sr_s.sffb010,sr_s.l_sffb010_mrba004) RETURNING sr_s.l_sffb010_mrba004 
     CALL asfr335_g01_initialize(sr_s.sffb024,sr_s.l_sffb024_ooge002) RETURNING sr_s.l_sffb024_ooge002 
     CALL asfr335_g01_initialize(sr_s.sffb003,sr_s.l_sffb003_ooefl003) RETURNING sr_s.l_sffb003_ooefl003
     CALL asfr335_g01_initialize(sr_s.sffb002,sr_s.l_sffb002_ooag011) RETURNING sr_s.l_sffb002_ooag011
     #組合品名/規格
     IF cl_null(sr_s.l_imaal003) AND cl_null(sr_s.l_imaal004) THEN
        INITIALIZE sr_s.l_imaal003_imaal004 TO NULL
     ELSE
        IF cl_null(sr_s.l_imaal003) OR cl_null(sr_s.l_imaal004) THEN
           LET sr_s.l_imaal003_imaal004 = sr_s.l_imaal003 , "/" , sr_s.l_imaal004
        ELSE
           LET sr_s.l_imaal003_imaal004 = sr_s.l_imaal003 || "/" || sr_s.l_imaal004
        END IF
     END IF
     #組合作業編號/作業序
     
     IF cl_null(sr_s.sffb007) AND cl_null(sr_s.sffb008) THEN
        INITIALIZE sr_s.l_sffb007_sffb008 TO NULL
     ELSE
        IF cl_null(sr_s.sffb007) OR cl_null(sr_s.sffb008) THEN
           LET sr_s.l_sffb007_sffb008 = sr_s.oocql_t_oocql004 , "/" , sr_s.sffb008
        ELSE
           LET sr_s.l_sffb007_sffb008 = sr_s.oocql_t_oocql004|| "/" || sr_s.sffb008
        END IF
     END IF
       #Check報表顯示否
       LET sr_s.l_count = 0
       SELECT COUNT(1) INTO sr_s.l_count FROM sffc_t
         WHERE sffcdocno = sr_s.sffbdocno
           AND sffcent = sr_s.sffbent
       IF sr_s.l_count > 0 THEN
          LET sr_s.l_sffcseq_show = "Y"
       ELSE
          LET sr_s.l_sffcseq_show = "N"
       END IF
       CALL asfr335_g01_delfloat(sr_s.sffb014) RETURNING sr_s.l_sffb014
       CALL asfr335_g01_delfloat(sr_s.sffb015) RETURNING sr_s.l_sffb015
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].sffbseq = sr_s.sffbseq
       LET sr[l_cnt].sffbstus = sr_s.sffbstus
       LET sr[l_cnt].sffb013 = sr_s.sffb013
       LET sr[l_cnt].sffb016 = sr_s.sffb016
       LET sr[l_cnt].sffc002 = sr_s.sffc002
       LET sr[l_cnt].sffb008 = sr_s.sffb008
       LET sr[l_cnt].sffbdocdt = sr_s.sffbdocdt
       LET sr[l_cnt].sffb010 = sr_s.sffb010
       LET sr[l_cnt].sffb014 = sr_s.sffb014
       LET sr[l_cnt].sffb015 = sr_s.sffb015
       LET sr[l_cnt].sffb017 = sr_s.sffb017
       LET sr[l_cnt].sffb018 = sr_s.sffb018
       LET sr[l_cnt].sffb001 = sr_s.sffb001
       LET sr[l_cnt].sffb005 = sr_s.sffb005
       LET sr[l_cnt].sffb009 = sr_s.sffb009
       LET sr[l_cnt].sffc003 = sr_s.sffc003
       LET sr[l_cnt].sffb002 = sr_s.sffb002
       LET sr[l_cnt].sffb003 = sr_s.sffb003
       LET sr[l_cnt].sffbsite = sr_s.sffbsite
       LET sr[l_cnt].sffc004 = sr_s.sffc004
       LET sr[l_cnt].sffc006 = sr_s.sffc006
       LET sr[l_cnt].sffbdocno = sr_s.sffbdocno
       LET sr[l_cnt].sffb004 = sr_s.sffb004
       LET sr[l_cnt].sffb019 = sr_s.sffb019
       LET sr[l_cnt].sffb024 = sr_s.sffb024
       LET sr[l_cnt].sffc001 = sr_s.sffc001
       LET sr[l_cnt].sffb006 = sr_s.sffb006
       LET sr[l_cnt].sffb007 = sr_s.sffb007
       LET sr[l_cnt].sffb012 = sr_s.sffb012
       LET sr[l_cnt].sffb011 = sr_s.sffb011
       LET sr[l_cnt].sffb020 = sr_s.sffb020
       LET sr[l_cnt].sffc005 = sr_s.sffc005
       LET sr[l_cnt].ooag_t_ooag011 = sr_s.ooag_t_ooag011
       LET sr[l_cnt].ooefl_t_ooefl003 = sr_s.ooefl_t_ooefl003
       LET sr[l_cnt].oogd_t_oogd002 = sr_s.oogd_t_oogd002
       LET sr[l_cnt].x_t1_oocql004 = sr_s.x_t1_oocql004
       LET sr[l_cnt].ecaa_t_ecaa002 = sr_s.ecaa_t_ecaa002
       LET sr[l_cnt].mrba_t_mrba004 = sr_s.mrba_t_mrba004
       LET sr[l_cnt].ooge_t_ooge002 = sr_s.ooge_t_ooge002
       LET sr[l_cnt].oocql_t_oocql004 = sr_s.oocql_t_oocql004
       LET sr[l_cnt].sffbent = sr_s.sffbent
       LET sr[l_cnt].sffcdocno = sr_s.sffcdocno
       LET sr[l_cnt].sffcent = sr_s.sffcent
       LET sr[l_cnt].sffcseq = sr_s.sffcseq
       LET sr[l_cnt].sffcsite = sr_s.sffcsite
       LET sr[l_cnt].l_sffbdocno_oobal004 = sr_s.l_sffbdocno_oobal004
       LET sr[l_cnt].l_imaal003 = sr_s.l_imaal003
       LET sr[l_cnt].l_imaal004 = sr_s.l_imaal004
       LET sr[l_cnt].l_sfaa010 = sr_s.l_sfaa010
       LET sr[l_cnt].l_sffb001_desc = sr_s.l_sffb001_desc
       LET sr[l_cnt].l_sfia007 = sr_s.l_sfia007
       LET sr[l_cnt].l_sfcbnum = sr_s.l_sfcbnum
       LET sr[l_cnt].l_sfcb003 = sr_s.l_sfcb003
       LET sr[l_cnt].l_sfcb004 = sr_s.l_sfcb004
       LET sr[l_cnt].l_count = sr_s.l_count
       LET sr[l_cnt].l_sffcseq_show = sr_s.l_sffcseq_show
       LET sr[l_cnt].l_sffb014 = sr_s.l_sffb014
       LET sr[l_cnt].l_sffb015 = sr_s.l_sffb015
       LET sr[l_cnt].l_sffb002_ooag011 = sr_s.l_sffb002_ooag011
       LET sr[l_cnt].l_sfcb003_desc = sr_s.l_sfcb003_desc
       LET sr[l_cnt].l_sfcb003_sfcb004 = sr_s.l_sfcb003_sfcb004
       LET sr[l_cnt].l_sffb007_sffb008 = sr_s.l_sffb007_sffb008
       LET sr[l_cnt].l_imaal003_imaal004 = sr_s.l_imaal003_imaal004
       LET sr[l_cnt].l_sffb009_ecaa002 = sr_s.l_sffb009_ecaa002
       LET sr[l_cnt].l_sffb004_oogd002 = sr_s.l_sffb004_oogd002
       LET sr[l_cnt].l_sffb010_mrba004 = sr_s.l_sffb010_mrba004
       LET sr[l_cnt].l_sffb024_ooge002 = sr_s.l_sffb024_ooge002
       LET sr[l_cnt].l_sffb003_ooefl003 = sr_s.l_sffb003_ooefl003
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="asfr335_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION asfr335_g01_rep_data()
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
          START REPORT asfr335_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT asfr335_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT asfr335_g01_rep
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
 
{<section id="asfr335_g01.rep" readonly="Y" >}
PRIVATE REPORT asfr335_g01_rep(sr1)
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
DEFINE sr3       sr3_r #轉入作業/作業序
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER EXTERNAL BY sr1.sffbdocno,sr1.sffcseq
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
        BEFORE GROUP OF sr1.sffbdocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
 
            #end add-point:rep.header 
            LET g_rep_docno = sr1.sffbdocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'sffbent=' ,sr1.sffbent,'{+}sffbdocno=' ,sr1.sffbdocno,'{+}sffbseq=' ,sr1.sffbseq         
            CALL cl_gr_init_apr(sr1.sffbdocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.sffbdocno.before name="rep.b_group.sffbdocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.sffbent CLIPPED ,"'", " AND  ooff003 = '", sr1.sffbdocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE asfr335_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE asfr335_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT asfr335_g01_subrep01
           DECLARE asfr335_g01_repcur01 CURSOR FROM g_sql
           FOREACH asfr335_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "asfr335_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT asfr335_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT asfr335_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.sffbdocno.after name="rep.b_group.sffbdocno.after"
           START REPORT asfr335_g01_subrep05
              LET g_sql = "SELECT sffddocno,sffd001,sffd002,sffd003",
                          "  FROM sffd_t ",
                          " WHERE sffddocno = '",sr1.sffbdocno CLIPPED,"'",
                          "   AND sffdent   = '",sr1.sffbent   CLIPPED,"'",                             
                          "   ORDER BY sffdseq "
              DECLARE asfr335_g01_repcur05 CURSOR FROM g_sql
              FOREACH asfr335_g01_repcur05 INTO sr3.*
                  #異常項目(系統分類碼轉換)
                 SELECT oocql004 INTO sr3.l_sffd001_desc
                   FROM oocql_t
                  WHERE oocql001 = 1053 
                    AND oocql002 = sr3.sffd001 
                    AND oocql003 = g_dlang
                    AND oocqlent = g_enterprise  #160902-00048#4
               OUTPUT TO REPORT asfr335_g01_subrep05(sr3.*)
              END FOREACH
           FINISH REPORT asfr335_g01_subrep05
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.sffcseq
 
           #add-point:rep.b_group.sffcseq.before name="rep.b_group.sffcseq.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.sffcseq.after name="rep.b_group.sffcseq.after"
           
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
                sr1.sffbent CLIPPED ,"'", " AND  ooff003 = '", sr1.sffbdocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.sffcseq CLIPPED ,""
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE asfr335_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE asfr335_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT asfr335_g01_subrep02
           DECLARE asfr335_g01_repcur02 CURSOR FROM g_sql
           FOREACH asfr335_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "asfr335_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT asfr335_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT asfr335_g01_subrep02
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
                sr1.sffbent CLIPPED ,"'", " AND  ooff003 = '", sr1.sffbdocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.sffcseq CLIPPED ,""
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE asfr335_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE asfr335_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT asfr335_g01_subrep03
           DECLARE asfr335_g01_repcur03 CURSOR FROM g_sql
           FOREACH asfr335_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "asfr335_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT asfr335_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT asfr335_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.sffbdocno
 
           #add-point:rep.a_group.sffbdocno.before name="rep.a_group.sffbdocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.sffbent CLIPPED ,"'", " AND  ooff003 = '", sr1.sffbdocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE asfr335_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE asfr335_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT asfr335_g01_subrep04
           DECLARE asfr335_g01_repcur04 CURSOR FROM g_sql
           FOREACH asfr335_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "asfr335_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT asfr335_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT asfr335_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.sffbdocno.after name="rep.a_group.sffbdocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.sffcseq
 
           #add-point:rep.a_group.sffcseq.before name="rep.a_group.sffcseq.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.sffcseq.after name="rep.a_group.sffcseq.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="asfr335_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT asfr335_g01_subrep01(sr2)
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
PRIVATE REPORT asfr335_g01_subrep02(sr2)
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
PRIVATE REPORT asfr335_g01_subrep03(sr2)
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
PRIVATE REPORT asfr335_g01_subrep04(sr2)
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
 
{<section id="asfr335_g01.other_function" readonly="Y" >}
################################################################################
# Descriptions...: 去除小數點後多餘的0
# Memo...........:
# Usage..........: CALL asfr335_g01_delfloat(传入参数)
#                  RETURNING 回传参数
# Input parameter: INT
# Return code....: INT
# Date & Author..: 2014/07/08 by 05384
# Modify.........:
################################################################################
PRIVATE FUNCTION asfr335_g01_delfloat(p_num)
DEFINE p_num       LIKE bmfb_t.bmfb011
DEFINE p_str       STRING
DEFINE l_float     STRING
DEFINE l_int       STRING
DEFINE l_count     INTEGER
DEFINE l_length    INTEGER
DEFINE l_float_length    INTEGER
DEFINE l_i         INTEGER
#組合bmfb011/bmfb012
   LET p_str = p_num
   LET l_count = p_str.getIndexOf(".",1)
   LET l_length = p_str.getLength()
   LET l_int = p_str.subString(1,l_count-1)
   LET l_float = p_str.subString(l_count+1,l_length)
   LET l_float_length = l_float.getLength()
   FOR l_i = 1 TO l_float_length
      IF l_float.subString(l_float_length+1-l_i,l_float_length+1-l_i) <> '0' THEN
         EXIT FOR
      END IF
   END FOR
   IF l_i < l_float_length+1 THEN
      LET l_float = l_float.subString(1,l_float_length+1-l_i)
      LET p_str = l_int || "." || l_float
   ELSE
      LET p_str = l_int
   END IF
   RETURN p_str
END FUNCTION

PRIVATE FUNCTION asfr335_g01_initialize(p_arg,p_exp)
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
 
{<section id="asfr335_g01.other_report" readonly="Y" >}

PRIVATE REPORT asfr335_g01_subrep05(sr3)
     DEFINE sr3 sr3_r     
     ORDER EXTERNAL BY sr3.sffddocno
     FORMAT
        ON EVERY ROW       
        PRINTX g_grNumFmt.* 
        PRINTX sr3.* 
END REPORT

 
{</section>}
 