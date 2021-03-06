#該程式未解開Section, 採用最新樣板產出!
{<section id="apmr050_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2016-08-03 15:32:32), PR版次:0003(2016-08-03 16:51:53)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000042
#+ Filename...: apmr050_x01
#+ Description: ...
#+ Creator....: 02574(2015-07-07 10:51:15)
#+ Modifier...: 08734 -SD/PR- 08734
 
{</section>}
 
{<section id="apmr050_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#160727-00019#13   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmr050_x01_temp01 ——> apmr050_tmp01
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
       wc STRING,                  #Where Condition 
       bdate LIKE type_t.dat,         #採購日期-起 
       edate LIKE type_t.dat          #採購日期-迄
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="apmr050_x01.main" readonly="Y" >}
PUBLIC FUNCTION apmr050_x01(p_arg1,p_arg2,p_arg3)
DEFINE  p_arg1 STRING                  #tm.wc  Where Condition 
DEFINE  p_arg2 LIKE type_t.dat         #tm.bdate  採購日期-起 
DEFINE  p_arg3 LIKE type_t.dat         #tm.edate  採購日期-迄
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.bdate = p_arg2
   LET tm.edate = p_arg3
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "apmr050_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL apmr050_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL apmr050_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL apmr050_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL apmr050_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL apmr050_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="apmr050_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION apmr050_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "pmdl015.pmdl_t.pmdl015,pmdn001.pmdn_t.pmdn001,l_pmdn015_min.type_t.num20_6,pmdlcnfdt.pmdl_t.pmdlcnfdt,l_pmdn015_average.type_t.num20_6,l_pmdn015_recent.type_t.num20_6,l_pmdn015_max.type_t.num20_6,l_pmdl004_pmaal004.type_t.chr100,l_imaa127.type_t.chr30,l_imaa127_desc.type_t.chr50,l_imaa127desc.type_t.chr80" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   DROP TABLE apmr050_tmp01;  #160727-00019#13   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmr050_x01_temp01 ——> apmr050_tmp01

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop apmr050_x01_temp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_rep_success = 'N'
      RETURN
   END IF
   #151106-00004#s983961--add(l_imaa127,l_imaa127_desc,l_imaa127desc)
   CREATE TEMP TABLE apmr050_tmp01(  #160727-00019#13   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmr050_x01_temp01 ——> apmr050_tmp01
                     pmdldocdt              DATE,  
                     pmdlcnfdt              DATETIME YEAR TO SECOND,   
                     pmdl015                VARCHAR(10),     
                     pmdn001                VARCHAR(40),     
                     l_pmdl004_pmaal004     VARCHAR(100),      
                     pmdn015                DECIMAL(20,6),
                     l_imaa127              VARCHAR(100),
                     l_imaa127_desc         VARCHAR(100),
                     l_imaa127desc          VARCHAR(100))

   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create apmr050_tmp01'  #160727-00019#13   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmr050_x01_temp01 ——> apmr050_tmp01
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_rep_success = 'N'
      RETURN
   END IF
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="apmr050_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION apmr050_x01_ins_prep()
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
             ?,?,?,?,?)"
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
 
