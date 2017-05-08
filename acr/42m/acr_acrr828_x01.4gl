#該程式未解開Section, 採用最新樣板產出!
{<section id="acrr828_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2016-08-16 17:03:58), PR版次:0001(2016-08-17 14:37:31)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000015
#+ Filename...: acrr828_x01
#+ Description: ...
#+ Creator....: 08172(2016-07-06 15:34:52)
#+ Modifier...: 08172 -SD/PR- 08172
 
{</section>}
 
{<section id="acrr828_x01.global" readonly="Y" >}
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
       lev LIKE type_t.chr1,         #level 
       sel LIKE type_t.chr1,         #statistic type 
       vip LIKE type_t.chr1,         #vip 
       stage LIKE type_t.chr1,         #stage 
       dat1 STRING,                  #date range 
       dat2 STRING,                  #date range 
       dat3 STRING,                  #date range 
       dat4 STRING,                  #date range 
       dat5 STRING,                  #date range 
       sta1 STRING,                  #stage name 
       sta2 STRING,                  #stage name 
       sta3 STRING,                  #stage name 
       sta4 STRING,                  #stage name 
       sta5 STRING                   #stage name
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="acrr828_x01.main" readonly="Y" >}
PUBLIC FUNCTION acrr828_x01(p_arg1,p_arg2,p_arg3,p_arg4,p_arg5,p_arg6,p_arg7,p_arg8,p_arg9,p_arg10,p_arg11,p_arg12,p_arg13,p_arg14,p_arg15)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr1         #tm.lev  level 
DEFINE  p_arg3 LIKE type_t.chr1         #tm.sel  statistic type 
DEFINE  p_arg4 LIKE type_t.chr1         #tm.vip  vip 
DEFINE  p_arg5 LIKE type_t.chr1         #tm.stage  stage 
DEFINE  p_arg6 STRING                  #tm.dat1  date range 
DEFINE  p_arg7 STRING                  #tm.dat2  date range 
DEFINE  p_arg8 STRING                  #tm.dat3  date range 
DEFINE  p_arg9 STRING                  #tm.dat4  date range 
DEFINE  p_arg10 STRING                  #tm.dat5  date range 
DEFINE  p_arg11 STRING                  #tm.sta1  stage name 
DEFINE  p_arg12 STRING                  #tm.sta2  stage name 
DEFINE  p_arg13 STRING                  #tm.sta3  stage name 
DEFINE  p_arg14 STRING                  #tm.sta4  stage name 
DEFINE  p_arg15 STRING                  #tm.sta5  stage name
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.lev = p_arg2
   LET tm.sel = p_arg3
   LET tm.vip = p_arg4
   LET tm.stage = p_arg5
   LET tm.dat1 = p_arg6
   LET tm.dat2 = p_arg7
   LET tm.dat3 = p_arg8
   LET tm.dat4 = p_arg9
   LET tm.dat5 = p_arg10
   LET tm.sta1 = p_arg11
   LET tm.sta2 = p_arg12
   LET tm.sta3 = p_arg13
   LET tm.sta4 = p_arg14
   LET tm.sta5 = p_arg15
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "acrr828_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL acrr828_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL acrr828_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL acrr828_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL acrr828_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL acrr828_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="acrr828_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION acrr828_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "debssite.debs_t.debssite,l_ooefl003.ooefl_t.ooefl003,l_debs005.type_t.chr200,l_date_name.type_t.chr30,l_num.type_t.num20_6" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
 
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="acrr828_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION acrr828_x01_ins_prep()
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
 
