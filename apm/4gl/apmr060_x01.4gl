#該程式未解開Section, 採用最新樣板產出!
{<section id="apmr060_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:7(2016-12-22 15:08:30), PR版次:0007(2016-12-22 15:27:39)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000049
#+ Filename...: apmr060_x01
#+ Description: ...
#+ Creator....: 05384(2015-09-03 16:30:18)
#+ Modifier...: 01534 -SD/PR- 01534
 
{</section>}
 
{<section id="apmr060_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#160310-00041#1  2016/03/11 By droislai 1.修正入庫回抓採購單時，資料多筆的問題
#                                       2.修正入庫單對應到的倉退單，資料上的錯誤。 
#                                         EX:兩張入庫單(apmt570)，僅挑其中一張打倉退單，報表輸出時，兩張入庫單，都抓到剛打的那張倉退單
#160413-00011#7  2016/04/14 By lixiang  效能優化
#161207-00033#24 2016/12/22 By lixh     一次性交易對象顯示說明，所有的客戶/供應商欄位都應該處理
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
       wc2 STRING                   #where condition2
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="apmr060_x01.main" readonly="Y" >}
PUBLIC FUNCTION apmr060_x01(p_arg1,p_arg2)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 STRING                  #tm.wc2  where condition2
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.wc2 = p_arg2
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "apmr060_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL apmr060_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL apmr060_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL apmr060_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL apmr060_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL apmr060_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="apmr060_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION apmr060_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "pmdadocno.pmda_t.pmdadocno,pmdadocdt.pmda_t.pmdadocdt,l_pmda002_ooag011.type_t.chr300,l_pmda003_ooefl003.type_t.chr1000,l_pmdastus_desc.gzcbl_t.gzcbl004,pmdbseq.pmdb_t.pmdbseq,pmdb004.pmdb_t.pmdb004,l_pmdb004_desc.imaal_t.imaal003,l_pmdb004_desc1.imaal_t.imaal004,imaa_t_imaa009.imaa_t.imaa009,l_imaa009_desc.rtaxl_t.rtaxl003,imaf_t_imaf141.imaf_t.imaf141,l_imaf141_desc.oocql_t.oocql004,imaa_t_imaa127.imaa_t.imaa127,l_imaa127_desc.oocql_t.oocql004,l_pmdb033_desc.gzcbl_t.gzcbl004,pmdb030.pmdb_t.pmdb030,pmdb007.pmdb_t.pmdb007,pmdb006.pmdb_t.pmdb006,pmdb049.pmdb_t.pmdb049,pmdl_t_pmdldocno.pmdl_t.pmdldocno,pmdl_t_pmdldocdt.pmdl_t.pmdldocdt,l_pmdl005_desc.gzcbl_t.gzcbl004,l_pmdl002_ooag011.type_t.chr300,l_pmdl003_ooefl003.type_t.chr1000,l_pmdl004_pmaal004.type_t.chr100,l_pmdlstus_desc.gzcbl_t.gzcbl004,pmdo_t_pmdoseq.pmdo_t.pmdoseq,pmdo_t_pmdoseq1.pmdo_t.pmdoseq1,pmdo_t_pmdoseq2.pmdo_t.pmdoseq2,l_pmdo003_desc.gzcbl_t.gzcbl004,pmdo_t_pmdo001.pmdo_t.pmdo001,l_pmdo001_desc.imaal_t.imaal004,l_pmdo001_desc1.imaal_t.imaal004,pmdo_t_pmdo012.pmdo_t.pmdo012,l_pmdn052.pmdn_t.pmdn052,l_pmdo006_pmdo019.type_t.num20_6,pmds_t_pmdsdocno.pmds_t.pmdsdocno,pmds_t_pmdsdocdt.pmds_t.pmdsdocdt,l_pmds002_ooag011.type_t.chr300,l_pmds003_ooefl003.type_t.chr1000,l_pmdsstus_desc.gzcbl_t.gzcbl004,pmdt_t_pmdtseq.pmdt_t.pmdtseq,pmdt_t_pmdt006.pmdt_t.pmdt006,l_pmdt006_desc.imaal_t.imaal003,l_pmdt006_desc1.imaal_t.imaal004,pmdt_t_pmdt007.pmdt_t.pmdt007,l_pmdt007_desc.type_t.chr1000,pmdt_t_pmdt016.pmdt_t.pmdt016,l_pmdt016_desc.inayl_t.inayl003,pmdt_t_pmdt017.pmdt_t.pmdt017,l_pmdt017_desc.inab_t.inab003,pmdt_t_pmdt018.pmdt_t.pmdt018,pmdt_t_pmdt019.pmdt_t.pmdt019,pmdt_t_pmdt020.pmdt_t.pmdt020,l_pmdsdocno1.pmds_t.pmdsdocno,l_pmdsdocdt1.pmds_t.pmdsdocdt,l_pmds0021_ooag011.type_t.chr300,l_pmds0031_ooefl003.type_t.chr1000,l_pmdsstus1_desc.gzcbl_t.gzcbl004,l_pmdtseq1.pmdt_t.pmdtseq,l_pmdt0191.pmdt_t.pmdt019,l_pmdt0201.pmdt_t.pmdt020,l_pmdsdocno2.pmds_t.pmdsdocno,l_pmdsdocdt2.pmds_t.pmdsdocdt,l_pmds0022_ooag011.type_t.chr300,l_pmds0032_ooefl003.type_t.chr1000,l_pmdsstus2_desc.gzcbl_t.gzcbl004,l_pmdtseq2.pmdt_t.pmdtseq,l_pmdt0062.pmdt_t.pmdt006,l_pmdt0062_desc.imaal_t.imaal003,l_pmdt0062_desc1.imaal_t.imaal004,l_pmdt0072.pmdt_t.pmdt007,l_pmdt0072_desc.type_t.chr1000,l_pmdt0162.pmdt_t.pmdt016,l_pmdt0162_desc.inayl_t.inayl003,l_pmdt0172.pmdt_t.pmdt017,l_pmdt0172_desc.inab_t.inab003,l_pmdt0182.pmdt_t.pmdt018,l_pmdt0192.pmdt_t.pmdt019,l_pmdt0202.pmdt_t.pmdt020,l_pmdsdocno3.pmds_t.pmdsdocno,l_pmdsdocdt3.pmds_t.pmdsdocdt,l_pmds0023_ooag011.type_t.chr300,l_pmds0033_ooefl003.type_t.chr1000,l_pmdsstus3_desc.gzcbl_t.gzcbl004,l_pmds1003.pmds_t.pmds100,l_pmds1003_desc.gzcbl_t.gzcbl004,l_pmdtseq3.pmdt_t.pmdtseq,l_pmdt0193.pmdt_t.pmdt019,l_pmdt0203.pmdt_t.pmdt020,pmdl_t_pmdl028.pmdl_t.pmdl028" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="apmr060_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION apmr060_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="apmr060_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apmr060_x01_sel_prep()
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
   IF tm.wc = ' 1=1 ' THEN
      #LET g_select = " SELECT DISTINCT v.pmdasite,v.pmdadocno,v.pmdadocdt,v.pmda002,'',v.pmda003,'',v.pmdastus,'',v.pmdbseq,v.pmdb004,'',
      #    '','','','','','','',v.pmdb033,gzcbl004,v.pmdb030,v.pmdb007,v.pmdb006,v.pmdb049,pmdlsite,pmdldocno,pmdldocdt,pmdl005,'',pmdl002,'',pmdl003,'',
      #    pmdl004,'',pmdl021,'',pmdl022,'',pmdl023,'',pmdlstus,'',pmdl001,pmdl006,pmdl007,pmdl008,pmdl009,pmdl010,
      #    pmdl011,pmdl012,pmdl013,pmdl015,pmdl016,pmdl017,pmdl018,pmdl019,pmdl020,pmdl024,pmdl025,pmdl026,pmdl027,
      #    pmdl028,pmdl029,pmdl030,pmdl031,pmdl032,pmdl033,pmdl040,pmdl041,pmdl042,pmdl043,pmdl044,pmdl046,pmdl047,
      #    pmdl048,pmdl049,pmdl050,pmdl051,pmdl052,pmdl053,pmdl054,pmdl055,pmdl200,pmdl201,pmdl202,pmdl203,pmdl204,
      #    pmdl205,pmdl206,pmdl207,u.pmdoseq, u.pmdoseq1,u.pmdoseq2,u.pmdo003,'',u.pmdo001,'','',u.pmdo012,'',u.pmdo004,
      #    u.pmdo006,u.pmdo022,u.pmdo002,u.pmdo005,u.pmdo007,u.pmdo008,u.pmdo009,u.pmdo010,u.pmdo011,u.pmdo013,u.pmdo014,
      #    u.pmdo015,u.pmdo016,u.pmdo017,u.pmdo019,0,u.pmdo020,u.pmdo021,u.pmdo023,u.pmdo024,u.pmdo025,u.pmdo026,u.pmdo027,
      #    u.pmdo028,u.pmdo029,u.pmdo030,u.pmdo031,u.pmdo032,u.pmdo033,u.pmdo034,u.pmdo035,u.pmdo036,u.pmdo037,u.pmdo038,
      #    u.pmdo039,u.pmdo040,u.pmdo041,u.pmdo042,u.pmdo043,u.pmdo044,u.pmdo200,u.pmdo201,w.pmdsdocno,w.pmdsdocdt,
      #    w.pmds002,'',w.pmds003,'',w.pmdsstus,'',w.pmdtseq,w.pmdt006,'','',w.pmdt007,'',w.pmdt016,'',w.pmdt017,
      #    w.pmdt018,'',w.pmdt019,w.pmdt020,x.pmdsdocno,x.pmdsdocdt,x.pmds002,x.pmds003,x.pmdsstus,'',x.pmdtseq,
      #    x.pmdt019,x.pmdt020,y.pmdsdocno,y.pmdsdocdt,y.pmds002,y.pmds003,y.pmdsstus,'',y.pmdtseq,y.pmdt006,'','',
      #    y.pmdt007,'',y.pmdt016,'',y.pmdt017,'',y.pmdt018,y.pmdt019,y.pmdt020,z.pmdsdocno,z.pmdsdocdt,z.pmds002,
      #    z.pmds003,z.pmdsstus,'',z.pmds100,'',z.pmdtseq,z.pmdt019,z.pmdt020"
      
      #160413-00011#7--mark---begin---
      #LET g_select = " SELECT DISTINCT v.pmdasite,v.pmdadocno,v.pmdadocdt,
      #    v.pmda002,
      #    CASE WHEN v.b0_ooag011 IS NULL THEN v.pmda002 ELSE trim(v.pmda002)||'.'||trim(v.b0_ooag011) END,
      #    v.pmda003,
      #    CASE WHEN v.ooefl003 IS NULL THEN v.pmda003 ELSE trim(v.pmda003)||'.'||trim(v.ooefl003) END,
      #    v.pmdastus,v.s1_gzcbl004,v.pmdbseq,v.pmdb004,v.d3_imaal003,
      #    v.d3_imaal004,v.imaa009,rtaxl003,imaf141,d1.oocql004,v.imaa127,d2.oocql004,v.pmdb033,v.s0_gzcbl004,
      #    v.pmdb030,v.pmdb007,v.pmdb006,v.pmdb049,pmdlsite,pmdldocno,pmdldocdt,pmdl005,s3.gzcbl004,
      #    pmdl002,
      #    CASE WHEN b1.ooag011 IS NULL THEN pmdl002 ELSE trim(pmdl002)||'.'||trim(b1.ooag011) END,
      #    pmdl003,
      #    CASE WHEN b2.ooefl003 IS NULL THEN pmdl003 ELSE trim(pmdl003)||'.'||trim(b2.ooefl003) END,
      #    pmdl004,
      #    CASE WHEN c0.pmaal004 IS NULL THEN pmdl004 ELSE trim(pmdl004)||'.'||trim(c0.pmaal004) END,
      #    pmdl021,
      #    CASE WHEN c1.pmaal004 IS NULL THEN pmdl021 ELSE trim(pmdl021)||'.'||trim(c1.pmaal004) END,
      #    pmdl022,
      #    CASE WHEN c2.pmaal004 IS NULL THEN pmdl022 ELSE trim(pmdl022)||'.'||trim(c2.pmaal004) END,
      #    pmdl023,
      #    CASE WHEN d0.oocql004 IS NULL THEN pmdl023 ELSE trim(pmdl023)||'.'||trim(d0.oocql004) END,
      #    pmdlstus,s2.gzcbl004,pmdl001,pmdl006,pmdl007,pmdl008,pmdl009,pmdl010,pmdl011,pmdl012,pmdl013,pmdl015,pmdl016,pmdl017,
      #    pmdl018,pmdl019,pmdl020,pmdl024,pmdl025,pmdl026,pmdl027,pmdl028,pmdl029,pmdl030,pmdl031,pmdl032,pmdl033,pmdl040,
      #    pmdl041,pmdl042,pmdl043,pmdl044,pmdl046,pmdl047,pmdl048,pmdl049,pmdl050,pmdl051,pmdl052,pmdl053,pmdl054,pmdl055,
      #    pmdl200,pmdl201,pmdl202,pmdl203,pmdl204,pmdl205,pmdl206,pmdl207,u.pmdoseq, u.pmdoseq1,u.pmdoseq2,
      #    u.pmdo003,u.s4_gzcbl004,
      #    u.pmdo001,u.d4_imaal003,u.d4_imaal004,u.pmdo012,pmdn052,u.pmdo004,u.pmdo006,u.pmdo022,u.pmdo002,u.pmdo005,u.pmdo007,u.pmdo008,u.pmdo009,
      #    u.pmdo010,u.pmdo011,u.pmdo013,u.pmdo014,u.pmdo015,u.pmdo016,u.pmdo017,u.pmdo019,0,u.pmdo020,u.pmdo021,u.pmdo023,
      #    u.pmdo024,u.pmdo025,u.pmdo026,u.pmdo027,u.pmdo028,u.pmdo029,u.pmdo030,u.pmdo031,u.pmdo032,u.pmdo033,u.pmdo034,u.pmdo035,
      #    u.pmdo036,u.pmdo037,u.pmdo038,u.pmdo039,u.pmdo040,u.pmdo041,u.pmdo042,u.pmdo043,u.pmdo044,u.pmdo200,u.pmdo201,
      #    w.pmdsdocno,w.pmdsdocdt,w.pmds002,
      #    CASE WHEN w.d6_ooag011 IS NULL THEN w.pmds002 ELSE trim(w.pmds002)||'.'||trim(w.d6_ooag011) END,
      #    w.pmds003,
      #    CASE WHEN w.d7_ooefl003 IS NULL THEN w.pmds003 ELSE trim(w.pmds003)||'.'||trim(w.d7_ooefl003) END,
      #    w.pmdsstus,w.d5_gzcbl004,w.pmdtseq,w.pmdt006,w.d8_imaal003,w.d8_imaal004,w.pmdt007,'',w.pmdt016,w.d9_inayl003,
      #    w.pmdt017,d12.inab003,w.pmdt018,w.pmdt019,w.pmdt020,
      #    x.pmdsdocno,x.pmdsdocdt,
      #    CASE WHEN x.d13_ooag011 IS NULL THEN x.pmds002 ELSE trim(x.pmds002)||'.'||trim(x.d13_ooag011) END,
      #    CASE WHEN x.d14_ooefl003 IS NULL THEN x.pmds003 ELSE trim(x.pmds003)||'.'||trim(x.d14_ooefl003) END,
      #    x.pmdsstus,x.d10_gzcbl004,x.pmdtseq,
      #    x.pmdt019,x.pmdt020,
      #    y.pmdsdocno,y.pmdsdocdt,
      #    CASE WHEN y.d15_ooag011 IS NULL THEN y.pmds002 ELSE trim(y.pmds002)||'.'||trim(y.d15_ooag011) END,
      #    CASE WHEN y.d16_ooefl003 IS NULL THEN y.pmds003 ELSE trim(y.pmds003)||'.'||trim(y.d16_ooefl003) END,
      #    y.pmdsstus,y.d11_gzcbl004,y.pmdtseq,y.pmdt006,y.d17_imaal003,y.d17_imaal004,
      #    y.pmdt007,'',y.pmdt016,y.d18_inayl003,y.pmdt017,d19.inab003,y.pmdt018,y.pmdt019,y.pmdt020,
      #    z.pmdsdocno,z.pmdsdocdt,
      #    CASE WHEN z.d22_ooag011 IS NULL THEN z.pmds002 ELSE trim(z.pmds002)||'.'||trim(z.d22_ooag011) END,
      #    CASE WHEN z.d23_ooefl003 IS NULL THEN z.pmds003 ELSE trim(z.pmds003)||'.'||trim(z.d23_ooefl003) END,
      #    z.pmdsstus,z.d20_gzcbl004,z.pmds100,z.d21_gzcbl004,z.pmdtseq,z.pmdt019,z.pmdt020"
      #160413-00011#7--mark--end----
      #160413-00011#7--add--begin---
      LET g_select = " SELECT DISTINCT v.pmdasite,v.pmdadocno,v.pmdadocdt,
          v.pmda002,v.b0_ooag011,v.pmda003,v.b1_ooefl003,v.pmdastus,v.s1_gzcbl004,v.pmdbseq,v.pmdb004,v.d3_imaal003,
          v.d3_imaal004,v.imaa009,v.rtaxl003,v.imaf141,v.d1_oocql004,v.imaa127,v.d2_oocql004,
          v.pmdb033,v.s0_gzcbl004,v.pmdb030,v.pmdb007,v.pmdb006,v.pmdb049,
          pmdldocno,pmdldocdt,pmdl005,
          (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '2052' AND gzcbl002 = pmdl005 AND gzcbl003 = '",g_dlang,"') S1_gzcbl004,
          pmdl002,
          (SELECT ooag011  FROM ooag_t WHERE ooagent = pmdlent AND ooag001 = pmdl002) ooag011,
          pmdl003,
          (SELECT ooefl003 FROM ooefl_t WHERE ooeflent = pmdlent AND ooefl001 = pmdl003 AND ooefl002 = '",g_dlang,"') ooefl003,
          pmdl004,
          (SELECT pmaal004 FROM pmaal_t WHERE pmaalent = pmdlent AND pmaal001 = pmdl004 AND pmaal002 = '",g_dlang,"') C0_pmaal004,
          pmdlstus,
          (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '13' AND gzcbl002 = pmdlstus AND gzcbl003 = '",g_dlang,"') S2_gzcbl004,
          u.pmdoseq, u.pmdoseq1,u.pmdoseq2,
          u.pmdo003,u.s4_gzcbl004,
          u.pmdo001,u.d4_imaal003,u.d4_imaal004,u.pmdo012,
          (SELECT pmdn052 FROM pmdn_t WHERE pmdnent = pmdlent AND pmdndocno = pmdldocno AND pmdnseq = u.pmdoseq) pmdn052,
          u.pmdo019_1,
          w.pmdsdocno,w.pmdsdocdt,w.pmds002,
          w.d6_ooag011,
          w.pmds003,
          w.d7_ooefl003,
          w.pmdsstus,w.d5_gzcbl004,w.pmdtseq,w.pmdt006,w.d8_imaal003,w.d8_imaal004,w.pmdt007,w.d9_inaml004,w.pmdt016,w.d9_inayl003,
          w.pmdt017,
          (SELECT inab003 FROM inab_t WHERE inabent  = pmdlent AND inabsite = pmdlsite AND inab001  = w.pmdt016 AND inab002  = w.pmdt017) D12_inab003,
          w.pmdt018,w.pmdt019,w.pmdt020,
          x.pmdsdocno,x.pmdsdocdt,
          x.d13_ooag011,
          x.d14_ooefl003,
          x.pmdsstus,x.d10_gzcbl004,x.pmdtseq,
          x.pmdt019,x.pmdt020,
          y.pmdsdocno,y.pmdsdocdt,
          y.d15_ooag011,
          y.d16_ooefl003,
          y.pmdsstus,y.d11_gzcbl004,y.pmdtseq,y.pmdt006,y.d17_imaal003,y.d17_imaal004,
          y.pmdt007,y.d18_inaml004,y.pmdt016,y.d18_inayl003,y.pmdt017,
          (SELECT inab003 FROM inab_t WHERE inabent  = pmdlent AND inabsite = pmdlsite AND inab001  = y.pmdt016 AND inab002  = y.pmdt017) D19_inab003,
          y.pmdt018,y.pmdt019,y.pmdt020,
          z.pmdsdocno,z.pmdsdocdt,
          z.d22_ooag011,
          z.d23_ooefl003,
          z.pmdsstus,z.d20_gzcbl004,z.pmds100,z.d21_gzcbl004,z.pmdtseq,z.pmdt019,z.pmdt020,pmdl028 "  ##161207-00033#24 add pmdl028
      #160413-00011#7---add---end---
   ELSE
      #LET g_select = " SELECT DISTINCT pmdasite,pmdadocno,pmdadocdt,pmda002,trim(pmda002)||'.'||trim(ooag_t.ooag011),
      #    pmda003,trim(pmda003)||'.'||trim(ooefl_t.ooefl003),pmdastus,gzcbl_t.gzcbl004,u.pmdbseq,u.pmdb004,u.imaal003,
      #    u.imaal004,u.imaa009,'',u.imaf141,'',u.imaa127,'',u.pmdb033,'',u.pmdb030,u.pmdb007,u.pmdb006,u.pmdb049,v.pmdlsite,v.pmdldocno, 
      #    v.pmdldocdt,v.pmdl005,'',v.pmdl002,'',v.pmdl003,'',v.pmdl004,'',v.pmdl021,'',v.pmdl022,'',v.pmdl023,'',
      #    v.pmdlstus,'',v.pmdl001,v.pmdl006,v.pmdl007,v.pmdl008,v.pmdl009,v.pmdl010,v.pmdl011,v.pmdl012,v.pmdl013,
      #    v.pmdl015,v.pmdl016,v.pmdl017,v.pmdl018,v.pmdl019,v.pmdl020,v.pmdl024,v.pmdl025,v.pmdl026,v.pmdl027,
      #    v.pmdl028,v.pmdl029,v.pmdl030,v.pmdl031,v.pmdl032,v.pmdl033,v.pmdl040,v.pmdl041,v.pmdl042,v.pmdl043,
      #    v.pmdl044,v.pmdl046,v.pmdl047,v.pmdl048,v.pmdl049,v.pmdl050,v.pmdl051,v.pmdl052,v.pmdl053,v.pmdl054,
      #    v.pmdl055,v.pmdl200,v.pmdl201,v.pmdl202,v.pmdl203,v.pmdl204,v.pmdl205,v.pmdl206,v.pmdl207,v.pmdoseq,
      #    v.pmdoseq1,v.pmdoseq2,v.pmdo003,'',v.pmdo001,'','',v.pmdo012,'',v.pmdo004,v.pmdo006,v.pmdo022,v.pmdo002, 
      #    v.pmdo005,v.pmdo007,v.pmdo008,v.pmdo009,v.pmdo010,v.pmdo011,v.pmdo013,v.pmdo014,v.pmdo015,v.pmdo016,
      #    v.pmdo017,v.pmdo019,0,v.pmdo020,v.pmdo021,v.pmdo023,v.pmdo024,v.pmdo025,v.pmdo026,v.pmdo027,v.pmdo028,
      #    v.pmdo029,v.pmdo030,v.pmdo031,v.pmdo032,v.pmdo033,v.pmdo034,v.pmdo035,v.pmdo036,v.pmdo037,v.pmdo038,
      #    v.pmdo039,v.pmdo040,v.pmdo041,v.pmdo042,v.pmdo043,v.pmdo044,v.pmdo200,v.pmdo201,w.pmdsdocno,w.pmdsdocdt,
      #    w.pmds002,'',w.pmds003,'',w.pmdsstus,'',w.pmdtseq,w.pmdt006,'','',w.pmdt007,'',w.pmdt016,'',w.pmdt017,
      #    w.pmdt018,'',w.pmdt019,w.pmdt020,x.pmdsdocno,x.pmdsdocdt,x.pmds002,x.pmds003,x.pmdsstus,'',x.pmdtseq,
      #    x.pmdt019,x.pmdt020,y.pmdsdocno,y.pmdsdocdt,y.pmds002,y.pmds003,y.pmdsstus,'',y.pmdtseq,y.pmdt006,'','',
      #    y.pmdt007,'',y.pmdt016,'',y.pmdt017,'',y.pmdt018,y.pmdt019,y.pmdt020,z.pmdsdocno,z.pmdsdocdt,z.pmds002,
      #    z.pmds003,z.pmdsstus,'',z.pmds100,'',z.pmdtseq,z.pmdt019,z.pmdt020"
      
      #160413-00011#7--mark---begin---
      #LET g_select = " SELECT DISTINCT pmdasite,pmdadocno,pmdadocdt,pmda002,
      #    CASE WHEN b0.ooag011 IS NULL THEN pmda002 ELSE trim(pmda002)||'.'||trim(b0.ooag011) END,
      #    pmda003,
      #    CASE WHEN ooefl_t.ooefl003 IS NULL THEN pmda003 ELSE trim(pmda003)||'.'||trim(ooefl_t.ooefl003) END,
      #    pmdastus,s1.gzcbl004,u.pmdbseq,u.pmdb004,u.imaal003,u.imaal004,
      #    u.imaa009,u.rtaxl003,u.imaf141,u.d1_oocql004,u.imaa127,u.d2_oocql004,u.pmdb033,'',u.pmdb030,u.pmdb007,u.pmdb006,u.pmdb049,v.pmdlsite,v.pmdldocno,v.pmdldocdt, 
      #    v.pmdl005,v.s3_gzcbl004,
      #    v.pmdl002,
      #    CASE WHEN v.b1_ooag011 IS NULL THEN pmdl002 ELSE trim(v.pmdl002)||'.'||trim(v.b1_ooag011) END,
      #    v.pmdl003,
      #    CASE WHEN v.b2_ooefl003 IS NULL THEN v.pmdl003 ELSE trim(v.pmdl003)||'.'||trim(v.b2_ooefl003) END,
      #    v.pmdl004, 
      #    CASE WHEN v.c0_pmaal004 IS NULL THEN v.pmdl004 ELSE trim(v.pmdl004)||'.'||trim(v.c0_pmaal004) END,
      #    v.pmdl021,
      #    CASE WHEN v.c1_pmaal004 IS NULL THEN v.pmdl021 ELSE trim(v.pmdl021)||'.'||trim(v.c1_pmaal004) END,
      #    v.pmdl022,
      #    CASE WHEN v.c2_pmaal004 IS NULL THEN v.pmdl022 ELSE trim(v.pmdl022)||'.'||trim(v.c2_pmaal004) END,
      #    v.pmdl023,
      #    CASE WHEN v.d0_oocql004 IS NULL THEN v.pmdl023 ELSE trim(v.pmdl023)||'.'||trim(v.d0_oocql004) END,
      #    v.pmdlstus,v.s2_gzcbl004,
      #    v.pmdl001,v.pmdl006,v.pmdl007,v.pmdl008,v.pmdl009,v.pmdl010,v.pmdl011,v.pmdl012,v.pmdl013,
      #    v.pmdl015,v.pmdl016,v.pmdl017,v.pmdl018,v.pmdl019,v.pmdl020,v.pmdl024,v.pmdl025,v.pmdl026,v.pmdl027,
      #    v.pmdl028,v.pmdl029,v.pmdl030,v.pmdl031,v.pmdl032,v.pmdl033,v.pmdl040,v.pmdl041,v.pmdl042,v.pmdl043,
      #    v.pmdl044,v.pmdl046,v.pmdl047,v.pmdl048,v.pmdl049,v.pmdl050,v.pmdl051,v.pmdl052,v.pmdl053,v.pmdl054,
      #    v.pmdl055,v.pmdl200,v.pmdl201,v.pmdl202,v.pmdl203,v.pmdl204,v.pmdl205,v.pmdl206,v.pmdl207,v.pmdoseq,
      #    v.pmdoseq1,v.pmdoseq2,v.pmdo003,v.s4_gzcbl004,
      #    v.pmdo001,v.d4_imaal003,v.d4_imaal004,v.pmdo012,v.pmdn052,v.pmdo004,v.pmdo006,v.pmdo022,v.pmdo002, 
      #    v.pmdo005,v.pmdo007,v.pmdo008,v.pmdo009,v.pmdo010,v.pmdo011,v.pmdo013,v.pmdo014,v.pmdo015,v.pmdo016,
      #    v.pmdo017,v.pmdo019,0,v.pmdo020,v.pmdo021,v.pmdo023,v.pmdo024,v.pmdo025,v.pmdo026,v.pmdo027,v.pmdo028,
      #    v.pmdo029,v.pmdo030,v.pmdo031,v.pmdo032,v.pmdo033,v.pmdo034,v.pmdo035,v.pmdo036,v.pmdo037,v.pmdo038,
      #    v.pmdo039,v.pmdo040,v.pmdo041,v.pmdo042,v.pmdo043,v.pmdo044,v.pmdo200,v.pmdo201,w.pmdsdocno,w.pmdsdocdt,
      #    w.pmds002,
      #    CASE WHEN w.d6_ooag011 IS NULL THEN w.pmds002 ELSE trim(w.pmds002)||'.'||trim(w.d6_ooag011) END,
      #    w.pmds003,
      #    CASE WHEN w.d7_ooefl003 IS NULL THEN w.pmds003 ELSE trim(w.pmds003)||'.'||trim(w.d7_ooefl003) END,
      #    w.pmdsstus,w.d5_gzcbl004,w.pmdtseq,w.pmdt006,w.d8_imaal003,w.d8_imaal004,w.pmdt007,'',w.pmdt016,w.d9_inayl003,
      #    w.pmdt017,d12.inab003,w.pmdt018,w.pmdt019,w.pmdt020,
      #    x.pmdsdocno,x.pmdsdocdt,
      #    CASE WHEN x.d13_ooag011 IS NULL THEN x.pmds002 ELSE trim(x.pmds002)||'.'||trim(x.d13_ooag011) END,
      #    CASE WHEN x.d14_ooefl003 IS NULL THEN x.pmds003 ELSE trim(x.pmds003)||'.'||trim(x.d14_ooefl003) END,
      #    x.pmdsstus,x.d10_gzcbl004,x.pmdtseq,x.pmdt019,x.pmdt020,
      #    y.pmdsdocno,y.pmdsdocdt,
      #    CASE WHEN y.d15_ooag011 IS NULL THEN y.pmds002 ELSE trim(y.pmds002)||'.'||trim(y.d15_ooag011) END,
      #    CASE WHEN y.d16_ooefl003 IS NULL THEN y.pmds003 ELSE trim(y.pmds003)||'.'||trim(y.d16_ooefl003) END,
      #    y.pmdsstus,y.d11_gzcbl004,y.pmdtseq,y.pmdt006,y.d17_imaal003,y.d17_imaal004,
      #    y.pmdt007,'',y.pmdt016,y.d18_inayl003,y.pmdt017,d19.inab003,y.pmdt018,y.pmdt019,y.pmdt020,
      #    z.pmdsdocno,z.pmdsdocdt,
      #    CASE WHEN z.d22_ooag011 IS NULL THEN z.pmds002 ELSE trim(z.pmds002)||'.'||trim(z.d22_ooag011) END,
      #    CASE WHEN z.d23_ooefl003 IS NULL THEN z.pmds003 ELSE trim(z.pmds003)||'.'||trim(z.d23_ooefl003) END,
      #    z.pmdsstus,z.d20_gzcbl004,z.pmds100,z.d21_gzcbl004,z.pmdtseq,z.pmdt019,z.pmdt020" 
      #160413-00011#7--mark--end----
      #160413-00011#7--add--begin---
      LET g_select = " SELECT DISTINCT pmdasite,pmdadocno,pmdadocdt,pmda002,
          (SELECT ooag011 FROM ooag_t WHERE ooagent = pmda_t.pmdaent AND ooag001 = pmda_t.pmda002) ooag011,
          pmda003,
          (SELECT ooefl003 FROM ooefl_t WHERE ooeflent = pmda_t.pmdaent AND ooefl001 = pmda_t.pmda003 AND ooefl_t.ooefl002 = '",g_dlang,"') ooefl003,
          pmdastus,
          (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '13' AND gzcbl002 = pmdastus AND gzcbl003 = '",g_dlang,"') S1_gzcbl004,
          u.pmdbseq,u.pmdb004,u.imaal003,u.imaal004,
          u.imaa009,u.rtaxl003,u.imaf141,u.d1_oocql004,u.imaa127,u.d2_oocql004,u.pmdb033,u.s0_gzcbl004,u.pmdb030,u.pmdb007,u.pmdb006,u.pmdb049,
          v.pmdldocno,v.pmdldocdt, 
          v.pmdl005,v.s3_gzcbl004,
          v.pmdl002,v.b1_ooag011,v.pmdl003,v.b2_ooefl003,v.pmdl004, v.c0_pmaal004,
          v.pmdlstus,v.s2_gzcbl004,
          v.pmdoseq,
          v.pmdoseq1,v.pmdoseq2,v.pmdo003,v.s4_gzcbl004,
          v.pmdo001,v.d4_imaal003,v.d4_imaal004,v.pmdo012,v.pmdn052,v.pmdo019_1,
          w.pmdsdocno,w.pmdsdocdt,
          w.pmds002,
          w.d6_ooag011,
          w.pmds003,
          w.d7_ooefl003,
          w.pmdsstus,w.d5_gzcbl004,w.pmdtseq,w.pmdt006,w.d8_imaal003,w.d8_imaal004,w.pmdt007,w.d9_inaml004,w.pmdt016,w.d9_inayl003,
          w.pmdt017,
          (SELECT inab003 FROM inab_t WHERE inabent  = w.pmdsent AND inabsite = v.pmdlsite AND inab001  = w.pmdt016 AND inab002  = w.pmdt017) D12_inab003,
          w.pmdt018,w.pmdt019,w.pmdt020,
          x.pmdsdocno,x.pmdsdocdt,
          x.d13_ooag011,
          x.d14_ooefl003,
          x.pmdsstus,x.d10_gzcbl004,x.pmdtseq,x.pmdt019,x.pmdt020,
          y.pmdsdocno,y.pmdsdocdt,
          y.d15_ooag011,
          y.d16_ooefl003,
          y.pmdsstus,y.d11_gzcbl004,y.pmdtseq,y.pmdt006,y.d17_imaal003,y.d17_imaal004,
          y.pmdt007,y.d18_inaml004,y.pmdt016,y.d18_inayl003,y.pmdt017,
          (SELECT inab003 FROM inab_t WHERE inabent  = y.pmdsent AND inabsite = v.pmdlsite AND inab001  = y.pmdt016 AND inab002  = y.pmdt017) D19_inab003,
          y.pmdt018,y.pmdt019,y.pmdt020,
          z.pmdsdocno,z.pmdsdocdt,
          z.d22_ooag011,
          z.d23_ooefl003,
          z.pmdsstus,z.d20_gzcbl004,z.pmds100,z.d21_gzcbl004,z.pmdtseq,z.pmdt019,z.pmdt020,v.pmdl028" ##161207-00033#24 add pmdl028      
      #160413-00011#7---add---end---          
   END IF
#   #end add-point
#   LET g_select = " SELECT pmdasite,pmdadocno,pmdadocdt,pmda002,'',pmda003,'',pmdastus,'',pmdbseq,pmdb004, 
#       '','',imaa_t.imaa009,'',imaf_t.imaf141,'',imaa_t.imaa127,'',pmdb033,'',pmdb030,pmdb007,pmdb006, 
#       pmdb049,pmdl_t.pmdldocno,pmdl_t.pmdldocdt,pmdl_t.pmdl005,'',pmdl_t.pmdl002,'',pmdl_t.pmdl003, 
#       '',pmdl_t.pmdl004,'',pmdl_t.pmdlstus,'',pmdo_t.pmdoseq,pmdo_t.pmdoseq1,pmdo_t.pmdoseq2,pmdo_t.pmdo003, 
#       '',pmdo_t.pmdo001,'','',pmdo_t.pmdo012,'',0,pmds_t.pmdsdocno,pmds_t.pmdsdocdt,pmds_t.pmds002, 
#       '',pmds_t.pmds003,'',pmds_t.pmdsstus,'',pmdt_t.pmdtseq,pmdt_t.pmdt006,'','',pmdt_t.pmdt007,'', 
#       pmdt_t.pmdt016,'',pmdt_t.pmdt017,'',pmdt_t.pmdt018,pmdt_t.pmdt019,pmdt_t.pmdt020,'','','','', 
#       '','','','',0,'','','','','','','','','','','','','','','','','','',0,'','','','','','','','', 
#       '','',0,pmdl_t.pmdl028"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   #151106-00004#10 20151119 s983961--mark(s)
   #IF tm.wc = ' 1=1 ' THEN
   #   LET g_from = " FROM pmdl_t LEFT OUTER JOIN (SELECT pmdo_t.*,pmdp_t.* FROM pmdo_t,pmdp_t  ) u ON pmdl_t.pmdlent = u.pmdoent AND pmdl_t.pmdldocno = u.pmdodocno AND u.pmdoent = u.pmdpent AND u.pmdodocno = u.pmdpdocno AND u.pmdoseq = u.pmdpseq ",
   #                "             LEFT OUTER JOIN (SELECT pmda_t.*,pmdb_t.* FROM pmda_t ",
   #                "             LEFT OUTER JOIN pmdb_t ON pmdb_t.pmdbent = pmda_t.pmdaent AND pmdb_t.pmdbdocno = pmda_t.pmdadocno ) v ON pmdl_t.pmdlent = v.pmdaent AND ((pmdl_t.pmdl008 = v.pmdadocno AND u.pmdoseq = v.pmdbseq) OR (u.pmdp003 = v.pmdadocno AND u.pmdp004 = v.pmdbseq))",
   #                "             LEFT OUTER JOIN (SELECT pmds_t.pmdsent,pmds_t.pmdsdocno,pmds_t.pmds000,pmds_t.pmds006,pmds_t.pmdsdocdt,pmds_t.pmds002,pmds_t.pmds003,pmds_t.pmdsstus,pmdt_t.pmdtseq,pmdt_t.pmdt001,pmdt_t.pmdt002,pmdt_t.pmdt003,pmdt_t.pmdt004,pmdt_t.pmdt006,pmdt_t.pmdt007,pmdt_t.pmdt016,pmdt_t.pmdt017,pmdt_t.pmdt018,pmdt_t.pmdt019,pmdt_t.pmdt020 FROM pmds_t ",
   #                "             LEFT OUTER JOIN pmdt_t ON pmdt_t.pmdtent = pmds_t.pmdsent AND pmdt_t.pmdtdocno = pmds_t.pmdsdocno ) w ON pmdl_t.pmdlent = w.pmdsent AND pmdl_t.pmdldocno = w.pmdt001 AND w.pmdt002 = u.pmdoseq AND w.pmdt003 = u.pmdoseq1 AND w.pmdt003 = u.pmdoseq2 AND w.pmds000 IN('1','8') ",
   #                "             LEFT OUTER JOIN (SELECT pmds_t.pmdsent,pmds_t.pmdsdocno,pmds_t.pmds000,pmds_t.pmds006,pmds_t.pmdsdocdt,pmds_t.pmds002,pmds_t.pmds003,pmds_t.pmdsstus,pmds_t.pmds100,pmdt_t.pmdtseq,pmdt_t.pmdt001,pmdt_t.pmdt002,pmdt_t.pmdt003,pmdt_t.pmdt004,pmdt_t.pmdt019,pmdt_t.pmdt020,pmdt_t.pmdt028 FROM pmds_t ",
   #                "             LEFT OUTER JOIN pmdt_t ON pmdt_t.pmdtent = pmds_t.pmdsent AND pmdt_t.pmdtdocno = pmds_t.pmdsdocno ) x ON pmdl_t.pmdlent = x.pmdsent AND pmdl_t.pmdldocno = x.pmdt001 AND x.pmdt002 = u.pmdoseq AND x.pmdt003 = u.pmdoseq1 AND x.pmdt003 = u.pmdoseq2 AND x.pmds000 IN('5','10') ",
   #                "             LEFT OUTER JOIN (SELECT pmds_t.pmdsent,pmds_t.pmdsdocno,pmds_t.pmds000,pmds_t.pmds006,pmds_t.pmdsdocdt,pmds_t.pmds002,pmds_t.pmds003,pmds_t.pmdsstus,pmdt_t.pmdtseq,pmdt_t.pmdt001,pmdt_t.pmdt002,pmdt_t.pmdt003,pmdt_t.pmdt004,pmdt_t.pmdt006,pmdt_t.pmdt007,pmdt_t.pmdt016,pmdt_t.pmdt017,pmdt_t.pmdt018,pmdt_t.pmdt019,pmdt_t.pmdt020 FROM pmds_t ",
   #                "             LEFT OUTER JOIN pmdt_t ON pmdt_t.pmdtent = pmds_t.pmdsent AND pmdt_t.pmdtdocno = pmds_t.pmdsdocno ) y ON pmdl_t.pmdlent = y.pmdsent AND pmdl_t.pmdldocno = y.pmdt001 AND y.pmdt002 = u.pmdoseq AND y.pmdt003 = u.pmdoseq1 AND y.pmdt003 = u.pmdoseq2 AND y.pmds000 IN('3','6','12') ",
   #                "             LEFT OUTER JOIN (SELECT pmds_t.pmdsent,pmds_t.pmdsdocno,pmds_t.pmds000,pmds_t.pmds006,pmds_t.pmdsdocdt,pmds_t.pmds002,pmds_t.pmds003,pmds_t.pmdsstus,pmds_t.pmds100,pmdt_t.pmdtseq,pmdt_t.pmdt001,pmdt_t.pmdt002,pmdt_t.pmdt003,pmdt_t.pmdt004,pmdt_t.pmdt019,pmdt_t.pmdt020,pmdt_t.pmdt028 FROM pmds_t ",
   #                "             LEFT OUTER JOIN pmdt_t ON pmdt_t.pmdtent = pmds_t.pmdsent AND pmdt_t.pmdtdocno = pmds_t.pmdsdocno ) z ON pmdl_t.pmdlent = z.pmdsent AND pmdl_t.pmdldocno = z.pmdt001 AND z.pmdt002 = u.pmdoseq AND z.pmdt003 = u.pmdoseq1 AND z.pmdt004 = u.pmdoseq2 AND z.pmds000 IN('7','14') "
   #ELSE
   #   LET g_from = " FROM pmda_t LEFT OUTER JOIN gzcbl_t ON gzcbl_t.gzcbl001 = '13' AND gzcbl_t.gzcbl002 = pmda_t.pmdastus AND gzcbl_t.gzcbl003 = '",g_dlang,"' ",
   #                "             LEFT OUTER JOIN ooag_t ON ooag_t.ooagent = pmda_t.pmdaent AND ooag_t.ooag001 = pmda_t.pmda002 ",
   #                "             LEFT OUTER JOIN ooefl_t ON ooefl_t.ooeflent = pmda_t.pmdaent AND ooefl_t.ooefl001 = pmda_t.pmda003 AND ooefl_t.ooefl002 = '",g_dlang,"' ",
   #                "             LEFT OUTER JOIN (SELECT pmdb_t.*,imaa_t.*,imaf_t.*,imaal_t.* FROM pmdb_t ",
   #                "             LEFT OUTER JOIN imaa_t ON imaa_t.imaaent = pmdb_t.pmdbent AND imaa_t.imaa001 = pmdb_t.pmdb004 ",
   #                "             LEFT OUTER JOIN imaal_t ON imaal_t.imaalent = pmdb_t.pmdbent AND imaal_t.imaal001 = pmdb_t.pmdb004 AND imaal_t.imaal002 = '",g_dlang,"' ",
   #                "             LEFT OUTER JOIN imaf_t ON imaf_t.imafent = pmdb_t.pmdbent AND imaf_t.imaf001 = pmdb_t.pmdb004 AND imaf_t.imafsite = pmdb_t.pmdbsite) u ON pmda_t.pmdaent = u.pmdbent AND pmda_t.pmdadocno = u.pmdbdocno ",
   #                "             LEFT OUTER JOIN (SELECT pmdl_t.*,pmdo_t.*,pmdp_t.pmdp003,pmdp_t.pmdp004 FROM pmdl_t ",
   #                "                LEFT OUTER JOIN pmdo_t ON pmdo_t.pmdoent = pmdl_t.pmdlent AND pmdo_t.pmdodocno = pmdl_t.pmdldocno ",
   #                "                LEFT OUTER JOIN pmdp_t ON pmdo_t.pmdoent = pmdp_t.pmdpent AND pmdo_t.pmdodocno = pmdp_t.pmdpdocno AND pmdo_t.pmdoseq = pmdp_t.pmdpseq) v ON pmda_t.pmdaent = v.pmdlent AND ((pmda_t.pmdadocno = v.pmdl008) AND u.pmdbseq = v.pmdoseq OR (v.pmdp003 = pmda_t.pmdadocno AND v.pmdp004 = u.pmdbseq))",
   #                "             LEFT OUTER JOIN (SELECT pmds_t.pmdsent,pmds_t.pmdsdocno,pmds_t.pmds000,pmds_t.pmds006,pmds_t.pmdsdocdt,pmds_t.pmds002,pmds_t.pmds003,pmds_t.pmdsstus,pmdt_t.pmdtseq,pmdt_t.pmdt001,pmdt_t.pmdt002,pmdt_t.pmdt003,pmdt_t.pmdt004,pmdt_t.pmdt006,pmdt_t.pmdt007,pmdt_t.pmdt016,pmdt_t.pmdt017,pmdt_t.pmdt018,pmdt_t.pmdt019,pmdt_t.pmdt020 FROM pmds_t ",
   #                "                LEFT OUTER JOIN pmdt_t ON pmdt_t.pmdtent = pmds_t.pmdsent AND pmdt_t.pmdtdocno = pmds_t.pmdsdocno ) w ON pmda_t.pmdaent = w.pmdsent AND v.pmdldocno = w.pmdt001 AND w.pmdt002 = v.pmdoseq AND w.pmdt003 = v.pmdoseq1 AND w.pmdt004 = v.pmdoseq2 AND w.pmds000 IN('1','8') ",
   #                "             LEFT OUTER JOIN (SELECT pmds_t.pmdsent,pmds_t.pmdsdocno,pmds_t.pmds000,pmds_t.pmds006,pmds_t.pmdsdocdt,pmds_t.pmds002,pmds_t.pmds003,pmds_t.pmdsstus,pmds_t.pmds100,pmdt_t.pmdtseq,pmdt_t.pmdt001,pmdt_t.pmdt002,pmdt_t.pmdt003,pmdt_t.pmdt004,pmdt_t.pmdt019,pmdt_t.pmdt020,pmdt_t.pmdt028 FROM pmds_t ",
   #                "                LEFT OUTER JOIN pmdt_t ON pmdt_t.pmdtent = pmds_t.pmdsent AND pmdt_t.pmdtdocno = pmds_t.pmdsdocno ) x ON pmda_t.pmdaent = x.pmdsent AND v.pmdldocno = x.pmdt001 AND x.pmdt002 = v.pmdoseq AND x.pmdt003 = v.pmdoseq1 AND x.pmdt004 = v.pmdoseq2 AND x.pmds000 IN('5','10') ",
   #                "             LEFT OUTER JOIN (SELECT pmds_t.pmdsent,pmds_t.pmdsdocno,pmds_t.pmds000,pmds_t.pmds006,pmds_t.pmdsdocdt,pmds_t.pmds002,pmds_t.pmds003,pmds_t.pmdsstus,pmdt_t.pmdtseq,pmdt_t.pmdt001,pmdt_t.pmdt002,pmdt_t.pmdt003,pmdt_t.pmdt004,pmdt_t.pmdt006,pmdt_t.pmdt007,pmdt_t.pmdt016,pmdt_t.pmdt017,pmdt_t.pmdt018,pmdt_t.pmdt019,pmdt_t.pmdt020 FROM pmds_t ",
   #                "                LEFT OUTER JOIN pmdt_t ON pmdt_t.pmdtent = pmds_t.pmdsent AND pmdt_t.pmdtdocno = pmds_t.pmdsdocno ) y ON pmda_t.pmdaent = y.pmdsent AND v.pmdldocno = y.pmdt001 AND y.pmdt002 = v.pmdoseq AND y.pmdt003 = v.pmdoseq1 AND y.pmdt004 = v.pmdoseq2  AND y.pmds000 IN('3','6','12') ",
   #                "             LEFT OUTER JOIN (SELECT pmds_t.pmdsent,pmds_t.pmdsdocno,pmds_t.pmds000,pmds_t.pmds006,pmds_t.pmdsdocdt,pmds_t.pmds002,pmds_t.pmds003,pmds_t.pmdsstus,pmds_t.pmds100,pmdt_t.pmdtseq,pmdt_t.pmdt001,pmdt_t.pmdt002,pmdt_t.pmdt003,pmdt_t.pmdt004,pmdt_t.pmdt019,pmdt_t.pmdt020,pmdt_t.pmdt028 FROM pmds_t ",
   #                "                LEFT OUTER JOIN pmdt_t ON pmdt_t.pmdtent = pmds_t.pmdsent AND pmdt_t.pmdtdocno = pmds_t.pmdsdocno ) z ON pmda_t.pmdaent = z.pmdsent AND v.pmdldocno = z.pmdt001 AND z.pmdt002 = v.pmdoseq AND z.pmdt003 = v.pmdoseq1 AND z.pmdt004 = v.pmdoseq2 AND z.pmds000 IN('7','14') "
   #END IF
   #151106-00004#10 20151119 s983961--mark(e)
   
   IF tm.wc = ' 1=1 ' THEN
      LET g_from = " FROM pmdl_t ",
                   #160413-00011#7--mark---begin---
                   #"             LEFT OUTER JOIN (SELECT pmdo_t.*,pmdp_t.*,s4.gzcbl004 s4_gzcbl004,d4.imaal003 d4_imaal003,d4.imaal004 d4_imaal004, ",  #s983961--add gzcbl004,d4.imaal003/004
                   #"                                (pmdo006-pmdo019) pmdo019_1 ", 
                   #"                                FROM pmdo_t ",  
                   #"                                LEFT OUTER JOIN gzcbl_t s4 ON s4.gzcbl001 = '2055' AND s4.gzcbl002 = pmdo003 AND s4.gzcbl003 ='",g_dlang,"' ",   #s983961--add gzcbl_t
                   #"                                LEFT OUTER JOIN imaal_t d4 ON d4.imaalent = pmdoent AND d4.imaal001 = pmdo001 AND d4.imaal002 = '",g_dlang,"' ",  #s983961--add imaal_t
                   #160413-00011#7--mark---end---
                   #160413-00011#7--add---begin---
                   "             LEFT OUTER JOIN (SELECT pmdoent,pmdodocno,pmdoseq,pmdpent,pmdpdocno, pmdpseq,pmdoseq1,pmdoseq2,pmdo003,pmdo001,pmdo012,(pmdo006-pmdo019) pmdo019_1,",
                   "                                     pmdp003,pmdp004 ,",
                   "                                 (SELECT imaal003 FROM imaal_t WHERE imaalent = pmdoent AND imaal001 = pmdo001 AND imaal002 = '",g_dlang,"') d4_imaal003, ",
                   "                                 (SELECT imaal004 FROM imaal_t WHERE imaalent = pmdoent AND imaal001 = pmdo001 AND imaal002 = '",g_dlang,"') d4_imaal004, ",
                   "                                 (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '2055' AND gzcbl002 = pmdo003 AND gzcbl003 = '",g_dlang,"' ) s4_gzcbl004 ",
                   "                                 FROM pmdo_t ",  
                   #160413-00011#7--add---end---
                   "                                                            ,pmdp_t) u ON pmdl_t.pmdlent = u.pmdoent AND pmdl_t.pmdldocno = u.pmdodocno AND u.pmdoent = u.pmdpent AND u.pmdodocno = u.pmdpdocno AND u.pmdoseq = u.pmdpseq ",
                   #160413-00011#7--mark---end---
                   #"             LEFT OUTER JOIN (SELECT pmda_t.*,pmdb_t.*, ",
                   ##151106-00004#10 s983961--add(s)
                   #"                                     ooefl003,b0.ooag011 b0_ooag011,d3.imaal003 d3_imaal003,d3.imaal004 d3_imaal004,s0.gzcbl004 s0_gzcbl004, ",
                   #"                                     imaa009,imaa127,s1.gzcbl004 s1_gzcbl004 ",
                   ##151106-00004#10 s983961--add(e)
                   #"                                FROM pmda_t ",
                   #"                                LEFT OUTER JOIN pmdb_t ON pmdb_t.pmdbent = pmda_t.pmdaent AND pmdb_t.pmdbdocno = pmda_t.pmdadocno ",
                   ##151106-00004#10 s983961--add(s)
                   #"                                LEFT OUTER JOIN ooefl_t ON ooeflent = pmdaent AND ooefl001 = pmda003 AND ooefl002 ='",g_dlang,"' ",     
                   #"                                LEFT OUTER JOIN ooag_t b0 ON b0.ooagent = pmdaent AND b0.ooag001 = pmda002 ",                      
                   #"                                LEFT OUTER JOIN imaal_t d3 ON d3.imaalent = pmdaent AND d3.imaal001 = pmdb004 AND d3.imaal002 = '",g_dlang,"' ",
                   #"                                LEFT OUTER JOIN gzcbl_t s0 ON s0.gzcbl001 = '2036' AND s0.gzcbl002 = pmdb033 AND s0.gzcbl003 = '",g_dlang,"' ",
                   #"                                LEFT OUTER JOIN imaa_t  ON imaaent = pmdaent AND imaa001 = pmdb004  ",
                   #"                                LEFT OUTER JOIN gzcbl_t s1 ON s1.gzcbl001 = '13' AND s1.gzcbl002 = pmdastus AND s1.gzcbl003 = '",g_dlang,"' ",
                   ##151106-00004#10 s983961--add(e)
                   #160413-00011#7--mark---end---
                   #160413-00011#7--add---begin---
                   "             LEFT OUTER JOIN (SELECT pmdaent,pmdasite,pmdadocno,pmdadocdt,pmda002,pmda003,pmdastus,pmdbseq,pmdb004,imaa009,imaa127, ",
                   "                                     pmdb033,pmdb030,pmdb007,pmdb006,pmdb049,",
                   "                                     imaf141 ,",
                   "                                 (SELECT imaal003 FROM imaal_t WHERE imaalent = pmdaent AND imaal001 = pmdb004 AND imaal002 = '",g_dlang,"') d3_imaal003, ",
                   "                                 (SELECT imaal004 FROM imaal_t WHERE imaalent = pmdaent AND imaal001 = pmdb004 AND imaal002 = '",g_dlang,"') d3_imaal004, ",
                   "                                 (SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent = pmdaent AND rtaxl001 = imaa009 AND rtaxl002 = '",g_dlang,"') rtaxl003,",
                   "                                 (SELECT oocql004 FROM oocql_t WHERE oocqlent = pmdaent AND oocql001 = '203' AND oocql002 = imaf141 AND oocql003 = '",g_dlang,"') d1_oocql004,",
                   "                                 (SELECT oocql004 FROM oocql_t WHERE oocqlent = pmdaent AND oocql001 = '2003' AND oocql002 = imaa127 AND oocql003 = '",g_dlang,"') d2_oocql004, ",
                   "                                 (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '2036' AND gzcbl002 = pmdb033 AND gzcbl003 = '",g_dlang,"' ) s0_gzcbl004 ,",
                   "                                 (SELECT ooefl003 FROM ooefl_t WHERE ooeflent = pmdaent AND ooefl001 = pmda003 AND ooefl002 ='",g_dlang,"' ) b1_ooefl003 ,",
                   "                                 (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '13' AND gzcbl002 = pmdastus AND gzcbl003 = '",g_dlang,"' ) s1_gzcbl004 ,",
                   "                                 (SELECT ooag011  FROM ooag_t WHERE ooagent = pmdaent AND ooag001 = pmda002) b0_ooag011 ",
                   "                                FROM pmda_t ",
                   "                                LEFT OUTER JOIN pmdb_t ON pmdbent = pmdaent AND pmdbdocno = pmdadocno ",
                   "                                LEFT OUTER JOIN imaa_t ON imaaent = pmdaent AND imaa001 = pmdb004  ",
                   "                                LEFT OUTER JOIN imaf_t ON imafent = pmdaent AND imaf001 = pmdb004 AND imafsite = pmdasite ",
                   #160413-00011#7--add---end---
                   "                             ) v ON pmdl_t.pmdlent = v.pmdaent AND ((pmdl_t.pmdl008 = v.pmdadocno AND u.pmdoseq = v.pmdbseq) OR (u.pmdp003 = v.pmdadocno AND u.pmdp004 = v.pmdbseq))",
                   "             LEFT OUTER JOIN (SELECT pmds_t.pmdsent,pmds_t.pmdsdocno,pmds_t.pmds000,pmds_t.pmds006,pmds_t.pmdsdocdt,pmds_t.pmds002,pmds_t.pmds003,pmds_t.pmdsstus,pmdt_t.pmdtseq,pmdt_t.pmdt001,pmdt_t.pmdt002,pmdt_t.pmdt003,pmdt_t.pmdt004,pmdt_t.pmdt006,pmdt_t.pmdt007,pmdt_t.pmdt016,pmdt_t.pmdt017,pmdt_t.pmdt018,pmdt_t.pmdt019,pmdt_t.pmdt020, ",
                   #"                                     d5.gzcbl004 d5_gzcbl004,d6.ooag011 d6_ooag011,d7.ooefl003 d7_ooefl003,d8.imaal003 d8_imaal003,d8.imaal004 d8_imaal004,d9.inayl003 d9_inayl003 ",  #s983961--add d5_gzcbl004,d6_ooag011,d8_imaal003,d8_imaal004  #160413-00011#7 mark
                   #160413-00011#7--add---begin---
                   "                                 (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '13' AND gzcbl002 = pmdsstus AND gzcbl003 = '",g_dlang,"' ) d5_gzcbl004 ,",
                   "                                 (SELECT ooag011 FROM ooag_t WHERE ooagent = pmdsent AND ooag001 = pmds002 ) d6_ooag011 ,",
                   "                                 (SELECT ooefl003 FROM ooefl_t WHERE ooeflent = pmdsent AND ooefl001 = pmds003 AND ooefl002 ='",g_dlang,"' ) d7_ooefl003,",
                   "                                 (SELECT imaal003 FROM imaal_t WHERE imaalent = pmdsent AND imaal001 = pmdt006 AND imaal002 = '",g_dlang,"' ) d8_imaal003 ,",
                   "                                 (SELECT imaal004 FROM imaal_t WHERE imaalent = pmdsent AND imaal001 = pmdt006 AND imaal002 = '",g_dlang,"' ) d8_imaal004 ,",
                   "                                 (SELECT inayl003 FROM inayl_t WHERE inaylent = pmdsent AND inayl001 = pmdt016 AND inayl002 = '",g_dlang,"' ) d9_inayl003,",
                   "                                 (SELECT inaml004 FROM inaml_t WHERE inamlent = pmdsent AND inaml001 = pmdt006 AND inaml002 = pmdt007 AND inaml003 = '",g_dlang,"' ) d9_inaml004 ",
                   #160413-00011#7--add---end---
                   "                                FROM pmds_t ",
                   "                                LEFT OUTER JOIN pmdt_t ON pmdt_t.pmdtent = pmds_t.pmdsent AND pmdt_t.pmdtdocno = pmds_t.pmdsdocno ",
                   #160413-00011#7--mark---begin---
                   ##151106-00004#10 s983961--add(s)
                   #"                                LEFT OUTER JOIN gzcbl_t d5 ON d5.gzcbl001 = '13' AND d5.gzcbl002 = pmdsstus AND d5.gzcbl003 = '",g_dlang,"' ", 
                   #"                                LEFT OUTER JOIN ooag_t d6 ON d6.ooagent = pmdsent AND d6.ooag001 = pmds002 ",                                  
                   #"                                LEFT OUTER JOIN ooefl_t d7 ON d7.ooeflent = pmdsent AND d7.ooefl001 = pmds003 AND d7.ooefl002 ='",g_dlang,"' ",     
                   #"                                LEFT OUTER JOIN imaal_t d8 ON d8.imaalent = pmdsent AND d8.imaal001 = pmdt006 AND d8.imaal002 = '",g_dlang,"' ",
                   #"                                LEFT OUTER JOIN inayl_t d9 ON d9.inaylent = pmdsent AND d9.inayl001 = pmdt016 AND d9.inayl002 = '",g_dlang,"' ",               
                   ##151106-00004#10 s983961--add(e)
                   #160413-00011#7--mark---end---
                   "                             ) w ON pmdl_t.pmdlent = w.pmdsent AND pmdl_t.pmdldocno = w.pmdt001 AND w.pmdt002 = u.pmdoseq AND w.pmdt003 = u.pmdoseq1 AND w.pmdt003 = u.pmdoseq2 AND w.pmds000 IN('1','8') ",
                   "             LEFT OUTER JOIN (SELECT pmds_t.pmdsent,pmds_t.pmdsdocno,pmds_t.pmds000,pmds_t.pmds006,pmds_t.pmdsdocdt,pmds_t.pmds002,pmds_t.pmds003,pmds_t.pmdsstus,pmds_t.pmds100,pmdt_t.pmdtseq,pmdt_t.pmdt001,pmdt_t.pmdt002,pmdt_t.pmdt003,pmdt_t.pmdt004,pmdt_t.pmdt019,pmdt_t.pmdt020,pmdt_t.pmdt028, ",
                   #"                                     d10.gzcbl004 d10_gzcbl004,d13.ooag011 d13_ooag011,d14.ooefl003 d14_ooefl003  ",  #160413-00011#7 mark
                   #160413-00011#7--add---begin---
                   "                                (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '13' AND gzcbl002 = pmdsstus AND gzcbl003 =  '",g_dlang,"') d10_gzcbl004, ",
                   "                                (SELECT ooag011 FROM ooag_t WHERE ooagent = pmdsent AND ooag001 = pmds002) d13_ooag011, ",
                   "                                (SELECT ooefl003 FROM ooefl_t WHERE ooeflent = pmdsent AND ooefl001 = pmds003 AND ooefl002 = '",g_dlang,"' ) d14_ooefl003 ",

                   #160413-00011#7--add---end---
                   "                               FROM pmds_t ",
                   "                               LEFT OUTER JOIN pmdt_t ON pmdt_t.pmdtent = pmds_t.pmdsent AND pmdt_t.pmdtdocno = pmds_t.pmdsdocno ",
                   #160413-00011#7--mark---begin---
                   #"                               LEFT OUTER JOIN gzcbl_t d10 ON d10.gzcbl001 = '13' AND d10.gzcbl002 = pmdsstus AND d10.gzcbl003 = '",g_dlang,"' ",  #151106-00004#10 s983961--add gzcbl_t d10
                   #"                               LEFT OUTER JOIN ooag_t d13 ON d13.ooagent = pmdsent AND d13.ooag001 = pmds002 ",                                    #151106-00004#10 s983961--add ooag_t  d13
                   #"                               LEFT OUTER JOIN ooefl_t d14 ON d14.ooeflent = pmdsent AND d14.ooefl001 = pmds003 AND d14.ooefl002 ='",g_dlang,"' ", #151106-00004#10 s983961--add ooefl_t d14    
                   #160413-00011#7--mark---end---
                   "                             ) x ON pmdl_t.pmdlent = x.pmdsent AND pmdl_t.pmdldocno = x.pmdt001 AND x.pmdt002 = u.pmdoseq AND x.pmdt003 = u.pmdoseq1 AND x.pmdt003 = u.pmdoseq2 AND x.pmds000 IN('5','10') ",
                   "             LEFT OUTER JOIN (SELECT pmds_t.pmdsent,pmds_t.pmdsdocno,pmds_t.pmds000,pmds_t.pmds006,pmds_t.pmdsdocdt,pmds_t.pmds002,pmds_t.pmds003,pmds_t.pmdsstus,pmdt_t.pmdtseq,pmdt_t.pmdt001,pmdt_t.pmdt002,pmdt_t.pmdt003,pmdt_t.pmdt004,pmdt_t.pmdt006,pmdt_t.pmdt007,pmdt_t.pmdt016,pmdt_t.pmdt017,pmdt_t.pmdt018,pmdt_t.pmdt019,pmdt_t.pmdt020, ",
                   #"                                     d11.gzcbl004 d11_gzcbl004,d15.ooag011 d15_ooag011,d16.ooefl003 d16_ooefl003,d17.imaal003 d17_imaal003,d17.imaal004 d17_imaal004,d18.inayl003 d18_inayl003,pmdt_t.pmdt028 ", #160310-00041#1-add-'pmdt_t.pmdt028'  #160413-00011#7 mark
                   #160413-00011#7--add---begin---
                   "                                     (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '13' AND gzcbl002 = pmdsstus AND gzcbl003 =  '",g_dlang,"') d11_gzcbl004,  ",
                   "                                     (SELECT ooag011 FROM ooag_t WHERE ooagent = pmdsent AND ooag001 = pmds002) d15_ooag011,      ",
                   "                                     (SELECT ooefl003 FROM ooefl_t WHERE ooeflent = pmdsent AND ooefl001 = pmds003 AND ooefl002 = '",g_dlang,"') d16_ooefl003, ",
                   "                                     (SELECT imaal003 FROM imaal_t WHERE imaalent = pmdsent AND imaal001 = pmdt006 AND imaal002 =  '",g_dlang,"') d17_imaal003,",
                   "                                     (SELECT imaal004 FROM imaal_t WHERE imaalent = pmdsent AND imaal001 = pmdt006 AND imaal002 =  '",g_dlang,"') d17_imaal004,",
                   "                                     (SELECT inayl003 FROM inayl_t WHERE inaylent = pmdsent AND inayl001 = pmdt016 AND inayl002 =  '",g_dlang,"') d18_inayl003,",
                   "                                     (SELECT inaml004 FROM inaml_t WHERE inamlent = pmdsent AND inaml001 = pmdt006 AND inaml002 = pmdt007 AND inaml003 = '",g_dlang,"' ) d18_inaml004,",
                   "                                     pmdt_t.pmdt028 ",
                   #160413-00011#7--add---end---
                   "                                FROM pmds_t ",
                   "                                LEFT OUTER JOIN pmdt_t ON pmdt_t.pmdtent = pmds_t.pmdsent AND pmdt_t.pmdtdocno = pmds_t.pmdsdocno ",              
                   #160413-00011#7--mark---begin---
                   #"                                LEFT OUTER JOIN gzcbl_t d11 ON d11.gzcbl001 = '13' AND d11.gzcbl002 = pmdsstus AND d11.gzcbl003 = '",g_dlang,"' ",  #151106-00004#10 s983961--add gzcbl_t d11
                   #"                                LEFT OUTER JOIN ooag_t d15 ON d15.ooagent = pmdsent AND d15.ooag001 = pmds002 ",                                    #151106-00004#10 s983961--add ooag_t  d15
                   #"                                LEFT OUTER JOIN ooefl_t d16 ON d16.ooeflent = pmdsent AND d16.ooefl001 = pmds003 AND d16.ooefl002 ='",g_dlang,"' ", #151106-00004#10 s983961--add ooefl_t d16     
                   #"                                LEFT OUTER JOIN imaal_t d17 ON d17.imaalent = pmdsent AND d17.imaal001 = pmdt006 AND d17.imaal002 = '",g_dlang,"' ",#151106-00004#10 s983961--add imaal_t d17
                   #"                                LEFT OUTER JOIN inayl_t d18 ON d18.inaylent = pmdsent AND d18.inayl001 = pmdt016 AND d18.inayl002 = '",g_dlang,"' ",#151106-00004#10 s983961--add inayl_t d18
                   #160413-00011#7--mark---end---
                   #160310-00041#1-mod-(S)
#                   "                             ) y ON pmdl_t.pmdlent = y.pmdsent AND pmdl_t.pmdldocno = y.pmdt001 AND y.pmdt002 = u.pmdoseq AND y.pmdt003 = u.pmdoseq1 AND y.pmdt003 = u.pmdoseq2 AND y.pmds000 IN('3','6','12') ",
                   "                              ) y ON (pmdl_t.pmdlent = y.pmdsent AND  y.pmds006 =w.pmdsdocno AND y.pmdt028=w.pmdtseq AND w.pmdt001 = y.pmdt001 AND w.pmdt002=y.pmdt002  AND w.pmdt003=y.pmdt003 ",   
                   "                                      AND y.pmds000 IN('6','12') ) OR (pmdl_t.pmdlent = y.pmdsent AND pmdl_t.pmdldocno = y.pmdt001 AND y.pmdt002 = u.pmdoseq AND y.pmdt003 = u.pmdoseq1 AND y.pmdt003 = u.pmdoseq2 AND y.pmds000 = '3') ",
                   #160310-00041#1-mod-(E)
                   "             LEFT OUTER JOIN (SELECT pmds_t.pmdsent,pmds_t.pmdsdocno,pmds_t.pmds000,pmds_t.pmds006,pmds_t.pmdsdocdt,pmds_t.pmds002,pmds_t.pmds003,pmds_t.pmdsstus,pmds_t.pmds100,pmdt_t.pmdtseq,pmdt_t.pmdt001,pmdt_t.pmdt002,pmdt_t.pmdt003,pmdt_t.pmdt004,pmdt_t.pmdt019,pmdt_t.pmdt020,pmdt_t.pmdt028, ",
                   #"                                     d20.gzcbl004 d20_gzcbl004,d21.gzcbl004 d21_gzcbl004,d22.ooag011 d22_ooag011,d23.ooefl003 d23_ooefl003  ",  #160413-00011#7 mark
                   #160413-00011#7--add---begin---
                   "                                     (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '13' AND gzcbl002 = pmdsstus AND gzcbl003 =  '",g_dlang,"') d20_gzcbl004, ",
                   "                                     (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '2062' AND gzcbl002 = pmds100 AND gzcbl003 =  '",g_dlang,"') d21_gzcbl004,",
                   "                                     (SELECT ooag011 FROM ooag_t WHERE ooagent = pmdsent AND ooag001 = pmds002 ) d22_ooag011,        ",
                   "                                     (SELECT ooefl003 FROM ooefl_t WHERE ooeflent = pmdsent AND ooefl001 = pmds003 AND ooefl002 = '",g_dlang,"') d23_ooefl003 ",
                   #160413-00011#7--add---end---
                   "                                FROM pmds_t ",
                   "                                LEFT OUTER JOIN pmdt_t ON pmdt_t.pmdtent = pmds_t.pmdsent AND pmdt_t.pmdtdocno = pmds_t.pmdsdocno ",
                   #160413-00011#7--mark---begin---
                   #"                                LEFT OUTER JOIN gzcbl_t d20 ON d20.gzcbl001 = '13' AND d20.gzcbl002 = pmdsstus AND d20.gzcbl003 = '",g_dlang,"' ",  #151106-00004#10 s983961--add gzcbl_t d20
                   #"                                LEFT OUTER JOIN gzcbl_t d21 ON d21.gzcbl001 = '2062' AND d21.gzcbl002 = pmds100 AND d21.gzcbl003 = '",g_dlang,"' ", #151106-00004#10 s983961--add gzcbl_t d21
                   #"                                LEFT OUTER JOIN ooag_t d22 ON d22.ooagent = pmdsent AND d22.ooag001 = pmds002 ",                                    #151106-00004#10 s983961--add ooag_t  d22
                   #"                                LEFT OUTER JOIN ooefl_t d23 ON d23.ooeflent = pmdsent AND d23.ooefl001 = pmds003 AND d23.ooefl002 ='",g_dlang,"' ", #151106-00004#10 s983961--add ooefl_t d23     
                   #160413-00011#7--mark---end---
                   "                             ) z ON pmdl_t.pmdlent = z.pmdsent AND pmdl_t.pmdldocno = z.pmdt001 AND z.pmdt002 = u.pmdoseq AND z.pmdt003 = u.pmdoseq1 AND z.pmdt004 = u.pmdoseq2 AND z.pmds000 IN('7','14') ",
                   "                                    AND ((z.pmds006 = y.pmds006  AND z.pmdt028 =  y.pmdt028 AND y.pmds000 IN ('6','12')) OR (z.pmds006 = y.pmdsdocno AND z.pmdt028=y.pmdtseq AND y.pmds000 = '3')) "#, #160310-00041#1-add
                   #160413-00011#7--mark---begin---
                   ##151106-00004#10 s983961 add--(s)
                   #"             LEFT OUTER JOIN imaf_t  ON imafent = pmdlent AND imafsite = pmdlsite AND imaf001 = v.pmdb004 ",
                   #"             LEFT OUTER JOIN pmdn_t ON pmdnent = pmdlent AND pmdndocno = pmdldocno AND pmdnseq = u.pmdoseq ",
                   #"             LEFT OUTER JOIN gzcbl_t s2 ON s2.gzcbl001 = '13' AND s2.gzcbl002 = pmdlstus AND s2.gzcbl003 = '",g_dlang,"' ",
                   #"             LEFT OUTER JOIN gzcbl_t s3 ON s3.gzcbl001 = '2052' AND s3.gzcbl002 = pmdl005 AND s3.gzcbl003 = '",g_dlang,"' ",
                   #"             LEFT OUTER JOIN ooag_t b1 ON b1.ooagent = pmdlent AND b1.ooag001 = pmdl002 ",  
                   #"             LEFT OUTER JOIN ooefl_t b2 ON b2.ooeflent = pmdlent AND b2.ooefl001 = pmdl003 AND b2.ooefl002 = '",g_dlang,"' ",
                   #"             LEFT OUTER JOIN pmaal_t c0 ON c0.pmaalent = pmdlent AND c0.pmaal001 = pmdl004 AND c0.pmaal002 = '",g_dlang,"' ",
                   #"             LEFT OUTER JOIN pmaal_t c1 ON c1.pmaalent = pmdlent AND c1.pmaal001 = pmdl021 AND c1.pmaal002 = '",g_dlang,"' ",
                   #"             LEFT OUTER JOIN pmaal_t c2 ON c2.pmaalent = pmdlent AND c2.pmaal001 = pmdl022 AND c2.pmaal002 = '",g_dlang,"' ",
                   #"             LEFT OUTER JOIN oocql_t d0 ON d0.oocqlent = pmdlent AND d0.oocql001 = '275' AND d0.oocql002 = pmdl023 AND d0.oocql003 = '",g_dlang,"' ", 
                   #"             LEFT OUTER JOIN rtaxl_t ON rtaxlent = pmdlent AND rtaxl001 = imaa009 AND rtaxl002 = '",g_dlang,"' ",
                   #"             LEFT OUTER JOIN oocql_t d1 ON d1.oocqlent = pmdlent AND d1.oocql001 = '203' AND d1.oocql002 = imaf141 AND d1.oocql003 = '",g_dlang,"' ",
                   #"             LEFT OUTER JOIN oocql_t d2 ON d2.oocqlent = pmdlent AND d1.oocql001 = '2003' AND d2.oocql002 = imaa127 AND d2.oocql003 = '",g_dlang,"' ",
                   #"             LEFT OUTER JOIN inab_t d12 ON d12.inabent  = pmdlent AND d12.inabsite = pmdlsite AND d12.inab001  = w.pmdt016 AND d12.inab002  = w.pmdt017 ",
                   #"             LEFT OUTER JOIN inab_t d19 ON d19.inabent  = pmdlent AND d19.inabsite = pmdlsite AND d19.inab001  = y.pmdt016 AND d19.inab002  = y.pmdt017 "
                   ##151106-00004#10 s983961 add--(e)
                   #160413-00011#7--mark---end---
   ELSE
      LET g_from = " FROM pmda_t ",
                   #160413-00011#7--mark---begin---
                   #"             LEFT OUTER JOIN gzcbl_t s1 ON s1.gzcbl001 = '13' AND s1.gzcbl002 = pmdastus AND s1.gzcbl003 = '",g_dlang,"' ",
                   #"             LEFT OUTER JOIN ooag_t b0 ON b0.ooagent = pmda_t.pmdaent AND b0.ooag001 = pmda_t.pmda002 ",
                   #"             LEFT OUTER JOIN ooefl_t ON ooefl_t.ooeflent = pmda_t.pmdaent AND ooefl_t.ooefl001 = pmda_t.pmda003 AND ooefl_t.ooefl002 = '",g_dlang,"' ",
                   #"             LEFT OUTER JOIN (SELECT pmdb_t.*,imaa_t.*,imaf_t.*,imaal_t.*,rtaxl003,d1.oocql004 d1_oocql004,d2.oocql004 d2_oocql004 FROM pmdb_t ",  #151106-00004#10 s983961--add rtaxl003,d1_oocql004,d2_oocql004,d8_imaal003,d8_imaal004
                   #"                                LEFT OUTER JOIN imaa_t ON imaa_t.imaaent = pmdb_t.pmdbent AND imaa_t.imaa001 = pmdb_t.pmdb004 ",
                   #"                                LEFT OUTER JOIN rtaxl_t ON rtaxlent = pmdbent AND rtaxl001 = imaa009 AND rtaxl002 = '",g_dlang,"' ",  #151106-00004#10 s983961 add
                   #"                                LEFT OUTER JOIN imaal_t ON imaal_t.imaalent = pmdb_t.pmdbent AND imaal_t.imaal001 = pmdb_t.pmdb004 AND imaal_t.imaal002 = '",g_dlang,"' ",
                   #"                                LEFT OUTER JOIN imaf_t ON imaf_t.imafent = pmdb_t.pmdbent AND imaf_t.imaf001 = pmdb_t.pmdb004 AND imaf_t.imafsite = pmdb_t.pmdbsite ",
                   #"                                LEFT OUTER JOIN oocql_t d1 ON d1.oocqlent = pmdbent AND d1.oocql001 = '203' AND d1.oocql002 = imaf141 AND d1.oocql003 = '",g_dlang,"' ",  #151106-00004#10 s983961 add
                   #"                                LEFT OUTER JOIN oocql_t d2 ON d2.oocqlent = pmdbent AND d1.oocql001 = '2003' AND d2.oocql002 = imaa127 AND d2.oocql003 = '",g_dlang,"') ",
                   #160413-00011#7--mark---end---
                   #160413-00011#7--add---begin---
                   "             LEFT OUTER JOIN (SELECT pmdbent,pmdbdocno,pmdbseq,pmdb004, pmdb033,pmdb030,pmdb007,pmdb006,pmdb049,imaa009,imaa127,imaf141,",
                   "                                 (SELECT imaal003 FROM imaal_t WHERE imaalent = pmdbent AND imaal001 = pmdb004 AND imaal002 = '",g_dlang,"') imaal003, ",
                   "                                 (SELECT imaal004 FROM imaal_t WHERE imaalent = pmdbent AND imaal001 = pmdb004 AND imaal002 = '",g_dlang,"') imaal004, ",
                   "                                 (SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent = pmdbent AND rtaxl001 = imaa009 AND rtaxl002 = '",g_dlang,"') rtaxl003,",
                   "                                 (SELECT oocql004 FROM oocql_t WHERE oocqlent = pmdbent AND oocql001 = '203' AND oocql002 = imaf141 AND oocql003 = '",g_dlang,"') d1_oocql004,",
                   "                                 (SELECT oocql004 FROM oocql_t WHERE oocqlent = pmdbent AND oocql001 = '2003' AND oocql002 = imaa127 AND oocql003 = '",g_dlang,"') d2_oocql004, ",
                   "                                 (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '2036' AND gzcbl002 = pmdb033 AND gzcbl003 = '",g_dlang,"' ) s0_gzcbl004 ",
                   "                           FROM pmdb_t ", 
                   "                                LEFT OUTER JOIN imaa_t ON imaa_t.imaaent = pmdb_t.pmdbent AND imaa_t.imaa001 = pmdb_t.pmdb004 ",
                   "                                LEFT OUTER JOIN imaf_t ON imaf_t.imafent = pmdb_t.pmdbent AND imaf_t.imaf001 = pmdb_t.pmdb004 AND imaf_t.imafsite = pmdb_t.pmdbsite ",
                   #160413-00011#7--add---end---
                   "                                 ) u ON pmda_t.pmdaent = u.pmdbent AND pmda_t.pmdadocno = u.pmdbdocno ",  
                   #160413-00011#7--mark---begin---
                   #"             LEFT OUTER JOIN (SELECT pmdl_t.*,pmdo_t.*,pmdp_t.pmdp003,pmdp_t.pmdp004, ",
                   ##151106-00004#10 s983961 add--(s)
                   #"                                     pmdn052,s2.gzcbl004 s2_gzcbl004,s3.gzcbl004 s3_gzcbl004,b1.ooag011 b1_ooag011,b2.ooefl003 b2_ooefl003,  ",   
                   #"                                     c0.pmaal004 c0_pmaal004,c1.pmaal004 c1_pmaal004,c2.pmaal004 c2_pmaal004,d0.oocql004 d0_oocql004, ",
                   #"                                     s4.gzcbl004 s4_gzcbl004,d4.imaal003 d4_imaal003,d4.imaal004 d4_imaal004,",  
                   ##151106-00004#10 s983961--add(e)            
                   #"                                     (pmdo006-pmdo019) pmdo019_1 ", #160413-00011#7 add
                   #"                                FROM pmdl_t ",
                   #"                                LEFT OUTER JOIN pmdo_t ON pmdo_t.pmdoent = pmdl_t.pmdlent AND pmdo_t.pmdodocno = pmdl_t.pmdldocno ",
                   #"                                LEFT OUTER JOIN pmdp_t ON pmdo_t.pmdoent = pmdp_t.pmdpent AND pmdo_t.pmdodocno = pmdp_t.pmdpdocno AND pmdo_t.pmdoseq = pmdp_t.pmdpseq ",
                   ##151106-00004#10 s983961--add(s)
                   #"                                LEFT OUTER JOIN gzcbl_t s4 ON s4.gzcbl001 = '2055' AND s4.gzcbl002 = pmdo003 AND s4.gzcbl003 ='",g_dlang,"' ", 
                   #"                                LEFT OUTER JOIN pmdn_t ON pmdnent = pmdlent AND pmdndocno = pmdldocno AND pmdnseq = pmdoseq ",  
                   #"                                LEFT OUTER JOIN gzcbl_t s2 ON s2.gzcbl001 = '13' AND s2.gzcbl002 = pmdlstus AND s2.gzcbl003 = '",g_dlang,"' ", 
                   #"                                LEFT OUTER JOIN gzcbl_t s3 ON s3.gzcbl001 = '2052' AND s3.gzcbl002 = pmdl005 AND s3.gzcbl003 = '",g_dlang,"' ",
                   #"                                LEFT OUTER JOIN ooag_t b1 ON b1.ooagent = pmdlent AND b1.ooag001 = pmdl002 ",  
                   #"                                LEFT OUTER JOIN ooefl_t b2 ON b2.ooeflent = pmdlent AND b2.ooefl001 = pmdl003 AND b2.ooefl002 = '",g_dlang,"' ",
                   #"                                LEFT OUTER JOIN pmaal_t c0 ON c0.pmaalent = pmdlent AND c0.pmaal001 = pmdl004 AND c0.pmaal002 = '",g_dlang,"' ",
                   #"                                LEFT OUTER JOIN pmaal_t c1 ON c1.pmaalent = pmdlent AND c1.pmaal001 = pmdl021 AND c1.pmaal002 = '",g_dlang,"' ",
                   #"                                LEFT OUTER JOIN pmaal_t c2 ON c2.pmaalent = pmdlent AND c2.pmaal001 = pmdl022 AND c2.pmaal002 = '",g_dlang,"' ",
                   #"                                LEFT OUTER JOIN oocql_t d0 ON d0.oocqlent = pmdlent AND d0.oocql001 = '275' AND d0.oocql002 = pmdl023 AND d0.oocql003 = '",g_dlang,"' ",
                   #"                                LEFT OUTER JOIN imaal_t d4 ON d4.imaalent = pmdoent AND d4.imaal001 = pmdo001 AND d4.imaal002 = '",g_dlang,"' ", 
                   ##151106-00004#10 s983961--add(e)
                   #160413-00011#7--mark---end---
                   #160413-00011#7--add---begin---
                   "             LEFT OUTER JOIN (SELECT pmdlent,pmdlsite,pmdldocno,pmdldocdt,pmdl005,pmdl002,pmdl003,pmdl004,pmdlstus,pmdl008,pmdl028 ", ##161207-00033#24 add pmdl028
                   "                                     pmdoent,pmdodocno,pmdoseq,pmdoseq1,pmdoseq2,pmdo003,pmdo001,pmdo012,pmdp003,pmdp004, ",                                    
                   "                              (SELECT pmdn052 FROM pmdn_t WHERE pmdnent = pmdlent AND pmdndocno = pmdldocno AND pmdnseq = pmdoseq) pmdn052, ",
                   "                              (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '13' AND gzcbl002 = pmdlstus AND gzcbl003 = '",g_dlang,"') s2_gzcbl004, ",
                   "                              (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '2052' AND gzcbl002 = pmdl005 AND gzcbl003 = '",g_dlang,"') s3_gzcbl004, ",
                   "                              (SELECT ooag011 FROM ooag_t WHERE ooagent = pmdlent AND ooag001 = pmdl002) b1_ooag011, ",
                   "                              (SELECT ooefl003 FROM ooefl_t WHERE ooeflent = pmdlent AND ooefl001 = pmdl003 AND ooefl002 = '",g_dlang,"') b2_ooefl003, ",                                       
                   "                              (SELECT pmaal004 FROM pmaal_t WHERE pmaalent = pmdlent AND pmaal001 = pmdl004 AND pmaal002 = '",g_dlang,"') c0_pmaal004, ",                                 
                   "                              (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '2055' AND gzcbl002 = pmdo003 AND gzcbl003 = '",g_dlang,"') s4_gzcbl004, ",
                   "                              (SELECT imaal003 FROM imaal_t WHERE imaalent = pmdoent AND imaal001 = pmdo001 AND imaal002 = '",g_dlang,"') d4_imaal003, ",
                   "                              (SELECT imaal004 FROM imaal_t WHERE imaalent = pmdoent AND imaal001 = pmdo001 AND imaal002 = '",g_dlang,"') d4_imaal004, ",
                   "                              (pmdo006-pmdo019) pmdo019_1 ",                           
                   "                             FROM pmdl_t  ",                          
                   "                              LEFT OUTER JOIN pmdo_t ON pmdoent = pmdlent AND pmdodocno = pmdldocno ",                               
                   "                              LEFT OUTER JOIN pmdp_t ON pmdoent = pmdpent AND pmdodocno = pmdpdocno AND pmdoseq = pmdpseq  ",
                   #160413-00011#7--add---end---
                   "                             ) v ON pmda_t.pmdaent = v.pmdlent AND ((pmda_t.pmdadocno = v.pmdl008) AND u.pmdbseq = v.pmdoseq OR (v.pmdp003 = pmda_t.pmdadocno AND v.pmdp004 = u.pmdbseq))",     
                   
                   "             LEFT OUTER JOIN (SELECT pmds_t.pmdsent,pmds_t.pmdsdocno,pmds_t.pmds000,pmds_t.pmds006,pmds_t.pmdsdocdt,pmds_t.pmds002,pmds_t.pmds003,pmds_t.pmdsstus,pmdt_t.pmdtseq,pmdt_t.pmdt001,pmdt_t.pmdt002,pmdt_t.pmdt003,pmdt_t.pmdt004,pmdt_t.pmdt006,pmdt_t.pmdt007,pmdt_t.pmdt016,pmdt_t.pmdt017,pmdt_t.pmdt018,pmdt_t.pmdt019,pmdt_t.pmdt020, ",
                   #160413-00011#7--add---begin---
                   "                               (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '13' AND gzcbl002 = pmdsstus AND gzcbl003 =  '",g_dlang,"') d5_gzcbl004,  ",
                   "                               (SELECT ooag011 FROM ooag_t WHERE ooagent = pmdsent AND ooag001 = pmds002) d6_ooag011,  ",
                   "                               (SELECT ooefl003 FROM ooefl_t WHERE ooeflent = pmdsent AND ooefl001 = pmds003 AND ooefl002 = '",g_dlang,"') d7_ooefl003, ",
                   "                               (SELECT imaal003 FROM imaal_t WHERE imaalent = pmdsent AND imaal001 = pmdt006 AND imaal002 =  '",g_dlang,"') d8_imaal003,",
                   "                               (SELECT imaal004 FROM imaal_t WHERE imaalent = pmdsent AND imaal001 = pmdt006 AND imaal002 =  '",g_dlang,"') d8_imaal004,",
                   "                               (SELECT inayl003 FROM inayl_t WHERE inaylent = pmdsent AND inayl001 = pmdt016 AND inayl002 =  '",g_dlang,"') d9_inayl003,", 
                   "                               (SELECT inaml004 FROM inaml_t WHERE inamlent = pmdsent AND inaml001 = pmdt006 AND inaml002 = pmdt007 AND inaml003 = '",g_dlang,"' ) d9_inaml004 ",
                   #160413-00011#7--add---end---
                   "                          FROM pmds_t ",
                   "                          LEFT OUTER JOIN pmdt_t ON pmdt_t.pmdtent = pmds_t.pmdsent AND pmdt_t.pmdtdocno = pmds_t.pmdsdocno ",
                   #160413-00011#7--mark---begin---
                   #"                                     d5.gzcbl004 d5_gzcbl004,d6.ooag011 d6_ooag011,d7.ooefl003 d7_ooefl003,d8.imaal003 d8_imaal003,d8.imaal004 d8_imaal004,d9.inayl003 d9_inayl003  ", 
                   #"                                FROM pmds_t ",
                   #"                                LEFT OUTER JOIN pmdt_t ON pmdt_t.pmdtent = pmds_t.pmdsent AND pmdt_t.pmdtdocno = pmds_t.pmdsdocno ",
                   ##151106-00004#10 s983961--add(s)
                   #"                                LEFT OUTER JOIN gzcbl_t d5 ON d5.gzcbl001 = '13' AND d5.gzcbl002 = pmdsstus AND d5.gzcbl003 = '",g_dlang,"' ", #s983961--add gzcbl_t d5
                   #"                                LEFT OUTER JOIN ooag_t d6 ON d6.ooagent = pmdsent AND d6.ooag001 = pmds002 ",                                  #s983961--add ooag_t  d6
                   #"                                LEFT OUTER JOIN ooefl_t d7 ON d7.ooeflent = pmdsent AND d7.ooefl001 = pmds003 AND d7.ooefl002 ='",g_dlang,"' ",#s983961--add ooefl_t d7  
                   #"                                LEFT OUTER JOIN imaal_t d8 ON d8.imaalent = pmdsent AND d8.imaal001 = pmdt006 AND d8.imaal002 = '",g_dlang,"' ",                 
                   #"                                LEFT OUTER JOIN inayl_t d9 ON d9.inaylent = pmdsent AND d9.inayl001 = pmdt016 AND d9.inayl002 = '",g_dlang,"' ",               
                   ##151106-00004#10 s983961--add(e)
                   #160413-00011#7--mark---end---
                   "                             ) w ON pmda_t.pmdaent = w.pmdsent AND v.pmdldocno = w.pmdt001 AND w.pmdt002 = v.pmdoseq AND w.pmdt003 = v.pmdoseq1 AND w.pmdt004 = v.pmdoseq2 AND w.pmds000 IN('1','8') ",
                   "             LEFT OUTER JOIN (SELECT pmds_t.pmdsent,pmds_t.pmdsdocno,pmds_t.pmds000,pmds_t.pmds006,pmds_t.pmdsdocdt,pmds_t.pmds002,pmds_t.pmds003,pmds_t.pmdsstus,pmds_t.pmds100,pmdt_t.pmdtseq,pmdt_t.pmdt001,pmdt_t.pmdt002,pmdt_t.pmdt003,pmdt_t.pmdt004,pmdt_t.pmdt019,pmdt_t.pmdt020,pmdt_t.pmdt028, ",
                   #"                                     d10.gzcbl004 d10_gzcbl004,d13.ooag011 d13_ooag011,d14.ooefl003 d14_ooefl003  ",  #160413-00011#7 mark
                   #160413-00011#7--add---begin---
                   "                                (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '13' AND gzcbl002 = pmdsstus AND gzcbl003 =  '",g_dlang,"') d10_gzcbl004, ",
                   "                                (SELECT ooag011 FROM ooag_t WHERE ooagent = pmdsent AND ooag001 = pmds002) d13_ooag011, ",
                   "                                (SELECT ooefl003 FROM ooefl_t WHERE ooeflent = pmdsent AND ooefl001 = pmds003 AND ooefl002 = '",g_dlang,"' ) d14_ooefl003 ",
                   #160413-00011#7--add---end---
                   "                                FROM pmds_t ",
                   "                                LEFT OUTER JOIN pmdt_t ON pmdt_t.pmdtent = pmds_t.pmdsent AND pmdt_t.pmdtdocno = pmds_t.pmdsdocno ",
                   #160413-00011#7--mark---begin---
                   #"                                LEFT OUTER JOIN gzcbl_t d10 ON d10.gzcbl001 = '13' AND d10.gzcbl002 = pmdsstus AND d10.gzcbl003 = '",g_dlang,"' ",  #s983961--add gzcbl_t d10
                   #"                                LEFT OUTER JOIN ooag_t d13 ON d13.ooagent = pmdsent AND d13.ooag001 = pmds002 ",                                    #s983961--add ooag_t  d13
                   #"                                LEFT OUTER JOIN ooefl_t d14 ON d14.ooeflent = pmdsent AND d14.ooefl001 = pmds003 AND d14.ooefl002 ='",g_dlang,"' ", #s983961--add ooefl_t d14   
                   #160413-00011#7--mark---end---
                   "                             ) x ON pmda_t.pmdaent = x.pmdsent AND v.pmdldocno = x.pmdt001 AND x.pmdt002 = v.pmdoseq AND x.pmdt003 = v.pmdoseq1 AND x.pmdt004 = v.pmdoseq2 AND x.pmds000 IN('5','10') ",
                   "             LEFT OUTER JOIN (SELECT pmds_t.pmdsent,pmds_t.pmdsdocno,pmds_t.pmds000,pmds_t.pmds006,pmds_t.pmdsdocdt,pmds_t.pmds002,pmds_t.pmds003,pmds_t.pmdsstus,pmdt_t.pmdtseq,pmdt_t.pmdt001,pmdt_t.pmdt002,pmdt_t.pmdt003,pmdt_t.pmdt004,pmdt_t.pmdt006,pmdt_t.pmdt007,pmdt_t.pmdt016,pmdt_t.pmdt017,pmdt_t.pmdt018,pmdt_t.pmdt019,pmdt_t.pmdt020, ",
                   #"                                     d11.gzcbl004 d11_gzcbl004,d15.ooag011 d15_ooag011,d16.ooefl003 d16_ooefl003,d17.imaal003 d17_imaal003,d17.imaal004 d17_imaal004,d18.inayl003 d18_inayl003,pmdt_t.pmdt028 ", #160310-00041#1-add-'pmdt_t.pmdt028'  #160413-00011#7 mark
                   #160413-00011#7--add---begin---
                   "                                     (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '13' AND gzcbl002 = pmdsstus AND gzcbl003 =  '",g_dlang,"') d11_gzcbl004,  ",
                   "                                     (SELECT ooag011 FROM ooag_t WHERE ooagent = pmdsent AND ooag001 = pmds002) d15_ooag011,      ",
                   "                                     (SELECT ooefl003 FROM ooefl_t WHERE ooeflent = pmdsent AND ooefl001 = pmds003 AND ooefl002 = '",g_dlang,"') d16_ooefl003, ",
                   "                                     (SELECT imaal003 FROM imaal_t WHERE imaalent = pmdsent AND imaal001 = pmdt006 AND imaal002 =  '",g_dlang,"') d17_imaal003,",
                   "                                     (SELECT imaal004 FROM imaal_t WHERE imaalent = pmdsent AND imaal001 = pmdt006 AND imaal002 =  '",g_dlang,"') d17_imaal004,",
                   "                                     (SELECT inayl003 FROM inayl_t WHERE inaylent = pmdsent AND inayl001 = pmdt016 AND inayl002 =  '",g_dlang,"') d18_inayl003,",
                   "                                     (SELECT inaml004 FROM inaml_t WHERE inamlent = pmdsent AND inaml001 = pmdt006 AND inaml002 = pmdt007 AND inaml003 = '",g_dlang,"' ) d18_inaml004, ",
                   "                                     pmdt_t.pmdt028 ",
                   #160413-00011#7--add---end---
                   "                                FROM pmds_t ",
                   "                                LEFT OUTER JOIN pmdt_t ON pmdt_t.pmdtent = pmds_t.pmdsent AND pmdt_t.pmdtdocno = pmds_t.pmdsdocno ",
                   #160413-00011#7--mark---begin---
                   #"                                LEFT OUTER JOIN gzcbl_t d11 ON d11.gzcbl001 = '13' AND d11.gzcbl002 = pmdsstus AND d11.gzcbl003 = '",g_dlang,"' ",  #s983961--add gzcbl_t d11
                   #"                                LEFT OUTER JOIN ooag_t d15 ON d15.ooagent = pmdsent AND d15.ooag001 = pmds002 ",                                    #s983961--add ooag_t  d15
                   #"                                LEFT OUTER JOIN ooefl_t d16 ON d16.ooeflent = pmdsent AND d16.ooefl001 = pmds003 AND d16.ooefl002 ='",g_dlang,"' ", #s983961--add ooefl_t d16     
                   #"                                LEFT OUTER JOIN imaal_t d17 ON d17.imaalent = pmdsent AND d17.imaal001 = pmdt006 AND d17.imaal002 = '",g_dlang,"' ",#s983961--add imaal_t d17
                   #"                                LEFT OUTER JOIN inayl_t d18 ON d18.inaylent = pmdsent AND d18.inayl001 = pmdt016 AND d18.inayl002 = '",g_dlang,"' ",#s983961--add inayl_t d18
                   #160413-00011#7--mark---end---
                   #160310-00041#1-mod-(S)
#                   "                             ) y ON pmda_t.pmdaent = y.pmdsent AND v.pmdldocno = y.pmdt001 AND y.pmdt002 = v.pmdoseq AND y.pmdt003 = v.pmdoseq1 AND y.pmdt004 = v.pmdoseq2  AND y.pmds000 IN('3','6','12') ",
                   "                              ) y ON (pmda_t.pmdaent = y.pmdsent AND  y.pmds006 =w.pmdsdocno AND y.pmdt028=w.pmdtseq AND w.pmdt001 = y.pmdt001 AND w.pmdt002=y.pmdt002  AND w.pmdt003=y.pmdt003 AND y.pmds000 IN('6','12') ) ",  
                   "                                      OR (v.pmdoent = y.pmdsent AND v.pmdodocno = y.pmdt001 AND y.pmdt002 = v.pmdoseq AND y.pmdt003 = v.pmdoseq1 AND y.pmdt003 = v.pmdoseq2 AND y.pmds000 IN('3')) ",
                   #160310-00041#1-mod-(E)
                   "             LEFT OUTER JOIN (SELECT pmds_t.pmdsent,pmds_t.pmdsdocno,pmds_t.pmds000,pmds_t.pmds006,pmds_t.pmdsdocdt,pmds_t.pmds002,pmds_t.pmds003,pmds_t.pmdsstus,pmds_t.pmds100,pmdt_t.pmdtseq,pmdt_t.pmdt001,pmdt_t.pmdt002,pmdt_t.pmdt003,pmdt_t.pmdt004,pmdt_t.pmdt019,pmdt_t.pmdt020,pmdt_t.pmdt028, ",
                   #"                                     d20.gzcbl004 d20_gzcbl004,d21.gzcbl004 d21_gzcbl004,d22.ooag011 d22_ooag011,d23.ooefl003 d23_ooefl003 ",   #160413-00011#7 mark
                   #160413-00011#7--add---begin---
                   "                                     (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '13' AND gzcbl002 = pmdsstus AND gzcbl003 =  '",g_dlang,"') d20_gzcbl004, ",
                   "                                     (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '2062' AND gzcbl002 = pmds100 AND gzcbl003 =  '",g_dlang,"') d21_gzcbl004,",
                   "                                     (SELECT ooag011 FROM ooag_t WHERE ooagent = pmdsent AND ooag001 = pmds002 ) d22_ooag011,        ",
                   "                                     (SELECT ooefl003 FROM ooefl_t WHERE ooeflent = pmdsent AND ooefl001 = pmds003 AND ooefl002 = '",g_dlang,"') d23_ooefl003 ",
                   #160413-00011#7--add---end---
                   "                                FROM pmds_t ",
                   "                                LEFT OUTER JOIN pmdt_t ON pmdt_t.pmdtent = pmds_t.pmdsent AND pmdt_t.pmdtdocno = pmds_t.pmdsdocno ",
                   #160413-00011#7--mark---begin---
                   #"                                LEFT OUTER JOIN gzcbl_t d20 ON d20.gzcbl001 = '13' AND d20.gzcbl002 = pmdsstus AND d20.gzcbl003 = '",g_dlang,"' ",  #s983961--add gzcbl_t d20
                   #"                                LEFT OUTER JOIN gzcbl_t d21 ON d21.gzcbl001 = '2062' AND d21.gzcbl002 = pmds100 AND d21.gzcbl003 = '",g_dlang,"' ", #s983961--add gzcbl_t d21
                   #"                                LEFT OUTER JOIN ooag_t d22 ON d22.ooagent = pmdsent AND d22.ooag001 = pmds002 ",                                    #s983961--add ooag_t  d22
                   #"                                LEFT OUTER JOIN ooefl_t d23 ON d23.ooeflent = pmdsent AND d23.ooefl001 = pmds003 AND d23.ooefl002 ='",g_dlang,"' ", #s983961--add ooefl_t d23     
                   #160413-00011#7--mark---end---
                   "                             ) z ON pmda_t.pmdaent = z.pmdsent AND v.pmdldocno = z.pmdt001 AND z.pmdt002 = v.pmdoseq AND z.pmdt003 = v.pmdoseq1 AND z.pmdt004 = v.pmdoseq2 AND z.pmds000 IN('7','14') ",
                   "                                 AND ((z.pmds006 = y.pmds006  AND z.pmdt028 =  y.pmdt028 AND y.pmds000 IN ('6','12')) OR (z.pmds006 = y.pmdsdocno AND z.pmdt028=y.pmdtseq AND y.pmds000 = '3')) "#, #160310-00041#1-add
                   #160413-00011#7--mark---begin---
                   #"             LEFT OUTER JOIN inab_t d12 ON d12.inabent  = w.pmdsent AND d12.inabsite = v.pmdlsite AND d12.inab001  = w.pmdt016 AND d12.inab002  = w.pmdt017 ",  
                   #"             LEFT OUTER JOIN inab_t d19 ON d19.inabent  = y.pmdsent AND d19.inabsite = v.pmdlsite AND d19.inab001  = y.pmdt016 AND d19.inab002  = y.pmdt017 " 
                   #160413-00011#7--mark---end---                   
  END IF
#   #end add-point
#    LET g_from = " FROM pmda_t,pmdb_t,pmdl_t,pmdo_t,pmds_t,pmdt_t,imaa_t,imaf_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET g_where = " WHERE " ,tm.wc CLIPPED ," AND ",tm.wc2 CLIPPED
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
 
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("pmda_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   IF tm.wc = ' 1=1 ' THEN      
          LET g_sql = g_sql CLIPPED, " ORDER BY v.pmdadocno,v.pmdbseq,pmdldocno,u.pmdoseq,u.pmdoseq1,u.pmdoseq2"
   ELSE      
          LET g_sql = g_sql CLIPPED, " ORDER BY pmdadocno,u.pmdbseq,v.pmdldocno,v.pmdoseq,v.pmdoseq1,v.pmdoseq2"
   END IF
   
   DISPLAY "Gsql:",g_sql
   #end add-point
   PREPARE apmr060_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE apmr060_x01_curs CURSOR FOR apmr060_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="apmr060_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION apmr060_x01_ins_data()
DEFINE sr RECORD 
   pmdasite LIKE pmda_t.pmdasite, 
   pmdadocno LIKE pmda_t.pmdadocno, 
   pmdadocdt LIKE pmda_t.pmdadocdt, 
   pmda002 LIKE pmda_t.pmda002, 
   l_pmda002_ooag011 LIKE type_t.chr300, 
   pmda003 LIKE pmda_t.pmda003, 
   l_pmda003_ooefl003 LIKE type_t.chr1000, 
   pmdastus LIKE pmda_t.pmdastus, 
   l_pmdastus_desc LIKE gzcbl_t.gzcbl004, 
   pmdbseq LIKE pmdb_t.pmdbseq, 
   pmdb004 LIKE pmdb_t.pmdb004, 
   l_pmdb004_desc LIKE imaal_t.imaal003, 
   l_pmdb004_desc1 LIKE imaal_t.imaal004, 
   imaa_t_imaa009 LIKE imaa_t.imaa009, 
   l_imaa009_desc LIKE rtaxl_t.rtaxl003, 
   imaf_t_imaf141 LIKE imaf_t.imaf141, 
   l_imaf141_desc LIKE oocql_t.oocql004, 
   imaa_t_imaa127 LIKE imaa_t.imaa127, 
   l_imaa127_desc LIKE oocql_t.oocql004, 
   pmdb033 LIKE pmdb_t.pmdb033, 
   l_pmdb033_desc LIKE gzcbl_t.gzcbl004, 
   pmdb030 LIKE pmdb_t.pmdb030, 
   pmdb007 LIKE pmdb_t.pmdb007, 
   pmdb006 LIKE pmdb_t.pmdb006, 
   pmdb049 LIKE pmdb_t.pmdb049, 
   pmdl_t_pmdldocno LIKE pmdl_t.pmdldocno, 
   pmdl_t_pmdldocdt LIKE pmdl_t.pmdldocdt, 
   pmdl_t_pmdl005 LIKE pmdl_t.pmdl005, 
   l_pmdl005_desc LIKE gzcbl_t.gzcbl004, 
   pmdl_t_pmdl002 LIKE pmdl_t.pmdl002, 
   l_pmdl002_ooag011 LIKE type_t.chr300, 
   pmdl_t_pmdl003 LIKE pmdl_t.pmdl003, 
   l_pmdl003_ooefl003 LIKE type_t.chr1000, 
   pmdl_t_pmdl004 LIKE pmdl_t.pmdl004, 
   l_pmdl004_pmaal004 LIKE type_t.chr100, 
   pmdl_t_pmdlstus LIKE pmdl_t.pmdlstus, 
   l_pmdlstus_desc LIKE gzcbl_t.gzcbl004, 
   pmdo_t_pmdoseq LIKE pmdo_t.pmdoseq, 
   pmdo_t_pmdoseq1 LIKE pmdo_t.pmdoseq1, 
   pmdo_t_pmdoseq2 LIKE pmdo_t.pmdoseq2, 
   pmdo_t_pmdo003 LIKE pmdo_t.pmdo003, 
   l_pmdo003_desc LIKE gzcbl_t.gzcbl004, 
   pmdo_t_pmdo001 LIKE pmdo_t.pmdo001, 
   l_pmdo001_desc LIKE imaal_t.imaal004, 
   l_pmdo001_desc1 LIKE imaal_t.imaal004, 
   pmdo_t_pmdo012 LIKE pmdo_t.pmdo012, 
   l_pmdn052 LIKE pmdn_t.pmdn052, 
   l_pmdo006_pmdo019 LIKE type_t.num20_6, 
   pmds_t_pmdsdocno LIKE pmds_t.pmdsdocno, 
   pmds_t_pmdsdocdt LIKE pmds_t.pmdsdocdt, 
   pmds_t_pmds002 LIKE pmds_t.pmds002, 
   l_pmds002_ooag011 LIKE type_t.chr300, 
   pmds_t_pmds003 LIKE pmds_t.pmds003, 
   l_pmds003_ooefl003 LIKE type_t.chr1000, 
   pmds_t_pmdsstus LIKE pmds_t.pmdsstus, 
   l_pmdsstus_desc LIKE gzcbl_t.gzcbl004, 
   pmdt_t_pmdtseq LIKE pmdt_t.pmdtseq, 
   pmdt_t_pmdt006 LIKE pmdt_t.pmdt006, 
   l_pmdt006_desc LIKE imaal_t.imaal003, 
   l_pmdt006_desc1 LIKE imaal_t.imaal004, 
   pmdt_t_pmdt007 LIKE pmdt_t.pmdt007, 
   l_pmdt007_desc LIKE type_t.chr1000, 
   pmdt_t_pmdt016 LIKE pmdt_t.pmdt016, 
   l_pmdt016_desc LIKE inayl_t.inayl003, 
   pmdt_t_pmdt017 LIKE pmdt_t.pmdt017, 
   l_pmdt017_desc LIKE inab_t.inab003, 
   pmdt_t_pmdt018 LIKE pmdt_t.pmdt018, 
   pmdt_t_pmdt019 LIKE pmdt_t.pmdt019, 
   pmdt_t_pmdt020 LIKE pmdt_t.pmdt020, 
   l_pmdsdocno1 LIKE pmds_t.pmdsdocno, 
   l_pmdsdocdt1 LIKE pmds_t.pmdsdocdt, 
   l_pmds0021_ooag011 LIKE type_t.chr300, 
   l_pmds0031_ooefl003 LIKE type_t.chr1000, 
   l_pmdsstus1 LIKE pmds_t.pmdsstus, 
   l_pmdsstus1_desc LIKE gzcbl_t.gzcbl004, 
   l_pmdtseq1 LIKE pmdt_t.pmdtseq, 
   l_pmdt0191 LIKE pmdt_t.pmdt019, 
   l_pmdt0201 LIKE pmdt_t.pmdt020, 
   l_pmdsdocno2 LIKE pmds_t.pmdsdocno, 
   l_pmdsdocdt2 LIKE pmds_t.pmdsdocdt, 
   l_pmds0022_ooag011 LIKE type_t.chr300, 
   l_pmds0032_ooefl003 LIKE type_t.chr1000, 
   l_pmdsstus2 LIKE pmds_t.pmdsstus, 
   l_pmdsstus2_desc LIKE gzcbl_t.gzcbl004, 
   l_pmdtseq2 LIKE pmdt_t.pmdtseq, 
   l_pmdt0062 LIKE pmdt_t.pmdt006, 
   l_pmdt0062_desc LIKE imaal_t.imaal003, 
   l_pmdt0062_desc1 LIKE imaal_t.imaal004, 
   l_pmdt0072 LIKE pmdt_t.pmdt007, 
   l_pmdt0072_desc LIKE type_t.chr1000, 
   l_pmdt0162 LIKE pmdt_t.pmdt016, 
   l_pmdt0162_desc LIKE inayl_t.inayl003, 
   l_pmdt0172 LIKE pmdt_t.pmdt017, 
   l_pmdt0172_desc LIKE inab_t.inab003, 
   l_pmdt0182 LIKE pmdt_t.pmdt018, 
   l_pmdt0192 LIKE pmdt_t.pmdt019, 
   l_pmdt0202 LIKE pmdt_t.pmdt020, 
   l_pmdsdocno3 LIKE pmds_t.pmdsdocno, 
   l_pmdsdocdt3 LIKE pmds_t.pmdsdocdt, 
   l_pmds0023_ooag011 LIKE type_t.chr300, 
   l_pmds0033_ooefl003 LIKE type_t.chr1000, 
   l_pmdsstus3 LIKE pmds_t.pmdsstus, 
   l_pmdsstus3_desc LIKE gzcbl_t.gzcbl004, 
   l_pmds1003 LIKE pmds_t.pmds100, 
   l_pmds1003_desc LIKE gzcbl_t.gzcbl004, 
   l_pmdtseq3 LIKE pmdt_t.pmdtseq, 
   l_pmdt0193 LIKE pmdt_t.pmdt019, 
   l_pmdt0203 LIKE pmdt_t.pmdt020, 
   pmdl_t_pmdl028 LIKE pmdl_t.pmdl028
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_success  LIKE type_t.num5
DEFINE l_ooag011  LIKE ooag_t.ooag011
DEFINE l_ooefl003 LIKE ooefl_t.ooefl003
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH apmr060_x01_curs INTO sr.*                               
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
       #161207-00033#24-S
       IF NOT cl_null(sr.pmdl_t_pmdl028) THEN
          CALL s_desc_get_oneturn_guest_desc(sr.pmdl_t_pmdl028) RETURNING sr.l_pmdl004_pmaal004 
       END IF
       #161207-00033#24-E
       
       #151106-00004#10 20151112 s983961 mark(s)效能調整
       #IF tm.wc = ' 1=1 ' AND NOT cl_null(sr.pmdadocno) THEN
          #請購單
          #CALL s_desc_get_person_desc(sr.pmda002) RETURNING sr.l_pmda002_ooag011
          #CALL apmr060_x01_assemble(sr.pmda002,sr.l_pmda002_ooag011) RETURNING sr.l_pmda002_ooag011
          #CALL s_desc_get_department_desc(sr.pmda003) RETURNING sr.l_pmda003_ooefl003 
          #CALL apmr060_x01_assemble(sr.pmda003,sr.l_pmda003_ooefl003 ) RETURNING sr.l_pmda003_ooefl003 
          #CALL s_desc_get_item_desc(sr.pmdb004) RETURNING sr.l_pmdb004_desc,sr.l_pmdb004_desc1
          #CALL s_desc_gzcbl004_desc('2036',sr.pmdb033) RETURNING sr.l_pmdb033_desc
          ##產品分類、系列號
          #SELECT imaa009,imaa127 INTO sr.imaa_t_imaa009,sr.imaa_t_imaa127
          #  FROM imaa_t
          # WHERE imaaent = g_enterprise
          #   AND imaa001 = sr.pmdb004
             
          #SELECT imaf141 INTO sr.imaf_t_imaf141
          #  FROM imaf_t
          # WHERE imafent = g_enterprise
          #   AND imafsite = sr.pmdl_t_pmdlsite
          #   AND imaf001 = sr.pmdb004           
       #END IF
       #151106-00004#10 20151112 s983961 mark(e)效能調整
       #CALL s_desc_gzcbl004_desc('13',sr.pmdastus) RETURNING sr.l_pmdastus_desc
       #採購單
       #SELECT pmdn052 INTO sr.l_pmdn052
       #  FROM pmdn_t
       # WHERE pmdnent = g_enterprise
       #   AND pmdndocno = sr.pmdl_t_pmdldocno
       #   AND pmdnseq = sr.pmdo_t_pmdoseq       
       #CALL s_desc_gzcbl004_desc('13',sr.pmdl_t_pmdlstus) RETURNING sr.l_pmdlstus_desc
       #CALL s_desc_gzcbl004_desc('2052',sr.pmdl_t_pmdl005) RETURNING sr.l_pmdl005_desc       
       #CALL s_desc_get_person_desc(sr.pmdl_t_pmdl002) RETURNING sr.l_pmdl002_ooag011
       #CALL apmr060_x01_assemble(sr.pmdl_t_pmdl002,sr.l_pmdl002_ooag011) RETURNING sr.l_pmdl002_ooag011
       #CALL s_desc_get_department_desc(sr.pmdl_t_pmdl003) RETURNING sr.l_pmdl003_ooefl003
       #CALL apmr060_x01_assemble(sr.pmdl_t_pmdl003,sr.l_pmdl003_ooefl003) RETURNING sr.l_pmdl003_ooefl003
       #CALL s_desc_get_trading_partner_abbr_desc(sr.pmdl_t_pmdl004) RETURNING sr.l_pmdl004_pmaal004
       #CALL apmr060_x01_assemble(sr.pmdl_t_pmdl004,sr.l_pmdl004_pmaal004) RETURNING sr.l_pmdl004_pmaal004
       #CALL s_desc_get_trading_partner_abbr_desc(sr.pmdl_t_pmdl021) RETURNING sr.l_pmdl021_pmaal004
       #CALL apmr060_x01_assemble(sr.pmdl_t_pmdl021,sr.l_pmdl021_pmaal004) RETURNING sr.l_pmdl021_pmaal004
       #CALL s_desc_get_trading_partner_abbr_desc(sr.pmdl_t_pmdl022) RETURNING sr.l_pmdl022_pmaal004
       #CALL apmr060_x01_assemble(sr.pmdl_t_pmdl022,sr.l_pmdl022_pmaal004) RETURNING sr.l_pmdl022_pmaal004
       #CALL s_desc_get_acc_desc('275',sr.pmdl_t_pmdl023) RETURNING sr.l_pmdl023_oocql004
       #CALL apmr060_x01_assemble(sr.pmdl_t_pmdl023,sr.l_pmdl023_oocql004) RETURNING sr.l_pmdl023_oocql004
       #CALL s_desc_get_rtaxl003_desc(sr.imaa_t_imaa009) RETURNING sr.l_imaa009_desc
       #CALL s_desc_get_acc_desc('203',sr.imaf_t_imaf141) RETURNING sr.l_imaf141_desc
       #CALL s_desc_get_acc_desc('2003',sr.imaa_t_imaa127) RETURNING sr.l_imaa127_desc
       #CALL s_desc_gzcbl004_desc('2055',sr.pmdo_t_pmdo003) RETURNING sr.l_pmdo003_desc
       #CALL s_desc_get_item_desc(sr.pmdo_t_pmdo001) RETURNING sr.l_pmdo001_desc,sr.l_pmdo001_desc1       
       #收貨單
       #CALL s_desc_gzcbl004_desc('13',sr.pmds_t_pmdsstus) RETURNING sr.l_pmdsstus_desc
       #CALL s_desc_get_person_desc(sr.pmds_t_pmds002) RETURNING sr.l_pmds002_ooag011
       #CALL apmr060_x01_assemble(sr.pmds_t_pmds002,sr.l_pmds002_ooag011) RETURNING sr.l_pmds002_ooag011
       #CALL s_desc_get_department_desc(sr.pmds_t_pmds003) RETURNING sr.l_pmds003_ooefl003
       #CALL apmr060_x01_assemble(sr.pmds_t_pmds003,sr.l_pmds003_ooefl003) RETURNING sr.l_pmds003_ooefl003
       #CALL s_desc_get_item_desc(sr.pmdt_t_pmdt006) RETURNING sr.l_pmdt006_desc,sr.l_pmdt006_desc1
       #160413-00011#7--mark---begin--
       #CALL s_feature_description(sr.pmdt_t_pmdt006,sr.pmdt_t_pmdt007) RETURNING l_success,sr.l_pmdt007_desc
       #IF NOT l_success THEN
       #   LET sr.l_pmdt007_desc = '' 
       #END IF
       #160413-00011#7--mark--end
       #CALL s_desc_get_stock_desc(sr.pmdl_t_pmdlsite,sr.pmdt_t_pmdt016) RETURNING sr.l_pmdt016_desc
       #CALL s_desc_get_locator_desc(sr.pmdl_t_pmdlsite,sr.pmdt_t_pmdt016,sr.pmdt_t_pmdt017) RETURNING sr.l_pmdt017_desc
       #驗退單
       #CALL s_desc_gzcbl004_desc('13',sr.l_pmdsstus1) RETURNING sr.l_pmdsstus1_desc
       # CALL s_desc_get_person_desc(sr.l_pmds0021_ooag011) RETURNING l_ooag011
       # CALL apmr060_x01_assemble(sr.l_pmds0021_ooag011,l_ooag011) RETURNING sr.l_pmds0021_ooag011
       #CALL s_desc_get_department_desc(sr.l_pmds0031_ooefl003) RETURNING l_ooefl003
       #CALL apmr060_x01_assemble(sr.l_pmds0031_ooefl003,l_ooefl003) RETURNING sr.l_pmds0031_ooefl003
       #INITIALIZE l_ooag011 TO NULL
       #INITIALIZE l_ooefl003 TO NULL
       #入庫單
       #CALL s_desc_gzcbl004_desc('13',sr.l_pmdsstus2) RETURNING sr.l_pmdsstus2_desc
       #CALL s_desc_get_person_desc(sr.l_pmds0022_ooag011) RETURNING l_ooag011
       #CALL apmr060_x01_assemble(sr.l_pmds0022_ooag011,l_ooag011) RETURNING sr.l_pmds0022_ooag011
       #CALL s_desc_get_department_desc(sr.l_pmds0032_ooefl003) RETURNING l_ooefl003
       #CALL apmr060_x01_assemble(sr.l_pmds0032_ooefl003,l_ooefl003) RETURNING sr.l_pmds0032_ooefl003
       #INITIALIZE l_ooag011 TO NULL
       #INITIALIZE l_ooefl003 TO NULL
       #CALL s_desc_get_item_desc(sr.l_pmdt0062) RETURNING sr.l_pmdt0062_desc,sr.l_pmdt0062_desc1
       #160413-00011#7--mark---begin---
       #CALL s_feature_description(sr.l_pmdt0062,sr.l_pmdt0072) RETURNING l_success,sr.l_pmdt0072_desc
       #IF NOT l_success THEN
       #   LET sr.l_pmdt0072_desc = '' 
       #END IF
       #160413-00011#7--mark---end----
       #CALL s_desc_get_stock_desc(sr.pmdl_t_pmdlsite,sr.l_pmdt0162) RETURNING sr.l_pmdt0162_desc
       #CALL s_desc_get_locator_desc(sr.pmdl_t_pmdlsite,sr.l_pmdt0162,sr.l_pmdt0172) RETURNING sr.l_pmdt0172_desc
       #倉退單
       #CALL s_desc_gzcbl004_desc('13',sr.l_pmdsstus3) RETURNING sr.l_pmdsstus3_desc
       #CALL s_desc_gzcbl004_desc('2062',sr.l_pmds1003) RETURNING sr.l_pmds1003_desc
       #CALL s_desc_get_person_desc(sr.l_pmds0023_ooag011) RETURNING l_ooag011
       #CALL apmr060_x01_assemble(sr.l_pmds0023_ooag011,l_ooag011) RETURNING sr.l_pmds0023_ooag011
       #CALL s_desc_get_department_desc(sr.l_pmds0033_ooefl003) RETURNING l_ooefl003
       #CALL apmr060_x01_assemble(sr.l_pmds0033_ooefl003,l_ooefl003) RETURNING sr.l_pmds0033_ooefl003
       #INITIALIZE l_ooag011 TO NULL
       #INITIALIZE l_ooefl003 TO NULL
       
       #151021-00004 by whitney add start
       #請購未轉採購量=請購量-已轉採購量
       LET sr.pmdb049 = sr.pmdb006 - sr.pmdb049
       #未交數=採購量-已入庫數量
       #LET sr.l_pmdo006_pmdo019 = sr.pmdo_t_pmdo006 - sr.pmdo_t_pmdo019 #160413-00011#7
       #151021-00004 by whitney add end
       
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.pmdadocno,sr.pmdadocdt,sr.l_pmda002_ooag011,sr.l_pmda003_ooefl003,sr.l_pmdastus_desc,sr.pmdbseq,sr.pmdb004,sr.l_pmdb004_desc,sr.l_pmdb004_desc1,sr.imaa_t_imaa009,sr.l_imaa009_desc,sr.imaf_t_imaf141,sr.l_imaf141_desc,sr.imaa_t_imaa127,sr.l_imaa127_desc,sr.l_pmdb033_desc,sr.pmdb030,sr.pmdb007,sr.pmdb006,sr.pmdb049,sr.pmdl_t_pmdldocno,sr.pmdl_t_pmdldocdt,sr.l_pmdl005_desc,sr.l_pmdl002_ooag011,sr.l_pmdl003_ooefl003,sr.l_pmdl004_pmaal004,sr.l_pmdlstus_desc,sr.pmdo_t_pmdoseq,sr.pmdo_t_pmdoseq1,sr.pmdo_t_pmdoseq2,sr.l_pmdo003_desc,sr.pmdo_t_pmdo001,sr.l_pmdo001_desc,sr.l_pmdo001_desc1,sr.pmdo_t_pmdo012,sr.l_pmdn052,sr.l_pmdo006_pmdo019,sr.pmds_t_pmdsdocno,sr.pmds_t_pmdsdocdt,sr.l_pmds002_ooag011,sr.l_pmds003_ooefl003,sr.l_pmdsstus_desc,sr.pmdt_t_pmdtseq,sr.pmdt_t_pmdt006,sr.l_pmdt006_desc,sr.l_pmdt006_desc1,sr.pmdt_t_pmdt007,sr.l_pmdt007_desc,sr.pmdt_t_pmdt016,sr.l_pmdt016_desc,sr.pmdt_t_pmdt017,sr.l_pmdt017_desc,sr.pmdt_t_pmdt018,sr.pmdt_t_pmdt019,sr.pmdt_t_pmdt020,sr.l_pmdsdocno1,sr.l_pmdsdocdt1,sr.l_pmds0021_ooag011,sr.l_pmds0031_ooefl003,sr.l_pmdsstus1_desc,sr.l_pmdtseq1,sr.l_pmdt0191,sr.l_pmdt0201,sr.l_pmdsdocno2,sr.l_pmdsdocdt2,sr.l_pmds0022_ooag011,sr.l_pmds0032_ooefl003,sr.l_pmdsstus2_desc,sr.l_pmdtseq2,sr.l_pmdt0062,sr.l_pmdt0062_desc,sr.l_pmdt0062_desc1,sr.l_pmdt0072,sr.l_pmdt0072_desc,sr.l_pmdt0162,sr.l_pmdt0162_desc,sr.l_pmdt0172,sr.l_pmdt0172_desc,sr.l_pmdt0182,sr.l_pmdt0192,sr.l_pmdt0202,sr.l_pmdsdocno3,sr.l_pmdsdocdt3,sr.l_pmds0023_ooag011,sr.l_pmds0033_ooefl003,sr.l_pmdsstus3_desc,sr.l_pmds1003,sr.l_pmds1003_desc,sr.l_pmdtseq3,sr.l_pmdt0193,sr.l_pmdt0203,sr.pmdl_t_pmdl028
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "apmr060_x01_execute"
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
 
{<section id="apmr060_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION apmr060_x01_rep_data()
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
 
{<section id="apmr060_x01.other_function" readonly="Y" >}

PRIVATE FUNCTION apmr060_x01_assemble(p_str1,p_str2)
   DEFINE p_str1  STRING
   DEFINE p_str2  STRING
   DEFINE r_assemble STRING
   
   IF cl_null(p_str1) AND cl_null(p_str2) THEN
      INITIALIZE r_assemble TO NULL
   ELSE
      IF cl_null(p_str1) OR cl_null(p_str2) THEN
         LET r_assemble = p_str1 ,'.', p_str2
      ELSE
         LET r_assemble = p_str1 || '.' || p_str2
      END IF
   END IF
   
   RETURN r_assemble
END FUNCTION

 
{</section>}
 
