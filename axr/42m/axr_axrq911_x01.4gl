#該程式未解開Section, 採用最新樣板產出!
{<section id="axrq911_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2015-09-15 10:58:36), PR版次:0002(2015-09-15 11:04:33)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000044
#+ Filename...: axrq911_x01
#+ Description: ...
#+ Creator....: 02599(2015-03-19 16:14:43)
#+ Modifier...: 05016 -SD/PR- 05016
 
{</section>}
 
{<section id="axrq911_x01.global" readonly="Y" >}
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
       table LIKE type_t.chr100,         #temp table 
       wc STRING                   #where condition
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="axrq911_x01.main" readonly="Y" >}
PUBLIC FUNCTION axrq911_x01(p_arg1,p_arg2)
DEFINE  p_arg1 LIKE type_t.chr100         #tm.table  temp table 
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
   LET g_rep_code = "axrq911_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL axrq911_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL axrq911_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL axrq911_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL axrq911_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL axrq911_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="axrq911_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION axrq911_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "xrcacomp.xrca_t.xrcacomp,xrcacomp_desc.ooefl_t.ooefl003,xrcald.xrca_t.xrcald,xrcald_desc.glaal_t.glaal002,xrca004.xrca_t.xrca004,xrca004_desc.type_t.chr200,xrca014.xrca_t.xrca014,xrca014_desc.type_t.chr200,type.type_t.chr200,xrcadocdt.xrca_t.xrcadocdt,xrca001.xrca_t.xrca001,xrca001_desc.type_t.chr200,xrcadocno.xrca_t.xrcadocno,xrcb047.xrcb_t.xrcb047,xrca035.xrca_t.xrca035,xrca035_desc.glacl_t.glacl004,xrca038.xrca_t.xrca038,xrca066.xrca_t.xrca066,xrca100.xrca_t.xrca100,xrca108.xrca_t.xrca108,xrca1081.xrca_t.xrca108,xrca1082.xrca_t.xrca108,xrca118.xrca_t.xrca118,xrca1181.xrca_t.xrca118,xrca1182.xrca_t.xrca118" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="axrq911_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION axrq911_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="axrq911_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axrq911_x01_sel_prep()
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
   LET g_select = " SELECT xrcacomp,'',xrcald,'',xrca004,'',xrca014,'','',xrcadocdt,xrca001,'',xrcadocno, 
       '',xrca035,'',xrca038,xrca066,xrca100,xrca108,0,0,xrca118,0,0"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_select = " SELECT xrcacomp,xrcacomp_desc,xrcald,xrcald_desc,xrca004,xrca004_desc,xrca014,xrca014_desc,type,
                           xrcadocdt,xrca001,xrca001_desc,xrcadocno,xrcb047,xrca035,xrca035_desc,xrca038,xrca066,
                           xrca100,xrca108,
                           l_xrca1081,l_xrca1082,xrca118,l_xrca1181,l_xrca1182"
   #end add-point
    LET g_from = " FROM xrca_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET g_from = " FROM ",tm.table
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
   LET g_sql = g_sql," ORDER BY odr"
   #end add-point
   PREPARE axrq911_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE axrq911_x01_curs CURSOR FOR axrq911_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="axrq911_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION axrq911_x01_ins_data()
DEFINE sr RECORD 
   xrcacomp LIKE xrca_t.xrcacomp, 
   xrcacomp_desc LIKE ooefl_t.ooefl003, 
   xrcald LIKE xrca_t.xrcald, 
   xrcald_desc LIKE glaal_t.glaal002, 
   xrca004 LIKE xrca_t.xrca004, 
   xrca004_desc LIKE type_t.chr200, 
   xrca014 LIKE xrca_t.xrca014, 
   xrca014_desc LIKE type_t.chr200, 
   type LIKE type_t.chr200, 
   xrcadocdt LIKE xrca_t.xrcadocdt, 
   xrca001 LIKE xrca_t.xrca001, 
   xrca001_desc LIKE type_t.chr200, 
   xrcadocno LIKE xrca_t.xrcadocno, 
   xrcb047 LIKE xrcb_t.xrcb047, 
   xrca035 LIKE xrca_t.xrca035, 
   xrca035_desc LIKE glacl_t.glacl004, 
   xrca038 LIKE xrca_t.xrca038, 
   xrca066 LIKE xrca_t.xrca066, 
   xrca100 LIKE xrca_t.xrca100, 
   xrca108 LIKE xrca_t.xrca108, 
   xrca1081 LIKE xrca_t.xrca108, 
   xrca1082 LIKE xrca_t.xrca108, 
   xrca118 LIKE xrca_t.xrca118, 
   xrca1181 LIKE xrca_t.xrca118, 
   xrca1182 LIKE xrca_t.xrca118
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH axrq911_x01_curs INTO sr.*                               
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
       EXECUTE insert_prep USING sr.xrcacomp,sr.xrcacomp_desc,sr.xrcald,sr.xrcald_desc,sr.xrca004,sr.xrca004_desc,sr.xrca014,sr.xrca014_desc,sr.type,sr.xrcadocdt,sr.xrca001,sr.xrca001_desc,sr.xrcadocno,sr.xrcb047,sr.xrca035,sr.xrca035_desc,sr.xrca038,sr.xrca066,sr.xrca100,sr.xrca108,sr.xrca1081,sr.xrca1082,sr.xrca118,sr.xrca1181,sr.xrca1182
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "axrq911_x01_execute"
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
 
{<section id="axrq911_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION axrq911_x01_rep_data()
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
 
{<section id="axrq911_x01.other_function" readonly="Y" >}

 
{</section>}
 
