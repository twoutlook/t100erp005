#該程式未解開Section, 採用最新樣板產出!
{<section id="asfp301_03.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0009(2016-02-24 10:37:23), PR版次:0009(2017-01-06 14:21:29)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000090
#+ Filename...: asfp301_03
#+ Description: 訂單轉工單作業 – 拼單調整
#+ Creator....: 00378(2014-07-10 15:03:21)
#+ Modifier...: 07024 -SD/PR- 00700
 
{</section>}
 
{<section id="asfp301_03.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"
#160214-00005#2  2016/03/17  By  dorislai  增加BOM特性合併
#160727-00019#17 2016/08/10  By 08734    临时表长度超过15码的减少到15码以下 asfp301_03_temp_d1 ——> asfp301_tmp02,asfp301_03_temp_d2 ——> asfp301_tmp03
#161109-00085#37 2016/11/17 By lienjunqi    整批調整系統星號寫法
#170104-00066#1  2017/01/04  By Rainy     筆數相關變數由num5放大至num10
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
 
{<section id="asfp301_03.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
#單身 type 宣告
DEFINE l_ac              LIKE type_t.num10   #170104-00066#1 num5->num10  17/01/05 mod by rainy 
DEFINE l_ac2             LIKE type_t.num10   #170104-00066#1 num5->num10  17/01/05 mod by rainy 
DEFINE g_master_idx      LIKE type_t.num10   #170104-00066#1 num5->num10  17/01/05 mod by rainy 

DEFINE g_rec_b           LIKE type_t.num10   #170104-00066#1 num5->num10  17/01/05 mod by rainy 
DEFINE g_rec_b2          LIKE type_t.num10   #170104-00066#1 num5->num10  17/01/05 mod by rainy 
DEFINE g_success         LIKE type_t.chr1
DEFINE g_result_str      LIKE type_t.chr1000
TYPE type_sfaa           RECORD                                         
                         keyno              LIKE type_t.num5,
                         sfaa005            LIKE sfaa_t.sfaa005, 
                         sfaa006            LIKE sfaa_t.sfaa006, 
                         sfaa007            LIKE sfaa_t.sfaa007, 
                         sfaa008            LIKE sfaa_t.sfaa008, 
                         sfaa063            LIKE sfaa_t.sfaa063, 
                         sfaa009            LIKE sfaa_t.sfaa009, 
                         sfaa010            LIKE sfaa_t.sfaa010, 
                         sfaa011            LIKE sfaa_t.sfaa011, #特性 #160214-00005#2-add
                         sfac006            LIKE sfac_t.sfac006,
                         sfaa012            LIKE sfaa_t.sfaa012, 
                         sfaa013            LIKE sfaa_t.sfaa013, 
                         sfaa019            LIKE sfaa_t.sfaa019, 
                         sfaa020            LIKE sfaa_t.sfaa020
                         END RECORD
TYPE type_xmdd           RECORD 
                         keyno              LIKE type_t.num5,
                         xmdddocno          LIKE xmdd_t.xmdddocno, 
                         xmddseq            LIKE xmdd_t.xmddseq, 
                         xmddseq1           LIKE xmdd_t.xmddseq1, 
                         xmddseq2           LIKE xmdd_t.xmddseq2, 
                         xmda004            LIKE xmda_t.xmda004, 
                         xmdd001            LIKE xmdd_t.xmdd001, 
                         xmdd040            LIKE xmdd_t.xmdd040, #160214-00005#2-add
                         xmdd002            LIKE xmdd_t.xmdd002, 
                         xmdd006            LIKE xmdd_t.xmdd006, 
                         xmdd004            LIKE xmdd_t.xmdd004, 
                         qty                LIKE xmdd_t.xmdd006,
                         xmdd011            LIKE xmdd_t.xmdd011
                         END RECORD                           
#end add-point
 
{</section>}
 
{<section id="asfp301_03.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="asfp301_03.other_dialog" >}

DIALOG asfp301_03_display()
   DEFINE l_success        LIKE type_t.num5
   
   DISPLAY ARRAY g_sfaa_d TO s_detail1_asfp301_03.* ATTRIBUTE(COUNT = g_rec_b)
      BEFORE DISPLAY
         CALL FGL_SET_ARR_CURR(l_ac)

      BEFORE ROW
        LET l_ac = DIALOG.getCurrentRow("s_detail1_asfp301_03")
        LET g_master_idx = l_ac
        CALL asfp301_03_fetch()
        
      ON DRAG_START(go_dnd)
        LET drag_source = "s_detail1"
        LET drag_index  = arr_curr()

      ON DRAG_FINISHED(go_dnd)
        INITIALIZE drag_source TO NULL

      ON DRAG_ENTER(go_dnd)
        IF drag_source IS NULL THEN
          CALL go_dnd.setOperation(NULL)
        END IF

      ON DROP(go_dnd)
          LET drop_index = go_dnd.getLocationRow()      
          CALL asfp301_03_drag()
               RETURNING l_success
          IF NOT l_success THEN
             CONTINUE DIALOG
          ELSE
             CALL FGL_SET_ARR_CURR(drop_index)
#             CALL ui.Interface.refresh()
          END IF
        
   END DISPLAY
END DIALOG

DIALOG asfp301_03_display2()
   DEFINE l_success        LIKE type_t.num5
   
   DISPLAY ARRAY g_xmdd_d TO s_detail2_asfp301_03.* ATTRIBUTE(COUNT = g_rec_b2)
      BEFORE DISPLAY
         CALL FGL_SET_ARR_CURR(l_ac2)

      BEFORE ROW
        LET l_ac2 = DIALOG.getCurrentRow("s_detail2_asfp301_03")

      ON DRAG_START(go_dnd)
        LET drag_source = "s_detail2"
        LET drag_index  = arr_curr()

      ON DRAG_FINISHED(go_dnd)
        INITIALIZE drag_source TO NULL

      ON DRAG_ENTER(go_dnd)
        IF drag_source IS NULL THEN
          CALL go_dnd.setOperation(NULL)
        END IF

#      ON DROP(go_dnd)
#          LET drop_index = go_dnd.getLocationRow()      
#          CALL asfp301_03_drag()
#               RETURNING l_success
#          IF NOT l_success THEN
#             CONTINUE DIALOG
#          END IF



   END DISPLAY
END DIALOG

 
{</section>}
 
{<section id="asfp301_03.other_function" readonly="Y" >}

PUBLIC FUNCTION asfp301_03(--)
   #add-point:input段變數傳入

   #end add-point
   )
   DEFINE l_ac_t          LIKE type_t.num5        #未取消的ARRAY CNT
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否
   DEFINE l_count         LIKE type_t.num5
   DEFINE l_insert        LIKE type_t.num5
   DEFINE l_cmd           LIKE type_t.chr5
   #add-point:input段define
   #end add-point

END FUNCTION

PUBLIC FUNCTION asfp301_03_init()
   CALL cl_set_combo_scc('sfaa005_d1_03','4009')
END FUNCTION

PUBLIC FUNCTION asfp301_03_create_temp_table()
   DEFINE r_success         LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   IF NOT asfp301_03_drop_temp_table() THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   CREATE TEMP TABLE asfp301_tmp02(  #160727-00019#17 2016/08/10  By 08734    临时表长度超过15码的减少到15码以下 asfp301_03_temp_d1 ——> asfp301_tmp02
          keyno              LIKE type_t.num5,
          sfaa005            LIKE sfaa_t.sfaa005, 
          sfaa006            LIKE sfaa_t.sfaa006, 
          sfaa007            LIKE sfaa_t.sfaa007, 
          sfaa008            LIKE sfaa_t.sfaa008, 
          sfaa063            LIKE sfaa_t.sfaa063, 
          sfaa009            LIKE sfaa_t.sfaa009, 
          sfaa010            LIKE sfaa_t.sfaa010, 
          sfaa011            LIKE sfaa_t.sfaa011, #特性 #160214-00005#2-add
          sfac006            LIKE sfac_t.sfac006,
          sfaa012            LIKE sfaa_t.sfaa012, 
          sfaa013            LIKE sfaa_t.sfaa013, 
          sfaa019            LIKE sfaa_t.sfaa019, 
          sfaa020            LIKE sfaa_t.sfaa020
      )

   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create asfp301_tmp02'  #160727-00019#17 2016/08/10  By 08734    临时表长度超过15码的减少到15码以下 asfp301_03_temp_d1 ——> asfp301_tmp02
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   CREATE TEMP TABLE asfp301_tmp03(  #160727-00019#17 2016/08/10  By 08734    临时表长度超过15码的减少到15码以下 asfp301_03_temp_d2 ——> asfp301_tmp03
          keyno               LIKE type_t.num5,
          xmdddocno           LIKE xmdd_t.xmdddocno, 
          xmddseq             LIKE xmdd_t.xmddseq, 
          xmddseq1            LIKE xmdd_t.xmddseq1, 
          xmddseq2            LIKE xmdd_t.xmddseq2, 
          xmda004             LIKE xmda_t.xmda004, 
          xmdd001             LIKE xmdd_t.xmdd001, 
          xmdd040             LIKE xmdd_t.xmdd040, #160214-00005#2-add
          xmdd002             LIKE xmdd_t.xmdd002, 
          xmdd006             LIKE xmdd_t.xmdd006, 
          xmdd004             LIKE xmdd_t.xmdd004, 
          qty                 LIKE xmdd_t.xmdd006,
          xmdd011             LIKE xmdd_t.xmdd011
      )

   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create asfp301_tmp03'  #160727-00019#17 2016/08/10  By 08734    临时表长度超过15码的减少到15码以下 asfp301_03_temp_d2 ——> asfp301_tmp03
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

PUBLIC FUNCTION asfp301_03_drop_temp_table()
   DEFINE r_success          LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   DROP TABLE asfp301_tmp02  #160727-00019#17 2016/08/10  By 08734    临时表长度超过15码的减少到15码以下 asfp301_03_temp_d1 ——> asfp301_tmp02

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop asfp301_tmp02'  #160727-00019#17 2016/08/10  By 08734    临时表长度超过15码的减少到15码以下 asfp301_03_temp_d1 ——> asfp301_tmp02
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   DROP TABLE asfp301_tmp03  #160727-00019#17 2016/08/10  By 08734    临时表长度超过15码的减少到15码以下 asfp301_03_temp_d2 ——> asfp301_tmp03

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop asfp301_tmp03'  #160727-00019#17 2016/08/10  By 08734    临时表长度超过15码的减少到15码以下 asfp301_03_temp_d2 ——> asfp301_tmp03
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

PUBLIC FUNCTION asfp301_03_fetch()
   DEFINE l_i         LIKE type_t.num10    #170104-00066#1 num5->num10  17/01/05 mod by rainy 
   DEFINE l_sql       STRING

   CALL g_xmdd_d.clear()

   IF g_master_idx <=0 THEN
      LET g_rec_b2 = 0
      RETURN
   END IF
   
#160414-00001 by whitney mark start
#   LET l_sql = " SELECT keyno   , xmdddocno, xmddseq, xmddseq1,", 
#               "        xmddseq2, xmda004  , ''     , xmdd001 ,xmdd040,", #160214-00005#2-add-'xmdd040'
#               "        ''      , ''       , xmdd002, ''      ,xmdd006 ,", 
#               "        xmdd004 , ''       , qty    , xmdd011  ",
#               "  FROM asfp301_03_temp_d2",
#               " WHERE keyno = ",g_sfaa_d[g_master_idx].keyno CLIPPED
#160414-00001 by whitney mark end
   #160414-00001 by whitney add start
   LET l_sql = " SELECT keyno,xmdddocno,xmddseq,xmddseq1,xmddseq2,xmda004, ",
               "(SELECT pmaal004 FROM pmaal_t WHERE pmaal001=xmda004 AND pmaalent='"||g_enterprise||"' AND pmaal002='"||g_dlang||"') pmaal004, ",
               "        xmdd001,xmdd040,imaal003,imaal004,xmdd002, ",
               "(SELECT inaml004 FROM inaml_t WHERE inamlent='"||g_enterprise||"' AND inaml001=xmdd001 AND inaml002=xmdd002 AND inaml003='"||g_dlang||"') inaml004, ",
               "        xmdd006,xmdd004, ",
               "(SELECT oocal003 FROM oocal_t WHERE oocal001=xmdd004 AND oocalent='"||g_enterprise||"' AND oocal002='"||g_dlang||"') oocal003, ",
               "        qty,xmdd011 ",
               "  FROM asfp301_tmp03",  #160727-00019#17 2016/08/10  By 08734    临时表长度超过15码的减少到15码以下 asfp301_03_temp_d2 ——> asfp301_tmp03
               "  LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001=xmdd001 AND imaal002='"||g_dlang||"' ",
               " WHERE keyno = ",g_sfaa_d[g_master_idx].keyno CLIPPED
   #160414-00001 by whitney add end
   PREPARE asfp301_03_temp_d2_sel FROM l_sql
   DECLARE asfp301_03_temp_d2_b_fill_curs CURSOR FOR asfp301_03_temp_d2_sel

   LET l_i = 1

   FOREACH asfp301_03_temp_d2_b_fill_curs INTO g_xmdd_d[l_i].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:asfp301_03_temp_d2_b_fill_curs"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF

#      CALL asfp301_03_detail_show(2,l_i)  #160414-00001 by whitney mark

      LET l_i = l_i + 1
      IF l_i > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ""
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
   END FOREACH
   
   LET g_rec_b2 = l_i - 1
   CALL g_xmdd_d.deleteElement(l_i)
   CLOSE asfp301_03_temp_d2_b_fill_curs
   FREE asfp301_03_temp_d2_sel

END FUNCTION

PUBLIC FUNCTION asfp301_03_b_fill()
   DEFINE l_sql        STRING
   DEFINE l_i          LIKE type_t.num10   #170104-00066#1 num5->num10  17/01/05 mod by rainy 

#160414-00001 by whitney mark start
#   LET l_sql = " SELECT keyno  , sfaa005, sfaa006, sfaa007,",
#               "        sfaa008, sfaa063, sfaa009, ''     ,",
#               "        sfaa010, sfaa011, ''     , ''     , sfac006, '',sfaa012,", #160214-00005#2-add-'sfaa011'
#               "        sfaa013, ''     , sfaa019, sfaa020 ",  
#               "  FROM asfp301_03_temp_d1"
#160414-00001 by whitney mark end
   #160414-00001 by whitney add start
   LET l_sql = " SELECT keyno,sfaa005,sfaa006,sfaa007,sfaa008,sfaa063,sfaa009, ",
               "(SELECT pmaal004 FROM pmaal_t WHERE pmaal001=sfaa009 AND pmaalent='"||g_enterprise||"' AND pmaal002='"||g_dlang||"') pmaal004, ",
               "        sfaa010,sfaa011,imaal003,imaal004,sfac006, ",
               "(SELECT inaml004 FROM inaml_t WHERE inamlent='"||g_enterprise||"' AND inaml001=sfaa010 AND inaml002=sfac006 AND inaml003='"||g_dlang||"') inaml004, ",
               "        sfaa012, sfaa013, ",
               "(SELECT oocal003 FROM oocal_t WHERE oocal001=sfaa013 AND oocalent='"||g_enterprise||"' AND oocal002='"||g_dlang||"') oocal003, ",
               "        '','','','','','',sfaa019,sfaa020,'','' ",
               "  FROM asfp301_tmp02 ",  #160727-00019#17 2016/08/10  By 08734    临时表长度超过15码的减少到15码以下 asfp301_03_temp_d1 ——> asfp301_tmp02
               "  LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001=sfaa010 AND imaal002='"||g_dlang||"' "
   #160414-00001 by whitney add end

   PREPARE asfp301_03_temp_d1_sel FROM l_sql
   DECLARE asfp301_03_temp_d1_b_fill_curs CURSOR FOR asfp301_03_temp_d1_sel
   
   CALL g_sfaa_d.clear()
   LET l_i = 1
   ERROR "Searching!"

   FOREACH asfp301_03_temp_d1_b_fill_curs INTO g_sfaa_d[l_i].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:asfp301_03_temp_d1_b_fill_curs"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
   
#      CALL asfp301_03_detail_show(1,l_i)  #160414-00001 by whitney mark
      
      LET l_i = l_i + 1
      IF l_i > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ""
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
   END FOREACH
   
   LET g_rec_b = l_i - 1
   CALL g_sfaa_d.deleteElement(l_i)
   CLOSE asfp301_03_temp_d1_b_fill_curs
   FREE asfp301_03_temp_d1_sel
   
   LET g_master_idx = 1
   CALL asfp301_03_fetch()

END FUNCTION

PRIVATE FUNCTION asfp301_03_detail_show(p_i,p_idx)
   DEFINE p_i            LIKE type_t.num5
   DEFINE p_idx          LIKE type_t.num10   #170104-00066#1 num5->num10  17/01/05 mod by rainy 
   DEFINE l_success      LIKE type_t.num5
   
   IF p_i = 1 THEN
      CALL s_desc_get_trading_partner_abbr_desc(g_sfaa_d[p_idx].sfaa009)
           RETURNING g_sfaa_d[p_idx].sfaa009_desc

      CALL s_desc_get_item_desc(g_sfaa_d[p_idx].sfaa010)
           RETURNING g_sfaa_d[p_idx].sfaa010_desc,g_sfaa_d[p_idx].sfaa010_desc_desc

      CALL s_desc_get_unit_desc(g_sfaa_d[p_idx].sfaa013)
           RETURNING g_sfaa_d[p_idx].sfaa013_desc

      CALL s_feature_description(g_sfaa_d[p_idx].sfaa010,g_sfaa_d[p_idx].sfac006)
           RETURNING l_success,g_sfaa_d[p_idx].sfac006_desc       
   END IF
   

   IF p_i = 2 THEN
      CALL s_desc_get_trading_partner_abbr_desc(g_xmdd_d[p_idx].xmda004)
           RETURNING g_xmdd_d[p_idx].xmda004_desc
          
      CALL s_desc_get_item_desc(g_xmdd_d[p_idx].xmdd001)
           RETURNING g_xmdd_d[p_idx].xmdd001_desc,g_xmdd_d[p_idx].xmdd001_desc_desc

      CALL s_desc_get_unit_desc(g_xmdd_d[p_idx].xmdd004)
           RETURNING g_xmdd_d[p_idx].xmdd004_desc

      CALL s_feature_description(g_xmdd_d[p_idx].xmdd001,g_xmdd_d[p_idx].xmdd002)
           RETURNING l_success,g_xmdd_d[p_idx].xmdd002_desc
   END IF
   
END FUNCTION

PUBLIC FUNCTION asfp301_03_delete_temp_table()
   DELETE FROM asfp301_tmp02;  #160727-00019#17 2016/08/10  By 08734    临时表长度超过15码的减少到15码以下 asfp301_03_temp_d1 ——> asfp301_tmp02
   DELETE FROM asfp301_tmp03;  #160727-00019#17 2016/08/10  By 08734    临时表长度超过15码的减少到15码以下 asfp301_03_temp_d2 ——> asfp301_tmp03
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL asfp301_03_gen_data()
#                       RETURNING r_success
# Input parameter: NULL
# Return code....: r_success
# Date & Author..: 2014-07-11 By Carrier
# Modify.........:
################################################################################
PUBLIC FUNCTION asfp301_03_gen_data()
   DEFINE r_success        LIKE type_t.num5
   DEFINE l_success        LIKE type_t.num5
   DEFINE l_sql            STRING
   TYPE type_tmp           RECORD
                           xmdddocno          LIKE xmdd_t.xmdddocno,
                           xmddseq            LIKE xmdd_t.xmddseq,
                           xmddseq1           LIKE xmdd_t.xmddseq1,
                           xmddseq2           LIKE xmdd_t.xmddseq2,
                           xmda004            LIKE xmda_t.xmda004,
                           xmdd001            LIKE xmdd_t.xmdd001,
                           xmdd040            LIKE xmdd_t.xmdd040,  #BOM特性 #160214-00005#2-add
                           xmdd002            LIKE xmdd_t.xmdd002,
                           qty                LIKE xmdd_t.xmdd006,
                           xmdd004            LIKE xmdd_t.xmdd004,
                           xmdd011            LIKE xmdd_t.xmdd011
                           END RECORD
   DEFINE l_tmp            type_tmp
   DEFINE l_sfaa           type_sfaa
   DEFINE l_sfaa_tmp       type_sfaa   
   DEFINE l_xmdd           type_xmdd                      
   DEFINE l_where          STRING
   DEFINE l_i              LIKE type_t.num10      
   DEFINE l_cmd            LIKE type_t.chr1 
   DEFINE l_flag           LIKE type_t.chr1   
   DEFINE l_xmdd004        LIKE xmdd_t.xmdd004
   DEFINE l_rate           LIKE inaj_t.inaj014
   
   WHENEVER ERROR CONTINUE
   LET r_success = FALSE
   
   #将临时表清除
   CALL asfp301_03_delete_temp_table()

   #取STEP-1的订单信息
   LET l_sql = "SELECT xmdddocno, xmddseq, xmddseq1, xmddseq2,",
               "       xmda004  , xmdd001, xmdd040 , xmdd002 , qty,     ", #160214-00005#2-add-'xmdd040'
               "       xmdd004  , xmdd011  ",
               "  FROM asfp301_01_temp ",
               " ORDER BY xmdd001,xmdd004 "
               
   PREPARE asfp301_03_gen_data_p1 FROM l_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'prepare asfp301_03_gen_data_p1'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   DECLARE asfp301_03_gen_data_cs1 CURSOR FOR asfp301_03_gen_data_p1
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'declare asfp301_03_gen_data_cs1'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
      
   LET l_i = 1
   FOREACH asfp301_03_gen_data_cs1 INTO l_tmp.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach asfp301_03_gen_data_cs1'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF
      
      #拼单
      IF g_setting.choice1 = '1' THEN    
         LET l_cmd = 'a'
      ELSE
         LET l_sql = "SELECT * FROM asfp301_tmp02",  #160727-00019#17 2016/08/10  By 08734    临时表长度超过15码的减少到15码以下 asfp301_03_temp_d1 ——> asfp301_tmp02
                     " WHERE sfaa010 = '",l_tmp.xmdd001,"'",
                     "   AND sfaa013 = '",l_tmp.xmdd004,"'"
         #160214-00005#5-add-(S)
         IF cl_null(l_tmp.xmdd040) THEN
            LET l_sql = l_sql CLIPPED," AND (sfaa011 = ' ' OR sfaa011 IS NULL)"
         ELSE
            LET l_sql = l_sql CLIPPED," AND sfaa011 = '",l_tmp.xmdd040,"'"
         END IF
         #160214-00005#5-add-(E)
         LET l_where = ' 1= 1'
         IF g_setting.choice5 = 'Y' THEN   #按订单拼单      
            LET l_where = l_where CLIPPED," AND sfaa006 = '",l_tmp.xmdddocno,"'"     
         END IF
         
         IF g_setting.choice3 = 'Y' THEN   #按客户拼单
            LET l_where = l_where CLIPPED," AND sfaa009 = '",l_tmp.xmda004,"'"
         END IF
         
         IF g_setting.choice4 = 'Y' THEN   #按产品特征拼单
            LET l_where = l_where CLIPPED," AND sfac006 = '",l_tmp.xmdd002,"'"
         END IF
         
         IF g_setting.choice2 = 'Y' THEN   #按预计交期拼单
            LET l_where = l_where CLIPPED," AND sfaa020 = '",l_tmp.xmdd011,"'"
         END IF
         
         LET l_sql = l_sql CLIPPED," AND ",l_where
         PREPARE asfp301_03_gen_data_p2 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'prepare asfp301_03_gen_data_p2'
            LET g_errparam.popup = TRUE
            CALL cl_err()

            RETURN r_success
         END IF
         EXECUTE asfp301_03_gen_data_p2 INTO l_sfaa.*
         IF SQLCA.sqlcode AND SQLCA.sqlcode <> 100 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'execute asfp301_03_gen_data_p2'
            LET g_errparam.popup = TRUE
            CALL cl_err()

            RETURN r_success   
         ELSE
            IF SQLCA.sqlcode = 100 THEN
               LET l_cmd = 'a'
            ELSE
               LET l_cmd = 'u'
            END IF
         END IF       
      END IF
      
      IF l_cmd = 'a' THEN
         SELECT MAX(keyno) + 1 INTO l_i FROM asfp301_tmp02  #160727-00019#17 2016/08/10  By 08734    临时表长度超过15码的减少到15码以下 asfp301_03_temp_d1 ——> asfp301_tmp02
         IF cl_null(l_i) THEN LET l_i = 1 END IF
    
         LET l_sfaa.keyno   = l_i                 #项次 
         LET l_sfaa.sfaa005 = '2'                 #来源-订单   

         LET l_sfaa.sfaa006 = l_tmp.xmdddocno     #订单单号
         IF l_sfaa.sfaa006 IS NULL THEN
            LET l_sfaa.sfaa006 = ' '
         END IF
         LET l_sfaa.sfaa007 = l_tmp.xmddseq       #项次
         LET l_sfaa.sfaa008 = l_tmp.xmddseq1      #项序
         LET l_sfaa.sfaa063 = l_tmp.xmddseq2      #分批序
         
         LET l_sfaa.sfaa009 = l_tmp.xmda004       #客户
         IF l_sfaa.sfaa009 IS NULL THEN
            LET l_sfaa.sfaa009 = ' '
         END IF
         LET l_sfaa.sfaa010 = l_tmp.xmdd001       #料号
         LET l_sfaa.sfaa011 = l_tmp.xmdd040       #特性 #160214-00005#2-add
         LET l_sfaa.sfac006 = l_tmp.xmdd002       #特征
         IF l_sfaa.sfac006 IS NULL THEN
            LET l_sfaa.sfac006 = ' '
         END IF
    
         LET l_sfaa.sfaa012 = l_tmp.qty           #数量
         LET l_sfaa.sfaa013 = l_tmp.xmdd004       #单位
         LET l_sfaa.sfaa020 = l_tmp.xmdd011       #预计完工日
         IF l_sfaa.sfaa020 IS NULL THEN
            LET l_sfaa.sfaa020 = cl_get_today()
         END IF
         
         IF NOT cl_null(l_sfaa.sfaa020) THEN
            #预计开工日
            CALL s_asft300_06('2',l_sfaa.sfaa010,l_sfaa.sfaa012,l_sfaa.sfaa020)
                 RETURNING l_success,l_sfaa.sfaa019
         END IF
         
         #161109-00085#37-s
         #INSERT INTO asfp301_tmp02 VALUES(l_sfaa.*)  #160727-00019#17 2016/08/10  By 08734    临时表长度超过15码的减少到15码以下 asfp301_03_temp_d1 ——> asfp301_tmp02         
         INSERT INTO asfp301_tmp02 (keyno,sfaa005,sfaa006,sfaa007,sfaa008,sfaa063,
                                    sfaa009,sfaa010,sfaa011,sfac006,sfaa012,
                                    sfaa013,sfaa019,sfaa020)
                             VALUES(l_sfaa.keyno,l_sfaa.sfaa005,l_sfaa.sfaa006,l_sfaa.sfaa007,l_sfaa.sfaa008,l_sfaa.sfaa063,
                                    l_sfaa.sfaa009,l_sfaa.sfaa010,l_sfaa.sfaa011,l_sfaa.sfac006,l_sfaa.sfaa012,
                                    l_sfaa.sfaa013,l_sfaa.sfaa019,l_sfaa.sfaa020)
         #161109-00085#37-e
         IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'insert asfp301_tmp02'  #160727-00019#17 2016/08/10  By 08734    临时表长度超过15码的减少到15码以下 asfp301_03_temp_d1 ——> asfp301_tmp02
            LET g_errparam.popup = TRUE
            CALL cl_err()

            RETURN r_success
         END IF           
      ELSE
         LET l_flag = 'Y'  #和原资料一样吗?
         LET l_sfaa_tmp.* = l_sfaa.*
         #订单单号
         IF l_sfaa.sfaa006 <> l_tmp.xmdddocno THEN
            LET l_sfaa.sfaa006 = ' '      #订单单号
            LET l_flag = 'N'            
         END IF
         LET l_sfaa.sfaa007 = ''       #项次
         LET l_sfaa.sfaa008 = ''       #项序
         LET l_sfaa.sfaa063 = ''       #分批序  
         
         #客户
         IF l_sfaa.sfaa009 <> l_tmp.xmda004 THEN
            LET l_sfaa.sfaa009 = ' '
            LET l_flag = 'N'
         END IF
         #特征
         IF l_sfaa.sfac006 <> l_tmp.xmdd002 THEN
            LET l_sfaa.sfac006 = ' '
            LET l_flag = 'N'
         END IF
         #预计完工日
         IF l_sfaa.sfaa020 < l_tmp.xmdd011 THEN
            LET l_sfaa.sfaa020 = l_tmp.xmdd011
            #预计开工日
            CALL s_asft300_06('2',l_sfaa.sfaa010,l_sfaa.sfaa012,l_sfaa.sfaa020)
                 RETURNING l_success,l_sfaa.sfaa019            
         END IF
         
--         IF l_flag = 'N' THEN
            LET l_sfaa.sfaa005 = '1'            #来源-1.Multi  
--         END IF
         #数量
         LET l_sfaa.sfaa012 = l_sfaa.sfaa012 + l_tmp.qty 
         UPDATE asfp301_tmp02 SET keyno   = l_sfaa.keyno   ,       #160727-00019#17 2016/08/10  By 08734    临时表长度超过15码的减少到15码以下 asfp301_03_temp_d1 ——> asfp301_tmp02
                                       sfaa005 = l_sfaa.sfaa005 ,      
                                       sfaa006 = l_sfaa.sfaa006 ,      
                                       sfaa007 = l_sfaa.sfaa007 ,      
                                       sfaa008 = l_sfaa.sfaa008 ,      
                                       sfaa063 = l_sfaa.sfaa063 ,      
                                       sfaa009 = l_sfaa.sfaa009 ,      
                                       sfaa010 = l_sfaa.sfaa010 ,      
                                       sfaa011 = l_sfaa.sfaa011 , #BOM特性 160214-00005#2-add
                                       sfac006 = l_sfaa.sfac006 ,      
                                       sfaa012 = l_sfaa.sfaa012 ,      
                                       sfaa013 = l_sfaa.sfaa013 ,      
                                       sfaa019 = l_sfaa.sfaa019 ,      
                                       sfaa020 = l_sfaa.sfaa020    
          WHERE keyno = l_sfaa_tmp.keyno                                       
#          WHERE sfaa006 = l_sfaa_tmp.sfaa006
#            AND sfaa009 = l_sfaa_tmp.sfaa009
#            AND sfaa010 = l_sfaa_tmp.sfaa010
#            AND sfaa013 = l_sfaa_tmp.sfaa013
#            AND sfaa020 = l_sfaa_tmp.sfaa020
#            AND sfac006 = l_sfaa_tmp.sfac006
         IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 OR SQLCA.sqlerrd[3] > 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'update asfp301_tmp02'  #160727-00019#17 2016/08/10  By 08734    临时表长度超过15码的减少到15码以下 asfp301_03_temp_d1 ——> asfp301_tmp02
            LET g_errparam.popup = TRUE
            CALL cl_err()

            RETURN r_success
         END IF
      
      END IF

      LET l_xmdd.keyno      = l_sfaa.keyno    
      LET l_xmdd.xmdddocno  = l_tmp.xmdddocno
      LET l_xmdd.xmddseq    = l_tmp.xmddseq  
      LET l_xmdd.xmddseq1   = l_tmp.xmddseq1 
      LET l_xmdd.xmddseq2   = l_tmp.xmddseq2 
      LET l_xmdd.xmda004    = l_tmp.xmda004  
      LET l_xmdd.xmdd001    = l_tmp.xmdd001  
      LET l_xmdd.xmdd040    = l_tmp.xmdd040  #BOM特性 160214-00005#2-add
      LET l_xmdd.xmdd002    = l_tmp.xmdd002      
      LET l_xmdd.xmdd004    = l_tmp.xmdd004  
      LET l_xmdd.qty        = l_tmp.qty      
      LET l_xmdd.xmdd011    = l_tmp.xmdd011 

      #取订单单位
      SELECT xmdd004 INTO l_xmdd004
        FROM xmdd_t
       WHERE xmddent   = g_enterprise
         AND xmdddocno = l_xmdd.xmdddocno
         AND xmddseq   = l_xmdd.xmddseq
         AND xmddseq1  = l_xmdd.xmddseq1
         AND xmddseq2  = l_xmdd.xmddseq2
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'sel xmdd_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF
       
      #订单数量
      LET l_xmdd.xmdd006 = l_xmdd.qty
      
      #订单单位与生产单位不一致时,数量转到订单单位
      #l_xmdd.xmdd004 为生产单位  l_xmdd004 为销售单位
      LET l_rate = 1
      IF l_xmdd.xmdd004 <> l_xmdd004 THEN
#         CALL s_aimi190_get_convert(l_xmdd.xmdd001,l_xmdd.xmdd004,l_xmdd004)
#              RETURNING l_success,l_rate
#         IF NOT l_success THEN
#            RETURN r_success
#         END IF
         CALL s_aooi250_convert_qty(l_xmdd.xmdd001,l_xmdd.xmdd004,l_xmdd004,l_xmdd.qty)
              RETURNING l_success,l_xmdd.xmdd006
         IF NOT l_success THEN
            RETURN r_success
         END IF
      END IF   
#      #订单数量
#      LET l_xmdd.xmdd006 = l_xmdd.qty * l_rate
      #161109-00085#37-s
      #INSERT INTO asfp301_tmp03 VALUES(l_xmdd.*)  #160727-00019#17 2016/08/10  By 08734    临时表长度超过15码的减少到15码以下 asfp301_03_temp_d2 ——> asfp301_tmp03
      INSERT INTO asfp301_tmp03(keyno,xmdddocno,xmddseq,xmddseq1,xmddseq2,
                                xmda004,xmdd001,xmdd040,xmdd002,xmdd006,
                                xmdd004,qty,xmdd011) 
                         VALUES(l_xmdd.keyno,l_xmdd.xmdddocno,l_xmdd.xmddseq,l_xmdd.xmddseq1,l_xmdd.xmddseq2,
                                l_xmdd.xmda004,l_xmdd.xmdd001,l_xmdd.xmdd040,l_xmdd.xmdd002,l_xmdd.xmdd006,
                                l_xmdd.xmdd004,l_xmdd.qty,l_xmdd.xmdd011)      
      #161109-00085#37-e    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'insert asfp301_tmp03'  #160727-00019#17 2016/08/10  By 08734    临时表长度超过15码的减少到15码以下 asfp301_03_temp_d2 ——> asfp301_tmp03
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF

   END FOREACH
   
   LET r_success = TRUE
   RETURN r_success
   
END FUNCTION

################################################################################
# Descriptions...: MOUSE拖动处理
# Memo...........:
# Usage..........: CALL asfp301_03_drag()
#                       RETURNING r_success
# Input parameter: NULL
# Return code....: r_success
# Date & Author..: 2014-07-11 By Carrier
# Modify.........:
################################################################################
PUBLIC FUNCTION asfp301_03_drag()
   DEFINE r_success      LIKE type_t.num5
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_sfaa         type_g_sfaa_d
   DEFINE l_cnt          LIKE type_t.num10   #170104-00066#1 num5->num10  17/01/05 mod by rainy 
   DEFINE l_sfaa_idx     LIKE type_t.num10   #170104-00066#1 num5->num10  17/01/05 mod by rainy 
   DEFINE l_i            LIKE type_t.num10   #170104-00066#1 num5->num10  17/01/05 mod by rainy 
   
   WHENEVER ERROR CONTINUE
   
   LET r_success = FALSE
   IF cl_null(drag_source) OR cl_null(drag_index) OR cl_null(drop_index) OR
      drag_index = 0 OR drop_index = 0 THEN
      RETURN r_success
   END IF 
   

   #工单合并
   IF drag_source = 's_detail1' THEN
      IF drop_index > g_rec_b THEN
         RETURN r_success      
      END IF
      
      IF g_sfaa_d[drag_index].sfaa010 <> g_sfaa_d[drop_index].sfaa010 THEN
         #料件编号不相同,不可合并!
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'asf-00367'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF
      
      #160214-00005#2-add-(S)
      #兩筆特性相比，若兩筆的特性都是NULL，就不用進去跑第二段IF的比對
      #             若兩筆的特性其中有一筆有資料，表示兩筆資料有可能不同，需比對看看
      IF NOT cl_null(g_sfaa_d[drag_index].sfaa011) OR NOT cl_null(g_sfaa_d[drop_index].sfaa011) THEN
         #多判斷cl_null，為避免NULL，IF判斷不到
         IF g_sfaa_d[drag_index].sfaa011 <> g_sfaa_d[drop_index].sfaa011 OR cl_null(g_sfaa_d[drag_index].sfaa011) 
                                                                         OR cl_null(g_sfaa_d[drop_index].sfaa011) THEN
            #BOM特性不相同，不可合併！
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'asf-00723'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN r_success
         END IF
      END IF
      #160214-00005#2-add-(E)
      
      #更新xmdd
      UPDATE asfp301_tmp03 SET keyno = g_sfaa_d[drop_index].keyno  #160727-00019#17 2016/08/10  By 08734    临时表长度超过15码的减少到15码以下 asfp301_03_temp_d2 ——> asfp301_tmp03
       WHERE keyno = g_sfaa_d[drag_index].keyno
      IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'update asfp301_tmp03'  #160727-00019#17 2016/08/10  By 08734    临时表长度超过15码的减少到15码以下 asfp301_03_temp_d2 ——> asfp301_tmp03
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF 
      
      #TO工单重置
      CALL asfp301_03_set_sfaa(g_sfaa_d[drop_index].keyno) RETURNING l_sfaa.*   
      CALL asfp301_03_upd_sfaa(l_sfaa.*)
           RETURNING l_success
      IF NOT l_success THEN
         RETURN r_success
      END IF
      
      #FROM工单DELETE
      DELETE FROM asfp301_tmp02 WHERE keyno = g_sfaa_d[drag_index].keyno  #160727-00019#17 2016/08/10  By 08734    临时表长度超过15码的减少到15码以下 asfp301_03_temp_d1 ——> asfp301_tmp02
      IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] <> 1 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'delete asfp301_tmp02'  #160727-00019#17 2016/08/10  By 08734    临时表长度超过15码的减少到15码以下 asfp301_03_temp_d1 ——> asfp301_tmp02
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF
      
      #ARRAY更新
      LET g_sfaa_d[drop_index].* = l_sfaa.*
      DISPLAY BY NAME g_sfaa_d[drop_index].*
      CALL asfp301_03_detail_show(1,drop_index)       
      LET g_master_idx = drop_index
      CALL asfp301_03_fetch()
      
      #FROM行在ARRAY中清除
      CALL g_sfaa_d.deleteElement(drag_index)
      LET g_rec_b = g_rec_b - 1
   ELSE
   #订单拖到此工单上
      #取FROM的sfaa的idx
      FOR l_i = 1 TO g_rec_b
          IF g_sfaa_d[l_i].keyno = g_xmdd_d[drag_index].keyno THEN
             LET l_sfaa_idx = l_i
             EXIT FOR
          END IF
      END FOR
      #订单资料拆分出来变成一笔新的工单
      IF drop_index > g_rec_b THEN
         #1.订单的KEYNO修改
         UPDATE asfp301_tmp03 SET keyno = 0   #160727-00019#17 2016/08/10  By 08734    临时表长度超过15码的减少到15码以下 asfp301_03_temp_d2 ——> asfp301_tmp03
          WHERE keyno     = g_xmdd_d[drag_index].keyno
            AND xmdddocno = g_xmdd_d[drag_index].xmdddocno
            AND xmddseq   = g_xmdd_d[drag_index].xmddseq
            AND xmddseq1  = g_xmdd_d[drag_index].xmddseq1
            AND xmddseq2  = g_xmdd_d[drag_index].xmddseq2
            
         IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] <> 1 THEN
            INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'update asfp301_tmp03'  #160727-00019#17 2016/08/10  By 08734    临时表长度超过15码的减少到15码以下 asfp301_03_temp_d2 ——> asfp301_tmp03
         LET g_errparam.popup = TRUE
         CALL cl_err()

            RETURN r_success
         END IF 

         #2.TO工单的重置
         CALL asfp301_03_set_sfaa(0) RETURNING l_sfaa.*
         CALL asfp301_03_ins_sfaa(l_sfaa.*)
              RETURNING l_success
         IF NOT l_success THEN
            RETURN r_success
         END IF 
         LET g_rec_b = g_rec_b + 1         
         LET g_sfaa_d[g_rec_b].* = l_sfaa.*
         DISPLAY BY NAME g_sfaa_d[g_rec_b].*
         CALL asfp301_03_detail_show(1,g_rec_b)          
         
         #3.将xmdd中keyno=0修改为最新的keyno
         UPDATE asfp301_tmp03 SET keyno = l_sfaa.keyno   #160727-00019#17 2016/08/10  By 08734    临时表长度超过15码的减少到15码以下 asfp301_03_temp_d2 ——> asfp301_tmp03
          WHERE keyno = 0
         IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] <> 1 THEN
            INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'update asfp301_tmp03'  #160727-00019#17 2016/08/10  By 08734    临时表长度超过15码的减少到15码以下 asfp301_03_temp_d2 ——> asfp301_tmp03
         LET g_errparam.popup = TRUE
         CALL cl_err()

            RETURN r_success
         END IF 

         #4.FROM工单的重置
         SELECT COUNT(*) INTO l_cnt FROM asfp301_tmp03  #160727-00019#17 2016/08/10  By 08734    临时表长度超过15码的减少到15码以下 asfp301_03_temp_d2 ——> asfp301_tmp03
          WHERE keyno = g_xmdd_d[drag_index].keyno
         IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
         IF l_cnt = 0 THEN
            DELETE FROM asfp301_tmp02 WHERE keyno = g_xmdd_d[drag_index].keyno  #160727-00019#17 2016/08/10  By 08734    临时表长度超过15码的减少到15码以下 asfp301_03_temp_d1 ——> asfp301_tmp02
            IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] <> 1 THEN
               INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'delete asfp301_tmp02'  #160727-00019#17 2016/08/10  By 08734    临时表长度超过15码的减少到15码以下 asfp301_03_temp_d1 ——> asfp301_tmp02
         LET g_errparam.popup = TRUE
         CALL cl_err()

               RETURN r_success
            END IF
            #FROM行在ARRAY中清除
            CALL g_sfaa_d.deleteElement(l_sfaa_idx)
            LET g_rec_b = g_rec_b - 1
         ELSE    
            CALL asfp301_03_set_sfaa(g_xmdd_d[drag_index].keyno) RETURNING l_sfaa.*
            CALL asfp301_03_upd_sfaa(l_sfaa.*)
                 RETURNING l_success
            IF NOT l_success THEN
               RETURN r_success
            END IF   
            LET g_sfaa_d[l_sfaa_idx].* = l_sfaa.*   
            DISPLAY BY NAME g_sfaa_d[l_sfaa_idx].*           
            CALL asfp301_03_detail_show(1,l_sfaa_idx)                
         END IF 
         
         #ARRAY更新     
         LET g_master_idx = g_rec_b
         CALL asfp301_03_fetch()         
         
      ELSE
      #订单资料从一笔工单移支另一笔工单上
         IF g_xmdd_d[drag_index].xmdd001 <> g_sfaa_d[drop_index].sfaa010 THEN
            #料件编号不相同,不可合并!
            INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'asf-00367'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

            RETURN r_success
         END IF

         #1.订单的KEYNO修改
         UPDATE asfp301_tmp03 SET keyno = g_sfaa_d[drop_index].keyno   #160727-00019#17 2016/08/10  By 08734    临时表长度超过15码的减少到15码以下 asfp301_03_temp_d2 ——> asfp301_tmp03
          WHERE keyno     = g_xmdd_d[drag_index].keyno
            AND xmdddocno = g_xmdd_d[drag_index].xmdddocno
            AND xmddseq   = g_xmdd_d[drag_index].xmddseq
            AND xmddseq1  = g_xmdd_d[drag_index].xmddseq1
            AND xmddseq2  = g_xmdd_d[drag_index].xmddseq2
         IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] <> 1 THEN
            INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'update asfp301_tmp03'  #160727-00019#17 2016/08/10  By 08734    临时表长度超过15码的减少到15码以下 asfp301_03_temp_d2 ——> asfp301_tmp03
         LET g_errparam.popup = TRUE
         CALL cl_err()

            RETURN r_success
         END IF

         #2.TO工单的重置
         CALL asfp301_03_set_sfaa(g_sfaa_d[drop_index].keyno) RETURNING l_sfaa.*
         CALL asfp301_03_upd_sfaa(l_sfaa.*)
              RETURNING l_success
         IF NOT l_success THEN
            RETURN r_success
         END IF
         LET g_sfaa_d[drop_index].* = l_sfaa.*
         DISPLAY BY NAME g_sfaa_d[drop_index].*
         CALL asfp301_03_detail_show(1,drop_index)           
         
         #3.FROM工单的重置
         SELECT COUNT(*) INTO l_cnt FROM asfp301_tmp03  #160727-00019#17 2016/08/10  By 08734    临时表长度超过15码的减少到15码以下 asfp301_03_temp_d2 ——> asfp301_tmp03
          WHERE keyno = g_xmdd_d[drag_index].keyno
         IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
         IF l_cnt = 0 THEN
            DELETE FROM asfp301_tmp02 WHERE keyno = g_xmdd_d[drag_index].keyno  #160727-00019#17 2016/08/10  By 08734    临时表长度超过15码的减少到15码以下 asfp301_03_temp_d1 ——> asfp301_tmp02
            IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] <> 1 THEN
               INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'delete asfp301_tmp02'  #160727-00019#17 2016/08/10  By 08734    临时表长度超过15码的减少到15码以下 asfp301_03_temp_d1 ——> asfp301_tmp02
         LET g_errparam.popup = TRUE
         CALL cl_err()

               RETURN r_success
            END IF
            #FROM行在ARRAY中清除
            CALL g_sfaa_d.deleteElement(l_sfaa_idx)
            LET g_rec_b = g_rec_b - 1
         ELSE    
            CALL asfp301_03_set_sfaa(g_xmdd_d[drag_index].keyno) RETURNING l_sfaa.*
            CALL asfp301_03_upd_sfaa(l_sfaa.*)
                 RETURNING l_success
            IF NOT l_success THEN
               RETURN r_success
            END IF   
            LET g_sfaa_d[l_sfaa_idx].* = l_sfaa.*  
            DISPLAY BY NAME g_sfaa_d[l_sfaa_idx].*            
            CALL asfp301_03_detail_show(1,l_sfaa_idx)              
         END IF  

         #ARRAY更新      
         LET g_master_idx = drop_index
         CALL asfp301_03_fetch()
      END IF
   END IF
    
   LET r_success = TRUE
   RETURN r_success
          
