#該程式未解開Section, 採用最新樣板產出!
{<section id="apsr007_x02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:5(2016-06-16 18:01:13), PR版次:0005(2016-06-20 17:12:51)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000050
#+ Filename...: apsr007_x02
#+ Description: ...
#+ Creator....: 05384(2015-05-25 09:34:33)
#+ Modifier...: 06821 -SD/PR- 06821
 
{</section>}
 
{<section id="apsr007_x02.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#160503-00030#20  160617  By 06821   效能調整
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
       wc STRING                   #where condition
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="apsr007_x02.main" readonly="Y" >}
PUBLIC FUNCTION apsr007_x02(p_arg1)
DEFINE  p_arg1 STRING                  #tm.wc  where condition
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
   LET g_rep_code = "apsr007_x02"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL apsr007_x02_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL apsr007_x02_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL apsr007_x02_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL apsr007_x02_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL apsr007_x02_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="apsr007_x02.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION apsr007_x02_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "psoz038.psoz_t.psoz038,l_imaal003.imaal_t.imaal003,l_imaal004.imaal_t.imaal004,psoz039.psoz_t.psoz039,l_imecl005.imecl_t.imecl005,l_imaa006.imaa_t.imaa006,l_imaf013_desc.gzcbl_t.gzcbl004,l_order.psoz_t.psoz005,psoz012.psoz_t.psoz012,psoz014.psoz_t.psoz014,psoz018.psoz_t.psoz018,psoz021.psoz_t.psoz021,psoz022.psoz_t.psoz022,l_psoz019_psoz041.psoz_t.psoz019,l_psoz024_psoz025.psoz_t.psoz024,l_substitute.psoz_t.psoz009,psoz036.psoz_t.psoz036,l_production.psoz_t.psoz032,l_purchase.psoz_t.psoz032,psoz037.psoz_t.psoz037" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="apsr007_x02.ins_prep" readonly="Y" >}
PRIVATE FUNCTION apsr007_x02_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="apsr007_x02.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apsr007_x02_sel_prep()
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
   #20151105 by stellar modify 151105-00005#1 ----- (S)
#   LET g_select = " SELECT c.psoz038,x.imaal003,x.imaal004,c.psoz039,'',y.imaa006,z.imaf013,'',to_char(c.psoz004,'yyyy-mm-dd'),'',c.psoz005,c.psoz006,c.psoz007,c.psoz012,c.psoz014, 
#       c.psoz018,c.psoz021,c.psoz022,'',c.psoz019,c.psoz041,'',c.psoz024,c.psoz025,'',c.psoz009,c.psoz010,c.psoz013,c.psoz015, 
#       c.psoz020,c.psoz026,c.psoz027,c.psoz028,c.psoz031,c.psoz029,c.psoz030,c.psoz036,'','',c.psoz032,c.psoz033,c.psoz034, 
#       c.psoz035,c.psoz037,c.psoz001,c.psoz002,c.psozsite,c.psozent"
   #160503-00030#20 --s mark
   #LET g_select = " SELECT c.psoz038,x.imaal003,x.imaal004,c.psoz039,'',y.imaa006,z.imaf013,'',to_char(c.psoz004,'yyyy-mm-dd'),'',c.psoz005,c.psoz006,c.psoz007,c.psoz012,c.psoz014, 
   #    c.psoz018,c.psoz021,c.psoz022,'',c.psoz019,c.psoz041,'',c.psoz024,c.psoz025,'',c.psoz009,c.psoz010,c.psoz013,c.psoz015, 
   #    c.psoz020,c.psoz026,c.psoz027,c.psoz028,c.psoz036,'','',c.psoz032,c.psoz033,c.psoz034, 
   #    c.psoz035,c.psoz037,c.psoz001,c.psoz002,c.psozsite,c.psozent"
   #160503-00030#20 --e mark
   #20151105 by stellar modify 151105-00005#1 ----- (S)
   
   #160503-00030#20 --s add
   LET g_select = " SELECT c.psoz038,",
                  "        (SELECT imaal003 FROM imaal_t WHERE imaalent = c.psozent AND imaal001 = c.psoz038 AND imaal002 = '",g_dlang,"' ),",
                  "        (SELECT imaal004 FROM imaal_t WHERE imaalent = c.psozent AND imaal001 = c.psoz038 AND imaal002 = '",g_dlang,"' ),",
                  "        c.psoz039, ", 
                  "        (SELECT inaml004 FROM inaml_t WHERE inamlent = c.psozent AND inaml001 = c.psoz038 AND inaml002 = c.psoz039 AND inaml003 = '",g_dlang,"'), ", 
                  "        (SELECT imaa006 FROM imaa_t WHERE imaaent = c.psozent AND imaa001 = c.psoz038), ",
                  "        (SELECT imaf013 FROM imaf_t WHERE imafent = c.psozent AND imafsite = c.psozsite AND imaf001 = c.psoz038),",
                  "        (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '2022' AND gzcbl003 = '",g_dlang,"' ", 
                  "                                AND gzcbl002 = (SELECT imaf013 FROM imaf_t WHERE imafent = c.psozent AND imafsite = c.psozsite AND imaf001 = c.psoz038)),",
                  "        to_char(c.psoz004,'yyyy-mm-dd'),'', ", 
                  "        COALESCE(c.psoz005,0),COALESCE(c.psoz006,0),COALESCE(c.psoz007,0),COALESCE(c.psoz012,0), ", 
                  "        COALESCE(c.psoz014,0),COALESCE(c.psoz018,0),COALESCE(c.psoz021,0),COALESCE(c.psoz022,0),'', ", 
                  "        COALESCE(c.psoz019,0),COALESCE(c.psoz041,0),'', ", 
                  "        COALESCE(c.psoz024,0),COALESCE(c.psoz025,0),'', ", 
                  "        COALESCE(c.psoz009,0),COALESCE(c.psoz010,0),COALESCE(c.psoz013,0),COALESCE(c.psoz015,0), ",  
                  "        COALESCE(c.psoz020,0),COALESCE(c.psoz026,0),COALESCE(c.psoz027,0),COALESCE(c.psoz028,0), ", 
                  "        COALESCE(c.psoz036,0),0,0, ",
                  "        COALESCE(c.psoz032,0),COALESCE(c.psoz033,0),COALESCE(c.psoz034,0), ", 
                  "        COALESCE(c.psoz035,0),COALESCE(c.psoz037,0),c.psoz001,c.psoz002,c.psozsite,c.psozent"
                  
   #160503-00030#20 --e add 
#   #end add-point
#   LET g_select = " SELECT psoz038,'','',psoz039,'','','','','','',psoz005,psoz006,psoz007,psoz012,psoz014, 
#       psoz018,psoz021,psoz022,'',psoz019,psoz041,'',psoz024,psoz025,'',psoz009,psoz010,psoz013,psoz015, 
#       psoz020,psoz026,psoz027,psoz028,psoz036,'','',psoz032,psoz033,psoz034,psoz035,psoz037,psoz001, 
#       psoz002,psozsite,psozent"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   #160503-00030#20 --s mark
   #LET g_from = 
   #    " FROM psca_t a, ",
   #    "      (SELECT psozent,psozsite,psoz001,MAX(psoz002) AS psoz002 FROM psoz_t GROUP BY psozent,psozsite,psoz001) b ,",
   #    "      psoz_t c ",
   #    "      LEFT JOIN imaal_t x ON x.imaalent = c.psozent AND x.imaal001 = c.psoz038 AND x.imaal002 = '",g_dlang,"' ", 
   #    "      LEFT JOIN imaa_t y ON y.imaaent = c.psozent AND y.imaa001 = c.psoz038 ",                                   
   #    "      LEFT JOIN imaf_t z ON z.imafent = c.psozent AND z.imafsite = c.psozsite AND z.imaf001 = c.psoz038 ",       
   #    "      LEFT JOIN imae_t e ON e.imaeent = c.psozent AND e.imaesite = c.psozsite AND e.imae001 = c.psoz038 "
   #160503-00030#20 --e mark
   
   #160503-00030#20 --s add
   LET g_from = 
       " FROM psca_t a, ",
       "      (SELECT psozent,psozsite,psoz001,MAX(psoz002) AS psoz002 FROM psoz_t GROUP BY psozent,psozsite,psoz001) b ,",
       "      psoz_t c ",
       "      LEFT JOIN imae_t e ON e.imaeent = c.psozent AND e.imaesite = c.psozsite AND e.imae001 = c.psoz038 "
   #160503-00030#20 --e add
#   #end add-point
#    LET g_from = " FROM psoz_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET g_where = " WHERE " ,tm.wc CLIPPED ,
                   " AND a.pscaent = b.psozent AND a.pscasite = b.psozsite AND a.psca001 =b.psoz001 ",
                   " AND c.psozent = b.psozent AND c.psozsite = b.psozsite AND c.psoz001 = b.psoz001 ",
                   " AND c.psoz002 = b.psoz002 "
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("psoz_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = g_sql CLIPPED," ORDER BY psoz038,psoz004 "
   #end add-point
   PREPARE apsr007_x02_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE apsr007_x02_curs CURSOR FOR apsr007_x02_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="apsr007_x02.ins_data" readonly="Y" >}
PRIVATE FUNCTION apsr007_x02_ins_data()
DEFINE sr RECORD 
   psoz038 LIKE psoz_t.psoz038, 
   l_imaal003 LIKE imaal_t.imaal003, 
   l_imaal004 LIKE imaal_t.imaal004, 
   psoz039 LIKE psoz_t.psoz039, 
   l_imecl005 LIKE imecl_t.imecl005, 
   l_imaa006 LIKE imaa_t.imaa006, 
   l_imaf013 LIKE imaf_t.imaf013, 
   l_imaf013_desc LIKE gzcbl_t.gzcbl004, 
   l_psoz004 LIKE type_t.chr30, 
   l_order LIKE psoz_t.psoz005, 
   psoz005 LIKE psoz_t.psoz005, 
   psoz006 LIKE psoz_t.psoz006, 
   psoz007 LIKE psoz_t.psoz007, 
   psoz012 LIKE psoz_t.psoz012, 
   psoz014 LIKE psoz_t.psoz014, 
   psoz018 LIKE psoz_t.psoz018, 
   psoz021 LIKE psoz_t.psoz021, 
   psoz022 LIKE psoz_t.psoz022, 
   l_psoz019_psoz041 LIKE psoz_t.psoz019, 
   psoz019 LIKE psoz_t.psoz019, 
   psoz041 LIKE psoz_t.psoz041, 
   l_psoz024_psoz025 LIKE psoz_t.psoz024, 
   psoz024 LIKE psoz_t.psoz024, 
   psoz025 LIKE psoz_t.psoz025, 
   l_substitute LIKE psoz_t.psoz009, 
   psoz009 LIKE psoz_t.psoz009, 
   psoz010 LIKE psoz_t.psoz010, 
   psoz013 LIKE psoz_t.psoz013, 
   psoz015 LIKE psoz_t.psoz015, 
   psoz020 LIKE psoz_t.psoz020, 
   psoz026 LIKE psoz_t.psoz026, 
   psoz027 LIKE psoz_t.psoz027, 
   psoz028 LIKE psoz_t.psoz028, 
   psoz036 LIKE psoz_t.psoz036, 
   l_production LIKE psoz_t.psoz032, 
   l_purchase LIKE psoz_t.psoz032, 
   psoz032 LIKE psoz_t.psoz032, 
   psoz033 LIKE psoz_t.psoz033, 
   psoz034 LIKE psoz_t.psoz034, 
   psoz035 LIKE psoz_t.psoz035, 
   psoz037 LIKE psoz_t.psoz037, 
   psoz001 LIKE psoz_t.psoz001, 
   psoz002 LIKE psoz_t.psoz002, 
   psozsite LIKE psoz_t.psozsite, 
   psozent LIKE psoz_t.psozent
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_success     LIKE type_t.num5
DEFINE l_sql         STRING
DEFINE l_from        STRING
DEFINE l_psoz_sql    STRING
DEFINE sr2 RECORD
   psoz038           LIKE psoz_t.psoz038,
   l_imaal003        LIKE imaal_t.imaal003,
   l_imaal004        LIKE imaal_t.imaal004,
   psoz039           LIKE psoz_t.psoz039,
   l_imecl005        LIKE imecl_t.imecl005,
   l_imaa006         LIKE imaa_t.imaa006,
   l_imaf013         LIKE imaf_t.imaf013,
   l_imaf013_desc    LIKE gzcbl_t.gzcbl004,
   l_psoz004         LIKE type_t.chr30,
   l_order           LIKE psoz_t.psoz005,
   psoz012           LIKE psoz_t.psoz012,
   psoz014           LIKE psoz_t.psoz014,
   psoz018           LIKE psoz_t.psoz018,
   psoz021           LIKE psoz_t.psoz021,
   psoz022           LIKE psoz_t.psoz022,
   l_psoz019_psoz041 LIKE psoz_t.psoz019,
   l_psoz024_psoz025 LIKE psoz_t.psoz024,
   l_substitute      LIKE psoz_t.psoz009,
   #20151105 by stellar mark 151105-00005#1 ----- (S)
#   psoz031           LIKE psoz_t.psoz031,
#   psoz029           LIKE psoz_t.psoz029,
#   psoz030           LIKE psoz_t.psoz030,
   #20151105 by stellar mark 151105-00005#1 ----- (E)
   psoz036           LIKE psoz_t.psoz036,
   l_production      LIKE psoz_t.psoz032,
   l_purchase        LIKE psoz_t.psoz032,
   psoz037           LIKE psoz_t.psoz037
END RECORD
DEFINE l_str_aps_00134 LIKE type_t.chr80     #把固定會取的文字先取好，暫存在此變數中  #160503-00030#20 add
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    CALL apsr007_x02_create_temp_table() RETURNING l_success
   #20151105 by stellar modify 151105-00005#1 ----- (S)
#    LET g_sql = " INSERT INTO apsr007_tmp VALUES(?,?,?,?,?, 
#             ?,?,?,?,?,  ?,?,?,?,?,  ?,?,?,?,?,  ?,?,?,?,?)"
    LET g_sql = " INSERT INTO apsr007_tmp VALUES(?,?,?,?,?, 
             ?,?,?,?,?,  ?,?,?,?,?,  ?,?,?,?,?,  ?,?)"
   #20151105 by stellar modify 151105-00005#1 ----- (E)
         PREPARE insert_apsr007_tmp FROM g_sql
         IF STATUS THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "insert_apsr007_tmp"
            LET g_errparam.code   = status
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            CALL apsr007_x02_drop_tmp_table()
            LET g_rep_success = 'N'           
         END IF 
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH apsr007_x02_curs INTO sr.*                               
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
       #160503-00030#20 --s mark
       #CALL apsr007_x02_nulltozero(sr.psoz005) RETURNING sr.psoz005
       #CALL apsr007_x02_nulltozero(sr.psoz006) RETURNING sr.psoz006
       #CALL apsr007_x02_nulltozero(sr.psoz007) RETURNING sr.psoz007
       #CALL apsr007_x02_nulltozero(sr.psoz012) RETURNING sr.psoz012
       #CALL apsr007_x02_nulltozero(sr.psoz014) RETURNING sr.psoz014
       #CALL apsr007_x02_nulltozero(sr.psoz018) RETURNING sr.psoz018
       #CALL apsr007_x02_nulltozero(sr.psoz021) RETURNING sr.psoz021
       #CALL apsr007_x02_nulltozero(sr.psoz022) RETURNING sr.psoz022
       #CALL apsr007_x02_nulltozero(sr.psoz019) RETURNING sr.psoz019
       #CALL apsr007_x02_nulltozero(sr.psoz041) RETURNING sr.psoz041
       #CALL apsr007_x02_nulltozero(sr.psoz024) RETURNING sr.psoz024
       #CALL apsr007_x02_nulltozero(sr.psoz025) RETURNING sr.psoz025
       #CALL apsr007_x02_nulltozero(sr.psoz009) RETURNING sr.psoz009
       #CALL apsr007_x02_nulltozero(sr.psoz010) RETURNING sr.psoz010
       #CALL apsr007_x02_nulltozero(sr.psoz013) RETURNING sr.psoz013
       #CALL apsr007_x02_nulltozero(sr.psoz015) RETURNING sr.psoz015
       #CALL apsr007_x02_nulltozero(sr.psoz020) RETURNING sr.psoz020
       #CALL apsr007_x02_nulltozero(sr.psoz026) RETURNING sr.psoz026
       #CALL apsr007_x02_nulltozero(sr.psoz027) RETURNING sr.psoz027
       #CALL apsr007_x02_nulltozero(sr.psoz028) RETURNING sr.psoz028
       ##20151105 by stellar mark 151105-00005#1 ----- (S)
