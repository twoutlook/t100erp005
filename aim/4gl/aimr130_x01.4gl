#該程式未解開Section, 採用最新樣板產出!
{<section id="aimr130_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2016-06-30 10:33:15), PR版次:0002(2016-07-07 16:59:09)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000033
#+ Filename...: aimr130_x01
#+ Description: ...
#+ Creator....: 05423(2015-12-22 14:33:23)
#+ Modifier...: 01534 -SD/PR- 01534
 
{</section>}
 
{<section id="aimr130_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#160629-00002#2   16/06/30 By lixh  效能优化
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
       bdate LIKE type_t.dat,         #bdate 
       edate LIKE type_t.dat,         #edate 
       pr1 LIKE type_t.chr2,         #采购前置期 
       days LIKE type_t.num5,         #差异天数 
       pr2 LIKE type_t.chr2,         #主要供应商 
       show LIKE type_t.chr2,         #仅显示差异者 
       pr3 LIKE type_t.chr2,         #最小采购批量 
       rate LIKE type_t.num5          #差异比率
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="aimr130_x01.main" readonly="Y" >}
PUBLIC FUNCTION aimr130_x01(p_arg1,p_arg2,p_arg3,p_arg4,p_arg5,p_arg6,p_arg7,p_arg8,p_arg9)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.dat         #tm.bdate  bdate 
DEFINE  p_arg3 LIKE type_t.dat         #tm.edate  edate 
DEFINE  p_arg4 LIKE type_t.chr2         #tm.pr1  采购前置期 
DEFINE  p_arg5 LIKE type_t.num5         #tm.days  差异天数 
DEFINE  p_arg6 LIKE type_t.chr2         #tm.pr2  主要供应商 
DEFINE  p_arg7 LIKE type_t.chr2         #tm.show  仅显示差异者 
DEFINE  p_arg8 LIKE type_t.chr2         #tm.pr3  最小采购批量 
DEFINE  p_arg9 LIKE type_t.num5         #tm.rate  差异比率
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.bdate = p_arg2
   LET tm.edate = p_arg3
   LET tm.pr1 = p_arg4
   LET tm.days = p_arg5
   LET tm.pr2 = p_arg6
   LET tm.show = p_arg7
   LET tm.pr3 = p_arg8
   LET tm.rate = p_arg9
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "aimr130_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL aimr130_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL aimr130_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL aimr130_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL aimr130_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL aimr130_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="aimr130_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION aimr130_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "imaa001.imaa_t.imaa001,l_imaal003.imaal_t.imaal003,l_imaal004.imaal_t.imaal004,l_imaa009_desc.rtaxl_t.rtaxl003,l_imaf141_desc.oocql_t.oocql004,l_imaf142_desc.ooag_t.ooag011,l_chk_item.oocql_t.oocql004,l_cur_set.type_t.chr100,l_act_set.type_t.chr100" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="aimr130_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION aimr130_x01_ins_prep()
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
             ?,?,?)"
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
 
