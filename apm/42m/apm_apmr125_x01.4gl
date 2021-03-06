#該程式未解開Section, 採用最新樣板產出!
{<section id="apmr125_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2015-11-16 16:35:55), PR版次:0003(2015-11-16 16:37:29)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000060
#+ Filename...: apmr125_x01
#+ Description: ...
#+ Creator....: 05423(2014-10-29 09:32:55)
#+ Modifier...: 07024 -SD/PR- 07024
 
{</section>}
 
{<section id="apmr125_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"

#end add-point
#add-point:填寫註解說明 name="global.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="global.import"
#151106-00004#11 by Dorislai 改善效能，將ins_data中的資料，寫入sel_prep的sql中
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
 
{<section id="apmr125_x01.main" readonly="Y" >}
PUBLIC FUNCTION apmr125_x01(p_arg1)
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
   LET g_rep_code = "apmr125_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL apmr125_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL apmr125_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL apmr125_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL apmr125_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL apmr125_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="apmr125_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION apmr125_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "pmar001.pmar_t.pmar001,l_pmar001_desc.type_t.chr500,l_pmar001_pmaal004.type_t.chr1000,pmaa003.pmaa_t.pmaa003,pmaa080.pmaa_t.pmaa080,l_pmaa080_desc.type_t.chr30,l_pmaa080_oocql004.type_t.chr1000,pmar002.pmar_t.pmar002,imaal_t_imaal003.imaal_t.imaal003,imaal_t_imaal004.imaal_t.imaal004,pmar003.pmar_t.pmar003,l_pmar003_desc.type_t.chr50,l_pmar003_desc1.type_t.chr1000,imaa_t_imaa009.imaa_t.imaa009,l_imaa009_desc.type_t.chr30,l_imaa127_desc.type_t.chr100,pmar000.pmar_t.pmar000,pmar004.pmar_t.pmar004,pmar005.pmar_t.pmar005,pmar006.pmar_t.pmar006,l_pmar006_desc.type_t.chr30,pmar007.pmar_t.pmar007,l_pmar007_desc.type_t.chr30,l_pmar007_ooail003.type_t.chr1000,pmar008.pmar_t.pmar008,pmar009.pmar_t.pmar009,l_pmar009_desc.type_t.chr30,l_pmar009_oodbl004.type_t.chr1000,pmar011.pmar_t.pmar011,pmar010.pmar_t.pmar010,pmar012.pmar_t.pmar012,pmar013.pmar_t.pmar013,pmar014.pmar_t.pmar014,l_pmar014_desc.type_t.chr30,pmar015.pmar_t.pmar015,pmar016.pmar_t.pmar016,pmar017.pmar_t.pmar017,pmar018.pmar_t.pmar018,pmar019.pmar_t.pmar019,pmar020.pmar_t.pmar020,l_pmar020_desc.type_t.chr30,l_pmar020_oodbl004.type_t.chr1000" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="apmr125_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION apmr125_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="apmr125_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apmr125_x01_sel_prep()
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
   #151106-00004#11-mod-(S)
#   LET g_select = " SELECT pmar001,(trim(pmar_t.pmar001)||'.'||trim(pmaal_t.pmaal004)),pmaa003,pmaa080,NULL,pmar002,imaal_t.imaal003,imaal_t.imaal004, 
#       pmar003,imaa_t.imaa009,rtaxl003,NULL,NULL,pmar000,pmar004,pmar005,pmar006,NULL,pmar007,NULL,pmar008,pmar009,oodbl004,pmar011,pmar010,pmar012, 
#       pmar013,pmar014,NULL,pmar015,pmar016,pmar017,pmar018,pmar019,pmar020, 
#       NULL,NULL,NULL,NULL,NULL,NULL,NULL"
   LET g_select = " SELECT pmar001,pmaal004,",
                  " CASE WHEN pmaal004 IS NULL THEN pmar001 ELSE trim(pmar001)||'.'||trim(pmaal004) END ,",
                  " pmaa003,pmaa080,A1.oocql004,",
                  " CASE WHEN A1.oocql004 IS NULL THEN pmaa080 ELSE trim(pmaa080)||'.'||trim(A1.oocql004) END ,",
                  " pmar002,imaal_t.imaal003,imaal_t.imaal004,pmar003,NULL,NULL,imaa_t.imaa009,rtaxl003,imaa127,",
                  " CASE WHEN A2.oocql004 IS NULL THEN imaa127 ELSE trim(imaa127)||'.'||trim(A2.oocql004) END ,",
                  " pmar000,pmar004,pmar005,pmar006,",
                  " CASE WHEN U1.oocal003 IS NULL THEN pmar006 ELSE trim(pmar006)||'.'||trim(U1.oocal003) END ,",
                  " pmar007,ooail003,",
                  " CASE WHEN ooail003 IS NULL THEN pmar007 ELSE trim(pmar007)||'.'||trim(ooail003) END ,",
                  " pmar008,pmar009,oodbl004,",
                  " CASE WHEN oodbl004 IS NULL THEN pmar009 ELSE trim(pmar009)||'.'||trim(oodbl004) END ,",
                  " pmar011/100,pmar010,pmar012,pmar013,pmar014,",
                  " CASE WHEN U2.oocal003 IS NULL THEN pmar014 ELSE trim(pmar014)||'.'||trim(U2.oocal003) END ,",
                  " pmar015,pmar016,pmar017,pmar018,pmar019,pmar020,ooag011,",
                  " CASE WHEN ooag011 IS NULL THEN pmar020 ELSE trim(pmar020)||'.'||trim(ooag011) END "
   #151106-00004#11-mod-(E)
#   #end add-point
#   LET g_select = " SELECT pmar001,NULL,NULL,pmaa003,pmaa080,NULL,NULL,pmar002,imaal_t.imaal003,imaal_t.imaal004, 
#       pmar003,NULL,NULL,imaa_t.imaa009,NULL,NULL,NULL,pmar000,pmar004,pmar005,pmar006,NULL,pmar007, 
#       NULL,NULL,pmar008,pmar009,NULL,NULL,pmar011,pmar010,pmar012,pmar013,pmar014,NULL,pmar015,pmar016, 
#       pmar017,pmar018,pmar019,pmar020,NULL,NULL"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   #151106-00004#11-modify-(S)
#   LET g_from = " FROM pmar_t LEFT OUTER JOIN pmaa_t ON pmar001 = pmaa001 AND pmarent = pmaaent ",
#                "             LEFT OUTER JOIN imaa_t ON pmar002 = imaa001 AND pmarent = imaaent ",
#                "             LEFT OUTER JOIN ooef_t ON ooef001 = pmarsite AND ooefent = pmarent ",
#                "             LEFT OUTER JOIN imaal_t ON imaal001 = pmar002 AND imaalent = pmarent AND imaal002 = '",g_dlang,"' ",
#                "             LEFT OUTER JOIN pmaal_t ON pmar001 = pmaal001 AND pmarent = pmaalent AND pmaal002 = '",g_dlang,"' ",
#                "             LEFT OUTER JOIN rtaxl_t ON rtaxl001 = imaa009 AND rtaxlent = imaaent AND rtaxl002 = '",g_dlang,"' ",
#                "             LEFT OUTER JOIN oodbl_t ON oodbl001 = ooef019 AND oodbl002 = pmar009 AND oodblent = pmarent AND oodbl003 = '",g_dlang,"' "
   LET g_from = " FROM pmar_t LEFT OUTER JOIN pmaa_t ON pmar001 = pmaa001 AND pmarent = pmaaent ",
                 "             LEFT OUTER JOIN imaa_t ON pmar002 = imaa001 AND pmarent = imaaent ",
                 "             LEFT OUTER JOIN ooef_t ON ooef001 = pmarsite AND ooefent = pmarent ",
                 "             LEFT OUTER JOIN imaal_t ON imaal001 = pmar002 AND imaalent = pmarent AND imaal002 = '",g_dlang,"' ",
                 "             LEFT OUTER JOIN pmaal_t ON pmar001 = pmaal001 AND pmarent = pmaalent AND pmaal002 = '",g_dlang,"' ",
                 "             LEFT OUTER JOIN rtaxl_t ON rtaxl001 = imaa009 AND rtaxlent = imaaent AND rtaxl002 = '",g_dlang,"' ",
                 "             LEFT OUTER JOIN oodbl_t ON oodbl001 = ooef019 AND oodbl002 = pmar009 AND oodblent = pmarent AND oodbl003 = '",g_dlang,"' ",
                 "             LEFT OUTER JOIN ooail_t D1 ON ooailent=pmarent AND ooail001=pmar007 AND ooail002='",g_dlang,"'",
                 "             LEFT OUTER JOIN ooag_t ON ooagent=pmarent AND ooag001=pmar020 ",
                 #ACC
                 "             LEFT OUTER JOIN oocql_t A1 ON A1.oocql001='251' AND A1.oocql002=pmaa080 AND A1.oocqlent=pmaaent AND A1.oocql003='",g_dlang,"'",
                 "             LEFT OUTER JOIN oocql_t A2 ON A2.oocql001='2003' AND A2.oocql002=imaa127 AND A2.oocqlent=imaaent AND A2.oocql003='",g_dlang,"'",
                 #Unit
                 "             LEFT OUTER JOIN oocal_t U1 ON U1.oocalent=pmarent AND U1.oocal001=pmar006 AND U1.oocal002='",g_dlang,"'",
                 "             LEFT OUTER JOIN oocal_t U2 ON U2.oocalent=pmarent AND U2.oocal001=pmar014 AND U2.oocal002='",g_dlang,"'"
   #151106-00004#11-modify-(E)             

#   #end add-point
#    LET g_from = " FROM pmar_t,pmaa_t,imaa_t,imaal_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("pmar_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE apmr125_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE apmr125_x01_curs CURSOR FOR apmr125_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="apmr125_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION apmr125_x01_ins_data()
DEFINE sr RECORD 
   pmar001 LIKE pmar_t.pmar001, 
   l_pmar001_desc LIKE type_t.chr500, 
   l_pmar001_pmaal004 LIKE type_t.chr1000, 
   pmaa003 LIKE pmaa_t.pmaa003, 
   pmaa080 LIKE pmaa_t.pmaa080, 
   l_pmaa080_desc LIKE type_t.chr30, 
   l_pmaa080_oocql004 LIKE type_t.chr1000, 
   pmar002 LIKE pmar_t.pmar002, 
   imaal_t_imaal003 LIKE imaal_t.imaal003, 
   imaal_t_imaal004 LIKE imaal_t.imaal004, 
   pmar003 LIKE pmar_t.pmar003, 
   l_pmar003_desc LIKE type_t.chr50, 
   l_pmar003_desc1 LIKE type_t.chr1000, 
   imaa_t_imaa009 LIKE imaa_t.imaa009, 
   l_imaa009_desc LIKE type_t.chr30, 
   l_imaa127 LIKE type_t.chr30, 
   l_imaa127_desc LIKE type_t.chr100, 
   pmar000 LIKE pmar_t.pmar000, 
   pmar004 LIKE pmar_t.pmar004, 
   pmar005 LIKE pmar_t.pmar005, 
   pmar006 LIKE pmar_t.pmar006, 
   l_pmar006_desc LIKE type_t.chr30, 
   pmar007 LIKE pmar_t.pmar007, 
   l_pmar007_desc LIKE type_t.chr30, 
   l_pmar007_ooail003 LIKE type_t.chr1000, 
   pmar008 LIKE pmar_t.pmar008, 
   pmar009 LIKE pmar_t.pmar009, 
   l_pmar009_desc LIKE type_t.chr30, 
   l_pmar009_oodbl004 LIKE type_t.chr1000, 
   pmar011 LIKE pmar_t.pmar011, 
   pmar010 LIKE pmar_t.pmar010, 
   pmar012 LIKE pmar_t.pmar012, 
   pmar013 LIKE pmar_t.pmar013, 
   pmar014 LIKE pmar_t.pmar014, 
   l_pmar014_desc LIKE type_t.chr30, 
   pmar015 LIKE pmar_t.pmar015, 
   pmar016 LIKE pmar_t.pmar016, 
   pmar017 LIKE pmar_t.pmar017, 
   pmar018 LIKE pmar_t.pmar018, 
   pmar019 LIKE pmar_t.pmar019, 
   pmar020 LIKE pmar_t.pmar020, 
   l_pmar020_desc LIKE type_t.chr30, 
   l_pmar020_oodbl004 LIKE type_t.chr1000
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_ooef019      LIKE  ooef_t.ooef019  #稅區 20150805 by dorislai add
DEFINE l_success      LIKE  type_t.num5     #20150805 by dorislai add
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH apmr125_x01_curs INTO sr.*                               
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
    #151106-00004#11-mark----(S)
#       IF NOT cl_null(sr.pmaa080) THEN
#         CALL apmr125_x01_desc('1','251',sr.pmaa080) RETURNING sr.l_pmaa080_desc
#       END IF
#       IF NOT cl_null(sr.pmar006) THEN
#         CALL apmr125_x01_desc('2','',sr.pmar006) RETURNING sr.l_pmar006_desc
#         LET sr.l_pmar006_desc = sr.pmar006,".",sr.l_pmar006_desc
#       END IF
#       IF NOT cl_null(sr.pmar007) THEN
#         CALL apmr125_x01_desc('3','',sr.pmar007) RETURNING sr.l_pmar007_desc
#         LET sr.l_pmar007_desc = sr.pmar007,".",sr.l_pmar007_desc
#       END IF
#       IF NOT cl_null(sr.pmar014) THEN
#         CALL apmr125_x01_desc('2','',sr.pmar014) RETURNING sr.l_pmar014_desc
#         LET sr.l_pmar014_desc = sr.pmar014,".",sr.l_pmar014_desc
#       END IF
#       #dorislai-20150805-add----(S)
#       #供應商編號說明 l_pmar001_ref	
#       LET sr.l_pmar001_ref = ''
#       SELECT pmaal004 INTO sr.l_pmar001_ref FROM pmaal_t 
#        WHERE pmaalent = g_enterprise AND pmaal001 = sr.pmar001 AND pmaal002 = g_dlang
    #151106-00004#11-mark----(E)
       #產品特徵說明 l_pmar003_desc		
       LET sr.l_pmar003_desc = ''
       LET sr.l_pmar003_desc1 = ''
       CALL s_feature_description(sr.pmar002,sr.pmar003) RETURNING l_success,sr.l_pmar003_desc
       IF NOT cl_null(sr.l_pmar003_desc) THEN
          LET sr.l_pmar003_desc1 = sr.pmar003,'.',sr.l_pmar003_desc
       END IF
    #151106-00004#11-mark----(S)
#       #幣別說明 l_pmar007_ref
#       LET sr.l_pmar007_ref = ''
#       SELECT ooail003 INTO sr.l_pmar007_ref FROM ooail_t 
#        WHERE ooailent = g_enterprise AND ooail001 = sr.pmar007 AND ooail002 = g_dlang
#       #稅別說明 l_pmar009_desc		
#       #----先抓稅區
#       LET l_ooef019 = ''
#       SELECT ooef019 INTO l_ooef019 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
#       #----在抓稅別
#       LET sr.l_pmar009_desc = ''
#       LET sr.l_pmar009desc = ''
#       SELECT oodbl004 INTO sr.l_pmar009_desc FROM oodbl_t 
#        WHERE oodblent = g_enterprise AND oodbl001 = l_ooef019 
#          AND oodbl002 = sr.pmar009 AND oodbl003 = g_dlang 
#       IF NOT cl_null(sr.l_pmar009_desc) THEN
#          LET sr.l_pmar009desc = sr.pmar009,'.',sr.l_pmar009_desc
#       END IF
#       #最近異動人員說明 l_pmar020_desc		
#       LET sr.l_pmar020_desc = ''
#       LET sr.l_pmar020desc = ''
#       SELECT ooag011 INTO sr.l_pmar020_desc FROM ooag_t 
#        WHERE ooagent = g_enterprise AND ooag001 = sr.pmar020 
#       IF NOT cl_null(sr.l_pmar020_desc) THEN
#          LET sr.l_pmar020desc = sr.pmar020,'.',sr.l_pmar020_desc
#       END IF
       #系列說明 l_imaa127_desc		
#       LET sr.l_imaa127_desc = ''
#       LET sr.l_imaa127desc = ''
#       #----用料號抓取系列
#       SELECT imaa127 INTO sr.l_imaa127 FROM imaa_t
#        WHERE imaa001 = sr.pmar002
#          AND imaaent = g_enterprise
#       #----抓取系列說明
#       CALL s_desc_get_acc_desc('2003',sr.l_imaa127)  RETURNING sr.l_imaa127_desc 
#       IF NOT cl_null(sr.l_imaa127_desc) THEN
#          LET sr.l_imaa127desc = sr.l_imaa127,'.',sr.l_imaa127_desc
#       END IF
       #dorislai-20150805-add----(E)
    #151106-00004#11-mark----(E)
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.pmar001,sr.l_pmar001_desc,sr.l_pmar001_pmaal004,sr.pmaa003,sr.pmaa080,sr.l_pmaa080_desc,sr.l_pmaa080_oocql004,sr.pmar002,sr.imaal_t_imaal003,sr.imaal_t_imaal004,sr.pmar003,sr.l_pmar003_desc,sr.l_pmar003_desc1,sr.imaa_t_imaa009,sr.l_imaa009_desc,sr.l_imaa127_desc,sr.pmar000,sr.pmar004,sr.pmar005,sr.pmar006,sr.l_pmar006_desc,sr.pmar007,sr.l_pmar007_desc,sr.l_pmar007_ooail003,sr.pmar008,sr.pmar009,sr.l_pmar009_desc,sr.l_pmar009_oodbl004,sr.pmar011,sr.pmar010,sr.pmar012,sr.pmar013,sr.pmar014,sr.l_pmar014_desc,sr.pmar015,sr.pmar016,sr.pmar017,sr.pmar018,sr.pmar019,sr.pmar020,sr.l_pmar020_desc,sr.l_pmar020_oodbl004
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "apmr125_x01_execute"
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
 
{<section id="apmr125_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION apmr125_x01_rep_data()
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
 
{<section id="apmr125_x01.other_function" readonly="Y" >}
#1.oocql004
#2.單位
#3.幣別
PRIVATE FUNCTION apmr125_x01_desc(p_type,p_num,p_target)
   DEFINE p_type   LIKE type_t.num5
   DEFINE p_num    LIKE type_t.num5
   DEFINE p_target LIKE type_t.chr10
   DEFINE r_desc   LIKE type_t.chr500

   CASE p_type
   WHEN '1' #GET oocql004
         SELECT oocql004 INTO r_desc
           FROM oocql_t
          WHERE oocql001 = p_num
            AND oocql002 = p_target
            AND oocql003 = g_dlang
            AND oocqlent = g_enterprise
   WHEN '2' #GET oocal003
         SELECT oocal003 INTO r_desc
           FROM oocal_t
          WHERE oocal001 = p_target
            AND oocal002 = g_dlang
            AND oocalent = g_enterprise
   WHEN '3' #GET ooail003
         SELECT ooail003 INTO r_desc
           FROM ooail_t
          WHERE ooail001 = p_target
            AND ooail002 = g_dlang
            AND ooailent = g_enterprise
   END CASE 
   
   RETURN r_desc
END FUNCTION

 
{</section>}
 
