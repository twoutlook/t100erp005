#該程式未解開Section, 採用最新樣板產出!
{<section id="apsr005_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:4(2016-10-13 15:28:24), PR版次:0004(2016-10-13 15:58:18)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000073
#+ Filename...: apsr005_x01
#+ Description: ...
#+ Creator....: 05231(2014-07-21 16:25:33)
#+ Modifier...: 07024 -SD/PR- 07024
 
{</section>}
 
{<section id="apsr005_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#160419-00057#1   2016/05/18  By  dorislai  1.把所有版本psxx002都換用MAX(psea002)取代掉
#                                           2.抓psos014的部分，改抓psos005
#160503-00030#19  2016/06/15  By  06821     效能調整
#160824-00003#4   2016/10/13  By  dorislai  抓psos036的地方改抓(psos045 - psos024)

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
       a1 LIKE type_t.chr1000          #APS版本
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
#160419-00057#1-mark-(S)
#DEFINE g_pspc002_0   LIKE pspc_t.pspc002
#DEFINE g_pspc002_1   LIKE pspc_t.pspc002
#DEFINE g_psos002_0   LIKE psos_t.psos002
#DEFINE g_psos002_1   LIKE psos_t.psos002
#DEFINE g_psor002     LIKE psor_t.psor002
#160419-00057#1-mark-(E)
DEFINE g_psea002     LIKE psea_t.psea002 #160419-00057#1-add
#end add-point
 
{</section>}
 
{<section id="apsr005_x01.main" readonly="Y" >}
PUBLIC FUNCTION apsr005_x01(p_arg1,p_arg2)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr1000         #tm.a1  APS版本
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.a1 = p_arg2
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "apsr005_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL apsr005_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL apsr005_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL apsr005_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL apsr005_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL apsr005_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="apsr005_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION apsr005_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "pspc050.pspc_t.pspc050,l_imaal003.type_t.chr200,l_imaal004.type_t.chr200,pspc051.pspc_t.pspc051,l_qty01.type_t.num20_6,l_qty02.type_t.num20_6,l_qty03.type_t.num20_6,l_qty04.type_t.num20_6,l_qty05.type_t.num20_6,l_qty06.type_t.num20_6,l_qty07.type_t.num20_6,l_qty08.type_t.num20_6,l_qty09.type_t.num20_6,l_qty10.type_t.num20_6" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="apsr005_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION apsr005_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?)"
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
 
{<section id="apsr005_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apsr005_x01_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define(客製用) name="sel_prep.define_customerization"

#end add-point
#add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
 
#end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   #160503-00030#19 --s add  
   LET g_psea002 = ''
   SELECT MAX(psea002) INTO g_psea002
    FROM psea_t 
   WHERE psea001 = tm.a1 AND pseaent = g_enterprise AND pseasite = g_site
   #160503-00030#19 --e add 
   #end add-point
 
   #add-point:sel_prep g_select name="sel_prep.g_select"
   #160503-00030#19 --s mark
   #LET g_select =
   #  "   SELECT DISTINCT b.pspcent,b.pspcsite,b.pspc001,b.pspc002,b.pspc050,d.imaal003,d.imaal004,b.pspc051,",
   #  "          '','','','','','','','','',''"
   #160503-00030#19 --e mark
   
   #160503-00030#19 --s add  
   LET g_select =
     "   SELECT DISTINCT b.pspcent,b.pspcsite,b.pspc001,b.pspc002,b.pspc050,",
     "          (SELECT imaal003 FROM imaal_t WHERE imaalent = b.pspcent AND imaal001 = b.pspc050 AND imaal002 ='", g_dlang,"'),",
     "          (SELECT imaal004 FROM imaal_t WHERE imaalent = b.pspcent AND imaal001 = b.pspc050 AND imaal002 ='", g_dlang,"'),",
     "          b.pspc051,",
     #庫存數
     "          (SELECT COALESCE(SUM(COALESCE(pspt007,0)),0) FROM pspt_t WHERE pspt011 = b.pspc050 AND pspt001 = b.pspc001 AND psptent = b.pspcent ",
     "              AND psptsite = b.pspcsite AND pspt002 = '",g_psea002,"' ), ",
     #庫存剩餘量
     "          (SELECT COALESCE(SUM(COALESCE(psor004,0)),0) FROM psor_t WHERE psorent = b.pspcent AND psorsite = b.pspcsite AND psor001 = b.pspc001 ",
     "              AND psor013 = b.pspc050 AND psor002 = '",g_psea002,"' ), ",
     "          '','','','','','','',''"
   #160503-00030#19 --e add
   
#   #end add-point
#   LET g_select = " SELECT pspcent,pspcsite,pspc001,pspc002,pspc050,'','',pspc051,NULL,NULL,NULL,NULL, 
#       NULL,'',NULL,NULL,NULL,''"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   #160419-00057#1-mod-(S)
#   SELECT MAX(pspc002) INTO g_pspc002_0
#     FROM pspc_t
#    WHERE pspcent = g_enterprise 
#      AND pspcsite = g_site 
#      AND pspc001 = tm.a1
#      AND pspc007 = 0
#   SELECT MAX(pspc002) INTO g_pspc002_1
#     FROM pspc_t
#    WHERE pspcent = g_enterprise 
#      AND pspcsite = g_site 
#      AND pspc001 = tm.a1
#      AND pspc007 = 1
#   SELECT MAX(psos002) INTO g_psos002_0
#     FROM psos_t
#    WHERE psosent = g_enterprise 
#      AND psossite = g_site 
#      AND psos001 = tm.a1
#      AND psos009 = 0
#   SELECT MAX(psos002) INTO g_psos002_1
#     FROM psos_t
#    WHERE psosent = g_enterprise 
#      AND psossite = g_site 
#      AND psos001 = tm.a1
#      AND psos009 = 1
#   SELECT MAX(psor002) INTO g_psor002
#     FROM psor_t
#    WHERE psorent = g_enterprise 
#      AND psorsite = g_site 
#      AND psor001 = tm.a1
   #160503-00030#19 --s mark
   #SELECT MAX(psea002) INTO g_psea002
   # FROM psea_t 
   #WHERE psea001 = tm.a1 AND pseaent = g_enterprise AND pseasite = g_site
   #160503-00030#19 --e mark
   #160419-00057#1-mod-(E)   
#   LET g_from =
#       " FROM  psca_t a, ",
#       "      (SELECT psoqent ,psoqsite ,psoq001 ,max(psoq002) AS psoq002 FROM psoq_t GROUP BY psoqent,psoqsite,psoq001) b ",
#       "        LEFT JOIN psoq_t  d ON d.psoqent=b.psoqent AND d.psoqsite=b.psoqsite AND d.psoq001=b.psoq001 AND d.psoq002=b.psoq002 ",
#       "        LEFT JOIN xmda_t  e ON e.xmdaent=d.psoqent AND e.xmdadocno =substr(d.psoq004,1,20),",
#       "     (SELECT pspcent, pspcsite,pspc001,pspc002,pspc050,pspc051 FROM pspc_t UNION ",
#       "      SELECT psosent, psossite,psos001,psos002,psos054,psos055 FROM psos_t UNION ",
#       "      SELECT psorent, psorsite,psor001,psor002,psor013,psor014 FROM psor_t  ) c  ",
#       "        LEFT JOIN imaa_t  f ON f.imaaent =c.pspcent AND f.imaa001 =c.pspc050     ",
#       "        LEFT JOIN imae_t  n ON n.imaeent =c.pspcent AND n.imae001 =c.pspc050 AND n.imaesite=c.pspcsite ",
#       "        LEFT JOIN imaf_t  g ON g.imafent =c.pspcent AND g.imaf001 =c.pspc050 AND g.imafsite=c.pspcsite  ",
#       "        LEFT JOIN imaal_t h ON h.imaalent=c.pspcent AND h.imaal001=c.pspc050 AND h.imaal002='",g_dlang,"'",
#       "        LEFT JOIN psor_t  i ON i.psorent =c.pspcent AND i.psorsite=c.pspcsite AND i.psor001=c.pspc001 AND i.psor002=c.pspc002 ",
#       "        LEFT JOIN psos_t  j ON j.psosent =c.pspcent AND j.psossite=c.pspcsite AND j.psos001=c.pspc001 AND j.psos002=c.pspc002 AND j.psos009=0 ",
#       "        LEFT JOIN pspc_t  k ON k.pspcent =c.pspcent AND k.pspcsite=c.pspcsite AND k.pspc001=c.pspc001 AND k.pspc002=c.pspc002 AND k.pspc007=0 ",
#       "        LEFT JOIN psos_t  l ON l.psosent =c.pspcent AND l.psossite=c.pspcsite AND l.psos001=c.pspc001 AND l.psos002=c.pspc002 AND l.psos009=1 ",
#       "        LEFT JOIN pspc_t  m ON m.pspcent =c.pspcent AND m.pspcsite=c.pspcsite AND m.pspc001=c.pspc001 AND m.pspc002=c.pspc002 AND m.pspc007=1 "
   #160419-00057#1-mod-(S)
#   LET g_from =
#       " FROM  psca_t a, ",
#       "      (SELECT pspcent,pspcsite,pspc001,pspc002,pspc050,pspc051",
#       "         FROM pspc_t ",
#       "        WHERE pspc001 = '",tm.a1,"' AND pspc007 = 1 AND pspc002 = '",g_pspc002_1,"'",
#       " UNION SELECT pspcent,pspcsite,pspc001,pspc002,pspc050,pspc051",
#       "         FROM pspc_t ",
#       "        WHERE pspc001 = '",tm.a1,"' AND pspc007 = 0 AND pspc002 = '",g_pspc002_0,"'",
#       " UNION SELECT psosent,psossite,psos001,psos002,psos054,psos055",
#       "         FROM psos_t ",
#       "        WHERE psos001 = '",tm.a1,"' AND psos009 = 1 AND psos002 = '",g_psos002_1,"'",
#       " UNION SELECT psosent,psossite,psos001,psos002,psos054,psos055",
#       "         FROM psos_t ",
#       "        WHERE psos001 = '",tm.a1,"' AND psos009 = 0 AND psos002 = '",g_psos002_0,"'",
#       " UNION SELECT psorent,psorsite,psor001,psor002,psor013,psor014",
#       "         FROM psor_t ",
#       "        WHERE psor001 = '",tm.a1,"' AND psor002 = '",g_psor002,"') b",
#       "       LEFT OUTER JOIN imaal_t d ON imaalent = b.pspcent AND imaal001 = b.pspc050 AND imaal002 ='", g_dlang,"'",
#       "       LEFT OUTER JOIN imaa_t ON imaaent = b.pspcent AND imaa001 = b.pspc050",
#       "       LEFT OUTER JOIN imaf_t ON imafent = b.pspcent AND imafsite = b.pspcsite AND imaf001 = b.pspc050",
#       "       LEFT OUTER JOIN imae_t ON imaeent = b.pspcent AND imaesite = b.pspcsite AND imae001 = b.pspc050"
   LET g_from =
       " FROM  psca_t a, ",
       "      (SELECT pspcent,pspcsite,pspc001,pspc002,pspc050,pspc051",
       "         FROM pspc_t ",
       "        WHERE pspc001 = '",tm.a1,"' AND pspc007 = 1 AND pspc002 = '",g_psea002,"'",
       " UNION SELECT pspcent,pspcsite,pspc001,pspc002,pspc050,pspc051",
       "         FROM pspc_t ",
       "        WHERE pspc001 = '",tm.a1,"' AND pspc007 = 0 AND pspc002 = '",g_psea002,"'",
       " UNION SELECT psosent,psossite,psos001,psos002,psos054,psos055",
       "         FROM psos_t ",
       "        WHERE psos001 = '",tm.a1,"' AND psos009 = 1 AND psos002 = '",g_psea002,"'",
       " UNION SELECT psosent,psossite,psos001,psos002,psos054,psos055",
       "         FROM psos_t ",
       "        WHERE psos001 = '",tm.a1,"' AND psos009 = 0 AND psos002 = '",g_psea002,"'",
       " UNION SELECT psorent,psorsite,psor001,psor002,psor013,psor014",
       "         FROM psor_t ",
       "        WHERE psor001 = '",tm.a1,"' AND psor002 = '",g_psea002,"') b",
       #"       LEFT OUTER JOIN imaal_t d ON imaalent = b.pspcent AND imaal001 = b.pspc050 AND imaal002 ='", g_dlang,"'",   #160503-00030#19 mark
       "       LEFT OUTER JOIN imaa_t ON imaaent = b.pspcent AND imaa001 = b.pspc050",
       "       LEFT OUTER JOIN imaf_t ON imafent = b.pspcent AND imafsite = b.pspcsite AND imaf001 = b.pspc050",
       "       LEFT OUTER JOIN imae_t ON imaeent = b.pspcent AND imaesite = b.pspcsite AND imae001 = b.pspc050"
   #160419-00057#1-mod-(E)
#   #end add-point
#    LET g_from = " FROM pspc_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET g_where = " WHERE " ,tm.wc CLIPPED," AND a.pscaent = b.pspcent     AND a.pscasite = b.pspcsite"
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("pspc_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE apsr005_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE apsr005_x01_curs CURSOR FOR apsr005_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="apsr005_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION apsr005_x01_ins_data()
DEFINE sr RECORD 
   pspcent LIKE pspc_t.pspcent, 
   pspcsite LIKE pspc_t.pspcsite, 
   pspc001 LIKE pspc_t.pspc001, 
   pspc002 LIKE pspc_t.pspc002, 
   pspc050 LIKE pspc_t.pspc050, 
   l_imaal003 LIKE type_t.chr200, 
   l_imaal004 LIKE type_t.chr200, 
   pspc051 LIKE pspc_t.pspc051, 
   l_qty01 LIKE type_t.num20_6, 
   l_qty02 LIKE type_t.num20_6, 
   l_qty03 LIKE type_t.num20_6, 
   l_qty04 LIKE type_t.num20_6, 
   l_qty05 LIKE type_t.num20_6, 
   l_qty06 LIKE type_t.num20_6, 
   l_qty07 LIKE type_t.num20_6, 
   l_qty08 LIKE type_t.num20_6, 
   l_qty09 LIKE type_t.num20_6, 
   l_qty10 LIKE type_t.num20_6
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_psos014    LIKE psos_t.psos014
DEFINE l_psos024    LIKE psos_t.psos024
DEFINE l_pspc006    LIKE pspc_t.pspc006
DEFINE l_pspc021    LIKE pspc_t.pspc021
DEFINE l_psos036    LIKE psos_t.psos036
DEFINE l_pspc043    LIKE pspc_t.pspc043
DEFINE l_psos025_0  LIKE psos_t.psos025
DEFINE l_psos025_1  LIKE psos_t.psos025
DEFINE l_pspc022_0  LIKE pspc_t.pspc022
DEFINE l_pspc022_1  LIKE pspc_t.pspc022
DEFINE l_pspt002    LIKE pspt_t.pspt002
DEFINE l_psos005    LIKE psos_t.psos015   #160419-00057#1-add
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH apsr005_x01_curs INTO sr.*                               
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
       #庫存數
       #160419-00057#1-mark-(S)
#       SELECT MAX(pspt002) INTO l_pspt002
#         FROM pspt_t
#        WHERE psptent = sr.pspcent
#          AND psptsite = sr.pspcsite
#          AND pspt001 = tm.a1
       #160419-00057#1-mark-(E)
       #160503-00030#19 --s mark
       #SELECT SUM(pspt007) INTO sr.l_qty01 
       #  FROM pspt_t 
       # WHERE pspt011 = sr.pspc050
       #   AND pspt001 = sr.pspc001
#      #    AND pspt002 = l_pspt002 #160419-00057#1-mark
       #   AND pspt002 = g_psea002  #160419-00057#1-add
       #   AND psptent = sr.pspcent
       #   AND psptsite = sr.pspcsite
       
       #庫存剩餘量
       #SELECT SUM(psor004) INTO sr.l_qty02
       #  FROM psor_t
       # WHERE psorent = sr.pspcent
       #   AND psorsite = sr.pspcsite
       #   AND psor001 = sr.pspc001
#      #    AND psor002 = g_psor002  #160419-00057#1-mark
       #   AND psor002 = g_psea002   #160419-00057#1-add
       #   AND psor013 = sr.pspc050
       #CALL apsr005_x01_nulltozero(sr.l_qty01)   RETURNING sr.l_qty01  
       #CALL apsr005_x01_nulltozero(sr.l_qty02)   RETURNING sr.l_qty02
       #160503-00030#19 --e mark
       LET sr.l_qty03 = sr.l_qty01 - sr.l_qty02   
       #160419-00057#1-mod-(S)
#       SELECT SUM(psos014),SUM(psos024),SUM(psos025) INTO l_psos014,l_psos024,l_psos025_0
#         FROM psos_t
#        WHERE psosent = sr.pspcent
#          AND psossite = sr.pspcsite
#          AND psos001 = sr.pspc001
#          AND psos002 = g_psos002_0
#          AND psos009 = 0
#          AND psos054 = sr.pspc050
       #SELECT SUM(psos005),SUM(psos024),SUM(psos025) INTO l_psos005,l_psos024,l_psos025_0 #160503-00030#19 mark
       #160503-00030#19 --s add
       SELECT COALESCE(SUM(COALESCE(psos005,0)),0),COALESCE(SUM(COALESCE(psos024,0)),0),COALESCE(SUM(COALESCE(psos025,0)),0) 
         INTO l_psos005,l_psos024,l_psos025_0
       #160503-00030#19 --e add
         FROM psos_t
        WHERE psosent = sr.pspcent
          AND psossite = sr.pspcsite
          AND psos001 = sr.pspc001
          AND psos002 = g_psea002    
          AND psos009 = 0
          AND psos054 = sr.pspc050   
       #160419-00057#1-mod-(E)
       
       #160824-00003#4-s-mod
       ##SELECT SUM(psos025),SUM(psos036) INTO l_psos025_1,l_psos036 #160503-00030#19 mark
       ##160503-00030#19 --s add
       #SELECT COALESCE(SUM(COALESCE(psos025,0)),0),COALESCE(SUM(COALESCE(psos036,0)),0)
       #  INTO l_psos025_1,l_psos036
       ##160503-00030#19 --e add  
       SELECT COALESCE(SUM(COALESCE(psos025,0)),0),COALESCE(SUM(COALESCE(psos045,0))-SUM(COALESCE(psos024,0)),0)
         INTO l_psos025_1,l_psos036
       #160824-00003#4-e-mod
         FROM psos_t
        WHERE psosent = sr.pspcent
          AND psossite = sr.pspcsite
          AND psos001 = sr.pspc001
#          AND psos002 = g_psos002_1  #160419-00057#1-mark
          AND psos002 = g_psea002     #160419-00057#1-add
          AND psos009 = 1
          AND psos054 = sr.pspc050
          
       #SELECT SUM(pspc006),SUM(pspc021),SUM(pspc022) INTO l_pspc006,l_pspc021,l_pspc022_0 #160503-00030#19 mark
       #160503-00030#19 --s add
       SELECT COALESCE(SUM(COALESCE(pspc006,0)),0),COALESCE(SUM(COALESCE(pspc021,0)),0),COALESCE(SUM(COALESCE(pspc022,0)),0) 
         INTO l_pspc006,l_pspc021,l_pspc022_0
       #160503-00030#19 --e add
         FROM pspc_t
        WHERE pspcent = sr.pspcent
          AND pspcsite = sr.pspcsite
          AND pspc001 = sr.pspc001
#          AND pspc002 = g_pspc002_1   #160419-00057#1-mark
          AND pspc002 = g_psea002      #160419-00057#1-add
          AND pspc007 = 0
          AND pspc050 = sr.pspc050
          
       #SELECT SUM(pspc022),SUM(pspc043) INTO l_pspc022_1,l_pspc043 #160503-00030#19 mark
       #160503-00030#19 --s add
       SELECT COALESCE(SUM(COALESCE(pspc022,0)),0),COALESCE(SUM(COALESCE(pspc043,0)),0) 
         INTO l_pspc022_1,l_pspc043
       #160503-00030#19 --e add
         FROM pspc_t
        WHERE pspcent = sr.pspcent
          AND pspcsite = sr.pspcsite
          AND pspc001 = sr.pspc001
#          AND pspc002 = g_pspc002_1    #160419-00057#1-mark
          AND pspc002 = g_psea002       #160419-00057#1-add
          AND pspc007 = 1
          AND pspc050 = sr.pspc050
       #160419-00057#1-mod-(S)   
#       CALL apsr005_x01_nulltozero(l_psos014)   RETURNING l_psos014  
       #CALL apsr005_x01_nulltozero(l_psos005)   RETURNING l_psos005   #160503-00030#19 mark
       #160419-00057#1-mod-(E)
       #160503-00030#19 mark --s
       #CALL apsr005_x01_nulltozero(l_psos024)   RETURNING l_psos024  
       #CALL apsr005_x01_nulltozero(l_pspc006)   RETURNING l_pspc006  
       #CALL apsr005_x01_nulltozero(l_pspc021)   RETURNING l_pspc021  
       #CALL apsr005_x01_nulltozero(l_psos036)   RETURNING l_psos036  
       #CALL apsr005_x01_nulltozero(l_pspc043)   RETURNING l_pspc043  
       #CALL apsr005_x01_nulltozero(l_psos025_0) RETURNING l_psos025_0
       #CALL apsr005_x01_nulltozero(l_psos025_1) RETURNING l_psos025_1
       #CALL apsr005_x01_nulltozero(l_pspc022_0) RETURNING l_pspc022_0
       #CALL apsr005_x01_nulltozero(l_pspc022_1) RETURNING l_pspc022_1
       #160503-00030#19 mark --e
       #160419-00057#1-mod-(S)  
#       LET sr.l_qty04 = (l_psos014-l_psos024) + (l_pspc006-l_pspc021)
       LET sr.l_qty04 = (l_psos005-l_psos024) + (l_pspc006-l_pspc021)
       #160419-00057#1-mod-(E) 
       LET sr.l_qty06 = l_psos025_0 + l_pspc022_0
       LET sr.l_qty05 = sr.l_qty04 - sr.l_qty06
       LET sr.l_qty07 = l_psos036 + l_pspc043
       LET sr.l_qty09 = l_psos025_1 + l_pspc022_1
       LET sr.l_qty08 = sr.l_qty07 - sr.l_qty09
       LET sr.l_qty10 = sr.l_qty03 + sr.l_qty06 + sr.l_qty09
       IF sr.l_qty10 = 0 THEN
          CONTINUE FOREACH
       END IF
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.pspc050,sr.l_imaal003,sr.l_imaal004,sr.pspc051,sr.l_qty01,sr.l_qty02,sr.l_qty03,sr.l_qty04,sr.l_qty05,sr.l_qty06,sr.l_qty07,sr.l_qty08,sr.l_qty09,sr.l_qty10
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "apsr005_x01_execute"
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
 
{<section id="apsr005_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION apsr005_x01_rep_data()
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
 
{<section id="apsr005_x01.other_function" readonly="Y" >}

PRIVATE FUNCTION apsr005_x01_nulltozero(p_arg)
   DEFINE p_arg LIKE type_t.num20_6

   IF cl_null(p_arg) THEN
      LET p_arg = 0
   END IF

   RETURN p_arg
END FUNCTION

 
{</section>}
 
