#該程式未解開Section, 採用最新樣板產出!
{<section id="asfp301_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0022(2016-10-03 09:39:48), PR版次:0022(2017-01-23 11:27:25)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000102
#+ Filename...: asfp301_01
#+ Description: 訂單轉工單作業 – 待轉訂單資料
#+ Creator....: 00378(2014-07-08 14:07:03)
#+ Modifier...: 04441 -SD/PR- 05384
 
{</section>}
 
{<section id="asfp301_01.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"
#160727-00019#17 2016/08/10  By 08734     临时表长度超过15码的减少到15码以下 p301_01_lock_b_t ——> asfp301_tmp01
#160706-00037#8  2016/08/25  By Sarah     引導式作業調整的作法:第一步查出待拋轉資料時不做LOCK
#160901-00043#1  2016/09/06  by whitney   累加最新的已转工单量調整為顯示目前已轉工單量
#160909-00062#1  2016/09/19  By Ann_Huang 1.畫面規格新增QBE條件"客戶料號(xmdc027)"
#                                         2.加入xmdc027條件資料
#161026-00063#1  2016/10/28  By charles4m 多交期情況應該要分比顯示不合併數量，asfp301_01_b_fill_curs_d1、asfp301_01_b_fill_curs_d2 SQL 合併成一句
#161103-00006#1  2016/11/03  By liuym     调整订单多交期转工单时，只能查询出一笔资料问题
#161124-00014#1  2016/11/24  By ouhz      调整订单转工单，无任何查询条件或查询多笔订单，但只能查询出一笔资料问题
#161219-00070#1  2016/12/21  By shiun     當訂單(預先訂單)已轉工單，則該訂單(預先訂單)對應的預先訂單(訂單)則不可再轉工單
#161222-00007#1  2016/12/23  By shiun     檢查訂單(預先訂單)是否已產生工單排除已作廢工單，及增加排除控制
#170104-00066#1  2017/01/04  By Rainy     筆數相關變數由num5放大至num10
#161128-00036#1  2017/01/23  By shiun     調整留置訂單也可拋轉工單
#end add-point
#add-point:填寫註解說明(客製用) name="main.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="main.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
#add-point:增加匯入變數檔 name="global.inc"
GLOBALS "../../asf/4gl/asfp301.inc"
#end add-point
 
{</section>}
 
{<section id="asfp301_01.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
 TYPE type_xmdd    RECORD
                          sel                  LIKE type_t.chr1,
                          xmdddocno            LIKE xmdd_t.xmdddocno,
                          xmddseq              LIKE xmdd_t.xmddseq,
                          xmddseq1             LIKE xmdd_t.xmddseq1,
                          xmddseq2             LIKE xmdd_t.xmddseq2,
                          xmdc027              LIKE xmdc_t.xmdc027,  #160909-00062#1 add
                          xmda004              LIKE xmda_t.xmda004,
                          xmda004_desc         LIKE pmaal_t.pmaal004,
                          xmdd001              LIKE xmdd_t.xmdd001,
                          xmdd040              LIKE xmdd_t.xmdd040,  #160214-00005#2-add
                          xmdd001_desc         LIKE imaal_t.imaal003,
                          xmdd001_desc_desc    LIKE imaal_t.imaal004,
                          xmdd002              LIKE xmdd_t.xmdd002,
                          xmdd002_desc         LIKE imefl_t.imefl005,
                          qty                  LIKE xmdd_t.xmdd006,
                          xmdd006              LIKE xmdd_t.xmdd006,  #160426-00002 by whitney add
                          sfab007              LIKE xmdd_t.xmdd006,  #160426-00002 by whitney add
                          #160805-00023 by whitney add start
                          xmdd006_1            LIKE xmdd_t.xmdd006,
                          sfab007_1            LIKE xmdd_t.xmdd006,
                          imae015              LIKE imae_t.imae015,
                          #160805-00023 by whitney add end
                          xmdd004              LIKE xmdd_t.xmdd004,
                          xmdd004_desc         LIKE oocal_t.oocal003,
                          xmdd011              LIKE xmdd_t.xmdd011
                          END RECORD
DEFINE g_xmdd_d           DYNAMIC ARRAY OF type_xmdd
DEFINE g_xmdd_d_t         type_xmdd
DEFINE l_ac               LIKE type_t.num10  #170104-00066#1 num5->num10  17/01/05 mod by rainy 
DEFINE g_idx              LIKE type_t.num10  #170104-00066#1 num5->num10  17/01/05 mod by rainy 
DEFINE g_rec_b            LIKE type_t.num10  #170104-00066#1 num5->num10  17/01/05 mod by rainy 
DEFINE g_qty              LIKE xmdd_t.xmdd006

#end add-point
 
{</section>}
 
{<section id="asfp301_01.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="asfp301_01.other_dialog" >}
#逾期資料的INPUT
DIALOG asfp301_01_input()
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_qty         LIKE xmdd_t.xmdd006
   
   INPUT ARRAY g_xmdd_d FROM s_detail1_asfp301_01.*
       ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
               INSERT ROW = FALSE,DELETE ROW = FALSE,APPEND ROW = FALSE)
               
       BEFORE INPUT
       
       BEFORE ROW
          LET l_ac = ARR_CURR()
          LET g_xmdd_d_t.* = g_xmdd_d[l_ac].*
          CALL asfp301_01_set_entry_b()
          CALL asfp301_01_set_no_entry_b()
         
       ON CHANGE sel_d1_01
          IF g_xmdd_d[l_ac].sel = 'Y' THEN
             #160805-00023 by whitney modify start
             CALL asfp301_01_get_qty('',g_xmdd_d[l_ac].xmdddocno,g_xmdd_d[l_ac].xmddseq,
                                     g_xmdd_d[l_ac].xmddseq1,g_xmdd_d[l_ac].xmddseq2,g_xmdd_d[l_ac].xmdd001,
                                     g_xmdd_d[l_ac].xmdd006_1,g_xmdd_d[l_ac].sfab007_1,
                                     g_xmdd_d[l_ac].xmdd006,g_xmdd_d[l_ac].sfab007)    
             #160805-00023 by whitney modify end
                  RETURNING l_qty                                     
             IF cl_null(g_xmdd_d[l_ac].qty) OR g_xmdd_d[l_ac].qty > l_qty THEN
                LET g_xmdd_d[l_ac].qty = l_qty
             END IF
          END IF
          CALL asfp301_01_set_entry_b()
          CALL asfp301_01_set_no_entry_b()
               
       AFTER FIELD sel_d1_01
          IF g_xmdd_d[l_ac].sel NOT MATCHES '[YN]' THEN
             NEXT FIELD sel_d1_01
          END IF

       AFTER FIELD qty_d1_01
          IF NOT cl_null(g_xmdd_d[l_ac].qty) THEN
             #160805-00023 by whitney modify start
             CALL asfp301_01_get_qty(g_xmdd_d[l_ac].imae015,g_xmdd_d[l_ac].xmdddocno,g_xmdd_d[l_ac].xmddseq,
                                     g_xmdd_d[l_ac].xmddseq1,g_xmdd_d[l_ac].xmddseq2,g_xmdd_d[l_ac].xmdd001,
                                     g_xmdd_d[l_ac].xmdd006_1,g_xmdd_d[l_ac].sfab007_1,
                                     g_xmdd_d[l_ac].xmdd006,g_xmdd_d[l_ac].sfab007)    
             #160805-00023 by whitney modify end
                  RETURNING l_qty      
             IF g_xmdd_d[l_ac].qty > l_qty THEN
                #数量 %1 超过此项订单项序的可转工单数量 %2
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'asf-00357'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                LET g_errparam.replace[1] = g_xmdd_d[l_ac].qty 
                LET g_errparam.replace[2] =  l_qty
                CALL cl_err()
                NEXT FIELD qty_d1_01
             END IF
          END IF
               
#       ON ACTION selall
#          CALL asfp301_01_sel_all("Y")
#
#       ON ACTION selnone
#          CALL asfp301_01_sel_all("N")
               
   END INPUT

END DIALOG

 
{</section>}
 
{<section id="asfp301_01.other_function" readonly="Y" >}

PUBLIC FUNCTION asfp301_01()

END FUNCTION

PUBLIC FUNCTION asfp301_01_create_temp_table()
   DEFINE r_success         LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   IF NOT asfp301_01_drop_temp_table() THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   CREATE TEMP TABLE asfp301_01_temp(
      xmdddocno            LIKE xmdd_t.xmdddocno,
      xmddseq              LIKE xmdd_t.xmddseq,
      xmddseq1             LIKE xmdd_t.xmddseq1,
      xmddseq2             LIKE xmdd_t.xmddseq2,
      xmda004              LIKE xmda_t.xmda004,
      xmdd001              LIKE xmdd_t.xmdd001,
      xmdd040              LIKE xmdd_t.xmdd040, #160214-00005#2-add
      xmdd002              LIKE xmdd_t.xmdd002,
      qty                  LIKE xmdd_t.xmdd006,
      xmdd004              LIKE xmdd_t.xmdd004,
      xmdd011              LIKE xmdd_t.xmdd011
      )

   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create asfp301_01_temp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #160120-00002#7 s983961--add(s)
   CREATE TEMP TABLE asfp301_tmp01(  #160727-00019#17 2016/08/10  By 08734    临时表长度超过15码的减少到15码以下 p301_01_lock_b_t ——> asfp301_tmp01
      xmdddocno            LIKE xmdd_t.xmdddocno,
      xmddseq              LIKE xmdd_t.xmddseq,
      xmddseq1             LIKE xmdd_t.xmddseq1,
      xmddseq2             LIKE xmdd_t.xmddseq2
      )
   #160120-00002#7 s983961--add(e)   
   RETURN r_success
END FUNCTION

PUBLIC FUNCTION asfp301_01_drop_temp_table()
   DEFINE r_success          LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   DROP TABLE asfp301_01_temp

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop asfp301_01_temp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #160120-00002#7 s983961--add(s)
   DROP TABLE asfp301_tmp01  #160727-00019#17 2016/08/10  By 08734    临时表长度超过15码的减少到15码以下 p301_01_lock_b_t ——> asfp301_tmp01
   #160120-00002#7 s983961--add(e)
   
   RETURN r_success
END FUNCTION
# 畫面資料初始化
PUBLIC FUNCTION asfp301_01_init()

END FUNCTION
#顯示對採購資料查詢的結果
PUBLIC FUNCTION asfp301_01_b_fill()
DEFINE l_wc         STRING
DEFINE l_success    LIKE type_t.num5
DEFINE l_where      STRING
DEFINE l_sql        STRING
DEFINE l_i          LIKE type_t.num10      #170104-00066#1 num5->num10  17/01/05 mod by rainy 
DEFINE l_qty1       LIKE xmdd_t.xmdd006
DEFINE l_qty2       LIKE xmdd_t.xmdd006
DEFINE l_qty3       LIKE xmdd_t.xmdd006
DEFINE l_qty4       LIKE xmdd_t.xmdd006
DEFINE l_qty5       LIKE xmdd_t.xmdd006
DEFINE l_qty6       LIKE xmdd_t.xmdd006
DEFINE l_qty        LIKE xmdd_t.xmdd006
#160805-00023 by whitney modify start
#160120-00002#7 s983961--add(s)
DEFINE l_xmdd  RECORD
    xmdddocno  LIKE xmdd_t.xmdddocno,
    xmddseq    LIKE xmdd_t.xmddseq,
    xmddseq1   LIKE xmdd_t.xmddseq1,
    xmddseq2   LIKE xmdd_t.xmddseq2
           END RECORD
#160120-00002#7 s983961--add(e)
#161219-00070#1-add-s
DEFINE l_sql2       STRING
DEFINE l_count      LIKE type_t.num5
DEFINE l_xmdadocno  LIKE xmda_t.xmdadocno
DEFINE l_xmda005    LIKE xmda_t.xmda005
DEFINE l_xmda007    LIKE xmda_t.xmda007
DEFINE l_xmda008    LIKE xmda_t.xmda008
#161219-00070#1-add-e
DEFINE l_continue   LIKE type_t.num5   #161222-00007#1
#160805-00023 by whitney modify end

   IF cl_null(g_wc) THEN LET g_wc = ' 1=1' END IF
   LET l_wc = g_wc

   #用控制组相关信息过滤料件的WHERE子句
   CALL s_control_get_item_sql('6',g_site,g_user,g_dept,g_sfaadocno)
        RETURNING l_success,l_where
   IF l_success THEN
      LET l_wc = l_wc CLIPPED," AND ",l_where
   END IF

   #160414-00001 by whitney mark start
   #LET l_sql = "SELECT UNIQUE 'N'    ,xmdddocno,xmddseq,0       ,0  ,",
   #            "              xmda004,''       ,xmdd001,xmdd040,''      ,'' ,", #160214-00005#2-add-'xmdd040'
   #            "              xmdd002,''       ,0        ,imae016,'',",
   #            "              ''  ",
   #            "  FROM xmda_t,xmdd_t,imaf_t,imaa_t,imae_t",
   #            " WHERE xmdaent   = xmddent  AND xmdaent  = imafent  ",
   #            "   AND xmdaent   = imaaent  AND xmdaent  = imaeent  ",
   #            "   AND xmdaent = ",g_enterprise,      
   #            "   AND xmdasite  = xmddsite AND xmdasite = imafsite ",
   #            "   AND xmdasite  = imaesite AND xmdasite = '",g_site,"'",
   #            "   AND xmdadocno = xmdddocno ",
   #            "   AND xmdd001   = imaf001 AND xmdd001 = imaa001 AND xmdd001 = imae001",
   #            "   AND (imaf012 = '1' OR imaf012 = '5') ",
   #            "   AND (imaf013 = '2' OR imaf013 = '3') ",
   #            "   AND ",l_wc CLIPPED,
   #            "   AND xmdastus = 'Y'",
   #            " ORDER BY xmdd001,xmda004,xmdd002,xmdddocno,xmddseq"      
   #160414-00001 by whitney mark end
  #161026-00063#1 ---mark (s)---
  ##160805-00023 by whitney modify start
  #LET l_sql = #" SELECT UNIQUE 'N',xmdddocno,xmddseq,xmda004, ",        #160909-00062#1 mark
  #            " SELECT UNIQUE 'N',xmdddocno,xmddseq,xmdc027,xmda004, ", #160909-00062#1 add xmdc027
  #            "(SELECT pmaal004 FROM pmaal_t WHERE pmaal001=xmda004 AND pmaalent=xmdaent AND pmaal002='"||g_dlang||"') pmaal004, ",
  #            "        xmdd001,imaal003,imaal004,0,0,imae015,imae016,oocal003 ",
  #           #"   FROM xmda_t ,xmdd_t ",   #160909-00062#1 mark
  #            #160909-00062#1-(S)-add
  #            "   FROM xmda_t ",
  #            "   LEFT JOIN xmdc_t ON xmdcent = xmdaent AND xmdcdocno = xmdadocno ",   
  #            "   ,xmdd_t ",
  #            #160909-00062#1-(E)-add
  #            "   LEFT JOIN imaal_t ON imaalent=xmddent AND imaal001=xmdd001 AND imaal002='"||g_dlang||"' ",
  #            "   LEFT JOIN (SELECT imaaent,imaa001,imaa009 FROM imaa_t) ON imaaent=xmddent AND imaa001=xmdd001 ",
  #            "   LEFT JOIN (SELECT imafent,imafsite,imaf001,imaf012,imaf013 FROM imaf_t) ON imafent=xmddent AND imaf001=xmdd001 AND imafsite=xmddsite ",
  #            "   LEFT JOIN (SELECT imaeent,imaesite,imae001,imae011,imae012,imae015,imae016,oocal003 FROM imae_t ",
  #            "   LEFT JOIN oocal_t ON oocal001=imae016 AND oocalent=imaeent AND oocal002='"||g_dlang||"') ",
  #            "     ON imaeent=xmddent AND imae001=xmdd001 AND imaesite=xmddsite ",               
  #            "  WHERE xmdaent = xmddent ",
  #            "    AND xmdaent = ? ",
  #            "    AND xmdasite = xmddsite ",
  #            "    AND xmdasite = ? ",
  #            "    AND xmdadocno = xmdddocno ",
  #            "    AND (imaf012 = '1' OR imaf012 = '5') ",
  #            "    AND (imaf013 = '2' OR imaf013 = '3') ",
  #            "    AND ",l_wc CLIPPED,
  #            "    AND xmdastus = 'Y' ",
  #            "    AND NOT EXISTS ( SELECT 1 FROM pmdl_t WHERE pmdlent=xmdaent AND pmdl008=xmdadocno AND pmdlstus<>'X' ) ",  #160907-00044#1
  #            "  ORDER BY xmdd001,xmdddocno,xmddseq "
  ##160805-00023 by whitney modify end
  #161026-00063#1 ---mark (e)---
  
  #161026-00063#1 ---add (s)---
   LET l_sql = " SELECT UNIQUE 'N',xmdddocno,xmddseq,xmddseq1,xmddseq2,xmdc027,xmda004, ", 
               "(SELECT pmaal004 FROM pmaal_t WHERE pmaal001=xmda004 AND pmaalent=xmdaent AND pmaal002='"||g_dlang||"') pmaal004, ",
               "        xmdd001,xmdd040,imaal003,imaal004,xmdd002, ",
               "(SELECT inaml004 FROM inaml_t WHERE inamlent=xmddent AND inaml001=xmdd001 AND inaml002=xmdd002 AND inaml003='"||g_dlang||"') inaml004, ",
               "        0,0,imae015,imae016,oocal003,xmdd011 ",
               "   FROM xmda_t ",
               "   LEFT JOIN xmdc_t ON xmdcent = xmdaent AND xmdcdocno = xmdadocno ",   
               "   ,xmdd_t ",
               "   LEFT JOIN imaal_t ON imaalent=xmddent AND imaal001=xmdd001 AND imaal002='"||g_dlang||"' ",
               "   LEFT JOIN (SELECT imaaent,imaa001,imaa009 FROM imaa_t) ON imaaent=xmddent AND imaa001=xmdd001 ",
               "   LEFT JOIN (SELECT imafent,imafsite,imaf001,imaf012,imaf013 FROM imaf_t) ON imafent=xmddent AND imaf001=xmdd001 AND imafsite=xmddsite ",
               "   LEFT JOIN (SELECT imaeent,imaesite,imae001,imae011,imae012,imae015,imae016,oocal003 FROM imae_t ",
               "   LEFT JOIN oocal_t ON oocal001=imae016 AND oocalent=imaeent AND oocal002='"||g_dlang||"') ",
               "     ON imaeent=xmddent AND imae001=xmdd001 AND imaesite=xmddsite ",               
               "  WHERE xmdaent = xmddent ",
               "    AND xmdaent = ? ",
               "    AND xmdasite = xmddsite ",
               "    AND xmdasite = ? ",
               "    AND xmdadocno = xmdddocno ",
               "    AND xmddseq=xmdcseq ",      #161103-00006#1 add
               "    AND (imaf012 = '1' OR imaf012 = '5') ",
               "    AND (imaf013 = '2' OR imaf013 = '3') ",
               "    AND ",l_wc CLIPPED,
               #161128-00036#1-s-mod
#               "    AND xmdastus = 'Y' ",
               "    AND xmdastus IN ('Y','H') ",
               #161128-00036#1-e-mod
               "    AND NOT EXISTS ( SELECT 1 FROM pmdl_t WHERE pmdlent=xmdaent AND pmdl008=xmdadocno AND pmdlstus<>'X' ) ",
               "  ORDER BY xmdd001,xmdddocno,xmddseq,xmdd011 DESC,xmddseq1 DESC ,xmddseq2 DESC"            
  #161026-00063#1 ---add (e)---

   PREPARE asfp301_01_sel_d1 FROM l_sql
   DECLARE asfp301_01_b_fill_curs_d1 CURSOR FOR asfp301_01_sel_d1
   
   #160805-00023 by whitney modify start
   #LET l_sql = " SELECT xmddseq1,xmddseq2,xmdd011 ",
   #            "   FROM xmdd_t ",
   #            "  WHERE xmddent = ",g_enterprise,
   #            "    AND xmdddocno = ? ",
   #            "    AND xmddseq   = ? ",
   #            "    AND xmdd001   = ? ",
   #            "  ORDER BY xmdd011 DESC,xmddseq1 DESC ,xmddseq2 DESC"
   
  #161026-00063#1 ---mark (s)---
  # LET l_sql = " SELECT xmddseq1,xmddseq2,xmdd040,xmdd002, ",
  #             "(SELECT inaml004 FROM inaml_t WHERE inamlent=xmddent AND inaml001=xmdd001 AND inaml002=xmdd002 AND inaml003='"||g_dlang||"') inaml004, ",
  #             "        0,0,0,xmdd011 ",
  #             "   FROM xmdd_t ",
  #             "  WHERE xmddent = ? ",
  #             "    AND xmdddocno = ? ",
  #             "    AND xmddseq   = ? ",
  #             "    AND xmdd001   = ? ",
  #             "  ORDER BY xmdd011 DESC,xmddseq1 DESC ,xmddseq2 DESC"
  ##160805-00023 by whitney modify end
               
  #PREPARE asfp301_01_sel_d2 FROM l_sql
  #DECLARE asfp301_01_b_fill_curs_d2 CURSOR FOR asfp301_01_sel_d2   
  #161026-00063#1 ---mark (e)---
   
   #160414-00001 by whitney add start
   LET l_sql = "SELECT xmdddocno,xmddseq,xmddseq1,xmddseq2 ", 
               "  FROM xmdd_t ", 
               " WHERE xmddent   = ? ", 
               "   AND xmdddocno = ? ", 
               "   AND xmddseq   = ? ",
               "   AND xmddseq1  = ? ",    
               "   AND xmddseq2  = ? ",                  
               "   FOR UPDATE SKIP LOCKED " 
   PREPARE asfp301_01_chk_locked_prep FROM l_sql 
   #160414-00001 by whitney add end
         
   CALL g_xmdd_d.clear()
   LET l_i = 1  
   ERROR "Searching!"

  #161026-00063#1 ---mark (s)---
  ##160805-00023 by whitney modify start
  #FOREACH asfp301_01_b_fill_curs_d1 USING g_enterprise,g_site
  #   INTO g_xmdd_d[l_i].sel,g_xmdd_d[l_i].xmdddocno,g_xmdd_d[l_i].xmddseq,
  #        g_xmdd_d[l_i].xmdc027,    #160909-00062#1 add
  #        g_xmdd_d[l_i].xmda004,g_xmdd_d[l_i].xmda004_desc,
  #        g_xmdd_d[l_i].xmdd001,g_xmdd_d[l_i].xmdd001_desc,g_xmdd_d[l_i].xmdd001_desc_desc,
  #        g_xmdd_d[l_i].xmdd006_1,g_xmdd_d[l_i].sfab007_1,
  #        g_xmdd_d[l_i].imae015,g_xmdd_d[l_i].xmdd004,g_xmdd_d[l_i].xmdd004_desc
  ##160805-00023 by whitney modify end
  #161026-00063#1 ---mark (e)---
  
  #161026-00063#1 ---add (s)---
   FOREACH asfp301_01_b_fill_curs_d1 USING g_enterprise,g_site
      INTO g_xmdd_d[l_i].sel,g_xmdd_d[l_i].xmdddocno,g_xmdd_d[l_i].xmddseq,g_xmdd_d[l_i].xmddseq1,
           g_xmdd_d[l_i].xmddseq2,
           g_xmdd_d[l_i].xmdc027,   
           g_xmdd_d[l_i].xmda004,g_xmdd_d[l_i].xmda004_desc,
           g_xmdd_d[l_i].xmdd001,g_xmdd_d[l_i].xmdd040,g_xmdd_d[l_i].xmdd001_desc,g_xmdd_d[l_i].xmdd001_desc_desc,
           g_xmdd_d[l_i].xmdd002,g_xmdd_d[l_i].xmdd002_desc,
           g_xmdd_d[l_i].xmdd006_1,g_xmdd_d[l_i].sfab007_1,
           g_xmdd_d[l_i].imae015,g_xmdd_d[l_i].xmdd004,g_xmdd_d[l_i].xmdd004_desc,
           g_xmdd_d[l_i].xmdd011
  #161026-00063#1 ---add (e)---
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:asfp301_01_b_fill_curs_d1"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      #161219-00070#1-add-s
      SELECT xmda005,xmda007,xmda008 INTO l_xmda005,l_xmda007,l_xmda008
        FROM xmda_t
       WHERE xmdaent = g_enterprise
         AND xmdadocno = g_xmdd_d[l_i].xmdddocno
      
      LET l_sql2 = " SELECT xmdadocno ",
                   "   FROM xmda_t ",
                   "  WHERE xmdaent = ",g_enterprise,
                   #161128-00036#1-s-mod
#                   "    AND xmdastus = 'Y' ",
                   "    AND xmdastus IN ('Y','H') ",
                   #161128-00036#1-e-mod
                   "    AND xmda007 = '2' ",
                   "    AND xmda008 = ? "
      PREPARE asfp301_chk_xmda_p FROM l_sql2
      DECLARE asfp301_chk_xmda_c CURSOR FOR asfp301_chk_xmda_p
      
      LET l_sql2 = " SELECT COUNT(1) ",
                   "   FROM sfaa_t ",
                   "  WHERE sfaaent = ",g_enterprise,
                   "    AND sfaastus <> 'X' ",   #161222-00007#1
                   "    AND sfaa005 = '2' ",
                   "    AND sfaa006 = ? "
      PREPARE asfp301_chk_sfaa_p FROM l_sql2
      LET l_sql2 = " SELECT COUNT(1) ",
                   "   FROM sfaa_t,sfab_t ",
                   "  WHERE sfaaent = sfabent ",
                   "    AND sfaadocno = sfabdocno ",
                   "    AND sfaastus <> 'X' ",   #161222-00007#1
                   "    AND sfabent = ",g_enterprise,                     
                   "    AND sfab001 = '2' ",
                   "    AND sfab002 = ? "
      PREPARE asfp301_chk_sfab_p FROM l_sql2
      
      LET l_continue = FALSE   #161222-00007#1
      
      IF l_xmda005 = '5' THEN   #若訂單性質為預先訂單，需檢查該預先訂單對應的訂單是否有轉工單
         LET l_xmdadocno = ''           
         FOREACH asfp301_chk_xmda_c USING g_xmdd_d[l_i].xmdddocno INTO l_xmdadocno
            LET l_count = 0
            EXECUTE asfp301_chk_sfaa_p USING l_xmdadocno INTO l_count
            IF l_count = 0 THEN
               EXECUTE asfp301_chk_sfab_p USING l_xmdadocno INTO l_count                 
            END IF
            IF l_count > 0 THEN
               LET l_continue = TRUE   #161222-00007#1
               CONTINUE FOREACH
            END IF
         END FOREACH
      ELSE
         IF l_xmda007 = '2' THEN
            LET l_count = 0
            EXECUTE asfp301_chk_sfaa_p USING l_xmda008 INTO l_count
            IF l_count = 0 THEN
               EXECUTE asfp301_chk_sfab_p USING l_xmda008 INTO l_count                 
            END IF
            IF l_count > 0 THEN
               CONTINUE FOREACH
            END IF
         END IF
      END IF
      #161219-00070#1-add-e
      #161222-00007#1-add-s
      IF l_continue THEN
         CONTINUE FOREACH
      END IF
      #161222-00007#1-add-e
      
      #BY 订单+项次+料件的 总订单量 总已转工单量 总剩余数量
      #160805-00023 by whitney modify start
      CALL asfp301_01_get_wo_qty(g_xmdd_d[l_i].xmdddocno,g_xmdd_d[l_i].xmddseq,'','',
                                 g_xmdd_d[l_i].xmdd001,g_xmdd_d[l_i].xmdd004)
           RETURNING l_success,l_qty1,l_qty2,l_qty3
      IF NOT l_success THEN CONTINUE FOREACH END IF
      LET g_xmdd_d[l_i].xmdd006_1 = l_qty1
      LET g_xmdd_d[l_i].sfab007_1 = l_qty2
      #160805-00023 by whitney modify end

      #总订单量(BY生产单位) = 0
      IF l_qty1 <= 0 THEN CONTINUE FOREACH END IF
      
      #剩余量
      IF l_qty3 <= 0 THEN CONTINUE FOREACH END IF
      
      #160414-00001 by whitney mark start
      #CALL s_feature_description(l_xmdd.xmdd001,l_xmdd.xmdd002)
      #     RETURNING l_success,l_xmdd.xmdd002_desc
      #160414-00001 by whitney mark end

     #161026-00063#1 ---mark (s)---
     ##160805-00023 by whitney modify start
     #FOREACH asfp301_01_b_fill_curs_d2
     #  USING g_enterprise,g_xmdd_d[l_i].xmdddocno,g_xmdd_d[l_i].xmddseq,g_xmdd_d[l_i].xmdd001
     #   INTO g_xmdd_d[l_i].xmddseq1,g_xmdd_d[l_i].xmddseq2,g_xmdd_d[l_i].xmdd040,
     #        g_xmdd_d[l_i].xmdd002,g_xmdd_d[l_i].xmdd002_desc,g_xmdd_d[l_i].qty,
     #        g_xmdd_d[l_i].xmdd006,g_xmdd_d[l_i].sfab007,
     #        g_xmdd_d[l_i].xmdd011
     ##160805-00023 by whitney modify end
     #   IF SQLCA.sqlcode THEN
     #      INITIALIZE g_errparam TO NULL
     #      LET g_errparam.code = SQLCA.sqlcode
     #      LET g_errparam.extend = "FOREACH asfp301_01_b_fill_curs_d2"
     #      LET g_errparam.popup = TRUE
     #      CALL cl_err()
     #      EXIT FOREACH
     #   END IF  
     #161026-00063#1 ---mark (e)---
         
         #160805-00023 by whitney modify start
         ##160120-00002#4 s983961--add(s)
         INITIALIZE l_xmdd.* TO NULL
         #160414-00001 by whitney mark start
         #LET l_sql = "SELECT xmdddocno,xmddseq,xmddseq1,xmddseq2 ",
         #            "  FROM xmdd_t ",
         #            " WHERE xmddent   = '",g_enterprise,"' ", 
         #            "   AND xmdddocno = '",l_xmdd.xmdddocno,"' ",
         #            "   AND xmddseq   = '",l_xmdd.xmddseq,"' ",
         #            "   AND xmddseq1  = '",l_xmdd.xmddseq1,"' ",
         #            "   AND xmddseq2  = '",l_xmdd.xmddseq2,"' ",
         #            "   FOR UPDATE SKIP LOCKED "
         #PREPARE asfp301_01_chk_locked_prep FROM l_sql
         #EXECUTE asfp301_01_chk_locked_prep INTO l_xmdddocno,l_xmddseq,l_xmddseq1,l_xmddseq2
         #160414-00001 by whitney mark end
         EXECUTE asfp301_01_chk_locked_prep
           USING g_enterprise,g_xmdd_d[l_i].xmdddocno,g_xmdd_d[l_i].xmddseq,g_xmdd_d[l_i].xmddseq1,g_xmdd_d[l_i].xmddseq2
            INTO l_xmdd.xmdddocno,l_xmdd.xmddseq,l_xmdd.xmddseq1,l_xmdd.xmddseq2
         IF cl_null(l_xmdd.xmdddocno) AND
            cl_null(l_xmdd.xmddseq) AND
            cl_null(l_xmdd.xmddseq1) AND
            cl_null(l_xmdd.xmddseq2) THEN
            CONTINUE FOREACH
         END IF
         ##160120-00002#4 s983961--add(e)          
         #160805-00023 by whitney modify end
         
         #BY分项序的剩余量
         #160805-00023 by whitney modify start
         CALL asfp301_01_get_wo_qty(g_xmdd_d[l_i].xmdddocno,g_xmdd_d[l_i].xmddseq,
                                    g_xmdd_d[l_i].xmddseq1,g_xmdd_d[l_i].xmddseq2,
                                    g_xmdd_d[l_i].xmdd001,g_xmdd_d[l_i].xmdd004)
              RETURNING l_success,l_qty4,l_qty5,l_qty6
         IF NOT l_success THEN CONTINUE FOREACH END IF
         #160805-00023 by whitney modify end
         
         #当前项序还有剩余可转量
         IF l_qty6 > 0 THEN
            #总已转量+本次待转量
            LET l_qty = l_qty2 + l_qty6
            #大于总订单量
            IF l_qty > l_qty1 THEN
               LET l_qty = l_qty1 - l_qty2   #订单剩余量
            ELSE
               LET l_qty = l_qty6            #项序的剩余量
            END IF   
            LET l_qty2 = l_qty2 + l_qty      #最新的已转工单量
         ELSE
            CONTINUE FOREACH
         END IF
         
         #160805-00023 by whitney modify start
        #160901-00043#1-s
        #LET g_xmdd_d[l_i].xmdd006 = l_qty1  #分批訂購數量  #160426-00002 by whitney add
        #LET g_xmdd_d[l_i].sfab007 = l_qty2  #已轉工單量    #160426-00002 by whitney add
         LET g_xmdd_d[l_i].xmdd006 = l_qty4
         LET g_xmdd_d[l_i].sfab007 = l_qty5
        #160901-00043#1-e
         LET g_xmdd_d[l_i].qty     = l_qty   #本次轉工單量
         #160805-00023 by whitney modify end
         
         #CALL asfp301_01_detail_show(l_i)  #160414-00001 by whitney mark
         
         LET l_i = l_i + 1
         IF l_i > g_max_rec THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.popup = TRUE
            CALL cl_err()
            #EXIT FOREACH         #161103-00006#1 mark
            CONTINUE FOREACH      #161103-00006#1 add  
         END IF
         
         #已转工单数量大于订单量时,此订单+项次+料件不再处理
        #IF l_qty2 >= l_qty1 THEN      #161124-00014#1   mark
         IF l_qty2 > l_qty1 THEN       #161124-00014#1   add
            EXIT FOREACH
         END IF

     #END FOREACH #161026-00063#1 mark

   END FOREACH
   
   LET g_rec_b = l_i - 1
   CALL g_xmdd_d.deleteElement(l_i)
   CLOSE asfp301_01_b_fill_curs_d1
   FREE asfp301_01_sel_d1

END FUNCTION
#顯示收貨底稿資料
PUBLIC FUNCTION asfp301_01_b_fill2()
#   DEFINE l_sql        STRING
#   DEFINE l_i          LIKE type_t.num5
#   DEFINE l_success    LIKE type_t.num5
#   DEFINE l_where      STRING
#   DEFINE l_wc         STRING
#      
#   LET l_wc = " 1=1"
#   #用控制组相关信息过滤料件的WHERE子句
#   CALL s_control_get_item_sql('6',g_site,g_user,g_dept,g_sfaadocno)
#        RETURNING l_success,l_where
#   IF l_success THEN
#      LET l_wc = l_where
#   END IF
#
##160414-00001 by whitney mark start
##   LET l_sql = "SELECT 'N'     ,xmdddocno,xmddseq,xmddseq1,xmddseq2,",
##               "        xmda004,''       ,xmdd001,''      ,''      ,", 
##               "        xmdd002,''       ,0      ,xmdd004 ,''      ,",
##               "        xmdd011  ",
##               "  FROM asfp301_01_temp,imaa_t",
##               " WHERE xmdd001 = imaa001 ",
##               "   AND imaaent = ",g_enterprise,
##               "   AND ",l_wc CLIPPED,
##               " ORDER BY xmdd001,xmdd011,xmda004,xmdd002,xmdddocno,xmddseq,xmddseq1,xmddseq2"      
##160414-00001 by whitney mark end
#   #160414-00001 by whitney add start
#   LET l_sql = " SELECT 'N',xmdddocno,xmddseq,xmddseq1,xmddseq2,xmda004, ",
#               "(SELECT pmaal004 FROM pmaal_t WHERE pmaal001=xmda004 AND pmaalent='"||g_enterprise||"' AND pmaal002='"||g_dlang||"') pmaal004, ",
#               "        xmdd001,xmdd040,imaal003,imaal004,xmdd002, ",
#               "(SELECT inaml004 FROM inaml_t WHERE inamlent='"||g_enterprise||"' AND inaml001=xmdd001 AND inaml002=xmdd002 AND inaml003='"||g_dlang||"') inaml004, ",
#               "        0,xmdd004, ",
#               "(SELECT oocal003 FROM oocal_t WHERE oocal001=xmdd004 AND oocalent='"||g_enterprise||"' AND oocal002='"||g_dlang||"') oocal003, ",
#               "        xmdd011 ",
#               "   FROM asfp301_01_temp,imaa_t",
#               "   LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001=xmdd001 AND imaal002='"||g_dlang||"' ",
#               "  WHERE xmdd001 = imaa001 ",
#               "    AND imaaent = ",g_enterprise,
#               "    AND ",l_wc CLIPPED,
#               "  ORDER BY xmdd001,xmdd011,xmda004,xmdd002,xmdddocno,xmddseq,xmddseq1,xmddseq2"      
#   #160414-00001 by whitney add end
#
#   PREPARE asfp301_01_temp_sel_d1 FROM l_sql
#   DECLARE asfp301_01_temp_b_fill_curs_d1 CURSOR FOR asfp301_01_temp_sel_d1
#   
#   CALL g_xmdd_d.clear()
#   
#   LET l_i = 1
#   ERROR "Searching!"
#
#   FOREACH asfp301_01_temp_b_fill_curs_d1 INTO g_xmdd_d[l_i].*
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = SQLCA.sqlcode
#         LET g_errparam.extend = "FOREACH:asfp301_01_temp_b_fill_curs_d1"
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#         EXIT FOREACH
#      END IF
#      
##      CALL asfp301_01_detail_show(l_i)  #160414-00001 by whitney mark
#      
#      LET l_i = l_i + 1
#      IF l_i > g_max_rec THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code =  9035
#         LET g_errparam.extend =  ""
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#         EXIT FOREACH
#      END IF
#   END FOREACH
#   
#   LET g_rec_b = l_i - 1
#   CALL g_xmdd_d.deleteElement(l_i)
#   
#   CLOSE asfp301_01_temp_b_fill_curs_d1
#   FREE asfp301_01_temp_sel_d1
#
END FUNCTION

PRIVATE FUNCTION asfp301_01_detail_show(p_i)
   DEFINE p_i           LIKE type_t.num5
   DEFINE l_success     LIKE type_t.num5

#160414-00001 by whitney mark start
#   CALL s_desc_get_trading_partner_abbr_desc(g_xmdd_d[p_i].xmda004)
#        RETURNING g_xmdd_d[p_i].xmda004_desc
#    
#   CALL s_desc_get_item_desc(g_xmdd_d[p_i].xmdd001)
#        RETURNING g_xmdd_d[p_i].xmdd001_desc,g_xmdd_d[p_i].xmdd001_desc_desc
#   
#   CALL s_desc_get_unit_desc(g_xmdd_d[p_i].xmdd004)
#        RETURNING g_xmdd_d[p_i].xmdd004_desc
#   
#   CALL s_feature_description(g_xmdd_d[p_i].xmdd001,g_xmdd_d[p_i].xmdd002)
#        RETURNING l_success,g_xmdd_d[p_i].xmdd002_desc
#160414-00001 by whitney mark end
   
END FUNCTION

PUBLIC FUNCTION asfp301_01_chk_temp_data(p_xmdddocno,p_xmddseq,p_xmddseq1,p_xmddseq2)
   DEFINE p_xmdddocno      LIKE xmdd_t.xmdddocno
   DEFINE p_xmddseq        LIKE xmdd_t.xmddseq
   DEFINE p_xmddseq1       LIKE xmdd_t.xmddseq1
   DEFINE p_xmddseq2       LIKE xmdd_t.xmddseq2
   DEFINE r_success        LIKE type_t.num5
   DEFINE l_cnt            LIKE type_t.num10    #170104-00066#1 num5->num10  17/01/05 mod by rainy 
   
   LET r_success = TRUE
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM asfp301_01_temp
    WHERE xmdddocno = p_xmdddocno
      AND xmddseq   = p_xmddseq
      AND xmddseq1  = p_xmddseq1
      AND xmddseq2  = p_xmddseq2
   IF l_cnt > 0 THEN
      LET r_success = FALSE
   END IF
   
   RETURN r_success
END FUNCTION

PUBLIC FUNCTION asfp301_01_set_entry_b()
   CALL cl_set_comp_required('qty_d1_01',TRUE)      #160426-00002 by whitney add
   CALL cl_set_comp_entry("qty_d1_01",TRUE)
END FUNCTION

PUBLIC FUNCTION asfp301_01_set_no_entry_b()
   IF g_xmdd_d[l_ac].sel = 'N' THEN
      CALL cl_set_comp_required('qty_d1_01',FALSE)  #160426-00002 by whitney add
      CALL cl_set_comp_entry("qty_d1_01",FALSE)
   END IF
END FUNCTION

PUBLIC FUNCTION asfp301_01_delete_temp_table()
   DELETE FROM asfp301_01_temp
   
   DELETE FROM asfp301_tmp01 #160120-00002#7 s983961--add(s)  #160727-00019#17 2016/08/10  By 08734    临时表长度超过15码的减少到15码以下 p301_01_lock_b_t ——> asfp301_tmp01
END FUNCTION

################################################################################
# Descriptions...: 取得订单可转工单数量
# Memo...........:
# Usage..........: CALL asfp301_01_get_wo_qty(p_xmdddocno,p_xmddseq,p_xmddseq1,p_xmddseq2,p_xmdd001,p_sfaa013)
#                       RETURNING r_qty
# Input parameter: p_xmdddocno    订单单号
#                : p_xmddseq      项次
#                : p_xmddseq1     项序
#                : p_xmddseq2     分项序
#                : p_xmdd001      生产料件
#                : p_sfaa013      生产单位
# Return code....: r_success      成功否标识符
#                : r_qty1         订单总数量
#                : r_qty2         已转工单数量
#                : r_qty3         可转工单数量
# Date & Author..: 2014/07/09 By Carrier
# Modify.........: 160805-00023 by whitney
################################################################################
PUBLIC FUNCTION asfp301_01_get_wo_qty(p_xmdddocno,p_xmddseq,p_xmddseq1,p_xmddseq2,p_xmdd001,p_sfaa013)
#DEFINE p_type         LIKE type_t.chr1
DEFINE p_xmdddocno    LIKE xmdd_t.xmdddocno
DEFINE p_xmddseq      LIKE xmdd_t.xmddseq
DEFINE p_xmddseq1     LIKE xmdd_t.xmddseq1
DEFINE p_xmddseq2     LIKE xmdd_t.xmddseq2
DEFINE p_xmdd001      LIKE xmdd_t.xmdd001
DEFINE p_sfaa013      LIKE sfaa_t.sfaa013
DEFINE r_success      LIKE type_t.num5
DEFINE r_qty1         LIKE xmdd_t.xmdd006
DEFINE r_qty2         LIKE xmdd_t.xmdd006
DEFINE r_qty3         LIKE xmdd_t.xmdd006
DEFINE l_xmdd004      LIKE xmdd_t.xmdd004
DEFINE l_xmdd006      LIKE xmdd_t.xmdd006
DEFINE l_sfaa012      LIKE sfaa_t.sfaa012
DEFINE l_success      LIKE type_t.num5
DEFINE l_qty          LIKE xmdd_t.xmdd006
#DEFINE l_imae015      LIKE imae_t.imae015
   
   LET r_qty1 = 0
   LET r_qty2 = 0
   LET r_qty3 = 0
   LET r_success = FALSE
   
   #取订单单位及订单数量
   LET l_xmdd004 = ''
   LET l_xmdd006 = 0
   IF cl_null(p_xmddseq1) THEN
      SELECT xmdd004,SUM(xmdd006) INTO l_xmdd004,l_xmdd006 
        FROM xmdd_t
       WHERE xmddent   = g_enterprise
         AND xmdddocno = p_xmdddocno
         AND xmddseq   = p_xmddseq
         AND xmdd001   = p_xmdd001
       GROUP BY xmdd004
   ELSE
      SELECT xmdd004,xmdd006 INTO l_xmdd004,l_xmdd006
        FROM xmdd_t
       WHERE xmddent   = g_enterprise
         AND xmdddocno = p_xmdddocno
         AND xmddseq   = p_xmddseq
         AND xmddseq1  = p_xmddseq1
         AND xmddseq2  = p_xmddseq2
   END IF
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'sel xmdd_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success,r_qty1,r_qty2,r_qty3
   END IF
   
   IF cl_null(l_xmdd006) THEN LET l_xmdd006 = 0 END IF
   IF l_xmdd006 = 0 THEN
      LET r_success = TRUE
      RETURN r_success,r_qty1,r_qty2,r_qty3
   END IF
   
   #取订单的已转工单数量
   LET l_sfaa012 = 0
   IF cl_null(p_xmddseq1) THEN
      SELECT SUM(sfab007) INTO l_sfaa012
        FROM sfaa_t,sfab_t
       WHERE sfaaent   = sfabent
         AND sfaaent   = g_enterprise
         AND sfaadocno = sfabdocno
         AND sfaastus <> 'X'
         AND sfab001   = '2'   #订单
         AND sfab002   = p_xmdddocno
         AND sfab003   = p_xmddseq
         AND sfaa010   = p_xmdd001
   ELSE
      SELECT SUM(sfab007) INTO l_sfaa012 FROM sfaa_t,sfab_t
       WHERE sfaaent   = sfabent
         AND sfaaent = g_enterprise
         AND sfaadocno = sfabdocno
         AND sfaastus <> 'X'
         AND sfab001   = '2'   #订单
         AND sfab002   = p_xmdddocno
         AND sfab003   = p_xmddseq
         AND sfab004   = p_xmddseq1
         AND sfab005   = p_xmddseq2
   END IF
   IF cl_null(l_sfaa012) THEN LET l_sfaa012 = 0 END IF
   
   #总数量
   LET l_qty = l_xmdd006
   
   #订单单位与生产单位不一致时,数量转到生产单位
   IF p_sfaa013 <> l_xmdd004 THEN
      CALL s_aooi250_convert_qty(p_xmdd001,l_xmdd004,p_sfaa013,l_xmdd006)
           RETURNING l_success,l_qty
      IF NOT l_success THEN
         RETURN r_success,r_qty1,r_qty2,r_qty3
      END IF
   END IF
   
#   #取工单的损耗率
#   LET l_imae015 = 0 
#   IF p_type = '2' THEN
#      SELECT imae015 INTO l_imae015 FROM imae_t
#       WHERE imaeent  = g_enterprise
#         AND imaesite = g_site
#         AND imae001  = p_xmdd001
#      IF cl_null(l_imae015) THEN LET l_imae015 = 0 END IF
#   END IF
#   
#   #纳入损耗率的总数量
#   LET l_qty = l_qty * (1 + l_imae015 / 100)
   
   LET r_qty1 = l_qty        #总订单数量(BY 生产单位) 
   LET r_qty2 = l_sfaa012    #已转工单数量
   #订单可转工单数量 = 总订单数量(BY生产单位) - 已转工单数量(BY生产单位)
   IF l_sfaa012 > l_qty THEN
      LET r_qty3 = 0
   ELSE
      LET r_qty3 = l_qty - l_sfaa012
   END IF
   
   LET r_success = TRUE
   RETURN r_success,r_qty1,r_qty2,r_qty3
END FUNCTION

################################################################################
# Descriptions...: 全选
# Memo...........:
# Usage..........: CALL asfp301_01_sel_all(p_flag)
#                       RETURNING NULL
# Input parameter: p_flag         Y/N
# Return code....: NULL
# Date & Author..: 2014-07-09 By Carrier
# Modify.........:
################################################################################
PUBLIC FUNCTION asfp301_01_sel_all(p_flag)
   DEFINE p_flag         LIKE type_t.chr1
   DEFINE l_i            LIKE type_t.num10    #170104-00066#1 num5->num10  17/01/05 mod by rainy 
   DEFINE l_qty          LIKE xmdd_t.xmdd006
   DEFINE l_success      LIKE type_t.num5

   FOR l_i = 1 TO g_xmdd_d.getLength()
       LET g_xmdd_d[l_i].sel = p_flag
       IF p_flag = 'Y' THEN
          #160805-00023 by whitney modify start
          CALL asfp301_01_get_qty('',g_xmdd_d[l_i].xmdddocno,g_xmdd_d[l_i].xmddseq,
                                  g_xmdd_d[l_i].xmddseq1,g_xmdd_d[l_i].xmddseq2,g_xmdd_d[l_i].xmdd001,
                                  g_xmdd_d[l_i].xmdd006_1,g_xmdd_d[l_i].sfab007_1,
                                  g_xmdd_d[l_i].xmdd006,g_xmdd_d[l_i].sfab007)    
          #160805-00023 by whitney modify end
               RETURNING l_qty  
          LET g_xmdd_d[l_i].qty = l_qty            
       ELSE
          LET g_xmdd_d[l_i].qty = NULL
       END IF
   END FOR
END FUNCTION

################################################################################
# Descriptions...: 取得订单可转工单数量
# Memo...........:
# Usage..........: CALL asfp301_01_get_qty(p_imae015,p_xmdddocno,p_xmddseq,p_xmddseq1,p_xmddseq2,p_xmdd001,p_xmdd006_1,p_sfab007_1,p_xmdd0062,p_sfab007)
#                       RETURNING r_qty
# Input parameter: p_imae015      檢查－工单的损耗率
#                : p_xmdddocno    订单单号
#                : p_xmddseq      项次
#                : p_xmddseq1     项序
#                : p_xmddseq2     分项序
#                : p_xmdd001      生产料件
# Return code....: r_qty
# Date & Author..: 2014/07/09 By Carrier
# Modify.........: 160805-00023 by whitney
################################################################################
PUBLIC FUNCTION asfp301_01_get_qty(p_imae015,p_xmdddocno,p_xmddseq,p_xmddseq1,p_xmddseq2,p_xmdd001,p_xmdd006_1,p_sfab007_1,p_xmdd006,p_sfab007)
DEFINE p_imae015     LIKE imae_t.imae015
DEFINE p_xmdddocno   LIKE xmdd_t.xmdddocno
DEFINE p_xmddseq     LIKE xmdd_t.xmddseq
DEFINE p_xmddseq1    LIKE xmdd_t.xmddseq1
DEFINE p_xmddseq2    LIKE xmdd_t.xmddseq2
DEFINE p_xmdd001     LIKE xmdd_t.xmdd001
DEFINE p_xmdd006_1   LIKE xmdd_t.xmdd006
DEFINE p_sfab007_1   LIKE xmdd_t.xmdd006
DEFINE p_xmdd006     LIKE xmdd_t.xmdd006
DEFINE p_sfab007     LIKE xmdd_t.xmdd006
DEFINE r_qty         LIKE xmdd_t.xmdd006
DEFINE l_qty1        LIKE xmdd_t.xmdd006
DEFINE l_qty2        LIKE xmdd_t.xmdd006
DEFINE l_qty3        LIKE xmdd_t.xmdd006
DEFINE l_qty4        LIKE xmdd_t.xmdd006
DEFINE l_qty5        LIKE xmdd_t.xmdd006
DEFINE l_qty6        LIKE xmdd_t.xmdd006
DEFINE l_qty         LIKE xmdd_t.xmdd006
DEFINE l_tot         LIKE xmdd_t.xmdd006
DEFINE l_success     LIKE type_t.num5
DEFINE l_i           LIKE type_t.num10     #170104-00066#1 num5->num10  17/01/05 mod by rainy 

   LET r_qty = 0
   
   #BY 订单+项次+料件的 总订单量 总已转工单量 总剩余数量
   #160805-00023 by whitney modify start
   #CALL asfp301_01_get_wo_qty(p_type,p_xmdddocno,p_xmddseq,'','',
   #                           p_xmdd001,p_xmdd004)
   #     RETURNING l_success,l_qty1,l_qty2,l_qty3
   #IF NOT l_success THEN
   #   RETURN r_qty
   LET l_qty1 = p_xmdd006_1
   LET l_qty2 = p_sfab007_1
   #纳入损耗率的总数量
   IF cl_null(p_imae015) THEN LET p_imae015 = 0 END IF
   LET l_qty1 = l_qty1 * (1 + p_imae015 / 100)
   IF l_qty2 > l_qty1 THEN
      LET l_qty3 = 0
   ELSE
      LET l_qty3 = l_qty1 - l_qty2
   END IF
   #160805-00023 by whitney modify end

   #总订单量(BY生产单位) = 0
   IF l_qty1 <= 0 THEN
      RETURN r_qty
   END IF
   
   #剩余量
   IF l_qty3 <= 0 THEN
      RETURN r_qty
   END IF
   
   #BY分项序的剩余量
   #160805-00023 by whitney modify start
   #CALL asfp301_01_get_wo_qty(p_type,p_xmdddocno,p_xmddseq,
   #                           p_xmddseq1,p_xmddseq2,p_xmdd001,p_xmdd004)
   #     RETURNING l_success,l_qty4,l_qty5,l_qty6
   #IF NOT l_success THEN
   #   RETURN r_qty
   #END IF   
   LET l_qty4 = p_xmdd006
   LET l_qty5 = p_sfab007
   #纳入损耗率的总数量
   LET l_qty4 = l_qty4 * (1 + p_imae015 / 100)
   IF l_qty5 > l_qty4 THEN
      LET l_qty6 = 0
   ELSE
      LET l_qty6 = l_qty4 - l_qty5
   END IF
   #160805-00023 by whitney modify end
   
   LET l_tot = 0
   FOR l_i = 1 TO g_xmdd_d.getLength()
      IF g_xmdd_d[l_i].sel = 'Y' THEN
         IF g_xmdd_d[l_i].xmdddocno = p_xmdddocno AND g_xmdd_d[l_i].xmddseq = p_xmddseq AND
            g_xmdd_d[l_i].xmdd001   = p_xmdd001   AND (g_xmdd_d[l_i].xmddseq1 <> p_xmddseq1 OR
            g_xmdd_d[l_i].xmddseq2 <> p_xmddseq2) THEN
            LET l_tot = l_tot + g_xmdd_d[l_i].qty
         END IF
      END IF   
   END FOR
   #工单上的数量+其他项次的数量
   LET l_qty2 = l_qty2 + l_tot
   
   #当前项序还有剩余可转量
   IF l_qty6 > 0 THEN
      #总已转量+本次待转量
      LET l_qty = l_qty2 + l_qty6
      #大于总订单量
      IF l_qty > l_qty1 THEN
         LET l_qty = l_qty1 - l_qty2   #订单剩余量
      ELSE
         LET l_qty = l_qty6            #项序的剩余量
      END IF   
   ELSE
      LET l_qty = 0
   END IF

   RETURN l_qty
END FUNCTION

PUBLIC FUNCTION asfp301_01_save_data()
   DEFINE l_i     LIKE type_t.num10        #170104-00066#1 num5->num10  17/01/05 mod by rainy 
   DEFINE l_msg   STRING
   #160120-00002#7 s983961--add(s)   
   DEFINE l_cnt       LIKE type_t.num10    #170104-00066#1 num5->num10  17/01/05 mod by rainy 
   DEFINE l_sql       STRING
   DEFINE l_xmdddocno LIKE xmdd_t.xmdddocno
   DEFINE l_xmddseq   LIKE xmdd_t.xmddseq
   DEFINE l_xmddseq1  LIKE xmdd_t.xmddseq1 
   DEFINE l_xmddseq2  LIKE xmdd_t.xmddseq2
   DEFINE l_where     STRING
   #160120-00002#7 s983961--add(e) 
   
   CALL cl_showmsg_init()
   CALL asfp301_01_delete_temp_table()

   FOR l_i = 1 TO g_xmdd_d.getLength()
      IF g_xmdd_d[l_i].sel = 'Y' THEN
         IF g_xmdd_d[l_i].qty > 0 THEN
            INSERT INTO asfp301_01_temp (xmdddocno,xmddseq,xmddseq1,xmddseq2,xmda004,
                                         xmdd001,xmdd040,  xmdd002,qty,     xmdd004, xmdd011) #160214-00005#2-add-'xmdd040'
            VALUES(g_xmdd_d[l_i].xmdddocno,g_xmdd_d[l_i].xmddseq, g_xmdd_d[l_i].xmddseq1,
                   g_xmdd_d[l_i].xmddseq2, g_xmdd_d[l_i].xmda004, g_xmdd_d[l_i].xmdd001,
                   g_xmdd_d[l_i].xmdd040, #160214-00005#2-add
                   g_xmdd_d[l_i].xmdd002,  g_xmdd_d[l_i].qty,     g_xmdd_d[l_i].xmdd004,
                   g_xmdd_d[l_i].xmdd011)
            #160120-00002#4 s983961--add(s)  
            LET l_cnt = 0
            SELECT COUNT(*) INTO l_cnt
              FROM asfp301_tmp01  #160727-00019#17 2016/08/10  By 08734    临时表长度超过15码的减少到15码以下 p301_01_lock_b_t ——> asfp301_tmp01
             WHERE xmdddocno = g_xmdd_d[l_i].xmdddocno
               AND xmddseq   = g_xmdd_d[l_i].xmddseq
               AND xmddseq1  = g_xmdd_d[l_i].xmddseq1
               AND xmddseq2  = g_xmdd_d[l_i].xmddseq2
            IF cl_null(l_cnt) OR l_cnt = 0 THEN
               INSERT INTO asfp301_tmp01(xmdddocno,xmddseq,xmddseq1,xmddseq2)   #160727-00019#17 2016/08/10  By 08734    临时表长度超过15码的减少到15码以下 p301_01_lock_b_t ——> asfp301_tmp01
               VALUES(g_xmdd_d[l_i].xmdddocno,g_xmdd_d[l_i].xmddseq,g_xmdd_d[l_i].xmddseq1,g_xmdd_d[l_i].xmddseq2)
            END IF
            #160120-00002#4 s983961--add(e)                                       
         ELSE
            CALL cl_getmsg_parm('axm-00219',g_dlang,g_xmdd_d[l_i].xmdddocno ||'|'|| g_xmdd_d[l_i].xmddseq ||'|'||
                                g_xmdd_d[l_i].xmddseq1 ||'|'|| g_xmdd_d[l_i].xmddseq2 )
                 RETURNING l_msg
            #待转数量 不可 小于等于零,不进行处理
            CALL cl_errmsg('xmdddocno',g_xmdd_d[l_i].xmdddocno,l_msg,'asf-00360',1)
         END IF
      END IF
   END FOR

#160706-00037#8-s mark
#第一步查出待拋轉資料時不做LOCK
#   #160120-00002#1 s983961--add(s)  
#   LET l_sql = "SELECT xmdddocno,xmddseq,xmddseq1,xmddseq2 ",
#               "  FROM asfp301_tmp01 ",  #160727-00019#17 2016/08/10  By 08734    临时表长度超过15码的减少到15码以下 p301_01_lock_b_t ——> asfp301_tmp01
#               " ORDER BY xmdddocno,xmddseq,xmddseq1,xmddseq2 "
#   PREPARE asfp301_lock_prep FROM l_sql
#   DECLARE asfp301_lock_curs CURSOR FOR asfp301_lock_prep
#   
#   LET l_sql = "SELECT xmdddocno,xmddseq,xmddseq1,xmddseq2 ",
#               "  FROM pmdo_t ",
#               " WHERE "
#   
#   LET l_where = ''
#   FOREACH asfp301_lock_curs INTO l_xmdddocno,l_xmddseq,l_xmddseq1,l_xmddseq2
#      IF cl_null(l_where) THEN
#         LET l_where = "(xmdddocno = '",l_xmdddocno,"' AND xmddseq = '",l_xmddseq,"' AND xmddseq1 = '",l_xmddseq1,"' AND xmddseq2 = '",l_xmddseq2,"') "
#      ELSE
#         LET l_where = l_where," OR ","(xmdddocno = '",l_xmdddocno,"' AND xmddseq = '",l_xmddseq,"' AND xmddseq1 = '",l_xmddseq1,"' AND xmddseq2 = '",l_xmddseq2,"') "
#      END IF
#   END FOREACH
#   
#   LET l_sql = l_sql,l_where," FOR UPDATE "
#   PREPARE asfp301_lock_body_prep FROM l_sql 
#   DECLARE asfp301_lock_body_curs CURSOR FOR asfp301_lock_body_prep
#   OPEN asfp301_lock_body_curs
#   #160120-00002#1 s983961--add(e)
#160706-00037#8-e mark

   CALL cl_showmsg()

END FUNCTION

 
{</section>}
 
