#該程式未解開Section, 採用最新樣板產出!
{<section id="ainr920_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2015-01-29 16:14:37), PR版次:0001(2015-01-29 16:20:36)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000061
#+ Filename...: ainr920_x01
#+ Description: ...
#+ Creator....: 05423(2014-12-23 17:29:13)
#+ Modifier...: 05423 -SD/PR- 05423
 
{</section>}
 
{<section id="ainr920_x01.global" readonly="Y" >}
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
       type STRING,                  #data type 
       pr LIKE type_t.chr2          #最大版本
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="ainr920_x01.main" readonly="Y" >}
PUBLIC FUNCTION ainr920_x01(p_arg1,p_arg2,p_arg3)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 STRING                  #tm.type  data type 
DEFINE  p_arg3 LIKE type_t.chr2         #tm.pr  最大版本
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.type = p_arg2
   LET tm.pr = p_arg3
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "ainr920_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL ainr920_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL ainr920_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL ainr920_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL ainr920_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL ainr920_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="ainr920_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION ainr920_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "inpq001.inpq_t.inpq001,inpq000.inpq_t.inpq000,l_inpq001_desc1.type_t.chr50,l_inpq001_desc2.type_t.chr50,inpq004.inpq_t.inpq004,l_inpq004_desc.type_t.chr30,inpq005.inpq_t.inpq005,inpq009.inpq_t.inpq009,inpq011.inpq_t.inpq011,inpq010.inpq_t.inpq010,inpq007.inpq_t.inpq007,inpq008.inpq_t.inpq008" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="ainr920_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION ainr920_x01_ins_prep()
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
         
         #end add-point                  
 
 
      END CASE
   END FOR
END FUNCTION
 
{</section>}
 