#      # CALL apsr007_x02_nulltozero(sr.psoz031) RETURNING sr.psoz031
#      # CALL apsr007_x02_nulltozero(sr.psoz029) RETURNING sr.psoz029
#      # CALL apsr007_x02_nulltozero(sr.psoz030) RETURNING sr.psoz030
       ##20151105 by stellar mark 151105-00005#1 ----- (E)
       #CALL apsr007_x02_nulltozero(sr.psoz036) RETURNING sr.psoz036
       #CALL apsr007_x02_nulltozero(sr.psoz032) RETURNING sr.psoz032
       #CALL apsr007_x02_nulltozero(sr.psoz033) RETURNING sr.psoz033
       #CALL apsr007_x02_nulltozero(sr.psoz034) RETURNING sr.psoz034
       #CALL apsr007_x02_nulltozero(sr.psoz035) RETURNING sr.psoz035
       #CALL apsr007_x02_nulltozero(sr.psoz037) RETURNING sr.psoz037
       #CALL apsr007_x02_nulltozero(sr.l_production) RETURNING sr.l_production
       #CALL apsr007_x02_nulltozero(sr.l_purchase) RETURNING sr.l_purchase
       ##產品特徵
       #CALL s_feature_description(sr.psoz038,sr.psoz039) RETURNING l_success,sr.l_imecl005
       ##補貨策略
       #CALL s_desc_gzcbl004_desc('2022',sr.l_imaf013) RETURNING sr.l_imaf013_desc
       #160503-00030#20 --e mark

       LET sr.l_order = sr.psoz005 + sr.psoz006 + sr.psoz007
       LET sr.l_psoz019_psoz041 = sr.psoz019 + sr.psoz041
       LET sr.l_psoz024_psoz025 = sr.psoz024 + sr.psoz025
       #modify--2015/10/22 By shiun--(S)
