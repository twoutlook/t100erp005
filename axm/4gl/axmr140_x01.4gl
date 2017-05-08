#該程式未解開Section, 採用最新樣板產出!
{<section id="axmr140_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2015-11-16 10:26:08), PR版次:0003(2015-11-16 11:17:03)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000052
#+ Filename...: axmr140_x01
#+ Description: ...
#+ Creator....: 04441(2015-03-19 14:22:32)
#+ Modifier...: 06814 -SD/PR- 06814
 
{</section>}
 
{<section id="axmr140_x01.global" readonly="Y" >}
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
       chk LIKE type_t.chr1          #僅顯示超限資
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="axmr140_x01.main" readonly="Y" >}
PUBLIC FUNCTION axmr140_x01(p_arg1,p_arg2)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr1         #tm.chk  僅顯示超限資
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.chk = p_arg2
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "axmr140_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL axmr140_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL axmr140_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL axmr140_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL axmr140_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL axmr140_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="axmr140_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION axmr140_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "l_pmab001.type_t.chr100,l_xmac001.type_t.chr100,xmac002.xmac_t.xmac002,xmac003.xmac_t.xmac003,l_money.type_t.num20_6,xmac004.xmac_t.xmac004,l_over_due.type_t.chr1,l_unrealized.type_t.chr1,l_xmaa002.type_t.chr100,xmab003.xmab_t.xmab003,xmab005.xmab_t.xmab005,l_xmab006.type_t.chr100,xmab007.xmab_t.xmab007,xmab013.xmab_t.xmab013,l_money1.type_t.num20_6,l_xmaa004.type_t.chr10,l_xmaa005.type_t.num20_6,l_money2.type_t.num20_6" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="axmr140_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION axmr140_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="axmr140_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axmr140_x01_sel_prep()
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
#   LET g_select = " SELECT pmab001,xmac001,xmac002,xmac003,(xmac003-xmac004),xmac004,'','', ",
#                  "        xmaa002,xmab003,xmab005,xmab006,xmab007,xmab013,(xmab009-xmab010*xmab013), ",
#                  "        xmaa004,xmaa005,((xmab009-xmab010*xmab013)*xmaa005/100),pmabsite "
   #151113-00022#3 20151116 mark by beckxie---S
   #LET g_select = " SELECT pmab001,pmab003,pmab005,pmab006,0,0,'','', ",
   #               "        xmaa002,xmab003,xmab005,xmab006,xmab007,xmab013,(xmab009-xmab010*xmab013), ",
   #               "        xmaa004,xmaa005,((xmab009-xmab010*xmab013)*xmaa005/100),pmabsite "
   #151113-00022#3 20151116 mark by beckxie---E
   #151113-00022#3 20151116  add by beckxie---S
   LET g_select = " SELECT trim(pmab001)||'.'||trim(A1.pmaal004),trim(pmab003)||'.'||trim(A2.pmaal004),pmab005,pmab006,0, ",
                  "        0,'','',trim(xmaa002)||'.'||trim(B1.gzcbl004),xmab003, ",
                  "        xmab005,trim(xmab006)||'.'||trim(C1.pmaal004),xmab007,xmab013,(xmab009-xmab010*xmab013), ",
                  "        trim(xmaa004)||'.'||trim(B2.gzcbl004),xmaa005,((xmab009-xmab010*xmab013)*xmaa005/100),pmabsite  "
   #151113-00022#3 20151116  add by beckxie---E
#   #end add-point
#   LET g_select = " SELECT '','',xmac002,xmac003,NULL,xmac004,'','','',xmab003,xmab005,'',xmab007,xmab013, 
#       NULL,'',NULL,NULL,xmacsite"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
#    LET g_from = " FROM pmaa_t,pmab_t,xmaa_t,xmac_t,xmab_t"
   #151113-00022#3 20151116 mark by beckxie---S
   #LET g_from = " FROM pmab_t,xmaa_t,xmab_t "
   #151113-00022#3 20151116 mark by beckxie---E
   #151113-00022#3 20151116  add by beckxie---S
   LET g_from = " FROM pmab_t ",
                " LEFT OUTER JOIN pmaal_t A1 ON A1.pmaalent= ",g_enterprise," AND A1.pmaal001 = pmab001 AND A1.pmaal002 = '",g_dlang,"' ",
                " LEFT OUTER JOIN pmaal_t A2 ON A2.pmaalent= ",g_enterprise," AND A2.pmaal001 = pmab003 AND A2.pmaal002 = '",g_dlang,"' ",
                " ,xmaa_t ",
                " LEFT OUTER JOIN gzcbl_t B1 ON B1.gzcbl001='2044' AND B1.gzcbl002=xmaa002 AND B1.gzcbl003='",g_dlang,"' ",
                " LEFT OUTER JOIN gzcbl_t B2 ON B2.gzcbl001='2045' AND B2.gzcbl002=xmaa004 AND B2.gzcbl003='",g_dlang,"' ",
                " ,xmab_t ",
                " LEFT OUTER JOIN pmaal_t C1 ON C1.pmaalent= ",g_enterprise," AND C1.pmaal001 = xmab006 AND C1.pmaal002 = '",g_dlang,"'  "
   #151113-00022#3 20151116  add by beckxie---E
