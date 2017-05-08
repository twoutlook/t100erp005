#該程式未解開Section, 採用最新樣板產出!
{<section id="asfr302_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:4(2016-04-21 17:33:03), PR版次:0004(2016-04-21 17:40:50)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000070
#+ Filename...: asfr302_x01
#+ Description: ...
#+ Creator....: 01258(2014-10-29 14:47:10)
#+ Modifier...: 06814 -SD/PR- 06814
 
{</section>}
 
{<section id="asfr302_x01.global" readonly="Y" >}
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
       chk01 LIKE type_t.chr5          #判斷列印子報
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="asfr302_x01.main" readonly="Y" >}
PUBLIC FUNCTION asfr302_x01(p_arg1,p_arg2)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr5         #tm.chk01  判斷列印子報
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
   LET g_rep_code = "asfr302_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL asfr302_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL asfr302_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL asfr302_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL asfr302_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL asfr302_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="asfr302_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION asfr302_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "sfaadocno.sfaa_t.sfaadocno,sfaadocdt.sfaa_t.sfaadocdt,l_sfaastus.type_t.chr30,l_sfaastus_ref.type_t.chr30,sfaa002.sfaa_t.sfaa002,sfaa002_desc.type_t.chr30,l_sfaa003.type_t.chr30,l_sfaa003_ref.type_t.chr30,l_sfaa057.type_t.chr30,l_sfaa057_ref.type_t.chr30,sfaa006.sfaa_t.sfaa006,sfaa007.sfaa_t.sfaa007,sfaa008.sfaa_t.sfaa008,sfaa009.sfaa_t.sfaa009,sfaa009_desc.type_t.chr30,sfaa021.sfaa_t.sfaa021,sfaa010.sfaa_t.sfaa010,sfaa010_desc.type_t.chr80,sfaa010_desc_1.type_t.chr80,sfaa012.sfaa_t.sfaa012,sfaa013.sfaa_t.sfaa013,sfaa013_desc.type_t.chr30,sfaa017.sfaa_t.sfaa017,sfaa017_desc.type_t.chr80,sfaa019.sfaa_t.sfaa019,sfaa020.sfaa_t.sfaa020,ooff013.type_t.chr500,sfaasite.sfaa_t.sfaasite,sfbaseq.sfba_t.sfbaseq,sfbaseq1.sfba_t.sfbaseq1,sfaa003.sfaa_t.sfaa003,sfba002.sfba_t.sfba002,sfba002_desc.type_t.chr30,sfba003.sfba_t.sfba003,sfba003_desc.type_t.chr30,sfba004.sfba_t.sfba004,sfba006.sfba_t.sfba006,sfba006_desc.type_t.chr80,sfba006_desc_1.type_t.chr80,sfba021.sfba_t.sfba021,sfba021_desc.type_t.chr80,l_sfba008.type_t.chr30,sfba009.sfba_t.sfba009,sfba010.sfba_t.sfba010,sfba011.sfba_t.sfba011,sfba012.sfba_t.sfba012,sfba023.sfba_t.sfba023,sfba024.sfba_t.sfba024,sfba013.sfba_t.sfba013,sfba014.sfba_t.sfba014,sfba014_desc.type_t.chr30,sfba015.sfba_t.sfba015,sfba016.sfba_t.sfba016,sfba025.sfba_t.sfba025,l_qty1.type_t.num20_6,sfba017.sfba_t.sfba017,l_qty2.type_t.num20_6,sfba028.sfba_t.sfba028,l_imaf034.type_t.chr1,l_imae092.type_t.chr1,ooff013_sfba.type_t.chr500,sfaa004.sfaa_t.sfaa004,sfaa057.sfaa_t.sfaa057,sfaastus.sfaa_t.sfaastus,sfaa005.sfaa_t.sfaa005,sfaa011.sfaa_t.sfaa011,sfaa018.sfaa_t.sfaa018,sfaa022.sfaa_t.sfaa022,sfaa058.sfaa_t.sfaa058,sfaa060.sfaa_t.sfaa060,sfaa068.sfaa_t.sfaa068,sfaa049.sfaa_t.sfaa049,sfaa050.sfaa_t.sfaa050,sfaa051.sfaa_t.sfaa051,sfaa055.sfaa_t.sfaa055,sfaa056.sfaa_t.sfaa056,sfba008.sfba_t.sfba008,sfba018.sfba_t.sfba018,sfba022.sfba_t.sfba022,sfba026.sfba_t.sfba026,sfba027.sfba_t.sfba027,l_sfaa004_desc.type_t.chr30,l_sfaa005_desc.type_t.chr30,l_sfaa018_desc.type_t.chr30,l_sfaa060_desc.type_t.chr30,l_sfaa068_desc.type_t.chr30,l_sfaa029_desc.type_t.chr50,l_sfaa030_desc.type_t.chr50" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
 
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="asfr302_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION asfr302_x01_ins_prep()
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
 
