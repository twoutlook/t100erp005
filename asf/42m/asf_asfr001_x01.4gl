#該程式未解開Section, 採用最新樣板產出!
{<section id="asfr001_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:7(2017-01-11 16:55:57), PR版次:0007(2017-01-11 17:26:37)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000085
#+ Filename...: asfr001_x01
#+ Description: ...
#+ Creator....: 05231(2014-07-15 09:56:17)
#+ Modifier...: 01996 -SD/PR- 01996
 
{</section>}
 
{<section id="asfr001_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#160411-00027    16/04/22  By Whitney 效能優化
#160425-00019    16/05/20  By Whitney 齊料套數不及時計算改抓sfaa071
#160906-00047#1  17/01/11  By xujing  算工单齐套的时候，应过滤掉工单单身必要特性sfba008=4 的料，因为参考材料不发料
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
       chk01 LIKE type_t.chr5          #判斷印子報表
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="asfr001_x01.main" readonly="Y" >}
PUBLIC FUNCTION asfr001_x01(p_arg1,p_arg2)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr5         #tm.chk01  判斷印子報表
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.chk01 = p_arg2
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "asfr001_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL asfr001_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL asfr001_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL asfr001_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL asfr001_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL asfr001_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="asfr001_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION asfr001_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "sfaadocno.sfaa_t.sfaadocno,sfaa020.sfaa_t.sfaa020,sfaa010.sfaa_t.sfaa010,l_imaal003.type_t.chr30,l_imaal004.type_t.chr30,sfaa013.sfaa_t.sfaa013,l_sfaa013_desc.type_t.chr30,sfaa012.sfaa_t.sfaa012,sfaa049.sfaa_t.sfaa049,l_count.type_t.num26_10,l_qty.type_t.num20_6,sfaasite.sfaa_t.sfaasite,sfaa050.sfaa_t.sfaa050,sfaa051.sfaa_t.sfaa051,sfaa002.sfaa_t.sfaa002,l_sfaa002_desc.type_t.chr30,sfaa003.sfaa_t.sfaa003,l_sfaa003_desc.type_t.chr100,sfaa004.sfaa_t.sfaa004,l_sfaa004_desc.type_t.chr50,sfaa057.sfaa_t.sfaa057,l_sfaa057_desc.type_t.chr50,sfaadocdt.sfaa_t.sfaadocdt,sfaastus.sfaa_t.sfaastus,l_sfaastus_desc.type_t.chr30,sfaa005.sfaa_t.sfaa005,l_sfaa005_desc.type_t.chr100,sfaa006.sfaa_t.sfaa006,sfaa007.sfaa_t.sfaa007,sfaa008.sfaa_t.sfaa008,sfaa063.sfaa_t.sfaa063,sfaa009.sfaa_t.sfaa009,l_sfaa009_desc.type_t.chr50,sfaa011.sfaa_t.sfaa011,sfaa017.sfaa_t.sfaa017,l_sfaa017_desc.type_t.chr50,sfaa018.sfaa_t.sfaa018,l_sfaa018_desc.type_t.chr30,sfaa019.sfaa_t.sfaa019,sfaa021.sfaa_t.sfaa021,sfaa022.sfaa_t.sfaa022,sfaa058.sfaa_t.sfaa058,sfaa060.sfaa_t.sfaa060,l_sfaa060_desc.type_t.chr30,sfaa068.sfaa_t.sfaa068,l_sfaa068_desc.type_t.chr30,sfaa028.sfaa_t.sfaa028,l_sfaa028_desc.type_t.chr30,sfaa029.sfaa_t.sfaa029,l_sfaa029_desc.type_t.chr30,sfaa030.sfaa_t.sfaa030,l_sfaa030_desc.type_t.chr30,sfaa055.sfaa_t.sfaa055,sfaa056.sfaa_t.sfaa056" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   LET g_sql = "sfbadocno.sfba_t.sfbadocno,", 
                "l_sfbaseq_sfbaseq1.type_t.chr100,",
                "sfba006.sfba_t.sfba006,",
                "imaal003.imaal_t.imaal003,",
                "imaal004.imaal_t.imaal004,",       
                "sfba021.sfba_t.sfba021,",
                "sfba009.sfba_t.sfba009,",
                "sfba028.sfba_t.sfba028,",
                "sfba014.sfba_t.sfba014,",
                "sfba015.sfba_t.sfba015,",
                "sfba013.sfba_t.sfba013,", 
                "sfba016.sfba_t.sfba016,", 
                "l_qty01.type_t.num20_6,", 
                "l_qty02.type_t.num20_6,",
                "sfba003.sfba_t.sfba003,",
                "sfba004.sfba_t.sfba004,",
                "sfbaseq.sfba_t.sfbaseq,",
                "sfbaseq1.sfba_t.sfbaseq1"
   IF NOT cl_xg_create_tmptable(g_sql,2) THEN
      LET g_rep_success = 'N'            
   END IF
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="asfr001_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION asfr001_x01_ins_prep()
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
             ?,?,?,?)"
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
         LET g_sql = " INSERT INTO ",g_rep_db CLIPPED,g_rep_tmpname[2] CLIPPED," VALUES(?,?,?,?,?,?, 
             ?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="asfr001_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION asfr001_x01_sel_prep()
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
#   LET g_select = " SELECT sfaadocno,sfaa020,sfaa010,'','',sfaa013,'',sfaa012,sfaa049,'',NULL,sfaaent, 
#       sfaasite,sfaa050,sfaa051,sfaa002,'',sfaa003,'',sfaa004,NULL,sfaa057,'',sfaadocdt,sfaastus,'', 
#       sfaa005,'',sfaa006,sfaa007,sfaa008,sfaa063,sfaa009,'',sfaa011,sfaa017,'',sfaa018,'',sfaa019,sfaa021, 
#       sfaa022,sfaa058,sfaa060,'',sfaa068,'',sfaa028,'',sfaa029,'',sfaa030,'',sfaa055,sfaa056"
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
   PREPARE asfr001_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE asfr001_x01_curs CURSOR FOR asfr001_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="asfr001_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION asfr001_x01_ins_data()
