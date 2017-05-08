#該程式未解開Section, 採用最新樣板產出!
{<section id="anmq410_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2016-11-29 17:33:20), PR版次:0002(2016-11-29 18:17:02)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000052
#+ Filename...: anmq410_x01
#+ Description: ...
#+ Creator....: 00810(2015-03-26 10:36:55)
#+ Modifier...: 03080 -SD/PR- 03080
 
{</section>}
 
{<section id="anmq410_x01.global" readonly="Y" >}
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
       table LIKE type_t.chr300,         #  
       wc STRING                   #
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="anmq410_x01.main" readonly="Y" >}
PUBLIC FUNCTION anmq410_x01(p_arg1,p_arg2)
DEFINE  p_arg1 LIKE type_t.chr300         #tm.table    
DEFINE  p_arg2 STRING                  #tm.wc
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.table = p_arg1
   LET tm.wc = p_arg2
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "anmq410_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL anmq410_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL anmq410_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL anmq410_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL anmq410_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL anmq410_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="anmq410_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION anmq410_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "nmckent.nmck_t.nmckent,nmckdocno.nmck_t.nmckdocno,nmck026.type_t.chr30,nmckstus.type_t.chr30,nmck024.nmck_t.nmck024,nmck025.nmck_t.nmck025,nmck002.nmck_t.nmck002,nmck002_desc.type_t.chr500,nmckdocdt.nmck_t.nmckdocdt,nmck011.nmck_t.nmck011,nmck012.nmck_t.nmck012,nmck100.nmck_t.nmck100,nmck103.nmck_t.nmck103,nmck113.nmck_t.nmck113,nmck031.nmck_t.nmck031,nmck005.nmck_t.nmck005,nmck005_desc.type_t.chr500,nmck015.nmck_t.nmck015,nmck004.nmck_t.nmck004,nmck004_desc.type_t.chr500,nmckcomp.nmck_t.nmckcomp,nmcksite.nmck_t.nmcksite" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="anmq410_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION anmq410_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="anmq410_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION anmq410_x01_sel_prep()
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
   LET g_select = " SELECT nmckent,nmckdocno,NULL,NULL,nmck024,nmck025,nmck002,NULL,nmckdocdt,nmck011, 
       nmck012,nmck100,nmck103,nmck113,nmck031,nmck005,NULL,nmck015,nmck004,NULL,nmckcomp,nmcksite"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   #161125-00036#2 mark-----s
   #LET g_select = " SELECT nmckent,nmckdocno,nmck026,nmckstus,nmck024,nmck025,nmck002,nmck002_desc,nmckdocdt, 
   #    nmck011,nmck100,nmck103,nmck113,nmck031,nmck005,nmck005_desc,nmck015,nmck004,nmck004_desc,nmckcomp,nmcksite" #150828-00005#4 add nmck113   #151016-00015#2 add nmck015
   #161125-00036#2 mark-----e
   #161125-00036#2-----s
   LET g_select = " SELECT nmckent,nmckdocno,nmck026,nmckstus,nmck024,nmck025,nmck002,nmck002_desc,nmckdocdt, 
       nmck011,nmck012,nmck100,nmck103,nmck113,nmck031,nmck005,nmck005_desc,nmck015,nmck004,nmck004_desc,nmckcomp,nmcksite"
   #161125-00036#2-----e
   #end add-point
    LET g_from = " FROM nmck_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET g_from = " FROM ",tm.table
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("nmck_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = g_sql," ORDER BY seq"
   #end add-point
   PREPARE anmq410_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE anmq410_x01_curs CURSOR FOR anmq410_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="anmq410_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION anmq410_x01_ins_data()
DEFINE sr RECORD 
   nmckent LIKE nmck_t.nmckent, 
   nmckdocno LIKE nmck_t.nmckdocno, 
   nmck026 LIKE type_t.chr30, 
   nmckstus LIKE type_t.chr30, 
   nmck024 LIKE nmck_t.nmck024, 
   nmck025 LIKE nmck_t.nmck025, 
   nmck002 LIKE nmck_t.nmck002, 
   nmck002_desc LIKE type_t.chr500, 
   nmckdocdt LIKE nmck_t.nmckdocdt, 
   nmck011 LIKE nmck_t.nmck011, 
   nmck012 LIKE nmck_t.nmck012, 
   nmck100 LIKE nmck_t.nmck100, 
   nmck103 LIKE nmck_t.nmck103, 
   nmck113 LIKE nmck_t.nmck113, 
   nmck031 LIKE nmck_t.nmck031, 
   nmck005 LIKE nmck_t.nmck005, 
   nmck005_desc LIKE type_t.chr500, 
   nmck015 LIKE nmck_t.nmck015, 
   nmck004 LIKE nmck_t.nmck004, 
   nmck004_desc LIKE type_t.chr500, 
   nmckcomp LIKE nmck_t.nmckcomp, 
   nmcksite LIKE nmck_t.nmcksite
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_desc      STRING
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH anmq410_x01_curs INTO sr.*                               
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
       #票況nmck026
       IF NOT cl_null(sr.nmck026) THEN
          CALL s_desc_gzcbl004_desc('8711',sr.nmck026) RETURNING l_desc
          LET sr.nmck026 = sr.nmck026,':',l_desc
       END IF
       #狀態碼
       IF NOT cl_null(sr.nmckstus) THEN
          CALL s_desc_gzcbl004_desc('50',sr.nmckstus) RETURNING l_desc
          LET sr.nmckstus = sr.nmckstus,':',l_desc
       END IF
       
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.nmckent,sr.nmckdocno,sr.nmck026,sr.nmckstus,sr.nmck024,sr.nmck025,sr.nmck002,sr.nmck002_desc,sr.nmckdocdt,sr.nmck011,sr.nmck012,sr.nmck100,sr.nmck103,sr.nmck113,sr.nmck031,sr.nmck005,sr.nmck005_desc,sr.nmck015,sr.nmck004,sr.nmck004_desc,sr.nmckcomp,sr.nmcksite
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "anmq410_x01_execute"
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
 
{<section id="anmq410_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION anmq410_x01_rep_data()
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
 
{<section id="anmq410_x01.other_function" readonly="Y" >}

 
{</section>}
 