#       LET sr.l_substitute = sr.psoz009 + sr.psoz010 + sr.psoz013 + sr.psoz015 + sr.psoz020 + sr.psoz026 + sr.psoz027 + sr.psoz028
       #psoz009、psoz010、psoz013、psoz015是減項
       LET sr.l_substitute = (sr.psoz009*-1) + (sr.psoz010*-1) + (sr.psoz013*-1) + (sr.psoz015*-1) + sr.psoz020 + sr.psoz026 + sr.psoz027 + sr.psoz028
                            + sr.psoz033 + sr.psoz035
       #modify--2015/10/22 By shiun--(E)
       #規畫採購或製造量:psoz032+psoz033+psoz034+psoz035
       #補給策略=1.採購 or 4.其他=規畫採購量
       #補給策略=2.自製 or 3.委外=規畫生產量
       IF sr.l_imaf013 = '1' OR sr.l_imaf013 = '4' THEN
          #20151105 by stellar modify 151105-00005#1 ----- (S)
#          LET sr.l_purchase = sr.psoz032 + sr.psoz033 + sr.psoz034 + sr.psoz035
          LET sr.l_purchase = sr.psoz032 + sr.psoz034
          #20151105 by stellar modify 151105-00005#1 ----- (E)
       ELSE
          #20151105 by stellar modify 151105-00005#1 ----- (S)
