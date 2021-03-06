#該程式未解開Section, 採用最新樣板產出!
{<section id="axrq360_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2015-12-03 18:13:06), PR版次:0002(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000044
#+ Filename...: axrq360_x01
#+ Description: ...
#+ Creator....: 02291(2015-05-27 10:58:57)
#+ Modifier...: 02599 -SD/PR- 00000
 
{</section>}
 
{<section id="axrq360_x01.global" readonly="Y" >}
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
       a1 STRING                   #print_tmp
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_tmp_table     STRING
#end add-point
 
{</section>}
 
{<section id="axrq360_x01.main" readonly="Y" >}
PUBLIC FUNCTION axrq360_x01(p_arg1,p_arg2)
DEFINE  p_arg1 STRING                  #tm.wc  condition:where 
DEFINE  p_arg2 STRING                  #tm.a1  print_tmp
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
   LET g_rep_code = "axrq360_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL axrq360_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL axrq360_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL axrq360_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL axrq360_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL axrq360_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="axrq360_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION axrq360_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "l_xrcastus.type_t.chr80,xrcasite.xrca_t.xrcasite,l_xrcasite_desc.type_t.chr500,xrcacomp.xrca_t.xrcacomp,l_xrcacomp_desc.type_t.chr500,xrcald.xrca_t.xrcald,l_xrcald_desc.type_t.chr500,xrcadocno.xrca_t.xrcadocno,xrcadocdt.xrca_t.xrcadocdt,l_xrca001.type_t.chr500,xrca004.xrca_t.xrca004,l_xrca004_desc.type_t.chr500,xrca057.xrca_t.xrca057,l_xrca057_desc.type_t.chr500,xrca035.xrca_t.xrca035,l_xrca035_desc.type_t.chr500,xrca038.xrca_t.xrca038,xrca014.xrca_t.xrca014,l_xrca014_desc.type_t.chr500,xrca015.xrca_t.xrca015,l_xrca015_desc.type_t.chr500,xrca058.xrca_t.xrca058,l_xrca058_desc.type_t.chr500,xrca007.xrca_t.xrca007,l_xrca007_desc.type_t.chr500,xrca040.xrca_t.xrca040,xrcc100.xrcc_t.xrcc100,xrcc102.xrcc_t.xrcc102,xrccseq.xrcc_t.xrccseq,xrcc001.xrcc_t.xrcc001,xrcc003.xrcc_t.xrcc003,xrcc004.xrcc_t.xrcc004,xrcc009.xrcc_t.xrcc009,xrcc108.xrcc_t.xrcc108,xrcc109.xrcc_t.xrcc109,l_calc.type_t.num20_6,xrcc118.xrcc_t.xrcc118,xrcc119.xrcc_t.xrcc119,l_calc2.type_t.num20_6" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="axrq360_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION axrq360_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="axrq360_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axrq360_x01_sel_prep()
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
   LET g_select = " SELECT NULL,xrcasite,NULL,xrcacomp,NULL,xrcald,NULL,xrcadocno,xrcadocdt,NULL,xrca004, 
       NULL,xrca057,NULL,xrca035,NULL,xrca038,xrca014,NULL,xrca015,NULL,xrca058,NULL,xrca007,NULL,xrca040, 
       xrcc100,xrcc102,xrccseq,xrcc001,xrcc003,xrcc004,xrcc009,xrcc108,xrcc109,NULL,xrcc118,xrcc119, 
       NULL"
 
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
   LET g_sql = " SELECT * FROM ", g_tmp_table CLIPPED," ORDER BY xrcald,xrcadocno"
   #end add-point
   PREPARE axrq360_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE axrq360_x01_curs CURSOR FOR axrq360_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="axrq360_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION axrq360_x01_ins_data()
DEFINE sr RECORD 
   l_xrcastus LIKE type_t.chr80, 
   xrcasite LIKE xrca_t.xrcasite, 
   l_xrcasite_desc LIKE type_t.chr500, 
   xrcacomp LIKE xrca_t.xrcacomp, 
   l_xrcacomp_desc LIKE type_t.chr500, 
   xrcald LIKE xrca_t.xrcald, 
   l_xrcald_desc LIKE type_t.chr500, 
   xrcadocno LIKE xrca_t.xrcadocno, 
   xrcadocdt LIKE xrca_t.xrcadocdt, 
   l_xrca001 LIKE type_t.chr500, 
   xrca004 LIKE xrca_t.xrca004, 
   l_xrca004_desc LIKE type_t.chr500, 
   xrca057 LIKE xrca_t.xrca057, 
   l_xrca057_desc LIKE type_t.chr500, 
   xrca035 LIKE xrca_t.xrca035, 
   l_xrca035_desc LIKE type_t.chr500, 
   xrca038 LIKE xrca_t.xrca038, 
   xrca014 LIKE xrca_t.xrca014, 
   l_xrca014_desc LIKE type_t.chr500, 
   xrca015 LIKE xrca_t.xrca015, 
   l_xrca015_desc LIKE type_t.chr500, 
   xrca058 LIKE xrca_t.xrca058, 
   l_xrca058_desc LIKE type_t.chr500, 
   xrca007 LIKE xrca_t.xrca007, 
   l_xrca007_desc LIKE type_t.chr500, 
   xrca040 LIKE xrca_t.xrca040, 
   xrcc100 LIKE xrcc_t.xrcc100, 
   xrcc102 LIKE xrcc_t.xrcc102, 
   xrccseq LIKE xrcc_t.xrccseq, 
   xrcc001 LIKE xrcc_t.xrcc001, 
   xrcc003 LIKE xrcc_t.xrcc003, 
   xrcc004 LIKE xrcc_t.xrcc004, 
   xrcc009 LIKE xrcc_t.xrcc009, 
   xrcc108 LIKE xrcc_t.xrcc108, 
   xrcc109 LIKE xrcc_t.xrcc109, 
   l_calc LIKE type_t.num20_6, 
   xrcc118 LIKE xrcc_t.xrcc118, 
   xrcc119 LIKE xrcc_t.xrcc119, 
   l_calc2 LIKE type_t.num20_6
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH axrq360_x01_curs INTO sr.*                               
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
       EXECUTE insert_prep USING sr.l_xrcastus,sr.xrcasite,sr.l_xrcasite_desc,sr.xrcacomp,sr.l_xrcacomp_desc,sr.xrcald,sr.l_xrcald_desc,sr.xrcadocno,sr.xrcadocdt,sr.l_xrca001,sr.xrca004,sr.l_xrca004_desc,sr.xrca057,sr.l_xrca057_desc,sr.xrca035,sr.l_xrca035_desc,sr.xrca038,sr.xrca014,sr.l_xrca014_desc,sr.xrca015,sr.l_xrca015_desc,sr.xrca058,sr.l_xrca058_desc,sr.xrca007,sr.l_xrca007_desc,sr.xrca040,sr.xrcc100,sr.xrcc102,sr.xrccseq,sr.xrcc001,sr.xrcc003,sr.xrcc004,sr.xrcc009,sr.xrcc108,sr.xrcc109,sr.l_calc,sr.xrcc118,sr.xrcc119,sr.l_calc2
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "axrq360_x01_execute"
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
 
{<section id="axrq360_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION axrq360_x01_rep_data()
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
 
{<section id="axrq360_x01.other_function" readonly="Y" >}

 
{</section>}
 
