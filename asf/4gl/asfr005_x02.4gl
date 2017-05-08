#該程式未解開Section, 採用最新樣板產出!
{<section id="asfr005_x02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2016-05-20 10:47:31), PR版次:0003(2016-05-20 10:50:36)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000086
#+ Filename...: asfr005_x02
#+ Description: ...
#+ Creator....: 05384(2014-08-01 11:45:35)
#+ Modifier...: 04441 -SD/PR- 04441
 
{</section>}
 
{<section id="asfr005_x02.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#160411-00027    16/04/22  By Whitney 效能優化
#160425-00019    16/05/20  By Whitney 齊料套數不及時計算改抓sfaa071
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
 
{<section id="asfr005_x02.main" readonly="Y" >}
PUBLIC FUNCTION asfr005_x02(p_arg1)
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
   LET g_rep_code = "asfr005_x02"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL asfr005_x02_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL asfr005_x02_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL asfr005_x02_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL asfr005_x02_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL asfr005_x02_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="asfr005_x02.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION asfr005_x02_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "sfaadocno.sfaa_t.sfaadocno,sfaa020.sfaa_t.sfaa020,sfaa010.sfaa_t.sfaa010,imaal_t_imaal003.imaal_t.imaal003,imaal_t_imaal004.imaal_t.imaal004,sfaa013.sfaa_t.sfaa013,l_sfaa013_desc.type_t.chr30,sfaa012.sfaa_t.sfaa012,sfaa049.sfaa_t.sfaa049,l_setfull.type_t.num26_10,l_sfaa050_sfaa051.type_t.num20_6,sfaa050.sfaa_t.sfaa050,sfaa051.sfaa_t.sfaa051,sfaa002.sfaa_t.sfaa002,l_sfaa002_desc.type_t.chr30,sfaa003.sfaa_t.sfaa003,l_sfaa003_desc.type_t.chr30,sfaa004.sfaa_t.sfaa004,l_sfaa004_desc.type_t.chr30,sfaa057.sfaa_t.sfaa057,l_sfaa057_desc.type_t.chr30,sfaadocdt.sfaa_t.sfaadocdt,sfaastus.sfaa_t.sfaastus,l_sfaastus_desc.type_t.chr30,sfaa005.sfaa_t.sfaa005,l_sfaa005_desc.type_t.chr30,sfaa006.sfaa_t.sfaa006,sfaa007.sfaa_t.sfaa007,sfaa008.sfaa_t.sfaa008,sfaa063.sfaa_t.sfaa063,sfaa009.sfaa_t.sfaa009,l_sfaa009_desc.type_t.chr30,sfaa011.sfaa_t.sfaa011,sfaa017.sfaa_t.sfaa017,l_sfaa017_desc.type_t.chr30,sfaa018.sfaa_t.sfaa018,l_sfaa018_desc.type_t.chr30,sfaa019.sfaa_t.sfaa019,sfaa021.sfaa_t.sfaa021,sfaa022.sfaa_t.sfaa022,sfaa058.sfaa_t.sfaa058,sfaa060.sfaa_t.sfaa060,l_sfaa060_desc.type_t.chr30,sfaa068.sfaa_t.sfaa068,l_sfaa068_desc.type_t.chr30,sfaa028.sfaa_t.sfaa028,l_sfaa028_desc.type_t.chr50,sfaa029.sfaa_t.sfaa029,l_sfaa029_desc.type_t.chr50,sfaa030.sfaa_t.sfaa030,l_sfaa030_desc.type_t.chr50,sfaa055.sfaa_t.sfaa055,sfaa056.sfaa_t.sfaa056" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   LET g_sql = "l_sfda002_desc.gzcbl_t.gzcbl004,",
               "l_sfdcdocno_sfdcseq.type_t.chr30,",
               "sfdc004.sfdc_t.sfdc004,",
               "l_imaal003.imaal_t.imaal003,",
               "l_imaal004.imaal_t.imaal004,",
               "sfdc005.sfdc_t.sfdc005,",
               "sfdc008.sfdc_t.sfdc008,",
               "sfdc006.sfdc_t.sfdc006,",
#160411-00027 by whitney mark start
#               "sfdadocno.sfda_t.sfdadocno,",
#               "sfdaent.sfda_t.sfdaent,",
#               "sfda002.sfda_t.sfda002,",
#               "sfdcdocno.sfdc_t.sfdcdocno,",
#               "sfdcent.sfdc_t.sfdcent,",
#               "sfdcsite.sfdc_t.sfdcsite,",
#               "sfdcseq.sfdc_t.sfdcseq,",
#160411-00027 by whitney mark end
               "sfdc001.sfdc_t.sfdc001"
   IF NOT cl_xg_create_tmptable(g_sql,2) THEN
      LET g_rep_success = 'N'            
   END IF
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="asfr005_x02.ins_prep" readonly="Y" >}
PRIVATE FUNCTION asfr005_x02_ins_prep()
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
             ?,?,?)"
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
         #子報表
         WHEN 2
         LET g_sql = " INSERT INTO ",g_rep_db CLIPPED,g_rep_tmpname[2] CLIPPED," VALUES(?,?,?,?,?,?,?,?,?)"  #160411-00027 by whitney modify -7 ?
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
 
