#該程式未解開Section, 採用最新樣板產出!
{<section id="axcq220_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2015-04-02 14:44:32), PR版次:0001(2015-03-26 09:55:46)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000045
#+ Filename...: axcq220_x01
#+ Description: ...
#+ Creator....: 05426(2015-03-18 09:33:33)
#+ Modifier...: 05426 -SD/PR- 05426
 
{</section>}
 
{<section id="axcq220_x01.global" readonly="Y" >}
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
       tmp STRING                   #暫存檔
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
 
{<section id="axcq220_x01.main" readonly="Y" >}
PUBLIC FUNCTION axcq220_x01(p_arg1,p_arg2)
DEFINE  p_arg1 STRING                  #tm.wc  QBE 
DEFINE  p_arg2 STRING                  #tm.tmp  暫存檔
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
   LET g_rep_code = "axcq220_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL axcq220_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL axcq220_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL axcq220_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL axcq220_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL axcq220_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="axcq220_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION axcq220_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "xccacomp.xcca_t.xccacomp,xccacomp_desc.type_t.chr1000,xccald.xcca_t.xccald,xccald_desc.type_t.chr100,xcca004.xcca_t.xcca004,xcca005.xcca_t.xcca005,xcca001.xcca_t.xcca001,xcca001_desc.type_t.chr100,xcca003.xcca_t.xcca003,xcca003_desc.type_t.chr100,xcca002.xcca_t.xcca002,xcca002_desc.type_t.chr100,xcca006.xcca_t.xcca006,imaal003.imaal_t.imaal003,imaal004.imaal_t.imaal004,imaa006.imaa_t.imaa006,imaa006_desc.type_t.chr100,xcca007.xcca_t.xcca007,xcca101.xcca_t.xcca101,xcbz901.xcbz_t.xcbz901,lbl_diff.xcca_t.xcca101,xccaent.xcca_t.xccaent,mainkey.type_t.chr1000" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="axcq220_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION axcq220_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="axcq220_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axcq220_x01_sel_prep()
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
   LET g_select = " SELECT xccacomp,NULL,xccald,NULL,xcca004,xcca005,xcca001,NULL,xcca003,NULL,xcca002, 
       NULL,xcca006,NULL,NULL,NULL,NULL,xcca007,xcca101,NULL,NULL,xccaent,NULL"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_select = " SELECT xccacomp,NULL,xccald,NULL,xcca004,xcca005,xcca001,NULL,xcca003,NULL,xcca002,NULL, 
       xcca006,NULL,NULL,NULL,NULL,xcca007,xcca101,xcbz901,diff,xccaent,NULL"
   #end add-point
    LET g_from = " FROM xcca_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET g_from = " FROM ",tm.tmp
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("xcca_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE axcq220_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE axcq220_x01_curs CURSOR FOR axcq220_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="axcq220_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION axcq220_x01_ins_data()
DEFINE sr RECORD 
   xccacomp LIKE xcca_t.xccacomp, 
   xccacomp_desc LIKE type_t.chr1000, 
   xccald LIKE xcca_t.xccald, 
   xccald_desc LIKE type_t.chr100, 
   xcca004 LIKE xcca_t.xcca004, 
   xcca005 LIKE xcca_t.xcca005, 
   xcca001 LIKE xcca_t.xcca001, 
   xcca001_desc LIKE type_t.chr100, 
   xcca003 LIKE xcca_t.xcca003, 
   xcca003_desc LIKE type_t.chr100, 
   xcca002 LIKE xcca_t.xcca002, 
   xcca002_desc LIKE type_t.chr100, 
   xcca006 LIKE xcca_t.xcca006, 
   imaal003 LIKE imaal_t.imaal003, 
   imaal004 LIKE imaal_t.imaal004, 
   imaa006 LIKE imaa_t.imaa006, 
   imaa006_desc LIKE type_t.chr100, 
   xcca007 LIKE xcca_t.xcca007, 
   xcca101 LIKE xcca_t.xcca101, 
   xcbz901 LIKE xcbz_t.xcbz901, 
   lbl_diff LIKE xcca_t.xcca101, 
   xccaent LIKE xcca_t.xccaent, 
   mainkey LIKE type_t.chr1000
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_glaa001        LIKE glaa_t.glaa001  #使用币别
DEFINE l_glaa016        LIKE glaa_t.glaa016  #本位幣二
DEFINE l_glaa020        LIKE glaa_t.glaa020  #本位幣三
DEFINE l_currency_desc  LIKE type_t.chr100
DEFINE l_xcca004        LIKE type_t.chr4
DEFINE l_xcca005        LIKE type_t.chr2
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH axcq220_x01_curs INTO sr.*                               
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
       #法人组织说明
       SELECT ooefl003 INTO sr.xccacomp_desc FROM ooefl_t WHERE ooeflent=g_enterprise AND ooefl001=sr.xccacomp AND ooefl002=g_dlang
       IF NOT cl_null(sr.xccacomp_desc) THEN
         LET sr.xccacomp_desc=sr.xccacomp,'(',sr.xccacomp_desc,')' CLIPPED
       ELSE
         LET sr.xccacomp_desc=sr.xccacomp
       END IF
       #帐套说明
       SELECT glaal002 INTO sr.xccald_desc FROM glaal_t WHERE glaalent=g_enterprise AND glaalld=sr.xccald AND glaal001=g_dlang
       IF NOT cl_null(sr.xccald_desc) THEN
         LET sr.xccald_desc=sr.xccald,'(',sr.xccald_desc,')' CLIPPED
       ELSE
         LET sr.xccald_desc=sr.xccald
       END IF
       #成本计算类型说明
       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = sr.xcca003
       CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET sr.xcca003_desc = '', g_rtn_fields[1] , ''
       IF NOT cl_null(sr.xcca003_desc) THEN
          LET sr.xcca003_desc=sr.xcca003,'(',sr.xcca003_desc,')' CLIPPED
       ELSE 
          LET sr.xcca003_desc=sr.xcca003
       END IF
       #本位币顺序说明
       IF NOT cl_null(sr.xcca001) THEN
          SELECT gzcbl004 INTO sr.xcca001_desc FROM gzcbl_t WHERE  gzcbl001='8914' AND gzcbl002=sr.xcca001 AND gzcbl003=g_dlang  
          LET sr.xcca001_desc=sr.xcca001,".",sr.xcca001_desc CLIPPED
          
          SELECT glaa001,glaa016,glaa020 INTO l_glaa001,l_glaa016,l_glaa020
            FROM glaa_t
            WHERE glaaent = g_enterprise
            AND glaald  = sr.xccald
          CASE sr.xcca001
             WHEN '1'
                CALL s_desc_get_currency_desc(l_glaa001) RETURNING l_currency_desc
             WHEN '2'
                CALL s_desc_get_currency_desc(l_glaa016) RETURNING l_currency_desc
             WHEN '3'
                CALL s_desc_get_currency_desc(l_glaa020) RETURNING l_currency_desc
          END CASE
          IF NOT cl_null(l_currency_desc) THEN
             LET sr.xcca001_desc=sr.xcca001_desc,'(',l_currency_desc,')' CLIPPED
          END IF
       END IF
       #成本域说明
       SELECT xcbfl003 INTO sr.xcca002_desc FROM xcbfl_t WHERE xcbflent= g_enterprise AND xcbflcomp=sr.xccacomp AND xcbfl001=sr.xcca002 AND xcbfl002=g_dlang  
       #品名、规格、基础单位带值
       SELECT imaal003,imaal004,imaa006 INTO sr.imaal003,sr.imaal004,sr.imaa006 
         FROM imaa_t LEFT JOIN imaal_t ON imaaent=imaalent AND imaa001=imaal001
         WHERE imaa001=sr.xcca006 AND imaal002=g_dlang AND imaaent=g_enterprise
         
       #基础单位说明
       CALL s_desc_get_unit_desc(sr.imaa006) RETURNING sr.imaa006_desc
       LET l_xcca004=sr.xcca004
       LET l_xcca005=sr.xcca005
       LET sr.mainkey=sr.xccacomp,'-',sr.xccald,'-',l_xcca004,'-',l_xcca005,'-',sr.xcca003,'-',sr.xcca001  CLIPPED
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.xccacomp,sr.xccacomp_desc,sr.xccald,sr.xccald_desc,sr.xcca004,sr.xcca005,sr.xcca001,sr.xcca001_desc,sr.xcca003,sr.xcca003_desc,sr.xcca002,sr.xcca002_desc,sr.xcca006,sr.imaal003,sr.imaal004,sr.imaa006,sr.imaa006_desc,sr.xcca007,sr.xcca101,sr.xcbz901,sr.lbl_diff,sr.xccaent,sr.mainkey
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "axcq220_x01_execute"
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
 
{<section id="axcq220_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION axcq220_x01_rep_data()
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
 
{<section id="axcq220_x01.other_function" readonly="Y" >}

 
{</section>}
 
