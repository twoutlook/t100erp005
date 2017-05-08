#該程式未解開Section, 採用最新樣板產出!
{<section id="apmr440_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:6(2016-11-02 21:05:22), PR版次:0006(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000258
#+ Filename...: apmr440_g01
#+ Description: ...
#+ Creator....: 05016(2014-05-05 13:54:03)
#+ Modifier...: 08734 -SD/PR- 00000
 
{</section>}
 
{<section id="apmr440_g01.global" readonly="Y" >}
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
   pmdi001 LIKE pmdi_t.pmdi001, 
   pmdi002 LIKE pmdi_t.pmdi002, 
   pmdi003 LIKE pmdi_t.pmdi003, 
   pmdi004 LIKE pmdi_t.pmdi004, 
   pmdi005 LIKE pmdi_t.pmdi005, 
   pmdi006 LIKE pmdi_t.pmdi006, 
   pmdi007 LIKE pmdi_t.pmdi007, 
   pmdi008 LIKE pmdi_t.pmdi008, 
   pmdi009 LIKE pmdi_t.pmdi009, 
   pmdi010 LIKE pmdi_t.pmdi010, 
   pmdi011 LIKE pmdi_t.pmdi011, 
   pmdi012 LIKE pmdi_t.pmdi012, 
   pmdi013 LIKE pmdi_t.pmdi013, 
   pmdi014 LIKE pmdi_t.pmdi014, 
   pmdi015 LIKE pmdi_t.pmdi015, 
   pmdi016 LIKE pmdi_t.pmdi016, 
   pmdi017 LIKE pmdi_t.pmdi017, 
   pmdi018 LIKE pmdi_t.pmdi018, 
   pmdi030 LIKE pmdi_t.pmdi030, 
   pmdi031 LIKE pmdi_t.pmdi031, 
   pmdi032 LIKE pmdi_t.pmdi032, 
   pmdidocdt LIKE pmdi_t.pmdidocdt, 
   pmdidocno LIKE pmdi_t.pmdidocno, 
   pmdient LIKE pmdi_t.pmdient, 
   pmdisite LIKE pmdi_t.pmdisite, 
   pmdistus LIKE pmdi_t.pmdistus, 
   pmdj001 LIKE pmdj_t.pmdj001, 
   pmdj002 LIKE pmdj_t.pmdj002, 
   pmdj003 LIKE pmdj_t.pmdj003, 
   pmdj004 LIKE pmdj_t.pmdj004, 
   pmdj005 LIKE pmdj_t.pmdj005, 
   pmdj006 LIKE pmdj_t.pmdj006, 
   pmdj007 LIKE pmdj_t.pmdj007, 
   pmdj008 LIKE pmdj_t.pmdj008, 
   pmdj009 LIKE pmdj_t.pmdj009, 
   pmdj010 LIKE pmdj_t.pmdj010, 
   pmdj011 LIKE pmdj_t.pmdj011, 
   pmdj012 LIKE pmdj_t.pmdj012, 
   pmdj013 LIKE pmdj_t.pmdj013, 
   pmdj014 LIKE pmdj_t.pmdj014, 
   pmdj015 LIKE pmdj_t.pmdj015, 
   pmdj016 LIKE pmdj_t.pmdj016, 
   pmdj030 LIKE pmdj_t.pmdj030, 
   pmdjseq LIKE pmdj_t.pmdjseq, 
   pmdjsite LIKE pmdj_t.pmdjsite, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   pmaal_t_pmaal004 LIKE pmaal_t.pmaal004, 
   ooail_t_ooail003 LIKE ooail_t.ooail003, 
   ooibl_t_ooibl004 LIKE ooibl_t.ooibl004, 
   oocql_t_oocql004 LIKE oocql_t.oocql004, 
   x_t1_oocql004 LIKE oocql_t.oocql004, 
   x_t2_oocql004 LIKE oocql_t.oocql004, 
   x_t4_oocql004 LIKE oocql_t.oocql004, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   x_t3_imaal003 LIKE imaal_t.imaal003, 
   x_oocal_t_oocal003 LIKE oocal_t.oocal003, 
   x_oobal_t_oobal004 LIKE oobal_t.oobal004, 
   x_imaal_t_imaal004 LIKE imaal_t.imaal004, 
   l_pmdi004_pmaal004 LIKE type_t.chr100, 
   l_pmdi002_ooag011 LIKE type_t.chr100, 
   l_pmdi006_desc LIKE type_t.chr100, 
   l_pmdi017_desc LIKE type_t.chr100, 
   l_pmdi018_desc LIKE type_t.chr100, 
   l_pmdi003_ooefl003 LIKE type_t.chr100, 
   x_t3_imaal004 LIKE imaal_t.imaal004
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
TYPE sr3_r RECORD  #子報表01
   pmdk001 LIKE pmdk_t.pmdk001,  #起始數量
   pmdk002 LIKE pmdk_t.pmdk002,  #截止數量
   pmdk003 LIKE pmdk_t.pmdk003,  #單價
   pmdk004 LIKE pmdk_t.pmdk004,  #折扣率
   pmdkdocno LIKE pmdk_t.pmdkdocno
END RECORD

#end add-point
 
{</section>}
 
{<section id="apmr440_g01.main" readonly="Y" >}
PUBLIC FUNCTION apmr440_g01(p_arg1)
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
   
   LET g_rep_code = "apmr440_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL apmr440_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL apmr440_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL apmr440_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="apmr440_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apmr440_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   
   #end add-point
   LET g_select = " SELECT pmdi001,pmdi002,pmdi003,pmdi004,pmdi005,pmdi006,pmdi007,pmdi008,pmdi009,pmdi010, 
       pmdi011,pmdi012,pmdi013,pmdi014,pmdi015,pmdi016,pmdi017,pmdi018,pmdi030,pmdi031,pmdi032,pmdidocdt, 
       pmdidocno,pmdient,pmdisite,pmdistus,pmdj001,pmdj002,pmdj003,pmdj004,pmdj005,pmdj006,pmdj007,pmdj008, 
       pmdj009,pmdj010,pmdj011,pmdj012,pmdj013,pmdj014,pmdj015,pmdj016,pmdj030,pmdjseq,pmdjsite,( SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = pmdi_t.pmdi002 AND ooag_t.ooagent = pmdi_t.pmdient), 
       ( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = pmdi_t.pmdi003 AND ooefl_t.ooeflent = pmdi_t.pmdient AND ooefl_t.ooefl002 = '" , 
       g_dlang,"'" ,"),( SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = pmdi_t.pmdi004 AND pmaal_t.pmaalent = pmdi_t.pmdient AND pmaal_t.pmaal002 = '" , 
       g_dlang,"'" ,"),( SELECT ooail003 FROM ooail_t WHERE ooail_t.ooail001 = pmdi_t.pmdi005 AND ooail_t.ooailent = pmdi_t.pmdient AND ooail_t.ooail002 = '" , 
       g_dlang,"'" ,"),( SELECT ooibl004 FROM ooibl_t WHERE ooibl_t.ooibl002 = pmdi_t.pmdi009 AND ooibl_t.ooiblent = pmdi_t.pmdient AND ooibl_t.ooibl003 = '" , 
       g_dlang,"'" ,"),( SELECT oocql004 FROM oocql_t WHERE oocql_t.oocql001 = '238' AND oocql_t.oocql002 = pmdi_t.pmdi011 AND oocql_t.oocqlent = pmdi_t.pmdient AND oocql_t.oocql003 = '" , 
       g_dlang,"'" ,"),x.t1_oocql004,x.t2_oocql004,x.t4_oocql004,x.imaal_t_imaal003,x.t3_imaal003,x.oocal_t_oocal003, 
       x.oobal_t_oobal004,x.imaal_t_imaal004,trim(pmdi004)||'.'||trim((SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = pmdi_t.pmdi004 AND pmaal_t.pmaalent = pmdi_t.pmdient AND pmaal_t.pmaal002 = '" , 
       g_dlang,"'" ,")),trim(pmdi002)||'.'||trim((SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = pmdi_t.pmdi002 AND ooag_t.ooagent = pmdi_t.pmdient)), 
       '','','',trim(pmdi003)||'.'||trim((SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = pmdi_t.pmdi003 AND ooefl_t.ooeflent = pmdi_t.pmdient AND ooefl_t.ooefl002 = '" , 
       g_dlang,"'" ,")),x.t3_imaal004"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   
   #end add-point
    LET g_from = " FROM pmdi_t LEFT OUTER JOIN ( SELECT pmdj_t.*,( SELECT oocql004 FROM oocql_t WHERE oocql_t.oocql001 = '221' AND oocql_t.oocql002 = pmdj_t.pmdj006 AND oocql_t.oocqlent = pmdj_t.pmdjent AND oocql_t.oocql003 = '" , 
        g_dlang,"'" ,") t1_oocql004,( SELECT oocql004 FROM oocql_t WHERE oocql_t.oocql001 = '265' AND oocql_t.oocql002 = pmdj_t.pmdj015 AND oocql_t.oocqlent = pmdj_t.pmdjent AND oocql_t.oocql003 = '" , 
        g_dlang,"'" ,") t2_oocql004,( SELECT oocql004 FROM oocql_t WHERE oocql_t.oocql001 = '263' AND oocql_t.oocql002 = pmdj_t.pmdj014 AND oocql_t.oocqlent = pmdj_t.pmdjent AND oocql_t.oocql003 = '" , 
        g_dlang,"'" ,") t4_oocql004,( SELECT imaal003 FROM imaal_t WHERE imaal_t.imaal001 = pmdj_t.pmdj004 AND imaal_t.imaalent = pmdj_t.pmdjent AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,") imaal_t_imaal003,( SELECT imaal003 FROM imaal_t WHERE imaal_t.imaal001 = pmdj_t.pmdj002 AND imaal_t.imaalent = pmdj_t.pmdjent AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,") t3_imaal003,( SELECT oocal003 FROM oocal_t WHERE oocal_t.oocal001 = pmdj_t.pmdj008 AND oocal_t.oocalent = pmdj_t.pmdjent AND oocal_t.oocal002 = '" , 
        g_dlang,"'" ,") oocal_t_oocal003,( SELECT oobal004 FROM oobal_t WHERE oobal_t.oobal002 = pmdj_t.pmdj016 AND oobal_t.oobalent = pmdj_t.pmdjent AND oobal_t.oobal003 = '" , 
        g_dlang,"'" ,") oobal_t_oobal004,( SELECT imaal004 FROM imaal_t WHERE imaal_t.imaal001 = pmdj_t.pmdj004 AND imaal_t.imaalent = pmdj_t.pmdjent AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,") imaal_t_imaal004,( SELECT imaal004 FROM imaal_t WHERE imaal_t.imaal001 = pmdj_t.pmdj002 AND imaal_t.imaalent = pmdj_t.pmdjent AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,") t3_imaal004 FROM pmdj_t ) x  ON pmdi_t.pmdient = x.pmdjent AND pmdi_t.pmdidocno  
        = x.pmdjdocno AND pmdi_t.pmdisite = x.pmdjsite"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
 
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
    LET g_order = " ORDER BY pmdidocno,pmdjseq"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("pmdi_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE apmr440_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE apmr440_g01_curs CURSOR FOR apmr440_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="apmr440_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION apmr440_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   pmdi001 LIKE pmdi_t.pmdi001, 
   pmdi002 LIKE pmdi_t.pmdi002, 
   pmdi003 LIKE pmdi_t.pmdi003, 
   pmdi004 LIKE pmdi_t.pmdi004, 
   pmdi005 LIKE pmdi_t.pmdi005, 
   pmdi006 LIKE pmdi_t.pmdi006, 
   pmdi007 LIKE pmdi_t.pmdi007, 
   pmdi008 LIKE pmdi_t.pmdi008, 
   pmdi009 LIKE pmdi_t.pmdi009, 
   pmdi010 LIKE pmdi_t.pmdi010, 
   pmdi011 LIKE pmdi_t.pmdi011, 
   pmdi012 LIKE pmdi_t.pmdi012, 
   pmdi013 LIKE pmdi_t.pmdi013, 
   pmdi014 LIKE pmdi_t.pmdi014, 
   pmdi015 LIKE pmdi_t.pmdi015, 
   pmdi016 LIKE pmdi_t.pmdi016, 
   pmdi017 LIKE pmdi_t.pmdi017, 
   pmdi018 LIKE pmdi_t.pmdi018, 
   pmdi030 LIKE pmdi_t.pmdi030, 
   pmdi031 LIKE pmdi_t.pmdi031, 
   pmdi032 LIKE pmdi_t.pmdi032, 
   pmdidocdt LIKE pmdi_t.pmdidocdt, 
   pmdidocno LIKE pmdi_t.pmdidocno, 
   pmdient LIKE pmdi_t.pmdient, 
   pmdisite LIKE pmdi_t.pmdisite, 
   pmdistus LIKE pmdi_t.pmdistus, 
   pmdj001 LIKE pmdj_t.pmdj001, 
   pmdj002 LIKE pmdj_t.pmdj002, 
   pmdj003 LIKE pmdj_t.pmdj003, 
   pmdj004 LIKE pmdj_t.pmdj004, 
   pmdj005 LIKE pmdj_t.pmdj005, 
   pmdj006 LIKE pmdj_t.pmdj006, 
   pmdj007 LIKE pmdj_t.pmdj007, 
   pmdj008 LIKE pmdj_t.pmdj008, 
   pmdj009 LIKE pmdj_t.pmdj009, 
   pmdj010 LIKE pmdj_t.pmdj010, 
   pmdj011 LIKE pmdj_t.pmdj011, 
   pmdj012 LIKE pmdj_t.pmdj012, 
   pmdj013 LIKE pmdj_t.pmdj013, 
   pmdj014 LIKE pmdj_t.pmdj014, 
   pmdj015 LIKE pmdj_t.pmdj015, 
   pmdj016 LIKE pmdj_t.pmdj016, 
   pmdj030 LIKE pmdj_t.pmdj030, 
   pmdjseq LIKE pmdj_t.pmdjseq, 
   pmdjsite LIKE pmdj_t.pmdjsite, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   pmaal_t_pmaal004 LIKE pmaal_t.pmaal004, 
   ooail_t_ooail003 LIKE ooail_t.ooail003, 
   ooibl_t_ooibl004 LIKE ooibl_t.ooibl004, 
   oocql_t_oocql004 LIKE oocql_t.oocql004, 
   x_t1_oocql004 LIKE oocql_t.oocql004, 
   x_t2_oocql004 LIKE oocql_t.oocql004, 
   x_t4_oocql004 LIKE oocql_t.oocql004, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   x_t3_imaal003 LIKE imaal_t.imaal003, 
   x_oocal_t_oocal003 LIKE oocal_t.oocal003, 
   x_oobal_t_oobal004 LIKE oobal_t.oobal004, 
   x_imaal_t_imaal004 LIKE imaal_t.imaal004, 
   l_pmdi004_pmaal004 LIKE type_t.chr100, 
   l_pmdi002_ooag011 LIKE type_t.chr100, 
   l_pmdi006_desc LIKE type_t.chr100, 
   l_pmdi017_desc LIKE type_t.chr100, 
   l_pmdi018_desc LIKE type_t.chr100, 
   l_pmdi003_ooefl003 LIKE type_t.chr100, 
   x_t3_imaal004 LIKE imaal_t.imaal004
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_ooef019  LIKE ooef_t.ooef019  #稅區
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH apmr440_g01_curs INTO sr_s.*
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
       
        #核價對像管制
       INITIALIZE sr_s.l_pmdi017_desc TO NULL
       SELECT gzcbl004 INTO sr_s.l_pmdi017_desc
         FROM gzcbl_t
        WHERE gzcbl001 = '2041'
          AND gzcbl002 = sr_s.pmdi017
          AND gzcbl003 = g_dlang
          
       #核價使用管制 
       INITIALIZE sr_s.l_pmdi018_desc TO NULL
       SELECT gzcbl004 INTO sr_s.l_pmdi018_desc
         FROM gzcbl_t
        WHERE gzcbl001 = '2042'
          AND gzcbl002 = sr_s.pmdi018
          AND gzcbl003 = g_dlang
                   
       #稅別說明
       LET l_ooef019 = ''
       SELECT ooef019 INTO l_ooef019 FROM ooef_t
        WHERE ooefent = sr_s.pmdient
          AND ooef001 = sr_s.pmdisite

       IF NOT cl_null(l_ooef019) THEN
          LET sr_s.l_pmdi006_desc = ''
          SELECT oodbl004 INTO sr_s.l_pmdi006_desc
            FROM oodbl_t
           WHERE oodblent = sr_s.pmdient
             AND oodbl001 = l_ooef019
             AND oodbl002 = sr_s.pmdi006
             AND oodbl003 = g_dlang
       END IF
       
       
                         
    
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].pmdi001 = sr_s.pmdi001
       LET sr[l_cnt].pmdi002 = sr_s.pmdi002
       LET sr[l_cnt].pmdi003 = sr_s.pmdi003
       LET sr[l_cnt].pmdi004 = sr_s.pmdi004
       LET sr[l_cnt].pmdi005 = sr_s.pmdi005
       LET sr[l_cnt].pmdi006 = sr_s.pmdi006
       LET sr[l_cnt].pmdi007 = sr_s.pmdi007
       LET sr[l_cnt].pmdi008 = sr_s.pmdi008
       LET sr[l_cnt].pmdi009 = sr_s.pmdi009
       LET sr[l_cnt].pmdi010 = sr_s.pmdi010
       LET sr[l_cnt].pmdi011 = sr_s.pmdi011
       LET sr[l_cnt].pmdi012 = sr_s.pmdi012
       LET sr[l_cnt].pmdi013 = sr_s.pmdi013
       LET sr[l_cnt].pmdi014 = sr_s.pmdi014
       LET sr[l_cnt].pmdi015 = sr_s.pmdi015
       LET sr[l_cnt].pmdi016 = sr_s.pmdi016
       LET sr[l_cnt].pmdi017 = sr_s.pmdi017
       LET sr[l_cnt].pmdi018 = sr_s.pmdi018
       LET sr[l_cnt].pmdi030 = sr_s.pmdi030
       LET sr[l_cnt].pmdi031 = sr_s.pmdi031
       LET sr[l_cnt].pmdi032 = sr_s.pmdi032
       LET sr[l_cnt].pmdidocdt = sr_s.pmdidocdt
       LET sr[l_cnt].pmdidocno = sr_s.pmdidocno
       LET sr[l_cnt].pmdient = sr_s.pmdient
       LET sr[l_cnt].pmdisite = sr_s.pmdisite
       LET sr[l_cnt].pmdistus = sr_s.pmdistus
       LET sr[l_cnt].pmdj001 = sr_s.pmdj001
       LET sr[l_cnt].pmdj002 = sr_s.pmdj002
       LET sr[l_cnt].pmdj003 = sr_s.pmdj003
       LET sr[l_cnt].pmdj004 = sr_s.pmdj004
       LET sr[l_cnt].pmdj005 = sr_s.pmdj005
       LET sr[l_cnt].pmdj006 = sr_s.pmdj006
       LET sr[l_cnt].pmdj007 = sr_s.pmdj007
       LET sr[l_cnt].pmdj008 = sr_s.pmdj008
       LET sr[l_cnt].pmdj009 = sr_s.pmdj009
       LET sr[l_cnt].pmdj010 = sr_s.pmdj010
       LET sr[l_cnt].pmdj011 = sr_s.pmdj011
       LET sr[l_cnt].pmdj012 = sr_s.pmdj012
       LET sr[l_cnt].pmdj013 = sr_s.pmdj013
       LET sr[l_cnt].pmdj014 = sr_s.pmdj014
       LET sr[l_cnt].pmdj015 = sr_s.pmdj015
       LET sr[l_cnt].pmdj016 = sr_s.pmdj016
       LET sr[l_cnt].pmdj030 = sr_s.pmdj030
       LET sr[l_cnt].pmdjseq = sr_s.pmdjseq
       LET sr[l_cnt].pmdjsite = sr_s.pmdjsite
       LET sr[l_cnt].ooag_t_ooag011 = sr_s.ooag_t_ooag011
       LET sr[l_cnt].ooefl_t_ooefl003 = sr_s.ooefl_t_ooefl003
       LET sr[l_cnt].pmaal_t_pmaal004 = sr_s.pmaal_t_pmaal004
       LET sr[l_cnt].ooail_t_ooail003 = sr_s.ooail_t_ooail003
       LET sr[l_cnt].ooibl_t_ooibl004 = sr_s.ooibl_t_ooibl004
       LET sr[l_cnt].oocql_t_oocql004 = sr_s.oocql_t_oocql004
       LET sr[l_cnt].x_t1_oocql004 = sr_s.x_t1_oocql004
       LET sr[l_cnt].x_t2_oocql004 = sr_s.x_t2_oocql004
       LET sr[l_cnt].x_t4_oocql004 = sr_s.x_t4_oocql004
       LET sr[l_cnt].x_imaal_t_imaal003 = sr_s.x_imaal_t_imaal003
       LET sr[l_cnt].x_t3_imaal003 = sr_s.x_t3_imaal003
       LET sr[l_cnt].x_oocal_t_oocal003 = sr_s.x_oocal_t_oocal003
       LET sr[l_cnt].x_oobal_t_oobal004 = sr_s.x_oobal_t_oobal004
       LET sr[l_cnt].x_imaal_t_imaal004 = sr_s.x_imaal_t_imaal004
       LET sr[l_cnt].l_pmdi004_pmaal004 = sr_s.l_pmdi004_pmaal004
       LET sr[l_cnt].l_pmdi002_ooag011 = sr_s.l_pmdi002_ooag011
       LET sr[l_cnt].l_pmdi006_desc = sr_s.l_pmdi006_desc
       LET sr[l_cnt].l_pmdi017_desc = sr_s.l_pmdi017_desc
       LET sr[l_cnt].l_pmdi018_desc = sr_s.l_pmdi018_desc
       LET sr[l_cnt].l_pmdi003_ooefl003 = sr_s.l_pmdi003_ooefl003
       LET sr[l_cnt].x_t3_imaal004 = sr_s.x_t3_imaal004
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
                
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apmr440_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION apmr440_g01_rep_data()
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
          START REPORT apmr440_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT apmr440_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT apmr440_g01_rep
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
 
{<section id="apmr440_g01.rep" readonly="Y" >}
PRIVATE REPORT apmr440_g01_rep(sr1)
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
DEFINE l_pmdj013_show  LIKE type_t.chr1    #單身%
DEFINE l_pmdj005_show  LIKE type_t.chr1    #供應商
DEFINE l_pmdj003_show  LIKE type_t.chr1    #產品特徵
DEFINE l_pmdi030_show  LIKE type_t.chr1    #pmdi030 備註 單頭
DEFINE l_pmdj030_show  LIKE type_t.chr1    #pmdj030 備註 單身

#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER EXTERNAL BY sr1.pmdidocno,sr1.pmdjseq
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
        BEFORE GROUP OF sr1.pmdidocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.pmdidocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'pmdient=' ,sr1.pmdient,'{+}pmdidocno=' ,sr1.pmdidocno         
            CALL cl_gr_init_apr(sr1.pmdidocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.pmdidocno.before name="rep.b_group.pmdidocno.before"
           #pmdi030 備註單頭隱藏
           INITIALIZE l_pmdi030_show TO NULL
           IF cl_null(sr1.pmdi030) THEN
              LET l_pmdi030_show = "N"
           ELSE
              LET l_pmdi030_show = "Y"
           END IF
           
           PRINTX l_pmdi030_show
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.pmdient CLIPPED ,"'", " AND  ooff003 = '", sr1.pmdidocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE apmr440_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE apmr440_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT apmr440_g01_subrep01
           DECLARE apmr440_g01_repcur01 CURSOR FROM g_sql
           FOREACH apmr440_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "apmr440_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT apmr440_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT apmr440_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.pmdidocno.after name="rep.b_group.pmdidocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.pmdjseq
 
           #add-point:rep.b_group.pmdjseq.before name="rep.b_group.pmdjseq.before"
   
           #end add-point:
 
 
           #add-point:rep.b_group.pmdjseq.after name="rep.b_group.pmdjseq.after"
           
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
                sr1.pmdient CLIPPED ,"'", " AND  ooff003 = '", sr1.pmdidocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.pmdjseq CLIPPED ,""
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE apmr440_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE apmr440_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT apmr440_g01_subrep02
           DECLARE apmr440_g01_repcur02 CURSOR FROM g_sql
           FOREACH apmr440_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "apmr440_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
            
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT apmr440_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT apmr440_g01_subrep02
           #add-point:rep.sub02.after name="rep.sub02.after"
           
           #end add-point:rep.sub02.after
 
 
 
          #add-point:rep.everyrow.beforerow name="rep.everyrow.beforerow"
            #供應商隱藏
            INITIALIZE l_pmdj005_show TO NULL
            IF cl_null(sr1.pmdj005) THEN
               LET l_pmdj005_show = "N"
            ELSE
               LET l_pmdj005_show = "Y"            
            END IF  
            
             #料號摘要隱藏
            INITIALIZE l_pmdj003_show TO NULL
            IF cl_null(sr1.pmdj003) THEN
               LET l_pmdj003_show = "N"
            ELSE
               LET l_pmdj003_show = "Y"
            END IF
            
               #pmdi030 備註單身隱藏                       
            INITIALIZE l_pmdj030_show TO NULL
            IF cl_null(sr1.pmdj030) THEN
               LET l_pmdj030_show = "N"
            ELSE
               LET l_pmdj030_show = "Y"
            END IF
            
             #單身%隱藏
            INITIALIZE l_pmdj013_show TO NULL
            IF cl_null(sr1.pmdj013) THEN
               LET l_pmdj013_show  = "N"
            ELSE
               LET l_pmdj013_show  = "Y"
            END IF
         
            PRINTX l_pmdj013_show        
            PRINTX l_pmdj005_show
            PRINTX l_pmdj003_show         
            PRINTX l_pmdj030_show
         
          #end add-point:rep.everyrow.beforerow
            
          PRINTX sr1.*
 
          #add-point:rep.everyrow.afterrow name="rep.everyrow.afterrow"
            START REPORT apmr440_g01_subrep05
               IF NOT cl_null(sr1.pmdjseq) THEN
                  LET g_sql = "SELECT pmdk001,pmdk002,pmdk003,pmdk004,pmdkdocno ",
                              "  FROM pmdk_t ",
                              " WHERE pmdkdocno = '",sr1.pmdidocno CLIPPED,"'",
                              "   AND pmdkent   = '",sr1.pmdient   CLIPPED,"'",
                              "   AND pmdkseq   = '",sr1.pmdjseq   CLIPPED,"' ",                           
                              "   ORDER BY pmdk001 "
                                  
                  DECLARE apmr440_g01_repcur05 CURSOR FROM g_sql
                  FOREACH apmr440_g01_repcur05 INTO sr3.*                               
                     OUTPUT TO REPORT apmr440_g01_subrep05(sr3.*)
                  END FOREACH
               END IF
            FINISH REPORT apmr440_g01_subrep05
          #end add-point:rep.everyrow.afterrow
 
          #單身後備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub03.before name="rep.sub03.before"
  
           #end add-point:rep.sub03.before
 
           #add-point:rep.sub03.sql name="rep.sub03.sql"
           
           #end add-point:rep.sub03.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooffent = '", 
                sr1.pmdient CLIPPED ,"'", " AND  ooff003 = '", sr1.pmdidocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.pmdjseq CLIPPED ,""
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE apmr440_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE apmr440_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT apmr440_g01_subrep03
           DECLARE apmr440_g01_repcur03 CURSOR FROM g_sql
           FOREACH apmr440_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "apmr440_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
            
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT apmr440_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT apmr440_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
           
                                                       
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.pmdidocno
 
           #add-point:rep.a_group.pmdidocno.before name="rep.a_group.pmdidocno.before"
         
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.pmdient CLIPPED ,"'", " AND  ooff003 = '", sr1.pmdidocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE apmr440_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE apmr440_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT apmr440_g01_subrep04
           DECLARE apmr440_g01_repcur04 CURSOR FROM g_sql
           FOREACH apmr440_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "apmr440_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT apmr440_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT apmr440_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.pmdidocno.after name="rep.a_group.pmdidocno.after"
          
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.pmdjseq
 
           #add-point:rep.a_group.pmdjseq.before name="rep.a_group.pmdjseq.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.pmdjseq.after name="rep.a_group.pmdjseq.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="apmr440_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT apmr440_g01_subrep01(sr2)
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
PRIVATE REPORT apmr440_g01_subrep02(sr2)
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
PRIVATE REPORT apmr440_g01_subrep03(sr2)
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
PRIVATE REPORT apmr440_g01_subrep04(sr2)
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
 
{<section id="apmr440_g01.other_function" readonly="Y" >}

 
{</section>}
 
{<section id="apmr440_g01.other_report" readonly="Y" >}

REPORT apmr440_g01_subrep05(sr3)
DEFINE sr3 sr3_r 

ORDER EXTERNAL BY sr3.pmdkdocno

      FORMAT
          
        ON EVERY ROW
            
            PRINTX sr3.*
            PRINTX g_grNumFmt.*            
      
END REPORT

 
{</section>}
 
