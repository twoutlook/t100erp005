#該程式未解開Section, 採用最新樣板產出!
{<section id="abmr001_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:15(2017-02-21 17:09:20), PR版次:0015(2017-02-21 17:13:01)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000109
#+ Filename...: abmr001_x01
#+ Description: ...
#+ Creator....: 05384(2014-08-07 15:37:43)
#+ Modifier...: 06978 -SD/PR- 06978
 
{</section>}
 
{<section id="abmr001_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#160510-00019#1  2016/05/29 By 02295 效能优化
#160817-00021#1  2016/08/18 By ywtsai  修正abmr001_x01_bmbc的SQL不指定to_date格式
#150925-00048#1  2016/10/13 By 02295   调整adzp188传入参数tm.a2类型为dat
#161021-00003#1  2016/10/21 By 02295   sql中日期类型的传参调整
#170111-00046#1  2017/01/12 By ywtsai  修正CURSOR abmr001_x01_bmea SQL判斷生失效日期的格式需加上時分秒
#170116-00007#1  2017/02/06 By zhujing abmr001、abmr011加上幾個欄位，增加的欄位預設為隱藏：
#                                      1.用量：檢查用量欄位邏輯，用組成用量/主件底數，小數６位，注意展階的問題，要一直往下乘
#                                      2.增加欄位：生效日期、失效日期、必要、ＥＣＮ單號、工單展開選項、代買料、元件投料時距、主要替代料、倒扣料、客供料、指定發料庫位、儲位、庫存管理特徵、保稅、損秏率型態、
#                                        變動損秏率、固定損秏量（這兩個都抓起始量最小的一個印）
#170220-00005#1  2017/02/21 By ywtsai  修正判斷是否為取/替代料時，文字與數值無法比較的問題

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
       a1 LIKE type_t.chr1,         #列印取替代料 
       a2 LIKE bmba_t.bmba005,         #有效日期 
       a3 LIKE type_t.chr1          #階次
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
   DEFINE g_type     LIKE type_t.num20
   DEFINE g_pid      LIKE type_t.num20
   DEFINE g_id       LIKE type_t.num20
   DEFINE g_first    LIKE type_t.chr1
   DEFINE g_bom      LIKE type_t.num5
#end add-point
 
{</section>}
 
{<section id="abmr001_x01.main" readonly="Y" >}
PUBLIC FUNCTION abmr001_x01(p_arg1,p_arg2,p_arg3,p_arg4)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr1         #tm.a1  列印取替代料 
DEFINE  p_arg3 LIKE bmba_t.bmba005         #tm.a2  有效日期 
DEFINE  p_arg4 LIKE type_t.chr1         #tm.a3  階次
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.a1 = p_arg2
   LET tm.a2 = p_arg3
   LET tm.a3 = p_arg4
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "abmr001_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL abmr001_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL abmr001_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL abmr001_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL abmr001_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL abmr001_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="abmr001_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION abmr001_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "l_bmba009.type_t.chr10,l_bmaa001_bmaa002.type_t.chr100,imaal003.imaal_t.imaal003,imaal004.imaal_t.imaal004,l_bmba004_desc.type_t.chr500,l_bmba007_desc.type_t.chr500,l_bmba011.type_t.chr1000,l_bmba012.type_t.chr1000,bmaa004.bmaa_t.bmaa004,l_bmbc010.type_t.chr1000,l_ooff013.type_t.chr1000,l_type.type_t.num20,l_pid.type_t.num20,l_id.type_t.num20,l_amount.type_t.num20_6,l_bmba005.bmba_t.bmba005,l_bmba006.bmba_t.bmba006,l_bmba013.bmba_t.bmba013,l_bmba013_desc.gzcbl_t.gzcbl004,l_bmba026.bmba_t.bmba026,l_bmba021.bmba_t.bmba021,l_bmba021_desc.gzcbl_t.gzcbl004,l_bmba022.bmba_t.bmba022,l_bmba023.bmba_t.bmba023,l_bmba024.bmba_t.bmba024,l_bmba030.bmba_t.bmba030,l_bmba031.bmba_t.bmba031,l_bmba015.bmba_t.bmba015,l_bmba015_desc.inayl_t.inayl003,l_bmba016.bmba_t.bmba016,l_bmba016_desc.inab_t.inab003,l_bmba032.bmba_t.bmba032,l_bmba035.bmba_t.bmba035,l_bmba029.bmba_t.bmba029,l_bmba029_desc.gzcbl_t.gzcbl004,l_bmbb011.bmbb_t.bmbb011,l_bmbb012.bmbb_t.bmbb012" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="abmr001_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION abmr001_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="abmr001_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION abmr001_x01_sel_prep()
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
   LET g_select = " SELECT '',bmaa001,'',( SELECT imaal003 FROM imaal_t WHERE imaal_t.imaalent = bmaa_t.bmaaent AND imaal_t.imaal001 = bmaa_t.bmaa001 AND imaal_t.imaal002 = '" , 
       g_dlang,"'" ,"),( SELECT imaal004 FROM imaal_t WHERE imaal_t.imaalent = bmaa_t.bmaaent AND imaal_t.imaal001 = bmaa_t.bmaa001 AND imaal_t.imaal002 = '" , 
       g_dlang,"'" ,"),'','','','',bmaa004,'','','','','',bmaastus,bmaa002,bmaasite,bmaa003,bmaaent, 
       NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 
       NULL,NULL,NULL,NULL"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   
   #end add-point
    LET g_from = " FROM bmaa_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("bmaa_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE abmr001_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE abmr001_x01_curs CURSOR FOR abmr001_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="abmr001_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION abmr001_x01_ins_data()
DEFINE sr RECORD 
   l_bmba009 LIKE type_t.chr10, 
   bmaa001 LIKE bmaa_t.bmaa001, 
   l_bmaa001_bmaa002 LIKE type_t.chr100, 
   imaal003 LIKE imaal_t.imaal003, 
   imaal004 LIKE imaal_t.imaal004, 
   l_bmba004_desc LIKE type_t.chr500, 
   l_bmba007_desc LIKE type_t.chr500, 
   l_bmba011 LIKE type_t.chr1000, 
   l_bmba012 LIKE type_t.chr1000, 
   bmaa004 LIKE bmaa_t.bmaa004, 
   l_bmbc010 LIKE type_t.chr1000, 
   l_ooff013 LIKE type_t.chr1000, 
   l_type LIKE type_t.num20, 
   l_pid LIKE type_t.num20, 
   l_id LIKE type_t.num20, 
   bmaastus LIKE bmaa_t.bmaastus, 
   bmaa002 LIKE bmaa_t.bmaa002, 
   bmaasite LIKE bmaa_t.bmaasite, 
   bmaa003 LIKE bmaa_t.bmaa003, 
   bmaaent LIKE bmaa_t.bmaaent, 
   l_amount LIKE type_t.num20_6, 
   l_bmba005 LIKE bmba_t.bmba005, 
   l_bmba006 LIKE bmba_t.bmba006, 
   l_bmba013 LIKE bmba_t.bmba013, 
   l_bmba013_desc LIKE gzcbl_t.gzcbl004, 
   l_bmba026 LIKE bmba_t.bmba026, 
   l_bmba021 LIKE bmba_t.bmba021, 
   l_bmba021_desc LIKE gzcbl_t.gzcbl004, 
   l_bmba022 LIKE bmba_t.bmba022, 
   l_bmba023 LIKE bmba_t.bmba023, 
   l_bmba024 LIKE bmba_t.bmba024, 
   l_bmba030 LIKE bmba_t.bmba030, 
   l_bmba031 LIKE bmba_t.bmba031, 
   l_bmba015 LIKE bmba_t.bmba015, 
   l_bmba015_desc LIKE inayl_t.inayl003, 
   l_bmba016 LIKE bmba_t.bmba016, 
   l_bmba016_desc LIKE inab_t.inab003, 
   l_bmba032 LIKE bmba_t.bmba032, 
   l_bmba035 LIKE bmba_t.bmba035, 
   l_bmba029 LIKE bmba_t.bmba029, 
   l_bmba029_desc LIKE gzcbl_t.gzcbl004, 
   l_bmbb011 LIKE bmbb_t.bmbb011, 
   l_bmbb012 LIKE bmbb_t.bmbb012
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
   DEFINE l_type    LIKE type_t.num20
   DEFINE l_pid     LIKE type_t.num20
   DEFINE l_id      LIKE type_t.num20
   DEFINE l_success LIKE type_t.num5
   #modify--2015/06/24 By shiun--(S)
#   DEFINE l_a2      LIKE type_t.dat
   DEFINE l_a2      DATETIME YEAR TO SECOND
   #modify--2015/06/24 By shiun--(E)
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    LET l_type = 1
    CALL abmr001_x01_cursor()  #160510-00019#1---add 
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH abmr001_x01_curs INTO sr.*                               
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
       END IF
       IF NOT cl_null(sr.bmaa001) THEN
          IF cl_null(sr.bmaa002) THEN
             LET sr.l_bmaa001_bmaa002 = sr.bmaa001
          ELSE
             LET sr.l_bmaa001_bmaa002 = sr.bmaa001 || '(' || sr.bmaa002 || ')'
          END IF
       END IF
       #取備註
       CALL s_aooi360_sel('4',sr.bmaasite,sr.bmaa001,sr.bmaa002,'','','','','','','','4')
       RETURNING l_success,sr.l_ooff013
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.l_bmba009,sr.l_bmaa001_bmaa002,sr.imaal003,sr.imaal004,sr.l_bmba004_desc,sr.l_bmba007_desc,sr.l_bmba011,sr.l_bmba012,sr.bmaa004,sr.l_bmbc010,sr.l_ooff013,sr.l_type,sr.l_pid,sr.l_id,sr.l_amount,sr.l_bmba005,sr.l_bmba006,sr.l_bmba013,sr.l_bmba013_desc,sr.l_bmba026,sr.l_bmba021,sr.l_bmba021_desc,sr.l_bmba022,sr.l_bmba023,sr.l_bmba024,sr.l_bmba030,sr.l_bmba031,sr.l_bmba015,sr.l_bmba015_desc,sr.l_bmba016,sr.l_bmba016_desc,sr.l_bmba032,sr.l_bmba035,sr.l_bmba029,sr.l_bmba029_desc,sr.l_bmbb011,sr.l_bmbb012
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "abmr001_x01_execute"
          LET g_errparam.code   = SQLCA.sqlcode
          LET g_errparam.popup  = FALSE
          CALL cl_err()       
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF
 
       #add-point:ins_data段after_save name="ins_data.after.save"
       
       #展BOM
       LET l_a2 = tm.a2   
       LET g_bom = sr.l_id
       #170116-00007#1 mod-S 添加了用量的参数，因为是根节点，所以传入1
#       CALL abmr001_x01_bom(sr.l_type,sr.l_pid,sr.l_id,sr.bmaaent,sr.bmaasite,sr.bmaa001,sr.bmaa002,tm.a1,l_a2)
       CALL abmr001_x01_bom(sr.l_type,sr.l_pid,sr.l_id,sr.bmaaent,sr.bmaasite,sr.bmaa001,sr.bmaa002,tm.a1,l_a2,1)
       #170116-00007#1 mod-E
       RETURNING l_success
       LET l_type = l_type + 1
       #end add-point
       
    END FOREACH
    
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="abmr001_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION abmr001_x01_rep_data()
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
 
{<section id="abmr001_x01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 展BOM的CURSOR提前定义
# Memo...........:
# Usage..........: CALL abmr001_x01_cursor()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_succes   TRUE/FALSE
# Date & Author..: 2016/05/29 By 02295
# Modify.........: 160510-00019#1
################################################################################
PRIVATE FUNCTION abmr001_x01_cursor()
DEFINE l_sql STRING
   #170116-00007#1 mod-S
#   LET l_sql = " SELECT DISTINCT bmbaent,bmbasite,bmba001,bmba002,bmba003,bmba004,bmba005,bmba007,bmba008,bmba009,bmba010,bmba011,bmba012,'','','',",
#               " (SELECT imaal003 FROM imaal_t WHERE imaalent = '",g_enterprise,"' AND imaal001 = bmba003 AND imaal002 = '",g_dlang,"') imaal003,",
#               " (SELECT imaal004 FROM imaal_t WHERE imaalent = '",g_enterprise,"' AND imaal001 = bmba003 AND imaal002 = '",g_dlang,"') imaal004,",
#               " (SELECT oocql004 FROM oocql_t WHERE oocqlent = '",g_enterprise,"' AND oocql001 = '215' AND oocql002 = bmba004 AND oocql003 = '",g_dlang,"') bmba004_desc,",
#               " (SELECT oocql004 FROM oocql_t WHERE oocqlent = '",g_enterprise,"' AND oocql001 = '221' AND oocql002 = bmba007 AND oocql003 = '",g_dlang,"') bmba007_desc",
   LET l_sql = " SELECT DISTINCT bmbaent,bmbasite,bmba001,bmba002,bmba003,bmba004,bmba005,bmba006,bmba007,bmba008,bmba009,bmba010,bmba011,bmba012,",
               " bmba013,(SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '1101' AND gzcbl002 = bmba013 AND gzcbl003 = '",g_dlang,"') bmba013_desc,",
               " bmba026,",
               " bmba021,(SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '4003' AND gzcbl002 = bmba021 AND gzcbl003 = '",g_dlang,"') bmba021_desc,",
               " bmba022,bmba023,bmba024,bmba030,bmba031,",
               " bmba015,(SELECT inayl003 FROM inayl_t WHERE inaylent = ",g_enterprise," AND inayl001 = bmba015 AND inayl002 = '",g_dlang,"') bmba015_desc,",
               " bmba016,(SELECT inab003  FROM inab_t  WHERE inabent = ",g_enterprise," AND inabsite = '",g_site,"' AND inab001 = bmba015 AND inab002 = bmba016) bmba016_desc,",
               " bmba032,bmba035,",
               " bmba029,(SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '1108' AND gzcbl002 = bmba029 AND gzcbl003 = '",g_dlang,"') bmba029_desc,",
               #选择最小bmbb009的资料
               " (SELECT DISTINCT bmbb011 FROM bmbb_t WHERE  bmbaent = bmbbent AND bmbasite = bmbbsite AND bmba001 = bmbb001 AND bmba002 = bmbb002 AND bmba003 = bmbb003 AND bmba004 = bmbb004 AND bmba005 = bmbb005 AND bmba007 = bmbb007 AND bmba008 = bmbb008 ",
               "                                        AND bmbb009 = (SELECT MIN(bmbb009) FROM bmbb_t WHERE  bmbaent = bmbbent AND bmbasite = bmbbsite AND bmba001 = bmbb001 AND bmba002 = bmbb002 AND bmba003 = bmbb003 AND bmba004 = bmbb004 AND bmba005 = bmbb005 AND bmba007 = bmbb007 AND bmba008 = bmbb008)) bmbb011,",
               " (SELECT DISTINCT bmbb012 FROM bmbb_t WHERE  bmbaent = bmbbent AND bmbasite = bmbbsite AND bmba001 = bmbb001 AND bmba002 = bmbb002 AND bmba003 = bmbb003 AND bmba004 = bmbb004 AND bmba005 = bmbb005 AND bmba007 = bmbb007 AND bmba008 = bmbb008 ",
               "                                        AND bmbb009 = (SELECT MIN(bmbb009) FROM bmbb_t WHERE  bmbaent = bmbbent AND bmbasite = bmbbsite AND bmba001 = bmbb001 AND bmba002 = bmbb002 AND bmba003 = bmbb003 AND bmba004 = bmbb004 AND bmba005 = bmbb005 AND bmba007 = bmbb007 AND bmba008 = bmbb008)) bmbb012,",
               " '','','',",
               " (SELECT imaal003 FROM imaal_t WHERE imaalent = '",g_enterprise,"' AND imaal001 = bmba003 AND imaal002 = '",g_dlang,"') imaal003,",
               " (SELECT imaal004 FROM imaal_t WHERE imaalent = '",g_enterprise,"' AND imaal001 = bmba003 AND imaal002 = '",g_dlang,"') imaal004,",
               " (SELECT oocql004 FROM oocql_t WHERE oocqlent = '",g_enterprise,"' AND oocql001 = '215' AND oocql002 = bmba004 AND oocql003 = '",g_dlang,"') bmba004_desc,",
               " (SELECT oocql004 FROM oocql_t WHERE oocqlent = '",g_enterprise,"' AND oocql001 = '221' AND oocql002 = bmba007 AND oocql003 = '",g_dlang,"') bmba007_desc",
   #170116-00007#1 mod-E
               "   FROM bmba_t ",
               "  WHERE bmbaent = ? ",
               "    AND bmbasite = ? ",
               "    AND bmba001 = ? ",
               "    AND bmba002 = ? ",
               #161021-00003#1---mod---s
               #" AND bmba005 < to_date(?,'yyyy-mm-dd  hh24:mi:ss')",
               #" AND (bmba006 >= to_date(?,'yyyy-mm-dd  hh24:mi:ss') OR bmba006 IS NULL)"
               "    AND bmba005 < to_date('",tm.a2,"','yyyy-mm-dd hh24:mi:ss') ",
               "    AND (bmba006 >=to_date('",tm.a2,"','yyyy-mm-dd hh24:mi:ss') OR bmba006 IS NULL)",                
               #161021-00003#1---mod---e                           
               "  ORDER BY bmba009"
   PREPARE abmr001_x01_prepare_bom FROM l_sql
   DECLARE abmr001_x01_bom CURSOR FOR abmr001_x01_prepare_bom
     
   LET l_sql = " SELECT DISTINCT bmbc010",
               "   FROM bmbc_t ",
               "  WHERE bmbcent = ? ",
               "    AND bmbcsite = ?",
               "    AND bmbc001 = ? ",
               "    AND bmbc002 = ? ",
               "    AND bmbc003 = ? ",
               "    AND bmbc004 = ? ",
               #"    AND bmbc005 = to_date(?,'yyyy-mm-dd hh24:mi:ss') ",        #160817-00021#1 mark
               "    AND bmbc005 = ? ",                                          #160817-00021#1 add            
               "    AND bmbc007 = ? ",
               "    AND bmbc008 = ? ",
               "  ORDER BY bmbc010 "
   PREPARE abmr001_x01_prepare_bmbc FROM l_sql
   DECLARE abmr001_x01_bmbc CURSOR FOR abmr001_x01_prepare_bmbc  

   #170116-00007#1 mod-S
#   LET l_sql = " SELECT DISTINCT bmeaent,bmeasite,bmea001,bmea002,bmea003,bmea004,bmea005,bmea006,bmea007,bmea008,bmea009,bmea011,bmea012,bmea013,'',",
#               " (SELECT imaal003 FROM imaal_t WHERE imaalent = '",g_enterprise,"' AND imaal001 = bmea008 AND imaal002 = '",g_dlang,"') imaal003,",
#               " (SELECT imaal004 FROM imaal_t WHERE imaalent = '",g_enterprise,"' AND imaal001 = bmea008 AND imaal002 = '",g_dlang,"') imaal004",   
   LET l_sql = " SELECT DISTINCT bmeaent,bmeasite,bmea001,bmea002,bmea003,bmea004,bmea005,bmea006,bmea007,bmea008,bmea009,bmea010,bmea020,bmea011,bmea012,bmea013,'',",
               " (SELECT imaal003 FROM imaal_t WHERE imaalent = '",g_enterprise,"' AND imaal001 = bmea008 AND imaal002 = '",g_dlang,"') imaal003,",
               " (SELECT imaal004 FROM imaal_t WHERE imaalent = '",g_enterprise,"' AND imaal001 = bmea008 AND imaal002 = '",g_dlang,"') imaal004",   
   #170116-00007#1 mod-E
                 "   FROM bmea_t ",
                 "  WHERE bmeaent = ? ",
                 "    AND bmeasite = ? ",
                 "    AND (bmea001 = ? OR bmea001 = 'ALL') ",
                 "    AND bmea002 = ? ",
                 "    AND bmea003 = ? ",
                 "    AND bmea004 = ? ",
                 "    AND bmea005 = ? ",
                 "    AND bmea006 = ? ",
                 #"    AND bmea009 < to_date(?,'yyyy-mm-dd') ",                             #170111-00046#1 mark
                 #"    AND (bmea010 >= to_date(?,'yyyy-mm-dd') OR bmea010 IS NULL)",        #170111-00046#1 mark
                 "    AND bmea009 < to_date(?,'yyyy-mm-dd hh24:mi:ss') ",                   #170111-00046#1 add
                 "    AND (bmea010 >= to_date(?,'yyyy-mm-dd hh24:mi:ss') OR bmea010 IS NULL)",  #170111-00046#1 add
                 "  ORDER BY bmea007 "
   PREPARE abmr001_x01_prepare_bmea FROM l_sql
   DECLARE abmr001_x01_bmea CURSOR FOR abmr001_x01_prepare_bmea
   
   LET l_sql = " SELECT DISTINCT bmeb009,",
               " (SELECT pmaal004 FROM pmaal_t WHERE pmaalent = '",g_enterprise,"' pmaal001 = bmeb009 AND pmaal002 = '",g_dlang,"') pmaal004",
               "   FROM bmeb_t ",
               "  WHERE bmebent = ?",
               "    AND bmebsite = ?",
               "    AND (bmeb001 = ? OR bmeb001 = 'ALL') ",
               "    AND bmeb002 = ?",
               "    AND bmeb003 = ?",
               "    AND bmeb004 = ?",
               "    AND bmeb005 = ?",
               "    AND bmeb006 = ?",
               "    AND bmeb007 = ?",
               "    AND bmeb008 = ?",
               "  ORDER BY bmeb009 "
   PREPARE abmr001_x01_prepare_bmeb FROM l_sql
   DECLARE abmr001_x01_bmeb CURSOR FOR abmr001_x01_prepare_bmeb   
   
   LET l_sql = " SELECT COUNT(*) ",
               "   FROM bmba_t ",
               " WHERE bmbaent = ?",
               " AND bmbasite = ? ",
               " AND bmba001 = ? ",
               " AND bmba002 = ? ",
               #161021-00003#1---mod---s
               #" AND bmba005 < to_date(?,'yyyy-mm-dd  hh24:mi:ss')",
               #" AND (bmba006 >= to_date(?,'yyyy-mm-dd  hh24:mi:ss') OR bmba006 IS NULL)"
               "    AND bmba005 < to_date('",tm.a2,"','yyyy-mm-dd hh24:mi:ss') ",
               "    AND (bmba006 >=to_date('",tm.a2,"','yyyy-mm-dd hh24:mi:ss') OR bmba006 IS NULL)"                
               #161021-00003#1---mod---e
   PREPARE abmr001_count FROM l_sql   
END FUNCTION

################################################################################
# Descriptions...: 展BOM
# Memo...........:
# Usage..........: CALL abmr001_x01_bom (传入参数)
#                  RETURNING 回传参数
# Input parameter: p_type 樹狀type
#                : p_pid 樹狀pid
#                : p_id 樹狀id
#                : p_bmaaent 企業編號
#                : p_bmaasite 營運據點
#                : p_bmaa001 料件編號
#                : p_bmaa002 特性
#                : p_a1
#                : p_a2
#                : p_amount  #170116-00007#1 用量
# Date & Author..: 2014/8/7 by ShiunYo
# Modify.........: 2017/02/06 By zhujing 添加用量的值，用于计算
################################################################################
PRIVATE FUNCTION abmr001_x01_bom(p_type,p_pid,p_id,p_bmaaent,p_bmaasite,p_bmaa001,p_bmaa002,p_a1,p_a2,p_amount)
   DEFINE l_sql      STRING
   DEFINE l_sql_2    STRING
   DEFINE l_sql_3    STRING
   DEFINE l_sql_4    STRING
   DEFINE l_sql_5    STRING
   DEFINE l_datetype STRING
   DEFINE l_id_add   LIKE type_t.num5
   DEFINE p_a1       LIKE type_t.chr1         #列印取替代料 
   DEFINE p_a2       DATETIME YEAR TO SECOND     #有效日期
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_ac       LIKE type_t.num5
   DEFINE l_ac2      LIKE type_t.num5
   DEFINE l_count    LIKE type_t.num5
   DEFINE l_count2   LIKE type_t.num5
   DEFINE l_count3   LIKE type_t.num5
   DEFINE l_first    LIKE type_t.chr1
   DEFINE p_type     LIKE type_t.num20
   DEFINE p_pid      LIKE type_t.num20
   DEFINE p_id       LIKE type_t.num20
   DEFINE l_type     LIKE type_t.num20
   DEFINE l_pid      LIKE type_t.num20
   DEFINE l_id       LIKE type_t.num20
   DEFINE p_bmaaent  LIKE bmaa_t.bmaaent
   DEFINE p_bmaasite LIKE bmaa_t.bmaasite
   DEFINE p_bmaa001  LIKE bmaa_t.bmaa001
   DEFINE p_bmaa002  LIKE bmaa_t.bmaa002
   DEFINE p_amount   LIKE type_t.num20_6     #170116-00007#1 add 接收上层用量
   DEFINE l_amount   LIKE type_t.num20_6     #170116-00007#1 add 计算本层用量
   DEFINE l_bmbalen  LIKE type_t.num5
   DEFINE l_bmealen  LIKE type_t.num5
   DEFINE l_bmbc010  LIKE bmbc_t.bmbc010
   DEFINE l_bmeb009  LIKE bmeb_t.bmeb009
   DEFINE l_pmaal004 LIKE pmaal_t.pmaal004
   DEFINE l_bmeb009_pmaal004 LIKE type_t.chr1000
   DEFINE l_imaal003 LIKE imaal_t.imaal003
   DEFINE l_imaal004 LIKE imaal_t.imaal004
   DEFINE l_bmba005  LIKE ooff_t.ooff007
   DEFINE l_bmba011  LIKE type_t.chr1000
   DEFINE l_bmba012  LIKE type_t.chr1000
   DEFINE l_bmea011  STRING
   DEFINE l_bmea012  STRING
   DEFINE l_bmea007_desc LIKE type_t.chr10
   DEFINE l_bmba003_bmba002 LIKE type_t.chr100
   DEFINE l_bmba004_desc LIKE oocql_t.oocql004
   DEFINE l_bmba007_desc LIKE oocql_t.oocql004
   DEFINE l_bmba011_bmba012 LIKE type_t.chr100
   DEFINE l_bmea011_bmea012 LIKE type_t.chr100
   DEFINE l_bmba009_1 LIKE type_t.chr1000
   DEFINE l_bmba009_2 LIKE type_t.chr1000
   DEFINE l_bmba     DYNAMIC ARRAY OF RECORD
          bmbaent   LIKE bmba_t.bmbaent,
          bmbasite  LIKE bmba_t.bmbasite,
          bmba001   LIKE bmba_t.bmba001,
          bmba002   LIKE bmba_t.bmba002,
          bmba003   LIKE bmba_t.bmba003,
          bmba004   LIKE bmba_t.bmba004,
          bmba005   DATETIME YEAR TO SECOND,
          bmba006   DATETIME YEAR TO SECOND, #170116-00007#1 add 失效日期
          bmba007   LIKE bmba_t.bmba007,
          bmba008   LIKE bmba_t.bmba008,
          #bmba009   LIKE type_t.chr10,      #160510-00019#1 mark
          bmba009   LIKE bmba_t.bmba009,     #160510-00019#1 add
          bmba010   LIKE bmba_t.bmba010,
          bmba011   LIKE bmba_t.bmba011,
          bmba012   LIKE bmba_t.bmba012,
          bmba013   LIKE bmba_t.bmba013,     #170116-00007#1 add 必要
          bmba013_desc LIKE gzcbl_t.gzcbl004,#170116-00007#1 add 说明
          bmba026   LIKE bmba_t.bmba026,     #170116-00007#1 add ECN单号
          bmba021   LIKE bmba_t.bmba021,     #170116-00007#1 add 工单展开选项
          bmba021_desc LIKE gzcbl_t.gzcbl004,#170116-00007#1 add 说明
          bmba022   LIKE bmba_t.bmba022,     #170116-00007#1 add 代买料
          bmba023   LIKE bmba_t.bmba023,     #170116-00007#1 add 元件投料时距
          bmba024   LIKE bmba_t.bmba024,     #170116-00007#1 add 主要替代料
          bmba030   LIKE bmba_t.bmba030,     #170116-00007#1 add 倒扣料
          bmba031   LIKE bmba_t.bmba031,     #170116-00007#1 add 客供料
          bmba015   LIKE bmba_t.bmba015,     #170116-00007#1 add 指定发料库位
          bmba015_desc LIKE inayl_t.inayl003,#170116-00007#1 add 说明
          bmba016   LIKE bmba_t.bmba016,     #170116-00007#1 add 指定发料储位
          bmba016_desc LIKE inab_t.inab003,  #170116-00007#1 add 说明
          bmba032   LIKE bmba_t.bmba032,     #170116-00007#1 add 指定库存管理特征
          bmba035   LIKE bmba_t.bmba035,     #170116-00007#1 add 保税
          bmba029   LIKE bmba_t.bmba029,     #170116-00007#1 add 损耗率型态
          bmba029_desc LIKE gzcbl_t.gzcbl004,#170116-00007#1 add 说明
          bmbb011   LIKE bmbb_t.bmbb011,     #170116-00007#1 add 变动损耗率
          bmbb012   LIKE bmbb_t.bmbb012,     #170116-00007#1 add 固定损耗率
          bmbc010   LIKE type_t.chr1000,
          ooff013   LIKE type_t.chr1000,
          l_ac      LIKE type_t.num5,
          imaal003  LIKE imaal_t.imaal003,    #160510-00019#1---add
          imaal004  LIKE imaal_t.imaal004,    #160510-00019#1---add
          bmba004_desc LIKE oocql_t.oocql004, #160510-00019#1---add 
          bmba007_desc LIKE oocql_t.oocql004  #160510-00019#1---add 
   END RECORD
   DEFINE l_bmea DYNAMIC ARRAY OF RECORD
          bmeaent   LIKE bmea_t.bmeaent,
          bmeasite  LIKE bmea_t.bmeasite,
          bmea001   LIKE bmea_t.bmea001,
          bmea002   LIKE bmea_t.bmea002,
          bmea003   LIKE bmea_t.bmea003,
          bmea004   LIKE bmea_t.bmea004,
          bmea005   LIKE bmea_t.bmea005,
          bmea006   LIKE bmea_t.bmea006,
          bmea007   LIKE bmea_t.bmea007,
          bmea008   LIKE bmea_t.bmea008,
          bmea009   LIKE bmea_t.bmea009,
          bmea010   LIKE bmea_t.bmea010,  #170116-00007#1 add 失效日期
          bmea020   LIKE bmea_t.bmea020,  #170116-00007#1 add 保税
          bmea011   LIKE bmea_t.bmea011,
          bmea012   LIKE bmea_t.bmea012,
          bmea013   LIKE bmea_t.bmea013,
          bmeb009   LIKE type_t.chr1000,
          imaal003  LIKE imaal_t.imaal003,   #160510-00019#1---add
          imaal004  LIKE imaal_t.imaal004    #160510-00019#1---add         
    END RECORD
   DEFINE l_bmba009_str  LIKE type_t.chr1000 #170220-00005#1 add
    
   WHENEVER ERROR CONTINUE    #160510-00019#1
   
   #抓取環境變數
   IF FGL_GETENV("DBDATE") ='Y2MD/' THEN
      LET l_datetype = 'yy/mm/dd'
   ELSE
      LET l_datetype = 'yyyy/mm/dd'
   END IF
   
#160510-00019#1---mark---s
#   LET l_sql = " SELECT bmbaent,bmbasite,bmba001,bmba002,bmba003,bmba004,bmba005,bmba007,bmba008,bmba009,bmba010,bmba011,bmba012",
#               "   FROM bmba_t ",
#               "  WHERE bmbaent = ",p_bmaaent,
#               "    AND bmbasite = '",p_bmaasite,"'",
#               "    AND bmba001 = '",p_bmaa001,"'",
#               "    AND bmba002 = '",p_bmaa002,"'",
#               #modify--2015/06/24 By shiun--(S)
##               "    AND to_char(ADD_MONTHS(bmba005,0)-1,'yyyy-mm-dd hh24:mi:ss') < '",p_a2,"'",
#               "    AND to_char(bmba005,'yyyy-mm-dd hh24:mi:ss') < '",p_a2,"'",
#               #modify--2015/06/24 By shiun--(E)
#               "    AND (to_char(bmba006,'yyyy-mm-dd hh24:mi:ss') >= '",p_a2,"' OR bmba006 IS NULL)",
##               "    AND (to_char(bmba006,'",l_datetype,"') >= '",p_a2,"' OR bmba006 IS NULL)",
#               "  ORDER BY bmba009"
#     PREPARE abmr001_x01_prepare_bom FROM l_sql
#     DECLARE abmr001_x01_bom CURSOR FOR abmr001_x01_prepare_bom
#160510-00019#1---mark---
     LET l_ac = l_ac + 1
     LET g_first = 'N'  
     #FOREACH abmr001_x01_bom INTO l_bmba[l_ac].*    #160510-00019#1---mark
     #FOREACH abmr001_x01_bom USING p_bmaaent,p_bmaasite,p_bmaa001,p_bmaa002,p_a2,p_a2 INTO l_bmba[l_ac].*    #160510-00019#1---add
     FOREACH abmr001_x01_bom USING p_bmaaent,p_bmaasite,p_bmaa001,p_bmaa002  INTO l_bmba[l_ac].*    #160510-00019#1---add
        IF STATUS THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.extend = 'foreach:'
           LET g_errparam.code   = STATUS
           LET g_errparam.popup  = TRUE
           CALL cl_err()
           LET g_rep_success = 'N'
           EXIT FOREACH
        END IF
        LET g_first = 'Y'
        INITIALIZE l_imaal003,l_imaal004,l_bmba003_bmba002,l_bmba004_desc,l_bmba007_desc,l_bmba011_bmba012 TO NULL
#160510-00019#1---mark---s        
#        LET l_sql_2 = " SELECT bmbc010",
#                      "   FROM bmbc_t ",
#                      "  WHERE bmbcent = ",l_bmba[l_ac].bmbaent,
#                      "    AND bmbcsite = '",l_bmba[l_ac].bmbasite,"'",
#                      "    AND bmbc001 = '",l_bmba[l_ac].bmba001,"'",
#                      "    AND bmbc002 = '",l_bmba[l_ac].bmba002,"'",
#                      "    AND bmbc003 = '",l_bmba[l_ac].bmba003,"'",
#                      "    AND bmbc004 = '",l_bmba[l_ac].bmba004,"'",
#                      "    AND to_char(bmbc005,'yyyy-mm-dd hh24:mi:ss') = '",l_bmba[l_ac].bmba005,"'",
#                      "    AND bmbc007 = '",l_bmba[l_ac].bmba007,"'",
#                      "    AND bmbc008 = '",l_bmba[l_ac].bmba008,"'",
#                      "  ORDER BY bmbc009 "
#        PREPARE abmr001_x01_prepare_bmbc FROM l_sql_2
#        DECLARE abmr001_x01_bmbc CURSOR FOR abmr001_x01_prepare_bmbc
#160510-00019#1---mark---e        
        INITIALIZE l_bmba[l_ac].bmbc010 TO NULL
        LET l_count = 1
        #FOREACH abmr001_x01_bmbc INTO l_bmbc010  #160510-00019#1---mark
        FOREACH abmr001_x01_bmbc USING l_bmba[l_ac].bmbaent,l_bmba[l_ac].bmbasite,l_bmba[l_ac].bmba001,l_bmba[l_ac].bmba002,                           #160510-00019#1---add
                                       l_bmba[l_ac].bmba003,l_bmba[l_ac].bmba004,l_bmba[l_ac].bmba005,l_bmba[l_ac].bmba007,l_bmba[l_ac].bmba008       #160510-00019#1---add
                                  INTO l_bmbc010  #160510-00019#1---add
           IF STATUS THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.extend = 'foreach:'
              LET g_errparam.code   = STATUS
              LET g_errparam.popup  = TRUE
              CALL cl_err()
              LET g_rep_success = 'N'
              EXIT FOREACH
           END IF
           IF l_count = 1 THEN
              LET l_bmba[l_ac].bmbc010 =  l_bmbc010
           ELSE
              IF cl_null(l_bmbc010) THEN
                 LET l_bmba[l_ac].bmbc010 = l_bmba[l_ac].bmbc010 , ',' , l_bmbc010
              ELSE
                 LET l_bmba[l_ac].bmbc010 = l_bmba[l_ac].bmbc010 || ',' || l_bmbc010
              END IF
           END IF
           LET l_count = l_count + 1
        END FOREACH
        #列印取替代料
        IF p_a1 = 'Y' THEN
           INITIALIZE l_bmea TO NULL
           LET l_ac2 = 0
           LET l_bmba005 = YEAR(l_bmba[l_ac].bmba005) USING "####",'-',MONTH(l_bmba[l_ac].bmba005) USING "&&",'-',DAY(l_bmba[l_ac].bmba005) USING "&&"
#160510-00019#1---mark---s           
#           LET l_sql_3 = " SELECT bmeaent,bmeasite,bmea001,bmea002,bmea003,bmea004,bmea005,bmea006,bmea007,bmea008,bmea009,bmea011,bmea012,bmea013",
#                         "   FROM bmea_t ",
#                         "  WHERE bmeaent = ",l_bmba[l_ac].bmbaent,
#                         "    AND bmeasite = '",l_bmba[l_ac].bmbasite,"'",
#                         #ming 20150815 modify -----------------------------------(S) 
#                         #"    AND bmea001 = '",l_bmba[l_ac].bmba001,"'",
#                         "    AND (bmea001 = '",l_bmba[l_ac].bmba001,"' OR bmea001 = 'ALL') ",
#                         #ming 20150815 modify -----------------------------------(E) 
#                         "    AND bmea002 = '",l_bmba[l_ac].bmba002,"'",
#                         "    AND bmea003 = '",l_bmba[l_ac].bmba003,"'",
#                         "    AND bmea004 = '",l_bmba[l_ac].bmba004,"'",
#                         "    AND bmea005 = '",l_bmba[l_ac].bmba007,"'",
#                         "    AND bmea006 = '",l_bmba[l_ac].bmba008,"'",
#                         #modify--2015/06/24 By shiun--(S)
##                         "    AND to_char(ADD_MONTHS(bmea009,0)-1,'yyyy-mm-dd hh24:mi:ss') < '",p_a2,"'",
#                         "    AND to_char(bmea009,'yyyy-mm-dd hh24:mi:ss') < '",p_a2,"'",
#                         #modify--2015/06/24 By shiun--(E)
#                         "    AND (to_char(bmea010,'yyyy-mm-dd hh24:mi:ss') >= '",p_a2,"' OR bmea010 IS NULL)",
##                         "    AND to_char(bmea009,'yyyy-mm-dd') = '",l_bmba005,"'",
#                         "  ORDER BY bmea007 "
#           PREPARE abmr001_x01_prepare_bmea FROM l_sql_3
#           DECLARE abmr001_x01_bmea CURSOR FOR abmr001_x01_prepare_bmea
#160510-00019#1---mark---e           
           LET l_ac2 = l_ac2 + 1
           #FOREACH abmr001_x01_bmea INTO l_bmea[l_ac2].*    #160510-00019#1---mark
           FOREACH abmr001_x01_bmea USING l_bmba[l_ac].bmbaent,l_bmba[l_ac].bmbasite,l_bmba[l_ac].bmba001,l_bmba[l_ac].bmba002,l_bmba[l_ac].bmba003,
                                          l_bmba[l_ac].bmba004,l_bmba[l_ac].bmba007,l_bmba[l_ac].bmba008,p_a2,p_a2
                                     INTO l_bmea[l_ac2].*    #160510-00019#1---add
              IF STATUS THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = 'foreach:'
                 LET g_errparam.code   = STATUS
                 LET g_errparam.popup  = TRUE
                 CALL cl_err()
                 LET g_rep_success = 'N'
                 EXIT FOREACH
              END IF
#160510-00019#1---mark---s              
#              LET l_sql_4 = " SELECT bmeb009",
#                            "   FROM bmeb_t ",
#                            "  WHERE bmebent = ",l_bmea[l_ac2].bmeaent,
#                            "    AND bmebsite = '",l_bmea[l_ac2].bmeasite,"'",
#                            #ming 20150815 modify --------------------------(S) 
#                            #"    AND bmeb001 = '",l_bmea[l_ac2].bmea001,"'",
#                            "    AND (bmeb001 = '",l_bmea[l_ac2].bmea001,"' OR bmeb001 = 'ALL') ",
#                            #ming 20150815 modify --------------------------(E) 
#                            "    AND bmeb002 = '",l_bmea[l_ac2].bmea002,"'",
#                            "    AND bmeb003 = '",l_bmea[l_ac2].bmea003,"'",
#                            "    AND bmeb004 = '",l_bmea[l_ac2].bmea004,"'",
#                            "    AND bmeb005 = '",l_bmea[l_ac2].bmea005,"'",
#                            "    AND bmeb006 = '",l_bmea[l_ac2].bmea006,"'",
#                            "    AND bmeb007 = '",l_bmea[l_ac2].bmea007,"'",
#                            "    AND bmeb008 = '",l_bmea[l_ac2].bmea008,"'",
#                            "  ORDER BY bmeb009 "
#              PREPARE abmr001_x01_prepare_bmeb FROM l_sql_4
#              DECLARE abmr001_x01_bmeb CURSOR FOR abmr001_x01_prepare_bmeb
#160510-00019#1---mark---e              
              INITIALIZE l_bmea[l_ac2].bmeb009 TO NULL
              LET l_count2 = 1
              #FOREACH abmr001_x01_bmeb INTO l_bmeb009   #160510-00019#1---mark
              FOREACH abmr001_x01_bmeb USING l_bmea[l_ac2].bmeaent,l_bmea[l_ac2].bmeasite,l_bmea[l_ac2].bmea001,l_bmea[l_ac2].bmea002,l_bmea[l_ac2].bmea003,
                                             l_bmea[l_ac2].bmea004,l_bmea[l_ac2].bmea005,l_bmea[l_ac2].bmea006,l_bmea[l_ac2].bmea007,l_bmea[l_ac2].bmea008
                                        INTO l_bmeb009,l_pmaal004   #160510-00019#1---add
                 IF STATUS THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.extend = 'foreach:'
                    LET g_errparam.code   = STATUS
                    LET g_errparam.popup  = TRUE
                    CALL cl_err()
                    LET g_rep_success = 'N'
                    EXIT FOREACH
                 END IF
                 #CALL s_desc_get_trading_partner_abbr_desc(l_bmeb009) RETURNING l_pmaal004   #160510-00019#1---mark
                 CALL abmr001_x01_assemble(l_bmeb009,l_pmaal004,'.') RETURNING l_bmeb009_pmaal004
                 IF l_count2 = 1 THEN
                    LET l_bmea[l_ac2].bmeb009 =  l_bmeb009_pmaal004
                 ELSE
                    IF cl_null(l_bmeb009_pmaal004) THEN
                       LET l_bmea[l_ac2].bmeb009 = l_bmea[l_ac2].bmeb009 , ',' , l_bmeb009_pmaal004
                    ELSE
                       LET l_bmea[l_ac2].bmeb009 = l_bmea[l_ac2].bmeb009 || ',' || l_bmeb009_pmaal004
                    END IF
                 END IF
                 LET l_count2 = l_count2 + 1
              END FOREACH
              LET l_ac2 = l_ac2 + 1
           END FOREACH
        END IF
        LET l_bmealen = l_bmea.getLength() - 1
        FOR l_ac2 = 1 TO l_bmealen
                LET l_ac = l_ac + 1
                #取代料or替代料
                IF l_bmea[l_ac2].bmea007 = '1' THEN
                   CALL cl_getmsg('abm-00210',g_lang) RETURNING l_bmba[l_ac].bmba009
                ELSE
                   CALL cl_getmsg('abm-00211',g_lang) RETURNING l_bmba[l_ac].bmba009
                END IF
                #CALL s_desc_get_item_desc(l_bmea[l_ac2].bmea008) RETURNING l_imaal003,l_imaal004
                LET l_bmba[l_ac].bmba003 = l_bmea[l_ac2].bmea008
                LET l_bmba[l_ac].imaal003 = l_bmea[l_ac2].imaal003   #160510-00019#1---add
                LET l_bmba[l_ac].imaal004 = l_bmea[l_ac2].imaal004   #160510-00019#1---add
                LET l_bmba[l_ac].bmba011 = l_bmea[l_ac2].bmea011
                LET l_bmba[l_ac].bmba012 = l_bmea[l_ac2].bmea012
                LET l_bmba[l_ac].bmba010 = l_bmea[l_ac2].bmea013
                LET l_bmba[l_ac].ooff013 = l_bmea[l_ac2].bmeb009
                #170116-00007#1 add-S
#                LET l_bmba[l_ac].bmba006 = l_bmea[l_ac2].bmea010     #失效日期
                LET l_bmba[l_ac].bmba035 = l_bmea[l_ac2].bmea020     #保税
                #170116-00007#1 add-E
                LET l_bmba[l_ac].l_ac = l_ac
        END FOR
        LET l_ac = l_ac + 1
     END FOREACH
     
     LET l_type = p_type
     LET l_pid = p_id
     LET l_bmbalen = l_bmba.getLength() - 1
     IF l_bmbalen < 0 THEN
        LET l_bmbalen = 0
     END IF
     #輸出
     LET l_count3 = 0
     FOR l_ac = 1 TO l_bmbalen
             LET p_id = p_id + 1
             IF p_id < g_id THEN
                LET p_id = g_id +1 
             END IF
             IF p_id = g_id THEN
                LET p_id = p_id + 1
             END IF
             LET g_id = p_id
             LET l_id = g_id
             IF NOT cl_null(l_bmba[l_ac].bmba003) THEN
                IF cl_null(l_bmba[l_ac].bmba002) THEN
                   LET l_bmba003_bmba002 = l_bmba[l_ac].bmba003
                ELSE
                   LET l_bmba003_bmba002 = l_bmba[l_ac].bmba003 || '(' || l_bmba[l_ac].bmba002 || ')'
                END IF
             END IF
             #160510-00019#1---mark---s
             #CALL s_desc_get_item_desc(l_bmba[l_ac].bmba003) RETURNING l_imaal003,l_imaal004
             #CALL s_desc_get_acc_desc(215,l_bmba[l_ac].bmba004) RETURNING l_bmba004_desc
             #CALL s_desc_get_acc_desc(221,l_bmba[l_ac].bmba007) RETURNING l_bmba007_desc
             #160510-00019#1---mark---e
             #160510-00019#1---add---s
             LET l_imaal003 = l_bmba[l_ac].imaal003
             LET l_imaal004 = l_bmba[l_ac].imaal004
             LET l_bmba004_desc = l_bmba[l_ac].bmba004_desc
             LET l_bmba007_desc = l_bmba[l_ac].bmba007_desc
             #160510-00019#1---add---e
             CALL abmr001_x01_delfloat(l_bmba[l_ac].bmba011) RETURNING l_bmba011
             CALL abmr001_x01_delfloat(l_bmba[l_ac].bmba012) RETURNING l_bmba012
             CALL abmr001_x01_assemble(l_bmba011,l_bmba012,'/') RETURNING l_bmba011_bmba012
             #170116-00007#1 add-S 计算本层用量
             LET l_amount = (l_bmba[l_ac].bmba011/l_bmba[l_ac].bmba012)*p_amount
             #170116-00007#1 add-E
             CALL cl_getmsg('abm-00210',g_lang) RETURNING l_bmba009_1
             CALL cl_getmsg('abm-00211',g_lang) RETURNING l_bmba009_2
             LET l_bmba009_str = l_bmba[l_ac].bmba009            #170220-00005#1 add
             #IF NOT (l_bmba[l_ac].bmba009 = l_bmba009_1 OR l_bmba[l_ac].bmba009 = l_bmba009_2) THEN        #170220-00005#1 mark
             IF NOT (l_bmba009_str = l_bmba009_1 OR l_bmba009_str = l_bmba009_2) THEN                       #170220-00005#1 add
                CALL s_aooi360_sel('5',p_bmaasite,p_bmaa001,p_bmaa002,l_bmba[l_ac].bmba003,l_bmba[l_ac].bmba004,'',l_bmba[l_ac].bmba007,l_bmba[l_ac].bmba008,'','','4')
                RETURNING l_success,l_bmba[l_ac].ooff013
             END IF
             IF l_bmba[l_ac].l_ac <> (g_id+2) THEN
                LET p_id = p_id + l_id_add
                IF p_id < g_id THEN
                   LET p_id = g_id +1 
                END IF
                IF p_id = g_id THEN
                   LET p_id = p_id + 1
                END IF
                LET g_id = p_id
                LET l_id = g_id
             END IF
             
             
             IF tm.a3 = '3' THEN
#160510-00019#1---mark---s              
#                LET l_sql_5 = " SELECT COUNT(*) ",
#                              "   FROM bmba_t ",
#                              " WHERE bmbaent = '",l_bmba[l_ac].bmbaent,"' ",
#                              " AND bmbasite = '",l_bmba[l_ac].bmbasite,"' ",
#                              " AND bmba001 = '",l_bmba[l_ac].bmba003,"' ",
#                              " AND bmba002 = '",l_bmba[l_ac].bmba002,"' ",
#                              #modify--2015/06/24 By shiun--(S)
##                              " AND to_char(ADD_MONTHS(bmba005,0)-1,'yyyy-mm-dd hh24:mi:ss') < '",p_a2,"'",
#                              " AND to_char(bmba005,'yyyy-mm-dd hh24:mi:ss') < '",p_a2,"'",
#                              #modify--2015/06/24 By shiun--(E)
#                              " AND (to_char(bmba006,'yyyy-mm-dd hh24:mi:ss') >= '",p_a2,"' OR bmba006 IS NULL)"
#                PREPARE abmr001_count FROM l_sql_5
#160510-00019#1---mark---e                 
                #EXECUTE abmr001_count INTO l_count3  #160510-00019#1---mark-
                EXECUTE abmr001_count USING l_bmba[l_ac].bmbaent,l_bmba[l_ac].bmbasite,l_bmba[l_ac].bmba003,l_bmba[l_ac].bmba002,p_a2,p_a2      #160510-00019#1---add
                                       INTO l_count3                                                                                             #160510-00019#1---add
                IF l_count3 THEN
                   #CONTINUE FOR
                ELSE
                   #170116-00007#1 mod-S
#                   EXECUTE insert_prep USING l_bmba[l_ac].bmba009,l_bmba003_bmba002,l_imaal003,l_imaal004,l_bmba004_desc,l_bmba007_desc,l_bmba011,l_bmba012,l_bmba[l_ac].bmba010,l_bmba[l_ac].bmbc010,l_bmba[l_ac].ooff013,l_type,g_bom,l_id   
                   EXECUTE insert_prep USING l_bmba[l_ac].bmba009,l_bmba003_bmba002,l_imaal003,l_imaal004,l_bmba004_desc,l_bmba007_desc,l_bmba011,l_bmba012,l_bmba[l_ac].bmba010,l_bmba[l_ac].bmbc010,l_bmba[l_ac].ooff013,l_type,g_bom,l_id,
                                             l_amount,            l_bmba[l_ac].bmba005,     l_bmba[l_ac].bmba006,     l_bmba[l_ac].bmba013,l_bmba[l_ac].bmba013_desc,
                                             l_bmba[l_ac].bmba026,l_bmba[l_ac].bmba021,     l_bmba[l_ac].bmba021_desc,l_bmba[l_ac].bmba022,l_bmba[l_ac].bmba023,
                                             l_bmba[l_ac].bmba024,l_bmba[l_ac].bmba030,     l_bmba[l_ac].bmba031,     l_bmba[l_ac].bmba015,l_bmba[l_ac].bmba015_desc,
                                             l_bmba[l_ac].bmba016,l_bmba[l_ac].bmba016_desc,l_bmba[l_ac].bmba032,     l_bmba[l_ac].bmba035,l_bmba[l_ac].bmba029,
                                             l_bmba[l_ac].bmba029_desc,l_bmba[l_ac].bmbb011,l_bmba[l_ac].bmbb012
                   #170116-00007#1 mod-E
                END IF
             
             ELSE
                #170116-00007#1 mod-S
#                EXECUTE insert_prep USING l_bmba[l_ac].bmba009,l_bmba003_bmba002,l_imaal003,l_imaal004,l_bmba004_desc,l_bmba007_desc,l_bmba011,l_bmba012,l_bmba[l_ac].bmba010,l_bmba[l_ac].bmbc010,l_bmba[l_ac].ooff013,l_type,l_pid,l_id   
                EXECUTE insert_prep USING l_bmba[l_ac].bmba009,l_bmba003_bmba002,l_imaal003,l_imaal004,l_bmba004_desc,l_bmba007_desc,l_bmba011,l_bmba012,l_bmba[l_ac].bmba010,l_bmba[l_ac].bmbc010,l_bmba[l_ac].ooff013,l_type,l_pid,l_id,   
                                             l_amount,            l_bmba[l_ac].bmba005,     l_bmba[l_ac].bmba006,     l_bmba[l_ac].bmba013,l_bmba[l_ac].bmba013_desc,
                                             l_bmba[l_ac].bmba026,l_bmba[l_ac].bmba021,     l_bmba[l_ac].bmba021_desc,l_bmba[l_ac].bmba022,l_bmba[l_ac].bmba023,
                                             l_bmba[l_ac].bmba024,l_bmba[l_ac].bmba030,     l_bmba[l_ac].bmba031,     l_bmba[l_ac].bmba015,l_bmba[l_ac].bmba015_desc,
                                             l_bmba[l_ac].bmba016,l_bmba[l_ac].bmba016_desc,l_bmba[l_ac].bmba032,     l_bmba[l_ac].bmba035,l_bmba[l_ac].bmba029,
                                             l_bmba[l_ac].bmba029_desc,l_bmba[l_ac].bmbb011,l_bmba[l_ac].bmbb012
                #170116-00007#1 mod-E
             END IF
             
             IF NOT cl_null(l_bmba[l_ac].bmba003) AND tm.a3 <> '1' THEN
                 #170116-00007#1 mod-S 添加了用量的参数
#                 CALL abmr001_x01_bom(l_type,l_pid,l_id,l_bmba[l_ac].bmbaent,l_bmba[l_ac].bmbasite,l_bmba[l_ac].bmba003,l_bmba[l_ac].bmba002,p_a1,p_a2)
                 CALL abmr001_x01_bom(l_type,l_pid,l_id,l_bmba[l_ac].bmbaent,l_bmba[l_ac].bmbasite,l_bmba[l_ac].bmba003,l_bmba[l_ac].bmba002,p_a1,p_a2,l_amount)
                 #170116-00007#1 mod-E
                 RETURNING l_id_add
             END IF
     END FOR

     IF g_first = 'N' THEN
        LET p_id = p_id + 1
        IF g_id < p_id THEN
           LET g_id = p_id
        END IF
     END IF
     RETURN l_bmbalen
END FUNCTION
################################################################################
# Descriptions...: 去除小數點後多餘的0
# Memo...........:
# Usage..........: CALL abmr001_x01_delfloat(传入参数)
#                  RETURNING 回传参数
# Input parameter: INT
# Return code....: INT
# Date & Author..: 2014/08/08 by 05384
# Modify.........:
################################################################################
PRIVATE FUNCTION abmr001_x01_delfloat(p_num)
DEFINE p_num       LIKE bmba_t.bmba011
DEFINE p_str       STRING
DEFINE l_float     STRING
DEFINE l_int       STRING
DEFINE l_count     INTEGER
DEFINE l_length    INTEGER
DEFINE l_float_length    INTEGER
DEFINE l_i         INTEGER

   LET p_str = p_num
   LET l_count = p_str.getIndexOf(".",1)
   LET l_length = p_str.getLength()
   LET l_int = p_str.subString(1,l_count-1)
   LET l_float = p_str.subString(l_count+1,l_length)
   LET l_float_length = l_float.getLength()
   FOR l_i = 1 TO l_float_length
      IF l_float.subString(l_float_length+1-l_i,l_float_length+1-l_i) <> '0' THEN
         EXIT FOR
      END IF
   END FOR
   IF l_i < l_float_length+1 THEN
      LET l_float = l_float.subString(1,l_float_length+1-l_i)
      LET p_str = l_int || "." || l_float
   ELSE
      LET p_str = l_int
   END IF
   RETURN p_str
END FUNCTION
################################################################################
# Descriptions...: 組合字串
# Memo...........:
# Usage..........: CALL abmr001_x01_assemble(传入参数)
#                  RETURNING 回传参数
# Input parameter: p_str1 要組合的字串1
#                  p_str2 要組合的字串2
#                  p_mid 中間的分隔符號
# Return code....: r_assemble 組合完的字串
# Date & Author..: 2014/08/08 by 05384
# Modify.........:
################################################################################
PRIVATE FUNCTION abmr001_x01_assemble(p_str1,p_str2,p_mid)
   DEFINE p_str1     STRING
   DEFINE p_str2     STRING
   DEFINE r_assemble STRING
   DEFINE p_mid   LIKE type_t.chr1
   IF cl_null(p_str1) OR cl_null(p_str2) THEN
      LET r_assemble = p_str1 , p_mid , p_str2
   ELSE
      LET r_assemble = p_str1 || p_mid || p_str2
   END IF
   IF cl_null(p_str1) AND cl_null(p_str2) THEN
      INITIALIZE r_assemble TO NULL
   END IF
   RETURN r_assemble
END FUNCTION

 
{</section>}
 
