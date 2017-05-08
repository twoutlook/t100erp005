#該程式未解開Section, 採用最新樣板產出!
{<section id="aisr410_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:4(2016-09-05 16:01:34), PR版次:0004(2016-09-05 16:10:57)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000046
#+ Filename...: aisr410_g01
#+ Description: ...
#+ Creator....: 06816(2015-05-29 17:16:51)
#+ Modifier...: 06821 -SD/PR- 06821
 
{</section>}
 
{<section id="aisr410_g01.global" readonly="Y" >}
#報表 g01 樣板自動產生(Version:13)
#add-point:填寫註解說明 name="global.memo"
#160905-00002#4 160905 By 06821 補入WHERE條件漏掉ENT的部分
#end add-point
#add-point:填寫註解說明 name="global.memo_customerization"

 
IMPORT os
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../cfg/top_report.inc"                  #報表使用的global
 
#報表 type 宣告
PRIVATE TYPE sr1_r RECORD
   isajent LIKE isaj_t.isajent, 
   isajcomp LIKE isaj_t.isajcomp, 
   isajsite LIKE isaj_t.isajsite, 
   isaj001 LIKE isaj_t.isaj001, 
   isaj003 LIKE isaj_t.isaj003, 
   isaj005 LIKE isaj_t.isaj005, 
   isaj006 LIKE isaj_t.isaj006, 
   isaj007 LIKE isaj_t.isaj007, 
   l_ooefl003 LIKE type_t.chr500, 
   l_isaa028 LIKE isaa_t.isaa028, 
   l_isaa005 LIKE isaa_t.isaa005, 
   l_isaa028_isaa005 LIKE type_t.chr500, 
   l_date LIKE isaj_t.isajdocdt, 
   l_isaj019_isaj020 LIKE type_t.chr500, 
   l_ooef002 LIKE type_t.chr500, 
   isaj018 LIKE isaj_t.isaj018, 
   isaj019 LIKE isaj_t.isaj019, 
   isaj020 LIKE isaj_t.isaj020, 
   t1_ooefl004 LIKE ooefl_t.ooefl004, 
   ooefl_t_ooefl004 LIKE ooefl_t.ooefl004, 
   pmaal_t_pmaal003 LIKE pmaal_t.pmaal003, 
   l_isaj103 LIKE isaj_t.isaj103, 
   l_isaj104 LIKE isaj_t.isaj104, 
   l_isaj103_1 LIKE isaj_t.isaj103, 
   l_isaj103_2 LIKE isaj_t.isaj103, 
   l_isaj103_3 LIKE isaj_t.isaj103
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING,                  #where condition 
       a1 LIKE type_t.chr500,         #申報單位 
       a2 LIKE type_t.num5,         #資料所屬年份 
       a3 LIKE type_t.num5,         #資料所屬月份 
       a4 LIKE type_t.chr1          #彙總報繳
       END RECORD
DEFINE sr DYNAMIC ARRAY OF sr1_r                   #宣告sr為sr1_t資料結構的動態陣列
DEFINE g_select        STRING
DEFINE g_from          STRING
DEFINE g_where         STRING
DEFINE g_order         STRING
DEFINE g_sql           STRING                         #report_select_prep,REPORT段使用
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_wc_isaj003 STRING
DEFINE l_isaj103    LIKE type_t.num20_6        #合計(應稅銷售額)
DEFINE l_isaj104    LIKE type_t.num20_6        #合計(稅額)
DEFINE l_isaj103_1  LIKE type_t.num20_6        #合計(經海關)
DEFINE l_isaj103_2  LIKE type_t.num20_6        #合計(非經海關)
DEFINE l_isaj103_3  LIKE type_t.num20_6        #合計(免稅金額)

TYPE sr3_r         RECORD                        #子報表01                    
   isaj018         LIKE isaj_t.isaj018,          #進項          
   isaj103         LIKE isaj_t.isaj103,          #可扣抵進項金額
   isaj104         LIKE isaj_t.isaj104,          #稅額
   isaj103_1       LIKE isaj_t.isaj103,          #零稅率金額
   isaj103_2       LIKE isaj_t.isaj103,          #免稅金額
   isaj103_sum     LIKE type_t.num20_6,          #合計(可扣抵進項金額)
   isaj104_sum     LIKE type_t.num20_6,          #合計(稅額)
   isaj103_1_sum   LIKE type_t.num20_6,          #合計(零稅率金額)
   isaj103_2_sum   LIKE type_t.num20_6           #合計(免稅金額)                   
                   END RECORD
TYPE sr4_r         RECORD                        #子報表02              
   isaj014         LIKE isaj_t.isaj014,          #進項扣抵代號
   isaj103         LIKE isaj_t.isaj103,          #不可扣抵進項金額
   isaj104         LIKE isaj_t.isaj104,          #稅額
   isaj103_1       LIKE isaj_t.isaj103,          #零稅率金額
   isaj103_2       LIKE isaj_t.isaj103,          #免稅金額
   isaj103_sum     LIKE type_t.num20_6,          #合計(不可扣抵進項金額)
   isaj104_sum     LIKE type_t.num20_6,          #合計(稅額)
   isaj103_1_sum   LIKE type_t.num20_6,          #合計(零稅率金額)
   isaj103_2_sum   LIKE type_t.num20_6           #合計(免稅金額) 
                   END RECORD

#end add-point
 
{</section>}
 
{<section id="aisr410_g01.main" readonly="Y" >}
PUBLIC FUNCTION aisr410_g01(p_arg1,p_arg2,p_arg3,p_arg4,p_arg5)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr500         #tm.a1  申報單位 
DEFINE  p_arg3 LIKE type_t.num5         #tm.a2  資料所屬年份 
DEFINE  p_arg4 LIKE type_t.num5         #tm.a3  資料所屬月份 
DEFINE  p_arg5 LIKE type_t.chr1         #tm.a4  彙總報繳
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.a1 = p_arg2
   LET tm.a2 = p_arg3
   LET tm.a3 = p_arg4
   LET tm.a4 = p_arg5
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "aisr410_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL aisr410_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL aisr410_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL aisr410_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="aisr410_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aisr410_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   CALL aisr410_g01_get_isaj003() RETURNING g_wc_isaj003
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   LET g_select = "SELECT NULL,NULL,NULL,NULL,t1.isaj003,NULL,NULL,NULL,NULL,NULL,NULL,NULL,",
                  "NULL,NULL,NULL,t1.isaj018,NULL,NULL,NULL,NULL,NULL,",
                  "SUM(CASE WHEN t2.a IS NULL THEN  0 ELSE t2.a END),",
                  "SUM(CASE WHEN t2.b IS NULL THEN  0 ELSE t2.b END),",
                  "SUM(CASE WHEN t3.isaj103 IS NULL THEN  0 ELSE t3.isaj103 END),",
                  "SUM(CASE WHEN t4.isaj103 IS NULL THEN  0 ELSE t4.isaj103 END),",
                  "SUM(CASE WHEN t5.isaj103 IS NULL THEN  0 ELSE t5.isaj103 END) "
#   #end add-point
#   LET g_select = " SELECT isajent,isajcomp,isajsite,isaj001,isaj003,isaj005,isaj006,isaj007,NULL,NULL, 
#       NULL,NULL,NULL,NULL,NULL,isaj018,isaj019,isaj020,( SELECT ooefl004 FROM ooefl_t t1 WHERE t1.ooeflent = isaj_t.isajent AND t1.ooefl001 = isaj_t.isaj003 AND t1.ooefl002 = '" , 
#       g_dlang,"'" ,"),( SELECT ooefl004 FROM ooefl_t WHERE ooefl_t.ooeflent = isaj_t.isajent AND ooefl_t.ooefl001 = isaj_t.isajsite AND ooefl_t.ooefl002 = '" , 
#       g_dlang,"'" ,"),( SELECT pmaal003 FROM pmaal_t WHERE pmaal_t.pmaalent = isaj_t.isajent AND pmaal_t.pmaal001 = isaj_t.isaj021 AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,"),'','','','',''"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_from = " FROM isaj_t t1", 
   " LEFT OUTER JOIN ooefl_t ON ooefl_t.ooeflent = t1.isajent AND ooefl_t.ooefl001 = t1.isajsite AND ooefl_t.ooefl002 = '" , g_dlang,"'" ,
   " LEFT OUTER JOIN pmaal_t ON pmaal_t.pmaalent = t1.isajent AND pmaal_t.pmaal001 = t1.isaj021 AND pmaal_t.pmaal002 = '" , g_dlang,"'" ,
   " LEFT OUTER JOIN ( SELECT isajent,isajcomp,isajsite,isaj001,isaj005,isaj006,isaj007,isaj003,isaj019,isaj020,",
                             #"CASE WHEN isaj012 IS NOT NULL AND isaj018<> '32' AND isaj018 <> '34' THEN isaj105 / (1+isaj016/100) ELSE isaj103 END AS a ,",  #150915-00013#5 mark
                             #"CASE WHEN isaj012 IS NOT NULL AND isaj018<> '32' AND isaj018 <> '34' THEN isaj103 * isaj016/100 ELSE isaj104 END AS b ",       #150915-00013#5 mark
                              "CASE WHEN isaj012 IS NOT NULL AND isaj018<> '32' AND isaj018 <> '34' THEN isaj105 ELSE isaj105 END AS a ,",  #150915-00013#5
                              "CASE WHEN isaj012 IS NOT NULL AND isaj018<> '32' AND isaj018 <> '34' THEN isaj104 ELSE isaj104 END AS b ",   #150915-00013#5
                      "FROM isaj_t   WHERE isaj015 ='1' AND isajstus = 'Y' )  ",
                      "t2 ON t1.isajent = t2.isajent AND t1.isajcomp = t2.isajcomp AND t1.isajsite = t2.isajsite AND t1.isaj001 = t2.isaj001 AND t1.isaj003 = t2.isaj003 ",
                      "AND t1.isaj005 = t2.isaj005 AND t1.isaj006 = t2.isaj006 AND t1.isaj007 = t2.isaj007 AND t1.isaj019 = t2.isaj019 AND t1.isaj020 = t2.isaj020 ",
   " LEFT OUTER JOIN ( SELECT isajent,isajcomp,isajsite,isaj001,isaj005,isaj006,isaj007 ,isaj003,isaj019,isaj020,",
                      "CASE WHEN isaj103 IS NULL THEN  0 ELSE isaj103 END AS isaj103 " ,
                      "FROM isaj_t WHERE isaj015 ='2' AND isajstus = 'Y'   AND (isaj027 IS NOT NULL OR isaj028 IS NOT NULL) ) ", 
                      "t3 ON t1.isajent = t3.isajent AND t1.isajcomp = t3.isajcomp AND t1.isajsite = t3.isajsite AND t1.isaj001 = t3.isaj001 AND t1.isaj003 = t3.isaj003 ",
                      "AND t1.isaj005 = t3.isaj005 AND t1.isaj006 = t3.isaj006 AND t1.isaj007 = t3.isaj007  AND t1.isaj019 = t3.isaj019 AND t1.isaj020 = t3.isaj020 ",
   " LEFT OUTER JOIN ( SELECT isajent,isajcomp,isajsite,isaj001,isaj005,isaj006,isaj007 ,isaj003,isaj019,isaj020,",
                      "CASE WHEN isaj103 IS NULL THEN  0 ELSE isaj103 END AS isaj103 ",
                      "FROM isaj_t WHERE isaj015 ='2' AND isajstus = 'Y'   AND (isaj025 IS NOT NULL OR isaj026 IS NOT NULL))  ",
                      "t4 ON t1.isajent = t4.isajent AND t1.isajcomp = t4.isajcomp AND t1.isajsite = t4.isajsite AND t1.isaj001 = t4.isaj001 AND t1.isaj003 = t4.isaj003 ",
                      "AND t1.isaj005 = t4.isaj005 AND t1.isaj006 = t4.isaj006 AND t1.isaj007 = t4.isaj007  AND t1.isaj019 = t4.isaj019 AND t1.isaj020 = t4.isaj020 ",
   " LEFT OUTER JOIN ( SELECT isajent,isajcomp,isajsite,isaj001,isaj005,isaj006,isaj007 ,isaj003,isaj019,isaj020,",
                      "CASE WHEN isaj103 IS NULL THEN  0 ELSE isaj103 END AS isaj103 ",
                      "FROM isaj_t WHERE isaj015 ='3' AND isajstus = 'Y' )  ",
                      "t5 ON t1.isajent = t5.isajent AND t1.isajcomp = t5.isajcomp AND t1.isajsite = t5.isajsite AND t1.isaj001 = t5.isaj001 AND t1.isaj003 = t5.isaj003 ",
                      "AND t1.isaj005 = t5.isaj005 AND t1.isaj006 = t5.isaj006 AND t1.isaj007 = t5.isaj007  AND t1.isaj019 = t5.isaj019 AND t1.isaj020 = t5.isaj020 " 
#   #end add-point
#    LET g_from = " FROM isaj_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET g_where = " WHERE " ,tm.wc CLIPPED," AND t1.isaj019 = ' ",tm.a2,"' AND t1.isaj020 = ' ",tm.a3,"'   AND t1.isaj018 LIKE '3%'",
                 " AND t1.isajstus = 'Y' AND t1.isaj003 IN ",g_wc_isaj003,""
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED 
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
    LET g_order = " GROUP BY t1.isaj003,t1.isaj018 " ," ORDER BY t1.isaj018"
#   #end add-point
#    LET g_order = " ORDER BY isaj003,isaj018"
# 
#   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("isaj_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE aisr410_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE aisr410_g01_curs CURSOR FOR aisr410_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="aisr410_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION aisr410_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   isajent LIKE isaj_t.isajent, 
   isajcomp LIKE isaj_t.isajcomp, 
   isajsite LIKE isaj_t.isajsite, 
   isaj001 LIKE isaj_t.isaj001, 
   isaj003 LIKE isaj_t.isaj003, 
   isaj005 LIKE isaj_t.isaj005, 
   isaj006 LIKE isaj_t.isaj006, 
   isaj007 LIKE isaj_t.isaj007, 
   l_ooefl003 LIKE type_t.chr500, 
   l_isaa028 LIKE isaa_t.isaa028, 
   l_isaa005 LIKE isaa_t.isaa005, 
   l_isaa028_isaa005 LIKE type_t.chr500, 
   l_date LIKE isaj_t.isajdocdt, 
   l_isaj019_isaj020 LIKE type_t.chr500, 
   l_ooef002 LIKE type_t.chr500, 
   isaj018 LIKE isaj_t.isaj018, 
   isaj019 LIKE isaj_t.isaj019, 
   isaj020 LIKE isaj_t.isaj020, 
   t1_ooefl004 LIKE ooefl_t.ooefl004, 
   ooefl_t_ooefl004 LIKE ooefl_t.ooefl004, 
   pmaal_t_pmaal003 LIKE pmaal_t.pmaal003, 
   l_isaj103 LIKE isaj_t.isaj103, 
   l_isaj104 LIKE isaj_t.isaj104, 
   l_isaj103_1 LIKE isaj_t.isaj103, 
   l_isaj103_2 LIKE isaj_t.isaj103, 
   l_isaj103_3 LIKE isaj_t.isaj103
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_year       LIKE type_t.chr500
DEFINE l_month      LIKE type_t.chr500
DEFINE l_money      LIKE isaj_t.isaj103 #150915-00013#5
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    LET l_isaj103   = 0
    LET l_isaj104   = 0
    LET l_isaj103_1 = 0
    LET l_isaj103_2 = 0
    LET l_isaj103_3 = 0
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH aisr410_g01_curs INTO sr_s.*
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
       IF cl_null(sr_s.l_isaj103) THEN LET sr_s.l_isaj103 = 0 END IF #150915-00013#5
       IF cl_null(sr_s.l_isaj104) THEN LET sr_s.l_isaj104 = 0 END IF #150915-00013#5
       CALL s_num_round(1,sr_s.l_isaj103,0)   RETURNING sr_s.l_isaj103    #四捨五入至整數
       CALL s_num_round(1,sr_s.l_isaj104,0)   RETURNING sr_s.l_isaj104    #四捨五入至整數
       CALL s_num_round(1,sr_s.l_isaj103_1,0) RETURNING sr_s.l_isaj103_1  #四捨五入至整數
       CALL s_num_round(1,sr_s.l_isaj103_2,0) RETURNING sr_s.l_isaj103_2  #四捨五入至整數
       CALL s_num_round(1,sr_s.l_isaj103_3,0) RETURNING sr_s.l_isaj103_3  #四捨五入至整數
       #150915-00013#5 add ------
       LET l_money = sr_s.l_isaj103
       IF l_money <> 0 THEN
          LET sr_s.l_isaj103 = l_money / 1.05
          CALL s_num_round(1,sr_s.l_isaj103,0) RETURNING sr_s.l_isaj103
          LET sr_s.l_isaj104 = l_money - sr_s.l_isaj103
       ELSE
          LET sr_s.l_isaj104 = 0
       END IF
       #150915-00013#5 add end---
       IF sr_s.isaj018 MATCHES '3[348]' THEN
          --- 銷項 ---
          LET l_isaj103 = l_isaj103 - sr_s.l_isaj103
          LET l_isaj104 = l_isaj104 - sr_s.l_isaj104      
          #零稅率經海關  
          LET l_isaj103_1 = l_isaj103_1 - sr_s.l_isaj103_1       
          #零稅率非經海關  
          LET l_isaj103_2 = l_isaj103_2 - sr_s.l_isaj103_2
          #免稅金額 
          LET l_isaj103_3 = l_isaj103_3 - sr_s.l_isaj103_3
       ELSE
          --- 銷項 ---
          LET l_isaj103 = l_isaj103 + sr_s.l_isaj103
          LET l_isaj104 = l_isaj104 + sr_s.l_isaj104      
          #零稅率經海關  
          LET l_isaj103_1 = l_isaj103_1 + sr_s.l_isaj103_1       
          #零稅率非經海關  
          LET l_isaj103_2 = l_isaj103_2 + sr_s.l_isaj103_2
          #免稅金額 
          LET l_isaj103_3 = l_isaj103_3 + sr_s.l_isaj103_3
       END IF
       #給單頭資料
       CALL s_desc_get_department_desc(tm.a1)   RETURNING sr_s.l_ooefl003
       SELECT ooef002 INTO sr_s.l_ooef002
       FROM ooef_t
       #WHERE ooef001 = tm.a1                           #160905-00002#4 mark
       WHERE ooefent = g_enterprise AND ooef001 = tm.a1 #160905-00002#4 add
       LET l_year  = tm.a2-1911
       LET l_month = tm.a3
       IF tm.a3 < 10 THEN
          LET sr_s.l_isaj019_isaj020 = l_year CLIPPED,"0",l_month CLIPPED
       ELSE
          LET sr_s.l_isaj019_isaj020 = l_year CLIPPED,l_month CLIPPED
       END IF
       SELECT isaa028,isaa005 INTO sr_s.l_isaa028,sr_s.l_isaa005
       FROM isaa_t
       #WHERE isaa001 = tm.a1                           #160905-00002#4 mark
       WHERE isaaent = g_enterprise AND isaa001 = tm.a1 #160905-00002#4 add 
       IF cl_null(sr_s.l_isaa028) THEN
          LET sr_s.l_isaa028_isaa005 = sr_s.l_isaa005
       ELSE
          LET sr_s.l_isaa028_isaa005 = sr_s.l_isaa028,"-", sr_s.l_isaa005     
       END IF
       LET sr_s.l_date = g_today
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].isajent = sr_s.isajent
       LET sr[l_cnt].isajcomp = sr_s.isajcomp
       LET sr[l_cnt].isajsite = sr_s.isajsite
       LET sr[l_cnt].isaj001 = sr_s.isaj001
       LET sr[l_cnt].isaj003 = sr_s.isaj003
       LET sr[l_cnt].isaj005 = sr_s.isaj005
       LET sr[l_cnt].isaj006 = sr_s.isaj006
       LET sr[l_cnt].isaj007 = sr_s.isaj007
       LET sr[l_cnt].l_ooefl003 = sr_s.l_ooefl003
       LET sr[l_cnt].l_isaa028 = sr_s.l_isaa028
       LET sr[l_cnt].l_isaa005 = sr_s.l_isaa005
       LET sr[l_cnt].l_isaa028_isaa005 = sr_s.l_isaa028_isaa005
       LET sr[l_cnt].l_date = sr_s.l_date
       LET sr[l_cnt].l_isaj019_isaj020 = sr_s.l_isaj019_isaj020
       LET sr[l_cnt].l_ooef002 = sr_s.l_ooef002
       LET sr[l_cnt].isaj018 = sr_s.isaj018
       LET sr[l_cnt].isaj019 = sr_s.isaj019
       LET sr[l_cnt].isaj020 = sr_s.isaj020
       LET sr[l_cnt].t1_ooefl004 = sr_s.t1_ooefl004
       LET sr[l_cnt].ooefl_t_ooefl004 = sr_s.ooefl_t_ooefl004
       LET sr[l_cnt].pmaal_t_pmaal003 = sr_s.pmaal_t_pmaal003
       LET sr[l_cnt].l_isaj103 = sr_s.l_isaj103
       LET sr[l_cnt].l_isaj104 = sr_s.l_isaj104
       LET sr[l_cnt].l_isaj103_1 = sr_s.l_isaj103_1
       LET sr[l_cnt].l_isaj103_2 = sr_s.l_isaj103_2
       LET sr[l_cnt].l_isaj103_3 = sr_s.l_isaj103_3
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
        
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aisr410_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION aisr410_g01_rep_data()
   DEFINE HANDLER         om.SaxDocumentHandler
   DEFINE l_i             INTEGER
 
    #判斷是否有報表資料，若回彈出訊息視窗
    IF sr.getLength() = 0 THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = "adz-00285"
       LET g_errparam.extend = NULL
       LET g_errparam.popup  = FALSE
       LET g_errparam.replace[1] = ''
       CALL cl_err()  
       RETURN 
    END IF
    WHILE TRUE   
       #add-point:rep_data段印前 name="rep_data.before"
       
       #end add-point     
       LET handler = cl_gr_handler()
       IF handler IS NOT NULL THEN
          START REPORT aisr410_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT aisr410_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT aisr410_g01_rep
       END IF
       #add-point:rep_data段印完 name="rep_data.after"
       
       #end add-point       
       IF g_rep_flag = TRUE THEN
          LET g_rep_flag = FALSE
          EXIT WHILE
       END IF
    END WHILE
    #add-point:rep_data段離開while印完前 name="rep_data.end.before"
    
    #end add-point
    CALL cl_gr_close_report()
    #add-point:rep_data段離開while印完後 name="rep_data.end.after"
    
    #end add-point    
