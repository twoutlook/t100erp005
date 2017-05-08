#該程式未解開Section, 採用最新樣板產出!
{<section id="abmr302_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2016-09-05 13:36:12), PR版次:0003(2016-09-06 14:21:12)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000067
#+ Filename...: abmr302_x01
#+ Description: ...
#+ Creator....: 05384(2014-08-27 16:23:56)
#+ Modifier...: 08734 -SD/PR- 08734
 
{</section>}
 
{<section id="abmr302_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#160905-00007#1   2016-09-05  By08734        ent调整
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
       a1 LIKE type_t.chr1,         #列印庫存 
       a2 LIKE type_t.chr1,         #列印請購單 
       a3 LIKE type_t.chr1,         #列印採購單 
       a4 LIKE type_t.chr1,         #列印收貨單 
       a5 LIKE type_t.chr1,         #列印工單 
       a6 LIKE type_t.chr1          #印成或半成品
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="abmr302_x01.main" readonly="Y" >}
PUBLIC FUNCTION abmr302_x01(p_arg1,p_arg2,p_arg3,p_arg4,p_arg5,p_arg6,p_arg7)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr1         #tm.a1  列印庫存 
DEFINE  p_arg3 LIKE type_t.chr1         #tm.a2  列印請購單 
DEFINE  p_arg4 LIKE type_t.chr1         #tm.a3  列印採購單 
DEFINE  p_arg5 LIKE type_t.chr1         #tm.a4  列印收貨單 
DEFINE  p_arg6 LIKE type_t.chr1         #tm.a5  列印工單 
DEFINE  p_arg7 LIKE type_t.chr1         #tm.a6  印成或半成品
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.a1 = p_arg2
   LET tm.a2 = p_arg3
   LET tm.a3 = p_arg4
   LET tm.a4 = p_arg5
   LET tm.a5 = p_arg6
   LET tm.a6 = p_arg7
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "abmr302_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL abmr302_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL abmr302_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL abmr302_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL abmr302_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL abmr302_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="abmr302_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION abmr302_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "bmfa003.bmfa_t.bmfa003,l_imaal003.imaal_t.imaal003,l_imaal004.imaal_t.imaal004,l_site_ooefl004.ooefl_t.ooefl004,l_ooef016.ooef_t.ooef016,l_bmfa003_gzcbl004.gzcbl_t.gzcbl004,l_docno.type_t.chr1000,l_date.type_t.dat,l_count.inag_t.inag008,l_unit.pmdt_t.pmdt021,l_amount.type_t.num20_6" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="abmr302_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION abmr302_x01_ins_prep()
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
             ?,?,?,?,?)"
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
 