#          LET sr.l_production = sr.psoz032 + sr.psoz033 + sr.psoz034 + sr.psoz035
          LET sr.l_production = sr.psoz032 + sr.psoz034
          #20151105 by stellar modify 151105-00005#1 ----- (E)
       END IF
       
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       #20151105 by stellar modify 151105-00005#1 ----- (S)
#       EXECUTE insert_apsr007_tmp USING sr.psoz038,sr.l_imaal003,sr.l_imaal004,sr.psoz039,sr.l_imecl005,sr.l_imaa006,sr.l_imaf013,sr.l_imaf013_desc,sr.l_psoz004,sr.l_order,sr.psoz012,sr.psoz014,sr.psoz018,sr.psoz021,sr.psoz022,sr.l_psoz019_psoz041,sr.l_psoz024_psoz025,sr.l_substitute,sr.psoz031,sr.psoz029,sr.psoz030,sr.psoz036,sr.l_production,sr.l_purchase,sr.psoz037
       EXECUTE insert_apsr007_tmp USING sr.psoz038,sr.l_imaal003,sr.l_imaal004,sr.psoz039,sr.l_imecl005,sr.l_imaa006,sr.l_imaf013,sr.l_imaf013_desc,sr.l_psoz004,sr.l_order,sr.psoz012,sr.psoz014,sr.psoz018,sr.psoz021,sr.psoz022,sr.l_psoz019_psoz041,sr.l_psoz024_psoz025,sr.l_substitute,sr.psoz036,sr.l_production,sr.l_purchase,sr.psoz037
       #20151105 by stellar modify 151105-00005#1 ----- (S)
       
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "insert_apsr007_tmp"
          LET g_errparam.code   = SQLCA.sqlcode
          LET g_errparam.popup  = FALSE
          CALL cl_err()       
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF
       CONTINUE FOREACH
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.psoz038,sr.l_imaal003,sr.l_imaal004,sr.psoz039,sr.l_imecl005,sr.l_imaa006,sr.l_imaf013_desc,sr.l_order,sr.psoz012,sr.psoz014,sr.psoz018,sr.psoz021,sr.psoz022,sr.l_psoz019_psoz041,sr.l_psoz024_psoz025,sr.l_substitute,sr.psoz036,sr.l_production,sr.l_purchase,sr.psoz037
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "apsr007_x02_execute"
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
    LET l_sql = " SELECT psoz038,l_imaal003,l_imaal004,psoz039,l_imecl005,l_imaa006,l_imaf013,l_imaf013_desc,MAX(l_psoz004) AS l_psoz004,SUM(l_order) AS l_order, ",
                "         SUM(psoz012) AS psoz012,SUM(psoz014) AS psoz014,SUM(psoz018) AS psoz018,SUM(psoz021) AS psoz021,SUM(psoz022) AS psoz022, ",
                "         SUM(l_psoz019_psoz041) AS l_psoz019_psoz041,SUM(l_psoz024_psoz025) AS l_psoz024_psoz025, ",
                #20151105 by stellar modify 151105-00005#1 ----- (S)
