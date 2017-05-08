#該程式未解開Section, 採用最新樣板產出!
{<section id="abmr003_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:6(2016-05-23 17:24:20), PR版次:0006(2016-05-23 17:50:15)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000081
#+ Filename...: abmr003_x01
#+ Description: ...
#+ Creator....: 02748(2014-09-22 15:57:52)
#+ Modifier...: 05384 -SD/PR- 05384
 
{</section>}
 
{<section id="abmr003_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#160112-00004#1    160112 02040  增加主件料號排序
#160322-00029#1   2016/05/23 By shiun     效能改善
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
       combo LIKE type_t.chr1,         #展階選項 
       flag LIKE type_t.chr1,         #考慮取替代料 
       date LIKE bmba_t.bmba005          #有效日期
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_wc            STRING
DEFINE g_wc_site       LIKE bmaa_t.bmaasite   #add--160322-00029#1 By shiun
#end add-point
 
{</section>}
 
{<section id="abmr003_x01.main" readonly="Y" >}
PUBLIC FUNCTION abmr003_x01(p_arg1,p_arg2,p_arg3,p_arg4)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr1         #tm.combo  展階選項 
DEFINE  p_arg3 LIKE type_t.chr1         #tm.flag  考慮取替代料 
DEFINE  p_arg4 LIKE bmba_t.bmba005         #tm.date  有效日期
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.combo = p_arg2
   LET tm.flag = p_arg3
   LET tm.date = p_arg4
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "abmr003_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL abmr003_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL abmr003_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL abmr003_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL abmr003_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL abmr003_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="abmr003_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION abmr003_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "imaa001.imaa_t.imaa001,l_imaal003.imaal_t.imaal003,l_imaal004.imaal_t.imaal004,imac003.imac_t.imac003,l_imaa009.rtaxl_t.rtaxl003" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   LET g_sql = "bmaa001.bmaa_t.bmaa001,",
               "l_bmaa001_desc.imaal_t.imaal003,",
               "l_bmaa001_desc1.imaal_t.imaal004,",
               "bmaa002.bmaa_t.bmaa002,",
               "l_imac003.imac_t.imac003,",
               "bmba004_desc.oocql_t.oocql004,",
               "bmba007_desc.oocql_t.oocql004,",
               "l_bmba011.type_t.chr1000,",
               "bmea007_desc.gzcbl_t.gzcbl004,",
               "bmba003.bmba_t.bmba003,",
               "l_bmba003_desc.imaal_t.imaal003,",
               "l_bmba003_desc1.imaal_t.imaal004,",
               "l_bmea011.type_t.chr1000,",
               "l_bmea012.type_t.chr1000,",
               "inag009.inag_t.inag009,",
               "l_imaa001.imaa_t.imaa001"               
   
   #建立TEMP TABLE,主報表序號2
   IF NOT cl_xg_create_tmptable(g_sql,2) THEN
      LET g_rep_success = 'N'            
   END IF
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="abmr003_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION abmr003_x01_ins_prep()
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
         LET g_sql = " INSERT INTO ",g_rep_db CLIPPED,g_rep_tmpname[1] CLIPPED," VALUES(?,?,?,?,?)"
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
         #INSERT INTO PREP
         LET g_sql = " INSERT INTO ",g_rep_db CLIPPED,g_rep_tmpname[2] CLIPPED," VALUES(?,?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?)"
         PREPARE insert_prep2 FROM g_sql
         IF STATUS THEN
            LET l_prep_str ="insert_prep2",i
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
 
{<section id="abmr003_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION abmr003_x01_sel_prep()
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
   LET g_select = " SELECT imaa001,imaal003,imaal004,imac003,trim(imaa009)||'.'||trim(rtaxl003)"
#   #end add-point
#   LET g_select = " SELECT imaa001,'','',imac003,trim(imaa009)||'.'||trim(rtaxl_t.rtaxl003)"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_from = " FROM imaa_t ",
                " LEFT OUTER JOIN imac_t ON imacent = imaaent AND imac001 = imaa001 ",
                " LEFT OUTER JOIN rtaxl_t ON rtaxlent = imaaent AND rtaxl001 = imaa009 AND rtaxl002 = '",g_dlang,"' ",
                " LEFT OUTER JOIN imaal_t ON imaalent = imaaent AND imaal001 = imaa001 AND imaal002 = '",g_dlang,"' "
#   #end add-point
#    LET g_from = " FROM imaa_t,imac_t,rtaxl_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET g_where = " WHERE imaaent = ",g_enterprise," AND ",tm.wc CLIPPED
   
   LET g_wc = " bmba005 <= to_date('",tm.date,"','YYYY-MM-DD HH24:MI:SS') AND (bmba006 IS NULL OR (bmba006 IS NOT NULL AND bmba006 >= to_date('",tm.date,"','YYYY-MM-DD HH24:MI:SS') )) "
   #LET g_wc = " bmba005 <= '",tm.date,"' AND (bmba006 IS NULL OR (bmba006 IS NOT NULL AND bmba006 >= '",tm.date,"' )) "
   
   IF g_prog = 'abmr003' THEN
      LET g_wc = g_wc," AND bmbasite = 'ALL' "
      LET g_wc_site = 'ALL'   #add--160322-00029#1 By shiun
   ELSE
      LET g_wc = g_wc," AND bmbasite = '",g_site,"'"
      LET g_wc_site = g_site   #add--160322-00029#1 By shiun
   END IF
   
   IF tm.flag = 'Y' THEN
      LET g_where = g_where," AND (EXISTS (SELECT 1 FROM bmea_t,bmba_t,bmaa_t ",
                           #"              WHERE bmeaent = bmbaent AND bmeasite = bmbasite AND bmea001 = bmba001 AND bmea002 = bmba002 ",                      #151028 Sarah mark
                            "              WHERE bmeaent = bmbaent AND bmeasite = bmbasite AND (bmea001 = bmba001 OR bmea001='ALL') AND bmea002 = bmba002 ",   #151028 Sarah mod
                            #"                AND bmea003 = bmba003 AND bmea004 = bmba004 AND bmea005 = bmba007 AND bmea006 = bmba008 AND bmea009 = bmba005 ",
                            "                AND bmea003 = bmba003 AND bmea004 = bmba004 AND bmea005 = bmba007 AND bmea006 = bmba008 AND to_date(bmea009,'YYYY-MM-DD HH24:MI:SS') <= to_date('",tm.date,"','YYYY-MM-DD HH24:MI:SS') AND (bmea010 IS NULL OR (bmea010 IS NOT NULL AND to_date(bmea010,'YYYY-MM-DD HH24:MI:SS') >= to_date('",tm.date,"','YYYY-MM-DD HH24:MI:SS') ))",
                            "                AND bmbaent = bmaaent AND bmbasite = bmaasite AND bmba001 = bmaa001 AND bmba002 = bmaa002 ",
                            "                AND bmbaent = imaaent AND bmea008 = imaa001 AND bmaastus <> 'X' AND ",g_wc,") ",
                            " OR EXISTS (SELECT 1 FROM bmba_t,bmaa_t ",
                            "              WHERE bmbaent = bmaaent AND bmbasite = bmaasite AND bmba001 = bmaa001 AND bmba002 = bmaa002 ",
                            "                AND bmbaent = imaaent AND bmba003 = imaa001 AND bmaastus <> 'X' AND ",g_wc,")) "
   ELSE
      LET g_where = g_where," AND EXISTS (SELECT 1 FROM bmba_t,bmaa_t ",
                            "              WHERE bmbaent = bmaaent AND bmbasite = bmaasite AND bmba001 = bmaa001 AND bmba002 = bmaa002 ",
                            "                AND bmbaent = imaaent AND bmba003 = imaa001 AND bmaastus <> 'X' AND ",g_wc,") "
   END IF
   
   
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("imaa_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_where = g_where,"ORDER BY imaa001"   #151229-00006#1 add
   #end add-point
   PREPARE abmr003_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE abmr003_x01_curs CURSOR FOR abmr003_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="abmr003_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION abmr003_x01_ins_data()
DEFINE sr RECORD 
   imaa001 LIKE imaa_t.imaa001, 
   l_imaal003 LIKE imaal_t.imaal003, 
   l_imaal004 LIKE imaal_t.imaal004, 
   imac003 LIKE imac_t.imac003, 
   l_imaa009 LIKE rtaxl_t.rtaxl003
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
#add--160322-00029#1 By shiun--(S)
DEFINE l_success     LIKE type_t.num5
DEFINE l_i           LIKE type_t.num10
DEFINE l_rec         LIKE type_t.num10
DEFINE l_sql         STRING
DEFINE l_sql1        STRING
DEFINE l_sql2        STRING
DEFINE l_bmba001     LIKE bmba_t.bmba001
DEFINE l_bmba003     LIKE bmba_t.bmba003
DEFINE l_bmba011     LIKE bmba_t.bmba011
DEFINE l_bmba011_sum LIKE bmba_t.bmba011
DEFINE l_bmea011      LIKE type_t.chr1000
DEFINE l_bmea012      LIKE type_t.chr1000
DEFINE l_imaa001     DYNAMIC ARRAY OF LIKE imaa_t.imaa001
DEFINE l_final_chk   LIKE type_t.num5
DEFINE sr2 RECORD 
   bmaa001            LIKE bmaa_t.bmaa001, 
   l_bmaa001_desc     LIKE imaal_t.imaal003, 
   l_bmaa001_desc1    LIKE imaal_t.imaal004,
   bmaa002            LIKE bmaa_t.bmaa002,    
   l_imac003          LIKE imac_t.imac003, 
   bmba004_desc       LIKE oocql_t.oocql004,
   bmba007_desc       LIKE oocql_t.oocql004,
   bmba011            LIKE bmba_t.bmba011,
   bmea007_desc       LIKE gzcbl_t.gzcbl004,
   bmba003            LIKE bmba_t.bmba003,
   l_bmba003_desc     LIKE imaal_t.imaal003,
   l_bmba003_desc1    LIKE imaal_t.imaal004,
   bmea011            LIKE bmea_t.bmea011,
   bmea012            LIKE bmea_t.bmea012,
   inag009            LIKE inag_t.inag009,
   bmba002            LIKE bmba_t.bmba002
 END RECORD
#add--160322-00029#1 By shiun--(E)
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    #add--160322-00029#1 By shiun--(S)
    CALL abmr003_x01_create_tmp() RETURNING l_success
    LET l_i = 1
    #add--160322-00029#1 By shiun--(E)
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH abmr003_x01_curs INTO sr.*                               
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
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.imaa001,sr.l_imaal003,sr.l_imaal004,sr.imac003,sr.l_imaa009
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "abmr003_x01_execute"
          LET g_errparam.code   = SQLCA.sqlcode
          LET g_errparam.popup  = FALSE
          CALL cl_err()       
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF
 
       #add-point:ins_data段after_save name="ins_data.after.save"
       #mod--160322-00029#1 By shiun--(S)
#       IF NOT abmr003_x01_bom(sr.imaa001) THEN
#          LET g_rep_success = 'N'
#          EXIT FOREACH
#       END IF
       LET l_imaa001[l_i] = sr.imaa001
       LET l_i = l_i + 1
       IF tm.combo <> '1' THEN
          IF NOT abmr003_x01_bom_s(sr.imaa001) THEN
             LET g_rep_success = 'N'
             EXIT FOREACH
          ELSE
             IF tm.flag = 'Y' THEN
                IF NOT abmr003_x01_bom_bmea(sr.imaa001) THEN
                   LET g_rep_success = 'N'
                   EXIT FOREACH
                END IF
             END IF
          END IF
       ELSE
          IF NOT abmr003_x01_bom(sr.imaa001) THEN
             LET g_rep_success = 'N'
             EXIT FOREACH
          END IF
       END IF
       #mod--160322-00029#1 By shiun--(E)
       #end add-point
       
    END FOREACH
    
    #add-point:ins_data段after name="ins_data.after"
    #add--160322-00029#1 By shiun--(S)
    LET l_sql = "MERGE INTO abmr003_tmp t0 ",
          "      USING (SELECT * FROM abmr003_tmp) tqc",
          "         ON (t0.bmba003 = tqc.bmba001 AND t0.imaa001 = tqc.imaa001) ",
          "       WHEN MATCHED THEN ",
          "     UPDATE SET t0.bmba011_sum = tqc.bmba011_sum * t0.bmba011"
    PREPARE abmr003_merge FROM l_sql
    EXECUTE abmr003_merge
    LET l_rec = l_i - 1
    FOR l_i = 1 TO l_rec
       LET l_sql1 = " SELECT bmba001,imaal003,imaal004,bmba002,imac003,t1.oocql004, ",
                    "        t2.oocql004,bmba011_sum,'','','', ",
                    "        '','','','',bmba002 ", 
                    "   FROM abmr003_tmp ",
                    "   LEFT OUTER JOIN imac_t ON imacent = '",g_enterprise,"' AND imac001 = bmba001 ",
                    "   LEFT OUTER JOIN imaal_t ON imaalent = '",g_enterprise,"' AND imaal001 = bmba001 AND imaal002 = '",g_dlang,"' ",
                    "   LEFT OUTER JOIN oocql_t t1 ON t1.oocqlent = '",g_enterprise,"' AND t1.oocql001 = '215' AND t1.oocql002 = bmba004 AND t1.oocql003 = '",g_dlang,"' ",
                    "   LEFT OUTER JOIN oocql_t t2 ON t2.oocqlent = '",g_enterprise,"' AND t2.oocql001 = '221' AND t2.oocql002 = bmba007 AND t2.oocql003 = '",g_dlang,"' ",
                    "  WHERE imaa001 = '",l_imaa001[l_i],"' "
#       IF tm.combo = '3' THEN   #如果是尾階
#          LET l_sql2 = "  SELECT * ",
#                       "    FROM bmba_t ",
#                       "   WHERE bmbasite = '",g_wc_site,"' AND CONNECT_BY_ISLEAF = 1 ",  
#                       "   START WITH (bmba001,bmba002,bmba003) IN( ",
#                       "  SELECT DISTINCT bmba001,bmba002,bmba003 ",
#                       "    FROM bmba_t WHERE bmbaent = '",g_enterprise,"' AND bmba003='",l_imaa001[l_i],"' AND ",g_wc," ) ",
#                       " CONNECT BY NOCYCLE PRIOR bmba001 = bmba003 AND PRIOR bmba002 = bmba002 AND bmbasite = '",g_wc_site,"' ORDER BY bmba001 "
#                       
#          LET l_sql1 = l_sql1 CLIPPED, " AND bmba001 IN ( SELECT DISTINCT bmba001 ",
#                                       "  FROM (",l_sql2,") b ,bmaa_t a ",
#                                       " WHERE a.bmaa001 = b.bmba001 AND a.bmaa002 = b.bmba002 ",
#                                       "   AND bmaaent = '",g_enterprise,"' AND bmaasite = bmbasite ",
#                                       "   AND ",g_wc," AND bmaastus = 'Y' ",
#                                       " )"  
#                              
#       END IF
       LET l_sql1 = l_sql1 CLIPPED,"  ORDER BY bmba001 "
          PREPARE abmr003_x01_sr2_p FROM l_sql1
          IF STATUS THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.extend = 'sr2_prepare3:'
             LET g_errparam.code   = STATUS
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             LET g_rep_success = 'N'
             RETURN
          END IF
          DECLARE abmr003_x01_sr2_c CURSOR FOR abmr003_x01_sr2_p
          
          FOREACH abmr003_x01_sr2_c INTO sr2.*
             #如果要展尾階
             IF tm.combo = '3' THEN
                LET l_final_chk = 0
                SELECT COUNT(*) INTO l_final_chk
                  FROM abmr003_tmp
                 WHERE bmba003 = sr2.bmaa001
                   AND imaa001 = l_imaa001[l_i]
                 
                 IF l_final_chk > 0 THEN
                   CONTINUE FOREACH
                 END IF
             END IF
             CALL abmr003_x01_inventory(sr2.bmaa001) RETURNING sr2.inag009
             CALL abmr003_x01_delfloat(sr2.bmba011) RETURNING l_bmba011
             CALL abmr003_x01_delfloat(sr2.bmea011) RETURNING l_bmea011
             CALL abmr003_x01_delfloat(sr2.bmea012) RETURNING l_bmea012
             #ins temp
             EXECUTE insert_prep2 USING sr2.bmaa001,sr2.l_bmaa001_desc,sr2.l_bmaa001_desc1,sr2.bmaa002,sr2.l_imac003,sr2.bmba004_desc,
                                        sr2.bmba007_desc,l_bmba011,sr2.bmea007_desc,sr2.bmba003,sr2.l_bmba003_desc,
                                        sr2.l_bmba003_desc1,l_bmea011,l_bmea012,sr2.inag009,l_imaa001[l_i]
             
             IF SQLCA.sqlcode THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = "abmr003_x01_execute2"
                LET g_errparam.code   = SQLCA.sqlcode
                LET g_errparam.popup  = FALSE
                CALL cl_err()       
                LET g_rep_success = 'N'
                EXIT FOREACH
             END IF
          END FOREACH
    END FOR
    #add--160322-00029#1 By shiun--(E)
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="abmr003_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION abmr003_x01_rep_data()
#add-point:rep_data.define (客製用) name="rep_data.define_customerization"

#end add-point:rep_data.define
#add-point:rep_data.define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="rep_data.define"

#end add-point:rep_data.define
 
    #add-point:rep_data.before name="rep_data.before"
    
    #end add-point:rep_data.before
    
    CALL cl_xg_view()
    #add-point:rep_data.after name="rep_data.after"
    CALL abmr003_x01_drop_tmp()   #add--160322-00029#1 By shiun
    #end add-point:rep_data.after
END FUNCTION
 
{</section>}
 
{<section id="abmr003_x01.other_function" readonly="Y" >}
#第一階
PRIVATE FUNCTION abmr003_x01_bom(p_imaa001)
DEFINE p_imaa001      LIKE imaa_t.imaa001
DEFINE r_success      LIKE type_t.num5
DEFINE sr RECORD 
   bmaa001            LIKE bmaa_t.bmaa001, 
   l_bmaa001_desc     LIKE imaal_t.imaal003, 
   l_bmaa001_desc1    LIKE imaal_t.imaal004,
   bmaa002            LIKE bmaa_t.bmaa002,    
   l_imac003          LIKE imac_t.imac003, 
   bmba004_desc       LIKE oocql_t.oocql004,
   bmba007_desc       LIKE oocql_t.oocql004,
   bmba011            LIKE bmba_t.bmba011,
   bmea007_desc       LIKE gzcbl_t.gzcbl004,
   bmba003            LIKE bmba_t.bmba003,
   l_bmba003_desc     LIKE imaal_t.imaal003,
   l_bmba003_desc1    LIKE imaal_t.imaal004,
   bmea011            LIKE bmea_t.bmea011,
   bmea012            LIKE bmea_t.bmea012,
   inag009            LIKE inag_t.inag009,
   bmba002            LIKE bmba_t.bmba002
 END RECORD
DEFINE l_success      LIKE type_t.num5
DEFINE l_flag         LIKE type_t.num5    #尾階
DEFINE l_bmba011      LIKE type_t.chr1000
DEFINE l_bmea011      LIKE type_t.chr1000
DEFINE l_bmea012      LIKE type_t.chr1000

   LET r_success = TRUE
   
   #BOM
   LET g_sql = " SELECT bmba001,imaal003,imaal004,bmba002,imac003,t1.oocql004, ",
               "        t2.oocql004,COALESCE(bmba011,0)/COALESCE(bmba012,1),'','','', ",
               "        '','','','',bmba002 ", 
               "   FROM bmba_t ",
               "   LEFT OUTER JOIN imac_t ON imacent = bmbaent AND imac001 = bmba001 ",
               "   LEFT OUTER JOIN imaal_t ON imaalent = bmbaent AND imaal001 = bmba001 AND imaal002 = '",g_dlang,"' ",
               "   LEFT OUTER JOIN oocql_t t1 ON t1.oocqlent = bmbaent AND t1.oocql001 = '215' AND t1.oocql002 = bmba004 AND t1.oocql003 = '",g_dlang,"' ",
               "   LEFT OUTER JOIN oocql_t t2 ON t2.oocqlent = bmbaent AND t2.oocql001 = '221' AND t2.oocql002 = bmba007 AND t2.oocql003 = '",g_dlang,"' ",
               "   ,bmaa_t ",
               "  WHERE bmbaent = bmaaent AND bmbasite = bmaasite AND bmba001 = bmaa001 AND bmba002 = bmaa002 ",
               "    AND bmaastus <> 'X' AND bmbaent = ",g_enterprise," AND bmba003 = '",p_imaa001,"' AND ",g_wc,
               "  ORDER BY bmba001 "                  #151229-00006#1 add               
   
   PREPARE abmr003_x01_p1 FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare1:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   DECLARE abmr003_x01_c1 CURSOR FOR abmr003_x01_p1
   
   #mark--160322-00029#1 By shiun--(S)
#   #取替代BOM
#   IF tm.flag = 'Y' THEN
#     #LET g_sql = " SELECT bmba001,t3.imaal003,t3.imaal004,bmba002,imac003,t1.oocql004, ",            #151028 Sarah mark
#      LET g_sql = " SELECT DISTINCT bmba001,t3.imaal003,t3.imaal004,bmba002,imac003,t1.oocql004, ",   #151028 Sarah add DISTINCT
#                  "        t2.oocql004,COALESCE(bmba011,0)/COALESCE(bmba012,1),gzcbl004,bmba003,t4.imaal003, ",
#                  "        t4.imaal004,bmea011,bmea012,'',bmba002 ", 
#                  "   FROM bmba_t ",
#                  "   LEFT OUTER JOIN imac_t ON imacent = bmbaent AND imac001 = bmba001 ",
#                  "   LEFT OUTER JOIN oocql_t t1 ON t1.oocqlent = bmbaent AND t1.oocql001 = '215' AND t1.oocql002 = bmba004 AND t1.oocql003 = '",g_dlang,"' ",
#                  "   LEFT OUTER JOIN oocql_t t2 ON t2.oocqlent = bmbaent AND t2.oocql001 = '221' AND t2.oocql002 = bmba007 AND t2.oocql003 = '",g_dlang,"' ",
#                  "   LEFT OUTER JOIN imaal_t t3 ON t3.imaalent = bmbaent AND t3.imaal001 = bmba001 AND t3.imaal002 = '",g_dlang,"' ",
#                  "   LEFT OUTER JOIN imaal_t t4 ON t4.imaalent = bmbaent AND t4.imaal001 = bmba003 AND t4.imaal002 = '",g_dlang,"' ",
#                  "   ,bmea_t ",
#                  "   LEFT OUTER JOIN gzcbl_t ON gzcbl001 = '1103' AND gzcbl002 = bmea007 AND gzcbl003 = '",g_dlang,"' ",
#                  "   ,bmaa_t ",
#                  "  WHERE bmbaent = bmaaent AND bmbasite = bmaasite AND bmba001 = bmaa001 AND bmba002 = bmaa002 ",
#                 #"    AND bmeaent = bmbaent AND bmeasite = bmbasite AND bmea001 = bmba001 AND bmea002 = bmba002 ",                      #151028 Sarah mark
#                  "    AND bmeaent = bmbaent AND bmeasite = bmbasite AND (bmea001 = bmba001 OR bmea001='ALL') AND bmea002 = bmba002 ",   #151028 Sarah mod
#                  "    AND bmea003 = bmba003 AND bmea004 = bmba004 AND bmea005 = bmba007 AND bmea006 = bmba008 AND to_date(bmea009,'YYYY-MM-DD HH24:MI:SS') <= to_date('",tm.date,"','YYYY-MM-DD HH24:MI:SS') AND (bmea010 IS NULL OR (bmea010 IS NOT NULL AND to_date(bmea010,'YYYY-MM-DD HH24:MI:SS') >= to_date('",tm.date,"','YYYY-MM-DD HH24:MI:SS') ))",
#                  #"    AND bmea003 = bmba003 AND bmea004 = bmba004 AND bmea005 = bmba007 AND bmea006 = bmba008 AND bmea009 = bmba005", #modify by shiunyo 2014/10/22
#                  "    AND bmaastus <> 'X' AND bmbaent = ",g_enterprise," AND bmea008 = '",p_imaa001,"' AND ",g_wc,
#                  "  ORDER BY bmba001 "                 #151229-00006#1 add                  
#
#      PREPARE abmr003_x01_p2 FROM g_sql
#      IF STATUS THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.extend = 'prepare2:'
#         LET g_errparam.code   = STATUS
#         LET g_errparam.popup  = TRUE
#         CALL cl_err()
#         LET r_success = FALSE
#         RETURN r_success
#      END IF
#      DECLARE abmr003_x01_c2 CURSOR FOR abmr003_x01_p2            
#   END IF
   #mark--160322-00029#1 By shiun--(E)

   FOREACH abmr003_x01_c1 INTO sr.* 
      IF STATUS THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'foreach1:'
         LET g_errparam.code   = STATUS
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      #1單階 2多階 3尾階
      IF tm.combo <> '1' THEN
         CALL abmr003_x01_bom_rec(sr.bmaa001,sr.bmba002,sr.bmba011,p_imaa001) RETURNING l_success,l_flag
         IF NOT l_success THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
      END IF
      
      IF tm.combo = '3' AND NOT l_flag THEN
         CONTINUE FOREACH
      END IF
      
      CALL abmr003_x01_inventory(sr.bmaa001) RETURNING sr.inag009
      CALL abmr003_x01_delfloat(sr.bmba011) RETURNING l_bmba011
      CALL abmr003_x01_delfloat(sr.bmea011) RETURNING l_bmea011
      CALL abmr003_x01_delfloat(sr.bmea012) RETURNING l_bmea012
      #ins temp
      EXECUTE insert_prep2 USING sr.bmaa001,sr.l_bmaa001_desc,sr.l_bmaa001_desc1,sr.bmaa002,sr.l_imac003,sr.bmba004_desc,
                                 sr.bmba007_desc,l_bmba011,sr.bmea007_desc,sr.bmba003,sr.l_bmba003_desc,
                                 sr.l_bmba003_desc1,l_bmea011,l_bmea012,sr.inag009,p_imaa001
 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "abmr003_x01_execute2"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = FALSE
         CALL cl_err()       
         LET r_success = FALSE
         RETURN r_success
      END IF

   END FOREACH
   #mod--160322-00029#1 By shiun--(S)
   #取替代BOM
   IF tm.flag = 'Y' THEN
      CALL abmr003_x01_bom_bmea(p_imaa001) RETURNING r_success
#      FOREACH abmr003_x01_c2 INTO sr.* 
#         IF STATUS THEN
#            INITIALIZE g_errparam TO NULL
#            LET g_errparam.extend = 'foreach2:'
#            LET g_errparam.code   = STATUS
#            LET g_errparam.popup  = TRUE
#            CALL cl_err()
#            LET r_success = FALSE
#            RETURN r_success
#         END IF
#         
#         #1單階 2多階 3尾階
#         IF tm.combo <> '1' THEN
#            CALL abmr003_x01_bom_rec(sr.bmaa001,sr.bmba002,sr.bmba011,p_imaa001) RETURNING l_success,l_flag
#            IF NOT l_success THEN
#               LET r_success = FALSE
#               RETURN r_success
#            END IF
#         END IF
#         
#         IF tm.combo = '3' AND NOT l_flag THEN
#            CONTINUE FOREACH
#         END IF
#         
#         CALL abmr003_x01_inventory(sr.bmaa001) RETURNING sr.inag009
#         CALL abmr003_x01_delfloat(sr.bmba011) RETURNING l_bmba011
#         CALL abmr003_x01_delfloat(sr.bmea011) RETURNING l_bmea011
#         CALL abmr003_x01_delfloat(sr.bmea012) RETURNING l_bmea012
#         #ins temp
#         EXECUTE insert_prep2 USING sr.bmaa001,sr.l_bmaa001_desc,sr.l_bmaa001_desc1,sr.bmaa002,sr.l_imac003,sr.bmba004_desc,
#                                    sr.bmba007_desc,l_bmba011,sr.bmea007_desc,sr.bmba003,sr.l_bmba003_desc,
#                                    sr.l_bmba003_desc1,l_bmea011,l_bmea012,sr.inag009,p_imaa001
#      
#         IF SQLCA.sqlcode THEN
#            INITIALIZE g_errparam TO NULL
#            LET g_errparam.extend = "abmr003_x01_execute2"
#            LET g_errparam.code   = SQLCA.sqlcode
#            LET g_errparam.popup  = FALSE
#            CALL cl_err()       
#            LET r_success = FALSE
#            RETURN r_success
#         END IF
#
#      END FOREACH
   END IF
   #mod--160322-00029#1 By shiun--(E)
   RETURN r_success
END FUNCTION
#展BOM
PRIVATE FUNCTION abmr003_x01_bom_rec(p_bmba003,p_bmba002,p_bmba011,p_imaa001)
DEFINE p_bmba003      LIKE bmba_t.bmba003
DEFINE p_bmba002      LIKE bmba_t.bmba002
DEFINE p_bmba011      LIKE bmba_t.bmba011
DEFINE p_imaa001      LIKE imaa_t.imaa001
DEFINE r_success      LIKE type_t.num5
DEFINE r_flag         LIKE type_t.num5    #尾階
DEFINE sr DYNAMIC ARRAY OF RECORD
   bmaa001            LIKE bmaa_t.bmaa001, 
   l_bmaa001_desc     LIKE imaal_t.imaal003, 
   l_bmaa001_desc1    LIKE imaal_t.imaal004, 
   bmaa002            LIKE bmaa_t.bmaa002,
   l_imac003          LIKE imac_t.imac003, 
   bmba004_desc       LIKE oocql_t.oocql004,
   bmba007_desc       LIKE oocql_t.oocql004,
   bmba011            LIKE bmba_t.bmba011,
   bmea007_desc       LIKE gzcbl_t.gzcbl004,
   bmba003            LIKE bmba_t.bmba003,
   l_bmba003_desc     LIKE imaal_t.imaal003,
   l_bmba003_desc1    LIKE imaal_t.imaal004,
   bmea011            LIKE bmea_t.bmea011,
   bmea012            LIKE bmea_t.bmea012,
   inag009            LIKE inag_t.inag009,
   bmba002            LIKE bmba_t.bmba002
 END RECORD
DEFINE l_success      LIKE type_t.num5
DEFINE l_flag         LIKE type_t.num5    #尾階
DEFINE l_i            LIKE type_t.num10
DEFINE l_rec          LIKE type_t.num10
DEFINE l_bmba011      LIKE type_t.chr1000
DEFINE l_bmea011      LIKE type_t.chr1000
DEFINE l_bmea012      LIKE type_t.chr1000

   LET r_success = TRUE
   LET r_flag = FALSE
   LET l_i = 1
   #BOM
   LET g_sql = " SELECT bmba001,imaal003,imaal004,bmaa002,imac003,t1.oocql004, ",
               "        t2.oocql004,COALESCE(bmba011,0)/COALESCE(bmba012,1),'','','', ",
               "        '','','','',bmba002 ", 
               "   FROM bmba_t ",
               "   LEFT OUTER JOIN imac_t ON imacent = bmbaent AND imac001 = bmba001 ",
               "   LEFT OUTER JOIN imaal_t ON imaalent = bmbaent AND imaal001 = bmba001 AND imaal002 = '",g_dlang,"' ",
               "   LEFT OUTER JOIN oocql_t t1 ON t1.oocqlent = bmbaent AND t1.oocql001 = '215' AND t1.oocql002 = bmba004 AND t1.oocql003 = '",g_dlang,"' ",
               "   LEFT OUTER JOIN oocql_t t2 ON t2.oocqlent = bmbaent AND t2.oocql001 = '221' AND t2.oocql002 = bmba007 AND t2.oocql003 = '",g_dlang,"' ",
               "   ,bmaa_t ",
               "  WHERE bmbaent = bmaaent AND bmbasite = bmaasite AND bmba001 = bmaa001 AND bmba002 = bmaa002 ",
               "    AND bmaastus <> 'X' AND bmbaent = ",g_enterprise," AND bmba003 = '",p_bmba003,"' AND bmba002 = '",p_bmba002,"' AND ",g_wc,
               "  ORDER BY bmba001 "                           #160112-00004#1 add
   
   PREPARE abmr003_x01_p3 FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare3:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success,r_flag
   END IF
   DECLARE abmr003_x01_c3 CURSOR FOR abmr003_x01_p3
   
   FOREACH abmr003_x01_c3 INTO sr[l_i].* 
      IF STATUS THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'foreach3:'
         LET g_errparam.code   = STATUS
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success,r_flag
      END IF
      LET l_i = l_i + 1
   END FOREACH
   
   IF cl_null(sr[1].bmaa001) THEN 
      LET r_flag = TRUE 
      RETURN r_success,r_flag
   END IF
   LET l_rec = l_i - 1
   
   FOR l_i = 1 TO l_rec 
         CALL abmr003_x01_bom_rec(sr[l_i].bmaa001,sr[l_i].bmba002,sr[l_i].bmba011,p_imaa001) RETURNING l_success,l_flag
         
         IF NOT l_success THEN
            LET r_success = FALSE
            RETURN r_success,r_flag
         END IF
         #尾階判斷
         IF tm.combo = '3' AND NOT l_flag THEN
            CONTINUE FOR
         END IF
         
         CALL abmr003_x01_inventory(sr[l_i].bmaa001) RETURNING sr[l_i].inag009
         
         LET sr[l_i].bmba011 = sr[l_i].bmba011 * p_bmba011
         CALL abmr003_x01_delfloat(sr[l_i].bmba011) RETURNING l_bmba011
         CALL abmr003_x01_delfloat(sr[l_i].bmea011) RETURNING l_bmea011
         CALL abmr003_x01_delfloat(sr[l_i].bmea012) RETURNING l_bmea012
         #ins temp
         EXECUTE insert_prep2 USING sr[l_i].bmaa001,sr[l_i].l_bmaa001_desc,sr[l_i].l_bmaa001_desc1,sr[l_i].bmaa002,sr[l_i].l_imac003,sr[l_i].bmba004_desc,
                                    sr[l_i].bmba007_desc,sr[l_i].bmba011,sr[l_i].bmea007_desc,sr[l_i].bmba003,sr[l_i].l_bmba003_desc,
                                    sr[l_i].l_bmba003_desc1,sr[l_i].bmea011,sr[l_i].bmea012,sr[l_i].inag009,p_imaa001
      
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "abmr003_x01_execute2"
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = FALSE
            CALL cl_err()       
            LET r_success = FALSE
            RETURN r_success,r_flag
         END IF
   END FOR

   RETURN r_success,r_flag
END FUNCTION
#庫存量
PRIVATE FUNCTION abmr003_x01_inventory(p_imaa001)
   DEFINE p_imaa001     LIKE imaa_t.imaa001
   DEFINE r_qty         LIKE inag_t.inag009
   
   LET r_qty = 0
   IF g_prog = 'abmr003' THEN
      SELECT SUM(inag009) INTO r_qty
        FROM inag_t
       WHERE inagent = g_enterprise
         AND inag001 = p_imaa001
   ELSE
      SELECT SUM(inag009) INTO r_qty
        FROM inag_t
       WHERE inagent = g_enterprise
         AND inagsite = g_site
         AND inag001 = p_imaa001
   END IF
   IF cl_null(r_qty) THEN LET r_qty = 0 END IF
   
   RETURN r_qty
END FUNCTION
################################################################################
# Descriptions...: 去除小數點後多餘的0
# Memo...........:
# Usage..........: CALL abmr003_x01_delfloat(p_num)
#                  RETURNING r_str
# Date & Author..: 2014/10/27 by shiun
# Modify.........:
################################################################################
PRIVATE FUNCTION abmr003_x01_delfloat(p_num)
DEFINE p_num       LIKE bmba_t.bmba011
DEFINE r_str       STRING
DEFINE l_float     STRING
DEFINE l_int       STRING
DEFINE l_count     INTEGER
DEFINE l_length    INTEGER
DEFINE l_float_length    INTEGER
DEFINE l_i         INTEGER

   LET r_str = p_num
   LET l_count = r_str.getIndexOf(".",1)
   LET l_length = r_str.getLength()
   LET l_int = r_str.subString(1,l_count-1)
   LET l_float = r_str.subString(l_count+1,l_length)
   LET l_float_length = l_float.getLength()
   FOR l_i = 1 TO l_float_length
      IF l_float.subString(l_float_length+1-l_i,l_float_length+1-l_i) <> '0' THEN
         EXIT FOR
      END IF
   END FOR
   IF l_i < l_float_length+1 THEN
      LET l_float = l_float.subString(1,l_float_length+1-l_i)
      LET r_str = l_int || "." || l_float
   ELSE
      LET r_str = l_int
   END IF
   RETURN r_str
END FUNCTION
################################################################################
# Descriptions...: 多階展BOM
# Memo...........:
# Usage..........: CALL abmr003_x01_bom_s(p_imaa001)
#                  RETURNING l_success
# Input parameter: p_imaa001      料件編號
# Return code....: l_success      成功否
# Date & Author..: 2016/05/23 By shiun
# Modify.........: #160322-00029#1 add
################################################################################
PRIVATE FUNCTION abmr003_x01_bom_s(p_imaa001)
DEFINE p_imaa001      LIKE imaa_t.imaa001
DEFINE r_success      LIKE type_t.num5
DEFINE l_sql          STRING
DEFINE sr RECORD 
   bmaa001     LIKE bmba_t.bmba001,
   bmba002     LIKE bmba_t.bmba002,
   bmba003     LIKE bmba_t.bmba003,
   bmba004     LIKE bmba_t.bmba004,
   bmba007     LIKE bmba_t.bmba007,
   bmba011     LIKE bmba_t.bmba011,
   bmba011_sum LIKE bmba_t.bmba011
 END RECORD
DEFINE l_success      LIKE type_t.num5
DEFINE l_flag         LIKE type_t.num5    #尾階
DEFINE l_bmba011      LIKE type_t.chr1000
DEFINE l_bmea011      LIKE type_t.chr1000
DEFINE l_bmea012      LIKE type_t.chr1000

   LET r_success = TRUE
   
   #BOM
   LET l_sql = "  SELECT * ",
               "    FROM bmba_t ",
               "   WHERE bmbasite = '",g_wc_site,"' ",  
               "   START WITH (bmba001,bmba002,bmba003) IN( ",
               "  SELECT DISTINCT bmba001,bmba002,bmba003 ",
               "    FROM bmba_t WHERE bmbaent = '",g_enterprise,"' AND bmba003='",p_imaa001,"' AND ",g_wc," ) ",
               " CONNECT BY NOCYCLE PRIOR bmba001 = bmba003 AND PRIOR bmba002 = bmba002 AND bmbasite = '",g_wc_site,"' ORDER BY bmba001 "
               
   LET g_sql = "  SELECT DISTINCT bmba001,bmba002,bmba003,bmba004,bmba007,COALESCE(bmba011,0)/COALESCE(bmba012,1),0 ",
               "    FROM (",l_sql,") b ,bmaa_t a ",
               " WHERE a.bmaa001 = b.bmba001 AND a.bmaa002 = b.bmba002 AND a.bmaaent = b.bmbaent ",
               "   AND bmaaent = '",g_enterprise,"' AND bmaasite = bmbasite ",
               "   AND ",g_wc," AND bmaastus <> 'X' ",
               " ORDER BY bmba001,bmba002"  
   
   PREPARE abmr003_x01_p9 FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare1:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   DECLARE abmr003_x01_c9 CURSOR FOR abmr003_x01_p9
   
   FOREACH abmr003_x01_c9 INTO sr.* 
      IF STATUS THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'foreach1:'
         LET g_errparam.code   = STATUS
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
    
      INSERT INTO abmr003_tmp VALUES(sr.bmaa001,sr.bmba002,sr.bmba003,sr.bmba004,sr.bmba007,sr.bmba011,sr.bmba011,p_imaa001)
    
   END FOREACH
   
   RETURN r_success
END FUNCTION

PRIVATE FUNCTION abmr003_x01_create_tmp()
DEFINE r_success         LIKE type_t.num5

   LET r_success = TRUE

   DROP TABLE abmr003_tmp;
   CREATE TEMP TABLE abmr003_tmp(
      bmba001      VARCHAR(40),
      bmba002      VARCHAR(30),
      bmba003      VARCHAR(40),
      bmba004      VARCHAR(10),
      bmba007      VARCHAR(10),
      bmba011      DECIMAL(20,6),
      bmba011_sum  DECIMAL(20,6),
      imaa001      VARCHAR(40)
      )
   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create abmr003_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success
END FUNCTION

PRIVATE FUNCTION abmr003_x01_drop_tmp()
   DROP TABLE abmr003_tmp;
END FUNCTION
################################################################################
# Descriptions...: 取替代展BOM
# Memo...........:
# Usage..........: CALL abmr003_x01_bom_bmea(p_imaa001)
#                  RETURNING l_success
# Input parameter: p_imaa001      料件編號
# Return code....: l_success      成功否
# Date & Author..: 2016/05/23 By shiun
# Modify.........: #160322-00029#1 add
################################################################################
PRIVATE FUNCTION abmr003_x01_bom_bmea(p_imaa001)
DEFINE p_imaa001      LIKE imaa_t.imaa001
DEFINE r_success      LIKE type_t.num5
DEFINE sr RECORD 
   bmaa001            LIKE bmaa_t.bmaa001, 
   l_bmaa001_desc     LIKE imaal_t.imaal003, 
   l_bmaa001_desc1    LIKE imaal_t.imaal004,
   bmaa002            LIKE bmaa_t.bmaa002,    
   l_imac003          LIKE imac_t.imac003, 
   bmba004_desc       LIKE oocql_t.oocql004,
   bmba007_desc       LIKE oocql_t.oocql004,
   bmba011            LIKE bmba_t.bmba011,
   bmea007_desc       LIKE gzcbl_t.gzcbl004,
   bmba003            LIKE bmba_t.bmba003,
   l_bmba003_desc     LIKE imaal_t.imaal003,
   l_bmba003_desc1    LIKE imaal_t.imaal004,
   bmea011            LIKE bmea_t.bmea011,
   bmea012            LIKE bmea_t.bmea012,
   inag009            LIKE inag_t.inag009,
   bmba002            LIKE bmba_t.bmba002
 END RECORD
DEFINE l_success      LIKE type_t.num5
DEFINE l_flag         LIKE type_t.num5    #尾階
DEFINE l_bmba011      LIKE type_t.chr1000
DEFINE l_bmea011      LIKE type_t.chr1000
DEFINE l_bmea012      LIKE type_t.chr1000
   
   LET r_success = TRUE
   LET g_sql = " SELECT DISTINCT bmba001,t3.imaal003,t3.imaal004,bmba002,imac003,t1.oocql004, ",   #151028 Sarah add DISTINCT
               "        t2.oocql004,COALESCE(bmba011,0)/COALESCE(bmba012,1),gzcbl004,bmba003,t4.imaal003, ",
               "        t4.imaal004,bmea011,bmea012,'',bmba002 ", 
               "   FROM bmba_t ",
               "   LEFT OUTER JOIN imac_t ON imacent = bmbaent AND imac001 = bmba001 ",
               "   LEFT OUTER JOIN oocql_t t1 ON t1.oocqlent = bmbaent AND t1.oocql001 = '215' AND t1.oocql002 = bmba004 AND t1.oocql003 = '",g_dlang,"' ",
               "   LEFT OUTER JOIN oocql_t t2 ON t2.oocqlent = bmbaent AND t2.oocql001 = '221' AND t2.oocql002 = bmba007 AND t2.oocql003 = '",g_dlang,"' ",
               "   LEFT OUTER JOIN imaal_t t3 ON t3.imaalent = bmbaent AND t3.imaal001 = bmba001 AND t3.imaal002 = '",g_dlang,"' ",
               "   LEFT OUTER JOIN imaal_t t4 ON t4.imaalent = bmbaent AND t4.imaal001 = bmba003 AND t4.imaal002 = '",g_dlang,"' ",
               "   ,bmea_t ",
               "   LEFT OUTER JOIN gzcbl_t ON gzcbl001 = '1103' AND gzcbl002 = bmea007 AND gzcbl003 = '",g_dlang,"' ",
               "   ,bmaa_t ",
               "  WHERE bmbaent = bmaaent AND bmbasite = bmaasite AND bmba001 = bmaa001 AND bmba002 = bmaa002 ",
              #"    AND bmeaent = bmbaent AND bmeasite = bmbasite AND bmea001 = bmba001 AND bmea002 = bmba002 ",                      #151028 Sarah mark
               "    AND bmeaent = bmbaent AND bmeasite = bmbasite AND (bmea001 = bmba001 OR bmea001='ALL') AND bmea002 = bmba002 ",   #151028 Sarah mod
               "    AND bmea003 = bmba003 AND bmea004 = bmba004 AND bmea005 = bmba007 AND bmea006 = bmba008 AND to_char(bmea009,'YYYY-MM-DD') <= '",tm.date,"' AND (bmea010 IS NULL OR (bmea010 IS NOT NULL AND to_char(bmea010,'YYYY-MM-DD') >= '",tm.date,"' ))",
              #"    AND bmea003 = bmba003 AND bmea004 = bmba004 AND bmea005 = bmba007 AND bmea006 = bmba008 AND bmea009 = bmba005", #modify by shiunyo 2014/10/22
               "    AND bmaastus <> 'X' AND bmbaent = ",g_enterprise," AND bmea008 = '",p_imaa001,"' AND ",g_wc,
               "  ORDER BY bmba001 "                 #151229-00006#1 add                  
    
   PREPARE abmr003_x01_p2 FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare2:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   DECLARE abmr003_x01_c2 CURSOR FOR abmr003_x01_p2            
   
   FOREACH abmr003_x01_c2 INTO sr.* 
      IF STATUS THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'foreach2:'
         LET g_errparam.code   = STATUS
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      #1單階 2多階 3尾階
      IF tm.combo <> '1' THEN
         CALL abmr003_x01_bom_rec(sr.bmaa001,sr.bmba002,sr.bmba011,p_imaa001) RETURNING l_success,l_flag
         IF NOT l_success THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
      END IF
      
      IF tm.combo = '3' AND NOT l_flag THEN
         CONTINUE FOREACH
      END IF
      
      CALL abmr003_x01_inventory(sr.bmaa001) RETURNING sr.inag009
      CALL abmr003_x01_delfloat(sr.bmba011) RETURNING l_bmba011
      CALL abmr003_x01_delfloat(sr.bmea011) RETURNING l_bmea011
      CALL abmr003_x01_delfloat(sr.bmea012) RETURNING l_bmea012
      #ins temp
      EXECUTE insert_prep2 USING sr.bmaa001,sr.l_bmaa001_desc,sr.l_bmaa001_desc1,sr.bmaa002,sr.l_imac003,sr.bmba004_desc,
                                 sr.bmba007_desc,l_bmba011,sr.bmea007_desc,sr.bmba003,sr.l_bmba003_desc,
                                 sr.l_bmba003_desc1,l_bmea011,l_bmea012,sr.inag009,p_imaa001
   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "abmr003_x01_execute2"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = FALSE
         CALL cl_err()       
         LET r_success = FALSE
         RETURN r_success
      END IF
    
   END FOREACH
   RETURN r_success
END FUNCTION

 
{</section>}
 
