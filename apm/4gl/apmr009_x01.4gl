#該程式未解開Section, 採用最新樣板產出!
{<section id="apmr009_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:4(2016-06-29 22:04:41), PR版次:0004(2016-07-04 18:52:05)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000060
#+ Filename...: apmr009_x01
#+ Description: ...
#+ Creator....: 05423(2014-11-07 13:57:41)
#+ Modifier...: 02749 -SD/PR- 02749
 
{</section>}
 
{<section id="apmr009_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"

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
       wc STRING                   #where condition
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE l_sql           STRING
#end add-point
 
{</section>}
 
{<section id="apmr009_x01.main" readonly="Y" >}
PUBLIC FUNCTION apmr009_x01(p_arg1)
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
   LET g_rep_code = "apmr009_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL apmr009_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL apmr009_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL apmr009_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL apmr009_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL apmr009_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="apmr009_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION apmr009_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "pmdidocno.pmdi_t.pmdidocno,pmdidocdt.pmdi_t.pmdidocdt,l_pmdistus_desc.type_t.chr30,l_pmdi002_desc.type_t.chr30,l_pmdi003_desc.type_t.chr30,l_pmdi004_desc.type_t.chr50,l_pmdi019_desc.type_t.chr30,l_pmdi005_desc.type_t.chr30,l_pmdi006_desc.type_t.chr30,pmdi007.pmdi_t.pmdi007,pmdi008.pmdi_t.pmdi008,l_pmdi009_desc.type_t.chr30,l_pmdi011_desc.type_t.chr30,pmdi015.pmdi_t.pmdi015,pmdi016.pmdi_t.pmdi016,pmdjseq.pmdj_t.pmdjseq,l_imaa009_desc.type_t.chr30,imaf_t_imaf141.imaf_t.imaf141,pmdj002.pmdj_t.pmdj002,imaal_t_imaal003.imaal_t.imaal003,imaal_t_imaal004.imaal_t.imaal004,pmdj003.pmdj_t.pmdj003,l_pmdj003_desc.type_t.chr30,pmdj031.pmdj_t.pmdj031,l_pmdj031_desc.type_t.chr50,l_pmdj031desc.type_t.chr80,pmdj005.pmdj_t.pmdj005,pmdj008.pmdj_t.pmdj008,pmdj010.pmdj_t.pmdj010,pmdj011.pmdj_t.pmdj011,pmdj030.pmdj_t.pmdj030,l_keys.type_t.chr200,pmdi010.pmdi_t.pmdi010,pmdi012.pmdi_t.pmdi012,pmdi014.pmdi_t.pmdi014,pmdi017.pmdi_t.pmdi017,pmdi018.pmdi_t.pmdi018,pmdi020.pmdi_t.pmdi020,pmdi030.pmdi_t.pmdi030,pmdi031.pmdi_t.pmdi031,pmdi032.pmdi_t.pmdi032,pmdj009.pmdj_t.pmdj009,pmdj012.pmdj_t.pmdj012,pmdj013.pmdj_t.pmdj013,pmdj014.pmdj_t.pmdj014,pmdj015.pmdj_t.pmdj015,pmdj016.pmdj_t.pmdj016,pmdj032.pmdj_t.pmdj032,l_pmdi005_ref.type_t.chr30,l_pmdi006_ref.type_t.chr30,l_pmdi009_ref.type_t.chr30,l_pmdi011_ref.type_t.chr30,l_pmdi019_ref.type_t.chr30,l_pmdj014_desc.type_t.chr30,l_pmdj015_desc.type_t.chr30,l_pmdj016_desc.type_t.chr30,l_pmdj032_desc.type_t.chr30,l_pmdj014desc.type_t.chr50,l_pmdj015desc.type_t.chr50,l_pmdj016desc.type_t.chr50,l_pmdj032desc.type_t.chr50,l_pmdidocno_desc.type_t.chr80,l_pmidstus_desc.type_t.chr30,l_pmdi014_desc.type_t.chr30,l_pmdi017_desc.type_t.chr30,l_pmdi018_desc.type_t.chr30,l_pmdi002_ref.type_t.chr30,l_pmdi003_ref.type_t.chr30,l_pmdi004_ref.type_t.chr30,l_pmdidocnodesc.type_t.chr200,l_pmidstusdesc.type_t.chr50,l_pmdi014desc.type_t.chr50,l_pmdi017desc.type_t.chr50,l_pmdi018desc.type_t.chr50,l_pmdj003desc.type_t.chr200" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   #子報表TEMP TABLE的欄位SQL   
   LET g_sql = "pmdk001.pmdk_t.pmdk001,pmdk002.pmdk_t.pmdk002,pmdk003.pmdk_t.pmdk003,pmdk004.pmdk_t.pmdk004,l_key.type_t.chr200" 
   
   #建立TEMP TABLE,子報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,2) THEN
      LET g_rep_success = 'N'            
   END IF
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="apmr009_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION apmr009_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
         #子報表 PREP
         LET g_sql = " INSERT INTO ",g_rep_db CLIPPED,g_rep_tmpname[2] CLIPPED," VALUES(?,?,?,?,?)"
         PREPARE insert_prep1 FROM g_sql
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
         #end add-point                  
 
 
      END CASE
   END FOR
END FUNCTION
 
{</section>}
 
{<section id="apmr009_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apmr009_x01_sel_prep()
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
   #dorislai-20150730-add----(S)
#   LET g_select = " SELECT DISTINCT pmdidocno,pmdidocdt,pmdistus,NULL,pmdi002,(trim(pmdi_t.pmdi002)||'.'||trim(ooag_t.ooag011)),
#       pmdi003,(trim(pmdi_t.pmdi003)||'.'||trim(ooefl_t.ooefl003)),pmdi004,(trim(pmdi_t.pmdi004)||'.'||trim(pmaal_t.pmaal004)), 
#       pmdi019,NULL,pmdi005,(trim(pmdi_t.pmdi005)||'.'||trim(ooail_t.ooail003)),pmdi006,NULL,",#(trim(pmdi_t.pmdi006)||'.'||trim(oodbl_t.oodbl004)),
#      "pmdi007,pmdi008,pmdi009,(trim(pmdi_t.pmdi009)||'.'||trim(ooibl_t.ooibl004)),pmdi011,NULL,pmdi015,pmdi016, 
#       pmdjseq,imaa_t.imaa009,(trim(imaa_t.imaa009)||'.'||trim(rtaxl_t.rtaxl003)),imaf_t.imaf141,NULL,pmdj002,imaal_t.imaal003,
#       imaal_t.imaal004,pmdj003,NULL,pmdj005,pmdj008,pmdj010,pmdj011,pmdj030,(trim(pmdi_t.pmdidocno)||'-'||trim(pmdi_t.pmdient)||'-'||trim(pmdj_t.pmdjseq)) "
   #151106-00004#5 20151118 mark by beckxie---S
   #LET g_select = " SELECT DISTINCT pmdidocno,pmdidocdt,pmdistus,NULL,pmdi002,(trim(pmdi_t.pmdi002)||'.'||trim(ooag_t.ooag011)),
   #    pmdi003,(trim(pmdi_t.pmdi003)||'.'||trim(ooefl_t.ooefl003)),pmdi004,(trim(pmdi_t.pmdi004)||'.'||trim(pmaal_t.pmaal004)), 
   #    pmdi019,NULL,pmdi005,(trim(pmdi_t.pmdi005)||'.'||trim(ooail_t.ooail003)),pmdi006,NULL,",#(trim(pmdi_t.pmdi006)||'.'||trim(oodbl_t.oodbl004)),
   #   "pmdi007,pmdi008,pmdi009,(trim(pmdi_t.pmdi009)||'.'||trim(ooibl_t.ooibl004)),pmdi011,NULL,pmdi015,pmdi016, 
   #    pmdjseq,imaa_t.imaa009,(trim(imaa_t.imaa009)||'.'||trim(rtaxl_t.rtaxl003)),imaf_t.imaf141,NULL,pmdj002,imaal_t.imaal003,
   #    imaal_t.imaal004,pmdj003,NULL,NULL,NULL,NULL,pmdj005,pmdj008,pmdj010,pmdj011,pmdj030,(trim(pmdi_t.pmdidocno)||'-'||trim(pmdi_t.pmdient)||'-'||trim(pmdj_t.pmdjseq)),
   #    pmdi010,pmdi012,pmdi014,pmdi017,pmdi018,pmdi020,pmdi030,pmdi031,pmdi032,pmdj009,pmdj012,pmdj013,pmdj014,pmdj015,pmdj016,pmdj031,pmdj032,NULL, 
   #    NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 
   #    NULL,NULL,NULL,NULL,NULL,NULL,NULL "
   #151106-00004#5 20151118 mark by beckxie---E
   #151106-00004#5 20151118 add by beckxie---S
   LET g_select = " SELECT DISTINCT pmdidocno,pmdidocdt,pmdistus, ",
                  " CASE WHEN A13.gzcbl004 IS NULL THEN pmdi_t.pmdistus ELSE trim(pmdi_t.pmdistus)||'.'||trim(A13.gzcbl004) END , ",
                  " pmdi002, ",
                  " CASE WHEN A4.ooag011 IS NULL THEN pmdi_t.pmdi002 ELSE (trim(pmdi_t.pmdi002)||'.'||trim(A4.ooag011)) END , ",
                  " pmdi003, ",
                  " CASE WHEN A8.ooefl003 IS NULL THEN pmdi_t.pmdi003 ELSE (trim(pmdi_t.pmdi003)||'.'||trim(A8.ooefl003)) END , ",
                  " pmdi004, ",
                  " CASE WHEN A12.pmaal004 IS NULL THEN pmdi_t.pmdi004 ELSE (trim(pmdi_t.pmdi004)||'.'||trim(A12.pmaal004)) END , ",
                  " pmdi019, ",
                 #160621-00003#6 160629 by lori mark and add---(S) 
                 #" CASE WHEN A14.oocql004 IS NULL THEN pmdi_t.pmdi019 ELSE trim(pmdi_t.pmdi019)||'.'||trim(A14.oocql004) END , ",
                  " CASE WHEN A14.oojdl003 IS NULL THEN pmdi_t.pmdi019 ELSE trim(pmdi_t.pmdi019)||'.'||trim(A14.oojdl004) END , ",
                 #160621-00003#6 160629 by lori mark and add---(S)               
                  " pmdi005, ",
                  " CASE WHEN A9.ooail003 IS NULL THEN pmdi_t.pmdi005 ELSE (trim(pmdi_t.pmdi005)||'.'||trim(A9.ooail003)) END , ",
                  " pmdi006, ",
                  " CASE WHEN A15.oodbl004 IS NULL THEN pmdi_t.pmdi006 ELSE (trim(pmdi_t.pmdi006)||'.'||trim(A15.oodbl004)) END , ",
                  " pmdi007/100,pmdi008,pmdi009, ",
                  " CASE WHEN A11.ooibl004 IS NULL THEN pmdi_t.pmdi009 ELSE (trim(pmdi_t.pmdi009)||'.'||trim(A11.ooibl004)) END , ",
                  " pmdi011, ",
                  " CASE WHEN A16.oocql004 IS NULL THEN pmdi_t.pmdi011 ELSE (trim(pmdi_t.pmdi011)||'.'||trim(A16.oocql004)) END , ",
                  " pmdi015,pmdi016, ",
                  " A1.pmdjseq,A2.imaa009, ",
                  " CASE WHEN A7.rtaxl003 IS NULL THEN A2.imaa009 ELSE (trim(A2.imaa009)||'.'||trim(A7.rtaxl003)) END , ",
                  " A3.imaf141, ",
                  " CASE WHEN A17.oocql004 IS NULL THEN A3.imaf141 ELSE (trim(A3.imaf141)||'.'||trim(A17.oocql004)) END , ",
                  " A1.pmdj002,A6.imaal003, ",
                  " A6.imaal004,A1.pmdj003,NULL,A2.imaa127,A18.oocql004, ",
                  " CASE WHEN A18.oocql004 IS NULL THEN A2.imaa127 ELSE (trim(A2.imaa127)||'.'||trim(A18.oocql004)) END , ",
                  " A1.pmdj005,A1.pmdj008,A1.pmdj010,A1.pmdj011,A1.pmdj030, ",
                  " (trim(pmdi_t.pmdidocno)||'-'||trim(pmdi_t.pmdient)||'-'||trim(A1.pmdjseq)), ",
                  " pmdi010,pmdi012,pmdi014,pmdi017,pmdi018,pmdi020,pmdi030,pmdi031,pmdi032,A1.pmdj009,A1.pmdj012/100,A1.pmdj013,A1.pmdj014,A1.pmdj015,A1.pmdj016,A1.pmdj032,A9.ooail003, ",
                 #160621-00003#6 160629 by lori mark and add---(S) 
                 #" A10.oodbl004,A11.ooibl004,A16.oocql004,A14.oocql004,A19.oocql004,A20.oocql004,A21.oodbl004,A22.rtaxl003, ",
                  " A10.oodbl004,A11.ooibl004,A16.oocql004,A14.oojdl003,A19.oocql004,A20.oocql004,A21.oodbl004,A22.rtaxl003, ",
                 #160621-00003#6 160629 by lori mark and add---(S) 
                  " CASE WHEN A19.oocql004 IS NULL THEN A1.pmdj014 ELSE (trim(A1.pmdj014)||'.'||trim(A19.oocql004)) END , ",
                  " CASE WHEN A20.oocql004 IS NULL THEN A1.pmdj015 ELSE (trim(A1.pmdj015)||'.'||trim(A20.oocql004)) END , ",
                  " CASE WHEN A21.oodbl004 IS NULL THEN A1.pmdj016 ELSE (trim(A1.pmdj016)||'.'||trim(A21.oodbl004)) END , ",
                  " CASE WHEN A22.rtaxl003 IS NULL THEN A1.pmdj032 ELSE (trim(A1.pmdj032)||'.'||trim(A22.rtaxl003)) END , ",
                  " NULL,A13.gzcbl004,A23.gzcbl004,A24.gzcbl004,A25.gzcbl004,A4.ooag011,A8.ooefl003,A12.pmaal004, ",
                  " NULL, ",
                  " CASE WHEN A13.gzcbl004 IS NULL THEN pmdi_t.pmdistus ELSE trim(pmdi_t.pmdistus)||'.'||trim(A13.gzcbl004) END , ",
                  " CASE WHEN A23.gzcbl004 IS NULL THEN pmdi_t.pmdi014 ELSE trim(pmdi_t.pmdi014)||'.'||trim(A23.gzcbl004) END , ",
                  " CASE WHEN A24.gzcbl004 IS NULL THEN pmdi_t.pmdi017 ELSE trim(pmdi_t.pmdi017)||'.'||trim(A24.gzcbl004) END , ",
                  " CASE WHEN A25.gzcbl004 IS NULL THEN pmdi_t.pmdi018 ELSE trim(pmdi_t.pmdi018)||'.'||trim(A25.gzcbl004) END , ",
                  " NULL"
   #151106-00004#5 20151118 add by beckxie---E
   #dorislai-20150730-add----(E)
#   #end add-point
#   LET g_select = " SELECT pmdidocno,pmdidocdt,pmdistus,NULL,pmdi002,NULL,pmdi003,NULL,pmdi004,NULL, 
#       pmdi019,NULL,pmdi005,NULL,pmdi006,NULL,pmdi007,pmdi008,pmdi009,NULL,pmdi011,NULL,pmdi015,pmdi016, 
#       pmdjseq,imaa_t.imaa009,NULL,imaf_t.imaf141,NULL,pmdj002,imaal_t.imaal003,imaal_t.imaal004,pmdj003, 
#       NULL,pmdj031,NULL,NULL,pmdj005,pmdj008,pmdj010,pmdj011,pmdj030,NULL,pmdi010,pmdi012,pmdi014,pmdi017, 
#       pmdi018,pmdi020,pmdi030,pmdi031,pmdi032,pmdj009,pmdj012,pmdj013,pmdj014,pmdj015,pmdj016,pmdj032, 
#       NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 
#       NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   #151106-00004#5 20151118 mark by beckxie---S
   #LET g_from = " FROM pmdi_t LEFT OUTER JOIN pmdj_t ON pmdient = pmdjent AND pmdidocno = pmdjdocno ",
   #             "             LEFT OUTER JOIN imaa_t ON pmdjent = imaaent AND pmdj002 = imaa001 ",
   #             "             LEFT OUTER JOIN imaf_t ON pmdjent = imafent AND pmdj002 = imaf001 AND pmdjsite = imafsite ",
   #             "             LEFT OUTER JOIN ooag_t ON pmdi002 = ooag001 AND pmdient = ooagent ",
   #             "             LEFT OUTER JOIN ooef_t ON pmdi003 = ooef001 AND pmdient = ooefent ",
   #             "             LEFT OUTER JOIN imaal_t ON pmdj002 = imaal001 AND pmdjent = imaalent AND imaal002 = '",g_dlang CLIPPED,"' ",
   #             "             LEFT OUTER JOIN rtaxl_t ON imaa009 = rtaxl001 AND imaaent = rtaxlent AND rtaxl002 = '",g_dlang CLIPPED,"' ",
   #             "             LEFT OUTER JOIN ooefl_t ON pmdi003 = ooefl001 AND pmdient = ooeflent AND ooefl002 = '",g_dlang CLIPPED,"' ",
   #             "             LEFT OUTER JOIN ooail_t ON pmdi005 = ooail001 AND pmdient = ooailent AND ooail002 = '",g_dlang CLIPPED,"' ",
   #             "             LEFT OUTER JOIN oodbl_t ON pmdi006 = oodbl002 AND pmdient = oodblent AND oodbl001 = ooef019 AND oodbl003 = '",g_dlang CLIPPED,"' ",
   #             "             LEFT OUTER JOIN ooibl_t ON pmdi009 = ooibl002 AND pmdient = ooiblent AND ooibl003 = '",g_dlang CLIPPED,"' ",
   #             "             LEFT OUTER JOIN pmaal_t ON pmdi004 = pmaal001 AND pmdient = pmaalent AND pmaal002 = '",g_dlang CLIPPED,"' "
   #151106-00004#5 20151118 mark by beckxie---E
   #151106-00004#5 20151118 add by beckxie---S
   LET g_from = " FROM pmdi_t ",
                "LEFT OUTER JOIN pmdj_t A1 ON pmdient = A1.pmdjent AND pmdidocno = A1.pmdjdocno ",
                "LEFT OUTER JOIN imaa_t A2 ON A1.pmdjent = A2.imaaent AND A1.pmdj002 = A2.imaa001 ",
                "LEFT OUTER JOIN imaf_t A3 ON A1.pmdjent = A3.imafent AND A1.pmdj002 = A3.imaf001 AND A1.pmdjsite = A3.imafsite ",
                "LEFT OUTER JOIN ooag_t A4 ON pmdient = A4.ooagent AND pmdi002 = A4.ooag001 ",
                "LEFT OUTER JOIN ooef_t A5 ON pmdient = A5.ooefent AND pmdi003 = A5.ooef001 ",
                "LEFT OUTER JOIN imaal_t A6 ON A1.pmdjent = A6.imaalent AND A1.pmdj002 = A6.imaal001 AND A6.imaal002 = '",g_dlang,"' ",
                "LEFT OUTER JOIN rtaxl_t A7 ON A2.imaaent = A7.rtaxlent AND A2.imaa009 = A7.rtaxl001 AND A7.rtaxl002 = '",g_dlang,"' ",
                "LEFT OUTER JOIN ooefl_t A8 ON pmdient = A8.ooeflent AND pmdi003 = A8.ooefl001 AND A8.ooefl002 = '",g_dlang,"' ",
                "LEFT OUTER JOIN ooail_t A9 ON pmdient = A9.ooailent AND pmdi005 = A9.ooail001 AND A9.ooail002 = '",g_dlang,"' ",
                "LEFT OUTER JOIN oodbl_t A10 ON pmdient = A10.oodblent AND pmdi006 = A10.oodbl002 AND A10.oodbl001 = A5.ooef019 AND A10.oodbl003 = '",g_dlang,"' ",
                "LEFT OUTER JOIN ooibl_t A11 ON pmdient = A11.ooiblent AND pmdi009 = A11.ooibl002 AND A11.ooibl003 = '",g_dlang,"' ",
                "LEFT OUTER JOIN pmaal_t A12 ON pmdient = A12.pmaalent AND pmdi004 = A12.pmaal001 AND A12.pmaal002 = '",g_dlang,"' ",
                "LEFT OUTER JOIN gzcbl_t A13 ON A13.gzcbl002 = pmdistus AND A13.gzcbl001 = '13' AND A13.gzcbl003 = '",g_dlang,"' ",
               #160621-00003#6 160629 by lori mark and add---(S)
               #"LEFT OUTER JOIN oocql_t A14 ON A14.oocqlent = ",g_enterprise," AND A14.oocql001 = '275' AND A14.oocql002 = pmdi019 AND A14.oocql003 = '",g_dlang,"' ",
                "LEFT OUTER JOIN oojdl_t A14 ON A14.oojdlent = ",g_enterprise," AND A14.oojdl001 = pmdi019 AND A14.oojdl002 = '",g_dlang,"' ",
               #160621-00003#6 160629 by lori mark and add---(E) 
                "LEFT OUTER JOIN oodbl_t A15 ON A15.oodblent=",g_enterprise," AND A15.oodbl001=A5.ooef019 AND A15.oodbl002=pmdi006 AND A15.oodbl003='",g_dlang,"' ",
                "LEFT OUTER JOIN oocql_t A16 ON A16.oocqlent = ",g_enterprise," AND A16.oocql001 = '238' AND A16.oocql002 = pmdi011 AND A16.oocql003 = '",g_dlang,"' ",
                "LEFT OUTER JOIN oocql_t A17 ON A17.oocqlent = ",g_enterprise," AND A17.oocql001 = '203' AND A17.oocql002 = A3.imaf141 AND A17.oocql003 = '",g_dlang,"' ",
                "LEFT OUTER JOIN oocql_t A18 ON A18.oocqlent = ",g_enterprise," AND A18.oocql001 = '2003' AND A18.oocql002 = A2.imaa127 AND A18.oocql003 = '",g_dlang,"' ",
                "LEFT OUTER JOIN oocql_t A19 ON A19.oocqlent = ",g_enterprise," AND A19.oocql001 = '263' AND A19.oocql002 = A1.pmdj014 AND A19.oocql003 = '",g_dlang,"' ",
                "LEFT OUTER JOIN oocql_t A20 ON A20.oocqlent = ",g_enterprise," AND A20.oocql001 = '268' AND A20.oocql002 = A1.pmdj015 AND A20.oocql003 = '",g_dlang,"' ",
                "LEFT OUTER JOIN oodbl_t A21 ON A21.oodblent = ",g_enterprise," AND A21.oodbl001=A5.ooef019 AND A21.oodbl002 = A1.pmdj016 AND A21.oodbl003 = '",g_dlang,"' ",
                "LEFT OUTER JOIN rtaxl_t A22 ON A22.rtaxlent = ",g_enterprise," AND A22.rtaxl001 = A1.pmdj032 AND A22.rtaxl002 = '",g_dlang,"' ",
                "LEFT OUTER JOIN gzcbl_t A23 ON A23.gzcbl001 = '2039' AND A23.gzcbl002 = pmdi014 AND A23.gzcbl003 = '",g_dlang,"' ",
                "LEFT OUTER JOIN gzcbl_t A24 ON A24.gzcbl001 = '2041' AND A24.gzcbl002 = pmdi017 AND A24.gzcbl003 = '",g_dlang,"' ",
                "LEFT OUTER JOIN gzcbl_t A25 ON A25.gzcbl001 = '2042' AND A25.gzcbl002 = pmdi018 AND A25.gzcbl003 = '",g_dlang,"' "
   #151106-00004#5 20151118 add by beckxie---E
#   #end add-point
#    LET g_from = " FROM pmdi_t,pmdj_t,imaa_t,imaal_t,imaf_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("pmdi_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   DISPLAY "g_sql:",g_sql
   #end add-point
   PREPARE apmr009_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE apmr009_x01_curs CURSOR FOR apmr009_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="apmr009_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION apmr009_x01_ins_data()
DEFINE sr RECORD 
   pmdidocno LIKE pmdi_t.pmdidocno, 
   pmdidocdt LIKE pmdi_t.pmdidocdt, 
   pmdistus LIKE pmdi_t.pmdistus, 
   l_pmdistus_desc LIKE type_t.chr30, 
   pmdi002 LIKE pmdi_t.pmdi002, 
   l_pmdi002_desc LIKE type_t.chr30, 
   pmdi003 LIKE pmdi_t.pmdi003, 
   l_pmdi003_desc LIKE type_t.chr30, 
   pmdi004 LIKE pmdi_t.pmdi004, 
   l_pmdi004_desc LIKE type_t.chr50, 
   pmdi019 LIKE pmdi_t.pmdi019, 
   l_pmdi019_desc LIKE type_t.chr30, 
   pmdi005 LIKE pmdi_t.pmdi005, 
   l_pmdi005_desc LIKE type_t.chr30, 
   pmdi006 LIKE pmdi_t.pmdi006, 
   l_pmdi006_desc LIKE type_t.chr30, 
   pmdi007 LIKE pmdi_t.pmdi007, 
   pmdi008 LIKE pmdi_t.pmdi008, 
   pmdi009 LIKE pmdi_t.pmdi009, 
   l_pmdi009_desc LIKE type_t.chr30, 
   pmdi011 LIKE pmdi_t.pmdi011, 
   l_pmdi011_desc LIKE type_t.chr30, 
   pmdi015 LIKE pmdi_t.pmdi015, 
   pmdi016 LIKE pmdi_t.pmdi016, 
   pmdjseq LIKE pmdj_t.pmdjseq, 
   imaa_t_imaa009 LIKE imaa_t.imaa009, 
   l_imaa009_desc LIKE type_t.chr30, 
   imaf_t_imaf141 LIKE imaf_t.imaf141, 
   l_imaf141_desc LIKE type_t.chr30, 
   pmdj002 LIKE pmdj_t.pmdj002, 
   imaal_t_imaal003 LIKE imaal_t.imaal003, 
   imaal_t_imaal004 LIKE imaal_t.imaal004, 
   pmdj003 LIKE pmdj_t.pmdj003, 
   l_pmdj003_desc LIKE type_t.chr30, 
   pmdj031 LIKE pmdj_t.pmdj031, 
   l_pmdj031_desc LIKE type_t.chr50, 
   l_pmdj031desc LIKE type_t.chr80, 
   pmdj005 LIKE pmdj_t.pmdj005, 
   pmdj008 LIKE pmdj_t.pmdj008, 
   pmdj010 LIKE pmdj_t.pmdj010, 
   pmdj011 LIKE pmdj_t.pmdj011, 
   pmdj030 LIKE pmdj_t.pmdj030, 
   l_keys LIKE type_t.chr200, 
   pmdi010 LIKE pmdi_t.pmdi010, 
   pmdi012 LIKE pmdi_t.pmdi012, 
   pmdi014 LIKE pmdi_t.pmdi014, 
   pmdi017 LIKE pmdi_t.pmdi017, 
   pmdi018 LIKE pmdi_t.pmdi018, 
   pmdi020 LIKE pmdi_t.pmdi020, 
   pmdi030 LIKE pmdi_t.pmdi030, 
   pmdi031 LIKE pmdi_t.pmdi031, 
   pmdi032 LIKE pmdi_t.pmdi032, 
   pmdj009 LIKE pmdj_t.pmdj009, 
   pmdj012 LIKE pmdj_t.pmdj012, 
   pmdj013 LIKE pmdj_t.pmdj013, 
   pmdj014 LIKE pmdj_t.pmdj014, 
   pmdj015 LIKE pmdj_t.pmdj015, 
   pmdj016 LIKE pmdj_t.pmdj016, 
   pmdj032 LIKE pmdj_t.pmdj032, 
   l_pmdi005_ref LIKE type_t.chr30, 
   l_pmdi006_ref LIKE type_t.chr30, 
   l_pmdi009_ref LIKE type_t.chr30, 
   l_pmdi011_ref LIKE type_t.chr30, 
   l_pmdi019_ref LIKE type_t.chr30, 
   l_pmdj014_desc LIKE type_t.chr30, 
   l_pmdj015_desc LIKE type_t.chr30, 
   l_pmdj016_desc LIKE type_t.chr30, 
   l_pmdj032_desc LIKE type_t.chr30, 
   l_pmdj014desc LIKE type_t.chr50, 
   l_pmdj015desc LIKE type_t.chr50, 
   l_pmdj016desc LIKE type_t.chr50, 
   l_pmdj032desc LIKE type_t.chr50, 
   l_pmdidocno_desc LIKE type_t.chr80, 
   l_pmidstus_desc LIKE type_t.chr30, 
   l_pmdi014_desc LIKE type_t.chr30, 
   l_pmdi017_desc LIKE type_t.chr30, 
   l_pmdi018_desc LIKE type_t.chr30, 
   l_pmdi002_ref LIKE type_t.chr30, 
   l_pmdi003_ref LIKE type_t.chr30, 
   l_pmdi004_ref LIKE type_t.chr30, 
   l_pmdidocnodesc LIKE type_t.chr200, 
   l_pmidstusdesc LIKE type_t.chr50, 
   l_pmdi014desc LIKE type_t.chr50, 
   l_pmdi017desc LIKE type_t.chr50, 
   l_pmdi018desc LIKE type_t.chr50, 
   l_pmdj003desc LIKE type_t.chr200
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE sr1 RECORD
   pmdk001  LIKE pmdk_t.pmdk001,
   pmdk002  LIKE pmdk_t.pmdk002,
   pmdk003  LIKE pmdk_t.pmdk003,
   pmdk004  LIKE pmdk_t.pmdk004,
   l_key LIKE type_t.chr200
END RECORD
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列

DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列


DEFINE   l_success  LIKE   type_t.num5     #20150730 by dorislai add   
DEFINE   l_imaa127  LIKE  imaa_t.imaa127   #20150730 by dorislai add
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH apmr009_x01_curs INTO sr.*                               
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
       #151106-00004#5 20151118 mark by beckxie---S
       #IF NOT cl_null(sr.pmdistus) THEN
       #  CALL apmr009_x01_desc('1','13',sr.pmdistus) RETURNING sr.l_pmdistus_desc
       #  LET sr.l_pmdistus_desc = sr.pmdistus CLIPPED ,':',sr.l_pmdistus_desc CLIPPED
       #END IF
       #IF NOT cl_null(sr.pmdi019) THEN
       #  CALL apmr009_x01_desc('2','275',sr.pmdi019) RETURNING sr.l_pmdi019_desc
       #  LET sr.l_pmdi019_desc = sr.pmdi019 CLIPPED ,'.',sr.l_pmdi019_desc CLIPPED
       #END IF
       #IF NOT cl_null(sr.pmdi011) THEN
       #  CALL apmr009_x01_desc('2','238',sr.pmdi011) RETURNING sr.l_pmdi011_desc
       #  LET sr.l_pmdi011_desc = sr.pmdi011 CLIPPED ,'.',sr.l_pmdi011_desc CLIPPED
       #END IF
       #IF NOT cl_null(sr.imaf_t_imaf141) THEN
       #  CALL apmr009_x01_desc('2','203',sr.imaf_t_imaf141) RETURNING sr.l_imaf141_desc
       #  LET sr.l_imaf141_desc = sr.imaf_t_imaf141 CLIPPED ,'.',sr.l_imaf141_desc CLIPPED
       #END IF
       #LET g_ref_fields[1] = sr.pmdi006
       #CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl002=? AND oodbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
       #LET sr.l_pmdi006_desc = g_rtn_fields[1]
       #LET sr.l_pmdi006_desc = sr.pmdi006 CLIPPED ,'.',sr.l_pmdi006_desc
       #151106-00004#5 20151118 mark by beckxie---E
       IF cl_null(sr.pmdi002) THEN LET sr.l_pmdi002_desc = NULL END IF
       IF cl_null(sr.pmdi003) THEN LET sr.l_pmdi003_desc = NULL END IF
       IF cl_null(sr.pmdi004) THEN LET sr.l_pmdi004_desc = NULL END IF
       IF cl_null(sr.pmdi005) THEN LET sr.l_pmdi005_desc = NULL END IF
       IF cl_null(sr.pmdi006) THEN LET sr.l_pmdi006_desc = NULL END IF
       IF cl_null(sr.pmdi009) THEN LET sr.l_pmdi009_desc = NULL END IF
       IF cl_null(sr.imaa_t_imaa009) THEN LET sr.l_imaa009_desc = NULL END IF
       
       
       LET l_sql = " SELECT UNIQUE pmdk001,pmdk002,pmdk003,pmdk004,(trim(pmdk_t.pmdkdocno)||'-'||(trim(pmdk_t.pmdkent)||'-'||trim(pmdk_t.pmdkseq))) ",
                   " FROM pmdk_t ",
                   " WHERE pmdkent = '",g_enterprise CLIPPED,"'  AND pmdkdocno = '",sr.pmdidocno CLIPPED,"'  AND pmdkseq = '", sr.pmdjseq CLIPPED,"' "

             
      PREPARE apmr009_x01_prepare2 FROM l_sql
      IF STATUS THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'prepare:'
         LET g_errparam.code   = STATUS
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET g_rep_success = 'N' 
      END IF
      DECLARE apmr009_x01_curs2 CURSOR FOR apmr009_x01_prepare2
      FOREACH apmr009_x01_curs2 INTO sr1.*                               
          IF STATUS THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.extend = 'foreach:'
             LET g_errparam.code   = STATUS
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             LET g_rep_success = 'N'
             EXIT FOREACH
          END IF 
          
      #子報表EXECUTE
         EXECUTE insert_prep1 USING sr1.pmdk001,sr1.pmdk002,sr1.pmdk003,sr1.pmdk004,sr1.l_key
 
         IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.extend = "apmr009_x01_subrep01_execute"
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.popup  = FALSE
             CALL cl_err()       
             LET g_rep_success = 'N'
             EXIT FOREACH
         END IF
       END FOREACH 
       
       #dorislai-20150730-add----(S)
       #核價單號全名 l_pmdidocnodesc 
       LET sr.l_pmdidocno_desc = ''
       LET sr.l_pmdidocnodesc = ''
       CALL s_aooi200_get_slip_desc(sr.pmdidocno) RETURNING sr.l_pmdidocno_desc
       IF NOT cl_null(sr.l_pmdidocno_desc) THEN
          LET sr.l_pmdidocnodesc = sr.pmdidocno,'.',sr.l_pmdidocno_desc
       END IF
       #151106-00004#5 20151118 mark by beckxie---S
       ##狀態碼全名 l_pmidstusdesc 
       #LET sr.l_pmidstus_desc = ''
       #LET sr.l_pmidstusdesc = ''
       #CALL s_desc_gzcbl004_desc('13',sr.pmdistus) RETURNING sr.l_pmidstus_desc
       #IF NOT cl_null(sr.l_pmidstus_desc) THEN
       #   LET sr.l_pmidstusdesc = sr.pmdistus,'.',sr.l_pmidstus_desc
       #END IF
       ##申請人員全名 l_pmdi002_ref 
       #LET sr.l_pmdi002_ref = ''
       #SELECT ooag011 INTO sr.l_pmdi002_ref FROM ooag_t 
       # WHERE ooagent = g_enterprise AND ooag001 = sr.pmdi002 
       ##申請部門全名 l_pmdi003_ref 
       #LET sr.l_pmdi003_ref = ''
       #SELECT ooefl003 INTO sr.l_pmdi003_ref FROM ooefl_t 
       # WHERE ooeflent = g_enterprise AND ooefl001 = sr.pmdi003 AND ooefl002 = g_dlang
       ##供應商全名 l_pmdi004_ref 
       #LET sr.l_pmdi004_ref = ''
       #SELECT pmaal004 INTO sr.l_pmdi004_ref FROM pmaal_t 
       # WHERE pmaalent = g_enterprise AND pmaal001 = sr.pmdi004 AND pmaal002 = g_dlang
       ##核價內容全名 l_pmdi014desc 
       #LET sr.l_pmdi014_desc = ''
       #LET sr.l_pmdi014desc = ''
       #CALL s_desc_gzcbl004_desc('2039',sr.pmdi014) RETURNING sr.l_pmdi014_desc
       #IF NOT cl_null(sr.l_pmdi014_desc) THEN
       #   LET sr.l_pmdi014desc = sr.pmdi014,'.',sr.l_pmdi014_desc
       #END IF
       ##核價對象管制全名 l_pmdi017desc 
       #LET sr.l_pmdi017_desc = ''
       #LET sr.l_pmdi017desc = ''
       #CALL s_desc_gzcbl004_desc('2041',sr.pmdi017) RETURNING sr.l_pmdi017_desc
       #IF NOT cl_null(sr.l_pmdi017_desc) THEN
       #   LET sr.l_pmdi017desc = sr.pmdi017,'.',sr.l_pmdi017_desc
       #END IF
       ##核價使用管制全名 l_pmdi018desc 
       #LET sr.l_pmdi018_desc = ''
       #LET sr.l_pmdi018desc = ''
       #CALL s_desc_gzcbl004_desc('2042',sr.pmdi018) RETURNING sr.l_pmdi018_desc
       #IF NOT cl_null(sr.l_pmdi018_desc) THEN
       #   LET sr.l_pmdi018desc = sr.pmdi018,'.',sr.l_pmdi018_desc
       #END IF 
       ##幣別說明
       #LET sr.l_pmdi005_ref = ''
       #SELECT ooail003 INTO sr.l_pmdi005_ref FROM ooail_t 
       # WHERE ooailent = g_enterprise AND ooail001 = sr.pmdi005 AND ooail002 = g_dlang
       ##稅別說明
       #LET sr.l_pmdi006_ref = ''
       #SELECT oodbl004 INTO sr.l_pmdi006_ref 
       #  FROM oodbl_t WHERE oodblent = g_enterprise 
       #   AND oodbl002 = sr.pmdi006 AND oodbl003 = g_dlang
       ##付款條件說明 
       #LET sr.l_pmdi009_ref = ''
       #SELECT ooibl004 INTO sr.l_pmdi009_ref FROM ooibl_t 
       # WHERE ooiblent = g_enterprise AND ooibl002 = sr.pmdi009 AND ooibl003 = g_dlang
       ##交易條件說明
       #LET sr.l_pmdi011_ref = ''
       #SELECT oocql004 INTO sr.l_pmdi011_ref FROM oocql_t 
       # WHERE oocqlent = g_enterprise AND oocql001 = '238' 
       #   AND oocql002 = sr.pmdi011 AND oocql003 = g_dlang
       ##採購通路說明
       #LET sr.l_pmdi019_ref = ''
       #CALL s_desc_get_acc_desc('275',sr.pmdi019) RETURNING sr.l_pmdi019_ref
       #151106-00004#5 20151118 mark by beckxie---E
       #產品特徵說明
       LET sr.l_pmdj003_desc = ''
       LET sr.l_pmdj003desc = ''
       CALL s_feature_description(sr.pmdj002,sr.pmdj003) RETURNING l_success,sr.l_pmdj003_desc
       IF NOT cl_null(sr.l_pmdj003_desc) THEN
          LET sr.l_pmdj003desc = sr.pmdj003,'.',sr.l_pmdj003_desc
       END IF
       #151106-00004#5 20151118 mark by beckxie---S
       ##運輸方式說明	
       #LET sr.l_pmdj014_desc = ''
       #LET sr.l_pmdj014desc = ''
       #SELECT oocql004 INTO sr.l_pmdj014_desc FROM oocql_t 
       # WHERE oocqlent = g_enterprise AND oocql001 = '263' 
       #   AND oocql002 = sr.pmdj014 AND oocql003 = g_dlang
       #IF NOT cl_null(sr.l_pmdj014_desc) THEN
       #   LET sr.l_pmdj014desc = sr.pmdj014,'.',sr.l_pmdj014_desc
       #END IF
       ##理由碼說明	 
       #LET sr.l_pmdj015_desc = ''
       #LET sr.l_pmdj015desc = ''
       #SELECT oocql004 INTO sr.l_pmdj015_desc FROM oocql_t 
       # WHERE oocqlent = g_enterprise AND oocql001 = '268' 
       #   AND oocql002 = sr.pmdj015 AND oocql003 = g_dlang
       #IF NOT cl_null(sr.l_pmdj015_desc) THEN
       #   LET sr.l_pmdj015desc = sr.pmdj015,'.',sr.l_pmdj015_desc
       #END IF
       ##稅別說明	
       #LET sr.l_pmdj016_desc = ''
       #LET sr.l_pmdj016desc = ''
       #SELECT oodbl004 INTO sr.l_pmdj016_desc FROM oodbl_t 
       # WHERE oodblent = g_enterprise AND oodbl002 = sr.pmdj016 AND oodbl003 = g_dlang
       #IF NOT cl_null(sr.l_pmdj016_desc) THEN
       #   LET sr.l_pmdj016desc = sr.pmdj016,'.',sr.l_pmdj016_desc
       #END IF
       ##系列說明	
       #LET sr.l_pmdj031_desc = ''
       #LET sr.l_pmdj031desc = ''
       #SELECT oocql004 INTO sr.l_pmdj031_desc FROM oocql_t 
       # WHERE oocqlent = g_enterprise AND oocql001 = '2003' 
       #   AND oocql002 = sr.pmdj031 AND oocql003 = g_dlang
       #IF NOT cl_null(sr.l_pmdj031_desc) THEN
       #   LET sr.l_pmdj031desc = sr.pmdj031,'.',sr.l_pmdj031_desc
       #END IF
       ##產品分類說明	
       #LET sr.l_pmdj032_desc = ''
       #LET sr.l_pmdj032desc = ''
       #SELECT rtaxl003 INTO sr.l_pmdj032_desc FROM rtaxl_t 
       # WHERE rtaxlent = g_enterprise AND rtaxl001 = sr.pmdj032 AND rtaxl002 = g_dlang
       #IF NOT cl_null(sr.l_pmdj032_desc) THEN
       #   LET sr.l_pmdj032desc = sr.pmdj032,'.',sr.l_pmdj032_desc
       #END IF
       ##系列
       ##----若為空，用料號抓系列
       #IF cl_null(sr.pmdj031) THEN
       #   SELECT imaa127 INTO sr.pmdj031 FROM imaa_t
       #    WHERE imaa001 = sr.pmdj002
       #      AND imaaent = g_enterprise
       #END IF
       ##----抓取系列說明
       #CALL s_desc_get_acc_desc('2003',sr.pmdj031)  RETURNING sr.l_pmdj031_desc   
       #IF NOT cl_null(sr.l_pmdj031_desc) THEN
       #   LET sr.l_pmdj031desc = sr.pmdj031,'.',sr.l_pmdj031_desc
       #ELSE
       #   LET sr.l_pmdj031desc = ''
       #END IF
       # 
       ##dorislai-20150730-add----(E)
       #151106-00004#5 20151118 mark by beckxie---E
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.pmdidocno,sr.pmdidocdt,sr.l_pmdistus_desc,sr.l_pmdi002_desc,sr.l_pmdi003_desc,sr.l_pmdi004_desc,sr.l_pmdi019_desc,sr.l_pmdi005_desc,sr.l_pmdi006_desc,sr.pmdi007,sr.pmdi008,sr.l_pmdi009_desc,sr.l_pmdi011_desc,sr.pmdi015,sr.pmdi016,sr.pmdjseq,sr.l_imaa009_desc,sr.imaf_t_imaf141,sr.pmdj002,sr.imaal_t_imaal003,sr.imaal_t_imaal004,sr.pmdj003,sr.l_pmdj003_desc,sr.pmdj031,sr.l_pmdj031_desc,sr.l_pmdj031desc,sr.pmdj005,sr.pmdj008,sr.pmdj010,sr.pmdj011,sr.pmdj030,sr.l_keys,sr.pmdi010,sr.pmdi012,sr.pmdi014,sr.pmdi017,sr.pmdi018,sr.pmdi020,sr.pmdi030,sr.pmdi031,sr.pmdi032,sr.pmdj009,sr.pmdj012,sr.pmdj013,sr.pmdj014,sr.pmdj015,sr.pmdj016,sr.pmdj032,sr.l_pmdi005_ref,sr.l_pmdi006_ref,sr.l_pmdi009_ref,sr.l_pmdi011_ref,sr.l_pmdi019_ref,sr.l_pmdj014_desc,sr.l_pmdj015_desc,sr.l_pmdj016_desc,sr.l_pmdj032_desc,sr.l_pmdj014desc,sr.l_pmdj015desc,sr.l_pmdj016desc,sr.l_pmdj032desc,sr.l_pmdidocno_desc,sr.l_pmidstus_desc,sr.l_pmdi014_desc,sr.l_pmdi017_desc,sr.l_pmdi018_desc,sr.l_pmdi002_ref,sr.l_pmdi003_ref,sr.l_pmdi004_ref,sr.l_pmdidocnodesc,sr.l_pmidstusdesc,sr.l_pmdi014desc,sr.l_pmdi017desc,sr.l_pmdi018desc,sr.l_pmdj003desc
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "apmr009_x01_execute"
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
 
{<section id="apmr009_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION apmr009_x01_rep_data()
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
 
{<section id="apmr009_x01.other_function" readonly="Y" >}

PRIVATE FUNCTION apmr009_x01_desc(p_class,p_num,p_target)
   DEFINE p_class  LIKE type_t.chr2
   DEFINE p_num    LIKE type_t.num5
   DEFINE p_target LIKE type_t.chr10
   DEFINE r_desc   LIKE type_t.chr500

   CASE p_class
   WHEN '1'
      SELECT gzcbl004 INTO r_desc
      FROM gzcbl_t
      WHERE gzcbl001 = p_num
      AND gzcbl002 = p_target
      AND gzcbl003 = g_dlang

   WHEN '2'
      SELECT oocql004 INTO r_desc
      FROM oocql_t
      WHERE oocql001 = p_num
      AND oocql002 = p_target
      AND oocql003 = g_dlang
      AND oocqlent = g_enterprise
   END CASE
      
   RETURN r_desc 
END FUNCTION

 
{</section>}
 
