#該程式未解開Section, 採用最新樣板產出!
{<section id="acrr800_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2016-02-17 13:39:29), PR版次:0001(2016-03-10 15:28:41)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000026
#+ Filename...: acrr800_x01
#+ Description: ...
#+ Creator....: 04226(2016-02-16 09:46:33)
#+ Modifier...: 04226 -SD/PR- 04226
 
{</section>}
 
{<section id="acrr800_x01.global" readonly="Y" >}
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
       wc STRING,                  #條件 
       argv1 LIKE type_t.chr10,         #作業參數 
       type LIKE type_t.chr1          #其他條件
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="acrr800_x01.main" readonly="Y" >}
PUBLIC FUNCTION acrr800_x01(p_arg1,p_arg2,p_arg3)
DEFINE  p_arg1 STRING                  #tm.wc  條件 
DEFINE  p_arg2 LIKE type_t.chr10         #tm.argv1  作業參數 
DEFINE  p_arg3 LIKE type_t.chr1         #tm.type  其他條件
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.argv1 = p_arg2
   LET tm.type = p_arg3
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "acrr800_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL acrr800_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL acrr800_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL acrr800_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL acrr800_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL acrr800_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="acrr800_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION acrr800_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "l_rtjasite_desc.type_t.chr1000,l_rtab001_desc.type_t.chr1000,rtja034.rtja_t.rtja034,l_sum.type_t.num26_10,l_time.type_t.chr30" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="acrr800_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION acrr800_x01_ins_prep()
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
         
         #end add-point                  
 
 
      END CASE
   END FOR
END FUNCTION
 
{</section>}
 