#                "         SUM(l_substitute) AS l_substitute,0,SUM(psoz029) AS psoz029,SUM(psoz030) AS psoz030,0, ",
                "         SUM(l_substitute) AS l_substitute,0, ",
                #20151105 by stellar modify 151105-00005#1 ----- (E)
                "         SUM(l_production) AS l_production,SUM(l_purchase) AS l_purchase,0 ",
                "    FROM apsr007_tmp GROUP BY psoz038,l_imaal003,l_imaal004,psoz039,l_imecl005,l_imaa006,l_imaf013,l_imaf013_desc "
    DECLARE apsr007_modify CURSOR FROM l_sql
    
    #160503-00030#20 --s add
    LET l_psoz_sql = ''
    LET l_psoz_sql = " SELECT psoz036,psoz037 ",
                     "   FROM apsr007_tmp",
                     "  WHERE psoz038   = ? ",
                     "    AND psoz039   = ? ",
                     "    AND l_imaa006 = ? ",
                     "    AND l_imaf013 = ? ",
                     "    AND l_psoz004 = ? "           
    PREPARE apsr007_psoz FROM l_psoz_sql

    CALL cl_getmsg('aps-00134',g_dlang) RETURNING l_str_aps_00134
    #160503-00030#20 --e add

    FOREACH apsr007_modify INTO sr2.*
    
       IF STATUS THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = 'apsr007_modify_foreach:'
          LET g_errparam.code   = STATUS
          LET g_errparam.popup  = TRUE
          CALL cl_err()
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF
       #LET l_psoz_sql = '' #160503-00030#20 mark
       #20151105 by stellar modify 151105-00005#1 ----- (S)
