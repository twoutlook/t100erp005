#該程式未解開Section, 採用最新樣板產出!
{<section id="abgq051_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2016-10-21 11:23:39), PR版次:0001(2016-10-21 10:47:39)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: abgq051_x01
#+ Description: ...
#+ Creator....: 05016(2016-10-21 09:18:11)
#+ Modifier...: 05016 -SD/PR- 05016
 
{</section>}
 
{<section id="abgq051_x01.global" readonly="Y" >}
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
       a1 STRING                   #x01_tmp
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_tmp_table     STRING
#end add-point
 
{</section>}
 
{<section id="abgq051_x01.main" readonly="Y" >}
PUBLIC FUNCTION abgq051_x01(p_arg1,p_arg2)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 STRING                  #tm.a1  x01_tmp
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
   LET g_rep_code = "abgq051_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL abgq051_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL abgq051_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL abgq051_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL abgq051_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL abgq051_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="abgq051_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION abgq051_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
 
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "l_bgbc001_desc.type_t.chr100,bgbc002.bgbc_t.bgbc002,l_glfa001.glfa_t.glfa001,l_bgbc003_desc.type_t.chr100,l_type.type_t.chr100,l_chk.type_t.chr100,l_year.xrea_t.xrea001,l_curry.type_t.chr100,l_glfa009.glfa_t.glfa009,l_glfa008.glfa_t.glfa008,l_strmon.type_t.chr100,l_assest.type_t.chr100,l_glfb0031.type_t.num5,l_amt1.type_t.num20_6,l_amt2.type_t.num20_6,l_amt3.type_t.num20_6,l_amt4.type_t.num20_6,l_item_desc.type_t.chr100,l_glfb0032.type_t.num5,l_amt5.type_t.num20_6,l_amt6.type_t.num20_6,l_amt7.type_t.num20_6,l_amt8.type_t.num20_6" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="abgq051_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION abgq051_x01_ins_prep()
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
 
{<section id="abgq051_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION abgq051_x01_sel_prep()
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
#   LET g_select = " SELECT '',bgbc002,'','','','','','','','','','','','','','','','','','','','',''" 
#
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
 
#   #end add-point
#    LET g_from = " FROM bgbc_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
 
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
 
#   #end add-point:sel_prep.sql.before
#   LET g_where = g_where ,cl_sql_add_filter("bgbc_t")   #資料過濾功能
#   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
#   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
# 
#   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = "SELECT * FROM ",g_tmp_table
   #end add-point
   PREPARE abgq051_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE abgq051_x01_curs CURSOR FOR abgq051_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="abgq051_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION abgq051_x01_ins_data()
DEFINE sr RECORD 
   l_bgbc001_desc LIKE type_t.chr100, 
   bgbc002 LIKE bgbc_t.bgbc002, 
   l_glfa001 LIKE glfa_t.glfa001, 
   l_bgbc003_desc LIKE type_t.chr100, 
   l_type LIKE type_t.chr100, 
   l_chk LIKE type_t.chr100, 
   l_year LIKE xrea_t.xrea001, 
   l_curry LIKE type_t.chr100, 
   l_glfa009 LIKE glfa_t.glfa009, 
   l_glfa008 LIKE glfa_t.glfa008, 
   l_strmon LIKE type_t.chr100, 
   l_assest LIKE type_t.chr100, 
   l_glfb0031 LIKE type_t.num5, 
   l_amt1 LIKE type_t.num20_6, 
   l_amt2 LIKE type_t.num20_6, 
   l_amt3 LIKE type_t.num20_6, 
   l_amt4 LIKE type_t.num20_6, 
   l_item_desc LIKE type_t.chr100, 
   l_glfb0032 LIKE type_t.num5, 
   l_amt5 LIKE type_t.num20_6, 
   l_amt6 LIKE type_t.num20_6, 
   l_amt7 LIKE type_t.num20_6, 
   l_amt8 LIKE type_t.num20_6
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH abgq051_x01_curs INTO sr.*                               
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
       EXECUTE insert_prep USING sr.l_bgbc001_desc,sr.bgbc002,sr.l_glfa001,sr.l_bgbc003_desc,sr.l_type,sr.l_chk,sr.l_year,sr.l_curry,sr.l_glfa009,sr.l_glfa008,sr.l_strmon,sr.l_assest,sr.l_glfb0031,sr.l_amt1,sr.l_amt2,sr.l_amt3,sr.l_amt4,sr.l_item_desc,sr.l_glfb0032,sr.l_amt5,sr.l_amt6,sr.l_amt7,sr.l_amt8
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "abgq051_x01_execute"
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
    IF g_prog NOT MATCHES 'abgq051' THEN
       LET g_xgrid.visible_column ="l_item_desc|l_glfb0032|l_amt5|l_amt6|l_amt7|l_amt8"
    END IF    
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="abgq051_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION abgq051_x01_rep_data()
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
 
{<section id="abgq051_x01.other_function" readonly="Y" >}

 
{</section>}
 