DEFINE sr RECORD 
   sfaadocno LIKE sfaa_t.sfaadocno, 
   sfaa020 LIKE sfaa_t.sfaa020, 
   sfaa010 LIKE sfaa_t.sfaa010, 
   l_imaal003 LIKE type_t.chr30, 
   l_imaal004 LIKE type_t.chr30, 
   sfaa013 LIKE sfaa_t.sfaa013, 
   l_sfaa013_desc LIKE type_t.chr30, 
   sfaa012 LIKE sfaa_t.sfaa012, 
   sfaa049 LIKE sfaa_t.sfaa049, 
   l_count LIKE type_t.num26_10, 
   l_qty LIKE type_t.num20_6, 
   sfaaent LIKE sfaa_t.sfaaent, 
   sfaasite LIKE sfaa_t.sfaasite, 
   sfaa050 LIKE sfaa_t.sfaa050, 
   sfaa051 LIKE sfaa_t.sfaa051, 
   sfaa002 LIKE sfaa_t.sfaa002, 
   l_sfaa002_desc LIKE type_t.chr30, 
   sfaa003 LIKE sfaa_t.sfaa003, 
   l_sfaa003_desc LIKE type_t.chr100, 
   sfaa004 LIKE sfaa_t.sfaa004, 
   l_sfaa004_desc LIKE type_t.chr50, 
   sfaa057 LIKE sfaa_t.sfaa057, 
   l_sfaa057_desc LIKE type_t.chr50, 
   sfaadocdt LIKE sfaa_t.sfaadocdt, 
   sfaastus LIKE sfaa_t.sfaastus, 
   l_sfaastus_desc LIKE type_t.chr30, 
   sfaa005 LIKE sfaa_t.sfaa005, 
   l_sfaa005_desc LIKE type_t.chr100, 
   sfaa006 LIKE sfaa_t.sfaa006, 
   sfaa007 LIKE sfaa_t.sfaa007, 
   sfaa008 LIKE sfaa_t.sfaa008, 
   sfaa063 LIKE sfaa_t.sfaa063, 
   sfaa009 LIKE sfaa_t.sfaa009, 
   l_sfaa009_desc LIKE type_t.chr50, 
   sfaa011 LIKE sfaa_t.sfaa011, 
   sfaa017 LIKE sfaa_t.sfaa017, 
   l_sfaa017_desc LIKE type_t.chr50, 
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
   l_sfaa028_desc LIKE type_t.chr30, 
   sfaa029 LIKE sfaa_t.sfaa029, 
   l_sfaa029_desc LIKE type_t.chr30, 
   sfaa030 LIKE sfaa_t.sfaa030, 
   l_sfaa030_desc LIKE type_t.chr30, 
   sfaa055 LIKE sfaa_t.sfaa055, 
   sfaa056 LIKE sfaa_t.sfaa056
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE sr1   RECORD 
   sfbadocno          LIKE sfba_t.sfbadocno, 
   l_sfbaseq_sfbaseq1 LIKE type_t.chr100, 
   sfba006            LIKE sfba_t.sfba006,
   imaal003           LIKE imaal_t.imaal003,
   imaal004           LIKE imaal_t.imaal004,
   sfba021            LIKE sfba_t.sfba021,
   sfba009            LIKE sfba_t.sfba009,
   sfba028            LIKE sfba_t.sfba028,
   sfba014            LIKE sfba_t.sfba014,
   sfba015            LIKE sfba_t.sfba015,
   sfba013            LIKE sfba_t.sfba013, 
   sfba016            LIKE sfba_t.sfba016, 
   l_qty01            LIKE type_t.num20_6,  
   l_qty02            LIKE type_t.num20_6,
   sfba003            LIKE sfba_t.sfba003,
   sfba004            LIKE sfba_t.sfba004,
   sfbaseq            LIKE sfba_t.sfbaseq,
   sfbaseq1           LIKE sfba_t.sfbaseq1
 END RECORD