#       LET l_psoz_sql = " SELECT psoz031,psoz036,psoz037 ",
       #LET l_psoz_sql = " SELECT psoz036,psoz037 ",  #160503-00030#20  mark
       #20151105 by stellar modify 151105-00005#1 ----- (E)
       #160503-00030#20 --s mark
       #               "   FROM apsr007_tmp",
       #               "  WHERE psoz038 = '",sr2.psoz038,"'",
       #               "    AND psoz039 = '",sr2.psoz039,"'",
       #               "    AND l_imaa006 = '",sr2.l_imaa006,"'",
       #               "    AND l_imaf013 = '",sr2.l_imaf013,"'",
       #               "    AND l_psoz004 = '",sr2.l_psoz004,"'"           
       #PREPARE apsr007_psoz FROM l_psoz_sql
       #160503-00030#20 --e mark
       #20151105 by stellar modify 151105-00005#1 ----- (S)
#       EXECUTE apsr007_psoz INTO sr2.psoz031,sr2.psoz036,sr2.psoz037
       #EXECUTE apsr007_psoz INTO sr2.psoz036,sr2.psoz037 #160503-00030#20  mark
       #20151105 by stellar modify 151105-00005#1 ----- (E)
#       SELECT psoz031,psoz036,psoz037 INTO sr2.psoz031,sr2.psoz036,sr2.psoz037
#         FROM l_from
#        WHERE psoz038 = sr2.psoz038
##          AND l_imaal003 = sr2.l_imaal003
##          AND l_imaal004 = sr2.l_imaal004
#          AND l_imecl005 = sr2.l_imecl005
#          AND l_imaa006 = sr2.l_imaa006
#          AND l_imaf013_desc = sr2.l_imaf013_desc
#          AND l_psoz004 = sr2.l_psoz004
       #CALL cl_getmsg('aps-00134',g_dlang) RETURNING sr2.l_psoz004 #160503-00030#20 mark
       
        #160503-00030#20 --s add
        EXECUTE apsr007_psoz USING sr2.psoz038,sr2.psoz039,sr2.l_imaa006,sr2.l_imaf013,sr2.l_psoz004 
                              INTO sr2.psoz036,sr2.psoz037
                              
        LET sr2.l_psoz004 = l_str_aps_00134                       
        #160503-00030#20 --e add
       
       #20151105 by stellar add 151105-00005#1 ----- (S)
       #預計結存=-受訂量-計畫備料量-工單備料量+庫存量+請購量+採購量+在驗量+在製量+替代量
       LET sr2.psoz036 = -sr2.l_order-sr2.psoz012-sr2.psoz014
                         +sr2.psoz018+sr2.psoz021+sr2.psoz022
                         +sr2.l_psoz019_psoz041+sr2.l_psoz024_psoz025+sr2.l_substitute
       #20151105 by stellar add 151105-00005#1 ----- (E)
       
       #20151105 by stellar modify 151105-00005#1 ----- (S)
