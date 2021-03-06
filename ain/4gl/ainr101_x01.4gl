#該程式未解開Section, 採用最新樣板產出!
{<section id="ainr101_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:5(2016-06-16 15:11:20), PR版次:0005(2016-06-21 12:00:13)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000062
#+ Filename...: ainr101_x01
#+ Description: ...
#+ Creator....: 00593(2014-12-30 10:34:42)
#+ Modifier...: 07024 -SD/PR- 07024
 
{</section>}
 
{<section id="ainr101_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#160304-00007#1  16/03/04  By Sarah    基礎單位數量(inag033)顯示的值是錯的
#160512-00004#2  16/06/16  By dorislai 新增製造日期(inad014)
#160512-00004#1  16/06/20  By Whitney  inai012製造日期改抓inae010
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
       pr1 STRING,                  #pr1 
       pr2 STRING,                  #pr2 
       pr3 STRING,                  #pr3 
       pr4 STRING,                  #pr4 
       day STRING                   #day
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_day           LIKE type_t.num10
#end add-point
 
{</section>}
 
{<section id="ainr101_x01.main" readonly="Y" >}
PUBLIC FUNCTION ainr101_x01(p_arg1,p_arg2,p_arg3,p_arg4,p_arg5,p_arg6)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 STRING                  #tm.pr1  pr1 
DEFINE  p_arg3 STRING                  #tm.pr2  pr2 
DEFINE  p_arg4 STRING                  #tm.pr3  pr3 
DEFINE  p_arg5 STRING                  #tm.pr4  pr4 
DEFINE  p_arg6 STRING                  #tm.day  day
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"
 
#end add-point
 
   LET tm.wc = p_arg1
   LET tm.pr1 = p_arg2
   LET tm.pr2 = p_arg3
   LET tm.pr3 = p_arg4
   LET tm.pr4 = p_arg5
   LET tm.day = p_arg6
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   LET g_day = tm.day
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "ainr101_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL ainr101_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL ainr101_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL ainr101_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL ainr101_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL ainr101_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="ainr101_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION ainr101_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "imaa_t_imaa009.imaa_t.imaa009,rtaxl_t_rtaxl003.rtaxl_t.rtaxl003,inag001.inag_t.inag001,imaal_t_imaal003.imaal_t.imaal003,imaal_t_imaal004.imaal_t.imaal004,inag002.inag_t.inag002,inag003.inag_t.inag003,inag004.inag_t.inag004,inayl_t_inayl003.inayl_t.inayl003,inag005.inag_t.inag005,inab_t_inab003.inab_t.inab003,inag006.inag_t.inag006,inag007.inag_t.inag007,inag008.inag_t.inag008,inag024.inag_t.inag024,inag025.inag_t.inag025,inag010.inag_t.inag010,inag011.inag_t.inag011,inag012.inag_t.inag012,inad_t_inad014.inad_t.inad014,inad_t_inad011.inad_t.inad011,l_exceed_date.type_t.num10,inad_t_inad012.inad_t.inad012,inag019.inag_t.inag019,inag020.inag_t.inag020,oocql_t_oocql004.oocql_t.oocql004,l_inap013.type_t.num20_6,inag021.inag_t.inag021,inaf006.inaf_t.inaf006,l_short_qty.type_t.num20_6,inag028.inag_t.inag028,inag032.inag_t.inag032,inag033.inag_t.inag033,l_key.type_t.chr500" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   #子報表TEMP TABLE的欄位SQL   
   LET g_sql = "l_key1.type_t.chr500,inai007.inai_t.inai007,inai008.inai_t.inai008,inai012.inai_t.inai012,inai010.inai_t.inai010,inae011.inae_t.inae011,l_day.type_t.num10" 
   
   #建立TEMP TABLE,子報表序號1
   IF NOT cl_xg_create_tmptable(g_sql,2) THEN
      LET g_rep_success = 'N'            
   END IF
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="ainr101_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION ainr101_x01_ins_prep()
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
         #INSERT INTO PREP 子報表
         LET g_sql = " INSERT INTO ",g_rep_db CLIPPED,g_rep_tmpname[2] CLIPPED," VALUES(?,?,?,?,?,?,?)"
         PREPARE insert_prep1 FROM g_sql
         IF STATUS THEN
            LET l_prep_str ="insert_prep1",i
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_prep_str
            LET g_errparam.code   = status
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            CALL cl_xg_drop_tmptable()
            LET g_rep_success = 'N'           
         END IF
         #end add-point                  
 
 
      END CASE
   END FOR
END FUNCTION
 
{</section>}
 
{<section id="ainr101_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION ainr101_x01_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define(客製用) name="sel_prep.define_customerization"

#end add-point
#add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
DEFINE g_order       STRING
DEFINE l_day         LIKE type_t.dat  #160407-00027#1-dorislai-add
#end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   #160407-00027#1-dorislai-add-(S)
   IF NOT cl_null(g_day) THEN
      LET l_day = g_today - g_day
   END IF
   #160407-00027#1-dorislai-add-(E)
   #end add-point
 
   #add-point:sel_prep g_select name="sel_prep.g_select"
   #160407-00027#1-dorislai-add-(S)
   LET g_select = " SELECT imaa_t.imaa009,
                           (SELECT rtaxl003 FROM rtaxl_t WHERE rtaxl001 = imaa009 AND imaa001 = inag001 AND inagent = rtaxlent AND rtaxl002 = '",g_dlang,"') rtaxl003,
                           inag001,
                           (SELECT imaal003 FROM imaal_t WHERE imaal001 = inag001 AND inagent = imaalent AND imaal002 = '",g_dlang,"') imaal003,
                           (SELECT imaal004 FROM imaal_t WHERE imaal001 = inag001 AND inagent = imaalent AND imaal002 = '",g_dlang,"') imaal004,
                           inag002,inag003,inag004,
                           (SELECT inayl003 FROM inayl_t WHERE inayl001 = inag004 AND inaylent = inagent AND inayl002 = '",g_dlang,"') inayl003,    
                           inag005,
                           (SELECT inab003 FROM inab_t WHERE inab001 = inag004 AND inab002 = inag005 AND inagent = inabent AND inabsite = inagsite) inab003,
                           inag006,inag007,
                           inag008,inag024,inag025,inag010,inag011,inag012,inad_t.inad014,inad_t.inad011," #160512-00004#2-add-'inad_t.inad014'
   IF cl_null(g_day) THEN
      LET g_select = g_select CLIPPED,"NULL,"
   ELSE
      LET g_select = g_select CLIPPED,"CASE WHEN inad_t.inad011 IS NULL THEN NULL ELSE (to_date('",l_day,"','yyyy/mm/dd') - inad_t.inad011) END,"
   END IF
   LET g_select = g_select CLIPPED,"inad_t.inad012,inag019,inag020,
                                    (SELECT oocql004 FROM oocql_t WHERE oocql002 = inag020 AND inagent = oocqlent AND oocql001= '304' AND oocql003 = '",g_dlang,"') oocql004,
                                    (SELECT NVL(SUM(inap013),0) FROM inap_t
                                    WHERE inap004=inag001 AND inap005=inag002 AND inap006=inag003 AND inap007=inag004 
                                      AND inap008=inag005 AND inap009=inag006 AND inapent =  inagent AND inapsite = inagsite),
                                    inag021,inaf006,NVL(inaf006-inag008,0),inag028,inag032,inag033,
                                   (trim(inag001)||'-'||trim(inag002)||'-'||trim(inag003)||'-'||trim(inag004)||'-'||trim(inag005)||'-'||trim(inag006))" 
   #160407-00027#1-dorislai-add-(E)   
#   #end add-point
#   LET g_select = " SELECT imaa_t.imaa009,rtaxl_t.rtaxl003,inag001,imaal_t.imaal003,imaal_t.imaal004, 
#       inag002,inag003,inag004,inayl_t.inayl003,inag005,inab_t.inab003,inag006,inag007,inag008,inag024, 
#       inag025,inag010,inag011,inag012,inad_t.inad014,inad_t.inad011,NULL,inad_t.inad012,inag019,inag020, 
#       oocql_t.oocql004,NULL,inag021,inaf006,NULL,inag028,inag032,inag033,(trim(inag001)||'-'||trim(inag002)||'-'||trim(inag003)||'-'||trim(inag004)||'-'||trim(inag005)||'-'||trim(inag006))" 
#
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   #160407-00027#1-dorislai-mod-(S)  
#    LET g_from = " FROM inag_t",
#                 " LEFT JOIN inaf_t ON inaf_t.inaf003 = inag_t.inag001 AND inaf_t.inaf004 = inag_t.inag002 AND inaf_t.inaf001 = inag_t.inag004 AND inaf_t.inaf002 = inag_t.inag005 AND inaf_t.inafent = inag_t.inagent AND inaf_t.inafsite = inag_t.inagsite",
#                 " LEFT JOIN inayl_t ON inayl_t.inayl001 = inag_t.inag004 AND inayl_t.inaylent = inag_t.inagent AND inayl_t.inayl002 = '",g_dlang,"'",    
#                 " LEFT JOIN inab_t ON inab_t.inab001 = inag_t.inag004 AND inab_t.inab002 = inag_t.inag005 AND inag_t.inagent = inab_t.inabent AND inab_t.inabsite = inag_t.inagsite",
#                 " LEFT JOIN inad_t ON inad_t.inad001 = inag_t.inag001 AND inag_t.inagent = inad_t.inadent AND inad_t.inadsite = inag_t.inagsite AND inad_t.inad002 = inag_t.inag002 AND inad_t.inad003 = inag_t.inag006",
#                 " LEFT JOIN imaa_t ON imaa_t.imaa001 = inag_t.inag001 AND inag_t.inagent = imaa_t.imaaent",
#                 " LEFT JOIN ooefl_t ON ooefl_t.ooefl001 = inag_t.inagsite AND inag_t.inagent =ooefl_t.ooeflent AND ooefl_t.ooefl002 = '",g_dlang,"' AND ooefl_t.ooefl001 = inag_t.inagsite",
#                 " LEFT JOIN rtaxl_t ON rtaxl_t.rtaxl001 = imaa_t.imaa009 AND imaa_t.imaa001 = inag_t.inag001 AND inag_t.inagent = rtaxl_t.rtaxlent AND rtaxl002 = '",g_dlang,"'",
#                 " LEFT JOIN oocql_t ON oocql_t.oocql002 = inag_t.inag020 AND inag_t.inagent = oocql_t.oocqlent AND oocql_t.oocql001= '304' AND oocql_t.oocql003 = '",g_dlang,"'",
#                 " LEFT JOIN imaal_t ON imaal_t.imaal001 = inag_t.inag001 AND inag_t.inagent = imaal_t.imaalent AND imaal_t.imaal002 = '",g_dlang,"'"
   LET g_from = " FROM inag_t",
                " LEFT JOIN inaf_t ON inaf_t.inaf003 = inag_t.inag001 AND inaf_t.inaf004 = inag_t.inag002 AND inaf_t.inaf001 = inag_t.inag004 AND inaf_t.inaf002 = inag_t.inag005 AND inaf_t.inafent = inag_t.inagent AND inaf_t.inafsite = inag_t.inagsite",
                " LEFT JOIN inad_t ON inad_t.inad001 = inag_t.inag001 AND inag_t.inagent = inad_t.inadent AND inad_t.inadsite = inag_t.inagsite AND inad_t.inad002 = inag_t.inag002 AND inad_t.inad003 = inag_t.inag006",
                " LEFT JOIN imaa_t ON imaa_t.imaa001 = inag_t.inag001 AND inag_t.inagent = imaa_t.imaaent"
   #160407-00027#1-dorislai-mod-(E)    
#   #end add-point
#    LET g_from = " FROM inag_t,inaf_t,inab_t,inad_t,imaa_t,imaal_t,ooefl_t,oocql_t,rtaxl_t,inayl_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   IF tm.pr2 = 'Y' THEN
      LET tm.wc = tm.wc CLIPPED ," AND inag_t.inag008 <> 0 "
   END IF
   IF tm.pr3 = 'Y' THEN
      LET tm.wc = tm.wc CLIPPED ," AND inag_t.inag008 < inaf_t.inaf006 "
   END IF
   #160407-00027#1-dorislai-add-(S) 
   #=====tm.pr4的寫法概念是這個↓====
#   IF tm.pr4 = 'Y' AND (cl_null(sr.l_exceed_date) OR sr.l_exceed_date < 0) THEN
#      INITIALIZE sr.* TO NULL
#      CONTINUE FOREACH
#   END IF
   #=====tm.pr4的寫法概念是這個↑====
   IF tm.pr4 = 'Y' AND NOT cl_null(l_day) THEN
      LET tm.wc = tm.wc CLIPPED ," AND inad_t.inad011 IS NOT NULL AND (to_date('",l_day,"','yyyy/mm/dd') - inad_t.inad011) > 0"
    END IF                           
   #160407-00027#1-dorislai-add-(E) 
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   LET g_order = " ORDER BY inag001,inag002,inag003,(trim(inag004)||'.'||trim(inayl_t.inayl003)),(trim(inag005)||'.'||trim(inab_t.inab003)),inag006"
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("inag_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
 
   #end add-point
   PREPARE ainr101_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE ainr101_x01_curs CURSOR FOR ainr101_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="ainr101_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION ainr101_x01_ins_data()
DEFINE sr RECORD 
   imaa_t_imaa009 LIKE imaa_t.imaa009, 
   rtaxl_t_rtaxl003 LIKE rtaxl_t.rtaxl003, 
   inag001 LIKE inag_t.inag001, 
   imaal_t_imaal003 LIKE imaal_t.imaal003, 
   imaal_t_imaal004 LIKE imaal_t.imaal004, 
   inag002 LIKE inag_t.inag002, 
   inag003 LIKE inag_t.inag003, 
   inag004 LIKE inag_t.inag004, 
   inayl_t_inayl003 LIKE inayl_t.inayl003, 
   inag005 LIKE inag_t.inag005, 
   inab_t_inab003 LIKE inab_t.inab003, 
   inag006 LIKE inag_t.inag006, 
   inag007 LIKE inag_t.inag007, 
   inag008 LIKE inag_t.inag008, 
   inag024 LIKE inag_t.inag024, 
   inag025 LIKE inag_t.inag025, 
   inag010 LIKE inag_t.inag010, 
   inag011 LIKE inag_t.inag011, 
   inag012 LIKE inag_t.inag012, 
   inad_t_inad014 LIKE inad_t.inad014, 
   inad_t_inad011 LIKE inad_t.inad011, 
   l_exceed_date LIKE type_t.num10, 
   inad_t_inad012 LIKE inad_t.inad012, 
   inag019 LIKE inag_t.inag019, 
   inag020 LIKE inag_t.inag020, 
   oocql_t_oocql004 LIKE oocql_t.oocql004, 
   l_inap013 LIKE type_t.num20_6, 
   inag021 LIKE inag_t.inag021, 
   inaf006 LIKE inaf_t.inaf006, 
   l_short_qty LIKE type_t.num20_6, 
   inag028 LIKE inag_t.inag028, 
   inag032 LIKE inag_t.inag032, 
   inag033 LIKE inag_t.inag033, 
   l_key LIKE type_t.chr500
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE sr1 RECORD
   l_key1   LIKE type_t.chr500,
   inai007  LIKE inai_t.inai007,
   inai008  LIKE inai_t.inai008,
   inai012  LIKE inai_t.inai012,
   inai010  LIKE inai_t.inai010,
   inae011  LIKE inae_t.inae011,
   l_day    LIKE type_t.num10   
END RECORD
DEFINE l_sql     STRING
DEFINE l_success LIKE type_t.num5   #160304-00007#1 add
DEFINE l_day     LIKE type_t.dat    #160407-00027#1-dorislai-add
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"

    #160407-00027#1-dorislai-add-(S)
    IF NOT cl_null(g_day) THEN
       LET l_day = g_today - g_day
    END IF
    LET l_sql = "SELECT DISTINCT (trim(inai001)||'-'||trim(inai002)||'-'||trim(inai003)||'-'||trim(inai004)||'-'||trim(inai005)||'-'||trim(inai006)),",
                "                inai007,inai008,inae010,inai010,inae011,"  #160512-00004#1 by whitney modify inai012->inae010
    IF cl_null(g_day) THEN
       LET l_sql = l_sql CLIPPED,"NULL,"
    ELSE
       LET l_sql = l_sql CLIPPED,"CASE WHEN inae011 IS NULL THEN NULL ELSE (to_date('",l_day,"','yyyy/mm/dd') - inae011) END,"
    END IF
    LET l_sql = l_sql CLIPPED,"  FROM inai_t",
                              "  LEFT JOIN inae_t ON inai001 = inae001 AND inai002 = inae002 AND inai007 = inae003 AND inai008 = inae004 AND inaient = inaeent AND inaisite = inaesite ",            
                              " WHERE (trim(inai001)||'-'||trim(inai002)||'-'||trim(inai003)||'-'||trim(inai004)||'-'||trim(inai005)||'-'||trim(inai006)) = ?",
                              "   AND inaient = ",g_enterprise," AND inaisite = '",g_site,"'",
                              " ORDER BY inai007,inai008"
    PREPARE ainr140_x01_prepare1 FROM l_sql
    IF STATUS THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.extend = 'prepare:'
       LET g_errparam.code   = STATUS
       LET g_errparam.popup  = TRUE
       CALL cl_err()
       LET g_rep_success = 'N' 
    END IF
    DECLARE ainr140_x01_curs1 CURSOR FOR ainr140_x01_prepare1
    #160407-00027#1-dorislai-add-(E)
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH ainr101_x01_curs INTO sr.*                               
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
       #160407-00027#1-dorislai-mark-(S)
#       IF NOT cl_null(sr.inad_t_inad011) AND NOT cl_null(g_day) THEN
#          #過期天數 = (g_today - 有效期指定幾天前) - 有效日期
#          LET sr.l_exceed_date = (g_today - g_day) - sr.inad_t_inad011
#       END IF

#       #列印有效期過期預警之料件
#       IF tm.pr4 = 'Y' AND (cl_null(sr.l_exceed_date) OR sr.l_exceed_date < 0) THEN
#          INITIALIZE sr.* TO NULL
#          CONTINUE FOREACH
#       END IF
       #160407-00027#1-dorislai-mark-(E)
       #在揀量
       #160407-00027#1-dorislai-mark-(S)
#       SELECT SUM(inap013) INTO sr.l_inap013       
#         FROM inap_t
#        WHERE (trim(inap004)||'-'||trim(inap005)||'-'||trim(inap006)||'-'||trim(inap007)||'-'||trim(inap008)||'-'||trim(inap009))= sr.l_key
#          AND inapent =  g_enterprise
#          AND inapsite = g_site
       #160407-00027#1-dorislai-mark-(E)
       #160407-00027#1-dorislai-mark-(S)
#       IF cl_null(sr.l_inap013) THEN LET sr.l_inap013 = 0 END IF
       
#       #缺少量 = 安全庫存量 - 庫存量
#       LET sr.l_short_qty = sr.inaf006 - sr.inag008
       #160407-00027#1-dorislai-mark-(E)
       #160304-00007#1 add str
       #當庫存單位(inag007)=基礎單位(inag032)時,則基礎單位數量(inag033)=庫存數量(inag008)
       #單位不一樣時則用庫存數量來換算
       IF sr.inag007 = sr.inag032 THEN
          LET sr.inag033 = sr.inag008
       ELSE
          IF NOT cl_null (sr.inag032) AND NOT cl_null(sr.inag007) THEN #160407-00027#1-dorislai-add
             CALl s_aooi250_convert_qty(sr.inag001,sr.inag007,sr.inag032,sr.inag008)
                  RETURNING l_success,sr.inag033
          END IF #160407-00027#1-dorislai-add
       END IF
       #160304-00007#1 add end

       #列印製造批序號資料       
       IF tm.pr1 = 'Y' THEN
          #子報表
          #160407-00027#1-dorislai-mark-(S)
#          LET l_sql = "SELECT DISTINCT (trim(inai001)||'-'||trim(inai002)||'-'||trim(inai003)||'-'||trim(inai004)||'-'||trim(inai005)||'-'||trim(inai006)),",
#                      "       inai007,inai008,inai012,inai010,inae011,NULL",
#                      "  FROM inai_t",
#                      "  LEFT JOIN inae_t ON inai001 = inae001 AND inai002 = inae002 AND inai007 = inae003 AND inai008 = inae004 AND inaient = inaeent AND inaisite = inaesite ",            
#                      " WHERE (trim(inai001)||'-'||trim(inai002)||'-'||trim(inai003)||'-'||trim(inai004)||'-'||trim(inai005)||'-'||trim(inai006)) = '",sr.l_key,"'",
#                      "   AND inaient = ",g_enterprise," AND inaisite = '",g_site,"'",
#                      " ORDER BY inai007,inai008"
#          PREPARE ainr140_x01_prepare1 FROM l_sql
#          IF STATUS THEN
#             INITIALIZE g_errparam TO NULL
#             LET g_errparam.extend = 'prepare:'
#             LET g_errparam.code   = STATUS
#             LET g_errparam.popup  = TRUE
#             CALL cl_err()
#             LET g_rep_success = 'N' 
#          END IF
#          DECLARE ainr140_x01_curs1 CURSOR FOR ainr140_x01_prepare1
          #160407-00027#1-dorislai-mark-(E)
          #160407-00027#1-dorislai-mod-(S)
#          FOREACH ainr140_x01_curs1 INTO sr1.*
          FOREACH ainr140_x01_curs1 USING sr.l_key INTO sr1.*
          #160407-00027#1-dorislai-mod-(E)
             IF STATUS THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = 'ainr140_x01_curs1 foreach:'
                LET g_errparam.code   = STATUS
                LET g_errparam.popup  = TRUE
                CALL cl_err()
                LET g_rep_success = 'N'
                EXIT FOREACH
             END IF 

             #160407-00027#1-dorislai-mark-(S)
#             IF NOT cl_null(sr1.inae011) AND NOT cl_null(g_day) THEN
#                #過期天數 = (g_today - 有效期指定幾天前) - 有效日期
#                LET sr1.l_day = g_today - g_day - sr1.inae011
#             END IF    
             #160407-00027#1-dorislai-mark-(E)
             
             #子報表EXECUTE
             EXECUTE insert_prep1 USING
                sr1.l_key1,sr1.inai007,sr1.inai008,sr1.inai012,sr1.inai010,sr1.inae011,sr1.l_day
               
             IF SQLCA.sqlcode THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = "ainr140_x01_subrep01_execute"
                LET g_errparam.code   = SQLCA.sqlcode
                LET g_errparam.popup  = FALSE
                CALL cl_err()
                LET g_rep_success = 'N'
                EXIT FOREACH
             END IF
          END FOREACH
       END IF
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       #160407-00027#1-dorislai-mark-(S)
#       #若儲位與名稱都沒資料,應把.去掉
#       IF sr.l_inag005_inab003 = '.' THEN LET sr.l_inag005_inab003 = '' END IF
       #160407-00027#1-dorislai-mark-(E)
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.imaa_t_imaa009,sr.rtaxl_t_rtaxl003,sr.inag001,sr.imaal_t_imaal003,sr.imaal_t_imaal004,sr.inag002,sr.inag003,sr.inag004,sr.inayl_t_inayl003,sr.inag005,sr.inab_t_inab003,sr.inag006,sr.inag007,sr.inag008,sr.inag024,sr.inag025,sr.inag010,sr.inag011,sr.inag012,sr.inad_t_inad014,sr.inad_t_inad011,sr.l_exceed_date,sr.inad_t_inad012,sr.inag019,sr.inag020,sr.oocql_t_oocql004,sr.l_inap013,sr.inag021,sr.inaf006,sr.l_short_qty,sr.inag028,sr.inag032,sr.inag033,sr.l_key
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "ainr101_x01_execute"
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
 
{<section id="ainr101_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION ainr101_x01_rep_data()
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
 
{<section id="ainr101_x01.other_function" readonly="Y" >}

 
{</section>}
 