END FUNCTION
 
{</section>}
 
{<section id="aisr410_g01.rep" readonly="Y" >}
PRIVATE REPORT aisr410_g01_rep(sr1)
DEFINE sr1 sr1_r
DEFINE sr2 sr2_r
DEFINE l_subrep01_show  LIKE type_t.chr1,
       l_subrep02_show  LIKE type_t.chr1,
       l_subrep03_show  LIKE type_t.chr1,
       l_subrep04_show  LIKE type_t.chr1
DEFINE l_cnt           LIKE type_t.num10
DEFINE l_sub_sql       STRING
#add-point:rep段define  (客製用) name="rep.define_customerization"

#end add-point
#add-point:rep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="rep.define"
DEFINE sr3       sr3_r
DEFINE sr4       sr4_r
DEFINE l_subrep05_show    LIKE type_t.chr1
DEFINE l_subrep06_show    LIKE type_t.chr1
DEFINE l_isaj015_count_u  LIKE type_t.num20_6  #銷項使用發票數
DEFINE l_isaj015_count_d  LIKE type_t.num20_6  #銷項空白發票數
DEFINE l_isaj015_count_f  LIKE type_t.num20_6  #銷項做廢發票數
DEFINE l_money            LIKE isaj_t.isaj103  #150915-00013#5
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER  BY sr1.isaj003,sr1.isaj018
    #add-point:rep段ORDER_after name="rep.order.after"
    
    #end add-point
    
    FORMAT
       FIRST PAGE HEADER          
          PRINTX g_user,g_pdate,g_rep_code,g_company,g_ptime,g_user_name,g_date_fmt
          PRINTX tm.*
          PRINTX g_grNumFmt.*
          PRINTX g_rep_wcchp
 
          #讀取beforeGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.isaj003
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.isaj003
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'isajent=' ,sr1.isajent,'{+}isajcomp=' ,sr1.isajcomp,'{+}isajsite=' ,sr1.isajsite,'{+}isaj001=' ,sr1.isaj001,'{+}isaj003=' ,sr1.isaj003,'{+}isaj005=' ,sr1.isaj005,'{+}isaj006=' ,sr1.isaj006,'{+}isaj007=' ,sr1.isaj007,'{+}isaj019=' ,sr1.isaj019,'{+}isaj020=' ,sr1.isaj020         
            CALL cl_gr_init_apr(sr1.isaj003)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.isaj003.before name="rep.b_group.isaj003.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.isajent CLIPPED ,"'", " AND  ooff003 = '", sr1.isaj003 CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aisr410_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE aisr410_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT aisr410_g01_subrep01
           DECLARE aisr410_g01_repcur01 CURSOR FROM g_sql
           FOREACH aisr410_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aisr410_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT aisr410_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT aisr410_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.isaj003.after name="rep.b_group.isaj003.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.isaj018
 
           #add-point:rep.b_group.isaj018.before name="rep.b_group.isaj018.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.isaj018.after name="rep.b_group.isaj018.after"
           
           #end add-point:
 
 
 
 
       ON EVERY ROW
          #add-point:rep.everyrow.before name="rep.everyrow.before"
          
          #end add-point:rep.everyrow.before
 
          #單身前備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub02.before name="rep.sub02.before"
           
           #end add-point:rep.sub02.before
 
           #add-point:rep.sub02.sql name="rep.sub02.sql"
           
           #end add-point:rep.sub02.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='2' AND ooffent = '", 
                sr1.isajent CLIPPED ,"'", " AND  ooff003 = '", sr1.isaj003 CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.isaj018 CLIPPED ,""
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aisr410_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE aisr410_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT aisr410_g01_subrep02
           DECLARE aisr410_g01_repcur02 CURSOR FROM g_sql
           FOREACH aisr410_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aisr410_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT aisr410_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT aisr410_g01_subrep02
           #add-point:rep.sub02.after name="rep.sub02.after"
           
           #end add-point:rep.sub02.after
 
 
 
          #add-point:rep.everyrow.beforerow name="rep.everyrow.beforerow"
          IF sr1.isaj018 MATCHES '3[348]' THEN
             LET sr1.isaj018 = "(-",sr1.isaj018,")"
          ELSE
             LET sr1.isaj018 = "( ",sr1.isaj018,")"          
          END IF
          #end add-point:rep.everyrow.beforerow
            
          PRINTX sr1.*
 
          #add-point:rep.everyrow.afterrow name="rep.everyrow.afterrow"
          
          #end add-point:rep.everyrow.afterrow
 
          #單身後備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub03.before name="rep.sub03.before"
           
           #end add-point:rep.sub03.before
 
           #add-point:rep.sub03.sql name="rep.sub03.sql"
           
           #end add-point:rep.sub03.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooffent = '", 
                sr1.isajent CLIPPED ,"'", " AND  ooff003 = '", sr1.isaj003 CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.isaj018 CLIPPED ,""
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aisr410_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE aisr410_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT aisr410_g01_subrep03
           DECLARE aisr410_g01_repcur03 CURSOR FROM g_sql
           FOREACH aisr410_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aisr410_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT aisr410_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT aisr410_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.isaj003
 
           #add-point:rep.a_group.isaj003.before name="rep.a_group.isaj003.before"
           PRINTX l_isaj103,l_isaj104,l_isaj103_1,l_isaj103_2,l_isaj103_3
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.isajent CLIPPED ,"'", " AND  ooff003 = '", sr1.isaj003 CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aisr410_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE aisr410_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT aisr410_g01_subrep04
           DECLARE aisr410_g01_repcur04 CURSOR FROM g_sql
           FOREACH aisr410_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aisr410_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT aisr410_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT aisr410_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.isaj003.after name="rep.a_group.isaj003.after"
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep05_show = 'N'
           LET g_sql = "SELECT t1.isaj018,",
                         #"SUM(CASE WHEN t2.isaj103 IS NULL THEN  0 ELSE t2.isaj103 END),", #150915-00013#5 mark
                          "SUM(CASE WHEN t2.isaj105 IS NULL THEN  0 ELSE t2.isaj105 END),", #150915-00013#5
                          "SUM(CASE WHEN t2.isaj104 IS NULL THEN  0 ELSE t2.isaj104 END),",
                          "SUM(CASE WHEN t3.isaj103 IS NULL THEN  0 ELSE t3.isaj103 END),",
                          "SUM(CASE WHEN t4.isaj103 IS NULL THEN  0 ELSE t4.isaj103 END)",
                      " FROM isaj_t t1", 
                      " LEFT OUTER JOIN ( SELECT isajent,isajcomp,isajsite,isaj001,isaj005,isaj006,isaj007,isaj003,isaj019,isaj020,",
                                              #" CASE WHEN isaj103 IS NULL THEN  0 ELSE isaj103 END AS isaj103 ,", #150915-00013#5 mark
                                               " CASE WHEN isaj105 IS NULL THEN  0 ELSE isaj105 END AS isaj105 ,", #150915-00013#5
                                               " CASE WHEN isaj104 IS NULL THEN  0 ELSE isaj104 END AS isaj104 ",                                               
                                           "FROM isaj_t   WHERE isaj015 ='1' )  ",
                         "t2 ON t1.isajent = t2.isajent AND t1.isajcomp = t2.isajcomp AND t1.isajsite = t2.isajsite AND t1.isaj001 = t2.isaj001  AND t1.isaj003 = t2.isaj003 ",
                         "AND t1.isaj005 = t2.isaj005 AND t1.isaj006 = t2.isaj006 AND t1.isaj007 = t2.isaj007 AND t1.isaj019 = t2.isaj019 AND t1.isaj020 = t2.isaj020 ",
                      " LEFT OUTER JOIN ( SELECT isajent,isajcomp,isajsite,isaj001,isaj005,isaj006,isaj007,isaj003,isaj019,isaj020,",
                                               " CASE WHEN isaj103 IS NULL THEN  0 ELSE isaj103 END AS isaj103 ", 
                                           "FROM isaj_t   WHERE isaj015 ='2' )  ",
                         "t3 ON t1.isajent = t3.isajent AND t1.isajcomp = t3.isajcomp AND t1.isajsite = t3.isajsite AND t1.isaj001 = t3.isaj001  AND t1.isaj003 = t3.isaj003 ",
                         "AND t1.isaj005 = t3.isaj005 AND t1.isaj006 = t3.isaj006 AND t1.isaj007 = t3.isaj007 AND t1.isaj019 = t3.isaj019 AND t1.isaj020 = t3.isaj020 ",
                      " LEFT OUTER JOIN ( SELECT isajent,isajcomp,isajsite,isaj001,isaj005,isaj006,isaj007,isaj003,isaj019,isaj020,",
                                               " CASE WHEN isaj103 IS NULL THEN  0 ELSE isaj103 END AS isaj103 ", 
                                           "FROM isaj_t   WHERE isaj015 ='3')  ",
                         "t4 ON t1.isajent = t4.isajent AND t1.isajcomp = t4.isajcomp AND t1.isajsite = t4.isajsite AND t1.isaj001 = t4.isaj001  AND t1.isaj003 = t4.isaj003 ",
                         "AND t1.isaj005 = t4.isaj005 AND t1.isaj006 = t4.isaj006 AND t1.isaj007 = t4.isaj007 AND t1.isaj019 = t4.isaj019 AND t1.isaj020 = t4.isaj020 ",
                         " WHERE " ,tm.wc CLIPPED," AND t1.isaj019 = ' ",tm.a2,"' AND t1.isaj020 = ' ",tm.a3,"'   AND t1.isaj018 LIKE '2%'",
                              " AND (t1.isaj014 = '1' OR t1.isaj014 = '2' ) AND t1.isajstus = 'Y'  AND t1.isaj003 IN ",g_wc_isaj003,
                              " GROUP BY t1.isaj018 " ," ORDER BY t1.isaj018"
           LET l_sub_sql = "SELECT COUNT(*) FROM (",g_sql,")"
           PREPARE aisr410_g01_repcur05_cnt_pre FROM l_sub_sql
           EXECUTE aisr410_g01_repcur05_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep05_show ="Y"
           END IF
           PRINTX l_subrep05_show
           START REPORT aisr410_g01_subrep05 
           DECLARE aisr410_g01_repcur05 CURSOR FROM g_sql
           LET sr3.isaj103_sum   = 0
           LET sr3.isaj104_sum   = 0
           LET sr3.isaj103_1_sum = 0
           LET sr3.isaj103_2_sum = 0
           FOREACH aisr410_g01_repcur05 INTO sr3.*             
               CALL s_num_round(1,sr3.isaj103,0)   RETURNING sr3.isaj103   #四捨五入至整數
               CALL s_num_round(1,sr3.isaj104,0)   RETURNING sr3.isaj104   #四捨五入至整數
               CALL s_num_round(1,sr3.isaj103_1,0) RETURNING sr3.isaj103_1 #四捨五入至整數
               CALL s_num_round(1,sr3.isaj103_2,0) RETURNING sr3.isaj103_2 #四捨五入至整數
               IF NOT cl_null(sr3.isaj018) THEN               
                  #150915-00013#5 add ------
                  LET l_money = sr3.isaj103
                  IF l_money <> 0 THEN
                     LET sr3.isaj103 = l_money / 1.05
                     CALL s_num_round(1,sr3.isaj103,0) RETURNING sr3.isaj103
                     LET sr3.isaj104 = l_money - sr3.isaj103
                  ELSE
                     LET sr3.isaj104 = 0
                  END IF
                  #150915-00013#5 add end---
                  IF sr3.isaj018 MATCHES '2[349]'  THEN
                     LET sr3.isaj103_sum   = sr3.isaj103_sum   - sr3.isaj103    #可扣抵進項金額
                     LET sr3.isaj104_sum   = sr3.isaj104_sum   - sr3.isaj104    #稅額             
                     LET sr3.isaj103_1_sum = sr3.isaj103_1_sum - sr3.isaj103_1  #零稅率金額     
                     LET sr3.isaj103_2_sum = sr3.isaj103_2_sum - sr3.isaj103_2  #免稅金額
                  ELSE                      
                     LET sr3.isaj103_sum   = sr3.isaj103_sum   + sr3.isaj103    #可扣抵進項金額
                     LET sr3.isaj104_sum   = sr3.isaj104_sum   + sr3.isaj104    #稅額             
                     LET sr3.isaj103_1_sum = sr3.isaj103_1_sum + sr3.isaj103_1  #零稅率金額     
                     LET sr3.isaj103_2_sum = sr3.isaj103_2_sum + sr3.isaj103_2  #免稅金額
                  END IF
               END IF
               OUTPUT TO REPORT aisr410_g01_subrep05(sr3.*)
           END FOREACH
           FINISH REPORT aisr410_g01_subrep05
           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep06_show = 'N'
           LET g_sql = "SELECT t1.isaj014,",
                         #"SUM(CASE WHEN t2.isaj103 IS NULL THEN  0 ELSE t2.isaj103 END),", #150915-00013#5 mark
                          "SUM(CASE WHEN t2.isaj105 IS NULL THEN  0 ELSE t2.isaj105 END),", #150915-00013#5
                          "SUM(CASE WHEN t2.isaj104 IS NULL THEN  0 ELSE t2.isaj104 END),",
                          "SUM(CASE WHEN t3.isaj103 IS NULL THEN  0 ELSE t3.isaj103 END),",
                          "SUM(CASE WHEN t4.isaj103 IS NULL THEN  0 ELSE t4.isaj103 END)",
                      " FROM isaj_t t1", 
                      " LEFT OUTER JOIN ( SELECT isajent,isajcomp,isajsite,isaj001,isaj005,isaj006,isaj007,isaj003,isaj019,isaj020,",
                                              #" CASE WHEN isaj103 IS NULL THEN  0 ELSE isaj103 END AS isaj103 ,",  #150915-00013#5 mark
                                               " CASE WHEN isaj105 IS NULL THEN  0 ELSE isaj105 END AS isaj105 ,",  #150915-00013#5
                                               " CASE WHEN isaj104 IS NULL THEN  0 ELSE isaj104 END AS isaj104 ",
                                           "FROM isaj_t   WHERE isaj015 ='1')  ",
                         "t2 ON t1.isajent = t2.isajent AND t1.isajcomp = t2.isajcomp AND t1.isajsite = t2.isajsite AND t1.isaj001 = t2.isaj001 AND t1.isaj003 = t2.isaj003 ",
                         "AND t1.isaj005 = t2.isaj005 AND t1.isaj006 = t2.isaj006 AND t1.isaj007 = t2.isaj007 AND t1.isaj019 = t2.isaj019 AND t1.isaj020 = t2.isaj020 ",
                      " LEFT OUTER JOIN ( SELECT isajent,isajcomp,isajsite,isaj001,isaj005,isaj006,isaj007,isaj003,isaj019,isaj020,",
                                               " CASE WHEN isaj103 IS NULL THEN  0 ELSE isaj103 END AS isaj103 ", 
                                           "FROM isaj_t   WHERE isaj015 ='2')  ",
                         "t3 ON t1.isajent = t3.isajent AND t1.isajcomp = t3.isajcomp AND t1.isajsite = t3.isajsite AND t1.isaj001 = t3.isaj001 AND t1.isaj003 = t3.isaj003 ",
                         "AND t1.isaj005 = t3.isaj005 AND t1.isaj006 = t3.isaj006 AND t1.isaj007 = t3.isaj007 AND t1.isaj019 = t3.isaj019 AND t1.isaj020 = t3.isaj020 ",
                      " LEFT OUTER JOIN ( SELECT isajent,isajcomp,isajsite,isaj001,isaj005,isaj006,isaj007,isaj003,isaj019,isaj020,",
                                               " CASE WHEN isaj103 IS NULL THEN  0 ELSE isaj103 END AS isaj103 ", 
                                           "FROM isaj_t   WHERE isaj015 ='3')  ",
                         "t4 ON t1.isajent = t4.isajent AND t1.isajcomp = t4.isajcomp AND t1.isajsite = t4.isajsite AND t1.isaj001 = t4.isaj001 AND t1.isaj003 = t4.isaj003 ",
                         "AND t1.isaj005 = t4.isaj005 AND t1.isaj006 = t4.isaj006 AND t1.isaj007 = t4.isaj007 AND t1.isaj019 = t4.isaj019 AND t1.isaj020 = t4.isaj020 ",
                      " WHERE " ,tm.wc CLIPPED," AND t1.isaj019 = ' ",tm.a2,"' AND t1.isaj020 = ' ",tm.a3,"'   AND t1.isaj018 LIKE '2%'",
                              " AND t1.isajstus = 'Y'  AND ( t1.isaj014 = '3' OR t1.isaj014 = '4' ) AND t1.isaj003 IN ",g_wc_isaj003,
                              " GROUP BY t1.isaj014 " ," ORDER BY t1.isaj014"
           LET l_sub_sql = "SELECT COUNT(*) FROM (",g_sql,")"
           PREPARE aisr410_g01_repcur06_cnt_pre FROM l_sub_sql
           EXECUTE aisr410_g01_repcur06_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep06_show ="Y"
           END IF
           PRINTX l_subrep06_show
           START REPORT aisr410_g01_subrep06 
           DECLARE aisr410_g01_repcur06 CURSOR FROM g_sql
           LET sr4.isaj103_sum   = 0
           LET sr4.isaj104_sum   = 0
           LET sr4.isaj103_1_sum = 0
           LET sr4.isaj103_2_sum = 0
           FOREACH aisr410_g01_repcur06 INTO sr4.*             
               CALL s_num_round(1,sr4.isaj103,0)   RETURNING sr4.isaj103   #四捨五入至整數
               CALL s_num_round(1,sr4.isaj104,0)   RETURNING sr4.isaj104   #四捨五入至整數
               CALL s_num_round(1,sr4.isaj103_1,0) RETURNING sr4.isaj103_1 #四捨五入至整數
               CALL s_num_round(1,sr4.isaj103_2,0) RETURNING sr4.isaj103_2 #四捨五入至整數
               #150915-00013#5 add ------
               LET l_money = sr4.isaj103
               IF l_money <> 0 THEN
                  LET sr4.isaj103 = l_money / 1.05
                  CALL s_num_round(1,sr4.isaj103,0) RETURNING sr4.isaj103
                  LET sr4.isaj104 = l_money - sr4.isaj103
               ELSE
                  LET sr4.isaj104 = 0
               END IF
               #150915-00013#5 add end---
               LET sr4.isaj103_sum   = sr4.isaj103_sum   + sr4.isaj103
               LET sr4.isaj104_sum   = sr4.isaj104_sum   + sr4.isaj104
               LET sr4.isaj103_1_sum = sr4.isaj103_1_sum + sr4.isaj103_1
               LET sr4.isaj103_2_sum = sr4.isaj103_2_sum + sr4.isaj103_2
               OUTPUT TO REPORT aisr410_g01_subrep06(sr4.*)
               
           END FOREACH
           FINISH REPORT aisr410_g01_subrep06
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.isaj018
 
           #add-point:rep.a_group.isaj018.before name="rep.a_group.isaj018.before"
           SELECT COUNT(*) INTO l_isaj015_count_u FROM isaj_t
            #WHERE isaj019 = tm.a2 AND isaj020 = tm.a3  AND isaj018  LIKE '3%'                            #160905-00002#4 mark
            WHERE isajent = g_enterprise AND isaj019 = tm.a2 AND isaj020 = tm.a3  AND isaj018  LIKE '3%'  #160905-00002#4 add
              AND isaj003 = tm.a1 AND isajstus ='Y' 
              AND isaj015 <> 'F'   #非作廢
              AND isaj015 <> 'D'   #非空白
              AND isaj018 NOT IN (33,34,38) 

            SELECT COUNT(*) INTO l_isaj015_count_d FROM isaj_t
            #WHERE isaj019 = tm.a2 AND isaj020 = tm.a3  AND isaj018  LIKE '3%'                            #160905-00002#4 mark
            WHERE isajent = g_enterprise AND isaj019 = tm.a2 AND isaj020 = tm.a3  AND isaj018  LIKE '3%'  #160905-00002#4 add
              AND isaj003 = tm.a1 AND isajstus ='Y' 
              AND isaj015 = 'D'      #空白      
         
            SELECT COUNT(*) INTO l_isaj015_count_f FROM isaj_t
            #WHERE isaj019 = tm.a2 AND isaj020 = tm.a3  AND isaj018  LIKE '3%'                           #160905-00002#4 mark
            WHERE isajent = g_enterprise AND isaj019 = tm.a2 AND isaj020 = tm.a3  AND isaj018  LIKE '3%' #160905-00002#4 add
              AND isaj003 = tm.a1 AND isajstus ='Y' 
              AND isaj015 = 'F'      #作廢
           PRINTX l_isaj015_count_u,l_isaj015_count_d,l_isaj015_count_f       
           #end add-point:
 
 
           #add-point:rep.a_group.isaj018.after name="rep.a_group.isaj018.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
 
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="aisr410_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT aisr410_g01_subrep01(sr2)
DEFINE  sr2  sr2_r
#add-point:query段define(客製用) name="sub01.define_customerization" 

