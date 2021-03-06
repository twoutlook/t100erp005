#該程式未解開Section, 採用最新樣板產出!
{<section id="axmr173_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2016-06-30 02:56:37), PR版次:0003(2016-06-30 02:58:24)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000028
#+ Filename...: axmr173_x01
#+ Description: ...
#+ Creator....: 05384(2016-04-26 17:50:36)
#+ Modifier...: 02749 -SD/PR- 02749
 
{</section>}
 
{<section id="axmr173_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#160511-00002#1   2016/06/01 By shiun     規格有變，已上傳到155，請搜尋 20160510
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
       a1 LIKE type_t.dat,         #起始日期 
       a2 LIKE type_t.dat,         #結束日期 
       a3 LIKE type_t.chr1          #顯示超出資料
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 type type_xmic      RECORD
   xmid007           LIKE xmid_t.xmid007, 
   xmid008           LIKE xmid_t.xmid008,
   xmid009           LIKE xmid_t.xmid009,
   xmid010           LIKE xmid_t.xmid010,
   xmid011           LIKE xmid_t.xmid011,
   xmid012           LIKE xmid_t.xmid012,
   xmid013           LIKE xmid_t.xmid013,
   xmid017           LIKE xmid_t.xmid017,
   xmid017_pre       LIKE xmid_t.xmid017,
   proportion        LIKE xmid_t.xmid017
END RECORD
#end add-point
 
{</section>}
 
{<section id="axmr173_x01.main" readonly="Y" >}
PUBLIC FUNCTION axmr173_x01(p_arg1,p_arg2,p_arg3,p_arg4)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.dat         #tm.a1  起始日期 
DEFINE  p_arg3 LIKE type_t.dat         #tm.a2  結束日期 
DEFINE  p_arg4 LIKE type_t.chr1         #tm.a3  顯示超出資料
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
   LET g_rep_code = "axmr173_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL axmr173_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL axmr173_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL axmr173_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL axmr173_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL axmr173_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="axmr173_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION axmr173_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "xmic001.xmic_t.xmic001,xmial_t_xmial003.xmial_t.xmial003,xmic002.xmic_t.xmic002,xmic003.xmic_t.xmic003,xmic004.xmic_t.xmic004,t1_ooefl003.ooefl_t.ooefl003,xmic005.xmic_t.xmic005,ooefl_t_ooefl003.ooefl_t.ooefl003,xmic006.xmic_t.xmic006,ooag_t_ooag011.ooag_t.ooag011,xmid007.xmid_t.xmid007,l_imaal003.imaal_t.imaal003,l_imaal004.imaal_t.imaal004,xmid008.xmid_t.xmid008,l_xmid008_desc.type_t.chr1000,xmid009.xmid_t.xmid009,l_xmid009_desc.pmaal_t.pmaal004,xmid010.xmid_t.xmid010,l_xmid010_desc.oocql_t.oocql004,l_xmid011.type_t.chr30,xmid017.xmid_t.xmid017,l_xmid017_pre.xmid_t.xmid017,l_proportion.xmid_t.xmid015,l_show.type_t.chr1" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   DROP TABLE axmr173_tmp;
   CREATE TEMP TABLE axmr173_tmp(
      xmic001         VARCHAR(10),            #預測編號  
      xmic002         DATE,            #預測基準日 
      xmic003         SMALLINT,            #版本 
      xmic004         VARCHAR(10),            #預測營運據點
      xmic005         VARCHAR(10),            #銷售組織
      xmic006         VARCHAR(20),            #業務員 
      xmid007         VARCHAR(40),            #預測料號
      xmid008         VARCHAR(256),            #產品特徵
      xmid009         VARCHAR(10),            #客戶
      xmid010         VARCHAR(10),            #通路
      xmid011         SMALLINT,            #期別
      xmid012         DATE,            #預測起始日
      xmid013         DATE,            #預測截止日
      xmid017         DECIMAL(20,6)     #預測總數量
   )  
   DROP TABLE axmr173_tmp1;
   CREATE TEMP TABLE axmr173_tmp1(
      xmic001         VARCHAR(10),            #預測編號  
      xmic002         DATE,            #預測基準日 
      xmic003         SMALLINT,            #版本 
      xmic004         VARCHAR(10),            #預測營運據點
      xmic005         VARCHAR(10),            #銷售組織
      xmic006         VARCHAR(20),            #業務員 
      xmid007         VARCHAR(40),            #預測料號
      xmid008         VARCHAR(256),            #產品特徵
      xmid009         VARCHAR(10),            #客戶
      xmid010         VARCHAR(10),            #通路
      xmid011         SMALLINT,            #期別
      xmid012         DATE,            #預測起始日
      xmid013         DATE,            #預測截止日
      xmid017         DECIMAL(20,6)     #預測總數量
   )
   DROP TABLE axmr173_tmp2;
   CREATE TEMP TABLE axmr173_tmp2(
   xmic001            VARCHAR(10), 
   xmic002            DATE, 
   xmic003            SMALLINT, 
   xmic004            VARCHAR(10),
   xmic005            VARCHAR(10), 
   xmic006            VARCHAR(20), 
   xmid007            VARCHAR(40), 
   xmid008            VARCHAR(256),
   xmid009            VARCHAR(10),
   xmid010            VARCHAR(10),
   xmid011            SMALLINT,
   xmid012            DATE,
   xmid013            DATE,
   xmid017            DECIMAL(20,6),
   l_xmid017_pre      DECIMAL(20,6),
   l_proportion       DECIMAL(20,6)
   )
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="axmr173_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION axmr173_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="axmr173_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axmr173_x01_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define(客製用) name="sel_prep.define_customerization"

#end add-point
#add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
DEFINE l_sql         STRING
DEFINE l_count       LIKE type_t.num5
DEFINE l_msg         LIKE type_t.chr500
DEFINE l_xmic001     LIKE xmic_t.xmic001 
DEFINE l_xmic002     LIKE xmic_t.xmic002 
DEFINE l_xmic002_pre LIKE xmic_t.xmic002 
DEFINE l_xmic003     LIKE xmic_t.xmic003 
DEFINE l_xmic004     LIKE xmic_t.xmic004
DEFINE l_xmic005     LIKE xmic_t.xmic005 
DEFINE l_xmic006     LIKE xmic_t.xmic006 
DEFINE l_xmid011     LIKE xmid_t.xmid011
DEFINE l_xmid012     LIKE xmid_t.xmid012
DEFINE l_xmid013     LIKE xmid_t.xmid013
#DEFINE l_xmid007     LIKE xmid_t.xmid007 
DEFINE l_chk         LIKE type_t.chr1000
DEFINE l_imaf125     LIKE imaf_t.imaf125
DEFINE l_imafsite    LIKE imaf_t.imafsite
DEFINE l_now         type_xmic
DEFINE l_pre         type_xmic
#end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   LET l_sql = " INSERT INTO axmr173_tmp ",
               " SELECT b.xmic001,b.xmic002,b.xmic003,b.xmic004,b.xmic005,b.xmic006,xmid007,xmid008,xmid009,xmid010,xmid011,xmid012,xmid013,xmid017 ",
               "   FROM (SELECT xmicent,xmic001,xmic002,MAX(xmic003) AS xmic003,xmic004,xmic005,xmic006 FROM xmic_t GROUP BY xmicent,xmic001,xmic002,xmic004,xmic005,xmic006 ) a, ",
               "        xmic_t b ,xmid_t c",#LEFT OUTER JOIN xmid_t c ON b.xmicent = c.xmident AND b.xmic001 = c.xmid001 AND b.xmic002 = c.xmid002 AND b.xmic003 = c.xmid003 AND b.xmic004 = c.xmid004 AND b.xmic005 = c.xmid005 AND b.xmic006 = c.xmid006 ",
               "  WHERE a.xmicent = b.xmicent AND a.xmic001 = b.xmic001 AND a.xmic002 = b.xmic002 ",
               "    AND a.xmic003 = b.xmic003 AND a.xmic004 = b.xmic004 AND a.xmic005 = b.xmic005 ",
               "    AND a.xmic006 = b.xmic006 AND a.xmic002 BETWEEN '",tm.a1,"' AND '",tm.a2,"' ",
               "    AND b.xmicent = c.xmident AND b.xmic001 = c.xmid001 AND b.xmic002 = c.xmid002 ",
               "    AND b.xmic003 = c.xmid003 AND b.xmic004 = c.xmid004 AND b.xmic005 = c.xmid005 ",
               "    AND b.xmic006 = c.xmid006 AND ",tm.wc
   PREPARE axmr173_tmp_insert FROM l_sql
   EXECUTE axmr173_tmp_insert
   
   LET l_sql = " INSERT INTO axmr173_tmp2 ",
               " SELECT xmic001,xmic002,xmic003,xmic004,xmic005,xmic006,xmid007,xmid008,xmid009,xmid010,xmid011,xmid012,xmid013,xmid017,NULL,NULL ",
               "   FROM axmr173_tmp ",
               "  WHERE xmic001 = ? ",
               "    AND xmic002 = ? ",
               "    AND xmic003 = ? ",
               "    AND xmic004 = ? ",
               "    AND xmic005 = ? ",
               "    AND xmic006 = ? "         
   PREPARE axmr173_tmp_ins_tmp2 FROM l_sql
   
   LET l_sql = " SELECT xmid007,xmid008,xmid009,xmid010,xmid011,xmid012,xmid013,xmid017,NULL,NULL ",
               "   FROM axmr173_tmp ",
               "  WHERE xmic001 = ? ",
               "    AND xmic002 = ? ",
               "    AND xmic003 = ? ",
               "    AND xmic004 = ? ",
               "    AND xmic005 = ? ",
               "    AND xmic006 = ? "
   PREPARE axmr173_x01_ins_pre FROM l_sql      
   DECLARE axmr173_x01_ins_curs CURSOR FOR axmr173_x01_ins_pre
   

   LET l_sql = " SELECT DISTINCT xmic001,xmic002,xmic003,xmic004,xmic005,xmic006,xmid012,xmid013 ",
               "   FROM axmr173_tmp ",
               "  WHERE xmid011 = '1' "
   PREPARE axmr173_x01_tmp2_pre FROM l_sql      
   DECLARE axmr173_x01_tmp2_curs CURSOR FOR axmr173_x01_tmp2_pre
   
   LET l_sql = " SELECT COUNT(*) ",
               "   FROM axmr173_tmp ",
               "  WHERE xmic001 = ? ",
               "    AND xmic002 = ? ",
#               "    AND xmic003 = ? ",   #mark--#160511-00002#1 By shiun
               "    AND xmic004 = ? ",
               "    AND xmic005 = ? ",
               "    AND xmic006 = ? "
   PREPARE axmr173_x01_count FROM l_sql
   
   #add--#160511-00002#1 By shiun--(S)
   LET l_sql = " SELECT MAX(xmic002) ",
               "   FROM axmr173_tmp ",
               "  WHERE xmic001 = ? ",
               "    AND xmic002 < ? ",
               "    AND xmic004 = ? ",
               "    AND xmic005 = ? ",
               "    AND xmic006 = ? "
   PREPARE axmr173_x01_xmic002 FROM l_sql
   #add--#160511-00002#1 By shiun--(E)
   
   INITIALIZE l_xmic001,l_xmic002,l_xmic003,l_xmic004,l_xmic005,l_xmic006,l_xmid012,l_xmid013 TO NULL
   FOREACH axmr173_x01_tmp2_curs INTO l_xmic001,l_xmic002,l_xmic003,l_xmic004,l_xmic005,l_xmic006,l_xmid012,l_xmid013
      LET l_count = 0
      #mod--160511-00002#1 By shiun--(S)
#      LET l_xmic002_pre = l_xmic002 - (l_xmid013 - l_xmid012 + 1)
      EXECUTE axmr173_x01_xmic002 USING l_xmic001,l_xmic002,l_xmic004,l_xmic005,l_xmic006 INTO l_xmic002_pre
#      EXECUTE axmr173_x01_count USING l_xmic001,l_xmic002_pre,l_xmic003,l_xmic004,l_xmic005,l_xmic006 INTO l_count
      EXECUTE axmr173_x01_count USING l_xmic001,l_xmic002_pre,l_xmic004,l_xmic005,l_xmic006 INTO l_count
      #mod--160511-00002#1 By shiun--(E)
      IF l_count = 0 THEN
         EXECUTE axmr173_tmp_ins_tmp2 USING l_xmic001,l_xmic002,l_xmic003,l_xmic004,l_xmic005,l_xmic006
      ELSE
         INITIALIZE l_now.* TO NULL
         FOREACH axmr173_x01_ins_curs USING l_xmic001,l_xmid012,l_xmic003,l_xmic004,l_xmic005,l_xmic006
            INTO  l_now.*
         
            INITIALIZE l_pre.* TO NULL
            SELECT xmid007,xmid008,xmid009,xmid010,xmid011,xmid012,xmid013,xmid017,NULL,NULL
              INTO l_pre.*
              FROM axmr173_tmp
             WHERE xmic001 = l_xmic001
               AND xmic002 = l_xmic002_pre
#               AND xmic003 = l_xmic003   #mark--#160511-00002#1 By shiun
               AND xmic004 = l_xmic004
               AND xmic005 = l_xmic005
               AND xmic006 = l_xmic006
               AND xmid007 = l_now.xmid007
               AND xmid008 = l_now.xmid008
               AND xmid009 = l_now.xmid009
               AND xmid010 = l_now.xmid010
               AND xmid012 = l_now.xmid012
               AND xmid013 = l_now.xmid013
            
            IF NOT cl_null(l_pre.xmid007) THEN   
               LET l_now.xmid017_pre = l_pre.xmid017
               LET l_now.proportion = (l_now.xmid017 - l_now.xmid017_pre) / l_now.xmid017_pre
            END IF
            INSERT INTO axmr173_tmp2 (xmic001,xmic002,xmic003,xmic004,xmic005,xmic006,xmid007,xmid008,
                                      xmid009,xmid010,xmid011,xmid012,xmid013,xmid017,l_xmid017_pre,l_proportion)
                               VALUES(l_xmic001,l_xmid012,l_xmic003,l_xmic004,l_xmic005,l_xmic006,l_now.xmid007,l_now.xmid008,
                                      l_now.xmid009,l_now.xmid010,l_now.xmid011,l_now.xmid012,l_now.xmid013,
                                      l_now.xmid017,l_now.xmid017_pre,l_now.proportion)
         END FOREACH
      END IF
   END FOREACH
   #end add-point
 
   #add-point:sel_prep g_select name="sel_prep.g_select"
   LET g_select = " SELECT xmic001,xmial003,xmic002,xmic003,xmic004,t1.ooefl003,xmic005,t2.ooefl003, ",
                  "        xmic006,ooag011,xmid007,imaal003,imaal004,xmid008,NULL,xmid009,pmaal004, ",
                 #160621-00003#6 160629 by lori mark and add---(S)  
                 #"        xmid010,oocql004,xmid011,NULL,xmid012,xmid013,xmid017,l_xmid017_pre,l_proportion,'N' "
                  "        xmid010,oojdl003,xmid011,NULL,xmid012,xmid013,xmid017,l_xmid017_pre,l_proportion,'N' "
                 #160621-00003#6 160629 by lori mark and add---(E)  
#   #end add-point
#   LET g_select = " SELECT xmic001,( SELECT xmial003 FROM xmial_t WHERE xmial_t.xmial001 = xmic_t.xmic001 AND xmial_t.xmialent = xmic_t.xmicent AND xmial_t.xmial002 = '" , 
#       g_dlang,"'" ,"),xmic002,xmic003,xmic004,( SELECT ooefl003 FROM ooefl_t t1 WHERE t1.ooefl001 = xmic_t.xmic004 AND t1.ooeflent = xmic_t.xmicent AND t1.ooefl002 = '" , 
#       g_dlang,"'" ,"),xmic005,( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = xmic_t.xmic005 AND ooefl_t.ooeflent = xmic_t.xmicent AND ooefl_t.ooefl002 = '" , 
#       g_dlang,"'" ,"),xmic006,( SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = xmic_t.xmic006 AND ooag_t.ooagent = xmic_t.xmicent), 
#       xmid007,NULL,NULL,xmid008,NULL,xmid009,NULL,xmid010,NULL,xmid011,NULL,xmid012,xmid013,xmid017, 
#       0,0,NULL"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_from = " FROM axmr173_tmp2 LEFT OUTER JOIN xmial_t ON xmialent = '",g_enterprise,"' AND xmial001 = xmic001 AND xmial002 = '",g_dlang,"' ",
                "                   LEFT OUTER JOIN imaal_t ON imaalent = '",g_enterprise,"' AND imaal001 = xmid007 AND imaal002 = '",g_dlang,"' ",
                "                   LEFT OUTER JOIN ooag_t ON ooagent = '",g_enterprise,"' AND ooag001 = xmic006 ",
                "                   LEFT OUTER JOIN ooefl_t t1 ON t1.ooeflent = '",g_enterprise,"' AND t1.ooefl001 = xmic004 AND  t1.ooefl002 = '",g_dlang,"' ",
                "                   LEFT OUTER JOIN ooefl_t t2 ON t2.ooeflent = '",g_enterprise,"' AND t2.ooefl001 = xmic005 AND  t2.ooefl002 = '",g_dlang,"' ",
                "                   LEFT OUTER JOIN pmaal_t ON pmaalent = '",g_enterprise,"' AND pmaal001 = xmid009 AND pmaal002 = '",g_dlang,"' ",
               #160621-00003#6 160629 by lori mark and add---(S) 
               #"                   LEFT OUTER JOIN oocql_t ON oocqlent = '",g_enterprise,"' AND oocql001 = '275' AND oocql002 = xmid010 AND oocql003 = '",g_dlang,"' "
                "                   LEFT OUTER JOIN oojdl_t ON oojdlent = '",g_enterprise,"' AND oojdl001 = xmid010 AND oojdl002 = '",g_dlang,"' "
               #160621-00003#6 160629 by lori mark and add---(E) 
#   LET g_from = " FROM (SELECT xmicent,xmic001,xmic002,MAX(xmic003) AS xmic003,xmic004,xmic005,xmic006 FROM xmic_t GROUP BY xmicent,xmic001,xmic002,xmic004,xmic005,xmic006 ) a, ",
#                "       xmic_t b ",
#                "       LEFT OUTER JOIN xmid_t c ON b.xmicent = c.xmident AND b.xmic001 = c.xmid001 AND b.xmic002 = c.xmid002 AND b.xmic003 = c.xmid003 AND b.xmic004 = c.xmid004 AND b.xmic005 = c.xmid005 AND b.xmic006 = c.xmid006 ",
#                "       LEFT OUTER JOIN xmial_t d ON d.xmial001 = b.xmic001 AND d.xmialent = b.xmicent AND d.xmial002 = '",g_dlang,"' ",
#                "       LEFT OUTER JOIN imaal_t e ON e.imaalent = c.xmident AND e.imaal001 = c.xmid007 AND e.imaal002 = '",g_dlang,"' ",
#                "       LEFT OUTER JOIN ooag_t f ON f.ooag001 = b.xmic006 AND f.ooagent = b.xmicent "
#   #end add-point
#    LET g_from = " FROM xmic_t LEFT OUTER JOIN ( SELECT xmid_t.* FROM xmid_t  ) x  ON xmic_t.xmicent  
#        = x.xmident AND xmic_t.xmic001 = x.xmid001 AND xmic_t.xmic002 = x.xmid002 AND xmic_t.xmic003  
#        = x.xmid003 AND xmic_t.xmic004 = x.xmid004 AND xmic_t.xmic005 = x.xmid005 AND xmic_t.xmic006  
#        = x.xmid006"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
#   LET g_where = " WHERE a.xmicent = b.xmicent AND a.xmic001 = b.xmic001 AND a.xmic002 = b.xmic002 ",
#                 "   AND a.xmic003 = b.xmic003 AND a.xmic004 = b.xmic004 AND a.xmic005 = b.xmic005 ",
#                 "   AND a.xmic006 = b.xmic006 AND ",tm.wc CLIPPED
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("xmic_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE axmr173_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE axmr173_x01_curs CURSOR FOR axmr173_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="axmr173_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION axmr173_x01_ins_data()
DEFINE sr RECORD 
   xmic001 LIKE xmic_t.xmic001, 
   xmial_t_xmial003 LIKE xmial_t.xmial003, 
   xmic002 LIKE xmic_t.xmic002, 
   xmic003 LIKE xmic_t.xmic003, 
   xmic004 LIKE xmic_t.xmic004, 
   t1_ooefl003 LIKE ooefl_t.ooefl003, 
   xmic005 LIKE xmic_t.xmic005, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   xmic006 LIKE xmic_t.xmic006, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   xmid007 LIKE xmid_t.xmid007, 
   l_imaal003 LIKE imaal_t.imaal003, 
   l_imaal004 LIKE imaal_t.imaal004, 
   xmid008 LIKE xmid_t.xmid008, 
   l_xmid008_desc LIKE type_t.chr1000, 
   xmid009 LIKE xmid_t.xmid009, 
   l_xmid009_desc LIKE pmaal_t.pmaal004, 
   xmid010 LIKE xmid_t.xmid010, 
   l_xmid010_desc LIKE oocql_t.oocql004, 
   xmid011 LIKE xmid_t.xmid011, 
   l_xmid011 LIKE type_t.chr30, 
   xmid012 LIKE xmid_t.xmid012, 
   xmid013 LIKE xmid_t.xmid013, 
   xmid017 LIKE xmid_t.xmid017, 
   l_xmid017_pre LIKE xmid_t.xmid017, 
   l_proportion LIKE xmid_t.xmid015, 
   l_show LIKE type_t.chr1
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_sql        STRING
DEFINE l_success    LIKE type_t.num5
DEFINE l_count      LIKE type_t.num5
DEFINE l_proportion LIKE xmid_t.xmid015
DEFINE l_xmib004    LIKE xmib_t.xmib004
DEFINE l_xmic001    LIKE xmic_t.xmic001
DEFINE l_xmic002    LIKE xmic_t.xmic002
DEFINE l_xmic003    LIKE xmic_t.xmic003
DEFINE l_xmic004    LIKE xmic_t.xmic004
DEFINE l_xmic005    LIKE xmic_t.xmic005
DEFINE l_xmic006    LIKE xmic_t.xmic006
DEFINE l_xmid007    LIKE xmid_t.xmid007
DEFINE l_xmid008    LIKE xmid_t.xmid008
DEFINE l_xmid009    LIKE xmid_t.xmid009
DEFINE l_xmid010    LIKE xmid_t.xmid010
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH axmr173_x01_curs INTO sr.*                               
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
       CALL s_feature_description(sr.xmid007,sr.xmid008) RETURNING l_success,sr.l_xmid008_desc
       CALL cl_getmsg_parm('axm-00778',g_lang,sr.xmid011) RETURNING sr.l_xmid011
       IF tm.a3 = 'Y' THEN
          LET l_xmib004 = ''
          SELECT xmib004 INTO l_xmib004
            FROM xmib_t
           WHERE xmibent = g_enterprise
             AND xmib001 = sr.xmic001
             AND xmib002 = sr.xmid011
          
          IF NOT cl_null(l_xmib004) THEN LET l_xmib004 = l_xmib004 / 100 END IF
          LET l_proportion = ''
          IF sr.l_proportion < 0 THEN 
             LET l_proportion = sr.l_proportion * (-1) 
          ELSE
             LET l_proportion = sr.l_proportion
          END IF
          IF l_proportion > l_xmib004 THEN LET sr.l_show = 'Y' END IF
       END IF
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.xmic001,sr.xmial_t_xmial003,sr.xmic002,sr.xmic003,sr.xmic004,sr.t1_ooefl003,sr.xmic005,sr.ooefl_t_ooefl003,sr.xmic006,sr.ooag_t_ooag011,sr.xmid007,sr.l_imaal003,sr.l_imaal004,sr.xmid008,sr.l_xmid008_desc,sr.xmid009,sr.l_xmid009_desc,sr.xmid010,sr.l_xmid010_desc,sr.l_xmid011,sr.xmid017,sr.l_xmid017_pre,sr.l_proportion,sr.l_show
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "axmr173_x01_execute"
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
    IF tm.a3 = 'Y' THEN
       LET l_sql = " SELECT COUNT(*) ",
                   "   FROM ",g_rep_db CLIPPED,g_rep_tmpname[1] CLIPPED,
                   "  WHERE xmic001 = ? ",
                   "    AND xmic002 = ? ",
                   "    AND xmic003 = ? ",
                   "    AND xmic004 = ? ",
                   "    AND xmic005 = ? ",
                   "    AND xmic006 = ? ",
                   "    AND xmid007 = ? ",
                   "    AND xmid008 = ? ",
                   "    AND xmid009 = ? ",
                   "    AND xmid010 = ? ",
                   "    AND l_show = 'Y' "
       PREPARE axmr173_count FROM l_sql
       
       LET l_sql = "DELETE FROM ",g_rep_db CLIPPED,g_rep_tmpname[1] CLIPPED,
                   "  WHERE xmic001 = ? ",                 
                   "    AND xmic002 = ? ",
                   "    AND xmic003 = ? ",
                   "    AND xmic004 = ? ",
                   "    AND xmic005 = ? ",
                   "    AND xmic006 = ? ",
                   "    AND xmid007 = ? ",
                   "    AND xmid008 = ? ",
                   "    AND xmid009 = ? ",
                   "    AND xmid010 = ? "
       PREPARE axmr173_delete FROM l_sql
       
       LET l_sql = " SELECT DISTINCT xmic001,xmic002,xmic003,xmic004,xmic005,xmic006,xmid007,xmid008,xmid009,xmid010 ",
                   "   FROM ",g_rep_db CLIPPED,g_rep_tmpname[1] CLIPPED
       DECLARE axmr173_modify CURSOR FROM l_sql
       INITIALIZE l_xmic001,l_xmic002,l_xmic003,l_xmic004,l_xmic005,l_xmic006,l_xmid007,l_xmid008,l_xmid009,l_xmid010 TO NULL
       FOREACH axmr173_modify INTO l_xmic001,l_xmic002,l_xmic003,l_xmic004,l_xmic005,l_xmic006,l_xmid007,l_xmid008,l_xmid009,l_xmid010
       
          IF STATUS THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.extend = 'axmr173_modify_foreach:'
             LET g_errparam.code   = STATUS
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             LET g_rep_success = 'N'
             EXIT FOREACH
          END IF
          
          LET l_count = 0
          EXECUTE axmr173_count USING l_xmic001,l_xmic002,l_xmic003,l_xmic004,l_xmic005,l_xmic006,l_xmid007,l_xmid008,l_xmid009,l_xmid010 INTO l_count
          IF l_count = 0 THEN
            EXECUTE axmr173_delete USING l_xmic001,l_xmic002,l_xmic003,l_xmic004,l_xmic005,l_xmic006,l_xmid007,l_xmid008,l_xmid009,l_xmid010
          END IF
       END FOREACH
    END IF
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axmr173_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION axmr173_x01_rep_data()
#add-point:rep_data.define (客製用) name="rep_data.define_customerization"

#end add-point:rep_data.define
#add-point:rep_data.define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="rep_data.define"

#end add-point:rep_data.define
 
    #add-point:rep_data.before name="rep_data.before"
    
    #end add-point:rep_data.before
    
    CALL cl_xg_view()
    #add-point:rep_data.after name="rep_data.after"
    DROP TABLE axmr173_tmp;
    DROP TABLE axmr173_tmp1;
    DROP TABLE axmr173_tmp2;
    #end add-point:rep_data.after
END FUNCTION
 
{</section>}
 
{<section id="axmr173_x01.other_function" readonly="Y" >}

 
{</section>}
 
