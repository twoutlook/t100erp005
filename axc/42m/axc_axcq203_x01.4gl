#該程式未解開Section, 採用最新樣板產出!
{<section id="axcq203_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2015-03-26 16:00:07), PR版次:0001(2015-03-26 16:34:54)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000045
#+ Filename...: axcq203_x01
#+ Description: ...
#+ Creator....: 05426(2015-03-17 09:47:39)
#+ Modifier...: 05426 -SD/PR- 05426
 
{</section>}
 
{<section id="axcq203_x01.global" readonly="Y" >}
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
       tmp STRING                   #暂存档
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
#end add-point
 
{</section>}
 
{<section id="axcq203_x01.main" readonly="Y" >}
PUBLIC FUNCTION axcq203_x01(p_arg1,p_arg2)
DEFINE  p_arg1 STRING                  #tm.wc  QBE 
DEFINE  p_arg2 STRING                  #tm.tmp  暂存档
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
   LET g_rep_code = "axcq203_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL axcq203_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL axcq203_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL axcq203_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL axcq203_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL axcq203_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="axcq203_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION axcq203_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "xcbs001.xcbs_t.xcbs001,xcbs001_desc.type_t.chr100,xcbs002.xcbs_t.xcbs002,xcbs003.xcbs_t.xcbs003,xcbsld.xcbs_t.xcbsld,xcbsld_desc.type_t.chr30,xcbs004.xcbs_t.xcbs004,xcbs004_desc.type_t.chr100,xcbs005.xcbs_t.xcbs005,xcbs005_desc.type_t.chr100,xccc001.xccc_t.xccc001,xccc001_desc.type_t.chr100,xcbs006.xcbs_t.xcbs006,xcbs008.xcbs_t.xcbs008,xcbs008_desc.type_t.chr100,xcbs009.xcbs_t.xcbs009,xcbs007.xcbs_t.xcbs007,xcbs007_desc.type_t.chr100,xcbs202.xcbs_t.xcbs202,xcbs100.xcbs_t.xcbs100,xcbs101.xcbs_t.xcbs101,mainkey.type_t.chr1000" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="axcq203_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION axcq203_x01_ins_prep()
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
 
{<section id="axcq203_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axcq203_x01_sel_prep()
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
   LET g_select = " SELECT xcbs001,NULL,xcbs002,xcbs003,xcbsld,NULL,xcbs004,NULL,xcbs005,NULL,NULL,NULL, 
       xcbs006,xcbs008,NULL,xcbs009,xcbs007,NULL,xcbs202,xcbs100,xcbs101,xcbscomp,xcbsent,NULL"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_select = " SELECT * "                
   #end add-point
    LET g_from = " FROM xcbs_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET g_from = " FROM ",tm.tmp
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
 
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("xcbs_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE axcq203_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE axcq203_x01_curs CURSOR FOR axcq203_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="axcq203_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION axcq203_x01_ins_data()
DEFINE sr RECORD 
   xcbs001 LIKE xcbs_t.xcbs001, 
   xcbs001_desc LIKE type_t.chr100, 
   xcbs002 LIKE xcbs_t.xcbs002, 
   xcbs003 LIKE xcbs_t.xcbs003, 
   xcbsld LIKE xcbs_t.xcbsld, 
   xcbsld_desc LIKE type_t.chr30, 
   xcbs004 LIKE xcbs_t.xcbs004, 
   xcbs004_desc LIKE type_t.chr100, 
   xcbs005 LIKE xcbs_t.xcbs005, 
   xcbs005_desc LIKE type_t.chr100, 
   xccc001 LIKE xccc_t.xccc001, 
   xccc001_desc LIKE type_t.chr100, 
   xcbs006 LIKE xcbs_t.xcbs006, 
   xcbs008 LIKE xcbs_t.xcbs008, 
   xcbs008_desc LIKE type_t.chr100, 
   xcbs009 LIKE xcbs_t.xcbs009, 
   xcbs007 LIKE xcbs_t.xcbs007, 
   xcbs007_desc LIKE type_t.chr100, 
   xcbs202 LIKE xcbs_t.xcbs202, 
   xcbs100 LIKE xcbs_t.xcbs100, 
   xcbs101 LIKE xcbs_t.xcbs101, 
   xcbscomp LIKE xcbs_t.xcbscomp, 
   xcbsent LIKE xcbs_t.xcbsent, 
   mainkey LIKE type_t.chr1000
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_glaa001        LIKE glaa_t.glaa001  #使用币别
DEFINE l_glaa016        LIKE glaa_t.glaa016  #本位幣二
DEFINE l_glaa020        LIKE glaa_t.glaa020  #本位幣三
DEFINE l_currency_desc  LIKE type_t.chr100
DEFINE l_xcbs002        LIKE type_t.chr4
DEFINE l_xcbs003        LIKE type_t.chr2
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH axcq203_x01_curs INTO sr.*                               
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
       #抓取分摊方式说明
       SELECT gzcbl004 INTO sr.xcbs007_desc FROM gzcbl_t WHERE  gzcbl001='8909' AND gzcbl002=sr.xcbs007 AND gzcbl003=g_dlang  
       LET sr.xcbs007_desc=sr.xcbs007,":",sr.xcbs007_desc CLIPPED
       #成本计算类型说明
       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = sr.xcbs001
       CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET sr.xcbs001_desc = '', g_rtn_fields[1] , ''
       IF NOT cl_null(sr.xcbs001_desc) THEN
          LET sr.xcbs001_desc=sr.xcbs001,'(',sr.xcbs001_desc,')' CLIPPED
       ELSE 
          LET sr.xcbs001_desc=sr.xcbs001
       END IF  
       #帐套说明
       SELECT glaal002 INTO sr.xcbsld_desc FROM glaal_t WHERE glaalent=g_enterprise AND glaalld=sr.xcbsld AND glaal001=g_dlang
       IF NOT cl_null(sr.xcbsld_desc) THEN
         LET sr.xcbsld_desc=sr.xcbsld,'(',sr.xcbsld_desc,')' CLIPPED
       ELSE
         LET sr.xcbsld_desc=sr.xcbsld
       END IF
       #成本中心说明
       SELECT ooefl003 INTO sr.xcbs004_desc FROM ooefl_t WHERE ooeflent=g_enterprise AND ooefl001=sr.xcbs004 AND ooefl002=g_dlang
       IF NOT cl_null(sr.xcbs004_desc) THEN
         LET sr.xcbs004_desc=sr.xcbs004,'(',sr.xcbs004_desc,')' CLIPPED
       ELSE
         LET sr.xcbs004_desc=sr.xcbs004
       END IF
       
       #成本主要素说明
       SELECT gzcbl004 INTO sr.xcbs005_desc FROM gzcbl_t WHERE  gzcbl001='8901' AND gzcbl002=sr.xcbs005 AND gzcbl003=g_dlang  
       LET sr.xcbs005_desc=sr.xcbs005,".",sr.xcbs005_desc CLIPPED
       #本位币顺序
       IF NOT cl_null(sr.xccc001) THEN
          SELECT gzcbl004 INTO sr.xccc001_desc FROM gzcbl_t WHERE  gzcbl001='8914' AND gzcbl002=sr.xccc001 AND gzcbl003=g_dlang  
          LET sr.xccc001_desc=sr.xccc001,".",sr.xccc001_desc CLIPPED
          
          SELECT glaa001,glaa016,glaa020 INTO l_glaa001,l_glaa016,l_glaa020
            FROM glaa_t
            WHERE glaaent = g_enterprise
            AND glaald  = sr.xcbsld
          CASE sr.xccc001
             WHEN '1'
                CALL s_desc_get_currency_desc(l_glaa001) RETURNING l_currency_desc
             WHEN '2'
                CALL s_desc_get_currency_desc(l_glaa016) RETURNING l_currency_desc
             WHEN '3'
                CALL s_desc_get_currency_desc(l_glaa020) RETURNING l_currency_desc
          END CASE
          IF NOT cl_null(l_currency_desc) THEN
             LET sr.xccc001_desc=sr.xccc001_desc,'(',l_currency_desc,')' CLIPPED
          END IF
       END IF
       LET l_xcbs002=sr.xcbs002 
       LET l_xcbs003=sr.xcbs003
       LET sr.mainkey=sr.xcbs001,'-',l_xcbs002,'-',l_xcbs003,'-',sr.xcbsld,'-',sr.xcbs004,'-',sr.xcbs005,'-',sr.xccc001  CLIPPED       
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.xcbs001,sr.xcbs001_desc,sr.xcbs002,sr.xcbs003,sr.xcbsld,sr.xcbsld_desc,sr.xcbs004,sr.xcbs004_desc,sr.xcbs005,sr.xcbs005_desc,sr.xccc001,sr.xccc001_desc,sr.xcbs006,sr.xcbs008,sr.xcbs008_desc,sr.xcbs009,sr.xcbs007,sr.xcbs007_desc,sr.xcbs202,sr.xcbs100,sr.xcbs101,sr.mainkey
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "axcq203_x01_execute"
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
 
{<section id="axcq203_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION axcq203_x01_rep_data()
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
 
{<section id="axcq203_x01.other_function" readonly="Y" >}

 
{</section>}
 
