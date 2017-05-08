#該程式未解開Section, 採用最新樣板產出!
{<section id="azzr810_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2015-06-09 13:49:01), PR版次:0002(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000039
#+ Filename...: azzr810_x01
#+ Description: ...
#+ Creator....: 00845(2014-12-18 18:26:39)
#+ Modifier...: 02667 -SD/PR- 00000
 
{</section>}
 
{<section id="azzr810_x01.global" readonly="Y" >}
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
       wc STRING                   #wc
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
GLOBALS
   DEFINE g_type LIKE type_t.num5  
   DEFINE g_top  LIKE type_t.num5      
END GLOBALS
#end add-point
 
{</section>}
 
{<section id="azzr810_x01.main" readonly="Y" >}
PUBLIC FUNCTION azzr810_x01(p_arg1)
DEFINE  p_arg1 STRING                  #tm.wc  wc
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
   LET g_rep_code = "azzr810_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL azzr810_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL azzr810_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL azzr810_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL azzr810_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL azzr810_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="azzr810_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION azzr810_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "gzzh001.gzzh_t.gzzh001,gzzh002.gzzh_t.gzzh002,gzzh003.gzzh_t.gzzh003,gzzh004.gzzh_t.gzzh004,gzzh005.gzzh_t.gzzh005,l_target.type_t.chr300,l_frequency.type_t.num10,l_month.type_t.chr30,l_module.type_t.chr30,l_prog.type_t.chr30,l_dept.type_t.chr30,l_user.type_t.chr30" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="azzr810_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION azzr810_x01_ins_prep()
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
             ?,?,?,?,?,?)"
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
 
{<section id="azzr810_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION azzr810_x01_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define(客製用) name="sel_prep.define_customerization"

#end add-point
#add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
DEFINE lc_gzge003    LIKE gzge_t.gzge003
#end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
 
   #add-point:sel_prep g_select name="sel_prep.g_select"
   LET g_sql = "SELECT 'A','',loga001,COUNT(*) AS B FROM loga_t ",  #使用者編號
               " WHERE logaent = ",g_enterprise,
                 " AND loga006 BETWEEN TO_DATE('2014-12-19 00:00:00','YYYY-MM-DD HH24:mi:ss') ",
                                 " AND TO_DATE('2014-12-19 23:59:59','YYYY-MM-DD HH24:mi:ss') ",
                 " AND loga001 <> 'azzi000' ",
                "GROUP BY loga001 ORDER BY B DESC "
#   #end add-point
#   LET g_select = " SELECT gzzh001,gzzh002,gzzh003,gzzh004,gzzh005,NULL,0,NULL,NULL,NULL,NULL,NULL"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_sql = tm.wc
   #說明調整
   CASE g_type
      WHEN 1
         SELECT gzge003 INTO lc_gzge003 FROM gzge_t 
          WHERE gzge000 = '6B3228EA-C940-4429-A566-DA7CA2BAD365' AND
                gzge001 = 'l_month' AND
                gzge002 = g_lang    
        LET g_xg_fieldname[6] = lc_gzge003

      WHEN 2
         SELECT gzge003 INTO lc_gzge003 FROM gzge_t 
          WHERE gzge000 = '6B3228EA-C940-4429-A566-DA7CA2BAD365' AND
                gzge001 = 'l_module' AND
                gzge002 = g_lang    
        LET g_xg_fieldname[6] = lc_gzge003
      
      WHEN 3
         SELECT gzge003 INTO lc_gzge003 FROM gzge_t 
          WHERE gzge000 = '6B3228EA-C940-4429-A566-DA7CA2BAD365' AND
                gzge001 = 'l_prog' AND
                gzge002 = g_lang    
        LET g_xg_fieldname[6] = lc_gzge003
      
      WHEN 4
         SELECT gzge003 INTO lc_gzge003 FROM gzge_t 
          WHERE gzge000 = '6B3228EA-C940-4429-A566-DA7CA2BAD365' AND
                gzge001 = 'l_dept' AND
                gzge002 = g_lang    
        LET g_xg_fieldname[6] = lc_gzge003
      
      WHEN 5
         SELECT gzge003 INTO lc_gzge003 FROM gzge_t 
          WHERE gzge000 = '6B3228EA-C940-4429-A566-DA7CA2BAD365' AND
                gzge001 = 'l_user' AND
                gzge002 = g_lang    
        LET g_xg_fieldname[6] = lc_gzge003
      
   END CASE
   
#   #end add-point
#    LET g_from = " FROM gzzh_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
 
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
  
#   #end add-point:sel_prep.sql.before
#   LET g_where = g_where ,cl_sql_add_filter("gzzh_t")   #資料過濾功能
#   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
#   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
# 
#   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE azzr810_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE azzr810_x01_curs CURSOR FOR azzr810_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="azzr810_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION azzr810_x01_ins_data()
DEFINE sr RECORD 
   gzzh001 LIKE gzzh_t.gzzh001, 
   gzzh002 LIKE gzzh_t.gzzh002, 
   gzzh003 LIKE gzzh_t.gzzh003, 
   gzzh004 LIKE gzzh_t.gzzh004, 
   gzzh005 LIKE gzzh_t.gzzh005, 
   l_target LIKE type_t.chr300, 
   l_frequency LIKE type_t.num10, 
   l_month LIKE type_t.chr30, 
   l_module LIKE type_t.chr30, 
   l_prog LIKE type_t.chr30, 
   l_dept LIKE type_t.chr30, 
   l_user LIKE type_t.chr30
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE li_cnt LIKE type_t.num5
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    LET li_cnt = 0
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH azzr810_x01_curs INTO sr.*                               
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
       LET li_cnt = li_cnt + 1
       IF g_type = 3 OR g_type = 4 OR g_type = 5 THEN
          IF li_cnt > g_top THEN
             EXIT FOREACH
          END IF
       END IF
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
 
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.gzzh001,sr.gzzh002,sr.gzzh003,sr.gzzh004,sr.gzzh005,sr.l_target,sr.l_frequency,sr.l_month,sr.l_module,sr.l_prog,sr.l_dept,sr.l_user
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "azzr810_x01_execute"
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
 
{<section id="azzr810_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION azzr810_x01_rep_data()
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
 
{<section id="azzr810_x01.other_function" readonly="Y" >}

 
{</section>}
 
