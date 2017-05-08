#該程式未解開Section, 採用最新樣板產出!
{<section id="apmr001_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:9(2016-09-05 17:33:05), PR版次:0009(2016-09-05 19:07:55)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000156
#+ Filename...: apmr001_x01
#+ Description: ...
#+ Creator....: 05229(2014-06-04 16:19:06)
#+ Modifier...: 01727 -SD/PR- 01727
 
{</section>}
 
{<section id="apmr001_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#160413-00011#6  16/04/13 By zhujing 效能提升:删除不需要的栏位；
#                                            取消组合字段，分拆为两个栏位；
#                                            将FOREACH中判断的内容转移到SQL中
#160905-00007#11  2016/09/05 By 01727     调整系统中无ENT的SQL条件增加ent
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
       a1 LIKE type_t.chr1          #未完全採購
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="apmr001_x01.main" readonly="Y" >}
PUBLIC FUNCTION apmr001_x01(p_arg1,p_arg2)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr1         #tm.a1  未完全採購
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.a1 = p_arg2
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   LET tm.wc = cl_replace_str(p_arg1,'imaa','C1_imaa')  #160309 Sarah add
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "apmr001_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL apmr001_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL apmr001_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL apmr001_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL apmr001_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL apmr001_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="apmr001_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION apmr001_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "pmdadocno.pmda_t.pmdadocno,pmdadocdt.pmda_t.pmdadocdt,l_pmdastus_desc.gzcbl_t.gzcbl004,pmda002.pmda_t.pmda002,l_pmda002_ooag011.type_t.chr80,pmdb004.pmdb_t.pmdb004,l_imaal003_desc.type_t.chr100,l_imaal004_desc.type_t.chr200,pmdb005.pmdb_t.pmdb005,l_imaa127.type_t.chr30,l_imaa127_desc.type_t.chr50,pmdb030.pmdb_t.pmdb030,l_pmdb031_desc.type_t.chr100,l_pmdb032_desc.gzcbl_t.gzcbl004,l_pmdb033_desc.type_t.chr30,pmdb006.pmdb_t.pmdb006,pmdb007.pmdb_t.pmdb007,pmdb049.pmdb_t.pmdb049,l_pmdb006_049_count.type_t.num20_6,l_imaf142.imaf_t.imaf142,l_imaf142_desc.type_t.chr100,pmdb050.pmdb_t.pmdb050,pmda007.pmda_t.pmda007,pmdb008.pmdb_t.pmdb008,pmdb009.pmdb_t.pmdb009,pmdb014.pmdb_t.pmdb014,pmdb015.pmdb_t.pmdb015,pmdb034.pmdb_t.pmdb034,pmdb035.pmdb_t.pmdb035,pmdb036.pmdb_t.pmdb036,pmda003.pmda_t.pmda003,l_pmdb005_desc.type_t.chr30,l_pmdb015_desc.type_t.chr30,l_pmdb034_desc.type_t.chr30,l_pmdb035_desc.type_t.chr30,l_pmdb036_desc.type_t.chr30" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="apmr001_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION apmr001_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="apmr001_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apmr001_x01_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define(客製用) name="sel_prep.define_customerization"

#end add-point
#add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
DEFINE l_ooef019     LIKE ooef_t.ooef019   #稅區  #160413-00011#6 add
#end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   SELECT ooef019 INTO l_ooef019 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site #160413-00011#6 add
   #end add-point
 
   #add-point:sel_prep g_select name="sel_prep.g_select"
   #160413-00011#6  16/04/13 zhujing marked---(S)
   #151030-00002#1 20151030  add by beckxie---S
#   LET g_select = " SELECT pmdadocno,pmdadocdt,S1.gzcbl004,pmda002,D1.ooag011, ",
#                  "   pmdb001,pmdb002,pmdb003,pmdb004,B1_imaal003, ",
#                  "   B1_imaal004,pmdb005,C1_imaa127,A1_oocql004,trim(C1_imaa127)||'.'||trim(A1_oocql004), ",
#                  "   pmdb030,A2_oocql004,A3_gzcbl004,A4_gzcbl004,pmdb006, ",
#                  "   pmdb007,pmdb049,COALESCE(pmdb006,0)-COALESCE(pmdb049,0),D2.imaf142,D3.ooag011, ",
#                  "   pmdb050,pmdaent,pmdb033,pmdb032,pmdasite, ",
#                  "   pmdastus,x.pmdb031,pmda004,pmda005,pmda006, ",
#                  "   pmda007,pmda010,pmda011,pmda012,pmda020, ",       
#                  "   pmda021,pmda022,pmda023,pmdb008,pmdb009, ",      
#                  "   pmdb010,pmdb011,pmdb014,pmdb015,pmdb016, ",      
#                  "   pmdb017,pmdb018,pmdb019,pmdb020,pmdb021, ",      
#                  "   pmdb034,pmdb035,pmdb036,pmdb037,pmdb038, ",      
#                  "   pmdb039,pmdb041,pmdb042,pmdb043,pmdb044, ",      
#                  "   pmdb045,pmdb046,pmdb048,pmdb051,pmdb052, ",      
#                  "   pmdbseq,pmda001,pmda003,D4.ooail003,D5.ooefl003, ",
#                  "   E2.oodbl004,F1.oocql004,F2.oocql004,'',B2_pmaal004, ",
#                  "   B3_ooibl004,A5_oocql004,B4_pjbal003,B5_pjbbl004,B6_pjbml004, ",
#                  "   B7_ooefl003,C3_inaa002,C4_inab003,B8_ooefl003,A6_oocql004, ",
#                  "   CASE WHEN pmdastus = 'H' THEN A7_oocql004 ",
#                  "   ELSE  A8_oocql004 ",
#                  "   END          ",
#                  "   ,'',trim(pmda002)||'.'||trim(D1.ooag011),D6.ooefl003,trim(pmda005)||'.'||trim(D4.ooail003), ",
#                  "   trim(pmda007)||'.'||trim(D5.ooefl003),trim(pmda010)||'.'||trim(E2.oodbl004),trim(pmda021)||'.'||trim(F1.oocql004),trim(pmda023)||'.'||trim(F2.oocql004),'', ",
#                  "   trim(C2_gzcb004)||'.'||trim(A2_oocql004),trim(pmdb048)||'.'||trim(A6_oocql004),trim(pmdb051)||'.'||trim(CASE WHEN pmdastus = 'H' THEN A7_oocql004 ",
#                  "   ELSE  A8_oocql004 ",
#                  "   END),trim(pmdb015)||'.'||trim(B2_pmaal004),trim(pmdb016)||'.'||trim(B3_ooibl004), ",
#                  "   trim(pmdb017)||'.'||trim(A5_oocql004),trim(pmdb034)||'.'||trim(B4_pjbal003),trim(pmdb035)||'.'||trim(B5_pjbbl004),trim(pmdb036)||'.'||trim(B6_pjbml004),trim(pmdb037)||'.'||trim(B7_ooefl003), ",
#                  "   trim(pmdb038)||'.'||trim(C3_inaa002),trim(pmdb039)||'.'||trim(C4_inab003),trim(pmdb046)||'.'||trim(B8_ooefl003),'',trim(pmdastus)||'.'||trim(S1.gzcbl004), ",
#                  "   trim(pmda003)||'.'||trim(D6.ooefl003),trim(x.pmdb032)||'.'||trim(A3_gzcbl004),trim(x.pmdb033)||'.'||trim(A4_gzcbl004) "
   #151030-00002#1 20151030  add by beckxie---E
   #160413-00011#6  16/04/13 zhujing marked---(E)
   #160413-00011#6  16/04/13 zhujing mod---(S)
    LET g_select = " SELECT pmdadocno,pmdadocdt, ",
                   " (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '13' AND gzcbl002 = pmdastus AND gzcbl003 = '",g_dlang,"') S1_gzcbl004,",
                   " pmda002,",
                   " (SELECT ooag011 FROM ooag_t WHERE ooag001 = pmda002 AND ooagent = pmdaent) D1_ooag011,",
                   " pmdb004,",
                   " (SELECT imaal003 FROM imaal_t WHERE imaal001 = pmdb004 AND imaal002 = '",g_dlang,"' AND imaalent = pmdbent )B1_imaal003,",
                   " (SELECT imaal004 FROM imaal_t WHERE imaal001 = pmdb004 AND imaal002 = '",g_dlang,"' AND imaalent = pmdbent )B1_imaal004,",
                   " pmdb005,",#不显示，产品特征
                   " imaa127,",#不显示
                   " (SELECT oocql004 FROM oocql_t WHERE oocql001 = '2003' AND oocql002 = imaa127 AND oocql003 = '",g_dlang,"' AND oocqlent = ",g_enterprise,")A1_oocql004,",#不显示   #160905-00007#11 Add ent
                   " pmdb030,",
                   " (SELECT oocql004 FROM oocql_t,gzcb_t WHERE oocqlent = 99 AND oocql001 = gzcb004 AND gzcb001 = '24' AND gzcb002 = 'apmt400' AND oocql002 =pmdb031 AND oocql003 = '",g_dlang,"' ) A2_oocql004,",
                   " (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001='2035'AND gzcbl002 = pmdb032 AND gzcbl003 = '",g_dlang,"')A3_gzcbl004,",
                   " (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001='2036'AND gzcbl002 = pmdb033 AND gzcbl003 = '",g_dlang,"')A4_gzcbl004,",
                   " pmdb006,pmdb007,pmdb049,COALESCE(pmdb006,0)-COALESCE(pmdb049,0),imaf142,",
                   " (SELECT ooag011 FROM ooag_t WHERE ooagent = pmdaent AND ooag001 = imaf142)D3_ooag011,",
                   " pmdb050,pmdaent,pmdasite,pmda007,pmdb008,pmdb009,pmdb014,pmdb015,pmdb034,pmdb035,pmdb036,pmda003,",
                   " (SELECT inaml004 FROM inaml_t WHERE inamlent = pmdbent AND inaml001 = pmdb004 AND inaml002 = pmdb005 AND inaml003='",g_dlang,"') inaml004,",#不显示，产品特征
                   " (SELECT pmaal004 FROM pmaal_t WHERE pmaalent = pmdbent AND pmaal001 = pmdb015 AND pmaal002 ='",g_dlang,"')B2_pmaal004,",    #不显示
                   " (SELECT pjbal003 FROM pjbal_t WHERE pjbalent = pmdbent AND pjbal001 = pmdb034 AND pjbal002 = '",g_dlang,"')B4_pjbal003,",  #不显示
                   " (SELECT pjbbl004 FROM pjbbl_t WHERE pjbblent = pmdbent AND pjbbl001 = pmdb034 AND pjbbl002 = pmdb035 AND pjbbl003 = '",g_dlang,"' )B5_pjbbl004,", #不显示
                   " (SELECT pjbml004 FROM pjbml_t WHERE pjbmlent = pmdbent AND pjbml001 = pmdb034 AND pjbml002 = pmdb036 AND pjbml003 = '",g_dlang,"' )B6_pjbml004"   #不显示 
   #160413-00011#6  16/04/13 zhujing mod---(E)
#   #end add-point
#   LET g_select = " SELECT pmdadocno,pmdadocdt,'',pmda002,'',pmdb004,NULL,NULL,pmdb005,'','',pmdb030, 
#       '','',NULL,pmdb006,pmdb007,pmdb049,0,'','',pmdb050,pmdaent,pmdasite,pmda007,pmdb008,pmdb009,pmdb014, 
#       pmdb015,pmdb034,pmdb035,pmdb036,pmda003,'','','','',''"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   #151030-00002#1 20151030  mark by beckxie---S
   #LET g_from = " FROM pmdb_t LEFT OUTER JOIN pmda_t ON pmda_t.pmdaent = pmdb_t.pmdbent AND pmda_t.pmdadocno = pmdb_t.pmdbdocno",
   #             "             LEFT OUTER JOIN imaa_t ON imaa_t.imaaent = pmdb_t.pmdbent AND imaa_t.imaa001 = pmdb_t.pmdb004",
   #             "             LEFT OUTER JOIN imaf_t ON imaf_t.imafent = pmdb_t.pmdbent AND imaf_t.imafsite = pmdb_t.pmdbsite AND imaf_t.imaf001 = pmdb_t.pmdb004"
   #151030-00002#1 20151030  mark by beckxie---E
   #160413-00011#6  16/04/13 zhujing marked---(S)
   #151030-00002#1 20151030  add by beckxie---S
#   LET g_from = " FROM pmda_t ",
##                " LEFT OUTER JOIN ooag_t D1 ON D1.ooagent = pmdaent AND D1.ooag001=pmda002 ",     #2016-4-14 zhujing marked
#                " LEFT OUTER JOIN ooail_t D4 ON D4.ooailent = pmdaent AND D4.ooail001 = pmda005 AND D4.ooail002 = '",g_dlang,"' ",
#                " LEFT OUTER JOIN ooefl_t D5 ON D5.ooeflent = pmdaent AND D5.ooefl001 = pmda007 AND D5.ooefl002 = '",g_dlang,"' ",
#                " LEFT OUTER JOIN ooefl_t D6 ON D6.ooeflent = pmdaent AND D6.ooefl001 = pmda003 AND D6.ooefl002 = '",g_dlang,"' ",
##                " LEFT OUTER JOIN gzcbl_t S1 ON S1.gzcbl001='13' AND S1.gzcbl002=pmdastus AND S1.gzcbl003='",g_dlang,"' ",   #2016-4-14 zhujing marked
#                " LEFT OUTER JOIN ooef_t E1 ON  E1.ooefent = pmdaent AND E1.ooef001 = '",g_site,"' ",
#                " LEFT OUTER JOIN oodbl_t E2 ON E2.oodblent = pmdaent AND E2.oodbl001 = E1.ooef019 AND E2.oodbl002 = pmda010 AND E2.oodbl003 = '",g_dlang,"' ",
#                " LEFT OUTER JOIN oocql_t F1 ON F1.oocqlent = pmdaent AND F1.oocql001 = '263' AND F1.oocql002 = pmda021 AND F1.oocql003 = '",g_dlang,"' ",
#                " LEFT OUTER JOIN oocql_t F2 ON F2.oocqlent = pmdaent AND F2.oocql001 = '317' AND F2.oocql002 = pmda023 AND F2.oocql003 = '",g_dlang,"' ",
#                " LEFT OUTER JOIN ( ",
#                " SELECT pmdb_t.*,C2.gzcb004 C2_gzcb004,B1.imaal003 B1_imaal003,B1.imaal004 B1_imaal004 ,C1.imaa127 C1_imaa127, ",
#                "             A1.oocql004 A1_oocql004,A2.oocql004 A2_oocql004,A3.gzcbl004 A3_gzcbl004,A4.gzcbl004 A4_gzcbl004, ",
#                "             B2.pmaal004 B2_pmaal004,B3.ooibl004 B3_ooibl004,A5.oocql004 A5_oocql004,B4.pjbal003 B4_pjbal003, ",
#                "             B5.pjbbl004 B5_pjbbl004,B6.pjbml004 B6_pjbml004,B7.ooefl003 B7_ooefl003,C3.inaa002 C3_inaa002, ",
#                "             C4.inab003 C4_inab003,B8.ooefl003 B8_ooefl003,A6.oocql004 A6_oocql004,A7.oocql004 A7_oocql004, ",
#                "             A8.oocql004 A8_oocql004 ",
#                " FROM  pmdb_t ",
#                " LEFT OUTER JOIN imaal_t B1 ON B1.imaalent=pmdbent AND B1.imaal001=pmdb004 AND B1.imaal002='",g_dlang,"' ",
#                " LEFT OUTER JOIN pmaal_t B2 ON B2.pmaalent = pmdbent AND B2.pmaal001 = pmdb015 AND B2.pmaal002 ='",g_dlang,"' ",
#                " LEFT OUTER JOIN ooibl_t B3 ON B3.ooiblent = pmdbent AND B3.ooibl002 = pmdb016 AND B3.ooibl003 = '",g_dlang,"' ",
#                " LEFT OUTER JOIN pjbal_t B4  ON B4.pjbalent = pmdbent AND B4.pjbal001 = pmdb034 AND B4.pjbal002 = '",g_dlang,"' ",
#                " LEFT OUTER JOIN pjbbl_t B5 ON B5.pjbblent = pmdbent AND B5.pjbbl001 = pmdb034 AND B5.pjbbl002 = pmdb035 AND B5.pjbbl003 = '",g_dlang,"' ",
#                " LEFT OUTER JOIN pjbml_t B6 ON B6.pjbmlent = pmdbent AND B6.pjbml001 = pmdb034 AND B6.pjbml002 = pmdb036 AND B6.pjbml003 = '",g_dlang,"' ",
#                " LEFT OUTER JOIN ooefl_t B7 ON B7.ooeflent = pmdbent AND B7.ooefl001 = pmdb037 AND B7.ooefl002 = '",g_dlang,"' ",
#                " LEFT OUTER JOIN ooefl_t B8 ON B8.ooeflent = pmdbent AND B8.ooefl001 = pmdb046 AND B8.ooefl002 = '",g_dlang,"' ",
#                " LEFT OUTER JOIN imaa_t C1 ON C1.imaaent=pmdbent AND C1.imaa001=pmdb004 ",
#                " LEFT OUTER JOIN gzcb_t C2 ON C2.gzcb001='24' AND C2.gzcb002='apmt400' ",
#                " LEFT OUTER JOIN inaa_t C3 ON C3.inaaent = pmdbent AND C3.inaasite = pmdb037 AND C3.inaa001 = pmdb038 ",
#                " LEFT OUTER JOIN inab_t C4 ON C4.inabent = pmdbent AND C4.inabsite = pmdb037 AND C4.inab001 = pmdb038 AND C4.inab002 = pmdb039 ",
#                " LEFT OUTER JOIN oocql_t A1 ON A1.oocqlent=pmdbent AND A1.oocql001='2003' AND A1.oocql002=C1.imaa127 AND A1.oocql003='",g_dlang,"' ",
#                " LEFT OUTER JOIN oocql_t A2 ON A2.oocqlent=pmdbent AND A2.oocql001=C2.gzcb004 AND A2.oocql002=pmdb031 AND A2.oocql003='",g_dlang,"' ",
#                " LEFT OUTER JOIN gzcbl_t A3 ON A3.gzcbl001='2035' AND A3.gzcbl002=pmdb032 AND A3.gzcbl003='",g_dlang,"' ",
#                " LEFT OUTER JOIN gzcbl_t A4 ON A4.gzcbl001='2036' AND A4.gzcbl002=pmdb033 AND A4.gzcbl003='",g_dlang,"' ",
#                " LEFT OUTER JOIN oocql_t A5 ON A5.oocqlent = pmdbent AND A5.oocql001 = '238' AND A5.oocql002 = pmdb017 AND A5.oocql003 = '",g_dlang,"' ",
#                " LEFT OUTER JOIN oocql_t A6 ON A6.oocqlent = pmdbent AND A6.oocql001 = '274' AND A6.oocql002 = pmdb048 AND A6.oocql003 = '",g_dlang,"' ",
#                " LEFT OUTER JOIN oocql_t A7 ON A7.oocqlent = pmdbent AND A7.oocql001 = '317' AND A7.oocql002 = pmdb051 AND A7.oocql003 = '",g_dlang,"' ",
#                " LEFT OUTER JOIN oocql_t A8 ON A8.oocqlent = pmdbent AND A8.oocql001 = '258' AND A8.oocql002 = pmdb051 AND A8.oocql003 = '",g_dlang,"' ",
#                " ) x ON x.pmdbent=pmda_t.pmdaent AND x.pmdbdocno=pmda_t.pmdadocno ",
#                " LEFT OUTER JOIN  imaf_t D2 ON D2.imafent=pmdaent AND D2.imafsite=pmdasite AND D2.imaf001 =pmdb004 ",
#                " LEFT OUTER JOIN ooag_t D3 ON D3.ooagent=pmdaent AND D3.ooag001=D2.imaf142" 
#   #151030-00002#1 20151030  add by beckxie---E
   #160413-00011#6  16/04/13 zhujing marked---(E)
   #160413-00011#6  16/04/13 zhujing mod---(S)
   LET g_from = "FROM pmda_t LEFT OUTER JOIN pmdb_t ON pmdbent = pmdaent AND pmdbdocno = pmdadocno ",
                "            LEFT OUTER JOIN imaa_t ON imaaent=pmdbent AND imaa001=pmdb004  ",
                "            LEFT OUTER JOIN imaf_t ON imafent = pmdaent AND imafsite = pmdasite AND imaf001 = pmdb004   "
   #160413-00011#6  16/04/13 zhujing mod---(E)
#   #end add-point
#    LET g_from = " FROM pmda_t,pmdb_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   #2016-4-14 zhujing mod-将逻辑处理转移到sql-(S)
   IF tm.a1 = 'Y' THEN
      LET g_where = " WHERE pmda_t.pmdastus <> 'X' AND pmdb032 NOT IN ('2','3','4') AND " ,tm.wc CLIPPED
   ELSE
      LET g_where = " WHERE pmda_t.pmdastus <> 'X' AND " ,tm.wc CLIPPED
   END IF
   #2016-4-14 zhujing mod-(E)
#   #end add-point
#    LET g_where = " WHERE pmda_t.pmdastus <> 'X' AND " ,tm.wc CLIPPED
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("pmda_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
DISPLAY "g_sql:",g_sql
   #end add-point
   PREPARE apmr001_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE apmr001_x01_curs CURSOR FOR apmr001_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="apmr001_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION apmr001_x01_ins_data()
DEFINE sr RECORD 
   pmdadocno LIKE pmda_t.pmdadocno, 
   pmdadocdt LIKE pmda_t.pmdadocdt, 
   l_pmdastus_desc LIKE gzcbl_t.gzcbl004, 
   pmda002 LIKE pmda_t.pmda002, 
   l_pmda002_ooag011 LIKE type_t.chr80, 
   pmdb004 LIKE pmdb_t.pmdb004, 
   l_imaal003_desc LIKE type_t.chr100, 
   l_imaal004_desc LIKE type_t.chr200, 
   pmdb005 LIKE pmdb_t.pmdb005, 
   l_imaa127 LIKE type_t.chr30, 
   l_imaa127_desc LIKE type_t.chr50, 
   pmdb030 LIKE pmdb_t.pmdb030, 
   l_pmdb031_desc LIKE type_t.chr100, 
   l_pmdb032_desc LIKE gzcbl_t.gzcbl004, 
   l_pmdb033_desc LIKE type_t.chr30, 
   pmdb006 LIKE pmdb_t.pmdb006, 
   pmdb007 LIKE pmdb_t.pmdb007, 
   pmdb049 LIKE pmdb_t.pmdb049, 
   l_pmdb006_049_count LIKE type_t.num20_6, 
   l_imaf142 LIKE imaf_t.imaf142, 
   l_imaf142_desc LIKE type_t.chr100, 
   pmdb050 LIKE pmdb_t.pmdb050, 
   pmdaent LIKE pmda_t.pmdaent, 
   pmdasite LIKE pmda_t.pmdasite, 
   pmda007 LIKE pmda_t.pmda007, 
   pmdb008 LIKE pmdb_t.pmdb008, 
   pmdb009 LIKE pmdb_t.pmdb009, 
   pmdb014 LIKE pmdb_t.pmdb014, 
   pmdb015 LIKE pmdb_t.pmdb015, 
   pmdb034 LIKE pmdb_t.pmdb034, 
   pmdb035 LIKE pmdb_t.pmdb035, 
   pmdb036 LIKE pmdb_t.pmdb036, 
   pmda003 LIKE pmda_t.pmda003, 
   l_pmdb005_desc LIKE type_t.chr30, 
   l_pmdb015_desc LIKE type_t.chr30, 
   l_pmdb034_desc LIKE type_t.chr30, 
   l_pmdb035_desc LIKE type_t.chr30, 
   l_pmdb036_desc LIKE type_t.chr30
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_ooag011 LIKE ooag_t.ooag011
DEFINE l_imaf142 LIKE imaf_t.imaf142
DEFINE l_ooef019      LIKE ooef_t.ooef019  #稅區 20150729 by dorislai add 
DEFINE l_success      LIKE type_t.num5     #20150729 by dorislai add  
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH apmr001_x01_curs INTO sr.*                               
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
      #2016-4-14 zhujing mod-添加至where段
#      IF tm.a1 = 'Y' AND sr.pmdb032 MATCHES "[234]" THEN
#         CONTINUE FOREACH
#      END IF
     #2016-4-14 zhujing mod 添加至where段
      #151030-00002#1 20151103 mark by beckxie---S
      ##帶出請購人員
      #CALL s_desc_get_person_desc(sr.pmda002) RETURNING sr.l_pmda002_ooag011
      #   
      ##帶出品名、規格
      #CALL s_desc_get_item_desc(sr.pmdb004) RETURNING sr.l_imaal003_desc,sr.l_imaal004_desc
      #
      ##帶出緊急度
      #CALL s_desc_gzcbl004_desc('2036',sr.pmdb033) RETURNING sr.l_pmdb033_desc
      ##dorislai-20150805-add----(S)
      #LET sr.l_pmdb033desc = ''
      #IF NOT cl_null(sr.l_pmdb033_desc) THEN
      #   LET sr.l_pmdb033desc = sr.pmdb033,'.',sr.l_pmdb033_desc
      #END IF
      ##dorislai-20150805-add----(E)
      ##行狀態
      #CALL s_desc_gzcbl004_desc('2035',sr.pmdb032) RETURNING sr.l_pmdb032_desc
      ##dorislai-20150805-add----(S)
      #LET sr.l_pmdb032desc = ''
      #IF NOT cl_null(sr.l_pmdb032_desc) THEN
      #   LET sr.l_pmdb032desc = sr.pmdb032,'.',sr.l_pmdb032_desc
      #END IF
      ##dorislai-20150805-add----(E)
      ##狀態碼
      #CALL s_desc_gzcbl004_desc('13',sr.pmdastus) RETURNING sr.l_pmdastus_desc
      ##dorislai-20150805-add----(S)
      #LET sr.l_pmdastusdesc = ''
      #IF NOT cl_null(sr.l_pmdastus_desc) THEN
      #   LET sr.l_pmdastusdesc = sr.pmdastus,'.',sr.l_pmdastus_desc
      #END IF
      ##dorislai-20150805-add----(E)
      ##帶出採購員 
      #LET l_imaf142 = ''
      #LET l_ooag011 = ''
      #     
      # SELECT imaf142 INTO sr.l_imaf142
      #   FROM imaf_t        
      #  WHERE imafent = sr.pmdaent  
      #    AND imafsite = sr.pmdasite
      #    AND imaf001  = sr.pmdb004
      #    
      # CALL s_desc_get_person_desc(sr.l_imaf142) RETURNING sr.l_imaf142_desc
      # IF cl_null(sr.pmdb006) THEN 
      #    LET sr.pmdb006 = 0 
      # END IF
      # IF cl_null(sr.pmdb049) THEN 
      #    LET sr.pmdb049 = 0 
      # END IF
      # #未採購量計算   
      # LET sr.l_pmdb006_049_count = sr.pmdb006 - sr.pmdb049  
      #  
      # #150529 by whitney add start
      # SELECT oocql004 INTO sr.l_pmdb031_desc
      #   FROM oocql_t,gzcb_t
      #  WHERE oocqlent = g_enterprise
      #    AND oocql001 = gzcb004
      #    AND oocql002 = sr.pmdb031
      #    AND oocql003 = g_dlang
      #    AND gzcb001 = '24'
      #    AND gzcb002 = 'apmt400'
      # #150529 by whitney add end
      #151030-00002#1 20151103 mark by beckxie---E
      
      #160413-00011#6  16/04/13 zhujing marked---(S)      
        ##dorislai-20150728-add----(S)
#       ##請購單號全名
#       LET sr.l_pmdadocno_desc = '' 
#       LET sr.l_pmdadocnodesc = '' 
#       CALL s_aooi200_get_slip_desc(sr.pmdadocno) RETURNING sr.l_pmdadocno_desc
#       IF NOT cl_null(sr.l_pmdadocno_desc) THEN
#          LET sr.l_pmdadocnodesc = sr.pmdadocno,'.',sr.l_pmdadocno_desc
#       END IF
       #151030-00002#1 20151103 mark by beckxie---S
      #160413-00011#6  16/04/13 zhujing marked---(E)
       
       ##請購人員說明
       #LET sr.l_pmda002_ref = ''
       #SELECT ooag011 INTO sr.l_pmda002_ref FROM ooag_t 
       # WHERE ooagent = g_enterprise AND ooag001 = sr.pmda002 
       ##請購部門全名
       #LET sr.l_pmda003_desc = '' 
       #LET sr.l_pmda003desc = '' 
       #SELECT ooefl003 INTO sr.l_pmda003_desc FROM ooefl_t 
       # WHERE ooeflent = g_enterprise AND ooefl001 = sr.pmda003 AND ooefl002 = g_dlang
       #IF NOT cl_null(sr.l_pmda003_desc) THEN
       #   LET sr.l_pmda003desc = sr.pmda003,'.',sr.l_pmda003_desc
       #END IF
       ##理由碼全名
       #LET sr.l_pmdb031desc = ''
       #IF NOT cl_null(sr.l_pmdb031_desc) THEN
       #   LET sr.l_pmdb031desc = sr.pmdb031,'.',sr.l_pmdb031_desc
       #END IF
       ##評價幣別說明 l_pmda005_desc	
       #LET sr.l_pmda005_desc = ''
       #LET sr.l_pmda005desc = ''
       #SELECT ooail003 INTO sr.l_pmda005_desc FROM ooail_t 
       # WHERE ooailent = g_enterprise AND ooail001 = sr.pmda005 AND ooail002 = g_dlang
       #IF NOT cl_null(sr.l_pmda005_desc) THEN
       #   LET sr.l_pmda005desc = sr.pmda005,'.',sr.l_pmda005_desc
       #END IF
       ##費用部門說明 l_pmda007_desc	
       #LET sr.l_pmda007_desc = ''
       #LET sr.l_pmda007desc = ''
       #SELECT ooefl003 INTO sr.l_pmda007_desc FROM ooefl_t 
       # WHERE ooeflent = g_enterprise AND ooefl001 = sr.pmda007 AND ooefl002 = g_dlang
       #IF NOT cl_null(sr.l_pmda007_desc) THEN
       #   LET sr.l_pmda007desc = sr.pmda007,'.',sr.l_pmda007_desc
       #END IF
       ##稅別說明 l_pmda010_desc	
       #LET sr.l_pmda010_desc = ''
       #LET sr.l_pmda010desc = ''
       #    #抓取稅區
       #LET l_ooef019 = ''
       #SELECT ooef019 INTO l_ooef019 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
       #    #稅別
       #SELECT oodbl004 INTO sr.l_pmda010_desc FROM oodbl_t 
       # WHERE oodblent = g_enterprise AND oodbl001 = l_ooef019 
       #   AND oodbl002 = sr.pmda010 AND oodbl003 = g_dlang     
       #
       #IF NOT cl_null(sr.l_pmda010_desc) THEN
       #   LET sr.l_pmda010desc = sr.pmda010,'.',sr.l_pmda010_desc
       #END IF
       ##運送方式說明l_pmda021_desc	
       #LET sr.l_pmda021_desc = ''
       #LET sr.l_pmda021desc = ''
       #SELECT oocql004 INTO sr.l_pmda021_desc FROM oocql_t 
       # WHERE oocqlent = g_enterprise AND oocql001 = '263' 
       #   AND oocql002 = sr.pmda021 AND oocql003 = g_dlang
       #IF NOT cl_null(sr.l_pmda021_desc) THEN
       #   LET sr.l_pmda021desc = sr.pmda021,'.',sr.l_pmda021_desc
       #END IF
       ##留置原因說明 l_pmda023_desc	
       #LET sr.l_pmda023_desc = ''
       #LET sr.l_pmda023desc = ''
       #SELECT oocql004 INTO sr.l_pmda023_desc FROM oocql_t 
       # WHERE oocqlent = g_enterprise AND oocql001 = '317' 
       #   AND oocql002 = sr.pmda023 AND oocql003 = g_dlang
       #IF NOT cl_null(sr.l_pmda023_desc) THEN
       #   LET sr.l_pmda023desc = sr.pmda023,'.',sr.l_pmda023_desc
       #END IF
       #151030-00002#1 20151103 mark by beckxie---E
       
      #160413-00011#6  16/04/13 zhujing marked---(S)
#       ##產品特徵說明 l_pmdb005_desc	
#       LET sr.l_pmdb005_desc = ''
#       LET sr.l_pmdb005desc = ''
#       CALL s_feature_description(sr.pmdb004,sr.pmdb005) RETURNING l_success,sr.l_pmdb005_desc
#       IF NOT cl_null(sr.l_pmdb005_desc) THEN
#          LET sr.l_pmdb005desc = sr.pmdb005,'.',sr.l_pmdb005_desc
#       END IF
       #151030-00002#1 20151103 mark by beckxie---S
      #160413-00011#6  16/04/13 zhujing marked---(E)
      
       ##供應商編號說明 l_pmdb015_desc	
       #LET sr.l_pmdb015_desc = ''
       #LET sr.l_pmdb015desc = ''       
       #SELECT pmaal004 INTO sr.l_pmdb015_desc FROM pmaal_t 
       # WHERE pmaalent = g_enterprise AND pmaal001 = sr.pmdb015 AND pmaal002 = g_dlang
       #IF NOT cl_null(sr.l_pmdb015_desc) THEN
       #   LET sr.l_pmdb015desc = sr.pmdb015,'.',sr.l_pmdb015_desc
       #END IF
       ##付款條件說明 l_pmdb016_desc	
       #LET sr.l_pmdb016_desc = ''
       #LET sr.l_pmdb016desc = ''
       #SELECT ooibl004 INTO sr.l_pmdb016_desc FROM ooibl_t 
       # WHERE ooiblent = g_enterprise AND ooibl002 = sr.pmdb016 AND ooibl003 = g_dlang
       #IF NOT cl_null(sr.l_pmdb016_desc) THEN
       #   LET sr.l_pmdb016desc = sr.pmdb016,'.',sr.l_pmdb016_desc
       #END IF
       ##交易條件說明 l_pmdb017_desc	
       #LET sr.l_pmdb017_desc = ''
       #LET sr.l_pmdb017desc = ''
       #SELECT oocql004 INTO sr.l_pmdb017_desc FROM oocql_t 
       # WHERE oocqlent = g_enterprise AND oocql001 = '238' 
       #   AND oocql002 = sr.pmdb017 AND oocql003 = g_dlang
       #IF NOT cl_null(sr.l_pmdb017_desc) THEN
       #   LET sr.l_pmdb017desc = sr.pmdb017,'.',sr.l_pmdb017_desc
       #END IF
       ##專案編號說明 l_pmdb034_desc	
       #LET sr.l_pmdb034_desc = ''
       #LET sr.l_pmdb034desc = ''
       #CALL s_desc_get_project_desc(sr.pmdb034) RETURNING sr.l_pmdb034_desc
       #IF NOT cl_null(sr.l_pmdb034_desc) THEN
       #   LET sr.l_pmdb034desc = sr.pmdb034,'.',sr.l_pmdb034_desc
       #END IF
       ##WBS說明 l_pmdb035_desc	
       #LET sr.l_pmdb035_desc = ''
       #LET sr.l_pmdb035desc = ''       
       #CALL s_desc_get_wbs_desc(sr.pmdb034,sr.pmdb035) RETURNING sr.l_pmdb035_desc 
       #IF NOT cl_null(sr.l_pmdb035_desc) THEN
       #   LET sr.l_pmdb035desc = sr.pmdb035,'.',sr.l_pmdb035_desc
       #END IF
       ##活動編號說明 l_pmdb036_desc	
       #LET sr.l_pmdb036_desc = ''
       #LET sr.l_pmdb036desc = ''
       #CALL s_desc_get_activity_desc(sr.pmdb034,sr.pmdb036) RETURNING sr.l_pmdb036_desc
       #IF NOT cl_null(sr.l_pmdb036_desc) THEN
       #   LET sr.l_pmdb036desc = sr.pmdb036,'.',sr.l_pmdb036_desc
       #END IF
       ##收貨據點說明 l_pmdb037_desc	
       #LET sr.l_pmdb037_desc = ''
       #LET sr.l_pmdb037desc = ''
       #SELECT ooefl003 INTO sr.l_pmdb037_desc FROM ooefl_t 
       # WHERE ooeflent = g_enterprise AND ooefl001 = sr.pmdb037 AND ooefl002 = g_dlang
       #IF NOT cl_null(sr.l_pmdb037_desc) THEN
       #   LET sr.l_pmdb037desc = sr.pmdb037,'.',sr.l_pmdb037_desc
       #END IF
       ##庫位名稱說明 l_pmdb038_desc	
       #LET sr.l_pmdb038_desc = ''
       #LET sr.l_pmdb038desc = ''
       #SELECT inaa002 INTO sr.l_pmdb038_desc FROM inaa_t 
       # WHERE inaaent = g_enterprise AND inaasite = sr.pmdb037 AND inaa001 = sr.pmdb038
       #IF NOT cl_null(sr.l_pmdb038_desc) THEN
       #   LET sr.l_pmdb038desc = sr.pmdb038,'.',sr.l_pmdb038_desc
       #END IF
       ##收貨儲位說明 l_pmdb039_desc	
       #LET sr.l_pmdb039_desc = ''
       #LET sr.l_pmdb039desc = ''
       #SELECT inab003 INTO sr.l_pmdb039_desc FROM inab_t 
       # WHERE inabent = g_enterprise AND inabsite = sr.pmdb037
       #   AND inab001 = sr.pmdb038 AND inab002 = sr.pmdb039
       #IF NOT cl_null(sr.l_pmdb039_desc) THEN
       #   LET sr.l_pmdb039desc = sr.pmdb039,'.',sr.l_pmdb039_desc
       #END IF
       ##費用部門說明 l_pmdb046_desc	
       #LET sr.l_pmdb046_desc = ''
       #LET sr.l_pmdb046desc = ''
       #SELECT ooefl003 INTO sr.l_pmdb046_desc FROM ooefl_t 
       # WHERE ooeflent = g_enterprise AND ooefl001 = sr.pmdb046 AND ooefl002 = g_dlang
       #IF NOT cl_null(sr.l_pmdb046_desc) THEN
       #   LET sr.l_pmdb046desc = sr.pmdb046,'.',sr.l_pmdb046_desc
       #END IF
       ##收貨時段說明 l_pmdb048_desc	
       #LET sr.l_pmdb048_desc = ''
       #LET sr.l_pmdb048desc = ''
       #SELECT oocql004 INTO sr.l_pmdb048_desc FROM oocql_t 
       # WHERE oocqlent = g_enterprise AND oocql001='274' 
       #   AND oocql002 = sr.pmdb048 AND oocql003 = g_dlang
       #IF NOT cl_null(sr.l_pmdb048_desc) THEN
       #   LET sr.l_pmdb048desc = sr.pmdb048,'.',sr.l_pmdb048_desc
       #END IF
       ##留置/結案理由碼說明 l_pmdb051_desc	
       #LET sr.l_pmdb051_desc = ''
       #LET sr.l_pmdb051desc = ''
       #IF sr.pmdastus = 'H' THEN  #留置狀態下，顯示留置理由碼說明
       #   CALL s_desc_get_acc_desc('317',sr.pmdb051) RETURNING sr.l_pmdb051_desc
       #ELSE
       #   CALL s_desc_get_acc_desc('258',sr.pmdb051) RETURNING sr.l_pmdb051_desc
       #END IF
       #
       #IF NOT cl_null(sr.l_pmdb051_desc) THEN
       #   LET sr.l_pmdb051desc = sr.pmdb051,'.',sr.l_pmdb015_desc
       #END IF
       #
       ##系列 l_imaa127_desc
       #LET sr.l_imaa127_desc = ''
       #LET sr.l_imaa127desc = ''
       #  #用料號抓取系列
       #SELECT imaa127 INTO sr.l_imaa127 FROM imaa_t
       # WHERE imaa001 = sr.pmdb004
       #   AND imaaent = g_enterprise
       #  #抓取系列說明
       #CALL s_desc_get_acc_desc('2003',sr.l_imaa127)  RETURNING sr.l_imaa127_desc   
       #IF NOT cl_null(sr.l_imaa127_desc) THEN
       #   LET sr.l_imaa127desc = sr.l_imaa127,'.',sr.l_imaa127_desc
       #END IF
       ##dorislai-20150728-add----(E)
       #151030-00002#1 20151103 mark by beckxie---E
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.pmdadocno,sr.pmdadocdt,sr.l_pmdastus_desc,sr.pmda002,sr.l_pmda002_ooag011,sr.pmdb004,sr.l_imaal003_desc,sr.l_imaal004_desc,sr.pmdb005,sr.l_imaa127,sr.l_imaa127_desc,sr.pmdb030,sr.l_pmdb031_desc,sr.l_pmdb032_desc,sr.l_pmdb033_desc,sr.pmdb006,sr.pmdb007,sr.pmdb049,sr.l_pmdb006_049_count,sr.l_imaf142,sr.l_imaf142_desc,sr.pmdb050,sr.pmda007,sr.pmdb008,sr.pmdb009,sr.pmdb014,sr.pmdb015,sr.pmdb034,sr.pmdb035,sr.pmdb036,sr.pmda003,sr.l_pmdb005_desc,sr.l_pmdb015_desc,sr.l_pmdb034_desc,sr.l_pmdb035_desc,sr.l_pmdb036_desc
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "apmr001_x01_execute"
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
 
{<section id="apmr001_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION apmr001_x01_rep_data()
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
 
{<section id="apmr001_x01.other_function" readonly="Y" >}

 
{</section>}
 
