#該程式未解開Section, 採用最新樣板產出!
{<section id="axcq520_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2016-05-03 10:38:42), PR版次:0003(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000052
#+ Filename...: axcq520_x01
#+ Description: ...
#+ Creator....: 06021(2015-03-17 16:26:38)
#+ Modifier...: 01588 -SD/PR- 00000
 
{</section>}
 
{<section id="axcq520_x01.global" readonly="Y" >}
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
 
{<section id="axcq520_x01.main" readonly="Y" >}
PUBLIC FUNCTION axcq520_x01(p_arg1,p_arg2)
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
   LET g_rep_code = "axcq520_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL axcq520_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL axcq520_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL axcq520_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL axcq520_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL axcq520_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="axcq520_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION axcq520_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "xcco004.xcco_t.xcco004,xcco005.xcco_t.xcco005,xcco002.xcco_t.xcco002,xcco002_desc.type_t.chr100,xcco006.xcco_t.xcco006,xcco006_desc.type_t.chr100,xcco006_desc_1.type_t.chr100,xcco007.xcco_t.xcco007,xcco008.xcco_t.xcco008,l_imag011.imag_t.imag011,l_imag011_desc.type_t.chr100,xcco010.xcco_t.xcco010,xcco010_desc.type_t.chr100,xcco009.xcco_t.xcco009,xcco011.xcco_t.xcco011,xcco102.xcco_t.xcco102,xcco102a.xcco_t.xcco102a,xcco102b.xcco_t.xcco102b,xcco102d.xcco_t.xcco102d,xcco102e.xcco_t.xcco102e,xcco102f.xcco_t.xcco102f,xcco102g.xcco_t.xcco102g,xcco102h.xcco_t.xcco102h,xcco102c.xcco_t.xcco102c,xccocomp.xcco_t.xccocomp,xccocomp_desc.type_t.chr100,xcco001.xcco_t.xcco001,xcco001_desc.type_t.chr100,xccold.xcco_t.xccold,xccold_desc.type_t.chr100,xcco003.xcco_t.xcco003,xcco003_desc.type_t.chr100,xccoent.xcco_t.xccoent,xccokey.type_t.chr1000" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="axcq520_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION axcq520_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="axcq520_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axcq520_x01_sel_prep()
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
   LET g_select = " SELECT xcco004,xcco005,xcco002,NULL,xcco006,NULL,NULL,xcco007,xcco008,NULL,NULL, 
       xcco010,NULL,xcco009,xcco011,xcco102,xcco102a,xcco102b,xcco102d,xcco102e,xcco102f,xcco102g,xcco102h, 
       xcco102c,xccocomp,NULL,xcco001,NULL,xccold,NULL,xcco003,NULL,xccoent,NULL"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
    LET g_select =" SELECT * "
   #end add-point
    LET g_from = " FROM xcco_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
    LET g_from =" FROM ",tm.tmp
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("xcco_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE axcq520_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE axcq520_x01_curs CURSOR FOR axcq520_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="axcq520_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION axcq520_x01_ins_data()
DEFINE sr RECORD 
   xcco004 LIKE xcco_t.xcco004, 
   xcco005 LIKE xcco_t.xcco005, 
   xcco002 LIKE xcco_t.xcco002, 
   xcco002_desc LIKE type_t.chr100, 
   xcco006 LIKE xcco_t.xcco006, 
   xcco006_desc LIKE type_t.chr100, 
   xcco006_desc_1 LIKE type_t.chr100, 
   xcco007 LIKE xcco_t.xcco007, 
   xcco008 LIKE xcco_t.xcco008, 
   l_imag011 LIKE imag_t.imag011, 
   l_imag011_desc LIKE type_t.chr100, 
   xcco010 LIKE xcco_t.xcco010, 
   xcco010_desc LIKE type_t.chr100, 
   xcco009 LIKE xcco_t.xcco009, 
   xcco011 LIKE xcco_t.xcco011, 
   xcco102 LIKE xcco_t.xcco102, 
   xcco102a LIKE xcco_t.xcco102a, 
   xcco102b LIKE xcco_t.xcco102b, 
   xcco102d LIKE xcco_t.xcco102d, 
   xcco102e LIKE xcco_t.xcco102e, 
   xcco102f LIKE xcco_t.xcco102f, 
   xcco102g LIKE xcco_t.xcco102g, 
   xcco102h LIKE xcco_t.xcco102h, 
   xcco102c LIKE xcco_t.xcco102c, 
   xccocomp LIKE xcco_t.xccocomp, 
   xccocomp_desc LIKE type_t.chr100, 
   xcco001 LIKE xcco_t.xcco001, 
   xcco001_desc LIKE type_t.chr100, 
   xccold LIKE xcco_t.xccold, 
   xccold_desc LIKE type_t.chr100, 
   xcco003 LIKE xcco_t.xcco003, 
   xcco003_desc LIKE type_t.chr100, 
   xccoent LIKE xcco_t.xccoent, 
   xccokey LIKE type_t.chr1000
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
 
    FOREACH axcq520_x01_curs INTO sr.*                               
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
       IF NOT cl_null(sr.xccocomp_desc) THEN
         LET sr.xccocomp_desc = sr.xccocomp,"(",sr.xccocomp_desc CLIPPED,")"
       ELSE
         LET sr.xccocomp_desc = sr.xccocomp
       END IF
       
       IF NOT cl_null(sr.xccold_desc) THEN
         LET sr.xccold_desc = sr.xccold,"(",sr.xccold_desc CLIPPED,")"
       ELSE
         LET sr.xccold_desc = sr.xccold
       END IF
       
       IF NOT cl_null(sr.xcco003_desc) THEN
         LET sr.xcco003_desc = sr.xcco003,"(",sr.xcco003_desc CLIPPED,")"
       ELSE
         LET sr.xcco003_desc = sr.xcco003
       END IF

       
      #本位顺序说明
       SELECT gzcbl004 INTO sr.xcco001_desc FROM gzcbl_t WHERE  gzcbl001='8914' AND gzcbl002=sr.xcco001 AND gzcbl003=g_dlang  
       LET sr.xcco001_desc=sr.xcco001,".",sr.xcco001_desc CLIPPED
       
       SELECT glaa001,glaa016,glaa020 INTO l_glaa001,l_glaa016,l_glaa020
         FROM glaa_t
         WHERE glaaent = g_enterprise
         AND glaald  = sr.xccold
       CASE sr.xcco001
          WHEN '1'
             CALL s_desc_get_currency_desc(l_glaa001) RETURNING l_currency_desc
          WHEN '2'
             CALL s_desc_get_currency_desc(l_glaa016) RETURNING l_currency_desc
          WHEN '3'
             CALL s_desc_get_currency_desc(l_glaa020) RETURNING l_currency_desc
       END CASE
       IF NOT cl_null(l_currency_desc) THEN
          LET sr.xcco001_desc=sr.xcco001_desc,'(',l_currency_desc,')'
       END IF
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.xcco004,sr.xcco005,sr.xcco002,sr.xcco002_desc,sr.xcco006,sr.xcco006_desc,sr.xcco006_desc_1,sr.xcco007,sr.xcco008,sr.l_imag011,sr.l_imag011_desc,sr.xcco010,sr.xcco010_desc,sr.xcco009,sr.xcco011,sr.xcco102,sr.xcco102a,sr.xcco102b,sr.xcco102d,sr.xcco102e,sr.xcco102f,sr.xcco102g,sr.xcco102h,sr.xcco102c,sr.xccocomp,sr.xccocomp_desc,sr.xcco001,sr.xcco001_desc,sr.xccold,sr.xccold_desc,sr.xcco003,sr.xcco003_desc,sr.xccoent,sr.xccokey
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "axcq520_x01_execute"
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
 
{<section id="axcq520_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION axcq520_x01_rep_data()
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
 
{<section id="axcq520_x01.other_function" readonly="Y" >}

 
{</section>}
 
