#該程式未解開Section, 採用最新樣板產出!
{<section id="acrr724_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2016-10-17 14:16:06), PR版次:0002(2016-10-17 17:19:10)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000050
#+ Filename...: acrr724_x01
#+ Description: ...
#+ Creator....: 01533(2015-04-01 16:56:40)
#+ Modifier...: 02749 -SD/PR- 02749
 
{</section>}
 
{<section id="acrr724_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
# Modify..........: 160819-00054#30   2016/10/17 by lori   1.BUG調整:若無輸入會員屬性資料, 查詢結果會造成資料發散
#                                                          2.BUG調整:acrr724_x01_prepare查詢結果資料發散
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
       bdate LIKE ooga_t.ooga001,         #当前日期 
       wc2 STRING                   #查询条件
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="acrr724_x01.main" readonly="Y" >}
PUBLIC FUNCTION acrr724_x01(p_arg1,p_arg2,p_arg3)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE ooga_t.ooga001         #tm.bdate  当前日期 
DEFINE  p_arg3 STRING                  #tm.wc2  查询条件
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.bdate = p_arg2
   LET tm.wc2 = p_arg3
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "acrr724_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL acrr724_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL acrr724_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL acrr724_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL acrr724_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL acrr724_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="acrr724_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION acrr724_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "l_year.type_t.num5,l_month.type_t.num5,l_mmaf001_mmaf008.type_t.chr300,mmaf014.mmaf_t.mmaf014,l_grade.type_t.chr300,l_rtab001_rtaal003.type_t.chr300,l_mmafunit_ooefl003.type_t.chr300,l_amount1.type_t.num20_6,l_amount2.type_t.num20_6,l_ring1.type_t.num15_3,l_rate1.type_t.num15_3,l_profit1.type_t.num20_6,l_profit2.type_t.num20_6,l_ring2.type_t.num15_3,l_rate2.type_t.num15_3" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="acrr724_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION acrr724_x01_ins_prep()
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
 
{<section id="acrr724_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION acrr724_x01_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define(客製用) name="sel_prep.define_customerization"

#end add-point
#add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
DEFINE l_year       LIKE type_t.num5
DEFINE l_month      LIKE type_t.num5
DEFINE l_bdate      LIKE type_t.dat
DEFINE l_edate      LIKE type_t.dat
DEFINE l_bdate1     LIKE type_t.dat
DEFINE l_edate1     LIKE type_t.dat
DEFINE l_int        LIKE type_t.num5    #判斷查詢字串中是否含有mmag #160819-00054#30 161017 by lori add
#end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
#by yangxf 20160303 (S)
#   IF tm.month = 1 THEN
#      LET l_year = tm.year -1
#      LET l_month = 12
#   ELSE
#      LET l_year = tm.year
#      LET l_month = tm.month - 1    
#   END IF
#by yangxf 20160303 (E)
   LET l_bdate = s_date_get_first_date(tm.bdate)
   LET l_edate = s_date_get_last_date(tm.bdate)
   #上一个月
   LET l_bdate1 = s_date_get_date(tm.bdate,-1,0)
   LET l_bdate1 = s_date_get_first_date(l_bdate1)
   LET l_edate1 = s_date_get_last_date(l_bdate1)
   LET l_month = MONTH(tm.bdate)
   
   LET l_int = 0                            #160819-00054#30 161017 by lori add
   LET l_int = tm.wc.getIndexOf("mmag",1)   #160819-00054#30 161017 by lori add   
   #end add-point
 
   #add-point:sel_prep g_select name="sel_prep.g_select"
   LET tm.wc = cl_replace_str(tm.wc,'decc','c.decc')
   LET tm.wc = cl_replace_str(tm.wc,'mmag','t2.mmag')
   #end add-point
   LET g_select = " SELECT 0,0,NULL,mmaf014,NULL,NULL,NULL,0,0,0,0,0,0,0,0"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
  #160819-00054#30 161017 by lori mark---(S)   
  #LET g_select = " SELECT to_char(c.decc002,'yyyy') decc002_1,'', TRIM(c.decc001)||'.'||TRIM(mmaf008) decc001_desc,mmaf014,TRIM(t1.mmag004)||'.'||TRIM(oocql004) mmag004_desc,",
  #               " TRIM(rtab001)||'.'||TRIM(rtaal003) rtab001_desc,TRIM(mmafunit)||'.'||TRIM(ooefl003) mmafunit_desc,COALESCE(SUM(a.decc010),0) decc010_a,COALESCE(SUM(b.decc010),0) decc010_b, ",
  #              #"  SUM(b.decc010)/SUM(a.decc010) ,(SUM(b.decc010)-SUM(a.decc010))/SUM(a.decc010),SUM(a.decc014),SUM(b.decc014),SUM(b.decc014)/SUM(a.decc014), (SUM(b.decc014)-SUM(a.decc014))/SUM(a.decc014) "    #mark by yangxf 20160224
  #              #add by yangxf ----start----20160224 
  #               " CASE COALESCE(SUM(a.decc010),0) WHEN 0 THEN 0 ELSE (COALESCE(SUM(b.decc010),0) / SUM(a.decc010))*100 END ring1 , ",
  #               " CASE COALESCE(SUM(a.decc010),0) WHEN 0 THEN 0 ELSE ((COALESCE(SUM(b.decc010),0) - COALESCE(SUM(a.decc010),0)) / SUM(a.decc010))*100 END rate1 ,",
  #               " COALESCE(SUM(a.decc014),0) decc014_a,COALESCE(SUM(b.decc014),0) decc014_b, ",
  #               " CASE COALESCE(SUM(a.decc014),0) WHEN 0 THEN 0 ELSE (COALESCE(SUM(b.decc014),0) / SUM(a.decc014))*100 END ring2, ",
  #               " CASE COALESCE(SUM(a.decc014),0) WHEN 0 THEN 0 ELSE ((COALESCE(SUM(b.decc014),0) - COALESCE(SUM(a.decc014),0)) / SUM(a.decc014))*100 END rate2 "
  #              #add by yangxf ----end----20160224
  #160819-00054#30 161017 by lori mark---(E)   

   #160819-00054#30 161017 by lori add---(S)
   LET g_select = " SELECT decc002_1, ",
                  "        '',  ",
                  "        decc001||'.'||t1.mmaf008 decc001_desc, ",
                  "        t1.mmaf014, ",
                  "        t1.mmag004||'.'||t1.oocql004 mmag004_desc, ",
                  "        t1.rtab001||'.'||t1.rtaal003 rtab001_desc, ",
                  "        t1.mmafunit||'.'||t1.ooefl003 mmafunit_desc, ",
                  "        COALESCE(SUM(decc010_a),0) decc010_a, ",
                  "        COALESCE(SUM(decc010_b),0) decc010_b, ",
                  "        (CASE WHEN COALESCE(SUM(decc010_a),0) = 0 THEN 0 ",
                  "             ELSE (COALESCE(SUM(decc010_b),0) / SUM(decc010_a))*100 END) ring1 , ",
                  "        (CASE WHEN COALESCE(SUM(decc010_a),0) = 0 THEN 0 ",
                  "              ELSE ((COALESCE(SUM(decc010_b),0) - COALESCE(SUM(decc010_a),0)) / SUM(decc010_a))*100 END) rate1 ,",
                  "        COALESCE(SUM(decc014_a),0) decc014_a, ",
                  "        COALESCE(SUM(decc014_b),0) decc014_b, ",
                  "        (CASE WHEN COALESCE(SUM(decc014_a),0) = 0 THEN 0 ",
                  "              ELSE (COALESCE(SUM(decc014_b),0) / SUM(decc014_a))*100 END) ring2, ",
                  "        (CASE WHEN COALESCE(SUM(decc014_a),0) = 0 THEN 0 ",
                  "              ELSE ((COALESCE(SUM(decc014_b),0) - COALESCE(SUM(decc014_a),0)) / SUM(decc014_a))*100 END) rate2 "   
   #160819-00054#30 161017 by lori add---(E)
   #end add-point
    LET g_from = " FROM mmaf_t,rtab_t,decc_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
  #160819-00054#30 161017 by lori mark---(S)    
  #LET g_from = " FROM decc_t c LEFT JOIN decc_t a ON c.deccent = a.deccent AND c.decc001 = a.decc001 ",
  #             "                                 AND a.decc002 BETWEEN '",l_bdate1,"' AND '",l_edate1,"'",
  #             "               LEFT JOIN decc_t b ON c.deccent = b.deccent AND c.decc001 = b.decc001 ",
  #             "                                 AND b.decc002 BETWEEN '",l_bdate,"' AND '",l_edate,"' ",
  #             "               LEFT OUTER JOIN mmaf_t ON c.deccent = mmafent AND c.decc001 = mmaf001",
  #             "               LEFT OUTER JOIN mmag_t t1 ON mmafent = t1.mmagent AND mmaf001 = t1.mmag001 AND t1.mmag003 = '2024' ", 
  #             "               LEFT OUTER JOIN oocql_t ON t1.mmag004 = oocql002 AND oocql001 = '2024' AND oocql003 = '",g_dlang,"'",                
  #             "               LEFT OUTER JOIN mmag_t t2 ON mmafent = t2.mmagent AND mmaf001 = t2.mmag001 ",   
  #             "               LEFT OUTER JOIN rtab_t ON mmafunit = rtab002 AND mmafent = rtabent ",
  #             "                                     AND EXISTS(SELECT 1 FROM rtak_t WHERE rtakent = rtabent AND rtab001 = rtak001 AND rtak002 = '1' AND rtak003 = 'Y') ",    #add by yangxf 20160224
  #             "               LEFT OUTER JOIN rtaal_t ON rtabent = rtaalent AND rtab001 = rtaal001 AND rtaal002 = '",g_dlang,"'",
  #             "               LEFT OUTER JOIN ooefl_t ON mmafent = ooeflent AND mmafunit = ooefl001 AND ooefl002 = '",g_dlang,"'"
  #160819-00054#30 161017 by lori mark---(E)    

   #160819-00054#30 161017 by lori add---(S)
   LET g_from = " FROM (SELECT deccent, ",
                "              TO_CHAR(decc002, 'YYYY') decc002_1, ",
                "              TRIM(decc001) decc001, ",
                "              (CASE WHEN decc002 BETWEEN '",l_bdate1,"' AND '",l_edate1,"' THEN COALESCE(decc010,0) ELSE 0 END) decc010_a, ",
                "              (CASE WHEN decc002 BETWEEN '",l_bdate, "' AND '",l_edate, "' THEN COALESCE(decc010,0) ELSE 0 END) decc010_b, ",
                "              (CASE WHEN decc002 BETWEEN '",l_bdate1,"' AND '",l_edate1,"' THEN COALESCE(decc014,0) ELSE 0 END) decc014_a, ",
                "              (CASE WHEN decc002 BETWEEN '",l_bdate, "' AND '",l_edate, "' THEN COALESCE(decc014,0) ELSE 0 END) decc014_b  ",                
                "         FROM decc_t ",
                "        WHERE deccent = ",g_enterprise,  
                "          AND decc002 BETWEEN '",l_bdate1,"' AND '",l_edate,"') ",  
                "      LEFT JOIN (SELECT mmafent,mmaf001,TRIM(mmaf008) mmaf008,mmaf014,TRIM(mmafunit) mmafunit, ",
                "                        TRIM(mmag004) mmag004, TRIM(oocql004) oocql004, ",
                "                        TRIM(rtab001) rtab001, TRIM(rtaal003) rtaal003, ",
                "                        TRIM(ooefl003) ooefl003 ",
                "                   FROM mmaf_t ",
                "                         LEFT JOIN (SELECT mmagent,mmag001,mmag003,mmag004,oocql004 ",
                "                                      FROM mmag_t LEFT JOIN oocql_t ",
                "                                                         ON oocqlent = mmagent AND oocql001 = mmag003 AND oocql002 = mmag004 AND oocql003 = '",g_dlang,"') ",
                "                                ON mmafent = mmagent AND mmaf001 = mmag001 AND mmag003 = '2024' ",
                "                         LEFT JOIN (SELECT rtabent,rtab002,rtab001,rtaal003 ",
                "                                      FROM rtab_t LEFT JOIN rtaal_t ",
                "                                                         ON rtabent = rtaalent AND rtab001 = rtaal001 AND rtaal002 = '",g_dlang,"' ",
                "                                          ,rtak_t ",
                "                                     WHERE rtabent = rtakent AND rtab001 = rtak001 AND rtak002 = '1' AND rtak003 = 'Y') ",
                "                                ON mmafent = rtabent  AND mmafunit = rtab002 ",
                "                         LEFT JOIN ooefl_t ON mmafent = ooeflent AND mmafunit = ooefl001 AND ooefl002 = '",g_dlang,"') t1 ",                
                "             ON deccent = mmafent AND decc001 = mmaf001 "

   IF l_int > 0 THEN
      LET g_from = g_from,
                "      LEFT JOIN mmag_t t2 ON mmafent = mmagent AND mmaf001 = t2.mmag001 "
   END IF             
   #160819-00054#30 161017 by lori add---(E)
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   #modify by yangxf 20160303 
  #LET g_where = g_where," AND a.deccent = b.deccent AND a.decc001 = b.decc001 AND to_number(to_char(b.decc002,'yyyy')) = '",tm.year,"' AND to_number(to_char(b.decc002,'mm')) = '",tm.month,"' ",
  #                      " AND to_number(to_char(a.decc002,'yyyy')) = '",l_year,"' AND to_number(to_char(a.decc002,'mm')) = '",l_month,"'"
  
  #160819-00054#30 161017 by lori mark---(S)   
  #LET g_where = g_where," AND c.deccent = ",g_enterprise,
  #                      " AND (EXISTS(SELECT 1 FROM decc_t d WHERE c.deccent = d.deccent AND c.decc001 = d.decc001 AND c.decc002 = d.decc002 ",
  #                      "                AND d.decc002 BETWEEN '",l_bdate1,"' AND '",l_edate1,"')",
  #                      "  OR  EXISTS(SELECT 1 FROM decc_t e WHERE c.deccent = e.deccent AND c.decc001 = e.decc001 AND c.decc002 = e.decc002 ",
  #                      "                AND e.decc002 BETWEEN '",l_bdate,"' AND '",l_edate,"'))"
  #160819-00054#30 161017 by lori mark---(E)      
   #modify by yangxf 20160303
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
 
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("mmaf_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   IF cl_null(tm.wc2) THEN 
      LET tm.wc2 = " 1=1"
   END IF 
  #160819-00054#30 161017 by lori mark---(S) 
  #LET g_sql = g_sql," GROUP BY to_char(c.decc002,'yyyy'), TRIM(c.decc001)||'.'||TRIM(mmaf008),mmaf014,TRIM(t1.mmag004)||'.'||TRIM(oocql004),
  #TRIM(rtab001)||'.'||TRIM(rtaal003),TRIM(mmafunit)||'.'||TRIM(ooefl003) "
  #LET g_sql= " SELECT decc002_1,'",l_month,"',decc001_desc,mmaf014,mmag004_desc,rtab001_desc,mmafunit_desc,decc010_a,decc010_b,ring1/100,rate1/100,decc014_a,decc014_b,ring2/100,rate2/100 FROM (",g_sql,")",
  #           "  WHERE ",tm.wc2 CLIPPED,
  #           " ORDER BY decc002_1,decc001_desc,mmaf014,mmag004_desc,rtab001_desc,mmafunit_desc "  
  #160819-00054#30 161017 by lori mark---(E)
  
   #160819-00054#30 161017 by lori add---(S)
    LET g_sql = g_sql,
               " GROUP BY decc002_1, ",
               "          decc001||'.'||t1.mmaf008, ",
               "          t1.mmaf014, ",
               "          t1.mmag004||'.'||t1.oocql004, ",
               "          t1.rtab001||'.'||t1.rtaal003, ",
               "          t1.mmafunit||'.'||t1.ooefl003 "
               
    LET g_sql= " SELECT decc002_1,   '",l_month,"',decc001_desc,mmaf014,  mmag004_desc, ",
               "        rtab001_desc,mmafunit_desc,decc010_a,   decc010_b,ring1/100, ",
               "        rate1/100,   decc014_a,    decc014_b,   ring2/100,rate2/100 ",
               "   FROM (",g_sql,") ",
               "  WHERE ",tm.wc2 CLIPPED,
               " ORDER BY decc002_1,decc001_desc,mmaf014,mmag004_desc,rtab001_desc,mmafunit_desc "     
   #160819-00054#30 161017 by lori add---(E)
   #end add-point
   PREPARE acrr724_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE acrr724_x01_curs CURSOR FOR acrr724_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="acrr724_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION acrr724_x01_ins_data()
DEFINE sr RECORD 
   l_year LIKE type_t.num5, 
   l_month LIKE type_t.num5, 
   l_mmaf001_mmaf008 LIKE type_t.chr300, 
   mmaf014 LIKE mmaf_t.mmaf014, 
   l_grade LIKE type_t.chr300, 
   l_rtab001_rtaal003 LIKE type_t.chr300, 
   l_mmafunit_ooefl003 LIKE type_t.chr300, 
   l_amount1 LIKE type_t.num20_6, 
   l_amount2 LIKE type_t.num20_6, 
   l_ring1 LIKE type_t.num15_3, 
   l_rate1 LIKE type_t.num15_3, 
   l_profit1 LIKE type_t.num20_6, 
   l_profit2 LIKE type_t.num20_6, 
   l_ring2 LIKE type_t.num15_3, 
   l_rate2 LIKE type_t.num15_3
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH acrr724_x01_curs INTO sr.*                               
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
       EXECUTE insert_prep USING sr.l_year,sr.l_month,sr.l_mmaf001_mmaf008,sr.mmaf014,sr.l_grade,sr.l_rtab001_rtaal003,sr.l_mmafunit_ooefl003,sr.l_amount1,sr.l_amount2,sr.l_ring1,sr.l_rate1,sr.l_profit1,sr.l_profit2,sr.l_ring2,sr.l_rate2
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "acrr724_x01_execute"
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
 
{<section id="acrr724_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION acrr724_x01_rep_data()
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
 
{<section id="acrr724_x01.other_function" readonly="Y" >}

 
{</section>}
 
