#該程式未解開Section, 採用最新樣板產出!
{<section id="axmr040_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2015-11-19 10:30:56), PR版次:0003(2015-11-19 11:12:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000059
#+ Filename...: axmr040_x01
#+ Description: ...
#+ Creator....: 04543(2014-12-17 14:07:30)
#+ Modifier...: 06814 -SD/PR- 06814
 
{</section>}
 
{<section id="axmr040_x01.global" readonly="Y" >}
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
       y STRING,                  #基準年度 
       m STRING,                  #基準月份 
       ys STRING,                  #起始年度 
       ms STRING,                  #起始月份 
       ye STRING,                  #截止年度 
       me STRING,                  #截止月份 
       minus STRING,                  #扣除退貨數量 
       range STRING                   #降價率範圍
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_from_where1   STRING
DEFINE g_from_where2   STRING
#end add-point
 
{</section>}
 
{<section id="axmr040_x01.main" readonly="Y" >}
PUBLIC FUNCTION axmr040_x01(p_arg1,p_arg2,p_arg3,p_arg4,p_arg5,p_arg6,p_arg7,p_arg8,p_arg9)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 STRING                  #tm.y  基準年度 
DEFINE  p_arg3 STRING                  #tm.m  基準月份 
DEFINE  p_arg4 STRING                  #tm.ys  起始年度 
DEFINE  p_arg5 STRING                  #tm.ms  起始月份 
DEFINE  p_arg6 STRING                  #tm.ye  截止年度 
DEFINE  p_arg7 STRING                  #tm.me  截止月份 
DEFINE  p_arg8 STRING                  #tm.minus  扣除退貨數量 
DEFINE  p_arg9 STRING                  #tm.range  降價率範圍
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.y = p_arg2
   LET tm.m = p_arg3
   LET tm.ys = p_arg4
   LET tm.ms = p_arg5
   LET tm.ye = p_arg6
   LET tm.me = p_arg7
   LET tm.minus = p_arg8
   LET tm.range = p_arg9
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "axmr040_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL axmr040_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL axmr040_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL axmr040_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL axmr040_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL axmr040_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="axmr040_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION axmr040_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "xmdl008.xmdl_t.xmdl008,l_imaa003.imaa_t.imaa003,l_imaa004.imaa_t.imaa004,l_feature.type_t.chr300,l_rtaxl003.type_t.chr500,l_imaa127.type_t.chr50,l_imaa127_desc.type_t.chr30,l_imaa127desc.type_t.chr80,l_xmdk003_ooag011.type_t.chr300,l_date_base.type_t.chr30,l_price_base.type_t.num20_6,l_price_avg.type_t.num20_6,l_amount.type_t.num20_6,l_cost.type_t.num20_6,l_cost_base.type_t.num20_6,l_cost_down.type_t.num20_6,l_rate.type_t.num20_6,xmdk016.xmdk_t.xmdk016,l_coin.type_t.chr30" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="axmr040_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION axmr040_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="axmr040_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axmr040_x01_sel_prep()
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
   #151113-00022#5 20151119 mark by beckxie---S
   #LET g_select = " SELECT DISTINCT xmdl008,'','',xmdl009,NULL,'','','','','',trim(xmdk003)||'.'||trim(ooag_t.ooag011),",
   #               "                 '','','','','','','','',xmdk016,'',xmdk003 "
   #151113-00022#5 20151119 mark by beckxie---E
   #151113-00022#5 20151119 add by beckxie---S
   LET g_select = " SELECT DISTINCT xmdl008,C1.imaal003,C1.imaal004,xmdl009,'',NULL,D1.rtaxl003,imaa_t.imaa127,D2.oocql004, ",
                  "        CASE WHEN D2.oocql004 IS NULL THEN imaa_t.imaa127 ELSE trim(imaa_t.imaa127)||'.'||trim(D2.oocql004) END , ",
                  "        CASE WHEN A1.ooag011 IS NULL THEN xmdk_t.xmdk003 ELSE trim(xmdk003)||'.'||trim(A1.ooag011) END , ",     
                  "        '','','','','','','','',xmdk016,A2.ooail003,xmdk003   "
   #151113-00022#5 20151119 add by beckxie---E
#   #end add-point
#   LET g_select = " SELECT xmdl008,'','',xmdl009,NULL,'','','','','',trim(xmdk003)||'.'||trim((SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = xmdk_t.xmdk003 AND ooag_t.ooagent = xmdk_t.xmdkent)), 
#       '','','','','','','','',xmdk016,'',xmdk003"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   #151113-00022#5 20151119 mark by beckxie---S
   #LET g_from = " FROM xmdk_t LEFT OUTER JOIN ooag_t ON ooag_t.ooagent = xmdk_t.xmdkent AND ooag_t.ooag001 = xmdk_t.xmdk003",
   #             "     ,pmaa_t LEFT OUTER JOIN oocq_t ON oocq_t.oocqent = pmaa_t.pmaaent AND oocq_t.oocq001 = '281' AND oocq_t.oocq002 = pmaa_t.pmaa090",
   #             "     ,xmdl_t",
   #             "     ,imaa_t LEFT OUTER JOIN rtax_t ON rtax_t.rtaxent = imaa_t.imaaent AND rtax_t.rtax001 = imaa_t.imaa009"
   #151113-00022#5 20151119 mark by beckxie---E
   #151113-00022#5 20151119 add by beckxie---S
   LET g_from = " FROM xmdk_t ",
                "      LEFT OUTER JOIN ooag_t A1 ON A1.ooagent = xmdk_t.xmdkent AND A1.ooag001 = xmdk_t.xmdk003 ",
                "      LEFT OUTER JOIN ooail_t A2 ON A2.ooailent = xmdk_t.xmdkent AND A2.ooail001 = xmdk_t.xmdk016 AND A2.ooail002 = '",g_dlang,"' ",
                "      ,pmaa_t ",
                "      LEFT OUTER JOIN oocq_t B1 ON B1.oocqent = pmaa_t.pmaaent AND B1.oocq001 = '281' AND B1.oocq002 = pmaa_t.pmaa090 ",
                "      ,xmdl_t ",
                "      LEFT OUTER JOIN imaal_t C1 ON C1.imaalent = xmdl_t.xmdlent AND C1.imaal001 = xmdl_t.xmdl008 AND C1.imaal002 = '",g_dlang,"' ",
                "      ,imaa_t ",
                "      LEFT OUTER JOIN rtaxl_t D1 ON D1.rtaxlent = imaa_t.imaaent AND D1.rtaxl001 = imaa_t.imaa009  AND D1.rtaxl002='",g_dlang,"' ",
                "      LEFT OUTER JOIN oocql_t D2 ON D2.oocqlent = imaa_t.imaaent AND D2.oocql001 = '2003' AND D2.oocql002 = imaa_t.imaa127 AND oocql003 = '",g_dlang,"' "
   #151113-00022#5 20151119 add by beckxie---E
#   #end add-point
#    LET g_from = " FROM xmdk_t LEFT OUTER JOIN ( SELECT xmdl_t.* FROM xmdl_t  ) x  ON xmdk_t.xmdkent  
#        = x.xmdlent AND xmdk_t.xmdkdocno = x.xmdldocno"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET g_where = " WHERE pmaaent = xmdkent AND xmdlent = xmdkent AND imaaent = xmdkent",
                 "   AND pmaa001 = xmdk007",
                 "   AND xmdldocno = xmdkdocno",
                 "   AND imaa001 = xmdl008",
                 "   AND ",tm.wc CLIPPED
#   #end add-point
#    LET g_where = " WHERE xmdk_t.xmdk000 IN ('1','2','3') AND " ,tm.wc CLIPPED
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   LET g_where = g_where ,cl_sql_add_filter("xmdk_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED," AND xmdk_t.xmdk000 IN ('1','2','3')"
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
#   #end add-point:sel_prep.sql.before
#   LET g_where = g_where ,cl_sql_add_filter("xmdk_t")   #資料過濾功能
#   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
#   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
# 
#   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   DISPLAY "g_sql:",g_sql
   LET g_from_where1 = g_from CLIPPED," ",g_where CLIPPED," AND xmdk_t.xmdk000 IN ('1','2','3')"
   LET g_from_where2 = g_from CLIPPED," ",g_where CLIPPED," AND xmdk_t.xmdk000 IN ('5','6')"
   #end add-point
   PREPARE axmr040_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE axmr040_x01_curs CURSOR FOR axmr040_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="axmr040_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION axmr040_x01_ins_data()
DEFINE sr RECORD 
   xmdl008 LIKE xmdl_t.xmdl008, 
   l_imaa003 LIKE imaa_t.imaa003, 
   l_imaa004 LIKE imaa_t.imaa004, 
   xmdl009 LIKE xmdl_t.xmdl009, 
   l_feature LIKE type_t.chr300, 
   l_imaa009 LIKE imaa_t.imaa009, 
   l_rtaxl003 LIKE type_t.chr500, 
   l_imaa127 LIKE type_t.chr50, 
   l_imaa127_desc LIKE type_t.chr30, 
   l_imaa127desc LIKE type_t.chr80, 
   l_xmdk003_ooag011 LIKE type_t.chr300, 
   l_date_base LIKE type_t.chr30, 
   l_price_base LIKE type_t.num20_6, 
   l_price_avg LIKE type_t.num20_6, 
   l_amount LIKE type_t.num20_6, 
   l_cost LIKE type_t.num20_6, 
   l_cost_base LIKE type_t.num20_6, 
   l_cost_down LIKE type_t.num20_6, 
   l_rate LIKE type_t.num20_6, 
   xmdk016 LIKE xmdk_t.xmdk016, 
   l_coin LIKE type_t.chr30, 
   xmdk003 LIKE xmdk_t.xmdk003
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_bdate     LIKE type_t.dat
   DEFINE l_edate     LIKE type_t.dat
   DEFINE l_year      LIKE type_t.num10
   DEFINE l_month     LIKE type_t.num10
   DEFINE l_date      LIKE type_t.dat
   DEFINE l_date1     LIKE type_t.dat
   DEFINE l_date2     LIKE type_t.dat
   
   DEFINE l_amount    LIKE type_t.num20_6 
   DEFINE l_cost      LIKE type_t.num20_6
   DEFINE l_sql       STRING
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #基準日期
    LET l_year = tm.y USING '<<<<'
    LET l_month = tm.m USING '<<'

    LET l_date = MDY(l_month,'1',l_year)    
    
    #開始日期
    LET l_bdate = MDY(tm.ms,'01',tm.ys)
    
    #截止日期
    IF tm.me = 12 THEN
       LET l_edate = MDY('1','1',tm.ye + 1) - 1
    ELSE
       LET l_edate = MDY(tm.me + 1,'1',tm.ye) - 1
    END IF

    LET l_sql = "SELECT DISTINCT TO_CHAR(xmdkdocdt,'YYYY'),TO_CHAR(xmdkdocdt,'MM')",g_from_where1 CLIPPED ,
                "   AND xmdkdocdt >= '",l_date,"'",
                " ORDER BY TO_CHAR(xmdkdocdt,'YYYY'),TO_CHAR(xmdkdocdt,'MM')"
    PREPARE axmr040_x01_pre0 FROM l_sql
    DECLARE axmr040_x01_cs0 CURSOR FOR axmr040_x01_pre0

    #基準年月=主畫面的基準年度要月份
    #基準單價=出貨日期於基準年月的平均單價(xmdl024)
    LET l_sql = "SELECT AVG(xmdl024) ",g_from_where1 CLIPPED ,
                "   AND xmdkdocdt BETWEEN ? AND ?",
                "   AND xmdl008 = ?",
                "   AND xmdk003 = ?",
                "   AND xmdk016 = ?"
    PREPARE axmr040_x01_pre1 FROM l_sql
    
    #期間平均單價=出貨日期於分析起始年月與分析截止年月間的平均單價(xmdl024)
    #期間出貨數量=出貨日期於分析起始年月與分析截止年月間的出貨數量加總
    #期間出貨金額=出貨日期於分析起始年月與分析截止年月間的含稅金額加總
    LET l_sql = "SELECT AVG(xmdl024),SUM(xmdl018),SUM(xmdl028) " CLIPPED ,
                " ", g_from_where1 CLIPPED ,
                " AND xmdkdocdt BETWEEN ? AND ? AND xmdl008 = ? AND xmdk003 = ? AND xmdk016 = ?"
    PREPARE axmr040_x01_pre2 FROM l_sql
    
    #主畫面"扣除退貨數量金額"="Y"時，
    #期間出貨數量、期間出貨金額需扣除退貨資料(單據性質='5.出貨簽退單,6.銷退單')
    LET l_sql = "SELECT SUM(xmdl018),SUM(xmdl028) " CLIPPED ,
                " ", g_from_where2 CLIPPED ,
                " AND xmdkdocdt BETWEEN ? AND ? AND xmdl008 = ? AND xmdk003 = ? AND xmdk016 = ?"
    PREPARE axmr040_x01_pre3 FROM l_sql
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH axmr040_x01_curs INTO sr.*                               
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

       IF cl_null(sr.xmdl008) THEN
          CONTINUE FOREACH
       END IF
       #151113-00022#5 20151119 mark by beckxie---S
       ##品名、規格
       #CALL s_desc_get_item_desc(sr.xmdl008) RETURNING sr.l_imaa003,sr.l_imaa004
       #151113-00022#5 20151119 mark by beckxie---E
       #產品特徵
       CALL s_feature_description(sr.xmdl008,sr.xmdl009) RETURNING l_success,sr.l_feature
       #151113-00022#5 20151119 mark by beckxie---S
       ##幣別
       #CALL s_desc_get_currency_desc(sr.xmdk016) RETURNING sr.l_coin
       ##產品分類
       #CALL axmr040_x01_sel_imaa009(sr.xmdl008) RETURNING sr.l_imaa009
       #CALL s_desc_get_rtaxl003_desc(sr.l_imaa009) RETURNING sr.l_rtaxl003
       ##系列    20150819  by dorislai add   (S)
       #   #用料號抓取系列
       #SELECT imaa127 INTO sr.l_imaa127 FROM imaa_t
       # WHERE imaa001 = sr.xmdl008
       #   AND imaaent = g_enterprise
       #   #抓取系列說明
       #CALL s_desc_get_acc_desc('2003',sr.l_imaa127)  RETURNING sr.l_imaa127_desc   
       #IF NOT cl_null(sr.l_imaa127_desc) THEN
       #   LET sr.l_imaa127desc = sr.l_imaa127,'.',sr.l_imaa127_desc 
       #ELSE
       #   LET sr.l_imaa127desc = ''
       #END IF
       #151113-00022#5 20151119 mark by beckxie---E
       #        20150819  by dorislai add   (E)
       FOREACH axmr040_x01_cs0 INTO l_year,l_month
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.extend = "axmr040_x01_cs0"
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.popup  = FALSE
             CALL cl_err()
             
             EXIT FOREACH
          END IF
       
          LET l_year = l_year USING '<<<<'
          LET l_month = l_month USING '<<'

          LET l_date1 = MDY(l_month,'1',l_year)
          IF l_month = 12 THEN
             LET l_date2 = MDY('1','1',l_year + 1) - 1
          ELSE
             LET l_date2 = MDY(l_month + 1,'1',l_year) - 1
          END IF
    
          EXECUTE axmr040_x01_pre1 USING l_date1,l_date2,sr.xmdl008,sr.xmdk003,sr.xmdk016
          INTO sr.l_price_base    #基準單價

          IF cl_null(sr.l_price_base) THEN
             CONTINUE FOREACH
          ELSE
             LET sr.l_date_base = l_year CLIPPED,'/',l_month CLIPPED   #基準年月
             EXIT FOREACH
          END IF

       END FOREACH

       EXECUTE axmr040_x01_pre2 USING l_bdate,l_edate,sr.xmdl008,sr.xmdk003,sr.xmdk016
       INTO sr.l_price_avg,sr.l_amount,sr.l_cost    #期間平均單價、期間出貨數量、期間出貨金額

       #取不到計算基準單價、期間平均單價
       IF cl_null(sr.l_price_base) AND cl_null(sr.l_price_avg) THEN
          CONTINUE FOREACH
       END IF

       IF tm.minus = 'Y' THEN
         EXECUTE axmr040_x01_pre3 USING l_bdate,l_edate,sr.xmdl008,sr.xmdk003,sr.xmdk016
         INTO l_amount,l_cost
         
         IF NOT cl_null(l_amount) THEN
            LET sr.l_amount = sr.l_amount - l_amount
         END IF
         IF NOT cl_null(l_amount) THEN
            LET sr.l_cost = sr.l_cost - l_cost
         END IF
       END IF

       #基準金額=基準單價*期間出貨數量
       LET sr.l_cost_base = sr.l_price_base * sr.l_amount
       #降價金額=(基準單價-平均單價)*期間出貨數量
       LET sr.l_cost_down = (sr.l_price_base - sr.l_price_avg) * sr.l_amount
       #降價率=降價金額/基準金額
       LET sr.l_rate = sr.l_cost_down / sr.l_cost_base

       #主畫面"降價率列印範圍"="0"時，全部列印，否則僅列印降價率於降價率列印範圍(+-)的資料
       IF tm.range <> 0 AND (sr.l_rate > tm.range / 100 OR sr.l_rate < tm.range / -100)THEN
         CONTINUE FOREACH
       END IF

       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.xmdl008,sr.l_imaa003,sr.l_imaa004,sr.l_feature,sr.l_rtaxl003,sr.l_imaa127,sr.l_imaa127_desc,sr.l_imaa127desc,sr.l_xmdk003_ooag011,sr.l_date_base,sr.l_price_base,sr.l_price_avg,sr.l_amount,sr.l_cost,sr.l_cost_base,sr.l_cost_down,sr.l_rate,sr.xmdk016,sr.l_coin
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "axmr040_x01_execute"
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
 
{<section id="axmr040_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION axmr040_x01_rep_data()
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
 
{<section id="axmr040_x01.other_function" readonly="Y" >}
#產品分類
PRIVATE FUNCTION axmr040_x01_sel_imaa009(p_imaa001)
   DEFINE p_imaa001     LIKE imaa_t.imaa001 #料件編號
   DEFINE r_imaa009     LIKE imaa_t.imaa009 #產品分類
   
   LET r_imaa009 = ''
   SELECT imaa009 INTO r_imaa009
     FROM imaa_t
    WHERE imaaent = g_enterprise
      AND imaa001 = p_imaa001
   
   RETURN r_imaa009
END FUNCTION

 
{</section>}
 
