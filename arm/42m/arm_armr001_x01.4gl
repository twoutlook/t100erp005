#該程式未解開Section, 採用最新樣板產出!
{<section id="armr001_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2015-08-15 16:23:18), PR版次:0001(2015-08-15 16:21:02)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000045
#+ Filename...: armr001_x01
#+ Description: ...
#+ Creator....: 05423(2015-06-05 17:03:32)
#+ Modifier...: 05423 -SD/PR- 05423
 
{</section>}
 
{<section id="armr001_x01.global" readonly="Y" >}
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
 
{<section id="armr001_x01.main" readonly="Y" >}
PUBLIC FUNCTION armr001_x01(p_arg1)
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
   LET g_rep_code = "armr001_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL armr001_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL armr001_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL armr001_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL armr001_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL armr001_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="armr001_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION armr001_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "rmaadocno.rmaa_t.rmaadocno,rmaadocdt.rmaa_t.rmaadocdt,rmaa001.rmaa_t.rmaa001,l_rmaa001_desc.pmaal_t.pmaal004,rmaa002.rmaa_t.rmaa002,l_rmaa002_desc.ooag_t.ooag011,rmaa003.rmaa_t.rmaa003,l_rmaa003_desc.ooefl_t.ooefl003,rmaa007.rmaa_t.rmaa007,rmabseq.rmab_t.rmabseq,rmab003.rmab_t.rmab003,rmab004.rmab_t.rmab004,rmab005.rmab_t.rmab005,rmab006.rmab_t.rmab006,rmab009.rmab_t.rmab009,l_imaal003.imaal_t.imaal003,l_imaal004.imaal_t.imaal004,rmab010.rmab_t.rmab010,l_rmab010_desc.oocql_t.oocql004,rmab011.rmab_t.rmab011,rmab012.rmab_t.rmab012,rmab013.rmab_t.rmab013,rmab014.rmab_t.rmab014,rmab015.rmab_t.rmab015,rmab016.rmab_t.rmab016,rmab017.rmab_t.rmab017,rmaa004.rmaa_t.rmaa004,rmaa005.rmaa_t.rmaa005,rmaa006.rmaa_t.rmaa006,rmaa008.rmaa_t.rmaa008,rmaastus.rmaa_t.rmaastus,rmab001.rmab_t.rmab001,rmab002.rmab_t.rmab002,rmab007.rmab_t.rmab007,rmab008.rmab_t.rmab008,l_rmaa001_ref.type_t.chr50,l_rmaa002_ref.type_t.chr30,l_rmaa003_ref.type_t.chr30,l_rmaadocno_desc.type_t.chr100,l_rmaastus_desc.type_t.chr30,l_rmaa004_desc.type_t.chr100,l_rmaa005_desc.type_t.chr100,l_rmaa006_desc.type_t.chr100,l_rmab001_desc.type_t.chr100,l_rmab003_desc.type_t.chr100,l_rmab005_desc.type_t.chr100,l_imaa127_desc.type_t.chr30,l_rmaadocnodesc.type_t.chr200,l_rmaastusdesc.type_t.chr50,l_rmaa004desc.type_t.chr200,l_rmaa005desc.type_t.chr200,l_rmaa006desc.type_t.chr200,l_rmab001desc.type_t.chr200,l_rmab003desc.type_t.chr200,l_rmab005desc.type_t.chr200,l_rmab010desc.type_t.chr200,l_imaa127desc.type_t.chr50" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="armr001_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION armr001_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?, 
             ?,?,?,?,?,?,?)"
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
 
