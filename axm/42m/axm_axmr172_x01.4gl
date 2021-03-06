#該程式未解開Section, 採用最新樣板產出!
{<section id="axmr172_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2016-06-01 11:25:19), PR版次:0002(2016-06-01 15:42:21)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000030
#+ Filename...: axmr172_x01
#+ Description: ...
#+ Creator....: 05384(2016-04-22 14:32:34)
#+ Modifier...: 05384 -SD/PR- 05384
 
{</section>}
 
{<section id="axmr172_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#160511-00001#1   2016/06/01 By shiun     1. 調整"檢核未輸入預測資料的預測料號"段的sql。2. 檢核逾期未維護的預測資料，每個據點，預測編號應該只出現一次
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
       wc2 STRING,                  #where condition2 
       wc3 STRING,                  #where condition3 
       a1 LIKE type_t.dat,         #基準日期 
       a2 LIKE type_t.chr1,         #未輸入預測 
       a3 LIKE type_t.chr1,         #逾期未維護 
       a4 LIKE type_t.chr1          #逾期未確認
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="axmr172_x01.main" readonly="Y" >}
PUBLIC FUNCTION axmr172_x01(p_arg1,p_arg2,p_arg3,p_arg4,p_arg5,p_arg6,p_arg7)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 STRING                  #tm.wc2  where condition2 
DEFINE  p_arg3 STRING                  #tm.wc3  where condition3 
DEFINE  p_arg4 LIKE type_t.dat         #tm.a1  基準日期 
DEFINE  p_arg5 LIKE type_t.chr1         #tm.a2  未輸入預測 
DEFINE  p_arg6 LIKE type_t.chr1         #tm.a3  逾期未維護 
DEFINE  p_arg7 LIKE type_t.chr1         #tm.a4  逾期未確認
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.wc2 = p_arg2
   LET tm.wc3 = p_arg3
   LET tm.a1 = p_arg4
   LET tm.a2 = p_arg5
   LET tm.a3 = p_arg6
   LET tm.a4 = p_arg7
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "axmr172_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL axmr172_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL axmr172_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL axmr172_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL axmr172_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL axmr172_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="axmr172_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION axmr172_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "xmic001.xmic_t.xmic001,xmial_t_xmial003.xmial_t.xmial003,xmic002.xmic_t.xmic002,xmic003.xmic_t.xmic003,xmic004.xmic_t.xmic004,t1_ooefl003.ooefl_t.ooefl003,xmic005.xmic_t.xmic005,ooefl_t_ooefl003.ooefl_t.ooefl003,xmic006.xmic_t.xmic006,ooag_t_ooag011.ooag_t.ooag011,xmid007.xmid_t.xmid007,l_imaal003.imaal_t.imaal003,l_imaal004.imaal_t.imaal004,l_chk.type_t.chr1000" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   DROP TABLE axmr172_tmp;
   CREATE TEMP TABLE axmr172_tmp(
      xmic001         VARCHAR(10),            #預測編號  
      xmic002         DATE,            #預測基準日 
      xmic003         SMALLINT,            #版本 
      xmic004         VARCHAR(10),            #預測營運據點
      xmic005         VARCHAR(10),            #銷售組織
      xmic006         VARCHAR(20),            #業務員 
      xmid007         VARCHAR(40),            #預測料號
      xmid011         SMALLINT,            #期別
      xmid012         DATE,            #預測起始日
      xmid013         DATE,            #預測截止日
      xmid015         DECIMAL(20,6)     #預測數量
   )  
   CREATE TEMP TABLE axmr172_tmp1(
      xmic001         VARCHAR(10),            #預測編號  
      xmic002         DATE,            #預測基準日 
      xmic003         SMALLINT,            #版本 
      xmic004         VARCHAR(10),            #預測營運據點
      xmic005         VARCHAR(10),            #銷售組織
      xmic006         VARCHAR(20),            #業務員 
      xmid007         VARCHAR(40),            #預測料號
      xmid011         SMALLINT,            #期別
      xmid012         DATE,            #預測起始日
      xmid013         DATE,            #預測截止日
      xmid015         DECIMAL(20,6)     #預測數量
   )
   DROP TABLE axmr172_tmp2;
   CREATE TEMP TABLE axmr172_tmp2(
   xmic001   VARCHAR(10), 
#   xmial003 LIKE xmial_t.xmial003, 
   xmic002   DATE, 
   xmic003   SMALLINT, 
   xmic004   VARCHAR(10),
   xmic005   VARCHAR(10), 
#   ooefl003 LIKE ooefl_t.ooefl003, 
   xmic006   VARCHAR(20), 
#   ooag011  LIKE ooag_t.ooag011, 
   xmid007   VARCHAR(40), 
#   imaal003 LIKE imaal_t.imaal003, 
#   imaal004 LIKE imaal_t.imaal004, 
   l_chk     VARCHAR(1000)
   )
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="axmr172_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION axmr172_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?)"
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
 
{<section id="axmr172_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axmr172_x01_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define(客製用) name="sel_prep.define_customerization"

#end add-point
#add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
DEFINE l_sql         STRING
DEFINE l_count    LIKE type_t.num5
DEFINE l_msg      LIKE type_t.chr500
DEFINE l_xmic001  LIKE xmic_t.xmic001 
DEFINE l_xmic002  LIKE xmic_t.xmic002 
DEFINE l_xmic003  LIKE xmic_t.xmic003 
DEFINE l_xmic004  LIKE xmic_t.xmic004
DEFINE l_xmic005  LIKE xmic_t.xmic005 
DEFINE l_xmic006  LIKE xmic_t.xmic006 
#DEFINE l_xmid007  LIKE xmid_t.xmid007 
DEFINE l_chk      LIKE type_t.chr1000
DEFINE l_imaf125  LIKE imaf_t.imaf125
DEFINE l_imafsite LIKE imaf_t.imafsite
DEFINE l_wc2      STRING
#end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   LET l_sql = " INSERT INTO axmr172_tmp ",
               " SELECT b.xmic001,b.xmic002,b.xmic003,b.xmic004,b.xmic005,b.xmic006,xmid007,xmid011,xmid012,xmid013,xmid015 ",
               "   FROM (SELECT xmicent,xmic001,xmic002,MAX(xmic003) AS xmic003,xmic004,xmic005,xmic006 FROM xmic_t GROUP BY xmicent,xmic001,xmic002,xmic004,xmic005,xmic006 ) a, ",
               "        xmic_t b LEFT OUTER JOIN xmid_t c ON b.xmicent = c.xmident AND b.xmic001 = c.xmid001 AND b.xmic002 = c.xmid002 AND b.xmic003 = c.xmid003 AND b.xmic004 = c.xmid004 AND b.xmic005 = c.xmid005 AND b.xmic006 = c.xmid006 ",
               "  WHERE a.xmicent = b.xmicent AND a.xmic001 = b.xmic001 AND a.xmic002 = b.xmic002 ",
               "    AND a.xmic003 = b.xmic003 AND a.xmic004 = b.xmic004 AND a.xmic005 = b.xmic005 ",
               "    AND a.xmic006 = b.xmic006 AND a.xmic002 <= '",tm.a1,"' AND ",tm.wc, " AND ",tm.wc3
   PREPARE axmr172_tmp_insert FROM l_sql
   EXECUTE axmr172_tmp_insert
   
   #檢核未輸入預測資料的預測料號
   IF tm.a2 = 'Y' THEN
      CALL cl_getmsg('axm-00775',g_lang) RETURNING l_msg
      LET l_wc2 = cl_replace_str(tm.wc3,'a.xmic004','imafsite')
      LET tm.wc2 = cl_replace_str(tm.wc2,'imaf125','b.imaf125')
      #mod--160511-00001#1 By shiun--(S)
#      LET l_sql = " SELECT imaf125,imafsite ",
#                  "   FROM imaa_t,imaf_t,oocq_t ",
#                  "  WHERE imaaent = imafent ",
#                  "    AND imaaent = oocqent ",
#                  "    AND imaa001 = imaf125 ",
#                  "    AND imafent = '",g_enterprise,"' ",
#                  "    AND imaastus = 'Y' ",
#                  "    AND imafsite <> 'ALL' ",
#                  "    AND oocq001 = '210' ",
#                  "    AND oocq002 = imaf016 ",
#                  "    AND oocq010 = 'Y' ",
#                  "    AND ",tm.wc2,
#                  "    AND ",l_wc2
      LET l_sql = " SELECT b.imaf125,b.imafsite ",
                  "   FROM imaa_t,imaf_t b,oocq_t,imaf_t a ",
                  "   WHERE imaaent = b.imafent ",
                  "   AND a.imafent = b.imafent ",
                  "   AND a.imaf001 = b.imaf125 ",
                  "   AND a.imafsite = b.imafsite ",
                  "   AND imaaent = oocqent ",   
                  "   AND imaa001 = b.imaf125 ",    
                  "   AND b.imafent = '",g_enterprise,"' ",
                  "   AND imaastus = 'Y' ",
                  "   AND b.imafsite <> 'ALL' ",
                  "   AND oocq001 = '210' ",
                  "   AND oocq002 = a.imaf016 ",
                  "   AND oocq010 = 'Y' ",
                  "   AND ",tm.wc2,
                  "   AND ",l_wc2
      #mod--160511-00001#1 By shiun--(E)
      PREPARE axmr172_x01_a2_pre FROM l_sql      
      DECLARE axmr172_x01_a2_curs CURSOR FOR axmr172_x01_a2_pre
      
      LET l_sql = " SELECT COUNT(*) ",
                  "   FROM axmr172_tmp ",
                  "  WHERE xmic004 = ? ",
                  "    AND xmid007 = ? ",
                  "    AND xmid012 <= '",tm.a1,"' ",
                  "    AND xmid013 >= '",tm.a1,"' "
      PREPARE axmr172_x01_a2_pre2 FROM l_sql
      FOREACH axmr172_x01_a2_curs INTO l_imaf125,l_imafsite
         LET l_count = 0
         EXECUTE axmr172_x01_a2_pre2 USING l_imafsite,l_imaf125 INTO l_count
         IF l_count = 0 THEN
            INSERT INTO axmr172_tmp2(xmic004,xmid007,l_chk) VALUES(l_imafsite,l_imaf125,l_msg)
         END IF
      END FOREACH
   END IF
   
   #檢核逾期未維護的預測資料
   LET l_sql = " SELECT DISTINCT xmic001,xmic002,xmic003,xmic004,xmic005,xmic006 ",
               "   FROM xmia_t,axmr172_tmp ",
               "  WHERE xmiaent = '",g_enterprise,"' ",
               "    AND xmia001 = xmic001 ",
               "    AND xmiastus = 'Y' "
   PREPARE axmr172_x01_a3_pre FROM l_sql
   DECLARE axmr172_x01_a3_curs CURSOR FOR axmr172_x01_a3_pre
   IF tm.a3 = 'Y' THEN
      INSERT INTO axmr172_tmp1 SELECT * FROM axmr172_tmp
      LET l_xmic001 = ''
      CALL cl_getmsg('axm-00776',g_lang) RETURNING l_msg
      LET l_sql = " SELECT COUNT(*) ",
                  "   FROM axmr172_tmp ",
                  "  WHERE xmic001 = ? ",
#                  "    AND xmic002 = ? ",
#                  "    AND xmic003 = ? ",
#                  "    AND xmic004 = ? ",
#                  "    AND xmic005 = ? ",
#                  "    AND xmic006 = ? ",
                  "    AND xmid011 = '1' ",
                  "    AND xmid012 <= '",tm.a1,"' ",
                  "    AND xmid013 >= '",tm.a1,"' "#,
#                  "  GROUP BY xmic002,xmic003,xmic004,xmic005,xmic006 "
      PREPARE axmr172_x01_a3_pre2 FROM l_sql
      DECLARE axmr172_x01_a3_curs2 CURSOR FOR axmr172_x01_a3_pre2
      INITIALIZE l_xmic001,l_xmic002,l_xmic003,l_xmic004,l_xmic005,l_xmic006 TO NULL
      FOREACH axmr172_x01_a3_curs INTO l_xmic001,l_xmic002,l_xmic003,l_xmic004,l_xmic005,l_xmic006
         LET l_count = 0         
         FOREACH axmr172_x01_a3_curs2 USING l_xmic001#,l_xmic002,l_xmic003,l_xmic004,l_xmic005,l_xmic006 INTO l_count
            IF l_count > 0 THEN
#                INSERT INTO axmr172_tmp2(xmic001,xmic002,xmic003,xmic005,xmic006,l_chk)
#                                  VALUES(l_xmic001,l_xmic002,l_xmic003,l_xmic005,l_xmic006,l_msg)
               DELETE FROM axmr172_tmp1 
                WHERE xmic001 = l_xmic001
#                  AND xmic002 = l_xmic002
#                  AND xmic003 = l_xmic003
#                  AND xmic004 = l_xmic004
#                  AND xmic005 = l_xmic005
#                  AND xmic006 = l_xmic006
            END IF
         END FOREACH
      END FOREACH
      #mod--160511-00001#1 By shiun--(S)
#      LET l_sql = " SELECT DISTINCT xmic001,xmic002,xmic003,xmic004,xmic005,xmic006 ",
      LET l_sql = " SELECT DISTINCT xmic001,MAX(xmic002),xmic003,xmic004,xmic005,xmic006 ",
                  "   FROM axmr172_tmp1 ",
                  "  GROUP BY xmic001,xmic003,xmic004,xmic005,xmic006 "
      #mod--160511-00001#1 By shiun--(E)
      PREPARE axmr172_x01_a3_pre3 FROM l_sql
      DECLARE axmr172_x01_a3_curs3 CURSOR FOR axmr172_x01_a3_pre3
      
      INITIALIZE l_xmic001,l_xmic002,l_xmic003,l_xmic004,l_xmic005,l_xmic006 TO NULL
      FOREACH axmr172_x01_a3_curs3 INTO l_xmic001,l_xmic002,l_xmic003,l_xmic004,l_xmic005,l_xmic006
         INSERT INTO axmr172_tmp2(xmic001,xmic002,xmic003,xmic004,xmic005,xmic006,l_chk)
                           VALUES(l_xmic001,l_xmic002,l_xmic003,l_xmic004,l_xmic005,l_xmic006,l_msg)
      END FOREACH
   END IF
   
   #檢核逾期未確認的預測資料
   IF tm.a4 = 'Y' THEN
      LET l_xmic001 = ''
      CALL cl_getmsg('axm-00777',g_lang) RETURNING l_msg
      LET l_sql = " SELECT COUNT(*) ",
                  "   FROM xmic_t ",
                  "  WHERE xmicent = '",g_enterprise,"' ",
                  "    AND xmic001 = ? ",                  
                  "    AND xmic002 = ? ",
                  "    AND xmic003 = ? ",
                  "    AND xmic004 = ? ",
                  "    AND xmic005 = ? ",
                  "    AND xmic006 = ? ",
                  "    AND xmic002 <= '",tm.a1,"' ",
                  "    AND xmicstus = 'N' ",
                  "  GROUP BY xmic002,xmic003,xmic004,xmic005,xmic006 "
      PREPARE axmr172_x01_a4_pre2 FROM l_sql
      DECLARE axmr172_x01_a4_curs2 CURSOR FOR axmr172_x01_a4_pre2
      INITIALIZE l_xmic001,l_xmic002,l_xmic003,l_xmic004,l_xmic005,l_xmic006 TO NULL
      FOREACH axmr172_x01_a3_curs INTO l_xmic001,l_xmic002,l_xmic003,l_xmic004,l_xmic005,l_xmic006
            LET l_count = 0            
            FOREACH axmr172_x01_a4_curs2 USING l_xmic001,l_xmic002,l_xmic003,l_xmic004,l_xmic005,l_xmic006 INTO l_count
            IF l_count > 0 THEN
                INSERT INTO axmr172_tmp2(xmic001,xmic002,xmic003,xmic004,xmic005,xmic006,l_chk)
                                  VALUES(l_xmic001,l_xmic002,l_xmic003,l_xmic004,l_xmic005,l_xmic006,l_msg)
            END IF
         END FOREACH
      END FOREACH
   END IF
   #end add-point
 
   #add-point:sel_prep g_select name="sel_prep.g_select"
   LET g_select = " SELECT DISTINCT xmic001,xmial003,xmic002,xmic003,xmic004,t1.ooefl003,xmic005,t2.ooefl003, ",
                  "        xmic006,ooag011,xmid007,imaal003,imaal004,l_chk "
#   #end add-point
#   LET g_select = " SELECT xmic001,( SELECT xmial003 FROM xmial_t WHERE xmial_t.xmial001 = xmic_t.xmic001 AND xmial_t.xmialent = xmic_t.xmicent AND xmial_t.xmial002 = '" , 
#       g_dlang,"'" ,"),xmic002,xmic003,xmic004,( SELECT ooefl003 FROM ooefl_t t1 WHERE t1.ooefl001 = xmic_t.xmic004 AND t1.ooeflent = xmic_t.xmicent AND t1.ooefl002 = '" , 
#       g_dlang,"'" ,"),xmic005,( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = xmic_t.xmic005 AND ooefl_t.ooeflent = xmic_t.xmicent AND ooefl_t.ooefl002 = '" , 
#       g_dlang,"'" ,"),xmic006,( SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = xmic_t.xmic006 AND ooag_t.ooagent = xmic_t.xmicent), 
#       xmid007,NULL,NULL,NULL"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_from = " FROM axmr172_tmp2 LEFT OUTER JOIN xmial_t ON xmialent = '",g_enterprise,"' AND xmial001 = xmic001 AND xmial002 = '",g_dlang,"' ",
                "                   LEFT OUTER JOIN imaal_t ON imaalent = '",g_enterprise,"' AND imaal001 = xmid007 AND imaal002 = '",g_dlang,"' ",
                "                   LEFT OUTER JOIN ooag_t ON ooagent = '",g_enterprise,"' AND ooag001 = xmic006 ",
                "                   LEFT OUTER JOIN ooefl_t t1 ON t1.ooeflent = '",g_enterprise,"' AND t1.ooefl001 = xmic004 AND  t1.ooefl002 = '",g_dlang,"' ",
                "                   LEFT OUTER JOIN ooefl_t t2 ON t2.ooeflent = '",g_enterprise,"' AND t2.ooefl001 = xmic005 AND  t2.ooefl002 = '",g_dlang,"' "
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
   PREPARE axmr172_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE axmr172_x01_curs CURSOR FOR axmr172_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="axmr172_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION axmr172_x01_ins_data()
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
   l_chk LIKE type_t.chr1000
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH axmr172_x01_curs INTO sr.*                               
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
       EXECUTE insert_prep USING sr.xmic001,sr.xmial_t_xmial003,sr.xmic002,sr.xmic003,sr.xmic004,sr.t1_ooefl003,sr.xmic005,sr.ooefl_t_ooefl003,sr.xmic006,sr.ooag_t_ooag011,sr.xmid007,sr.l_imaal003,sr.l_imaal004,sr.l_chk
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "axmr172_x01_execute"
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
 
{<section id="axmr172_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION axmr172_x01_rep_data()
#add-point:rep_data.define (客製用) name="rep_data.define_customerization"

#end add-point:rep_data.define
#add-point:rep_data.define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="rep_data.define"

#end add-point:rep_data.define
 
    #add-point:rep_data.before name="rep_data.before"
    
    #end add-point:rep_data.before
    
    CALL cl_xg_view()
    #add-point:rep_data.after name="rep_data.after"
    DROP TABLE axmr172_tmp;
    DROP TABLE axmr172_tmp1;
    DROP TABLE axmr172_tmp2;
    #end add-point:rep_data.after
END FUNCTION
 
{</section>}
 
{<section id="axmr172_x01.other_function" readonly="Y" >}

 
{</section>}
 
