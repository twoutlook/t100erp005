#該程式未解開Section, 採用最新樣板產出!
{<section id="axmr120_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2017-02-16 09:19:02), PR版次:0003(2017-02-21 19:24:01)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000028
#+ Filename...: axmr120_x01
#+ Description: ...
#+ Creator....: 05384(2016-05-11 16:38:32)
#+ Modifier...: 08993 -SD/PR- 08993
 
{</section>}
 
{<section id="axmr120_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#161006-00004#1  2016/10/06   By  dorislai  將xmdkdocdt換成xmdk001
#170123-00051#3  2017/02/16   By  08993     新增料號、品名、規格欄位
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
       a1 STRING,                  #比較期別暫存 
       a2 STRING,                  #營運據點暫存 
       a3 LIKE type_t.chr1,         #比較基準 
       a4 LIKE type_t.chr1,         #幣別 
       a5 LIKE type_t.chr1,         #已確認訂單 
       a6 LIKE type_t.chr1,         #已過帳出貨單 
       a7 LIKE type_t.chr1          #排除多角
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="axmr120_x01.main" readonly="Y" >}
PUBLIC FUNCTION axmr120_x01(p_arg1,p_arg2,p_arg3,p_arg4,p_arg5,p_arg6,p_arg7,p_arg8)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 STRING                  #tm.a1  比較期別暫存 
DEFINE  p_arg3 STRING                  #tm.a2  營運據點暫存 
DEFINE  p_arg4 LIKE type_t.chr1         #tm.a3  比較基準 
DEFINE  p_arg5 LIKE type_t.chr1         #tm.a4  幣別 
DEFINE  p_arg6 LIKE type_t.chr1         #tm.a5  已確認訂單 
DEFINE  p_arg7 LIKE type_t.chr1         #tm.a6  已過帳出貨單 
DEFINE  p_arg8 LIKE type_t.chr1         #tm.a7  排除多角
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.a1 = p_arg2
   LET tm.a2 = p_arg3
   LET tm.a3 = p_arg4
   LET tm.a4 = p_arg5
   LET tm.a5 = p_arg6
   LET tm.a6 = p_arg7
   LET tm.a7 = p_arg8
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "axmr120_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL axmr120_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL axmr120_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL axmr120_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL axmr120_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL axmr120_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="axmr120_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION axmr120_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   DROP TABLE axmr120_x01_tmp;
   CREATE TEMP TABLE axmr120_x01_tmp(
      xmdasite        VARCHAR(10), 
      xmda002         VARCHAR(20), 
      xmda003         VARCHAR(10), 
      xmda004         VARCHAR(10), 
      imaa009         VARCHAR(10), 
      imaf111         VARCHAR(10), 
      imaa127         VARCHAR(10), 
      l_other         SMALLINT, 
      l_other_desc    VARCHAR(1000), 
      xmda015         VARCHAR(10), 
      xmda016         DECIMAL(20,10), 
      l_datumamount   DECIMAL(20,6), 
      l_datum_sum     DECIMAL(20,6),
      l_datumrate     DECIMAL(20,6), 
      l_actualamount  DECIMAL(20,6), 
      l_actual_sum    DECIMAL(20,6), 
      l_actualrate    DECIMAL(20,6), 
      l_growthrate    DECIMAL(20,6),
      xmdc001         VARCHAR(40)     #170123-00051#3 add

   )  
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "xmdasite.xmda_t.xmdasite,l_xmdasite_desc.ooefl_t.ooefl003,xmda002.xmda_t.xmda002,ooag_t_ooag011.ooag_t.ooag011,xmda003.xmda_t.xmda003,l_xmda003_desc.ooefl_t.ooefl003,xmda004.xmda_t.xmda004,l_xmda004_desc.pmaal_t.pmaal004,imaa_t_imaa009.imaa_t.imaa009,l_imaa009_desc.rtaxl_t.rtaxl003,imaf_t_imaf111.imaf_t.imaf111,l_imaf111_desc.oocql_t.oocql004,imaa_t_imaa127.imaa_t.imaa127,l_imaa127_desc.oocql_t.oocql004,l_other.type_t.num5,l_other_desc.type_t.chr1000,xmda015.xmda_t.xmda015,l_xmda015_desc.ooail_t.ooail003,xmda016.xmda_t.xmda016,l_datumamount.xmdc_t.xmdc046,l_datum_sum.xmdc_t.xmdc046,l_datumrate.xmdc_t.xmdc046,l_actualamount.xmdc_t.xmdc046,l_actual_sum.xmdc_t.xmdc046,l_actualrate.xmdc_t.xmdc046,l_growthrate.xmdc_t.xmdc046,xmdc001.xmdc_t.xmdc001,l_imaal003_desc.imaal_t.imaal003,l_imaal004_desc.imaal_t.imaal004" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="axmr120_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION axmr120_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="axmr120_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axmr120_x01_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define(客製用) name="sel_prep.define_customerization"

#end add-point
#add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
DEFINE l_sql          STRING
DEFINE l_sql2         STRING
DEFINE l_site         STRING
DEFINE l_wc           STRING
DEFINE l_stus         STRING
DEFINE l_aic          STRING
DEFINE l_gzxc004      LIKE gzxc_t.gzxc004
DEFINE l_other        LIKE type_t.num5
DEFINE l_other_desc   LIKE type_t.chr1000
DEFINE l_datumdate_s  LIKE type_t.dat
DEFINE l_datumdate_e  LIKE type_t.dat
DEFINE l_actualdate_s LIKE type_t.dat
DEFINE l_actualdate_e LIKE type_t.dat
DEFINE l_xmda   RECORD
       xmdasite       LIKE xmda_t.xmdasite, 
       xmda002        LIKE xmda_t.xmda002, 
       xmda003        LIKE xmda_t.xmda003, 
       xmda004        LIKE xmda_t.xmda004, 
       imaa009        LIKE imaa_t.imaa009, 
       imaf111        LIKE imaf_t.imaf111, 
       imaa127        LIKE imaa_t.imaa127, 
       l_other        LIKE type_t.num5, 
       l_other_desc   LIKE type_t.chr1000, 
       xmda015        LIKE xmda_t.xmda015, 
       xmda016        LIKE xmda_t.xmda016,
       l_datumamount  LIKE xmdc_t.xmdc046, 
       l_datum_sum    LIKE xmdc_t.xmdc046,
       l_datumrate    LIKE xmdc_t.xmdc046, 
       l_actualamount LIKE xmdc_t.xmdc046, 
       l_actual_sum   LIKE xmdc_t.xmdc046, 
       l_actualrate   LIKE xmdc_t.xmdc046, 
       l_growthrate   LIKE xmdc_t.xmdc046,
       xmdc001        LIKE xmdc_t.xmdc001       #170123-00051#3 add

       END RECORD
#end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   LET l_sql = " SELECT gzxc004 ",
               "   FROM ",tm.a2,
               "  ORDER BY gzxc004 "
   PREPARE axmr120_x01_site_pre FROM l_sql      
   DECLARE axmr120_x01_site_curs CURSOR FOR axmr120_x01_site_pre
   
   INITIALIZE l_site,l_gzxc004 TO NULL
   
   FOREACH axmr120_x01_site_curs INTO l_gzxc004
      IF cl_null(l_site) THEN
         LET l_site = "('",l_gzxc004,"'"
      ELSE
         LET l_site = l_site CLIPPED,",'",l_gzxc004,"'"
      END IF
   END FOREACH
   LET l_site = l_site CLIPPED,")"
   
   LET l_sql = " SELECT other,other_desc,datumdate_s,datumdate_e,actualdate_s,actualdate_e ",
               "   FROM ",tm.a1,
               "  ORDER BY other "
   PREPARE axmr120_x01_other_p FROM l_sql      
   DECLARE axmr120_x01_other_c CURSOR FOR axmr120_x01_other_p
   
   LET l_wc = cl_replace_str(tm.wc,'xmda002','xmdk003')
   LET l_wc = cl_replace_str(l_wc,'xmda003','xmdk004')
   LET l_wc = cl_replace_str(l_wc,'xmda004','xmdk007')
   LET l_wc = cl_replace_str(l_wc,'xmdc001','xmdl008')
   CASE tm.a3
      WHEN "0"
         IF tm.a5 = 'Y' THEN
            LET l_stus = " xmdastus IN ('Y','C') "
         ELSE
            LET l_stus = " xmdastus <> 'X' "
         END IF
         IF tm.a7 = 'Y' THEN
            LET l_aic = " xmda006 <> '5' "
         ELSE
            LET l_aic = " 1=1 "
         END IF
         
         LET l_sql = " SELECT xmdasite,xmda002,xmda003,xmda004,imaa009,imaf111,imaa127,'','',xmda015,xmda016,SUM(xmdc046),0,0,0,0,0,0,",
                     "        xmdc001 ",                                                                                 #170123-00051#3 add                                                                                              
                     "   FROM xmda_t LEFT OUTER JOIN pmaa_t ON pmaaent = xmdaent AND pmaa001 = xmda004 ",
                     ",xmdc_t ",                                                                 
                     "   LEFT OUTER JOIN imaa_t ON imaaent = xmdcent AND imaa001 = xmdc001 ",
                     "   LEFT OUTER JOIN imaf_t ON imafent = xmdcent AND imaf001 = xmdc001 AND imafsite = xmdcsite ",
                     "  WHERE xmdaent = xmdaent ",
                     "    AND xmdasite = xmdcsite ",
                     "    AND xmdadocno = xmdcdocno ",
                     "    AND xmdaent = '",g_enterprise,"' ",
                     "    AND xmdadocdt BETWEEN ? AND ? ",
                     "    AND ",tm.wc,
                     "    AND xmdasite IN ",l_site,
                     "    AND ",l_stus,
                     "    AND ",l_aic,
                     "  GROUP BY xmdasite,xmda002,xmda003,xmda004,imaa009,imaf111,imaa127,xmda015,xmda016,
                                 xmdc001 "                                                  #170123-00051#3 add
         
         LET l_sql2 = " SELECT xmdasite,xmda002,xmda003,xmda004,imaa009,imaf111,imaa127,'','',xmda015,xmda016,0,0,0,SUM(xmdc046),0,0,0,",
                      "        xmdc001 ",                                                   #170123-00051#3 add
                      "   FROM xmda_t LEFT OUTER JOIN pmaa_t ON pmaaent = xmdaent AND pmaa001 = xmda004 ",
                      ",xmdc_t ",                                                                
                      "   LEFT OUTER JOIN imaa_t ON imaaent = xmdcent AND imaa001 = xmdc001 ",
                      "   LEFT OUTER JOIN imaf_t ON imafent = xmdcent AND imaf001 = xmdc001 AND imafsite = xmdcsite ",
                      "  WHERE xmdaent = xmdaent ",
                      "    AND xmdasite = xmdcsite ",
                      "    AND xmdadocno = xmdcdocno ",
                      "    AND xmdaent = '",g_enterprise,"' ",
                      "    AND xmdadocdt BETWEEN ? AND ? ",
                      "    AND ",tm.wc,
                      "    AND xmdasite IN ",l_site,
                      "    AND ",l_stus,
                      "    AND ",l_aic,
                      "  GROUP BY xmdasite,xmda002,xmda003,xmda004,imaa009,imaf111,imaa127,xmda015,xmda016, 
                                  xmdc001 "                                                 #170123-00051#3 add
      OTHERWISE
         IF tm.a6 = 'Y' THEN
            LET l_stus = " xmdkstus = 'S' "
         ELSE
            LET l_stus = " xmdkstus <> 'X' "
         END IF
         
         IF tm.a7 = 'Y' THEN
            LET l_aic = " xmdk045 <> '5' "
         ELSE
            LET l_aic = " 1=1 "
         END IF
         
         LET l_sql = " SELECT xmdksite,xmdk003,xmdk004,xmdk007,imaa009,imaf111,imaa127,'','',xmdk016,xmdk017,SUM(xmdl027),0,0,0,0,0,0, ",
                     " xmdl008 ",                             #170123-00051#3 add
                     "   FROM xmdk_t LEFT OUTER JOIN pmaa_t ON pmaaent = xmdkent AND pmaa001 = xmdk007 ",
                     ",xmdl_t ",
                     "   LEFT OUTER JOIN imaa_t ON imaaent = xmdlent AND imaa001 = xmdl008 ",
                     "   LEFT OUTER JOIN imaf_t ON imafent = xmdlent AND imaf001 = xmdl008 AND imafsite = xmdlsite ",
                     "  WHERE xmdkent = xmdlent ",
                     "    AND xmdksite = xmdlsite ",
                     "    AND xmdkdocno = xmdldocno ",
                     "    AND xmdkent = '",g_enterprise,"' ",
                     "    AND ((xmdk000 = '1' AND xmdk002 IN ('1','2')) ",
                     "     OR   (xmdk000 = '4' AND xmdk002 = '3')) ",
                     #"    AND xmdkdocdt BETWEEN ? AND ? ",  #161006-00004#1-s-mod
                     "    AND xmdk001 BETWEEN ? AND ? ",     #161006-00004#1-e-mod
                     "    AND ",l_wc,
                     "    AND xmdksite IN ",l_site,
                     "    AND ",l_stus,
                     "    AND ",l_aic,
                     "  GROUP BY xmdksite,xmdk003,xmdk004,xmdk007,imaa009,imaf111,imaa127,xmdk016,xmdk017, 
                                 xmdl008 "                   #170123-00051#3 add
         
         LET l_sql2 = " SELECT xmdksite,xmdk003,xmdk004,xmdk007,imaa009,imaf111,imaa127,'','',xmdk016,xmdk017,0,0,0,SUM(xmdl027),0,0,0, ",
                      "  xmdl008 ",                           #170123-00051#3 add
                      "   FROM xmdk_t LEFT OUTER JOIN pmaa_t ON pmaaent = xmdkent AND pmaa001 = xmdk004 ",
                      ",xmdl_t ",
                      "   LEFT OUTER JOIN imaa_t ON imaaent = xmdlent AND imaa001 = xmdl008 ",
                      "   LEFT OUTER JOIN imaf_t ON imafent = xmdlent AND imaf001 = xmdl008 AND imafsite = xmdlsite ",
                      "  WHERE xmdkent = xmdlent ",
                      "    AND xmdksite = xmdlsite ",
                      "    AND xmdkdocno = xmdldocno ",
                      "    AND xmdkent = '",g_enterprise,"' ",
                      "    AND ((xmdk000 = '1' AND xmdk002 IN ('1','2')) ",
                      "     OR   (xmdk000 = '4' AND xmdk002 = '3')) ",
                      #"    AND xmdkdocdt BETWEEN ? AND ? ",  #161006-00004#1-s-mod
                      "    AND xmdk001 BETWEEN ? AND ? ",     #161006-00004#1-e-mod
                      "    AND ",l_wc,
                      "    AND xmdksite IN ",l_site,
                      "    AND ",l_stus,
                      "    AND ",l_aic,
                      "  GROUP BY xmdksite,xmdk003,xmdk004,xmdk007,imaa009,imaf111,imaa127,xmdk016,xmdk017, 
                                  xmdl008 "                   #170123-00051#3 add
         
   END CASE
   PREPARE axmr120_x01_da_p FROM l_sql      
   DECLARE axmr120_x01_da_c CURSOR FOR axmr120_x01_da_p
   
   PREPARE axmr120_x01_ac_p FROM l_sql2 
   DECLARE axmr120_x01_ac_c CURSOR FOR axmr120_x01_ac_p
   
   IF tm.a3 = '2' THEN
      IF tm.a6 = 'Y' THEN
            LET l_stus = " xmdkstus = 'S' "
         ELSE
            LET l_stus = " xmdkstus <> 'X' "
         END IF
         
         IF tm.a7 = 'Y' THEN
            LET l_aic = " xmdk045 <> '5' "
         ELSE
            LET l_aic = " 1=1 "
         END IF
         
         LET l_sql = " SELECT xmdksite,xmdk003,xmdk004,xmdk007,imaa009,imaf111,imaa127,'','',xmdk016,xmdk017,-SUM(xmdl027),0,0,0,0,0,0 ",
                     "   FROM xmdk_t LEFT OUTER JOIN pmaa_t ON pmaaent = xmdkent AND pmaa001 = xmdk007 ",
                     ",xmdl_t ",
                     "   LEFT OUTER JOIN imaa_t ON imaaent = xmdlent AND imaa001 = xmdl008 ",
                     "   LEFT OUTER JOIN imaf_t ON imafent = xmdlent AND imaf001 = xmdl008 AND imafsite = xmdlsite ",
                     "  WHERE xmdkent = xmdlent ",
                     "    AND xmdksite = xmdlsite ",
                     "    AND xmdkdocno = xmdldocno ",
                     "    AND xmdkent = '",g_enterprise,"' ",
                     "    AND xmdk000 = '6' ",
                     #"    AND xmdkdocdt BETWEEN ? AND ? ",  #161006-00004#1-s-mod
                     "    AND xmdk001 BETWEEN ? AND ? ",     #161006-00004#1-e-mod
                     "    AND ",l_wc,
                     "    AND xmdksite IN ",l_site,
                     "    AND ",l_stus,
                     "    AND ",l_aic,
                     "  GROUP BY xmdksite,xmdk003,xmdk004,xmdk007,imaa009,imaf111,imaa127,xmdk016,xmdk017 "
         
         LET l_sql2 = " SELECT xmdksite,xmdk003,xmdk004,xmdk007,imaa009,imaf111,imaa127,'','',xmdk016,xmdk017,0,0,0,-SUM(xmdl027),0,0,0 ",
                      "   FROM xmdk_t LEFT OUTER JOIN pmaa_t ON pmaaent = xmdkent AND pmaa001 = xmdk004 ",
                      ",xmdl_t ",
                      "   LEFT OUTER JOIN imaa_t ON imaaent = xmdlent AND imaa001 = xmdl008 ",
                      "   LEFT OUTER JOIN imaf_t ON imafent = xmdlent AND imaf001 = xmdl008 AND imafsite = xmdlsite ",
                      "  WHERE xmdkent = xmdlent ",
                      "    AND xmdksite = xmdlsite ",
                      "    AND xmdkdocno = xmdldocno ",
                      "    AND xmdkent = '",g_enterprise,"' ",
                      "    AND xmdk000 = '6' ",
                      #"    AND xmdkdocdt BETWEEN ? AND ? ",  #161006-00004#1-s-mod
                      "    AND xmdk001 BETWEEN ? AND ? ",     #161006-00004#1-e-mod
                      "    AND ",l_wc,
                      "    AND xmdksite IN ",l_site,
                      "    AND ",l_stus,
                      "    AND ",l_aic,
                      "  GROUP BY xmdksite,xmdk003,xmdk004,xmdk007,imaa009,imaf111,imaa127,xmdk016,xmdk017 "
   END IF
   PREPARE axmr120_x01_da_p2 FROM l_sql      
   DECLARE axmr120_x01_da_c2 CURSOR FOR axmr120_x01_da_p2
   
   PREPARE axmr120_x01_ac_p2 FROM l_sql2 
   DECLARE axmr120_x01_ac_c2 CURSOR FOR axmr120_x01_ac_p2
   
   INITIALIZE l_other,l_other_desc,l_datumdate_s,l_datumdate_e,l_actualdate_s,l_actualdate_e TO NULL
   DELETE FROM axmr120_x01_tmp
   
   FOREACH axmr120_x01_other_c INTO l_other,l_other_desc,l_datumdate_s,l_datumdate_e,l_actualdate_s,l_actualdate_e
      INITIALIZE l_xmda TO NULL
      FOREACH axmr120_x01_da_c USING l_datumdate_s,l_datumdate_e INTO l_xmda.*
         IF tm.a4 = '1' THEN
            LET l_xmda.l_datumamount = l_xmda.l_datumamount * l_xmda.xmda016
         END IF
         LET l_xmda.l_other = l_other
         LET l_xmda.l_other_desc = l_other_desc
         
         INSERT INTO axmr120_x01_tmp (xmdasite,xmda002,xmda003,xmda004,imaa009,imaf111,imaa127,l_other,
                                     l_other_desc,xmda015,xmda016,l_datumamount,l_datum_sum,l_datumrate,
                                     l_actualamount,l_actual_sum,l_actualrate,l_growthrate,
                                     xmdc001)                     #170123-00051#3 add
                             VALUES (l_xmda.xmdasite,l_xmda.xmda002,l_xmda.xmda003,l_xmda.xmda004,l_xmda.imaa009,
                                     l_xmda.imaf111,l_xmda.imaa127,l_xmda.l_other,l_xmda.l_other_desc,l_xmda.xmda015,
                                     l_xmda.xmda016,l_xmda.l_datumamount,l_xmda.l_datum_sum,l_xmda.l_datumrate,
                                     l_xmda.l_actualamount,l_xmda.l_actual_sum,l_xmda.l_actualrate,l_xmda.l_growthrate,
                                     l_xmda.xmdc001)#170123-00051#3 add
      END FOREACH
      
      INITIALIZE l_xmda TO NULL
      FOREACH axmr120_x01_ac_c USING l_actualdate_s,l_actualdate_e INTO l_xmda.*
         IF tm.a4 = '1' THEN
            LET l_xmda.l_actualamount = l_xmda.l_actualamount * l_xmda.xmda016     
         END IF
         LET l_xmda.l_other = l_other
         LET l_xmda.l_other_desc = l_other_desc
         
         UPDATE axmr120_x01_tmp SET l_actualamount = l_xmda.l_actualamount
          WHERE xmdasite = l_xmda.xmdasite
            AND xmda002 = l_xmda.xmda002
            AND xmda003 = l_xmda.xmda003
            AND xmda004 = l_xmda.xmda004
            AND imaa009 = l_xmda.imaa009
            AND imaf111 = l_xmda.imaf111
            AND imaa127 = l_xmda.imaa127
            AND l_other = l_xmda.l_other
            AND l_other_desc = l_xmda.l_other_desc
            AND xmda015 = l_xmda.xmda015
            AND xmda016 = l_xmda.xmda016
            AND xmdc001 = l_xmda.xmdc001                    #170123-00051#3 add

         
         IF sqlca.sqlerrd[3] = 0 THEN
            INSERT INTO axmr120_x01_tmp (xmdasite,xmda002,xmda003,xmda004,imaa009,imaf111,imaa127,l_other,
                                         l_other_desc,xmda015,xmda016,l_datumamount,l_datum_sum,l_datumrate,
                                         l_actualamount,l_actual_sum,l_actualrate,l_growthrate,
                                         xmdc001)                     #170123-00051#3 add
                                 VALUES (l_xmda.xmdasite,l_xmda.xmda002,l_xmda.xmda003,l_xmda.xmda004,l_xmda.imaa009,
                                         l_xmda.imaf111,l_xmda.imaa127,l_xmda.l_other,l_xmda.l_other_desc,l_xmda.xmda015,
                                         l_xmda.xmda016,l_xmda.l_datumamount,l_xmda.l_datum_sum,l_xmda.l_datumrate,
                                         l_xmda.l_actualamount,l_xmda.l_actual_sum,l_xmda.l_actualrate,l_xmda.l_growthrate,
                                         l_xmda.xmdc001)#170123-00051#3 add
         END IF

      END FOREACH
      IF tm.a3 = '2' THEN
         INITIALIZE l_xmda TO NULL
         FOREACH axmr120_x01_da_c2 USING l_datumdate_s,l_datumdate_e INTO l_xmda.*
            IF tm.a4 = '1' THEN
               LET l_xmda.l_datumamount = l_xmda.l_datumamount * l_xmda.xmda016
            END IF
            LET l_xmda.l_other = l_other
            LET l_xmda.l_other_desc = l_other_desc
            
            UPDATE axmr120_x01_tmp SET l_datumamount = l_datumamount + l_xmda.l_datumamount
             WHERE xmdasite = l_xmda.xmdasite
               AND xmda002 = l_xmda.xmda002
               AND xmda003 = l_xmda.xmda003
               AND xmda004 = l_xmda.xmda004
               AND imaa009 = l_xmda.imaa009
               AND imaf111 = l_xmda.imaf111
               AND imaa127 = l_xmda.imaa127
               AND l_other = l_xmda.l_other
               AND l_other_desc = l_xmda.l_other_desc
               AND xmda015 = l_xmda.xmda015
               AND xmda016 = l_xmda.xmda016
               AND xmdc001 = l_xmda.xmdc001                    #170123-00051#3 add

               
            IF sqlca.sqlerrd[3] = 0 THEN
               INSERT INTO axmr120_x01_tmp (xmdasite,xmda002,xmda003,xmda004,imaa009,imaf111,imaa127,l_other,
                                            l_other_desc,xmda015,xmda016,l_datumamount,l_datum_sum,l_datumrate,
                                            l_actualamount,l_actual_sum,l_actualrate,l_growthrate,
                                            xmdc001)                     #170123-00051#3 add
                                    VALUES (l_xmda.xmdasite,l_xmda.xmda002,l_xmda.xmda003,l_xmda.xmda004,l_xmda.imaa009,
                                            l_xmda.imaf111,l_xmda.imaa127,l_xmda.l_other,l_xmda.l_other_desc,l_xmda.xmda015,
                                            l_xmda.xmda016,l_xmda.l_datumamount,l_xmda.l_datum_sum,l_xmda.l_datumrate,
                                            l_xmda.l_actualamount,l_xmda.l_actual_sum,l_xmda.l_actualrate,l_xmda.l_growthrate,
                                            l_xmda.xmdc001)#170123-00051#3 add
            END IF
         END FOREACH
         
         INITIALIZE l_xmda TO NULL
         FOREACH axmr120_x01_ac_c2 USING l_actualdate_s,l_actualdate_e INTO l_xmda.*
            IF tm.a4 = '1' THEN
               LET l_xmda.l_actualamount = l_xmda.l_actualamount * l_xmda.xmda016

            END IF
            LET l_xmda.l_other = l_other
            LET l_xmda.l_other_desc = l_other_desc                        
            
            UPDATE axmr120_x01_tmp SET l_actualamount = l_actualamount + l_xmda.l_actualamount
             WHERE xmdasite = l_xmda.xmdasite
               AND xmda002 = l_xmda.xmda002
               AND xmda003 = l_xmda.xmda003
               AND xmda004 = l_xmda.xmda004
               AND imaa009 = l_xmda.imaa009
               AND imaf111 = l_xmda.imaf111
               AND imaa127 = l_xmda.imaa127
               AND l_other = l_xmda.l_other
               AND l_other_desc = l_xmda.l_other_desc
               AND xmda015 = l_xmda.xmda015
               AND xmda016 = l_xmda.xmda016
               AND xmdc001 = l_xmda.xmdc001                    #170123-00051#3 add

               
            IF sqlca.sqlerrd[3] = 0 THEN
               INSERT INTO axmr120_x01_tmp (xmdasite,xmda002,xmda003,xmda004,imaa009,imaf111,imaa127,l_other,
                                            l_other_desc,xmda015,xmda016,l_datumamount,l_datum_sum,l_datumrate,
                                            l_actualamount,l_actual_sum,l_actualrate,l_growthrate,
                                            xmdc001)                     #170123-00051#3 add
                                    VALUES (l_xmda.xmdasite,l_xmda.xmda002,l_xmda.xmda003,l_xmda.xmda004,l_xmda.imaa009,
                                            l_xmda.imaf111,l_xmda.imaa127,l_xmda.l_other,l_xmda.l_other_desc,l_xmda.xmda015,
                                            l_xmda.xmda016,l_xmda.l_datumamount,l_xmda.l_datum_sum,l_xmda.l_datumrate,
                                            l_xmda.l_actualamount,l_xmda.l_actual_sum,l_xmda.l_actualrate,l_xmda.l_growthrate,
                                            l_xmda.xmdc001)#170123-00051#3 add
            END IF
         END FOREACH
      END IF
   END FOREACH
   #end add-point
 
   #add-point:sel_prep g_select name="sel_prep.g_select"
   LET g_select = " SELECT xmdasite,a.ooefl003,xmda002,ooag011,xmda003,b.ooefl003,xmda004,pmaal004,imaa009,rtaxl003, ",
                   "        imaf111,c.oocql004,imaa127,d.oocql004,l_other,l_other_desc,xmda015,ooail003,xmda016, ",
                   "        l_datumamount,l_datum_sum,l_datumrate,l_actualamount,l_actual_sum,l_actualrate,l_growthrate, ",
                   "       xmdc001,e.imaal003,f.imaal004 "                                       #170123-00051#3 add

#   #end add-point
#   LET g_select = " SELECT xmdasite,NULL,xmda002,ooag_t.ooag011,xmda003,NULL,xmda004,NULL,imaa_t.imaa009, 
#       NULL,imaf_t.imaf111,NULL,imaa_t.imaa127,NULL,0,NULL,xmda015,NULL,xmda016,0,0,0,0,0,0,0,xmdc001, 
#       NULL,NULL"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_from = " FROM axmr120_x01_tmp ",
                " LEFT OUTER JOIN ooefl_t a ON a.ooefl001 = xmdasite AND a.ooefl002 = '",g_dlang,"' AND a.ooeflent = '",g_enterprise,"' ",
                " LEFT OUTER JOIN ooag_t ON ooagent = '",g_enterprise,"' AND ooag001 = xmda002 ",
                " LEFT OUTER JOIN ooefl_t b ON b.ooefl001 = xmda003 AND b.ooefl002 = '",g_dlang,"' AND b.ooeflent = '",g_enterprise,"' ",
                " LEFT OUTER JOIN pmaal_t ON pmaal001 = xmda004 AND pmaal002 = '",g_dlang,"' AND pmaalent = '",g_enterprise,"' ",
                " LEFT OUTER JOIN rtaxl_t ON rtaxlent = '",g_enterprise,"' AND rtaxl001 = imaa009 AND rtaxl002 = '",g_dlang,"' ",
                " LEFT OUTER JOIN oocql_t c ON c.oocql003 = '",g_dlang,"' AND c.oocqlent = '",g_enterprise,"' AND c.oocql002 = imaf111 AND c.oocql001 = '202' ",
                " LEFT OUTER JOIN oocql_t d ON d.oocql003 = '",g_dlang,"' AND d.oocqlent = '",g_enterprise,"' AND d.oocql002 = imaa127 AND d.oocql001 = '2003' ",
                " LEFT OUTER JOIN ooail_t ON ooailent = '",g_enterprise,"' AND ooail001 = xmda015 AND ooail002 = '",g_dlang,"' ",
                " LEFT OUTER JOIN imaal_t e ON e.imaalent= '",g_enterprise,"'AND e.imaal001 = xmdc001 AND e.imaal002 = '",g_dlang,"' ", #170123-00051#3 add
                " LEFT OUTER JOIN imaal_t f ON f.imaalent= '",g_enterprise,"'AND f.imaal001 = xmdc001 AND f.imaal002 = '",g_dlang,"' "  #170123-00051#3 add
                
#   #end add-point
#    LET g_from = " FROM xmda_t,xmdc_t,imaa_t,imaf_t,ooag_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
 
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("xmda_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
 
   #end add-point
   PREPARE axmr120_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE axmr120_x01_curs CURSOR FOR axmr120_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="axmr120_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION axmr120_x01_ins_data()
DEFINE sr RECORD 
   xmdasite LIKE xmda_t.xmdasite, 
   l_xmdasite_desc LIKE ooefl_t.ooefl003, 
   xmda002 LIKE xmda_t.xmda002, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   xmda003 LIKE xmda_t.xmda003, 
   l_xmda003_desc LIKE ooefl_t.ooefl003, 
   xmda004 LIKE xmda_t.xmda004, 
   l_xmda004_desc LIKE pmaal_t.pmaal004, 
   imaa_t_imaa009 LIKE imaa_t.imaa009, 
   l_imaa009_desc LIKE rtaxl_t.rtaxl003, 
   imaf_t_imaf111 LIKE imaf_t.imaf111, 
   l_imaf111_desc LIKE oocql_t.oocql004, 
   imaa_t_imaa127 LIKE imaa_t.imaa127, 
   l_imaa127_desc LIKE oocql_t.oocql004, 
   l_other LIKE type_t.num5, 
   l_other_desc LIKE type_t.chr1000, 
   xmda015 LIKE xmda_t.xmda015, 
   l_xmda015_desc LIKE ooail_t.ooail003, 
   xmda016 LIKE xmda_t.xmda016, 
   l_datumamount LIKE xmdc_t.xmdc046, 
   l_datum_sum LIKE xmdc_t.xmdc046, 
   l_datumrate LIKE xmdc_t.xmdc046, 
   l_actualamount LIKE xmdc_t.xmdc046, 
   l_actual_sum LIKE xmdc_t.xmdc046, 
   l_actualrate LIKE xmdc_t.xmdc046, 
   l_growthrate LIKE xmdc_t.xmdc046, 
   xmdc001 LIKE xmdc_t.xmdc001, 
   l_imaal003_desc LIKE imaal_t.imaal003, 
   l_imaal004_desc LIKE imaal_t.imaal004
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_sql    STRING
DEFINE l_other        LIKE type_t.num5
DEFINE l_other_desc   LIKE type_t.chr1000
DEFINE l_datum_sum    LIKE xmdc_t.xmdc046
DEFINE l_actual_sum   LIKE xmdc_t.xmdc046
#DEFINE l_xmda   RECORD
#       xmdasite       LIKE xmda_t.xmdasite, 
#       xmda002        LIKE xmda_t.xmda002, 
#       xmda003        LIKE xmda_t.xmda003, 
#       xmda004        LIKE xmda_t.xmda004, 
#       imaa009        LIKE imaa_t.imaa009, 
#       imaf111        LIKE imaf_t.imaf111, 
#       imaa127        LIKE imaa_t.imaa127, 
#       l_other        LIKE type_t.num5, 
#       l_other_desc   LIKE type_t.chr1000, 
#       xmda015        LIKE xmda_t.xmda015, 
#       xmda016        LIKE xmda_t.xmda016,
#       l_datum_sum    LIKE xmdc_t.xmdc046,
#       l_actual_sum   LIKE xmdc_t.xmdc046
#       END RECORD
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH axmr120_x01_curs INTO sr.*                               
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
       EXECUTE insert_prep USING sr.xmdasite,sr.l_xmdasite_desc,sr.xmda002,sr.ooag_t_ooag011,sr.xmda003,sr.l_xmda003_desc,sr.xmda004,sr.l_xmda004_desc,sr.imaa_t_imaa009,sr.l_imaa009_desc,sr.imaf_t_imaf111,sr.l_imaf111_desc,sr.imaa_t_imaa127,sr.l_imaa127_desc,sr.l_other,sr.l_other_desc,sr.xmda015,sr.l_xmda015_desc,sr.xmda016,sr.l_datumamount,sr.l_datum_sum,sr.l_datumrate,sr.l_actualamount,sr.l_actual_sum,sr.l_actualrate,sr.l_growthrate,sr.xmdc001,sr.l_imaal003_desc,sr.l_imaal004_desc
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "axmr120_x01_execute"
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
    LET l_sql = " SELECT l_other,l_other_desc,SUM(l_datumamount),SUM(l_actualamount) ",
                "   FROM ",g_rep_db CLIPPED,g_rep_tmpname[1] CLIPPED,
                "  GROUP BY l_other,l_other_desc "
    PREPARE axmr120_x01_sum_p FROM l_sql      
    DECLARE axmr120_x01_sum_c CURSOR FOR axmr120_x01_sum_p
    
    LET l_sql = " UPDATE ",g_rep_db CLIPPED,g_rep_tmpname[1] CLIPPED,
                "    SET l_datum_sum = ? ,",
                "        l_actual_sum = ? ",
                "  WHERE l_other = ? ",
                "    AND l_other_desc = ? "
    PREPARE axmr120_update FROM l_sql
    
    INITIALIZE l_other,l_other_desc,l_datum_sum,l_actual_sum TO NULL
    FOREACH axmr120_x01_sum_c INTO l_other,l_other_desc,l_datum_sum,l_actual_sum
       EXECUTE axmr120_update USING l_datum_sum,l_actual_sum,l_other,l_other_desc
    END FOREACH
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axmr120_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION axmr120_x01_rep_data()
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
 
{<section id="axmr120_x01.other_function" readonly="Y" >}

 
{</section>}
 
