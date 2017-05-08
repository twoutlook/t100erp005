#該程式未解開Section, 採用最新樣板產出!
{<section id="apmr010_x03.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2014-12-22 15:12:06), PR版次:0001(2014-12-11 17:37:57)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000058
#+ Filename...: apmr010_x03
#+ Description: ...
#+ Creator....: 05423(2014-11-04 09:37:31)
#+ Modifier...: 05423 -SD/PR- 05423
 
{</section>}
 
{<section id="apmr010_x03.global" readonly="Y" >}
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
       wc STRING                   #where condition
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE l_where       STRING

#end add-point
 
{</section>}
 
{<section id="apmr010_x03.main" readonly="Y" >}
PUBLIC FUNCTION apmr010_x03(p_arg1)
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
   LET g_rep_code = "apmr010_x03"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL apmr010_x03_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL apmr010_x03_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL apmr010_x03_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL apmr010_x03_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL apmr010_x03_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="apmr010_x03.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION apmr010_x03_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "pmds003.pmds_t.pmds003,l_pmds003_desc.type_t.chr30,pmdt051.pmdt_t.pmdt051,l_pmdt051_desc.type_t.chr30,l_count.type_t.num15_3,l_count_pct.type_t.num15_3,l_value.type_t.num15_3,l_value_pct.type_t.num15_3" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="apmr010_x03.ins_prep" readonly="Y" >}
PRIVATE FUNCTION apmr010_x03_ins_prep()
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
 
{<section id="apmr010_x03.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apmr010_x03_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define(客製用) name="sel_prep.define_customerization"

#end add-point
#add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
DEFINE g_order       STRING
DEFINE l_sql         STRING
#end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
 
   #add-point:sel_prep g_select name="sel_prep.g_select"
   LET g_select = " SELECT DISTINCT pmds003,(trim(pmds_t.pmds003)||'.'||trim(ooefl_t.ooefl003)),pmdt051,(trim(pmdt_t.pmdt051)||'.'||trim(oocql_t.oocql004)),NULL,NULL,NULL,NULL"
#   #end add-point
#   LET g_select = " SELECT pmds003,NULL,pmdt051,NULL,NULL,NULL,NULL,NULL"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
    LET g_from = " FROM pmds_t LEFT OUTER JOIN pmdt_t ON pmdtdocno = pmdsdocno AND pmdtent = pmdsent ",
                 "             LEFT OUTER JOIN imaa_t ON imaa001 = pmdt006 AND imaaent = pmdtent ",
                 "             LEFT OUTER JOIN pmaa_t ON pmaa001 = pmds007 AND pmaaent = pmdsent ",
                 "             LEFT OUTER JOIN ooefl_t ON ooefl001 = pmds003 AND ooeflent = pmdsent AND ooefl002 = '",g_dlang,"' ",
                 "             LEFT OUTER JOIN oocql_t ON oocql001 = '269' AND oocql002 = pmdt051 AND oocqlent = pmdtent AND oocql003 = '",g_dlang,"' "
#   #end add-point
#    LET g_from = " FROM pmds_t,pmdt_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   LET g_order = " ORDER BY pmds003 "

   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("pmds_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = g_sql CLIPPED ," ",g_order CLIPPED ," "
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
   LET l_where = g_from CLIPPED ," ",g_where CLIPPED
   
   #計算所有資料的筆數及總金額
   LET l_sql = "SELECT COUNT(pmdtseq),SUM(COALESCE(pmdt038,0)*COALESCE(pmds038,1))" CLIPPED ,
               " ",g_from CLIPPED ," ",g_where CLIPPED
   PREPARE apmr010_x03_sum FROM l_sql
   #end add-point
   PREPARE apmr010_x03_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE apmr010_x03_curs CURSOR FOR apmr010_x03_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="apmr010_x03.ins_data" readonly="Y" >}
PRIVATE FUNCTION apmr010_x03_ins_data()
DEFINE sr RECORD 
   pmds003 LIKE pmds_t.pmds003, 
   l_pmds003_desc LIKE type_t.chr30, 
   pmdt051 LIKE pmdt_t.pmdt051, 
   l_pmdt051_desc LIKE type_t.chr30, 
   l_count LIKE type_t.num15_3, 
   l_count_pct LIKE type_t.num15_3, 
   l_value LIKE type_t.num15_3, 
   l_value_pct LIKE type_t.num15_3
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_sql1     STRING
DEFINE l_count LIKE type_t.num20_6
DEFINE l_count_total LIKE type_t.num20_6
DEFINE l_value LIKE type_t.num20_6
DEFINE l_value_total LIKE type_t.num20_6
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH apmr010_x03_curs INTO sr.*                               
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
       IF cl_null(sr.pmdt051) THEN
         LET sr.l_pmdt051_desc = NULL
         LET l_sql1 = " SELECT COUNT(pmdtseq),SUM(COALESCE(pmdt038,0)*COALESCE(pmds038,1)) ",l_where CLIPPED,
                       " AND pmds003 = '",sr.pmds003 CLIPPED,"' AND pmdt051 IS NULL GROUP BY pmds003,pmdt051 "
       ELSE
         LET l_sql1 = " SELECT COUNT(pmdtseq),SUM(COALESCE(pmdt038,0)*COALESCE(pmds038,1)) ",l_where CLIPPED,
                       " AND pmds003 = '",sr.pmds003 CLIPPED,"' AND pmdt051 = '",sr.pmdt051 CLIPPED,"' GROUP BY pmds003,pmdt051 "
       END IF
       PREPARE apmr010_x03_sum2 FROM l_sql1
       DECLARE apmr010_x03_curs2 CURSOR FOR apmr010_x03_sum2
       OPEN apmr010_x03_curs2
       FETCH apmr010_x03_curs2 INTO sr.l_count,sr.l_value

       #計算總筆數、總金額
       LET l_count_total = 0
       LET l_value_total = 0
       EXECUTE apmr010_x03_sum INTO l_count_total,l_value_total
       #計算百分比
       IF l_count_total = 0 THEN
         LET sr.l_count_pct = 0
       ELSE
         LET sr.l_count_pct = (sr.l_count / l_count_total) 
       END IF
       IF l_value_total = 0 THEN
         LET sr.l_value_pct = 0
       ELSE
         LET sr.l_value_pct = (sr.l_value / l_value_total) 
       END IF
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.pmds003,sr.l_pmds003_desc,sr.pmdt051,sr.l_pmdt051_desc,sr.l_count,sr.l_count_pct,sr.l_value,sr.l_value_pct
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "apmr010_x03_execute"
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
 
{<section id="apmr010_x03.rep_data" readonly="Y" >}
PRIVATE FUNCTION apmr010_x03_rep_data()
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
 
{<section id="apmr010_x03.other_function" readonly="Y" >}

 
{</section>}
 
