#該程式未解開Section, 採用最新樣板產出!
{<section id="apmr420_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:5(2016-11-02 21:04:21), PR版次:0005(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000203
#+ Filename...: apmr420_g01
#+ Description: ...
#+ Creator....: 05231(2014-05-05 14:38:17)
#+ Modifier...: 08734 -SD/PR- 00000
 
{</section>}
 
{<section id="apmr420_g01.global" readonly="Y" >}
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
   pmdf001 LIKE pmdf_t.pmdf001, 
   pmdf002 LIKE pmdf_t.pmdf002, 
   pmdf003 LIKE pmdf_t.pmdf003, 
   pmdf004 LIKE pmdf_t.pmdf004, 
   pmdf005 LIKE pmdf_t.pmdf005, 
   pmdf006 LIKE pmdf_t.pmdf006, 
   pmdf007 LIKE pmdf_t.pmdf007, 
   pmdf008 LIKE pmdf_t.pmdf008, 
   pmdf009 LIKE pmdf_t.pmdf009, 
   pmdf010 LIKE pmdf_t.pmdf010, 
   pmdf030 LIKE pmdf_t.pmdf030, 
   pmdfdocdt LIKE pmdf_t.pmdfdocdt, 
   pmdfdocno LIKE pmdf_t.pmdfdocno, 
   pmdfent LIKE pmdf_t.pmdfent, 
   pmdfsite LIKE pmdf_t.pmdfsite, 
   pmdfstus LIKE pmdf_t.pmdfstus, 
   pmdg001 LIKE pmdg_t.pmdg001, 
   pmdg002 LIKE pmdg_t.pmdg002, 
   pmdg003 LIKE pmdg_t.pmdg003, 
   pmdg004 LIKE pmdg_t.pmdg004, 
   pmdg005 LIKE pmdg_t.pmdg005, 
   pmdg007 LIKE pmdg_t.pmdg007, 
   pmdg008 LIKE pmdg_t.pmdg008, 
   pmdg009 LIKE pmdg_t.pmdg009, 
   pmdg010 LIKE pmdg_t.pmdg010, 
   pmdg011 LIKE pmdg_t.pmdg011, 
   pmdg012 LIKE pmdg_t.pmdg012, 
   pmdg013 LIKE pmdg_t.pmdg013, 
   pmdg014 LIKE pmdg_t.pmdg014, 
   pmdg015 LIKE pmdg_t.pmdg015, 
   pmdg016 LIKE pmdg_t.pmdg016, 
   pmdg017 LIKE pmdg_t.pmdg017, 
   pmdg018 LIKE pmdg_t.pmdg018, 
   pmdg030 LIKE pmdg_t.pmdg030, 
   pmdgseq LIKE pmdg_t.pmdgseq, 
   pmdgsite LIKE pmdg_t.pmdgsite, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   pmaal_t_pmaal004 LIKE pmaal_t.pmaal004, 
   x_t4_pmaal004 LIKE pmaal_t.pmaal004, 
   ooail_t_ooail003 LIKE ooail_t.ooail003, 
   ooibl_t_ooibl004 LIKE ooibl_t.ooibl004, 
   oocql_t_oocql004 LIKE oocql_t.oocql004, 
   x_t1_oocql004 LIKE oocql_t.oocql004, 
   x_t2_oocql004 LIKE oocql_t.oocql004, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   x_t3_imaal003 LIKE imaal_t.imaal003, 
   x_oocal_t_oocal003 LIKE oocal_t.oocal003, 
   l_pmdf002_ooag011 LIKE type_t.chr80, 
   l_pmdg002_pmaal004 LIKE type_t.chr80, 
   x_t3_imaal004 LIKE imaal_t.imaal004, 
   l_pmdf009_desc LIKE type_t.chr80, 
   l_pmdf010_desc LIKE type_t.chr80, 
   l_pmdf003_ooefl003 LIKE type_t.chr80, 
   l_pmdf006_desc LIKE type_t.chr80
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
   pmdhseq    LIKE pmdh_t.pmdhseq,
   pmdhdocno  LIKE pmdh_t.pmdhdocno,
   pmdh001    LIKE pmdh_t.pmdh001,  
   pmdh002    LIKE pmdh_t.pmdh002,
   pmdh003    LIKE pmdh_t.pmdh003,  
   pmdh004    LIKE pmdh_t.pmdh004  
   
END RECORD
#end add-point
 
{</section>}
 
{<section id="apmr420_g01.main" readonly="Y" >}
PUBLIC FUNCTION apmr420_g01(p_arg1)
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
   
   LET g_rep_code = "apmr420_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL apmr420_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL apmr420_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL apmr420_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="apmr420_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apmr420_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   
   #end add-point
   LET g_select = " SELECT pmdf001,pmdf002,pmdf003,pmdf004,pmdf005,pmdf006,pmdf007,pmdf008,pmdf009,pmdf010, 
       pmdf030,pmdfdocdt,pmdfdocno,pmdfent,pmdfsite,pmdfstus,pmdg001,pmdg002,pmdg003,pmdg004,pmdg005, 
       pmdg007,pmdg008,pmdg009,pmdg010,pmdg011,pmdg012,pmdg013,pmdg014,pmdg015,pmdg016,pmdg017,pmdg018, 
       pmdg030,pmdgseq,pmdgsite,( SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = pmdf_t.pmdf002 AND ooag_t.ooagent = pmdf_t.pmdfent), 
       ( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = pmdf_t.pmdf003 AND ooefl_t.ooeflent = pmdf_t.pmdfent AND ooefl_t.ooefl002 = '" , 
       g_dlang,"'" ,"),( SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = pmdf_t.pmdf004 AND pmaal_t.pmaalent = pmdf_t.pmdfent AND pmaal_t.pmaal002 = '" , 
       g_dlang,"'" ,"),x.t4_pmaal004,( SELECT ooail003 FROM ooail_t WHERE ooail_t.ooail001 = pmdf_t.pmdf005 AND ooail_t.ooailent = pmdf_t.pmdfent AND ooail_t.ooail002 = '" , 
       g_dlang,"'" ,"),( SELECT ooibl004 FROM ooibl_t WHERE ooibl_t.ooibl002 = pmdf_t.pmdf009 AND ooibl_t.ooiblent = pmdf_t.pmdfent AND ooibl_t.ooibl003 = '" , 
       g_dlang,"'" ,"),( SELECT oocql004 FROM oocql_t WHERE oocql_t.oocql001 = '238' AND oocql_t.oocql002 = pmdf_t.pmdf010 AND oocql_t.oocqlent = pmdf_t.pmdfent AND oocql_t.oocql003 = '" , 
       g_dlang,"'" ,"),x.t1_oocql004,x.t2_oocql004,x.imaal_t_imaal003,x.t3_imaal003,x.oocal_t_oocal003, 
       trim(pmdf002)||'.'||trim((SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = pmdf_t.pmdf002 AND ooag_t.ooagent = pmdf_t.pmdfent)), 
       trim(pmdg002)||'.'||trim(x.t4_pmaal004),x.t3_imaal004,'','',trim(pmdf003)||'.'||trim((SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = pmdf_t.pmdf003 AND ooefl_t.ooeflent = pmdf_t.pmdfent AND ooefl_t.ooefl002 = '" , 
       g_dlang,"'" ,")),''"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   
   #end add-point
    LET g_from = " FROM pmdf_t LEFT OUTER JOIN ( SELECT pmdg_t.*,( SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = pmdg_t.pmdg002 AND pmaal_t.pmaalent = pmdg_t.pmdgent AND pmaal_t.pmaal002 = '" , 
        g_dlang,"'" ,") t4_pmaal004,( SELECT oocql004 FROM oocql_t WHERE oocql_t.oocql001 = '263' AND oocql_t.oocql002 = pmdg_t.pmdg016 AND oocql_t.oocqlent = pmdg_t.pmdgent AND oocql_t.oocql003 = '" , 
        g_dlang,"'" ,") t1_oocql004,( SELECT oocql004 FROM oocql_t WHERE oocql_t.oocql001 = '221' AND oocql_t.oocql002 = pmdg_t.pmdg014 AND oocql_t.oocqlent = pmdg_t.pmdgent AND oocql_t.oocql003 = '" , 
        g_dlang,"'" ,") t2_oocql004,( SELECT imaal003 FROM imaal_t WHERE imaal_t.imaal001 = pmdg_t.pmdg005 AND imaal_t.imaalent = pmdg_t.pmdgent AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,") imaal_t_imaal003,( SELECT imaal003 FROM imaal_t WHERE imaal_t.imaal001 = pmdg_t.pmdg003 AND imaal_t.imaalent = pmdg_t.pmdgent AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,") t3_imaal003,( SELECT oocal003 FROM oocal_t WHERE oocal_t.oocal001 = pmdg_t.pmdg008 AND oocal_t.oocalent = pmdg_t.pmdgent AND oocal_t.oocal002 = '" , 
        g_dlang,"'" ,") oocal_t_oocal003,( SELECT imaal004 FROM imaal_t WHERE imaal_t.imaal001 = pmdg_t.pmdg003 AND imaal_t.imaalent = pmdg_t.pmdgent AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,") t3_imaal004 FROM pmdg_t ) x  ON pmdf_t.pmdfent = x.pmdgent AND pmdf_t.pmdfdocno  
        = x.pmdgdocno AND pmdf_t.pmdfsite = x.pmdgsite"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
    LET g_order = " ORDER BY pmdfdocno,pmdgseq"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("pmdf_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE apmr420_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE apmr420_g01_curs CURSOR FOR apmr420_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="apmr420_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION apmr420_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   pmdf001 LIKE pmdf_t.pmdf001, 
   pmdf002 LIKE pmdf_t.pmdf002, 
   pmdf003 LIKE pmdf_t.pmdf003, 
   pmdf004 LIKE pmdf_t.pmdf004, 
   pmdf005 LIKE pmdf_t.pmdf005, 
   pmdf006 LIKE pmdf_t.pmdf006, 
   pmdf007 LIKE pmdf_t.pmdf007, 
   pmdf008 LIKE pmdf_t.pmdf008, 
   pmdf009 LIKE pmdf_t.pmdf009, 
   pmdf010 LIKE pmdf_t.pmdf010, 
   pmdf030 LIKE pmdf_t.pmdf030, 
   pmdfdocdt LIKE pmdf_t.pmdfdocdt, 
   pmdfdocno LIKE pmdf_t.pmdfdocno, 
   pmdfent LIKE pmdf_t.pmdfent, 
   pmdfsite LIKE pmdf_t.pmdfsite, 
   pmdfstus LIKE pmdf_t.pmdfstus, 
   pmdg001 LIKE pmdg_t.pmdg001, 
   pmdg002 LIKE pmdg_t.pmdg002, 
   pmdg003 LIKE pmdg_t.pmdg003, 
   pmdg004 LIKE pmdg_t.pmdg004, 
   pmdg005 LIKE pmdg_t.pmdg005, 
   pmdg007 LIKE pmdg_t.pmdg007, 
   pmdg008 LIKE pmdg_t.pmdg008, 
   pmdg009 LIKE pmdg_t.pmdg009, 
   pmdg010 LIKE pmdg_t.pmdg010, 
   pmdg011 LIKE pmdg_t.pmdg011, 
   pmdg012 LIKE pmdg_t.pmdg012, 
   pmdg013 LIKE pmdg_t.pmdg013, 
   pmdg014 LIKE pmdg_t.pmdg014, 
   pmdg015 LIKE pmdg_t.pmdg015, 
   pmdg016 LIKE pmdg_t.pmdg016, 
   pmdg017 LIKE pmdg_t.pmdg017, 
   pmdg018 LIKE pmdg_t.pmdg018, 
   pmdg030 LIKE pmdg_t.pmdg030, 
   pmdgseq LIKE pmdg_t.pmdgseq, 
   pmdgsite LIKE pmdg_t.pmdgsite, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   pmaal_t_pmaal004 LIKE pmaal_t.pmaal004, 
   x_t4_pmaal004 LIKE pmaal_t.pmaal004, 
   ooail_t_ooail003 LIKE ooail_t.ooail003, 
   ooibl_t_ooibl004 LIKE ooibl_t.ooibl004, 
   oocql_t_oocql004 LIKE oocql_t.oocql004, 
   x_t1_oocql004 LIKE oocql_t.oocql004, 
   x_t2_oocql004 LIKE oocql_t.oocql004, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   x_t3_imaal003 LIKE imaal_t.imaal003, 
   x_oocal_t_oocal003 LIKE oocal_t.oocal003, 
   l_pmdf002_ooag011 LIKE type_t.chr80, 
   l_pmdg002_pmaal004 LIKE type_t.chr80, 
   x_t3_imaal004 LIKE imaal_t.imaal004, 
   l_pmdf009_desc LIKE type_t.chr80, 
   l_pmdf010_desc LIKE type_t.chr80, 
   l_pmdf003_ooefl003 LIKE type_t.chr80, 
   l_pmdf006_desc LIKE type_t.chr80
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_ooef019  LIKE ooef_t.ooef019

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH apmr420_g01_curs INTO sr_s.*
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
       #稅別說明
       INITIALIZE l_ooef019 TO NULL
       SELECT ooef019 INTO l_ooef019
         FROM ooef_t
        WHERE ooef001=sr_s.pmdfsite
          AND ooefent=sr_s.pmdfent 
                   
       SELECT oodbl004 INTO sr_s.l_pmdf006_desc
         FROM oodbl_t y
        WHERE sr_s.pmdf006 = y.oodbl002
          AND l_ooef019    = y.oodbl001
          AND g_dlang      = y.oodbl003
          AND sr_s.pmdfent = y.oodblent
        
       #付款條件說明            
       SELECT ooibl004 INTO sr_s.l_pmdf009_desc
         FROM ooibl_t
        WHERE ooiblent = sr_s.pmdfent
          AND ooibl002 = sr_s.pmdf009
          AND ooibl003 = g_dlang
      #交易條件說明
       SELECT oocql004 INTO sr_s.l_pmdf010_desc
         FROM oocql_t
        WHERE oocqlent = sr_s.pmdfent
          AND oocql001 = 238
          AND oocql002 = sr_s.pmdf010
          AND oocql003 = g_dlang

       

       
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
        
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].pmdf001 = sr_s.pmdf001
       LET sr[l_cnt].pmdf002 = sr_s.pmdf002
       LET sr[l_cnt].pmdf003 = sr_s.pmdf003
       LET sr[l_cnt].pmdf004 = sr_s.pmdf004
       LET sr[l_cnt].pmdf005 = sr_s.pmdf005
       LET sr[l_cnt].pmdf006 = sr_s.pmdf006
       LET sr[l_cnt].pmdf007 = sr_s.pmdf007
       LET sr[l_cnt].pmdf008 = sr_s.pmdf008
       LET sr[l_cnt].pmdf009 = sr_s.pmdf009
       LET sr[l_cnt].pmdf010 = sr_s.pmdf010
       LET sr[l_cnt].pmdf030 = sr_s.pmdf030
       LET sr[l_cnt].pmdfdocdt = sr_s.pmdfdocdt
       LET sr[l_cnt].pmdfdocno = sr_s.pmdfdocno
       LET sr[l_cnt].pmdfent = sr_s.pmdfent
       LET sr[l_cnt].pmdfsite = sr_s.pmdfsite
       LET sr[l_cnt].pmdfstus = sr_s.pmdfstus
       LET sr[l_cnt].pmdg001 = sr_s.pmdg001
       LET sr[l_cnt].pmdg002 = sr_s.pmdg002
       LET sr[l_cnt].pmdg003 = sr_s.pmdg003
       LET sr[l_cnt].pmdg004 = sr_s.pmdg004
       LET sr[l_cnt].pmdg005 = sr_s.pmdg005
       LET sr[l_cnt].pmdg007 = sr_s.pmdg007
       LET sr[l_cnt].pmdg008 = sr_s.pmdg008
       LET sr[l_cnt].pmdg009 = sr_s.pmdg009
       LET sr[l_cnt].pmdg010 = sr_s.pmdg010
       LET sr[l_cnt].pmdg011 = sr_s.pmdg011
       LET sr[l_cnt].pmdg012 = sr_s.pmdg012
       LET sr[l_cnt].pmdg013 = sr_s.pmdg013
       LET sr[l_cnt].pmdg014 = sr_s.pmdg014
       LET sr[l_cnt].pmdg015 = sr_s.pmdg015
       LET sr[l_cnt].pmdg016 = sr_s.pmdg016
       LET sr[l_cnt].pmdg017 = sr_s.pmdg017
       LET sr[l_cnt].pmdg018 = sr_s.pmdg018
       LET sr[l_cnt].pmdg030 = sr_s.pmdg030
       LET sr[l_cnt].pmdgseq = sr_s.pmdgseq
       LET sr[l_cnt].pmdgsite = sr_s.pmdgsite
       LET sr[l_cnt].ooag_t_ooag011 = sr_s.ooag_t_ooag011
       LET sr[l_cnt].ooefl_t_ooefl003 = sr_s.ooefl_t_ooefl003
       LET sr[l_cnt].pmaal_t_pmaal004 = sr_s.pmaal_t_pmaal004
       LET sr[l_cnt].x_t4_pmaal004 = sr_s.x_t4_pmaal004
       LET sr[l_cnt].ooail_t_ooail003 = sr_s.ooail_t_ooail003
       LET sr[l_cnt].ooibl_t_ooibl004 = sr_s.ooibl_t_ooibl004
       LET sr[l_cnt].oocql_t_oocql004 = sr_s.oocql_t_oocql004
       LET sr[l_cnt].x_t1_oocql004 = sr_s.x_t1_oocql004
       LET sr[l_cnt].x_t2_oocql004 = sr_s.x_t2_oocql004
       LET sr[l_cnt].x_imaal_t_imaal003 = sr_s.x_imaal_t_imaal003
       LET sr[l_cnt].x_t3_imaal003 = sr_s.x_t3_imaal003
       LET sr[l_cnt].x_oocal_t_oocal003 = sr_s.x_oocal_t_oocal003
       LET sr[l_cnt].l_pmdf002_ooag011 = sr_s.l_pmdf002_ooag011
       LET sr[l_cnt].l_pmdg002_pmaal004 = sr_s.l_pmdg002_pmaal004
       LET sr[l_cnt].x_t3_imaal004 = sr_s.x_t3_imaal004
       LET sr[l_cnt].l_pmdf009_desc = sr_s.l_pmdf009_desc
       LET sr[l_cnt].l_pmdf010_desc = sr_s.l_pmdf010_desc
       LET sr[l_cnt].l_pmdf003_ooefl003 = sr_s.l_pmdf003_ooefl003
       LET sr[l_cnt].l_pmdf006_desc = sr_s.l_pmdf006_desc
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apmr420_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION apmr420_g01_rep_data()
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
          START REPORT apmr420_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT apmr420_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT apmr420_g01_rep
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
 
{<section id="apmr420_g01.rep" readonly="Y" >}
PRIVATE REPORT apmr420_g01_rep(sr1)
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
DEFINE l_sql     STRING
DEFINE sr3       sr3_r
DEFINE l_percent_show  LIKE type_t.chr5
DEFINE l_pmdf030_show  LIKE type_t.chr5  
DEFINE l_detail04_show LIKE type_t.chr5  
DEFINE l_detail05_show LIKE type_t.chr5   
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER EXTERNAL BY sr1.pmdfdocno,sr1.pmdgseq
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
        BEFORE GROUP OF sr1.pmdfdocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.pmdfdocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'pmdfent=' ,sr1.pmdfent,'{+}pmdfdocno=' ,sr1.pmdfdocno         
            CALL cl_gr_init_apr(sr1.pmdfdocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.pmdfdocno.before name="rep.b_group.pmdfdocno.before"
           
           #單頭備註隱藏
           INITIALIZE l_pmdf030_show TO NULL
           IF cl_null(sr1.pmdf030) THEN
              LET l_pmdf030_show = "N"
           ELSE
              LET l_pmdf030_show = "Y"
           END IF
           
           PRINTX l_pmdf030_show
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.pmdfent CLIPPED ,"'", " AND  ooff003 = '", sr1.pmdfdocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE apmr420_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE apmr420_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT apmr420_g01_subrep01
           DECLARE apmr420_g01_repcur01 CURSOR FROM g_sql
           FOREACH apmr420_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "apmr420_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT apmr420_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT apmr420_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.pmdfdocno.after name="rep.b_group.pmdfdocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.pmdgseq
 
           #add-point:rep.b_group.pmdgseq.before name="rep.b_group.pmdgseq.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.pmdgseq.after name="rep.b_group.pmdgseq.after"
           
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
                sr1.pmdfent CLIPPED ,"'", " AND  ooff003 = '", sr1.pmdfdocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.pmdgseq CLIPPED ,""
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE apmr420_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE apmr420_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT apmr420_g01_subrep02
           DECLARE apmr420_g01_repcur02 CURSOR FROM g_sql
           FOREACH apmr420_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "apmr420_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT apmr420_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT apmr420_g01_subrep02
           #add-point:rep.sub02.after name="rep.sub02.after"
            
           #end add-point:rep.sub02.after
 
 
 
          #add-point:rep.everyrow.beforerow name="rep.everyrow.beforerow"
          
          #end add-point:rep.everyrow.beforerow
            
          PRINTX sr1.*
 
          #add-point:rep.everyrow.afterrow name="rep.everyrow.afterrow"
            #單身%隱藏
            INITIALIZE l_percent_show TO NULL
            IF cl_null(sr1.pmdg012) THEN
               LET l_percent_show = "N"
            ELSE
               LET l_percent_show = "Y"
            END IF
            #單身備註隱藏
            INITIALIZE l_detail05_show TO NULL
            IF cl_null(sr1.pmdg030) THEN
               LET l_detail05_show = "N"
            ELSE
               LET l_detail05_show = "Y"
            END IF
            #單身產品特徵隱藏
            INITIALIZE l_detail04_show TO NULL
            IF cl_null(sr1.pmdg004) THEN
               LET l_detail04_show = "N"
            ELSE
               LET l_detail04_show = "Y"
            END IF

            
            
            PRINTX l_percent_show,l_detail05_show,l_detail04_show
          #end add-point:rep.everyrow.afterrow
 
          #單身後備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub03.before name="rep.sub03.before"
           
           #end add-point:rep.sub03.before
 
           #add-point:rep.sub03.sql name="rep.sub03.sql"
           
           #end add-point:rep.sub03.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooffent = '", 
                sr1.pmdfent CLIPPED ,"'", " AND  ooff003 = '", sr1.pmdfdocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.pmdgseq CLIPPED ,""
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE apmr420_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE apmr420_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT apmr420_g01_subrep03
           DECLARE apmr420_g01_repcur03 CURSOR FROM g_sql
           FOREACH apmr420_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "apmr420_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT apmr420_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT apmr420_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
              START REPORT apmr420_g01_subrep05
              IF NOT cl_null(sr1.pmdgseq) THEN
               
                 LET l_sql ="SELECT pmdhseq,pmdhdocno,pmdh001,pmdh002,pmdh003,pmdh004 ",
                          "  FROM pmdh_t ",
                          " WHERE pmdhdocno = '",sr1.pmdfdocno CLIPPED,"'",
                          "   AND pmdhent   = '",sr1.pmdfent   CLIPPED,"'", 
                          "   AND pmdhseq   = '",sr1.pmdgseq   CLIPPED,"'  ", 
                          "   ORDER BY pmdh001 "
                        
                 DECLARE pmdh_repcur CURSOR FROM l_sql
                 FOREACH pmdh_repcur INTO sr3.*             
                    OUTPUT TO REPORT apmr420_g01_subrep05(sr3.*)
                 END FOREACH
              END IF            
              FINISH REPORT apmr420_g01_subrep05
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.pmdfdocno
 
           #add-point:rep.a_group.pmdfdocno.before name="rep.a_group.pmdfdocno.before"
 
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.pmdfent CLIPPED ,"'", " AND  ooff003 = '", sr1.pmdfdocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE apmr420_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE apmr420_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT apmr420_g01_subrep04
           DECLARE apmr420_g01_repcur04 CURSOR FROM g_sql
           FOREACH apmr420_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "apmr420_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT apmr420_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT apmr420_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
            
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.pmdfdocno.after name="rep.a_group.pmdfdocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.pmdgseq
 
           #add-point:rep.a_group.pmdgseq.before name="rep.a_group.pmdgseq.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.pmdgseq.after name="rep.a_group.pmdgseq.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="apmr420_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT apmr420_g01_subrep01(sr2)
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
PRIVATE REPORT apmr420_g01_subrep02(sr2)
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
PRIVATE REPORT apmr420_g01_subrep03(sr2)
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
PRIVATE REPORT apmr420_g01_subrep04(sr2)
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
 
{<section id="apmr420_g01.other_function" readonly="Y" >}

 
{</section>}
 
{<section id="apmr420_g01.other_report" readonly="Y" >}

REPORT apmr420_g01_subrep05(sr3)

 DEFINE sr3 sr3_r
 ORDER EXTERNAL BY sr3.pmdhdocno
      FORMAT

        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr3.*
END REPORT

 
{</section>}
 
