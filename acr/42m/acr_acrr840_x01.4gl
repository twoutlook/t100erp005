#該程式未解開Section, 採用最新樣板產出!
{<section id="acrr840_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2016-05-24 18:13:20), PR版次:0001(2016-06-03 18:03:54)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000025
#+ Filename...: acrr840_x01
#+ Description: ...
#+ Creator....: 08172(2016-04-28 16:00:24)
#+ Modifier...: 08172 -SD/PR- 08172
 
{</section>}
 
{<section id="acrr840_x01.global" readonly="Y" >}
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
       wc STRING,                  #where condition 
       wc2 STRING,                  #where condition2 
       strt LIKE type_t.dat,         #start date 
       ed LIKE type_t.dat,         #end date 
       sel LIKE type_t.chr1,         #type 
       num LIKE debs_t.debs011,         #number 
       chk LIKE type_t.chr1          #check
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="acrr840_x01.main" readonly="Y" >}
PUBLIC FUNCTION acrr840_x01(p_arg1,p_arg2,p_arg3,p_arg4,p_arg5,p_arg6,p_arg7)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 STRING                  #tm.wc2  where condition2 
DEFINE  p_arg3 LIKE type_t.dat         #tm.strt  start date 
DEFINE  p_arg4 LIKE type_t.dat         #tm.ed  end date 
DEFINE  p_arg5 LIKE type_t.chr1         #tm.sel  type 
DEFINE  p_arg6 LIKE debs_t.debs011         #tm.num  number 
DEFINE  p_arg7 LIKE type_t.chr1         #tm.chk  check
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.wc2 = p_arg2
   LET tm.strt = p_arg3
   LET tm.ed = p_arg4
   LET tm.sel = p_arg5
   LET tm.num = p_arg6
   LET tm.chk = p_arg7
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "acrr840_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL acrr840_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL acrr840_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL acrr840_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL acrr840_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL acrr840_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="acrr840_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION acrr840_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "debs005.debs_t.debs005,l_rtaxl003.rtaxl_t.rtaxl003,debs016.debs_t.debs016,debs017.debs_t.debs017,debs011.debs_t.debs011,debs019.debs_t.debs019,l_imaa009_1.imaa_t.imaa009,l_rtaxl003_1.rtaxl_t.rtaxl003,l_relevance_1.type_t.num20_6,l_imaa009_2.imaa_t.imaa009,l_rtaxl003_2.rtaxl_t.rtaxl003,l_relevance_2.type_t.num20_6,l_imaa009_3.imaa_t.imaa009,l_rtaxl003_3.rtaxl_t.rtaxl003,l_relevance_3.type_t.num20_6" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   CREATE TEMP TABLE rtjb_temp(
       a1  VARCHAR(10),               #主品类
       a2  VARCHAR(10),               #关联品类
       a3  DECIMAL(20,6),               #关联度
       a4  VARCHAR(20)     #销售单号
       )
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="acrr840_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION acrr840_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?)"
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
 
