#該程式未解開Section, 採用最新樣板產出!
{<section id="asfr342_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2015-08-12 18:19:45), PR版次:0003(2015-08-12 18:20:36)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000056
#+ Filename...: asfr342_x01
#+ Description: ...
#+ Creator....: 00768(2014-11-06 14:13:36)
#+ Modifier...: 07024 -SD/PR- 07024
 
{</section>}
 
{<section id="asfr342_x01.global" readonly="Y" >}
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
 
{<section id="asfr342_x01.main" readonly="Y" >}
PUBLIC FUNCTION asfr342_x01(p_arg1)
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
   LET g_rep_code = "asfr342_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL asfr342_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL asfr342_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL asfr342_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL asfr342_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL asfr342_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="asfr342_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION asfr342_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "sfebdocno.sfeb_t.sfebdocno,l_sfeadocdt.sfea_t.sfeadocdt,l_sfea001.sfea_t.sfea001,l_sfea002_desc.ooag_t.ooag011,l_sfea003_desc.ooefl_t.ooefl003,l_sfea004.sfea_t.sfea004,l_sfea005.sfea_t.sfea005,l_sfeastus_desc.gzcbl_t.gzcbl004,sfebseq.sfeb_t.sfebseq,sfeb001.sfeb_t.sfeb001,sfeb026.sfeb_t.sfeb026,sfeb002.sfeb_t.sfeb002,l_qcbadocno.qcba_t.qcbadocno,l_qcbastus_desc.gzcbl_t.gzcbl004,l_qcba022_desc.gzcbl_t.gzcbl004,l_sfeb003.gzcbl_t.gzcbl004,sfeb004.sfeb_t.sfeb004,l_sfeb004_imaal003.imaal_t.imaal003,l_sfeb004_imaal004.imaal_t.imaal004,sfeb005.sfeb_t.sfeb005,l_sfeb005_desc.type_t.chr100,l_imaa009_desc.rtaxl_t.rtaxl003,l_imae011_desc.oocql_t.oocql004,sfeb008.sfeb_t.sfeb008,sfeb009.sfeb_t.sfeb009,sfeb007.sfeb_t.sfeb007,l_sfeb013_desc.inayl_t.inayl003,l_sfeb014_desc.inab_t.inab003,sfeb015.sfeb_t.sfeb015,sfeb016.sfeb_t.sfeb016,sfeb022.sfeb_t.sfeb022,l_ooff013.ooff_t.ooff013,sfeb010.sfeb_t.sfeb010,sfeb011.sfeb_t.sfeb011,sfeb012.sfeb_t.sfeb012,sfeb017.sfeb_t.sfeb017,sfeb018.sfeb_t.sfeb018,sfeb019.sfeb_t.sfeb019,sfeb020.sfeb_t.sfeb020,sfeb021.sfeb_t.sfeb021,sfeb027.sfeb_t.sfeb027,l_sfeb001_desc.type_t.chr100,l_sfeb003_ref.type_t.chr30,l_sfeb013_ref.type_t.chr30,l_sfeb014_ref.type_t.chr30,l_sfeb017_desc.type_t.chr50,l_sfeb018_desc.type_t.chr50,l_sfeb019_desc.type_t.chr50,l_sfeb020_desc.type_t.chr30,l_imaa127_desc.type_t.chr30,l_sfeb001desc.type_t.chr200,l_sfeb005desc.type_t.chr200,l_sfeb017desc.type_t.chr100,l_sfeb018desc.type_t.chr100,l_sfeb019desc.type_t.chr100,l_sfeb020desc.type_t.chr80,l_imaa127desc.type_t.chr80" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="asfr342_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION asfr342_x01_ins_prep()
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
             ?,?,?,?,?,?,?)"
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
 