{<section id="aimr130_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aimr130_x01_sel_prep()
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
   LET g_select = " SELECT DISTINCT imaa001,imaal003,imaal004,imaa009,rtaxl004,imaf141,oocql004,imaf142,ooag011,NULL,NULL,NULL", 
                  ",COALESCE(imaf171,0),COALESCE(imaf172,0),COALESCE(imaf174,0),imaf153,COALESCE(imaf146,0)"   #160629-00002#2 add
#   #end add-point
#   LET g_select = " SELECT imaa001,NULL,NULL,imaa009,NULL,imaf141,NULL,imaf142,NULL,NULL,NULL,NULL"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_from = " FROM imaa_t LEFT OUTER JOIN imaal_t ON imaal001 = imaa001 AND imaalent = imaaent AND imaal002 = '",g_dlang,"' ",
                "             LEFT OUTER JOIN imaf_t ON imaf001 = imaa001 AND imafent = imaaent ",
                "             LEFT OUTER JOIN rtaxl_t ON rtaxl001 = imaa009 AND rtaxlent = imaaent AND rtaxl002 = '",g_dlang,"' ",
                "             LEFT OUTER JOIN oocql_t ON oocql001 = '203' AND oocql002 = imaf141 AND oocql003 = '",g_dlang,"' ",
                "             LEFT OUTER JOIN ooag_t ON ooag001 = imaf142 AND ooagent = imaaent "
#   #end add-point
#    LET g_from = " FROM imaa_t,imaf_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("imaa_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE aimr130_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE aimr130_x01_curs CURSOR FOR aimr130_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="aimr130_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION aimr130_x01_ins_data()
DEFINE sr RECORD 
   imaa001 LIKE imaa_t.imaa001, 
   l_imaal003 LIKE imaal_t.imaal003, 
   l_imaal004 LIKE imaal_t.imaal004, 
   imaa009 LIKE imaa_t.imaa009, 
   l_imaa009_desc LIKE rtaxl_t.rtaxl003, 
   imaf141 LIKE imaf_t.imaf141, 
   l_imaf141_desc LIKE oocql_t.oocql004, 
   imaf142 LIKE imaf_t.imaf142, 
   l_imaf142_desc LIKE ooag_t.ooag011, 
   l_chk_item LIKE oocql_t.oocql004, 
   l_cur_set LIKE type_t.chr100, 
   l_act_set LIKE type_t.chr100
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_imaf171  LIKE imaf_t.imaf171
DEFINE l_imaf172  LIKE imaf_t.imaf172
DEFINE l_imaf174  LIKE imaf_t.imaf174
DEFINE l_imaf153  LIKE type_t.chr100
DEFINE l_imaf146  LIKE imaf_t.imaf146
DEFINE l_date1    LIKE type_t.dat
DEFINE l_date2    LIKE type_t.dat
DEFINE l_count    LIKE type_t.num10
DEFINE l_sql      STRING
DEFINE l_tmp1      LIKE type_t.num10
DEFINE l_tmp2      LIKE type_t.num10
DEFINE l_sql2      STRING
DEFINE l_sql3      STRING
DEFINE l_sql4      STRING
DEFINE l_sql5      STRING
DEFINE l_imaf171_desc   LIKE oocql_t.oocql004
DEFINE l_imaf172_desc   LIKE oocql_t.oocql004
DEFINE l_imaf174_desc   LIKE oocql_t.oocql004
DEFINE l_imaf153_desc   LIKE oocql_t.oocql004
DEFINE l_imaf146_desc   LIKE oocql_t.oocql004
DEFINE l_pmaal003       LIKE pmaal_t.pmaal003
DEFINE l_imaf153_desc2   LIKE pmaal_t.pmaal003
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    #160629-00002#2-s
    LET g_rep_success = 'Y'
    LET l_imaf171_desc = aimr130_x01_get_item_desc('imaf171')
    LET l_imaf172_desc = aimr130_x01_get_item_desc('imaf172')
    LET l_imaf174_desc = aimr130_x01_get_item_desc('imaf174')
    LET l_imaf153_desc = aimr130_x01_get_item_desc('imaf153')
    LET l_imaf146_desc = aimr130_x01_get_item_desc('imaf146')
    IF tm.pr1 = "Y" THEN
       LET l_sql = " SELECT DISTINCT imaa001,imaal003,imaal004,imaa009,rtaxl004,imaf141,oocql004,imaf142,ooag011,NULL,NULL,NULL,", 
                   "                  COALESCE(imaf171,0),COALESCE(imaf172,0),COALESCE(imaf174,0),imaf153,COALESCE(imaf146,0),num ",   
              
                   "   FROM imaa_t LEFT OUTER JOIN imaal_t ON imaal001 = imaa001 AND imaalent = imaaent AND imaal002 = '",g_dlang,"' ",
                   "               LEFT OUTER JOIN imaf_t ON imaf001 = imaa001 AND imafent = imaaent ",
                   "               LEFT OUTER JOIN rtaxl_t ON rtaxl001 = imaa009 AND rtaxlent = imaaent AND rtaxl002 = '",g_dlang,"' ",
                   "               LEFT OUTER JOIN oocql_t ON oocql001 = '203' AND oocql002 = imaf141 AND oocql003 = '",g_dlang,"' ",
                   "               LEFT OUTER JOIN ooag_t ON ooag001 = imaf142 AND ooagent = imaaent ",
                   "               LEFT OUTER JOIN ",
                   " (SELECT C.pmdb004,MAX(COALESCE(C.l_num,0)) AS num              
                        FROM (SELECT pmdb004,pmdadocno,MAX(pmdldocdt),pmdadocdt,COALESCE(MAX(pmdldocdt)-pmdadocdt,0) AS l_num
                                FROM pmda_t LEFT OUTER JOIN pmdb_t ON pmdbdocno = pmdadocno AND pmdbent = pmdaent AND pmdbsite = pmdasite
                                            LEFT OUTER JOIN pmdp_t ON pmdbdocno = pmdp003 AND pmdbseq = pmdp004 AND pmdbent = pmdpent AND pmdbsite = pmdpsite
                                            LEFT OUTER JOIN pmdl_t ON pmdpdocno = pmdldocno AND pmdpent = pmdlent AND pmdpsite = pmdlsite AND pmdlstus IN ('C','Y') 
                               WHERE pmdaent = ",g_enterprise,
                   "             AND pmdasite = '",g_site,"'",
                   "             AND pmdastus IN ('C','Y') ",
                   "             AND (pmdadocdt BETWEEN '",tm.bdate,"' AND '",tm.edate,"')",
                   "           GROUP BY pmdb004,pmdadocno,pmdadocdt
                               ORDER BY l_num desc) C
                        WHERE 1=1
                        GROUP BY C.pmdb004
                        ORDER BY C.pmdb004) D ON imaa001 = D.pmdb004 ",
                   " WHERE imaaent = ",g_enterprise,
                   "   AND ",tm.wc CLIPPED 
           
       PREPARE aimr130_x01_prepare2 FROM l_sql
       DECLARE aimr130_x01_curs2 CURSOR FOR aimr130_x01_prepare2           
                           

    
       LET sr.l_act_set = NULL 
       FOREACH aimr130_x01_curs2 INTO sr.*,l_imaf171,l_imaf172,l_imaf174,l_imaf153,l_imaf146,sr.l_act_set
          IF STATUS THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.extend = 'foreach:'
             LET g_errparam.code   = STATUS
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             LET g_rep_success = 'N'
             EXIT FOREACH
          END IF
      
          #获取说明
          IF NOT cl_null(sr.imaa009) THEN
             LET sr.l_imaa009_desc = sr.imaa009 CLIPPED,'.',sr.l_imaa009_desc CLIPPED
          END IF
          IF NOT cl_null(sr.imaf141) THEN
             LET sr.l_imaf141_desc = sr.imaf141 CLIPPED,'.',sr.l_imaf141_desc CLIPPED
          END IF
          IF NOT cl_null(sr.imaf142) THEN
             LET sr.l_imaf142_desc = sr.imaf142 CLIPPED,'.',sr.l_imaf142_desc CLIPPED
          END IF
          LET sr.l_chk_item = l_imaf171_desc
      
          IF (sr.l_act_set >= l_imaf171 + tm.days OR sr.l_act_set <= l_imaf171 - tm.days) THEN
             EXECUTE insert_prep USING sr.imaa001,sr.l_imaal003,sr.l_imaal004,sr.l_imaa009_desc,sr.l_imaf141_desc,sr.l_imaf142_desc,sr.l_chk_item,l_imaf171,sr.l_act_set
          END IF
          
          LET sr.l_act_set = NULL
          
          #获取设定资料
          INITIALIZE l_imaf171 TO NULL
          INITIALIZE l_imaf172 TO NULL
          INITIALIZE l_imaf174 TO NULL
          INITIALIZE l_imaf153 TO NULL
          INITIALIZE l_imaf146 TO NULL
          INITIALIZE l_tmp1 TO NULL
          INITIALIZE l_tmp2 TO NULL       
       END FOREACH 
       
       LET l_sql4 = " SELECT DISTINCT imaa001,imaal003,imaal004,imaa009,rtaxl004,imaf141,oocql004,imaf142,ooag011,NULL,NULL,NULL,", 
                    "                  COALESCE(imaf171,0),COALESCE(imaf172,0),COALESCE(imaf174,0),imaf153,COALESCE(imaf146,0),num ",   
                 
                    "   FROM imaa_t LEFT OUTER JOIN imaal_t ON imaal001 = imaa001 AND imaalent = imaaent AND imaal002 = '",g_dlang,"' ",
                    "               LEFT OUTER JOIN imaf_t ON imaf001 = imaa001 AND imafent = imaaent ",
                    "               LEFT OUTER JOIN rtaxl_t ON rtaxl001 = imaa009 AND rtaxlent = imaaent AND rtaxl002 = '",g_dlang,"' ",
                    "               LEFT OUTER JOIN oocql_t ON oocql001 = '203' AND oocql002 = imaf141 AND oocql003 = '",g_dlang,"' ",
                    "               LEFT OUTER JOIN ooag_t ON ooag001 = imaf142 AND ooagent = imaaent ",
                    "               LEFT OUTER JOIN ",       
                    "              (SELECT t.pmdn001 AS l_pmdn001,MAX(COALESCE(t.l_num1,0) AS num )  ",   
                    "                 FROM (SELECT pmdn001,pmdldocno,MAX(b.pmdsdocdt),pmdldocdt,COALESCE(MAX(b.pmdsdocdt)-pmdldocdt,0) AS l_num1 ",
                    "                       FROM pmdl_t LEFT OUTER JOIN pmdn_t ON pmdndocno = pmdldocno AND pmdnent = pmdlent AND pmdnsite = pmdlsite ",
                    "                                   LEFT OUTER JOIN pmdt_t ON pmdt001 = pmdndocno AND pmdt002 = pmdnseq AND pmdtent = pmdnent AND pmdtsite = pmdnsite ",
                    "                                   LEFT OUTER JOIN pmds_t b ON pmdtdocno = b.pmdsdocno AND b.pmdsent = pmdtent AND b.pmdssite = pmdtsite AND b.pmds000 = '1' AND b.pmdsstus = 'Y' ",
                
                    "                      WHERE 1=1 ",
                    "                        AND pmdlent = ",g_enterprise, 
                    "                        AND pmdlsite = '",g_site,"'",
                    "                        AND (pmdldocdt BETWEEN '",tm.bdate,"' AND '",tm.edate,"')",
                    "                      GROUP BY pmdn001,pmdldocno,pmdldocdt ",
                    "                      ORDER BY l_num1 desc) t ",
                    "                      GROUP BY l_pmdn001 ) t1 ON imaa001 = t1.l_pmdn001 ",     
                    "                WHERE imaaent = ",g_enterprise,
                    "                  AND (num >= imaf172 + '",tm.days,"' OR num <= imaf172 - '",tm.days,"')",
                    "                  AND ",tm.wc CLIPPED           

       PREPARE aimr130_x01_prepare5 FROM l_sql4
       DECLARE aimr130_x01_curs5 CURSOR FOR aimr130_x01_prepare5          
       
       LET sr.l_act_set = NULL       
       FOREACH aimr130_x01_curs5 INTO sr.*,l_imaf171,l_imaf172,l_imaf174,l_imaf153,l_imaf146,sr.l_act_set
          IF STATUS THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.extend = 'foreach:'
             LET g_errparam.code   = STATUS
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             LET g_rep_success = 'N'
             EXIT FOREACH
          END IF
      
          #获取说明
          IF NOT cl_null(sr.imaa009) THEN
             LET sr.l_imaa009_desc = sr.imaa009 CLIPPED,'.',sr.l_imaa009_desc CLIPPED
          END IF
          IF NOT cl_null(sr.imaf141) THEN
             LET sr.l_imaf141_desc = sr.imaf141 CLIPPED,'.',sr.l_imaf141_desc CLIPPED
          END IF
          IF NOT cl_null(sr.imaf142) THEN
             LET sr.l_imaf142_desc = sr.imaf142 CLIPPED,'.',sr.l_imaf142_desc CLIPPED
          END IF
          LET sr.l_chk_item = l_imaf172_desc

          IF (sr.l_act_set >= l_imaf172 + tm.days OR sr.l_act_set <= l_imaf172 - tm.days) THEN
             EXECUTE insert_prep USING sr.imaa001,sr.l_imaal003,sr.l_imaal004,sr.l_imaa009_desc,sr.l_imaf141_desc,sr.l_imaf142_desc,sr.l_chk_item,l_imaf172,sr.l_act_set
          END IF
          
          LET sr.l_act_set = NULL
          
          #获取设定资料
          INITIALIZE l_imaf171 TO NULL
          INITIALIZE l_imaf172 TO NULL
          INITIALIZE l_imaf174 TO NULL
          INITIALIZE l_imaf153 TO NULL
          INITIALIZE l_imaf146 TO NULL
          INITIALIZE l_tmp1 TO NULL
          INITIALIZE l_tmp2 TO NULL 
       END FOREACH   

       LET l_sql5 = " SELECT DISTINCT imaa001,imaal003,imaal004,imaa009,rtaxl004,imaf141,oocql004,imaf142,ooag011,NULL,NULL,NULL,", 
                    "                  COALESCE(imaf171,0),COALESCE(imaf172,0),COALESCE(imaf174,0),imaf153,COALESCE(imaf146,0),num ",   
                 
                    "   FROM imaa_t LEFT OUTER JOIN imaal_t ON imaal001 = imaa001 AND imaalent = imaaent AND imaal002 = '",g_dlang,"' ",
                    "               LEFT OUTER JOIN imaf_t ON imaf001 = imaa001 AND imafent = imaaent ",
                    "               LEFT OUTER JOIN rtaxl_t ON rtaxl001 = imaa009 AND rtaxlent = imaaent AND rtaxl002 = '",g_dlang,"' ",
                    "               LEFT OUTER JOIN oocql_t ON oocql001 = '203' AND oocql002 = imaf141 AND oocql003 = '",g_dlang,"' ",
                    "               LEFT OUTER JOIN ooag_t ON ooag001 = imaf142 AND ooagent = imaaent ",
                    "               LEFT OUTER JOIN ",       
                    "              (SELECT t.pmdn001 AS l_pmdn001,MAX(COALESCE(t.l_num1,0)) AS num2,MAX(COALESCE(t.l_num2,0)) AS num ",    
                    "                 FROM (SELECT pmdn001,pmdldocno,MAX(b.pmdsdocdt),pmdldocdt,COALESCE(MAX(b.pmdsdocdt)-pmdldocdt,0) AS l_num1,MAX(b.pmdsdocdt),COALESCE(MAX(a.pmdsdocdt)-MAX(b.pmdsdocdt),0) AS l_num2 ",
                    "                         FROM pmdl_t LEFT OUTER JOIN pmdn_t ON pmdndocno = pmdldocno AND pmdnent = pmdlent AND pmdnsite = pmdlsite ",
                    "                         LEFT OUTER JOIN pmdt_t ON pmdt001 = pmdndocno AND pmdt002 = pmdnseq AND pmdtent = pmdnent AND pmdtsite = pmdnsite ",
                    "                         LEFT OUTER JOIN pmds_t b ON pmdtdocno = b.pmdsdocno AND b.pmdsent = pmdtent AND b.pmdssite = pmdtsite AND b.pmds000 IN ('1','2') AND b.pmdsstus = 'Y' ",
                    "                         LEFT OUTER JOIN pmds_t a ON pmdtdocno = a.pmdsdocno AND a.pmdsent = pmdtent AND a.pmdssite = pmdtsite AND a.pmds000 = '6' AND a.pmdsstus IN ('S','Y') ",      
                    "                        WHERE 1=1 ",
                    "                          AND pmdlent = ",g_enterprise,
                    "                          AND pmdlsite = '",g_site,"'",
                    "                          AND (pmdldocdt BETWEEN '",tm.bdate,"' AND '", tm.edate,"')",
                    "                        GROUP BY pmdn001,pmdldocno,pmdldocdt ",
                    "                        ORDER BY pmdn001,l_num1,l_num2 desc) t ",
                    "                WHERE 1=1 ",
                    "                GROUP BY l_pmdn001,num2,num) t1 ON imaa001 = t1.l_pmdn001  ",  
                    "   WHERE imaaent = ",g_enterprise,
                    "      AND (num >= imaf174 + '",tm.days,"' OR num <= imaf174 - '",tm.days,"')",
                    "      AND ",tm.wc CLIPPED           

       PREPARE aimr130_x01_prepare6 FROM l_sql5
       DECLARE aimr130_x01_curs6 CURSOR FOR aimr130_x01_prepare6  
       
       LET sr.l_act_set = NULL                            
       FOREACH aimr130_x01_curs6 INTO sr.*,l_imaf171,l_imaf172,l_imaf174,l_imaf153,l_imaf146,sr.l_act_set
          IF STATUS THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.extend = 'foreach:'
             LET g_errparam.code   = STATUS
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             LET g_rep_success = 'N'
             EXIT FOREACH
          END IF
      
          #获取说明
          IF NOT cl_null(sr.imaa009) THEN
             LET sr.l_imaa009_desc = sr.imaa009 CLIPPED,'.',sr.l_imaa009_desc CLIPPED
          END IF
          IF NOT cl_null(sr.imaf141) THEN
             LET sr.l_imaf141_desc = sr.imaf141 CLIPPED,'.',sr.l_imaf141_desc CLIPPED
          END IF
          IF NOT cl_null(sr.imaf142) THEN
             LET sr.l_imaf142_desc = sr.imaf142 CLIPPED,'.',sr.l_imaf142_desc CLIPPED
          END IF
          LET sr.l_chk_item = l_imaf174_desc

          IF (sr.l_act_set >= l_imaf174 + tm.days OR sr.l_act_set <= l_imaf174 - tm.days) THEN
             EXECUTE insert_prep USING sr.imaa001,sr.l_imaal003,sr.l_imaal004,sr.l_imaa009_desc,sr.l_imaf141_desc,sr.l_imaf142_desc,sr.l_chk_item,l_imaf174,sr.l_act_set
          END IF
          
          LET sr.l_act_set = NULL
          
          #获取设定资料
          INITIALIZE l_imaf171 TO NULL
          INITIALIZE l_imaf172 TO NULL
          INITIALIZE l_imaf174 TO NULL
          INITIALIZE l_imaf153 TO NULL
          INITIALIZE l_imaf146 TO NULL
          INITIALIZE l_tmp1 TO NULL
          INITIALIZE l_tmp2 TO NULL 
       END FOREACH                    
    END IF   
    
  

    LET sr.l_act_set = NULL
    #主要供应商 imaf153----次数最多的供应商
    IF tm.pr2 = "Y" THEN
       #优化之后捞取的资料有可能比优化前多，因为同一料件，次数最多的供应商可能有多个，比如供应商A出现了5次，B也出现了5次，且次数最多的供应商出现的次数是5，应该多个供应商都显示，
       #优化前的处理方式是取任意一个供应商，应该次数相同的供应商都显示比较合理
       LET l_sql2 = " SELECT DISTINCT imaa001,imaal003,imaal004,imaa009,rtaxl004,imaf141,oocql004,imaf142,ooag011,NULL,NULL,NULL,", 
                    "                  COALESCE(imaf171,0),COALESCE(imaf172,0),COALESCE(imaf174,0),imaf153,COALESCE(imaf146,0),t5.pmaal003,t4.pmaal003,num ",   
               
                    "   FROM imaa_t LEFT OUTER JOIN imaal_t ON imaal001 = imaa001 AND imaalent = imaaent AND imaal002 = '",g_dlang,"' ",
                    "               LEFT OUTER JOIN imaf_t ON imaf001 = imaa001 AND imafent = imaaent ",
                    "               LEFT OUTER JOIN rtaxl_t ON rtaxl001 = imaa009 AND rtaxlent = imaaent AND rtaxl002 = '",g_dlang,"' ",
                    "               LEFT OUTER JOIN oocql_t ON oocql001 = '203' AND oocql002 = imaf141 AND oocql003 = '",g_dlang,"' ",
                    "               LEFT OUTER JOIN ooag_t ON ooag001 = imaf142 AND ooagent = imaaent ",
                    "               LEFT OUTER JOIN pmaal_t t5 ON t5.pmaalent = imafent AND t5.pmaal001 = imaf153 AND t5.pmaal002 = '",g_dlang,"' ",   #add
                    "               LEFT OUTER JOIN ",          
                    "               (SELECT t2.pmdn001 AS n_pmdn001,t2.pmdl004 AS num ",
                    "                  FROM (SELECT t.pmdn001,MAX(l_pmdl004) AS l_max ",
                    "                          FROM (SELECT pmdn001,pmdl004,COUNT(pmdl004) AS l_pmdl004 ",
                    "                                  FROM pmdl_t ",
                    "                                  LEFT OUTER JOIN pmdn_t ON pmdndocno = pmdldocno AND pmdnent = pmdlent AND pmdnsite= pmdlsite ", 
                    "                                 WHERE  pmdlent = ",g_enterprise, 
                    "                                   AND pmdlsite = 'DSCNJ'  AND pmdlstus IN ('C','Y') ", 
                    "                                   AND (pmdldocdt BETWEEN to_date('",tm.bdate,"','yy-mm-dd') AND to_date('",tm.edate,"','yy-mm-dd'))",
                    "                                 GROUP BY pmdn001,pmdl004) t ",
                    "                         GROUP BY pmdn001) t1, ",                                                          
                    "                       (SELECT pmdn001,pmdl004,COUNT(pmdl004) AS l_pmdl004  ", 
                    "                          FROM pmdl_t ",
                    "                          LEFT OUTER JOIN pmdn_t ON pmdndocno = pmdldocno AND pmdnent = pmdlent AND pmdnsite= pmdlsite ",
                    "                         WHERE  pmdlent = ",g_enterprise," AND pmdlsite = 'DSCNJ'  AND pmdlstus IN ('C','Y') ", 
                    "                           AND (pmdldocdt BETWEEN to_date('",tm.bdate,"','yy-mm-dd') AND to_date('",tm.edate,"','yy-mm-dd'))",
                    "                         GROUP BY pmdn001,pmdl004) t2 ",                                          
                    "                 WHERE t1.pmdn001 = t2.pmdn001 AND t1.l_max = t2.l_pmdl004) t3 ON t3.n_pmdn001 = imaa001 ",
                    "               LEFT OUTER JOIN pmaal_t t4 ON t4.pmaal001 = t3.num AND t4.pmaalent = '",g_enterprise,"' AND t4.pmaal002 = '",g_dlang,"'",   #add
                    "   WHERE imaaent = ",g_enterprise,
                    "      AND ",tm.wc CLIPPED     
                   
       PREPARE aimr130_imaf153_pre2 FROM l_sql2
       DECLARE aimr130_imaf153_cs2  CURSOR FOR aimr130_imaf153_pre2
       FOREACH aimr130_imaf153_cs2 INTO sr.*,l_imaf171,l_imaf172,l_imaf174,l_imaf153,l_imaf146,l_imaf153_desc2,l_pmaal003,sr.l_act_set
          IF STATUS THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.extend = 'foreach:'
             LET g_errparam.code   = STATUS
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             LET g_rep_success = 'N'
             EXIT FOREACH
          END IF
      
          #获取说明
          IF NOT cl_null(sr.imaa009) THEN
             LET sr.l_imaa009_desc = sr.imaa009 CLIPPED,'.',sr.l_imaa009_desc CLIPPED
          END IF
          IF NOT cl_null(sr.imaf141) THEN
             LET sr.l_imaf141_desc = sr.imaf141 CLIPPED,'.',sr.l_imaf141_desc CLIPPED
          END IF
          IF NOT cl_null(sr.imaf142) THEN
             LET sr.l_imaf142_desc = sr.imaf142 CLIPPED,'.',sr.l_imaf142_desc CLIPPED
          END IF
          LET sr.l_chk_item = l_imaf153_desc
                          
          IF tm.show = "Y" THEN
             IF sr.l_act_set <> l_imaf153 OR (cl_null(l_imaf153) AND NOT cl_null(sr.l_act_set)) THEN
                #LET sr.l_act_set = aimr130_x01_get_desc(sr.l_act_set)
                LET sr.l_act_set = sr.l_act_set CLIPPED,'.',l_pmaal003 CLIPPED 
                #LET l_imaf153 = aimr130_x01_get_desc(l_imaf153)
                IF NOT cl_null(l_imaf153) THEN 
                   LET l_imaf153 = l_imaf153 CLIPPED,'.',l_imaf153_desc2 CLIPPED 
                END IF 
                EXECUTE insert_prep USING sr.imaa001,sr.l_imaal003,sr.l_imaal004,sr.l_imaa009_desc,sr.l_imaf141_desc,sr.l_imaf142_desc,sr.l_chk_item,l_imaf153,sr.l_act_set
             END IF
          ELSE
             IF NOT cl_null(sr.l_act_set) THEN
                #LET sr.l_act_set = aimr130_x01_get_desc(sr.l_act_set)
                LET sr.l_act_set = sr.l_act_set CLIPPED,'.',l_pmaal003 CLIPPED
                #LET l_imaf153 = aimr130_x01_get_desc(l_imaf153)
                IF NOT cl_null(l_imaf153) THEN 
                   LET l_imaf153 = l_imaf153 CLIPPED,'.',l_imaf153_desc2 CLIPPED 
                END IF
                EXECUTE insert_prep USING sr.imaa001,sr.l_imaal003,sr.l_imaal004,sr.l_imaa009_desc,sr.l_imaf141_desc,sr.l_imaf142_desc,sr.l_chk_item,l_imaf153,sr.l_act_set
             END IF
          END IF
          #获取设定资料
          INITIALIZE l_imaf171 TO NULL
          INITIALIZE l_imaf172 TO NULL
          INITIALIZE l_imaf174 TO NULL
          INITIALIZE l_imaf153 TO NULL
          INITIALIZE l_imaf146 TO NULL
          INITIALIZE l_tmp1 TO NULL
          INITIALIZE l_tmp2 TO NULL           
          LET sr.l_act_set = NULL           
       END FOREACH                    

    END IF
       
       
       
    LET sr.l_act_set = NULL
    #最小采购批量 imaf146----最小收货数量
    IF tm.pr3 = "Y" THEN
       LET sr.l_chk_item = l_imaf146_desc
       
       LET l_sql3 = " SELECT DISTINCT imaa001,imaal003,imaal004,imaa009,rtaxl004,imaf141,oocql004,imaf142,ooag011,NULL,NULL,NULL,", 
                    "                  COALESCE(imaf171,0),COALESCE(imaf172,0),COALESCE(imaf174,0),imaf153,COALESCE(imaf146,0),t.l_pmdt020 ",   
                 
                    "   FROM imaa_t LEFT OUTER JOIN imaal_t ON imaal001 = imaa001 AND imaalent = imaaent AND imaal002 = '",g_dlang,"' ",
                    "               LEFT OUTER JOIN imaf_t ON imaf001 = imaa001 AND imafent = imaaent ",
                    "               LEFT OUTER JOIN rtaxl_t ON rtaxl001 = imaa009 AND rtaxlent = imaaent AND rtaxl002 = '",g_dlang,"' ",
                    "               LEFT OUTER JOIN oocql_t ON oocql001 = '203' AND oocql002 = imaf141 AND oocql003 = '",g_dlang,"' ",
                    "               LEFT OUTER JOIN ooag_t ON ooag001 = imaf142 AND ooagent = imaaent ",
                    "               LEFT OUTER JOIN ",   
                    "               (SELECT pmdt006,MIN(pmdt020) AS l_pmdt020
                                      FROM pmds_t LEFT OUTER JOIN pmdt_t ON pmdsdocno = pmdtdocno AND pmdsent = pmdtent AND pmdssite = pmdtsite ",
                    "                WHERE pmdsent = ",g_enterprise, 
                    "                  AND pmdssite = '",g_site,"'",
                    "                  AND pmdsstus IN ('S','Y') ",
                    "                  AND pmds000 IN ('1','2','3','4')",
                    "                  AND (pmdsdocdt BETWEEN '",tm.bdate,"' AND '",tm.edate,"')",
                    "                GROUP BY pmdt006   
                                     ORDER BY pmdt006,pmdt020 asc) t ON imaa001 = t.pmdt006 ",
                    "   WHERE imaaent = ",g_enterprise,
                    "     AND (t.l_pmdt020 >= imaf146*(100+'",tm.rate,"')/100 OR t.l_pmdt020 <= imaf146*(100-'",tm.rate,"')/100 )",
                    "     AND ",tm.wc CLIPPED 
   
       PREPARE aimr130_x01_prepare4 FROM l_sql3
       DECLARE aimr130_x01_curs4 CURSOR FOR aimr130_x01_prepare4  
     
       FOREACH aimr130_x01_curs4 INTO sr.*,l_imaf171,l_imaf172,l_imaf174,l_imaf153,l_imaf146,sr.l_act_set
          IF STATUS THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.extend = 'foreach:'
             LET g_errparam.code   = STATUS
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             LET g_rep_success = 'N'
             EXIT FOREACH
          END IF
      
          #获取说明
          IF NOT cl_null(sr.imaa009) THEN
             LET sr.l_imaa009_desc = sr.imaa009 CLIPPED,'.',sr.l_imaa009_desc CLIPPED
          END IF
          IF NOT cl_null(sr.imaf141) THEN
             LET sr.l_imaf141_desc = sr.imaf141 CLIPPED,'.',sr.l_imaf141_desc CLIPPED
          END IF
          IF NOT cl_null(sr.imaf142) THEN
             LET sr.l_imaf142_desc = sr.imaf142 CLIPPED,'.',sr.l_imaf142_desc CLIPPED
          END IF
          LET sr.l_chk_item = aimr130_x01_get_item_desc('imaf146')
                       
          IF sr.l_act_set >= l_imaf146*(100+tm.rate)/100 OR sr.l_act_set <= l_imaf146*(100-tm.rate)/100 THEN
             EXECUTE insert_prep USING sr.imaa001,sr.l_imaal003,sr.l_imaal004,sr.l_imaa009_desc,sr.l_imaf141_desc,sr.l_imaf142_desc,sr.l_chk_item,l_imaf146,sr.l_act_set
          END IF 
          #获取设定资料
          INITIALIZE l_imaf171 TO NULL
          INITIALIZE l_imaf172 TO NULL
          INITIALIZE l_imaf174 TO NULL
          INITIALIZE l_imaf153 TO NULL
          INITIALIZE l_imaf146 TO NULL
          INITIALIZE l_tmp1 TO NULL
          INITIALIZE l_tmp2 TO NULL           
          LET sr.l_act_set = NULL           
       END FOREACH                    
    END IF
    RETURN 
       #160629-00002#2-e
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH aimr130_x01_curs INTO sr.*                               
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
       #获取说明
       IF NOT cl_null(sr.imaa009) THEN
          LET sr.l_imaa009_desc = sr.imaa009 CLIPPED,'.',sr.l_imaa009_desc CLIPPED
       END IF
       IF NOT cl_null(sr.imaf141) THEN
          LET sr.l_imaf141_desc = sr.imaf141 CLIPPED,'.',sr.l_imaf141_desc CLIPPED
       END IF
       IF NOT cl_null(sr.imaf142) THEN
          LET sr.l_imaf142_desc = sr.imaf142 CLIPPED,'.',sr.l_imaf142_desc CLIPPED
       END IF
       #获取设定资料
       INITIALIZE l_imaf171 TO NULL
       INITIALIZE l_imaf172 TO NULL
       INITIALIZE l_imaf174 TO NULL
       INITIALIZE l_imaf153 TO NULL
       INITIALIZE l_imaf146 TO NULL
       INITIALIZE l_tmp1 TO NULL
       INITIALIZE l_tmp2 TO NULL
       SELECT DISTINCT COALESCE(imaf171,0),COALESCE(imaf172,0),COALESCE(imaf174,0),imaf153,COALESCE(imaf146,0)
       INTO l_imaf171,l_imaf172,l_imaf174,l_imaf153,l_imaf146
         FROM imaf_t
        WHERE imaf001 = sr.imaa001
          AND imafent = g_enterprise 
          AND imafsite = g_site
       #检核项目：
       #采购前置期
       IF tm.pr1 = "Y" THEN
       #采购文件前置时间 imaf171----采购单单据日期pmdldocdt-请购单单据日期pmdadocdt
          LET sr.l_chk_item = aimr130_x01_get_item_desc('imaf171')
          #计算实际参数
