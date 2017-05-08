#該程式未解開Section, 採用最新樣板產出!
{<section id="apmp570_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0008(2014-10-15 15:45:20), PR版次:0008(2016-12-30 14:58:02)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000090
#+ Filename...: apmp570_01
#+ Description: 引導式入庫處理作業-待入庫資料
#+ Creator....: 01588(2014-07-04 15:38:30)
#+ Modifier...: 01588 -SD/PR- 01534
 
{</section>}
 
{<section id="apmp570_01.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"
#160727-00019#12   2016/08/03 By 08734     临时表长度超过15码的减少到15码以下 p570_01_lock_b_t ——> p570_lock_t
#160706-00037#3    2016/10/24 By shiun     引導式作業調整的作法:進行到第二步時，針對勾選的資料中若有被別人處理中的單據提示"單據編號OOO+項次XX被其他使用者處理中"
#161124-00027#1    2016/11/24 By wuxja     待验数据查询时需加上ENT条件
#161207-00033#21   2016/12/20 By lixh      一次性交易對象顯示說明，所有的客戶/供應商欄位都應該處理
#161230-00020#1    2016/12/30 By lixh      apmp570_01_temp临时表增加pmds028用来捞取一次性交易對象顯示說明【查看底稿ACTION】
#end add-point
#add-point:填寫註解說明(客製用) name="main.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="main.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
#add-point:增加匯入變數檔 name="global.inc"
 
#end add-point
 
{</section>}
 
{<section id="apmp570_01.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
TYPE type_pmdt         RECORD
   sel                 LIKE type_t.chr1,
   pmdsdocno           LIKE pmds_t.pmdsdocno,
   pmdsdocdt           LIKE pmds_t.pmdsdocdt,
   pmds007             LIKE pmds_t.pmds007,
   pmds007_desc        LIKE pmaal_t.pmaal004,
   pmdtseq             LIKE pmdt_t.pmdtseq,
   pmdt006             LIKE pmdt_t.pmdt006,
   pmdt006_desc        LIKE imaal_t.imaal003,
   pmdt006_desc_desc   LIKE imaal_t.imaal004,
   pmdt007             LIKE pmdt_t.pmdt007,
   pmdt007_desc        LIKE type_t.chr500,
   pmdt009             LIKE pmdt_t.pmdt009,
   pmdt009_desc        LIKE oocql_t.oocql004,
   pmdt010             LIKE pmdt_t.pmdt010,
   pmdt019             LIKE pmdt_t.pmdt019,
   pmdt019_desc        LIKE oocal_t.oocal003,
   pmdt020             LIKE pmdt_t.pmdt020,
   pmdt021             LIKE pmdt_t.pmdt021,
   pmdt021_desc        LIKE oocal_t.oocal003,
   pmdt022             LIKE pmdt_t.pmdt022,
   pmdt016             LIKE pmdt_t.pmdt016,
   pmdt016_desc        LIKE inaa_t.inaa002,
   pmdt017             LIKE pmdt_t.pmdt017,
   pmdt017_desc        LIKE inab_t.inab003,
   pmdt018             LIKE pmdt_t.pmdt018,
   pmdt063             LIKE pmdt_t.pmdt063,
   pmdt026             LIKE pmdt_t.pmdt026,
   amt1                LIKE pmdt_t.pmdt020,
   amt2                LIKE pmdt_t.pmdt020,
   pmdt059             LIKE pmdt_t.pmdt059
                       END RECORD
TYPE type_pmdt2        RECORD
   pmdsdocno           LIKE pmds_t.pmdsdocno,
   pmds007             LIKE pmds_t.pmds007,
   pmds007_desc        LIKE pmaal_t.pmaal004,
   pmdsdocdt           LIKE pmds_t.pmdsdocdt,
   pmdtseq             LIKE pmdt_t.pmdtseq,
   pmdt006             LIKE pmdt_t.pmdt006,
   pmdt006_desc        LIKE imaal_t.imaal003,
   pmdt006_desc_desc   LIKE imaal_t.imaal004,
   pmdt007             LIKE pmdt_t.pmdt007,
   pmdt007_desc        LIKE type_t.chr500,
   pmdt009             LIKE pmdt_t.pmdt009,
   pmdt009_desc        LIKE oocql_t.oocql004,
   pmdt010             LIKE pmdt_t.pmdt010,
   pmdt019             LIKE pmdt_t.pmdt019,
   pmdt019_desc        LIKE oocal_t.oocal003,
   pmdt020             LIKE pmdt_t.pmdt020,
   pmdt021             LIKE pmdt_t.pmdt021,
   pmdt021_desc        LIKE oocal_t.oocal003,
   pmdt022             LIKE pmdt_t.pmdt022,
   pmdt016             LIKE pmdt_t.pmdt016,
   pmdt016_desc        LIKE inaa_t.inaa002,
   pmdt017             LIKE pmdt_t.pmdt017,
   pmdt017_desc        LIKE inab_t.inab003,
   pmdt018             LIKE pmdt_t.pmdt018,
   pmdt063             LIKE pmdt_t.pmdt063,
   pmdt026             LIKE pmdt_t.pmdt026,
   amt1                LIKE pmdt_t.pmdt020,
   pmdt059             LIKE pmdt_t.pmdt059
                       END RECORD
DEFINE g_pmdt_d        DYNAMIC ARRAY OF type_pmdt
DEFINE g_pmdt_d_t      type_pmdt
DEFINE g_pmdt2_d       DYNAMIC ARRAY OF type_pmdt2

DEFINE l_ac            LIKE type_t.num5
DEFINE g_rec_b         LIKE type_t.num5
DEFINE g_rec_b2        LIKE type_t.num5
DEFINE g_input_type    LIKE type_t.chr1   #1.請購資料  2.底稿資料
DEFINE g_i             LIKE type_t.num5
DEFINE g_flag          LIKE type_t.num5
#end add-point
 
{</section>}
 
{<section id="apmp570_01.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="apmp570_01.other_dialog" >}
#逾期資料的INPUT
DIALOG apmp570_01_input()

   INPUT ARRAY g_pmdt_d FROM s_detail1_apmp570_01.*
       ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
               INSERT ROW = FALSE,DELETE ROW = FALSE,APPEND ROW = FALSE)
       BEFORE INPUT
       
       BEFORE ROW
          LET l_ac = DIALOG.getCurrentRow("s_detail1_apmp570_01")
          CALL DIALOG.setCurrentRow("s_detail1_apmp570_01",l_ac)
          LET g_pmdt_d_t.* = g_pmdt_d[l_ac].*
          CALL apmp570_01_set_entry_b()
          CALL apmp570_01_set_no_required_b()
          CALL apmp570_01_set_required_b()
          CALL apmp570_01_set_no_entry_b()
          
       ON CHANGE sel_d1_01
          IF g_input_type = '1' THEN
             IF g_pmdt_d[l_ac].sel = 'Y' THEN
                LET g_pmdt_d[l_ac].amt2 = g_pmdt_d[l_ac].amt1
             ELSE
                LET g_pmdt_d[l_ac].amt2 = 0
             END IF
          END IF
          CALL apmp570_01_set_entry_b()
          CALL apmp570_01_set_no_required_b()
          CALL apmp570_01_set_required_b()
          CALL apmp570_01_set_no_entry_b()
         
       AFTER FIELD amt2_d1_01
          IF NOT cl_null(g_pmdt_d[l_ac].amt2) THEN
             IF NOT cl_ap_chk_Range(g_pmdt_d[l_ac].amt2,"0.000","1",g_pmdt_d[l_ac].amt1,"1","azz-00087",1) THEN
                NEXT FIELD CURRENT
             END IF
             
             #針對數量進行取位
             CALL s_aooi250_take_decimals(g_pmdt_d[l_ac].pmdt019,g_pmdt_d[l_ac].amt2)
                  RETURNING g_flag,g_pmdt_d[l_ac].amt2
             IF NOT g_flag THEN
                NEXT FIELD CURRENT
             END IF
          END IF
          
       ON ACTION selall
          FOR g_i = 1 TO g_pmdt_d.getLength()
             LET g_pmdt_d[g_i].sel = 'Y'
             LET g_pmdt_d[g_i].amt2 = g_pmdt_d[g_i].amt1
          END FOR
          
       ON ACTION selall_pmdsdocno
          FOR g_i = 1 TO g_pmdt_d.getLength()
             IF g_pmdt_d[g_i].pmdsdocno = g_pmdt_d[l_ac].pmdsdocno THEN
                LET g_pmdt_d[g_i].sel = 'Y'
                LET g_pmdt_d[g_i].amt2 = g_pmdt_d[g_i].amt1
             END IF
          END FOR
          
       ON ACTION unselall
          FOR g_i = 1 TO g_pmdt_d.getLength()
             LET g_pmdt_d[g_i].sel = 'N'
             LET g_pmdt_d[g_i].amt2 = 0
          END FOR
          
       ON ACTION delete_data
          CALL apmp570_01_delete_data()
          CALL apmp570_01_b_fill2()
   END INPUT

END DIALOG

DIALOG apmp570_01_display2()
   DISPLAY ARRAY g_pmdt2_d TO s_detail2_apmp570_01.* ATTRIBUTE(COUNT = g_rec_b2)
      BEFORE DISPLAY
         CALL FGL_SET_ARR_CURR(l_ac)

      BEFORE ROW
        LET l_ac = DIALOG.getCurrentRow("s_detail2_apmp570_01")
   END DISPLAY
END DIALOG

 
{</section>}
 
{<section id="apmp570_01.other_function" readonly="Y" >}

PUBLIC FUNCTION apmp570_01()

END FUNCTION

PUBLIC FUNCTION apmp570_01_create_temp_table()
DEFINE r_success         LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   IF NOT apmp570_01_drop_temp_table() THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   CREATE TEMP TABLE apmp570_01_temp(
      pmdsdocno            LIKE pmds_t.pmdsdocno,
      pmdsdocdt            LIKE pmds_t.pmdsdocdt,
      pmds007              LIKE pmds_t.pmds007,
      pmdtseq              LIKE pmdt_t.pmdtseq,
      pmdt006              LIKE pmdt_t.pmdt006,
      pmdt007              LIKE pmdt_t.pmdt007,
      pmdt009              LIKE pmdt_t.pmdt009,
      pmdt010              LIKE pmdt_t.pmdt010,
      pmdt019              LIKE pmdt_t.pmdt019,
      pmdt020              LIKE pmdt_t.pmdt020,
      pmdt021              LIKE pmdt_t.pmdt021,
      pmdt022              LIKE pmdt_t.pmdt022,
      pmdt016              LIKE pmdt_t.pmdt016,
      pmdt017              LIKE pmdt_t.pmdt017,
      pmdt018              LIKE pmdt_t.pmdt018,
      pmdt063              LIKE pmdt_t.pmdt063,
      pmdt026              LIKE pmdt_t.pmdt026,
      amt1                 LIKE pmdt_t.pmdt020,
      amt2                 LIKE pmdt_t.pmdt020,
      pmdt059              LIKE pmdt_t.pmdt059,
      pmds028              LIKE pmds_t.pmds028
      )  #161230-00020#1 add pmds028

   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create apmp570_01_temp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   #160120-00002#2 s983961--add(s)
   CREATE TEMP TABLE p570_lock_t(  #160727-00019#12   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 p570_01_lock_b_t ——> p570_lock_t
      pmdtdocno      LIKE pmdt_t.pmdtdocno,     #請購單號 
      pmdtseq        LIKE pmdt_t.pmdtseq        #請購項次 
   )
   #160120-00002#2 s983961--add(s)
   
   RETURN r_success
END FUNCTION

PUBLIC FUNCTION apmp570_01_drop_temp_table()
DEFINE r_success          LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   DROP TABLE apmp570_01_temp

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop apmp570_01_temp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   #160120-00002#2 s983961--add(s)   
   DROP TABLE p570_lock_t;  #160727-00019#12   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 p570_01_lock_b_t ——> p570_lock_t
   #160120-00002#2 s983961--add(e)   
   RETURN r_success
END FUNCTION
#顯示對收貨資料查詢的結果
PUBLIC FUNCTION apmp570_01_b_fill(p_wc)
DEFINE p_wc         STRING
DEFINE l_sql        STRING
DEFINE l_ac_t       LIKE type_t.num5
DEFINE l_amt        LIKE pmdt_t.pmdt020
DEFINE l_pmdt053    LIKE pmdt_t.pmdt053
DEFINE l_pmdt054    LIKE pmdt_t.pmdt054
DEFINE l_pmdt055    LIKE pmdt_t.pmdt055
DEFINE l_success    LIKE type_t.num5
#160120-00002#2 s983961--add(s) 
DEFINE l_pmdtdocno  LIKE pmdt_t.pmdtdocno
DEFINE l_pmdtseq    LIKE pmdt_t.pmdtseq
#160120-00002#2 s983961--add(s) 
DEFINE l_pmds028    LIKE pmds_t.pmds028   #161207-00033#21

   IF cl_null(p_wc) THEN
      LET p_wc = ' 1=1'
   END IF
   
   LET g_input_type = '1'
   
   #待入庫資料
   LET l_sql = "SELECT UNIQUE 'N',pmdsdocno,pmdsdocdt,pmds007,a.pmaal004, ",
               "       pmdtseq,pmdt006,b.imaal003,b.imaal004,pmdt007,pmdt009,i.oocql004, ",
               "       pmdt010,pmdt019,c.oocal003,pmdt020,pmdt021,d.oocal003, ",
               "       pmdt022,pmdt016,e.inayl003,pmdt017,f.inab003,pmdt018,pmdt063, ",
               "       pmdt026,0,0,pmdt059, ",
               "       pmdt053,pmdt054,pmdt055,pmds028 ",  #161207-00033#21 add pmds028
               "  FROM pmds_t ",
               "       LEFT OUTER JOIN pmaal_t a ON a.pmaalent = pmdsent AND a.pmaal001 = pmds007 AND a.pmaal002 = '",g_dlang,"'",
               "      ,pmdt_t ",
               "       LEFT OUTER JOIN imaal_t b ON b.imaalent = pmdtent AND b.imaal001 = pmdt006 AND b.imaal002 = '",g_dlang,"'",
               "       LEFT OUTER JOIN oocal_t c ON c.oocalent = pmdtent AND c.oocal001 = pmdt019 AND c.oocal002 = '",g_dlang,"'",
               "       LEFT OUTER JOIN oocal_t d ON d.oocalent = pmdtent AND d.oocal001 = pmdt021 AND d.oocal002 = '",g_dlang,"'",
               "       LEFT OUTER JOIN inayl_t e ON e.inaylent = pmdtent AND e.inayl001 = pmdt016 AND e.inayl002 = '",g_dlang,"'",
               "       LEFT OUTER JOIN inab_t  f ON f.inabent  = pmdtent AND f.inabsite = pmdtsite AND f.inab001  = pmdt016 AND f.inab002  = pmdt017 ",
               "       LEFT OUTER JOIN inac_t  g ON g.inacent  = pmdtent AND g.inacsite = pmdtsite AND g.inac001  = pmdt016 AND g.inac002  = pmdt017 ",
               "       LEFT OUTER JOIN imaf_t  h ON h.imafent  = pmdtent AND h.imafsite = pmdtsite AND h.imaf001  = pmdt006 ",
               "       LEFT OUTER JOIN oocql_t i ON i.oocqlent = pmdtent AND i.oocql001 = '221' AND i.oocql002 = pmdt009 AND i.oocql003 = '",g_dlang,"'",
               " WHERE pmdsent = pmdtent ",
               "   AND pmdsdocno = pmdtdocno ",
               "   AND pmds000 IN ('1','2','8','9') ",   #採購收貨、無採購收貨、委外採購收貨、重覆性生產收貨
               "   AND pmdsstus = 'Y' ",
               "   AND pmdsent = ",g_enterprise,
               "   AND pmdssite = '",g_site,"'",
               "   AND ",p_wc CLIPPED,
               "   AND (pmdsdocno,pmdtseq) NOT IN(SELECT pmdsdocno,pmdtseq FROM apmp570_01_temp)"
   
   LET l_sql = l_sql CLIPPED, " ORDER BY pmdsdocno,pmdtseq"     
   
   PREPARE apmp570_01_sel_d1 FROM l_sql
   DECLARE apmp570_01_b_fill_curs_d1 CURSOR FOR apmp570_01_sel_d1
   
   CALL g_pmdt_d.clear()

   LET l_ac_t = l_ac
   LET l_ac = 1
   ERROR "Searching!"

   FOREACH apmp570_01_b_fill_curs_d1 INTO g_pmdt_d[l_ac].sel,g_pmdt_d[l_ac].pmdsdocno,g_pmdt_d[l_ac].pmdsdocdt,
                                          g_pmdt_d[l_ac].pmds007,g_pmdt_d[l_ac].pmds007_desc,g_pmdt_d[l_ac].pmdtseq,
                                          g_pmdt_d[l_ac].pmdt006,g_pmdt_d[l_ac].pmdt006_desc,g_pmdt_d[l_ac].pmdt006_desc_desc,
                                          g_pmdt_d[l_ac].pmdt007,g_pmdt_d[l_ac].pmdt009,g_pmdt_d[l_ac].pmdt009_desc,
                                          g_pmdt_d[l_ac].pmdt010,g_pmdt_d[l_ac].pmdt019,g_pmdt_d[l_ac].pmdt019_desc,
                                          g_pmdt_d[l_ac].pmdt020,g_pmdt_d[l_ac].pmdt021,g_pmdt_d[l_ac].pmdt021_desc,
                                          g_pmdt_d[l_ac].pmdt022,g_pmdt_d[l_ac].pmdt016,g_pmdt_d[l_ac].pmdt016_desc,
                                          g_pmdt_d[l_ac].pmdt017,g_pmdt_d[l_ac].pmdt017_desc,g_pmdt_d[l_ac].pmdt018,
                                          g_pmdt_d[l_ac].pmdt063,g_pmdt_d[l_ac].pmdt026,g_pmdt_d[l_ac].amt1,
                                          g_pmdt_d[l_ac].amt2,g_pmdt_d[l_ac].pmdt059,
                                          l_pmdt053,l_pmdt054,l_pmdt055,l_pmds028   #161207-00033#21 add pmds028
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:apmp570_01_b_fill_curs_d1"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      #160120-00002#2 s983961--add(s) 
      #檢查請購單的資料是否已經被lock 
      LET l_pmdtdocno = '' 
      LET l_pmdtseq   = '' 
      LET l_sql = "SELECT pmdtdocno,pmdtseq ", 
                  "  FROM pmdt_t ", 
                  " WHERE pmdtent   = '",g_enterprise,"' ", 
                  "   AND pmdtdocno = '",g_pmdt_d[l_ac].pmdsdocno,"' ", 
                  "   AND pmdtseq   = '",g_pmdt_d[l_ac].pmdtseq,"' ", 
                  "   FOR UPDATE SKIP LOCKED " 
      PREPARE apmp570_01_chk_locked_prep FROM l_sql 
      EXECUTE apmp570_01_chk_locked_prep INTO l_pmdtdocno,l_pmdtseq 
      IF cl_null(l_pmdtdocno) AND cl_null(l_pmdtseq) THEN 
         CONTINUE FOREACH 
      END IF 
      #160120-00002#2 s983961--add(s) 
      
      #產品特徵說明
      CALL s_feature_description(g_pmdt_d[l_ac].pmdt006,g_pmdt_d[l_ac].pmdt007)
           RETURNING l_success,g_pmdt_d[l_ac].pmdt007_desc
      
      IF cl_null(l_pmdt053) THEN LET l_pmdt053 = 0 END IF
      IF cl_null(l_pmdt054) THEN LET l_pmdt054 = 0 END IF
      IF cl_null(l_pmdt055) THEN LET l_pmdt055 = 0 END IF
      
      #已打入庫未確認數量(計算待入庫數量使用)
      LET l_amt = 0
      SELECT SUM(pmdt020) INTO l_amt
        FROM pmds_t,pmdt_t
       WHERE pmdsent = pmdtent
         AND pmdsdocno = pmdtdocno
         AND pmdsstus = 'N'
         AND pmds006 = g_pmdt_d[l_ac].pmdsdocno
         AND pmdt002 = g_pmdt_d[l_ac].pmdtseq
         AND pmds000 IN ('6','12','13')
      IF cl_null(l_amt) THEN LET l_amt = 0 END IF
      
      #待入庫數量
      #20151102 by stellar modify 151102-00027#1 ----- (S)
#      LET g_pmdt_d[l_ac].amt1 = l_pmdt053 - l_pmdt054 - l_pmdt055 - l_amt
      LET g_pmdt_d[l_ac].amt1 = l_pmdt053 - l_pmdt054 - l_amt
      #20151102 by stellar modify 151102-00027#1 ----- (E)
      
      #待入庫數量<=0，就不顯示此筆資料
      IF g_pmdt_d[l_ac].amt1 <= 0 THEN
         CONTINUE FOREACH
      END IF
      
      #161207-00033#21-S
      IF NOT cl_null(l_pmds028) THEN
         CALL s_desc_get_oneturn_guest_desc(l_pmds028) RETURNING g_pmdt_d[l_ac].pmds007_desc
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
   CALL g_pmdt_d.deleteElement(l_ac)
   LET l_ac = l_ac_t
   CLOSE apmp570_01_b_fill_curs_d1
   FREE apmp570_01_sel_d1
   
   #待驗資料   
   LET l_sql = "SELECT UNIQUE pmdsdocno,pmdsdocdt,pmds007,a.pmaal004, ",
               "       pmdtseq,pmdt006,b.imaal003,b.imaal004,pmdt007,pmdt009,i.oocql004, ",
               "       pmdt010,pmdt019,c.oocal003,pmdt020,pmdt021,d.oocal003, ",
               "       pmdt022,pmdt016,e.inaa002,pmdt017,f.inab003,pmdt018,pmdt063, ",
               "       pmdt026,0,pmdt059, ",
               "       pmdt053,pmdt054,pmdt055,pmds028 ",   #161207-00033#21 add pmds028
               "  FROM pmds_t ",
               "       LEFT OUTER JOIN pmaal_t a ON a.pmaalent = pmdsent AND a.pmaal001 = pmds007 AND a.pmaal002 = '",g_dlang,"'",
               "      ,pmdt_t ",
               "       LEFT OUTER JOIN imaal_t b ON b.imaalent = pmdtent AND b.imaal001 = pmdt006 AND b.imaal002 = '",g_dlang,"'",
               "       LEFT OUTER JOIN oocal_t c ON c.oocalent = pmdtent AND c.oocal001 = pmdt019 AND c.oocal002 = '",g_dlang,"'",
               "       LEFT OUTER JOIN oocal_t d ON d.oocalent = pmdtent AND d.oocal001 = pmdt021 AND d.oocal002 = '",g_dlang,"'",
               "       LEFT OUTER JOIN inaa_t  e ON e.inaaent  = pmdtent AND e.inaasite = pmdtsite AND e.inaa001  = pmdt016 ",
               "       LEFT OUTER JOIN inab_t  f ON f.inabent  = pmdtent AND f.inabsite = pmdtsite AND f.inab001  = pmdt016 AND f.inab002  = pmdt017 ",
               "       LEFT OUTER JOIN inac_t  g ON g.inacent  = pmdtent AND g.inacsite = pmdtsite AND g.inac001  = pmdt016 AND g.inac002  = pmdt017 ",
               "       LEFT OUTER JOIN imaf_t  h ON h.imafent  = pmdtent AND h.imafsite = pmdtsite AND h.imaf001  = pmdt006 ",
               "       LEFT OUTER JOIN oocql_t i ON i.oocqlent = pmdtent AND i.oocql001 = '221' AND i.oocql002 = pmdt009 AND i.oocql003 = '",g_dlang,"'",
               " WHERE pmdsent = pmdtent ",
               "   AND pmdsdocno = pmdtdocno ",
               "   AND pmds000 IN ('1','2') ",
               "   AND pmdsstus = 'Y' ",
               "   AND pmdsent = ",g_enterprise,   #161124-00027#1 add
               "   AND pmdssite = '",g_site,"'",
               "   AND pmdt026 = 'Y' ",
               "   AND ",p_wc CLIPPED,
               "   AND (pmdsdocno,pmdtseq) NOT IN(SELECT pmdsdocno,pmdtseq FROM apmp570_01_temp)"
              
   LET l_sql = l_sql CLIPPED, " ORDER BY pmdsdocno,pmdtseq"     
   
   PREPARE apmp570_01_sel_d2 FROM l_sql
   DECLARE apmp570_01_b_fill_curs_d2 CURSOR FOR apmp570_01_sel_d2
   
   CALL g_pmdt2_d.clear()

   LET l_ac_t = l_ac
   LET l_ac = 1
   ERROR "Searching!"

   FOREACH apmp570_01_b_fill_curs_d2 INTO g_pmdt2_d[l_ac].pmdsdocno,g_pmdt2_d[l_ac].pmdsdocdt,
                                          g_pmdt2_d[l_ac].pmds007,g_pmdt2_d[l_ac].pmds007_desc,g_pmdt2_d[l_ac].pmdtseq,
                                          g_pmdt2_d[l_ac].pmdt006,g_pmdt2_d[l_ac].pmdt006_desc,g_pmdt2_d[l_ac].pmdt006_desc_desc,
                                          g_pmdt2_d[l_ac].pmdt007,g_pmdt2_d[l_ac].pmdt009,g_pmdt2_d[l_ac].pmdt009_desc,
                                          g_pmdt2_d[l_ac].pmdt010,g_pmdt2_d[l_ac].pmdt019,g_pmdt2_d[l_ac].pmdt019_desc,
                                          g_pmdt2_d[l_ac].pmdt020,g_pmdt2_d[l_ac].pmdt021,g_pmdt2_d[l_ac].pmdt021_desc,
                                          g_pmdt2_d[l_ac].pmdt022,g_pmdt2_d[l_ac].pmdt016,g_pmdt2_d[l_ac].pmdt016_desc,
                                          g_pmdt2_d[l_ac].pmdt017,g_pmdt2_d[l_ac].pmdt017_desc,g_pmdt2_d[l_ac].pmdt018,
                                          g_pmdt2_d[l_ac].pmdt063,g_pmdt2_d[l_ac].pmdt026,g_pmdt2_d[l_ac].amt1,
                                          g_pmdt2_d[l_ac].pmdt059,
                                          l_pmdt053,l_pmdt054,l_pmdt055,l_pmds028  #161207-00033#21 add pmds028
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:apmp570_01_b_fill_curs_d2"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      #產品特徵說明
      CALL s_feature_description(g_pmdt2_d[l_ac].pmdt006,g_pmdt2_d[l_ac].pmdt007)
           RETURNING l_success,g_pmdt2_d[l_ac].pmdt007_desc
      
      IF cl_null(l_pmdt053) THEN LET l_pmdt053 = 0 END IF
      IF cl_null(l_pmdt054) THEN LET l_pmdt054 = 0 END IF
      IF cl_null(l_pmdt055) THEN LET l_pmdt055 = 0 END IF
      
      #待驗數量=收貨數量-(允收數量+驗退量)
      LET g_pmdt2_d[l_ac].amt1 = g_pmdt2_d[l_ac].pmdt020 - (l_pmdt053 + l_pmdt055)
      #待驗數量<=0，就不顯示此筆資料
      IF g_pmdt2_d[l_ac].amt1 <= 0 THEN
         CONTINUE FOREACH
      END IF
      #161207-00033#21-S
      IF NOT cl_null(l_pmds028) THEN
         CALL s_desc_get_oneturn_guest_desc(l_pmds028) RETURNING g_pmdt2_d[l_ac].pmds007_desc
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
   
   LET g_rec_b2 = l_ac - 1
   CALL g_pmdt2_d.deleteElement(l_ac)
   LET l_ac = l_ac_t
   CLOSE apmp570_01_b_fill_curs_d2
   FREE apmp570_01_sel_d2
   
   IF l_ac > g_pmdt_d.getLength() THEN
      LET l_ac = g_pmdt_d.getLength()
   END IF
   IF cl_null(l_ac) OR l_ac = 0 THEN
      LET l_ac = 1
   END IF
END FUNCTION
#顯示收貨底稿資料
PUBLIC FUNCTION apmp570_01_b_fill2()
DEFINE l_sql        STRING
DEFINE l_ac_t       LIKE type_t.num5
DEFINE l_success    LIKE type_t.num5
DEFINE l_pmds028    LIKE pmds_t.pmds028   #161207-00033#21
   
   LET g_input_type = '2'
   
   LET l_sql = "SELECT 'N',pmdsdocno,pmdsdocdt,pmds007,a.pmaal004, ",
               "       pmdtseq,pmdt006,b.imaal003,b.imaal004,pmdt007,pmdt009,i.oocql004, ",
               "       pmdt010,pmdt019,c.oocal003,pmdt020,pmdt021,d.oocal003, ",
               "       pmdt022,pmdt016,e.inayl003,pmdt017,f.inab003,pmdt018,pmdt063, ",
               "       pmdt026,amt1,amt2,pmdt059,pmds028 ", #161207-00033#21 add pmds028
               "  FROM apmp570_01_temp ",
               "       LEFT OUTER JOIN pmaal_t a ON a.pmaalent = ",g_enterprise," AND a.pmaal001 = pmds007 AND a.pmaal002 = '",g_dlang,"'",
               "       LEFT OUTER JOIN imaal_t b ON b.imaalent = ",g_enterprise," AND b.imaal001 = pmdt006 AND b.imaal002 = '",g_dlang,"'",
               "       LEFT OUTER JOIN oocal_t c ON c.oocalent = ",g_enterprise," AND c.oocal001 = pmdt019 AND c.oocal002 = '",g_dlang,"'",
               "       LEFT OUTER JOIN oocal_t d ON d.oocalent = ",g_enterprise," AND d.oocal001 = pmdt021 AND d.oocal002 = '",g_dlang,"'",
               "       LEFT OUTER JOIN inayl_t e ON e.inaylent = ",g_enterprise," AND e.inayl001 = pmdt016 AND e.inayl002 = '",g_dlang,"'",
               "       LEFT OUTER JOIN inab_t  f ON f.inabent  = ",g_enterprise," AND f.inabsite = '",g_site,"' AND f.inab001  = pmdt016 AND f.inab002  = pmdt017 ", 
               "       LEFT OUTER JOIN imaf_t  h ON h.imafent  = ",g_enterprise," AND h.imafsite = '",g_site,"' AND h.imaf001  = pmdt006 ",
               "       LEFT OUTER JOIN oocql_t i ON i.oocqlent = ",g_enterprise," AND i.oocql001 = '221' AND i.oocql002 = pmdt009 AND i.oocql003 = '",g_dlang,"'"

   PREPARE apmp570_01_temp_sel_d1 FROM l_sql
   DECLARE apmp570_01_temp_b_fill_curs_d1 CURSOR FOR apmp570_01_temp_sel_d1
   
   CALL g_pmdt_d.clear()
   CALL g_pmdt2_d.clear()

   LET l_ac_t = l_ac
   LET l_ac = 1
   ERROR "Searching!"

   FOREACH apmp570_01_temp_b_fill_curs_d1 INTO g_pmdt_d[l_ac].sel,g_pmdt_d[l_ac].pmdsdocno,g_pmdt_d[l_ac].pmdsdocdt,
                                               g_pmdt_d[l_ac].pmds007,g_pmdt_d[l_ac].pmds007_desc,g_pmdt_d[l_ac].pmdtseq,
                                               g_pmdt_d[l_ac].pmdt006,g_pmdt_d[l_ac].pmdt006_desc,g_pmdt_d[l_ac].pmdt006_desc_desc,
                                               g_pmdt_d[l_ac].pmdt007,g_pmdt_d[l_ac].pmdt009,g_pmdt_d[l_ac].pmdt009_desc,
                                               g_pmdt_d[l_ac].pmdt010,g_pmdt_d[l_ac].pmdt019,g_pmdt_d[l_ac].pmdt019_desc,
                                               g_pmdt_d[l_ac].pmdt020,g_pmdt_d[l_ac].pmdt021,g_pmdt_d[l_ac].pmdt021_desc,
                                               g_pmdt_d[l_ac].pmdt022,g_pmdt_d[l_ac].pmdt016,g_pmdt_d[l_ac].pmdt016_desc,
                                               g_pmdt_d[l_ac].pmdt017,g_pmdt_d[l_ac].pmdt017_desc,g_pmdt_d[l_ac].pmdt018,
                                               g_pmdt_d[l_ac].pmdt063,g_pmdt_d[l_ac].pmdt026,g_pmdt_d[l_ac].amt1,
                                               g_pmdt_d[l_ac].amt2,g_pmdt_d[l_ac].pmdt059,l_pmds028   #161207-00033#21 add pmds028
   
      IF SQLCA.sqlcode THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:apmp570_01_temp_b_fill_curs_d1"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      #產品特徵說明
      CALL s_feature_description(g_pmdt_d[l_ac].pmdt006,g_pmdt_d[l_ac].pmdt007)
           RETURNING l_success,g_pmdt_d[l_ac].pmdt007_desc
      
      #161207-00033#21-S      
      IF NOT cl_null(l_pmds028) THEN
         CALL s_desc_get_oneturn_guest_desc(l_pmds028) RETURNING g_pmdt_d[l_ac].pmds007_desc
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
   CALL g_pmdt_d.deleteElement(l_ac)
   LET l_ac = l_ac_t
   CLOSE apmp570_01_temp_b_fill_curs_d1
   FREE apmp570_01_temp_sel_d1
   
   IF l_ac > g_pmdt_d.getLength() THEN
      LET l_ac = g_pmdt_d.getLength()
   END IF
   IF cl_null(l_ac) OR l_ac = 0 THEN
      LET l_ac = 1
   END IF
END FUNCTION

PUBLIC FUNCTION apmp570_01_save_data()
DEFINE l_i     LIKE type_t.num5
#160120-00002#2 s983961--add(s)
DEFINE l_cnt       LIKE type_t.num5
DEFINE l_sql       STRING
DEFINE l_pmdtdocno LIKE pmdt_t.pmdtdocno
DEFINE l_pmdtseq   LIKE pmdt_t.pmdtseq
DEFINE l_where     STRING
#160120-00002#2 s983961--add(e)
DEFINE l_pmds028   LIKE pmds_t.pmds028  #161230-00020#1

   FOR l_i = 1 TO g_pmdt_d.getLength()
      IF g_pmdt_d[l_i].sel = 'Y' THEN
         #161230-00020#1-S
         SELECT pmds028 INTO l_pmds028 FROM pmds_t
          WHERE pmdsent=g_enterprise AND pmdsdocno=g_pmdt_d[l_i].pmdsdocno 
         #161230-00020#1-E          
         INSERT INTO apmp570_01_temp
            (pmdsdocno,pmdsdocdt,pmds007,pmdtseq,pmdt006,pmdt007,pmdt009,pmdt010,pmdt019,pmdt020,
             pmdt021,pmdt022,pmdt016,pmdt017,pmdt018,pmdt063,pmdt026,amt1,amt2,pmdt059,pmds028)  #161230-00020#1
         VALUES
            (g_pmdt_d[l_i].pmdsdocno,g_pmdt_d[l_i].pmdsdocdt,g_pmdt_d[l_i].pmds007,
             g_pmdt_d[l_i].pmdtseq,g_pmdt_d[l_i].pmdt006,g_pmdt_d[l_i].pmdt007,
             g_pmdt_d[l_i].pmdt009,g_pmdt_d[l_i].pmdt010,g_pmdt_d[l_i].pmdt019,
             g_pmdt_d[l_i].pmdt020,g_pmdt_d[l_i].pmdt021,g_pmdt_d[l_i].pmdt022,
             g_pmdt_d[l_i].pmdt016,g_pmdt_d[l_i].pmdt017,g_pmdt_d[l_i].pmdt018,
             g_pmdt_d[l_i].pmdt063,g_pmdt_d[l_i].pmdt026,g_pmdt_d[l_i].amt1,
             g_pmdt_d[l_i].amt2,g_pmdt_d[l_i].pmdt059,l_pmds028)  #161230-00020#1                         
         IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'ins apmp570_01_temp'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            EXIT FOR
         END IF
         #160120-00002#2 s983961--add(s)
         LET l_cnt = 0
         SELECT COUNT(*) INTO l_cnt
           FROM p570_lock_t  #160727-00019#12   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 p570_01_lock_b_t ——> p570_lock_t
          WHERE pmdtdocno = g_pmdt_d[l_i].pmdsdocno
            AND pmdtseq   = g_pmdt_d[l_i].pmdtseq
         IF cl_null(l_cnt) OR l_cnt = 0 THEN
            INSERT INTO p570_lock_t VALUES(g_pmdt_d[l_i].pmdsdocno,g_pmdt_d[l_i].pmdtseq)  #160727-00019#12   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 p570_01_lock_b_t ——> p570_lock_t
         END IF
         #160120-00002#2 s983961--add(e)
      END IF
   END FOR
   
   #mark--160706-00037#3 By shiun--(S)
#   #160120-00002#2 s983961--add(s)
#   LET l_sql = "SELECT pmdtdocno,pmdtseq ",
#               "  FROM p570_lock_t ",  #160727-00019#12   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 p570_01_lock_b_t ——> p570_lock_t
#               " ORDER BY pmdtdocno,pmdtseq "
#   PREPARE apmp570_lock_prep FROM l_sql
#   DECLARE apmp570_lock_curs CURSOR FOR apmp570_lock_prep
#
#   LET l_sql = "SELECT pmdtdocno,pmdtseq ",
#               "  FROM pmdt_t ",
#               " WHERE "
#
#   LET l_where = ''
#   FOREACH apmp570_lock_curs INTO l_pmdtdocno,l_pmdtseq
#      IF cl_null(l_where) THEN
#         LET l_where = "(pmdtdocno = '",l_pmdtdocno,"' AND pmdtseq = '",l_pmdtseq,"') "
#      ELSE
#         LET l_where = l_where," OR ","(pmdtdocno = '",l_pmdtdocno,"' AND pmdtseq = '",l_pmdtseq,"') "
#      END IF
#   END FOREACH
#
#   LET l_sql = l_sql,l_where," FOR UPDATE "
#   PREPARE apmp570_lock_body_prep FROM l_sql 
#   DECLARE apmp570_lock_body_curs CURSOR FOR apmp570_lock_body_prep
#   OPEN apmp570_lock_body_curs
#   #160120-00002#2 s983961--add(e)
   #mark--160706-00037#3 By shiun--(E)
END FUNCTION

PUBLIC FUNCTION apmp570_01_delete_data()
DEFINE l_i     LIKE type_t.num5
   
   FOR l_i = 1 TO g_pmdt_d.getLength()
      IF g_pmdt_d[l_i].sel = 'Y' THEN
         DELETE FROM apmp570_01_temp
          WHERE pmdsdocno = g_pmdt_d[l_i].pmdsdocno
            AND pmdtseq = g_pmdt_d[l_i].pmdtseq
         IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'del apmp570_01_temp'
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOR
         END IF
         #160120-00002#1 s983961--add(s)
         DELETE FROM p570_lock_t  #160727-00019#12   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 p570_01_lock_b_t ——> p570_lock_t
          WHERE pmdtdocno = g_pmdt_d[l_i].pmdsdocno
            AND pmdtseq   = g_pmdt_d[l_i].pmdtseq
         #160120-00002#1 s983961--add(e)
      END IF
   END FOR
   
END FUNCTION

PUBLIC FUNCTION apmp570_01_set_entry_b()
   CALL cl_set_comp_entry("amt2_d1_01",TRUE)
END FUNCTION

PUBLIC FUNCTION apmp570_01_set_no_entry_b()
   IF NOT cl_null(g_input_type) AND g_input_type = '2' THEN
      CALL cl_set_comp_entry("amt2_d1_01",FALSE)
   END IF
END FUNCTION

PUBLIC FUNCTION apmp570_01_delete_temp_table()
   DELETE FROM apmp570_01_temp
END FUNCTION

PUBLIC FUNCTION apmp570_01_set_required_b()
   IF g_pmdt_d[l_ac].sel = 'Y' THEN
      CALL cl_set_comp_required("amt2_d1_01",TRUE)
   END IF
END FUNCTION

PUBLIC FUNCTION apmp570_01_set_no_required_b()
   CALL cl_set_comp_required("amt2_d1_01",FALSE)
END FUNCTION

 
{</section>}
 
