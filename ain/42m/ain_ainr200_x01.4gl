#該程式未解開Section, 採用最新樣板產出!
{<section id="ainr200_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2015-01-26 17:14:08), PR版次:0001(2015-01-28 15:18:13)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000067
#+ Filename...: ainr200_x01
#+ Description: ...
#+ Creator....: 05423(2014-12-08 14:15:00)
#+ Modifier...: 05423 -SD/PR- 05423
 
{</section>}
 
{<section id="ainr200_x01.global" readonly="Y" >}
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
       find STRING                   #l_find
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
TYPE sr_s RECORD 
   l_inal018_desc LIKE type_t.chr30, 
   inal018 LIKE inal_t.inal018, 
   inal001 LIKE inal_t.inal001, 
   inal002 LIKE inal_t.inal002, 
   inal017 LIKE inal_t.inal017, 
   inal006 LIKE inal_t.inal006, 
   imaal_t_imaal003 LIKE imaal_t.imaal003, 
   imaal_t_imaal004 LIKE imaal_t.imaal004, 
   inal009 LIKE inal_t.inal009, 
   l_inal009_desc LIKE type_t.chr30, 
   inal010 LIKE inal_t.inal010, 
   l_inal010_desc LIKE type_t.chr30, 
   inal011 LIKE inal_t.inal011, 
   inal012 LIKE inal_t.inal012, 
   inal013 LIKE inal_t.inal013, 
   inal007 LIKE inal_t.inal007, 
   inal008 LIKE inal_t.inal008, 
   inaj044 LIKE inaj_t.inaj044, 
   inaj018 LIKE inaj_t.inaj018, 
   l_inaj018_desc LIKE type_t.chr50, 
   l_type LIKE type_t.num20, 
   l_pid LIKE type_t.num20, 
   l_id LIKE type_t.num20
 END RECORD
DEFINE g_id   LIKE type_t.num20
#end add-point
 
{</section>}
 
{<section id="ainr200_x01.main" readonly="Y" >}
PUBLIC FUNCTION ainr200_x01(p_arg1,p_arg2)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 STRING                  #tm.find  l_find
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.find = p_arg2
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "ainr200_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL ainr200_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL ainr200_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL ainr200_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL ainr200_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL ainr200_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="ainr200_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION ainr200_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "l_inal018_desc.type_t.chr30,inal018.inal_t.inal018,inal001.inal_t.inal001,inal002.inal_t.inal002,inal017.inal_t.inal017,inal006.inal_t.inal006,imaal_t_imaal003.imaal_t.imaal003,imaal_t_imaal004.imaal_t.imaal004,inal009.inal_t.inal009,l_inal009_desc.type_t.chr30,inal010.inal_t.inal010,l_inal010_desc.type_t.chr30,inal011.inal_t.inal011,inal012.inal_t.inal012,inal013.inal_t.inal013,inal007.inal_t.inal007,inal008.inal_t.inal008,inaj044.inaj_t.inaj044,inaj018.inaj_t.inaj018,l_inaj018_desc.type_t.chr50,l_type.type_t.num20,l_pid.type_t.num20,l_id.type_t.num20" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="ainr200_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION ainr200_x01_ins_prep()
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
 
{<section id="ainr200_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION ainr200_x01_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define(客製用) name="sel_prep.define_customerization"

#end add-point
#add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
DEFINE g_order       STRING
#end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
 
   #add-point:sel_prep g_select name="sel_prep.g_select"
   #得到起始階料號、庫位、儲位、批號、製造批號、製造序號
   LET g_select = " SELECT DISTINCT NULL,NULL,NULL,NULL,NULL,inal006,imaal_t.imaal003,imaal_t.imaal004, 
       inal009,(trim(inal009)||'.'||(trim(inayl003))),inal010,(trim(inal010)||'.'||trim(inab003)),inal011,inal012,inal013,inal007,inal008,NULL,NULL,NULL,NULL,NULL, 
       NULL"
#   #end add-point
#   LET g_select = " SELECT NULL,inal018,inal001,inal002,inal017,inal006,imaal_t.imaal003,imaal_t.imaal004, 
#       inal009,NULL,inal010,NULL,inal011,inal012,inal013,inal007,inal008,inaj044,inaj018,NULL,NULL,NULL, 
#       NULL"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_from = " FROM inal_t LEFT OUTER JOIN inaj_t ON inajent = inalent AND inajsite = inalsite AND inaj001 = inal001 AND inaj002 = inal002 AND inaj003 = inal003 AND inaj004 = inal005 ",
                "             LEFT OUTER JOIN imaal_t ON inalent = imaalent AND inal006 = imaal001 AND imaal002 = '",g_dlang,"' ",
                "             LEFT OUTER JOIN inayl_t ON inal009 = inayl001 AND inalent = inaylent AND inayl002 = '",g_dlang,"' ",
                "             LEFT OUTER JOIN inab_t ON inal009 = inab001 AND inalent = inabent AND inal010 = inab002 "           
#   #end add-point
#    LET g_from = " FROM inal_t,inaj_t,imaal_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   LET g_order = " ORDER BY inal006,inal009,inal010,inal011,inal012,inal013 "
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("inal_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_where = g_where ,cl_sql_add_filter("inal_t")   #資料過濾功能
   LET g_sql = g_sql CLIPPED ," ",g_order CLIPPED ," "
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
   #end add-point
   PREPARE ainr200_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE ainr200_x01_curs CURSOR FOR ainr200_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="ainr200_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION ainr200_x01_ins_data()
DEFINE sr RECORD 
   l_inal018_desc LIKE type_t.chr30, 
   inal018 LIKE inal_t.inal018, 
   inal001 LIKE inal_t.inal001, 
   inal002 LIKE inal_t.inal002, 
   inal017 LIKE inal_t.inal017, 
   inal006 LIKE inal_t.inal006, 
   imaal_t_imaal003 LIKE imaal_t.imaal003, 
   imaal_t_imaal004 LIKE imaal_t.imaal004, 
   inal009 LIKE inal_t.inal009, 
   l_inal009_desc LIKE type_t.chr30, 
   inal010 LIKE inal_t.inal010, 
   l_inal010_desc LIKE type_t.chr30, 
   inal011 LIKE inal_t.inal011, 
   inal012 LIKE inal_t.inal012, 
   inal013 LIKE inal_t.inal013, 
   inal007 LIKE inal_t.inal007, 
   inal008 LIKE inal_t.inal008, 
   inaj044 LIKE inaj_t.inaj044, 
   inaj018 LIKE inaj_t.inaj018, 
   l_inaj018_desc LIKE type_t.chr50, 
   l_type LIKE type_t.num20, 
   l_pid LIKE type_t.num20, 
   l_id LIKE type_t.num20
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
   DEFINE l_type LIKE type_t.num20
   DEFINE l_pid  LIKE type_t.num20
   DEFINE l_id   LIKE type_t.num20
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    LET l_type = 1
    LET l_pid = 0
    LET l_id = 0
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH ainr200_x01_curs INTO sr.*                               
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
       LET sr.l_type = l_type
       LET sr.l_pid = ''
       IF l_type = 1 THEN
          LET sr.l_id = 1
          LET g_id = 1
       ELSE
          LET sr.l_id = g_id + 1
          LET g_id= sr.l_id 
       END IF       
       IF (sr.l_inal009_desc = '.') THEN
         LET sr.l_inal009_desc = sr.inal009
       END IF
       IF (sr.l_inal010_desc = '.') THEN
         LET sr.l_inal010_desc = sr.inal010
       END IF
       IF (sr.l_inaj018_desc = '.') THEN
         LET sr.l_inaj018_desc = sr.inaj018
         
       END IF
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.l_inal018_desc,sr.inal018,sr.inal001,sr.inal002,sr.inal017,sr.inal006,sr.imaal_t_imaal003,sr.imaal_t_imaal004,sr.inal009,sr.l_inal009_desc,sr.inal010,sr.l_inal010_desc,sr.inal011,sr.inal012,sr.inal013,sr.inal007,sr.inal008,sr.inaj044,sr.inaj018,sr.l_inaj018_desc,sr.l_type,sr.l_pid,sr.l_id
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "ainr200_x01_execute"
          LET g_errparam.code   = SQLCA.sqlcode
          LET g_errparam.popup  = FALSE
          CALL cl_err()       
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF
 
       #add-point:ins_data段after_save name="ins_data.after.save"
         
       IF tm.find = '1' THEN
          CALL ainr200_x01_define_cursor()
          CALL ainr200_x01_tree1(sr.*)  
          CALL ainr200_x01_tree2(sr.*)
          CALL ainr200_x01_tree3(sr.*)
       ELSE
          CALL ainr200_x01_define_cursor2()
          CALL ainr200_x01_ltree1(sr.*)   
          CALL ainr200_x01_ltree2(sr.*)          
       END IF
       LET l_type = l_type+1
       #end add-point
       
    END FOREACH
    
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="ainr200_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION ainr200_x01_rep_data()
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
 
{<section id="ainr200_x01.other_function" readonly="Y" >}

PRIVATE FUNCTION ainr200_x01_define_cursor()


   
  ##优先抓去銷退單，無銷退單時抓去出貨單
  ##銷退資料：抓取[T.製造批序號庫存交易明細檔(inal_t)].[C.庫存異動類型]='202'的資料
  LET g_sql = "SELECT DISTINCT '',inal018,inal001,inal002,inal017,inal006,imaal003,imaal004,inal009,(trim(inal009)||'.'||(trim(inayl003))),inal010,(trim(inal010)||'.'||trim(inab003)),inal011,inal012,inal013,",
              "        inal007,inal008,inaj044,inaj018,(trim(inaj018)||'.'||trim(ooefl003)),'','','' ",
              " FROM inal_t LEFT OUTER JOIN inaj_t ON inajent = inalent AND inajsite = inalsite AND inaj001 = inal001 AND inaj002 = inal002 AND inaj003 = inal003 AND inaj004 = inal005 ",
              "             LEFT OUTER JOIN imaal_t ON inalent = imaalent AND inal006 = imaal001 AND imaal002 = '",g_dlang,"' ",
              "             LEFT OUTER JOIN inayl_t ON inal009 = inayl001 AND inalent = inaylent AND inayl002 = '",g_dlang,"' ",
              "             LEFT OUTER JOIN inab_t ON inal009 = inab001 AND inalent = inabent AND inal010 = inab002 " ,
              "             LEFT OUTER JOIN ooefl_t ON inaj018 = ooefl001 AND inajent = ooeflent AND ooefl002 = '",g_dlang,"' ",
              " WHERE inalent= '",g_enterprise,"' AND inalsite= '",g_site,"' ",
              "   AND inal018 = '202' ",
              "   AND inal006= ? AND inal009= ? AND inal010= ? ",
              "   AND inal011= ? AND inal012= ? AND inal013= ? ",
              " ORDER BY inal001,inal002,inal017 "
       PREPARE ainr200_x01_pb1 FROM g_sql
       DECLARE ainr200_x01_curs1 CURSOR FOR ainr200_x01_pb1

   ##由銷退單撈出出貨單
   ##出貨資料：抓取[T.製造批序號庫存交易明細檔(inal_t)].[C.庫存異動類型]='201','301'且[C.出入庫碼]="-1"的資料
   LET g_sql = "SELECT DISTINCT '',inal018,inal001,inal002,inal017,inal006,imaal003,imaal004,inal009,(trim(inal009)||'.'||(trim(inayl003))),inal010,(trim(inal010)||'.'||trim(inab003)),inal011,inal012,inal013,",
               "       inal007,inal008,inaj044,inaj018,(trim(inaj018)||'.'||trim(pmaal003)),'','','' ",
               "  FROM inal_t LEFT OUTER JOIN inaj_t ON inajent = inalent AND inajsite = inalsite AND inaj001 = inal001 AND inaj002 = inal002 AND inaj003 = inal003 AND inaj004 = inal005 ",
               "              LEFT OUTER JOIN imaal_t ON inalent = imaalent AND inal006 = imaal001 AND imaal002 = '",g_dlang,"' ",
               "              LEFT OUTER JOIN inayl_t ON inal009 = inayl001 AND inalent = inaylent AND inayl002 = '",g_dlang,"' ",
               "              LEFT OUTER JOIN inab_t ON inal009 = inab001 AND inalent = inabent AND inal010 = inab002 " ,
               "              LEFT OUTER JOIN pmaal_t ON inaj018 = pmaal001 AND inajent = pmaalent AND pmaal002 = '",g_dlang,"' ",
               "              LEFT OUTER JOIN xmdk_t ON inalent = xmdkent AND inal001 = xmdk005 ",
               " WHERE inalent= '",g_enterprise,"' AND inalsite= '",g_site,"' ",
               "   AND (inaj036 = '201' OR inaj036 = '301') AND inal005 = -1 ",
               "   AND inal006= ? AND inal009= ? AND inal010= ?",
               "   AND inal011= ? AND inal012= ? AND inal013= ? ",
               " ORDER BY inal001,inal002,inal017"

       PREPARE ainr200_x01_pb2 FROM g_sql
       DECLARE ainr200_x01_curs2 CURSOR FOR ainr200_x01_pb2

   ##採購/入庫資料：抓取[T.製造批序號庫存交易明細檔(inal_t)].[C.庫存異動類型]='1開頭'且[C.出入庫碼]="1"的資料
   LET g_sql = "SELECT DISTINCT '',inal018,inal001,inal002,inal017,inal006,imaal003,imaal004,inal009,(trim(inal009)||'.'||(trim(inayl003))),inal010,(trim(inal010)||'.'||trim(inab003)),inal011,inal012,inal013,",
              "        inal007,inal008,inaj044,inaj018,(trim(inaj018)||'.'||trim(pmaal003)),'','','' ",
               "  FROM inal_t LEFT OUTER JOIN inaj_t ON inajent = inalent AND inajsite = inalsite AND inaj001 = inal001 AND inaj002 = inal002 AND inaj003 = inal003 AND inaj004 = inal005 ",
               "              LEFT OUTER JOIN imaal_t ON inalent = imaalent AND inal006 = imaal001 AND imaal002 = '",g_dlang,"' ",
               "              LEFT OUTER JOIN inayl_t ON inal009 = inayl001 AND inalent = inaylent AND inayl002 = '",g_dlang,"' ",
               "              LEFT OUTER JOIN inab_t ON inal009 = inab001 AND inalent = inabent AND inal010 = inab002 " ,
               "              LEFT OUTER JOIN pmaal_t ON inaj018 = pmaal001 AND inajent = pmaalent AND pmaal002 = '",g_dlang,"' ",
               " WHERE inalent= '",g_enterprise,"' AND inalsite= '",g_site,"' ",
               "   AND inaj036 LIKE '1%' AND inal005 = 1 ",
               "   AND inal006= ? AND inal009= ? AND inal010= ?",
               "   AND inal011= ? AND inal012= ? AND inal013= ? ",
               " ORDER BY inal001,inal002,inal017 "

       PREPARE ainr200_x01_pb3 FROM g_sql
       DECLARE ainr200_x01_curs3 CURSOR FOR ainr200_x01_pb3

   ##依發料單號分別抓取該單之[T.製造批序號庫存交易明細檔(inal_t)].[C.庫存異動類型]='302'的資料
   LET g_sql = "SELECT DISTINCT '',inal018,inal001,inal002,inal017,inal006,imaal003,imaal004,inal009,(trim(inal009)||'.'||(trim(inayl003))),inal010,(trim(inal010)||'.'||trim(inab003)),inal011,inal012,inal013,",
              "        inal007,inal008,inaj044,inaj018,(trim(inaj018)||'.'||trim(pmaal003)),'','','' ",
               "  FROM inal_t LEFT OUTER JOIN inaj_t ON inajent = inalent AND inajsite = inalsite AND inaj001 = inal001 AND inaj002 = inal002 AND inaj003 = inal003 AND inaj004 = inal005 ",
               "              LEFT OUTER JOIN imaal_t ON inalent = imaalent AND inal006 = imaal001 AND imaal002 = '",g_dlang,"' ",
               "              LEFT OUTER JOIN inayl_t ON inal009 = inayl001 AND inalent = inaylent AND inayl002 = '",g_dlang,"' ",
               "              LEFT OUTER JOIN inab_t ON inal009 = inab001 AND inalent = inabent AND inal010 = inab002 " ,
               "              LEFT OUTER JOIN pmaal_t ON inaj018 = pmaal001 AND inajent = pmaalent AND pmaal002 = '",g_dlang,"' ",
               "              LEFT OUTER JOIN sfdc_t ON inal001 = sfdcdocno AND inalent = sfdcent " ,
               " WHERE inalent= '",g_enterprise,"' AND inalsite= '",g_site,"' ",
               "   AND inal018= '302' ",
               "   AND inal006= ? AND inal009= ? AND inal010= ?",
               "   AND inal011= ? AND inal012= ? AND inal013= ? ",
               "   AND sfdc001= ? ",
               " ORDER BY inal001,inal002,inal017 "

       PREPARE ainr200_x01_pb4 FROM g_sql
       DECLARE ainr200_x01_curs4 CURSOR FOR ainr200_x01_pb4
       
END FUNCTION

#展開樹1階銷退資料
PRIVATE FUNCTION ainr200_x01_tree1(sr)
   DEFINE sr   sr_s
   DEFINE sr1  sr_s
   DEFINE l_success LIKE type_t.num5
   
   OPEN ainr200_x01_curs1 USING sr.inal006,sr.inal009,sr.inal010,sr.inal011,sr.inal012,sr.inal013 #銷退或出貨
   FOREACH ainr200_x01_curs1 INTO sr1.*
      LET g_id=g_id+1
      LET sr1.l_type = sr.l_type
      LET sr1.l_pid = sr.l_id
      LET sr1.l_id = g_id
      IF (sr1.l_inal009_desc = '.') THEN
         LET sr1.l_inal009_desc = sr1.inal009
      END IF
      IF (sr1.l_inal010_desc = '.') THEN
         LET sr1.l_inal010_desc = sr1.inal010
      END IF
      IF (sr1.l_inaj018_desc = '.') THEN
         LET sr1.l_inaj018_desc = sr1.inaj018
      END IF
      SELECT gzcbl004 INTO sr1.l_inal018_desc
        FROM gzcbl_t
       WHERE gzcbl001 = '4046'
         AND gzcbl002 = '1'
         AND gzcbl003 = g_dlang
         
#      LET sr1.l_inal018_desc = '銷退資料'
      EXECUTE insert_prep USING sr1.*      
   END FOREACH
            
END FUNCTION

#展開樹2階出貨資料
PRIVATE FUNCTION ainr200_x01_tree2(sr)
   DEFINE sr   sr_s
   DEFINE sr1  sr_s
   DEFINE l_id   LIKE type_t.num20
   DEFINE l_success LIKE type_t.num5
   LET l_id = 0
   OPEN ainr200_x01_curs2 USING sr.inal006,sr.inal009,sr.inal010,sr.inal011,sr.inal012,sr.inal013 #出貨
   FOREACH ainr200_x01_curs2 INTO sr1.*     
      LET g_id=g_id+1
      LET sr1.l_type = sr.l_type
      LET sr1.l_pid = sr.l_id
      LET sr1.l_id = g_id

      IF (sr1.l_inal009_desc = '.') THEN
         LET sr1.l_inal009_desc = sr1.inal009
      END IF
      IF (sr1.l_inal010_desc = '.') THEN
         LET sr1.l_inal010_desc = sr1.inal010
      END IF
      IF (sr1.l_inaj018_desc = '.') THEN
         LET sr1.l_inaj018_desc = sr1.inaj018
      END IF
      SELECT gzcbl004 INTO sr1.l_inal018_desc
        FROM gzcbl_t
       WHERE gzcbl001 = '4046'
         AND gzcbl002 = '2'
         AND gzcbl003 = g_dlang
#      LET sr1.l_inal018_desc = '出貨資料'
      EXECUTE insert_prep USING sr1.*
         
   END FOREACH
END FUNCTION

#展開樹3階採購/入庫資料
PRIVATE FUNCTION ainr200_x01_tree3(sr)
   DEFINE sr   sr_s
   DEFINE sr1  sr_s
   DEFINE sr2  sr_s
   DEFINE l_id   LIKE type_t.num20
   DEFINE l_id1  LIKE type_t.num20
   DEFINE l_id2  LIKE type_t.num20
   DEFINE l_success LIKE type_t.num5
   LET l_id = 0
   LET l_id1 = 0
   LET l_id2 = 0

   OPEN ainr200_x01_curs3 USING sr.inal006,sr.inal009,sr.inal010,sr.inal011,sr.inal012,sr.inal013 #採購/入庫    
   FOREACH ainr200_x01_curs3 INTO sr1.*     
      LET g_id=g_id+1
      LET sr1.l_type = sr.l_type
      LET sr1.l_pid = sr.l_id
      LET sr1.l_id = g_id
      IF (sr1.l_inal009_desc = '.') THEN
         LET sr1.l_inal009_desc = sr1.inal009
      END IF
      IF (sr1.l_inal010_desc = '.') THEN
         LET sr1.l_inal010_desc = sr1.inal010
      END IF
      IF (sr1.l_inaj018_desc = '.') THEN
         LET sr1.l_inaj018_desc = sr1.inaj018
      END IF
      IF (sr1.inal018 = '101' OR sr1.inal018 = '102' OR sr1.inal018 = '115') THEN
         SELECT gzcbl004 INTO sr1.l_inal018_desc
           FROM gzcbl_t
          WHERE gzcbl001 = '4046'
            AND gzcbl002 = '3'
            AND gzcbl003 = g_dlang
#         LET sr1.l_inal018_desc = '採購資料'
         EXECUTE insert_prep USING sr1.*
         CONTINUE FOREACH
      END IF
      SELECT gzcbl004 INTO sr1.l_inal018_desc
        FROM gzcbl_t
       WHERE gzcbl001 = '4046'
         AND gzcbl002 = '4'
         AND gzcbl003 = g_dlang
#      LET sr1.l_inal018_desc = '入庫資料'
      EXECUTE insert_prep USING sr1.*
      
      IF sr1.inal018 = '110' OR sr1.inal018 = '111' 
         OR sr1.inal018 = '112' OR sr1.inal018 = '113' 
         OR sr1.inal018 = '114' THEN 
         ##[C.庫存異動類型]='110','111','112','113','114'，依[C.單據編號]串至[T.完工入庫明細檔(sfec_t)]抓取[C.工單單號]
         LET g_sql = "SELECT DISTINCT '','',sfaadocno,'',sfaadoncdt,'','','','','','','','','','',",
                     "        '','','','','','','','' ",
                     " FROM sfaa_t,sfec_t",
                     " WHERE sfaaent = sfecent AND sfaasite = sfecsite AND sfaadocno = sfec001 ",
                     "   AND sfecent= ? AND sfecsite= ? ",
                     "   AND sfecdocno = ? ",
                     " ORDER BY sfaadocno,sfaadocdt"
         PREPARE ainr200_x01_pb5 FROM g_sql
         DECLARE b_fill_curs5 CURSOR FOR ainr200_x01_pb5 
         OPEN b_fill_curs5 USING g_enterprise,g_site,sr1.inal001
         FOREACH b_fill_curs5 INTO sr2.*
            LET g_id=g_id+1
            SELECT gzcbl004 INTO sr2.l_inal018_desc
              FROM gzcbl_t
             WHERE gzcbl001 = '4046'
               AND gzcbl002 = '6'
               AND gzcbl003 = g_dlang
#            LET sr2.l_inal018_desc = '工單'
            LET sr2.l_type = sr.l_type
            LET sr2.l_pid = sr1.l_id
            LET sr2.l_id = g_id
            EXECUTE insert_prep USING sr2.*
            CALL ainr200_x01_tree4(sr1.*,sr.*) #發料資料
       
         END FOREACH                      
      END IF
      IF sr1.inal018 = '103' OR sr1.inal018 = '104' 
         OR sr1.inal018 = '105' OR sr1.inal018 = '106' 
         OR sr1.inal018 = '107' THEN 
         LET g_sql = "SELECT DISTINCT '','',sfaadocno,'',sfaadoncdt,'','','','','','','','','','',",
                     "        '','','','','','','','' ",
                     " FROM sfaa_t,pmdv_t",
                     " WHERE sfaaent = pmdvent AND sfaasite = pmdvsite AND sfaadocno = pmdv014 ",
                     "   AND pmdvent= ? AND pmdvsite= ? ",
                     "   AND pmdvdocno = ? ",
                     " ORDER BY sfaadocno,sfaadocdt "
         PREPARE ainr200_x01_pb6 FROM g_sql
         DECLARE b_fill_curs6 CURSOR FOR ainr200_x01_pb6 
         OPEN b_fill_curs6 USING g_enterprise,g_site,sr1.inal001
         
         FOREACH b_fill_curs6 INTO sr2.*
            LET g_id=g_id+1
            LET sr2.l_inal018_desc = '工單'
            LET sr2.l_type = sr.l_type
            LET sr2.l_pid = sr1.l_id
            LET sr2.l_id = g_id
            EXECUTE insert_prep USING sr2.*
            CALL ainr200_x01_tree4(sr1.*,sr.*) #發料資料
        
         END FOREACH  
      END IF               
        
   END FOREACH 
END FUNCTION

#展開樹4階發料資料
PRIVATE FUNCTION ainr200_x01_tree4(sr,sr2)
   DEFINE sr   sr_s
   DEFINE sr1  sr_s
   DEFINE sr2  sr_s
   DEFINE l_id   LIKE type_t.num20
   DEFINE l_success LIKE type_t.num5
   LET l_id = 0
   OPEN ainr200_x01_curs4 USING sr2.inal006,sr2.inal009,sr2.inal010,sr2.inal011,sr2.inal012,sr2.inal013,sr.inal001 #發料
   FOREACH ainr200_x01_curs4 INTO sr1.*     
      LET sr1.l_type = sr.l_type + 1
      LET sr1.l_pid = sr.l_id
      LET sr1.l_id = l_id + 1
      LET l_id = sr1.l_id
      IF (sr1.l_inal009_desc = '.') THEN
         LET sr1.l_inal009_desc = sr1.inal009
      END IF
      IF (sr1.l_inal010_desc = '.') THEN
         LET sr1.l_inal010_desc = sr1.inal010
      END IF
      IF (sr1.l_inaj018_desc = '.') THEN
         LET sr1.l_inaj018_desc = sr1.inaj018
      END IF
      SELECT gzcbl004 INTO sr1.l_inal018_desc
        FROM gzcbl_t
       WHERE gzcbl001 = '4046'
         AND gzcbl002 = '5'
         AND gzcbl003 = g_dlang
#      LET sr.l_inal018_desc = '發料資料'
      EXECUTE insert_prep USING sr1.*
   --   CALL ainr200_x01_tree5(sr1.*)
         
   END FOREACH
END FUNCTION

#從材料到成品
PRIVATE FUNCTION ainr200_x01_define_cursor2()
  
   ##採購資料：依2步驟資料，抓取[T.製造批序號庫存交易明細檔(inal_t)].[C.庫存異動類型]='101','102''115'且[C.出入庫碼]="1"的資料
   LET g_sql = "SELECT DISTINCT '',inal018,inal001,inal002,inal017,inal006,imaal003,imaal004,inal009,(trim(inal009)||'.'||(trim(inayl003))),inal010,(trim(inal010)||'.'||trim(inab003)),inal011,inal012,inal013,",
               "        inal007,inal008,inaj044,inaj018,(trim(inaj018)||'.'||trim(pmaal003)),'','','' ",
               " FROM inal_t LEFT OUTER JOIN inaj_t ON inajent = inalent AND inajsite = inalsite AND inaj001 = inal001 AND inaj002 = inal002 AND inaj003 = inal003 AND inaj004 = inal005 ",
               "             LEFT OUTER JOIN imaal_t ON inalent = imaalent AND inal006 = imaal001 AND imaal002 = '",g_dlang,"' ",
               "             LEFT OUTER JOIN inayl_t ON inal009 = inayl001 AND inalent = inaylent AND inayl002 = '",g_dlang,"' ",
               "             LEFT OUTER JOIN inab_t ON inal009 = inab001 AND inalent = inabent AND inal010 = inab002 " ,
               "              LEFT OUTER JOIN pmaal_t ON inaj018 = pmaal001 AND inajent = pmaalent AND pmaal002 = '",g_dlang,"' ",
               " WHERE inalent= '",g_enterprise,"' AND inalsite= '",g_site,"' ",
               "   AND (((inal018 = '101' OR inal018 = '102' OR inal018 = '115') AND inal005 = 1) OR inal018 = '302' ) ",
               "   AND inal006= ? AND inal007= ? AND inal008= ?",
               "   AND inal011= ? AND inal012= ? AND inal013= ? ",
               " ORDER BY inal001,inal002,inal017"

   PREPARE ainr200_x01_2pb1 FROM g_sql
   DECLARE ainr200_x01_2curs1 CURSOR FOR ainr200_x01_2pb1   

   ##[C.庫存異動類型]='110','111','112','113','114'，依[C.單據編號]串至[T.完工入庫明細檔(sfec_t)]抓取[C.工單單號]
   LET g_sql = "SELECT DISTINCT '','',sfaadocno,'',sfaadoncdt,'','','','','','','','','','',",
               "        '','','','','','','','' ",
               "        FROM sfaa_t,sfdb_t",
               " WHERE sfaaent = sfdbent AND sfaasite = sfdbsite AND sfaadocno = sfdb001 ",
               "   AND sfdbent= '",g_enterprise,"' AND sfdbsite= '",g_site,"' ",
               "   AND sfdbdocno = ? ",
               " ORDER BY sfaadocno,sfaadocdt"
   PREPARE ainr200_x01_2pb2 FROM g_sql
   DECLARE ainr200_x01_2curs2 CURSOR FOR ainr200_x01_2pb2

   ##依入庫單號分別抓取該單之[T.製造批序號庫存交易明細檔(inal_t)].[C.庫存異動類型]='103','104','105','106','107''110','111','112','113','114'的資料
   LET g_sql = "SELECT DISTINCT '',inal018,inal001,inal002,inal017,inal006,imaal003,imaal004,inal009,(trim(inal009)||'.'||(trim(inayl003))),inal010,(trim(inal010)||'.'||trim(inab003)),inal011,inal012,inal013,",
               "        inal007,inal008,inaj044,inaj018,(trim(inaj018)||'.'||trim(pmaal003)),'','','' ",
               "  FROM inal_t LEFT OUTER JOIN inaj_t ON inajent = inalent AND inajsite = inalsite AND inaj001 = inal001 AND inaj002 = inal002 AND inaj003 = inal003 AND inaj004 = inal005 ",
               "              LEFT OUTER JOIN imaal_t ON inalent = imaalent AND inal006 = imaal001 AND imaal002 = '",g_dlang,"' ",
               "              LEFT OUTER JOIN inayl_t ON inal009 = inayl001 AND inalent = inaylent AND inayl002 = '",g_dlang,"' ",
               "              LEFT OUTER JOIN inab_t ON inal009 = inab001 AND inalent = inabent AND inal010 = inab002 " ,
               "              LEFT OUTER JOIN pmaal_t ON inaj018 = pmaal001 AND inajent = pmaalent AND pmaal002 = '",g_dlang,"' ",
               "              LEFT OUTER JOIN sfec_t ON inal001 = sfecdocno AND inalent = sfecent " ,
               " WHERE inalent= '",g_enterprise,"' AND inalsite= '",g_site,"' ",
               "   AND (inal018 = '103' OR inal018 = '104' OR inal018 = '105' OR inal018 = '106' ",
               "        OR inal018 = '107' OR inal018 = '110' OR inal018 = '111' OR inal018 = '112' OR inal018 = '113' OR inal018 = '114')  ",
               "   AND sfec001 = ?",
               " ORDER BY inal001,inal002,inal017"

   PREPARE ainr200_x01_2pb3 FROM g_sql
   DECLARE ainr200_x01_2curs3 CURSOR FOR ainr200_x01_2pb3
   
   ##出貨資料：抓取[T.製造批序號庫存交易明細檔(inal_t)].[C.庫存異動類型]='201','301'且[C.出入庫碼]="-1"的資料
   LET g_sql = "SELECT DISTINCT '',inal018,inal001,inal002,inal017,inal006,imaal003,imaal004,inal009,(trim(inal009)||'.'||(trim(inayl003))),inal010,(trim(inal010)||'.'||trim(inab003)),inal011,inal012,inal013,",
               "        inal007,inal008,inaj044,inaj018,(trim(inaj018)||'.'||trim(pmaal003)),'','','' ",
               " FROM inal_t LEFT OUTER JOIN inaj_t ON inajent = inalent AND inajsite = inalsite AND inaj001 = inal001 AND inaj002 = inal002 AND inaj003 = inal003 AND inaj004 = inal005 ",
               "             LEFT OUTER JOIN imaal_t ON inalent = imaalent AND inal006 = imaal001 AND imaal002 = '",g_dlang,"' ",
               "             LEFT OUTER JOIN inayl_t ON inal009 = inayl001 AND inalent = inaylent AND inayl002 = '",g_dlang,"' ",
               "             LEFT OUTER JOIN inab_t ON inal009 = inab001 AND inalent = inabent AND inal010 = inab002 " ,
               "             LEFT OUTER JOIN pmaal_t ON inaj018 = pmaal001 AND inajent = pmaalent AND pmaal002 = '",g_dlang,"' ",
               " WHERE inalent= '",g_enterprise,"' AND inalsite= '",g_site,"' ",
               " AND (inal018 = '201' OR inal018 = '301') AND inal005 = -1 ",
               "   AND inal006= ? AND inal009= ? AND inal010= ?",
               "   AND inal011= ? AND inal012= ? AND inal013= ? ",
               " ORDER BY inal001,inal002,inal017"

   PREPARE ainr200_x01_2pb4 FROM g_sql
   DECLARE ainr200_x01_2curs4 CURSOR FOR ainr200_x01_2pb4
   
   LET g_sql ="SELECT DISTINCT '',inal018,inal001,inal002,inal017,inal006,imaal003,imaal004,inal009,(trim(inal009)||'.'||(trim(inayl003))),inal010,(trim(inal010)||'.'||trim(inab003)),inal011,inal012,inal013,",
               "       inal007,inal008,inaj044,inaj018,(trim(inaj018)||'.'||trim(pmaal003)),'','','' ",
               "  FROM inal_t LEFT OUTER JOIN inaj_t ON inajent = inalent AND inajsite = inalsite AND inaj001 = inal001 AND inaj002 = inal002 AND inaj003 = inal003 AND inaj004 = inal005 ",
               "              LEFT OUTER JOIN imaal_t ON inalent = imaalent AND inal006 = imaal001 AND imaal002 = '",g_dlang,"' ",
               "              LEFT OUTER JOIN inayl_t ON inal009 = inayl001 AND inalent = inaylent AND inayl002 = '",g_dlang,"' ",
               "              LEFT OUTER JOIN inab_t ON inal009 = inab001 AND inalent = inabent AND inal010 = inab002 " ,
               "              LEFT OUTER JOIN pmaal_t ON inaj018 = pmaal001 AND inajent = pmaalent AND pmaal002 = '",g_dlang,"' ",
               "              LEFT OUTER JOIN xmdl_t ON inalent = xmdlent AND inal001 = xmdldocno",
               " WHERE inalent= '",g_enterprise,"' AND inalsite= '",g_site,"' ",
               "   AND inalent= ? AND inalsite= ? AND inaj036 = '202' ",
               "   AND inal006= ? AND inal009= ? AND inal010= ?",
               "   AND inal011= ? AND inal012= ? AND inal013= ? ",
               "   AND xmdl001 = ? ",
               " ORDER BY inal001,inal002,inal017"

   PREPARE ainr200_x01_2pb5 FROM g_sql
   DECLARE ainr200_x01_2curs5 CURSOR FOR ainr200_x01_2pb5
END FUNCTION

#從材料到成品
#展開樹1階採購單
PRIVATE FUNCTION ainr200_x01_ltree1(sr)
   DEFINE sr   sr_s
   DEFINE sr1  sr_s
   DEFINE l_id   LIKE type_t.num20
   DEFINE l_success LIKE type_t.num5
   LET l_id = 0

   OPEN ainr200_x01_2curs1 USING sr.inal006,sr.inal009,sr.inal010,sr.inal011,sr.inal012,sr.inal013 #採購單
   FOREACH ainr200_x01_2curs1 INTO sr1.*
      LET sr1.l_type = sr.l_type + 1
      LET sr1.l_pid = sr.l_id
      LET sr1.l_id = l_id + 1
      LET l_id = sr1.l_id
      IF (sr1.l_inal009_desc = '.') THEN
         LET sr1.l_inal009_desc = sr1.inal009
      END IF
      IF (sr1.l_inal010_desc = '.') THEN
         LET sr1.l_inal010_desc = sr1.inal010
      END IF
      IF (sr1.l_inaj018_desc = '.') THEN
         LET sr1.l_inaj018_desc = sr1.inaj018
      END IF
      SELECT gzcbl004 INTO sr1.l_inal018_desc
        FROM gzcbl_t
       WHERE gzcbl001 = '4046'
         AND gzcbl002 = '3'
         AND gzcbl003 = g_dlang
#         LET sr1.l_inal018_desc = '採購單'
         
         EXECUTE insert_prep USING sr1.*

   END FOREACH
END FUNCTION

#從材料到成品
#展開樹2階工單單號
PRIVATE FUNCTION ainr200_x01_ltree2(sr)
   DEFINE sr   sr_s
   DEFINE sr1  sr_s
   DEFINE l_id   LIKE type_t.num20
   DEFINE l_success LIKE type_t.num5
   LET l_id = 0
   OPEN ainr200_x01_2curs2 USING sr.inal001
   FOREACH ainr200_x01_2curs2 INTO sr1.*
      LET sr1.l_type = sr.l_type + 1
      LET sr1.l_pid = sr.l_id
      LET sr1.l_id = l_id + 1
      LET l_id = sr1.l_id
      IF (sr1.l_inal009_desc = '.') THEN
         LET sr1.l_inal009_desc = sr1.inal009
      END IF
      IF (sr1.l_inal010_desc = '.') THEN
         LET sr1.l_inal010_desc = sr1.inal010
      END IF
      IF (sr1.l_inaj018_desc = '.') THEN
         LET sr1.l_inaj018_desc = sr1.inaj018
      END IF
      SELECT gzcbl004 INTO sr1.l_inal018_desc
        FROM gzcbl_t
       WHERE gzcbl001 = '4046'
         AND gzcbl002 = '6'
         AND gzcbl003 = g_dlang
#      LET sr1.l_inal018_desc = '工單'
      EXECUTE insert_prep USING sr1.*
      CALL ainr200_x01_ltree3(sr1.*)
       
   END FOREACH   
END FUNCTION

#從材料到成品
#展開樹3階入庫單
PRIVATE FUNCTION ainr200_x01_ltree3(sr)
   DEFINE sr   sr_s
   DEFINE sr1  sr_s
   DEFINE l_id   LIKE type_t.num20
   DEFINE l_success LIKE type_t.num5
   LET l_id = 0
##依入庫單號分別抓取該單之[T.製造批序號庫存交易明細檔(inal_t)].[C.庫存異動類型]='103','104','105','106','107''110','111','112','113','114'的資料
   OPEN ainr200_x01_2curs3 USING sr.inal001
   FOREACH ainr200_x01_2curs4 INTO sr1.*
      LET sr1.l_type = sr.l_type + 1
      LET sr1.l_pid = sr.l_id
      LET sr1.l_id = l_id + 1
      LET l_id = sr1.l_id
      IF (sr1.l_inal009_desc = '.') THEN
         LET sr1.l_inal009_desc = sr1.inal009
      END IF
      IF (sr1.l_inal010_desc = '.') THEN
         LET sr1.l_inal010_desc = sr1.inal010
      END IF
      IF (sr1.l_inaj018_desc = '.') THEN
         LET sr1.l_inaj018_desc = sr1.inaj018
      END IF
      SELECT gzcbl004 INTO sr1.l_inal018_desc
        FROM gzcbl_t
       WHERE gzcbl001 = '4046'
         AND gzcbl002 = '4'
         AND gzcbl003 = g_dlang
#      LET sr1.l_inal018_desc = '入庫單'
      EXECUTE insert_prep USING sr1.*
      CALL ainr200_x01_ltree4(sr1.*)
   END FOREACH   
END FUNCTION

#從材料到成品
#展開樹4階出貨單
PRIVATE FUNCTION ainr200_x01_ltree4(sr)
   DEFINE sr   sr_s
   DEFINE sr1  sr_s
   DEFINE l_id   LIKE type_t.num20
   DEFINE l_success LIKE type_t.num5
   LET l_id = 0
   OPEN ainr200_x01_2curs4 USING sr.inal006,sr.inal009,sr.inal010,sr.inal011,sr.inal012,sr.inal013 #出貨單
   FOREACH ainr200_x01_2curs4 INTO sr1.*
      LET sr1.l_type = sr.l_type + 1
      LET sr1.l_pid = sr.l_id
      LET sr1.l_id = l_id + 1
      LET l_id = sr1.l_id
      SELECT gzcbl004 INTO sr1.l_inal018_desc
        FROM gzcbl_t
       WHERE gzcbl001 = '4046'
         AND gzcbl002 = '2'
         AND gzcbl003 = g_dlang
#      LET sr1.l_inal018_desc = '出貨單'
      IF (sr1.l_inal009_desc = '.') THEN
         LET sr1.l_inal009_desc = sr1.inal009
      END IF
      IF (sr1.l_inal010_desc = '.') THEN
         LET sr1.l_inal010_desc = sr1.inal010
      END IF
      IF (sr1.l_inaj018_desc = '.') THEN
         LET sr1.l_inaj018_desc = sr1.inaj018
      END IF
      EXECUTE insert_prep USING sr1.*
      CALL ainr200_x01_ltree5(sr1.*) 
   END FOREACH 
END FUNCTION

#從材料到成品
#展開樹5階銷退單
PRIVATE FUNCTION ainr200_x01_ltree5(sr)
   DEFINE sr   sr_s
   DEFINE sr1  sr_s
   DEFINE l_id   LIKE type_t.num20
   DEFINE l_success LIKE type_t.num5
   LET l_id = 0
   OPEN ainr200_x01_2curs5 USING sr.inal006,sr.inal009,sr.inal010,sr.inal011,sr.inal012,sr.inal013,sr.inal001 #銷退單
   FOREACH ainr200_x01_2curs5 INTO sr1.*
      LET sr1.l_type = sr.l_type + 1
      LET sr1.l_pid = sr.l_id
      LET sr1.l_id = l_id + 1
      LET l_id = sr1.l_id
      IF (sr1.l_inal009_desc = '.') THEN
         LET sr1.l_inal009_desc = sr1.inal009
      END IF
      IF (sr1.l_inal010_desc = '.') THEN
         LET sr1.l_inal010_desc = sr1.inal010
      END IF
      IF (sr1.l_inaj018_desc = '.') THEN
         LET sr1.l_inaj018_desc = sr1.inaj018
      END IF
      SELECT gzcbl004 INTO sr1.l_inal018_desc
        FROM gzcbl_t
       WHERE gzcbl001 = '4046'
         AND gzcbl002 = '1'
         AND gzcbl003 = g_dlang
#      LET sr1.l_inal018_desc = '銷退單'
      EXECUTE insert_prep USING sr1.*
   END FOREACH 
END FUNCTION

 
{</section>}
 
