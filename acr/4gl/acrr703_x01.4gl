#該程式未解開Section, 採用最新樣板產出!
{<section id="acrr703_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2016-02-25 16:09:28), PR版次:0001(2016-02-25 15:49:34)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000028
#+ Filename...: acrr703_x01
#+ Description: ...
#+ Creator....: 01251(2014-08-22 14:48:43)
#+ Modifier...: 01251 -SD/PR- 01251
 
{</section>}
 
{<section id="acrr703_x01.global" readonly="Y" >}
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
       wc STRING                   #查询条件
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="acrr703_x01.main" readonly="Y" >}
PUBLIC FUNCTION acrr703_x01(p_arg1)
DEFINE  p_arg1 STRING                  #tm.wc  查询条件
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
   LET g_rep_code = "acrr703_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL acrr703_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL acrr703_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL acrr703_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL acrr703_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL acrr703_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="acrr703_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION acrr703_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "l_staff.type_t.chr50,l_customers.type_t.chr30,l_source.type_t.chr30,l_regional.type_t.chr50,l_tel.type_t.chr30,l_fax.type_t.chr30,pmaj012.pmaj_t.pmaj012,l_phone.type_t.chr30,l_stus.type_t.chr30" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="acrr703_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION acrr703_x01_ins_prep()
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
             ?,?,?)"
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
 
{<section id="acrr703_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION acrr703_x01_sel_prep()
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
   LET g_select = " SELECT NULL,NULL,NULL,NULL,NULL,NULL,pmaj012,NULL,NULL"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_select = " SELECT craa021,craa001,craa014,craa017,NULL,NULL,pmaj012,NULL,craastus"
   #end add-point
    LET g_from = " FROM pmaj_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
     
  LET g_from = " FROM craa_t LEFT JOIN pmaj_t ON pmajent = craaent AND pmaj001 = craa001 AND pmaj004 = 'Y' "
                   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   LET g_where = g_where," AND craaent = ",g_enterprise
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("pmaj_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = g_sql CLIPPED," ORDER BY craa021,craa001"
  
   #end add-point
   PREPARE acrr703_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE acrr703_x01_curs CURSOR FOR acrr703_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="acrr703_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION acrr703_x01_ins_data()
DEFINE sr RECORD 
   l_staff LIKE type_t.chr50, 
   l_customers LIKE type_t.chr30, 
   l_source LIKE type_t.chr30, 
   l_regional LIKE type_t.chr50, 
   l_tel LIKE type_t.chr30, 
   l_fax LIKE type_t.chr30, 
   pmaj012 LIKE pmaj_t.pmaj012, 
   l_phone LIKE type_t.chr30, 
   l_stus LIKE type_t.chr30
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_ooag011      LIKE ooag_t.ooag011
DEFINE l_craal004     LIKE craal_t.craal004
DEFINE l_oocql004     LIKE oocql_t.oocql004
DEFINE l_dbaal003     LIKE dbaal_t.dbaal003
DEFINE l_pmaj002      LIKE pmaj_t.pmaj002
DEFINE l_craa013      LIKE craa_t.craa013
DEFINE l_gzcbl004     LIKE gzcbl_t.gzcbl004
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH acrr703_x01_curs INTO sr.*                               
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

       LET l_craa013=''
       SELECT craa013 INTO l_craa013
         FROM craa_t
        WHERE craaent=g_enterprise
          AND craa001=sr.l_customers
          
       #主要聯繫人姓名
       LET l_pmaj002=''             
       SELECT pmaj002 INTO l_pmaj002
         FROM pmaj_t
        WHERE pmajent=g_enterprise
          AND pmaj001=sr.l_customers
          AND pmaj004='Y'
          AND pmajstus='Y'
#       IF NOT cl_null(l_pmaj002) THEN
#          SELECT oofa011 INTO sr.oofa011 
#            FROM oofa_t
#            WHERE oofaent=g_enterprise 
#              AND oofa001=l_pmaj002
#       END IF    

       LET l_ooag011=''
       SELECT ooag011 INTO l_ooag011 #業務員姓名
         FROM ooag_t
        WHERE ooagent=g_enterprise
          AND ooag001=sr.l_staff
       IF NOT cl_null(l_ooag011) THEN
          LET sr.l_staff=sr.l_staff||'.'||l_ooag011
       END IF

       LET l_craal004=''
       SELECT craal004 INTO l_craal004 #潛在客戶名稱
         FROM craal_t
        WHERE craalent=g_enterprise
          AND craal001=sr.l_customers
          AND craal002=g_dlang
       IF NOT cl_null(l_craal004) THEN
          LET sr.l_customers=sr.l_customers||'.'||l_craal004
       END IF
       
       LET l_oocql004=''
       SELECT oocql004 INTO l_oocql004 #潛在客戶來源說明
         FROM oocql_t
        WHERE oocqlent=g_enterprise
          AND oocql001='2107'
          AND oocql002=sr.l_source
          AND oocql003=g_dlang 
       IF NOT cl_null(l_oocql004) THEN
          LET sr.l_source=sr.l_source||'.'||l_oocql004   
       END IF          
          
       LET l_dbaal003=''
       SELECT dbaal003 INTO l_dbaal003 #區域說明
         FROM dbaal_t
        WHERE dbaalent=g_enterprise
          AND dbaal001=sr.l_regional
          AND dbaal002=g_dlang
       IF NOT cl_null(l_dbaal003) THEN
         LET sr.l_regional=sr.l_regional||'.'||l_dbaal003
       END IF
       
       
       #公司電話、公司傳真、行動電話          
       SELECT oofc014 INTO sr.l_tel #公司電話
         FROM oofc_t
        WHERE oofcent=g_enterprise
          AND oofc002=l_craa013
          AND oofc008='1'
          AND oofc010='Y'
          AND oofcstus='Y'
          
       SELECT oofc014 INTO sr.l_fax #公司傳真
         FROM oofc_t
        WHERE oofcent=g_enterprise
          AND oofc002=l_craa013
          AND oofc008='3'
          AND oofc010='Y'
          AND oofcstus='Y'  
          
       SELECT oofc014 INTO sr.l_phone #行動電話
         FROM oofc_t
        WHERE oofcent=g_enterprise
          AND oofc002=l_craa013
          AND oofc008='2'
          AND oofc010='Y'
          AND oofcstus='Y'

       SELECT gzcbl004 INTO l_gzcbl004 #狀態碼說明
         FROM gzcbl_t
        WHERE gzcbl001='50'
          AND gzcbl002=sr.l_stus
          AND gzcbl003=g_dlang
       LET sr.l_stus=sr.l_stus||'.'||l_gzcbl004
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.l_staff,sr.l_customers,sr.l_source,sr.l_regional,sr.l_tel,sr.l_fax,sr.pmaj012,sr.l_phone,sr.l_stus
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "acrr703_x01_execute"
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
 
{<section id="acrr703_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION acrr703_x01_rep_data()
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
 
{<section id="acrr703_x01.other_function" readonly="Y" >}

 
{</section>}
 
