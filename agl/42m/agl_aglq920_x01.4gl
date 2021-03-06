#該程式未解開Section, 採用最新樣板產出!
{<section id="aglq920_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2016-06-01 17:30:46), PR版次:0001(2016-06-01 17:56:43)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000023
#+ Filename...: aglq920_x01
#+ Description: ...
#+ Creator....: 06821(2016-06-01 17:19:59)
#+ Modifier...: 06821 -SD/PR- 06821
 
{</section>}
 
{<section id="aglq920_x01.global" readonly="Y" >}
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
       wc STRING,                  #where cindition 
       a1 STRING                   #gldt_t tmp
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_tmp_table     STRING
#end add-point
 
{</section>}
 
{<section id="aglq920_x01.main" readonly="Y" >}
PUBLIC FUNCTION aglq920_x01(p_arg1,p_arg2)
DEFINE  p_arg1 STRING                  #tm.wc  where cindition 
DEFINE  p_arg2 STRING                  #tm.a1  gldt_t tmp
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
   LET g_rep_code = "aglq920_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL aglq920_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL aglq920_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL aglq920_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL aglq920_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL aglq920_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="aglq920_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION aglq920_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "l_gldtld_desc.type_t.chr80,l_gldt001_desc.type_t.chr80,l_gldt003_desc.type_t.chr80,gldt005.gldt_t.gldt005,gldt006.gldt_t.gldt006,gldt009.gldt_t.gldt009,gldt025.gldt_t.gldt025,gldt028.gldt_t.gldt028,gldt007.gldt_t.gldt007,gldt033.gldt_t.gldt033,gldt010.gldt_t.gldt010,gldt011.gldt_t.gldt011,l_gldt010_gldt011.type_t.num20_6,gldt034.gldt_t.gldt034,gldt026.gldt_t.gldt026,gldt027.gldt_t.gldt027,l_gldt026_gldt027.type_t.num20_6,gldt035.gldt_t.gldt035,gldt029.gldt_t.gldt029,gldt030.gldt_t.gldt030,l_gldt029_gldt030.type_t.num20_6" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="aglq920_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION aglq920_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="aglq920_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aglq920_x01_sel_prep()
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
#   LET g_select = " SELECT gldtent,gldtld,'','','',gldt005,gldt006,gldt009,gldt025,gldt028,gldt007,gldt033, 
#       gldt010,gldt011,'',gldt034,gldt026,gldt027,'',gldt035,gldt029,gldt030,''"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
 
#   #end add-point
#    LET g_from = " FROM gldt_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
 
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
 
#   #end add-point:sel_prep.sql.before
#   LET g_where = g_where ,cl_sql_add_filter("gldt_t")   #資料過濾功能
#   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
#   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
# 
#   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = " SELECT * FROM ", g_tmp_table CLIPPED,
               "  ORDER BY gldt007 "
   #end add-point
   PREPARE aglq920_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE aglq920_x01_curs CURSOR FOR aglq920_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="aglq920_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION aglq920_x01_ins_data()
DEFINE sr RECORD 
   gldtent LIKE gldt_t.gldtent, 
   gldtld LIKE gldt_t.gldtld, 
   l_gldtld_desc LIKE type_t.chr80, 
   l_gldt001_desc LIKE type_t.chr80, 
   l_gldt003_desc LIKE type_t.chr80, 
   gldt005 LIKE gldt_t.gldt005, 
   gldt006 LIKE gldt_t.gldt006, 
   gldt009 LIKE gldt_t.gldt009, 
   gldt025 LIKE gldt_t.gldt025, 
   gldt028 LIKE gldt_t.gldt028, 
   gldt007 LIKE gldt_t.gldt007, 
   gldt033 LIKE gldt_t.gldt033, 
   gldt010 LIKE gldt_t.gldt010, 
   gldt011 LIKE gldt_t.gldt011, 
   l_gldt010_gldt011 LIKE type_t.num20_6, 
   gldt034 LIKE gldt_t.gldt034, 
   gldt026 LIKE gldt_t.gldt026, 
   gldt027 LIKE gldt_t.gldt027, 
   l_gldt026_gldt027 LIKE type_t.num20_6, 
   gldt035 LIKE gldt_t.gldt035, 
   gldt029 LIKE gldt_t.gldt029, 
   gldt030 LIKE gldt_t.gldt030, 
   l_gldt029_gldt030 LIKE type_t.num20_6
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_glaa015  LIKE glaa_t.glaa015
DEFINE l_glaa019  LIKE glaa_t.glaa019
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH aglq920_x01_curs INTO sr.*                               
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
       EXECUTE insert_prep USING sr.l_gldtld_desc,sr.l_gldt001_desc,sr.l_gldt003_desc,sr.gldt005,sr.gldt006,sr.gldt009,sr.gldt025,sr.gldt028,sr.gldt007,sr.gldt033,sr.gldt010,sr.gldt011,sr.l_gldt010_gldt011,sr.gldt034,sr.gldt026,sr.gldt027,sr.l_gldt026_gldt027,sr.gldt035,sr.gldt029,sr.gldt030,sr.l_gldt029_gldt030
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "aglq920_x01_execute"
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
    LET g_xgrid.visible_column = NULL
    
    LET l_glaa015 = ''
    LET l_glaa019 = ''
    SELECT glaa015,glaa019 INTO l_glaa015,l_glaa019 
      FROM glaa_t
     WHERE glaaent = g_enterprise AND glaald = sr.gldtld
    
    IF l_glaa015 = 'N' THEN #功能幣啟用否
       LET g_xgrid.visible_column = "gldt034|gldt026|gldt027|l_gldt026_gldt027"
    END IF
    
    IF l_glaa019 = 'N' THEN #報告幣啟用否
       IF NOT cl_null(g_xgrid.visible_column)THEN       
          LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED ,"|gldt035|gldt029|gldt030|l_gldt029_gldt030"
       ELSE
          LET g_xgrid.visible_column = "gldt035|gldt029|gldt030|l_gldt029_gldt030"
       END IF
    END IF
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aglq920_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION aglq920_x01_rep_data()
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
 
{<section id="aglq920_x01.other_function" readonly="Y" >}

 
{</section>}
 
