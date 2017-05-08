#該程式未解開Section, 採用最新樣板產出!
{<section id="asfr011_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2016-08-04 15:29:29), PR版次:0002(2016-08-04 15:38:01)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000027
#+ Filename...: asfr011_x01
#+ Description: ...
#+ Creator....: 04441(2016-02-15 10:03:11)
#+ Modifier...: 08734 -SD/PR- 08734
 
{</section>}
 
{<section id="asfr011_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#160727-00019#19   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfr011_x01_tmp1 ——> asfr011_tmp01,asfr011_x01_tmp2 ——> asfr011_tmp02
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
       cond1 LIKE type_t.chr1,         #彙總計算 
       cond2 LIKE type_t.chr1          #計算時距
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="asfr011_x01.main" readonly="Y" >}
PUBLIC FUNCTION asfr011_x01(p_arg1,p_arg2,p_arg3)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr1         #tm.cond1  彙總計算 
DEFINE  p_arg3 LIKE type_t.chr1         #tm.cond2  計算時距
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.cond1 = p_arg2
   LET tm.cond2 = p_arg3
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "asfr011_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL asfr011_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL asfr011_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL asfr011_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL asfr011_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL asfr011_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="asfr011_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION asfr011_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "mrbh001.mrbh_t.mrbh001,l_mrba004.type_t.chr300,mrbh006.mrbh_t.mrbh006,l_ecaa002.type_t.chr80,l_date.type_t.chr50,l_rate1.type_t.num20_6,l_rate2.type_t.num20_6,l_rate3.type_t.num20_6,l_rate4.type_t.num20_6" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="asfr011_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION asfr011_x01_ins_prep()
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
 
{<section id="asfr011_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION asfr011_x01_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define(客製用) name="sel_prep.define_customerization"

#end add-point
#add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
DEFINE sr  RECORD
    mrbh001    LIKE mrbh_t.mrbh001,
    mrba004    LIKE mrba_t.mrba004,
    mrbh002    LIKE mrbh_t.mrbh002,
    mrbh006    LIKE mrbh_t.mrbh006,
    ecaa002    LIKE ecaa_t.ecaa002,
    oogc008    LIKE oogc_t.oogc008,
    oogc016    LIKE oogc_t.oogc016,
    sffb015    LIKE sffb_t.sffb015,
    sffb017    LIKE sffb_t.sffb017,
    sffb018    LIKE sffb_t.sffb018,
    ecbh007    LIKE ecbh_t.ecbh007
           END RECORD
DEFINE l_time       LIKE type_t.num15_3    #上班時間
DEFINE l_mrbh003    LIKE mrbh_t.mrbh003    #開始時間
DEFINE l_mrbh004    LIKE mrbh_t.mrbh004    #結束時間
DEFINE l_mrbh003_h  LIKE type_t.num5       #開始時間的小時
DEFINE l_mrbh004_h  LIKE type_t.num5       #結束時間的小時
DEFINE l_mrbh003_m  LIKE type_t.num5       #開始時間的分鐘
DEFINE l_mrbh004_m  LIKE type_t.num5       #結束時間的分鐘
DEFINE l_s_d        LIKE mrbh_t.mrbh002    #開始日期
DEFINE l_e_d        LIKE mrbh_t.mrbh002    #結束日期
DEFINE l_date       LIKE type_t.chr50      #日期範圍
DEFINE l_str        STRING
#end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
 
   #add-point:sel_prep g_select name="sel_prep.g_select"

   #標準工時=aecm200的資源項目，sum(ecbh007)
   #報工時間=asft335，sum(sffb015，報工機器=資源編號，完成日期在計算的日期範圍內，已確認)
   #良品數量=asft335，sum(sffb017，報工機器=資源編號，完成日期在計算的日期範圍內，已確認)
   #生產數量=asft335，sum(sffb017+sffb018，報工機器=資源編號，完成日期在計算的日期範圍內，已確認)
   
   LET g_select = " SELECT mrbh001,mrba004,mrbh002,mrbh006,ecaa002,oogc008,oogc016,SUM(sffb015),SUM(NVL(sffb017,0)),SUM(NVL(sffb018,0)),SUM(ecbh007) "

#   #end add-point
#   LET g_select = " SELECT mrbh001,NULL,mrbh006,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL" 
#
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"

   #資料抓取：
   #1.抓取資源行事曆檔(mrbh_t)資料
   #2.製程料號從aecm200的資源項目串回mrbh_t
   #3.產品分類、生管人員抓製程料號
   
   LET g_from = " FROM oogc_t,ooef_t, ",
                " (SELECT DISTINCT mrbhent,mrbhsite,mrbh001,mrbh002,mrbh006 FROM mrbh_t ) ",
                " LEFT OUTER JOIN mrba_t ON mrbaent = mrbhent AND mrbasite = mrbhsite AND mrba001 = mrbh001 ",
                " LEFT OUTER JOIN ecaa_t ON ecaaent = mrbhent AND ecaasite = mrbhsite AND ecaa001 = mrbh006 ",
                " LEFT OUTER JOIN sffb_t ON sffbent = mrbhent AND sffbsite = mrbhsite AND sffbstus = 'Y' AND sffb010 = mrbh001 AND sffb012 = mrbh002 ",
                " LEFT OUTER JOIN ( SELECT DISTINCT ecbhent,ecbhsite,ecbh004,ecbh007,ecbh001,imaa009,imae012 FROM ecbh_t ",
                " LEFT OUTER JOIN imaa_t ON imaaent = ecbhent AND imaa001 = ecbh001 ",
                " LEFT OUTER JOIN imae_t ON imaeent = ecbhent AND imaesite = ecbhsite AND imae001 = ecbh001 ",
                " ) ON ecbhent = mrbhent AND ecbhsite = mrbhsite AND ecbh004 = mrbh001 "

#   #end add-point
#    LET g_from = " FROM mrbh_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"

   LET g_where = " WHERE mrbhent = ",g_enterprise," AND mrbhsite = '",g_site,"' ",  #" AND mrbhstus = 'Y' ",
                 "   AND oogcent = ooefent AND oogc001 = ooef008 AND oogc002 = ooef009 AND oogc003 = mrbh002 AND oogcstus = 'Y' ",
                 "   AND ooefent = mrbhent AND ooef001 = mrbhsite AND ",tm.wc CLIPPED

#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("mrbh_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = g_sql," GROUP BY mrbh001,mrba004,mrbh002,mrbh006,ecaa002,oogc008,oogc016 ORDER BY mrbh002 "
   PREPARE ins_tmp_pre FROM g_sql
   DECLARE ins_tmp_cur CURSOR FOR ins_tmp_pre
   
   LET g_sql = " SELECT mrbh003,mrbh004 FROM mrbh_t ",
               "  WHERE mrbhent = ",g_enterprise," AND mrbhsite = '",g_site,"' ",
               "    AND mrbh001 = ? AND mrbh002 = ? AND mrbh006 = ? AND mrbh005 = 'Y' "
   PREPARE get_time_pre FROM g_sql
   DECLARE get_time_cur CURSOR FOR get_time_pre
   
   DELETE FROM asfr011_tmp01  #160727-00019#19   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfr011_x01_tmp1 ——> asfr011_tmp01
   DELETE FROM asfr011_tmp02  #160727-00019#19   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfr011_x01_tmp2 ——> asfr011_tmp02
   
   FOREACH ins_tmp_cur INTO sr.*
      INSERT INTO asfr011_tmp02 VALUES(sr.mrbh001,sr.mrbh002,sr.mrbh006,sr.oogc008,sr.oogc016)  #160727-00019#19   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfr011_x01_tmp2 ——> asfr011_tmp02
   END FOREACH
   
   FOREACH ins_tmp_cur INTO sr.*
   
      #上班時間=amri050，sum(結束時間-開始時間，正常運作否='Y'，日期在計算的日期範圍內)
      LET l_time = 0
      LET l_mrbh003 = ''
      LET l_mrbh004 = ''
      FOREACH get_time_cur USING sr.mrbh001,sr.mrbh002,sr.mrbh006 INTO l_mrbh003,l_mrbh004
         LET l_mrbh003_h = l_mrbh003[1,2]
         LET l_mrbh004_h = l_mrbh004[1,2]
         LET l_mrbh003_m = l_mrbh003[4,5]
         LET l_mrbh004_m = l_mrbh004[4,5]
         LET l_time = l_time + (l_mrbh004_h * 60 + l_mrbh004_m) - (l_mrbh003_h * 60 + l_mrbh003_m)
         LET l_mrbh003 = ''
         LET l_mrbh004 = ''
      END FOREACH
      
      #日期：顯示計算的日期範圍
      #日 -> 每一天做計算
      LET l_date = sr.mrbh002
      IF tm.cond2 MATCHES '[23]' THEN
         LET l_s_d = ''
         LET l_e_d = ''
         CASE tm.cond2  #計算時距
            WHEN '2'
               #週 -> 到aooi420抓取每週的日期範圍
               SELECT MIN(mrbh002),MAX(mrbh002) INTO l_s_d,l_e_d
                 FROM asfr011_tmp02   #160727-00019#19   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfr011_x01_tmp2 ——> asfr011_tmp02
                WHERE oogc008 = sr.oogc008
            WHEN '3'
               #月 -> 到aooi420抓取每月的日期範圍
               SELECT MIN(mrbh002),MAX(mrbh002) INTO l_s_d,l_e_d
                 FROM asfr011_tmp02  #160727-00019#19   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfr011_x01_tmp2 ——> asfr011_tmp02
                WHERE oogc016 = sr.oogc016
         END CASE
         IF l_s_d <> l_e_d THEN
            LET l_str = l_s_d,"-",l_e_d
            LET l_date = l_str
         END IF
      END IF
      
      #機台：彙總計算=2.工作站或3.所有設備時顯示'ALL'
      IF tm.cond1 MATCHES '[23]' THEN
         LET sr.mrbh001 = 'ALL'
         LET sr.mrba004 = ''
         #工作站：彙總計算=3.所有設備時顯示'ALL'
         IF tm.cond1 = '3' THEN
            LET sr.mrbh006 = 'ALL'
            LET sr.ecaa002 = ''
         END IF
      END IF
      
      INSERT INTO asfr011_tmp01 VALUES(sr.mrbh001,sr.mrba004,sr.mrbh006,sr.ecaa002,l_date,l_time,sr.sffb015,sr.ecbh007,sr.sffb017,sr.sffb018)  #160727-00019#19   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfr011_x01_tmp1 ——> asfr011_tmp01
   
   END FOREACH
   
   LET g_sql = " SELECT mrbh001,mrba004,mrbh006,ecaa002,l_date,'','','','',SUM(l_time1),SUM(l_time2),ecbh007,SUM(sffb017),SUM(sffb018) ",
               "   FROM asfr011_tmp01 ",  #160727-00019#19   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfr011_x01_tmp1 ——> asfr011_tmp01
               "  GROUP BY mrbh001,mrba004,mrbh006,ecaa002,l_date,ecbh007 "

   #end add-point
   PREPARE asfr011_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE asfr011_x01_curs CURSOR FOR asfr011_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="asfr011_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION asfr011_x01_ins_data()
DEFINE sr RECORD 
   mrbh001 LIKE mrbh_t.mrbh001, 
   l_mrba004 LIKE type_t.chr300, 
   mrbh006 LIKE mrbh_t.mrbh006, 
   l_ecaa002 LIKE type_t.chr80, 
   l_date LIKE type_t.chr50, 
   l_rate1 LIKE type_t.num20_6, 
   l_rate2 LIKE type_t.num20_6, 
   l_rate3 LIKE type_t.num20_6, 
   l_rate4 LIKE type_t.num20_6, 
   l_time1 LIKE type_t.num15_3, 
   l_time2 LIKE type_t.num15_3, 
   l_ecbh007 LIKE type_t.num15_3, 
   l_sffb017 LIKE type_t.num20_6, 
   l_sffb018 LIKE type_t.num20_6
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
 
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
 
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH asfr011_x01_curs INTO sr.*                               
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
       
       CALL asfr011_x01_rate(sr.l_time1,sr.l_time2,sr.l_ecbh007,sr.l_sffb017,sr.l_sffb018)
            RETURNING sr.l_rate1,sr.l_rate2,sr.l_rate3,sr.l_rate4
       
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
 
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.mrbh001,sr.l_mrba004,sr.mrbh006,sr.l_ecaa002,sr.l_date,sr.l_rate1,sr.l_rate2,sr.l_rate3,sr.l_rate4
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "asfr011_x01_execute"
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

    LET g_sql = " SELECT mrbh001,mrba004,mrbh006,ecaa002,'ALL','','','','',SUM(l_time1),SUM(l_time2),ecbh007,SUM(sffb017),SUM(sffb018) ",
                "   FROM asfr011_tmp01 ",  #160727-00019#19   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfr011_x01_tmp1 ——> asfr011_tmp01
                "  GROUP BY mrbh001,mrba004,mrbh006,ecaa002,ecbh007 "
    PREPARE get_all_pre FROM g_sql
    DECLARE get_all_cur CURSOR FOR get_all_pre
    FOREACH get_all_cur INTO sr.*
       
       CALL asfr011_x01_rate(sr.l_time1,sr.l_time2,sr.l_ecbh007,sr.l_sffb017,sr.l_sffb018)
            RETURNING sr.l_rate1,sr.l_rate2,sr.l_rate3,sr.l_rate4
       
       EXECUTE insert_prep USING sr.mrbh001,sr.l_mrba004,sr.mrbh006,sr.l_ecaa002,sr.l_date,sr.l_rate1,sr.l_rate2,sr.l_rate3,sr.l_rate4
       
    END FOREACH

    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="asfr011_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION asfr011_x01_rep_data()
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
 
{<section id="asfr011_x01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 
# Memo...........:
# Usage..........: CALL asfr011_x01_rate(p_time1,p_time2,p_ecbh007,p_sffb017,p_sffb018)
#                  RETURNING r_rate1,r_rate2,r_rate3,r_rate4
# Input parameter: 
# Return code....: 
# Date & Author..: 160225 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION asfr011_x01_rate(p_time1,p_time2,p_ecbh007,p_sffb017,p_sffb018)
DEFINE p_time1      LIKE type_t.num15_3
DEFINE p_time2      LIKE type_t.num15_3
DEFINE p_ecbh007    LIKE type_t.num15_3
DEFINE p_sffb017    LIKE type_t.num20_6
DEFINE p_sffb018    LIKE type_t.num20_6
DEFINE r_rate1      LIKE type_t.num20_6
DEFINE r_rate2      LIKE type_t.num20_6
DEFINE r_rate3      LIKE type_t.num20_6
DEFINE r_rate4      LIKE type_t.num20_6

   LET r_rate1 = ''
   LET r_rate2 = ''
   LET r_rate3 = ''
   LET r_rate4 = ''
   
   #停止時間=上班時間-報工時間
   #開動時間=上班時間-停止時間
   IF p_time2 < 0 THEN
      #若開動時間為負數時，讓開動時間=上班時間
      LET r_rate1 = 1
   ELSE
      #稼動率=開動時間/上班時間*100
      LET r_rate1 = p_time2 / p_time1
      #稼動率最大100%
      IF r_rate1 > 1 THEN
         LET r_rate1 = 1
      END IF
   END IF
   
   #標準時間=標準工時*生產數量
   #產能效率=標準時間/報工時間*100
   LET r_rate2 = p_ecbh007 * ( p_sffb017 + p_sffb018 ) / p_time2
   
   #良品率=良品數量/加工數量*100
   LET r_rate3 = p_sffb017 / ( p_sffb017 + p_sffb018 )
   
   #設備綜合效率 = (稼動率/100) * (產能效率/100) * (良品率/100) * 100
   LET r_rate4 = r_rate1 * r_rate2 * r_rate3 
   
   RETURN r_rate1,r_rate2,r_rate3,r_rate4
END FUNCTION

 
{</section>}
 
