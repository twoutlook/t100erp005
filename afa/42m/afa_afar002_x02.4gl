#該程式未解開Section, 採用最新樣板產出!
{<section id="afar002_x02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2016-04-28 09:57:13), PR版次:0003(2016-04-28 11:18:54)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000050
#+ Filename...: afar002_x02
#+ Description: ...
#+ Creator....: 01251(2015-03-27 16:17:43)
#+ Modifier...: 02599 -SD/PR- 02599
 
{</section>}
 
{<section id="afar002_x02.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#160427-00002#2   2016/04/28   By 02599   程序优化
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
       site LIKE type_t.chr20,         #資產中心 
       ld LIKE type_t.chr20,         #帳套 
       year LIKE type_t.num5,         #年度 
       peri LIKE type_t.num5,         #期別 
       a LIKE type_t.chr1,         #按主要類型匯 
       b LIKE type_t.chr1          #按部門匯總
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="afar002_x02.main" readonly="Y" >}
PUBLIC FUNCTION afar002_x02(p_arg1,p_arg2,p_arg3,p_arg4,p_arg5,p_arg6,p_arg7)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr20         #tm.site  資產中心 
DEFINE  p_arg3 LIKE type_t.chr20         #tm.ld  帳套 
DEFINE  p_arg4 LIKE type_t.num5         #tm.year  年度 
DEFINE  p_arg5 LIKE type_t.num5         #tm.peri  期別 
DEFINE  p_arg6 LIKE type_t.chr1         #tm.a  按主要類型匯 
DEFINE  p_arg7 LIKE type_t.chr1         #tm.b  按部門匯總
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.site = p_arg2
   LET tm.ld = p_arg3
   LET tm.year = p_arg4
   LET tm.peri = p_arg5
   LET tm.a = p_arg6
   LET tm.b = p_arg7
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "afar002_x02"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL afar002_x02_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL afar002_x02_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL afar002_x02_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL afar002_x02_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL afar002_x02_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="afar002_x02.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION afar002_x02_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "faah_t_faah006.faah_t.faah006,faah006_desc.type_t.chr200,faamld.faam_t.faamld,faam011.faam_t.faam011,faam014.faam_t.faam014,faam016.faam_t.faam016,faam015.faam_t.faam015,faam014_faam015.type_t.num20_6" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="afar002_x02.ins_prep" readonly="Y" >}
PRIVATE FUNCTION afar002_x02_ins_prep()
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
             ?,?)"
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
 
{<section id="afar002_x02.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION afar002_x02_sel_prep()
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
   LET g_select = " SELECT faah_t.faah006,NULL,faamld,faam011,faam014,faam016,faam015,NULL"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   #160427-00002#2--mod--str--
#   LET g_select = " SELECT faah_t.faah006,NULL,faamld,faam011,SUM(faam014),SUM(faam016),SUM(faam015),NULL"
   LET g_select = " SELECT faah_t.faah006,faacl003,faamld,faam011,SUM(faam014),SUM(faam016),",
                  "        SUM(CASE WHEN faam015 IS NULL THEN 0 ELSE faam015 END),",
                  "        SUM(faam014) - SUM(CASE WHEN faam015 IS NULL THEN 0 ELSE faam015 END)"
   #160427-00002#2--mod--end
   #end add-point
    LET g_from = " FROM faaj_t,faam_t,faah_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   #160427-00002#2--add--str--
   LET g_from = " FROM faaj_t,faam_t,",
                "      faah_t LEFT JOIN faacl_t ON faahent=faaclent AND faah006=faacl001 AND faacl002='",g_dlang,"'"
   #160427-00002#2--add--end
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
    LET g_where = " WHERE faahent = faajent AND faajent = faament ",
                  "   AND faah003 = faaj001 AND faah004 = faaj002 ",
                  "   AND faaj001 = faam001 AND faaj002 = faam002 ",  
                  "   AND faah001 = faaj037 AND faaj037 = faam000 ",
                  "   AND faajld = faamld ",
                  "   AND faahstus = 'Y' ",
                  "   AND faament= '",g_enterprise,"'",
                  "   AND faamld = '",tm.ld,"'",
                  "   AND faam004 = ",tm.year,
                  "   AND faam005 = ",tm.peri,
                  "   AND faam007 <> '2'         ",  #151015 #不等於分攤前 By Hans
                  "   AND ", tm.wc CLIPPED  
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("faaj_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   IF tm.a='Y' AND tm.b='N' THEN
#160427-00002#2--mod--str--
#      LET g_sql=g_sql CLIPPED," GROUP BY faah006,faamld,faam011 ORDER BY faah006,faamld,faam011"
      LET g_sql=g_sql CLIPPED," GROUP BY faah006,faacl003,faamld,faam011 ",
                              " ORDER BY faah006,faamld,faam011"
#160427-00002#2--mod--end
   END IF
   
   IF tm.a='N' AND tm.b='Y' THEN
      LET g_sql=g_sql CLIPPED," GROUP BY faam009,faamld,faam011 ORDER BY faam009,faamld,faam011"
   END IF
   IF (tm.a='Y' AND tm.b='Y') OR (tm.a='N' AND tm.b='N') THEN
      LET g_sql=g_sql CLIPPED," GROUP BY faah006,faam009,faamld,faam011 ORDER BY faah006,faam009,faamld,faam011"
   END IF  
   #end add-point
   PREPARE afar002_x02_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE afar002_x02_curs CURSOR FOR afar002_x02_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="afar002_x02.ins_data" readonly="Y" >}
PRIVATE FUNCTION afar002_x02_ins_data()
DEFINE sr RECORD 
   faah_t_faah006 LIKE faah_t.faah006, 
   faah006_desc LIKE type_t.chr200, 
   faamld LIKE faam_t.faamld, 
   faam011 LIKE faam_t.faam011, 
   faam014 LIKE faam_t.faam014, 
   faam016 LIKE faam_t.faam016, 
   faam015 LIKE faam_t.faam015, 
   faam014_faam015 LIKE type_t.num20_6
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH afar002_x02_curs INTO sr.*                               
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
#160427-00002#2--mark--str--
#       #資產主要類型
#       SELECT faacl003 INTO sr.faah006_desc
#         FROM faacl_t 
#        WHERE faacl001=sr.faah_t_faah006
#          AND faacl002 = g_dlang 
#          AND faaclent = g_enterprise
#               
#      #帳面價值
#      IF cl_null(sr.faam015) THEN
#         LET sr.faam015=0
#      END IF
#      LET sr.faam014_faam015=sr.faam014-sr.faam015
#160427-00002#2--mark--end
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.faah_t_faah006,sr.faah006_desc,sr.faamld,sr.faam011,sr.faam014,sr.faam016,sr.faam015,sr.faam014_faam015
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "afar002_x02_execute"
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
 
{<section id="afar002_x02.rep_data" readonly="Y" >}
PRIVATE FUNCTION afar002_x02_rep_data()
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
 
{<section id="afar002_x02.other_function" readonly="Y" >}

 
{</section>}
 
