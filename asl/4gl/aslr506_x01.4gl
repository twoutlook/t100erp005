#該程式未解開Section, 採用最新樣板產出!
{<section id="aslr506_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2016-11-22 14:15:53), PR版次:0001(2016-11-24 18:16:58)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: aslr506_x01
#+ Description: ...
#+ Creator....: 08172(2016-11-09 16:09:16)
#+ Modifier...: 08172 -SD/PR- 08172
 
{</section>}
 
{<section id="aslr506_x01.global" readonly="Y" >}
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
       wc STRING,                  #condiction 
       year1 LIKE type_t.num5,         #year_1 
       mon LIKE type_t.num5          #month1
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_ooef016 LIKE ooef_t.ooef016
#end add-point
 
{</section>}
 
{<section id="aslr506_x01.main" readonly="Y" >}
PUBLIC FUNCTION aslr506_x01(p_arg1,p_arg2,p_arg3)
DEFINE  p_arg1 STRING                  #tm.wc  condiction 
DEFINE  p_arg2 LIKE type_t.num5         #tm.year1  year_1 
DEFINE  p_arg3 LIKE type_t.num5         #tm.mon  month1
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.year1 = p_arg2
   LET tm.mon = p_arg3
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "aslr506_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL aslr506_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL aslr506_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL aslr506_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL aslr506_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL aslr506_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="aslr506_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION aslr506_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "l_date_type.type_t.chr100,l_sum_type.type_t.chr100,l_year_sys.type_t.chr100,l_season_sys.type_t.chr100,l_data_sys.type_t.num20_6" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   CREATE TEMP TABLE aslr506_tmp(
      l_data_typ   LIKE type_t.chr100,
      l_count_typ  LIKE type_t.chr100,
      l_year       LIKE type_t.chr100,
      l_season     LIKE type_t.chr100,
      l_data       LIKE type_t.num20_6)
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="aslr506_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION aslr506_x01_ins_prep()
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
         LET g_sql = " INSERT INTO ",g_rep_db CLIPPED,g_rep_tmpname[1] CLIPPED," VALUES(?,?,?,?,?)"
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
 
{<section id="aslr506_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aslr506_x01_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define(客製用) name="sel_prep.define_customerization"

#end add-point
#add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
DEFINE l_i       LIKE type_t.num10
DEFINE l_a       LIKE type_t.num10
DEFINE l_b       LIKE type_t.num10
DEFINE l_c       LIKE type_t.num10
DEFINE l_sql     STRING
DEFINE l_str1    LIKE type_t.chr100
DEFINE l_str2    LIKE type_t.chr100
DEFINE l_month   LIKE type_t.chr100
DEFINE l_imaa154 LIKE type_t.chr100
DEFINE l_imaa155 LIKE type_t.chr100
DEFINE l_sum     LIKE type_t.num20_6
DEFINE l_type    LIKE type_t.chr100
DEFINE l_days    LIKE type_t.num10
DEFINE l_date    LIKE type_t.chr100
DEFINE l_date1   LIKE type_t.chr100
DEFINE l_date2   LIKE type_t.chr100
DEFINE l_date3   LIKE type_t.chr100
DEFINE l_date4   LIKE type_t.chr100
DEFINE l_date_1  LIKE type_t.chr100
DEFINE l_date_2  LIKE type_t.chr100
DEFINE l_year1   LIKE type_t.chr100
DEFINE l_month1  LIKE type_t.chr100
DEFINE l_debn014 LIKE type_t.num20_6
DEFINE l_merge_sum    STRING
DEFINE l_merge_count  STRING
DEFINE l_merge_change STRING
DEFINE l_merge_rant   STRING
DEFINE l_merge_all    STRING
#end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
 
   #add-point:sel_prep g_select name="sel_prep.g_select"
   
   #end add-point
   LET g_select = " SELECT 0,0,'','',0"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   
   #end add-point
    LET g_from = " FROM imaa_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("imaa_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
#   LET g_sql = " SELECT '','',imaa154,imaa155,rtib012,MONTH(rtiadocdt)",
#               "   FROM rtib_t",
#               "        LEFT JOIN rtia_t ON rtiaent = rtibent AND rtiadocno = rtibdocno AND rtiastus = 'Y'",
#               "        LEFT JOIN imaa_t ON imaaent = rtiaent AND imaa001 = rtib004 AND imaastus = 'Y'",
#               "  WHERE rtibent = ",g_enterprise,
#               "    AND imaa154 IN (",tm.year1,",",(tm.year1-1),")",
#               "    AND imaa155 IN ('1','2')",
#               "    AND ",tm.wc
   LET l_str1 = "1." CLIPPED,tm.year1 CLIPPED
   LET l_str2 = "2." CLIPPED,(tm.year1-1) CLIPPED
   FOR l_i = 1 TO 4
      CASE l_i
         WHEN 1
            FOR l_a = 1 TO 48 
               CASE l_a
                  WHEN 1
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','1.一月','1.春夏季',0)
                  WHEN 2
                    INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','2.二月','1.春夏季',0)
                  WHEN 3
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','3.三月','1.春夏季',0)
                  WHEN 4
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','4.四月','1.春夏季',0)
                  WHEN 5
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','5.五月','1.春夏季',0)
                  WHEN 6
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','6.六月','1.春夏季',0)
                  WHEN 7
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','7.七月','1.春夏季',0)
                  WHEN 8
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','8.八月','1.春夏季',0)
                  WHEN 9
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','9.九月','1.春夏季',0)
                  WHEN 10
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','a.十月','1.春夏季',0)
                  WHEN 11
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','b.十一月','1.春夏季',0)
                  WHEN 12
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','c.十二月','1.春夏季',0)
                  WHEN 13
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','1.一月','2.秋冬季',0)
                  WHEN 14                                                  
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','2.二月','2.秋冬季',0) 
                  WHEN 15                                                  
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','3.三月','2.秋冬季',0)
                  WHEN 16                                                  
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','4.四月','2.秋冬季',0) 
                  WHEN 17                                                  
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','5.五月','2.秋冬季',0)
                  WHEN 18                                                  
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','6.六月','2.秋冬季',0) 
                  WHEN 19                                                  
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','7.七月','2.秋冬季',0)
                  WHEN 20                                                   
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','8.八月','2.秋冬季',0) 
                  WHEN 21                                                   
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','9.九月','2.秋冬季',0)
                  WHEN 22                                                   
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','a.十月','2.秋冬季',0) 
                  WHEN 23                                                   
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','b.十一月','2.秋冬季',0)
                  WHEN 24                                                   
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','c.十二月','2.秋冬季',0)
                  WHEN 25                                                  
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','d.销售累计','1.春夏季',0)
                  WHEN 26                                                  
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season) VALUES ('1.总数','e.期初存货','1.春夏季') 
                  WHEN 27                                                  
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season) VALUES ('1.总数','f.售罄率','1.春夏季')
                  WHEN 28                                                   
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','g.期末存量','1.春夏季',0) 
                  WHEN 29                                                   
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','d.销售累计','2.秋冬季',0)
                  WHEN 30                                                   
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season) VALUES ('1.总数','e.期初存货','2.秋冬季') 
                  WHEN 31                                                   
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season) VALUES ('1.总数','f.售罄率','2.秋冬季')
                  WHEN 32                                                   
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','g.期末存量','2.秋冬季',0)
                  WHEN 33
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','1.一月','合计',0)
                  WHEN 34
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','2.二月','合计',0)
                  WHEN 35
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','3.三月','合计',0)
                  WHEN 36
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','4.四月','合计',0)
                  WHEN 37
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','5.五月','合计',0)
                  WHEN 38
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','6.六月','合计',0)
                  WHEN 39
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','7.七月','合计',0)
                  WHEN 40
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','8.八月','合计',0)
                  WHEN 41
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','9.九月','合计',0)
                  WHEN 42
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','a.十月','合计',0)
                  WHEN 43
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','b.十一月','合计',0)
                  WHEN 44
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','c.十二月','合计',0)
                  WHEN 45
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','d.销售累计','合计',0)
                  WHEN 46                                                                            
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season) VALUES ('1.总数','e.期初存货','合计')  
                  WHEN 47                                                                           
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season) VALUES ('1.总数','f.售罄率','合计')
                  WHEN 48                                                                             
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','g.期末存量','合计',0)  
               END CASE
            END FOR
            FOR l_b = 1 TO 48
               CASE l_b
                  WHEN 1
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','1.一月','1.春夏季',0)
                  WHEN 2
                    INSERT  INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','2.二月','1.春夏季',0)
                  WHEN 3
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','3.三月','1.春夏季',0)
                  WHEN 4
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','4.四月','1.春夏季',0)
                  WHEN 5
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','5.五月','1.春夏季',0)
                  WHEN 6
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','6.六月','1.春夏季',0)
                  WHEN 7
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','7.七月','1.春夏季',0)
                  WHEN 8
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','8.八月','1.春夏季',0)
                  WHEN 9
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','9.九月','1.春夏季',0)
                  WHEN 10
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','a.十月','1.春夏季',0)
                  WHEN 11
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','b.十一月','1.春夏季',0)
                  WHEN 12
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','c.十二月','1.春夏季',0)
                  WHEN 13
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','1.一月','2.秋冬季',0)
                  WHEN 14                                             
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','2.二月','2.秋冬季',0) 
                  WHEN 15                                             
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','3.三月','2.秋冬季',0)
                  WHEN 16                                             
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','4.四月','2.秋冬季',0) 
                  WHEN 17                                             
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','5.五月','2.秋冬季',0)
                  WHEN 18                                             
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','6.六月','2.秋冬季',0) 
                  WHEN 19                                             
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','7.七月','2.秋冬季',0)
                  WHEN 20                                              
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','8.八月','2.秋冬季',0) 
                  WHEN 21                                              
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','9.九月','2.秋冬季',0)
                  WHEN 22                                              
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','a.十月','2.秋冬季',0) 
                  WHEN 23                                              
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','b.十一月','2.秋冬季',0)
                  WHEN 24                                              
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','c.十二月','2.秋冬季',0)
                  WHEN 25                                             
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','d.销售累计','1.春夏季',0)
                  WHEN 26                                             
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season) VALUES ('2.当季','e.期初存货','1.春夏季') 
                  WHEN 27                                             
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season) VALUES ('2.当季','f.售罄率','1.春夏季')
                  WHEN 28                                              
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','g.期末存量','1.春夏季',0) 
                  WHEN 29                                              
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','d.销售累计','2.秋冬季',0)
                  WHEN 30                                              
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season) VALUES ('2.当季','e.期初存货','2.秋冬季') 
                  WHEN 31                                              
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season) VALUES ('2.当季','f.售罄率','2.秋冬季')
                  WHEN 32                                              
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','g.期末存量','2.秋冬季',0)
                  WHEN 33
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','1.一月','合计',0)
                  WHEN 34                                                         
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','2.二月','合计',0)
                  WHEN 35                                                         
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','3.三月','合计',0)
                  WHEN 36                                                           
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','4.四月','合计',0)
                  WHEN 37                                                         
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','5.五月','合计',0)
                  WHEN 38                                                     
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','6.六月','合计',0)
                  WHEN 39                                                        
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','7.七月','合计',0)
                  WHEN 40                                                         
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','8.八月','合计',0)
                  WHEN 41                                                         
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','9.九月','合计',0)
                  WHEN 42                                                        
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','a.十月','合计',0)
                  WHEN 43                                                           
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','b.十一月','合计',0)
                  WHEN 44                                                        
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','c.十二月','合计',0)
                  WHEN 45                                                      
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','d.销售累计','合计',0)
                  WHEN 46                                                     
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season) VALUES ('2.当季','e.期初存货','合计')  
                  WHEN 47                                                      
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season) VALUES ('2.当季','f.售罄率','合计')
                  WHEN 48                                                             
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','g.期末存量','合计',0)  
               END CASE
            END FOR
            FOR l_c = 1 TO 48
               CASE l_c
                  WHEN 1
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','1.一月','1.春夏季',0)
                  WHEN 2
                    INSERT  INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','2.二月','1.春夏季',0)
                  WHEN 3
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','3.三月','1.春夏季',0)
                  WHEN 4
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','4.四月','1.春夏季',0)
                  WHEN 5
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','5.五月','1.春夏季',0)
                  WHEN 6
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','6.六月','1.春夏季',0)
                  WHEN 7
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','7.七月','1.春夏季',0)
                  WHEN 8
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','8.八月','1.春夏季',0)
                  WHEN 9
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','9.九月','1.春夏季',0)
                  WHEN 10
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','a.十月','1.春夏季',0)
                  WHEN 11
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','b.十一月','1.春夏季',0)
                  WHEN 12
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','c.十二月','1.春夏季',0)
                  WHEN 13
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','1.一月','2.秋冬季',0)
                  WHEN 14                                             
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','2.二月','2.秋冬季',0) 
                  WHEN 15                                             
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','3.三月','2.秋冬季',0)
                  WHEN 16                                             
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','4.四月','2.秋冬季',0) 
                  WHEN 17                                             
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','5.五月','2.秋冬季',0)
                  WHEN 18                                             
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','6.六月','2.秋冬季',0) 
                  WHEN 19                                             
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','7.七月','2.秋冬季',0)
                  WHEN 20                                              
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','8.八月','2.秋冬季',0) 
                  WHEN 21                                              
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','9.九月','2.秋冬季',0)
                  WHEN 22                                              
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','a.十月','2.秋冬季',0) 
                  WHEN 23                                              
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','b.十一月','2.秋冬季',0)
                  WHEN 24                                              
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','c.十二月','2.秋冬季',0)
                  WHEN 25                                             
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','d.销售累计','1.春夏季',0)
                  WHEN 26                                             
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season) VALUES ('3.过季','e.期初存货','1.春夏季') 
                  WHEN 27                                             
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season) VALUES ('3.过季','f.售罄率','1.春夏季')
                  WHEN 28                                              
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','g.期末存量','1.春夏季',0) 
                  WHEN 29                                              
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','d.销售累计','2.秋冬季',0)
                  WHEN 30                                              
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season) VALUES ('3.过季','e.期初存货','2.秋冬季') 
                  WHEN 31                                              
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season) VALUES ('3.过季','f.售罄率','2.秋冬季')
                  WHEN 32                                              
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','g.期末存量','2.秋冬季',0)
                  WHEN 33
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','1.一月','合计',0)
                  WHEN 34                                                           
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','2.二月','合计',0)
                  WHEN 35                                                         
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','3.三月','合计',0)
                  WHEN 36                                                           
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','4.四月','合计',0)
                  WHEN 37                                                          
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','5.五月','合计',0)
                  WHEN 38                                                      
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','6.六月','合计',0)
                  WHEN 39                                                             
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','7.七月','合计',0)
                  WHEN 40                                                            
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','8.八月','合计',0)
                  WHEN 41                                                            
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','9.九月','合计',0)
                  WHEN 42                                                           
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','a.十月','合计',0)
                  WHEN 43                                                          
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','b.十一月','合计',0)
                  WHEN 44                                                      
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','c.十二月','合计',0)
                  WHEN 45                                                          
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','d.销售累计','合计',0)
                  WHEN 46                                                            
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season) VALUES ('3.过季','e.期初存货','合计')  
                  WHEN 47                                                           
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season) VALUES ('3.过季','f.售罄率','合计')
                  WHEN 48                                                             
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','g.期末存量','合计',0)  
               END CASE
            END FOR
            UPDATE aslr506_tmp SET l_year = l_str1
         WHEN 2
            FOR l_a = 1 TO 48
               CASE l_a
                  WHEN 1
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','1.一月','1.春夏季',0)
                  WHEN 2
                    INSERT  INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','2.二月','1.春夏季',0)
                  WHEN 3
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','3.三月','1.春夏季',0)
                  WHEN 4
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','4.四月','1.春夏季',0)
                  WHEN 5
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','5.五月','1.春夏季',0)
                  WHEN 6
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','6.六月','1.春夏季',0)
                  WHEN 7
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','7.七月','1.春夏季',0)
                  WHEN 8
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','8.八月','1.春夏季',0)
                  WHEN 9
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','9.九月','1.春夏季',0)
                  WHEN 10
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','a.十月','1.春夏季',0)
                  WHEN 11
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','b.十一月','1.春夏季',0)
                  WHEN 12
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','c.十二月','1.春夏季',0)
                  WHEN 13
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','1.一月','2.秋冬季',0)
                  WHEN 14                                             
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','2.二月','2.秋冬季',0) 
                  WHEN 15                                             
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','3.三月','2.秋冬季',0)
                  WHEN 16                                             
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','4.四月','2.秋冬季',0) 
                  WHEN 17                                             
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','5.五月','2.秋冬季',0)
                  WHEN 18                                             
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','6.六月','2.秋冬季',0) 
                  WHEN 19                                             
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','7.七月','2.秋冬季',0)
                  WHEN 20                                              
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','8.八月','2.秋冬季',0) 
                  WHEN 21                                              
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','9.九月','2.秋冬季',0)
                  WHEN 22                                              
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','a.十月','2.秋冬季',0) 
                  WHEN 23                                              
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','b.十一月','2.秋冬季',0)
                  WHEN 24                                              
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','c.十二月','2.秋冬季',0)
                  WHEN 25                                             
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','d.销售累计','1.春夏季',0)
                  WHEN 26                                             
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season) VALUES ('1.总数','e.期初存货','1.春夏季') 
                  WHEN 27                                             
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season) VALUES ('1.总数','f.售罄率','1.春夏季')
                  WHEN 28                                              
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','g.期末存量','1.春夏季',0) 
                  WHEN 29                                              
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','d.销售累计','2.秋冬季',0)
                  WHEN 30                                              
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season) VALUES ('1.总数','e.期初存货','2.秋冬季') 
                  WHEN 31                                              
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season) VALUES ('1.总数','f.售罄率','2.秋冬季')
                  WHEN 32                                              
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','g.期末存量','2.秋冬季',0)
                  WHEN 33
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','1.一月','合计',0)
                  WHEN 34
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','2.二月','合计',0)
                  WHEN 35
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','3.三月','合计',0)
                  WHEN 36
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','4.四月','合计',0)
                  WHEN 37
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','5.五月','合计',0)
                  WHEN 38
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','6.六月','合计',0)
                  WHEN 39
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','7.七月','合计',0)
                  WHEN 40
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','8.八月','合计',0)
                  WHEN 41
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','9.九月','合计',0)
                  WHEN 42
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','a.十月','合计',0)
                  WHEN 43
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','b.十一月','合计',0)
                  WHEN 44
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','c.十二月','合计',0)
                  WHEN 45
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','d.销售累计','合计',0)
                  WHEN 46                                                                       
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season) VALUES ('1.总数','e.期初存货','合计')  
                  WHEN 47                                                                      
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season) VALUES ('1.总数','f.售罄率','合计')
                  WHEN 48                                                                        
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('1.总数','g.期末存量','合计',0)  
               END CASE
            END FOR
            FOR l_b = 1 TO 48
               CASE l_b
                  WHEN 1
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','1.一月','1.春夏季',0)
                  WHEN 2
                    INSERT  INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','2.二月','1.春夏季',0)
                  WHEN 3
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','3.三月','1.春夏季',0)
                  WHEN 4
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','4.四月','1.春夏季',0)
                  WHEN 5
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','5.五月','1.春夏季',0)
                  WHEN 6
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','6.六月','1.春夏季',0)
                  WHEN 7
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','7.七月','1.春夏季',0)
                  WHEN 8
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','8.八月','1.春夏季',0)
                  WHEN 9
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','9.九月','1.春夏季',0)
                  WHEN 10
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','a.十月','1.春夏季',0)
                  WHEN 11
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','b.十一月','1.春夏季',0)
                  WHEN 12
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','c.十二月','1.春夏季',0)
                  WHEN 13
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','1.一月','2.秋冬季',0)
                  WHEN 14                                             
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','2.二月','2.秋冬季',0) 
                  WHEN 15                                             
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','3.三月','2.秋冬季',0)
                  WHEN 16                                             
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','4.四月','2.秋冬季',0) 
                  WHEN 17                                             
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','5.五月','2.秋冬季',0)
                  WHEN 18                                             
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','6.六月','2.秋冬季',0) 
                  WHEN 19                                             
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','7.七月','2.秋冬季',0)
                  WHEN 20                                              
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','8.八月','2.秋冬季',0) 
                  WHEN 21                                              
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','9.九月','2.秋冬季',0)
                  WHEN 22                                              
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','a.十月','2.秋冬季',0) 
                  WHEN 23                                              
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','b.十一月','2.秋冬季',0)
                  WHEN 24                                              
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','c.十二月','2.秋冬季',0)
                  WHEN 25                                             
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','d.销售累计','1.春夏季',0)
                  WHEN 26                                             
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season) VALUES ('2.当季','e.期初存货','1.春夏季') 
                  WHEN 27                                             
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season) VALUES ('2.当季','f.售罄率','1.春夏季')
                  WHEN 28                                              
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','g.期末存量','1.春夏季',0) 
                  WHEN 29                                              
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','d.销售累计','2.秋冬季',0)
                  WHEN 30                                              
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season) VALUES ('2.当季','e.期初存货','2.秋冬季') 
                  WHEN 31                                              
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season) VALUES ('2.当季','f.售罄率','2.秋冬季')
                  WHEN 32                                              
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','g.期末存量','2.秋冬季',0)
                  WHEN 33
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','1.一月','合计',0)
                  WHEN 34                                                      
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','2.二月','合计',0)
                  WHEN 35                                                    
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','3.三月','合计',0)
                  WHEN 36                                                       
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','4.四月','合计',0)
                  WHEN 37                                                           
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','5.五月','合计',0)
                  WHEN 38                                                      
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','6.六月','合计',0)
                  WHEN 39                                                          
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','7.七月','合计',0)
                  WHEN 40                                                        
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','8.八月','合计',0)
                  WHEN 41                                                          
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','9.九月','合计',0)
                  WHEN 42                                                       
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','a.十月','合计',0)
                  WHEN 43                                                        
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','b.十一月','合计',0)
                  WHEN 44                                                           
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','c.十二月','合计',0)
                  WHEN 45                                                           
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','d.销售累计','合计',0)
                  WHEN 46                                                           
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season) VALUES ('2.当季','e.期初存货','合计')  
                  WHEN 47                                                          
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season) VALUES ('2.当季','f.售罄率','合计')
                  WHEN 48                                                             
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('2.当季','g.期末存量','合计',0)  
               END CASE
            END FOR
            FOR l_c = 1 TO 48
               CASE l_c
                  WHEN 1
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','1.一月','1.春夏季',0)
                  WHEN 2
                    INSERT  INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','2.二月','1.春夏季',0)
                  WHEN 3
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','3.三月','1.春夏季',0)
                  WHEN 4
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','4.四月','1.春夏季',0)
                  WHEN 5
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','5.五月','1.春夏季',0)
                  WHEN 6
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','6.六月','1.春夏季',0)
                  WHEN 7
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','7.七月','1.春夏季',0)
                  WHEN 8
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','8.八月','1.春夏季',0)
                  WHEN 9
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','9.九月','1.春夏季',0)
                  WHEN 10
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','a.十月','1.春夏季',0)
                  WHEN 11
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','b.十一月','1.春夏季',0)
                  WHEN 12
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','c.十二月','1.春夏季',0)
                  WHEN 13
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','1.一月','2.秋冬季',0)
                  WHEN 14                                             
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','2.二月','2.秋冬季',0) 
                  WHEN 15                                             
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','3.三月','2.秋冬季',0)
                  WHEN 16                                             
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','4.四月','2.秋冬季',0) 
                  WHEN 17                                             
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','5.五月','2.秋冬季',0)
                  WHEN 18                                             
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','6.六月','2.秋冬季',0) 
                  WHEN 19                                             
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','7.七月','2.秋冬季',0)
                  WHEN 20                                              
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','8.八月','2.秋冬季',0) 
                  WHEN 21                                              
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','9.九月','2.秋冬季',0)
                  WHEN 22                                              
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','a.十月','2.秋冬季',0) 
                  WHEN 23                                              
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','b.十一月','2.秋冬季',0)
                  WHEN 24                                              
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','c.十二月','2.秋冬季',0)
                  WHEN 25                                             
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','d.销售累计','1.春夏季',0)
                  WHEN 26                                             
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season) VALUES ('3.过季','e.期初存货','1.春夏季') 
                  WHEN 27                                             
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season) VALUES ('3.过季','f.售罄率','1.春夏季')
                  WHEN 28                                              
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','g.期末存量','1.春夏季',0) 
                  WHEN 29                                              
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','d.销售累计','2.秋冬季',0)
                  WHEN 30                                              
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season) VALUES ('3.过季','e.期初存货','2.秋冬季') 
                  WHEN 31                                              
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season) VALUES ('3.过季','f.售罄率','2.秋冬季')
                  WHEN 32                                              
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','g.期末存量','2.秋冬季',0)
                  WHEN 33
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','1.一月','合计',0)
                  WHEN 34                                                             
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','2.二月','合计',0)
                  WHEN 35                                                            
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','3.三月','合计',0)
                  WHEN 36                                                            
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','4.四月','合计',0)
                  WHEN 37                                                             
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','5.五月','合计',0)
                  WHEN 38                                                           
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','6.六月','合计',0)
                  WHEN 39                                                             
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','7.七月','合计',0)
                  WHEN 40                                                             
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','8.八月','合计',0)
                  WHEN 41                                                             
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','9.九月','合计',0)
                  WHEN 42                                                              
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','a.十月','合计',0)
                  WHEN 43                                                            
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','b.十一月','合计',0)
                  WHEN 44                                                          
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','c.十二月','合计',0)
                  WHEN 45                                                          
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','d.销售累计','合计',0)
                  WHEN 46                                                          
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season) VALUES ('3.过季','e.期初存货','合计')  
                  WHEN 47                                                           
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season) VALUES ('3.过季','f.售罄率','合计')
                  WHEN 48                                                            
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_season,l_data) VALUES ('3.过季','g.期末存量','合计',0)  
               END CASE
            END FOR
            UPDATE aslr506_tmp SET l_year = l_str2 WHERE l_year IS NULL
         WHEN 3 
            FOR l_a = 1 TO 16
               CASE l_a
                  WHEN 1
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('1.总数','1.一月','3.成长率%',0)
                  WHEN 2
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('1.总数','2.二月','3.成长率%',0)
                  WHEN 3                                                                                
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('1.总数','3.三月','3.成长率%',0)
                  WHEN 4                                                                                
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('1.总数','4.四月','3.成长率%',0)
                  WHEN 5
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('1.总数','5.五月','3.成长率%',0)
                  WHEN 6                                                                            
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('1.总数','6.六月','3.成长率%',0)
                  WHEN 7                                                                                
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('1.总数','7.七月','3.成长率%',0)
                  WHEN 8                                                                            
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('1.总数','8.八月','3.成长率%',0)
                  WHEN 9                                                                               
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('1.总数','9.九月','3.成长率%',0)
                  WHEN 10                                                                   
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('1.总数','a.十月','3.成长率%',0)
                  WHEN 11                                         
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('1.总数','b.十一月','3.成长率%',0)
                  WHEN 12                                                                           
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('1.总数','c.十二月','3.成长率%',0)
                  WHEN 13                                                                
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('1.总数','d.销售累计','3.成长率%',0)
                  WHEN 14                                                                             
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year) VALUES ('1.总数','e.期初存货','3.成长率%')  
                  WHEN 15                                                               
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year) VALUES ('1.总数','f.售罄率','3.成长率%')
                  WHEN 16                                                               
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('1.总数','g.期末存量','3.成长率%',0)                         
               END CASE
            END FOR
            FOR l_b = 1 TO 16
               CASE l_b
                  WHEN 1
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('2.当季','1.一月','3.成长率%',0)
                  WHEN 2                                                                    
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('2.当季','2.二月','3.成长率%',0)
                  WHEN 3                                                                     
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('2.当季','3.三月','3.成长率%',0)
                  WHEN 4                                                                          
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('2.当季','4.四月','3.成长率%',0)
                  WHEN 5                                                                     
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('2.当季','5.五月','3.成长率%',0)
                  WHEN 6                                                                      
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('2.当季','6.六月','3.成长率%',0)
                  WHEN 7                                                                         
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('2.当季','7.七月','3.成长率%',0)
                  WHEN 8                                                                        
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('2.当季','8.八月','3.成长率%',0)
                  WHEN 9                                                                         
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('2.当季','9.九月','3.成长率%',0)
                  WHEN 10                                                                
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('2.当季','a.十月','3.成长率%',0)
                  WHEN 11                                                    
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('2.当季','b.十一月','3.成长率%',0)
                  WHEN 12                                                     
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('2.当季','c.十二月','3.成长率%',0)
                  WHEN 13                                                           
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('2.当季','d.销售累计','3.成长率%',0)
                  WHEN 14                                                      
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year) VALUES ('2.当季','e.期初存货','3.成长率%')  
                  WHEN 15                                                          
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year) VALUES ('2.当季','f.售罄率','3.成长率%')
                  WHEN 16                                                         
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('2.当季','g.期末存量','3.成长率%',0)                         
               END CASE
            END FOR
            FOR l_b = 1 TO 16
               CASE l_b
                  WHEN 1 
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('3.过季','1.一月','3.成长率%',0)
                  WHEN 2                                                      
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('3.过季','2.二月','3.成长率%',0)
                  WHEN 3                                                         
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('3.过季','3.三月','3.成长率%',0)
                  WHEN 4                                                             
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('3.过季','4.四月','3.成长率%',0)
                  WHEN 5                                                        
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('3.过季','5.五月','3.成长率%',0)
                  WHEN 6                                                           
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('3.过季','6.六月','3.成长率%',0)
                  WHEN 7                                                         
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('3.过季','7.七月','3.成长率%',0)
                  WHEN 8                                                         
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('3.过季','8.八月','3.成长率%',0)
                  WHEN 9                                                            
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('3.过季','9.九月','3.成长率%',0)
                  WHEN 10                                                        
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('3.过季','a.十月','3.成长率%',0)
                  WHEN 11                                                        
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('3.过季','b.十一月','3.成长率%',0)
                  WHEN 12                                                        
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('3.过季','c.十二月','3.成长率%',0)
                  WHEN 13                                                           
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('3.过季','d.销售累计','3.成长率%',0)
                  WHEN 14                                                      
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year) VALUES ('3.过季','e.期初存货','3.成长率%')  
                  WHEN 15                                                          
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year) VALUES ('3.过季','f.售罄率','3.成长率%')
                  WHEN 16                                                         
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('3.过季','g.期末存量','3.成长率%',0)                         
               END CASE
            END FOR
         WHEN 4
            FOR l_a = 1 TO 16
               CASE l_a
                  WHEN 1
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('1.总数','1.一月','4.差异数量',0)
                  WHEN 2                                                                     
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('1.总数','2.二月','4.差异数量',0)
                  WHEN 3                                                                        
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('1.总数','3.三月','4.差异数量',0)
                  WHEN 4                                                                        
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('1.总数','4.四月','4.差异数量',0)
                  WHEN 5                                                                          
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('1.总数','5.五月','4.差异数量',0)
                  WHEN 6                                                                             
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('1.总数','6.六月','4.差异数量',0)
                  WHEN 7                                                                           
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('1.总数','7.七月','4.差异数量',0)
                  WHEN 8                                                                              
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('1.总数','8.八月','4.差异数量',0)
                  WHEN 9                                                                      
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('1.总数','9.九月','4.差异数量',0)
                  WHEN 10                                                                            
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('1.总数','a.十月','4.差异数量',0)
                  WHEN 11                                    
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('1.总数','b.十一月','4.差异数量',0)
                  WHEN 12                                                                                
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('1.总数','c.十二月','4.差异数量',0)
                  WHEN 13                                                           
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('1.总数','d.销售累计','4.差异数量',0)
                  WHEN 14                                                                              
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year) VALUES ('1.总数','e.期初存货','4.差异数量')  
                  WHEN 15                                                          
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year) VALUES ('1.总数','f.售罄率','4.差异数量')
                  WHEN 16                                                          
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('1.总数','g.期末存量','4.差异数量',0)                         
               END CASE
            END FOR
            FOR l_b = 1 TO 16
               CASE l_b
                  WHEN 1
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('2.当季','1.一月','4.差异数量',0)
                  WHEN 2                                                                   
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('2.当季','2.二月','4.差异数量',0)
                  WHEN 3                                                                      
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('2.当季','3.三月','4.差异数量',0)
                  WHEN 4                                                                  
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('2.当季','4.四月','4.差异数量',0)
                  WHEN 5                                                                   
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('2.当季','5.五月','4.差异数量',0)
                  WHEN 6                                                                       
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('2.当季','6.六月','4.差异数量',0)
                  WHEN 7                                                                       
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('2.当季','7.七月','4.差异数量',0)
                  WHEN 8                                                                         
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('2.当季','8.八月','4.差异数量',0)
                  WHEN 9                                                                         
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('2.当季','9.九月','4.差异数量',0)
                  WHEN 10                                                                       
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('2.当季','a.十月','4.差异数量',0)
                  WHEN 11                                                    
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('2.当季','b.十一月','4.差异数量',0)
                  WHEN 12                                                     
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('2.当季','c.十二月','4.差异数量',0)
                  WHEN 13                                                           
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('2.当季','d.销售累计','4.差异数量',0)
                  WHEN 14                                                      
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year) VALUES ('2.当季','e.期初存货','4.差异数量')  
                  WHEN 15                                                          
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year) VALUES ('2.当季','f.售罄率','4.差异数量')
                  WHEN 16                                                         
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('2.当季','g.期末存量','4.差异数量',0)                         
               END CASE
            END FOR
            FOR l_b = 1 TO 16
               CASE l_b
                  WHEN 1
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('3.过季','1.一月','4.差异数量',0)
                  WHEN 2                                                                               
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('3.过季','2.二月','4.差异数量',0)
                  WHEN 3                                                                               
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('3.过季','3.三月','4.差异数量',0)
                  WHEN 4                                                                               
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('3.过季','4.四月','4.差异数量',0)
                  WHEN 5                                                                               
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('3.过季','5.五月','4.差异数量',0)
                  WHEN 6                                                                               
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('3.过季','6.六月','4.差异数量',0)
                  WHEN 7                                                                               
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('3.过季','7.七月','4.差异数量',0)
                  WHEN 8                                                                               
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('3.过季','8.八月','4.差异数量',0)
                  WHEN 9                                                                             
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('3.过季','9.九月','4.差异数量',0)
                  WHEN 10                                                                           
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('3.过季','a.十月','4.差异数量',0)
                  WHEN 11                                                        
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('3.过季','b.十一月','4.差异数量',0)
                  WHEN 12                                                        
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('3.过季','c.十二月','4.差异数量',0)
                  WHEN 13                                                           
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('3.过季','d.销售累计','4.差异数量',0)
                  WHEN 14                                                      
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year) VALUES ('3.过季','e.期初存货','4.差异数量')  
                  WHEN 15                                                          
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year) VALUES ('3.过季','f.售罄率','4.差异数量')
                  WHEN 16                                                         
                     INSERT INTO aslr506_tmp (l_data_typ,l_count_typ,l_year,l_data) VALUES ('3.过季','g.期末存量','4.差异数量',0)                         
               END CASE
            END FOR
      END CASE
   END FOR
   #计算日期
   CALL s_date_get_max_day(tm.year1,tm.mon) RETURNING l_days
   LET l_date = MDY(tm.mon,l_days,tm.year1)
   IF l_date >= g_today THEN
      LET l_date1 = g_today-1
      LET l_date_1 = g_today
   ELSE
      LET l_date1 = l_date
      LET l_date_1 = l_date
   END IF
   IF l_date = l_date1 THEN
      CALL s_date_get_max_day(YEAR(l_date1)-1,MONTH(l_date1)) RETURNING l_days
      LET l_date2 = MDY(MONTH(l_date1),l_days,YEAR(l_date1)-1)
   ELSE
      LET l_date2 = MDY(MONTH(l_date1),DAY(l_date1),YEAR(l_date1)-1)
   END IF
   IF l_date = l_date_1 THEN
      CALL s_date_get_max_day(YEAR(l_date_1)-1,MONTH(l_date_1)) RETURNING l_days
      LET l_date_2 = MDY(MONTH(l_date_1),l_days,YEAR(l_date_1)-1)
   ELSE
      LET l_date_2 = MDY(MONTH(l_date_1),DAY(l_date_1),YEAR(l_date_1)-1)
   END IF
   LET l_date3 = MDY(1,1,tm.year1) 
   LET l_date4 = MDY(1,1,tm.year1-1)    
   LET l_sql = " SELECT mon,yea,imaa155,SUM(A)", 
               "   FROM (SELECT to_char(rtiadocdt,'MM') mon,to_char(rtiadocdt,'YYYY') yea,imaa154,imaa155,COALESCE(rtib012,0) A",
               "           FROM rtaw_t,imaa_t,rtib_t,rtia_t",
               "          WHERE rtibent = imaaent AND rtib004 = imaa001",
               "            AND rtiaent = rtibent AND rtiadocno = rtibdocno AND rtiastus = 'Y' ",
               "            AND ((rtiadocdt BETWEEN to_date('",l_date4,"','yy/mm/dd') AND to_date('",l_date_2,"','yy/mm/dd')) OR (rtiadocdt BETWEEN to_date('",l_date3,"','yy/mm/dd') AND to_date('",l_date_1,"','yy/mm/dd')))",
               "            AND imaaent = rtawent",
               "            AND imaa009 = rtaw002",
               "            AND imaa155 <> '0'",
               "            AND imaaent = ",g_enterprise,
               "            AND (",tm.wc,"))",
               "  GROUP BY mon,yea,imaa155"
   PREPARE aslr506_pre FROM l_sql
   DECLARE aslr506_cur CURSOR FOR aslr506_pre
   FOREACH aslr506_cur INTO l_month,l_year1,l_imaa155,l_sum
      IF STATUS THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = 'foreach:'
          LET g_errparam.code   = STATUS
          LET g_errparam.popup  = TRUE
          CALL cl_err()
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF
#       IF l_imaa154 >= tm.year2 AND l_imaa155 >= tm.typ THEN
#          LET l_type = "2.当季"
#       ELSE
#          LET l_type = "3.过季"
#       END IF
       IF l_year1 = tm.year1 THEN LET l_year1 = l_str1 END IF
       IF l_year1 = tm.year1-1 THEN LET l_year1 = l_str2 END IF
       IF l_imaa155 = '1' THEN LET l_imaa155 = "1.春夏季" END IF
       IF l_imaa155 = '2' THEN LET l_imaa155 = "2.秋冬季" END IF
       CASE l_month
          WHEN 01  LET l_month1 = "1.一月"
          WHEN 02  LET l_month1 = "2.二月"
          WHEN 03  LET l_month1 = "3.三月"
          WHEN 04  LET l_month1 = "4.四月"
          WHEN 05  LET l_month1 = "5.五月"
          WHEN 06  LET l_month1 = "6.六月"
          WHEN 07  LET l_month1 = "7.七月"
          WHEN 08  LET l_month1 = "8.八月"
          WHEN 09  LET l_month1 = "9.九月"
          WHEN 10  LET l_month1 = "a.十月"
          WHEN 11  LET l_month1 = "b.十一月"
          WHEN 12  LET l_month1 = "c.十二月"
       END CASE
       UPDATE aslr506_tmp 
          SET l_data = l_sum
        WHERE l_data_typ = "1.总数"
          AND l_count_typ = l_month1
          AND l_year = l_year1
          AND l_season = l_imaa155
      IF STATUS THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'update aslr506_tmp:'
         LET g_errparam.code   = STATUS
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET g_rep_success = 'N'
         EXIT FOREACH
      END IF
   END FOREACH 
   CLOSE aslr506_cur
   LET l_sql = " SELECT mon,yea,imaa155,SUM(A)", 
               "   FROM (SELECT to_char(xmdkdocdt,'MM') mon,to_char(xmdkdocdt,'YYYY') yea,imaa154,imaa155,COALESCE(xmdl018,0) A",
               "           FROM rtaw_t,imaa_t,xmdl_t,xmdk_t",
               "          WHERE xmdlent = imaaent AND xmdl008 = imaa001",
               "            AND xmdkent = xmdlent AND xmdkdocno = xmdldocno AND xmdk000 = '1' AND xmdkstus IN ('Y','S')",
               "            AND ((xmdkdocdt BETWEEN to_date('",l_date4,"','yy/mm/dd') AND to_date('",l_date_2,"','yy/mm/dd')) OR (xmdkdocdt BETWEEN to_date('",l_date3,"','yy/mm/dd') AND to_date('",l_date_1,"','yy/mm/dd')))",
               "            AND imaaent = rtawent",
               "            AND imaa009 = rtaw002",
               "            AND imaa155 <> '0'",
               "            AND imaaent = ",g_enterprise,
               "            AND (",tm.wc,"))",
               "  GROUP BY mon,yea,imaa155"
   PREPARE aslr506_pre_1 FROM l_sql
   DECLARE aslr506_cur_1 CURSOR FOR aslr506_pre_1
   FOREACH aslr506_cur_1 INTO l_month,l_year1,l_imaa155,l_sum
      IF STATUS THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = 'foreach:'
          LET g_errparam.code   = STATUS
          LET g_errparam.popup  = TRUE
          CALL cl_err()
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF
       
       IF l_year1 = tm.year1 THEN LET l_year1 = l_str1 END IF
       IF l_year1 = tm.year1-1 THEN LET l_year1 = l_str2 END IF
       IF l_imaa155 = '1' THEN LET l_imaa155 = "1.春夏季" END IF
       IF l_imaa155 = '2' THEN LET l_imaa155 = "2.秋冬季" END IF
       CASE l_month
          WHEN 01  LET l_month1 = "1.一月"
          WHEN 02  LET l_month1 = "2.二月"
          WHEN 03  LET l_month1 = "3.三月"
          WHEN 04  LET l_month1 = "4.四月"
          WHEN 05  LET l_month1 = "5.五月"
          WHEN 06  LET l_month1 = "6.六月"
          WHEN 07  LET l_month1 = "7.七月"
          WHEN 08  LET l_month1 = "8.八月"
          WHEN 09  LET l_month1 = "9.九月"
          WHEN 10  LET l_month1 = "a.十月"
          WHEN 11  LET l_month1 = "b.十一月"
          WHEN 12  LET l_month1 = "c.十二月"
       END CASE
       UPDATE aslr506_tmp 
          SET l_data = l_data + l_sum
        WHERE l_data_typ = "1.总数"
          AND l_count_typ = l_month1
          AND l_year = l_year1
          AND l_season = l_imaa155
      IF STATUS THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'update aslr506_tmp:'
         LET g_errparam.code   = STATUS
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET g_rep_success = 'N'
         EXIT FOREACH
      END IF
   END FOREACH 
   CLOSE aslr506_cur_1
   LET l_sql = " SELECT mon,yea,imaa155,SUM(A)", 
               "   FROM (SELECT to_char(xmdkdocdt,'MM') mon,to_char(xmdkdocdt,'YYYY') yea,imaa154,imaa155,COALESCE(xmdl018,0) A",
               "           FROM rtaw_t,imaa_t,xmdl_t,xmdk_t",
               "          WHERE xmdlent = imaaent AND xmdl008 = imaa001",
               "            AND xmdkent = xmdlent AND xmdkdocno = xmdldocno AND xmdk000 = '6' AND xmdkstus IN ('Y','S')",
               "            AND ((xmdkdocdt BETWEEN to_date('",l_date4,"','yy/mm/dd') AND to_date('",l_date_2,"','yy/mm/dd')) OR (xmdkdocdt BETWEEN to_date('",l_date3,"','yy/mm/dd') AND to_date('",l_date_1,"','yy/mm/dd')))",
               "            AND imaaent = rtawent",
               "            AND imaa009 = rtaw002",
               "            AND imaa155 <> '0'",
               "            AND imaaent = ",g_enterprise,
               "            AND (",tm.wc,"))",
               "  GROUP BY mon,yea,imaa155"
   PREPARE aslr506_pre_2 FROM l_sql
   DECLARE aslr506_cur_2 CURSOR FOR aslr506_pre_2
   FOREACH aslr506_cur_2 INTO l_month,l_year1,l_imaa155,l_sum
      IF STATUS THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = 'foreach:'
          LET g_errparam.code   = STATUS
          LET g_errparam.popup  = TRUE
          CALL cl_err()
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF
       
       IF l_year1 = tm.year1 THEN LET l_year1 = l_str1 END IF
       IF l_year1 = tm.year1-1 THEN LET l_year1 = l_str2 END IF
       IF l_imaa155 = '1' THEN LET l_imaa155 = "1.春夏季" END IF
       IF l_imaa155 = '2' THEN LET l_imaa155 = "2.秋冬季" END IF
       CASE l_month
          WHEN 01  LET l_month1 = "1.一月"
          WHEN 02  LET l_month1 = "2.二月"
          WHEN 03  LET l_month1 = "3.三月"
          WHEN 04  LET l_month1 = "4.四月"
          WHEN 05  LET l_month1 = "5.五月"
          WHEN 06  LET l_month1 = "6.六月"
          WHEN 07  LET l_month1 = "7.七月"
          WHEN 08  LET l_month1 = "8.八月"
          WHEN 09  LET l_month1 = "9.九月"
          WHEN 10  LET l_month1 = "a.十月"
          WHEN 11  LET l_month1 = "b.十一月"
          WHEN 12  LET l_month1 = "c.十二月"
       END CASE
       UPDATE aslr506_tmp 
          SET l_data = l_data - l_sum
        WHERE l_data_typ = "1.总数"
          AND l_count_typ = l_month1
          AND l_year = l_year1
          AND l_season = l_imaa155
      IF STATUS THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'update aslr506_tmp:'
         LET g_errparam.code   = STATUS
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET g_rep_success = 'N'
         EXIT FOREACH
      END IF
   END FOREACH 
   CLOSE aslr506_cur_2
   LET l_sql = " SELECT mon,yea,imaa155,SUM(A)", 
               "   FROM (SELECT to_char(rtiadocdt,'MM') mon,to_char(rtiadocdt,'YYYY') yea,imaa154,imaa155,COALESCE(rtib012,0) A",
               "           FROM rtaw_t,imaa_t,rtib_t,rtia_t",
               "          WHERE rtibent = imaaent AND rtib004 = imaa001",
               "            AND rtiaent = rtibent AND rtiadocno = rtibdocno AND rtiastus = 'Y' ",
               "            AND ((rtiadocdt BETWEEN to_date('",l_date4,"','yy/mm/dd') AND to_date('",l_date_2,"','yy/mm/dd')) OR (rtiadocdt BETWEEN to_date('",l_date3,"','yy/mm/dd') AND to_date('",l_date_1,"','yy/mm/dd')))",
               "            AND imaaent = rtawent",
               "            AND imaa009 = rtaw002",
               "            AND imaa155 <> '0'",
               "            AND imaa154 = ",tm.year1,
               "            AND imaaent = ",g_enterprise,
               "            AND (",tm.wc,"))",
               "  GROUP BY mon,yea,imaa155"
   PREPARE aslr506_pre1 FROM l_sql
   DECLARE aslr506_cur1 CURSOR FOR aslr506_pre1
   FOREACH aslr506_cur1 INTO l_month,l_year1,l_imaa155,l_sum
      IF STATUS THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = 'foreach:'
          LET g_errparam.code   = STATUS
          LET g_errparam.popup  = TRUE
          CALL cl_err()
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF
       IF l_year1 = tm.year1 THEN LET l_year1 = l_str1 END IF
       IF l_year1 = tm.year1-1 THEN LET l_year1 = l_str2 END IF
       IF l_imaa155 = '1' THEN LET l_imaa155 = "1.春夏季" END IF
       IF l_imaa155 = '2' THEN LET l_imaa155 = "2.秋冬季" END IF
       CASE l_month
          WHEN 01  LET l_month1 = "1.一月"
          WHEN 02  LET l_month1 = "2.二月"
          WHEN 03  LET l_month1 = "3.三月"
          WHEN 04  LET l_month1 = "4.四月"
          WHEN 05  LET l_month1 = "5.五月"
          WHEN 06  LET l_month1 = "6.六月"
          WHEN 07  LET l_month1 = "7.七月"
          WHEN 08  LET l_month1 = "8.八月"
          WHEN 09  LET l_month1 = "9.九月"
          WHEN 10  LET l_month1 = "a.十月"
          WHEN 11  LET l_month1 = "b.十一月"
          WHEN 12  LET l_month1 = "c.十二月"
       END CASE
       IF l_imaa155 = "1.春夏季" AND l_month <= 8 AND l_year1 = l_str1 THEN
          UPDATE aslr506_tmp 
             SET l_data = l_sum
           WHERE l_data_typ = "2.当季"
             AND l_count_typ = l_month1
             AND l_year = l_str1
             AND l_season = l_imaa155
          IF STATUS THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.extend = 'update aslr506_tmp:'
             LET g_errparam.code   = STATUS
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             LET g_rep_success = 'N'
             EXIT FOREACH
          END IF
      END IF
   END FOREACH 
   CLOSE aslr506_cur1
   LET l_sql = " SELECT mon,yea,imaa155,SUM(A)", 
               "   FROM (SELECT to_char(xmdkdocdt,'MM') mon,to_char(xmdkdocdt,'YYYY') yea,imaa154,imaa155,COALESCE(xmdl018,0) A",
               "           FROM rtaw_t,imaa_t,xmdl_t,xmdk_t",
               "          WHERE xmdlent = imaaent AND xmdl008 = imaa001",
               "            AND xmdkent = xmdlent AND xmdkdocno = xmdldocno AND xmdk000 = '1' AND xmdkstus IN ('Y','S')",
               "            AND ((xmdkdocdt BETWEEN to_date('",l_date4,"','yy/mm/dd') AND to_date('",l_date_2,"','yy/mm/dd')) OR (xmdkdocdt BETWEEN to_date('",l_date3,"','yy/mm/dd') AND to_date('",l_date_1,"','yy/mm/dd')))",
               "            AND imaaent = rtawent",
               "            AND imaa009 = rtaw002",
               "            AND imaa155 <> '0'",
               "            AND imaa154 = ",tm.year1,
               "            AND imaaent = ",g_enterprise,
               "            AND (",tm.wc,"))",
               "  GROUP BY mon,yea,imaa155"
   PREPARE aslr506_pre1_1 FROM l_sql
   DECLARE aslr506_cur1_1 CURSOR FOR aslr506_pre1_1
   FOREACH aslr506_cur1_1 INTO l_month,l_year1,l_imaa155,l_sum
      IF STATUS THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = 'foreach:'
          LET g_errparam.code   = STATUS
          LET g_errparam.popup  = TRUE
          CALL cl_err()
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF
       IF l_year1 = tm.year1 THEN LET l_year1 = l_str1 END IF
       IF l_year1 = tm.year1-1 THEN LET l_year1 = l_str2 END IF
       IF l_imaa155 = '1' THEN LET l_imaa155 = "1.春夏季" END IF
       IF l_imaa155 = '2' THEN LET l_imaa155 = "2.秋冬季" END IF
       CASE l_month
          WHEN 01  LET l_month1 = "1.一月"
          WHEN 02  LET l_month1 = "2.二月"
          WHEN 03  LET l_month1 = "3.三月"
          WHEN 04  LET l_month1 = "4.四月"
          WHEN 05  LET l_month1 = "5.五月"
          WHEN 06  LET l_month1 = "6.六月"
          WHEN 07  LET l_month1 = "7.七月"
          WHEN 08  LET l_month1 = "8.八月"
          WHEN 09  LET l_month1 = "9.九月"
          WHEN 10  LET l_month1 = "a.十月"
          WHEN 11  LET l_month1 = "b.十一月"
          WHEN 12  LET l_month1 = "c.十二月"
       END CASE
       IF l_imaa155 = "1.春夏季" AND l_month <= 8 AND l_year1 = l_str1 THEN
          UPDATE aslr506_tmp 
             SET l_data =l_data + l_sum
           WHERE l_data_typ = "2.当季"
             AND l_count_typ = l_month1
             AND l_year = l_str1
             AND l_season = l_imaa155
          IF STATUS THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.extend = 'update aslr506_tmp:'
             LET g_errparam.code   = STATUS
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             LET g_rep_success = 'N'
             EXIT FOREACH
          END IF
      END IF
   END FOREACH 
   CLOSE aslr506_cur1_1
   LET l_sql = " SELECT mon,yea,imaa155,SUM(A)", 
               "   FROM (SELECT to_char(xmdkdocdt,'MM') mon,to_char(xmdkdocdt,'YYYY') yea,imaa154,imaa155,COALESCE(xmdl018,0) A",
               "           FROM rtaw_t,imaa_t,xmdl_t,xmdk_t",
               "          WHERE xmdlent = imaaent AND xmdl008 = imaa001",
               "            AND xmdkent = xmdlent AND xmdkdocno = xmdldocno AND xmdk000 = '6' AND xmdkstus IN ('Y','S')",
               "            AND ((xmdkdocdt BETWEEN to_date('",l_date4,"','yy/mm/dd') AND to_date('",l_date_2,"','yy/mm/dd')) OR (xmdkdocdt BETWEEN to_date('",l_date3,"','yy/mm/dd') AND to_date('",l_date_1,"','yy/mm/dd')))",
               "            AND imaaent = rtawent",
               "            AND imaa009 = rtaw002",
               "            AND imaa155 <> '0'",
               "            AND imaa154 = ",tm.year1,
               "            AND imaaent = ",g_enterprise,
               "            AND (",tm.wc,"))",
               "  GROUP BY mon,yea,imaa155"
   PREPARE aslr506_pre1_2 FROM l_sql
   DECLARE aslr506_cur1_2 CURSOR FOR aslr506_pre1_2
   FOREACH aslr506_cur1_2  INTO l_month,l_year1,l_imaa155,l_sum
      IF STATUS THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = 'foreach:'
          LET g_errparam.code   = STATUS
          LET g_errparam.popup  = TRUE
          CALL cl_err()
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF
       IF l_year1 = tm.year1 THEN LET l_year1 = l_str1 END IF
       IF l_year1 = tm.year1-1 THEN LET l_year1 = l_str2 END IF
       IF l_imaa155 = '1' THEN LET l_imaa155 = "1.春夏季" END IF
       IF l_imaa155 = '2' THEN LET l_imaa155 = "2.秋冬季" END IF
       CASE l_month
          WHEN 01  LET l_month1 = "1.一月"
          WHEN 02  LET l_month1 = "2.二月"
          WHEN 03  LET l_month1 = "3.三月"
          WHEN 04  LET l_month1 = "4.四月"
          WHEN 05  LET l_month1 = "5.五月"
          WHEN 06  LET l_month1 = "6.六月"
          WHEN 07  LET l_month1 = "7.七月"
          WHEN 08  LET l_month1 = "8.八月"
          WHEN 09  LET l_month1 = "9.九月"
          WHEN 10  LET l_month1 = "a.十月"
          WHEN 11  LET l_month1 = "b.十一月"
          WHEN 12  LET l_month1 = "c.十二月"
       END CASE
       IF l_imaa155 = "1.春夏季" AND l_month <= 8 AND l_year1 = l_str1 THEN
          UPDATE aslr506_tmp 
             SET l_data =l_data - l_sum
           WHERE l_data_typ = "2.当季"
             AND l_count_typ = l_month1
             AND l_year = l_str1
             AND l_season = l_imaa155
          IF STATUS THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.extend = 'update aslr506_tmp:'
             LET g_errparam.code   = STATUS
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             LET g_rep_success = 'N'
             EXIT FOREACH
          END IF
      END IF
   END FOREACH 
   CLOSE aslr506_cur1_2
   LET l_sql = " SELECT mon,yea,imaa155,SUM(A)", 
               "   FROM (SELECT to_char(rtiadocdt,'MM') mon,to_char(rtiadocdt,'YYYY') yea,imaa154,imaa155,COALESCE(rtib012,0) A",
               "           FROM rtaw_t,imaa_t,rtib_t,rtia_t",
               "          WHERE rtibent = imaaent AND rtib004 = imaa001",
               "            AND rtiaent = rtibent AND rtiadocno = rtibdocno AND rtiastus = 'Y' ",
               "            AND ((rtiadocdt BETWEEN to_date('",l_date4,"','yy/mm/dd') AND to_date('",l_date_2,"','yy/mm/dd')) OR (rtiadocdt BETWEEN to_date('",l_date3,"','yy/mm/dd') AND to_date('",l_date_1,"','yy/mm/dd')))",
               "            AND imaaent = rtawent",
               "            AND imaa009 = rtaw002",
               "            AND imaa155 <> '0'",
               "            AND imaa154 = ",tm.year1-1,
               "            AND imaaent = ",g_enterprise,
               "            AND (",tm.wc,"))",
               "  GROUP BY mon,yea,imaa155"
   PREPARE aslr506_pre2 FROM l_sql
   DECLARE aslr506_cur2 CURSOR FOR aslr506_pre2
   FOREACH aslr506_cur2 INTO l_month,l_year1,l_imaa155,l_sum
      IF STATUS THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = 'foreach:'
          LET g_errparam.code   = STATUS
          LET g_errparam.popup  = TRUE
          CALL cl_err()
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF
       IF l_year1 = tm.year1 THEN LET l_year1 = l_str1 END IF
       IF l_year1 = tm.year1-1 THEN LET l_year1 = l_str2 END IF
       IF l_imaa155 = '1' THEN LET l_imaa155 = "1.春夏季" END IF
       IF l_imaa155 = '2' THEN LET l_imaa155 = "2.秋冬季" END IF
       CASE l_month
          WHEN 01  LET l_month1 = "1.一月"
          WHEN 02  LET l_month1 = "2.二月"
          WHEN 03  LET l_month1 = "3.三月"
          WHEN 04  LET l_month1 = "4.四月"
          WHEN 05  LET l_month1 = "5.五月"
          WHEN 06  LET l_month1 = "6.六月"
          WHEN 07  LET l_month1 = "7.七月"
          WHEN 08  LET l_month1 = "8.八月"
          WHEN 09  LET l_month1 = "9.九月"
          WHEN 10  LET l_month1 = "a.十月"
          WHEN 11  LET l_month1 = "b.十一月"
          WHEN 12  LET l_month1 = "c.十二月"
       END CASE
       IF l_imaa155 = "1.春夏季" AND l_month <= 8 AND l_year1 = l_str2 THEN
          UPDATE aslr506_tmp 
             SET l_data = l_sum
           WHERE l_data_typ = "2.当季"
             AND l_count_typ = l_month1
             AND l_year = l_str2
             AND l_season = l_imaa155
          IF STATUS THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.extend = 'update aslr506_tmp:'
             LET g_errparam.code   = STATUS
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             LET g_rep_success = 'N'
             EXIT FOREACH
          END IF
      END IF
   END FOREACH 
   CLOSE aslr506_cur2
   LET l_sql = " SELECT mon,yea,imaa155,SUM(A)", 
               "   FROM (SELECT to_char(xmdkdocdt,'MM') mon,to_char(xmdkdocdt,'YYYY') yea,imaa154,imaa155,COALESCE(xmdl018,0) A",
               "           FROM rtaw_t,imaa_t,xmdl_t,xmdk_t",
               "          WHERE xmdlent = imaaent AND xmdl008 = imaa001",
               "            AND xmdkent = xmdlent AND xmdkdocno = xmdldocno AND xmdk000 = '1' AND xmdkstus IN ('Y','S')",
               "            AND ((xmdkdocdt BETWEEN to_date('",l_date4,"','yy/mm/dd') AND to_date('",l_date_2,"','yy/mm/dd')) OR (xmdkdocdt BETWEEN to_date('",l_date3,"','yy/mm/dd') AND to_date('",l_date_1,"','yy/mm/dd')))",
               "            AND imaaent = rtawent",
               "            AND imaa009 = rtaw002",
               "            AND imaa155 <> '0'",
               "            AND imaa154 = ",tm.year1-1,
               "            AND imaaent = ",g_enterprise,
               "            AND (",tm.wc,"))",
               "  GROUP BY mon,yea,imaa155"
   PREPARE aslr506_pre2_1 FROM l_sql
   DECLARE aslr506_cur2_1 CURSOR FOR aslr506_pre2_1
   FOREACH aslr506_cur2_1 INTO l_month,l_year1,l_imaa155,l_sum
      IF STATUS THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = 'foreach:'
          LET g_errparam.code   = STATUS
          LET g_errparam.popup  = TRUE
          CALL cl_err()
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF
       IF l_year1 = tm.year1 THEN LET l_year1 = l_str1 END IF
       IF l_year1 = tm.year1-1 THEN LET l_year1 = l_str2 END IF
       IF l_imaa155 = '1' THEN LET l_imaa155 = "1.春夏季" END IF
       IF l_imaa155 = '2' THEN LET l_imaa155 = "2.秋冬季" END IF
       CASE l_month
          WHEN 01  LET l_month1 = "1.一月"
          WHEN 02  LET l_month1 = "2.二月"
          WHEN 03  LET l_month1 = "3.三月"
          WHEN 04  LET l_month1 = "4.四月"
          WHEN 05  LET l_month1 = "5.五月"
          WHEN 06  LET l_month1 = "6.六月"
          WHEN 07  LET l_month1 = "7.七月"
          WHEN 08  LET l_month1 = "8.八月"
          WHEN 09  LET l_month1 = "9.九月"
          WHEN 10  LET l_month1 = "a.十月"
          WHEN 11  LET l_month1 = "b.十一月"
          WHEN 12  LET l_month1 = "c.十二月"
       END CASE
       IF l_imaa155 = "1.春夏季" AND l_month <= 8 AND l_year1 = l_str2 THEN
          UPDATE aslr506_tmp 
             SET l_data = l_data + l_sum
           WHERE l_data_typ = "2.当季"
             AND l_count_typ = l_month1
             AND l_year = l_str2
             AND l_season = l_imaa155
          IF STATUS THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.extend = 'update aslr506_tmp:'
             LET g_errparam.code   = STATUS
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             LET g_rep_success = 'N'
             EXIT FOREACH
          END IF
      END IF
   END FOREACH 
   CLOSE aslr506_cur2_1
   LET l_sql = " SELECT mon,yea,imaa155,SUM(A)", 
               "   FROM (SELECT to_char(xmdkdocdt,'MM') mon,to_char(xmdkdocdt,'YYYY') yea,imaa154,imaa155,COALESCE(xmdl018,0) A",
               "           FROM rtaw_t,imaa_t,xmdl_t,xmdk_t",
               "          WHERE xmdlent = imaaent AND xmdl008 = imaa001",
               "            AND xmdkent = xmdlent AND xmdkdocno = xmdldocno AND xmdk000 = '6' AND xmdkstus IN ('Y','S')",
               "            AND ((xmdkdocdt BETWEEN to_date('",l_date4,"','yy/mm/dd') AND to_date('",l_date_2,"','yy/mm/dd')) OR (xmdkdocdt BETWEEN to_date('",l_date3,"','yy/mm/dd') AND to_date('",l_date_1,"','yy/mm/dd')))",
               "            AND imaaent = rtawent",
               "            AND imaa009 = rtaw002",
               "            AND imaa155 <> '0'",
               "            AND imaa154 = ",tm.year1-1,
               "            AND imaaent = ",g_enterprise,
               "            AND (",tm.wc,"))",
               "  GROUP BY mon,yea,imaa155"
   PREPARE aslr506_pre2_2 FROM l_sql
   DECLARE aslr506_cur2_2 CURSOR FOR aslr506_pre2_2
   FOREACH aslr506_cur2_2 INTO l_month,l_year1,l_imaa155,l_sum
      IF STATUS THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = 'foreach:'
          LET g_errparam.code   = STATUS
          LET g_errparam.popup  = TRUE
          CALL cl_err()
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF
       IF l_year1 = tm.year1 THEN LET l_year1 = l_str1 END IF
       IF l_year1 = tm.year1-1 THEN LET l_year1 = l_str2 END IF
       IF l_imaa155 = '1' THEN LET l_imaa155 = "1.春夏季" END IF
       IF l_imaa155 = '2' THEN LET l_imaa155 = "2.秋冬季" END IF
       CASE l_month
          WHEN 01  LET l_month1 = "1.一月"
          WHEN 02  LET l_month1 = "2.二月"
          WHEN 03  LET l_month1 = "3.三月"
          WHEN 04  LET l_month1 = "4.四月"
          WHEN 05  LET l_month1 = "5.五月"
          WHEN 06  LET l_month1 = "6.六月"
          WHEN 07  LET l_month1 = "7.七月"
          WHEN 08  LET l_month1 = "8.八月"
          WHEN 09  LET l_month1 = "9.九月"
          WHEN 10  LET l_month1 = "a.十月"
          WHEN 11  LET l_month1 = "b.十一月"
          WHEN 12  LET l_month1 = "c.十二月"
       END CASE
       IF l_imaa155 = "1.春夏季" AND l_month <= 8 AND l_year1 = l_str2 THEN
          UPDATE aslr506_tmp 
             SET l_data = l_data - l_sum
           WHERE l_data_typ = "2.当季"
             AND l_count_typ = l_month1
             AND l_year = l_str2
             AND l_season = l_imaa155
          IF STATUS THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.extend = 'update aslr506_tmp:'
             LET g_errparam.code   = STATUS
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             LET g_rep_success = 'N'
             EXIT FOREACH
          END IF
      END IF
   END FOREACH 
   CLOSE aslr506_cur2_2
   LET l_sql = " SELECT mon,yea,imaa155,SUM(A)", 
               "   FROM (SELECT to_char(rtiadocdt,'MM') mon,to_char(rtiadocdt,'YYYY') yea,imaa154,imaa155,COALESCE(rtib012,0) A",
               "           FROM rtaw_t,imaa_t,rtib_t,rtia_t",
               "          WHERE rtibent = imaaent AND rtib004 = imaa001",
               "            AND rtiaent = rtibent AND rtiadocno = rtibdocno AND rtiastus = 'Y' ",
               "            AND ((rtiadocdt BETWEEN to_date('",l_date4,"','yy/mm/dd') AND to_date('",l_date_2,"','yy/mm/dd')) OR (rtiadocdt BETWEEN to_date('",l_date3,"','yy/mm/dd') AND to_date('",l_date_1,"','yy/mm/dd')))",
               "            AND imaaent = rtawent",
               "            AND imaa009 = rtaw002",
               "            AND imaa155 <> '0'",
               "            AND imaa154 = ",tm.year1,
               "            AND imaaent = ",g_enterprise,
               "            AND (",tm.wc,"))",
               "  GROUP BY mon,yea,imaa155"
   PREPARE aslr506_pre3 FROM l_sql
   DECLARE aslr506_cur3 CURSOR FOR aslr506_pre3
   FOREACH aslr506_cur3 INTO l_month,l_year1,l_imaa155,l_sum
      IF STATUS THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.code   = STATUS
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET g_rep_success = 'N'
         EXIT FOREACH
      END IF
      IF l_year1 = tm.year1 THEN LET l_year1 = l_str1 END IF
      IF l_year1 = tm.year1-1 THEN LET l_year1 = l_str2 END IF
      IF l_imaa155 = '1' THEN LET l_imaa155 = "1.春夏季" END IF
      IF l_imaa155 = '2' THEN LET l_imaa155 = "2.秋冬季" END IF
      CASE l_month
         WHEN 01  LET l_month1 = "1.一月"
         WHEN 02  LET l_month1 = "2.二月"
         WHEN 03  LET l_month1 = "3.三月"
         WHEN 04  LET l_month1 = "4.四月"
         WHEN 05  LET l_month1 = "5.五月"
         WHEN 06  LET l_month1 = "6.六月"
         WHEN 07  LET l_month1 = "7.七月"
         WHEN 08  LET l_month1 = "8.八月"
         WHEN 09  LET l_month1 = "9.九月"
         WHEN 10  LET l_month1 = "a.十月"
         WHEN 11  LET l_month1 = "b.十一月"
         WHEN 12  LET l_month1 = "c.十二月"
      END CASE
      IF l_month >= 8 AND l_imaa155 = "2.秋冬季" AND l_year1 = l_str1 THEN
         UPDATE aslr506_tmp 
            SET l_data = l_sum
          WHERE l_data_typ = "2.当季"
            AND l_count_typ = l_month1
            AND l_year = l_str1
            AND l_season = l_imaa155
         IF STATUS THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'update aslr506_tmp:'
            LET g_errparam.code   = STATUS
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET g_rep_success = 'N'
            EXIT FOREACH
         END IF
      END IF
   END FOREACH 
   CLOSE aslr506_cur3
   LET l_sql = " SELECT mon,yea,imaa155,SUM(A)", 
               "   FROM (SELECT to_char(xmdkdocdt,'MM') mon,to_char(xmdkdocdt,'YYYY') yea,imaa154,imaa155,COALESCE(xmdl018,0) A",
               "           FROM rtaw_t,imaa_t,xmdl_t,xmdk_t",
               "          WHERE xmdlent = imaaent AND xmdl008 = imaa001",
               "            AND xmdkent = xmdlent AND xmdkdocno = xmdldocno AND xmdk000 = '1' AND xmdkstus IN ('Y','S')",
               "            AND ((xmdkdocdt BETWEEN to_date('",l_date4,"','yy/mm/dd') AND to_date('",l_date_2,"','yy/mm/dd')) OR (xmdkdocdt BETWEEN to_date('",l_date3,"','yy/mm/dd') AND to_date('",l_date_1,"','yy/mm/dd')))",
               "            AND imaaent = rtawent",
               "            AND imaa009 = rtaw002",
               "            AND imaa155 <> '0'",
               "            AND imaa154 = ",tm.year1,
               "            AND imaaent = ",g_enterprise,
               "            AND (",tm.wc,"))",
               "  GROUP BY mon,yea,imaa155"
   PREPARE aslr506_pre3_1 FROM l_sql
   DECLARE aslr506_cur3_1 CURSOR FOR aslr506_pre3_1
   FOREACH aslr506_cur3_1 INTO l_month,l_year1,l_imaa155,l_sum
      IF STATUS THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.code   = STATUS
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET g_rep_success = 'N'
         EXIT FOREACH
      END IF
      IF l_year1 = tm.year1 THEN LET l_year1 = l_str1 END IF
      IF l_year1 = tm.year1-1 THEN LET l_year1 = l_str2 END IF
      IF l_imaa155 = '1' THEN LET l_imaa155 = "1.春夏季" END IF
      IF l_imaa155 = '2' THEN LET l_imaa155 = "2.秋冬季" END IF
      CASE l_month
         WHEN 01  LET l_month1 = "1.一月"
         WHEN 02  LET l_month1 = "2.二月"
         WHEN 03  LET l_month1 = "3.三月"
         WHEN 04  LET l_month1 = "4.四月"
         WHEN 05  LET l_month1 = "5.五月"
         WHEN 06  LET l_month1 = "6.六月"
         WHEN 07  LET l_month1 = "7.七月"
         WHEN 08  LET l_month1 = "8.八月"
         WHEN 09  LET l_month1 = "9.九月"
         WHEN 10  LET l_month1 = "a.十月"
         WHEN 11  LET l_month1 = "b.十一月"
         WHEN 12  LET l_month1 = "c.十二月"
      END CASE
      IF l_month >= 8 AND l_imaa155 = "2.秋冬季" AND l_year1 = l_str1 THEN
         UPDATE aslr506_tmp 
            SET l_data = l_data + l_sum
          WHERE l_data_typ = "2.当季"
            AND l_count_typ = l_month1
            AND l_year = l_str1
            AND l_season = l_imaa155
         IF STATUS THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'update aslr506_tmp:'
            LET g_errparam.code   = STATUS
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET g_rep_success = 'N'
            EXIT FOREACH
         END IF
      END IF
   END FOREACH 
   CLOSE aslr506_cur3_1
   LET l_sql = " SELECT mon,yea,imaa155,SUM(A)", 
               "   FROM (SELECT to_char(xmdkdocdt,'MM') mon,to_char(xmdkdocdt,'YYYY') yea,imaa154,imaa155,COALESCE(xmdl018,0) A",
               "           FROM rtaw_t,imaa_t,xmdl_t,xmdk_t",
               "          WHERE xmdlent = imaaent AND xmdl008 = imaa001",
               "            AND xmdkent = xmdlent AND xmdkdocno = xmdldocno AND xmdk000 = '6' AND xmdkstus IN ('Y','S')",
               "            AND ((xmdkdocdt BETWEEN to_date('",l_date4,"','yy/mm/dd') AND to_date('",l_date_2,"','yy/mm/dd')) OR (xmdkdocdt BETWEEN to_date('",l_date3,"','yy/mm/dd') AND to_date('",l_date_1,"','yy/mm/dd')))",
               "            AND imaaent = rtawent",
               "            AND imaa009 = rtaw002",
               "            AND imaa155 <> '0'",
               "            AND imaa154 = ",tm.year1,
               "            AND imaaent = ",g_enterprise,
               "            AND (",tm.wc,"))",
               "  GROUP BY mon,yea,imaa155"
   PREPARE aslr506_pre3_2 FROM l_sql
   DECLARE aslr506_cur3_2 CURSOR FOR aslr506_pre3_2
   FOREACH aslr506_cur3_2 INTO l_month,l_year1,l_imaa155,l_sum
      IF STATUS THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.code   = STATUS
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET g_rep_success = 'N'
         EXIT FOREACH
      END IF
      IF l_year1 = tm.year1 THEN LET l_year1 = l_str1 END IF
      IF l_year1 = tm.year1-1 THEN LET l_year1 = l_str2 END IF
      IF l_imaa155 = '1' THEN LET l_imaa155 = "1.春夏季" END IF
      IF l_imaa155 = '2' THEN LET l_imaa155 = "2.秋冬季" END IF
      CASE l_month
         WHEN 01  LET l_month1 = "1.一月"
         WHEN 02  LET l_month1 = "2.二月"
         WHEN 03  LET l_month1 = "3.三月"
         WHEN 04  LET l_month1 = "4.四月"
         WHEN 05  LET l_month1 = "5.五月"
         WHEN 06  LET l_month1 = "6.六月"
         WHEN 07  LET l_month1 = "7.七月"
         WHEN 08  LET l_month1 = "8.八月"
         WHEN 09  LET l_month1 = "9.九月"
         WHEN 10  LET l_month1 = "a.十月"
         WHEN 11  LET l_month1 = "b.十一月"
         WHEN 12  LET l_month1 = "c.十二月"
      END CASE
      IF l_month >= 8 AND l_imaa155 = "2.秋冬季" AND l_year1 = l_str1 THEN
         UPDATE aslr506_tmp 
            SET l_data = l_data - l_sum
          WHERE l_data_typ = "2.当季"
            AND l_count_typ = l_month1
            AND l_year = l_str1
            AND l_season = l_imaa155
         IF STATUS THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'update aslr506_tmp:'
            LET g_errparam.code   = STATUS
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET g_rep_success = 'N'
            EXIT FOREACH
         END IF
      END IF
   END FOREACH 
   CLOSE aslr506_cur3_2
   LET l_sql = " SELECT mon,yea,imaa155,SUM(A)", 
               "   FROM (SELECT to_char(rtiadocdt,'MM') mon,to_char(rtiadocdt,'YYYY') yea,imaa154,imaa155,COALESCE(rtib012,0) A",
               "           FROM rtaw_t,imaa_t,rtib_t,rtia_t",
               "          WHERE rtibent = imaaent AND rtib004 = imaa001",
               "            AND rtiaent = rtibent AND rtiadocno = rtibdocno AND rtiastus = 'Y' ",
               "            AND ((rtiadocdt BETWEEN to_date('",l_date4,"','yy/mm/dd') AND to_date('",l_date_2,"','yy/mm/dd')) OR (rtiadocdt BETWEEN to_date('",l_date3,"','yy/mm/dd') AND to_date('",l_date_1,"','yy/mm/dd')))",
               "            AND imaaent = rtawent",
               "            AND imaa009 = rtaw002",
               "            AND imaa155 <> '0'",
               "            AND imaa154 = ",tm.year1-1,
               "            AND imaaent = ",g_enterprise,
               "            AND (",tm.wc,"))",
               "  GROUP BY mon,yea,imaa155"
   PREPARE aslr506_pre4 FROM l_sql
   DECLARE aslr506_cur4 CURSOR FOR aslr506_pre4
   FOREACH aslr506_cur4 INTO l_month,l_year1,l_imaa155,l_sum
      IF STATUS THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.code   = STATUS
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET g_rep_success = 'N'
         EXIT FOREACH
      END IF
      IF l_year1 = tm.year1 THEN LET l_year1 = l_str1 END IF
      IF l_year1 = tm.year1-1 THEN LET l_year1 = l_str2 END IF
      IF l_imaa155 = '1' THEN LET l_imaa155 = "1.春夏季" END IF
      IF l_imaa155 = '2' THEN LET l_imaa155 = "2.秋冬季" END IF
      CASE l_month
         WHEN 01  LET l_month1 = "1.一月"
         WHEN 02  LET l_month1 = "2.二月"
         WHEN 03  LET l_month1 = "3.三月"
         WHEN 04  LET l_month1 = "4.四月"
         WHEN 05  LET l_month1 = "5.五月"
         WHEN 06  LET l_month1 = "6.六月"
         WHEN 07  LET l_month1 = "7.七月"
         WHEN 08  LET l_month1 = "8.八月"
         WHEN 09  LET l_month1 = "9.九月"
         WHEN 10  LET l_month1 = "a.十月"
         WHEN 11  LET l_month1 = "b.十一月"
         WHEN 12  LET l_month1 = "c.十二月"
      END CASE
      IF l_month <= 3 AND l_imaa155 = "2.秋冬季" AND l_year1 = l_str1 THEN
         UPDATE aslr506_tmp 
            SET l_data = l_sum
          WHERE l_data_typ = "2.当季"
            AND l_count_typ = l_month1
            AND l_year = l_str1
            AND l_season = l_imaa155
         IF STATUS THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'update aslr506_tmp:'
            LET g_errparam.code   = STATUS
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET g_rep_success = 'N'
            EXIT FOREACH
         END IF
      END IF
      IF l_month >= 8 AND l_imaa155 = "2.秋冬季" AND l_year1 = l_str2 THEN
         UPDATE aslr506_tmp 
            SET l_data = l_sum
          WHERE l_data_typ = "2.当季"
            AND l_count_typ = l_month1
            AND l_year = l_str2
            AND l_season = l_imaa155
         IF STATUS THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'update aslr506_tmp:'
            LET g_errparam.code   = STATUS
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET g_rep_success = 'N'
            EXIT FOREACH
         END IF
      END IF
   END FOREACH 
   CLOSE aslr506_cur4
   LET l_sql = " SELECT mon,yea,imaa155,SUM(A)", 
               "   FROM (SELECT to_char(xmdkdocdt,'MM') mon,to_char(xmdkdocdt,'YYYY') yea,imaa154,imaa155,COALESCE(xmdl018,0) A",
               "           FROM rtaw_t,imaa_t,xmdl_t,xmdk_t",
               "          WHERE xmdlent = imaaent AND xmdl008 = imaa001",
               "            AND xmdkent = xmdlent AND xmdkdocno = xmdldocno AND xmdk000 = '1' AND xmdkstus IN ('Y','S')",
               "            AND ((xmdkdocdt BETWEEN to_date('",l_date4,"','yy/mm/dd') AND to_date('",l_date_2,"','yy/mm/dd')) OR (xmdkdocdt BETWEEN to_date('",l_date3,"','yy/mm/dd') AND to_date('",l_date_1,"','yy/mm/dd')))",
               "            AND imaaent = rtawent",
               "            AND imaa009 = rtaw002",
               "            AND imaa155 <> '0'",
               "            AND imaa154 = ",tm.year1-1,
               "            AND imaaent = ",g_enterprise,
               "            AND (",tm.wc,"))",
               "  GROUP BY mon,yea,imaa155"
   PREPARE aslr506_pre4_1 FROM l_sql
   DECLARE aslr506_cur4_1 CURSOR FOR aslr506_pre4_1
   FOREACH aslr506_cur4_1 INTO l_month,l_year1,l_imaa155,l_sum
      IF STATUS THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.code   = STATUS
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET g_rep_success = 'N'
         EXIT FOREACH
      END IF
      IF l_year1 = tm.year1 THEN LET l_year1 = l_str1 END IF
      IF l_year1 = tm.year1-1 THEN LET l_year1 = l_str2 END IF
      IF l_imaa155 = '1' THEN LET l_imaa155 = "1.春夏季" END IF
      IF l_imaa155 = '2' THEN LET l_imaa155 = "2.秋冬季" END IF
      CASE l_month
         WHEN 01  LET l_month1 = "1.一月"
         WHEN 02  LET l_month1 = "2.二月"
         WHEN 03  LET l_month1 = "3.三月"
         WHEN 04  LET l_month1 = "4.四月"
         WHEN 05  LET l_month1 = "5.五月"
         WHEN 06  LET l_month1 = "6.六月"
         WHEN 07  LET l_month1 = "7.七月"
         WHEN 08  LET l_month1 = "8.八月"
         WHEN 09  LET l_month1 = "9.九月"
         WHEN 10  LET l_month1 = "a.十月"
         WHEN 11  LET l_month1 = "b.十一月"
         WHEN 12  LET l_month1 = "c.十二月"
      END CASE
      IF l_month <= 3 AND l_imaa155 = "2.秋冬季" AND l_year1 = l_str1 THEN
         UPDATE aslr506_tmp 
            SET l_data = l_data + l_sum
          WHERE l_data_typ = "2.当季"
            AND l_count_typ = l_month1
            AND l_year = l_str1
            AND l_season = l_imaa155
         IF STATUS THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'update aslr506_tmp:'
            LET g_errparam.code   = STATUS
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET g_rep_success = 'N'
            EXIT FOREACH
         END IF
      END IF
      IF l_month >= 8 AND l_imaa155 = "2.秋冬季" AND l_year1 = l_str2 THEN
         UPDATE aslr506_tmp 
            SET l_data = l_data + l_sum
          WHERE l_data_typ = "2.当季"
            AND l_count_typ = l_month1
            AND l_year = l_str2
            AND l_season = l_imaa155
         IF STATUS THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'update aslr506_tmp:'
            LET g_errparam.code   = STATUS
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET g_rep_success = 'N'
            EXIT FOREACH
         END IF
      END IF
   END FOREACH 
   CLOSE aslr506_cur4_1
   LET l_sql = " SELECT mon,yea,imaa155,SUM(A)", 
               "   FROM (SELECT to_char(xmdkdocdt,'MM') mon,to_char(xmdkdocdt,'YYYY') yea,imaa154,imaa155,COALESCE(xmdl018,0) A",
               "           FROM rtaw_t,imaa_t,xmdl_t,xmdk_t",
               "          WHERE xmdlent = imaaent AND xmdl008 = imaa001",
               "            AND xmdkent = xmdlent AND xmdkdocno = xmdldocno AND xmdk000 = '6' AND xmdkstus IN ('Y','S')",
               "            AND ((xmdkdocdt BETWEEN to_date('",l_date4,"','yy/mm/dd') AND to_date('",l_date_2,"','yy/mm/dd')) OR (xmdkdocdt BETWEEN to_date('",l_date3,"','yy/mm/dd') AND to_date('",l_date_1,"','yy/mm/dd')))",
               "            AND imaaent = rtawent",
               "            AND imaa009 = rtaw002",
               "            AND imaa155 <> '0'",
               "            AND imaa154 = ",tm.year1-1,
               "            AND imaaent = ",g_enterprise,
               "            AND (",tm.wc,"))",
               "  GROUP BY mon,yea,imaa155"
   PREPARE aslr506_pre4_2 FROM l_sql
   DECLARE aslr506_cur4_2 CURSOR FOR aslr506_pre4_2
   FOREACH aslr506_cur4_2 INTO l_month,l_year1,l_imaa155,l_sum
      IF STATUS THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.code   = STATUS
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET g_rep_success = 'N'
         EXIT FOREACH
      END IF
      IF l_year1 = tm.year1 THEN LET l_year1 = l_str1 END IF
      IF l_year1 = tm.year1-1 THEN LET l_year1 = l_str2 END IF
      IF l_imaa155 = '1' THEN LET l_imaa155 = "1.春夏季" END IF
      IF l_imaa155 = '2' THEN LET l_imaa155 = "2.秋冬季" END IF
      CASE l_month
         WHEN 01  LET l_month1 = "1.一月"
         WHEN 02  LET l_month1 = "2.二月"
         WHEN 03  LET l_month1 = "3.三月"
         WHEN 04  LET l_month1 = "4.四月"
         WHEN 05  LET l_month1 = "5.五月"
         WHEN 06  LET l_month1 = "6.六月"
         WHEN 07  LET l_month1 = "7.七月"
         WHEN 08  LET l_month1 = "8.八月"
         WHEN 09  LET l_month1 = "9.九月"
         WHEN 10  LET l_month1 = "a.十月"
         WHEN 11  LET l_month1 = "b.十一月"
         WHEN 12  LET l_month1 = "c.十二月"
      END CASE
      IF l_month <= 3 AND l_imaa155 = "2.秋冬季" AND l_year1 = l_str1 THEN
         UPDATE aslr506_tmp 
            SET l_data = l_data - l_sum
          WHERE l_data_typ = "2.当季"
            AND l_count_typ = l_month1
            AND l_year = l_str1
            AND l_season = l_imaa155
         IF STATUS THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'update aslr506_tmp:'
            LET g_errparam.code   = STATUS
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET g_rep_success = 'N'
            EXIT FOREACH
         END IF
      END IF
      IF l_month >= 8 AND l_imaa155 = "2.秋冬季" AND l_year1 = l_str2 THEN
         UPDATE aslr506_tmp 
            SET l_data = l_data - l_sum
          WHERE l_data_typ = "2.当季"
            AND l_count_typ = l_month1
            AND l_year = l_str2
            AND l_season = l_imaa155
         IF STATUS THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'update aslr506_tmp:'
            LET g_errparam.code   = STATUS
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET g_rep_success = 'N'
            EXIT FOREACH
         END IF
      END IF
   END FOREACH 
   CLOSE aslr506_cur4_2
   LET l_sql = " SELECT mon,yea,imaa155,SUM(A)", 
               "   FROM (SELECT to_char(rtiadocdt,'MM') mon,to_char(rtiadocdt,'YYYY') yea,imaa154,imaa155,COALESCE(rtib012,0) A",
               "           FROM rtaw_t,imaa_t,rtib_t,rtia_t",
               "          WHERE rtibent = imaaent AND rtib004 = imaa001",
               "            AND rtiaent = rtibent AND rtiadocno = rtibdocno AND rtiastus = 'Y' ",
               "            AND ((rtiadocdt BETWEEN to_date('",l_date4,"','yy/mm/dd') AND to_date('",l_date_2,"','yy/mm/dd')) OR (rtiadocdt BETWEEN to_date('",l_date3,"','yy/mm/dd') AND to_date('",l_date_1,"','yy/mm/dd')))",
               "            AND imaaent = rtawent",
               "            AND imaa009 = rtaw002",
               "            AND imaa155 <> '0'",
               "            AND imaa154 = ",tm.year1-2,
               "            AND imaaent = ",g_enterprise,
               "            AND (",tm.wc,"))",
               "  GROUP BY mon,yea,imaa155"
   PREPARE aslr506_pre5 FROM l_sql
   DECLARE aslr506_cur5 CURSOR FOR aslr506_pre5
   FOREACH aslr506_cur5 INTO l_month,l_year1,l_imaa155,l_sum
      IF STATUS THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.code   = STATUS
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET g_rep_success = 'N'
         EXIT FOREACH
      END IF
      IF l_year1 = tm.year1 THEN LET l_year1 = l_str1 END IF
      IF l_year1 = tm.year1-1 THEN LET l_year1 = l_str2 END IF
      IF l_imaa155 = '1' THEN LET l_imaa155 = "1.春夏季" END IF
      IF l_imaa155 = '2' THEN LET l_imaa155 = "2.秋冬季" END IF
      CASE l_month
         WHEN 01  LET l_month1 = "1.一月"
         WHEN 02  LET l_month1 = "2.二月"
         WHEN 03  LET l_month1 = "3.三月"
         WHEN 04  LET l_month1 = "4.四月"
         WHEN 05  LET l_month1 = "5.五月"
         WHEN 06  LET l_month1 = "6.六月"
         WHEN 07  LET l_month1 = "7.七月"
         WHEN 08  LET l_month1 = "8.八月"
         WHEN 09  LET l_month1 = "9.九月"
         WHEN 10  LET l_month1 = "a.十月"
         WHEN 11  LET l_month1 = "b.十一月"
         WHEN 12  LET l_month1 = "c.十二月"
      END CASE
      IF l_month <= 3 AND l_imaa155 = "2.秋冬季" AND l_year1 = l_str2 THEN
         UPDATE aslr506_tmp 
            SET l_data = l_sum
          WHERE l_data_typ = "2.当季"
            AND l_count_typ = l_month1
            AND l_year = l_str2
            AND l_season = l_imaa155
         IF STATUS THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'update aslr506_tmp:'
            LET g_errparam.code   = STATUS
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET g_rep_success = 'N'
            EXIT FOREACH
         END IF
      END IF
   END FOREACH 
   CLOSE aslr506_cur5
   LET l_sql = " SELECT mon,yea,imaa155,SUM(A)", 
               "   FROM (SELECT to_char(xmdkdocdt,'MM') mon,to_char(xmdkdocdt,'YYYY') yea,imaa154,imaa155,COALESCE(xmdl018,0) A",
               "           FROM rtaw_t,imaa_t,xmdl_t,xmdk_t",
               "          WHERE xmdlent = imaaent AND xmdl008 = imaa001",
               "            AND xmdkent = xmdlent AND xmdkdocno = xmdldocno AND xmdk000 = '1' AND xmdkstus IN ('Y','S')",
               "            AND ((xmdkdocdt BETWEEN to_date('",l_date4,"','yy/mm/dd') AND to_date('",l_date_2,"','yy/mm/dd')) OR (xmdkdocdt BETWEEN to_date('",l_date3,"','yy/mm/dd') AND to_date('",l_date_1,"','yy/mm/dd')))",
               "            AND imaaent = rtawent",
               "            AND imaa009 = rtaw002",
               "            AND imaa155 <> '0'",
               "            AND imaa154 = ",tm.year1-2,
               "            AND imaaent = ",g_enterprise,
               "            AND (",tm.wc,"))",
               "  GROUP BY mon,yea,imaa155"
   PREPARE aslr506_pre5_1 FROM l_sql
   DECLARE aslr506_cur5_1 CURSOR FOR aslr506_pre5_1
   FOREACH aslr506_cur5_1 INTO l_month,l_year1,l_imaa155,l_sum
      IF STATUS THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.code   = STATUS
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET g_rep_success = 'N'
         EXIT FOREACH
      END IF
      IF l_year1 = tm.year1 THEN LET l_year1 = l_str1 END IF
      IF l_year1 = tm.year1-1 THEN LET l_year1 = l_str2 END IF
      IF l_imaa155 = '1' THEN LET l_imaa155 = "1.春夏季" END IF
      IF l_imaa155 = '2' THEN LET l_imaa155 = "2.秋冬季" END IF
      CASE l_month
         WHEN 01  LET l_month1 = "1.一月"
         WHEN 02  LET l_month1 = "2.二月"
         WHEN 03  LET l_month1 = "3.三月"
         WHEN 04  LET l_month1 = "4.四月"
         WHEN 05  LET l_month1 = "5.五月"
         WHEN 06  LET l_month1 = "6.六月"
         WHEN 07  LET l_month1 = "7.七月"
         WHEN 08  LET l_month1 = "8.八月"
         WHEN 09  LET l_month1 = "9.九月"
         WHEN 10  LET l_month1 = "a.十月"
         WHEN 11  LET l_month1 = "b.十一月"
         WHEN 12  LET l_month1 = "c.十二月"
      END CASE
      IF l_month <= 3 AND l_imaa155 = "2.秋冬季" AND l_year1 = l_str2 THEN
         UPDATE aslr506_tmp 
            SET l_data = l_data + l_sum
          WHERE l_data_typ = "2.当季"
            AND l_count_typ = l_month1
            AND l_year = l_str2
            AND l_season = l_imaa155
         IF STATUS THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'update aslr506_tmp:'
            LET g_errparam.code   = STATUS
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET g_rep_success = 'N'
            EXIT FOREACH
         END IF
      END IF
   END FOREACH 
   CLOSE aslr506_cur5_1
   LET l_sql = " SELECT mon,yea,imaa155,SUM(A)", 
               "   FROM (SELECT to_char(xmdkdocdt,'MM') mon,to_char(xmdkdocdt,'YYYY') yea,imaa154,imaa155,COALESCE(xmdl018,0) A",
               "           FROM rtaw_t,imaa_t,xmdl_t,xmdk_t",
               "          WHERE xmdlent = imaaent AND xmdl008 = imaa001",
               "            AND xmdkent = xmdlent AND xmdkdocno = xmdldocno AND xmdk000 = '6' AND xmdkstus IN ('Y','S')",
               "            AND ((xmdkdocdt BETWEEN to_date('",l_date4,"','yy/mm/dd') AND to_date('",l_date_2,"','yy/mm/dd')) OR (xmdkdocdt BETWEEN to_date('",l_date3,"','yy/mm/dd') AND to_date('",l_date_1,"','yy/mm/dd')))",
               "            AND imaaent = rtawent",
               "            AND imaa009 = rtaw002",
               "            AND imaa155 <> '0'",
               "            AND imaa154 = ",tm.year1-2,
               "            AND imaaent = ",g_enterprise,
               "            AND (",tm.wc,"))",
               "  GROUP BY mon,yea,imaa155"
   PREPARE aslr506_pre5_2 FROM l_sql
   DECLARE aslr506_cur5_2 CURSOR FOR aslr506_pre5_2
   FOREACH aslr506_cur5_2 INTO l_month,l_year1,l_imaa155,l_sum
      IF STATUS THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.code   = STATUS
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET g_rep_success = 'N'
         EXIT FOREACH
      END IF
      IF l_year1 = tm.year1 THEN LET l_year1 = l_str1 END IF
      IF l_year1 = tm.year1-1 THEN LET l_year1 = l_str2 END IF
      IF l_imaa155 = '1' THEN LET l_imaa155 = "1.春夏季" END IF
      IF l_imaa155 = '2' THEN LET l_imaa155 = "2.秋冬季" END IF
      CASE l_month
         WHEN 01  LET l_month1 = "1.一月"
         WHEN 02  LET l_month1 = "2.二月"
         WHEN 03  LET l_month1 = "3.三月"
         WHEN 04  LET l_month1 = "4.四月"
         WHEN 05  LET l_month1 = "5.五月"
         WHEN 06  LET l_month1 = "6.六月"
         WHEN 07  LET l_month1 = "7.七月"
         WHEN 08  LET l_month1 = "8.八月"
         WHEN 09  LET l_month1 = "9.九月"
         WHEN 10  LET l_month1 = "a.十月"
         WHEN 11  LET l_month1 = "b.十一月"
         WHEN 12  LET l_month1 = "c.十二月"
      END CASE
      IF l_month <= 3 AND l_imaa155 = "2.秋冬季" AND l_year1 = l_str2 THEN
         UPDATE aslr506_tmp 
            SET l_data = l_data - l_sum
          WHERE l_data_typ = "2.当季"
            AND l_count_typ = l_month1
            AND l_year = l_str2
            AND l_season = l_imaa155
         IF STATUS THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'update aslr506_tmp:'
            LET g_errparam.code   = STATUS
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET g_rep_success = 'N'
            EXIT FOREACH
         END IF
      END IF
   END FOREACH 
   CLOSE aslr506_cur5_2
   #计算销售累计
   LET l_merge_sum = " MERGE INTO aslr506_tmp O",
                     " USING ( SELECT l_data_typ,l_year,l_season,COALESCE(SUM(l_data),0) A
                                 FROM aslr506_tmp
                                GROUP BY l_data_typ,l_year,l_season) U",
                     " ON    (U.l_data_typ = O.l_data_typ",
                     "    AND U.l_year = O.l_year",
                     "    AND U.l_season = O.l_season",
                     "    AND O.l_count_typ = 'd.销售累计')",
                     " WHEN MATCHED THEN",
                     "    UPDATE SET O.l_data = U.A"
   PREPARE l_merge_sum_pb FROM l_merge_sum
   EXECUTE l_merge_sum_pb
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'l_merge_sum'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_rep_success = 'N'
   END IF
   #计算存量
   
   LET l_sql = "SELECT SUM(COALESCE(debn014,0)) ",
               "  FROM debn_t",
               " WHERE debnent = ",g_enterprise,
               "   AND debnsite = '",g_site,"'",
               "   AND debn002 = '",l_date1,"'",
               "   AND EXISTS (SELECT 1 FROM imaa_t,rtaw_t",
               "                WHERE imaaent = rtawent",
               "                  AND imaa009 = rtaw002",
               "                  AND imaa155 = '1'",
               "                  AND imaaent = ",g_enterprise,
               "                  AND imaa001 = debn005",
               "                  AND (",tm.wc,"))"
   
   PREPARE aslr506_pre_6 FROM l_sql 
   EXECUTE aslr506_pre_6 INTO l_debn014
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'aslr506_pre_6'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_rep_success = 'N'
   END IF
   UPDATE aslr506_tmp
      SET l_data = l_debn014
    WHERE l_data_typ = "1.总数"
      AND l_count_typ = "g.期末存量"
      AND l_year = l_str1
      AND l_season = "1.春夏季"
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'upd aslr506_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_rep_success = 'N'
   END IF
   LET l_sql = "SELECT COALESCE(SUM(debn014),0) ",
               "  FROM debn_t",
               " WHERE debnent = ",g_enterprise,
               "   AND debnsite = '",g_site,"'",
               "   AND debn002 = '",l_date1,"'",
               "   AND EXISTS (SELECT 1 FROM imaa_t,rtaw_t",
               "                WHERE imaaent=rtawent",
               "                  AND imaa009 = rtaw002",
               "                  AND imaa155 = '2'",
               "                  AND imaaent = ",g_enterprise,
               "                  AND (",tm.wc,"))"
   PREPARE aslr506_pre_7 FROM l_sql 
   EXECUTE aslr506_pre_7 INTO l_debn014
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'aslr506_pre_7'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_rep_success = 'N'
   END IF
   UPDATE aslr506_tmp
      SET l_data = l_debn014
    WHERE l_data_typ = "1.总数"
      AND l_count_typ = "g.期末存量"
      AND l_year = l_str1
      AND l_season = "2.秋冬季"
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'upd aslr506_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_rep_success = 'N'
   END IF
   LET l_sql = "SELECT COALESCE(SUM(debn014),0) ",
               "  FROM debn_t",
               " WHERE debnent = ",g_enterprise,
               "   AND debnsite = '",g_site,"'",
               "   AND debn002 = '",l_date2,"'",
               "   AND EXISTS (SELECT 1 FROM imaa_t,rtaw_t",
               "                WHERE imaaent=rtawent",
               "                  AND imaa009 = rtaw002",
               "                  AND imaa155 = '1'",
               "                  AND imaaent = ",g_enterprise,
               "                  AND imaa001 = debn005",
               "                  AND (",tm.wc,"))"
   PREPARE aslr506_pre_8 FROM l_sql 
   EXECUTE aslr506_pre_8 INTO l_debn014
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'aslr506_pre_8'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_rep_success = 'N'
   END IF
   UPDATE aslr506_tmp
      SET l_data = l_debn014
    WHERE l_data_typ = "1.总数"
      AND l_count_typ = "g.期末存量"
      AND l_year = l_str2
      AND l_season = "1.春夏季"
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'upd aslr506_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_rep_success = 'N'
   END IF
   LET l_sql = "SELECT COALESCE(SUM(debn014),0) ",
               "  FROM debn_t",
               " WHERE debnent = ",g_enterprise,
               "   AND debnsite = '",g_site,"'",
               "   AND debn002 = '",l_date2,"'",
               "   AND EXISTS (SELECT 1 FROM imaa_t,rtaw_t",
               "                WHERE imaaent=rtawent",
               "                  AND imaa009 = rtaw002",
               "                  AND imaa155 = '2'",
               "                  AND imaaent = ",g_enterprise,
               "                  AND imaa001 = debn005",
               "                  AND (",tm.wc,"))"          
   PREPARE aslr506_pre_9 FROM l_sql 
   EXECUTE aslr506_pre_9 INTO l_debn014
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'aslr506_pre_9'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_rep_success = 'N'
   END IF
   UPDATE aslr506_tmp
      SET l_data = l_debn014
    WHERE l_data_typ = "1.总数"
      AND l_count_typ = "g.期末存量"
      AND l_year = l_str2
      AND l_season = "2.秋冬季"
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'upd aslr506_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_rep_success = 'N'
   END IF
   LET l_sql = "SELECT COALESCE(SUM(debn014),0) ",
               "  FROM debn_t",
               " WHERE debnent = ",g_enterprise,
               "   AND debnsite = '",g_site,"'",
               "   AND debn002 = '",l_date1,"'",
               "   AND EXISTS (SELECT 1 FROM imaa_t,rtaw_t",
               "                WHERE imaaent=rtawent",
               "                  AND imaa009 = rtaw002",
               "                  AND imaa154 = '",tm.year1,"'",
               "                  AND imaa155 = '1'",
               "                  AND imaaent = ",g_enterprise,
               "                  AND imaa001 = debn005",
               "                  AND (",tm.wc,"))"
   
   PREPARE aslr506_pre_10 FROM l_sql
   EXECUTE aslr506_pre_10 INTO l_debn014
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'aslr506_pre_10'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_rep_success = 'N'
   END IF
   UPDATE aslr506_tmp
      SET l_data = l_debn014
    WHERE l_data_typ = "2.当季"
      AND l_count_typ = "g.期末存量"
      AND l_year = l_str1
      AND l_season = "1.春夏季"
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'upd aslr506_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_rep_success = 'N'
   END IF
   LET l_sql = "SELECT COALESCE(SUM(debn014),0) ",
               "  FROM debn_t",
               " WHERE debnent = ",g_enterprise,
               "   AND debnsite = '",g_site,"'",
               "   AND debn002 = '",l_date2,"'",
               "   AND EXISTS (SELECT 1 FROM imaa_t,rtaw_t",
               "                WHERE imaaent=rtawent",
               "                  AND imaa009 = rtaw002",
               "                  AND imaa154 = '",tm.year1-1,"'",
               "                  AND imaa155 = '1'",
               "                  AND imaaent = ",g_enterprise,
               "                  AND imaa001 = debn005",
               "                  AND (",tm.wc,"))"
   PREPARE aslr506_pre_11 FROM l_sql 
   EXECUTE aslr506_pre_11 INTO l_debn014
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'aslr506_pre_11'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_rep_success = 'N'
   END IF
   UPDATE aslr506_tmp
      SET l_data = l_debn014
    WHERE l_data_typ = "2.当季"
      AND l_count_typ = "g.期末存量"
      AND l_year = l_str2
      AND l_season = "1.春夏季"
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'upd aslr506_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_rep_success = 'N'
   END IF
   
   IF tm.mon >= 4 THEN
      LET l_sql = "SELECT COALESCE(SUM(debn014),0) ",
               "  FROM debn_t",
               " WHERE debnent = ",g_enterprise,
               "   AND debnsite = '",g_site,"'",
               "   AND debn002 = '",l_date1,"'",
               "   AND EXISTS (SELECT 1 FROM imaa_t,rtaw_t",
               "                WHERE imaaent=rtawent",
               "                  AND imaa009 = rtaw002",
               "                  AND imaa154 = '",tm.year1,"'",
               "                  AND imaa155 = '2'",
               "                  AND imaaent = ",g_enterprise,
               "                  AND imaa001 = debn005",
               "                  AND (",tm.wc,"))"
      PREPARE aslr506_pre_12 FROM l_sql 
      EXECUTE aslr506_pre_12 INTO l_debn014
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'aslr506_pre_12'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_rep_success = 'N'
      END IF
      UPDATE aslr506_tmp
         SET l_data = l_debn014
       WHERE l_data_typ = "2.当季"
         AND l_count_typ = "g.期末存量"
         AND l_year = l_str1
         AND l_season = "2.秋冬季"
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'upd aslr506_tmp'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_rep_success = 'N'
      END IF
   ELSE
      LET l_sql = "SELECT COALESCE(SUM(debn014),0) ",
               "  FROM debn_t",
               " WHERE debnent = ",g_enterprise,
               "   AND debnsite = '",g_site,"'",
               "   AND debn002 = '",l_date1,"'",
               "   AND EXISTS (SELECT 1 FROM imaa_t,rtaw_t",
               "                WHERE imaaent=rtawent",
               "                  AND imaa009 = rtaw002",
               "                  AND imaa154 = '",tm.year1-1,"'",
               "                  AND imaa155 = '2'",
               "                  AND imaaent = ",g_enterprise,
               "                  AND imaa001 = debn005",
               "                  AND (",tm.wc,"))"
      PREPARE aslr506_pre_13 FROM l_sql 
      EXECUTE aslr506_pre_13 INTO l_debn014
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'aslr506_pre_13'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_rep_success = 'N'
      END IF
      UPDATE aslr506_tmp
         SET l_data = l_debn014
       WHERE l_data_typ = "2.当季"
         AND l_count_typ = "g.期末存量"
         AND l_year = l_str1
         AND l_season = "2.秋冬季"
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'upd aslr506_tmp'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_rep_success = 'N'
      END IF
   END IF
  
   IF tm.mon >= 4 THEN
      LET l_sql = "SELECT COALESCE(SUM(debn014),0) ",
               "  FROM debn_t",
               " WHERE debnent = ",g_enterprise,
               "   AND debnsite = '",g_site,"'",
               "   AND debn002 = '",l_date2,"'",
               "   AND EXISTS (SELECT 1 FROM imaa_t,rtaw_t",
               "                WHERE imaaent=rtawent",
               "                  AND imaa009 = rtaw002",
               "                  AND imaa154 = '",tm.year1-1,"'",
               "                  AND imaa155 = '2'",
               "                  AND imaaent = ",g_enterprise,
               "                  AND imaa001 = debn005",
               "                  AND (",tm.wc,"))"
      PREPARE aslr506_pre_14 FROM l_sql 
      EXECUTE aslr506_pre_14 INTO l_debn014
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'aslr506_pre_14'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_rep_success = 'N'
      END IF
      UPDATE aslr506_tmp
         SET l_data = l_debn014
       WHERE l_data_typ = "2.当季"
         AND l_count_typ = "g.期末存量"
         AND l_year = l_str2
         AND l_season = "2.秋冬季"
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'upd aslr506_tmp'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_rep_success = 'N'
      END IF
   ELSE
      LET l_sql = "SELECT COALESCE(SUM(debn014),0) ",
               "  FROM debn_t",
               " WHERE debnent = ",g_enterprise,
               "   AND debnsite = '",g_site,"'",
               "   AND debn002 = '",l_date2,"'",
               "   AND EXISTS (SELECT 1 FROM imaa_t,rtaw_t",
               "                WHERE imaaent=rtawent",
               "                  AND imaa009 = rtaw002",
               "                  AND imaa154 = '",tm.year1-2,"'",
               "                  AND imaa155 = '2'",
               "                  AND imaaent = ",g_enterprise,
               "                  AND imaa001 = debn005",
               "                  AND (",tm.wc,"))"
      PREPARE aslr506_pre_15 FROM l_sql 
      EXECUTE aslr506_pre_15 INTO l_debn014
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'aslr506_pre_15'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_rep_success = 'N'
      END IF
      UPDATE aslr506_tmp
         SET l_data = l_debn014
       WHERE l_data_typ = "2.当季"
         AND l_count_typ = "g.期末存量"
         AND l_year = l_str2
         AND l_season = "2.秋冬季"
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'upd aslr506_tmp'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_rep_success = 'N'
      END IF
   END IF
   #计算合计
   LET l_merge_count = " MERGE INTO aslr506_tmp O",
                       " USING (SELECT l_data_typ,l_count_typ,l_year,COALESCE(SUM(l_data),0) A
                                  FROM aslr506_tmp
                                 GROUP BY l_data_typ,l_count_typ,l_year) U",
                       " ON   ( U.l_data_typ = O.l_data_typ" ,
                       "    AND U.l_count_typ = O.l_count_typ",
                       "    AND U.l_year = O.l_year",
                       "    AND O.l_season = '合计' )",
                       " WHEN MATCHED THEN",
                       "    UPDATE SET O.l_data = U.A"                       
   PREPARE l_merge_count_pb FROM l_merge_count
   EXECUTE l_merge_count_pb
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'l_merge_count'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_rep_success = 'N'
   END IF
   #计算过季
   LET l_merge_all = " MERGE INTO aslr506_tmp O",
                     " USING (SELECT a.l_count_typ l_count_typ,a.l_year l_year,a.l_season l_season,(COALESCE(a.l_data,0)-COALESCE(b.l_data,0)) A
                                FROM aslr506_tmp a,aslr506_tmp b
                               WHERE a.l_data_typ = '1.总数'
                                 AND b.l_data_typ = '2.当季'
                                 AND a.l_count_typ = b.l_count_typ
                                 AND a.l_year = b.l_year
                                 AND a.l_season = b.l_season) U",
                     " ON    (U.l_count_typ = O.l_count_typ",
                     "    AND U.l_year = O.l_year",
                     "    AND U.l_season = O.l_season",
                     "    AND O.l_data_typ = '3.过季')",
                     " WHEN MATCHED THEN",
                     "    UPDATE SET O.l_data = U.A"
   PREPARE l_merge_all_pb FROM l_merge_all
   EXECUTE l_merge_all_pb
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'l_merge_all'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_rep_success = 'N'
   END IF
   #计算成长率和差异数量
   LET l_merge_change = " MERGE INTO aslr506_tmp O",
                        " USING (SELECT a.l_data_typ l_data_typ,a.l_count_typ l_count_typ,(COALESCE(a.l_data,0)-COALESCE(b.l_data,0)) A
                                   FROM aslr506_tmp a,aslr506_tmp b
                                  WHERE a.l_data_typ = b.l_data_typ
                                    AND a.l_count_typ = b.l_count_typ
                                    AND a.l_season = b.l_season
                                    AND b.l_year = '",l_str2,"'
                                    AND a.l_year = '",l_str1,"'
                                    AND a.l_season = '合计') U",
                        " ON   ( U.l_data_typ = O.l_data_typ",
                        "    AND U.l_count_typ = O.l_count_typ",
                        "    AND O.l_year = '4.差异数量')",
                        " WHEN MATCHED THEN",
                        "    UPDATE SET O.l_data = U.A"
   PREPARE l_merge_change_pb FROM l_merge_change
   EXECUTE l_merge_change_pb
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'l_merge_change'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_rep_success = 'N'
   END IF
   LET l_merge_rant = " MERGE INTO aslr506_tmp O",
                      " USING (SELECT a.l_data_typ l_data_typ,b.l_count_typ l_count_typ,(COALESCE(a.l_data,0)/(CASE COALESCE(b.l_data, 0) WHEN 0 THEN 1 ELSE COALESCE(b.l_data, 0) END)*100) A
                                 FROM aslr506_tmp a,aslr506_tmp b
                                WHERE a.l_data_typ = b.l_data_typ
                                  AND a.l_count_typ = b.l_count_typ
                                  AND b.l_year = '",l_str2,"'
                                  AND b.l_season = '合计'
                                  AND a.l_year = '4.差异数量') U",
                      " ON    (U.l_data_typ = O.l_data_typ",
                      "    AND U.l_count_typ = O.l_count_typ",
                      "    AND O.l_year = '3.成长率%')",
                      " WHEN MATCHED THEN",
                      "    UPDATE SET O.l_data = U.A"
   PREPARE l_merge_rant_pb FROM l_merge_rant
   EXECUTE l_merge_rant_pb
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'l_merge_rant'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_rep_success = 'N'
   END IF
   #取得币种
   SELECT ooef016 INTO g_ooef016 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
   LET g_sql = " SELECT l_data_typ,l_count_typ,l_year,l_season,l_data FROM aslr506_tmp"
   #end add-point
   PREPARE aslr506_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE aslr506_x01_curs CURSOR FOR aslr506_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="aslr506_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION aslr506_x01_ins_data()
DEFINE sr RECORD 
   l_date_type LIKE type_t.chr100, 
   l_sum_type LIKE type_t.chr100, 
   l_year_sys LIKE type_t.chr100, 
   l_season_sys LIKE type_t.chr100, 
   l_data_sys LIKE type_t.num20_6
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH aslr506_x01_curs INTO sr.*                               
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
       IF sr.l_year_sys = "3.成长率%" THEN
          CALL s_curr_round(g_site,g_ooef016,sr.l_data_sys,'2') RETURNING sr.l_data_sys
       END IF
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.l_date_type,sr.l_sum_type,sr.l_year_sys,sr.l_season_sys,sr.l_data_sys
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "aslr506_x01_execute"
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
    DROP TABLE aslr506_tmp
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aslr506_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION aslr506_x01_rep_data()
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
 
{<section id="aslr506_x01.other_function" readonly="Y" >}

 
{</section>}
 
