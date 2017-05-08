#該程式未解開Section, 採用最新樣板產出!
{<section id="anmq970_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2015-10-16 15:17:34), PR版次:0001(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000038
#+ Filename...: anmq970_x01
#+ Description: ...
#+ Creator....: 02291(2015-10-16 15:01:15)
#+ Modifier...: 02291 -SD/PR- 00000
 
{</section>}
 
{<section id="anmq970_x01.global" readonly="Y" >}
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
       wc STRING,                  #condition:where 
       a1 STRING                   #print_tmp
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_tmp_table     STRING
#end add-point
 
{</section>}
 
{<section id="anmq970_x01.main" readonly="Y" >}
PUBLIC FUNCTION anmq970_x01(p_arg1,p_arg2)
DEFINE  p_arg1 STRING                  #tm.wc  condition:where 
DEFINE  p_arg2 STRING                  #tm.a1  print_tmp
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.a1 = p_arg2
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   LET g_tmp_table = tm.a1
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "anmq970_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL anmq970_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL anmq970_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL anmq970_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL anmq970_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL anmq970_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="anmq970_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION anmq970_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "l_nmbi001_desc.type_t.chr500,l_nmbidocno.nmbi_t.nmbidocno,l_a_desc.type_t.chr500,nmbj001.nmbj_t.nmbj001,ooefl_t_ooefl003.ooefl_t.ooefl003,nmbj002.nmbj_t.nmbj002,nmbdl_t_nmbdl004.nmbdl_t.nmbdl004,nmbj003.nmbj_t.nmbj003,nmbj004.nmbj_t.nmbj004,nmbj005.nmbj_t.nmbj005,ooail_t_ooail003.ooail_t.ooail003,nmbj006.nmbj_t.nmbj006,nmbj007.nmbj_t.nmbj007,nmbj008.nmbj_t.nmbj008,l_nmbc103.type_t.num20_6,l_amt1.type_t.num20_6,l_amt2.type_t.num20_6,nmbjent.nmbj_t.nmbjent" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="anmq970_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION anmq970_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="anmq970_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION anmq970_x01_sel_prep()
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
   LET g_select = " SELECT trim(nmbj001)||'.'||trim(ooefl003),NULL,NULL,nmbj001,( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooeflent = nmbj_t.nmbjent AND ooefl_t.ooefl001 = nmbj_t.nmbj001 AND ooefl_t.ooefl002 = '" , 
       g_dlang,"'" ,"),nmbj002,( SELECT nmbdl004 FROM nmbdl_t WHERE nmbdl_t.nmbdlent = nmbj_t.nmbjent AND nmbdl_t.nmbdl001 = nmbj_t.nmbj002 AND nmbdl_t.nmbdl003 = '" , 
       g_dlang,"'" ,"),nmbj003,nmbj004,nmbj005,( SELECT ooail003 FROM ooail_t WHERE ooail_t.ooailent = nmbj_t.nmbjent AND ooail_t.ooail001 = nmbj_t.nmbj005 AND ooail_t.ooail002 = '" , 
       g_dlang,"'" ,"),nmbj006,nmbj007,nmbj008,NULL,NULL,NULL,nmbjent"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   
   #end add-point
    LET g_from = " FROM nmbj_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("nmbj_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = " SELECT * FROM ", g_tmp_table CLIPPED
   #end add-point
   PREPARE anmq970_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE anmq970_x01_curs CURSOR FOR anmq970_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="anmq970_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION anmq970_x01_ins_data()
DEFINE sr RECORD 
   l_nmbi001_desc LIKE type_t.chr500, 
   l_nmbidocno LIKE nmbi_t.nmbidocno, 
   l_a_desc LIKE type_t.chr500, 
   nmbj001 LIKE nmbj_t.nmbj001, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   nmbj002 LIKE nmbj_t.nmbj002, 
   nmbdl_t_nmbdl004 LIKE nmbdl_t.nmbdl004, 
   nmbj003 LIKE nmbj_t.nmbj003, 
   nmbj004 LIKE nmbj_t.nmbj004, 
   nmbj005 LIKE nmbj_t.nmbj005, 
   ooail_t_ooail003 LIKE ooail_t.ooail003, 
   nmbj006 LIKE nmbj_t.nmbj006, 
   nmbj007 LIKE nmbj_t.nmbj007, 
   nmbj008 LIKE nmbj_t.nmbj008, 
   l_nmbc103 LIKE type_t.num20_6, 
   l_amt1 LIKE type_t.num20_6, 
   l_amt2 LIKE type_t.num20_6, 
   nmbjent LIKE nmbj_t.nmbjent
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH anmq970_x01_curs INTO sr.*                               
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
       EXECUTE insert_prep USING sr.l_nmbi001_desc,sr.l_nmbidocno,sr.l_a_desc,sr.nmbj001,sr.ooefl_t_ooefl003,sr.nmbj002,sr.nmbdl_t_nmbdl004,sr.nmbj003,sr.nmbj004,sr.nmbj005,sr.ooail_t_ooail003,sr.nmbj006,sr.nmbj007,sr.nmbj008,sr.l_nmbc103,sr.l_amt1,sr.l_amt2,sr.nmbjent
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "anmq970_x01_execute"
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
 
{<section id="anmq970_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION anmq970_x01_rep_data()
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
 
{<section id="anmq970_x01.other_function" readonly="Y" >}

 
{</section>}
 