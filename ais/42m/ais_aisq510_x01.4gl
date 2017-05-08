#該程式未解開Section, 採用最新樣板產出!
{<section id="aisq510_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2016-02-03 15:16:36), PR版次:0001(2016-02-02 10:35:30)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000028
#+ Filename...: aisq510_x01
#+ Description: ...
#+ Creator....: 05016(2016-01-14 15:34:12)
#+ Modifier...: 05016 -SD/PR- 05016
 
{</section>}
 
{<section id="aisq510_x01.global" readonly="Y" >}
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
       a1 STRING                   #tmp_table
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_tmp_table   STRING
#end add-point
 
{</section>}
 
{<section id="aisq510_x01.main" readonly="Y" >}
PUBLIC FUNCTION aisq510_x01(p_arg1,p_arg2)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 STRING                  #tm.a1  tmp_table
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
   LET g_rep_code = "aisq510_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL aisq510_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL aisq510_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL aisq510_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL aisq510_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL aisq510_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="aisq510_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION aisq510_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "isav001.isav_t.isav001,l_isav001_desc.type_t.chr500,isav003.isav_t.isav003,isav007.isav_t.isav007,isavseq.isav_t.isavseq,l_isav009.type_t.chr100,isav008.isav_t.isav008,isav004.isav_t.isav004,l_isav005.type_t.chr100,isav010.isav_t.isav010,l_isav010_desc.type_t.chr100,isav011.isav_t.isav011,isav012.isav_t.isav012,isav013.isav_t.isav013,isavcomp.isav_t.isavcomp,l_isavcomp_desc.type_t.chr100,isav002.isav_t.isav002,l_isav008s.isav_t.isav008,l_isav008e.isav_t.isav008,l_isav003h.isav_t.isav003" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="aisq510_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION aisq510_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="aisq510_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aisq510_x01_sel_prep()
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
 
#   #end add-point
#   LET g_select = " SELECT isav001,NULL,isav003,isav007,isavseq,'',isav008,isav004,'',isav010,'',isav011, 
#       isav012,isav013,isavcomp,'',isav002,isavsite,isavent,'','',''"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
 
#   #end add-point
#    LET g_from = " FROM isav_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
 
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
  
#   #end add-point:sel_prep.sql.before
#   LET g_where = g_where ,cl_sql_add_filter("isav_t")   #資料過濾功能
#   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
#   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
# 
#   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = " SELECT * FROM ",g_tmp_table
   #end add-point
   PREPARE aisq510_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE aisq510_x01_curs CURSOR FOR aisq510_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="aisq510_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION aisq510_x01_ins_data()
DEFINE sr RECORD 
   isav001 LIKE isav_t.isav001, 
   l_isav001_desc LIKE type_t.chr500, 
   isav003 LIKE isav_t.isav003, 
   isav007 LIKE isav_t.isav007, 
   isavseq LIKE isav_t.isavseq, 
   l_isav009 LIKE type_t.chr100, 
   isav008 LIKE isav_t.isav008, 
   isav004 LIKE isav_t.isav004, 
   l_isav005 LIKE type_t.chr100, 
   isav010 LIKE isav_t.isav010, 
   l_isav010_desc LIKE type_t.chr100, 
   isav011 LIKE isav_t.isav011, 
   isav012 LIKE isav_t.isav012, 
   isav013 LIKE isav_t.isav013, 
   isavcomp LIKE isav_t.isavcomp, 
   l_isavcomp_desc LIKE type_t.chr100, 
   isav002 LIKE isav_t.isav002, 
   isavsite LIKE isav_t.isavsite, 
   isavent LIKE isav_t.isavent, 
   l_isav008s LIKE isav_t.isav008, 
   l_isav008e LIKE isav_t.isav008, 
   l_isav003h LIKE isav_t.isav003
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH aisq510_x01_curs INTO sr.*                               
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
       EXECUTE insert_prep USING sr.isav001,sr.l_isav001_desc,sr.isav003,sr.isav007,sr.isavseq,sr.l_isav009,sr.isav008,sr.isav004,sr.l_isav005,sr.isav010,sr.l_isav010_desc,sr.isav011,sr.isav012,sr.isav013,sr.isavcomp,sr.l_isavcomp_desc,sr.isav002,sr.l_isav008s,sr.l_isav008e,sr.l_isav003h
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "aisq510_x01_execute"
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
 
{<section id="aisq510_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION aisq510_x01_rep_data()
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
 
{<section id="aisq510_x01.other_function" readonly="Y" >}

 
{</section>}
 
