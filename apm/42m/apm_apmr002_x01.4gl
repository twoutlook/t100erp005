#該程式未解開Section, 採用最新樣板產出!
{<section id="apmr002_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:10(2016-12-21 12:19:37), PR版次:0010(2016-12-21 16:00:27)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000163
#+ Filename...: apmr002_x01
#+ Description: ...
#+ Creator....: 05384(2014-06-09 15:36:36)
#+ Modifier...: 01534 -SD/PR- 01534
 
{</section>}
 
{<section id="apmr002_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#160411-00027#5  2016/04/13  By  dorislai  效能改善：欄位減少、說明寫成Sub-Query
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
       chk LIKE type_t.chr1          #僅顯示未交資
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="apmr002_x01.main" readonly="Y" >}
PUBLIC FUNCTION apmr002_x01(p_arg1,p_arg2)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr1         #tm.chk  僅顯示未交資
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.chk = p_arg2
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "apmr002_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL apmr002_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL apmr002_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL apmr002_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL apmr002_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL apmr002_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="apmr002_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION apmr002_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "pmdldocno.pmdl_t.pmdldocno,pmdldocdt.pmdl_t.pmdldocdt,l_pmdl005_desc.type_t.chr100,l_pmdlstus_desc.type_t.chr100,pmdoseq.pmdo_t.pmdoseq,pmdoseq1.pmdo_t.pmdoseq1,pmdoseq2.pmdo_t.pmdoseq2,l_pmdo003_desc.gzcbl_t.gzcbl004,pmdo001.pmdo_t.pmdo001,x_imaal_t_imaal003.imaal_t.imaal003,x_imaal_t_imaal004.imaal_t.imaal004,pmdo002.pmdo_t.pmdo002,l_imaa127.type_t.chr30,l_imaa127_desc.type_t.chr50,l_pmdn045_desc.gzcbl_t.gzcbl004,pmdo012.pmdo_t.pmdo012,l_pmdn052.type_t.chr1,pmdo006.pmdo_t.pmdo006,pmdo004.pmdo_t.pmdo004,pmdo022.pmdo_t.pmdo022,pmdo033.pmdo_t.pmdo033,pmdo015.pmdo_t.pmdo015,pmdo016.pmdo_t.pmdo016,pmdo017.pmdo_t.pmdo017,pmdo040.pmdo_t.pmdo040,l_undelivered.type_t.num20_6,l_pmdn050.pmdn_t.pmdn050,l_pmdn020.type_t.chr10,pmdl009.pmdl_t.pmdl009,pmdl010.pmdl_t.pmdl010,pmdl011.pmdl_t.pmdl011,pmdl012.pmdl_t.pmdl012,pmdl015.pmdl_t.pmdl015,pmdl016.pmdl_t.pmdl016,pmdl033.pmdl_t.pmdl033,pmdl043.pmdl_t.pmdl043,l_pmdl009_desc.type_t.chr30,l_pmdl010_desc.type_t.chr30,l_pmdl011_desc.type_t.chr30,l_pmdl033_desc.type_t.chr30,l_pmdl015_desc.type_t.chr30,l_pmdl043_desc.type_t.chr30,pmdl004.pmdl_t.pmdl004,pmdl002.pmdl_t.pmdl002,pmdl003.pmdl_t.pmdl003,pmdl013.pmdl_t.pmdl013,l_pmdl002_desc.ooag_t.ooag011,l_pmdl003_desc.ooefl_t.ooefl003,l_pmdl004_desc.pmaal_t.pmaal004,l_pmdo002_desc.type_t.chr30" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="apmr002_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION apmr002_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)" 
 
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
 
{<section id="apmr002_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apmr002_x01_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define(客製用) name="sel_prep.define_customerization"

#end add-point
#add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
#160328-00011#3-add-(S)
DEFINE l_ooef019     LIKE ooef_t.ooef019   #稅區
#DEFINE l_oofa001       LIKE oofa_t.oofa001 #聯絡對象識別碼  #160411-00027#5-mark
#160328-00011#3-add-(E)
#end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   #160328-00011#3-add-(S)
   SELECT ooef019 INTO l_ooef019 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site 
#   SELECT oofa001 INTO l_oofa001 FROM oofa_t WHERE oofaent = g_enterprise AND oofa002 = '1' AND oofa003 = g_site   #160411-00027#5-mark
   #160328-00011#3-add-(E)
   #end add-point
 
   #add-point:sel_prep g_select name="sel_prep.g_select"
   #160328-00011#3-mod-(S)
#   #dorislai-20150715-modify----(S)
##   LET g_select = " SELECT pmdldocno,pmdldocdt,pmdl005,'',pmdlstus,'',trim(pmdl002)||'.'||trim(ooag_t.ooag011), 
##       trim(pmdl003)||'.'||trim(t7.ooefl003),trim(pmdl004)||'.'||trim(t8.pmaal004),trim(pmdl021)||'.'||trim(t3.pmaal004), 
##       trim(pmdl022)||'.'||trim(t2.pmaal004),trim(pmdl023)||'.'||trim(oocql_t.oocql004),trim(pmdl024)||'.'||trim(t1.oocql004), 
##       pmdoseq,pmdoseq1,pmdoseq2,pmdo003,'','','',pmdo001,x.imaal_t_imaal003,x.imaal_t_imaal004,pmdo002, 
##       pmdo009,'','',pmdo012,'',pmdo006,pmdo004,pmdo029,pmdo028,pmdo031,pmdo030,pmdo022,pmdo032,pmdo033, 
##       pmdo034,pmdo015,pmdo016,pmdo017,pmdo040,'','',pmdn045,'',x.t11_oocql004"
#   LET g_select =  " SELECT pmdldocno,pmdldocdt,pmdl005,t19.gzcbl004,pmdlstus,t20.gzcbl004,trim(pmdl002)||'.'||trim(ooag_t.ooag011), 
#       trim(pmdl003)||'.'||trim(t7.ooefl003),trim(pmdl004)||'.'||trim(t8.pmaal004),trim(pmdl021)||'.'||trim(t3.pmaal004), 
#       trim(pmdl022)||'.'||trim(t2.pmaal004),trim(pmdl023)||'.'||trim(oocql_t.oocql004),trim(pmdl024)||'.'||trim(t1.oocql004), 
#       pmdoseq,pmdoseq1,pmdoseq2,pmdo003,x.t21_gzcbl004,x.imaa009,x.imaf141,pmdo001,x.imaal_t_imaal003,x.imaal_t_imaal004,pmdo002, 
#       x.imaa127,x.t22_oocql004,pmdo009,x.t23_gzcbl004,x.t24_gzcbl004,pmdo012,pmdn052,COALESCE(pmdo006,0),pmdo004,pmdo029,pmdo028,pmdo031,pmdo030,pmdo022,pmdo032,pmdo033, 
#       pmdo034,COALESCE(pmdo015,0),COALESCE(pmdo016,0),COALESCE(pmdo017,0),pmdo040,
#       (COALESCE(pmdo006,0)-COALESCE(pmdo015,0)+COALESCE(pmdo016,0)+COALESCE(pmdo017,0)),
#       pmdn050,pmdn045,pmdn020,x.t11_oocql004,pmdl006,pmdl007,pmdl008,pmdl009, 
#       pmdl010,pmdl011,pmdl012,pmdl015,pmdl016,pmdl017,pmdl018,pmdl023,pmdl027,pmdl033,pmdl043,pmdl044, 
#       pmdl051,pmdl052,pmdl053,'',ooibl_t.ooibl004,t6.pmaal004,t5.oocql004,'','',ooail_t.ooail003,pmaml_t.pmaml003,
#       ooidl_t.ooidl003,oocql_t.oocql004,t13.oocql004,icaal_t.icaal003,pmdl020,pmdl025,pmdl026,pmdl029,
#       t4.oocql004,'','',ooefl_t.ooefl003,pmdl021,pmdl022,pmdl024,pmdl031,pmdl032,pmdl054,pmdl055,t3.pmaal004,
#       t2.pmaal004,t1.oocql004,pmaal_t.pmaal004,pmdl040,pmdl041,pmdl046,oocal003,oocql_t.oocql004, 
#       pmdo005,pmdo010,pmdo011,pmdo013,pmdo014,pmdo019,pmdo020,pmdo021,pmdo023,pmdo024,pmdo025,x.t11_oocql004,'', 
#       pmdl004,'','',pmdl028,pmdl001,pmdl002,pmdl003,pmdl013,pmdl019,pmdl030,pmdl047,pmdl048,pmdl049, 
#       pmdo026,pmdo027,ooag_t.ooag011,t7.ooefl003,t8.pmaal004,gzcbl_t.gzcbl004,t14.gzcbl004,t15.gzcbl004,t16.gzcbl004,
#       t17.gzcbl004,'',x.t18_gzcbl004,x.t10_ooag011 "
#       
    #===160411-00027#5-mod-(S)
#   LET g_select =  " SELECT pmdldocno,pmdldocdt,pmdl005,t19.gzcbl004,pmdlstus,t20.gzcbl004,
#                            ooag_t.ooag011,t7.ooefl003,t8.pmaal004,t3.pmaal004,t2.pmaal004,
#                            oocql_t.oocql004,t1.oocql004,pmdoseq,pmdoseq1,pmdoseq2,pmdo003,
#                            x.t21_gzcbl004,x.imaa009,x.imaf141,pmdo001,x.imaal_t_imaal003,
#                            x.imaal_t_imaal004,pmdo002,x.imaa127,x.t22_oocql004,pmdo009,
#                            x.t23_gzcbl004,x.t24_gzcbl004,pmdo012,pmdn052,COALESCE(pmdo006,0),
#                            pmdo004,pmdo029,pmdo028,pmdo031,pmdo030,pmdo022,pmdo032,pmdo033, 
#                            pmdo034,COALESCE(pmdo015,0),COALESCE(pmdo016,0),COALESCE(pmdo017,0),pmdo040,
#                            (COALESCE(pmdo006,0)-COALESCE(pmdo015,0)+COALESCE(pmdo016,0)+COALESCE(pmdo017,0)),
#                            pmdn050,pmdn045,pmdn020,x.t11_oocql004,pmdl006,pmdl007,pmdl008,pmdl009, 
#                            pmdl010,pmdl011,pmdl012,pmdl015,pmdl016,pmdl017,pmdl018,pmdl023,pmdl027,pmdl033,pmdl043,pmdl044, 
#                            pmdl051,pmdl052,pmdl053,pmaj012,ooibl_t.ooibl004,t6.pmaal004,t5.oocql004,oodbl_t.oodbl004,isacl_t.isacl004,
#                            ooail_t.ooail003,pmaml_t.pmaml003,ooidl_t.ooidl003,t13.oocql004,icaal_t.icaal003,pmdl020,pmdl025,pmdl026,pmdl029,
#                            t4.oocql004,B1.oofb011,B2.oofb011,ooefl_t.ooefl003,pmdl021,pmdl022,pmdl024,pmdl031,pmdl032,pmdl054,pmdl055,
#                            pmaal_t.pmaal004,pmdl040,pmdl041,pmdl046,oocal003, 
#                            pmdo005,pmdo010,pmdo011,pmdo013,pmdo014,pmdo019,pmdo020,pmdo021,pmdo023,pmdo024,pmdo025,x.t11_oocql004,x.oodbl_t_oodbl004, 
#                            pmdl004,'','',pmdl028,pmdl001,pmdl002,pmdl003,pmdl013,pmdl019,pmdl030,pmdl047,pmdl048,pmdl049, 
#                            pmdo026,pmdo027,gzcbl_t.gzcbl004,t14.gzcbl004,t15.gzcbl004,t16.gzcbl004,
#                            t17.gzcbl004,'',x.t18_gzcbl004,x.t10_ooag011 "
   LET g_select =  " SELECT pmdldocno,pmdldocdt,
                            (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '2052' AND gzcbl002 = pmdl_t.pmdl005 AND gzcbl003 = '", g_dlang,"') S1_gzcbl004, 
                            (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '13' AND gzcbl002 = pmdl_t.pmdlstus AND gzcbl003 = '", g_dlang,"') S2_gzcbl004, 
                            x.pmdoseq,x.pmdoseq1,x.pmdoseq2,
                            (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '2055' AND gzcbl002 = x.pmdo003 AND gzcbl003 = '", g_dlang,"') S3_gzcbl004, 
                            x.pmdo001,
                            (SELECT imaal003 FROM imaal_t WHERE imaal001 = x.pmdo001 AND imaalent = x.pmdoent AND imaal002 = '", g_dlang,"') imaal003,
                            (SELECT imaal004 FROM imaal_t WHERE imaal001 = x.pmdo001 AND imaalent = x.pmdoent AND imaal002 = '", g_dlang,"') imaal004,
                            x.pmdo002,x.imaa127,
                            (SELECT oocql004 FROM oocql_t WHERE oocql001 = '2003' AND oocql002 = x.imaa127 AND oocqlent = x.pmdoent AND oocql003 = '", g_dlang,"') A1_oocql004,
                            (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '2035' AND gzcbl002 = x.pmdn045 AND gzcbl003 = '", g_dlang,"')  S4_gzcbl004,
                            x.pmdo012,x.pmdn052,COALESCE(x.pmdo006,0),x.pmdo004,x.pmdo022,x.pmdo033,COALESCE(x.pmdo015,0),
                            COALESCE(pmdo016,0),COALESCE(pmdo017,0),pmdo040,
                            (COALESCE(x.pmdo006,0)-COALESCE(x.pmdo015,0)+COALESCE(x.pmdo016,0)+COALESCE(x.pmdo017,0)),
                            x.pmdn050,x.pmdn020,pmdl009, 
                            pmdl010,pmdl011,pmdl012,pmdl015,pmdl016,pmdl033,pmdl043,
                            (SELECT ooibl004 FROM ooibl_t WHERE ooibl002 = pmdl009 AND ooiblent = pmdlent AND ooibl003 = '",g_dlang,"') ooibl004,
                            (SELECT oocql004 FROM oocql_t WHERE oocql001 = '238' AND oocql002 = pmdl010 AND oocqlent = pmdlent AND oocql003 = '",g_dlang,"') A2_oocql004,
                            (SELECT oodbl004 FROM oodbl_t WHERE pmdlent = oodblent AND oodbl001 = '",l_ooef019,"' AND pmdl011 = oodbl002 AND oodbl003 = '",g_dlang,"') oodbl004,
                            (SELECT isacl004 FROM isacl_t WHERE pmdlent = isaclent AND isacl001 = '",l_ooef019,"' AND pmdl033 = isacl002 AND isacl003 = '",g_dlang,"')  isacl004,
                            (SELECT ooail003 FROM ooail_t WHERE ooail001 = pmdl015 AND ooailent = pmdlent AND ooail002 = '",g_dlang,"') ooail003,
                            (SELECT oocql004 FROM oocql_t WHERE oocql001 = '317' AND oocql002 = pmdl043 AND oocqlent = pmdlent AND oocql003 = '",g_dlang,"') A2_oocql004,
                            pmdl004,pmdl002,pmdl003,pmdl013,
                            (SELECT ooag011 FROM ooag_t WHERE ooag001 = pmdl002 AND ooagent = pmdlent) ooag011,
                            (SELECT ooefl003 FROM ooefl_t WHERE ooefl001 = pmdl003 AND ooeflent = pmdlent AND ooefl002 = '",g_dlang,"') ooefl003, 
                            (SELECT pmaal004 FROM pmaal_t WHERE pmaal001 = pmdl004 AND pmaalent = pmdlent AND pmaal002 = '",g_dlang,"') pmaal004, 
                            (SELECT inaml004 FROM inaml_t WHERE inamlent=x.pmdoent AND inaml001=x.pmdo001 AND inaml002=x.pmdo002 AND inaml003='",g_dlang,"') inaml004 "  
   #===160411-00027#5-mod-(E)
   #160328-00011#3-mod-(E)
#   #end add-point
#   LET g_select = " SELECT pmdldocno,pmdldocdt,'','',pmdoseq,pmdoseq1,pmdoseq2,'',pmdo001,x.imaal_t_imaal003, 
#       x.imaal_t_imaal004,pmdo002,'','','',pmdo012,'',pmdo006,pmdo004,pmdo022,pmdo033,pmdo015,pmdo016, 
#       pmdo017,pmdo040,'','','',pmdl009,pmdl010,pmdl011,pmdl012,pmdl015,pmdl016,pmdl033,pmdl043,'','', 
#       '','','','',pmdl004,pmdl002,pmdl003,pmdl013,'',NULL,NULL,''"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   #160328-00011#3-mod-(S)
#    LET g_from = " FROM pmdl_t LEFT OUTER JOIN pmaal_t ON pmaal_t.pmaal001 = pmdl_t.pmdl032 AND pmaal_t.pmaalent = pmdl_t.pmdlent AND pmaal_t.pmaal002 = '" , g_dlang,"'" ,
#                     #160328-00011#3-add-(S)
#                     "            LEFT OUTER JOIN pmaj_t ON pmdlent = pmajent AND pmdl004 = pmaj001 AND pmdl027 = pmaj002 ", 
#                     "            LEFT OUTER JOIN oodbl_t ON pmdlent = oodblent AND oodbl001 = '",l_ooef019,"' AND pmdl011 = oodbl002 AND oodbl003 = '",g_dlang,"' ",
#                     "            LEFT OUTER JOIN isacl_t ON pmdlent = isaclent AND isacl001 = '",l_ooef019,"' AND pmdl033 = isacl002 AND isacl003 = '",g_dlang,"' ",
#                     "            LEFT OUTER JOIN oofb_t B1 ON pmdlent = B1.oofbent AND B1.oofb002 = '",l_oofa001,"' AND B1.oofb008 = '3' AND pmdl025 = B1.oofb019 ",
#                     "            LEFT OUTER JOIN oofb_t B2 ON pmdlent = B2.oofbent AND B2.oofb002 = '",l_oofa001,"' AND B2.oofb008 = '5' AND pmdl026 = B2.oofb019 ",
#                     #160328-00011#3-add-(E)
#                     "             LEFT OUTER JOIN ooag_t ON ooag_t.ooag001 = pmdl_t.pmdl002 AND ooag_t.ooagent = pmdl_t.pmdlent             LEFT OUTER JOIN oocql_t ON oocql_t.oocql001 = '264' AND oocql_t.oocql002 = pmdl_t.pmdl023 AND oocql_t.oocqlent = pmdl_t.pmdlent AND oocql_t.oocql003 = '" , 
#        g_dlang,"'" ,"             LEFT OUTER JOIN oocql_t t1 ON t1.oocql001 = '264' AND t1.oocql002 = pmdl_t.pmdl024 AND t1.oocqlent = pmdl_t.pmdlent AND t1.oocql003 = '" , 
#        g_dlang,"'" ,"             LEFT OUTER JOIN oofa_t ON oofa_t.oofa001 = pmdl_t.pmdl027 AND oofa_t.oofaent = pmdl_t.pmdlent             LEFT OUTER JOIN ooefl_t ON ooefl_t.ooefl001 = pmdl_t.pmdl029 AND ooefl_t.ooeflent = pmdl_t.pmdlent AND ooefl_t.ooefl002 = '" , 
#        g_dlang,"'" ,"             LEFT OUTER JOIN pmaal_t t2 ON t2.pmaal001 = pmdl_t.pmdl022 AND t2.pmaalent = pmdl_t.pmdlent AND t2.pmaal002 = '" , 
#        g_dlang,"'" ,"             LEFT OUTER JOIN pmaal_t t3 ON t3.pmaal001 = pmdl_t.pmdl021 AND t3.pmaalent = pmdl_t.pmdlent AND t3.pmaal002 = '" , 
#        g_dlang,"'" ,"             LEFT OUTER JOIN oocql_t t4 ON t4.oocql001 = '263' AND t4.oocql002 = pmdl_t.pmdl020 AND t4.oocqlent = pmdl_t.pmdlent AND t4.oocql003 = '" , 
#        g_dlang,"'" ,"             LEFT OUTER JOIN ooidl_t ON ooidl_t.ooidl001 = pmdl_t.pmdl018 AND ooidl_t.ooidlent = pmdl_t.pmdlent AND ooidl_t.ooidl002 = '" , 
#        g_dlang,"'" ,"             LEFT OUTER JOIN pmaml_t ON pmaml_t.pmaml001 = pmdl_t.pmdl017 AND pmaml_t.pmamlent = pmdl_t.pmdlent AND pmaml_t.pmaml002 = '" , 
#        g_dlang,"'" ,"             LEFT OUTER JOIN ooail_t ON ooail_t.ooail001 = pmdl_t.pmdl015 AND ooail_t.ooailent = pmdl_t.pmdlent AND ooail_t.ooail002 = '" , 
#        g_dlang,"'" ,"             LEFT OUTER JOIN oocql_t t5 ON t5.oocql001 = '238' AND t5.oocql002 = pmdl_t.pmdl010 AND t5.oocqlent = pmdl_t.pmdlent AND t5.oocql003 = '" , 
#        g_dlang,"'" ,"             LEFT OUTER JOIN pmaal_t t6 ON t6.pmaal001 = pmdl_t.pmdl052 AND t6.pmaalent = pmdl_t.pmdlent AND t6.pmaal002 = '" , 
#        g_dlang,"'" ,"             LEFT OUTER JOIN ooefl_t t7 ON t7.ooefl001 = pmdl_t.pmdl003 AND t7.ooeflent = pmdl_t.pmdlent AND t7.ooefl002 = '" , 
#        g_dlang,"'" ,"             LEFT OUTER JOIN pmaal_t t8 ON t8.pmaal001 = pmdl_t.pmdl004 AND t8.pmaalent = pmdl_t.pmdlent AND t8.pmaal002 = '" , 
#        g_dlang,"'" ,"             LEFT OUTER JOIN ooibl_t ON ooibl_t.ooibl002 = pmdl_t.pmdl009 AND ooibl_t.ooiblent = pmdl_t.pmdlent AND ooibl_t.ooibl003 = '" , 
#        g_dlang,"'" ,"             LEFT OUTER JOIN oocql_t t13 ON t13.oocql001 = '317' AND t13.oocql002 = pmdl_t.pmdl043 AND t13.oocqlent = pmdl_t.pmdlent AND t13.oocql003 = '" , 
#        g_dlang,"'" ,"             LEFT OUTER JOIN icaal_t ON icaal_t.icaal001 = pmdl_t.pmdl051 AND icaal_t.icaalent = pmdl_t.pmdlent AND icaal_t.icaal002 = '" , 
#        g_dlang,"'" ,"             LEFT OUTER JOIN gzcbl_t ON gzcbl_t.gzcbl001 = '2053' AND gzcbl_t.gzcbl002 = pmdl_t.pmdl006 AND gzcbl_t.gzcbl003 = '" , 
#        g_dlang,"'" ,"             LEFT OUTER JOIN gzcbl_t t14 ON t14.gzcbl001 = '2054' AND t14.gzcbl002 = pmdl_t.pmdl007 AND t14.gzcbl003 = '" , 
#        g_dlang,"'" ,"             LEFT OUTER JOIN gzcbl_t t15 ON t15.gzcbl001 = '2087' AND t15.gzcbl002 = pmdl_t.pmdl054 AND t15.gzcbl003 = '" , 
#        g_dlang,"'" ,"             LEFT OUTER JOIN gzcbl_t t16 ON t16.gzcbl001 = '2086' AND t16.gzcbl002 = pmdl_t.pmdl055 AND t16.gzcbl003 = '" , 
#        g_dlang,"'" ,"             LEFT OUTER JOIN gzcbl_t t17 ON t17.gzcbl001 = '8321' AND t17.gzcbl002 = pmdl_t.pmdl046 AND t17.gzcbl003 = '" , 
#        g_dlang,"'" ,"             LEFT OUTER JOIN gzcbl_t t19 ON t19.gzcbl001 = '2052' AND t19.gzcbl002 = pmdl_t.pmdl005 AND t19.gzcbl003 = '" , 
#        g_dlang,"'" ,"             LEFT OUTER JOIN gzcbl_t t20 ON t20.gzcbl001 = '13' AND t20.gzcbl002 = pmdl_t.pmdlstus AND t20.gzcbl003 = '" , 
#        g_dlang,"'" ," LEFT OUTER JOIN ( SELECT pmdo_t.*,pmdn_t.*,t23.gzcbl004 t23_gzcbl004,imaal_t.imaal003 imaal_t_imaal003,imaal_t.imaal004 imaal_t_imaal004, 
#        t10.ooag011 t10_ooag011,t11.oocql004 t11_oocql004,t18.gzcbl004 t18_gzcbl004,t21.gzcbl004 t21_gzcbl004,t24.gzcbl004 t24_gzcbl004,imaf141,imaa009,imaa127,t22.oocql004 t22_oocql004,oocal_t.oocal003,oodbl_t.oodbl004 oodbl_t_oodbl004 ", #160328-00011#3-add-'oodbl_t.oodbl004 oodbl_t_oodbl004'
#                     "             FROM pmdo_t             LEFT OUTER JOIN oocal_t ON oocal_t.oocal001 = pmdo_t.pmdo030 AND oocal_t.oocalent = pmdo_t.pmdoent AND oocal_t.oocal002 = '" , g_dlang,"'" ,
#                     "             LEFT OUTER JOIN oodbl_t ON pmdoent = oodblent AND oodbl001 = '",l_ooef019,"' AND pmdo023 = oodbl002 AND oodbl003 = '",g_dlang,"' ",     #160328-00011#3-add
#                     "             LEFT OUTER JOIN oocal_t t9 ON t9.oocal001 = pmdo_t.pmdo028 AND t9.oocalent = pmdo_t.pmdoent AND t9.oocal002 = '" , 
#        g_dlang,"'" ,"             LEFT OUTER JOIN ooag_t t10 ON t10.ooag001 = pmdo_t.pmdo026 AND t10.ooagent = pmdo_t.pmdoent             LEFT OUTER JOIN oocql_t t11 ON t11.oocql001 = '274' AND t11.oocql002 = pmdo_t.pmdo010 AND t11.oocqlent = pmdo_t.pmdoent AND t11.oocql003 = '" , 
#        g_dlang,"'" ,"             LEFT OUTER JOIN imaa_t ON imaa_t.imaa001 = pmdo_t.pmdo001 AND imaa_t.imaaent = pmdo_t.pmdoent           LEFT OUTER JOIN oocal_t t12 ON t12.oocal001 = pmdo_t.pmdo004 AND t12.oocalent = pmdo_t.pmdoent AND t12.oocal002 = '" , 
#        g_dlang,"'" ,"             LEFT OUTER JOIN imaf_t ON imaf_t.imaf001 = pmdo_t.pmdo001 AND imaf_t.imafent = pmdo_t.pmdoent AND imaf_t.imafsite = '" , 
#        g_site,"'" ,"             LEFT OUTER JOIN imaal_t ON imaal_t.imaal001 = pmdo_t.pmdo001 AND imaal_t.imaalent = pmdo_t.pmdoent AND imaal_t.imaal002 = '" , 
#        g_dlang,"'" ,"             LEFT OUTER JOIN gzcbl_t t18 ON t18.gzcbl001 = '2058' AND t18.gzcbl002 = pmdo_t.pmdo021 AND t18.gzcbl003 = '" , 
#        g_dlang,"'" ,"             LEFT OUTER JOIN gzcbl_t t21 ON t21.gzcbl001 = '2055' AND t21.gzcbl002 = pmdo_t.pmdo003 AND t21.gzcbl003 = '" , 
#        g_dlang,"'" ,"             LEFT OUTER JOIN oocql_t t22 ON t22.oocql001 = '2003' AND t22.oocql002 = imaa_t.imaa127 AND t22.oocqlent = imaa_t.imaaent AND t22.oocql003 = '" , 
#        g_dlang,"'" ,"             LEFT OUTER JOIN gzcbl_t t24 ON t24.gzcbl001 = '2057' AND t24.gzcbl002 = pmdo_t.pmdo009 AND t24.gzcbl003 = '" , 
#        g_dlang,"'" ,"            LEFT OUTER JOIN pmdn_t ON pmdn_t.pmdnseq = pmdo_t.pmdoseq AND pmdn_t.pmdnent = pmdo_t.pmdoent AND pmdn_t.pmdndocno = pmdo_t.pmdodocno ",
#                     "             LEFT OUTER JOIN gzcbl_t t23 ON t23.gzcbl001 = '2035' AND t23.gzcbl002 = pmdn_t.pmdn045 AND t23.gzcbl003 = '" , 
#        g_dlang,"' ) x  ON pmdl_t.pmdlent = x.pmdoent AND pmdl_t.pmdldocno = x.pmdodocno"
     LET g_from = " FROM pmdl_t ",
                  " LEFT OUTER JOIN ( SELECT pmdo_t.*,pmdn_t.*,imaa_t.*,imaf141",
                  "                     FROM pmdo_t ",
                  "                     LEFT OUTER JOIN pmdn_t ON pmdn_t.pmdnseq = pmdo_t.pmdoseq AND pmdn_t.pmdnent = pmdo_t.pmdoent AND pmdn_t.pmdndocno = pmdo_t.pmdodocno ",
                  "                     LEFT OUTER JOIN imaa_t ON imaa_t.imaa001 = pmdo_t.pmdo001 AND imaa_t.imaaent = pmdo_t.pmdoent ",
                  "                     LEFT OUTER JOIN imaf_t ON imaf_t.imaf001 = pmdo_t.pmdo001 AND imaf_t.imafent = pmdo_t.pmdoent AND imaf_t.imafsite = '", g_site,"'",
                  " ) x  ON pmdl_t.pmdlent = x.pmdoent AND pmdl_t.pmdldocno = x.pmdodocno"
    #160328-00011#3-mod-(E)                

#   #end add-point
#    LET g_from = " FROM pmdl_t LEFT OUTER JOIN ( SELECT pmdo_t.*,( SELECT imaal003 FROM imaal_t WHERE imaal_t.imaal001 = pmdo_t.pmdo001 AND imaal_t.imaalent = pmdo_t.pmdoent AND imaal_t.imaal002 = '" , 
#        g_dlang,"'" ,") imaal_t_imaal003,( SELECT imaal004 FROM imaal_t WHERE imaal_t.imaal001 = pmdo_t.pmdo001 AND imaal_t.imaalent = pmdo_t.pmdoent AND imaal_t.imaal002 = '" , 
#        g_dlang,"'" ,") imaal_t_imaal004 FROM pmdo_t ) x  ON pmdl_t.pmdlent = x.pmdoent AND pmdl_t.pmdldocno  
#        = x.pmdodocno"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
    IF tm.chk = 'Y' THEN
       LET g_where = " WHERE " ,tm.wc CLIPPED," AND (COALESCE(pmdo006,0)-COALESCE(pmdo015,0)+COALESCE(pmdo016,0)+COALESCE(pmdo017,0)) > 0 AND pmdn045 NOT IN ('2','3','4') "
    ELSE
       LET g_where = " WHERE " ,tm.wc CLIPPED
    END IF
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("pmdl_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE apmr002_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE apmr002_x01_curs CURSOR FOR apmr002_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="apmr002_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION apmr002_x01_ins_data()
DEFINE sr RECORD 
   pmdldocno LIKE pmdl_t.pmdldocno, 
   pmdldocdt LIKE pmdl_t.pmdldocdt, 
   l_pmdl005_desc LIKE type_t.chr100, 
   l_pmdlstus_desc LIKE type_t.chr100, 
   pmdoseq LIKE pmdo_t.pmdoseq, 
   pmdoseq1 LIKE pmdo_t.pmdoseq1, 
   pmdoseq2 LIKE pmdo_t.pmdoseq2, 
   l_pmdo003_desc LIKE gzcbl_t.gzcbl004, 
   pmdo001 LIKE pmdo_t.pmdo001, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   x_imaal_t_imaal004 LIKE imaal_t.imaal004, 
   pmdo002 LIKE pmdo_t.pmdo002, 
   l_imaa127 LIKE type_t.chr30, 
   l_imaa127_desc LIKE type_t.chr50, 
   l_pmdn045_desc LIKE gzcbl_t.gzcbl004, 
   pmdo012 LIKE pmdo_t.pmdo012, 
   l_pmdn052 LIKE type_t.chr1, 
   pmdo006 LIKE pmdo_t.pmdo006, 
   pmdo004 LIKE pmdo_t.pmdo004, 
   pmdo022 LIKE pmdo_t.pmdo022, 
   pmdo033 LIKE pmdo_t.pmdo033, 
   pmdo015 LIKE pmdo_t.pmdo015, 
   pmdo016 LIKE pmdo_t.pmdo016, 
   pmdo017 LIKE pmdo_t.pmdo017, 
   pmdo040 LIKE pmdo_t.pmdo040, 
   l_undelivered LIKE type_t.num20_6, 
   l_pmdn050 LIKE pmdn_t.pmdn050, 
   l_pmdn020 LIKE type_t.chr10, 
   pmdl009 LIKE pmdl_t.pmdl009, 
   pmdl010 LIKE pmdl_t.pmdl010, 
   pmdl011 LIKE pmdl_t.pmdl011, 
   pmdl012 LIKE pmdl_t.pmdl012, 
   pmdl015 LIKE pmdl_t.pmdl015, 
   pmdl016 LIKE pmdl_t.pmdl016, 
   pmdl033 LIKE pmdl_t.pmdl033, 
   pmdl043 LIKE pmdl_t.pmdl043, 
   l_pmdl009_desc LIKE type_t.chr30, 
   l_pmdl010_desc LIKE type_t.chr30, 
   l_pmdl011_desc LIKE type_t.chr30, 
   l_pmdl033_desc LIKE type_t.chr30, 
   l_pmdl015_desc LIKE type_t.chr30, 
   l_pmdl043_desc LIKE type_t.chr30, 
   pmdl004 LIKE pmdl_t.pmdl004, 
   pmdl002 LIKE pmdl_t.pmdl002, 
   pmdl003 LIKE pmdl_t.pmdl003, 
   pmdl013 LIKE pmdl_t.pmdl013, 
   l_pmdl002_desc LIKE ooag_t.ooag011, 
   l_pmdl003_desc LIKE ooefl_t.ooefl003, 
   l_pmdl004_desc LIKE pmaal_t.pmaal004, 
   l_pmdo002_desc LIKE type_t.chr30
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_pmdo012_count LIKE type_t.num5   #未來預計交貨天數
DEFINE l_desc          LIKE type_t.chr100 

DEFINE l_ooef019       LIKE ooef_t.ooef019 #稅區           dorislai-20150716-add----(S)
DEFINE l_oofa001       LIKE oofa_t.oofa001 #聯絡對象識別碼
DEFINE l_success       LIKE type_t.num5
DEFINE l_pmaa004       LIKE pmaa_t.pmaa004 #法人類型        dorislai-20150716-add----(E)          
DEFINE l_pmdl028       LIKE pmdl_t.pmdl028 #161207-00033#22
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    #160328-00011#3-add-(S)
    #先獲取當前營運據點的聯絡對象識別碼
    SELECT oofa001 INTO l_oofa001 FROM oofa_t WHERE oofaent = g_enterprise AND oofa002 = '1' AND oofa003 = g_site
    #160328-00011#3-add-(E)
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH apmr002_x01_curs INTO sr.*                               
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
       SELECT pmdl028 INTO l_pmdl028 FROM pmdl_t
        WHERE pmdlent = g_enterprise
          AND pmdldocno = sr.pmdldocno
       IF NOT cl_null(l_pmdl028) THEN
          CALL s_desc_get_oneturn_guest_desc(l_pmdl028) RETURNING sr.l_pmdl004_desc
       END IF       
       #161207-00033#22-E
#       LET sr.l_overdue = 0
#       IF (g_today - sr.pmdo012) < 0 THEN
#          LET sr.l_overdue = 0
#          LET l_pmdo012_count = (sr.pmdo012 - g_today)
#       ELSE
#          LET sr.l_overdue = (g_today - sr.pmdo012)
#          LET l_pmdo012_count = 0
#       END IF
#       IF cl_null(sr.l_overdue) THEN LET sr.l_overdue = 0 END IF
#       IF cl_null(l_pmdo012_count) THEN LET l_pmdo012_count = 0 END IF
#       #逾期交貨天數&未來預計交貨天數的判斷
#       CASE tm.a1
#          WHEN '1'
#             CASE tm.a3
#                WHEN '1'
#                   IF (sr.l_overdue >= tm.a2) OR (l_pmdo012_count >= tm.a4) THEN
#                      CONTINUE FOREACH
#                   END IF
#                WHEN '2'
#                   IF (sr.l_overdue >= tm.a2) OR (l_pmdo012_count > tm.a4) THEN
#                      CONTINUE FOREACH
#                   END IF
#                WHEN '3'
#                   IF (sr.l_overdue >= tm.a2) OR (l_pmdo012_count <> tm.a4) THEN
#                      CONTINUE FOREACH
#                   END IF
#                WHEN '4'
#                   IF (sr.l_overdue >= tm.a2) OR (l_pmdo012_count <= tm.a4) THEN
#                      CONTINUE FOREACH
#                   END IF
#                OTHERWISE
#                   IF (sr.l_overdue >= tm.a2) OR (l_pmdo012_count < tm.a4) THEN
#                      CONTINUE FOREACH
#                   END IF
#             END CASE
#          WHEN '2'
#             CASE tm.a3
#                WHEN '1'
#                   IF (sr.l_overdue > tm.a2) OR (l_pmdo012_count >= tm.a4) THEN
#                      CONTINUE FOREACH
#                   END IF
#                WHEN '2'
#                   IF (sr.l_overdue > tm.a2) OR (l_pmdo012_count > tm.a4) THEN
#                      CONTINUE FOREACH
#                   END IF
#                WHEN '3'
#                   IF (sr.l_overdue > tm.a2) OR (l_pmdo012_count <> tm.a4) THEN
#                      CONTINUE FOREACH
#                   END IF
#                WHEN '4'
#                   IF (sr.l_overdue > tm.a2) OR (l_pmdo012_count <= tm.a4) THEN
#                      CONTINUE FOREACH
#                   END IF
#                OTHERWISE
#                   IF (sr.l_overdue > tm.a2) OR (l_pmdo012_count < tm.a4) THEN
#                      CONTINUE FOREACH
#                   END IF
#             END CASE
#          WHEN '3'
#             CASE tm.a3
#                WHEN '1'
#                   IF (sr.l_overdue <> tm.a2) OR (l_pmdo012_count >= tm.a4) THEN
#                      CONTINUE FOREACH
#                   END IF
#                WHEN '2'
#                   IF (sr.l_overdue <> tm.a2) OR (l_pmdo012_count > tm.a4) THEN
#                      CONTINUE FOREACH
#                   END IF
#                WHEN '3'
#                   IF (sr.l_overdue <> tm.a2) OR (l_pmdo012_count <> tm.a4) THEN
#                      CONTINUE FOREACH
#                   END IF
#                WHEN '4'
#                   IF (sr.l_overdue <> tm.a2) OR (l_pmdo012_count <= tm.a4) THEN
#                      CONTINUE FOREACH
#                   END IF
#                OTHERWISE
#                   IF (sr.l_overdue <> tm.a2) OR (l_pmdo012_count < tm.a4) THEN
#                      CONTINUE FOREACH
#                   END IF
#             END CASE
#          WHEN '4'
#             CASE tm.a3
#                WHEN '1'
#                   IF (sr.l_overdue <= tm.a2) OR (l_pmdo012_count >= tm.a4) THEN
#                      CONTINUE FOREACH
#                   END IF
#                WHEN '2'
#                   IF (sr.l_overdue <= tm.a2) OR (l_pmdo012_count > tm.a4) THEN
#                      CONTINUE FOREACH
#                   END IF
#                WHEN '3'
#                   IF (sr.l_overdue <= tm.a2) OR (l_pmdo012_count <> tm.a4) THEN
#                      CONTINUE FOREACH
#                   END IF
#                WHEN '4'
#                   IF (sr.l_overdue <= tm.a2) OR (l_pmdo012_count <= tm.a4) THEN
#                      CONTINUE FOREACH
#                   END IF
#                OTHERWISE
#                   IF (sr.l_overdue <= tm.a2) OR (l_pmdo012_count < tm.a4) THEN
#                      CONTINUE FOREACH
#                   END IF
#             END CASE
#          OTHERWISE
#             CASE tm.a3
#                WHEN '1'
#                   IF (sr.l_overdue < tm.a2) OR (l_pmdo012_count >= tm.a4) THEN
#                      CONTINUE FOREACH
#                   END IF
#                WHEN '2'
#                   IF (sr.l_overdue < tm.a2) OR (l_pmdo012_count > tm.a4) THEN
#                      CONTINUE FOREACH
#                   END IF
#                WHEN '3'
#                   IF (sr.l_overdue < tm.a2) OR (l_pmdo012_count <> tm.a4) THEN
#                      CONTINUE FOREACH
#                   END IF
#                WHEN '4'
#                   IF (sr.l_overdue < tm.a2) OR (l_pmdo012_count <= tm.a4) THEN
#                      CONTINUE FOREACH
#                   END IF
#                OTHERWISE
#                   IF (sr.l_overdue < tm.a2) OR (l_pmdo012_count < tm.a4) THEN
#                      CONTINUE FOREACH
#                   END IF
#             END CASE
#       END CASE

#       #未交量
#       LET sr.l_undelivered = 0
#       IF cl_null(sr.pmdo006) THEN LET sr.pmdo006 = 0 END IF
#       IF cl_null(sr.pmdo015) THEN LET sr.pmdo015 = 0 END IF
#       IF cl_null(sr.pmdo016) THEN LET sr.pmdo016 = 0 END IF
#       IF cl_null(sr.pmdo017) THEN LET sr.pmdo017 = 0 END IF
#       LET sr.l_undelivered = sr.pmdo006 - sr.pmdo015 + sr.pmdo016 + sr.pmdo017
#       #打勾時，僅顯示未交量>0的資料
#       IF tm.chk = 'Y' AND (sr.l_undelivered <= 0 OR sr.l_pmdn045 MATCHES "[234]")THEN
#          CONTINUE FOREACH
#       END IF
       
       #行狀態
#       CALL s_desc_gzcbl004_desc('2035',sr.l_pmdn045) RETURNING sr.l_pmdn045_desc
       #採購單類型
#       CALL s_desc_gzcbl004_desc('2052',sr.pmdl005) RETURNING sr.l_pmdl005_desc
       #dorislai-20150803-add----(S)
#       LET sr.l_pmdl005desc = ''
#       IF NOT cl_null(sr.l_pmdl005_desc) THEN
#          LET sr.l_pmdl005desc = sr.pmdl005,'.',sr.l_pmdl005_desc
#       END IF
       #dorislai-20150803-add----(E)
       #狀態
#       CALL s_desc_gzcbl004_desc('13',sr.pmdlstus) RETURNING sr.l_pmdlstus_desc
       #dorislai-20150803-add----(S)
#       LET sr.l_pmdlstusdesc = ''
#       IF NOT cl_null(sr.l_pmdlstus_desc) THEN
#          LET sr.l_pmdlstusdesc = sr.pmdlstus,'.',sr.l_pmdlstus_desc
#       END IF
       #dorislai-20150803-add----(E)
       #子件特性
#       CALL s_desc_gzcbl004_desc('2055',sr.pmdo003) RETURNING sr.l_pmdo003_desc
       #產品分類
#       SELECT imaa009 INTO sr.l_imaa009 FROM imaa_t
#        WHERE imaaent = g_enterprise AND imaa001 = sr.pmdo001
#       CALL s_desc_get_rtaxl003_desc(sr.l_imaa009) RETURNING l_desc
#       IF NOT cl_null(sr.l_imaa009) AND NOT cl_null(l_desc) THEN
#          LET sr.l_imaa009 = sr.l_imaa009,'.',l_desc
#       END IF
       #採購分群
#       SELECT imaf141 INTO sr.l_imaf141 FROM imaf_t
#        WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = sr.pmdo001
#       CALL s_desc_gzcbl004_desc('203',sr.l_imaf141) RETURNING l_desc
#       IF NOT cl_null(sr.l_imaf141) AND NOT cl_null(l_desc) THEN
#          LET sr.l_imaf141 = sr.l_imaf141,'.',l_desc
#       END IF
       #交期類型
#       CALL s_desc_gzcbl004_desc('2057',sr.pmdo009) RETURNING sr.l_pmdo009_desc
#       #dorislai-20150803-add----(S)
#       LET sr.l_pmdo009desc = ''
#       IF NOT cl_null(sr.l_pmdo009_desc) THEN
#          LET sr.l_pmdo009desc = sr.pmdo009,'.',sr.l_pmdo009_desc
#       END IF
       #dorislai-20150803-add----(E)
       #檢驗、行狀態、緊急度
#       SELECT pmdn052,pmdn050,pmdn045,pmdn020 INTO sr.l_pmdn052,sr.l_pmdn050,sr.l_pmdn045,sr.l_pmdn020 FROM pmdn_t
#        WHERE pmdnent = g_enterprise AND pmdndocno = sr.pmdldocno AND pmdnseq = sr.pmdoseq
#       
       #dorislai-20150716-add----(S)
       #組欄位與說明
       #單頭
       #----採購人員&說明(l_pmdl002desc) 
#       LET sr.l_pmdl002_desc = ''
#       LET sr.l_pmdl002desc = ''
#       SELECT ooag011 INTO sr.l_pmdl002_desc FROM ooag_t 
#        WHERE ooagent = g_enterprise AND ooag001 = sr.pmdl002
#       IF NOT cl_null(sr.l_pmdl002_desc) THEN
#          LET sr.l_pmdl002desc = sr.pmdl002,'.',sr.l_pmdl002_desc
#       END IF
       #----採購部門&說明(l_pmdl003desc) 
#       LET sr.l_pmdl003_desc = ''
#       LET sr.l_pmdl003desc = ''
#       SELECT ooefl003 INTO sr.l_pmdl003_desc FROM ooefl_t 
#        WHERE ooeflent = g_enterprise AND ooefl001 = sr.pmdl003 AND ooefl002 = g_dlang
#       IF NOT cl_null(sr.l_pmdl003_desc) THEN
#          LET sr.l_pmdl003desc = sr.pmdl003,'.',sr.l_pmdl003_desc
#       END IF
       #----供應商編號&說明(l_pmdl004desc) 
#       LET sr.l_pmdl004_desc = ''
#       LET sr.l_pmdl004desc = ''
#
#       SELECT pmaal004 INTO sr.l_pmdl004_desc FROM pmaal_t 
#        WHERE pmaalent = g_enterprise AND pmaal001 = sr.pmdl004 AND pmaal002 = g_dlang
#       
#       IF NOT cl_null(sr.l_pmdl004_desc) THEN
#          LET sr.l_pmdl004desc = sr.pmdl004,'.',sr.l_pmdl004_desc
#       END IF
       #單頭----交易資訊
       #----多角性質&說明(l_pmdl006desc) 
#       LET sr.l_pmdl006_desc = ''
#       LET sr.l_pmdl006desc = ''
#       CALL s_desc_gzcbl004_desc('2053',sr.pmdl006) RETURNING sr.l_pmdl006_desc
#       IF NOT cl_null(sr.l_pmdl006_desc) THEN
#          LET sr.l_pmdl006desc = sr.pmdl006,'.',sr.l_pmdl006_desc
#       END IF
       #----資料來源類型&說明(l_pmdl007desc) 
#       LET sr.l_pmdl007_desc = ''
#       LET sr.l_pmdl007desc = ''
#       CALL s_desc_gzcbl004_desc('2054',sr.pmdl007) RETURNING sr.l_pmdl007_desc
#       IF NOT cl_null(sr.l_pmdl007_desc) THEN
#          LET sr.l_pmdl007desc = sr.pmdl007,'.',sr.l_pmdl007_desc
#       END IF
       #160328-00011#3-mark-(S)
#       #----供應商聯絡人&說明(l_pmdl027desc)
#       LET sr.l_pmdl027_desc = ''
##       LET sr.l_pmdl027desc = ''
#       SELECT pmaj012 INTO sr.l_pmdl027_desc FROM pmaj_t
#        WHERE pmajent = g_enterprise AND pmaj001 = sr.pmdl004 AND pmaj002 = sr.pmdl027
       #160328-00011#3-mark-(E) 
#       IF NOT cl_null(sr.l_pmdl027_desc) THEN
#          LET sr.l_pmdl027desc = sr.pmdl027,'.',sr.l_pmdl027_desc  #組合說明
#       END IF
       #----最終供應商&說明(l_pmdl052desc)  
#       LET sr.l_pmdl052_desc = ''       
#       LET sr.l_pmdl052desc = ''       
#       SELECT pmaal004 INTO sr.l_pmdl052_desc FROM pmaal_t 
#        WHERE pmaalent = g_enterprise AND pmaal001 = sr.pmdl052 AND pmaal002 = g_dlang
#       IF NOT cl_null(sr.l_pmdl052_desc) THEN
#          LET sr.l_pmdl052desc = sr.pmdl052,'.',sr.l_pmdl052_desc  #組合說明
#       END IF
       #----付款條件&說明(l_pmdl009desc) 
#       LET sr.l_pmdl009_desc = ''
#       LET sr.l_pmdl009desc = ''
#       SELECT ooibl004 INTO sr.l_pmdl009_desc FROM ooibl_t 
#        WHERE ooiblent = g_enterprise AND ooibl002 = sr.pmdl009 AND ooibl003 = g_dlang
#       IF NOT cl_null(sr.l_pmdl009_desc) THEN
#          LET sr.l_pmdl009desc = sr.pmdl009,'.',sr.l_pmdl009_desc #組合說明
#       END IF
       #----交易條件&說明(l_pmdl010desc) 
#       LET sr.l_pmdl010_desc = ''
#       LET sr.l_pmdl010desc = ''
#       SELECT oocql004 INTO sr.l_pmdl010_desc FROM oocql_t 
#        WHERE oocqlent = g_enterprise AND oocql001 = '238' AND oocql002 = sr.pmdl010 AND oocql003 = g_dlang
#       IF NOT cl_null(sr.l_pmdl010_desc) THEN
#          LET sr.l_pmdl010desc = sr.pmdl010,'.',sr.l_pmdl010_desc #組合說明
#       END IF
       #----稅別&說明(l_pmdl011desc)  
       #160328-00011#3-mark-(S)
#           #先取得獲得當前營運據點的所屬稅區
#       LET l_ooef019 = ''
#       SELECT ooef019 INTO l_ooef019 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
#           #取得稅別說明
#       LET sr.l_pmdl011_desc = ''
##       LET sr.l_pmdl011desc = ''
#       CALL s_desc_get_tax_desc(l_ooef019,sr.pmdl011) RETURNING sr.l_pmdl011_desc  
       #160328-00011#3-mark-(E)
#       IF NOT cl_null(sr.l_pmdl011_desc) THEN
#          LET sr.l_pmdl011desc = sr.pmdl011,'.',sr.l_pmdl011_desc #組合說明       
#       END IF
       #160328-00011#3-mark-(S)
#       #----發票類型&說明(l_pmdl033desc) 
#           #先取得獲得當前營運據點的所屬稅區
#       LET l_ooef019 = ''
#       SELECT ooef019 INTO l_ooef019 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
#           #取得發票類型
#       LET sr.l_pmdl033_desc = ''
##       LET sr.l_pmdl033desc = ''
#       SELECT isacl004 INTO sr.l_pmdl033_desc FROM isacl_t 
#        WHERE isaclent = g_enterprise AND isacl001 = l_ooef019 AND isacl002 = sr.pmdl033 AND isacl003 = g_dlang
       #160328-00011#3-mark-(E) 
#       IF NOT cl_null(sr.l_pmdl033_desc) THEN
#          LET sr.l_pmdl033desc = sr.pmdl033,'.',sr.l_pmdl033_desc #組合說明
#       END IF
       #----幣別&說明(l_pmdl015desc)  
#       LET sr.l_pmdl015_desc = ''
#       LET sr.l_pmdl015desc = ''
#       SELECT ooail003 INTO sr.l_pmdl015_desc FROM ooail_t 
#        WHERE ooailent = g_enterprise AND ooail001 = sr.pmdl015 AND ooail002 = g_dlang
#       IF NOT cl_null(sr.l_pmdl015_desc) THEN
#          LET sr.l_pmdl015desc = sr.pmdl015,'.',sr.l_pmdl015_desc #組合說明
#       END IF
       #----取價方式&說明(l_pmdl017desc) 
#       LET sr.l_pmdl017_desc = ''
#       LET sr.l_pmdl017desc = ''
#       SELECT pmaml003 INTO sr.l_pmdl017_desc FROM pmaml_t 
#        WHERE pmamlent = g_enterprise AND pmaml001 = sr.pmdl017 AND pmaml002 = g_dlang
#       IF NOT cl_null(sr.l_pmdl017_desc) THEN
#          LET sr.l_pmdl017desc = sr.pmdl017,'.',sr.l_pmdl017_desc #組合說明
#       END IF
       #----付款優惠條件&說明(l_pmdl018desc) 
#       LET sr.l_pmdl018_desc = ''
#       LET sr.l_pmdl018desc = ''
#       SELECT ooidl003 INTO sr.l_pmdl018_desc FROM ooidl_t 
#        WHERE ooidlent = g_enterprise AND ooidl001 = sr.pmdl018 AND ooidl002 = g_dlang
#       IF NOT cl_null(sr.l_pmdl018_desc) THEN
#          LET sr.l_pmdl018desc = sr.pmdl018,'.',sr.l_pmdl018_desc #組合說明       
#       END IF
       #----採購通路&說明(l_pmdl023desc)  
#       LET sr.l_pmdl023_desc = ''
#       LET sr.l_pmdl023desc = ''
#       SELECT oocql004 INTO sr.l_pmdl023_desc FROM oocql_t 
#        WHERE oocqlent = g_enterprise AND oocql001 = '275' AND oocql002 = sr.pmdl023 AND oocql003 = g_dlang
#       IF NOT cl_null(sr.l_pmdl023_desc) THEN
#          LET sr.l_pmdl023desc = sr.pmdl023,'.',sr.l_pmdl023_desc #組合說明     
#       END IF
       #----留置原因&說明(l_pmdl043desc)  
#       LET sr.l_pmdl043_desc = ''
#       LET sr.l_pmdl043desc = ''
#       CALL s_desc_get_acc_desc('317',sr.pmdl043) RETURNING sr.l_pmdl043_desc
#       IF NOT cl_null(sr.l_pmdl043_desc) THEN
#          LET sr.l_pmdl043desc = sr.pmdl043,'.',sr.l_pmdl043_desc #組合說明
#       END IF
       #----多角流程代碼&說明(l_pmdl051desc)  
#       LET sr.l_pmdl051_desc = ''
#       LET sr.l_pmdl051desc = ''
#       CALL s_desc_get_icaa001_desc(sr.pmdl051) RETURNING sr.l_pmdl051_desc
#       IF NOT cl_null(sr.l_pmdl051_desc) THEN
#          LET sr.l_pmdl051desc = sr.pmdl051,'.',sr.l_pmdl051_desc #組合說明
#       END IF
       #單頭----運輸資訊
       #----送貨方式&說明(l_pmdl020desc)      
#       LET sr.l_pmdl020_desc = ''   
#       LET sr.l_pmdl020desc = ''
#       SELECT oocql004 INTO sr.l_pmdl020_desc FROM oocql_t 
#        WHERE oocqlent = g_enterprise AND oocql001 = '263' AND oocql002 = sr.pmdl020 AND oocql003 = g_dlang
#       IF NOT cl_null(sr.l_pmdl020_desc) THEN
#          LET sr.l_pmdl020desc = sr.pmdl020,'.',sr.l_pmdl020_desc #組合說明
#       END IF
       #160328-00011#3-mark-(S)
#       #----送貨地址類型&說明(l_pmdl025desc)   
#           #先獲取當前營運據點的聯絡對象識別碼
#       LET l_oofa001 = ''
#       SELECT oofa001 INTO l_oofa001 FROM oofa_t WHERE oofaent = g_enterprise AND oofa002 = '1' AND oofa003 = g_site
#           #取得送貨地址類型說明
#       LET sr.l_pmdl025_desc = ''       
##       LET sr.l_pmdl025desc = ''
#       SELECT oofb011 INTO sr.l_pmdl025_desc FROM oofb_t 
#        WHERE oofbent = g_enterprise AND oofb002 = l_oofa001 AND oofb008 = '3' AND oofb019 = sr.pmdl025
       #160328-00011#3-mark-(E) 
#       IF NOT cl_null(sr.l_pmdl025_desc) THEN
#          LET sr.l_pmdl025desc = sr.pmdl025,'.',sr.l_pmdl025_desc #組合說明
#       END IF
       #----送貨地址(l_oofb017)
       #160328-00011#3-mark-(S)    
#           #先獲取當前營運據點的聯絡對象識別碼
#       LET l_oofa001 = ''
#       SELECT oofa001 INTO l_oofa001 FROM oofa_t WHERE oofaent = g_enterprise AND oofa002 = '1' AND oofa003 = g_site
#       
#       LET sr.l_oofb017 = ''
       #160328-00011#3-mark-(E)
       #160411-00027#5-mark-(S)
#       #送貨地址
#       IF NOT cl_null(sr.pmdl025) THEN
#          CALL s_aooi350_get_address(l_oofa001,sr.pmdl025,g_lang) RETURNING l_success,sr.l_oofb017
#       END IF
       #160411-00027#5-mark-(E)
       #----帳款地址類型&說明(l_pmdl026desc) 
       #160328-00011#3-mark-(S)       
#       #先獲取當前營運據點的聯絡對象識別碼
#       LET l_oofa001 = ''
#       SELECT oofa001 INTO l_oofa001 FROM oofa_t WHERE oofaent = g_enterprise AND oofa002 = '1' AND oofa003 = g_site
#           #帳款地址
#       LET sr.l_pmdl026_desc = '' 
##       LET sr.l_pmdl026desc = ''
#       SELECT oofb011 INTO sr.l_pmdl026_desc FROM oofb_t 
#        WHERE oofbent = g_enterprise AND oofb002 = l_oofa001 AND oofb008 = '5' AND oofb019 = sr.pmdl026
       #160328-00011#3-mark-(E)
#       IF NOT cl_null(sr.l_pmdl026_desc) THEN
#          LET sr.l_pmdl026desc = sr.pmdl026,'.',sr.l_pmdl026_desc #組合說明
#       END IF
       #----帳款地址(l_oodb017_1)
       #160328-00011#3-mark-(S) 
#           #先獲取當前營運據點的聯絡對象識別碼
#       LET l_oofa001 = ''
#       SELECT oofa001 INTO l_oofa001 FROM oofa_t WHERE oofaent = g_enterprise AND oofa002 = '1' AND oofa003 = g_site
#           #帳款地址
#       LET sr.l_oofb017_1 = ''       
       #160328-00011#3-mark-(E) 
       #160411-00027#5-mark-(S)
#       #帳款地址
#       IF NOT cl_null(sr.pmdl026) THEN
#          CALL s_aooi350_get_address(l_oofa001,sr.pmdl026,g_lang) RETURNING l_success,sr.l_oofb017_1
#       END IF
       #160411-00027#5-mark-(E)
       #----收貨部門&說明(l_pmdl029desc) 
#       LET sr.l_pmdl029_desc = ''
#       LET sr.l_pmdl029desc = ''
#       SELECT ooefl003 INTO sr.l_pmdl029_desc FROM ooefl_t 
#        WHERE ooeflent = g_enterprise AND ooefl001 = sr.pmdl029 AND ooefl002 = g_dlang
#       IF NOT cl_null(sr.l_pmdl029_desc) THEN
#          LET sr.l_pmdl029desc = sr.pmdl029,'.',sr.l_pmdl029_desc #組合說明 
#       END IF
       #單頭----其他資訊
       #----付款供應商&說明(l_pmdl021desc) 
#       LET sr.l_pmdl021_desc = ''
#       LET sr.l_pmdl021desc = ''
#       SELECT pmaal004 INTO sr.l_pmdl021_desc FROM pmaal_t 
#        WHERE pmaalent = g_enterprise AND pmaal001 = sr.pmdl021 AND pmaal002 = g_dlang
#       IF NOT cl_null(sr.l_pmdl021_desc) THEN
#          LET sr.l_pmdl021desc = sr.pmdl021,'.',sr.l_pmdl021_desc #組合說明
#       END IF
       #----送貨供應商&說明(l_pmdl022desc)
#       LET sr.l_pmdl022_desc = ''
#       LET sr.l_pmdl022desc = ''
#       SELECT pmaal004 INTO sr.l_pmdl022_desc FROM pmaal_t WHERE pmaalent = g_enterprise 
#          AND pmaal001 = sr.pmdl022 AND pmaal002 = g_dlang
#       IF NOT cl_null(sr.l_pmdl022_desc) THEN
#          LET sr.l_pmdl022desc = sr.pmdl022,'.',sr.l_pmdl022_desc #組合說明
#       END IF
       #----採購分類(l_pmdl024desc) 
#       LET sr.l_pmdl024_desc = ''
#       LET sr.l_pmdl024desc = ''
#       SELECT oocql004 INTO sr.l_pmdl024_desc FROM oocql_t 
#        WHERE oocqlent = g_enterprise AND oocql001 = '264' AND oocql002 = sr.pmdl024 AND oocql003 = g_dlang
#       IF NOT cl_null(sr.l_pmdl024_desc) THEN
#          LET sr.l_pmdl024desc = sr.pmdl024,'.',sr.l_pmdl024_desc #組合說明
#       END IF
       #----最終客戶(l_pmdl032desc)
#       LET sr.l_pmdl032_desc = ''
#       LET sr.l_pmdl032desc = ''
#       SELECT pmaal004 INTO sr.l_pmdl032_desc FROM pmaal_t WHERE pmaalent = g_enterprise 
#          AND pmaal001 = sr.pmdl032 AND pmaal002 = g_dlang
#       IF NOT cl_null(sr.l_pmdl032_desc) THEN
#          LET sr.l_pmdl032desc = sr.pmdl032,'.',sr.l_pmdl032_desc #組合說明
#       END IF
       #----內外購全名(l_pmdl054desc) 
#       LET sr.l_pmdl054_desc = ''
#       LET sr.l_pmdl054desc = ''
#       CALL s_desc_gzcbl004_desc('2087',sr.pmdl054) RETURNING sr.l_pmdl054_desc
#       IF NOT cl_null(sr.l_pmdl054_desc) THEN
#          LET sr.l_pmdl054desc = sr.pmdl054,'.',sr.l_pmdl054_desc
#       END IF
       #----匯率計算基準全名(l_pmdl055desc) 
#       LET sr.l_pmdl055_desc = ''
#       LET sr.l_pmdl055desc = ''
#       CALL s_desc_gzcbl004_desc('2086',sr.pmdl055) RETURNING sr.l_pmdl055_desc
#       IF NOT cl_null(sr.l_pmdl055_desc) THEN
#          LET sr.l_pmdl055desc = sr.pmdl055,'.',sr.l_pmdl055_desc
#       END IF
       #----預付款發票開立方式全名(l_pmdl046desc) 
#       LET sr.l_pmdl046_desc = ''
#       LET sr.l_pmdl046desc = ''
#       CALL s_desc_gzcbl004_desc('8321',sr.pmdl046) RETURNING sr.l_pmdl046_desc
#       IF NOT cl_null(sr.l_pmdl046_desc) THEN
#          LET sr.l_pmdl046desc = sr.pmdl046,'.',sr.l_pmdl046_desc
#       END IF
       #單身----交期明細
       #----產品特徵全名(l_pmdo002desc) 
#       LET sr.l_pmdo002_desc = '' #160328-00011#3-mark
#       LET sr.l_pmdo002desc = ''
#       CALL s_feature_description(sr.pmdo001,sr.pmdo002) RETURNING l_success,sr.l_pmdo002_desc  #160411-00027#5-mark
#       IF NOT cl_null(sr.l_pmdo002_desc) THEN
#          LET sr.l_pmdo002desc = sr.pmdo002,'.',sr.l_pmdo002_desc
#       END IF
       #----交貨類型全名(l_pmdo021desc) 
#       LET sr.l_pmdo021_desc = ''
#       LET sr.l_pmdo021desc = ''
#       CALL s_desc_gzcbl004_desc('2058',sr.pmdo021) RETURNING sr.l_pmdo021_desc
#       IF NOT cl_null(sr.l_pmdo021_desc) THEN
#          LET sr.l_pmdo021desc = sr.pmdo021,'.',sr.l_pmdo021_desc
#       END IF
       #----最近修改人員全名(l_pmdo026desc) 
#       LET sr.l_pmdo026_desc = ''
#       LET sr.l_pmdo026desc = ''
#       SELECT ooag011 INTO sr.l_pmdo026_desc FROM ooag_t 
#        WHERE ooagent = g_enterprise AND ooag001 = sr.pmdo026 
#       IF NOT cl_null(sr.l_pmdo026_desc) THEN
#          LET sr.l_pmdo026desc = sr.pmdo026,'.',sr.l_pmdo026_desc
#       END IF
       #----收貨時段全名(l_pmdo010_desc)
#       LET sr.l_pmdo010_desc = ''
#       LET sr.l_pmdo010desc = ''
#       SELECT oocql004 INTO sr.l_pmdo010_desc FROM oocql_t 
#        WHERE oocqlent = g_enterprise AND oocql001 = '274' AND oocql002 = sr.pmdo010 AND oocql003 = g_dlang
#       IF NOT cl_null(sr.l_pmdo010_desc) THEN
#          LET sr.l_pmdo010desc = sr.pmdo010,'.',sr.l_pmdo010_desc #組合說明
#       END IF
       #160328-00011#3-mark-(S)
#       #----稅別全名(l_pmdo023_desc)    
#           #先獲得當前營運據點的所屬稅區
#       LET l_ooef019 = ''
#       SELECT ooef019 INTO l_ooef019 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
#           #稅別
#       LET sr.l_pmdo023_desc = ''
##       LET sr.l_pmdo023desc = ''
#       CALL s_desc_get_tax_desc(l_ooef019,sr.pmdo023) RETURNING sr.l_pmdo023_desc
       #160328-00011#3-mark-(E)
#       IF NOT cl_null(sr.l_pmdo023_desc) THEN
#          LET sr.l_pmdo023desc = sr.pmdo023,'.',sr.l_pmdo023_desc #組合說明
#       END IF
       #組合系列&說明
#       LET sr.l_imaa127_desc = ''
#       LET sr.l_imaa127desc = ''
#          #用料號抓取系列
#       SELECT imaa127 INTO sr.l_imaa127 FROM imaa_t
#        WHERE imaa001 = sr.pmdo001
#          AND imaaent = g_enterprise
#          #抓取系列說明
#       CALL s_desc_get_acc_desc('2003',sr.l_imaa127)  RETURNING sr.l_imaa127_desc   
#       IF NOT cl_null(sr.l_imaa127_desc) THEN
#          LET sr.l_imaa127desc = sr.l_imaa127,'.',sr.l_imaa127_desc 
#       END IF
       #dorislai-20150716-add----(E)

       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.pmdldocno,sr.pmdldocdt,sr.l_pmdl005_desc,sr.l_pmdlstus_desc,sr.pmdoseq,sr.pmdoseq1,sr.pmdoseq2,sr.l_pmdo003_desc,sr.pmdo001,sr.x_imaal_t_imaal003,sr.x_imaal_t_imaal004,sr.pmdo002,sr.l_imaa127,sr.l_imaa127_desc,sr.l_pmdn045_desc,sr.pmdo012,sr.l_pmdn052,sr.pmdo006,sr.pmdo004,sr.pmdo022,sr.pmdo033,sr.pmdo015,sr.pmdo016,sr.pmdo017,sr.pmdo040,sr.l_undelivered,sr.l_pmdn050,sr.l_pmdn020,sr.pmdl009,sr.pmdl010,sr.pmdl011,sr.pmdl012,sr.pmdl015,sr.pmdl016,sr.pmdl033,sr.pmdl043,sr.l_pmdl009_desc,sr.l_pmdl010_desc,sr.l_pmdl011_desc,sr.l_pmdl033_desc,sr.l_pmdl015_desc,sr.l_pmdl043_desc,sr.pmdl004,sr.pmdl002,sr.pmdl003,sr.pmdl013,sr.l_pmdl002_desc,sr.l_pmdl003_desc,sr.l_pmdl004_desc,sr.l_pmdo002_desc
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "apmr002_x01_execute"
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
 
{<section id="apmr002_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION apmr002_x01_rep_data()
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
 
{<section id="apmr002_x01.other_function" readonly="Y" >}

 
{</section>}
 
