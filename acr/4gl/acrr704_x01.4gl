#該程式未解開Section, 採用最新樣板產出!
{<section id="acrr704_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2016-02-22 10:25:27), PR版次:0001(2016-02-23 14:02:56)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000072
#+ Filename...: acrr704_x01
#+ Description: ...
#+ Creator....: 03247(2014-09-04 11:02:36)
#+ Modifier...: 03247 -SD/PR- 03247
 
{</section>}
 
{<section id="acrr704_x01.global" readonly="Y" >}
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
       sdate LIKE craa_t.craa024,         #input condition 
       edate LIKE craa_t.craa024          #input condition
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="acrr704_x01.main" readonly="Y" >}
PUBLIC FUNCTION acrr704_x01(p_arg1,p_arg2,p_arg3)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE craa_t.craa024         #tm.sdate  input condition 
DEFINE  p_arg3 LIKE craa_t.craa024         #tm.edate  input condition
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.sdate = p_arg2
   LET tm.edate = p_arg3
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "acrr704_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL acrr704_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL acrr704_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL acrr704_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL acrr704_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL acrr704_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="acrr704_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION acrr704_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "l_clerk.type_t.chr500,craa024_1.type_t.dat,l_customer.type_t.chr500,l_level.type_t.chr500,craa024.craa_t.craa024,craa025.craa_t.craa025,oofa_t_oofa011.oofa_t.oofa011,oofc_t_oofc014.oofc_t.oofc014" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="acrr704_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION acrr704_x01_ins_prep()
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
 
