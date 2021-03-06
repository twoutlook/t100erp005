#該程式未解開Section, 採用最新樣板產出!
{<section id="axcq532_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2016-01-13 14:38:51), PR版次:0001(2015-10-06 16:11:43)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000035
#+ Filename...: axcq532_x01
#+ Description: ...
#+ Creator....: 06815(2015-10-01 09:39:48)
#+ Modifier...: 05384 -SD/PR- 06815
 
{</section>}
 
{<section id="axcq532_x01.global" readonly="Y" >}
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
       a1 STRING,                  #TEMP TABLE 名稱 
       a2 STRING,                  #採用成本域否 
       a3 STRING                   #採用特性否
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_tmp_table     STRING
#end add-point
 
{</section>}
 
{<section id="axcq532_x01.main" readonly="Y" >}
PUBLIC FUNCTION axcq532_x01(p_arg1,p_arg2,p_arg3,p_arg4)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 STRING                  #tm.a1  TEMP TABLE 名稱 
DEFINE  p_arg3 STRING                  #tm.a2  採用成本域否 
DEFINE  p_arg4 STRING                  #tm.a3  採用特性否
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.a1 = p_arg2
   LET tm.a2 = p_arg3
   LET tm.a3 = p_arg4
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   LET g_tmp_table = tm.a1
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "axcq532_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL axcq532_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL axcq532_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL axcq532_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL axcq532_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL axcq532_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="axcq532_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION axcq532_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "l_xccdcomp_desc.type_t.chr100,l_xccdld_desc.type_t.chr50,xccd004.xccd_t.xccd004,xccd005.xccd_t.xccd005,l_xccd004_1.xccd_t.xccd004,l_xccd005_1.xccd_t.xccd005,l_xccd002.type_t.chr100,l_xccd003.type_t.chr50,l_xccd001.type_t.chr100,xccd007.xccd_t.xccd007,l_xccd007_desc.type_t.chr30,l_xccd007_desc_1.type_t.chr30,xccd008.xccd_t.xccd008,xccd201.xccd_t.xccd201,xccd202.xccd_t.xccd202,l_xcce007.xcce_t.xcce007,l_xcce007_desc.type_t.chr30,l_xcce007_desc_1.type_t.chr30,l_xcce008.xcce_t.xcce008,l_price.type_t.num20_6,l_xcce201.xcce_t.xcce201,l_xcce202.xcce_t.xcce202,l_xccd_key.type_t.num20" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="axcq532_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION axcq532_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="axcq532_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axcq532_x01_sel_prep()
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
#   LET g_select = " SELECT xccdent,xccdcomp,xccdld,NULL,NULL,xccd004,xccd005,NULL,NULL,NULL,NULL,NULL, 
#       xccd007,NULL,NULL,xccd008,xccd201,xccd202,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
 
#   #end add-point
#    LET g_from = " FROM xccd_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
 
#   #end add-point:sel_prep.sql.before
#   LET g_where = g_where ,cl_sql_add_filter("xccd_t")   #資料過濾功能
#   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
#   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
# 
#   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = "SELECT * FROM ",g_tmp_table CLIPPED
   LET g_sql = g_sql," ORDER BY xccd_key,xcce007" 
   #end add-point
   PREPARE axcq532_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE axcq532_x01_curs CURSOR FOR axcq532_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="axcq532_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION axcq532_x01_ins_data()
DEFINE sr RECORD 
   xccdent LIKE xccd_t.xccdent, 
   xccdcomp LIKE xccd_t.xccdcomp, 
   xccdld LIKE xccd_t.xccdld, 
   l_xccdcomp_desc LIKE type_t.chr100, 
   l_xccdld_desc LIKE type_t.chr50, 
   xccd004 LIKE xccd_t.xccd004, 
   xccd005 LIKE xccd_t.xccd005, 
   l_xccd004_1 LIKE xccd_t.xccd004, 
   l_xccd005_1 LIKE xccd_t.xccd005, 
   l_xccd002 LIKE type_t.chr100, 
   l_xccd003 LIKE type_t.chr50, 
   l_xccd001 LIKE type_t.chr100, 
   xccd007 LIKE xccd_t.xccd007, 
   l_xccd007_desc LIKE type_t.chr30, 
   l_xccd007_desc_1 LIKE type_t.chr30, 
   xccd008 LIKE xccd_t.xccd008, 
   xccd201 LIKE xccd_t.xccd201, 
   xccd202 LIKE xccd_t.xccd202, 
   l_xcce007 LIKE xcce_t.xcce007, 
   l_xcce007_desc LIKE type_t.chr30, 
   l_xcce007_desc_1 LIKE type_t.chr30, 
   l_xcce008 LIKE xcce_t.xcce008, 
   l_price LIKE type_t.num20_6, 
   l_xcce201 LIKE xcce_t.xcce201, 
   l_xcce202 LIKE xcce_t.xcce202, 
   l_xccd_key LIKE type_t.num20
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH axcq532_x01_curs INTO sr.*                               
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
       EXECUTE insert_prep USING sr.l_xccdcomp_desc,sr.l_xccdld_desc,sr.xccd004,sr.xccd005,sr.l_xccd004_1,sr.l_xccd005_1,sr.l_xccd002,sr.l_xccd003,sr.l_xccd001,sr.xccd007,sr.l_xccd007_desc,sr.l_xccd007_desc_1,sr.xccd008,sr.xccd201,sr.xccd202,sr.l_xcce007,sr.l_xcce007_desc,sr.l_xcce007_desc_1,sr.l_xcce008,sr.l_price,sr.l_xcce201,sr.l_xcce202,sr.l_xccd_key
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "axcq532_x01_execute"
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
    IF tm.a2 = 'N' THEN #採用成本域否
       LET g_xgrid.visible_column ="l_xccd002"
    END IF
     
    IF tm.a3 = 'N' THEN #採用特性否
       IF cl_null(g_xgrid.visible_column)THEN       
          LET g_xgrid.visible_column ="xccd008"
       ELSE
          LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED ,"|xccd008"
       END IF
    END IF  
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axcq532_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION axcq532_x01_rep_data()
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
 
{<section id="axcq532_x01.other_function" readonly="Y" >}

 
{</section>}
 
