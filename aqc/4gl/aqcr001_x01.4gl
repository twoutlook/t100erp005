#該程式未解開Section, 採用最新樣板產出!
{<section id="aqcr001_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2016-04-15 17:52:58), PR版次:0003(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000056
#+ Filename...: aqcr001_x01
#+ Description: ...
#+ Creator....: 05423(2015-01-07 10:20:08)
#+ Modifier...: 05423 -SD/PR- 00000
 
{</section>}
 
{<section id="aqcr001_x01.global" readonly="Y" >}
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
 
{<section id="aqcr001_x01.main" readonly="Y" >}
PUBLIC FUNCTION aqcr001_x01(p_arg1)
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
   LET g_rep_code = "aqcr001_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL aqcr001_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL aqcr001_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL aqcr001_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL aqcr001_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL aqcr001_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="aqcr001_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION aqcr001_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "qcbadocno.qcba_t.qcbadocno,qcbadocdt.qcba_t.qcbadocdt,l_qcba000_desc.type_t.chr30,qcba001.qcba_t.qcba001,qcba002.qcba_t.qcba002,qcba003.qcba_t.qcba003,qcba004.qcba_t.qcba004,qcba010.qcba_t.qcba010,imaal003.imaal_t.imaal003,imaal004.imaal_t.imaal004,l_qcba012_desc.type_t.chr50,qcba005.qcba_t.qcba005,l_qcba005_desc.type_t.chr50,qcba006.qcba_t.qcba006,l_qcba006_desc.type_t.chr50,qcba007.qcba_t.qcba007,qcba008.qcba_t.qcba008,qcba017.qcba_t.qcba017,qcba009.qcba_t.qcba009,qcba013.qcba_t.qcba013,qcba020.qcba_t.qcba020,qcba021.qcba_t.qcba021,l_qcba024_desc.type_t.chr30,l_qcba022_desc.type_t.chr30,qcba023.qcba_t.qcba023,qcba027.qcba_t.qcba027,l_qcbastus_desc.type_t.chr30,qcba014.qcba_t.qcba014,qcba015.qcba_t.qcba015,qcba016.qcba_t.qcba016,qcba018.qcba_t.qcba018,qcba019.qcba_t.qcba019,qcba025.qcba_t.qcba025,qcba026.qcba_t.qcba026,qcba028.qcba_t.qcba028,qcba029.qcba_t.qcba029,qcba031.qcba_t.qcba031,qcba900.qcba_t.qcba900,qcba901.qcba_t.qcba901,l_qcba031_desc.type_t.chr30,l_qcba900_desc.type_t.chr30,l_qcba901_desc.type_t.chr30,l_qcbadocno_desc.type_t.chr100,l_qcba009_desc.type_t.chr30,l_qcba013_desc.type_t.chr30,l_qcba016_desc.type_t.chr30,l_qcba021_desc.type_t.chr30,l_qcba018_desc.type_t.chr30,l_qcba019_desc.type_t.chr30,l_imaa127_desc.type_t.chr30,l_qcba000_ref.type_t.chr30,l_qcbastus_ref.type_t.chr30,l_qcba012_ref.type_t.chr100,l_qcba022_ref.type_t.chr50,l_qcba031desc.type_t.chr50,l_qcba900desc.type_t.chr50,l_qcba901desc.type_t.chr50,l_qcbadocnodesc.type_t.chr200,l_qcba005desc.type_t.chr80,l_qcba009desc.type_t.chr50,l_qcba012desc.type_t.chr100,l_qcba013desc.type_t.chr50,l_qcba016desc.type_t.chr50,l_qcba021desc.type_t.chr50,l_qcba024desc.type_t.chr50,l_qcba018desc.type_t.chr50,l_qcba019desc.type_t.chr50,l_imaa127desc.type_t.chr50" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="aqcr001_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION aqcr001_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="aqcr001_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aqcr001_x01_sel_prep()
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
   LET g_select = " SELECT DISTINCT qcbadocno,qcbadocdt,qcba000,NULL,qcba001,qcba002,qcba003,qcba004,qcba010, 
       imaal003,imaal004,qcba012,NULL,qcba005,pmaal004,qcba006,oocql004,qcba007,qcba008,qcba017,qcba009,qcba013,qcba020, 
       qcba021,qcba024,ooag011,qcba022,NULL,qcba023,qcba027,qcbastus,NULL,qcba014,qcba015,qcba016, 
       qcba018,qcba019,qcba025,qcba026,qcba028,qcba029,qcba031,qcba900,qcba901,NULL,NULL,NULL,NULL,NULL, 
       NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 
       NULL,NULL,NULL,NULL,NULL"
#   #end add-point
#   LET g_select = " SELECT qcbadocno,qcbadocdt,qcba000,NULL,qcba001,qcba002,qcba003,qcba004,qcba010, 
#       imaal003,imaal004,qcba012,NULL,qcba005,NULL,qcba006,NULL,qcba007,qcba008,qcba017,qcba009,qcba013, 
#       qcba020,qcba021,qcba024,NULL,qcba022,NULL,qcba023,qcba027,qcbastus,NULL,qcba014,qcba015,qcba016, 
#       qcba018,qcba019,qcba025,qcba026,qcba028,qcba029,qcba031,qcba900,qcba901,NULL,NULL,NULL,NULL,NULL, 
#       NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 
#       NULL,NULL,NULL,NULL,NULL"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
    LET g_from = " FROM qcba_t LEFT OUTER JOIN ooag_t ON qcba024 = ooag001 AND qcbaent = ooagent ",
                 "             LEFT OUTER JOIN imaal_t ON qcba010 = imaal001 AND qcbaent = imaalent AND imaal002 = '",g_dlang,"' ",
                 "             LEFT OUTER JOIN oocql_t ON qcba006 = oocql002 AND oocql001 = '221' AND oocqlent = qcbaent AND oocql003 = '",g_dlang,"' ",
                 "             LEFT OUTER JOIN pmaal_t ON qcba005 = pmaal001 AND qcbaent = pmaalent AND pmaal002 = '",g_dlang,"' "
    
#   #end add-point
#    LET g_from = " FROM qcba_t,imaal_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("qcba_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE aqcr001_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE aqcr001_x01_curs CURSOR FOR aqcr001_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="aqcr001_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION aqcr001_x01_ins_data()
DEFINE sr RECORD 
   qcbadocno LIKE qcba_t.qcbadocno, 
   qcbadocdt LIKE qcba_t.qcbadocdt, 
   qcba000 LIKE qcba_t.qcba000, 
   l_qcba000_desc LIKE type_t.chr30, 
   qcba001 LIKE qcba_t.qcba001, 
   qcba002 LIKE qcba_t.qcba002, 
   qcba003 LIKE qcba_t.qcba003, 
   qcba004 LIKE qcba_t.qcba004, 
   qcba010 LIKE qcba_t.qcba010, 
   imaal003 LIKE imaal_t.imaal003, 
   imaal004 LIKE imaal_t.imaal004, 
   qcba012 LIKE qcba_t.qcba012, 
   l_qcba012_desc LIKE type_t.chr50, 
   qcba005 LIKE qcba_t.qcba005, 
   l_qcba005_desc LIKE type_t.chr50, 
   qcba006 LIKE qcba_t.qcba006, 
   l_qcba006_desc LIKE type_t.chr50, 
   qcba007 LIKE qcba_t.qcba007, 
   qcba008 LIKE qcba_t.qcba008, 
   qcba017 LIKE qcba_t.qcba017, 
   qcba009 LIKE qcba_t.qcba009, 
   qcba013 LIKE qcba_t.qcba013, 
   qcba020 LIKE qcba_t.qcba020, 
   qcba021 LIKE qcba_t.qcba021, 
   qcba024 LIKE qcba_t.qcba024, 
   l_qcba024_desc LIKE type_t.chr30, 
   qcba022 LIKE qcba_t.qcba022, 
   l_qcba022_desc LIKE type_t.chr30, 
   qcba023 LIKE qcba_t.qcba023, 
   qcba027 LIKE qcba_t.qcba027, 
   qcbastus LIKE qcba_t.qcbastus, 
   l_qcbastus_desc LIKE type_t.chr30, 
   qcba014 LIKE qcba_t.qcba014, 
   qcba015 LIKE qcba_t.qcba015, 
   qcba016 LIKE qcba_t.qcba016, 
   qcba018 LIKE qcba_t.qcba018, 
   qcba019 LIKE qcba_t.qcba019, 
   qcba025 LIKE qcba_t.qcba025, 
   qcba026 LIKE qcba_t.qcba026, 
   qcba028 LIKE qcba_t.qcba028, 
   qcba029 LIKE qcba_t.qcba029, 
   qcba031 LIKE qcba_t.qcba031, 
   qcba900 LIKE qcba_t.qcba900, 
   qcba901 LIKE qcba_t.qcba901, 
   l_qcba031_desc LIKE type_t.chr30, 
   l_qcba900_desc LIKE type_t.chr30, 
   l_qcba901_desc LIKE type_t.chr30, 
   l_qcbadocno_desc LIKE type_t.chr100, 
   l_qcba009_desc LIKE type_t.chr30, 
   l_qcba013_desc LIKE type_t.chr30, 
   l_qcba016_desc LIKE type_t.chr30, 
   l_qcba021_desc LIKE type_t.chr30, 
   l_qcba018_desc LIKE type_t.chr30, 
   l_qcba019_desc LIKE type_t.chr30, 
   l_imaa127_desc LIKE type_t.chr30, 
   l_qcba000_ref LIKE type_t.chr30, 
   l_qcbastus_ref LIKE type_t.chr30, 
   l_qcba012_ref LIKE type_t.chr100, 
   l_qcba022_ref LIKE type_t.chr50, 
   l_qcba031desc LIKE type_t.chr50, 
   l_qcba900desc LIKE type_t.chr50, 
   l_qcba901desc LIKE type_t.chr50, 
   l_qcbadocnodesc LIKE type_t.chr200, 
   l_qcba005desc LIKE type_t.chr80, 
   l_qcba009desc LIKE type_t.chr50, 
   l_qcba012desc LIKE type_t.chr100, 
   l_qcba013desc LIKE type_t.chr50, 
   l_qcba016desc LIKE type_t.chr50, 
   l_qcba021desc LIKE type_t.chr50, 
   l_qcba024desc LIKE type_t.chr50, 
   l_qcba018desc LIKE type_t.chr50, 
   l_qcba019desc LIKE type_t.chr50, 
   l_imaa127desc LIKE type_t.chr50
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_success  LIKE type_t.chr2

DEFINE l_imaa127  LIKE imaa_t.imaa127
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH aqcr001_x01_curs INTO sr.*                               
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
       IF NOT cl_null(sr.qcba000) THEN
          #dorislai-20150808-modify----(S)
#          CALL aqcr001_x01_desc('5056',sr.qcba000) RETURNING sr.l_qcba000_desc
#          LET sr.l_qcba000_desc = sr.qcba000 CLIPPED,'.',sr.l_qcba000_desc CLIPPED
          CALL aqcr001_x01_desc('5056',sr.qcba000) RETURNING sr.l_qcba000_ref
          IF NOT cl_null(sr.l_qcba000_ref) THEN
             LET sr.l_qcba000_desc = sr.qcba000 CLIPPED,'.',sr.l_qcba000_ref CLIPPED
          END IF
          #dorislai-20150808-modify----(E)
       END IF
       IF NOT cl_null(sr.qcba022) THEN
          #dorislai-20150808-modify----(S)
#          CALL aqcr001_x01_desc('5072',sr.qcba022) RETURNING sr.l_qcba022_desc
#          LET sr.l_qcba022_desc = sr.qcba022 CLIPPED,'.',sr.l_qcba022_desc CLIPPED
          CALL aqcr001_x01_desc('5072',sr.qcba022) RETURNING sr.l_qcba022_ref
          IF NOT cl_null(sr.l_qcba022_ref) THEN
             LET sr.l_qcba022_desc = sr.qcba022 CLIPPED,'.',sr.l_qcba022_ref CLIPPED
          END IF
          #dorislai-20150808-modify----(E)
       END IF
       IF NOT cl_null(sr.qcbastus) THEN
          #dorislai-20150808-modify----(S)
#         CALL aqcr001_x01_desc('13',sr.qcbastus) RETURNING sr.l_qcbastus_desc
#         LET sr.l_qcbastus_desc = sr.qcbastus CLIPPED,'.',sr.l_qcbastus_desc CLIPPED
          CALL aqcr001_x01_desc('13',sr.qcbastus) RETURNING sr.l_qcbastus_ref
          IF NOT cl_null(sr.l_qcbastus_ref) THEN
             LET sr.l_qcbastus_desc = sr.qcbastus CLIPPED,'.',sr.l_qcbastus_ref CLIPPED
          END IF
          #dorislai-20150808-modify----(E)
       END IF
       IF NOT cl_null(sr.qcba012) THEN
         CALL s_feature_description(sr.qcba010,sr.qcba012) RETURNING l_success,sr.l_qcba012_desc
         #dorislai-2050808-add---(S)
         IF NOT cl_null(sr.l_qcba012_desc) THEN
            LET sr.l_qcba012desc = sr.qcba012 CLIPPED,'.',sr.l_qcba012_desc CLIPPED
         END IF
         #dorislai-2050808-add---(E)
#         LET sr.l_qcba012_desc = sr.qcba012 CLIPPED,".",sr.l_qcba012_desc CLIPPED
       ELSE 
         LET sr.l_qcba012_desc = NULL
       END IF
       #dorislai-20150808-add----(S)
       #交易對象編號說明 l_qcba005_desc
       LET sr.l_qcba005desc = ''
       IF NOT cl_null(sr.l_qcba005_desc) THEN
          LET sr.l_qcba005desc = sr.qcba005 CLIPPED,'.',sr.l_qcba005_desc CLIPPED
       END IF       
       #檢驗員說明 l_qcba024_desc	    
       LET sr.l_qcba024desc = ''
       IF NOT cl_null(sr.l_qcba024_desc) THEN
          LET sr.l_qcba024desc = sr.qcba024 CLIPPED,'.',sr.l_qcba024_desc CLIPPED
       END IF
       #類型分類說明 l_qcba031_desc		
       LET sr.l_qcba031_desc = ''
       LET sr.l_qcba031desc = ''
       CASE sr.qcba000
          WHEN 4
             CALL s_desc_gzcbl004_desc('5061',sr.qcba031) RETURNING sr.l_qcba031_desc
          WHEN 5
             CALL s_desc_gzcbl004_desc('5060',sr.qcba031) RETURNING sr.l_qcba031_desc
       END CASE
       IF NOT cl_null(sr.l_qcba031_desc) THEN
          LET sr.l_qcba031desc = sr.qcba031 CLIPPED,'.',sr.l_qcba031_desc CLIPPED
       END IF
       #開單人員說明 l_qcba900_desc		
       LET sr.l_qcba900_desc = ''
       LET sr.l_qcba900desc = ''
       SELECT ooag011 INTO sr.l_qcba900_desc FROM ooag_t 
        WHERE ooagent = g_enterprise AND ooag001 = sr.qcba900
       IF NOT cl_null(sr.l_qcba900_desc) THEN
          LET sr.l_qcba900desc = sr.qcba900 CLIPPED,'.',sr.l_qcba900_desc CLIPPED
       END IF
       #開單部門說明 l_qcba901_desc		
       LET sr.l_qcba901_desc = ''
       LET sr.l_qcba901desc = ''
       SELECT ooefl003 INTO sr.l_qcba901_desc FROM ooefl_t 
        WHERE ooeflent = g_enterprise AND ooefl001 = sr.qcba901 AND ooefl002 = g_dlang
       IF NOT cl_null(sr.l_qcba901_desc) THEN
          LET sr.l_qcba901desc = sr.qcba901 CLIPPED,'.',sr.l_qcba901_desc CLIPPED
       END IF
       #檢驗單號說明 l_qcbadocno_desc		
       LET sr.l_qcbadocno_desc = ''
       LET sr.l_qcbadocnodesc = ''
       CALL s_aooi200_get_slip_desc(sr.qcbadocno) RETURNING sr.l_qcbadocno_desc
       IF NOT cl_null(sr.l_qcbadocno_desc) THEN
          LET sr.l_qcbadocnodesc = sr.qcbadocno CLIPPED,'.',sr.l_qcbadocno_desc CLIPPED
       END IF
       
       #====基本資料====
       #單位說明 l_qcba009_desc		
       LET sr.l_qcba009_desc = ''
       LET sr.l_qcba009desc = ''
       SELECT oocal003 INTO sr.l_qcba009_desc FROM oocal_t 
        WHERE oocalent = g_enterprise AND oocal001 = sr.qcba009 AND oocal002 = g_dlang
       IF NOT cl_null(sr.l_qcba009_desc) THEN
          LET sr.l_qcba009desc = sr.qcba009 CLIPPED,'.',sr.l_qcba009_desc CLIPPED
       END IF
       #品管分群說明 l_qcba013_desc		
       LET sr.l_qcba013_desc = ''
       LET sr.l_qcba013desc = ''
       SELECT oocql004 INTO sr.l_qcba013_desc FROM oocql_t 
        WHERE oocqlent = g_enterprise AND oocql001 = '205' 
          AND oocql002 = sr.qcba013 AND oocql003 = g_dlang
       IF NOT cl_null(sr.l_qcba013_desc) THEN
          LET sr.l_qcba013desc = sr.qcba013 CLIPPED,'.',sr.l_qcba013_desc CLIPPED
       END IF
       #檢驗單位說明 l_qcba016_desc		
       LET sr.l_qcba016_desc = ''
       LET sr.l_qcba016desc = ''
       SELECT oocal003 INTO sr.l_qcba016_desc FROM oocal_t 
        WHERE oocalent = g_enterprise AND oocal001 = sr.qcba016 AND oocal002 = g_dlang
       IF NOT cl_null(sr.l_qcba016_desc) THEN
          LET sr.l_qcba016desc = sr.qcba016 CLIPPED,'.',sr.l_qcba016_desc CLIPPED
       END IF
       #緊急度說明 l_qcba021_desc		
       LET sr.l_qcba021_desc = ''
       LET sr.l_qcba021desc = ''
       CALL s_desc_gzcbl004_desc('5074',sr.qcba021) RETURNING sr.l_qcba021_desc
       IF NOT cl_null(sr.l_qcba021_desc) THEN
          LET sr.l_qcba021desc = sr.qcba021 CLIPPED,'.',sr.l_qcba021_desc CLIPPED
       END IF
       #====相關資訊====
       #檢驗程度說明 l_qcba018_desc	
       LET sr.l_qcba018_desc = ''
       LET sr.l_qcba018desc = ''
       CALL s_desc_gzcbl004_desc('5051',sr.qcba018) RETURNING sr.l_qcba018_desc
       IF NOT cl_null(sr.l_qcba018_desc) THEN
          LET sr.l_qcba018desc = sr.qcba018 CLIPPED,'.',sr.l_qcba018_desc CLIPPED
       END IF
       #檢驗級數說明 l_qcba019_desc	
       LET sr.l_qcba019_desc = ''
       LET sr.l_qcba019desc = ''
       CALL s_desc_gzcbl004_desc('5053',sr.qcba019) RETURNING sr.l_qcba019_desc
       IF NOT cl_null(sr.l_qcba019_desc) THEN
          LET sr.l_qcba019desc = sr.qcba019 CLIPPED,'.',sr.l_qcba019_desc CLIPPED
       END IF
       #系列說明 l_imaa127_desc	
       LET sr.l_imaa127_desc = ''
       LET sr.l_imaa127desc = ''
          #用料號抓取系列
       SELECT imaa127 INTO l_imaa127 FROM imaa_t
        WHERE imaa001 = sr.qcba010
          AND imaaent = g_enterprise
         #抓取系列說明
       CALL s_desc_get_acc_desc('2003',l_imaa127)  RETURNING sr.l_imaa127_desc 
       IF NOT cl_null(sr.l_imaa127_desc) THEN
          LET sr.l_imaa127desc = l_imaa127 CLIPPED,'.',sr.l_imaa127_desc CLIPPED
       END IF
       #dorislai-20150808-add----(E)
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.qcbadocno,sr.qcbadocdt,sr.l_qcba000_desc,sr.qcba001,sr.qcba002,sr.qcba003,sr.qcba004,sr.qcba010,sr.imaal003,sr.imaal004,sr.l_qcba012_desc,sr.qcba005,sr.l_qcba005_desc,sr.qcba006,sr.l_qcba006_desc,sr.qcba007,sr.qcba008,sr.qcba017,sr.qcba009,sr.qcba013,sr.qcba020,sr.qcba021,sr.l_qcba024_desc,sr.l_qcba022_desc,sr.qcba023,sr.qcba027,sr.l_qcbastus_desc,sr.qcba014,sr.qcba015,sr.qcba016,sr.qcba018,sr.qcba019,sr.qcba025,sr.qcba026,sr.qcba028,sr.qcba029,sr.qcba031,sr.qcba900,sr.qcba901,sr.l_qcba031_desc,sr.l_qcba900_desc,sr.l_qcba901_desc,sr.l_qcbadocno_desc,sr.l_qcba009_desc,sr.l_qcba013_desc,sr.l_qcba016_desc,sr.l_qcba021_desc,sr.l_qcba018_desc,sr.l_qcba019_desc,sr.l_imaa127_desc,sr.l_qcba000_ref,sr.l_qcbastus_ref,sr.l_qcba012_ref,sr.l_qcba022_ref,sr.l_qcba031desc,sr.l_qcba900desc,sr.l_qcba901desc,sr.l_qcbadocnodesc,sr.l_qcba005desc,sr.l_qcba009desc,sr.l_qcba012desc,sr.l_qcba013desc,sr.l_qcba016desc,sr.l_qcba021desc,sr.l_qcba024desc,sr.l_qcba018desc,sr.l_qcba019desc,sr.l_imaa127desc
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "aqcr001_x01_execute"
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
 
{<section id="aqcr001_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION aqcr001_x01_rep_data()
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
 
{<section id="aqcr001_x01.other_function" readonly="Y" >}

#GET SCC
PRIVATE FUNCTION aqcr001_x01_desc(p_num,p_target)
   DEFINE p_num    LIKE type_t.num5
   DEFINE p_target LIKE type_t.chr10
   DEFINE r_desc   LIKE type_t.chr500
   
   SELECT gzcbl004 INTO r_desc
      FROM gzcbl_t
     WHERE gzcbl001 = p_num
       AND gzcbl002 = p_target
       AND gzcbl003 = g_dlang
   
   RETURN r_desc
END FUNCTION

 
{</section>}
 