#   #end add-point
#    LET g_from = " FROM xmac_t,xmab_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
#    LET g_where = " WHERE pmabent = pmaaent AND pmab001 = pmaa001 ",
#                  "   AND xmaaent = pmabent AND xmaa001 = pmab004 ",
#                  "   AND xmabent = xmaaent AND xmab001 = xmaa002 ",
#                  "   AND xmacent = xmabent AND xmac001 = pmab003 AND xmacsite = pmabsite ",
#                  "   AND ",tm.wc CLIPPED

    LET g_where = " WHERE pmabent = ",g_enterprise,
                  "   AND pmabsite = '",g_site,"' ",
                  "   AND pmab002 IN ('2','3') ",  #信用查核
                  "   AND pmab001 IN (SELECT pmab003 FROM pmaa_t,pmab_t WHERE pmabent = ",g_enterprise," AND pmabsite = '",g_site,"' AND pmaaent = pmabent AND pmaa001 = pmab001 AND ",tm.wc CLIPPED,")",
                  "   AND xmaaent = pmabent ",
                  "   AND xmaa001 = pmab004 ",
                  "   AND xmaa002 NOT IN ('S7','S10','S11') ",  #150822-00001#9 150903 by whitney add 'S7'
                  "   AND xmabent = xmaaent ",
                  "   AND xmab001 = xmaa002 ",
#                  "   AND xmab006 = pmab001 ",
                  "   AND xmab008 = pmab003 ",
                  "   AND xmab009 > xmab010 ",
                  "   AND xmab017 = 'N' "