#          SELECT pmdldocdt INTO l_date1      #采购单单据日期
#            FROM (SELECT pmdldocdt 
#            FROM pmdl_t LEFT OUTER JOIN pmdn_t ON pmdndocno = pmdldocno AND pmdnent = pmdlent
#           WHERE pmdn001 = sr.imaa001 
#             AND pmdlent = g_enterprise 
#             AND pmdl007 = '2'               #关联请购单
#             AND pmdl008 = '请购单'               #关联请购单
#             AND pmdlstus IN ('C','Y')
#             AND (pmdldocdt BETWEEN tm.bdate AND tm.edate)
#           ORDER BY pmdldocdt desc)
#           WHERE rownum = 1
#          SELECT pmdadocdt INTO l_date2      #请购单单据日期
#            FROM (SELECT pmdadocdt 
#            FROM pmda_t LEFT OUTER JOIN pmdb_t ON pmdbdocno = pmdadocno AND pmdbent = pmdaent
#           WHERE pmdb004 = sr.imaa001 
#             AND pmdaent = g_enterprise 
#             AND pmdastus IN ('C','Y')
#             AND (pmdadocdt BETWEEN tm.bdate AND tm.edate)
#           ORDER BY pmdadocdt desc)
#           WHERE rownum = 1    
#          LET sr.l_act_set = l_date1-l_date2
          -----取复合条件的请购单日期与其对应的采购单日期，多笔请购单，选计算最大的
          SELECT MAX(COALESCE(l_num,0)) INTO l_tmp1   #sr.l_act_set      #采购单单据日期
            FROM (SELECT pmdadocno,MAX(pmdldocdt),pmdadocdt,COALESCE(MAX(pmdldocdt)-pmdadocdt,0) AS l_num
            FROM pmda_t LEFT OUTER JOIN pmdb_t ON pmdbdocno = pmdadocno AND pmdbent = pmdaent AND pmdbsite = pmdasite
                        LEFT OUTER JOIN pmdp_t ON pmdbdocno = pmdp003 AND pmdbseq = pmdp004 AND pmdbent = pmdpent AND pmdbsite = pmdpsite
                        LEFT OUTER JOIN pmdl_t ON pmdpdocno = pmdldocno AND pmdpent = pmdlent AND pmdpsite = pmdlsite AND pmdlstus IN ('C','Y') 
           WHERE pmdb004 = sr.imaa001 
             AND pmdaent = g_enterprise 
             AND pmdasite = g_site
             AND pmdastus IN ('C','Y')
             AND (pmdadocdt BETWEEN tm.bdate AND tm.edate)
           GROUP BY pmdadocno,pmdadocdt
           ORDER BY l_num desc)
           WHERE rownum = 1
           GROUP BY l_num
           LET sr.l_act_set = l_tmp1