DEFINE l_success STRING
DEFINE l_sql STRING  
DEFINE l_imaa127 LIKE imaa_t.imaa127   #系列       20150811 by dorislai add
DEFINE l_imae032 LIKE imae_t.imae032   #製程料號    20150811 by dorislai add
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    #160411-00027 by whitney add start
    LET l_sql = " SELECT sfbadocno,sfbaseq||'/'||sfbaseq1,sfba006,imaal003,imaal004,sfba021,sfba009,sfba028,sfba014,sfba015, ",
                "        sfba013,sfba016,0,0,sfba003,sfba004,sfbaseq,sfbaseq1 ",
                "   FROM sfba_t LEFT JOIN imaal_t ON imaalent = sfbaent AND imaal001=sfba006 AND imaal002 ='",g_dlang,"' ",
                "  WHERE sfbadocno = ? ",
                "  ORDER BY sfbaseq,sfbaseq1 "
    DECLARE asfr001_x01_repcur CURSOR FROM l_sql
    #160411-00027 by whitney add end
    CALL asfr001_x01_seq_sets_def_cursor() RETURNING l_success
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH asfr001_x01_curs INTO sr.*                               
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
#       #已入庫量
#       LET sr.l_qty = sr.sfaa050 + sr.sfaa051
#       #備料套數
#       CALL s_asft340_full_sets(sr.sfaadocno,'','','') RETURNING l_success,sr.l_count  
#160425-00019 by whitney mark end
#160411-00027 by whitney mark start
#       #品名、規格
#       SELECT imaal003,imaal004 INTO sr.l_imaal003,sr.l_imaal004
#         FROM imaal_t
#        WHERE imaalent = sr.sfaaent
#          AND imaal002 = g_dlang
#          AND imaal001 = sr.sfaa010
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
       EXECUTE insert_prep USING sr.sfaadocno,sr.sfaa020,sr.sfaa010,sr.l_imaal003,sr.l_imaal004,sr.sfaa013,sr.l_sfaa013_desc,sr.sfaa012,sr.sfaa049,sr.l_count,sr.l_qty,sr.sfaasite,sr.sfaa050,sr.sfaa051,sr.sfaa002,sr.l_sfaa002_desc,sr.sfaa003,sr.l_sfaa003_desc,sr.sfaa004,sr.l_sfaa004_desc,sr.sfaa057,sr.l_sfaa057_desc,sr.sfaadocdt,sr.sfaastus,sr.l_sfaastus_desc,sr.sfaa005,sr.l_sfaa005_desc,sr.sfaa006,sr.sfaa007,sr.sfaa008,sr.sfaa063,sr.sfaa009,sr.l_sfaa009_desc,sr.sfaa011,sr.sfaa017,sr.l_sfaa017_desc,sr.sfaa018,sr.l_sfaa018_desc,sr.sfaa019,sr.sfaa021,sr.sfaa022,sr.sfaa058,sr.sfaa060,sr.l_sfaa060_desc,sr.sfaa068,sr.l_sfaa068_desc,sr.sfaa028,sr.l_sfaa028_desc,sr.sfaa029,sr.l_sfaa029_desc,sr.sfaa030,sr.l_sfaa030_desc,sr.sfaa055,sr.sfaa056
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "asfr001_x01_execute"
          LET g_errparam.code   = SQLCA.sqlcode
          LET g_errparam.popup  = FALSE
          CALL cl_err()       
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF
 
       #add-point:ins_data段after_save name="ins_data.after.save"
