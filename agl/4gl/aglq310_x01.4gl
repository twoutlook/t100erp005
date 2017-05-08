#該程式未解開Section, 採用最新樣板產出!
{<section id="aglq310_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2015-05-19 16:29:34), PR版次:0001(2015-05-20 10:33:57)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000049
#+ Filename...: aglq310_x01
#+ Description: ...
#+ Creator....: 02291(2015-05-19 15:15:57)
#+ Modifier...: 02291 -SD/PR- 02291
 
{</section>}
 
{<section id="aglq310_x01.global" readonly="Y" >}
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
       wc STRING,                  #where.condition 
       a1 STRING,                  #print_tmp 
       a2 LIKE type_t.chr1,         #ctype 
       a3 LIKE type_t.chr1          #
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_tmp_table     STRING
#end add-point
 
{</section>}
 
{<section id="aglq310_x01.main" readonly="Y" >}
PUBLIC FUNCTION aglq310_x01(p_arg1,p_arg2,p_arg3,p_arg4)
DEFINE  p_arg1 STRING                  #tm.wc  where.condition 
DEFINE  p_arg2 STRING                  #tm.a1  print_tmp 
DEFINE  p_arg3 LIKE type_t.chr1         #tm.a2  ctype 
DEFINE  p_arg4 LIKE type_t.chr1         #tm.a3
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
   LET g_rep_code = "aglq310_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL aglq310_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL aglq310_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL aglq310_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL aglq310_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL aglq310_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="aglq310_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION aglq310_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "l_glaald_desc.type_t.chr500,l_glaacomp_desc.type_t.chr500,l_curr_desc.type_t.chr500,l_sdate.type_t.chr50,l_edate.type_t.chr50,l_ctype.type_t.chr20,l_stus_desc.type_t.chr20,glapdocdt.glap_t.glapdocdt,glap002.glap_t.glap002,glap004.glap_t.glap004,glapdocno.glap_t.glapdocno,glaqseq.glaq_t.glaqseq,glaq001.glaq_t.glaq001,glaq002.glaq_t.glaq002,l_glaq002_desc.type_t.chr500,glaq005.glaq_t.glaq005,l_glaq005_desc.type_t.chr500,glaq010.glaq_t.glaq010,glaq006.glaq_t.glaq006,glaq003.glaq_t.glaq003,glaq004.glaq_t.glaq004,glaq039.glaq_t.glaq039,glaq040.glaq_t.glaq040,glaq041.glaq_t.glaq041,glaq042.glaq_t.glaq042,glaq043.glaq_t.glaq043,glaq044.glaq_t.glaq044,glaq017.glaq_t.glaq017,l_glaq017_desc.type_t.chr500,glaq018.glaq_t.glaq018,l_glaq018_desc.type_t.chr500,glaq019.glaq_t.glaq019,l_glaq019_desc.type_t.chr500,glaq020.glaq_t.glaq020,l_glaq020_desc.type_t.chr500,glaq021.glaq_t.glaq021,l_glaq021_desc.type_t.chr500,glaq022.glaq_t.glaq022,l_glaq022_desc.type_t.chr500,glaq023.glaq_t.glaq023,l_glaq023_desc.type_t.chr500,glaq024.glaq_t.glaq024,l_glaq024_desc.type_t.chr500,l_glbc004.type_t.chr500,l_glbc004_desc.type_t.chr500,glaq051.glaq_t.glaq051,glaq052.glaq_t.glaq052,l_glaq052_desc.type_t.chr500,glaq053.glaq_t.glaq053,l_glaq053_desc.type_t.chr500,glaq025.glaq_t.glaq025,l_glaq025_desc.type_t.chr500,glaq027.glaq_t.glaq027,l_glaq027_desc.type_t.chr500,glaq028.glaq_t.glaq028,l_glaq028_desc.type_t.chr500,glaq029.glaq_t.glaq029,l_glaq029_desc.type_t.chr500,glaq030.glaq_t.glaq030,l_glaq030_desc.type_t.chr500,glaq031.glaq_t.glaq031,l_glaq031_desc.type_t.chr500,glaq032.glaq_t.glaq032,l_glaq032_desc.type_t.chr500,glaq033.glaq_t.glaq033,l_glaq033_desc.type_t.chr500,glaq034.glaq_t.glaq034,l_glaq034_desc.type_t.chr500,glaq035.glaq_t.glaq035,l_glaq035_desc.type_t.chr500,glaq036.glaq_t.glaq036,l_glaq036_desc.type_t.chr500,glaq037.glaq_t.glaq037,l_glaq037_desc.type_t.chr500,glaq038.glaq_t.glaq038,l_glaq038_desc.type_t.chr500,l_glapownid_desc.type_t.chr500,l_glapcnfid_desc.type_t.chr500,l_glappstid_desc.type_t.chr500,glap013.glap_t.glap013,glap009.glap_t.glap009" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="aglq310_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION aglq310_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="aglq310_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aglq310_x01_sel_prep()
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
   LET g_select = " SELECT NULL,NULL,NULL,NULL,NULL,NULL,NULL,glapdocdt,glap002,glap004,glapdocno,glaqseq, 
       glaq001,glaq002,NULL,glaq005,NULL,glaq010,glaq006,glaq003,glaq004,glaq039,glaq040,glaq041,glaq042, 
       glaq043,glaq044,glaq017,NULL,glaq018,NULL,glaq019,NULL,glaq020,NULL,glaq021,NULL,glaq022,NULL, 
       glaq023,NULL,glaq024,NULL,NULL,NULL,glaq051,glaq052,NULL,glaq053,NULL,glaq025,NULL,glaq027,NULL, 
       glaq028,NULL,glaq029,NULL,glaq030,NULL,glaq031,NULL,glaq032,NULL,glaq033,NULL,glaq034,NULL,glaq035, 
       NULL,glaq036,NULL,glaq037,NULL,glaq038,NULL,NULL,NULL,NULL,glap013,glap009"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   
   #end add-point
    LET g_from = " FROM glaq_t,glap_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("glaq_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = " SELECT * FROM ", g_tmp_table CLIPPED," ORDER BY glapdocdt,glapdocno,glaqseq"
   #end add-point
   PREPARE aglq310_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE aglq310_x01_curs CURSOR FOR aglq310_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="aglq310_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION aglq310_x01_ins_data()
DEFINE sr RECORD 
   l_glaald_desc LIKE type_t.chr500, 
   l_glaacomp_desc LIKE type_t.chr500, 
   l_curr_desc LIKE type_t.chr500, 
   l_sdate LIKE type_t.chr50, 
   l_edate LIKE type_t.chr50, 
   l_ctype LIKE type_t.chr20, 
   l_stus_desc LIKE type_t.chr20, 
   glapdocdt LIKE glap_t.glapdocdt, 
   glap002 LIKE glap_t.glap002, 
   glap004 LIKE glap_t.glap004, 
   glapdocno LIKE glap_t.glapdocno, 
   glaqseq LIKE glaq_t.glaqseq, 
   glaq001 LIKE glaq_t.glaq001, 
   glaq002 LIKE glaq_t.glaq002, 
   l_glaq002_desc LIKE type_t.chr500, 
   glaq005 LIKE glaq_t.glaq005, 
   l_glaq005_desc LIKE type_t.chr500, 
   glaq010 LIKE glaq_t.glaq010, 
   glaq006 LIKE glaq_t.glaq006, 
   glaq003 LIKE glaq_t.glaq003, 
   glaq004 LIKE glaq_t.glaq004, 
   glaq039 LIKE glaq_t.glaq039, 
   glaq040 LIKE glaq_t.glaq040, 
   glaq041 LIKE glaq_t.glaq041, 
   glaq042 LIKE glaq_t.glaq042, 
   glaq043 LIKE glaq_t.glaq043, 
   glaq044 LIKE glaq_t.glaq044, 
   glaq017 LIKE glaq_t.glaq017, 
   l_glaq017_desc LIKE type_t.chr500, 
   glaq018 LIKE glaq_t.glaq018, 
   l_glaq018_desc LIKE type_t.chr500, 
   glaq019 LIKE glaq_t.glaq019, 
   l_glaq019_desc LIKE type_t.chr500, 
   glaq020 LIKE glaq_t.glaq020, 
   l_glaq020_desc LIKE type_t.chr500, 
   glaq021 LIKE glaq_t.glaq021, 
   l_glaq021_desc LIKE type_t.chr500, 
   glaq022 LIKE glaq_t.glaq022, 
   l_glaq022_desc LIKE type_t.chr500, 
   glaq023 LIKE glaq_t.glaq023, 
   l_glaq023_desc LIKE type_t.chr500, 
   glaq024 LIKE glaq_t.glaq024, 
   l_glaq024_desc LIKE type_t.chr500, 
   l_glbc004 LIKE type_t.chr500, 
   l_glbc004_desc LIKE type_t.chr500, 
   glaq051 LIKE glaq_t.glaq051, 
   glaq052 LIKE glaq_t.glaq052, 
   l_glaq052_desc LIKE type_t.chr500, 
   glaq053 LIKE glaq_t.glaq053, 
   l_glaq053_desc LIKE type_t.chr500, 
   glaq025 LIKE glaq_t.glaq025, 
   l_glaq025_desc LIKE type_t.chr500, 
   glaq027 LIKE glaq_t.glaq027, 
   l_glaq027_desc LIKE type_t.chr500, 
   glaq028 LIKE glaq_t.glaq028, 
   l_glaq028_desc LIKE type_t.chr500, 
   glaq029 LIKE glaq_t.glaq029, 
   l_glaq029_desc LIKE type_t.chr500, 
   glaq030 LIKE glaq_t.glaq030, 
   l_glaq030_desc LIKE type_t.chr500, 
   glaq031 LIKE glaq_t.glaq031, 
   l_glaq031_desc LIKE type_t.chr500, 
   glaq032 LIKE glaq_t.glaq032, 
   l_glaq032_desc LIKE type_t.chr500, 
   glaq033 LIKE glaq_t.glaq033, 
   l_glaq033_desc LIKE type_t.chr500, 
   glaq034 LIKE glaq_t.glaq034, 
   l_glaq034_desc LIKE type_t.chr500, 
   glaq035 LIKE glaq_t.glaq035, 
   l_glaq035_desc LIKE type_t.chr500, 
   glaq036 LIKE glaq_t.glaq036, 
   l_glaq036_desc LIKE type_t.chr500, 
   glaq037 LIKE glaq_t.glaq037, 
   l_glaq037_desc LIKE type_t.chr500, 
   glaq038 LIKE glaq_t.glaq038, 
   l_glaq038_desc LIKE type_t.chr500, 
   l_glapownid_desc LIKE type_t.chr500, 
   l_glapcnfid_desc LIKE type_t.chr500, 
   l_glappstid_desc LIKE type_t.chr500, 
   glap013 LIKE glap_t.glap013, 
   glap009 LIKE glap_t.glap009
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH aglq310_x01_curs INTO sr.*                               
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
       EXECUTE insert_prep USING sr.l_glaald_desc,sr.l_glaacomp_desc,sr.l_curr_desc,sr.l_sdate,sr.l_edate,sr.l_ctype,sr.l_stus_desc,sr.glapdocdt,sr.glap002,sr.glap004,sr.glapdocno,sr.glaqseq,sr.glaq001,sr.glaq002,sr.l_glaq002_desc,sr.glaq005,sr.l_glaq005_desc,sr.glaq010,sr.glaq006,sr.glaq003,sr.glaq004,sr.glaq039,sr.glaq040,sr.glaq041,sr.glaq042,sr.glaq043,sr.glaq044,sr.glaq017,sr.l_glaq017_desc,sr.glaq018,sr.l_glaq018_desc,sr.glaq019,sr.l_glaq019_desc,sr.glaq020,sr.l_glaq020_desc,sr.glaq021,sr.l_glaq021_desc,sr.glaq022,sr.l_glaq022_desc,sr.glaq023,sr.l_glaq023_desc,sr.glaq024,sr.l_glaq024_desc,sr.l_glbc004,sr.l_glbc004_desc,sr.glaq051,sr.glaq052,sr.l_glaq052_desc,sr.glaq053,sr.l_glaq053_desc,sr.glaq025,sr.l_glaq025_desc,sr.glaq027,sr.l_glaq027_desc,sr.glaq028,sr.l_glaq028_desc,sr.glaq029,sr.l_glaq029_desc,sr.glaq030,sr.l_glaq030_desc,sr.glaq031,sr.l_glaq031_desc,sr.glaq032,sr.l_glaq032_desc,sr.glaq033,sr.l_glaq033_desc,sr.glaq034,sr.l_glaq034_desc,sr.glaq035,sr.l_glaq035_desc,sr.glaq036,sr.l_glaq036_desc,sr.glaq037,sr.l_glaq037_desc,sr.glaq038,sr.l_glaq038_desc,sr.l_glapownid_desc,sr.l_glapcnfid_desc,sr.l_glappstid_desc,sr.glap013,sr.glap009
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "aglq310_x01_execute"
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
    #顯示本位幣二
    IF tm.a2='1' THEN 
       LET g_xgrid.visible_column = "glaq042|glaq043|glaq044"
    END IF
    #顯示本位幣三
    IF tm.a2='2' THEN
       LET g_xgrid.visible_column = "glaq039|glaq040|glaq041"
    END IF
    #只顯示本位幣一
    IF tm.a2='0' THEN
       LET g_xgrid.visible_column = "glaq039|glaq040|glaq041|glaq042|glaq043|glaq044"
    END IF
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aglq310_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION aglq310_x01_rep_data()
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
 
{<section id="aglq310_x01.other_function" readonly="Y" >}

 
{</section>}
 
