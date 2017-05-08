#該程式未解開Section, 採用最新樣板產出!
{<section id="apmp490_04.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0012(2016-08-01 15:47:36), PR版次:0012(2016-12-26 15:57:05)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000178
#+ Filename...: apmp490_04
#+ Description: 引導式請購轉採購作業_結果檢視
#+ Creator....: 03079(2014-04-11 17:16:26)
#+ Modifier...: 02294 -SD/PR- 01534
 
{</section>}
 
{<section id="apmp490_04.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"
 #160318-00025#1   2016/04/05  by 07675       將重複內容的錯誤訊息置換為公用錯誤訊息
 #161102-00052#1   2016/11/10  By shiun       在結果檢視的功能"採購單維護"可查到多張採購
 #161207-00033#22  2016/12/21  By lixh     一次性交易對象顯示說明，所有的客戶/供應商欄位都應該處理
#end add-point
#add-point:填寫註解說明(客製用) name="main.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="main.import"
IMPORT util
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
#add-point:增加匯入變數檔 name="global.inc"
GLOBALS "../../apm/4gl/apmp490_04.inc"
#end add-point
 
{</section>}
 
{<section id="apmp490_04.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
 TYPE type_g_pmdl_d RECORD
                              keyno_04_01         LIKE type_t.num10,       #keyno 
                              result_04_01        LIKE type_t.chr1000,     #執行結果 
                              pmdldocno_04_01     LIKE pmdl_t.pmdldocno,   #採購單號  
                              pmdl004_04_01       LIKE pmdl_t.pmdl004,     #供應商   
                              pmaal004_04_01      LIKE pmaal_t.pmaal004,   #供應商名稱 
                              pmdl009_04_01       LIKE pmdl_t.pmdl009,     #付款條件  
                              pmdl010_04_01       LIKE pmdl_t.pmdl010,     #交易條件   
                              pmdl011_04_01       LIKE pmdl_t.pmdl011,     #稅別   
                              pmdl012_04_01       LIKE pmdl_t.pmdl012,     #稅率   
                              pmdl013_04_01       LIKE pmdl_t.pmdl013,     #含稅否   
                              pmdl015_04_01       LIKE pmdl_t.pmdl015,     #幣別   
                              pmdl016_04_01       LIKE pmdl_t.pmdl016,     #匯率   
                              pmdl017_04_01       LIKE pmdl_t.pmdl017      #取價方式  
                           END RECORD 
 TYPE type_g_pmdn_d RECORD
                              pmdnseq_04_02       LIKE pmdn_t.pmdnseq,     #項次   
                              pmdn001_04_02       LIKE pmdn_t.pmdn001,     #採購料件  
                              imaal003_04_02      LIKE imaal_t.imaal003,   #品名  
                              imaal004_04_02      LIKE imaal_t.imaal004,   #規格 
                              pmdn002_04_02       LIKE pmdn_t.pmdn002,     #採購產品特徵  
                              pmdn002_04_02_desc  LIKE type_t.chr80,       #產品特徵說明
                              pmdn006_04_02       LIKE pmdn_t.pmdn006,     #採購單位  
                              pmdn006_04_02_desc  LIKE type_t.chr80,       #單位說明 
                              pmdn007_04_02       LIKE pmdn_t.pmdn007,     #採購數量 
                              pmdn008_04_02       LIKE pmdn_t.pmdn008,     #參考單位 
                              pmdn008_04_02_desc  LIKE type_t.chr80,       #單位說明 
                              pmdn009_04_02       LIKE pmdn_t.pmdn009,     #參考數量 
                              pmdn010_04_02       LIKE pmdn_t.pmdn010,     #計價單位  
                              pmdn010_04_02_desc  LIKE type_t.chr80,       #單位說明 
                              pmdn011_04_02       LIKE pmdn_t.pmdn011,     #計價數量  
                              pmdn012_04_02       LIKE pmdn_t.pmdn012,     #交貨日期  
                              pmdn013_04_02       LIKE pmdn_t.pmdn013,     #到廠日期  
                              pmdn014_04_02       LIKE pmdn_t.pmdn014,     #到庫日期   
                              pmdn015_04_02       LIKE pmdn_t.pmdn015,     #單價  
                              pmdn050_04_02       LIKE pmdn_t.pmdn050      #備註
                           END RECORD
 TYPE type_g_pmdp_d RECORD
                              pmdpseq_04_03       LIKE pmdp_t.pmdpseq,     #項次 
                              pmdpseq1_04_03      LIKE pmdp_t.pmdpseq1,    #項序 
                              pmdp001_04_03       LIKE pmdp_t.pmdp001,     #料號 
                              pmdp003_04_03       LIKE pmdp_t.pmdp003,     #請購單號 
                              pmdp004_04_03       LIKE pmdp_t.pmdp004,     #請購項次 
                              pmdp007_04_03       LIKE pmdp_t.pmdp007,     #請購料號  
                              pmdp008_04_03       LIKE pmdp_t.pmdp008,     #請購產品特徵  
                              pmdp008_04_03_desc  LIKE type_t.chr80,       #產品特徵說明 
                              pmdp021_04_03       LIKE pmdp_t.pmdp021,     #沖銷順序 
                              pmdp022_04_03       LIKE pmdp_t.pmdp022,     #需求單位 
                              pmdp023_04_03       LIKE pmdp_t.pmdp023,     #需求數量   
                              pmdp024_04_03       LIKE pmdp_t.pmdp024      #折合採購量 
                           END RECORD 
 TYPE type_g_pmdo_d RECORD
                              pmdoseq_04_04       LIKE pmdo_t.pmdoseq,     #項次 
                              pmdoseq1_04_04      LIKE pmdo_t.pmdoseq1,    #項序 
                              pmdo001_04_04       LIKE pmdo_t.pmdo001,     #採購料號 
                              pmdo002_04_04       LIKE pmdo_t.pmdo002,     #採購產品特徵  
                              pmdo002_04_04_desc  LIKE type_t.chr80,       #產品特徵說明 
                              pmdo004_04_04       LIKE pmdo_t.pmdo004,     #採購單位  
                              pmdo005_04_04       LIKE pmdo_t.pmdo005,     #採購數量 
                              pmdoseq2_04_04      LIKE pmdo_t.pmdoseq2,    #分批序 
                              pmdo006_04_04       LIKE pmdo_t.pmdo006,     #分批採購數量 
                              pmdo011_04_04       LIKE pmdo_t.pmdo011,     #交貨日期 
                              pmdo012_04_04       LIKE pmdo_t.pmdo012,     #到廠日期 
                              pmdo013_04_04       LIKE pmdo_t.pmdo013      #到庫日期 
                           END RECORD
DEFINE g_pmdl_d            DYNAMIC ARRAY OF type_g_pmdl_d
DEFINE g_pmdn_d            DYNAMIC ARRAY OF type_g_pmdn_d
DEFINE g_pmdp_d            DYNAMIC ARRAY OF type_g_pmdp_d
DEFINE g_pmdo_d            DYNAMIC ARRAY OF type_g_pmdo_d
#end add-point
 
{</section>}
 
{<section id="apmp490_04.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="apmp490_04.other_dialog" >}

DIALOG apmp490_04_display01()
   DEFINE l_wc     STRING

   DISPLAY ARRAY g_pmdl_d TO s_apmp490_04_detail1.* ATTRIBUTE(COUNT=g_d_cnt_p49004_01)
      BEFORE DISPLAY
         CALL FGL_SET_ARR_CURR(g_d_idx_p49004_01)

      BEFORE ROW
         LET g_d_idx_p49004_01 = DIALOG.getCurrentRow("s_apmp490_04_detail1")
         LET g_appoint_idx = g_d_idx_p49004_01

         LET l_wc = "keyno = '",g_pmdl_d[g_d_idx_p49004_01].keyno_04_01,"' "
         CALL apmp490_04_b_fill_02(l_wc)
         CALL apmp490_04_b_fill_03(l_wc)
         CALL apmp490_04_b_fill_04(l_wc)


   END DISPLAY
END DIALOG

DIALOG apmp490_04_display02()
   DISPLAY ARRAY g_pmdn_d TO s_apmp490_04_detail2.* ATTRIBUTE(COUNT=g_d_cnt_p49004_02)
      BEFORE DISPLAY
         CALL FGL_SET_ARR_CURR(g_d_idx_p49004_02)

      BEFORE ROW
         LET g_d_idx_p49004_02 = DIALOG.getCurrentRow("s_apmp490_04_detail2")
         LET g_appoint_idx = g_d_idx_p49004_02
   END DISPLAY
END DIALOG

DIALOG apmp490_04_display03()
   DISPLAY ARRAY g_pmdp_d TO s_apmp490_04_detail3.* ATTRIBUTE(COUNT=g_d_cnt_p49004_03)
      BEFORE DISPLAY
         CALL FGL_SET_ARR_CURR(g_d_idx_p49004_03)

      BEFORE ROW
         LET g_d_idx_p49004_03 = DIALOG.getCurrentRow("s_apmp490_04_detail3")
         LET g_appoint_idx = g_d_idx_p49004_03
   END DISPLAY
END DIALOG

DIALOG apmp490_04_display04()
   DISPLAY ARRAY g_pmdo_d TO s_apmp490_04_detail4.* ATTRIBUTE(COUNT=g_d_cnt_p49004_04)
      BEFORE DISPLAY
         CALL FGL_SET_ARR_CURR(g_d_idx_p49004_04)

      BEFORE ROW
         LET g_d_idx_p49004_04 = DIALOG.getCurrentRow("s_apmp490_04_detail4")
         LET g_appoint_idx = g_d_idx_p49004_04
   END DISPLAY
END DIALOG

 
{</section>}
 
{<section id="apmp490_04.other_function" readonly="Y" >}

PUBLIC FUNCTION apmp490_04(--)
   #add-point:input段變數傳入

   #end add-point
   )

END FUNCTION

################################################################################
# Descriptions...: 建立temp table
# Memo...........:
# Usage..........: CALL apmp490_04_create_temp_table()
# Date & Author..: 2014/06/20 By ming
# Modify.........:
################################################################################
PUBLIC FUNCTION apmp490_04_create_temp_table()
   
   WHENEVER ERROR CONTINUE 
   
   CREATE TEMP TABLE p490_04_pmdl_t(
      keyno           INTEGER,            #temp table之間的關聯key  
      pmdldocno       VARCHAR(20),        #採購單號  
      pmdl004         VARCHAR(10),          #供應商  
      pmdl009         VARCHAR(10),          #付款條件  
      pmdl010         VARCHAR(10),          #交易條件  
      pmdl011         VARCHAR(10),          #稅別  
      pmdl012         DECIMAL(5,2),          #稅率  
      pmdl013         VARCHAR(1),          #含稅否  
      pmdl015         VARCHAR(10),          #幣別  
      pmdl016         DECIMAL(20,10),          #匯率  
      pmdl017         VARCHAR(10),          #取價方式  
      result          VARCHAR(1000)     #執行結果 
   ) 
   
   CREATE TEMP TABLE p490_04_pmdn_t(
      keyno           INTEGER,            #temp table之間的關聯key 
      pmdndocno       VARCHAR(20),        #採購單號  
      pmdnseq         INTEGER,          #項次   
      pmdn001         VARCHAR(40),          #採購料號  
      pmdn002         VARCHAR(256),          #採購產品特徵  
      pmdn006         VARCHAR(10),          #採購單位  
      pmdn007         DECIMAL(20,6),          #採購數量  
      pmdn008         VARCHAR(10),          #參考單位 
      pmdn009         DECIMAL(20,6),          #參考數量 
      pmdn010         VARCHAR(10),          #計價單位  
      pmdn011         DECIMAL(20,6),          #計價數量  
      pmdn012         DATE,          #交貨日期  
      pmdn013         DATE,          #到廠日期  
      pmdn014         DATE,          #到庫日期 
      pmdn015         DECIMAL(20,6),          #單價  
      pmdn050         VARCHAR(255)     #備註 
   ) 
   
   CREATE TEMP TABLE p490_04_pmdp_t(
      keyno           INTEGER,            #temp table之間的關聯key 
      pmdpdocno       VARCHAR(20),        #採購單號  
      pmdpseq         INTEGER,          #項次  
      pmdpseq1        INTEGER,         #項序  
      pmdp001         VARCHAR(40),          #料號  
      pmdp003         VARCHAR(20),          #請購單號  
      pmdp004         INTEGER,          #請購項次  
      pmdp007         VARCHAR(40),          #請購料號  
      pmdp008         VARCHAR(256),          #請購產品特徵  
      pmdp021         INTEGER,          #沖銷順序  
      pmdp022         VARCHAR(10),          #需求單位  
      pmdp023         DECIMAL(20,6),          #需求數量  
      pmdp024         DECIMAL(20,6)     #折合採購量  
   ) 
   
   CREATE TEMP TABLE p490_04_pmdo_t(
      keyno           INTEGER,            #temp table之間的關聯key 
      pmdodocno       VARCHAR(20),
      pmdoseq         INTEGER,
      pmdoseq1        INTEGER,
      pmdo001         VARCHAR(40),
      pmdo002         VARCHAR(256),
      pmdo004         VARCHAR(10),
      pmdo005         DECIMAL(20,6),
      pmdoseq2        INTEGER,   
      pmdo006         DECIMAL(20,6),    
      pmdo011         DATE,
      pmdo012         DATE,
      pmdo013         DATE
   )
END FUNCTION

################################################################################
# Descriptions...: 刪除temp table
# Memo...........:
# Usage..........: CALL apmp490_04_drop_temp_table()
# Date & Author..: 2014/06/20 By ming
# Modify.........:
################################################################################
PUBLIC FUNCTION apmp490_04_drop_temp_table()
   
   WHENEVER ERROR CONTINUE 
   
   DROP TABLE p490_04_pmdl_t;
   DROP TABLE p490_04_pmdn_t;
   DROP TABLE p490_04_pmdp_t;
   DROP TABLE p490_04_pmdo_t;
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apmp490_04_b_fill_01(p_wc)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2014/06/20 By ming
# Modify.........:
################################################################################
PUBLIC FUNCTION apmp490_04_b_fill_01(p_wc)
   DEFINE p_wc     STRING
   DEFINE l_sql    STRING
   DEFINE l_cnt    LIKE type_t.num5
   DEFINE l_wc     STRING 
   DEFINE l_pmdl028    LIKE pmdl_t.pmdl028  #161207-00033#22
   
   WHENEVER ERROR CONTINUE 

   CALL g_pmdl_d.clear()

   LET l_sql = "SELECT keyno,result,pmdldocno,pmdl004,'',pmdl009,pmdl010,pmdl011, ",
               "       pmdl012,pmdl013,pmdl015,pmdl016,pmdl017 ",
               "  FROM p490_04_pmdl_t ",
               " ORDER BY pmdldocno "
   PREPARE apmp490_04_get_pmdl_prep FROM l_sql
   DECLARE apmp490_04_get_pmdl_curs CURSOR FOR apmp490_04_get_pmdl_prep

   LET l_cnt = 1
   FOREACH apmp490_04_get_pmdl_curs INTO g_pmdl_d[l_cnt].*
      IF STATUS THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = STATUS
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      #161207-00033#22-S
      IF NOT cl_null(g_pmdl_d[l_cnt].pmdldocno_04_01) THEN
         SELECT pmdl028 INTO l_pmdl028 FROM pmdl_t 
          WHERE pmdlent = g_enterprise
            AND pmdldocno = g_pmdl_d[l_cnt].pmdldocno_04_01
         IF NOT cl_null(l_pmdl028) THEN
            CALL s_desc_get_oneturn_guest_desc(l_pmdl028) RETURNING g_pmdl_d[l_cnt].pmaal004_04_01
         END IF         
      ELSE   
      #161207-00033#22-S
         CALL apmp490_04_get_pmaal004(g_pmdl_d[l_cnt].pmdl004_04_01)
              RETURNING g_pmdl_d[l_cnt].pmaal004_04_01
      END IF  #161207-00033#22
      LET l_cnt = l_cnt + 1
   END FOREACH 
   
   CALL g_pmdl_d.deleteElement(l_cnt)
   LET l_cnt = l_cnt - 1

   IF l_cnt > 0 THEN
      LET l_wc = "keyno = '",g_pmdl_d[1].keyno_04_01,"' "
      CALL apmp490_04_b_fill_02(l_wc)
      CALL apmp490_04_b_fill_03(l_wc)
      CALL apmp490_04_b_fill_04(l_wc)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apmp490_04_b_fill_02(p_wc)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2014/06/20 By ming
# Modify.........:
################################################################################
PUBLIC FUNCTION apmp490_04_b_fill_02(p_wc)
   DEFINE p_wc      STRING
   DEFINE l_sql     STRING
   DEFINE l_cnt     LIKE type_t.num5 
   DEFINE l_success LIKE type_t.num5  
   
   WHENEVER ERROR CONTINUE 

   CALL g_pmdn_d.clear()

   LET l_sql = "SELECT pmdnseq,pmdn001,'','',pmdn002,'',pmdn006,'',pmdn007,",
               "       pmdn008,'',pmdn009,pmdn010,'',pmdn011,pmdn012,pmdn013,pmdn014,",
               "       pmdn015,pmdn050 ",
               "  FROM p490_04_pmdn_t ",
               " WHERE ",p_wc,
               " ORDER BY pmdnseq "
   PREPARE apmp490_04_get_pmdn_prep FROM l_sql
   DECLARE apmp490_04_get_pmdn_curs CURSOR FOR apmp490_04_get_pmdn_prep

   LET l_cnt = 1
   FOREACH apmp490_04_get_pmdn_curs INTO g_pmdn_d[l_cnt].*
      IF STATUS THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = STATUS
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      SELECT imaal003,imaal004 INTO g_pmdn_d[l_cnt].imaal003_04_02,
                                    g_pmdn_d[l_cnt].imaal004_04_02
        FROM imaal_t
       WHERE imaalent = g_enterprise
         AND imaal001 = g_pmdn_d[l_cnt].pmdn001_04_02
         AND imaal002 = g_dlang 
         
      #取得產品特徵說明 
      CALL s_feature_description(g_pmdn_d[l_cnt].pmdn001_04_02,g_pmdn_d[l_cnt].pmdn002_04_02)
           RETURNING l_success,g_pmdn_d[l_cnt].pmdn002_04_02_desc 
           
      CALL s_desc_get_unit_desc(g_pmdn_d[l_cnt].pmdn006_04_02)
           RETURNING g_pmdn_d[l_cnt].pmdn006_04_02_desc

      CALL s_desc_get_unit_desc(g_pmdn_d[l_cnt].pmdn008_04_02)
           RETURNING g_pmdn_d[l_cnt].pmdn008_04_02_desc

      CALL s_desc_get_unit_desc(g_pmdn_d[l_cnt].pmdn010_04_02)
           RETURNING g_pmdn_d[l_cnt].pmdn010_04_02_desc

      LET l_cnt = l_cnt + 1 
   END FOREACH

   CALL g_pmdn_d.deleteElement(l_cnt)
   LET l_cnt = l_cnt - 1
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apmp490_04_b_fill_03(p_wc)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2014/06/20 By ming
# Modify.........:
################################################################################
PUBLIC FUNCTION apmp490_04_b_fill_03(p_wc)
   DEFINE p_wc      STRING
   DEFINE l_sql     STRING
   DEFINE l_cnt     LIKE type_t.num5 
   DEFINE l_success LIKE type_t.num5  
   
   WHENEVER ERROR CONTINUE 

   CALL g_pmdp_d.clear()

   LET l_sql = "SELECT pmdpseq,pmdpseq1,pmdp001,pmdp003,pmdp004,pmdp007,'', ",
               "       pmdp008,pmdp021,pmdp022,pmdp023,pmdp024 ",
               "  FROM p490_04_pmdp_t ",
               " WHERE ",p_wc,
               " ORDER BY pmdpseq,pmdpseq1 "
   PREPARE apmp490_04_get_pmdp_prep FROM l_sql
   DECLARE apmp490_04_get_pmdp_curs CURSOR FOR apmp490_04_get_pmdp_prep

   LET l_cnt = 1
   FOREACH apmp490_04_get_pmdp_curs INTO g_pmdp_d[l_cnt].*
      IF STATUS THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = STATUS
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF 
      
      #取得產品特徵說明 
      CALL s_feature_description(g_pmdp_d[l_cnt].pmdp007_04_03,g_pmdp_d[l_cnt].pmdp008_04_03)
           RETURNING l_success,g_pmdp_d[l_cnt].pmdp008_04_03_desc

      LET l_cnt = l_cnt + 1
   END FOREACH

   CALL g_pmdp_d.deleteElement(l_cnt)
   LET l_cnt = l_cnt - 1
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apmp490_04_b_fill_04(p_wc)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2014/06/20 By ming
# Modify.........:
################################################################################
PUBLIC FUNCTION apmp490_04_b_fill_04(p_wc)
   DEFINE p_wc      STRING
   DEFINE l_sql     STRING
   DEFINE l_cnt     LIKE type_t.num5 
   DEFINE l_success LIKE type_t.num5  
   
   WHENEVER ERROR CONTINUE 

   CALL g_pmdo_d.clear()

   LET l_sql = "SELECT pmdoseq,pmdoseq1,pmdo001,pmdo002,'',pmdo004,pmdo005, ",
               "       pmdoseq2,pmdo006,pmdo011,pmdo012,pmdo013 ",
               "  FROM p490_04_pmdo_t ",
               " WHERE ",p_wc,
               " ORDER BY pmdoseq,pmdoseq1,pmdoseq2"
   PREPARE apmp490_04_get_pmdo_prep FROM l_sql
   DECLARE apmp490_04_get_pmdo_curs CURSOR FOR apmp490_04_get_pmdo_prep

   LET l_cnt = 1
   FOREACH apmp490_04_get_pmdo_curs INTO g_pmdo_d[l_cnt].*
      IF STATUS THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = STATUS
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      #取得產品特徵說明 
      CALL s_feature_description(g_pmdo_d[l_cnt].pmdo001_04_04,g_pmdo_d[l_cnt].pmdo002_04_04)
           RETURNING l_success,g_pmdo_d[l_cnt].pmdo002_04_04_desc

      LET l_cnt = l_cnt + 1
   END FOREACH

   CALL g_pmdo_d.deleteElement(l_cnt)
   LET l_cnt = l_cnt - 1
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apmp490_04_get_pmaal004(p_pmaal001)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2014/06/20 By ming
# Modify.........:
################################################################################
PUBLIC FUNCTION apmp490_04_get_pmaal004(p_pmaal001)
   DEFINE p_pmaal001     LIKE pmaal_t.pmaal001
   DEFINE r_pmaal004     LIKE pmaal_t.pmaal004 
   
   WHENEVER ERROR CONTINUE 

   LET r_pmaal004 = ''
   SELECT pmaal004 INTO r_pmaal004
     FROM pmaal_t
    WHERE pmaalent = g_enterprise
      AND pmaal001 = p_pmaal001
      AND pmaal002 = g_dlang
   
   RETURN r_pmaal004
END FUNCTION

################################################################################
# Descriptions...: 執行apmt500
# Memo...........:
# Usage..........: CALL apmp490_04_open_apmt500()
# Date & Author..: 2014/08/11 By ming
# Modify.........:
################################################################################
PUBLIC FUNCTION apmp490_04_open_apmt500()
   DEFINE la_param  RECORD
                       prog   STRING,
                       param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING 
   DEFINE l_where   STRING   #add--161102-00052#1 By shiun
   
   WHENEVER ERROR CONTINUE 

   DISPLAY g_pmdl_d[g_d_idx_p49004_01].pmdldocno_04_01     
   
   #add--161102-00052#1 By shiun--(S)
   CALL apmp490_04_output_apmt500() RETURNING l_where
   LET l_where = " AND pmdldocno IN ("||l_where||")"            
   #add--161102-00052#1 By shiun--(E)

   IF NOT cl_null(g_pmdl_d[g_d_idx_p49004_01].pmdldocno_04_01) THEN 
      LET la_param.prog = 'apmt500'
      #mod--161102-00052#1 By shiun--(S)
#      LET la_param.param[1] = g_pmdl_d[g_d_idx_p49004_01].pmdldocno_04_01 
      LET la_param.param[2] = l_where 
      #md--161102-00052#1 By shiun--(E)
      LET ls_js = util.JSON.stringify( la_param )

      CALL cl_cmdrun(ls_js)

   END IF
END FUNCTION

PUBLIC FUNCTION apmp490_04_init()
   
   WHENEVER ERROR CONTINUE 
   
   #如果不使用產品特徵的話 就設定隱藏 
   IF cl_get_para(g_enterprise,g_site,"S-BAS-0036") = 'N' THEN
      CALL cl_set_comp_visible("pmdn002_04_02,pmdn002_04_02_desc",FALSE)
      CALL cl_set_comp_visible("pmdp008_04_03,pmdp008_04_03_desc",FALSE)
      CALL cl_set_comp_visible("pmdo002_04_04,pmdo002_04_04_desc",FALSE) 
   END IF 
   
   #取得據點參數，若不使用參考單位時，則參考單位、數量需隱藏，不可維護 
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0028') = 'N' THEN 
      CALL cl_set_comp_visible('pmdn008_04_02,pmdn008_04_02_desc,pmdn009_04_02',FALSE) 
   END IF 
   
   #取得據點參數，若不使用計價單位時，則計價單位、數量需隱藏，不可維護 
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0019') = 'N' THEN 
      CALL cl_set_comp_visible('pmdn010_04_02,pmdn010_04_02_desc,pmdn011_04_02',FALSE) 
   END IF  
   
   CALL g_pmdl_d.clear()    
   CALL g_pmdn_d.clear()    
   CALL g_pmdp_d.clear()    
   CALL g_pmdo_d.clear() 
END FUNCTION

################################################################################
# Descriptions...: 組出可放入IN中的採購單號
# Memo...........:
# Usage..........: CALL apmp490_04_output_apmt500()
#                  RETURNING r_where
# Return code....: r_where：組好的單號
# Date & Author..: 2014/12/29 By ming
# Modify.........:
################################################################################
PUBLIC FUNCTION apmp490_04_output_apmt500()
   DEFINE l_i         LIKE type_t.num5
   DEFINE r_where     STRING 
   
   WHENEVER ERROR CONTINUE 

   LET r_where = ''
   FOR l_i = 1 TO g_pmdl_d.getLength() 
      IF cl_null(g_pmdl_d[l_i].pmdldocno_04_01) THEN 
         CONTINUE FOR 
      END IF 

      IF cl_null(r_where) THEN
         LET r_where = " '",g_pmdl_d[l_i].pmdldocno_04_01,"' "
      ELSE
         LET r_where = r_where CLIPPED ,",'",g_pmdl_d[l_i].pmdldocno_04_01,"' "
      END IF 
   END FOR

   RETURN r_where
END FUNCTION

 
{</section>}
 