#160411-00027 by whitney mark start
#       LET l_sql=
#             "SELECT sfbadocno,sfbaseq||'/'||sfbaseq1,sfba006,imaal003,imaal004,sfba021,sfba009,sfba028,sfba014,sfba015,sfba013,sfba016,0,0, ",
#             "       sfba003,sfba004,sfbaseq,sfbaseq1 ",
#             "  FROM sfba_t LEFT JOIN imaal_t ON imaalent = sfbaent AND imaal001=sfba006 AND imaal002 ='",g_dlang,"'  ",
#             " WHERE sfbadocno ='",sr.sfaadocno,"' ",
#             " ORDER BY sfbaseq,sfbaseq1 "
#       DECLARE asfr001_x01_repcur CURSOR FROM l_sql
#       FOREACH asfr001_x01_repcur INTO sr1.* 
#160411-00027 by whitney mark end
       FOREACH asfr001_x01_repcur USING sr.sfaadocno INTO sr1.* 
#          CALL s_asft340_full_sets(sr1.sfbadocno,sr1.sfba003,sr1.sfba004,'') RETURNING  l_success,sr1.l_qty01
          CALL asfr001_x01_seq_sets(sr1.sfbadocno,sr1.sfbaseq,sr1.sfbaseq1) RETURNING l_success,sr1.l_qty01
          CALL s_asft300_07(sr1.sfbadocno,sr1.sfbaseq,sr1.sfbaseq1) RETURNING  l_success,sr1.l_qty02   
          EXECUTE insert_prep1 USING sr1.sfbadocno,sr1.l_sfbaseq_sfbaseq1,sr1.sfba006,sr1.imaal003,sr1.imaal004,
                                     sr1.sfba021,sr1.sfba009,sr1.sfba028,sr1.sfba014,sr1.sfba015,sr1.sfba013,sr1.sfba016,
                                     sr1.l_qty01,sr1.l_qty02,sr1.sfba003,sr1.sfba004,sr1.sfbaseq,sr1.sfbaseq1                                     
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.extend = "asfr001_x01_execute1"
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.popup  = FALSE
             CALL cl_err()       
             LET g_rep_success = 'N'
             EXIT FOREACH
          END IF 
       END FOREACH
       #end add-point
       
    END FOREACH
    
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="asfr001_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION asfr001_x01_rep_data()
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
 
