#該程式未解開Section, 採用最新樣板產出!
{<section id="apsr009_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:4(2017-01-13 16:05:37), PR版次:0004(2017-01-13 16:10:36)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000029
#+ Filename...: apsr009_x01
#+ Description: ...
#+ Creator....: 05384(2016-03-28 18:22:59)
#+ Modifier...: 06978 -SD/PR- 06978
 
{</section>}
 
{<section id="apsr009_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#160519-00024#1  16/06/13  By Sarah  某些情況執行完會出現錯誤訊息foreach:
#160727-00019#15 2016/08/03 By 08742   系统中定义的临时表名称超过15码在执行时会出错,所以需要将系统中定义的临时表长度超过15码的全部改掉	 	
#                                      Mod   apsr009_x01_tmp1 -->apsr009_tmp01
#                                      Mod   apsr009_x01_tmp2 -->apsr009_tmp02
#170113-00015#1  2017/01/13 By ywtsai  修改SELECT 爛位相除時，分母SUM(psoe005)會有0的情形造成錯誤，修正為NULLIF(SUM(psoe005))
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
       timep LIKE type_t.chr1          #計算時距
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="apsr009_x01.main" readonly="Y" >}
PUBLIC FUNCTION apsr009_x01(p_arg1,p_arg2)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr1         #tm.timep  計算時距
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.timep = p_arg2
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   CALL apsr009_x01_creat_tmp()
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "apsr009_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL apsr009_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL apsr009_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL apsr009_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL apsr009_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL apsr009_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="apsr009_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION apsr009_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "mrba001.mrba_t.mrba001,mrba004.mrba_t.mrba004,mrba022.mrba_t.mrba022,l_mrba022_desc.ecaa_t.ecaa002,mrba027.mrba_t.mrba027,l_mrba027_desc.oocql_t.oocql004,l_date.type_t.chr50,l_rate.type_t.num20_6,l_psoe005.psoe_t.psoe005,l_psoe006.psoe_t.psoe006" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="apsr009_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION apsr009_x01_ins_prep()
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
 
{<section id="apsr009_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apsr009_x01_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define(客製用) name="sel_prep.define_customerization"

#end add-point
#add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
DEFINE sr  RECORD
    mrba001    LIKE mrba_t.mrba001,
    mrba004    LIKE mrba_t.mrba004,
    mrba022    LIKE mrba_t.mrba022,
    ecaa002    LIKE ecaa_t.ecaa002,
    mrba027    LIKE mrba_t.mrba027,
    oocql004   LIKE oocql_t.oocql004,
    psoe004    LIKE psoe_t.psoe004,
    psoe005    LIKE psoe_t.psoe005,
    psoe006    LIKE psoe_t.psoe006,
    oogc008    LIKE oogc_t.oogc008,
    oogc016    LIKE oogc_t.oogc016
           END RECORD
DEFINE l_s_d        LIKE mrbh_t.mrbh002    #開始日期
DEFINE l_e_d        LIKE mrbh_t.mrbh002    #結束日期
DEFINE l_date       LIKE type_t.chr50      #日期範圍
DEFINE l_str        STRING
#end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
 
   #add-point:sel_prep g_select name="sel_prep.g_select"
   LET g_select = " SELECT d.mrba001,d.mrba004,d.mrba022,e.ecaa002,d.mrba027,f.oocql004,c.psoe004,SUM(NVL(c.psoe005,0)),SUM(NVL(c.psoe006,0)),oogc008,oogc016 "
#   #end add-point
#   LET g_select = " SELECT mrba001,mrba004,mrba022,NULL,mrba027,NULL,NULL,NULL,NULL,NULL"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   
   #資料抓取：
   #1.抓取資源行事曆檔(mrbh_t)資料
   #2.製程料號從aecm200的資源項目串回mrbh_t
   #3.產品分類、生管人員抓製程料號
   
   LET g_from = " FROM oogc_t,ooef_t,psca_t a, ",
                " ( SELECT psoeent,psoesite,psoe001,MAX(psoe002) AS psoe002 FROM psoe_t GROUP BY psoeent,psoesite,psoe001) b ",
                " LEFT OUTER JOIN psoe_t c ON c.psoeent = b.psoeent AND c.psoesite = b.psoesite AND c.psoe001 = b.psoe001 AND c.psoe002 = b.psoe002 ",
                " LEFT OUTER JOIN mrba_t d ON d.mrbaent = c.psoeent AND d.mrbasite = c.psoesite AND d.mrba001 = c.psoe003 ",
                " LEFT OUTER JOIN ecaa_t e ON e.ecaaent = d.mrbaent AND e.ecaasite = d.mrbasite AND e.ecaa001 = d.mrba022 ",                
                " LEFT OUTER JOIN oocql_t f ON f.oocqlent = d.mrbaent AND f.oocql001 = '1103' AND f.oocql002 = d.mrba027 AND oocql003 = '",g_dlang,"' "
#   #end add-point
#    LET g_from = " FROM mrba_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET g_where = " WHERE a.pscaent = b.psoeent AND a.pscasite = b.psoesite AND a.psca001 = b.psoe001 ",
                 "   AND oogcent = ooefent AND oogc001 = ooef008 AND oogc002 = ooef009 AND oogc003 = c.psoe004 AND oogcstus = 'Y' ",
                 "   AND ooefent = c.psoeent AND ooef001 = c.psoesite AND ",tm.wc CLIPPED

#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("mrba_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = g_sql CLIPPED," GROUP BY d.mrba001,d.mrba004,c.psoe004,d.mrba022,e.ecaa002,d.mrba027,f.oocql004,oogc008,oogc016 ORDER BY c.psoe004 "
   PREPARE ins_tmp_pre FROM g_sql
   DECLARE ins_tmp_cur CURSOR FOR ins_tmp_pre
   
 
   DELETE FROM apsr009_tmp01         #160727-00019#15 Mod   apsr009_x01_tmp1 -->apsr009_tmp01
   DELETE FROM apsr009_tmp02         #160727-00019#15 Mod   apsr009_x01_tmp2 -->apsr009_tmp02

   FOREACH ins_tmp_cur INTO sr.*
      INSERT INTO apsr009_tmp02 VALUES(sr.mrba001,sr.psoe004,sr.oogc008,sr.oogc016)         #160727-00019#15 Mod   apsr009_x01_tmp2 -->apsr009_tmp02
   END FOREACH

   FOREACH ins_tmp_cur INTO sr.*
      #日期：顯示計算的日期範圍
      #日 -> 每一天做計算
      LET l_date = sr.psoe004
      IF tm.timep MATCHES '[23]' THEN
         LET l_s_d = ''
         LET l_e_d = ''
         CASE tm.timep  #計算時距
            WHEN '2'
               #週 -> 到aooi420抓取每週的日期範圍
               SELECT MIN(psoe004),MAX(psoe004) INTO l_s_d,l_e_d
                 FROM apsr009_tmp02            #160727-00019#15 Mod   apsr009_x01_tmp2 -->apsr009_tmp02
                WHERE oogc008 = sr.oogc008
            WHEN '3'
               #月 -> 到aooi420抓取每月的日期範圍
               SELECT MIN(psoe004),MAX(psoe004) INTO l_s_d,l_e_d
                 FROM apsr009_tmp02            #160727-00019#15 Mod   apsr009_x01_tmp2 -->apsr009_tmp02
                WHERE oogc016 = sr.oogc016
         END CASE
         IF l_s_d <> l_e_d THEN
            LET l_str = l_s_d,"-",l_e_d
            LET l_date = l_str
         END IF
      END IF

      INSERT INTO apsr009_tmp01 VALUES(sr.mrba001,sr.mrba004,sr.mrba022,sr.ecaa002,sr.mrba027,sr.oocql004,l_date,0,sr.psoe005,sr.psoe006)    #160727-00019#15 Mod   apsr009_x01_tmp1 -->apsr009_tmp01
   END FOREACH

   LET g_sql = " SELECT mrba001,mrba004,mrba022,l_mrba022_desc,mrba027,l_mrba027_desc,l_date,",
#               "        (SUM(l_psoe006)/SUM(l_psoe005)),SUM(l_psoe005),SUM(l_psoe006) ",                                      #160519-00024#1 mark
               #"        COALESCE((SUM(l_psoe006)/SUM(l_psoe005)),0),COALESCE((SUM(l_psoe005),0),COALESCE(SUM(l_psoe006),0) ",  #160519-00024#1      #170113-00015#1 mark
               "        COALESCE((SUM(l_psoe006)/NULLIF(SUM(l_psoe005),0)),0),COALESCE(SUM(l_psoe005),0),COALESCE(SUM(l_psoe006),0) ",               #170113-00015#1 add
               "   FROM apsr009_tmp01 ",          #160727-00019#15 Mod   apsr009_x01_tmp1 -->apsr009_tmp01
               "  GROUP BY mrba001,mrba004,mrba022,l_mrba022_desc,mrba027,l_mrba027_desc,l_date "

   #end add-point
   PREPARE apsr009_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE apsr009_x01_curs CURSOR FOR apsr009_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="apsr009_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION apsr009_x01_ins_data()
DEFINE sr RECORD 
   mrba001 LIKE mrba_t.mrba001, 
   mrba004 LIKE mrba_t.mrba004, 
   mrba022 LIKE mrba_t.mrba022, 
   l_mrba022_desc LIKE ecaa_t.ecaa002, 
   mrba027 LIKE mrba_t.mrba027, 
   l_mrba027_desc LIKE oocql_t.oocql004, 
   l_date LIKE type_t.chr50, 
   l_rate LIKE type_t.num20_6, 
   l_psoe005 LIKE psoe_t.psoe005, 
   l_psoe006 LIKE psoe_t.psoe006
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
 
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
 
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH apsr009_x01_curs INTO sr.*                               
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
 
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.mrba001,sr.mrba004,sr.mrba022,sr.l_mrba022_desc,sr.mrba027,sr.l_mrba027_desc,sr.l_date,sr.l_rate,sr.l_psoe005,sr.l_psoe006
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "apsr009_x01_execute"
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
    LET g_sql = " SELECT mrba001,mrba004,mrba022,l_mrba022_desc,mrba027,l_mrba027_desc,'ALL',",
#               "        (SUM(l_psoe006)/SUM(l_psoe005)),SUM(l_psoe005),SUM(l_psoe006) ",                                      #160519-00024#1 mark
                #"        COALESCE((SUM(l_psoe006)/SUM(l_psoe005)),0),COALESCE((SUM(l_psoe005),0),COALESCE(SUM(l_psoe006),0) ",  #160519-00024#1  #170113-00015#1 mark
                "        COALESCE((SUM(l_psoe006)/NULLIF(SUM(l_psoe005),0)),0),COALESCE(SUM(l_psoe005),0),COALESCE(SUM(l_psoe006),0) ",                    #170113-00015#1 add
                "   FROM apsr009_tmp01 ",          #160727-00019#15 Mod   apsr009_x01_tmp1 -->apsr009_tmp01
                "  GROUP BY mrba001,mrba004,mrba022,l_mrba022_desc,mrba027,l_mrba027_desc "
    PREPARE get_all_pre FROM g_sql
    DECLARE get_all_cur CURSOR FOR get_all_pre
    FOREACH get_all_cur INTO sr.*
      
       EXECUTE insert_prep USING sr.mrba001,sr.mrba004,sr.mrba022,sr.l_mrba022_desc,sr.mrba027,sr.l_mrba027_desc,sr.l_date,sr.l_rate,sr.l_psoe005,sr.l_psoe006
    END FOREACH

    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apsr009_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION apsr009_x01_rep_data()
#add-point:rep_data.define (客製用) name="rep_data.define_customerization"

#end add-point:rep_data.define
#add-point:rep_data.define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="rep_data.define"

#end add-point:rep_data.define
 
    #add-point:rep_data.before name="rep_data.before"
    
    #end add-point:rep_data.before
    
    CALL cl_xg_view()
    #add-point:rep_data.after name="rep_data.after"
    CALL apsr009_x01_drop_tmp()
    #end add-point:rep_data.after
END FUNCTION
 
{</section>}
 
{<section id="apsr009_x01.other_function" readonly="Y" >}

PRIVATE FUNCTION apsr009_x01_creat_tmp()
   CREATE TEMP TABLE apsr009_tmp01(         #160727-00019#15 Mod   apsr009_x01_tmp1 -->apsr009_tmp01
      mrba001 LIKE mrba_t.mrba001, 
      mrba004 LIKE mrba_t.mrba004, 
      mrba022 LIKE mrba_t.mrba022, 
      l_mrba022_desc LIKE ecaa_t.ecaa002, 
      mrba027 LIKE mrba_t.mrba027, 
      l_mrba027_desc LIKE oocql_t.oocql004, 
      l_date LIKE type_t.chr50, 
      l_rate LIKE type_t.num20_6, 
      l_psoe005 LIKE psoe_t.psoe005, 
      l_psoe006 LIKE psoe_t.psoe006
      )
   CREATE TEMP TABLE apsr009_tmp02(          #160727-00019#15 Mod   apsr009_x01_tmp2 -->apsr009_tmp02
    mrba001    LIKE mrba_t.mrba001, 
    psoe004    LIKE psoe_t.psoe004,
    oogc008    LIKE oogc_t.oogc008,
    oogc016    LIKE oogc_t.oogc016
    )
END FUNCTION

PRIVATE FUNCTION apsr009_x01_drop_tmp()
   DROP TABLE apsr009_tmp01       #160727-00019#15 Mod   apsr009_x01_tmp1 -->apsr009_tmp01
   DROP TABLE apsr009_tmp02       #160727-00019#15 Mod   apsr009_x01_tmp2 -->apsr009_tmp02
END FUNCTION

 
{</section>}
 
