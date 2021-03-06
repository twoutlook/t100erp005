#該程式未解開Section, 採用最新樣板產出!
{<section id="anmq820_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2016-05-16 17:47:37), PR版次:0003(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000049
#+ Filename...: anmq820_x01
#+ Description: ...
#+ Creator....: 00810(2015-03-23 15:57:33)
#+ Modifier...: 08108 -SD/PR- 00000
 
{</section>}
 
{<section id="anmq820_x01.global" readonly="Y" >}
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
       table LIKE type_t.chr100,         #  
       wc STRING                   #where condition
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="anmq820_x01.main" readonly="Y" >}
PUBLIC FUNCTION anmq820_x01(p_arg1,p_arg2)
DEFINE  p_arg1 LIKE type_t.chr100         #tm.table    
DEFINE  p_arg2 STRING                  #tm.wc  where condition
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
   LET g_rep_code = "anmq820_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL anmq820_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL anmq820_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL anmq820_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL anmq820_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL anmq820_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="anmq820_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION anmq820_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "nmbxent.nmbx_t.nmbxent,nmbx003.nmbx_t.nmbx003,nmbx100.nmbx_t.nmbx100,nmbxcomp.nmbx_t.nmbxcomp,glaa001.glaa_t.glaa001,nmbx002.nmbx_t.nmbx002,l_ori_begin.nmbx_t.nmbx103,nmbx103.nmbx_t.nmbx103,nmbx104.nmbx_t.nmbx104,l_ori_end.nmbx_t.nmbx103,l_loc_begin.nmbx_t.nmbx113,nmbx113.nmbx_t.nmbx113,nmbx114.nmbx_t.nmbx114,l_loc_end.nmbx_t.nmbx113" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="anmq820_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION anmq820_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?)"
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
 
{<section id="anmq820_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION anmq820_x01_sel_prep()
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
   LET g_select = " SELECT nmbxent,nmbx003,nmbx100,nmbxcomp,NULL,nmbx002,0,nmbx103,nmbx104,0,0,nmbx113, 
       nmbx114,0"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_select = " SELECT nmbxent,nmbx003,nmbx100,nmbxcomp,glaa001,nmbx002,l_ori_begin,nmbx103,nmbx104,
       l_ori_end,l_loc_begin,nmbx113,nmbx114,l_loc_end"
   #end add-point
    LET g_from = " FROM nmbx_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET g_from = " FROM ",tm.table
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("nmbx_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = g_sql," ORDER BY seq"
   #end add-point
   PREPARE anmq820_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE anmq820_x01_curs CURSOR FOR anmq820_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="anmq820_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION anmq820_x01_ins_data()
DEFINE sr RECORD 
   nmbxent LIKE nmbx_t.nmbxent, 
   nmbx003 LIKE nmbx_t.nmbx003, 
   nmbx100 LIKE nmbx_t.nmbx100, 
   nmbxcomp LIKE nmbx_t.nmbxcomp, 
   glaa001 LIKE glaa_t.glaa001, 
   nmbx002 LIKE nmbx_t.nmbx002, 
   l_ori_begin LIKE nmbx_t.nmbx103, 
   nmbx103 LIKE nmbx_t.nmbx103, 
   nmbx104 LIKE nmbx_t.nmbx104, 
   l_ori_end LIKE nmbx_t.nmbx103, 
   l_loc_begin LIKE nmbx_t.nmbx113, 
   nmbx113 LIKE nmbx_t.nmbx113, 
   nmbx114 LIKE nmbx_t.nmbx114, 
   l_loc_end LIKE nmbx_t.nmbx113
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH anmq820_x01_curs INTO sr.*                               
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
       EXECUTE insert_prep USING sr.nmbxent,sr.nmbx003,sr.nmbx100,sr.nmbxcomp,sr.glaa001,sr.nmbx002,sr.l_ori_begin,sr.nmbx103,sr.nmbx104,sr.l_ori_end,sr.l_loc_begin,sr.nmbx113,sr.nmbx114,sr.l_loc_end
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "anmq820_x01_execute"
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
 
{<section id="anmq820_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION anmq820_x01_rep_data()
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
 
{<section id="anmq820_x01.other_function" readonly="Y" >}

 
{</section>}
 