{<section id="acrr704_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION acrr704_x01_sel_prep()
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
   
   #end add-point
   LET g_select = " SELECT craa021,ooag_t.ooag011,NULL,NULL,craa001,craal004,NULL,craa016,oocql_t.oocql004, 
       NULL,craa024,craa025,oofa_t.oofa011,oofc_t.oofc014,oocq_t.oocq011,oocq_t.oocq012,oocq_t.oocq013, 
       craa022"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_select = " SELECT craa021,ooag_t.ooag011,NULL,NULL,craa001,craal004,NULL,craa016,oocql_t.oocql004, 
       NULL,craa024,craa025,pmaj_t.pmaj012,oofc_t.oofc014,oocq_t.oocq011,oocq_t.oocq012,oocq_t.oocq013, 
       craa022"
   #end add-point
    LET g_from = " FROM craa_t,craal_t,ooag_t,oocq_t,oocql_t,oofa_t,oofc_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET g_from = " FROM craa_t LEFT OUTER JOIN craal_t ON craaent = craalent AND craa001 = craal001 AND craal002 = '",g_dlang,"' ",
                "             LEFT OUTER JOIN ooag_t ON craaent = ooagent AND craa021 = ooag001 ",
                "             LEFT OUTER JOIN ooeg_t ON ooagent = ooegent AND ooag003 = ooeg001 ",
                "             LEFT OUTER JOIN oocq_t ON craaent = oocqent AND oocq001 = '2105' AND craa016 = oocq002 ",
                "             LEFT OUTER JOIN oocql_t ON craaent = oocqlent AND oocql001 = '2105' AND craa016 = oocql002 AND oocql003 = '",g_dlang,"' ",
                #"             LEFT OUTER JOIN oofa_t ON craaent = oofaent AND craa001 = oofa003 AND oofa002 = '4' ",
                "             LEFT OUTER JOIN pmaj_t ON pmajent = craaent AND pmaj001 = craa001 AND pmaj004 = 'Y' ",
                "             LEFT OUTER JOIN oofc_t ON craaent = oofcent AND craa013 = oofc002 AND oofc008 = '1' AND oofc010 = 'Y' AND oofcstus='Y' "
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   LET g_where = g_where," AND craaent='",g_enterprise,"' ",
                             " AND craa032 = '1' "
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("craa_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = g_sql CLIPPED," ORDER BY craa021,craa001 "
   #end add-point
   PREPARE acrr704_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE acrr704_x01_curs CURSOR FOR acrr704_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="acrr704_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION acrr704_x01_ins_data()
DEFINE sr RECORD 
   craa021 LIKE craa_t.craa021, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   l_clerk LIKE type_t.chr500, 
   craa024_1 LIKE type_t.dat, 
   craa001 LIKE craa_t.craa001, 
   craal004 LIKE craal_t.craal004, 
   l_customer LIKE type_t.chr500, 
   craa016 LIKE craa_t.craa016, 
   oocql_t_oocql004 LIKE oocql_t.oocql004, 
   l_level LIKE type_t.chr500, 
   craa024 LIKE craa_t.craa024, 
   craa025 LIKE craa_t.craa025, 
   oofa_t_oofa011 LIKE oofa_t.oofa011, 
   oofc_t_oofc014 LIKE oofc_t.oofc014, 
   oocq_t_oocq011 LIKE oocq_t.oocq011, 
   oocq_t_oocq012 LIKE oocq_t.oocq012, 
   oocq_t_oocq013 LIKE oocq_t.oocq013, 
   craa022 LIKE craa_t.craa022
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE i      LIKE type_t.num5
DEFINE l_n    LIKE type_t.num5
DEFINE l_craa024  LIKE craa_t.craa024
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH acrr704_x01_curs INTO sr.*                               
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
       IF cl_null(sr.ooag_t_ooag011) THEN
          LET sr.ooag_t_ooag011 = ' '
       END IF
       IF cl_null(sr.craal004) THEN
          LET sr.craal004 = ' '
       END IF
       IF cl_null(sr.oocql_t_oocql004) THEN
          LET sr.oocql_t_oocql004 = ' '
       END IF
       
       LET sr.l_clerk = sr.craa021||'.'||sr.ooag_t_ooag011
       LET sr.l_customer = sr.craa001||'.'||sr.craal004
       LET sr.l_level = sr.craa016||'.'||sr.oocql_t_oocql004
       LET i = 0
       IF cl_null(sr.oocq_t_oocq011) THEN
          LET sr.oocq_t_oocq011 = 0
       END IF
       IF cl_null(sr.oocq_t_oocq012) THEN
          LET sr.oocq_t_oocq012 = 0
       END IF
       IF cl_null(sr.oocq_t_oocq013) THEN
          LET sr.oocq_t_oocq013 = 0
       END IF
       #IF sr.oocq_t_oocq013 > 0 THEN
       #   LET l_n = (sr.oocq_t_oocq011*30+sr.oocq_t_oocq012)/sr.oocq_t_oocq013
       #ELSE
       #   LET l_n = 1
       #END IF
       IF cl_null(sr.craa024) THEN
          LET l_craa024 = sr.craa022
       ELSE
          LET l_craa024 = sr.craa024 + 1
       END IF
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       #IF NOT cl_null(sr.craa024) THEN
       #   LET i = 1
       #END IF
       WHILE TRUE
          #LET i = i+1
          #LET sr.craa024_1 = sr.craa024 + l_n*i
          IF sr.oocq_t_oocq013 > 0 THEN
             LET sr.craa024_1 = l_craa024 + (((sr.oocq_t_oocq011*30+sr.oocq_t_oocq012)*i)/sr.oocq_t_oocq013)
          ELSE
             LET sr.craa024_1 = tm.edate + 1
          END IF
          LET i = i+1
          IF NOT cl_null(sr.craa024) THEN
             IF sr.craa024_1 = sr.craa024 THEN
                CONTINUE WHILE
             END IF
          END IF
          IF sr.craa024_1 >= tm.sdate AND sr.craa024_1 <= tm.edate THEN
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.l_clerk,sr.craa024_1,sr.l_customer,sr.l_level,sr.craa024,sr.craa025,sr.oofa_t_oofa011,sr.oofc_t_oofc014
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "acrr704_x01_execute"
          LET g_errparam.code   = SQLCA.sqlcode
          LET g_errparam.popup  = FALSE
          CALL cl_err()       
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF
 
       #add-point:ins_data段after_save name="ins_data.after.save"
             #EXIT WHILE
          ELSE
             #IF sr.craa024_1 > tm.edate OR (l_n = 0 AND (sr.craa024 < tm.sdate OR sr.craa024 > tm.edate)) THEN
             IF sr.craa024_1 > tm.edate THEN
                EXIT WHILE
             END IF
          END IF
       END WHILE
       #end add-point
       
    END FOREACH
    
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="acrr704_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION acrr704_x01_rep_data()
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
 
{<section id="acrr704_x01.other_function" readonly="Y" >}

 
{</section>}
 