{<section id="asfr001_x01.other_function" readonly="Y" >}
################################################################################
# Descriptions...: 工單單一項次套數計算--定義CURSOR
# Memo...........:
# Usage..........: CALL asfr001_x01_seq_sets_def_cursor()
#                       RETURNING r_success
# Input parameter: 無
# Return code....: r_success      成功否
# Date & Author..: 2014/08/20 By Sarah
# Modify.........:
################################################################################
PRIVATE FUNCTION asfr001_x01_seq_sets_def_cursor()
   DEFINE r_success            LIKE type_t.num5
   DEFINE l_sql                STRING

   LET r_success = FALSE

   #組CURSOR
   #僅找出項序為0的備料資料
   #                    項次     作業編號  製程     QPA-分子  QPA-分母 誤差率    
   LET l_sql = " SELECT sfbaseq, sfba003, sfba004, sfba010, sfba011, sfba012 ",
               "  FROM sfaa_t,sfba_t ",
               " WHERE sfaaent   = sfbaent ",
               "   AND sfaasite  = sfbasite ",
               "   AND sfaadocno = sfbadocno ",
               "   AND sfaaent   = ",g_enterprise,
               "   AND sfaasite  = '",g_site,"'",
               "   AND sfaadocno = ? ",
               "   AND sfbaseq   = ? ",
               "   AND (sfba008  = '1' OR sfba008 = '2' )",    #1.主要材料  2.次要材料
               "   AND sfba009   = 'N' ",                      #倒扣料='N'
               "   AND sfbaseq1  = 0 "                         #項次為0
#   #作業編號               
#   IF NOT cl_null(p_sfba003) THEN
#      LET l_sql = l_sql CLIPPED," AND sfba003 = '",p_sfba003,"'"
#   END IF
#   #製程式
#   IF NOT cl_null(p_sfba004) THEN
#      LET l_sql = l_sql CLIPPED," AND sfba004 = '",p_sfba004,"'"
#   END IF
   
   LET l_sql = l_sql CLIPPED," ORDER BY sfbaseq "

   PREPARE asfr001_x01_seq_sets_p1 FROM l_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'asfr001_x01_seq_sets_p1'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   DECLARE asfr001_x01_seq_sets_cs1 CURSOR FOR asfr001_x01_seq_sets_p1
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'asfr001_x01_seq_sets_cs1'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   #按備料項次,把所有項序的資料找出
#   LET l_sql = " SELECT * FROM sfba_t ",   #160906-00047#1 mark
   #160906-00047#1 add(s)
   LET l_sql = " SELECT sfbaent,sfbasite,sfbadocno,sfbaseq,sfbaseq1,sfba001,sfba002,sfba003,     ",
               "        sfba004,sfba005, sfba006,  sfba007,sfba008, sfba009,sfba010,sfba011,sfba012,",
               "        sfba013,sfba014, sfba015,  sfba016,sfba017, sfba018,sfba019,sfba020,sfba021,",
               "        sfba022,sfba023, sfba024,  sfba025,sfba026, sfba027,sfba028,sfba029,sfba030,",
               "        sfba031,sfba032, sfba033,  sfba034,sfba035 ",
    #160906-00047#1 add(e)           
               "  WHERE sfbaent   = ",g_enterprise,
               "    AND sfbasite  = '",g_site,"'",
               "    AND sfbadocno = ? ",
               "    AND sfbaseq   = ? ",
               "    AND sfbaseq1  = ? ",
               "    AND sfba008 <> '4'",  #160906-00047#1 add
               "  ORDER BY sfbaseq,sfbaseq1 "
   PREPARE asfr001_x01_seq_sets_p2 FROM l_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'asfr001_x01_seq_sets_p2'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   DECLARE asfr001_x01_seq_sets_cs2 CURSOR FOR asfr001_x01_seq_sets_p2
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'asfr001_x01_seq_sets_cs2'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF  

   #按工單號碼+項次+項序找發退料數量
   LET l_sql = " SELECT sfda002,sfdc006,sfdc008 ",
               "   FROM sfda_t,sfdc_t ",
               "  WHERE sfdcent = sfdaent ",
               "    AND sfdcsite = sfdasite ",
               "    AND sfdcdocno = sfdadocno ",
               "    AND sfdcent = ",g_enterprise,
               "    AND sfdcsite = '",g_site,"'",
               "    AND sfdastus = 'S'",                       #已扣帳
