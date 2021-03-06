#該程式未解開Section, 採用最新樣板產出!
{<section id="apmr421_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:4(2015-11-18 16:44:18), PR版次:0004(2015-11-18 17:36:08)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000074
#+ Filename...: apmr421_x01
#+ Description: ...
#+ Creator....: 05423(2014-09-02 15:20:09)
#+ Modifier...: 07024 -SD/PR- 07024
 
{</section>}
 
{<section id="apmr421_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"

#end add-point
#add-point:填寫註解說明 name="global.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="global.import"
##151106-00004#12 by Dorislai 改善效能，將ins_data中的資料，寫入sel_prep的sql中
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../cfg/top_report.inc"                  #報表使用的global
 
#報表 type 宣告
DEFINE tm RECORD
       wc STRING                   #where condition
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="apmr421_x01.main" readonly="Y" >}
PUBLIC FUNCTION apmr421_x01(p_arg1)
DEFINE  p_arg1 STRING                  #tm.wc  where condition
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "apmr421_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL apmr421_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL apmr421_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL apmr421_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL apmr421_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL apmr421_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="apmr421_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION apmr421_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "pmdfdocno.pmdf_t.pmdfdocno,pmdfdocdt.pmdf_t.pmdfdocdt,pmdg002.pmdg_t.pmdg002,l_pmdg002_desc.type_t.chr500,l_pmdg002_pmaal004.type_t.chr30,l_pmaa080_desc.type_t.chr30,pmdf002.pmdf_t.pmdf002,l_pmdf002_desc.type_t.chr500,l_pmdf002_ooag011.type_t.chr30,pmdf003.pmdf_t.pmdf003,l_pmdf003_desc.type_t.chr500,l_pmdf003_ooefl003.type_t.chr30,pmdf005.pmdf_t.pmdf005,l_pmdf005_desc.type_t.chr30,l_pmdf005_ooail003.type_t.chr1000,pmdf006.pmdf_t.pmdf006,l_pmdf006_desc.type_t.chr30,l_pmdf006_oodbl004.type_t.chr1000,pmdf009.pmdf_t.pmdf009,l_pmdf009_desc.type_t.chr30,l_pmdf009_ooibl004.type_t.chr1000,pmdf010.pmdf_t.pmdf010,l_pmdf010_desc.type_t.chr30,l_pmdf010_oocql004.type_t.chr1000,l_imaa009_desc.type_t.chr30,pmdg003.pmdg_t.pmdg003,imaal_t_imaal003.imaal_t.imaal003,imaal_t_imaal004.imaal_t.imaal004,pmdg004.pmdg_t.pmdg004,l_pmdg004_desc.type_t.chr30,l_pmdg004_desc1.type_t.chr1000,l_imaa127.type_t.chr30,l_imaa127_desc.type_t.chr50,l_imaa127_oocql004.type_t.chr500,pmdg008.pmdg_t.pmdg008,pmdg007.pmdg_t.pmdg007,pmdg010.pmdg_t.pmdg010,pmdg013.pmdg_t.pmdg013,pmdg012.pmdg_t.pmdg012,pmdg017.pmdg_t.pmdg017,pmdf004.pmdf_t.pmdf004,l_pmdf004_desc.type_t.chr30,l_pmdf004_pmaal004.type_t.chr1000,pmdf007.pmdf_t.pmdf007,pmdf030.pmdf_t.pmdf030,pmdfstus.pmdf_t.pmdfstus,l_pmdfstus_desc.type_t.chr30,l_pmdfstus_gzcbl004.type_t.chr50,pmdg005.pmdg_t.pmdg005,l_pmdg005_desc.type_t.chr30,l_pmdg005_imaal003.type_t.chr1000,pmdg009.pmdg_t.pmdg009,pmdg011.pmdg_t.pmdg011,pmdg016.pmdg_t.pmdg016,l_pmdg016_desc.type_t.chr30,l_pmdg016_oocql004.type_t.chr1000,pmdg018.pmdg_t.pmdg018,l_pmdg018_desc.type_t.chr30,l_pmdg018_oodbl004.type_t.chr1000,pmdg030.pmdg_t.pmdg030,pmdgseq.pmdg_t.pmdgseq" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="apmr421_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION apmr421_x01_ins_prep()
DEFINE i              INTEGER
DEFINE l_prep_str     STRING
#add-point:ins_prep.define (客製用) name="ins_prep.define_customerization"

#end add-point:ins_prep.define
#add-point:ins_prep.define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_prep.define"

#end add-point:ins_prep.define
 
   FOR i = 1 TO g_rep_tmpname.getLength()
      CALL cl_xg_del_data(g_rep_tmpname[i])
      #LET g_sql = g_rep_ins_prep[i]              #透過此lib取得prepare字串 lib精簡
      CASE i
         WHEN 1
         #INSERT INTO PREP
         LET g_sql = " INSERT INTO ",g_rep_db CLIPPED,g_rep_tmpname[1] CLIPPED," VALUES(?,?,?,?,?,?, 
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?, 
             ?,?,?,?,?,?,?,?,?,?,?)"
         PREPARE insert_prep FROM g_sql
         IF STATUS THEN
            LET l_prep_str ="insert_prep",i
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_prep_str
            LET g_errparam.code   = status
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            CALL cl_xg_drop_tmptable()
            LET g_rep_success = 'N'           
         END IF 
         #add-point:insert_prep段 name="insert_prep"
         
         #end add-point                  
 
 
      END CASE
   END FOR
