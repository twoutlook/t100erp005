#該程式未解開Section, 採用最新樣板產出!
{<section id="aqcr330_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2015-02-13 16:55:03), PR版次:0001(2015-02-13 17:01:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000060
#+ Filename...: aqcr330_x01
#+ Description: ...
#+ Creator....: 01996(2014-12-30 15:05:29)
#+ Modifier...: 01996 -SD/PR- 01996
 
{</section>}
 
{<section id="aqcr330_x01.global" readonly="Y" >}
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
       wc STRING,                  #条件 
       typea STRING,                  #检验类型 
       typeb STRING,                  #库存异动类型 
       bdate STRING,                  #起始日期 
       edate STRING                   #截至日期
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="aqcr330_x01.main" readonly="Y" >}
PUBLIC FUNCTION aqcr330_x01(p_arg1,p_arg2,p_arg3,p_arg4,p_arg5)
DEFINE  p_arg1 STRING                  #tm.wc  条件 
DEFINE  p_arg2 STRING                  #tm.typea  检验类型 
DEFINE  p_arg3 STRING                  #tm.typeb  库存异动类型 
DEFINE  p_arg4 STRING                  #tm.bdate  起始日期 
DEFINE  p_arg5 STRING                  #tm.edate  截至日期
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.typea = p_arg2
   LET tm.typeb = p_arg3
   LET tm.bdate = p_arg4
   LET tm.edate = p_arg5
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "aqcr330_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL aqcr330_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL aqcr330_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL aqcr330_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL aqcr330_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL aqcr330_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="aqcr330_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION aqcr330_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "qcba005.qcba_t.qcba005,qcbadocno.qcba_t.qcbadocno,qcba010.qcba_t.qcba010,qcba024.qcba_t.qcba024,l_qcbe001.qcbe_t.qcbe001,l_qcbe001_desc.type_t.chr500,l_qcbe002.qcbe_t.qcbe002,l_qcbe004.qcbe_t.qcbe004,l_qcbe004_sum.qcbe_t.qcbe004,l_group.type_t.chr1000,l_group_qcbe001.type_t.chr1000,l_flag.type_t.chr1" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
#   LET g_sql = "l_qcbe001.qcbe_t.qcbe001,l_qcbe001_desc.type_t.chr500,l_qcbe002.qcbe_t.qcbe002,l_qcbe004.qcbe_t.qcbe004,l_qcbe004_sum.qcbe_t.qcbe004" 
#   
#   #建立TEMP TABLE,主報表序號1 
#   IF NOT cl_xg_create_tmptable(g_sql,2) THEN
#      LET g_rep_success = 'N'            
#   END IF
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="aqcr330_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION aqcr330_x01_ins_prep()
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
#         WHEN 2
#         #INSERT INTO PREP
#         LET g_sql = " INSERT INTO ",g_rep_db CLIPPED,g_rep_tmpname[2] CLIPPED," VALUES(?,?,?,?,?)"
#         PREPARE insert_prep2 FROM g_sql
#         IF STATUS THEN
#            LET l_prep_str ="insert_prep",i
#            INITIALIZE g_errparam TO NULL
#            LET g_errparam.extend = l_prep_str
#            LET g_errparam.code   = status
#            LET g_errparam.popup  = TRUE
#            CALL cl_err()
#            CALL cl_xg_drop_tmptable()
#            LET g_rep_success = 'N'           
#         END IF
         #end add-point                  
 
 
      END CASE
   END FOR
END FUNCTION
 
{</section>}
 