#          IF NOT cl_null(l_date1) AND NOT cl_null(l_date2) AND (sr.l_act_set >= l_imaf171 + tm.days OR sr.l_act_set <= l_imaf171 - tm.days) THEN
          IF (sr.l_act_set >= l_imaf171 + tm.days OR sr.l_act_set <= l_imaf171 - tm.days) THEN
             EXECUTE insert_prep USING sr.imaa001,sr.l_imaal003,sr.l_imaal004,sr.l_imaa009_desc,sr.l_imaf141_desc,sr.l_imaf142_desc,sr.l_chk_item,l_imaf171,sr.l_act_set
          END IF
          LET sr.l_act_set = NULL
       #采购交货前置时间 imaf172----收货单单据日期pmdsdocdt-采购单单据日期pmdldocdt
          LET sr.l_chk_item = aimr130_x01_get_item_desc('imaf172')
#          LET l_date2 = l_date1              #采购单单据日期
#          LET l_date1 = NULL
#          SELECT pmdsdocdt INTO l_date1      #收货单单据日期 
#            FROM (SELECT pmdsdocdt 
#            FROM pmds_t LEFT OUTER JOIN pmdt_t ON pmdsdocno = pmdtdocno AND pmdsent = pmdtent
#           WHERE pmdt006 = sr.imaa001 
#             AND pmdsent = g_enterprise 
#             AND pmdsstus IN ('C','Y')
#             AND pmds000 = '1'
#             AND (pmdsdocdt BETWEEN tm.bdate AND tm.edate)
#           ORDER BY pmdsdocdt desc)
#           WHERE rownum = 1
#          LET sr.l_act_set = l_date1-l_date2
          SELECT MAX(COALESCE(l_num1,0) ) INTO l_tmp1      #收货单单据日期 
            FROM (SELECT pmdldocno,MAX(b.pmdsdocdt),pmdldocdt,COALESCE(MAX(b.pmdsdocdt)-pmdldocdt,0) AS l_num1
            FROM pmdl_t LEFT OUTER JOIN pmdn_t ON pmdndocno = pmdldocno AND pmdnent = pmdlent AND pmdnsite = pmdlsite
                        LEFT OUTER JOIN pmdt_t ON pmdt001 = pmdndocno AND pmdt002 = pmdnseq AND pmdtent = pmdnent AND pmdtsite = pmdnsite
                        LEFT OUTER JOIN pmds_t b ON pmdtdocno = b.pmdsdocno AND b.pmdsent = pmdtent AND b.pmdssite = pmdtsite AND b.pmds000 = '1' AND b.pmdsstus = 'Y'
#                        LEFT OUTER JOIN pmds_t a ON pmdtdocno = a.pmdsdocno AND a.pmdsent = pmdtent AND a.pmdssite = pmdtsite AND a.pmds000 = '3' AND a.pmdsstus IN ('S','Y')
           WHERE pmdn001 = sr.imaa001 
             AND pmdlent = g_enterprise 
             AND pmdlsite = g_site
             AND (pmdldocdt BETWEEN tm.bdate AND tm.edate)
           GROUP BY pmdldocno,pmdldocdt
           ORDER BY l_num1,l_num2 desc)
           WHERE rownum = 1
           GROUP BY l_num1
          LET sr.l_act_set = l_tmp1
