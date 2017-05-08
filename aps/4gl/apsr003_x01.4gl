#該程式未解開Section, 採用最新樣板產出!
{<section id="apsr003_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2016-05-24 11:29:45), PR版次:0002(2016-05-26 14:03:25)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000090
#+ Filename...: apsr003_x01
#+ Description: ...
#+ Creator....: 05231(2014-07-09 14:49:07)
#+ Modifier...: 07024 -SD/PR- 07024
 
{</section>}
 
{<section id="apsr003_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#160503-00030#18   2016/05/24   By  dorislai  效能調整
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
       p01 LIKE type_t.chr1000,         #APS版本1 
       p02 LIKE type_t.chr1000,         #APS版本2 
       p03 LIKE type_t.chr1          #只印差異資料
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_psoq002_1   LIKE psoq_t.psoq002
DEFINE g_psoq002_2   LIKE psoq_t.psoq002
#end add-point
 
{</section>}
 
{<section id="apsr003_x01.main" readonly="Y" >}
PUBLIC FUNCTION apsr003_x01(p_arg1,p_arg2,p_arg3,p_arg4)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr1000         #tm.p01  APS版本1 
DEFINE  p_arg3 LIKE type_t.chr1000         #tm.p02  APS版本2 
DEFINE  p_arg4 LIKE type_t.chr1         #tm.p03  只印差異資料
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.p01 = p_arg2
   LET tm.p02 = p_arg3
   LET tm.p03 = p_arg4
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "apsr003_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL apsr003_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL apsr003_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL apsr003_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL apsr003_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL apsr003_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="apsr003_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION apsr003_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "l_psoq004.psoq_t.psoq004,psoq009.psoq_t.psoq009,l_pmaal003.type_t.chr1000,l_psoq036.type_t.chr1000,l_psoq036_desc.ooag_t.ooag011,l_psoq043.psoq_t.psoq043,l_imaal003.imaal_t.imaal003,l_imaal004.imaal_t.imaal004,l_psoq044.psoq_t.psoq044,b_psoq006.type_t.num20_6,c_psoq006.type_t.num20_6,b_psoq007.psoq_t.psoq007,c_psoq007.psoq_t.psoq007,b_psoq024.psoq_t.psoq024,c_psoq024.psoq_t.psoq024,v1_delay.type_t.num20,v2_delay.type_t.num20,l_xmda015.type_t.chr300,v1_sum.type_t.num20_6,v1_sum_o.type_t.num20_6,v2_sum.type_t.num20_6,v2_sum_o.type_t.num20_6" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="apsr003_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION apsr003_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="apsr003_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apsr003_x01_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define(客製用) name="sel_prep.define_customerization"

#end add-point
#add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
DEFINE l_para      LIKE type_t.num5  #160503-00030#18-add
#end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   #160503-00030#18-add-(S)
   CALL cl_get_para(g_enterprise,g_site,'E-COM-0005')
       RETURNING l_para

   SELECT MAX(psoq002) INTO g_psoq002_1 
     FROM psoq_t
    WHERE psoqent = g_enterprise 
      AND psoqsite = g_site 
      AND psoq001 = tm.p01
   SELECT MAX(psoq002) INTO g_psoq002_2 
     FROM psoq_t
    WHERE psoqent = g_enterprise 
      AND psoqsite = g_site 
      AND psoq001 = tm.p02
   #160503-00030#18-add-(E)    
   #end add-point
 
   #add-point:sel_prep g_select name="sel_prep.g_select"
#   LET g_select =
#      " SELECT COALESCE(b.psoq004,c.psoq004),COALESCE(b.psoq009_pmaal004,c.psoq009_pmaal004),'',",
#      "        COALESCE(b.psoq043,c.psoq043),COALESCE(b.imaal003,c.imaal003),COALESCE(b.imaal004,c.imaal004),COALESCE(b.psoq044,c.psoq044),",
#      "        b.psoq006,c.psoq006,b.psoq0007,c.psoq007,b.psoq024,c.psoq024,'','','','','','','',",
#      "        COALESCE(b.psoqent,c.psoqent),COALESCE(b.psoqsite,c.psoqsite)"

   #160503-00030#18-mod-(S)
#   LET g_select =
#      " SELECT b.psoq004,trim(b.psoq009)||'.'||trim(c.pmaal003),'',b.psoq043,d.imaal003,d.imaal004,b.psoq044,",
#      "       '','','','','','','','','','','','','',b.psoqsite,b.psoqent"
   LET g_select =" SELECT b.psoq004 b_psoq004,b.psoq009 b_psoq009, ",
                 "  (SELECT pmaal003 FROM pmaal_t WHERE pmaal001 = b.psoq009 AND pmaalent = b.psoqent AND pmaal002 = '",g_dlang,"') pmaal003, ",
                 "  e.xmda002 e_xmda002,(SELECT ooag011 FROM ooag_t WHERE ooagent = e.xmdaent AND ooag001 = e.xmda002) ooag011, ",
                 "  b.psoq043 b_psoq043,  ",
                 "  (SELECT imaal003 FROM imaal_t WHERE imaal001 = b.psoq043 AND imaalent = b.psoqent AND imaal002 = '",g_dlang,"') imaal003, ",
                 "  (SELECT imaal004 FROM imaal_t WHERE imaal001 = b.psoq043 AND imaalent = b.psoqent AND imaal002 = '",g_dlang,"') imaal004, ",
                 "  b.psoq044 b_psoq044, ",
                 "  (SELECT psoq006 FROM psoq_t WHERE psoq001='",tm.p01,"' AND psoq002='",g_psoq002_1,"' AND psoq004=b.psoq004 AND psoqent=b.psoqent AND psoqsite=b.psoqsite) b_psoq006, ",
                 "  (SELECT psoq006 FROM psoq_t WHERE psoq001='",tm.p02,"' AND psoq002='",g_psoq002_2,"' AND psoq004=b.psoq004 AND psoqent=b.psoqent AND psoqsite=b.psoqsite) c_psoq006, ",
                 "  (SELECT psoq007 FROM psoq_t WHERE psoq001='",tm.p01,"' AND psoq002='",g_psoq002_1,"' AND psoq004=b.psoq004 AND psoqent=b.psoqent AND psoqsite=b.psoqsite) b_psoq007, ",
                 "  (SELECT psoq007 FROM psoq_t WHERE psoq001='",tm.p02,"' AND psoq002='",g_psoq002_2,"' AND psoq004=b.psoq004 AND psoqent=b.psoqent AND psoqsite=b.psoqsite) c_psoq007, ",
                 "  (SELECT psoq024 FROM psoq_t WHERE psoq001='",tm.p01,"' AND psoq002='",g_psoq002_1,"' AND psoq004=b.psoq004 AND psoqent=b.psoqent AND psoqsite=b.psoqsite) b_psoq024, ",
                 "  (SELECT psoq024 FROM psoq_t WHERE psoq001='",tm.p02,"' AND psoq002='",g_psoq002_2,"' AND psoq004=b.psoq004 AND psoqent=b.psoqent AND psoqsite=b.psoqsite) c_psoq024, ",
                 "  '','',xmda015 xmda_t_xmda015, ",
                 "  '','','','',b.psoqsite b_psoqsite,b.psoqent b_psoqent, ",
                 "  (SELECT xmdc015 FROM xmdc_t WHERE xmdcent=b.psoqent AND xmdcdocno=xmdadocno AND xmdcseq=substr(psoq004,"||l_para||"+2,instr(psoq004,'-',"||l_para||"+2)-(instr(psoq004,'-',"||l_para||"+1)+1) )) xmdc_t_xmdc015, ",
                 "  xmda016 xmda_t_xmda016 "
   #160503-00030#18-mod-(E)

#         FROM psoq_t
#        WHERE psoq001 = tm.p01
#          AND psoq002 = g_psoq002_1
#          AND psoq004 = sr.l_psoq004
#          AND psoqent = sr.psoqent
#          AND psoqsite = sr.psoqsite
#       #取版本2的數量、交期、預計完工日
#       SELECT psoq006,psoq007,psoq024 INTO sr.c_psoq006,sr.c_psoq007,sr.c_psoq024
#         FROM psoq_t
#        WHERE psoq001 = tm.p02
#          AND psoq002 = g_psoq002_2
#          AND psoq004 = sr.l_psoq004
#          AND psoqent = sr.psoqent
#          AND psoqsite = sr.psoqsite

#   #end add-point
#   LET g_select = " SELECT '',psoq009,'','',NULL,'','','','',NULL,NULL,'','','','',NULL,NULL,'',NULL, 
#       NULL,NULL,NULL,psoqsite,psoqent"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   #160503-00030#18-mark-(S)
#   SELECT MAX(psoq002) INTO g_psoq002_1 
#     FROM psoq_t
#    WHERE psoqent = g_enterprise 
#      AND psoqsite = g_site 
#      AND psoq001 = tm.p01
#   SELECT MAX(psoq002) INTO g_psoq002_2 
#     FROM psoq_t
#    WHERE psoqent = g_enterprise 
#      AND psoqsite = g_site 
#      AND psoq001 = tm.p02
   #160503-00030#18-mark-(E)
   #160503-00030#18-mod-(S)
   LET g_from =" FROM ( SELECT psoqent,psoqsite,psoq001,psoq002,psoq004,psoq009,psoq036,psoq043,psoq044,psoq006,psoq007,psoq024 ",
               "          FROM psoq_t ",
               "         WHERE psoq001 = '",tm.p01,"' AND psoq002 = '",g_psoq002_1,"'",
               "         UNION ",
               "        SELECT psoqent,psoqsite,psoq001,psoq002,psoq004,psoq009,psoq036,psoq043,psoq044,psoq006,psoq007,psoq024 ",
               "          FROM psoq_t ",
               "          WHERE psoq001 = '",tm.p02,"' AND psoq002 = '",g_psoq002_2,"') b",
               " LEFT OUTER JOIN xmda_t  e ON e.xmdaent = b.psoqent AND e.xmdadocno = substr(b.psoq004,1,",l_para,") "
#   LET g_from =
#    "  FROM ( SELECT psoqent,psoqsite,psoq001,psoq002,psoq004,psoq009,psoq036,psoq043,psoq044,psoq006,psoq007,psoq024 ",
#    "          FROM psoq_t ",
#    "          WHERE psoq001 = '",tm.p01,"' AND psoq002 = '",g_psoq002_1,"'",
#    " UNION   SELECT psoqent,psoqsite,psoq001,psoq002,psoq004,psoq009,psoq036,psoq043,psoq044,psoq006,psoq007,psoq024 ",
#    "          FROM psoq_t ",
#    "          WHERE psoq001 = '",tm.p02,"' AND psoq002 = '",g_psoq002_2,"') b",
#    "         LEFT OUTER JOIN pmaal_t c ON pmaal001 = b.psoq009 AND pmaalent = b.psoqent AND pmaal002 = '",g_dlang,"'",
#    "         LEFT OUTER JOIN imaal_t d ON imaal001 = b.psoq043 AND imaalent = b.psoqent AND imaal002 = '",g_dlang,"'"
#
##    "       ( SELECT psoqent,psoqsite,psoq001,psoq002,psoq004,psoq009,pmaal004,psoq036,ooag011,psoq043,imaal003,imaal004,psoq044,posq006,psoq007,psoq024,",
##    "                trim(psoq009)||'.'||trim(pmaal004) AS psoq009_pmaal004,trim(psoq036)||'.'||trim(ooag011) AS psoq036_ooag011 ",
##    "           FROM psoq_t LEFT OUTER JOIN pmaal_t ON pmaal001=psoq009 AND pmaalent =psoqent AND pmaal002 = '",g_dlang,"'",
##    "                       LEFT OUTER JOIN imaal_t ON imaal001=psoq005 AND imaalent =psoqent AND imaal002 = '",g_dlang,"'",
##    "          WHERE posq001 = '",tm.p02,"' AND psoq002 = '",l_c_psoq002,"') c"
#   
##   IF NOT cl_null(tm.p01) THEN
##      LET g_from = g_from , " AND b.psoq001= '",tm.p01, "' AND b.psoq002 = '",l_b_psoq002,"'"
##   END IF
##   IF NOT cl_null(tm.p02) THEN
##      LET g_from = g_from , " AND c.psoq001= '",tm.p02, "' AND c.psoq002 = '",l_c_psoq002,"'"
##   END IF                     
##   LET g_from = g_from ,       
##        "  LEFT JOIN xmdc_t f ON f.xmdcent=c.psoqent AND f.xmdcdocno= substr(c.psoq004,1,20) AND f.xmdcseq = substr(c.psoq004,22,1)          ",
##        "  LEFT JOIN xmda_t d ON d.xmdaent=a.psoqent AND d.xmdadocno= substr(a.psoq004,1,20) "
    #160503-00030#18-mod-(E)
#   #end add-point
#    LET g_from = " FROM psoq_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
    LET g_where = " WHERE " ,tm.wc CLIPPED
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("psoq_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql=g_sql," ORDER BY b.psoq004 "
   #160503-00030#18-add-(S)
   LET g_sql = " SELECT b_psoq004,b_psoq009,pmaal003,e_xmda002,ooag011,b_psoq043,imaal003,imaal004,b_psoq044,b_psoq006, ",
               "        c_psoq006,b_psoq007,c_psoq007,b_psoq024,c_psoq024, ",
               "        NVL(b_psoq024 - b_psoq007,0) v1_delay,NVL(c_psoq024 - c_psoq007,0) v2_delay, ",
               "        xmda_t_xmda015, ",
               "        (b_psoq006*xmdc_t_xmdc015) v1_sum,(b_psoq006*xmdc_t_xmdc015*xmda_t_xmda016) v1_sum_o, ",
               "        (c_psoq006*xmdc_t_xmdc015) v2_sum,(c_psoq006*xmdc_t_xmdc015*xmda_t_xmda016) v2_sum_o, ",
               "        b_psoqsite,b_psoqent,xmdc_t_xmdc015 ",
               "   FROM (",g_sql,") "
   #160503-00030#18-add-(E)     
   #end add-point
   PREPARE apsr003_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE apsr003_x01_curs CURSOR FOR apsr003_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="apsr003_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION apsr003_x01_ins_data()
DEFINE sr RECORD 
   l_psoq004 LIKE psoq_t.psoq004, 
   psoq009 LIKE psoq_t.psoq009, 
   l_pmaal003 LIKE type_t.chr1000, 
   l_psoq036 LIKE type_t.chr1000, 
   l_psoq036_desc LIKE ooag_t.ooag011, 
   l_psoq043 LIKE psoq_t.psoq043, 
   l_imaal003 LIKE imaal_t.imaal003, 
   l_imaal004 LIKE imaal_t.imaal004, 
   l_psoq044 LIKE psoq_t.psoq044, 
   b_psoq006 LIKE type_t.num20_6, 
   c_psoq006 LIKE type_t.num20_6, 
   b_psoq007 LIKE psoq_t.psoq007, 
   c_psoq007 LIKE psoq_t.psoq007, 
   b_psoq024 LIKE psoq_t.psoq024, 
   c_psoq024 LIKE psoq_t.psoq024, 
   v1_delay LIKE type_t.num20, 
   v2_delay LIKE type_t.num20, 
   l_xmda015 LIKE type_t.chr300, 
   v1_sum LIKE type_t.num20_6, 
   v1_sum_o LIKE type_t.num20_6, 
   v2_sum LIKE type_t.num20_6, 
   v2_sum_o LIKE type_t.num20_6, 
   psoqsite LIKE psoq_t.psoqsite, 
   psoqent LIKE psoq_t.psoqent
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    DEFINE l_sql       STRING
    DEFINE l_psoq004   STRING
    DEFINE l_para      LIKE type_t.num5
    DEFINE l_n         LIKE type_t.num5
    DEFINE l_n1        LIKE type_t.num5
    DEFINE l_xmdadocno LIKE xmda_t.xmdadocno
    DEFINE l_xmdcseq   LIKE xmdc_t.xmdcseq
    DEFINE l_xmda002   LIKE xmda_t.xmda002
    DEFINE l_xmda016   LIKE xmda_t.xmda016
    DEFINE l_xmdc015   LIKE xmdc_t.xmdc015
    DEFINE l_ooag011   LIKE ooag_t.ooag011
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH apsr003_x01_curs INTO sr.*                               
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
       #160503-00030#18-mark-(S)
#       LET l_psoq004 = sr.l_psoq004
#       CALL cl_get_para(sr.psoqent,sr.psoqsite,'E-COM-0005')
#       RETURNING l_para
#       LET l_xmdadocno = l_psoq004.subString(1,l_para)
#       LET l_n = l_psoq004.getIndexOf('-',l_para)+1
#       LET l_n1 = l_psoq004.getIndexOf('-',l_n)-1
#       LET l_xmdcseq = l_psoq004.subString(l_n,l_n1)
#       #取業務員.幣別.匯率
#       SELECT xmda002,xmda015,xmda016 INTO l_xmda002,sr.l_xmda015,l_xmda016
#         FROM xmda_t
#        WHERE xmdaent = sr.psoqent
#          AND xmdadocno = l_xmdadocno
#       #取業務員名稱
#       CALL s_desc_get_person_desc(l_xmda002) RETURNING l_ooag011
#       IF cl_null(l_xmda002) AND cl_null(l_ooag011) THEN
#          LET sr.l_psoq036 = ''
#       ELSE
#          IF cl_null(l_xmda002) OR cl_null(l_ooag011) THEN
#             LET sr.l_psoq036 = l_xmda002,'.',l_ooag011
#          ELSE
#             LET sr.l_psoq036 = l_xmda002||'.'||l_ooag011
#          END IF
#       END IF
#       IF sr.l_pmaal003 = '.' THEN
#          LET sr.l_pmaal003 = ''
#       END IF
#       #取訂單單價
#       SELECT xmdc015 INTO l_xmdc015
#         FROM xmdc_t
#        WHERE xmdcent = g_enterprise
#          AND xmdcdocno = l_xmdadocno
#          AND xmdcseq = l_xmdcseq
        
#       #取版本1的數量、交期、預計完工日
#       SELECT psoq006,psoq007,psoq024 INTO sr.b_psoq006,sr.b_psoq007,sr.b_psoq024
#         FROM psoq_t
#        WHERE psoq001 = tm.p01
#          AND psoq002 = g_psoq002_1
#          AND psoq004 = sr.l_psoq004
#          AND psoqent = sr.psoqent
#          AND psoqsite = sr.psoqsite
#       #取版本2的數量、交期、預計完工日
#       SELECT psoq006,psoq007,psoq024 INTO sr.c_psoq006,sr.c_psoq007,sr.c_psoq024
#         FROM psoq_t
#        WHERE psoq001 = tm.p02
#          AND psoq002 = g_psoq002_2
#          AND psoq004 = sr.l_psoq004
#          AND psoqent = sr.psoqent
#          AND psoqsite = sr.psoqsite
#       
#       #延遲天數計算
#       LET sr.v1_delay = sr.b_psoq024 - sr.b_psoq007
#       LET sr.v2_delay = sr.c_psoq024 - sr.c_psoq007
#       #原幣金額計算
#       LET sr.v1_sum = l_xmdc015 * sr.b_psoq006
#       LET sr.v2_sum = l_xmdc015 * sr.c_psoq006
#       #本幣金額計算
#       LET sr.v1_sum_o = sr.v1_sum * l_xmda016
#       LET sr.v2_sum_o = sr.v2_sum * l_xmda016
#       CALL apsr003_x01_if_negative_number(sr.v1_delay) RETURNING sr.v1_delay
#       CALL apsr003_x01_if_negative_number(sr.v2_delay) RETURNING sr.v2_delay
       #160503-00030#18-mark-(E)  
       IF tm.p03 = 'Y' THEN
          IF (sr.b_psoq006 = sr.c_psoq006 AND sr.b_psoq007 = sr.c_psoq007 AND sr.b_psoq024 = sr.c_psoq024) THEN
             CONTINUE FOREACH
          END IF
       END IF
      
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.l_psoq004,sr.psoq009,sr.l_pmaal003,sr.l_psoq036,sr.l_psoq036_desc,sr.l_psoq043,sr.l_imaal003,sr.l_imaal004,sr.l_psoq044,sr.b_psoq006,sr.c_psoq006,sr.b_psoq007,sr.c_psoq007,sr.b_psoq024,sr.c_psoq024,sr.v1_delay,sr.v2_delay,sr.l_xmda015,sr.v1_sum,sr.v1_sum_o,sr.v2_sum,sr.v2_sum_o
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "apsr003_x01_execute"
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
 
{<section id="apsr003_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION apsr003_x01_rep_data()
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
 
{<section id="apsr003_x01.other_function" readonly="Y" >}

PRIVATE FUNCTION apsr003_x01_if_negative_number(p_param)
DEFINE p_param LIKE type_t.num20
IF p_param <= 0 THEN
   RETURN 0
ELSE
   RETURN p_param
END IF
END FUNCTION

 
{</section>}
 
