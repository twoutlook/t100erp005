#該程式未解開Section, 採用最新樣板產出!
{<section id="aglq750_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2015-10-21 17:22:12), PR版次:0001(2015-10-21 17:51:32)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000034
#+ Filename...: aglq750_x01
#+ Description: ...
#+ Creator....: 02599(2015-10-21 10:11:10)
#+ Modifier...: 02599 -SD/PR- 02599
 
{</section>}
 
{<section id="aglq750_x01.global" readonly="Y" >}
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
       tmp LIKE type_t.chr200,         #temp table 
       a1 STRING                   #隱藏欄位
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="aglq750_x01.main" readonly="Y" >}
PUBLIC FUNCTION aglq750_x01(p_arg1,p_arg2,p_arg3)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr200         #tm.tmp  temp table 
DEFINE  p_arg3 STRING                  #tm.a1  隱藏欄位
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.tmp = p_arg2
   LET tm.a1 = p_arg3
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "aglq750_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL aglq750_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL aglq750_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL aglq750_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL aglq750_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL aglq750_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="aglq750_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION aglq750_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "l_seq.type_t.num10,glarld.glar_t.glarld,l_glarld_desc.type_t.chr500,glarcomp.glar_t.glarcomp,l_glarcomp_desc.type_t.chr500,glar002.glar_t.glar002,l_period.type_t.chr50,glar001.glar_t.glar001,l_glar001_desc.type_t.chr500,glar012.glar_t.glar012,l_glar012_desc.type_t.chr500,glar013.glar_t.glar013,l_glar013_desc.type_t.chr500,glar014.glar_t.glar014,l_glar014_desc.type_t.chr500,glar015.glar_t.glar015,l_glar015_desc.type_t.chr500,glar016.glar_t.glar016,l_glar016_desc.type_t.chr500,glar017.glar_t.glar017,l_glar017_desc.type_t.chr500,glar018.glar_t.glar018,l_glar018_desc.type_t.chr500,glar019.glar_t.glar019,l_glar019_desc.type_t.chr500,glar051.glar_t.glar051,l_glar051_desc.type_t.chr200,glar052.glar_t.glar052,l_glar052_desc.type_t.chr500,glar053.glar_t.glar053,l_glar053_desc.type_t.chr500,glar020.glar_t.glar020,l_glar020_desc.type_t.chr200,glar022.glar_t.glar022,l_glar022_desc.type_t.chr500,glar023.glar_t.glar023,l_glar023_desc.type_t.chr500,glar024.glar_t.glar024,l_glar024_desc.type_t.chr500,glar025.glar_t.glar025,l_glar025_desc.type_t.chr500,glar026.glar_t.glar026,l_glar026_desc.type_t.chr500,glar027.glar_t.glar027,l_glar027_desc.type_t.chr500,glar028.glar_t.glar028,l_glar028_desc.type_t.chr500,glar029.glar_t.glar029,l_glar029_desc.type_t.chr500,glar030.glar_t.glar030,l_glar030_desc.type_t.chr500,glar031.glar_t.glar031,l_glar031_desc.type_t.chr500,glar032.glar_t.glar032,l_glar032_desc.type_t.chr500,glar033.glar_t.glar033,l_glar033_desc.type_t.chr500,glar003.glar_t.glar003,l_style.type_t.chr500,glar005.glar_t.glar005,glar006.glar_t.glar006,glar034.glar_t.glar034,glar035.glar_t.glar035,glar036.glar_t.glar036,glar037.glar_t.glar037,l_state.type_t.chr30,l_amt1.type_t.num20_6,l_amt2.type_t.num20_6,l_amt3.type_t.num20_6,glarent.glar_t.glarent" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="aglq750_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION aglq750_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?, 
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="aglq750_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aglq750_x01_sel_prep()
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
   LET g_select = " SELECT 0,glarld,'',glarcomp,'',glar002,'',glar001,'',glar012,'',glar013,'',glar014, 
       '',glar015,'',glar016,'',glar017,'',glar018,'',glar019,'',glar051,'',glar052,'',glar053,'',glar020, 
       '',glar022,'',glar023,'',glar024,'',glar025,'',glar026,'',glar027,'',glar028,'',glar029,'',glar030, 
       '',glar031,'',glar032,'',glar033,'',glar003,'',glar005,glar006,glar034,glar035,glar036,glar037, 
       '',0,0,0,glarent"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   
   #end add-point
    LET g_from = " FROM glar_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("glar_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = " SELECT * FROM ", tm.tmp CLIPPED," ORDER BY seq"
   LET g_sql = cl_sql_add_mask(g_sql)
   #end add-point
   PREPARE aglq750_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE aglq750_x01_curs CURSOR FOR aglq750_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="aglq750_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION aglq750_x01_ins_data()
