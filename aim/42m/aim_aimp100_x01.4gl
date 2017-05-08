#該程式未解開Section, 採用最新樣板產出!
{<section id="aimp100_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2017-02-10 10:50:48), PR版次:0003(2017-02-10 10:53:58)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000072
#+ Filename...: aimp100_x01
#+ Description: ...
#+ Creator....: 02295(2014-12-29 19:20:44)
#+ Modifier...: 08734 -SD/PR- 08734
 
{</section>}
 
{<section id="aimp100_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#151213-00001#1  2016/03/15 By xianghui 增加列印差异百分比以及一些报表栏位的调整
#170207-00018#1  2017/02/10 By 08734    ROWNUM整批调整
#end add-point
#add-point:填寫註解說明 name="global.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="global.import"
IMPORT util
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../cfg/top_report.inc"                  #報表使用的global
 
#報表 type 宣告
DEFINE tm RECORD
       wc STRING,                  #where codition 
       bdate LIKE type_t.dat,         #bdate 
       edate LIKE type_t.dat,         #edate 
       b LIKE type_t.chr1,         #b 
       c LIKE type_t.chr1,         #c 
       xm001 STRING,                  #xmid001 
       per LIKE type_t.num5          #per
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_stage DYNAMIC ARRAY OF RECORD 
             xmib002     LIKE xmib_t.xmib002,
             xmib003     LIKE xmib_t.xmib003,
             bdate       LIKE type_t.dat, 
             edate       LIKE type_t.dat,
             xmid_total  LIKE xmid_t.xmid015,
             inaj_total  LIKE inaj_t.inaj011
             END RECORD
#151213-00001#1 ---mod---begin        
DEFINE g_bdate  LIKE bmba_t.bmba005,    
       g_edate  LIKE bmba_t.bmba005           
DEFINE g_bmba DYNAMIC ARRAY OF RECORD       #每階存放資料
          bmba001 LIKE bmba_t.bmba001,    #主件料號
          bmba003 LIKE bmba_t.bmba003     #元件料號
      END RECORD      
DEFINE g_i        LIKE type_t.num5
#151213-00001#1 ---mod---end             
#end add-point
 
{</section>}
 
{<section id="aimp100_x01.main" readonly="Y" >}
PUBLIC FUNCTION aimp100_x01(p_arg1,p_arg2,p_arg3,p_arg4,p_arg5,p_arg6,p_arg7)
DEFINE  p_arg1 STRING                  #tm.wc  where codition 
DEFINE  p_arg2 LIKE type_t.dat         #tm.bdate  bdate 
DEFINE  p_arg3 LIKE type_t.dat         #tm.edate  edate 
DEFINE  p_arg4 LIKE type_t.chr1         #tm.b  b 
DEFINE  p_arg5 LIKE type_t.chr1         #tm.c  c 
DEFINE  p_arg6 STRING                  #tm.xm001  xmid001 
DEFINE  p_arg7 LIKE type_t.num5         #tm.per  per
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.bdate = p_arg2
   LET tm.edate = p_arg3
   LET tm.b = p_arg4
   LET tm.c = p_arg5
   LET tm.xm001 = p_arg6
   LET tm.per = p_arg7
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "aimp100_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL aimp100_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL aimp100_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL aimp100_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL aimp100_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL aimp100_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="aimp100_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION aimp100_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "imaa001.imaa_t.imaa001,imaal003.imaal_t.imaal003,imaal004.imaal_t.imaal004,imaa006.imaa_t.imaa006,imaf_t_imaf026.imaf_t.imaf026,imaf_t_imaf023.imaf_t.imaf023,imaf_t_imaf025.imaf_t.imaf025,l_imaf026.imaf_t.imaf026,l_imaf025.imaf_t.imaf025,l_imaf023.imaf_t.imaf023" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
 
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="aimp100_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION aimp100_x01_ins_prep()
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
 
{<section id="aimp100_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aimp100_x01_sel_prep()
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
   LET g_select = " SELECT imaa001,imaal003,imaal004,imaa006,imaf026,imaf025,imaf023,'','',''"
#   #end add-point
#   LET g_select = " SELECT imaa001,imaal003,imaal004,imaa006,imaf_t.imaf026,imaf_t.imaf023,imaf_t.imaf025, 
#       NULL,NULL,NULL"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_from = " FROM imaa_t LEFT OUTER JOIN imaal_t ON imaaent=imaalent AND imaa001=imaal001 AND imaal002='",g_dlang,"'",
                "      ,imaf_t "
#   #end add-point
#    LET g_from = " FROM imaa_t,imaal_t,imaf_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET g_where = " WHERE imaaent = imafent AND imaa001 = imaf001 AND imafsite = '",g_site,"' AND ",tm.wc CLIPPED
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("imaa_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE aimp100_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE aimp100_x01_curs CURSOR FOR aimp100_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="aimp100_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION aimp100_x01_ins_data()
DEFINE sr RECORD 
   imaa001 LIKE imaa_t.imaa001, 
   imaal003 LIKE imaal_t.imaal003, 
   imaal004 LIKE imaal_t.imaal004, 
   imaa006 LIKE imaa_t.imaa006, 
   imaf_t_imaf026 LIKE imaf_t.imaf026, 
   imaf_t_imaf023 LIKE imaf_t.imaf023, 
   imaf_t_imaf025 LIKE imaf_t.imaf025, 
   l_imaf026 LIKE imaf_t.imaf026, 
   l_imaf025 LIKE imaf_t.imaf025, 
   l_imaf023 LIKE imaf_t.imaf023
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH aimp100_x01_curs INTO sr.*                               
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
       #151213-00001#1---add---begin
       LET sr.l_imaf026=0
       LET sr.l_imaf025=0
       LET sr.l_imaf023=0
       CALL aimp100_x01_get(sr.imaa001) RETURNING sr.l_imaf026,sr.l_imaf025,sr.l_imaf023
       IF (sr.imaf_t_imaf026*(1-tm.per/100) <= sr.l_imaf026 AND sr.l_imaf026 <= sr.imaf_t_imaf026*(1+tm.per/100)) AND
          (sr.imaf_t_imaf025*(1-tm.per/100) <= sr.l_imaf025 AND sr.l_imaf025 <= sr.imaf_t_imaf025*(1+tm.per/100)) AND
          (sr.imaf_t_imaf023*(1-tm.per/100) <= sr.l_imaf023 AND sr.l_imaf023 <= sr.imaf_t_imaf023*(1+tm.per/100)) THEN 
           CONTINUE FOREACH
       END IF  
       #151213-00001#1---add---end       
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.imaa001,sr.imaal003,sr.imaal004,sr.imaa006,sr.imaf_t_imaf026,sr.imaf_t_imaf023,sr.imaf_t_imaf025,sr.l_imaf026,sr.l_imaf025,sr.l_imaf023
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "aimp100_x01_execute"
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
 
{<section id="aimp100_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION aimp100_x01_rep_data()
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
 
{<section id="aimp100_x01.other_function" readonly="Y" >}

PRIVATE FUNCTION aimp100_x01_get(p_imaa001)
DEFINE p_imaa001  LIKE imaa_t.imaa001,
       r_imaf026  LIKE imaf_t.imaf026,
       r_imaf025  LIKE imaf_t.imaf025,
       r_imaf023  LIKE imaf_t.imaf023
DEFINE l_imaa      RECORD 
         imaa001    LIKE imaa_t.imaa001,
         imaa006    LIKE imaa_t.imaa006,
         imaf171    LIKE imaf_t.imaf171,
         imaf172    LIKE imaf_t.imaf172,
         imaf173    LIKE imaf_t.imaf173,
         imaf174    LIKE imaf_t.imaf174,
         imaf021    LIKE imaf_t.imaf021,
         imaf022    LIKE imaf_t.imaf022
         END RECORD
DEFINE l_fac       LIKE type_t.num20_6
DEFINE l_leadtime  LIKE type_t.num5
DEFINE l_n         LIKE type_t.num5
DEFINE l_imaf023   LIKE imaf_t.imaf023   #期間補足量
DEFINE l_imaf025   LIKE imaf_t.imaf025   #再訂購點量
DEFINE l_imaf026   LIKE imaf_t.imaf026   #安全存量
DEFINE l_inaj_sum  LIKE inaj_t.inaj011
DEFINE l_days      LIKE type_t.num5
DEFINE i           LIKE type_t.num5
DEFINE l_amt_total LIKE type_t.num20_6
DEFINE l_amt       LIKE type_t.num20_6
DEFINE l_d         LIKE type_t.num20_6
DEFINE l_bdate     LIKE type_t.dat
DEFINE l_edate     LIKE type_t.dat       
 

   CREATE TEMP TABLE aimp100_tmp
   (  xmid014     VARCHAR(10),
      xmid015     DECIMAL(20,6)
   );  
   
   LET g_sql = " INSERT INTO aimp100_tmp ",
               " SELECT DISTINCT xmid014,MAX(xmid015) FROM xmid_t,xmic_t ",
               " WHERE xmicent = xmident AND xmic001 = xmid001 AND xmic002 = xmid002 ",
               "   AND xmic003 = xmid003 AND xmic004 = xmid004 AND xmic005 = xmid005 AND xmic006 = xmid006 ",
               "   AND xmident = '",g_enterprise,"'",
               "   AND xmicstus = 'Y' ",
               "   AND xmid001 = '",tm.xm001,"'",
               "   AND xmid007 = ? ",
               "   AND xmid012 BETWEEN ? AND ? ",
               " GROUP BY xmid014 "
   PREPARE tmp_ins FROM g_sql

   LET g_sql = " SELECT * FROM aimp100_tmp "
   PREPARE tmp_sel_pr FROM g_sql
   DECLARE tmp_sel_cr CURSOR FOR tmp_sel_pr

   CALL aimp100_x01_fill_stage()
   
   #安全係數
   CASE tm.b
       WHEN '1'
            LET l_fac = 1.3
       WHEN '2'
            LET l_fac = 1.6
       WHEN '3'
            LET l_fac = 2.4
   END CASE 

   SELECT DISTINCT imaa001,imaa006,imaf171,imaf172,imaf173,imaf174,imaf021,imaf022
     INTO l_imaa.*    
     FROM imaa_t,imaf_t 
    WHERE imaaent = imafent AND imaa001 = imaf001
      AND imaaent = g_enterprise
      AND imaastus = 'Y'
      AND imafsite = g_site
      AND imaa001 = p_imaa001

   ------計算安全存量------
   #前置時間
   LET l_leadtime = l_imaa.imaf171+l_imaa.imaf172+l_imaa.imaf173+l_imaa.imaf174
   IF cl_null(l_leadtime) THEN LET l_leadtime = 1 END IF
   IF l_leadtime < 1 AND l_leadtime >= 0 THEN LET l_leadtime = 1 END IF 
   
   #期數
   LET l_n = g_stage.getLength()
       
   #標準差
   CALL aimp100_x01_fill_total(l_imaa.imaa001,l_imaa.imaa006)
   LET l_amt_total = 0
   LET l_amt = 0     
 
   FOR i= 1 TO l_n
      LET l_amt = (g_stage[i].xmid_total-g_stage[i].inaj_total)*(g_stage[i].xmid_total-g_stage[i].inaj_total)
      LET l_amt_total = l_amt_total + l_amt
   END FOR
   IF cl_null(l_amt_total) THEN LET l_amt_total = 0 END IF 
   LET l_d = util.Math.sqrt(l_amt_total/l_n)
   LET l_imaf026 = l_fac* util.Math.sqrt(l_leadtime)*l_d
   IF cl_null(l_imaf026) THEN LET l_imaf026 = 0 END IF 
   
   ------計算再訂購點量------
   LET l_bdate = tm.bdate
   LET l_edate = tm.edate
   LET l_days = l_edate - l_bdate
   
   #料件單位時間消耗量
   SELECT SUM(inaj011*inaj014) 
     INTO l_inaj_sum
     FROM inaj_t
    WHERE inajent = g_enterprise
      AND inajsite = g_site
      AND inaj005 = l_imaa.imaa001
      AND inaj004 = -1
      AND inaj022 BETWEEN tm.bdate AND tm.edate
   IF cl_null(l_inaj_sum) THEN LET l_inaj_sum = 0 END IF   
   LET l_imaf025 = (l_inaj_sum/l_days)*l_leadtime + l_imaf026      
   IF cl_null(l_imaf025) THEN LET l_imaf025 = 0 END IF
         
   ------計算期間補足量------
   LET l_imaf023 = (l_inaj_sum/l_days)*(l_leadtime+(l_imaa.imaf021*30+l_imaa.imaf022))+l_imaf026
   IF cl_null(l_imaf023) THEN LET l_imaf023 = 0 END IF

   LET r_imaf026 = l_imaf026
   LET r_imaf025 = l_imaf025
   LET r_imaf023 = l_imaf023
   RETURN r_imaf026,r_imaf025,r_imaf023
   
END FUNCTION

PRIVATE FUNCTION aimp100_x01_fill_stage()
DEFINE l_sql     STRING
DEFINE l_yy       LIKE type_t.num5
DEFINE l_mm       LIKE type_t.num5
DEFINE l_dd       LIKE type_t.num5
DEFINE l_dd_1     LIKE type_t.num5
DEFINE l_ac       LIKE type_t.num5
DEFINE l_e_date   LIKE xmic_t.xmic002

   LET l_sql = "SELECT DISTINCT xmib002,xmib003 FROM xmib_t WHERE xmibent = '",g_enterprise,"'",
               "   AND xmib001 = '",tm.xm001,"' ORDER BY xmib002 "
   PREPARE aimp100_x01_pre1 FROM l_sql 
   DECLARE aimp100_x01_cur1 CURSOR FOR aimp100_x01_pre1
   LET l_ac = 1
   FOREACH aimp100_x01_cur1 INTO g_stage[l_ac].xmib002,g_stage[l_ac].xmib003
      IF g_stage[l_ac].xmib002 = 1 THEN
         LET g_stage[l_ac].bdate = tm.bdate
         LET l_yy = YEAR(g_stage[l_ac].bdate)
         LET l_mm = MONTH(g_stage[l_ac].bdate)
         LET l_dd = DAY(g_stage[l_ac].bdate)

         IF g_stage[l_ac].xmib003 = '0' THEN   #天
            LET g_stage[l_ac].edate = g_stage[l_ac].bdate
         END IF
         IF g_stage[l_ac].xmib003 = '1' THEN   #周
            LET g_stage[l_ac].edate = g_stage[l_ac].bdate + 6
         END IF
         IF g_stage[l_ac].xmib003 = '2' THEN   #旬
            LET g_stage[l_ac].edate = g_stage[l_ac].bdate + 9
         END IF
         IF g_stage[l_ac].xmib003 = '3' THEN   #月
            IF l_dd = 1 THEN
               CALL s_date_get_last_date(g_stage[l_ac].bdate) RETURNING g_stage[l_ac].edate
            ELSE
               IF l_mm = 12 THEN
                  LET l_yy = l_yy +1
                  LET l_mm = 1
               ELSE
                  LET l_mm = l_mm + 1
               END IF
               LET g_stage[l_ac].edate = MDY(l_mm,l_dd-1,l_yy)
            END IF
         END IF
      ELSE
         LET l_yy = YEAR(g_stage[l_ac-1].edate)
         LET l_mm = MONTH(g_stage[l_ac-1].edate)
         LET l_dd = DAY(g_stage[l_ac-1].edate)
         LET g_stage[l_ac].bdate = g_stage[l_ac-1].edate + 1
         IF g_stage[l_ac].xmib003 = '0' THEN   #天
            LET g_stage[l_ac].edate = g_stage[l_ac].bdate
         END IF
         IF g_stage[l_ac].xmib003 = '1' THEN   #周
            LET g_stage[l_ac].edate = g_stage[l_ac].bdate + 6
         END IF
         IF g_stage[l_ac].xmib003 = '2' THEN   #旬
            LET g_stage[l_ac].edate = g_stage[l_ac].bdate + 9
         END IF
         IF g_stage[l_ac].xmib003 = '3' THEN   #月
            CALL s_date_get_last_date(g_stage[l_ac-1].edate) RETURNING l_e_date
            IF g_stage[l_ac-1].edate = l_e_date THEN   #最後一天
               LET l_dd = 1
            END IF
            IF l_dd = 1 THEN
               IF l_mm = 12 THEN
                  LET l_yy = l_yy + 1
                  LET l_mm = 1
               ELSE
                  LET l_mm = l_mm + 1
               END IF
               LET g_stage[l_ac].bdate = MDY(l_mm,1,l_yy)
               CALL s_date_get_last_date(g_stage[l_ac].bdate) RETURNING g_stage[l_ac].edate
            ELSE
               LET g_stage[l_ac].bdate = MDY(l_mm,l_dd+1,l_yy)
               IF l_mm = 12 THEN
                  LET l_yy = l_yy + 1
                  LET l_mm = 1
               ELSE
                  LET l_mm = l_mm + 1
               END IF
               LET g_stage[l_ac].edate = MDY(l_mm,l_dd,l_yy)
            END IF
         END IF
      END IF
      IF g_stage[l_ac].bdate > tm.edate THEN 
          INITIALIZE g_stage[l_ac].* TO NULL                         # Default cond
          CALL g_stage.deleteElement(l_ac)
          EXIT FOREACH 
      END IF
      LET l_ac = l_ac + 1
   END FOREACH
   CALL g_stage.deleteElement(l_ac)
END FUNCTION

PRIVATE FUNCTION aimp100_x01_fill_total(p_imaa001,p_imaa006)
DEFINE p_imaa001  LIKE imaa_t.imaa001,
       p_imaa006  LIKE imaa_t.imaa006
DEFINE i,j   LIKE type_t.num5
DEFINE l_sql STRING
DEFINE l_xmid014  LIKE xmid_t.xmid014,
       l_xmid015  LIKE xmid_t.xmid015 
DEFINE l_rate     LIKE inaj_t.inaj014         
DEFINE l_cnt      LIKE type_t.num5
DEFINE l_bmaa002  LIKE bmaa_t.bmaa002  #151213-00001#1 

  LET j =g_stage.getlength()
  FOR i= 1 TO j

     #将销售预测的资料按单位分组，抓取每种单位下数量的最大值插入到临时表中
     #在将这些数量换算成料件基础单位的数量更新临时表
     #最后抓去临时表中数量最大的值作为销售预测数量
     DELETE FROM aimp100_tmp;
     EXECUTE tmp_ins USING p_imaa001,g_stage[i].bdate,g_stage[i].edate
     
     FOREACH tmp_sel_cr INTO l_xmid014,l_xmid015  
        CALL s_aimi190_get_convert(p_imaa001,l_xmid014,p_imaa006) RETURNING g_success,l_rate
        IF g_success THEN 
           LET l_xmid015 = l_xmid015 * l_rate
        END IF
        UPDATE aimp100_tmp
           SET xmid015 = l_xmid015
         WHERE xmid014 = l_xmid014  
     END FOREACH
     SELECT MAX(xmid015) INTO g_stage[i].xmid_total
       FROM aimp100_tmp
     IF cl_null(g_stage[i].xmid_total) THEN LET g_stage[i].xmid_total = 0 END IF
     
     SELECT SUM(inaj014*inaj011) INTO g_stage[i].inaj_total
       FROM inaj_t
      WHERE inajent = g_enterprise
        AND inajsite = g_site
        AND inaj005 = p_imaa001
        AND inaj004 = -1
        AND inaj022 BETWEEN g_stage[i].bdate AND g_stage[i].edate  
     IF cl_null(g_stage[i].inaj_total) THEN LET g_stage[i].inaj_total = 0 END IF

     LET l_cnt = 0 
     #151213-00001#1 ---mod---begin
#    SELECT COUNT(*) INTO l_cnt
#      FROM bmba_t
#     WHERE bmbaent = g_enterprise
#       AND bmbasite = g_site
#       AND bmba003 = p_imaa001
#    IF l_cnt > 0 THEN
#       CALL aimp100_root_bom(0,'',p_imaa001,i)
#    END IF     
     LET g_bdate = g_stage[i].bdate
     LET g_edate = g_stage[i].bdate
     LET l_sql = "SELECT COUNT(*) ", 
                 "  FROM bmaa_t,bmba_t ",
                 " WHERE bmaaent = bmbaent ",
                 "   AND bmaasite = bmbasite  ",     
                 "   AND bmaa001 = bmba001 ",
                 "   AND bmaa002 = bmba002 ",
                 "   AND bmbaent = '",g_enterprise,"'",
                 "   AND bmbasite = '",g_site,"'",
                 "   AND bmba003 = '",p_imaa001,"'",
                 "   AND bmba005 <=to_date('",g_bdate,"','yyyy-mm-dd hh24:mi:ss')",
                 "   AND (bmba006 > to_date('",g_edate,"','yyyy-mm-dd hh24:mi:ss') OR bmba006 IS NULL)",
                 "   AND bmaastus = 'Y' "
     PREPARE aimp100_get_bom1 FROM l_sql
     EXECUTE aimp100_get_bom1 INTO l_cnt     
     IF l_cnt > 0 THEN
        LET l_bmaa002 = ' '      
        #170207-00018#1    2017/02/10   By 08734 mark(S)
        #LET l_sql = "SELECT bmba002 ", 
        #            "  FROM bmaa_t,bmba_t ",
        #            " WHERE bmaaent = bmbaent ",
        #            "   AND bmaasite = bmbasite  ",     
        #            "   AND bmaa001 = bmba001 ",
        #            "   AND bmaa002 = bmba002 ",
        #            "   AND bmbaent = '",g_enterprise,"'",
        #            "   AND bmbasite = '",g_site,"'",
        #            "   AND bmba003 = '",p_imaa001,"'",
        #            "   AND bmba005 <=to_date('",g_bdate,"','yyyy-mm-dd hh24:mi:ss')",
        #            "   AND (bmba006 > to_date('",g_edate,"','yyyy-mm-dd hh24:mi:ss') OR bmba006 IS NULL)",
        #            "   AND bmaastus = 'Y' ",
        #            "   AND rownum = 1 ",
        #            " ORDER BY bmaa002"
        #170207-00018#1    2017/02/10   By 08734 mark(E)
        #170207-00018#1    2017/02/10   By 08734 add(S)        
        LET l_sql = " SELECT a.bmba002 FROM ( ",     
                    " SELECT bmba002 ", 
                    "  FROM bmaa_t,bmba_t ",
                    " WHERE bmaaent = bmbaent ",
                    "   AND bmaasite = bmbasite  ",     
                    "   AND bmaa001 = bmba001 ",
                    "   AND bmaa002 = bmba002 ",
                    "   AND bmbaent = '",g_enterprise,"'",
                    "   AND bmbasite = '",g_site,"'",
                    "   AND bmba003 = '",p_imaa001,"'",
                    "   AND bmba005 <=to_date('",g_bdate,"','yyyy-mm-dd hh24:mi:ss')",
                    "   AND (bmba006 > to_date('",g_edate,"','yyyy-mm-dd hh24:mi:ss') OR bmba006 IS NULL)",
                    "   AND bmaastus = 'Y' ",
                    " ORDER BY bmaa002 ) a ",
                    " WHERE rownum = 1 "
        #170207-00018#1    2017/02/10   By 08734 add(E)
        PREPARE aimp100_get_bom2 FROM l_sql
        EXECUTE aimp100_get_bom2 INTO l_bmaa002        
        CALL aimp100_x01_root_bom(0,l_bmaa002,p_imaa001,i)
     END IF
     #151213-00001#1 ---mod---end     
  END FOR
END FUNCTION

PRIVATE FUNCTION aimp100_x01_root_bom(p_level,p_bmba002,p_bmba003,p_i)
DEFINE p_level LIKE type_t.num5,
       p_bmba002 LIKE bmba_t.bmba002,
       p_bmba003 LIKE bmba_t.bmba003,
       l_imaa006 LIKE imaa_t.imaa006,
       p_i LIKE type_t.num5
DEFINE sr DYNAMIC ARRAY OF RECORD       #每階存放資料
          bmba001 LIKE bmba_t.bmba001,    #主件料號
          bmba002 LIKE bmba_t.bmba002,
          bmba003 LIKE bmba_t.bmba003,    #元件料號
          bmba011 LIKE type_t.num20_6     #QPA
      END RECORD
DEFINE i      LIKE type_t.num5
DEFINE l_ac   LIKE type_t.num5
DEFINE l_sql STRING
DEFINE l_xmid014  LIKE xmid_t.xmid014,
       l_xmid015  LIKE xmid_t.xmid015 
DEFINE l_rate     LIKE inaj_t.inaj014  
DEFINE l_xmid_total LIKE xmid_t.xmid015
DEFINE l_inaj_total LIKE inaj_t.inaj014
DEFINE l_idx      LIKE type_t.num5 #151213-00001#1

    LET p_level = p_level + 1
    IF p_level = 1 THEN
        INITIALIZE sr[1].* TO NULL
        LET sr[1].bmba001 = p_bmba003
        LET g_i = 1
    END IF
    LET g_sql = "SELECT DISTINCT bmba001,bmba002,bmba003,bmba011/bmba012 FROM bmba_t",
                " WHERE bmbaent='",g_enterprise,"' AND bmbasite='",g_site,"' ",
                "   AND bmba003='",p_bmba003,"'"
    IF p_bmba002 IS NOT NULL THEN 
       LET g_sql = g_sql," AND bmba002 ='",p_bmba002,"'" 
    END IF
    #151213-00001#1 ---mod---begin
    #LET g_sql = g_sql,"   AND to_char(bmba005,'YYYY-MM-DD')<='",g_stage[p_i].bdate,"' ",
    #                  "   AND (bmba006 IS NULL OR to_char(bmba006,'YYYY-MM-DD')>'",g_stage[p_i].bdate,"')",
    LET g_sql = g_sql,"   AND bmba005 <=to_date('",g_bdate,"','yyyy-mm-dd hh24:mi:ss')",
                      "   AND (bmba006 > to_date('",g_edate,"','yyyy-mm-dd hh24:mi:ss') OR bmba006 IS NULL)",                      
                      " ORDER BY bmba001 "
    #151213-00001#1---mod---end                       
    PREPARE aimp100_x01_bom_pre FROM g_sql
    DECLARE aimp100_x01_bom_cs CURSOR FOR aimp100_x01_bom_pre 

    WHILE TRUE
      LET l_ac = 1
      FOREACH aimp100_x01_bom_cs INTO sr[l_ac].* 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF
         #151213-00001#1 ---mod---begin
         FOR l_idx = 1 TO g_i
            IF sr[l_ac].bmba001 = g_bmba[l_idx].bmba003 THEN 
               CONTINUE FOREACH
            END IF
         END FOR
         LET g_bmba[g_i].bmba001 = sr[l_ac].bmba001
         LET g_bmba[g_i].bmba003 = sr[l_ac].bmba003
         LET g_i = g_i + 1
         #151213-00001#1 ---mod---end         
         LET l_ac = l_ac + 1
      END FOREACH 
      FOR i=1 TO l_ac-1

         #将销售预测的资料按单位分组，抓取每种单位下数量的最大值插入到临时表中
         #在将这些数量换算成料件基础单位的数量更新临时表
         #最后抓去临时表中数量最大的值作为销售预测数量
         DELETE FROM aimp100_tmp;
         EXECUTE tmp_ins USING sr[i].bmba001,g_stage[p_i].bdate,g_stage[p_i].edate
         SELECT imaa006 INTO l_imaa006 
           FROM imaa_t
          WHERE imaaent = g_enterprise
            AND imaa001 = sr[i].bmba001          
         FOREACH tmp_sel_cr INTO l_xmid014,l_xmid015  
            CALL s_aimi190_get_convert(sr[i].bmba001,l_xmid014,l_imaa006) RETURNING g_success,l_rate
            IF g_success THEN 
               LET l_xmid015 = l_xmid015 * l_rate
            END IF
            UPDATE aimp100_tmp
               SET xmid015 = l_xmid015
             WHERE xmid014 = l_xmid014  
         END FOREACH
         SELECT MAX(xmid015) INTO l_xmid_total
           FROM aimp100_tmp
         IF cl_null(l_xmid_total) THEN LET l_xmid_total = 0 END IF         
         LET l_xmid_total = l_xmid_total*sr[i].bmba011
         LET g_stage[p_i].xmid_total = g_stage[p_i].xmid_total + l_xmid_total

         SELECT SUM(inaj014*inaj011) INTO l_inaj_total
           FROM inaj_t
          WHERE inajent = g_enterprise
            AND inajsite = g_site
            AND inaj005 = sr[i].bmba001
            AND inaj004 = -1
            AND inaj022 BETWEEN g_stage[p_i].bdate AND g_stage[p_i].edate  
         IF cl_null(l_inaj_total) THEN LET l_inaj_total = 0 END IF
         LET l_inaj_total = l_inaj_total*sr[i].bmba011
         LET g_stage[p_i].inaj_total = g_stage[p_i].inaj_total + l_inaj_total         
         
         
         CALL aimp100_x01_root_bom(p_level,sr[i].bmba002,sr[i].bmba001,p_i)
      END FOR
      IF l_ac = 1 THEN 
         EXIT WHILE
      END IF
   END WHILE  
END FUNCTION

 
{</section>}
 
