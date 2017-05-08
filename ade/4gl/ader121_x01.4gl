#該程式未解開Section, 採用最新樣板產出!
{<section id="ader121_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2016-08-01 16:14:39), PR版次:0002(2016-09-01 18:26:05)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000024
#+ Filename...: ader121_x01
#+ Description: ...
#+ Creator....: 06948(2016-04-13 10:38:34)
#+ Modifier...: 08742 -SD/PR- 08742
 
{</section>}
 
{<section id="ader121_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#160727-00019#10 2016/08/01 By 08742   系统中定义的临时表名称超过15码在执行时会出错,所以需要将系统中定义的临时表长度超过15码的全部改掉	 	
#                                      Mod   ader121_site_temp -->ader121_tmp01
#                                      Mod   ader121_data_temp -->ader121_tmp02
#                                      Mod   ader121_data_temp1 -->ader121_tmp03
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
       wc2 STRING,                  #營運據點 
       bdate LIKE type_t.dat,         #起始日期 
       edate LIKE type_t.dat          #截止日期
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_bdate       LIKE type_t.dat
DEFINE g_edate       LIKE type_t.dat
DEFINE g_wc_site     STRING
DEFINE g_time1       DATETIME YEAR TO FRACTION
DEFINE g_time2       DATETIME YEAR TO FRACTION
#end add-point
 
{</section>}
 
{<section id="ader121_x01.main" readonly="Y" >}
PUBLIC FUNCTION ader121_x01(p_arg1,p_arg2,p_arg3,p_arg4)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 STRING                  #tm.wc2  營運據點 
DEFINE  p_arg3 LIKE type_t.dat         #tm.bdate  起始日期 
DEFINE  p_arg4 LIKE type_t.dat         #tm.edate  截止日期
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"
DEFINE l_success     LIKE type_t.num5
#end add-point
 
   LET tm.wc = p_arg1
   LET tm.wc2 = p_arg2
   LET tm.bdate = p_arg3
   LET tm.edate = p_arg4
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   IF cl_null(tm.wc2) THEN
      LET tm.wc2 = " debasite like '%' "
   END IF
   IF cl_null(tm.bdate) THEN
      LET tm.bdate = g_today
   END IF
   IF cl_null(tm.edate) THEN
      LET tm.edate = g_today
   END IF
   CALL s_date_get_date(tm.bdate,-12,0) RETURNING g_bdate
   CALL s_date_get_date(tm.edate,-12,0) RETURNING g_edate
   CALL ader121_x01_drop_temp() RETURNING l_success
   CALL ader121_x01_create_temp() RETURNING l_success
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "ader121_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL ader121_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL ader121_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL ader121_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL ader121_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL ader121_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="ader121_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION ader121_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "deba053.deba_t.deba053,l_deba053_desc.type_t.chr500,l_rtaw001.type_t.chr500,l_rtaw001_dese.type_t.chr500,deba016.deba_t.deba016,l_deba016_desc.type_t.chr500,debasite.deba_t.debasite,l_deba026_n_sum.type_t.num20_6,l_deba026_l_sum.type_t.num20_6,l_deba026_diff.type_t.num20_6,l_deba026_pcnt.type_t.num20_6,l_deba027_n_sum.type_t.num20_6,l_deba027_l_sum.type_t.num20_6,l_deba027_diff.type_t.num20_6,l_deba027_pcnt.type_t.num20_6" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
 
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="ader121_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION ader121_x01_ins_prep()
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
 
{<section id="ader121_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION ader121_x01_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define(客製用) name="sel_prep.define_customerization"

#end add-point
#add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"

#end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   CALL ader121_x01_ins_site_temp()
   CALL ader121_x01_ins_data_temp()
   #end add-point
 
   #add-point:sel_prep g_select name="sel_prep.g_select"
   
   #end add-point
   LET g_select = " SELECT deba053,'','','',deba016,'',debasite,0,0,0,0,0,0,0,0"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_select = " SELECT ",
                  "    t1.deba053, ",
                  "    t1.deba053_desc, ",
                  "    t1.rtaw001, ",
                  "    t1.rtaw001_desc, ",
                  "    t1.deba016, ",
                  "    t1.deba016_desc, ",
                  "    t1.debasite, ",
                  "    t1.deba026_sum_n, ",
                  "    t1.deba026_sum_l, ",
                  "    0,0, ",
                  "    t1.deba027_sum_n, ",
                  "    t1.deba027_sum_l, ",
                  "    0,0 "

   #end add-point
    LET g_from = " FROM deba_t,rtaxl_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET g_from = " FROM ader121_tmp03 t1 "        #160727-00019#10 Mod   ader121_data_temp1 -->ader121_tmp03
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   LET g_where = "  WHERE t1.debasite IN (",g_wc_site CLIPPED,") "
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("deba_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = g_sql,
                 #" GROUP BY t1.deba053, t1.deba053_desc, t1.rtaw001, t1.rtaw001_desc, t1.deba016, t1.deba016_desc, t1.debasite ",
                 " ORDER BY t1.debasite, t1.deba053, t1.rtaw001, t1.deba016"
                 
   #end add-point
   PREPARE ader121_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE ader121_x01_curs CURSOR FOR ader121_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="ader121_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION ader121_x01_ins_data()
DEFINE sr RECORD 
   deba053 LIKE deba_t.deba053, 
   l_deba053_desc LIKE type_t.chr500, 
   l_rtaw001 LIKE type_t.chr500, 
   l_rtaw001_dese LIKE type_t.chr500, 
   deba016 LIKE deba_t.deba016, 
   l_deba016_desc LIKE type_t.chr500, 
   debasite LIKE deba_t.debasite, 
   l_deba026_n_sum LIKE type_t.num20_6, 
   l_deba026_l_sum LIKE type_t.num20_6, 
   l_deba026_diff LIKE type_t.num20_6, 
   l_deba026_pcnt LIKE type_t.num20_6, 
   l_deba027_n_sum LIKE type_t.num20_6, 
   l_deba027_l_sum LIKE type_t.num20_6, 
   l_deba027_diff LIKE type_t.num20_6, 
   l_deba027_pcnt LIKE type_t.num20_6
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_deba026_pcnt           LIKE deba_t.deba026    #銷售增長率
DEFINE l_deba027_pcnt           LIKE deba_t.deba027    #毛利增長率
DEFINE l_sql                    STRING
DEFINE l_ooef016                LIKE ooef_t.ooef016    #幣別
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    LET l_sql = " SELECT ooef016 FROM ader121_tmp01 ",     #160727-00019#10 Mod   ader121_site_temp -->ader121_tmp01
                "  WHERE debasite = ? "
    PREPARE ader121_x01_ooef016 FROM l_sql
    LET g_time1 = cl_get_timestamp()
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH ader121_x01_curs INTO sr.*                               
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
       LET l_ooef016 = ''
       EXECUTE ader121_x01_ooef016 INTO l_ooef016
                                   USING sr.debasite
       IF cl_null(l_ooef016) THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = 'foreach:'
          LET g_errparam.code   = 'apm-00675'
          LET g_errparam.replace[1] = sr.debasite
          LET g_errparam.popup  = TRUE
          CALL cl_err()
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF
       LET sr.l_deba026_diff = sr.l_deba026_n_sum - sr.l_deba026_l_sum
       LET sr.l_deba026_pcnt = (sr.l_deba026_diff / sr.l_deba026_l_sum) * 100
       LET sr.l_deba027_diff = sr.l_deba027_n_sum - sr.l_deba027_l_sum
       LET sr.l_deba027_pcnt = (sr.l_deba027_diff / sr.l_deba027_l_sum) * 100
       LET sr.l_deba026_n_sum = s_curr_round(sr.debasite, l_ooef016, sr.l_deba026_n_sum, 2)
       LET sr.l_deba026_l_sum = s_curr_round(sr.debasite, l_ooef016, sr.l_deba026_l_sum, 2)
       LET sr.l_deba027_n_sum = s_curr_round(sr.debasite, l_ooef016, sr.l_deba027_n_sum, 2)
       LET sr.l_deba027_l_sum = s_curr_round(sr.debasite, l_ooef016, sr.l_deba027_l_sum, 2)
       LET sr.l_deba026_diff = s_curr_round(sr.debasite, l_ooef016, sr.l_deba026_diff, 2)
       LET sr.l_deba027_diff = s_curr_round(sr.debasite, l_ooef016, sr.l_deba027_diff, 2)
       LET sr.l_deba026_pcnt = s_curr_round(sr.debasite, l_ooef016, sr.l_deba026_pcnt, 2)
       LET sr.l_deba027_pcnt = s_curr_round(sr.debasite, l_ooef016, sr.l_deba027_pcnt, 2)
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.deba053,sr.l_deba053_desc,sr.l_rtaw001,sr.l_rtaw001_dese,sr.deba016,sr.l_deba016_desc,sr.debasite,sr.l_deba026_n_sum,sr.l_deba026_l_sum,sr.l_deba026_diff,sr.l_deba026_pcnt,sr.l_deba027_n_sum,sr.l_deba027_l_sum,sr.l_deba027_diff,sr.l_deba027_pcnt
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "ader121_x01_execute"
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
    LET g_time2 = cl_get_timestamp()
    DISPLAY "[calculate each data] Time Cost: ",g_time2-g_time1
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="ader121_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION ader121_x01_rep_data()
#add-point:rep_data.define (客製用) name="rep_data.define_customerization"

#end add-point:rep_data.define
#add-point:rep_data.define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="rep_data.define"
DEFINE l_success    LIKE type_t.num5
#end add-point:rep_data.define
 
    #add-point:rep_data.before name="rep_data.before"
    
    #end add-point:rep_data.before
    
    CALL cl_xg_view()
    #add-point:rep_data.after name="rep_data.after"
    CALL ader121_x01_drop_temp() RETURNING l_success
    #end add-point:rep_data.after
END FUNCTION
 
{</section>}
 
{<section id="ader121_x01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 加總銷售額、毛利
# Memo...........: 160329-00036#5 add
# Usage..........: CALL ader121_x01_sel_sum_prep()
# Date & Author..: 16/04/14 By 06948 tsungyung
# Modify.........:
################################################################################
PRIVATE FUNCTION ader121_x01_sel_sum_prep()
DEFINE l_deba026_n_tot          LIKE deba_t.deba026    #符合門店本期銷售總額
DEFINE l_deba026_l_tot          LIKE deba_t.deba026    #符合門店去年銷售總額
DEFINE l_deba026_d_tot          LIKE deba_t.deba026    #符合門店銷售差額 (本期-去年)
DEFINE l_deba026_pcnt_tot       LIKE deba_t.deba026    #符合門店銷售增長率
DEFINE l_gp_n_tot               LIKE deba_t.deba026    #符合門店本期毛利額
DEFINE l_gp_l_tot               LIKE deba_t.deba026    #符合門店去年毛利額
DEFINE l_gp_d_tot               LIKE deba_t.deba026    #符合門店毛利差額 (本期-去年)
DEFINE l_gp_pcnt_tot            LIKE deba_t.deba026    #符合門店本期毛利增長率
DEFINE l_deba026_n              LIKE deba_t.deba026    #指定門店本期銷售總額
DEFINE l_deba026_l              LIKE deba_t.deba026    #指定門店去年銷售總額
DEFINE l_deba026_d              LIKE deba_t.deba026    #指定門店銷售差額 (本期-去年)
DEFINE l_deba026_pcnt           LIKE deba_t.deba026    #指定門店銷售增長率
DEFINE l_gp_n                   LIKE deba_t.deba026    #指定門店本期毛利額
DEFINE l_gp_l                   LIKE deba_t.deba026    #指定門店去年毛利額
DEFINE l_gp_d                   LIKE deba_t.deba026    #指定門店毛利差額 (本期-去年)
DEFINE l_gp_pcnt                LIKE deba_t.deba026    #指定門店本期毛利增長率
DEFINE l_sql                    STRING

   #每一個門店的總和  &  所有門店的總和
   LET l_sql = " SELECT SUM(deba026), SUM(deba026-deba022) ",
               "   FROM deba_t ",
               "  WHERE debaent = '",g_enterprise,"' ",
               "    AND ( t1.deba002 BETWEEN '",tm.bdate,"' AND '",tm.edate,"' )",
               "    AND ",tm.wc CLIPPED,
               "    AND debasite = ? "
   LET l_sql = cl_sql_add_mask(l_sql)
   PREPARE ader121_x01_sel_sum FROM l_sql
   EXECUTE ader121_x01_sel_sum INTO l_deba026_n_tot,l_gp_n_tot
   IF cl_null(l_deba026_n_tot) THEN
      LET l_deba026_n_tot = 0
   END IF
   IF cl_null(l_gp_n_tot) THEN
      LET l_gp_n_tot = 0
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: create temp table
# Memo...........:
# Usage..........: ader121_x01_create_temp()
# Date & Author..: 16/04/15 By 06948 tsungyung
# Modify.........:
################################################################################
PRIVATE FUNCTION ader121_x01_create_temp()
DEFINE r_success       LIKE type_t.num5

   LET r_success = TRUE
   WHENEVER ERROR CONTINUE 
   
   IF NOT ader121_x01_drop_temp() THEN
      LET r_success = FALSE
      RETURN r_success
   END IF 
   
   CREATE TEMP TABLE ader121_tmp01(      #160727-00019#10 Mod   ader121_site_temp -->ader121_tmp01
           seq      LIKE type_t.num5,       
      debasite      LIKE deba_t.debasite,
      debasite_desc LIKE ooefl_t.ooefl003,
      ooef016       LIKE ooef_t.ooef016
      )
      
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'Create ader121_tmp01'  #160727-00019#10 Mod   ader121_site_temp -->ader121_tmp01
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF   
   
   CREATE TEMP TABLE ader121_tmp02(          #160727-00019#10 Mod   ader121_data_temp -->ader121_tmp02
      deba053       LIKE deba_t.deba053,
      deba053_desc  LIKE type_t.chr500,
      rtaw001       LIKE rtaw_t.rtaw001,
      rtaw001_desc  LIKE type_t.chr500,
      deba016       LIKE deba_t.deba016,
      deba016_desc  LIKE type_t.chr500,
      debasite      LIKE deba_t.debasite,
      deba002       LIKE deba_t.deba002,
      deba026       LIKE deba_t.deba026,
      deba027       LIKE deba_t.deba027
      )

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'Create ader121_tmp02'  #160727-00019#10 Mod   ader121_data_temp -->ader121_tmp02
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF   

   CREATE TEMP TABLE ader121_tmp03(        #160727-00019#10 Mod   ader121_data_temp1 -->ader121_tmp03
      deba053       LIKE deba_t.deba053,
      deba053_desc  LIKE type_t.chr500,
      rtaw001       LIKE rtaw_t.rtaw001,
      rtaw001_desc  LIKE type_t.chr500,
      deba016       LIKE deba_t.deba016,
      deba016_desc  LIKE type_t.chr500,
      debasite      LIKE deba_t.debasite,
      deba026_sum_n LIKE deba_t.deba026,
      deba026_sum_l LIKE deba_t.deba026,  
      deba027_sum_n LIKE deba_t.deba027,
      deba027_sum_l LIKE deba_t.deba027 
      )

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'Create ader121_tmp03'        #160727-00019#10 Mod   ader121_data_temp1 -->ader121_tmp03
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF   

   RETURN r_success
    
END FUNCTION

################################################################################
# Descriptions...: drop temp table
# Memo...........:
# Usage..........: CALL ader121_x01_drop_temp()
# Date & Author..: 16/04/15 By 06948 tsungyung
# Modify.........:
################################################################################
PRIVATE FUNCTION ader121_x01_drop_temp()
DEFINE r_success       LIKE type_t.num5
   
   LET r_success = TRUE
   WHENEVER ERROR CONTINUE 

   DROP TABLE ader121_tmp01        #160727-00019#10 Mod   ader121_site_temp -->ader121_tmp01
   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop ader121_tmp01'      #160727-00019#10 Mod   ader121_site_temp -->ader121_tmp01
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   DROP TABLE ader121_tmp02          #160727-00019#10 Mod   ader121_data_temp -->ader121_tmp02
   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop ader121_tmp02'      #160727-00019#10 Mod   ader121_data_temp -->ader121_tmp02
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   DROP TABLE ader121_tmp03      #160727-00019#10 Mod   ader121_data_temp1 -->ader121_tmp03
   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop ader121_tmp03'   #160727-00019#10 Mod   ader121_data_temp1 -->ader121_tmp03
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF   

   RETURN r_success
   
END FUNCTION

################################################################################
# Descriptions...: ins data into temp table
# Memo...........:
# Usage..........: CALL ader121_x01_ins_site_temp()
# Date & Author..: 16/04/15 By 06948 tsungyung
# Modify.........:
################################################################################
PRIVATE FUNCTION ader121_x01_ins_site_temp()
DEFINE l_i            LIKE type_t.num5
DEFINE l_wc           STRING
DEFINE l_cnt          LIKE type_t.num5
DEFINE l_site         LIKE deba_t.debasite
DEFINE l_sql          STRING
DEFINE l_desc         LIKE type_t.chr500
DEFINE l_str          STRING

   #清空ader121_tmp01
   DELETE FROM ader121_tmp01   #160727-00019#10 Mod   ader121_site_temp -->ader121_tmp01
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'del_ader121_tmp01'  #160727-00019#10 Mod   del_site_temp -->del_ader121_tmp01
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   
   LET l_wc = cl_str_replace_multistr(tm.wc2,"debasite","ooef001")
   LET l_sql ="INSERT INTO ader121_tmp01(seq,debasite,debasite_desc,ooef016) ",   #160727-00019#10 Mod   ader121_site_temp -->ader121_tmp01
              "       SELECT ROW_NUMBER() OVER (ORDER BY ooef001) seq,ooef001, ",
              "              (SELECT ooefl003 FROM ooefl_t ",
              "                WHERE ooeflent = ",g_enterprise," AND ooefl001 = ooef001 AND ooefl002 = '",g_dlang,"') ",
              "              ,ooef016 ",
              "         FROM  ",
              "            (SELECT UNIQUE ooef001,ooef016 FROM ooef_t ",
              "              WHERE ooefent = ",g_enterprise," AND ",l_wc," )"
   PREPARE ader121_ins_site_temp FROM l_sql
   EXECUTE ader121_ins_site_temp               
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins_site_temp_pre'   
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF 
   
     
   LET l_cnt = 0
   SELECT MAX(seq) INTO l_cnt
     FROM ader121_tmp01        #160727-00019#10 Mod   ader121_site_temp -->ader121_tmp01
     
   IF l_cnt > 11 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ade-00169' #只顯示11家門店
      LET g_errparam.replace[1] = "11"
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      
      DELETE FROM ader121_tmp01 WHERE seq > 11    #160727-00019#10 Mod   ader121_site_temp -->ader121_tmp01
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'ins_ader121_tmp01_pre'   #160727-00019#10 Mod   ins_site_temp_pre -->ins_ader121_tmp01_pre
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF 
      
      LET l_cnt = 11
      
   END IF
   
   LET g_wc_site = ''
   FOR l_i = 1 TO l_cnt
      LET l_site = ''
      SELECT debasite INTO l_site
        FROM ader121_tmp01     #160727-00019#10 Mod   ader121_site_temp -->ader121_tmp01
       WHERE seq = l_i
      IF NOT cl_null(l_site) THEN
         LET g_wc_site = g_wc_site CLIPPED,"'",l_site CLIPPED,"',"
      END IF
   END FOR
   LET g_wc_site = g_wc_site.subString(1,g_wc_site.getLength() - 1)
END FUNCTION

################################################################################
# Descriptions...: ins data into temp table
# Memo...........:
# Usage..........: CALL ader121_x01_ins_data_temp()
# Date & Author..: 16/04/15 By 06948 tsungyung
# Modify.........:
################################################################################
PRIVATE FUNCTION ader121_x01_ins_data_temp()
DEFINE l_sql          STRING

   DELETE FROM ader121_tmp02          #160727-00019#10 Mod   ader121_data_temp -->ader121_tmp02
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'del_ader121_tmp02'   #160727-00019#10 Mod   del_data_temp -->del_ader121_tmp02
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   
   DELETE FROM ader121_tmp03     #160727-00019#10 Mod   ader121_data_temp1 -->ader121_tmp03
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'del_ader121_tmp03'        #160727-00019#10 Mod   del_data_temp1 -->del_ader121_tmp03
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF   

   LET l_sql = " INSERT INTO ader121_tmp02 (",       #160727-00019#10 Mod   ader121_data_temp -->ader121_tmp02
               " deba053, deba053_desc, rtaw001, rtaw001_desc, deba016, deba016_desc, ",
               " debasite, deba002, deba026, deba027 ) ",
               " SELECT t1.deba053, ",
               "        (SELECT rtaxl003 ",
               "           FROM rtaxl_t ",
               "          WHERE     rtaxlent = t1.debaent ",
               "                AND rtaxl001 = t1.deba053 ",
               "                AND rtaxl002 = '",g_dlang,"') deba053_desc, ",
               "        t2.rtaw001, ",
               "        (SELECT rtaxl003 ",
               "           FROM rtaxl_t ",
               "          WHERE     rtaxlent = t2.rtawent ",
               "                AND rtaxl001 = t2.rtaw001 ",
               "                AND rtaxl002 = '",g_dlang,"') rtaw001_desc, ",
               "        t1.deba016, ",
               "        (SELECT rtaxl003 ",
               "           FROM rtaxl_t ",
               "          WHERE     rtaxlent = t1.debaent ",
               "                AND rtaxl001 = t1.deba016 ",
               "                AND rtaxl002 = '",g_dlang,"') deba016_desc, ",
               "        t1.debasite, ",
               "        t1.deba002,  ",
               "        COALESCE(t1.deba026,0), ",
               "        COALESCE(t1.deba027,0) ",
               "  FROM deba_t t1 ",
               "  LEFT JOIN rtaw_t t2 on ",
               "                  t2.rtawent = t1.debaent ",
               "              AND t2.rtaw002 = t1.deba016 ",
               "              AND t2.rtaw003 = '",cl_get_para(g_enterprise,"","E-CIR-0062"),"' ",
               "  WHERE t1.debaent = '",g_enterprise,"' ",
               "       AND (t1.deba002 BETWEEN '",tm.bdate,"' AND '",tm.edate,"' ",
               "        OR t1.deba002 BETWEEN '",g_bdate,"' AND '",g_edate,"' )",
               "       AND ",tm.wc CLIPPED,
               "       AND t1.debasite IN (",g_wc_site,") "
   LET g_time1 = cl_get_timestamp()
   PREPARE ader121_ins_data_temp FROM l_sql
   EXECUTE ader121_ins_data_temp   
   LET g_time2 = cl_get_timestamp()
   DISPLAY "[insert into ader121_tmp02] COUNT: ", SQLCA.sqlerrd[3],", Time Cost: ",g_time2-g_time1   #160727-00019#10 Mod   ader121_data_temp -->ader121_tmp02
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins_data_temp_pre'             
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF 
   
   CREATE INDEX ader121_tmp_index ON ader121_tmp02(debasite,deba053,rtaw001,deba016)    #160727-00019#10 Mod   ader121_data_temp -->ader121_tmp02
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "CREATE INDEX ader121_tmp02 ERROR"    #160727-00019#10 Mod   ader121_data_temp -->ader121_tmp02
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF
   IF cl_db_generate_analyze("ader121_tmp02") THEN END IF   #160727-00019#10 Mod   ader121_data_temp -->ader121_tmp02
   
   LET l_sql = " INSERT INTO ader121_tmp03 (",     #160727-00019#10 Mod   ader121_data_temp1 -->ader121_tmp03
               " deba053, deba053_desc, rtaw001, rtaw001_desc, deba016, deba016_desc, ",
               " debasite, deba026_sum_n, deba026_sum_l, ",
               " deba027_sum_n, deba027_sum_l ) ",
               " SELECT ",
               "    t1.deba053, ",
               "    t1.deba053_desc, ",
               "    t1.rtaw001, ",
               "    t1.rtaw001_desc, ",
               "    t1.deba016, ",
               "    t1.deba016_desc, ",
               "    t1.debasite, ",
               " COALESCE(( SELECT SUM(COALESCE(t3.deba026,0)) FROM ader121_tmp02 t3 ",    #160727-00019#10 Mod   ader121_data_temp -->ader121_tmp02
               "    WHERE t1.deba016 = t3.deba016 ",
               "      AND t1.deba053 = t3.deba053 ",
               "      AND t1.rtaw001 = t3.rtaw001 ",
               "      AND t1.debasite = t3.debasite ",
               "      AND t3.deba002 BETWEEN'",tm.bdate,"' AND '",tm.edate,"' ",
               " GROUP BY t3.deba016,t3.deba053,t3.rtaw001,t3.debasite ),0) t3_deba026, ",
               " COALESCE(( SELECT SUM(COALESCE(t4.deba026,0)) FROM ader121_tmp02 t4 ",   #160727-00019#10 Mod   ader121_data_temp -->ader121_tmp02
               "    WHERE t1.deba016 = t4.deba016 ",
               "      AND t1.deba053 = t4.deba053 ",
               "      AND t1.rtaw001 = t4.rtaw001 ",
               "      AND t1.debasite = t4.debasite ",
               "      AND t4.deba002 BETWEEN'",g_bdate,"' AND '",g_edate,"' ",
               " GROUP BY t4.deba016,t4.deba053,t4.rtaw001,t4.debasite ),0) t4_deba026, ",   #160727-00019#10 Mod   ader121_data_temp -->ader121_tmp02
               " COALESCE(( SELECT SUM(COALESCE(t5.deba027,0)) FROM ader121_tmp02 t5 ",   
               "    WHERE t1.deba016 = t5.deba016 ",
               "      AND t1.deba053 = t5.deba053 ",
               "      AND t1.rtaw001 = t5.rtaw001 ",
               "      AND t1.debasite = t5.debasite ",
               "      AND t5.deba002 BETWEEN'",tm.bdate,"' AND '",tm.edate,"' ",
               " GROUP BY t5.deba016,t5.deba053,t5.rtaw001,t5.debasite ),0) t5_deba026, ",
               " COALESCE(( SELECT SUM(COALESCE(t6.deba027,0)) FROM ader121_tmp02 t6 ",   #160727-00019#10 Mod   ader121_data_temp -->ader121_tmp02
               "    WHERE t1.deba016 = t6.deba016 ",
               "      AND t1.deba053 = t6.deba053 ",
               "      AND t1.rtaw001 = t6.rtaw001 ",
               "      AND t1.debasite = t6.debasite ",
               "      AND t6.deba002 BETWEEN'",g_bdate,"' AND '",g_edate,"' ",
               " GROUP BY t6.deba016,t6.deba053,t6.rtaw001,t6.debasite ),0) t6_deba026 ",
               " FROM ader121_tmp02 t1 ",   #160727-00019#10 Mod   ader121_data_temp -->ader121_tmp02
               " GROUP BY ",
               " t1.debasite, ",
               " t1.rtaw001, ",
               " t1.rtaw001_desc, ",
               " t1.deba053, ",
               " t1.deba053_desc, ",
               " t1.deba016, ",
               " t1.deba016_desc "
               
   LET g_time1 = cl_get_timestamp()
   PREPARE ader121_ins_data_temp1 FROM l_sql
   EXECUTE ader121_ins_data_temp1   
   LET g_time2 = cl_get_timestamp()
   DISPLAY "[insert into ader121_tmp03] COUNT: ", SQLCA.sqlerrd[3],", Time Cost: ",g_time2-g_time1   #160727-00019#10 Mod   ader121_data_temp1 -->ader121_tmp03
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins_data_temp1_pre'        
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF 

END FUNCTION

 
{</section>}
 