{<section id="apmr050_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apmr050_x01_sel_prep()
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
   LET g_select = " SELECT pmdl001,pmdl002,pmdl003,pmdl004,pmdl005,pmdl006,pmdl007,pmdl008,pmdl009,pmdl010, 
       pmdl011,pmdl012,pmdl013,pmdl015,pmdl016,pmdl017,pmdl018,pmdl019,pmdl020,pmdl021,pmdl022,pmdl023, 
       pmdl024,pmdl025,pmdl026,pmdl027,pmdl028,pmdl029,pmdl030,pmdl031,pmdl032,pmdl033,pmdl040,pmdl041, 
       pmdl042,pmdl043,pmdl044,pmdl046,pmdl047,pmdl048,pmdl049,pmdl051,pmdl052,pmdl053,pmdl054,pmdl055, 
       pmdldocdt,pmdldocno,pmdlent,pmdlsite,pmdlstus,pmdlunit,pmdn001,0,pmdlcnfdt,0,0,0,pmdn002,pmdn003, 
       pmdn004,pmdn005,pmdn006,pmdn007,pmdn008,pmdn009,pmdn010,pmdn011,pmdn012,pmdn013,pmdn014,pmdn015, 
       pmdn016,pmdn017,pmdn019,pmdn020,pmdn021,pmdn022,pmdn023,pmdn024,pmdn025,pmdn026,pmdn027,pmdn028, 
       pmdn029,pmdn030,pmdn031,pmdn032,pmdn033,pmdn035,pmdn036,pmdn037,pmdn038,pmdn039,pmdn040,pmdn041, 
       pmdn042,pmdn043,pmdn044,pmdn045,pmdn046,pmdn047,pmdn048,pmdn049,pmdn050,pmdn051,pmdn052,pmdn053, 
       pmdn054,pmdn055,pmdn056,pmdn057,pmdnorga,pmdnseq,pmdnsite,pmdnunit,pmaal_t.pmaal004,t1.pmaal004, 
       t2.pmaal004,t3.pmaal004,t4.pmaal004,x.t5_pmaal004,x.imaal_t_imaal003,x.t10_imaal003,trim(pmdl004)||'.'||trim(t2.pmaal004), 
       trim(pmdl021)||'.'||trim(t1.pmaal004),trim(pmdl022)||'.'||trim(pmaal_t.pmaal004),trim(pmdl032)||'.'||trim(t4.pmaal004), 
       trim(pmdl052)||'.'||trim(t3.pmaal004),trim(pmdn023)||'.'||trim(x.t5_pmaal004),x.imaa127,x.oocql004, 
       trim(x.imaa127)||'.'||trim(x.oocql004) "  #151106-00004#9 20151123 s983961--add(x.imaa127,x.oocql004,trim(x.imaa127)||'.'||trim(x.oocql004))
#   #end add-point
#   LET g_select = " SELECT pmdl001,pmdl002,pmdl003,pmdl004,pmdl005,pmdl006,pmdl007,pmdl008,pmdl009,pmdl010, 
#       pmdl011,pmdl012,pmdl013,pmdl015,pmdl016,pmdl017,pmdl018,pmdl019,pmdl020,pmdl021,pmdl022,pmdl023, 
#       pmdl024,pmdl025,pmdl026,pmdl027,pmdl028,pmdl029,pmdl030,pmdl031,pmdl032,pmdl033,pmdl040,pmdl041, 
#       pmdl042,pmdl043,pmdl044,pmdl046,pmdl047,pmdl048,pmdl049,pmdl051,pmdl052,pmdl053,pmdl054,pmdl055, 
#       pmdldocdt,pmdldocno,pmdlent,pmdlsite,pmdlstus,pmdlunit,pmdn001,0,pmdlcnfdt,0,0,0,pmdn002,pmdn003, 
#       pmdn004,pmdn005,pmdn006,pmdn007,pmdn008,pmdn009,pmdn010,pmdn011,pmdn012,pmdn013,pmdn014,pmdn015, 
#       pmdn016,pmdn017,pmdn019,pmdn020,pmdn021,pmdn022,pmdn023,pmdn024,pmdn025,pmdn026,pmdn027,pmdn028, 
#       pmdn029,pmdn030,pmdn031,pmdn032,pmdn033,pmdn035,pmdn036,pmdn037,pmdn038,pmdn039,pmdn040,pmdn041, 
#       pmdn042,pmdn043,pmdn044,pmdn045,pmdn046,pmdn047,pmdn048,pmdn049,pmdn050,pmdn051,pmdn052,pmdn053, 
#       pmdn054,pmdn055,pmdn056,pmdn057,pmdnorga,pmdnseq,pmdnsite,pmdnunit,( SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = pmdl_t.pmdl022 AND pmaal_t.pmaalent = pmdl_t.pmdlent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,"),( SELECT pmaal004 FROM pmaal_t t1 WHERE t1.pmaal001 = pmdl_t.pmdl021 AND t1.pmaalent = pmdl_t.pmdlent AND t1.pmaal002 = '" , 
#       g_dlang,"'" ,"),( SELECT pmaal004 FROM pmaal_t t2 WHERE t2.pmaal001 = pmdl_t.pmdl004 AND t2.pmaalent = pmdl_t.pmdlent AND t2.pmaal002 = '" , 
#       g_dlang,"'" ,"),( SELECT pmaal004 FROM pmaal_t t3 WHERE t3.pmaal001 = pmdl_t.pmdl052 AND t3.pmaalent = pmdl_t.pmdlent AND t3.pmaal002 = '" , 
#       g_dlang,"'" ,"),( SELECT pmaal004 FROM pmaal_t t4 WHERE t4.pmaal001 = pmdl_t.pmdl032 AND t4.pmaalent = pmdl_t.pmdlent AND t4.pmaal002 = '" , 
#       g_dlang,"'" ,"),x.t5_pmaal004,x.imaal_t_imaal003,x.t10_imaal003,trim(pmdl004)||'.'||trim((SELECT pmaal004 FROM pmaal_t t2 WHERE t2.pmaal001 = pmdl_t.pmdl004 AND t2.pmaalent = pmdl_t.pmdlent AND t2.pmaal002 = '" , 
#       g_dlang,"'" ,")),trim(pmdl021)||'.'||trim((SELECT pmaal004 FROM pmaal_t t1 WHERE t1.pmaal001 = pmdl_t.pmdl021 AND t1.pmaalent = pmdl_t.pmdlent AND t1.pmaal002 = '" , 
#       g_dlang,"'" ,")),trim(pmdl022)||'.'||trim((SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = pmdl_t.pmdl022 AND pmaal_t.pmaalent = pmdl_t.pmdlent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,")),trim(pmdl032)||'.'||trim((SELECT pmaal004 FROM pmaal_t t4 WHERE t4.pmaal001 = pmdl_t.pmdl032 AND t4.pmaalent = pmdl_t.pmdlent AND t4.pmaal002 = '" , 
#       g_dlang,"'" ,")),trim(pmdl052)||'.'||trim((SELECT pmaal004 FROM pmaal_t t3 WHERE t3.pmaal001 = pmdl_t.pmdl052 AND t3.pmaalent = pmdl_t.pmdlent AND t3.pmaal002 = '" , 
#       g_dlang,"'" ,")),trim(pmdn023)||'.'||trim(x.t5_pmaal004),NULL,NULL,NULL"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
    LET g_from = " FROM pmdl_t LEFT OUTER JOIN pmaal_t ON pmaal_t.pmaal001 = pmdl_t.pmdl022 AND pmaal_t.pmaalent = pmdl_t.pmdlent AND pmaal_t.pmaal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN pmaal_t t1 ON t1.pmaal001 = pmdl_t.pmdl021 AND t1.pmaalent = pmdl_t.pmdlent AND t1.pmaal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN pmaal_t t2 ON t2.pmaal001 = pmdl_t.pmdl004 AND t2.pmaalent = pmdl_t.pmdlent AND t2.pmaal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN pmaal_t t3 ON t3.pmaal001 = pmdl_t.pmdl052 AND t3.pmaalent = pmdl_t.pmdlent AND t3.pmaal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN pmaal_t t4 ON t4.pmaal001 = pmdl_t.pmdl032 AND t4.pmaalent = pmdl_t.pmdlent AND t4.pmaal002 = '" , 
        g_dlang,"'" ,
        "                          LEFT OUTER JOIN pmaa_t ON pmaa_t.pmaa001 = pmdl_t.pmdl004 AND pmaa_t.pmaaent = pmdl_t.pmdlent",
        " LEFT OUTER JOIN ( SELECT pmdn_t.*,t5.pmaal004 t5_pmaal004,imaal_t.imaal003 imaal_t_imaal003, 
        t10.imaal003 t10_imaal003,imaa009,imaa127,oocql004 FROM pmdn_t LEFT OUTER JOIN pmaal_t t5 ON t5.pmaal001 = pmdn_t.pmdn023 AND t5.pmaalent = pmdn_t.pmdnent AND t5.pmaal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN imaal_t ON imaal_t.imaal001 = pmdn_t.pmdn001 AND imaal_t.imaalent = pmdn_t.pmdnent AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN imaal_t t10 ON t10.imaal001 = pmdn_t.pmdn003 AND t10.imaalent = pmdn_t.pmdnent AND t10.imaal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN imaa_t ON imaa_t.imaa001 = pmdn_t.pmdn001 AND imaa_t.imaaent = pmdn_t.pmdnent ",  
        "                          LEFT OUTER JOIN oocql_t ON oocqlent = pmdnent AND oocql001 = '2003' AND oocql002 = imaa127 AND oocql003 = '",g_dlang,"' ", #151106-00004#9 20151123 s983961--add(oocql_t)
        " ) x  ON pmdl_t.pmdlent = x.pmdnent AND pmdl_t.pmdldocno = x.pmdndocno"
 
#   #end add-point
#    LET g_from = " FROM pmdl_t LEFT OUTER JOIN ( SELECT pmdn_t.*,( SELECT pmaal004 FROM pmaal_t t5 WHERE t5.pmaal001 = pmdn_t.pmdn023 AND t5.pmaalent = pmdn_t.pmdnent AND t5.pmaal002 = '" , 
#        g_dlang,"'" ,") t5_pmaal004,( SELECT imaal003 FROM imaal_t WHERE imaal_t.imaal001 = pmdn_t.pmdn001 AND imaal_t.imaalent = pmdn_t.pmdnent AND imaal_t.imaal002 = '" , 
#        g_dlang,"'" ,") imaal_t_imaal003,( SELECT imaal003 FROM imaal_t t10 WHERE t10.imaal001 = pmdn_t.pmdn003 AND t10.imaalent = pmdn_t.pmdnent AND t10.imaal002 = '" , 
#        g_dlang,"'" ,") t10_imaal003 FROM pmdn_t ) x  ON pmdl_t.pmdlent = x.pmdnent AND pmdl_t.pmdldocno  
#        = x.pmdndocno"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE pmdl_t.pmdlstus = 'Y' AND " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   #dorislai-20150821-modify----(S)   日期格式不相同，需做轉換
#    LET g_where = g_where CLIPPED," AND  pmdldocdt  BETWEEN '",tm.bdate,"' AND '",tm.edate,"' "
   LET g_where = g_where CLIPPED," AND  pmdldocdt  BETWEEN to_date('",tm.bdate,"','yy-mm-dd') AND to_date('",tm.edate,"','yy-mm-dd') "
   #dorislai-20150821-modify----(E)
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("pmdl_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   DISPLAY "g_sql   :",g_sql

   PREPARE apmr050_x01_prepare02 FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE apmr050_x01_curs02 CURSOR FOR apmr050_x01_prepare02
   
   #最低   
   LET g_sql = " SELECT MIN(pmdn015) ", 
               "   FROM apmr050_tmp01 ",   #160727-00019#13   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmr050_x01_temp01 ——> apmr050_tmp01
               "  WHERE l_pmdl004_pmaal004 = ?",
               "    AND pmdl015 =?",
               "    AND pmdn001 =? "  
   PREPARE apmr050_x01_min_pmdn015_pre FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF                                              
       
   #平均
   LET g_sql = " SELECT SUM(pmdn015),COUNT(*) ", 
               "   FROM apmr050_tmp01 ",   #160727-00019#13   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmr050_x01_temp01 ——> apmr050_tmp01
               "  WHERE l_pmdl004_pmaal004 = ?",
               "    AND pmdl015 =?",
               "    AND pmdn001 =? "  
   PREPARE apmr050_x01_average_pmdn015_pre FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
              
   #最高 
   LET g_sql = " SELECT MAX(pmdn015) ", 
               "   FROM apmr050_tmp01 ",   #160727-00019#13   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmr050_x01_temp01 ——> apmr050_tmp01
               "  WHERE l_pmdl004_pmaal004 = ?",
               "    AND pmdl015 =? ",
               "    AND pmdn001 =? "  
   PREPARE apmr050_x01_max_pmdn015_pre FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
                                                                         
   #最近
   LET g_sql = " SELECT pmdn015 ", 
               "   FROM apmr050_tmp01 ",   #160727-00019#13   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmr050_x01_temp01 ——> apmr050_tmp01
               "  WHERE l_pmdl004_pmaal004 = ? ",
               "    AND pmdl015 =? ",
               "    AND pmdn001 =? ",
               "  ORDER BY pmdldocdt DESC,pmdlcnfdt DESC"             
   PREPARE apmr050_x01_recent_pmdn015_pre FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE apmr050_x01_recent_pmdn015_curs CURSOR FOR apmr050_x01_recent_pmdn015_pre    

    #最低   
   LET g_sql = " SELECT MIN(pmdn015) ", 
               "   FROM apmr050_tmp01 ",   #160727-00019#13   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmr050_x01_temp01 ——> apmr050_tmp01
               "  WHERE pmdl015 =?",
               "    AND pmdn001 =? "  
   PREPARE apmr050_x01_min_pmdn015_pre02 FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF                                              
       
   #平均
   LET g_sql = " SELECT SUM(pmdn015),COUNT(*) ", 
               "   FROM apmr050_tmp01 ",   #160727-00019#13   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmr050_x01_temp01 ——> apmr050_tmp01
               "  WHERE pmdl015 =?",
               "    AND pmdn001 =? "  
   PREPARE apmr050_x01_average_pmdn015_pre02 FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
              
   #最高 
   LET g_sql = " SELECT MAX(pmdn015) ", 
               "   FROM apmr050_tmp01 ",   #160727-00019#13   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmr050_x01_temp01 ——> apmr050_tmp01
               "  WHERE  pmdl015 =? ",
               "    AND pmdn001 =? "  
   PREPARE apmr050_x01_max_pmdn015_pre02 FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
                                                                         
   #最近
   LET g_sql = " SELECT pmdn015 ", 
               "   FROM apmr050_tmp01 ",   #160727-00019#13   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmr050_x01_temp01 ——> apmr050_tmp01
               "  WHERE pmdl015 =? ",
               "    AND pmdn001 =? ",
               "  ORDER BY pmdldocdt DESC,pmdlcnfdt DESC"             
   PREPARE apmr050_x01_recent_pmdn015_pre02 FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE apmr050_x01_recent_pmdn015_curs02 CURSOR FOR apmr050_x01_recent_pmdn015_pre02    

   #依 幣別 料件分群
   LET g_select = " SELECT DISTINCT '','','','','','','','','','', 
                                    '','','',pmdl015 ,'','','','','','','','',    
                                    '','','','','','','','','','','','', 
                                    '','','','','','','','','','','','','','','','','','',pmdn001 ,0,'',0,0,0,'','','', 
                                    '','','','','','','','','','','','', 
                                    '','','','','','','','','','','','', 
                                    '','','','','','','','','','','','', 
                                     '','','','','','','','','','','','', 
                                     '','','','','','','','','','',
                                     '','','','','','','','','',
                                     '','','','',''"                  
   LET g_from  = " FROM apmr050_tmp01"  #160727-00019#13   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmr050_x01_temp01 ——> apmr050_tmp01
   LET g_where = " WHERE 1=1"
   
   PREPARE apmr050_x01_prepare03 FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE apmr050_x01_curs03 CURSOR FOR apmr050_x01_prepare03

   #依廠商 幣別 料件分群
   LET g_select = " SELECT DISTINCT '','','','','','','','','','', 
                                    '','','',pmdl015 ,'','','','','','','','',    
                                    '','','','','','','','','','','','', 
                                    '','','','','','','','','','','','','','','','','','',pmdn001 ,0,'',0,0,0,'','','', 
                                    '','','','','','','','','','','','', 
                                    '','','','','','','','','','','','', 
                                    '','','','','','','','','','','','', 
                                     '','','','','','','','','','','','', 
                                     '','','','','','','','','','',
                                     '','','','','',l_pmdl004_pmaal004,'','','',
                                     '','',l_imaa127,l_imaa127_desc,l_imaa127desc"     #151106-00004#9 s983961--add(l_imaa127,l_imaa127_desc,l_imaa127desc)             
   LET g_from  = " FROM apmr050_tmp01"  #160727-00019#13   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmr050_x01_temp01 ——> apmr050_tmp01
   LET g_where = " WHERE 1=1"
    
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   #end add-point
   PREPARE apmr050_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE apmr050_x01_curs CURSOR FOR apmr050_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="apmr050_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION apmr050_x01_ins_data()
DEFINE sr RECORD 
   pmdl001 LIKE pmdl_t.pmdl001, 
   pmdl002 LIKE pmdl_t.pmdl002, 
   pmdl003 LIKE pmdl_t.pmdl003, 
   pmdl004 LIKE pmdl_t.pmdl004, 
   pmdl005 LIKE pmdl_t.pmdl005, 
   pmdl006 LIKE pmdl_t.pmdl006, 
   pmdl007 LIKE pmdl_t.pmdl007, 
   pmdl008 LIKE pmdl_t.pmdl008, 
   pmdl009 LIKE pmdl_t.pmdl009, 
   pmdl010 LIKE pmdl_t.pmdl010, 
   pmdl011 LIKE pmdl_t.pmdl011, 
   pmdl012 LIKE pmdl_t.pmdl012, 
   pmdl013 LIKE pmdl_t.pmdl013, 
   pmdl015 LIKE pmdl_t.pmdl015, 
   pmdl016 LIKE pmdl_t.pmdl016, 
   pmdl017 LIKE pmdl_t.pmdl017, 
   pmdl018 LIKE pmdl_t.pmdl018, 
   pmdl019 LIKE pmdl_t.pmdl019, 
   pmdl020 LIKE pmdl_t.pmdl020, 
   pmdl021 LIKE pmdl_t.pmdl021, 
   pmdl022 LIKE pmdl_t.pmdl022, 
   pmdl023 LIKE pmdl_t.pmdl023, 
   pmdl024 LIKE pmdl_t.pmdl024, 
   pmdl025 LIKE pmdl_t.pmdl025, 
   pmdl026 LIKE pmdl_t.pmdl026, 
   pmdl027 LIKE pmdl_t.pmdl027, 
   pmdl028 LIKE pmdl_t.pmdl028, 
   pmdl029 LIKE pmdl_t.pmdl029, 
   pmdl030 LIKE pmdl_t.pmdl030, 
   pmdl031 LIKE pmdl_t.pmdl031, 
   pmdl032 LIKE pmdl_t.pmdl032, 
   pmdl033 LIKE pmdl_t.pmdl033, 
   pmdl040 LIKE pmdl_t.pmdl040, 
   pmdl041 LIKE pmdl_t.pmdl041, 
   pmdl042 LIKE pmdl_t.pmdl042, 
   pmdl043 LIKE pmdl_t.pmdl043, 
   pmdl044 LIKE pmdl_t.pmdl044, 
   pmdl046 LIKE pmdl_t.pmdl046, 
   pmdl047 LIKE pmdl_t.pmdl047, 
   pmdl048 LIKE pmdl_t.pmdl048, 
   pmdl049 LIKE pmdl_t.pmdl049, 
   pmdl051 LIKE pmdl_t.pmdl051, 
   pmdl052 LIKE pmdl_t.pmdl052, 
   pmdl053 LIKE pmdl_t.pmdl053, 
   pmdl054 LIKE pmdl_t.pmdl054, 
   pmdl055 LIKE pmdl_t.pmdl055, 
   pmdldocdt LIKE pmdl_t.pmdldocdt, 
   pmdldocno LIKE pmdl_t.pmdldocno, 
   pmdlent LIKE pmdl_t.pmdlent, 
   pmdlsite LIKE pmdl_t.pmdlsite, 
   pmdlstus LIKE pmdl_t.pmdlstus, 
   pmdlunit LIKE pmdl_t.pmdlunit, 
   pmdn001 LIKE pmdn_t.pmdn001, 
   l_pmdn015_min LIKE type_t.num20_6, 
   pmdlcnfdt LIKE pmdl_t.pmdlcnfdt, 
   l_pmdn015_average LIKE type_t.num20_6, 
   l_pmdn015_recent LIKE type_t.num20_6, 
   l_pmdn015_max LIKE type_t.num20_6, 
   pmdn002 LIKE pmdn_t.pmdn002, 
   pmdn003 LIKE pmdn_t.pmdn003, 
   pmdn004 LIKE pmdn_t.pmdn004, 
   pmdn005 LIKE pmdn_t.pmdn005, 
   pmdn006 LIKE pmdn_t.pmdn006, 
   pmdn007 LIKE pmdn_t.pmdn007, 
   pmdn008 LIKE pmdn_t.pmdn008, 
   pmdn009 LIKE pmdn_t.pmdn009, 
   pmdn010 LIKE pmdn_t.pmdn010, 
   pmdn011 LIKE pmdn_t.pmdn011, 
   pmdn012 LIKE pmdn_t.pmdn012, 
   pmdn013 LIKE pmdn_t.pmdn013, 
   pmdn014 LIKE pmdn_t.pmdn014, 
   pmdn015 LIKE pmdn_t.pmdn015, 
   pmdn016 LIKE pmdn_t.pmdn016, 
   pmdn017 LIKE pmdn_t.pmdn017, 
   pmdn019 LIKE pmdn_t.pmdn019, 
   pmdn020 LIKE pmdn_t.pmdn020, 
   pmdn021 LIKE pmdn_t.pmdn021, 
   pmdn022 LIKE pmdn_t.pmdn022, 
   pmdn023 LIKE pmdn_t.pmdn023, 
   pmdn024 LIKE pmdn_t.pmdn024, 
   pmdn025 LIKE pmdn_t.pmdn025, 
   pmdn026 LIKE pmdn_t.pmdn026, 
   pmdn027 LIKE pmdn_t.pmdn027, 
   pmdn028 LIKE pmdn_t.pmdn028, 
   pmdn029 LIKE pmdn_t.pmdn029, 
   pmdn030 LIKE pmdn_t.pmdn030, 
   pmdn031 LIKE pmdn_t.pmdn031, 
   pmdn032 LIKE pmdn_t.pmdn032, 
   pmdn033 LIKE pmdn_t.pmdn033, 
   pmdn035 LIKE pmdn_t.pmdn035, 
   pmdn036 LIKE pmdn_t.pmdn036, 
   pmdn037 LIKE pmdn_t.pmdn037, 
   pmdn038 LIKE pmdn_t.pmdn038, 
   pmdn039 LIKE pmdn_t.pmdn039, 
   pmdn040 LIKE pmdn_t.pmdn040, 
   pmdn041 LIKE pmdn_t.pmdn041, 
   pmdn042 LIKE pmdn_t.pmdn042, 
   pmdn043 LIKE pmdn_t.pmdn043, 
   pmdn044 LIKE pmdn_t.pmdn044, 
   pmdn045 LIKE pmdn_t.pmdn045, 
   pmdn046 LIKE pmdn_t.pmdn046, 
   pmdn047 LIKE pmdn_t.pmdn047, 
   pmdn048 LIKE pmdn_t.pmdn048, 
   pmdn049 LIKE pmdn_t.pmdn049, 
   pmdn050 LIKE pmdn_t.pmdn050, 
   pmdn051 LIKE pmdn_t.pmdn051, 
   pmdn052 LIKE pmdn_t.pmdn052, 
   pmdn053 LIKE pmdn_t.pmdn053, 
   pmdn054 LIKE pmdn_t.pmdn054, 
   pmdn055 LIKE pmdn_t.pmdn055, 
   pmdn056 LIKE pmdn_t.pmdn056, 
   pmdn057 LIKE pmdn_t.pmdn057, 
   pmdnorga LIKE pmdn_t.pmdnorga, 
   pmdnseq LIKE pmdn_t.pmdnseq, 
   pmdnsite LIKE pmdn_t.pmdnsite, 
   pmdnunit LIKE pmdn_t.pmdnunit, 
   pmaal_t_pmaal004 LIKE pmaal_t.pmaal004, 
   t1_pmaal004 LIKE pmaal_t.pmaal004, 
   t2_pmaal004 LIKE pmaal_t.pmaal004, 
   t3_pmaal004 LIKE pmaal_t.pmaal004, 
   t4_pmaal004 LIKE pmaal_t.pmaal004, 
   x_t5_pmaal004 LIKE pmaal_t.pmaal004, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   x_t10_imaal003 LIKE imaal_t.imaal003, 
   l_pmdl004_pmaal004 LIKE type_t.chr100, 
   l_pmdl021_pmaal004 LIKE type_t.chr100, 
   l_pmdl022_pmaal004 LIKE type_t.chr100, 
   l_pmdl032_pmaal004 LIKE type_t.chr100, 
   l_pmdl052_pmaal004 LIKE type_t.chr100, 
   l_pmdn023_pmaal004 LIKE type_t.chr100, 
   l_imaa127 LIKE type_t.chr30, 
   l_imaa127_desc LIKE type_t.chr50, 
   l_imaa127desc LIKE type_t.chr80
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
   DEFINE l_pmdn015    LIKE pmdn_t.pmdn015
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_oodbl004   LIKE oodbl_t.oodbl004  
   DEFINE l_oodb005    LIKE oodb_t.oodb005    
   DEFINE l_oodb006    LIKE oodb_t.oodb006    
   DEFINE l_oodb011    LIKE oodb_t.oodb011
   DEFINE l_tot_cnt    LIKE type_t.num10
   DEFINE l_tot_price  LIKE pmdn_t.pmdn015
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    FOREACH apmr050_x01_curs02 INTO sr.*                               
       IF STATUS THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = 'foreach:'
          LET g_errparam.code   = STATUS
          LET g_errparam.popup  = TRUE
          CALL cl_err()
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF
       CALL s_tax_chk(sr.pmdlsite,sr.pmdn016)
          RETURNING l_success,l_oodbl004,l_oodb005,l_oodb006,l_oodb011
          
       IF l_oodb005 = 'Y' THEN
          LET l_pmdn015 = sr.pmdn015 / (1 + l_oodb006/100)
       ELSE
          LET l_pmdn015 = sr.pmdn015
       END IF       
       #160727-00019#13   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmr050_x01_temp01 ——> apmr050_tmp01           
       INSERT INTO apmr050_tmp01 VALUES (sr.pmdldocdt,sr.pmdlcnfdt,sr.pmdl015,sr.pmdn001,sr.l_pmdl004_pmaal004,l_pmdn015,sr.l_imaa127,sr.l_imaa127_desc,sr.l_imaa127desc)  #151106-00004#9 s983961--add(l_imaa127,l_imaa127_desc,l_imaa127desc)
    END FOREACH   
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH apmr050_x01_curs INTO sr.*                               
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
       #最低 
       EXECUTE apmr050_x01_min_pmdn015_pre USING sr.l_pmdl004_pmaal004,sr.pmdl015,sr.pmdn001
                                            INTO sr.l_pmdn015_min    
       IF cl_null(sr.l_pmdn015_min) THEN LET sr.l_pmdn015_min = 0 END IF  
       
       #平均
       LET l_tot_price =0 
       LET l_tot_cnt   =0
       EXECUTE apmr050_x01_average_pmdn015_pre USING sr.l_pmdl004_pmaal004,sr.pmdl015,sr.pmdn001
                                                INTO l_tot_price,l_tot_cnt
       IF cl_null(l_tot_price) THEN LET l_tot_price = 0 END IF 
       IF cl_null(l_tot_cnt) THEN LET l_tot_cnt = 0 END IF       
       
       LET sr.l_pmdn015_average = l_tot_price/l_tot_cnt
       IF cl_null(sr.l_pmdn015_average) THEN LET sr.l_pmdn015_average = 0 END IF
       
       #最高 
       EXECUTE apmr050_x01_max_pmdn015_pre USING sr.l_pmdl004_pmaal004,sr.pmdl015,sr.pmdn001
                                            INTO sr.l_pmdn015_max 
       IF cl_null(sr.l_pmdn015_max) THEN LET sr.l_pmdn015_max = 0 END IF                                     
                                            
       #最近
       FOREACH apmr050_x01_recent_pmdn015_curs USING sr.l_pmdl004_pmaal004,sr.pmdl015,sr.pmdn001
                                               INTO sr.l_pmdn015_recent
          EXIT FOREACH
       END FOREACH                                               
       IF cl_null(sr.l_pmdn015_recent) THEN LET sr.l_pmdn015_recent = 0 END IF
       #151106-00004#9 20151123 s983961--mark(s)
       ##系列號  20150821  by  dorislai  add   (S)
       #   #用料號抓取系列
       #SELECT imaa127 INTO sr.l_imaa127 FROM imaa_t
       # WHERE imaa001 = sr.pmdn001
       #   AND imaaent = g_enterprise
       #   #抓取系列說明
       #CALL s_desc_get_acc_desc('2003',sr.l_imaa127)  RETURNING sr.l_imaa127_desc   
       #IF NOT cl_null(sr.l_imaa127_desc) THEN
       #   LET sr.l_imaa127desc = sr.l_imaa127,'.',sr.l_imaa127_desc 
       #ELSE
       #   LET sr.l_imaa127desc = ''
       #END IF
       #        20150821  by  dorislai  add   (E)
       #151106-00004#9 20151123 s983961--mark(e)
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.pmdl015,sr.pmdn001,sr.l_pmdn015_min,sr.pmdlcnfdt,sr.l_pmdn015_average,sr.l_pmdn015_recent,sr.l_pmdn015_max,sr.l_pmdl004_pmaal004,sr.l_imaa127,sr.l_imaa127_desc,sr.l_imaa127desc
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "apmr050_x01_execute"
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
    FOREACH apmr050_x01_curs03 INTO sr.*                               
       IF STATUS THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = 'foreach:'
          LET g_errparam.code   = STATUS
          LET g_errparam.popup  = TRUE
          CALL cl_err()
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF
       CALL cl_getmsg('axm-00699',g_dlang) RETURNING sr.l_pmdl004_pmaal004
       LET sr.l_pmdl004_pmaal004 = '.',sr.l_pmdl004_pmaal004
       
       #最低          
       EXECUTE apmr050_x01_min_pmdn015_pre02 USING sr.pmdl015,sr.pmdn001
                                              INTO sr.l_pmdn015_min    
       IF cl_null(sr.l_pmdn015_min) THEN LET sr.l_pmdn015_min = 0 END IF  
       
       #平均
       LET l_tot_price =0 
       LET l_tot_cnt   =0
       EXECUTE apmr050_x01_average_pmdn015_pre02 USING sr.pmdl015,sr.pmdn001
                                                  INTO l_tot_price,l_tot_cnt
       IF cl_null(l_tot_price) THEN LET l_tot_price = 0 END IF 
       IF cl_null(l_tot_cnt) THEN LET l_tot_cnt = 0 END IF       
       
       LET sr.l_pmdn015_average = l_tot_price/l_tot_cnt
       IF cl_null(sr.l_pmdn015_average) THEN LET sr.l_pmdn015_average = 0 END IF
       
       #最高 
       EXECUTE apmr050_x01_max_pmdn015_pre02 USING sr.pmdl015,sr.pmdn001
                                              INTO sr.l_pmdn015_max 
       IF cl_null(sr.l_pmdn015_max) THEN LET sr.l_pmdn015_max = 0 END IF                                     
                                            
       #最近
       FOREACH apmr050_x01_recent_pmdn015_curs02 USING sr.pmdl015,sr.pmdn001
                                                  INTO sr.l_pmdn015_recent
          EXIT FOREACH
       END FOREACH                                               
       IF cl_null(sr.l_pmdn015_recent) THEN LET sr.l_pmdn015_recent = 0 END IF
       
 
       #EXECUTE
       EXECUTE insert_prep USING sr.pmdl015,sr.pmdn001,sr.l_pmdn015_min,sr.pmdlcnfdt,sr.l_pmdn015_average,sr.l_pmdn015_recent,sr.l_pmdn015_max,sr.l_pmdl004_pmaal004
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "apmr050_x01_execute"
          LET g_errparam.code   = SQLCA.sqlcode
          LET g_errparam.popup  = FALSE
          CALL cl_err()       
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF    
       
    END FOREACH
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apmr050_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION apmr050_x01_rep_data()
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
 
{<section id="apmr050_x01.other_function" readonly="Y" >}

 
{</section>}
 