END FUNCTION

################################################################################
# Descriptions...: 按xmdd_t的资料重置sfaa_t
# Memo...........:
# Usage..........: CALL asfp301_03_set_sfaa(p_keyno)
#                       RETURNING l_sfaa
# Input parameter: p_keyno        KEYNO
# Return code....: l_sfaa         sfaa资料
# Date & Author..: 2014-07-11 By Carrier
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp301_03_set_sfaa(p_keyno)
   DEFINE p_keyno           LIKE type_t.num5
   DEFINE l_sfaa            type_g_sfaa_d
   DEFINE l_xmdd            type_xmdd
   DEFINE l_cnt             LIKE type_t.num10  #170104-00066#1 num5->num10  17/01/05 mod by rainy 
   DEFINE l_success         LIKE type_t.num5
   DEFINE l_cmd             LIKE type_t.chr1
   DEFINE l_i               LIKE type_t.num5
   
   WHENEVER ERROR CONTINUE
   
   INITIALIZE l_sfaa.* TO NULL
   
   IF cl_null(p_keyno) THEN
      RETURN l_sfaa.*
   END IF
   
   SELECT keyno  , sfaa005, sfaa006, sfaa007, sfaa008,
          sfaa063, sfaa009, ''     , sfaa010, sfaa011, ''     , '', #160214-00005#2-add-'sfaa011'
          sfac006, ''     , sfaa012, sfaa013, ''     , sfaa019,
          sfaa020
     INTO l_sfaa.* 
     FROM asfp301_tmp02  #160727-00019#17 2016/08/10  By 08734    临时表长度超过15码的减少到15码以下 asfp301_03_temp_d1 ——> asfp301_tmp02
    WHERE keyno = p_keyno
   IF SQLCA.sqlcode AND SQLCA.sqlcode <> 100 THEN
      RETURN l_sfaa.*
   ELSE
      IF SQLCA.sqlcode = 100 THEN
         LET l_cmd = 'a'
      ELSE
         LET l_cmd = 'u'
      END IF
   END IF
   
   SELECT COUNT(*) INTO l_cnt FROM asfp301_tmp03  #160727-00019#17 2016/08/10  By 08734    临时表长度超过15码的减少到15码以下 asfp301_03_temp_d2 ——> asfp301_tmp03
    WHERE keyno = p_keyno
    
   IF l_cnt = 1 THEN    
   SELECT * INTO l_xmdd.* FROM asfp301_tmp03  #160727-00019#17 2016/08/10  By 08734    临时表长度超过15码的减少到15码以下 asfp301_03_temp_d2 ——> asfp301_tmp03
    
        WHERE keyno = p_keyno
       IF l_cmd = 'a' THEN
          SELECT MAX(keyno) + 1 INTO l_i FROM asfp301_tmp02  #160727-00019#17 2016/08/10  By 08734    临时表长度超过15码的减少到15码以下 asfp301_03_temp_d1 ——> asfp301_tmp02
          IF cl_null(l_i) THEN LET l_i = 1 END IF
          LET l_sfaa.keyno   = l_i                 #项次     
       END IF
       LET l_sfaa.sfaa005 = '2'          
       LET l_sfaa.sfaa006 = l_xmdd.xmdddocno    
       IF l_sfaa.sfaa006 IS NULL THEN
          LET l_sfaa.sfaa006 = ' '
       END IF       
       LET l_sfaa.sfaa007 = l_xmdd.xmddseq
       LET l_sfaa.sfaa008 = l_xmdd.xmddseq1          
       LET l_sfaa.sfaa063 = l_xmdd.xmddseq2          
       LET l_sfaa.sfaa009 = l_xmdd.xmda004
       IF l_sfaa.sfaa009 IS NULL THEN
          LET l_sfaa.sfaa009 = ' '
       END IF
       LET l_sfaa.sfaa010 = l_xmdd.xmdd001       #料号
       LET l_sfaa.sfaa011 = l_xmdd.xmdd040       #BOM特性 #160214-00005#5-add
       LET l_sfaa.sfac006 = l_xmdd.xmdd002       #特征
       CALL s_feature_description(l_sfaa.sfaa010,l_sfaa.sfac006)
            RETURNING l_success,l_sfaa.sfac006_desc       
       IF l_sfaa.sfac006 IS NULL THEN
          LET l_sfaa.sfac006 = ' '
          LET l_sfaa.sfac006_desc = ''
       END IF
       LET l_sfaa.sfaa012 = l_xmdd.qty  
       LET l_sfaa.sfaa013 = l_xmdd.xmdd004       #单位
       
       LET l_sfaa.sfaa020 = l_xmdd.xmdd011  
       IF l_sfaa.sfaa020 IS NULL THEN
          LET l_sfaa.sfaa020 = cl_get_today()
       END IF
       CALL s_asft300_06('2',l_sfaa.sfaa010,l_sfaa.sfaa012,l_sfaa.sfaa020)
            RETURNING l_success,l_sfaa.sfaa019          
   ELSE
       LET l_sfaa.sfaa005 = '1'  
       SELECT UNIQUE xmdddocno INTO l_sfaa.sfaa006 FROM asfp301_tmp03 WHERE keyno = p_keyno  #160727-00019#17 2016/08/10  By 08734    临时表长度超过15码的减少到15码以下 asfp301_03_temp_d2 ——> asfp301_tmp03
       IF SQLCA.sqlcode THEN
          LET l_sfaa.sfaa006 = ' '
       END IF 
       LET l_sfaa.sfaa007 = ''    
       LET l_sfaa.sfaa008 = ''    
       LET l_sfaa.sfaa063 = ''    
       SELECT UNIQUE xmda004 INTO l_sfaa.sfaa009 FROM asfp301_tmp03 WHERE keyno = p_keyno  #160727-00019#17 2016/08/10  By 08734    临时表长度超过15码的减少到15码以下 asfp301_03_temp_d2 ——> asfp301_tmp03
       IF SQLCA.sqlcode THEN
          LET l_sfaa.sfaa009 = ' '
       END IF       
       SELECT UNIQUE xmdd002 INTO l_sfaa.sfac006 FROM asfp301_tmp03 WHERE keyno = p_keyno  #160727-00019#17 2016/08/10  By 08734    临时表长度超过15码的减少到15码以下 asfp301_03_temp_d2 ——> asfp301_tmp03
       IF SQLCA.sqlcode THEN
          LET l_sfaa.sfac006 = ' '
          LET l_sfaa.sfac006_desc = ''
       ELSE
          CALL s_feature_description(l_sfaa.sfaa010,l_sfaa.sfac006)
               RETURNING l_success,l_sfaa.sfac006_desc
       END IF 
       SELECT SUM(qty) INTO l_sfaa.sfaa012 FROM asfp301_tmp03 WHERE keyno = p_keyno  #160727-00019#17 2016/08/10  By 08734    临时表长度超过15码的减少到15码以下 asfp301_03_temp_d2 ——> asfp301_tmp03
       IF cl_null(l_sfaa.sfaa012) THEN       
          LET l_sfaa.sfaa012 = 0
       END IF
       SELECT MAX(xmdd011) INTO l_sfaa.sfaa020 FROM asfp301_tmp03 WHERE keyno = p_keyno  #160727-00019#17 2016/08/10  By 08734    临时表长度超过15码的减少到15码以下 asfp301_03_temp_d2 ——> asfp301_tmp03
       CALL s_asft300_06('2',l_sfaa.sfaa010,l_sfaa.sfaa012,l_sfaa.sfaa020)
            RETURNING l_success,l_sfaa.sfaa019      
   END IF
   
   RETURN l_sfaa.*
