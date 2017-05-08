#該程式未解開Section, 採用最新樣板產出!
{<section id="axmr432_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2015-11-19 15:56:09), PR版次:0002(2015-11-23 20:19:01)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000039
#+ Filename...: axmr432_x01
#+ Description: ...
#+ Creator....: 05384(2015-07-22 15:47:28)
#+ Modifier...: 06815 -SD/PR- 06815
 
{</section>}
 
{<section id="axmr432_x01.global" readonly="Y" >}
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
       wc STRING,                  #where condition 
       wc2 STRING                   #where condition2
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="axmr432_x01.main" readonly="Y" >}
PUBLIC FUNCTION axmr432_x01(p_arg1,p_arg2)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 STRING                  #tm.wc2  where condition2
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.wc2 = p_arg2
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "axmr432_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL axmr432_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL axmr432_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL axmr432_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL axmr432_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL axmr432_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="axmr432_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION axmr432_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "xmfjdocno.xmfj_t.xmfjdocno,xmflseq.xmfl_t.xmflseq,l_xmdk003.xmdk_t.xmdk003,l_xmdk003_desc.ooag_t.ooag011,l_xmdk004.xmdk_t.xmdk004,l_xmdk004_desc.ooefl_t.ooefl003,xmfj003.xmfj_t.xmfj003,l_xmfj003_desc.pmaal_t.pmaal004,l_xmdkdocno.xmdk_t.xmdkdocno,l_xmdlseq.xmdl_t.xmdlseq,l_xmda004.xmda_t.xmda004,l_xmda004_desc.pmaal_t.pmaal004,l_xmda034.xmda_t.xmda034,l_xmda034_desc.pmaal_t.pmaal004,l_xmdk001.xmdk_t.xmdk001,l_imaa009.imaa_t.imaa009,l_imaa009_desc.rtaxl_t.rtaxl003,l_imaf111.imaf_t.imaf111,l_imaf111_desc.oocql_t.oocql004,l_imaa127.imaa_t.imaa127,l_imaa127_desc.oocql_t.oocql004,l_imaa127desc.type_t.chr80,l_xmdl008.xmdl_t.xmdl008,l_xmdl008_desc.imaal_t.imaal003,l_xmdl008_desc2.imaal_t.imaal004,l_xmdl009.xmdl_t.xmdl009,l_xmdl009_desc.type_t.chr1000,l_xmdl022.xmdl_t.xmdl022,l_xmdl021.xmdl_t.xmdl021,l_xmdl024.xmdl_t.xmdl024,l_xmdl027.xmdl_t.xmdl027,l_xmdl028.xmdl_t.xmdl028,l_xmdl029.xmdl_t.xmdl029" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="axmr432_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION axmr432_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="axmr432_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axmr432_x01_sel_prep()
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
   #151113-00022#11 20151123 s983961--ADD(S)
   LET g_select = " SELECT xmfjent,xmfjsite,xmfjstus,xmfl002,xmfjdocno,xmflseq,'','','','',xmfj003,pmaal004,  
       '','','','','','','','','','','','','','','','','','','','','','','','','',xmfj004,xmfj005,xmfj006, 
       xmfj008,xmfj009,xmfj010,xmfj011,xmfj012,xmfj013,xmfj014,xmfj015,xmfj016,xmfj017,xmfl001"
   #151113-00022#11 20151123 s983961--ADD(E)    
#   #end add-point
#   LET g_select = " SELECT xmfjent,xmfjsite,xmfjstus,xmfl002,xmfjdocno,xmflseq,'','','','',xmfj003,'', 
#       '','','','','','','','','','','','','','','','','','','','','','','','','',xmfj004,xmfj005,xmfj006, 
#       xmfj008,xmfj009,xmfj010,xmfj011,xmfj012,xmfj013,xmfj014,xmfj015,xmfj016,xmfj017,xmfl001"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_from = " FROM xmfj_t LEFT OUTER JOIN ( SELECT xmfl_t.* FROM xmfl_t ",
                "                             ) x ON xmfj_t.xmfjent = x.xmflent AND xmfj_t.xmfjdocno = x.xmfldocno",
                "             LEFT OUTER JOIN pmaal_t ON pmaalent = xmfjent AND pmaal001 = xmfj003 AND pmaal002 = '",g_dlang,"' " #151113-00022#11 20151123 s983961--ADD