{<section id="asfr005_x02.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION asfr005_x02_sel_prep()
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
   #160411-00027 by whitney add start
   LET g_select = " SELECT sfaadocno,sfaa020,sfaa010,imaal003,imaal004,sfaa013, ",
                  "(SELECT oocal003 FROM oocal_t WHERE oocalent=sfaaent AND oocal001=sfaa013 AND oocal002='"||g_dlang||"') oocal003,",
                 #160425-00019 by whitney modift start
                 #"        sfaa012,sfaa049,0,0,sfaaent,sfaasite,sfaa050,sfaa051,sfaa002, ",
                  "        sfaa012,sfaa049,NVL(sfaa071,0),(sfaa050+sfaa051),sfaaent,sfaasite,sfaa050,sfaa051,sfaa002, ",
                 #160425-00019 by whitney modift end
                  "(SELECT ooag011 FROM ooag_t WHERE ooagent=sfaaent AND ooag001=sfaa002) ooag011,",
                  "        sfaa003, ",
                  "(SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001='4007' AND gzcbl002=sfaa003 AND gzcbl003='"||g_dlang||"') gzcbl004,",
                  "        sfaa004, ",
                  "(SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001='4008' AND gzcbl002=sfaa004 AND gzcbl003='"||g_dlang||"') gzcbl004,",
                  "        sfaa057, ",
                  "(SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001='4010' AND gzcbl002=sfaa004 AND gzcbl003='"||g_dlang||"') gzcbl004,",
                  "        sfaadocdt,sfaastus, ",
                  "(SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001='13' AND gzcbl002=sfaastus AND gzcbl003='"||g_dlang||"') gzcbl004,",
                  "        sfaa005, ",
                  "(SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001='4009' AND gzcbl002=sfaa005 AND gzcbl003='"||g_dlang||"') gzcbl004,",
                  "        sfaa006,sfaa007,sfaa008,sfaa063,sfaa009, ",
                  "(SELECT pmaal004 FROM pmaal_t WHERE pmaalent=sfaaent AND pmaal001=sfaa009 AND pmaal002='"||g_dlang||"') pmaal004,",
                  "        sfaa011,sfaa017, ",
                  "(SELECT pmaal004 FROM pmaal_t WHERE pmaalent=sfaaent AND pmaal001=sfaa017 AND pmaal002='"||g_dlang||"') pmaal004,",
                  "        sfaa018, ",
                  "(SELECT ooeal003 FROM ooeal_t WHERE ooealent=sfaaent AND ooeal001=sfaa018 AND ooeal002='"||g_dlang||"') ooeal003,",
                  "        sfaa019,sfaa021,sfaa022,sfaa058,sfaa060, ",
                  "(SELECT oocal003 FROM oocal_t WHERE oocalent=sfaaent AND oocal001=sfaa060 AND oocal002='"||g_dlang||"') oocal003,",
                  "        sfaa068, ",
                  "(SELECT ooefl003 FROM ooefl_t WHERE ooeflent=sfaaent AND ooefl001=sfaa068 AND ooefl002='"||g_dlang||"') ooefl003,",
                  "        sfaa028, ",
                  "CASE WHEN pjabl003 IS NULL THEN pjbal003 ELSE pjabl003 END, ",
                  "        sfaa029, ",
                  "(SELECT pjbbl004 FROM pjbbl_t WHERE pjbblent=sfaaent AND pjbbl001=sfaa028 AND pjbbl002=sfaa029 AND pjbbl003='"||g_dlang||"') pjbbl004,",
                  "        sfaa030, ",
                  "(SELECT pjbml004 FROM pjbml_t WHERE pjbmlent=sfaaent AND pjbml001=sfaa028 AND pjbml002=sfaa030 AND pjbml003='"||g_dlang||"') pjbml004,",
                  "        sfaa055,sfaa056 "
   #160411-00027 by whitney add end
#   #end add-point
#   LET g_select = " SELECT sfaadocno,sfaa020,sfaa010,( SELECT imaal003 FROM imaal_t WHERE imaal_t.imaal001 = sfaa_t.sfaa010 AND imaal_t.imaalent = sfaa_t.sfaaent AND imaal_t.imaal002 = '" , 
#       g_dlang,"'" ,"),( SELECT imaal004 FROM imaal_t WHERE imaal_t.imaal001 = sfaa_t.sfaa010 AND imaal_t.imaalent = sfaa_t.sfaaent AND imaal_t.imaal002 = '" , 
#       g_dlang,"'" ,"),sfaa013,NULL,sfaa012,sfaa049,'','',sfaaent,sfaasite,sfaa050,sfaa051,sfaa002,NULL, 
#       sfaa003,NULL,sfaa004,NULL,sfaa057,NULL,sfaadocdt,sfaastus,NULL,sfaa005,NULL,sfaa006,sfaa007,sfaa008, 
#       sfaa063,sfaa009,NULL,sfaa011,sfaa017,NULL,sfaa018,NULL,sfaa019,sfaa021,sfaa022,sfaa058,sfaa060, 
#       NULL,sfaa068,NULL,sfaa028,NULL,sfaa029,NULL,sfaa030,NULL,sfaa055,sfaa056"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   #160411-00027 by whitney add start
   LET g_from = " FROM sfaa_t ",
                " LEFT JOIN imaal_t ON imaalent=sfaaent AND imaal001=sfaa010 AND imaal002='"||g_dlang||"' ",
                " LEFT JOIN pjabl_t ON pjablent=sfaaent AND pjabl001=sfaa028 AND pjabl002='"||g_dlang||"' ",
                " LEFT JOIN pjbal_t ON pjbalent=sfaaent AND pjbal001=sfaa028 AND pjbal002='"||g_dlang||"' "
   #160411-00027 by whitney add end
#   #end add-point
#    LET g_from = " FROM sfaa_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("sfaa_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE asfr005_x02_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE asfr005_x02_curs CURSOR FOR asfr005_x02_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="asfr005_x02.ins_data" readonly="Y" >}
PRIVATE FUNCTION asfr005_x02_ins_data()
DEFINE sr RECORD 
   sfaadocno LIKE sfaa_t.sfaadocno, 
   sfaa020 LIKE sfaa_t.sfaa020, 
   sfaa010 LIKE sfaa_t.sfaa010, 
   imaal_t_imaal003 LIKE imaal_t.imaal003, 
   imaal_t_imaal004 LIKE imaal_t.imaal004, 
   sfaa013 LIKE sfaa_t.sfaa013, 
   l_sfaa013_desc LIKE type_t.chr30, 
   sfaa012 LIKE sfaa_t.sfaa012, 
   sfaa049 LIKE sfaa_t.sfaa049, 
   l_setfull LIKE type_t.num26_10, 
   l_sfaa050_sfaa051 LIKE type_t.num20_6, 
   sfaaent LIKE sfaa_t.sfaaent, 
   sfaasite LIKE sfaa_t.sfaasite, 
   sfaa050 LIKE sfaa_t.sfaa050, 
   sfaa051 LIKE sfaa_t.sfaa051, 
   sfaa002 LIKE sfaa_t.sfaa002, 
   l_sfaa002_desc LIKE type_t.chr30, 
   sfaa003 LIKE sfaa_t.sfaa003, 
   l_sfaa003_desc LIKE type_t.chr30, 
   sfaa004 LIKE sfaa_t.sfaa004, 
   l_sfaa004_desc LIKE type_t.chr30, 
   sfaa057 LIKE sfaa_t.sfaa057, 
   l_sfaa057_desc LIKE type_t.chr30, 
   sfaadocdt LIKE sfaa_t.sfaadocdt, 
   sfaastus LIKE sfaa_t.sfaastus, 
   l_sfaastus_desc LIKE type_t.chr30, 
   sfaa005 LIKE sfaa_t.sfaa005, 
   l_sfaa005_desc LIKE type_t.chr30, 
   sfaa006 LIKE sfaa_t.sfaa006, 
   sfaa007 LIKE sfaa_t.sfaa007, 
   sfaa008 LIKE sfaa_t.sfaa008, 
   sfaa063 LIKE sfaa_t.sfaa063, 
   sfaa009 LIKE sfaa_t.sfaa009, 
   l_sfaa009_desc LIKE type_t.chr30, 
   sfaa011 LIKE sfaa_t.sfaa011, 
   sfaa017 LIKE sfaa_t.sfaa017, 
   l_sfaa017_desc LIKE type_t.chr30, 
   sfaa018 LIKE sfaa_t.sfaa018, 
   l_sfaa018_desc LIKE type_t.chr30, 
   sfaa019 LIKE sfaa_t.sfaa019, 
   sfaa021 LIKE sfaa_t.sfaa021, 
   sfaa022 LIKE sfaa_t.sfaa022, 
   sfaa058 LIKE sfaa_t.sfaa058, 
   sfaa060 LIKE sfaa_t.sfaa060, 
   l_sfaa060_desc LIKE type_t.chr30, 
   sfaa068 LIKE sfaa_t.sfaa068, 
   l_sfaa068_desc LIKE type_t.chr30, 
   sfaa028 LIKE sfaa_t.sfaa028, 
   l_sfaa028_desc LIKE type_t.chr50, 
   sfaa029 LIKE sfaa_t.sfaa029, 
   l_sfaa029_desc LIKE type_t.chr50, 
   sfaa030 LIKE sfaa_t.sfaa030, 
   l_sfaa030_desc LIKE type_t.chr50, 
   sfaa055 LIKE sfaa_t.sfaa055, 
   sfaa056 LIKE sfaa_t.sfaa056
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_success LIKE type_t.num5
DEFINE sr1 RECORD
   l_sfda002_desc LIKE gzcbl_t.gzcbl004,
   l_sfdcdocno_sfdcseq LIKE type_t.chr30,
   sfdc004     LIKE sfdc_t.sfdc004,
   l_imaal003  LIKE imaal_t.imaal003,
   l_imaal004  LIKE imaal_t.imaal004,
   sfdc005     LIKE sfdc_t.sfdc005,
   sfdc008     LIKE sfdc_t.sfdc008,
   sfdc006     LIKE sfdc_t.sfdc006,
#160411-00027 by whitney mark start
#   sfdadocno   LIKE sfda_t.sfdadocno,
#   sfdaent     LIKE sfda_t.sfdaent,
#   sfda002     LIKE sfda_t.sfda002,
#   sfdcdocno   LIKE sfdc_t.sfdcdocno,
#   sfdcent     LIKE sfdc_t.sfdcent,
#   sfdcsite    LIKE sfdc_t.sfdcsite,
#   sfdcseq     LIKE sfdc_t.sfdcseq,
#160411-00027 by whitney mark end
   sfdc001     LIKE sfdc_t.sfdc001
 END RECORD
DEFINE l_sql STRING
DEFINE l_imaa127 LIKE imaa_t.imaa127   #系列       20150811 by dorislai add
DEFINE l_imae032 LIKE imae_t.imae032   #製程料號    20150811 by dorislai add
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    #160411-00027 by whitney add start
    LET l_sql = " SELECT (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001='4013' AND gzcbl002=sfda002 AND gzcbl003='"||g_dlang||"') gzcbl004,",
                "        trim(sfdcdocno)||'/'||trim(sfdcseq),",
                "        sfdc004,imaal003,imaal004,sfdc005,sfdc008,sfdc006,sfdc001 ",
                "   FROM sfda_t,sfaa_t,sfdc_t",
                "   LEFT JOIN imaal_t ON imaalent=sfdcent AND imaal001=sfdc004 AND imaal002='"||g_dlang||"' ",
                "  WHERE sfdcdocno = sfdadocno",
                "    AND sfdcent = sfdaent",
                "    AND sfdcent = sfaaent",
                "    AND sfdc001 = sfaadocno",
                "    AND sfdc001 = ?",
                "    AND sfdcent = ?",                             
                "    ORDER BY sfdcseq "
    DECLARE asfr005_x02_repcur CURSOR FROM l_sql
    #160411-00027 by whitney add end
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH asfr005_x02_curs INTO sr.*                               
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
#160425-00019 by whitney mark start
#       CALL s_asft340_full_sets(sr.sfaadocno,'','','')
#       RETURNING l_success,sr.l_setfull
#       IF NOT l_success THEN
#          LET sr.l_setfull = 0
#       END IF
#       LET sr.l_sfaa050_sfaa051 = sr.sfaa050 + sr.sfaa051
#160425-00019 by whitney mark end
#160411-00027 by whitney mark start
#       #dorislai-20150811-add----(S)
#       #單頭
#       #生管人員全名 l_sfaa002desc	
#       LET sr.l_sfaa002_desc = ''
#       LET sr.l_sfaa002desc = ''
#       SELECT ooag011 INTO sr.l_sfaa002_desc FROM ooag_t 
#        WHERE ooagent = g_enterprise AND ooag001 = sr.sfaa002 
#       IF NOT cl_null(sr.l_sfaa002_desc) THEN
#          LET sr.l_sfaa002desc = sr.sfaa002,'.',sr.l_sfaa002_desc
#       END IF
#       #工單類型全名 l_sfaa003desc	
#       LET sr.l_sfaa003_desc = ''
#       LET sr.l_sfaa003desc = ''
#       CALL s_desc_gzcbl004_desc('4007',sr.sfaa003) RETURNING sr.l_sfaa003_desc
#       IF NOT cl_null(sr.l_sfaa003_desc) THEN
#          LET sr.l_sfaa003desc = sr.sfaa003,'.',sr.l_sfaa003_desc 
#       END IF
#       #發科制度全名 l_sfaa004desc	
#       LET sr.l_sfaa004_desc = ''
#       LET sr.l_sfaa004desc = ''
#       CALL s_desc_gzcbl004_desc('4008',sr.sfaa004) RETURNING sr.l_sfaa004_desc
#       IF NOT cl_null(sr.l_sfaa004_desc) THEN
#          LET sr.l_sfaa004desc = sr.sfaa004,'.',sr.l_sfaa004_desc
#       END IF
#       #委外類型全名 l_sfaa057desc	
#       LET sr.l_sfaa057_desc = ''
#       LET sr.l_sfaa057desc = ''
#       CALL s_desc_gzcbl004_desc('4010',sr.sfaa057) RETURNING sr.l_sfaa057_desc
#       IF NOT cl_null(sr.l_sfaa057_desc) THEN
#          LET sr.l_sfaa057desc = sr.sfaa057,'.',sr.l_sfaa057_desc
#       END IF
#       #單號全名 l_sfaadocnodesc	
#       LET sr.l_sfaadocno_desc = ''
#       LET sr.l_sfaadocnodesc = ''
#       CALL s_aooi200_get_slip_desc(sr.sfaadocno) RETURNING sr.l_sfaadocno_desc
#       IF NOT cl_null(sr.l_sfaadocno_desc) THEN
#          LET sr.l_sfaadocnodesc = sr.sfaadocno,'.',sr.l_sfaadocno_desc
#       END IF
#       #狀態碼全名 l_sfaastusdesc	
#       LET sr.l_sfaastus_desc = ''
#       LET sr.l_sfaastusdesc = ''
#       CALL s_desc_gzcbl004_desc('13',sr.sfaastus) RETURNING sr.l_sfaastus_desc
#       IF NOT cl_null(sr.l_sfaastus_desc) THEN
#          LET sr.l_sfaastusdesc = sr.sfaastus,'.',sr.l_sfaastus_desc
#       END IF
#       
#       #====基本資料====
#       #工單來源全名 l_sfaa005desc	
#       LET sr.l_sfaa005_desc = ''
#       LET sr.l_sfaa005desc = ''
#       CALL s_desc_gzcbl004_desc('4009',sr.sfaa005) RETURNING sr.l_sfaa005_desc
#       IF NOT cl_null(sr.l_sfaa005_desc) THEN
#          LET sr.l_sfaa005desc = sr.sfaa005,'.',sr.l_sfaa005_desc
#       END IF
#       #來源單號全名 l_sfaa006desc	
#       LET sr.l_sfaa006_desc = ''	
#       LET sr.l_sfaa006desc = ''
#       CALL s_aooi200_get_slip_desc(sr.sfaa006) RETURNING sr.l_sfaa006_desc
#       IF NOT cl_null(sr.l_sfaa006_desc) THEN
#          LET sr.l_sfaa006desc = sr.sfaa006,'.',sr.l_sfaa006_desc
#       END IF
#       #來源項次序 l_sfaa007
#       LET sr.l_sfaa007 = ''
#       #---項次
#       IF NOT cl_null(sr.sfaa007) THEN
#          LET sr.l_sfaa007 = sr.sfaa007
#       END IF
#       #----項序
#       IF NOT cl_null(sr.sfaa008) THEN
#          LET sr.l_sfaa007 = sr.l_sfaa007 CLIPPED ||'-'||sr.sfaa008 
#       END IF
#       #----分批序
#       IF NOT cl_null(sr.sfaa063) THEN
#          LET sr.l_sfaa007 = sr.l_sfaa007 CLIPPED ||'-'||sr.sfaa063
#       END IF
#       #參考客戶全名 l_sfaa009desc	
#       LET sr.l_sfaa009_desc = ''
#       LET sr.l_sfaa009desc = ''
#       SELECT pmaal004 INTO sr.l_sfaa009_desc FROM pmaal_t 
#        WHERE pmaalent = g_enterprise AND pmaal001 = sr.sfaa009 AND pmaal002 = g_dlang
#       IF NOT cl_null(sr.l_sfaa009_desc) THEN
#          LET sr.l_sfaa009desc = sr.sfaa009,'.',sr.l_sfaa009_desc
#       END IF
#       #生產單位全名 l_sfaa013desc	
#       LET sr.l_sfaa013_desc = ''
#       LET sr.l_sfaa013desc = ''
#       SELECT oocal003 INTO sr.l_sfaa013_desc FROM oocal_t 
#        WHERE oocalent = g_enterprise AND oocal001 = sr.sfaa013 AND oocal002 = g_dlang
#       IF NOT cl_null(sr.l_sfaa013_desc) THEN
#          LET sr.l_sfaa013desc = sr.sfaa013,'.',sr.l_sfaa013_desc
#       END IF
#       #製成編號全名 l_sfaa016desc	
#       LET sr.l_sfaa016_desc = ''
#       LET sr.l_sfaa016desc = ''
#       IF NOT cl_null(sr.sfaa016) THEN
#          #抓製成料號
#          SELECT imae032 INTO l_imae032 FROM imae_t 
#           WHERE imaeent = g_enterprise AND imaesite = g_site AND imae001 = sr.sfaa010
#          IF cl_null(l_imae032) THEN
#             LET l_imae032 = sr.sfaa010
#          END IF
#          #抓製成編號
#          IF NOT cl_null(l_imae032) THEN
#             SELECT ecba003 INTO sr.l_sfaa016_desc FROM ecba_t 
#              WHERE ecbaent = g_enterprise AND ecba001 = l_imae032 AND ecba002 = sr.sfaa016
#          END IF
#       END IF
#       
#       IF NOT cl_null(sr.l_sfaa016_desc) THEN
#          LET sr.l_sfaa016desc = sr.sfaa016,'.',sr.l_sfaa016_desc
#       END IF
#       #部門廠商全名 l_sfaa017desc	
#       LET sr.l_sfaa017_desc = ''
#       LET sr.l_sfaa017desc = ''
#       
#       IF sr.sfaa057 = '2' THEN
#          INITIALIZE g_chkparam.* TO NULL
#          LET g_chkparam.arg1 = sr.sfaa017
#          CALL cl_ref_val("v_pmaal004")
#          LET sr.l_sfaa017_desc = g_chkparam.return1
#       ELSE
#          CALL s_desc_get_department_desc(sr.sfaa017) RETURNING sr.l_sfaa017_desc
#       END IF
#       
#       IF NOT cl_null(sr.l_sfaa017_desc) THEN
#          LET sr.l_sfaa017desc = sr.sfaa017,'.',sr.l_sfaa017_desc
#       END IF
#       #協作據點全名 l_sfaa018desc	
#       LET sr.l_sfaa018_desc = ''
#       LET sr.l_sfaa018desc = ''
#       SELECT ooeal003 INTO sr.l_sfaa018_desc FROM ooeal_t
#        WHERE ooealent = g_enterprise AND ooeal001 = sr.sfaa018 AND ooeal002 = g_dlang
#       IF NOT cl_null(sr.l_sfaa018_desc) THEN
#          LET sr.l_sfaa018desc = sr.sfaa018,'.',sr.l_sfaa018_desc
#       END IF
#       #母工單單號全名 l_sfaa021desc	
#       LET sr.l_sfaa021_desc = ''
#       LET sr.l_sfaa021desc = ''
#       CALL s_aooi200_get_slip_desc(sr.sfaa021) RETURNING sr.l_sfaa021_desc
#       IF NOT cl_null(sr.l_sfaa021_desc) THEN
#          LET sr.l_sfaa021desc = sr.sfaa021,'.',sr.l_sfaa021_desc
#       END IF
#       #參考原始單號全名 l_sfaa022desc	
#       LET sr.l_sfaa022_desc = ''
#       LET sr.l_sfaa022desc = ''
#       CALL s_aooi200_get_slip_desc(sr.sfaa022) RETURNING sr.l_sfaa022_desc
#       IF NOT cl_null(sr.l_sfaa022_desc) THEN
#          LET sr.l_sfaa022desc = sr.sfaa022,'.',sr.l_sfaa022_desc
#       END IF
#       #前工單單號全名 l_sfaa025desc	
#       LET sr.l_sfaa025_desc = ''
#       LET sr.l_sfaa025desc = ''
#       CALL s_aooi200_get_slip_desc(sr.sfaa025) RETURNING sr.l_sfaa025_desc
#       IF NOT cl_null(sr.l_sfaa025_desc) THEN
#          LET sr.l_sfaa025desc = sr.sfaa025,'.',sr.l_sfaa025_desc
#       END IF
#       #參考單位全名 l_sfaa060desc	
#       LET sr.l_sfaa060_desc = ''
#       LET sr.l_sfaa060desc = ''
#       SELECT oocal003 INTO sr.l_sfaa060_desc FROM oocal_t 
#        WHERE oocalent = g_enterprise AND oocal001 = sr.sfaa060 AND oocal002 = g_dlang
#       IF NOT cl_null(sr.l_sfaa060_desc) THEN
#          LET sr.l_sfaa060desc = sr.sfaa060,'.',sr.l_sfaa060_desc
#       END IF  
#       #成本中心全名 l_sfaa068desc	
#       LET sr.l_sfaa068_desc = ''
#       LET sr.l_sfaa068desc = ''
#       SELECT ooefl003 INTO sr.l_sfaa068_desc FROM ooefl_t
#        WHERE ooeflent = g_enterprise AND ooefl001 = sr.sfaa068 AND ooefl002 = g_dlang
#       IF NOT cl_null(sr.l_sfaa068_desc) THEN
#          LET sr.l_sfaa068desc = sr.sfaa068,'.',sr.l_sfaa068_desc
#       END IF
#       
#       #====工單資料====
#       #專案代號全名 l_sfaa028desc
#       LET sr.l_sfaa028_desc = ''
#       LET sr.l_sfaa028desc = ''
#       CALL s_desc_get_project_desc(sr.sfaa028) RETURNING sr.l_sfaa028_desc
#       IF NOT cl_null(sr.l_sfaa028_desc) THEN
#          LET sr.l_sfaa028desc = sr.sfaa028,'.',sr.l_sfaa028_desc
#       END IF
#       #WBS全名 l_sfaa029desc
#       LET sr.l_sfaa029_desc = ''
#       LET sr.l_sfaa029desc = ''
#       CALL s_desc_get_wbs_desc(sr.sfaa028,sr.sfaa029) RETURNING sr.l_sfaa029_desc
#       IF NOT cl_null(sr.l_sfaa029_desc) THEN
#          LET sr.l_sfaa029desc = sr.sfaa029,'.',sr.l_sfaa029_desc
#       END IF
#       #活動全名 l_sfaa030desc
#       LET sr.l_sfaa030_desc = ''
#       LET sr.l_sfaa030desc = ''
#       CALL s_desc_get_activity_desc(sr.sfaa028,sr.sfaa030) RETURNING sr.l_sfaa030_desc
#       IF NOT cl_null(sr.l_sfaa030_desc) THEN
#          LET sr.l_sfaa030desc = sr.sfaa030,'.',sr.l_sfaa030_desc
#       END IF
#       #理由碼全名 l_sfaa031desc
#       LET sr.l_sfaa031_desc = ''
#       LET sr.l_sfaa031desc = ''
#       CALL s_desc_get_acc_desc('225',sr.sfaa031) RETURNING sr.l_sfaa031_desc
#       IF NOT cl_null(sr.l_sfaa031_desc) THEN
#          LET sr.l_sfaa031desc = sr.sfaa031,'.',sr.l_sfaa031_desc
#       END IF
#       #預計入庫庫位全名 l_sfaa034desc
#       LET sr.l_sfaa034_desc = ''
#       LET sr.l_sfaa034desc = ''
#       CALL s_desc_get_stock_desc(g_site,sr.sfaa034) RETURNING sr.l_sfaa034_desc
#       IF NOT cl_null(sr.l_sfaa034_desc) THEN
#          LET sr.l_sfaa034desc = sr.sfaa034,'.',sr.l_sfaa034_desc
#       END IF
#       #預計入庫儲位全名 l_sfaa035desc
#       LET sr.l_sfaa035_desc = ''
#       LET sr.l_sfaa035desc = ''
#       CALL s_desc_get_locator_desc(g_site,sr.sfaa034,sr.sfaa035) RETURNING sr.l_sfaa035_desc
#       IF NOT cl_null(sr.l_sfaa035_desc) THEN
#          LET sr.l_sfaa035desc = sr.sfaa035,'.',sr.l_sfaa035_desc
#       END IF
#       
#       #====相關資訊====
#       #生管結案狀態全名 l_sfaa065desc
#       LET sr.l_sfaa065_desc = ''
#       LET sr.l_sfaa065desc = ''
#       CALL s_desc_gzcbl004_desc('4022',sr.sfaa065) RETURNING sr.l_sfaa065_desc
#       IF NOT cl_null(sr.l_sfaa065_desc) THEN
#          LET sr.l_sfaa065desc = sr.sfaa065,'.',sr.l_sfaa065_desc
#       END IF
#       #系列全名 l_imaa127desc
#       LET sr.l_imaa127_desc = ''
#       LET sr.l_imaa127desc = ''
#          #用料號抓取系列
#       SELECT imaa127 INTO l_imaa127 FROM imaa_t
#        WHERE imaa001 = sr.sfaa010
#          AND imaaent = g_enterprise
#         #抓取系列說明
#       CALL s_desc_get_acc_desc('2003',l_imaa127)  RETURNING sr.l_imaa127_desc 
#       IF NOT cl_null(sr.l_imaa127_desc) THEN
#          LET sr.l_imaa127desc = l_imaa127,'.',sr.l_imaa127_desc
#       END IF
#       #dorislai-20150811-add----(E)
#160411-00027 by whitney mark end
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.sfaadocno,sr.sfaa020,sr.sfaa010,sr.imaal_t_imaal003,sr.imaal_t_imaal004,sr.sfaa013,sr.l_sfaa013_desc,sr.sfaa012,sr.sfaa049,sr.l_setfull,sr.l_sfaa050_sfaa051,sr.sfaa050,sr.sfaa051,sr.sfaa002,sr.l_sfaa002_desc,sr.sfaa003,sr.l_sfaa003_desc,sr.sfaa004,sr.l_sfaa004_desc,sr.sfaa057,sr.l_sfaa057_desc,sr.sfaadocdt,sr.sfaastus,sr.l_sfaastus_desc,sr.sfaa005,sr.l_sfaa005_desc,sr.sfaa006,sr.sfaa007,sr.sfaa008,sr.sfaa063,sr.sfaa009,sr.l_sfaa009_desc,sr.sfaa011,sr.sfaa017,sr.l_sfaa017_desc,sr.sfaa018,sr.l_sfaa018_desc,sr.sfaa019,sr.sfaa021,sr.sfaa022,sr.sfaa058,sr.sfaa060,sr.l_sfaa060_desc,sr.sfaa068,sr.l_sfaa068_desc,sr.sfaa028,sr.l_sfaa028_desc,sr.sfaa029,sr.l_sfaa029_desc,sr.sfaa030,sr.l_sfaa030_desc,sr.sfaa055,sr.sfaa056
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "asfr005_x02_execute"
          LET g_errparam.code   = SQLCA.sqlcode
          LET g_errparam.popup  = FALSE
          CALL cl_err()       
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF
 
       #add-point:ins_data段after_save name="ins_data.after.save"
       #160411-00027 by whitney modify start
       FOREACH asfr005_x02_repcur USING sr.sfaadocno,sr.sfaaent INTO sr1.*
          EXECUTE insert_prep1 USING sr1.l_sfda002_desc,sr1.l_sfdcdocno_sfdcseq,sr1.sfdc004,sr1.l_imaal003,sr1.l_imaal004,
                                     sr1.sfdc005,sr1.sfdc008,sr1.sfdc006,sr1.sfdc001
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.extend = "asfr005_x02_repcur_execute"
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.popup  = FALSE
             CALL cl_err()       
             LET g_rep_success = 'N'
             EXIT FOREACH
          END IF
       END FOREACH
       #160411-00027 by whitney modify end
       #end add-point
       
    END FOREACH
    
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="asfr005_x02.rep_data" readonly="Y" >}
PRIVATE FUNCTION asfr005_x02_rep_data()
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
 
{<section id="asfr005_x02.other_function" readonly="Y" >}

 
{</section>}
 
