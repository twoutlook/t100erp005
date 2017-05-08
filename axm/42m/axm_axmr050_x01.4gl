#該程式未解開Section, 採用最新樣板產出!
{<section id="axmr050_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2016-08-05 09:32:55), PR版次:0002(2016-08-05 13:52:45)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000042
#+ Filename...: axmr050_x01
#+ Description: ...
#+ Creator....: 02210(2015-07-06 11:32:47)
#+ Modifier...: 08742 -SD/PR- 08742
 
{</section>}
 
{<section id="axmr050_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"

#end add-point
#add-point:填寫註解說明 name="global.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="global.import"
#160727-00019#25  2016/08/5 By 08742        系统中定义的临时表名称超过15码在执行时会出错,将系统中定义的临时表长度超过15码的改掉
#                                           Mod   axmr050_x01_temp--> axmr050_temp01
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../cfg/top_report.inc"                  #報表使用的global
 
#報表 type 宣告
DEFINE tm RECORD
       wc STRING,                  #where condtion 
       bdate LIKE type_t.dat,         #訂單日期-起 
       edate LIKE type_t.dat          #訂單日期-迄
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="axmr050_x01.main" readonly="Y" >}
PUBLIC FUNCTION axmr050_x01(p_arg1,p_arg2,p_arg3)
DEFINE  p_arg1 STRING                  #tm.wc  where condtion 
DEFINE  p_arg2 LIKE type_t.dat         #tm.bdate  訂單日期-起 
DEFINE  p_arg3 LIKE type_t.dat         #tm.edate  訂單日期-迄
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.bdate = p_arg2
   LET tm.edate = p_arg3
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "axmr050_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL axmr050_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL axmr050_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL axmr050_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL axmr050_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL axmr050_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="axmr050_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION axmr050_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "xmda015.xmda_t.xmda015,xmdc001.xmdc_t.xmdc001,l_xmda004_pmaal004.type_t.chr100,l_price_min.type_t.num20_6,l_price_avg.type_t.num20_6,l_price_max.type_t.num20_6,l_price_recent.type_t.num20_6,l_imaa127.type_t.chr30,l_imaa127_desc.type_t.chr50,l_imaa127desc.type_t.chr80" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   DROP TABLE axmr050_x01_temp;         #160727-00019#25 Mod  axmr050_x01_temp--> axmr050_temp01

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop axmr050_temp01'       #160727-00019#25 Mod  axmr050_x01_temp--> axmr050_temp01
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_rep_success = 'N'
      RETURN
   END IF
   
   CREATE TEMP TABLE axmr050_temp01(           #160727-00019#25 Mod  axmr050_x01_temp--> axmr050_temp01
                   xmdadocdt              DATE,        #訂單日期
                   xmdacnfdt              DATETIME YEAR TO SECOND,        #確認日期
                   xmda015                VARCHAR(10),          #幣別
                   xmdc001                VARCHAR(40),          #料號
                   l_xmda004_pmaal004     VARCHAR(100),           #客戶(含說明)
                   price                  DECIMAL(20,6)     #未稅價格
                   )

   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create axmr050_temp01'           #160727-00019#25 Mod  axmr050_x01_temp--> axmr050_temp01
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_rep_success = 'N'
      RETURN
   END IF
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="axmr050_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION axmr050_x01_ins_prep()
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
             ?,?,?,?)"
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
 