#           LET sr.l_act_set = sr.l_act_set USING '#######'
#          IF NOT cl_null(l_date1) AND NOT cl_null(l_date2) AND (sr.l_act_set >= l_imaf172 + tm.days OR sr.l_act_set <= l_imaf172 - tm.days) THEN
#          IF sr.l_act_set <= l_imaf172 + tm.days AND sr.l_act_set >= l_imaf172 - tm.days THEN
          IF (sr.l_act_set >= l_imaf172 + tm.days OR sr.l_act_set <= l_imaf172 - tm.days) THEN
             EXECUTE insert_prep USING sr.imaa001,sr.l_imaal003,sr.l_imaal004,sr.l_imaa009_desc,sr.l_imaf141_desc,sr.l_imaf142_desc,sr.l_chk_item,l_imaf172,sr.l_act_set
          END IF
          LET sr.l_act_set = NULL
       #采购入库前置时间 imaf174----入库单单据日期pmdsdocdt-收货单单据日期pmdsdocdt
          LET sr.l_chk_item = aimr130_x01_get_item_desc('imaf174')
#          LET l_date2 = l_date1              #收货单单据日期 
#          LET l_date1 = NULL
#          SELECT pmdsdocdt INTO l_date1      #入库单单据日期 
#            FROM (SELECT pmdsdocdt 
#            FROM pmds_t LEFT OUTER JOIN pmdt_t ON pmdsdocno = pmdtdocno AND pmdsent = pmdtent
#           WHERE pmdt006 = sr.imaa001 
#             AND pmdsent = g_enterprise 
#             AND pmdsstus IN ('C','Y')
#             AND pmds000 = '3'
#             AND (pmdsdocdt BETWEEN tm.bdate AND tm.edate)
#           ORDER BY pmdsdocdt desc)
#           WHERE rownum = 1
#          LET sr.l_act_set = l_date1-l_date2
           SELECT MAX(COALESCE(l_num1,0) ),MAX(COALESCE(l_num2,0)) INTO l_tmp1,l_tmp2      #收货单单据日期 
            FROM (SELECT pmdldocno,MAX(b.pmdsdocdt),pmdldocdt,COALESCE(MAX(b.pmdsdocdt)-pmdldocdt,0) AS l_num1,MAX(b.pmdsdocdt),COALESCE(MAX(a.pmdsdocdt)-MAX(b.pmdsdocdt),0) AS l_num2
            FROM pmdl_t LEFT OUTER JOIN pmdn_t ON pmdndocno = pmdldocno AND pmdnent = pmdlent AND pmdnsite = pmdlsite
                        LEFT OUTER JOIN pmdt_t ON pmdt001 = pmdndocno AND pmdt002 = pmdnseq AND pmdtent = pmdnent AND pmdtsite = pmdnsite
                        LEFT OUTER JOIN pmds_t b ON pmdtdocno = b.pmdsdocno AND b.pmdsent = pmdtent AND b.pmdssite = pmdtsite AND b.pmds000 IN ('1','2') AND b.pmdsstus = 'Y'
                        LEFT OUTER JOIN pmds_t a ON pmdtdocno = a.pmdsdocno AND a.pmdsent = pmdtent AND a.pmdssite = pmdtsite AND a.pmds000 = '6' AND a.pmdsstus IN ('S','Y')            
           WHERE pmdn001 = sr.imaa001 
             AND pmdlent = g_enterprise 
             AND pmdlsite = g_site
             AND (pmdldocdt BETWEEN tm.bdate AND tm.edate)
           GROUP BY pmdldocno,pmdldocdt
           ORDER BY l_num1,l_num2 desc)
           WHERE rownum = 1
           GROUP BY l_num1,l_num2
          LET sr.l_act_set = l_tmp2
