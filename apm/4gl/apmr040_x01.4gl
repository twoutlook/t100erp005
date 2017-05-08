#該程式未解開Section, 採用最新樣板產出!
{<section id="apmr040_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:4(2015-11-06 15:00:32), PR版次:0004(2015-11-11 17:39:43)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000069
#+ Filename...: apmr040_x01
#+ Description: ...
#+ Creator....: 05423(2014-12-12 11:05:03)
#+ Modifier...: 06815 -SD/PR- 06815
 
{</section>}
 
{<section id="apmr040_x01.global" readonly="Y" >}
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
       year1 STRING,                  #基準年 
       mont1 STRING,                  #基準月 
       year2 STRING,                  #起始年 
       mont2 STRING,                  #起始月 
       year3 STRING,                  #截止年 
       mont3 STRING,                  #截止月 
       min STRING,                  #扣除退貨數量 
       rang STRING                   #降價率列印範
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE l_where       STRING
#end add-point
 
{</section>}
 
{<section id="apmr040_x01.main" readonly="Y" >}
PUBLIC FUNCTION apmr040_x01(p_arg1,p_arg2,p_arg3,p_arg4,p_arg5,p_arg6,p_arg7,p_arg8,p_arg9)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 STRING                  #tm.year1  基準年 
DEFINE  p_arg3 STRING                  #tm.mont1  基準月 
DEFINE  p_arg4 STRING                  #tm.year2  起始年 
DEFINE  p_arg5 STRING                  #tm.mont2  起始月 
DEFINE  p_arg6 STRING                  #tm.year3  截止年 
DEFINE  p_arg7 STRING                  #tm.mont3  截止月 
DEFINE  p_arg8 STRING                  #tm.min  扣除退貨數量 
DEFINE  p_arg9 STRING                  #tm.rang  降價率列印範
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.year1 = p_arg2
   LET tm.mont1 = p_arg3
   LET tm.year2 = p_arg4
   LET tm.mont2 = p_arg5
   LET tm.year3 = p_arg6
   LET tm.mont3 = p_arg7
   LET tm.min = p_arg8
   LET tm.rang = p_arg9
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "apmr040_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL apmr040_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL apmr040_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL apmr040_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL apmr040_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL apmr040_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="apmr040_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION apmr040_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "pmdt006.pmdt_t.pmdt006,imaal_t_imaal003.imaal_t.imaal003,imaal_t_imaal004.imaal_t.imaal004,pmdt007.pmdt_t.pmdt007,imaa_t_imaa009.imaa_t.imaa009,l_imaa009_desc.type_t.chr30,l_imaa127.type_t.chr30,l_imaa127_desc.type_t.chr50,l_imaa127desc.type_t.chr80,pmds002.pmds_t.pmds002,l_pmds002_desc.type_t.chr30,l_year1.type_t.chr20,l_price1.type_t.num20_6,l_avgprice.type_t.num20_6,l_amount.type_t.num20_6,l_value.type_t.num20_6,l_value1.type_t.num20_6,l_minvalue.type_t.num20_6,l_minrate.type_t.num20_6,pmds037.pmds_t.pmds037" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="apmr040_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION apmr040_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="apmr040_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apmr040_x01_sel_prep()
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
   #151106-00004#8 20151111 s983961--MOD--imaa127,oocql004,trim(imaa127)||'.'||trim(oocql004) (S)
   #LET g_select = " SELECT DISTINCT pmdt006,imaal_t.imaal003,imaal_t.imaal004,pmdt007,imaa_t.imaa009,rtaxl003,NULL,NULL,NULL,pmds002, 
   #    (trim(pmds002)||'.'||trim(ooag011)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,pmds037"
    
   LET g_select = " SELECT DISTINCT pmdt006,imaal_t.imaal003,imaal_t.imaal004,pmdt007,imaa_t.imaa009,rtaxl003,imaa127,oocql004,trim(imaa127)||'.'||trim(oocql004),
                    pmds002,(trim(pmds002)||'.'||trim(ooag011)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,pmds037"   
  #151106-00004#8 20151111 s983961--MOD--imaa127,oocql004,trim(imaa127)||'.'||trim(oocql004) (E)                    
#   #end add-point
#   LET g_select = " SELECT pmdt006,imaal_t.imaal003,imaal_t.imaal004,pmdt007,imaa_t.imaa009,NULL,NULL, 
#       NULL,NULL,pmds002,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,pmds037"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
    LET g_from = " FROM pmds_t LEFT OUTER JOIN pmdt_t ON pmdsent = pmdtent AND pmdsdocno = pmdtdocno ",
                 "             LEFT OUTER JOIN ooag_t ON pmds002 = ooag001 AND pmdsent = ooagent ",
                 "             LEFT OUTER JOIN imaa_t ON pmdt006 = imaa001 AND pmdtent = imaaent ",
                 "             LEFT OUTER JOIN oocql_t ON oocqlent = pmdtent AND oocql001 = '2003' AND oocql002 = imaa127 AND oocql003 = '",g_dlang,"' ",  #151106-00004#8 20151111 s983961--add(S)
                 "             LEFT OUTER JOIN pmaa_t ON pmds007 = pmaa001 AND pmdsent = pmaaent ",
                 "             LEFT OUTER JOIN imaal_t ON pmdt006 = imaal001 AND pmdtent = imaalent AND imaal002 = '",g_dlang,"' ",
                 "             LEFT OUTER JOIN rtaxl_t ON imaa009 = rtaxl001 AND imaaent = rtaxlent AND rtaxl002 = '",g_dlang,"' "
         
#   #end add-point
#    LET g_from = " FROM pmds_t,pmdt_t,imaa_t,imaal_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
    IF tm.mont3!='12' THEN
      LET g_where = " WHERE " ,tm.wc CLIPPED," AND pmds000 IN ('3','4','6') AND pmdsstus = 'S' AND pmdsdocdt >= '",MDY(tm.mont2,'01',tm.year2) CLIPPED,"' 
      AND pmdsdocdt < ('",MDY(tm.mont3+1,'01',tm.year3) CLIPPED,"') "
    ELSE
      LET g_where = " WHERE " ,tm.wc CLIPPED," AND pmds000 IN ('3','4','6') AND pmdsstus = 'S' AND pmdsdocdt >= '",MDY(tm.mont2,'01',tm.year2) CLIPPED,"' 
      AND pmdsdocdt < ('",MDY('01','01',tm.year3+1) CLIPPED,"') "
    END IF

#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("pmds_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET l_where = g_from CLIPPED," ",g_where CLIPPED
   #end add-point
   PREPARE apmr040_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE apmr040_x01_curs CURSOR FOR apmr040_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="apmr040_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION apmr040_x01_ins_data()
DEFINE sr RECORD 
   pmdt006 LIKE pmdt_t.pmdt006, 
   imaal_t_imaal003 LIKE imaal_t.imaal003, 
   imaal_t_imaal004 LIKE imaal_t.imaal004, 
   pmdt007 LIKE pmdt_t.pmdt007, 
   imaa_t_imaa009 LIKE imaa_t.imaa009, 
   l_imaa009_desc LIKE type_t.chr30, 
   l_imaa127 LIKE type_t.chr30, 
   l_imaa127_desc LIKE type_t.chr50, 
   l_imaa127desc LIKE type_t.chr80, 
   pmds002 LIKE pmds_t.pmds002, 
   l_pmds002_desc LIKE type_t.chr30, 
   l_year1 LIKE type_t.chr20, 
   l_price1 LIKE type_t.num20_6, 
   l_avgprice LIKE type_t.num20_6, 
   l_amount LIKE type_t.num20_6, 
   l_value LIKE type_t.num20_6, 
   l_value1 LIKE type_t.num20_6, 
   l_minvalue LIKE type_t.num20_6, 
   l_minrate LIKE type_t.num20_6, 
   pmds037 LIKE pmds_t.pmds037
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE r_success  LIKE type_t.chr2
DEFINE l_sql      STRING
DEFINE l_cnt   LIKE type_t.num10
DEFINE l_year1  LIKE type_t.num10
DEFINE l_month1 LIKE type_t.num10
DEFINE l_year2  LIKE type_t.chr20
DEFINE l_month2 LIKE type_t.chr20

DEFINE l_range  LIKE type_t.num20_6

DEFINE l_date1 LIKE type_t.dat
DEFINE l_date2 LIKE type_t.dat
DEFINE l_bdate LIKE type_t.dat
DEFINE l_edate LIKE type_t.dat

DEFINE   l_amount LIKE type_t.num20_6 
DEFINE   l_value  LIKE type_t.num20_6
DEFINE   l_minrate LIKE type_t.num20_6
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
       LET l_bdate = MDY(tm.mont2,'01',tm.year2)
       IF tm.mont3 != 12 THEN
          LET l_edate = MDY(tm.mont3+1,'01',tm.year3)
       ELSE 
          LET l_edate = MDY('01','01',tm.year3+1)
       END IF

       

       LET l_range = tm.rang
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH apmr040_x01_curs INTO sr.*                               
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
       #151106-00004#8 20151111 s983961--MARK(S)
       ##系列   dorislai-20150820 add  (S)
       #   #用料號抓取系列
       #SELECT imaa127 INTO sr.l_imaa127 FROM imaa_t
       # WHERE imaa001 = sr.pmdt006
       #   AND imaaent = g_enterprise
          #抓取系列說明
       #CALL s_desc_get_acc_desc('2003',sr.l_imaa127)  RETURNING sr.l_imaa127_desc   
       #IF NOT cl_null(sr.l_imaa127_desc) THEN
       #   LET sr.l_imaa127desc = sr.l_imaa127,'.',sr.l_imaa127_desc 
       #ELSE
       #   LET sr.l_imaa127desc = ''
       #END IF
       ##       dorislai-20150820 add  (E)
       #151106-00004#8 20151111 s983961--MARK(E)
       LET l_year1 = tm.year1 USING '<<<<'
       LET l_month1 = tm.mont1 USING '<<'
       #2015-4-24 zj add 数值初始化--(S)
       LET l_amount = 0
       LET l_value = 0
       LET l_minrate = 0
       #2015-4-24 zj add 数值初始化--(E)
#       CALL s_feature_description(sr.pmdt006,sr.pmdt007) RETURNING r_success,sr.pmdt007
       IF cl_null(sr.pmds002) THEN
         LET sr.l_pmds002_desc = NULL
       END IF
       IF cl_null(sr.pmdt007) THEN
         LET sr.pmdt007 = ' '
       END IF

       #期間平均單價=第1點的資料且入庫日期於分析起始年月與分析截止年月間的平均單價(pmdt036)
       #期間收貨數量=第1點的資料且入庫日期於分析起始年月與分析截止年月間的入庫數量加總
       #期間收貨金額=第1點的資料且入庫日期於分析起始年月與分析截止年月間的含稅金額加總
       IF cl_null(sr.pmds037) THEN
         LET l_sql = "SELECT AVG(pmdt036),SUM(pmdt020),SUM(pmdt039) " CLIPPED ,
                   " FROM pmds_t LEFT OUTER JOIN pmdt_t ON pmdsent = pmdtent AND pmdsdocno = pmdtdocno ",
                   " WHERE ", tm.wc CLIPPED ," AND pmds000 IN ('3','4','6') AND pmdsstus = 'S' ",
                   " AND pmdsdocdt>= ? AND pmdsdocdt< ? AND pmdt006 = ? AND pmds002 = ? AND pmds037 IS NULL AND pmdt007 = ? ",
                   " GROUP BY pmdt006 "
       ELSE
         LET l_sql = "SELECT AVG(pmdt036),SUM(pmdt020),SUM(pmdt039) " CLIPPED ,
                   " FROM pmds_t LEFT OUTER JOIN pmdt_t ON pmdsent = pmdtent AND pmdsdocno = pmdtdocno ",
                   " WHERE ", tm.wc CLIPPED ," AND pmds000 IN ('3','4','6') AND pmdsstus = 'S' ",
                   " AND pmdsdocdt>= ? AND pmdsdocdt< ? AND pmdt006 = ? AND pmds002 = ? AND pmds037 = ? AND pmdt007 = ? ",
                   " GROUP BY pmdt006 "
       END IF
       PREPARE apmr040_x01_pre2 FROM l_sql
       DECLARE apmr040_x01_cur2 CURSOR FOR apmr040_x01_pre2
       #主畫面"扣除退貨數量金額"="Y"時，
       #期間收貨數量、期間收貨金額需扣除倉退資料(單據性質='7.倉退單')
       IF tm.min = 'Y' THEN
         IF cl_null(sr.pmds037) THEN
            LET l_sql = "SELECT SUM(pmdt020),SUM(pmdt039) " CLIPPED ,
                     " FROM pmds_t LEFT OUTER JOIN pmdt_t ON pmdsent = pmdtent AND pmdsdocno = pmdtdocno ",
                     " WHERE ",tm.wc CLIPPED," AND pmds000 = '7' AND pmdsstus = 'S'  ",
                     " AND pmdsdocdt>= ? AND pmdsdocdt< ? AND pmdt006 = ? AND pmds002 = ? AND pmds037 IS NULL AND pmdt007 = ? ",                    
                     " GROUP BY pmdt006 "
         ELSE
            LET l_sql = "SELECT SUM(pmdt020),SUM(pmdt039) " CLIPPED ,
                     " FROM pmds_t LEFT OUTER JOIN pmdt_t ON pmdsent = pmdtent AND pmdsdocno = pmdtdocno ",
                     " WHERE ",tm.wc CLIPPED," AND pmds000 = '7' AND pmdsstus = 'S'  ",
                     " AND pmdsdocdt>= ? AND pmdsdocdt< ? AND pmdt006 = ? AND pmds002 = ? AND pmds037 = ? AND pmdt007 = ? ",                    
                     " GROUP BY pmdt006 "
         END IF        
         PREPARE apmr040_x01_pre3 FROM l_sql
         DECLARE apmr040_x01_cur3 CURSOR FOR apmr040_x01_pre3
       END IF

       FOR l_cnt = l_month1 TO 12
         LET l_year2 = l_year1
         LET l_month2 = l_month1
         LET l_date1 = MDY(l_month1,'01',l_year1)
         IF l_month1 != 12 THEN
            LET l_date2 = MDY(l_month1+1,'01',l_year1)
         ELSE 
            LET l_date2 = MDY('1','01',l_year1+1)
         END IF



         #資料抓取收貨/入庫單頭檔(pmds_t)單據性質='3.收貨入庫單,4.無採購收貨入庫單,6.入庫單'的符合條件入庫資料
         #基準單價=第1點的資料且入庫日期於基準年月的平均單價(pmdt036)
         #如抓不到單價則往後抓最接近的一筆，基準年月也需依抓到的一筆的年月為準
         IF cl_null(sr.pmds037) THEN
            LET l_sql = "SELECT AVG(pmdt036) " CLIPPED ,
                     " FROM pmds_t LEFT OUTER JOIN pmdt_t ON pmdsent = pmdtent AND pmdsdocno = pmdtdocno ",
                     " WHERE ", tm.wc CLIPPED ," AND pmds000 IN ('3','4','6') AND pmdsstus = 'S' ",
                     " AND pmdsdocdt>= '",l_date1,"' AND pmdsdocdt< '",l_date2,"' AND pmdt006 = '",sr.pmdt006,"'  AND pmds002 = '",sr.pmds002,"' AND pmds037 IS NULL ",
                     " AND pmdt007 = ' ",sr.pmdt007 CLIPPED ,"' "
         ELSE
            LET l_sql = "SELECT AVG(pmdt036) " CLIPPED ,
                     " FROM pmds_t LEFT OUTER JOIN pmdt_t ON pmdsent = pmdtent AND pmdsdocno = pmdtdocno ",
                     " WHERE ", tm.wc CLIPPED ," AND pmds000 IN ('3','4','6') AND pmdsstus = 'S' ",
                     " AND pmdsdocdt>= '",l_date1,"' AND pmdsdocdt< '",l_date2,"' AND pmdt006 = '",sr.pmdt006,"'  AND pmds002 = '",sr.pmds002,"' AND pmds037 = '",sr.pmds037,"' ",
                     " AND pmdt007 = ' ",sr.pmdt007 CLIPPED ,"' "
         END IF

         PREPARE apmr040_x01_pre1 FROM l_sql
         DECLARE apmr040_x01_cur1 CURSOR FOR apmr040_x01_pre1
         EXECUTE apmr040_x01_cur1 INTO sr.l_price1    #基準單價
         
         IF NOT cl_null(sr.l_price1) THEN
            LET sr.l_year1 = l_year1 CLIPPED,'/',l_month1 CLIPPED   #基準年月
            EXIT FOR
         END IF
         IF l_month1 = 12 THEN
            LET l_year1 = l_year1 + 1
            LET l_month1 = 0
            LET l_cnt = 0
         END IF
         IF (l_month1>MONTH(g_today) AND l_year1 = YEAR(g_today)) OR (l_year1 > YEAR(g_today) )THEN
            EXIT FOR
         END IF
         LET l_month1 = l_month1 + 1

       END FOR
       IF cl_null(sr.pmds037) THEN
         OPEN apmr040_x01_cur2 USING l_bdate,l_edate,sr.pmdt006,sr.pmds002,sr.pmdt007
       ELSE
         OPEN apmr040_x01_cur2 USING l_bdate,l_edate,sr.pmdt006,sr.pmds002,sr.pmds037,sr.pmdt007
       END IF
       EXECUTE apmr040_x01_cur2 INTO sr.l_avgprice,sr.l_amount,sr.l_value   #期間平均單價、期間收貨數量、期間收貨金額
    
       IF tm.min = 'Y' THEN
         IF cl_null(sr.pmds037) THEN
            OPEN apmr040_x01_cur3 USING l_bdate,l_edate,sr.pmdt006,sr.pmds002,sr.pmdt007
         ELSE   
            OPEN apmr040_x01_cur3 USING l_bdate,l_edate,sr.pmdt006,sr.pmds002,sr.pmds037,sr.pmdt007
         END IF
         EXECUTE apmr040_x01_cur3 INTO l_amount,l_value
         IF NOT cl_null(l_amount) THEN
            LET sr.l_amount = sr.l_amount - l_amount
         END IF
         IF NOT cl_null(l_amount) THEN
            LET sr.l_value = sr.l_value - l_value
         END IF
         
       END IF
         
       LET sr.l_value1 = sr.l_price1 * sr.l_amount
       LET sr.l_minvalue = (sr.l_price1 - sr.l_avgprice)*sr.l_amount
       LET sr.l_minrate = sr.l_minvalue/sr.l_value1
       
       LET l_minrate = sr.l_minrate * 100       
       IF l_range <> 0 AND (l_minrate > l_range OR l_minrate < l_range*(-1) )THEN
         INITIALIZE sr.* TO NULL
         CONTINUE FOREACH
       END IF
       
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.pmdt006,sr.imaal_t_imaal003,sr.imaal_t_imaal004,sr.pmdt007,sr.imaa_t_imaa009,sr.l_imaa009_desc,sr.l_imaa127,sr.l_imaa127_desc,sr.l_imaa127desc,sr.pmds002,sr.l_pmds002_desc,sr.l_year1,sr.l_price1,sr.l_avgprice,sr.l_amount,sr.l_value,sr.l_value1,sr.l_minvalue,sr.l_minrate,sr.pmds037
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "apmr040_x01_execute"
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
 
{<section id="apmr040_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION apmr040_x01_rep_data()
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
 
{<section id="apmr040_x01.other_function" readonly="Y" >}

 
{</section>}
 
