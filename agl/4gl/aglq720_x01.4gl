#該程式未解開Section, 採用最新樣板產出!
{<section id="aglq720_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2015-06-02 16:23:53), PR版次:0001(2015-06-02 13:47:30)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000043
#+ Filename...: aglq720_x01
#+ Description: ...
#+ Creator....: 02599(2015-06-01 11:36:41)
#+ Modifier...: 02291 -SD/PR- 02291
 
{</section>}
 
{<section id="aglq720_x01.global" readonly="Y" >}
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
       a1 STRING,                  #print_tmp 
       a2 STRING                   #visible:where
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_tmp_table     STRING
#end add-point
 
{</section>}
 
{<section id="aglq720_x01.main" readonly="Y" >}
PUBLIC FUNCTION aglq720_x01(p_arg1,p_arg2,p_arg3)
DEFINE  p_arg1 STRING                  #tm.wc  condition:where 
DEFINE  p_arg2 STRING                  #tm.a1  print_tmp 
DEFINE  p_arg3 STRING                  #tm.a2  visible:where
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.a1 = p_arg2
   LET tm.a2 = p_arg3
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   LET g_tmp_table = tm.a1
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "aglq720_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL aglq720_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL aglq720_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL aglq720_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL aglq720_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL aglq720_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="aglq720_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION aglq720_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "l_glaald_desc.type_t.chr500,l_glaacomp_desc.type_t.chr500,l_glaa001_desc.type_t.chr500,l_sdate.type_t.chr500,l_edate.type_t.chr500,l_ctype.type_t.chr500,l_glac005.type_t.chr500,l_stus.type_t.chr500,glar001.glar_t.glar001,l_glar001_desc.type_t.chr500,glar012.glar_t.glar012,l_glar012_desc.type_t.chr500,glar013.glar_t.glar013,l_glar013_desc.type_t.chr500,glar014.glar_t.glar014,l_glar014_desc.type_t.chr500,glar015.glar_t.glar015,l_glar015_desc.type_t.chr500,glar016.glar_t.glar016,l_glar016_desc.type_t.chr500,glar017.glar_t.glar017,l_glar017_desc.type_t.chr500,glar018.glar_t.glar018,l_glar018_desc.type_t.chr500,glar019.glar_t.glar019,l_glar019_desc.type_t.chr500,l_glar051.type_t.chr500,glar052.glar_t.glar052,l_glar052_desc.type_t.chr500,glar053.glar_t.glar053,l_glar053_desc.type_t.chr500,glar020.glar_t.glar020,l_glar020_desc.type_t.chr500,glar022.glar_t.glar022,l_glar022_desc.type_t.chr500,glar023.glar_t.glar023,l_glar023_desc.type_t.chr500,glar024.glar_t.glar024,l_glar024_desc.type_t.chr500,glar025.glar_t.glar025,l_glar025_desc.type_t.chr500,glar026.glar_t.glar026,l_glar026_desc.type_t.chr500,glar027.glar_t.glar027,l_glar027_desc.type_t.chr500,glar028.glar_t.glar028,l_glar028_desc.type_t.chr500,glar029.glar_t.glar029,l_glar029_desc.type_t.chr500,glar030.glar_t.glar030,l_glar030_desc.type_t.chr500,glar031.glar_t.glar031,l_glar031_desc.type_t.chr500,glar032.glar_t.glar032,l_glar032_desc.type_t.chr500,glar033.glar_t.glar033,l_glar033_desc.type_t.chr500,glar009.glar_t.glar009,l_oyeard.glaq_t.glaq003,l_oyearc.glaq_t.glaq003,l_yeard.glaq_t.glaq003,l_yearc.glaq_t.glaq003,l_yeard2.glaq_t.glaq003,l_yearc2.glaq_t.glaq003,l_yeard3.glaq_t.glaq003,l_yearc3.glaq_t.glaq003,l_oqcd.glaq_t.glaq003,l_oqcc.glaq_t.glaq003,l_qcd.glaq_t.glaq003,l_qcc.glaq_t.glaq003,l_qcd2.glaq_t.glaq003,l_qcc2.glaq_t.glaq003,l_qcd3.glaq_t.glaq003,l_qcc3.glaq_t.glaq003,l_oqjd.glaq_t.glaq003,l_oqjc.glaq_t.glaq003,l_qjd.glaq_t.glaq003,l_qjc.glaq_t.glaq003,l_qjd2.glaq_t.glaq003,l_qjc2.glaq_t.glaq003,l_qjd3.glaq_t.glaq003,l_qjc3.glaq_t.glaq003,l_oqmd.glaq_t.glaq003,l_oqmc.glaq_t.glaq003,l_qmd.glaq_t.glaq003,l_qmc.glaq_t.glaq003,l_qmd2.glaq_t.glaq003,l_qmc2.glaq_t.glaq003,l_qmd3.glaq_t.glaq003,l_qmc3.glaq_t.glaq003,l_osumd.glaq_t.glaq003,l_osumc.glaq_t.glaq003,l_sumd.glaq_t.glaq003,l_sumc.glaq_t.glaq003,l_sumd2.glaq_t.glaq003,l_sumc2.glaq_t.glaq003,l_sumd3.glaq_t.glaq003,l_sumc3.glaq_t.glaq003" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="aglq720_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION aglq720_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?, 
             ?,?,?,?)"
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
 
