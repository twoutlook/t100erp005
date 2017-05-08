#該程式未解開Section, 採用最新樣板產出!
{<section id="abmr617_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:5(2016-10-13 14:39:04), PR版次:0005(2016-10-12 22:24:22)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000047
#+ Filename...: abmr617_x01
#+ Description: ...
#+ Creator....: 05423(2015-10-29 11:50:40)
#+ Modifier...: 07025 -SD/PR- 07025
 
{</section>}
 
{<section id="abmr617_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#160629-00002#11  2016/06/29  By zhujing     效能优化
#160727-00019#7   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 abmr617_bmbc_tmp ——> abmr617_tmp01
#161011-00034#1   16/10/12 By catmoon 當比較的料為2筆以上時(EX:A.B.C)，原先的SQL會把A=B的排除，導致A<>C時無法顯示。修改SQL，讓他的等於筆數必須等於比較的料號數量
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
       level LIKE type_t.chr2,         #展階選項 
       pr LIKE type_t.chr2,         #是否列印無異 
       chk LIKE type_t.chr2          #集團/營運據
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
TYPE type_wc RECORD
   wc    STRING
END RECORD
TYPE type_date RECORD
   date     LIKE type_t.chr100,
   bmbc001  LIKE bmbc_t.bmbc001,
   bmbc002  LIKE bmbc_t.bmbc002
END RECORD   

DEFINE l_wc              DYNAMIC ARRAY OF type_wc  
DEFINE l_date            DYNAMIC ARRAY OF type_date
DEFINE g_type     LIKE type_t.num20
DEFINE g_pid      LIKE type_t.num20
DEFINE g_id       LIKE type_t.num20
DEFINE g_tmp_id      LIKE type_t.num20   #临时表结点编号
DEFINE g_cnt        LIKE type_t.num10   
DEFINE g_qbe         STRING
#end add-point
 
{</section>}
 
{<section id="abmr617_x01.main" readonly="Y" >}
PUBLIC FUNCTION abmr617_x01(p_arg1,p_arg2,p_arg3,p_arg4)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr2         #tm.level  展階選項 
DEFINE  p_arg3 LIKE type_t.chr2         #tm.pr  是否列印無異 
DEFINE  p_arg4 LIKE type_t.chr2         #tm.chk  集團/營運據
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.level = p_arg2
   LET tm.pr = p_arg3
   LET tm.chk = p_arg4
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   CALL abmr617_x01_getwc(tm.wc) RETURNING l_wc,l_date,g_qbe      #拆解wc，获取画面单身条件
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "abmr617_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL abmr617_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL abmr617_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL abmr617_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL abmr617_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL abmr617_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="abmr617_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION abmr617_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "l_no.type_t.num10,bmbc001.bmbc_t.bmbc001,l_imaal003_1.imaal_t.imaal003,l_imaal004_1.imaal_t.imaal004,bmbc002.bmbc_t.bmbc002,l_bmbc001_bmbc002.type_t.chr200,bmbc003.bmbc_t.bmbc003,l_imaal003_2.imaal_t.imaal003,l_imaal004_2.imaal_t.imaal004,bmbc010.bmbc_t.bmbc010,bmbc011.bmbc_t.bmbc011" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   DROP TABLE abmr617_tmp01    #160727-00019#7   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 abmr617_bmbc_tmp ——> abmr617_tmp01
   CREATE TEMP TABLE abmr617_tmp01(   #160727-00019#7   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 abmr617_bmbc_tmp ——> abmr617_tmp01
   bmbc001  LIKE bmbc_t.bmbc001, 
   bmbc002  LIKE bmbc_t.bmbc002, 
   bmbc003  LIKE bmbc_t.bmbc003,
   bmbc010  LIKE bmbc_t.bmbc010,
   bmbc005  DATETIME YEAR TO FRACTION(5),
   bmbc011  LIKE bmbc_t.bmbc011,
   bmbcent  LIKE bmbc_t.bmbcent, 
   bmbcsite LIKE bmbc_t.bmbcsite,
   l_type   LIKE type_t.num10,      #树编号
   l_pid    LIKE type_t.num10,      #父结点ID
   l_id     LIKE type_t.num10);     #结点ID 
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="abmr617_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION abmr617_x01_ins_prep()
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
         #料号临时表插入准备
         #INSERT INTO PREP
         LET g_sql = " INSERT INTO abmr617_tmp01 VALUES(?,?,?,?,?,?,?,?,?,?,?)"   #160727-00019#7   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 abmr617_bmbc_tmp ——> abmr617_tmp01
         PREPARE insert_prep1 FROM g_sql
         IF STATUS THEN
            LET l_prep_str ="insert_tmp_prep"
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_prep_str
            LET g_errparam.code   = status
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            DROP TABLE abmr617_tmp01  #160727-00019#7   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 abmr617_bmbc_tmp ——> abmr617_tmp01
            LET g_rep_success = 'N'           
         END IF 
         #end add-point                  
 
 
      END CASE
   END FOR
END FUNCTION
 
{</section>}
 
{<section id="abmr617_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION abmr617_x01_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define(客製用) name="sel_prep.define_customerization"

#end add-point
#add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
DEFINE g_order       STRING
DEFINE l_cnt         LIKE type_t.num5
DEFINE l_sql         DYNAMIC ARRAY OF type_wc  
DEFINE l_sql1        STRING
DEFINE l_tmp_sql     STRING
DEFINE l_tmp_name    STRING
DEFINE l_bmbc011_sql STRING   #160629-00002#11 add
DEFINE l_sub_sql     STRING   #160629-00002#11 add
DEFINE l_wc_cnt      LIKE type_t.num5  #161011-00034#1

#end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   LET l_tmp_name = 'abmr617_tmp01'  #160727-00019#7   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 abmr617_bmbc_tmp ——> abmr617_tmp01
   #161011-00034#1--add--start--
   IF tm.pr='Y' THEN
      LET l_wc_cnt=0
      FOR l_cnt = 1 TO l_wc.getLength()
         IF NOT cl_null(l_wc[l_cnt].wc) THEN
            LET l_wc_cnt = l_wc_cnt+1;
         ELSE
            EXIT FOR
         END IF 
      END FOR
      LET l_wc_cnt = l_wc_cnt - 1
   END IF  
   #161011-00034#1--add--end----
   #end add-point
 
   #add-point:sel_prep g_select name="sel_prep.g_select"
   #160629-00002#11 marked-S
#   LET g_select = " SELECT NULL,a.bmbc001,NULL,NULL,a.bmbc002,trim(a.bmbc001)||'('||trim(a.bmbc002)||')', 
#       a.bmbc003,NULL,NULL,a.bmbc010,a.bmbc011"
   #160629-00002#11 marked-E
   #160629-00002#11 mod-S
   LET g_select = " SELECT NULL,a.bmbc001,",
                  " (SELECT imaal003 FROM imaal_t WHERE imaal001 = a.bmbc001 AND imaalent = ",g_enterprise," AND imaal002 = '",g_dlang,"') t1_imaal003,",
                  " (SELECT imaal004 FROM imaal_t WHERE imaal001 = a.bmbc001 AND imaalent = ",g_enterprise," AND imaal002 = '",g_dlang,"') t1_imaal004,",
                  " a.bmbc002,trim(a.bmbc001)||'('||trim(a.bmbc002)||')',",
                  " a.bmbc003,",                  
                  " (SELECT imaal003 FROM imaal_t WHERE imaal001 = a.bmbc003 AND imaalent = ",g_enterprise," AND imaal002 = '",g_dlang,"') t2_imaal003,",
                  " (SELECT imaal004 FROM imaal_t WHERE imaal001 = a.bmbc003 AND imaalent = ",g_enterprise," AND imaal002 = '",g_dlang,"') t2_imaal003,",
                  " a.bmbc010,a.bmbc011"
   #160629-00002#11 mod-E
#   #end add-point
#   LET g_select = " SELECT NULL,bmbc001,NULL,NULL,bmbc002,trim(bmbc001)||'.'||trim(bmbc002),bmbc003, 
#       NULL,NULL,bmbc010,bmbc011"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   CASE tm.pr
      WHEN 'N'
         LET g_from = " FROM ",l_tmp_name CLIPPED," a "
      WHEN 'Y' 
#         LET g_from = " FROM ",l_tmp_name CLIPPED," a ,",l_tmp_name CLIPPED," b "     #2015-11-27 zhujing marked
         LET g_from = " FROM ",l_tmp_name CLIPPED," a "                                #2015-11-27 zhujing add
   END CASE
#   #end add-point
#    LET g_from = " FROM bmbc_t,imaal_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   CASE tm.pr
      WHEN 'N'
         LET g_where = " WHERE 1=1 "
      WHEN 'Y'
         #2015-11-27 zhujing marked---(S)
#         LET g_where = " WHERE a.bmbc010 = b.bmbc010 AND a.bmbc003 = b.bmbc003 AND (((a.bmbc001 <> b.bmbc001 OR a.bmbc002 <> b.bmbc002) ",
#                       " AND a.bmbc011 <> b.bmbc011 ) OR (a.bmbc001 = b.bmbc001 AND a.bmbc002 = b.bmbc002 AND a.bmbc011 = b.bmbc011))  "
         #2015-11-27 zhujing marked---(E)
         #2015-11-27 zhujing add---(S)
         LET g_where = " WHERE a.bmbc003 NOT IN (SELECT b.bmbc003 FROM ",l_tmp_name CLIPPED," b ",
                       " WHERE a.bmbc010 = b.bmbc010 AND a.bmbc003 = b.bmbc003 AND ((a.bmbc001 <> b.bmbc001 OR a.bmbc002 <> b.bmbc002) ",
                      #" AND a.bmbc011 = b.bmbc011 )) "  #161011-00034#1 mark
                       " AND a.bmbc011 = b.bmbc011 ) GROUP BY b.bmbc003 HAVING COUNT(*) =",l_wc_cnt,") " #161011-00034#1 add
         #2015-11-27 zhujing add---(E)                       
   END CASE
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   LET g_order  = " ORDER BY a.bmbc010,a.bmbc003,a.bmbc001 "
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED,' ', g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
   #使用临时表存放主件与元件资料，计算差异、全部料件后存放至报表暂存档。
   CASE tm.level
      WHEN '1'
         #2015-11-30 zhujing marked 直接使用bmaa_t的来展开树------（S）
#         LET l_tmp_sql = " SELECT DISTINCT bmbc001,bmbc002,bmbc003,bmbc010,bmbc005,bmbc011,bmbcent,bmbcsite,0,0,0 ",
#                         " FROM bmbc_t ",
#                         " WHERE (",tm.wc CLIPPED,") "
         LET l_tmp_sql = " SELECT DISTINCT bmba001,bmba002,bmba003,bmbc010,bmba005,bmbc011,bmbaent,bmbasite,0,0,0 ",
                         "   FROM bmaa_t LEFT OUTER JOIN bmba_t ON bmba001 = bmaa001 AND bmba002 = bmaa002 AND bmbaent = bmaaent AND bmbasite = bmaasite ",
                         "   LEFT OUTER JOIN bmbc_t ON bmbc001 = bmba001 AND bmbc002 = bmba002 AND bmbc003 = bmba003 AND bmbc004 = bmba004 ",
                         "   AND bmbc005 = bmba005 AND bmbc007 = bmba007 AND bmbc008 = bmba008 AND bmbcent = bmbaent AND bmbcsite = bmbasite ",
                         " WHERE (",tm.wc CLIPPED,") " 
                                 
      WHEN '2'
#         LET l_tmp_sql = " SELECT DISTINCT bmbc001,bmbc002,bmbc003,NULL,bmbc005,NULL,bmbcent,bmbcsite,0,0,0 ",
#                         " FROM bmbc_t ",
#                         " WHERE (",tm.wc CLIPPED,") "
         LET l_tmp_sql = " SELECT DISTINCT bmba001,bmba002,bmba003,NULL,bmba005,NULL,bmbaent,bmbasite,0,0,0 ",
                         "   FROM bmaa_t LEFT OUTER JOIN bmba_t ON bmba001 = bmaa001 AND bmba002 = bmaa002 AND bmbaent = bmaaent AND bmbasite = bmaasite ",
                         "   LEFT OUTER JOIN bmbc_t ON bmbc001 = bmba001 AND bmbc002 = bmba002 AND bmbc003 = bmba003 AND bmbc004 = bmba004 ",
                         "   AND bmbc005 = bmba005 AND bmbc007 = bmba007 AND bmbc008 = bmba008 AND bmbcent = bmbaent AND bmbcsite = bmbasite ",
                         " WHERE (",tm.wc CLIPPED,") "             
         #2015-11-30 zhujing mod 直接使用bmaa_t的来展开树---------（E）                          
   END CASE
   CASE tm.chk
      WHEN '1'
         #2015-11-30 zhujing mod 直接使用bmaa_t的来展开树---------（S）    
#         LET l_tmp_sql = l_tmp_sql CLIPPED," AND bmbcsite = 'ALL' "
         LET l_tmp_sql = l_tmp_sql CLIPPED," AND bmaasite = 'ALL' AND bmbc010 IS NOT NULL "  #2016-2-1 zhujing mod 添加插件位置不为空的筛选
      WHEN '2'
#         LET l_tmp_sql = l_tmp_sql CLIPPED," AND bmbcsite = '",g_site,"' "
         LET l_tmp_sql = l_tmp_sql CLIPPED," AND bmaasite = '",g_site,"' "
         #2015-11-30 zhujing mod 直接使用bmaa_t的来展开树---------（E）    
   END CASE               
   LET l_tmp_sql = cl_sql_add_mask(l_tmp_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段                   
   PREPARE abmr617_x01_tmp_prepare FROM l_tmp_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE abmr617_x01_tmp_curs CURSOR FOR abmr617_x01_tmp_prepare 
#   #end add-point:sel_prep.sql.before
#   LET g_where = g_where ,cl_sql_add_filter("bmbc_t")   #資料過濾功能
#   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
#   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
# 
#   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   #160629-00002#11 add-S
   LET l_bmbc011_sql = " SELECT DISTINCT bmbc010,bmbc011 ",    #160331-00005#1 add             
                       "  FROM bmbc_t ",
                       " INNER JOIN bmba_t ON bmbaent = bmbcent AND bmbasite = bmbcsite AND bmba001 = bmbc001 AND bmba002 = bmbc002 AND bmba003 = bmbc003 AND bmba004 = bmbc004 AND bmba005 = bmbc005 AND bmba007 = bmbc007 AND bmba008 = bmbc008",            #160331-00005#1 add                                 
                       " WHERE bmbc001 = ? ",
                       "   AND bmbc002 = ? ",
                       "   AND bmbc003 = ? ",
                       "   AND bmbcent = ? ",
                       "   AND bmbcsite = ? ",
                       "   AND to_char(bmbc005,'yyyy-mm-dd hh24:mi:ss') <= ? "
   LET l_sub_sql = "SELECT COUNT(1) FROM (",l_bmbc011_sql,")"
   PREPARE bmbc011_cnt_pre FROM l_sub_sql
   DECLARE bmbc011_curs CURSOR FROM l_bmbc011_sql
   LET l_sql1 = " SELECT DISTINCT bmba001,bmba002,bmba003,NULL,bmba005,NULL,bmbaent,bmbasite,?,?,0 ",
               "   FROM bmaa_t LEFT OUTER JOIN bmba_t ON bmba001 = bmaa001 AND bmba002 = bmaa002 AND bmbaent = bmaaent AND bmbasite = bmaasite ",
               "   LEFT OUTER JOIN bmbc_t ON bmbc001 = bmba001 AND bmbc002 = bmba002 AND bmbc003 = bmba003 AND bmbc004 = bmba004 ",
               "   AND bmbc005 = bmba005 AND bmbc007 = bmba007 AND bmbc008 = bmba008 AND bmbcent = bmbaent AND bmbcsite = bmbasite ",
               "  WHERE bmaaent = ?",
               "    AND bmaasite = ?",
               "    AND bmba001 = ?",
               "    AND bmba002 = ?",
               "    AND to_char(bmba005,'yyyy-mm-dd hh24:mi:ss') <= ?",
               "    AND (to_char(bmba006,'yyyy-mm-dd hh24:mi:ss') > ?"," OR to_char(bmba006,'yyyy-mm-dd hh24:mi:ss') IS NULL )",   #160331-00005#1 add  
               "    AND ",g_qbe CLIPPED,
               "  ORDER BY bmba003"            
   #2015-11-30 zhujing mod 直接使用bmaa_t的来展开树---------（E）
   LET l_sub_sql = "SELECT COUNT(1) FROM (",l_sql1,")"
   PREPARE abmr617_x01_tmp_bom_cnt_pre FROM l_sub_sql
   PREPARE abmr617_x01_prepare_tmp_bom FROM l_sql1
   DECLARE abmr617_x01_tmp_bom CURSOR FOR abmr617_x01_prepare_tmp_bom
   LET l_sql1 = " SELECT DISTINCT bmbc010,bmbc011 ",    #160331-00005#1 add            
               "  FROM bmbc_t ",
               " INNER JOIN bmba_t ON bmbaent = bmbcent AND bmbasite = bmbcsite AND bmba001 = bmbc001 AND bmba002 = bmbc002 AND bmba003 = bmbc003 AND bmba004 = bmbc004 AND bmba005 = bmbc005 AND bmba007 = bmbc007 AND bmba008 = bmbc008",            #160331-00005#1 add                                  
               " WHERE bmbc001 = ? ",
               "   AND bmbc002 = ? ",
               "   AND bmbc003 = ? ",
               "   AND bmbcent = ? ",
               "   AND bmbcsite = ? ",
               "   AND to_char(bmbc005,'yyyy-mm-dd hh24:mi:ss') <= ? "
   LET l_sub_sql = "SELECT COUNT(1) FROM (",l_sql1,")"
   PREPARE bmbc010_cnt_pre FROM l_sub_sql
   DECLARE bmbc010_curs CURSOR FROM l_sql1
   #160629-00002#11 add-E            
   #end add-point
   PREPARE abmr617_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE abmr617_x01_curs CURSOR FOR abmr617_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="abmr617_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION abmr617_x01_ins_data()
DEFINE sr RECORD 
   l_no LIKE type_t.num10, 
   bmbc001 LIKE bmbc_t.bmbc001, 
   l_imaal003_1 LIKE imaal_t.imaal003, 
   l_imaal004_1 LIKE imaal_t.imaal004, 
   bmbc002 LIKE bmbc_t.bmbc002, 
   l_bmbc001_bmbc002 LIKE type_t.chr200, 
   bmbc003 LIKE bmbc_t.bmbc003, 
   l_imaal003_2 LIKE imaal_t.imaal003, 
   l_imaal004_2 LIKE imaal_t.imaal004, 
   bmbc010 LIKE bmbc_t.bmbc010, 
   bmbc011 LIKE bmbc_t.bmbc011
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
   DEFINE l_type LIKE type_t.num20
   DEFINE l_pid  LIKE type_t.num20
   DEFINE l_id   LIKE type_t.num20
   DEFINE l_success LIKE type_t.chr1
   DEFINE l_len   LIKE type_t.num5
   DEFINE l_no    LIKE type_t.num5
   DEFINE l_tmp   LIKE type_t.chr100
   DEFINE l_bmbc003  LIKE bmbc_t.bmbc003
   DEFINE l_bmbc010  LIKE bmbc_t.bmbc010
   DEFINE l_cnt   LIKE type_t.num5
   
   DEFINE l_bmbc001    LIKE bmbc_t.bmbc001
   DEFINE l_bmbc002    LIKE bmbc_t.bmbc002
   DEFINE l_sql        STRING
   DEFINE l_count      LIKE type_t.num5
   DEFINE l_bmbc001_desc1 LIKE imaal_t.imaal003 #2016-1-12 zhujing mod
   DEFINE l_bmbc001_desc2 LIKE imaal_t.imaal004 #2016-1-12 zhujing mod
   DEFINE l_key LIKE type_t.chr50
   DEFINE l_bmbc011     LIKE bmbc_t.bmbc011
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    INITIALIZE l_bmbc011 TO NULL
    #树准备
    LET l_type = 1
    #序号记录准备
    LET g_cnt = 0
    INITIALIZE l_bmbc003 TO NULL          #用于记录当前笔元件料号是否与上一笔相同
    INITIALIZE l_bmbc010 TO NULL          #用于记录当前笔插件位置是否与上一笔相同
    CALL abmr617_x01_ins_tmp()       #插入主件元件资料至临时表
    
    SELECT COUNT(*) INTO l_cnt FROM abmr617_tmp01  #160727-00019#7   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 abmr617_bmbc_tmp ——> abmr617_tmp01
    #查看是否由于差异料，丢失主件料号资料
    LET l_sql = " SELECT DISTINCT bmbc001,bmbc002 ",
                "   FROM abmr617_tmp01",   #160727-00019#7   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 abmr617_bmbc_tmp ——> abmr617_tmp01
                "  WHERE bmbc001 <> ? ",
                "     OR (bmbc001 = ? AND bmbc002 <> ?) "
    PREPARE abmr617_x01_bmbc001_prepare FROM l_sql
    IF STATUS THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.extend = 'prepare:'
       LET g_errparam.code   = STATUS
       LET g_errparam.popup  = TRUE
       CALL cl_err()
       LET g_rep_success = 'N' 
    END IF
    DECLARE abmr617_x01_bmbc001_curs CURSOR FOR abmr617_x01_bmbc001_prepare 
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH abmr617_x01_curs INTO sr.*                               
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
       #获取品名规格
       #主件
       CALL s_desc_get_item_desc(sr.bmbc001) RETURNING sr.l_imaal003_1,sr.l_imaal004_1
       #元件
       CALL s_desc_get_item_desc(sr.bmbc003) RETURNING sr.l_imaal003_2,sr.l_imaal004_2
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       IF cl_null(sr.bmbc010) THEN CONTINUE FOREACH END IF        #2016-2-2 zhujing add
       #判断是否为相同元件料号+部位，若相同，则给同一序号。
       IF cl_null(l_bmbc003) OR l_bmbc003 <> sr.bmbc003  OR l_bmbc010 <> sr.bmbc010 THEN
          LET l_bmbc003 = sr.bmbc003
          LET l_bmbc010 = sr.bmbc010
          LET g_cnt = g_cnt + 1
       END IF
            
       LET sr.l_no = g_cnt USING '&&&&&&'
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.l_no,sr.bmbc001,sr.l_imaal003_1,sr.l_imaal004_1,sr.bmbc002,sr.l_bmbc001_bmbc002,sr.bmbc003,sr.l_imaal003_2,sr.l_imaal004_2,sr.bmbc010,sr.bmbc011
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "abmr617_x01_execute"
          LET g_errparam.code   = SQLCA.sqlcode
          LET g_errparam.popup  = FALSE
          CALL cl_err()       
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF
 
       #add-point:ins_data段after_save name="ins_data.after.save"
       #仅打印差异资料：判断是否筛去了有相同资料的主件料号，若有，则给空资料显示
       IF tm.pr = 'Y' THEN
          FOREACH abmr617_x01_bmbc001_curs USING sr.bmbc001,sr.bmbc001,sr.bmbc002 INTO l_bmbc001,l_bmbc002
             IF STATUS THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = 'foreach bmbc001_curs:'
                LET g_errparam.code   = STATUS
                LET g_errparam.popup  = TRUE
                CALL cl_err()
                LET g_rep_success = 'N'
                EXIT FOREACH
             END IF
             LET l_count = 0
             SELECT COUNT(*) INTO l_count
               FROM abmr617_tmp01   #160727-00019#7   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 abmr617_bmbc_tmp ——> abmr617_tmp01
              WHERE bmbc001 = l_bmbc001
                AND bmbc002 = l_bmbc002
                AND bmbc003 = sr.bmbc003
             IF l_count = 0 THEN
                LET l_key = l_bmbc001,"(",l_bmbc002 CLIPPED,")"
                CALL s_desc_get_item_desc(l_bmbc001) RETURNING l_bmbc001_desc1,l_bmbc001_desc2
                EXECUTE insert_prep USING sr.l_no,l_bmbc001,l_bmbc001_desc1,l_bmbc001_desc2,sr.bmbc002,l_key,sr.bmbc003,sr.l_imaal003_2,sr.l_imaal004_2,sr.bmbc010,l_bmbc011
             END IF
          END FOREACH
       END IF
       #end add-point
       
    END FOREACH
    
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="abmr617_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION abmr617_x01_rep_data()
#add-point:rep_data.define (客製用) name="rep_data.define_customerization"

#end add-point:rep_data.define
#add-point:rep_data.define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="rep_data.define"
DEFINE l_rep_name    LIKE type_t.chr200
#end add-point:rep_data.define
 
    #add-point:rep_data.before name="rep_data.before"
    CASE tm.chk
       WHEN '1'      #abmr617
         SELECT gzzal003 INTO l_rep_name
           FROM gzzal_t
          WHERE gzzal001 = 'abmr617'
            AND gzzal002 = g_dlang
       WHEN '2'      #abmr618
         SELECT gzzal003 INTO l_rep_name
           FROM gzzal_t
          WHERE gzzal001 = 'abmr618'
            AND gzzal002 = g_dlang
    END CASE
    LET g_rep_code_desc = l_rep_name
    #end add-point:rep_data.before
    
    CALL cl_xg_view()
    #add-point:rep_data.after name="rep_data.after"
    
    #end add-point:rep_data.after
END FUNCTION
 
{</section>}
 
{<section id="abmr617_x01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 拆解tm.wc，获取单身日期
# Memo...........:
# Usage..........: CALL abmr617_x01_getwc(wc)
#                  RETURNING r_wc,r_date,r_qbe
################################################################################
PRIVATE FUNCTION abmr617_x01_getwc(wc)
DEFINE wc   STRING
DEFINE r_wc       DYNAMIC ARRAY OF type_wc 
DEFINE r_date     DYNAMIC ARRAY OF type_date
DEFINE r_qbe      STRING                  #画面qbe条件
DEFINE l_cnt      LIKE type_t.num5
DEFINE l_start    LIKE type_t.num5
DEFINE l_end      LIKE type_t.num5
DEFINE l_start2   LIKE type_t.num5
DEFINE l_end2     LIKE type_t.num5
DEFINE l_start3   LIKE type_t.num5
DEFINE l_end3     LIKE type_t.num5
DEFINE l_start4   LIKE type_t.num5
DEFINE l_end4     LIKE type_t.num5
DEFINE l_len      LIKE type_t.num5
DEFINE l_qbe_len  LIKE type_t.num5

LET l_start = 1   #wc
LET l_end = 1
LET l_start2 = 1  #date
LET l_end2 = 1
LET l_start3 = 1  #bmbc001
LET l_end3 = 1
LET l_start4 = 1  #bmbc002
LET l_end4 = 1
LET l_len = wc.getLength()    #wc的长度
LET l_qbe_len = wc.getIndexOf(" AND ( ",1)
LET r_qbe = wc.subString(1,l_qbe_len)

FOR l_cnt = 1 TO l_len
#   LET l_start = wc.getIndexOf("bmbc001 = '",l_start)            #2015-11-30 zhujing marked
   LET l_start = wc.getIndexOf("bmaa001 = '",l_start)             #2015-11-30 zhujing mod
   LET l_end = wc.getIndexOf('OR ( ',l_start) - 1
   LET l_start2 = wc.getIndexOf("<= '",l_start2) + 4
   LET l_end2 = wc.getIndexOf("' )",l_start2)-1
#   LET l_start3 = wc.getIndexOf("bmbc001 = '",l_start3) + 11     #2015-11-30 zhujing marked
   LET l_start3 = wc.getIndexOf("bmaa001 = '",l_start3) + 11      #2015-11-30 zhujing mod
#   LET l_end3 = wc.getIndexOf("' AND bmbc002",l_start3) - 1      #2015-11-30 zhujing marked
   LET l_end3 = wc.getIndexOf("' AND bmaa002",l_start3) - 1       #2015-11-30 zhujing mod
#   LET l_start4 = wc.getIndexOf("bmbc002 = '",l_start4) + 11     #2015-11-30 zhujing marked
   LET l_start4 = wc.getIndexOf("bmaa002 = '",l_start4) + 11      #2015-11-30 zhujing mod
#   LET l_end4 = wc.getIndexOf(" AND (to_char(bmbc005",l_start4) - 3 #2015-11-30 zhujing marked
   LET l_end4 = wc.getIndexOf(" AND (to_char(bmba005",l_start4) - 3  #2015-11-30 zhujing mod
   
   IF (l_end = 0 OR l_end = -1) THEN 
      IF (l_end <> l_len) THEN
         LET r_wc[l_cnt].wc = wc.subString (l_start,l_len)
         LET r_date[l_cnt].date = wc.subString (l_start2,l_end2)
         LET r_date[l_cnt].bmbc001 = wc.subString (l_start3,l_end3)
         LET r_date[l_cnt].bmbc002 = wc.subString (l_start4,l_end4)
      END IF
      EXIT FOR 
   END IF
   LET r_wc[l_cnt].wc = wc.subString (l_start,l_end)
   LET r_date[l_cnt].date = wc.subString (l_start2,l_end2)
   LET r_date[l_cnt].bmbc001 = wc.subString (l_start3,l_end3)
   LET r_date[l_cnt].bmbc002 = wc.subString (l_start4,l_end4)
   LET l_start = l_end + 3
   IF (l_start > l_len)  THEN
      EXIT FOR
   END IF
END FOR

RETURN r_wc,r_date,r_qbe
END FUNCTION

################################################################################
# Descriptions...: 抓取全部资料存入暂存档
# Memo...........:
# Usage..........: CALL abmr617_x01_ins_tmp()
################################################################################
PRIVATE FUNCTION abmr617_x01_ins_tmp()
#临时表字段
DEFINE sr1 RECORD 
   bmbc001  LIKE bmbc_t.bmbc001, 
   bmbc002  LIKE bmbc_t.bmbc002, 
   bmbc003  LIKE bmbc_t.bmbc003,
   bmbc010  LIKE bmbc_t.bmbc010,
   bmbc005  LIKE bmbc_t.bmbc005,
   bmbc011  LIKE bmbc_t.bmbc011,
   bmbcent  LIKE bmbc_t.bmbcent, 
   bmbcsite LIKE bmbc_t.bmbcsite,
   l_type   LIKE type_t.num10,      #树编号
   l_pid    LIKE type_t.num10,      #父结点ID
   l_id     LIKE type_t.num10       #结点ID 
END RECORD

DEFINE l_type  LIKE type_t.num10
DEFINE l_pid   LIKE type_t.num10
DEFINE l_no    LIKE type_t.num10
DEFINE l_len   LIKE type_t.num5
DEFINE l_tmp   LIKE type_t.chr100
DEFINE l_success LIKE type_t.chr1

DEFINE l_bmbc011_sql    STRING
DEFINE l_sub_sql        STRING
DEFINE l_cnt            LIKE type_t.num10    #记录尾阶时的插件位置及用量
#抓取元件资料
    LET g_rep_success = 'Y'
    LET l_type = 1
    LET g_tmp_id = 1
 
    FOREACH abmr617_x01_tmp_curs INTO sr1.*
       IF STATUS THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = 'foreach:'
          LET g_errparam.code   = STATUS
          LET g_errparam.popup  = TRUE
          CALL cl_err()
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF
#       LET sr1.bmbc003 = sr1.bmbc001
       LET sr1.l_type = l_type   #给定BOM树编号
       LET sr1.l_pid = 0      #总是父结点
       LET sr1.l_id = g_tmp_id    #按顺序编号
       #将值插入表中
       IF tm.level = '1' THEN
          EXECUTE insert_prep1 USING sr1.bmbc001,sr1.bmbc002,sr1.bmbc003,sr1.bmbc010,sr1.bmbc005,sr1.bmbc011,sr1.bmbcent,sr1.bmbcsite,sr1.l_type,sr1.l_pid,sr1.l_id
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.extend = "abmr617_x01_tmp_execute"
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.popup  = FALSE
             CALL cl_err()       
             LET g_rep_success = 'N'
             EXIT FOREACH
          END IF
       END IF
       #单阶：只抓取第一笔，不再展BOM
       #尾阶：抓至最后一笔，只输出最后一笔（无子结点）     
       IF tm.level = '2' THEN
          FOR l_no = 1 TO l_date.getlength()
             IF l_date[l_no].bmbc001 = sr1.bmbc001 AND l_date[l_no].bmbc002 = sr1.bmbc002 THEN
                LET l_tmp = l_date[l_no].date
                EXIT FOR
             END IF
          END FOR
          CALL abmr617_x01_tmp_bom(sr1.l_type,sr1.l_pid,sr1.l_id,sr1.bmbc001,sr1.bmbc002,sr1.bmbc003,sr1.bmbcent,sr1.bmbcsite,l_tmp) 
          RETURNING l_len,l_success
          IF l_success = 'N' THEN
             #160629-00002#11 marked-S
            #LET l_bmbc011_sql = " SELECT bmbc010,bmbc011 ",             #160331-00005#1 mark
#             LET l_bmbc011_sql = " SELECT DISTINCT bmbc010,bmbc011 ",    #160331-00005#1 add             
#                                 "  FROM bmbc_t ",
#                                 " INNER JOIN bmba_t ON bmbaent = bmbcent AND bmbasite = bmbcsite AND bmba001 = bmbc001 AND bmba002 = bmbc002 AND bmba003 = bmbc003 AND bmba004 = bmbc004 AND bmba005 = bmbc005 AND bmba007 = bmbc007 AND bmba008 = bmbc008",            #160331-00005#1 add                                 
#                                 " WHERE bmbc001 = '",sr1.bmbc001,"' ",
#                                 "   AND bmbc002 = '",sr1.bmbc002,"' ",
#                                 "   AND bmbc003 = '",sr1.bmbc003,"' ",
#                                 "   AND bmbcent = '",sr1.bmbcent,"' ",
#                                 "   AND bmbcsite = '",sr1.bmbcsite,"' ",
#                                 "   AND to_char(bmbc005,'yyyy-mm-dd hh24:mi:ss') <= '",l_tmp,"' "
#             LET l_sub_sql = "SELECT COUNT(1) FROM (",l_bmbc011_sql,")"
#             PREPARE bmbc011_cnt_pre FROM l_sub_sql
#             EXECUTE bmbc011_cnt_pre INTO l_cnt
             #160629-00002#11 marked-E
             EXECUTE bmbc011_cnt_pre USING sr1.bmbc001,sr1.bmbc002,sr1.bmbc003,sr1.bmbcent,sr1.bmbcsite,l_tmp INTO l_cnt    #160629-00002#11 mod
             IF l_cnt > 0 THEN 
                #160629-00002#11 marked-S
#                DECLARE bmbc011_curs CURSOR FROM l_bmbc011_sql
#                FOREACH bmbc011_curs INTO sr1.bmbc010,sr1.bmbc011
                #160629-00002#11 marked-E
                FOREACH bmbc011_curs USING sr1.bmbc001,sr1.bmbc002,sr1.bmbc003,sr1.bmbcent,sr1.bmbcsite,l_tmp INTO sr1.bmbc010,sr1.bmbc011   #160629-00002#11 mod
                   EXECUTE insert_prep1 USING sr1.bmbc001,sr1.bmbc002,sr1.bmbc003,sr1.bmbc010,sr1.bmbc005,sr1.bmbc011,sr1.bmbcent,sr1.bmbcsite,sr1.l_type,sr1.l_pid,sr1.l_id
                   IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.extend = "abmr617_x01_tmp_execute"
                      LET g_errparam.code   = SQLCA.sqlcode
                      LET g_errparam.popup  = FALSE
                      CALL cl_err()       
                      LET g_rep_success = 'N'
                      EXIT FOREACH
                   END IF
                END FOREACH
             END IF
          END IF
       END IF
       
       LET l_type = l_type + 1   #树编号+1，开启新树！
    END FOREACH
    
END FUNCTION

################################################################################
# Descriptions...: 展开暂存档资料，获取尾阶
# Memo...........:
# Usage..........: CALL abmr617_x01_tmp_bom(p_type,p_pid,p_id,p_bmbc001,p_bmbc002,p_bmbc003,p_bmbcent,p_bmbcsite,p_vdate)
# 参数说明........: p_type       树编号
# 参数说明........: p_pid        父结点
# 参数说明........: p_id         结点编号
# 参数说明........: p_bmbc001    主件料号
# 参数说明........: p_bmbc002    特性
# 参数说明........: p_bmbc003    元件料号
# 参数说明........: p_bmbcent    企业编号
# 参数说明........: p_vdate      有效日期
################################################################################
PRIVATE FUNCTION abmr617_x01_tmp_bom(p_type,p_pid,p_id,p_bmbc001,p_bmbc002,p_bmbc003,p_bmbcent,p_bmbcsite,p_vdate)
   DEFINE p_bmbcent  LIKE bmbc_t.bmbcent
   DEFINE p_bmbcsite LIKE bmbc_t.bmbcsite
   DEFINE p_bmbc001  LIKE bmbc_t.bmbc001
   DEFINE p_bmbc002  LIKE bmbc_t.bmbc002
   DEFINE p_bmbc003  LIKE bmbc_t.bmbc003
   DEFINE p_type     LIKE type_t.num20
   DEFINE p_pid      LIKE type_t.num20
   DEFINE p_id       LIKE type_t.num20
   DEFINE p_vdate    LIKE type_t.chr100  #有效日期
   DEFINE r_bmbclen  LIKE type_t.num5
   DEFINE r_success  LIKE type_t.chr2
   
   DEFINE l_bmbc     DYNAMIC ARRAY OF RECORD 
      bmbc001  LIKE bmbc_t.bmbc001, 
      bmbc002  LIKE bmbc_t.bmbc002,
      bmbc003  LIKE bmbc_t.bmbc003, 
      bmbc010  LIKE bmbc_t.bmbc010, 
      bmbc005  LIKE bmbc_t.bmbc005,
      bmbc011  LIKE bmbc_t.bmbc011, 
      bmbcent  LIKE bmbc_t.bmbcent,
      bmbcsite LIKE bmbc_t.bmbcsite,
      l_type   LIKE type_t.num10, 
      l_pid    LIKE type_t.num10, 
      l_id     LIKE type_t.num10
   END RECORD
   
   DEFINE l_sql      STRING
   DEFINE l_datetype STRING
   DEFINE l_ac       LIKE type_t.num5
   DEFINE l_bmbclen  LIKE type_t.num5
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_sub_sql       STRING   
   DEFINE l_bmbc010_sql   STRING
   
   DEFINE l_suc1          LIKE type_t.chr2
   
   CALL l_bmbc.clear()
   #抓取環境變數
   IF FGL_GETENV("DBDATE") ='Y2MD/' THEN
      LET l_datetype = 'yy/mm/dd'
   ELSE
      LET l_datetype = 'yyyy/mm/dd'
   END IF
   #2015-11-30 zhujing marked 直接使用bmaa_t的来展开树------（S）
#   LET l_sql = " SELECT bmbc001,bmbc002,bmbc003,NULL,bmbc005,NULL,bmbcent,bmbcsite,'",p_type,"','",p_id,"',0 ",
#               "   FROM bmbc_t ",
#               "  WHERE bmbcent = '",p_bmbcent,"'",
#               "    AND bmbcsite = '",p_bmbcsite,"'",
#               "    AND bmbc001 = '",p_bmbc003,"'",
#               "    AND bmbc002 = '",p_bmbc002,"'",
#               "    AND to_char(bmbc005,'yyyy-mm-dd hh24:mi:ss') <= '",p_vdate,"'",
#               "    AND ",g_qbe CLIPPED,
#               "  ORDER BY bmbc003"
   #2015-11-30 zhujing marked 直接使用bmaa_t的来展开树------（E）               
   #160629-00002#11 marked-S           
#   #2015-11-30 zhujing mod 直接使用bmaa_t的来展开树---------（S）
#   LET l_sql = " SELECT DISTINCT bmba001,bmba002,bmba003,NULL,bmba005,NULL,bmbaent,bmbasite,'",p_type,"','",p_id,"',0 ",
#               "   FROM bmaa_t LEFT OUTER JOIN bmba_t ON bmba001 = bmaa001 AND bmba002 = bmaa002 AND bmbaent = bmaaent AND bmbasite = bmaasite ",
#               "   LEFT OUTER JOIN bmbc_t ON bmbc001 = bmba001 AND bmbc002 = bmba002 AND bmbc003 = bmba003 AND bmbc004 = bmba004 ",
#               "   AND bmbc005 = bmba005 AND bmbc007 = bmba007 AND bmbc008 = bmba008 AND bmbcent = bmbaent AND bmbcsite = bmbasite ",
#               "  WHERE bmaaent = '",p_bmbcent,"'",
#               "    AND bmaasite = '",p_bmbcsite,"'",
#               "    AND bmba001 = '",p_bmbc003,"'",
#               "    AND bmba002 = '",p_bmbc002,"'",
#               "    AND to_char(bmba005,'yyyy-mm-dd hh24:mi:ss') <= '",p_vdate,"'",
#               "    AND (to_char(bmba006,'yyyy-mm-dd hh24:mi:ss') > '",p_vdate,"'"," OR to_char(bmba006,'yyyy-mm-dd hh24:mi:ss') IS NULL )",   #160331-00005#1 add                 
#              #"    AND to_char(bmba006,'yyyy-mm-dd hh24:mi:ss') <= '",p_vdate,"'", #2016-2-1 zhujing add 失效日期                              #160331-00005#1 mark           
#               "    AND ",g_qbe CLIPPED,
#               "  ORDER BY bmba003"            
#   #2015-11-30 zhujing mod 直接使用bmaa_t的来展开树---------（E）
#   LET l_cnt = 0
#   LET l_sub_sql = ""
#   LET r_success  = 'N'
#   LET l_sub_sql = "SELECT COUNT(1) FROM (",l_sql,")"
#   PREPARE abmr617_x01_tmp_bom_cnt_pre FROM l_sub_sql
#   EXECUTE abmr617_x01_tmp_bom_cnt_pre INTO l_cnt
   #160629-00002#11 marked-E  
   #160629-00002#11 add-S  
   LET l_cnt = 0
   LET l_sub_sql = ""
   LET r_success  = 'N'   
   EXECUTE abmr617_x01_tmp_bom_cnt_pre USING p_type,p_id,p_bmbcent,p_bmbcsite,p_bmbc003,p_bmbc002,p_vdate,p_vdate INTO l_cnt
   #160629-00002#11 add-E
   IF l_cnt > 0 THEN 
      LET r_success  ="Y"       #有子结点
   END IF
   LET l_suc1 = 'N'
   #单阶：只抓取第一笔，不再展BOM
   #尾阶：抓至最后一笔，只输出最后一笔（无子结点）
   #160629-00002#11 marked-S           
#   PREPARE abmr617_x01_prepare_tmp_bom FROM l_sql
#   DECLARE abmr617_x01_tmp_bom CURSOR FOR abmr617_x01_prepare_tmp_bom
#   LET l_ac = l_ac + 1
#   
#   FOREACH abmr617_x01_tmp_bom INTO l_bmbc[l_ac].bmbc001,l_bmbc[l_ac].bmbc002,l_bmbc[l_ac].bmbc003,l_bmbc[l_ac].bmbc010,
#                                    l_bmbc[l_ac].bmbc005,l_bmbc[l_ac].bmbc011,l_bmbc[l_ac].bmbcent,l_bmbc[l_ac].bmbcsite,
#                                    l_bmbc[l_ac].l_type, l_bmbc[l_ac].l_pid,  l_bmbc[l_ac].l_id
   #160629-00002#11 marked-E        
   #160629-00002#11 add-S           
   LET l_ac = l_ac + 1
   
   FOREACH abmr617_x01_tmp_bom USING p_type,p_id,p_bmbcent,p_bmbcsite,p_bmbc003,p_bmbc002,p_vdate,p_vdate
                               INTO l_bmbc[l_ac].bmbc001,l_bmbc[l_ac].bmbc002,l_bmbc[l_ac].bmbc003,l_bmbc[l_ac].bmbc010,
                                    l_bmbc[l_ac].bmbc005,l_bmbc[l_ac].bmbc011,l_bmbc[l_ac].bmbcent,l_bmbc[l_ac].bmbcsite,
                                    l_bmbc[l_ac].l_type, l_bmbc[l_ac].l_pid,  l_bmbc[l_ac].l_id
   #160629-00002#11 add-E        
      IF STATUS THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'abmr617_x01_tmp_bom foreach:'
         LET g_errparam.code   = STATUS
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET g_rep_success = 'N'
         EXIT FOREACH
      END IF
#      LET l_bmbc[l_ac].bmbc003 = l_bmbc[l_ac].bmbc001
      LET l_bmbc[l_ac].bmbc001 = p_bmbc001
      LET l_bmbc[l_ac].l_id = g_tmp_id + 1
      LET g_tmp_id = l_bmbc[l_ac].l_id       #临时表结点编号
      
      LET l_ac = l_ac + 1
   END FOREACH
   LET l_ac = l_ac - 1 
   
 
   LET r_bmbclen = l_ac
   
   #輸出
   FOR l_ac = 1 TO r_bmbclen
      IF NOT cl_null(l_bmbc[l_ac].bmbc003) THEN
         CALL abmr617_x01_tmp_bom(l_bmbc[l_ac].l_type,l_bmbc[l_ac].l_pid,l_bmbc[l_ac].l_id,p_bmbc001,l_bmbc[l_ac].bmbc002,l_bmbc[l_ac].bmbc003,p_bmbcent,p_bmbcsite,p_vdate)
         RETURNING l_bmbclen,l_suc1
      
         IF (l_suc1 = 'N' AND tm.level = '2') THEN #尾阶，且无子结点
            #160629-00002#11 marked-S           
           #LET l_bmbc010_sql = " SELECT bmbc010,bmbc011 ",             #160331-00005#1 mark
#            LET l_bmbc010_sql = " SELECT DISTINCT bmbc010,bmbc011 ",    #160331-00005#1 add            
#                                 "  FROM bmbc_t ",
#                                 " INNER JOIN bmba_t ON bmbaent = bmbcent AND bmbasite = bmbcsite AND bmba001 = bmbc001 AND bmba002 = bmbc002 AND bmba003 = bmbc003 AND bmba004 = bmbc004 AND bmba005 = bmbc005 AND bmba007 = bmbc007 AND bmba008 = bmbc008",            #160331-00005#1 add                                  
#                                 " WHERE bmbc001 = '",p_bmbc003,"' ",
#                                 "   AND bmbc002 = '",l_bmbc[l_ac].bmbc002,"' ",
#                                 "   AND bmbc003 = '",l_bmbc[l_ac].bmbc003,"' ",
#                                 "   AND bmbcent = '",l_bmbc[l_ac].bmbcent,"' ",
#                                 "   AND bmbcsite = '",l_bmbc[l_ac].bmbcsite,"' ",
#                                 "   AND to_char(bmbc005,'yyyy-mm-dd hh24:mi:ss') <= '",p_vdate,"' "
#             LET l_sub_sql = "SELECT COUNT(1) FROM (",l_bmbc010_sql,")"
#             PREPARE bmbc010_cnt_pre FROM l_sub_sql
#             EXECUTE bmbc010_cnt_pre INTO l_cnt
            #160629-00002#11 marked-E          
            #160629-00002#11 add-S  
            LET l_cnt = 0
            LET l_sub_sql = ""
            LET r_success  = 'N'   
            EXECUTE bmbc010_cnt_pre USING p_bmbc003,l_bmbc[l_ac].bmbc002,l_bmbc[l_ac].bmbc003,l_bmbc[l_ac].bmbcent,l_bmbc[l_ac].bmbcsite,p_vdate INTO l_cnt
            #160629-00002#11 add-E
             IF l_cnt > 0 THEN 
               #160629-00002#11 marked-S        
#                DECLARE bmbc010_curs CURSOR FROM l_bmbc010_sql
#                FOREACH bmbc010_curs INTO l_bmbc[l_ac].bmbc010,l_bmbc[l_ac].bmbc011
               #160629-00002#11 marked-S        
               #160629-00002#11 add-S 
               FOREACH bmbc010_curs USING p_bmbc003,l_bmbc[l_ac].bmbc002,l_bmbc[l_ac].bmbc003,l_bmbc[l_ac].bmbcent,l_bmbc[l_ac].bmbcsite,p_vdate INTO l_bmbc[l_ac].bmbc010,l_bmbc[l_ac].bmbc011               
               #160629-00002#11 add-E  
                   EXECUTE insert_prep1 USING p_bmbc001,l_bmbc[l_ac].bmbc002,l_bmbc[l_ac].bmbc003,l_bmbc[l_ac].bmbc010,l_bmbc[l_ac].bmbc005,l_bmbc[l_ac].bmbc011,
                                       l_bmbc[l_ac].bmbcent,l_bmbc[l_ac].bmbcsite,l_bmbc[l_ac].l_type,l_bmbc[l_ac].l_pid,l_bmbc[l_ac].l_id
               END FOREACH
            END IF            
         END IF
      END IF
   END FOR

   RETURN r_bmbclen,r_success 
END FUNCTION

 
{</section>}
 