{<section id="axmr050_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axmr050_x01_sel_prep()
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
   LET g_select = " SELECT xmda001,xmda002,xmda003,xmda004,xmda005,xmda006,xmda007,xmda008,xmda009,xmda010, 
       xmda011,xmda012,xmda013,xmda015,xmda016,xmda017,xmda018,xmda019,xmda020,xmda021,xmda022,xmda023, 
       xmda024,xmda025,xmda026,xmda027,xmda028,xmda030,xmda031,xmda032,xmda033,xmda034,xmda035,xmda036, 
       xmda037,xmda038,xmda039,xmda041,xmda042,xmda043,xmda044,xmda045,xmda046,xmda047,xmda048,xmda049, 
       xmda050,xmda071,xmda203,xmdadocdt,xmdadocno,xmdaent,xmdasite,xmdastus,xmdaunit,xmdacnfdt,xmdc001, 
       xmdc002,xmdc003,xmdc006,xmdc007,xmdc008,xmdc009,xmdc010,xmdc011,xmdc012,xmdc013,xmdc015,xmdc016, 
       xmdc017,xmdc019,xmdc020,xmdc021,xmdc022,xmdc023,xmdc024,xmdc025,xmdc026,xmdc027,xmdc028,xmdc029, 
       xmdc030,xmdc031,xmdc032,xmdc033,xmdc035,xmdc036,xmdc037,xmdc038,xmdc039,xmdc040,xmdc041,xmdc042, 
       xmdc043,xmdc044,xmdc045,xmdc046,xmdc047,xmdc048,xmdc049,xmdc050,xmdc052,xmdc053,xmdc054,xmdc057, 
       xmdc058,xmdc059,xmdc060,xmdc061,xmdcorga,xmdcseq,xmdcsite,xmdcunit,( SELECT pmaal003 FROM pmaal_t t1 WHERE t1.pmaal001 = xmda_t.xmda034 AND t1.pmaalent = xmda_t.xmdaent AND t1.pmaal002 = '" , 
       g_dlang,"'" ,"),( SELECT pmaal003 FROM pmaal_t t5 WHERE t5.pmaal001 = xmda_t.xmda203 AND t5.pmaalent = xmda_t.xmdaent AND t5.pmaal002 = '" , 
       g_dlang,"'" ,"),( SELECT pmaal003 FROM pmaal_t t8 WHERE t8.pmaal001 = xmda_t.xmda021 AND t8.pmaalent = xmda_t.xmdaent AND t8.pmaal002 = '" , 
       g_dlang,"'" ,"),( SELECT pmaal003 FROM pmaal_t t9 WHERE t9.pmaal001 = xmda_t.xmda022 AND t9.pmaalent = xmda_t.xmdaent AND t9.pmaal002 = '" , 
       g_dlang,"'" ,"),( SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmda_t.xmda036 AND pmaal_t.pmaalent = xmda_t.xmdaent AND pmaal_t.pmaal002 = '" , 
       g_dlang,"'" ,"),( SELECT pmaal004 FROM pmaal_t t4 WHERE t4.pmaal001 = xmda_t.xmda004 AND t4.pmaalent = xmda_t.xmdaent AND t4.pmaal002 = '" , 
       g_dlang,"'" ,"),x.imaal_t_imaal003,x.t17_imaal003,trim(xmda036)||'.'||trim((SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmda_t.xmda036 AND pmaal_t.pmaalent = xmda_t.xmdaent AND pmaal_t.pmaal002 = '" , 
       g_dlang,"'" ,")),trim(xmda022)||'.'||trim((SELECT pmaal003 FROM pmaal_t t9 WHERE t9.pmaal001 = xmda_t.xmda022 AND t9.pmaalent = xmda_t.xmdaent AND t9.pmaal002 = '" , 
       g_dlang,"'" ,")),trim(xmda021)||'.'||trim((SELECT pmaal003 FROM pmaal_t t8 WHERE t8.pmaal001 = xmda_t.xmda021 AND t8.pmaalent = xmda_t.xmdaent AND t8.pmaal002 = '" , 
       g_dlang,"'" ,")),trim(xmda203)||'.'||trim((SELECT pmaal003 FROM pmaal_t t5 WHERE t5.pmaal001 = xmda_t.xmda203 AND t5.pmaalent = xmda_t.xmdaent AND t5.pmaal002 = '" , 
       g_dlang,"'" ,")),trim(xmda034)||'.'||trim((SELECT pmaal003 FROM pmaal_t t1 WHERE t1.pmaal001 = xmda_t.xmda034 AND t1.pmaalent = xmda_t.xmdaent AND t1.pmaal002 = '" , 
       g_dlang,"'" ,")),trim(xmda004)||'.'||trim((SELECT pmaal004 FROM pmaal_t t4 WHERE t4.pmaal001 = xmda_t.xmda004 AND t4.pmaalent = xmda_t.xmdaent AND t4.pmaal002 = '" , 
       g_dlang,"'" ,")),0,0,0,0,'','',''"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   
   #end add-point
    LET g_from = " FROM xmda_t LEFT OUTER JOIN ( SELECT xmdc_t.*,( SELECT imaal003 FROM imaal_t WHERE imaal_t.imaal001 = xmdc_t.xmdc003 AND imaal_t.imaalent = xmdc_t.xmdcent AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,") imaal_t_imaal003,( SELECT imaal003 FROM imaal_t t17 WHERE t17.imaal001 = xmdc_t.xmdc001 AND t17.imaalent = xmdc_t.xmdcent AND t17.imaal002 = '" , 
        g_dlang,"'" ,") t17_imaal003 FROM xmdc_t ) x  ON xmda_t.xmdaent = x.xmdcent AND xmda_t.xmdadocno  
        = x.xmdcdocno"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
 
   #end add-point
    LET g_where = " WHERE xmda_t.xmdastus = 'Y' AND " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   LET g_from = g_from,
       "             LEFT OUTER JOIN pmaa_t t10 ON t10.pmaa001 = xmda_t.xmda004 AND t10.pmaaent = xmda_t.xmdaent ",
       "             LEFT OUTER JOIN imaa_t t18 ON t18.imaa001 = x.xmdc001 AND t18.imaaent = x.xmdcent"
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("xmda_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   PREPARE axmr050_x01_prepare2 FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE axmr050_x01_curs2 CURSOR FOR axmr050_x01_prepare2

   #step3.從TEMP TABLE撈取-全部廠商
   LET g_select = " SELECT DISTINCT 
                    '', '', '', '', '', '', '', '', '', '', 
                    '', '', '', xmda015, '', '', '', '', '', '', 
                    '', '', '', '', '', '', '', '', '', '', 
                    '', '', '', '', '', '', '', '', '', '', 
                    '', '', '', '', '', '', '', '', '', '', 
                    '', '', '', '', '', '',
                    xmdc001, '', '', '', '', '', '', '', '', '', 
                    '', '', '', '', '', '', '', '', '', '', 
                    '', '', '', '', '', '', '', '', '', '', 
                    '', '', '', '', '', '', '', '', '', '', 
                    '', '', '', '', '', '', '', '', '', '', 
                    '', '', '', '', '', '', '', 
                    '', '', '', '', '', '', '', '',
                    '', '', '', '', '', '', 0, 0, 0, 0,'','','' "


   LET g_from  = " FROM axmr050_temp01"        #160727-00019#25 Mod  axmr050_x01_temp--> axmr050_temp01
   LET g_where = " WHERE 1=1"
    
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   
   PREPARE axmr050_x01_prepare3 FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE axmr050_x01_curs3 CURSOR FOR axmr050_x01_prepare3

   #step1.從TEMP TABLE撈資料-單一廠商
   LET g_select = " SELECT DISTINCT 
                    '', '', '', '', '', '', '', '', '', '', 
                    '', '', '', xmda015, '', '', '', '', '', '', 
                    '', '', '', '', '', '', '', '', '', '', 
                    '', '', '', '', '', '', '', '', '', '', 
                    '', '', '', '', '', '', '', '', '', '', 
                    '', '', '', '', '',  '',
                    xmdc001, '', '', '', '', '', '', '', '', '', 
                    '', '', '', '', '', '', '', '', '', '', 
                    '', '', '', '', '', '', '', '', '', '', 
                    '', '', '', '', '', '', '', '', '', '', 
                    '', '', '', '', '', '', '', '', '', '', 
                    '', '', '', '', '', '', '', 
                    '', '', '', '', '', '', '', '',
                    '', '', '', '', '', l_xmda004_pmaal004, 0, 0, 0, 0,'','','' "


   LET g_from  = " FROM axmr050_temp01"       #160727-00019#25 Mod  axmr050_x01_temp--> axmr050_temp01
   LET g_where = " WHERE 1=1"
    
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED

   #end add-point
   PREPARE axmr050_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE axmr050_x01_curs CURSOR FOR axmr050_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="axmr050_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION axmr050_x01_ins_data()
DEFINE sr RECORD 
   xmda001 LIKE xmda_t.xmda001, 
   xmda002 LIKE xmda_t.xmda002, 
   xmda003 LIKE xmda_t.xmda003, 
   xmda004 LIKE xmda_t.xmda004, 
   xmda005 LIKE xmda_t.xmda005, 
   xmda006 LIKE xmda_t.xmda006, 
   xmda007 LIKE xmda_t.xmda007, 
   xmda008 LIKE xmda_t.xmda008, 
   xmda009 LIKE xmda_t.xmda009, 
   xmda010 LIKE xmda_t.xmda010, 
   xmda011 LIKE xmda_t.xmda011, 
   xmda012 LIKE xmda_t.xmda012, 
   xmda013 LIKE xmda_t.xmda013, 
   xmda015 LIKE xmda_t.xmda015, 
   xmda016 LIKE xmda_t.xmda016, 
   xmda017 LIKE xmda_t.xmda017, 
   xmda018 LIKE xmda_t.xmda018, 
   xmda019 LIKE xmda_t.xmda019, 
   xmda020 LIKE xmda_t.xmda020, 
   xmda021 LIKE xmda_t.xmda021, 
   xmda022 LIKE xmda_t.xmda022, 
   xmda023 LIKE xmda_t.xmda023, 
   xmda024 LIKE xmda_t.xmda024, 
   xmda025 LIKE xmda_t.xmda025, 
   xmda026 LIKE xmda_t.xmda026, 
   xmda027 LIKE xmda_t.xmda027, 
   xmda028 LIKE xmda_t.xmda028, 
   xmda030 LIKE xmda_t.xmda030, 
   xmda031 LIKE xmda_t.xmda031, 
   xmda032 LIKE xmda_t.xmda032, 
   xmda033 LIKE xmda_t.xmda033, 
   xmda034 LIKE xmda_t.xmda034, 
   xmda035 LIKE xmda_t.xmda035, 
   xmda036 LIKE xmda_t.xmda036, 
   xmda037 LIKE xmda_t.xmda037, 
   xmda038 LIKE xmda_t.xmda038, 
   xmda039 LIKE xmda_t.xmda039, 
   xmda041 LIKE xmda_t.xmda041, 
   xmda042 LIKE xmda_t.xmda042, 
   xmda043 LIKE xmda_t.xmda043, 
   xmda044 LIKE xmda_t.xmda044, 
   xmda045 LIKE xmda_t.xmda045, 
   xmda046 LIKE xmda_t.xmda046, 
   xmda047 LIKE xmda_t.xmda047, 
   xmda048 LIKE xmda_t.xmda048, 
   xmda049 LIKE xmda_t.xmda049, 
   xmda050 LIKE xmda_t.xmda050, 
   xmda071 LIKE xmda_t.xmda071, 
   xmda203 LIKE xmda_t.xmda203, 
   xmdadocdt LIKE xmda_t.xmdadocdt, 
   xmdadocno LIKE xmda_t.xmdadocno, 
   xmdaent LIKE xmda_t.xmdaent, 
   xmdasite LIKE xmda_t.xmdasite, 
   xmdastus LIKE xmda_t.xmdastus, 
   xmdaunit LIKE xmda_t.xmdaunit, 
   xmdacnfdt LIKE xmda_t.xmdacnfdt, 
   xmdc001 LIKE xmdc_t.xmdc001, 
   xmdc002 LIKE xmdc_t.xmdc002, 
   xmdc003 LIKE xmdc_t.xmdc003, 
   xmdc006 LIKE xmdc_t.xmdc006, 
   xmdc007 LIKE xmdc_t.xmdc007, 
   xmdc008 LIKE xmdc_t.xmdc008, 
   xmdc009 LIKE xmdc_t.xmdc009, 
   xmdc010 LIKE xmdc_t.xmdc010, 
   xmdc011 LIKE xmdc_t.xmdc011, 
   xmdc012 LIKE xmdc_t.xmdc012, 
   xmdc013 LIKE xmdc_t.xmdc013, 
   xmdc015 LIKE xmdc_t.xmdc015, 
   xmdc016 LIKE xmdc_t.xmdc016, 
   xmdc017 LIKE xmdc_t.xmdc017, 
   xmdc019 LIKE xmdc_t.xmdc019, 
   xmdc020 LIKE xmdc_t.xmdc020, 
   xmdc021 LIKE xmdc_t.xmdc021, 
   xmdc022 LIKE xmdc_t.xmdc022, 
   xmdc023 LIKE xmdc_t.xmdc023, 
   xmdc024 LIKE xmdc_t.xmdc024, 
   xmdc025 LIKE xmdc_t.xmdc025, 
   xmdc026 LIKE xmdc_t.xmdc026, 
   xmdc027 LIKE xmdc_t.xmdc027, 
   xmdc028 LIKE xmdc_t.xmdc028, 
   xmdc029 LIKE xmdc_t.xmdc029, 
   xmdc030 LIKE xmdc_t.xmdc030, 
   xmdc031 LIKE xmdc_t.xmdc031, 
   xmdc032 LIKE xmdc_t.xmdc032, 
   xmdc033 LIKE xmdc_t.xmdc033, 
   xmdc035 LIKE xmdc_t.xmdc035, 
   xmdc036 LIKE xmdc_t.xmdc036, 
   xmdc037 LIKE xmdc_t.xmdc037, 
   xmdc038 LIKE xmdc_t.xmdc038, 
   xmdc039 LIKE xmdc_t.xmdc039, 
   xmdc040 LIKE xmdc_t.xmdc040, 
   xmdc041 LIKE xmdc_t.xmdc041, 
   xmdc042 LIKE xmdc_t.xmdc042, 
   xmdc043 LIKE xmdc_t.xmdc043, 
   xmdc044 LIKE xmdc_t.xmdc044, 
   xmdc045 LIKE xmdc_t.xmdc045, 
   xmdc046 LIKE xmdc_t.xmdc046, 
   xmdc047 LIKE xmdc_t.xmdc047, 
   xmdc048 LIKE xmdc_t.xmdc048, 
   xmdc049 LIKE xmdc_t.xmdc049, 
   xmdc050 LIKE xmdc_t.xmdc050, 
   xmdc052 LIKE xmdc_t.xmdc052, 
   xmdc053 LIKE xmdc_t.xmdc053, 
   xmdc054 LIKE xmdc_t.xmdc054, 
   xmdc057 LIKE xmdc_t.xmdc057, 
   xmdc058 LIKE xmdc_t.xmdc058, 
   xmdc059 LIKE xmdc_t.xmdc059, 
   xmdc060 LIKE xmdc_t.xmdc060, 
   xmdc061 LIKE xmdc_t.xmdc061, 
   xmdcorga LIKE xmdc_t.xmdcorga, 
   xmdcseq LIKE xmdc_t.xmdcseq, 
   xmdcsite LIKE xmdc_t.xmdcsite, 
   xmdcunit LIKE xmdc_t.xmdcunit, 
   t1_pmaal003 LIKE pmaal_t.pmaal003, 
   t5_pmaal003 LIKE pmaal_t.pmaal003, 
   t8_pmaal003 LIKE pmaal_t.pmaal003, 
   t9_pmaal003 LIKE pmaal_t.pmaal003, 
   pmaal_t_pmaal004 LIKE pmaal_t.pmaal004, 
   t4_pmaal004 LIKE pmaal_t.pmaal004, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   x_t17_imaal003 LIKE imaal_t.imaal003, 
   l_xmda036_pmaal004 LIKE type_t.chr100, 
   l_xmda022_pmaal003 LIKE type_t.chr300, 
   l_xmda021_pmaal003 LIKE type_t.chr300, 
   l_xmda203_pmaal003 LIKE type_t.chr300, 
   l_xmda034_pmaal003 LIKE type_t.chr300, 
   l_xmda004_pmaal004 LIKE type_t.chr100, 
   l_price_min LIKE type_t.num20_6, 
   l_price_avg LIKE type_t.num20_6, 
   l_price_max LIKE type_t.num20_6, 
   l_price_recent LIKE type_t.num20_6, 
   l_imaa127 LIKE type_t.chr30, 
   l_imaa127_desc LIKE type_t.chr50, 
   l_imaa127desc LIKE type_t.chr80
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
   DEFINE l_price      LIKE type_t.num20_6    #單價(未稅)
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_oodbl004   LIKE oodbl_t.oodbl004  #稅別名稱
   DEFINE l_oodb005    LIKE oodb_t.oodb005    #含稅否
   DEFINE l_oodb006    LIKE oodb_t.oodb006    #稅率
   DEFINE l_oodb011    LIKE oodb_t.oodb011    #取得稅別類型1:正常稅率2:依料件設
   DEFINE l_price_sum  LIKE type_t.num20_6    #單價總和
   DEFINE l_price_cnt  LIKE type_t.num20_6    #資料筆數
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    LET g_rep_success = 'Y'

    FOREACH axmr050_x01_curs2 INTO sr.*                               
       IF STATUS THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = 'foreach:'
          LET g_errparam.code   = STATUS
          LET g_errparam.popup  = TRUE
          CALL cl_err()
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF

       #稅別檔
       CALL s_tax_chk(sr.xmdasite,sr.xmdc016)
          RETURNING l_success,l_oodbl004,l_oodb005,l_oodb006,l_oodb011

       LET l_price = 0
       IF l_oodb005 = 'Y' THEN   #單價含稅否
          LET l_price = sr.xmdc015 / (1 + l_oodb006/100)
       ELSE
          LET l_price = sr.xmdc015
       END IF       

       #整理未稅單價至TEMP TABLE
       INSERT INTO axmr050_temp01 VALUES (sr.xmdadocdt,sr.xmdacnfdt,sr.xmda015,sr.xmdc001,sr.l_xmda004_pmaal004,l_price)        #160727-00019#25 Mod  axmr050_x01_temp--> axmr050_temp01
       
    END FOREACH
    
    IF g_rep_success = 'N' THEN
       RETURN
    END IF
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH axmr050_x01_curs INTO sr.*                               
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
       #系列  20150819 by dorislai add   (S)
          #用料號抓取系列
       SELECT imaa127 INTO sr.l_imaa127 FROM imaa_t
        WHERE imaa001 = sr.xmdc001
          AND imaaent = g_enterprise
          #抓取系列說明
       CALL s_desc_get_acc_desc('2003',sr.l_imaa127)  RETURNING sr.l_imaa127_desc   
       IF NOT cl_null(sr.l_imaa127_desc) THEN
          LET sr.l_imaa127desc = sr.l_imaa127,'.',sr.l_imaa127_desc 
       END IF
       #      20150819 by dorislai add   (E)
       #總和,資料筆數
       LET l_price_sum = 0
       LET l_price_cnt = 0
       SELECT SUM(price),COUNT(price) INTO l_price_sum,l_price_cnt
         FROM axmr050_temp01      #160727-00019#25 Mod  axmr050_x01_temp--> axmr050_temp01
        WHERE xmda015 = sr.xmda015                         #幣別
          AND xmdc001 = sr.xmdc001                         #料號
          AND l_xmda004_pmaal004 = sr.l_xmda004_pmaal004   #客戶(含說明)
       IF cl_null(l_price_sum) THEN LET l_price_sum = 0 END IF
       IF cl_null(l_price_cnt) THEN LET l_price_cnt = 0 END IF
       
       #最低價格
       SELECT MIN(price) INTO sr.l_price_min
         FROM axmr050_temp01        #160727-00019#25 Mod  axmr050_x01_temp--> axmr050_temp01
        WHERE xmda015 = sr.xmda015                         #幣別
          AND xmdc001 = sr.xmdc001                         #料號
          AND l_xmda004_pmaal004 = sr.l_xmda004_pmaal004   #客戶(含說明)
       IF cl_null(sr.l_price_min) THEN LET sr.l_price_min = 0 END IF
       
       #最高價格
       SELECT MAX(price) INTO sr.l_price_max
         FROM axmr050_temp01           #160727-00019#25 Mod  axmr050_x01_temp--> axmr050_temp01
        WHERE xmda015 = sr.xmda015                         #幣別
          AND xmdc001 = sr.xmdc001                         #料號
          AND l_xmda004_pmaal004 = sr.l_xmda004_pmaal004   #客戶(含說明)
       IF cl_null(sr.l_price_max) THEN LET sr.l_price_max = 0 END IF
       
       #平均價格
       LET sr.l_price_avg = l_price_sum / l_price_cnt

       #最近價格
       DECLARE axmr050_x01_pric_cs CURSOR FOR 
          SELECT price
            FROM axmr050_temp01        #160727-00019#25 Mod  axmr050_x01_temp--> axmr050_temp01
           WHERE xmda015 = sr.xmda015                         #幣別
             AND xmdc001 = sr.xmdc001                         #料號
             AND l_xmda004_pmaal004 = sr.l_xmda004_pmaal004   #客戶(含說明)
           ORDER BY xmdadocdt DESC,xmdacnfdt DESC

       FOREACH axmr050_x01_pric_cs INTO sr.l_price_recent
          EXIT FOREACH
       END FOREACH
       IF cl_null(sr.l_price_recent) THEN LET sr.l_price_recent = 0 END IF
       
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.xmda015,sr.xmdc001,sr.l_xmda004_pmaal004,sr.l_price_min,sr.l_price_avg,sr.l_price_max,sr.l_price_recent,sr.l_imaa127,sr.l_imaa127_desc,sr.l_imaa127desc
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "axmr050_x01_execute"
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
             
    #新增-全部廠商
    FOREACH axmr050_x01_curs3 INTO sr.*                               
       IF STATUS THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = 'foreach:'
          LET g_errparam.code   = STATUS
          LET g_errparam.popup  = TRUE
          CALL cl_err()
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF

       CALL cl_getmsg('axm-00699',g_dlang) RETURNING sr.l_xmda004_pmaal004
       LET sr.l_xmda004_pmaal004 = '.',sr.l_xmda004_pmaal004
       
       #總和,資料筆數
       LET l_price_sum = 0
       LET l_price_cnt = 0
       SELECT SUM(price),COUNT(price) INTO l_price_sum,l_price_cnt
         FROM axmr050_temp01          #160727-00019#25 Mod  axmr050_x01_temp--> axmr050_temp01
        WHERE xmda015 = sr.xmda015                         #幣別
          AND xmdc001 = sr.xmdc001                         #料號
       IF cl_null(l_price_sum) THEN LET l_price_sum = 0 END IF
       IF cl_null(l_price_cnt) THEN LET l_price_cnt = 0 END IF
       
       #最低價格
       SELECT MIN(price) INTO sr.l_price_min
         FROM axmr050_temp01        #160727-00019#25 Mod  axmr050_x01_temp--> axmr050_temp01
        WHERE xmda015 = sr.xmda015                         #幣別
          AND xmdc001 = sr.xmdc001                         #料號
       IF cl_null(sr.l_price_min) THEN LET sr.l_price_min = 0 END IF
       
       #最高價格
       SELECT MAX(price) INTO sr.l_price_max
         FROM axmr050_temp01          #160727-00019#25 Mod  axmr050_x01_temp--> axmr050_temp01
        WHERE xmda015 = sr.xmda015                         #幣別
          AND xmdc001 = sr.xmdc001                         #料號
       IF cl_null(sr.l_price_max) THEN LET sr.l_price_max = 0 END IF
       
       #平均價格
       LET sr.l_price_avg = l_price_sum / l_price_cnt

       #最近價格
       DECLARE axmr050_x01_pric_cs2 CURSOR FOR 
          SELECT price
            FROM axmr050_temp01      #160727-00019#25 Mod  axmr050_x01_temp--> axmr050_temp01
           WHERE xmda015 = sr.xmda015                         #幣別
             AND xmdc001 = sr.xmdc001                         #料號
           ORDER BY xmdadocdt DESC,xmdacnfdt DESC

       FOREACH axmr050_x01_pric_cs2 INTO sr.l_price_recent
          EXIT FOREACH
       END FOREACH
       IF cl_null(sr.l_price_recent) THEN LET sr.l_price_recent = 0 END IF     
       #dorislai-20150820modify----(S)
#       EXECUTE insert_prep USING sr.xmda015,sr.xmdc001,sr.l_xmda004_pmaal004,sr.l_price_min,sr.l_price_avg,sr.l_price_max,sr.l_price_recent
       EXECUTE insert_prep USING sr.xmda015,sr.xmdc001,sr.l_xmda004_pmaal004,sr.l_price_min,sr.l_price_avg,sr.l_price_max,sr.l_price_recent,sr.l_imaa127,sr.l_imaa127_desc,sr.l_imaa127desc
       #dorislai-20150820modify----(E)
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "axmr050_x01_execute"
          LET g_errparam.code   = SQLCA.sqlcode
          LET g_errparam.popup  = FALSE
          CALL cl_err()       
          LET g_rep_success = 'N'
       END IF
       
    END FOREACH

    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axmr050_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION axmr050_x01_rep_data()
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
 
{<section id="axmr050_x01.other_function" readonly="Y" >}

 
{</section>}
 
