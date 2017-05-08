#該程式未解開Section, 採用最新樣板產出!
{<section id="axcq515_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2016-05-20 13:58:59), PR版次:0003(2016-05-20 14:12:18)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000051
#+ Filename...: axcq515_x01
#+ Description: ...
#+ Creator....: 05795(2015-03-25 15:27:37)
#+ Modifier...: 02599 -SD/PR- 02599
 
{</section>}
 
{<section id="axcq515_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#160520-00002#1  By 02599     程式优化
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
       wc STRING,                  #qbe 
       tmp STRING                   #臨時表
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="axcq515_x01.main" readonly="Y" >}
PUBLIC FUNCTION axcq515_x01(p_arg1,p_arg2)
DEFINE  p_arg1 STRING                  #tm.wc  qbe 
DEFINE  p_arg2 STRING                  #tm.tmp  臨時表
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.tmp = p_arg2
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "axcq515_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL axcq515_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL axcq515_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL axcq515_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL axcq515_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL axcq515_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="axcq515_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION axcq515_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "xccksite.xcck_t.xccksite,xccksite_desc.type_t.chr300,xcck047.xcck_t.xcck047,xcck006.xcck_t.xcck006,xcck013.xcck_t.xcck013,xcck007.xcck_t.xcck007,xcck008.xcck_t.xcck008,xcck010.xcck_t.xcck010,xcck010_desc1.type_t.chr300,xcck010_desc2.type_t.chr300,xcck011.xcck_t.xcck011,xcck002.xcck_t.xcck002,xcck002_desc.type_t.chr300,xcck015.xcck_t.xcck015,xcck015_desc.type_t.chr300,xcck017.xcck_t.xcck017,xcck044.xcck_t.xcck044,xcck044_desc.type_t.chr300,xcck009.xcck_t.xcck009,xcck201.xcck_t.xcck201,xcck282a.xcck_t.xcck282a,xcck282b.xcck_t.xcck282b,xcck282c.xcck_t.xcck282c,xcck282d.xcck_t.xcck282d,xcck282e.xcck_t.xcck282e,xcck282f.xcck_t.xcck282f,xcck282g.xcck_t.xcck282g,xcck282h.xcck_t.xcck282h,xcck282.xcck_t.xcck282,xcck202a.xcck_t.xcck202a,xcck202b.xcck_t.xcck202b,xcck202c.xcck_t.xcck202c,xcck202d.xcck_t.xcck202d,xcck202e.xcck_t.xcck202e,xcck202f.xcck_t.xcck202f,xcck202g.xcck_t.xcck202g,xcck202h.xcck_t.xcck202h,xcck202.xcck_t.xcck202,xcckcomp.xcck_t.xcckcomp,xcckld.xcck_t.xcckld,xcckcomp_desc.type_t.chr300,xcckld_desc.type_t.chr300,xcck001.xcck_t.xcck001,xcck003.xcck_t.xcck003,xcck004.xcck_t.xcck004,xcck005.xcck_t.xcck005,xcck001_desc.type_t.chr300,xcck003_desc.type_t.chr300,xcck004_desc.type_t.chr300,xcck005_desc.type_t.chr300,xcck_key.type_t.chr1000" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="axcq515_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION axcq515_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?, 
             ?)"
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
 