#          LET sr.l_act_set = sr.l_act_set USING '########'
#          IF NOT cl_null(l_date1) AND NOT cl_null(l_date2) AND (sr.l_act_set >= l_imaf174 + tm.days OR sr.l_act_set <= l_imaf174 - tm.days) THEN
#          IF sr.l_act_set <= l_imaf174 + tm.days AND sr.l_act_set >= l_imaf174 - tm.days THEN
          IF (sr.l_act_set >= l_imaf174 + tm.days OR sr.l_act_set <= l_imaf174 - tm.days) THEN
             EXECUTE insert_prep USING sr.imaa001,sr.l_imaal003,sr.l_imaal004,sr.l_imaa009_desc,sr.l_imaf141_desc,sr.l_imaf142_desc,sr.l_chk_item,l_imaf174,sr.l_act_set
          END IF
       END IF
       LET sr.l_act_set = NULL
       #主要供应商 imaf153----次数最多的供应商
       IF tm.pr2 = "Y" THEN
          LET sr.l_chk_item = aimr130_x01_get_item_desc('imaf153')
          LET l_sql = " SELECT pmdl004,COUNT(pmdl004) ",
                      " FROM pmdl_t LEFT OUTER JOIN pmdn_t ON pmdndocno = pmdldocno AND pmdnent = pmdlent AND pmdnsite= pmdlsite ",
                      " WHERE pmdn001 = '",sr.imaa001 CLIPPED,"' ",
                      " AND pmdlent = ",g_enterprise ,
                      " AND pmdlsite = '",g_site ,"' ",
                      " AND pmdlstus IN ('C','Y') ",
                      " AND (pmdldocdt BETWEEN to_date('",tm.bdate,"','yy-mm-dd') AND to_date('",tm.edate,"','yy-mm-dd'))",
                      " GROUP BY pmdl004 ",
                      " ORDER BY COUNT(*) desc "
          PREPARE aimr130_imaf153_pre FROM l_sql
          DECLARE aimr130_imaf153_cs SCROLL CURSOR FOR aimr130_imaf153_pre
          OPEN aimr130_imaf153_cs
          FETCH FIRST aimr130_imaf153_cs INTO sr.l_act_set,l_count
          IF tm.show = "Y" THEN
             IF sr.l_act_set <> l_imaf153 OR (cl_null(l_imaf153) AND NOT cl_null(sr.l_act_set)) THEN
                LET sr.l_act_set = aimr130_x01_get_desc(sr.l_act_set)
                LET l_imaf153 = aimr130_x01_get_desc(l_imaf153)
                EXECUTE insert_prep USING sr.imaa001,sr.l_imaal003,sr.l_imaal004,sr.l_imaa009_desc,sr.l_imaf141_desc,sr.l_imaf142_desc,sr.l_chk_item,l_imaf153,sr.l_act_set
             END IF
          ELSE
             IF NOT cl_null(sr.l_act_set) THEN
                LET sr.l_act_set = aimr130_x01_get_desc(sr.l_act_set)
                LET l_imaf153 = aimr130_x01_get_desc(l_imaf153)
                EXECUTE insert_prep USING sr.imaa001,sr.l_imaal003,sr.l_imaal004,sr.l_imaa009_desc,sr.l_imaf141_desc,sr.l_imaf142_desc,sr.l_chk_item,l_imaf153,sr.l_act_set
             END IF
          END IF
       END IF
       LET sr.l_act_set = NULL
       #最小采购批量 imaf146----最小收货数量
       IF tm.pr3 = "Y" THEN
          LET sr.l_chk_item = aimr130_x01_get_item_desc('imaf146')
          SELECT pmdt020 INTO sr.l_act_set      #收货单单据日期 
            FROM (SELECT pmdt020
            FROM pmds_t LEFT OUTER JOIN pmdt_t ON pmdsdocno = pmdtdocno AND pmdsent = pmdtent AND pmdssite = pmdtsite
           WHERE pmdt006 = sr.imaa001 
             AND pmdsent = g_enterprise 
             AND pmdssite = g_site
             AND pmdsstus IN ('S','Y')
             AND pmds000 IN ('1','2','3','4')
             AND (pmdsdocdt BETWEEN tm.bdate AND tm.edate)
           ORDER BY pmdt020 asc)
           WHERE rownum = 1
           IF sr.l_act_set >= l_imaf146*(100+tm.rate)/100 OR sr.l_act_set <= l_imaf146*(100-tm.rate)/100 THEN
              EXECUTE insert_prep USING sr.imaa001,sr.l_imaal003,sr.l_imaal004,sr.l_imaa009_desc,sr.l_imaf141_desc,sr.l_imaf142_desc,sr.l_chk_item,l_imaf146,sr.l_act_set
           END IF
       END IF
       LET sr.l_act_set = NULL
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       CONTINUE FOREACH
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.imaa001,sr.l_imaal003,sr.l_imaal004,sr.l_imaa009_desc,sr.l_imaf141_desc,sr.l_imaf142_desc,sr.l_chk_item,sr.l_cur_set,sr.l_act_set
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "aimr130_x01_execute"
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
 
