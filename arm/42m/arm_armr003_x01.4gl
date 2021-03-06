#該程式未解開Section, 採用最新樣板產出!
{<section id="armr003_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2015-06-10 11:50:17), PR版次:0001(2015-12-17 15:24:49)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000041
#+ Filename...: armr003_x01
#+ Description: ...
#+ Creator....: 05423(2015-06-05 17:04:48)
#+ Modifier...: 05423 -SD/PR- 05423
 
{</section>}
 
{<section id="armr003_x01.global" readonly="Y" >}
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
 
{<section id="armr003_x01.main" readonly="Y" >}
PUBLIC FUNCTION armr003_x01(p_arg1)
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
   LET g_rep_code = "armr003_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL armr003_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL armr003_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL armr003_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL armr003_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL armr003_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="armr003_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION armr003_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "l_imaa009.imaa_t.imaa009,l_imaa009_desc.rtaxl_t.rtaxl003,sfba006.sfba_t.sfba006,l_imaal003_1.imaal_t.imaal003,l_imaal004_1.imaal_t.imaal004,sfaa010.sfaa_t.sfaa010,l_imaal003_2.imaal_t.imaal003,l_imaal004_2.imaal_t.imaal004,l_sum1.sfaa_t.sfaa012,l_sum2.sfba_t.sfba016,l_imae016.imae_t.imae016,l_imae081.imae_t.imae081" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="armr003_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION armr003_x01_ins_prep()
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
 
{<section id="armr003_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION armr003_x01_sel_prep()
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
   LET g_select = " SELECT DISTINCT imaa009,trim(imaa009)||'.'||trim(rtaxl003),sfba006,t1.imaal003,t1.imaal004,",
                  " sfaa010,t2.imaal003,t2.imaal004,0,0,t3.imae016,t4.imae081"
#   #end add-point
#   LET g_select = " SELECT NULL,NULL,sfba006,NULL,NULL,sfaa010,NULL,NULL,NULL,NULL,NULL,NULL"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_from = " FROM sfaa_t LEFT OUTER JOIN sfba_t ON sfaadocno = sfbadocno AND sfaaent = sfbaent ",
                "             LEFT OUTER JOIN imaa_t ON sfba006 = imaa001 AND sfbaent = imaaent ",
                "             LEFT OUTER JOIN rtaxl_t ON imaa009 = rtaxl001 AND imaaent = rtaxlent AND rtaxl002 = '",g_dlang,"' ",
                "             LEFT OUTER JOIN imaal_t t1 ON sfba006 = t1.imaal001 AND sfbaent = t1.imaalent AND t1.imaal002 = '",g_dlang,"' ",
                "             LEFT OUTER JOIN imaal_t t2 ON sfaa010 = t2.imaal001 AND sfaaent = t2.imaalent AND t2.imaal002 = '",g_dlang,"' ",
                "             LEFT OUTER JOIN imae_t t3 ON sfaa010 = t3.imae001 AND sfaaent = t3.imaeent AND sfaasite = t3.imaesite ",
                "             LEFT OUTER JOIN imae_t t4 ON sfba006 = t4.imae001 AND sfbaent = t4.imaeent AND sfbasite = t4.imaesite "
#   #end add-point
#    LET g_from = " FROM sfaa_t,sfba_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("sfaa_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE armr003_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE armr003_x01_curs CURSOR FOR armr003_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="armr003_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION armr003_x01_ins_data()
DEFINE sr RECORD 
   l_imaa009 LIKE imaa_t.imaa009, 
   l_imaa009_desc LIKE rtaxl_t.rtaxl003, 
   sfba006 LIKE sfba_t.sfba006, 
   l_imaal003_1 LIKE imaal_t.imaal003, 
   l_imaal004_1 LIKE imaal_t.imaal004, 
   sfaa010 LIKE sfaa_t.sfaa010, 
   l_imaal003_2 LIKE imaal_t.imaal003, 
   l_imaal004_2 LIKE imaal_t.imaal004, 
   l_sum1 LIKE sfaa_t.sfaa012, 
   l_sum2 LIKE sfba_t.sfba016, 
   l_imae016 LIKE imae_t.imae016, 
   l_imae081 LIKE imae_t.imae081
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_sfaa012  LIKE sfaa_t.sfaa012  #返修数量
DEFINE l_sfaa013  LIKE sfaa_t.sfaa013  #返修单位
DEFINE l_sfba016  LIKE sfba_t.sfba016  #领用数量 = 已发（sfba016）+超领（sfba025）
DEFINE l_sfba014  LIKE sfba_t.sfba014  #领用单位
DEFINE l_sum_sql1 STRING
DEFINE l_sum_sql2 STRING
DEFINE l_rate     LIKE inaj_t.inaj014
DEFINE l_success  LIKE type_t.chr2
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH armr003_x01_curs INTO sr.*                               
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
       IF sr.l_imaa009_desc = '.' THEN
          LET sr.l_imaa009_desc = NULL
       END IF
       
       IF NOT cl_null(sr.sfaa010) THEN
          LET l_sum_sql1 = " SELECT DISTINCT SUM(COALESCE(sfaa012,0)),sfaa013 ",
                           " FROM sfaa_t LEFT OUTER JOIN sfba_t ON sfaadocno = sfbadocno AND sfaaent = sfbaent ",
                           " WHERE ",tm.wc CLIPPED,
                           "   AND sfaa010 = '",sr.sfaa010,"' ",
                           "   AND sfba006 = '",sr.sfba006,"' ",
                           "   AND sfaaent = ",g_enterprise,
                           " GROUP BY sfaa013 "
          PREPARE armr003_x01_sum1_pre FROM l_sum_sql1
          IF STATUS THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.extend = 'prepare:'
             LET g_errparam.code   = STATUS
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             LET g_rep_success = 'N' 
          END IF
          DECLARE armr003_x01_sum1_curs CURSOR FOR armr003_x01_sum1_pre
          FOREACH armr003_x01_sum1_curs INTO l_sfaa012,l_sfaa013
             IF STATUS THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = 'foreach:'
                LET g_errparam.code   = STATUS
                LET g_errparam.popup  = TRUE
                CALL cl_err()
                LET g_rep_success = 'N'
                EXIT FOREACH
             END IF
             #统一换算成料件主档的生产单位数量
             IF NOT cl_null(sr.l_imae016) AND NOT cl_null(l_sfaa013) THEN
                CALL s_aimi190_get_convert(sr.sfaa010,l_sfaa013,sr.l_imae016) RETURNING l_success,l_rate 
                IF NOT l_success THEN
                   LET l_rate = 1
                END IF
             ELSE 
                LET l_rate = 1
             END IF
             LET sr.l_sum1 = sr.l_sum1 + l_sfaa012 * l_rate
             LET l_rate = 0
          END FOREACH
       END IF
       
       IF NOT cl_null(sr.sfba006) THEN
          LET l_sum_sql2 = " SELECT DISTINCT SUM(COALESCE(sfba016,0)+COALESCE(sfba025,0)),sfba014 ",
                           " FROM sfaa_t LEFT OUTER JOIN sfba_t ON sfaadocno = sfbadocno AND sfaaent = sfbaent ",
                           " WHERE ",tm.wc CLIPPED,
                           "   AND sfaa010 = '",sr.sfaa010,"' ",
                           "   AND sfba006 = '",sr.sfba006,"' ",
                           "   AND sfaaent = ",g_enterprise,
                           " GROUP BY sfba014 "
          PREPARE armr003_x01_sum2_pre FROM l_sum_sql2
          IF STATUS THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.extend = 'prepare:'
             LET g_errparam.code   = STATUS
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             LET g_rep_success = 'N' 
          END IF
          DECLARE armr003_x01_sum2_curs CURSOR FOR armr003_x01_sum2_pre
          FOREACH armr003_x01_sum2_curs INTO l_sfba016,l_sfba014
             IF STATUS THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = 'foreach:'
                LET g_errparam.code   = STATUS
                LET g_errparam.popup  = TRUE
                CALL cl_err()
                LET g_rep_success = 'N'
                EXIT FOREACH
             END IF
             #统一换算成料件主档的生产单位数量
             IF NOT cl_null(sr.l_imae081) AND NOT cl_null(l_sfba014) THEN
                CALL s_aimi190_get_convert(sr.sfba006,l_sfba014,sr.l_imae081) RETURNING l_success,l_rate 
                IF NOT l_success THEN
                   LET l_rate = 1
                END IF
             ELSE 
                LET l_rate = 1
             END IF
             LET sr.l_sum2 = sr.l_sum2 + l_sfba016 * l_rate
             LET l_rate = 0
          END FOREACH
       ELSE 
          IF cl_null(sr.l_imaa009) THEN
             CONTINUE FOREACH
          END IF
       END IF
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.l_imaa009,sr.l_imaa009_desc,sr.sfba006,sr.l_imaal003_1,sr.l_imaal004_1,sr.sfaa010,sr.l_imaal003_2,sr.l_imaal004_2,sr.l_sum1,sr.l_sum2,sr.l_imae016,sr.l_imae081
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "armr003_x01_execute"
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
 
{<section id="armr003_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION armr003_x01_rep_data()
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
 
{<section id="armr003_x01.other_function" readonly="Y" >}

 
{</section>}
 
