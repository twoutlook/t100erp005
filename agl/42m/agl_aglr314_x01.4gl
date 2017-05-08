#該程式未解開Section, 採用最新樣板產出!
{<section id="aglr314_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2015-09-16 13:43:47), PR版次:0001(2015-09-21 10:12:11)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000036
#+ Filename...: aglr314_x01
#+ Description: ...
#+ Creator....: 03080(2015-09-15 14:28:09)
#+ Modifier...: 03080 -SD/PR- 03080
 
{</section>}
 
{<section id="aglr314_x01.global" readonly="Y" >}
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
       wc STRING                   #where condition
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="aglr314_x01.main" readonly="Y" >}
PUBLIC FUNCTION aglr314_x01(p_arg1)
DEFINE  p_arg1 STRING                  #tm.wc  where condition
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "aglr314_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL aglr314_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL aglr314_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL aglr314_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL aglr314_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL aglr314_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="aglr314_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION aglr314_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "glapld.glap_t.glapld,glap002.glap_t.glap002,glap004.glap_t.glap004,glapdocdt.glap_t.glapdocdt,glapownid.glap_t.glapownid,l_glapownid_desc.type_t.chr100,glapdocno.glap_t.glapdocno,glap007.glap_t.glap007,l_glap007_desc.type_t.chr100,glap010.glap_t.glap010,glapstus.glap_t.glapstus,glap009.glap_t.glap009,glap013.glap_t.glap013,glap012.glap_t.glap012,glappstid.glap_t.glappstid,l_glappstid_desc.type_t.chr100,glapcnfid.glap_t.glapcnfid,l_glapcnfid_desc.type_t.chr100,l_yyyymm.type_t.chr100" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="aglr314_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION aglr314_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="aglr314_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aglr314_x01_sel_prep()
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
   LET g_select = " SELECT glapld,glap002,glap004,glapdocdt,glapownid,'',glapdocno,glap007,'',glap010, 
       glapstus,glap009,glap013,glap012,glappstid,'',glapcnfid,'',''"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   
   #end add-point
    LET g_from = " FROM glap_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
 
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("glap_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = g_sql CLIPPED,
               " ORDER BY glapdocdt,glapdocno "
   #end add-point
   PREPARE aglr314_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE aglr314_x01_curs CURSOR FOR aglr314_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="aglr314_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION aglr314_x01_ins_data()
DEFINE sr RECORD 
   glapld LIKE glap_t.glapld, 
   glap002 LIKE glap_t.glap002, 
   glap004 LIKE glap_t.glap004, 
   glapdocdt LIKE glap_t.glapdocdt, 
   glapownid LIKE glap_t.glapownid, 
   l_glapownid_desc LIKE type_t.chr100, 
   glapdocno LIKE glap_t.glapdocno, 
   glap007 LIKE glap_t.glap007, 
   l_glap007_desc LIKE type_t.chr100, 
   glap010 LIKE glap_t.glap010, 
   glapstus LIKE glap_t.glapstus, 
   glap009 LIKE glap_t.glap009, 
   glap013 LIKE glap_t.glap013, 
   glap012 LIKE glap_t.glap012, 
   glappstid LIKE glap_t.glappstid, 
   l_glappstid_desc LIKE type_t.chr100, 
   glapcnfid LIKE glap_t.glapcnfid, 
   l_glapcnfid_desc LIKE type_t.chr100, 
   l_yyyymm LIKE type_t.chr100
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_glapdocno_o       LIKE glap_t.glapdocno
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    LET l_glapdocno_o = ''  #2015/9/18 add
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH aglr314_x01_curs INTO sr.*                               
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
       LET sr.l_glapownid_desc = s_desc_get_person_desc(sr.glapownid) 
       LET sr.l_glap007_desc   =  s_desc_gzcbl004_desc('8007',sr.glap007)
       LET sr.l_glappstid_desc = s_desc_get_person_desc(sr.glappstid) 
       LET sr.l_glapcnfid_desc = s_desc_get_person_desc(sr.glapcnfid) 
       LET sr.l_yyyymm   = sr.glap002,sr.glap004
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.glapld,sr.glap002,sr.glap004,sr.glapdocdt,sr.glapownid,sr.l_glapownid_desc,sr.glapdocno,sr.glap007,sr.l_glap007_desc,sr.glap010,sr.glapstus,sr.glap009,sr.glap013,sr.glap012,sr.glappstid,sr.l_glappstid_desc,sr.glapcnfid,sr.l_glapcnfid_desc,sr.l_yyyymm
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "aglr314_x01_execute"
          LET g_errparam.code   = SQLCA.sqlcode
          LET g_errparam.popup  = FALSE
          CALL cl_err()       
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF
 
       #add-point:ins_data段after_save name="ins_data.after.save"
       #2015/9/18--add--str--
       #更新凭证打印次数
       IF cl_null(l_glapdocno_o) THEN
          UPDATE glap_t SET glap012=glap012 + 1
           WHERE glapent=g_enterprise AND glapld=sr.glapld AND glapdocno=sr.glapdocno
          LET l_glapdocno_o = sr.glapdocno
       ELSE
          IF l_glapdocno_o <> sr.glapdocno THEN
             UPDATE glap_t SET glap012=glap012 + 1
              WHERE glapent=g_enterprise AND glapld=sr.glapld AND glapdocno=sr.glapdocno
             LET l_glapdocno_o = sr.glapdocno
          END IF
       END IF
       #2015/9/18--add--end
       #end add-point
       
    END FOREACH
    
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aglr314_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION aglr314_x01_rep_data()
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
 
{<section id="aglr314_x01.other_function" readonly="Y" >}

 
{</section>}
 