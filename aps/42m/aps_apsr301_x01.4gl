#該程式未解開Section, 採用最新樣板產出!
{<section id="apsr301_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2015-08-21 17:35:48), PR版次:0001(2015-08-21 17:41:26)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000035
#+ Filename...: apsr301_x01
#+ Description: ...
#+ Creator....: 05384(2015-08-21 15:07:27)
#+ Modifier...: 05384 -SD/PR- 05384
 
{</section>}
 
{<section id="apsr301_x01.global" readonly="Y" >}
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
 
{<section id="apsr301_x01.main" readonly="Y" >}
PUBLIC FUNCTION apsr301_x01(p_arg1)
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
   LET g_rep_code = "apsr301_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL apsr301_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL apsr301_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL apsr301_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL apsr301_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL apsr301_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="apsr301_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION apsr301_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "psaadocno.psaa_t.psaadocno,psaadocdt.psaa_t.psaadocdt,psaa001.psaa_t.psaa001,ooag_t_ooag011.ooag_t.ooag011,psaa002.psaa_t.psaa002,ooefl_t_ooefl003.ooefl_t.ooefl003,psaa003.psaa_t.psaa003,l_psaastus_desc.gzcbl_t.gzcbl004,psabseq.psab_t.psabseq,psab001.psab_t.psab001,x_imaal_t_imaal003.imaal_t.imaal003,x_imaal_t_imaal004.imaal_t.imaal004,psab002.psab_t.psab002,l_psab002_desc.type_t.chr1000,psab003.psab_t.psab003,psab004.psab_t.psab004,psab005.psab_t.psab005,psab006.psab_t.psab006,l_psab005_psab006.psab_t.psab005,psab007.psab_t.psab007,psab008.psab_t.psab008,psab009.psab_t.psab009" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="apsr301_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION apsr301_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="apsr301_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apsr301_x01_sel_prep()
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
   LET g_select = " SELECT psaaent,psaasite,psaadocno,psaadocdt,psaa001,( SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = psaa_t.psaa001 AND ooag_t.ooagent = psaa_t.psaaent), 
       psaa002,( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = psaa_t.psaa002 AND ooefl_t.ooeflent = psaa_t.psaaent AND ooefl_t.ooefl002 = '" , 
       g_dlang,"'" ,"),psaa003,psaastus,'',psabseq,psab001,x.imaal_t_imaal003,x.imaal_t_imaal004,psab002, 
       '',psab003,psab004,psab005,psab006,'',psab007,psab008,psab009,psabsite,x.t1_imaal003,trim(psaa001)||'.'||trim((SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = psaa_t.psaa001 AND ooag_t.ooagent = psaa_t.psaaent)), 
       trim(psaa002)||'.'||trim((SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = psaa_t.psaa002 AND ooefl_t.ooeflent = psaa_t.psaaent AND ooefl_t.ooefl002 = '" , 
       g_dlang,"'" ,"))"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   
   #end add-point
    LET g_from = " FROM psaa_t LEFT OUTER JOIN ( SELECT psab_t.*,( SELECT imaal003 FROM imaal_t WHERE imaal_t.imaal001 = psab_t.psab001 AND imaal_t.imaalent = psab_t.psabent AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,") imaal_t_imaal003,( SELECT imaal004 FROM imaal_t WHERE imaal_t.imaal001 = psab_t.psab001 AND imaal_t.imaalent = psab_t.psabent AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,") imaal_t_imaal004,( SELECT imaal003 FROM imaal_t t1 WHERE t1.imaalent = psab_t.psabent AND t1.imaal001 = psab_t.psab001 AND t1.imaal002 = '" , 
        g_dlang,"'" ,") t1_imaal003 FROM psab_t ) x  ON psaa_t.psaaent = x.psabent AND psaa_t.psaadocno  
        = x.psabdocno"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("psaa_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE apsr301_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE apsr301_x01_curs CURSOR FOR apsr301_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="apsr301_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION apsr301_x01_ins_data()
DEFINE sr RECORD 
   psaaent LIKE psaa_t.psaaent, 
   psaasite LIKE psaa_t.psaasite, 
   psaadocno LIKE psaa_t.psaadocno, 
   psaadocdt LIKE psaa_t.psaadocdt, 
   psaa001 LIKE psaa_t.psaa001, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   psaa002 LIKE psaa_t.psaa002, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   psaa003 LIKE psaa_t.psaa003, 
   psaastus LIKE psaa_t.psaastus, 
   l_psaastus_desc LIKE gzcbl_t.gzcbl004, 
   psabseq LIKE psab_t.psabseq, 
   psab001 LIKE psab_t.psab001, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   x_imaal_t_imaal004 LIKE imaal_t.imaal004, 
   psab002 LIKE psab_t.psab002, 
   l_psab002_desc LIKE type_t.chr1000, 
   psab003 LIKE psab_t.psab003, 
   psab004 LIKE psab_t.psab004, 
   psab005 LIKE psab_t.psab005, 
   psab006 LIKE psab_t.psab006, 
   l_psab005_psab006 LIKE psab_t.psab005, 
   psab007 LIKE psab_t.psab007, 
   psab008 LIKE psab_t.psab008, 
   psab009 LIKE psab_t.psab009, 
   psabsite LIKE psab_t.psabsite, 
   x_t1_imaal003 LIKE imaal_t.imaal003, 
   l_psaa001_ooag011 LIKE type_t.chr300, 
   l_psaa002_ooefl003 LIKE type_t.chr1000
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_success  LIKE type_t.num5
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH apsr301_x01_curs INTO sr.*                               
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
       #狀態
       CALL s_desc_gzcbl004_desc('13',sr.psaastus) RETURNING sr.l_psaastus_desc
       #產品特徵
       CALL s_feature_description(sr.psab001,sr.psab002) RETURNING l_success,sr.l_psab002_desc
       IF NOT l_success THEN
          LET sr.l_psab002_desc = ''
       END IF
       #淨需求量
       IF cl_null(sr.psab005) THEN  LET sr.psab005 = 0   END IF
       IF cl_null(sr.psab006) THEN  LET sr.psab005 = 0   END IF
       LET sr.l_psab005_psab006 = sr.psab005 - sr.psab006
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.psaadocno,sr.psaadocdt,sr.psaa001,sr.ooag_t_ooag011,sr.psaa002,sr.ooefl_t_ooefl003,sr.psaa003,sr.l_psaastus_desc,sr.psabseq,sr.psab001,sr.x_imaal_t_imaal003,sr.x_imaal_t_imaal004,sr.psab002,sr.l_psab002_desc,sr.psab003,sr.psab004,sr.psab005,sr.psab006,sr.l_psab005_psab006,sr.psab007,sr.psab008,sr.psab009
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "apsr301_x01_execute"
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
 
{<section id="apsr301_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION apsr301_x01_rep_data()
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
 
{<section id="apsr301_x01.other_function" readonly="Y" >}

 
{</section>}
 