#end add-point
#add-point:sub01.define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sub01.define" 

#end add-point:sub01.define
 
    #add-point:sub01.order.before name="sub01.order.before" 
    
    #end add-point:sub01.order.before
 
 
 
    FORMAT
 
 
 
       ON EVERY ROW
            #add-point:sub01.everyrow.before name="sub01.everyrow.before" 
                          
            #end add-point:sub01.everyrow.before
 
            PRINTX sr2.*
 
            #add-point:sub01.everyrow.after name="sub01.everyrow.after" 
            
            #end add-point:sub01.everyrow.after
 
 
END REPORT
 
 
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT aisr410_g01_subrep02(sr2)
DEFINE  sr2  sr2_r
#add-point:query段define(客製用) name="sub02.define_customerization" 

#end add-point
#add-point:sub02.define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sub02.define" 

#end add-point:sub02.define
 
    #add-point:sub02.order.before name="sub02.order.before" 
    
    #end add-point:sub02.order.before
 
 
 
    FORMAT
 
 
 
       ON EVERY ROW
            #add-point:sub02.everyrow.before name="sub02.everyrow.before" 
                          
            #end add-point:sub02.everyrow.before
 
            PRINTX sr2.*
 
            #add-point:sub02.everyrow.after name="sub02.everyrow.after" 
            
            #end add-point:sub02.everyrow.after
 
 