{<section id="asfr302_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION asfr302_x01_sel_prep()
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
   #160411-00027#12 20160420 mark by beckxie ---S
   #LET g_select = " SELECT sfaadocno,sfaadocdt, ",
   #               "        CASE WHEN a1.gzcbl004 IS NULL THEN a1.gzcbl004 ELSE trim(sfaastus)||'.'||trim(a1.gzcbl004) END, ",
   #               "        sfaa002,a2.ooag011,  ",
   #               "        CASE WHEN a3.gzcbl004 IS NULL THEN a3.gzcbl004 ELSE trim(sfaa003)||'.'||trim(a3.gzcbl004) END,    ",
   #               "        CASE WHEN a4.gzcbl004 IS NULL THEN a4.gzcbl004 ELSE trim(sfaa057)||'.'||trim(a4.gzcbl004) END,    ",
   #               "        sfaa006,sfaa007,sfaa008, ",
   #               "        sfaa009,a5.pmaal004,     ",
   #               "        sfaa021, ",
   #               "        sfaa010,a6.imaal003,a6.imaal004, ",
   #               "        sfaa012,sfaa013,a7.oocal003,     ",
   #               "        sfaa017,NULL,sfaa019,   ",
   #               "        sfaa020,NULL,sfaaent,   ",
   #               "        sfaasite,trim(sfbaseq)||'/'||trim(sfbaseq1), ",
   #               "        sfba002,a8.oocql004,  ",
   #               "        sfba003,a9.oocql004,  ",
   #               "        sfba004, ",
   #               "        sfba006,a10.imaal003,a10.imaal004,         ",
   #               "        sfba021,NULL, ",
   #               "        sfba007,trim(a11.gzcb002)||':'||trim(a11.gzcbl004),  ",
   #               "        sfba009,sfba010,sfba011,sfba012,sfba023,sfba024,sfba013, ",
   #               "        sfba014,a12.oocal003, ",
   #               "        sfba015,sfba016, ",
   #               "        sfba025,(sfba013-sfba016), ",
   #               "        sfba017,NULL,    ",
   #               "        sfba019,a13.inayl003,    ",
   #               "        sfba020,a14.inab003, ",
   #               "        sfba029,sfba030, ",
   #               "        sfba028,a15.imaf034,a16.imae092,NULL, ",
   #               "        sfbaseq,sfbaseq1,sfaa001,       ",
   #               "        sfaa003,sfaa004,sfaa057,sfaastus,sfaa005,sfaa011,sfaa016,sfaa018,sfaa022,sfaa025,sfaa058,sfaa060, ",
   #               "        sfaa061,sfaa068,sfaa014,sfaa015,sfaa026,sfaa028,sfaa029,sfaa030,sfaa031,sfaa032,sfaa033,sfaa034,  ",
   #               "        sfaa035,sfaa036,sfaa037,sfaa038,sfaa059,sfaa062,sfaa039,sfaa040,sfaa041,sfaa042,sfaa043,sfaa044,  ",
   #               "        sfaa045,sfaa046,sfaa047,sfaa048,sfaa049,sfaa050,sfaa051,sfaa055,sfaa056,sfaa065,sfaa069,sfaa070,  ",
   #               "        sfba001,a17.imaal003,a17.imaal004, ",
   #               "        sfba005,a18.imaal003,a18.imaal004, ",
   #               "        sfba008,sfba018,sfba022,sfba026, ",
   #               "        sfba027, ",
   #               "        a3.gzcbl004, ",
   #               "        a19.gzcbl004, ",
   #               "        a4.gzcbl004, ",
   #               "        NULL,  ",
   #               "        a1.gzcbl004,  ",
   #               "        a20.gzcbl004, ",
   #               "        NULL, ",
   #               "        NULL, ",
   #               "        a21.ooeal003 l_sfaa018_desc, ",
   #               "        NULL, ",
   #               "        NULL, ",
   #               "        NULL, ",
   #               "        a22.oocal003, ",
   #               "        a23.ooefl003 l_sfaa068_desc, ",
   #               "        a24.pjabl003,a25.pjbbl004,a26.pjbml004, ",
   #               "        a27.oocql004,a28.inayl003,a29.inab003, ",
   #               "        a30.gzcbl004 l_sfaa065_desc, ",
   #               "        a31.oocql004,NULL, ",
   #               "        a32.gzcbl004,a33.gzcbl004, ",
   #               "        CASE WHEN a2.ooag011 IS NULL THEN a2.ooag011 ELSE trim(sfaa002)||'.'||trim(a2.ooag011) END,  ",
   #               "        NULL, ",
   #               "        CASE WHEN a19.gzcbl004 IS NULL THEN a19.gzcbl004 ELSE trim(sfaa004)||'.'||trim(a19.gzcbl004) END,  ",
   #               "        NULL, ",
   #               "        NULL, ",
   #               "        CASE WHEN a20.gzcbl004 IS NULL THEN a20.gzcbl004 ELSE trim(sfaa005)||'.'||trim(a20.gzcbl004) END,  ",
   #               "        NULL, ",
   #               "        CASE WHEN a5.pmaal004 IS NULL THEN a5.pmaal004 ELSE trim(sfaa009)||'.'||trim(a5.pmaal004) END,  ",
   #               "        CASE WHEN a7.oocal003 IS NULL THEN a7.oocal003 ELSE trim(sfaa013)||'.'||trim(a7.oocal003) END,  ",
   #               "        NULL, ",
   #               "        NULL, ",
   #               "        CASE WHEN a21.ooeal003 IS NULL THEN a21.ooeal003 ELSE trim(sfaa018)||'.'||trim(a21.ooeal003) END,  ",
   #               "        NULL, ",
   #               "        NULL, ",
   #               "        NULL, ",
   #               "        CASE WHEN a22.oocal003 IS NULL THEN a22.oocal003 ELSE trim(sfaa060)||'.'||trim(a22.oocal003) END,  ",
   #               "        CASE WHEN a23.ooefl003 IS NULL THEN a23.ooefl003 ELSE trim(sfaa068)||'.'||trim(a23.ooefl003) END,  ",
   #               "        CASE WHEN a24.pjabl003 IS NULL THEN a24.pjabl003 ELSE trim(sfaa028)||'.'||trim(a24.pjabl003) END,  ",
   #               "        CASE WHEN a25.pjbbl004 IS NULL THEN a25.pjbbl004 ELSE trim(sfaa029)||'.'||trim(a25.pjbbl004) END,  ",
   #               "        CASE WHEN a26.pjbml004 IS NULL THEN a26.pjbml004 ELSE trim(sfaa030)||'.'||trim(a26.pjbml004) END,  ",
   #               "        CASE WHEN a27.oocql004 IS NULL THEN a27.oocql004 ELSE trim(sfaa031)||'.'||trim(a27.oocql004) END,  ",
   #               "        CASE WHEN a28.inayl003 IS NULL THEN a28.inayl003 ELSE trim(sfaa034)||'.'||trim(a28.inayl003) END,  ",
   #               "        CASE WHEN a29.inab003 IS NULL THEN a29.inab003 ELSE trim(sfaa035)||'.'||trim(a29.inab003) END,  ",
   #               "        CASE WHEN a30.gzcbl004 IS NULL THEN a30.gzcbl004 ELSE trim(sfaa065)||'.'||trim(a30.gzcbl004) END,  ",
   #               "        CASE WHEN a31.oocql004 IS NULL THEN a31.oocql004 ELSE trim(a31.imaa127)||'.'||trim(a31.oocql004) END,  ",
   #               "        CASE WHEN a8.oocql004 IS NULL THEN a8.oocql004 ELSE trim(sfba002)||'.'||trim(a8.oocql004) END,  ",
   #               "        CASE WHEN a9.oocql004 IS NULL THEN a9.oocql004 ELSE trim(sfba003)||'.'||trim(a9.oocql004) END,  ",
   #               "        CASE WHEN a32.gzcbl004 IS NULL THEN a32.gzcbl004 ELSE trim(sfba008)||'.'||trim(a32.gzcbl004) END,  ",
   #               "        CASE WHEN a13.inayl003 IS NULL THEN a13.inayl003 ELSE trim(sfba019)||'.'||trim(a13.inayl003) END,  ",                
   #               "        CASE WHEN a14.inab003 IS NULL THEN a14.inab003 ELSE trim(sfba020)||'.'||trim(a14.inab003) END,  ",        
   #               "        NULL, ",
   #               "        CASE WHEN a33.gzcbl004 IS NULL THEN a33.gzcbl004 ELSE trim(sfba026)||'.'||trim(a33.gzcbl004) END  "
   #160411-00027#12 20160420 mark by beckxie ---E
   #160411-00027#12 20160420 add by beckxie ---S
   LET g_select = " SELECT sfaadocno,sfaadocdt, 
                           sfaastus,  
                           (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '13' AND gzcbl002 = sfaastus AND gzcbl003 = '",g_dlang,"') ,
                           sfaa002,
                           (SELECT ooag011 FROM ooag_t WHERE ooagent = sfaaent AND ooag001 = sfaa002) ,   
                           sfaa003,
                           (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '4007' AND gzcbl002 = sfaa003 AND gzcbl003 = '",g_dlang,"') ,
                           sfaa057,     
                           (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '4010' AND gzcbl002 = sfaa057 AND gzcbl003 = '",g_dlang,"') ,
                           sfaa006,sfaa007,sfaa008,  
                           sfaa009,
                           (SELECT pmaal004 FROM pmaal_t WHERE pmaalent = sfaaent AND pmaal001 = sfaa009 AND pmaal002 = '",g_dlang,"') ,
                           sfaa021,  
                           sfaa010,a6.imaal003,a6.imaal004,  
                           sfaa012,sfaa013,
                           (SELECT oocal003 FROM oocal_t WHERE oocalent = sfaaent AND oocal001 = sfaa013 AND oocal002 = '",g_dlang,"') ,
                           sfaa017, 
                           (SELECT ooefl003 FROM ooefl_t WHERE ooeflent = sfaaent AND ooefl001 = sfaa017 AND ooefl002 = '"||g_dlang||"' ) ooefl003,  
                           sfaa019,    
                           sfaa020,NULL,    
                           sfaasite,  
						   sfbaseq,sfbaseq1,sfaa003,
                           sfba002,
                           (SELECT oocql004 FROM oocql_t WHERE oocqlent = sfbaent AND oocql001 = '215' AND oocql002 = sfba002 AND oocql003 = '",g_dlang,"') ,
                           sfba003,
                           (SELECT oocql004 FROM oocql_t WHERE oocqlent = sfbaent AND oocql001 = '221' AND oocql002 = sfba003 AND oocql003 = '",g_dlang,"') ,   
                           sfba004,  
                           sfba006,a10.imaal003,a10.imaal004,          
                           sfba021, 
                           (SELECT inaml004 FROM inaml_t WHERE inamlent=sfbaent AND inaml001=sfba006 AND inaml002=sfba021 AND inaml003='"||g_dlang||"') inaml004, 
                           trim(a11.gzcb002)||':'||trim(a11.gzcbl004),   
                           sfba009,sfba010,sfba011,sfba012,sfba023,sfba024,sfba013,  
                           sfba014,
                           (SELECT oocal003 FROM oocal_t WHERE oocalent = sfbaent AND oocal001 = sfba014 AND oocal002 = '",g_dlang,"') ,  
                           sfba015,sfba016,  
                           sfba025,(sfba013-sfba016),  
                           sfba017,NULL,   sfba019,sfba020,sfba029,sfba030,						   
                           sfba028,
                           (SELECT imaf034 FROM imaf_t WHERE imafent = sfbaent AND imafsite = sfbasite AND imaf001 = sfba006 ),
                           (SELECT imae092 FROM imae_t WHERE imaeent = sfbaent AND imaesite = sfbasite AND imae001 = sfba006 ),
                           NULL,          
                           sfaa004,sfaa057,sfaastus,sfaa005,sfaa011,sfaa018,sfaa022,sfaa058,sfaa060,  
                           sfaa068,   
                           sfaa049,sfaa050,sfaa051,sfaa055,sfaa056,
                           sfba008,sfba018,sfba022,sfba026,  
                           sfba027,  
                           (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '4008' AND gzcbl002 = sfaa004 AND gzcbl003 = '",g_dlang,"') ,  
                           (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '4009' AND gzcbl002 = sfaa005 AND gzcbl003 = '",g_dlang,"') ,
                           (SELECT ooeal003 FROM ooeal_t WHERE ooealent = sfaaent AND ooeal001 = sfaa018 AND ooeal002 = '",g_dlang,"') l_sfaa018_desc,  
                           (SELECT oocal003 FROM oocal_t WHERE oocalent = sfaaent AND oocal001 = sfaa060 AND oocal002 = '",g_dlang,"') ,  
                           (SELECt ooefl003 FROM ooefl_t WHERE ooeflent = sfaaent AND ooefl001 = sfaa068 AND ooefl002 = '",g_dlang,"') l_sfaa068_desc,
                           (SELECT pjbbl004 FROM pjbbl_t WHERE pjbblent = sfaaent AND pjbbl001 = sfaa028 AND pjbbl002 = sfaa029 AND pjbbl003 = '",g_dlang,"') ,        
                           (SELECT pjbml004 FROM pjbml_t WHERE pjbmlent = sfaaent AND pjbml001 = sfaa028 AND pjbml002 = sfaa030 AND pjbml003 = '",g_dlang,"') ,
                           sfaaent "
   #160411-00027#12 20160420 add by beckxie ---E
 
#   #end add-point
#   LET g_select = " SELECT sfaadocno,sfaadocdt,NULL,NULL,sfaa002,NULL,NULL,NULL,NULL,NULL,sfaa006,sfaa007, 
#       sfaa008,sfaa009,NULL,sfaa021,sfaa010,NULL,NULL,sfaa012,sfaa013,NULL,sfaa017,NULL,sfaa019,sfaa020, 
#       NULL,sfaasite,sfbaseq,sfbaseq1,sfaa003,sfba002,NULL,sfba003,NULL,sfba004,sfba006,NULL,NULL,sfba021, 
#       NULL,NULL,sfba009,sfba010,sfba011,sfba012,sfba023,sfba024,sfba013,sfba014,NULL,sfba015,sfba016, 
#       sfba025,NULL,sfba017,NULL,sfba019,sfba020,sfba029,sfba030,sfba028,NULL,NULL,NULL,sfaa004,sfaa057, 
#       sfaastus,sfaa005,sfaa011,sfaa018,sfaa022,sfaa058,sfaa060,sfaa068,sfaa049,sfaa050,sfaa051,sfaa055, 
#       sfaa056,sfba008,sfba018,sfba022,sfba026,sfba027,NULL,NULL,NULL,NULL,NULL,NULL,NULL,sfaaent"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   #160411-00027#12 20160420 mark by beckxie ---S
   #LET g_from = " FROM sfaa_t ",
   #             " LEFT OUTER JOIN gzcbl_t a1 ON a1.gzcbl001 = '13' AND a1.gzcbl002 = sfaastus AND a1.gzcbl003 = '",g_dlang,"'   ",
   #             " LEFT OUTER JOIN ooag_t a2 ON a2.ooagent = sfaaent AND a2.ooag001 = sfaa002 ", 
   #             " LEFT OUTER JOIN gzcbl_t a3 ON a3.gzcbl001 = '4007' AND a3.gzcbl002 = sfaa003 AND a3.gzcbl003 = '",g_dlang,"'  ",
   #             " LEFT OUTER JOIN gzcbl_t a4 ON a4.gzcbl001 = '4010' AND a4.gzcbl002 = sfaa057 AND a4.gzcbl003 = '",g_dlang,"'  ",
   #             " LEFT OUTER JOIN pmaal_t a5 ON a5.pmaalent = sfaaent AND a5.pmaal001 = sfaa009 AND a5.pmaal002 = '",g_dlang,"' ",
   #             " LEFT OUTER JOIN imaal_t a6 ON a6.imaalent = sfaaent AND a6.imaal001 = sfaa010 AND a6.imaal002 = '",g_dlang,"' ",
   #             " LEFT OUTER JOIN oocal_t a7 ON a7.oocalent = sfaaent AND a7.oocal001 = sfaa013 AND a7.oocal002 = '",g_dlang,"' ",        
   #             " LEFT OUTER JOIN gzcbl_t a19 ON a19.gzcbl001 = '4008' AND a19.gzcbl002 = sfaa004 AND a19.gzcbl003 = '",g_dlang,"'  ",
   #             " LEFT OUTER JOIN gzcbl_t a20 ON a20.gzcbl001 = '4009' AND a20.gzcbl002 = sfaa005 AND a20.gzcbl003 = '",g_dlang,"'  ",  
   #             " LEFT OUTER JOIN ooeal_t a21 ON a21.ooealent = sfaaent AND a21.ooeal001 = sfaa018 AND a21.ooeal002 = '",g_dlang,"' ",                
   #             " LEFT OUTER JOIN oocal_t a22 ON a22.oocalent = sfaaent AND a22.oocal001 = sfaa060 AND a22.oocal002 = '",g_dlang,"' ",      
   #             " LEFT OUTER JOIN ooefl_t a23 ON a23.ooeflent = sfaaent AND a23.ooefl001 = sfaa068 AND a23.ooefl002 = '",g_dlang,"' ",    
   #             " LEFT OUTER JOIN pjabl_t a24 ON a24.pjablent = sfaaent AND a24.pjabl001 = sfaa028 AND a24.pjabl002 = '",g_dlang,"' ",       
   #             " LEFT OUTER JOIN pjbbl_t a25 ON a25.pjbblent = sfaaent AND a25.pjbbl001 = sfaa028 AND a25.pjbbl002 = sfaa029 AND a25.pjbbl003 = '",g_dlang,"' ",        
   #             " LEFT OUTER JOIN pjbml_t a26 ON a26.pjbmlent = sfaaent AND a26.pjbml001 = sfaa028 AND a26.pjbml002 = sfaa030 AND a26.pjbml003 = '",g_dlang,"' ",
   #             " LEFT OUTER JOIN oocql_t a27 ON a27.oocqlent = sfaaent AND a27.oocql001 = '225'   AND a27.oocql002 = sfaa031 AND a27.oocql003 = '",g_dlang,"' ",                 
   #             " LEFT OUTER JOIN inayl_t a28 ON a28.inaylent = sfaaent AND a28.inayl001 = sfaa034 AND a28.inayl002 = '",g_dlang,"' ",               
   #             " LEFT OUTER JOIN inab_t a29 ON a29.inabent  = sfaaent AND a29.inabsite = sfaasite AND a29.inab001  = sfaa034 AND a29.inab002  = sfaa035 ",
   #             " LEFT OUTER JOIN gzcbl_t a30 ON a30.gzcbl001 = '4022' AND a30.gzcbl002 = sfaa065 AND a30.gzcbl003 = '",g_dlang,"'  ",
   #             " LEFT OUTER JOIN ( SELECT imaaent,imaa001,imaa127,oocql004  ",
   #             "                     FROM imaa_t   ",
   #             "                     LEFT OUTER JOIN oocql_t ON oocqlent = imaaent AND oocql001 = '2003' AND oocql002 = imaa127 AND oocql003 = '",g_dlang,"'  ",
   #             "                 ) a31 ON a31.imaaent = sfaaent AND imaa001 = sfaa010 ",                                          
   #             " ,sfba_t ",
   #             " LEFT OUTER JOIN oocql_t a8 ON a8.oocqlent = sfbaent AND a8.oocql001 = '215' AND a8.oocql002 = sfba002 AND a8.oocql003 = '",g_dlang,"' ",
   #             " LEFT OUTER JOIN oocql_t a9 ON a9.oocqlent = sfbaent AND a9.oocql001 = '221' AND a9.oocql002 = sfba003 AND a9.oocql003 = '",g_dlang,"' ",
   #             " LEFT OUTER JOIN imaal_t a10 ON a10.imaalent = sfbaent AND a10.imaal001 = sfba006 AND a10.imaal002 = '",g_dlang,"' ",
   #             " LEFT OUTER JOIN (SELECT gzcb001,gzcb002,gzcbl004 ", 
   #             "                    FROM gzcb_t  ",
   #             "                    LEFT JOIN gzcbl_t ON gzcb002 = gzcbl002 AND gzcb001 = gzcbl001 AND gzcb001 = '1101' AND gzcbl003 = '",g_dlang,"' ",                                                                                                                                                                      
   #             "                  ) a11 ON a11.gzcb001 = '1101' AND a11.gzcb002 = sfba008 ",
   #             " LEFT OUTER JOIN oocal_t a12 ON a12.oocalent = sfbaent AND a12.oocal001 = sfba014 AND a12.oocal002 = '",g_dlang,"' ",
   #             " LEFT OUTER JOIN inayl_t a13 ON a13.inaylent = sfbaent AND a13.inayl001 = sfba019 AND a13.inayl002 = '",g_dlang,"' ", 
   #             " LEFT OUTER JOIN inab_t a14 ON a14.inabent = sfbaent AND a14.inabsite = sfbasite AND a14.inab001  = sfba019 AND a14.inab002  = sfba020 ",
   #             " LEFT OUTER JOIN imaf_t a15 ON a15.imafent = sfbaent AND a15.imafsite = sfbasite AND a15.imaf001 = sfba006 ",
   #             " LEFT OUTER JOIN imae_t a16 ON a16.imaeent = sfbaent AND a16.imaesite = sfbasite AND a16.imae001 = sfba006 ",
   #             " LEFT OUTER JOIN imaal_t a17 ON a17.imaalent = sfbaent AND a17.imaal001 = sfba001 AND a17.imaal002 = '",g_dlang,"' ",
   #             " LEFT OUTER JOIN imaal_t a18 ON a18.imaalent = sfbaent AND a18.imaal001 = sfba005 AND a18.imaal002 = '",g_dlang,"' ",
   #             " LEFT OUTER JOIN gzcbl_t a32 ON a32.gzcbl001 = '1101' AND a32.gzcbl002 = sfba008 AND a32.gzcbl003 = '",g_dlang,"'  ",          
   #             " LEFT OUTER JOIN gzcbl_t a33 ON a33.gzcbl001 = '4012' AND a33.gzcbl002 = sfba026 AND a33.gzcbl003 = '",g_dlang,"'  "                               
   #160411-00027#12 20160420 mark by beckxie ---E
   #160411-00027#12 20160420 add by beckxie ---S
   LET g_from = " FROM sfaa_t ",
                " LEFT OUTER JOIN imaal_t a6 ON a6.imaalent = sfaaent AND a6.imaal001 = sfaa010 AND a6.imaal002 = '",g_dlang,"' ",
                " ,sfba_t ",
                " LEFT OUTER JOIN imaal_t a10 ON a10.imaalent = sfbaent AND a10.imaal001 = sfba006 AND a10.imaal002 = '",g_dlang,"' ",
                " LEFT OUTER JOIN (SELECT gzcb001,gzcb002,gzcbl004 ", 
                "                    FROM gzcb_t  ",
                "                    LEFT JOIN gzcbl_t ON gzcb002 = gzcbl002 AND gzcb001 = gzcbl001 AND gzcb001 = '1101' AND gzcbl003 = '",g_dlang,"' ",                                                                                                                                                                      
                "                  ) a11 ON a11.gzcb001 = '1101' AND a11.gzcb002 = sfba008 "
   #160411-00027#12 20160420 add by beckxie ---E
#   #end add-point
#    LET g_from = " FROM sfaa_t,sfba_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
 
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   LET g_where = " WHERE sfaaent = sfbaent AND sfaadocno = sfbadocno AND " ,tm.wc CLIPPED
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
 
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("sfaa_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = g_sql," ORDER BY sfaadocno,sfbaseq,sfbaseq1"
   #DISPLAY "g_sql:" , g_sql
   #end add-point
   PREPARE asfr302_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE asfr302_x01_curs CURSOR FOR asfr302_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="asfr302_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION asfr302_x01_ins_data()
DEFINE sr RECORD 
   sfaadocno LIKE sfaa_t.sfaadocno, 
   sfaadocdt LIKE sfaa_t.sfaadocdt, 
   l_sfaastus LIKE type_t.chr30, 
   l_sfaastus_ref LIKE type_t.chr30, 
   sfaa002 LIKE sfaa_t.sfaa002, 
   sfaa002_desc LIKE type_t.chr30, 
   l_sfaa003 LIKE type_t.chr30, 
   l_sfaa003_ref LIKE type_t.chr30, 
   l_sfaa057 LIKE type_t.chr30, 
   l_sfaa057_ref LIKE type_t.chr30, 
   sfaa006 LIKE sfaa_t.sfaa006, 
   sfaa007 LIKE sfaa_t.sfaa007, 
   sfaa008 LIKE sfaa_t.sfaa008, 
   sfaa009 LIKE sfaa_t.sfaa009, 
   sfaa009_desc LIKE type_t.chr30, 
   sfaa021 LIKE sfaa_t.sfaa021, 
   sfaa010 LIKE sfaa_t.sfaa010, 
   sfaa010_desc LIKE type_t.chr80, 
   sfaa010_desc_1 LIKE type_t.chr80, 
   sfaa012 LIKE sfaa_t.sfaa012, 
   sfaa013 LIKE sfaa_t.sfaa013, 
   sfaa013_desc LIKE type_t.chr30, 
   sfaa017 LIKE sfaa_t.sfaa017, 
   sfaa017_desc LIKE type_t.chr80, 
   sfaa019 LIKE sfaa_t.sfaa019, 
   sfaa020 LIKE sfaa_t.sfaa020, 
   ooff013 LIKE type_t.chr500, 
   sfaasite LIKE sfaa_t.sfaasite, 
   sfbaseq LIKE sfba_t.sfbaseq, 
   sfbaseq1 LIKE sfba_t.sfbaseq1, 
   sfaa003 LIKE sfaa_t.sfaa003, 
   sfba002 LIKE sfba_t.sfba002, 
   sfba002_desc LIKE type_t.chr30, 
   sfba003 LIKE sfba_t.sfba003, 
   sfba003_desc LIKE type_t.chr30, 
   sfba004 LIKE sfba_t.sfba004, 
   sfba006 LIKE sfba_t.sfba006, 
   sfba006_desc LIKE type_t.chr80, 
   sfba006_desc_1 LIKE type_t.chr80, 
   sfba021 LIKE sfba_t.sfba021, 
   sfba021_desc LIKE type_t.chr80, 
   l_sfba008 LIKE type_t.chr30, 
   sfba009 LIKE sfba_t.sfba009, 
   sfba010 LIKE sfba_t.sfba010, 
   sfba011 LIKE sfba_t.sfba011, 
   sfba012 LIKE sfba_t.sfba012, 
   sfba023 LIKE sfba_t.sfba023, 
   sfba024 LIKE sfba_t.sfba024, 
   sfba013 LIKE sfba_t.sfba013, 
   sfba014 LIKE sfba_t.sfba014, 
   sfba014_desc LIKE type_t.chr30, 
   sfba015 LIKE sfba_t.sfba015, 
   sfba016 LIKE sfba_t.sfba016, 
   sfba025 LIKE sfba_t.sfba025, 
   l_qty1 LIKE type_t.num20_6, 
   sfba017 LIKE sfba_t.sfba017, 
   l_qty2 LIKE type_t.num20_6, 
   sfba019 LIKE sfba_t.sfba019, 
   sfba020 LIKE sfba_t.sfba020, 
   sfba029 LIKE sfba_t.sfba029, 
   sfba030 LIKE sfba_t.sfba030, 
   sfba028 LIKE sfba_t.sfba028, 
   l_imaf034 LIKE type_t.chr1, 
   l_imae092 LIKE type_t.chr1, 
   ooff013_sfba LIKE type_t.chr500, 
   sfaa004 LIKE sfaa_t.sfaa004, 
   sfaa057 LIKE sfaa_t.sfaa057, 
   sfaastus LIKE sfaa_t.sfaastus, 
   sfaa005 LIKE sfaa_t.sfaa005, 
   sfaa011 LIKE sfaa_t.sfaa011, 
   sfaa018 LIKE sfaa_t.sfaa018, 
   sfaa022 LIKE sfaa_t.sfaa022, 
   sfaa058 LIKE sfaa_t.sfaa058, 
   sfaa060 LIKE sfaa_t.sfaa060, 
   sfaa068 LIKE sfaa_t.sfaa068, 
   sfaa049 LIKE sfaa_t.sfaa049, 
   sfaa050 LIKE sfaa_t.sfaa050, 
   sfaa051 LIKE sfaa_t.sfaa051, 
   sfaa055 LIKE sfaa_t.sfaa055, 
   sfaa056 LIKE sfaa_t.sfaa056, 
   sfba008 LIKE sfba_t.sfba008, 
   sfba018 LIKE sfba_t.sfba018, 
   sfba022 LIKE sfba_t.sfba022, 
   sfba026 LIKE sfba_t.sfba026, 
   sfba027 LIKE sfba_t.sfba027, 
   l_sfaa004_desc LIKE type_t.chr30, 
   l_sfaa005_desc LIKE type_t.chr30, 
   l_sfaa018_desc LIKE type_t.chr30, 
   l_sfaa060_desc LIKE type_t.chr30, 
   l_sfaa068_desc LIKE type_t.chr30, 
   l_sfaa029_desc LIKE type_t.chr50, 
   l_sfaa030_desc LIKE type_t.chr50, 
   sfaaent LIKE sfaa_t.sfaaent
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_success           LIKE type_t.num5
DEFINE l_sql               STRING
#160411-00027#12 20160420 mark by beckxie ---S
#DEFINE l_gzcb002           LIKE gzcb_t.gzcb002
#DEFINE l_gzcbl004          LIKE gzcbl_t.gzcbl004
#DEFINE l_imaa127 LIKE imaa_t.imaa127   #系列       20150811 by dorislai add  (S)
#DEFINE l_imae032 LIKE imae_t.imae032   #製程料號   
#DEFINE l_sfaa007 LIKE sfaa_t.sfaa007   #來源項次
#DEFINE l_sfaa008 LIKE sfaa_t.sfaa008   #來源項序
#DEFINE l_sfaa063 LIKE sfaa_t.sfaa063   #來源分批序  20150811 by dorislai add  (E)
#160411-00027#12 20160420 mark by beckxie ---E
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH asfr302_x01_curs INTO sr.*                               
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
       #SELECT ooag011 INTO sr.sfaa002_desc FROM ooag_t WHERE ooagent=sr.sfaaent AND ooag001=sr.sfaa002
       
       #SELECT pmaal004 INTO sr.sfaa009_desc FROM pmaal_t WHERE pmaalent=sr.sfaaent AND pmaal001=sr.sfaa009 AND pmaal002=g_lang
       
       #SELECT imaal003,imaal004 INTO sr.sfaa010_desc,sr.sfaa010_desc_1 FROM imaal_t 
       # WHERE imaalent = sr.sfaaent AND imaal001 = sr.sfaa010 AND imaal002 = g_lang
        
       #SELECT oocal003 INTO sr.sfaa013_desc FROM oocal_t WHERE oocalent=sr.sfaaent AND oocal001=sr.sfaa013 AND oocal002=g_lang
       #dorislai-20150812-modify----(S)
       
#       SELECT gzcb002, gzcbl004 INTO l_gzcb002,l_gzcbl004
#         FROM gzcb_t LEFT JOIN gzcbl_t ON gzcb002 = gzcbl002
#                                      AND gzcb001 = gzcbl001
#                                      AND gzcb001 = '13'
#                                      AND gzcbl003 = g_dlang
#        WHERE gzcb001 = '13' AND gzcb002 = (SELECT sfaastus FROM sfaa_t
#                                             WHERE sfaaent = g_enterprise AND sfaadocno = sr.sfaadocno)
#       LET sr.l_sfaastus = l_gzcb002,":",l_gzcbl004
#       
#       SELECT gzcb002, gzcbl004 INTO l_gzcb002,l_gzcbl004
#         FROM gzcb_t LEFT JOIN gzcbl_t ON gzcb002 = gzcbl002
#                                      AND gzcb001 = gzcbl001
#                                      AND gzcb001 = '4007'
#                                      AND gzcbl003 = g_dlang
#        WHERE gzcb001 = '4007' AND gzcb002 = (SELECT sfaa003 FROM sfaa_t
#                                             WHERE sfaaent = g_enterprise AND sfaadocno = sr.sfaadocno)
#       LET sr.l_sfaa003 = l_gzcb002,":",l_gzcbl004
#       
#       SELECT gzcb002, gzcbl004 INTO l_gzcb002,l_gzcbl004
#         FROM gzcb_t LEFT JOIN gzcbl_t ON gzcb002 = gzcbl002
#                                      AND gzcb001 = gzcbl001
#                                      AND gzcb001 = '4010'
#                                      AND gzcbl003 = g_dlang
#        WHERE gzcb001 = '4010' AND gzcb002 = (SELECT sfaa057 FROM sfaa_t
#                                             WHERE sfaaent = g_enterprise AND sfaadocno = sr.sfaadocno)
#       LET sr.l_sfaa057 = l_gzcb002,":",l_gzcbl004
#       
#       IF sr.l_sfaa057 = '2' THEN
#          INITIALIZE g_chkparam.* TO NULL
#          LET g_chkparam.arg1 = sr.sfaa017
#          CALL cl_ref_val("v_pmaal004")
#          LET sr.sfaa017_desc = g_chkparam.return1
#       ELSE
#          CALL s_desc_get_department_desc(sr.sfaa017) RETURNING sr.sfaa017_desc
#       END IF
       
       ##狀態碼
       #LET sr.l_sfaastus_ref = ''
       #LET sr.l_sfaastus = ''
       #CALL s_desc_gzcbl004_desc('13',sr.sfaastus) RETURNING sr.l_sfaastus_ref
       #IF NOT cl_null(sr.l_sfaastus_ref) THEN
       #   LET sr.l_sfaastus = sr.sfaastus,'.',sr.l_sfaastus_ref
       #END IF
       ##工單類型
       #LET sr.l_sfaa003_ref = ''
       #LET sr.l_sfaa003 = ''
       #CALL s_desc_gzcbl004_desc('4007',sr.sfaa003) RETURNING sr.l_sfaa003_ref
       #IF NOT cl_null(sr.l_sfaa003_ref) THEN
       #   LET sr.l_sfaa003 = sr.sfaa003,'.',sr.l_sfaa003_ref
       #END IF
       ##委外類型
       #LET sr.l_sfaa057_ref = ''
       #LET sr.l_sfaa057 = ''
       #CALL s_desc_gzcbl004_desc('4010',sr.sfaa057) RETURNING sr.l_sfaa057_ref
       #IF NOT cl_null(sr.l_sfaa057_ref) THEN
       #   LET sr.l_sfaa057 = sr.sfaa057,'.',sr.l_sfaa057_ref
       #END IF
       #160411-00027#12 20160420 mark by beckxie ---S
       ##部門廠商
       #IF sr.sfaa057 = '2' THEN
       #   INITIALIZE g_chkparam.* TO NULL
       #   LET g_chkparam.arg1 = sr.sfaa017
       #   CALL cl_ref_val("v_pmaal004")
       #   LET sr.sfaa017_desc = g_chkparam.return1
       #ELSE
       #   CALL s_desc_get_department_desc(sr.sfaa017) RETURNING sr.sfaa017_desc
       #END IF
       ##dorislai-20150812-modify----(E)
       #160411-00027#12 20160420 mark by beckxie ---E
       CALL s_aooi360_sel('6',sr.sfaadocno,'','','','','','','','','','2')
            RETURNING l_success,sr.ooff013
       
       #LET sr.l_sfbaseq = sr.sfbaseq,"/",sr.sfbaseq1
       
       #SELECT oocql004 INTO sr.sfba002_desc FROM oocql_t
       # WHERE oocqlent = sr.sfaaent AND oocql001 = '215' AND oocql002 = sr.sfba002 AND oocql003 = g_lang
       
       #SELECT oocql004 INTO sr.sfba003_desc FROM oocql_t
       # WHERE oocqlent = sr.sfaaent AND oocql001 = '221' AND oocql002 = sr.sfba003 AND oocql003 = g_lang
        
       #SELECT imaal003,imaal004 INTO sr.sfba006_desc,sr.sfba006_desc_1 FROM imaal_t 
       # WHERE imaalent = sr.sfaaent AND imaal001 = sr.sfba006 AND imaal002 = g_lang
       #160411-00027#12 20160420 mark by beckxie ---S
       #CALL s_feature_description(sr.sfba006,sr.sfba021)
       #     RETURNING l_success,sr.sfba021_desc
       #IF NOT l_success THEN
       #   LET sr.sfba021_desc = ''
       #END IF
       #160411-00027#12 20160420 mark by beckxie ---E
       #SELECT gzcb002, gzcbl004 INTO l_gzcb002,l_gzcbl004
       #  FROM gzcb_t LEFT JOIN gzcbl_t ON gzcb002 = gzcbl002
       #                               AND gzcb001 = gzcbl001
       #                               AND gzcb001 = '1101'
       #                               AND gzcbl003 = g_dlang
       # WHERE gzcb001 = '1101' AND gzcb002 = (SELECT sfba008 FROM sfba_t
       #                                        WHERE sfbaent = sr.sfaaent AND sfbadocno = sr.sfaadocno
       #                                          AND sfbaseq = sr.sfbaseq AND sfbaseq1 = sr.sfbaseq1)
       #LET sr.l_sfba008 = l_gzcb002,":",l_gzcbl004
       
       #SELECT oocal003 INTO sr.sfba014_desc FROM oocal_t WHERE oocalent=sr.sfaaent AND oocal001=sr.sfba014 AND oocal002=g_lang
       
       #LET sr.l_qty1 = sr.sfba013 - sr.sfba016
       
       ##可用库存量
       LET l_sql = "SELECT SUM(inag008) FROM inag_t WHERE inagent=",sr.sfaaent," AND inagsite='",sr.sfaasite,"'",
                   "   AND inag001='",sr.sfba006,"' AND inag002='",sr.sfba021,"' AND inag007='",sr.sfba014,"'",
                   "   AND inag010='Y'"
       
       IF sr.sfba030 IS NOT NULL THEN
          LET l_sql = l_sql," AND inag003='",sr.sfba030,"'"
       END IF
       IF sr.sfba019 IS NOT NULL THEN
          LET l_sql = l_sql," AND inag004='",sr.sfba019,"'"
       END IF
       IF sr.sfba020 IS NOT NULL THEN
          LET l_sql = l_sql," AND inag005='",sr.sfba020,"'"
       END IF
       IF sr.sfba029 IS NOT NULL THEN
          LET l_sql = l_sql," AND inag006='",sr.sfba029,"'"
       END IF
       PREPARE asfr302_x01_ins_pre FROM l_sql
       EXECUTE asfr302_x01_ins_pre INTO sr.l_qty2
       IF cl_null(sr.l_qty2) THEN
          LET sr.l_qty2 = 0 
       END IF
       
       #LET sr.sfba019_desc = s_desc_get_stock_desc(sr.sfaasite,sr.sfba019)
       
       #LET sr.sfba020_desc = s_desc_get_locator_desc(sr.sfaasite,sr.sfba019,sr.sfba020)
      
       #SELECT imaf034 INTO sr.l_imaf034 FROM imaf_t 
       # WHERE imafent = sr.sfaaent AND imafsite = sr.sfaasite AND imaf001 = sr.sfba006
        
       #SELECT imae092 INTO sr.l_imae092 FROM imae_t 
       # WHERE imaeent = sr.sfaaent AND imaesite = sr.sfaasite AND imae001 = sr.sfba006
        
       IF NOT cl_null(sr.sfaadocno) AND NOT cl_null(sr.sfbaseq) AND NOT cl_null(sr.sfbaseq1) THEN
          CALL s_aooi360_sel('7',sr.sfaadocno,sr.sfbaseq,sr.sfbaseq1,'','','','','','','','2')
               RETURNING l_success,sr.ooff013_sfba  
       END IF
       
       #dorislai-20150812-add----(S)
       ##單頭
       ##生管人員全名 l_sfaa002desc	
       #LET sr.l_sfaa002desc = ''
       #IF NOT cl_null(sr.sfaa002_desc) THEN
       #   LET sr.l_sfaa002desc = sr.sfaa002,'.',sr.sfaa002_desc
       #END IF

       #發科制度全名 l_sfaa004desc	
       #LET sr.l_sfaa004_desc = ''
       #LET sr.l_sfaa004desc = ''
       #CALL s_desc_gzcbl004_desc('4008',sr.sfaa004) RETURNING sr.l_sfaa004_desc
       #IF NOT cl_null(sr.l_sfaa004_desc) THEN
       #   LET sr.l_sfaa004desc = sr.sfaa004,'.',sr.l_sfaa004_desc
       #END IF
       #160411-00027#12 20160420 mark by beckxie ---S
       ##單號全名 l_sfaadocnodesc	
       #LET sr.l_sfaadocno_desc = ''
       #LET sr.l_sfaadocnodesc = ''
       #CALL s_aooi200_get_slip_desc(sr.sfaadocno) RETURNING sr.l_sfaadocno_desc
       #IF NOT cl_null(sr.l_sfaadocno_desc) THEN
       #   LET sr.l_sfaadocnodesc = sr.sfaadocno,'.',sr.l_sfaadocno_desc
       #END IF
       #160411-00027#12 20160420 mark by beckxie ---E
       
       #====基本資料====
       #工單來源全名 l_sfaa005desc	
       #LET sr.l_sfaa005_desc = ''
       #LET sr.l_sfaa005desc = ''
       #CALL s_desc_gzcbl004_desc('4009',sr.sfaa005) RETURNING sr.l_sfaa005_desc
       #IF NOT cl_null(sr.l_sfaa005_desc) THEN
       #   LET sr.l_sfaa005desc = sr.sfaa005,'.',sr.l_sfaa005_desc
       #END IF
       #160411-00027#12 20160420 mark by beckxie ---S
       ##來源單號全名 l_sfaa006desc	
       #LET sr.l_sfaa006_desc = ''	
       #LET sr.l_sfaa006desc = ''
       #CALL s_aooi200_get_slip_desc(sr.sfaa006) RETURNING sr.l_sfaa006_desc
       #IF NOT cl_null(sr.l_sfaa006_desc) THEN
       #   LET sr.l_sfaa006desc = sr.sfaa006,'.',sr.l_sfaa006_desc
       #END IF
       ##來源項次序 l_sfaa007
       #LET sr.l_sfaa007 = ''
       #SELECT sfaa007,sfaa008,sfaa063 INTO l_sfaa007,l_sfaa008,l_sfaa063 FROM sfaa_t
       # WHERE sfaaent = g_enterprise AND sfaasite = g_site AND sfaadocno = sr.sfaadocno
       ##---項次
       #IF NOT cl_null(l_sfaa007) THEN
       #   LET sr.l_sfaa007 = l_sfaa007
       #END IF
       ##----項序
       #IF NOT cl_null(l_sfaa008) THEN
       #   LET sr.l_sfaa007 = sr.l_sfaa007 CLIPPED ||'-'||l_sfaa008 
       #END IF
       ##----分批序
       #IF NOT cl_null(l_sfaa063) THEN
       #   LET sr.l_sfaa007 = sr.l_sfaa007 CLIPPED ||'-'||l_sfaa063
       #END IF
       #160411-00027#12 20160420 mark by beckxie ---E
       ##參考客戶全名 l_sfaa009desc	
       #LET sr.l_sfaa009desc = ''
       #IF NOT cl_null(sr.sfaa009_desc) THEN
       #   LET sr.l_sfaa009desc = sr.sfaa009,'.',sr.sfaa009_desc
       #END IF
       ##生產單位全名 l_sfaa013desc	
       #LET sr.l_sfaa013desc = ''
       #IF NOT cl_null(sr.sfaa013_desc) THEN
       #   LET sr.l_sfaa013desc = sr.sfaa013,'.',sr.sfaa013_desc
       #END IF
       #製成編號全名 l_sfaa016desc	
       #160411-00027#12 20160420 mark by beckxie ---S
       #LET sr.l_sfaa016_desc = ''
       #LET sr.l_sfaa016desc = ''
       #IF NOT cl_null(sr.sfaa016) THEN
       #   #抓製成料號
       #   SELECT imae032 INTO l_imae032 FROM imae_t 
       #    WHERE imaeent = g_enterprise AND imaesite = g_site AND imae001 = sr.sfaa010
       #   IF cl_null(l_imae032) THEN
       #      LET l_imae032 = sr.sfaa010
       #   END IF
       #   #抓製成編號
       #   IF NOT cl_null(l_imae032) THEN
       #      SELECT ecba003 INTO sr.l_sfaa016_desc FROM ecba_t 
       #       WHERE ecbaent = g_enterprise AND ecba001 = l_imae032 AND ecba002 = sr.sfaa016
       #   END IF
       #END IF
       #
       #IF NOT cl_null(sr.l_sfaa016_desc) THEN
       #   LET sr.l_sfaa016desc = sr.sfaa016,'.',sr.l_sfaa016_desc
       #END IF
       ##部門廠商全名 l_sfaa017desc	
       #LET sr.l_sfaa017desc = ''
       #IF NOT cl_null(sr.sfaa017_desc) THEN
       #   LET sr.l_sfaa017desc = sr.sfaa017,'.',sr.sfaa017_desc
       #END IF
       #160411-00027#12 20160420 mark by beckxie ---E
       ##協作據點全名 l_sfaa018desc	
       #LET sr.l_sfaa018_desc = ''
       #LET sr.l_sfaa018desc = ''
       #SELECT ooeal003 INTO sr.l_sfaa018_desc FROM ooeal_t
       # WHERE ooealent = g_enterprise AND ooeal001 = sr.sfaa018 AND ooeal002 = g_dlang
       #IF NOT cl_null(sr.l_sfaa018_desc) THEN
       #   LET sr.l_sfaa018desc = sr.sfaa018,'.',sr.l_sfaa018_desc
       #END IF
       #160411-00027#12 20160420 mark by beckxie ---S
       ##母工單單號全名 l_sfaa021desc	
       #LET sr.l_sfaa021_desc = ''
       #LET sr.l_sfaa021desc = ''
       #CALL s_aooi200_get_slip_desc(sr.sfaa021) RETURNING sr.l_sfaa021_desc
       #IF NOT cl_null(sr.l_sfaa021_desc) THEN
       #   LET sr.l_sfaa021desc = sr.sfaa021,'.',sr.l_sfaa021_desc
       #END IF
       ##參考原始單號全名 l_sfaa022desc	
       #LET sr.l_sfaa022_desc = ''
       #LET sr.l_sfaa022desc = ''
       #CALL s_aooi200_get_slip_desc(sr.sfaa022) RETURNING sr.l_sfaa022_desc
       #IF NOT cl_null(sr.l_sfaa022_desc) THEN
       #   LET sr.l_sfaa022desc = sr.sfaa022,'.',sr.l_sfaa022_desc
       #END IF
       ##前工單單號全名 l_sfaa025desc	
       #LET sr.l_sfaa025_desc = ''
       #LET sr.l_sfaa025desc = ''
       #CALL s_aooi200_get_slip_desc(sr.sfaa025) RETURNING sr.l_sfaa025_desc
       #IF NOT cl_null(sr.l_sfaa025_desc) THEN
       #   LET sr.l_sfaa025desc = sr.sfaa025,'.',sr.l_sfaa025_desc
       #END IF
       #160411-00027#12 20160420 mark by beckxie ---E
       ##參考單位全名 l_sfaa060desc	
       #LET sr.l_sfaa060_desc = ''
       #LET sr.l_sfaa060desc = ''
       #SELECT oocal003 INTO sr.l_sfaa060_desc FROM oocal_t 
       # WHERE oocalent = g_enterprise AND oocal001 = sr.sfaa060 AND oocal002 = g_dlang
       #IF NOT cl_null(sr.l_sfaa060_desc) THEN
       #   LET sr.l_sfaa060desc = sr.sfaa060,'.',sr.l_sfaa060_desc
       #END IF  
       ##成本中心全名 l_sfaa068desc	
       #LET sr.l_sfaa068_desc = ''
       #LET sr.l_sfaa068desc = ''
       #SELECT ooefl003 INTO sr.l_sfaa068_desc FROM ooefl_t
       # WHERE ooeflent = g_enterprise AND ooefl001 = sr.sfaa068 AND ooefl002 = g_dlang
       #IF NOT cl_null(sr.l_sfaa068_desc) THEN
       #   LET sr.l_sfaa068desc = sr.sfaa068,'.',sr.l_sfaa068_desc
       #END IF
       
       ##====工單資料====
       ##專案代號全名 l_sfaa028desc
       #LET sr.l_sfaa028_desc = ''
       #LET sr.l_sfaa028desc = ''
       #CALL s_desc_get_project_desc(sr.sfaa028) RETURNING sr.l_sfaa028_desc
       #IF NOT cl_null(sr.l_sfaa028_desc) THEN
       #   LET sr.l_sfaa028desc = sr.sfaa028,'.',sr.l_sfaa028_desc
       #END IF
       ##WBS全名 l_sfaa029desc
       #LET sr.l_sfaa029_desc = ''
       #LET sr.l_sfaa029desc = ''
       #CALL s_desc_get_wbs_desc(sr.sfaa028,sr.sfaa029) RETURNING sr.l_sfaa029_desc
       #IF NOT cl_null(sr.l_sfaa029_desc) THEN
       #   LET sr.l_sfaa029desc = sr.sfaa029,'.',sr.l_sfaa029_desc
       #END IF
       ##活動全名 l_sfaa030desc
       #LET sr.l_sfaa030_desc = ''
       #LET sr.l_sfaa030desc = ''
       #CALL s_desc_get_activity_desc(sr.sfaa028,sr.sfaa030) RETURNING sr.l_sfaa030_desc
       #IF NOT cl_null(sr.l_sfaa030_desc) THEN
       #   LET sr.l_sfaa030desc = sr.sfaa030,'.',sr.l_sfaa030_desc
       #END IF
       ##理由碼全名 l_sfaa031desc
       #LET sr.l_sfaa031_desc = ''
       #LET sr.l_sfaa031desc = ''
       #CALL s_desc_get_acc_desc('225',sr.sfaa031) RETURNING sr.l_sfaa031_desc
       #IF NOT cl_null(sr.l_sfaa031_desc) THEN
       #   LET sr.l_sfaa031desc = sr.sfaa031,'.',sr.l_sfaa031_desc
       #END IF
       ##預計入庫庫位全名 l_sfaa034desc
       #LET sr.l_sfaa034_desc = ''
       #LET sr.l_sfaa034desc = ''
       #CALL s_desc_get_stock_desc(g_site,sr.sfaa034) RETURNING sr.l_sfaa034_desc
       #IF NOT cl_null(sr.l_sfaa034_desc) THEN
       #   LET sr.l_sfaa034desc = sr.sfaa034,'.',sr.l_sfaa034_desc
       #END IF
       ##預計入庫儲位全名 l_sfaa035desc
       #LET sr.l_sfaa035_desc = ''
       #LET sr.l_sfaa035desc = ''
       #CALL s_desc_get_locator_desc(g_site,sr.sfaa034,sr.sfaa035) RETURNING sr.l_sfaa035_desc
       #IF NOT cl_null(sr.l_sfaa035_desc) THEN
       #   LET sr.l_sfaa035desc = sr.sfaa035,'.',sr.l_sfaa035_desc
       #END IF
       
       ##====相關資訊====
       ##生管結案狀態全名 l_sfaa065desc
       #LET sr.l_sfaa065_desc = ''
       #LET sr.l_sfaa065desc = ''
       #CALL s_desc_gzcbl004_desc('4022',sr.sfaa065) RETURNING sr.l_sfaa065_desc
       #IF NOT cl_null(sr.l_sfaa065_desc) THEN
       #   LET sr.l_sfaa065desc = sr.sfaa065,'.',sr.l_sfaa065_desc
       #END IF
       #系列全名 l_imaa127desc
       #LET sr.l_imaa127_desc = ''
       #LET sr.l_imaa127desc = ''
       ##用料號抓取系列
       #SELECT imaa127 INTO l_imaa127 FROM imaa_t
       # WHERE imaa001 = sr.sfaa010
       #   AND imaaent = g_enterprise
       #  #抓取系列說明
       #CALL s_desc_get_acc_desc('2003',l_imaa127)  RETURNING sr.l_imaa127_desc 
       #IF NOT cl_null(sr.l_imaa127_desc) THEN
       #   LET sr.l_imaa127desc = l_imaa127,'.',sr.l_imaa127_desc
       #END IF
       
       ##====備料明細====
       ##部位全名	l_sfba002desc
       #LET sr.l_sfba002desc = ''
       #IF NOT cl_null(sr.sfba002_desc) THEN
       #   LET sr.l_sfba002desc = sr.sfba002,'.',sr.sfba002_desc
       #END IF
       ##作業編號全名	l_sfba003desc
       #LET sr.l_sfba003desc = ''
       #IF NOT cl_null(sr.sfba003_desc) THEN
       #   LET sr.l_sfba003desc = sr.sfba003,'.',sr.sfba003_desc
       #END IF
       ##必要特性全名	l_sfba008desc
       #LET sr.l_sfba008_desc = ''
       #LET sr.l_sfba008desc = ''
       #CALL s_desc_gzcbl004_desc('1101',sr.sfba008) RETURNING sr.l_sfba008_desc
       #IF NOT cl_null(sr.l_sfba008_desc) THEN
       #   LET sr.l_sfba008desc = sr.sfba008,'.',sr.l_sfba008_desc
       #END IF
       #指定發料倉庫全名	l_sfba019desc
       #LET sr.l_sfba019desc = ''
       #IF NOT cl_null(sr.sfba019_desc) THEN
       #   LET sr.l_sfba019desc = sr.sfba019,'.',sr.sfba019_desc
       #END IF
       ##儲位名稱全名	l_sfba020desc
       #LET sr.l_sfba020desc = ''
       #IF NOT cl_null(sr.sfba020_desc) THEN
       #   LET sr.l_sfba020desc = sr.sfba020,'.',sr.sfba020_desc
       #END IF
       #160411-00027#12 20160420 mark by beckxie ---S
       ##產品特徵全名	l_sfba021desc
       #LET sr.l_sfba021desc = ''
       #IF NOT cl_null(sr.sfba021_desc) THEN
       #   LET sr.l_sfba021desc = sr.sfba021,'.',sr.sfba021_desc
       #END IF
       #160411-00027#12 20160420 mark by beckxie ---E
       ##替代狀態全名	l_sfba026desc
       #LET sr.l_sfba026_desc = ''
       #LET sr.l_sfba026desc = ''
       #CALL s_desc_gzcbl004_desc('4012',sr.sfba026) RETURNING sr.l_sfba026_desc
       #IF NOT cl_null(sr.l_sfba026_desc) THEN
       #   LET sr.l_sfba026desc = sr.sfba026,'.',sr.l_sfba026_desc
       #END IF
       
       
       ##上階料號品名(l_sfba001_imaal003).上階料號規格	(l_sfba001_imaal004)
       #SELECT imaal003,imaal004 INTO sr.l_sfba001_imaal003,sr.l_sfba001_imaal004
       #FROM imaal_t
       #WHERE imaalent = g_enterprise
       #AND imaal001 = sr.sfba001
       #AND imaal002 = g_dlang
       

       ##BOM品名(l_sfba005_imaal003).BOM規格(l_sfba005_imaal004)
       #SELECT imaal003,imaal004 INTO sr.l_sfba005_imaal003,sr.l_sfba005_imaal004
       #FROM imaal_t
       #WHERE imaalent = g_enterprise
       #AND imaal001 = sr.sfba005
       #AND imaal002 = g_dlang

       #dorislai-20150812-add----(E)       
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.sfaadocno,sr.sfaadocdt,sr.l_sfaastus,sr.l_sfaastus_ref,sr.sfaa002,sr.sfaa002_desc,sr.l_sfaa003,sr.l_sfaa003_ref,sr.l_sfaa057,sr.l_sfaa057_ref,sr.sfaa006,sr.sfaa007,sr.sfaa008,sr.sfaa009,sr.sfaa009_desc,sr.sfaa021,sr.sfaa010,sr.sfaa010_desc,sr.sfaa010_desc_1,sr.sfaa012,sr.sfaa013,sr.sfaa013_desc,sr.sfaa017,sr.sfaa017_desc,sr.sfaa019,sr.sfaa020,sr.ooff013,sr.sfaasite,sr.sfbaseq,sr.sfbaseq1,sr.sfaa003,sr.sfba002,sr.sfba002_desc,sr.sfba003,sr.sfba003_desc,sr.sfba004,sr.sfba006,sr.sfba006_desc,sr.sfba006_desc_1,sr.sfba021,sr.sfba021_desc,sr.l_sfba008,sr.sfba009,sr.sfba010,sr.sfba011,sr.sfba012,sr.sfba023,sr.sfba024,sr.sfba013,sr.sfba014,sr.sfba014_desc,sr.sfba015,sr.sfba016,sr.sfba025,sr.l_qty1,sr.sfba017,sr.l_qty2,sr.sfba028,sr.l_imaf034,sr.l_imae092,sr.ooff013_sfba,sr.sfaa004,sr.sfaa057,sr.sfaastus,sr.sfaa005,sr.sfaa011,sr.sfaa018,sr.sfaa022,sr.sfaa058,sr.sfaa060,sr.sfaa068,sr.sfaa049,sr.sfaa050,sr.sfaa051,sr.sfaa055,sr.sfaa056,sr.sfba008,sr.sfba018,sr.sfba022,sr.sfba026,sr.sfba027,sr.l_sfaa004_desc,sr.l_sfaa005_desc,sr.l_sfaa018_desc,sr.l_sfaa060_desc,sr.l_sfaa068_desc,sr.l_sfaa029_desc,sr.l_sfaa030_desc
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "asfr302_x01_execute"
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
 
{<section id="asfr302_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION asfr302_x01_rep_data()
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
 
{<section id="asfr302_x01.other_function" readonly="Y" >}

 
{</section>}
 