#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
 
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
#   LET g_sql = " SELECT pmab001,xmac001,xmac002,xmac003,(xmac003-xmac004),xmac004,'','', ",
#               "        xmaa002,xmab003,xmab005,xmab006,xmab007,xmab013,(xmab009-xmab010*xmab013), ",
#               "        xmaa004,xmaa005,((xmab009-xmab010*xmab013)*xmaa005),pmabsite ",
#               "   FROM pmaa_t,pmab_t,xmaa_t,xmac_t,xmab_t ",
#               "  WHERE pmabent = pmaaent AND pmab001 = pmaa001 AND pmabsite = 'ALL' ",
#               "    AND (SELECT COUNT(*) FROM pmab_t WHERE pmabent = ",g_enterprise," AND pmabsite = '",g_site,"') = 0 ",
#               "    AND xmaaent = pmabent AND xmaa001 = pmab004 ",
#               "    AND xmabent = xmaaent AND xmab001 = xmaa002 ",
#               "    AND xmacent = xmabent AND xmac001 = pmab003 AND xmacsite = pmabsite ",
#               "    AND ",tm.wc CLIPPED,
#               "  UNION ",
#               " SELECT pmab001,xmac001,xmac002,xmac003,(xmac003-xmac004),xmac004,'','', ",
#               "        xmaa002,xmab003,xmab005,xmab006,xmab007,xmab013,(xmab009-xmab010*xmab013), ",
#               "        xmaa004,xmaa005,((xmab009-xmab010*xmab013)*xmaa005),pmabsite ",
#               "   FROM pmaa_t,pmab_t,xmaa_t,xmac_t,xmab_t ",
#               "  WHERE pmabent = pmaaent AND pmab001 = pmaa001 AND pmabsite = '",g_site,"' ",
#               "    AND xmaaent = pmabent AND xmaa001 = pmab004 ",
#               "    AND xmabent = xmaaent AND xmab001 = xmaa002 ",
#               "    AND xmacent = xmabent AND xmac001 = pmab003 AND xmacsite = pmabsite ",
#               "    AND ",tm.wc CLIPPED,
#               "  ORDER BY pmab001,xmac001,xmac002 "

   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("xmac_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = g_sql," ORDER BY pmab001,pmab003,pmab005 "
   DISPLAY "g_sql:",g_sql
   #end add-point
   PREPARE axmr140_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE axmr140_x01_curs CURSOR FOR axmr140_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="axmr140_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION axmr140_x01_ins_data()
DEFINE sr RECORD 
   l_pmab001 LIKE type_t.chr100, 
   l_xmac001 LIKE type_t.chr100, 
   xmac002 LIKE xmac_t.xmac002, 
   xmac003 LIKE xmac_t.xmac003, 
   l_money LIKE type_t.num20_6, 
   xmac004 LIKE xmac_t.xmac004, 
   l_over_due LIKE type_t.chr1, 
   l_unrealized LIKE type_t.chr1, 
   l_xmaa002 LIKE type_t.chr100, 
   xmab003 LIKE xmab_t.xmab003, 
   xmab005 LIKE xmab_t.xmab005, 
   l_xmab006 LIKE type_t.chr100, 
   xmab007 LIKE xmab_t.xmab007, 
   xmab013 LIKE xmab_t.xmab013, 
   l_money1 LIKE type_t.num20_6, 
   l_xmaa004 LIKE type_t.chr10, 
   l_xmaa005 LIKE type_t.num20_6, 
   l_money2 LIKE type_t.num20_6, 
   xmacsite LIKE xmac_t.xmacsite
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_desc     LIKE type_t.chr100

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
 
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH axmr140_x01_curs INTO sr.*                               
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
       #Over Due
       IF s_credit_over_due_chk(sr.xmacsite,sr.l_xmac001) THEN
          LET sr.l_over_due = 'N'
       ELSE
          LET sr.l_over_due = 'Y'
       END IF
       #逾期未兌現票據
       IF s_credit_unrealized_bills_chk(sr.xmacsite,sr.l_xmac001) THEN 
          LET sr.l_unrealized = 'N'
       ELSE
          LET sr.l_unrealized = 'Y'
       END IF
       CALL axmr140_x01_count(sr.l_xmac001,sr.xmac003) RETURNING sr.l_money,sr.xmac004
       #僅顯示超限資料
       IF tm.chk = 'Y' THEN
          IF sr.xmac004 > 0 AND sr.l_over_due = 'N' AND sr.l_unrealized = 'N' THEN
             CONTINUE FOREACH
          END IF
       END IF
       #151113-00022#3 20151116 mark by beckxie---S
       ##客戶編號
       #CALL s_desc_get_trading_partner_abbr_desc(sr.l_pmab001)
       #     RETURNING l_desc
       #IF NOT cl_null(l_desc) THEN
       #   LET sr.l_pmab001 = sr.l_pmab001,".",l_desc
       #END IF
       ##額度對象
       #CALL s_desc_get_trading_partner_abbr_desc(sr.l_xmac001)
       #     RETURNING l_desc
       #IF NOT cl_null(l_desc) THEN
       #   LET sr.l_xmac001 = sr.l_xmac001,".",l_desc
       #END IF
       ##計算項目
       #CALL s_desc_gzcbl004_desc('2044',sr.l_xmaa002)
       #     RETURNING l_desc
       #IF NOT cl_null(l_desc) THEN
       #   LET sr.l_xmaa002 = sr.l_xmaa002,".",l_desc
       #END IF
       ##交易客戶
       #CALL s_desc_get_trading_partner_abbr_desc(sr.l_xmab006)
       #     RETURNING l_desc
       #IF NOT cl_null(l_desc) THEN
       #   LET sr.l_xmab006 = sr.l_xmab006,".",l_desc
       #END IF
       ##額度計算加減項
       #CALL s_desc_gzcbl004_desc('2045',sr.l_xmaa004)
       #     RETURNING l_desc
       #IF NOT cl_null(l_desc) THEN
       #   LET sr.l_xmaa004 = sr.l_xmaa004,".",l_desc
       #END IF
       #151113-00022#3 20151116 mark by beckxie---E
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.l_pmab001,sr.l_xmac001,sr.xmac002,sr.xmac003,sr.l_money,sr.xmac004,sr.l_over_due,sr.l_unrealized,sr.l_xmaa002,sr.xmab003,sr.xmab005,sr.l_xmab006,sr.xmab007,sr.xmab013,sr.l_money1,sr.l_xmaa004,sr.l_xmaa005,sr.l_money2
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "axmr140_x01_execute"
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
 
{<section id="axmr140_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION axmr140_x01_rep_data()
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
 
{<section id="axmr140_x01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 餘額計算
# Memo...........:
# Usage..........: CALL axmr140_x01_count(p_xmac001,p_xmac003)
#                  RETURNING r_monry01,r_monry02
# Input parameter: p_xmac001   額度客戶
#                : p_xmac003   信用額度
# Return code....: r_monry01   耗用金額
#                : r_monry02   信用餘額
# Date & Author..: 150922 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION axmr140_x01_count(p_xmac001,p_xmac003)
DEFINE p_xmac001    LIKE xmac_t.xmac001
DEFINE p_xmac003    LIKE xmac_t.xmac003
DEFINE r_monry01    LIKE xmac_t.xmac003
DEFINE r_monry02    LIKE xmac_t.xmac003
DEFINE l_xmaa  RECORD
    xmaa004    LIKE xmaa_t.xmaa004,
    xmaa005    LIKE xmaa_t.xmaa005,
    money00    LIKE xmac_t.xmac003
           END RECORD

   LET g_sql = " SELECT UNIQUE xmaa004,xmaa005, ",
               #項目金額：依計算項目抓取對應的xmac_t欄位
               "  (CASE WHEN xmaa002 = 'S1' THEN xmac011 ",
               "        WHEN xmaa002 = 'S2' THEN xmac012 ",
               "        WHEN xmaa002 = 'S3' THEN xmac013 ",
               "        WHEN xmaa002 = 'S4' THEN xmac014 ",
               "        WHEN xmaa002 = 'S5' THEN xmac015 ",
               "        WHEN xmaa002 = 'S6' THEN xmac016 ",
               "        WHEN xmaa002 = 'S7' THEN xmac017 ",
               "        WHEN xmaa002 = 'S8' THEN xmac018 ",
               "        WHEN xmaa002 = 'S9' THEN xmac019 ",
               "        WHEN xmaa002 = 'P1' THEN xmac041 ",
               "        WHEN xmaa002 = 'P2' THEN xmac042 ",
               "        WHEN xmaa002 = 'P3' THEN xmac043 ",
               "        WHEN xmaa002 = 'P4' THEN xmac044 ",
               "        WHEN xmaa002 = 'P5' THEN xmac045 ",
               "        WHEN xmaa002 = 'P6' THEN xmac046 ",
               "        WHEN xmaa002 = 'P7' THEN xmac047 ",
               "        WHEN xmaa002 = 'P9' THEN xmac048 ",
               "        END) ",
               "   FROM xmaa_t,pmab_t,xmac_t ",
               "  WHERE pmabent = xmacent ",
               "    AND pmabsite = xmacsite ",
               "    AND pmab001 = '",p_xmac001,"' ",
               "    AND xmacent = xmaaent ",
               "    AND xmacsite = '",g_site,"' ",
               "    AND xmac001 = '",p_xmac001,"' ",
               "    AND xmaaent = ",g_enterprise," ",
               "    AND xmaa001 = pmab004 ",
               "    AND xmaa002 NOT IN ('S7','S10','S11') "  #150822-00001#9 150903 by whitney add 'S7'
   PREPARE axmr140_x01_count_pb FROM g_sql
   DECLARE axmr140_x01_count_cs CURSOR FOR axmr140_x01_count_pb
   
   LET r_monry01 = 0
   INITIALIZE l_xmaa.* TO NULL
   FOREACH axmr140_x01_count_cs INTO l_xmaa.xmaa004,l_xmaa.xmaa005,l_xmaa.money00
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      #額度耗用金額 = 項目金額 * 計算比率
      IF l_xmaa.xmaa004 = '1' THEN
         LET r_monry01 = r_monry01 - (l_xmaa.money00 * l_xmaa.xmaa005 / 100)
      ELSE
         LET r_monry01 = r_monry01 + (l_xmaa.money00 * l_xmaa.xmaa005 / 100)
      END IF
      
   END FOREACH

   LET　r_monry02 = p_xmac003 - r_monry01

   RETURN r_monry01,r_monry02
END FUNCTION

 
{</section>}
 
