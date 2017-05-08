#該程式未解開Section, 採用最新樣板產出!
{<section id="apsr820_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2016-07-13 11:06:06), PR版次:0003(2016-07-13 11:08:05)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000052
#+ Filename...: apsr820_x01
#+ Description: ...
#+ Creator....: 05384(2015-03-02 15:58:29)
#+ Modifier...: 07024 -SD/PR- 07024
 
{</section>}
 
{<section id="apsr820_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#160614-00029#4  2016/06/20  By ming     報表增加保稅欄位(psgb029)在需求日期前 
#160711-00013#4  2016/07/13  By dorislai 拿掉#160614-00029#4新增的保稅欄位(psgb029)，原因請看需求單敘述
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
       wc STRING,                  #where condition 
       a1 STRING,                  #行動日(開始 
       a2 STRING                   #行動日(截止
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="apsr820_x01.main" readonly="Y" >}
PUBLIC FUNCTION apsr820_x01(p_arg1,p_arg2,p_arg3)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 STRING                  #tm.a1  行動日(開始 
DEFINE  p_arg3 STRING                  #tm.a2  行動日(截止
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.a1 = p_arg2
   LET tm.a2 = p_arg3
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "apsr820_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL apsr820_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL apsr820_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL apsr820_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL apsr820_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL apsr820_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="apsr820_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION apsr820_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "l_ooefl004.ooefl_t.ooefl004,psgb002.psgb_t.psgb002,l_imaal003.imaal_t.imaal003,l_imaal004.imaal_t.imaal004,psgb003.psgb_t.psgb003,l_psgb003_desc.type_t.chr1000,psgb022.psgb_t.psgb022,l_imaa006.imaa_t.imaa006,psgb004.psgb_t.psgb004,l_psgb004_minus.psgb_t.psgb004,psgb028.psgb_t.psgb028" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="apsr820_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION apsr820_x01_ins_prep()
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
             ?,?,?,?,?)"
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
 
