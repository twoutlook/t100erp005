#該程式未解開Section, 採用最新樣板產出!
{<section id="aimr140_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:4(2016-08-01 17:05:56), PR版次:0004(2016-08-01 17:08:19)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000029
#+ Filename...: aimr140_x01
#+ Description: ...
#+ Creator....: 05423(2016-04-18 10:10:50)
#+ Modifier...: 05423 -SD/PR- 05423
 
{</section>}
 
{<section id="aimr140_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#160523-00001#1   2016/06/12 By zhujing   1.檢核項目.變動生產前置時間="Y"時，區間變動生產前置時間=抓取符合QBE條件及基準日期區間的已結案工單(生管結案或成本結案).單據日期，分料號取出單據日期最大的工單，再依工單找出"已確認或已過帳"且確認日期最大的入庫單
#                                         2.檢核項目.生產損耗率 = "Y"時，區間生產損耗率 = 抓取符合QBE條件及基準日期區間的已結案工單(生管結案或成本結案+已發料套數>0).單據日期
#160708-00006#1   2016/07/11 By zhujing   1. 規格中所有工單的結案類型都改為 生管結案 或 成本結案 2. 更細化公式計算方式(請重新檢視每個項目)
#160708-00005#1   2016/08/01 By zhujing   檢核項目: 生產損耗率 公式是 1- (加總已入庫合格量 / 加總已發料套數) 其中已發料套數應該要拿sfaa049，目前是拿生產數量sfaa12

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
       bdate LIKE type_t.dat,         #bdate 
       edate LIKE type_t.dat,         #edate 
       pr1 LIKE type_t.chr2,         #生產損耗率 
       rate1 LIKE type_t.num5,         #差異比率 
       pr2 LIKE type_t.chr2,         #生產單位批量 
       rate2 LIKE type_t.num5,         #差異比率 
       pr3 LIKE type_t.chr2,         #最小生產數量 
       rate3 LIKE type_t.num5,         #差异比率 
       pr4 LIKE type_t.chr2,         #工單拆分批量 
       show LIKE type_t.chr2,         #拆分批量為0 
       rate4 LIKE type_t.num5,         #差異比率 
       pr5 LIKE type_t.chr2,         #變動生產前置 
       day1 LIKE type_t.num15_3,         #差異天數 
       pr6 LIKE type_t.chr2,         #QC前置時間 
       day2 LIKE type_t.num15_3          #差異天數
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE l_datetype   STRING
#end add-point
 
{</section>}
 
{<section id="aimr140_x01.main" readonly="Y" >}
PUBLIC FUNCTION aimr140_x01(p_arg1,p_arg2,p_arg3,p_arg4,p_arg5,p_arg6,p_arg7,p_arg8,p_arg9,p_arg10,p_arg11,p_arg12,p_arg13,p_arg14,p_arg15,p_arg16)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.dat         #tm.bdate  bdate 
DEFINE  p_arg3 LIKE type_t.dat         #tm.edate  edate 
DEFINE  p_arg4 LIKE type_t.chr2         #tm.pr1  生產損耗率 
DEFINE  p_arg5 LIKE type_t.num5         #tm.rate1  差異比率 
DEFINE  p_arg6 LIKE type_t.chr2         #tm.pr2  生產單位批量 
DEFINE  p_arg7 LIKE type_t.num5         #tm.rate2  差異比率 
DEFINE  p_arg8 LIKE type_t.chr2         #tm.pr3  最小生產數量 
DEFINE  p_arg9 LIKE type_t.num5         #tm.rate3  差异比率 
DEFINE  p_arg10 LIKE type_t.chr2         #tm.pr4  工單拆分批量 
DEFINE  p_arg11 LIKE type_t.chr2         #tm.show  拆分批量為0 
DEFINE  p_arg12 LIKE type_t.num5         #tm.rate4  差異比率 
DEFINE  p_arg13 LIKE type_t.chr2         #tm.pr5  變動生產前置 
DEFINE  p_arg14 LIKE type_t.num15_3         #tm.day1  差異天數 
DEFINE  p_arg15 LIKE type_t.chr2         #tm.pr6  QC前置時間 
DEFINE  p_arg16 LIKE type_t.num15_3         #tm.day2  差異天數
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.bdate = p_arg2
   LET tm.edate = p_arg3
   LET tm.pr1 = p_arg4
   LET tm.rate1 = p_arg5
   LET tm.pr2 = p_arg6
   LET tm.rate2 = p_arg7
   LET tm.pr3 = p_arg8
   LET tm.rate3 = p_arg9
   LET tm.pr4 = p_arg10
   LET tm.show = p_arg11
   LET tm.rate4 = p_arg12
   LET tm.pr5 = p_arg13
   LET tm.day1 = p_arg14
   LET tm.pr6 = p_arg15
   LET tm.day2 = p_arg16
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   #抓取環境變數
   IF FGL_GETENV("DBDATE") ='Y2MD/' THEN
      LET l_datetype = 'yy/mm/dd'
   ELSE
      LET l_datetype = 'yyyy/mm/dd'
   END IF
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "aimr140_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL aimr140_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL aimr140_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL aimr140_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL aimr140_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL aimr140_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="aimr140_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION aimr140_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "imaa001.imaa_t.imaa001,l_imaal003.imaal_t.imaal003,l_imaal004.imaal_t.imaal004,imaa009.imaa_t.imaa009,l_imaa009_desc.rtaxl_t.rtaxl003,imaa003.imaa_t.imaa003,l_imaa003_desc.oocql_t.oocql004,imae011.imae_t.imae011,l_imae011_desc.oocql_t.oocql004,imae012.imae_t.imae012,l_imae012_desc.ooag_t.ooag011,imae016.imae_t.imae016,l_imae016_desc.oocal_t.oocal003,l_chk_item.oocql_t.oocql004,l_cur_set.type_t.num15_3,l_act_set.type_t.num15_3" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="aimr140_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION aimr140_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="aimr140_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aimr140_x01_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define(客製用) name="sel_prep.define_customerization"

#end add-point
#add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
DEFINE l_sql         STRING
#end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
 
   #add-point:sel_prep g_select name="sel_prep.g_select"
   LET g_select = " SELECT DISTINCT imaa001,imaal003,imaal004,imaa009,rtaxl004,imaa003,a.oocql004,imae011,b.oocql004,imae012,ooag011,imae016, 
       oocal003,NULL,NULL,NULL"
#   #end add-point
#   LET g_select = " SELECT imaa001,NULL,NULL,imaa009,NULL,imaa003,NULL,imae011,NULL,imae012,NULL,imae016, 
#       NULL,NULL,NULL,NULL"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_from = " FROM imaa_t LEFT OUTER JOIN imaal_t ON imaal001 = imaa001 AND imaalent = imaaent AND imaal002 = '",g_dlang,"' ",
                "             LEFT OUTER JOIN imae_t ON imae001 = imaa001 AND imaeent = imaaent ",
                "             LEFT OUTER JOIN rtaxl_t ON rtaxl001 = imaa009 AND rtaxlent = imaaent AND rtaxl002 = '",g_dlang,"' ",
                "             LEFT OUTER JOIN oocql_t a ON a.oocqlent = imaaent AND a.oocql001 = '200' AND a.oocql002 = imaa003 AND a.oocql003 = '",g_dlang,"' ",
                "             LEFT OUTER JOIN oocql_t b ON b.oocqlent = imaaent AND b.oocql001 = '204' AND b.oocql002 = imae011 AND b.oocql003 = '",g_dlang,"' ",
                "             LEFT OUTER JOIN ooag_t ON ooag001 = imae012 AND ooagent = imaaent ",
                "             LEFT OUTER JOIN oocal_t ON oocal001 = imae016 AND oocalent = imaeent AND oocal002 = '",g_dlang,"' "
#   #end add-point
#    LET g_from = " FROM imaa_t,imae_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
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
   #检核项目：
   #1.檢核項目.生產損耗率 = "Y"時，#imae015
   #1-1.區間生產損耗率 = 抓取符合QBE條件及基準日期區間的已結案工單(生管結案+已發料套數>0).單據日期，分料號sfaa010計算 sfaa003<>'3' sfaastus = 'C' sfaa049>0
   #1-1-1.計算方式: 1- (加總已入庫合格量sfaa050 / 加總生產數量sfaa012)
   #1-1-2.計算說明: 如果工單的生產單位和料件據點資料檔.生產單位imae016不同時，應先轉換回料件生產單位再進行計算
   #160523-00001#1 2.檢核項目.生產損耗率 = "Y"時，區間生產損耗率 = 抓取符合QBE條件及基準日期區間的已結案工單(生管結案或成本結案+已發料套數>0).單據日期
   
   #160708-00006#1   add-S
#   1.檢核項目.生產損耗率 = "Y"時，
#  1-1.區間生產損耗率 = 抓取符合QBE條件及基準日期區間的已結案工單(生管結案或成本結案+已發料套數>0).單據日期，分料號計算
#      1-1-1.計算方式: 1- (加總已入庫合格量 / 加總已發料套數) 
#      1-1-2.計算說明: 如果工單的生產單位和料件據點資料檔.生產單位imae016不同時，應先轉換回料件生產單位再進行計算
#
#  1-2.目前設定生產損耗率 = 料件據點資料檔.生產損耗率(imae015)
#
#  1-3.生產損耗率 與 區間生產損耗率 的差異 超過 ±報表設定的差異比率 才顯示
#    1-3-1 舉例1: 本次報表設定的差異比率為10%
#                 料號的imae015 = 0%，本次計算出來的區間生產損耗率 為 0.167 (相當於16.7%)，
#                 (0% - 16.7%) < -10% 所以這筆資料應該要產生異常報表
#    1-3-2 舉例2: 本次報表設定的差異比率為10%
#                 料號的imae015 = 30%，本次計算出來的區間生產損耗率 為 0.167 (相當於16.7%)，
#                 (30% - 16.7%) > 10% 所以這筆資料應該要產生異常報表
#
   #160708-00006#1   add-E
   IF tm.pr1 = 'Y' THEN
#      LET l_sql = " SELECT SUM(sfaa050),SUM(sfaa012),sfaa013 ",  #160708-00005#1 mod
      LET l_sql = " SELECT SUM(sfaa050),SUM(sfaa049),sfaa013 ",   #160708-00005#1 mod
                  " FROM sfaa_t ",
                  " WHERE sfaaent = ",g_enterprise,
                  "   AND sfaasite = '",g_site,"' ",
                  "   AND sfaa003 <> '3' ",
#                  "   AND sfaastus = 'C' ", #160523-00001#1 mod
                  "   AND (sfaastus = 'M' OR sfaa065 IN ('1','2')) ",  #160523-00001#1 mod
                  "   AND sfaa049 > 0 ",
                  "   AND sfaa010 = ? ",
                  "   AND (sfaadocdt BETWEEN to_date('",tm.bdate,"','",l_datetype CLIPPED,"') AND to_date('",tm.edate,"','",l_datetype CLIPPED,"') )",
                  "   GROUP BY sfaa010,sfaa013 ",
                  "   ORDER BY sfaa010,sfaa013 "
      PREPARE aimr140_x01_imae015_pre FROM l_sql
      DECLARE aimr140_x01_imae015_cur CURSOR FOR aimr140_x01_imae015_pre
   END IF
   #2.檢核項目.生產單位批量 = "Y"時，
   # 2-1. 區間生產單位批量 = 抓取符合QBE條件及基準日期區間的已結案工單(生管結案).單據日期，分料號取出最小生產數量
   #      2-1-1.計算說明: 如果工單的生產單位和料件據點資料檔.生產單位imae016不同時，應先轉換回料件生產單位再取最小生產數量
   # 2-2.目前設定的生產單位批量 = 料件據點資料檔.生產單位批量(imae017)
   # 2-3.區間生產單位批量不等於目前設定的生產單位批量才顯示
   #3.檢核項目.最小生產數量 = "Y"時，
   # 3-1. 區間最小生產數量 = 抓取符合QBE條件及基準日期區間的已結案工單(生管結案).單據日期，分料號取出最小生產數量
   #      3-1-1.計算說明: 如果工單的生產單位和料件據點資料檔.生產單位imae016不同時，應先轉換回料件生產單位再取最小生產數量
   # 3-2.目前設定的最小生產數量 = 料件據點資料檔.最小生產數量(imae018)
   # 3-3.區間最小生產數量不等於目前設定的最小生產數量才顯示
   
   #160708-00006#1   add-S
#2.檢核項目.生產單位批量 = "Y"時，
#  2-1. 區間生產單位批量 = 抓取符合QBE條件及基準日期區間的已結案工單(生管結案或成本結案).單據日期，分料號取出最小生產數量
#       2-1-1.計算說明: 如果工單的生產單位和料件據點資料檔.生產單位imae016不同時，應先轉換回料件生產單位再取最小生產數量
#
#  2-2.目前設定的生產單位批量 = 料件據點資料檔.生產單位批量(imae017)
#
#  2-3.生產單位批量 與 區間生產單位批量 差異 超過 ±報表設定的差異比率 才顯示
#    2-3-1 例如: 本次報表設定的差異比率為 10% 
#                料號的imae017為20 pcs，本次區間最小生產批量為 30 pcs
#                本次的差異比率為 (20 - 30)/30 = -0.333 (相當於-33%) -33% < -10% 所以這筆資料應該要產生異常報表
#    2-3-2 例如: 本次報表設定的差異比率為 10% 
#                料號的imae017為40 pcs，本次區間最小生產批量為 30 pcs
#                本次的差異比率為 (40 - 30)/30 = 0.333 (相當於33%) 33% > 10% 所以這筆資料應該要產生異常報表
   #160708-00006#1   add-E
   IF tm.pr2 = 'Y' OR tm.pr3 = 'Y' THEN
      LET l_sql = " SELECT MIN(sfaa012),sfaa013 ",
                  " FROM sfaa_t ",
                  " WHERE sfaaent = ",g_enterprise,
                  "   AND sfaasite = '",g_site,"' ",
                  "   AND (sfaastus = 'M' OR sfaa065 IN ('1','2')) ",  #160708-00006#1   mod
#                  "   AND sfaastus = 'C' ",
                  "   AND sfaa010 = ? ",
                  "   AND (sfaadocdt BETWEEN to_date('",tm.bdate,"','",l_datetype CLIPPED,"') AND to_date('",tm.edate,"','",l_datetype CLIPPED,"') )",
                  "   GROUP BY sfaa010,sfaa013 ",
                  "   ORDER BY sfaa010,sfaa013 "
      PREPARE aimr140_x01_imae017_pre FROM l_sql
      DECLARE aimr140_x01_imae017_cur CURSOR FOR aimr140_x01_imae017_pre
   END IF
   
   #4.檢核項目.工單拆分批量 = "Y"時，
   # 4-1.區間工單拆分批量 = 抓取符合QBE條件及基準日期區間的已結案工單(生管結案).單據日期，分料號取出最小拆分數量
   #     4-1-1.當檢核項目.工單拆分批量.拆分批量為0者不管制 = "Y"，代表當料件據點資料檔.工單拆分批量(imae022)=0時，不需計算此料件
   #     4-1-2.拆分數量需用工單編號到 Runcard拆分記錄單身檔中找出最小的拆分轉入數量sfcf005
   #     4-1-3.如果工單的生產單位和料件據點資料檔.生產單位imae016不同時，應先轉換回料件生產單位再取最小拆分數量
   # 4-2.目前設定的工單拆分批量 = 料件據點資料檔.工單拆分批量(imae022)
   # 4-3.區間工單拆分批量不等於目前設定的工單拆分批量才顯示
   
   #160708-00006#1   add-S
#   4.檢核項目.工單拆分批量 = "Y"時，
#  4-1.區間工單拆分批量 = 抓取符合QBE條件及基準日期區間的已結案工單(生管結案或成本結案).單據日期，分料號取出最小拆分數量
#      4-1-1.當檢核項目.工單拆分批量.拆分批量為0者不管制 = "Y"，代表當料件據點資料檔.工單拆分批量(imae022)=0時，不需計算此料件
#      4-1-2.拆分數量需用工單編號到 Runcard拆分記錄單身檔中找出最小的拆分轉入數量sfcf005
#      4-1-3.如果工單的生產單位和料件據點資料檔.生產單位imae016不同時，應先轉換回料件生產單位再取最小拆分數量
#  
#  4-2.目前設定的工單拆分批量 = 料件據點資料檔.工單拆分批量(imae022)
#
#  4-3.工單拆分批量 與 區間工單拆分批量 差異 超過 ±報表設定的差異比率 才顯示
#    4-3-1 例如: 本次報表設定的差異比率為 10% 
#                料號的imae022為20 pcs，本次區間工單拆分批量為 30 pcs
#                本次的差異比率為 (20 - 30)/30 = -0.333 (相當於-33%) -33% < -10% 所以這筆資料應該要產生異常報表
#    4-3-2 例如: 本次報表設定的差異比率為 10% 
#                料號的imae022為40 pcs，本次區間工單拆分批量為 30 pcs
#                本次的差異比率為 (40 - 30)/30 = 0.333 (相當於33%) 33% > 10% 所以這筆資料應該要產生異常報表
#
   #160708-00006#1   add-E
   IF tm.pr4 = 'Y' THEN
      LET l_sql = " SELECT MIN(sfcf005),sfaa013 ",
                  " FROM sfaa_t LEFT OUTER JOIN sfcf_t ON sfaadocno = sfcfdocno AND sfaaent = sfcfent AND sfaasite = sfcfsite ",
                  " WHERE sfaaent = ",g_enterprise,
                  "   AND sfaasite = '",g_site,"' ",
                  "   AND (sfaastus = 'M' OR sfaa065 IN ('1','2')) ",  #160708-00006#1   mod
#                  "   AND sfaastus = 'C' ",
                  "   AND sfaa010 = ? ",
                  "   AND (sfaadocdt BETWEEN to_date('",tm.bdate,"','",l_datetype CLIPPED,"') AND to_date('",tm.edate,"','",l_datetype CLIPPED,"') )",
                  "   GROUP BY sfaa010,sfaa013 ",
                  "   ORDER BY sfaa010,sfaa013 "
      PREPARE aimr140_x01_imae022_pre FROM l_sql
      DECLARE aimr140_x01_imae022_cur CURSOR FOR aimr140_x01_imae022_pre
   END IF
   
   #5.檢核項目.變動生產前置時間="Y"時，
   # 5-1.區間變動生產前置時間=抓取符合QBE條件及基準日期區間的已結案工單(生管結案).單據日期，分料號取出日期最大的工單，再依工單找出已確認且確認日期最大的入庫單
   #     5-1-1.如果料件據點資料檔.變動批量imae073為0，忽略計算此料件
   #     5-1-2.計算方式: ((入庫單.確認日期sfeacnfdt - 工單.實際開始發料日sfaa045)/入庫單.入庫數量sfec009)*料件據點資料檔.變動批量imae073
   #     5-1-3.如果入庫單的單位和料件據點資料檔.生產單位imae016不同時，應要轉換回料件生產單位的數量
   # 5-2.目前設定的變動生產前置時間 = 料件據點資料檔.變動生產前置時間imae072
   # 5-3.區間變動生產前置時間不等於目前設定的變動生產前置時間才顯示
   #160523-00001#1  1.檢核項目.變動生產前置時間="Y"時，區間變動生產前置時間=抓取符合QBE條件及基準日期區間的已結案工單(生管結案或成本結案).單據日期，分料號取出單據日期最大的工單，再依工單找出"已確認或已過帳"且確認日期最大的入庫單
   
   #160708-00006#1   add-S
#5.檢核項目.變動生產前置時間="Y"時，
#  5-1.區間變動生產前置時間=抓取符合QBE條件及基準日期區間的已結案工單(生管結案或成本結案).單據日期，分料號取出單據日期最大的工單，再依工單找出已確認或已過帳且確認日期最大的入庫單
#      5-1-1.如果料件據點資料檔.變動批量imae073為0，忽略計算此料件
#      5-1-2.計算方式: ((入庫單.確認日期sfeacnfdt - 工單.實際開始發料日sfaa045)/入庫單.入庫數量sfec009)*料件據點資料檔.變動批量imae073
#      5-1-3.如果入庫單的單位和料件據點資料檔.生產單位imae016不同時，應要轉換回料件生產單位的數量
#
#  5-2.目前設定的變動生產前置時間 = 料件據點資料檔.變動生產前置時間imae072
#
#  5-3.區間變動生產前置時間不等於目前設定的變動生產前置時間才顯示
#  5-3.工單拆分批量 與 區間變動生產前置時間 差異 超過 ±報表設定的差異比率 才顯示
#    5-3-1 例如: 本次報表設定的差異比率為 10% 
#                料號的imae022為20 pcs，本次區間工單拆分批量為 30 pcs
#                本次的差異比率為 (20 - 30)/30 = -0.333 (相當於-33%) -33% < -10% 所以這筆資料應該要產生異常報表
#    5-3-2 例如: 本次報表設定的差異比率為 10% 
#                料號的imae022為40 pcs，本次區間工單拆分批量為 30 pcs
#                本次的差異比率為 (40 - 30)/30 = 0.333 (相當於33%) 33% > 10% 所以這筆資料應該要產生異常報表
   #160708-00006#1   add-E
   IF tm.pr5 = 'Y' THEN
      LET l_sql = " SELECT MAX(sfeacnfdt),MAX(sfaa045),SUM(sfec009),sfec008 ",
                  " FROM sfea_t LEFT OUTER JOIN sfec_t ON sfecdocno = sfeadocno AND sfecent = sfeaent ",
                  "             LEFT OUTER JOIN sfaa_t ON sfec001 = sfaadocno AND sfecent = sfaaent ",
                  " WHERE sfeaent = ",g_enterprise,
                  "   AND sfeasite = '",g_site,"' ",
#                  "   AND sfeastus = 'Y' ", #160523-00001#1 mod
                  "   AND (sfeastus = 'Y' OR sfeastus = 'S' ) ", #160523-00001#1 mod
                  "   AND sfeacnfdt IS NOT NULL ",
                  "   AND sfaa045 IS NOT NULL ",
                  "   AND sfaa010 = ? ",
                  "   AND (sfaadocdt IN ",
                  "   (SELECT MAX(sfaadocdt) FROM sfaa_t ",
#                  "    WHERE sfaaent = ",g_enterprise," AND sfaastus = 'C' AND sfaasite = '",g_site,"' ",#160523-00001#1 mod
                  "    WHERE sfaaent = ",g_enterprise," AND (sfaastus = 'M' OR sfaa065 IN ('1','2')) AND sfaasite = '",g_site,"' ",#160523-00001#1 mod
                  "    AND sfaa010 = ? AND (sfaadocdt BETWEEN to_date('",tm.bdate,"','",l_datetype CLIPPED,"') AND to_date('",tm.edate,"','",l_datetype CLIPPED,"')) GROUP BY sfaa010) )",
                  "   GROUP BY sfaadocno,sfaa045,sfec008 ",
                  "   ORDER BY sfaadocno,sfaa045,sfec008 "
      PREPARE aimr140_x01_imae072_pre FROM l_sql
      DECLARE aimr140_x01_imae072_cur CURSOR FOR aimr140_x01_imae072_pre
   END IF
   
   #6.檢核項目.QC前置時間="Y"時，
   # 6-1.區間QC前置時間=抓取符合QBE條件及基準日期區間的已結案工單.單據日期，分料號取出日期最大的工單，再依工單找出已確認且確認日期最大的入庫單
   #     6-1-1.計算方式: 入庫單的入庫過帳日sfeapstdt - 入庫資料確認日期sfeacnfdt
   # 6-2.目前設定的QC前置時間=料件據點資料檔.QC前置時間(imae074)
   # 6-3.區間QC前置時間不等於目前設定的QC前置時間才顯示
   #160708-00006#1   add-S
#   6.檢核項目.QC前置時間="Y"時，
#  6-1.區間QC前置時間=抓取符合QBE條件及基準日期區間的已結案工單(生管結案或成本結案).單據日期，分料號取出單據日期最大的工單，再依工單找出已確認且確認日期最大的入庫單
#      6-1-1.計算方式: 入庫單的入庫過帳日sfeapstdt - 入庫資料確認日期sfeacnfdt
#
#  6-2.目前設定的QC前置時間=料件據點資料檔.QC前置時間(imae074)
#
#  6-3.區間QC前置時間不等於目前設定的QC前置時間才顯示
   #160708-00006#1   add-E
   IF tm.pr6 = 'Y' THEN
      LET l_sql = " SELECT DISTINCT sfeapstdt,sfeacnfdt ",
                  " FROM sfea_t LEFT OUTER JOIN sfec_t ON sfecdocno = sfeadocno AND sfecent = sfeaent ",
                  "             LEFT OUTER JOIN sfaa_t ON sfec001 = sfaadocno AND sfecent = sfaaent ",
                  " WHERE sfeaent = ",g_enterprise,
                  "   AND sfeasite = '",g_site,"' ",
                  "   AND sfeastus = 'Y' ",
                  "   AND sfeadocno IN ",
                  "       (SELECT sfeadocno FROM sfea_t,sfec_t,sfaa_t ",
                  "         WHERE sfeadocno = sfecdocno AND sfeaent = sfecent AND sfec001 = sfaadocno AND sfecent = sfaaent ",
                  "           AND sfeastus = 'Y' AND sfaa010 = ? AND sfeaent = ",g_enterprise," AND sfeasite = '",g_site,"' ",
                  "           AND sfeacnfdt = (SELECT MAX(sfeacnfdt) FROM sfea_t,sfec_t,sfaa_t ",
                  "           WHERE sfeadocno = sfecdocno AND sfeaent = sfecent AND sfec001 = sfaadocno AND sfecent = sfaaent ",
#                  "             AND sfaastus = 'C' ",
                  "   AND (sfaastus = 'M' OR sfaa065 IN ('1','2')) ",  #160708-00006#1   mod
                  "             AND sfaa010 = ? ",
                  "             AND sfaadocdt = (SELECT MAX(sfaadocdt) FROM sfaa_t ",
#                  "             WHERE sfaastus = 'C' AND sfaa010 = ? AND (sfaadocdt BETWEEN to_date('",tm.bdate,"','",l_datetype CLIPPED,"') AND to_date('",tm.edate,"','",l_datetype CLIPPED,"') )",
                  "             WHERE sfaastus = 'M' OR sfaa065 IN ('1','2') AND sfaa010 = ? AND (sfaadocdt BETWEEN to_date('",tm.bdate,"','",l_datetype CLIPPED,"') AND to_date('",tm.edate,"','",l_datetype CLIPPED,"') )", #160708-00006#1   mod
                  "               AND sfaaent = ",g_enterprise," AND sfaasite = '",g_site,"' ",
                  "        )))"
   END IF                      
   PREPARE aimr140_x01_imae074_pre FROM l_sql
   DECLARE aimr140_x01_imae074_cur CURSOR FOR aimr140_x01_imae074_pre
   
   #end add-point
   PREPARE aimr140_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE aimr140_x01_curs CURSOR FOR aimr140_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="aimr140_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION aimr140_x01_ins_data()
DEFINE sr RECORD 
   imaa001 LIKE imaa_t.imaa001, 
   l_imaal003 LIKE imaal_t.imaal003, 
   l_imaal004 LIKE imaal_t.imaal004, 
   imaa009 LIKE imaa_t.imaa009, 
   l_imaa009_desc LIKE rtaxl_t.rtaxl003, 
   imaa003 LIKE imaa_t.imaa003, 
   l_imaa003_desc LIKE oocql_t.oocql004, 
   imae011 LIKE imae_t.imae011, 
   l_imae011_desc LIKE oocql_t.oocql004, 
   imae012 LIKE imae_t.imae012, 
   l_imae012_desc LIKE ooag_t.ooag011, 
   imae016 LIKE imae_t.imae016, 
   l_imae016_desc LIKE oocal_t.oocal003, 
   l_chk_item LIKE oocql_t.oocql004, 
   l_cur_set LIKE type_t.num15_3, 
   l_act_set LIKE type_t.num15_3
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_imae015  LIKE imae_t.imae015
DEFINE l_imae016  LIKE imae_t.imae016     #料件生产单位
DEFINE l_imae017  LIKE imae_t.imae017
DEFINE l_imae018  LIKE imae_t.imae018
DEFINE l_imae022  LIKE imae_t.imae022
DEFINE l_imae072  LIKE imae_t.imae072
DEFINE l_imae073  LIKE imae_t.imae073
DEFINE l_imae074  LIKE imae_t.imae074
DEFINE l_sfaa050  LIKE sfaa_t.sfaa050
DEFINE l_sfaa012  LIKE sfaa_t.sfaa012
DEFINE l_sfaa013  LIKE sfaa_t.sfaa013     #工单生产单位
DEFINE l_sfcf005  LIKE sfcf_t.sfcf005
DEFINE l_sfec008  LIKE sfec_t.sfec008
DEFINE l_sfec009  LIKE sfec_t.sfec009
DEFINE l_rate     LIKE type_t.num15_3     #单位换算率
DEFINE l_date1    LIKE type_t.dat
DEFINE l_date2    LIKE type_t.dat
DEFINE l_count    LIKE type_t.num10
DEFINE l_sql      STRING
DEFINE l_tmp1     LIKE type_t.num10
DEFINE l_tmp2     LIKE type_t.num10
DEFINE l_success  LIKE type_t.num10
DEFINE l_no       LIKE type_t.num10
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH aimr140_x01_curs INTO sr.*                               
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
       #获取设定资料
       INITIALIZE l_imae015 TO NULL
       INITIALIZE l_imae017 TO NULL
       INITIALIZE l_imae018 TO NULL
       INITIALIZE l_imae022 TO NULL
       INITIALIZE l_imae072 TO NULL
       INITIALIZE l_imae073 TO NULL
       INITIALIZE l_imae074 TO NULL
       INITIALIZE l_sfaa013 TO NULL
       LET l_tmp1 = 0
       LET l_tmp2 = 0
       SELECT DISTINCT COALESCE(imae015,0),COALESCE(imae017,0),COALESCE(imae018,0),COALESCE(imae022,0),COALESCE(imae072,0),COALESCE(imae074,0),imae016,imae073
                  INTO l_imae015,l_imae017,l_imae018,l_imae022,l_imae072,l_imae074,l_imae016,l_imae073
         FROM imae_t
        WHERE imae001 = sr.imaa001
          AND imaeent = g_enterprise 
          AND imaesite = g_site
       #检核项目：
       #1.檢核項目.生產損耗率 = "Y"時，#imae015
       #1-1.區間生產損耗率 = 抓取符合QBE條件及基準日期區間的已結案工單(生管結案+已發料套數>0).單據日期，分料號sfaa010計算 sfaa003<>'3' sfaastus = 'C' sfaa049>0
       #1-1-1.計算方式: 1- (加總已入庫合格量sfaa050 / 加總生產數量sfaa012)
       #1-1-2.計算說明: 如果工單的生產單位和料件據點資料檔.生產單位imae016不同時，應先轉換回料件生產單位再進行計算
       
      #160708-00006#1   add-S
#         1-3.生產損耗率 與 區間生產損耗率 的差異 超過 ±報表設定的差異比率 才顯示
#          1-3-1 舉例1: 本次報表設定的差異比率為10%
#                       料號的imae015 = 0%，本次計算出來的區間生產損耗率 為 0.167 (相當於16.7%)，
#                       (0% - 16.7%) < -10% 所以這筆資料應該要產生異常報表
#          1-3-2 舉例2: 本次報表設定的差異比率為10%
#                       料號的imae015 = 30%，本次計算出來的區間生產損耗率 為 0.167 (相當於16.7%)，
#                       (30% - 16.7%) > 10% 所以這筆資料應該要產生異常報表
      #160708-00006#1   add-E
       IF tm.pr1 = "Y" THEN
          LET sr.l_chk_item = aimr140_x01_get_item_desc('imae015')
          #计算实际参数
          LET l_no = 0
          FOREACH aimr140_x01_imae015_cur USING sr.imaa001 INTO l_sfaa050,l_sfaa012,l_sfaa013
            IF l_imae016<>l_sfaa013 THEN
               CALL s_aimi190_get_convert(sr.imaa001,l_imae016,l_sfaa013) RETURNING l_success,l_rate
            ELSE
               LET l_rate = 1
            END IF
            LET l_no = l_no+1
            LET l_tmp1 = l_tmp1 + (1-l_sfaa050/l_sfaa012*l_rate)
          END FOREACH
          LET sr.l_act_set = l_tmp1
          LET sr.l_cur_set = l_imae015
          IF ((sr.l_cur_set - sr.l_act_set*100) > tm.rate1 OR (sr.l_cur_set - sr.l_act_set*100) < -1*tm.rate1) AND l_no>0 THEN #160708-00006#1 mod
#          IF (sr.l_act_set*100 > sr.l_cur_set*(100+tm.rate1) OR sr.l_act_set*100 < sr.l_cur_set*(100-tm.rate1)) AND l_no>0 THEN
             EXECUTE insert_prep USING sr.imaa001,sr.l_imaal003,sr.l_imaal004,sr.imaa009,sr.l_imaa009_desc,sr.imaa003,sr.l_imaa003_desc,sr.imae011,sr.l_imae011_desc,sr.imae012,sr.l_imae012_desc,sr.imae016,sr.l_imae016_desc,sr.l_chk_item,sr.l_cur_set,sr.l_act_set
          END IF
          LET sr.l_act_set = NULL
       END IF
       #2.檢核項目.生產單位批量 = "Y"時，
       # 2-1. 區間生產單位批量 = 抓取符合QBE條件及基準日期區間的已結案工單.單據日期，分料號取出最小生產數量
       #      2-1-1.計算說明: 如果工單的生產單位和料件據點資料檔.生產單位imae016不同時，應先轉換回料件生產單位再取最小生產數量
       # 2-2.目前設定的生產單位批量 = 料件據點資料檔.生產單位批量(imae017)
       # 2-3.區間生產單位批量不等於目前設定的生產單位批量才顯示
       #3.檢核項目.最小生產數量 = "Y"時，
       # 3-1. 區間最小生產數量 = 抓取符合QBE條件及基準日期區間的已結案工單.單據日期，分料號取出最小生產數量
       #      3-1-1.計算說明: 如果工單的生產單位和料件據點資料檔.生產單位imae016不同時，應先轉換回料件生產單位再取最小生產數量
       # 3-2.目前設定的最小生產數量 = 料件據點資料檔.最小生產數量(imae018)
       # 3-3.區間最小生產數量不等於目前設定的最小生產數量才顯示
       LET l_tmp1 = 0
       LET l_tmp2 = 0
       IF tm.pr2 = "Y" OR tm.pr3 = "Y" THEN
          #计算实际参数
          LET l_no = 0
          FOREACH aimr140_x01_imae017_cur USING sr.imaa001 INTO l_sfaa012,l_sfaa013
            IF l_imae016<>l_sfaa013 THEN
               CALL s_aimi190_get_convert(sr.imaa001,l_imae016,l_sfaa013) RETURNING l_success,l_rate
            ELSE
               LET l_rate = 1
            END IF
            LET l_no = l_no+1
            LET l_tmp1 = l_tmp1 + l_sfaa012*l_rate
          END FOREACH
          LET sr.l_act_set = l_tmp1
          IF tm.pr2 = 'Y' AND l_no>0 THEN
              LET sr.l_chk_item = aimr140_x01_get_item_desc('imae017')
             LET sr.l_cur_set = l_imae017
             #160708-00006#1 mod
#             IF (sr.l_act_set*100 > sr.l_cur_set*(100+tm.rate2) OR sr.l_act_set*100 < sr.l_cur_set*(100-tm.rate2)) THEN
             IF (sr.l_cur_set*100 > sr.l_act_set*(100+tm.rate2) OR sr.l_cur_set*100 < sr.l_act_set*(100-tm.rate2)) THEN
                EXECUTE insert_prep USING sr.imaa001,sr.l_imaal003,sr.l_imaal004,sr.imaa009,sr.l_imaa009_desc,sr.imaa003,sr.l_imaa003_desc,sr.imae011,sr.l_imae011_desc,sr.imae012,sr.l_imae012_desc,sr.imae016,sr.l_imae016_desc,sr.l_chk_item,sr.l_cur_set,sr.l_act_set
             END IF
          END IF
          IF tm.pr3 = 'Y' AND l_no>0 THEN 
            LET sr.l_chk_item = aimr140_x01_get_item_desc('imae018')
            LET sr.l_cur_set = l_imae018
             #160708-00006#1 mod
#             IF (sr.l_act_set*100 > sr.l_cur_set*(100+tm.rate3) OR sr.l_act_set*100 < sr.l_cur_set*(100-tm.rate3)) THEN
             IF (sr.l_cur_set*100 > sr.l_act_set*(100+tm.rate3) OR sr.l_cur_set*100 < sr.l_act_set*(100-tm.rate3)) THEN
                EXECUTE insert_prep USING sr.imaa001,sr.l_imaal003,sr.l_imaal004,sr.imaa009,sr.l_imaa009_desc,sr.imaa003,sr.l_imaa003_desc,sr.imae011,sr.l_imae011_desc,sr.imae012,sr.l_imae012_desc,sr.imae016,sr.l_imae016_desc,sr.l_chk_item,sr.l_cur_set,sr.l_act_set
             END IF
          END IF
          LET sr.l_act_set = NULL
       END IF
      
       #4.檢核項目.工單拆分批量 = "Y"時，
       # 4-1.區間工單拆分批量 = 抓取符合QBE條件及基準日期區間的已結案工單.單據日期，分料號取出最小拆分數量
       #     4-1-1.當檢核項目.工單拆分批量.拆分批量為0者不管制 = "Y"，代表當料件據點資料檔.工單拆分批量(imae022)=0時，不需計算此料件
       #     4-1-2.拆分數量需用工單編號到 Runcard拆分記錄單身檔中找出最小的拆分轉入數量sfcf005
       #     4-1-3.如果工單的生產單位和料件據點資料檔.生產單位imae016不同時，應先轉換回料件生產單位再取最小拆分數量
       # 4-2.目前設定的工單拆分批量 = 料件據點資料檔.工單拆分批量(imae022)
       # 4-3.區間工單拆分批量不等於目前設定的工單拆分批量才顯示
       LET l_tmp1 = 0
       LET l_tmp2 = 0
       IF tm.pr4 = "Y" THEN
          IF tm.show = 'Y' AND l_imae022 = 0 THEN
          ELSE
             LET sr.l_chk_item = aimr140_x01_get_item_desc('imae022')
             #计算实际参数
             LET l_no = 0
             FOREACH aimr140_x01_imae022_cur USING sr.imaa001 INTO l_sfcf005,l_sfaa013
                IF l_imae016<>l_sfaa013 THEN 
                   CALL s_aimi190_get_convert(sr.imaa001,l_imae016,l_sfaa013) RETURNING l_success,l_rate
                ELSE
                   LET l_rate = 1
                END IF
                LET l_no = l_no+1
                LET l_tmp1 = l_tmp1 + l_sfcf005*l_rate
             END FOREACH
             LET sr.l_act_set = l_tmp1
             LET sr.l_cur_set = l_imae022
             #160708-00006#1 mod
#             IF (sr.l_act_set*100 > sr.l_cur_set*(100+tm.rate4) OR sr.l_act_set*100 < sr.l_cur_set*(100-tm.rate4)) AND l_no>0 THEN
             IF (sr.l_cur_set*100 > sr.l_act_set*(100+tm.rate4) OR sr.l_cur_set*100 < sr.l_act_set*(100-tm.rate4)) AND l_no>0 THEN
                EXECUTE insert_prep USING sr.imaa001,sr.l_imaal003,sr.l_imaal004,sr.imaa009,sr.l_imaa009_desc,sr.imaa003,sr.l_imaa003_desc,sr.imae011,sr.l_imae011_desc,sr.imae012,sr.l_imae012_desc,sr.imae016,sr.l_imae016_desc,sr.l_chk_item,sr.l_cur_set,sr.l_act_set
             END IF
             LET sr.l_act_set = NULL
          END IF
       END IF
     
       #5.檢核項目.變動生產前置時間="Y"時，
       # 5-1.區間變動生產前置時間=抓取符合QBE條件及基準日期區間的已結案工單.單據日期，分料號取出日期最大的工單，再依工單找出已確認且確認日期最大的入庫單
       #     5-1-1.如果料件據點資料檔.變動批量imae073為0，忽略計算此料件
       #     5-1-2.計算方式: ((入庫單.確認日期sfeacnfdt - 工單.實際開始發料日sfaa045)/入庫單.入庫數量sfec009)*料件據點資料檔.變動批量imae073
       #     5-1-3.如果入庫單的單位和料件據點資料檔.生產單位imae016不同時，應要轉換回料件生產單位的數量
       # 5-2.目前設定的變動生產前置時間 = 料件據點資料檔.變動生產前置時間imae072
       # 5-3.區間變動生產前置時間不等於目前設定的變動生產前置時間才顯示
       LET l_tmp1 = 0
       LET l_tmp2 = 0
       IF tm.pr5 = "Y" THEN
          LET sr.l_chk_item = aimr140_x01_get_item_desc('imae072')
          #计算实际参数
          LET l_no = 0
          FOREACH aimr140_x01_imae072_cur USING sr.imaa001,sr.imaa001 INTO l_date1,l_date2,l_sfec009,l_sfec008
            IF l_imae016<>l_sfec008 THEN
               CALL s_aimi190_get_convert(sr.imaa001,l_imae016,l_sfec008) RETURNING l_success,l_rate
            ELSE
               LET l_rate = 1
            END IF
            LET l_no = l_no+1
            LET l_tmp1 = l_tmp1 + (l_date1-l_date2)*l_sfec009*l_rate
          END FOREACH
          LET sr.l_act_set = l_tmp1
          LET sr.l_cur_set = l_imae072
          IF (sr.l_act_set > sr.l_cur_set+tm.day1 OR sr.l_act_set < sr.l_cur_set-tm.day1) AND l_no>0 THEN
             EXECUTE insert_prep USING sr.imaa001,sr.l_imaal003,sr.l_imaal004,sr.imaa009,sr.l_imaa009_desc,sr.imaa003,sr.l_imaa003_desc,sr.imae011,sr.l_imae011_desc,sr.imae012,sr.l_imae012_desc,sr.imae016,sr.l_imae016_desc,sr.l_chk_item,sr.l_cur_set,sr.l_act_set
          END IF
          LET sr.l_act_set = NULL
       END IF
       #6.檢核項目.QC前置時間="Y"時，
       # 6-1.區間QC前置時間=抓取符合QBE條件及基準日期區間的已結案工單.單據日期，分料號取出日期最大的工單，再依工單找出已確認且確認日期最大的入庫單
       #     6-1-1.計算方式: 入庫單的入庫過帳日sfeapstdt - 入庫資料確認日期sfeacnfdt
       # 6-2.目前設定的QC前置時間=料件據點資料檔.QC前置時間(imae074)
       # 6-3.區間QC前置時間不等於目前設定的QC前置時間才顯示
       LET l_tmp1 = 0
       LET l_tmp2 = 0
       IF tm.pr5 = "Y" THEN
          LET sr.l_chk_item = aimr140_x01_get_item_desc('imae072')
          #计算实际参数
          LET l_no = 0
          FOREACH aimr140_x01_imae074_cur USING sr.imaa001,sr.imaa001,sr.imaa001 INTO l_date1,l_date2
            LET l_tmp1 = l_tmp1 + (l_date1-l_date2)
            LET l_no = l_no+1
          END FOREACH
          LET sr.l_act_set = l_tmp1
          LET sr.l_cur_set = l_imae074
          IF (sr.l_act_set > sr.l_cur_set+tm.day2 OR sr.l_act_set < sr.l_cur_set*tm.day2) AND l_no>0 THEN
             EXECUTE insert_prep USING sr.imaa001,sr.l_imaal003,sr.l_imaal004,sr.imaa009,sr.l_imaa009_desc,sr.imaa003,sr.l_imaa003_desc,sr.imae011,sr.l_imae011_desc,sr.imae012,sr.l_imae012_desc,sr.imae016,sr.l_imae016_desc,sr.l_chk_item,sr.l_cur_set,sr.l_act_set
          END IF
          LET sr.l_act_set = NULL
       END IF
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       CONTINUE FOREACH
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.imaa001,sr.l_imaal003,sr.l_imaal004,sr.imaa009,sr.l_imaa009_desc,sr.imaa003,sr.l_imaa003_desc,sr.imae011,sr.l_imae011_desc,sr.imae012,sr.l_imae012_desc,sr.imae016,sr.l_imae016_desc,sr.l_chk_item,sr.l_cur_set,sr.l_act_set
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "aimr140_x01_execute"
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
 
{<section id="aimr140_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION aimr140_x01_rep_data()
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
 
{<section id="aimr140_x01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 获取检核项目名称
# Memo...........:
# Usage..........: CALL aimr140_x01_get_item_desc(p_item)
#                  RETURNING r_desc
# Date & Author..: 2015-12-22 By zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION aimr140_x01_get_item_desc(p_item)
DEFINE p_item  LIKE type_t.chr50
DEFINE r_desc  LIKE oocql_t.oocql004

   LET r_desc = NULL
   IF cl_null(p_item) THEN 
      RETURN r_desc
   END IF
   
   SELECT dzebl003 INTO r_desc
     FROM dzebl_t
    WHERE dzebl001 = p_item
      AND dzebl002 = g_dlang
   
   RETURN r_desc
END FUNCTION

 
{</section>}
 
