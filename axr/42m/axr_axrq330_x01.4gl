#該程式未解開Section, 採用最新樣板產出!
{<section id="axrq330_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2015-05-28 15:07:18), PR版次:0001(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000037
#+ Filename...: axrq330_x01
#+ Description: ...
#+ Creator....: 02291(2015-05-28 13:39:21)
#+ Modifier...: 02291 -SD/PR- 00000
 
{</section>}
 
{<section id="axrq330_x01.global" readonly="Y" >}
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
       a2 LIKE type_t.chr1,         #g_type 
       s2 LIKE type_t.chr1          #b_rule
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_tmp_table     STRING
#end add-point
 
{</section>}
 
{<section id="axrq330_x01.main" readonly="Y" >}
PUBLIC FUNCTION axrq330_x01(p_arg1,p_arg2,p_arg3,p_arg4)
DEFINE  p_arg1 STRING                  #tm.wc  condition:where 
DEFINE  p_arg2 STRING                  #tm.a1  print_tmp 
DEFINE  p_arg3 LIKE type_t.chr1         #tm.a2  g_type 
DEFINE  p_arg4 LIKE type_t.chr1         #tm.s2  b_rule
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.a1 = p_arg2
   LET tm.a2 = p_arg3
   LET tm.s2 = p_arg4
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   LET g_tmp_table = tm.a1
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "axrq330_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL axrq330_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL axrq330_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL axrq330_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL axrq330_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL axrq330_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="axrq330_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION axrq330_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "l_xrcasite_desc.type_t.chr500,l_xrcald_desc.type_t.chr500,l_g_type.type_t.chr500,l_b_rule.type_t.chr500,l_type_desc.type_t.chr500,l_xrca004_desc.type_t.chr500,xrca100.xrca_t.xrca100,xrcc108.xrcc_t.xrcc108,l_amount21.type_t.num20_6,l_amount26.type_t.num20_6,l_amount12.type_t.num20_6,l_amount19.type_t.num20_6,l_amount22.type_t.num20_6,l_amount29.type_t.num20_6,l_amount01.type_t.num20_6,l_amount03.type_t.num20_6,l_amt.type_t.num20_6,xrcc109.xrcc_t.xrcc109,xrcc118.xrcc_t.xrcc118,xrcc119.xrcc_t.xrcc119" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="axrq330_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION axrq330_x01_ins_prep()
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
 
{<section id="axrq330_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axrq330_x01_sel_prep()
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
   LET g_select = " SELECT NULL,NULL,NULL,NULL,NULL,NULL,xrca100,xrcc108,NULL,NULL,NULL,NULL,NULL,NULL, 
       NULL,NULL,NULL,xrcc109,xrcc118,xrcc119"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   
   #end add-point
    LET g_from = " FROM xrca_t,xrcc_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("xrca_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = " SELECT * FROM ", g_tmp_table CLIPPED,
               "  ORDER BY xrca004_desc,xrca100,type_desc"
   #end add-point
   PREPARE axrq330_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE axrq330_x01_curs CURSOR FOR axrq330_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="axrq330_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION axrq330_x01_ins_data()
DEFINE sr RECORD 
   l_xrcasite_desc LIKE type_t.chr500, 
   l_xrcald_desc LIKE type_t.chr500, 
   l_g_type LIKE type_t.chr500, 
   l_b_rule LIKE type_t.chr500, 
   l_type_desc LIKE type_t.chr500, 
   l_xrca004_desc LIKE type_t.chr500, 
   xrca100 LIKE xrca_t.xrca100, 
   xrcc108 LIKE xrcc_t.xrcc108, 
   l_amount21 LIKE type_t.num20_6, 
   l_amount26 LIKE type_t.num20_6, 
   l_amount12 LIKE type_t.num20_6, 
   l_amount19 LIKE type_t.num20_6, 
   l_amount22 LIKE type_t.num20_6, 
   l_amount29 LIKE type_t.num20_6, 
   l_amount01 LIKE type_t.num20_6, 
   l_amount03 LIKE type_t.num20_6, 
   l_amt LIKE type_t.num20_6, 
   xrcc109 LIKE xrcc_t.xrcc109, 
   xrcc118 LIKE xrcc_t.xrcc118, 
   xrcc119 LIKE xrcc_t.xrcc119
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH axrq330_x01_curs INTO sr.*                               
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
       EXECUTE insert_prep USING sr.l_xrcasite_desc,sr.l_xrcald_desc,sr.l_g_type,sr.l_b_rule,sr.l_type_desc,sr.l_xrca004_desc,sr.xrca100,sr.xrcc108,sr.l_amount21,sr.l_amount26,sr.l_amount12,sr.l_amount19,sr.l_amount22,sr.l_amount29,sr.l_amount01,sr.l_amount03,sr.l_amt,sr.xrcc109,sr.xrcc118,sr.xrcc119
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "axrq330_x01_execute"
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

    IF tm.a2 = '0' THEN 
       LET g_xgrid.visible_column ="l_type_desc"
    END IF
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrq330_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION axrq330_x01_rep_data()
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
 
{<section id="axrq330_x01.other_function" readonly="Y" >}

 
{</section>}
 
