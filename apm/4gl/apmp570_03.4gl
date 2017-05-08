#該程式未解開Section, 採用最新樣板產出!
{<section id="apmp570_03.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0011(2014-11-27 11:10:03), PR版次:0011(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000097
#+ Filename...: apmp570_03
#+ Description: 引導式入庫處理作業-完成
#+ Creator....: 01588(2014-07-04 15:49:52)
#+ Modifier...: 01588 -SD/PR- 00000
 
{</section>}
 
{<section id="apmp570_03.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"
#+ Modifier...:   No.160318-00025#37  2016/04/19 BY pengxin  將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#             :      160606-00011#1   2016/06/13 By dorislai 多加一個action-入庫維護，開啟apmt570、apmt571、apmt573
#             :      160727-00019#12  1016/08/03 By 08734    临时表长度超过15码的减少到15码以下 apmp570_tmp_master ——> apmp570_tmp01,apmp570_02_temp_d1 ——> apmp570_tmp02,apmp570_02_temp_d2 ——> apmp570_tmp03,apmp570_02_temp_d3 ——> apmp570_tmp04,apmp570_02_temp_d5 ——> apmp570_tmp05
#             :      160729-00038#1   2016/08/05 By 02097    需自立AP否='Y'
#             :      160714-00010#1   2016/08/12 By dorislai 1.pmdt056,pmdt057,pmdt58,pmdt067,pmdt068,pmdt069沒給值，應全給0
#                                                            2.pmdt084需依採購性質(pmds011)給值，VMI給"N"，其餘為"Y"
#             :      160816-00001#7  2016/08/17 By 08742     抓取理由碼改CALL sub
#             :      160908-00031#1  2016/09/20 By 02097     apmp570 未根据采购性质赋值的栏位有：pmdt066
#             :      160706-00037#3  2016/10/24 By shiun     檢查來源單據的狀態碼(例如可拋轉的單據狀態碼應該是Y.已確認)，若為不可拋轉的資料提示"單據編號OOO單據狀態碼非Y.已確認不可拋轉"
#             :      161124-00048#8  2016/12/15 By zhujing   .*整批调整
#             :      161207-00033#21 2016/12/22  By lixh     一次性交易對象顯示說明，所有的客戶/供應商欄位都應該處理
#end add-point
#add-point:填寫註解說明(客製用) name="main.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="main.import"
IMPORT util #160606-00011#1-add
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
{</section>}
 
{<section id="apmp570_03.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
#單身 type 宣告
 TYPE type_g_pmds_d       RECORD
   keyno                  LIKE type_t.num5,
   pmdsdocno              LIKE pmds_t.pmdsdocno,
   pmds006                LIKE pmds_t.pmds006,
   pmds007                LIKE pmds_t.pmds007,
   pmds007_desc           LIKE pmaal_t.pmaal004,
   pmds031                LIKE pmds_t.pmds031,
   pmds031_desc           LIKE ooibl_t.ooibl004,
   pmds032                LIKE pmds_t.pmds032,
   pmds032_desc           LIKE oocql_t.oocql004,
   pmds033                LIKE pmds_t.pmds033,
   pmds033_desc           LIKE oodbl_t.oodbl004,
   pmds034                LIKE pmds_t.pmds034,
   pmds035                LIKE pmds_t.pmds035,
   pmds037                LIKE pmds_t.pmds037,
   pmds037_desc           LIKE ooail_t.ooail003,
   pmds038                LIKE pmds_t.pmds038,
   pmds039                LIKE pmds_t.pmds039,
   pmds039_desc           LIKE pmaml_t.pmaml003,
   result_str             LIKE type_t.chr500
                          END RECORD

 TYPE type_g_pmds2_d      RECORD
   pmdtseq                LIKE pmdt_t.pmdtseq,
   pmdt028                LIKE pmdt_t.pmdt028,
   pmdt001                LIKE pmdt_t.pmdt001,
   pmdt002                LIKE pmdt_t.pmdt002,
   pmdt003                LIKE pmdt_t.pmdt003,
   pmdt004                LIKE pmdt_t.pmdt004,
   pmdt081                LIKE pmdt_t.pmdt081,
   pmdt082                LIKE pmdt_t.pmdt082,
   pmdt083                LIKE pmdt_t.pmdt083,
   pmdt083_desc           LIKE qcaol_t.qcaol004,
   pmdt005                LIKE pmdt_t.pmdt005,
   pmdt006                LIKE pmdt_t.pmdt006,
   pmdt006_desc           LIKE imaal_t.imaal003,
   pmdt006_desc_desc      LIKE imaal_t.imaal004,
   pmdt007                LIKE pmdt_t.pmdt007,
   pmdt007_desc           LIKE type_t.chr500,
   pmdt009                LIKE pmdt_t.pmdt009,
   pmdt009_desc           LIKE oocql_t.oocql004,
   pmdt010                LIKE pmdt_t.pmdt010,
   pmdt019                LIKE pmdt_t.pmdt019,
   pmdt019_desc           LIKE oocal_t.oocal003,
   pmdt020                LIKE pmdt_t.pmdt020,
   pmdt021                LIKE pmdt_t.pmdt021,
   pmdt021_desc           LIKE oocal_t.oocal003,
   pmdt022                LIKE pmdt_t.pmdt022,
   pmdt023                LIKE pmdt_t.pmdt023,
   pmdt023_desc           LIKE oocal_t.oocal003,
   pmdt024                LIKE pmdt_t.pmdt024,
   pmdt062                LIKE pmdt_t.pmdt062,
   pmdt016                LIKE pmdt_t.pmdt016,
   pmdt016_desc           LIKE inayl_t.inayl003,
   pmdt017                LIKE pmdt_t.pmdt017,
   pmdt017_desc           LIKE inab_t.inab003,
   pmdt018                LIKE pmdt_t.pmdt018,
   pmdt063                LIKE pmdt_t.pmdt063,
   pmdt051                LIKE pmdt_t.pmdt051,
   pmdt051_desc           LIKE oocql_t.oocql004,
   pmdt059                LIKE pmdt_t.pmdt059
                          END RECORD

 TYPE type_g_pmds3_d      RECORD
   pmduseq                LIKE pmdu_t.pmduseq,
   pmduseq1               LIKE pmdu_t.pmduseq1,
   pmdu001                LIKE pmdu_t.pmdu001,
   pmdu001_desc           LIKE imaal_t.imaal003,
   pmdu001_desc_desc      LIKE imaal_t.imaal004,
   pmdu002                LIKE pmdu_t.pmdu002,
   pmdu002_desc           LIKE type_t.chr500,
   pmdu003                LIKE pmdu_t.pmdu003,
   pmdu003_desc           LIKE oocql_t.oocql004,
   pmdu004                LIKE pmdu_t.pmdu004,
   pmdu006                LIKE pmdu_t.pmdu006,
   pmdu006_desc           LIKE inaa_t.inaa002,
   pmdu007                LIKE pmdu_t.pmdu007,
   pmdu007_desc           LIKE inab_t.inab003,
   pmdu008                LIKE pmdu_t.pmdu008,
   pmdu005                LIKE pmdu_t.pmdu005,
   pmdu009                LIKE pmdu_t.pmdu009,
   pmdu009_desc           LIKE oocal_t.oocal003,
   pmdu010                LIKE pmdu_t.pmdu010,
   pmdu011                LIKE pmdu_t.pmdu011,
   pmdu011_desc           LIKE oocal_t.oocal003,
   pmdu012                LIKE pmdu_t.pmdu012,
   pmdu013                LIKE pmdu_t.pmdu013,
   pmdu014                LIKE pmdu_t.pmdu014,
   pmdu015                LIKE pmdu_t.pmdu015
                          END RECORD

 TYPE type_g_pmds5_d      RECORD
   pmdvseq                LIKE pmdv_t.pmdvseq,
   pmdv005                LIKE pmdv_t.pmdv005,
   pmdv001                LIKE pmdv_t.pmdv001,
   pmdv001_desc           LIKE imaal_t.imaal003,
   pmdv001_desc_desc      LIKE imaal_t.imaal004,
   pmdv002                LIKE pmdv_t.pmdv002,
   pmdv002_desc           LIKE type_t.chr500,
   pmdv003                LIKE pmdv_t.pmdv003,
   pmdv003_desc           LIKE oocql_t.oocql004,
   pmdv004                LIKE pmdv_t.pmdv004,
   pmdv014                LIKE pmdv_t.pmdv014,
   pmdv015                LIKE pmdv_t.pmdv015,
   pmdv016                LIKE pmdv_t.pmdv016,
   pmdv018                LIKE pmdv_t.pmdv018,
   pmdv018_desc           LIKE oocal_t.oocal003,
   pmdv019                LIKE pmdv_t.pmdv019
                          END RECORD
                          
DEFINE g_pmds_d           DYNAMIC ARRAY OF type_g_pmds_d
DEFINE g_pmds_d_t         type_g_pmds_d
DEFINE g_pmds2_d          DYNAMIC ARRAY OF type_g_pmds2_d
DEFINE g_pmds2_d_t        type_g_pmds2_d
DEFINE g_pmds3_d          DYNAMIC ARRAY OF type_g_pmds3_d
DEFINE g_pmds3_d_t        type_g_pmds3_d
DEFINE g_pmds5_d          DYNAMIC ARRAY OF type_g_pmds5_d
DEFINE g_pmds5_d_t        type_g_pmds5_d
 
DEFINE g_master_idx       LIKE type_t.num5
DEFINE l_ac               LIKE type_t.num5
DEFINE g_rec_b            LIKE type_t.num5
DEFINE g_rec_b2           LIKE type_t.num5
DEFINE g_rec_b3           LIKE type_t.num5
DEFINE g_rec_b4           LIKE type_t.num5
DEFINE g_rec_b5           LIKE type_t.num5

DEFINE g_master           RECORD 
         pmdsdocno        LIKE pmds_t.pmdsdocno,
         pmds002          LIKE pmds_t.pmds002,
         pmds011          LIKE pmds_t.pmds011
                          END RECORD
DEFINE g_result_str       LIKE type_t.chr500
#160606-00011#1-add-(S)
DEFINE g_pmdsdocno        STRING
DEFINE g_pmdsdocno_1      STRING
DEFINE g_pmdsdocno_2      STRING
#160606-00011#1-add-(E)
#end add-point
 
{</section>}
 
{<section id="apmp570_03.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="apmp570_03.other_dialog" >}

DIALOG apmp570_03_display()
   DISPLAY ARRAY g_pmds_d TO s_detail1_apmp570_03.* ATTRIBUTE(COUNT = g_rec_b)
      BEFORE DISPLAY
         CALL FGL_SET_ARR_CURR(l_ac)

      BEFORE ROW
        LET l_ac = DIALOG.getCurrentRow("s_detail1_apmp570_03")
        LET g_master_idx = l_ac
        CALL apmp570_03_fetch()
   END DISPLAY
END DIALOG

DIALOG apmp570_03_display2()
   DISPLAY ARRAY g_pmds2_d TO s_detail2_apmp570_03.* ATTRIBUTE(COUNT = g_rec_b2)
      BEFORE DISPLAY
         CALL FGL_SET_ARR_CURR(l_ac)

      BEFORE ROW
        LET l_ac = DIALOG.getCurrentRow("s_detail2_apmp570_03")

   END DISPLAY
END DIALOG

DIALOG apmp570_03_display3()
   DISPLAY ARRAY g_pmds3_d TO s_detail3_apmp570_03.* ATTRIBUTE(COUNT = g_rec_b3)
      BEFORE DISPLAY
         CALL FGL_SET_ARR_CURR(l_ac)

      BEFORE ROW
        LET l_ac = DIALOG.getCurrentRow("s_detail3_apmp570_03")

   END DISPLAY
END DIALOG

DIALOG apmp570_03_display5()
   DISPLAY ARRAY g_pmds5_d TO s_detail5_apmp570_03.* ATTRIBUTE(COUNT = g_rec_b5)
      BEFORE DISPLAY
         CALL FGL_SET_ARR_CURR(l_ac)

      BEFORE ROW
        LET l_ac = DIALOG.getCurrentRow("s_detail5_apmp570_03")

   END DISPLAY
END DIALOG

 
{</section>}
 
{<section id="apmp570_03.other_function" readonly="Y" >}

PUBLIC FUNCTION apmp570_03(--)
   #add-point:input段變數傳入

   #end add-point
   )
   
   #add-point:input段define
   #end add-point

END FUNCTION

PUBLIC FUNCTION apmp570_03_init()
   
   CALL cl_set_combo_scc('pmdt005_d2_03','2055')
   CALL cl_set_combo_scc('pmdv005_d5_03','2055')
   
   #判斷據點參數若不使用產品特徵時，則產品特徵需隱藏不可以維護(據點參數:S-BAS-0036)
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'N' THEN
      CALL cl_set_comp_visible("pmdt007_d2_03",FALSE)
   END IF
   
   #判斷據點參數若不使用參考單位時，則參考單位、數量需隱藏不可以維護(據點參數:S-BAS-0028)
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0028') = 'N' THEN
      CALL cl_set_comp_visible("pmdt021_d2_03,pmdt021_d2_03_desc,pmdt022_d2_03",FALSE)
      CALL cl_set_comp_visible("pmdu011_d3_03,pmdu011_d3_03_desc,pmdu012_d3_03",FALSE)
   END IF

   #整體參數未使用採購計價單位
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0019') = "N" THEN
      CALL cl_set_comp_visible("pmdt023_d2_03,pmdt023_d2_03_desc,pmdt024_d2_03",FALSE)
   END IF
END FUNCTION

PUBLIC FUNCTION apmp570_03_fetch()
DEFINE l_ac_t      LIKE type_t.num5
DEFINE l_sql       STRING
DEFINE l_success   LIKE type_t.num5
   

   CALL g_pmds2_d.clear()

   LET l_sql = "SELECT pmdtseq,pmdt028,pmdt001,pmdt002,pmdt003,pmdt004,pmdt081,pmdt082,pmdt083, ",
               "       pmdt005,pmdt006,a.imaal003,a.imaal004,pmdt007, ",
               "       pmdt009,b.oocql004,pmdt010,pmdt019,c.oocal003, ",
               "       pmdt020,pmdt021,d.oocal003,pmdt022,pmdt023, ",
               "       e.oocal003,pmdt024,pmdt062,pmdt016,f.inayl003, ",
               "       pmdt017,g.inab003,pmdt018,pmdt063,pmdt051,pmdt059 ",
               "  FROM apmp570_tmp03 ",  #160727-00019#12   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmp570_02_temp_d2 ——> apmp570_tmp03
               "       LEFT OUTER JOIN imaal_t a ON a.imaalent = ",g_enterprise," AND a.imaal001 = pmdt006 AND a.imaal002 = '",g_dlang,"'",
               "       LEFT OUTER JOIN oocql_t b ON b.oocqlent = ",g_enterprise," AND b.oocql001 = '221' AND b.oocql002 = pmdt009 AND b.oocql003 = '",g_dlang,"'",
               "       LEFT OUTER JOIN oocal_t c ON c.oocalent = ",g_enterprise," AND c.oocal001 = pmdt019 AND c.oocal002 = '",g_dlang,"'",
               "       LEFT OUTER JOIN oocal_t d ON d.oocalent = ",g_enterprise," AND d.oocal001 = pmdt021 AND d.oocal002 = '",g_dlang,"'",
               "       LEFT OUTER JOIN oocal_t e ON e.oocalent = ",g_enterprise," AND e.oocal001 = pmdt023 AND e.oocal002 = '",g_dlang,"'",
               "       LEFT OUTER JOIN inayl_t f ON f.inaylent = ",g_enterprise," AND f.inayl001 = pmdt016 AND f.inayl002 = '",g_dlang,"'",
               "       LEFT OUTER JOIN inab_t  g ON g.inabent  = ",g_enterprise," AND g.inabsite = '",g_site,"' AND g.inab001 = pmdt016 AND g.inab002 = pmdt017 ",
               " WHERE keyno = ",g_pmds_d[g_master_idx].keyno,
               " ORDER BY pmdtseq "

   PREPARE apmp570_03_temp_d2_sel FROM l_sql
   DECLARE apmp570_03_temp_d2_b_fill_curs CURSOR FOR apmp570_03_temp_d2_sel

   LET l_ac_t = l_ac
   LET l_ac = 1

   FOREACH apmp570_03_temp_d2_b_fill_curs INTO 
      g_pmds2_d[l_ac].pmdtseq,g_pmds2_d[l_ac].pmdt028,g_pmds2_d[l_ac].pmdt001,
      g_pmds2_d[l_ac].pmdt002,g_pmds2_d[l_ac].pmdt003,g_pmds2_d[l_ac].pmdt004,
      g_pmds2_d[l_ac].pmdt081,g_pmds2_d[l_ac].pmdt082,g_pmds2_d[l_ac].pmdt083,
      g_pmds2_d[l_ac].pmdt005,g_pmds2_d[l_ac].pmdt006,g_pmds2_d[l_ac].pmdt006_desc,
      g_pmds2_d[l_ac].pmdt006_desc_desc,g_pmds2_d[l_ac].pmdt007,g_pmds2_d[l_ac].pmdt009,
      g_pmds2_d[l_ac].pmdt009_desc,g_pmds2_d[l_ac].pmdt010,g_pmds2_d[l_ac].pmdt019,
      g_pmds2_d[l_ac].pmdt019_desc,g_pmds2_d[l_ac].pmdt020,g_pmds2_d[l_ac].pmdt021,
      g_pmds2_d[l_ac].pmdt021_desc,g_pmds2_d[l_ac].pmdt022,g_pmds2_d[l_ac].pmdt023,
      g_pmds2_d[l_ac].pmdt023_desc,g_pmds2_d[l_ac].pmdt024,g_pmds2_d[l_ac].pmdt062,
      g_pmds2_d[l_ac].pmdt016,g_pmds2_d[l_ac].pmdt016_desc,g_pmds2_d[l_ac].pmdt017,
      g_pmds2_d[l_ac].pmdt017_desc,g_pmds2_d[l_ac].pmdt018,g_pmds2_d[l_ac].pmdt063,
      g_pmds2_d[l_ac].pmdt051,g_pmds2_d[l_ac].pmdt059
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:apmp570_03_temp_d2_b_fill_curs"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      CALL apmp570_03_detail_show()

      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ""
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
   END FOREACH

   LET g_rec_b2 = l_ac - 1
   CALL g_pmds2_d.deleteElement(l_ac)
   LET l_ac = l_ac_t
   CLOSE apmp570_03_temp_d2_b_fill_curs
   FREE apmp570_03_temp_d2_sel

   CALL g_pmds3_d.clear()

   LET l_sql = "SELECT pmduseq,pmduseq1,pmdu001,a.imaal003,a.imaal004,pmdu002, ",
               "       pmdu003,b.oocql004,pmdu004,pmdu006,c.inayl003, ",
               "       pmdu007,d.inab003,pmdu008,pmdu005,pmdu009,e.oocal003,pmdu010, ",
               "       pmdu011,f.oocal003,pmdu012,pmdu013,pmdu014,pmdu015 ",
               "  FROM apmp570_tmp04 ",  #160727-00019#12   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmp570_02_temp_d3 ——> apmp570_tmp04
               "       LEFT OUTER JOIN imaal_t a ON a.imaalent = ",g_enterprise," AND a.imaal001 = pmdu001 AND a.imaal002 = '",g_dlang,"'",
               "       LEFT OUTER JOIN oocql_t b ON b.oocqlent = ",g_enterprise," AND b.oocql001 = '221' AND b.oocql002 = pmdu003 AND b.oocql003 = '",g_dlang,"'",
               "       LEFT OUTER JOIN inayl_t c ON c.inaylent = ",g_enterprise," AND c.inayl001 = pmdu006 AND c.inayl002 = '",g_dlang,"'",
               "       LEFT OUTER JOIN inab_t  d ON d.inabent  = ",g_enterprise," AND d.inabsite = '",g_site,"' AND d.inab001 = pmdu006 AND d.inab002 = pmdu007 ",
               "       LEFT OUTER JOIN oocal_t e ON e.oocalent = ",g_enterprise," AND e.oocal001 = pmdu009 AND e.oocal002 = '",g_dlang,"'",
               "       LEFT OUTER JOIN oocal_t f ON f.oocalent = ",g_enterprise," AND f.oocal001 = pmdu011 AND f.oocal002 = '",g_dlang,"'",
               " WHERE keyno = ",g_pmds_d[g_master_idx].keyno,
               " ORDER BY pmduseq,pmduseq1 "

   PREPARE apmp570_03_temp_d3_sel FROM l_sql
   DECLARE apmp570_03_temp_d3_b_fill_curs CURSOR FOR apmp570_03_temp_d3_sel

   LET l_ac_t = l_ac
   LET l_ac = 1

   FOREACH apmp570_03_temp_d3_b_fill_curs INTO 
      g_pmds3_d[l_ac].pmduseq,g_pmds3_d[l_ac].pmduseq1,g_pmds3_d[l_ac].pmdu001,
      g_pmds3_d[l_ac].pmdu001_desc,g_pmds3_d[l_ac].pmdu001_desc_desc,g_pmds3_d[l_ac].pmdu002,
      g_pmds3_d[l_ac].pmdu003,g_pmds3_d[l_ac].pmdu003_desc,g_pmds3_d[l_ac].pmdu004,
      g_pmds3_d[l_ac].pmdu006,g_pmds3_d[l_ac].pmdu006_desc,g_pmds3_d[l_ac].pmdu007,
      g_pmds3_d[l_ac].pmdu007_desc,g_pmds3_d[l_ac].pmdu008,g_pmds3_d[l_ac].pmdu005,
      g_pmds3_d[l_ac].pmdu009,g_pmds3_d[l_ac].pmdu009_desc,g_pmds3_d[l_ac].pmdu010,
      g_pmds3_d[l_ac].pmdu011,g_pmds3_d[l_ac].pmdu011_desc,g_pmds3_d[l_ac].pmdu012,
      g_pmds3_d[l_ac].pmdu013,g_pmds3_d[l_ac].pmdu014,g_pmds3_d[l_ac].pmdu015
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:apmp570_03_temp_d3_b_fill_curs"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      #產品特徵的說明
      CALL s_feature_description(g_pmds3_d[l_ac].pmdu001,g_pmds3_d[l_ac].pmdu002)
           RETURNING l_success,g_pmds3_d[l_ac].pmdu002_desc

      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ""
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
   END FOREACH

   LET g_rec_b3 = l_ac - 1
   CALL g_pmds3_d.deleteElement(l_ac)
   LET l_ac = l_ac_t
   CLOSE apmp570_03_temp_d3_b_fill_curs
   FREE apmp570_03_temp_d3_sel

   CALL g_pmds5_d.clear()

   LET l_sql = "SELECT pmdvseq,pmdv005,pmdv001,a.imaal003,a.imaal004,pmdv002, ",
               "       pmdv003,b.oocql004,pmdv004,pmdv014,pmdv015,pmdv016, ",
               "       pmdv018,c.oocal003,pmdv019 ",
               "  FROM apmp570_tmp05 ",  #160727-00019#12   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmp570_02_temp_d5 ——> apmp570_tmp05
               "       LEFT OUTER JOIN imaal_t a ON a.imaalent = ",g_enterprise," AND a.imaal001 = pmdv001 AND a.imaal002 = '",g_dlang,"'",
               "       LEFT OUTER JOIN oocql_t b ON b.oocqlent = ",g_enterprise," AND b.oocql001 = '221' AND b.oocql002 = pmdv003 AND b.oocql003 = '",g_dlang,"'",
               "       LEFT OUTER JOIN oocal_t c ON c.oocalent = ",g_enterprise," AND c.oocal001 = pmdv018 AND c.oocal002 = '",g_dlang,"'",
               " WHERE keyno = ",g_pmds_d[g_master_idx].keyno,
               " ORDER BY pmdvseq "

   PREPARE apmp570_03_temp_d5_sel FROM l_sql
   DECLARE apmp570_03_temp_d5_b_fill_curs CURSOR FOR apmp570_03_temp_d5_sel

   LET l_ac_t = l_ac
   LET l_ac = 1

   FOREACH apmp570_03_temp_d5_b_fill_curs INTO 
      g_pmds5_d[l_ac].pmdvseq,g_pmds5_d[l_ac].pmdv005,g_pmds5_d[l_ac].pmdv001,
      g_pmds5_d[l_ac].pmdv001_desc,g_pmds5_d[l_ac].pmdv001_desc_desc,g_pmds5_d[l_ac].pmdv002,
      g_pmds5_d[l_ac].pmdv003,g_pmds5_d[l_ac].pmdv003_desc,g_pmds5_d[l_ac].pmdv004,
      g_pmds5_d[l_ac].pmdv014,g_pmds5_d[l_ac].pmdv015,g_pmds5_d[l_ac].pmdv016,
      g_pmds5_d[l_ac].pmdv018,g_pmds5_d[l_ac].pmdv018_desc,g_pmds5_d[l_ac].pmdv019
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:apmp570_03_temp_d5_b_fill_curs"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      #產品特徵的說明
      CALL s_feature_description(g_pmds5_d[l_ac].pmdv001,g_pmds5_d[l_ac].pmdv002)
           RETURNING l_success,g_pmds5_d[l_ac].pmdv002_desc

      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ""
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
   END FOREACH

   LET g_rec_b5 = l_ac - 1
   CALL g_pmds5_d.deleteElement(l_ac)
   LET l_ac = l_ac_t
   CLOSE apmp570_03_temp_d5_b_fill_curs
   FREE apmp570_03_temp_d5_sel
END FUNCTION

PUBLIC FUNCTION apmp570_03_b_fill()
DEFINE l_sql            STRING
DEFINE l_ac_t           LIKE type_t.num5
DEFINE l_ooef019        LIKE ooef_t.ooef019
DEFINE l_pmds028        LIKE pmds_t.pmds028   #161207-00033#21 

   SELECT pmdsdocno,pmds002,pmds011
     INTO g_master.pmdsdocno,g_master.pmds002,g_master.pmds011
     FROM apmp570_tmp01   #160727-00019#12   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmp570_tmp_master ——> apmp570_tmp01

   LET l_ooef019 = ''
   SELECT ooef019 INTO l_ooef019 FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
   
   LET l_sql = "SELECT keyno,pmdsdocno,pmds006,pmds007,a.pmaal004,pmds031,b.ooibl004, ",
               "       pmds032,c.oocql004,pmds033,d.oodbl004,pmds034,pmds035, ",
               "       pmds037,e.ooail003,pmds038,pmds039,f.pmaml003,result_str,pmds028 ", ##161207-00033#21 add pmds028
               "  FROM apmp570_tmp02 ",  #160727-00019#12   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmp570_02_temp_d1 ——> apmp570_tmp02
               "       LEFT OUTER JOIN pmaal_t a ON a.pmaalent = ",g_enterprise," AND a.pmaal001 = pmds007 AND a.pmaal002 = '",g_dlang,"'",
               "       LEFT OUTER JOIN ooibl_t b ON b.ooiblent = ",g_enterprise," AND b.ooibl002 = pmds031 AND b.ooibl003 = '",g_dlang,"'",
               "       LEFT OUTER JOIN oocql_t c ON c.oocqlent = ",g_enterprise," AND c.oocql001 = '238' AND c.oocql002 = pmds032 AND c.oocql003 = '",g_dlang,"'",
               "       LEFT OUTER JOIN oodbl_t d ON d.oodblent = ",g_enterprise," AND d.oodbl001 = '",l_ooef019,"' AND d.oodbl002 = pmds033 AND d.oodbl003 = '",g_dlang,"'",
               "       LEFT OUTER JOIN ooail_t e ON e.ooailent = ",g_enterprise," AND e.ooail001 = pmds037 AND e.ooail002 = '",g_dlang,"'",
               "       LEFT OUTER JOIN pmaml_t f ON f.pmamlent = ",g_enterprise," AND f.pmaml001 = pmds039 AND f.pmaml002 = '",g_dlang,"'",
               " ORDER BY keyno "
   PREPARE apmp570_03_temp_d1_sel FROM l_sql
   DECLARE apmp570_03_temp_d1_b_fill_curs CURSOR FOR apmp570_03_temp_d1_sel
   
   CALL g_pmds_d.clear()
   IF cl_null(l_ac) OR l_ac = 0 THEN
      LET l_ac = 1
   END IF
   LET l_ac_t = l_ac
   LET l_ac = 1
   ERROR "Searching!"

   FOREACH apmp570_03_temp_d1_b_fill_curs INTO 
      g_pmds_d[l_ac].keyno,g_pmds_d[l_ac].pmdsdocno,g_pmds_d[l_ac].pmds006,g_pmds_d[l_ac].pmds007,
      g_pmds_d[l_ac].pmds007_desc,g_pmds_d[l_ac].pmds031,g_pmds_d[l_ac].pmds031_desc,g_pmds_d[l_ac].pmds032,
      g_pmds_d[l_ac].pmds032_desc,g_pmds_d[l_ac].pmds033,g_pmds_d[l_ac].pmds033_desc,g_pmds_d[l_ac].pmds034,
      g_pmds_d[l_ac].pmds035,g_pmds_d[l_ac].pmds037,g_pmds_d[l_ac].pmds037_desc,g_pmds_d[l_ac].pmds038,
      g_pmds_d[l_ac].pmds039,g_pmds_d[l_ac].pmds039_desc,g_pmds_d[l_ac].result_str,l_pmds028   #161207-00033#21 add pmds028
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:apmp570_03_temp_d1_b_fill_curs"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF 
      
      #161207-00033#21-S
      IF NOT cl_null(l_pmds028) THEN
         CALL s_desc_get_oneturn_guest_desc(l_pmds028) RETURNING g_pmds_d[l_ac].pmds007_desc
      END IF
      #161207-00033#21-E
      
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ""
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
   END FOREACH
   LET g_rec_b = l_ac - 1
   CALL g_pmds_d.deleteElement(l_ac)
   LET l_ac = l_ac_t
   CLOSE apmp570_03_temp_d1_b_fill_curs
   FREE apmp570_03_temp_d1_sel
   
   LET g_master_idx = l_ac
  
   CALL apmp570_03_fetch()

END FUNCTION

PRIVATE FUNCTION apmp570_03_detail_show()
DEFINE l_success         LIKE type_t.num5

   #產品特徵的說明
   CALL s_feature_description(g_pmds2_d[l_ac].pmdt006,g_pmds2_d[l_ac].pmdt007)
        RETURNING l_success,g_pmds2_d[l_ac].pmdt007_desc
        
   #判定結果的說明
   CALL s_desc_get_qc_desc(g_site,g_pmds2_d[l_ac].pmdt083)
        RETURNING g_pmds2_d[l_ac].pmdt083_desc
        
   #理由碼的說明
   CALL apmp570_03_pmdt051_desc()

END FUNCTION

################################################################################
# Descriptions...: 產生入庫單
# Memo...........:
# Usage..........: CALL apmp570_03_gen_data()
#                  
# Input parameter: 
# Return code....: 
# Date & Author..: 2014/10/06 By stellar
# Modify.........:
################################################################################
PUBLIC FUNCTION apmp570_03_gen_data()
#161124-00048#8 mod-S
#DEFINE l_pmds           RECORD LIKE pmds_t.*
DEFINE l_pmds RECORD  #收貨/入庫單頭檔
       pmdsent LIKE pmds_t.pmdsent, #企業編號
       pmdssite LIKE pmds_t.pmdssite, #營運據點
       pmdsdocno LIKE pmds_t.pmdsdocno, #單據單號
       pmdsdocdt LIKE pmds_t.pmdsdocdt, #單據日期
       pmds000 LIKE pmds_t.pmds000, #單據性質
       pmds001 LIKE pmds_t.pmds001, #扣帳日期
       pmds002 LIKE pmds_t.pmds002, #申請人員
       pmds003 LIKE pmds_t.pmds003, #申請部門
       pmds006 LIKE pmds_t.pmds006, #來源單號
       pmds007 LIKE pmds_t.pmds007, #採購供應商
       pmds008 LIKE pmds_t.pmds008, #帳款供應商
       pmds009 LIKE pmds_t.pmds009, #送貨供應商
       pmds010 LIKE pmds_t.pmds010, #供應商送貨單號
       pmds011 LIKE pmds_t.pmds011, #採購性質
       pmds012 LIKE pmds_t.pmds012, #採購通路
       pmds013 LIKE pmds_t.pmds013, #採購分類
       pmds014 LIKE pmds_t.pmds014, #多角性質
       pmds021 LIKE pmds_t.pmds021, #LC進口
       pmds022 LIKE pmds_t.pmds022, #進口日期
       pmds023 LIKE pmds_t.pmds023, #進口報單
       pmds024 LIKE pmds_t.pmds024, #進口號碼
       pmds028 LIKE pmds_t.pmds028, #一次性交易對象識別碼
       pmds031 LIKE pmds_t.pmds031, #付款條件
       pmds032 LIKE pmds_t.pmds032, #交易條件
       pmds033 LIKE pmds_t.pmds033, #稅別
       pmds034 LIKE pmds_t.pmds034, #稅率
       pmds035 LIKE pmds_t.pmds035, #單價含稅否
       pmds036 LIKE pmds_t.pmds036, #交易類型
       pmds037 LIKE pmds_t.pmds037, #幣別
       pmds038 LIKE pmds_t.pmds038, #匯率
       pmds039 LIKE pmds_t.pmds039, #取價方式
       pmds040 LIKE pmds_t.pmds040, #付款優惠條件
       pmds041 LIKE pmds_t.pmds041, #多角序號
       pmds042 LIKE pmds_t.pmds042, #整合單號
       pmds043 LIKE pmds_t.pmds043, #採購總未稅金額
       pmds044 LIKE pmds_t.pmds044, #採購總含稅金額
       pmds045 LIKE pmds_t.pmds045, #備註
       pmds046 LIKE pmds_t.pmds046, #採購總稅額
       pmds047 LIKE pmds_t.pmds047, #多角貿易中斷點
       pmds048 LIKE pmds_t.pmds048, #內外購
       pmds049 LIKE pmds_t.pmds049, #匯率計算基準
       pmds050 LIKE pmds_t.pmds050, #多角貿易已拋轉
       pmds051 LIKE pmds_t.pmds051, #出貨單號
       pmds052 LIKE pmds_t.pmds052, #供應商出貨日
       pmds053 LIKE pmds_t.pmds053, #多角流程編號
       pmds081 LIKE pmds_t.pmds081, #取回日期
       pmds100 LIKE pmds_t.pmds100, #倉退方式
       pmds101 LIKE pmds_t.pmds101, #折讓日期
       pmds102 LIKE pmds_t.pmds102, #折讓原始發票
       pmdsownid LIKE pmds_t.pmdsownid, #資料所屬者
       pmdsowndp LIKE pmds_t.pmdsowndp, #資料所有部門
       pmdscrtid LIKE pmds_t.pmdscrtid, #資料建立者
       pmdscrtdp LIKE pmds_t.pmdscrtdp, #資料建立部門
       pmdscrtdt LIKE pmds_t.pmdscrtdt, #資料創建日
       pmdsmodid LIKE pmds_t.pmdsmodid, #資料修改者
       pmdsmoddt LIKE pmds_t.pmdsmoddt, #最近修改日
       pmdscnfid LIKE pmds_t.pmdscnfid, #資料確認者
       pmdscnfdt LIKE pmds_t.pmdscnfdt, #資料確認日
       pmdspstid LIKE pmds_t.pmdspstid, #資料過帳者
       pmdspstdt LIKE pmds_t.pmdspstdt, #資料過帳日
       pmdsstus LIKE pmds_t.pmdsstus, #狀態碼
       pmds200 LIKE pmds_t.pmds200, #收貨預約單號
       pmds054 LIKE pmds_t.pmds054, #資料來源
       pmds055 LIKE pmds_t.pmds055, #來源單號
       pmds201 LIKE pmds_t.pmds201, #來源單號
       pmds202 LIKE pmds_t.pmds202, #來源類型
       pmdsunit LIKE pmds_t.pmdsunit, #應用執行組織物件
       pmds056 LIKE pmds_t.pmds056, #No use
       pmds057 LIKE pmds_t.pmds057, #整合來源
       pmds058 LIKE pmds_t.pmds058, #倒扣領料單號
       pmds103 LIKE pmds_t.pmds103  #折讓證明單開立方式
#       pmds025 LIKE pmds_t.pmds025  #保稅異動原因代碼
END RECORD
#161124-00048#8 mod-E
DEFINE l_ooag003        LIKE ooag_t.ooag003
DEFINE l_success        LIKE type_t.num5
DEFINE l_prog_t         LIKE type_t.chr20
DEFINE l_keyno          LIKE type_t.num5
DEFINE l_sql            STRING
DEFINE l_errno          LIKE gzze_t.gzze001
DEFINE l_xrcd113        LIKE xrcd_t.xrcd113
DEFINE l_xrcd114        LIKE xrcd_t.xrcd114
DEFINE l_xrcd115        LIKE xrcd_t.xrcd115
#160606-00011#1-add-(S)
DEFINE l_str            STRING
DEFINE l_str1           STRING
DEFINE l_str2           STRING
DEFINE l_msg            STRING
#160606-00011#1-add-(E)
DEFINE l_pmdsstus       LIKE pmds_t.pmdsstus   #add--160706-00037#3 By shiun
   
   #160606-00011#1-add-(S)   
   LET l_str = ''
   LET l_str1 = ''
   LET l_str2 = ''
   #160606-00011#1-add-(E)   
   
   SELECT pmdsdocno,pmds002,pmds011 
     INTO g_master.pmdsdocno,g_master.pmds002,g_master.pmds011
     FROM apmp570_tmp01  #160727-00019#12   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmp570_tmp_master ——> apmp570_tmp01
    
   #歸屬部門
   LET l_ooag003 = ''
   SELECT ooag003 INTO l_ooag003 FROM ooag_t
    WHERE ooagent = g_enterprise
      AND ooag001 = g_master.pmds002

   #上單身資料
   LET l_sql = "SELECT pmds006,pmds007,pmds031,pmds032,pmds033,pmds034,pmds035, ",
               "       pmds037,pmds038,pmds039,keyno ",
               "  FROM apmp570_tmp02 ",  #160727-00019#12   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmp570_02_temp_d1 ——> apmp570_tmp02
               " ORDER BY keyno "
   PREPARE apmp570_03_temp_d1_pre FROM l_sql
   DECLARE apmp570_03_temp_d1_curs CURSOR WITH HOLD FOR apmp570_03_temp_d1_pre
   
   #入庫明細 
   LET l_sql = "SELECT pmdtseq,pmdt028,pmdt001,pmdt002,pmdt003,pmdt004,pmdt081,pmdt082,pmdt083,pmdt005, ",
               "       pmdt006,pmdt007,pmdt009,pmdt010,pmdt019,pmdt020,pmdt021,pmdt022,pmdt023,pmdt024, ",
               "       pmdt062,pmdt016,pmdt017,pmdt018,pmdt063,pmdt051,pmdt059 ",
               "  FROM apmp570_tmp03 ",  #160727-00019#12   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmp570_02_temp_d2 ——> apmp570_tmp03
               " WHERE keyno = ? ",
               " ORDER BY pmdtseq "
   PREPARE apmp570_03_temp_d2_pre FROM l_sql
   DECLARE apmp570_03_temp_d2_curs CURSOR FOR apmp570_03_temp_d2_pre
   
   #多倉儲批明細
   LET l_sql = "SELECT pmduseq,pmduseq1,",
               "       pmdu001,pmdu002,pmdu003,pmdu004,pmdu005,",
               "       pmdu006,pmdu007,pmdu008,pmdu009,pmdu010,",
               "       pmdu011,pmdu012,pmdu013,pmdu014,pmdu015 ",
               "  FROM apmp570_tmp04 ",  #160727-00019#12   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmp570_02_temp_d3 ——> apmp570_tmp04
               " WHERE keyno = ? ",
               " ORDER BY pmduseq,pmduseq1 "
   PREPARE apmp570_03_temp_d3_pre FROM l_sql
   DECLARE apmp570_03_temp_d3_curs CURSOR FOR apmp570_03_temp_d3_pre
   
   #原始需求分配明細
   LET l_sql = "SELECT pmdvseq,pmdvseq1,",
               "       pmdv001,pmdv002,pmdv003,pmdv004,pmdv005,",
               "       pmdv006,",
               "       pmdv011,pmdv012,pmdv013,pmdv014,pmdv015,",
               "       pmdv016,pmdv018,pmdv019 ",
               "  FROM apmp570_tmp05 ",  #160727-00019#12   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmp570_02_temp_d5 ——> apmp570_tmp05
               " WHERE keyno = ? ",
               " ORDER BY pmdvseq "
   PREPARE apmp570_03_temp_d5_pre FROM l_sql
   DECLARE apmp570_03_temp_d5_curs CURSOR FOR apmp570_03_temp_d5_pre
   
   INITIALIZE l_pmds.* TO NULL
   FOREACH apmp570_03_temp_d1_curs INTO l_pmds.pmds006,l_pmds.pmds007,l_pmds.pmds031,l_pmds.pmds032,l_pmds.pmds033,
                                        l_pmds.pmds034,l_pmds.pmds035,l_pmds.pmds037,l_pmds.pmds038,l_pmds.pmds039,
                                        l_keyno
      #add--160706-00037#3 By shiun--(S)
      #檢查來源單據的狀態碼(例如可拋轉的單據狀態碼應該是Y.已確認)，若為不可拋轉的資料提示"單據編號OOO單據狀態碼非Y.已確認不可拋轉"
      SELECT pmdsstus INTO l_pmdsstus
        FROM pmds_t
       WHERE pmdsent   = g_enterprise
         AND pmdsdocno = l_pmds.pmds006
      IF l_pmdsstus <> 'Y' THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ''
         LET g_errparam.code   = 'apm-01119'
         LET g_errparam.popup  = TRUE
         LET g_errparam.replace[1] = l_pmds.pmds006
         CALL cl_err()
         CONTINUE FOREACH
      END IF
      #add--160706-00037#3 By shiun--(E)
      
      CALL s_transaction_begin()
      CALL cl_err_collect_init()
      LET l_success = TRUE
      LET g_result_str = ''   

      LET l_pmds.pmdsent   = g_enterprise
      LET l_pmds.pmdssite  = g_site
      LET l_pmds.pmdsdocno = g_master.pmdsdocno
      LET l_pmds.pmdsdocdt = g_today

      CASE g_master.pmds011
         WHEN '1'
              LET l_pmds.pmds000 = '6'   #入庫單
         WHEN '2'
              LET l_pmds.pmds000 = '12'  #委外收貨入庫單
         WHEN '10'
              LET l_pmds.pmds000 = '13'  #重覆性生產入庫
      END CASE
      
      LET l_pmds.pmds001 = g_today  #扣賬日期
      LET l_pmds.pmds002 = g_master.pmds002
      LET l_pmds.pmds003 = l_ooag003
      LET l_pmds.pmds011 = g_master.pmds011
      LET l_pmds.pmds047 = 'N'
      
      #從收貨單單頭帶值
      SELECT pmds008,pmds009,pmds010,pmds012,pmds013,
             pmds014,pmds021,pmds022,pmds023,pmds024,
             pmds028,pmds036,pmds040,pmds041,pmds042,
             pmds043,pmds044,pmds046,pmds048,pmds049,
             pmds100
        INTO l_pmds.pmds008,l_pmds.pmds009,l_pmds.pmds010,l_pmds.pmds012,l_pmds.pmds013,
             l_pmds.pmds014,l_pmds.pmds021,l_pmds.pmds022,l_pmds.pmds023,l_pmds.pmds024,
             l_pmds.pmds028,l_pmds.pmds036,l_pmds.pmds040,l_pmds.pmds041,l_pmds.pmds042,
             l_pmds.pmds043,l_pmds.pmds044,l_pmds.pmds046,l_pmds.pmds048,l_pmds.pmds049,
             l_pmds.pmds100
        FROM pmds_t
       WHERE pmdsent = g_enterprise
         AND pmdsdocno = l_pmds.pmds006
         
      LET l_pmds.pmdsownid = g_user
      LET l_pmds.pmdsowndp = g_dept
      LET l_pmds.pmdscrtid = g_user
      LET l_pmds.pmdscrtdp = g_dept
      LET l_pmds.pmdscrtdt = cl_get_current()
      LET l_pmds.pmdsstus = 'N'
       
      CALL apmp570_03_chk_headers(l_pmds.*)
           RETURNING l_success
      
      IF l_success THEN
         LET l_prog_t = g_prog
         CASE l_pmds.pmds011
            WHEN '1'
                 LET g_prog = 'apmt570'
            WHEN '2'
                 LET g_prog = 'apmt571'
            WHEN '10'
                 LET g_prog = 'apmt573'
         END CASE
         
         #自動編號
         CALL s_aooi200_gen_docno(g_site,l_pmds.pmdsdocno,l_pmds.pmdsdocdt,g_prog)
              RETURNING l_success,l_pmds.pmdsdocno
         IF NOT l_success THEN
            LET l_errno = 'apm-00003'
            IF NOT cl_null(g_result_str) THEN
               LET g_result_str = g_result_str,",",cl_getmsg(l_errno,g_lang)
            ELSE
               LET g_result_str = cl_getmsg(l_errno,g_lang)
            END IF
         END IF
         LET g_prog = l_prog_t
      END IF
      
      IF l_success THEN
         #新增入庫單單頭
         INSERT INTO pmds_t(pmdsent,pmdssite,pmdsdocno,pmdsdocdt,pmds000,
                            pmds001,pmds002,pmds003,
                            pmds006,pmds007,pmds008,pmds009,pmds010,
                            pmds011,pmds012,pmds013,pmds014,
                            pmds021,pmds022,pmds023,pmds024,
                            pmds028,
                            pmds031,pmds032,pmds033,pmds034,pmds035,
                            pmds036,pmds037,pmds038,pmds039,pmds040,
                            pmds041,pmds042,pmds043,pmds044,pmds045,
                            pmds046,pmds047,pmds048,pmds049,pmds050,
                            pmds051,
                            pmds081,
                            pmds100,pmds101,pmds102,
                            pmdsownid,pmdsowndp,pmdscrtid,pmdscrtdp,pmdscrtdt,
                            pmdsmodid,pmdsmoddt,pmdscnfid,pmdscnfdt,pmdspstid,
                            pmdspstdt,pmdsstus)
            VALUES(l_pmds.pmdsent,l_pmds.pmdssite,l_pmds.pmdsdocno,l_pmds.pmdsdocdt,l_pmds.pmds000,
                   l_pmds.pmds001,l_pmds.pmds002,l_pmds.pmds003,
                   l_pmds.pmds006,l_pmds.pmds007,l_pmds.pmds008,l_pmds.pmds009,l_pmds.pmds010,
                   l_pmds.pmds011,l_pmds.pmds012,l_pmds.pmds013,l_pmds.pmds014,
                   l_pmds.pmds021,l_pmds.pmds022,l_pmds.pmds023,l_pmds.pmds024,
                   l_pmds.pmds028,
                   l_pmds.pmds031,l_pmds.pmds032,l_pmds.pmds033,l_pmds.pmds034,l_pmds.pmds035,
                   l_pmds.pmds036,l_pmds.pmds037,l_pmds.pmds038,l_pmds.pmds039,l_pmds.pmds040,
                   l_pmds.pmds041,l_pmds.pmds042,l_pmds.pmds043,l_pmds.pmds044,l_pmds.pmds045,
                   l_pmds.pmds046,l_pmds.pmds047,l_pmds.pmds048,l_pmds.pmds049,l_pmds.pmds050,
                   l_pmds.pmds051,
                   l_pmds.pmds081,
                   l_pmds.pmds100,l_pmds.pmds101,l_pmds.pmds102,
                   l_pmds.pmdsownid,l_pmds.pmdsowndp,l_pmds.pmdscrtid,l_pmds.pmdscrtdp,l_pmds.pmdscrtdt,
                   l_pmds.pmdsmodid,l_pmds.pmdsmoddt,l_pmds.pmdscnfid,l_pmds.pmdscnfdt,l_pmds.pmdspstid,
                   l_pmds.pmdspstdt,l_pmds.pmdsstus)
         IF SQLCA.sqlcode THEN
             LET l_errno = SQLCA.sqlcode             
             IF NOT cl_null(g_result_str) THEN
                LET g_result_str = g_result_str,",","INSERT INTO pmds_t",cl_getmsg(l_errno,g_lang)
             ELSE
                LET g_result_str = "INSERT INTO pmds_t",cl_getmsg(l_errno,g_lang)
             END IF
             LET l_success = FALSE
         END IF
      END IF
      
      IF l_success THEN
         #入庫明細
         CALL apmp570_03_ins_pmdt(l_pmds.pmdsdocno,l_keyno)
              RETURNING l_success
      END IF
 
      IF l_success THEN
         #多庫儲批明細
         CALL apmp570_03_ins_pmdu(l_pmds.pmdsdocno,l_keyno)
              RETURNING l_success
      END IF
      
      IF l_success THEN
         #原始需求分配明細
         CALL apmp570_03_ins_pmdv(l_pmds.pmdsdocno,l_keyno)
              RETURNING l_success
      END IF
      
      IF l_success THEN
         #重新計算整單的未稅、含稅總金額
        CALL s_tax_recount_tmp()
        CALL s_tax_recount(l_pmds.pmdsdocno)
             RETURNING l_pmds.pmds043,l_pmds.pmds046,l_pmds.pmds044,l_xrcd113,l_xrcd114,l_xrcd115
        IF g_sub_success THEN
           UPDATE pmds_t SET pmds043 = l_pmds.pmds043,
                             pmds044 = l_pmds.pmds044,
                             pmds046 = l_pmds.pmds046
            WHERE pmdsent = l_pmds.pmdsent
              AND pmdsdocno = l_pmds.pmdsdocno
            IF SQLCA.sqlcode THEN
                LET l_errno = SQLCA.sqlcode             
                IF NOT cl_null(g_result_str) THEN
                   LET g_result_str = g_result_str,",","UPDATE pmds_t",cl_getmsg(l_errno,g_lang)
                ELSE
                   LET g_result_str = "INSERT INTO pmds_t",cl_getmsg(l_errno,g_lang)
                END IF
                LET l_success = FALSE
            END IF
         ELSE
            IF g_errcollect.getLength() > 0 THEN
               LET g_result_str = g_errcollect[g_errcollect.getLength()].message
            END IF
            LET l_success = FALSE
         END IF
      END IF
      
      IF l_success THEN
         CALL s_transaction_end('Y','0')
         LET g_result_str = cl_getmsg('apm-00538',g_lang)        #建立成功  
      ELSE         
         CALL s_transaction_end('N','0')
         #因為執行失敗 所以不給予單號 
         LET l_pmds.pmdsdocno = ''
      END IF
      
      #160606-00011#1-add-(S)
      IF l_success THEN
         CASE l_pmds.pmds011
            WHEN '1' #入庫單
               IF cl_null(l_str) THEN
                  LET l_str = l_pmds.pmdsdocno
               ELSE
                  LET l_str = l_str CLIPPED,"','",l_pmds.pmdsdocno
               END IF
            WHEN '2' #委外收貨入庫單
               IF cl_null(l_str1) THEN
                  LET l_str1 = l_pmds.pmdsdocno
               ELSE
                  LET l_str1 = l_str1 CLIPPED,"','",l_pmds.pmdsdocno
               END IF
            WHEN '3' #重複性生產入庫
               IF cl_null(l_str2) THEN
                  LET l_str2 = l_pmds.pmdsdocno
               ELSE
                  LET l_str2 = l_str2 CLIPPED,"','",l_pmds.pmdsdocno
               END IF
         END CASE
      END IF
      #160606-00011#1-add-(E)
      
      #寫入顯示結果是成功或錯誤訊息
      UPDATE apmp570_tmp02  #160727-00019#12   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmp570_02_temp_d1 ——> apmp570_tmp02
         SET pmdsdocno = l_pmds.pmdsdocno,
             result_str = g_result_str
       WHERE keyno = l_keyno

      INITIALIZE l_pmds.* TO NULL
      LET l_keyno = ''
      CALL cl_err_collect_init()
      CALL cl_err_collect_show()
      
   END FOREACH  
   #160606-00011#1-add-(S)
   LET g_pmdsdocno = l_str
   LET g_pmdsdocno_1 = l_str1
   LET g_pmdsdocno_2 = l_str2
   #160606-00011#1-add-(E)
END FUNCTION

################################################################################
# Descriptions...: 欄位值檢查
# Memo...........:
# Usage..........: CALL apmp570_03_chk_headers(p_pmds)
#                  RETURNING r_success
# Input parameter: p_pmds         入庫單單頭欄位ARRAY
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2014/10/07 By stellar
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp570_03_chk_headers(p_pmds)
#161124-00048#8 mod-S
#DEFINE p_pmds            RECORD LIKE pmds_t.*
DEFINE p_pmds RECORD  #收貨/入庫單頭檔
       pmdsent LIKE pmds_t.pmdsent, #企業編號
       pmdssite LIKE pmds_t.pmdssite, #營運據點
       pmdsdocno LIKE pmds_t.pmdsdocno, #單據單號
       pmdsdocdt LIKE pmds_t.pmdsdocdt, #單據日期
       pmds000 LIKE pmds_t.pmds000, #單據性質
       pmds001 LIKE pmds_t.pmds001, #扣帳日期
       pmds002 LIKE pmds_t.pmds002, #申請人員
       pmds003 LIKE pmds_t.pmds003, #申請部門
       pmds006 LIKE pmds_t.pmds006, #來源單號
       pmds007 LIKE pmds_t.pmds007, #採購供應商
       pmds008 LIKE pmds_t.pmds008, #帳款供應商
       pmds009 LIKE pmds_t.pmds009, #送貨供應商
       pmds010 LIKE pmds_t.pmds010, #供應商送貨單號
       pmds011 LIKE pmds_t.pmds011, #採購性質
       pmds012 LIKE pmds_t.pmds012, #採購通路
       pmds013 LIKE pmds_t.pmds013, #採購分類
       pmds014 LIKE pmds_t.pmds014, #多角性質
       pmds021 LIKE pmds_t.pmds021, #LC進口
       pmds022 LIKE pmds_t.pmds022, #進口日期
       pmds023 LIKE pmds_t.pmds023, #進口報單
       pmds024 LIKE pmds_t.pmds024, #進口號碼
       pmds028 LIKE pmds_t.pmds028, #一次性交易對象識別碼
       pmds031 LIKE pmds_t.pmds031, #付款條件
       pmds032 LIKE pmds_t.pmds032, #交易條件
       pmds033 LIKE pmds_t.pmds033, #稅別
       pmds034 LIKE pmds_t.pmds034, #稅率
       pmds035 LIKE pmds_t.pmds035, #單價含稅否
       pmds036 LIKE pmds_t.pmds036, #交易類型
       pmds037 LIKE pmds_t.pmds037, #幣別
       pmds038 LIKE pmds_t.pmds038, #匯率
       pmds039 LIKE pmds_t.pmds039, #取價方式
       pmds040 LIKE pmds_t.pmds040, #付款優惠條件
       pmds041 LIKE pmds_t.pmds041, #多角序號
       pmds042 LIKE pmds_t.pmds042, #整合單號
       pmds043 LIKE pmds_t.pmds043, #採購總未稅金額
       pmds044 LIKE pmds_t.pmds044, #採購總含稅金額
       pmds045 LIKE pmds_t.pmds045, #備註
       pmds046 LIKE pmds_t.pmds046, #採購總稅額
       pmds047 LIKE pmds_t.pmds047, #多角貿易中斷點
       pmds048 LIKE pmds_t.pmds048, #內外購
       pmds049 LIKE pmds_t.pmds049, #匯率計算基準
       pmds050 LIKE pmds_t.pmds050, #多角貿易已拋轉
       pmds051 LIKE pmds_t.pmds051, #出貨單號
       pmds052 LIKE pmds_t.pmds052, #供應商出貨日
       pmds053 LIKE pmds_t.pmds053, #多角流程編號
       pmds081 LIKE pmds_t.pmds081, #取回日期
       pmds100 LIKE pmds_t.pmds100, #倉退方式
       pmds101 LIKE pmds_t.pmds101, #折讓日期
       pmds102 LIKE pmds_t.pmds102, #折讓原始發票
       pmdsownid LIKE pmds_t.pmdsownid, #資料所屬者
       pmdsowndp LIKE pmds_t.pmdsowndp, #資料所有部門
       pmdscrtid LIKE pmds_t.pmdscrtid, #資料建立者
       pmdscrtdp LIKE pmds_t.pmdscrtdp, #資料建立部門
       pmdscrtdt LIKE pmds_t.pmdscrtdt, #資料創建日
       pmdsmodid LIKE pmds_t.pmdsmodid, #資料修改者
       pmdsmoddt LIKE pmds_t.pmdsmoddt, #最近修改日
       pmdscnfid LIKE pmds_t.pmdscnfid, #資料確認者
       pmdscnfdt LIKE pmds_t.pmdscnfdt, #資料確認日
       pmdspstid LIKE pmds_t.pmdspstid, #資料過帳者
       pmdspstdt LIKE pmds_t.pmdspstdt, #資料過帳日
       pmdsstus LIKE pmds_t.pmdsstus, #狀態碼
       pmds200 LIKE pmds_t.pmds200, #收貨預約單號
       pmds054 LIKE pmds_t.pmds054, #資料來源
       pmds055 LIKE pmds_t.pmds055, #來源單號
       pmds201 LIKE pmds_t.pmds201, #來源單號
       pmds202 LIKE pmds_t.pmds202, #來源類型
       pmdsunit LIKE pmds_t.pmdsunit, #應用執行組織物件
       pmds056 LIKE pmds_t.pmds056, #No use
       pmds057 LIKE pmds_t.pmds057, #整合來源
       pmds058 LIKE pmds_t.pmds058, #倒扣領料單號
       pmds103 LIKE pmds_t.pmds103  #折讓證明單開立方式
#       pmds025 LIKE pmds_t.pmds025  #保稅異動原因代碼
END RECORD
#161124-00048#8 mod-E
DEFINE r_success         LIKE type_t.num5
DEFINE l_success         LIKE type_t.num5
DEFINE l_flag            LIKE type_t.num5
DEFINE l_pmds033_desc    LIKE type_t.chr500
DEFINE l_pmds034         LIKE pmds_t.pmds034
DEFINE l_pmds035         LIKE pmds_t.pmds035
DEFINE l_oodb011         LIKE oodb_t.oodb011
   
   LET r_success = TRUE
   
   #pmds007
   INITIALIZE g_chkparam.* TO NULL
   LET g_chkparam.arg1 = p_pmds.pmds007
   IF NOT cl_chk_exist("v_pmaa001_1") THEN
      #採購供應商資料校驗失敗
      IF NOT cl_null(g_result_str) THEN
         LET g_result_str = g_result_str,",",cl_getmsg('apm-00545',g_dlang)
      ELSE
         LET g_result_str = cl_getmsg('apm-00545',g_dlang)
      END IF
      LET r_success = FALSE
   ELSE
      #檢核輸入的供應商是否在單據別限制範圍內，若不在限制內則不允許跟此供應商採購
      CALL s_control_chk_doc('2',p_pmds.pmdsdocno,p_pmds.pmds007,'','','','') RETURNING l_success,l_flag
      IF NOT l_success THEN      
         #控制組資料校驗過程式,處理狀態出現異常
         IF NOT cl_null(g_result_str) THEN
            LET g_result_str = g_result_str,",",cl_getmsg('apm-00546',g_dlang)
         ELSE
            LET g_result_str = cl_getmsg('apm-00546',g_dlang)
         END IF
         LET r_success = FALSE
      ELSE
         IF NOT l_flag THEN      #是否存在
            IF NOT cl_null(g_result_str) THEN
               LET g_result_str = g_result_str,",",cl_getmsg('apm-00239',g_dlang)
            ELSE
               LET g_result_str = cl_getmsg('apm-00239',g_dlang)
            END IF
            LET r_success = FALSE
         END IF
      END IF
   END IF
   
   #pmds008
   CALL s_apmm100_chk_pmac002('1','1',p_pmds.pmds007,p_pmds.pmds008)
        RETURNING r_success
   IF NOT r_success THEN
      #帳款供應商資料校驗失敗
      IF NOT cl_null(g_result_str) THEN
         LET g_result_str = g_result_str,",",cl_getmsg('apm-00547',g_dlang)
      ELSE
         LET g_result_str = cl_getmsg('apm-00547',g_dlang)
      END IF
   END IF
#   INITIALIZE g_chkparam.* TO NULL
#   LET g_chkparam.arg1 = p_pmds.pmds007
#   LET g_chkparam.arg2 = p_pmds.pmds008
#   LET g_chkparam.arg3 = g_site
#   IF NOT cl_chk_exist("v_pmac002") THEN
#      #帳款供應商資料校驗失敗
#      IF NOT cl_null(g_result_str) THEN
#         LET g_result_str = g_result_str,",",cl_getmsg('apm-00547',g_dlang)
#      ELSE
#         LET g_result_str = cl_getmsg('apm-00547',g_dlang)
#      END IF
#      LET r_success = FALSE
#   END IF

   #pmds009
   CALL s_apmm100_chk_pmac002('1','2',p_pmds.pmds007,p_pmds.pmds009)
        RETURNING r_success
   IF NOT r_success THEN
      #帳款供應商資料校驗失敗
      IF NOT cl_null(g_result_str) THEN
         LET g_result_str = g_result_str,",",cl_getmsg('apm-00548',g_dlang)
      ELSE
         LET g_result_str = cl_getmsg('apm-00548',g_dlang)
      END IF
   END IF
#   INITIALIZE g_chkparam.* TO NULL
#   LET g_chkparam.arg1 = p_pmds.pmds007
#   LET g_chkparam.arg2 = p_pmds.pmds009
#   LET g_chkparam.arg3 = g_site
#   IF NOT cl_chk_exist("v_pmac002") THEN
#      #送貨供應商資料校驗失敗
#      IF NOT cl_null(g_result_str) THEN
#         LET g_result_str = g_result_str,",",cl_getmsg('apm-00548',g_dlang)
#      ELSE
#         LET g_result_str = cl_getmsg('apm-00548',g_dlang)
#      END IF
#      LET r_success = FALSE
#   END IF
   
   #pmds033
   CALL s_tax_chk(g_site,p_pmds.pmds033)
        RETURNING l_success,l_pmds033_desc,l_pmds035,l_pmds034,l_oodb011
   IF NOT l_success THEN
      #稅別資料校驗失敗
      IF NOT cl_null(g_result_str) THEN
         LET g_result_str = g_result_str,",",cl_getmsg('apm-00549',g_dlang)
      ELSE
         LET g_result_str = cl_getmsg('apm-00549',g_dlang)
      END IF
      LET r_success = FALSE
   ELSE
      IF l_pmds034 != p_pmds.pmds034 THEN
         #稅率與現行系統中,與稅別對應的稅率值不相符
         IF NOT cl_null(g_result_str) THEN
            LET g_result_str = g_result_str,",",cl_getmsg('apm-00550',g_dlang)
         ELSE
            LET g_result_str = cl_getmsg('apm-00550',g_dlang)
         END IF
         LET r_success = FALSE
      END IF 
      
      IF l_pmds035 != p_pmds.pmds035 THEN
         #含稅否與現行系統中,與稅別對應的是否含稅的設定值不相符
         IF NOT cl_null(g_result_str) THEN
            LET g_result_str = g_result_str,",",cl_getmsg('apm-00551',g_dlang)
         ELSE
            LET g_result_str = cl_getmsg('apm-00551',g_dlang)
         END IF
         LET r_success = FALSE
      END IF 
   END IF

   #pmds037
   LET g_chkparam.arg1 = g_site
   LET g_chkparam.arg2 = p_pmds.pmds037
   
   #160318-00025#37  2016/04/19  by pengxin  add(S)
   LET g_errshow = TRUE #是否開窗 
   LET g_chkparam.err_str[1] = "aoo-00176:sub-01302|aooi150|",cl_get_progname("aooi150",g_lang,"2"),"|:EXEPROGaooi150"
   #160318-00025#37  2016/04/19  by pengxin  add(E)
   
   IF NOT cl_chk_exist("v_ooaj002") THEN
      #幣別資料校驗失敗
      IF NOT cl_null(g_result_str) THEN
         LET g_result_str = g_result_str,",",cl_getmsg('apm-00552',g_dlang)
      ELSE
         LET g_result_str = cl_getmsg('apm-00552',g_dlang)
      END IF
      LET r_success = FALSE
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 理由碼的說明
# Memo...........:
# Usage..........: CALL apmp570_03_pmdt051_desc()
#                  
# Date & Author..: 2014/10/07 By stellar
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp570_03_pmdt051_desc()
DEFINE l_gzcb004         LIKE gzcb_t.gzcb004

   #理由碼
   LET l_gzcb004 = ''
   CASE g_master.pmds011
      WHEN '1'
           #SELECT gzcb004 INTO l_gzcb004 FROM gzcb_t  WHERE gzcb001 = '24'  AND gzcb002 = 'apmt570'  #160816-00001#7 mark
           LET l_gzcb004 = s_fin_get_scc_value('24','apmt570','2')  #160816-00001#7  Add
      WHEN '2'
           #SELECT gzcb004 INTO l_gzcb004 FROM gzcb_t  WHERE gzcb001 = '24'  AND gzcb002 = 'apmt571'  #160816-00001#7 mark
           LET l_gzcb004 = s_fin_get_scc_value('24','apmt571','2')  #160816-00001#7  Add
      WHEN '10'
           #SELECT gzcb004 INTO l_gzcb004 FROM gzcb_t  WHERE gzcb001 = '24'  AND gzcb002 = 'apmt573'  #160816-00001#7 mark
           LET l_gzcb004 = s_fin_get_scc_value('24','apmt573','2')  #160816-00001#7  Add
   END CASE
   
   CALL s_desc_get_acc_desc(l_gzcb004,g_pmds2_d[l_ac].pmdt051)
        RETURNING g_pmds2_d[l_ac].pmdt051_desc
   
   DISPLAY g_pmds2_d[l_ac].pmdt051_desc TO pmdt051_d2_03
   
END FUNCTION

################################################################################
# Descriptions...: 新增入庫明細檔
# Memo...........:
# Usage..........: CALL apmp570_03_ins_pmdt(p_pmdtdocno,p_keyno)
#                  RETURNING r_success
# Input parameter: p_pmdtdocno    入庫單號
#                : p_keyno        底稿key
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2014/10/08 By stellar
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp570_03_ins_pmdt(p_pmdtdocno,p_keyno)
DEFINE p_pmdtdocno       LIKE pmdt_t.pmdtdocno
DEFINE p_keyno           LIKE type_t.num5
DEFINE r_success         LIKE type_t.num5
#161124-00048#8 mod-S
#DEFINE l_pmdt            RECORD LIKE pmdt_t.*
DEFINE l_pmdt RECORD  #收貨/入庫單身明細檔
       pmdtent LIKE pmdt_t.pmdtent, #企业编号
       pmdtsite LIKE pmdt_t.pmdtsite, #营运据点
       pmdtdocno LIKE pmdt_t.pmdtdocno, #单据编号
       pmdtseq LIKE pmdt_t.pmdtseq, #项次
       pmdt001 LIKE pmdt_t.pmdt001, #采购单号
       pmdt002 LIKE pmdt_t.pmdt002, #采购项次
       pmdt003 LIKE pmdt_t.pmdt003, #采购项序
       pmdt004 LIKE pmdt_t.pmdt004, #采购分批序
       pmdt005 LIKE pmdt_t.pmdt005, #子件特性
       pmdt006 LIKE pmdt_t.pmdt006, #料件编号
       pmdt007 LIKE pmdt_t.pmdt007, #产品特征
       pmdt008 LIKE pmdt_t.pmdt008, #包装容器
       pmdt009 LIKE pmdt_t.pmdt009, #作业编号
       pmdt010 LIKE pmdt_t.pmdt010, #作业序
       pmdt011 LIKE pmdt_t.pmdt011, #冲销顺序
       pmdt016 LIKE pmdt_t.pmdt016, #库位
       pmdt017 LIKE pmdt_t.pmdt017, #储位
       pmdt018 LIKE pmdt_t.pmdt018, #批号
       pmdt019 LIKE pmdt_t.pmdt019, #收货/入库单位
       pmdt020 LIKE pmdt_t.pmdt020, #收货/入库数量
       pmdt021 LIKE pmdt_t.pmdt021, #参考单位
       pmdt022 LIKE pmdt_t.pmdt022, #参考数量
       pmdt023 LIKE pmdt_t.pmdt023, #计价单位
       pmdt024 LIKE pmdt_t.pmdt024, #计价数量
       pmdt025 LIKE pmdt_t.pmdt025, #紧急度
       pmdt026 LIKE pmdt_t.pmdt026, #检验否
       pmdt027 LIKE pmdt_t.pmdt027, #收货单号
       pmdt028 LIKE pmdt_t.pmdt028, #收货项次
       pmdt036 LIKE pmdt_t.pmdt036, #单价
       pmdt037 LIKE pmdt_t.pmdt037, #税率
       pmdt038 LIKE pmdt_t.pmdt038, #税前金额
       pmdt039 LIKE pmdt_t.pmdt039, #含税金额
       pmdt040 LIKE pmdt_t.pmdt040, #价格核决
       pmdt041 LIKE pmdt_t.pmdt041, #保税否
       pmdt042 LIKE pmdt_t.pmdt042, #取价来源
       pmdt043 LIKE pmdt_t.pmdt043, #价格参考单号
       pmdt044 LIKE pmdt_t.pmdt044, #取出单价
       pmdt045 LIKE pmdt_t.pmdt045, #价差比
       pmdt046 LIKE pmdt_t.pmdt046, #税种
       pmdt047 LIKE pmdt_t.pmdt047, #税额
       pmdt051 LIKE pmdt_t.pmdt051, #理由码
       pmdt052 LIKE pmdt_t.pmdt052, #状态码
       pmdt053 LIKE pmdt_t.pmdt053, #允收数量
       pmdt054 LIKE pmdt_t.pmdt054, #已入库量
       pmdt055 LIKE pmdt_t.pmdt055, #验退量
       pmdt056 LIKE pmdt_t.pmdt056, #主账套已请款数量
       pmdt057 LIKE pmdt_t.pmdt057, #账套二已请款数量
       pmdt058 LIKE pmdt_t.pmdt058, #账套三已请款数量
       pmdt059 LIKE pmdt_t.pmdt059, #备注
       pmdt060 LIKE pmdt_t.pmdt060, #供应商批号
       pmdt061 LIKE pmdt_t.pmdt061, #供应商送货数量
       pmdt062 LIKE pmdt_t.pmdt062, #多库储批收货入库
       pmdt063 LIKE pmdt_t.pmdt063, #库存管理特征
       pmdt064 LIKE pmdt_t.pmdt064, #出货单号
       pmdt065 LIKE pmdt_t.pmdt065, #出货单项次
       pmdt066 LIKE pmdt_t.pmdt066, #主账套暂估数量
       pmdt067 LIKE pmdt_t.pmdt067, #账套二暂估数量
       pmdt068 LIKE pmdt_t.pmdt068, #账套三暂估数量
       pmdt069 LIKE pmdt_t.pmdt069, #已开发票数量
       pmdt081 LIKE pmdt_t.pmdt081, #QC单号
       pmdt082 LIKE pmdt_t.pmdt082, #QC判定项次
       pmdt083 LIKE pmdt_t.pmdt083, #判定结果
       pmdt084 LIKE pmdt_t.pmdt084, #须自立AP否
       pmdt085 LIKE pmdt_t.pmdt085, #多角流程编号
       pmdt086 LIKE pmdt_t.pmdt086, #采购多角性质
       pmdt087 LIKE pmdt_t.pmdt087, #采购单开立据点
       pmdt088 LIKE pmdt_t.pmdt088, #存货备注
       pmdt089 LIKE pmdt_t.pmdt089, #有效日期
       pmdt900 LIKE pmdt_t.pmdt900, #保留字段str
       pmdt999 LIKE pmdt_t.pmdt999, #保留字段end
       pmdt200 LIKE pmdt_t.pmdt200, #商品条码
       pmdt201 LIKE pmdt_t.pmdt201, #收货包装单位
       pmdt202 LIKE pmdt_t.pmdt202, #收货包装数量
       pmdt203 LIKE pmdt_t.pmdt203, #采购组织
       pmdt204 LIKE pmdt_t.pmdt204, #采购中心
       pmdt205 LIKE pmdt_t.pmdt205, #要货组织
       pmdt206 LIKE pmdt_t.pmdt206, #预约收货单号
       pmdt207 LIKE pmdt_t.pmdt207, #预约收货项次
       pmdt208 LIKE pmdt_t.pmdt208, #采购渠道
       pmdt209 LIKE pmdt_t.pmdt209, #渠道性质
       pmdt210 LIKE pmdt_t.pmdt210, #经营方式
       pmdt211 LIKE pmdt_t.pmdt211, #结算方式
       pmdt212 LIKE pmdt_t.pmdt212, #合同编号
       pmdt213 LIKE pmdt_t.pmdt213, #协议编号
       pmdtorga LIKE pmdt_t.pmdtorga, #账务组织
       pmdt070 LIKE pmdt_t.pmdt070, #参考单号
       pmdt071 LIKE pmdt_t.pmdt071, #参考项次
       pmdt214 LIKE pmdt_t.pmdt214, #采购方式
       pmdt215 LIKE pmdt_t.pmdt215, #最终收货组织
       pmdt048 LIKE pmdt_t.pmdt048, #价格参考项次
       pmdt216 LIKE pmdt_t.pmdt216, #退货申请单号
       pmdt217 LIKE pmdt_t.pmdt217, #退货申请项次
       pmdt090 LIKE pmdt_t.pmdt090, #借货还价数量
       pmdt091 LIKE pmdt_t.pmdt091, #借货还价参考数量
       pmdt092 LIKE pmdt_t.pmdt092, #还价税前金额
       pmdt093 LIKE pmdt_t.pmdt093, #还价含税金额
       pmdt218 LIKE pmdt_t.pmdt218, #采购价
       pmdt219 LIKE pmdt_t.pmdt219, #制造日期
       pmdt072 LIKE pmdt_t.pmdt072, #项目编号
       pmdt073 LIKE pmdt_t.pmdt073, #WBS
       pmdt074 LIKE pmdt_t.pmdt074, #活动编号
       pmdt227 LIKE pmdt_t.pmdt227, #补货规格说明
       pmdt049 LIKE pmdt_t.pmdt049, #发票编号
       pmdt050 LIKE pmdt_t.pmdt050, #发票号码
       pmdt075 LIKE pmdt_t.pmdt075, #预算细项
       pmdt220 LIKE pmdt_t.pmdt220, #商品品类
       pmdt221 LIKE pmdt_t.pmdt221  #来源单据商品品类
END RECORD
#161124-00048#8 mod-E
DEFINE l_pmds037         LIKE pmds_t.pmds037
DEFINE l_pmds011         LIKE pmds_t.pmds011  #採購性質  #160714-00010#1-add
DEFINE l_xrcd113         LIKE xrcd_t.xrcd113
DEFINE l_xrcd114         LIKE xrcd_t.xrcd114
DEFINE l_xrcd115         LIKE xrcd_t.xrcd115
DEFINE l_xrcd123         LIKE xrcd_t.xrcd123
DEFINE l_xrcd124         LIKE xrcd_t.xrcd124
DEFINE l_xrcd125         LIKE xrcd_t.xrcd125
DEFINE l_xrcd133         LIKE xrcd_t.xrcd133
DEFINE l_xrcd134         LIKE xrcd_t.xrcd134
DEFINE l_xrcd135         LIKE xrcd_t.xrcd135

   LET r_success = TRUE
   
   INITIALIZE l_pmdt.* TO NULL
   FOREACH apmp570_03_temp_d2_curs USING p_keyno INTO
      l_pmdt.pmdtseq,l_pmdt.pmdt028,l_pmdt.pmdt001,l_pmdt.pmdt002,l_pmdt.pmdt003,
      l_pmdt.pmdt004,l_pmdt.pmdt081,l_pmdt.pmdt082,l_pmdt.pmdt083,l_pmdt.pmdt005,
      l_pmdt.pmdt006,l_pmdt.pmdt007,l_pmdt.pmdt009,l_pmdt.pmdt010,l_pmdt.pmdt019,
      l_pmdt.pmdt020,l_pmdt.pmdt021,l_pmdt.pmdt022,l_pmdt.pmdt023,l_pmdt.pmdt024,
      l_pmdt.pmdt062,l_pmdt.pmdt016,l_pmdt.pmdt017,l_pmdt.pmdt018,l_pmdt.pmdt063,
      l_pmdt.pmdt051,l_pmdt.pmdt059
      
      LET l_pmdt.pmdtent = g_enterprise
      LET l_pmdt.pmdtsite = g_site
      LET l_pmdt.pmdtdocno = p_pmdtdocno
      
      #預設單頭的收貨單號
      #160714-00010#1-mod-(S) 多抓採購性質(pmds011)
#      SELECT pmds006,pmds037 INTO l_pmdt.pmdt027,l_pmds037 FROM pmds_t
#       WHERE pmdsent = g_enterprise
#         AND pmdsdocno = l_pmdt.pmdtdocno
      LET l_pmds037 = ''
      LET l_pmds011 = ''
      SELECT pmds006,pmds037,pmds011 INTO l_pmdt.pmdt027,l_pmds037,l_pmds011 
        FROM pmds_t
       WHERE pmdsent = g_enterprise
         AND pmdsdocno = l_pmdt.pmdtdocno
      #160714-00010#1-mod-(E)
      
      #將收貨單的資料帶過來
      SELECT pmdt008,pmdt011,pmdt025,pmdt026,pmdt036,
             pmdt037,pmdt038,pmdt039,pmdt040,pmdt041,
             pmdt046,pmdt047,NVL(pmdt053,0),NVL(pmdt054,0),NVL(pmdt055,0),
             pmdt072,pmdt073,pmdt074  #add by lixiang 2015/06/29
        INTO l_pmdt.pmdt008,l_pmdt.pmdt011,l_pmdt.pmdt025,l_pmdt.pmdt026,l_pmdt.pmdt036,
             l_pmdt.pmdt037,l_pmdt.pmdt038,l_pmdt.pmdt039,l_pmdt.pmdt040,l_pmdt.pmdt041,
             l_pmdt.pmdt046,l_pmdt.pmdt047,l_pmdt.pmdt053,l_pmdt.pmdt054,l_pmdt.pmdt055,
             l_pmdt.pmdt072,l_pmdt.pmdt073,l_pmdt.pmdt074   #add by lixiang 2015/06/29
        FROM pmdt_t
       WHERE pmdtent = l_pmdt.pmdtent
         AND pmdtdocno = l_pmdt.pmdt027
         AND pmdtseq = l_pmdt.pmdt028
         
      #重計金額
      CALL s_tax_ins(l_pmdt.pmdtdocno,l_pmdt.pmdtseq,0,g_site,l_pmdt.pmdt020*l_pmdt.pmdt036,
                     l_pmdt.pmdt046,l_pmdt.pmdt020,l_pmds037,1,' ',1,1)
           RETURNING l_pmdt.pmdt038,l_pmdt.pmdt047,l_pmdt.pmdt039,
                     l_xrcd113,l_xrcd114,l_xrcd115,
                     l_xrcd123,l_xrcd124,l_xrcd125,
                     l_xrcd133,l_xrcd134,l_xrcd135
      IF NOT g_sub_success THEN
         IF g_errcollect.getLength() > 0 THEN
            LET g_result_str = g_errcollect[g_errcollect.getLength()].message
         END IF
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      
      #沖銷順序
      CALL apmp570_03_def_pmdt011(l_pmdt.*)
           RETURNING l_pmdt.pmdt011
           
      #160714-00010#1-mod-(S)
      #依採購性質給值，VMI給'N'，其餘為'Y'
#      LET l_pmdt.pmdt084 = 'Y'      #160729-00038#1
      IF l_pmds011 = '3' THEN
         LET l_pmdt.pmdt084 = 'N'
      ELSE
         LET l_pmdt.pmdt084 = 'Y'
      END IF
      #160714-00010#1-mod-(E)
      #160714-00010#1-add-(S)
      LET l_pmdt.pmdt056 = 0   #主帳套已請款數量
      LET l_pmdt.pmdt057 = 0   #帳套二已請款數量
      LET l_pmdt.pmdt058 = 0   #帳套三已請款數量
      LET l_pmdt.pmdt066 = 0   #帳套一暫估數量      #160908-00031#1
      LET l_pmdt.pmdt067 = 0   #帳套二暫估數量
      LET l_pmdt.pmdt068 = 0   #帳套三暫估數量 
      LET l_pmdt.pmdt069 = 0   #已開發票數量
      #160714-00010#1-add-(E)
      INSERT INTO pmdt_t(pmdtent,pmdtsite,pmdtdocno,pmdtseq,
                         pmdt001,pmdt002,pmdt003,pmdt004,pmdt005,
                         pmdt006,pmdt007,pmdt008,pmdt009,pmdt010,
                         pmdt011,
                         pmdt016,pmdt017,pmdt018,pmdt019,pmdt020,
                         pmdt021,pmdt022,pmdt023,pmdt024,pmdt025,
                         pmdt026,pmdt027,pmdt028,
                         pmdt036,pmdt037,pmdt038,pmdt039,pmdt040,
                         pmdt041,pmdt042,pmdt043,pmdt044,pmdt045,
                         pmdt046,pmdt047,
                         pmdt051,pmdt052,pmdt053,pmdt054,pmdt055,
                         pmdt056,pmdt057,pmdt058,pmdt059,pmdt060,
                         pmdt061,pmdt062,pmdt063,pmdt064,pmdt065,
                         pmdt066,pmdt067,pmdt068,pmdt069,
                         pmdt081,pmdt082,pmdt083,pmdt084,pmdt085,
                         pmdt086,pmdt087,
                         pmdt072,pmdt073,pmdt074) #add by lixiang 2015/06/29
         VALUES(l_pmdt.pmdtent,l_pmdt.pmdtsite,l_pmdt.pmdtdocno,l_pmdt.pmdtseq,
                l_pmdt.pmdt001,l_pmdt.pmdt002,l_pmdt.pmdt003,l_pmdt.pmdt004,l_pmdt.pmdt005,
                l_pmdt.pmdt006,l_pmdt.pmdt007,l_pmdt.pmdt008,l_pmdt.pmdt009,l_pmdt.pmdt010,
                l_pmdt.pmdt011,
                l_pmdt.pmdt016,l_pmdt.pmdt017,l_pmdt.pmdt018,l_pmdt.pmdt019,l_pmdt.pmdt020,
                l_pmdt.pmdt021,l_pmdt.pmdt022,l_pmdt.pmdt023,l_pmdt.pmdt024,l_pmdt.pmdt025,
                l_pmdt.pmdt026,l_pmdt.pmdt027,l_pmdt.pmdt028,
                l_pmdt.pmdt036,l_pmdt.pmdt037,l_pmdt.pmdt038,l_pmdt.pmdt039,l_pmdt.pmdt040,
                l_pmdt.pmdt041,l_pmdt.pmdt042,l_pmdt.pmdt043,l_pmdt.pmdt044,l_pmdt.pmdt045,
                l_pmdt.pmdt046,l_pmdt.pmdt047,
                l_pmdt.pmdt051,l_pmdt.pmdt052,l_pmdt.pmdt053,l_pmdt.pmdt054,l_pmdt.pmdt055,
                l_pmdt.pmdt056,l_pmdt.pmdt057,l_pmdt.pmdt058,l_pmdt.pmdt059,l_pmdt.pmdt060,
                l_pmdt.pmdt061,l_pmdt.pmdt062,l_pmdt.pmdt063,l_pmdt.pmdt064,l_pmdt.pmdt065,
                l_pmdt.pmdt066,l_pmdt.pmdt067,l_pmdt.pmdt068,l_pmdt.pmdt069,
                l_pmdt.pmdt081,l_pmdt.pmdt082,l_pmdt.pmdt083,l_pmdt.pmdt084,l_pmdt.pmdt085,
                l_pmdt.pmdt086,l_pmdt.pmdt087,
                l_pmdt.pmdt072,l_pmdt.pmdt073,l_pmdt.pmdt074)   #add by lixiang 2015/06/29
      IF SQLCA.sqlcode THEN
         IF NOT cl_null(g_result_str) THEN
            LET g_result_str = g_result_str,",","INSERT INTO pmdt_t",cl_getmsg(SQLCA.sqlcode,g_lang)
         ELSE
            LET g_result_str = "INSERT INTO pmdt_t",cl_getmsg(SQLCA.sqlcode,g_lang)
         END IF
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      
      INITIALIZE l_pmdt.* TO NULL
   END FOREACH
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 新增多庫儲批明細
# Memo...........:
# Usage..........: CALL apmp570_03_ins_pmdu(p_pmdudocno,p_keyno)
#                  RETURNING r_success
# Input parameter: p_pmdudocno    入庫單號
#                : p_keyno        底稿key
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2014/10/08 By stellar
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp570_03_ins_pmdu(p_pmdudocno,p_keyno)
DEFINE p_pmdudocno       LIKE pmdu_t.pmdudocno
DEFINE p_keyno           LIKE type_t.num5
DEFINE r_success         LIKE type_t.num5
#161124-00048#8 mod-S
#DEFINE l_pmdu            RECORD LIKE pmdu_t.*
DEFINE l_pmdu RECORD  #收貨/驗退/入庫/倉退單多庫儲批收貨明細檔
       pmduent LIKE pmdu_t.pmduent, #企业编号
       pmdusite LIKE pmdu_t.pmdusite, #营运据点
       pmdudocno LIKE pmdu_t.pmdudocno, #单据编号
       pmduseq LIKE pmdu_t.pmduseq, #项次
       pmduseq1 LIKE pmdu_t.pmduseq1, #项序
       pmdu001 LIKE pmdu_t.pmdu001, #料件编号
       pmdu002 LIKE pmdu_t.pmdu002, #产品特征
       pmdu003 LIKE pmdu_t.pmdu003, #作业编号
       pmdu004 LIKE pmdu_t.pmdu004, #作业序
       pmdu005 LIKE pmdu_t.pmdu005, #库存管理特征
       pmdu006 LIKE pmdu_t.pmdu006, #库位
       pmdu007 LIKE pmdu_t.pmdu007, #储位
       pmdu008 LIKE pmdu_t.pmdu008, #批号
       pmdu009 LIKE pmdu_t.pmdu009, #单位
       pmdu010 LIKE pmdu_t.pmdu010, #数量
       pmdu011 LIKE pmdu_t.pmdu011, #参考单位
       pmdu012 LIKE pmdu_t.pmdu012, #参考数量
       pmdu013 LIKE pmdu_t.pmdu013, #允收数量
       pmdu014 LIKE pmdu_t.pmdu014, #已入库量
       pmdu015 LIKE pmdu_t.pmdu015, #已验退量
       pmdu016 LIKE pmdu_t.pmdu016, #存货备注
       pmdu017 LIKE pmdu_t.pmdu017, #有效日期
       pmdu200 LIKE pmdu_t.pmdu200, #包装单位
       pmdu201 LIKE pmdu_t.pmdu201, #包装数量
       pmdu202 LIKE pmdu_t.pmdu202  #制造日期
END RECORD
#161124-00048#8 mod-E
DEFINE l_pmdt027         LIKE pmdt_t.pmdt027
DEFINE l_pmdt028         LIKE pmdt_t.pmdt028
DEFINE l_n               LIKE type_t.num10

   LET r_success = TRUE
   
   INITIALIZE l_pmdu.* TO NULL
   FOREACH apmp570_03_temp_d3_curs USING p_keyno INTO 
      l_pmdu.pmduseq,l_pmdu.pmduseq1,
      l_pmdu.pmdu001,l_pmdu.pmdu002,l_pmdu.pmdu003,l_pmdu.pmdu004,l_pmdu.pmdu005,
      l_pmdu.pmdu006,l_pmdu.pmdu007,l_pmdu.pmdu008,l_pmdu.pmdu009,l_pmdu.pmdu010,
      l_pmdu.pmdu011,l_pmdu.pmdu012,l_pmdu.pmdu013,l_pmdu.pmdu014,l_pmdu.pmdu015
      
      LET l_pmdu.pmduent = g_enterprise
      LET l_pmdu.pmdusite = g_site
      LET l_pmdu.pmdudocno = p_pmdudocno
      
      INSERT INTO pmdu_t(pmduent,pmdusite,pmdudocno,pmduseq,pmduseq1,
                         pmdu001,pmdu002,pmdu003,pmdu004,pmdu005,
                         pmdu006,pmdu007,pmdu008,pmdu009,pmdu010,
                         pmdu011,pmdu012,pmdu013,pmdu014,pmdu015)
         VALUES(l_pmdu.pmduent,l_pmdu.pmdusite,l_pmdu.pmdudocno,l_pmdu.pmduseq,l_pmdu.pmduseq1,
                l_pmdu.pmdu001,l_pmdu.pmdu002,l_pmdu.pmdu003,l_pmdu.pmdu004,l_pmdu.pmdu005,
                l_pmdu.pmdu006,l_pmdu.pmdu007,l_pmdu.pmdu008,l_pmdu.pmdu009,l_pmdu.pmdu010,
                l_pmdu.pmdu011,l_pmdu.pmdu012,l_pmdu.pmdu013,l_pmdu.pmdu014,l_pmdu.pmdu015)
      IF SQLCA.sqlcode THEN
         IF NOT cl_null(g_result_str) THEN
            LET g_result_str = g_result_str,",","INSERT INTO pmdu_t",cl_getmsg(SQLCA.sqlcode,g_lang)
         ELSE
            LET g_result_str = "INSERT INTO pmdu_t",cl_getmsg(SQLCA.sqlcode,g_lang)
         END IF
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      
      #供P類作業對出入庫的交易單交易單據自動挑選製造批序號資料
      LET l_pmdt027 = ''
      LET l_pmdt028 = ''
      SELECT pmdt027,pmdt028 INTO l_pmdt027,l_pmdt028 FROM pmdt_t 
         WHERE pmdtent = g_enterprise AND pmdtdocno = l_pmdu.pmdudocno AND pmdtseq = l_pmdu.pmduseq
      SELECT COUNT(*) INTO l_n FROM inao_t WHERE inaoent = g_enterprise AND inaodocno = l_pmdt027 AND inaoseq = l_pmdt028
      IF l_n > 0 THEN
         IF NOT s_lot_auto_sel('2',l_pmdu.pmdudocno,l_pmdu.pmduseq,l_pmdu.pmduseq1,l_pmdu.pmdu010,'1','apmt570',l_pmdt027,l_pmdt028) THEN
            LET r_success = FALSE
            EXIT FOREACH
         ELSE
            #更新對應收貨單上的inao021(已入庫量)
            IF NOT s_apmt520_upd_inao('1',l_pmdu.pmdudocno,l_pmdu.pmduseq,l_pmdu.pmduseq1) THEN
               LET r_success = FALSE
               EXIT FOREACH
            END IF
         END IF
      END IF
      
      INITIALIZE l_pmdu.* TO NULL
   END FOREACH
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 新增原始需求分配明細
# Memo...........:
# Usage..........: CALL apmp570_03_ins_pmdv(p_pmdvdocno,p_keyno)
#                  RETURNING r_success
# Input parameter: p_pmdvdocno    入庫單號
#                : p_keyno        底稿key
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2014/10/08 By stellar
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp570_03_ins_pmdv(p_pmdvdocno,p_keyno)
DEFINE p_pmdvdocno       LIKE pmdv_t.pmdvdocno
DEFINE p_keyno           LIKE type_t.num5
DEFINE r_success         LIKE type_t.num5
#161124-00048#8 mod-S
#DEFINE l_pmdv            RECORD LIKE pmdv_t.*
DEFINE l_pmdv RECORD  #收貨/入庫需求分配明細檔
       pmdvent LIKE pmdv_t.pmdvent, #企业编号
       pmdvsite LIKE pmdv_t.pmdvsite, #营运据点
       pmdvdocno LIKE pmdv_t.pmdvdocno, #单据编号
       pmdvseq LIKE pmdv_t.pmdvseq, #项次
       pmdvseq1 LIKE pmdv_t.pmdvseq1, #项序
       pmdv001 LIKE pmdv_t.pmdv001, #收货料件编号
       pmdv002 LIKE pmdv_t.pmdv002, #收货产品特征
       pmdv003 LIKE pmdv_t.pmdv003, #作业编号
       pmdv004 LIKE pmdv_t.pmdv004, #作业序
       pmdv005 LIKE pmdv_t.pmdv005, #子件特性
       pmdv006 LIKE pmdv_t.pmdv006, #QPA
       pmdv011 LIKE pmdv_t.pmdv011, #采购单号
       pmdv012 LIKE pmdv_t.pmdv012, #采购项次
       pmdv013 LIKE pmdv_t.pmdv013, #采购项序
       pmdv014 LIKE pmdv_t.pmdv014, #需求单号
       pmdv015 LIKE pmdv_t.pmdv015, #需求项次
       pmdv016 LIKE pmdv_t.pmdv016, #需求项序
       pmdv017 LIKE pmdv_t.pmdv017, #需求分批序
       pmdv018 LIKE pmdv_t.pmdv018, #收货/入库单位
       pmdv019 LIKE pmdv_t.pmdv019, #收货/入库分配数量
       pmdv900 LIKE pmdv_t.pmdv900, #保留字段str
       pmdv999 LIKE pmdv_t.pmdv999, #保留字段end
       pmdv200 LIKE pmdv_t.pmdv200, #包装单位
       pmdv201 LIKE pmdv_t.pmdv201  #包装数量
END RECORD
#161124-00048#8 mod-E

   LET r_success = TRUE
   
   INITIALIZE l_pmdv.* TO NULL
   FOREACH apmp570_03_temp_d5_curs USING p_keyno INTO
      l_pmdv.pmdvseq,l_pmdv.pmdvseq1,
      l_pmdv.pmdv001,l_pmdv.pmdv002,l_pmdv.pmdv003,l_pmdv.pmdv004,l_pmdv.pmdv005,
      l_pmdv.pmdv006,
      l_pmdv.pmdv011,l_pmdv.pmdv012,l_pmdv.pmdv013,l_pmdv.pmdv014,l_pmdv.pmdv015,
      l_pmdv.pmdv016,l_pmdv.pmdv018,l_pmdv.pmdv019
      
      LET l_pmdv.pmdvent = g_enterprise
      LET l_pmdv.pmdvsite = g_site
      LET l_pmdv.pmdvdocno = p_pmdvdocno
      
      INSERT INTO pmdv_t(pmdvent,pmdvsite,pmdvdocno,pmdvseq,pmdvseq1, 
                         pmdv001,pmdv002,pmdv003,pmdv004,pmdv005, 
                         pmdv006,
                         pmdv011,pmdv012,pmdv013,pmdv014,pmdv015,
                         pmdv016,pmdv017,pmdv018,pmdv019) 
         VALUES(l_pmdv.pmdvent,l_pmdv.pmdvsite,l_pmdv.pmdvdocno,l_pmdv.pmdvseq,l_pmdv.pmdvseq1, 
                l_pmdv.pmdv001,l_pmdv.pmdv002,l_pmdv.pmdv003,l_pmdv.pmdv004,l_pmdv.pmdv005, 
                l_pmdv.pmdv006,
                l_pmdv.pmdv011,l_pmdv.pmdv012,l_pmdv.pmdv013,l_pmdv.pmdv014,l_pmdv.pmdv015,
                l_pmdv.pmdv016,l_pmdv.pmdv017,l_pmdv.pmdv018,l_pmdv.pmdv019) 
      IF SQLCA.sqlcode THEN
         IF NOT cl_null(g_result_str) THEN
            LET g_result_str = g_result_str,",","INSERT INTO pmdv_t",cl_getmsg(SQLCA.sqlcode,g_lang)
         ELSE
            LET g_result_str = "INSERT INTO pmdv_t",cl_getmsg(SQLCA.sqlcode,g_lang)
         END IF
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      
      INITIALIZE l_pmdv.* TO NULL
   END FOREACH
   
   RETURN r_success
END FUNCTION
#當沖銷順序相關的欄位 "料件編號、產品特徵、收貨單位、倉庫、儲位、批號" 
#有修改過,即自動將重新預設沖銷順序
PRIVATE FUNCTION apmp570_03_def_pmdt011(p_pmdt)
#161124-00048#8 mod-S
#DEFINE p_pmdt            RECORD LIKE pmdt_t.*
DEFINE p_pmdt RECORD  #收貨/入庫單身明細檔
       pmdtent LIKE pmdt_t.pmdtent, #企业编号
       pmdtsite LIKE pmdt_t.pmdtsite, #营运据点
       pmdtdocno LIKE pmdt_t.pmdtdocno, #单据编号
       pmdtseq LIKE pmdt_t.pmdtseq, #项次
       pmdt001 LIKE pmdt_t.pmdt001, #采购单号
       pmdt002 LIKE pmdt_t.pmdt002, #采购项次
       pmdt003 LIKE pmdt_t.pmdt003, #采购项序
       pmdt004 LIKE pmdt_t.pmdt004, #采购分批序
       pmdt005 LIKE pmdt_t.pmdt005, #子件特性
       pmdt006 LIKE pmdt_t.pmdt006, #料件编号
       pmdt007 LIKE pmdt_t.pmdt007, #产品特征
       pmdt008 LIKE pmdt_t.pmdt008, #包装容器
       pmdt009 LIKE pmdt_t.pmdt009, #作业编号
       pmdt010 LIKE pmdt_t.pmdt010, #作业序
       pmdt011 LIKE pmdt_t.pmdt011, #冲销顺序
       pmdt016 LIKE pmdt_t.pmdt016, #库位
       pmdt017 LIKE pmdt_t.pmdt017, #储位
       pmdt018 LIKE pmdt_t.pmdt018, #批号
       pmdt019 LIKE pmdt_t.pmdt019, #收货/入库单位
       pmdt020 LIKE pmdt_t.pmdt020, #收货/入库数量
       pmdt021 LIKE pmdt_t.pmdt021, #参考单位
       pmdt022 LIKE pmdt_t.pmdt022, #参考数量
       pmdt023 LIKE pmdt_t.pmdt023, #计价单位
       pmdt024 LIKE pmdt_t.pmdt024, #计价数量
       pmdt025 LIKE pmdt_t.pmdt025, #紧急度
       pmdt026 LIKE pmdt_t.pmdt026, #检验否
       pmdt027 LIKE pmdt_t.pmdt027, #收货单号
       pmdt028 LIKE pmdt_t.pmdt028, #收货项次
       pmdt036 LIKE pmdt_t.pmdt036, #单价
       pmdt037 LIKE pmdt_t.pmdt037, #税率
       pmdt038 LIKE pmdt_t.pmdt038, #税前金额
       pmdt039 LIKE pmdt_t.pmdt039, #含税金额
       pmdt040 LIKE pmdt_t.pmdt040, #价格核决
       pmdt041 LIKE pmdt_t.pmdt041, #保税否
       pmdt042 LIKE pmdt_t.pmdt042, #取价来源
       pmdt043 LIKE pmdt_t.pmdt043, #价格参考单号
       pmdt044 LIKE pmdt_t.pmdt044, #取出单价
       pmdt045 LIKE pmdt_t.pmdt045, #价差比
       pmdt046 LIKE pmdt_t.pmdt046, #税种
       pmdt047 LIKE pmdt_t.pmdt047, #税额
       pmdt051 LIKE pmdt_t.pmdt051, #理由码
       pmdt052 LIKE pmdt_t.pmdt052, #状态码
       pmdt053 LIKE pmdt_t.pmdt053, #允收数量
       pmdt054 LIKE pmdt_t.pmdt054, #已入库量
       pmdt055 LIKE pmdt_t.pmdt055, #验退量
       pmdt056 LIKE pmdt_t.pmdt056, #主账套已请款数量
       pmdt057 LIKE pmdt_t.pmdt057, #账套二已请款数量
       pmdt058 LIKE pmdt_t.pmdt058, #账套三已请款数量
       pmdt059 LIKE pmdt_t.pmdt059, #备注
       pmdt060 LIKE pmdt_t.pmdt060, #供应商批号
       pmdt061 LIKE pmdt_t.pmdt061, #供应商送货数量
       pmdt062 LIKE pmdt_t.pmdt062, #多库储批收货入库
       pmdt063 LIKE pmdt_t.pmdt063, #库存管理特征
       pmdt064 LIKE pmdt_t.pmdt064, #出货单号
       pmdt065 LIKE pmdt_t.pmdt065, #出货单项次
       pmdt066 LIKE pmdt_t.pmdt066, #主账套暂估数量
       pmdt067 LIKE pmdt_t.pmdt067, #账套二暂估数量
       pmdt068 LIKE pmdt_t.pmdt068, #账套三暂估数量
       pmdt069 LIKE pmdt_t.pmdt069, #已开发票数量
       pmdt081 LIKE pmdt_t.pmdt081, #QC单号
       pmdt082 LIKE pmdt_t.pmdt082, #QC判定项次
       pmdt083 LIKE pmdt_t.pmdt083, #判定结果
       pmdt084 LIKE pmdt_t.pmdt084, #须自立AP否
       pmdt085 LIKE pmdt_t.pmdt085, #多角流程编号
       pmdt086 LIKE pmdt_t.pmdt086, #采购多角性质
       pmdt087 LIKE pmdt_t.pmdt087, #采购单开立据点
       pmdt088 LIKE pmdt_t.pmdt088, #存货备注
       pmdt089 LIKE pmdt_t.pmdt089, #有效日期
       pmdt900 LIKE pmdt_t.pmdt900, #保留字段str
       pmdt999 LIKE pmdt_t.pmdt999, #保留字段end
       pmdt200 LIKE pmdt_t.pmdt200, #商品条码
       pmdt201 LIKE pmdt_t.pmdt201, #收货包装单位
       pmdt202 LIKE pmdt_t.pmdt202, #收货包装数量
       pmdt203 LIKE pmdt_t.pmdt203, #采购组织
       pmdt204 LIKE pmdt_t.pmdt204, #采购中心
       pmdt205 LIKE pmdt_t.pmdt205, #要货组织
       pmdt206 LIKE pmdt_t.pmdt206, #预约收货单号
       pmdt207 LIKE pmdt_t.pmdt207, #预约收货项次
       pmdt208 LIKE pmdt_t.pmdt208, #采购渠道
       pmdt209 LIKE pmdt_t.pmdt209, #渠道性质
       pmdt210 LIKE pmdt_t.pmdt210, #经营方式
       pmdt211 LIKE pmdt_t.pmdt211, #结算方式
       pmdt212 LIKE pmdt_t.pmdt212, #合同编号
       pmdt213 LIKE pmdt_t.pmdt213, #协议编号
       pmdtorga LIKE pmdt_t.pmdtorga, #账务组织
       pmdt070 LIKE pmdt_t.pmdt070, #参考单号
       pmdt071 LIKE pmdt_t.pmdt071, #参考项次
       pmdt214 LIKE pmdt_t.pmdt214, #采购方式
       pmdt215 LIKE pmdt_t.pmdt215, #最终收货组织
       pmdt048 LIKE pmdt_t.pmdt048, #价格参考项次
       pmdt216 LIKE pmdt_t.pmdt216, #退货申请单号
       pmdt217 LIKE pmdt_t.pmdt217, #退货申请项次
       pmdt090 LIKE pmdt_t.pmdt090, #借货还价数量
       pmdt091 LIKE pmdt_t.pmdt091, #借货还价参考数量
       pmdt092 LIKE pmdt_t.pmdt092, #还价税前金额
       pmdt093 LIKE pmdt_t.pmdt093, #还价含税金额
       pmdt218 LIKE pmdt_t.pmdt218, #采购价
       pmdt219 LIKE pmdt_t.pmdt219, #制造日期
       pmdt072 LIKE pmdt_t.pmdt072, #项目编号
       pmdt073 LIKE pmdt_t.pmdt073, #WBS
       pmdt074 LIKE pmdt_t.pmdt074, #活动编号
       pmdt227 LIKE pmdt_t.pmdt227, #补货规格说明
       pmdt049 LIKE pmdt_t.pmdt049, #发票编号
       pmdt050 LIKE pmdt_t.pmdt050, #发票号码
       pmdt075 LIKE pmdt_t.pmdt075, #预算细项
       pmdt220 LIKE pmdt_t.pmdt220, #商品品类
       pmdt221 LIKE pmdt_t.pmdt221  #来源单据商品品类
END RECORD
#161124-00048#8 mod-E
DEFINE r_pmdt011     LIKE pmdt_t.pmdt011
DEFINE l_pmdt011     LIKE type_t.num5
DEFINE l_sql         STRING
    
   LET l_sql = " SELECT MAX(pmdt011) FROM pmdt_t",
               "  WHERE pmdtent = ",p_pmdt.pmdtent,
               "    AND pmdtdocno = '",p_pmdt.pmdtdocno,"'",
               "    AND pmdtseq != ",p_pmdt.pmdtseq,
               "    AND pmdt006 = '",p_pmdt.pmdt006,"'"

   IF p_pmdt.pmdt007 IS NULL THEN 
      LET l_sql = l_sql CLIPPED,
               "    AND pmdt007 IS NULL " 
   ELSE
      LET l_sql = l_sql CLIPPED,
               "    AND pmdt007 = '",p_pmdt.pmdt007,"'" 
   END IF

   IF p_pmdt.pmdt019 IS NULL THEN 
      LET l_sql = l_sql CLIPPED,
               "    AND pmdt019 IS NULL " 
   ELSE
      LET l_sql = l_sql CLIPPED,
               "    AND pmdt019 = '",p_pmdt.pmdt019,"'" 
   END IF

   IF p_pmdt.pmdt016 IS NULL THEN 
      LET l_sql = l_sql CLIPPED,
               "    AND pmdt016 IS NULL " 
   ELSE
      LET l_sql = l_sql CLIPPED,
               "    AND pmdt016 = '",p_pmdt.pmdt016,"'" 
   END IF

   IF p_pmdt.pmdt017 IS NULL THEN 
      LET l_sql = l_sql CLIPPED,
               "    AND pmdt017 IS NULL "
   ELSE
      LET l_sql = l_sql CLIPPED,
               "    AND pmdt017 = '",p_pmdt.pmdt017,"'" 
   END IF

   IF p_pmdt.pmdt018 IS NULL THEN 
      LET l_sql = l_sql CLIPPED,
               "    AND pmdt018 IS NULL " 
   ELSE
      LET l_sql = l_sql CLIPPED,
               "    AND pmdt018 = '",p_pmdt.pmdt018,"'" 
   END IF

   PREPARE apmp570_02_pmdt011_pre3 FROM l_sql
   EXECUTE apmp570_02_pmdt011_pre3 INTO l_pmdt011

   IF cl_null(l_pmdt011) THEN
      LET r_pmdt011 = 1
   ELSE
      LET r_pmdt011 = l_pmdt011 + 1
   END IF
   
   RETURN r_pmdt011
END FUNCTION

################################################################################
# Descriptions...: 執行apmt570 or apmt571 or apmt573
# Memo...........:
# Usage..........: CALL apmp570_03_open_apmt570()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/06/13 By dorislai(#160606-00011#1)
# Modify.........:
################################################################################
PUBLIC FUNCTION apmp570_03_open_apmt570()
   DEFINE la_param  RECORD
                       prog   STRING,
                       param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING 
   
   WHENEVER ERROR CONTINUE 
   
   #apmt570
   IF NOT cl_null(g_pmdsdocno) THEN
      INITIALIZE la_param.* TO NULL
      LET la_param.prog = 'apmt570'
      LET la_param.param[1] = g_pmdsdocno
      LET ls_js = util.JSON.stringify(la_param )
      CALL cl_cmdrun(ls_js)
   END IF
   
   #apmt571
   IF NOT cl_null(g_pmdsdocno_1) THEN
      INITIALIZE la_param.* TO NULL
      LET la_param.prog = 'apmt571'
      LET la_param.param[1] = g_pmdsdocno_1
      LET ls_js = util.JSON.stringify(la_param )
      CALL cl_cmdrun(ls_js)
   END IF
   
   #apmt573
   IF NOT cl_null(g_pmdsdocno_2) THEN
      INITIALIZE la_param.* TO NULL
      LET la_param.prog = 'apmt573'
      LET la_param.param[1] = g_pmdsdocno_2
      LET ls_js = util.JSON.stringify(la_param )
      CALL cl_cmdrun(ls_js)
   END IF
   
   
END FUNCTION

 
{</section>}
 