{<section id="abmr302_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION abmr302_x01_sel_prep()
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
   LET g_select = "SELECT DISTINCT b.bmfa003,c.imaal003,c.imaal004,d.ooefl004,'','','','','','','',b.bmfaent,b.bmfasite,e.imaa006"
#   #end add-point
#   LET g_select = " SELECT bmfa003,'','','','','','','','','','',bmfaent,bmfasite,''"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_where = " WHERE " ,tm.wc CLIPPED
   #使用ENC料號之成品或半成品庫存資料
   IF tm.a6 = 'Y' THEN
      LET g_from = "   FROM ( SELECT bmfa003,bmfadocno,bmfaent,bmfasite,bmfadocdt,bmfa006,bmfa007",
                   "            FROM bmfa_t ",g_where, " AND bmfaent=",g_enterprise, #160905-00007#1 add
                   "             AND bmfa003 IN(",
                   " SELECT DISTINCT bmaa001 ",
                   "            FROM bmaa_t ",
                   "           WHERE bmaa001 IN (SELECT DISTINCT bmfa003 FROM bmfa_t",g_where," AND bmfaent=",g_enterprise,"))", #160905-00007#1 add
                   "    UNION SELECT bmfa003,bmfadocno,bmfaent,bmfasite,bmfadocdt,bmfa006,bmfa007",
                   "            FROM bmfa_t ",g_where, " AND bmfaent=",g_enterprise, #160905-00007#1 add
                   "    UNION SELECT bmfd004,bmfddocno,bmfdent,bmfdsite,bmfadocdt,bmfa006,bmfa007",
                   "            FROM bmfa_t JOIN bmfd_t ",
                   "              ON bmfddocno=bmfadocno AND bmfdsite = bmfasite AND bmfdent = bmfaent",g_where, " AND bmfaent=",g_enterprise, #160905-00007#1 add
                   "    UNION SELECT bmfp002,bmfpdocno,bmfpent,bmfpsite,bmfadocdt,bmfa006,bmfa007",
                   "            FROM bmfa_t JOIN bmfp_t ",
                   "              ON bmfpdocno=bmfadocno AND bmfpsite = bmfasite AND bmfpent = bmfaent",g_where, " AND bmfaent=",g_enterprise, #160905-00007#1 add
                   "    UNION SELECT bmfb005,bmfbdocno,bmfbent,bmfbsite,bmfadocdt,bmfa006,bmfa007",
                   "            FROM bmfa_t JOIN bmfb_t ",
                   "              ON bmfbdocno=bmfadocno AND bmfbsite = bmfasite AND bmfbent = bmfaent",g_where, " AND bmfaent=",g_enterprise, #160905-00007#1 add
                   "    UNION SELECT bmfb006,bmfbdocno,bmfbent,bmfbsite,bmfadocdt,bmfa006,bmfa007",
                   "            FROM bmfa_t JOIN bmfb_t ",
                   "              ON bmfbdocno=bmfadocno AND bmfbsite = bmfasite AND bmfbent = bmfaent",g_where, " AND bmfaent=",g_enterprise, #160905-00007#1 add
                   "    UNION SELECT bmfc005,bmfcdocno,bmfcent,bmfcsite,bmfadocdt,bmfa006,bmfa007",
                   "            FROM bmfb_t JOIN bmfc_t ",
                   "              ON bmfcdocno=bmfbdocno AND bmfcsite = bmfbsite AND bmfcent = bmfbent AND bmfc002 = bmfb002",
                   "       LEFT JOIN bmfa_t ",
                   "              ON bmfbdocno=bmfadocno AND bmfbsite = bmfasite AND bmfbent = bmfaent",g_where, " AND bmfaent=",g_enterprise, #160905-00007#1 add
                   "    UNION SELECT bmfe004,bmfedocno,bmfeent,bmfesite,bmfadocdt,bmfa006,bmfa007",
                   "            FROM bmfa_t JOIN bmfe_t ",
                   "              ON bmfedocno=bmfadocno AND bmfesite = bmfasite AND bmfeent = bmfaent",g_where, " AND bmfaent=",g_enterprise, #160905-00007#1 add
                   "    UNION SELECT bmff004,bmffdocno,bmffent,bmffsite,bmfadocdt,bmfa006,bmfa007",
                   "            FROM bmfa_t JOIN bmff_t ",
                   "              ON bmffdocno=bmfadocno AND bmffsite = bmfasite AND bmffent = bmfaent",g_where,"  AND bmfaent=",g_enterprise,") b ", #160905-00007#1 add
                   "    LEFT OUTER JOIN imaal_t c ON imaalent = b.bmfaent AND imaal001 = b.bmfa003 AND imaal002 = '",g_dlang,"'",
                   "    LEFT OUTER JOIN ooefl_t d ON ooeflent = b.bmfaent AND ooefl001 = b.bmfasite AND ooefl002 = '",g_dlang,"'",
                   "    LEFT OUTER JOIN imaa_t e ON imaaent = b.bmfaent AND imaa001 = b.bmfa003"
   ELSE
      LET g_from = "   FROM ( SELECT bmfa003,bmfadocno,bmfaent,bmfasite,bmfadocdt,bmfa006,bmfa007",
                   "            FROM bmfa_t ",g_where, " AND bmfaent=",g_enterprise, #160905-00007#1 add
                   "    UNION SELECT bmfd004,bmfddocno,bmfdent,bmfdsite,bmfadocdt,bmfa006,bmfa007",
                   "            FROM bmfa_t JOIN bmfd_t ",
                   "              ON bmfddocno=bmfadocno AND bmfdsite = bmfasite AND bmfdent = bmfaent",g_where, " AND bmfaent=",g_enterprise, #160905-00007#1 add
                   "    UNION SELECT bmfp002,bmfpdocno,bmfpent,bmfpsite,bmfadocdt,bmfa006,bmfa007",
                   "            FROM bmfa_t JOIN bmfp_t ",
                   "              ON bmfpdocno=bmfadocno AND bmfpsite = bmfasite AND bmfpent = bmfaent",g_where, " AND bmfaent=",g_enterprise, #160905-00007#1 add
                   "    UNION SELECT bmfb005,bmfbdocno,bmfbent,bmfbsite,bmfadocdt,bmfa006,bmfa007",
                   "            FROM bmfa_t JOIN bmfb_t ",
                   "              ON bmfbdocno=bmfadocno AND bmfbsite = bmfasite AND bmfbent = bmfaent",g_where, " AND bmfaent=",g_enterprise, #160905-00007#1 add
                   "    UNION SELECT bmfb006,bmfbdocno,bmfbent,bmfbsite,bmfadocdt,bmfa006,bmfa007",
                   "            FROM bmfa_t JOIN bmfb_t ",
                   "              ON bmfbdocno=bmfadocno AND bmfbsite = bmfasite AND bmfbent = bmfaent",g_where, " AND bmfaent=",g_enterprise, #160905-00007#1 add
                   "    UNION SELECT bmfc005,bmfcdocno,bmfcent,bmfcsite,bmfadocdt,bmfa006,bmfa007",
                   "            FROM bmfb_t JOIN bmfc_t ",
                   "              ON bmfcdocno=bmfbdocno AND bmfcsite = bmfbsite AND bmfcent = bmfbent AND bmfc002 = bmfb002",
                   "       LEFT JOIN bmfa_t ",
                   "              ON bmfbdocno=bmfadocno AND bmfbsite = bmfasite AND bmfbent = bmfaent",g_where, " AND bmfaent=",g_enterprise, #160905-00007#1 add
                   "    UNION SELECT bmfe004,bmfedocno,bmfeent,bmfesite,bmfadocdt,bmfa006,bmfa007",
                   "            FROM bmfa_t JOIN bmfe_t ",
                   "              ON bmfedocno=bmfadocno AND bmfesite = bmfasite AND bmfeent = bmfaent",g_where, " AND bmfaent=",g_enterprise, #160905-00007#1 add
                   "    UNION SELECT bmff004,bmffdocno,bmffent,bmffsite,bmfadocdt,bmfa006,bmfa007",
                   "            FROM bmfa_t JOIN bmff_t ",
                   "              ON bmffdocno=bmfadocno AND bmffsite = bmfasite AND bmffent = bmfaent",g_where,"  AND bmfaent=",g_enterprise,") b ", #160905-00007#1 add
                   "    LEFT OUTER JOIN imaal_t c ON imaalent = b.bmfaent AND imaal001 = b.bmfa003 AND imaal002 = '",g_dlang,"'",
                   "    LEFT OUTER JOIN ooefl_t d ON ooeflent = b.bmfaent AND ooefl001 = b.bmfasite AND ooefl002 = '",g_dlang,"'",
                   "    LEFT OUTER JOIN imaa_t e ON imaaent = b.bmfaent AND imaa001 = b.bmfa003"
   END IF          
                
#   #end add-point
#    LET g_from = " FROM bmfa_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
 
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("bmfa_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   DISPLAY BY NAME g_sql
   #end add-point
   PREPARE abmr302_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE abmr302_x01_curs CURSOR FOR abmr302_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="abmr302_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION abmr302_x01_ins_data()
DEFINE sr RECORD 
   bmfa003 LIKE bmfa_t.bmfa003, 
   l_imaal003 LIKE imaal_t.imaal003, 
   l_imaal004 LIKE imaal_t.imaal004, 
   l_site_ooefl004 LIKE ooefl_t.ooefl004, 
   l_ooef016 LIKE ooef_t.ooef016, 
   l_bmfa003_gzcbl004 LIKE gzcbl_t.gzcbl004, 
   l_docno LIKE type_t.chr1000, 
   l_date LIKE type_t.dat, 
   l_count LIKE inag_t.inag008, 
   l_unit LIKE pmdt_t.pmdt021, 
   l_amount LIKE type_t.num20_6, 
   bmfaent LIKE bmfa_t.bmfaent, 
   bmfasite LIKE bmfa_t.bmfasite, 
   l_imaa006 LIKE imaa_t.imaa006
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
   DEFINE l_sql   STRING
   DEFINE l_sql_1 STRING
   DEFINE l_sql_2 STRING
   DEFINE l_ooef016       LIKE ooef_t.ooef016
   DEFINE l_ooef016_rate  LIKE ooan_t.ooan005
   DEFINE l_imaa006       LIKE imaa_t.imaa006
   DEFINE l_imaa006_rate  LIKE inaj_t.inaj014
   DEFINE l_success       LIKE type_t.num5
   DEFINE inag RECORD 
      inag004             LIKE inag_t.inag004,   #庫位
      inag007             LIKE inag_t.inag007,   #單位
      inag008             LIKE inag_t.inag008,   #庫存數量
      inagsite            LIKE inag_t.inagsite,
      xccc280             LIKE xccc_t.xccc280,   #單價
      inayl003            LIKE inayl_t.inayl003, #庫位名稱
      l_inag008_xccc280   LIKE type_t.num20_6,   #金額
      l_inag004_inayl003  LIKE type_t.chr1000    #庫位.名稱
    END RECORD
   DEFINE pmdb RECORD     
      pmdbdocno           LIKE pmdb_t.pmdbdocno, #單號
      pmdbseq             LIKE pmdb_t.pmdbseq,   #項次
      pmdb006             LIKE pmdb_t.pmdb006,   #需求數量
      pmdb007             LIKE pmdb_t.pmdb007,   #單位
      pmdb019             LIKE pmdb_t.pmdb019,   #單價
      pmdb049             LIKE pmdb_t.pmdb049,   #已轉採購量
      pmdbsite            LIKE pmdb_t.pmdbsite,
      pmdadocdt           LIKE pmda_t.pmdadocdt, #日期
      l_pmdb006_pmdb049   LIKE pmdb_t.pmdb006,   #數量
      l_pmdbdocno_pmdbseq LIKE type_t.chr1000,   #單號-項次
      l_pmdb006_pmdb019   LIKE type_t.num20_6    #金額
    END RECORD
   DEFINE pmdo RECORD
      pmdodocno           LIKE pmdo_t.pmdodocno, #單號
      pmdoseq             LIKE pmdo_t.pmdoseq,   #項次
      pmdoseq1            LIKE pmdo_t.pmdoseq1,  #項序
      pmdoseq2            LIKE pmdo_t.pmdoseq2,  #分批序
      pmdo005             LIKE pmdo_t.pmdo005,   #採購總數量
      pmdo015             LIKE pmdo_t.pmdo015,   #已收貨量
      pmdosite            LIKE pmdo_t.pmdosite,  
      pmdldocdt           LIKE pmdl_t.pmdldocdt, #日期
      pmdn006             LIKE pmdn_t.pmdn006,   #單位
      pmdn015             LIKE pmdn_t.pmdn015,   #單價
      l_pmdo005_pmdo015   LIKE pmdo_t.pmdo005,   #數量
      l_pmdo005_pmdn015   LIKE type_t.num20_6,   #金額
      l_pmdodocno_pmdoseq LIKE type_t.chr1000    #單號-項次-項序-分批序
    END RECORD            
    DEFINE pmdt RECORD    
      pmdtdocno           LIKE pmdt_t.pmdtdocno, #單號
      pmdtseq             LIKE pmdt_t.pmdtseq,   #項次
      pmdt019             LIKE pmdt_t.pmdt019,   #收貨單位
      pmdt020             LIKE pmdt_t.pmdt020,   #收貨/入庫數量
      pmdt036             LIKE pmdt_t.pmdt036,   #單價
      pmdt054             LIKE pmdt_t.pmdt054,   #已入庫量
      pmdtsite            LIKE pmdt_t.pmdtsite,   
      pmdsdocdt           LIKE pmds_t.pmdsdocdt, #日期
      l_pmdt020_pmdt054   LIKE pmdt_t.pmdt020,   #收貨數量
      l_pmdt020_pmdt036   LIKE type_t.num20_6,   #金額
      l_pmdtdocno_pmdtseq LIKE type_t.chr1000    #單號-項次
    END RECORD
    DEFINE sfaa RECORD
      sfaadocno           LIKE sfaa_t.sfaadocno, #單號
      sfaa012             LIKE sfaa_t.sfaa012,   #生產數量
      sfaa013             LIKE sfaa_t.sfaa013,   #單位
      sfaa020             LIKE sfaa_t.sfaa020,   #預計完工日
      sfaa050             LIKE sfaa_t.sfaa050,   #已入庫合格量
      sfaasite            LIKE sfaa_t.sfaasite,
      xccc280             LIKE xccc_t.xccc280,   #單價
      l_sfaa012_sfaa050   LIKE pmdt_t.pmdt020,   #數量
      l_sfaa012_xccc280   LIKE type_t.num20_6    #金額
    END RECORD
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH abmr302_x01_curs INTO sr.*                               
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
       IF cl_null(sr.bmfa003) THEN
          CONTINUE FOREACH
       END IF
       LET l_sql_1 = " SELECT ooef016 ",#INTO sr.l_ooef016
                     "   FROM ooef_t ",
                     "  WHERE ooef001 = (SELECT ooef017 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef001 = ?)" #160905-00007#1 add
       LET l_sql_2 = " SELECT ooef016 ",#INTO l_ooef016
                     "   FROM ooef_t ",
                     "  WHERE ooef001 = ?",
                     "     AND ooefent= ", g_enterprise  #160905-00007#1
       PREPARE sr_l_ooef016_pre FROM l_sql_1
       PREPARE l_ooef016_pre FROM l_sql_2
       SELECT imaa006 INTO l_imaa006
         FROM imaa_t
        WHERE imaaent = sr.bmfaent
          AND imaa001 = sr.bmfa003
#       #計算匯率
#       INITIALIZE l_ooef016_rate TO NULL
#       IF cl_null(sr.l_ooef016) OR cl_null(l_ooef016) THEN
#          LET l_ooef016_rate = 1
#       ELSE
#          CALL s_aooi160_get_exrate('1',sr.bmfasite,g_today,l_ooef016,sr.l_ooef016,1,'11') RETURNING l_ooef016_rate
#          IF cl_null(l_ooef016_rate) THEN
#             LET l_ooef016_rate = 1
#          END IF
#       END IF
       #----------列印庫存----------#
       IF tm.a1 = "Y" THEN
          IF sr.bmfasite = 'ALL' THEN
             LET l_sql = " SELECT inag004,inag007,inag008,inagsite",
                         "   FROM inag_t ",
                         "  WHERE inagent = ",sr.bmfaent,
                         "    AND inag001 = '",sr.bmfa003,"'"
          ELSE
             LET l_sql = " SELECT inag004,inag007,inag008,inagsite",
                         "   FROM inag_t ",
                         "  WHERE inagent = ",sr.bmfaent,
                         "    AND inagsite = '",sr.bmfasite,"'",
                         "    AND inag001 = '",sr.bmfa003,"'"
          END IF

          PREPARE abmr302_x01_prepare_inag FROM l_sql
          DECLARE abmr302_x01_inag CURSOR FOR abmr302_x01_prepare_inag
          FOREACH abmr302_x01_inag INTO inag.*
             IF STATUS THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = 'foreach:'
                LET g_errparam.code   = STATUS
                LET g_errparam.popup  = TRUE
                CALL cl_err()
                LET g_rep_success = 'N'
                EXIT FOREACH
             END IF
             #計算匯率
             EXECUTE sr_l_ooef016_pre INTO sr.l_ooef016 USING inag.inagsite
             EXECUTE l_ooef016_pre INTO l_ooef016 USING inag.inagsite
             INITIALIZE l_ooef016_rate TO NULL
             IF cl_null(sr.l_ooef016) OR cl_null(l_ooef016) THEN
                LET l_ooef016_rate = 1
             ELSE
                CALL s_aooi160_get_exrate('1',sr.bmfasite,g_today,l_ooef016,sr.l_ooef016,1,'11') RETURNING l_ooef016_rate
                IF cl_null(l_ooef016_rate) THEN
                   LET l_ooef016_rate = 1
                END IF
             END IF
             
             CALL s_desc_get_stock_desc(sr.bmfasite,inag.inag004) RETURNING inag.inayl003
             IF cl_null(inag.inayl003) THEN
                LET inag.l_inag004_inayl003 = inag.inag004
             ELSE
                IF cl_null(inag.inag004) THEN
                   LET inag.l_inag004_inayl003 = ''
                ELSE
                   LET inag.l_inag004_inayl003 = inag.inag004 || "." || inag.inayl003
                END IF
             END IF
             SELECT xccc280 INTO inag.xccc280
               FROM xccc_t
              WHERE xcccent = sr.bmfaent
                AND xccc006 = sr.bmfa003
             IF cl_null(inag.xccc280) THEN
                SELECT imai021 INTO inag.xccc280
                  FROM imai_t
                 WHERE imaient = sr.bmfaent
                   AND imaisite = sr.bmfasite
                   AND imai001 = sr.bmfa003
             END IF
             CALL abmr302_x01_nulltozero(inag.xccc280) RETURNING inag.xccc280
             IF NOT (cl_null(inag.inag007) OR cl_null(l_imaa006)) THEN
#                CALL s_aimi190_get_convert(sr.bmfa003,inag.inag007,l_imaa006) RETURNING l_success,l_imaa006_rate
                CALL s_aooi250_convert_qty(sr.bmfa003,inag.inag007,l_imaa006,inag.inag008)
                     RETURNING l_success,inag.inag008
             END IF
#             IF l_success THEN
#                LET inag.inag008 = inag.inag008 * l_imaa006_rate
#             END IF
             LET inag.l_inag008_xccc280 = inag.inag008 * inag.xccc280 * l_ooef016_rate
             CALL s_desc_gzcbl004_desc(5449,1) RETURNING sr.l_bmfa003_gzcbl004
             IF inag.inag008 = 0 THEN
                CONTINUE FOREACH
             END IF
             SELECT ooefl004 INTO sr.l_site_ooefl004
               FROM ooefl_t
              WHERE ooeflent = g_enterprise
                AND ooefl001 = inag.inagsite
                AND ooefl002 = g_dlang
             EXECUTE insert_prep USING sr.bmfa003,sr.l_imaal003,sr.l_imaal004,sr.l_site_ooefl004,sr.l_ooef016,sr.l_bmfa003_gzcbl004,inag.l_inag004_inayl003,sr.l_date,inag.inag008,inag.inag007,inag.l_inag008_xccc280
             IF SQLCA.sqlcode THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = "abmr302_x01_execute"
                LET g_errparam.code   = SQLCA.sqlcode
                LET g_errparam.popup  = FALSE
                CALL cl_err()       
                LET g_rep_success = 'N'
                EXIT FOREACH
             END IF
          END FOREACH
       END IF
       #----------列印請購單----------#
       IF tm.a2 = "Y" THEN
          IF sr.bmfasite = 'ALL' THEN
             LET l_sql = "SELECT pmdbdocno,pmdbseq,pmdb006,pmdb007,pmdb019,pmdb049,pmdbsite",
                         "  FROM pmdb_t ",
                         " WHERE pmdbent = ",sr.bmfaent,
                         "   AND pmdb004 = '",sr.bmfa003,"'"
          ELSE
             LET l_sql = "SELECT pmdbdocno,pmdbseq,pmdb006,pmdb007,pmdb019,pmdb049,pmdbsite",
                         "  FROM pmdb_t ",
                         " WHERE pmdbent = ",sr.bmfaent,
                         "   AND pmdbsite = '",sr.bmfasite,"'",
                         "   AND pmdb004 = '",sr.bmfa003,"'"
          END IF
          
          PREPARE abmr302_x01_prepare_pmdb FROM l_sql
          DECLARE abmr302_x01_pmdb CURSOR FOR abmr302_x01_prepare_pmdb
          FOREACH abmr302_x01_pmdb INTO pmdb.*
             IF STATUS THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = 'foreach:'
                LET g_errparam.code   = STATUS
                LET g_errparam.popup  = TRUE
                CALL cl_err()
                LET g_rep_success = 'N'
                EXIT FOREACH
             END IF
             #計算匯率
             EXECUTE sr_l_ooef016_pre INTO sr.l_ooef016 USING pmdb.pmdbsite
             EXECUTE l_ooef016_pre INTO l_ooef016 USING pmdb.pmdbsite
             INITIALIZE l_ooef016_rate TO NULL
             IF cl_null(sr.l_ooef016) OR cl_null(l_ooef016) THEN
                LET l_ooef016_rate = 1
             ELSE
                CALL s_aooi160_get_exrate('1',sr.bmfasite,g_today,l_ooef016,sr.l_ooef016,1,'11') RETURNING l_ooef016_rate
                IF cl_null(l_ooef016_rate) THEN
                   LET l_ooef016_rate = 1
                END IF
             END IF
             
             SELECT pmdadocdt INTO pmdb.pmdadocdt
               FROM pmda_t
              WHERE pmdadocno = pmdb.pmdbdocno
                AND pmdaent = sr.bmfaent
             IF cl_null(pmdb.pmdbdocno) OR cl_null(pmdb.pmdbseq) THEN
                LET pmdb.l_pmdbdocno_pmdbseq = pmdb.pmdbdocno CLIPPED,'-',pmdb.pmdbseq CLIPPED
             ELSE
                LET pmdb.l_pmdbdocno_pmdbseq = pmdb.pmdbdocno CLIPPED||'-'||pmdb.pmdbseq CLIPPED
             END IF
             CALL abmr302_x01_nulltozero(pmdb.pmdb006) RETURNING pmdb.pmdb006
             CALL abmr302_x01_nulltozero(pmdb.pmdb049) RETURNING pmdb.pmdb049
             LET pmdb.l_pmdb006_pmdb049 = pmdb.pmdb006 - pmdb.pmdb049
             IF NOT (cl_null(pmdb.pmdb007) OR cl_null(l_imaa006)) THEN
#                CALL s_aimi190_get_convert(sr.bmfa003,pmdb.pmdb007,l_imaa006) RETURNING l_success,l_imaa006_rate
#             ELSE
#                LET l_imaa006_rate = 1
                CALL s_aooi250_convert_qty(sr.bmfa003,pmdb.pmdb007,l_imaa006,pmdb.l_pmdb006_pmdb049)
                     RETURNING l_success,pmdb.l_pmdb006_pmdb049
             END IF
#             IF l_success THEN
#                LET pmdb.l_pmdb006_pmdb049 = pmdb.l_pmdb006_pmdb049 * l_imaa006_rate
#             END IF
             IF cl_null(pmdb.pmdb019) THEN
                SELECT imai021 INTO pmdb.pmdb019
                  FROM imai_t
                 WHERE imaient = sr.bmfaent
                   AND imaisite = sr.bmfasite
                   AND imai001 = sr.bmfa003
                IF cl_null(pmdb.pmdb019) THEN
                   SELECT xccc280 INTO inag.xccc280
                     FROM xccc_t
                    WHERE xcccent = sr.bmfaent
                      AND xccc006 = sr.bmfa003
                END IF
             END IF
             CALL abmr302_x01_nulltozero(pmdb.pmdb019) RETURNING pmdb.pmdb019
             LET pmdb.l_pmdb006_pmdb019 = pmdb.l_pmdb006_pmdb049 * pmdb.pmdb019 * l_ooef016_rate
             CALL s_desc_gzcbl004_desc(5449,2) RETURNING sr.l_bmfa003_gzcbl004
             IF pmdb.l_pmdb006_pmdb049 = 0 THEN
                CONTINUE FOREACH
             END IF
             SELECT ooefl004 INTO sr.l_site_ooefl004
               FROM ooefl_t
              WHERE ooeflent = g_enterprise
                AND ooefl001 = pmdb.pmdbsite
                AND ooefl002 = g_dlang
             EXECUTE insert_prep USING sr.bmfa003,sr.l_imaal003,sr.l_imaal004,sr.l_site_ooefl004,sr.l_ooef016,sr.l_bmfa003_gzcbl004,pmdb.l_pmdbdocno_pmdbseq,pmdb.pmdadocdt,pmdb.l_pmdb006_pmdb049,pmdb.pmdb007,pmdb.l_pmdb006_pmdb019
                IF SQLCA.sqlcode THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.extend = "abmr302_x01_execute"
                   LET g_errparam.code   = SQLCA.sqlcode
                   LET g_errparam.popup  = FALSE
                   CALL cl_err()       
                   LET g_rep_success = 'N'
                   EXIT FOREACH
                END IF
          END FOREACH
       END IF
       #----------列印採購單----------#
       IF tm.a3 = "Y" THEN
          IF sr.bmfasite = 'ALL' THEN
             LET l_sql = "SELECT pmdodocno,pmdoseq,pmdoseq1,pmdoseq2,pmdo005,pmdo015,pmdosite",
                         "  FROM pmdo_t ",
                         " WHERE pmdoent = ",sr.bmfaent,
                         "   AND pmdo001 = '",sr.bmfa003,"'"
          ELSE
             LET l_sql = "SELECT pmdodocno,pmdoseq,pmdoseq1,pmdoseq2,pmdo005,pmdo015,pmdosite",
                         "  FROM pmdo_t ",
                         " WHERE pmdoent = ",sr.bmfaent,
                         "   AND pmdosite = '",sr.bmfasite,"'",
                         "   AND pmdo001 = '",sr.bmfa003,"'"
          END IF
          
          PREPARE abmr302_x01_prepare_pmdo FROM l_sql
          DECLARE abmr302_x01_pmdo CURSOR FOR abmr302_x01_prepare_pmdo
          FOREACH abmr302_x01_pmdo INTO pmdo.*
             IF STATUS THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = 'foreach:'
                LET g_errparam.code   = STATUS
                LET g_errparam.popup  = TRUE
                CALL cl_err()
                LET g_rep_success = 'N'
                EXIT FOREACH
             END IF
             #計算匯率
             EXECUTE sr_l_ooef016_pre INTO sr.l_ooef016 USING pmdo.pmdosite
             EXECUTE l_ooef016_pre INTO l_ooef016 USING pmdo.pmdosite
             INITIALIZE l_ooef016_rate TO NULL
             IF cl_null(sr.l_ooef016) OR cl_null(l_ooef016) THEN
                LET l_ooef016_rate = 1
             ELSE
                CALL s_aooi160_get_exrate('1',sr.bmfasite,g_today,l_ooef016,sr.l_ooef016,1,'11') RETURNING l_ooef016_rate
                IF cl_null(l_ooef016_rate) THEN
                   LET l_ooef016_rate = 1
                END IF
             END IF
             
             SELECT pmdldocdt INTO pmdo.pmdldocdt
               FROM pmdl_t
              WHERE pmdldocno = pmdo.pmdodocno
                AND pmdlent = sr.bmfaent
             SELECT pmdn006,pmdn015 INTO pmdo.pmdn006,pmdo.pmdn015
               FROM pmdn_t
              WHERE pmdndocno = pmdo.pmdodocno
                AND pmdnent = sr.bmfaent
                AND pmdnseq = pmdo.pmdoseq
             LET pmdo.l_pmdodocno_pmdoseq = pmdo.pmdodocno CLIPPED,'-',pmdo.pmdoseq CLIPPED,'-',pmdo.pmdoseq1 CLIPPED,'-',pmdo.pmdoseq2 CLIPPED
             CALL abmr302_x01_nulltozero(pmdo.pmdo005) RETURNING pmdo.pmdo005
             CALL abmr302_x01_nulltozero(pmdo.pmdo015) RETURNING pmdo.pmdo015
             CALL abmr302_x01_nulltozero(pmdo.pmdn015) RETURNING pmdo.pmdn015
             LET pmdo.l_pmdo005_pmdo015 = pmdo.pmdo005 - pmdo.pmdo015
             IF NOT (cl_null(pmdo.pmdn006) OR cl_null(l_imaa006)) THEN
#                CALL s_aimi190_get_convert(sr.bmfa003,pmdo.pmdn006,l_imaa006) RETURNING l_success,l_imaa006_rate
#             ELSE
#                LET l_imaa006_rate = 1
                CALL s_aooi250_convert_qty(sr.bmfa003,pmdo.pmdn006,l_imaa006,pmdo.l_pmdo005_pmdo015)
                     RETURNING l_success,pmdo.l_pmdo005_pmdo015
             END IF
#             IF l_success THEN
#                LET pmdo.l_pmdo005_pmdo015 = pmdo.l_pmdo005_pmdo015 * l_imaa006_rate
#             END IF
             LET pmdo.l_pmdo005_pmdn015 = pmdo.l_pmdo005_pmdo015 * pmdo.pmdn015 * l_ooef016_rate
             CALL s_desc_gzcbl004_desc(5449,3) RETURNING sr.l_bmfa003_gzcbl004
             IF pmdo.l_pmdo005_pmdo015 = 0 THEN
                CONTINUE FOREACH
             END IF
             SELECT ooefl004 INTO sr.l_site_ooefl004
               FROM ooefl_t
              WHERE ooeflent = g_enterprise
                AND ooefl001 = pmdo.pmdosite
                AND ooefl002 = g_dlang
             EXECUTE insert_prep USING sr.bmfa003,sr.l_imaal003,sr.l_imaal004,sr.l_site_ooefl004,sr.l_ooef016,sr.l_bmfa003_gzcbl004,pmdo.l_pmdodocno_pmdoseq,pmdo.pmdldocdt,pmdo.l_pmdo005_pmdo015,pmdo.pmdn006,pmdo.l_pmdo005_pmdn015
                IF SQLCA.sqlcode THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.extend = "abmr302_x01_execute"
                   LET g_errparam.code   = SQLCA.sqlcode
                   LET g_errparam.popup  = FALSE
                   CALL cl_err()       
                   LET g_rep_success = 'N'
                   EXIT FOREACH
                END IF
          END FOREACH
       END IF
       #----------列印收貨單----------#
       IF tm.a4 = "Y" THEN
          IF sr.bmfasite = 'ALL' THEN
             LET l_sql = "SELECT pmdtdocno,pmdtseq,pmdt019,pmdt020,pmdt036,pmdt054,pmdtsite",
                         "  FROM pmdt_t,pmds_t ",
                         " WHERE pmdtent = ",sr.bmfaent,
                         "   AND pmdt006 = '",sr.bmfa003,"'",
                         "   AND pmdsent = pmdtent",
                         "   AND pmdsdocno = pmdtdocno",
                         "   AND pmds000 IN ('1','2','8','9')"
          ELSE
             LET l_sql = "SELECT pmdtdocno,pmdtseq,pmdt019,pmdt020,pmdt036,pmdt054,pmdtsite",
                         "  FROM pmdt_t,pmdsdocno ",
                         " WHERE pmdtent = ",sr.bmfaent,
                         "   AND pmdtsite = '",sr.bmfasite,"'",
                         "   AND pmdt006 = '",sr.bmfa003,"'",
                         "   AND pmdsent = pmdtent",
                         "   AND pmdsdocno = pmdtdocno",
                         "   AND pmds000 IN ('1','2','8','9')"
          END IF
          
          PREPARE abmr302_x01_prepare_pmdt FROM l_sql
          DECLARE abmr302_x01_pmdt CURSOR FOR abmr302_x01_prepare_pmdt
          FOREACH abmr302_x01_pmdt INTO pmdt.*
             IF STATUS THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = 'foreach:'
                LET g_errparam.code   = STATUS
                LET g_errparam.popup  = TRUE
                CALL cl_err()
                LET g_rep_success = 'N'
                EXIT FOREACH
             END IF
             #計算匯率
             EXECUTE sr_l_ooef016_pre INTO sr.l_ooef016 USING pmdt.pmdtsite
             EXECUTE l_ooef016_pre INTO l_ooef016 USING pmdt.pmdtsite
             INITIALIZE l_ooef016_rate TO NULL
             IF cl_null(sr.l_ooef016) OR cl_null(l_ooef016) THEN
                LET l_ooef016_rate = 1
             ELSE
                CALL s_aooi160_get_exrate('1',sr.bmfasite,g_today,l_ooef016,sr.l_ooef016,1,'11') RETURNING l_ooef016_rate
                IF cl_null(l_ooef016_rate) THEN
                   LET l_ooef016_rate = 1
                END IF
             END IF
             
             SELECT pmdsdocdt INTO pmdt.pmdsdocdt
               FROM pmds_t
              WHERE pmdsdocno = pmdt.pmdtdocno
                AND pmdsent = sr.bmfaent
             IF cl_null(pmdt.pmdtdocno) OR cl_null(pmdt.pmdtseq) THEN
                LET pmdt.l_pmdtdocno_pmdtseq = pmdt.pmdtdocno CLIPPED,'-',pmdt.pmdtseq CLIPPED
             ELSE
                LET pmdt.l_pmdtdocno_pmdtseq = pmdt.pmdtdocno CLIPPED||'-'||pmdt.pmdtseq CLIPPED
             END IF
             CALL abmr302_x01_nulltozero(pmdt.pmdt020) RETURNING pmdt.pmdt020
             CALL abmr302_x01_nulltozero(pmdt.pmdt036) RETURNING pmdt.pmdt036
             CALL abmr302_x01_nulltozero(pmdt.pmdt054) RETURNING pmdt.pmdt054
             LET pmdt.l_pmdt020_pmdt054 = pmdt.pmdt020 - pmdt.pmdt054
             IF NOT (cl_null(pmdt.pmdt019) OR cl_null(l_imaa006)) THEN
#                CALL s_aimi190_get_convert(sr.bmfa003,pmdt.pmdt019,l_imaa006) RETURNING l_success,l_imaa006_rate
#             ELSE
#                LET l_imaa006_rate = 1
                CALL s_aooi250_convert_qty(sr.bmfa003,pmdt.pmdt019,l_imaa006,pmdt.l_pmdt020_pmdt054)
                     RETURNING l_success,pmdt.l_pmdt020_pmdt054
             END IF
#             IF l_success THEN
#                LET pmdt.l_pmdt020_pmdt054 = pmdt.l_pmdt020_pmdt054 * l_imaa006_rate
#             END IF
             LET pmdt.l_pmdt020_pmdt036 = pmdt.l_pmdt020_pmdt054 * pmdt.pmdt036 * l_ooef016_rate
             CALL s_desc_gzcbl004_desc(5449,4) RETURNING sr.l_bmfa003_gzcbl004
             IF pmdt.l_pmdt020_pmdt054 = 0 THEN
                CONTINUE FOREACH
             END IF
             SELECT ooefl004 INTO sr.l_site_ooefl004
               FROM ooefl_t
              WHERE ooeflent = g_enterprise
                AND ooefl001 = pmdt.pmdtsite
                AND ooefl002 = g_dlang
             EXECUTE insert_prep USING sr.bmfa003,sr.l_imaal003,sr.l_imaal004,sr.l_site_ooefl004,sr.l_ooef016,sr.l_bmfa003_gzcbl004,pmdt.l_pmdtdocno_pmdtseq,pmdt.pmdsdocdt,pmdt.l_pmdt020_pmdt054,pmdt.pmdt019,pmdt.l_pmdt020_pmdt036
                IF SQLCA.sqlcode THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.extend = "abmr302_x01_execute"
                   LET g_errparam.code   = SQLCA.sqlcode
                   LET g_errparam.popup  = FALSE
                   CALL cl_err()       
                   LET g_rep_success = 'N'
                   EXIT FOREACH
                END IF
          END FOREACH
       END IF
      #----------列印工單----------#
       IF tm.a5 = "Y" THEN
          IF sr.bmfasite = 'ALL' THEN
             LET l_sql = "SELECT sfaadocno,sfaa012,sfaa013,sfaa020,sfaa050,sfaasite",
                         "  FROM sfaa_t ",
                         " WHERE sfaaent = ",sr.bmfaent,
                         #modify--160420-00037#1 By shiun--(S)
#                         "   AND sfaa006 = '",sr.bmfa003,"'"
                         "   AND sfaa010 = '",sr.bmfa003,"'"
          ELSE
             LET l_sql = "SELECT sfaadocno,sfaa012,sfaa013,sfaa020,sfaa050,sfaasite",
                         "  FROM sfaa_t ",
                         " WHERE sfaaent = ",sr.bmfaent,
                         "   AND sfaasite = '",sr.bmfasite,"'",
#                         "   AND sfaa006 = '",sr.bmfa003,"'"
                         "   AND sfaa010 = '",sr.bmfa003,"'"
                         #modify--160420-00037#1 By shiun--(E)
          END IF
          
          PREPARE abmr302_x01_prepare_sfaa FROM l_sql
          DECLARE abmr302_x01_sfaa CURSOR FOR abmr302_x01_prepare_sfaa
          FOREACH abmr302_x01_sfaa INTO sfaa.*
             IF STATUS THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = 'foreach:'
                LET g_errparam.code   = STATUS
                LET g_errparam.popup  = TRUE
                CALL cl_err()
                LET g_rep_success = 'N'
                EXIT FOREACH
             END IF
             #計算匯率
             EXECUTE sr_l_ooef016_pre INTO sr.l_ooef016 USING sfaa.sfaasite
             EXECUTE l_ooef016_pre INTO l_ooef016 USING sfaa.sfaasite
             INITIALIZE l_ooef016_rate TO NULL
             IF cl_null(sr.l_ooef016) OR cl_null(l_ooef016) THEN
                LET l_ooef016_rate = 1
             ELSE
                CALL s_aooi160_get_exrate('1',sr.bmfasite,g_today,l_ooef016,sr.l_ooef016,1,'11') RETURNING l_ooef016_rate
                IF cl_null(l_ooef016_rate) THEN
                   LET l_ooef016_rate = 1
                END IF
             END IF
             
             SELECT xccc280 INTO sfaa.xccc280
               FROM xccc_t
              WHERE xcccent = sr.bmfaent
                AND xccc006 = sr.bmfa003
             CALL abmr302_x01_nulltozero(sfaa.sfaa012) RETURNING sfaa.sfaa012
             CALL abmr302_x01_nulltozero(sfaa.sfaa050) RETURNING sfaa.sfaa050
             CALL abmr302_x01_nulltozero(sfaa.xccc280) RETURNING sfaa.xccc280
             LET sfaa.l_sfaa012_sfaa050 = sfaa.sfaa012 - sfaa.sfaa050
             IF NOT (cl_null(sfaa.sfaa012) OR cl_null(l_imaa006)) THEN
#                CALL s_aimi190_get_convert(sr.bmfa003,sfaa.sfaa012,l_imaa006) RETURNING l_success,l_imaa006_rate
#             ELSE
#                LET l_imaa006_rate = 1
                CALL s_aooi250_convert_qty(sr.bmfa003,sfaa.sfaa013,l_imaa006,sfaa.l_sfaa012_sfaa050)
                     RETURNING l_success,sfaa.l_sfaa012_sfaa050
             END IF
#             IF l_success THEN
#                LET sfaa.l_sfaa012_sfaa050 = sfaa.l_sfaa012_sfaa050 * l_imaa006_rate
#             END IF
             LET sfaa.l_sfaa012_xccc280 = sfaa.l_sfaa012_sfaa050 * sfaa.xccc280  * l_ooef016_rate
             CALL s_desc_gzcbl004_desc(5449,5) RETURNING sr.l_bmfa003_gzcbl004
             IF sfaa.l_sfaa012_sfaa050 = 0 THEN
                CONTINUE FOREACH
             END IF
             SELECT ooefl004 INTO sr.l_site_ooefl004
               FROM ooefl_t
              WHERE ooeflent = g_enterprise
                AND ooefl001 = sfaa.sfaasite
                AND ooefl002 = g_dlang
             EXECUTE insert_prep USING sr.bmfa003,sr.l_imaal003,sr.l_imaal004,sr.l_site_ooefl004,sr.l_ooef016,sr.l_bmfa003_gzcbl004,sfaa.sfaadocno,sfaa.sfaa020,sfaa.l_sfaa012_sfaa050,sfaa.sfaa013,sfaa.l_sfaa012_xccc280
                IF SQLCA.sqlcode THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.extend = "abmr302_x01_execute"
                   LET g_errparam.code   = SQLCA.sqlcode
                   LET g_errparam.popup  = FALSE
                   CALL cl_err()       
                   LET g_rep_success = 'N'
                   EXIT FOREACH
                END IF
          END FOREACH
       END IF                           
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       IF tm.a1 = 'Y' OR tm.a2 = 'Y' OR tm.a3 = 'Y' OR tm.a4 = 'Y' OR tm.a5 = 'Y' OR sr.l_count = 0 THEN
          CONTINUE FOREACH
       END IF
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.bmfa003,sr.l_imaal003,sr.l_imaal004,sr.l_site_ooefl004,sr.l_ooef016,sr.l_bmfa003_gzcbl004,sr.l_docno,sr.l_date,sr.l_count,sr.l_unit,sr.l_amount
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "abmr302_x01_execute"
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
 
{<section id="abmr302_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION abmr302_x01_rep_data()
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
 
{<section id="abmr302_x01.other_function" readonly="Y" >}

PRIVATE FUNCTION abmr302_x01_nulltozero(p_num)
   DEFINE p_num LIKE type_t.num20_6

   IF cl_null(p_num) THEN
      LET p_num = 0
   END IF

   RETURN p_num
END FUNCTION

 
{</section>}
 