{<section id="aglq720_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aglq720_x01_sel_prep()
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
   LET g_select = " SELECT NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,glar001,NULL,glar012,NULL,glar013, 
       NULL,glar014,NULL,glar015,NULL,glar016,NULL,glar017,NULL,glar018,NULL,glar019,NULL,NULL,glar052, 
       NULL,glar053,NULL,glar020,NULL,glar022,NULL,glar023,NULL,glar024,NULL,glar025,NULL,glar026,NULL, 
       glar027,NULL,glar028,NULL,glar029,NULL,glar030,NULL,glar031,NULL,glar032,NULL,glar033,NULL,glar009, 
       NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 
       NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 
       NULL,NULL"
 
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
   LET g_sql = " SELECT * FROM ", g_tmp_table CLIPPED
   #end add-point
   PREPARE aglq720_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE aglq720_x01_curs CURSOR FOR aglq720_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="aglq720_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION aglq720_x01_ins_data()
DEFINE sr RECORD 
   l_glaald_desc LIKE type_t.chr500, 
   l_glaacomp_desc LIKE type_t.chr500, 
   l_glaa001_desc LIKE type_t.chr500, 
   l_sdate LIKE type_t.chr500, 
   l_edate LIKE type_t.chr500, 
   l_ctype LIKE type_t.chr500, 
   l_glac005 LIKE type_t.chr500, 
   l_stus LIKE type_t.chr500, 
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
   l_glar051 LIKE type_t.chr500, 
   glar052 LIKE glar_t.glar052, 
   l_glar052_desc LIKE type_t.chr500, 
   glar053 LIKE glar_t.glar053, 
   l_glar053_desc LIKE type_t.chr500, 
   glar020 LIKE glar_t.glar020, 
   l_glar020_desc LIKE type_t.chr500, 
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
   glar009 LIKE glar_t.glar009, 
   l_oyeard LIKE glaq_t.glaq003, 
   l_oyearc LIKE glaq_t.glaq003, 
   l_yeard LIKE glaq_t.glaq003, 
   l_yearc LIKE glaq_t.glaq003, 
   l_yeard2 LIKE glaq_t.glaq003, 
   l_yearc2 LIKE glaq_t.glaq003, 
   l_yeard3 LIKE glaq_t.glaq003, 
   l_yearc3 LIKE glaq_t.glaq003, 
   l_oqcd LIKE glaq_t.glaq003, 
   l_oqcc LIKE glaq_t.glaq003, 
   l_qcd LIKE glaq_t.glaq003, 
   l_qcc LIKE glaq_t.glaq003, 
   l_qcd2 LIKE glaq_t.glaq003, 
   l_qcc2 LIKE glaq_t.glaq003, 
   l_qcd3 LIKE glaq_t.glaq003, 
   l_qcc3 LIKE glaq_t.glaq003, 
   l_oqjd LIKE glaq_t.glaq003, 
   l_oqjc LIKE glaq_t.glaq003, 
   l_qjd LIKE glaq_t.glaq003, 
   l_qjc LIKE glaq_t.glaq003, 
   l_qjd2 LIKE glaq_t.glaq003, 
   l_qjc2 LIKE glaq_t.glaq003, 
   l_qjd3 LIKE glaq_t.glaq003, 
   l_qjc3 LIKE glaq_t.glaq003, 
   l_oqmd LIKE glaq_t.glaq003, 
   l_oqmc LIKE glaq_t.glaq003, 
   l_qmd LIKE glaq_t.glaq003, 
   l_qmc LIKE glaq_t.glaq003, 
   l_qmd2 LIKE glaq_t.glaq003, 
   l_qmc2 LIKE glaq_t.glaq003, 
   l_qmd3 LIKE glaq_t.glaq003, 
   l_qmc3 LIKE glaq_t.glaq003, 
   l_osumd LIKE glaq_t.glaq003, 
   l_osumc LIKE glaq_t.glaq003, 
   l_sumd LIKE glaq_t.glaq003, 
   l_sumc LIKE glaq_t.glaq003, 
   l_sumd2 LIKE glaq_t.glaq003, 
   l_sumc2 LIKE glaq_t.glaq003, 
   l_sumd3 LIKE glaq_t.glaq003, 
   l_sumc3 LIKE glaq_t.glaq003
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH aglq720_x01_curs INTO sr.*                               
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
       EXECUTE insert_prep USING sr.l_glaald_desc,sr.l_glaacomp_desc,sr.l_glaa001_desc,sr.l_sdate,sr.l_edate,sr.l_ctype,sr.l_glac005,sr.l_stus,sr.glar001,sr.l_glar001_desc,sr.glar012,sr.l_glar012_desc,sr.glar013,sr.l_glar013_desc,sr.glar014,sr.l_glar014_desc,sr.glar015,sr.l_glar015_desc,sr.glar016,sr.l_glar016_desc,sr.glar017,sr.l_glar017_desc,sr.glar018,sr.l_glar018_desc,sr.glar019,sr.l_glar019_desc,sr.l_glar051,sr.glar052,sr.l_glar052_desc,sr.glar053,sr.l_glar053_desc,sr.glar020,sr.l_glar020_desc,sr.glar022,sr.l_glar022_desc,sr.glar023,sr.l_glar023_desc,sr.glar024,sr.l_glar024_desc,sr.glar025,sr.l_glar025_desc,sr.glar026,sr.l_glar026_desc,sr.glar027,sr.l_glar027_desc,sr.glar028,sr.l_glar028_desc,sr.glar029,sr.l_glar029_desc,sr.glar030,sr.l_glar030_desc,sr.glar031,sr.l_glar031_desc,sr.glar032,sr.l_glar032_desc,sr.glar033,sr.l_glar033_desc,sr.glar009,sr.l_oyeard,sr.l_oyearc,sr.l_yeard,sr.l_yearc,sr.l_yeard2,sr.l_yearc2,sr.l_yeard3,sr.l_yearc3,sr.l_oqcd,sr.l_oqcc,sr.l_qcd,sr.l_qcc,sr.l_qcd2,sr.l_qcc2,sr.l_qcd3,sr.l_qcc3,sr.l_oqjd,sr.l_oqjc,sr.l_qjd,sr.l_qjc,sr.l_qjd2,sr.l_qjc2,sr.l_qjd3,sr.l_qjc3,sr.l_oqmd,sr.l_oqmc,sr.l_qmd,sr.l_qmc,sr.l_qmd2,sr.l_qmc2,sr.l_qmd3,sr.l_qmc3,sr.l_osumd,sr.l_osumc,sr.l_sumd,sr.l_sumc,sr.l_sumd2,sr.l_sumc2,sr.l_sumd3,sr.l_sumc3
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "aglq720_x01_execute"
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
    LET g_xgrid.visible_column = tm.a2
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aglq720_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION aglq720_x01_rep_data()
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
 
{<section id="aglq720_x01.other_function" readonly="Y" >}

 
{</section>}
 