{<section id="aimr130_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION aimr130_x01_rep_data()
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
 
{<section id="aimr130_x01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 获取检核项目名称
# Memo...........:
# Usage..........: CALL aimr130_x01_get_item_desc(p_item)
#                  RETURNING r_desc
# Date & Author..: 2015-12-22 By zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION aimr130_x01_get_item_desc(p_item)
DEFINE p_item  LIKE type_t.chr50
DEFINE r_desc  LIKE oocql_t.oocql004

   LET r_desc = NULL
   IF cl_null(p_item) THEN 
      RETURN r_desc
   END IF
   
   SELECT dzebl003 INTO r_desc
     FROM dzebl_t
    WHERE dzebl001 = p_item
      AND dzebl002 = g_dlang
   
   RETURN r_desc
END FUNCTION

################################################################################
# Descriptions...: 获取供应商名称
################################################################################
PRIVATE FUNCTION aimr130_x01_get_desc(p_item)
DEFINE p_item  LIKE type_t.chr100
DEFINE r_desc  LIKE type_t.chr100

   LET r_desc = NULL
   IF cl_null(p_item) THEN 
      RETURN r_desc
   END IF
   
   SELECT pmaal003 INTO r_desc
     FROM pmaal_t
    WHERE pmaal001 = p_item
      AND pmaal002 = g_dlang
      AND pmaalent = g_enterprise
   
   LET r_desc = p_item CLIPPED,'.',r_desc CLIPPED
   
   RETURN r_desc
END FUNCTION

 
{</section>}
 