END REPORT
 
 
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT aisr410_g01_subrep03(sr2)
DEFINE  sr2  sr2_r
#add-point:query段define(客製用) name="sub03.define_customerization" 

#end add-point
#add-point:sub03.define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sub03.define" 

#end add-point:sub03.define
 
    #add-point:sub03.order.before name="sub03.order.before" 
    
    #end add-point:sub03.order.before
 
 
 
    FORMAT
 
 
 
       ON EVERY ROW
            #add-point:sub03.everyrow.before name="sub03.everyrow.before" 
                          
            #end add-point:sub03.everyrow.before
 
            PRINTX sr2.*
 
            #add-point:sub03.everyrow.after name="sub03.everyrow.after" 
            
            #end add-point:sub03.everyrow.after
 
 
END REPORT
 
 
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT aisr410_g01_subrep04(sr2)
DEFINE  sr2  sr2_r
#add-point:query段define(客製用) name="sub04.define_customerization" 

#end add-point
#add-point:sub04.define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sub04.define" 

#end add-point:sub04.define
 
    #add-point:sub04.order.before name="sub04.order.before" 
    
    #end add-point:sub04.order.before
 
 
 
    FORMAT
 
 
 
       ON EVERY ROW
            #add-point:sub04.everyrow.before name="sub04.everyrow.before" 
                          
            #end add-point:sub04.everyrow.before
 
            PRINTX sr2.*
 
            #add-point:sub04.everyrow.after name="sub04.everyrow.after" 
            
            #end add-point:sub04.everyrow.after
 
 
