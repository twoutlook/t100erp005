#該程式未解開Section, 採用最新樣板產出!
{<section id="asfr006_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:6(2017-02-17 11:06:42), PR版次:0006(2017-02-17 11:21:07)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000063
#+ Filename...: asfr006_x01
#+ Description: ...
#+ Creator....: 01258(2014-10-28 10:35:27)
#+ Modifier...: 07423 -SD/PR- 07423
 
{</section>}
 
{<section id="asfr006_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#160411-00027#10  16/04/21  By zhujing  效能优化:资料的抓取全部放在主sql中
#160425-00019     16/05/20  By Whitney  齊料套數不及時計算改抓sfaa071
#160822-00011#1   16/08/22  By dorislai 修正狀態碼說明的應用分類碼
#160908-00048#1   16/09/08  By dorislai 修正委外的工單，部門供應商說明沒出來的問題
#170216-00028#1   17/02/17  By fionchen 增加顯示sfaa023,sfaa024欄位
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
 
{<section id="asfr006_x01.main" readonly="Y" >}
PUBLIC FUNCTION asfr006_x01(p_arg1)
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
   LET g_rep_code = "asfr006_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL asfr006_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL asfr006_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL asfr006_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL asfr006_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL asfr006_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="asfr006_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION asfr006_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "sfaadocno.sfaa_t.sfaadocno,sfaa010.sfaa_t.sfaa010,sfaa010_desc.type_t.chr30,sfaa010_desc_1.type_t.chr80,sfaa019.sfaa_t.sfaa019,sfaa020.sfaa_t.sfaa020,sfaa017.sfaa_t.sfaa017,sfaa017_desc.type_t.chr80,sfaa002.sfaa_t.sfaa002,sfaa002_desc.type_t.chr80,sfaa012.sfaa_t.sfaa012,sfaa013.sfaa_t.sfaa013,sfaa013_desc.type_t.chr30,sfaa049.sfaa_t.sfaa049,l_qty.type_t.num20_6,sfaa050.sfaa_t.sfaa050,sfaa051.sfaa_t.sfaa051,sfaa055.sfaa_t.sfaa055,sfaa056.sfaa_t.sfaa056,l_qty1.type_t.num20_6,l_sfab002.type_t.chr50,sfaa009.sfaa_t.sfaa009,sfaa009_desc.type_t.chr30,l_ooff013.ooff_t.ooff013,sfaa003.sfaa_t.sfaa003,sfaa004.sfaa_t.sfaa004,sfaa057.sfaa_t.sfaa057,sfaadocdt.sfaa_t.sfaadocdt,sfaastus.sfaa_t.sfaastus,sfaa005.sfaa_t.sfaa005,sfaa006.sfaa_t.sfaa006,sfaa011.sfaa_t.sfaa011,sfaa016.sfaa_t.sfaa016,sfaa018.sfaa_t.sfaa018,sfaa021.sfaa_t.sfaa021,sfaa022.sfaa_t.sfaa022,sfaa023.sfaa_t.sfaa023,sfaa024.sfaa_t.sfaa024,sfaa058.sfaa_t.sfaa058,sfaa060.sfaa_t.sfaa060,sfaa061.sfaa_t.sfaa061,sfaa068.sfaa_t.sfaa068,sfaa046.sfaa_t.sfaa046,sfaa047.sfaa_t.sfaa047,sfaa048.sfaa_t.sfaa048,sfaa065.sfaa_t.sfaa065,l_sfaa003_desc.type_t.chr30,l_sfaa004_desc.type_t.chr30,l_sfaa057_desc.type_t.chr30,l_sfaastus_desc.type_t.chr30,l_sfaa005_desc.type_t.chr30,l_sfaa016_desc.type_t.chr30,l_sfaa018_desc.type_t.chr30,l_sfaa068_desc.type_t.chr30,l_sfaa029_desc.type_t.chr50,l_sfaa030_desc.type_t.chr50" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="asfr006_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION asfr006_x01_ins_prep()
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
             ?,?,?,?,?,?)"
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
 
{<section id="asfr006_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION asfr006_x01_sel_prep()
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
   #160411-00027#10 mod by zhujing -(S)
   LET g_select = " SELECT DISTINCT X.sfaadocno,X.sfaa010,",
                  " (SELECT imaal003 FROM imaal_t WHERE imaal001 = X.sfaa010 AND X.sfaaent = imaalent AND imaal002 = '",g_dlang,"')imaal003,",
                  " (SELECT imaal004 FROM imaal_t WHERE imaal001 = X.sfaa010 AND X.sfaaent = imaalent AND imaal002 = '",g_dlang,"')imaal004,",
                  " X.sfaa019,X.sfaa020,X.sfaa017,",
                  #160908-00048#1-s-#-mod
                  #" (SELECT ooefl003 FROM ooefl_t WHERE X.sfaa017 = ooefl001 AND X.sfaaent = ooeflent AND ooefl002 = '",g_dlang,"') A1_ooefl003,",
                  " (CASE X.sfaa057 WHEN '1' THEN (SELECT ooefl003 FROM ooefl_t WHERE ooeflent = X.sfaaent AND ooefl001 = X.sfaa017 AND ooefl002 = '",g_dlang,"' )",
                  "                 WHEN '2' THEN (SELECT pmaal004 FROM pmaal_t WHERE pmaalent = X.sfaaent AND pmaal001 = X.sfaa017 AND pmaal002 = '",g_dlang,"' ) ",
                  "  END ) A1_ooefl003, ",
                  #160908-00048#1-e-#-mod
                  " X.sfaa002,",
                  " (SELECT ooag011 FROM ooag_t WHERE ooag001 = X.sfaa002 AND ooagent = X.sfaaent) C_ooag011,",
                  " X.sfaa012,X.sfaa013,",
                  " (SELECT oocal003 FROM oocal_t WHERE oocal001 = X.sfaa013 AND oocalent = X.sfaaent AND oocal002 = '",g_dlang,"')oocal003,",
                 #160425-00019 by whitney modift start
                 #" X.sfaa049,NULL,X.sfaa050,X.sfaa051,X.sfaa055,X.sfaa056,",
                  " X.sfaa049,X.sfaa071,X.sfaa050,X.sfaa051,X.sfaa055,X.sfaa056,",
                 #160425-00019 by whitney modift end
                  " (COALESCE(X.sfaa012,0)-COALESCE(X.sfaa050,0)-COALESCE(X.sfaa051,0)-COALESCE(X.sfaa055,0)-COALESCE(X.sfaa056,0)),",
                  " (SELECT trim(D.sfaa006)||'-'||trim(D.sfaa007)||'-'||trim(D.sfaa008)||'-'||trim(D.sfaa063) FROM sfaa_t D ",
                  " WHERE D.sfaasite = sfaasite AND D.sfaadocno = X.sfaadocno AND D.sfaaent = X.sfaaent AND (D.sfaa006 IS NOT NULL) ",
                  " AND (D.sfaa007 IS NOT NULL) AND (D.sfaa008 IS NOT NULL) AND (D.sfaa063 IS NOT NULL )) l_sfba002,X.sfaa009,",
                  " (SELECT pmaal004 FROM pmaal_t WHERE pmaal001 = X.sfaa009 AND pmaalent = X.sfaaent AND pmaal002 = '",g_dlang,"')pmaal004,",
                  " (SELECT ooff013 FROM ooff_t WHERE ooff001 = '6' AND ooff002 = X.sfaadocno AND ooffent = X.sfaaent AND ooff012 = '2')ooff013, ",
                  " X.sfaa003,X.sfaa004,X.sfaa057,X.sfaadocdt,X.sfaastus,X.sfaa005,X.sfaa006,X.sfaa011,X.sfaa016,X.sfaa018,X.sfaa021,X.sfaa022, ",
                  " X.sfaa023,X.sfaa024,",       #170216-00028#1 add                                                      
                  " X.sfaa058,X.sfaa060,X.sfaa061,X.sfaa068,X.sfaa046,X.sfaa047,X.sfaa048,X.sfaa065,",
                  " (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '4007' AND gzcbl002 = X.sfaa003 AND gzcbl003 = '",g_dlang,"')B3_gzcbl004,",
                  " (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '4008' AND gzcbl002 = X.sfaa004 AND gzcbl003 = '",g_dlang,"')B4_gzcbl004,",
                  " (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '4010' AND gzcbl002 = X.sfaa057 AND gzcbl003 = '",g_dlang,"')B2_gzcbl004,",
                  #160822-00011#1-s-mod
#                  " (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '3' AND gzcbl002 = X.sfaastus AND gzcbl003 = '",g_dlang,"')B1_gzcbl004,",
                  " (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '13' AND gzcbl002 = X.sfaastus AND gzcbl003 = '",g_dlang,"')B1_gzcbl004,",
                  #160822-00011#1-e-mod
                  " (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '4009' AND gzcbl002 = X.sfaa005 AND gzcbl003 = '",g_dlang,"')B5_gzcbl004,",
                  " (SELECT ecba003 FROM ecba_t,imae_t WHERE ecba001 = imae032 AND ecba002 = X.sfaa016 AND ecbaent = X.sfaaent AND X.sfaasite = ecbasite AND imae001 = X.sfaa010 AND imaeent = X.sfaaent AND imaesite = X.sfaasite)ecba003,",
                  " (SELECT ooeal003 FROM ooeal_t WHERE ooeal001 = X.sfaa018 AND ooealent = X.sfaaent AND ooeal002 = '",g_dlang,"')ooeal003,",
                  " (SELECT ooefl003 FROM ooefl_t WHERE ooefl001 = X.sfaa068 AND ooeflent = X.sfaaent AND ooefl002 = '",g_dlang,"')A2_ooefl003,",
                  " (SELECT pjbbl004 FROM pjbbl_t WHERE pjbbl001 = X.sfaa028 AND pjbbl002 = X.sfaa029 AND pjbblent = X.sfaaent AND pjbbl003 = '",g_dlang,"')pjbbl004,",
                  " (SELECT pjbml004 FROM pjbml_t WHERE pjbml001 = X.sfaa028 AND pjbml002 = X.sfaa030 AND pjbmlent = X.sfaaent AND pjbml003 = '",g_dlang,"')pjbml004 "
   #160411-00027#10 mod by zhujing -(E)
   #160411-00027#10 marked by zhujing -(S)
#   #end add-point
#   LET g_select = " SELECT sfaadocno,sfaa010,NULL,NULL,sfaa019,sfaa020,sfaa017,NULL,sfaa002,NULL,sfaa012, 
#       sfaa013,NULL,sfaa049,NULL,sfaa050,sfaa051,sfaa055,sfaa056,NULL,NULL,sfaa009,NULL,NULL,sfaa003, 
#       sfaa004,sfaa057,sfaadocdt,sfaastus,sfaa005,sfaa006,sfaa011,sfaa016,sfaa018,sfaa021,sfaa022,sfaa023, 
#       sfaa024,sfaa058,sfaa060,sfaa061,sfaa068,sfaa046,sfaa047,sfaa048,sfaa065,NULL,NULL,NULL,NULL,NULL, 
#       NULL,NULL,NULL,NULL,NULL"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   #160411-00027#10 marked by zhujing -(E)
   #160411-00027#10 mod by zhujing -(S)
   LET g_from = " FROM sfaa_t X"
   #160411-00027#10 mod by zhujing -(E)
   #160411-00027#10 marked by zhujing -(S)
#   #end add-point
#    LET g_from = " FROM sfaa_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   #160411-00027#10 marked by zhujing -(E)
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
   PREPARE asfr006_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE asfr006_x01_curs CURSOR FOR asfr006_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="asfr006_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION asfr006_x01_ins_data()
DEFINE sr RECORD 
   sfaadocno LIKE sfaa_t.sfaadocno, 
   sfaa010 LIKE sfaa_t.sfaa010, 
   sfaa010_desc LIKE type_t.chr30, 
   sfaa010_desc_1 LIKE type_t.chr80, 
   sfaa019 LIKE sfaa_t.sfaa019, 
   sfaa020 LIKE sfaa_t.sfaa020, 
   sfaa017 LIKE sfaa_t.sfaa017, 
   sfaa017_desc LIKE type_t.chr80, 
   sfaa002 LIKE sfaa_t.sfaa002, 
   sfaa002_desc LIKE type_t.chr80, 
   sfaa012 LIKE sfaa_t.sfaa012, 
   sfaa013 LIKE sfaa_t.sfaa013, 
   sfaa013_desc LIKE type_t.chr30, 
   sfaa049 LIKE sfaa_t.sfaa049, 
   l_qty LIKE type_t.num20_6, 
   sfaa050 LIKE sfaa_t.sfaa050, 
   sfaa051 LIKE sfaa_t.sfaa051, 
   sfaa055 LIKE sfaa_t.sfaa055, 
   sfaa056 LIKE sfaa_t.sfaa056, 
   l_qty1 LIKE type_t.num20_6, 
   l_sfab002 LIKE type_t.chr50, 
   sfaa009 LIKE sfaa_t.sfaa009, 
   sfaa009_desc LIKE type_t.chr30, 
   l_ooff013 LIKE ooff_t.ooff013, 
   sfaa003 LIKE sfaa_t.sfaa003, 
   sfaa004 LIKE sfaa_t.sfaa004, 
   sfaa057 LIKE sfaa_t.sfaa057, 
   sfaadocdt LIKE sfaa_t.sfaadocdt, 
   sfaastus LIKE sfaa_t.sfaastus, 
   sfaa005 LIKE sfaa_t.sfaa005, 
   sfaa006 LIKE sfaa_t.sfaa006, 
   sfaa011 LIKE sfaa_t.sfaa011, 
   sfaa016 LIKE sfaa_t.sfaa016, 
   sfaa018 LIKE sfaa_t.sfaa018, 
   sfaa021 LIKE sfaa_t.sfaa021, 
   sfaa022 LIKE sfaa_t.sfaa022, 
   sfaa023 LIKE sfaa_t.sfaa023, 
   sfaa024 LIKE sfaa_t.sfaa024, 
   sfaa058 LIKE sfaa_t.sfaa058, 
   sfaa060 LIKE sfaa_t.sfaa060, 
   sfaa061 LIKE sfaa_t.sfaa061, 
   sfaa068 LIKE sfaa_t.sfaa068, 
   sfaa046 LIKE sfaa_t.sfaa046, 
   sfaa047 LIKE sfaa_t.sfaa047, 
   sfaa048 LIKE sfaa_t.sfaa048, 
   sfaa065 LIKE sfaa_t.sfaa065, 
   l_sfaa003_desc LIKE type_t.chr30, 
   l_sfaa004_desc LIKE type_t.chr30, 
   l_sfaa057_desc LIKE type_t.chr30, 
   l_sfaastus_desc LIKE type_t.chr30, 
   l_sfaa005_desc LIKE type_t.chr30, 
   l_sfaa016_desc LIKE type_t.chr30, 
   l_sfaa018_desc LIKE type_t.chr30, 
   l_sfaa068_desc LIKE type_t.chr30, 
   l_sfaa029_desc LIKE type_t.chr50, 
   l_sfaa030_desc LIKE type_t.chr50
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_success          LIKE type_t.num5
DEFINE l_sfaa006          LIKE sfaa_t.sfaa006
DEFINE l_sfaa007          LIKE sfaa_t.sfaa007
DEFINE l_sfaa008          LIKE sfaa_t.sfaa008
DEFINE l_sfaa063          LIKE sfaa_t.sfaa063
DEFINE l_gzcb002          LIKE gzcb_t.gzcb002
DEFINE l_gzcb002_1        LIKE gzcb_t.gzcb002
DEFINE l_gzcbl004         LIKE gzcbl_t.gzcbl004
DEFINE l_gzcbl004_1       LIKE gzcbl_t.gzcbl004
DEFINE l_imaa127 LIKE imaa_t.imaa127   #系列       20150811 by dorislai add
DEFINE l_imae032 LIKE imae_t.imae032   #製程料號    20150811 by dorislai add
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH asfr006_x01_curs INTO sr.*                               
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
       #160411-00027#10 marked by zhujing -(S)
#       SELECT imaal003,imaal004 INTO sr.sfaa010_desc,sr.sfaa010_desc_1 FROM imaal_t 
#        WHERE imaalent = g_enterprise AND imaal001 = sr.sfaa010 AND imaal002 = g_lang
#       
#       SELECT ooag011 INTO sr.sfaa002_desc FROM ooag_t WHERE ooagent=g_enterprise AND ooag001=sr.sfaa002
#       
#       SELECT oocal003 INTO sr.sfaa013_desc FROM oocal_t WHERE oocalent=g_enterprise AND oocal001=sr.sfaa013 AND oocal002=g_lang
#
#       SELECT pmaal004 INTO sr.sfaa009_desc FROM pmaal_t WHERE pmaalent=g_enterprise AND pmaal001=sr.sfaa009 AND pmaal002=g_lang
       #160411-00027#10 marked by zhujing -(E)
#160425-00019 by whitney mark start
#       CALL s_asft340_full_sets(sr.sfaadocno,'','','') RETURNING l_success,sr.l_qty
#160425-00019 by whitney mark end
       #160411-00027#10 marked by zhujing -(S)
#       LET sr.l_qty1 = sr.sfaa012 - sr.sfaa050 - sr.sfaa051 - sr.sfaa055 - sr.sfaa056
#       
#       CALL s_aooi360_sel('6',sr.sfaadocno,'','','','','','','','','','2') RETURNING l_success,sr.l_ooff013
#       
#       SELECT sfaa006,sfaa007,sfaa008,sfaa063 INTO l_sfaa006,l_sfaa007,l_sfaa008,l_sfaa063 FROM sfaa_t
#        WHERE sfaaent = g_enterprise AND sfaasite = g_site AND sfaadocno = sr.sfaadocno
#       IF NOT cl_null(l_sfaa006) AND NOT cl_null(l_sfaa007) AND NOT cl_null(l_sfaa008) AND NOT cl_null(l_sfaa063) THEN
#          LET sr.l_sfab002 = l_sfaa006,"-",l_sfaa007,"-",l_sfaa008,"-",l_sfaa063
#       END IF
#       
#       SELECT gzcb002, gzcbl004 INTO l_gzcb002,l_gzcbl004
#         FROM gzcb_t LEFT JOIN gzcbl_t ON gzcb002 = gzcbl002
#                                      AND gzcb001 = gzcbl001
#                                      AND gzcb001 = '13'
#                                      AND gzcbl003 = g_dlang
#        WHERE gzcb001 = '13' AND gzcb002 = (SELECT sfaastus FROM sfaa_t
#                                             WHERE sfaaent = g_enterprise AND sfaadocno = sr.sfaadocno)
#       LET sr.l_sfaastus = l_gzcb002,":",l_gzcbl004
#       
#       SELECT gzcb002, gzcbl004 INTO l_gzcb002_1,l_gzcbl004_1
#         FROM gzcb_t LEFT JOIN gzcbl_t ON gzcb002 = gzcbl002
#                                      AND gzcb001 = gzcbl001
#                                      AND gzcb001 = '4010'
#                                      AND gzcbl003 = g_dlang
#        WHERE gzcb001 = '4010' AND gzcb002 = (SELECT sfaa057 FROM sfaa_t
#                                             WHERE sfaaent = g_enterprise AND sfaadocno = sr.sfaadocno)
#       LET sr.l_sfaa057 = l_gzcb002_1,":",l_gzcbl004_1
#       
#       IF l_gzcb002_1 = '2' THEN
#          INITIALIZE g_chkparam.* TO NULL
#          LET g_chkparam.arg1 = sr.sfaa017
#          CALL cl_ref_val("v_pmaal004")
#          LET sr.sfaa017_desc = g_chkparam.return1
#       ELSE
#          CALL s_desc_get_department_desc(sr.sfaa017) RETURNING sr.sfaa017_desc
#       END IF
#       
#       #dorislai-20150811-add----(S)
#       #生管人員全名
#       LET sr.l_sfaa002desc = ''
#       IF NOT cl_null(sr.sfaa002_desc) THEN
#          LET sr.l_sfaa002desc = sr.sfaa002,'.',sr.sfaa002_desc
#       END IF
#       #生產單位全名
#       LET sr.l_sfaa013desc = ''
#       IF NOT cl_null(sr.sfaa013_desc) THEN
#          LET sr.l_sfaa013desc = sr.sfaa013,'.',sr.sfaa013_desc
#       END IF
#       #參考客戶全名
#       LET sr.l_sfaa009desc = ''
#       IF NOT cl_null(sr.sfaa009_desc) THEN
#          LET sr.l_sfaa009desc = sr.sfaa009,'.',sr.sfaa009_desc
#       END IF
#       #部門廠商全名 	
#       LET sr.l_sfaa017desc = ''
#       IF NOT cl_null(sr.sfaa017_desc) THEN
#          LET sr.l_sfaa017desc = sr.sfaa017,'.',sr.sfaa017_desc
#       END IF
#       
#       #單頭
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
#
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
#       
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
       #160411-00027#10 marked by zhujing -(E)
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.sfaadocno,sr.sfaa010,sr.sfaa010_desc,sr.sfaa010_desc_1,sr.sfaa019,sr.sfaa020,sr.sfaa017,sr.sfaa017_desc,sr.sfaa002,sr.sfaa002_desc,sr.sfaa012,sr.sfaa013,sr.sfaa013_desc,sr.sfaa049,sr.l_qty,sr.sfaa050,sr.sfaa051,sr.sfaa055,sr.sfaa056,sr.l_qty1,sr.l_sfab002,sr.sfaa009,sr.sfaa009_desc,sr.l_ooff013,sr.sfaa003,sr.sfaa004,sr.sfaa057,sr.sfaadocdt,sr.sfaastus,sr.sfaa005,sr.sfaa006,sr.sfaa011,sr.sfaa016,sr.sfaa018,sr.sfaa021,sr.sfaa022,sr.sfaa023,sr.sfaa024,sr.sfaa058,sr.sfaa060,sr.sfaa061,sr.sfaa068,sr.sfaa046,sr.sfaa047,sr.sfaa048,sr.sfaa065,sr.l_sfaa003_desc,sr.l_sfaa004_desc,sr.l_sfaa057_desc,sr.l_sfaastus_desc,sr.l_sfaa005_desc,sr.l_sfaa016_desc,sr.l_sfaa018_desc,sr.l_sfaa068_desc,sr.l_sfaa029_desc,sr.l_sfaa030_desc
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "asfr006_x01_execute"
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
 
{<section id="asfr006_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION asfr006_x01_rep_data()
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
 
{<section id="asfr006_x01.other_function" readonly="Y" >}

 
{</section>}
 