#              "    AND (sfda002 = '11' OR sfda002 = '21') ",  #發料類型  11.成套發料  21.成套退料
               "    AND sfdc001 = ? ",                         #工單單號
               "    AND sfdc002 = ? ",                         #工單-項次
               "    AND sfdc003 = ? "                          #工單-項序
#   #傳入日期值不空時,找的發退料過帳日期不可大於此日期值            
#   IF NOT cl_null(p_date) THEN
#      LET l_sql = l_sql CLIPPED,"  AND sfda001 <= '",p_date,"'"
#   END IF
   PREPARE asfr001_x01_seq_sets_p3 FROM l_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'asfr001_x01_seq_sets_p3'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   DECLARE asfr001_x01_seq_sets_cs3 CURSOR FOR asfr001_x01_seq_sets_p3
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'asfr001_x01_seq_sets_cs3'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success 
   END IF    

   LET r_success = TRUE
   RETURN r_success

END FUNCTION

################################################################################
# Descriptions...: 工單單一項次套數計算
# Memo...........:
# Usage..........: CALL asfr001_x01_seq_sets(p_sfaadocno,p_sfbaseq,p_sfbaseq1)
#                       RETURNING r_success,r_sets
# Input parameter: p_sfaadocno    工單編號
#                : p_sfbaseq      項次
#                : p_sfbaseq1     項序
# Return code....: r_success      成功否(TRUE-成功 FALSE-失敗)
#                : r_sets         工單單一項次套數
# Date & Author..: 2014/08/20 By Sarah
# Modify.........:
################################################################################
PRIVATE FUNCTION asfr001_x01_seq_sets(p_sfaadocno,p_sfbaseq,p_sfbaseq1)
DEFINE p_sfaadocno          LIKE sfaa_t.sfaadocno
DEFINE p_sfbaseq            LIKE sfba_t.sfbaseq
DEFINE p_sfbaseq1           LIKE sfba_t.sfbaseq1
DEFINE r_success            LIKE type_t.num5
DEFINE r_sets               LIKE type_t.num26_10
#161109-00085#40-s
#DEFINE l_sfba               RECORD LIKE sfba_t.*
DEFINE l_sfba RECORD  #工單備料單身檔
       sfbaent LIKE sfba_t.sfbaent, #企業編號
       sfbasite LIKE sfba_t.sfbasite, #營運據點
       sfbadocno LIKE sfba_t.sfbadocno, #單號
       sfbaseq LIKE sfba_t.sfbaseq, #項次
       sfbaseq1 LIKE sfba_t.sfbaseq1, #項序
       sfba001 LIKE sfba_t.sfba001, #上階料號
       sfba002 LIKE sfba_t.sfba002, #部位
       sfba003 LIKE sfba_t.sfba003, #作業編號
       sfba004 LIKE sfba_t.sfba004, #作業序
       sfba005 LIKE sfba_t.sfba005, #BOM料號
       sfba006 LIKE sfba_t.sfba006, #發料料號
       sfba007 LIKE sfba_t.sfba007, #投料時距
       sfba008 LIKE sfba_t.sfba008, #必要特性
       sfba009 LIKE sfba_t.sfba009, #倒扣料
       sfba010 LIKE sfba_t.sfba010, #標準QPA分子
       sfba011 LIKE sfba_t.sfba011, #標準QPA分母
       sfba012 LIKE sfba_t.sfba012, #允許誤差率
       sfba013 LIKE sfba_t.sfba013, #應發數量
       sfba014 LIKE sfba_t.sfba014, #單位
       sfba015 LIKE sfba_t.sfba015, #委外代買數量
       sfba016 LIKE sfba_t.sfba016, #已發數量
       sfba017 LIKE sfba_t.sfba017, #報廢數量
       sfba018 LIKE sfba_t.sfba018, #盤虧數量
       sfba019 LIKE sfba_t.sfba019, #指定發料倉庫
       sfba020 LIKE sfba_t.sfba020, #指定發料儲位
       sfba021 LIKE sfba_t.sfba021, #產品特徵
       sfba022 LIKE sfba_t.sfba022, #替代率
       sfba023 LIKE sfba_t.sfba023, #標準應發數量
       sfba024 LIKE sfba_t.sfba024, #調整應發數量
       sfba025 LIKE sfba_t.sfba025, #超領數量
       sfba026 LIKE sfba_t.sfba026, #SET替代狀態
       sfba027 LIKE sfba_t.sfba027, #SET替代群組
       sfba028 LIKE sfba_t.sfba028, #客供料
       sfba029 LIKE sfba_t.sfba029, #指定發料批號
       sfba030 LIKE sfba_t.sfba030, #指定庫存管理特徵
       sfba031 LIKE sfba_t.sfba031, #備置量
       sfba032 LIKE sfba_t.sfba032, #備置理由碼
       sfba033 LIKE sfba_t.sfba033, #保稅否
       sfba034 LIKE sfba_t.sfba034, #SET被替代群組
       sfba035 LIKE sfba_t.sfba035  #SET替代套數
