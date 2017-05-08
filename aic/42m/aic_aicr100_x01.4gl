#該程式未解開Section, 採用最新樣板產出!
{<section id="aicr100_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2016-06-02 17:00:09), PR版次:0001(2016-06-02 17:30:49)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000024
#+ Filename...: aicr100_x01
#+ Description: ...
#+ Creator....: 02040(2016-06-01 14:34:45)
#+ Modifier...: 02040 -SD/PR- 02040
 
{</section>}
 
{<section id="aicr100_x01.global" readonly="Y" >}
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

#end add-point
 
{</section>}
 
{<section id="aicr100_x01.main" readonly="Y" >}
PUBLIC FUNCTION aicr100_x01(p_arg1)
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
   LET g_rep_code = "aicr100_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL aicr100_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL aicr100_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL aicr100_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL aicr100_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL aicr100_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="aicr100_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION aicr100_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "l_aic_s.xmda_t.xmda031,l_oobx003.type_t.chr100,l_docno_s.xmdc_t.xmdcdocno,l_seq_s.xmdc_t.xmdcseq,xmdc001.xmdc_t.xmdc001,l_xmdc001_desc.type_t.chr100,l_xmdc001_desc_1.type_t.chr100,xmdc002.xmdc_t.xmdc002,l_xmdc002_desc.type_t.chr100,l_aic_e.xmda_t.xmda031,l_docno_e.xmdc_t.xmdcdocno,l_seq_e.xmdc_t.xmdcseq,l_site_e.xmdc_t.xmdcsite,l_site_e_desc.type_t.chr100,xmdcsite.xmdc_t.xmdcsite,l_xmdcsite_desc.type_t.chr100,xmdc006.xmdc_t.xmdc006,l_xmdc006_desc.type_t.chr100,xmdc007.xmdc_t.xmdc007,xmdc046.xmdc_t.xmdc046,xmdc047.xmdc_t.xmdc047,xmdc048.xmdc_t.xmdc048" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="aicr100_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION aicr100_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="aicr100_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aicr100_x01_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define(客製用) name="sel_prep.define_customerization"

#end add-point
#add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
DEFINE l_sql      STRING
#end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
 
   #add-point:sel_prep g_select name="sel_prep.g_select"
   LET l_sql = "SELECT DISTINCT icaa001,icaa003 FROM icaa_t,icab_t ",
               " WHERE icaaent = icabent AND icaa001 = icab001 ",
               "   AND icabent = ",g_enterprise,
               "   AND icaastus = 'Y' AND icab005 = 'Y' ",
               "   AND ",tm.wc
   LET l_sql = cl_sql_add_mask(l_sql)              #遮蔽特定資料
   PREPARE aicr100_icaa_p FROM l_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:aicr100_icaa_p'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE aicr100_icaa_c CURSOR WITH HOLD FOR aicr100_icaa_p 
   
   LET l_sql = "SELECT DISTINCT a.icab003 FROM icab_t a",
               " WHERE a.icabent = ",g_enterprise,
               "   AND a.icab001 = ? ",
               "   AND a.icab002 = (SELECT MAX(b.icab002) FROM icab_t b ",
               "                   WHERE a.icabent = b.icabent AND a.icab001 = b.icab001 ) "
     
   LET l_sql = cl_sql_add_mask(l_sql)              #遮蔽特定資料
   PREPARE aicr100_icab003_p FROM l_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:aicr100_icab003_p'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE aicr100_icab003_c CURSOR WITH HOLD FOR aicr100_icab003_p  

   LET l_sql = "SELECT DISTINCT a.icab003 FROM icab_t a",
               " WHERE a.icabent = ",g_enterprise,
               "   AND a.icab001 = ? ",
               "   AND a.icab002 = (SELECT MIN(b.icab002) FROM icab_t b ",
               "                   WHERE a.icabent = b.icabent AND a.icab001 = b.icab001 ) "
     
   LET l_sql = cl_sql_add_mask(l_sql)              #遮蔽特定資料
   PREPARE aicr100_icab003_p2 FROM l_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:aicr100_icab003_p2'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE aicr100_icab003_c2 CURSOR WITH HOLD FOR aicr100_icab003_p2 
   
   LET l_sql = "SELECT DISTINCT icab003, ",
               "       (SELECT ooefl003 FROM ooefl_t WHERE ooeflent=icabent AND ooefl001=icab003 AND ooefl002='",g_dlang,"') ooefl003",
               "  FROM icab_t ",
               " WHERE icabent = ",g_enterprise,
               "   AND icab001 = ? ",
               "   AND icab005 = 'Y' "
     
   LET l_sql = cl_sql_add_mask(l_sql)              #遮蔽特定資料
   PREPARE aicr100_icab003_p3 FROM l_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:aicr100_icab003_p3'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE aicr100_icab003_c3 CURSOR WITH HOLD FOR aicr100_icab003_p3    
   
   LET l_sql = "SELECT xmda015,xmda031,xmdcdocno,xmdcseq,xmdc007, ",
               "       xmdc046,xmdc047,xmdc048 ",
               "  FROM xmda_t a,xmdc_t ",
               " WHERE a.xmdaent = xmdcent ",
               "   AND a.xmdadocno = xmdcdocno ",
               "   AND a.xmdaent = ",g_enterprise,
               "   AND a.xmda031 = (SELECT b.xmda031 ",
               "                      FROM xmda_t b ",
               "                     WHERE a.xmdaent = b.xmdaent ",
               "                       AND b.xmdadocno = ? ) ", 
               "  AND xmdcseq =? "  ,
               "  AND xmdcsite = ? ",
               "ORDER BY xmdcdocno,xmdcseq "
                 
   LET l_sql = cl_sql_add_mask(l_sql)              #遮蔽特定資料
   PREPARE aicr100_xmda_p FROM l_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:aicr100_xmda_p'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE aicr100_xmda_c CURSOR WITH HOLD FOR aicr100_xmda_p    
   
   LET l_sql = "SELECT pmdl015,pmdl031,pmdndocno,pmdnseq,pmdn007, ",
               "       pmdn046,pmdn047,pmdn048 ",
               "  FROM pmdl_t ,pmdn_t ",
               " WHERE pmdlent = pmdnent ",
               "   AND pmdldocno = pmdndocno ",
               "   AND pmdlent = ",g_enterprise,
               "   AND pmdl031 = (SELECT xmda031 ",
               "                      FROM xmda_t  ",
               "                     WHERE pmdlent = xmdaent ",
               "                       AND xmdadocno = ? ) ", 
               "  AND pmdnseq =? ",   
               "  AND pmdnsite = ? ",
               "ORDER BY pmdndocno,pmdnseq"
                
   LET l_sql = cl_sql_add_mask(l_sql)              #遮蔽特定資料
   PREPARE aicr100_pmdl_p FROM l_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:aicr100_pmdn_p'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE aicr100_pmdl_c CURSOR WITH HOLD FOR aicr100_pmdl_p     
   
   
   LET g_select = "SELECT          '',         '', xmdl003,    xmdl004,xmdl008, ",
                  "       (SELECT imaal003 FROM imaal_t WHERE imaalent=xmdlent AND imaal001=xmdl008 AND imaal002='",g_dlang,"') imaal003,",
                  "       (SELECT imaal004 FROM imaal_t WHERE imaalent=xmdlent AND imaal001=xmdl008 AND imaal002='",g_dlang,"') imaal004,",
                  "        xmdl009, ",
                  "       (SELECT inaml004 FROM inaml_t WHERE inamlent=xmdlent AND inaml001=xmdl008 AND inaml002=xmdl009 AND inaml003='",g_dlang,"') inaml004,",
                  "        xmdk035, ",
                  "        xmdldocno,    xmdlseq,xmdlsite, ",
                  "       (SELECT ooefl003 FROM ooefl_t WHERE ooeflent=xmdlent AND ooefl001=xmdlsite AND ooefl002='",g_dlang,"') ooefl003,",
                  "        '','',xmdl017, ",
                  "       (SELECT oocal003 FROM oocal_t WHERE oocalent=xmdlent AND oocal001=xmdl017 AND oocal002='",g_dlang,"') oocal003,",
                  "       (xmdl018-xmdl035),'',         '',     ''  "         
   
   
#   #end add-point
#   LET g_select = " SELECT NULL,NULL,NULL,NULL,xmdc001,NULL,NULL,xmdc002,NULL,NULL,NULL,NULL,NULL,NULL, 
#       xmdcsite,NULL,xmdc006,NULL,xmdc007,xmdc046,xmdc047,xmdc048"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
    LET g_from =  "FROM xmdk_t,xmdl_t"

#   #end add-point
#    LET g_from = " FROM xmdc_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET g_where =  "WHERE xmdkent = xmdlent AND xmdkdocno = xmdldocno ",
                  "  AND xmdkent = ",g_enterprise, 
                  "  AND xmdk035 IS NOT NULL AND xmdk083 = 'Y' AND (xmdl018 - xmdl035) > 0 ",
                  "  AND xmdk044 = ? AND xmdksite = ? "
                 
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("xmdc_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE aicr100_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE aicr100_x01_curs CURSOR FOR aicr100_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="aicr100_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION aicr100_x01_ins_data()
DEFINE sr RECORD 
   l_aic_s LIKE xmda_t.xmda031, 
   l_oobx003 LIKE type_t.chr100, 
   l_docno_s LIKE xmdc_t.xmdcdocno, 
   l_seq_s LIKE xmdc_t.xmdcseq, 
   xmdc001 LIKE xmdc_t.xmdc001, 
   l_xmdc001_desc LIKE type_t.chr100, 
   l_xmdc001_desc_1 LIKE type_t.chr100, 
   xmdc002 LIKE xmdc_t.xmdc002, 
   l_xmdc002_desc LIKE type_t.chr100, 
   l_aic_e LIKE xmda_t.xmda031, 
   l_docno_e LIKE xmdc_t.xmdcdocno, 
   l_seq_e LIKE xmdc_t.xmdcseq, 
   l_site_e LIKE xmdc_t.xmdcsite, 
   l_site_e_desc LIKE type_t.chr100, 
   xmdcsite LIKE xmdc_t.xmdcsite, 
   l_xmdcsite_desc LIKE type_t.chr100, 
   xmdc006 LIKE xmdc_t.xmdc006, 
   l_xmdc006_desc LIKE type_t.chr100, 
   xmdc007 LIKE xmdc_t.xmdc007, 
   xmdc046 LIKE xmdc_t.xmdc046, 
   xmdc047 LIKE xmdc_t.xmdc047, 
   xmdc048 LIKE xmdc_t.xmdc048
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_icaa001 LIKE icaa_t.icaa001
DEFINE l_icaa003 LIKE icaa_t.icaa003  
DEFINE l_icab003_s LIKE icab_t.icab003
DEFINE l_icab003_e LIKE icab_t.icab003
DEFINE l_icab003_o LIKE icab_t.icab003
DEFINE l_icab003_desc LIKE type_t.chr100
DEFINE l_gzcbl004_1 LIKE gzcbl_t.gzcbl004
DEFINE l_gzcbl004_2 LIKE gzcbl_t.gzcbl004
DEFINE l_xmda015    LIKE xmda_t.xmda015
DEFINE l_xmdc007    LIKE xmdc_t.xmdc007
DEFINE l_xmdc046    LIKE xmdc_t.xmdc046
DEFINE l_xmdc047    LIKE xmdc_t.xmdc047
DEFINE l_xmdc048    LIKE xmdc_t.xmdc048
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    SELECT gzcbl004 INTO l_gzcbl004_1
      FROM gzcbl_t
     WHERE gzcbl001 = '24'AND gzcbl002 = 'axmt500' AND gzcbl003 = g_dlang
    SELECT gzcbl004 INTO l_gzcbl004_2
      FROM gzcbl_t
     WHERE gzcbl001 = '24'AND gzcbl002 = 'apmt500' AND gzcbl003 = g_dlang    
     
FOREACH aicr100_icaa_c INTO l_icaa001,l_icaa003
    
    OPEN aicr100_icab003_c USING l_icaa001
    FETCH aicr100_icab003_c INTO l_icab003_e      #抓取最終站site
    
    OPEN aicr100_icab003_c2 USING l_icaa001
    FETCH aicr100_icab003_c2 INTO l_icab003_s     #抓取起始站site    
    
    OPEN aicr100_icab003_c3 USING l_icaa001
    FETCH aicr100_icab003_c3 INTO l_icab003_o,l_icab003_desc     #抓取中斷站site 
    
    CLOSE aicr100_icab003_c 
    CLOSE aicr100_icab003_c2
    CLOSE aicr100_icab003_c3
    
    OPEN aicr100_x01_curs USING l_icaa001,l_icab003_e 
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH aicr100_x01_curs INTO sr.*                               
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
         
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       #抓取訂單的多角流程序號
       LET sr.xmdcsite = l_icab003_o          #在途據點
       LET sr.l_xmdcsite_desc = l_icab003_desc
       IF l_icaa003 = '1' THEN
          #起始站為訂單
          LET sr.l_oobx003 = l_gzcbl004_1
          OPEN aicr100_xmda_c USING sr.l_docno_s,sr.l_seq_s,l_icab003_s 
          FETCH aicr100_xmda_c INTO l_xmda015,sr.l_aic_s,sr.l_docno_s,sr.l_seq_s,l_xmdc007,l_xmdc046,l_xmdc047,l_xmdc048
          CLOSE aicr100_xmda_c
       ELSE
          #起始站為採購單
          LET sr.l_oobx003 = l_gzcbl004_2
          OPEN aicr100_pmdl_c USING sr.l_docno_s,sr.l_seq_s,l_icab003_s 
          FETCH aicr100_pmdl_c INTO l_xmda015,sr.l_aic_s,sr.l_docno_s,sr.l_seq_s,l_xmdc007,l_xmdc046,l_xmdc047,l_xmdc048
          CLOSE aicr100_pmdl_c
       END IF
       IF cl_null(l_xmdc007) THEN LET l_xmdc007 = 0 END IF
       IF cl_null(l_xmdc046) THEN LET l_xmdc046 = 0 END IF
       IF cl_null(l_xmdc047) THEN LET l_xmdc047 = 0 END IF
       IF cl_null(l_xmdc048) THEN LET l_xmdc048 = 0 END IF
       IF NOT cl_null(sr.l_docno_s) AND NOT cl_null(sr.l_seq_s) THEN
          LET sr.xmdc046 = l_xmdc046 * (sr.xmdc007 / l_xmdc007)  
          LET sr.xmdc047 = l_xmdc047 * (sr.xmdc007 / l_xmdc007)  
          LET sr.xmdc048 = l_xmdc048 * (sr.xmdc007 / l_xmdc007)  
          CALL s_curr_round(g_site,l_xmda015,sr.xmdc046,'1') RETURNING sr.xmdc046
          CALL s_curr_round(g_site,l_xmda015,sr.xmdc047,'1') RETURNING sr.xmdc047
          CALL s_curr_round(g_site,l_xmda015,sr.xmdc048,'1') RETURNING sr.xmdc048
       END IF
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.l_aic_s,sr.l_oobx003,sr.l_docno_s,sr.l_seq_s,sr.xmdc001,sr.l_xmdc001_desc,sr.l_xmdc001_desc_1,sr.xmdc002,sr.l_xmdc002_desc,sr.l_aic_e,sr.l_docno_e,sr.l_seq_e,sr.l_site_e,sr.l_site_e_desc,sr.xmdcsite,sr.l_xmdcsite_desc,sr.xmdc006,sr.l_xmdc006_desc,sr.xmdc007,sr.xmdc046,sr.xmdc047,sr.xmdc048
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "aicr100_x01_execute"
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
END FOREACH
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aicr100_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION aicr100_x01_rep_data()
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
 
{<section id="aicr100_x01.other_function" readonly="Y" >}

 
{</section>}
 
