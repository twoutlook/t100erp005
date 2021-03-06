#該程式未解開Section, 採用最新樣板產出!
{<section id="axcr311_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2016-04-29 14:32:13), PR版次:0002(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000025
#+ Filename...: axcr311_x01
#+ Description: ...
#+ Creator....: 07024(2016-04-25 15:48:41)
#+ Modifier...: 02040 -SD/PR- 00000
 
{</section>}
 
{<section id="axcr311_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#160408-00022#2   2016/4/27  By dorislai  增加成本中心、成本中心的欄位
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
       wc STRING                   #where condition
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="axcr311_x01.main" readonly="Y" >}
PUBLIC FUNCTION axcr311_x01(p_arg1)
DEFINE  p_arg1 STRING                  #tm.wc  where condition
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
   LET g_rep_code = "axcr311_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL axcr311_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL axcr311_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL axcr311_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL axcr311_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL axcr311_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="axcr311_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION axcr311_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "l_xccpcomp_ooefl003.type_t.chr1000,l_xccpld_glaal002.type_t.chr1000,l_xccp004_xccp005.type_t.chr30,l_xccp003_xcatl003.type_t.chr1000,xccp006.xccp_t.xccp006,l_xccp008_desc.type_t.chr100,l_sfaa068.sfaa_t.sfaa068,l_sfaa068_desc.ooefl_t.ooefl003,xccp007.xccp_t.xccp007,l_sfaa010.sfaa_t.sfaa010,xccp009.xccp_t.xccp009,xccp101.xccp_t.xccp101,xccp102a.xccp_t.xccp102a,xccp102b.xccp_t.xccp102b,xccp102c.xccp_t.xccp102c,xccp102d.xccp_t.xccp102d,xccp102e.xccp_t.xccp102e,xccp102f.xccp_t.xccp102f,xccp102g.xccp_t.xccp102g,xccp102h.xccp_t.xccp102h,xccp102.xccp_t.xccp102,l_key.type_t.chr500" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="axcr311_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION axcr311_x01_ins_prep()
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
 
{<section id="axcr311_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axcr311_x01_sel_prep()
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
   LET g_select = " SELECT xccpent,xccpcomp,xccpld,
                          CASE WHEN ooefl003 IS NULL THEN xccpcomp ELSE trim(xccpcomp)||'.'||trim(ooefl003) END,
                          CASE WHEN glaal002 IS NULL THEN xccpld ELSE trim(xccpld)||'.'||trim(glaal002) END, 
                          trim(xccp004)||'/'||trim(xccp005),
                          CASE WHEN xcatl003 IS NULL THEN xccp003 ELSE trim(xccp003)||'.'||trim(xcatl003) END,
                          xccp006,
                          CASE WHEN gzcbl004 IS NULL THEN xccp008 ELSE trim(xccp008)||'.'||trim(gzcbl004) END,",
                  #160408-00022#2-add-(S)
                  "        sfaa068,
                          (SELECT ooefl003 FROM ooefl_t WHERE ooeflent=xccpent AND ooefl002='",g_dlang,"'AND ooefl001 = sfaa068),",
                  #160408-00022#2-add-(E)
                  "       xccp007,
                          (SELECT sfaa010 FROM sfaa_t WHERE sfaaent = xccpent AND sfaadocno = xccp007 ) sfaa010,
                          xccp009,xccp101,xccp102a,xccp102b,xccp102c,xccp102d,xccp102e,xccp102f,xccp102g,xccp102h,xccp102,
                          trim(xccpcomp)||'-'||trim(xccpld)||'-'||trim(xccp004)||'-'||trim(xccp005)||'-'||trim(xccp003)||'-'||trim(xccp006)||'-'||trim(xccp008)"
#   #end add-point
#   LET g_select = " SELECT xccpent,xccpcomp,xccpld,trim(xccpcomp)||'.'||trim((SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooeflent = xccp_t.xccpent AND ooefl_t.ooefl001 = xccp_t.xccpcomp AND ooefl_t.ooefl002 = '" , 
#       g_dlang,"'" ,")),trim(xccpld)||'.'||trim((SELECT glaal002 FROM glaal_t WHERE glaal_t.glaalent = xccp_t.xccpent AND glaal_t.glaalld = xccp_t.xccpld AND glaal_t.glaal001 = '" , 
#       g_dlang,"'" ,")),NULL,trim(xccp003)||'.'||trim(xcatl003),xccp006,NULL,NULL,NULL,xccp007,NULL, 
#       xccp009,xccp101,xccp102a,xccp102b,xccp102c,xccp102d,xccp102e,xccp102f,xccp102g,xccp102h,xccp102, 
#       NULL"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_from = " FROM xccp_t LEFT OUTER JOIN xcatl_t ON xcatlent = xccpent AND xcatl001 = xccp003 AND xcatl002 = '",g_dlang,"'",
                "             LEFT OUTER JOIN glaal_t ON glaalent = xccpent AND glaalld = xccpld AND glaal001 = '",g_dlang,"'",
                "             LEFT OUTER JOIN ooefl_t ON ooeflent = xccpent AND ooefl001 = xccpcomp AND ooefl002 = '",g_dlang,"'",
                "             LEFT OUTER JOIN gzcbl_t ON gzcbl001 = '8919' AND gzcbl002 = xccp008 AND gzcbl003 = '",g_dlang,"'",
                "             LEFT OUTER JOIN sfaa_t ON sfaaent = xccpent AND sfaasite = '",g_site,"' AND sfaadocno = xccp007"  #160408-00022#2-add
#   #end add-point
#    LET g_from = " FROM xccp_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("xccp_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   DISPLAY "g_sql：",g_sql
   #end add-point
   PREPARE axcr311_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE axcr311_x01_curs CURSOR FOR axcr311_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="axcr311_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION axcr311_x01_ins_data()
DEFINE sr RECORD 
   xccpent LIKE xccp_t.xccpent, 
   xccpcomp LIKE xccp_t.xccpcomp, 
   xccpld LIKE xccp_t.xccpld, 
   l_xccpcomp_ooefl003 LIKE type_t.chr1000, 
   l_xccpld_glaal002 LIKE type_t.chr1000, 
   l_xccp004_xccp005 LIKE type_t.chr30, 
   l_xccp003_xcatl003 LIKE type_t.chr1000, 
   xccp006 LIKE xccp_t.xccp006, 
   l_xccp008_desc LIKE type_t.chr100, 
   l_sfaa068 LIKE sfaa_t.sfaa068, 
   l_sfaa068_desc LIKE ooefl_t.ooefl003, 
   xccp007 LIKE xccp_t.xccp007, 
   l_sfaa010 LIKE sfaa_t.sfaa010, 
   xccp009 LIKE xccp_t.xccp009, 
   xccp101 LIKE xccp_t.xccp101, 
   xccp102a LIKE xccp_t.xccp102a, 
   xccp102b LIKE xccp_t.xccp102b, 
   xccp102c LIKE xccp_t.xccp102c, 
   xccp102d LIKE xccp_t.xccp102d, 
   xccp102e LIKE xccp_t.xccp102e, 
   xccp102f LIKE xccp_t.xccp102f, 
   xccp102g LIKE xccp_t.xccp102g, 
   xccp102h LIKE xccp_t.xccp102h, 
   xccp102 LIKE xccp_t.xccp102, 
   l_key LIKE type_t.chr500
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH axcr311_x01_curs INTO sr.*                               
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
       EXECUTE insert_prep USING sr.l_xccpcomp_ooefl003,sr.l_xccpld_glaal002,sr.l_xccp004_xccp005,sr.l_xccp003_xcatl003,sr.xccp006,sr.l_xccp008_desc,sr.l_sfaa068,sr.l_sfaa068_desc,sr.xccp007,sr.l_sfaa010,sr.xccp009,sr.xccp101,sr.xccp102a,sr.xccp102b,sr.xccp102c,sr.xccp102d,sr.xccp102e,sr.xccp102f,sr.xccp102g,sr.xccp102h,sr.xccp102,sr.l_key
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "axcr311_x01_execute"
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
 
{<section id="axcr311_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION axcr311_x01_rep_data()
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
 
{<section id="axcr311_x01.other_function" readonly="Y" >}

 
{</section>}
 