{<section id="acrr840_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION acrr840_x01_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define(客製用) name="sel_prep.define_customerization"

#end add-point
#add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
DEFINE l_where   STRING
#end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
 
   #add-point:sel_prep g_select name="sel_prep.g_select"
   
   #end add-point
   LET g_select = " SELECT debs005,'',debs016,debs017,debs011,debs019,'','','','','','','','',''"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   
   #end add-point
    LET g_from = " FROM debs_t,imaa_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("debs_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
#   IF cl_null(tm.num) THEN
#      LET tm.num=10
#   END IF
   
   LET l_where = ''
   IF tm.chk='Y' THEN
      IF  NOT cl_null(tm.strt) THEN
         LET l_where = " AND debx002 >='",tm.strt,"'"
      ELSE
         LET l_where =" AND 1=1"
      END IF
      IF NOT cl_null(tm.ed) THEN
         LET l_where = l_where," AND debx002 <='",tm.ed,"'"
      ELSE
         LET l_where = l_where," AND 1=1"
      END IF
      #抓取会员主品类
      LET g_sql = " SELECT DISTINCT debx005,rtaxl003,SUM(debx017) a,SUM(debx018) b,SUM(debx012) c,SUM(debx012)/(CASE WHEN SUM(debx021)=0 THEN 1 ELSE SUM(debx021) END ) d",
                 "    FROM debx_t",
              "  LEFT JOIN rtaxl_t ON rtaxlent='",g_enterprise,"' AND rtaxl001=debx005 AND rtaxl002='",g_dlang,"'",
               " LEFT JOIN rtab_t ON debxent=rtabent AND debxsite=rtab002",
#                 "   WHERE debxsite=rtab002",
                 "   WHERE ",tm.wc CLIPPED,l_where,
                " GROUP BY debx005,rtaxl003"
      CASE tm.sel
         WHEN '1' LET g_sql = g_sql," ORDER BY a DESC"
         WHEN '2' LET g_sql = g_sql," ORDER BY b DESC"
         WHEN '3' LET g_sql = g_sql," ORDER BY c DESC"
         WHEN '4' LET g_sql = g_sql," ORDER BY d DESC"
      END CASE
      LET g_sql=" SELECT debx005,rtaxl003,a,b,c,d,'','','','','','','','','' FROM(",g_sql,") ",
               " WHERE ROWNUM<=",tm.num
   ELSE
      #抓取非会员主品类
      IF NOT cl_null(tm.strt) THEN
         LET l_where = " AND debw002 >='",tm.strt,"'"
      ELSE
         LET l_where =" AND 1=1"
      END IF
      IF NOT cl_null(tm.ed) THEN
         LET l_where = l_where," AND debw002 <='",tm.ed,"'"
      ELSE
         LET l_where = l_where," AND 1=1"
      END IF
      LET g_sql = " SELECT debw005,rtaxl003,SUM(debw016) a,SUM(debw017) b,SUM(debw011) c,SUM(debw011)/(CASE WHEN SUM(debw019)=0 THEN 1 ELSE SUM(debw019) END) d",
                  "   FROM debw_t",
              "  LEFT JOIN rtaxl_t ON rtaxlent='",g_enterprise,"' AND rtaxl001=debw005 AND rtaxl002='",g_dlang,"'",
               " LEFT JOIN rtab_t ON debwent=rtabent AND debwsite=rtab002",
#                  "  WHERE debwsite=rtab002",
                  "  WHERE ",tm.wc CLIPPED,l_where,
                " GROUP BY debw005,rtaxl003"
      CASE tm.sel
         WHEN '1' LET g_sql = g_sql," ORDER BY a DESC"
         WHEN '2' LET g_sql = g_sql," ORDER BY b DESC"
         WHEN '3' LET g_sql = g_sql," ORDER BY c DESC"
         WHEN '4' LET g_sql = g_sql," ORDER BY d DESC"
      END CASE
      LET g_sql=" SELECT debw005,rtaxl003,a,b,c,d,'','','','','','','','','' FROM(",g_sql,") ",
               " WHERE ROWNUM<=",tm.num
   END IF
   
   #end add-point
   PREPARE acrr840_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE acrr840_x01_curs CURSOR FOR acrr840_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="acrr840_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION acrr840_x01_ins_data()
DEFINE sr RECORD 
   debs005 LIKE debs_t.debs005, 
   l_rtaxl003 LIKE rtaxl_t.rtaxl003, 
   debs016 LIKE debs_t.debs016, 
   debs017 LIKE debs_t.debs017, 
   debs011 LIKE debs_t.debs011, 
   debs019 LIKE debs_t.debs019, 
   l_imaa009_1 LIKE imaa_t.imaa009, 
   l_rtaxl003_1 LIKE rtaxl_t.rtaxl003, 
   l_relevance_1 LIKE type_t.num20_6, 
   l_imaa009_2 LIKE imaa_t.imaa009, 
   l_rtaxl003_2 LIKE rtaxl_t.rtaxl003, 
   l_relevance_2 LIKE type_t.num20_6, 
   l_imaa009_3 LIKE imaa_t.imaa009, 
   l_rtaxl003_3 LIKE rtaxl_t.rtaxl003, 
   l_relevance_3 LIKE type_t.num20_6
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_n  LIKE type_t.num20_6    #主品类数量
DEFINE l_n2 LIKE type_t.num20_6    #关联品类数量
DEFINE l_a1 LIKE imaa_t.imaa009    #主品类
DEFINE l_a2 LIKE imaa_t.imaa009    #关联品类
DEFINE l_a3 LIKE type_t.num20_6    #关联度
DEFINE l_str  STRING
DEFINE l_str1  STRING
DEFINE l_str2  STRING
DEFINE l_wc1  STRING
DEFINE l_wc2  STRING
DEFINE l_where1 STRING
DEFINE l_where2 STRING
DEFINE l_imaa009   LIKE imaa_t.imaa009
DEFINE l_rtaxl003  LIKE rtaxl_t.rtaxl003
DEFINE l_relevance LIKE type_t.num20_6
DEFINE l_i  LIKE type_t.num5
DEFINE l_sql   STRING
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH acrr840_x01_curs INTO sr.*                               
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
       DELETE FROM rtjb_temp
       IF cl_null(tm.wc2) THEN LET tm.wc2 = " 1=1" END IF
       LET l_where1 = ''
       LET l_where2 = ''
       LET l_wc1 = cl_replace_str(tm.wc2,'rtab001','g.rtab001')
       LET l_wc1 = cl_replace_str(tm.wc2,'rtjbsite','a.rtjbsite')
       LET l_wc2 = cl_replace_str(tm.wc2,'rtab001','h.rtab001')
       LET l_wc2 = cl_replace_str(tm.wc2,'rtjbsite','b.rtjbsite')
       
       IF NOT cl_null(tm.strt) THEN
             LET l_where1 = " e.rtjadocdt >='",tm.strt,"'"
          ELSE
             LET l_where1="1=1"
          END IF
          IF NOT cl_null(tm.ed) THEN
             LET l_where1 = l_where1," AND e.rtjadocdt <='",tm.ed,"'"
          ELSE
             LET l_where1 = l_where1," AND 1=1"
          END IF
          IF NOT cl_null(tm.strt) THEN
             LET l_where2 = " f.rtjadocdt >='",tm.strt,"'"
          ELSE
             LET l_where2="1=1"
          END IF
          IF NOT cl_null(tm.ed) THEN
             LET l_where2 = l_where2," AND f.rtjadocdt <='",tm.ed,"'"
          ELSE
             LET l_where2 = l_where2," AND 1=1"
          END IF
       
       IF tm.chk='Y' THEN
          
          #抓取会员的关联品类
          LET l_str="INSERT INTO rtjb_temp(a1,a2,a4)",
                   " SELECT DISTINCT c.imaa009,d.imaa009,a.rtjbdocno ",
                     " FROM rtjb_t a LEFT JOIN rtja_t e ON e.rtjaent=a.rtjbent AND e.rtjadocno=a.rtjbdocno AND e.rtja001 IS NOT NULL AND ",l_where1,
                                   " LEFT JOIN rtab_t g ON g.rtabent=a.rtjbent AND g.rtab002=a.rtjbsite",
                         " ,rtjb_t b LEFT JOIN rtja_t f ON f.rtjaent=b.rtjbent AND f.rtjadocno=b.rtjbdocno AND f.rtja001 IS NOT NULL AND ",l_where2,
                                   " LEFT JOIN rtab_t h ON h.rtabent=b.rtjbent AND h.rtab002=b.rtjbsite",
                         " ,imaa_t c,imaa_t d",
                    " WHERE c.imaa001=a.rtjb004 AND d.imaa001=b.rtjb004",
                      " AND a.rtjbent='",g_enterprise,"' AND b.rtjbent='",g_enterprise,"'",
                      " AND c.imaaent='",g_enterprise,"' AND d.imaaent='",g_enterprise,"'",
                      " AND a.rtjbdocno=b.rtjbdocno AND ",l_wc1," AND ",l_wc2,
                      " AND d.imaa009<>c.imaa009",
                      " AND c.imaa009='",sr.debs005,"'"           
       ELSE
          #抓取非会员的关联品类
          LET l_str="INSERT INTO rtjb_temp(a1,a2,a4)",
                   " SELECT DISTINCT c.imaa009,d.imaa009,a.rtjbdocno",
                     " FROM rtjb_t a LEFT JOIN rtja_t e ON e.rtjaent=a.rtjbent AND e.rtjadocno=a.rtjbdocno AND e.rtja001='' AND ",l_where1,
                                   " LEFT JOIN rtab_t g ON g.rtabent=a.rtjbent AND g.rtab002=a.rtjbsite",
                          " ,rtjb_t b LEFT JOIN rtja_t f ON f.rtjaent=b.rtjbent AND f.rtjadocno=b.rtjbdocno AND f.rtja001='' AND ",l_where2,
                                   " LEFT JOIN rtab_t h ON h.rtabent=b.rtjbent AND h.rtab002=b.rtjbsite",
                          " ,imaa_t c,imaa_t d",
                    " WHERE c.imaa001=a.rtjb004 AND d.imaa001=b.rtjb004",
                      " AND a.rtjbent='",g_enterprise,"'",
                      " AND b.rtjbent='",g_enterprise,"'",
                      " AND c.imaaent='",g_enterprise,"'",
                      " AND d.imaaent='",g_enterprise,"'",
                      " AND a.rtjbdocno=b.rtjbdocno AND ",l_wc1," AND ",l_wc2,
                      " AND d.imaa009<>c.imaa009",
                      " AND c.imaa009='",sr.debs005,"'"
       END IF
       PREPARE acrr840_x01_prepare3 FROM l_str
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = "rtjb_temp:" 
          LET g_errparam.code   = SQLCA.sqlcode 
          LET g_errparam.popup  = TRUE 
          CALL cl_err()
          RETURN
       END IF
       EXECUTE acrr840_x01_prepare3
       #计算主品类数量
       LET l_str1=" SELECT a1,COUNT(a1) FROM rtjb_temp GROUP BY a1"
       PREPARE acrr840_x01_prepare1 FROM l_str1
       DECLARE acrr840_x01_curs1 CURSOR FOR acrr840_x01_prepare1
       OPEN  acrr840_x01_curs1      
       FOREACH acrr840_x01_curs1 INTO l_a1,l_n
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL 
             LET g_errparam.extend = "acrr840_x01_curs1:" 
             LET g_errparam.code   = SQLCA.sqlcode 
             LET g_errparam.popup  = TRUE 
             CALL cl_err()
             EXIT FOREACH
          END IF
          #根据主品类计算关联品类数量
          LET l_str2="SELECT a2,COUNT(a2) FROM rtjb_temp WHERE a1='",l_a1,"' GROUP BY a1,a2"
          PREPARE acrr840_x01_prepare2 FROM l_str2
          DECLARE acrr840_x01_curs2 CURSOR FOR acrr840_x01_prepare2
          OPEN acrr840_x01_curs2
          FOREACH acrr840_x01_curs2 INTO l_a2,l_n2
             IF SQLCA.sqlcode THEN
                INITIALIZE g_errparam TO NULL 
                LET g_errparam.extend = "acrr840_x01_curs2:"
                LET g_errparam.code   = SQLCA.sqlcode 
                LET g_errparam.popup  = TRUE 
                CALL cl_err()
                EXIT FOREACH
             END IF
             #计算关联度
             LET l_a3=l_n2/l_n
             UPDATE rtjb_temp SET a3=l_a3 WHERE a1=l_a1 AND a2=l_a2
             
          END FOREACH
          LET l_i=0
          LET l_imaa009=''
          LET l_rtaxl003=''
          LET l_relevance=0
          #根据关联度排序，抓取前三笔关联品类
          LET l_sql="SELECT a2,rtaxl003,a3 ",  
                     " FROM(SELECT DISTINCT a2,rtaxl003,a3 ",
                   "          FROM rtjb_temp",
                   "          LEFT JOIN rtaxl_t ON rtaxlent='",g_enterprise,"' AND rtaxl001=a2 AND rtaxl002='",g_dlang,"'",
                   "         WHERE a1='",l_a1,"'",
                  "          ORDER BY a3 DESC,a2)",
                  "    WHERE ROWNUM<=3"
           PREPARE acrr840_x01_prepare4 FROM l_sql
           DECLARE acrr840_x01_curs4 CURSOR FOR acrr840_x01_prepare4
           OPEN acrr840_x01_curs4
           FOREACH acrr840_x01_curs4 INTO l_imaa009,l_rtaxl003,l_relevance
             IF SQLCA.sqlcode THEN
                INITIALIZE g_errparam TO NULL 
                LET g_errparam.extend = "acrr840_x01_curs2:"
                LET g_errparam.code   = SQLCA.sqlcode 
                LET g_errparam.popup  = TRUE 
                CALL cl_err()
                EXIT FOREACH
             END IF
             LET l_i=l_i+1
             CASE l_i
                WHEN 1
                   LET sr.l_imaa009_1=l_imaa009
                   LET sr.l_rtaxl003_1=l_rtaxl003
                   LET sr.l_relevance_1=l_relevance
                WHEN 2
                   LET sr.l_imaa009_2=l_imaa009
                   LET sr.l_rtaxl003_2=l_rtaxl003
                   LET sr.l_relevance_2=l_relevance 
                WHEN 3
                   LET sr.l_imaa009_3=l_imaa009
                   LET sr.l_rtaxl003_3=l_rtaxl003
                   LET sr.l_relevance_3=l_relevance
             END CASE
          END FOREACH
#          SELECT a2,rtaxl003,a3 INTO sr.l_imaa009_2,sr.l_rtaxl003_2,sr.l_relevance_2 FROM(
#          SELECT a2,rtaxl003,a3 FROM(
#          SELECT a2,rtaxl003,a3 FROM rtjb_temp
#       LEFT JOIN rtaxl_t ON rtaxlent=g_enterprise AND rtaxl001=a2 AND rtaxl002=g_dlang
#           WHERE a1=l_a1
#        ORDER BY a3 DESC)
#        WHERE ROWNUM<=2
#        ORDER BY a3)
#        WHERE ROWNUM=1
#          
#          SELECT a2,rtaxl003,a3 INTO sr.l_imaa009_3,sr.l_rtaxl003_3,sr.l_relevance_3 
#            FROM(SELECT a2,rtaxl003,a3 
#                   FROM(SELECT a2,rtaxl003,a3 
#                          FROM rtjb_temp
#                          LEFT JOIN rtaxl_t ON rtaxlent=g_enterprise AND rtaxl001=a2 AND rtaxl002=g_dlang
#                         WHERE a1=l_a1
#                         ORDER BY a3 DESC)
#                   WHERE ROWNUM<=3
#                   ORDER BY a3)
#           WHERE ROWNUM=1
       
       END FOREACH
       CLOSE acrr840_x01_curs2
       CLOSE acrr840_x01_curs1
       CLOSE acrr840_x01_curs4       
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.debs005,sr.l_rtaxl003,sr.debs016,sr.debs017,sr.debs011,sr.debs019,sr.l_imaa009_1,sr.l_rtaxl003_1,sr.l_relevance_1,sr.l_imaa009_2,sr.l_rtaxl003_2,sr.l_relevance_2,sr.l_imaa009_3,sr.l_rtaxl003_3,sr.l_relevance_3
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "acrr840_x01_execute"
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
 
{<section id="acrr840_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION acrr840_x01_rep_data()
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
 
{<section id="acrr840_x01.other_function" readonly="Y" >}

 
{</section>}
 
