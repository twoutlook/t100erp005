#該程式未解開Section, 採用最新樣板產出!
{<section id="asfr316_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2015-08-10 13:48:46), PR版次:0002(2015-08-10 13:56:45)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000057
#+ Filename...: asfr316_x01
#+ Description: ...
#+ Creator....: 00768(2014-11-05 11:26:43)
#+ Modifier...: 07024 -SD/PR- 07024
 
{</section>}
 
{<section id="asfr316_x01.global" readonly="Y" >}
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
DEFINE g_ref_unit            LIKE type_t.chr1   #是否启用参考单位
#end add-point
 
{</section>}
 
{<section id="asfr316_x01.main" readonly="Y" >}
PUBLIC FUNCTION asfr316_x01(p_arg1)
DEFINE  p_arg1 STRING                  #tm.wc  where condition
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   CALL cl_get_para(g_enterprise,g_site,'S-BAS-0028') RETURNING g_ref_unit  #是否启用参考单位
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "asfr316_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL asfr316_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL asfr316_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL asfr316_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL asfr316_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL asfr316_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="asfr316_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION asfr316_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "sfdddocno.sfdd_t.sfdddocno,l_sfdadocdt.sfda_t.sfdadocdt,l_sfda001.sfda_t.sfda001,l_sfda002.sfda_t.sfda002,l_sfda002_desc.gzcbl_t.gzcbl004,l_sfda003.sfda_t.sfda003,l_sfda003_desc.ooefl_t.ooefl003,l_sfda004.sfda_t.sfda004,l_sfda004_desc.ooag_t.ooag011,l_sfda005.sfda_t.sfda005,l_sfdastus.sfda_t.sfdastus,l_sfdastus_desc.gzcbl_t.gzcbl004,sfddseq.sfdd_t.sfddseq,l_sfdc001.sfdc_t.sfdc001,l_sfdc002.sfdc_t.sfdc002,l_sfdc003.sfdc_t.sfdc003,l_sfba002.sfba_t.sfba002,l_sfba002_desc.oocql_t.oocql004,l_sfba003.sfba_t.sfba003,l_sfba003_desc.oocql_t.oocql004,l_sfdc004.sfdc_t.sfdc004,l_sfdc004_imaal003.imaal_t.imaal003,l_sfdc004_imaal004.imaal_t.imaal004,l_sfdc007.sfdc_t.sfdc007,l_sfdc008.sfdc_t.sfdc008,l_sfdc006.sfdc_t.sfdc006,l_sfdc010.sfdc_t.sfdc010,l_sfdc011.sfdc_t.sfdc011,l_sfdc009.sfdc_t.sfdc009,l_sfdc015.sfdc_t.sfdc015,l_sfdc015_desc.oocql_t.oocql004,sfdd001.sfdd_t.sfdd001,l_sfdd001_imaal003.imaal_t.imaal003,l_sfdd001_imaal004.imaal_t.imaal004,sfdd013.sfdd_t.sfdd013,l_sfdd013_desc.type_t.chr100,sfdd003.sfdd_t.sfdd003,l_sfdd003_desc.inayl_t.inayl003,sfdd004.sfdd_t.sfdd004,l_sfdd004_desc.inab_t.inab003,sfdd005.sfdd_t.sfdd005,sfdd010.sfdd_t.sfdd010,l_sfdd007_sfdd012.sfdd_t.sfdd007,sfdd006.sfdd_t.sfdd006,l_sfdd009_sfdd012.sfdd_t.sfdd009,sfdd008.sfdd_t.sfdd008,sfdd002.sfdd_t.sfdd002,sfddseq1.sfdd_t.sfddseq1,l_imaa127_desc.type_t.chr30,l_sfdd003desc.type_t.chr100,l_sfdd004desc.type_t.chr100,l_sfdd013desc.type_t.chr200,l_imaa127desc.type_t.chr100" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="asfr316_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION asfr316_x01_ins_prep()
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
         
         #end add-point                  
 
 
      END CASE
   END FOR
END FUNCTION
 
{</section>}
 
{<section id="asfr316_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION asfr316_x01_sel_prep()
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
   LET g_select = " SELECT sfdddocno,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,sfddseq, 
       NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,sfdd001, 
       NULL,NULL,sfdd013,NULL,sfdd003,NULL,sfdd004,NULL,sfdd005,sfdd010,sfdd007,NULL,sfdd006,sfdd009, 
       NULL,sfdd008,sfdd012,sfdd002,sfddseq1,NULL,NULL,NULL,NULL,NULL"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   
   #end add-point
    LET g_from = " FROM sfdd_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET g_from = g_from CLIPPED,
                " LEFT JOIN sfdc_t ON sfdcent=sfddent AND sfdcdocno = sfdddocno AND sfdcseq=sfddseq ",
                " LEFT JOIN sfda_t ON sfdaent=sfddent AND sfdadocno = sfdddocno ",
                " LEFT JOIN imaa_t ON imaaent=sfddent AND imaa001 = sfdd001 ",
                " LEFT JOIN imae_t ON imaeent=sfddent AND imaesite=sfddsite AND imae001 = sfdd001 "
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   LET g_where = g_where CLIPPED," AND sfda002 NOT IN('16','26') "
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("sfdd_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE asfr316_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE asfr316_x01_curs CURSOR FOR asfr316_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="asfr316_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION asfr316_x01_ins_data()
DEFINE sr RECORD 
   sfdddocno LIKE sfdd_t.sfdddocno, 
   l_sfdadocdt LIKE sfda_t.sfdadocdt, 
   l_sfda001 LIKE sfda_t.sfda001, 
   l_sfda002 LIKE sfda_t.sfda002, 
   l_sfda002_desc LIKE gzcbl_t.gzcbl004, 
   l_sfda003 LIKE sfda_t.sfda003, 
   l_sfda003_desc LIKE ooefl_t.ooefl003, 
   l_sfda004 LIKE sfda_t.sfda004, 
   l_sfda004_desc LIKE ooag_t.ooag011, 
   l_sfda005 LIKE sfda_t.sfda005, 
   l_sfdastus LIKE sfda_t.sfdastus, 
   l_sfdastus_desc LIKE gzcbl_t.gzcbl004, 
   sfddseq LIKE sfdd_t.sfddseq, 
   l_sfdc001 LIKE sfdc_t.sfdc001, 
   l_sfdc002 LIKE sfdc_t.sfdc002, 
   l_sfdc003 LIKE sfdc_t.sfdc003, 
   l_sfba002 LIKE sfba_t.sfba002, 
   l_sfba002_desc LIKE oocql_t.oocql004, 
   l_sfba003 LIKE sfba_t.sfba003, 
   l_sfba003_desc LIKE oocql_t.oocql004, 
   l_sfdc004 LIKE sfdc_t.sfdc004, 
   l_sfdc004_imaal003 LIKE imaal_t.imaal003, 
   l_sfdc004_imaal004 LIKE imaal_t.imaal004, 
   l_sfdc007 LIKE sfdc_t.sfdc007, 
   l_sfdc008 LIKE sfdc_t.sfdc008, 
   l_sfdc006 LIKE sfdc_t.sfdc006, 
   l_sfdc010 LIKE sfdc_t.sfdc010, 
   l_sfdc011 LIKE sfdc_t.sfdc011, 
   l_sfdc009 LIKE sfdc_t.sfdc009, 
   l_sfdc015 LIKE sfdc_t.sfdc015, 
   l_sfdc015_desc LIKE oocql_t.oocql004, 
   sfdd001 LIKE sfdd_t.sfdd001, 
   l_sfdd001_imaal003 LIKE imaal_t.imaal003, 
   l_sfdd001_imaal004 LIKE imaal_t.imaal004, 
   sfdd013 LIKE sfdd_t.sfdd013, 
   l_sfdd013_desc LIKE type_t.chr100, 
   sfdd003 LIKE sfdd_t.sfdd003, 
   l_sfdd003_desc LIKE inayl_t.inayl003, 
   sfdd004 LIKE sfdd_t.sfdd004, 
   l_sfdd004_desc LIKE inab_t.inab003, 
   sfdd005 LIKE sfdd_t.sfdd005, 
   sfdd010 LIKE sfdd_t.sfdd010, 
   sfdd007 LIKE sfdd_t.sfdd007, 
   l_sfdd007_sfdd012 LIKE sfdd_t.sfdd007, 
   sfdd006 LIKE sfdd_t.sfdd006, 
   sfdd009 LIKE sfdd_t.sfdd009, 
   l_sfdd009_sfdd012 LIKE sfdd_t.sfdd009, 
   sfdd008 LIKE sfdd_t.sfdd008, 
   sfdd012 LIKE sfdd_t.sfdd012, 
   sfdd002 LIKE sfdd_t.sfdd002, 
   sfddseq1 LIKE sfdd_t.sfddseq1, 
   l_imaa127_desc LIKE type_t.chr30, 
   l_sfdd003desc LIKE type_t.chr100, 
   l_sfdd004desc LIKE type_t.chr100, 
   l_sfdd013desc LIKE type_t.chr200, 
   l_imaa127desc LIKE type_t.chr100
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_success  LIKE type_t.num5
DEFINE l_gzcbl004 LIKE gzcbl_t.gzcbl004  #ACC说明
DEFINE l_imaa127  LIKE imaa_t.imaa127    #系列  20150810 by dorislai add
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH asfr316_x01_curs INTO sr.*                               
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
       #发料单单头sfda_t
       SELECT sfdadocdt,sfda001,sfda002,sfda003,sfda004,sfda005,sfdastus
         INTO sr.l_sfdadocdt,sr.l_sfda001,sr.l_sfda002,sr.l_sfda003,sr.l_sfda004,sr.l_sfda005,sr.l_sfdastus
         FROM sfda_t
        WHERE sfdaent   = g_enterprise
          AND sfdadocno = sr.sfdddocno
       
       #发退料类别
       LET l_gzcbl004 = s_desc_gzcbl004_desc('4013',sr.l_sfda002)
       IF NOT cl_null(l_gzcbl004) THEN
          LET sr.l_sfda002_desc= sr.l_sfda002 CLIPPED,'.',l_gzcbl004
       ELSE
          LET sr.l_sfda002_desc= sr.l_sfda002
       END IF
       
       #部门名称
       LET sr.l_sfda003_desc = s_desc_get_department_desc(sr.l_sfda003)
       
       #申请人名称
       LET sr.l_sfda004_desc = s_desc_get_person_desc(sr.l_sfda004)
       
       #状态
       LET l_gzcbl004 = s_desc_gzcbl004_desc('13',sr.l_sfdastus)
       IF NOT cl_null(l_gzcbl004) THEN
          LET sr.l_sfdastus_desc= sr.l_sfdastus CLIPPED,'.',l_gzcbl004
       ELSE
          LET sr.l_sfdastus_desc= sr.l_sfdastus
       END IF
       
       #发料单需求单身sfdc_t
       SELECT sfdc001,sfdc002,sfdc003,sfba002,sfba003,
              sfdc004,imaal003,imaal004,sfdc007,sfdc008,
              sfdc006,sfdc010,sfdc011,sfdc009,sfdc015
         INTO sr.l_sfdc001,sr.l_sfdc002,sr.l_sfdc003,sr.l_sfba002,sr.l_sfba003,
              sr.l_sfdc004,sr.l_sfdc004_imaal003,sr.l_sfdc004_imaal004,sr.l_sfdc007,sr.l_sfdc008,
              sr.l_sfdc006,sr.l_sfdc010,sr.l_sfdc011,sr.l_sfdc009,sr.l_sfdc015
         FROM sfdc_t LEFT JOIN sfba_t ON sfbaent=sfdcent AND sfbadocno=sfdc001 AND sfbaseq=sfdc002 AND sfbaseq1=sfdc003
                     LEFT JOIN imaal_t ON imaalent=g_enterprise AND imaal001=sfdc004 AND imaal002=g_dlang
        WHERE sfdcent   = g_enterprise
          AND sfdcdocno = sr.sfdddocno
          AND sfdcseq   = sr.sfddseq
       
       #部位名称
       LET sr.l_sfba002_desc =  s_desc_get_acc_desc('215',sr.l_sfba002)

       #作业说明
       LET sr.l_sfba003_desc =  s_desc_get_acc_desc('221',sr.l_sfba003)
       
       #理由码说明
       LET sr.l_sfdc015_desc =  s_desc_get_acc_desc('226',sr.l_sfdc015)
       
       #发退料料号品名、规格
       CALL s_desc_get_item_desc(sr.sfdd001) RETURNING sr.l_sfdd001_imaal003,sr.l_sfdd001_imaal004

       #产品特征说明
       CALL s_feature_description(sr.sfdd001,sr.sfdd013) RETURNING l_success,sr.l_sfdd013_desc
       #----dorislai-20150810-add----(S)
       LET sr.l_sfdd013desc = ''
       IF NOT cl_null(sr.l_sfdd013_desc) THEN
          LET sr.l_sfdd013desc = sr.sfdd003,'.',sr.l_sfdd013_desc
       END IF
       #----dorislai-20150810-add----(E)
       #库位名称
       CALL s_desc_get_stock_desc(g_site,sr.sfdd003) RETURNING sr.l_sfdd003_desc
       #----dorislai-20150810-add----(S)
       LET sr.l_sfdd003desc = ''
       IF NOT cl_null(sr.l_sfdd003_desc) THEN
          LET sr.l_sfdd003desc = sr.sfdd003,'.',sr.l_sfdd003_desc
       END IF
       #----dorislai-20150810-add----(E)
       #储位名称
       CALL s_desc_get_locator_desc(g_site,sr.sfdd003,sr.sfdd004) RETURNING sr.l_sfdd004_desc
       #----dorislai-20150810-add----(S)
       LET sr.l_sfdd004desc = ''
       IF NOT cl_null(sr.l_sfdd004_desc) THEN
          LET sr.l_sfdd004desc = sr.sfdd004,'.',sr.l_sfdd004_desc
       END IF
       #系列
       LET sr.l_imaa127_desc = ''
       LET sr.l_imaa127desc = ''
          #用料號抓取系列
       SELECT imaa127 INTO l_imaa127 FROM imaa_t
        WHERE imaa001 = sr.sfdd001
          AND imaaent = g_enterprise
         #抓取系列說明
       CALL s_desc_get_acc_desc('2003',l_imaa127)  RETURNING sr.l_imaa127_desc 
       IF NOT cl_null(sr.l_imaa127_desc) THEN
          LET sr.l_imaa127desc = l_imaa127,'.',sr.l_imaa127_desc
       END IF
       #----dorislai-20150810-add----(E)
       #数量
       LET sr.l_sfdd007_sfdd012 = sr.sfdd007 * sr.sfdd012
       LET sr.l_sfdd009_sfdd012 = sr.sfdd009 * sr.sfdd012
       
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.sfdddocno,sr.l_sfdadocdt,sr.l_sfda001,sr.l_sfda002,sr.l_sfda002_desc,sr.l_sfda003,sr.l_sfda003_desc,sr.l_sfda004,sr.l_sfda004_desc,sr.l_sfda005,sr.l_sfdastus,sr.l_sfdastus_desc,sr.sfddseq,sr.l_sfdc001,sr.l_sfdc002,sr.l_sfdc003,sr.l_sfba002,sr.l_sfba002_desc,sr.l_sfba003,sr.l_sfba003_desc,sr.l_sfdc004,sr.l_sfdc004_imaal003,sr.l_sfdc004_imaal004,sr.l_sfdc007,sr.l_sfdc008,sr.l_sfdc006,sr.l_sfdc010,sr.l_sfdc011,sr.l_sfdc009,sr.l_sfdc015,sr.l_sfdc015_desc,sr.sfdd001,sr.l_sfdd001_imaal003,sr.l_sfdd001_imaal004,sr.sfdd013,sr.l_sfdd013_desc,sr.sfdd003,sr.l_sfdd003_desc,sr.sfdd004,sr.l_sfdd004_desc,sr.sfdd005,sr.sfdd010,sr.l_sfdd007_sfdd012,sr.sfdd006,sr.l_sfdd009_sfdd012,sr.sfdd008,sr.sfdd002,sr.sfddseq1,sr.l_imaa127_desc,sr.l_sfdd003desc,sr.l_sfdd004desc,sr.l_sfdd013desc,sr.l_imaa127desc
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "asfr316_x01_execute"
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
 
{<section id="asfr316_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION asfr316_x01_rep_data()
#add-point:rep_data.define (客製用) name="rep_data.define_customerization"

#end add-point:rep_data.define
#add-point:rep_data.define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="rep_data.define"

#end add-point:rep_data.define
 
    #add-point:rep_data.before name="rep_data.before"
    #动态隐藏
    IF g_ref_unit = 'N' THEN  #不使用参考单位
       LET g_xgrid.visible_column = "l_sfdd009_sfdd012|sfdd008"
    END IF
    #end add-point:rep_data.before
    
    CALL cl_xg_view()
    #add-point:rep_data.after name="rep_data.after"
    
    #end add-point:rep_data.after
END FUNCTION
 
{</section>}
 
{<section id="asfr316_x01.other_function" readonly="Y" >}

 
{</section>}
 
