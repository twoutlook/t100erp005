#該程式未解開Section, 採用最新樣板產出!
{<section id="ainr001_x03.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2016-06-16 13:50:15), PR版次:0003(2016-06-16 13:53:30)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000053
#+ Filename...: ainr001_x03
#+ Description: ...
#+ Creator....: 05423(2015-03-02 11:20:37)
#+ Modifier...: 07024 -SD/PR- 07024
 
{</section>}
 
{<section id="ainr001_x03.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#160510-00019#6   2016-5-23  By zhujing    效能优化
#160512-00004#2   2016-6-16  By dorislai   新增製造日期(inad014)
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
       date LIKE type_t.num5,         #invaliddate 
       stype STRING                   #storetype
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="ainr001_x03.main" readonly="Y" >}
PUBLIC FUNCTION ainr001_x03(p_arg1,p_arg2,p_arg3)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.num5         #tm.date  invaliddate 
DEFINE  p_arg3 STRING                  #tm.stype  storetype
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.date = p_arg2
   LET tm.stype = p_arg3
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "ainr001_x03"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL ainr001_x03_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL ainr001_x03_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL ainr001_x03_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL ainr001_x03_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL ainr001_x03_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="ainr001_x03.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION ainr001_x03_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "inad001.inad_t.inad001,l_imaal003.imaal_t.imaal003,l_imaal004.imaal_t.imaal004,inad002.inad_t.inad002,l_inad002_desc.oocql_t.oocql004,l_imaf052.imaf_t.imaf052,l_imaf052_desc.ooag_t.ooag011,inad003.inad_t.inad003,inae003.inae_t.inae003,inae004.inae_t.inae004,inad014.inad_t.inad014,inae011.inae_t.inae011,l_invaliddate.type_t.num5,l_inai004_inayl003.inayl_t.inayl003,l_inai005_inab003.inab_t.inab003,l_inai003.inai_t.inai003,l_inai010.inai_t.inai010" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="ainr001_x03.ins_prep" readonly="Y" >}
PRIVATE FUNCTION ainr001_x03_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="ainr001_x03.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION ainr001_x03_sel_prep()
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
   #160510-00019#6 marked-S
#   LET g_select = " SELECT DISTINCT inad001,imaal003,imaal004,inad002,NULL,imaf052,trim(imaf052)||'.'||trim(ooag011),inad003,NULL,NULL,inad011, 
#       NULL,(trim(inag004)||'.'||trim(inayl003)),(trim(inag005)||'.'||trim(inab003)),inag003,inag008"
   #160510-00019#6 marked-E
   #160510-00019#6 add-S
   LET g_select = " SELECT DISTINCT inad001,",
                  " (SELECT imaal003 FROM imaal_t WHERE imaal001 = inad001 AND imaalent = inadent AND imaal002 = '",g_dlang,"') t1_imaal003,",
                  " (SELECT imaal004 FROM imaal_t WHERE imaal001 = inad001 AND imaalent = inadent AND imaal002 = '",g_dlang,"') t1_imaal004,",
                  " inad002,",
                  " (SELECT inaml004 FROM inaml_t WHERE inamlent = inadent AND inaml001 = inad001 AND inaml002 = inad002 AND inaml003='",g_dlang,"') t2_inaml004,",#不显示，产品特征
                  " imaf052,",
                  " (SELECT trim(ooag001)||'.'||trim(ooag011) FROM ooag_t WHERE ooag001 = imaf052 AND ooagent = imafent) t3_ooag011,", 
                  " inad003,NULL,NULL,inad014,inad011,NULL,", #160512-00004#2-add-'inad014'
                  " (SELECT trim(inayl001)||'.'||trim(inayl003) FROM inayl_t WHERE inayl001 = inag004 AND inaylent = inagent AND inayl002= '",g_dlang,"') t4_inayl003,",
                  " (SELECT trim(inab002)||'.'||trim(inab003) FROM inab_t WHERE inab001 = inag004 AND inab002 = inag005 AND inabent = inagent AND inabsite = inagsite) t5_inab003,",
                  " inag003,inag008 "
   #160510-00019#6 add-E
   
#   #end add-point
#   LET g_select = " SELECT inad001,NULL,NULL,inad002,NULL,NULL,NULL,inad003,inae003,inae004,inad014, 
#       inae011,NULL,NULL,NULL,NULL,NULL"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_from = " FROM inad_t ",#LEFT OUTER JOIN imaal_t ON imaal001 = inad001 AND imaalent = inadent AND imaal002 = '",g_dlang,"'",#160510-00019#6 marked
              "               LEFT OUTER JOIN imaf_t ON imaf001 = inad001 AND imafsite = inadsite AND imafent = inadent",
#              "               LEFT OUTER JOIN ooag_t ON ooag001 = imaf052 AND ooagent = inadent ",#160510-00019#6 marked
#              "               LEFT OUTER JOIN inae_t ON inae001 = inad001 AND inae002 = inad002 AND inaeent = inadent AND inaesite = inadsite",
              "               LEFT OUTER JOIN inag_t ON inagent = '",g_enterprise,"'  AND inag001 = inad001 AND inag002 = inad002 AND inag006 = inad003  ",
#              "               LEFT OUTER JOIN inayl_t ON inag004 = inayl_t.inayl001 AND inayl002 = '",g_dlang,"' AND inaylent = inagent ",#160510-00019#6 marked
#              "               LEFT OUTER JOIN inab_t ON inag005 = inab_t.inab002 AND inabent = inagent AND inabsite = inagsite AND inab001 = inag004 ",#160510-00019#6 marked
              "               LEFT OUTER JOIN imaa_t ON imaa001 = inad001 AND imaaent = inadent"
#   #end add-point
#    LET g_from = " FROM inad_t,inae_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET g_where = " WHERE inadent = '",g_enterprise CLIPPED,"' AND inadsite = '",g_site CLIPPED,"' AND " ,tm.wc CLIPPED
   #inag008>0
#   #end add-point
#    LET g_where = " WHERE inad_t.inad001 <> '0' AND " ,tm.wc CLIPPED
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("inad_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE ainr001_x03_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE ainr001_x03_curs CURSOR FOR ainr001_x03_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="ainr001_x03.ins_data" readonly="Y" >}
PRIVATE FUNCTION ainr001_x03_ins_data()
DEFINE sr RECORD 
   inad001 LIKE inad_t.inad001, 
   l_imaal003 LIKE imaal_t.imaal003, 
   l_imaal004 LIKE imaal_t.imaal004, 
   inad002 LIKE inad_t.inad002, 
   l_inad002_desc LIKE oocql_t.oocql004, 
   l_imaf052 LIKE imaf_t.imaf052, 
   l_imaf052_desc LIKE ooag_t.ooag011, 
   inad003 LIKE inad_t.inad003, 
   inae003 LIKE inae_t.inae003, 
   inae004 LIKE inae_t.inae004, 
   inad014 LIKE inad_t.inad014, 
   inae011 LIKE inae_t.inae011, 
   l_invaliddate LIKE type_t.num5, 
   l_inai004_inayl003 LIKE inayl_t.inayl003, 
   l_inai005_inab003 LIKE inab_t.inab003, 
   l_inai003 LIKE inai_t.inai003, 
   l_inai010 LIKE inai_t.inai010
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
#DEFINE  l_success             LIKE type_t.num5 #160510-00019#6 marked
DEFINE l_inad011 LIKE inad_t.inad011
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH ainr001_x03_curs INTO sr.*                               
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
       IF sr.l_imaf052_desc = '.' THEN
          LET sr.l_imaf052_desc = NULL
       END IF
       #160510-00019#6 marked-S
#       IF NOT cl_null(sr.inad001) THEN
#          CALL s_feature_description(sr.inad001,sr.inad002)
#          RETURNING l_success,sr.l_inad002_desc
#       END IF
       #160510-00019#6 marked-E
       IF sr.l_inai004_inayl003 = '.' THEN
          LET sr.l_inai004_inayl003 = NULL
       END IF
       IF sr.l_inai005_inab003 = '.' THEN
          LET sr.l_inai005_inab003 = NULL
       END IF
       IF cl_null(tm.date) THEN
          LET sr.l_invaliddate = NULL
       ELSE
          LET l_inad011 = sr.inae011
          LET sr.l_invaliddate = tm.date - l_inad011
       END IF
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.inad001,sr.l_imaal003,sr.l_imaal004,sr.inad002,sr.l_inad002_desc,sr.l_imaf052,sr.l_imaf052_desc,sr.inad003,sr.inae003,sr.inae004,sr.inad014,sr.inae011,sr.l_invaliddate,sr.l_inai004_inayl003,sr.l_inai005_inab003,sr.l_inai003,sr.l_inai010
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "ainr001_x03_execute"
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
 
{<section id="ainr001_x03.rep_data" readonly="Y" >}
PRIVATE FUNCTION ainr001_x03_rep_data()
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
 
{<section id="ainr001_x03.other_function" readonly="Y" >}

 
{</section>}
 