{<section id="axcq515_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axcq515_x01_sel_prep()
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
   LET g_select = " SELECT * "
#   #end add-point
#   LET g_select = " SELECT xccksite,NULL,xcck047,xcck006,xcck013,xcck007,xcck008,xcck010,NULL,NULL,xcck011, 
#       xcck002,NULL,xcck015,NULL,xcck017,xcck044,NULL,xcck009,xcck201,xcck282a,xcck282b,xcck282c,xcck282d, 
#       xcck282e,xcck282f,xcck282g,xcck282h,xcck282,xcck202a,xcck202b,xcck202c,xcck202d,xcck202e,xcck202f, 
#       xcck202g,xcck202h,xcck202,xcckcomp,xcckld,NULL,NULL,xcck001,xcck003,xcck004,xcck005,NULL,NULL, 
#       NULL,NULL,NULL"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_from = " FROM ",tm.tmp
#   #end add-point
#    LET g_from = " FROM xcck_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("xcck_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE axcq515_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE axcq515_x01_curs CURSOR FOR axcq515_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="axcq515_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION axcq515_x01_ins_data()
DEFINE sr RECORD 
   xccksite LIKE xcck_t.xccksite, 
   xccksite_desc LIKE type_t.chr300, 
   xcck047 LIKE xcck_t.xcck047, 
   xcck006 LIKE xcck_t.xcck006, 
   xcck013 LIKE xcck_t.xcck013, 
   xcck007 LIKE xcck_t.xcck007, 
   xcck008 LIKE xcck_t.xcck008, 
   xcck010 LIKE xcck_t.xcck010, 
   xcck010_desc1 LIKE type_t.chr300, 
   xcck010_desc2 LIKE type_t.chr300, 
   xcck011 LIKE xcck_t.xcck011, 
   xcck002 LIKE xcck_t.xcck002, 
   xcck002_desc LIKE type_t.chr300, 
   xcck015 LIKE xcck_t.xcck015, 
   xcck015_desc LIKE type_t.chr300, 
   xcck017 LIKE xcck_t.xcck017, 
   xcck044 LIKE xcck_t.xcck044, 
   xcck044_desc LIKE type_t.chr300, 
   xcck009 LIKE xcck_t.xcck009, 
   xcck201 LIKE xcck_t.xcck201, 
   xcck282a LIKE xcck_t.xcck282a, 
   xcck282b LIKE xcck_t.xcck282b, 
   xcck282c LIKE xcck_t.xcck282c, 
   xcck282d LIKE xcck_t.xcck282d, 
   xcck282e LIKE xcck_t.xcck282e, 
   xcck282f LIKE xcck_t.xcck282f, 
   xcck282g LIKE xcck_t.xcck282g, 
   xcck282h LIKE xcck_t.xcck282h, 
   xcck282 LIKE xcck_t.xcck282, 
   xcck202a LIKE xcck_t.xcck202a, 
   xcck202b LIKE xcck_t.xcck202b, 
   xcck202c LIKE xcck_t.xcck202c, 
   xcck202d LIKE xcck_t.xcck202d, 
   xcck202e LIKE xcck_t.xcck202e, 
   xcck202f LIKE xcck_t.xcck202f, 
   xcck202g LIKE xcck_t.xcck202g, 
   xcck202h LIKE xcck_t.xcck202h, 
   xcck202 LIKE xcck_t.xcck202, 
   xcckcomp LIKE xcck_t.xcckcomp, 
   xcckld LIKE xcck_t.xcckld, 
   xcckcomp_desc LIKE type_t.chr300, 
   xcckld_desc LIKE type_t.chr300, 
   xcck001 LIKE xcck_t.xcck001, 
   xcck003 LIKE xcck_t.xcck003, 
   xcck004 LIKE xcck_t.xcck004, 
   xcck005 LIKE xcck_t.xcck005, 
   xcck001_desc LIKE type_t.chr300, 
   xcck003_desc LIKE type_t.chr300, 
   xcck004_desc LIKE type_t.chr300, 
   xcck005_desc LIKE type_t.chr300, 
   xcck_key LIKE type_t.chr1000
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_glaa001        LIKE glaa_t.glaa001  #使用币别
DEFINE l_glaa016        LIKE glaa_t.glaa016  #本位幣二
DEFINE l_glaa020        LIKE glaa_t.glaa020  #本位幣三
DEFINE l_currency_desc  LIKE type_t.chr100
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH axcq515_x01_curs INTO sr.*                               
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
#160520-00002#1--mark--str--
#       IF NOT cl_null(sr.xcckcomp_desc) THEN
#         LET sr.xcckcomp_desc = sr.xcckcomp,"(",sr.xcckcomp_desc CLIPPED,")"
#       ELSE
#         LET sr.xcckcomp_desc = sr.xcckcomp
#       END IF
#       
#       IF NOT cl_null(sr.xcckld_desc) THEN
#         LET sr.xcckld_desc = sr.xcckld,"(",sr.xcckld_desc CLIPPED,")"
#       ELSE
#         LET sr.xcckld_desc = sr.xcckld
#       END IF
#       
#       IF NOT cl_null(sr.xcck003_desc) THEN
#         LET sr.xcck003_desc = sr.xcck003,"(",sr.xcck003_desc CLIPPED,")"
#       ELSE
#         LET sr.xcck003_desc = sr.xcck003
#       END IF
#       
#       #本位顺序说明
#       SELECT gzcbl004 INTO sr.xcck001_desc FROM gzcbl_t WHERE  gzcbl001='8914' AND gzcbl002=sr.xcck001 AND gzcbl003=g_dlang  
#       LET sr.xcck001_desc=sr.xcck001,".",sr.xcck001_desc CLIPPED
#       
#       SELECT glaa001,glaa016,glaa020 INTO l_glaa001,l_glaa016,l_glaa020
#         FROM glaa_t
#         WHERE glaaent = g_enterprise
#         AND glaald  = sr.xcckld
#       CASE sr.xcck001
#          WHEN '1'
#             CALL s_desc_get_currency_desc(l_glaa001) RETURNING l_currency_desc
#          WHEN '2'
#             CALL s_desc_get_currency_desc(l_glaa016) RETURNING l_currency_desc
#          WHEN '3'
#             CALL s_desc_get_currency_desc(l_glaa020) RETURNING l_currency_desc
#       END CASE
#       IF NOT cl_null(l_currency_desc) THEN
#          LET sr.xcck001_desc=sr.xcck001_desc,'(',l_currency_desc,')'
#       END IF
#160520-00002#1--mark--end
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.xccksite,sr.xccksite_desc,sr.xcck047,sr.xcck006,sr.xcck013,sr.xcck007,sr.xcck008,sr.xcck010,sr.xcck010_desc1,sr.xcck010_desc2,sr.xcck011,sr.xcck002,sr.xcck002_desc,sr.xcck015,sr.xcck015_desc,sr.xcck017,sr.xcck044,sr.xcck044_desc,sr.xcck009,sr.xcck201,sr.xcck282a,sr.xcck282b,sr.xcck282c,sr.xcck282d,sr.xcck282e,sr.xcck282f,sr.xcck282g,sr.xcck282h,sr.xcck282,sr.xcck202a,sr.xcck202b,sr.xcck202c,sr.xcck202d,sr.xcck202e,sr.xcck202f,sr.xcck202g,sr.xcck202h,sr.xcck202,sr.xcckcomp,sr.xcckld,sr.xcckcomp_desc,sr.xcckld_desc,sr.xcck001,sr.xcck003,sr.xcck004,sr.xcck005,sr.xcck001_desc,sr.xcck003_desc,sr.xcck004_desc,sr.xcck005_desc,sr.xcck_key
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "axcq515_x01_execute"
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
 
{<section id="axcq515_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION axcq515_x01_rep_data()
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
 
{<section id="axcq515_x01.other_function" readonly="Y" >}

 
{</section>}
 
