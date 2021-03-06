#該程式未解開Section, 採用最新樣板產出!
{<section id="apsr001_x02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2015-01-23 17:55:18), PR版次:0001(2014-11-18 11:14:32)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000040
#+ Filename...: apsr001_x02
#+ Description: ...
#+ Creator....: 05231(2014-07-30 11:01:28)
#+ Modifier...: 05384 -SD/PR- 05384
 
{</section>}
 
{<section id="apsr001_x02.global" readonly="Y" >}
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
       chk01 LIKE type_t.chr1          #列印原始需求
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="apsr001_x02.main" readonly="Y" >}
PUBLIC FUNCTION apsr001_x02(p_arg1,p_arg2)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr1         #tm.chk01  列印原始需求
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.chk01 = p_arg2
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "apsr001_x02"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL apsr001_x02_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL apsr001_x02_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL apsr001_x02_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL apsr001_x02_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL apsr001_x02_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="apsr001_x02.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION apsr001_x02_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "pspa012.pspa_t.pspa012,l_imaal003.imaal_t.imaal003,l_imaal004.imaal_t.imaal004,pspa013.pspa_t.pspa013,l_imaa006.imaa_t.imaa006,l_imaf013_desc.gzcbl_t.gzcbl004,pspa011.pspa_t.pspa011,l_pspa020_desc.gzcbl_t.gzcbl004,pspa009.pspa_t.pspa009,l_qty.type_t.num20_6,pspa006.pspa_t.pspa006,pspa017.pspa_t.pspa017" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
#   LET g_sql = "psph007.psph_t.psph007,",                                       
#               "psph009.psph_t.psph009 "                                       
#   IF NOT cl_xg_create_tmptable(g_sql,2) THEN
#      LET g_rep_success = 'N'
#   END IF
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="apsr001_x02.ins_prep" readonly="Y" >}
PRIVATE FUNCTION apsr001_x02_ins_prep()
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
             ?,?,?,?,?,?)"
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
#         WHEN 2
#         LET g_sql = " INSERT INTO ",g_rep_db CLIPPED,g_rep_tmpname[2] CLIPPED," VALUES(?,?)"
#         PREPARE insert_prep1 FROM g_sql
#         IF STATUS THEN
#            LET l_prep_str ="insert_prep1",i
#            INITIALIZE g_errparam TO NULL
#            LET g_errparam.extend = l_prep_str
#            LET g_errparam.code   = status
#            LET g_errparam.popup  = TRUE
#            CALL cl_err()
#            CALL cl_xg_drop_tmptable()
#            LET g_rep_success = 'N'
#         END IF
         #end add-point                  
 
 
      END CASE
   END FOR
END FUNCTION
 
{</section>}
 