END RECORD
#161109-00085#40-e
DEFINE l_tot                RECORD 
                            sfbaseq       LIKE sfba_t.sfbaseq,    #工单项次
                            sfba003       LIKE sfba_t.sfba003,    #作业编号(扩展用)
                            sfba004       LIKE sfba_t.sfba004,    #制程序(扩展用)
                            sfba010       LIKE sfba_t.sfba010,    #标准QPA分子
                            sfba011       LIKE sfba_t.sfba011,    #标准QPA分母
                            sfba012       LIKE sfba_t.sfba012     #允许误差率
                            END RECORD 
DEFINE l_sfaa012            LIKE sfaa_t.sfaa012                   #工单生产数量
DEFINE l_sfba013            LIKE sfba_t.sfba013                   #应发数量  
DEFINE l_sfda002            LIKE sfda_t.sfda002                   #发料类型   
DEFINE l_sfdc006            LIKE sfdc_t.sfdc006                   #实际发料单位
DEFINE l_sfdc008            LIKE sfdc_t.sfdc008                   #实际发料数量
DEFINE l_tot_sfdc008        LIKE sfdc_t.sfdc008                   #汇总实际发料数量
DEFINE l_success            LIKE type_t.num5
DEFINE l_sets               LIKE type_t.num26_10                  #套數
DEFINE l_rate               LIKE inaj_t.inaj014                   #單位轉換率


   WHENEVER ERROR CONTINUE

   LET r_success = FALSE
   LET r_sets = 0
   
   IF cl_null(p_sfaadocno) OR cl_null(p_sfbaseq) THEN
      RETURN r_success,r_sets
   END IF
   
   #工單生產數量
   SELECT sfaa012 INTO l_sfaa012 FROM sfaa_t
    WHERE sfaaent   = g_enterprise
      AND sfaasite  = g_site
      AND sfaadocno = p_sfaadocno

