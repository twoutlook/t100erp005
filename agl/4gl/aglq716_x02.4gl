#該程式未解開Section, 採用最新樣板產出!
{<section id="aglq716_x02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2016-05-27 14:20:40), PR版次:0002(2016-05-27 14:42:16)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000048
#+ Filename...: aglq716_x02
#+ Description: ...
#+ Creator....: 02599(2015-03-18 11:08:18)
#+ Modifier...: 02599 -SD/PR- 02599
 
{</section>}
 
{<section id="aglq716_x02.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#160505-00007#13  2016/05/27  By 02599 程式优化
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
 
{<section id="aglq716_x02.main" readonly="Y" >}
PUBLIC FUNCTION aglq716_x02(p_arg1,p_arg2)
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
   LET g_rep_code = "aglq716_x02"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL aglq716_x02_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL aglq716_x02_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL aglq716_x02_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL aglq716_x02_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL aglq716_x02_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="aglq716_x02.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION aglq716_x02_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "glgaent.glga_t.glgaent,glgacomp.glga_t.glgacomp,glgacomp_desc.ooefl_t.ooefl003,glgald.glga_t.glgald,glgald_desc.glaal_t.glaal002,glga100.type_t.chr200,glgb021.glgb_t.glgb021,glgb021_desc.ooefl_t.ooefl004,style.type_t.chr200,glgadocdt.glga_t.glgadocdt,glga101.type_t.chr200,xrca001.type_t.chr200,glgadocno.glga_t.glgadocno,glga007.glga_t.glga007,glgb002.glgb_t.glgb002,glgb002_desc.glacl_t.glacl004,glgb003.glgb_t.glgb003,glgb004.glgb_t.glgb004,glgb0041.glgb_t.glgb004" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="aglq716_x02.ins_prep" readonly="Y" >}
PRIVATE FUNCTION aglq716_x02_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="aglq716_x02.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aglq716_x02_sel_prep()
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
   LET g_select = " SELECT glgaent,glgacomp,'',glgald,'','',glgb021,'','',glgadocdt,'','',glgadocno, 
       glga007,glgb002,'',glgb003,glgb004,0"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
#160505-00007#13--mod--str--
#   LET g_select = " SELECT glgaent,glgacomp,glgacomp_desc,glgald,glgald_desc,glga100,glgb021,glgb021_desc,style,
#                           glgadocdt,glga101,xrca001,glgadocno,glga007,glgb002,glgb002_desc,
#                           glgb003,glgb004,glgb0041"
   LET g_select = " SELECT glgaent,glgacomp,glgacomp_desc,glgald,glgald_desc,",
                  "        CASE WHEN RTRIM(glga100) IS NULL THEN glga100 ELSE glga100||':'||t1.gzcbl004 END,",
                  "        glgb021,glgb021_desc,style,glgadocdt,",
                  "        CASE WHEN RTRIM(glga101) IS NULL THEN glga101 ELSE glga101||':'||t2.gzcbl004 END,",
                  "        xrca001,glgadocno,glga007,glgb002,glgb002_desc,glgb003,glgb004,glgb0041"
#160505-00007#13--mod--end
   #end add-point
    LET g_from = " FROM glga_t,glgb_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET g_from = " FROM ",tm.table
   #160505-00007#13--add--str--
   LET g_from = g_from,
                " LEFT JOIN gzcbl_t t1 ON t1.gzcbl001='8007' AND t1.gzcbl002=glga100 AND t1.gzcbl003='",g_dlang,"' ",
                " LEFT JOIN gzcbl_t t2 ON t2.gzcbl001='8007' AND t2.gzcbl002=glga100 AND t2.gzcbl003='",g_dlang,"' "
   #160505-00007#13--add--end
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("glga_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = g_sql," ORDER BY seq"
   #end add-point
   PREPARE aglq716_x02_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE aglq716_x02_curs CURSOR FOR aglq716_x02_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="aglq716_x02.ins_data" readonly="Y" >}
PRIVATE FUNCTION aglq716_x02_ins_data()
DEFINE sr RECORD 
   glgaent LIKE glga_t.glgaent, 
   glgacomp LIKE glga_t.glgacomp, 
   glgacomp_desc LIKE ooefl_t.ooefl003, 
   glgald LIKE glga_t.glgald, 
   glgald_desc LIKE glaal_t.glaal002, 
   glga100 LIKE type_t.chr200, 
   glgb021 LIKE glgb_t.glgb021, 
   glgb021_desc LIKE ooefl_t.ooefl004, 
   style LIKE type_t.chr200, 
   glgadocdt LIKE glga_t.glgadocdt, 
   glga101 LIKE type_t.chr200, 
   xrca001 LIKE type_t.chr200, 
   glgadocno LIKE glga_t.glgadocno, 
   glga007 LIKE glga_t.glga007, 
   glgb002 LIKE glgb_t.glgb002, 
   glgb002_desc LIKE glacl_t.glacl004, 
   glgb003 LIKE glgb_t.glgb003, 
   glgb004 LIKE glgb_t.glgb004, 
   glgb0041 LIKE glgb_t.glgb004
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_desc      STRING
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH aglq716_x02_curs INTO sr.*                               
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
#160505-00007#13--mark--str--
#       #資料來源glga100
#       IF NOT cl_null(sr.glga100) THEN
#          CALL s_desc_gzcbl004_desc('8007',sr.glga100) RETURNING l_desc
#          LET sr.glga100 = sr.glga100,':',l_desc
#       END IF
#       #資料類別
#       IF NOT cl_null(sr.glga101) THEN
#          CALL s_desc_gzcbl004_desc('8035',sr.glga101) RETURNING l_desc
#          LET sr.glga101 = sr.glga101,':',l_desc
#       END IF
#160505-00007#13--mark--end
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.glgaent,sr.glgacomp,sr.glgacomp_desc,sr.glgald,sr.glgald_desc,sr.glga100,sr.glgb021,sr.glgb021_desc,sr.style,sr.glgadocdt,sr.glga101,sr.xrca001,sr.glgadocno,sr.glga007,sr.glgb002,sr.glgb002_desc,sr.glgb003,sr.glgb004,sr.glgb0041
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "aglq716_x02_execute"
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
 
{<section id="aglq716_x02.rep_data" readonly="Y" >}
PRIVATE FUNCTION aglq716_x02_rep_data()
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
 
{<section id="aglq716_x02.other_function" readonly="Y" >}

 
{</section>}
 
