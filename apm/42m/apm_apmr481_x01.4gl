#該程式未解開Section, 採用最新樣板產出!
{<section id="apmr481_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2015-11-25 09:20:15), PR版次:0002(2015-11-25 09:04:57)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000047
#+ Filename...: apmr481_x01
#+ Description: ...
#+ Creator....: 05423(2015-02-27 11:18:48)
#+ Modifier...: 07024 -SD/PR- 07024
 
{</section>}
 
{<section id="apmr481_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"

#end add-point
#add-point:填寫註解說明 name="global.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="global.import"
#151106-00004#15 By Dorislai 改善效能，將ins_data中的資料，寫入sel_prep的sql中
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
 
{<section id="apmr481_x01.main" readonly="Y" >}
PUBLIC FUNCTION apmr481_x01(p_arg1)
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
   LET g_rep_code = "apmr481_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL apmr481_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL apmr481_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL apmr481_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL apmr481_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL apmr481_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="apmr481_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION apmr481_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "pmeo001.pmeo_t.pmeo001,pmeo002.pmeo_t.pmeo002,pmdx002.pmdx_t.pmdx002,l_pmdx002_desc.ooag_t.ooag011,pmdx003.pmdx_t.pmdx003,l_pmdx003_desc.ooefl_t.ooefl003,pmdx004.pmdx_t.pmdx004,l_pmdx004_desc.pmaal_t.pmaal004,pmeo005.pmeo_t.pmeo005,pmeo003.pmeo_t.pmeo003,pmeo004.pmeo_t.pmeo004,l_imaa009.imaa_t.imaa009,l_imaa009_desc.rtaxl_t.rtaxl003,l_imaf141.imaf_t.imaf141,l_imaf141_desc.oocql_t.oocql004,pmeo006.pmeo_t.pmeo006,l_imaal003.imaal_t.imaal003,l_imaal004.imaal_t.imaal004,pmeo007.pmeo_t.pmeo007,l_pmeo007_desc.oocql_t.oocql004,l_imaa127.type_t.chr500,l_imaa127_desc.type_t.chr500,l_imaa127_oocql004.type_t.chr1000,pmeo021.pmeo_t.pmeo021,pmeo017.pmeo_t.pmeo017,pmeo018.pmeo_t.pmeo018,pmeo019.pmeo_t.pmeo019,pmeo020.pmeo_t.pmeo020,pmeo014.pmeo_t.pmeo014,pmeo015.pmeo_t.pmeo015,pmeo016.pmeo_t.pmeo016,pmeo010.pmeo_t.pmeo010,pmeo011.pmeo_t.pmeo011,pmeo012.pmeo_t.pmeo012,pmeo013.pmeo_t.pmeo013,pmeo008.pmeo_t.pmeo008,pmeo009.pmeo_t.pmeo009,l_pmeo025_desc.gzcbl_t.gzcbl004,pmeo027.pmeo_t.pmeo027,pmeo028.pmeo_t.pmeo028" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="apmr481_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION apmr481_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="apmr481_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apmr481_x01_sel_prep()
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
   #151106-00004#15-mod-(S)
#   LET g_select = " SELECT pmeo001,pmeo002,pmdx002,NULL,pmdx003,NULL,pmdx004,NULL,pmeo005,pmeo003,pmeo004, 
#       imaa009,NULL,imaf141,NULL,pmeo006,imaal003,imaal004,pmeo007,NULL,NULL,NULL,NULL,pmeo021,pmeo017,pmeo018,pmeo019,pmeo020,pmeo014, 
#       pmeo015,pmeo016,pmeo010,pmeo011,pmeo012,pmeo013,pmeo008,pmeo009,pmeo025,NULL,pmeo027,pmeo028" 
   LET g_select = " SELECT pmeo001,pmeo002,pmdx002,ooag011,pmdx003,ooefl003,pmdx004,pmaal004,
                           pmeo005,pmeo003,pmeo004,imaa009,rtaxl003,imaf141,A1.oocql004,pmeo006,
                           imaal003,imaal004,pmeo007,NULL,imaa127,A2.oocql004,
                           CASE WHEN A2.oocql004 IS NULL THEN imaa127 ELSE trim(imaa127)||'.'||trim(A2.oocql004) END ,
                           pmeo021,pmeo017,pmeo018,pmeo019,pmeo020,pmeo014,pmeo015,pmeo016,pmeo010,
                           pmeo011,pmeo012,pmeo013,pmeo008,pmeo009,pmeo025,gzcbl004,pmeo027,pmeo028" 
   #151106-00004#15-mod-(E)    
#   #end add-point
#   LET g_select = " SELECT pmeo001,pmeo002,pmdx002,NULL,pmdx003,NULL,pmdx004,NULL,pmeo005,pmeo003,pmeo004, 
#       NULL,NULL,NULL,NULL,pmeo006,NULL,NULL,pmeo007,NULL,NULL,NULL,NULL,pmeo021,pmeo017,pmeo018,pmeo019, 
#       pmeo020,pmeo014,pmeo015,pmeo016,pmeo010,pmeo011,pmeo012,pmeo013,pmeo008,pmeo009,pmeo025,NULL, 
#       pmeo027,pmeo028"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_from = " FROM pmeo_t LEFT OUTER JOIN pmdx_t ON pmeo001 = pmdxdocno AND pmeoent = pmdxent ",
                "             LEFT OUTER JOIN imaa_t ON pmeo006 = imaa001 AND pmeoent = imaaent ",
                "             LEFT OUTER JOIN imaf_t ON pmeo006 = imaf001 AND pmeoent = imafent AND pmeosite = imafsite ",
                "             LEFT OUTER JOIN imaal_t ON pmeo006 = imaal001 AND pmeoent = imaalent AND imaal002 = '",g_dlang,"' ",
                #151106-00004#15-add-(S)
                "             LEFT OUTER JOIN ooag_t ON ooagent = pmdxent AND ooag001 = pmdx002",
                "             LEFT OUTER JOIN ooefl_t ON ooeflent = pmdxent AND ooefl001 = pmdx003 AND ooefl002 = '",g_dlang,"' ",
                "             LEFT OUTER JOIN pmaal_t ON pmaalent = pmdxent AND pmaal001 = pmdx004 AND pmaal002 = '",g_dlang,"' ",
                "             LEFT OUTER JOIN rtaxl_t ON rtaxlent = imaaent AND rtaxl001 = imaa009 AND rtaxl002 = '",g_dlang,"' ",
                "             LEFT OUTER JOIN gzcbl_t ON gzcbl001 = '5450' AND gzcbl002 = pmeo025 AND gzcbl003 = '",g_dlang,"' ",
                #ACC
                "             LEFT OUTER JOIN oocql_t A1 ON A1.oocqlent = imafent AND A1.oocql001 = '203' AND A1.oocql002 = imaf141 AND A1.oocql003 = '",g_dlang,"' ",
                "             LEFT OUTER JOIN oocql_t A2 ON A2.oocqlent = imaaent AND A2.oocql001 = '2003' AND A2.oocql002 = imaa127 AND A2.oocql003 = '",g_dlang,"' "        
                #151106-00004#15-add-(E)
                
                
#   #end add-point
#    LET g_from = " FROM pmeo_t,pmdx_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("pmeo_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE apmr481_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE apmr481_x01_curs CURSOR FOR apmr481_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="apmr481_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION apmr481_x01_ins_data()
DEFINE sr RECORD 
   pmeo001 LIKE pmeo_t.pmeo001, 
   pmeo002 LIKE pmeo_t.pmeo002, 
   pmdx002 LIKE pmdx_t.pmdx002, 
   l_pmdx002_desc LIKE ooag_t.ooag011, 
   pmdx003 LIKE pmdx_t.pmdx003, 
   l_pmdx003_desc LIKE ooefl_t.ooefl003, 
   pmdx004 LIKE pmdx_t.pmdx004, 
   l_pmdx004_desc LIKE pmaal_t.pmaal004, 
   pmeo005 LIKE pmeo_t.pmeo005, 
   pmeo003 LIKE pmeo_t.pmeo003, 
   pmeo004 LIKE pmeo_t.pmeo004, 
   l_imaa009 LIKE imaa_t.imaa009, 
   l_imaa009_desc LIKE rtaxl_t.rtaxl003, 
   l_imaf141 LIKE imaf_t.imaf141, 
   l_imaf141_desc LIKE oocql_t.oocql004, 
   pmeo006 LIKE pmeo_t.pmeo006, 
   l_imaal003 LIKE imaal_t.imaal003, 
   l_imaal004 LIKE imaal_t.imaal004, 
   pmeo007 LIKE pmeo_t.pmeo007, 
   l_pmeo007_desc LIKE oocql_t.oocql004, 
   l_imaa127 LIKE type_t.chr500, 
   l_imaa127_desc LIKE type_t.chr500, 
   l_imaa127_oocql004 LIKE type_t.chr1000, 
   pmeo021 LIKE pmeo_t.pmeo021, 
   pmeo017 LIKE pmeo_t.pmeo017, 
   pmeo018 LIKE pmeo_t.pmeo018, 
   pmeo019 LIKE pmeo_t.pmeo019, 
   pmeo020 LIKE pmeo_t.pmeo020, 
   pmeo014 LIKE pmeo_t.pmeo014, 
   pmeo015 LIKE pmeo_t.pmeo015, 
   pmeo016 LIKE pmeo_t.pmeo016, 
   pmeo010 LIKE pmeo_t.pmeo010, 
   pmeo011 LIKE pmeo_t.pmeo011, 
   pmeo012 LIKE pmeo_t.pmeo012, 
   pmeo013 LIKE pmeo_t.pmeo013, 
   pmeo008 LIKE pmeo_t.pmeo008, 
   pmeo009 LIKE pmeo_t.pmeo009, 
   pmeo025 LIKE pmeo_t.pmeo025, 
   l_pmeo025_desc LIKE gzcbl_t.gzcbl004, 
   pmeo027 LIKE pmeo_t.pmeo027, 
   pmeo028 LIKE pmeo_t.pmeo028
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE  r_success             LIKE type_t.num5
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH apmr481_x01_curs INTO sr.*                               
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
       #151106-00004#15-mark-(S)
#       #获取说明
#       #采购人员姓名 pmdx002
#       IF NOT cl_null(sr.pmdx002) THEN
#          CALL apmr481_x01_desc('5','',sr.pmdx002) RETURNING sr.l_pmdx002_desc
#       END IF
#       #采购部门简称 pmdx003
#       IF NOT cl_null(sr.pmdx003) THEN
#          CALL apmr481_x01_desc('6','',sr.pmdx003) RETURNING sr.l_pmdx003_desc
#       END IF
#       #供应商简称   pmdx004
#       IF NOT cl_null(sr.pmdx004) THEN
#          CALL apmr481_x01_desc('3','',sr.pmdx004) RETURNING sr.l_pmdx004_desc
#       END IF
#       #产品分类说明 imaa009
#       IF NOT cl_null(sr.l_imaa009) THEN
#          CALL apmr481_x01_desc('4','',sr.l_imaa009) RETURNING sr.l_imaa009_desc
#       END IF
#       #采购分群说明 imaf141 '203'
#       IF NOT cl_null(sr.l_imaf141) THEN
#          CALL apmr481_x01_desc('2','203',sr.l_imaf141) RETURNING sr.l_imaf141_desc
#       END IF
       #151106-00004#15-mark-(E)
       #产品特徴说明 pmeo007
       IF NOT cl_null(sr.pmeo007) THEN
          CALL s_feature_description(sr.pmeo006,sr.pmeo007)
          RETURNING r_success,sr.l_pmeo007_desc             
       END IF
       #差异处理否   pmeo025
       IF NOT cl_null(sr.pmeo025) THEN
          CALL apmr481_x01_desc('1','5450',sr.pmeo025) RETURNING sr.l_pmeo025_desc
          LET sr.l_pmeo025_desc = sr.pmeo025,'.',sr.l_pmeo025_desc
       END IF
       #151106-00004#15-mark-(S)
#       #系列   20150820 by dorislai add  (S)
#          #用料號抓取系列
#       SELECT imaa127 INTO sr.l_imaa127 FROM imaa_t
#        WHERE imaa001 = sr.pmeo006
#          AND imaaent = g_enterprise
#          #抓取系列說明
#       CALL s_desc_get_acc_desc('2003',sr.l_imaa127)  RETURNING sr.l_imaa127_desc   
#       IF NOT cl_null(sr.l_imaa127_desc) THEN
#          LET sr.l_imaa127desc = sr.l_imaa127,'.',sr.l_imaa127_desc 
#       ELSE
#          LET sr.l_imaa127desc = ''
#       END IF
       #       20150820 by dorislai add  (E)
       #151106-00004#15-mark-(E)
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.pmeo001,sr.pmeo002,sr.pmdx002,sr.l_pmdx002_desc,sr.pmdx003,sr.l_pmdx003_desc,sr.pmdx004,sr.l_pmdx004_desc,sr.pmeo005,sr.pmeo003,sr.pmeo004,sr.l_imaa009,sr.l_imaa009_desc,sr.l_imaf141,sr.l_imaf141_desc,sr.pmeo006,sr.l_imaal003,sr.l_imaal004,sr.pmeo007,sr.l_pmeo007_desc,sr.l_imaa127,sr.l_imaa127_desc,sr.l_imaa127_oocql004,sr.pmeo021,sr.pmeo017,sr.pmeo018,sr.pmeo019,sr.pmeo020,sr.pmeo014,sr.pmeo015,sr.pmeo016,sr.pmeo010,sr.pmeo011,sr.pmeo012,sr.pmeo013,sr.pmeo008,sr.pmeo009,sr.l_pmeo025_desc,sr.pmeo027,sr.pmeo028
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "apmr481_x01_execute"
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
 
{<section id="apmr481_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION apmr481_x01_rep_data()
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
 
{<section id="apmr481_x01.other_function" readonly="Y" >}

#GET DESC
PRIVATE FUNCTION apmr481_x01_desc(p_class,p_num,p_target)
   DEFINE p_class  LIKE type_t.chr2
   DEFINE p_num    LIKE type_t.num5
   DEFINE p_target LIKE type_t.chr20
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
   
   WHEN '3' #获取供应商名称
      SELECT pmaal004 INTO r_desc
        FROM pmaal_t
       WHERE pmaal001 = p_target
         AND pmaal002 = g_dlang
         AND pmaalent = g_enterprise

   WHEN '4' #获取产品分类说明
      SELECT rtaxl003 INTO r_desc
        FROM rtaxl_t
       WHERE rtaxl001 = p_target
         AND rtaxl002 = g_dlang
         AND rtaxlent = g_enterprise
   
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
 
