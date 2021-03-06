#該程式未解開Section, 採用最新樣板產出!
{<section id="apsr600_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:6(2016-06-15 23:00:11), PR版次:0006(2016-06-15 23:06:25)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000083
#+ Filename...: apsr600_x01
#+ Description: ...
#+ Creator....: 05231(2014-07-16 17:30:17)
#+ Modifier...: 03079 -SD/PR- 03079
 
{</section>}
 
{<section id="apsr600_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#160503-00030#22  2016/05/23 By shiun     效能改善 
#160614-00029#1   2016/06/15 By ming      增加保稅欄位(pspc062)在需求日期前
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
       wc STRING                   #where conditon
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="apsr600_x01.main" readonly="Y" >}
PUBLIC FUNCTION apsr600_x01(p_arg1)
DEFINE  p_arg1 STRING                  #tm.wc  where conditon
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "apsr600_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL apsr600_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL apsr600_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL apsr600_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL apsr600_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL apsr600_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="apsr600_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION apsr600_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "pspc050.pspc_t.pspc050,l_imaal003.type_t.chr80,l_imaal004.type_t.chr80,pspc051.pspc_t.pspc051,pspc043.pspc_t.pspc043,pspc014.pspc_t.pspc014,pspc062.pspc_t.pspc062,pspc045.pspc_t.pspc045,pspc010.pspc_t.pspc010,pspc018.pspc_t.pspc018,l_imaf016_desc.oocql_t.oocql004,l_bmif009_desc.oocql_t.oocql004,l_bmif012.bmif_t.bmif012,pspc054.pspc_t.pspc054,pspc061.pspc_t.pspc061" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="apsr600_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION apsr600_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?)"
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
 
{<section id="apsr600_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apsr600_x01_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define(客製用) name="sel_prep.define_customerization"

#end add-point
#add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
DEFINE l_pspc002     LIKE pspc_t.pspc002
#end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
 
   #add-point:sel_prep g_select name="sel_prep.g_select"
   ##160614-00029#1 20160615 modify by ming -----(S) 
   #mod--160503-00030#22 By shiun--(S)
   ##LET g_select =" SELECT  a.pspc050,f.imaal003,f.imaal004,a.pspc051,a.pspc043,a.pspc014,a.pspc045,a.pspc010,a.pspc018, ",
   ##              "         '','','',a.pspc054,a.pspc061 "
   #LET g_select =" SELECT  a.pspc050,f.imaal003,f.imaal004,a.pspc051,a.pspc043,d.imaf143,a.pspc045,a.pspc010,a.pspc018, ", 
   #              "         g.oocql004,'','',a.pspc054,a.pspc061 " 
   ##mod--160503-00030#22 By shiun--(E) 
   LET g_select =" SELECT  a.pspc050,f.imaal003,f.imaal004,a.pspc051,a.pspc043,d.imaf143, ", 
                 "         COALESCE(a.pspc062,'N'),a.pspc045,a.pspc010,a.pspc018, ", 
                 "         g.oocql004,'','',a.pspc054,a.pspc061 " 
   #160614-00029#1 20160615 modify by ming -----(E) 
#   #end add-point
#   LET g_select = " SELECT pspc050,'','',pspc051,pspc043,pspc014,pspc062,pspc045,pspc010,pspc018,'', 
#       '','',pspc054,pspc061"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_from =
       "  FROM  pspc_t a LEFT JOIN imae_t  c ON c.imaeent =a.pspcent AND c.imaesite=a.pspcsite AND c.imae001=a.pspc050        ",
       "                 LEFT JOIN imaf_t  d ON d.imafent =a.pspcent AND d.imafsite=a.pspcsite AND d.imaf001=a.pspc050        ",
       "                 LEFT JOIN imaa_t  e ON e.imaaent =a.pspcent AND e.imaa001 =a.pspc050                                 ",
       "                 LEFT JOIN imaal_t f ON f.imaalent=a.pspcent AND f.imaal001=a.pspc050  AND f.imaal002='",g_dlang,"'  ",               
       "                 LEFT JOIN oocql_t g ON g.oocqlent=a.pspcent AND g.oocql001='210'  AND g.oocql002=d.imaf016 AND g.oocql003='",g_dlang,"',  ",   #add--160503-00030#22 By shiun
       " ( SELECT pspcent,pspcsite,pspc001,max(pspc002) AS pspc002 FROM pspc_t GROUP BY pspcent,pspcsite,pspc001 ) b          "
#   #end add-point
#    LET g_from = " FROM pspc_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET g_where = " WHERE " ,tm.wc CLIPPED," AND  a.pspcent = b.pspcent AND  a.pspcsite = b.pspcsite ",
                                          " AND  a.pspc001 = b.pspc001 AND  a.pspc002 = b.pspc002  AND a.pspc007 = 1"
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("pspc_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE apsr600_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE apsr600_x01_curs CURSOR FOR apsr600_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="apsr600_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION apsr600_x01_ins_data()
DEFINE sr RECORD 
   pspc050 LIKE pspc_t.pspc050, 
   l_imaal003 LIKE type_t.chr80, 
   l_imaal004 LIKE type_t.chr80, 
   pspc051 LIKE pspc_t.pspc051, 
   pspc043 LIKE pspc_t.pspc043, 
   pspc014 LIKE pspc_t.pspc014, 
   pspc062 LIKE pspc_t.pspc062, 
   pspc045 LIKE pspc_t.pspc045, 
   pspc010 LIKE pspc_t.pspc010, 
   pspc018 LIKE pspc_t.pspc018, 
   l_imaf016_desc LIKE oocql_t.oocql004, 
   l_bmif009_desc LIKE oocql_t.oocql004, 
   l_bmif012 LIKE bmif_t.bmif012, 
   pspc054 LIKE pspc_t.pspc054, 
   pspc061 LIKE pspc_t.pspc061
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
   DEFINE l_cnt      LIKE type_t.num5 
   DEFINE l_bmif009  LIKE bmif_t.bmif009 
   DEFINE l_bmif011  LIKE bmif_t.bmif011 
   DEFINE l_imaf016  LIKE imaf_t.imaf016 
   DEFINE l_sql      STRING  
   
   #151116-00010#2 20151117 modify by ming -----(S) 
   DEFINE l_imaf143  LIKE imaf_t.imaf143
   DEFINE l_success  LIKE type_t.num5
   #151116-00010#2 20151117 modify by ming -----(E) 
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH apsr600_x01_curs INTO sr.*                               
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
       
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       #生命週期狀態 
       #mark--160503-00030#22 By shiun--(S)
#       LET l_imaf016 = '' 
#       SELECT imaf016 INTO l_imaf016 
#         FROM imaf_t 
#        WHERE imafent  = g_enterprise 
#          AND imafsite = g_site 
#          AND imaf001  = sr.pspc050 
#       CALL s_desc_get_acc_desc('210',l_imaf016) RETURNING sr.l_imaf016_desc  
       #mark--160503-00030#22 By shiun--(E)
       
       #承認狀態  
       LET l_bmif011 = '' 
       SELECT MAX(bmif011) INTO l_bmif011 
         FROM bmif_t 
        WHERE bmifent = g_enterprise 
          AND bmif001 = sr.pspc050 
       
       LET l_cnt = 0 
       SELECT COUNT(*) INTO l_cnt 
         FROM bmif_t 
        WHERE bmifent = g_enterprise 
          AND bmif001 = sr.pspc050 
          AND bmif011 = l_bmif011  
          
       LET l_sql = "SELECT bmif009,bmif012 ", 
                   "  FROM bmif_t ", 
                   " WHERE bmifent = '",g_enterprise,"' ", 
                   "   AND bmif001 = '",sr.pspc050,"' ", 
                   "   AND bmif011 = '",l_bmif011,"' " 
       IF l_cnt > 1 THEN 
          LET l_sql = l_sql ," AND bmifmoddt = (SELECT MAX(bmifmoddt) ", 
                             "                    FROM bmif_t ",  
                             "                   WHERE bmifent = '",g_enterprise,"' ", 
                             "                     AND bmif001 = '",sr.pspc050,"' ", 
                             "                     AND bmif011 = '",l_bmif011,"') " 
       END IF  
       
       LET l_bmif009 = '' 
       PREPARE apsr600_x01_get_bmif_prep FROM l_sql 
       EXECUTE apsr600_x01_get_bmif_prep INTO l_bmif009,sr.l_bmif012  
       
       CALL s_desc_get_acc_desc('1116',l_bmif009) RETURNING sr.l_bmif009_desc 
       
       #151124-00006#2 20151124 modify by ming -----(S) 
       #由於數量本身就已經有先被轉成採購單位的數量，只是單位的顯示是基礎單位 
       #所以就不必做單位的數量轉換 
       ##151116-00010#2 20151117 modify by ming -----(S) 
       #LET l_imaf143 = ''
       #SELECT imaf143 INTO l_imaf143
       #  FROM imaf_t
       # WHERE imafent  = g_enterprise
       #   AND imafsite = g_site
       #   AND imaf001  = sr.pspc050
       #IF (NOT cl_null(l_imaf143)) AND
       #   (NOT cl_null(sr.pspc014)) THEN
       #   #建議開立量 
       #   CALL s_aooi250_convert_qty(sr.pspc050,sr.pspc014,l_imaf143,sr.pspc043)
       #        RETURNING l_success,sr.pspc043
       #
       #   #已轉數量  
       #   CALL s_aooi250_convert_qty(sr.pspc050,sr.pspc014,l_imaf143,sr.pspc061)
       #        RETURNING l_success,sr.pspc061
       #
       #   LET sr.pspc014 = l_imaf143
       #END IF
       ##151116-00010#2 20151117 modify by ming -----(E) 
       #mark--160503-00030#22 By shiun--(S)
#       LET l_imaf143 = ''
#       SELECT imaf143 INTO l_imaf143
#         FROM imaf_t
#        WHERE imafent  = g_enterprise
#          AND imafsite = g_site
#          AND imaf001  = sr.pspc050 
#       LET sr.pspc014 = l_imaf143
       #mark--160503-00030#22 By shiun--(E)
       #151124-00006#2 20151124 modify by ming -----(E) 
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.pspc050,sr.l_imaal003,sr.l_imaal004,sr.pspc051,sr.pspc043,sr.pspc014,sr.pspc062,sr.pspc045,sr.pspc010,sr.pspc018,sr.l_imaf016_desc,sr.l_bmif009_desc,sr.l_bmif012,sr.pspc054,sr.pspc061
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "apsr600_x01_execute"
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
 
{<section id="apsr600_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION apsr600_x01_rep_data()
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
 
{<section id="apsr600_x01.other_function" readonly="Y" >}

 
{</section>}
 
