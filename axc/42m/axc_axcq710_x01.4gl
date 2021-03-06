#該程式未解開Section, 採用最新樣板產出!
{<section id="axcq710_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2015-05-25 07:58:20), PR版次:0002(2015-05-25 08:16:38)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000040
#+ Filename...: axcq710_x01
#+ Description: ...
#+ Creator....: 06816(2015-05-06 16:42:45)
#+ Modifier...: 06816 -SD/PR- 06816
 
{</section>}
 
{<section id="axcq710_x01.global" readonly="Y" >}
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
 
{<section id="axcq710_x01.main" readonly="Y" >}
PUBLIC FUNCTION axcq710_x01(p_arg1,p_arg2,p_arg3,p_arg4)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
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
   LET g_rep_code = "axcq710_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL axcq710_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL axcq710_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL axcq710_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL axcq710_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL axcq710_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="axcq710_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION axcq710_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "xcdksite.xcdk_t.xcdksite,l_xcdksite_3_desc.type_t.chr500,xcdk025.xcdk_t.xcdk025,xcdk021.xcdk_t.xcdk021,xcdk011.xcdk_t.xcdk011,l_imaal003.type_t.chr500,l_imaal004.type_t.chr500,xcdk010.xcdk_t.xcdk010,l_xcdk010_3_desc.type_t.chr500,xcdk012.xcdk_t.xcdk012,xcdk018.xcdk_t.xcdk018,xcdk002.xcdk_t.xcdk002,l_xcdk002_3_desc.type_t.chr500,xcdk009.xcdk_t.xcdk009,xcdk201.xcdk_t.xcdk201,l_xcdk202a.type_t.num20_6,l_xcdk202b.type_t.num20_6,l_xcdk202c.type_t.num20_6,l_xcdk202d.type_t.num20_6,l_xcdk202e.type_t.num20_6,l_xcdk202f.type_t.num20_6,l_xcdk202g.type_t.num20_6,l_xcdk202h.type_t.num20_6,xcdk202.xcdk_t.xcdk202,l_xcdkcomp_desc.type_t.chr500,l_xcdkld_desc.type_t.chr500,xcdk004.xcdk_t.xcdk004,xcdk005.xcdk_t.xcdk005,l_xcdk001_desc.type_t.chr500,l_xcdk003_desc.type_t.chr500" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="axcq710_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION axcq710_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="axcq710_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axcq710_x01_sel_prep()
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
#   LET g_select = " SELECT xcdksite,'',xcdk025,xcdk021,xcdk011,'','',xcdk010,'',xcdk012,xcdk018,xcdk002, 
#       '',xcdk009,xcdk201,'','','','','','','','',xcdk202,'','',xcdk004,xcdk005,'',''"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
 
#   #end add-point
#    LET g_from = " FROM xcdk_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
 
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
 
#   #end add-point:sel_prep.sql.before
#   LET g_where = g_where ,cl_sql_add_filter("xcdk_t")   #資料過濾功能
#   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
#   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
# 
#   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = "SELECT * FROM ",g_tmp_table CLIPPED
   #end add-point
   PREPARE axcq710_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE axcq710_x01_curs CURSOR FOR axcq710_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="axcq710_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION axcq710_x01_ins_data()
DEFINE sr RECORD 
   xcdksite LIKE xcdk_t.xcdksite, 
   l_xcdksite_3_desc LIKE type_t.chr500, 
   xcdk025 LIKE xcdk_t.xcdk025, 
   xcdk021 LIKE xcdk_t.xcdk021, 
   xcdk011 LIKE xcdk_t.xcdk011, 
   l_imaal003 LIKE type_t.chr500, 
   l_imaal004 LIKE type_t.chr500, 
   xcdk010 LIKE xcdk_t.xcdk010, 
   l_xcdk010_3_desc LIKE type_t.chr500, 
   xcdk012 LIKE xcdk_t.xcdk012, 
   xcdk018 LIKE xcdk_t.xcdk018, 
   xcdk002 LIKE xcdk_t.xcdk002, 
   l_xcdk002_3_desc LIKE type_t.chr500, 
   xcdk009 LIKE xcdk_t.xcdk009, 
   xcdk201 LIKE xcdk_t.xcdk201, 
   l_xcdk202a LIKE type_t.num20_6, 
   l_xcdk202b LIKE type_t.num20_6, 
   l_xcdk202c LIKE type_t.num20_6, 
   l_xcdk202d LIKE type_t.num20_6, 
   l_xcdk202e LIKE type_t.num20_6, 
   l_xcdk202f LIKE type_t.num20_6, 
   l_xcdk202g LIKE type_t.num20_6, 
   l_xcdk202h LIKE type_t.num20_6, 
   xcdk202 LIKE xcdk_t.xcdk202, 
   l_xcdkcomp_desc LIKE type_t.chr500, 
   l_xcdkld_desc LIKE type_t.chr500, 
   xcdk004 LIKE xcdk_t.xcdk004, 
   xcdk005 LIKE xcdk_t.xcdk005, 
   l_xcdk001_desc LIKE type_t.chr500, 
   l_xcdk003_desc LIKE type_t.chr500
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH axcq710_x01_curs INTO sr.*                               
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
       EXECUTE insert_prep USING sr.xcdksite,sr.l_xcdksite_3_desc,sr.xcdk025,sr.xcdk021,sr.xcdk011,sr.l_imaal003,sr.l_imaal004,sr.xcdk010,sr.l_xcdk010_3_desc,sr.xcdk012,sr.xcdk018,sr.xcdk002,sr.l_xcdk002_3_desc,sr.xcdk009,sr.xcdk201,sr.l_xcdk202a,sr.l_xcdk202b,sr.l_xcdk202c,sr.l_xcdk202d,sr.l_xcdk202e,sr.l_xcdk202f,sr.l_xcdk202g,sr.l_xcdk202h,sr.xcdk202,sr.l_xcdkcomp_desc,sr.l_xcdkld_desc,sr.xcdk004,sr.xcdk005,sr.l_xcdk001_desc,sr.l_xcdk003_desc
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "axcq710_x01_execute"
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
       LET g_xgrid.visible_column ="xcdk002|l_xcdk002_3_desc"
    END IF
    IF tm.a3 = 'N' THEN #採用特性否
       IF cl_null(g_xgrid.visible_column)THEN       
          LET g_xgrid.visible_column ="xcdk012"
       ELSE
          LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED ,"|xcdk012"
       END IF
    END IF
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axcq710_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION axcq710_x01_rep_data()
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
 
{<section id="axcq710_x01.other_function" readonly="Y" >}

 
{</section>}
 
