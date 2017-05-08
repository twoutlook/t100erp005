#該程式未解開Section, 採用最新樣板產出!
{<section id="axcq740_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2015-05-25 07:58:58), PR版次:0002(2015-05-25 08:22:37)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000040
#+ Filename...: axcq740_x01
#+ Description: ...
#+ Creator....: 06816(2015-05-12 08:30:26)
#+ Modifier...: 06816 -SD/PR- 06816
 
{</section>}
 
{<section id="axcq740_x01.global" readonly="Y" >}
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
       wc STRING,                  #WHERE CONDITION 
       a1 STRING,                  #TEMP TABLE名稱 
       a2 STRING,                  #採用成本域否 
       a3 STRING                   #採用特性否
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_tmp_table           STRING
#end add-point
 
{</section>}
 
{<section id="axcq740_x01.main" readonly="Y" >}
PUBLIC FUNCTION axcq740_x01(p_arg1,p_arg2,p_arg3,p_arg4)
DEFINE  p_arg1 STRING                  #tm.wc  WHERE CONDITION 
DEFINE  p_arg2 STRING                  #tm.a1  TEMP TABLE名稱 
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
   LET g_rep_code = "axcq740_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL axcq740_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL axcq740_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL axcq740_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL axcq740_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL axcq740_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="axcq740_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION axcq740_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "l_sfaasite.sfaa_t.sfaasite,l_sfaasite_desc.type_t.chr500,xccd002.xccd_t.xccd002,l_xccd002_desc.type_t.chr500,xccd006.xccd_t.xccd006,xcde007.xcde_t.xcde007,l_imaal003.type_t.chr500,l_imaal004.type_t.chr500,xcde008.xcde_t.xcde008,xcde009.xcde_t.xcde009,xcde010.xcde_t.xcde010,l_xcde010_desc.type_t.chr500,l_xcbb005.type_t.chr500,xcde101.xcde_t.xcde101,xcde102.xcde_t.xcde102,xcde201.xcde_t.xcde201,xcde202.xcde_t.xcde202,xcde301.xcde_t.xcde301,xcde302.xcde_t.xcde302,xcde303.xcde_t.xcde303,xcde304.xcde_t.xcde304,xcde307.xcde_t.xcde307,xcde308.xcde_t.xcde308,xcde901.xcde_t.xcde901,xcde902.xcde_t.xcde902,l_xccdcomp_desc.type_t.chr500,l_xccdld_desc.type_t.chr500,xcde004.xcde_t.xcde004,xcde005.xcde_t.xcde005,l_xccd001_desc.type_t.chr500,l_xccd003_desc.type_t.chr500" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="axcq740_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION axcq740_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="axcq740_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axcq740_x01_sel_prep()
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
#   LET g_select = " SELECT '','',xccd002,'',xccd006,xcde007,'','',xcde008,xcde009,xcde010,'','',xcde101, 
#       xcde102,xcde201,xcde202,xcde301,xcde302,xcde303,xcde304,xcde307,xcde308,xcde901,xcde902,'','', 
#       xcde004,xcde005,'','',''"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
 
#   #end add-point
#    LET g_from = " FROM xccd_t,xcde_t"
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
   LET g_sql = "SELECT * FROM ",g_tmp_table CLIPPED," ORDER BY l_odr "
   #end add-point
   PREPARE axcq740_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE axcq740_x01_curs CURSOR FOR axcq740_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="axcq740_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION axcq740_x01_ins_data()
DEFINE sr RECORD 
   l_sfaasite LIKE sfaa_t.sfaasite, 
   l_sfaasite_desc LIKE type_t.chr500, 
   xccd002 LIKE xccd_t.xccd002, 
   l_xccd002_desc LIKE type_t.chr500, 
   xccd006 LIKE xccd_t.xccd006, 
   xcde007 LIKE xcde_t.xcde007, 
   l_imaal003 LIKE type_t.chr500, 
   l_imaal004 LIKE type_t.chr500, 
   xcde008 LIKE xcde_t.xcde008, 
   xcde009 LIKE xcde_t.xcde009, 
   xcde010 LIKE xcde_t.xcde010, 
   l_xcde010_desc LIKE type_t.chr500, 
   l_xcbb005 LIKE type_t.chr500, 
   xcde101 LIKE xcde_t.xcde101, 
   xcde102 LIKE xcde_t.xcde102, 
   xcde201 LIKE xcde_t.xcde201, 
   xcde202 LIKE xcde_t.xcde202, 
   xcde301 LIKE xcde_t.xcde301, 
   xcde302 LIKE xcde_t.xcde302, 
   xcde303 LIKE xcde_t.xcde303, 
   xcde304 LIKE xcde_t.xcde304, 
   xcde307 LIKE xcde_t.xcde307, 
   xcde308 LIKE xcde_t.xcde308, 
   xcde901 LIKE xcde_t.xcde901, 
   xcde902 LIKE xcde_t.xcde902, 
   l_xccdcomp_desc LIKE type_t.chr500, 
   l_xccdld_desc LIKE type_t.chr500, 
   xcde004 LIKE xcde_t.xcde004, 
   xcde005 LIKE xcde_t.xcde005, 
   l_xccd001_desc LIKE type_t.chr500, 
   l_xccd003_desc LIKE type_t.chr500, 
   l_odr LIKE type_t.num5
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH axcq740_x01_curs INTO sr.*                               
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
       EXECUTE insert_prep USING sr.l_sfaasite,sr.l_sfaasite_desc,sr.xccd002,sr.l_xccd002_desc,sr.xccd006,sr.xcde007,sr.l_imaal003,sr.l_imaal004,sr.xcde008,sr.xcde009,sr.xcde010,sr.l_xcde010_desc,sr.l_xcbb005,sr.xcde101,sr.xcde102,sr.xcde201,sr.xcde202,sr.xcde301,sr.xcde302,sr.xcde303,sr.xcde304,sr.xcde307,sr.xcde308,sr.xcde901,sr.xcde902,sr.l_xccdcomp_desc,sr.l_xccdld_desc,sr.xcde004,sr.xcde005,sr.l_xccd001_desc,sr.l_xccd003_desc
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "axcq740_x01_execute"
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
       LET g_xgrid.visible_column ="xccd002|l_xccd002_desc"
    END IF
    IF tm.a3 = 'N' THEN #採用特性否
       IF cl_null(g_xgrid.visible_column)THEN       
          LET g_xgrid.visible_column ="xcde008"
       ELSE
          LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED ,"|xcde008"
       END IF
    END IF
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axcq740_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION axcq740_x01_rep_data()
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
 
{<section id="axcq740_x01.other_function" readonly="Y" >}

 
{</section>}
 
