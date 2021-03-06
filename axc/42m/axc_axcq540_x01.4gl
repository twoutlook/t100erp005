#該程式未解開Section, 採用最新樣板產出!
{<section id="axcq540_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2016-01-15 16:29:29), PR版次:0002(2016-01-15 16:27:41)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000049
#+ Filename...: axcq540_x01
#+ Description: ...
#+ Creator....: 06021(2015-03-17 16:27:05)
#+ Modifier...: 07024 -SD/PR- 07024
 
{</section>}
 
{<section id="axcq540_x01.global" readonly="Y" >}
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
       wc STRING,                  #QBE 
       tmp STRING                   #臨時表
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="axcq540_x01.main" readonly="Y" >}
PUBLIC FUNCTION axcq540_x01(p_arg1,p_arg2)
DEFINE  p_arg1 STRING                  #tm.wc  QBE 
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
   LET g_rep_code = "axcq540_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL axcq540_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL axcq540_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL axcq540_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL axcq540_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL axcq540_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="axcq540_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION axcq540_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "sfaa068.xcce_t.xcce006,sfaa068_desc.type_t.chr100,xccd006.xccd_t.xccd006,xccd007.xccd_t.xccd007,xccd007_desc.type_t.chr100,xccd007_desc_1.type_t.chr100,xcce007.xcce_t.xcce007,xcce007_desc.type_t.chr100,xcce007_desc_1.type_t.chr100,xcce008.xcce_t.xcce008,xcce009.xcce_t.xcce009,xcbb005.type_t.chr100,xcbb005_desc.type_t.chr100,xccd002.xccd_t.xccd002,xcce101.xcce_t.xcce101,xcce102.xcce_t.xcce102,xcce201.xcce_t.xcce201,xcce202.xcce_t.xcce202,xcce301.xcce_t.xcce301,xcce302.xcce_t.xcce302,xcce303.xcce_t.xcce303,xcce304.xcce_t.xcce304,xcce307.xcce_t.xcce307,xcce308.xcce_t.xcce308,xcce901.xcce_t.xcce901,xcce902.xcce_t.xcce902,xccdcomp.xccd_t.xccdcomp,xccdcomp_desc.type_t.chr100,xccd004.xccd_t.xccd004,xccd001.xccd_t.xccd001,xccd001_desc.type_t.chr100,xccdld.xccd_t.xccdld,xccdld_desc.type_t.chr100,xccd005.xccd_t.xccd005,xccd003.xccd_t.xccd003,xccd003_desc.type_t.chr100,xccdent.xccd_t.xccdent,l_xccdkey.type_t.num10" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="axcq540_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION axcq540_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="axcq540_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axcq540_x01_sel_prep()
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
   LET g_select = " SELECT NULL,NULL,xccd006,xccd007,NULL,NULL,xcce007,NULL,NULL,xcce008,xcce009,NULL, 
       NULL,xccd002,xcce101,xcce102,xcce201,xcce202,xcce301,xcce302,xcce303,xcce304,xcce307,xcce308, 
       xcce901,xcce902,xccdcomp,NULL,xccd004,xccd001,NULL,xccdld,NULL,xccd005,xccd003,NULL,xccdent,NULL" 
 
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
    LET g_select =" SELECT * "
   #end add-point
    LET g_from = " FROM xccd_t,xcce_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
    LET g_from =" FROM ",tm.tmp
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("xccd_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = g_sql CLIPPED," ORDER BY xccdkey" #160106-00012#1-add
   #end add-point
   PREPARE axcq540_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE axcq540_x01_curs CURSOR FOR axcq540_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="axcq540_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION axcq540_x01_ins_data()
DEFINE sr RECORD 
   sfaa068 LIKE xcce_t.xcce006, 
   sfaa068_desc LIKE type_t.chr100, 
   xccd006 LIKE xccd_t.xccd006, 
   xccd007 LIKE xccd_t.xccd007, 
   xccd007_desc LIKE type_t.chr100, 
   xccd007_desc_1 LIKE type_t.chr100, 
   xcce007 LIKE xcce_t.xcce007, 
   xcce007_desc LIKE type_t.chr100, 
   xcce007_desc_1 LIKE type_t.chr100, 
   xcce008 LIKE xcce_t.xcce008, 
   xcce009 LIKE xcce_t.xcce009, 
   xcbb005 LIKE type_t.chr100, 
   xcbb005_desc LIKE type_t.chr100, 
   xccd002 LIKE xccd_t.xccd002, 
   xcce101 LIKE xcce_t.xcce101, 
   xcce102 LIKE xcce_t.xcce102, 
   xcce201 LIKE xcce_t.xcce201, 
   xcce202 LIKE xcce_t.xcce202, 
   xcce301 LIKE xcce_t.xcce301, 
   xcce302 LIKE xcce_t.xcce302, 
   xcce303 LIKE xcce_t.xcce303, 
   xcce304 LIKE xcce_t.xcce304, 
   xcce307 LIKE xcce_t.xcce307, 
   xcce308 LIKE xcce_t.xcce308, 
   xcce901 LIKE xcce_t.xcce901, 
   xcce902 LIKE xcce_t.xcce902, 
   xccdcomp LIKE xccd_t.xccdcomp, 
   xccdcomp_desc LIKE type_t.chr100, 
   xccd004 LIKE xccd_t.xccd004, 
   xccd001 LIKE xccd_t.xccd001, 
   xccd001_desc LIKE type_t.chr100, 
   xccdld LIKE xccd_t.xccdld, 
   xccdld_desc LIKE type_t.chr100, 
   xccd005 LIKE xccd_t.xccd005, 
   xccd003 LIKE xccd_t.xccd003, 
   xccd003_desc LIKE type_t.chr100, 
   xccdent LIKE xccd_t.xccdent, 
   l_xccdkey LIKE type_t.num10
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
 
    FOREACH axcq540_x01_curs INTO sr.*                               
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
       IF NOT cl_null(sr.xccdcomp_desc) THEN
         LET sr.xccdcomp_desc = sr.xccdcomp,"(",sr.xccdcomp_desc CLIPPED,")"
       ELSE
         LET sr.xccdcomp_desc = sr.xccdcomp
       END IF
       
       IF NOT cl_null(sr.xccdld_desc) THEN
         LET sr.xccdld_desc = sr.xccdld,"(",sr.xccdld_desc CLIPPED,")"
       ELSE
         LET sr.xccdld_desc = sr.xccdld
       END IF
       
       IF NOT cl_null(sr.xccd003_desc) THEN
         LET sr.xccd003_desc = sr.xccd003,"(",sr.xccd003_desc CLIPPED,")"
       ELSE
         LET sr.xccd003_desc = sr.xccd003
       END IF

       
      #本位顺序说明
#       SELECT gzcbl004 INTO sr.xccd001_desc FROM gzcbl_t WHERE  gzcbl001='8914' AND gzcbl002=sr.xccd001 AND gzcbl003=g_dlang  #160108-00001#1-mark
       LET sr.xccd001_desc=sr.xccd001,".",sr.xccd001_desc CLIPPED
       
       SELECT glaa001,glaa016,glaa020 INTO l_glaa001,l_glaa016,l_glaa020
         FROM glaa_t
         WHERE glaaent = g_enterprise
         AND glaald  = sr.xccdld
       CASE sr.xccd001
          WHEN '1'
             CALL s_desc_get_currency_desc(l_glaa001) RETURNING l_currency_desc
          WHEN '2'
             CALL s_desc_get_currency_desc(l_glaa016) RETURNING l_currency_desc
          WHEN '3'
             CALL s_desc_get_currency_desc(l_glaa020) RETURNING l_currency_desc
       END CASE
       IF NOT cl_null(l_currency_desc) THEN
          LET sr.xccd001_desc=sr.xccd001_desc,'(',l_currency_desc,')'
       END IF
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.sfaa068,sr.sfaa068_desc,sr.xccd006,sr.xccd007,sr.xccd007_desc,sr.xccd007_desc_1,sr.xcce007,sr.xcce007_desc,sr.xcce007_desc_1,sr.xcce008,sr.xcce009,sr.xcbb005,sr.xcbb005_desc,sr.xccd002,sr.xcce101,sr.xcce102,sr.xcce201,sr.xcce202,sr.xcce301,sr.xcce302,sr.xcce303,sr.xcce304,sr.xcce307,sr.xcce308,sr.xcce901,sr.xcce902,sr.xccdcomp,sr.xccdcomp_desc,sr.xccd004,sr.xccd001,sr.xccd001_desc,sr.xccdld,sr.xccdld_desc,sr.xccd005,sr.xccd003,sr.xccd003_desc,sr.xccdent,sr.l_xccdkey
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "axcq540_x01_execute"
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
 
{<section id="axcq540_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION axcq540_x01_rep_data()
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
 
{<section id="axcq540_x01.other_function" readonly="Y" >}

 
{</section>}
 