{<section id="aqcr330_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aqcr330_x01_sel_prep()
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
   LET g_sql = " SELECT qcba005,qcbadocno,qcba010,qcba024,qcbe001,oocql004,SUM(qcbe002),SUM(qcbe004),0,'',''",
               "   FROM qcba_t LEFT OUTER JOIN imaa_t ON imaaent = qcbaent AND imaa001 = qcba010",
               "       ,qcbe_t LEFT OUTER JOIN oocql_t ON oocqlent = qcbeent AND oocql001 = '1053' AND oocql002 = qcbe001 AND oocql003 = '",g_dlang,"'",
               " WHERE qcbaent = ",g_enterprise," AND qcbasite = '",g_site,"'",
               "    AND qcbaent = qcbeent AND qcbadocno = qcbedocno AND ",tm.wc CLIPPED,
               "    AND qcbadocdt BETWEEN '",tm.bdate,"' AND '",tm.edate,"' AND qcba000 = '",tm.typea,"'"
   IF NOT cl_null(tm.typeb) THEN
      LET g_sql = g_sql," AND qcba031 = '",tm.typeb,"'"
   END IF
   LET g_sql = g_sql," GROUP BY qcba005,qcbadocno,qcba010,qcba024,qcbe001,oocql004"
   LET g_sql = g_sql," ORDER BY qcba005,qcbadocno,qcba010,qcba024,qcbe001,oocql004"
#   #end add-point
#   LET g_select = " SELECT qcba005,qcbadocno,qcba010,qcba024,'','','','','','','',''"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
 
#   #end add-point
#    LET g_from = " FROM qcba_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
 
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
 
#   #end add-point:sel_prep.sql.before
#   LET g_where = g_where ,cl_sql_add_filter("qcba_t")   #資料過濾功能
#   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
#   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
# 
#   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = cl_sql_add_mask(g_sql)
   #end add-point
   PREPARE aqcr330_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE aqcr330_x01_curs CURSOR FOR aqcr330_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="aqcr330_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION aqcr330_x01_ins_data()
DEFINE sr RECORD 
   qcba005 LIKE qcba_t.qcba005, 
   qcbadocno LIKE qcba_t.qcbadocno, 
   qcba010 LIKE qcba_t.qcba010, 
   qcba024 LIKE qcba_t.qcba024, 
   l_qcbe001 LIKE qcbe_t.qcbe001, 
   l_qcbe001_desc LIKE type_t.chr500, 
   l_qcbe002 LIKE qcbe_t.qcbe002, 
   l_qcbe004 LIKE qcbe_t.qcbe004, 
   l_qcbe004_sum LIKE qcbe_t.qcbe004, 
   l_group LIKE type_t.chr1000, 
   l_group_qcbe001 LIKE type_t.chr1000, 
   l_flag LIKE type_t.chr1
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_qcbe002_sum  LIKE qcbe_t.qcbe002
DEFINE l_qcbe002_p    LIKE qcbe_t.qcbe002
DEFINE l_qcbadocno_p  LIKE qcba_t.qcbadocno
DEFINE sr1 RECORD 
   l_qcbe001 LIKE qcbe_t.qcbe001,
   l_qcbe001_desc LIKE type_t.chr500,
   l_qcbe002 LIKE qcbe_t.qcbe002,
   l_qcbe004 LIKE qcbe_t.qcbe004,
   l_qcbe004_sum LIKE qcbe_t.qcbe004
 END RECORD
DEFINE l_group_p  LIKE type_t.chr1000
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
#    LET g_sql = "SELECT DISTINCT qcbe001,oocql004,SUM(qcbe002),SUM(qcbe004),0",
#                "  FROM qcbe_t ",
#                "  LEFT OUTER JOIN oocql_t ON oocqlent = qcbeent AND oocql001 = '1053' AND oocql002 = qcbe001 AND oocql003 = '",g_dlang,"'",
#                "  WHERE qcbeent = ",g_enterprise," AND qcbedocno = ?",
#                "  GROUP BY qcbe001,oocql004 ORDER BY qcbe001,oocql004"
#    PREPARE sel_qcbe_prep1 FROM g_sql
#    DECLARE sel_qcbe_curs1 CURSOR FOR sel_qcbe_prep1
    INITIALIZE l_group_p TO NULL
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH aqcr330_x01_curs INTO sr.*                               
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
       SELECT SUM(qcbe002) INTO l_qcbe002_sum 
        FROM qcbe_t WHERE qcbeent = g_enterprise 
         AND qcbedocno = sr.qcbadocno 
       
       IF l_qcbadocno_p = sr.qcbadocno THEN
          LET l_qcbe002_p = l_qcbe002_p + sr.l_qcbe002
       ELSE
          LET l_qcbe002_p = sr.l_qcbe002
       END IF
       LET sr.l_qcbe004_sum = l_qcbe002_p / l_qcbe002_sum 
       
       LET l_qcbadocno_p = sr.qcbadocno
       
       IF NOT cl_null(sr.l_qcbe001_desc) THEN
          LET sr.l_qcbe001_desc = sr.l_qcbe001,".",sr.l_qcbe001_desc
       ELSE
          LET sr.l_qcbe001_desc = sr.l_qcbe001
       END IF
       
       LET sr.l_group = sr.qcba005,"-",sr.qcbadocno,"-",sr.qcba010,"-",sr.qcba024
       IF l_group_p = sr.l_group THEN
          LET sr.l_flag = 'N'
       ELSE
          LET sr.l_flag = 'Y'
       END IF
       LET sr.l_group_qcbe001 = sr.qcba005,"-",sr.qcbadocno,"-",sr.qcba010,"-",sr.qcba024,"-",sr.l_qcbe001
       
       LET l_group_p = sr.l_group 
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
    
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.qcba005,sr.qcbadocno,sr.qcba010,sr.qcba024,sr.l_qcbe001,sr.l_qcbe001_desc,sr.l_qcbe002,sr.l_qcbe004,sr.l_qcbe004_sum,sr.l_group,sr.l_group_qcbe001,sr.l_flag
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "aqcr330_x01_execute"
          LET g_errparam.code   = SQLCA.sqlcode
          LET g_errparam.popup  = FALSE
          CALL cl_err()       
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF
 
       #add-point:ins_data段after_save name="ins_data.after.save"
#子报表
#       LET l_qcbe002_p = 0
#       SELECT SUM(qcbe002) INTO l_qcbe002_sum 
#           FROM qcbe_t WHERE qcbeent = g_enterprise 
#            AND qcbedocno = sr.qcbadocno 
#       FOREACH sel_qcbe_curs1 USING sr.qcbadocno INTO sr1.*  
#          IF STATUS THEN
#             INITIALIZE g_errparam TO NULL
#             LET g_errparam.extend = 'foreach:'
#             LET g_errparam.code   = STATUS
#             LET g_errparam.popup  = TRUE
#             CALL cl_err()
#             LET g_rep_success = 'N'
#             EXIT FOREACH
#          END IF
#          
#          
#       #   IF l_qcbadocno_p = sr.qcbadocno THEN
#             LET l_qcbe002_p = l_qcbe002_p + sr1.l_qcbe002
#      #    ELSE
#      #      LET l_qcbe002_p = sr.l_qcbe002
#      #    END IF
#          LET sr1.l_qcbe004_sum = l_qcbe002_p / l_qcbe002_sum 
#          
#       #   LET l_qcbadocno_p = sr.qcbadocno
#          
#          IF NOT cl_null(sr1.l_qcbe001_desc) THEN
#             LET sr1.l_qcbe001_desc = sr1.l_qcbe001,".",sr1.l_qcbe001_desc
#          ELSE
#             LET sr1.l_qcbe001_desc = sr1.l_qcbe001
#          END IF
#          
#          EXECUTE insert_prep2 USING sr1.l_qcbe001,sr1.l_qcbe001_desc,sr1.l_qcbe002,sr1.l_qcbe004,sr1.l_qcbe004_sum
# 
#          IF SQLCA.sqlcode THEN
#             INITIALIZE g_errparam TO NULL
#             LET g_errparam.extend = "aqcr330_x01_execute"
#             LET g_errparam.code   = SQLCA.sqlcode
#             LET g_errparam.popup  = FALSE
#             CALL cl_err()       
#             LET g_rep_success = 'N'
#             EXIT FOREACH
#          END IF
#       END FOREACH
       #end add-point
       
    END FOREACH
    
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aqcr330_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION aqcr330_x01_rep_data()
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
 
{<section id="aqcr330_x01.other_function" readonly="Y" >}

 
{</section>}
 
