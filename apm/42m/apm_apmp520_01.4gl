#該程式未解開Section, 採用最新樣板產出!
{<section id="apmp520_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0015(2016-11-29 16:42:32), PR版次:0015(2017-02-06 11:26:30)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000192
#+ Filename...: apmp520_01
#+ Description: 引導式收貨處理作業-待交資料
#+ Creator....: 01752(2014-06-16 13:59:30)
#+ Modifier...: 01258 -SD/PR- 05384
 
{</section>}
 
{<section id="apmp520_01.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"
#160727-00019#11  2016/08/02  By 08734    临时表长度超过15码的减少到15码以下 p520_01_lock_b_t ——> p520_lock_t
#160815-00014#1   2016/08/23  By Sarah    判別D-BAS-0074參數的處理段已經組到SQL WHERE條件中,這邊的判斷拿掉
#160908-00038#1   2016/09/02  By 02097    计算待交数量时，未考虑收货单上面的仓退换货量
#161124-00054#1   2016/11/24  By lixiang  第一步中预设可收货数量时，计算其他单据中已存在的数量，应匹配单据类型pmds000是收货单的单据
#161129-00037#1   2016/11/29  By wuxja    增加库存管理特征栏位
#161205-00023#1   2016/12/19  BY 08993    18主机5区ENT=99查看收货底稿，修改未来数据页签的供应商简称没有带出对应资料显示
#161207-00033#21  2016/12/20  By lixh     一次性交易對象顯示說明，所有的客戶/供應商欄位都應該處理
#170116-00051#1   2017/01/16  By lixh     apmp520_01_temp临时表增加pmdl028(#161207-00033#21漏加)
#161230-00019#2   2017/02/02  By shiun    引導式作業一次性交易對象處理，需加上對象識別碼為匯總條件，一次性交易對象不同識別碼者需拆單
#end add-point
#add-point:填寫註解說明(客製用) name="main.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="main.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
#add-point:增加匯入變數檔 name="global.inc"
GLOBALS "../../apm/4gl/apmp520_01.inc"
#end add-point
 
{</section>}
 
{<section id="apmp520_01.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
 TYPE type_pmdo RECORD
    sel                LIKE type_t.chr1,
    pmdl004            LIKE pmdl_t.pmdl004,
    pmdl004_desc       LIKE pmaal_t.pmaal004,
    pmdodocno          LIKE pmdo_t.pmdodocno,
    pmdoseq            LIKE pmdo_t.pmdoseq,
    pmdoseq1           LIKE pmdo_t.pmdoseq1,
    pmdoseq2           LIKE pmdo_t.pmdoseq2,
    pmdo003            LIKE pmdo_t.pmdo003,
    pmdo001            LIKE pmdo_t.pmdo001,
    pmdo001_desc       LIKE imaal_t.imaal003,
    pmdo001_desc_desc  LIKE imaal_t.imaal004,
    pmdo002            LIKE pmdo_t.pmdo002,
    pmdo004            LIKE pmdo_t.pmdo004,
    pmdo004_desc       LIKE oocal_t.oocal003,
    pmdo012            LIKE pmdo_t.pmdo012,
    pmdo006            LIKE pmdo_t.pmdo006,
    days               LIKE type_t.num5,
    pmdt020            LIKE pmdt_t.pmdt020,
    pmdn028            LIKE pmdn_t.pmdn028,
    pmdn028_desc       LIKE inaa_t.inaa002,
    pmdn029            LIKE pmdn_t.pmdn029,
    pmdn029_desc       LIKE inab_t.inab003,
    pmdn030            LIKE pmdn_t.pmdn030,
    pmdn053            LIKE pmdn_t.pmdn053,    #161129-00037#1 add
    pmdn022            LIKE pmdn_t.pmdn022,
    pmdn050            LIKE pmdn_t.pmdn050
                   END RECORD
DEFINE g_pmdo_d        DYNAMIC ARRAY OF type_pmdo
DEFINE g_pmdo_d_t      type_pmdo
DEFINE g_pmdo2_d       DYNAMIC ARRAY OF type_pmdo
DEFINE g_pmdo2_d_t     type_pmdo
DEFINE g_pmdo3_d       DYNAMIC ARRAY OF type_pmdo
DEFINE g_pmdo3_d_t     type_pmdo

DEFINE l_ac            LIKE type_t.num5
DEFINE g_idx           LIKE type_t.num5
DEFINE g_rec_b         LIKE type_t.num5
DEFINE g_rec_b2        LIKE type_t.num5
DEFINE g_rec_b3        LIKE type_t.num5
DEFINE g_qty           LIKE pmdo_t.pmdo006
DEFINE g_current_page  LIKE type_t.chr1
DEFINE g_pmdl028       LIKE pmdl_t.pmdl028  #161207-00033#21
#end add-point
 
{</section>}
 
{<section id="apmp520_01.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="apmp520_01.other_dialog" >}
#逾期資料的INPUT
DIALOG apmp520_01_input()
 
   INPUT ARRAY g_pmdo_d FROM s_detail1_apmp520_01.*
       ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                 INSERT ROW = FALSE,
                 DELETE ROW = FALSE,
                 APPEND ROW = FALSE)
               
       BEFORE INPUT
          LET g_current_page = '1'
          
       BEFORE ROW
          LET l_ac = DIALOG.getCurrentRow("s_detail1_apmp520_01")
          LET g_pmdo_d_t.* = g_pmdo_d[l_ac].*
          CALL apmp520_01_set_entry_b()
          CALL apmp520_01_set_no_entry_b()
          
       AFTER FIELD sel_d1_01
          IF g_apmp520_01_input_type = '1' THEN
             IF g_pmdo_d[l_ac].sel = 'Y' THEN
                IF g_pmdo_d[l_ac].pmdt020 <= 0 THEN
                   LET g_pmdo_d[l_ac].pmdt020 = g_pmdo_d[l_ac].pmdo006
                END IF
             ELSE
                LET g_pmdo_d[l_ac].pmdt020 = 0
             END IF
             LET g_pmdo_d_t.pmdt020 = g_pmdo_d[l_ac].pmdt020
          END IF
          
       AFTER FIELD pmdt020_d1_01
          IF g_apmp520_01_input_type = '1' THEN
             IF g_pmdo_d[l_ac].sel = 'Y' THEN
                IF NOT cl_ap_chk_Range(g_pmdo_d[l_ac].pmdt020,"0.000","0","","","azz-00079",1) THEN
                   LET g_pmdo_d[l_ac].pmdt020 = g_pmdo_d_t.pmdt020
                   NEXT FIELD pmdt020_d1_01
                END IF
             END IF
             
             IF NOT cl_null(g_pmdo_d[l_ac].pmdt020) THEN
                LET g_qty = 0
                CALL s_apmt520_get_quantity(g_pmdo_d[l_ac].pmdodocno,g_pmdo_d[l_ac].pmdoseq,g_pmdo_d[l_ac].pmdoseq1,g_pmdo_d[l_ac].pmdoseq2)
                     RETURNING g_qty
                IF g_pmdo_d[l_ac].pmdt020 > g_qty THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'apm-00383'
                   LET g_errparam.extend = g_pmdo_d[l_ac].pmdt020
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   LET g_pmdo_d[l_ac].pmdt020 = g_pmdo_d_t.pmdt020
                   NEXT FIELD pmdt020_d1_01
                END IF
                IF g_pmdo_d[l_ac].pmdt020 < g_pmdo_d[l_ac].pmdo006 AND g_pmdo_d[l_ac].pmdn022 = 'N' THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'apm-00382'
                   LET g_errparam.extend = g_pmdo_d[l_ac].pmdt020
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   LET g_pmdo_d[l_ac].pmdt020 = g_pmdo_d_t.pmdt020
                   NEXT FIELD pmdt020_d1_01
                END IF
             END IF
          END IF
          
       ON ROW CHANGE 
          IF g_apmp520_01_input_type = '1' THEN
             IF g_pmdo_d[l_ac].sel = 'Y' THEN
                IF NOT cl_ap_chk_Range(g_pmdo_d[l_ac].pmdt020,"0.000","0","","","azz-00079",1) THEN
                   LET g_pmdo_d[l_ac].pmdt020 = g_pmdo_d_t.pmdt020
                   NEXT FIELD pmdt020_d1_01
                END IF
             END IF
          END IF
          
       ON ACTION selall_pmdl004
          FOR g_idx = 1 TO g_pmdo_d.getLength()
             IF g_pmdo_d[g_idx].pmdl004 = g_pmdo_d[l_ac].pmdl004 THEN
                LET g_pmdo_d[g_idx].sel = 'Y'
                IF g_pmdo_d[g_idx].pmdt020 <= 0 THEN
                   LET g_pmdo_d[g_idx].pmdt020 = g_pmdo_d[g_idx].pmdo006
                END IF
             END IF
          END FOR
          
       ON ACTION selall_pmdodocno
          FOR g_idx = 1 TO g_pmdo_d.getLength()
             IF g_pmdo_d[g_idx].pmdodocno = g_pmdo_d[l_ac].pmdodocno THEN
                LET g_pmdo_d[g_idx].sel = 'Y'
                IF g_pmdo_d[g_idx].pmdt020 <= 0 THEN
                   LET g_pmdo_d[g_idx].pmdt020 = g_pmdo_d[g_idx].pmdo006
                END IF
             END IF
          END FOR
          
       ON ACTION unselall
          FOR g_idx = 1 TO g_pmdo_d.getLength()
             LET g_pmdo_d[g_idx].sel = 'N'
             LET g_pmdo_d[g_idx].pmdt020 = 0
          END FOR
          
       ON ACTION delete_data
          CALL apmp520_01_delete_data()
          CALL apmp520_01_b_fill2()
          
       
   END INPUT

END DIALOG
#今日到廠資料的INPUT
DIALOG apmp520_01_input2()
   
   INPUT ARRAY g_pmdo2_d FROM s_detail2_apmp520_01.*
       ATTRIBUTE(COUNT = g_rec_b2,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                 INSERT ROW = FALSE,
                 DELETE ROW = FALSE,
                 APPEND ROW = FALSE)
                 
       BEFORE INPUT
          LET g_current_page = '2'
          
       BEFORE ROW
          LET l_ac = DIALOG.getCurrentRow("s_detail2_apmp520_01")
          LET g_pmdo2_d_t.* = g_pmdo2_d[l_ac].*
          CALL apmp520_01_set_entry_b()
          CALL apmp520_01_set_no_entry_b()
          
       AFTER FIELD sel_d2_01
          IF g_apmp520_01_input_type = '1' THEN
             IF g_pmdo2_d[l_ac].sel = 'Y' THEN
                IF g_pmdo2_d[l_ac].pmdt020 <= 0 THEN
                   LET g_pmdo2_d[l_ac].pmdt020 = g_pmdo2_d[l_ac].pmdo006
                END IF
             ELSE
                LET g_pmdo2_d[l_ac].pmdt020 = 0
             END IF
             LET g_pmdo2_d_t.pmdt020 = g_pmdo2_d[l_ac].pmdt020
          END IF
          
       AFTER FIELD pmdt020_d2_01
          IF g_apmp520_01_input_type = '1' THEN
             IF g_pmdo2_d[l_ac].sel = 'Y' THEN
                IF NOT cl_ap_chk_Range(g_pmdo2_d[l_ac].pmdt020,"0.000","0","","","azz-00079",1) THEN
                   LET g_pmdo2_d[l_ac].pmdt020 = g_pmdo2_d_t.pmdt020
                   NEXT FIELD pmdt020_d2_01
                END IF
             END IF
             IF NOT cl_null(g_pmdo2_d[l_ac].pmdt020) THEN
                LET g_qty = 0
                CALL s_apmt520_get_quantity(g_pmdo2_d[l_ac].pmdodocno,g_pmdo2_d[l_ac].pmdoseq,g_pmdo2_d[l_ac].pmdoseq1,g_pmdo2_d[l_ac].pmdoseq2)
                     RETURNING g_qty
                IF g_pmdo2_d[l_ac].pmdt020 > g_qty THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'apm-00383'
                   LET g_errparam.extend = g_pmdo2_d[l_ac].pmdt020
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   LET g_pmdo2_d[l_ac].pmdt020 = g_pmdo2_d_t.pmdt020
                   NEXT FIELD pmdt020_d1_01
                END IF
                IF g_pmdo2_d[l_ac].pmdt020 < g_pmdo2_d[l_ac].pmdo006 AND g_pmdo2_d[l_ac].pmdn022 = 'N' THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'apm-00382'
                   LET g_errparam.extend = g_pmdo2_d[l_ac].pmdt020
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   LET g_pmdo2_d[l_ac].pmdt020 = g_pmdo2_d_t.pmdt020
                   NEXT FIELD pmdt020_d1_01
                END IF
             END IF
          END IF
          
       ON ROW CHANGE
          IF g_apmp520_01_input_type = '1' THEN
             IF g_pmdo2_d[l_ac].sel = 'Y' THEN
                IF NOT cl_ap_chk_Range(g_pmdo2_d[l_ac].pmdt020,"0.000","0","","","azz-00079",1) THEN
                   LET g_pmdo2_d[l_ac].pmdt020 = g_pmdo2_d_t.pmdt020
                   NEXT FIELD pmdt020_d2_01
                END IF
             END IF
          END IF

       ON ACTION selall_pmdl004
          FOR g_idx = 1 TO g_pmdo2_d.getLength()
             IF g_pmdo2_d[g_idx].pmdl004 = g_pmdo2_d[l_ac].pmdl004 THEN
                LET g_pmdo2_d[g_idx].sel = 'Y'
                IF g_pmdo2_d[g_idx].pmdt020 <= 0 THEN
                   LET g_pmdo2_d[g_idx].pmdt020 = g_pmdo2_d[g_idx].pmdo006
                END IF
             END IF
          END FOR
          
       ON ACTION selall_pmdodocno
          FOR g_idx = 1 TO g_pmdo2_d.getLength()
             IF g_pmdo2_d[g_idx].pmdodocno = g_pmdo2_d[l_ac].pmdodocno THEN
                LET g_pmdo2_d[g_idx].sel = 'Y'
                IF g_pmdo2_d[g_idx].pmdt020 <= 0 THEN
                   LET g_pmdo2_d[g_idx].pmdt020 = g_pmdo2_d[g_idx].pmdo006
                END IF
             END IF
          END FOR
          
       ON ACTION unselall
          FOR g_idx = 1 TO g_pmdo2_d.getLength()
             LET g_pmdo2_d[g_idx].sel = 'N'
             LET g_pmdo2_d[g_idx].pmdt020 = 0
          END FOR
       
       ON ACTION delete_data
          CALL apmp520_01_delete_data()
          CALL apmp520_01_b_fill2()
       
   END INPUT
END DIALOG
#未來資料的INPUT
DIALOG apmp520_01_input3()
   INPUT ARRAY g_pmdo3_d FROM s_detail3_apmp520_01.*
       ATTRIBUTE(COUNT = g_rec_b3,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                 INSERT ROW = FALSE,
                 DELETE ROW = FALSE,
                 APPEND ROW = FALSE)
                 
       BEFORE INPUT
          LET g_current_page = '3'
          
       BEFORE ROW
          LET l_ac = DIALOG.getCurrentRow("s_detail3_apmp520_01")
          LET g_pmdo3_d_t.* = g_pmdo3_d[l_ac].*
          CALL apmp520_01_set_entry_b()
          CALL apmp520_01_set_no_entry_b()
          
       AFTER FIELD sel_d3_01
          IF g_apmp520_01_input_type = '1' THEN
             IF g_pmdo3_d[l_ac].sel = 'Y' THEN
                IF g_pmdo3_d[l_ac].pmdt020 <= 0 THEN
                   LET g_pmdo3_d[l_ac].pmdt020 = g_pmdo3_d[l_ac].pmdo006
                END IF
             ELSE
                LET g_pmdo3_d[l_ac].pmdt020 = 0
             END IF
             LET g_pmdo3_d_t.pmdt020 = g_pmdo3_d[l_ac].pmdt020
          END IF
          
       AFTER FIELD pmdt020_d3_01
          IF g_apmp520_01_input_type = '1' THEN
             IF g_pmdo3_d[l_ac].sel = 'Y' THEN
                IF NOT cl_ap_chk_Range(g_pmdo3_d[l_ac].pmdt020,"0.000","0","","","azz-00079",1) THEN
                   LET g_pmdo3_d[l_ac].pmdt020 = g_pmdo3_d_t.pmdt020
                   NEXT FIELD pmdt020_d3_01
                END IF
             END IF          
             IF NOT cl_null(g_pmdo3_d[l_ac].pmdt020) THEN
                LET g_qty = 0
                CALL s_apmt520_get_quantity(g_pmdo3_d[l_ac].pmdodocno,g_pmdo3_d[l_ac].pmdoseq,g_pmdo3_d[l_ac].pmdoseq1,g_pmdo3_d[l_ac].pmdoseq2)
                     RETURNING g_qty
                IF g_pmdo3_d[l_ac].pmdt020 > g_qty THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'apm-00383'
                   LET g_errparam.extend = g_pmdo3_d[l_ac].pmdt020
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   LET g_pmdo3_d[l_ac].pmdt020 = g_pmdo3_d_t.pmdt020
                   NEXT FIELD pmdt020_d1_01
                END IF
                IF g_pmdo3_d[l_ac].pmdt020 < g_pmdo3_d[l_ac].pmdo006 AND g_pmdo3_d[l_ac].pmdn022 = 'N' THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'apm-00382'
                   LET g_errparam.extend = g_pmdo3_d[l_ac].pmdt020
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   LET g_pmdo3_d[l_ac].pmdt020 = g_pmdo3_d_t.pmdt020
                   NEXT FIELD pmdt020_d1_01
                END IF
             END IF
          END IF
          
          
       ON ROW CHANGE
          IF g_apmp520_01_input_type = '1' THEN
             IF g_pmdo3_d[l_ac].sel = 'Y' THEN
                IF NOT cl_ap_chk_Range(g_pmdo3_d[l_ac].pmdt020,"0.000","0","","","azz-00079",1) THEN
                   LET g_pmdo3_d[l_ac].pmdt020 = g_pmdo3_d_t.pmdt020
                   NEXT FIELD pmdt020_d3_01
                END IF
             END IF
          END IF
          
       ON ACTION selall_pmdl004
          FOR g_idx = 1 TO g_pmdo3_d.getLength()
             IF g_pmdo3_d[g_idx].pmdl004 = g_pmdo3_d[l_ac].pmdl004 THEN
                LET g_pmdo3_d[g_idx].sel = 'Y'
                IF g_pmdo3_d[g_idx].pmdt020 <= 0 THEN
                   LET g_pmdo3_d[g_idx].pmdt020 = g_pmdo3_d[g_idx].pmdo006
                END IF
             END IF
          END FOR
          
       ON ACTION selall_pmdodocno
          FOR g_idx = 1 TO g_pmdo3_d.getLength()
             IF g_pmdo3_d[g_idx].pmdodocno = g_pmdo3_d[l_ac].pmdodocno THEN
                LET g_pmdo3_d[g_idx].sel = 'Y'
                IF g_pmdo3_d[g_idx].pmdt020 <= 0 THEN
                   LET g_pmdo3_d[g_idx].pmdt020 = g_pmdo3_d[g_idx].pmdo006
                END IF
             END IF
          END FOR
          
       ON ACTION unselall
          FOR g_idx = 1 TO g_pmdo3_d.getLength()
             LET g_pmdo3_d[g_idx].sel = 'N'
             LET g_pmdo3_d[g_idx].pmdt020 = 0
          END FOR
       
       ON ACTION delete_data
          CALL apmp520_01_delete_data()
          CALL apmp520_01_b_fill2()
       
   END INPUT
END DIALOG

 
{</section>}
 
{<section id="apmp520_01.other_function" readonly="Y" >}

PUBLIC FUNCTION apmp520_01()

END FUNCTION

PUBLIC FUNCTION apmp520_01_create_temp_table()
DEFINE r_success         LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   IF NOT apmp520_01_drop_temp_table() THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   CREATE TEMP TABLE apmp520_01_temp(
      pmdl004               VARCHAR(10),
      pmdodocno             VARCHAR(20),
      pmdoseq               INTEGER,
      pmdoseq1              INTEGER,
      pmdoseq2              INTEGER,
      pmdo003               VARCHAR(10),
      pmdo001               VARCHAR(40),
      pmdo002               VARCHAR(256),
      pmdo004               VARCHAR(10),
      pmdo012               DATE,
      pmdo006               DECIMAL(20,6),
      pmdt020               DECIMAL(20,6),
      pmdn028               VARCHAR(10),
      pmdn029               VARCHAR(10),
      pmdn030               VARCHAR(30),
      pmdn053               VARCHAR(30),       #161129-00037#1 add
      pmdn022               VARCHAR(1),
      pmdn050               VARCHAR(255),
      pmdl028               VARCHAR(20)
      
      )  #170116-00051#1 add pmdl028

   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create apmp520_01_temp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #160120-00002#1 s983961--add(s)
   CREATE TEMP TABLE p520_lock_t(   #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 p520_01_lock_b_t ——> p520_lock_t
      pmdodocno             VARCHAR(20),
      pmdoseq               INTEGER,
      pmdoseq1              INTEGER,
      pmdoseq2              INTEGER
   )
  #160120-00002#1 s983961--add(e)
  
   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create p520_lock_t'  #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 p520_01_lock_b_t ——> p520_lock_t
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

PUBLIC FUNCTION apmp520_01_drop_temp_table()
DEFINE r_success          LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   DROP TABLE apmp520_01_temp

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop apmp520_01_temp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #160120-00002#1 s983961--add(s)
   DROP TABLE p520_lock_t;   #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 p520_01_lock_b_t ——> p520_lock_t
   #160120-00002#1 s983961--add(e)
   
   RETURN r_success
END FUNCTION
# 畫面資料初始化
PUBLIC FUNCTION apmp520_01_init()

   WHENEVER ERROR CONTINUE
   
   CALL cl_set_combo_scc('pmdo003_d1_01','2055')
   CALL cl_set_combo_scc('pmdo003_d2_01','2055')
   CALL cl_set_combo_scc('pmdo003_d3_01','2055')
END FUNCTION
#顯示對採購資料查詢的結果
PUBLIC FUNCTION apmp520_01_b_fill(p_wc,p_wc2)
DEFINE p_wc         STRING
DEFINE p_wc2        STRING
DEFINE l_sql        STRING
DEFINE l_ac_t       LIKE type_t.num5
DEFINE l_slip       LIKE type_t.chr10
DEFINE l_ooac004    LIKE ooac_t.ooac004
DEFINE l_success    LIKE type_t.num5
#160120-00002#1 s983961--add(s)
DEFINE l_pmdodocno       LIKE pmdo_t.pmdodocno #請購單號 
DEFINE l_pmdoseq         LIKE pmdo_t.pmdoseq   #請購項次
DEFINE l_pmdoseq1        LIKE pmdo_t.pmdoseq1   #請購項次
DEFINE l_pmdoseq2        LIKE pmdo_t.pmdoseq2   #請購項次
#160120-00002#1 s983961--add(e)

   WHENEVER ERROR CONTINUE
   
   IF cl_null(p_wc) THEN
      LET p_wc = ' 1=1'
   END IF
   #--detail1-- 
   IF cl_null(p_wc2) OR p_wc2 = " 1=1" THEN
      LET l_sql = "SELECT UNIQUE 'N',pmdl004,      '',pmdodocno,pmdoseq,pmdoseq1,",
                  "                  pmdoseq2,pmdo003,pmdo001,       '',      '',",
                  "                  pmdo002, pmdo004,     '',  pmdo012,pmdo006, ",
                  "                        0,       0,pmdn028,     '',  pmdn029, ",
                  "                       '', pmdn030,pmdn053,pmdn022,pmdn050,pmdl028 ",  #161129-00037#1 add pmdn053  #161207-00033#21 add pmdl028
                  "  FROM pmdl_t,pmdn_t,pmdo_t,imaf_t ",
                  " WHERE pmdlent = pmdnent AND pmdldocno = pmdndocno",
                  "   AND pmdnent = pmdoent AND pmdndocno = pmdodocno ",
                  "   AND pmdnseq = pmdoseq ",
                  "   AND pmdoent = imafent AND pmdosite = imafsite ",
                  "   AND pmdo001 = imaf001 ",
                  "   AND pmdlent = ?",
                  "   AND pmdnsite = '",g_site CLIPPED,"'",
                  "   AND ",p_wc CLIPPED,
                  "   AND pmdlstus = 'Y'",
                  "   AND pmdn045 = '1'",
                  "   AND pmdo012 < '",g_today CLIPPED,"'"
   ELSE
      LET l_sql = "SELECT UNIQUE 'N',pmdl004,      '',pmdodocno,pmdoseq,pmdoseq1,",
                  "                  pmdoseq2,pmdo003,pmdo001,       '',      '',",
                  "                  pmdo002, pmdo004,     '',  pmdo012,pmdo006, ",
                  "                        0,       0,pmdn028,     '',  pmdn029, ",
                  "                       '', pmdn030,pmdn053,pmdn022,pmdn050,pmdl028 ",   #161129-00037#1 add pmdn053  #161207-00033#21 add pmdl028
                  "  FROM pmdl_t,pmdn_t,inac_t,pmdo_t,imaf_t ",
                  " WHERE pmdlent = pmdnent AND pmdldocno = pmdndocno",
                  "   AND pmdnent = inacent AND pmdnsite = inacsite ",
                  "   AND pmdn028 = inac001 AND pmdn029 = inac002 ",
                  "   AND pmdnent = pmdoent AND pmdndocno = pmdodocno ",
                  "   AND pmdnseq = pmdoseq ",
                  "   AND pmdoent = imafent AND pmdosite = imafsite ",
                  "   AND pmdo001 = imaf001 ",
                  "   AND pmdlent = ?",
                  "   AND pmdnsite = '",g_site CLIPPED,"'",
                  "   AND ",p_wc CLIPPED,
                  "   AND ",p_wc2 CLIPPED,
                  "   AND pmdlstus = 'Y'",
                  "   AND pmdn045 = '1'",
                  "   AND pmdo012 < '",g_today CLIPPED,"'"
   END IF
   
   LET l_sql = l_sql CLIPPED, " ORDER BY pmdo012 DESC"     
   
   PREPARE apmp520_01_sel_d1 FROM l_sql
   DECLARE apmp520_01_b_fill_curs_d1 CURSOR FOR apmp520_01_sel_d1
   
   CALL g_pmdo_d.clear()

   LET l_ac_t = l_ac
   LET l_ac = 1
   ERROR "Searching!"

   FOREACH apmp520_01_b_fill_curs_d1 USING g_enterprise INTO g_pmdo_d[l_ac].*,g_pmdl028  #161207-00033#21 add pmdl028
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:apmp520_01_b_fill_curs_d1"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      #160120-00002#1 s983961--add(s)   
      #檢查請購單的資料是否已經被lock 
      LET l_pmdodocno = '' 
      LET l_pmdoseq   = '' 
      LET l_sql = "SELECT pmdodocno,pmdoseq,pmdoseq1,pmdoseq2 ", 
                  "  FROM pmdo_t ", 
                  " WHERE pmdoent   = '",g_enterprise,"' ", 
                  "   AND pmdodocno = '",g_pmdo_d[l_ac].pmdodocno,"' ", 
                  "   AND pmdoseq   = '",g_pmdo_d[l_ac].pmdoseq,"' ",
                  "   AND pmdoseq1  = '",g_pmdo_d[l_ac].pmdoseq1,"' ",    
                  "   AND pmdoseq2  = '",g_pmdo_d[l_ac].pmdoseq2,"' ",                  
                  "   FOR UPDATE SKIP LOCKED " 
      PREPARE apmp520_01_chk_locked_prep FROM l_sql 
      EXECUTE apmp520_01_chk_locked_prep INTO l_pmdodocno,l_pmdoseq               
      IF cl_null(l_pmdodocno) AND cl_null(l_pmdoseq) THEN 
         CONTINUE FOREACH 
      END IF 
      #160120-00002#1 s983961--add(e) 
      
      IF NOT apmp520_01_chk_temp_data(g_pmdo_d[l_ac].pmdodocno,g_pmdo_d[l_ac].pmdoseq,g_pmdo_d[l_ac].pmdoseq1,g_pmdo_d[l_ac].pmdoseq2) THEN
         CONTINUE FOREACH
      END IF
      
      CALL apmp520_01_default_quantity(g_pmdo_d[l_ac].pmdodocno,g_pmdo_d[l_ac].pmdoseq,g_pmdo_d[l_ac].pmdoseq1,g_pmdo_d[l_ac].pmdoseq2) 
       RETURNING g_pmdo_d[l_ac].pmdo006
      IF g_pmdo_d[l_ac].pmdo006 = 0 THEN
         CONTINUE FOREACH
      END IF
      
      LET l_slip = ''
      CALL s_aooi200_get_slip(g_pmdo_d[l_ac].pmdodocno) RETURNING l_success,l_slip
      IF NOT l_success THEN
         CONTINUE FOREACH
      END IF
#160815-00014#1-s mark
#      LET l_ooac004 = ''
#      CALL cl_get_doc_para(g_enterprise,g_site,l_slip,'D-BAS-0074') RETURNING l_ooac004
#      IF cl_null(l_ooac004) THEN
#         CONTINUE FOREACH
#      END IF
#160815-00014#1-e mark

      LET g_pmdo_d[l_ac].days = g_today - g_pmdo_d[l_ac].pmdo012
 
      CALL apmp520_01_detail_show("'1'")
          
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
   CALL g_pmdo_d.deleteElement(l_ac)
   LET l_ac = l_ac_t
   CLOSE apmp520_01_b_fill_curs_d1
   FREE apmp520_01_sel_d1
   
   #--detail2--   
   IF cl_null(p_wc2) OR p_wc2 = " 1=1" THEN
      LET l_sql = "SELECT UNIQUE 'N',pmdl004,      '',pmdodocno,pmdoseq,pmdoseq1,",
                  "                  pmdoseq2,pmdo003,pmdo001,       '',      '',",
                  "                  pmdo002, pmdo004,     '',  pmdo012,pmdo006, ",
                  "                        0,       0,pmdn028,     '',  pmdn029, ",
                  "                       '', pmdn030,pmdn053,pmdn022,pmdn050,pmdl028 ", #161129-00037#1 add pmdn053  #161207-00033#21 add pmdl028
                  "  FROM pmdl_t,pmdn_t,pmdo_t,imaf_t ",
                  " WHERE pmdlent = pmdnent AND pmdldocno = pmdndocno",
                  "   AND pmdnent = pmdoent AND pmdndocno = pmdodocno ",
                  "   AND pmdnseq = pmdoseq ",
                  "   AND pmdoent = imafent AND pmdosite = imafsite ",
                  "   AND pmdo001 = imaf001 ",
                  "   AND pmdlent = ?",
                  "   AND pmdnsite = '",g_site CLIPPED,"'",
                  "   AND ",p_wc CLIPPED,
                  "   AND pmdlstus = 'Y'",
                  "   AND pmdn045 = '1'",
                  "   AND pmdo012 = '",g_today CLIPPED,"'"
   ELSE
      LET l_sql = "SELECT UNIQUE 'N',pmdl004,      '',pmdodocno,pmdoseq,pmdoseq1,",
                  "                  pmdoseq2,pmdo003,pmdo001,       '',      '',",
                  "                  pmdo002, pmdo004,     '',  pmdo012,pmdo006, ",
                  "                        0,       0,pmdn028,     '',  pmdn029, ",
                  "                       '', pmdn030,pmdn053,pmdn022,pmdn050,pmdl028 ",  #161129-00037#1 add pmdn053  #161207-00033#21 add pmdl028
                  "  FROM pmdl_t,pmdn_t,inac_t,pmdo_t,imaf_t ",
                  " WHERE pmdlent = pmdnent AND pmdldocno = pmdndocno",
                  "   AND pmdnent = inacent AND pmdnsite = inacsite ",
                  "   AND pmdn028 = inac001 AND pmdn029 = inac002 ",
                  "   AND pmdnent = pmdoent AND pmdndocno = pmdodocno ",
                  "   AND pmdnseq = pmdoseq ",
                  "   AND pmdoent = imafent AND pmdosite = imafsite ",
                  "   AND pmdo001 = imaf001 ",
                  "   AND pmdlent = ?",
                  "   AND pmdnsite = '",g_site CLIPPED,"'",
                  "   AND ",p_wc CLIPPED,
                  "   AND ",p_wc2 CLIPPED,
                  "   AND pmdlstus = 'Y'",
                  "   AND pmdn045 = '1'",
                  "   AND pmdo012 = '",g_today CLIPPED,"'"
   END IF
              
   PREPARE apmp520_01_sel_d2 FROM l_sql
   DECLARE apmp520_01_b_fill_curs_d2 CURSOR FOR apmp520_01_sel_d2
   
   CALL g_pmdo2_d.clear()

   LET l_ac_t = l_ac
   LET l_ac = 1
   ERROR "Searching!"

   FOREACH apmp520_01_b_fill_curs_d2 USING g_enterprise INTO g_pmdo2_d[l_ac].*,g_pmdl028  #161207-00033#21 add pmdl028
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:apmp520_01_b_fill_curs_d2"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      #160120-00002#1 s983961--add(s)   
      ##檢查請購單的資料是否已經被lock      
      LET l_pmdodocno = '' 
      LET l_pmdoseq   = '' 
      LET l_sql = "SELECT pmdodocno,pmdoseq ", 
                  "  FROM pmdo_t ", 
                  " WHERE pmdoent   = '",g_enterprise,"' ", 
                  "   AND pmdodocno = '",g_pmdo2_d[l_ac].pmdodocno,"' ", 
                  "   AND pmdoseq   = '",g_pmdo2_d[l_ac].pmdoseq,"' ", 
                  "   AND pmdoseq1  = '",g_pmdo2_d[l_ac].pmdoseq1,"' ", 
                  "   AND pmdoseq2  = '",g_pmdo2_d[l_ac].pmdoseq2,"' ", 
                  "   FOR UPDATE SKIP LOCKED " 
      PREPARE apmp520_02_chk_locked_prep FROM l_sql 
      EXECUTE apmp520_02_chk_locked_prep INTO l_pmdodocno,l_pmdoseq,l_pmdoseq1,l_pmdoseq2               
      IF cl_null(l_pmdodocno) AND cl_null(l_pmdoseq) THEN 
         CONTINUE FOREACH 
      END IF 
      #160120-00002#1 s983961--add(e) 
           
      IF NOT apmp520_01_chk_temp_data(g_pmdo2_d[l_ac].pmdodocno,g_pmdo2_d[l_ac].pmdoseq,g_pmdo2_d[l_ac].pmdoseq1,g_pmdo2_d[l_ac].pmdoseq2) THEN
         CONTINUE FOREACH
      END IF
      
      CALL apmp520_01_default_quantity(g_pmdo2_d[l_ac].pmdodocno,g_pmdo2_d[l_ac].pmdoseq,g_pmdo2_d[l_ac].pmdoseq1,g_pmdo2_d[l_ac].pmdoseq2) 
       RETURNING g_pmdo2_d[l_ac].pmdo006
      IF g_pmdo2_d[l_ac].pmdo006 = 0 THEN
         CONTINUE FOREACH
      END IF
      
      LET l_slip = ''
      CALL s_aooi200_get_slip(g_pmdo2_d[l_ac].pmdodocno) RETURNING l_success,l_slip
      IF NOT l_success THEN
         CONTINUE FOREACH
      END IF
#160815-00014#1-s mark
#      LET l_ooac004 = ''
#      CALL cl_get_doc_para(g_enterprise,g_site,l_slip,'D-BAS-0074') RETURNING l_ooac004
#      IF cl_null(l_ooac004) THEN
#         CONTINUE FOREACH
#      END IF
#160815-00014#1-e mark
      
      CALL apmp520_01_detail_show("'2'")   
          
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
   CALL g_pmdo2_d.deleteElement(l_ac)
   LET l_ac = l_ac_t
   CLOSE apmp520_01_b_fill_curs_d2
   FREE apmp520_01_sel_d2
   
   #--detail3--
   IF cl_null(p_wc2) OR p_wc2 = " 1=1" THEN
      LET l_sql = "SELECT UNIQUE 'N',pmdl004,      '',pmdodocno,pmdoseq,pmdoseq1,",
                  "                  pmdoseq2,pmdo003,pmdo001,       '',      '',",
                  "                  pmdo002, pmdo004,     '',  pmdo012,pmdo006, ",
                  "                        0,       0,pmdn028,     '',  pmdn029, ",
                  "                       '', pmdn030,pmdn053,pmdn022,pmdn050,pmdl028 ",   #161129-00037#1 add pmdn053  #161207-00033#21 add pmdl028
                  "  FROM pmdl_t,pmdn_t,pmdo_t,imaf_t ",
                  " WHERE pmdlent = pmdnent AND pmdldocno = pmdndocno",
                  "   AND pmdnent = pmdoent AND pmdndocno = pmdodocno ",
                  "   AND pmdnseq = pmdoseq ",
                  "   AND pmdoent = imafent AND pmdosite = imafsite ",
                  "   AND pmdo001 = imaf001 ",
                  "   AND pmdlent = ?",
                  "   AND pmdnsite = '",g_site CLIPPED,"'",
                  "   AND ",p_wc CLIPPED,
                  "   AND pmdlstus = 'Y'",
                  "   AND pmdn045 = '1'",
                  "   AND pmdo012 > '",g_today CLIPPED,"'"
   ELSE
      LET l_sql = "SELECT UNIQUE 'N',pmdl004,      '',pmdodocno,pmdoseq,pmdoseq1,",
                  "                  pmdoseq2,pmdo003,pmdo001,       '',      '',",
                  "                  pmdo002, pmdo004,     '',  pmdo012,pmdo006, ",
                  "                        0,       0,pmdn028,     '',  pmdn029, ",
                  "                       '', pmdn030,pmdn053,pmdn022,pmdn050,pmdl028 ",   #161129-00037#1 add pmdn053  #161207-00033#21 add pmdl028  
                  "  FROM pmdl_t,pmdn_t,inac_t,pmdo_t,imaf_t ",
                  " WHERE pmdlent = pmdnent AND pmdldocno = pmdndocno",
                  "   AND pmdnent = inacent AND pmdnsite = inacsite ",
                  "   AND pmdn028 = inac001 AND pmdn029 = inac002 ",
                  "   AND pmdnent = pmdoent AND pmdndocno = pmdodocno ",
                  "   AND pmdnseq = pmdoseq ",
                  "   AND pmdoent = imafent AND pmdosite = imafsite ",
                  "   AND pmdo001 = imaf001 ",
                  "   AND pmdlent = ?",
                  "   AND pmdnsite = '",g_site CLIPPED,"'",
                  "   AND ",p_wc CLIPPED,
                  "   AND ",p_wc2 CLIPPED,
                  "   AND pmdlstus = 'Y'",
                  "   AND pmdn045 = '1'",
                  "   AND pmdo012 > '",g_today CLIPPED,"'"
   END IF
   
   LET l_sql = l_sql CLIPPED, " ORDER BY pmdo012 "             
   
   PREPARE apmp520_01_sel_d3 FROM l_sql
   DECLARE apmp520_01_b_fill_curs_d3 CURSOR FOR apmp520_01_sel_d3
   
   CALL g_pmdo3_d.clear()

   LET l_ac_t = l_ac
   LET l_ac = 1
   ERROR "Searching!"

   FOREACH apmp520_01_b_fill_curs_d3 USING g_enterprise INTO g_pmdo3_d[l_ac].*,g_pmdl028   #161207-00033#21 add pmdl028
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:apmp520_01_b_fill_curs_d3"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      #160120-00002#1 s983961--add(s)   
      ##檢查請購單的資料是否已經被lock 
      LET l_pmdodocno = '' 
      LET l_pmdoseq   = '' 
      LET l_sql = "SELECT pmdodocno,pmdoseq ", 
                  "  FROM pmdo_t ", 
                  " WHERE pmdoent   = '",g_enterprise,"' ", 
                  "   AND pmdodocno = '",g_pmdo3_d[l_ac].pmdodocno,"' ", 
                  "   AND pmdoseq   = '",g_pmdo3_d[l_ac].pmdoseq,"' ", 
                  "   AND pmdoseq1  = '",g_pmdo3_d[l_ac].pmdoseq1,"' ", 
                  "   AND pmdoseq2  = '",g_pmdo3_d[l_ac].pmdoseq2,"' ", 
                  "   FOR UPDATE SKIP LOCKED " 
      PREPARE apmp520_03_chk_locked_prep FROM l_sql 
      EXECUTE apmp520_03_chk_locked_prep INTO l_pmdodocno,l_pmdoseq,l_pmdoseq1,l_pmdoseq2               
      IF cl_null(l_pmdodocno) AND cl_null(l_pmdoseq) THEN 
         CONTINUE FOREACH 
      END IF 
      #160120-00002#1 s983961--add(e) 
      
      IF NOT apmp520_01_chk_temp_data(g_pmdo3_d[l_ac].pmdodocno,g_pmdo3_d[l_ac].pmdoseq,g_pmdo3_d[l_ac].pmdoseq1,g_pmdo3_d[l_ac].pmdoseq2) THEN
         CONTINUE FOREACH
      END IF
      

      
      CALL apmp520_01_default_quantity(g_pmdo3_d[l_ac].pmdodocno,g_pmdo3_d[l_ac].pmdoseq,g_pmdo3_d[l_ac].pmdoseq1,g_pmdo3_d[l_ac].pmdoseq2) 
       RETURNING g_pmdo3_d[l_ac].pmdo006
      IF g_pmdo3_d[l_ac].pmdo006 = 0 THEN
         CONTINUE FOREACH
      END IF
      
      LET l_slip = ''
      CALL s_aooi200_get_slip(g_pmdo3_d[l_ac].pmdodocno) RETURNING l_success,l_slip
      IF NOT l_success THEN
         CONTINUE FOREACH
      END IF
#160815-00014#1-s mark
#      LET l_ooac004 = ''
#      CALL cl_get_doc_para(g_enterprise,g_site,l_slip,'D-BAS-0074') RETURNING l_ooac004
#      IF cl_null(l_ooac004) THEN
#         CONTINUE FOREACH
#      END IF
#160815-00014#1-e mark
      
      LET g_pmdo3_d[l_ac].days =  g_pmdo3_d[l_ac].pmdo012 - g_today
      
      CALL apmp520_01_detail_show("'3'")   
          
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
   CALL g_pmdo3_d.deleteElement(l_ac)
   LET l_ac = l_ac_t
   CLOSE apmp520_01_b_fill_curs_d3
   FREE apmp520_01_sel_d3
   
   CASE g_current_page
      WHEN '1'
         IF l_ac > g_pmdo_d.getLength() THEN
            LET l_ac = g_pmdo_d.getLength()
         END IF
         IF cl_null(l_ac) OR l_ac = 0 THEN
            LET l_ac = 1
         END IF
      WHEN '2'
         IF l_ac > g_pmdo2_d.getLength() THEN
            LET l_ac = g_pmdo2_d.getLength()
         END IF
         IF cl_null(l_ac) OR l_ac = 0 THEN
            LET l_ac = 1
         END IF
      WHEN '3'
         IF l_ac > g_pmdo3_d.getLength() THEN
            LET l_ac = g_pmdo3_d.getLength()
         END IF
         IF cl_null(l_ac) OR l_ac = 0 THEN
            LET l_ac = 1
         END IF
   END CASE
   
END FUNCTION
#顯示收貨底稿資料
PUBLIC FUNCTION apmp520_01_b_fill2()
DEFINE l_sql        STRING
DEFINE l_ac_t       LIKE type_t.num5

   WHENEVER ERROR CONTINUE
   
   LET l_sql = "SELECT 'N',pmdl004,      '',pmdodocno,pmdoseq,pmdoseq1,",
               "           pmdoseq2,pmdo003,pmdo001,       '',      '',",
               "           pmdo002, pmdo004,     '',  pmdo012,pmdo006, ",
               "                 0, pmdt020,pmdn028,     '',  pmdn029, ",
               "                '', pmdn030,pmdn053,pmdn022,pmdn050,pmdl028 ",   #161129-00037#1 add pmdn053  #161207-00033#21 add pmdl028
               "  FROM apmp520_01_temp",
               " WHERE pmdo012 < '",g_today CLIPPED,"'"

              
   PREPARE apmp520_01_temp_sel_d1 FROM l_sql
   DECLARE apmp520_01_temp_b_fill_curs_d1 CURSOR FOR apmp520_01_temp_sel_d1
   
   CALL g_pmdo_d.clear()

   LET l_ac_t = l_ac
   LET l_ac = 1
   ERROR "Searching!"

   FOREACH apmp520_01_temp_b_fill_curs_d1 INTO g_pmdo_d[l_ac].*,g_pmdl028  #161207-00033#21 add pmdl028
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:apmp520_01_temp_b_fill_curs_d1"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
   
      LET g_pmdo_d[l_ac].days = g_today - g_pmdo_d[l_ac].pmdo012
      
      CALL apmp520_01_detail_show("'1'")
      
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
   CALL g_pmdo_d.deleteElement(l_ac)
   LET l_ac = l_ac_t
   CLOSE apmp520_01_temp_b_fill_curs_d1
   FREE apmp520_01_temp_sel_d1
   
   LET l_sql = "SELECT 'N',pmdl004,      '',pmdodocno,pmdoseq,pmdoseq1,",
               "           pmdoseq2,pmdo003,pmdo001,       '',      '',",
               "           pmdo002, pmdo004,     '',  pmdo012,pmdo006, ",
               "                 0, pmdt020,pmdn028,     '',  pmdn029, ",
               "                '', pmdn030,pmdn053,pmdn022,pmdn050,pmdl028",   #161129-00037#1 add pmdn053  #161207-00033#21 add pmdl028
               "  FROM apmp520_01_temp",
               " WHERE pmdo012 = '",g_today CLIPPED,"'"

              
   PREPARE apmp520_01_temp_sel_d2 FROM l_sql
   DECLARE apmp520_01_temp_b_fill_curs_d2 CURSOR FOR apmp520_01_temp_sel_d2
   
   CALL g_pmdo2_d.clear()

   LET l_ac_t = l_ac
   LET l_ac = 1
   ERROR "Searching!"

   FOREACH apmp520_01_temp_b_fill_curs_d2 INTO g_pmdo2_d[l_ac].*,g_pmdl028   #161207-00033#21 add pmdl028
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:apmp520_01_temp_b_fill_curs_d2"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
   
      CALL apmp520_01_detail_show("'2'")
          
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
   CALL g_pmdo2_d.deleteElement(l_ac)
   LET l_ac = l_ac_t
   CLOSE apmp520_01_temp_b_fill_curs_d2
   FREE apmp520_01_temp_sel_d2
   
   LET l_sql = "SELECT 'N',pmdl004,      '',pmdodocno,pmdoseq,pmdoseq1,",
               "           pmdoseq2,pmdo003,pmdo001,       '',      '',",
               "           pmdo002, pmdo004,     '',  pmdo012,pmdo006, ",
               "                 0, pmdt020,pmdn028,     '',  pmdn029, ",
               "                '', pmdn030,pmdn053,pmdn022,pmdn050,pmdl028 ",   #161129-00037#1 add pmdn053  #161207-00033#21 add pmdl028
               "  FROM apmp520_01_temp",
               " WHERE pmdo012 > '",g_today CLIPPED,"'"

              
   PREPARE apmp520_01_temp_sel_d3 FROM l_sql
   DECLARE apmp520_01_temp_b_fill_curs_d3 CURSOR FOR apmp520_01_temp_sel_d3
   
   CALL g_pmdo3_d.clear()

   LET l_ac_t = l_ac
   LET l_ac = 1
   ERROR "Searching!"

   FOREACH apmp520_01_temp_b_fill_curs_d3 INTO g_pmdo3_d[l_ac].*,g_pmdl028   #161207-00033#21 add pmdl028
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:apmp520_01_temp_b_fill_curs_d3"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
   
      LET g_pmdo3_d[l_ac].days = g_pmdo3_d[l_ac].pmdo012 - g_today 
      
      #161205-00023#1-s mod
#      CALL apmp520_01_detail_show("'1'")   #161205-00023#1-s mark
      CALL apmp520_01_detail_show("'3'")
      #161205-00023#1-e mod
          
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
   CALL g_pmdo3_d.deleteElement(l_ac)
   LET l_ac = l_ac_t
   CLOSE apmp520_01_temp_b_fill_curs_d3
   FREE apmp520_01_temp_sel_d3
   
   CASE g_current_page
      WHEN '1'
         IF l_ac > g_pmdo_d.getLength() THEN
            LET l_ac = g_pmdo_d.getLength()
         END IF
         IF cl_null(l_ac) OR l_ac = 0 THEN
            LET l_ac = 1
         END IF
      WHEN '2'
         IF l_ac > g_pmdo2_d.getLength() THEN
            LET l_ac = g_pmdo2_d.getLength()
         END IF
         IF cl_null(l_ac) OR l_ac = 0 THEN
            LET l_ac = 1
         END IF
      WHEN '3'
         IF l_ac > g_pmdo3_d.getLength() THEN
            LET l_ac = g_pmdo3_d.getLength()
         END IF
         IF cl_null(l_ac) OR l_ac = 0 THEN
            LET l_ac = 1
         END IF
   END CASE
END FUNCTION

PRIVATE FUNCTION apmp520_01_detail_show(p_page)
   DEFINE p_page      STRING
   DEFINE l_pmak003   LIKE pmak_t.pmak003   #161230-00019#2

   IF p_page.getIndexOf("'1'",1) > 0 THEN
      #161230-00019#2-s-mark
      #161207-00033#21-S
#      IF NOT cl_null(g_pmdl028) THEN
#         CALL s_desc_get_oneturn_guest_desc(g_pmdl028) RETURNING g_pmdo_d[l_ac].pmdl004_desc
#      ELSE
#      #161207-00033#21-E 
#         CALL s_desc_get_trading_partner_abbr_desc(g_pmdo_d[l_ac].pmdl004)
#          RETURNING g_pmdo_d[l_ac].pmdl004_desc
#      END IF   #161207-00033#21
      #161230-00019#2-e-mark
      #161230-00019#2-s-add
      CALL s_desc_get_trading_partner_abbr_desc(g_pmdo_d[l_ac].pmdl004)
        RETURNING g_pmdo_d[l_ac].pmdl004_desc
      IF NOT cl_null(g_pmdl028) THEN
         LET l_pmak003 = ''
         CALL s_desc_get_oneturn_guest_desc(g_pmdl028) 
           RETURNING l_pmak003
         
         IF NOT cl_null(l_pmak003) THEN
            LET g_pmdo_d[l_ac].pmdl004_desc = l_pmak003
         END IF
      END IF
      #161230-00019#2-e-add
      LET g_pmdl028 = ''   #161207-00033#21 add pmdl028
      
      CALL s_desc_get_item_desc(g_pmdo_d[l_ac].pmdo001)
       RETURNING g_pmdo_d[l_ac].pmdo001_desc,g_pmdo_d[l_ac].pmdo001_desc_desc
      
      CALL s_desc_get_unit_desc(g_pmdo_d[l_ac].pmdo004)
       RETURNING g_pmdo_d[l_ac].pmdo004_desc
      
      CALL s_desc_get_stock_desc(g_site,g_pmdo_d[l_ac].pmdn028)
       RETURNING g_pmdo_d[l_ac].pmdn028_desc
       
      CALL s_desc_get_locator_desc(g_site,g_pmdo_d[l_ac].pmdn028,g_pmdo_d[l_ac].pmdn029)
       RETURNING g_pmdo_d[l_ac].pmdn029_desc
   END IF
   
   IF p_page.getIndexOf("'2'",1) > 0 THEN

      #161230-00019#2-s-mark
#      #161207-00033#21-S
#      IF NOT cl_null(g_pmdl028) THEN
#         CALL s_desc_get_oneturn_guest_desc(g_pmdl028) RETURNING g_pmdo2_d[l_ac].pmdl004_desc
#      ELSE
#      #161207-00033#21-E 
#         CALL s_desc_get_trading_partner_abbr_desc(g_pmdo2_d[l_ac].pmdl004)
#          RETURNING g_pmdo2_d[l_ac].pmdl004_desc
#      END IF #161207-00033#21 
      #161230-00019#2-e-mark
      #161230-00019#2-s-add
      CALL s_desc_get_trading_partner_abbr_desc(g_pmdo2_d[l_ac].pmdl004)
        RETURNING g_pmdo2_d[l_ac].pmdl004_desc
      IF NOT cl_null(g_pmdl028) THEN
         LET l_pmak003 = ''
         CALL s_desc_get_oneturn_guest_desc(g_pmdl028) 
           RETURNING l_pmak003
         
         IF NOT cl_null(l_pmak003) THEN
            LET g_pmdo2_d[l_ac].pmdl004_desc = l_pmak003
         END IF
      END IF
      #161230-00019#2-e-add
      LET g_pmdl028 = ''     #161207-00033#21
      CALL s_desc_get_item_desc(g_pmdo2_d[l_ac].pmdo001)
       RETURNING g_pmdo2_d[l_ac].pmdo001_desc,g_pmdo2_d[l_ac].pmdo001_desc_desc
      
      CALL s_desc_get_unit_desc(g_pmdo2_d[l_ac].pmdo004)
       RETURNING g_pmdo2_d[l_ac].pmdo004_desc
      
      CALL s_desc_get_stock_desc(g_site,g_pmdo2_d[l_ac].pmdn028)
       RETURNING g_pmdo2_d[l_ac].pmdn028_desc
       
      CALL s_desc_get_locator_desc(g_site,g_pmdo2_d[l_ac].pmdn028,g_pmdo2_d[l_ac].pmdn029)
       RETURNING g_pmdo2_d[l_ac].pmdn029_desc
   END IF
   
   IF p_page.getIndexOf("'3'",1) > 0 THEN
   
      #161230-00019#2-s-mark
#      #161207-00033#21-S
#      IF NOT cl_null(g_pmdl028) THEN
#         CALL s_desc_get_oneturn_guest_desc(g_pmdl028) RETURNING g_pmdo3_d[l_ac].pmdl004_desc
#      ELSE
#      #161207-00033#21-E    
#         CALL s_desc_get_trading_partner_abbr_desc(g_pmdo3_d[l_ac].pmdl004)
#          RETURNING g_pmdo3_d[l_ac].pmdl004_desc
#      #161207-00033#21-S    
#      END IF
      #161230-00019#2-e-mark
      #161230-00019#2-s-add
      CALL s_desc_get_trading_partner_abbr_desc(g_pmdo3_d[l_ac].pmdl004)
        RETURNING g_pmdo3_d[l_ac].pmdl004_desc
      IF NOT cl_null(g_pmdl028) THEN
         LET l_pmak003 = ''
         CALL s_desc_get_oneturn_guest_desc(g_pmdl028) 
           RETURNING l_pmak003
         
         IF NOT cl_null(l_pmak003) THEN
            LET g_pmdo3_d[l_ac].pmdl004_desc = l_pmak003
         END IF
      END IF
      #161230-00019#2-e-add
      LET g_pmdl028 = '' 
      #161207-00033#21-E      
      CALL s_desc_get_item_desc(g_pmdo3_d[l_ac].pmdo001)
       RETURNING g_pmdo3_d[l_ac].pmdo001_desc,g_pmdo3_d[l_ac].pmdo001_desc_desc
      
      CALL s_desc_get_unit_desc(g_pmdo3_d[l_ac].pmdo004)
       RETURNING g_pmdo3_d[l_ac].pmdo004_desc
      
      CALL s_desc_get_stock_desc(g_site,g_pmdo3_d[l_ac].pmdn028)
       RETURNING g_pmdo3_d[l_ac].pmdn028_desc
       
      CALL s_desc_get_locator_desc(g_site,g_pmdo3_d[l_ac].pmdn028,g_pmdo3_d[l_ac].pmdn029)
       RETURNING g_pmdo3_d[l_ac].pmdn029_desc
   END IF
END FUNCTION

PUBLIC FUNCTION apmp520_01_save_data()
   DEFINE l_i         LIKE type_t.num5
   DEFINE l_msg       STRING   
   #160120-00002#1 s983961--add(s)
   DEFINE l_cnt       LIKE type_t.num5
   DEFINE l_sql       STRING
   DEFINE l_pmdodocno LIKE pmdo_t.pmdodocno
   DEFINE l_pmdoseq   LIKE pmdo_t.pmdoseq
   DEFINE l_pmdoseq1  LIKE pmdo_t.pmdoseq1
   DEFINE l_pmdoseq2  LIKE pmdo_t.pmdoseq2
   DEFINE l_where     STRING
   #160120-00002#1 s983961--add(e)
   DEFINE l_pmdl028   LIKE pmdl_t.pmdl028   #161230-00019#2
   
   CALL cl_showmsg_init()
   
   CASE g_current_page
      WHEN '1'         
         IF g_pmdo_d[l_ac].sel = 'Y' THEN
            IF g_pmdo_d[l_ac].pmdt020 <= 0 THEN
               LET g_pmdo_d[l_ac].pmdt020 = g_pmdo_d[l_ac].pmdo006
            END IF
         END IF 
      WHEN '2'
         IF g_pmdo2_d[l_ac].sel = 'Y' THEN
            IF g_pmdo2_d[l_ac].pmdt020 <= 0 THEN
               LET g_pmdo2_d[l_ac].pmdt020 = g_pmdo2_d[l_ac].pmdo006
            END IF
         END IF 
      WHEN '3'
         IF g_pmdo3_d[l_ac].sel = 'Y' THEN
            IF g_pmdo3_d[l_ac].pmdt020 <= 0 THEN
               LET g_pmdo3_d[l_ac].pmdt020 = g_pmdo3_d[l_ac].pmdo006
            END IF
         END IF 
   END CASE


   FOR l_i = 1 TO g_pmdo_d.getLength()
      IF g_pmdo_d[l_i].sel = 'Y' THEN
         IF g_pmdo_d[l_i].pmdt020 > 0 THEN
            #161230-00019#2-s-add
            LET l_pmdl028 = ''
            SELECT pmdl028 INTO l_pmdl028
              FROM pmdl_t
             WHERE pmdlent = g_enterprise
               AND pmdldocno = g_pmdo_d[l_i].pmdodocno
            #161230-00019#2-e-add            
            INSERT INTO apmp520_01_temp (pmdl004,pmdodocno,pmdoseq,pmdoseq1,pmdoseq2,
                                        pmdo003,pmdo001,  pmdo002,pmdo004, pmdo012, 
                                        pmdo006,pmdt020,  pmdn028,pmdn029, pmdn030, 
                                        #161230-00019#2-s-mod
#                                        pmdn053,pmdn022,  pmdn050 )    #161129-00037#1 add pmdn053
                                        pmdn053,pmdn022,  pmdn050 ,pmdl028)
                                        #161230-00019#2-e-mod
            VALUES(g_pmdo_d[l_i].pmdl004, g_pmdo_d[l_i].pmdodocno,g_pmdo_d[l_i].pmdoseq,
                   g_pmdo_d[l_i].pmdoseq1,g_pmdo_d[l_i].pmdoseq2, g_pmdo_d[l_i].pmdo003,
                   g_pmdo_d[l_i].pmdo001, g_pmdo_d[l_i].pmdo002,  g_pmdo_d[l_i].pmdo004,
                   g_pmdo_d[l_i].pmdo012, g_pmdo_d[l_i].pmdo006,  g_pmdo_d[l_i].pmdt020,
                   g_pmdo_d[l_i].pmdn028, g_pmdo_d[l_i].pmdn029,  g_pmdo_d[l_i].pmdn030,
                   #161230-00019#2-s-mod
#                   g_pmdo_d[l_i].pmdn053, g_pmdo_d[l_i].pmdn022, g_pmdo_d[l_i].pmdn050)   #161129-00037#1 add pmdn053
                   g_pmdo_d[l_i].pmdn053, g_pmdo_d[l_i].pmdn022, g_pmdo_d[l_i].pmdn050,l_pmdl028)
                   #161230-00019#2-e-mod
            #161230-00019#2-e-mod
            #160120-00002#1 s983961--add(s)  
            LET l_cnt = 0
            SELECT COUNT(*) INTO l_cnt
              FROM p520_lock_t   #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 p520_01_lock_b_t ——> p520_lock_t
             WHERE pmdodocno = g_pmdo_d[l_i].pmdodocno
               AND pmdoseq   = g_pmdo_d[l_i].pmdoseq
               AND pmdoseq1  = g_pmdo_d[l_i].pmdoseq1
               AND pmdoseq2  = g_pmdo_d[l_i].pmdoseq2
            IF cl_null(l_cnt) OR l_cnt = 0 THEN
               INSERT INTO p520_lock_t VALUES(g_pmdo_d[l_i].pmdodocno,g_pmdo_d[l_i].pmdoseq,g_pmdo_d[l_i].pmdoseq1,g_pmdo_d[l_i].pmdoseq2)   #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 p520_01_lock_b_t ——> p520_lock_t
            END IF
            #160120-00002#1 s983961--add(e)         
         ELSE  
            CALL cl_getmsg_parm('axm-00219',g_dlang,g_pmdo_d[l_i].pmdodocno ||'|'|| g_pmdo_d[l_i].pmdoseq ||'|'|| 
                                g_pmdo_d[l_i].pmdoseq1 ||'|'|| g_pmdo_d[l_i].pmdoseq2 )
             RETURNING l_msg         
            CALL cl_errmsg('pmdldocno',g_pmdo_d[l_i].pmdodocno,l_msg,'apm-00539',1)
         END IF
      END IF
   END FOR

   FOR l_i = 1 TO g_pmdo2_d.getLength()
      IF g_pmdo2_d[l_i].sel = 'Y' THEN
         IF g_pmdo2_d[l_i].pmdt020 > 0 THEN
            #161230-00019#2-s-add
            LET l_pmdl028 = ''
            SELECT pmdl028 INTO l_pmdl028
              FROM pmdl_t
             WHERE pmdlent = g_enterprise
               AND pmdldocno = g_pmdo2_d[l_i].pmdodocno
            #161230-00019#2-e-add
            INSERT INTO apmp520_01_temp (pmdl004,pmdodocno,pmdoseq,pmdoseq1,pmdoseq2,
                                        pmdo003,pmdo001,  pmdo002,pmdo004, pmdo012, 
                                        pmdo006,pmdt020,  pmdn028,pmdn029, pmdn030,
                                        #161230-00019#2-s-mod
#                                        pmdn053,pmdn022,  pmdn050 )    #161129-00037#1 add pmdn053
                                        pmdn053,pmdn022,  pmdn050 ,pmdl028)
                                        #161230-00019#2-e-mod
            VALUES(g_pmdo2_d[l_i].pmdl004, g_pmdo2_d[l_i].pmdodocno,g_pmdo2_d[l_i].pmdoseq,
                   g_pmdo2_d[l_i].pmdoseq1,g_pmdo2_d[l_i].pmdoseq2, g_pmdo2_d[l_i].pmdo003,
                   g_pmdo2_d[l_i].pmdo001, g_pmdo2_d[l_i].pmdo002,  g_pmdo2_d[l_i].pmdo004,
                   g_pmdo2_d[l_i].pmdo012, g_pmdo2_d[l_i].pmdo006,  g_pmdo2_d[l_i].pmdt020,
                   g_pmdo2_d[l_i].pmdn028, g_pmdo2_d[l_i].pmdn029,  g_pmdo2_d[l_i].pmdn030,
                   #161230-00019#2-s-mod
#                   g_pmdo2_d[l_i].pmdn053, g_pmdo2_d[l_i].pmdn022, g_pmdo2_d[l_i].pmdn050)  #161129-00037#1 add pmdn053
                   g_pmdo2_d[l_i].pmdn053, g_pmdo2_d[l_i].pmdn022, g_pmdo2_d[l_i].pmdn050,l_pmdl028)
                   #161230-00019#2-e-mod                   
            #160120-00002#1 s983961--add(s)  
            LET l_cnt = 0
            SELECT COUNT(*) INTO l_cnt
              FROM p520_lock_t  #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 p520_01_lock_b_t ——> p520_lock_t
             WHERE pmdodocno = g_pmdo2_d[l_i].pmdodocno
               AND pmdoseq   = g_pmdo2_d[l_i].pmdoseq
               AND pmdoseq1  = g_pmdo2_d[l_i].pmdoseq1
               AND pmdoseq2  = g_pmdo2_d[l_i].pmdoseq2
            IF cl_null(l_cnt) OR l_cnt = 0 THEN
               INSERT INTO p520_lock_t VALUES(g_pmdo2_d[l_i].pmdodocno,g_pmdo2_d[l_i].pmdoseq,g_pmdo2_d[l_i].pmdoseq1,g_pmdo2_d[l_i].pmdoseq2)  #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 p520_01_lock_b_t ——> p520_lock_t
            END IF
            #160120-00002#1 s983961--add(e)         
         ELSE
            CALL cl_getmsg_parm('axm-00219',g_dlang,g_pmdo2_d[l_i].pmdodocno ||'|'|| g_pmdo2_d[l_i].pmdoseq ||'|'|| 
                                g_pmdo2_d[l_i].pmdoseq1 ||'|'|| g_pmdo2_d[l_i].pmdoseq2 )
             RETURNING l_msg         
            CALL cl_errmsg('pmdldocno',g_pmdo2_d[l_i].pmdodocno,l_msg,'apm-00539',1)
         END IF
      END IF           
   END FOR

   FOR l_i = 1 TO g_pmdo3_d.getLength()
      IF g_pmdo3_d[l_i].sel = 'Y' THEN
         IF g_pmdo3_d[l_i].pmdt020 > 0 THEN
            #161230-00019#2-s-add
            LET l_pmdl028 = ''
            SELECT pmdl028 INTO l_pmdl028
              FROM pmdl_t
             WHERE pmdlent = g_enterprise
               AND pmdldocno = g_pmdo3_d[l_i].pmdodocno
            #161230-00019#2-e-add
            INSERT INTO apmp520_01_temp (pmdl004,pmdodocno,pmdoseq,pmdoseq1,pmdoseq2,
                                        pmdo003,pmdo001,  pmdo002,pmdo004, pmdo012, 
                                        pmdo006,pmdt020,  pmdn028,pmdn029, pmdn030,
                                        #161230-00019#2-s-mod
#                                        pmdn053,pmdn022,  pmdn050 )    #161129-00037#1 add pmdn053
                                        pmdn053,pmdn022,  pmdn050 ,pmdl028)
                                        #161230-00019#2-e-mod
            VALUES(g_pmdo3_d[l_i].pmdl004, g_pmdo3_d[l_i].pmdodocno,g_pmdo3_d[l_i].pmdoseq,
                   g_pmdo3_d[l_i].pmdoseq1,g_pmdo3_d[l_i].pmdoseq2, g_pmdo3_d[l_i].pmdo003,
                   g_pmdo3_d[l_i].pmdo001, g_pmdo3_d[l_i].pmdo002,  g_pmdo3_d[l_i].pmdo004,
                   g_pmdo3_d[l_i].pmdo012, g_pmdo3_d[l_i].pmdo006,  g_pmdo3_d[l_i].pmdt020,
                   g_pmdo3_d[l_i].pmdn028, g_pmdo3_d[l_i].pmdn029,  g_pmdo3_d[l_i].pmdn030,                   
                   #161230-00019#2-s-mod
#                   g_pmdo3_d[l_i].pmdn053, g_pmdo3_d[l_i].pmdn022,  g_pmdo3_d[l_i].pmdn050)  #161129-00037#1 add pmdn053
                   g_pmdo3_d[l_i].pmdn053, g_pmdo3_d[l_i].pmdn022,  g_pmdo3_d[l_i].pmdn050,l_pmdl028)
                   #161230-00019#2-e-mod
            #160120-00002#1 s983961--add(s)  
            LET l_cnt = 0
            SELECT COUNT(*) INTO l_cnt
              FROM p520_lock_t  #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 p520_01_lock_b_t ——> p520_lock_t
             WHERE pmdodocno = g_pmdo3_d[l_i].pmdodocno
               AND pmdoseq   = g_pmdo3_d[l_i].pmdoseq
               AND pmdoseq1  = g_pmdo3_d[l_i].pmdoseq1
               AND pmdoseq2  = g_pmdo3_d[l_i].pmdoseq2
            IF cl_null(l_cnt) OR l_cnt = 0 THEN
               INSERT INTO p520_lock_t VALUES(g_pmdo3_d[l_i].pmdodocno,g_pmdo3_d[l_i].pmdoseq,g_pmdo3_d[l_i].pmdoseq1,g_pmdo3_d[l_i].pmdoseq2)  #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 p520_01_lock_b_t ——> p520_lock_t
            END IF
            #160120-00002#1 s983961--add(e)         
         ELSE
            CALL cl_getmsg_parm('axm-00219',g_dlang,g_pmdo3_d[l_i].pmdodocno ||'|'|| g_pmdo3_d[l_i].pmdoseq ||'|'|| 
                                g_pmdo3_d[l_i].pmdoseq1 ||'|'|| g_pmdo3_d[l_i].pmdoseq2 )
             RETURNING l_msg         
            CALL cl_errmsg('pmdldocno',g_pmdo3_d[l_i].pmdodocno,l_msg,'apm-00539',1)
         END IF
      END IF      
   END FOR
   
   #160706-00037#2 20160710 03079 -----(S) 
   ##160120-00002#1 s983961--add(s)  
   #LET l_sql = "SELECT pmdodocno,pmdoseq,pmdoseq1,pmdoseq2 ",
   #            "  FROM p520_01_lock_b_t ",
   #            " ORDER BY pmdodocno,pmdoseq "
   #PREPARE apmp520_lock_prep FROM l_sql
   #DECLARE apmp520_lock_curs CURSOR FOR apmp520_lock_prep
   #
   #LET l_sql = "SELECT pmdodocno,pmdoseq,pmdoseq1,pmdoseq2 ",
   #            "  FROM pmdo_t ",
   #            " WHERE "
   #
   #LET l_where = ''
   #FOREACH apmp520_lock_curs INTO l_pmdodocno,l_pmdoseq,l_pmdoseq1,l_pmdoseq2
   #   IF cl_null(l_where) THEN
   #      LET l_where = "(pmdodocno = '",l_pmdodocno,"' AND pmdoseq = '",l_pmdoseq,"' AND pmdoseq1 = '",l_pmdoseq1,"' AND pmdoseq2 = '",l_pmdoseq2,"') "
   #   ELSE
   #      LET l_where = l_where," OR ","(pmdodocno = '",l_pmdodocno,"' AND pmdoseq = '",l_pmdoseq,"' AND pmdoseq1 = '",l_pmdoseq1,"' AND pmdoseq2 = '",l_pmdoseq2,"') "
   #   END IF
   #END FOREACH
   #
   #LET l_sql = l_sql,l_where," FOR UPDATE "
   #PREPARE apmp520_lock_body_prep FROM l_sql 
   #DECLARE apmp520_lock_body_curs CURSOR FOR apmp520_lock_body_prep
   #OPEN apmp520_lock_body_curs
   ##160120-00002#1 s983961--add(e)
   #160706-00037#2 20160710 03079 -----(E) 

   CALL cl_showmsg()
END FUNCTION

PUBLIC FUNCTION apmp520_01_chk_temp_data(p_pmdodocno,p_pmdoseq,p_pmdoseq1,p_pmdoseq2)
   DEFINE p_pmdodocno      LIKE pmdo_t.pmdodocno
   DEFINE p_pmdoseq        LIKE pmdo_t.pmdoseq
   DEFINE p_pmdoseq1       LIKE pmdo_t.pmdoseq1
   DEFINE p_pmdoseq2       LIKE pmdo_t.pmdoseq2
   DEFINE r_success        LIKE type_t.num5
   DEFINE l_cnt            LIKE type_t.num5
   
   LET r_success = TRUE
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM apmp520_01_temp
    WHERE pmdodocno = p_pmdodocno
      AND pmdoseq   = p_pmdoseq
      AND pmdoseq1  = p_pmdoseq1
      AND pmdoseq2  = p_pmdoseq2
   IF l_cnt > 0 THEN
      LET r_success = FALSE
   END IF
   
   RETURN r_success
END FUNCTION

PUBLIC FUNCTION apmp520_01_delete_data()
   DEFINE l_i     LIKE type_t.num5
   
   FOR l_i = 1 TO g_pmdo_d.getLength()
      IF g_pmdo_d[l_i].sel = 'Y' THEN
         DELETE FROM apmp520_01_temp
          WHERE pmdodocno = g_pmdo_d[l_i].pmdodocno
            AND pmdoseq   = g_pmdo_d[l_i].pmdoseq
            AND pmdoseq1  = g_pmdo_d[l_i].pmdoseq1
            AND pmdoseq2  = g_pmdo_d[l_i].pmdoseq2
         #160120-00002#1 s983961--add(s)  
         DELETE FROM p520_lock_t  #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 p520_01_lock_b_t ——> p520_lock_t
          WHERE pmdodocno = g_pmdo_d[l_i].pmdodocno
            AND pmdoseq   = g_pmdo_d[l_i].pmdoseq      
            AND pmdoseq1  = g_pmdo_d[l_i].pmdoseq1
            AND pmdoseq2  = g_pmdo_d[l_i].pmdoseq2
         #160120-00002#1 s983961--add(e)    
      END IF
   END FOR

   FOR l_i = 1 TO g_pmdo2_d.getLength()
      IF g_pmdo2_d[l_i].sel = 'Y' THEN
         DELETE FROM apmp520_01_temp
          WHERE pmdodocno = g_pmdo2_d[l_i].pmdodocno
            AND pmdoseq   = g_pmdo2_d[l_i].pmdoseq
            AND pmdoseq1  = g_pmdo2_d[l_i].pmdoseq1
            AND pmdoseq2  = g_pmdo2_d[l_i].pmdoseq2
         #160120-00002#1 s983961--add(s)    
         DELETE FROM p520_lock_t  #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 p520_01_lock_b_t ——> p520_lock_t
          WHERE pmdodocno = g_pmdo2_d[l_i].pmdodocno
            AND pmdoseq   = g_pmdo2_d[l_i].pmdoseq     
            AND pmdoseq1  = g_pmdo2_d[l_i].pmdoseq1
            AND pmdoseq2  = g_pmdo2_d[l_i].pmdoseq2            
         #160120-00002#1 s983961--add(e)    
      END IF
   END FOR

   FOR l_i = 1 TO g_pmdo3_d.getLength()
      IF g_pmdo3_d[l_i].sel = 'Y' THEN
         DELETE FROM apmp520_01_temp
          WHERE pmdodocno = g_pmdo3_d[l_i].pmdodocno
            AND pmdoseq   = g_pmdo3_d[l_i].pmdoseq
            AND pmdoseq1  = g_pmdo3_d[l_i].pmdoseq1
            AND pmdoseq2  = g_pmdo3_d[l_i].pmdoseq2            
         #160120-00002#1 s983961--add(s)    
         DELETE FROM p520_lock_t  #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 p520_01_lock_b_t ——> p520_lock_t
          WHERE pmdodocno = g_pmdo3_d[l_i].pmdodocno
            AND pmdoseq   = g_pmdo3_d[l_i].pmdoseq      
            AND pmdoseq1  = g_pmdo3_d[l_i].pmdoseq1
            AND pmdoseq2  = g_pmdo3_d[l_i].pmdoseq2
         #160120-00002#1 s983961--add(e)       
      END IF
   END FOR
END FUNCTION

################################################################################
# Descriptions...: 待收數量預設
# Memo...........:
# Usage..........: CALL apmp520_01_default_quantity(p_pmdt001,p_pmdt002,p_pmdt003,p_pmdt004)
#                  RETURNING r_quantity
# Input parameter: p_pmdt001      採購單號
#                : p_pmdt002      採購項次
#                : p_pmdt003      採購項序
#                : p_pmdt004      採購分批序
# Return code....: r_quantity     待收數量
# Date & Author..: 2014/06/23 By benson
# Modify.........:
################################################################################
PUBLIC FUNCTION apmp520_01_default_quantity(p_pmdt001,p_pmdt002,p_pmdt003,p_pmdt004)
DEFINE r_quantity    LIKE pmdt_t.pmdt020
DEFINE p_pmdt001     LIKE pmdt_t.pmdt001   #採購單號
DEFINE p_pmdt002     LIKE pmdt_t.pmdt002   #項次
DEFINE p_pmdt003     LIKE pmdt_t.pmdt003   #項序
DEFINE p_pmdt004     LIKE pmdt_t.pmdt004   #分批序
DEFINE l_pmdn022     LIKE pmdn_t.pmdn022
DEFINE l_pmdn034     LIKE pmdn_t.pmdn034
DEFINE l_pmdo006     LIKE pmdo_t.pmdo006
DEFINE l_pmdo015     LIKE pmdo_t.pmdo015
DEFINE l_pmdo016     LIKE pmdo_t.pmdo016
DEFINE l_pmdo017     LIKE pmdo_t.pmdo017     #160908-00038#1
DEFINE l_pmdt020     LIKE pmdt_t.pmdt020

   LET r_quantity = 0

   #若採購項次設置不允許部分收貨時，則收貨數量不允許小於採購數量
   LET l_pmdn022 = '' #部分收貨   
   SELECT pmdn022 INTO l_pmdn022 FROM pmdn_t
     WHERE pmdnent = g_enterprise AND pmdndocno = p_pmdt001
       AND pmdnseq = p_pmdt002

   LET l_pmdo006 = 0
   LET l_pmdo015 = 0  #pmdo015(已收貨量)
   LET l_pmdo016 = 0  #pmdo016(驗退量)
   SELECT pmdo006,pmdo015,pmdo016,pmdo017       #160908-00038#1 add pmdo017
     INTO l_pmdo006,l_pmdo015,l_pmdo016,l_pmdo017     #160908-00038#1 add pmdo017
     FROM pmdo_t
     WHERE pmdoent = g_enterprise AND pmdodocno = p_pmdt001
       AND pmdoseq = p_pmdt002
       AND pmdoseq1 = p_pmdt003
       AND pmdoseq2 = p_pmdt004

   IF cl_null(l_pmdo006) THEN
      LET l_pmdo006 = 0
   END IF
   IF cl_null(l_pmdo015) THEN
      LET l_pmdo015 = 0
   END IF
   IF cl_null(l_pmdo016) THEN
      LET l_pmdo016 = 0
   END IF
   #160908-00038#1-s
   IF cl_null(l_pmdo017) THEN
      LET l_pmdo017 = 0
   END IF
   #160908-00038#1-e

   #輸入的收貨數量不可以大於對應採購的pmdo006(需求量+超交率數量)-pmdo015(已收貨量)+pmdo016(驗退量)-已打收貨單未確認數量
   #收貨數量需要考慮超交率，總收貨量不可以大於採購量+超交率數量
   LET l_pmdt020 = 0    #已登打收貨單未確認量(其他單據上的)
   SELECT SUM(COALESCE(pmdt020,0)) INTO l_pmdt020 FROM pmdt_t,pmds_t
     WHERE pmdtent = pmdsent AND pmdtdocno = pmdsdocno
       AND pmdtent = g_enterprise AND pmdsstus = 'N'
       AND pmdt001 = p_pmdt001 AND pmdt002 = p_pmdt002
       AND pmdt003 = p_pmdt003 AND pmdt004 = p_pmdt004
       AND pmds000 IN ('1','3','8','9','23','24','20')    #161124-00054#1 #收货单类型
   IF cl_null(l_pmdt020) THEN
      LET l_pmdt020 = 0
   END IF
   
   IF l_pmdn022 = 'N' THEN  #不允許部分收貨
      IF l_pmdt020 = 0 THEN
         LET r_quantity = l_pmdo006
      ELSE
         LET r_quantity = 0
      END IF
   ELSE
      LET r_quantity = l_pmdo006 - l_pmdo015 + l_pmdo016 - l_pmdt020 + l_pmdo017    #160908-00038#1
   END IF

   IF cl_null(r_quantity) OR r_quantity < 0 THEN
      LET r_quantity = 0
   END IF

   RETURN r_quantity
END FUNCTION

PUBLIC FUNCTION apmp520_01_set_entry_b()
   CALL cl_set_comp_entry("pmdt020_d1_01,pmdt020_d2_01,pmdt020_d3_01,",TRUE)
   CALL cl_set_comp_entry("pmdn050_d1_01,pmdn050_d2_01,pmdn050_d3_01,",TRUE)
END FUNCTION

PUBLIC FUNCTION apmp520_01_set_no_entry_b()
DEFINE l_pmdn050    LIKE pmdn_t.pmdn050

   IF g_apmp520_01_input_type = '2' THEN
      CALL cl_set_comp_entry("pmdt020_d1_01,pmdt020_d2_01,pmdt020_d3_01",FALSE)
   END IF
   
   LET l_pmdn050 = ''
   CASE g_current_page
      WHEN '1'
         SELECT pmdn050 INTO l_pmdn050
           FROM pmdn_t
          WHERE pmdnent = g_enterprise
            AND pmdndocno = g_pmdo_d[l_ac].pmdodocno 
            AND pmdnseq = g_pmdo_d[l_ac].pmdoseq
         IF NOT cl_null(l_pmdn050) THEN
            CALL cl_set_comp_entry("pmdn050_d1_01",FALSE)
         END IF  
      WHEN '2'
         SELECT pmdn050 INTO l_pmdn050
           FROM pmdn_t
          WHERE pmdnent = g_enterprise
            AND pmdndocno = g_pmdo2_d[l_ac].pmdodocno 
            AND pmdnseq = g_pmdo2_d[l_ac].pmdoseq
         IF NOT cl_null(l_pmdn050) THEN
            CALL cl_set_comp_entry("pmdn050_d2_01",FALSE)
         END IF  
      WHEN '3'
         SELECT pmdn050 INTO l_pmdn050
           FROM pmdn_t
          WHERE pmdnent = g_enterprise
            AND pmdndocno = g_pmdo3_d[l_ac].pmdodocno 
            AND pmdnseq = g_pmdo3_d[l_ac].pmdoseq
         IF NOT cl_null(l_pmdn050) THEN
            CALL cl_set_comp_entry("pmdn050_d3_01",FALSE)
         END IF  
   END CASE
   
  
          
END FUNCTION

PUBLIC FUNCTION apmp520_01_delete_temp_table()
   DELETE FROM apmp520_01_temp
   
   #160120-00002#1 s983961--add(s)
   DELETE FROM p520_lock_t      #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 p520_01_lock_b_t ——> p520_lock_t      
   #160120-00002#1 s983961--add(e)   
END FUNCTION

 
{</section>}
 