DEFINE sr RECORD 
   l_seq LIKE type_t.num10, 
   glarld LIKE glar_t.glarld, 
   l_glarld_desc LIKE type_t.chr500, 
   glarcomp LIKE glar_t.glarcomp, 
   l_glarcomp_desc LIKE type_t.chr500, 
   glar002 LIKE glar_t.glar002, 
   l_period LIKE type_t.chr50, 
   glar001 LIKE glar_t.glar001, 
   l_glar001_desc LIKE type_t.chr500, 
   glar012 LIKE glar_t.glar012, 
   l_glar012_desc LIKE type_t.chr500, 
   glar013 LIKE glar_t.glar013, 
   l_glar013_desc LIKE type_t.chr500, 
   glar014 LIKE glar_t.glar014, 
   l_glar014_desc LIKE type_t.chr500, 
   glar015 LIKE glar_t.glar015, 
   l_glar015_desc LIKE type_t.chr500, 
   glar016 LIKE glar_t.glar016, 
   l_glar016_desc LIKE type_t.chr500, 
   glar017 LIKE glar_t.glar017, 
   l_glar017_desc LIKE type_t.chr500, 
   glar018 LIKE glar_t.glar018, 
   l_glar018_desc LIKE type_t.chr500, 
   glar019 LIKE glar_t.glar019, 
   l_glar019_desc LIKE type_t.chr500, 
   glar051 LIKE glar_t.glar051, 
   l_glar051_desc LIKE type_t.chr200, 
   glar052 LIKE glar_t.glar052, 
   l_glar052_desc LIKE type_t.chr500, 
   glar053 LIKE glar_t.glar053, 
   l_glar053_desc LIKE type_t.chr500, 
   glar020 LIKE glar_t.glar020, 
   l_glar020_desc LIKE type_t.chr200, 
   glar022 LIKE glar_t.glar022, 
   l_glar022_desc LIKE type_t.chr500, 
   glar023 LIKE glar_t.glar023, 
   l_glar023_desc LIKE type_t.chr500, 
   glar024 LIKE glar_t.glar024, 
   l_glar024_desc LIKE type_t.chr500, 
   glar025 LIKE glar_t.glar025, 
   l_glar025_desc LIKE type_t.chr500, 
   glar026 LIKE glar_t.glar026, 
   l_glar026_desc LIKE type_t.chr500, 
   glar027 LIKE glar_t.glar027, 
   l_glar027_desc LIKE type_t.chr500, 
   glar028 LIKE glar_t.glar028, 
   l_glar028_desc LIKE type_t.chr500, 
   glar029 LIKE glar_t.glar029, 
   l_glar029_desc LIKE type_t.chr500, 
   glar030 LIKE glar_t.glar030, 
   l_glar030_desc LIKE type_t.chr500, 
   glar031 LIKE glar_t.glar031, 
   l_glar031_desc LIKE type_t.chr500, 
   glar032 LIKE glar_t.glar032, 
   l_glar032_desc LIKE type_t.chr500, 
   glar033 LIKE glar_t.glar033, 
   l_glar033_desc LIKE type_t.chr500, 
   glar003 LIKE glar_t.glar003, 
   l_style LIKE type_t.chr500, 
   glar005 LIKE glar_t.glar005, 
   glar006 LIKE glar_t.glar006, 
   glar034 LIKE glar_t.glar034, 
   glar035 LIKE glar_t.glar035, 
   glar036 LIKE glar_t.glar036, 
   glar037 LIKE glar_t.glar037, 
   l_state LIKE type_t.chr30, 
   l_amt1 LIKE type_t.num20_6, 
   l_amt2 LIKE type_t.num20_6, 
   l_amt3 LIKE type_t.num20_6, 
   glarent LIKE glar_t.glarent
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH aglq750_x01_curs INTO sr.*                               
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
       EXECUTE insert_prep USING sr.l_seq,sr.glarld,sr.l_glarld_desc,sr.glarcomp,sr.l_glarcomp_desc,sr.glar002,sr.l_period,sr.glar001,sr.l_glar001_desc,sr.glar012,sr.l_glar012_desc,sr.glar013,sr.l_glar013_desc,sr.glar014,sr.l_glar014_desc,sr.glar015,sr.l_glar015_desc,sr.glar016,sr.l_glar016_desc,sr.glar017,sr.l_glar017_desc,sr.glar018,sr.l_glar018_desc,sr.glar019,sr.l_glar019_desc,sr.glar051,sr.l_glar051_desc,sr.glar052,sr.l_glar052_desc,sr.glar053,sr.l_glar053_desc,sr.glar020,sr.l_glar020_desc,sr.glar022,sr.l_glar022_desc,sr.glar023,sr.l_glar023_desc,sr.glar024,sr.l_glar024_desc,sr.glar025,sr.l_glar025_desc,sr.glar026,sr.l_glar026_desc,sr.glar027,sr.l_glar027_desc,sr.glar028,sr.l_glar028_desc,sr.glar029,sr.l_glar029_desc,sr.glar030,sr.l_glar030_desc,sr.glar031,sr.l_glar031_desc,sr.glar032,sr.l_glar032_desc,sr.glar033,sr.l_glar033_desc,sr.glar003,sr.l_style,sr.glar005,sr.glar006,sr.glar034,sr.glar035,sr.glar036,sr.glar037,sr.l_state,sr.l_amt1,sr.l_amt2,sr.l_amt3,sr.glarent
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "aglq750_x01_execute"
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
    LET g_xgrid.visible_column = tm.a1
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aglq750_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION aglq750_x01_rep_data()
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
 
{<section id="aglq750_x01.other_function" readonly="Y" >}

 
{</section>}
 