{<section id="acrr828_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION acrr828_x01_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define(客製用) name="sel_prep.define_customerization"

#end add-point
#add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
DEFINE l_sql  STRING
DEFINE l_where  STRING
#end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
 
   #add-point:sel_prep g_select name="sel_prep.g_select"
   
   #end add-point
   LET g_select = " SELECT debssite,'','','',0"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   IF tm.vip = 'N' THEN
      IF tm.lev = '0' THEN
         LET g_select = " SELECT DISTINCT debwsite,ooefl003,rtaw002 rtaw001,debw002"
      ELSE
         LET g_select = " SELECT DISTINCT debwsite,ooefl003,rtaw001,debw002"
      END IF
      CASE tm.sel
         WHEN 1
            LET g_select = g_select,",debw016"
         WHEN 2
            LET g_select = g_select,",debw017"
         WHEN 3
            LET g_select = g_select,",debw016,debw019"
         WHEN 4
            LET g_select = g_select,",debw011,debw019"
      END CASE      
   ELSE
      IF tm.lev = '0' THEN
         LET g_select = " SELECT DISTINCT debxsite,ooefl003,rtaw002 rtaw001,debx002"
      ELSE
         LET g_select = " SELECT DISTINCT debxsite,ooefl003,rtaw001,debx002"
      END IF
      CASE tm.sel
         WHEN 1
            LET g_select = g_select,",debx017"
         WHEN 2
            LET g_select = g_select,",debx018"
         WHEN 3
            LET g_select = g_select,",debx017,debx021"
         WHEN 4
            LET g_select = g_select,",debx012,debx021"
      END CASE      
   END IF
   #end add-point
    LET g_from = " FROM debs_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   IF tm.vip = 'N' THEN
      LET g_from = " FROM debw_t",
                        " LEFT JOIN ooefl_t ON ooeflent=debwent AND ooefl001=debwsite AND ooefl002='",g_dlang,"'",
                        " LEFT JOIN rtab_t ON rtabent=debwent AND rtab002=debwsite,rtaw_t"
#                        " LEFT JOIN rtaw_t ON rtawent=debsent AND rtaw002=debs005 AND rtaw003='",tm.lev,"'"
   ELSE
      LET g_from = " FROM debx_t",
                        " LEFT JOIN ooefl_t ON ooeflent=debxent AND ooefl001=debxsite AND ooefl002='",g_dlang,"'",
                        " LEFT JOIN rtab_t ON rtabent=debxent AND rtab002=debxsite,rtaw_t"
#                        " LEFT JOIN rtaw_t ON rtawent=debtent AND rtaw002=debt005 AND rtaw003='",tm.lev,"'"
   END IF
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   IF tm.vip='N' THEN
      IF tm.lev = '0' THEN
         LET g_from = g_from," LEFT JOIN rtax_t ON rtaxent=rtawent AND rtax001=rtaw002 AND rtax003=rtaw001 AND rtax005=0 "
         LET g_where = " WHERE rtaw001 <> ' ' AND rtawent=debwent AND rtaw002=debw005 AND " ,tm.wc CLIPPED
      ELSE
         LET g_where = " WHERE rtaw001 <> ' ' AND rtawent=debwent AND rtaw002=debw005 AND rtaw003='",tm.lev,"' AND " ,tm.wc CLIPPED
      END IF
      CALL s_aooi500_sql_where(g_prog,'debwsite') RETURNING l_where
      LET g_where = g_where," AND ",l_where
   ELSE
      IF tm.lev = '0' THEN
         LET g_from = g_from," LEFT JOIN rtax_t ON rtaxent=rtawent AND rtax001=rtaw002 AND rtax003=rtaw001 AND rtax005=0 "
         LET g_where = " WHERE rtaw001 <> ' ' AND rtawent=debxent AND rtaw002=debx005 AND " ,tm.wc CLIPPED
      ELSE
         LET g_where = " WHERE rtaw001 <> ' ' AND rtawent=debxent AND rtaw002=debx005 AND rtaw003='",tm.lev,"' AND " ,tm.wc CLIPPED
      END IF
      CALL s_aooi500_sql_where(g_prog,'debxsite') RETURNING l_where
      LET g_where = g_where," AND ",l_where
   END IF   
   
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("debs_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET l_sql = ''
   IF tm.vip = 'N' THEN
      CASE tm.stage
         WHEN 1
            LET g_sql = g_sql," AND (debw002 ",tm.dat1,")"
            
         WHEN 2
            LET g_sql = g_sql," AND (debw002 ",tm.dat1," OR debw002 ",tm.dat2,")"
            
         WHEN 3
            LET g_sql = g_sql," AND (debw002 ",tm.dat1," OR debw002 ",tm.dat2," OR debw002 ",tm.dat3,")"
            
         WHEN 4
            LET g_sql = g_sql," AND (debw002 ",tm.dat1," OR debw002 ",tm.dat2," OR debw002 ",tm.dat3," OR debw002 ",tm.dat4,")"
            
      WHEN 5
            LET g_sql = g_sql," AND (debw002 ",tm.dat1," OR debw002 ",tm.dat2," OR debw002 ",tm.dat3," OR debw002 ",tm.dat4," OR debw002 ",tm.dat5,")"
            
      END CASE
      LET l_sql = " SELECT debwsite,ooefl003,rtaw001,debw002"
      CASE tm.sel
         WHEN 1
            LET l_sql = l_sql,",SUM(debw016) a"
         WHEN 2
            LET l_sql = l_sql,",SUM(debw017) a"
         WHEN 3
            LET l_sql = l_sql,",SUM(debw016)/(CASE WHEN SUM(debw019)=0 THEN 1 ELSE SUM(debw019) END ) a"
         WHEN 4
            LET l_sql = l_sql,",SUM(debw011)/(CASE WHEN SUM(debw019)=0 THEN 1 ELSE SUM(debw019) END ) a"
      END CASE
      LET g_sql = l_sql," FROM (",g_sql,")",
                          " GROUP BY debwsite,ooefl003,rtaw001,debw002"            
      LET g_sql = " SELECT debwsite,ooefl003,rtaw001,date_name,a",
                  "   FROM (",g_sql,"),acrr828_tmp",
                  "  WHERE debw002 BETWEEN date_start AND date_end"
   ELSE
      CASE tm.stage
         WHEN 1
            LET g_sql = g_sql," AND (debx002 ",tm.dat1,")"
            
         WHEN 2
            LET g_sql = g_sql," AND (debx002 ",tm.dat1," OR debx002 ",tm.dat2,")"
            
         WHEN 3
            LET g_sql = g_sql," AND (debx002 ",tm.dat1," OR debx002 ",tm.dat2," OR debx002 ",tm.dat3,")"
           
         WHEN 4
            LET g_sql = g_sql," AND (debx002 ",tm.dat1," OR debx002 ",tm.dat2," OR debx002 ",tm.dat3," OR debx002 ",tm.dat4,")"
            
         WHEN 5
            LET g_sql = g_sql," AND (debx002 ",tm.dat1," OR debx002 ",tm.dat2," OR debx002 ",tm.dat3," OR debx002 ",tm.dat4," OR debx002 ",tm.dat5,")"
            
      END CASE
      LET l_sql = " SELECT debxsite,ooefl003,rtaw001,debx002"
      CASE tm.sel
         WHEN 1
            LET l_sql = l_sql,",SUM(debx017) a"
         WHEN 2
            LET l_sql = l_sql,",SUM(debx018) a"
         WHEN 3
            LET l_sql = l_sql,",SUM(debx017)/(CASE WHEN SUM(debx021)=0 THEN 1 ELSE SUM(debx021) END ) a"
         WHEN 4
            LET l_sql = l_sql,",SUM(debx012)/(CASE WHEN SUM(debx021)=0 THEN 1 ELSE SUM(debx021) END ) a"
      END CASE
      LET g_sql = l_sql," FROM (",g_sql,")",
                          " GROUP BY debxsite,ooefl003,rtaw001,debx002"            
      LET g_sql = " SELECT debxsite,ooefl003,rtaw001,date_name,a",
                  "   FROM (",g_sql,"),acrr828_tmp",
                  "  WHERE debx002 BETWEEN date_start AND date_end"
   END IF
   #end add-point
   PREPARE acrr828_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE acrr828_x01_curs CURSOR FOR acrr828_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="acrr828_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION acrr828_x01_ins_data()
DEFINE sr RECORD 
   debssite LIKE debs_t.debssite, 
   l_ooefl003 LIKE ooefl_t.ooefl003, 
   l_debs005 LIKE type_t.chr200, 
   l_date_name LIKE type_t.chr30, 
   l_num LIKE type_t.num20_6
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_str   LIKE type_t.chr200
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH acrr828_x01_curs INTO sr.*                               
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
       SELECT rtaxl003  INTO l_str
         FROM rtaxl_t
        WHERE rtaxlent = g_enterprise 
          AND rtaxl001 = sr.l_debs005
          AND rtaxl002 = g_lang
       LET sr.l_debs005 = sr.l_debs005,".",l_str
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.debssite,sr.l_ooefl003,sr.l_debs005,sr.l_date_name,sr.l_num
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "acrr828_x01_execute"
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
 
{<section id="acrr828_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION acrr828_x01_rep_data()
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
 
{<section id="acrr828_x01.other_function" readonly="Y" >}

 
{</section>}
 