END FUNCTION

################################################################################
# Descriptions...: update sfaa
# Memo...........:
# Usage..........: CALL asfp301_03_upd_sfaa(p_sfaa)
#                       RETURNING r_success
# Input parameter: p_sfaa         sfaa资料
# Return code....: r_success      成功否标识符
# Date & Author..: 2014-07-11 By Carier
# Modify.........:
################################################################################
PUBLIC FUNCTION asfp301_03_upd_sfaa(p_sfaa)
   DEFINE p_sfaa           type_g_sfaa_d
   DEFINE r_success        LIKE type_t.num5

   LET r_success = FALSE
   
   UPDATE asfp301_tmp02 SET keyno   = p_sfaa.keyno   ,      #160727-00019#17 2016/08/10  By 08734    临时表长度超过15码的减少到15码以下 asfp301_03_temp_d1 ——> asfp301_tmp02 
                                 sfaa005 = p_sfaa.sfaa005 ,      
                                 sfaa006 = p_sfaa.sfaa006 ,      
                                 sfaa007 = p_sfaa.sfaa007 ,      
                                 sfaa008 = p_sfaa.sfaa008 ,      
                                 sfaa063 = p_sfaa.sfaa063 ,      
                                 sfaa009 = p_sfaa.sfaa009 ,      
                                 sfaa010 = p_sfaa.sfaa010 , 
                                 sfaa011 = p_sfaa.sfaa011 , #BOM特性 #160214-00005#2-add                                 
                                 sfac006 = p_sfaa.sfac006 ,      
                                 sfaa012 = p_sfaa.sfaa012 ,      
                                 sfaa013 = p_sfaa.sfaa013 ,      
                                 sfaa019 = p_sfaa.sfaa019 ,      
                                 sfaa020 = p_sfaa.sfaa020    
    WHERE keyno = p_sfaa.keyno   
   IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] <> 1 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'update asfp301_tmp02'  #160727-00019#17 2016/08/10  By 08734    临时表长度超过15码的减少到15码以下 asfp301_03_temp_d1 ——> asfp301_tmp02
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: insert sfaa
# Memo...........:
# Usage..........: CALL asfp301_03_ins_sfaa(p_sfaa)
#                       RETURNING r_success
# Input parameter: p_sfaa         sfaa资料
# Return code....: r_success      成功否标识符
# Date & Author..: 2014-07-11 By Carier
# Modify.........:
################################################################################
PUBLIC FUNCTION asfp301_03_ins_sfaa(p_sfaa)
   DEFINE p_sfaa           type_g_sfaa_d
   DEFINE r_success        LIKE type_t.num5

   LET r_success = FALSE
   
   INSERT INTO asfp301_tmp02  #160727-00019#17 2016/08/10  By 08734    临时表长度超过15码的减少到15码以下 asfp301_03_temp_d1 ——> asfp301_tmp02
          VALUES(p_sfaa.keyno   ,p_sfaa.sfaa005 ,p_sfaa.sfaa006 ,
                 p_sfaa.sfaa007 ,p_sfaa.sfaa008 ,p_sfaa.sfaa063 ,
                 p_sfaa.sfaa009 ,p_sfaa.sfaa010 ,p_sfaa.sfaa011 , #160214-00005#5-add-'sfaa011'
                 p_sfaa.sfac006 ,p_sfaa.sfaa012 ,p_sfaa.sfaa013 ,
                 p_sfaa.sfaa019 ,p_sfaa.sfaa020 )

   IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] <> 1 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'insert asfp301_tmp02'  #160727-00019#17 2016/08/10  By 08734    临时表长度超过15码的减少到15码以下 asfp301_03_temp_d1 ——> asfp301_tmp02
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

 
{</section>}
 