{<section id="apsr820_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apsr820_x01_sel_prep()
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
   #160711-00013#4-mod-(S)
#   #160614-00029#4 20160620 modify by ming -----(S) 
#   #LET g_select = " SELECT psgbsite,ooefl004,psgb002,imaal003,imaal004,psgb003,'',psgb022,imaa006,psgb004,'',psgb028,psgbent"
#   LET g_select = " SELECT psgbsite,ooefl004,psgb002,imaal003,imaal004,psgb003,'',psgb022,imaa006,psgb029,psgb004,'',psgb028,psgbent"
#   #160614-00029#4 20160620 modify by ming -----(E) 
   LET g_select = " SELECT psgbsite,ooefl004,psgb002,imaal003,imaal004,psgb003,'',psgb022,imaa006,psgb004,'',psgb028,psgbent"
   #160711-00013#4-mod-(E)
#   #end add-point
#   LET g_select = " SELECT psgbsite,'',psgb002,'','',psgb003,'',psgb022,'',psgb004,'',psgb028,psgbent" 
#
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
    LET g_from = " FROM psgb_t ",
                 "      LEFT OUTER JOIN imaal_t ON imaalent = psgbent AND imaal001 = psgb002 AND imaal002 = '",g_dlang,"' ",
                 "      LEFT OUTER JOIN ooefl_t ON ooeflent = psgbent AND ooefl001 = psgbsite AND ooefl002 = '",g_dlang,"' ",
                 "      LEFT OUTER JOIN imaa_t ON imaaent = psgbent AND imaa001 = psgb002 ",
                 "      LEFT OUTER JOIN imae_t ON imaeent = psgbent AND imae001 = psgb002 AND imaesite = psgbsite "
#   #end add-point
#    LET g_from = " FROM psgb_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE psgb_t.psgb022 > '0' AND " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("psgb_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE apsr820_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE apsr820_x01_curs CURSOR FOR apsr820_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="apsr820_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION apsr820_x01_ins_data()
DEFINE sr RECORD 
   psgbsite LIKE psgb_t.psgbsite, 
   l_ooefl004 LIKE ooefl_t.ooefl004, 
   psgb002 LIKE psgb_t.psgb002, 
   l_imaal003 LIKE imaal_t.imaal003, 
   l_imaal004 LIKE imaal_t.imaal004, 
   psgb003 LIKE psgb_t.psgb003, 
   l_psgb003_desc LIKE type_t.chr1000, 
   psgb022 LIKE psgb_t.psgb022, 
   l_imaa006 LIKE imaa_t.imaa006, 
   psgb004 LIKE psgb_t.psgb004, 
   l_psgb004_minus LIKE psgb_t.psgb004, 
   psgb028 LIKE psgb_t.psgb028, 
   psgbent LIKE psgb_t.psgbent
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_success   LIKE type_t.num5
DEFINE l_imaf171   LIKE imaf_t.imaf171
DEFINE l_imaf172   LIKE imaf_t.imaf172
DEFINE l_imaf173   LIKE imaf_t.imaf173
DEFINE l_imaf174   LIKE imaf_t.imaf174
DEFINE l_leadtime  LIKE type_t.num5
DEFINE l_ooef008   LIKE ooef_t.ooef008
DEFINE l_ooef009   LIKE ooef_t.ooef009
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH apsr820_x01_curs INTO sr.*                               
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
       CALL s_feature_description(sr.psgb002,sr.psgb003) RETURNING l_success,sr.l_psgb003_desc
       IF NOT l_success THEN
          LET sr.l_psgb003_desc = ''
       END IF
       LET l_leadtime = 0
       LET l_imaf171 = 0
       LET l_imaf172 = 0
       LET l_imaf173 = 0
       LET l_imaf174 = 0
       #取前置時間
       SELECT COALESCE(imaf171,0),COALESCE(imaf172,0),COALESCE(imaf173,0),COALESCE(imaf174,0) 
         INTO l_imaf171,l_imaf172,l_imaf173,l_imaf174
         FROM imaf_t
        WHERE imafent = sr.psgbent
          AND imafsite = sr.psgbsite
          AND imaf001 = sr.psgb002
       
       LET l_leadtime = l_imaf171 + l_imaf172 + l_imaf173 + l_imaf174
       LET l_leadtime = l_leadtime * -1
       #計算行動日期
       SELECT ooef008,ooef009 INTO l_ooef008,l_ooef009 
         FROM ooef_t 
        WHERE ooefent = g_enterprise 
          AND ooef001 = sr.psgbsite
       #呼叫元件計算行動日(忽略非工作日)
       CALL s_date_get_work_date(sr.psgbsite,l_ooef008,l_ooef009,sr.psgb004,0,l_leadtime) RETURNING sr.l_psgb004_minus
       
       #行動日區間
       IF NOT cl_null(tm.a1) AND NOT cl_null(tm.a2) THEN
          IF sr.l_psgb004_minus < tm.a1 OR sr.l_psgb004_minus > tm.a2 THEN
             CONTINUE FOREACH
          END IF
       ELSE
          IF NOT cl_null(tm.a1) THEN
             IF sr.l_psgb004_minus < tm.a1 THEN
                CONTINUE FOREACH
             END IF
          END IF
          
          IF NOT cl_null(tm.a2) THEN
             IF sr.l_psgb004_minus > tm.a2 THEN
                CONTINUE FOREACH
             END IF
          END IF
       END IF
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.l_ooefl004,sr.psgb002,sr.l_imaal003,sr.l_imaal004,sr.psgb003,sr.l_psgb003_desc,sr.psgb022,sr.l_imaa006,sr.psgb004,sr.l_psgb004_minus,sr.psgb028
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "apsr820_x01_execute"
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
 
{<section id="apsr820_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION apsr820_x01_rep_data()
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
 
{<section id="apsr820_x01.other_function" readonly="Y" >}

 
{</section>}
 