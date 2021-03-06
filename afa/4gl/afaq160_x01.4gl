#該程式未解開Section, 採用最新樣板產出!
{<section id="afaq160_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2016-12-19 15:32:33), PR版次:0001(2016-12-19 15:34:44)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: afaq160_x01
#+ Description: ...
#+ Creator....: 07900(2016-11-16 13:11:50)
#+ Modifier...: 07900 -SD/PR- 07900
 
{</section>}
 
{<section id="afaq160_x01.global" readonly="Y" >}
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
       a1 STRING                   #临时表
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_tmp_table           STRING
#end add-point
 
{</section>}
 
{<section id="afaq160_x01.main" readonly="Y" >}
PUBLIC FUNCTION afaq160_x01(p_arg1,p_arg2)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 STRING                  #tm.a1  临时表
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
   LET g_rep_code = "afaq160_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL afaq160_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL afaq160_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL afaq160_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL afaq160_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL afaq160_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="afaq160_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION afaq160_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "l_ooef001_desc.type_t.chr80,l_glaald_desc.type_t.chr80,l_faaj009.type_t.num5,l_faaj010_1.type_t.num5,l_faaj010_2.type_t.num5,l_faah006_desc.type_t.chr500,l_faah007_desc.type_t.chr500,l_faah032_desc.type_t.chr500,faah003.faah_t.faah003,faah004.faah_t.faah004,faah001.faah_t.faah001,faah012.faah_t.faah012,faah013.faah_t.faah013,faaj023.faaj_t.faaj023,l_faaj023.type_t.chr80,l_faaj048_desc.type_t.chr80,l_faan014.type_t.num20_6,l_faaj016.type_t.num20_6,l_faaj017.type_t.num20_6,l_fabh010.type_t.num20_6,l_faaj018.type_t.num20_6,l_fabh011.type_t.num20_6,l_fabh012.type_t.num20_6,l_fabh022.type_t.num20_6,l_fabo018.type_t.num20_6,l_fabh008.type_t.num20_6,l_fabr043.type_t.num20_6,l_fabh009.type_t.num20_6,l_fabo019.type_t.num20_6,l_fabr041.type_t.num20_6,l_faan015.type_t.num20_6" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="afaq160_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION afaq160_x01_ins_prep()
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
 
{<section id="afaq160_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION afaq160_x01_sel_prep()
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
   LET g_select = " SELECT '','',NULL,NULL,NULL,'','','',faah003,faah004,faah001,faah012,faah013,faaj023, 
       NULL,'',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   
   #end add-point
    LET g_from = " FROM faah_t,faaj_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("faah_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = "SELECT * FROM ",g_tmp_table CLIPPED
   LET g_sql = g_sql," ORDER BY faah006_desc,faah007_desc,faah003 "
   #end add-point
   PREPARE afaq160_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE afaq160_x01_curs CURSOR FOR afaq160_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="afaq160_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION afaq160_x01_ins_data()
DEFINE sr RECORD 
   l_ooef001_desc LIKE type_t.chr80, 
   l_glaald_desc LIKE type_t.chr80, 
   l_faaj009 LIKE type_t.num5, 
   l_faaj010_1 LIKE type_t.num5, 
   l_faaj010_2 LIKE type_t.num5, 
   l_faah006_desc LIKE type_t.chr500, 
   l_faah007_desc LIKE type_t.chr500, 
   l_faah032_desc LIKE type_t.chr500, 
   faah003 LIKE faah_t.faah003, 
   faah004 LIKE faah_t.faah004, 
   faah001 LIKE faah_t.faah001, 
   faah012 LIKE faah_t.faah012, 
   faah013 LIKE faah_t.faah013, 
   faaj023 LIKE faaj_t.faaj023, 
   l_faaj023 LIKE type_t.chr80, 
   l_faaj048_desc LIKE type_t.chr80, 
   l_faan014 LIKE type_t.num20_6, 
   l_faaj016 LIKE type_t.num20_6, 
   l_faaj017 LIKE type_t.num20_6, 
   l_fabh010 LIKE type_t.num20_6, 
   l_faaj018 LIKE type_t.num20_6, 
   l_fabh011 LIKE type_t.num20_6, 
   l_fabh012 LIKE type_t.num20_6, 
   l_fabh022 LIKE type_t.num20_6, 
   l_fabo018 LIKE type_t.num20_6, 
   l_fabh008 LIKE type_t.num20_6, 
   l_fabr043 LIKE type_t.num20_6, 
   l_fabh009 LIKE type_t.num20_6, 
   l_fabo019 LIKE type_t.num20_6, 
   l_fabr041 LIKE type_t.num20_6, 
   l_faan015 LIKE type_t.num20_6
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_gzdel003  LIKE gzdel_t.gzdel003
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH afaq160_x01_curs INTO sr.*                               
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
       EXECUTE insert_prep USING sr.l_ooef001_desc,sr.l_glaald_desc,sr.l_faaj009,sr.l_faaj010_1,sr.l_faaj010_2,sr.l_faah006_desc,sr.l_faah007_desc,sr.l_faah032_desc,sr.faah003,sr.faah004,sr.faah001,sr.faah012,sr.faah013,sr.faaj023,sr.l_faaj023,sr.l_faaj048_desc,sr.l_faan014,sr.l_faaj016,sr.l_faaj017,sr.l_fabh010,sr.l_faaj018,sr.l_fabh011,sr.l_fabh012,sr.l_fabh022,sr.l_fabo018,sr.l_fabh008,sr.l_fabr043,sr.l_fabh009,sr.l_fabo019,sr.l_fabr041,sr.l_faan015
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "afaq160_x01_execute"
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
    #报表标题
    SELECT gzdel003 INTO l_gzdel003
      FROM gzdel_t
     WHERE gzdel001 = 'afaq160_x01'
       AND gzdel002 = g_dlang
       
    LET g_rep_code_desc = l_gzdel003  
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afaq160_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION afaq160_x01_rep_data()
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
 
{<section id="afaq160_x01.other_function" readonly="Y" >}

 
{</section>}
 