#       EXECUTE insert_prep USING sr2.psoz038,sr2.l_imaal003,sr2.l_imaal004,sr2.psoz039,sr2.l_imecl005,sr2.l_imaa006,sr2.l_imaf013_desc,sr2.l_order,sr2.psoz012,sr2.psoz014,sr2.psoz018,sr2.psoz021,sr2.psoz022,sr2.l_psoz019_psoz041,sr2.l_psoz024_psoz025,sr2.l_substitute,sr2.psoz031,sr2.psoz029,sr2.psoz030,sr2.psoz036,sr2.l_production,sr2.l_purchase,sr2.psoz037
       EXECUTE insert_prep USING sr2.psoz038,sr2.l_imaal003,sr2.l_imaal004,sr2.psoz039,sr2.l_imecl005,sr2.l_imaa006,sr2.l_imaf013_desc,sr2.l_order,sr2.psoz012,sr2.psoz014,sr2.psoz018,sr2.psoz021,sr2.psoz022,sr2.l_psoz019_psoz041,sr2.l_psoz024_psoz025,sr2.l_substitute,sr2.psoz036,sr2.l_production,sr2.l_purchase,sr2.psoz037
       #20151105 by stellar modify 151105-00005#1 ----- (E)
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "apsr007_modify_execute"
          LET g_errparam.code   = SQLCA.sqlcode
          LET g_errparam.popup  = FALSE
          CALL cl_err()       
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF
    END FOREACH
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apsr007_x02.rep_data" readonly="Y" >}
PRIVATE FUNCTION apsr007_x02_rep_data()
#add-point:rep_data.define (客製用) name="rep_data.define_customerization"

