#該程式未解開Section, 採用最新樣板產出!
{<section id="ainr332_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:6(2016-09-07 16:53:46), PR版次:0006(2016-09-07 17:05:46)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000058
#+ Filename...: ainr332_x01
#+ Description: ...
#+ Creator....: 05423(2015-02-10 17:05:48)
#+ Modifier...: 08172 -SD/PR- 08172
 
{</section>}
 
{<section id="ainr332_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#160505-00014#6  2016/05/06 By xianghui 效能优化
#160905-00007#4   2016/09/05  by 08172       调整系统中无ENT的SQL条件增加ent
#160906-00031#1   2016/09/06  by 08172       调整oocql001
#160907-00047#1   2016/09/07  by 08172       inda108_desc取值逻辑修改
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
 
{<section id="ainr332_x01.main" readonly="Y" >}
PUBLIC FUNCTION ainr332_x01(p_arg1)
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
   LET g_rep_code = "ainr332_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL ainr332_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL ainr332_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL ainr332_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL ainr332_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL ainr332_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="ainr332_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION ainr332_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "indcdocno.indc_t.indcdocno,indcdocdt.indc_t.indcdocdt,indc022.indc_t.indc022,l_indc000_desc.gzcbl_t.gzcbl004,indc006.indc_t.indc006,l_indc006_desc.ooefl_t.ooefl004,indc004.indc_t.indc004,l_indc004_desc.ooag_t.ooag011,indc101.indc_t.indc101,l_indc101_desc.ooefl_t.ooefl004,l_indcstus_desc.gzcbl_t.gzcbl004,l_indc102_desc.gzcbl_t.gzcbl004,indc007.indc_t.indc007,l_indc007_desc.inayl_t.inayl003,indc109.indc_t.indc109,l_indc109_desc.inayl_t.inayl003,inddseq.indd_t.inddseq,indd002.indd_t.indd002,l_imaal003.imaal_t.imaal003,l_imaal004.imaal_t.imaal004,indd004.indd_t.indd004,l_indd004_desc.oocql_t.oocql004,indd022.indd_t.indd022,l_indd022_desc.inayl_t.inayl003,indd023.indd_t.indd023,l_indd023_desc.inab_t.inab003,indd024.indd_t.indd024,indd102.indd_t.indd102,indd006.indd_t.indd006,indd103.indd_t.indd103,indd104.indd_t.indd104,indd105.indd_t.indd105,indd151.indd_t.indd151,l_indd151_desc.oocql_t.oocql004,indd032.indd_t.indd032,l_indd032_desc.inayl_t.inayl003,indd033.indd_t.indd033,l_indd033_desc.inab_t.inab003,indd041.indd_t.indd041,indd031.indd_t.indd031,indd108.indd_t.indd108,indc002.indc_t.indc002,indc003.indc_t.indc003,indc008.indc_t.indc008,indc009.indc_t.indc009,indc103.indc_t.indc103,indc104.indc_t.indc104,indc105.indc_t.indc105,indc106.indc_t.indc106,indc107.indc_t.indc107,indc108.indc_t.indc108,indc151.indc_t.indc151,indd001.indd_t.indd001,indd021.indd_t.indd021,indd040.indd_t.indd040,indd042.indd_t.indd042,indd043.indd_t.indd043,indd044.indd_t.indd044,indd101.indd_t.indd101,indd106.indd_t.indd106,indd109.indd_t.indd109,indd152.indd_t.indd152,l_indc105_desc.type_t.chr30,l_indc106_desc.type_t.chr30,l_indc107_desc.type_t.chr30,l_indc108_desc.type_t.chr30,l_indc151_desc.type_t.chr30,l_address.type_t.chr300,l_indd042_desc.type_t.chr30,l_indd043_desc.type_t.chr30,l_indd044_desc.type_t.chr30,l_imaa127_desc.type_t.chr30,l_indc006desc.type_t.chr50,l_indc105desc.type_t.chr50,l_indc106desc.type_t.chr50,l_indc107desc.type_t.chr50,l_indc108desc.type_t.chr50,l_indc151desc.type_t.chr50,l_indd004desc.type_t.chr50,l_indd022desc.type_t.chr50,l_indd023desc.type_t.chr50,l_indd032desc.type_t.chr50,l_indd033desc.type_t.chr50,l_indd042desc.type_t.chr50,l_indd043desc.type_t.chr50,l_indd044desc.type_t.chr50,l_indd151desc.type_t.chr50,l_imaa127desc.type_t.chr50,l_indcdocno_desc.type_t.chr30,l_indc002_desc.type_t.chr30,l_indcdocnodesc.type_t.chr50,l_indcstusdesc.type_t.chr50,l_indc004desc.type_t.chr50,l_indc101desc.type_t.chr50,l_indc002desc.type_t.chr50,l_indc102desc.type_t.chr50" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="ainr332_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION ainr332_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?, 
             ?,?)"
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
 
{<section id="ainr332_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION ainr332_x01_sel_prep()
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
   #doirlsai-20150724-modify----(S)
#   LET g_select = " SELECT indcdocno,indcdocdt,indc022,indc000,NULL,indc006,NULL,indc004,NULL,indc101, 
#       NULL,indcstus,NULL,indc102,NULL,indc007,NULL,indc109,NULL,inddseq,indd002,imaal003,imaal004,indd004,NULL, 
#       indd022,NULL,indd023,NULL,indd024,indd102,indd006,indd103,indd104,indd105,indd151,NULL,indd032, 
#       NULL,indd033,NULL,indd041,indd031,indd108"
   #160505-00014#6---mod---begin
   #LET g_select = " SELECT indcdocno,indcdocdt,indc022,indc000,NULL,indc006,NULL,indc004,NULL,indc101, 
   #    NULL,indcstus,NULL,indc102,NULL,indc007,NULL,indc109,NULL,inddseq,indd002,imaal003,imaal004,indd004,NULL, 
   #    indd022,NULL,indd023,NULL,indd024,indd102,indd006,indd103,indd104,indd105,indd151,NULL,indd032, 
   #    NULL,indd033,NULL,indd041,indd031,indd108,indc002,indc003,indc008,indc009,indc103,indc104,indc105, 
   #    indc106,indc107,indc108,indc151,indd001,indd021,indd040,indd042,indd043,indd044,indd101,indd106, 
   #    indd109,indd152,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 
   #    NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL"
           
   LET g_select = " SELECT indcdocno,indcdocdt,indc022,
                    indc000,(SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '2083' AND gzcbl002 = indc000 AND gzcbl003 = '",g_dlang,"') indc000_desc,
                    indc006,(SELECT ooefl003 FROM ooefl_t WHERE ooeflent = indcent AND ooefl001 = indc006  AND ooefl002 = '",g_dlang,"') indc006_desc,
                    indc004,(SELECT ooag011 FROM ooag_t WHERE ooagent = indcent AND ooag001 = indc004 ) indc004_desc,
                    indc101,(SELECT ooefl003 FROM ooefl_t WHERE ooeflent = indcent AND ooefl001 = indc101  AND ooefl002 = '",g_dlang,"') indc101_desc,
                    indcstus,(SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '13' AND gzcbl002 = indcstus AND gzcbl003 = '",g_dlang,"') indcstus_desc,
                    indc102,(SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '2081' AND gzcbl002 = indc102 AND gzcbl003 = '",g_dlang,"') indc102_desc,
                    indc007,(SELECT inayl003 FROM inayl_t WHERE inaylent = indcent AND inayl001 = indc007 AND inayl002 = '",g_dlang,"') indc007_desc,
                    indc109,(SELECT inayl003 FROM inayl_t WHERE inaylent = indcent AND inayl001 = indc109 AND inayl002 = '",g_dlang,"') indc109_desc,
                    inddseq,
                    indd002,
                    (SELECT imaal003 FROM imaal_t WHERE imaalent = inddent AND imaal001 = indd002 AND imaal002 = '",g_dlang,"') imaal003,
                    (SELECT imaal004 FROM imaal_t WHERE imaalent = inddent AND imaal001 = indd002 AND imaal002 = '",g_dlang,"') imaal004,
                    indd004,(SELECT inaml004 FROM inaml_t WHERE inamlent = inddent AND inaml001 = indd002 AND inaml002 = indd004 AND inaml003 = '",g_dlang,"') indd004_desc, 
                    indd022,(SELECT inayl003 FROM inayl_t WHERE inaylent = inddent AND inayl001 = indd022 AND inayl002 = '",g_dlang,"') indd022_desc,
                    indd023,(SELECT inab003 FROM inab_t WHERE inabent = inddent AND inabsite = inddsite AND inab001 = indd022 AND inab002 = indd023) indd023_desc,
                    indd024,indd102,indd006,indd103,indd104,indd105,
                    indd151,(SELECT oocql004 FROM oocql_t WHERE oocqlent = inddent AND oocql001 = '303' AND oocql002 = indd151 AND oocql003 = '",g_dlang,"') indd151_desc,
                    indd032,(SELECT inayl003 FROM inayl_t WHERE inaylent = inddent AND inayl001 = indd032 AND inayl002 = '",g_dlang,"') indd032_desc,
                    indd033,(SELECT inab003 FROM inab_t WHERE inabent = inddent AND inabsite = inddsite AND inab001 = indd032 AND inab002 = indd033) indd033_desc,
                    indd041,indd031,indd108,indc002,indc003,indc008,indc009,indc103,indc104,indc105, 
                    indc106,indc107,indc108,indc151,indd001,indd021,indd040,indd042,indd043,indd044,indd101,indd106, 
                    indd109,indd152,
                    (SELECT oofb011 FROM oofa_t,oofb_t WHERE oofaent = oofbent AND oofa002 ='2' AND oofb002 = oofa001  AND oofbent = indcent AND oofb019 = indc105) indc105_desc,
                    (SELECT oocql004 FROM oocql_t WHERE oocqlent = indcent AND oocql001 = '263' AND oocql002 = indc106 AND oocql003 = '",g_dlang,"') indc106_desc,
                    NULL indc107_desc,
                    NULL indc108_desc,
                    (SELECT oocql004 FROM oocql_t WHERE oocqlent = indcent AND oocql001 = '303' AND oocql002 = indc151 AND oocql003 = '",g_dlang,"') indc151_desc,
                    NULL l_address,
                    COALESCE((SELECT pjabl003 FROM pjabl_t WHERE pjablent = inddent AND pjabl001 = indd042 AND pjabl002 = '",g_dlang,"'),(SELECT pjbal003 FROM pjbal_t WHERE pjbalent = inddent AND pjbal001 = indd042 AND pjbal002 = '",g_dlang,"')) indd042_desc,
                    (SELECT pjbbl004 FROM pjbbl_t WHERE pjbblent = inddent AND pjbbl001 = indd042 AND pjbbl002 = indd043 AND pjbbl003 = '",g_dlang,"') indd043_desc,
                    (SELECT pjbml004 FROM pjbml_t WHERE pjbmlent = inddent AND pjbml001 = indd042 AND pjbml002 = indd044 AND pjbml003 = '",g_dlang,"') indd044_desc,
                    (SELECT oocql004 FROM oocql_t,imaa_t WHERE oocqlent = imaaent AND oocql001 = '2003' AND oocql002 = imaa127 AND imaaent = inddent AND imaa001 = indd002 AND oocql003 = '",g_dlang,"') imaa127_desc,
                    NULL indc006desc,
                    NULL indc105desc,
                    NULL indc106desc,
                    NULL indc107desc,
                    NULL indc108desc,
                    NULL indc151desc, 
                    NULL indd004desc,
                    NULL indd022desc,
                    NULL indd023desc,
                    NULL indd032desc,
                    NULL indd033desc,
                    NULL indd042desc,
                    NULL indd043desc,
                    NULL indd044desc,
                    NULL indd151desc,
                    NULL imaa127desc,
                    NULL indcdocno_desc,
                    (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '6016' AND gzcbl002 = indc002 AND gzcbl003 = '",g_dlang,"' ) indc002_desc,
                    NULL indcdocnodesc,
                    NULL indcstusdesc,
                    NULL indc004desc,
                    NULL indc101desc,
                    NULL indc002desc,
                    NULL indc102desc"       
   #doirlsai-20150724-modify----(E)
   #160505-00014#6---mod---end

#   #end add-point
#   LET g_select = " SELECT indcdocno,indcdocdt,indc022,indc000,NULL,indc006,NULL,indc004,NULL,indc101, 
#       NULL,indcstus,NULL,indc102,NULL,indc007,NULL,indc109,NULL,inddseq,indd002,NULL,NULL,indd004,NULL, 
#       indd022,NULL,indd023,NULL,indd024,indd102,indd006,indd103,indd104,indd105,indd151,NULL,indd032, 
#       NULL,indd033,NULL,indd041,indd031,indd108,indc002,indc003,indc008,indc009,indc103,indc104,indc105, 
#       indc106,indc107,indc108,indc151,indd001,indd021,indd040,indd042,indd043,indd044,indd101,indd106, 
#       indd109,indd152,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 
#       NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   #160505-00014#6---mod---begin
   #LET g_from = " FROM indc_t LEFT OUTER JOIN indd_t ON indcdocno = indddocno AND indcent = inddent ",
   #              "            LEFT OUTER JOIN imaa_t ON indd002 = imaa001 AND inddent = imaaent ",
   #              "            LEFT OUTER JOIN imaal_t ON indd002 = imaal001 AND inddent = imaalent AND imaal002 = '",g_dlang,"' ",
   #              "            LEFT OUTER JOIN imaf_t ON indd002 = imaf001 AND inddent = imafent AND inddsite = imafsite "
   LET g_from = " FROM indc_t LEFT OUTER JOIN indd_t ON indcdocno = indddocno AND indcent = inddent "          
   #160505-00014#6---mod---end              
#   #end add-point
#    LET g_from = " FROM indc_t,indd_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("indc_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE ainr332_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE ainr332_x01_curs CURSOR FOR ainr332_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="ainr332_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION ainr332_x01_ins_data()
DEFINE sr RECORD 
   indcdocno LIKE indc_t.indcdocno, 
   indcdocdt LIKE indc_t.indcdocdt, 
   indc022 LIKE indc_t.indc022, 
   indc000 LIKE indc_t.indc000, 
   l_indc000_desc LIKE gzcbl_t.gzcbl004, 
   indc006 LIKE indc_t.indc006, 
   l_indc006_desc LIKE ooefl_t.ooefl004, 
   indc004 LIKE indc_t.indc004, 
   l_indc004_desc LIKE ooag_t.ooag011, 
   indc101 LIKE indc_t.indc101, 
   l_indc101_desc LIKE ooefl_t.ooefl004, 
   indcstus LIKE indc_t.indcstus, 
   l_indcstus_desc LIKE gzcbl_t.gzcbl004, 
   indc102 LIKE indc_t.indc102, 
   l_indc102_desc LIKE gzcbl_t.gzcbl004, 
   indc007 LIKE indc_t.indc007, 
   l_indc007_desc LIKE inayl_t.inayl003, 
   indc109 LIKE indc_t.indc109, 
   l_indc109_desc LIKE inayl_t.inayl003, 
   inddseq LIKE indd_t.inddseq, 
   indd002 LIKE indd_t.indd002, 
   l_imaal003 LIKE imaal_t.imaal003, 
   l_imaal004 LIKE imaal_t.imaal004, 
   indd004 LIKE indd_t.indd004, 
   l_indd004_desc LIKE oocql_t.oocql004, 
   indd022 LIKE indd_t.indd022, 
   l_indd022_desc LIKE inayl_t.inayl003, 
   indd023 LIKE indd_t.indd023, 
   l_indd023_desc LIKE inab_t.inab003, 
   indd024 LIKE indd_t.indd024, 
   indd102 LIKE indd_t.indd102, 
   indd006 LIKE indd_t.indd006, 
   indd103 LIKE indd_t.indd103, 
   indd104 LIKE indd_t.indd104, 
   indd105 LIKE indd_t.indd105, 
   indd151 LIKE indd_t.indd151, 
   l_indd151_desc LIKE oocql_t.oocql004, 
   indd032 LIKE indd_t.indd032, 
   l_indd032_desc LIKE inayl_t.inayl003, 
   indd033 LIKE indd_t.indd033, 
   l_indd033_desc LIKE inab_t.inab003, 
   indd041 LIKE indd_t.indd041, 
   indd031 LIKE indd_t.indd031, 
   indd108 LIKE indd_t.indd108, 
   indc002 LIKE indc_t.indc002, 
   indc003 LIKE indc_t.indc003, 
   indc008 LIKE indc_t.indc008, 
   indc009 LIKE indc_t.indc009, 
   indc103 LIKE indc_t.indc103, 
   indc104 LIKE indc_t.indc104, 
   indc105 LIKE indc_t.indc105, 
   indc106 LIKE indc_t.indc106, 
   indc107 LIKE indc_t.indc107, 
   indc108 LIKE indc_t.indc108, 
   indc151 LIKE indc_t.indc151, 
   indd001 LIKE indd_t.indd001, 
   indd021 LIKE indd_t.indd021, 
   indd040 LIKE indd_t.indd040, 
   indd042 LIKE indd_t.indd042, 
   indd043 LIKE indd_t.indd043, 
   indd044 LIKE indd_t.indd044, 
   indd101 LIKE indd_t.indd101, 
   indd106 LIKE indd_t.indd106, 
   indd109 LIKE indd_t.indd109, 
   indd152 LIKE indd_t.indd152, 
   l_indc105_desc LIKE type_t.chr30, 
   l_indc106_desc LIKE type_t.chr30, 
   l_indc107_desc LIKE type_t.chr30, 
   l_indc108_desc LIKE type_t.chr30, 
   l_indc151_desc LIKE type_t.chr30, 
   l_address LIKE type_t.chr300, 
   l_indd042_desc LIKE type_t.chr30, 
   l_indd043_desc LIKE type_t.chr30, 
   l_indd044_desc LIKE type_t.chr30, 
   l_imaa127_desc LIKE type_t.chr30, 
   l_indc006desc LIKE type_t.chr50, 
   l_indc105desc LIKE type_t.chr50, 
   l_indc106desc LIKE type_t.chr50, 
   l_indc107desc LIKE type_t.chr50, 
   l_indc108desc LIKE type_t.chr50, 
   l_indc151desc LIKE type_t.chr50, 
   l_indd004desc LIKE type_t.chr50, 
   l_indd022desc LIKE type_t.chr50, 
   l_indd023desc LIKE type_t.chr50, 
   l_indd032desc LIKE type_t.chr50, 
   l_indd033desc LIKE type_t.chr50, 
   l_indd042desc LIKE type_t.chr50, 
   l_indd043desc LIKE type_t.chr50, 
   l_indd044desc LIKE type_t.chr50, 
   l_indd151desc LIKE type_t.chr50, 
   l_imaa127desc LIKE type_t.chr50, 
   l_indcdocno_desc LIKE type_t.chr30, 
   l_indc002_desc LIKE type_t.chr30, 
   l_indcdocnodesc LIKE type_t.chr50, 
   l_indcstusdesc LIKE type_t.chr50, 
   l_indc004desc LIKE type_t.chr50, 
   l_indc101desc LIKE type_t.chr50, 
   l_indc002desc LIKE type_t.chr50, 
   l_indc102desc LIKE type_t.chr50
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE  r_success             LIKE type_t.num5
DEFINE  l_imaa127             LIKE imaa_t.imaa127  #系列              dorislai-20150727-add----(S)
DEFINE  l_oofa001             LIKE oofa_t.oofa001  #聯絡對象識別碼
DEFINE  l_oocq019             LIKE oocq_t.oocq019  #參考欄位16
DEFINE  l_success             LIKE type_t.num5     #                  dorislai-20150727-add----(E)

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH ainr332_x01_curs INTO sr.*                               
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
       #資料處理
       #160505-00014#6---mark---begin
       #調撥方式indc000
       #IF NOT cl_null(sr.indc000) THEN
       #   CALL ainr332_x01_desc('1','2083',sr.indc000,'') RETURNING sr.l_indc000_desc
       #END IF
       #160505-00014#6---mark---end
       #撥入營運據點indc006
       IF NOT cl_null(sr.indc006) THEN
          #CALL ainr332_x01_desc('6','',sr.indc006,'') RETURNING sr.l_indc006_desc  #160505-00014#6 mark
          #20150727 by dorislai add----(S)
          LET sr.l_indc006desc = ''
          IF NOT cl_null(sr.l_indc006_desc) THEN
             LET sr.l_indc006desc = sr.indc006,'.',sr.l_indc006_desc 
          END IF
          #20150727 by dorislai add----(E)
       END IF
       #調撥人員indc004
       IF NOT cl_null(sr.indc004) THEN
          #CALL ainr332_x01_desc('5','',sr.indc004,'') RETURNING sr.l_indc004_desc  #160505-00014#6 mark
          #dorislai-20150804-add---(S)
          LET sr.l_indc004desc = ''
          IF NOT cl_null(sr.l_indc004_desc) THEN
             LET sr.l_indc004desc = sr.indc004,'.',sr.l_indc004_desc
          END IF
          #dorislai-20150804-add---(E)
       END IF
       #調撥部門indc101
       IF NOT cl_null(sr.indc101) THEN
          #CALL ainr332_x01_desc('6','',sr.indc101,'') RETURNING sr.l_indc101_desc  #160505-00014#6 mark
          #dorislai-20150804-add---(S)
          LET sr.l_indc101desc = ''
          IF NOT cl_null(sr.l_indc101_desc) THEN
             LET sr.l_indc101desc = sr.indc101,'.',sr.l_indc101_desc
          END IF
          #dorislai-20150804-add---(E)
       END IF
       #狀態碼indcstus
       IF NOT cl_null(sr.indcstus) THEN
          #CALL ainr332_x01_desc('1','13',sr.indcstus,'') RETURNING sr.l_indcstus_desc  #160505-00014#6 mark
          #dorislai-20150804-add---(S)
          LET sr.l_indcstusdesc = ''
          IF NOT cl_null(sr.l_indcstus_desc) THEN
             LET sr.l_indcstusdesc = sr.indcstus,'.',sr.l_indcstus_desc
          END IF
          #dorislai-20150804-add---(E)
       END IF   
       #檢驗方式indc102
       IF NOT cl_null(sr.indc102) THEN
          #CALL ainr332_x01_desc('1','2081',sr.indc102,'') RETURNING sr.l_indc102_desc  #160505-00014#6 mark
          #dorislai-20150804-add---(S)
          LET sr.l_indc102desc = ''
          IF NOT cl_null(sr.l_indc102_desc) THEN
             LET sr.l_indc102desc = sr.indc102,'.',sr.l_indc102_desc
          END IF
          #dorislai-20150804-add---(E)
       END IF   
       #產品特徴說明indd004
       IF NOT cl_null(sr.indd004) THEN
          #CALL s_feature_description(sr.indd002,sr.indd004)   #160505-00014#6 mark
          #RETURNING r_success,sr.l_indd004_desc      #160505-00014#6 mark
          #20150727 by dorislai add----(S)
          LET sr.l_indd004desc = ''
          IF NOT cl_null(sr.l_indd004_desc) THEN
             LET sr.l_indd004desc = sr.indd004,'.',sr.l_indd004_desc 
          END IF 
          #20150727 by dorislai add----(E)          
       END IF   
       #理由碼indd151
       IF NOT cl_null(sr.indd151) THEN
          #CALL ainr332_x01_desc('2','303',sr.indd151,'') RETURNING sr.l_indd151_desc  #160505-00014#6 mark
          #20150727 by dorislai add----(S)
          LET sr.l_indd151desc = ''
          IF NOT cl_null(sr.l_indd151_desc) THEN
             LET sr.l_indd151desc = sr.indd151,'.',sr.l_indd151_desc 
          END IF
          #20150727 by dorislai add----(E)
       END IF
       #在途成本庫位indc007
       #160505-00014#6---mark---begin
       #IF NOT cl_null(sr.indc007) THEN
       #   CALL ainr332_x01_desc('3','',sr.indc007,'') RETURNING sr.l_indc007_desc  
       #END IF
       #在途非成本庫位indc109
       #IF NOT cl_null(sr.indc109) THEN
       #   CALL ainr332_x01_desc('3','',sr.indc109,'') RETURNING sr.l_indc109_desc
       #END IF
       #160505-00014#6---mark---end
       #撥出庫位indd022
       IF NOT cl_null(sr.indd022) THEN
          #CALL ainr332_x01_desc('3','',sr.indd022,'') RETURNING sr.l_indd022_desc   #160505-00014#6 mark
          #20150727 by dorislai add----(S)
          LET sr.l_indd022desc = ''
          IF NOT cl_null(sr.l_indd022_desc) THEN
             LET sr.l_indd022desc = sr.indd022,'.',sr.l_indd022_desc 
          END IF
          #20150727 by dorislai add----(E)
       END IF
       #撥出儲位indd023
       IF NOT cl_null(sr.indd023) THEN
          #CALL ainr332_x01_desc('4','',sr.indd022,sr.indd023) RETURNING sr.l_indd023_desc   #160505-00014#6 mark
          #20150727 by dorislai add----(S)
          LET sr.l_indd023desc = ''
          IF NOT cl_null(sr.l_indd023_desc) THEN
             LET sr.l_indd023desc = sr.indd023,'.',sr.l_indd023_desc 
          END IF
          #20150727 by dorislai add----(E)
       END IF
       #撥入庫位indd032
       IF NOT cl_null(sr.indd032) THEN
          #CALL ainr332_x01_desc('3','',sr.indd032,'') RETURNING sr.l_indd032_desc  #160505-00014#6 mark
          #20150727 by dorislai add----(S)
          LET sr.l_indd032desc = ''
          IF NOT cl_null(sr.l_indd032_desc) THEN
             LET sr.l_indd032desc = sr.indd032,'.',sr.l_indd032_desc 
          END IF
          #20150727 by dorislai add----(E)
       END IF
       #撥入儲位indd033
       IF NOT cl_null(sr.indd033) THEN
          #CALL ainr332_x01_desc('4','',sr.indd032,sr.indd033) RETURNING sr.l_indd033_desc   #160505-00014#6 mark
          #20150727 by dorislai add----(S)
          LET sr.l_indd033desc = ''
          IF NOT cl_null(sr.l_indd033_desc) THEN
             LET sr.l_indd033desc = sr.indd033,'.',sr.l_indd033_desc 
          END IF
          #20150727 by dorislai add----(E)
       END IF
       #dorislai-20150724-add----(S)
       #SELECT oofa001 INTO l_oofa001 FROM oofa_t          #160505-00014#6 mark
       # WHERE oofaent = g_enterprise AND oofa002 = '1' AND oofa003 = sr.indc006   #160505-00014#6 mark

       #送貨地址類型說明 l_indc105_desc	
       #LET sr.l_indc105_desc = ''  #160505-00014#6 mark
       LET sr.l_indc105desc = ''
       #SELECT oofb011 INTO sr.l_indc105_desc FROM oofb_t    #160505-00014#6 mark
       # WHERE oofbent = g_enterprise AND oofb002 = l_oofa001  AND oofb019 = sr.indc105  #160505-00014#6 mark
       IF NOT cl_null(sr.l_indc105_desc) THEN
          LET sr.l_indc105desc = sr.indc105,'.',sr.l_indc105_desc
       END IF
       #運輸方式說明 l_indc106_desc	
       #LET sr.l_indc106_desc = ''   #160505-00014#6 mark
       LET sr.l_indc106desc = ''
       #160505-00014#6---mark---begin
       #SELECT oocql004 INTO sr.l_indc106_desc FROM oocql_t 
       # WHERE oocqlent = g_enterprise AND oocql001 = '263' 
       #   AND oocql002 = sr.indc106 AND oocql003 = g_dlang
       #160505-00014#6---mark---end
       IF NOT cl_null(sr.l_indc106_desc) THEN
          LET sr.l_indc106desc = sr.indc106,'.',sr.l_indc106_desc
       END IF
       #起運地說明 l_indc107_desc	  
       LET sr.l_indc107_desc = ''
       LET sr.l_indc107desc = ''  
       #160907-00047#1 -s by 08172       
#       IF NOT cl_null(sr.indc106) THEN
#          SELECT oocq019 INTO l_oocq019
#            FROM oocq_t WHERE oocq001='263' AND oocq002= sr.indc106
#             AND oocqent = g_enterprise  #160905-00007#4 by 08172
#       END IF
#     
#       IF NOT cl_null(l_oocq019) THEN
#          CASE
#             WHEN l_oocq019 ='1' OR l_oocq019 ='4'
#                SELECT oockl005 INTO sr.l_indc107_desc FROM oockl_t 
#                 WHERE oocklent = g_enterprise AND oockl003 = sr.indc107 AND oockl004 = g_dlang
#     
#             WHEN l_oocq019 ='2'
#                SELECT oocql004 INTO sr.l_indc107_desc FROM oocql_t 
#                 WHERE oocqlent = g_enterprise AND oocql002 = sr.indc107 
#                   AND oocql001 = '262' AND oocql003 = g_dlang
#     
#             WHEN l_oocq019 ='3'
#                SELECT oocql004 INTO sr.l_indc107_desc FROM oocql_t 
#                 WHERE oocqlent = g_enterprise AND oocql002 = sr.indc107 
#                   AND oocql001 = '276' AND oocql003 = g_dlang
#
#          END CASE
#       ELSE
#          SELECT oockl005 INTO sr.l_indc107_desc FROM oockl_t 
#           WHERE oocklent = g_enterprise AND oockl003 = sr.indc107 
##             AND oocql001 = '262' AND oockl004 = g_dlang   #160906-00031#1 by 08172
#             AND oockl002 = '262' AND oockl004 = g_dlang    #160906-00031#1 by 08172
#          
#       END IF
       CALL s_apmi011_location_ref(sr.indc106,sr.indc107) RETURNING sr.l_indc107_desc
       #160907-00047#1 -e by 08172
       IF NOT cl_null(sr.l_indc107_desc) THEN
          LET sr.l_indc107desc = sr.indc107,'.',sr.l_indc107_desc
       END IF
       #到達地說明 l_indc108_desc	
       LET sr.l_indc108_desc = ''	
       LET sr.l_indc108desc = ''
       CALL s_apmi011_location_ref(sr.indc106,sr.indc108) RETURNING sr.l_indc108_desc
       IF NOT cl_null(sr.l_indc108_desc) THEN
          LET sr.l_indc108desc = sr.indc108,'.',sr.l_indc108_desc
       END IF
       #調撥理由說明 l_indc151_desc	
       #LET sr.l_indc151_desc = ''   #160505-00014#6 mark
       LET sr.l_indc151desc = ''
       #SELECT oocql004 INTO sr.l_indc151_desc FROM oocql_t    #160505-00014#6 mark
       # WHERE oocqlent = g_enterprise AND oocql001 = '303' AND oocql002 = sr.indc151  #160505-00014#6 mark
       IF NOT cl_null(sr.l_indc151_desc) THEN
          LET sr.l_indc151desc = sr.indc151,'.',sr.l_indc151_desc
       END IF
       #送貨地址 l_address	
       LET sr.l_address = ''
       CALL s_aooi350_get_address(l_oofa001,sr.indc105,g_lang)RETURNING l_success,sr.l_address
   
       #專案編號說明 l_indd042_desc	
       #LET sr.l_indd042_desc = ''   #160505-00014#6 mark
       LET sr.l_indd042desc = ''
       #CALL s_desc_get_project_desc(sr.indd042) RETURNING sr.l_indd042_desc   #160505-00014#6 mark
       IF NOT cl_null(sr.l_indd042_desc) THEN
          LET sr.l_indd042desc = sr.indd042,'.',sr.l_indd042_desc
       END IF
       #WBS說明 l_indd043_desc	
       #LET sr.l_indd043_desc = ''   #160505-00014#6 mark
       LET sr.l_indd043desc = ''
       #CALL s_desc_get_wbs_desc(sr.indd042,sr.indd043) RETURNING sr.l_indd043_desc  #160505-00014#6 mark
       IF NOT cl_null(sr.l_indd043_desc) THEN
          LET sr.l_indd043desc = sr.indd043,'.',sr.l_indd043_desc
       END IF
       #活動編號說明 l_indd044_desc	
       LET sr.l_indd044_desc = ''
       LET sr.l_indd044desc = ''
       CALL s_desc_get_activity_desc(sr.indd042,sr.indd044) RETURNING sr.l_indd044_desc
       IF NOT cl_null(sr.l_indd044_desc) THEN
          LET sr.l_indd044desc = sr.indd044,'.',sr.l_indd044_desc
       END IF
       #調撥單號全名 l_indcdocnodesc 
       #LET sr.l_indcdocno_desc = ''  #160505-00014#6 mark
       LET sr.l_indcdocnodesc = ''      
       #CALL s_aooi200_get_slip_desc(sr.indcdocno) RETURNING sr.l_indcdocno_desc   #160505-00014#6 mark
       IF NOT cl_null(sr.l_indcdocno_desc) THEN
          LET sr.l_indcdocnodesc = sr.indcdocno,'.',sr.l_indcdocno_desc
       END IF
       #來源類別全名 l_indc002desc 
       #LET sr.l_indc002_desc = ''
       LET sr.l_indc002desc = ''
       #CALL s_desc_gzcbl004_desc('6016',sr.indc002) RETURNING sr.l_indc002_desc
       IF NOT cl_null(sr.l_indc002_desc) THEN
          LET sr.l_indc002desc = sr.indc002,'.',sr.l_indc002_desc
       END IF
       #系列說明 l_imaa127_desc	
       #LET sr.l_imaa127_desc = ''   #160505-00014#6 mark
       LET sr.l_imaa127desc = ''
          #用料號抓取系列
       #160505-00014#6 mark---begin   
       #SELECT imaa127 INTO l_imaa127 FROM imaa_t
       # WHERE imaa001 = sr.indd002
       #   AND imaaent = g_enterprise
       #  #抓取系列說明
       #CALL s_desc_get_acc_desc('2003',l_imaa127)  RETURNING sr.l_imaa127_desc   
       #160505-00014#6---mark---end
       IF NOT cl_null(sr.l_imaa127_desc) THEN
          LET sr.l_imaa127desc = l_imaa127,'.',sr.l_imaa127_desc
       END IF
       #dorislai-20150724-add----(E)
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.indcdocno,sr.indcdocdt,sr.indc022,sr.l_indc000_desc,sr.indc006,sr.l_indc006_desc,sr.indc004,sr.l_indc004_desc,sr.indc101,sr.l_indc101_desc,sr.l_indcstus_desc,sr.l_indc102_desc,sr.indc007,sr.l_indc007_desc,sr.indc109,sr.l_indc109_desc,sr.inddseq,sr.indd002,sr.l_imaal003,sr.l_imaal004,sr.indd004,sr.l_indd004_desc,sr.indd022,sr.l_indd022_desc,sr.indd023,sr.l_indd023_desc,sr.indd024,sr.indd102,sr.indd006,sr.indd103,sr.indd104,sr.indd105,sr.indd151,sr.l_indd151_desc,sr.indd032,sr.l_indd032_desc,sr.indd033,sr.l_indd033_desc,sr.indd041,sr.indd031,sr.indd108,sr.indc002,sr.indc003,sr.indc008,sr.indc009,sr.indc103,sr.indc104,sr.indc105,sr.indc106,sr.indc107,sr.indc108,sr.indc151,sr.indd001,sr.indd021,sr.indd040,sr.indd042,sr.indd043,sr.indd044,sr.indd101,sr.indd106,sr.indd109,sr.indd152,sr.l_indc105_desc,sr.l_indc106_desc,sr.l_indc107_desc,sr.l_indc108_desc,sr.l_indc151_desc,sr.l_address,sr.l_indd042_desc,sr.l_indd043_desc,sr.l_indd044_desc,sr.l_imaa127_desc,sr.l_indc006desc,sr.l_indc105desc,sr.l_indc106desc,sr.l_indc107desc,sr.l_indc108desc,sr.l_indc151desc,sr.l_indd004desc,sr.l_indd022desc,sr.l_indd023desc,sr.l_indd032desc,sr.l_indd033desc,sr.l_indd042desc,sr.l_indd043desc,sr.l_indd044desc,sr.l_indd151desc,sr.l_imaa127desc,sr.l_indcdocno_desc,sr.l_indc002_desc,sr.l_indcdocnodesc,sr.l_indcstusdesc,sr.l_indc004desc,sr.l_indc101desc,sr.l_indc002desc,sr.l_indc102desc
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "ainr332_x01_execute"
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
 
{<section id="ainr332_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION ainr332_x01_rep_data()
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
 
{<section id="ainr332_x01.other_function" readonly="Y" >}

#GET DESC
PRIVATE FUNCTION ainr332_x01_desc(p_class,p_num,p_target,p_target2)
   DEFINE p_class  LIKE type_t.chr2
   DEFINE p_num    LIKE type_t.num5
   DEFINE p_target LIKE type_t.chr20
   DEFINE p_target2 LIKE type_t.chr20
   DEFINE r_desc   LIKE type_t.chr500
   
   CASE p_class
   WHEN '1' #获取SCC码说明
      SELECT gzcbl004 INTO r_desc
        FROM gzcbl_t
       WHERE gzcbl001 = p_num
         AND gzcbl002 = p_target
         AND gzcbl003 = g_dlang
         
   WHEN '2' #获取ACC码说明
      SELECT oocql004 INTO r_desc
        FROM oocql_t
       WHERE oocql001 = p_num
         AND oocql002 = p_target
         AND oocql003 = g_dlang
         AND oocqlent = g_enterprise

   WHEN '3' #获取库位名称
      SELECT inayl003 INTO r_desc
        FROM inayl_t
       WHERE inayl001 = p_target
         AND inayl002 = g_dlang
         AND inaylent = g_enterprise
         
   WHEN '4' #获取储位名称
      SELECT inab003 INTO r_desc
        FROM inab_t
       WHERE inab001 = p_target
         AND inab002 = p_target2
         AND inabsite = g_site
         AND inabent = g_enterprise
         
   WHEN '5' #获取人员名称
      SELECT ooag011 INTO r_desc
        FROM ooag_t
       WHERE ooag001 = p_target
         AND ooagent = g_enterprise
         
   WHEN '6' #获取部门名称
      SELECT ooefl003 INTO r_desc
        FROM ooefl_t
       WHERE ooefl001 = p_target
         AND ooefl002 = g_dlang
         AND ooeflent = g_enterprise  

   END CASE
   
   RETURN r_desc 
END FUNCTION

 
{</section>}
 