{<section id="apsr001_x02.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apsr001_x02_sel_prep()
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
   LET g_select =
       " SELECT c.pspa012,g.imaal003,g.imaal004,c.pspa013,d.imaa006,h.gzcbl004,c.pspa011,i.gzcbl004,c.pspa009,0,c.pspa006,c.pspa017,c.pspa020,c.pspa001,c.pspa002,c.pspaent,c.pspasite "
#   #end add-point
#   LET g_select = " SELECT pspa012,'','',pspa013,'','',pspa011,'',pspa009,'',pspa006,pspa017,pspa020, 
#       pspa001,pspa002,pspaent,pspasite"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_from =
       " FROM psca_t a , ",
       " ( SELECT pspaent,pspasite,pspa001,MAX(pspa002) AS pspa002 FROM pspa_t GROUP BY pspaent,pspasite,pspa001) b ",
       "     LEFT JOIN pspa_t  c ON c.pspaent =b.pspaent AND c.pspasite=b.pspasite AND c.pspa001=b.pspa001 AND c.pspa002=b.pspa002 ",
       "     LEFT JOIN imaa_t  d ON d.imaaent =c.pspaent AND d.imaa001 =c.pspa012 ",
       "     LEFT JOIN imaf_t  e ON e.imafent =c.pspaent AND e.imaf001 =c.pspa012 AND e.imafsite=c.pspasite ",
       "     LEFT JOIN imae_t  f ON f.imaeent =c.pspaent AND f.imae001 =c.pspa012 AND f.imaesite=c.pspasite ",
       "     LEFT JOIN imaal_t g ON g.imaalent=c.pspaent AND g.imaal001=c.pspa012 AND g.imaal002='",g_dlang,"' ",
       "     LEFT JOIN gzcbl_t h ON h.gzcbl001='2022'    AND h.gzcbl002=e.imaf013 AND h.gzcbl003='",g_dlang,"' ",
       "     LEFT JOIN gzcbl_t i ON i.gzcbl001='5440'    AND i.gzcbl002=c.pspa020 AND i.gzcbl003='",g_dlang,"' "
#   #end add-point
#    LET g_from = " FROM pspa_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET g_where = "WHERE a.pscaent=b.pspaent AND a.pscasite=b.pspasite AND a.psca001=b.pspa001 AND ",tm.wc CLIPPED
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("pspa_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = g_sql CLIPPED," ORDER BY pspa012,pspa013,pspa011 "
   #end add-point
   PREPARE apsr001_x02_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE apsr001_x02_curs CURSOR FOR apsr001_x02_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="apsr001_x02.ins_data" readonly="Y" >}
PRIVATE FUNCTION apsr001_x02_ins_data()
DEFINE sr RECORD 
   pspa012 LIKE pspa_t.pspa012, 
   l_imaal003 LIKE imaal_t.imaal003, 
   l_imaal004 LIKE imaal_t.imaal004, 
   pspa013 LIKE pspa_t.pspa013, 
   l_imaa006 LIKE imaa_t.imaa006, 
   l_imaf013_desc LIKE gzcbl_t.gzcbl004, 
   pspa011 LIKE pspa_t.pspa011, 
   l_pspa020_desc LIKE gzcbl_t.gzcbl004, 
   pspa009 LIKE pspa_t.pspa009, 
   l_qty LIKE type_t.num20_6, 
   pspa006 LIKE pspa_t.pspa006, 
   pspa017 LIKE pspa_t.pspa017, 
   pspa020 LIKE pspa_t.pspa020, 
   pspa001 LIKE pspa_t.pspa001, 
   pspa002 LIKE pspa_t.pspa002, 
   pspaent LIKE pspa_t.pspaent, 
   pspasite LIKE pspa_t.pspasite
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE sr1   RECORD
   psph007       LIKE psph_t.psph007,
   psph009       LIKE psph_t.psph009
END RECORD
DEFINE l_sum     LIKE type_t.num20_6 
DEFINE l_pspa012 LIKE pspa_t.pspa012 #run過的舊料號
DEFINE l_count   INTEGER
DEFINE l_sql     STRING
DEFINE l_pspa013 LIKE pspa_t.pspa013
DEFINE l_pspa012_o LIKE pspa_t.pspa012
DEFINE l_pspa013_o LIKE pspa_t.pspa013
DEFINE l_gzcb003 LIKE gzcb_t.gzcb003
DEFINE l_psph002 LIKE psph_t.psph002
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH apsr001_x02_curs INTO sr.*                               
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
       LET l_gzcb003 = 1
       SELECT gzcb003 INTO l_gzcb003 FROM gzcb_t
        WHERE gzcb001 = '5440'
          AND gzcb002 = sr.pspa020
       IF cl_null(l_gzcb003) THEN 
          LET l_gzcb003 = 1 
       END IF
       LET sr.pspa009 = sr.pspa009 * l_gzcb003
       IF cl_null(sr.pspa013) THEN
          LET sr.pspa013 = ' '
       END IF
       IF l_count = 1 THEN    
          LET l_sum = 0       
          LET sr.l_qty = l_sum + sr.pspa009
          LET l_sum = sr.l_qty         
          LET l_pspa012 = sr.pspa012
          LET l_pspa013 = sr.pspa013
       ELSE
          IF l_pspa012 = sr.pspa012 AND l_pspa013 = sr.pspa013 THEN
             LET sr.l_qty = l_sum + sr.pspa009
             LET l_sum = sr.l_qty            
          ELSE
               LET l_sum = 0
               LET sr.l_qty = l_sum + sr.pspa009
               LET l_sum = sr.l_qty  
               LET l_pspa012 = sr.pspa012
               LET l_pspa013 = sr.pspa013
          END IF
       END IF
       LET l_count = l_count + 1
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.pspa012,sr.l_imaal003,sr.l_imaal004,sr.pspa013,sr.l_imaa006,sr.l_imaf013_desc,sr.pspa011,sr.l_pspa020_desc,sr.pspa009,sr.l_qty,sr.pspa006,sr.pspa017
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "apsr001_x02_execute"
          LET g_errparam.code   = SQLCA.sqlcode
          LET g_errparam.popup  = FALSE
          CALL cl_err()       
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF
 
       #add-point:ins_data段after_save name="ins_data.after.save"
#       IF tm.chk01 = 'Y' THEN   #要列印原始需求單號
#          LET l_sql = " SELECT DISTINCT psph007,psph009 ",
#                      "   FROM psph_t ",
#                      "  WHERE psphent = ",sr.pspaent,
#                      "    AND psphsite = '",sr.pspasite,"'",
#                      "    AND psph001 = '",sr.pspa001,"'",
#                      "    AND psph002 = '",sr.pspa002,"'",
#                      "    AND psph007 = '",sr.pspa006,"'"               
#          DECLARE apsr001_x01_repcur CURSOR FROM l_sql
#          FOREACH apsr001_x01_repcur INTO sr1.*         
#             EXECUTE insert_prep1 USING sr1.psph007,sr1.psph009
#             IF SQLCA.sqlcode THEN
#                INITIALIZE g_errparam TO NULL
#                LET g_errparam.extend = "apsr001_x01_execute1"
#                LET g_errparam.code   = SQLCA.sqlcode
#                LET g_errparam.popup  = FALSE
#                CALL cl_err()
#                LET g_rep_success = 'N'
#                EXIT FOREACH
#             END IF
#          END FOREACH
#       END IF
       #end add-point
       
    END FOREACH
    
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apsr001_x02.rep_data" readonly="Y" >}
PRIVATE FUNCTION apsr001_x02_rep_data()
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
 
{<section id="apsr001_x02.other_function" readonly="Y" >}

 
{</section>}
 
