#該程式未解開Section, 採用最新樣板產出!
{<section id="afaq152_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2017-01-13 17:04:33), PR版次:0002(2017-01-13 17:14:06)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000048
#+ Filename...: afaq152_x01
#+ Description: ...
#+ Creator....: 01251(2015-03-26 18:01:57)
#+ Modifier...: 07900 -SD/PR- 07900
 
{</section>}
 
{<section id="afaq152_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#170111-00025#1   2017/01/13  By 07900    存放位置加上说明
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
       comp LIKE ooef_t.ooef001          #法人組織
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="afaq152_x01.main" readonly="Y" >}
PUBLIC FUNCTION afaq152_x01(p_arg1,p_arg2)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE ooef_t.ooef001         #tm.comp  法人組織
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.comp = p_arg2
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "afaq152_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL afaq152_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL afaq152_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL afaq152_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL afaq152_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL afaq152_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="afaq152_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION afaq152_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "faah003.faah_t.faah003,faah004.faah_t.faah004,faah001.faah_t.faah001,faaiseq.faai_t.faaiseq,faai004.faai_t.faai004,faai012.faai_t.faai012,faai013.faai_t.faai013,faai005.faai_t.faai005,faai006.faai_t.faai006,faai007.faai_t.faai007,faai008.faai_t.faai008,faai014.faai_t.faai014,faai015.faai_t.faai015,faai015_desc.type_t.chr200,faai016.faai_t.faai016,faai016_desc.type_t.chr200,faai017.faai_t.faai017,l_faai017_desc.type_t.chr80,faai023.faai_t.faai023,faai023_desc.type_t.chr200" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="afaq152_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION afaq152_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="afaq152_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION afaq152_x01_sel_prep()
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
   LET g_select = " SELECT faah003,faah004,faah001,faaiseq,faai004,faai012,faai013,faai005,faai006,faai007, 
       faai008,faai014,faai015,NULL,faai016,NULL,faai017,NULL,faai023,NULL"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_select =  "SELECT  UNIQUE faah003,faah004,faah001,faaiseq,faai004,faai012,faai013,faai005,faai006,faai007,faai008,faai014,faai015,NULL,faai016,NULL,faai017,faai023,NULL "
   #end add-point
    LET g_from = " FROM faah_t,faai_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET g_from = "  FROM faah_t LEFT JOIN faai_t ON faahent = faaient AND faah003 = faai002 AND faah004 = faai003 AND faah001 = faai001"
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   LET g_where = " WHERE faahent = '",g_enterprise,"'",
                  "  AND faah032 = '",tm.comp,"'",
                  "  AND ",tm.wc CLIPPED, 
                  "  AND faahstus = 'Y' "              
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("faah_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = g_sql CLIPPED," ORDER BY faah003,faah004,faah001,faaiseq "
   #end add-point
   PREPARE afaq152_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE afaq152_x01_curs CURSOR FOR afaq152_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="afaq152_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION afaq152_x01_ins_data()
DEFINE sr RECORD 
   faah003 LIKE faah_t.faah003, 
   faah004 LIKE faah_t.faah004, 
   faah001 LIKE faah_t.faah001, 
   faaiseq LIKE faai_t.faaiseq, 
   faai004 LIKE faai_t.faai004, 
   faai012 LIKE faai_t.faai012, 
   faai013 LIKE faai_t.faai013, 
   faai005 LIKE faai_t.faai005, 
   faai006 LIKE faai_t.faai006, 
   faai007 LIKE faai_t.faai007, 
   faai008 LIKE faai_t.faai008, 
   faai014 LIKE faai_t.faai014, 
   faai015 LIKE faai_t.faai015, 
   faai015_desc LIKE type_t.chr200, 
   faai016 LIKE faai_t.faai016, 
   faai016_desc LIKE type_t.chr200, 
   faai017 LIKE faai_t.faai017, 
   l_faai017_desc LIKE type_t.chr80, 
   faai023 LIKE faai_t.faai023, 
   faai023_desc LIKE type_t.chr200
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH afaq152_x01_curs INTO sr.*                               
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

      IF cl_null(sr.faaiseq) THEN 
         SELECT faah012,faah013,faah017,faah018,faah019,faah014,faah025,faah026,faah027,faah015
           INTO sr.faai012,sr.faai013,sr.faai006,sr.faai007,sr.faai008,sr.faai014,
                sr.faai015,sr.faai016,sr.faai017,sr.faai023
           FROM faah_t
          WHERE faahent = g_enterprise
            AND faah001 = sr.faah001
            AND faah003 = sr.faah003
            AND faah004 = sr.faah004
      END IF
       #170111-00025#1--add--s--
       #存放位置名称
      SELECT oocql004 INTO sr.l_faai017_desc
        FROM oocql_t
       WHERE oocqlent = g_enterprise AND oocql001 = '3900' 
         AND oocql002 = sr.faai017 AND oocql003 = g_dlang 
       #170111-00025#1--add--e--
       #部門名稱
       SELECT ooefl003 INTO sr.faai016_desc
         FROM ooefl_t 
        WHERE ooeflent=g_enterprise
          AND ooefl001=sr.faai016
          AND ooefl002 =g_dlang 
      #人員名稱          
      SELECT ooag011 INTO sr.faai015_desc
        FROM ooag_t
       WHERE ooagent=g_enterprise
         AND ooag001= sr.faai015      
      #資產狀態
      CASE sr.faai023
         WHEN '0'
                LET sr.faai023_desc = cl_getmsg("afa-00438",g_lang)
         WHEN '1'            
                LET sr.faai023_desc = cl_getmsg("afa-00439",g_lang)
         WHEN '2'             
                LET sr.faai023_desc = cl_getmsg("afa-00440",g_lang)
         WHEN '3'             
                LET sr.faai023_desc = cl_getmsg("afa-00441",g_lang)
         WHEN '4'            
                LET sr.faai023_desc = cl_getmsg("afa-00442",g_lang)
         WHEN '5'             
                LET sr.faai023_desc = cl_getmsg("afa-00443",g_lang)
         WHEN '6'             
                LET sr.faai023_desc = cl_getmsg("afa-00444",g_lang)
         WHEN '7'            
                LET sr.faai023_desc = cl_getmsg("afa-00445",g_lang)
         WHEN '8'             
                LET sr.faai023_desc = cl_getmsg("afa-00446",g_lang)
         WHEN '9'             
                LET sr.faai023_desc = cl_getmsg("afa-00447",g_lang)
         WHEN '10'            
                LET sr.faai023_desc = cl_getmsg("afa-00448",g_lang)
      END CASE       
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.faah003,sr.faah004,sr.faah001,sr.faaiseq,sr.faai004,sr.faai012,sr.faai013,sr.faai005,sr.faai006,sr.faai007,sr.faai008,sr.faai014,sr.faai015,sr.faai015_desc,sr.faai016,sr.faai016_desc,sr.faai017,sr.l_faai017_desc,sr.faai023,sr.faai023_desc
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "afaq152_x01_execute"
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
 
{<section id="afaq152_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION afaq152_x01_rep_data()
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
 
{<section id="afaq152_x01.other_function" readonly="Y" >}

 
{</section>}
 
