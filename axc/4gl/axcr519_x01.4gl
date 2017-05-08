#該程式未解開Section, 採用最新樣板產出!
{<section id="axcr519_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2015-04-14 11:10:29), PR版次:0001(2015-04-14 14:44:22)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000023
#+ Filename...: axcr519_x01
#+ Description: ...
#+ Creator....: 05426(2015-04-14 10:35:59)
#+ Modifier...: 05426 -SD/PR- 05426
 
{</section>}
 
{<section id="axcr519_x01.global" readonly="Y" >}
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
       wc STRING,                  #QBE 
       flag1 LIKE type_t.chr1,         #隱藏成本域否 
       flag2 LIKE type_t.chr1,         #隱藏明細否 
       flag3 LIKE type_t.chr1,         #隱藏特性否 
       flag4 LIKE type_t.chr1          #隱藏成本要素
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="axcr519_x01.main" readonly="Y" >}
PUBLIC FUNCTION axcr519_x01(p_arg1,p_arg2,p_arg3,p_arg4,p_arg5)
DEFINE  p_arg1 STRING                  #tm.wc  QBE 
DEFINE  p_arg2 LIKE type_t.chr1         #tm.flag1  隱藏成本域否 
DEFINE  p_arg3 LIKE type_t.chr1         #tm.flag2  隱藏明細否 
DEFINE  p_arg4 LIKE type_t.chr1         #tm.flag3  隱藏特性否 
DEFINE  p_arg5 LIKE type_t.chr1         #tm.flag4  隱藏成本要素
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.flag1 = p_arg2
   LET tm.flag2 = p_arg3
   LET tm.flag3 = p_arg4
   LET tm.flag4 = p_arg5
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "axcr519_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL axcr519_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL axcr519_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL axcr519_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL axcr519_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL axcr519_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="axcr519_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION axcr519_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "xccksite.xcck_t.xccksite,xccksite_desc.type_t.chr100,xcck002.xcck_t.xcck002,xcck002_desc.type_t.chr100,xcck013.xcck_t.xcck013,xcck006.xcck_t.xcck006,xcck007.xcck_t.xcck007,xcck008.xcck_t.xcck008,xcck015.xcck_t.xcck015,xcck015_desc.type_t.chr100,xcck010.xcck_t.xcck010,imaal003.imaal_t.imaal003,imaal004.imaal_t.imaal004,xcck011.xcck_t.xcck011,xcck017.xcck_t.xcck017,xcck044.xcck_t.xcck044,xcck044_desc.type_t.chr100,xcck009.xcck_t.xcck009,xcck201.xcck_t.xcck201,xcck282a.xcck_t.xcck282a,xcck282b.xcck_t.xcck282b,xcck282c.xcck_t.xcck282c,xcck282d.xcck_t.xcck282d,xcck282e.xcck_t.xcck282e,xcck282f.xcck_t.xcck282f,xcck282g.xcck_t.xcck282g,xcck282h.xcck_t.xcck282h,xcck282.xcck_t.xcck282,xcck202a.xcck_t.xcck202a,xcck202b.xcck_t.xcck202b,xcck202c.xcck_t.xcck202c,xcck202d.xcck_t.xcck202d,xcck202e.xcck_t.xcck202e,xcck202f.xcck_t.xcck202f,xcck202g.xcck_t.xcck202g,xcck202h.xcck_t.xcck202h,xcck202.xcck_t.xcck202,l_flag1.type_t.chr1,l_flag2.type_t.chr1,l_flag3.type_t.chr1,l_flag4.type_t.chr1" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="axcr519_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION axcr519_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="axcr519_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axcr519_x01_sel_prep()
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
   LET g_select = " SELECT xccksite,NULL,xcck002,NULL,xcck013,xcck006,xcck007,xcck008,xcck015,NULL,xcck010, 
       NULL,NULL,xcck011,xcck017,xcck044,NULL,xcck009,xcck201,xcck282a,xcck282b,xcck282c,xcck282d,xcck282e, 
       xcck282f,xcck282g,xcck282h,xcck282,xcck202a,xcck202b,xcck202c,xcck202d,xcck202e,xcck202f,xcck202g, 
       xcck202h,xcck202,NULL,NULL,NULL,NULL"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_select = "SELECT xccksite,ooefl_t.ooefl003,xcck002,xcbfl_t.xcbfl003, 
       xcck013,xcck006,xcck007,xcck008,xcck015,inayl003,xcck010,imaal003,imaal004,xcck011,xcck017,
       xcck044,oocal_t.oocal003,xcck009,xcck009*xcck201,xcck009*xcck282a,xcck009*xcck282b,xcck009*xcck282c,
       xcck009*xcck282d,xcck009*xcck282e,xcck009*xcck282f,xcck009*xcck282g,xcck009*xcck282h,xcck009*xcck282,
       xcck009*xcck202a,xcck009*xcck202b,xcck009*xcck202c,xcck009*xcck202d,xcck009*xcck202e,xcck009*xcck202f,
       xcck009*xcck202g,xcck009*xcck202h,xcck009*xcck202,NULL,NULL,NULL,NULL"
   #end add-point
    LET g_from = " FROM xcck_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET g_from=" FROM  xcck_t","    LEFT JOIN imag_t ON  imag001=xcck010 AND imagsite=xccksite AND imagent=xcckent",
                     "             LEFT JOIN imaa_t ON  imaaent=xcckent AND imaa001=xcck010",                                         
                     "             LEFT OUTER JOIN xcbfl_t ON xcbfl_t.xcbfl001 = xcck_t.xcck002 AND xcbfl_t.xcbflent = xcck_t.xcckent AND xcbfl_t.xcbfl002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN imaal_t ON imaal_t.imaal001 = xcck_t.xcck010 AND imaal_t.imaalent = xcck_t.xcckent AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN oocal_t ON oocal_t.oocal001 = xcck_t.xcck044 AND oocal_t.oocalent = xcck_t.xcckent AND oocal_t.oocal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN ooefl_t ON ooefl_t.ooeflent = xcck_t.xcckent AND ooefl_t.ooefl001 = xcck_t.xccksite AND ooefl_t.ooefl002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN inayl_t ON inaylent=xcckent AND inayl001=xcck015 AND inayl002='",
        g_dlang,"'" ,"             LEFT OUTER JOIN oocal_t ON oocal_t.oocal001 = xcck_t.xcck044 AND oocal_t.oocalent = xcck_t.xcckent AND oocal_t.oocal002 = '" , 
        g_dlang,"'" 
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("xcck_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE axcr519_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE axcr519_x01_curs CURSOR FOR axcr519_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="axcr519_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION axcr519_x01_ins_data()
DEFINE sr RECORD 
   xccksite LIKE xcck_t.xccksite, 
   xccksite_desc LIKE type_t.chr100, 
   xcck002 LIKE xcck_t.xcck002, 
   xcck002_desc LIKE type_t.chr100, 
   xcck013 LIKE xcck_t.xcck013, 
   xcck006 LIKE xcck_t.xcck006, 
   xcck007 LIKE xcck_t.xcck007, 
   xcck008 LIKE xcck_t.xcck008, 
   xcck015 LIKE xcck_t.xcck015, 
   xcck015_desc LIKE type_t.chr100, 
   xcck010 LIKE xcck_t.xcck010, 
   imaal003 LIKE imaal_t.imaal003, 
   imaal004 LIKE imaal_t.imaal004, 
   xcck011 LIKE xcck_t.xcck011, 
   xcck017 LIKE xcck_t.xcck017, 
   xcck044 LIKE xcck_t.xcck044, 
   xcck044_desc LIKE type_t.chr100, 
   xcck009 LIKE xcck_t.xcck009, 
   xcck201 LIKE xcck_t.xcck201, 
   xcck282a LIKE xcck_t.xcck282a, 
   xcck282b LIKE xcck_t.xcck282b, 
   xcck282c LIKE xcck_t.xcck282c, 
   xcck282d LIKE xcck_t.xcck282d, 
   xcck282e LIKE xcck_t.xcck282e, 
   xcck282f LIKE xcck_t.xcck282f, 
   xcck282g LIKE xcck_t.xcck282g, 
   xcck282h LIKE xcck_t.xcck282h, 
   xcck282 LIKE xcck_t.xcck282, 
   xcck202a LIKE xcck_t.xcck202a, 
   xcck202b LIKE xcck_t.xcck202b, 
   xcck202c LIKE xcck_t.xcck202c, 
   xcck202d LIKE xcck_t.xcck202d, 
   xcck202e LIKE xcck_t.xcck202e, 
   xcck202f LIKE xcck_t.xcck202f, 
   xcck202g LIKE xcck_t.xcck202g, 
   xcck202h LIKE xcck_t.xcck202h, 
   xcck202 LIKE xcck_t.xcck202, 
   l_flag1 LIKE type_t.chr1, 
   l_flag2 LIKE type_t.chr1, 
   l_flag3 LIKE type_t.chr1, 
   l_flag4 LIKE type_t.chr1
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH axcr519_x01_curs INTO sr.*                               
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
       EXECUTE insert_prep USING sr.xccksite,sr.xccksite_desc,sr.xcck002,sr.xcck002_desc,sr.xcck013,sr.xcck006,sr.xcck007,sr.xcck008,sr.xcck015,sr.xcck015_desc,sr.xcck010,sr.imaal003,sr.imaal004,sr.xcck011,sr.xcck017,sr.xcck044,sr.xcck044_desc,sr.xcck009,sr.xcck201,sr.xcck282a,sr.xcck282b,sr.xcck282c,sr.xcck282d,sr.xcck282e,sr.xcck282f,sr.xcck282g,sr.xcck282h,sr.xcck282,sr.xcck202a,sr.xcck202b,sr.xcck202c,sr.xcck202d,sr.xcck202e,sr.xcck202f,sr.xcck202g,sr.xcck202h,sr.xcck202,sr.l_flag1,sr.l_flag2,sr.l_flag3,sr.l_flag4
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "axcr519_x01_execute"
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
 
{<section id="axcr519_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION axcr519_x01_rep_data()
#add-point:rep_data.define (客製用) name="rep_data.define_customerization"

#end add-point:rep_data.define
#add-point:rep_data.define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="rep_data.define"

#end add-point:rep_data.define
 
    #add-point:rep_data.before name="rep_data.before"
    #隐藏成本域否
    IF tm.flag1 = 'N' THEN
      LET g_xgrid.visible_column = "xcck002|xcck002_desc"
    END IF
    #隐藏明细否
    IF tm.flag2 = 'N' THEN
      LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED,"|xcck013|xcck006|xcck007|xcck008|xcck015|xcck015_desc"
    END IF
    #隐藏特性否
    IF tm.flag3 = 'N' THEN
      LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED,"|xcck011"
    END IF
    #隐藏要素否
    IF tm.flag4 = 'N' THEN
      LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED,"|xcck282a|xcck282b|xcck282c|xcck282d|xcck282e|xcck282f|xcck282g|xcck282h|xcck202a|xcck202b|xcck202c|xcck202d|xcck202e|xcck202f|xcck202g|xcck202h"
    END IF

    #end add-point:rep_data.before
    
    CALL cl_xg_view()
    #add-point:rep_data.after name="rep_data.after"
    
    #end add-point:rep_data.after
END FUNCTION
 
{</section>}
 
{<section id="axcr519_x01.other_function" readonly="Y" >}

 
{</section>}
 
