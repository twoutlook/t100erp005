#該程式未解開Section, 採用最新樣板產出!
{<section id="ainr110_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2014-08-07 00:00:00), PR版次:0001(2014-12-10 16:26:19)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000078
#+ Filename...: ainr110_x01
#+ Description: ...
#+ Creator....: 05423(2014-08-07 10:15:27)
#+ Modifier...: 05423 -SD/PR- 05423
 
{</section>}
 
{<section id="ainr110_x01.global" readonly="Y" >}
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
 
{<section id="ainr110_x01.main" readonly="Y" >}
PUBLIC FUNCTION ainr110_x01(p_arg1)
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
   LET g_rep_code = "ainr110_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL ainr110_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL ainr110_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL ainr110_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL ainr110_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL ainr110_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="ainr110_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION ainr110_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "imaa_t_imaa009.imaa_t.imaa009,l_rtaxl003_desc.type_t.chr30,inai001.inai_t.inai001,imaal_t_imaal003.imaal_t.imaal003,imaal_t_imaal004.imaal_t.imaal004,inai002.inai_t.inai002,inai003.inai_t.inai003,l_inai004_inayl003.type_t.chr30,l_inai005_inab003.type_t.chr30,inai006.inai_t.inai006,inai007.inai_t.inai007,inai008.inai_t.inai008,inai009.inai_t.inai009,inai010.inai_t.inai010,inae_t_inae011.inae_t.inae011" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="ainr110_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION ainr110_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?)"
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
 
{<section id="ainr110_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION ainr110_x01_sel_prep()
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
   LET g_select = " SELECT DISTINCT imaa_t.imaa009,rtaxl_t.rtaxl003,inai001,imaal_t.imaal003,imaal_t.imaal004,inai002,inai003, 
       trim(inai004)||'.'||trim(inayl003),trim(inai005)||'.'||trim(inab_t.inab003),inai006,inai007,inai008, 
       inai009,inai010,inae_t.inae011"
#   #end add-point
#   LET g_select = " SELECT imaa_t.imaa009,NULL,inai001,imaal_t.imaal003,imaal_t.imaal004,inai002,inai003, 
#       trim(inai004)||'.'||trim(inayl_t.inayl003),trim(inai005)||'.'||trim(inab003),inai006,inai007, 
#       inai008,inai009,inai010,inae_t.inae011"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
    LET g_from = " FROM inai_t LEFT OUTER JOIN inayl_t ON inai_t.inai004 = inayl_t.inayl001 AND inaient = inaylent AND inayl002 = '",g_dlang,"'
                               LEFT OUTER JOIN inab_t ON inai_t.inai005 = inab_t.inab002 AND inai004 = inab001 AND inaient = inabent AND inaisite = inabsite
                               LEFT OUTER JOIN inae_t ON inai_t.inai001 = inae_t.inae001 AND inai002 = inae002 AND inai007 = inae003 AND inai008 = inae004 AND inaient =inaeent AND inaisite = inaesite
                               LEFT OUTER JOIN imaa_t ON inai_t.inai001 = imaa_t.imaa001 AND inaient = imaaent
                               LEFT OUTER JOIN imaal_t ON inai_t.inai001 = imaal_t.imaal001 AND inaient = imaalent AND imaal002 = '",g_dlang,"'
                               LEFT OUTER JOIN rtaxl_t ON inai_t.inaient = rtaxl_t.rtaxlent AND imaa_t.imaa009 = rtaxl_t.rtaxl001 AND rtaxl002 = '",g_dlang,"'"
#   #end add-point
#    LET g_from = " FROM inai_t,inab_t,inae_t,imaa_t,imaal_t,rtaxl_t,inayl_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE inai_t.inai010 <> '0' AND " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("inai_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE ainr110_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE ainr110_x01_curs CURSOR FOR ainr110_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="ainr110_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION ainr110_x01_ins_data()
DEFINE sr RECORD 
   imaa_t_imaa009 LIKE imaa_t.imaa009, 
   l_rtaxl003_desc LIKE type_t.chr30, 
   inai001 LIKE inai_t.inai001, 
   imaal_t_imaal003 LIKE imaal_t.imaal003, 
   imaal_t_imaal004 LIKE imaal_t.imaal004, 
   inai002 LIKE inai_t.inai002, 
   inai003 LIKE inai_t.inai003, 
   l_inai004_inayl003 LIKE type_t.chr30, 
   l_inai005_inab003 LIKE type_t.chr30, 
   inai006 LIKE inai_t.inai006, 
   inai007 LIKE inai_t.inai007, 
   inai008 LIKE inai_t.inai008, 
   inai009 LIKE inai_t.inai009, 
   inai010 LIKE inai_t.inai010, 
   inae_t_inae011 LIKE inae_t.inae011
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH ainr110_x01_curs INTO sr.*                               
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
       
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.imaa_t_imaa009,sr.l_rtaxl003_desc,sr.inai001,sr.imaal_t_imaal003,sr.imaal_t_imaal004,sr.inai002,sr.inai003,sr.l_inai004_inayl003,sr.l_inai005_inab003,sr.inai006,sr.inai007,sr.inai008,sr.inai009,sr.inai010,sr.inae_t_inae011
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "ainr110_x01_execute"
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
 
{<section id="ainr110_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION ainr110_x01_rep_data()
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
 
{<section id="ainr110_x01.other_function" readonly="Y" >}

 
{</section>}
 