{<section id="acrr800_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION acrr800_x01_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define(客製用) name="sel_prep.define_customerization"

#end add-point
#add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
DEFINE l_sql         STRING
#end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
 
   #add-point:sel_prep g_select name="sel_prep.g_select"
   DELETE FROM acrr800_tmp
   
   LET l_sql = " INSERT INTO acrr800_tmp(rtjasite, rtjadocno, rtab001, rtja034,",
               "                         rtja035,  rtja031,   num)",
               " SELECT rtjasite, rtjadocno,           rtab001, rtja034,",
               "        rtja035,  COALESCE(rtja031,0), 1",
               "   FROM rtja_t",
               "   LEFT OUTER JOIN (SELECT rtabent, rtab001, rtab002",
               "                      FROM rtab_t, rtaa_t, rtak_t",
               "                     WHERE rtaaent = rtabent",
               "                       AND rtaa001 = rtab001",
               "                       AND rtakent = rtaaent",
               "                       AND rtak001 = rtaa001",
               "                       AND rtaastus = 'Y'",
               "                       AND rtak002 = '1'",
               "                       AND rtak003 = 'Y'",
               "                       AND rtaaent = ",g_enterprise,")",
               "                ON rtabent = rtjaent AND rtab002 = rtjasite",
               "  WHERE rtjaent = ",g_enterprise,
               "    AND rtja_t.rtja032 <> '4'",
               "    AND rtja_t.rtjastus = 'S'",
               "    AND ",tm.wc
   
   CASE tm.type
      WHEN 'Y'   #會員
         LET l_sql = l_sql," AND rtja001 IS NOT NULL"
      WHEN 'N'   #非會員
         LET l_sql = l_sql," AND rtja001 IS NULL"
   END CASE
   PREPARE acrr800_ins_tmp FROM l_sql
   EXECUTE acrr800_ins_tmp
   DISPLAY l_sql
   #end add-point
   LET g_select = " SELECT rtjasite,NULL,rtab_t.rtab001,NULL,rtja034,oocq009,oocq010,0,NULL"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_select = "SELECT DISTINCT rtjasite, (SELECT ooefl003 FROM ooefl_t",
                  "                            WHERE ooeflent = ",g_enterprise,
                  "                              AND ooefl001 = rtjasite",
                  "                              AND ooefl002 = '",g_dlang,"'),",
                  "                rtab001,  (SELECT rtaal003 FROM rtaal_t",
                  "                            WHERE rtaalent = ",g_enterprise,
                  "                              AND rtaal001 = rtab001",
                  "                              AND rtaal002 = '",g_dlang,"'),",
                  "                rtja034,  oocq009, oocq010, 0, oocq009||'-'||oocq010"
   #end add-point
    LET g_from = " FROM rtja_t,oocq_t,rtab_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET g_from  = " FROM acrr800_tmp,oocq_t"
   #end add-point
    LET g_where = " WHERE rtja_t.rtja032 <> '4' rtja_t.rtjastus = 'S' oocq_t.oocq001 = '2108' oocq_t.oocqstus = 'Y' AND " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   LET g_where = " WHERE oocqent = ",g_enterprise,
                 "   AND oocq001 = '2108'",
                 "   AND oocqstus = 'Y'"
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("rtja_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = g_sql, " ORDER BY rtjasite,rtja034,oocq009,oocq010"
   #end add-point
   PREPARE acrr800_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE acrr800_x01_curs CURSOR FOR acrr800_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="acrr800_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION acrr800_x01_ins_data()
DEFINE sr RECORD 
   rtjasite LIKE rtja_t.rtjasite, 
   l_rtjasite_desc LIKE type_t.chr1000, 
   rtab_t_rtab001 LIKE rtab_t.rtab001, 
   l_rtab001_desc LIKE type_t.chr1000, 
   rtja034 LIKE rtja_t.rtja034, 
   oocq009 LIKE oocq_t.oocq009, 
   oocq010 LIKE oocq_t.oocq010, 
   l_sum LIKE type_t.num26_10, 
   l_time LIKE type_t.chr30
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
   DEFINE l_sql         STRING
   DEFINE l_str         STRING
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    #門店時段來客次數(acrr800) => 作業參數(tm.argv1) = '1'
    #門店時段來客金額(acrr801) => 作業參數(tm.argv1) = '2'
    IF tm.argv1 = '1' THEN
       LET l_sql = "SELECT COALESCE(SUM(num),0)",
                   "  FROM acrr800_tmp",
                   " WHERE rtjasite = ?",
                   "   AND rtja034 = ?",
                   "   AND rtja035 BETWEEN ? AND ?"
    ELSE
       LET l_sql = "SELECT COALESCE(SUM(rtja031),0)",
                   "  FROM acrr800_tmp",
                   " WHERE rtjasite = ?",
                   "   AND rtja034 = ?",
                   "   AND rtja035 BETWEEN ? AND ?"
    END IF
    PREPARE acrr800_x01_sum FROM l_sql
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH acrr800_x01_curs INTO sr.*                               
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
       LET sr.l_sum = 0
       EXECUTE acrr800_x01_sum
         USING sr.rtjasite, sr.rtja034, sr.oocq009, sr.oocq010
          INTO sr.l_sum

       LET sr.l_rtjasite_desc = sr.rtjasite,".",sr.l_rtjasite_desc
       LET sr.l_rtab001_desc = sr.rtab_t_rtab001,".",sr.l_rtab001_desc
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.l_rtjasite_desc,sr.l_rtab001_desc,sr.rtja034,sr.l_sum,sr.l_time
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "acrr800_x01_execute"
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
    LET l_str = cl_get_progname(g_prog,g_dlang,"1")
    LET g_xg_rep_title = l_str
    LET g_xgrid.title2 = l_str
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="acrr800_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION acrr800_x01_rep_data()
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
 
{<section id="acrr800_x01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 建立temp table
# Memo...........:
# Usage..........: CALL acrr800_x01_create_tmp()
#                  RETURNING r_success
# Input parameter: 無
# Return code....: r_success      True/False
# Date & Author..: 2016/02/15 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION acrr800_x01_create_tmp()
DEFINE r_success         LIKE type_t.num5

   LET r_success = TRUE

   DROP TABLE acrr800_tmp

   CREATE TEMP TABLE acrr800_tmp(
      rtjasite       LIKE rtja_t.rtjasite,    #銷售組織
      rtjadocno      LIKE rtja_t.rtjadocno,   #銷售單據
      rtab001        LIKE rtab_t.rtab001,     #店群編號
      rtja034        LIKE rtja_t.rtja034,     #來源日期
      rtja035        LIKE rtja_t.rtja035,     #來源時間
      rtja031        LIKE rtja_t.rtja031,     #消費金額
      num            LIKE type_t.num26_10     #次數
   )
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "Create Temp Table acrr800_tmp"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success
END FUNCTION

 
{</section>}
 
