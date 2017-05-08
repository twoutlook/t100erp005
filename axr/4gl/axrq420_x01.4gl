#該程式未解開Section, 採用最新樣板產出!
{<section id="axrq420_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2015-05-27 15:24:44), PR版次:0001(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000037
#+ Filename...: axrq420_x01
#+ Description: ...
#+ Creator....: 02291(2015-05-27 14:49:33)
#+ Modifier...: 02291 -SD/PR- 00000
 
{</section>}
 
{<section id="axrq420_x01.global" readonly="Y" >}
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
       a2 LIKE type_t.chr1,         #glaa015 
       a3 LIKE type_t.chr1          #glaa019
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_tmp_table     STRING
#end add-point
 
{</section>}
 
{<section id="axrq420_x01.main" readonly="Y" >}
PUBLIC FUNCTION axrq420_x01(p_arg1,p_arg2,p_arg3,p_arg4)
DEFINE  p_arg1 STRING                  #tm.wc  condition:where 
DEFINE  p_arg2 STRING                  #tm.a1  print_tmp 
DEFINE  p_arg3 LIKE type_t.chr1         #tm.a2  glaa015 
DEFINE  p_arg4 LIKE type_t.chr1         #tm.a3  glaa019
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
   LET g_rep_code = "axrq420_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL axrq420_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL axrq420_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL axrq420_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL axrq420_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL axrq420_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="axrq420_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION axrq420_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "l_xrdeld_desc.type_t.chr500,xrdeld.xrde_t.xrdeld,xrdedocno.xrde_t.xrdedocno,xrdeseq.xrde_t.xrdeseq,l_xrda005.xrda_t.xrda005,l_xrda005_desc.type_t.chr500,l_xrde002.type_t.chr500,l_xrde006.type_t.chr500,xrde003.xrde_t.xrde003,xrde004.xrde_t.xrde004,xrde008.xrde_t.xrde008,xrde100.xrde_t.xrde100,xrde101.xrde_t.xrde101,xrde109.xrde_t.xrde109,xrde119.xrde_t.xrde119,xrde120.xrde_t.xrde120,xrde121.xrde_t.xrde121,xrde129.xrde_t.xrde129,xrde130.xrde_t.xrde130,xrde131.xrde_t.xrde131,xrde139.xrde_t.xrde139,xrde014.xrde_t.xrde014,xrde013.xrde_t.xrde013,xrde012.xrde_t.xrde012,xrde015.xrde_t.xrde015,xrde010.xrde_t.xrde010,xrde016.xrde_t.xrde016" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="axrq420_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION axrq420_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="axrq420_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axrq420_x01_sel_prep()
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
   LET g_select = " SELECT NULL,xrdeld,xrdedocno,xrdeseq,NULL,NULL,NULL,NULL,xrde003,xrde004,xrde008, 
       xrde100,xrde101,xrde109,xrde119,xrde120,xrde121,xrde129,xrde130,xrde131,xrde139,xrde014,xrde013, 
       xrde012,xrde015,xrde010,xrde016"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   
   #end add-point
    LET g_from = " FROM xrde_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("xrde_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = " SELECT * FROM ", g_tmp_table CLIPPED," ORDER BY xrdedocno,xrdeseq"
   #end add-point
   PREPARE axrq420_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE axrq420_x01_curs CURSOR FOR axrq420_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="axrq420_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION axrq420_x01_ins_data()
DEFINE sr RECORD 
   l_xrdeld_desc LIKE type_t.chr500, 
   xrdeld LIKE xrde_t.xrdeld, 
   xrdedocno LIKE xrde_t.xrdedocno, 
   xrdeseq LIKE xrde_t.xrdeseq, 
   l_xrda005 LIKE xrda_t.xrda005, 
   l_xrda005_desc LIKE type_t.chr500, 
   l_xrde002 LIKE type_t.chr500, 
   l_xrde006 LIKE type_t.chr500, 
   xrde003 LIKE xrde_t.xrde003, 
   xrde004 LIKE xrde_t.xrde004, 
   xrde008 LIKE xrde_t.xrde008, 
   xrde100 LIKE xrde_t.xrde100, 
   xrde101 LIKE xrde_t.xrde101, 
   xrde109 LIKE xrde_t.xrde109, 
   xrde119 LIKE xrde_t.xrde119, 
   xrde120 LIKE xrde_t.xrde120, 
   xrde121 LIKE xrde_t.xrde121, 
   xrde129 LIKE xrde_t.xrde129, 
   xrde130 LIKE xrde_t.xrde130, 
   xrde131 LIKE xrde_t.xrde131, 
   xrde139 LIKE xrde_t.xrde139, 
   xrde014 LIKE xrde_t.xrde014, 
   xrde013 LIKE xrde_t.xrde013, 
   xrde012 LIKE xrde_t.xrde012, 
   xrde015 LIKE xrde_t.xrde015, 
   xrde010 LIKE xrde_t.xrde010, 
   xrde016 LIKE xrde_t.xrde016
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH axrq420_x01_curs INTO sr.*                               
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
       EXECUTE insert_prep USING sr.l_xrdeld_desc,sr.xrdeld,sr.xrdedocno,sr.xrdeseq,sr.l_xrda005,sr.l_xrda005_desc,sr.l_xrde002,sr.l_xrde006,sr.xrde003,sr.xrde004,sr.xrde008,sr.xrde100,sr.xrde101,sr.xrde109,sr.xrde119,sr.xrde120,sr.xrde121,sr.xrde129,sr.xrde130,sr.xrde131,sr.xrde139,sr.xrde014,sr.xrde013,sr.xrde012,sr.xrde015,sr.xrde010,sr.xrde016
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "axrq420_x01_execute"
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

    IF tm.a2 = 'N' THEN #本位幣二
       LET g_xgrid.visible_column="xrde120|xrde121|xrde129"
    END IF
    
    IF tm.a3 = 'N' THEN #本位幣三
       IF NOT cl_null(g_xgrid.visible_column)THEN       
          LET g_xgrid.visible_column =g_xgrid.visible_column CLIPPED ,"|xrde130|xrde131|xrde139"
       ELSE
          LET g_xgrid.visible_column = "xrde130|xrde131|xrde139"
       END IF
    END IF
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrq420_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION axrq420_x01_rep_data()
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
 
{<section id="axrq420_x01.other_function" readonly="Y" >}

 
{</section>}
 