{<section id="ainr920_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION ainr920_x01_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define(客製用) name="sel_prep.define_customerization"

#end add-point
#add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
DEFINE g_order       STRING
#end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
 
   #add-point:sel_prep g_select name="sel_prep.g_select"
   LET g_select = " SELECT DISTINCT inpq001,inpq000,NULL,NULL,inpq004,NULL,inpq005,inpq009,inpq011,inpq010,inpq007, 
       inpq008,inpq002,inpq003 "
#   #end add-point
#   LET g_select = " SELECT inpq001,inpq000,NULL,NULL,inpq004,NULL,inpq005,inpq009,inpq011,inpq010,inpq007, 
#       inpq008,inpq002,inpq003"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
    CASE tm.type
      WHEN '1'
         LET g_from = " FROM inpq_t LEFT OUTER JOIN inpo_t ON inpq006 = inpo001 AND inpqent = inpoent AND inpqsite = inposite ",
                 "             LEFT OUTER JOIN imaa_t ON imaa001 = inpq001 AND imaaent = inpqent "
      WHEN '2'
         LET g_from = " FROM inpq_t LEFT OUTER JOIN inpo_t ON inpq006 = inpo001 AND inpqent = inpoent AND inpqsite = inposite ",
                 "             LEFT OUTER JOIN imaa_t ON imaa009 = inpq001 AND imaaent = inpqent "
      WHEN '3'
         LET g_from = " FROM inpq_t LEFT OUTER JOIN inpo_t ON inpq006 = inpo001 AND inpqent = inpoent AND inpqsite = inposite ",
                 "             LEFT OUTER JOIN imaf_t ON imaf057 = inpq001 AND imafent = inpqent AND imafsite = inpqsite "
      WHEN '4'
         LET g_from = " FROM inpq_t LEFT OUTER JOIN inpo_t ON inpq006 = inpo001 AND inpqent = inpoent AND inpqsite = inposite ",
                 "             LEFT OUTER JOIN imag_t ON imag011 = inpq001 AND imagent = inpqent AND imagsite = inpqsite "
    END CASE
#    LET g_from = " FROM inpq_t LEFT OUTER JOIN inpo_t ON inpq006 = inpo001 AND inpqent = inpoent AND inpqsite = inposite ",
#                 "             LEFT OUTER JOIN imaa_t ON (imaa001 = inpq001 OR imaa009 = inpq001) AND imaaent = inpqent ",
#                 "             LEFT OUTER JOIN imaf_t ON imaf057 = inpq001 AND imafent = inpqent AND imafsite = inpqsite ",
#                 "             LEFT OUTER JOIN imag_t ON imag011 = inpq001 AND imagent = inpqent AND imagsite = inpqsite "
#   #end add-point
#    LET g_from = " FROM inpq_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   LET g_order = " ORDER BY inpq001,inpq000,inpq004,inpq005 "
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("inpq_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_where = g_where ,cl_sql_add_filter("inpq_t")   #資料過濾功能
   LET g_sql = g_sql CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
   #end add-point
   PREPARE ainr920_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE ainr920_x01_curs CURSOR FOR ainr920_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="ainr920_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION ainr920_x01_ins_data()
DEFINE sr RECORD 
   inpq001 LIKE inpq_t.inpq001, 
   inpq000 LIKE inpq_t.inpq000, 
   l_inpq001_desc1 LIKE type_t.chr50, 
   l_inpq001_desc2 LIKE type_t.chr50, 
   inpq004 LIKE inpq_t.inpq004, 
   l_inpq004_desc LIKE type_t.chr30, 
   inpq005 LIKE inpq_t.inpq005, 
   inpq009 LIKE inpq_t.inpq009, 
   inpq011 LIKE inpq_t.inpq011, 
   inpq010 LIKE inpq_t.inpq010, 
   inpq007 LIKE inpq_t.inpq007, 
   inpq008 LIKE inpq_t.inpq008, 
   inpq002 LIKE inpq_t.inpq002, 
   inpq003 LIKE inpq_t.inpq003
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_inpq005 LIKE inpq_t.inpq005
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH ainr920_x01_curs INTO sr.*                               
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
       ----2015-1-29 zj mod 參數tm.pr為'Y'，則只列印最大版本號----------
       IF tm.pr = 'Y' THEN                
          SELECT MAX(inpq005) INTO l_inpq005
            FROM inpq_t 
           WHERE inpqent = g_enterprise
             AND inpqsite = g_site
             AND inpq000 = sr.inpq000
             AND inpq001 = sr.inpq001
             AND inpq002 = sr.inpq002
             AND inpq003 = sr.inpq003
          IF sr.inpq005 != l_inpq005 THEN
            CONTINUE FOREACH
          END IF
       END IF
       ----2015-1-29 zj mod end--------------------------------------
       CASE sr.inpq000
         WHEN '1'
            SELECT imaal003,imaal004 INTO sr.l_inpq001_desc1,sr.l_inpq001_desc2
              FROM imaal_t
             WHERE imaal001 = sr.inpq001 
               AND imaalent = g_enterprise
               AND imaal002 = g_dlang
         WHEN '2'
            SELECT rtaxl003,NULL INTO sr.l_inpq001_desc1,sr.l_inpq001_desc2
              FROM rtaxl_t 
             WHERE rtaxl001 = sr.inpq001
               AND rtaxlent = g_enterprise 
               AND rtaxl002 = g_dlang
         WHEN '3'
            SELECT gzcbl004,NULL INTO sr.l_inpq001_desc1,sr.l_inpq001_desc2
              FROM gzcbl_t 
             WHERE gzcbl001 = sr.inpq001
               AND gzcbl002 = g_dlang
         WHEN '4'
            SELECT oocql004,NULL INTO sr.l_inpq001_desc1,sr.l_inpq001_desc2
              FROM oocql_t 
             WHERE oocql001 = sr.inpq001
               AND oocqlent = g_enterprise 
               AND oocql002 = g_dlang
       END CASE
       IF NOT cl_null(sr.inpq004) THEN
         CALL ainr920_x01_desc('1','2221',sr.inpq004) RETURNING sr.l_inpq004_desc
       END IF
         
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.inpq001,sr.inpq000,sr.l_inpq001_desc1,sr.l_inpq001_desc2,sr.inpq004,sr.l_inpq004_desc,sr.inpq005,sr.inpq009,sr.inpq011,sr.inpq010,sr.inpq007,sr.inpq008
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "ainr920_x01_execute"
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
 
{<section id="ainr920_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION ainr920_x01_rep_data()
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
 
{<section id="ainr920_x01.other_function" readonly="Y" >}

#獲取說明
PRIVATE FUNCTION ainr920_x01_desc(p_class,p_num,p_target)
   DEFINE p_class  LIKE type_t.chr2
   DEFINE p_num    LIKE type_t.num5
   DEFINE p_target LIKE type_t.chr10
   DEFINE r_desc   LIKE type_t.chr500

   CASE p_class
   WHEN '1'
      SELECT gzcbl004 INTO r_desc
      FROM gzcbl_t
      WHERE gzcbl001 = p_num
      AND gzcbl002 = p_target
      AND gzcbl003 = g_dlang

   WHEN '2'
      SELECT oocql004 INTO r_desc
      FROM oocql_t
      WHERE oocql001 = p_num
      AND oocql002 = p_target
      AND oocql003 = g_dlang
      AND oocqlent = g_enterprise
   END CASE
      
   RETURN r_desc 
END FUNCTION

 
{</section>}
 