{<section id="armr001_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION armr001_x01_sel_prep()
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
   LET g_select = " SELECT rmaadocno,rmaadocdt,rmaa001,trim(rmaa001)||'.'||trim(pmaal003),rmaa002,trim(rmaa002)||'.'||trim(ooag011),",
                  " rmaa003,trim(rmaa003)||'.'||trim(ooefl003),rmaa007,rmabseq, ",
                  " rmab003,rmab004,rmab005,rmab006,rmab009,imaal003,imaal004,rmab010,NULL,rmab011,rmab012,rmab013,rmab014, ",
                  " rmab015,rmab016,rmab017,rmaa004,rmaa005,rmaa006,rmaa008,rmaastus,rmab001,rmab002,rmab007,rmab008, ", 
                  " NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, ", 
                  " NULL "
#   #end add-point
#   LET g_select = " SELECT rmaadocno,rmaadocdt,rmaa001,NULL,rmaa002,NULL,rmaa003,NULL,rmaa007,rmabseq, 
#       rmab003,rmab004,rmab005,rmab006,rmab009,NULL,NULL,rmab010,NULL,rmab011,rmab012,rmab013,rmab014, 
#       rmab015,rmab016,rmab017,rmaa004,rmaa005,rmaa006,rmaa008,rmaastus,rmab001,rmab002,rmab007,rmab008, 
#       NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 
#       NULL,NULL,NULL"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_from = " FROM rmaa_t LEFT OUTER JOIN rmab_t ON rmabdocno = rmaadocno AND rmabent = rmaaent AND rmabsite = rmaasite ",
                "             LEFT OUTER JOIN pmaal_t ON rmaa001 = pmaal001 AND rmaaent = pmaalent AND pmaal002 = '",g_dlang,"' ",
                "             LEFT OUTER JOIN ooag_t ON rmaa002 = ooag001 AND rmaaent = ooagent ",
                "             LEFT OUTER JOIN ooefl_t ON rmaa003 = ooefl001 AND rmaaent = ooeflent AND ooefl002 = '",g_dlang,"' ",
                "             LEFT OUTER JOIN imaal_t ON imaal001 = rmab009 AND imaalent = rmabent AND imaal002 = '",g_dlang,"' "
#   #end add-point
#    LET g_from = " FROM rmaa_t,rmab_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("rmaa_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE armr001_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE armr001_x01_curs CURSOR FOR armr001_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="armr001_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION armr001_x01_ins_data()
DEFINE sr RECORD 
   rmaadocno LIKE rmaa_t.rmaadocno, 
   rmaadocdt LIKE rmaa_t.rmaadocdt, 
   rmaa001 LIKE rmaa_t.rmaa001, 
   l_rmaa001_desc LIKE pmaal_t.pmaal004, 
   rmaa002 LIKE rmaa_t.rmaa002, 
   l_rmaa002_desc LIKE ooag_t.ooag011, 
   rmaa003 LIKE rmaa_t.rmaa003, 
   l_rmaa003_desc LIKE ooefl_t.ooefl003, 
   rmaa007 LIKE rmaa_t.rmaa007, 
   rmabseq LIKE rmab_t.rmabseq, 
   rmab003 LIKE rmab_t.rmab003, 
   rmab004 LIKE rmab_t.rmab004, 
   rmab005 LIKE rmab_t.rmab005, 
   rmab006 LIKE rmab_t.rmab006, 
   rmab009 LIKE rmab_t.rmab009, 
   l_imaal003 LIKE imaal_t.imaal003, 
   l_imaal004 LIKE imaal_t.imaal004, 
   rmab010 LIKE rmab_t.rmab010, 
   l_rmab010_desc LIKE oocql_t.oocql004, 
   rmab011 LIKE rmab_t.rmab011, 
   rmab012 LIKE rmab_t.rmab012, 
   rmab013 LIKE rmab_t.rmab013, 
   rmab014 LIKE rmab_t.rmab014, 
   rmab015 LIKE rmab_t.rmab015, 
   rmab016 LIKE rmab_t.rmab016, 
   rmab017 LIKE rmab_t.rmab017, 
   rmaa004 LIKE rmaa_t.rmaa004, 
   rmaa005 LIKE rmaa_t.rmaa005, 
   rmaa006 LIKE rmaa_t.rmaa006, 
   rmaa008 LIKE rmaa_t.rmaa008, 
   rmaastus LIKE rmaa_t.rmaastus, 
   rmab001 LIKE rmab_t.rmab001, 
   rmab002 LIKE rmab_t.rmab002, 
   rmab007 LIKE rmab_t.rmab007, 
   rmab008 LIKE rmab_t.rmab008, 
   l_rmaa001_ref LIKE type_t.chr50, 
   l_rmaa002_ref LIKE type_t.chr30, 
   l_rmaa003_ref LIKE type_t.chr30, 
   l_rmaadocno_desc LIKE type_t.chr100, 
   l_rmaastus_desc LIKE type_t.chr30, 
   l_rmaa004_desc LIKE type_t.chr100, 
   l_rmaa005_desc LIKE type_t.chr100, 
   l_rmaa006_desc LIKE type_t.chr100, 
   l_rmab001_desc LIKE type_t.chr100, 
   l_rmab003_desc LIKE type_t.chr100, 
   l_rmab005_desc LIKE type_t.chr100, 
   l_imaa127_desc LIKE type_t.chr30, 
   l_rmaadocnodesc LIKE type_t.chr200, 
   l_rmaastusdesc LIKE type_t.chr50, 
   l_rmaa004desc LIKE type_t.chr200, 
   l_rmaa005desc LIKE type_t.chr200, 
   l_rmaa006desc LIKE type_t.chr200, 
   l_rmab001desc LIKE type_t.chr200, 
   l_rmab003desc LIKE type_t.chr200, 
   l_rmab005desc LIKE type_t.chr200, 
   l_rmab010desc LIKE type_t.chr200, 
   l_imaa127desc LIKE type_t.chr50
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_success              LIKE type_t.num5

DEFINE l_imaa127              LIKE imaa_t.imaa127
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH armr001_x01_curs INTO sr.*                               
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
       IF NOT cl_null(sr.rmab010) AND NOT cl_null(sr.rmab009) THEN
          CALL s_feature_description(sr.rmab009,sr.rmab010) 
               RETURNING l_success,sr.l_rmab010_desc 
       END IF
       IF sr.l_rmaa001_desc = '.' THEN
          LET sr.l_rmaa001_desc = NULL
       END IF
       IF sr.l_rmaa002_desc = '.' THEN
          LET sr.l_rmaa002_desc = NULL
       END IF
       IF sr.l_rmaa003_desc = '.' THEN
          LET sr.l_rmaa003_desc = NULL
       END IF
       #dorislai-20150815-add----(S)
       #====單頭====
       #客戶編號說明	l_rmaa001_ref
       LET sr.l_rmaa001_ref = ''
       CALL s_desc_get_trading_partner_abbr_desc(sr.rmaa001) RETURNING sr.l_rmaa001_ref
       #業務人員說明	l_rmaa002_ref
       LET sr.l_rmaa002_ref = ''
       CALL s_desc_get_person_desc(sr.rmaa002) RETURNING sr.l_rmaa002_ref
       #業務部門說明	l_rmaa003_ref
       LET sr.l_rmaa003_ref = ''
       CALL s_desc_get_department_desc(sr.rmaa003) RETURNING sr.l_rmaa003_ref
       #RMA單號全名	l_rmaadocnodesc
       LET sr.l_rmaadocno_desc = ''
       LET sr.l_rmaadocnodesc = ''
       CALL s_aooi200_get_slip_desc(sr.rmaadocno) RETURNING sr.l_rmaadocno_desc
       IF NOT cl_null(sr.l_rmaadocno_desc) THEN
          LET sr.l_rmaadocnodesc = sr.rmaadocno,'.',sr.l_rmaadocno_desc
       END IF
       #狀態碼全名	l_rmaastusdesc
       LET sr.l_rmaastus_desc = ''
       LET sr.l_rmaastusdesc = ''
       CALL s_desc_gzcbl004_desc('13',sr.rmaastus) RETURNING sr.l_rmaastus_desc
       IF NOT cl_null(sr.l_rmaastus_desc) THEN
          LET sr.l_rmaastusdesc = sr.rmaastus,'.',sr.l_rmaastus_desc
       END IF
       #====基本資料====
       #客訴單號全名	l_rmaa004desc
       LET sr.l_rmaa004_desc = ''
       LET sr.l_rmaa004desc = ''
       CALL s_aooi200_get_slip_desc(sr.rmaa004) RETURNING sr.l_rmaa004_desc
       IF NOT cl_null(sr.l_rmaa004_desc) THEN
          LET sr.l_rmaa004desc = sr.rmaa004,'.',sr.l_rmaa004_desc
       END IF
       #出貨單號全名	l_rmaa005desc
       LET sr.l_rmaa005_desc = ''
       LET sr.l_rmaa005desc = ''
       CALL s_aooi200_get_slip_desc(sr.rmaa005) RETURNING sr.l_rmaa005_desc
       IF NOT cl_null(sr.l_rmaa005_desc) THEN
          LET sr.l_rmaa005desc = sr.rmaa005,'.',sr.l_rmaa005_desc
       END IF
       #訂單單號全名	l_rmaa006desc
       LET sr.l_rmaa006_desc = ''
       LET sr.l_rmaa006desc = ''
       CALL s_aooi200_get_slip_desc(sr.rmaa006) RETURNING sr.l_rmaa006_desc
       IF NOT cl_null(sr.l_rmaa006_desc) THEN
          LET sr.l_rmaa006desc = sr.rmaa006,'.',sr.l_rmaa006_desc
       END IF
       #====退品明細====
       #客訴單號全名	l_rmab001desc
       LET sr.l_rmab001_desc = ''
       LET sr.l_rmab001desc = ''
       CALL s_aooi200_get_slip_desc(sr.rmab001) RETURNING sr.l_rmab001_desc
       IF NOT cl_null(sr.l_rmab001_desc) THEN
          LET sr.l_rmab001desc = sr.rmab001,'.',sr.l_rmab001_desc
       END IF
       #出貨單號全名	l_rmab003desc
       LET sr.l_rmab003_desc = ''
       LET sr.l_rmab003desc = ''
       CALL s_aooi200_get_slip_desc(sr.rmab003) RETURNING sr.l_rmab003_desc
       IF NOT cl_null(sr.l_rmab003_desc) THEN
          LET sr.l_rmab003desc = sr.rmab003,'.',sr.l_rmab003_desc
       END IF
       #訂單單號全名	l_rmab005desc
       LET sr.l_rmab005_desc = ''
       LET sr.l_rmab005desc = ''
       CALL s_aooi200_get_slip_desc(sr.rmab005) RETURNING sr.l_rmab005_desc
       IF NOT cl_null(sr.l_rmab005_desc) THEN
          LET sr.l_rmab005desc = sr.rmab005,'.',sr.l_rmab005_desc
       END IF
       #產品特徵全名 	l_rmab010desc 組全名即可
       LET sr.l_rmab010desc = ''
       IF NOT cl_null(sr.l_rmab010_desc) THEN
          LET sr.l_rmab010desc = sr.rmab010,'.',sr.l_rmab010_desc
       END IF
       #系列全名 l_imaa127desc
       LET sr.l_imaa127_desc = ''
       LET sr.l_imaa127desc = ''
          #用料號抓取系列
       SELECT imaa127 INTO l_imaa127 FROM imaa_t
        WHERE imaa001 = sr.rmab009
          AND imaaent = g_enterprise
         #抓取系列說明
       CALL s_desc_get_acc_desc('2003',l_imaa127)  RETURNING sr.l_imaa127_desc 
       IF NOT cl_null(sr.l_imaa127_desc) THEN
          LET sr.l_imaa127desc = l_imaa127,'.',sr.l_imaa127_desc
       END IF
       #dorislai-20150815-add----(E)
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.rmaadocno,sr.rmaadocdt,sr.rmaa001,sr.l_rmaa001_desc,sr.rmaa002,sr.l_rmaa002_desc,sr.rmaa003,sr.l_rmaa003_desc,sr.rmaa007,sr.rmabseq,sr.rmab003,sr.rmab004,sr.rmab005,sr.rmab006,sr.rmab009,sr.l_imaal003,sr.l_imaal004,sr.rmab010,sr.l_rmab010_desc,sr.rmab011,sr.rmab012,sr.rmab013,sr.rmab014,sr.rmab015,sr.rmab016,sr.rmab017,sr.rmaa004,sr.rmaa005,sr.rmaa006,sr.rmaa008,sr.rmaastus,sr.rmab001,sr.rmab002,sr.rmab007,sr.rmab008,sr.l_rmaa001_ref,sr.l_rmaa002_ref,sr.l_rmaa003_ref,sr.l_rmaadocno_desc,sr.l_rmaastus_desc,sr.l_rmaa004_desc,sr.l_rmaa005_desc,sr.l_rmaa006_desc,sr.l_rmab001_desc,sr.l_rmab003_desc,sr.l_rmab005_desc,sr.l_imaa127_desc,sr.l_rmaadocnodesc,sr.l_rmaastusdesc,sr.l_rmaa004desc,sr.l_rmaa005desc,sr.l_rmaa006desc,sr.l_rmab001desc,sr.l_rmab003desc,sr.l_rmab005desc,sr.l_rmab010desc,sr.l_imaa127desc
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "armr001_x01_execute"
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
 
{<section id="armr001_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION armr001_x01_rep_data()
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
 
{<section id="armr001_x01.other_function" readonly="Y" >}

 
{</section>}
 