END FUNCTION
 
{</section>}
 
{<section id="apmr421_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apmr421_x01_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define(客製用) name="sel_prep.define_customerization"

#end add-point
#add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"

#end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
 
   #add-point:sel_prep g_select name="sel_prep.g_select"
   #151106-00004#12-mod-(S)
#   LET g_select = " SELECT UNIQUE pmdfdocno,pmdfdocdt,trim(pmdg002)||'.'||trim(pmaal_t.pmaal004),oocql_t.oocql004, 
#       trim(pmdf002)||'.'||trim(ooag_t.ooag011),trim(pmdf003)||'.'||trim(ooefl_t.ooefl003),pmdf005,oodbl_t.oodbl004, 
#       ooibl_t.ooibl004,pmdf010,NULL,rtaxl003,pmdg003,imaal_t.imaal003,imaal_t.imaal004,pmdg004,NULL,NULL,NULL,pmdg008,pmdg007, 
#       pmdg010,pmdg013,pmdg012,pmdg017,pmdf002,pmdf003,pmdf004,pmdf006,pmdf007,pmdf008,pmdf009,pmdf030,pmdfstus,
#       pmdg002,pmdg005,pmdg009,pmdg011,pmdg016,pmdg018,pmdg030,pmdgseq,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
#       NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL"
   LET g_select = " SELECT UNIQUE pmdfdocno,pmdfdocdt,pmdg002,C2.pmaal004,
                    CASE WHEN C2.pmaal004 IS NULL THEN pmdg002 ELSE trim(pmdg002)||'.'||trim(C2.pmaal004) END ,
                    A1.oocql004,pmdf002,ooag_t.ooag011,
                    CASE WHEN ooag_t.ooag011 IS NULL THEN pmdf002 ELSE trim(pmdf002)||'.'||trim(ooag_t.ooag011) END ,
                    pmdf003,ooefl_t.ooefl003,
                    CASE WHEN ooefl_t.ooefl003 IS NULL THEN pmdf003 ELSE trim(pmdf003)||'.'||trim(ooefl_t.ooefl003) END ,
                    pmdf005,ooail_t.ooail003,
                    CASE WHEN ooail003 IS NULL THEN pmdf005 ELSE trim(pmdf005)||'.'||trim(ooail003) END ,
                    pmdf006,E1.oodbl004,
                    CASE WHEN E1.oodbl004 IS NULL THEN pmdf006 ELSE trim(pmdf006)||'.'||trim(E1.oodbl004) END ,
                    pmdf009,ooibl004,
                    CASE WHEN ooibl004 IS NULL THEN pmdf009 ELSE trim(pmdf009)||'.'||trim(ooibl004) END ,
                    pmdf010,A1.oocql004,
                    CASE WHEN A2.oocql004 IS NULL THEN pmdf010 ELSE trim(pmdf010)||'.'||trim(A2.oocql004) END ,
                    rtaxl003,pmdg003,D1.imaal003,D1.imaal004,pmdg004,NULL,NULL,imaa127,A3.oocql004,
                    CASE WHEN A3.oocql004 IS NULL THEN imaa127 ELSE trim(imaa127)||'.'||trim(A3.oocql004) END ,
                    pmdg008,pmdg007,pmdg010,pmdg013,pmdg012,pmdg017,pmdf004,C1.pmaal004,
                    CASE WHEN C1.pmaal004 IS NULL THEN pmdf004 ELSE trim(pmdf004)||'.'||trim(C1.pmaal004) END ,
                    pmdf007,pmdf030,pmdfstus,gzcbl_t.gzcbl004,
                    CASE WHEN gzcbl004 IS NULL THEN pmdfstus ELSE trim(pmdfstus)||'.'||trim(gzcbl004) END ,
                    pmdg005,D2.imaal003,
                    CASE WHEN D2.imaal003 IS NULL THEN pmdg005 ELSE trim(pmdg005)||'.'||trim(D2.imaal003) END ,
                    pmdg009,pmdg011,pmdg016,A4.oocql004,
                    CASE WHEN A4.oocql004 IS NULL THEN pmdg016 ELSE trim(pmdg016)||'.'||trim(A4.oocql004) END ,
                    pmdg018,E2.oodbl004,
                    CASE WHEN E2.oodbl004 IS NULL THEN pmdg018 ELSE trim(pmdg018)||'.'||trim(E2.oodbl004) END ,
                    pmdg030,pmdgseq "
   #151106-00004#12-mod-(E)    
#   #end add-point
#   LET g_select = " SELECT pmdfdocno,pmdfdocdt,pmdg002,NULL,trim(pmdg002)||'.'||trim(pmaal_t.pmaal004), 
#       NULL,pmdf002,NULL,trim(pmdf002)||'.'||trim(ooag_t.ooag011),pmdf003,NULL,trim(pmdf003)||'.'||trim(ooefl_t.ooefl003), 
#       pmdf005,NULL,NULL,pmdf006,NULL,NULL,pmdf009,NULL,NULL,pmdf010,NULL,NULL,NULL,pmdg003,imaal_t.imaal003, 
#       imaal_t.imaal004,pmdg004,NULL,NULL,NULL,NULL,NULL,pmdg008,pmdg007,pmdg010,pmdg013,pmdg012,pmdg017, 
#       pmdf004,NULL,NULL,pmdf007,pmdf030,pmdfstus,NULL,NULL,pmdg005,NULL,NULL,pmdg009,pmdg011,pmdg016, 
#       NULL,NULL,pmdg018,NULL,NULL,pmdg030,pmdgseq"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
#151106-00004#12-mod-(S)
##150527 by whitney modify start
#    LET g_from = " FROM pmdf_t LEFT OUTER JOIN pmdg_t ON pmdfent = pmdgent AND pmdfdocno = pmdgdocno                                                    ",
##                 "             LEFT OUTER JOIN pmaa_t ON pmdf004 = pmaa001 AND pmdfent = pmaaent                                                        ",
#                 "             LEFT OUTER JOIN pmaa_t ON pmdg002 = pmaa001 AND pmdfent = pmaaent                                                        ",
#                 "             LEFT OUTER JOIN imaa_t ON pmdg003 = imaa001 AND pmdfent = imaaent                                                        ",
#                 "             LEFT OUTER JOIN imaal_t ON pmdg003 = imaal001 AND pmdfent = imaalent AND imaal002 = '",g_dlang,"'                        ",
#                 "             LEFT OUTER JOIN ooag_t ON pmdf002 = ooag001 AND pmdfent = ooagent                                                        ",
##                 "             LEFT OUTER JOIN ooef_t ON pmdf003 = ooef001 AND pmdfent = ooefent                                                        ",
#                 "             LEFT OUTER JOIN ooef_t ON pmdfsite = ooef001 AND pmdfent = ooefent                                                        ",
#                 "             LEFT OUTER JOIN oocql_t ON pmaa080 = oocql002 AND pmdfent = oocqlent AND oocql001 = '251' AND oocql003 = '",g_dlang,"'   ",
#                 "             LEFT OUTER JOIN ooefl_t ON pmdf003 = ooefl001 AND pmdfent = ooeflent AND ooefl002 = '",g_dlang,"'                        ",
#                 "             LEFT OUTER JOIN oodbl_t ON pmdf006 = oodbl002 AND pmdfent = oodblent AND ooef019 = oodbl001 AND oodbl003 = '",g_dlang,"' ",
#                 "             LEFT OUTER JOIN ooibl_t ON pmdf009 = ooibl002 AND pmdfent = ooiblent AND ooibl003 = '",g_dlang,"'                        ",
##                 "             LEFT OUTER JOIN pmaal_t ON pmdf004 = pmaal001 AND pmdfent = pmaalent AND pmaal002 = '",g_dlang,"'                        ",    
#                 "             LEFT OUTER JOIN pmaal_t ON pmdg002 = pmaal001 AND pmdfent = pmaalent AND pmaal002 = '",g_dlang,"'                        ",    
#                 "             LEFT OUTER JOIN rtaxl_t ON imaa009 = rtaxl001 AND pmdfent = rtaxlent AND rtaxl002 = '",g_dlang,"'                        "
##150527 by whitney modify end
    LET g_from = " FROM pmdf_t LEFT OUTER JOIN pmdg_t ON pmdfent = pmdgent AND pmdfdocno = pmdgdocno ",
                 "             LEFT OUTER JOIN pmaa_t ON pmdg002 = pmaa001 AND pmdfent = pmaaent ",
                 "             LEFT OUTER JOIN imaa_t ON pmdg003 = imaa001 AND pmdfent = imaaent ",
                 "             LEFT OUTER JOIN ooag_t ON pmdf002 = ooag001 AND pmdfent = ooagent ",
#                 "             LEFT OUTER JOIN ooef_t ON pmdf003 = ooef001 AND pmdfent = ooefent  ",
                 "             LEFT OUTER JOIN ooef_t ON pmdfsite = ooef001 AND pmdfent = ooefent  ",
                 #ACC
                 "             LEFT OUTER JOIN oocql_t A1 ON pmaa080 = A1.oocql002 AND pmdfent = A1.oocqlent AND A1.oocql001 = '251' AND A1.oocql003 = '",g_dlang,"'   ",
                 "             LEFT OUTER JOIN oocql_t A2 ON pmdf010 = A2.oocql002 AND pmdfent = A2.oocqlent AND A2.oocql001 = '238' AND A2.oocql003 = '",g_dlang,"'   ",
                 "             LEFT OUTER JOIN oocql_t A3 ON imaa127 = A3.oocql002 AND imaaent = A3.oocqlent AND A3.oocql001 = '2003' AND A3.oocql003 = '",g_dlang,"'   ",
                 "             LEFT OUTER JOIN oocql_t A4 ON pmdg016 = A4.oocql002 AND pmdgent = A4.oocqlent AND A4.oocql001 = '263' AND A4.oocql003 = '",g_dlang,"'   ",
                 #pmaal_t
                 "             LEFT OUTER JOIN pmaal_t C1 ON pmdf004 = C1.pmaal001 AND pmdfent = C1.pmaalent AND C1.pmaal002 = '",g_dlang,"'",    
                 "             LEFT OUTER JOIN pmaal_t C2 ON pmdg002 = C2.pmaal001 AND pmdfent = C2.pmaalent AND C2.pmaal002 = '",g_dlang,"'",    
                 #imaal_t
                 "             LEFT OUTER JOIN imaal_t D1 ON pmdg003 = D1.imaal001 AND pmdgent = D1.imaalent AND D1.imaal002 = '",g_dlang,"'",
                 "             LEFT OUTER JOIN imaal_t D2 ON pmdg005 = D2.imaal001 AND pmdgent = D2.imaalent AND D2.imaal002 = '",g_dlang,"'",
                 #oodbl_t
                 "             LEFT OUTER JOIN oodbl_t E1 ON pmdf006 = E1.oodbl002 AND pmdfent = E1.oodblent AND ooef019 = E1.oodbl001 AND E1.oodbl003 = '",g_dlang,"' ",
                 "             LEFT OUTER JOIN oodbl_t E2 ON pmdg018 = E2.oodbl002 AND pmdgent = E2.oodblent AND ooef019 = E2.oodbl001 AND E2.oodbl003 = '",g_dlang,"' ",
                 "             LEFT OUTER JOIN ooail_t ON pmdfent = ooailent AND pmdf005 = ooail001 AND ooail002 = '",g_dlang,"'",               
                 "             LEFT OUTER JOIN gzcbl_t ON gzcbl001 = '13' AND pmdfstus = gzcbl002 AND gzcbl003 = '",g_dlang,"'",
                 "             LEFT OUTER JOIN ooefl_t ON pmdf003 = ooefl001 AND pmdfent = ooeflent AND ooefl002 = '",g_dlang,"'",
                 "             LEFT OUTER JOIN ooibl_t ON pmdf009 = ooibl002 AND pmdfent = ooiblent AND ooibl003 = '",g_dlang,"'",
                 "             LEFT OUTER JOIN rtaxl_t ON imaa009 = rtaxl001 AND pmdfent = rtaxlent AND rtaxl002 = '",g_dlang,"'"
                 
#151106-00004#12-mod-(E)
#   #end add-point
#    LET g_from = " FROM pmdf_t,pmdg_t,pmaa_t,imaa_t,imaal_t,ooag_t,oocql_t,ooefl_t,oodbl_t,ooibl_t,pmaal_t, 
#        rtaxl_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("pmdf_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE apmr421_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE apmr421_x01_curs CURSOR FOR apmr421_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="apmr421_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION apmr421_x01_ins_data()
DEFINE sr RECORD 
   pmdfdocno LIKE pmdf_t.pmdfdocno, 
   pmdfdocdt LIKE pmdf_t.pmdfdocdt, 
   pmdg002 LIKE pmdg_t.pmdg002, 
   l_pmdg002_desc LIKE type_t.chr500, 
   l_pmdg002_pmaal004 LIKE type_t.chr30, 
   l_pmaa080_desc LIKE type_t.chr30, 
   pmdf002 LIKE pmdf_t.pmdf002, 
   l_pmdf002_desc LIKE type_t.chr500, 
   l_pmdf002_ooag011 LIKE type_t.chr30, 
   pmdf003 LIKE pmdf_t.pmdf003, 
   l_pmdf003_desc LIKE type_t.chr500, 
   l_pmdf003_ooefl003 LIKE type_t.chr30, 
   pmdf005 LIKE pmdf_t.pmdf005, 
   l_pmdf005_desc LIKE type_t.chr30, 
   l_pmdf005_ooail003 LIKE type_t.chr1000, 
   pmdf006 LIKE pmdf_t.pmdf006, 
   l_pmdf006_desc LIKE type_t.chr30, 
   l_pmdf006_oodbl004 LIKE type_t.chr1000, 
   pmdf009 LIKE pmdf_t.pmdf009, 
   l_pmdf009_desc LIKE type_t.chr30, 
   l_pmdf009_ooibl004 LIKE type_t.chr1000, 
   pmdf010 LIKE pmdf_t.pmdf010, 
   l_pmdf010_desc LIKE type_t.chr30, 
   l_pmdf010_oocql004 LIKE type_t.chr1000, 
   l_imaa009_desc LIKE type_t.chr30, 
   pmdg003 LIKE pmdg_t.pmdg003, 
   imaal_t_imaal003 LIKE imaal_t.imaal003, 
   imaal_t_imaal004 LIKE imaal_t.imaal004, 
   pmdg004 LIKE pmdg_t.pmdg004, 
   l_pmdg004_desc LIKE type_t.chr30, 
   l_pmdg004_desc1 LIKE type_t.chr1000, 
   l_imaa127 LIKE type_t.chr30, 
   l_imaa127_desc LIKE type_t.chr50, 
   l_imaa127_oocql004 LIKE type_t.chr500, 
   pmdg008 LIKE pmdg_t.pmdg008, 
   pmdg007 LIKE pmdg_t.pmdg007, 
   pmdg010 LIKE pmdg_t.pmdg010, 
   pmdg013 LIKE pmdg_t.pmdg013, 
   pmdg012 LIKE pmdg_t.pmdg012, 
   pmdg017 LIKE pmdg_t.pmdg017, 
   pmdf004 LIKE pmdf_t.pmdf004, 
   l_pmdf004_desc LIKE type_t.chr30, 
   l_pmdf004_pmaal004 LIKE type_t.chr1000, 
   pmdf007 LIKE pmdf_t.pmdf007, 
   pmdf030 LIKE pmdf_t.pmdf030, 
   pmdfstus LIKE pmdf_t.pmdfstus, 
   l_pmdfstus_desc LIKE type_t.chr30, 
   l_pmdfstus_gzcbl004 LIKE type_t.chr50, 
   pmdg005 LIKE pmdg_t.pmdg005, 
   l_pmdg005_desc LIKE type_t.chr30, 
   l_pmdg005_imaal003 LIKE type_t.chr1000, 
   pmdg009 LIKE pmdg_t.pmdg009, 
   pmdg011 LIKE pmdg_t.pmdg011, 
   pmdg016 LIKE pmdg_t.pmdg016, 
   l_pmdg016_desc LIKE type_t.chr30, 
   l_pmdg016_oocql004 LIKE type_t.chr1000, 
   pmdg018 LIKE pmdg_t.pmdg018, 
   l_pmdg018_desc LIKE type_t.chr30, 
   l_pmdg018_oodbl004 LIKE type_t.chr1000, 
   pmdg030 LIKE pmdg_t.pmdg030, 
   pmdgseq LIKE pmdg_t.pmdgseq
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE  l_success   LIKE  type_t.num5      #dorislai-20150806-add
DEFINE  l_ooef019   LIKE  ooef_t.ooef019   #稅區   dorislai-20150806-add

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH apmr421_x01_curs INTO sr.*                               
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
    #151106-00004#12-mark-(S)
#       SELECT oocql004 INTO sr.l_pmdf010_desc
#       FROM oocql_t
#       WHERE oocql002 = sr.pmdf010 AND oocqlent = g_enterprise AND oocql001 = '238' AND oocql003 = g_dlang
#       #dorislai-20150806-add----(S)
#       #----先抓稅區
#       LET l_ooef019 = ''
#       SELECT ooef019 INTO l_ooef019 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
#       #詢價人員全名 l_pmdf002_ref		
#       LET sr.l_pmdf002_ref = ''
#       SELECT ooag011 INTO sr.l_pmdf002_ref FROM ooag_t 
#        WHERE ooagent = g_enterprise AND ooag001 = sr.pmdf002 
#       #詢價部門全名 l_pmdf003_ref		
#       LET sr.l_pmdf003_ref = ''
#       SELECT ooefl003 INTO sr.l_pmdf003_ref FROM ooefl_t 
#        WHERE ooeflent = g_enterprise AND ooefl001 = sr.pmdf003 AND ooefl002 = g_dlang
#       #供應商全名 l_pmdf004desc		
#       LET sr.l_pmdf004_desc = ''
#       LET sr.l_pmdf004desc = ''
#       SELECT pmaal004 INTO sr.l_pmdf004_desc FROM pmaal_t 
#        WHERE pmaalent = g_enterprise AND pmaal001 = sr.pmdf004 AND pmaal002 = g_dlang
#       IF NOT cl_null(sr.l_pmdf004_desc) THEN
#          LET sr.l_pmdf004desc = sr.pmdf004,'.',sr.l_pmdf004_desc
#       END IF
#       #幣別全名 l_pmdf005desc		
#       LET sr.l_pmdf005_desc = ''
#       LET sr.l_pmdf005desc = ''
#       SELECT ooail003 INTO sr.l_pmdf005_desc FROM ooail_t 
#        WHERE ooailent = g_enterprise AND ooail001 = sr.pmdf005 AND ooail002 = g_dlang
#       IF NOT cl_null(sr.l_pmdf005_desc) THEN
#          LET sr.l_pmdf005desc = sr.pmdf005,'.',sr.l_pmdf005_desc
#       END IF
#       #稅別全名 l_pmdf006desc		chk
#       LET sr.l_pmdf006_desc = ''
#       LET sr.l_pmdf006desc = ''
#       SELECT oodbl004 INTO sr.l_pmdf006_desc FROM oodbl_t 
#        WHERE oodblent = g_enterprise AND oodbl001 = l_ooef019
#          AND oodbl002 = sr.pmdf006 AND oodbl003 = g_dlang
#       IF NOT cl_null(sr.l_pmdf006_desc) THEN
#          LET sr.l_pmdf006desc = sr.pmdf006,'.',sr.l_pmdf006_desc
#       END IF
#       #付款條件全名 l_pmdf009desc		
#       LET sr.l_pmdf009_desc = ''
#       LET sr.l_pmdf009desc = ''
#       SELECT ooibl004 INTO sr.l_pmdf009_desc FROM ooibl_t 
#        WHERE ooiblent = g_enterprise AND ooibl002 = sr.pmdf009 AND ooibl003 = g_dlang
#       IF NOT cl_null(sr.l_pmdf009_desc) THEN
#          LET sr.l_pmdf009desc = sr.pmdf009,'.',sr.l_pmdf009_desc
#       END IF
#       #交易條件全名 l_pmdf010desc		
#       LET sr.l_pmdf010_desc = ''
#       LET sr.l_pmdf010desc = ''
#       SELECT oocql004 INTO sr.l_pmdf010_desc FROM oocql_t 
#        WHERE oocqlent = g_enterprise AND oocql001 = '238' 
#          AND oocql002 = sr.pmdf010 AND oocql003 = g_dlang
#       IF NOT cl_null(sr.l_pmdf010_desc) THEN
#          LET sr.l_pmdf010desc = sr.pmdf010,'.',sr.l_pmdf010_desc
#       END IF
#       #詢價單號全名 l_pmdfdocnodesc 	
#       LET sr.l_pmdfdocno_desc = ''
#       LET sr.l_pmdfdocnodesc = ''
#       CALL s_aooi200_get_slip_desc(sr.pmdfdocno) RETURNING sr.l_pmdfdocno_desc
#       IF NOT cl_null(sr.l_pmdfdocno_desc) THEN
#          LET sr.l_pmdfdocnodesc = sr.pmdfdocno,'.',sr.l_pmdfdocno_desc
#       END IF
#       #狀態碼全名 l_pmdfstusdesc		
#       LET sr.l_pmdfstus_desc = ''
#       LET sr.l_pmdfstusdesc = ''
#       CALL s_desc_gzcbl004_desc('13',sr.pmdfstus) RETURNING sr.l_pmdfstus_desc
#       IF NOT cl_null(sr.l_pmdfstus_desc) THEN
#          LET sr.l_pmdfstusdesc = sr.pmdfstus,'.',sr.l_pmdfstus_desc
#       END IF
#       #供應商簡稱 l_pmdg002_ref	
#       LET sr.l_pmdg002_ref = ''
#       SELECT pmaal004 INTO sr.l_pmdg002_ref FROM pmaal_t 
#        WHERE pmaalent = g_enterprise AND pmaal001 = sr.pmdg002 AND pmaal002 = g_dlang
    #151106-00004#12-mark-(E)
       #產品特徵全名 l_pmdg004desc	
       LET sr.l_pmdg004_desc = ''
       LET sr.l_pmdg004_desc1 = ''
       CALL s_feature_description(sr.pmdg003,sr.pmdg004) RETURNING l_success,sr.l_pmdg004_desc
       IF NOT cl_null(sr.l_pmdg004_desc) THEN
          LET sr.l_pmdg004_desc1 = sr.pmdg004,'.',sr.l_pmdg004_desc
       END IF
    #151106-00004#12-mark-(S)
#       #品名(包裝容器) l_pmdg005desc	
#       LET sr.l_pmdg005_desc = ''
#       LET sr.l_pmdg005desc = ''
#       SELECT imaal003 INTO sr.l_pmdg005_desc FROM imaal_t 
#        WHERE imaalent = g_enterprise AND imaal001 = sr.pmdg005 AND imaal002 = g_dlang
#       IF NOT cl_null(sr.l_pmdg005_desc) THEN
#          LET sr.l_pmdg005desc = sr.pmdg005,'.',sr.l_pmdg005_desc
#       END IF
#       #運輸方式全名 l_pmdg016desc	
#       LET sr.l_pmdg016_desc = ''
#       LET sr.l_pmdg016desc = ''
#       SELECT oocql004 INTO sr.l_pmdg016_desc FROM oocql_t 
#        WHERE oocqlent = g_enterprise AND oocql001='263' AND oocql002 = sr.pmdg016 AND oocql003 = g_dlang
#       IF NOT cl_null(sr.l_pmdg016_desc) THEN
#          LET sr.l_pmdg016desc = sr.pmdg016,'.',sr.l_pmdg016_desc
#       END IF
#       #稅別全名 l_pmdg018desc	
#       LET sr.l_pmdg018_desc = ''       
#       LET sr.l_pmdg018desc = ''
#       SELECT oodbl004 INTO sr.l_pmdg018_desc FROM oodbl_t 
#        WHERE oodblent = g_enterprise AND oodbl001 = l_ooef019 
#          AND oodbl002 = sr.pmdg018 AND oodbl003 = g_dlang
#       IF NOT cl_null(sr.l_pmdg018_desc) THEN
#          LET sr.l_pmdg018desc = sr.pmdg018,'.',sr.l_pmdg018_desc
#       END IF
#       #系列全名 l_imaa127desc
#       LET sr.l_imaa127_desc = ''
#       LET sr.l_imaa127desc = ''
#          #用料號抓取系列
#       SELECT imaa127 INTO sr.l_imaa127 FROM imaa_t
#        WHERE imaa001 = sr.pmdg003
#          AND imaaent = g_enterprise
#         #抓取系列說明
#       CALL s_desc_get_acc_desc('2003',sr.l_imaa127)  RETURNING sr.l_imaa127_desc   
#       IF NOT cl_null(sr.l_imaa127_desc) THEN
#          LET sr.l_imaa127desc = sr.l_imaa127,'.',sr.l_imaa127_desc
#       END IF
#       #dorislai-20150806-add----(E)
   #151106-00004#12-mark-(E)
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.pmdfdocno,sr.pmdfdocdt,sr.pmdg002,sr.l_pmdg002_desc,sr.l_pmdg002_pmaal004,sr.l_pmaa080_desc,sr.pmdf002,sr.l_pmdf002_desc,sr.l_pmdf002_ooag011,sr.pmdf003,sr.l_pmdf003_desc,sr.l_pmdf003_ooefl003,sr.pmdf005,sr.l_pmdf005_desc,sr.l_pmdf005_ooail003,sr.pmdf006,sr.l_pmdf006_desc,sr.l_pmdf006_oodbl004,sr.pmdf009,sr.l_pmdf009_desc,sr.l_pmdf009_ooibl004,sr.pmdf010,sr.l_pmdf010_desc,sr.l_pmdf010_oocql004,sr.l_imaa009_desc,sr.pmdg003,sr.imaal_t_imaal003,sr.imaal_t_imaal004,sr.pmdg004,sr.l_pmdg004_desc,sr.l_pmdg004_desc1,sr.l_imaa127,sr.l_imaa127_desc,sr.l_imaa127_oocql004,sr.pmdg008,sr.pmdg007,sr.pmdg010,sr.pmdg013,sr.pmdg012,sr.pmdg017,sr.pmdf004,sr.l_pmdf004_desc,sr.l_pmdf004_pmaal004,sr.pmdf007,sr.pmdf030,sr.pmdfstus,sr.l_pmdfstus_desc,sr.l_pmdfstus_gzcbl004,sr.pmdg005,sr.l_pmdg005_desc,sr.l_pmdg005_imaal003,sr.pmdg009,sr.pmdg011,sr.pmdg016,sr.l_pmdg016_desc,sr.l_pmdg016_oocql004,sr.pmdg018,sr.l_pmdg018_desc,sr.l_pmdg018_oodbl004,sr.pmdg030,sr.pmdgseq
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "apmr421_x01_execute"
          LET g_errparam.code   = SQLCA.sqlcode
          LET g_errparam.popup  = FALSE
          CALL cl_err()       
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF
 
       #add-point:ins_data段after_save name="ins_data.after.save"
       
       #end add-point
       
    END FOREACH
    
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apmr421_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION apmr421_x01_rep_data()
#add-point:rep_data.define (客製用) name="rep_data.define_customerization"

#end add-point:rep_data.define
#add-point:rep_data.define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="rep_data.define"

#end add-point:rep_data.define
 
    #add-point:rep_data.before name="rep_data.before"
    
    #end add-point:rep_data.before
    
    CALL cl_xg_view()
    #add-point:rep_data.after name="rep_data.after"
    
    #end add-point:rep_data.after
END FUNCTION
 
{</section>}
 
{<section id="apmr421_x01.other_function" readonly="Y" >}

 
{</section>}
 
