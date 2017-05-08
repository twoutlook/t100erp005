#該程式未解開Section, 採用最新樣板產出!
{<section id="abmr410_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2014-10-30 11:21:19), PR版次:0001(2014-10-30 11:29:15)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000057
#+ Filename...: abmr410_x01
#+ Description: ...
#+ Creator....: 05423(2014-10-27 14:20:17)
#+ Modifier...: 05423 -SD/PR- 05423
 
{</section>}
 
{<section id="abmr410_x01.global" readonly="Y" >}
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

#end add-point
 
{</section>}
 
{<section id="abmr410_x01.main" readonly="Y" >}
PUBLIC FUNCTION abmr410_x01(p_arg1)
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
   LET g_rep_code = "abmr410_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL abmr410_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL abmr410_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL abmr410_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL abmr410_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL abmr410_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="abmr410_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION abmr410_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "bmif001.bmif_t.bmif001,imaal003.imaal_t.imaal003,imaal004.imaal_t.imaal004,bmif005.bmif_t.bmif005,bmif004.bmif_t.bmif004,bmif002.bmif_t.bmif002,l_bmif002_desc.type_t.chr30,bmif003.bmif_t.bmif003,bmif006.bmif_t.bmif006,l_bmif006_desc.type_t.chr30,bmif007.bmif_t.bmif007,l_bmif007_desc.type_t.chr30,bmif009.bmif_t.bmif009,l_bmif009_desc.type_t.chr30,bmif010.bmif_t.bmif010,bmif011.bmif_t.bmif011,bmif012.bmif_t.bmif012,bmif017.bmif_t.bmif017,bmif018.bmif_t.bmif018,bmif019.bmif_t.bmif019,l_bmif019_desc.type_t.chr30,bmif020.bmif_t.bmif020,l_bmif020_desc.type_t.chr30,bmif014.bmif_t.bmif014,bmif015.bmif_t.bmif015,bmif016.bmif_t.bmif016,l_imaal003.type_t.chr30,l_imaal004.type_t.chr30" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="abmr410_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION abmr410_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="abmr410_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION abmr410_x01_sel_prep()
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
   LET g_select = " SELECT bmif001,b.imaal003,b.imaal004,bmif005,bmif004,bmif002,NULL,bmif003,bmif006,NULL, 
       bmif007,pmaal004,bmif009,NULL,bmif010,bmif011,bmif012,bmif017,bmif018,bmif019,ooag011,bmif020,ooefl003,bmif014, 
       bmif015,bmif016,a.imaal003,a.imaal004 "
#   #end add-point
#   LET g_select = " SELECT bmif001,imaal003,imaal004,bmif005,bmif004,bmif002,NULL,bmif003,bmif006,NULL, 
#       bmif007,NULL,bmif009,NULL,bmif010,bmif011,bmif012,bmif017,bmif018,bmif019,NULL,bmif020,NULL,bmif014, 
#       bmif015,bmif016,NULL,NULL"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
    LET g_from = " FROM bmif_t LEFT OUTER JOIN ooag_t ON ooag001 = bmif019 AND ooagent = bmifent ",
                 "             LEFT OUTER JOIN imaal_t b ON bmif001 = b.imaal001 AND bmifent = b.imaalent AND b.imaal002 = '",g_dlang,"' ",
                 "             LEFT OUTER JOIN imaal_t a ON bmif004 = a.imaal001 AND bmifent = a.imaalent AND a.imaal002 = '",g_dlang,"' ",
                 "             LEFT OUTER JOIN pmaal_t ON pmaal001 = bmif007 AND pmaalent = bmifent AND pmaal002 = '",g_dlang,"' ",
                 "             LEFT OUTER JOIN ooefl_t ON ooefl001 = bmif020 AND ooeflent = bmifent AND ooefl002 = '",g_dlang,"' "

#   #end add-point
#    LET g_from = " FROM bmif_t,imaal_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   LET g_order = " ORDER BY bmif001 "
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("bmif_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = g_sql CLIPPED ," ",g_order CLIPPED 
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
   #end add-point
   PREPARE abmr410_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE abmr410_x01_curs CURSOR FOR abmr410_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="abmr410_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION abmr410_x01_ins_data()
DEFINE sr RECORD 
   bmif001 LIKE bmif_t.bmif001, 
   imaal003 LIKE imaal_t.imaal003, 
   imaal004 LIKE imaal_t.imaal004, 
   bmif005 LIKE bmif_t.bmif005, 
   bmif004 LIKE bmif_t.bmif004, 
   bmif002 LIKE bmif_t.bmif002, 
   l_bmif002_desc LIKE type_t.chr30, 
   bmif003 LIKE bmif_t.bmif003, 
   bmif006 LIKE bmif_t.bmif006, 
   l_bmif006_desc LIKE type_t.chr30, 
   bmif007 LIKE bmif_t.bmif007, 
   l_bmif007_desc LIKE type_t.chr30, 
   bmif009 LIKE bmif_t.bmif009, 
   l_bmif009_desc LIKE type_t.chr30, 
   bmif010 LIKE bmif_t.bmif010, 
   bmif011 LIKE bmif_t.bmif011, 
   bmif012 LIKE bmif_t.bmif012, 
   bmif017 LIKE bmif_t.bmif017, 
   bmif018 LIKE bmif_t.bmif018, 
   bmif019 LIKE bmif_t.bmif019, 
   l_bmif019_desc LIKE type_t.chr30, 
   bmif020 LIKE bmif_t.bmif020, 
   l_bmif020_desc LIKE type_t.chr30, 
   bmif014 LIKE bmif_t.bmif014, 
   bmif015 LIKE bmif_t.bmif015, 
   bmif016 LIKE bmif_t.bmif016, 
   l_imaal003 LIKE type_t.chr30, 
   l_imaal004 LIKE type_t.chr30
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH abmr410_x01_curs INTO sr.*                               
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
       IF NOT cl_null(sr.bmif002) THEN
         CALL abmr410_x01_desc('2','221',sr.bmif002) RETURNING sr.l_bmif002_desc
       END IF
       IF NOT cl_null(sr.bmif006) THEN
         CALL abmr410_x01_desc('1','2014',sr.bmif006) RETURNING sr.l_bmif006_desc
         LET sr.l_bmif006_desc = sr.bmif006,".",sr.l_bmif006_desc
       END IF
       IF NOT cl_null(sr.bmif009) THEN
         CALL abmr410_x01_desc('2','1116',sr.bmif009) RETURNING sr.l_bmif009_desc
       END IF
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.bmif001,sr.imaal003,sr.imaal004,sr.bmif005,sr.bmif004,sr.bmif002,sr.l_bmif002_desc,sr.bmif003,sr.bmif006,sr.l_bmif006_desc,sr.bmif007,sr.l_bmif007_desc,sr.bmif009,sr.l_bmif009_desc,sr.bmif010,sr.bmif011,sr.bmif012,sr.bmif017,sr.bmif018,sr.bmif019,sr.l_bmif019_desc,sr.bmif020,sr.l_bmif020_desc,sr.bmif014,sr.bmif015,sr.bmif016,sr.l_imaal003,sr.l_imaal004
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "abmr410_x01_execute"
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
 
{<section id="abmr410_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION abmr410_x01_rep_data()
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
 
{<section id="abmr410_x01.other_function" readonly="Y" >}

PRIVATE FUNCTION abmr410_x01_desc(p_type,p_num,p_target)
   DEFINE p_type    LIKE type_t.chr10
   DEFINE p_num    LIKE type_t.num5
   DEFINE p_target LIKE type_t.chr10
   DEFINE r_desc   LIKE type_t.chr500
  
   CASE p_type
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
 
