#該程式未解開Section, 採用最新樣板產出!
{<section id="ainr900_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2014-12-25 11:10:14), PR版次:0001(2014-12-25 11:18:59)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000059
#+ Filename...: ainr900_x01
#+ Description: ...
#+ Creator....: 05423(2014-12-19 09:45:05)
#+ Modifier...: 05423 -SD/PR- 05423
 
{</section>}
 
{<section id="ainr900_x01.global" readonly="Y" >}
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
       pr STRING                   #print
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="ainr900_x01.main" readonly="Y" >}
PUBLIC FUNCTION ainr900_x01(p_arg1,p_arg2)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 STRING                  #tm.pr  print
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.pr = p_arg2
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "ainr900_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL ainr900_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL ainr900_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL ainr900_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL ainr900_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL ainr900_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="ainr900_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION ainr900_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "inpr002.inpr_t.inpr002,imaa009.imaa_t.imaa009,l_imaa009_desc.type_t.chr30,inpr001.inpr_t.inpr001,imaal_t_imaal003.imaal_t.imaal003,imaal_t_imaal004.imaal_t.imaal004,inpr003.inpr_t.inpr003,imaa004.imaa_t.imaa004,l_imaa004_desc.type_t.chr30,imaa002.imaa_t.imaa002,imaf_t_imaf013.imaf_t.imaf013,l_imaf013_desc.type_t.chr30,inpr005.inpr_t.inpr005,inpr006.inpr_t.inpr006,inpr007.inpr_t.inpr007,inph_t_inph007.inph_t.inph007,inph_t_inph001.inph_t.inph001" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="ainr900_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION ainr900_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="ainr900_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION ainr900_x01_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define(客製用) name="sel_prep.define_customerization"

#end add-point
#add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
DEFINE g_order       STRING

#end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
 
   #add-point:sel_prep g_select name="sel_prep.g_select"
   LET g_select = " SELECT DISTINCT inpr002,imaa009,rtaxl003,inpr001,imaal_t.imaal003,imaal_t.imaal004,inpr003,imaa004,NULL, 
       imaa002,imaf_t.imaf013,NULL,inpr005,inpr006,inpr007,inph_t.inph007,inph_t.inph001"
#   #end add-point
#   LET g_select = " SELECT inpr002,imaa009,NULL,inpr001,imaal_t.imaal003,imaal_t.imaal004,inpr003,imaa004, 
#       NULL,imaa002,imaf_t.imaf013,NULL,inpr005,inpr006,inpr007,inph_t.inph007,inph_t.inph001"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_from = " FROM inpr_t LEFT OUTER JOIN imaa_t ON inpr001 = imaa001 AND inprent = imaaent ",
                "             LEFT OUTER JOIN imaal_t ON inpr001 = imaal001 AND inprent = imaalent AND imaal002 = '",g_dlang,"' ",
                "             LEFT OUTER JOIN rtaxl_t ON imaa009 = rtaxl001 AND imaaent = rtaxlent AND rtaxl002 = '",g_dlang,"' ",
                "             LEFT OUTER JOIN imaf_t ON inpr001 = imaf001 AND inprent = imafent AND inprsite = imafsite ",
                "             LEFT OUTER JOIN inph_t ON inprent = inphent AND inprsite = inphsite "

#   #end add-point
#    LET g_from = " FROM inpr_t,imaa_t,imaal_t,imaf_t,inph_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   LET g_order = " ORDER BY inpr002,imaa009,inpr001 "
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("inpr_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = g_sql CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
   #end add-point
   PREPARE ainr900_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE ainr900_x01_curs CURSOR FOR ainr900_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="ainr900_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION ainr900_x01_ins_data()
DEFINE sr RECORD 
   inpr002 LIKE inpr_t.inpr002, 
   imaa009 LIKE imaa_t.imaa009, 
   l_imaa009_desc LIKE type_t.chr30, 
   inpr001 LIKE inpr_t.inpr001, 
   imaal_t_imaal003 LIKE imaal_t.imaal003, 
   imaal_t_imaal004 LIKE imaal_t.imaal004, 
   inpr003 LIKE inpr_t.inpr003, 
   imaa004 LIKE imaa_t.imaa004, 
   l_imaa004_desc LIKE type_t.chr30, 
   imaa002 LIKE imaa_t.imaa002, 
   imaf_t_imaf013 LIKE imaf_t.imaf013, 
   l_imaf013_desc LIKE type_t.chr30, 
   inpr005 LIKE inpr_t.inpr005, 
   inpr006 LIKE inpr_t.inpr006, 
   inpr007 LIKE inpr_t.inpr007, 
   inph_t_inph007 LIKE inph_t.inph007, 
   inph_t_inph001 LIKE inph_t.inph001
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH ainr900_x01_curs INTO sr.*                               
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
       IF NOT cl_null(sr.imaa004) THEN
         CALL ainr900_x01_desc('1001',sr.imaa004) RETURNING sr.l_imaa004_desc
       END IF
       IF NOT cl_null(sr.imaf_t_imaf013) THEN
         CALL ainr900_x01_desc('2022',sr.imaf_t_imaf013) RETURNING sr.l_imaf013_desc
       END IF
       IF tm.pr = "N" THEN
         LET sr.inpr005 = NULL
         LET sr.inpr006 = NULL
         LET sr.inpr007 = NULL
       ELSE
         IF sr.inph_t_inph007 = "1"  THEN
            IF sr.inph_t_inph001 = '1' THEN
               LET sr.inpr005 = NULL
               LET sr.inpr007 = NULL
            ELSE
               IF sr.inph_t_inph001 = "2" THEN
                  LET sr.inpr005 = NULL
                  LET sr.inpr006 = NULL
               END IF
            END IF
         ELSE 
            IF sr.inph_t_inph007 = "2" THEN
               LET sr.inpr006 = NULL
               LET sr.inpr007 = NULL
            END IF
         END IF
      END IF
            
       
       
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.inpr002,sr.imaa009,sr.l_imaa009_desc,sr.inpr001,sr.imaal_t_imaal003,sr.imaal_t_imaal004,sr.inpr003,sr.imaa004,sr.l_imaa004_desc,sr.imaa002,sr.imaf_t_imaf013,sr.l_imaf013_desc,sr.inpr005,sr.inpr006,sr.inpr007,sr.inph_t_inph007,sr.inph_t_inph001
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "ainr900_x01_execute"
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
 
{<section id="ainr900_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION ainr900_x01_rep_data()
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
 
{<section id="ainr900_x01.other_function" readonly="Y" >}

#獲取SCC碼說明
PRIVATE FUNCTION ainr900_x01_desc(p_num,p_target)
   DEFINE p_num    LIKE type_t.num5
   DEFINE p_target LIKE type_t.chr10
   DEFINE r_desc   LIKE type_t.chr500
   
   SELECT gzcbl004 INTO r_desc
     FROM gzcbl_t
    WHERE gzcbl001 = p_num
      AND gzcbl002 = p_target
      AND gzcbl003 = g_dlang
      
   RETURN r_desc       
END FUNCTION

 
{</section>}
 