#該程式未解開Section, 採用最新樣板產出!
{<section id="apmr004_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:12(2016-12-21 12:20:17), PR版次:0012(2016-12-29 11:37:36)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000167
#+ Filename...: apmr004_x01
#+ Description: ...
#+ Creator....: 05231(2014-06-04 15:22:55)
#+ Modifier...: 01534 -SD/PR- 01534
 
{</section>}
 
{<section id="apmr004_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#160328-00011#2  2016/03/28  By  dorislai  效能改善
#160411-00027#7  2016/04/13  By  dorislai  效能改善：欄位減少、說明寫成Sub-Query
#161207-00033#22 2016/12/21  By lixh       一次性交易對象顯示說明，所有的客戶/供應商欄位都應該處理
#end add-point
#add-point:填寫註解說明 name="global.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../cfg/top_report.inc"                  #報表使用的global
 
#報表 type 宣告
DEFINE tm RECORD
       wc STRING,                  #where condition 
       a1 LIKE type_t.chr1          #多庫儲批明細
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="apmr004_x01.main" readonly="Y" >}
PUBLIC FUNCTION apmr004_x01(p_arg1,p_arg2)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr1         #tm.a1  多庫儲批明細
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.a1 = p_arg2
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "apmr004_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL apmr004_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL apmr004_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL apmr004_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL apmr004_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL apmr004_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="apmr004_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION apmr004_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "pmdsdocno.pmds_t.pmdsdocno,pmdsdocdt.pmds_t.pmdsdocdt,l_pmds000_desc.type_t.chr100,pmds011.pmds_t.pmds011,l_pmds011_desc.type_t.chr100,pmdsstus.pmds_t.pmdsstus,l_pmdsstus_desc.type_t.chr100,l_pmds002_desc.ooag_t.ooag011,l_pmds003_desc.ooefl_t.ooefl003,l_pmds007_desc.pmaal_t.pmaal004,l_pmds008_desc.pmaal_t.pmaal004,pmdtseq.pmdt_t.pmdtseq,pmds006.pmds_t.pmds006,pmdt002.pmdt_t.pmdt002,l_pmdt005_desc.type_t.chr30,pmdt006.pmdt_t.pmdt006,x_t6_imaal003.imaal_t.imaal003,x_t6_imaal004.imaal_t.imaal004,pmdt007.pmdt_t.pmdt007,l_imaa127_desc.type_t.chr50,pmdt020.pmdt_t.pmdt020,pmdt019.pmdt_t.pmdt019,pmdt022.pmdt_t.pmdt022,pmdt021.pmdt_t.pmdt021,pmdt024.pmdt_t.pmdt024,pmdt023.pmdt_t.pmdt023,pmdt036.pmdt_t.pmdt036,pmdt038.pmdt_t.pmdt038,pmdt039.pmdt_t.pmdt039,pmdt016.pmdt_t.pmdt016,l_pmdt016_desc.type_t.chr100,pmdt017.pmdt_t.pmdt017,l_pmdt017_desc.type_t.chr100,pmdt018.pmdt_t.pmdt018,pmdt059.pmdt_t.pmdt059,pmds002.pmds_t.pmds002,pmds003.pmds_t.pmds003,pmds007.pmds_t.pmds007,pmds008.pmds_t.pmds008,pmdt063.pmdt_t.pmdt063,pmdt072.pmdt_t.pmdt072,pmdt073.pmdt_t.pmdt073,pmdt074.pmdt_t.pmdt074,l_pmdt072_desc.type_t.chr30,l_pmdt073_desc.type_t.chr30,l_pmdt074_desc.type_t.chr30,l_pmdt007_desc.type_t.chr100" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   #160411-00027#7-mod-(S)
#   LET g_sql = "pmdu006.type_t.chr100,",
#               "pmdu007.type_t.chr100,",
   LET g_sql = "pmdu006.pmdu_t.pmdu006,",
               "pmdu006_desc.inayl_t.inayl003,",
               "pmdu007.pmdu_t.pmdu007,",
               "pmdu007_desc.inab_t.inab003,",
   #160411-00027#7-mod-(E)            
               "pmdu008.pmdu_t.pmdu008,",
               "pmdu010.pmdu_t.pmdu010,",
               "pmdu009.pmdu_t.pmdu009,",
               "pmdu012.pmdu_t.pmdu012,",
               "pmdu011.pmdu_t.pmdu011,",
               "pmdudocno.pmdu_t.pmdudocno,",
               "pmduseq.pmdu_t.pmduseq"
   IF NOT cl_xg_create_tmptable(g_sql,2) THEN
      LET g_rep_success = 'N'
   END IF

   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="apmr004_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION apmr004_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
         WHEN 2
         #160411-00027#7-mod-(S)
#         LET g_sql = " INSERT INTO ",g_rep_db CLIPPED,g_rep_tmpname[2] CLIPPED," VALUES(?,?,?,?,?, ?,?,?,?)"
         LET g_sql = " INSERT INTO ",g_rep_db CLIPPED,g_rep_tmpname[2] CLIPPED," VALUES(?,?,?,?,?, ?,?,?,?,?,?)"
         #160411-00027#7-mod-(E)
         PREPARE insert_prep1 FROM g_sql
         IF STATUS THEN
            LET l_prep_str ="insert_prep1",i
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_prep_str
            LET g_errparam.code   = status
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            CALL cl_xg_drop_tmptable()
            LET g_rep_success = 'N'
         END IF
         #end add-point                  
 
 
      END CASE
   END FOR
END FUNCTION
 
{</section>}
 
{<section id="apmr004_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apmr004_x01_sel_prep()
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
   #160328-00011#2-mod-(S)
#   #151106-00004#1 20151109 add by beckxie---S
#   LET g_select = " SELECT UNIQUE pmdsdocno,pmdsdocdt,pmds000,t8.gzcbl004,pmds011, ",
#                  " t9.gzcbl004,pmdsstus,t10.gzcbl004,trim(pmds002)||'.'||trim(ooag_t.ooag011),trim(pmds003)||'.'||trim(ooefl_t.ooefl003), ",
#                  " trim(pmds007)||'.'||trim(pmaal_t.pmaal004),trim(pmds008)||'.'||trim(t2.pmaal004),trim(pmds009)||'.'||trim(t3.pmaal004),trim(pmds012)||'.'||trim(t4.oocql004),trim(pmds013)||'.'||trim(t1.oocql004), ",
#                  " pmdsent,pmdssite,pmdtseq,pmds006,x.pmdt002, ",
#                  " x.pmdt005,x.t11_gzcbl004,trim(x.imaa009)||'.'||trim(x.t12_rtaxl003),x.imaf141,x.pmdt006, ",
#                  " x.t6_imaal003,x.t6_imaal004,x.pmdt007,x.imaa127,x.t14_oocql004, ",
#                  " trim(x.imaa127)||'.'||trim(x.t14_oocql004),x.pmdt020,x.pmdt019,x.pmdt022,x.pmdt021, ",
#                  " x.pmdt024,x.pmdt023,x.pmdt036,x.pmdt038,x.pmdt039, ",
#                  " x.pmdt047,x.pmdt016,trim(x.pmdt016)||'.'||trim(x.t15_inayl003),x.pmdt017,trim(x.pmdt017)||'.'||trim(t32.inab003), ",
#                  " x.pmdt018,x.pmdt059,pmds002,pmds003,pmds007, ",
#                  " pmds008,pmds009,pmds010,pmds012,pmds014, ",
#                  " pmds021,pmds022,pmds023,pmds024,pmds031, ",
#                  " pmds032,pmds033,pmds034/100,pmds035,pmds036, ",
#                  " pmds037,pmds038,pmds039,pmds040,pmds041, ",
#                  " pmds042,pmds045,pmds047,pmds048,pmds049, ",
#                  " pmds050,pmds052,pmds053,x.pmdt001,x.pmdt003, ",
#                  " x.pmdt004,x.pmdt011,x.pmdt025,x.pmdt026,x.pmdt041, ",
#                  " x.pmdt051,x.pmdt053,x.pmdt054,x.pmdt055,x.pmdt060, ",
#                  " x.pmdt061,x.pmdt062,x.pmdt063,x.pmdt072,x.pmdt073, ",
#                  " x.pmdt074,x.pmdt088,x.pmdt089,ooag_t.ooag011,ooefl_t.ooefl003, ",
#                  " pmaal_t.pmaal004,t2.pmaal004,t3.pmaal004,t4.oocql004,t16.gzcbl004, ",
#                  " ooibl_t.ooibl004,oocql_t.oocql004,t18.oodbl004,t19.gzcbl004,t20.ooail003, ",
#                  " t21.pmaml003,t22.ooidl003,t23.gzcbl004,t24.gzcbl004,'', ",
#                  " t25.icaal003,x.t26_gzcbl004,t35.oocql004,t29_pjbal003,x.t30_pjbbl004, ",
#                  " x.t31_pjbml004,x.t15_inayl003,t32.inab003,trim(pmds007)||'.'||trim(pmaal_t.pmaal004),trim(pmds008)||'.'||trim(t2.pmaal004), ",
#                  " trim(pmds009)||'.'||trim(t3.pmaal004),trim(pmds011)||'.'||trim(t9.gzcbl004),trim(pmds012)||'.'||trim(t4.oocql004),trim(pmds014)||'.'||trim(t16.gzcbl004),trim(pmds031)||'.'||trim(ooibl_t.ooibl004), ",
#                  " trim(pmds032)||'.'||trim(oocql_t.oocql004),trim(pmds033)||'.'||trim(t18.oodbl004),trim(pmds036)||'.'||trim(t19.gzcbl004),trim(pmds037)||'.'||trim(t20.ooail003),trim(pmds039)||'.'||trim(t21.pmaml003), ",
#                  " trim(pmds040)||'.'||trim(t22.ooidl003),trim(pmds048)||'.'||trim(t23.gzcbl004),trim(pmds049)||'.'||trim(t24.gzcbl004),trim(pmds053)||'.'||trim(t25.icaal003),NULL, ",
#                  " trim(pmdsstus)||'.'||trim(t10.gzcbl004),trim(x.pmdt005)||'.'||trim(x.t11_gzcbl004),trim(x.pmdt025)||'.'||trim(x.t26_gzcbl004),trim(x.pmdt051)||'.'||trim(t35.oocql004),trim(x.pmdt072)||'.'||trim(x.t29_pjbal003), ",
#                  " trim(x.pmdt073)||'.'||trim(x.t30_pjbbl004),trim(x.pmdt074)||'.'||trim(x.t31_pjbml004),'','' "
#   #151106-00004#1 20151109 add by beckxie---E
   #===160411-00027#7-mod-(S)
#   LET g_select = " SELECT UNIQUE pmdsdocno,pmdsdocdt,pmds000,t8.gzcbl004,pmds011, ",
#                  " t9.gzcbl004,pmdsstus,t10.gzcbl004,ooag_t.ooag011,ooefl_t.ooefl003,",
#                  " pmaal_t.pmaal004,t2.pmaal004,t3.pmaal004,t4.oocql004,t1.oocql004, ",
#                  " pmdsent,pmdssite,pmdtseq,pmds006,x.pmdt002,x.pmdt005,x.t11_gzcbl004, ",
#                  " x.t12_rtaxl003,x.t13_oocql004,x.pmdt006,x.t6_imaal003,x.t6_imaal004,x.pmdt007, ",
#                  " x.t14_oocql004,x.pmdt020,x.pmdt019,x.pmdt022,x.pmdt021,x.pmdt024,x.pmdt023, ",
#                  " x.pmdt036,x.pmdt038,x.pmdt039,x.pmdt047,x.pmdt016,x.t15_inayl003,x.pmdt017, ",
#                  " t32.inab003,x.pmdt018,x.pmdt059,pmds002,pmds003,pmds007,pmds008,pmds009, ",
#                  " pmds010,pmds012,pmds014,pmds021,pmds022,pmds023,pmds024,pmds031, ",
#                  " pmds032,pmds033,pmds034/100,pmds035,pmds036,pmds037,pmds038,pmds039,pmds040, ",
#                  " pmds041,pmds042,pmds045,pmds047,pmds048,pmds049,pmds050,pmds052, ",
#                  " pmds053,x.pmdt001,x.pmdt003,x.pmdt004,x.pmdt011,x.pmdt025,x.pmdt026, ",
#                  " x.pmdt041,x.pmdt051,x.pmdt053,x.pmdt054,x.pmdt055,x.pmdt060, ",
#                  " x.pmdt061,x.pmdt062,x.pmdt063,x.pmdt072,x.pmdt073,x.pmdt074, ",
#                  " x.pmdt088,x.pmdt089,t4.oocql004,t16.gzcbl004,ooibl_t.ooibl004,",
#                  " oocql_t.oocql004,t18.oodbl004,t19.gzcbl004,t20.ooail003, ",
#                  " t21.pmaml003,t22.ooidl003,t23.gzcbl004,t24.gzcbl004,'', ",
#                  " t25.icaal003,x.t26_gzcbl004,t35.oocql004,t29_pjbal003,x.t30_pjbbl004, ",
#                  " x.t31_pjbml004,''"
#   #160328-00011#2-mod-(E)
   LET g_select = " SELECT UNIQUE pmdsdocno,pmdsdocdt,pmds000,
                   (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001='2060' AND gzcbl002=pmds000 AND gzcbl003='",g_dlang,"') S1_gzcbl004,
                    pmds011, 
                   (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001='2061' AND gzcbl002=pmds011 AND gzcbl003='",g_dlang,"') S2_gzcbl004,
                    pmdsstus,
                   (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001='13' AND gzcbl002=pmdsstus AND gzcbl003='",g_dlang,"') S3_gzcbl004,
                   (SELECT ooag011 FROM ooag_t WHERE ooagent = pmdsent AND ooag001 = pmds002) ooag011,
                   (SELECT ooefl003 FROM ooefl_t WHERE ooeflent = pmdsent AND ooefl001 = pmds003 AND ooefl002 = '",g_dlang,"') ooefl003,
                   (SELECT pmaal004 FROM pmaal_t WHERE pmaalent = pmdsent AND pmaal001 = pmds007 AND pmaal002 = '",g_dlang,"') B1_pmaal004,
                   (SELECT pmaal004 FROM pmaal_t WHERE pmaalent = pmdsent AND pmaal001 = pmds008 AND pmaal002 = '",g_dlang,"') B2_pmaal004,
                    pmdsent,pmdssite,pmdtseq,pmds006,pmdt002,
                   (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001='2055' AND gzcbl002=pmdt005 AND gzcbl003='",g_dlang,"') S4_gzcbl004,
                    pmdt006,
                   (SELECT imaal003 FROM imaal_t WHERE imaalent = pmdtent AND imaal001 = pmdt006 AND imaal002 = '",g_dlang,"') imaal003,
                   (SELECT imaal004 FROM imaal_t WHERE imaalent = pmdtent AND imaal001 = pmdt006 AND imaal002 = '",g_dlang,"') imaal004,
                    pmdt007, 
                   (SELECT oocql004 FROM oocql_t WHERE oocql001='2003' AND oocql002=x.imaa127 AND oocql003='",g_dlang," AND oocqlent=pmdtent') A1_oocql004,
                   (pmdt020*NVL(gzcb004,1)),pmdt019,(pmdt022*NVL(gzcb004,1)),pmdt021,(pmdt024*NVL(gzcb004,1)),pmdt023, 
                    pmdt036,(pmdt038*NVL(gzcb004,1)),(pmdt039*NVL(gzcb004,1)),pmdt016,
                   (SELECT inayl003 FROM inayl_t WHERE inaylent=pmdtent AND inayl001=pmdt016 AND inayl002='",g_dlang,"') inayl003,
                    pmdt017, 
                   (SELECT inab003 FROM inab_t WHERE inabent = pmdtent AND inabsite = pmdtsite AND inab001 = pmdt016 AND inab002 =pmdt017) inab003, 
                    pmdt018,pmdt059,pmds002,pmds003,pmds007,pmds008,
                    pmdt063,pmdt072,pmdt073,pmdt074, 
                   (SELECT pjbal003 FROM pjbal_t WHERE pjbalent = pmdtent AND pjbal001 = pmdt072 AND pjbal002 = '",g_dlang,"') pjbal003,
                   (SELECT pjbbl004 FROM pjbbl_t WHERE pjbblent = pmdtent AND pjbbl001 = pmdt072 AND pjbbl002 = pmdt073 AND pjbbl003 = '",g_dlang,"') pjbbl004,
                   (SELECT pjbml004 FROM pjbml_t WHERE pjbmlent = pmdtent AND pjbml001 = pmdt072 AND pjbml002 =  pmdt074 AND pjbml003 = '",g_dlang,"') pjbml004,
                   (SELECT inaml004 FROM inaml_t WHERE inamlent=pmdtent AND inaml001=pmdt006 AND inaml002=pmdt007 AND inaml003='",g_dlang,"') inaml004 "
   #===160411-00027#7-mod-(E)
#   #end add-point
#   LET g_select = " SELECT pmdsdocno,pmdsdocdt,pmds000,'',pmds011,'',pmdsstus,'',NULL,'','','',pmdsent, 
#       pmdssite,pmdtseq,pmds006,pmdt002,'',pmdt006,x.t6_imaal003,x.t6_imaal004,pmdt007,'',pmdt020,pmdt019, 
#       pmdt022,pmdt021,pmdt024,pmdt023,pmdt036,pmdt038,pmdt039,pmdt016,'',pmdt017,'',pmdt018,pmdt059, 
#       pmds002,pmds003,pmds007,pmds008,pmdt063,pmdt072,pmdt073,pmdt074,'','','',''"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
    #151106-00004#1 20151109 mark by beckxie---S
    #LET g_from = " FROM pmds_t LEFT OUTER JOIN ooag_t ON ooag_t.ooag001 = pmds_t.pmds002 AND ooag_t.ooagent = pmds_t.pmdsent             LEFT OUTER JOIN ooidl_t ON ooidl_t.ooidl001 = pmds_t.pmds040 AND ooidl_t.ooidlent = pmds_t.pmdsent AND ooidl_t.ooidl002 = '" , 
    #    g_dlang,"'" ,"             LEFT OUTER JOIN pmaml_t ON pmaml_t.pmaml001 = pmds_t.pmds039 AND pmaml_t.pmamlent = pmds_t.pmdsent AND pmaml_t.pmaml002 = '" , 
    #    g_dlang,"'" ,"             LEFT OUTER JOIN ooail_t ON ooail_t.ooail001 = pmds_t.pmds037 AND ooail_t.ooailent = pmds_t.pmdsent AND ooail_t.ooail002 = '" , 
    #    g_dlang,"'" ,"             LEFT OUTER JOIN oocql_t ON oocql_t.oocql001 = '238' AND oocql_t.oocql002 = pmds_t.pmds032 AND oocql_t.oocqlent = pmds_t.pmdsent AND oocql_t.oocql003 = '" , 
    #    g_dlang,"'" ,"             LEFT OUTER JOIN ooibl_t ON ooibl_t.ooibl002 = pmds_t.pmds031 AND ooibl_t.ooiblent = pmds_t.pmdsent AND ooibl_t.ooibl003 = '" , 
    #    g_dlang,"'" ,"             LEFT OUTER JOIN oocql_t t1 ON t1.oocql001 = '275' AND t1.oocql002 = pmds_t.pmds013 AND t1.oocqlent = pmds_t.pmdsent AND t1.oocql003 = '" , 
    #    g_dlang,"'" ,"             LEFT OUTER JOIN ooefl_t ON ooefl_t.ooefl001 = pmds_t.pmds003 AND ooefl_t.ooeflent = pmds_t.pmdsent AND ooefl_t.ooefl002 = '" , 
    #    g_dlang,"'" ,"             LEFT OUTER JOIN pmaal_t ON pmaal_t.pmaal001 = pmds_t.pmds007 AND pmaal_t.pmaalent = pmds_t.pmdsent AND pmaal_t.pmaal002 = '" , 
    #    g_dlang,"'" ,"             LEFT OUTER JOIN pmaal_t t2 ON t2.pmaal001 = pmds_t.pmds008 AND t2.pmaalent = pmds_t.pmdsent AND t2.pmaal002 = '" , 
    #    g_dlang,"'" ,"             LEFT OUTER JOIN pmaal_t t3 ON t3.pmaal001 = pmds_t.pmds009 AND t3.pmaalent = pmds_t.pmdsent AND t3.pmaal002 = '" , 
    #    g_dlang,"'" ,"             LEFT OUTER JOIN oocql_t t4 ON t4.oocql001 = '275' AND t4.oocql002 = pmds_t.pmds012 AND t4.oocqlent = pmds_t.pmdsent AND t4.oocql003 = '" , 
    #    g_dlang,"'" ," LEFT OUTER JOIN ( SELECT pmdt_t.*,t6.imaal003 t6_imaal003,t6.imaal004 t6_imaal004,imaf_t.*,imaa_t.* FROM pmdt_t LEFT OUTER JOIN oocal_t ON oocal_t.oocal001 = pmdt_t.pmdt021 AND oocal_t.oocalent = pmdt_t.pmdtent AND oocal_t.oocal002 = '" , 
    #    g_dlang,"'" ,"             LEFT OUTER JOIN imaa_t ON imaa_t.imaa001 = pmdt_t.pmdt006 AND imaa_t.imaaent = pmdt_t.pmdtent         LEFT OUTER JOIN oocal_t t5 ON t5.oocal001 = pmdt_t.pmdt019 AND t5.oocalent = pmdt_t.pmdtent AND t5.oocal002 = '" , 
    #    g_dlang,"'" ,"             LEFT OUTER JOIN imaf_t ON imaf_t.imaf001 = pmdt_t.pmdt006 AND imaf_t.imafent = pmdt_t.pmdtent AND imaf_t.imafsite = '" , 
    #    g_site,"'" ,"             LEFT OUTER JOIN imaal_t ON imaal_t.imaal001 = pmdt_t.pmdt008 AND imaal_t.imaalent = pmdt_t.pmdtent AND imaal_t.imaal002 = '" , 
    #    g_dlang,"'" ,"             LEFT OUTER JOIN imaal_t t6 ON t6.imaal001 = pmdt_t.pmdt006 AND t6.imaalent = pmdt_t.pmdtent AND t6.imaal002 = '" , 
    #    g_dlang,"'" ,"             LEFT OUTER JOIN oocal_t t7 ON t7.oocal001 = pmdt_t.pmdt023 AND t7.oocalent = pmdt_t.pmdtent AND t7.oocal002 = '" , 
    #    g_dlang,"'" ,"             LEFT OUTER JOIN qcaol_t ON qcaol_t.qcaol002 = pmdt_t.pmdt083 AND qcaol_t.qcaolent = pmdt_t.pmdtent AND qcaol_t.qcaol003 = '" , 
    #    g_dlang,"'" ," ) x  ON pmds_t.pmdsent = x.pmdtent AND pmds_t.pmdsdocno = x.pmdtdocno"
    #151106-00004#1 20151109 mark by beckxie---E
    #160411-00027#7-mod-(S)
#    #151106-00004#1 20151109 add by beckxie---S
#    LET g_from = " FROM pmds_t ", 
#                 " LEFT OUTER JOIN gzcb_t ON gzcb001 = '2060' AND gzcb002 = pmds000", #160328-00011#2-add
#                 " LEFT OUTER JOIN ooag_t ON ooag_t.ooagent = pmds_t.pmdsent AND ooag_t.ooag001 = pmds_t.pmds002 ",
#                 " LEFT OUTER JOIN oocql_t ON oocql_t.oocqlent = pmds_t.pmdsent AND oocql_t.oocql001 = '238' AND oocql_t.oocql002 = pmds_t.pmds032 AND oocql_t.oocql003 = '",g_dlang,"' ",
#                 " LEFT OUTER JOIN ooibl_t ON ooibl_t.ooiblent = pmds_t.pmdsent AND ooibl_t.ooibl002 = pmds_t.pmds031 AND ooibl_t.ooibl003 = '",g_dlang,"' ",
#                 " LEFT OUTER JOIN oocql_t t1 ON t1.oocqlent = pmds_t.pmdsent AND t1.oocql001 = '275' AND t1.oocql002 = pmds_t.pmds013 AND  t1.oocql003 = '",g_dlang,"' ",
#                 " LEFT OUTER JOIN ooefl_t ON ooefl_t.ooeflent = pmds_t.pmdsent AND ooefl_t.ooefl001 = pmds_t.pmds003 AND ooefl_t.ooefl002 = '",g_dlang,"' ",
#                 " LEFT OUTER JOIN pmaal_t ON pmaal_t.pmaalent = pmds_t.pmdsent AND pmaal_t.pmaal001 = pmds_t.pmds007 AND pmaal_t.pmaal002 = '",g_dlang,"' ",          
#                 " LEFT OUTER JOIN pmaal_t t2 ON t2.pmaalent = pmds_t.pmdsent AND t2.pmaal001 = pmds_t.pmds008 AND t2.pmaal002 = '",g_dlang,"' ",
#                 " LEFT OUTER JOIN pmaal_t t3 ON t3.pmaalent = pmds_t.pmdsent AND t3.pmaal001 = pmds_t.pmds009 AND t3.pmaal002 = '",g_dlang,"' ",          
#                 " LEFT OUTER JOIN oocql_t t4 ON t4.oocqlent = pmds_t.pmdsent AND t4.oocql001 = '275' AND t4.oocql002 = pmds_t.pmds012 AND t4.oocql003 = '",g_dlang,"' ",
#                 " LEFT OUTER JOIN gzcbl_t t8 ON t8.gzcbl001='2060' AND t8.gzcbl002=pmds_t.pmds000 AND t8.gzcbl003='",g_dlang,"' ",
#                 " LEFT OUTER JOIN gzcbl_t t9 ON t9.gzcbl001='2061' AND t9.gzcbl002=pmds_t.pmds011 AND t9.gzcbl003='",g_dlang,"' ",
#                 " LEFT OUTER JOIN gzcbl_t t10 ON t10.gzcbl001='13' AND t10.gzcbl002=pmds_t.pmdsstus AND t10.gzcbl003='",g_dlang,"' ",
#                 " LEFT OUTER JOIN gzcbl_t t16 ON t16.gzcbl001='2053' AND t16.gzcbl002=pmds_t.pmds014 AND t16.gzcbl003='",g_dlang,"' ",
#                 " LEFT OUTER JOIN ooef_t t17 ON t17.ooefent = pmds_t.pmdsent AND t17.ooef001 =  pmds_t.pmdssite  ",
#                 " LEFT OUTER JOIN oodbl_t t18 ON t18.oodblent=  pmds_t.pmdsent AND t18.oodbl001=t17.ooef019 AND t18.oodbl002=pmds_t.pmds033 AND t18.oodbl003='",g_dlang,"' ",
#                 " LEFT OUTER JOIN gzcbl_t t19 ON t19.gzcbl001='2026' AND t19.gzcbl002=pmds_t.pmds036 AND t19.gzcbl003='",g_dlang,"' ",
#                 " LEFT OUTER JOIN ooail_t t20 ON t20.ooailent = pmds_t.pmdsent AND t20.ooail001 = pmds_t.pmds037 AND t20.ooail002 = '",g_dlang,"' ",
#                 " LEFT OUTER JOIN pmaml_t t21 ON t21.pmamlent = pmds_t.pmdsent AND t21.pmaml001 = pmds_t.pmds039 AND t21.pmaml002 = '",g_dlang,"' ",
#                 " LEFT OUTER JOIN ooidl_t t22 ON t22.ooidlent = pmds_t.pmdsent AND t22.ooidl001 = pmds_t.pmds040 AND t22.ooidl002 = '",g_dlang,"' ",
#                 " LEFT OUTER JOIN gzcbl_t t23 ON t23.gzcbl001='2087' AND t23.gzcbl002=pmds_t.pmds048 AND t23.gzcbl003='",g_dlang,"' ",
#                 " LEFT OUTER JOIN gzcbl_t t24 ON t24.gzcbl001='2086' AND t24.gzcbl002=pmds_t.pmds049 AND t24.gzcbl003='",g_dlang,"' ",
#                 " LEFT OUTER JOIN icaal_t t25 ON t25.icaalent=pmds_t.pmdsent AND t25.icaal001=pmds_t.pmds053 AND t25.icaal002='",g_dlang,"' ",
#                 " LEFT OUTER JOIN (  ",
#                 " SELECT pmdt_t.*,imaf_t.imaf141,imaa_t.imaa009,imaa_t.imaa127,t6.imaal003 t6_imaal003, ",
#                 "        t6.imaal004 t6_imaal004,t11.gzcbl004 t11_gzcbl004,t12.rtaxl003 t12_rtaxl003 ,t13.oocql004 t13_oocql004,t14.oocql004 t14_oocql004, ",
#                 "        t15.inayl003 t15_inayl003,t26.gzcbl004 t26_gzcbl004,t29.pjbal003 t29_pjbal003, ",
#                 "        t30.pjbbl004 t30_pjbbl004,t31.pjbml004 t31_pjbml004 ",
#                 "   FROM pmdt_t LEFT OUTER JOIN oocal_t ON oocal_t.oocal001 = pmdt_t.pmdt021 AND oocal_t.oocalent = pmdt_t.pmdtent AND oocal_t.oocal002 = '",g_dlang,"' ",       
#                 "   LEFT OUTER JOIN imaa_t ON imaa_t.imaaent = pmdt_t.pmdtent AND imaa_t.imaa001 = pmdt_t.pmdt006 ",
#                 "   LEFT OUTER JOIN oocal_t t5 ON t5.oocalent = pmdt_t.pmdtent AND t5.oocal001 = pmdt_t.pmdt019 AND t5.oocal002 = '",g_dlang,"' ",
#                 "   LEFT OUTER JOIN imaf_t ON imaf_t.imafent = pmdt_t.pmdtent AND imaf_t.imaf001 = pmdt_t.pmdt006 AND imaf_t.imafsite = '",g_site,"' ",
#                 "   LEFT OUTER JOIN imaal_t ON imaal_t.imaalent = pmdt_t.pmdtent AND imaal_t.imaal001 = pmdt_t.pmdt008 AND imaal_t.imaal002 = '",g_dlang,"' ",
#                 "   LEFT OUTER JOIN imaal_t t6 ON t6.imaalent = pmdt_t.pmdtent AND t6.imaal001 = pmdt_t.pmdt006 AND t6.imaal002 = '",g_dlang,"' ",
#                 "   LEFT OUTER JOIN oocal_t t7 ON t7.oocalent = pmdt_t.pmdtent AND t7.oocal001 = pmdt_t.pmdt023 AND t7.oocal002 = '",g_dlang,"' ",
#                 "   LEFT OUTER JOIN qcaol_t ON qcaol_t.qcaolent = pmdt_t.pmdtent AND qcaol_t.qcaol002 = pmdt_t.pmdt083 AND qcaol_t.qcaol003 = '",g_dlang,"' ",
#                 "   LEFT OUTER JOIN gzcbl_t t11 ON t11.gzcbl001='2055' AND t11.gzcbl002=pmdt_t.pmdt005 AND t11.gzcbl003='",g_dlang,"' ", 
#                 "   LEFT OUTER JOIN rtaxl_t t12 ON rtaxlent = pmdt_t.pmdtent AND rtaxl001 = imaa_t.imaa009 AND rtaxl002= '",g_dlang,"' ",
#                 "   LEFT OUTER JOIN oocql_t t13 ON t13.oocql001='203' AND t13.oocql002=imaf_t.imaf141 AND t13.oocql003='",g_dlang,"' ",
#                 "   LEFT OUTER JOIN oocql_t t14 ON t14.oocql001='2003' AND t14.oocql002=imaa_t.imaa127 AND t14.oocql003='",g_dlang,"' ",
#                 "   LEFT OUTER JOIN inayl_t t15 ON t15.inayl001=pmdt_t.pmdt016 AND t15.inayl002='",g_dlang,"' ",
#                 "   LEFT OUTER JOIN gzcbl_t t26 ON t26.gzcbl001='2036' AND t26.gzcbl002=pmdt_t.pmdt025 AND t26.gzcbl003='",g_dlang,"' ",
#                 "   LEFT OUTER JOIN pjbal_t t29 ON t29.pjbalent = pmdt_t.pmdtent AND t29.pjbal001 = pmdt_t.pmdt072 AND t29.pjbal002 = '",g_dlang,"' ",
#                 "   LEFT OUTER JOIN pjbbl_t t30 ON t30.pjbblent = pmdt_t.pmdtent AND t30.pjbbl001 = pmdt_t.pmdt072 AND t30.pjbbl002 = pmdt_t.pmdt073 AND t30.pjbbl003 = '",g_dlang,"' ",
#                 "   LEFT OUTER JOIN pjbml_t t31 ON t31.pjbmlent = pmdt_t.pmdtent AND t31.pjbml001 = pmdt_t.pmdt072 AND t31.pjbml002 =  pmdt_t.pmdt074 AND t31.pjbml003 = '",g_dlang,"' ",
#                 "   ) x   ",
#                 "   ON pmds_t.pmdsent = x.pmdtent AND pmds_t.pmdsdocno = x.pmdtdocno   ",
#                 "   LEFT OUTER JOIN inab_t t32 ON t32.inabent  = pmds_t.pmdsent AND t32.inabsite = pmds_t.pmdssite AND t32.inab001  = x.pmdt016 AND t32.inab002  =x.pmdt017 ",
#                 "   LEFT OUTER JOIN gzzz_t t33 ON t33.gzzz002='apmt520' AND t33.gzzz004=pmds_t.pmds000",
#                 "   LEFT OUTER JOIN gzcb_t t34 ON t34.gzcb001 = '24' AND t34.gzcb002 = t33.gzzz001 ",
#                 "   LEFT OUTER JOIN oocql_t t35 ON t35.oocqlent = pmds_t.pmdsent AND t35.oocql001 = t34.gzcb004 AND t35.oocql002 = x.pmdt051 AND t35.oocql003 = '",g_dlang,"' "
#    #151106-00004#1 20151109 add by beckxie---E
    LET g_from = " FROM pmds_t ", 
                 " LEFT OUTER JOIN gzcb_t ON gzcb001 = '2060' AND gzcb002 = pmds000",
                 " LEFT OUTER JOIN (SELECT pmdt_t.*,imaa_t.*,imaf141",
                 "   FROM pmdt_t ",
                 "   LEFT OUTER JOIN imaa_t ON imaa_t.imaaent = pmdt_t.pmdtent AND imaa_t.imaa001 = pmdt_t.pmdt006 ",
                 "   LEFT OUTER JOIN imaf_t ON imaf_t.imafent = pmdt_t.pmdtent AND imaf_t.imaf001 = pmdt_t.pmdt006 AND imaf_t.imafsite = '",g_site,"' ",
                 "   ) x   ",
                 "   ON pmds_t.pmdsent = x.pmdtent AND pmds_t.pmdsdocno = x.pmdtdocno   "
    #160411-00027#7-mod-(E)
#   #end add-point
#    LET g_from = " FROM pmds_t LEFT OUTER JOIN ( SELECT pmdt_t.*,( SELECT imaal003 FROM imaal_t WHERE imaal_t.imaal001 = pmdt_t.pmdt006 AND imaal_t.imaalent = pmdt_t.pmdtent AND imaal_t.imaal002 = '" , 
#        g_dlang,"'" ,") t6_imaal003,( SELECT imaal004 FROM imaal_t WHERE imaal_t.imaal001 = pmdt_t.pmdt006 AND imaal_t.imaalent = pmdt_t.pmdtent AND imaal_t.imaal002 = '" , 
#        g_dlang,"'" ,") t6_imaal004 FROM pmdt_t ) x  ON pmds_t.pmdsent = x.pmdtent AND pmds_t.pmdsdocno  
#        = x.pmdtdocno"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
 
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("pmds_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   DISPLAY "g_sql:",g_sql
   #end add-point
   PREPARE apmr004_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE apmr004_x01_curs CURSOR FOR apmr004_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="apmr004_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION apmr004_x01_ins_data()
DEFINE sr RECORD 
   pmdsdocno LIKE pmds_t.pmdsdocno, 
   pmdsdocdt LIKE pmds_t.pmdsdocdt, 
   pmds000 LIKE pmds_t.pmds000, 
   l_pmds000_desc LIKE type_t.chr100, 
   pmds011 LIKE pmds_t.pmds011, 
   l_pmds011_desc LIKE type_t.chr100, 
   pmdsstus LIKE pmds_t.pmdsstus, 
   l_pmdsstus_desc LIKE type_t.chr100, 
   l_pmds002_desc LIKE ooag_t.ooag011, 
   l_pmds003_desc LIKE ooefl_t.ooefl003, 
   l_pmds007_desc LIKE pmaal_t.pmaal004, 
   l_pmds008_desc LIKE pmaal_t.pmaal004, 
   pmdsent LIKE pmds_t.pmdsent, 
   pmdssite LIKE pmds_t.pmdssite, 
   pmdtseq LIKE pmdt_t.pmdtseq, 
   pmds006 LIKE pmds_t.pmds006, 
   pmdt002 LIKE pmdt_t.pmdt002, 
   l_pmdt005_desc LIKE type_t.chr30, 
   pmdt006 LIKE pmdt_t.pmdt006, 
   x_t6_imaal003 LIKE imaal_t.imaal003, 
   x_t6_imaal004 LIKE imaal_t.imaal004, 
   pmdt007 LIKE pmdt_t.pmdt007, 
   l_imaa127_desc LIKE type_t.chr50, 
   pmdt020 LIKE pmdt_t.pmdt020, 
   pmdt019 LIKE pmdt_t.pmdt019, 
   pmdt022 LIKE pmdt_t.pmdt022, 
   pmdt021 LIKE pmdt_t.pmdt021, 
   pmdt024 LIKE pmdt_t.pmdt024, 
   pmdt023 LIKE pmdt_t.pmdt023, 
   pmdt036 LIKE pmdt_t.pmdt036, 
   pmdt038 LIKE pmdt_t.pmdt038, 
   pmdt039 LIKE pmdt_t.pmdt039, 
   pmdt016 LIKE pmdt_t.pmdt016, 
   l_pmdt016_desc LIKE type_t.chr100, 
   pmdt017 LIKE pmdt_t.pmdt017, 
   l_pmdt017_desc LIKE type_t.chr100, 
   pmdt018 LIKE pmdt_t.pmdt018, 
   pmdt059 LIKE pmdt_t.pmdt059, 
   pmds002 LIKE pmds_t.pmds002, 
   pmds003 LIKE pmds_t.pmds003, 
   pmds007 LIKE pmds_t.pmds007, 
   pmds008 LIKE pmds_t.pmds008, 
   pmdt063 LIKE pmdt_t.pmdt063, 
   pmdt072 LIKE pmdt_t.pmdt072, 
   pmdt073 LIKE pmdt_t.pmdt073, 
   pmdt074 LIKE pmdt_t.pmdt074, 
   l_pmdt072_desc LIKE type_t.chr30, 
   l_pmdt073_desc LIKE type_t.chr30, 
   l_pmdt074_desc LIKE type_t.chr30, 
   l_pmdt007_desc LIKE type_t.chr100
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE sr1  RECORD
    #160411-00027#7-mod-(S)
#    pmdu006      LIKE type_t.chr100,
#    pmdu007      LIKE type_t.chr100,
    pmdu006      LIKE pmdu_t.pmdu006,
    pmdu006_desc      LIKE inayl_t.inayl003,
    pmdu007      LIKE pmdu_t.pmdu007,
    pmdu007_desc      LIKE inab_t.inab003,
    #160411-00027#7-mod-(E)
    pmdu008      LIKE pmdu_t.pmdu008,
    pmdu010      LIKE pmdu_t.pmdu010,
    pmdu009      LIKE pmdu_t.pmdu009,
    pmdu012      LIKE pmdu_t.pmdu012,
    pmdu011      LIKE pmdu_t.pmdu011,
    pmdudocno    LIKE pmdu_t.pmdudocno,
    pmduseq      LIKE pmdu_t.pmduseq
           END RECORD
DEFINE l_desc    LIKE type_t.chr100
DEFINE l_sql     STRING
DEFINE l_count   LIKE type_t.num5
DEFINE l_gzcb004 LIKE gzcb_t.gzcb004
DEFINE l_ooef019 LIKE ooef_t.ooef019 #稅區    dorislai-20150806-add----(S)
DEFINE l_success LIKE type_t.num5
DEFINE l_acc     LIKE gzcb_t.gzcb007 #        dorislai-20150806-add----(E)
DEFINE l_pmds028 LIKE pmds_t.pmds028 #161207-00033#22
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    #160411-00027#7-mod-(S)
#    #160328-00011#2-add-(S)
#    LET l_sql = " SELECT CASE inayl003 WHEN NULL THEN pmdu006 ELSE trim(pmdu006)||'.'||trim(inayl003) END, ",
#                "        CASE inab003 WHEN NULL THEN pmdu007 ELSE trim(pmdu007)||'.'||trim(inab003) END, ",
#                "        pmdu008,pmdu010,pmdu009,pmdu012,pmdu011,pmdudocno,pmduseq ",
#                "   FROM pmdu_t ",
#                "   LEFT OUTER JOIN inayl_t ON pmduent = inaylent AND pmdu006 = inayl001 AND inayl002 = '",g_dlang,"'",
#                "   LEFT OUTER JOIN inab_t ON pmduent = inabent AND pmdusite = inabsite AND pmdu006 = inab001 AND pmdu007 = inab002 ",
#                "  WHERE pmduent = ? ",
#                "    AND pmdudocno = ? ",
#                "    AND pmduseq = ? "
#
#    DECLARE apmr004_x01_repcur CURSOR FROM l_sql
#    #160328-00011#2-add-(E)
    LET l_sql = " SELECT pmdu006,",
                "        (SELECT inayl003 FROM inayl_t WHERE pmduent = inaylent AND pmdu006 = inayl001 AND inayl002 = '",g_dlang,"') inayl003,",
                "        pmdu007,",
                "        (SELECT inab003 FROM inab_t WHERE pmduent = inabent AND pmdusite = inabsite AND pmdu006 = inab001 AND pmdu007 = inab002) inab003, ",
                "        pmdu008,",
                "        (pmdu010*(SELECT NVL(gzcb004,1) FROM gzcb_t WHERE gzcb001 = '2060' AND gzcb002 = ?)) pmdu010,",
                "        pmdu009,pmdu012,pmdu011,pmdudocno,pmduseq ",
                "   FROM pmdu_t ",
                "  WHERE pmduent = ? ",
                "    AND pmdudocno = ? ",
                "    AND pmduseq = ? "

    DECLARE apmr004_x01_repcur CURSOR FROM l_sql
    #160411-00027#7-mod-(E)
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH apmr004_x01_curs INTO sr.*                               
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
       #161207-00033#22-S
       SELECT pmds028 INTO l_pmds028 FROM pmds_t
        WHERE pmdsent = g_enterprise
          AND pmdsdocno = sr.pmdsdocno
       IF NOT cl_null(l_pmds028) THEN
          CALL s_desc_get_oneturn_guest_desc(l_pmds028) RETURNING sr.l_pmds007_desc
       END IF
       #161207-00033#22-E
       #151106-00004#1 20151109 mark by beckxie---S
       ##子件特性
       #CALL s_desc_gzcbl004_desc('2055',sr.pmdt005) RETURNING sr.l_pmdt005_desc
       ##dorislai-20150806-add----(S)
       #LET sr.l_pmdt005desc = ''
       #IF NOT cl_null(sr.l_pmdt005_desc) THEN
       #   LET sr.l_pmdt005desc = sr.pmdt005,'.',sr.l_pmdt005_desc
       #END IF
       ##dorislai-20150806-add----(E)
       ##產品分類
       #SELECT imaa009 INTO sr.l_imaa009_rtaxl003 FROM imaa_t
       # WHERE imaaent = g_enterprise AND imaa001 = sr.pmdt006
       #CALL s_desc_get_rtaxl003_desc(sr.l_imaa009_rtaxl003) RETURNING l_desc
       #IF NOT cl_null(sr.l_imaa009_rtaxl003) AND NOT cl_null(l_desc) THEN
       #   LET sr.l_imaa009_rtaxl003 = sr.l_imaa009_rtaxl003,'.',l_desc
       #END IF
       ##採購分群
       #SELECT imaf141 INTO sr.l_imaf141_oocql004 FROM imaf_t
       # WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = sr.pmdt006
       #CALL s_desc_gzcbl004_desc('203',sr.l_imaf141_oocql004) RETURNING l_desc
       #IF NOT cl_null(sr.l_imaf141_oocql004) AND NOT cl_null(l_desc) THEN
       #   LET sr.l_imaf141_oocql004 = sr.l_imaf141_oocql004,'.',l_desc
       #END IF
       ##限定庫位
       #LET sr.l_pmdt016_desc = sr.pmdt016
       ##dorislai-20150806-modify----(S)
#      # CALL s_desc_get_stock_desc(sr.pmdssite,sr.pmdt016) RETURNING l_desc
#      # IF NOT cl_null(sr.l_pmdt016_desc) AND NOT cl_null(l_desc) THEN
#      #    LET sr.l_pmdt016_desc = sr.pmdt016,'.',l_desc
#      # END IF
       #CALL s_desc_get_stock_desc(sr.pmdssite,sr.pmdt016) RETURNING sr.l_pmdt016_ref
       #IF NOT cl_null(sr.l_pmdt016_desc) AND NOT cl_null(sr.l_pmdt016_ref) THEN
       #   LET sr.l_pmdt016_desc = sr.pmdt016,'.',sr.l_pmdt016_ref
       #END IF
       ##dorislai-20150806-modify----(E)
       ##限定儲位
       #LET sr.l_pmdt017_desc = sr.pmdt017
       ##dorislai-20150806-modify----(S)
#      # CALL s_desc_get_locator_desc(sr.pmdssite,sr.pmdt016,sr.pmdt017) RETURNING l_desc
#      # IF NOT cl_null(sr.l_pmdt017_desc) AND NOT cl_null(l_desc) THEN
#      #    LET sr.l_pmdt017_desc = sr.pmdt017,'.',l_desc
#      # END IF
       #CALL s_desc_get_locator_desc(sr.pmdssite,sr.pmdt016,sr.pmdt017) RETURNING sr.l_pmdt017_ref
       #IF NOT cl_null(sr.l_pmdt017_desc) AND NOT cl_null(sr.l_pmdt017_ref) THEN
       #   LET sr.l_pmdt017_desc = sr.pmdt017,'.',sr.l_pmdt017_ref
       #END IF
       ##dorislai-20150806-modify----(E)
       ##狀態碼
       #CALL s_desc_gzcbl004_desc('13',sr.pmdsstus) RETURNING sr.l_pmdsstus_desc
       ##dorislai-20150806-add----(S)
       #LET sr.l_pmdsstusdesc = ''
       #CALL s_desc_gzcbl004_desc('13',sr.pmdsstus) RETURNING sr.l_pmdsstus_desc
       #IF NOT cl_null(sr.l_pmdsstus_desc) THEN
       #   LET sr.l_pmdsstusdesc = sr.pmdsstus,'.',sr.l_pmdsstus_desc
       #END IF
       ##dorislai-20150806-add----(E)
       ##單據性質
       #CALL s_desc_gzcbl004_desc('2060',sr.pmds000) RETURNING sr.l_pmds000_desc
       ##採購性質
       #CALL s_desc_gzcbl004_desc('2061',sr.pmds011) RETURNING sr.l_pmds011_desc
       ##dorislai-20150806-add----(S)
       #LET sr.l_pmds011desc = ''
       #IF NOT cl_null(sr.l_pmds011_desc) THEN
       #   LET sr.l_pmds011desc = sr.pmds011,'.',sr.l_pmds011_desc
       #END IF
       ##dorislai-20150806-add----(E)   
       #151106-00004#1 20151109 mark by beckxie---E
       #160411-00027#7-mark-(S)
#       LET l_gzcb004 = 1
#       SELECT gzcb004 INTO l_gzcb004 FROM gzcb_t
#        WHERE gzcb001 = '2060'
#          AND gzcb002 = sr.pmds000
#       IF cl_null(l_gzcb004) THEN 
#          LET l_gzcb004 = 1 
#       END IF
#       LET sr.pmdt020 = sr.pmdt020 * l_gzcb004
#       LET sr.pmdt022 = sr.pmdt022 * l_gzcb004
#       LET sr.pmdt024 = sr.pmdt024 * l_gzcb004
#       LET sr.pmdt038 = sr.pmdt038 * l_gzcb004
#       LET sr.pmdt039 = sr.pmdt039 * l_gzcb004
#       LET sr.pmdt047 = sr.pmdt047 * l_gzcb004 
       #160411-00027#7-mark-(E)
       #151106-00004#1 20151109 mark by beckxie---S
       ##dorislai-20150806-add----(S)
       ##----稅區
       #LET l_ooef019 = ''
       #SELECT ooef019 INTO l_ooef019 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
       ##申請人員說明 l_pmds002_ref	
       #LET sr.l_pmds002_ref = ''
       #CALL s_desc_get_person_desc(sr.pmds002) RETURNING sr.l_pmds002_ref
       ##申請部門說明 l_pmds003_ref	
       #LET sr.l_pmds003_ref = ''
       #CALL s_desc_get_department_desc(sr.pmds003) RETURNING sr.l_pmds003_ref
       ##採購供應商全名 l_pmds007desc	
       #LET sr.l_pmds007_desc = ''
       #LET sr.l_pmds007desc = ''
       #SELECT pmaal004 INTO sr.l_pmds007_desc FROM pmaal_t 
       # WHERE pmaalent = g_enterprise AND pmaal001 = sr.pmds007 AND pmaal002 = g_dlang
       #IF NOT cl_null(sr.l_pmds007_desc) THEN
       #   LET sr.l_pmds007desc = sr.pmds007,'.',sr.l_pmds007_desc
       #END IF
       ##帳款供應商全名 l_pmds008desc
       #LET sr.l_pmds008_desc = ''       
       #LET sr.l_pmds008desc = ''
       #SELECT pmaal004 INTO sr.l_pmds008_desc FROM pmaal_t 
       # WHERE pmaalent = g_enterprise AND pmaal001 = sr.pmds008 AND pmaal002 = g_dlang
       #IF NOT cl_null(sr.l_pmds008_desc) THEN
       #   LET sr.l_pmds008desc = sr.pmds008,'.',sr.l_pmds008_desc
       #END IF
       ##送貨供應商全名 l_pmds009desc	
       #LET sr.l_pmds009_desc = ''
       #LET sr.l_pmds009desc = ''
       #SELECT pmaal004 INTO sr.l_pmds009_desc FROM pmaal_t 
       # WHERE pmaalent = g_enterprise AND pmaal001 = sr.pmds009 AND pmaal002 = g_dlang
       #IF NOT cl_null(sr.l_pmds009_desc) THEN
       #   LET sr.l_pmds009desc = sr.pmds009,'.',sr.l_pmds009_desc
       #END IF
       #
       ##採購通路全名 l_pmds012desc	
       #LET sr.l_pmds012_desc = ''
       #LET sr.l_pmds012desc = ''
       #CALL s_desc_get_acc_desc('275',sr.pmds012) RETURNING sr.l_pmds012_desc
       #IF NOT cl_null(sr.l_pmds012_desc) THEN
       #   LET sr.l_pmds012desc = sr.pmds012,'.',sr.l_pmds012_desc
       #END IF
       ##多角性質全名 l_pmds014desc	
       #LET sr.l_pmds014_desc = ''
       #LET sr.l_pmds014desc = ''
       #CALL s_desc_gzcbl004_desc('2053',sr.pmds014) RETURNING sr.l_pmds014_desc
       #IF NOT cl_null(sr.l_pmds014_desc) THEN
       #   LET sr.l_pmds014desc = sr.pmds014,'.',sr.l_pmds014_desc
       #END IF
       ##付款條件全名 l_pmds031desc	
       #LET sr.l_pmds031_desc = ''
       #LET sr.l_pmds031desc = ''
       #CALL s_desc_get_ooib002_desc(sr.pmds031) RETURNING sr.l_pmds031_desc
       #IF NOT cl_null(sr.l_pmds031_desc) THEN
       #   LET sr.l_pmds031desc = sr.pmds031,'.',sr.l_pmds031_desc
       #END IF
       ##交易條件全名 l_pmds032desc	
       #LET sr.l_pmds032_desc = ''
       #LET sr.l_pmds032desc = ''
       #CALL s_desc_get_acc_desc('238',sr.pmds032) RETURNING sr.l_pmds032_desc
       #IF NOT cl_null(sr.l_pmds032_desc) THEN
       #   LET sr.l_pmds032desc = sr.pmds032,'.',sr.l_pmds032_desc
       #END IF
       ##稅別全名 l_pmds033desc	
       #LET sr.l_pmds033_desc = ''
       #LET sr.l_pmds033desc = ''
       #CALL s_desc_get_tax_desc(l_ooef019,sr.pmds033) RETURNING sr.l_pmds033_desc
       #IF NOT cl_null(sr.l_pmds033_desc) THEN
       #   LET sr.l_pmds033desc = sr.pmds033,'.',sr.l_pmds033_desc
       #END IF
       ##交易類型全名 l_pmds036desc	
       #LET sr.l_pmds036_desc = ''
       #LET sr.l_pmds036desc = ''
       #CALL s_desc_gzcbl004_desc('2026',sr.pmds036) RETURNING sr.l_pmds036_desc 
       #IF NOT cl_null(sr.l_pmds036_desc) THEN
       #   LET sr.l_pmds036desc = sr.pmds036,'.',sr.l_pmds036_desc
       #END IF
       ##幣別全名 l_pmds037desc	
       #LET sr.l_pmds037_desc = ''
       #LET sr.l_pmds037desc = ''
       #CALL s_desc_get_currency_desc(sr.pmds037) RETURNING sr.l_pmds037_desc
       #IF NOT cl_null(sr.l_pmds037_desc) THEN 
       #   LET sr.l_pmds037desc = sr.pmds037,'.',sr.l_pmds037_desc
       #END IF
       ##取價方式全名 l_pmds039desc	
       #LET sr.l_pmds039_desc = ''
       #LET sr.l_pmds039desc = ''
       #CALL s_desc_get_price_type_desc(sr.pmds039) RETURNING sr.l_pmds039_desc
       #IF NOT cl_null(sr.l_pmds039_desc) THEN
       #   LET sr.l_pmds039desc = sr.pmds039,'.',sr.l_pmds039_desc
       #END IF
       ##付款優惠條件全名 l_pmds040desc	
       #LET sr.l_pmds040_desc = ''
       #LET sr.l_pmds040desc = ''
       #CALL s_desc_ooid001_desc(sr.pmds040) RETURNING sr.l_pmds040_desc
       #IF NOT cl_null(sr.l_pmds040_desc) THEN
       #   LET sr.l_pmds040desc = sr.pmds040,'.',sr.l_pmds040_desc
       #END IF
       ##內外購全名 l_pmds048desc	
       #LET sr.l_pmds048_desc = ''
       #LET sr.l_pmds048desc = ''
       #CALL s_desc_gzcbl004_desc('2087',sr.pmds048) RETURNING sr.l_pmds048_desc
       #IF NOT cl_null(sr.l_pmds048_desc) THEN
       #   LET sr.l_pmds048desc = sr.pmds048,'.',sr.l_pmds048_desc
       #END IF
       ##匯率計算基準全名 l_pmds049desc	
       #LET sr.l_pmds049_desc = ''
       #LET sr.l_pmds049desc = ''
       #CALL s_desc_gzcbl004_desc('2086',sr.pmds049) RETURNING sr.l_pmds049_desc
       #IF NOT cl_null(sr.l_pmds049_desc) THEN
       #   LET sr.l_pmds049desc = sr.pmds049,'.',sr.l_pmds049_desc
       #END IF
       ##多角流程代碼全名 l_pmds053desc	
       #LET sr.l_pmds053_desc = ''
       #LET sr.l_pmds053desc = ''
       #CALL s_desc_get_icaa001_desc(sr.pmds053) RETURNING sr.l_pmds053_desc
       #IF NOT cl_null(sr.l_pmds053_desc) THEN
       #   LET sr.l_pmds053desc = sr.pmds053,'.',sr.l_pmds053_desc
       #END IF
       #151106-00004#1 20151109 mark by beckxie---E
       #160328-00011#2-mark-(S)
       #單據單號全名 l_pmdsdocnodesc	
#       LET sr.l_pmdsdocno_desc = ''
#       LET sr.l_pmdsdocnodesc = ''
#       CALL s_aooi200_get_slip_desc(sr.pmdsdocno) RETURNING sr.l_pmdsdocno_desc
#       IF NOT cl_null(sr.l_pmdsdocno_desc) THEN
#          LET sr.l_pmdsdocnodesc = sr.pmdsdocno,'.',sr.l_pmdsdocno_desc
#       END IF
       #160328-00011#2-mark-(E)
       #產品特徵全名 l_pmdt007_desc
       #160328-00011#2-mark-(S)
#       LET sr.l_pmdt007_desc = ''
#       LET sr.l_pmdt007desc = ''
       #160328-00011#2-mark-(E)
#       CALL s_feature_description(sr.pmdt006,sr.pmdt007) RETURNING l_success,sr.l_pmdt007_desc  #160411-00027#7-mark
       #160328-00011#2-mark-(S)
#       IF NOT cl_null(sr.l_pmdt007_desc) THEN
#          LET sr.l_pmdt007desc = sr.pmdt007,'.',sr.l_pmdt007_desc
#       END IF
       #160328-00011#2-mark-(E)
       #151106-00004#1 20151109 mark by beckxie---S
       ##緊急度全名 l_pmdt025desc	
       #LET sr.l_pmdt025_desc = ''
       #LET sr.l_pmdt025desc = ''
       #CALL s_desc_gzcbl004_desc('2036',sr.pmdt025) RETURNING sr.l_pmdt025_desc
       #IF NOT cl_null(sr.l_pmdt025_desc) THEN
       #   LET sr.l_pmdt025desc = sr.pmdt025,'.',sr.l_pmdt025_desc
       #END IF
       ##理由碼全名 l_pmdt051desc	
       #LET sr.l_pmdt051_desc = ''
       #LET sr.l_pmdt051desc = ''
       #SELECT gzcb004 INTO l_acc FROM gzcb_t WHERE gzcb001 = '24' AND gzcb002 = g_prog   
       #CALL s_desc_get_acc_desc(l_acc,sr.pmdt051) RETURNING sr.l_pmdt051_desc
       #IF NOT cl_null(sr.l_pmdt051_desc) THEN
       #   LET sr.l_pmdt051desc = sr.pmdt051,'.',sr.l_pmdt051_desc
       #END IF
       ##專案編號全名 l_pmdt072desc	
       #LET sr.l_pmdt072_desc = ''
       #LET sr.l_pmdt072desc = ''
       #CALL s_desc_get_project_desc(sr.pmdt072) RETURNING sr.l_pmdt072_desc
       #IF NOT cl_null(sr.l_pmdt072_desc) THEN
       #   LET sr.l_pmdt072desc = sr.pmdt072,'.',sr.l_pmdt072_desc
       #END IF
       ##WBS全名 l_pmdt073desc	
       #LET sr.l_pmdt073_desc = ''
       #LET sr.l_pmdt073desc = ''
       #CALL s_desc_get_wbs_desc(sr.pmdt072,sr.pmdt073) RETURNING sr.l_pmdt073_desc
       #IF NOT cl_null(sr.l_pmdt073_desc) THEN
       #   LET sr.l_pmdt073desc = sr.pmdt073,'.',sr.l_pmdt073_desc
       #END IF
       ##活動編號全名 l_pmdt074desc	
       #LET sr.l_pmdt074_desc = ''
       #LET sr.l_pmdt074desc = ''
       #CALL s_desc_get_activity_desc(sr.pmdt072,sr.pmdt074) RETURNING sr.l_pmdt074_desc
       #IF NOT cl_null(sr.l_pmdt074_desc) THEN
       #   LET sr.l_pmdt074desc = sr.pmdt074,'.',sr.l_pmdt074_desc
       #END IF
       ##系列全名 l_imaa127desc	
       #LET sr.l_imaa127_desc = ''
       #LET sr.l_imaa127desc = ''
       #   #用料號抓取系列
       #SELECT imaa127 INTO sr.l_imaa127 FROM imaa_t
       # WHERE imaa001 = sr.pmdt006
       #   AND imaaent = g_enterprise
       #  #抓取系列說明
       #CALL s_desc_get_acc_desc('2003',sr.l_imaa127)  RETURNING sr.l_imaa127_desc
       #IF NOT cl_null(sr.l_imaa127_desc) THEN
       #   LET sr.l_imaa127desc = sr.l_imaa127,'.',sr.l_imaa127_desc
       #END IF
       ##dorislai-20150806-add----(E)
       #151106-00004#1 20151109 mark by beckxie---E
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.pmdsdocno,sr.pmdsdocdt,sr.l_pmds000_desc,sr.pmds011,sr.l_pmds011_desc,sr.pmdsstus,sr.l_pmdsstus_desc,sr.l_pmds002_desc,sr.l_pmds003_desc,sr.l_pmds007_desc,sr.l_pmds008_desc,sr.pmdtseq,sr.pmds006,sr.pmdt002,sr.l_pmdt005_desc,sr.pmdt006,sr.x_t6_imaal003,sr.x_t6_imaal004,sr.pmdt007,sr.l_imaa127_desc,sr.pmdt020,sr.pmdt019,sr.pmdt022,sr.pmdt021,sr.pmdt024,sr.pmdt023,sr.pmdt036,sr.pmdt038,sr.pmdt039,sr.pmdt016,sr.l_pmdt016_desc,sr.pmdt017,sr.l_pmdt017_desc,sr.pmdt018,sr.pmdt059,sr.pmds002,sr.pmds003,sr.pmds007,sr.pmds008,sr.pmdt063,sr.pmdt072,sr.pmdt073,sr.pmdt074,sr.l_pmdt072_desc,sr.l_pmdt073_desc,sr.l_pmdt074_desc,sr.l_pmdt007_desc
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "apmr004_x01_execute"
          LET g_errparam.code   = SQLCA.sqlcode
          LET g_errparam.popup  = FALSE
          CALL cl_err()       
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF
 
       #add-point:ins_data段after_save name="ins_data.after.save"
       LET l_count = 0
       SELECT COUNT(*) INTO l_count
         FROM pmdu_t
        WHERE pmduent = sr.pmdsent
          AND pmdudocno = sr.pmdsdocno
          AND pmduseq = sr.pmdtseq
          
       IF tm.a1 = 'Y' AND l_count > 1 THEN
          #160328-00011#2-mark-(S)
#          LET l_sql = " SELECT pmdu006,pmdu007,pmdu008,pmdu010,pmdu009,pmdu012,pmdu011,pmdudocno,pmduseq ",
#                      "   FROM pmdu_t ",
#                      "  WHERE pmduent = ",sr.pmdsent,
#                      "    AND pmdudocno = '",sr.pmdsdocno,"' ",
#                      "    AND pmduseq = '",sr.pmdtseq,"' "
#          DECLARE apmr004_x01_repcur CURSOR FROM l_sql
          #160328-00011#2-mark-(E)
          #160411-00027#7-mark-(S)
#          #160328-00011#2-mod-(S)
##          FOREACH apmr004_x01_repcur INTO sr1.pmdu006,sr1.pmdu007,sr1.pmdu008,sr1.pmdu010,sr1.pmdu009,
##                                          sr1.pmdu012,sr1.pmdu011,sr1.pmdudocno,sr1.pmduseq
#          FOREACH apmr004_x01_repcur USING sr.pmdsent,sr.pmdsdocno,sr.pmdtseq
#                                     INTO sr1.pmdu006,sr1.pmdu007,sr1.pmdu008,sr1.pmdu010,sr1.pmdu009,
#                                          sr1.pmdu012,sr1.pmdu011,sr1.pmdudocno,sr1.pmduseq
#          #160328-00011#2-mod-(E)
          #160411-00027#7-mark-(E)
          #160411-00027#7-add-(S)
          FOREACH apmr004_x01_repcur USING sr.pmds000,sr.pmdsent,sr.pmdsdocno,sr.pmdtseq
                                     INTO sr1.pmdu006,sr1.pmdu006_desc,sr1.pmdu007,sr1.pmdu007_desc,
                                          sr1.pmdu008,sr1.pmdu010,sr1.pmdu009,
                                          sr1.pmdu012,sr1.pmdu011,sr1.pmdudocno,sr1.pmduseq
          #160411-00027#7-add-(E)                                
             IF STATUS THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = 'foreach:'
                LET g_errparam.code   = STATUS
                LET g_errparam.popup  = TRUE
                CALL cl_err()
                LET g_rep_success = 'N'
                EXIT FOREACH
             END IF
             #160328-00011#2-mark-(S) 移至子報表SQL中
#             #限定庫位
#             CALL s_desc_get_stock_desc(sr.pmdssite,sr1.pmdu006) RETURNING l_desc
#             IF NOT cl_null(sr1.pmdu006) AND NOT cl_null(l_desc) THEN
#                LET sr1.pmdu006 = sr1.pmdu006,'.',l_desc
#             END IF
#             #限定儲位
#             CALL s_desc_get_locator_desc(sr.pmdssite,sr1.pmdu006,sr1.pmdu007) RETURNING l_desc
#             IF NOT cl_null(sr1.pmdu007) AND NOT cl_null(l_desc) THEN
#                LET sr1.pmdu007 = sr1.pmdu007,'.',l_desc
#             END IF
             #160328-00011#2-mark-(E)
#             LET sr1.pmdu010 = sr1.pmdu010 * l_gzcb004 #160411-00027#7-mark
             #160411-00027#7-mod-(S)
#             EXECUTE insert_prep1 USING sr1.pmdu006,sr1.pmdu007,sr1.pmdu008,sr1.pmdu010,sr1.pmdu009,
#                                        sr1.pmdu012,sr1.pmdu011,sr1.pmdudocno,sr1.pmduseq
             EXECUTE insert_prep1 USING sr1.pmdu006,sr1.pmdu006_desc,sr1.pmdu007,sr1.pmdu007_desc,
                                        sr1.pmdu008,sr1.pmdu010,sr1.pmdu009,
                                        sr1.pmdu012,sr1.pmdu011,sr1.pmdudocno,sr1.pmduseq
             #160411-00027#7-mod-(E)
             IF SQLCA.sqlcode THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = "apmr004_x01_execute1"
                LET g_errparam.code   = SQLCA.sqlcode
                LET g_errparam.popup  = FALSE
                CALL cl_err()
                LET g_rep_success = 'N'
                EXIT FOREACH
             END IF
          END FOREACH
       END IF
       #end add-point
       
    END FOREACH
    
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apmr004_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION apmr004_x01_rep_data()
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
 
{<section id="apmr004_x01.other_function" readonly="Y" >}

 
{</section>}
 