#   LET g_from = " FROM xmfj_t LEFT OUTER JOIN ( SELECT xmfl_t.*,imaa009,imaa127,imaf111 FROM xmfl_t ",
#                "                               LEFT OUTER JOIN imaa_t ON imaa_t.imaa001 = xmfl_t.xmfl002 AND imaa_t.imaaent = xmfl_t.xmflent" ,
#                "                               LEFT OUTER JOIN imaf_t ON imaf_t.imaf001 = xmfl_t.xmfl002 AND imaf_t.imafent = xmfl_t.xmflent ) x ON xmfj_t.xmfjent = x.xmflent AND xmfj_t.xmfjdocno = x.xmfldocno"
#   #end add-point
#    LET g_from = " FROM xmfj_t,xmfl_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("xmfj_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   DISPLAY "g_SQL ::",g_sql
   #end add-point
   PREPARE axmr432_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE axmr432_x01_curs CURSOR FOR axmr432_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="axmr432_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION axmr432_x01_ins_data()
DEFINE sr RECORD 
   xmfjent LIKE xmfj_t.xmfjent, 
   xmfjsite LIKE xmfj_t.xmfjsite, 
   xmfjstus LIKE xmfj_t.xmfjstus, 
   xmfl002 LIKE xmfl_t.xmfl002, 
   xmfjdocno LIKE xmfj_t.xmfjdocno, 
   xmflseq LIKE xmfl_t.xmflseq, 
   l_xmdk003 LIKE xmdk_t.xmdk003, 
   l_xmdk003_desc LIKE ooag_t.ooag011, 
   l_xmdk004 LIKE xmdk_t.xmdk004, 
   l_xmdk004_desc LIKE ooefl_t.ooefl003, 
   xmfj003 LIKE xmfj_t.xmfj003, 
   l_xmfj003_desc LIKE pmaal_t.pmaal004, 
   l_xmdkdocno LIKE xmdk_t.xmdkdocno, 
   l_xmdlseq LIKE xmdl_t.xmdlseq, 
   l_xmda004 LIKE xmda_t.xmda004, 
   l_xmda004_desc LIKE pmaal_t.pmaal004, 
   l_xmda034 LIKE xmda_t.xmda034, 
   l_xmda034_desc LIKE pmaal_t.pmaal004, 
   l_xmdk001 LIKE xmdk_t.xmdk001, 
   l_imaa009 LIKE imaa_t.imaa009, 
   l_imaa009_desc LIKE rtaxl_t.rtaxl003, 
   l_imaf111 LIKE imaf_t.imaf111, 
   l_imaf111_desc LIKE oocql_t.oocql004, 
   l_imaa127 LIKE imaa_t.imaa127, 
   l_imaa127_desc LIKE oocql_t.oocql004, 
   l_imaa127desc LIKE type_t.chr80, 
   l_xmdl008 LIKE xmdl_t.xmdl008, 
   l_xmdl008_desc LIKE imaal_t.imaal003, 
   l_xmdl008_desc2 LIKE imaal_t.imaal004, 
   l_xmdl009 LIKE xmdl_t.xmdl009, 
   l_xmdl009_desc LIKE type_t.chr1000, 
   l_xmdl022 LIKE xmdl_t.xmdl022, 
   l_xmdl021 LIKE xmdl_t.xmdl021, 
   l_xmdl024 LIKE xmdl_t.xmdl024, 
   l_xmdl027 LIKE xmdl_t.xmdl027, 
   l_xmdl028 LIKE xmdl_t.xmdl028, 
   l_xmdl029 LIKE xmdl_t.xmdl029, 
   xmfj004 LIKE xmfj_t.xmfj004, 
   xmfj005 LIKE xmfj_t.xmfj005, 
   xmfj006 LIKE xmfj_t.xmfj006, 
   xmfj008 LIKE xmfj_t.xmfj008, 
   xmfj009 LIKE xmfj_t.xmfj009, 
   xmfj010 LIKE xmfj_t.xmfj010, 
   xmfj011 LIKE xmfj_t.xmfj011, 
   xmfj012 LIKE xmfj_t.xmfj012, 
   xmfj013 LIKE xmfj_t.xmfj013, 
   xmfj014 LIKE xmfj_t.xmfj014, 
   xmfj015 LIKE xmfj_t.xmfj015, 
   xmfj016 LIKE xmfj_t.xmfj016, 
   xmfj017 LIKE xmfj_t.xmfj017, 
   xmfl001 LIKE xmfl_t.xmfl001
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_sql      STRING
DEFINE l_where    STRING
DEFINE l_success  LIKE type_t.num5
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
 
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH axmr432_x01_curs INTO sr.*                               
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
       LET l_where = ''
       IF cl_null(sr.xmfj012) THEN
         LET l_where = " xmdk001 >= '",sr.xmfj011,"' "
       ELSE
         LET l_where = " xmdk001 >= '",sr.xmfj011,"' AND xmdk001 <= '",sr.xmfj012,"' "
       END IF
       IF sr.xmfj013 = 'Y' THEN
         LET l_where = l_where CLIPPED ," AND xmdk016 = '",sr.xmfj004,"' "
       END IF
       
       IF sr.xmfj014 = 'Y' THEN
         LET l_where = l_where CLIPPED ," AND xmdk012 = '",sr.xmfj005,"' "
       END IF
       
       IF sr.xmfj015 = 'Y' THEN
         LET l_where = l_where CLIPPED ," AND xmdk010 = '",sr.xmfj008,"' "
       END IF
       
       IF sr.xmfj016 = 'Y' THEN
         LET l_where = l_where CLIPPED ," AND xmdk011 = '",sr.xmfj009,"' "
       END IF
       
       IF sr.xmfj017 = 'Y' THEN
         LET l_where = l_where CLIPPED ," AND xmdk030 = '",sr.xmfj010,"' "
       END IF
       CASE sr.xmfl001
          WHEN '1'
             IF NOT cl_null(sr.xmfl002) THEN
                LET l_where = l_where CLIPPED ," AND xmdl008 = '",sr.xmfl002,"' "
             END IF
          WHEN '2'
             IF NOT cl_null(sr.xmfl002) THEN
                LET l_where = l_where CLIPPED ," AND imaa009 = '",sr.xmfl002,"' "
             END IF
          WHEN '3'
             IF NOT cl_null(sr.xmfl002) THEN
                LET l_where = l_where CLIPPED ," AND imaa127 = '",sr.xmfl002,"' "
             END IF
       END CASE
       IF cl_null(l_where) THEN
          LET l_where = ' 1=1 '
       END IF
       #151113-00022#11 20151123 s983961--MOD(S)
       #LET l_sql = " SELECT xmdkdocno,xmdk001,xmdk003,xmdk004,xmdlseq,xmdl008, ",
       #            "        xmdl009,xmdl021,xmdl022,xmdl024,xmdl027,xmdl028,xmdl029, ",
       #            "        imaa009,imaa127,imaf111,xmda004,xmda034",
       #            "   FROM xmdk_t,xmdl_t LEFT OUTER JOIN xmda_t ON xmda_t.xmdaent = xmdl_t.xmdlent AND xmdadocno = xmdl_t.xmdl003 ",
       #            "                      LEFT OUTER JOIN imaa_t ON imaa_t.imaaent = xmdl_t.xmdlent AND imaa_t.imaa001 = xmdl_t.xmdl008 ",
       #            "                      LEFT OUTER JOIN imaf_t ON imaf_t.imafent = xmdl_t.xmdlent AND imaf_t.imafsite = xmdl_t.xmdlsite AND imaf_t.imaf001 = xmdl_t.xmdl008 ",
       #            "  WHERE xmdkent = xmdlent ",
       #            "    AND xmdkdocno = xmdldocno ",
       #            "    AND xmdkstus = 'S' ",
       #            "    AND xmdk000 IN ('1','2','6') ",
       #            "    AND xmdkdocno NOT IN (SELECT DISTINCT xmde003 ",
       #            "                            FROM xmde_t ",
       #            "                           WHERE xmdeent = ",g_enterprise,
       #            "                             AND xmdesite = '",g_site,"')",
       #            "    AND xmdk007 = '",sr.xmfj003,"' ",
       #            "    AND ",tm.wc2,
       #            "    AND ",l_where
       LET l_sql = " SELECT xmdkdocno,xmdk001,xmdk003,xmdk004,xmdlseq,xmdl008, ",
                   "        xmdl009,xmdl021,xmdl022,xmdl024,xmdl027,xmdl028,xmdl029, ",
                   "        imaa009,imaa127,imaf111,xmda004,xmda034, ",
                   "        ooag011,ooefl003,a1.pmaal004,a2.pmaal004,rtaxl003,a3.oocql004,a4.oocql004, ",
                   "        trim(imaa127)||'.'||trim(a4.oocql004),imaal003,imaal004  ",
                   "   FROM xmdk_t LEFT OUTER JOIN ooag_t ON ooagent = xmdkent AND ooag001 = xmdk003",
                   "               LEFT OUTER JOIN ooefl_t ON ooeflent = xmdkent AND ooefl001 = xmdk004 AND ooefl002 = '",g_lang,"' ",
                   "       ,xmdl_t LEFT OUTER JOIN xmda_t ON xmda_t.xmdaent = xmdl_t.xmdlent AND xmdadocno = xmdl_t.xmdl003 ",
                   "               LEFT OUTER JOIN imaa_t ON imaa_t.imaaent = xmdl_t.xmdlent AND imaa_t.imaa001 = xmdl_t.xmdl008 ",
                   "               LEFT OUTER JOIN imaf_t ON imaf_t.imafent = xmdl_t.xmdlent AND imaf_t.imafsite = xmdl_t.xmdlsite AND imaf_t.imaf001 = xmdl_t.xmdl008 ",
                   "               LEFT OUTER JOIN pmaal_t a1 ON a1.pmaalent = xmdlent AND a1.pmaal001 = xmda004 AND a1.pmaal002 = '",g_dlang,"' ",
                   "               LEFT OUTER JOIN pmaal_t a2 ON a2.pmaalent = xmdlent AND a2.pmaal001 = xmda034 AND a2.pmaal002 = '",g_dlang,"' ",
                   "               LEFT OUTER JOIN rtaxl_t ON rtaxlent = xmdlent AND rtaxl001 = imaa009 AND rtaxl002 = '",g_dlang,"' ",
                   "               LEFT OUTER JOIN oocql_t a3 ON a3.oocqlent = xmdlent AND a3.oocql001 = '202' AND a3.oocql002 = imaf111 AND a3.oocql003 = '",g_dlang,"' ",
                   "               LEFT OUTER JOIN oocql_t a4 ON a4.oocqlent = xmdlent AND a4.oocql001 = '2003' AND a4.oocql002 = imaa127 AND a4.oocql003 = '",g_dlang,"' ",
                   "               LEFT OUTER JOIN imaal_t ON imaalent = xmdlent AND imaal001 = xmdl008 AND imaal002 = '",g_dlang,"' ",
                   "  WHERE xmdkent = xmdlent ",
                   "    AND xmdkdocno = xmdldocno ",
                   "    AND xmdkstus = 'S' ",
                   "    AND xmdk000 IN ('1','2','6') ",
                   "    AND xmdkdocno NOT IN (SELECT DISTINCT xmde003 ",
                   "                            FROM xmde_t ",
                   "                           WHERE xmdeent = ",g_enterprise,
                   "                             AND xmdesite = '",g_site,"')",
                   "    AND xmdk007 = '",sr.xmfj003,"' ",
                   "    AND ",tm.wc2,
                   "    AND ",l_where
       #151113-00022#11 20151123 s983961--MOD(E)            
       PREPARE axmr432_xmdk_prepare FROM l_sql
       DISPLAY l_sql
       IF STATUS THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = 'prepare:'
          LET g_errparam.code   = STATUS
          LET g_errparam.popup  = TRUE
          CALL cl_err()
          LET g_rep_success = 'N' 
       END IF
       DECLARE axmr432_xmdk_curs CURSOR FOR axmr432_xmdk_prepare
       
       #151113-00022#11 20151123 s983961--MOD(S)
       #FOREACH axmr432_xmdk_curs INTO sr.l_xmdkdocno,sr.l_xmdk001,sr.l_xmdk003,sr.l_xmdk004,sr.l_xmdlseq,
       #                               sr.l_xmdl008,sr.l_xmdl009,sr.l_xmdl021,sr.l_xmdl022,sr.l_xmdl024,
       #                               sr.l_xmdl027,sr.l_xmdl028,sr.l_xmdl029,sr.l_imaa009,sr.l_imaa127,
       #                               sr.l_imaf111,sr.l_xmda004,sr.l_xmda034
       FOREACH axmr432_xmdk_curs INTO sr.l_xmdkdocno,sr.l_xmdk001,sr.l_xmdk003,sr.l_xmdk004,sr.l_xmdlseq,
                                      sr.l_xmdl008,sr.l_xmdl009,sr.l_xmdl021,sr.l_xmdl022,sr.l_xmdl024,
                                      sr.l_xmdl027,sr.l_xmdl028,sr.l_xmdl029,sr.l_imaa009,sr.l_imaa127,
                                      sr.l_imaf111,sr.l_xmda004,sr.l_xmda034,
                                      sr.l_xmdk003_desc,sr.l_xmdk004_desc,sr.l_xmda004_desc,sr.l_xmda034_desc,
                                      sr.l_imaa009_desc,sr.l_imaf111_desc,sr.l_imaa127_desc,sr.l_imaa127desc,
                                      sr.l_xmdl008_desc,sr.l_xmdl008_desc2
       #151113-00022#11 20151123 s983961--MOD(E)                               
          IF STATUS THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.extend = 'foreach:'
             LET g_errparam.code   = STATUS
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             LET g_rep_success = 'N'
             EXIT FOREACH
          END IF
          #151113-00022#11 20151123 s983961--MARK(S)
          ##業務人員
          #CALL s_desc_get_person_desc(sr.l_xmdk003) RETURNING sr.l_xmdk003_desc
          ##業務部門
          #CALL s_desc_get_department_desc(sr.l_xmdk004) RETURNING sr.l_xmdk004_desc
          ##帳款客戶
          #CALL s_desc_get_trading_partner_abbr_desc(sr.xmfj003) RETURNING sr.l_xmfj003_desc          
          ##訂單客戶
          #CALL s_desc_get_trading_partner_abbr_desc(sr.l_xmda004) RETURNING sr.l_xmda004_desc
          ##訂單最終客戶
          #CALL s_desc_get_trading_partner_abbr_desc(sr.l_xmda034) RETURNING sr.l_xmda034_desc
          ##產品分類
          #CALL s_desc_get_rtaxl003_desc(sr.l_imaa009) RETURNING sr.l_imaa009_desc
          ##銷售分群
          #CALL s_desc_get_acc_desc('202',sr.l_imaf111) RETURNING sr.l_imaf111_desc
          ##系列號
          #CALL s_desc_get_acc_desc('2003',sr.l_imaa127) RETURNING sr.l_imaa127_desc 
          #IF NOT cl_null(sr.l_imaa127_desc) THEN    #20150819 dorislai add  (S)
          #   LET sr.l_imaa127desc = sr.l_imaa127,'.',sr.l_imaa127_desc
          #ELSE
          #   LET sr.l_imaa127desc = ''
          #END IF                                    #20150819 dorislai add   (E)
          ##品名規格
          #CALL s_desc_get_item_desc(sr.l_xmdl008) RETURNING sr.l_xmdl008_desc,sr.l_xmdl008_desc2
          #151113-00022#11 20151123 s983961--MARK(E)
          #產品特徵
          CALL s_feature_description(sr.l_xmdl008,sr.l_xmdl009) RETURNING l_success,sr.l_xmdl009_desc
          IF NOT l_success THEN
             LET sr.l_xmdl009_desc = ''
          END IF
          
          EXECUTE insert_prep USING sr.xmfjdocno,sr.xmflseq,sr.l_xmdk003,sr.l_xmdk003_desc,sr.l_xmdk004,sr.l_xmdk004_desc,sr.xmfj003,sr.l_xmfj003_desc,sr.l_xmdkdocno,sr.l_xmdlseq,sr.l_xmda004,sr.l_xmda004_desc,sr.l_xmda034,sr.l_xmda034_desc,sr.l_xmdk001,sr.l_imaa009,sr.l_imaa009_desc,sr.l_imaf111,sr.l_imaf111_desc,sr.l_imaa127,sr.l_imaa127_desc,sr.l_imaa127desc,sr.l_xmdl008,sr.l_xmdl008_desc,sr.l_xmdl008_desc2,sr.l_xmdl009,sr.l_xmdl009_desc,sr.l_xmdl022,sr.l_xmdl021,sr.l_xmdl024,sr.l_xmdl027,sr.l_xmdl028,sr.l_xmdl029
          IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
             LET g_errparam.extend = "axmr432_x01_execute"
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.popup  = FALSE
             CALL cl_err()       
             LET g_rep_success = 'N'
             EXIT FOREACH
          END IF
       END FOREACH       
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       IF g_rep_success = 'N' THEN
         EXIT FOREACH
       ELSE
         CONTINUE FOREACH
       END IF
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.xmfjdocno,sr.xmflseq,sr.l_xmdk003,sr.l_xmdk003_desc,sr.l_xmdk004,sr.l_xmdk004_desc,sr.xmfj003,sr.l_xmfj003_desc,sr.l_xmdkdocno,sr.l_xmdlseq,sr.l_xmda004,sr.l_xmda004_desc,sr.l_xmda034,sr.l_xmda034_desc,sr.l_xmdk001,sr.l_imaa009,sr.l_imaa009_desc,sr.l_imaf111,sr.l_imaf111_desc,sr.l_imaa127,sr.l_imaa127_desc,sr.l_imaa127desc,sr.l_xmdl008,sr.l_xmdl008_desc,sr.l_xmdl008_desc2,sr.l_xmdl009,sr.l_xmdl009_desc,sr.l_xmdl022,sr.l_xmdl021,sr.l_xmdl024,sr.l_xmdl027,sr.l_xmdl028,sr.l_xmdl029
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "axmr432_x01_execute"
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
 
{<section id="axmr432_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION axmr432_x01_rep_data()
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
 
{<section id="axmr432_x01.other_function" readonly="Y" >}

 
{</section>}
 
