#該程式未解開Section, 採用最新樣板產出!
{<section id="asfr007_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2016-05-16 14:11:17), PR版次:0003(2016-05-16 14:17:07)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000065
#+ Filename...: asfr007_x01
#+ Description: ...
#+ Creator....: 00768(2014-11-03 11:25:00)
#+ Modifier...: 04441 -SD/PR- 04441
 
{</section>}
 
{<section id="asfr007_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#160503-00030    by whitney  效能優化
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
 
{<section id="asfr007_x01.main" readonly="Y" >}
PUBLIC FUNCTION asfr007_x01(p_arg1)
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
   LET g_rep_code = "asfr007_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL asfr007_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL asfr007_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL asfr007_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL asfr007_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL asfr007_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="asfr007_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION asfr007_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "sffbdocno.sffb_t.sffbdocno,sffbseq.sffb_t.sffbseq,l_sffb001_desc.gzcbl_t.gzcbl004,sffbdocdt.sffb_t.sffbdocdt,sffb002.sffb_t.sffb002,l_sffb002_desc.ooag_t.ooag011,sffb003.sffb_t.sffb003,l_sffb003_desc.ooefl_t.ooefl003,l_sffbstus_desc.gzcbl_t.gzcbl004,sffb005.sffb_t.sffb005,sffb006.sffb_t.sffb006,sffb007.sffb_t.sffb007,l_sffb007_desc.oocql_t.oocql004,sffb008.sffb_t.sffb008,l_sfaa010.sfaa_t.sfaa010,l_sfaa010_imaal003.imaal_t.imaal003,l_sfaa010_imaal004.imaal_t.imaal004,l_imaa009.imaa_t.imaa009,l_imaa009_desc.rtaxl_t.rtaxl003,l_imae011.imae_t.imae011,l_imae011_desc.oocql_t.oocql004,sffb009.sffb_t.sffb009,l_sffb009_desc.ecaa_t.ecaa002,sffb004.sffb_t.sffb004,l_sffb004_desc.oogd_t.oogd002,sffb010.sffb_t.sffb010,l_sffb010_desc.mrba_t.mrba004,sffb024.sffb_t.sffb024,l_sffb024_desc.ooge_t.ooge002,sffb011.sffb_t.sffb011,sffb012.sffb_t.sffb012,sffb013.sffb_t.sffb013,sffb014.sffb_t.sffb014,sffb015.sffb_t.sffb015,sffb016.sffb_t.sffb016,l_sffb016_desc.type_t.chr30,sffb017.sffb_t.sffb017,sffb018.sffb_t.sffb018,sffb019.sffb_t.sffb019,sffb020.sffb_t.sffb020,l_sffd001.type_t.chr1000,sffb029.sffb_t.sffb029,l_imaa127.imaa_t.imaa127,l_imaa127_desc.oocql_t.oocql004" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="asfr007_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION asfr007_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="asfr007_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION asfr007_x01_sel_prep()
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
   #160503-00030 by whitney add start
   LET g_select = " SELECT sffbdocno,sffbseq,sffb001, ",
                  "(SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001='4020' AND gzcbl002=sffb001 AND gzcbl003='"||g_dlang||"') gzcbl004,",
                  "        sffbdocdt,sffb002, ",
                  "(SELECT ooag011 FROM ooag_t WHERE ooagent=sffbent AND ooag001=sffb002) ooag011,",
                  "        sffb003, ",
                  "(SELECT ooefl003 FROM ooefl_t WHERE ooeflent=sffbent AND ooefl001=sffb003 AND ooefl002='"||g_dlang||"') ooefl003,",
                  "        sffbstus, ",
                  "(SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001='13' AND gzcbl002=sffbstus AND gzcbl003='"||g_dlang||"') gzcbl004,",
                  "        sffb005,sffb006,sffb007, ",
                  "(SELECT oocql004 FROM oocql_t WHERE oocql001='221' AND oocql002=sffb007 AND oocqlent=sffbent AND oocql003='"||g_dlang||"') oocql004,",
                  "        sffb008,sfaa010,imaal003,imaal004,imaa009, ",
                  "(SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent=sffbent AND rtaxl001=imaa009 AND rtaxl002='"||g_dlang||"') rtaxl003,",
                  "        imae011, ",
                  "(SELECT oocql004 FROM oocql_t WHERE oocql001='204' AND oocql002=imae011 AND oocqlent=sffbent AND oocql003='"||g_dlang||"') oocql004,",
                  "        sffb009, ",
                  "(SELECT ecaa002 FROM ecaa_t WHERE ecaaent=sffbent AND ecaasite=sffbsite AND ecaa001=sffb009) ecaa002,",
                  "        sffb004, ",
                  "(SELECT oogd002 FROM oogd_t WHERE oogdent=sffbent AND oogdsite=sffbsite AND oogd001=sffb004) oogd002,",
                  "        sffb010, ",
                  "(SELECT mrba004 FROM mrba_t WHERE mrbaent=sffbent AND mrbasite=sffbsite AND mrba001=sffb010) mrba004,",
                  "        sffb024, ",
                  "(SELECT ooge002 FROM ooge_t WHERE oogeent=sffbent AND oogesite=sffbsite AND ooge001=sffb024) ooge002,",
                  "        sffb011,sffb012,sffb013,sffb014,sffb015,sffb016, ",
                  "(SELECT oocal003 FROM oocal_t WHERE oocalent=sffbent AND oocal001=sffb016 AND oocal002='"||g_dlang||"') oocal003,",
                  "        sffb017,sffb018,sffb019,sffb020, ",
                  "        NULL,sffb029,imaa127, ",
                  "(SELECT oocql004 FROM oocql_t WHERE oocql001='2003' AND oocql002=imaa127 AND oocqlent=sffbent AND oocql003='"||g_dlang||"') oocql004"
   #160503-00030 by whitney add end
#   #end add-point
#   LET g_select = " SELECT sffbdocno,sffbseq,sffb001,NULL,sffbdocdt,sffb002,NULL,sffb003,NULL,sffbstus, 
#       NULL,sffb005,sffb006,sffb007,NULL,sffb008,NULL,NULL,NULL,NULL,NULL,NULL,NULL,sffb009,NULL,sffb004, 
#       NULL,sffb010,NULL,sffb024,NULL,sffb011,sffb012,sffb013,sffb014,sffb015,sffb016,NULL,sffb017,sffb018, 
#       sffb019,sffb020,NULL,sffb029,NULL,NULL"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   #160503-00030 by whitney add start
   LET g_from = " FROM sffb_t ",
                " LEFT JOIN (SELECT sfaaent,sfaasite,sfaadocno,sfaa010,imaal003,imaal004,imaa009,imaa127,imae011 FROM sfaa_t ",
                " LEFT JOIN imaa_t ON imaaent=sfaaent AND imaa001=sfaa010 ",
                " LEFT JOIN imae_t ON imaeent=sfaaent AND imae001=sfaa010 AND imaesite=sfaasite ",
                " LEFT JOIN imaal_t ON imaalent=sfaaent AND imaal001=sfaa010 AND imaal002='"||g_dlang||"') ",
                " ON sfaaent=sffbent AND sfaasite=sffbsite AND sfaadocno = sffb005 "
   #160503-00030 by whitney add end

#   #end add-point
#    LET g_from = " FROM sffb_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
 
   #end add-point
    LET g_where = " WHERE sffb_t.sffb001 BETWEEN 0 AND 9 AND " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
 
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("sffb_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE asfr007_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE asfr007_x01_curs CURSOR FOR asfr007_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="asfr007_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION asfr007_x01_ins_data()
DEFINE sr RECORD 
   sffbdocno LIKE sffb_t.sffbdocno, 
   sffbseq LIKE sffb_t.sffbseq, 
   sffb001 LIKE sffb_t.sffb001, 
   l_sffb001_desc LIKE gzcbl_t.gzcbl004, 
   sffbdocdt LIKE sffb_t.sffbdocdt, 
   sffb002 LIKE sffb_t.sffb002, 
   l_sffb002_desc LIKE ooag_t.ooag011, 
   sffb003 LIKE sffb_t.sffb003, 
   l_sffb003_desc LIKE ooefl_t.ooefl003, 
   sffbstus LIKE sffb_t.sffbstus, 
   l_sffbstus_desc LIKE gzcbl_t.gzcbl004, 
   sffb005 LIKE sffb_t.sffb005, 
   sffb006 LIKE sffb_t.sffb006, 
   sffb007 LIKE sffb_t.sffb007, 
   l_sffb007_desc LIKE oocql_t.oocql004, 
   sffb008 LIKE sffb_t.sffb008, 
   l_sfaa010 LIKE sfaa_t.sfaa010, 
   l_sfaa010_imaal003 LIKE imaal_t.imaal003, 
   l_sfaa010_imaal004 LIKE imaal_t.imaal004, 
   l_imaa009 LIKE imaa_t.imaa009, 
   l_imaa009_desc LIKE rtaxl_t.rtaxl003, 
   l_imae011 LIKE imae_t.imae011, 
   l_imae011_desc LIKE oocql_t.oocql004, 
   sffb009 LIKE sffb_t.sffb009, 
   l_sffb009_desc LIKE ecaa_t.ecaa002, 
   sffb004 LIKE sffb_t.sffb004, 
   l_sffb004_desc LIKE oogd_t.oogd002, 
   sffb010 LIKE sffb_t.sffb010, 
   l_sffb010_desc LIKE mrba_t.mrba004, 
   sffb024 LIKE sffb_t.sffb024, 
   l_sffb024_desc LIKE ooge_t.ooge002, 
   sffb011 LIKE sffb_t.sffb011, 
   sffb012 LIKE sffb_t.sffb012, 
   sffb013 LIKE sffb_t.sffb013, 
   sffb014 LIKE sffb_t.sffb014, 
   sffb015 LIKE sffb_t.sffb015, 
   sffb016 LIKE sffb_t.sffb016, 
   l_sffb016_desc LIKE type_t.chr30, 
   sffb017 LIKE sffb_t.sffb017, 
   sffb018 LIKE sffb_t.sffb018, 
   sffb019 LIKE sffb_t.sffb019, 
   sffb020 LIKE sffb_t.sffb020, 
   l_sffd001 LIKE type_t.chr1000, 
   sffb029 LIKE sffb_t.sffb029, 
   l_imaa127 LIKE imaa_t.imaa127, 
   l_imaa127_desc LIKE oocql_t.oocql004
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_sffd001  LIKE sffd_t.sffd001
DEFINE l_oocql004 LIKE oocql_t.oocql004
DEFINE l_sql      STRING

DEFINE l_imaa127  LIKE imaa_t.imaa127   #系列
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    LET l_sql = "SELECT UNIQUE sffd001,oocql004 FROM sffd_t ",
                " INNER JOIN sffb_t ON sffbent = sffdent AND sffbdocno = sffddocno AND sffbseq = sffdseq ",
                " LEFT JOIN oocql_t ON oocqlent='"||g_enterprise||"' AND oocql001='1053' AND oocql002=sffd001 AND oocql003='"||g_dlang||"' ",
                " WHERE sffdent  = ",g_enterprise,
                "   AND sffddocno= ? ",
                "   AND sffdseq  = ? "
    PREPARE asfr007_x01_ins_data_p1 FROM l_sql
    DECLARE asfr007_x01_ins_data_c1 CURSOR FOR asfr007_x01_ins_data_p1
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH asfr007_x01_curs INTO sr.*                               
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
       #sr.sffd001
       FOREACH asfr007_x01_ins_data_c1 USING sr.sffbdocno,sr.sffbseq
                                       INTO l_sffd001,l_oocql004
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = "FOREACH:asfr007_x01_ins_data_c1"
             LET g_errparam.popup = TRUE
             CALL cl_err()
             EXIT FOREACH
          END IF
          IF cl_null(sr.l_sffd001) THEN
             LET sr.l_sffd001 = l_oocql004
          ELSE
             LET sr.l_sffd001 = sr.l_sffd001 CLIPPED,' ',l_oocql004
          END IF
       END FOREACH
#160503-00030 by whitney mark start
#       SELECT sfaa010,imaa009,imae011 INTO sr.l_sfaa010,sr.l_imaa009,sr.l_imae011
#        FROM sfaa_t LEFT JOIN imaa_t ON sfaaent = imaaent AND sfaa010 = imaa001
#                    LEFT JOIN imae_t ON sfaaent = imaeent AND sfaasite= imaesite AND sfaa010 = imae001
#        WHERE sfaaent   = g_enterprise
#          AND sfaadocno = sr.sffb005
#       LET sr.l_sffb002_desc = s_desc_get_person_desc(sr.sffb002)
#       LET sr.l_sffb003_desc = s_desc_get_department_desc(sr.sffb003)
#       LET sr.l_sffb007_desc =  s_desc_get_acc_desc('221',sr.sffb007)
#       CALL s_desc_get_item_desc(sr.l_sfaa010) RETURNING sr.l_sfaa010_imaal003,sr.l_sfaa010_imaal004
#       LET sr.l_imaa009_desc = s_desc_get_rtaxl003_desc(sr.l_imaa009)
#       LET sr.l_imae011_desc =  s_desc_get_acc_desc('204',sr.l_imae011)
#   
#       SELECT ecaa002 INTO sr.l_sffb009_desc FROM ecaa_t
#        WHERE ecaaent=g_enterprise AND ecaasite=g_site AND ecaa001=sr.sffb009
#
#       SELECT oogd002 INTO sr.l_sffb004_desc FROM oogd_t
#        WHERE oogdent=g_enterprise AND oogdsite=g_site AND oogd001=sr.sffb004
#       
#       SELECT mrba004 INTO sr.l_sffb010_desc FROM mrba_t
#        WHERE mrbaent=g_enterprise AND mrbasite=g_site AND mrba001=sr.sffb010
#       
#       SELECT ooge002 INTO sr.l_sffb024_desc FROM ooge_t
#        WHERE oogeent=g_enterprise AND oogesite=g_site AND ooge001=sr.sffb024
#       #dorislai-20150809-add----(S)
#       #報工人員全名 l_sffb002desc	
#       LET sr.l_sffb002desc = ''
#       LET sr.l_sffb002_desc = s_desc_get_person_desc(sr.sffb002)   
#       IF NOT cl_null(sr.l_sffb002_desc) THEN
#          LET sr.l_sffb002desc = sr.sffb002,'.',sr.l_sffb002_desc
#       END IF
#       #部門全名 l_sffb003desc	
#       LET sr.l_sffb003desc = ''
#       LET sr.l_sffb003_desc = s_desc_get_department_desc(sr.sffb003)
#       IF NOT cl_null(sr.l_sffb003_desc) THEN 
#          LET sr.l_sffb003desc = sr.sffb003,'.',sr.l_sffb003_desc
#       END IF
#       #報工單號全名l_sffbdocnodesc	
#       LET sr.l_sffbdocnodesc = ''
#       LET sr.l_sffbdocno_desc = s_aooi200_get_slip_desc(sr.sffbdocno)
#       IF NOT cl_null(sr.l_sffbdocno_desc) THEN
#          LET sr.l_sffbdocnodesc = sr.sffbdocno,'.',sr.l_sffbdocno_desc
#       END IF
#       #報工班別全名 l_sffb004desc		
#       LET sr.l_sffb004desc = ''       
#       IF NOT cl_null(sr.l_sffb004_desc) THEN
#          LET sr.l_sffb004desc = sr.sffb004,'.',sr.l_sffb004_desc
#       END IF
#       #工單單號全名 l_sffb005desc		
#       LET sr.l_sffb005_desc = s_aooi200_get_slip_desc(sr.sffb005)
#       LET sr.l_sffb005desc = ''
#       IF NOT cl_null(sr.l_sffb005_desc) THEN
#          LET sr.l_sffb005desc = sr.sffb005,'.',sr.l_sffb005_desc
#       END IF
#       #作業編號全名 l_sffb007desc		
#       LET sr.l_sffb007desc = ''      
#       IF NOT cl_null(sr.l_sffb007_desc) THEN
#          LET sr.l_sffb007desc = sr.sffb007,'.',sr.l_sffb007desc
#       END IF
#       #工作站全名 l_sffb009desc		
#       LET sr.l_sffb009desc = ''       
#       IF NOT cl_null(sr.l_sffb009_desc) THEN
#          LET sr.l_sffb009desc = sr.sffb009,'.',sr.l_sffb009_desc
#       END IF
#       #報工機器全名 l_sffb010desc		
#       LET sr.l_sffb010desc = ''       
#       IF NOT cl_null(sr.l_sffb010_desc) THEN
#          LET sr.l_sffb010desc = sr.sffb010,'.',sr.l_sffb010_desc
#       END IF
#       #單位全名 l_sffb016desc		
#       LET sr.l_sffb016_desc = ''
#       LET sr.l_sffb016desc = ''
#       SELECT oocal003 INTO sr.l_sffb016_desc FROM oocal_t 
#        WHERE oocalent = g_enterprise AND oocal001 = sr.sffb016 AND oocal002 = g_dlang
#       IF NOT cl_null(sr.l_sffb016_desc) THEN
#          LET sr.l_sffb016desc = sr.sffb016,'.',sr.l_sffb016_desc
#       END IF
#       #報工組別全名 l_sffb024desc		chk
#       LET sr.l_sffb024desc = ''
#       IF NOT cl_null(sr.l_sffb024_desc) THEN
#          LET sr.l_sffb024desc = sr.sffb024,'.',sr.l_sffb024_desc
#       END IF
#       #系列全名 l_imaa127desc		
#       LET sr.l_imaa127_desc = ''
#       LET sr.l_imaa127desc = ''
#          #用料號抓取系列
#       SELECT imaa127 INTO l_imaa127 FROM imaa_t
#        WHERE imaa001 = sr.sffb029
#          AND imaaent = g_enterprise
#         #抓取系列說明
#       CALL s_desc_get_acc_desc('2003',l_imaa127)  RETURNING sr.l_imaa127_desc 
#       IF NOT cl_null(sr.l_imaa127_desc) THEN
#          LET sr.l_imaa127desc = l_imaa127,'.',sr.l_imaa127_desc
#       END IF
#       #dorislai-20150809-add----(E)
#       
#       #ACC说明
#       #dorislai-20150809-modify----(S)
##       LET sr.l_sffb001_desc = s_desc_gzcbl004_desc('4020',sr.sffb001)
##       IF NOT cl_null(sr.l_sffb001_desc) THEN
##          LET sr.l_sffb001_desc = sr.sffb001 CLIPPED,'.',sr.l_sffb001_desc
##       ELSE
##          LET sr.l_sffb001_desc = sr.sffb001
##       END IF
##       
##       LET sr.l_sffbstus_desc = s_desc_gzcbl004_desc('13',sr.sffbstus)
##       IF NOT cl_null(sr.l_sffbstus_desc) THEN
##          LET sr.l_sffbstus_desc= sr.sffbstus CLIPPED,'.',sr.l_sffbstus_desc
##       ELSE
##          LET sr.l_sffbstus_desc= sr.sffbstus
##       END IF
#       #----報工類別說明
#       LET sr.l_sffb001_ref = ''
#       LET sr.l_sffb001_desc = ''
#       LET sr.l_sffb001_ref = s_desc_gzcbl004_desc('4020',sr.sffb001)
#       IF NOT cl_null(sr.l_sffb001_ref) THEN
#          LET sr.l_sffb001_desc = sr.sffb001 CLIPPED,'.',sr.l_sffb001_ref
#       ELSE
#          LET sr.l_sffb001_desc = sr.sffb001
#       END IF
#       #----狀態碼
#       LET sr.l_sffbstus_ref = ''
#       LET sr.l_sffbstus_desc = ''
#       LET sr.l_sffbstus_ref = s_desc_gzcbl004_desc('13',sr.sffbstus)
#       IF NOT cl_null(sr.l_sffbstus_ref) THEN
#          LET sr.l_sffbstus_desc= sr.sffbstus CLIPPED,'.',sr.l_sffbstus_ref
#       ELSE
#          LET sr.l_sffbstus_desc= sr.sffbstus
#       END IF
#       #dorislai-20150809-modify----(E)
#160503-00030 by whitney mark end

       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.sffbdocno,sr.sffbseq,sr.l_sffb001_desc,sr.sffbdocdt,sr.sffb002,sr.l_sffb002_desc,sr.sffb003,sr.l_sffb003_desc,sr.l_sffbstus_desc,sr.sffb005,sr.sffb006,sr.sffb007,sr.l_sffb007_desc,sr.sffb008,sr.l_sfaa010,sr.l_sfaa010_imaal003,sr.l_sfaa010_imaal004,sr.l_imaa009,sr.l_imaa009_desc,sr.l_imae011,sr.l_imae011_desc,sr.sffb009,sr.l_sffb009_desc,sr.sffb004,sr.l_sffb004_desc,sr.sffb010,sr.l_sffb010_desc,sr.sffb024,sr.l_sffb024_desc,sr.sffb011,sr.sffb012,sr.sffb013,sr.sffb014,sr.sffb015,sr.sffb016,sr.l_sffb016_desc,sr.sffb017,sr.sffb018,sr.sffb019,sr.sffb020,sr.l_sffd001,sr.sffb029,sr.l_imaa127,sr.l_imaa127_desc
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "asfr007_x01_execute"
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
#    CLOSE asfr007_x01_ins_data_c1
#    FREE asfr007_x01_ins_data_p1
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="asfr007_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION asfr007_x01_rep_data()
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
 
{<section id="asfr007_x01.other_function" readonly="Y" >}

 
{</section>}
 