END REPORT
 
 
 
 
{</section>}
 
{<section id="aisr410_g01.other_function" readonly="Y" >}
################################################################################
# Descriptions...: 跟據彙總報繳與否 取得isaj003條件
# Memo...........:
# Usage..........: CALL aisr410_g01_get_isaj003()
# Date & Author..: 150602 By Rayhuang
# Modify.........:
################################################################################
PRIVATE FUNCTION aisr410_g01_get_isaj003()
   DEFINE l_str     STRING
   DEFINE r_wc      STRING
   DEFINE l_sql     STRING
   DEFINE l_sons    LIKE isaa_t.isaa001
   
   #根據彙總條件
   #LET l_sql = "SELECT isaa001 FROM isaa_t WHERE isaa001 = '",tm.a1,"'"                                #160905-00002#4 mark
   LET l_sql = "SELECT isaa001 FROM isaa_t WHERE isaaent = ",g_enterprise," AND isaa001 = '",tm.a1,"'"  #160905-00002#4 add
   IF  tm.a4 THEN
      LET l_sql = l_sql,"OR isaa009 = '",tm.a1,"'"       
   END IF
   PREPARE aisr410_g01_get_isaj003_pre FROM l_sql
   DECLARE aisr410_g01_get_isaj003_cur CURSOR FOR aisr410_g01_get_isaj003_pre
   #取出isaa001放入l_str
   LET l_str = NULL
   FOREACH aisr410_g01_get_isaj003_cur INTO l_sons
      IF SQLCA.SQLCODE THEN EXIT FOREACH END IF
      IF cl_null(l_str)THEN
         LET l_str = l_sons CLIPPED
      ELSE
         LET l_str = l_str CLIPPED,"','",l_sons CLIPPED,""
      END IF         
   END FOREACH
   LET r_wc = "('",l_str,"')"
   
   RETURN r_wc
   
END FUNCTION

 
{</section>}
 
{<section id="aisr410_g01.other_report" readonly="Y" >}

PRIVATE REPORT aisr410_g01_subrep05(sr3)
DEFINE sr3 sr3_r


   ORDER EXTERNAL BY sr3.isaj018 
       FORMAT
          
   
       ON EVERY ROW
          IF sr3.isaj018 MATCHES '2[349]'  THEN
             LET sr3.isaj018 = "(-",sr3.isaj018,")"
          ELSE
             LET sr3.isaj018 = "( ",sr3.isaj018,")"
          END IF
          
          PRINTX sr3.*
          PRINTX g_grNumFmt.*
    
END REPORT

PRIVATE REPORT aisr410_g01_subrep06(sr4)
DEFINE sr4 sr4_r

   ORDER EXTERNAL BY sr4.isaj014
   FORMAT
           
      ON EVERY ROW
         PRINTX sr4.*
         PRINTX g_grNumFmt.*
         
END REPORT

 
{</section>}
 
