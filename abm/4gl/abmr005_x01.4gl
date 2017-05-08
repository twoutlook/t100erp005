#該程式未解開Section, 採用最新樣板產出!
{<section id="abmr005_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2014-10-21 14:44:27), PR版次:0001(2014-10-21 15:38:49)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000076
#+ Filename...: abmr005_x01
#+ Description: ...
#+ Creator....: 05423(2014-10-11 14:15:26)
#+ Modifier...: 05423 -SD/PR- 05423
 
{</section>}
 
{<section id="abmr005_x01.global" readonly="Y" >}
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
       a1 STRING                   #source
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="abmr005_x01.main" readonly="Y" >}
PUBLIC FUNCTION abmr005_x01(p_arg1,p_arg2)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 STRING                  #tm.a1  source
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
   LET g_rep_code = "abmr005_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL abmr005_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL abmr005_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL abmr005_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL abmr005_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL abmr005_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="abmr005_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION abmr005_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "imaf001.imaf_t.imaf001,imaal_t_imaal003.imaal_t.imaal003,imaal_t_imaal004.imaal_t.imaal004,imaa009.imaa_t.imaa009,l_imaa009_desc.type_t.chr30,imaa010.imaa_t.imaa010,l_imaa010_desc.type_t.chr30,imaa004.imaa_t.imaa004,l_imaa004_desc.type_t.chr30,imaf013.imaf_t.imaf013,l_imaf013_desc.type_t.chr30" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="abmr005_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION abmr005_x01_ins_prep()
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
         
         #end add-point                  
 
 
      END CASE
   END FOR
END FUNCTION
 
{</section>}
 
{<section id="abmr005_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION abmr005_x01_sel_prep()
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
   CASE tm.a1
      WHEN '1' 
         LET g_select = " SELECT DISTINCT imaf_t.imaf001,imaal003,imaal004,imaa009,(trim(imaa_t.imaa009)||'.'||trim(rtaxl_t.rtaxl003)),imaa010,(trim(imaa_t.imaa010)||'.'||trim(oocql_t.oocql004)),imaa004,NULL,imaf_t.imaf013, 
         NULL"
      WHEN '2'
         LET g_select = " SELECT DISTINCT xmdc001,imaal003,imaal004,imaa009,(trim(imaa_t.imaa009)||'.'||trim(rtaxl_t.rtaxl003)),imaa010,(trim(imaa_t.imaa010)||'.'||trim(oocql_t.oocql004)),imaa004,NULL,imaf_t.imaf013, 
         NULL"
   END CASE

#   #end add-point
#   LET g_select = " SELECT imaf001,imaal_t.imaal003,imaal_t.imaal004,imaa009,NULL,imaa010,NULL,imaa004, 
#       NULL,imaf013,NULL"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   CASE tm.a1
      WHEN '1'
         LET g_from = " FROM imaf_t LEFT OUTER JOIN imaa_t ON imaf001 = imaa001 AND imafent = imaaent ",
                      "             LEFT OUTER JOIN imaal_t ON imaf001 = imaal001 AND imafent = imaalent AND imaal002 = '",g_dlang,"' ",
                      "             LEFT OUTER JOIN rtaxl_t ON imaa009 = rtaxl001 AND imaaent = rtaxlent AND rtaxl002 = '",g_dlang,"' ",
                      "             LEFT OUTER JOIN oocql_t ON imaa010 = oocql002 AND imaaent = oocqlent AND oocql001 = '210' AND oocql003 = '",g_dlang,"' " 
      WHEN '2'
         LET g_from = " FROM xmdc_t  LEFT OUTER JOIN imaa_t ON xmdc001 = imaa001 AND xmdcent = imaaent ",
                      "             LEFT OUTER JOIN imaf_t ON imaf001 = xmdc001 AND imafent = xmdcent AND imafent = xmdcent AND imafsite = xmdcsite ",
                      "             LEFT OUTER JOIN imaal_t ON imaf001 = imaal001 AND imafent = imaalent AND imaal002 = '",g_dlang,"' ",
                      "             LEFT OUTER JOIN rtaxl_t ON imaa009 = rtaxl001 AND imaaent = rtaxlent AND rtaxl002 = '",g_dlang,"' ",
                      "             LEFT OUTER JOIN oocql_t ON imaa010 = oocql002 AND imaaent = oocqlent AND oocql001 = '210' AND oocql003 = '",g_dlang,"' " 
   END CASE
#   #end add-point
#    LET g_from = " FROM imaf_t,imaa_t,imaal_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
#   CASE tm.a1
#      WHEN '1'
#         LET g_order = " ORDER BY imaf001 "
#      WHEN '2'
#         LET g_order = " ORDER BY xmdc001 "
#   END CASE
#
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("imaf_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
#   LET g_sql = g_sql CLIPPED ," ",g_order CLIPPED 
#   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
   #end add-point
   PREPARE abmr005_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE abmr005_x01_curs CURSOR FOR abmr005_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="abmr005_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION abmr005_x01_ins_data()
DEFINE sr RECORD 
   imaf001 LIKE imaf_t.imaf001, 
   imaal_t_imaal003 LIKE imaal_t.imaal003, 
   imaal_t_imaal004 LIKE imaal_t.imaal004, 
   imaa009 LIKE imaa_t.imaa009, 
   l_imaa009_desc LIKE type_t.chr30, 
   imaa010 LIKE imaa_t.imaa010, 
   l_imaa010_desc LIKE type_t.chr30, 
   imaa004 LIKE imaa_t.imaa004, 
   l_imaa004_desc LIKE type_t.chr30, 
   imaf013 LIKE imaf_t.imaf013, 
   l_imaf013_desc LIKE type_t.chr30
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH abmr005_x01_curs INTO sr.*                               
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
       CALL abmr005_x01_desc('1001',sr.imaa004) RETURNING sr.l_imaa004_desc
       CALL abmr005_x01_desc('2022',sr.imaf013) RETURNING sr.l_imaf013_desc
       LET sr.l_imaa004_desc = sr.imaa004 ,".",sr.l_imaa004_desc
       LET sr.l_imaf013_desc = sr.imaf013 ,".",sr.l_imaf013_desc
       IF cl_null(sr.imaa009) THEN
         LET sr.l_imaa009_desc = NULL
       END IF
       IF cl_null(sr.imaa010) THEN
         LET sr.l_imaa010_desc = NULL               
       END IF
       IF cl_null(sr.imaa004) THEN
         LET sr.l_imaa004_desc = NULL               
       END IF       
       IF cl_null(sr.imaf013) THEN
         LET sr.l_imaf013_desc = NULL               
       END IF
       
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.imaf001,sr.imaal_t_imaal003,sr.imaal_t_imaal004,sr.imaa009,sr.l_imaa009_desc,sr.imaa010,sr.l_imaa010_desc,sr.imaa004,sr.l_imaa004_desc,sr.imaf013,sr.l_imaf013_desc
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "abmr005_x01_execute"
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
 
{<section id="abmr005_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION abmr005_x01_rep_data()
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
 
{<section id="abmr005_x01.other_function" readonly="Y" >}

PRIVATE FUNCTION abmr005_x01_desc(p_num,p_target)
   DEFINE p_num    LIKE type_t.num5
   DEFINE p_target LIKE type_t.chr10
   DEFINE r_desc   LIKE type_t.chr500
   
   SELECT gzcbl004 INTO r_desc
      FROM gzcbl_t
     WHERE gzcbl001 = p_num
       AND gzcbl002 = p_target
       AND gzcbl003 = g_dlang
   
   RETURN r_desc 
END FUNCTION

 
{</section>}
 