{<section id="asfr342_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION asfr342_x01_sel_prep()
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
   
   #end add-point
   LET g_select = " SELECT sfebdocno,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,sfebseq,sfeb001, 
       sfeb026,sfeb002,NULL,NULL,NULL,NULL,NULL,sfeb003,NULL,sfeb004,NULL,NULL,sfeb005,NULL,NULL,NULL, 
       NULL,NULL,sfeb008,sfeb009,sfeb007,sfeb013,NULL,sfeb014,NULL,sfeb015,sfeb016,sfeb022,NULL,sfeb010, 
       sfeb011,sfeb012,sfeb017,sfeb018,sfeb019,sfeb020,sfeb021,sfeb027,NULL,NULL,NULL,NULL,NULL,NULL, 
       NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   
   #end add-point
    LET g_from = " FROM sfeb_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET g_from = g_from CLIPPED,
                " LEFT JOIN sfea_t ON sfeaent=sfebent AND sfeadocno = sfebdocno ",
                " LEFT JOIN imaa_t ON imaaent=sfebent AND imaa001 = sfeb004 ",
                " LEFT JOIN imae_t ON imaeent=sfebent AND imaesite=sfebsite AND imae001 = sfeb004 "
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   #LET g_where = g_where CLIPPED," AND sfeastus = 'S' "
   LET g_where = g_where CLIPPED," AND sfeastus != 'X' "  #mod 150112
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("sfeb_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE asfr342_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE asfr342_x01_curs CURSOR FOR asfr342_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="asfr342_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION asfr342_x01_ins_data()
DEFINE sr RECORD 
   sfebdocno LIKE sfeb_t.sfebdocno, 
   l_sfeadocdt LIKE sfea_t.sfeadocdt, 
   l_sfea001 LIKE sfea_t.sfea001, 
   l_sfea002 LIKE sfea_t.sfea002, 
   l_sfea002_desc LIKE ooag_t.ooag011, 
   l_sfea003 LIKE sfea_t.sfea003, 
   l_sfea003_desc LIKE ooefl_t.ooefl003, 
   l_sfea004 LIKE sfea_t.sfea004, 
   l_sfea005 LIKE sfea_t.sfea005, 
   l_sfeastus LIKE sfea_t.sfeastus, 
   l_sfeastus_desc LIKE gzcbl_t.gzcbl004, 
   sfebseq LIKE sfeb_t.sfebseq, 
   sfeb001 LIKE sfeb_t.sfeb001, 
   sfeb026 LIKE sfeb_t.sfeb026, 
   sfeb002 LIKE sfeb_t.sfeb002, 
   l_qcbadocno LIKE qcba_t.qcbadocno, 
   l_qcbastus LIKE qcba_t.qcbastus, 
   l_qcbastus_desc LIKE gzcbl_t.gzcbl004, 
   l_qcba022 LIKE qcba_t.qcba022, 
   l_qcba022_desc LIKE gzcbl_t.gzcbl004, 
   sfeb003 LIKE sfeb_t.sfeb003, 
   l_sfeb003 LIKE gzcbl_t.gzcbl004, 
   sfeb004 LIKE sfeb_t.sfeb004, 
   l_sfeb004_imaal003 LIKE imaal_t.imaal003, 
   l_sfeb004_imaal004 LIKE imaal_t.imaal004, 
   sfeb005 LIKE sfeb_t.sfeb005, 
   l_sfeb005_desc LIKE type_t.chr100, 
   l_imaa009 LIKE imaa_t.imaa009, 
   l_imaa009_desc LIKE rtaxl_t.rtaxl003, 
   l_imae011 LIKE imae_t.imae011, 
   l_imae011_desc LIKE oocql_t.oocql004, 
   sfeb008 LIKE sfeb_t.sfeb008, 
   sfeb009 LIKE sfeb_t.sfeb009, 
   sfeb007 LIKE sfeb_t.sfeb007, 
   sfeb013 LIKE sfeb_t.sfeb013, 
   l_sfeb013_desc LIKE inayl_t.inayl003, 
   sfeb014 LIKE sfeb_t.sfeb014, 
   l_sfeb014_desc LIKE inab_t.inab003, 
   sfeb015 LIKE sfeb_t.sfeb015, 
   sfeb016 LIKE sfeb_t.sfeb016, 
   sfeb022 LIKE sfeb_t.sfeb022, 
   l_ooff013 LIKE ooff_t.ooff013, 
   sfeb010 LIKE sfeb_t.sfeb010, 
   sfeb011 LIKE sfeb_t.sfeb011, 
   sfeb012 LIKE sfeb_t.sfeb012, 
   sfeb017 LIKE sfeb_t.sfeb017, 
   sfeb018 LIKE sfeb_t.sfeb018, 
   sfeb019 LIKE sfeb_t.sfeb019, 
   sfeb020 LIKE sfeb_t.sfeb020, 
   sfeb021 LIKE sfeb_t.sfeb021, 
   sfeb027 LIKE sfeb_t.sfeb027, 
   l_sfeb001_desc LIKE type_t.chr100, 
   l_sfeb003_ref LIKE type_t.chr30, 
   l_sfeb013_ref LIKE type_t.chr30, 
   l_sfeb014_ref LIKE type_t.chr30, 
   l_sfeb017_desc LIKE type_t.chr50, 
   l_sfeb018_desc LIKE type_t.chr50, 
   l_sfeb019_desc LIKE type_t.chr50, 
   l_sfeb020_desc LIKE type_t.chr30, 
   l_imaa127_desc LIKE type_t.chr30, 
   l_sfeb001desc LIKE type_t.chr200, 
   l_sfeb005desc LIKE type_t.chr200, 
   l_sfeb017desc LIKE type_t.chr100, 
   l_sfeb018desc LIKE type_t.chr100, 
   l_sfeb019desc LIKE type_t.chr100, 
   l_sfeb020desc LIKE type_t.chr80, 
   l_imaa127desc LIKE type_t.chr80
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_success  LIKE type_t.num5
DEFINE l_sql      STRING
DEFINE l_imaa127  LIKE imaa_t.imaa127  #系列  20150810 by dorislai add
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    LET l_sql = "SELECT UNIQUE qcbadocno,qcbastus,t1.gzcbl004,qcba022,t2.gzcbl004 FROM qcba_t ",
                " LEFT JOIN gzcbl_t t1 ON t1.gzcbl001='13' AND t1.gzcbl002=qcbastus AND t1.gzcbl003='"||g_dlang||"' ",
                " LEFT JOIN gzcbl_t t2 ON t2.gzcbl001='5072' AND t2.gzcbl002=qcba022 AND t2.gzcbl003='"||g_dlang||"' ",
                " WHERE qcbaent = ",g_enterprise,
                "   AND qcba001 = ? ",  #來源單號=入庫單號sr.sfebdocno
                "   AND qcba002 = ? ",  #來源單項次 sr.sfebseq
                "   AND qcbastus= 'Y' "
    DECLARE asfr342_x01_ins_data_c1 SCROLL CURSOR FROM l_sql
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH asfr342_x01_curs INTO sr.*                               
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
       #入庫单单头sfea_t
       SELECT sfeadocdt,sfea001,sfea002,ooag011,
              sfea003,ooefl003,sfea004,sfea005,sfeastus
         INTO sr.l_sfeadocdt,sr.l_sfea001,sr.l_sfea002,sr.l_sfea002_desc,
              sr.l_sfea003,sr.l_sfea003_desc,sr.l_sfea004,sr.l_sfea005,sr.l_sfeastus
         FROM sfea_t LEFT JOIN ooag_t  ON ooagent = g_enterprise AND ooag001 = sfea002
                     LEFT JOIN ooefl_t ON ooeflent= g_enterprise AND ooefl001= sfea003 AND ooefl002= g_dlang
        WHERE sfeaent   = g_enterprise
          AND sfeadocno = sr.sfebdocno
       
       #申请人名称
       #LET sr.l_sfea002_desc = s_desc_get_person_desc(sr.l_sfea002)
       IF NOT cl_null(sr.l_sfea002_desc) THEN
          LET sr.l_sfea002_desc = sr.l_sfea002 CLIPPED,'.',sr.l_sfea002_desc
       ELSE
          LET sr.l_sfea002_desc = sr.l_sfea002
       END IF
       
       #部门名称
       #LET sr.l_sfea003_desc = s_desc_get_department_desc(sr.l_sfea003)
       IF NOT cl_null(sr.l_sfea003_desc) THEN
          LET sr.l_sfea003_desc = sr.l_sfea003 CLIPPED,'.',sr.l_sfea003_desc
       ELSE
          LET sr.l_sfea003_desc = sr.l_sfea003
       END IF
       
       #状态
       LET sr.l_sfeastus_desc = s_desc_gzcbl004_desc('13',sr.l_sfeastus)
       IF NOT cl_null(sr.l_sfeastus_desc) THEN
          LET sr.l_sfeastus_desc= sr.l_sfeastus CLIPPED,'.',sr.l_sfeastus_desc
       ELSE
          LET sr.l_sfeastus_desc= sr.l_sfeastus
       END IF
       
       #FQC单号     FQC单状态 判定结果
       OPEN asfr342_x01_ins_data_c1 USING sr.sfebdocno,sr.sfebseq
       FETCH FIRST asfr342_x01_ins_data_c1 INTO sr.l_qcbadocno,sr.l_qcbastus,sr.l_qcbastus_desc,sr.l_qcba022,sr.l_qcba022_desc
       CLOSE asfr342_x01_ins_data_c1
       #LET sr.l_qcbastus_desc = s_desc_gzcbl004_desc('13',sr.l_qcbastus)
       #LET sr.l_qcba022_desc  = s_desc_gzcbl004_desc('5072',sr.l_qcba022)
       IF NOT cl_null(sr.l_qcbastus_desc) THEN
          LET sr.l_qcbastus_desc = sr.l_qcbastus CLIPPED,'.',sr.l_qcbastus_desc
       ELSE
          LET sr.l_qcbastus_desc = sr.l_qcbastus
       END IF
       IF NOT cl_null(sr.l_qcba022_desc) THEN
          LET sr.l_qcba022_desc  = sr.l_qcba022 CLIPPED,'.',sr.l_qcba022_desc
       ELSE
          LET sr.l_qcba022_desc  = sr.l_qcba022
       END IF
       
       #入库类型
       #----dorislai-20150810-modify----(S)
#       LET sr.l_sfeb003 = s_desc_gzcbl004_desc('4019',sr.sfeb003)
#       IF NOT cl_null(sr.l_sfeb003) THEN
#          LET sr.l_sfeb003= sr.sfeb003 CLIPPED,'.',sr.l_sfeb003
#       ELSE
#          LET sr.l_sfeb003= sr.sfeb003
#       END IF
       LET sr.l_sfeb003_ref = s_desc_gzcbl004_desc('4019',sr.sfeb003)
       IF NOT cl_null(sr.l_sfeb003_ref) THEN
          LET sr.l_sfeb003= sr.sfeb003 CLIPPED,'.',sr.l_sfeb003_ref
       ELSE
          LET sr.l_sfeb003= sr.sfeb003
       END IF
       #----dorislai-20150810-modify----(E)
       #发退料料号品名、规格
       CALL s_desc_get_item_desc(sr.sfeb004) RETURNING sr.l_sfeb004_imaal003,sr.l_sfeb004_imaal004
       
       #产品特征说明
       CALL s_feature_description(sr.sfeb004,sr.sfeb005) RETURNING l_success,sr.l_sfeb005_desc
       #----droislai-20150810-add----(S)
       LET sr.l_sfeb005desc = ''
       IF NOT cl_null(sr.l_sfeb005_desc) THEN
          LET sr.l_sfeb005desc = sr.sfeb005,'.',sr.l_sfeb005_desc
       END IF
       #----droislai-20150810-add----(E)
       #產品分類
       SELECT imaa009,rtaxl003 INTO sr.l_imaa009,sr.l_imaa009_desc
         FROM imaa_t LEFT JOIN rtaxl_t ON rtaxlent = g_enterprise AND rtaxl001 = imaa009 AND rtaxl002= g_dlang
        WHERE imaaent = g_enterprise
          AND imaa001 = sr.sfeb004
       #CALL s_desc_get_rtaxl003_desc(sr.l_imaa009) RETURNING sr.l_imaa009_desc
       IF NOT cl_null(sr.l_imaa009_desc) THEN
          LET sr.l_imaa009_desc = sr.l_imaa009 CLIPPED,'.',sr.l_imaa009_desc
       ELSE
          LET sr.l_imaa009_desc = sr.l_imaa009
       END IF

       #生管分群
       SELECT imae011 INTO sr.l_imae011 FROM imae_t
        WHERE imaeent = g_enterprise
          AND imaesite= g_site
          AND imae001 = sr.sfeb004
       IF NOT cl_null(sr.l_imae011) THEN
          CALL s_desc_get_acc_desc('204',sr.l_imae011) RETURNING sr.l_imae011_desc
          IF NOT cl_null(sr.l_imae011_desc) THEN
             LET sr.l_imae011_desc = sr.l_imae011 CLIPPED,'.',sr.l_imae011_desc
          ELSE
             LET sr.l_imae011_desc = sr.l_imae011
          END IF
       END IF
       #----dorislai-20150810-modify----(S)   把說明欄位也抓出來
#       #库位名称
#       CALL s_desc_get_stock_desc(g_site,sr.sfeb013) RETURNING sr.l_sfeb013_desc
#       IF NOT cl_null(sr.l_sfeb013_desc) THEN
#          LET sr.l_sfeb013_desc = sr.sfeb013 CLIPPED,'.',sr.l_sfeb013_desc
#       ELSE
#          LET sr.l_sfeb013_desc = sr.sfeb013
#       END IF
#       
#       #储位名称
#       CALL s_desc_get_locator_desc(g_site,sr.sfeb013,sr.sfeb014) RETURNING sr.l_sfeb014_desc
#       IF NOT cl_null(sr.l_sfeb014_desc) THEN
#          LET sr.l_sfeb014_desc = sr.sfeb014 CLIPPED,'.',sr.l_sfeb014_desc
#       ELSE
#          LET sr.l_sfeb014_desc = sr.sfeb014
#       END IF
       
       #库位名称
       CALL s_desc_get_stock_desc(g_site,sr.sfeb013) RETURNING sr.l_sfeb013_ref
       IF NOT cl_null(sr.l_sfeb013_ref) THEN
          LET sr.l_sfeb013_desc = sr.sfeb013 CLIPPED,'.',sr.l_sfeb013_ref
       ELSE
          LET sr.l_sfeb013_desc = sr.sfeb013
       END IF
       
       #储位名称
       CALL s_desc_get_locator_desc(g_site,sr.sfeb013,sr.sfeb014) RETURNING sr.l_sfeb014_ref
       IF NOT cl_null(sr.l_sfeb014_ref) THEN
          LET sr.l_sfeb014_desc = sr.sfeb014 CLIPPED,'.',sr.l_sfeb014_ref
       ELSE
          LET sr.l_sfeb014_desc = sr.sfeb014
       END IF
       #----dorislai-20150810-modify----(E)
       #備註
       CALL s_aooi360_sel('6',sr.sfebdocno,'','','','','','','','','','4')
          RETURNING l_success,sr.l_ooff013
          
       #dorislai-20150810-add----(S)   
       #工單單號說明 l_sfeb001_desc	
       LET sr.l_sfeb001_desc = ''
       LET sr.l_sfeb001desc = ''
       CALL s_aooi200_get_slip_desc(sr.sfeb001) RETURNING sr.l_sfeb001_desc
       IF NOT cl_null(sr.l_sfeb001_desc) THEN
          LET sr.l_sfeb001desc = sr.sfeb001,'.',sr.l_sfeb001_desc
       END IF
       #專案代號說明 l_sfeb017_desc	
       LET sr.l_sfeb017_desc = ''
       LET sr.l_sfeb017desc = ''
       CALL s_desc_get_project_desc(sr.sfeb017) RETURNING sr.l_sfeb017_desc
       IF NOT cl_null(sr.l_sfeb017_desc) THEN
          LET sr.l_sfeb017desc = sr.sfeb017,'.',sr.l_sfeb017_desc
       END IF
       #WBS說明 l_sfeb018_desc	
       LET sr.l_sfeb018_desc = ''
       LET sr.l_sfeb018desc = ''
       CALL s_desc_get_wbs_desc(sr.sfeb017,sr.sfeb018) RETURNING sr.l_sfeb018_desc
       IF NOT cl_null(sr.l_sfeb018_desc) THEN
          LET sr.l_sfeb018desc = sr.sfeb018,'.',sr.l_sfeb018_desc
       END IF
       #活動代號 l_sfeb019_desc	
       LET sr.l_sfeb019_desc = ''
       LET sr.l_sfeb019desc = ''
       CALL s_desc_get_activity_desc(sr.sfeb017,sr.sfeb019) RETURNING sr.l_sfeb019_desc
       IF NOT cl_null(sr.l_sfeb019_desc) THEN
          LET sr.l_sfeb019desc = sr.sfeb019,'.',sr.l_sfeb019_desc
       END IF
       #理由碼說明 l_sfeb020_desc	   
       LET sr.l_sfeb020_desc = ''   
       LET sr.l_sfeb020desc = ''
       CALL s_desc_get_acc_desc('225',sr.sfeb020) RETURNING sr.l_sfeb020_desc
       IF NOT cl_null(sr.l_sfeb020_desc) THEN
          LET sr.l_sfeb020desc = sr.sfeb020,'.',sr.l_sfeb020_desc
       END IF
       #系列說明 l_imaa127_desc       
       LET sr.l_imaa127_desc = ''
       LET sr.l_imaa127desc = ''
          #用料號抓取系列
       SELECT imaa127 INTO l_imaa127 FROM imaa_t
        WHERE imaa001 = sr.sfeb004
          AND imaaent = g_enterprise
         #抓取系列說明
       CALL s_desc_get_acc_desc('2003',l_imaa127)  RETURNING sr.l_imaa127_desc
       IF NOT cl_null(sr.l_imaa127_desc) THEN
          LET sr.l_imaa127desc = l_imaa127,'.',sr.l_imaa127_desc
       END IF
       
       
       #dorislai-20150810-add----(E)   
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.sfebdocno,sr.l_sfeadocdt,sr.l_sfea001,sr.l_sfea002_desc,sr.l_sfea003_desc,sr.l_sfea004,sr.l_sfea005,sr.l_sfeastus_desc,sr.sfebseq,sr.sfeb001,sr.sfeb026,sr.sfeb002,sr.l_qcbadocno,sr.l_qcbastus_desc,sr.l_qcba022_desc,sr.l_sfeb003,sr.sfeb004,sr.l_sfeb004_imaal003,sr.l_sfeb004_imaal004,sr.sfeb005,sr.l_sfeb005_desc,sr.l_imaa009_desc,sr.l_imae011_desc,sr.sfeb008,sr.sfeb009,sr.sfeb007,sr.l_sfeb013_desc,sr.l_sfeb014_desc,sr.sfeb015,sr.sfeb016,sr.sfeb022,sr.l_ooff013,sr.sfeb010,sr.sfeb011,sr.sfeb012,sr.sfeb017,sr.sfeb018,sr.sfeb019,sr.sfeb020,sr.sfeb021,sr.sfeb027,sr.l_sfeb001_desc,sr.l_sfeb003_ref,sr.l_sfeb013_ref,sr.l_sfeb014_ref,sr.l_sfeb017_desc,sr.l_sfeb018_desc,sr.l_sfeb019_desc,sr.l_sfeb020_desc,sr.l_imaa127_desc,sr.l_sfeb001desc,sr.l_sfeb005desc,sr.l_sfeb017desc,sr.l_sfeb018desc,sr.l_sfeb019desc,sr.l_sfeb020desc,sr.l_imaa127desc
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "asfr342_x01_execute"
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
 
{<section id="asfr342_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION asfr342_x01_rep_data()
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
 
{<section id="asfr342_x01.other_function" readonly="Y" >}

 
{</section>}
 