#   CALL asfr001_x01_seq_sets_def_cursor() RETURNING l_success
#   IF NOT l_success THEN
#      RETURN r_success,r_sets   
#   END IF
   
   EXECUTE asfr001_x01_seq_sets_cs1 USING p_sfaadocno,p_sfbaseq INTO l_tot.*
   IF SQLCA.sqlcode THEN
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = SQLCA.sqlcode
#      LET g_errparam.extend = 'EXECUTE asfr001_x01_seq_sets_cs1'
#      LET g_errparam.popup = TRUE
#      CALL cl_err()

      RETURN r_success,r_sets   
   END IF 
   
   LET l_tot_sfdc008 = 0
   #161109-00085#40-s
   #FOREACH asfr001_x01_seq_sets_cs2 USING p_sfaadocno,p_sfbaseq,p_sfbaseq1 INTO l_sfba.*
   FOREACH asfr001_x01_seq_sets_cs2 USING p_sfaadocno,p_sfbaseq,p_sfbaseq1 
   INTO 
        l_sfba.sfbaent,l_sfba.sfbasite,l_sfba.sfbadocno,l_sfba.sfbaseq,l_sfba.sfbaseq1,
        l_sfba.sfba001,l_sfba.sfba002,l_sfba.sfba003,l_sfba.sfba004,l_sfba.sfba005,
        l_sfba.sfba006,l_sfba.sfba007,l_sfba.sfba008,l_sfba.sfba009,l_sfba.sfba010,
        l_sfba.sfba011,l_sfba.sfba012,l_sfba.sfba013,l_sfba.sfba014,l_sfba.sfba015,
        l_sfba.sfba016,l_sfba.sfba017,l_sfba.sfba018,l_sfba.sfba019,l_sfba.sfba020,
        l_sfba.sfba021,l_sfba.sfba022,l_sfba.sfba023,l_sfba.sfba024,l_sfba.sfba025,
        l_sfba.sfba026,l_sfba.sfba027,l_sfba.sfba028,l_sfba.sfba029,l_sfba.sfba030,
        l_sfba.sfba031,l_sfba.sfba032,l_sfba.sfba033,l_sfba.sfba034,l_sfba.sfba035
   #161109-00085#40-e
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach asfr001_x01_seq_full_sets_cs2'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success,r_sets   
      END IF     
      
      #委外代買數量算成已發料 BY SA
      LET l_tot_sfdc008 = l_tot_sfdc008 + l_sfba.sfba015 * l_sfba.sfba022      
      
      #BY 項次+項序 的 發料數量匯總
      FOREACH asfr001_x01_seq_sets_cs3 USING p_sfaadocno,l_sfba.sfbaseq,l_sfba.sfbaseq1
                                       INTO l_sfda002,l_sfdc006,l_sfdc008
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'foreach asfr001_x01_seq_full_sets_cs2'
            LET g_errparam.popup = TRUE
            CALL cl_err()

            RETURN r_success,r_sets   
         END IF       
         
         #單位轉換率
         LET l_rate = 1
         IF l_sfdc006 <> l_sfba.sfba014 THEN
            CALL s_aimi190_get_convert(l_sfba.sfba006,l_sfdc006,l_sfba.sfba014)
                 RETURNING l_success,l_rate
            IF NOT l_success THEN
               LET l_rate = 1
            END IF
         END IF
         
         #發料類型 1.成套發料  2.成套退料
         LET l_sfda002 = l_sfda002[1,1]
         CASE l_sfda002
              WHEN '1'    LET l_tot_sfdc008 = l_tot_sfdc008 + (l_sfdc008 * l_rate) / l_sfba.sfba022
              WHEN '2'    LET l_tot_sfdc008 = l_tot_sfdc008 - (l_sfdc008 * l_rate) / l_sfba.sfba022
         END CASE
   
      END FOREACH
   
   END FOREACH
   
   #單項足套數=(SUM(已發數量*替代率) / 項序0的標準QPA分子 * 項序0的標準QPA分母 WHERE 相同工單+項次)/(100-項序0的允許誤差率)*100
   LET l_sets = (l_tot_sfdc008 / l_tot.sfba010 * l_tot.sfba011 ) / (100 - l_tot.sfba012) * 100

   RETURN r_success,l_sets

END FUNCTION

 
{</section>}
 
