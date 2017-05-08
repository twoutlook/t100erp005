#該程式未解開Section, 採用最新樣板產出!
{<section id="aqcr010_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2016-08-17 15:26:37), PR版次:0001(2016-09-02 14:27:25)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000003
#+ Filename...: aqcr010_x01
#+ Description: ...
#+ Creator....: 05423(2016-08-17 15:06:32)
#+ Modifier...: 05423 -SD/PR- 05423
 
{</section>}
 
{<section id="aqcr010_x01.global" readonly="Y" >}
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
       wc STRING,                  #where condition 
       chk1 LIKE type_t.chr2,         #IQC.出货单 
       chk2 LIKE type_t.chr2,         #FQC.工单完工 
       chk3 LIKE type_t.chr2,         #PQC.工单制程 
       chk4 LIKE type_t.chr2,         #OQC.出货单 
       chk5 LIKE type_t.chr2,         #Inventory QC 
       chk6 LIKE type_t.chr2          #RQC.借货还货
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_qcaz001         LIKE qcaz_t.qcaz001    #品管参照表
#end add-point
 
{</section>}
 
{<section id="aqcr010_x01.main" readonly="Y" >}
PUBLIC FUNCTION aqcr010_x01(p_arg1,p_arg2,p_arg3,p_arg4,p_arg5,p_arg6,p_arg7)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr2         #tm.chk1  IQC.出货单 
DEFINE  p_arg3 LIKE type_t.chr2         #tm.chk2  FQC.工单完工 
DEFINE  p_arg4 LIKE type_t.chr2         #tm.chk3  PQC.工单制程 
DEFINE  p_arg5 LIKE type_t.chr2         #tm.chk4  OQC.出货单 
DEFINE  p_arg6 LIKE type_t.chr2         #tm.chk5  Inventory QC 
DEFINE  p_arg7 LIKE type_t.chr2         #tm.chk6  RQC.借货还货
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.chk1 = p_arg2
   LET tm.chk2 = p_arg3
   LET tm.chk3 = p_arg4
   LET tm.chk4 = p_arg5
   LET tm.chk5 = p_arg6
   LET tm.chk6 = p_arg7
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   LET g_qcaz001 = cl_get_para(g_enterprise,g_site,'S-MFG-0046')
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "aqcr010_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL aqcr010_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL aqcr010_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL aqcr010_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL aqcr010_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL aqcr010_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="aqcr010_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION aqcr010_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "qcba000.qcba_t.qcba000,l_qcba000_desc.gzcbl_t.gzcbl004,l_qcba000_qcba031.gzcbl_t.gzcbl004,qcba001.qcba_t.qcba001,qcba002.qcba_t.qcba002,qcba029.qcba_t.qcba029,qcba010.qcba_t.qcba010,l_imaal003.imaal_t.imaal003,l_imaal004.imaal_t.imaal004,qcba013.qcba_t.qcba013,l_qcba013_desc.oocql_t.oocql004,qcba012.qcba_t.qcba012,l_qcba012_desc.inaml_t.inaml004,qcba006.qcba_t.qcba006,l_qcba006_desc.gzzal_t.gzzal003,qcba007.qcba_t.qcba007,qcba005.qcba_t.qcba005,l_qcba005_desc.pmaal_t.pmaal004,l_result.oocql_t.oocql004" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   DROP TABLE aqcr010_x01_data
   CREATE TEMP TABLE aqcr010_x01_data(
   qcbaent LIKE qcba_t.qcbaent,
   qcbasite LIKE qcba_t.qcbasite,
   qcba000 LIKE qcba_t.qcba000, 
   qcba031 LIKE qcba_t.qcba031, 
   qcba001 LIKE qcba_t.qcba001, 
   qcba002 LIKE qcba_t.qcba002, 
   qcba029 LIKE qcba_t.qcba029, 
   qcba010 LIKE qcba_t.qcba010, 
   qcba013 LIKE qcba_t.qcba013, 
   qcba012 LIKE qcba_t.qcba012, 
   qcba006 LIKE qcba_t.qcba006, 
   l_qcba006_desc LIKE gzzal_t.gzzal003, 
   qcba007 LIKE qcba_t.qcba007, 
   qcba005 LIKE qcba_t.qcba005,
   l_num   LIKE qcba_t.qcba017
   )
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="aqcr010_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION aqcr010_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="aqcr010_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aqcr010_x01_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define(客製用) name="sel_prep.define_customerization"

#end add-point
#add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
DEFINE l_sql_ins     STRING
DEFINE l_sql         STRING      #检验结果判断，sql准备
DEFINE g_order       STRING      
#end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
 
   #add-point:sel_prep g_select name="sel_prep.g_select"
   #根據選擇的範圍找出符合檢驗數量大於零的資料                              
   LET g_select = " SELECT DISTINCT qcba000,",
                  " (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '5056' AND gzcbl002 = qcba000 AND gzcbl003 = '",g_dlang,"') t1_gzcbl004,",
                  " qcba031,NULL,qcba001,qcba002,qcba029,qcba010,",
                  " (SELECT imaal003 FROM imaal_t WHERE imaalent = ",g_enterprise," AND imaal001 = qcba010 AND imaal002 = '",g_dlang,"') t2_imaal003,",
                  " (SELECT imaal004 FROM imaal_t WHERE imaalent = ",g_enterprise," AND imaal001 = qcba010 AND imaal002 = '",g_dlang,"') t2_imaal004,",
                  " qcba013, ",
                  " (SELECT oocql004 FROM oocql_t WHERE oocqlent = ",g_enterprise," AND oocql001 = '205' AND oocql002 = qcba013 AND oocql003 = '",g_dlang,"') t3_oocql004,",
                  " qcba012,",
                  " (SELECT inaml004 FROM inaml_t WHERE inamlent = ",g_enterprise," AND inaml001 = qcba010 AND inaml002 = qcba012 AND inaml003 = '",g_dlang,"') t4_inaml004,",
                  " qcba006,l_qcba006_desc,",
#                  " (SELECT gzzal003 FROM gzzal_t WHERE gzzal001= qcba006 AND gzzal002='",g_dlang,"') t5_gzzal003,",
                  " qcba007,qcba005,",
                  " (SELECT pmaal004 FROM pmaal_t WHERE pmaalent = ",g_enterprise," AND pmaal001 = qcba005 AND pmaal002 = '",g_dlang,"') t6_pmaal004,",
                  " NULL"   #检验结果
#   #end add-point
#   LET g_select = " SELECT qcba000,NULL,qcba031,NULL,qcba001,qcba002,qcba029,qcba010,NULL,NULL,qcba013, 
#       NULL,qcba012,NULL,qcba006,NULL,qcba007,qcba005,NULL,NULL"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_from = " FROM aqcr010_x01_data ",
                "             LEFT OUTER JOIN imaa_t ON imaaent = qcbaent AND imaa001 = qcba010 ",
                "             LEFT OUTER JOIN imae_t ON imaeent = qcbaent AND imaesite = qcbasite AND imae001 = qcba010 "
#   #end add-point
#    LET g_from = " FROM qcba_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
    LET g_where = " WHERE l_num > '0' AND " ,tm.wc CLIPPED
#   #end add-point
#    LET g_where = " WHERE qcba_t.qcba017 > '0' AND " ,tm.wc CLIPPED
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   #总判断：依照條件去品質檢驗標準設定作業aqci010撈，是否有符合的檢驗專案（当料件的未检核数量大于0时，才需进行判断）
   LET l_sql = " SELECT COUNT(*) ",
               "   FROM qcam_t ",
               "  WHERE qcam001 = '",g_qcaz001,"' ",
               "    AND (qcam002 = ? OR qcam002 = 'ALL') ",    #qcba013
               "    AND (qcam003 = ? OR qcam003 = 'ALL') ",    #qcba010 
               "    AND (qcam004 = ? OR qcam004 = 'ALL') ",    #qcba012 
               "    AND (qcam005 = ? OR qcam005 = 'ALL') ",    #qcba006 
               "    AND (qcam006 = ? OR qcam006 = 0) ",        #qcba007 
               "    AND (qcam008 = ? OR qcam008 = 'ALL') ",    #qcba005 
               "    AND (qcam009 = ? OR qcam009 = '0') ",      #qcba000 
               "    AND qcamstus = 'Y' "
   #IF cl_null(l_n) OR l_n = 0 THEN 產生報表資料，檢驗結果為"無法找到符合的品質檢驗標準設定作業(aqci010)資料" END IF
   PREPARE aqcr010_x01_qcam_pre FROM l_sql
   DECLARE aqcr010_x01_qcam_cur CURSOR FOR aqcr010_x01_qcam_pre
   DELETE FROM aqcr010_x01_data
   #IQC（来源出货单）大于零则继续
   IF tm.chk1 = 'Y' THEN
#      LET l_sql = " SELECT pmdt020-NVL(SUM(qcba0170,0) ",
#                  "   FROM pmds_t INNER JOIN pmdt_t ON pmdsdocno = pmdtdocno AND pmdsent = pmdtent ",
#                  "               LEFT OUTER JOIN qcba_t ON qcbaent = pmdtent AND qcbasite = pmdtsite AND qcba001 = pmdtdocno AND qcba002 = pmdtseq AND qcba000 = '1' AND qcbastus <> 'X' ",
#                  "  WHERE pmdsent = ",g_enterprise," AND pmdssite = '",g_site,"' ",
#                  "    AND pmdsstus = 'Y' AND pmds000 IN ('1','2') AND pmdt026 = 'Y' ",
#                  "    AND pmdsdocno = ? AND pmdtseq = ? ",
#                  "  GROUP BY pmdsdocno,pmdtseq,pmdt020 "
#      PREPARE aqcr010_x01_iqc_pre FROM l_sql
#      DECLARE aqcr010_x01_iqc_cur CURSOR FOR aqcr010_x01_iqc_pre
      LET l_sql = " SELECT pmdsent,pmdssite,'1','',pmdtdocno,pmdtseq,NULL,pmdt006,imae111,pmdt007,NULL,NULL,NULL,pmds007,pmdt020-NVL(SUM(qcba017),0) ",
                  "   FROM pmds_t INNER JOIN pmdt_t ON pmdsdocno = pmdtdocno AND pmdsent = pmdtent ",
                  "               LEFT OUTER JOIN qcba_t ON qcbaent = pmdtent AND qcbasite = pmdtsite AND qcba001 = pmdtdocno AND qcba002 = pmdtseq AND qcba000 = '1' AND qcbastus <> 'X' ",
                  "               LEFT OUTER JOIN imaa_t ON imaaent = pmdtent AND imaa001 = pmdt006 ",
                  "               LEFT OUTER JOIN imae_t ON imaeent = pmdtent AND imaesite = pmdtsite AND imae001 = pmdt006 ",
                  "  WHERE pmdsent = ",g_enterprise," AND pmdssite = '",g_site,"' AND pmdt026='Y' ",
                  "    AND pmdsstus = 'Y' AND pmds000 IN ('1','2')  AND " ,tm.wc CLIPPED,
                  "  GROUP BY pmdsent,pmdssite,pmdtdocno,pmdtseq,pmdt006,imae111,pmdt007,pmds007,pmdt020 ",
                  " HAVING pmdt020-NVL(SUM(qcba017),0)>0 "    
      LET l_sql_ins ="INSERT INTO aqcr010_x01_data ",l_sql
      EXECUTE IMMEDIATE l_sql_ins 
   END IF
   #FQC
   IF tm.chk2 = 'Y' THEN
#      LET l_sql = " SELECT sfeb008-NVL(SUM(qcba017),0) ",
#                  "   FROM sfeb_t INNER JOIN sfea_t ON sfeadocno = sfebdocno AND sfeaent = sfebent AND sfeasite = sfebsite AND sfeastus = 'Y' AND sfea006 IS NULL ",
#                  "               INNER JOIN sfaa_t ON sfaadocno = sfeb001 AND sfaaent = sfebent AND sfaasite = sfebsite ",
#                  "               LEFT OUTER JOIN qcba_t ON qcbaent = sfebent AND qcbasite = sfebsite AND qcba001 = sfebdocno AND qcba002 = sfebseq AND qcba000 = '2' AND qcbastus <> 'X' ",
#                  "  WHERE sfebent = ",g_enterprise," AND sfebsite = '",g_site,"' AND sfeb002 = 'Y' ",
#                  "    AND sfebdocno = ? AND sfebseq = ? ",
#                  "  GROUP BY sfebdocno,sfebseq,sfeb008 "
#      PREPARE aqcr010_x01_fqc_pre FROM l_sql
#      DECLARE aqcr010_x01_fqc_cur CURSOR FOR aqcr010_x01_fqc_pre
      LET l_sql = " SELECT sfebent,sfebsite,'2','',sfebdocno,sfebseq,NULL,sfeb004,imae111,sfeb005,NULL,NULL,NULL,sfaa009,sfeb008-NVL(SUM(qcba017),0) ",
                  "   FROM sfeb_t INNER JOIN sfea_t ON sfeadocno = sfebdocno AND sfeaent = sfebent AND sfeasite = sfebsite AND sfeastus = 'Y' AND sfea006 IS NULL ",
                  "               INNER JOIN sfaa_t ON sfaadocno = sfeb001 AND sfaaent = sfebent AND sfaasite = sfebsite ",
                  "               LEFT OUTER JOIN qcba_t ON qcbaent = sfebent AND qcbasite = sfebsite AND qcba001 = sfebdocno AND qcba002 = sfebseq AND qcba000 = '2' AND qcbastus <> 'X' ",
                  "               LEFT OUTER JOIN imaa_t ON imaaent = sfebent AND imaa001 = sfeb004 ",
                  "               LEFT OUTER JOIN imae_t ON imaeent = sfebent AND imaesite = sfebsite AND imae001 = sfeb004 ",
                  "  WHERE sfebent = ",g_enterprise," AND sfebsite = '",g_site,"' AND sfeb002 = 'Y' AND sfaa044 = 'Y' AND " ,tm.wc CLIPPED,
                  "  GROUP BY sfebent,sfebsite,sfebdocno,sfebseq,sfeb004,imae111,sfeb005,sfaa009,sfeb008 ",
                  " HAVING sfeb008-NVL(SUM(qcba017),0)>0 "
      LET l_sql_ins ="INSERT INTO aqcr010_x01_data ",l_sql
      EXECUTE IMMEDIATE l_sql_ins 
   END IF
   #PQC
   IF tm.chk3 = 'Y' THEN
#      LET l_sql = " SELECT sfcb050 - NVL(SUM(qcba017),0) ",
#                  "   FROM sfcb_t INNER JOIN sfca_t ON sfcadocno = sfcbdocno AND sfcaent = sfcbent AND sfcasite = sfcbsite AND sfca001 = sfcb001 ",
#                  "             INNER JOIN sfaa_t ON sfaadocno = sfcbdocno AND sfaastus = 'F' AND sfaaent = sfcbent AND sfaasite = sfcbsite",
#                  "             LEFT OUTER JOIN qcba_t ON qcbaent = sfcbent AND qcbasite = sfcbsite AND qcba001 = sfcbdocno AND qcba002 = sfcb002 AND qcba029 = sfcb001 AND qcba000 = '3' AND qcbastus <> 'X' ",
#                  "  WHERE sfcbent = ",g_enterprise," AND sfcbsite = '",g_site,"' AND sfcb017 = 'Y' AND sfcb050 > 0 ",
#                  "    AND sfcbdocno = ? AND sfcb002 = ? ",
#                  "  GROUP BY sfcbdocno,sfcb002,sfcb050 "
#      PREPARE aqcr010_x01_pqc_pre FROM l_sql
#      DECLARE aqcr010_x01_pqc_cur CURSOR FOR aqcr010_x01_pqc_pre
      LET l_sql = " SELECT sfcbent,sfcbsite,'3','',sfcbdocno,sfcb002,sfcb001,sfaa010,imae111,NULL,sfcb003,gzzal003,sfcb004,sfaa009,sfcb050 - NVL(SUM(qcba017),0) ",
                  "   FROM sfcb_t INNER JOIN sfca_t ON sfcadocno = sfcbdocno AND sfcaent = sfcbent AND sfcasite = sfcbsite AND sfca001 = sfcb001 ",
                  "               INNER JOIN sfaa_t ON sfaadocno = sfcbdocno AND sfaastus = 'F' AND sfaaent = sfcbent AND sfaasite = sfcbsite",
                  "               LEFT OUTER JOIN qcba_t ON qcbaent = sfcbent AND qcbasite = sfcbsite AND qcba001 = sfcbdocno AND qcba002 = sfcb002 AND qcba029 = sfcb001 AND qcba000 = '3' AND qcbastus <> 'X' ",
                  "               LEFT OUTER JOIN gzzal_t ON  gzzal001= sfcb003 AND gzzal002='",g_dlang,"' ",
                  "               LEFT OUTER JOIN imaa_t ON imaaent = sfaaent AND imaa001 = sfaa010 ",
                  "               LEFT OUTER JOIN imae_t ON imaeent = sfaaent AND imaesite = sfaasite AND imae001 = sfaa010 ",
                  "  WHERE sfcbent = ",g_enterprise," AND sfcbsite = '",g_site,"' AND sfcb017 = 'Y' AND sfcb050 > 0 AND " ,tm.wc CLIPPED,
                  "  GROUP BY sfcbent,sfcbsite,sfcbdocno,sfcb002,sfcb001,sfaa010,imae111,sfcb003,gzzal003,sfcb004,sfaa009,sfcb050 ",
                  " HAVING sfcb050 - NVL(SUM(qcba017),0)>0 "
      LET l_sql_ins ="INSERT INTO aqcr010_x01_data ",l_sql
      EXECUTE IMMEDIATE l_sql_ins 
   END IF
   #OQC
   IF tm.chk4 = 'Y' THEN
      #分为出货单、出货通知单，根据S-BAS-0094进行判定
         # LET l_para = cl_get_doc_para(g_enterprise,g_site,l_slip,'D-BAS-0094')
      #2.4.1.1. 出貨單  
#      LET l_sql = " SELECT xmdl018-NVL(SUM(qcba017),0)",
#                  "   FROM xmdk_t INNER JOIN xmdl_t ON xmdkent = xmdlent AND xmdksite = xmdlsite AND xmdkdocno = xmdldocno AND xmdl023 = 'Y' ",
#                  "               INNER JOIN xmdd_t ON xmddent = xmdlent AND xmddsite = xmdlsite AND xmdddocno = xmdl003 AND xmddseq = xmdl004  AND xmddseq1 =xmdl005 AND xmddseq2 = xmdl006 ",
#                  "               LEFT OUTER JOIN qcba_t ON qcbaent = xmdlent AND qcbasite = xmdlsite AND qcba001 = xmdldocno AND qcba002 = xmdlseq AND qcba000 = '4' AND qcbastus <> 'X' ",
#                  "  WHERE xmdkent = ",g_enterprise," AND xmdksite = '",g_site,"' ",
#                  "    AND xmdkstus = 'Y' AND xmdk000 IN ('1','2') AND xmdk002 <> '2' ",
#                  "    AND xmdkdocno = ? AND xmdlseq = ? ",
#                  "  GROUP BY xmdkdocno,xmdlseq,xmdl018 "
#      PREPARE aqcr010_x01_oqc1_pre FROM l_sql
#      DECLARE aqcr010_x01_oqc1_cur CURSOR FOR aqcr010_x01_oqc1_pre
      LET l_sql = " SELECT xmdkent,xmdksite,'4','2',xmdldocno,xmdlseq,NULL,xmdl008,imae111,xmdl009,NULL,NULL,NULL,xmdk007,xmdl018-NVL(SUM(qcba017),0)",
                  "   FROM xmdk_t INNER JOIN xmdl_t ON xmdkent = xmdlent AND xmdksite = xmdlsite AND xmdkdocno = xmdldocno AND xmdl023 = 'Y' ",
                  "               INNER JOIN xmdd_t ON xmddent = xmdlent AND xmddsite = xmdlsite AND xmdddocno = xmdl003 AND xmddseq = xmdl004  AND xmddseq1 =xmdl005 AND xmddseq2 = xmdl006 ",
                  "               LEFT OUTER JOIN qcba_t ON qcbaent = xmdlent AND qcbasite = xmdlsite AND qcba001 = xmdldocno AND qcba002 = xmdlseq AND qcba000 = '4' AND qcbastus <> 'X' ",
                  "               LEFT OUTER JOIN imaa_t ON imaaent = xmdlent AND imaa001 = xmdl008 ",
                  "               LEFT OUTER JOIN imae_t ON imaeent = xmdlent AND imaesite = xmdlsite AND imae001 = xmdl008 ",
                  "  WHERE xmdkent = ",g_enterprise," AND xmdksite = '",g_site,"' ",
                  "    AND xmdkstus = 'Y' AND xmdk000 IN ('1','2') AND xmdk002 <> '2' AND " ,tm.wc CLIPPED,
                  "  GROUP BY xmdkent,xmdksite,xmdldocno,xmdlseq,xmdl008,imae111,xmdl009,xmdk007,xmdl018 ",
                  " HAVING xmdl018-NVL(SUM(qcba017),0)>0 "
      LET l_sql_ins ="INSERT INTO aqcr010_x01_data ",l_sql
      EXECUTE IMMEDIATE l_sql_ins 
      #2.4.1.2. 出通單
#      LET l_sql = " SELECT xmdh016-NVL(SUM(qcba017),0) ",
#                  "   FROM xmdg_t INEER JOIN xmdh_t ON xmdgent = xmdhent AND xmdgsite = xmdhsite AND xmdgdocno = xmdhdocno AND xmdh022 = 'Y' ",
#                  "               INNER JOIN xmdd_t ON xmddent = xmdhent AND xmddsite = xmdhsite AND xmdddocno = xmdh001 AND xmddseq = xmdh002  AND xmddseq1 =xmdh003 AND xmddseq2 = xmdh004 ",
#                  "               LEFT OUTER JOIN qcba_t ON qcbaent = xmdhent AND qcbasite = xmdhsite AND qcba001 = xmdhdocno AND qcba002 = xmdhseq AND qcba000 = '4' AND qcbastus <> 'X' ",
#                  "  WHERE xmdgent = ",g_enterprise," AND xmdgsite = '",g_site,"' AND xmdgstus = 'Y' ",
#                  "    AND xmdhdocno = ? AND xmdhseq = ? ",
#                  "  GROUP BY xmdhdocno,xmdhseq,xmdh016 "
#      PREPARE aqcr010_x01_oqc2_pre FROM l_sql
#      DECLARE aqcr010_x01_oqc2_cur CURSOR FOR aqcr010_x01_oqc2_pre
      LET l_sql = " SELECT xmdgent,xmdgsite,'4','1',xmdhdocno,xmdhseq,NULL,xmdh006,imae111,xmdh007,NULL,NULL,NULL,xmdg005,xmdh016-NVL(SUM(qcba017),0) ",
                  "   FROM xmdg_t INEER JOIN xmdh_t ON xmdgent = xmdhent AND xmdgsite = xmdhsite AND xmdgdocno = xmdhdocno AND xmdh022 = 'Y' ",
                  "               INNER JOIN xmdd_t ON xmddent = xmdhent AND xmddsite = xmdhsite AND xmdddocno = xmdh001 AND xmddseq = xmdh002  AND xmddseq1 =xmdh003 AND xmddseq2 = xmdh004 ",
                  "               LEFT OUTER JOIN qcba_t ON qcbaent = xmdhent AND qcbasite = xmdhsite AND qcba001 = xmdhdocno AND qcba002 = xmdhseq AND qcba000 = '4' AND qcbastus <> 'X' ",
                  "               LEFT OUTER JOIN imaa_t ON imaaent = xmdhent AND imaa001 = xmdh006 ",
                  "               LEFT OUTER JOIN imae_t ON imaeent = xmdhent AND imaesite = xmdhsite AND imae001 = xmdh006 ",
                  "  WHERE xmdgent = ",g_enterprise," AND xmdgsite = '",g_site,"' AND xmdgstus = 'Y' AND " ,tm.wc CLIPPED,
                  "  GROUP BY xmdgent,xmdgsite,xmdhdocno,xmdhseq,xmdh006,imae111,xmdh007,xmdg005,xmdh016 ",
                  " HAVING xmdh016-NVL(SUM(qcba017),0)>0 "
      LET l_sql_ins ="INSERT INTO aqcr010_x01_data ",l_sql
      EXECUTE IMMEDIATE l_sql_ins 
#      2.4.1.3. OQC決定檢驗的時間點會分是在 出通單 還是 出貨單，所以上面二個SQL撈出來後，還要依訂單單別決定需不需要檢驗，
#               使用訂單單別到aooi200找參數 D-BAS-0094 OQC檢驗時機，1代表出通時檢驗，2代表出貨時檢驗
   END IF
   #Inventory QC
   IF tm.chk5 = 'Y' THEN
      #2.5.1.1. 杂收发
#      LET l_sql = " SELECT inbb011-NVL(SUM(qcba017),0),inba001 ",
#                  "   FROM inbb_t INNER JOIN inba_t ON inbaent = inbbent AND inbadocno = inbbdocno AND inbastus = 'Y' ",
#                  "               LEFT OUTER JOIN qcba_t ON qcbaent = inbbent AND qcbasite = inbbsite AND qcba001 = inbbdocno AND qcba002 = inbbseq AND qcba000 = '5' AND qcbastus <> 'X' ",
#                  "               INNER JOIN imae_t ON inbbent = imaeent AND inbbsite = imaesite AND inbb001 = imae001 ",
#                  "  WHERE inbb018 = 'Y' AND inbbent = ",g_enterprise," AND inbbsite = '",g_site,"' ",
#                  "    AND inbbdocno = ? AND inbbseq = ? ",
#                  "  GROUP BY inbbdocno,inbbseq,inbb011,inba001 "
#      PREPARE aqcr010_x01_invqc1_pre FROM l_sql
#      DECLARE aqcr010_x01_invqc1_cur CURSOR FOR aqcr010_x01_invqc1_pre
      LET l_sql = " SELECT inbbent,inbbsite,'5',inba001,inbbdocno,inbbseq,NULL,inbb001,imae111,inbb002,NULL,NULL,NULL,NULL,inbb011-NVL(SUM(qcba017),0) ",
                  "   FROM inbb_t INNER JOIN inba_t ON inbaent = inbbent AND inbadocno = inbbdocno AND inbastus = 'Y' ",
                  "               LEFT OUTER JOIN qcba_t ON qcbaent = inbbent AND qcbasite = inbbsite AND qcba001 = inbbdocno AND qcba002 = inbbseq AND qcba000 = '5' AND qcbastus <> 'X' ",
                  "               INNER JOIN imae_t ON inbbent = imaeent AND inbbsite = imaesite AND inbb001 = imae001 ",
                  "               LEFT OUTER JOIN imaa_t ON inbbent = imaaent AND inbb001 = imaa001 ",
                  "  WHERE inbb018 = 'Y' AND inbbent = ",g_enterprise," AND inbbsite = '",g_site,"' AND " ,tm.wc CLIPPED,
                  "  GROUP BY inbbent,inbbsite,inba001,inbbdocno,inbbseq,inbb001,imae111,inbb002,inbb011 ",
                  " HAVING inbb011-NVL(SUM(qcba017),0)>0 "
      LET l_sql_ins ="INSERT INTO aqcr010_x01_data ",l_sql
      EXECUTE IMMEDIATE l_sql_ins 
      
      #2.5.1.2. 調撥
#      LET l_sql = " SELECT indd103-NVL(SUM(qcba017),0),DECODE(indc000,'1','3','4') ",
#                  "   FROM indd_t INNER JOIN indc_t ON indcent = inddent AND indcsite = inddsite AND indcdocno = indddocno AND ((indcstus = 'O' AND indc102 = '2') OR (indcstus = 'P' AND indc102 = '3')) ",
#                  "               INNER JOIN imae_t ON imaeent = inddent AND imaesite = inddsite AND indd002 = imae001 ",
#                  "               LEFT OUTER JOIN LEFT OUTER JOIN qcba_t ON qcbaent = inddent AND qcbasite = inddsite AND qcba001 = indddocno AND qcba002 = inddseq AND qcba000 = '5' AND qcbastus <> 'X' ",
#                  "  WHERE indd040 <> 'Y' AND inddent = ",g_enterprise," AND inddsite = '",g_site,"' ",
#                  "    AND indddocno = ? AND inddseq = ? ",
#                  "  GROUP BY indddocno,inddseq,indd103 "
#      PREPARE aqcr010_x01_invqc2_pre FROM l_sql
#      DECLARE aqcr010_x01_invqc2_cur CURSOR FOR aqcr010_x01_invqc2_pre
      LET l_sql = " SELECT inddent,inddsite,'5',(CASE WHEN indc000 = '1' THEN '3' ELSE '4' END),indddocno,inddseq,NULL,indd002,imae111,indd004,NULL,NULL,NULL,NULL,indd103-NVL(SUM(qcba017),0)",
                  "   FROM indd_t INNER JOIN indc_t ON indcent = inddent AND indcsite = inddsite AND indcdocno = indddocno AND ((indcstus = 'O' AND indc102 = '2') OR (indcstus = 'P' AND indc102 = '3')) ",
                  "               INNER JOIN imae_t ON imaeent = inddent AND imaesite = inddsite AND indd002 = imae001 ",
                  "               LEFT OUTER JOIN imaa_t ON imaaent = inddent AND indd002 = imaa001 ",
                  "               LEFT OUTER JOIN qcba_t ON qcbaent = inddent AND qcbasite = inddsite AND qcba001 = indddocno AND qcba002 = inddseq AND qcba000 = '5' AND qcbastus <> 'X' ",
                  "  WHERE inddent = ",g_enterprise," AND inddsite = '",g_site,"' AND " ,tm.wc CLIPPED,
                  "  GROUP BY inddent,inddsite,indc000,indddocno,inddseq,indd002,imae111,indd004,indd103,indd107 ",
                  " HAVING indd103-NVL(SUM(qcba017),0)>0 "
      LET l_sql_ins ="INSERT INTO aqcr010_x01_data ",l_sql
      EXECUTE IMMEDIATE l_sql_ins 

      #2.5.1.3. 報廢
      LET l_sql = " SELECT inbient,inbisite,'5','5',inbjdocno,inbjseq,NULL,inbj001,imae111,inbj002,NULL,NULL,NULL,NULL,inbj009 -NVL(SUM(qcba017),0) ",
                  "   FROM inbj_t INNER JOIN inbi_t ON inbient = inbjent AND inbisite = inbjsite AND inbidocno = inbjdocno ",
                  "               INNER JOIN imae_t ON inbjent = imaeent AND inbjsite = imaesite AND inbj001 = imae001 ",
                  "               LEFT OUTER JOIN imaa_t ON inbjent = imaaent AND inbj001 = imaa001 ",
                  "               LEFT OUTER JOIN qcba_t ON qcbaent = inbjent AND qcbasite = inbjsite AND qcba001 = inbjdocno AND qcba002 = inbjseq AND qcba000 = '5' AND qcbastus <> 'X' ",
                  "  WHERE inbistus = 'O' AND inbi004 = 'Y' AND inbient = ",g_enterprise," AND inbisite = '",g_site ,"' AND " ,tm.wc CLIPPED,
                  "  GROUP BY inbient,inbisite,inbjdocno,inbjseq,inbj001,imae111,inbj002,inbj009 ",
                  " HAVING inbj009 -NVL(SUM(qcba017),0)>0 "
      LET l_sql_ins ="INSERT INTO aqcr010_x01_data ",l_sql
      EXECUTE IMMEDIATE l_sql_ins 

      #2.5.1.4. 倉庫檢驗
      LET l_sql = " SELECT qcbnent,qcbnsite,'5','6',qcbndocno,NULL,NULL,qcba003,imae111,qcbn004,NULL,NULL,NULL,qcbn009,qcbn011 -NVL(SUM(qcba017),0) ",
                  "   FROM qcbn_t INNER JOIN imae_t ON qcbnent = imaeent AND qcbnsite = imaesite AND qcbn003 = imae001 ",
                  "               LEFT OUTER JOIN imaa_t ON qcbnent = imaaent AND qcbn003 = imaa001 ",
                  "               LEFT OUTER JOIN qcba_t ON qcbaent = qcbnent AND qcbasite = qcbnsite AND qcba001 = qcbndocno AND qcba000 = '5' AND qcbastus <> 'X' ",
                  "  WHERE qcbnstus = 'Y' AND qcbnent = ",g_enterprise ," AND qcbnsite = '",g_site ,"' AND " ,tm.wc CLIPPED,
                  "  GROUP BY qcbnent,qcbnsite,qcbndocno,qcba003,imae111,qcbn004,qcbn009,qcbn011 ",
                  " HAVING qcbn011 -NVL(SUM(qcba017),0)>0 "
      LET l_sql_ins ="INSERT INTO aqcr010_x01_data ",l_sql
      EXECUTE IMMEDIATE l_sql_ins 
   END IF
   #RQC
   IF tm.chk6 = 'Y' THEN
      LET l_sql = " SELECT xmdkent,xmdksite,'6','',xmdldocno,xmdlseq,NULL,xmdl008,imae111,xmdl009,NULL,NULL,NULL,xmdk007,xmdl092-NVL(SUM(qcba017),0) ",
                  "   FROM xmdk_t INNER JOIN xmdl_t ON xmdkent = xmdlent AND xmdksite = xmdlsite AND xmdkdocno = xmdldocno AND xmdl023 = 'Y' ",
                  "               INNER JOIN xmdd_t ON xmddent = xmdlent AND xmddsite = xmdlsite AND xmdddocno = xmdl003 AND xmddseq = xmdl004  AND xmddseq1 =xmdl005 AND xmddseq2 = xmdl006 ",
                  "               LEFT OUTER JOIN qcba_t ON qcbaent = xmdlent AND qcbasite = xmdlsite AND qcba001 = xmdldocno AND qcba002 = xmdlseq AND qcba000 = '4' AND qcbastus <> 'X' ",
                  "               LEFT OUTER JOIN imaa_t ON imaaent = xmdlent AND imaa001 = xmdl008 ",
                  "               LEFT OUTER JOIN imae_t ON imaeent = xmdlent AND imaesite = xmdlsite AND imae001 = xmdl008 ",
                  "  WHERE xmdkent = ",g_enterprise ," AND xmdksite = '",g_site,"' AND xmdkstus = 'Y' AND xmdk000 = '7'  AND xmdk002 <> '2' AND ",tm.wc CLIPPED,
                  "  GROUP BY xmdkent,xmdksite,xmdldocno,xmdlseq,xmdl008,imae111,xmdl009,xmdk007,xmdl092 ",
                  " HAVING xmdl092-NVL(SUM(qcba017),0)>0"
      LET l_sql_ins ="INSERT INTO aqcr010_x01_data ",l_sql
      EXECUTE IMMEDIATE l_sql_ins 
   END IF
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   LET g_order = " ORDER BY qcba000,qcba031 "
   LET g_where = g_where ,cl_sql_add_filter("qcba_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
#   #end add-point:sel_prep.sql.before
#   LET g_where = g_where ,cl_sql_add_filter("qcba_t")   #資料過濾功能
#   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
#   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
# 
#   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE aqcr010_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE aqcr010_x01_curs CURSOR FOR aqcr010_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="aqcr010_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION aqcr010_x01_ins_data()
DEFINE sr RECORD 
   qcba000 LIKE qcba_t.qcba000, 
   l_qcba000_desc LIKE gzcbl_t.gzcbl004, 
   qcba031 LIKE qcba_t.qcba031, 
   l_qcba000_qcba031 LIKE gzcbl_t.gzcbl004, 
   qcba001 LIKE qcba_t.qcba001, 
   qcba002 LIKE qcba_t.qcba002, 
   qcba029 LIKE qcba_t.qcba029, 
   qcba010 LIKE qcba_t.qcba010, 
   l_imaal003 LIKE imaal_t.imaal003, 
   l_imaal004 LIKE imaal_t.imaal004, 
   qcba013 LIKE qcba_t.qcba013, 
   l_qcba013_desc LIKE oocql_t.oocql004, 
   qcba012 LIKE qcba_t.qcba012, 
   l_qcba012_desc LIKE inaml_t.inaml004, 
   qcba006 LIKE qcba_t.qcba006, 
   l_qcba006_desc LIKE gzzal_t.gzzal003, 
   qcba007 LIKE qcba_t.qcba007, 
   qcba005 LIKE qcba_t.qcba005, 
   l_qcba005_desc LIKE pmaal_t.pmaal004, 
   l_result LIKE oocql_t.oocql004
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_n        LIKE type_t.num10
DEFINE l_num      LIKE type_t.num10
DEFINE l_para     LIKE type_t.chr1
DEFINE l_slip     STRING
DEFINE l_success  LIKE type_t.num5
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH aqcr010_x01_curs INTO sr.*                               
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
       IF tm.chk4 = 'Y' AND sr.qcba000 = '4' THEN  #获取是出通单还是出货单进行判断
          IF NOT cl_null(sr.qcba001) THEN
             CALL s_aooi200_get_slip(sr.qcba001) RETURNING l_success,l_slip
             IF l_success THEN
                LET l_para = cl_get_doc_para(g_enterprise,g_site,l_slip,'D-BAS-0094')
                IF l_para = '1' AND sr.qcba031 <> '1' THEN
                   CONTINUE FOREACH
                END IF 
             ELSE 
                CONTINUE FOREACH
             END IF
          ELSE 
             CONTINUE FOREACH
          END IF
       END IF
       #根据检验类型+类型分类，获取类型分类名称：
       CALL aqcr010_x01_type_desc(sr.qcba000,sr.qcba031) RETURNING sr.l_qcba000_qcba031
       LET l_n = 0
       LET l_num = 0
       EXECUTE aqcr010_x01_qcam_cur USING sr.qcba013,sr.qcba010,sr.qcba012,sr.qcba006,sr.qcba007,sr.qcba005,sr.qcba000 INTO l_n
       #IF cl_null(l_n) OR l_n = 0 THEN 產生報表資料，檢驗結果為"無法找到符合的品質檢驗標準設定作業(aqci010)資料" END IF
       IF cl_null(l_n) OR l_n = 0 THEN 
          LET sr.l_result = cl_getmsg("aqc-00136",g_dlang)     #無法找到符合的品質檢驗標準設定作業(aqci010)資料
       ELSE 
          CONTINUE FOREACH
       END IF
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.qcba000,sr.l_qcba000_desc,sr.l_qcba000_qcba031,sr.qcba001,sr.qcba002,sr.qcba029,sr.qcba010,sr.l_imaal003,sr.l_imaal004,sr.qcba013,sr.l_qcba013_desc,sr.qcba012,sr.l_qcba012_desc,sr.qcba006,sr.l_qcba006_desc,sr.qcba007,sr.qcba005,sr.l_qcba005_desc,sr.l_result
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "aqcr010_x01_execute"
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
 
{<section id="aqcr010_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION aqcr010_x01_rep_data()
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
 
{<section id="aqcr010_x01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 获取类型分类的说明
# Memo...........: 根據qcba000+qcba031再區分
# Memo...........:   qcba000 = 1 為收貨檢驗
# Memo...........:   qcba000 = 2 為完工入庫檢驗
# Memo...........:   qcba000 = 3 為工單制程檢驗
# Memo...........:   qcba000 = 4 & qcba031 = 1 為出貨通知單
# Memo...........:   qcba000 = 4 & qcba031 = 2 為出貨單
# Memo...........:   qcba000 = 5 & qcba031 = 1 為雜項發料
# Memo...........:   qcba000 = 5 & qcba031 = 2 為雜項收料
# Memo...........:   qcba000 = 5 & qcba031 = 3 為一階段調撥
# Memo...........:   qcba000 = 5 & qcba031 = 4 為二階段調撥
# Memo...........:   qcba000 = 5 & qcba031 = 5 為報廢申請
# Memo...........:   qcba000 = 5 & qcba031 = 6 為倉庫檢驗
# Memo...........:   qcba000 = 6 為借貨還貨檢驗
# Usage..........: CALL aqcr010_x01_type_desc(p_qcba000,p_qcba031)
#                  RETURNING r_desc
# Date & Author..: 2016-8-17 By zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION aqcr010_x01_type_desc(p_qcba000,p_qcba031)
DEFINE p_qcba000     LIKE qcba_t.qcba000
DEFINE p_qcba031     LIKE qcba_t.qcba031
DEFINE r_desc        LIKE oocql_t.oocql004
   
   LET r_desc = NULL
   CASE p_qcba000
      WHEN '1' 
         LET r_desc = cl_getmsg("aqc-00137",g_dlang) #收货检验
      WHEN '2'
         LET r_desc = cl_getmsg("aqc-00138",g_dlang) #完工入库检验
      WHEN '3'
         LET r_desc = cl_getmsg("aqc-00139",g_dlang) #工单制程检验
      WHEN '4' #5061
         SELECT gzcbl004 INTO r_desc
           FROM gzcbl_t
          WHERE gzcbl001 = '5061'
            AND gzcbl002 = p_qcba031
            AND gzcbl003 = g_dlang
      WHEN '5' #5060
         SELECT gzcbl004 INTO r_desc
           FROM gzcbl_t
          WHERE gzcbl001 = '5060'
            AND gzcbl002 = p_qcba031
            AND gzcbl003 = g_dlang
      WHEN '6'
         LET r_desc = cl_getmsg("aqc-00140",g_dlang) #借货还货检验
   END CASE
   RETURN r_desc
END FUNCTION

 
{</section>}
 
