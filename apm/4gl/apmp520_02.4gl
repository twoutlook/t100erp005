#該程式未解開Section, 採用最新樣板產出!
{<section id="apmp520_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0018(2016-11-29 18:13:20), PR版次:0018(2017-02-06 11:29:35)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000139
#+ Filename...: apmp520_02
#+ Description: 引導式收貨維護作業-收貨調整
#+ Creator....: 01752(2014-06-18 15:56:35)
#+ Modifier...: 02294 -SD/PR- 05384
 
{</section>}
 
{<section id="apmp520_02.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"
#160318-00025#20   16/04/18  BY 07900    校验代码重复错误讯息的修改
#160617-00005#5   2016/06/27  By lixiang    輸入收貨、入庫明細時， 料件批號須有批號且自動編碼而批號為空就自動編碼
#160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d1 ——> apmp520_tmp01,apmp520_02_temp_d2 ——> apmp520_tmp02,apmp520_02_temp_d3 ——> apmp520_tmp03,apmp520_02_temp_d5 ——> apmp520_tmp04
#160804-00068#1    16/08/16  By dorislai 1.修正輸入完儲位後，按確認，沖銷順序沒有重新計算的問題
#                                        2.修正沖銷順序儲位、批號的SQL組成 (參考apmp520_02_update_temp2改寫的)
#161103-00015#1    16/11/03  By wuxja    带出收货信息时，仓库储位同apmt520，若空时，单别预设——》参数预设——》料号预设
#160929-00038#1   2016/11/23  By lixiang   收货入库的计价数量栏位处理，先预设带出剩余的计价数量，不用单位换算重新计算
#161129-00037#1   2016/11/29  By wuxja     增加库存管理特征栏位
#161207-00006#1   2016/12/26  By liuym     多加了一个字段导致display错位  
#161207-00033#21  2016/12/20  By lixh     一次性交易對象顯示說明，所有的客戶/供應商欄位都應該處理
#161006-00018#22  2016/12/26  By lixh      增加参数D-MFG-0085(來源單據指定庫儲後，是否允許修改) 
#161215-00003#1   2016/12/30  By dorislai  多新增判斷當pmdl005='2.委外採購'，讓pmds011='2'
#161205-00035#1   2017/01/18  By xujing   检验否栏位已采购单单身带出为准,不可修改
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

#end add-point
 
{</section>}
 
{<section id="apmp520_02.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
 TYPE type_g_pmds_d    RECORD
    keyno              LIKE type_t.num5,
    pmds007            LIKE pmds_t.pmds007, 
    pmds007_desc       LIKE type_t.chr500, 
    pmds031            LIKE pmds_t.pmds031, 
    pmds031_desc       LIKE type_t.chr500, 
    pmds032            LIKE pmds_t.pmds032, 
    pmds032_desc       LIKE type_t.chr500, 
    pmds033            LIKE pmds_t.pmds033, 
    pmds033_desc       LIKE type_t.chr500, 
    pmds034            LIKE pmds_t.pmds034, 
    pmds035            LIKE pmds_t.pmds035, 
    pmds037            LIKE pmds_t.pmds037, 
    pmds037_desc       LIKE type_t.chr500, 
    pmds038            LIKE pmds_t.pmds038, 
    pmds039            LIKE pmds_t.pmds039, 
    pmds039_desc       LIKE type_t.chr500,
    ooac004            LIKE ooac_t.ooac004,
    pmds011            LIKE pmds_t.pmds011,
    pmds048            LIKE pmds_t.pmds048,
    pmds049            LIKE pmds_t.pmds049
                   END RECORD
 TYPE type_g_pmds2_d   RECORD
    keyno              LIKE type_t.num5,
    pmdtseq            LIKE pmdt_t.pmdtseq, 
    pmdt001            LIKE pmdt_t.pmdt001, 
    pmdt002            LIKE pmdt_t.pmdt002, 
    pmdt003            LIKE pmdt_t.pmdt003, 
    pmdt004            LIKE pmdt_t.pmdt004, 
    pmdt005            LIKE pmdt_t.pmdt005,
    pmdo001            LIKE pmdo_t.pmdo001,
    pmdo001_desc       LIKE imaal_t.imaal003,
    pmdo001_desc_desc  LIKE imaal_t.imaal004,       
    pmdt006            LIKE pmdt_t.pmdt006, 
    pmdt006_desc       LIKE imaal_t.imaal003,
    pmdt006_desc_desc  LIKE imaal_t.imaal004,
    pmdt007            LIKE pmdt_t.pmdt007, 
    pmdt009            LIKE pmdt_t.pmdt009, 
    pmdt010            LIKE pmdt_t.pmdt010, 
    pmdt011            LIKE pmdt_t.pmdt011, 
    pmdt019            LIKE pmdt_t.pmdt019, 
    pmdt019_desc       LIKE type_t.chr500, 
    pmdt020            LIKE pmdt_t.pmdt020, 
    pmdt021            LIKE pmdt_t.pmdt021, 
    pmdt021_desc       LIKE type_t.chr500, 
    pmdt022            LIKE pmdt_t.pmdt022, 
    pmdt023            LIKE pmdt_t.pmdt023, 
    pmdt023_desc       LIKE type_t.chr500, 
    pmdt024            LIKE pmdt_t.pmdt024, 
    pmdt026            LIKE pmdt_t.pmdt026, 
    pmdt062            LIKE pmdt_t.pmdt062, 
    pmdt016            LIKE pmdt_t.pmdt016, 
    pmdt016_desc       LIKE type_t.chr500, 
    pmdt017            LIKE pmdt_t.pmdt017, 
    pmdt017_desc       LIKE type_t.chr500, 
    pmdt018            LIKE pmdt_t.pmdt018,
    pmdt063            LIKE pmdt_t.pmdt063,    #161129-00037#1 add
    pmdt059            LIKE pmdt_t.pmdt059
                   END RECORD
       
 TYPE type_g_pmds3_d   RECORD
    keyno              LIKE type_t.num5,
    pmduseq            LIKE pmdu_t.pmduseq,
    pmduseq1           LIKE pmdu_t.pmduseq1,
    pmdu001            LIKE pmdu_t.pmdu001,
    pmdu001_desc       LIKE imaal_t.imaal003,
    pmdu001_desc_desc  LIKE imaal_t.imaal004,
    pmdu002            LIKE pmdu_t.pmdu002,
    pmdu003            LIKE pmdu_t.pmdu003,
    pmdu004            LIKE pmdu_t.pmdu004,
    pmdu005            LIKE pmdu_t.pmdu005,
    pmdu006            LIKE pmdu_t.pmdu006,
    pmdu006_desc       LIKE inaa_t.inaa002,
    pmdu007            LIKE pmdu_t.pmdu007,
    pmdu007_desc       LIKE inab_t.inab003,
    pmdu008            LIKE pmdu_t.pmdu008,
    pmdu009            LIKE pmdu_t.pmdu009,
    pmdu009_desc       LIKE oocal_t.oocal003,
    pmdu010            LIKE pmdu_t.pmdu010,
    pmdu011            LIKE pmdu_t.pmdu011,
    pmdu011_desc       LIKE oocal_t.oocal003,
    pmdu012            LIKE pmdu_t.pmdu012,
    pmdu013            LIKE pmdu_t.pmdu013,
    pmdu014            LIKE pmdu_t.pmdu014,
    pmdu015            LIKE pmdu_t.pmdu015 
                   END RECORD 

 TYPE type_g_pmds5_d   RECORD
    keyno              LIKE type_t.num5,
    pmdvseq            LIKE pmdv_t.pmdvseq,
    pmdvseq1           LIKE pmdv_t.pmdvseq1,
    pmdv001            LIKE pmdv_t.pmdv001,
    pmdv001_desc       LIKE imaal_t.imaal003,
    pmdv001_desc_desc  LIKE imaal_t.imaal004,
    pmdv002            LIKE pmdv_t.pmdv002,
    pmdv003            LIKE pmdv_t.pmdv003,
    pmdv004            LIKE pmdv_t.pmdv004,
    pmdv005            LIKE pmdv_t.pmdv005,
    pmdv006            LIKE pmdv_t.pmdv006,
    pmdv011            LIKE pmdv_t.pmdv011,
    pmdv012            LIKE pmdv_t.pmdv012,
    pmdv013            LIKE pmdv_t.pmdv013,
    pmdv014            LIKE pmdv_t.pmdv014,
    pmdv015            LIKE pmdv_t.pmdv015,
    pmdv016            LIKE pmdv_t.pmdv016,
    pmdv017            LIKE pmdv_t.pmdv017,
    pmdv018            LIKE pmdv_t.pmdv018,
    pmdv018_desc       LIKE oocal_t.oocal003,
    pmdv019            LIKE pmdv_t.pmdv019 
                   END RECORD
       
#於 gen_data 中使用
 TYPE type_pmdo        RECORD
    pmdodocno          LIKE pmdo_t.pmdodocno,
    pmdoseq            LIKE pmdo_t.pmdoseq,
    pmdoseq1           LIKE pmdo_t.pmdoseq1,
    pmdoseq2           LIKE pmdo_t.pmdoseq2,
    pmdt020            LIKE pmdt_t.pmdt020
                   END RECORD
 TYPE type_pmdl        RECORD
    pmdl004            LIKE pmdl_t.pmdl004,
    pmdl009            LIKE pmdl_t.pmdl009,
    pmdl010            LIKE pmdl_t.pmdl010,
    pmdl011            LIKE pmdl_t.pmdl011,
    pmdl012            LIKE pmdl_t.pmdl012,
    pmdl013            LIKE pmdl_t.pmdl013,
    pmdl015            LIKE pmdl_t.pmdl015,
    pmdl016            LIKE pmdl_t.pmdl016,
    pmdl017            LIKE pmdl_t.pmdl017,
    pmdl005            LIKE pmdl_t.pmdl005,
    pmdl006            LIKE pmdl_t.pmdl006,
    pmdl054            LIKE pmdl_t.pmdl054,
    pmdl055            LIKE pmdl_t.pmdl055,
    pmdo003            LIKE pmdo_t.pmdo003,
    pmdo001            LIKE pmdo_t.pmdo001,
    pmdo002            LIKE pmdo_t.pmdo002,
    pmdn004            LIKE pmdn_t.pmdn004,
    pmdn005            LIKE pmdn_t.pmdn005,
    pmdo004            LIKE pmdo_t.pmdo004,
    pmdo028            LIKE pmdo_t.pmdo028,
    pmdo029            LIKE pmdo_t.pmdo029,
    pmdo030            LIKE pmdo_t.pmdo030,
    pmdo031            LIKE pmdo_t.pmdo031,
    pmdn028            LIKE pmdn_t.pmdn028,
    pmdn029            LIKE pmdn_t.pmdn029,
    pmdn030            LIKE pmdn_t.pmdn030,
    pmdn050            LIKE pmdn_t.pmdn050,
    pmdn053            LIKE pmdn_t.pmdn053
                   END RECORD 
 
 
DEFINE g_pmds_d        DYNAMIC ARRAY OF type_g_pmds_d
DEFINE g_pmds_d_t      type_g_pmds_d
DEFINE g_pmds2_d       DYNAMIC ARRAY OF type_g_pmds2_d
DEFINE g_pmds2_d_t     type_g_pmds2_d
DEFINE g_pmds3_d       DYNAMIC ARRAY OF type_g_pmds3_d
DEFINE g_pmds3_d_t     type_g_pmds3_d
DEFINE g_pmds5_d       DYNAMIC ARRAY OF type_g_pmds5_d
DEFINE g_pmds5_d_t     type_g_pmds5_d

DEFINE g_master_idx    LIKE type_t.num5
DEFINE l_ac            LIKE type_t.num5
DEFINE g_rec_b         LIKE type_t.num5
DEFINE g_rec_b2        LIKE type_t.num5
DEFINE g_rec_b3        LIKE type_t.num5
DEFINE g_rec_b4        LIKE type_t.num5
DEFINE g_rec_b5        LIKE type_t.num5
DEFINE g_flag          LIKE type_t.num5
DEFINE g_qty           LIKE pmdt_t.pmdt020
DEFINE g_pmdo006       LIKE pmdo_t.pmdo006
DEFINE g_pmdn022       LIKE pmdn_t.pmdn022
DEFINE g_pmdsdocno     LIKE type_t.chr10
DEFINE g_cnt           LIKE type_t.num5
#161006-00018#22-S
GLOBALS
   DEFINE g_pmdsdocno          LIKE pmds_t.pmdsdocno
END GLOBALS
#161006-00018#22-E
DEFINE g_pmdl028       LIKE pmdl_t.pmdl028    #161207-00033#21
#end add-point
 
{</section>}
 
{<section id="apmp520_02.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"
 
#end add-point
 
{</section>}
 
{<section id="apmp520_02.other_dialog" >}

DIALOG apmp520_02_display()
   DISPLAY ARRAY g_pmds_d TO s_detail1_apmp520_02.* ATTRIBUTE(COUNT = g_rec_b)
      BEFORE DISPLAY
         CALL FGL_SET_ARR_CURR(l_ac)

      BEFORE ROW
        LET l_ac = DIALOG.getCurrentRow("s_detail1_apmp520_02")
        LET g_master_idx = l_ac
        CALL apmp520_02_fetch('1')
        #DISPLAY g_d_idx_p49001 TO FORMONLY.idx
        # 點的當筆放入g_appoint_idx中, 可讓雙擊直接進入指定筆
   END DISPLAY
END DIALOG

DIALOG apmp520_02_input2()
   INPUT ARRAY g_pmds2_d FROM s_detail2_apmp520_02.*
      ATTRIBUTE(COUNT = g_rec_b2,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                INSERT ROW = FALSE,
                DELETE ROW = FALSE,
                APPEND ROW = FALSE)
                
      BEFORE INPUT
      
      BEFORE ROW
         LET l_ac = ARR_CURR()    
         
         SELECT keyno  , pmdtseq, pmdt001, pmdt002, pmdt003,  
                pmdt004, pmdt005, pmdo001,      '',      '',  
                pmdt006,      '',      '', pmdt007, pmdt009,  
                pmdt010, pmdt011, pmdt019,      '', pmdt020,  
                pmdt021,      '', pmdt022, pmdt023,      '',  
                pmdt024, pmdt026, pmdt062, pmdt016,      '',  
                pmdt017,      '', pmdt018, pmdt063, pmdt059    #161129-00037#1 add pmdt063
           INTO g_pmds2_d[l_ac].*
           FROM apmp520_tmp02  #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d2 ——> apmp520_tmp02
          WHERE keyno = g_pmds2_d[l_ac].keyno
            AND pmdtseq = g_pmds2_d[l_ac].pmdtseq
         CALL apmp520_02_detail_show("'2'")   
         LET g_pmds2_d_t.* = g_pmds2_d[l_ac].*
         CALL apmp520_02_set_entry_b()
         CALL apmp520_02_set_no_entry_b()
         
      AFTER FIELD pmdt006_d2_02
         LET g_pmds2_d[l_ac].pmdt006_desc = ''
         LET g_pmds2_d[l_ac].pmdt006_desc_desc = ''
         IF NOT cl_null(g_pmds2_d[l_ac].pmdt006) THEN      
            IF NOT apmp520_02_chk_pmdt006(g_pmds_d[g_master_idx].pmds007,g_pmds2_d[l_ac].pmdo001,g_pmds2_d[l_ac].pmdt006,g_pmds2_d[l_ac].pmdt007) THEN
               LET g_pmds2_d[l_ac].pmdt006 = g_pmds2_d_t.pmdt006
               CALL s_desc_get_item_desc(g_pmds2_d[l_ac].pmdt006)
                    RETURNING g_pmds2_d[l_ac].pmdt006_desc,g_pmds2_d[l_ac].pmdt006_desc_desc
               NEXT FIELD CURRENT
            END IF
            #161205-00035#1 mark(s)
#            LET g_pmds2_d[l_ac].pmdt026 = ''
#            IF (NOT cl_null(g_pmds2_d[l_ac].pmdt009)) AND (NOT cl_null(g_pmds2_d[l_ac].pmdt010)) THEN
#               SELECT qcap006 INTO g_pmds2_d[l_ac].pmdt026
#                 FROM qcap_t
#                 WHERE qcapent = g_enterprise AND qcapsite = g_site
#                   AND qcap001 = g_pmds2_d[l_ac].pmdt006
#                   AND qcap002 = g_pmds_d[g_master_idx].pmds007
#                   AND qcap003 = g_pmds2_d[l_ac].pmdt009
#                   AND qcap004 = g_pmds2_d[l_ac].pmdt010
#                   AND qcap005 = g_pmds2_d[l_ac].pmdt007
#            END IF
#
#            IF cl_null(g_pmds2_d[l_ac].pmdt026) THEN
#               LET g_pmds2_d[l_ac].pmdt026 = 'N'
#            END IF
#             
#            IF g_pmds_d[g_master_idx].ooac004 = 'Y' THEN
#               LET g_pmds2_d[l_ac].pmdt026 = 'N'
#            END IF
#            #161205-00035#1 mark(e)
            #預設沖銷順序
            IF g_pmds2_d[l_ac].pmdt006 != g_pmds2_d_t.pmdt006 OR g_pmds2_d_t.pmdt006 IS NULL THEN
               CALL apmp520_02_def_pmdt011()     
            END IF    
         END IF
         
         CALL s_desc_get_item_desc(g_pmds2_d[l_ac].pmdt006) 
              RETURNING g_pmds2_d[l_ac].pmdt006_desc,g_pmds2_d[l_ac].pmdt006_desc_desc
         LET g_pmds2_d_t.pmdt006 = g_pmds2_d[l_ac].pmdt006 
         
      AFTER FIELD pmdt007_d2_02
         IF NOT cl_null(g_pmds2_d[l_ac].pmdt007) THEN
            IF g_pmds2_d[l_ac].pmdt007 != g_pmds2_d_t.pmdt007 OR g_pmds2_d_t.pmdt007 IS NULL THEN
               IF NOT cl_null(g_pmds2_d[l_ac].pmdt006) THEN
                  #預設沖銷順序
                  CALL apmp520_02_def_pmdt011()
               END IF
            END IF
         END IF   
         LET g_pmds2_d_t.pmdt007 = g_pmds2_d[l_ac].pmdt007  
         
      AFTER FIELD pmdt011_d2_02
         IF NOT cl_ap_chk_Range(g_pmds2_d[l_ac].pmdt011,"0","0","","","azz-00079",1) THEN
            LET g_pmds2_d[l_ac].pmdt011 = g_pmds2_d_t.pmdt011
            NEXT FIELD pmdt011_d2_02
         END IF
         
         #沖銷順序
         IF NOT cl_null(g_pmds2_d[l_ac].pmdt011) AND NOT cl_null(g_pmds2_d[l_ac].pmdt006) THEN
            IF NOT apmp520_02_chk_pmdt011() THEN
               LET g_pmds2_d[l_ac].pmdt011 = g_pmds2_d_t.pmdt011
               NEXT FIELD pmdt011_d2_02
            END IF
         END IF  
         
      AFTER FIELD pmdt020_d2_02
         IF NOT cl_ap_chk_Range(g_pmds2_d[l_ac].pmdt020,"0","0","","","azz-00079",1) THEN
            LET g_pmds2_d[l_ac].pmdt020 = g_pmds2_d_t.pmdt020
            NEXT FIELD pmdt020_d2_02
         END IF

         IF NOT cl_null(g_pmds2_d[l_ac].pmdt020) THEN
            LET g_qty = 0
            CALL s_apmt520_get_quantity(g_pmds2_d[l_ac].pmdt001,g_pmds2_d[l_ac].pmdt002,g_pmds2_d[l_ac].pmdt003,g_pmds2_d[l_ac].pmdt004)
                 RETURNING g_qty
            IF g_pmds2_d[l_ac].pmdt020 > g_qty THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'apm-00383'
               LET g_errparam.extend = g_pmds2_d[l_ac].pmdt020
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_pmds2_d[l_ac].pmdt020 = g_pmds2_d_t.pmdt020
               NEXT FIELD pmdt020_d2_02
            END IF

            LET g_pmdo006 = ''
            CALL apmp520_01_default_quantity(g_pmds2_d[l_ac].pmdt001,g_pmds2_d[l_ac].pmdt002,g_pmds2_d[l_ac].pmdt003,g_pmds2_d[l_ac].pmdt004)
                 RETURNING g_pmdo006

            LET g_pmdn022 = ''
            SELECT pmdn022 INTO g_pmdn022
              FROM pmdn_t
             WHERE pmdnent = g_enterprise
               AND pmdndocno = g_pmds2_d[l_ac].pmdt001
               AND pmdnseq = g_pmds2_d[l_ac].pmdt002

            IF g_pmds2_d[l_ac].pmdt020 < g_pmdo006 AND g_pmdn022 = 'N' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'apm-00382'
               LET g_errparam.extend = g_pmds2_d[l_ac].pmdt020
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_pmds2_d[l_ac].pmdt020 = g_pmds2_d_t.pmdt020
               NEXT FIELD pmdt020_d2_02
            END IF
         END IF

         #自動換算參考數量、計價數量
         IF NOT cl_null(g_pmds2_d[l_ac].pmdt021) THEN
            CALL s_aooi250_convert_qty(g_pmds2_d[l_ac].pmdt006,g_pmds2_d[l_ac].pmdt019,g_pmds2_d[l_ac].pmdt021,g_pmds2_d[l_ac].pmdt020)
                 RETURNING g_flag,g_pmds2_d[l_ac].pmdt022
         END IF
        
         IF NOT cl_null(g_pmds2_d[l_ac].pmdt023) THEN
            CALL s_aooi250_convert_qty(g_pmds2_d[l_ac].pmdt006,g_pmds2_d[l_ac].pmdt019,g_pmds2_d[l_ac].pmdt023,g_pmds2_d[l_ac].pmdt020)
                 RETURNING g_flag,g_pmds2_d[l_ac].pmdt024
         END IF
         
      ON CHANGE pmdt062_d2_02
         IF g_pmds2_d[l_ac].pmdt062 = 'N' THEN
            LET g_cnt = 0 
            SELECT COUNT(*) INTO g_cnt
              FROM apmp520_tmp03   #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d3 ——> apmp520_tmp03
             WHERE keyno = g_pmds2_d[l_ac].keyno
               AND pmduseq = g_pmds2_d[l_ac].pmdtseq
            IF g_cnt > 0 THEN
               IF cl_ask_confirm('apm-00559') THEN
                  DELETE FROM apmp520_tmp03  #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d3 ——> apmp520_tmp03
                   WHERE keyno = g_pmds2_d[l_ac].keyno
                     AND pmduseq = g_pmds2_d[l_ac].pmdtseq
               ELSE
                  LET g_pmds2_d[l_ac].pmdt062 = 'Y'
               END IF
            END IF
         ELSE
            CALL apmp520_02_update_temp2()
            IF NOT apmp520_04(g_pmds2_d[l_ac].keyno,g_pmds2_d[l_ac].pmdtseq) THEN
               LET g_cnt = 0 
               SELECT COUNT(*) INTO g_cnt
                 FROM apmp520_tmp03   #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d3 ——> apmp520_tmp03
                WHERE keyno = g_pmds2_d[l_ac].keyno
                  AND pmduseq = g_pmds2_d[l_ac].pmdtseq
               IF g_cnt = 0 THEN
                  LET g_pmds2_d[l_ac].pmdt062 = 'N'
                  NEXT FIELD CURRENT
               END IF
            END IF
         END IF

         IF g_pmds2_d[l_ac].pmdt062 = 'Y' THEN
            LET g_pmds2_d[l_ac].pmdt016 = ''
            LET g_pmds2_d[l_ac].pmdt016_desc = ''
            LET g_pmds2_d[l_ac].pmdt017 = ''
            LET g_pmds2_d[l_ac].pmdt017_desc = ''
            LET g_pmds2_d[l_ac].pmdt018 = ''
            IF NOT cl_null(g_pmds2_d[l_ac].pmdt006) THEN
               #預設沖銷順序
               CALL apmp520_02_def_pmdt011()
            END IF
         END IF 
         CALL apmp520_02_set_entry_b()
         CALL apmp520_02_set_no_entry_b()
         
      AFTER FIELD pmdt016_d2_02
         LET g_pmds2_d[l_ac].pmdt016_desc = ''
         IF NOT cl_null(g_pmds2_d[l_ac].pmdt016) THEN
            IF g_pmds2_d[l_ac].pmdt016 != g_pmds2_d_t.pmdt016 OR g_pmds2_d_t.pmdt016 IS NULL THEN
               IF NOT apmp520_02_pmdn050_chk() THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_pmds2_d[l_ac].pmdt016
                  #160318-00025#20  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
                  #160318-00025#20  by 07900 --add-end
                  IF NOT cl_chk_exist("v_inaa001_9") THEN
                     LET g_pmds2_d[l_ac].pmdt016 = g_pmds2_d_t.pmdt016
                  CALL s_desc_get_stock_desc(g_site,g_pmds2_d[l_ac].pmdt016)
                       RETURNING g_pmds2_d[l_ac].pmdt016_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
               
               #儲位值清空
               LET g_pmds2_d[l_ac].pmdt017 = ' '
               LET g_pmds2_d[l_ac].pmdt017_desc = '' 
               LET g_pmds2_d_t.pmdt017 = ' '
               IF NOT cl_null(g_pmds2_d[l_ac].pmdt006) THEN
                  #預設沖銷順序
                  CALL apmp520_02_def_pmdt011()
               END IF
            END IF
         END IF   
         LET g_pmds2_d_t.pmdt016 = g_pmds2_d[l_ac].pmdt016  
         CALL s_desc_get_stock_desc(g_site,g_pmds2_d[l_ac].pmdt016)
              RETURNING g_pmds2_d[l_ac].pmdt016_desc
       

      AFTER FIELD pmdt017_d2_02         
         LET g_pmds2_d[l_ac].pmdt017_desc = ''
         IF NOT cl_null(g_pmds2_d[l_ac].pmdt017) THEN
            IF g_pmds2_d[l_ac].pmdt017 != g_pmds2_d_t.pmdt017 OR g_pmds2_d_t.pmdt017 IS NULL THEN
               IF NOT apmp520_02_pmdn050_chk() THEN
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_site
                  LET g_chkparam.arg2 = g_pmds2_d[l_ac].pmdt016
                  LET g_chkparam.arg3 = g_pmds2_d[l_ac].pmdt017
                  IF NOT cl_chk_exist("v_inab002_1") THEN
                     #檢查失敗時後續處理
                     LET g_pmds2_d[l_ac].pmdt017 = g_pmds2_d_t.pmdt017
                     CALL s_desc_get_locator_desc(g_site,g_pmds2_d[l_ac].pmdt016,g_pmds2_d[l_ac].pmdt017)
                          RETURNING g_pmds2_d[l_ac].pmdt017_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
               
               IF NOT cl_null(g_pmds2_d[l_ac].pmdt006) THEN
                  #預設沖銷順序
                  CALL apmp520_02_def_pmdt011()
               END IF
            END IF
         END IF   
         LET g_pmds2_d_t.pmdt017 = g_pmds2_d[l_ac].pmdt017  
         CALL s_desc_get_locator_desc(g_site,g_pmds2_d[l_ac].pmdt016,g_pmds2_d[l_ac].pmdt017)
              RETURNING g_pmds2_d[l_ac].pmdt017_desc
          
      AFTER FIELD pmdt018_d2_02
         IF NOT cl_null(g_pmds2_d[l_ac].pmdt018) THEN
            IF g_pmds2_d[l_ac].pmdt018 != g_pmds2_d_t.pmdt018 OR g_pmds2_d_t.pmdt018 IS NULL THEN
               IF NOT cl_null(g_pmds2_d[l_ac].pmdt006) THEN
                  #預設沖銷順序
                  CALL apmp520_02_def_pmdt011()
               END IF
            END IF
         END IF   
         LET g_pmds2_d_t.pmdt018 = g_pmds2_d[l_ac].pmdt018  
         
      ON ROW CHANGE
         #沖銷順序
         IF NOT cl_null(g_pmds2_d[l_ac].pmdt011) AND NOT cl_null(g_pmds2_d[l_ac].pmdt006) THEN
            IF NOT apmp520_02_chk_pmdt011() THEN
               LET g_pmds2_d[l_ac].pmdt011 = g_pmds2_d_t.pmdt011
               NEXT FIELD pmdt011_d2_02
            END IF
         END IF  
         CALL apmp520_02_update_temp2()
         IF g_pmds2_d[l_ac].pmdt062 = 'N' THEN
            CALL apmp520_02_update_temp3()
         END IF
         
      AFTER INPUT
         CALL apmp520_02_refresh_pmdv()
         
         
      ON ACTION controlp
         CASE
            WHEN INFIELD(pmdt006_d2_02)
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_pmds2_d[l_ac].pmdt006
               CALL q_imaf001_15()                                #呼叫開窗                     
               LET g_pmds2_d[l_ac].pmdt006 = g_qryparam.return1   #將開窗取得的值回傳到變數
               CALL s_desc_get_item_desc(g_pmds2_d[l_ac].pmdt006) 
                    RETURNING g_pmds2_d[l_ac].pmdt006_desc,g_pmds2_d[l_ac].pmdt006_desc_desc                  
               NEXT FIELD pmdt006_d2_02 
            WHEN INFIELD(pmdt016_d2_02)
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_pmds2_d[l_ac].pmdt016      #給予default值
               CALL q_inaa001_2()                                     #呼叫開窗
               LET g_pmds2_d[l_ac].pmdt016 = g_qryparam.return1       #將開窗取得的值回傳到變數
               DISPLAY g_pmds2_d[l_ac].pmdt016 TO pmdt016_d2_02
               CALL s_desc_get_stock_desc(g_site,g_pmds2_d[l_ac].pmdt016) 
                    RETURNING g_pmds2_d[l_ac].pmdt016_desc               
               NEXT FIELD CURRENT
            WHEN INFIELD(pmdt017_d2_02)
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = g_pmds2_d[l_ac].pmdt016
               LET g_qryparam.default1 = g_pmds2_d[l_ac].pmdt017      #給予default值
               CALL q_inab002_3()                                     #呼叫開窗
               LET g_pmds2_d[l_ac].pmdt017 = g_qryparam.return1       #將開窗取得的值回傳到變數
               DISPLAY g_pmds2_d[l_ac].pmdt017 TO pmdt017_d2_02
               CALL s_desc_get_locator_desc(g_site,g_pmds2_d[l_ac].pmdt016,g_pmds2_d[l_ac].pmdt017)
                    RETURNING g_pmds2_d[l_ac].pmdt017_desc                
               NEXT FIELD CURRENT
         END CASE               
         
   END INPUT
END DIALOG

DIALOG apmp520_02_display3()
   DISPLAY ARRAY g_pmds3_d TO s_detail3_apmp520_02.* ATTRIBUTE(COUNT = g_rec_b3)
      BEFORE DISPLAY
         CALL FGL_SET_ARR_CURR(l_ac)
         CALL apmp520_02_fetch('2')

      BEFORE ROW
        LET l_ac = DIALOG.getCurrentRow("s_detail3_apmp520_02")

   END DISPLAY
END DIALOG

DIALOG apmp520_02_display5()
   DISPLAY ARRAY g_pmds5_d TO s_detail5_apmp520_02.* ATTRIBUTE(COUNT = g_rec_b5)
      BEFORE DISPLAY
         CALL FGL_SET_ARR_CURR(l_ac)
         CALL apmp520_02_fetch('2')
         
      BEFORE ROW
         LET l_ac = DIALOG.getCurrentRow("s_detail5_apmp520_02")

   END DISPLAY
END DIALOG

################################################################################
# Descriptions...: 收貨明細頁籤的顯示段(display)
# Memo...........:
# Usage..........: CALL apmp520_02_display2()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/02/25 By Ken  #151118-00029#2
# Modify.........:
################################################################################
DIALOG apmp520_02_display2()
   DISPLAY ARRAY g_pmds2_d TO s_detail2_apmp520_02.* ATTRIBUTE(COUNT = g_rec_b2)
      BEFORE DISPLAY
         CALL FGL_SET_ARR_CURR(l_ac)
         CALL apmp520_02_fetch('2')
         
      BEFORE ROW
        LET l_ac = DIALOG.getCurrentRow("s_detail2_apmp520_02")

   END DISPLAY
END DIALOG

 
{</section>}
 
{<section id="apmp520_02.other_function" readonly="Y" >}

PUBLIC FUNCTION apmp520_02()

END FUNCTION

PUBLIC FUNCTION apmp520_02_init()

   WHENEVER ERROR CONTINUE
   
   CALL cl_set_combo_scc('pmds011_d1_02','2061')
   CALL cl_set_combo_scc('pmds048_d1_02','2087')
   CALL cl_set_combo_scc('pmds049_d1_02','2086')
   CALL cl_set_combo_scc('pmdt005_d2_02','2055')
   CALL cl_set_combo_scc('pmdv005_d5_02','2055')
END FUNCTION

PUBLIC FUNCTION apmp520_02_create_temp_table()
DEFINE r_success         LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   IF NOT apmp520_02_drop_temp_table() THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   CREATE TEMP TABLE apmp520_tmp01(   #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d1 ——> apmp520_tmp01
       keyno      LIKE type_t.num5,
       pmdsdocno  LIKE pmds_t.pmdsdocno,
       pmds007    LIKE pmds_t.pmds007, 
       pmds031    LIKE pmds_t.pmds031, 
       pmds032    LIKE pmds_t.pmds032, 
       pmds033    LIKE pmds_t.pmds033, 
       pmds034    LIKE pmds_t.pmds034, 
       pmds035    LIKE pmds_t.pmds035, 
       pmds037    LIKE pmds_t.pmds037, 
       pmds038    LIKE pmds_t.pmds038, 
       pmds039    LIKE pmds_t.pmds039,
       ooac004    LIKE ooac_t.ooac004,
       pmds011    LIKE pmds_t.pmds011,
       pmds048    LIKE pmds_t.pmds048,
       pmds049    LIKE pmds_t.pmds049,
       result_str LIKE type_t.chr1000,
       pmdl028    LIKE pmdl_t.pmdl028   
      )   #161006-00018#22 add pmds028
   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create apmp520_tmp01'  #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d1 ——> apmp520_tmp01
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CREATE TEMP TABLE apmp520_tmp02(  #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d2 ——> apmp520_tmp02
       keyno              LIKE type_t.num5,
       pmdtseq            LIKE pmdt_t.pmdtseq, 
       pmdt001            LIKE pmdt_t.pmdt001, 
       pmdt002            LIKE pmdt_t.pmdt002, 
       pmdt003            LIKE pmdt_t.pmdt003, 
       pmdt004            LIKE pmdt_t.pmdt004, 
       pmdt005            LIKE pmdt_t.pmdt005,
       pmdo001            LIKE pmdo_t.pmdo001,
       pmdt006            LIKE pmdt_t.pmdt006, 
       pmdt007            LIKE pmdt_t.pmdt007, 
       pmdt009            LIKE pmdt_t.pmdt009, 
       pmdt010            LIKE pmdt_t.pmdt010, 
       pmdt011            LIKE pmdt_t.pmdt011, 
       pmdt019            LIKE pmdt_t.pmdt019, 
       pmdt020            LIKE pmdt_t.pmdt020, 
       pmdt021            LIKE pmdt_t.pmdt021, 
       pmdt022            LIKE pmdt_t.pmdt022, 
       pmdt023            LIKE pmdt_t.pmdt023, 
       pmdt024            LIKE pmdt_t.pmdt024, 
       pmdt026            LIKE pmdt_t.pmdt026, 
       pmdt062            LIKE pmdt_t.pmdt062, 
       pmdt016            LIKE pmdt_t.pmdt016, 
       pmdt017            LIKE pmdt_t.pmdt017, 
       pmdt018            LIKE pmdt_t.pmdt018,
       pmdt063            LIKE pmdt_t.pmdt063,  #161129-00037#1 add pmdt063
       pmdt059            LIKE pmdt_t.pmdt059
      )
   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create apmp520_tmp02'  #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d2 ——> apmp520_tmp02
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CREATE TEMP TABLE apmp520_tmp03(   #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d3 ——> apmp520_tmp03
       keyno              LIKE type_t.num5,
       pmduseq            LIKE pmdu_t.pmduseq,
       pmduseq1           LIKE pmdu_t.pmduseq1,
       pmdu001            LIKE pmdu_t.pmdu001,
       pmdu002            LIKE pmdu_t.pmdu002,
       pmdu003            LIKE pmdu_t.pmdu003,
       pmdu004            LIKE pmdu_t.pmdu004,
       pmdu005            LIKE pmdu_t.pmdu005,
       pmdu006            LIKE pmdu_t.pmdu006,
       pmdu007            LIKE pmdu_t.pmdu007,
       pmdu008            LIKE pmdu_t.pmdu008,
       pmdu009            LIKE pmdu_t.pmdu009,
       pmdu010            LIKE pmdu_t.pmdu010,
       pmdu011            LIKE pmdu_t.pmdu011,
       pmdu012            LIKE pmdu_t.pmdu012,
       pmdu013            LIKE pmdu_t.pmdu013,
       pmdu014            LIKE pmdu_t.pmdu014,
       pmdu015            LIKE pmdu_t.pmdu015
      )
   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create apmp520_tmp03'   #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d3 ——> apmp520_tmp03
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CREATE TEMP TABLE apmp520_tmp04(  #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d5 ——> apmp520_tmp04
       keyno              LIKE type_t.num5,
       pmdvseq            LIKE pmdv_t.pmdvseq,
       pmdvseq1           LIKE pmdv_t.pmdvseq1,
       pmdv001            LIKE pmdv_t.pmdv001,
       pmdv002            LIKE pmdv_t.pmdv002,
       pmdv003            LIKE pmdv_t.pmdv003,
       pmdv004            LIKE pmdv_t.pmdv004,
       pmdv005            LIKE pmdv_t.pmdv005,
       pmdv006            LIKE pmdv_t.pmdv006,
       pmdv011            LIKE pmdv_t.pmdv011,
       pmdv012            LIKE pmdv_t.pmdv012,
       pmdv013            LIKE pmdv_t.pmdv013,
       pmdv014            LIKE pmdv_t.pmdv014,
       pmdv015            LIKE pmdv_t.pmdv015,
       pmdv016            LIKE pmdv_t.pmdv016,
       pmdv017            LIKE pmdv_t.pmdv017,
       pmdv018            LIKE pmdv_t.pmdv018,
       pmdv019            LIKE pmdv_t.pmdv019 
      )
   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create apmp520_tmp04'  #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d5 ——> apmp520_tmp04
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

PUBLIC FUNCTION apmp520_02_drop_temp_table()
DEFINE r_success          LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   DROP TABLE apmp520_tmp01  #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d1 ——> apmp520_tmp01

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop apmp520_tmp01'  #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d1 ——> apmp520_tmp01
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   DROP TABLE apmp520_tmp02  #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d2 ——> apmp520_tmp02

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop apmp520_tmp02'  #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d2 ——> apmp520_tmp02
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   DROP TABLE apmp520_tmp03   #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d3 ——> apmp520_tmp03

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop apmp520_tmp03'   #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d3 ——> apmp520_tmp03
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   DROP TABLE apmp520_tmp04  #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d5 ——> apmp520_tmp04

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop apmp520_tmp04'  #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d5 ——> apmp520_tmp04
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...:　將apmp520_01_temp　的資料　整理成apmp520_02　可使用的資料
# Memo...........:
# Usage..........: CALL apmp520_02_gen_data(p_pmdsdocno)
#                  RETURNING r_success
# Input parameter: p_pmdsdocno    收貨單別
# Return code....: r_success      執行結果
# Date & Author..: 2014/06/24 By benson
# Modify.........: 20150112 by whitney add insert pmdu_t
################################################################################
PUBLIC FUNCTION apmp520_02_gen_data(p_pmdsdocno)
DEFINE p_pmdsdocno     LIKE pmds_t.pmdsdocno
DEFINE r_success       LIKE type_t.num5
DEFINE l_sql           STRING
DEFINE l_pmdo          type_pmdo
DEFINE l_pmdl          type_pmdl
DEFINE l_keyno         LIKE type_t.num5
DEFINE l_slip          LIKE type_t.chr10
DEFINE l_success       LIKE type_t.num5
DEFINE l_ooac004       LIKE ooac_t.ooac004
DEFINE l_pmds011       LIKE pmds_t.pmds011
DEFINE l_pmdtseq       LIKE pmdt_t.pmdtseq
DEFINE l_pmdt011       LIKE pmdt_t.pmdt011
DEFINE l_pmdt026       LIKE pmdt_t.pmdt026
DEFINE l_pmdu013       LIKE pmdu_t.pmdu013
DEFINE l_pmdn052       LIKE pmdn_t.pmdn052   #add--2015/03/30 By shiun
#160617-00005#5---s--
DEFINE l_imaf061    LIKE imaf_t.imaf061
DEFINE l_imaf062    LIKE imaf_t.imaf062
DEFINE l_imaf063    LIKE imaf_t.imaf063
DEFINE l_oofg_return DYNAMIC ARRAY OF RECORD    
          oofg019     LIKE oofg_t.oofg019,   #field
          oofg020     LIKE oofg_t.oofg020    #value
                  END RECORD
#160617-00005#5---e--
DEFINE l_pmdl028    LIKE pmdl_t.pmdl028  #161207-00033#21

   WHENEVER ERROR CONTINUE

   DELETE FROM apmp520_tmp01   #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d1 ——> apmp520_tmp01
   DELETE FROM apmp520_tmp02   #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d2 ——> apmp520_tmp02
   DELETE FROM apmp520_tmp03   #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d3 ——> apmp520_tmp03
   DELETE FROM apmp520_tmp04   #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d5 ——> apmp520_tmp04
   
   LET g_pmdsdocno = p_pmdsdocno
   
   LET l_sql = "SELECT pmdodocno,pmdoseq,pmdoseq1,pmdoseq2,pmdt020 ",
               "  FROM apmp520_01_temp",
               " ORDER BY pmdodocno,pmdoseq,pmdoseq1,pmdoseq2 "
   PREPARE apmp520_02_pre1 FROM l_sql
   DECLARE apmp520_02_curs1 CURSOR WITH HOLD FOR apmp520_02_pre1

   FOREACH apmp520_02_curs1 INTO l_pmdo.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'FOREACH:apmp520_02_curs1'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      INITIALIZE l_pmdl.* TO NULL 
      INITIALIZE l_pmdn052,l_pmdl028 TO NULL  #161230-00019#2
      SELECT pmdl004,pmdl009,pmdl010,pmdl011,pmdl012,
             pmdl013,pmdl015,pmdl016,pmdl017,pmdl005,
             pmdl006,pmdl054,pmdl055,
             pmdo003,pmdo001,pmdo002,pmdn004,pmdn005,
             pmdo004,pmdo028,pmdo029,pmdo030,pmdo031,
             pmdn028,pmdn029,pmdn030,pmdn050,pmdn053,
             pmdn052,pmdl028   #add--2015/03/30 By shiun  #161207-00033#21 add pmdl028
        INTO l_pmdl.pmdl004,l_pmdl.pmdl009,l_pmdl.pmdl010,l_pmdl.pmdl011,l_pmdl.pmdl012,
             l_pmdl.pmdl013,l_pmdl.pmdl015,l_pmdl.pmdl016,l_pmdl.pmdl017,l_pmdl.pmdl005,
             l_pmdl.pmdl006,l_pmdl.pmdl054,l_pmdl.pmdl055,
             l_pmdl.pmdo003,l_pmdl.pmdo001,l_pmdl.pmdo002,l_pmdl.pmdn004,l_pmdl.pmdn005,
             l_pmdl.pmdo004,l_pmdl.pmdo028,l_pmdl.pmdo029,l_pmdl.pmdo030,l_pmdl.pmdo031,
             l_pmdl.pmdn028,l_pmdl.pmdn029,l_pmdl.pmdn030,l_pmdl.pmdn050,l_pmdl.pmdn053,
             l_pmdn052,l_pmdl028   #add--2015/03/30 By shiun  #161207-00033#21 add pmdl028
        FROM pmdl_t,pmdn_t,pmdo_t
       WHERE pmdlent = pmdnent AND pmdldocno = pmdndocno
         AND pmdnent = pmdoent AND pmdndocno = pmdodocno AND pmdnseq = pmdoseq 
         AND pmdodocno = l_pmdo.pmdodocno
         AND pmdoseq = l_pmdo.pmdoseq
         AND pmdoseq1 = l_pmdo.pmdoseq1
         AND pmdoseq2 = l_pmdo.pmdoseq2
         AND pmdoent = g_enterprise   #161230-00019#2
       
      LET l_slip = ''
      CALL s_aooi200_get_slip(l_pmdo.pmdodocno) RETURNING l_success,l_slip
      LET l_ooac004 = ''
      CALL cl_get_doc_para(g_enterprise,g_site,l_slip,'D-BAS-0074') RETURNING l_ooac004
      
      #161103-00015#1  --begin--
      #預帶預設庫位的值，aooi200抓值優先順序：預設欄位>應用參數
      IF cl_null(l_pmdl.pmdn028) THEN
         #預設欄位
         CALL s_aooi200_get_doc_default(g_site,'1',l_slip,'pmdt016',l_pmdl.pmdn028)
              RETURNING l_pmdl.pmdn028
         #應用參數
         IF cl_null(l_pmdl.pmdn028) THEN
            CALL cl_get_doc_para(g_enterprise,g_site,l_slip,'D-MFG-0076')
                 RETURNING l_pmdl.pmdn028
         END IF
      END IF
      #預設料件的庫儲
      IF cl_null(l_pmdl.pmdn028) THEN
         SELECT imaf091,imaf092 INTO l_pmdl.pmdn028,l_pmdl.pmdn029
           FROM imaf_t
          WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = l_pmdl.pmdo001
      END IF
      IF l_pmdl.pmdn029 IS NULL THEN
         SELECT imaf092 INTO l_pmdl.pmdn029
           FROM imaf_t
          WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = l_pmdl.pmdo001
      END IF
      #161103-00015#1  --end--

      #依據輸入的採購單號的採購性質(pmdl005)與多角性質(pmdl006)的值設[C:採購性質]欄位的值，
      LET l_pmds011 = ''
      IF l_pmdl.pmdl005 MATCHES '[14]' AND l_pmdl.pmdl006 = '1' THEN
         LET l_pmds011 = '1'
      END IF
      IF l_pmdl.pmdl005 MATCHES '[14]' AND l_pmdl.pmdl006 MATCHES '[45]' THEN
         LET l_pmds011 = '7'
      END IF
      IF l_pmdl.pmdl005 = '3' THEN
         LET l_pmds011 = '9'
      END IF
      #161215-00003-s-add 
      #採購性質='2.委外採購'
      IF l_pmdl.pmdl005 = '2' THEN
         LET l_pmds011 = '2'
      END IF
      #161215-00003-e-add
      
      #還沒有規則前 都先給1
      IF cl_null(l_pmds011) THEN
         LET l_pmds011 = '1'
      END IF
      
      LET l_keyno = ''   
      IF cl_null(l_pmdl028) THEN   #161230-00019#2
         SELECT keyno INTO l_keyno 
           FROM apmp520_tmp01  #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d1 ——> apmp520_tmp01
          WHERE pmds007 = l_pmdl.pmdl004
            AND pmds031 = l_pmdl.pmdl009
            AND pmds032 = l_pmdl.pmdl010
            AND pmds033 = l_pmdl.pmdl011
            AND pmds034 = l_pmdl.pmdl012
            AND pmds035 = l_pmdl.pmdl013
            AND pmds037 = l_pmdl.pmdl015
            AND pmds038 = l_pmdl.pmdl016
            AND pmds039 = l_pmdl.pmdl017
            AND ooac004 = l_ooac004
            AND pmds048 = l_pmdl.pmdl054 
            AND pmds049 = l_pmdl.pmdl055 
            AND pmds011 = l_pmds011
      #161230-00019#2-s-add
            AND pmdl028 IS NULL      
      ELSE
         SELECT keyno INTO l_keyno 
           FROM apmp520_tmp01  #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d1 ——> apmp520_tmp01
          WHERE pmds007 = l_pmdl.pmdl004
            AND pmds031 = l_pmdl.pmdl009
            AND pmds032 = l_pmdl.pmdl010
            AND pmds033 = l_pmdl.pmdl011
            AND pmds034 = l_pmdl.pmdl012
            AND pmds035 = l_pmdl.pmdl013
            AND pmds037 = l_pmdl.pmdl015
            AND pmds038 = l_pmdl.pmdl016
            AND pmds039 = l_pmdl.pmdl017
            AND ooac004 = l_ooac004
            AND pmds048 = l_pmdl.pmdl054 
            AND pmds049 = l_pmdl.pmdl055 
            AND pmds011 = l_pmds011
            AND pmdl028 = l_pmdl028
      END IF
      #161230-00019#2-e-add

      IF cl_null(l_keyno) THEN
         SELECT MAX(keyno) INTO l_keyno FROM apmp520_tmp01  #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d1 ——> apmp520_tmp01
         IF cl_null(l_keyno) THEN
            LET l_keyno = 1 
         ELSE 
            LET l_keyno = l_keyno + 1
         END IF


         INSERT INTO apmp520_tmp01(keyno, pmds007,  pmds031, pmds032, pmds033,   #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d1 ——> apmp520_tmp01
                                      pmds034, pmds035,  pmds037, pmds038, pmds039, 
                                      ooac004, pmds011,  pmds048, pmds049,pmdl028)   #161207-00033#21 add pmdl028
              VALUES(l_keyno,        l_pmdl.pmdl004,l_pmdl.pmdl009,l_pmdl.pmdl010,l_pmdl.pmdl011,
                     l_pmdl.pmdl012, l_pmdl.pmdl013,l_pmdl.pmdl015,l_pmdl.pmdl016,l_pmdl.pmdl017,
                     l_ooac004,      l_pmds011     ,l_pmdl.pmdl054,l_pmdl.pmdl055,l_pmdl028)  #161207-00033#21 add pmdl028
         
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'ins apmp520_tmp01'  #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d1 ——> apmp520_tmp01
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF
      END IF 
      
      #單身資料
      LET l_pmdtseq = ''
      SELECT MAX(pmdtseq) INTO l_pmdtseq FROM apmp520_tmp02  #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d2 ——> apmp520_tmp02
       WHERE keyno = l_keyno
      IF cl_null(l_pmdtseq) THEN
         LET l_pmdtseq = 1
      ELSE
         LET l_pmdtseq = l_pmdtseq + 1
      END IF

      LET l_pmdt011 = ''
      LET l_sql = " SELECT MAX(pmdt011) FROM apmp520_tmp02",  #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d2 ——> apmp520_tmp02
                  "  WHERE keyno = ",l_keyno,
                  "    AND pmdt006 = '",l_pmdl.pmdo001,"'"

      IF l_pmdl.pmdo002 IS NULL THEN 
         LET l_sql = l_sql CLIPPED,
                  "    AND pmdt007 IS NULL " 
      ELSE
         LET l_sql = l_sql CLIPPED,
                  "    AND pmdt007 = '",l_pmdl.pmdo002,"'" 
      END IF

      IF l_pmdl.pmdo004 IS NULL THEN 
         LET l_sql = l_sql CLIPPED,
                  "    AND pmdt019 IS NULL " 
      ELSE
         LET l_sql = l_sql CLIPPED,
                  "    AND pmdt019 = '",l_pmdl.pmdo004,"'" 
      END IF

      IF l_pmdl.pmdn028 IS NULL THEN 
         LET l_sql = l_sql CLIPPED,
                  "    AND pmdt016 IS NULL " 
      ELSE
         LET l_sql = l_sql CLIPPED,
                  "    AND pmdt016 = '",l_pmdl.pmdn028,"'" 
      END IF

      IF l_pmdl.pmdn029 IS NULL THEN 
         LET l_sql = l_sql CLIPPED,
                  "    AND pmdt017 IS NULL " 
      ELSE
         LET l_sql = l_sql CLIPPED,
                  "    AND pmdt017 = '",l_pmdl.pmdn029,"'" 
      END IF

      IF l_pmdl.pmdn030 IS NULL THEN 
         LET l_sql = l_sql CLIPPED,
                  "    AND pmdt018 IS NULL " 
      ELSE
         LET l_sql = l_sql CLIPPED,
                  "    AND pmdt018 = '",l_pmdl.pmdn030,"'" 
      END IF

      #161129-00037#1 add --begin--
      IF l_pmdl.pmdn053 IS NULL THEN 
         LET l_sql = l_sql CLIPPED,
                  "    AND pmdt063 IS NULL " 
      ELSE
         LET l_sql = l_sql CLIPPED,
                  "    AND pmdt063 = '",l_pmdl.pmdn053,"'" 
      END IF
      #161129-00037#1 add --end--

      PREPARE apmp520_02_pmdt011_pre FROM l_sql
      EXECUTE apmp520_02_pmdt011_pre INTO l_pmdt011
      
      IF cl_null(l_pmdt011) THEN
         LET l_pmdt011 = 1
      ELSE
         LET l_pmdt011 = l_pmdt011 + 1
      END IF
      #mark--2015/03/30 By shiun--(S)
#      LET l_pmdt026 = ''
#      IF NOT (cl_null(l_pmdl.pmdn004) OR cl_null(l_pmdl.pmdn005)) THEN
#         SELECT qcap006 INTO l_pmdt026 FROM qcap_t
#           WHERE qcapent = g_enterprise AND qcapsite = g_site
#             AND qcap001 = l_pmdl.pmdo001 AND qcap002 = l_pmdl.pmdl004
#             AND qcap003 = l_pmdl.pmdn004 AND qcap004 = l_pmdl.pmdn005
#             AND qcap005 = l_pmdl.pmdo002
#      END IF
#
#      IF cl_null(l_pmdt026) THEN 
#         LET l_pmdt026 = 'N'
#      END IF
      #mark--2015/03/30 By shiun--(E)
      #add--2015/03/30 By shiun--(S)
      LET l_pmdt026 = l_pmdn052
      #直接收貨入庫時，無需檢驗
      #此參數以後會用到，先以g_prog代替
#      IF g_prog = 'axmt530' OR g_prog = 'axmt532' THEN
#         LET l_pmdt026 = 'N'
#      END IF
      #add--2015/03/30 By shiun--(E)
      IF l_ooac004 = 'Y' THEN
#         LET l_pmdt026 = 'N'   #mark--2015/03/30 By shiun
         #若該收貨項次QC檢驗為否時，則須將此收貨項次的允收數量更新成收貨數量
         LET l_pmdu013 = l_pmdo.pmdt020
      ELSE
         LET l_pmdu013 = 0
      END IF
      
      IF NOT cl_null(l_pmdl.pmdo028) THEN
         CALL s_aooi250_convert_qty(l_pmdl.pmdo001,l_pmdl.pmdo004,l_pmdl.pmdo028,l_pmdo.pmdt020)
          RETURNING l_success,l_pmdl.pmdo029 
      END IF
      
      
      IF NOT cl_null(l_pmdl.pmdo030) THEN
         #160929-00038#1---s
         IF l_pmdl.pmdl005 = '1' THEN
            IF g_prog MATCHES 'apmp520' THEN
               CALL s_apmt520_get_pmdt024('1','','','',l_pmdo.pmdodocno,l_pmdo.pmdoseq,l_pmdo.pmdoseq1,l_pmdo.pmdoseq2,l_pmdl.pmdo001,l_pmdl.pmdo004,l_pmdo.pmdt020,l_pmdl.pmdo030)
                  RETURNING l_pmdl.pmdo031 
            ELSE
               CALL s_apmt520_get_pmdt024('3','','','',l_pmdo.pmdodocno,l_pmdo.pmdoseq,l_pmdo.pmdoseq1,l_pmdo.pmdoseq2,l_pmdl.pmdo001,l_pmdl.pmdo004,l_pmdo.pmdt020,l_pmdl.pmdo030)
                  RETURNING l_pmdl.pmdo031 
            END IF
            IF cl_null(l_pmdl.pmdo031) OR l_pmdl.pmdo031 = 0 THEN
               CALL s_aooi250_convert_qty(l_pmdl.pmdo001,l_pmdl.pmdo004,l_pmdl.pmdo030,l_pmdo.pmdt020)
                  RETURNING l_success,l_pmdl.pmdo031 
            END IF
         ELSE
         #160929-00038#1---e
            CALL s_aooi250_convert_qty(l_pmdl.pmdo001,l_pmdl.pmdo004,l_pmdl.pmdo030,l_pmdo.pmdt020)
               RETURNING l_success,l_pmdl.pmdo031 
      #160929-00038#1---s    
         END IF   
      ELSE
         LET l_pmdl.pmdo030 = l_pmdl.pmdo004
         LET l_pmdl.pmdo031 = l_pmdo.pmdt020
      #160929-00038#1---e
      END IF
      
      #160617-00005#5---s--
      LET l_imaf061 = ''
      LET l_imaf062 = ''
      LET l_imaf063 = ''
      SELECT imaf061,imaf062,imaf063 INTO l_imaf061,l_imaf062,l_imaf063  
        FROM imaf_t WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = l_pmdl.pmdo001
   
      IF cl_null(l_pmdl.pmdn030) AND l_imaf061 = '1' AND l_imaf062 = 'Y' AND (NOT cl_null(l_imaf063)) THEN
         CALL s_aooi390_gen_1('6',l_imaf063) RETURNING l_success,l_pmdl.pmdn030,l_oofg_return
         IF NOT l_success THEN
            LET l_pmdl.pmdn030 = ' '
         ELSE
            CALL s_aooi390_get_auto_no('6',l_pmdl.pmdn030) RETURNING l_success,l_pmdl.pmdn030
            CALL s_aooi390_oofi_upd('6',l_pmdl.pmdn030) RETURNING l_success
         END IF
      END IF
      #160617-00005#5---e-- 
      
      INSERT INTO apmp520_tmp02(  keyno,   pmdtseq, pmdt001, pmdt002, pmdt003,   #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d2 ——> apmp520_tmp02
                                       pmdt004, pmdt005, pmdo001, pmdt006, pmdt007, 
                                       pmdt009, pmdt010, pmdt011, pmdt019, pmdt020, 
                                       pmdt021, pmdt022, pmdt023, pmdt024, pmdt026, 
                                       pmdt062, pmdt016, pmdt017, pmdt018, pmdt063,  #161129-00037#1 add pmdt063
                                       pmdt059)
           VALUES(l_keyno,        l_pmdtseq,     l_pmdo.pmdodocno,l_pmdo.pmdoseq,l_pmdo.pmdoseq1,
                  l_pmdo.pmdoseq2,l_pmdl.pmdo003,l_pmdl.pmdo001,  l_pmdl.pmdo001,l_pmdl.pmdo002,
                  l_pmdl.pmdn004, l_pmdl.pmdn005,l_pmdt011,       l_pmdl.pmdo004,l_pmdo.pmdt020,
                  l_pmdl.pmdo028, l_pmdl.pmdo029,l_pmdl.pmdo030,  l_pmdl.pmdo031,l_pmdt026,
                  'N',            l_pmdl.pmdn028,l_pmdl.pmdn029,  l_pmdl.pmdn030,l_pmdl.pmdn053,  #161129-00037#1 add pmdn053
                  l_pmdl.pmdn050)

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'ins apmp520_tmp02'  #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d2 ——> apmp520_tmp02
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      INSERT INTO apmp520_tmp03(keyno,pmduseq,pmduseq1,   #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d3 ——> apmp520_tmp03
                                     pmdu001,pmdu002,pmdu003,pmdu004,pmdu005,
                                     pmdu006,pmdu007,pmdu008,pmdu009,pmdu010,
                                     pmdu011,pmdu012,pmdu013,pmdu014,pmdu015)
           VALUES(l_keyno,l_pmdtseq,1,
                  l_pmdl.pmdo001,l_pmdl.pmdo002,l_pmdl.pmdn004,l_pmdl.pmdn005,l_pmdl.pmdn053,
                  l_pmdl.pmdn028,l_pmdl.pmdn029,l_pmdl.pmdn030,l_pmdl.pmdo004,l_pmdo.pmdt020,
                  l_pmdl.pmdo028,l_pmdl.pmdo029,l_pmdu013,0,0)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'ins apmp520_tmp03'  #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d3 ——> apmp520_tmp03
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF

      IF NOT apmp520_02_gen_data_pmdv(l_pmdo.*,l_pmdl.*,l_keyno,l_pmdtseq) THEN
         EXIT FOREACH
      END IF
      
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 產生原始需求分配明細資料
# Memo...........:
# Usage..........: CALL apmp520_02_gen_data_pmdv(p_pmdo,p_pmdl,p_ooac004,p_keyno,p_pmdtseq)
#                  RETURNING r_success
# Input parameter: p_pmdo        
#                : p_pmdl      
#                : p_keyno         串接的主要key
#                : p_pmdtseq       收貨單項次   
# Return code....: r_success       執行結果
# Date & Author..: 2014/06/26 By benson
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp520_02_gen_data_pmdv(p_pmdo,p_pmdl,p_keyno,p_pmdtseq)
DEFINE p_pmdo       type_pmdo
DEFINE p_pmdl       type_pmdl
DEFINE p_keyno      LIKE type_t.num5
DEFINE p_pmdtseq    LIKE pmdt_t.pmdtseq
DEFINE r_success    LIKE type_t.num5

DEFINE l_pmdp  RECORD 
    pmdpdocno  LIKE pmdp_t.pmdpdocno,
    pmdpseq    LIKE pmdp_t.pmdpseq,
    pmdpseq1   LIKE pmdp_t.pmdpseq1,
    pmdp003    LIKE pmdp_t.pmdp003,
    pmdp004    LIKE pmdp_t.pmdp004,
    pmdp005    LIKE pmdp_t.pmdp005,
    pmdp006    LIKE pmdp_t.pmdp006,
    pmdp024    LIKE pmdp_t.pmdp024 
           END RECORD
DEFINE l_pmdv  RECORD
    keyno      LIKE type_t.num5,
    pmdvseq    LIKE pmdv_t.pmdvseq,
    pmdvseq1   LIKE pmdv_t.pmdvseq1,
    pmdv001    LIKE pmdv_t.pmdv001,
    pmdv002    LIKE pmdv_t.pmdv002,
    pmdv003    LIKE pmdv_t.pmdv003,
    pmdv004    LIKE pmdv_t.pmdv004,
    pmdv005    LIKE pmdv_t.pmdv005,
    pmdv006    LIKE pmdv_t.pmdv006,
    pmdv011    LIKE pmdv_t.pmdv011,
    pmdv012    LIKE pmdv_t.pmdv012,
    pmdv013    LIKE pmdv_t.pmdv013,
    pmdv014    LIKE pmdv_t.pmdv014,
    pmdv015    LIKE pmdv_t.pmdv015,
    pmdv016    LIKE pmdv_t.pmdv016,
    pmdv017    LIKE pmdv_t.pmdv017,
    pmdv018    LIKE pmdv_t.pmdv018,
    pmdv019    LIKE pmdv_t.pmdv019 
           END RECORD
DEFINE l_pmdp024    LIKE pmdp_t.pmdp024
DEFINE l_pmdp025    LIKE pmdp_t.pmdp025
DEFINE l_n          LIKE type_t.num5
DEFINE l_pmdo008    LIKE pmdo_t.pmdo008
DEFINE l_pmdv019    LIKE pmdv_t.pmdv019
DEFINE l_pmdv019_2  LIKE pmdv_t.pmdv019
DEFINE l_pmdt001    LIKE pmdt_t.pmdt001
DEFINE l_pmdt002    LIKE pmdt_t.pmdt002
DEFINE l_sql        STRING

   WHENEVER ERROR CONTINUE
   
   LET r_success = TRUE

  #若收貨項次對應的採購項次是有對應的關聯單據明細資料(pmdp_t)時，需將此次的收貨收量分配給各需求單據
   LET l_n = 0
   SELECT COUNT(*) INTO l_n FROM pmdp_t
    WHERE pmdpent = g_enterprise 
      AND pmdpdocno = p_pmdo.pmdodocno AND pmdpseq = p_pmdo.pmdoseq
      AND pmdpseq1 = p_pmdo.pmdoseq1
   IF l_n  = 0 OR cl_null(l_n) THEN
      RETURN r_success
   END IF

   #當子件特性是'1:一般'、'2:CKD'、'3:SKD'、'8:委外代買'時才需要進行收貨量分配
   IF p_pmdl.pmdo003 NOT MATCHES '[1238]' THEN
      RETURN r_success
   END IF

   #依據對應pmdp_t的沖銷順序(pmdp021)作為分配的優先序，判斷該需求單是否還有可分配量
   #若有,才可將收貨量分配給該需求單，可分配量計算公式如下:
   #可分配量 = 折合採購量(pmdp024)*QPA(pmdo008) - 已收貨量
   #已收貨量 = 指的是對應的pmdpdocno+pmdpseq+pmdpseq1已經存在pmdv_t的分配數量總合
   INITIALIZE l_pmdp.* TO NULL

   #折合採購量-已收貨量 > 0 
   LET l_sql = "SELECT pmdpdocno,pmdpseq,pmdpseq1,pmdp003,pmdp004, ",
               #"       pmdp004,  pmdp005,pmdp006 ,pmdp024 ",   #161207-00006 mark
               "        pmdp005,pmdp006 ,pmdp024 ",             #161207-00006 add
               "  FROM pmdp_t ",
               " WHERE pmdpent = ",g_enterprise,
               "   AND pmdpdocno = '",p_pmdo.pmdodocno,"' AND pmdpseq = ",p_pmdo.pmdoseq,
               "   AND pmdpseq1 = ",p_pmdo.pmdoseq1,
               "   AND (COALESCE(pmdp024,0) - COALESCE(pmdp025,0)) > 0 ", #折合採購量-已收貨量 > 0 
               "ORDER BY pmdp021 "

   PREPARE apmp520_02_pmdp_pre1 FROM l_sql
   DECLARE apmp520_02_pmdp_curs1 CURSOR FOR apmp520_02_pmdp_pre1

   FOREACH apmp520_02_pmdp_curs1 INTO l_pmdp.*
      #已收貨量 = 指的是對應的 pmdpdocno + pmdpseq + pmdpseq1已經存在pmdv_t的分配數量總合
      LET l_pmdv019 = 0
      SELECT SUM(COALESCE(pmdv019,0)) INTO l_pmdv019 FROM pmdv_t
        WHERE pmdvent = g_enterprise   AND pmdv011 = l_pmdp.pmdpdocno
          AND pmdv012 = l_pmdp.pmdpseq AND pmdv013 = l_pmdp.pmdpseq1
      IF cl_null(l_pmdv019) THEN
         LET l_pmdv019 = 0
      END IF
      
      #再加上已產生的temp資料
      SELECT SUM(COALESCE(pmdv019,0)) INTO l_pmdv019_2 FROM apmp520_tmp04  #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d5 ——> apmp520_tmp04
        WHERE pmdv011 = l_pmdp.pmdpdocno
          AND pmdv012 = l_pmdp.pmdpseq AND pmdv013 = l_pmdp.pmdpseq1
      IF cl_null(l_pmdv019_2) THEN
         LET l_pmdv019_2 = 0
      END IF
      LET l_pmdv019 = l_pmdv019 + l_pmdv019_2
      
      LET l_pmdo008 = 1
      SELECT pmdo008 INTO l_pmdo008  
        FROM pmdo_t,pmdp_t
       WHERE pmdoent = pmdpent AND pmdodocno = pmdpdocno
         AND pmdoseq = pmdpseq AND pmdo001 = pmdp001
         AND pmdo002 = pmdp002 
         AND pmdoent = g_enterprise
         AND pmdodocno = p_pmdo.pmdodocno AND pmdtseq  = p_pmdo.pmdoseq
         AND pmdoseq1  = p_pmdo.pmdoseq1  AND pmdoseq2 = p_pmdo.pmdoseq2
      IF cl_null(l_pmdo008) THEN
         LET l_pmdo008 = 1
      END IF

      #可分配量 = 折合採購量(pmdp024)* QPA(pmdo008) - 已收貨/入庫量
      LET l_pmdp024 = l_pmdp.pmdp024 * l_pmdo008 - l_pmdv019

      #判斷收貨單據當前項次的收貨數量與來源單據可沖銷的數量大小
      #若收貨量大於可沖銷數量，則更新來源單據的已收貨量=原來的數量+可沖銷數量，當前項次的收貨數量則要減去已沖銷的數量
      #若收貨量小於等於可沖銷數量，則直接更新已收貨量 = 原來的數量+收貨數量
      IF p_pmdo.pmdt020 > l_pmdp024 THEN   #收貨/入庫數量 > 可沖銷的數量
         LET l_pmdp025 = l_pmdp024
         LET p_pmdo.pmdt020 = p_pmdo.pmdt020 - l_pmdp025
      ELSE
         LET l_pmdp025 = p_pmdo.pmdt020
      END IF

      #若該需求單有分配到收貨量則將分配到的數量新增一筆pmdv_t紀錄資料
      IF l_pmdp025 > 0 THEN
         LET l_pmdv.keyno   = p_keyno
         LET l_pmdv.pmdvseq = p_pmdtseq

         SELECT MAX(pmdvseq1) INTO l_pmdv.pmdvseq1 FROM apmp520_tmp04  #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d5 ——> apmp520_tmp04
          WHERE keyno = p_keyno AND pmdvseq = l_pmdv.pmdvseq
         IF cl_null(l_pmdv.pmdvseq1) OR l_pmdv.pmdvseq1 = 0 THEN
            LET l_pmdv.pmdvseq1 = 1
         ELSE
            LET l_pmdv.pmdvseq1 = l_pmdv.pmdvseq1 + 1
         END IF

         LET l_pmdv.pmdv001 = p_pmdl.pmdo001   #收貨料件編號
         LET l_pmdv.pmdv002 = p_pmdl.pmdo002   #收貨產品特徵
         LET l_pmdv.pmdv003 = p_pmdl.pmdn004   #作業編號
         LET l_pmdv.pmdv004 = p_pmdl.pmdn005   #製程序
         LET l_pmdv.pmdv005 = p_pmdl.pmdo002   #子件特性
         LET l_pmdv.pmdv006 = l_pmdo008        #QPA
         LET l_pmdv.pmdv011 = l_pmdp.pmdpdocno #採購單號
         LET l_pmdv.pmdv012 = l_pmdp.pmdpseq   #採購項次
         LET l_pmdv.pmdv013 = l_pmdp.pmdpseq1
         LET l_pmdv.pmdv014 = l_pmdp.pmdp003
         LET l_pmdv.pmdv015 = l_pmdp.pmdp004
         LET l_pmdv.pmdv016 = l_pmdp.pmdp005
         LET l_pmdv.pmdv017 = l_pmdp.pmdp006
         LET l_pmdv.pmdv018 = p_pmdl.pmdo004
         LET l_pmdv.pmdv019 = l_pmdp025
         
         INSERT INTO apmp520_tmp04 (keyno,   pmdvseq, pmdvseq1, pmdv001, pmdv002,  #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d5 ——> apmp520_tmp04
                                         pmdv003, pmdv004, pmdv005,  pmdv006, pmdv011, 
                                         pmdv012, pmdv013, pmdv014, pmdv015, pmdv016, 
                                         pmdv017, pmdv018, pmdv019 )
              VALUES (l_pmdv.keyno,   l_pmdv.pmdvseq, l_pmdv.pmdvseq1,l_pmdv.pmdv001, l_pmdv.pmdv002, 
                      l_pmdv.pmdv003, l_pmdv.pmdv004, l_pmdv.pmdv005, l_pmdv.pmdv006, l_pmdv.pmdv011, 
                      l_pmdv.pmdv012, l_pmdv.pmdv013, l_pmdv.pmdv014, l_pmdv.pmdv015, l_pmdv.pmdv016, 
                      l_pmdv.pmdv017, l_pmdv.pmdv018, l_pmdv.pmdv019)
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'ins apmp520_tmp04'  #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d5 ——> apmp520_tmp04
            LET g_errparam.popup = TRUE
            CALL cl_err()

            LET r_success = FALSE
            EXIT FOREACH
         END IF
      END IF
   END FOREACH
   
   RETURN r_success
END FUNCTION

PUBLIC FUNCTION apmp520_02_b_fill()
DEFINE l_sql        STRING
DEFINE l_ac_t       LIKE type_t.num5

   WHENEVER ERROR CONTINUE
   
   LET l_sql = "SELECT keyno  , pmds007,      '', pmds031,      '',",
               "       pmds032,      '', pmds033,      '', pmds034,",
               "       pmds035, pmds037,      '', pmds038, pmds039,",  
               "            '', ooac004, pmds011, pmds048, pmds049,pmdl028 ",    #161207-00033#21 add pmdl028
               "  FROM apmp520_tmp01"  #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d1 ——> apmp520_tmp01
   PREPARE apmp520_02_temp_d1_sel FROM l_sql
   DECLARE apmp520_02_temp_d1_b_fill_curs CURSOR FOR apmp520_02_temp_d1_sel
   
   CALL g_pmds_d.clear()
   IF cl_null(g_master_idx) OR g_master_idx = 0 THEN
      LET g_master_idx = 1
   END IF
   LET l_ac_t = g_master_idx
   LET l_ac = 1

   FOREACH apmp520_02_temp_d1_b_fill_curs INTO g_pmds_d[l_ac].*,g_pmdl028  #161207-00033#21 add pmdl028
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:apmp520_02_temp_d1_b_fill_curs"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
   
      CALL apmp520_02_detail_show("'1'")
      
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
   CLOSE apmp520_02_temp_d1_b_fill_curs
   FREE apmp520_02_temp_d1_sel
   
   LET g_master_idx = l_ac
  
   CALL apmp520_02_fetch('1')
END FUNCTION

PRIVATE FUNCTION apmp520_02_detail_show(p_page)
DEFINE p_page      STRING
DEFINE l_pmak003   LIKE pmak_t.pmak003   #161230-00019#2
   
   IF p_page.getIndexOf("'1'",1) > 0 THEN
      #161230-00019#2-s-mark
      #161207-00033#21-S
#      IF NOT cl_null(g_pmdl028) THEN
#         CALL s_desc_get_oneturn_guest_desc(g_pmdl028) RETURNING g_pmds_d[l_ac].pmds007_desc
#      ELSE
#      #161207-00033#21-E 
#         CALL s_desc_get_trading_partner_abbr_desc(g_pmds_d[l_ac].pmds007)
#              RETURNING g_pmds_d[l_ac].pmds007_desc
#      END IF  #161207-00033#21         
      #161230-00019#2-e-mark
      #161230-00019#2-s-add
      CALL s_desc_get_trading_partner_abbr_desc(g_pmds_d[l_ac].pmds007)
           RETURNING g_pmds_d[l_ac].pmds007_desc
      IF NOT cl_null(g_pmdl028) THEN
         LET l_pmak003 = ''
         CALL s_desc_get_oneturn_guest_desc(g_pmdl028) 
           RETURNING l_pmak003
         
         IF NOT cl_null(l_pmak003) THEN
            LET g_pmds_d[l_ac].pmds007_desc = l_pmak003
         END IF
      END IF
      #161230-00019#2-e-add
      LET g_pmdl028 = ''   #161207-00033#21 add pmdl028   
      
      CALL s_desc_get_ooib002_desc(g_pmds_d[l_ac].pmds031)
           RETURNING g_pmds_d[l_ac].pmds031_desc
       
      CALL s_desc_get_acc_desc('238',g_pmds_d[l_ac].pmds032)
           RETURNING g_pmds_d[l_ac].pmds032_desc

      CALL s_desc_get_tax_desc1(g_site,g_pmds_d[l_ac].pmds033)
           RETURNING g_pmds_d[l_ac].pmds033_desc

      CALL s_desc_get_currency_desc(g_pmds_d[l_ac].pmds037)
           RETURNING g_pmds_d[l_ac].pmds037_desc
       
      CALL s_desc_get_price_type_desc(g_pmds_d[l_ac].pmds039)
           RETURNING g_pmds_d[l_ac].pmds039_desc
   END IF
   

   IF p_page.getIndexOf("'2'",1) > 0 THEN
      CALL s_desc_get_item_desc(g_pmds2_d[l_ac].pmdo001)
           RETURNING g_pmds2_d[l_ac].pmdo001_desc,g_pmds2_d[l_ac].pmdo001_desc_desc

      CALL s_desc_get_item_desc(g_pmds2_d[l_ac].pmdt006)
           RETURNING g_pmds2_d[l_ac].pmdt006_desc,g_pmds2_d[l_ac].pmdt006_desc_desc

      CALL s_desc_get_unit_desc(g_pmds2_d[l_ac].pmdt019)
           RETURNING g_pmds2_d[l_ac].pmdt019_desc

      CALL s_desc_get_unit_desc(g_pmds2_d[l_ac].pmdt021)
           RETURNING g_pmds2_d[l_ac].pmdt021_desc

      CALL s_desc_get_unit_desc(g_pmds2_d[l_ac].pmdt023)
           RETURNING g_pmds2_d[l_ac].pmdt023_desc

      CALL s_desc_get_stock_desc(g_site,g_pmds2_d[l_ac].pmdt016)
           RETURNING g_pmds2_d[l_ac].pmdt016_desc
       
      CALL s_desc_get_locator_desc(g_site,g_pmds2_d[l_ac].pmdt016,g_pmds2_d[l_ac].pmdt017)
           RETURNING g_pmds2_d[l_ac].pmdt017_desc
   END IF
   
   IF p_page.getIndexOf("'3'",1) > 0 THEN
      CALL s_desc_get_item_desc(g_pmds3_d[l_ac].pmdu001)
           RETURNING g_pmds3_d[l_ac].pmdu001_desc,g_pmds3_d[l_ac].pmdu001_desc_desc

      CALL s_desc_get_stock_desc(g_site,g_pmds3_d[l_ac].pmdu006)
           RETURNING g_pmds3_d[l_ac].pmdu006_desc
       
      CALL s_desc_get_locator_desc(g_site,g_pmds3_d[l_ac].pmdu006,g_pmds3_d[l_ac].pmdu007)
           RETURNING g_pmds3_d[l_ac].pmdu007_desc

      CALL s_desc_get_unit_desc(g_pmds3_d[l_ac].pmdu009)
           RETURNING g_pmds3_d[l_ac].pmdu009_desc

      CALL s_desc_get_unit_desc(g_pmds3_d[l_ac].pmdu011)
           RETURNING g_pmds3_d[l_ac].pmdu011_desc
   END IF
   
   IF p_page.getIndexOf("'5'",1) > 0 THEN
      CALL s_desc_get_item_desc(g_pmds5_d[l_ac].pmdv001)
           RETURNING g_pmds5_d[l_ac].pmdv001_desc,g_pmds5_d[l_ac].pmdv001_desc_desc

      CALL s_desc_get_unit_desc(g_pmds5_d[l_ac].pmdv018)
           RETURNING g_pmds5_d[l_ac].pmdv018_desc
   END IF
   
END FUNCTION

PUBLIC FUNCTION apmp520_02_fetch(p_cmd)
DEFINE p_cmd       LIKE type_t.chr1
DEFINE l_ac_t      LIKE type_t.num5   
DEFINE l_sql       STRING

   WHENEVER ERROR CONTINUE

   IF p_cmd = '1' THEN
      CALL g_pmds2_d.clear()
      
      LET l_sql = "SELECT keyno  , pmdtseq, pmdt001, pmdt002, pmdt003,",
                  "       pmdt004, pmdt005, pmdo001,      '',      '',",
                  "       pmdt006,      '',      '', pmdt007, pmdt009,",
                  "       pmdt010, pmdt011, pmdt019,      '', pmdt020,",
                  "       pmdt021,      '', pmdt022, pmdt023,      '',",
                  "       pmdt024, pmdt026, pmdt062, pmdt016,      '',",
                  "       pmdt017,      '', pmdt018, pmdt063, pmdt059 ",  #161129-00037#1 add pmdt063
                  "  FROM apmp520_tmp02",   #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d2 ——> apmp520_tmp02
                  " WHERE keyno = ",g_pmds_d[g_master_idx].keyno CLIPPED
      PREPARE apmp520_02_temp_d2_sel FROM l_sql
      DECLARE apmp520_02_temp_d2_b_fill_curs CURSOR FOR apmp520_02_temp_d2_sel
      
      LET l_ac_t = l_ac
      LET l_ac = 1
      
      FOREACH apmp520_02_temp_d2_b_fill_curs INTO g_pmds2_d[l_ac].*
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:apmp520_02_temp_d2_b_fill_curs"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            EXIT FOREACH
         END IF
      
         CALL apmp520_02_detail_show("'2'")
         
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
      CLOSE apmp520_02_temp_d2_b_fill_curs
      FREE apmp520_02_temp_d2_sel
   END IF
   
   CALL g_pmds3_d.clear()
   
   LET l_sql = "SELECT keyno,   pmduseq, pmduseq1,pmdu001,      '',",
               "            '', pmdu002, pmdu003, pmdu004, pmdu005,",
               "       pmdu006,      '', pmdu007,      '', pmdu008,",
               "       pmdu009,      '', pmdu010, pmdu011,      '',",
               "       pmdu012, pmdu013, pmdu014, pmdu015  ",
               "  FROM apmp520_tmp03",   #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d3 ——> apmp520_tmp03
               " WHERE keyno = ",g_pmds_d[g_master_idx].keyno CLIPPED
   PREPARE apmp520_02_temp_d3_sel FROM l_sql
   DECLARE apmp520_02_temp_d3_b_fill_curs CURSOR FOR apmp520_02_temp_d3_sel
   
   LET l_ac_t = l_ac
   LET l_ac = 1

   FOREACH apmp520_02_temp_d3_b_fill_curs INTO g_pmds3_d[l_ac].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:apmp520_02_temp_d3_b_fill_curs"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
   
      CALL apmp520_02_detail_show("'3'")
      
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
   CLOSE apmp520_02_temp_d3_b_fill_curs
   FREE apmp520_02_temp_d3_sel
   
   CALL g_pmds5_d.clear()
   
   LET l_sql = "SELECT keyno  , pmdvseq, pmdvseq1, pmdv001,      '',",
               "            '', pmdv002, pmdv003,  pmdv004, pmdv005,",
               "       pmdv006, pmdv011, pmdv012,  pmdv013, pmdv014,",
               "       pmdv015, pmdv016, pmdv017,  pmdv018,      '',",
               "       pmdv019 ",
               "  FROM apmp520_tmp04",  #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d5 ——> apmp520_tmp04
               " WHERE keyno = ",g_pmds_d[g_master_idx].keyno CLIPPED
   PREPARE apmp520_02_temp_d5_sel FROM l_sql
   DECLARE apmp520_02_temp_d5_b_fill_curs CURSOR FOR apmp520_02_temp_d5_sel
   
   LET l_ac_t = l_ac
   LET l_ac = 1

   FOREACH apmp520_02_temp_d5_b_fill_curs INTO g_pmds5_d[l_ac].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:apmp520_02_temp_d5_b_fill_curs"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
   
      CALL apmp520_02_detail_show("'5'")
      
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
   CLOSE apmp520_02_temp_d5_b_fill_curs
   FREE apmp520_02_temp_d5_sel
   
END FUNCTION

PUBLIC FUNCTION apmp520_02_delete_temp_table()

   WHENEVER ERROR CONTINUE
   
   DELETE FROM apmp520_tmp01  #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d1 ——> apmp520_tmp01
   DELETE FROM apmp520_tmp02  #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d2 ——> apmp520_tmp02
   DELETE FROM apmp520_tmp03  #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d3 ——> apmp520_tmp03
   DELETE FROM apmp520_tmp04  #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d5 ——> apmp520_tmp04
END FUNCTION

PRIVATE FUNCTION apmp520_02_chk_pmdt011()
DEFINE r_success     LIKE type_t.num5
DEFINE l_n           LIKE type_t.num5
DEFINE l_sql         STRING
    
   LET r_success = TRUE
   LET l_n = 0

   LET l_sql = " SELECT COUNT(*) FROM apmp520_tmp02",  #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d2 ——> apmp520_tmp02
               "  WHERE keyno = ",g_pmds2_d[l_ac].keyno,
               "    AND pmdtseq != ",g_pmds2_d[l_ac].pmdtseq,
               "    AND pmdt006 = '",g_pmds2_d[l_ac].pmdt006,"'",
               "    AND pmdt011 = ",g_pmds2_d[l_ac].pmdt011

   IF g_pmds2_d[l_ac].pmdt007 IS NULL THEN 
      LET l_sql = l_sql CLIPPED,
               "    AND pmdt007 IS NULL " 
   ELSE
      LET l_sql = l_sql CLIPPED,
               "    AND pmdt007 = '",g_pmds2_d[l_ac].pmdt007,"'" 
   END IF

   IF g_pmds2_d[l_ac].pmdt019 IS NULL THEN 
      LET l_sql = l_sql CLIPPED,
               "    AND pmdt019 IS NULL " 
   ELSE
      LET l_sql = l_sql CLIPPED,
               "    AND pmdt019 = '",g_pmds2_d[l_ac].pmdt019,"'" 
   END IF

   IF g_pmds2_d[l_ac].pmdt016 IS NULL THEN 
      LET l_sql = l_sql CLIPPED,
               "    AND pmdt016 IS NULL " 
   ELSE
      LET l_sql = l_sql CLIPPED,
               "    AND pmdt016 = '",g_pmds2_d[l_ac].pmdt016,"'" 
   END IF
   #160804-00068#1-mod-(S)  參考apmp520_02_update_temp2改寫的
#   IF g_pmds2_d[l_ac].pmdt017 IS NULL THEN 
#      LET l_sql = l_sql CLIPPED,
#               "    AND pmdt017 IS NULL "
#   ELSE
#      LET l_sql = l_sql CLIPPED,
#               "    AND pmdt017 = '",g_pmds2_d[l_ac].pmdt017,"'" 
#   END IF
#
#   IF g_pmds2_d[l_ac].pmdt018 IS NULL THEN 
#      LET l_sql = l_sql CLIPPED,
#               "    AND pmdt018 IS NULL " 
#   ELSE
#      LET l_sql = l_sql CLIPPED,
#               "    AND pmdt018 = '",g_pmds2_d[l_ac].pmdt018,"'" 
#   END IF
   #儲位
   CASE
      WHEN NOT cl_null(g_pmds2_d[l_ac].pmdt017) 
         LET l_sql = l_sql CLIPPED," AND pmdt017 = '",g_pmds2_d[l_ac].pmdt017,"'" 
      WHEN g_pmds2_d[l_ac].pmdt062 = 'N' AND NOT cl_null(g_pmds2_d[l_ac].pmdt016)
         LET l_sql = l_sql CLIPPED," AND (pmdt017 IS NULL OR pmdt017 = ' ') "
      WHEN g_pmds2_d[l_ac].pmdt017 IS NULL
         LET l_sql = l_sql CLIPPED," AND pmdt017 IS NULL "
   END CASE
   #批號
   CASE
      WHEN NOT cl_null(g_pmds2_d[l_ac].pmdt018)
         LET l_sql = l_sql CLIPPED," AND pmdt018 = '",g_pmds2_d[l_ac].pmdt018,"'" 
      WHEN g_pmds2_d[l_ac].pmdt062 = 'N' AND NOT cl_null(g_pmds2_d[l_ac].pmdt016)
         LET l_sql = l_sql CLIPPED," AND (pmdt018 IS NULL OR pmdt018 = ' ') " 
      WHEN g_pmds2_d[l_ac].pmdt018 IS NULL
         LET l_sql = l_sql CLIPPED," AND pmdt018 IS NULL "
   END CASE
   #160804-00068#1-mod-(E)
   
   ##161129-00037#1 add --begin--
   #库存管理特征
   CASE
      WHEN NOT cl_null(g_pmds2_d[l_ac].pmdt063)
         LET l_sql = l_sql CLIPPED," AND pmdt063 = '",g_pmds2_d[l_ac].pmdt063,"'" 
      WHEN g_pmds2_d[l_ac].pmdt063 IS NULL
         LET l_sql = l_sql CLIPPED," AND pmdt063 IS NULL "
   END CASE
   #161129-00037#1 add --end--
   
#   IF g_pmds2_d[l_ac].pmdt017 IS NULL THEN 
#      LET l_sql = l_sql CLIPPED,
#               "    AND pmdt017 IS NULL " 
#   ELSE
#      IF g_pmds2_d[l_ac].pmdt016 IS NULL THEN
#         LET l_sql = l_sql CLIPPED,
#                  "    AND pmdt017 IS NULL " 
#      ELSE
#         LET l_sql = l_sql CLIPPED,
#                  "    AND pmdt017 = '",g_pmds2_d[l_ac].pmdt017,"'"  
#      END IF
#   END IF

#   IF g_pmds2_d[l_ac].pmdt018 IS NULL THEN 
#      LET l_sql = l_sql CLIPPED,
#               "    AND pmdt018 IS NULL " 
#   ELSE
#      IF g_pmds2_d[l_ac].pmdt016 IS NULL AND cl_null(g_pmds2_d[l_ac].pmdt018) THEN         
#         LET l_sql = l_sql CLIPPED,
#                  "    AND pmdt018 IS NULL " 
#      ELSE
#         LET l_sql = l_sql CLIPPED,
#                  "    AND pmdt018 = '",g_pmds2_d[l_ac].pmdt018,"'" 
#      END IF
#   END IF

   PREPARE apmp520_02_pmdt011_pre2 FROM l_sql
   EXECUTE apmp520_02_pmdt011_pre2 INTO l_n

   IF l_n > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apm-00407'
      LET g_errparam.extend = g_pmds2_d[l_ac].pmdt011
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success
END FUNCTION

PRIVATE FUNCTION apmp520_02_refresh_pmdv()
DEFINE l_pmdo          type_pmdo
DEFINE l_pmdl          type_pmdl
DEFINE l_keyno         LIKE type_t.num5
DEFINE l_pmdtseq       LIKE type_t.num5
DEFINE l_sql           STRING

   DELETE FROM apmp520_tmp04  #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d5 ——> apmp520_tmp04

   LET l_sql = "SELECT UNIQUE keyno,pmdtseq,pmdt001,pmdt002,pmdt003,pmdt004,pmdt020 ",
               "  FROM apmp520_tmp02",  #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d2 ——> apmp520_tmp02
               " ORDER BY keyno,pmdtseq,pmdt001,pmdt002,pmdt003,pmdt004"
   PREPARE apmp520_02_temp_d1_pre FROM l_sql
   DECLARE apmp520_02_temp_d1_curs CURSOR FOR apmp520_02_temp_d1_pre


   FOREACH apmp520_02_temp_d1_curs INTO l_keyno,l_pmdtseq,l_pmdo.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'FOREACH:apmp520_02_curs1'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      INITIALIZE l_pmdl.* TO NULL 
      SELECT pmdl004,pmdl009,pmdl010,pmdl011,pmdl012,
             pmdl013,pmdl015,pmdl016,pmdl017,pmdl005,
             pmdl006,pmdl054,pmdl055,
             pmdo003,pmdo001,pmdo002,pmdn004,pmdn005,
             pmdo004,pmdo028,pmdo029,pmdo030,pmdo031,
             pmdn028,pmdn029,pmdn030
        INTO l_pmdl.pmdl004,l_pmdl.pmdl009,l_pmdl.pmdl010,l_pmdl.pmdl011,l_pmdl.pmdl012,
             l_pmdl.pmdl013,l_pmdl.pmdl015,l_pmdl.pmdl016,l_pmdl.pmdl017,l_pmdl.pmdl005,
             l_pmdl.pmdl006,l_pmdl.pmdl054,l_pmdl.pmdl055,
             l_pmdl.pmdo003,l_pmdl.pmdo001,l_pmdl.pmdo002,l_pmdl.pmdn004,l_pmdl.pmdn005,
             l_pmdl.pmdo004,l_pmdl.pmdo028,l_pmdl.pmdo029,l_pmdl.pmdo030,l_pmdl.pmdo031,
             l_pmdl.pmdn028,l_pmdl.pmdn029,l_pmdl.pmdn030
        FROM pmdl_t,pmdn_t,pmdo_t
       WHERE pmdlent = pmdnent AND pmdldocno = pmdndocno
         AND pmdnent = pmdoent AND pmdndocno = pmdodocno AND pmdnseq = pmdoseq 
         AND pmdodocno = l_pmdo.pmdodocno
         AND pmdoseq  = l_pmdo.pmdoseq
         AND pmdoseq1 = l_pmdo.pmdoseq1
         AND pmdoseq2 = l_pmdo.pmdoseq2
         AND pmdoent = g_enterprise   #161230-00019#2
       
      IF NOT apmp520_02_gen_data_pmdv(l_pmdo.*,l_pmdl.*,l_keyno,l_pmdtseq) THEN
         EXIT FOREACH
      END IF
      
   END FOREACH
END FUNCTION

PRIVATE FUNCTION apmp520_02_chk_pmdt006(p_pmds007,p_pmdo001,p_pmdt006,p_pmdt007)
DEFINE p_pmds007     LIKE pmds_t.pmds007
DEFINE p_pmdo001     LIKE pmdo_t.pmdo001
DEFINE p_pmdt006     LIKE pmdt_t.pmdt006
DEFINE p_pmdt007     LIKE pmdt_t.pmdt007
DEFINE l_flag        LIKE type_t.num5
DEFINE l_success     LIKE type_t.num5
DEFINE r_success     LIKE type_t.num5

   LET r_success = TRUE
 
   IF NOT cl_null(p_pmdt006) THEN
      INITIALIZE g_chkparam.* TO NULL
      LET g_chkparam.arg1 = p_pmdt006
      IF cl_chk_exist("v_imaa001") THEN
         IF NOT cl_chk_exist("v_imaf001_14") THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
      ELSE
         LET r_success = FALSE
         RETURN r_success
      END IF
 
      #檢核輸入的料件的生命週期是否在單據別限制範圍內，若不在限制內則不允許請購此料
      CALL s_control_chk_doc('4',g_pmdsdocno,p_pmdt006,'','','','') RETURNING l_success,l_flag
      IF NOT l_success THEN      #处理状态
         LET r_success = FALSE
         RETURN r_success
      ELSE
         IF NOT l_flag THEN      #是否存在
            LET r_success = FALSE
            RETURN r_success
         END IF
      END IF
 
      #檢核輸入的料件的產品分類是否在單據別限制範圍內，若不在限制內則不允許請購此料
      CALL s_control_chk_doc('5',g_pmdsdocno,p_pmdt006,'','','','') RETURNING l_success,l_flag
      IF NOT l_success THEN      #处理状态
         LET r_success = FALSE
         RETURN r_success
      ELSE
         IF NOT l_flag THEN      #是否存在
            LET r_success = FALSE
            RETURN r_success
         END IF
      END IF
 
      #當收貨料號與採購料號不一樣時，必須檢核是否與採購料號有替代關係，若沒有則不允許修改
      IF p_pmdt006 <> p_pmdo001 AND NOT cl_null(p_pmdo001) THEN
         IF NOT s_pmaq_chk_replacement(p_pmds007,p_pmdo001,p_pmdt006,'3',p_pmdt007,p_pmdt007) THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
      END IF
   END IF
 
   RETURN r_success
END FUNCTION

PRIVATE FUNCTION apmp520_02_set_entry_b()
   CALL cl_set_comp_entry("pmdt016_d2_02,pmdt017_d2_02,pmdt018_d2_02,pmdt062_d2_02,pmdt059_d2_02",TRUE)
END FUNCTION

PRIVATE FUNCTION apmp520_02_set_no_entry_b()
DEFINE l_pmdn028         LIKE pmdn_t.pmdn028
DEFINE l_pmdn029         LIKE pmdn_t.pmdn029
DEFINE l_pmdn030         LIKE pmdn_t.pmdn030
DEFINE l_inaa007         LIKE inaa_t.inaa007
DEFINE l_imaf061         LIKE imaf_t.imaf061
#161006-00018#22-S
DEFINE l_flag            LIKE type_t.num5
DEFINE l_ooac002         LIKE ooac_t.ooac002
DEFINE l_ooac004         LIKE ooac_t.ooac004
#161006-00018#22-E  

   LET l_pmdn028 = ''
   LET l_pmdn029 = ''
   LET l_pmdn030 = ''
   SELECT pmdn028,pmdn029,pmdn030 INTO l_pmdn028,l_pmdn029,l_pmdn030
     FROM pmdn_t
    WHERE pmdnent = g_enterprise
      AND pmdndocno = g_pmds2_d[l_ac].pmdt001 
      AND pmdnseq = g_pmds2_d[l_ac].pmdt002
      
   #如果來源單據的庫位資料不為空，則依單別參數判斷庫儲批欄位是否可以修改
   #如果來源單據的庫位資料為空，則不依參數，都要可以維護
   #161006-00018#22-S 
   CALL s_aooi200_get_slip(g_pmdsdocno) RETURNING l_flag,l_ooac002
   CALL cl_get_doc_para(g_enterprise,g_site,l_ooac002,'D-MFG-0085') RETURNING l_ooac004  
   #161006-00018#22-E   
   
   IF NOT cl_null(l_pmdn028) THEN
      IF l_ooac004 = 'N' THEN    #161006-00018#22
         CALL cl_set_comp_entry("pmdt016_d2_02,",FALSE)
      END IF   #161006-00018#22
      CALL cl_set_comp_entry("pmdt062_d2_02",FALSE)
   END IF
   IF NOT cl_null(l_pmdn029) OR l_pmdn029 = ' ' THEN
      IF l_ooac004 = 'N' THEN    #161006-00018#22
         CALL cl_set_comp_entry("pmdt017_d2_02",FALSE)
      END IF   #161006-00018#22
      CALL cl_set_comp_entry("pmdt062_d2_02",FALSE)
   END IF
   IF NOT cl_null(l_pmdn030) OR l_pmdn030 = ' ' THEN
      IF l_ooac004 = 'N' THEN    #161006-00018#22
         CALL cl_set_comp_entry("pmdt018_d2_02",FALSE)
      END IF   #161006-00018#22
      CALL cl_set_comp_entry("pmdt062_d2_02",FALSE)
   END IF  
   IF apmp520_02_pmdn050_chk() THEN
      CALL cl_set_comp_entry("pmdt059_d2_02",FALSE)
   END IF  
   
   IF g_pmds2_d[l_ac].pmdt062 = 'Y' THEN      
      CALL cl_set_comp_entry("pmdt016_d2_02,pmdt017_d2_02,pmdt018_d2_02",FALSE)
   END IF
   IF l_ac > 0 THEN 
      LET l_inaa007 = ''
      SELECT inaa007 INTO l_inaa007
        FROM inaa_t
       WHERE inaaent = g_enterprise
         AND inaasite = g_site
         AND inaa001 = g_pmds2_d[l_ac].pmdt016
      IF l_inaa007 = 'N' THEN
         CALL cl_set_comp_entry("pmdt017_d2_02",FALSE)
      END IF
      
      LET l_imaf061 = ''
      SELECT imaf061 INTO l_imaf061
        FROM imaf_t
       WHERE imafent = g_enterprise
         AND imafsite = g_site
         AND imaf001 = g_pmds2_d[l_ac].pmdt006
      IF l_imaf061 MATCHES '[12]' THEN
         CALL cl_set_comp_entry("pmdt018_d2_02",FALSE)
      END IF
   END IF
   
END FUNCTION
#當沖銷順序相關的欄位 "料件編號、產品特徵、收貨單位、倉庫、儲位、批號" 
#有修改過,即自動將重新預設沖銷順序
PRIVATE FUNCTION apmp520_02_def_pmdt011()
DEFINE l_pmdt011     LIKE type_t.num5
DEFINE l_sql         STRING
    
   LET l_sql = " SELECT MAX(pmdt011) FROM apmp520_tmp02",  #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d2 ——> apmp520_tmp02
               "  WHERE keyno = ",g_pmds2_d[l_ac].keyno,
               "    AND pmdtseq != ",g_pmds2_d[l_ac].pmdtseq,
               "    AND pmdt006 = '",g_pmds2_d[l_ac].pmdt006,"'"

   IF g_pmds2_d[l_ac].pmdt007 IS NULL THEN 
      LET l_sql = l_sql CLIPPED,
               "    AND pmdt007 IS NULL " 
   ELSE
      LET l_sql = l_sql CLIPPED,
               "    AND pmdt007 = '",g_pmds2_d[l_ac].pmdt007,"'" 
   END IF

   IF g_pmds2_d[l_ac].pmdt019 IS NULL THEN 
      LET l_sql = l_sql CLIPPED,
               "    AND pmdt019 IS NULL " 
   ELSE
      LET l_sql = l_sql CLIPPED,
               "    AND pmdt019 = '",g_pmds2_d[l_ac].pmdt019,"'" 
   END IF

   IF g_pmds2_d[l_ac].pmdt016 IS NULL THEN 
      LET l_sql = l_sql CLIPPED,
               "    AND pmdt016 IS NULL " 
   ELSE
      LET l_sql = l_sql CLIPPED,
               "    AND pmdt016 = '",g_pmds2_d[l_ac].pmdt016,"'" 
   END IF
   
   #160804-00068#1-mod-(S)   參考apmp520_02_update_temp2改寫的
#   IF g_pmds2_d[l_ac].pmdt017 IS NULL THEN 
#      LET l_sql = l_sql CLIPPED,
#               "    AND pmdt017 IS NULL "
#   ELSE
#      LET l_sql = l_sql CLIPPED,
#               "    AND pmdt017 = '",g_pmds2_d[l_ac].pmdt017,"'" 
#   END IF
#
#   IF g_pmds2_d[l_ac].pmdt018 IS NULL THEN 
#      LET l_sql = l_sql CLIPPED,
#               "    AND pmdt018 IS NULL " 
#   ELSE
#      LET l_sql = l_sql CLIPPED,
#               "    AND pmdt018 = '",g_pmds2_d[l_ac].pmdt018,"'" 
#   END IF
   #儲位
   CASE
      WHEN NOT cl_null(g_pmds2_d[l_ac].pmdt017)
         LET l_sql = l_sql CLIPPED," AND pmdt017 = '",g_pmds2_d[l_ac].pmdt017,"'"
      WHEN g_pmds2_d[l_ac].pmdt062 = 'N' AND NOT cl_null(g_pmds2_d[l_ac].pmdt016)
         LET l_sql = l_sql CLIPPED," AND (pmdt017 IS NULL OR pmdt017 = ' ') "
      WHEN g_pmds2_d[l_ac].pmdt017 IS NULL
         LET l_sql = l_sql CLIPPED," AND pmdt017 IS NULL "
   END CASE
   #批號
   CASE
      WHEN NOT cl_null(g_pmds2_d[l_ac].pmdt018)
         LET l_sql = l_sql CLIPPED," AND pmdt018 = '",g_pmds2_d[l_ac].pmdt018,"'"
      WHEN g_pmds2_d[l_ac].pmdt062 = 'N' AND NOT cl_null(g_pmds2_d[l_ac].pmdt016)
         LET l_sql = l_sql CLIPPED," AND (pmdt018 IS NULL OR pmdt018 = ' ') "
      WHEN g_pmds2_d[l_ac].pmdt018 IS NULL
         LET l_sql = l_sql CLIPPED," AND pmdt018 IS NULL "
   END CASE
   #160804-00068#1-mod-(E)
   
   ##161129-00037#1 add --begin--
   #库存管理特征
   CASE
      WHEN NOT cl_null(g_pmds2_d[l_ac].pmdt063)
         LET l_sql = l_sql CLIPPED," AND pmdt063 = '",g_pmds2_d[l_ac].pmdt063,"'" 
      WHEN g_pmds2_d[l_ac].pmdt063 IS NULL
         LET l_sql = l_sql CLIPPED," AND pmdt063 IS NULL "
   END CASE
   #161129-00037#1 add --end--
   
#   IF g_pmds2_d[l_ac].pmdt017 IS NULL THEN 
#      LET l_sql = l_sql CLIPPED,
#               "    AND pmdt017 IS NULL " 
#   ELSE
#      IF g_pmds2_d[l_ac].pmdt016 IS NULL THEN
#         LET l_sql = l_sql CLIPPED,
#                  "    AND pmdt017 IS NULL " 
#      ELSE
#         LET l_sql = l_sql CLIPPED,
#                  "    AND pmdt017 = '",g_pmds2_d[l_ac].pmdt017,"'"  
#      END IF
#   END IF

#   IF g_pmds2_d[l_ac].pmdt018 IS NULL THEN 
#      LET l_sql = l_sql CLIPPED,
#               "    AND pmdt018 IS NULL " 
#   ELSE
#      IF g_pmds2_d[l_ac].pmdt016 IS NULL AND cl_null(g_pmds2_d[l_ac].pmdt018) THEN         
#         LET l_sql = l_sql CLIPPED,
#                  "    AND pmdt018 IS NULL " 
#      ELSE
#         LET l_sql = l_sql CLIPPED,
#                  "    AND pmdt018 = '",g_pmds2_d[l_ac].pmdt018,"'" 
#      END IF
#   END IF

   PREPARE apmp520_02_pmdt011_pre3 FROM l_sql
   EXECUTE apmp520_02_pmdt011_pre3 INTO l_pmdt011

   IF cl_null(l_pmdt011) THEN
      LET g_pmds2_d[l_ac].pmdt011 = 1
   ELSE
      LET g_pmds2_d[l_ac].pmdt011 = l_pmdt011 + 1
   END IF
   LET g_pmds2_d_t.pmdt011 = g_pmds2_d[l_ac].pmdt011
   
END FUNCTION

################################################################################
# Descriptions...: 檢核是否為費用料號
# Memo...........:
# Usage..........: CALL apmp520_02_pmdn050_chk()
#                  RETURNING r_success
# Input parameter: 
# Return code....: TRUE OR FALSE
# Date & Author..: 150109 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp520_02_pmdn050_chk()
DEFINE l_pmdn050         LIKE pmdn_t.pmdn050
DEFINE r_success         LIKE type_t.num5

   LET r_success = TRUE

   LET l_pmdn050 = ''
   SELECT pmdn050 INTO l_pmdn050
     FROM pmdn_t
    WHERE pmdnent = g_enterprise
      AND pmdndocno = g_pmds2_d[l_ac].pmdt001 
      AND pmdnseq = g_pmds2_d[l_ac].pmdt002
   IF cl_null(l_pmdn050) THEN
      LET r_success = FALSE
   END IF  

   RETURN r_success

END FUNCTION

################################################################################
# Descriptions...: UPDATE apmp520_02_temp_d2
# Memo...........:
# Usage..........: CALL apmp520_02_update_temp2()
# Input parameter: 
# Return code....: 
# Date & Author..: 150109 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp520_02_update_temp2()

   IF g_pmds2_d[l_ac].pmdt062 = 'N' AND NOT cl_null(g_pmds2_d[l_ac].pmdt016) THEN
      IF cl_null(g_pmds2_d[l_ac].pmdt017) THEN
         LET g_pmds2_d[l_ac].pmdt017 = ' '
      END IF
      
      IF cl_null(g_pmds2_d[l_ac].pmdt018) THEN
         LET g_pmds2_d[l_ac].pmdt018 = ' '
      END IF
   ELSE
      LET g_pmds2_d[l_ac].pmdt017 = ''            
      IF cl_null(g_pmds2_d[l_ac].pmdt018) THEN
         LET g_pmds2_d[l_ac].pmdt018 = ''
      END IF
   END IF
   
   #整體參數未使用採購計價單位,則賦值當前的採購單位和數量
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0019') = "N" THEN
      LET g_pmds2_d[l_ac].pmdt023 = g_pmds2_d[l_ac].pmdt019
      LET g_pmds2_d[l_ac].pmdt024 = g_pmds2_d[l_ac].pmdt020
   END IF
   
   UPDATE apmp520_tmp02  #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d2 ——> apmp520_tmp02
      SET pmdt006 = g_pmds2_d[l_ac].pmdt006,
          pmdt007 = g_pmds2_d[l_ac].pmdt007,
          pmdt011 = g_pmds2_d[l_ac].pmdt011,
          pmdt019 = g_pmds2_d[l_ac].pmdt019,
          pmdt020 = g_pmds2_d[l_ac].pmdt020,
          pmdt021 = g_pmds2_d[l_ac].pmdt021,
          pmdt022 = g_pmds2_d[l_ac].pmdt022,
          pmdt023 = g_pmds2_d[l_ac].pmdt023,
          pmdt024 = g_pmds2_d[l_ac].pmdt024,
          pmdt062 = g_pmds2_d[l_ac].pmdt062,
          pmdt016 = g_pmds2_d[l_ac].pmdt016,
          pmdt017 = g_pmds2_d[l_ac].pmdt017,
          pmdt018 = g_pmds2_d[l_ac].pmdt018,
          pmdt063 = g_pmds2_d[l_ac].pmdt063,  #161129-00037#1 add
          pmdt059 = g_pmds2_d[l_ac].pmdt059
    WHERE keyno = g_pmds2_d[l_ac].keyno 
      AND pmdtseq = g_pmds2_d[l_ac].pmdtseq 

END FUNCTION

################################################################################
# Descriptions...: UPDATE apmp520_02_temp_d2
# Memo...........:
# Usage..........: CALL apmp520_02_update_temp3()
# Input parameter: 
# Return code....: 
# Date & Author..: 150205 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp520_02_update_temp3()
DEFINE l_n          LIKE type_t.num5

   LET l_n = 0 
   SELECT COUNT(*) INTO l_n
     FROM apmp520_tmp03   #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d3 ——> apmp520_tmp03
    WHERE keyno = g_pmds2_d[l_ac].keyno
      AND pmduseq = g_pmds2_d[l_ac].pmdtseq
   IF cl_null(l_n) OR l_n = 0 THEN
      INSERT INTO apmp520_tmp03(keyno,pmduseq,pmduseq1,  #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d3 ——> apmp520_tmp03
                                     pmdu001,pmdu002,pmdu003,pmdu004,pmdu005,
                                     pmdu006,pmdu007,pmdu008,pmdu009,pmdu010,
                                     pmdu011,pmdu012,pmdu013,pmdu014,pmdu015)
           VALUES(g_pmds2_d[l_ac].keyno,g_pmds2_d[l_ac].pmdtseq,1,
                  g_pmds2_d[l_ac].pmdt006,g_pmds2_d[l_ac].pmdt007,g_pmds2_d[l_ac].pmdt009,g_pmds2_d[l_ac].pmdt010,g_pmds2_d[l_ac].pmdt063, #161129-00037#1 mod ''-->pmdt063
                  g_pmds2_d[l_ac].pmdt016,g_pmds2_d[l_ac].pmdt017,g_pmds2_d[l_ac].pmdt018,g_pmds2_d[l_ac].pmdt019,g_pmds2_d[l_ac].pmdt020,
                  g_pmds2_d[l_ac].pmdt021,g_pmds2_d[l_ac].pmdt022,0,0,0)
   ELSE
      UPDATE apmp520_tmp03  #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d3 ——> apmp520_tmp03
         SET pmdu001 = g_pmds2_d[l_ac].pmdt006,
             pmdu002 = g_pmds2_d[l_ac].pmdt007,
             pmdu006 = g_pmds2_d[l_ac].pmdt016,
             pmdu007 = g_pmds2_d[l_ac].pmdt017,
             pmdu008 = g_pmds2_d[l_ac].pmdt018,
             pmdu005 = g_pmds2_d[l_ac].pmdt063,  #161129-00037#1 add
             pmdu009 = g_pmds2_d[l_ac].pmdt019,
             pmdu010 = g_pmds2_d[l_ac].pmdt020,
             pmdu011 = g_pmds2_d[l_ac].pmdt021,
             pmdu012 = g_pmds2_d[l_ac].pmdt022
       WHERE keyno = g_pmds2_d[l_ac].keyno 
         AND pmduseq = g_pmds2_d[l_ac].pmdtseq 
   END IF

END FUNCTION

################################################################################
# Descriptions...: 收貨明細頁籤的輸入段(input)
# Memo...........:
# Usage..........: CALL apmp520_02_b()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/02/25 By Ken  #151118-00029#2
# Modify.........: 151118-00029#2 2016/03/28 By ming 修正多庫儲的操作問題
################################################################################
PUBLIC FUNCTION apmp520_02_b()
DEFINE l_ac1          LIKE type_t.num5   
DEFINE l_pmds2_t      type_g_pmds2_d
DEFINE l_del_pmdt     LIKE type_t.num5  #151118-00029#2 Add By Ken 160314
   
   WHENEVER ERROR CONTINUE 

   DIALOG ATTRIBUTES(UNBUFFERED)
      INPUT ARRAY g_pmds2_d FROM s_detail2_apmp520_02.*
         ATTRIBUTE(COUNT = g_rec_b2,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                   INSERT ROW = FALSE,
                   DELETE ROW = FALSE,
                   APPEND ROW = FALSE)
                   
         BEFORE INPUT
         
         BEFORE ROW
            LET l_ac = ARR_CURR()   
            #LET l_pmds2_t.* = g_pmds2_d[l_ac1].*            
            
            SELECT keyno  , pmdtseq, pmdt001, pmdt002, pmdt003,  
                   pmdt004, pmdt005, pmdo001,      '',      '',  
                   pmdt006,      '',      '', pmdt007, pmdt009,  
                   pmdt010, pmdt011, pmdt019,      '', pmdt020,  
                   pmdt021,      '', pmdt022, pmdt023,      '',  
                   pmdt024, pmdt026, pmdt062, pmdt016,      '',  
                   pmdt017,      '', pmdt018, pmdt063, pmdt059    #161129-00037#1 add pmdt063
              INTO g_pmds2_d[l_ac].*
              FROM apmp520_tmp02  #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d2 ——> apmp520_tmp02
             WHERE keyno = g_pmds2_d[l_ac].keyno
               AND pmdtseq = g_pmds2_d[l_ac].pmdtseq
            CALL apmp520_02_detail_show("'2'")   
            LET g_pmds2_d_t.* = g_pmds2_d[l_ac].*
            CALL apmp520_02_set_entry_b()
            CALL apmp520_02_set_no_entry_b()
            
         AFTER FIELD pmdt006_d2_02
            LET g_pmds2_d[l_ac].pmdt006_desc = ''
            LET g_pmds2_d[l_ac].pmdt006_desc_desc = ''
            IF NOT cl_null(g_pmds2_d[l_ac].pmdt006) THEN      
               IF NOT apmp520_02_chk_pmdt006(g_pmds_d[g_master_idx].pmds007,g_pmds2_d[l_ac].pmdo001,g_pmds2_d[l_ac].pmdt006,g_pmds2_d[l_ac].pmdt007) THEN
                  LET g_pmds2_d[l_ac].pmdt006 = g_pmds2_d_t.pmdt006
                  CALL s_desc_get_item_desc(g_pmds2_d[l_ac].pmdt006)
                       RETURNING g_pmds2_d[l_ac].pmdt006_desc,g_pmds2_d[l_ac].pmdt006_desc_desc
                  NEXT FIELD CURRENT
               END IF
               #161205-00035#1 mark(s)
#               LET g_pmds2_d[l_ac].pmdt026 = ''
#               IF (NOT cl_null(g_pmds2_d[l_ac].pmdt009)) AND (NOT cl_null(g_pmds2_d[l_ac].pmdt010)) THEN
#                  SELECT qcap006 INTO g_pmds2_d[l_ac].pmdt026
#                    FROM qcap_t
#                    WHERE qcapent = g_enterprise AND qcapsite = g_site
#                      AND qcap001 = g_pmds2_d[l_ac].pmdt006
#                      AND qcap002 = g_pmds_d[g_master_idx].pmds007
#                      AND qcap003 = g_pmds2_d[l_ac].pmdt009
#                      AND qcap004 = g_pmds2_d[l_ac].pmdt010
#                      AND qcap005 = g_pmds2_d[l_ac].pmdt007
#               END IF
#      
#               IF cl_null(g_pmds2_d[l_ac].pmdt026) THEN
#                  LET g_pmds2_d[l_ac].pmdt026 = 'N'
#               END IF
#                
#               IF g_pmds_d[g_master_idx].ooac004 = 'Y' THEN
#                  LET g_pmds2_d[l_ac].pmdt026 = 'N'
#               END IF
               #161205-00035#1 mark(e)
               #預設沖銷順序
               IF g_pmds2_d[l_ac].pmdt006 != g_pmds2_d_t.pmdt006 OR g_pmds2_d_t.pmdt006 IS NULL THEN
                  CALL apmp520_02_def_pmdt011()     
               END IF    
            END IF
            
            CALL s_desc_get_item_desc(g_pmds2_d[l_ac].pmdt006) 
                 RETURNING g_pmds2_d[l_ac].pmdt006_desc,g_pmds2_d[l_ac].pmdt006_desc_desc
            LET g_pmds2_d_t.pmdt006 = g_pmds2_d[l_ac].pmdt006 
            
         AFTER FIELD pmdt007_d2_02
            IF NOT cl_null(g_pmds2_d[l_ac].pmdt007) THEN
               IF g_pmds2_d[l_ac].pmdt007 != g_pmds2_d_t.pmdt007 OR g_pmds2_d_t.pmdt007 IS NULL THEN
                  IF NOT cl_null(g_pmds2_d[l_ac].pmdt006) THEN
                     #預設沖銷順序
                     CALL apmp520_02_def_pmdt011()
                  END IF
               END IF
            END IF   
            LET g_pmds2_d_t.pmdt007 = g_pmds2_d[l_ac].pmdt007  
            
         AFTER FIELD pmdt011_d2_02
            IF NOT cl_ap_chk_Range(g_pmds2_d[l_ac].pmdt011,"0","0","","","azz-00079",1) THEN
               LET g_pmds2_d[l_ac].pmdt011 = g_pmds2_d_t.pmdt011
               NEXT FIELD pmdt011_d2_02
            END IF
            
            #沖銷順序
            IF NOT cl_null(g_pmds2_d[l_ac].pmdt011) AND NOT cl_null(g_pmds2_d[l_ac].pmdt006) THEN
               IF NOT apmp520_02_chk_pmdt011() THEN
                  LET g_pmds2_d[l_ac].pmdt011 = g_pmds2_d_t.pmdt011
                  NEXT FIELD pmdt011_d2_02
               END IF
            END IF  
            
         AFTER FIELD pmdt020_d2_02
            IF NOT cl_ap_chk_Range(g_pmds2_d[l_ac].pmdt020,"0","0","","","azz-00079",1) THEN
               LET g_pmds2_d[l_ac].pmdt020 = g_pmds2_d_t.pmdt020
               NEXT FIELD pmdt020_d2_02
            END IF
      
            IF NOT cl_null(g_pmds2_d[l_ac].pmdt020) THEN
               LET g_qty = 0
               CALL s_apmt520_get_quantity(g_pmds2_d[l_ac].pmdt001,g_pmds2_d[l_ac].pmdt002,g_pmds2_d[l_ac].pmdt003,g_pmds2_d[l_ac].pmdt004)
                    RETURNING g_qty
               IF g_pmds2_d[l_ac].pmdt020 > g_qty THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00383'
                  LET g_errparam.extend = g_pmds2_d[l_ac].pmdt020
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_pmds2_d[l_ac].pmdt020 = g_pmds2_d_t.pmdt020
                  NEXT FIELD pmdt020_d2_02
               END IF
      
               LET g_pmdo006 = ''
               CALL apmp520_01_default_quantity(g_pmds2_d[l_ac].pmdt001,g_pmds2_d[l_ac].pmdt002,g_pmds2_d[l_ac].pmdt003,g_pmds2_d[l_ac].pmdt004)
                    RETURNING g_pmdo006
      
               LET g_pmdn022 = ''
               SELECT pmdn022 INTO g_pmdn022
                 FROM pmdn_t
                WHERE pmdnent = g_enterprise
                  AND pmdndocno = g_pmds2_d[l_ac].pmdt001
                  AND pmdnseq = g_pmds2_d[l_ac].pmdt002
      
               IF g_pmds2_d[l_ac].pmdt020 < g_pmdo006 AND g_pmdn022 = 'N' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00382'
                  LET g_errparam.extend = g_pmds2_d[l_ac].pmdt020
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_pmds2_d[l_ac].pmdt020 = g_pmds2_d_t.pmdt020
                  NEXT FIELD pmdt020_d2_02
               END IF
            END IF
      
            #自動換算參考數量、計價數量
            IF NOT cl_null(g_pmds2_d[l_ac].pmdt021) THEN
               CALL s_aooi250_convert_qty(g_pmds2_d[l_ac].pmdt006,g_pmds2_d[l_ac].pmdt019,g_pmds2_d[l_ac].pmdt021,g_pmds2_d[l_ac].pmdt020)
                    RETURNING g_flag,g_pmds2_d[l_ac].pmdt022
            END IF
           
            IF NOT cl_null(g_pmds2_d[l_ac].pmdt023) THEN
               CALL s_aooi250_convert_qty(g_pmds2_d[l_ac].pmdt006,g_pmds2_d[l_ac].pmdt019,g_pmds2_d[l_ac].pmdt023,g_pmds2_d[l_ac].pmdt020)
                    RETURNING g_flag,g_pmds2_d[l_ac].pmdt024
            END IF
            
         ON CHANGE pmdt062_d2_02
            IF g_pmds2_d[l_ac].pmdt062 = 'N' THEN
               LET g_cnt = 0 
               SELECT COUNT(*) INTO g_cnt
                 FROM apmp520_tmp03   #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d3 ——> apmp520_tmp03
                WHERE keyno = g_pmds2_d[l_ac].keyno
                  AND pmduseq = g_pmds2_d[l_ac].pmdtseq
               #151118-00029#2 20160328 by ming modify -----(S) 
               #IF g_cnt > 0 THEN
               IF g_cnt > 1 THEN
               #151118-00029#2 20160328 by ming modify -----(E) 
                  IF cl_ask_confirm('apm-00559') THEN
                     #DELETE FROM apmp520_02_temp_d3 
                     # WHERE keyno = g_pmds2_d[l_ac1].keyno
                     #   AND pmduseq = g_pmds2_d[l_ac1].pmdtseq
                     LET l_del_pmdt = TRUE
                  ELSE
                     LET g_pmds2_d[l_ac].pmdt062 = 'Y'
                     LET l_del_pmdt = FALSE
                  END IF
               END IF
            ELSE 
               #151118-00029#2 20160328 by ming mark -----(S) 
               #這裡不該先清空資料  
               #CALL apmp520_02_update_temp2()
               #151118-00029#2 20160328 by ming mark -----(E) 
               IF NOT apmp520_04(g_pmds2_d[l_ac].keyno,g_pmds2_d[l_ac].pmdtseq) THEN
                  LET g_cnt = 0 
                  SELECT COUNT(*) INTO g_cnt
                    FROM apmp520_tmp03   #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d3 ——> apmp520_tmp03
                   WHERE keyno = g_pmds2_d[l_ac].keyno
                     AND pmduseq = g_pmds2_d[l_ac].pmdtseq
                  IF g_cnt = 0 THEN
                     LET g_pmds2_d[l_ac].pmdt062 = 'N'
                     NEXT FIELD CURRENT
                  END IF
               #151118-00029#2 20160328 by ming add -----(S) 
               ELSE
                  CALL apmp520_02_update_temp2()

                  LET g_pmds2_d[l_ac].pmdt016 = ''
                  LET g_pmds2_d[l_ac].pmdt016_desc = ''
                  LET g_pmds2_d[l_ac].pmdt017 = ''
                  LET g_pmds2_d[l_ac].pmdt017_desc = ''
                  LET g_pmds2_d[l_ac].pmdt018 = ''
                  IF NOT cl_null(g_pmds2_d[l_ac].pmdt006) THEN
                     #預設沖銷順序
                     CALL apmp520_02_def_pmdt011()
                  END IF
               #151118-00029#2 20160328 by ming add -----(E) 
               END IF
            END IF
            
            #151118-00029#2 20160328 by ming mark -----(S) 
            #IF g_pmds2_d[l_ac1].pmdt062 = 'Y' THEN
            #   LET g_pmds2_d[l_ac1].pmdt016 = ''
            #   LET g_pmds2_d[l_ac1].pmdt016_desc = ''
            #   LET g_pmds2_d[l_ac1].pmdt017 = ''
            #   LET g_pmds2_d[l_ac1].pmdt017_desc = ''
            #   LET g_pmds2_d[l_ac1].pmdt018 = ''
            #   IF NOT cl_null(g_pmds2_d[l_ac1].pmdt006) THEN
            #      #預設沖銷順序
            #      CALL apmp520_02_def_pmdt011()
            #   END IF
            #END IF 
            #151118-00029#2 20160328 by ming mark -----(E) 
            CALL apmp520_02_set_entry_b()
            CALL apmp520_02_set_no_entry_b()
            
         AFTER FIELD pmdt016_d2_02
            LET g_pmds2_d[l_ac].pmdt016_desc = ''
            IF NOT cl_null(g_pmds2_d[l_ac].pmdt016) THEN
               IF g_pmds2_d[l_ac].pmdt016 != g_pmds2_d_t.pmdt016 OR g_pmds2_d_t.pmdt016 IS NULL THEN
                  IF NOT apmp520_02_pmdn050_chk() THEN
                     INITIALIZE g_chkparam.* TO NULL
                     LET g_chkparam.arg1 = g_pmds2_d[l_ac].pmdt016
                     #160318-00025#20  by 07900 --add-str
                     LET g_errshow = TRUE #是否開窗                   
                     LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
                     #160318-00025#20  by 07900 --add-end
                     IF NOT cl_chk_exist("v_inaa001_9") THEN
                        LET g_pmds2_d[l_ac].pmdt016 = g_pmds2_d_t.pmdt016
                     CALL s_desc_get_stock_desc(g_site,g_pmds2_d[l_ac].pmdt016)
                          RETURNING g_pmds2_d[l_ac].pmdt016_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  
                  #儲位值清空
                  LET g_pmds2_d[l_ac].pmdt017 = ' '
                  LET g_pmds2_d[l_ac].pmdt017_desc = '' 
                  LET g_pmds2_d_t.pmdt017 = ' '
                  IF NOT cl_null(g_pmds2_d[l_ac].pmdt006) THEN
                     #預設沖銷順序
                     CALL apmp520_02_def_pmdt011()
                  END IF
               END IF
            END IF   
            LET g_pmds2_d_t.pmdt016 = g_pmds2_d[l_ac].pmdt016  
            CALL s_desc_get_stock_desc(g_site,g_pmds2_d[l_ac].pmdt016)
                 RETURNING g_pmds2_d[l_ac].pmdt016_desc
          
      
         AFTER FIELD pmdt017_d2_02         
            LET g_pmds2_d[l_ac].pmdt017_desc = ''
            IF NOT cl_null(g_pmds2_d[l_ac].pmdt017) THEN
               IF g_pmds2_d[l_ac].pmdt017 != g_pmds2_d_t.pmdt017 OR g_pmds2_d_t.pmdt017 IS NULL THEN
                  IF NOT apmp520_02_pmdn050_chk() THEN
                     #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                     INITIALIZE g_chkparam.* TO NULL
                     LET g_chkparam.arg1 = g_site
                     LET g_chkparam.arg2 = g_pmds2_d[l_ac].pmdt016
                     LET g_chkparam.arg3 = g_pmds2_d[l_ac].pmdt017
                     IF NOT cl_chk_exist("v_inab002_1") THEN
                        #檢查失敗時後續處理
                        LET g_pmds2_d[l_ac].pmdt017 = g_pmds2_d_t.pmdt017
                        CALL s_desc_get_locator_desc(g_site,g_pmds2_d[l_ac].pmdt016,g_pmds2_d[l_ac].pmdt017)
                             RETURNING g_pmds2_d[l_ac].pmdt017_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  
                  IF NOT cl_null(g_pmds2_d[l_ac].pmdt006) THEN
                     #預設沖銷順序
                     CALL apmp520_02_def_pmdt011()
                  END IF
               END IF
            END IF   
            LET g_pmds2_d_t.pmdt017 = g_pmds2_d[l_ac].pmdt017  
            CALL s_desc_get_locator_desc(g_site,g_pmds2_d[l_ac].pmdt016,g_pmds2_d[l_ac].pmdt017)
                 RETURNING g_pmds2_d[l_ac].pmdt017_desc
             
         AFTER FIELD pmdt018_d2_02
            IF NOT cl_null(g_pmds2_d[l_ac].pmdt018) THEN
               IF g_pmds2_d[l_ac].pmdt018 != g_pmds2_d_t.pmdt018 OR g_pmds2_d_t.pmdt018 IS NULL THEN
                  IF NOT cl_null(g_pmds2_d[l_ac].pmdt006) THEN
                     #預設沖銷順序
                     CALL apmp520_02_def_pmdt011()
                  END IF
               END IF
            END IF   
            LET g_pmds2_d_t.pmdt018 = g_pmds2_d[l_ac].pmdt018  
            
         ON ROW CHANGE
            #沖銷順序
            IF NOT cl_null(g_pmds2_d[l_ac].pmdt011) AND NOT cl_null(g_pmds2_d[l_ac].pmdt006) THEN
               IF NOT apmp520_02_chk_pmdt011() THEN
                  LET g_pmds2_d[l_ac].pmdt011 = g_pmds2_d_t.pmdt011
                  NEXT FIELD pmdt011_d2_02
               END IF
            END IF  
            CALL apmp520_02_update_temp2()
            IF g_pmds2_d[l_ac].pmdt062 = 'N' THEN
               CALL apmp520_02_update_temp3()
            END IF
            
         AFTER INPUT
            CALL apmp520_02_refresh_pmdv()
            
            
         ON ACTION controlp
            CASE
               WHEN INFIELD(pmdt006_d2_02)
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.default1 = g_pmds2_d[l_ac].pmdt006
                  CALL q_imaf001_15()                                #呼叫開窗                     
                  LET g_pmds2_d[l_ac].pmdt006 = g_qryparam.return1   #將開窗取得的值回傳到變數
                  CALL s_desc_get_item_desc(g_pmds2_d[l_ac].pmdt006) 
                       RETURNING g_pmds2_d[l_ac].pmdt006_desc,g_pmds2_d[l_ac].pmdt006_desc_desc                  
                  NEXT FIELD pmdt006_d2_02 
               WHEN INFIELD(pmdt016_d2_02)
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.default1 = g_pmds2_d[l_ac].pmdt016      #給予default值
                  CALL q_inaa001_2()                                     #呼叫開窗
                  LET g_pmds2_d[l_ac].pmdt016 = g_qryparam.return1       #將開窗取得的值回傳到變數
                  DISPLAY g_pmds2_d[l_ac].pmdt016 TO pmdt016_d2_02
                  CALL s_desc_get_stock_desc(g_site,g_pmds2_d[l_ac].pmdt016) 
                       RETURNING g_pmds2_d[l_ac].pmdt016_desc               
                  NEXT FIELD CURRENT
               WHEN INFIELD(pmdt017_d2_02)
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.arg1 = g_pmds2_d[l_ac].pmdt016
                  LET g_qryparam.default1 = g_pmds2_d[l_ac].pmdt017      #給予default值
                  CALL q_inab002_3()                                     #呼叫開窗
                  LET g_pmds2_d[l_ac].pmdt017 = g_qryparam.return1       #將開窗取得的值回傳到變數
                  DISPLAY g_pmds2_d[l_ac].pmdt017 TO pmdt017_d2_02
                  CALL s_desc_get_locator_desc(g_site,g_pmds2_d[l_ac].pmdt016,g_pmds2_d[l_ac].pmdt017)
                       RETURNING g_pmds2_d[l_ac].pmdt017_desc                
                  NEXT FIELD CURRENT
            END CASE  

            ON ACTION accept
            #151118-00029#2 Add By Ken 160314(S)
            #是否刪除多庫除批資料 20160310
            IF NOT cl_null(l_del_pmdt) THEN     
              IF l_del_pmdt THEN
              
                LET l_del_pmdt = FALSE               
                DELETE FROM apmp520_tmp03   #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d3 ——> apmp520_tmp03
                 WHERE keyno = g_pmds2_d[l_ac].keyno
                   AND pmduseq = g_pmds2_d[l_ac].pmdtseq              
                IF SQLCA.sqlcode THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = SQLCA.sqlcode
                   LET g_errparam.extend = "apmp520_tmp03"  #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d3 ——> apmp520_tmp03
                   LET g_errparam.popup = TRUE
                   CALL cl_err()                  
                END IF
                
              END IF  
            END IF 
            #151118-00029#2 Add By Ken 160314(E)            
            
            
            #收貨料件編號的檢查
               IF NOT cl_null(g_pmds2_d[l_ac].pmdt006) THEN      
                  IF NOT apmp520_02_chk_pmdt006(g_pmds_d[g_master_idx].pmds007,g_pmds2_d[l_ac].pmdo001,g_pmds2_d[l_ac].pmdt006,g_pmds2_d[l_ac].pmdt007) THEN
                     LET g_pmds2_d[l_ac].pmdt006 = g_pmds2_d_t.pmdt006
                     CALL s_desc_get_item_desc(g_pmds2_d[l_ac].pmdt006)
                          RETURNING g_pmds2_d[l_ac].pmdt006_desc,g_pmds2_d[l_ac].pmdt006_desc_desc
                     NEXT FIELD CURRENT
                  END IF
                  #161205-00035#1 mark(s)
#                  LET g_pmds2_d[l_ac].pmdt026 = ''
#                  IF (NOT cl_null(g_pmds2_d[l_ac].pmdt009)) AND (NOT cl_null(g_pmds2_d[l_ac].pmdt010)) THEN
#                     SELECT qcap006 INTO g_pmds2_d[l_ac].pmdt026
#                       FROM qcap_t
#                       WHERE qcapent = g_enterprise AND qcapsite = g_site
#                         AND qcap001 = g_pmds2_d[l_ac].pmdt006
#                         AND qcap002 = g_pmds_d[g_master_idx].pmds007
#                         AND qcap003 = g_pmds2_d[l_ac].pmdt009
#                         AND qcap004 = g_pmds2_d[l_ac].pmdt010
#                         AND qcap005 = g_pmds2_d[l_ac].pmdt007
#                  END IF
#               
#                  IF cl_null(g_pmds2_d[l_ac].pmdt026) THEN
#                     LET g_pmds2_d[l_ac].pmdt026 = 'N'
#                  END IF
#                   
#                  IF g_pmds_d[g_master_idx].ooac004 = 'Y' THEN
#                     LET g_pmds2_d[l_ac].pmdt026 = 'N'
#                  END IF
                  #161205-00035#1 mark(e)
                  #預設沖銷順序
                  IF g_pmds2_d[l_ac].pmdt006 != g_pmds2_d_t.pmdt006 OR g_pmds2_d_t.pmdt006 IS NULL THEN
                     CALL apmp520_02_def_pmdt011()     
                  END IF    
               END IF
               
               CALL s_desc_get_item_desc(g_pmds2_d[l_ac].pmdt006) 
                    RETURNING g_pmds2_d[l_ac].pmdt006_desc,g_pmds2_d[l_ac].pmdt006_desc_desc
               LET g_pmds2_d_t.pmdt006 = g_pmds2_d[l_ac].pmdt006 

            #收貨產品特徵的檢查
               IF NOT cl_null(g_pmds2_d[l_ac].pmdt007) THEN
                  IF g_pmds2_d[l_ac].pmdt007 != g_pmds2_d_t.pmdt007 OR g_pmds2_d_t.pmdt007 IS NULL THEN
                     IF NOT cl_null(g_pmds2_d[l_ac].pmdt006) THEN
                        #預設沖銷順序
                        CALL apmp520_02_def_pmdt011()
                     END IF
                  END IF
               END IF   
               LET g_pmds2_d_t.pmdt007 = g_pmds2_d[l_ac].pmdt007 
               
            #沖銷順序的檢查
               IF NOT cl_ap_chk_Range(g_pmds2_d[l_ac].pmdt011,"0","0","","","azz-00079",1) THEN
                  LET g_pmds2_d[l_ac].pmdt011 = g_pmds2_d_t.pmdt011
                  NEXT FIELD pmdt011_d2_02
               END IF
               
               #160804-00068#1-add-(S)
               #沖銷順序重新計算 (避免輸入完資料，直接按確認，會有問題)
               IF NOT cl_null(g_pmds2_d[l_ac].pmdt006) THEN
                  CALL apmp520_02_def_pmdt011()
               END IF
               #160804-00068#1-add-(E)
               
               #沖銷順序
               IF NOT cl_null(g_pmds2_d[l_ac].pmdt011) AND NOT cl_null(g_pmds2_d[l_ac].pmdt006) THEN
                  IF NOT apmp520_02_chk_pmdt011() THEN
                     LET g_pmds2_d[l_ac].pmdt011 = g_pmds2_d_t.pmdt011
                     NEXT FIELD pmdt011_d2_02
                  END IF
               END IF  

            #收貨數量的檢查
               IF NOT cl_ap_chk_Range(g_pmds2_d[l_ac].pmdt020,"0","0","","","azz-00079",1) THEN
                  LET g_pmds2_d[l_ac].pmdt020 = g_pmds2_d_t.pmdt020
                  NEXT FIELD pmdt020_d2_02
               END IF
               
               IF NOT cl_null(g_pmds2_d[l_ac].pmdt020) THEN
                  LET g_qty = 0
                  CALL s_apmt520_get_quantity(g_pmds2_d[l_ac].pmdt001,g_pmds2_d[l_ac].pmdt002,g_pmds2_d[l_ac].pmdt003,g_pmds2_d[l_ac].pmdt004)
                       RETURNING g_qty
                  IF g_pmds2_d[l_ac].pmdt020 > g_qty THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apm-00383'
                     LET g_errparam.extend = g_pmds2_d[l_ac].pmdt020
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_pmds2_d[l_ac].pmdt020 = g_pmds2_d_t.pmdt020
                     NEXT FIELD pmdt020_d2_02
                  END IF
               
                  LET g_pmdo006 = ''
                  CALL apmp520_01_default_quantity(g_pmds2_d[l_ac].pmdt001,g_pmds2_d[l_ac].pmdt002,g_pmds2_d[l_ac].pmdt003,g_pmds2_d[l_ac].pmdt004)
                       RETURNING g_pmdo006
               
                  LET g_pmdn022 = ''
                  SELECT pmdn022 INTO g_pmdn022
                    FROM pmdn_t
                   WHERE pmdnent = g_enterprise
                     AND pmdndocno = g_pmds2_d[l_ac].pmdt001
                     AND pmdnseq = g_pmds2_d[l_ac].pmdt002
               
                  IF g_pmds2_d[l_ac].pmdt020 < g_pmdo006 AND g_pmdn022 = 'N' THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apm-00382'
                     LET g_errparam.extend = g_pmds2_d[l_ac].pmdt020
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_pmds2_d[l_ac].pmdt020 = g_pmds2_d_t.pmdt020
                     NEXT FIELD pmdt020_d2_02
                  END IF
               END IF
               
               #自動換算參考數量、計價數量
               IF NOT cl_null(g_pmds2_d[l_ac].pmdt021) THEN
                  CALL s_aooi250_convert_qty(g_pmds2_d[l_ac].pmdt006,g_pmds2_d[l_ac].pmdt019,g_pmds2_d[l_ac].pmdt021,g_pmds2_d[l_ac].pmdt020)
                       RETURNING g_flag,g_pmds2_d[l_ac].pmdt022
               END IF
               
               IF NOT cl_null(g_pmds2_d[l_ac].pmdt023) THEN
                  CALL s_aooi250_convert_qty(g_pmds2_d[l_ac].pmdt006,g_pmds2_d[l_ac].pmdt019,g_pmds2_d[l_ac].pmdt023,g_pmds2_d[l_ac].pmdt020)
                       RETURNING g_flag,g_pmds2_d[l_ac].pmdt024
               END IF
               
            #限定庫位的檢查
               IF NOT cl_null(g_pmds2_d[l_ac].pmdt016) THEN
                  IF g_pmds2_d[l_ac].pmdt016 != g_pmds2_d_t.pmdt016 OR g_pmds2_d_t.pmdt016 IS NULL THEN
                     IF NOT apmp520_02_pmdn050_chk() THEN
                        INITIALIZE g_chkparam.* TO NULL
                        LET g_chkparam.arg1 = g_pmds2_d[l_ac].pmdt016
                        #160318-00025#20  by 07900 --add-str
                        LET g_errshow = TRUE #是否開窗                   
                        LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
                        #160318-00025#20  by 07900 --add-end
                        IF NOT cl_chk_exist("v_inaa001_9") THEN
                           LET g_pmds2_d[l_ac].pmdt016 = g_pmds2_d_t.pmdt016
                        CALL s_desc_get_stock_desc(g_site,g_pmds2_d[l_ac].pmdt016)
                             RETURNING g_pmds2_d[l_ac].pmdt016_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                     
                     #儲位值清空
                     LET g_pmds2_d[l_ac].pmdt017 = ' '
                     LET g_pmds2_d[l_ac].pmdt017_desc = '' 
                     LET g_pmds2_d_t.pmdt017 = ' '
                     IF NOT cl_null(g_pmds2_d[l_ac].pmdt006) THEN
                        #預設沖銷順序
                        CALL apmp520_02_def_pmdt011()
                     END IF
                  END IF
               END IF   
               LET g_pmds2_d_t.pmdt016 = g_pmds2_d[l_ac].pmdt016  
               CALL s_desc_get_stock_desc(g_site,g_pmds2_d[l_ac].pmdt016)
                    RETURNING g_pmds2_d[l_ac].pmdt016_desc   

            #限定儲位的檢查
               IF NOT cl_null(g_pmds2_d[l_ac].pmdt017) THEN
                  IF g_pmds2_d[l_ac].pmdt017 != g_pmds2_d_t.pmdt017 OR g_pmds2_d_t.pmdt017 IS NULL THEN
                     IF NOT apmp520_02_pmdn050_chk() THEN
                        #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                        INITIALIZE g_chkparam.* TO NULL
                        LET g_chkparam.arg1 = g_site
                        LET g_chkparam.arg2 = g_pmds2_d[l_ac].pmdt016
                        LET g_chkparam.arg3 = g_pmds2_d[l_ac].pmdt017
                        IF NOT cl_chk_exist("v_inab002_1") THEN
                           #檢查失敗時後續處理
                           LET g_pmds2_d[l_ac].pmdt017 = g_pmds2_d_t.pmdt017
                           CALL s_desc_get_locator_desc(g_site,g_pmds2_d[l_ac].pmdt016,g_pmds2_d[l_ac].pmdt017)
                                RETURNING g_pmds2_d[l_ac].pmdt017_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                     
                     IF NOT cl_null(g_pmds2_d[l_ac].pmdt006) THEN
                        #預設沖銷順序
                        CALL apmp520_02_def_pmdt011()
                     END IF
                  END IF
               END IF   
               LET g_pmds2_d_t.pmdt017 = g_pmds2_d[l_ac].pmdt017  
               CALL s_desc_get_locator_desc(g_site,g_pmds2_d[l_ac].pmdt016,g_pmds2_d[l_ac].pmdt017)
                    RETURNING g_pmds2_d[l_ac].pmdt017_desc
                    
            #批號的檢查         
               IF NOT cl_null(g_pmds2_d[l_ac].pmdt018) THEN
                  IF g_pmds2_d[l_ac].pmdt018 != g_pmds2_d_t.pmdt018 OR g_pmds2_d_t.pmdt018 IS NULL THEN
                     IF NOT cl_null(g_pmds2_d[l_ac].pmdt006) THEN
                        #預設沖銷順序
                        CALL apmp520_02_def_pmdt011()
                     END IF
                  END IF
               END IF   
               LET g_pmds2_d_t.pmdt018 = g_pmds2_d[l_ac].pmdt018  

               CALL apmp520_02_update_temp2()
               IF g_pmds2_d[l_ac].pmdt062 = 'N' THEN
                  CALL apmp520_02_update_temp3()
               END IF
               
               EXIT DIALOG 
            
            
            ON ACTION cancel 
               LET g_pmds2_d[l_ac].*  = g_pmds2_d_t.*
               IF g_pmds2_d_t.pmdt062 = 'N' THEN
                  LET l_del_pmdt = FALSE
                  LET g_cnt = 0 
                  CALL apmp520_02_update_temp2()                  
                  SELECT COUNT(*) INTO g_cnt
                    FROM apmp520_tmp03   #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d3 ——> apmp520_tmp03
                   WHERE keyno = g_pmds2_d[l_ac].keyno
                     AND pmduseq = g_pmds2_d[l_ac].pmdtseq 
                  #151118-00029#2 20160328 by ming modify -----(S)    
                  #IF g_cnt > 0 THEN
                  IF g_cnt > 1 THEN
                  #151118-00029#2 20160328 by ming modify -----(E)    
                     #IF cl_ask_confirm('apm-00559') THEN
                        DELETE FROM apmp520_tmp03   #160727-00019#11   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 apmp520_02_temp_d3 ——> apmp520_tmp03
                         WHERE keyno = g_pmds2_d[l_ac].keyno
                           AND pmduseq = g_pmds2_d[l_ac].pmdtseq
                        CALL apmp520_02_update_temp3()                        
                     #ELSE
                     #   LET g_pmds2_d[l_ac1].pmdt062 = 'Y'
                     #   LET l_del_pmdt = TRUE
                     #END IF
                  END IF               
               END IF 

               EXIT DIALOG             
      END INPUT   
   END DIALOG
END FUNCTION

 
{</section>}
 
