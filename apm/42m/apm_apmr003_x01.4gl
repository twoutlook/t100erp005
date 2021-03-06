#該程式未解開Section, 採用最新樣板產出!
{<section id="apmr003_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:13(2016-12-21 12:19:58), PR版次:0013(2016-12-21 16:15:40)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000209
#+ Filename...: apmr003_x01
#+ Description: ...
#+ Creator....: 05384(2014-06-04 10:40:54)
#+ Modifier...: 01534 -SD/PR- 01534
 
{</section>}
 
{<section id="apmr003_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#160328-00011#1   2016/03/18  By  dorislai  增進效能  1.修改SQL拿掉XXX.CCC，以及有說明的欄位，拿掉其代號
#                                                    2.將子報表的SQL移去before foreach，以及將子報表部分內容移至子報表SQL中
#160411-00027#6   2016/04/13  By  dorislai  效能改善：欄位減少、說明寫成Sub-Query
#161207-00033#22  2016/12/21  By  lixh      一次性交易對象顯示說明，所有的客戶/供應商欄位都應該處理
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
       chk LIKE type_t.chr1,         #列印相關進出 
       chk1 LIKE type_t.chr1,         #已收未驗 
       chk2 LIKE type_t.chr1,         #已驗未入 
       chk3 LIKE type_t.chr1          #已驗未退
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="apmr003_x01.main" readonly="Y" >}
PUBLIC FUNCTION apmr003_x01(p_arg1,p_arg2,p_arg3,p_arg4,p_arg5)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr1         #tm.chk  列印相關進出 
DEFINE  p_arg3 LIKE type_t.chr1         #tm.chk1  已收未驗 
DEFINE  p_arg4 LIKE type_t.chr1         #tm.chk2  已驗未入 
DEFINE  p_arg5 LIKE type_t.chr1         #tm.chk3  已驗未退
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.chk = p_arg2
   LET tm.chk1 = p_arg3
   LET tm.chk2 = p_arg4
   LET tm.chk3 = p_arg5
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "apmr003_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL apmr003_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL apmr003_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL apmr003_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL apmr003_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL apmr003_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="apmr003_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION apmr003_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
 
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "pmdsdocno.pmds_t.pmdsdocno,pmdsdocdt.pmds_t.pmdsdocdt,l_pmds000_desc.type_t.chr80,l_pmds011_desc.type_t.chr80,l_pmdsstus_desc.type_t.chr80,ooag_t_ooag011.ooag_t.ooag011,ooefl_t_ooefl003.ooefl_t.ooefl003,l_pmds007_desc.pmaal_t.pmaal004,pmdtseq.pmdt_t.pmdtseq,pmdt001.pmdt_t.pmdt001,pmdt002.pmdt_t.pmdt002,pmdt003.pmdt_t.pmdt003,pmdt004.pmdt_t.pmdt004,l_pmdt005_desc.type_t.chr10,pmdt006.pmdt_t.pmdt006,x_t6_imaal003.imaal_t.imaal003,x_t6_imaal004.imaal_t.imaal004,pmdt007.pmdt_t.pmdt007,l_pmdt007_desc.type_t.chr500,l_imaa127_desc.type_t.chr50,pmdt026.pmdt_t.pmdt026,pmdt020.pmdt_t.pmdt020,pmdt019.pmdt_t.pmdt019,pmdt016.pmdt_t.pmdt016,l_pmdt016_desc.type_t.chr500,pmdt017.pmdt_t.pmdt017,l_pmdt017_desc.inab_t.inab003,pmdt018.pmdt_t.pmdt018,pmdt053.pmdt_t.pmdt053,pmdt054.pmdt_t.pmdt054,pmdt055.pmdt_t.pmdt055,l_qty_1.type_t.num20_6,l_qty_2.type_t.num20_6,l_qty_3.type_t.num20_6,pmdt059.pmdt_t.pmdt059,l_pmdt025_desc.gzcbl_t.gzcbl004,pmdt063.pmdt_t.pmdt063,l_pmdt019_desc.oocal_t.oocal003,l_pmdt083_desc.qcaol_t.qcaol004" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   LET g_sql = "l_pmdt001.pmdt_t.pmdt001, ",
               "l_pmdt002.pmdt_t.pmdt002, ",
               "l_pmds000.rtaxl_t.rtaxl003,",
               "l_pmdsdocno.pmds_t.pmdsdocno, ",
               "l_pmdsdocdt.pmds_t.pmdsdocdt, ",
               "l_pmdsstus.pmds_t.pmdsstus, ",
               #160411-00027#6-mod-(S)
#               "l_pmds002.type_t.chr100, ",
#               "l_pmds003.type_t.chr100, ",
               "l_pmds002.pmds_t.pmds002, ",
               "l_pmds002_desc.ooag_t.ooag011, ",
               "l_pmds003.pmds_t.pmds003, ",
               "l_pmds003_desc.ooefl_t.ooefl003, ",
               #160411-00027#6-mod-(E)
               "l_pmdtseq.pmdt_t.pmdtseq, ",
               "l_pmdt020.pmdt_t.pmdt020, ",
               "l_pmdt019.pmdt_t.pmdt019, ",
               "l_pmdt022.pmdt_t.pmdt022, ",
               "l_pmdt021.pmdt_t.pmdt021, ",
               "l_pmdt024.pmdt_t.pmdt024, ",
               "l_pmdt023.pmdt_t.pmdt023, ",
               #160411-00027#6-mod-(S)
#               "l_pmdt016.type_t.chr100, ",
#               "l_pmdt017.type_t.chr100, ",
               "l_pmdt016.pmdt_t.pmdt016, ",
               "l_pmdt016_ref.inayl_t.inayl003, ",
               "l_pmdt017.pmdt_t.pmdt017, ",
               "l_pmdt017_ref.inab_t.inab003, ",
               #160411-00027#6-mod-(E)
               "l_pmdt018.pmdt_t.pmdt018, ",
               "l_pmdt083.pmdt_t.pmdt083, ",
               "l_pmdt055.pmdt_t.pmdt055 "
               
   IF NOT cl_xg_create_tmptable(g_sql,2) THEN
      LET g_rep_success = 'N'
   END IF

   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="apmr003_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION apmr003_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
         #160411-00027#6-mod-(S)
#         LET g_sql = " INSERT INTO ",g_rep_db CLIPPED,g_rep_tmpname[2] CLIPPED," VALUES(?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?)"
         LET g_sql = " INSERT INTO ",g_rep_db CLIPPED,g_rep_tmpname[2] CLIPPED," VALUES(?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?,?,?,?,?)"
         #160411-00027#6-mod-(E)
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
 
{<section id="apmr003_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apmr003_x01_sel_prep()
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
   #160328-00011#1-mod-(S)
#   #151030-00002#2 20151030 s983961--mark(s) 效能調整
#   LET g_select = " SELECT pmdsdocno,pmdsdocdt,pmds000, ",
#                  "        S1.gzcbl004, ",
#                  "        pmds011, ",
#                  "        S2.gzcbl004, ",
#                  "        pmdsstus, ",
#                  "        S3.gzcbl004, ",
#                  "        trim(pmds002)||'.'||trim(ooag_t.ooag011),  trim(pmds003)||'.'||trim(ooefl_t.ooefl003), ", 
#                  "        trim(pmds007)||'.'||trim(pmaal_t.pmaal004),trim(pmds008)||'.'||trim(t2.pmaal004),      ",
#                  "        trim(pmds009)||'.'||trim(t3.pmaal004),     trim(pmds012)||'.'||trim(t4.oocql004),      ",
#                  "        trim(pmds013)||'.'||trim(t1.oocql004), ",
#                  "        pmdsent,pmdssite,x.pmdtseq, ",
#                  "        x.pmdt001,x.pmdt002,x.pmdt003,  ",
#                  "        x.pmdt004,x.pmdt005, ",
#                  "        x.S4_gzcbl004, ",
#                  "        trim(x.imaa009)||'.'||trim((SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent = x.pmdtent AND rtaxl001 = imaa009 AND rtaxl002= '",g_dlang,"')), ",
#                  "        trim(x.imaf141)||'.'||trim(x.S5_gzcbl004) l_imaf141_oocql004, ",
#                  "        x.pmdo001, ",
#                  "        x.S6_imaal003,x.S6_imaal004, ",
#                  "        x.pmdt006,x.t6_imaal003,x.t6_imaal004, ",
#                  "        x.pmdt007, ",
#                  "        x.imaa127, ",
#                  "        x.S7_oocql004, ",
#                  "        trim(x.imaa127)||'.'||trim(x.S7_oocql004), ",
#                  "        x.pmdt026,COALESCE(x.pmdt020,0),x.pmdt019, ",
#                  "        x.pmdt022,x.pmdt021,x.pmdt024, ",
#                  "        x.pmdt023,x.pmdt036,x.pmdt038, ",
#                  "        x.pmdt039,x.pmdt047,x.pmdt016, ",
#                  "        trim(x.pmdt016)||'.'||trim(x.S8_inayl003), ",
#                  "        x.pmdt017, ",
#                  "        trim(x.pmdt017)||'.'||trim(x.S9_inab003), ",
#                  "        x.pmdt018,COALESCE(x.pmdt053,0),COALESCE(x.pmdt054,0), ",
#                  "        COALESCE(x.pmdt055,0),NULL,NULL, ",
#                  "        '', ",
#                  "        x.pmdt059,x.pmdt025, ",
#                  "        x.S10_gzcbl004, ",
#                  "        pmds006,pmds007,pmds008, ",
#                  "        pmds009,pmds010,pmds012, ",
#                  "        pmds014,pmds021,pmds022, ",
#                  "        pmds023,pmds024,pmds031, ",
#                  "        pmds032,pmds033,pmds034, ",
#                  "        pmds035,pmds036,pmds037,pmds038,pmds039,pmds040,pmds041,pmds042, ",                  
#                  "        pmds045,pmds047,pmds048,pmds049,pmds050,pmds052,pmds053,x.pmdt011, ",
#                  "        x.pmdt041,x.pmdt051,x.pmdt060,x.pmdt061,x.pmdt062,x.pmdt063,x.pmdt072,x.pmdt073, ",
#                  "        x.pmdt074,x.pmdt088,x.pmdt089,pmds002,pmds003, ",
#                  "        S11.pmaal004,S12.pmaal004, ", 
#                  "        S13.pmaal004,t4.oocql004, ",
#                  "        ooibl004,S15.oocql004, ",
#                  "        oodbl004,ooail003, ",
#                  "        pmaml003,ooidl003, ",
#                  "        icaal003,'', ",
#                  "        x.S16_oocql004,x.pjbal003, ",
#                  "        x.pjbbl004,x.pjbml004, ",
#                  "        trim(pmds031)||'.'||trim(ooibl004),      ",
#                  "        trim(pmds032)||'.'||trim(S15.oocql004),  ",
#                  "        trim(pmds033)||'.'||trim(oodbl004),      ",
#                  "        trim(pmds037)||'.'||trim(ooail003),      ",
#                  "        trim(pmds039)||'.'||trim(pmaml003),      ",
#                  "        trim(pmds040)||'.'||trim(ooidl003),      ",
#                  "        trim(pmds053)||'.'||trim(icaal003),      ",
#                  "        '',                                      ",
#                  "        trim(pmds051)||'.'||trim(x.S16_oocql004),",
#                  "        trim(pmdt072)||'.'||trim(x.pjbal003),    ",
#                  "        trim(pmdt073)||'.'||trim(x.pjbbl004),    ",
#                  "        trim(pmdt074)||'.'||trim(x.pjbml004),    ",
#                  "        x.S8_inayl003,x.S9_inab003, ",
##                  "        '',ooag011, ", #dorislai-160118-mod-(S)
#                  "        ooag011, ",     #dorislai-160118-mod-(E)
#                  "        ooefl003,S17.gzcbl004, ",
#                  "        S18.gzcbl004,S19.gzcbl004, ",
##                  "        S20.gzcbl004,'', ", #dorislai-160118-mod-(S)
#                  "        S20.gzcbl004, ",     #dorislai-160118-mod-(E)
#                  "        trim(pmdsstus)||'.'||trim(S3.gzcbl004), ",
#                  "        trim(pmds011)||'.'||trim(S2.gzcbl004),  ",
#                  "        trim(pmds014)||'.'||trim(S17.gzcbl004), ",
#                  "        trim(pmds036)||'.'||trim(S18.gzcbl004), ",
#                  "        trim(pmds048)||'.'||trim(S19.gzcbl004), ",
#                  "        trim(pmds049)||'.'||trim(S20.gzcbl004), ",
#                  "        trim(x.pmdt005)||'.'||trim(x.S4_gzcbl004),  ",
#                  "        trim(x.pmdt025)||'.'||trim(x.S10_gzcbl004)  "
   #160328-00011#1-mod-(E)
   #160411-00027#6-mod-(S)
#   LET g_select = " SELECT pmdsdocno,pmdsdocdt,S1.gzcbl004,S2.gzcbl004,S3.gzcbl004,ooag_t.ooag011,ooefl_t.ooefl003, ",
#                  "        pmaal_t.pmaal004,t2.pmaal004,t3.pmaal004,t4.oocql004,t1.oocql004,pmdsent,pmdssite,x.pmdtseq, ",
#                  "        x.pmdt001,x.pmdt002,x.pmdt003,x.pmdt004,x.S4_gzcbl004,x.rtaxl003,x.S5_gzcbl004,x.pmdo001, ",
#                  "        x.S6_imaal003,x.S6_imaal004,x.pmdt006,x.t6_imaal003,x.t6_imaal004,x.pmdt007,'',x.S7_oocql004, ",
#                  "        x.pmdt026,COALESCE(x.pmdt020,0),x.pmdt019,x.pmdt022,x.pmdt021,x.pmdt024,x.pmdt023,x.pmdt036,x.pmdt038, ",
#                  "        x.pmdt039,x.pmdt047,x.pmdt016,x.S8_inayl003,x.pmdt017,x.S9_inab003,x.pmdt018,COALESCE(x.pmdt053,0),COALESCE(x.pmdt054,0), ",
#                  "        COALESCE(x.pmdt055,0),NULL,NULL,'',x.pmdt059,x.S10_gzcbl004,pmds006,pmds010,S17.gzcbl004,pmds021,pmds022, ",
#                  "        pmds023,pmds024,ooibl004,S15.oocql004,oodbl004,pmds034,pmds035,S18.gzcbl004,ooail003,pmds038,pmaml003, ",
#                  "        ooidl003,pmds041,pmds042,pmds045,pmds047,S19.gzcbl004,S20.gzcbl004,pmds050,pmds052,icaal003,x.pmdt011, ",
#                  "        x.pmdt041,x.S16_oocql004,x.pmdt060,x.pmdt061,x.pmdt062,x.pmdt063,x.pjbal003,x.pjbbl004,x.pjbml004,",
#                  "        x.pmdt088,x.pmdt089 "
   LET g_select = " SELECT pmdsdocno,pmdsdocdt,
                    (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '2060' AND gzcbl002 = pmds000 AND gzcbl003 = '",g_dlang,"') S1_gzcbl004,
                    (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '2061' AND gzcbl002 = pmds011 AND gzcbl003 = '",g_dlang,"') S2_gzcbl004,
                    (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '13'   AND gzcbl002 = pmdsstus AND gzcbl003 = '",g_dlang,"') S3_gzcbl004,
                    (SELECT ooag011 FROM ooag_t WHERE ooag001 = pmds002 AND ooagent = pmdsent ) ooag011,
                    (SELECT ooefl003 FROM ooefl_t WHERE ooefl001 = pmds003 AND ooeflent = pmdsent AND ooefl002 = '",g_dlang,"') ooefl003,
                    (SELECT pmaal004 FROM pmaal_t WHERE pmaal001 = pmds007 AND pmaalent = pmdsent AND pmaal002 = '",g_dlang,"') pmaal004,
                    pmdsent,pmdssite,x.pmdtseq,x.pmdt001,x.pmdt002,x.pmdt003,x.pmdt004,
                    (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '2055' AND gzcbl002 = x.pmdt005 AND gzcbl003 = '",g_dlang,"') S4_gzcbl004,
                    x.pmdt006,
                    (SELECT imaal003 FROM imaal_t WHERE imaal001 = x.pmdt006 AND imaalent = x.pmdtent AND imaal002 = '",g_dlang,"') imaal003,
                    (SELECT imaal004 FROM imaal_t WHERE imaal001 = x.pmdt006 AND imaalent = x.pmdtent AND imaal002 = '",g_dlang,"') imaal004,
                    x.pmdt007,
                    (SELECT inaml004 FROM inaml_t WHERE inamlent=x.pmdtent AND inaml001=x.pmdt006 AND inaml002=x.pmdt007 AND inaml003='",g_dlang,"') inaml004,
                    (SELECT oocql004 FROM oocql_t WHERE oocql001 = '2003' AND oocql002 = x.imaa127 AND oocqlent = x.pmdtent AND oocql003 = '",g_dlang,"') oocql004,
                    x.pmdt026,COALESCE(x.pmdt020,0),x.pmdt019,x.pmdt016,
                    (SELECT inayl003 FROM inayl_t WHERE inaylent = x.pmdtent AND inayl001 = x.pmdt016 AND inayl002 = '",g_dlang,"') inayl003,
                    x.pmdt017,
                    (SELECT inab003 FROM inab_t WHERE inabent = pmdtent AND inabsite = pmdtsite AND inab001 = pmdt016 AND inab002 = pmdt017) inab003,
                    x.pmdt018,COALESCE(x.pmdt053,0),COALESCE(x.pmdt054,0), 
                    COALESCE(x.pmdt055,0),NULL,NULL,'',x.pmdt059,
                    (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '2036' AND gzcbl002 = pmdt025 AND gzcbl003 = '",g_dlang,"') S5_gzcbl004,
                    x.pmdt063,
                    (SELECT oocal003 FROM oocal_t WHERE oocal001 = x.pmdt019 AND oocalent = x.pmdtent AND oocal002 = '",g_dlang,"') oocal003,
                    (SELECT qcaol004 FROM qcaol_t WHERE qcaol002 = x.pmdt083 AND qcaolent = x.pmdtent AND qcaol003 = '", g_dlang,"') qcaol004 "
   #160411-00027#6-mod-(E)
#   #end add-point
#   LET g_select = " SELECT pmdsdocno,pmdsdocdt,'','','',( SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = pmds_t.pmds002 AND ooag_t.ooagent = pmds_t.pmdsent), 
#       ( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = pmds_t.pmds003 AND ooefl_t.ooeflent = pmds_t.pmdsent AND ooefl_t.ooefl002 = '" , 
#       g_dlang,"'" ,"),'',pmdsent,pmdssite,pmdtseq,pmdt001,pmdt002,pmdt003,pmdt004,'',pmdt006,x.t6_imaal003, 
#       x.t6_imaal004,pmdt007,'','',pmdt026,pmdt020,pmdt019,pmdt016,'',pmdt017,'',pmdt018,pmdt053,pmdt054, 
#       pmdt055,NULL,NULL,'',pmdt059,'',pmdt063,NULL,NULL"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   #160411-00027#6-mod-(S)
#   LET g_from = " FROM pmds_t LEFT OUTER JOIN ooag_t ON ooag_t.ooag001 = pmds_t.pmds002 AND ooag_t.ooagent = pmds_t.pmdsent  ",
#        "             LEFT OUTER JOIN ooidl_t ON ooidl_t.ooidl001 = pmds_t.pmds040 AND ooidl_t.ooidlent = pmds_t.pmdsent AND ooidl_t.ooidl002 = '",g_dlang,"' ", 
#        "             LEFT OUTER JOIN pmaml_t ON pmaml_t.pmaml001 = pmds_t.pmds039 AND pmaml_t.pmamlent = pmds_t.pmdsent AND pmaml_t.pmaml002 = '",g_dlang,"' ",
#        "             LEFT OUTER JOIN ooail_t ON ooail_t.ooail001 = pmds_t.pmds037 AND ooail_t.ooailent = pmds_t.pmdsent AND ooail_t.ooail002 = '",g_dlang,"' ",
#        "             LEFT OUTER JOIN oocql_t ON oocql_t.oocql001 = '238' AND oocql_t.oocql002 = pmds_t.pmds032 AND oocql_t.oocqlent = pmds_t.pmdsent AND oocql_t.oocql003 = '",g_dlang,"' ",
#        "             LEFT OUTER JOIN ooibl_t ON ooibl_t.ooibl002 = pmds_t.pmds031 AND ooibl_t.ooiblent = pmds_t.pmdsent AND ooibl_t.ooibl003 = '",g_dlang,"' " ,
#        "             LEFT OUTER JOIN oocql_t t1 ON t1.oocql001 = '275' AND t1.oocql002 = pmds_t.pmds013 AND t1.oocqlent = pmds_t.pmdsent AND t1.oocql003 = '",g_dlang,"' ",
#        "             LEFT OUTER JOIN ooefl_t ON ooefl_t.ooefl001 = pmds_t.pmds003 AND ooefl_t.ooeflent = pmds_t.pmdsent AND ooefl_t.ooefl002 = '",g_dlang,"' ",
#        "             LEFT OUTER JOIN pmaal_t ON pmaal_t.pmaal001 = pmds_t.pmds007 AND pmaal_t.pmaalent = pmds_t.pmdsent AND pmaal_t.pmaal002 = '",g_dlang,"' ",
#        "             LEFT OUTER JOIN pmaal_t t2 ON t2.pmaal001 = pmds_t.pmds008 AND t2.pmaalent = pmds_t.pmdsent AND t2.pmaal002 = '",g_dlang,"' ",
#        "             LEFT OUTER JOIN pmaal_t t3 ON t3.pmaal001 = pmds_t.pmds009 AND t3.pmaalent = pmds_t.pmdsent AND t3.pmaal002 = '",g_dlang,"' ",
#        "             LEFT OUTER JOIN oocql_t t4 ON t4.oocql001 = '275' AND t4.oocql002 = pmds_t.pmds012 AND t4.oocqlent = pmds_t.pmdsent AND t4.oocql003 = '",g_dlang,"' ", 
#        "        LEFT OUTER JOIN ( SELECT pmdt_t.*,t6.imaal003 t6_imaal003,t6.imaal004 t6_imaal004,imaf141,imaa009,imaa127, ",
#        "                                 S4.gzcbl004 S4_gzcbl004,pmdo001,S5.gzcbl004 S5_gzcbl004,S6.imaal003 S6_imaal003,S6.imaal004 S6_imaal004,S7.oocql004 S7_oocql004,",
#        "                                 S8.inayl003 S8_inayl003,S9.inab003 S9_inab003,S10.gzcbl004 S10_gzcbl004,S16.oocql004 S16_oocql004,pjbal003,pjbbl004,pjbml004,rtaxl003 ",  #160328-00011#1-rtaxl003
#        "                           FROM pmdt_t ",
#        "                           LEFT OUTER JOIN oocal_t ON oocal_t.oocal001 = pmdt_t.pmdt021 AND oocal_t.oocalent = pmdt_t.pmdtent AND oocal_t.oocal002 = '",g_dlang,"' ", 
#        "                           LEFT OUTER JOIN imaa_t ON imaa_t.imaa001 = pmdt_t.pmdt006 AND imaa_t.imaaent = pmdt_t.pmdtent ",
#        "                           LEFT OUTER JOIN oocal_t t5 ON t5.oocal001 = pmdt_t.pmdt019 AND t5.oocalent = pmdt_t.pmdtent AND t5.oocal002 = '",g_dlang,"' " ,
#        "                           LEFT OUTER JOIN imaf_t ON imaf_t.imaf001 = pmdt_t.pmdt006 AND imaf_t.imafent = pmdt_t.pmdtent AND imaf_t.imafsite = '" ,g_site,"'" , 
#        "                           LEFT OUTER JOIN imaal_t ON imaal_t.imaal001 = pmdt_t.pmdt008 AND imaal_t.imaalent = pmdt_t.pmdtent AND imaal_t.imaal002 = '",g_dlang,"' ", 
#        "                           LEFT OUTER JOIN imaal_t t6 ON t6.imaal001 = pmdt_t.pmdt006 AND t6.imaalent = pmdt_t.pmdtent AND t6.imaal002 = '",g_dlang,"' ", 
#        "                           LEFT OUTER JOIN oocal_t t7 ON t7.oocal001 = pmdt_t.pmdt023 AND t7.oocalent = pmdt_t.pmdtent AND t7.oocal002 = '",g_dlang,"' ", 
#        "                           LEFT OUTER JOIN qcaol_t ON qcaol_t.qcaol002 = pmdt_t.pmdt083 AND qcaol_t.qcaolent = pmdt_t.pmdtent AND qcaol_t.qcaol003 = '", g_dlang,"' ",    
#        "                           LEFT OUTER JOIN pmdo_t ON pmdoent = pmdtent AND pmdodocno = pmdt001 AND pmdoseq = pmdt002 AND pmdoseq1 = pmdt003  AND pmdoseq2 = pmdt004 ",                                                                    
#        "                           LEFT OUTER JOIN gzcbl_t S4 ON S4.gzcbl001 = '2055' AND S4.gzcbl002 = pmdt005 AND S4.gzcbl003 = '",g_dlang,"' ",
#        "                           LEFT OUTER JOIN gzcbl_t S5 ON S5.gzcbl001 = '203'  AND S5.gzcbl002 = imaf141 AND S5.gzcbl003 = '",g_dlang,"' ",
#        "                           LEFT OUTER JOIN imaal_t S6 ON S6.imaal001 = pmdo001 AND S6.imaalent = pmdtent AND S6.imaal002 = '",g_dlang,"' ",
#        "                           LEFT OUTER JOIN oocql_t S7 ON S7.oocql001 = '2003' AND S7.oocql002 = imaa127 AND S7.oocqlent = pmdtent AND S7.oocql003 = '",g_dlang,"' ",
#        "                           LEFT OUTER JOIN inayl_t S8 ON S8.inaylent = pmdtent AND S8.inayl001 = pmdt016 AND S8.inayl002 = '",g_dlang,"' ",
#        "                           LEFT OUTER JOIN inab_t  S9 ON S9.inabent = pmdtent AND S9.inabsite = pmdtsite AND S9.inab001 = pmdt016 AND S9.inab002 = pmdt017 ",
#        "                           LEFT OUTER JOIN gzcbl_t S10 ON S10.gzcbl001 = '2036' AND S10.gzcbl002 = pmdt025 AND S10.gzcbl003 = '",g_dlang,"'  ",
#        "                           LEFT OUTER JOIN gzcb_t ON gzcb001 = '24' AND gzcb002 = '",g_prog,"' ",
#        "                           LEFT OUTER JOIN oocql_t S16 ON S16.oocql001 = gzcb004 AND S16.oocql002 = pmdt051 AND S16.oocqlent = pmdtent AND S16.oocql003 = '",g_dlang,"' ", 
#        "                           LEFT OUTER JOIN pjbal_t ON pjbalent = pmdtent AND pjbal001 = pmdt072 AND pjbal002 = '",g_dlang,"' ",
#        "                           LEFT OUTER JOIN pjbbl_t ON pjbblent = pmdtent AND pjbbl001 = pmdt072 AND pjbbl002 = pmdt073 AND pjbbl003 = '",g_dlang,"' ",
#        "                           LEFT OUTER JOIN rtaxl_t ON rtaxlent = pmdtent AND rtaxl001 = imaa009 AND rtaxl002= '",g_dlang,"' ", #160328-00011#1-add
#        "                           LEFT OUTER JOIN pjbml_t ON pjbmlent = pmdtent AND pjbml001 = pmdt072 AND pjbml002 = pmdt074 AND pjbml003 = '",g_dlang,"') x ",
#        "        ON pmds_t.pmdsent = x.pmdtent AND pmds_t.pmdsdocno = x.pmdtdocno",
#        "             LEFT OUTER JOIN gzcbl_t S1 ON S1.gzcbl001 = '2060' AND S1.gzcbl002 = pmds000 AND S1.gzcbl003 = '",g_dlang,"' ",
#        "             LEFT OUTER JOIN gzcbl_t S2 ON S2.gzcbl001 = '2061' AND S2.gzcbl002 = pmds011 AND S2.gzcbl003 = '",g_dlang,"' ",
#        "             LEFT OUTER JOIN gzcbl_t S3 ON S3.gzcbl001 = '13'   AND S3.gzcbl002 = pmdsstus AND S3.gzcbl003 = '",g_dlang,"' ",
#        #160328-00011#1-mark-(S) 與上方重複
##        "             LEFT OUTER JOIN pmaal_t S11 ON S11.pmaalent = pmdsent AND S11.pmaal001 = pmds007 AND S11.pmaal002 = '",g_dlang,"' ",
##        "             LEFT OUTER JOIN pmaal_t S12 ON S12.pmaalent = pmdsent AND S12.pmaal001 = pmds008 AND S12.pmaal002 = '",g_dlang,"' ",
##        "             LEFT OUTER JOIN pmaal_t S13 ON S13.pmaalent = pmdsent AND S13.pmaal001 = pmds009 AND S13.pmaal002 = '",g_dlang,"' ",
#        #160328-00011#1-mark-(E)
#        --"             LEFT OUTER JOIN oocql_t S14 ON S14.oocql001 = '275' AND S14.oocql002 = pmds012 AND S14.oocqlent = pmdsent AND S14.oocql003 = '",g_dlang,"' ",
#        "             LEFT OUTER JOIN oocql_t S15 ON S15.oocql001 = '238' AND S15.oocql002 = pmds032 AND S15.oocqlent = pmdsent AND S15.oocql003 = '",g_dlang,"' ",
#        "             LEFT OUTER JOIN ooef_t ON ooefent = pmdsent AND ooef001 = pmdssite ",
#        "             LEFT OUTER JOIN oodbl_t ON oodblent = pmdsent AND oodbl001 = ooef019 AND oodbl002 = pmds033 AND oodbl003 = '",g_dlang,"' ",
#        "             LEFT OUTER JOIN icaal_t ON icaalent = pmdsent AND icaal001 = pmds053 AND icaal002 = '",g_dlang,"' ",
#        "             LEFT OUTER JOIN gzcbl_t S17 ON S17.gzcbl001 = '2053' AND S17.gzcbl002 = pmds014 AND S17.gzcbl003 = '",g_dlang,"' ",
#        "             LEFT OUTER JOIN gzcbl_t S18 ON S18.gzcbl001 = '2026' AND S18.gzcbl002 = pmds036 AND S18.gzcbl003 = '",g_dlang,"' ",
#        "             LEFT OUTER JOIN gzcbl_t S19 ON S19.gzcbl001 = '2087' AND S19.gzcbl002 = pmds048 AND S19.gzcbl003 = '",g_dlang,"' ",
#        "             LEFT OUTER JOIN gzcbl_t S20 ON S20.gzcbl001 = '2086' AND S20.gzcbl002 = pmds049 AND S20.gzcbl003 = '",g_dlang,"' "
   LET g_from = " FROM pmds_t ",
                " LEFT OUTER JOIN ( SELECT pmdt_t.*,pmdo_t.*,imaa_t.*,imaf141",
                "                    FROM pmdt_t ",
                "                    LEFT OUTER JOIN pmdo_t ON pmdoent = pmdtent AND pmdodocno = pmdt001 AND pmdoseq = pmdt002 AND pmdoseq1 = pmdt003  AND pmdoseq2 = pmdt004 ",                                                                    
                "                    LEFT OUTER JOIN imaa_t ON imaa_t.imaa001 = pmdt_t.pmdt006 AND imaa_t.imaaent = pmdt_t.pmdtent ",
                "                    LEFT OUTER JOIN imaf_t ON imaf_t.imaf001 = pmdt_t.pmdt006 AND imaf_t.imafent = pmdt_t.pmdtent AND imaf_t.imafsite = '" ,g_site,"'" , 
                "                  ) x ",
                "              ON pmds_t.pmdsent = x.pmdtent AND pmds_t.pmdsdocno = x.pmdtdocno"
   #160411-00027#6-mod-(E)        
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
   PREPARE apmr003_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE apmr003_x01_curs CURSOR FOR apmr003_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="apmr003_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION apmr003_x01_ins_data()
DEFINE sr RECORD 
   pmdsdocno LIKE pmds_t.pmdsdocno, 
   pmdsdocdt LIKE pmds_t.pmdsdocdt, 
   l_pmds000_desc LIKE type_t.chr80, 
   l_pmds011_desc LIKE type_t.chr80, 
   l_pmdsstus_desc LIKE type_t.chr80, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   l_pmds007_desc LIKE pmaal_t.pmaal004, 
   pmdsent LIKE pmds_t.pmdsent, 
   pmdssite LIKE pmds_t.pmdssite, 
   pmdtseq LIKE pmdt_t.pmdtseq, 
   pmdt001 LIKE pmdt_t.pmdt001, 
   pmdt002 LIKE pmdt_t.pmdt002, 
   pmdt003 LIKE pmdt_t.pmdt003, 
   pmdt004 LIKE pmdt_t.pmdt004, 
   l_pmdt005_desc LIKE type_t.chr10, 
   pmdt006 LIKE pmdt_t.pmdt006, 
   x_t6_imaal003 LIKE imaal_t.imaal003, 
   x_t6_imaal004 LIKE imaal_t.imaal004, 
   pmdt007 LIKE pmdt_t.pmdt007, 
   l_pmdt007_desc LIKE type_t.chr500, 
   l_imaa127_desc LIKE type_t.chr50, 
   pmdt026 LIKE pmdt_t.pmdt026, 
   pmdt020 LIKE pmdt_t.pmdt020, 
   pmdt019 LIKE pmdt_t.pmdt019, 
   pmdt016 LIKE pmdt_t.pmdt016, 
   l_pmdt016_desc LIKE type_t.chr500, 
   pmdt017 LIKE pmdt_t.pmdt017, 
   l_pmdt017_desc LIKE inab_t.inab003, 
   pmdt018 LIKE pmdt_t.pmdt018, 
   pmdt053 LIKE pmdt_t.pmdt053, 
   pmdt054 LIKE pmdt_t.pmdt054, 
   pmdt055 LIKE pmdt_t.pmdt055, 
   l_qty_1 LIKE type_t.num20_6, 
   l_qty_2 LIKE type_t.num20_6, 
   l_qty_3 LIKE type_t.num20_6, 
   pmdt059 LIKE pmdt_t.pmdt059, 
   l_pmdt025_desc LIKE gzcbl_t.gzcbl004, 
   pmdt063 LIKE pmdt_t.pmdt063, 
   l_pmdt019_desc LIKE oocal_t.oocal003, 
   l_pmdt083_desc LIKE qcaol_t.qcaol004
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE sr1  RECORD
    l_pmdt001    LIKE pmdt_t.pmdt001,
    l_pmdt002    LIKE pmdt_t.pmdt002,
    l_pmds000    LIKE rtaxl_t.rtaxl003,
    l_pmdsdocno  LIKE pmds_t.pmdsdocno,
    l_pmdsdocdt  LIKE pmds_t.pmdsdocdt,
    l_pmdsstus   LIKE type_t.chr80,
    #160411-00027#6-mod-(S)
#    l_pmds002    LIKE type_t.chr100,
#    l_pmds003    LIKE type_t.chr100,
    l_pmds002    LIKE pmds_t.pmds002,
    l_pmds002_desc LIKE ooag_t.ooag011,
    l_pmds003    LIKE pmds_t.pmds003,
    l_pmds003_desc LIKE ooefl_t.ooefl003,
    #160411-00027#6-mod-(E)
    l_pmdtseq    LIKE pmdt_t.pmdtseq,
    l_pmdt020    LIKE pmdt_t.pmdt020,
    l_pmdt019    LIKE pmdt_t.pmdt019,
    l_pmdt022    LIKE pmdt_t.pmdt022,
    l_pmdt021    LIKE pmdt_t.pmdt021,
    l_pmdt024    LIKE pmdt_t.pmdt024,
    l_pmdt023    LIKE pmdt_t.pmdt023,
    #160411-00027#6-mod-(S)
#    l_pmdt016    LIKE type_t.chr100,
#    l_pmdt017    LIKE type_t.chr100,
    l_pmdt016    LIKE pmdt_t.pmdt016,
    l_pmdt016_ref LIKE inayl_t.inayl003,
    l_pmdt017    LIKE pmdt_t.pmdt017,
    l_pmdt017_ref LIKE inab_t.inab003,
    #160411-00027#6-mod-(E)
    l_pmdt018    LIKE pmdt_t.pmdt018,
    l_pmdt083    LIKE pmdt_t.pmdt083,
    l_pmdt055    LIKE pmdt_t.pmdt055
           END RECORD
DEFINE l_desc    LIKE type_t.chr100
DEFINE l_false   LIKE type_t.num20_6
DEFINE l_pmdt020 LIKE pmdt_t.pmdt020
DEFINE l_qcba017 LIKE qcba_t.qcba017
DEFINE l_pass    LIKE type_t.num5
DEFINE l_sql     STRING
DEFINE l_qc_sql  STRING
DEFINE l_pmdt_sql STRING
DEFINE l_qcba_sql STRING
DEFINE l_ooef019   LIKE ooef_t.ooef019  #稅區            dorislai-20150729-add----(S)
DEFINE l_success   LIKE type_t.num5
DEFINE l_acc       LIKE gzcb_t.gzcb004  #系統應用欄位二   dorislai-20150729-add----(E)              
DEFINE l_pmds028   LIKE pmds_t.pmds028  #161207-00033#22
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    LET l_qc_sql = " SELECT COALESCE(qcba017,0)-COALESCE(qcba023,0) ",
                        "   FROM qcba_t ",
                        "  WHERE qcbastus = 'Y' ",
                        "    AND qcbasite = '",g_site,"'",
                        "    AND qcba001 = ? ",
                        "    AND qcba002 = ?"
    PREPARE apmr003_qc FROM l_qc_sql
    LET l_pmdt_sql = " SELECT SUM(COALESCE(pmdt020,0)) ",
                        "   FROM pmds_t,pmdt_t ",
                        "  WHERE pmdsstus = 'Y' ",
                        "    AND pmdssite = '",g_site,"'",
                        "    AND pmdsdocno = pmdtdocno ",
                        "    AND pmdsent = pmdtent ",
                        "    AND pmds000 = '5' ",
                        "    AND pmdt027 = ? ",
                        "    AND pmdt028 = ? "
    PREPARE apmr003_pmdt FROM l_pmdt_sql
    LET l_qcba_sql = " SELECT SUM(COALESCE(qcba017,0)) ",
                        "   FROM qcba_t ",
                        "  WHERE qcbastus = 'Y' ",
                        "    AND qcbasite = '",g_site,"'",
                        "    AND qcba001 = ? ",
                        "    AND qcba002 = ?"
    PREPARE apmr003_qcba FROM l_qcba_sql
    #160328-00011#1-add-(S) 
    LET l_sql = " SELECT pmds000,pmdsdocno,pmdsdocdt, ",
                "        (SELECT gzcbl004 FROM gzcb_t,gzcbl_t WHERE gzcb001 = '13' AND gzcb002 = pmdsstus AND gzcb001 = gzcbl001  AND gzcb002 = gzcbl002 AND gzcbl003 = '"||g_dlang||"') pmdsstus, ", 
                #160411-00027#6-mod-(S)
#                "        trim(pmds002)||'.'||trim((SELECT ooag011  FROM ooag_t WHERE ooagent = pmdsent AND ooag001 = pmds002)), ",
#                "        trim(pmds003)||'.'||trim((SELECT ooefl003 FROM ooefl_t WHERE ooeflent = pmdsent AND ooefl001 = pmds003 AND ooefl002 = '"||g_dlang||"')), ",                                  
                "        pmds002,",
                "        (SELECT ooag011  FROM ooag_t WHERE ooagent = pmdsent AND ooag001 = pmds002) ooag011, ",
                "        pmds003,",
                "        (SELECT ooefl003 FROM ooefl_t WHERE ooeflent = pmdsent AND ooefl001 = pmds003 AND ooefl002 = '"||g_dlang||"') ooefl003, ", 
                #160411-00027#6-mod-(E)
                "        pmdtseq, COALESCE(pmdt020,0), pmdt019,   ",
                "        pmdt022, pmdt021,             pmdt024,   ", 
                "        pmdt023, ",
                #160411-00027#6-mod-(S)
#                "        trim(pmdt016)||'.'||trim((SELECT inayl003 FROM inay_t ",
#                "                                   INNER JOIN inayl_t ON inayent = inaylent AND inay001 = inayl001 AND inayl002 = '"||g_dlang||"' ",
#                "                                   WHERE inayent  = pmdsent AND inay001  = pmdt016)), ",
#                "        trim(pmdt017)||'.'||trim((SELECT inab003  FROM inab_t WHERE inabent  = pmdsent AND inabsite = pmdssite AND inab001  = pmdt016 AND inab002  = pmdt017)), ",
                "        pmdt016,",
                "        (SELECT inayl003 FROM inay_t ",
                "                INNER JOIN inayl_t ON inayent = inaylent AND inay001 = inayl001 AND inayl002 = '"||g_dlang||"' ",
                "                WHERE inayent  = pmdsent AND inay001  = pmdt016) inayl003, ",
                "        pmdt017,",
                "        (SELECT inab003  FROM inab_t WHERE inabent  = pmdsent AND inabsite = pmdssite AND inab001  = pmdt016 AND inab002  = pmdt017) inab003, ",
                #160411-00027#6-mod-(E)
                "        pmdt018, ",
                "        CASE pmds000 WHEN '5' THEN pmdt083 ELSE '' END, ",
                "        CASE pmds000 WHEN '5' THEN COALESCE(pmdt020,0)-COALESCE(pmdt055,0) ELSE 0 END, ",
                "        pmdt001, pmdt002                                   ",
                "   FROM pmds_t,  pmdt_t ",
                "  WHERE pmdsent = ?",
                "    AND pmdssite = ?",
                "    AND pmds000 IN ('3','4','5','6','7') ",
                "    AND pmdtent = pmdsent ",
                "    AND pmdtdocno = pmdsdocno ",
                "    AND pmdt001 = ? ",
                "    AND pmdt002 = ? ",
                "  ORDER BY pmdsdocdt "  
    DECLARE apmr003_x01_repcur CURSOR FROM l_sql
    #160328-00011#1-add-(E) 
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH apmr003_x01_curs INTO sr.*                               
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
#       INITIALIZE sr.l_pmdt020_053_055_count TO NULL
#       LET sr.l_pmdt020_053_055_count = sr.pmdt020 - sr.pmdt053 - sr.pmdt055
#       #當tm.a1=Y(是否只列印未檢驗的資料)，只列印(收貨量-允收量-驗退量)>0的資料
#       IF  tm.a1 = "Y" THEN
#         IF sr.l_pmdt020_053_055_count <= 0 THEN
#            CONTINUE FOREACH
#         END IF
#       END IF 
       LET l_pass = FALSE
       LET l_false = 0
       LET l_pmdt020 = 0
       LET l_qcba017 = 0
       #CALL apmr003_x01_nulltozero(sr.pmdt020) RETURNING sr.pmdt020
       #CALL apmr003_x01_nulltozero(sr.pmdt053) RETURNING sr.pmdt053
       #CALL apmr003_x01_nulltozero(sr.pmdt054) RETURNING sr.pmdt054
       #CALL apmr003_x01_nulltozero(sr.pmdt055) RETURNING sr.pmdt055
       #待驗量
       IF sr.pmdt026 = 'Y' THEN  #檢驗
          #待驗量 = 收貨量-已驗量
          EXECUTE apmr003_qcba USING sr.pmdsdocno,sr.pmdtseq INTO l_qcba017
          CALL apmr003_x01_nulltozero(l_qcba017) RETURNING l_qcba017
          LET sr.l_qty_1 = sr.pmdt020 - l_qcba017
          #待入庫量 = 允收量-已入庫量
          LET sr.l_qty_2 = sr.pmdt053 - sr.pmdt054
          #驗退量
          EXECUTE apmr003_qc USING sr.pmdsdocno,sr.pmdtseq INTO l_false
          EXECUTE apmr003_pmdt USING sr.pmdsdocno,sr.pmdtseq INTO l_pmdt020
          CALL apmr003_x01_nulltozero(l_false) RETURNING l_false
          CALL apmr003_x01_nulltozero(l_pmdt020) RETURNING l_pmdt020
          LET sr.l_qty_3 = l_false - l_pmdt020
       ELSE
          LET sr.l_qty_1 = 0
          #待入庫量 = 收貨數量-已入庫量
          LET sr.l_qty_2 = sr.pmdt020 - sr.pmdt054
          #驗退量
          LET sr.l_qty_3 = 0
       END IF
       #chk1打勾時，僅顯示待檢驗量>0的資料
##       IF tm.chk1 = 'Y' AND sr.l_qty_1 <= 0 THEN
##          CONTINUE FOREACH
##       END IF
       #待入庫量
#       IF sr.pmdt026 = 'Y' THEN  #檢驗
#          #待入庫量 = 允收量-已入庫量
#          LET sr.l_qty_2 = sr.pmdt053 - sr.pmdt054
#       ELSE
#          #待入庫量 = 收貨數量-已入庫量
#          LET sr.l_qty_2 = sr.pmdt020 - sr.pmdt054
#       END IF
       #chk2打勾時，僅顯示待入庫量>0的資料
##       IF tm.chk2 = 'Y' AND sr.l_qty_2 <= 0 THEN
##          CONTINUE FOREACH
##       END IF
      
#       IF sr.pmdt026 = 'Y' THEN  #檢驗
#          #驗退量
#          
#          EXECUTE apmr003_qc USING sr.pmdsdocno,sr.pmdtseq INTO l_false
#          EXECUTE apmr003_pmdt USING sr.pmdsdocno,sr.pmdtseq INTO l_pmdt020
#          CALL apmr003_x01_nulltozero(l_false) RETURNING l_false
#          CALL apmr003_x01_nulltozero(l_pmdt020) RETURNING l_pmdt020
#          LET sr.l_qty_3 = l_false - l_pmdt020
#       ELSE
#          #待入庫量 = 收貨數量-已入庫量
#          LET sr.l_qty_3 = 0
#       END IF
       
##       IF tm.chk3 = 'Y' AND sr.l_qty_3 <= 0 THEN
##          CONTINUE FOREACH
##       END IF
       
       #子件特性
       #CALL s_desc_gzcbl004_desc('2055',sr.pmdt005) RETURNING sr.l_pmdt005_desc
       #dorislai-20150805-add----(S)
       #LET sr.l_pmdt005desc = ''
       #IF NOT cl_null(sr.l_pmdt005_desc) THEN
       #   LET sr.l_pmdt005desc = sr.pmdt005,'.',sr.l_pmdt005_desc
       #END IF
       #dorislai-20150805-add----(E)
       #產品分類 s983961 mark
       #SELECT imaa009 INTO sr.l_imaa009_rtaxl003 FROM imaa_t
       # WHERE imaaent = g_enterprise AND imaa001 = sr.pmdt006
       #CALL s_desc_get_rtaxl003_desc(sr.l_imaa009_rtaxl003) RETURNING l_desc
       #IF NOT cl_null(sr.l_imaa009_rtaxl003) AND NOT cl_null(l_desc) THEN
       #   LET sr.l_imaa009_rtaxl003 = sr.l_imaa009_rtaxl003,'.',l_desc
       #END IF
       
       
       #採購分群 #s983961--mark
       #SELECT imaf141 INTO sr.l_imaf141_oocql004 FROM imaf_t
       # WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = sr.pmdt006
       #CALL s_desc_gzcbl004_desc('203',sr.l_imaf141_oocql004) RETURNING l_desc
       #IF NOT cl_null(sr.l_imaf141_oocql004) AND NOT cl_null(l_desc) THEN
       #   LET sr.l_imaf141_oocql004 = sr.l_imaf141_oocql004,'.',l_desc
       #END IF
       #採購料號
       #SELECT pmdo001 INTO sr.l_pmdo001 FROM pmdo_t
       # WHERE pmdoent = g_enterprise AND pmdodocno = sr.pmdt001
       #   AND pmdoseq = sr.pmdt002 AND pmdoseq1 = sr.pmdt003 AND pmdoseq2 = sr.pmdt004
       #CALL s_desc_get_item_desc(sr.l_pmdo001) RETURNING sr.l_pmdo001_imaal003,sr.l_pmdo001_imaal004
       #
       #LEFT OUTER JOIN pmdo_t ON pmdoent = pmdtent AND pmdodocno = pmdt001 AND pmdoseq = pmdt002 
       #                                            AND pmdoseq1 = pmdt003  AND pmdoseq2 = pmdt004
       #限定庫位
       #LET sr.l_pmdt016_desc = sr.pmdt016
       #dorislai-20150729-modify----(S)
#       CALL s_desc_get_stock_desc(sr.pmdssite,sr.pmdt016) RETURNING l_desc
#       IF NOT cl_null(sr.pmdt016) AND NOT cl_null(l_desc) THEN
#          LET sr.l_pmdt016_desc = sr.pmdt016,'.',l_desc
#       END IF
       #LET sr.l_pmdt016_ref = ''
       #LET sr.l_pmdt016_desc = ''
       #CALL s_desc_get_stock_desc(sr.pmdssite,sr.pmdt016) RETURNING sr.l_pmdt016_ref
       #IF NOT cl_null(sr.pmdt016) AND NOT cl_null(sr.l_pmdt016_ref) THEN
       #   LET sr.l_pmdt016_desc = sr.pmdt016,'.',sr.l_pmdt016_ref
       #END IF
       #dorislai-20150729-modify----(E)
       #限定儲位
       #LET sr.l_pmdt017_desc = sr.pmdt017
       #dorislai-20150729-modify----(S)
#       CALL s_desc_get_locator_desc(sr.pmdssite,sr.pmdt016,sr.pmdt017) RETURNING l_desc
#       IF NOT cl_null(sr.pmdt017) AND NOT cl_null(l_desc) THEN
#          LET sr.l_pmdt017_desc = sr.pmdt017,'.',l_desc
#       END IF
       #LET sr.l_pmdt017_ref = ''
       #LET sr.l_pmdt017_desc = ''
       #CALL s_desc_get_locator_desc(sr.pmdssite,sr.pmdt016,sr.pmdt017) RETURNING sr.l_pmdt017_ref
       #IF NOT cl_null(sr.pmdt017) AND NOT cl_null(sr.l_pmdt017_ref) THEN
       #   LET sr.l_pmdt017_desc = sr.pmdt017,'.',sr.l_pmdt017_ref
       #END IF
       #dorislai-20150729-modify----(E)
       #緊急度
       #CALL s_desc_gzcbl004_desc('2036',sr.pmdt025) RETURNING sr.l_pmdt025_desc
       #dorislai-20150805-add----(S)
       #LET sr.l_pmdt025desc = ''
       #IF NOT cl_null(sr.l_pmdt025_desc) THEN
       #   LET sr.l_pmdt025desc = sr.pmdt025,'.',sr.l_pmdt025_desc
       #END IF
       #dorislai-20150805-add----(E)
       #狀態碼
       #CALL s_desc_gzcbl004_desc('13',sr.pmdsstus) RETURNING sr.l_pmdsstus_desc
       #dorislai-20150805-add----(S)
       #LET sr.l_pmdsstusdesc = ''
       #IF NOT cl_null(sr.l_pmdsstus_desc) THEN
       #   LET sr.l_pmdsstusdesc = sr.pmdsstus,'.',sr.l_pmdsstus_desc
       #END IF
       #dorislai-20150805-add----(E)
       #單據性質
       #CALL s_desc_gzcbl004_desc('2060',sr.pmds000) RETURNING sr.l_pmds000_desc
       #採購性質
       #CALL s_desc_gzcbl004_desc('2061',sr.pmds011) RETURNING sr.l_pmds011_desc
       #dorislai-20150729-add----(S)
       #LET sr.l_pmds011desc = ''
       #IF NOT cl_null(sr.l_pmds011_desc) THEN
       #   LET sr.l_pmds011desc = sr.pmds011,'.',sr.l_pmds011_desc
       #END IF
       #採購供應商說明 l_pmds007_desc	
       #LET sr.l_pmds007_desc = ''	   
       #SELECT pmaal004 INTO sr.l_pmds007_desc FROM pmaal_t 
       # WHERE pmaalent = g_enterprise AND pmaal001 = sr.pmds007 AND pmaal002 = g_dlang
       #帳款供應商說明 l_pmds008_desc	
       #LET sr.l_pmds008_desc = ''	
       #SELECT pmaal004 INTO sr.l_pmds008_desc FROM pmaal_t 
       # WHERE pmaalent = g_enterprise AND pmaal001 = sr.pmds008 AND pmaal002 = g_dlang
       #送貨供應商說明 l_pmds009_desc	
       #LET sr.l_pmds009_desc = ''	 
       #SELECT pmaal004 INTO sr.l_pmds009_desc FROM pmaal_t 
       # WHERE pmaalent = g_enterprise AND pmaal001 = sr.pmds009 AND pmaal002 = g_dlang
       #採購通路說明 l_pmds012_desc	
       #LET sr.l_pmds012_desc = ''
       #CALL s_desc_get_acc_desc('275',sr.pmds012) RETURNING sr.l_pmds012_desc
       #付款條件全名 l_pmds031desc	
       #LET sr.l_pmds031_desc = ''
       #LET sr.l_pmds031desc = ''
       #CALL s_desc_get_ooib002_desc(sr.pmds031) RETURNING sr.l_pmds031_desc
       #IF NOT cl_null(sr.l_pmds031_desc) THEN
       #   LET sr.l_pmds031desc = sr.pmds031,'.',sr.l_pmds031_desc	
       #END IF
       #交易條件全名 l_pmds032desc	
       #LET sr.l_pmds032_desc = ''
       #LET sr.l_pmds032desc = ''
       #CALL s_desc_get_acc_desc('238',sr.pmds032) RETURNING sr.l_pmds032_desc
       #IF NOT cl_null(sr.l_pmds032_desc) THEN
       #   LET sr.l_pmds032desc = sr.pmds032,'.',sr.l_pmds032_desc
       #END IF
       
       
       
       #稅別全名 l_pmds033desc	
       #   #稅區
       #LET l_ooef019 = ''
       #SELECT ooef019 INTO l_ooef019 FROM ooef_t 
       # WHERE ooefent = g_enterprise AND ooef001 = g_site 
       #   #稅別
       #LET sr.l_pmds033_desc = ''
       #LET sr.l_pmds033desc = ''
       #CALL s_desc_get_tax_desc(l_ooef019,sr.pmds033) RETURNING sr.l_pmds033_desc
       #IF NOT cl_null(sr.l_pmds033_desc) THEN
       #   LET sr.l_pmds033desc = sr.pmds033,'.',sr.l_pmds033_desc
       #END IF
       #幣別全名 l_pmds037desc	
       #LET sr.l_pmds037_desc = ''
       #LET sr.l_pmds037desc = ''
       #CALL s_desc_get_currency_desc(sr.pmds037) RETURNING sr.l_pmds037_desc
       #IF NOT cl_null(sr.l_pmds037_desc) THEN
       #   LET sr.l_pmds037desc = sr.pmds037,'.',sr.l_pmds037_desc
       #END IF
       #取價方式全名 l_pmds039desc	
       #LET sr.l_pmds039_desc = ''
       #LET sr.l_pmds039desc = ''
       #CALL s_desc_get_price_type_desc(sr.pmds039) RETURNING sr.l_pmds039_desc
       #IF NOT cl_null(sr.l_pmds039_desc) THEN
       #   LET sr.l_pmds039desc = sr.pmds039,'.',sr.l_pmds039_desc
       #END IF
       #付款優惠條件全名 l_pmds040desc	
       #LET sr.l_pmds040_desc = ''
       #LET sr.l_pmds040desc = ''
       #CALL s_desc_ooid001_desc(sr.pmds040) RETURNING sr.l_pmds040_desc
       #IF NOT cl_null(sr.l_pmds040_desc) THEN
       #   LET sr.l_pmds040desc = sr.pmds040,'.',sr.l_pmds040_desc
       #END IF
       #多角流程代碼全名 l_pmds053desc	
       #LET sr.l_pmds053_desc = ''
       #LET sr.l_pmds053desc = ''
       #CALL s_desc_get_icaa001_desc(sr.pmds053) RETURNING sr.l_pmds053_desc
       #IF NOT cl_null(sr.l_pmds053_desc) THEN
       #   LET sr.l_pmds053desc = sr.pmds053,'.',sr.l_pmds053_desc
       #END IF
       
       #產品特徵全名 l_pmdt007desc	
       #160328-00011#1-mark-(S)
#       LET sr.l_pmdt007_desc = ''
#       LET sr.l_pmdt007desc = ''
       #160328-00011#1-mark-(E)
#       CALL s_feature_description(sr.pmdt006,sr.pmdt007) RETURNING l_success,sr.l_pmdt007_desc #160411-00027#6-mark
       #160328-00011#1-mark-(S)
#       IF NOT cl_null(sr.l_pmdt007_desc) THEN
#          LET sr.l_pmdt007desc = sr.pmdt007,'.',sr.l_pmdt007_desc	
#       END IF
       #160328-00011#1-mark-(E)
       #理由碼全名 l_pmdt051desc	
       #LET sr.l_pmdt051_desc = ''
       #LET sr.l_pmdt051desc = ''
       #SELECT gzcb004 INTO l_acc FROM gzcb_t WHERE gzcb001 = '24' AND gzcb002 = g_prog 
       #CALL s_desc_get_acc_desc(l_acc,sr.pmdt051) RETURNING sr.l_pmdt051_desc
       #IF NOT cl_null(sr.l_pmdt051_desc) THEN
       #   LET sr.l_pmdt051desc = sr.pmdt051,'.',sr.l_pmdt051_desc
       #END IF
       #專案編號全名 l_pmdt072desc	
       #LET sr.l_pmdt072_desc = ''
       #LET sr.l_pmdt072desc = ''
       #CALL s_desc_get_project_desc(sr.pmdt072) RETURNING sr.l_pmdt072_desc
       #IF NOT cl_null(sr.l_pmdt072_desc) THEN
       #   LET sr.l_pmdt072desc = sr.pmdt072,'.',sr.l_pmdt072_desc	
       #END IF
       #WBS全名 l_pmdt073desc	
       #LET sr.l_pmdt073_desc = ''
       #LET sr.l_pmdt073desc = ''
       #CALL s_desc_get_wbs_desc(sr.pmdt072,sr.pmdt073) RETURNING sr.l_pmdt073_desc
       #IF NOT cl_null(sr.l_pmdt073_desc) THEN
       #   LET sr.l_pmdt073desc = sr.pmdt073,'.',sr.l_pmdt073_desc
       #END IF
       #活動編號全名 l_pmdt074desc	
       #LET sr.l_pmdt074_desc = ''	
       #LET sr.l_pmdt074desc = ''	
       #CALL s_desc_get_activity_desc(sr.pmdt072,sr.pmdt074) RETURNING sr.l_pmdt074_desc
       #IF NOT cl_null(sr.l_pmdt074_desc) THEN
       #   LET sr.l_pmdt074desc = sr.pmdt074,'.',sr.l_pmdt074_desc	
       #END IF
       #dorislai-20160118-mark----(S)
#       #單據單號全名 l_pmdsdocnodesc 
#       LET sr.l_pmdsdocno_desc = ''
#       LET sr.l_pmdsdocnodesc = ''
#       CALL s_aooi200_get_slip_desc(sr.pmdsdocno) RETURNING sr.l_pmdsdocno_desc
#       IF NOT cl_null(sr.l_pmdsdocno_desc) THEN
#          LET sr.l_pmdsdocnodesc = sr.pmdsdocno,'.',sr.l_pmdsdocno_desc
#       END IF
       #dorislai-20160118-mark----(E)
       ##申請人員說明 l_pmds002_ref 
       #LET sr.l_pmds002_ref = ''
       #CALL s_desc_get_person_desc(sr.pmds002) RETURNING sr.l_pmds002_ref
       ##申請部門說明 l_pmds003_ref 
       #LET sr.l_pmds003_ref = ''
       #CALL s_desc_get_department_desc(sr.pmds003) RETURNING sr.l_pmds003_ref
       ##多角性質全名 l_pmds014desc 
       #LET sr.l_pmds014_desc = ''
       #LET sr.l_pmds014desc = ''
       #CALL s_desc_gzcbl004_desc('2053',sr.pmds014) RETURNING sr.l_pmds014_desc
       #IF NOT cl_null(sr.l_pmds014_desc) THEN
       #   LET sr.l_pmds014desc = sr.pmds014,'.',sr.l_pmds014_desc
       #END IF
       ##交易類型全名 l_pmds036desc 
       #LET sr.l_pmds036_desc = ''
       #LET sr.l_pmds036desc = ''
       #CALL s_desc_gzcbl004_desc('2026',sr.pmds036) RETURNING sr.l_pmds036_desc
       #IF NOT cl_null(sr.l_pmds036_desc) THEN
       #   LET sr.l_pmds036desc = sr.pmds036,'.',sr.l_pmds036_desc
       #END IF
       #內外購全名 l_pmds048desc 
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
       #dorislai-20150729-add----(E)
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       IF tm.chk1 = 'N' AND tm.chk2 = 'N' AND tm.chk3 = 'N' THEN
          LET l_pass = TRUE
       END IF
       
       IF tm.chk1 = 'Y' AND sr.l_qty_1 > 0 THEN
          LET l_pass = TRUE
       END IF
       
       IF tm.chk2 = 'Y' AND sr.l_qty_2 > 0 THEN
          LET l_pass = TRUE
       END IF
       
       IF tm.chk3 = 'Y' AND sr.l_qty_3 > 0 THEN
          LET l_pass = TRUE
       END IF
       
       IF NOT l_pass THEN
          CONTINUE FOREACH
       END IF
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.pmdsdocno,sr.pmdsdocdt,sr.l_pmds000_desc,sr.l_pmds011_desc,sr.l_pmdsstus_desc,sr.ooag_t_ooag011,sr.ooefl_t_ooefl003,sr.l_pmds007_desc,sr.pmdtseq,sr.pmdt001,sr.pmdt002,sr.pmdt003,sr.pmdt004,sr.l_pmdt005_desc,sr.pmdt006,sr.x_t6_imaal003,sr.x_t6_imaal004,sr.pmdt007,sr.l_pmdt007_desc,sr.l_imaa127_desc,sr.pmdt026,sr.pmdt020,sr.pmdt019,sr.pmdt016,sr.l_pmdt016_desc,sr.pmdt017,sr.l_pmdt017_desc,sr.pmdt018,sr.pmdt053,sr.pmdt054,sr.pmdt055,sr.l_qty_1,sr.l_qty_2,sr.l_qty_3,sr.pmdt059,sr.l_pmdt025_desc,sr.pmdt063,sr.l_pmdt019_desc,sr.l_pmdt083_desc
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "apmr003_x01_execute"
          LET g_errparam.code   = SQLCA.sqlcode
          LET g_errparam.popup  = FALSE
          CALL cl_err()       
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF
 
       #add-point:ins_data段after_save name="ins_data.after.save"
       IF tm.chk = 'Y' THEN   #列印相關進出單據明細
          #151030-00002#2 20151030 s983961--mark(s) 效能調整
          #LET l_sql = " SELECT pmds000,pmdsdocno,pmdsdocdt,pmdsstus,pmds002,pmds003,pmdtseq,pmdt020,pmdt019, ",
          #            "        pmdt022,pmdt021,pmdt024,pmdt023,pmdt016,pmdt017,pmdt018,pmdt083,pmdt055,pmdt001,pmdt002 ",
          #            "   FROM pmds_t,pmdt_t ",
          #            "  WHERE pmdsent = ",sr.pmdsent,
          #            "    AND pmdssite = '",sr.pmdssite,"' ",
          #            "    AND pmds000 IN ('3','4','5','6','7') ",
          #            "    AND pmdtent = pmdsent ",
          #            "    AND pmdtdocno = pmdsdocno ",
          #            "    AND pmdt001 = '",sr.pmdsdocno,"' ",
          #            "    AND pmdt002 = '",sr.pmdtseq,"' ",
          #            "  ORDER BY pmdsdocdt "
          #151030-00002#2 20151030 s983961--mark(e) 效能調整            
          #160328-00011#1-mark-(S)
#          #151030-00002#2 20151030 s983961--add(s) 效能調整            
#          LET l_sql = " SELECT pmds000, pmdsdocno,           pmdsdocdt, ",
#                      "        (SELECT gzcbl004 FROM gzcb_t,gzcbl_t WHERE gzcb001 = '13' AND gzcb002 = pmdsstus AND gzcb001 = gzcbl001  AND gzcb002 = gzcbl002 AND gzcbl003 = '"||g_dlang||"') pmdsstus, ", 
#                      "        trim(pmds002)||'.'||trim((SELECT ooag011  FROM ooag_t WHERE ooagent = pmdsent AND ooag001 = pmds002)), ",
#                      "        trim(pmds003)||'.'||trim((SELECT ooefl003 FROM ooefl_t WHERE ooeflent = pmdsent AND ooefl001 = pmds003 AND ooefl002 = '"||g_dlang||"')), ",                                  
#                      "        pmdtseq, COALESCE(pmdt020,0), pmdt019,   ",
#                      "        pmdt022, pmdt021,             pmdt024,   ", 
#                      "        pmdt023, ",
#                      "        trim(pmdt016)||'.'||trim((SELECT inayl003 FROM inay_t ",
#                      "                                   INNER JOIN inayl_t ON inayent = inaylent AND inay001 = inayl001 AND inayl002 = '"||g_dlang||"' ",
#                      "                                   WHERE inayent  = pmdsent AND inay001  = pmdt016)), ",
#                      "        trim(pmdt017)||'.'||trim((SELECT inab003  FROM inab_t WHERE inabent  = pmdsent AND inabsite = pmdssite AND inab001  = pmdt016 AND inab002  = pmdt017)), ",
#                      "        pmdt018, pmdt083,             COALESCE(pmdt055,0), ",
#                      "        pmdt001, pmdt002                                   ",
#                      "   FROM pmds_t,  pmdt_t ",
#                      "  WHERE pmdsent = ",sr.pmdsent,
#                      "    AND pmdssite = '",sr.pmdssite,"' ",
#                      "    AND pmds000 IN ('3','4','5','6','7') ",
#                      "    AND pmdtent = pmdsent ",
#                      "    AND pmdtdocno = pmdsdocno ",
#                      "    AND pmdt001 = '",sr.pmdsdocno,"' ",
#                      "    AND pmdt002 = '",sr.pmdtseq,"' ",
#                      "  ORDER BY pmdsdocdt "            
#          #151030-00002#2 20151030 s983961--add(e) 效能調整
          #160328-00011#1-mark-(E) 
          
#          DECLARE apmr003_x01_repcur CURSOR FROM l_sql
          #160328-00011#1-mark-(E) 
          #160328-00011#1-mod-(S)
#          FOREACH apmr003_x01_repcur INTO sr1.l_pmds000,sr1.l_pmdsdocno,sr1.l_pmdsdocdt,sr1.l_pmdsstus,
#                                          sr1.l_pmds002,sr1.l_pmds003,sr1.l_pmdtseq,sr1.l_pmdt020,sr1.l_pmdt019,
#                                          sr1.l_pmdt022,sr1.l_pmdt021,sr1.l_pmdt024,sr1.l_pmdt023,sr1.l_pmdt016,
#                                          sr1.l_pmdt017,sr1.l_pmdt018,sr1.l_pmdt083,sr1.l_pmdt055,sr1.l_pmdt001,sr1.l_pmdt002
          FOREACH apmr003_x01_repcur USING sr.pmdsent,sr.pmdssite,sr.pmdsdocno,sr.pmdtseq
                                      INTO sr1.l_pmds000,sr1.l_pmdsdocno,sr1.l_pmdsdocdt,sr1.l_pmdsstus,
                                           #160411-00027#6-mod-(S)
#                                           sr1.l_pmds002,sr1.l_pmds003,
                                           sr1.l_pmds002,sr1.l_pmds002_desc,sr1.l_pmds003,sr1.l_pmds003_desc,
                                           #160411-00027#6-mod-(E)
                                           sr1.l_pmdtseq,sr1.l_pmdt020,sr1.l_pmdt019,
                                           sr1.l_pmdt022,sr1.l_pmdt021,sr1.l_pmdt024,sr1.l_pmdt023,
                                           #160411-00027#6-mod-(S)
#                                           sr1.l_pmdt016,sr1.l_pmdt017,
                                           sr1.l_pmdt016,sr1.l_pmdt016_ref,sr1.l_pmdt017,sr1.l_pmdt017_ref,
                                           #160411-00027#6-mod-(E)
                                           sr1.l_pmdt018,sr1.l_pmdt083,sr1.l_pmdt055,sr1.l_pmdt001,sr1.l_pmdt002
          #160328-00011#1-mod-(E)
             IF STATUS THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = 'foreach:'
                LET g_errparam.code   = STATUS
                LET g_errparam.popup  = TRUE
                CALL cl_err()
                LET g_rep_success = 'N'
                EXIT FOREACH
             END IF
             #151030-00002#2 20151030 s983961--mark(s) 效能調整
             #人員
             #CALL s_desc_get_person_desc(sr1.l_pmds002) RETURNING l_desc
             #IF NOT cl_null(sr1.l_pmds002) AND NOT cl_null(l_desc) THEN
             #   LET sr1.l_pmds002 = sr1.l_pmds002,'.',l_desc
             #END IF
             #部門
             #CALL s_desc_get_department_desc(sr1.l_pmds003) RETURNING l_desc
             #IF NOT cl_null(sr1.l_pmds003) AND NOT cl_null(l_desc) THEN
             #   LET sr1.l_pmds003 = sr1.l_pmds003,'.',l_desc
             #END IF
             #限定庫位
             #CALL s_desc_get_stock_desc(sr.pmdssite,sr1.l_pmdt016) RETURNING l_desc
             #IF NOT cl_null(sr1.l_pmdt016) AND NOT cl_null(l_desc) THEN
             #   LET sr1.l_pmdt016 = sr1.l_pmdt016,'.',l_desc
             #END IF
             #限定儲位
             #CALL s_desc_get_locator_desc(sr.pmdssite,sr1.l_pmdt016,sr1.l_pmdt017) RETURNING l_desc
             #IF NOT cl_null(sr1.l_pmdt017) AND NOT cl_null(l_desc) THEN
             #   LET sr1.l_pmdt017 = sr1.l_pmdt017,'.',l_desc
             #END IF
             #IF cl_null(sr1.l_pmdt020) THEN LET sr1.l_pmdt020 = 0 END IF
             #IF cl_null(sr1.l_pmdt055) THEN LET sr1.l_pmdt055 = 0 END IF
             #151030-00002#2 20151030 s983961--mark(e) 效能調整
             #160328-00011#-mark-(S)
#             IF sr1.l_pmds000 = '5' THEN
#                LET sr1.l_pmdt055 = sr1.l_pmdt020 - sr1.l_pmdt055
#             ELSE
#                LET sr1.l_pmdt083 = ''
#                LET sr1.l_pmdt055 = ''
#             END IF
#             #單據性質
#             CALL s_desc_gzcbl004_desc('2060',sr1.l_pmds000) RETURNING sr1.l_pmds000  
             #160328-00011#-mark-(E)
             #狀態碼
             #CALL s_desc_gzcbl004_desc('13',sr1.l_pmdsstus) RETURNING sr1.l_pmdsstus  #151030-00002#2 s983961--mark 效能調整

             EXECUTE insert_prep1 USING sr1.l_pmdt001,sr1.l_pmdt002,sr1.l_pmds000,sr1.l_pmdsdocno,sr1.l_pmdsdocdt,
                                        #160411-00027#6-mod-(S)
#                                        sr1.l_pmdsstus,sr1.l_pmds002,sr1.l_pmds003,
                                        sr1.l_pmdsstus,sr1.l_pmds002,sr1.l_pmds002_desc,sr1.l_pmds003,sr1.l_pmds003_desc,
                                        #160411-00027#6-mod-(E)
                                        sr1.l_pmdtseq,sr1.l_pmdt020,
                                        sr1.l_pmdt019,sr1.l_pmdt022,sr1.l_pmdt021,sr1.l_pmdt024,sr1.l_pmdt023,
                                        #160411-00027#6-mod-(S)
#                                        sr1.l_pmdt016,sr1.l_pmdt017,
                                        sr1.l_pmdt016,sr1.l_pmdt016_ref,sr1.l_pmdt017,sr1.l_pmdt017_ref,
                                        #160411-00027#6-mod-(E)
                                        sr1.l_pmdt018,sr1.l_pmdt083,sr1.l_pmdt055
             IF SQLCA.sqlcode THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = "apmr003_x01_execute1"
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
 
{<section id="apmr003_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION apmr003_x01_rep_data()
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
 
{<section id="apmr003_x01.other_function" readonly="Y" >}

PRIVATE FUNCTION apmr003_x01_nulltozero(p_num)
   DEFINE p_num LIKE type_t.num20_6

   IF cl_null(p_num) THEN
      LET p_num = 0
   END IF

   RETURN p_num
END FUNCTION

 
{</section>}
 