#end add-point:rep_data.define
#add-point:rep_data.define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="rep_data.define"

#end add-point:rep_data.define
 
    #add-point:rep_data.before name="rep_data.before"
    
    #end add-point:rep_data.before
    
    CALL cl_xg_view()
    #add-point:rep_data.after name="rep_data.after"
    CALL apsr007_x02_drop_tmp_table()
    #end add-point:rep_data.after
END FUNCTION
 
{</section>}
 
{<section id="apsr007_x02.other_function" readonly="Y" >}

PRIVATE FUNCTION apsr007_x02_nulltozero(p_num)
   DEFINE p_num LIKE type_t.num20_6

   IF cl_null(p_num) THEN
      LET p_num = 0
   END IF

   RETURN p_num
END FUNCTION
################################################################################
# Descriptions...: Create Temp Table
# Memo...........:
# Usage..........: CALL apsr007_x02_create_temp_table()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2015/05/25 By shiun
# Modify.........:
################################################################################
PRIVATE FUNCTION apsr007_x02_create_temp_table()
DEFINE r_success         LIKE type_t.num5

   LET r_success = TRUE
   
   DROP TABLE apsr007_tmp;
   CREATE TEMP TABLE apsr007_tmp( 
      psoz038           LIKE psoz_t.psoz038,
      l_imaal003        LIKE imaal_t.imaal003,
      l_imaal004        LIKE imaal_t.imaal004,
      psoz039           LIKE psoz_t.psoz039,
      l_imecl005        LIKE imecl_t.imecl005,
      l_imaa006         LIKE imaa_t.imaa006,
      l_imaf013         LIKE imaf_t.imaf013,
      l_imaf013_desc    LIKE gzcbl_t.gzcbl004,
      l_psoz004         LIKE type_t.chr30,
      l_order           LIKE psoz_t.psoz005,
      psoz012           LIKE psoz_t.psoz012,
      psoz014           LIKE psoz_t.psoz014,
      psoz018           LIKE psoz_t.psoz018,
      psoz021           LIKE psoz_t.psoz021,
      psoz022           LIKE psoz_t.psoz022,
      l_psoz019_psoz041 LIKE psoz_t.psoz019,
      l_psoz024_psoz025 LIKE psoz_t.psoz024,
      l_substitute      LIKE psoz_t.psoz009,
      #20151105 by stellar mark 151105-00005#1 ----- (S)
#      psoz031           LIKE psoz_t.psoz031,
#      psoz029           LIKE psoz_t.psoz029,
#      psoz030           LIKE psoz_t.psoz030,
      #20151105 by stellar mark 151105-00005#1 ----- (E)
      psoz036           LIKE psoz_t.psoz036,
      l_production      LIKE psoz_t.psoz032,
      l_purchase        LIKE psoz_t.psoz032,
      psoz037           LIKE psoz_t.psoz037
      )
   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create apsr007_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success
END FUNCTION
################################################################################
# Descriptions...: 刪除臨時表
# Memo...........:
# Usage..........: CALL apsr007_x02_drop_tmp_table()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/05/25 By Shiun
# Modify.........:
################################################################################
PRIVATE FUNCTION apsr007_x02_drop_tmp_table()

   DROP TABLE apsr007_tmp

END FUNCTION

 
{</section>}
 
