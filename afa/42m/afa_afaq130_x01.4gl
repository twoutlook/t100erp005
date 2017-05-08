#該程式未解開Section, 採用最新樣板產出!
{<section id="afaq130_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2015-11-05 16:20:01), PR版次:0002(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000036
#+ Filename...: afaq130_x01
#+ Description: ...
#+ Creator....: 06816(2015-10-05 14:21:41)
#+ Modifier...: 06821 -SD/PR- 00000
 
{</section>}
 
{<section id="afaq130_x01.global" readonly="Y" >}
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
       a1 STRING                   #temp table
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_tmp_table           STRING
#end add-point
 
{</section>}
 
{<section id="afaq130_x01.main" readonly="Y" >}
PUBLIC FUNCTION afaq130_x01(p_arg1,p_arg2)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 STRING                  #tm.a1  temp table
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
   LET g_rep_code = "afaq130_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL afaq130_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL afaq130_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL afaq130_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL afaq130_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL afaq130_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="afaq130_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION afaq130_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "faam001.faam_t.faam001,faam002.faam_t.faam002,faam000.faam_t.faam000,faah_t_faah006.faah_t.faah006,l_faah006_desc.type_t.chr500,faah_t_faah007.faah_t.faah007,l_faah007_desc.type_t.chr500,faam009.faam_t.faam009,l_faam009_desc.type_t.chr500,faah_t_faah028.faah_t.faah028,l_faah028_desc.type_t.chr500,l_faah005.type_t.chr500,l_faah042.type_t.chr500,faah_t_faah008.faah_t.faah008,l_faah008_desc.type_t.chr500,faah_t_faah018.faah_t.faah018,faam014.faam_t.faam014,l_faam003_desc.type_t.chr500,faaj019.faaj_t.faaj019,l_faam007_desc.type_t.chr500,faam010.faam_t.faam010,l_faam010_desc.type_t.chr500,faam017.faam_t.faam017,faam015.faam_t.faam015,faam013.faam_t.faam013,faah_t_faah043.faah_t.faah043,faam024.faam_t.faam024,faaj008.faaj_t.faaj008,faah_t_faah012.faah_t.faah012,faam016.faam_t.faam016,l_faam014_015.type_t.num20_6,l_faaj004.faaj_t.faaj004,faam022.faam_t.faam022,l_faam022_desc.type_t.chr500,l_faamsite.type_t.chr500,l_faamld.type_t.chr500,l_faamcomp.type_t.chr500,faam011.faam_t.faam011,faam004.faam_t.faam004,faam005.faam_t.faam005" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="afaq130_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION afaq130_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="afaq130_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION afaq130_x01_sel_prep()
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
#   LET g_select = " SELECT faam001,faam002,faam000,faah_t.faah006,'',faah_t.faah007,'',faam009,'',faah_t.faah028, 
#       '','','',faah_t.faah008,'',faah_t.faah018,faam014,'',faaj019,'',faam010,'',faam017,faam015,faam013, 
#       faah_t.faah043,faam024,faaj008,faah_t.faah012,faam016,'','',faam022,'',faamsite,'',faamld,'', 
#       faamcomp,'',faam011,faam004,faam005,faament"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
 
#   #end add-point
#    LET g_from = " FROM faam_t,faaj_t,faah_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
 
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
#   #end add-point:sel_prep.sql.before
#   LET g_where = g_where ,cl_sql_add_filter("faam_t")   #資料過濾功能
#   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
#   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
# 
#   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = "SELECT * FROM ",g_tmp_table CLIPPED
   #end add-point
   PREPARE afaq130_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE afaq130_x01_curs CURSOR FOR afaq130_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="afaq130_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION afaq130_x01_ins_data()
DEFINE sr RECORD 
   faam001 LIKE faam_t.faam001, 
   faam002 LIKE faam_t.faam002, 
   faam000 LIKE faam_t.faam000, 
   faah_t_faah006 LIKE faah_t.faah006, 
   l_faah006_desc LIKE type_t.chr500, 
   faah_t_faah007 LIKE faah_t.faah007, 
   l_faah007_desc LIKE type_t.chr500, 
   faam009 LIKE faam_t.faam009, 
   l_faam009_desc LIKE type_t.chr500, 
   faah_t_faah028 LIKE faah_t.faah028, 
   l_faah028_desc LIKE type_t.chr500, 
   l_faah005 LIKE type_t.chr500, 
   l_faah042 LIKE type_t.chr500, 
   faah_t_faah008 LIKE faah_t.faah008, 
   l_faah008_desc LIKE type_t.chr500, 
   faah_t_faah018 LIKE faah_t.faah018, 
   faam014 LIKE faam_t.faam014, 
   l_faam003_desc LIKE type_t.chr500, 
   faaj019 LIKE faaj_t.faaj019, 
   l_faam007_desc LIKE type_t.chr500, 
   faam010 LIKE faam_t.faam010, 
   l_faam010_desc LIKE type_t.chr500, 
   faam017 LIKE faam_t.faam017, 
   faam015 LIKE faam_t.faam015, 
   faam013 LIKE faam_t.faam013, 
   faah_t_faah043 LIKE faah_t.faah043, 
   faam024 LIKE faam_t.faam024, 
   faaj008 LIKE faaj_t.faaj008, 
   faah_t_faah012 LIKE faah_t.faah012, 
   faam016 LIKE faam_t.faam016, 
   l_faam014_015 LIKE type_t.num20_6, 
   l_faaj004 LIKE faaj_t.faaj004, 
   faam022 LIKE faam_t.faam022, 
   l_faam022_desc LIKE type_t.chr500, 
   faamsite LIKE faam_t.faamsite, 
   l_faamsite LIKE type_t.chr500, 
   faamld LIKE faam_t.faamld, 
   l_faamld LIKE type_t.chr500, 
   faamcomp LIKE faam_t.faamcomp, 
   l_faamcomp LIKE type_t.chr500, 
   faam011 LIKE faam_t.faam011, 
   faam004 LIKE faam_t.faam004, 
   faam005 LIKE faam_t.faam005, 
   faament LIKE faam_t.faament
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH afaq130_x01_curs INTO sr.*                               
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
       EXECUTE insert_prep USING sr.faam001,sr.faam002,sr.faam000,sr.faah_t_faah006,sr.l_faah006_desc,sr.faah_t_faah007,sr.l_faah007_desc,sr.faam009,sr.l_faam009_desc,sr.faah_t_faah028,sr.l_faah028_desc,sr.l_faah005,sr.l_faah042,sr.faah_t_faah008,sr.l_faah008_desc,sr.faah_t_faah018,sr.faam014,sr.l_faam003_desc,sr.faaj019,sr.l_faam007_desc,sr.faam010,sr.l_faam010_desc,sr.faam017,sr.faam015,sr.faam013,sr.faah_t_faah043,sr.faam024,sr.faaj008,sr.faah_t_faah012,sr.faam016,sr.l_faam014_015,sr.l_faaj004,sr.faam022,sr.l_faam022_desc,sr.l_faamsite,sr.l_faamld,sr.l_faamcomp,sr.faam011,sr.faam004,sr.faam005
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "afaq130_x01_execute"
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
 
{<section id="afaq130_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION afaq130_x01_rep_data()
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
 
{<section id="afaq130_x01.other_function" readonly="Y" >}

 
{</section>}
 
