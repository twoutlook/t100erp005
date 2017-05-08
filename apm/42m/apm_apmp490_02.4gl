#該程式未解開Section, 採用最新樣板產出!
{<section id="apmp490_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0027(2017-02-20 16:24:48), PR版次:0027(2017-02-20 16:55:58)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000226
#+ Filename...: apmp490_02
#+ Description: 引導式請購轉採購作業_分配處理
#+ Creator....: 03079(2014-04-11 17:16:05)
#+ Modifier...: 05384 -SD/PR- 05384
 
{</section>}
 
{<section id="apmp490_02.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"
#151118-00029#1.....2016/01/12 By ming      修改第二步的上方單身時，只有綠勾勾(確認)，沒有紅叉叉(取消)，此次補上紅叉叉
#160318-00005#35   2016/03/28  By 07900     重复错误信息修改
#160318-00025#1    2016/04/05  by 07675     將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160706-00037#1    2016/07/07  By 03079     移除沒有需求單號的註解 
#160801-00004#3    2016/08/01  By lixiang   庫存管理特微有值時，需帶入到採購單上，且有值時，請購資料不合併
#160819-00043#6    2016/08/23  By lixiang   抓取"分配比率(pmao008)"的部份，改抓pmat_t檔，需串到site
#160824-00032#1    2016/08/23  By lixiang   料件据点资料设置供应商选择方式是：主供应商优先，余量分配 或者 在画面上选择该分配方式时，产生的分配资料不正确
#160908-00029#1    2016/09/20  By 02097     料件设置了最小采购数量，且管控方式是强制时，转出的采购单数量仍然可以小于最小采购数量
#161005-00031#1    2016/10/12  By Ann_Huang 檢查供應商是否存在apmm202(供應商據點資料)中
#161107-00031#1    2016/11/16  By shiun     依比例分配採購數量取位問題
#161214-00058#1    2016/12/15  By wuxja     若送货地址、账款地址为空时预设当前据点的出货地址及账款地址
#161006-00018#21   2016/12/26  By lixh      增加参数D-MFG-0085(來源單據指定庫儲後，是否允許修改)
#161221-00064#9    2017/01/10  By zhujing   增加pmao000(1-采购，2-销售),用于区分axmi120和apmi120数据显示
#170123-00050#1    2017/01/25  By wuxja     删除所选资料后重新显示时需把说明等栏位一并显示出来
#150305-00010#1    2017/02/03  By shiun     b_fill_02、b_fill_03、b_fill_04中抓資料的SQL,都增加過濾stus <> 'X'條件
#161230-00019#1    2017/02/13  By shiun     供應商不得選一次性交易對象
#161031-00025#6    2017/02/17  By shiun     同原單身備註，依單別參數帶入來源單據長備註
#end add-point
#add-point:填寫註解說明(客製用) name="main.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="main.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
#add-point:增加匯入變數檔 name="global.inc"
GLOBALS "../../apm/4gl/apmp490_01.inc"
GLOBALS "../../apm/4gl/apmp490_02.inc"
#end add-point
 
{</section>}
 
{<section id="apmp490_02.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
 TYPE type_g_pmdn_d RECORD
                              pmdb014_02_01         LIKE pmdb_t.pmdb014,     #供應商選擇 
                              pmdl004_02_01         LIKE pmdl_t.pmdl004,     #供應商編號  
                              pmaal004_02_01        LIKE pmaal_t.pmaal004,   #供應商名稱 
                              pmdb004_02_01         LIKE pmdb_t.pmdb004,     #料件編號  
                              imaal003_02_01_1      LIKE imaal_t.imaal003,   #品名  
                              imaal004_02_01_1      LIKE imaal_t.imaal004,   #規格  
                              pmdb005_02_01         LIKE pmdb_t.pmdb005,     #產品特徵   
                              pmdb005_02_01_desc    LIKE type_t.chr80,       #產品特徵說明  
                              pmdb007_02_01         LIKE pmdb_t.pmdb007,     #單位  
                              pmdb007_02_01_desc    LIKE type_t.chr80,       #單位說明 
                              qty_02_01             LIKE pmdb_t.pmdb006,     #未轉採購量  
                              pmdn014_02_01         LIKE pmdn_t.pmdn014,     #到庫日期  
                              pmdn001_02_01         LIKE pmdn_t.pmdn001,     #料件編號  
                              imaal003_02_01_2      LIKE imaal_t.imaal003,   #品名  
                              imaal004_02_01_2      LIKE imaal_t.imaal004,   #規格  
                              pmdn002_02_01         LIKE pmdn_t.pmdn002,     #產品特徵   
                              pmdn002_02_01_desc    LIKE type_t.chr80,       #產品特徵說明 
                              pmdn006_02_01         LIKE pmdn_t.pmdn006,     #採購單位  
                              pmdn006_02_01_desc    LIKE type_t.chr80,       #單位說明 
                              pmdn007_02_01         LIKE pmdn_t.pmdn007,     #採購數量   
                              pmdn008_02_01         LIKE pmdn_t.pmdn008,     #參考單位  
                              pmdn008_02_01_desc    LIKE type_t.chr80,       #單位說明 
                              pmdn009_02_01         LIKE pmdn_t.pmdn009,     #參考數量 
                              pmdn010_02_01         LIKE pmdn_t.pmdn010,     #計價單位  
                              pmdn010_02_01_desc    LIKE type_t.chr80,       #單位說明           
                              pmdn011_02_01         LIKE pmdn_t.pmdn011,     #計價數量   
                              pmdl025_02_01         LIKE pmdl_t.pmdl025,     #送貨地址 
                              pmdl025_02_01_desc    LIKE type_t.chr500,      #送貨地址說明 
                              pmdl025_02_01_oofb017 LIKE oofb_t.oofb017,     #地址 
                              pmdl026_02_01         LIKE pmdl_t.pmdl026,     #帳款地址 
                              pmdl026_02_01_desc    LIKE type_t.chr500,      #帳款地址說明 
                              pmdl026_02_01_oofb017 LIKE oofb_t.oofb017,     #地址  
                              pmdn058_02_01         LIKE pmdn_t.pmdn058,     #預算科目 
                              pmdn058_02_01_desc    LIKE type_t.chr500,      # 
                              pmdn036_02_01         LIKE pmdn_t.pmdn036,     #專案編號 
                              pmdn036_02_01_desc    LIKE type_t.chr500,      #專案編號說明 
                              pmdn037_02_01         LIKE pmdn_t.pmdn037,     #WBS 
                              pmdn037_02_01_desc    LIKE type_t.chr500,      #WBS說明 
                              pmdn038_02_01         LIKE pmdn_t.pmdn038,     #活動編號 
                              pmdn038_02_01_desc    LIKE type_t.chr500,      #活動編號說明 
                              #160801-00004#3--s
                              pmdn028_02_01         LIKE pmdn_t.pmdn028,       #庫位
                              pmdn028_02_01_desc    LIKE type_t.chr500,        #庫位說明 
                              pmdn029_02_01         LIKE pmdn_t.pmdn029,       #儲位
                              pmdn029_02_01_desc    LIKE type_t.chr500,        #儲位說明 
                              pmdn053_02_01         LIKE pmdn_t.pmdn053,       #庫存管理特徵
                              #160801-00004#3--e              
                              pmdn050_02_01         LIKE pmdn_t.pmdn050,     #備註  
                              ooff013_02_01         LIKE ooff_t.ooff013,     #長備註   #161031-00025#6
                              ooff014_02_01         LIKE ooff_t.ooff014,     #失效日期 #161031-00025#6
                              pmdbdocno_02_01       LIKE pmdb_t.pmdbdocno,   #請購單號 
                              pmdbseq_02_01         LIKE pmdb_t.pmdbseq,     #請購項次  
                              pmdbent_02_01         LIKE pmdb_t.pmdbent,
                              pmdbsite_02_01        LIKE pmdb_t.pmdbsite
                           END RECORD
DEFINE g_pmdn_d            DYNAMIC ARRAY OF type_g_pmdn_d
DEFINE g_pmdn_d_t          type_g_pmdn_d
DEFINE l_ac                LIKE type_t.num5 

DEFINE g_ref_fields        DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields        DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列  

DEFINE g_rec_b             LIKE type_t.num5
DEFINE g_detail_idx        LIKE type_t.num5
DEFINE g_apmp490_02_pmdn_d DYNAMIC ARRAY OF RECORD
                              pmdl004_02_02       LIKE pmdl_t.pmdl004,      #供應商編號  
                              pmaal004_02_02      LIKE pmaal_t.pmaal004,    #供應商名稱 
                              pmdldocno_02_02     LIKE pmdl_t.pmdldocno,    #採購單號  
                              pmdldocdt_02_02     LIKE pmdl_t.pmdldocdt,    #採購日期   
                              pmdl009_02_02       LIKE pmdl_t.pmdl009,      #付款條件   
                              pmdl010_02_02       LIKE pmdl_t.pmdl010,      #交易條件   
                              pmdl011_02_02       LIKE pmdl_t.pmdl011,      #稅別   
                              pmdl012_02_02       LIKE pmdl_t.pmdl012,      #稅率   
                              pmdl013_02_02       LIKE pmdl_t.pmdl013,      #單價含稅否    
                              pmdl015_02_02       LIKE pmdl_t.pmdl015,      #幣別   
                              pmdl016_02_02       LIKE pmdl_t.pmdl016,      #匯率   
                              pmdn007_02_02       LIKE pmdn_t.pmdn007,      #數量   
                              pmdn015_02_02       LIKE pmdn_t.pmdn015,      #單價   
                              pmdn040_02_02       LIKE pmdn_t.pmdn040       #取價來源  
                           END RECORD 
DEFINE g_apmp490_02_pmds_d DYNAMIC ARRAY OF RECORD
                              pmds009_02_03       LIKE pmds_t.pmds009,      #送貨供應商  
                              pmaal004_02_03      LIKE pmaal_t.pmaal004,    #供應商名稱 
                              pmdsdocno_02_03     LIKE pmds_t.pmdsdocno,    #單據單號  
                              pmdo013_02_03       LIKE pmdo_t.pmdo013,      #到庫日期  
                              pmdsdocdt_02_03     LIKE pmds_t.pmdsdocdt,    #單據日期  
                              stus_02_03          LIKE type_t.chr20,        #狀態  
                              diff_day_02_03      LIKE type_t.num10         #差異天數  
                           END RECORD 
DEFINE g_apmp490_02_qcba_d DYNAMIC ARRAY OF RECORD
                              qcba005_02_04       LIKE qcba_t.qcba005,      #供應商 
                              pmaal004_02_04      LIKE pmaal_t.pmaal004,    #供應商名稱 
                              qcbadocno_02_04     LIKE qcba_t.qcbadocno,    #單號  
                              qcba014_02_04       LIKE qcba_t.qcba014,      #檢驗日期  
                              imae116_02_04       LIKE imae_t.imae116,      #檢驗水準  
                              qcba018_02_04       LIKE qcba_t.qcba018,      #檢驗程度  
                              qcba019_02_04       LIKE qcba_t.qcba019,      #檢驗級數  
                              qcba017_02_04       LIKE qcba_t.qcba017,      #送驗量  
                              qcba022_02_04       LIKE qcba_t.qcba022,      #判定結果  
                              qcba023_02_04       LIKE qcba_t.qcba023       #合格量  
                           END RECORD 
DEFINE g_apmp490_02_pmdn_color_d DYNAMIC ARRAY OF RECORD
                                    pmdl004    LIKE type_t.chr80,
                                    pmdb004    LIKE type_t.chr80,
                                    pmdb005    LIKE type_t.chr80,
                                    pmdb007    LIKE type_t.chr80,
                                    qty        LIKE type_t.chr80,
                                    pmdn014    LIKE type_t.chr80,
                                    pmdn001    LIKE type_t.chr80,
                                    pmdn002    LIKE type_t.chr80,
                                    pmdn006    LIKE type_t.chr80,
                                    pmdn007    LIKE type_t.chr80,
                                    pmdn010    LIKE type_t.chr80,
                                    pmdn011    LIKE type_t.chr80,
                                    pmdbent    LIKE type_t.chr80,
                                    pmdbsite   LIKE type_t.chr80
                                 END RECORD
DEFINE g_date                    LIKE pmdl_t.pmdldocdt
DEFINE g_mm                      LIKE type_t.num5
#end add-point
 
{</section>}
 
{<section id="apmp490_02.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="apmp490_02.other_dialog" >}

DIALOG apmp490_02_input01()
   DEFINE l_sql     STRING
   DEFINE l_sql1    STRING
   DEFINE l_sql2    STRING
   DEFINE l_success LIKE type_t.num5
   DEFINE l_wc      STRING

   INPUT BY NAME g_apmp490_02_input.scb01,g_apmp490_02_input.scb02,
                 g_apmp490_02_input.bt01,g_apmp490_02_input.ed01,
                 g_apmp490_02_input.scb03
                 ATTRIBUTE(WITHOUT DEFAULTS)

      BEFORE INPUT
         CALL apmp490_02_set_entry('a')
         CALL apmp490_02_set_no_entry('a')

      AFTER INPUT

      ON CHANGE scb01
         CALL apmp490_02_set_entry('a')
         CALL apmp490_02_set_no_entry('a')

      AFTER FIELD bt01
        CALL apmp490_02_bt01_ref(g_apmp490_02_input.bt01) RETURNING g_apmp490_02_input.bt01_desc
        DISPLAY BY NAME g_apmp490_02_input.bt01_desc

        IF NOT cl_null(g_apmp490_02_input.bt01) THEN
           IF NOT apmp490_02_pmdl004_chk(g_apmp490_02_input.bt01) THEN
              
              NEXT FIELD CURRENT 
           END IF

        END IF

      AFTER FIELD ed01
         IF NOT cl_null(g_apmp490_02_input.ed01) THEN
            IF g_apmp490_02_input.ed01 <= 0 THEN    #必輸不可空白，數量需>0  
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'ade-00016'    #數量不可小於等於0
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
           
               NEXT FIELD CURRENT
            END IF
         END IF

      ON CHANGE scb03
         #當「參考資料期間」改變的時候 要重新找符合期間的資料  
         CASE g_apmp490_02_input.scb03
            WHEN '0'            #1個月   
               LET g_mm = 1
            WHEN '1'            #2個月  
               LET g_mm = 2
            WHEN '2'            #3個月  
               LET g_mm = 3
            WHEN '3'            #6個月  
               LET g_mm = 6
            WHEN '4'            #1年  
               LET g_mm = 12
         END CASE

         #利用sql計算要查找資料的起始點 
         #SELECT ADD_MONTHS(LAST_DAY(g_today)+1,-g_mm) INTO g_date FROM DUAL  
         #假設今天是 2014/05/15 而我要找的是1個月前到今日的資料  
         #是要找2014/04/15 ~ 2014/05/15的資料 所以不用算到月初  
         SELECT ADD_MONTHS(g_today,-g_mm) INTO g_date FROM DUAL

         LET l_wc = "pmdldocdt BETWEEN '",g_date,"' AND '",g_today,"' "
         CALL apmp490_02_b_fill_02(l_wc)
         LET l_wc = "pmdsdocdt BETWEEN '",g_date,"' AND '",g_today,"' "
         CALL apmp490_02_b_fill_03(l_wc)
         LET l_wc = "qcbadocdt BETWEEN '",g_date,"' AND '",g_today,"' "
         CALL apmp490_02_b_fill_04(l_wc)

      ON ACTION controlp INFIELD bt01
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'i'
         LET g_qryparam.reqry = FALSE

         LET g_qryparam.default1 = g_apmp490_02_input.bt01

         LET g_qryparam.where = "1=1 "

         #統一使用s_control_get_supplier_sql()回傳的sql丟入where條件即可 
         CALL s_control_get_supplier_sql('4',g_site,g_user,g_dept,g_apmp490_01_input.pmdldocno)
              RETURNING l_success,l_sql
         IF l_success THEN
            LET g_qryparam.where = l_sql
         END IF

         #161005-00031#1-(S)-add
         IF NOT cl_null(g_qryparam.where) THEN
            LET g_qryparam.where = g_qryparam.where, " AND "
         END IF
         LET g_qryparam.where = g_qryparam.where, 
                                " pmaa004 <> '2' AND ",   #161230-00019#1
                                "pmaa001 IN (SELECT pmab001 FROM pmab_t ",                                             
                                "             WHERE pmabsite = '",g_site,"' AND pmabent = '",g_enterprise,"' AND 1=1)" 
         #161005-00031#1-(E)-add
         CALL q_pmaa001_3()

         LET g_apmp490_02_input.bt01 = g_qryparam.return1
         DISPLAY g_apmp490_02_input.bt01 TO bt01

         NEXT FIELD bt01

   END INPUT
END DIALOG

DIALOG apmp490_02_display01()
   DEFINE l_wc     STRING

   DISPLAY ARRAY g_pmdn_d TO s_apmp490_02_detail1.* ATTRIBUTE(COUNT=g_d_cnt_p49002_01)
      BEFORE DISPLAY
         CALL FGL_SET_ARR_CURR(g_d_idx_p49002_01)
         CALL DIALOG.setCellAttributes(g_apmp490_02_pmdn_color_d)

      BEFORE ROW
         LET g_d_idx_p49002_01 = DIALOG.getCurrentRow("s_apmp490_02_detail1")

         LET g_appoint_idx = g_d_idx_p49002_01

         SELECT ADD_MONTHS(g_today,-g_mm) INTO g_date FROM DUAL

         LET l_wc = "pmdldocdt BETWEEN '",g_date,"' AND '",g_today,"' "
         CALL apmp490_02_b_fill_02(l_wc)
         LET l_wc = "pmdsdocdt BETWEEN '",g_date,"' AND '",g_today,"' "
         CALL apmp490_02_b_fill_03(l_wc)
         LET l_wc = "qcbadocdt BETWEEN '",g_date,"' AND '",g_today,"' "
         CALL apmp490_02_b_fill_04(l_wc)


   END DISPLAY
END DIALOG

DIALOG apmp490_02_display02()
   DISPLAY ARRAY g_apmp490_02_pmdn_d TO s_apmp490_02_detail2.* ATTRIBUTE(COUNT=g_d_cnt_p49002_02)
      BEFORE DISPLAY
         CALL FGL_SET_ARR_CURR(g_d_idx_p49002_02)

      BEFORE ROW
         LET g_d_idx_p49002_02 = DIALOG.getCurrentRow("s_apmp490_02_detail2")
         
         LET g_appoint_idx = g_d_idx_p49002_02
   END DISPLAY
END DIALOG

DIALOG apmp490_02_display03()
   DISPLAY ARRAY g_apmp490_02_pmds_d TO s_apmp490_02_detail3.* ATTRIBUTE(COUNT=g_d_cnt_p49002_03)
      BEFORE DISPLAY
         CALL FGL_SET_ARR_CURR(g_d_idx_p49002_03)

      BEFORE ROW
         LET g_d_idx_p49002_03 = DIALOG.getCurrentRow("s_apmp490_02_detail3")
         LET g_appoint_idx = g_d_idx_p49002_03
   END DISPLAY
END DIALOG

DIALOG apmp490_02_display04()
   DISPLAY ARRAY g_apmp490_02_qcba_d TO s_apmp490_02_detail4.* ATTRIBUTE(COUNT=g_d_cnt_p49002_04)
      BEFORE DISPLAY
         CALL FGL_SET_ARR_CURR(g_d_idx_p49002_04)

      BEFORE ROW
         LET g_d_idx_p49002_04 = DIALOG.getCurrentRow("s_apmp490_02_detail4")
         LET g_appoint_idx = g_d_idx_p49002_04
   END DISPLAY
END DIALOG

 
{</section>}
 
{<section id="apmp490_02.other_function" readonly="Y" >}

PUBLIC FUNCTION apmp490_02(--)
   #add-point:input段變數傳入

   #end add-point
   )

END FUNCTION

################################################################################
# Descriptions...: 資料初始設定
# Memo...........:
# Usage..........: CALL apmp490_02_init()
# Date & Author..: 2014/06/18 By ming
# Modify.........:
################################################################################
PUBLIC FUNCTION apmp490_02_init()
   DEFINE l_msg     STRING 
 
   WHENEVER ERROR CONTINUE 

   #設定ComboBox的選項 
   #151022-00003#3 20151201 modify by ming -----(S) 
   #增加選項 
   #LET l_msg = cl_getmsg("apm-00469",g_lang),",",         #1.依料件主檔設定   
   #            cl_getmsg("apm-00470",g_lang),",",         #2.主要供應商，無限量  
   #            cl_getmsg("apm-00471",g_lang),",",         #3.依廠商分配  
   #            cl_getmsg("apm-00472",g_lang),",",         #4.主要供應商分配優先，餘量分配  
   #            cl_getmsg("apm-00473",g_lang)              #5.指定單一供應商  
   #CALL cl_set_combo_items("scb01","1,2,3,4,5",l_msg)
   LET l_msg = cl_getmsg("apm-00469",g_lang),",",         #1.依料件主檔設定   
               cl_getmsg("apm-00470",g_lang),",",         #2.主要供應商，無限量  
               cl_getmsg("apm-00471",g_lang),",",         #3.依廠商分配  
               cl_getmsg("apm-00472",g_lang),",",         #4.主要供應商分配優先，餘量分配  
               cl_getmsg("apm-00473",g_lang),",",         #5.指定單一供應商  
               cl_getmsg("apm-01039",g_lang)              #6.預設取價條件之最低價供應商 
   CALL cl_set_combo_items("scb01","1,2,3,4,5,6",l_msg)
   #151022-00003#3 20151201 modify by ming -----(E) 

   LET l_msg = cl_getmsg("apm-00474",g_lang),",",         #1.依料件進行匯總  
               cl_getmsg("apm-00475",g_lang),",",         #2.依料件+需求日期進行匯總  
               cl_getmsg("apm-01031",g_lang)              #3.不匯總  
   CALL cl_set_combo_items("scb02","1,2,3",l_msg)

   LET l_msg = cl_getmsg("apm-00476",g_lang),",",         #一個月  
               cl_getmsg("apm-00477",g_lang),",",         #二個月  
               cl_getmsg("apm-00478",g_lang),",",         #三個月  
               cl_getmsg("apm-00479",g_lang),",",         #六個月  
               cl_getmsg("apm-00480",g_lang)              #一年  
   CALL cl_set_combo_items("scb03","0,1,2,3,4",l_msg)

   CALL cl_set_combo_scc("pmdb014_02_01","2037")          #供應商選擇 
   CALL cl_set_combo_scc("pmdn040_02_02","2016")          #取價來源    
   
   CALL cl_set_combo_scc("imae116_02_04","5052")          #檢驗水準  
   CALL cl_set_combo_scc("qcba018_02_04","5051")          #程度  
   CALL cl_set_combo_scc("qcba019_02_04","5053")          #級數   
   CALL cl_set_combo_scc("qcba022_02_04","5072")          #判定結果  
   
   #設定ComboBox預設值  
   LET g_apmp490_02_input.scb01 = 1
   
   LET g_apmp490_02_input.scb02 = 3

   LET g_apmp490_02_input.scb03 = 3

   CASE g_apmp490_02_input.scb03
      WHEN '0'           #一個月   
         LET g_mm = 1
      WHEN '1'           #兩個月  
         LET g_mm = 2
      WHEN '2'           #三個月  
         LET g_mm = 3
      WHEN '3'           #六個月   
         LET g_mm = 6
      WHEN '4'           #一年  
         LET g_mm = 12
   END CASE 
   
   #不使用產品特徵，則將產品特徵及說明隱藏 
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'N' THEN
      CALL cl_set_comp_visible("pmdb005_02_01,pmdb005_02_01_desc",FALSE)
      CALL cl_set_comp_visible("pmdn002_02_01,pmdn002_02_01_desc",FALSE)
   END IF 
   
   #取得據點參數，若不使用參考單位時，則參考單位、數量需隱藏，不可維護  
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0028') = 'N' THEN
      CALL cl_set_comp_visible("pmdn008_02_01,pmdn008_02_01_desc,pmdn009_02_01",FALSE)
   END IF

   #取得據點參數，若不使用計價單位時，則計價單位、數量需隱藏，不可維護 
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0019') = 'N' THEN
      CALL cl_set_comp_visible("pmdn010_02_01,pmdn010_02_01_desc,pmdn011_02_01",FALSE)
   END IF 
      
   CALL g_pmdn_d.clear()      #上方單身清空  
   CALL g_apmp490_02_pmdn_d.clear()
   CALL g_apmp490_02_pmds_d.clear()
   CALL g_apmp490_02_qcba_d.clear()
END FUNCTION

################################################################################
# Descriptions...: 畫面欄位開關設定
# Memo...........:
# Usage..........: CALL apmp490_02_set_entry(p_cmd)
# Input parameter: p_cmd:模式
# Date & Author..: 2014/06/18 By ming
# Modify.........:
################################################################################
PUBLIC FUNCTION apmp490_02_set_entry(p_cmd)
   DEFINE p_cmd LIKE type_t.chr1

   WHENEVER ERROR CONTINUE 

   CALL cl_set_comp_entry("ed01",TRUE) 
   CALL cl_set_comp_entry("bt01",TRUE)
   
END FUNCTION

################################################################################
# Descriptions...: 畫面欄位開關設定
# Memo...........:
# Usage..........: CALL apmp490_02_set_no_entry(p_cmd)
# Input parameter: p_cmd:模式
# Date & Author..: 2014/06/18 By ming
# Modify.........:
################################################################################
PUBLIC FUNCTION apmp490_02_set_no_entry(p_cmd)
   DEFINE p_cmd LIKE type_t.chr1

   WHENEVER ERROR CONTINUE 

   IF g_apmp490_02_input.scb01 <> 4 THEN
      CALL cl_set_comp_entry("ed01",FALSE)
   END IF 
   
   IF g_apmp490_02_input.scb01 <> '1' AND g_apmp490_02_input.scb01 <> '5' THEN
      CALL cl_set_comp_entry("bt01",FALSE)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 上方單身資料填充
# Memo...........:
# Usage..........: CALL apmp490_02_b_fill_01(p_wc)
# Input parameter: p_wc
# Date & Author..: 2014/06/18 By ming
# Modify.........:
################################################################################
PUBLIC FUNCTION apmp490_02_b_fill_01(p_wc)
   DEFINE p_wc     STRING
   DEFINE l_sql    STRING
   DEFINE l_ac1    LIKE type_t.num5
   DEFINE l_success LIKE type_t.num5
   DEFINE l_rate    LIKE inaj_t.inaj014
   DEFINE l_pmdn_d  type_g_pmdn_d
   DEFINE l_imaf152 LIKE imaf_t.imaf152 
   DEFINE l_wc      STRING  
   DEFINE l_oofa001 LIKE oofa_t.oofa001

   WHENEVER ERROR CONTINUE 

   IF g_apmp490_02_input.scb01 = '4' THEN        #主要供應商分配優先，餘量分配  
      IF cl_null(g_apmp490_02_input.ed01) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ''
         LET g_errparam.code   = 'apm-00695'     #主要供應商分配優先，餘量分配時，主供應商分配限量不可為空！   
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         RETURN
      END IF

      IF g_apmp490_02_input.ed01 <= 0 THEN    #必輸不可空白，數量需>0  
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ''
         LET g_errparam.code   = 'ade-00016' #數量不可小於等於0   
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         RETURN
      END IF
   END IF 
   
   IF g_apmp490_02_input.scb01 = '5' THEN        #指定單一供應商  
      IF cl_null(g_apmp490_02_input.bt01) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ''
         LET g_errparam.code   = 'art-00282'     #供應商欄位不可為空！  
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         RETURN
      END IF

      #檢查供應商 
      IF NOT apmp490_02_pmdl004_chk(g_apmp490_02_input.bt01) THEN
         RETURN
      END IF

      #顯示供應商名稱說明 
      CALL apmp490_02_bt01_ref(g_apmp490_02_input.bt01) RETURNING g_apmp490_02_input.bt01_desc
      DISPLAY BY NAME g_apmp490_02_input.bt01_desc
   END IF 
   
   IF NOT cl_null(g_apmp490_02_input.bt01) THEN
      IF NOT apmp490_02_pmdl004_chk(g_apmp490_02_input.bt01) THEN
         RETURN
      END IF
   END IF

   DELETE FROM p490_02_pmdn_t;
   DELETE FROM p490_02_pmdb_t;

   UPDATE p490_01_pmdb_t SET applied_qty = '0'

   CALL g_pmdn_d.clear()

   #IF g_apmp490_02_input.scb02 = '1' THEN        #依料件進行匯總  
   CASE g_apmp490_02_input.scb02     #匯總方式  
      WHEN '1'     #依料件進行匯總  
         LET l_sql = "SELECT pmdb014,pmdb015,'',pmdb004,'','',pmdb005,'',pmdb007,'',SUM(qty),",
                     "       '','','','','','','','','','','','','','','', ",
                     "       pmda024,'','',pmda025,'','', ",
                     "       pmdb053,'', ",
                     "       pmdb034,'',pmdb035,'',pmdb036,'', ",
                     "       pmdb038,'',pmdb039,'',pmdb054, ",   #160801-00004#3
                     #161031-00025#6-s-mod
#                     "       pmdb050,'','',pmdbent,pmdbsite",
                     "       pmdb050,ooff013,ooff014,'','',pmdbent,pmdbsite",
                     #161031-00025#6-e-mod
                     "  FROM p490_01_pmdb_t,imaf_t ",
                     " WHERE imafent = pmdbent ",
                     "   AND imafsite = pmdbsite ",
                     "   AND imaf001 = pmdb004 ", 
                     " GROUP BY pmdb014,pmdb015,pmdb004,pmdb005,pmdb007, ",
                     "          pmda024,pmda025,pmdb053,pmdb034,pmdb035,pmdb036, ",
                     "          pmdb038,pmdb039,pmdb054, ",   #160801-00004#3
                     #161031-00025#6-s-mod
#                     "          pmdb050,pmdbent,pmdbsite",
                     "          pmdb050,ooff013,ooff014,pmdbent,pmdbsite",
                     #161031-00025#6-e-mod
                     " ORDER BY pmdb004,pmdb005 "
      WHEN '2'     #依料件+需求日進行匯總  
         LET l_sql = "SELECT pmdb014,pmdb015,'',pmdb004,'','',pmdb005,'',pmdb007,'',SUM(qty),",
                     "       pmdb030,'','','','','','','','','','','','','','', ",
                     "       pmda024,'','',pmda025,'','', ",
                     "       pmdb053,'', ",
                     "       pmdb034,'',pmdb035,'',pmdb036,'', ",
                     "       pmdb038,'',pmdb039,'',pmdb054, ",   #160801-00004#3
                     #161031-00025#6-s-mod
#                     "       pmdb050,'','',pmdbent,pmdbsite ",
                     "       pmdb050,ooff013,ooff014,'','',pmdbent,pmdbsite ",
                     #161031-00025#6-e-mod
                     "  FROM p490_01_pmdb_t,imaf_t ",
                     " WHERE imafent = pmdbent ",
                     "   AND imafsite = pmdbsite ",
                     "   AND imaf001 = pmdb004 ",
                     " GROUP BY pmdb014,pmdb015,pmdb004,pmdb005,pmdb007, ",
                     "          pmdb030,pmda024,pmda025,pmdb053,pmdb034,pmdb035,pmdb036, ",
                     "          pmdb038,pmdb039,pmdb054, ",   #160801-00004#3
                     #161031-00025#6-s-mod
#                     "          pmdb050,pmdbent,pmdbsite",
                     "          pmdb050,ooff013,ooff014,pmdbent,pmdbsite",
                     #161031-00025#6-e-mod
                     " ORDER BY pmdb004,pmdb005 "
      WHEN '3'     #不匯總  
         LET l_sql = "SELECT pmdb014,pmdb015,'',pmdb004,'','',pmdb005,'',pmdb007,'',qty,",
                     "       pmdb030,'','','','','','','','','','','','','','', ",
                     "       pmda024,'','',pmda025,'','', ",
                     "       pmdb053,'', ",
                     "       pmdb034,'',pmdb035,'',pmdb036,'', ",
                     "       pmdb038,'',pmdb039,'',pmdb054, ",   #160801-00004#3
                     #161031-00025#6-s-mod
#                     "       pmdb050,pmdbdocno,pmdbseq,pmdbent,pmdbsite ",
                     "       pmdb050,ooff013,ooff014,pmdbdocno,pmdbseq,pmdbent,pmdbsite ",
                     #161031-00025#6-e-mod
                     "  FROM p490_01_pmdb_t,imaf_t ",
                     " WHERE imafent = pmdbent ",
                     "   AND imafsite = pmdbsite ",
                     "   AND imaf001 = pmdb004 ", 
                     " ORDER BY pmdb004,pmdb005 "
   END CASE
   
   PREPARE apmp490_02_group_prep FROM l_sql
   DECLARE apmp490_02_group_curs CURSOR FOR apmp490_02_group_prep

   LET l_ac1 = 1 
   
   CALL cl_err_collect_init()

   FOREACH apmp490_02_group_curs INTO l_pmdn_d.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      IF g_apmp490_02_input.scb02 = '1' THEN               #依料件進行匯總的話  
         SELECT MIN(pmdb030) INTO l_pmdn_d.pmdn014_02_01   #如果需求日有不同的話  
           FROM p490_01_pmdb_t                             #就以最小的為主  
          WHERE pmdb004 = l_pmdn_d.pmdb004_02_01
      END IF

      LET l_pmdn_d.pmdn001_02_01 = l_pmdn_d.pmdb004_02_01  #料件編號  
      LET l_pmdn_d.pmdn002_02_01 = l_pmdn_d.pmdb005_02_01  #產品特徵    
      
      #取得產品特徵說明 
      CALL s_feature_description(l_pmdn_d.pmdb004_02_01,l_pmdn_d.pmdb005_02_01)
           RETURNING l_success,l_pmdn_d.pmdb005_02_01_desc
      CALL s_feature_description(l_pmdn_d.pmdn001_02_01,l_pmdn_d.pmdn002_02_01)
           RETURNING l_success,l_pmdn_d.pmdn002_02_01_desc

      #取得料件的採購單位 
      SELECT imaf143 INTO l_pmdn_d.pmdn006_02_01
        FROM imaf_t
       WHERE imafent  = l_pmdn_d.pmdbent_02_01
         AND imafsite = l_pmdn_d.pmdbsite_02_01
         AND imaf001  = l_pmdn_d.pmdn001_02_01

      IF cl_null(l_pmdn_d.pmdn006_02_01) THEN
         LET l_pmdn_d.pmdn006_02_01 = l_pmdn_d.pmdb007_02_01
      END IF

      LET l_pmdn_d.pmdn007_02_01 = l_pmdn_d.qty_02_01
      IF l_pmdn_d.pmdb007_02_01 != l_pmdn_d.pmdn006_02_01 THEN
         #單位轉換 
         CALL apmp490_02_convert_qty(l_pmdn_d.pmdb004_02_01,     #料號  
                                     l_pmdn_d.pmdb007_02_01,     #來源單位  
                                     l_pmdn_d.pmdn006_02_01,     #目的單位  
                                     l_pmdn_d.pmdn007_02_01)     #數量  
              RETURNING l_pmdn_d.pmdn007_02_01
      END IF
      
      #參考單位 
      IF cl_get_para(g_enterprise,g_site,'S-BAS-0028') = 'Y' THEN
         SELECT imaf015 INTO l_pmdn_d.pmdn008_02_01
           FROM imaf_t
          WHERE imafent  = g_enterprise
            AND imafsite = g_site
            AND imaf001  = l_pmdn_d.pmdb004_02_01
         IF (NOT cl_null(l_pmdn_d.pmdn008_02_01)) AND
            (NOT cl_null(l_pmdn_d.pmdn001_02_01)) AND
            (NOT cl_null(l_pmdn_d.pmdn006_02_01)) THEN
            CALL apmp490_02_convert_qty(l_pmdn_d.pmdn001_02_01,l_pmdn_d.pmdn006_02_01,
                                        l_pmdn_d.pmdn008_02_01,l_pmdn_d.pmdn007_02_01)
                 RETURNING l_pmdn_d.pmdn009_02_01
            IF NOT cl_null(l_pmdn_d.pmdn009_02_01) THEN
               CALL apmp490_02_unit_round(l_pmdn_d.pmdn008_02_01,l_pmdn_d.pmdn009_02_01)
                    RETURNING l_pmdn_d.pmdn009_02_01
            END IF
         END IF
      END IF

      #如果aoos020中，設定使用採購計價單位 
      IF cl_get_para(g_enterprise,g_site,'S-BAS-0019') = "Y" THEN
         #取料件的預設採購計價單位 
         SELECT imaf144 INTO l_pmdn_d.pmdn010_02_01
           FROM imaf_t
          WHERE imafent = g_enterprise
            AND imafsite = g_site
            AND imaf001 = l_pmdn_d.pmdb004_02_01 

         IF cl_null(l_pmdn_d.pmdn010_02_01) THEN
            LET l_pmdn_d.pmdn010_02_01 = l_pmdn_d.pmdn006_02_01
         END IF

         CALL apmp490_02_convert_qty(l_pmdn_d.pmdb004_02_01,l_pmdn_d.pmdn006_02_01,
                                     l_pmdn_d.pmdn010_02_01,l_pmdn_d.pmdn007_02_01)
              RETURNING l_pmdn_d.pmdn011_02_01
      ELSE
         #[C:計價單位] = 採購料號主檔的預設採購計價單位，若不使用採購計價單位時則此欄位=採購單位
         #[C:計價數量] = 採購數量*(採購單位與計價單位換算率)，若不使用採購計價單位時則此欄位=採購數量
         LET l_pmdn_d.pmdn010_02_01 = l_pmdn_d.pmdn006_02_01
         LET l_pmdn_d.pmdn011_02_01 = l_pmdn_d.pmdn007_02_01
      END IF

      CALL apmp490_02_get_imaal(l_pmdn_d.pmdb004_02_01)
           RETURNING l_pmdn_d.imaal003_02_01_1,l_pmdn_d.imaal004_02_01_1

      CALL apmp490_02_get_imaal(l_pmdn_d.pmdn001_02_01)
           RETURNING l_pmdn_d.imaal003_02_01_2,l_pmdn_d.imaal004_02_01_2 
           
      #取得請購單位說明 
      CALL s_desc_get_unit_desc(l_pmdn_d.pmdb007_02_01)
           RETURNING l_pmdn_d.pmdb007_02_01_desc

      #取得採購單位說明 
      CALL s_desc_get_unit_desc(l_pmdn_d.pmdn006_02_01)
           RETURNING l_pmdn_d.pmdn006_02_01_desc

      #取得參考單位說明 
      CALL s_desc_get_unit_desc(l_pmdn_d.pmdn008_02_01)
           RETURNING l_pmdn_d.pmdn008_02_01_desc

      #取得計價單位說明 
      CALL s_desc_get_unit_desc(l_pmdn_d.pmdn010_02_01)
           RETURNING l_pmdn_d.pmdn010_02_01_desc 
           
      #取得專案編號說明 
      CALL s_desc_get_project_desc(l_pmdn_d.pmdn036_02_01)
           RETURNING l_pmdn_d.pmdn036_02_01_desc

      #取得WBS編號說明 
      CALL s_desc_get_wbs_desc(l_pmdn_d.pmdn036_02_01,l_pmdn_d.pmdn037_02_01)
           RETURNING l_pmdn_d.pmdn037_02_01_desc

      #取得活動編號說明 
      CALL s_desc_get_activity_desc(l_pmdn_d.pmdn036_02_01,l_pmdn_d.pmdn038_02_01)
           RETURNING l_pmdn_d.pmdn038_02_01_desc
           
      #160801-00004#3--s
      CALL s_desc_get_stock_desc(l_pmdn_d.pmdbsite_02_01,l_pmdn_d.pmdn028_02_01)
           RETURNING l_pmdn_d.pmdn028_02_01_desc
           
      CALL s_desc_get_locator_desc(l_pmdn_d.pmdbsite_02_01,l_pmdn_d.pmdn028_02_01,l_pmdn_d.pmdn029_02_01)
           RETURNING l_pmdn_d.pmdn029_02_01_desc
           
      #160801-00004#3--e              
                              
      #送貨地址 
      #161214-00058#1 add  --begin--
      IF cl_null(l_pmdn_d.pmdl025_02_01) THEN
         CALL apmp490_02_get_pmdl025_pmdl026('3') RETURNING l_pmdn_d.pmdl025_02_01
      END IF
      #161214-00058#1 add  --end--
      
      IF NOT cl_null(l_pmdn_d.pmdl025_02_01) THEN
         CALL s_apmp490_get_address('3',l_pmdn_d.pmdl025_02_01)
              RETURNING l_pmdn_d.pmdl025_02_01_desc,l_pmdn_d.pmdl025_02_01_oofb017
      END IF

      #帳款地址
      #161214-00058#1 add  --begin--      
      IF cl_null(l_pmdn_d.pmdl026_02_01) THEN
         CALL apmp490_02_get_pmdl025_pmdl026('5') RETURNING l_pmdn_d.pmdl026_02_01
      END IF
      #161214-00058#1 add  --end--
      IF NOT cl_null(l_pmdn_d.pmdl026_02_01) THEN
         CALL s_apmp490_get_address('5',l_pmdn_d.pmdl026_02_01)
              RETURNING l_pmdn_d.pmdl026_02_01_desc,l_pmdn_d.pmdl026_02_01_oofb017
      END IF

      SELECT pmaal004 INTO l_pmdn_d.pmaal004_02_01
        FROM pmaal_t
       WHERE pmaalent = g_enterprise
         AND pmaal001 = l_pmdn_d.pmdl004_02_01
         AND pmaal002 = g_dlang 

      CASE g_apmp490_02_input.scb01
         WHEN '1'     #依料件主檔設定  
            LET l_imaf152 = ''
            SELECT imaf152 INTO l_imaf152
              FROM imaf_t
             WHERE imafent = l_pmdn_d.pmdbent_02_01
               AND imafsite = l_pmdn_d.pmdbsite_02_01
               AND imaf001 = l_pmdn_d.pmdb004_02_01

            #因為imaf152有可能為空 所以如果無資料的話就預設為0.主要供應商，無限量 
            IF cl_null(l_imaf152) THEN
               LET l_imaf152 = '0'
            END IF

            CASE l_imaf152
               WHEN '0'    #主要供應商，無限量  
                  CALL apmp490_02_allot_0(l_pmdn_d.*) 
                  
               WHEN '1'    #依廠商分配  
                  #如果有指定供應商的話就無條件走主要供應商無限量的分配方式 
                  IF l_pmdn_d.pmdb014_02_01 != '3' THEN
                     #依廠商分配(apmi070) 
                     CALL apmp490_02_allot_1(l_pmdn_d.*)
                  ELSE
                     #主要供應商，無限量 
                     CALL apmp490_02_allot_0(l_pmdn_d.*)
                  END IF
                  
               WHEN '2'    #主要供應商分配優先，餘量分配  
                  IF l_pmdn_d.pmdb014_02_01 != '3' THEN
                     #主要供應商分配優先，餘量分配 
                     CALL apmp490_02_allot_2(l_pmdn_d.*)
                  ELSE
                     #主要供應商，無限量 
                     CALL apmp490_02_allot_0(l_pmdn_d.*)
                  END IF
                  
               WHEN '3'    #指定單一供應商  
                  IF l_pmdn_d.pmdb014_02_01 != '3' THEN
                     #指定單一供應商 
                     CALL apmp490_02_allot_3(l_pmdn_d.*)
                  ELSE
                     #主要供應商，無限量 
                     CALL apmp490_02_allot_0(l_pmdn_d.*)
                  END IF

            END CASE
            
         WHEN '2'     #主要供應商，無限量  
            CALL apmp490_02_allot_0(l_pmdn_d.*) 
            
         WHEN '3'     #依廠商分配  
            IF l_pmdn_d.pmdb014_02_01 != '3' THEN
               #依廠商分配 
               CALL apmp490_02_allot_1(l_pmdn_d.*)
            ELSE
               #主要供應商，無限量 
               CALL apmp490_02_allot_0(l_pmdn_d.*)
            END IF
            
         WHEN '4'     #主要供應商分配優先，餘量分配  
            IF l_pmdn_d.pmdb014_02_01 != '3' THEN
               #主要供應商分配優先，餘量分配 
               CALL apmp490_02_allot_2(l_pmdn_d.*)
            ELSE
               #主要供應商，無限量 
               CALL apmp490_02_allot_0(l_pmdn_d.*)
            END IF
            
         WHEN '5'     #指定單一供應商  
            IF l_pmdn_d.pmdb014_02_01 != '3' THEN
               #指定單一供應商 
               CALL apmp490_02_allot_3(l_pmdn_d.*)
            ELSE
               #主要供應商，無限量 
               CALL apmp490_02_allot_0(l_pmdn_d.*)
            END IF
            
         #151022-00003#3 20151201 add by ming -----(S) 
         WHEN '6'     #預設取價條件之最低價供應商 
            IF l_pmdn_d.pmdb014_02_01 != '3' THEN 
               CALL apmp490_02_allot_4(l_pmdn_d.*)
            ELSE 
               #主要供應商，無限量 
               CALL apmp490_02_allot_0(l_pmdn_d.*)
            END IF 
         #151022-00003#3 20151201 add by ming -----(E) 
      END CASE

   END FOREACH 
   
   CALL cl_err_collect_show() 

   SELECT ADD_MONTHS(g_today,-g_mm) INTO g_date FROM DUAL

   LET l_wc = "pmdldocdt BETWEEN '",g_date,"' AND '",g_today,"' "
   CALL apmp490_02_b_fill_02(l_wc)
   LET l_wc = "pmdsdocdt BETWEEN '",g_date,"' AND '",g_today,"' "
   CALL apmp490_02_b_fill_03(l_wc)
   LET l_wc = "qcbadocdt BETWEEN '",g_date,"' AND '",g_today,"' "
   CALL apmp490_02_b_fill_04(l_wc)
END FUNCTION

################################################################################
# Descriptions...: 最近採購資料填充
# Memo...........:
# Usage..........: apmp490_02_b_fill_02(p_wc)
# Input parameter: p_wc
# Date & Author..: 2014/06/18 By ming
# Modify.........:
################################################################################
PUBLIC FUNCTION apmp490_02_b_fill_02(p_wc)
   DEFINE p_wc     STRING
   DEFINE l_sql    STRING
   DEFINE l_ac1    LIKE type_t.num5

   WHENEVER ERROR CONTINUE 

   IF g_d_idx_p49002_01 = 0 THEN
      LET g_d_idx_p49002_01 = 1
   END IF

   CALL g_apmp490_02_pmdn_d.clear()

   LET l_sql = "SELECT pmdl004,'',pmdldocno,pmdldocdt,pmdl009, ",
               "       pmdl010,pmdl011,pmdl012,pmdl013,pmdl015, ",
               "       pmdl016,pmdn007,pmdn015,pmdn040 ",
               "  FROM pmdl_t,pmdn_t ",
               " WHERE pmdlent   = pmdnent ",
               "   AND pmdlsite  = pmdnsite ",
               "   AND pmdldocno = pmdndocno ",
               "   AND pmdlent   = '",g_enterprise,"' ",
               "   AND pmdlsite  = '",g_site,"' ",
               "   AND pmdlstus <> 'X' ",   #150305-00010#1
               "   AND pmdn001   = '",g_pmdn_d[g_d_idx_p49002_01].pmdb004_02_01,"' ",
               "   AND ",p_wc

   PREPARE apmp490_02_b_fill_prep01 FROM l_sql
   DECLARE apmp490_02_b_fill_curs01 CURSOR FOR apmp490_02_b_fill_prep01 

   LET l_ac1 = 1
   FOREACH apmp490_02_b_fill_curs01 INTO g_apmp490_02_pmdn_d[l_ac1].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      #取得供應商名稱 
      CALL apmp490_02_get_pmaal004(g_apmp490_02_pmdn_d[l_ac1].pmdl004_02_02)
           RETURNING g_apmp490_02_pmdn_d[l_ac1].pmaal004_02_02

      LET l_ac1 = l_ac1 + 1

      IF l_ac1 > g_max_rec THEN
         EXIT FOREACH
      END IF

   END FOREACH

   CALL g_apmp490_02_pmdn_d.deleteElement(l_ac1)
   LET l_ac1 = l_ac1 - 1
END FUNCTION

################################################################################
# Descriptions...: 最近收貨資料填充
# Memo...........:
# Usage..........: CALL apmp490_02_b_fill_03(p_wc)
# Input parameter: p_wc
# Date & Author..: 2014/06/18 By ming
# Modify.........:
################################################################################
PUBLIC FUNCTION apmp490_02_b_fill_03(p_wc)
   DEFINE p_wc     STRING
   DEFINE l_sql    STRING
   DEFINE l_ac1    LIKE type_t.num5

   WHENEVER ERROR CONTINUE 

   IF g_d_idx_p49002_01 = 0 THEN
      LET g_d_idx_p49002_01 = 1
   END IF

   CALL g_apmp490_02_pmds_d.clear()

   LET l_sql = "SELECT pmds009,'',pmdsdocno,pmdo013,pmdsdocdt,'','' ",
               "  FROM pmds_t,pmdt_t,pmdo_t ",
               " WHERE pmdsent   = pmdtent ",
               "   AND pmdssite  = pmdtsite ",
               "   AND pmdsdocno = pmdtdocno ",
               "   AND pmdoent   = pmdtent ",
               "   AND pmdosite  = pmdtsite ",
               "   AND pmdodocno = pmdt001 ",       #採購單號  
               "   AND pmdoseq   = pmdt002 ",       #採購項次  
               "   AND pmdoseq1  = pmdt003 ",       #採購項序 
               "   AND pmdoseq2  = pmdt004 ",       #分批序  
               "   AND pmdsent   = '",g_enterprise,"' ",
               "   AND pmdssite  = '",g_site,"' ",               
               "   AND pmdsstus <> 'X' ",   #150305-00010#1
               "   AND pmdt006   = '",g_pmdn_d[g_d_idx_p49002_01].pmdb004_02_01,"' ",
               "   AND ",p_wc

   PREPARE apmp490_02_b_fill_prep02 FROM l_sql
   DECLARE apmp490_02_b_fill_curs02 CURSOR FOR apmp490_02_b_fill_prep02

   LET l_ac1 = 1 
   FOREACH apmp490_02_b_fill_curs02 INTO g_apmp490_02_pmds_d[l_ac1].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      #取得供應商名稱 
      CALL apmp490_02_get_pmaal004(g_apmp490_02_pmds_d[l_ac1].pmds009_02_03)
           RETURNING g_apmp490_02_pmds_d[l_ac1].pmaal004_02_03 
           
      LET g_apmp490_02_pmds_d[l_ac1].diff_day_02_03 = g_apmp490_02_pmds_d[l_ac1].pmdsdocdt_02_03 -
                                                      g_apmp490_02_pmds_d[l_ac1].pmdo013_02_03

      CASE
         #採購交貨日期 > 收貨日期 
         WHEN g_apmp490_02_pmds_d[l_ac1].pmdo013_02_03 > g_apmp490_02_pmds_d[l_ac1].pmdsdocdt_02_03
            LET g_apmp490_02_pmds_d[l_ac1].stus_02_03 = cl_getmsg("apm-00696",g_lang)     #提前交貨 

         #採購交貨日期 = 收貨日期 
         WHEN g_apmp490_02_pmds_d[l_ac1].pmdo013_02_03 = g_apmp490_02_pmds_d[l_ac1].pmdsdocdt_02_03
            LET g_apmp490_02_pmds_d[l_ac1].stus_02_03 = cl_getmsg("apm-00697",g_lang)     #正常交貨 

         #採購交貨日期 < 收貨日期 
         WHEN g_apmp490_02_pmds_d[l_ac1].pmdo013_02_03 < g_apmp490_02_pmds_d[l_ac1].pmdsdocdt_02_03
            LET g_apmp490_02_pmds_d[l_ac1].stus_02_03 = cl_getmsg("apm-00698",g_lang)     #延誤交貨 

         OTHERWISE
            EXIT CASE
      END CASE

      LET l_ac1 = l_ac1 + 1

      IF l_ac1 > g_max_rec THEN
         EXIT FOREACH
      END IF

   END FOREACH

   CALL g_apmp490_02_pmds_d.deleteElement(l_ac1)
   LET l_ac1 = l_ac1 - 1
END FUNCTION

################################################################################
# Descriptions...: 最近檢驗資料填充
# Memo...........:
# Usage..........: CALL apmp490_02_b_fill_04(p_wc)
# Input parameter: p_wc
# Date & Author..: 2014/06/18 By ming
# Modify.........:
################################################################################
PUBLIC FUNCTION apmp490_02_b_fill_04(p_wc)
   DEFINE p_wc     STRING
   DEFINE l_sql    STRING
   DEFINE l_ac1    LIKE type_t.num5

   WHENEVER ERROR CONTINUE 

   IF g_d_idx_p49002_01 = 0 THEN
      LET g_d_idx_p49002_01 = 1
   END IF

   CALL g_apmp490_02_qcba_d.clear()

   LET l_sql = "SELECT qcba005,'',qcbadocno,qcba014,'',qcba018,qcba019, ",
               "       qcba017,qcba022,qcba023 ",
               "  FROM qcba_t ",
               " WHERE qcbaent  = '",g_enterprise,"' ",
               "   AND qcbasite = '",g_site,"' ",               
               "   AND qcbastus <> 'X' ",   #150305-00010#1
               "   AND qcba010  = '",g_pmdn_d[g_d_idx_p49002_01].pmdb004_02_01,"' ",
               "   AND ",p_wc

   PREPARE apmp490_02_b_fill_prep03 FROM l_sql
   DECLARE apmp490_02_b_fill_curs03 CURSOR FOR apmp490_02_b_fill_prep03

   LET l_ac1 = 1
   FOREACH apmp490_02_b_fill_curs03 INTO g_apmp490_02_qcba_d[l_ac1].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      #取得供應商名稱 
      CALL apmp490_02_get_pmaal004(g_apmp490_02_qcba_d[l_ac1].qcba005_02_04)
           RETURNING g_apmp490_02_qcba_d[l_ac1].pmaal004_02_04 
           
      #取得檢驗水準 
      SELECT imae116 INTO g_apmp490_02_qcba_d[l_ac1].imae116_02_04
        FROM imaa_t LEFT OUTER JOIN imae_t ON imaeent  = imaaent
                                          AND imaesite = g_site
                                          AND imae001  = imaa001
       WHERE imaaent = g_enterprise
         AND imaa001 = g_pmdn_d[g_d_idx_p49002_01].pmdb004_02_01

      LET l_ac1 = l_ac1 + 1

      IF l_ac1 > g_max_rec THEN
         EXIT FOREACH
      END IF

   END FOREACH

   CALL g_apmp490_02_qcba_d.deleteElement(l_ac1)
   LET l_ac1 = l_ac1 - 1
END FUNCTION

################################################################################
# Descriptions...: 主要供應商，無限量
# Memo...........:
# Usage..........: CALL apmp490_02_allot_0(p_pmdn_d)
# Input parameter: p_pmdn_d:整個pmdn_file 
# Date & Author..: 2014/06/18 By ming
# Modify.........:
################################################################################
PUBLIC FUNCTION apmp490_02_allot_0(p_pmdn_d)
   DEFINE p_pmdn_d         type_g_pmdn_d
   DEFINE l_ac1            LIKE type_t.num5 
   DEFINE l_success        LIKE type_t.num5

   WHENEVER ERROR CONTINUE 

   LET l_ac1 = g_pmdn_d.getLength() + 1

   LET g_pmdn_d[l_ac1].* = p_pmdn_d.*

   IF g_pmdn_d[l_ac1].pmdb014_02_01 != '3' THEN
      SELECT imaf153 INTO g_pmdn_d[l_ac1].pmdl004_02_01
        FROM imaf_t
       WHERE imafent = p_pmdn_d.pmdbent_02_01
         AND imafsite = p_pmdn_d.pmdbsite_02_01
         AND imaf001 = p_pmdn_d.pmdb004_02_01

      #取得供應商簡稱 
      CALL apmp490_02_get_pmaal004(g_pmdn_d[l_ac1].pmdl004_02_01)
           RETURNING g_pmdn_d[l_ac1].pmaal004_02_01
   END IF
   
   CALL apmp490_02_ins_pmdb(l_ac1,g_pmdn_d[l_ac1].pmdb004_02_01,
                            g_pmdn_d[l_ac1].pmdb005_02_01,
                            g_pmdn_d[l_ac1].pmdl025_02_01,
                            g_pmdn_d[l_ac1].pmdl026_02_01,
                            g_pmdn_d[l_ac1].pmdn058_02_01,
                            g_pmdn_d[l_ac1].pmdn036_02_01,
                            g_pmdn_d[l_ac1].pmdn037_02_01,
                            g_pmdn_d[l_ac1].pmdn038_02_01,
                            #160801-00004#3--s
                            g_pmdn_d[l_ac1].pmdn028_02_01,
                            g_pmdn_d[l_ac1].pmdn029_02_01,
                            g_pmdn_d[l_ac1].pmdn053_02_01,
                            #160801-00004#3--e              
                            g_pmdn_d[l_ac1].pmdn050_02_01,
                            g_pmdn_d[l_ac1].ooff013_02_01,   #161031-00025#6
                            g_pmdn_d[l_ac1].ooff014_02_01,   #161031-00025#6
                            g_pmdn_d[l_ac1].pmdbdocno_02_01,
                            g_pmdn_d[l_ac1].pmdbseq_02_01,
                            g_pmdn_d[l_ac1].qty_02_01)
        RETURNING l_success

   IF l_success THEN
      INSERT INTO p490_02_pmdn_t(pmdb014,pmdl004,pmdl025,pmdl026,pmdn058,
                                 pmdn036,pmdn037,pmdn038,
                                 pmdb004,pmdb005,pmdb007,qty,
                                 pmdn014,pmdn001,pmdn002,pmdn006,pmdn007,
                                 pmdn008,pmdn009,pmdn010,
                                 pmdn011,
                                 pmdn028,pmdn029,pmdn053,  #160801-00004#3
                                 #161031-00025#6-s-mod
#                                 pmdn050,pmdbent,pmdbsite,pmdbdocno,pmdbseq,link_no)
                                 pmdn050,ooff013,ooff014,pmdbent,pmdbsite,pmdbdocno,pmdbseq,link_no)
                                 #161031-00025#6-e-mod
                          VALUES(g_pmdn_d[l_ac1].pmdb014_02_01,g_pmdn_d[l_ac1].pmdl004_02_01,
                                 g_pmdn_d[l_ac1].pmdl025_02_01,g_pmdn_d[l_ac1].pmdl026_02_01,
                                 g_pmdn_d[l_ac1].pmdn058_02_01,
                                 g_pmdn_d[l_ac1].pmdn036_02_01,g_pmdn_d[l_ac1].pmdn037_02_01,
                                 g_pmdn_d[l_ac1].pmdn038_02_01,
                                 g_pmdn_d[l_ac1].pmdb004_02_01,
                                 g_pmdn_d[l_ac1].pmdb005_02_01,g_pmdn_d[l_ac1].pmdb007_02_01,
                                 g_pmdn_d[l_ac1].qty_02_01    ,g_pmdn_d[l_ac1].pmdn014_02_01,
                                 g_pmdn_d[l_ac1].pmdn001_02_01,g_pmdn_d[l_ac1].pmdn002_02_01, 
                                 g_pmdn_d[l_ac1].pmdn006_02_01,g_pmdn_d[l_ac1].pmdn007_02_01,
                                 g_pmdn_d[l_ac1].pmdn008_02_01,g_pmdn_d[l_ac1].pmdn009_02_01,
                                 g_pmdn_d[l_ac1].pmdn010_02_01,g_pmdn_d[l_ac1].pmdn011_02_01,
                                 #160801-00004#3--s
                                 g_pmdn_d[l_ac1].pmdn028_02_01,
                                 g_pmdn_d[l_ac1].pmdn029_02_01,
                                 g_pmdn_d[l_ac1].pmdn053_02_01,
                                 #160801-00004#3--e   
                                 g_pmdn_d[l_ac1].pmdn050_02_01,
                                 g_pmdn_d[l_ac1].ooff013_02_01,   #161031-00025#6
                                 g_pmdn_d[l_ac1].ooff014_02_01,   #161031-00025#6
                                 g_pmdn_d[l_ac1].pmdbent_02_01,g_pmdn_d[l_ac1].pmdbsite_02_01,
                                 g_pmdn_d[l_ac1].pmdbdocno_02_01,g_pmdn_d[l_ac1].pmdbseq_02_01,
                                 l_ac1)
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 依廠商分配
# Memo...........:
# Usage..........: CALL apmp490_02_allot_1(p_pmdn_d)
# Input parameter: p_pmdn_d:整個pmdn_file 
# Date & Author..: 2014/06/18 By ming
# Modify.........:
################################################################################
PUBLIC FUNCTION apmp490_02_allot_1(p_pmdn_d)
   DEFINE p_pmdn_d         type_g_pmdn_d
   DEFINE l_ac1            LIKE type_t.num5
   DEFINE l_pmao008_sum    LIKE pmao_t.pmao008
   DEFINE l_pmao008        LIKE pmao_t.pmao008
   DEFINE l_sql            STRING
   DEFINE l_pmao001        LIKE pmao_t.pmao001 
   DEFINE l_success        LIKE type_t.num5
   DEFINE l_rate           LIKE inaj_t.inaj014

   WHENEVER ERROR CONTINUE 

   #pmao008:分配比率 
   #先算出此料的總比率 
   LET l_pmao008_sum = 0
   #160819-00043#6--s
   #SELECT SUM(pmao008) INTO l_pmao008_sum
   #  FROM pmao_t
   # WHERE pmaoent = p_pmdn_d.pmdbent_02_01
   #   AND pmao002 = p_pmdn_d.pmdb004_02_01                    #料件編號  
   #   AND NVL(pmao003,' ') = NVL(p_pmdn_d.pmdb005_02_01,' ')  #產品特徵 
   
   SELECT SUM(pmat004) INTO l_pmao008_sum
     FROM pmat_t
    WHERE pmatent = p_pmdn_d.pmdbent_02_01
      AND pmatsite = p_pmdn_d.pmdbsite_02_01
      AND pmat002 = p_pmdn_d.pmdb004_02_01                    #料件編號  
      AND NVL(pmat003,' ') = NVL(p_pmdn_d.pmdb005_02_01,' ')  #產品特徵 
      AND pmatstus = 'Y'
   #160819-00043#6---e
   
   IF cl_null(l_pmao008_sum) THEN
      LET l_pmao008_sum = 0
   END IF

   IF l_pmao008_sum = 0 THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ''
      LET g_errparam.code   = 'apm-00969'     #料件編號%1之分配比率總合不可為0！ 
      LET g_errparam.popup  = TRUE
      LET g_errparam.replace[1] = p_pmdn_d.pmdb004_02_01
      CALL cl_err()
      RETURN 
   END IF 

   #再看供應商可分配多少比率 
   #160819-00043#6--s
   #LET l_sql = "SELECT pmao001,pmao008 ",
   #            "  FROM pmao_t ",
   #            " WHERE pmaoent = '",p_pmdn_d.pmdbent_02_01,"' ",
   #            "   AND pmao002 = '",p_pmdn_d.pmdb004_02_01,"' ",
   #            "   AND NVL(pmao003,' ') = NVL('",p_pmdn_d.pmdb005_02_01,"',' ') " 
   LET l_sql = "SELECT pmat001,pmat004 ",
               "  FROM pmat_t ",
               " WHERE pmatent = '",p_pmdn_d.pmdbent_02_01,"' ",
               "   AND pmatsite = '",p_pmdn_d.pmdbsite_02_01,"' ",
               "   AND pmat002 = '",p_pmdn_d.pmdb004_02_01,"' ",
               "   AND NVL(pmat003,' ') = NVL('",p_pmdn_d.pmdb005_02_01,"',' ') " ,
               "   AND pmatstus = 'Y' "
   
   #160819-00043#6--e
   PREPARE apmp490_02_pmao_prep_1 FROM l_sql
   DECLARE apmp490_02_pmao_curs_1 CURSOR FOR apmp490_02_pmao_prep_1

   LET l_ac1 = g_pmdn_d.getLength() + 1

   FOREACH apmp490_02_pmao_curs_1 INTO l_pmao001,l_pmao008
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      LET g_pmdn_d[l_ac1].* = p_pmdn_d.*
      
      LET g_pmdn_d[l_ac1].pmdl004_02_01 = l_pmao001 
      #取得供應商簡稱 
      CALL apmp490_02_get_pmaal004(g_pmdn_d[l_ac1].pmdl004_02_01)
           RETURNING g_pmdn_d[l_ac1].pmaal004_02_01
      LET g_pmdn_d[l_ac1].pmdn007_02_01 = p_pmdn_d.pmdn007_02_01 * l_pmao008 / l_pmao008_sum 
      #161107-00031#1-add-s
      CALL s_aooi250_take_decimals(g_pmdn_d[l_ac1].pmdn006_02_01,g_pmdn_d[l_ac1].pmdn007_02_01)
           RETURNING l_success,g_pmdn_d[l_ac1].pmdn007_02_01
      #161107-00031#1-add-e
      
      #參考單位與數量 
      IF cl_get_para(g_enterprise,g_site,'S-BAS-0028') = 'Y' THEN
         SELECT imaf015 INTO g_pmdn_d[l_ac1].pmdn008_02_01
           FROM imaf_t
          WHERE imafent  = g_enterprise
            AND imafsite = g_site
            AND imaf001  = g_pmdn_d[l_ac1].pmdb004_02_01
         IF (NOT cl_null(g_pmdn_d[l_ac1].pmdn008_02_01)) AND
            (NOT cl_null(g_pmdn_d[l_ac1].pmdn001_02_01)) AND
            (NOT cl_null(g_pmdn_d[l_ac1].pmdn006_02_01)) THEN
            CALL apmp490_02_convert_qty(g_pmdn_d[l_ac1].pmdn001_02_01,g_pmdn_d[l_ac1].pmdn006_02_01,
                                        g_pmdn_d[l_ac1].pmdn008_02_01,g_pmdn_d[l_ac1].pmdn007_02_01)
                 RETURNING g_pmdn_d[l_ac1].pmdn009_02_01
            IF NOT cl_null(g_pmdn_d[l_ac1].pmdn009_02_01) THEN
               CALL apmp490_02_unit_round(g_pmdn_d[l_ac1].pmdn008_02_01,g_pmdn_d[l_ac1].pmdn009_02_01)
                    RETURNING g_pmdn_d[l_ac1].pmdn009_02_01
            END IF
         END IF
      END IF
      
      IF cl_get_para(g_enterprise,g_site,'S-BAS-0019') = 'Y' THEN
         #取料件的預設採購計價單位 
         SELECT imaf144 INTO g_pmdn_d[l_ac1].pmdn010_02_01
           FROM imaf_t
          WHERE imafent  = g_enterprise
            AND imafsite = g_site
            AND imaf001  = g_pmdn_d[l_ac1].pmdb004_02_01

         IF cl_null(g_pmdn_d[l_ac1].pmdn010_02_01) THEN
            LET g_pmdn_d[l_ac1].pmdn010_02_01 = g_pmdn_d[l_ac1].pmdn006_02_01
         END IF

         CALL apmp490_02_convert_qty(g_pmdn_d[l_ac1].pmdb004_02_01,g_pmdn_d[l_ac1].pmdn006_02_01,
                                     g_pmdn_d[l_ac1].pmdn010_02_01,g_pmdn_d[l_ac1].pmdn007_02_01)
              RETURNING g_pmdn_d[l_ac1].pmdn011_02_01
      ELSE
         #[C:計價單位] = 採購料號主檔的預設採購計價單位，若不使用採購計價單位時則此欄位=採購單位
         #[C:計價數量] = 採購數量*(採購單位與計價單位換算率)，若不使用採購計價單位時則此欄位=採購數量
         LET g_pmdn_d[l_ac1].pmdn010_02_01 = g_pmdn_d[l_ac1].pmdn006_02_01
         LET g_pmdn_d[l_ac1].pmdn011_02_01 = g_pmdn_d[l_ac1].pmdn007_02_01
      END IF

      CALL apmp490_02_ins_pmdb(l_ac1,g_pmdn_d[l_ac1].pmdb004_02_01,
                               g_pmdn_d[l_ac1].pmdb005_02_01,
                               g_pmdn_d[l_ac1].pmdl025_02_01,
                               g_pmdn_d[l_ac1].pmdl026_02_01,
                               g_pmdn_d[l_ac1].pmdn058_02_01,
                               g_pmdn_d[l_ac1].pmdn036_02_01,
                               g_pmdn_d[l_ac1].pmdn037_02_01,
                               g_pmdn_d[l_ac1].pmdn038_02_01,
                               #160801-00004#3--s
                               g_pmdn_d[l_ac1].pmdn028_02_01,
                               g_pmdn_d[l_ac1].pmdn029_02_01,
                               g_pmdn_d[l_ac1].pmdn053_02_01,
                               #160801-00004#3--e  
                               g_pmdn_d[l_ac1].pmdn050_02_01,
                               g_pmdn_d[l_ac1].ooff013_02_01,   #161031-00025#6
                               g_pmdn_d[l_ac1].ooff014_02_01,   #161031-00025#6
                               g_pmdn_d[l_ac1].pmdbdocno_02_01,
                               g_pmdn_d[l_ac1].pmdbseq_02_01,
                               g_pmdn_d[l_ac1].pmdn007_02_01)
           RETURNING l_success
      
      IF l_success THEN
         INSERT INTO p490_02_pmdn_t(pmdb014,pmdl004,pmdl025,pmdl026,pmdn058,
                                    pmdn036,pmdn037,pmdn038,
                                    pmdb004,pmdb005,pmdb007,qty,
                                    pmdn014,pmdn001,pmdn002,pmdn006,pmdn007,
                                    pmdn008,pmdn009,pmdn010,
                                    pmdn011,
                                    pmdn028,pmdn029,pmdn053,  #160801-00004#3
                                    #161031-00025#6-s-mod
#                                    pmdn050,pmdbent,pmdbsite,pmdbdocno,pmdbseq,link_no)
                                    pmdn050,ooff013,ooff014,pmdbent,pmdbsite,pmdbdocno,pmdbseq,link_no)
                                    #161031-00025#6-e-mod
                             VALUES(g_pmdn_d[l_ac1].pmdn014_02_01,g_pmdn_d[l_ac1].pmdl004_02_01,
                                    g_pmdn_d[l_ac1].pmdl025_02_01,g_pmdn_d[l_ac1].pmdl026_02_01,
                                    g_pmdn_d[l_ac1].pmdn058_02_01,
                                    g_pmdn_d[l_ac1].pmdn036_02_01,g_pmdn_d[l_ac1].pmdn037_02_01,
                                    g_pmdn_d[l_ac1].pmdn038_02_01,
                                    g_pmdn_d[l_ac1].pmdb004_02_01,
                                    g_pmdn_d[l_ac1].pmdb005_02_01,g_pmdn_d[l_ac1].pmdb007_02_01,
                                    g_pmdn_d[l_ac1].qty_02_01    ,g_pmdn_d[l_ac1].pmdn014_02_01,
                                    g_pmdn_d[l_ac1].pmdn001_02_01,g_pmdn_d[l_ac1].pmdn002_02_01, 
                                    g_pmdn_d[l_ac1].pmdn006_02_01,g_pmdn_d[l_ac1].pmdn007_02_01,
                                    g_pmdn_d[l_ac1].pmdn008_02_01,g_pmdn_d[l_ac1].pmdn009_02_01,
                                    g_pmdn_d[l_ac1].pmdn010_02_01,g_pmdn_d[l_ac1].pmdn011_02_01,
                                    #160801-00004#3--s
                                    g_pmdn_d[l_ac1].pmdn028_02_01,
                                    g_pmdn_d[l_ac1].pmdn029_02_01,
                                    g_pmdn_d[l_ac1].pmdn053_02_01,
                                    #160801-00004#3--e  
                                    g_pmdn_d[l_ac1].pmdn050_02_01,
                                    g_pmdn_d[l_ac1].ooff013_02_01,   #161031-00025#6
                                    g_pmdn_d[l_ac1].ooff014_02_01,   #161031-00025#6
                                    g_pmdn_d[l_ac1].pmdbent_02_01,g_pmdn_d[l_ac1].pmdbsite_02_01,
                                    g_pmdn_d[l_ac1].pmdbdocno_02_01,g_pmdn_d[l_ac1].pmdbseq_02_01,
                                    l_ac1)
         LET l_ac1 = l_ac1 + 1 
      END IF      

   END FOREACH

END FUNCTION

################################################################################
# Descriptions...: 主要供應商分配優先，餘量分配
# Memo...........:
# Usage..........: CALLapmp490_02_allot_2(p_pmdn_d)
# Input parameter: p_pmdn_d:整個pmdn_file 
# Date & Author..: 2014/06/18 By ming
# Modify.........:
################################################################################
PUBLIC FUNCTION apmp490_02_allot_2(p_pmdn_d)
   DEFINE p_pmdn_d         type_g_pmdn_d
   DEFINE l_ac1            LIKE type_t.num5
   DEFINE l_max_qty        LIKE imaf_t.imaf154
   DEFINE l_imaf153        LIKE imaf_t.imaf153
   DEFINE l_imaf154        LIKE imaf_t.imaf154
   DEFINE l_pmao008_sum    LIKE pmao_t.pmao008
   DEFINE l_pmao008        LIKE pmao_t.pmao008
   DEFINE l_pmao001        LIKE pmao_t.pmao001
   DEFINE l_sql            STRING 
   DEFINE l_rate           LIKE inaj_t.inaj014
   DEFINE l_success        LIKE type_t.num5

   WHENEVER ERROR CONTINUE 

   #l_max_qty:主要供應商可分配數量的最大限度 
   #imaf153  :主要供應商 
   #imaf154  :主供應商分配限量 
   LET l_max_qty = 0
   SELECT imaf153,imaf154 INTO l_imaf153,l_imaf154
     FROM imaf_t
    WHERE imafent = p_pmdn_d.pmdbent_02_01
      AND imafsite = p_pmdn_d.pmdbsite_02_01
      AND imaf001 = p_pmdn_d.pmdb004_02_01
   
   #分配限量的值從何而來 如果不是依料件主檔而來的話 則從畫面上設定
   #IF g_apmp490_02_input.scb02 = '1' THEN    #依料件主檔設定    #160824-00032#1
   IF g_apmp490_02_input.scb01 = '1' THEN   #160824-00032#1 #依料件主档设定的选择栏位代号是scb01
      LET l_max_qty = l_imaf154
   ELSE
      LET l_max_qty = g_apmp490_02_input.ed01
   END IF

   LET l_ac1 = g_pmdn_d.getLength() + 1
   LET g_pmdn_d[l_ac1].* = p_pmdn_d.* 
   
   IF NOT cl_null(g_pmdn_d[l_ac1].pmdl004_02_01) THEN
      LET l_imaf153 = g_pmdn_d[l_ac1].pmdl004_02_01
   END IF 
   
   #第一筆資料的供應商應該是料件的主要供應商 
   LET g_pmdn_d[l_ac1].pmdl004_02_01 = l_imaf153
   #取得供應商簡稱 
   CALL apmp490_02_get_pmaal004(g_pmdn_d[l_ac1].pmdl004_02_01)
        RETURNING g_pmdn_d[l_ac1].pmaal004_02_01
   
   #如果採購數量是200 分配限量是120 則把採購數量修改為120 
   #否則則不改變 
   IF g_pmdn_d[l_ac1].pmdn007_02_01 > l_max_qty THEN
      LET g_pmdn_d[l_ac1].pmdn007_02_01 = l_max_qty
      LET p_pmdn_d.pmdn007_02_01 = p_pmdn_d.pmdn007_02_01 - l_max_qty
   END IF 
   
   #重新計算參考單位與數量 
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0028') = 'Y' THEN
      SELECT imaf015 INTO g_pmdn_d[l_ac1].pmdn008_02_01
        FROM imaf_t
       WHERE imafent  = g_enterprise
         AND imafsite = g_site
         AND imaf001 = g_pmdn_d[l_ac1].pmdb004_02_01
      IF (NOT cl_null(g_pmdn_d[l_ac1].pmdn008_02_01)) AND
         (NOT cl_null(g_pmdn_d[l_ac1].pmdn001_02_01)) AND
         (NOT cl_null(g_pmdn_d[l_ac1].pmdn006_02_01)) THEN
         CALL apmp490_02_convert_qty(g_pmdn_d[l_ac1].pmdn001_02_01,g_pmdn_d[l_ac1].pmdn006_02_01,
                                     g_pmdn_d[l_ac1].pmdn008_02_01,g_pmdn_d[l_ac1].pmdn007_02_01)
              RETURNING g_pmdn_d[l_ac1].pmdn009_02_01
         IF NOT cl_null(g_pmdn_d[l_ac1].pmdn009_02_01) THEN
            CALL apmp490_02_unit_round(g_pmdn_d[l_ac1].pmdn008_02_01,g_pmdn_d[l_ac1].pmdn009_02_01)
                 RETURNING g_pmdn_d[l_ac1].pmdn009_02_01
         END IF
      END IF
   END IF
   
   #需要重新計算計價數量 
   #如果aoos020中，設定使用採購計價單位 
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0019') = "Y" THEN
      #取料件的預設採購計價單位 
      SELECT imaf144 INTO g_pmdn_d[l_ac1].pmdn010_02_01
        FROM imaf_t
       WHERE imafent = g_enterprise
         AND imafsite = g_site
         AND imaf001 = g_pmdn_d[l_ac1].pmdb004_02_01

      IF cl_null(g_pmdn_d[l_ac1].pmdn010_02_01) THEN
         LET g_pmdn_d[l_ac1].pmdn010_02_01 = g_pmdn_d[l_ac1].pmdn006_02_01
      END IF

      CALL apmp490_02_convert_qty(g_pmdn_d[l_ac1].pmdb004_02_01,g_pmdn_d[l_ac1].pmdn006_02_01,
                                  g_pmdn_d[l_ac1].pmdn010_02_01,g_pmdn_d[l_ac1].pmdn007_02_01)
           RETURNING g_pmdn_d[l_ac1].pmdn011_02_01
   ELSE
      #[C:計價單位] = 採購料號主檔的預設採購計價單位，若不使用採購計價單位時則此欄位=採購單位
      #[C:計價數量] = 採購數量*(採購單位與計價單位換算率)，若不使用採購計價單位時則此欄位=採購數量
      LET g_pmdn_d[l_ac1].pmdn010_02_01 = g_pmdn_d[l_ac1].pmdn006_02_01
      LET g_pmdn_d[l_ac1].pmdn011_02_01 = g_pmdn_d[l_ac1].pmdn007_02_01
   END IF 
     
   CALL apmp490_02_ins_pmdb(l_ac1,g_pmdn_d[l_ac1].pmdb004_02_01,
                            g_pmdn_d[l_ac1].pmdb005_02_01,
                            g_pmdn_d[l_ac1].pmdl025_02_01,
                            g_pmdn_d[l_ac1].pmdl026_02_01,
                            g_pmdn_d[l_ac1].pmdn058_02_01,
                            g_pmdn_d[l_ac1].pmdn036_02_01,
                            g_pmdn_d[l_ac1].pmdn037_02_01,
                            g_pmdn_d[l_ac1].pmdn038_02_01,
                            #160801-00004#3--s
                            g_pmdn_d[l_ac1].pmdn028_02_01,
                            g_pmdn_d[l_ac1].pmdn029_02_01,
                            g_pmdn_d[l_ac1].pmdn053_02_01,
                            #160801-00004#3--e
                            g_pmdn_d[l_ac1].pmdn050_02_01,
                            g_pmdn_d[l_ac1].ooff013_02_01,   #161031-00025#6
                            g_pmdn_d[l_ac1].ooff014_02_01,   #161031-00025#6
                            g_pmdn_d[l_ac1].pmdbdocno_02_01,
                            g_pmdn_d[l_ac1].pmdbseq_02_01,
                            #g_pmdn_d[l_ac1].qty_02_01)   #160824-00032#1
                            g_pmdn_d[l_ac1].pmdn007_02_01)#160824-00032#1
        RETURNING l_success

   IF l_success THEN
      INSERT INTO p490_02_pmdn_t(pmdb014,pmdl004,pmdl025,pmdl026,pmdn058,
                                 pmdn036,pmdn037,pmdn038,
                                 pmdb004,pmdb005,pmdb007,qty,
                                 pmdn014,pmdn001,pmdn002,pmdn006,pmdn007,
                                 pmdn008,pmdn009,pmdn010,
                                 pmdn011,
                                 pmdn028,pmdn029,pmdn053,  #160801-00004#3
                                 #161031-00025#6-s-mod
#                                 pmdn050,pmdbent,pmdbsite,pmdbdocno,pmdbseq,link_no)
                                 pmdn050,ooff013,ooff014,pmdbent,pmdbsite,pmdbdocno,pmdbseq,link_no)
                                 #161031-00025#6-e-mod
                          VALUES(g_pmdn_d[l_ac1].pmdb014_02_01,g_pmdn_d[l_ac1].pmdl004_02_01,
                                 g_pmdn_d[l_ac1].pmdl025_02_01,g_pmdn_d[l_ac1].pmdl026_02_01,
                                 g_pmdn_d[l_ac1].pmdn058_02_01,
                                 g_pmdn_d[l_ac1].pmdn036_02_01,g_pmdn_d[l_ac1].pmdn037_02_01,
                                 g_pmdn_d[l_ac1].pmdn038_02_01,
                                 g_pmdn_d[l_ac1].pmdb004_02_01,
                                 g_pmdn_d[l_ac1].pmdb005_02_01,g_pmdn_d[l_ac1].pmdb007_02_01,
                                 g_pmdn_d[l_ac1].qty_02_01    ,g_pmdn_d[l_ac1].pmdn014_02_01,
                                 g_pmdn_d[l_ac1].pmdn001_02_01,g_pmdn_d[l_ac1].pmdn002_02_01, 
                                 g_pmdn_d[l_ac1].pmdn006_02_01,g_pmdn_d[l_ac1].pmdn007_02_01,
                                 g_pmdn_d[l_ac1].pmdn008_02_01,g_pmdn_d[l_ac1].pmdn009_02_01,
                                 g_pmdn_d[l_ac1].pmdn010_02_01,g_pmdn_d[l_ac1].pmdn011_02_01,
                                 #160801-00004#3--s
                                 g_pmdn_d[l_ac1].pmdn028_02_01,
                                 g_pmdn_d[l_ac1].pmdn029_02_01,
                                 g_pmdn_d[l_ac1].pmdn053_02_01,
                                 #160801-00004#3--e
                                 g_pmdn_d[l_ac1].pmdn050_02_01,                                 
                                 g_pmdn_d[l_ac1].ooff013_02_01,   #161031-00025#6
                                 g_pmdn_d[l_ac1].ooff014_02_01,   #161031-00025#6
                                 g_pmdn_d[l_ac1].pmdbent_02_01,g_pmdn_d[l_ac1].pmdbsite_02_01,
                                 g_pmdn_d[l_ac1].pmdbdocno_02_01,g_pmdn_d[l_ac1].pmdbseq_02_01,
                                 l_ac1)
      LET l_ac1 = l_ac1 + 1
   END IF

   LET l_pmao008_sum = 0
   
   #160819-00043#6--s
   #SELECT SUM(pmao008) INTO l_pmao008_sum
   #  FROM pmao_t
   # WHERE pmaoent = p_pmdn_d.pmdbent_02_01
   #   AND pmao002 = p_pmdn_d.pmdb004_02_01
   #   AND NVL(pmao003,' ') = NVL(p_pmdn_d.pmdb005_02_01,' ')
   #   AND pmao001 <> l_imaf153
   
   SELECT SUM(pmat004) INTO l_pmao008_sum
     FROM pmat_t
    WHERE pmatent = p_pmdn_d.pmdbent_02_01
      AND pmatsite = p_pmdn_d.pmdbsite_02_01
      AND pmat002 = p_pmdn_d.pmdb004_02_01                    #料件編號  
      AND NVL(pmat003,' ') = NVL(p_pmdn_d.pmdb005_02_01,' ')  #產品特徵 
      AND pmat001 <> l_imaf153
      AND pmatstus = 'Y'
   #160819-00043#6---e
   
   IF cl_null(l_pmao008_sum) THEN
      LET l_pmao008_sum = 0
   END IF

   IF l_pmao008_sum = 0 THEN  
      RETURN 
   END IF 

   #160819-00043#6--s
   #LET l_sql = "SELECT pmao001,pmao008 ",
   #            "  FROM pmao_t ",
   #            " WHERE pmaoent = '",p_pmdn_d.pmdbent_02_01,"' ",
   #            "   AND pmao002 = '",p_pmdn_d.pmdb004_02_01,"' ",
   #            "   AND NVL(pmao003,' ') = NVL('",p_pmdn_d.pmdb005_02_01,"',' ') ",
   #            "   AND pmao001 <> '",l_imaf153,"' "
   
   LET l_sql = "SELECT pmat001,pmat004 ",
               "  FROM pmat_t ",
               " WHERE pmatent = '",p_pmdn_d.pmdbent_02_01,"' ",
               "   AND pmatsite = '",p_pmdn_d.pmdbsite_02_01,"' ",
               "   AND pmat002 = '",p_pmdn_d.pmdb004_02_01,"' ",
               "   AND NVL(pmat003,' ') = NVL('",p_pmdn_d.pmdb005_02_01,"',' ') ",
               "   AND pmat001 <> '",l_imaf153,"' ",
               "   AND pmatstus = 'Y' "
   
   #160819-00043#6--e
   PREPARE apmp490_02_pmao_prep_2 FROM l_sql
   DECLARE apmp490_02_pmao_curs_2 CURSOR FOR apmp490_02_pmao_prep_2 
   
   FOREACH apmp490_02_pmao_curs_2 INTO l_pmao001,l_pmao008
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      LET g_pmdn_d[l_ac1].* = p_pmdn_d.*
      LET g_pmdn_d[l_ac1].pmdl004_02_01 = l_pmao001 
      #取得供應商簡稱 
      CALL apmp490_02_get_pmaal004(g_pmdn_d[l_ac1].pmdl004_02_01)
           RETURNING g_pmdn_d[l_ac1].pmaal004_02_01
      LET g_pmdn_d[l_ac1].pmdn007_02_01 = p_pmdn_d.pmdn007_02_01 * l_pmao008 / l_pmao008_sum  
      #161107-00031#1-add-s
      CALL s_aooi250_take_decimals(g_pmdn_d[l_ac1].pmdn006_02_01,g_pmdn_d[l_ac1].pmdn007_02_01)
           RETURNING l_success,g_pmdn_d[l_ac1].pmdn007_02_01
      #161107-00031#1-add-e
      
      #重新計算參考單位與數量 
      IF cl_get_para(g_enterprise,g_site,'S-BAS-0028') = 'Y' THEN
         SELECT imaf015 INTO g_pmdn_d[l_ac1].pmdn008_02_01
           FROM imaf_t
          WHERE imafent  = g_enterprise
            AND imafsite = g_site
            AND imaf001  = g_pmdn_d[l_ac1].pmdb004_02_01
         IF (NOT cl_null(g_pmdn_d[l_ac1].pmdn008_02_01)) AND
            (NOT cl_null(g_pmdn_d[l_ac1].pmdn001_02_01)) AND
            (NOT cl_null(g_pmdn_d[l_ac1].pmdn006_02_01)) THEN
            CALL apmp490_02_convert_qty(g_pmdn_d[l_ac1].pmdn001_02_01,g_pmdn_d[l_ac1].pmdn006_02_01,
                                        g_pmdn_d[l_ac1].pmdn008_02_01,g_pmdn_d[l_ac1].pmdn007_02_01)
                 RETURNING g_pmdn_d[l_ac1].pmdn009_02_01
            IF NOT cl_null(g_pmdn_d[l_ac1].pmdn009_02_01) THEN
               CALL apmp490_02_unit_round(g_pmdn_d[l_ac1].pmdn008_02_01,g_pmdn_d[l_ac1].pmdn009_02_01)
                    RETURNING g_pmdn_d[l_ac1].pmdn009_02_01
            END IF
         END IF
      END IF
      
      #需要重新計算計價數量 
      #如果aoos020中，設定使用採購計價單位 
      IF cl_get_para(g_enterprise,g_site,'S-BAS-0019') = "Y" THEN
         #取料件的預設採購計價單位 
         SELECT imaf144 INTO g_pmdn_d[l_ac1].pmdn010_02_01
           FROM imaf_t
          WHERE imafent = g_enterprise
            AND imafsite = g_site
            AND imaf001 = g_pmdn_d[l_ac1].pmdb004_02_01

         IF cl_null(g_pmdn_d[l_ac1].pmdn010_02_01) THEN
            LET g_pmdn_d[l_ac1].pmdn010_02_01 = g_pmdn_d[l_ac1].pmdn006_02_01
         END IF

         CALL apmp490_02_convert_qty(g_pmdn_d[l_ac1].pmdb004_02_01,g_pmdn_d[l_ac1].pmdn006_02_01,
                                     g_pmdn_d[l_ac1].pmdn010_02_01,g_pmdn_d[l_ac1].pmdn007_02_01)
              RETURNING g_pmdn_d[l_ac1].pmdn011_02_01
      ELSE
         #[C:計價單位] = 採購料號主檔的預設採購計價單位，若不使用採購計價單位時則此欄位=採購單位
         #[C:計價數量] = 採購數量*(採購單位與計價單位換算率)，若不使用採購計價單位時則此欄位=採購數量
         LET g_pmdn_d[l_ac1].pmdn010_02_01 = g_pmdn_d[l_ac1].pmdn006_02_01
         LET g_pmdn_d[l_ac1].pmdn011_02_01 = g_pmdn_d[l_ac1].pmdn007_02_01
      END IF

      CALL apmp490_02_ins_pmdb(l_ac1,g_pmdn_d[l_ac1].pmdb004_02_01,
                               g_pmdn_d[l_ac1].pmdb005_02_01,
                               g_pmdn_d[l_ac1].pmdl025_02_01,
                               g_pmdn_d[l_ac1].pmdl026_02_01,
                               g_pmdn_d[l_ac1].pmdn058_02_01,
                               g_pmdn_d[l_ac1].pmdn036_02_01,
                               g_pmdn_d[l_ac1].pmdn037_02_01,
                               g_pmdn_d[l_ac1].pmdn038_02_01,
                               #160801-00004#3--s
                               g_pmdn_d[l_ac1].pmdn028_02_01,
                               g_pmdn_d[l_ac1].pmdn029_02_01,
                               g_pmdn_d[l_ac1].pmdn053_02_01,
                               #160801-00004#3--e
                               g_pmdn_d[l_ac1].pmdn050_02_01,
                               g_pmdn_d[l_ac1].ooff013_02_01,   #161031-00025#6
                               g_pmdn_d[l_ac1].ooff014_02_01,   #161031-00025#6
                               g_pmdn_d[l_ac1].pmdbdocno_02_01,
                               g_pmdn_d[l_ac1].pmdbseq_02_01,
                               #g_pmdn_d[l_ac1].qty_02_01)   #160824-00032#1
                               g_pmdn_d[l_ac1].pmdn007_02_01)#160824-00032#1
           RETURNING l_success

      IF l_success THEN
         INSERT INTO p490_02_pmdn_t(pmdb014,pmdl004,pmdl025,pmdl026,pmdn058,
                                    pmdn036,pmdn037,pmdn038,
                                    pmdb004,pmdb005,pmdb007,qty,
                                    pmdn014,pmdn001,pmdn002,pmdn006,pmdn007,
                                    pmdn008,pmdn009,pmdn010,
                                    pmdn011,
                                    pmdn028,pmdn029,pmdn053,  #160801-00004#3	
                                    #161031-00025#6-s-mod
#                                    pmdn050,pmdbent,pmdbsite,pmdbdocno,pmdbseq,link_no)
                                    pmdn050,ooff013,ooff014,pmdbent,pmdbsite,pmdbdocno,pmdbseq,link_no)
                                    #161031-00025#6-e-mod
                             VALUES(g_pmdn_d[l_ac1].pmdb014_02_01,g_pmdn_d[l_ac1].pmdl004_02_01,
                                    g_pmdn_d[l_ac1].pmdl025_02_01,g_pmdn_d[l_ac1].pmdl026_02_01,
                                    g_pmdn_d[l_ac1].pmdn058_02_01,
                                    g_pmdn_d[l_ac1].pmdn036_02_01,g_pmdn_d[l_ac1].pmdn037_02_01,
                                    g_pmdn_d[l_ac1].pmdn038_02_01,
                                    g_pmdn_d[l_ac1].pmdb004_02_01,
                                    g_pmdn_d[l_ac1].pmdb005_02_01,g_pmdn_d[l_ac1].pmdb007_02_01,
                                    g_pmdn_d[l_ac1].qty_02_01    ,g_pmdn_d[l_ac1].pmdn014_02_01,
                                    g_pmdn_d[l_ac1].pmdn001_02_01,g_pmdn_d[l_ac1].pmdn002_02_01, 
                                    g_pmdn_d[l_ac1].pmdn006_02_01,g_pmdn_d[l_ac1].pmdn007_02_01,
                                    g_pmdn_d[l_ac1].pmdn008_02_01,g_pmdn_d[l_ac1].pmdn009_02_01,
                                    g_pmdn_d[l_ac1].pmdn010_02_01,g_pmdn_d[l_ac1].pmdn011_02_01,
                                    #160801-00004#3--s
                                    g_pmdn_d[l_ac1].pmdn028_02_01,
                                    g_pmdn_d[l_ac1].pmdn029_02_01,
                                    g_pmdn_d[l_ac1].pmdn053_02_01,
                                    #160801-00004#3--e
                                    g_pmdn_d[l_ac1].pmdn050_02_01,
                                    g_pmdn_d[l_ac1].ooff013_02_01,   #161031-00025#6
                                    g_pmdn_d[l_ac1].ooff014_02_01,   #161031-00025#6
                                    g_pmdn_d[l_ac1].pmdbent_02_01,g_pmdn_d[l_ac1].pmdbsite_02_01,
                                    g_pmdn_d[l_ac1].pmdbdocno_02_01,g_pmdn_d[l_ac1].pmdbseq_02_01,
                                    l_ac1)
         LET l_ac1 = l_ac1 + 1
      END IF
      
   END FOREACH

END FUNCTION

################################################################################
# Descriptions...: 指定單一供應商
# Memo...........:
# Usage..........: CALL apmp490_02_allot_3(p_pmdn_d)
# Input parameter: p_pmdn_d:整個pmdn_file
# Date & Author..: 2014/06/18 By ming
# Modify.........:
################################################################################
PUBLIC FUNCTION apmp490_02_allot_3(p_pmdn_d)
   DEFINE p_pmdn_d         type_g_pmdn_d
   DEFINE l_ac1            LIKE type_t.num5 
   DEFINE l_success        LIKE type_t.num5

   WHENEVER ERROR CONTINUE 

   LET l_ac1 = g_pmdn_d.getLength() + 1
   LET g_pmdn_d[l_ac1].* = p_pmdn_d.*

   LET g_pmdn_d[l_ac1].pmdl004_02_01 = g_apmp490_02_input.bt01 
   
   #取得供應商簡稱 
   CALL apmp490_02_get_pmaal004(g_pmdn_d[l_ac1].pmdl004_02_01)
        RETURNING g_pmdn_d[l_ac1].pmaal004_02_01

   CALL apmp490_02_ins_pmdb(l_ac1,g_pmdn_d[l_ac1].pmdb004_02_01,
                            g_pmdn_d[l_ac1].pmdb005_02_01,
                            g_pmdn_d[l_ac1].pmdl025_02_01,
                            g_pmdn_d[l_ac1].pmdl026_02_01,
                            g_pmdn_d[l_ac1].pmdn058_02_01,
                            g_pmdn_d[l_ac1].pmdn036_02_01,
                            g_pmdn_d[l_ac1].pmdn037_02_01,
                            g_pmdn_d[l_ac1].pmdn038_02_01,
                            #160801-00004#3--s
                            g_pmdn_d[l_ac1].pmdn028_02_01,
                            g_pmdn_d[l_ac1].pmdn029_02_01,
                            g_pmdn_d[l_ac1].pmdn053_02_01,
                            #160801-00004#3--e 
                            g_pmdn_d[l_ac1].pmdn050_02_01,
                            g_pmdn_d[l_ac1].ooff013_02_01,   #161031-00025#6
                            g_pmdn_d[l_ac1].ooff014_02_01,   #161031-00025#6
                            g_pmdn_d[l_ac1].pmdbdocno_02_01,
                            g_pmdn_d[l_ac1].pmdbseq_02_01,
                            g_pmdn_d[l_ac1].qty_02_01)
        RETURNING l_success

   IF l_success THEN
      INSERT INTO p490_02_pmdn_t(pmdb014,pmdl004,pmdl025,pmdl026,pmdn058,
                                 pmdn036,pmdn037,pmdn038,
                                 pmdb004,pmdb005,pmdb007,qty,
                                 pmdn014,pmdn001,pmdn002,pmdn006,pmdn007,
                                 pmdn008,pmdn009,pmdn010,
                                 pmdn011,
                                 pmdn028,pmdn029,pmdn053,  #160801-00004#3	
                                 #161031-00025#6-s-mod
#                                 pmdn050,pmdbent,pmdbsite,pmdbdocno,pmdbseq,link_no)
                                 pmdn050,ooff013,ooff014,pmdbent,pmdbsite,pmdbdocno,pmdbseq,link_no)
                                 #161031-00025#6-e-mod
                          VALUES(g_pmdn_d[l_ac1].pmdb014_02_01,g_pmdn_d[l_ac1].pmdl004_02_01,
                                 g_pmdn_d[l_ac1].pmdl025_02_01,g_pmdn_d[l_ac1].pmdl026_02_01,
                                 g_pmdn_d[l_ac1].pmdn058_02_01,
                                 g_pmdn_d[l_ac1].pmdn036_02_01,g_pmdn_d[l_ac1].pmdn037_02_01,
                                 g_pmdn_d[l_ac1].pmdn038_02_01,
                                 g_pmdn_d[l_ac1].pmdb004_02_01,
                                 g_pmdn_d[l_ac1].pmdb005_02_01,g_pmdn_d[l_ac1].pmdb007_02_01,
                                 g_pmdn_d[l_ac1].qty_02_01    ,g_pmdn_d[l_ac1].pmdn014_02_01,
                                 g_pmdn_d[l_ac1].pmdn001_02_01,g_pmdn_d[l_ac1].pmdn002_02_01, 
                                 g_pmdn_d[l_ac1].pmdn006_02_01,g_pmdn_d[l_ac1].pmdn007_02_01,
                                 g_pmdn_d[l_ac1].pmdn008_02_01,g_pmdn_d[l_ac1].pmdn009_02_01,
                                 g_pmdn_d[l_ac1].pmdn010_02_01,g_pmdn_d[l_ac1].pmdn011_02_01,
                                 #160801-00004#3--s
                                 g_pmdn_d[l_ac1].pmdn028_02_01,
                                 g_pmdn_d[l_ac1].pmdn029_02_01,
                                 g_pmdn_d[l_ac1].pmdn053_02_01,
                                 #160801-00004#3--e 
                                 g_pmdn_d[l_ac1].pmdn050_02_01,
                                 g_pmdn_d[l_ac1].ooff013_02_01,   #161031-00025#6
                                 g_pmdn_d[l_ac1].ooff014_02_01,   #161031-00025#6
                                 g_pmdn_d[l_ac1].pmdbent_02_01,g_pmdn_d[l_ac1].pmdbsite_02_01,
                                 g_pmdn_d[l_ac1].pmdbdocno_02_01,g_pmdn_d[l_ac1].pmdbseq_02_01,
                                 l_ac1)
   END IF

END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apmp490_02_allot_4(p_pmdn_d)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/12/02 By ming
# Modify.........:
################################################################################
PUBLIC FUNCTION apmp490_02_allot_4(p_pmdn_d)
   DEFINE p_pmdn_d         type_g_pmdn_d
   DEFINE l_ac1            LIKE type_t.num5
   DEFINE l_success        LIKE type_t.num5
   DEFINE l_sql            STRING
   DEFINE l_supply         RECORD
                              pmab001     LIKE pmab_t.pmab001,     #供應商代號 
                              pmab033     LIKE pmab_t.pmab033,     #幣別 
                              pmab034     LIKE pmab_t.pmab034,     #稅別 
                              pmab037     LIKE pmab_t.pmab037,     #付款條件 
                              pmab039     LIKE pmab_t.pmab039,     #採購分類 
                              pmab053     LIKE pmab_t.pmab053,     #交易條件 
                              pmab054     LIKE pmab_t.pmab054,     #慣用取價方式 
                              pmab057     LIKE pmab_t.pmab057,     #內外購 
                              price       LIKE pmdn_t.pmdn015      #單價  
                           END RECORD
   DEFINE l_pmdn015        LIKE pmdn_t.pmdn015
   DEFINE l_pmdn040        LIKE pmdn_t.pmdn040
   DEFINE l_pmdn041        LIKE pmdn_t.pmdn041
   DEFINE l_pmdn042        LIKE pmdn_t.pmdn042

   WHENEVER ERROR CONTINUE

   LET l_ac1 = g_pmdn_d.getLength() + 1

   LET g_pmdn_d[l_ac1].* = p_pmdn_d.*

   #清空temp table的資料 
   DELETE FROM p490_02_tmp01_t; 
   #找apmi125與apmi070的供應商資料 
   LET l_sql = "SELECT DISTINCT pmar001,pmab033,pmab034,pmab037,pmab039,pmab053, ",
               "                pmab054,pmab057,0 ",
               "  FROM pmar_t LEFT JOIN pmab_t ON pmabent  = '",g_enterprise,"' ",
               "                              AND pmabsite = '",g_site,"' ",
               "                              AND pmab001  = pmar001 ",
               " WHERE pmarent  = '",g_enterprise,"' ",
               "   AND pmarsite = '",g_site,"' ",
               "   AND pmar002  = '",g_pmdn_d[l_ac1].pmdb004_02_01,"' ",
               " UNION ",
               "SELECT DISTINCT pmao001,pmab033,pmab034,pmab037,pmab039,pmab053, ",
               "                pmab054,pmab057,0 ",
               "  FROM pmao_t LEFT JOIN pmab_t ON pmabent  = '",g_enterprise,"' ",
               "                              AND pmabsite = '",g_site,"' ",
               "                              AND pmab001  = pmao001 ",
               " WHERE pmaoent = '",g_enterprise,"' ",
               "   AND pmao000 = '1' ",      #161221-00064#9 add
               "   AND pmao002 = '",g_pmdn_d[l_ac1].pmdb004_02_01,"' "

   PREPARE apmp490_02_get_supply_data_prep FROM l_sql
   DECLARE apmp490_02_get_supply_data_curs CURSOR FOR apmp490_02_get_supply_data_prep

   INITIALIZE l_supply.* TO NULL
   FOREACH apmp490_02_get_supply_data_curs INTO l_supply.pmab001,l_supply.pmab033,
                                                l_supply.pmab034,l_supply.pmab037,
                                                l_supply.pmab039,l_supply.pmab053,
                                                l_supply.pmab054,l_supply.pmab057, 
                                                l_supply.price

      IF NOT (cl_null(l_supply.pmab054) OR cl_null(l_supply.pmab001) OR
              cl_null(g_pmdn_d[l_ac1].pmdb004_02_01) OR
              cl_null(l_supply.pmab033) OR cl_null(l_supply.pmab034) OR
              cl_null(l_supply.pmab037) OR cl_null(l_supply.pmab053) OR
              cl_null(l_supply.pmab039) OR cl_null(l_supply.pmab057) OR
              cl_null(g_pmdn_d[l_ac1].pmdn010_02_01) OR
              cl_null(g_pmdn_d[l_ac1].pmdn011_02_01) ) THEN
         CALL s_purchase_price_get(l_supply.pmab054,l_supply.pmab001,
                                   g_pmdn_d[l_ac1].pmdb004_02_01,
                                   g_pmdn_d[l_ac1].pmdb005_02_01,
                                   l_supply.pmab033,l_supply.pmab034,l_supply.pmab037,
                                   l_supply.pmab053,l_supply.pmab039,
                                   g_apmp490_01_input.pmdldocno,g_today,
                                   g_pmdn_d[l_ac1].pmdn010_02_01,
                                   g_pmdn_d[l_ac1].pmdn011_02_01,
                                   g_site,l_supply.pmab057,'1','apmp490','')
              RETURNING l_pmdn040,l_pmdn015,l_pmdn041,l_pmdn042

         LET l_supply.price = l_pmdn015
      END IF

      #取不到單價的供應商需要排除掉 
      IF cl_null(l_supply.price) OR l_supply.price <= 0 THEN
         CONTINUE FOREACH
      END IF 
      
      INSERT INTO p490_02_tmp01_t VALUES(l_supply.pmab001,l_supply.price)

   END FOREACH

   SELECT pmab001 INTO g_pmdn_d[l_ac1].pmdl004_02_01
     FROM p490_02_tmp01_t
    WHERE price = (SELECT MIN(price)
                     FROM p490_02_tmp01_t)



   #取得供應商簡稱 
   CALL apmp490_02_get_pmaal004(g_pmdn_d[l_ac1].pmdl004_02_01)
        RETURNING g_pmdn_d[l_ac1].pmaal004_02_01

   CALL apmp490_02_ins_pmdb(l_ac1,g_pmdn_d[l_ac1].pmdb004_02_01,
                            g_pmdn_d[l_ac1].pmdb005_02_01,
                            g_pmdn_d[l_ac1].pmdl025_02_01,
                            g_pmdn_d[l_ac1].pmdl026_02_01,
                            g_pmdn_d[l_ac1].pmdn058_02_01,
                            g_pmdn_d[l_ac1].pmdn036_02_01,
                            g_pmdn_d[l_ac1].pmdn037_02_01,
                            g_pmdn_d[l_ac1].pmdn038_02_01,
                            #160801-00004#3--s
                            g_pmdn_d[l_ac1].pmdn028_02_01,
                            g_pmdn_d[l_ac1].pmdn029_02_01,
                            g_pmdn_d[l_ac1].pmdn053_02_01,
                            #160801-00004#3--e 
                            g_pmdn_d[l_ac1].pmdn050_02_01,
                            g_pmdn_d[l_ac1].ooff013_02_01,   #161031-00025#6
                            g_pmdn_d[l_ac1].ooff014_02_01,   #161031-00025#6
                            g_pmdn_d[l_ac1].pmdbdocno_02_01,
                            g_pmdn_d[l_ac1].pmdbseq_02_01, 
                            g_pmdn_d[l_ac1].qty_02_01)
        RETURNING l_success

   IF l_success THEN
      INSERT INTO p490_02_pmdn_t(pmdb014,pmdl004,pmdl025,pmdl026,pmdn058,
                                 pmdn036,pmdn037,pmdn038,
                                 pmdb004,pmdb005,pmdb007,qty,
                                 pmdn014,pmdn001,pmdn002,pmdn006,pmdn007,
                                 pmdn008,pmdn009,pmdn010,
                                 pmdn011,
                                 pmdn028,pmdn029,pmdn053,  #160801-00004#3	
                                 #161031-00025#6-s-mod
#                                 pmdn050,pmdbent,pmdbsite,pmdbdocno,pmdbseq,link_no)
                                 pmdn050,ooff013,ooff014,pmdbent,pmdbsite,pmdbdocno,pmdbseq,link_no)
                                 #161031-00025#6-e-mod
                          VALUES(g_pmdn_d[l_ac1].pmdb014_02_01,g_pmdn_d[l_ac1].pmdl004_02_01,
                                 g_pmdn_d[l_ac1].pmdl025_02_01,g_pmdn_d[l_ac1].pmdl026_02_01,
                                 g_pmdn_d[l_ac1].pmdn058_02_01,
                                 g_pmdn_d[l_ac1].pmdn036_02_01,g_pmdn_d[l_ac1].pmdn037_02_01,
                                 g_pmdn_d[l_ac1].pmdn038_02_01,
                                 g_pmdn_d[l_ac1].pmdb004_02_01,
                                 g_pmdn_d[l_ac1].pmdb005_02_01,g_pmdn_d[l_ac1].pmdb007_02_01,
                                 g_pmdn_d[l_ac1].qty_02_01    ,g_pmdn_d[l_ac1].pmdn014_02_01,
                                 g_pmdn_d[l_ac1].pmdn001_02_01,g_pmdn_d[l_ac1].pmdn002_02_01,
                                 g_pmdn_d[l_ac1].pmdn006_02_01,g_pmdn_d[l_ac1].pmdn007_02_01,
                                 g_pmdn_d[l_ac1].pmdn008_02_01,g_pmdn_d[l_ac1].pmdn009_02_01,
                                 g_pmdn_d[l_ac1].pmdn010_02_01,g_pmdn_d[l_ac1].pmdn011_02_01,
                                 #160801-00004#3--s
                                 g_pmdn_d[l_ac1].pmdn028_02_01,
                                 g_pmdn_d[l_ac1].pmdn029_02_01,
                                 g_pmdn_d[l_ac1].pmdn053_02_01,
                                 #160801-00004#3--e 
                                 g_pmdn_d[l_ac1].pmdn050_02_01,
                                 g_pmdn_d[l_ac1].ooff013_02_01,   #161031-00025#6
                                 g_pmdn_d[l_ac1].ooff014_02_01,   #161031-00025#6
                                 g_pmdn_d[l_ac1].pmdbent_02_01,g_pmdn_d[l_ac1].pmdbsite_02_01,
                                 g_pmdn_d[l_ac1].pmdbdocno_02_01,g_pmdn_d[l_ac1].pmdbseq_02_01,
                                 l_ac1)

   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 設定欄位變色
# Memo...........:
# Usage..........: CALL apmp490_02_pmdn_set_color(p_ac)
# Input parameter: p_ac
# Date & Author..: 2014/06/18 By ming
# Modify.........:
################################################################################
PUBLIC FUNCTION apmp490_02_pmdn_set_color(p_ac)
   DEFINE p_ac     LIKE type_t.num5

   WHENEVER ERROR CONTINUE 

   LET g_apmp490_02_pmdn_color_d[p_ac].pmdl004 = 'red'
   LET g_apmp490_02_pmdn_color_d[p_ac].pmdb004 = 'red'
   LET g_apmp490_02_pmdn_color_d[p_ac].pmdb005 = 'red'
   LET g_apmp490_02_pmdn_color_d[p_ac].pmdb007 = 'red'
   LET g_apmp490_02_pmdn_color_d[p_ac].qty     = 'red'
   LET g_apmp490_02_pmdn_color_d[p_ac].pmdn014 = 'red'
   LET g_apmp490_02_pmdn_color_d[p_ac].pmdn001 = 'red'
   LET g_apmp490_02_pmdn_color_d[p_ac].pmdn002 = 'red'
   LET g_apmp490_02_pmdn_color_d[p_ac].pmdn006 = 'red'
   LET g_apmp490_02_pmdn_color_d[p_ac].pmdn007 = 'red'
   LET g_apmp490_02_pmdn_color_d[p_ac].pmdn010 = 'red'
   LET g_apmp490_02_pmdn_color_d[p_ac].pmdn011 = 'red'
   LET g_apmp490_02_pmdn_color_d[p_ac].pmdbent = 'red'
   LET g_apmp490_02_pmdn_color_d[p_ac].pmdbsite = 'red'
END FUNCTION

################################################################################
# Descriptions...: 建立temp table 
# Memo...........:
# Usage..........: CALL apmp490_02_create_temp_table()
# Date & Author..: 2014/06/18 By ming
# Modify.........:
################################################################################
PUBLIC FUNCTION apmp490_02_create_temp_table()

   WHENEVER ERROR CONTINUE 

   CREATE TEMP TABLE p490_02_pmdn_t( 
      pmdb014         VARCHAR(10),           #供應商選擇  
      pmdl004         VARCHAR(10),           #供應商  
      pmdl025         VARCHAR(10),           #送貨地址       
      pmdl026         VARCHAR(10),           #帳款地址       
      pmdn058         VARCHAR(24),           #預算科目 
      pmdn036         VARCHAR(20),           #專案編號    
      pmdn037         VARCHAR(30),           #WBS 
      pmdn038         VARCHAR(30),           #活動編號    
      pmdb004         VARCHAR(40),           #請購料號  
      pmdb005         VARCHAR(256),           #請購產品特徵  
      pmdb007         VARCHAR(10),           #請購單位  
      qty             DECIMAL(20,6),           #未轉採購量  
      pmdn014         DATE,           #到庫日期  
      pmdn001         VARCHAR(40),           #採購料號  
      pmdn002         VARCHAR(256),           #採購產品特徵  
      pmdn006         VARCHAR(10),           #採購單位  
      pmdn007         DECIMAL(20,6),           #採購數量  
      pmdn008         VARCHAR(10),           #參考單位 
      pmdn009         DECIMAL(20,6),           #參考數量 
      pmdn010         VARCHAR(10),           #計價單位  
      pmdn011         DECIMAL(20,6),           #計價數量 
      #160801-00004#3--s
      pmdn028         VARCHAR(10),           #庫位 
      pmdn029         VARCHAR(10),           #儲位
      pmdn053         VARCHAR(30),           #庫存管理特徵
      #160801-00004#3--e 
      pmdn050         VARCHAR(255),           #備註   
      ooff013         VARCHAR(4000),           #長備註   #161031-00025#6
      ooff014         DATE,           #失效日期 #161031-00025#6
      pmdbent         SMALLINT,
      pmdbsite        VARCHAR(10), 
      pmdbdocno       VARCHAR(20),         #請購單號     #20151106 ming add 
      pmdbseq         INTEGER,           #請購項次     #20151106 ming add 
      link_no         INTEGER     #序號   
   ) 
   
   #新請購底稿資料  
   CREATE TEMP TABLE p490_02_pmdb_t(
      link_no         INTEGER,             #序號 用來與採購底稿關聯的 
      pmdbdocno       VARCHAR(20),         #請購單號 
      pmdbseq         INTEGER,           #項次 
      pmdb004         VARCHAR(40),           #請購料號 
      pmdb005         VARCHAR(256),           #產品特徵 
      pmdb007         VARCHAR(10),           #單位  
      pmdb006         DECIMAL(20,6),           #需求數量   
      qty             DECIMAL(20,6),           #未轉採購量  #也代表 被分配的數量  
      pmdb030         DATE,           #需求日期 
      pmdb033         VARCHAR(10),           #緊急度 
      pmdb014         VARCHAR(10),           #供應商選擇 
      pmdb015         VARCHAR(10),           #供應商編號  
      pmda024         VARCHAR(10),           #送貨地址      
      pmda025         VARCHAR(10),           #帳款地址     
      pmdn058         VARCHAR(24),           #預算科目    
      pmdn036         VARCHAR(20),           #專案編號    
      pmdn037         VARCHAR(30),           #WBS 
      pmdn038         VARCHAR(30),           #活動編號  
      #160801-00004#3--s
      pmdn028         VARCHAR(10),           #庫位 
      pmdn029         VARCHAR(10),           #儲位
      pmdn053         VARCHAR(30),           #庫存管理特徵
      #160801-00004#3--e       
      pmdb050         VARCHAR(255),            #備註        
      ooff013         VARCHAR(4000),            #長備註   #161031-00025#6
      ooff014         DATE     #失效日期 #161031-00025#6
   ) 
   
   #151022-00003#3 20151202 add by ming -----(S) 
   #最低價供應商的暫存表   
   CREATE TEMP TABLE p490_02_tmp01_t(
      pmab001         VARCHAR(10),           #供應商代號 
      price           DECIMAL(20,6)     #單價 
   )
   #151022-00003#3 20151202 add by ming -----(E)  
   
END FUNCTION

################################################################################
# Descriptions...: 刪除temp table 
# Memo...........:
# Usage..........: CALL apmp490_02_drop_temp_table()
# Date & Author..: 2014/06/18 By ming
# Modify.........:
################################################################################
PUBLIC FUNCTION apmp490_02_drop_temp_table()
   
   WHENEVER ERROR CONTINUE 
   
   DROP TABLE p490_02_pmdn_t;
   DROP TABLE p490_02_pmdb_t;
   #151022-00003#3 20151202 add by ming -----(S) 
   #最低價供應商的暫存表   
   DROP TABLE p490_02_tmp01_t;
   #151022-00003#3 20151202 add by ming -----(E) 
END FUNCTION

################################################################################
# Descriptions...: 建立第三頁所需的單頭資料
# Memo...........:
# Usage..........: CALL apmp490_02_ins_pmdl_t()
# Date & Author..: 2014/06/18 By ming
# Modify.........:
################################################################################
PUBLIC FUNCTION apmp490_02_ins_pmdl_t()
   DEFINE l_sql       STRING
   DEFINE l_pmdl004   LIKE pmdl_t.pmdl004 
   DEFINE l_pmdl025   LIKE pmdl_t.pmdl025
   DEFINE l_pmdl026   LIKE pmdl_t.pmdl026
   DEFINE l_pmdn058   LIKE pmdn_t.pmdn058
   
   DEFINE l_flag      LIKE type_t.num5
   DEFINE l_pmal002   LIKE pmal_t.pmal002    #控制組編號   

   DEFINE l_pmdl009   LIKE pmdl_t.pmdl009    #付款條件  
   DEFINE l_pmdl010   LIKE pmdl_t.pmdl010    #交易條件  
   DEFINE l_pmdl011   LIKE pmdl_t.pmdl011    #稅別  
   DEFINE l_pmdl012   LIKE pmdl_t.pmdl012    #稅率  
   DEFINE l_pmdl013   LIKE pmdl_t.pmdl013    #單價含稅否  
   DEFINE l_pmdl015   LIKE pmdl_t.pmdl015    #幣別  
   DEFINE l_pmdl016   LIKE pmdl_t.pmdl016    #匯率  
   DEFINE l_pmdl017   LIKE pmdl_t.pmdl017    #取價方式  
   DEFINE l_pmdl023   LIKE pmdl_t.pmdl023    #採購通路 
   DEFINE l_pmdl054   LIKE pmdl_t.pmdl054    #內外購  
   DEFINE l_pmdl033   LIKE pmdl_t.pmdl033    #發票類型 
   DEFINE l_pmdl055   LIKE pmdl_t.pmdl055    #匯率計算基礎 

   DEFINE l_ooef016   LIKE ooef_t.ooef016 
   DEFINE l_pmdl_ins  RECORD                 #存在此record中的，才是真的會存入temp table 的 
                         pmdl004     LIKE pmdl_t.pmdl004,
                         pmdl009     LIKE pmdl_t.pmdl009,     #付款條件 
                         pmdl010     LIKE pmdl_t.pmdl010,     #交易條件 
                         pmdl011     LIKE pmdl_t.pmdl011,     #稅別 
                         pmdl012     LIKE pmdl_t.pmdl012,     #稅率 
                         pmdl013     LIKE pmdl_t.pmdl013,     #單價含稅否 
                         pmdl015     LIKE pmdl_t.pmdl015,     #幣別 
                         pmdl016     LIKE pmdl_t.pmdl016,     #匯率 
                         pmdl017     LIKE pmdl_t.pmdl017,     #取價方式 
                         pmdl023     LIKE pmdl_t.pmdl023,     #採購通路 
                         pmdl054     LIKE pmdl_t.pmdl054,     #內外購 
                         pmdl033     LIKE pmdl_t.pmdl033,     #發票類型 
                         pmdl055     LIKE pmdl_t.pmdl055,     #匯率計算基礎 
                         pmal002     LIKE pmal_t.pmal002,     #控制組編號  
                         pmdl025     LIKE pmdl_t.pmdl025,     #送貨地址 
                         pmdl026     LIKE pmdl_t.pmdl026      #帳款地址 
                      END RECORD
   
   WHENEVER ERROR CONTINUE 

   #將第三步的temp table清空 以免資料不斷的寫入 
   DELETE FROM p490_03_pmdl_t;

   LET l_sql = "SELECT pmdl004,pmdl025,pmdl026 ",
               "  FROM p490_02_pmdn_t ",
               " GROUP BY pmdl004,pmdl025,pmdl026 "
   PREPARE apmp490_02_ins_pmdl_prep FROM l_sql
   DECLARE apmp490_02_ins_pmdl_curs CURSOR FOR apmp490_02_ins_pmdl_prep 
   
   #pmal_t:採購控制組供應商預設條件檔 
   #pmal002:控制組編號 
   #pmal003:慣用交易幣別 
   #pmal004:慣用稅務規則 
   #pmal006:慣用付款條件  
   #pmal020:慣用交易條件  
   #pmal021:慣用取價方式  
   #pmal008:慣用採購通路 
   #pmal023:慣用內外購 
   #pmal022:慣用發票類型 
   #pmal024:慣用匯率計算基準
   LET l_sql = "SELECT pmal002,pmal003,pmal004,pmal006,pmal020,pmal021, ",
               "       pmal008,pmal023,pmal022,pmal024  ",
               "  FROM pmal_t ",
               " WHERE pmalent = '",g_enterprise,"' ",
               "   AND pmalstus = 'Y' ",
               "   AND pmal001 = ? ",  
               "   AND pmal002 = '",g_controlno,"' "     #控制組編號  
   PREPARE apmp490_02_get_pmal_prep FROM l_sql
   DECLARE apmp490_02_get_pmal_curs CURSOR FOR apmp490_02_get_pmal_prep

   FOREACH apmp490_02_ins_pmdl_curs INTO l_pmdl004,l_pmdl025,l_pmdl026,l_pmdn058
      IF STATUS THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = STATUS
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF 
      
      INITIALIZE l_pmdl_ins.* TO NULL
      LET l_pmdl_ins.pmdl004 = l_pmdl004
      LET l_pmdl_ins.pmdl025 = l_pmdl025
      LET l_pmdl_ins.pmdl026 = l_pmdl026
      LET l_pmdl_ins.pmal002 = g_controlno                   #控制組編號  

      #取單別預設值 
      LET l_pmdl_ins.pmdl009 = g_apmp490_01_pmdl.pmdl009     #付款條件 
      LET l_pmdl_ins.pmdl010 = g_apmp490_01_pmdl.pmdl010     #交易條件 
      LET l_pmdl_ins.pmdl011 = g_apmp490_01_pmdl.pmdl011     #稅別 
      LET l_pmdl_ins.pmdl012 = g_apmp490_01_pmdl.pmdl012     #稅率 
      LET l_pmdl_ins.pmdl013 = g_apmp490_01_pmdl.pmdl013     #單價含稅否 
      LET l_pmdl_ins.pmdl015 = g_apmp490_01_pmdl.pmdl015     #幣別 
      LET l_pmdl_ins.pmdl016 = g_apmp490_01_pmdl.pmdl016     #匯率 
      LET l_pmdl_ins.pmdl017 = g_apmp490_01_pmdl.pmdl017     #取價方式 
      LET l_pmdl_ins.pmdl023 = g_apmp490_01_pmdl.pmdl023     #採購通路 
      LET l_pmdl_ins.pmdl054 = g_apmp490_01_pmdl.pmdl054     #內外購 
      LET l_pmdl_ins.pmdl033 = g_apmp490_01_pmdl.pmdl033     #發票類型 
      LET l_pmdl_ins.pmdl055 = g_apmp490_01_pmdl.pmdl055     #匯率計算基礎 

      #用供應商找是否有控制組的資料 apmi110  
      LET l_pmal002 = ''         #控制組編號 
      LET l_pmdl009 = ''         #付款條件  
      LET l_pmdl010 = ''         #交易條件  
      LET l_pmdl011 = ''         #稅別  
      LET l_pmdl012 = ''         #稅率 
      LET l_pmdl013 = ''         #單價含稅否  
      LET l_pmdl015 = ''         #幣別  
      LET l_pmdl017 = ''         #取價方式    
      LET l_pmdl023 = ''         #採購通路  
      LET l_pmdl054 = ''         #內外購  
      LET l_pmdl033 = ''         #發票類型  
      LET l_pmdl055 = ''         #匯率計算基礎 
      LET l_flag = TRUE

      FOREACH apmp490_02_get_pmal_curs USING l_pmdl004
                                        INTO l_pmal002,l_pmdl015,l_pmdl011,
                                             l_pmdl009,l_pmdl010,l_pmdl017, 
                                             l_pmdl023,l_pmdl054,l_pmdl033,l_pmdl055
         IF STATUS THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = STATUS
            LET g_errparam.extend = 'foreach:'
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF

         #有進入foreach抓到資料 就改變flag 這樣就不用去apmm202抓資料了  
         LET l_flag = FALSE
         EXIT FOREACH
      END FOREACH

      #如果在控制組中找不到資料的話 改找apmm202的資料來預設  
      IF l_flag THEN
         LET l_pmdl009 = ''      #付款條件  
         LET l_pmdl010 = ''      #交易條件  
         LET l_pmdl011 = ''      #稅別  
         LET l_pmdl015 = ''      #幣別  
         LET l_pmdl017 = ''      #取價方式   
         LET l_pmdl023 = ''      #採購通路  
         LET l_pmdl054 = ''      #內外購  
         LET l_pmdl033 = ''      #發票類型 
         LET l_pmdl055 = ''      #匯率計算基礎
         SELECT pmab034,pmab033,pmab037,pmab053,pmab054,pmab038,pmab057,pmab056,pmab058
           INTO l_pmdl011,l_pmdl015,l_pmdl009,l_pmdl010,l_pmdl017,
                l_pmdl023,l_pmdl054,l_pmdl033,l_pmdl055
           FROM pmab_t
          WHERE pmabent  = g_enterprise
            AND pmabsite = g_site
            AND pmab001  = l_pmdl004
      END IF 

      #取得稅率、單價含稅否 
      IF NOT cl_null(l_pmdl011) THEN
         SELECT oodb006,oodb005 INTO l_pmdl012,l_pmdl013
           FROM oodb_t,ooef_t
          WHERE ooefent = oodbent
            AND ooef001 = g_site
            AND ooef019 = oodb001
            AND oodbent = g_enterprise
            AND oodb002 = l_pmdl011       #稅別  
      END IF

      #取得匯率 
      IF NOT cl_null(l_pmdl015) THEN
         LET l_ooef016 = ''               #主幣別編號 
         SELECT ooef016 INTO l_ooef016
           FROM ooef_t
          WHERE ooefent = g_enterprise
            AND ooef001 = g_site

         CALL s_apmp490_get_exrate(l_pmdl015,l_ooef016,l_pmdl054)
              RETURNING l_pmdl016
      END IF 
      
      IF cl_null(l_pmdl_ins.pmdl009) THEN     #付款條件  
         LET l_pmdl_ins.pmdl009 = l_pmdl009
      END IF
      IF cl_null(l_pmdl_ins.pmdl010) THEN     #交易條件
         LET l_pmdl_ins.pmdl010 = l_pmdl010
      END IF
      IF cl_null(l_pmdl_ins.pmdl011) THEN     #稅別 
         LET l_pmdl_ins.pmdl011 = l_pmdl011
      END IF
      IF cl_null(l_pmdl_ins.pmdl012) THEN     #稅率 
         LET l_pmdl_ins.pmdl012 = l_pmdl012
      END IF
      IF cl_null(l_pmdl_ins.pmdl013) THEN     #單價含稅否 
         LET l_pmdl_ins.pmdl013 = l_pmdl013
      END IF
      IF cl_null(l_pmdl_ins.pmdl015) THEN     #幣別 
         LET l_pmdl_ins.pmdl015 = l_pmdl015
      END IF
      IF cl_null(l_pmdl_ins.pmdl016) THEN     #匯率 
         LET l_pmdl_ins.pmdl016 = l_pmdl016
      END IF
      IF cl_null(l_pmdl_ins.pmdl017) THEN     #取價方式 
         LET l_pmdl_ins.pmdl017 = l_pmdl017
      END IF
      IF cl_null(l_pmdl_ins.pmdl023) THEN     #採購通路 
         LET l_pmdl_ins.pmdl023 = l_pmdl023
      END IF 
      IF cl_null(l_pmdl_ins.pmdl054) THEN      #內外購 
         LET l_pmdl_ins.pmdl054 = l_pmdl054
      END IF
      IF cl_null(l_pmdl_ins.pmdl033) THEN      #發票類型 
         LET l_pmdl_ins.pmdl033 = l_pmdl033
      END IF
      IF cl_null(l_pmdl_ins.pmdl055) THEN      #匯率計算基礎 
         LET l_pmdl_ins.pmdl055 = l_pmdl055
      END IF

      INSERT INTO p490_03_pmdl_t(pmdl004,pmdl009,pmdl010,pmdl011,pmdl012,
                                 pmdl013,pmdl015,pmdl016,pmdl017,pmdl023,
                                 pmdl054,pmdl033,pmdl055,pmal002,pmdl025,pmdl026)
                          VALUES(l_pmdl_ins.*)

   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 第二步進入第三步前的基本檢查
# Memo...........:
# Usage..........: CALL apmp490_02_basic_chk()
# Date & Author..: 2014/06/18 By ming
# Modify.........:
################################################################################
PUBLIC FUNCTION apmp490_02_basic_chk()
   DEFINE l_sql     STRING
   DEFINE l_pmdl004 LIKE pmdl_t.pmdl004   #供應商   
   DEFINE l_pmdb004 LIKE pmdb_t.pmdb004   #請購料號   
   DEFINE l_pmdn014 LIKE pmdn_t.pmdn014   #到庫日期   
   DEFINE l_pmdn001 LIKE pmdn_t.pmdn001   #採購料號  
   DEFINE l_pmdn002 LIKE pmdn_t.pmdn002   #採購產品特徵  
   DEFINE l_pmdn006 LIKE pmdn_t.pmdn006   #採購單位  
   DEFINE l_pmdn007 LIKE pmdn_t.pmdn007   #採購數量  
   DEFINE l_pmdn008 LIKE pmdn_t.pmdn008   #參考單位 
   DEFINE l_pmdn009 LIKE pmdn_t.pmdn009   #參考數量 
   DEFINE l_pmdn010 LIKE pmdn_t.pmdn010   #計價單位  
   DEFINE l_pmdn011 LIKE pmdn_t.pmdn011   #計價數量   
   DEFINE l_pmdn050 LIKE pmdn_t.pmdn050   #備註 
   DEFINE r_success LIKE type_t.chr1
   DEFINE l_msg     STRING 
   
   WHENEVER ERROR CONTINUE 

   LET l_sql = "SELECT pmdl004,pmdb004,pmdn014,pmdn001,pmdn002, ",
               "       pmdn006,pmdn007,pmdn008,pmdn009,pmdn010, ",
               "       pmdn011,pmdn050 ",
               "  FROM p490_02_pmdn_t "
   PREPARE apmp490_02_basic_chk_prep FROM l_sql
   DECLARE apmp490_02_basic_chk_curs CURSOR FOR apmp490_02_basic_chk_prep

   LET r_success = 'Y'

   CALL cl_err_collect_init()


   LET l_msg = '' 
   
   FOREACH apmp490_02_basic_chk_curs INTO l_pmdl004,l_pmdb004,l_pmdn014,l_pmdn001,l_pmdn002,
                                          l_pmdn006,l_pmdn007,l_pmdn008,l_pmdn009,l_pmdn010,
                                          l_pmdn011,l_pmdn050
      IF STATUS THEN
         CALL cl_errmsg('','','foreach',STATUS,1)
         LET r_success = 'N'
         EXIT FOREACH
      END IF

      LET l_msg = l_pmdb004,";",l_pmdn014

      IF cl_null(l_pmdl004) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = l_msg
         LET g_errparam.code   = 'art-00282'
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         LET r_success = 'N'
      END IF
      IF cl_null(l_pmdn001) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = l_msg
         LET g_errparam.code   = 'apm-00287'
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         LET r_success = 'N'
      END IF
      IF cl_null(l_pmdn006) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = l_msg
         LET g_errparam.code   = 'apm-00288'
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         LET r_success = 'N'
      END IF
      IF cl_null(l_pmdn007) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = l_msg
         LET g_errparam.code   = 'apm-00289'
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         LET r_success = 'N'
      END IF
      
      #加入供應商是否已確認的檢查 
      IF NOT cl_null(l_pmdl004) THEN
         IF NOT apmp490_02_pmdl004_chk(l_pmdl004) THEN
            LET r_success = 'N'
         END IF
      END IF

   END FOREACH

   CALL cl_err_collect_show()
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 供應商基本檢查
# Memo...........:
# Usage..........: CALL apmp490_02_pmdl004_chk(p_pmdl004)
#                  RETURNING r_success
# Input parameter: p_pmdl004：供應商編號
# Return code....: r_success：true/false
# Date & Author..: 2014/06/18 By ming
# Modify.........:
################################################################################
PUBLIC FUNCTION apmp490_02_pmdl004_chk(p_pmdl004)
   DEFINE p_pmdl004     LIKE pmdl_t.pmdl004

   DEFINE l_success    LIKE type_t.num5
   DEFINE l_flag       LIKE type_t.num5
   DEFINE r_success    LIKE type_t.num5

   DEFINE l_pmaastus   LIKE pmaa_t.pmaastus    
   DEFINE l_pmaa004    LIKE pmaa_t.pmaa004   #161230-00019#1
   WHENEVER ERROR CONTINUE 

   LET r_success = TRUE
   LET g_errno = ''

   IF NOT cl_null(p_pmdl004) THEN
      LET l_pmaastus = ''
      #161230-00019#1-s-mod
#      SELECT pmaastus INTO l_pmaastus       
      SELECT pmaastus,pmaa004 INTO l_pmaastus,l_pmaa004
      #161230-00019#1-e-mod
        FROM pmaa_t
       WHERE pmaa001 = p_pmdl004
         AND pmaaent = g_enterprise
         AND (pmaa002 = '1' OR pmaa002 = '3')         
         AND pmaa001 IN (SELECT pmab001 FROM pmab_t WHERE pmabsite = g_site AND pmabent = g_enterprise) #161005-00031#1 add         

      CASE
         WHEN SQLCA.sqlcode = 100   #LET g_errno = 'apm-00024'      #輸入的資料不存在於交易        #161005-00031#1 mark
                                     LET g_errno = 'apm-01055'      #輸入的資料不存在於交易據點檔  #161005-00031#1 add
                                     
         WHEN l_pmaastus <> 'Y'      LET g_errno = 'apm-00200'      #輸入的資料未確認或已無效！ 
         #161230-00019#1-s-add
         WHEN l_pmaa004 = '2'        LET g_errno = 'apm-01155'      #輸入的供應商不可為一次性交易對象，請重新輸入！
         #161230-00019#1-e-add         
         OTHERWISE                   LET g_errno = SQLCA.sqlcode USING '------'
      END CASE

      IF NOT cl_null(g_errno) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = g_errno
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF 
      
      #呼叫s_control_check_supplier做整合檢查 
      CALL s_control_check_supplier(p_pmdl004,'4',g_site,g_user,g_dept,g_apmp490_01_input.pmdldocno)
           RETURNING l_success
      IF NOT l_success THEN
         LET r_success = l_success
      END IF
      
   END IF
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: apmp490_02_pmdn001_chk(p_pmdn001,p_pmdb004,p_pmdl004,p_pmdn002,p_pmdb005)
#                  RETURNING r_success
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: r_success
# Date & Author..: 2014/06/18 By ming
# Modify.........:
################################################################################
PUBLIC FUNCTION apmp490_02_pmdn001_chk(p_pmdn001,p_pmdb004,p_pmdl004,p_pmdn002,p_pmdb005)
   DEFINE p_pmdn001     LIKE pmdn_t.pmdn001
   DEFINE p_pmdb004     LIKE pmdb_t.pmdb004
   DEFINE p_pmdl004     LIKE pmdl_t.pmdl004 
   DEFINE p_pmdn002     LIKE pmdn_t.pmdn002
   DEFINE p_pmdb005     LIKE pmdn_t.pmdn005

   DEFINE l_flag        LIKE type_t.num5
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_ooba002     LIKE ooba_t.ooba002
   DEFINE l_pmdp007     LIKE pmdp_t.pmdp007
   DEFINE r_success     LIKE type_t.num5

   DEFINE l_imaastus    LIKE imaa_t.imaastus 
   
   WHENEVER ERROR CONTINUE 

   LET r_success = TRUE

   LET g_errno = ''
   LET l_imaastus = ''

   IF NOT cl_null(p_pmdn001) THEN
      #改用r.v檢查 
      INITIALIZE g_chkparam.* TO NULL
      LET g_chkparam.arg1 = p_pmdn001      
      IF NOT cl_chk_exist("v_imaf001_14") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF

      #呼叫s_control_check_item做整合檢查 
      CALL s_control_check_item(p_pmdn001,'4',g_site,g_user,g_dept,g_apmp490_01_input.pmdldocno)
           RETURNING l_success
      IF NOT l_success THEN
         LET r_success = l_success
         RETURN r_success
      END IF

      #若單據別設置是要作請採勾稽時，則修改料號時必須檢核是否與"關聯單據明細"中的來源料號有替代關係
      IF cl_get_doc_para(g_enterprise,g_site,g_apmp490_01_input.pmdldocno,'D-BAS-0061') = "Y" THEN
         IF p_pmdb004 <> p_pmdn001 THEN
            #add by lixiang 2015/07/16----s------
            #請採購替代是否依據BOM替代資料
            #選Y時，代表請購轉採購時可以依據BOM替代資料進行採購料的替代
            #若選N，則是依據apmi131採購替代原則的設定進行採購料的替代
            IF cl_get_doc_para(g_enterprise,g_site,g_apmp490_01_input.pmdldocno,'D-BAS-0096') = "Y" THEN
               IF NOT s_apmt500_chk_bom_replace(p_pmdb004,p_pmdn001,p_pmdn002) THEN
                  LET r_success = FALSE
                  RETURN r_success
               END IF
            ELSE      
            #add by lixiang 2015/07/16----e------
               IF NOT s_pmaq_chk_replacement(p_pmdl004,p_pmdb004,p_pmdn001,'2',p_pmdb005,p_pmdn002) THEN
                  LET r_success = FALSE
                  RETURN r_success
               END IF
            END IF
         END IF
      END IF

   END IF
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apmp490_02_set_entry_b(p_ac)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2014/06/18 By ming
# Modify.........:
################################################################################
PUBLIC FUNCTION apmp490_02_set_entry_b(p_ac)
   DEFINE p_ac     LIKE type_t.num5   
   
   WHENEVER ERROR CONTINUE 
  
   CALL cl_set_comp_entry("pmdn002_02_01",TRUE)
   
   CALL cl_set_comp_entry("pmdn028_02_01,pmdn029_02_01",TRUE)  #161006-00018#21

END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apmp490_02_set_no_entry_b(p_ac)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2014/06/18 By ming
# Modify.........:
################################################################################
PUBLIC FUNCTION apmp490_02_set_no_entry_b(p_ac)
   DEFINE p_ac          LIKE type_t.num5
   DEFINE l_imaa005     LIKE imaa_t.imaa005 
   #161006-00018#21-S
   DEFINE l_flag        LIKE type_t.num5
   DEFINE l_ooac002     LIKE ooac_t.ooac002
   DEFINE l_ooac004     LIKE ooac_t.ooac004
   DEFINE l_pmdb038     LIKE pmdb_t.pmdb038
   DEFINE l_pmdb039     LIKE pmdb_t.pmdb039
   DEFINE l_inaa007     LIKE inaa_t.inaa007
   #161006-00018#21-E
   WHENEVER ERROR CONTINUE 
  
   #料件不使用產品特徵時，產品特徵欄位不可錄入
   LET l_imaa005 = ''
   SELECT imaa005 INTO l_imaa005
     FROM imaa_t
    WHERE imaaent = g_enterprise
      AND imaa001 = g_pmdn_d[p_ac].pmdn001_02_01
   IF cl_null(l_imaa005) THEN
      CALL cl_set_comp_entry("pmdn002_02_01",FALSE)
      LET g_pmdn_d[p_ac].pmdn002_02_01 = ' '
   ELSE
      IF cl_null(g_pmdn_d[p_ac].pmdn002_02_01) THEN
         LET g_pmdn_d[p_ac].pmdn002_02_01 = ''
      END IF
   END IF
   #161006-00018#21-S
   IF p_ac <> 0 THEN
      IF NOT cl_null(g_pmdn_d[p_ac].pmdbdocno_02_01) THEN
         CALL s_aooi200_get_slip(g_apmp490_01_input.pmdldocno) RETURNING l_flag,l_ooac002
         CALL cl_get_doc_para(g_enterprise,g_site,l_ooac002,'D-MFG-0085') RETURNING l_ooac004
         IF l_ooac004 = 'N' THEN      #不可以修改
            SELECT pmdb038,pmdb039 INTO l_pmdb038,l_pmdb039 FROM pmdb_t
             WHERE pmdbent = g_enterprise
               AND pmdbdocno = g_pmdn_d[p_ac].pmdbdocno_02_01
               AND pmdbseq = g_pmdn_d[p_ac].pmdbseq_02_01
            IF NOT cl_null(l_pmdb038) THEN
               CALL cl_set_comp_entry("pmdn028_02_01",FALSE)
            END IF
            IF NOT cl_null(l_pmdb039) THEN
               CALL cl_set_comp_entry("pmdn029_02_01",FALSE)
            END IF            
         END IF
         SELECT inaa007 INTO l_inaa007 FROM inaa_t 
          WHERE inaaent = g_enterprise
            AND inaasite = g_site
            AND inaa001 = g_pmdn_d[p_ac].pmdn028_02_01
         IF l_inaa007 = '5' THEN
            CALL cl_set_comp_entry("pmdn029_02_01",FALSE) 
         END IF         
      END IF            
   END IF
   #161006-00018#21-E
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apmp490_02_unit_chk(p_pmdn006)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2014/06/18 By ming
# Modify.........:
################################################################################
PUBLIC FUNCTION apmp490_02_unit_chk(p_pmdn006)
   DEFINE p_pmdn006     LIKE pmdn_t.pmdn006
   DEFINE l_oocastus    LIKE ooca_t.oocastus 
   
   WHENEVER ERROR CONTINUE 

   LET g_errno = ''
   LET l_oocastus = ''

   SELECT oocastus INTO l_oocastus
     FROM ooca_t
    WHERE ooca001 = p_pmdn006
      AND oocaent = g_enterprise

   CASE
      WHEN SQLCA.sqlcode = 100    LET g_errno = 'aim-00004'     #輸入的資料不存在於[單位資料檔]中！ 
      WHEN l_oocastus <> 'Y'      LET g_errno = 'sub-01302'     #輸入的資料無效！ #aim-00005  #160318-00005#35  By 07900--mod
      OTHERWISE                   LET g_errno = SQLCA.sqlcode USING '------'
   END CASE
END FUNCTION

################################################################################
# Descriptions...: #根據單位取位類型對數量進行取位
# Memo...........:
# Usage..........: CALL apmp490_02_unit_round(p_unit,p_qty)
#                  RETURNING 回传参数
# Input parameter: p_unit：單位
#                : p_qty ：數量
# Return code....: r_qty ：數量
# Date & Author..: 2014/06/18 By ming
# Modify.........:
################################################################################
PUBLIC FUNCTION apmp490_02_unit_round(p_unit,p_qty)
   DEFINE p_unit     LIKE pmdn_t.pmdn006
   DEFINE p_qty      LIKE pmdn_t.pmdn007
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_ooca002   LIKE ooca_t.ooca002      #小数位数
   DEFINE l_ooca004   LIKE ooca_t.ooca004      #舍入类型 
   DEFINE r_qty       LIKE pmdn_t.pmdn007      #數量 
   
   WHENEVER ERROR CONTINUE 

   LET l_success = NULL
   LET l_ooca002 = 0
   LET l_ooca004 = NULL
   LET r_qty     = 0

   #抓取單位檔中的小數位數和捨入類型  
   IF NOT cl_null(p_unit) THEN
      CALL s_aooi250_get_msg(p_unit) RETURNING l_success,l_ooca002,l_ooca004
      IF l_success THEN
         IF NOT cl_null(p_qty) THEN
            CALL s_num_round(l_ooca004,p_qty,l_ooca002) RETURNING r_qty
            RETURN r_qty
         END IF
      END IF
   END IF
   RETURN r_qty
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apmp490_02_default()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2014/06/18 By ming
# Modify.........:
################################################################################
PUBLIC FUNCTION apmp490_02_default()
   
   WHENEVER ERROR CONTINUE 
   
   LET g_apmp490_02_input.scb01 = 1
   LET g_apmp490_02_input.bt01 = ''
   LET g_apmp490_02_input.ed01 = ''
   LET g_apmp490_02_input.scb02 = 1
   LET g_apmp490_02_input.scb03 = 3

   CASE g_apmp490_02_input.scb03
      WHEN '0'           #一個月   
         LET g_mm = 1
      WHEN '1'           #兩個月  
         LET g_mm = 2
      WHEN '2'           #三個月  
         LET g_mm = 3
      WHEN '3'           #六個月   
         LET g_mm = 6
      WHEN '4'           #一年  
         LET g_mm = 12
   END CASE

   CALL g_pmdn_d.clear()
   CALL g_apmp490_02_pmdn_d.clear()
   CALL g_apmp490_02_pmds_d.clear()
   CALL g_apmp490_02_qcba_d.clear()
END FUNCTION

PUBLIC FUNCTION apmp490_02_bt01_ref(p_pmdl004)
   DEFINE p_pmdl004    LIKE pmdl_t.pmdl004
   DEFINE r_pmaal004   LIKE pmaal_t.pmaal004 
   
   WHENEVER ERROR CONTINUE 

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_pmdl004
   CALL ap_ref_array2(g_ref_fields,
                      "SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002= '"||g_dlang||"'",
                      "")
        RETURNING g_rtn_fields
   LET r_pmaal004 = '', g_rtn_fields[1] , ''
   RETURN r_pmaal004
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apmp490_02_get_imaal(p_imaal001)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2014/06/18 By ming
# Modify.........:
################################################################################
PUBLIC FUNCTION apmp490_02_get_imaal(p_imaal001)
   DEFINE p_imaal001     LIKE imaal_t.imaal001
   DEFINE r_imaal003     LIKE imaal_t.imaal003
   DEFINE r_imaal004     LIKE imaal_t.imaal004 
   
   WHENEVER ERROR CONTINUE 

   LET r_imaal003 = ''
   LET r_imaal004 = ''

   SELECT imaal003,imaal004 INTO r_imaal003,r_imaal004
     FROM imaal_t
    WHERE imaalent = g_enterprise
      AND imaal001 = p_imaal001
      AND imaal002 = g_dlang

   RETURN r_imaal003,r_imaal004
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apmp490_02_get_pmaal004(p_pmaal001)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2014/06/18 By ming
# Modify.........:
################################################################################
PUBLIC FUNCTION apmp490_02_get_pmaal004(p_pmaal001)
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
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apmp490_02_ins_pmdb(p_link_no,p_pmdb004,p_pmdb005,p_pmda024,p_pmda025,p_pmdn058,p_pmdn036,p_pmdn037,p_pmdn038,p_pmdn028,p_pmdn029,p_pmdn053,p_pmdb050,p_ooff013,p_ooff014,p_pmdbdocno,p_pmdbseq,p_qty)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2014/06/18 By ming
# Modify.........:  #160801-00004#3 by lixiang 增加 p_pmdn028,p_pmdn029,p_pmdn053
#                :  #161031-00025#6 by shiun   增加 p_ooff013,p_ooff014
################################################################################
PUBLIC FUNCTION apmp490_02_ins_pmdb(p_link_no,p_pmdb004,p_pmdb005,p_pmda024,p_pmda025,p_pmdn058,p_pmdn036,p_pmdn037,p_pmdn038,p_pmdn028,p_pmdn029,p_pmdn053,p_pmdb050,p_ooff013,p_ooff014,p_pmdbdocno,p_pmdbseq,p_qty)
   DEFINE p_link_no     LIKE type_t.num10
   DEFINE p_pmdb004     LIKE pmdb_t.pmdb004
   DEFINE p_pmdb005     LIKE pmdb_t.pmdb005 
   DEFINE p_pmda024     LIKE pmda_t.pmda024
   DEFINE p_pmda025     LIKE pmda_t.pmda025
   DEFINE p_pmdn058     LIKE pmdn_t.pmdn058
   DEFINE p_pmdn036     LIKE pmdn_t.pmdn036
   DEFINE p_pmdn037     LIKE pmdn_t.pmdn037
   DEFINE p_pmdn038     LIKE pmdn_t.pmdn038
   DEFINE p_pmdbdocno   LIKE pmdb_t.pmdbdocno
   DEFINE p_pmdbseq     LIKE pmdb_t.pmdbseq
   DEFINE p_pmdb050     LIKE pmdb_t.pmdb050
   DEFINE p_ooff013     LIKE ooff_t.ooff013   #161031-00025#6
   DEFINE p_ooff014     LIKE ooff_t.ooff014   #161031-00025#6
   DEFINE p_qty         LIKE pmdb_t.pmdb006
   DEFINE l_sql         STRING
   DEFINE l_pmdbdocno   LIKE pmdb_t.pmdbdocno
   DEFINE l_pmdbseq     LIKE pmdb_t.pmdbseq
   DEFINE l_pmdb004     LIKE pmdb_t.pmdb004
   DEFINE l_pmdb005     LIKE pmdb_t.pmdb005
   DEFINE l_pmdb007     LIKE pmdb_t.pmdb007
   DEFINE l_pmdb006     LIKE pmdb_t.pmdb006
   DEFINE l_qty         LIKE pmdb_t.pmdb006
   DEFINE l_pmdb030     LIKE pmdb_t.pmdb030
   DEFINE l_pmdb033     LIKE pmdb_t.pmdb033
   DEFINE l_pmdb014     LIKE pmdb_t.pmdb014
   DEFINE l_pmdb015     LIKE pmdb_t.pmdb015 
   DEFINE l_pmdb050     LIKE pmdb_t.pmdb050
   DEFINE l_applied_qty LIKE type_t.num10
   DEFINE l_qty_w       LIKE pmdb_t.pmdb006 
   DEFINE r_success     LIKE type_t.num5      #回傳結果   
   DEFINE l_pmda024     LIKE pmda_t.pmda024
   DEFINE l_pmda025     LIKE pmda_t.pmda025
   DEFINE l_pmdb053     LIKE pmdb_t.pmdb053
   DEFINE l_pmdb034     LIKE pmdb_t.pmdb034
   DEFINE l_pmdb035     LIKE pmdb_t.pmdb035
   DEFINE l_pmdb036     LIKE pmdb_t.pmdb036
   #160801-00004#3--s
   DEFINE p_pmdn028     LIKE pmdn_t.pmdn028
   DEFINE p_pmdn029     LIKE pmdn_t.pmdn029
   DEFINE p_pmdn053     LIKE pmdn_t.pmdn053
   DEFINE l_pmdb038     LIKE pmdb_t.pmdb038
   DEFINE l_pmdb039     LIKE pmdb_t.pmdb039
   DEFINE l_pmdb054     LIKE pmdb_t.pmdb054
   #160801-00004#3--e    
   DEFINE l_ooff013     LIKE ooff_t.ooff013   #161031-00025#6
   DEFINE l_ooff014     LIKE ooff_t.ooff014   #161031-00025#6
               
   WHENEVER ERROR CONTINUE 
   
   #由此function做分配的檢查 
   #如果已分配完畢 就不可產生分配的資料 
   LET r_success = FALSE

   LET l_sql = "SELECT pmdbdocno,pmdbseq,pmdb004,pmdb005,pmdb007,",
               "       pmdb006,qty,pmdb030,pmdb033,pmdb014,pmdb015,",
               "       pmda024,pmda025, ",
               "       pmdb053, ",
               "       pmdb034,pmdb035,pmdb036, ",
               "       pmdb038,pmdb039,pmdb054, ",   #160801-00004#3
               #161031-00025#6-s-mod
#               "       pmdb050, applied_qty ",
               "       pmdb050,ooff013,ooff014,applied_qty ",
               #161031-00025#6-e-mod
               "  FROM p490_01_pmdb_t ",
               " WHERE pmdb004 = '",p_pmdb004,"' ",
               "   AND pmdb005 = '",p_pmdb005,"' ",
               "   AND NVL(pmda024,' ') = NVL('",p_pmda024,"',' ') ",
               "   AND NVL(pmda025,' ') = NVL('",p_pmda025,"',' ') ",
               "   AND NVL(pmdb053,' ') = NVL('",p_pmdn058,"',' ') ",
               "   AND NVL(pmdb034,' ') = NVL('",p_pmdn036,"',' ') ",
               "   AND NVL(pmdb035,' ') = NVL('",p_pmdn037,"',' ') ",
               "   AND NVL(pmdb036,' ') = NVL('",p_pmdn038,"',' ') ",
               #160801-00004#3--s
               "   AND NVL(pmdb038,' ') = NVL('",p_pmdn028,"',' ') ",
               "   AND NVL(pmdb039,' ') = NVL('",p_pmdn029,"',' ') ",
               "   AND NVL(pmdb054,' ') = NVL('",p_pmdn053,"',' ') "
               #160801-00004#3--e              

   IF g_apmp490_02_input.scb02 = '3' THEN
      LET l_sql = l_sql, "   AND NVL(pmdbdocno,' ') = NVL('",p_pmdbdocno,"',' ') ",
                         "   AND NVL(pmdbseq,'0') = NVL('",p_pmdbseq,"','0') "
   END IF

   LET l_sql = l_sql,"   AND NVL(pmdb050,' ') = NVL('",p_pmdb050,"',' ') ",
                     "   AND NVL(ooff013,' ') = NVL('",p_ooff013,"',' ') ",   #161031-00025#6
                     " ORDER BY pmdb030 "
   
   PREPARE p490_02_ins_02_pmdb_prep FROM l_sql
   DECLARE p490_02_ins_02_pmdb_curs CURSOR WITH HOLD FOR p490_02_ins_02_pmdb_prep 
   
   FOREACH p490_02_ins_02_pmdb_curs INTO l_pmdbdocno,l_pmdbseq,l_pmdb004,l_pmdb005,
                                         l_pmdb007,l_pmdb006,l_qty,l_pmdb030,
                                         l_pmdb033,l_pmdb014,l_pmdb015,l_pmda024,l_pmda025, 
                                         l_pmdb053,
                                         l_pmdb034,l_pmdb035,l_pmdb036,
                                         l_pmdb038,l_pmdb039,l_pmdb054,  #160801-00004#3
                                         #161031-00025#6-s-mod
#                                         l_pmdb050,l_applied_qty
                                         l_pmdb050,l_ooff013,l_ooff014,l_applied_qty
                                         #161031-00025#6-e-mod
      IF STATUS THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = STATUS
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      #如果未轉採購量等於已分配的數量 就代表此請購資料已經被分配完畢 
      IF l_qty = l_applied_qty THEN
         CONTINUE FOREACH
      END IF

      LET l_qty = l_qty - l_applied_qty   #取得未分配的數量總數   

      IF p_qty > l_qty THEN
         LET l_qty_w = l_qty              #取得真正要寫入的數量  
         LET p_qty = p_qty - l_qty        #計算剩餘需分配的數量  
      ELSE
         LET l_qty_w = p_qty
         LET p_qty = 0
      END IF

      #有寫入新底稿的情況 就是有資料可以分配  
      LET r_success = TRUE

      INSERT INTO p490_02_pmdb_t(link_no,pmdbdocno,pmdbseq,pmdb004,pmdb005,
                                 pmdb007,pmdb006,qty,pmdb030,pmdb033,pmdb014,
                                 pmdb015,pmda024,pmda025,pmdn058,pmdn036,pmdn037,pmdn038,
                                 pmdn028,pmdn029,pmdn053,  #160801-00004#3
                                 #161031-00025#6-s-mod
#                                 pmdb050)
                                 pmdb050,ooff013,ooff014)
                                 #161031-00025#6-e-mod
                          VALUES(p_link_no,l_pmdbdocno,l_pmdbseq,l_pmdb004,
                                 l_pmdb005,l_pmdb007,l_pmdb006,l_qty_w,l_pmdb030, 
                                 l_pmdb033,l_pmdb014,l_pmdb015,l_pmda024,l_pmda025,
                                 l_pmdb053,l_pmdb034,l_pmdb035,l_pmdb036,
                                 l_pmdb038,l_pmdb039,l_pmdb054,  #160801-00004#3
                                 #161031-00025#6-s-mod
#                                 l_pmdb050)
                                 l_pmdb050,l_ooff013,l_ooff014)
                                 #161031-00025#6-e-mod

      #更新已分配的數量 
      UPDATE p490_01_pmdb_t SET applied_qty = applied_qty + l_qty_w
       WHERE pmdbdocno = l_pmdbdocno
         AND pmdbseq = l_pmdbseq

      IF p_qty <=0 THEN
         EXIT FOREACH
      END IF
   END FOREACH 
   
   RETURN r_success
   
END FUNCTION

################################################################################
# Descriptions...: 單位轉換，統一寫在一個function之中，以後如果再有aimi190改aooi250的這種情況就不必改很多地方 
# Memo...........:
# Usage..........: CALL apmp490_02_convert_qty(p_imaa001,p_from_unit,p_to_unit,p_qty)
#                  RETURNING r_qty
# Input parameter: p_imaa001  ：料號 
#                : p_from_unit：來源單位 
#                : p_to_unit  ：目的單位 
#                : p_qty      ：數量 
# Return code....: r_qty      ：要回傳的結果 
# Date & Author..: 2015/01/05 By ming
# Modify.........:
################################################################################
PUBLIC FUNCTION apmp490_02_convert_qty(p_imaa001,p_from_unit,p_to_unit,p_qty)
   DEFINE p_imaa001     LIKE imaa_t.imaa001     #料號 
   DEFINE p_from_unit   LIKE inag_t.inag007     #來源單位 
   DEFINE p_to_unit     LIKE inag_t.inag007     #目的單位
   DEFINE p_qty         LIKE inag_t.inag008     #數量 
   DEFINE l_success     LIKE type_t.num5
   DEFINE r_qty         LIKE inag_t.inag008     #要回傳的結果  
   
   WHENEVER ERROR CONTINUE 

   LET r_qty = 0

   CALL s_aooi250_convert_qty(p_imaa001,p_from_unit,p_to_unit,p_qty)
        RETURNING l_success,r_qty

   IF (NOT l_success) OR cl_null(r_qty) THEN
      LET r_qty = 0
   END IF 
   
   #沒有單位轉換率的話,要報錯
   IF NOT l_success THEN
      LET g_errparam.code   = 'sub-00015'     #沒有設定%1與%2的單位轉換資料 
      LET g_errparam.extend = p_imaa001
      LET g_errparam.popup  = TRUE
      LET g_errparam.replace[1] = p_from_unit
      LET g_errparam.replace[2] = p_to_unit
      CALL cl_err()
   END IF


   RETURN r_qty
END FUNCTION

################################################################################
# Descriptions...: 輸入上方單身資料
# Memo...........:
# Usage..........: CALL apmp490_02_b()
# Date & Author..: 2014/06/18 By ming
# Modify.........: 2015/12/21 By ming 移除已註解的CALL apmp490_02_pmdn001_desc
#                : #151118-00029#1 2016/01/12 by ming 補上紅叉叉，加入on action cancel並回復舊值
#                : #160323-00001#1 2016/04/29 by ming 補上採購部分的產品特徵開窗
################################################################################
PUBLIC FUNCTION apmp490_02_b()
   DEFINE l_ac1     LIKE type_t.num5
   DEFINE l_sql     STRING
   DEFINE l_success LIKE type_t.num5
   DEFINE l_pmdn_t  type_g_pmdn_d
   DEFINE l_rate    LIKE inaj_t.inaj014 
   DEFINE l_qty     LIKE pmdn_t.pmdn007       #用來記錄單位換算後的數量  
   #160323-00001#1 20160429 add by ming -----(S) 
   DEFINE l_imaa005 LIKE imaa_t.imaa005       #產品特徵組別 
   #160323-00001#1 20160429 add by ming -----(E) 
   DEFINE l_pmdn0071 LIKE pmdn_t.pmdn007   #160908-00029#1
   WHENEVER ERROR CONTINUE 

   DIALOG ATTRIBUTES(UNBUFFERED)
      INPUT ARRAY g_pmdn_d FROM s_apmp490_02_detail1.*
            ATTRIBUTE(COUNT = g_d_cnt_p49002_01,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                      INSERT ROW = FALSE,
                      DELETE ROW = TRUE,
                      APPEND ROW = FALSE)
         BEFORE INPUT

         BEFORE ROW
            LET l_ac1 = ARR_CURR()
            LET l_pmdn_t.* = g_pmdn_d[l_ac1].*

            CALL apmp490_02_set_entry_b(l_ac1)
            #161006-00018#21-S
            CALL apmp490_02_set_no_required_b(l_ac1)
            CALL apmp490_02_set_required_b(l_ac1)
            #161006-00018#21-E
            CALL apmp490_02_set_no_entry_b(l_ac1)

         AFTER FIELD pmdl004_02_01   #供應商編號   
            CALL apmp490_02_get_pmaal004(g_pmdn_d[l_ac1].pmdl004_02_01)
                 RETURNING g_pmdn_d[l_ac1].pmaal004_02_01
            DISPLAY BY NAME g_pmdn_d[l_ac1].pmaal004_02_01 

            IF NOT cl_null(g_pmdn_d[l_ac1].pmdl004_02_01) THEN
               IF g_pmdn_d[l_ac1].pmdl004_02_01 != l_pmdn_t.pmdl004_02_01 OR
                  l_pmdn_t.pmdl004_02_01 IS NULL THEN
                  IF g_pmdn_d[l_ac1].pmdb014_02_01 = '3' THEN
                     LET g_pmdn_d[l_ac1].pmdl004_02_01 = l_pmdn_t.pmdl004_02_01
                     CALL apmp490_02_get_pmaal004(g_pmdn_d[l_ac1].pmdl004_02_01)
                          RETURNING g_pmdn_d[l_ac1].pmaal004_02_01
                     DISPLAY BY NAME g_pmdn_d[l_ac1].pmaal004_02_01
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apm-00537'     #請購單已指定供應商，不可修改！ 
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
      
                     NEXT FIELD CURRENT
                  END IF

                  IF NOT apmp490_02_pmdl004_chk(g_pmdn_d[l_ac1].pmdl004_02_01) THEN

                     NEXT FIELD CURRENT
                  END IF

               END IF
            END IF 

         AFTER FIELD pmdn001_02_01   #採購料件編號  
            CALL apmp490_02_get_imaal(g_pmdn_d[l_ac1].pmdn001_02_01)
                 RETURNING g_pmdn_d[l_ac1].imaal003_02_01_2,g_pmdn_d[l_ac1].imaal004_02_01_2
            DISPLAY BY NAME g_pmdn_d[l_ac1].imaal003_02_01_2,g_pmdn_d[l_ac1].imaal004_02_01_2

            IF NOT cl_null(g_pmdn_d[l_ac1].pmdn001_02_01) THEN
               IF g_pmdn_d[l_ac1].pmdn001_02_01 != l_pmdn_t.pmdn001_02_01 OR
                  l_pmdn_t.pmdn001_02_01 IS NULL THEN
                  IF NOT apmp490_02_pmdn001_chk(g_pmdn_d[l_ac1].pmdn001_02_01,
                                                g_pmdn_d[l_ac1].pmdb004_02_01,
                                                g_pmdn_d[l_ac1].pmdl004_02_01,
                                                g_pmdn_d[l_ac1].pmdn002_02_01,
                                                g_pmdn_d[l_ac1].pmdb004_02_01) THEN

                     NEXT FIELD CURRENT
                  END IF

               END IF
            END IF

            CALL apmp490_02_set_entry_b(l_ac1)
            #161006-00018#21-S
            CALL apmp490_02_set_no_required_b(l_ac1)
            CALL apmp490_02_set_required_b(l_ac1)
            #161006-00018#21-E            
            CALL apmp490_02_set_no_entry_b(l_ac1)

         AFTER FIELD pmdn002_02_01   #產品特徵  
            #如果產品特徵沒有輸入的話，要設定為一個空白 
            IF cl_null(g_pmdn_d[l_ac1].pmdn002_02_01) THEN
               LET g_pmdn_d[l_ac1].pmdn002_02_01 = ' '
            END IF
            
            #取得產品特徵說明 
            CALL s_feature_description(g_pmdn_d[l_ac1].pmdn001_02_01,g_pmdn_d[l_ac1].pmdn002_02_01)
                 RETURNING l_success,g_pmdn_d[l_ac1].pmdn002_02_01_desc
            #產品特徵的基本檢查  
            IF NOT cl_null(g_pmdn_d[l_ac1].pmdn002_02_01) THEN
               IF NOT s_feature_check(g_pmdn_d[l_ac1].pmdn001_02_01,g_pmdn_d[l_ac1].pmdn002_02_01) THEN
                  LET g_pmdn_d[l_ac1].pmdn002_02_01 = l_pmdn_t.pmdn002_02_01
                  CALL s_feature_description(g_pmdn_d[l_ac1].pmdn001_02_01,g_pmdn_d[l_ac1].pmdn002_02_01)
                       RETURNING l_success,g_pmdn_d[l_ac1].pmdn002_02_01_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
         
            IF NOT cl_null(g_pmdn_d[l_ac1].pmdn002_02_01) THEN
               IF g_pmdn_d[l_ac1].pmdn002_02_01 != l_pmdn_t.pmdn002_02_01 OR
                  l_pmdn_t.pmdn002_02_01 IS NULL THEN
                  #2.呼叫產品特徵檢核應用元件，檢核輸入的產品特徵值是否合理
                  #3.當請採勾稽時，採購料號+採購產品特徵與請購料號+請購產品特徵不一樣時，必須檢核是否與請購料號+
                  #  請購產品特徵有替代關係，若沒有則不允許修改

               END IF
            END IF 

         AFTER FIELD pmdn006_02_01   #採購單位  
            IF NOT cl_null(g_pmdn_d[l_ac1].pmdn006_02_01) THEN
               IF g_pmdn_d[l_ac1].pmdn006_02_01 != l_pmdn_t.pmdn006_02_01 OR
                  l_pmdn_t.pmdn006_02_01 IS NULL THEN
                  CALL apmp490_02_unit_chk(g_pmdn_d[l_ac1].pmdn006_02_01)

                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     #160318-00005#35  By 07900 --add-str
                    LET g_errparam.replace[1] ='aooi250'
                    LET g_errparam.replace[2] = cl_get_progname("aooi250",g_lang,"2")
                    LET g_errparam.exeprog ='aooi250'
                    #160318-00005#35  By 07900 --add-end
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD CURRENT
                  END IF 
                  
                  #單位改變後,數量要重新推算 
                  CALL apmp490_02_convert_qty(g_pmdn_d[l_ac1].pmdb004_02_01,     #料號  
                                              g_pmdn_d[l_ac1].pmdb007_02_01,     #來源單位  
                                              g_pmdn_d[l_ac1].pmdn006_02_01,     #目的單位  
                                              g_pmdn_d[l_ac1].pmdn007_02_01)     #數量  
                       RETURNING g_pmdn_d[l_ac1].pmdn007_02_01


                  IF NOT cl_null(g_pmdn_d[l_ac1].pmdn007_02_01) THEN
                     CALL apmp490_02_unit_round(g_pmdn_d[l_ac1].pmdn006_02_01,g_pmdn_d[l_ac1].pmdn007_02_01)
                          RETURNING g_pmdn_d[l_ac1].pmdn007_02_01
                     DISPLAY BY NAME g_pmdn_d[l_ac1].pmdn007_02_01

                     #若參數有使用計價單位時，則輸入[C:需求數量]時則應自動推算計價數量，
                     #[C:計價數量]=[C:需求數量]*[C:單位]與[C:計價單位]換算率
                     IF cl_get_para(g_enterprise,g_site,'S-BAS-0019') = "Y" THEN  #體參數使用採購計價單位
                        CALL apmp490_02_convert_qty(g_pmdn_d[l_ac1].pmdn001_02_01,
                                                    g_pmdn_d[l_ac1].pmdn006_02_01,
                                                    g_pmdn_d[l_ac1].pmdn010_02_01,
                                                    g_pmdn_d[l_ac1].pmdn007_02_01)
                             RETURNING g_pmdn_d[l_ac1].pmdn011_02_01
                        IF NOT cl_null(g_pmdn_d[l_ac1].pmdn011_02_01) THEN
                           CALL apmp490_02_unit_round(g_pmdn_d[l_ac1].pmdn010_02_01,g_pmdn_d[l_ac1].pmdn011_02_01)
                                RETURNING g_pmdn_d[l_ac1].pmdn011_02_01
                           DISPLAY BY NAME g_pmdn_d[l_ac1].pmdn011_02_01
                        END IF
                     END IF
                  END IF 
               END IF
            END IF 
            
            CALL s_desc_get_unit_desc(g_pmdn_d[l_ac1].pmdn006_02_01)
                 RETURNING g_pmdn_d[l_ac1].pmdn006_02_01_desc

         AFTER FIELD pmdn007_02_01   #採購數量  
            IF NOT cl_null(g_pmdn_d[l_ac1].pmdn007_02_01) THEN
               IF g_pmdn_d[l_ac1].pmdn007_02_01 <= 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ade-00016'   #數量不可小於等於0  
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
   
                  NEXT FIELD CURRENT
               END IF 
               
               LET l_qty = g_pmdn_d[l_ac1].pmdn007_02_01
               IF g_pmdn_d[l_ac1].pmdb007_02_01 != g_pmdn_d[l_ac1].pmdn006_02_01 THEN
                  CALL apmp490_02_convert_qty(g_pmdn_d[l_ac1].pmdb004_02_01,g_pmdn_d[l_ac1].pmdn006_02_01,
                                              g_pmdn_d[l_ac1].pmdb007_02_01,l_qty)
                       RETURNING l_qty
               END IF

               #如果採購數量乘上轉換率後，超過未轉採購量的數量，就算錯 
               IF l_qty > g_pmdn_d[l_ac1].qty_02_01 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'apm-00699'     #數量不可大於未轉採購量！  
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()

                  NEXT FIELD CURRENT
               END IF

               CALL apmp490_02_unit_round(g_pmdn_d[l_ac1].pmdn006_02_01,g_pmdn_d[l_ac1].pmdn007_02_01)
                    RETURNING g_pmdn_d[l_ac1].pmdn007_02_01
               DISPLAY BY NAME g_pmdn_d[l_ac1].pmdn007_02_01

               IF cl_get_para(g_enterprise,g_site,'S-BAS-0028') = 'Y' THEN
                  IF NOT cl_null(g_pmdn_d[l_ac1].pmdn001_02_01) AND
                     NOT cl_null(g_pmdn_d[l_ac1].pmdn006_02_01) AND
                     NOT cl_null(g_pmdn_d[l_ac1].pmdn008_02_01) THEN
                     CALL apmp490_02_convert_qty(g_pmdn_d[l_ac1].pmdn001_02_01,g_pmdn_d[l_ac1].pmdn006_02_01,
                                                 g_pmdn_d[l_ac1].pmdn008_02_01,g_pmdn_d[l_ac1].pmdn007_02_01)
                          RETURNING g_pmdn_d[l_ac1].pmdn009_02_01
                     IF NOT cl_null(g_pmdn_d[l_ac1].pmdn009_02_01) THEN
                        CALL apmp490_02_unit_round(g_pmdn_d[l_ac1].pmdn008_02_01,g_pmdn_d[l_ac1].pmdn009_02_01)
                             RETURNING g_pmdn_d[l_ac1].pmdn009_02_01
                        DISPLAY BY NAME g_pmdn_d[l_ac1].pmdn009_02_01
                     END IF

                  END IF
               END IF

               #若參數有使用計價單位時，則輸入[C:需求數量]時則應自動推算計價數量，
               #[C:計價數量]=[C:需求數量]*[C:單位]與[C:計價單位]換算率 
               IF cl_get_para(g_enterprise,g_site,'S-BAS-0019') = "Y" THEN  #體參數使用採購計價單位
                  CALL apmp490_02_convert_qty(g_pmdn_d[l_ac1].pmdn001_02_01,g_pmdn_d[l_ac1].pmdn006_02_01,
                                              g_pmdn_d[l_ac1].pmdn010_02_01,g_pmdn_d[l_ac1].pmdn007_02_01)
                       RETURNING g_pmdn_d[l_ac1].pmdn011_02_01
                  IF NOT cl_null(g_pmdn_d[l_ac1].pmdn011_02_01) THEN
                     CALL apmp490_02_unit_round(g_pmdn_d[l_ac1].pmdn010_02_01,g_pmdn_d[l_ac1].pmdn011_02_01)
                          RETURNING g_pmdn_d[l_ac1].pmdn011_02_01
                     DISPLAY BY NAME g_pmdn_d[l_ac1].pmdn011_02_01
                  END IF
               END IF
               #160908-00029#1-s
               CALL apmp490_02_pmdn007_chk('','',g_pmdn_d[l_ac1].pmdn001_02_01,g_pmdn_d[l_ac1].pmdn002_02_01,'','',g_pmdn_d[l_ac1].pmdn006_02_01,g_pmdn_d[l_ac1].pmdn007_02_01)
                    RETURNING l_success,l_pmdn0071
               IF NOT l_success THEN
                  NEXT FIELD pmdn007
               ELSE
                  LET g_pmdn_d[l_ac1].pmdn007_02_01 = l_pmdn0071
               END IF
               #160908-00029#1-e
            END IF 
            
         AFTER FIELD pmdn008_02_01   #參考單位 
            IF NOT cl_null(g_pmdn_d[l_ac1].pmdn008_02_01) THEN
               CALL apmp490_02_unit_chk(g_pmdn_d[l_ac1].pmdn008_02_01)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = g_errno
                  #160318-00005#35  By 07900 --add-str
                    LET g_errparam.replace[1] ='aooi250'
                    LET g_errparam.replace[2] = cl_get_progname("aooi250",g_lang,"2")
                    LET g_errparam.exeprog ='aooi250'
                    #160318-00005#35  By 07900 --add-end
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()

                  NEXT FIELD CURRENT
               END IF

               #計算參考數量 
               IF (NOT cl_null(g_pmdn_d[l_ac1].pmdn006_02_01)) AND 
                  (NOT cl_null(g_pmdn_d[l_ac1].pmdn007_02_01)) THEN
                  CALL apmp490_02_convert_qty(g_pmdn_d[l_ac1].pmdn001_02_01,g_pmdn_d[l_ac1].pmdn006_02_01,
                                              g_pmdn_d[l_ac1].pmdn008_02_01,g_pmdn_d[l_ac1].pmdn007_02_01)
                       RETURNING g_pmdn_d[l_ac1].pmdn009_02_01
               END IF

               IF NOT cl_null(g_pmdn_d[l_ac1].pmdn009_02_01) THEN
                  CALL apmp490_02_unit_round(g_pmdn_d[l_ac1].pmdn008_02_01,g_pmdn_d[l_ac1].pmdn009_02_01)
                       RETURNING g_pmdn_d[l_ac1].pmdn009_02_01
               END IF
            END IF  
            
            CALL s_desc_get_unit_desc(g_pmdn_d[l_ac1].pmdn008_02_01)
                 RETURNING g_pmdn_d[l_ac1].pmdn008_02_01_desc
            
         AFTER FIELD pmdn009_02_01   #參考數量 
            IF NOT cl_null(g_pmdn_d[l_ac1].pmdn009_02_01) THEN
               IF g_pmdn_d[l_ac1].pmdn009_02_01 <= 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'ade-00016' #數量不可小於等於0  
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()

                  NEXT FIELD CURRENT
               END IF

               #檢查數量是否有超過採購數量 
               LET l_qty = g_pmdn_d[l_ac1].pmdn009_02_01
               IF g_pmdn_d[l_ac1].pmdb007_02_01 != g_pmdn_d[l_ac1].pmdn008_02_01 THEN
                  CALL apmp490_02_convert_qty(g_pmdn_d[l_ac1].pmdb004_02_01,g_pmdn_d[l_ac1].pmdn008_02_01,
                                              g_pmdn_d[l_ac1].pmdb007_02_01,l_qty)
                       RETURNING l_qty
               END IF

               #如果數量乘上轉換率後，超過未轉採購量，就算錯 
               IF l_qty > g_pmdn_d[l_ac1].qty_02_01 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'apm-00699'    #數量不可大於未轉採購量！  
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()

                  NEXT FIELD CURRENT
               END IF

               IF NOT cl_null(g_pmdn_d[l_ac1].pmdn008_02_01) THEN
                  CALL apmp490_02_unit_round(g_pmdn_d[l_ac1].pmdn008_02_01,g_pmdn_d[l_ac1].pmdn009_02_01)
                       RETURNING g_pmdn_d[l_ac1].pmdn009_02_01
                  DISPLAY BY NAME g_pmdn_d[l_ac1].pmdn009_02_01
               END IF
            END IF

         AFTER FIELD pmdn010_02_01   #計價單位  
            IF NOT cl_null(g_pmdn_d[l_ac1].pmdn010_02_01) THEN
                CALL apmp490_02_unit_chk(g_pmdn_d[l_ac1].pmdn010_02_01)
                IF NOT cl_null(g_errno) THEN
                   INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     #160318-00005#35  By 07900 --add-str
                    LET g_errparam.replace[1] ='aooi250'
                    LET g_errparam.replace[2] = cl_get_progname("aooi250",g_lang,"2")
                    LET g_errparam.exeprog ='aooi250'
                    #160318-00005#35  By 07900 --add-end
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                   NEXT FIELD CURRENT
                END IF 
                
                #單位改變後,數量要重新推算 
                CALL apmp490_02_convert_qty(g_pmdn_d[l_ac1].pmdb004_02_01,     #料號  
                                            g_pmdn_d[l_ac1].pmdb007_02_01,     #來源單位  
                                            g_pmdn_d[l_ac1].pmdn010_02_01,     #目的單位  
                                            g_pmdn_d[l_ac1].pmdn007_02_01)     #數量  
                     RETURNING g_pmdn_d[l_ac1].pmdn011_02_01


                IF NOT cl_null(g_pmdn_d[l_ac1].pmdn011_02_01) THEN
                   CALL apmp490_02_unit_round(g_pmdn_d[l_ac1].pmdn010_02_01,g_pmdn_d[l_ac1].pmdn011_02_01)
                        RETURNING g_pmdn_d[l_ac1].pmdn011_02_01
                   DISPLAY BY NAME g_pmdn_d[l_ac1].pmdn011_02_01
                END IF
            END IF 
            
            CALL s_desc_get_unit_desc(g_pmdn_d[l_ac1].pmdn010_02_01)
                 RETURNING g_pmdn_d[l_ac1].pmdn010_02_01_desc

         AFTER FIELD pmdn011_02_01   #計價數量   
            IF NOT cl_null(g_pmdn_d[l_ac1].pmdn011_02_01) THEN
               IF g_pmdn_d[l_ac1].pmdn011_02_01 <= 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ade-00016'   #數量不可小於等於0  
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
     
                  NEXT FIELD CURRENT
               END IF 
               
               LET l_qty = g_pmdn_d[l_ac1].pmdn011_02_01
               IF g_pmdn_d[l_ac1].pmdb007_02_01 != g_pmdn_d[l_ac1].pmdn010_02_01 THEN
                  CALL apmp490_02_convert_qty(g_pmdn_d[l_ac1].pmdb004_02_01,g_pmdn_d[l_ac1].pmdn010_02_01,
                                              g_pmdn_d[l_ac1].pmdb007_02_01,l_qty)
                       RETURNING l_qty
               END IF

               #如果採購數量乘上轉換率後，超過未轉採購量的數量，就算錯 
               IF l_qty > g_pmdn_d[l_ac1].qty_02_01 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'apm-00699'     #數量不可大於未轉採購量！  
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()

                  NEXT FIELD CURRENT
               END IF

               IF NOT cl_null(g_pmdn_d[l_ac1].pmdn010_02_01) THEN
                  CALL apmp490_02_unit_round(g_pmdn_d[l_ac1].pmdn010_02_01,g_pmdn_d[l_ac1].pmdn011_02_01)
                       RETURNING g_pmdn_d[l_ac1].pmdn011_02_01
                  DISPLAY BY NAME g_pmdn_d[l_ac1].pmdn011_02_01
               END IF
            END IF 
            
         #161006-00018#21-S
         AFTER FIELD pmdn028_02_01
            CALL s_desc_get_stock_desc(g_site,g_pmdn_d[l_ac1].pmdn028_02_01) RETURNING g_pmdn_d[l_ac1].pmdn028_02_01_desc
            IF NOT cl_null(g_pmdn_d[l_ac1].pmdn028_02_01) THEN
               #此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_site
               LET g_chkparam.arg2 = g_pmdn_d[l_ac1].pmdn028_02_01

               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_inaa001_1") THEN
                  #檢查成功時後續處理                  
               ELSE
                  NEXT FIELD CURRENT
               END IF     
               IF NOT apmp490_02_pmdn029_chk(l_ac1) THEN
                  NEXT FIELD CURRENT
               END IF               
            END IF
            CALL s_desc_get_stock_desc(g_site,g_pmdn_d[l_ac1].pmdn028_02_01) RETURNING g_pmdn_d[l_ac1].pmdn028_02_01_desc            
            CALL apmp490_02_set_entry_b(l_ac1)            
            CALL apmp490_02_set_no_required_b(l_ac1)
            CALL apmp490_02_set_required_b(l_ac1)                       
            CALL apmp490_02_set_no_entry_b(l_ac1)    

         AFTER FIELD pmdn029_02_01
            IF NOT cl_null(g_pmdn_d[l_ac1].pmdn029_02_01) THEN
               IF NOT apmp490_02_pmdn029_chk(l_ac1) THEN
                  NEXT FIELD CURRENT
               END IF              
            END IF
         #161006-00018#21-E 
         
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_pmdn_d[l_ac1].* = l_pmdn_t.*
               EXIT DIALOG
            END IF
            
            UPDATE p490_02_pmdn_t SET pmdl004 = g_pmdn_d[l_ac1].pmdl004_02_01,
                                      pmdn001 = g_pmdn_d[l_ac1].pmdn001_02_01,
                                      pmdn002 = g_pmdn_d[l_ac1].pmdn002_02_01,
                                      pmdn006 = g_pmdn_d[l_ac1].pmdn006_02_01,
                                      pmdn007 = g_pmdn_d[l_ac1].pmdn007_02_01,
                                      pmdn008 = g_pmdn_d[l_ac1].pmdn008_02_01,
                                      pmdn009 = g_pmdn_d[l_ac1].pmdn009_02_01,
                                      pmdn010 = g_pmdn_d[l_ac1].pmdn010_02_01,
                                      pmdn011 = g_pmdn_d[l_ac1].pmdn011_02_01,
                                      pmdn058 = g_pmdn_d[l_ac1].pmdn058_02_01,
                                      pmdn028 = g_pmdn_d[l_ac1].pmdn028_02_01,    #161006-00018#21
                                      pmdn029 = g_pmdn_d[l_ac1].pmdn029_02_01     #161006-00018#21
             WHERE NVL(pmdl004,' ') = NVL(l_pmdn_t.pmdl004_02_01,' ')
               AND pmdb004 = g_pmdn_d[l_ac1].pmdb004_02_01
               AND pmdb005 = g_pmdn_d[l_ac1].pmdb005_02_01
               AND pmdn014 = g_pmdn_d[l_ac1].pmdn014_02_01                   #因為會有費用料件的問題 
               AND NVL(pmdn050,' ') = NVL(g_pmdn_d[l_ac1].pmdn050_02_01,' ') #所以要多考慮備註 
               AND NVL(ooff013,' ') = NVL(g_pmdn_d[l_ac1].ooff013_02_01,' ')   #161031-00025#6
               AND NVL(pmdl025,' ') = NVL(g_pmdn_d[l_ac1].pmdl025_02_01,' ')
               AND NVL(pmdl026,' ') = NVL(g_pmdn_d[l_ac1].pmdl026_02_01,' ')
               AND NVL(pmdn058,' ') = NVL(l_pmdn_t.pmdn058_02_01,' ')
               AND NVL(pmdn036,' ') = NVL(l_pmdn_t.pmdn036_02_01,' ')
               AND NVL(pmdn037,' ') = NVL(l_pmdn_t.pmdn037_02_01,' ')
               AND NVL(pmdn038,' ') = NVL(l_pmdn_t.pmdn038_02_01,' ')
               #160801-00004#3--s
               AND NVL(pmdn028,' ') = NVL(l_pmdn_t.pmdn028_02_01,' ')
               AND NVL(pmdn029,' ') = NVL(l_pmdn_t.pmdn029_02_01,' ')
               AND NVL(pmdn053,' ') = NVL(l_pmdn_t.pmdn053_02_01,' ')
               #160801-00004#3--e  

               AND NVL(pmdbdocno,' ') = NVL(g_pmdn_d[l_ac1].pmdbdocno_02_01,' ')
               AND NVL(pmdbseq,'0') = NVL(g_pmdn_d[l_ac1].pmdbseq_02_01,'0')

         #161006-00018#21-S
         ON ACTION controlp INFIELD pmdn028_02_01
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmdn_d[l_ac1].pmdn028_02_01
            LET g_qryparam.arg1 = g_site 
            CALL q_inaa001_4()
            LET g_pmdn_d[l_ac1].pmdn028_02_01 = g_qryparam.return1              #將開窗取得的值回傳到變數 
            DISPLAY g_pmdn_d[l_ac1].pmdn028_02_01 TO pmdn028_02_01              #顯示到畫面上

            NEXT FIELD pmdn028_02_01    

         ON ACTION controlp INFIELD pmdn029_02_01
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmdn_d[l_ac1].pmdn029_02_01
            LET g_qryparam.arg1 = g_site 
            LET g_qryparam.arg2 = g_pmdn_d[l_ac1].pmdn028_02_01 
            CALL q_inab002_6()
            LET g_pmdn_d[l_ac1].pmdn029_02_01 = g_qryparam.return1              #將開窗取得的值回傳到變數 
            DISPLAY g_pmdn_d[l_ac1].pmdn029_02_01 TO pmdn029_02_01              #顯示到畫面上

            NEXT FIELD pmdn029_02_01 
            
         #161006-00018#21-E
         
         ON ACTION controlp INFIELD pmdl004_02_01       #供應商編號 
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmdn_d[l_ac1].pmdl004_02_01

            LET g_qryparam.where = "1=1 "

            #統一使用s_control_get_supplier_sql()回傳的sql丟入where條件即可 
            CALL s_control_get_supplier_sql('4',g_site,g_user,g_dept,g_apmp490_01_input.pmdldocno)
                 RETURNING l_success,l_sql
            IF l_success THEN
               LET g_qryparam.where = l_sql
            END IF

            #161005-00031#1-(S)-add
            IF NOT cl_null(g_qryparam.where) THEN
               LET g_qryparam.where = g_qryparam.where, " AND "
            END IF
            LET g_qryparam.where = g_qryparam.where, 
                                   " pmaa004 <> '2' AND ",   #161230-00019#1
                                   "pmaa001 IN (SELECT pmab001 FROM pmab_t ",                                             
                                   "             WHERE pmabsite = '",g_site,"' AND pmabent = '",g_enterprise,"' AND 1=1)" 
            #161005-00031#1-(E)-add
            CALL q_pmaa001_3()

            LET g_pmdn_d[l_ac1].pmdl004_02_01 = g_qryparam.return1 
            DISPLAY g_pmdn_d[l_ac1].pmdl004_02_01 TO pmdl004_02_01

            NEXT FIELD pmdl004_02_01

         ON ACTION controlp INFIELD pmdn001_02_01         #採購料號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmdn_d[l_ac1].pmdn001_02_01

            LET g_qryparam.WHERE = "1=1 "

            #呼叫s_control_get_item_sql取得where  
            CALL s_control_get_item_sql('4',g_site,g_user,g_dept,g_apmp490_01_input.pmdldocno)
                 RETURNING l_success,l_sql
            IF l_success THEN
               LET g_qryparam.where = l_sql
            END IF 
            
            IF cl_get_doc_para(g_enterprise,g_site,g_apmp490_01_input.pmdldocno,'D-BAS-0096') = "Y" THEN
               LET g_qryparam.where = g_qryparam.where,
                                      " AND imaf001 IN (SELECT bmea008 ",
                                      "                   FROM bmea_t ",
                                      "                  WHERE bmeaent = '",g_enterprise,"' ",
                                      "                    AND bmeasite = '",g_site,"' ",
                                      "                    AND bmea003  = '",g_pmdn_d[l_ac1].pmdn001_02_01,"' ",
                                      "                    AND bmea007 = '2' ",
                                      "                    AND bmea009<= '",g_today,"' ",
                                      "                    AND (bmea010 > '",g_today,"'  OR bmea010 IS NULL ) ",
                                      "                     ) "

            END IF
            
            CALL q_imaf001_15()                                #呼叫開窗  
            LET g_pmdn_d[l_ac1].pmdn001_02_01 = g_qryparam.return1

            DISPLAY g_pmdn_d[l_ac1].pmdn001_02_01 TO pmdn001_02_01

            NEXT FIELD pmdn001_02_01
            
         #160323-00001#1 20160429 add by ming -----(S) 
         ON ACTION controlp INFIELD pmdn002_02_01 
            #取得產品特徵組別 
            LET l_imaa005 = '' 
            SELECT imaa005 INTO l_imaa005 
              FROM imaa_t 
             WHERE imaaent = g_enterprise 
               AND imaa001 = g_pmdn_d[l_ac1].pmdn001_02_01 
         
            IF NOT cl_null(l_imaa005) THEN 
               CALL s_feature_single(g_pmdn_d[l_ac1].pmdn001_02_01, 
                                     g_pmdn_d[l_ac1].pmdn002_02_01, 
                                     g_site,' ') 
                    RETURNING l_success,g_pmdn_d[l_ac1].pmdn002_02_01 
               CALL s_feature_description(g_pmdn_d[l_ac1].pmdn001_02_01, 
                                          g_pmdn_d[l_ac1].pmdn002_02_01) 
                    RETURNING l_success,g_pmdn_d[l_ac1].pmdn002_02_01_desc 
               DISPLAY BY NAME g_pmdn_d[l_ac1].pmdn002_02_01, 
                               g_pmdn_d[l_ac1].pmdn002_02_01_desc 
            END IF 
         #160323-00001#1 20160429 add by ming -----(E) 

         ON ACTION controlp INFIELD pmdn006_02_01
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmdn_d[l_ac1].pmdn006_02_01             #給予default值
            CALL q_ooca001_1()                                                  #呼叫開窗
            LET g_pmdn_d[l_ac1].pmdn006_02_01 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_pmdn_d[l_ac1].pmdn006_02_01 TO pmdn006_02_01              #顯示到畫面上 
            CALL s_desc_get_unit_desc(g_pmdn_d[l_ac1].pmdn006_02_01)
                 RETURNING g_pmdn_d[l_ac1].pmdn006_02_01_desc
            DISPLAY BY NAME g_pmdn_d[l_ac1].pmdn006_02_01_desc
            NEXT FIELD pmdn006_02_01                                            #返回原欄位
            
         ON ACTION controlp INFIELD pmdn008_02_01
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmdn_d[l_ac1].pmdn008_02_01             #給予default值  
            CALL q_ooca001_1()                                                  #呼叫開窗 
            LET g_pmdn_d[l_ac1].pmdn008_02_01 = g_qryparam.return1              #將開窗取得的值回傳到變數上 
            DISPLAY g_pmdn_d[l_ac1].pmdn008_02_01 TO pmdn008_02_01              #顯示到畫面上 
            CALL s_desc_get_unit_desc(g_pmdn_d[l_ac1].pmdn008_02_01)
                 RETURNING g_pmdn_d[l_ac1].pmdn008_02_01_desc
            DISPLAY BY NAME g_pmdn_d[l_ac1].pmdn008_02_01_desc
            NEXT FIELD pmdn008_02_01                                            #返回原欄位 

         ON ACTION controlp INFIELD pmdn010_02_01
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmdn_d[l_ac1].pmdn010_02_01             #給予default值
            CALL q_ooca001_1()                                                  #呼叫開窗
            LET g_pmdn_d[l_ac1].pmdn010_02_01 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_pmdn_d[l_ac1].pmdn010_02_01 TO pmdn010_02_01              #顯示到畫面上 
            CALL s_desc_get_unit_desc(g_pmdn_d[l_ac1].pmdn010_02_01)
                 RETURNING g_pmdn_d[l_ac1].pmdn010_02_01_desc
            DISPLAY BY NAME g_pmdn_d[l_ac1].pmdn010_02_01_desc
            NEXT FIELD pmdn010_02_01                                            #返回原欄位  
            
         ON ACTION accept 
            #供應商檢查 
            CALL apmp490_02_get_pmaal004(g_pmdn_d[l_ac1].pmdl004_02_01)
                 RETURNING g_pmdn_d[l_ac1].pmaal004_02_01
            DISPLAY BY NAME g_pmdn_d[l_ac1].pmaal004_02_01
            IF NOT cl_null(g_pmdn_d[l_ac1].pmdl004_02_01) THEN
               IF g_pmdn_d[l_ac1].pmdl004_02_01 != l_pmdn_t.pmdl004_02_01 OR
                  l_pmdn_t.pmdl004_02_01 IS NULL THEN
                  IF g_pmdn_d[l_ac1].pmdb014_02_01 = '3' THEN
                     LET g_pmdn_d[l_ac1].pmdl004_02_01 = l_pmdn_t.pmdl004_02_01
                     CALL apmp490_02_get_pmaal004(g_pmdn_d[l_ac1].pmdl004_02_01)
                          RETURNING g_pmdn_d[l_ac1].pmaal004_02_01
                     DISPLAY BY NAME g_pmdn_d[l_ac1].pmaal004_02_01
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apm-00537'     #請購單已指定供應商，不可修改！ 
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD xmdl004_02_01
                  END IF

                  IF NOT apmp490_02_pmdl004_chk(g_pmdn_d[l_ac1].pmdl004_02_01) THEN

                     NEXT FIELD xmdl004_02_01
                  END IF

               END IF
            END IF
            
            #採購料號檢查 
            CALL apmp490_02_get_imaal(g_pmdn_d[l_ac1].pmdn001_02_01)
                 RETURNING g_pmdn_d[l_ac1].imaal003_02_01_2,g_pmdn_d[l_ac1].imaal004_02_01_2
            DISPLAY BY NAME g_pmdn_d[l_ac1].imaal003_02_01_2,g_pmdn_d[l_ac1].imaal004_02_01_2
            IF NOT cl_null(g_pmdn_d[l_ac1].pmdn001_02_01) THEN
               IF g_pmdn_d[l_ac1].pmdn001_02_01 != l_pmdn_t.pmdn001_02_01 OR
                  l_pmdn_t.pmdn001_02_01 IS NULL THEN
                  IF NOT apmp490_02_pmdn001_chk(g_pmdn_d[l_ac1].pmdn001_02_01,
                                                g_pmdn_d[l_ac1].pmdb004_02_01,
                                                g_pmdn_d[l_ac1].pmdl004_02_01,
                                                g_pmdn_d[l_ac1].pmdn002_02_01,
                                                g_pmdn_d[l_ac1].pmdb004_02_01) THEN

                     NEXT FIELD pmdn001_02_01
                  END IF

               END IF
            END IF

            CALL apmp490_02_set_entry_b(l_ac1)
            #161006-00018#21-S
            CALL apmp490_02_set_no_required_b(l_ac1)
            CALL apmp490_02_set_required_b(l_ac1)
            #161006-00018#21-E            
            CALL apmp490_02_set_no_entry_b(l_ac1) 
            
            #產品特徵檢查 
            #如果產品特徵沒有輸入的話，要設定為一個空白 
            IF cl_null(g_pmdn_d[l_ac1].pmdn002_02_01) THEN
               LET g_pmdn_d[l_ac1].pmdn002_02_01 = ' '
            ELSE
               #取得產品特徵說明 
               CALL s_feature_description(g_pmdn_d[l_ac1].pmdn001_02_01,g_pmdn_d[l_ac1].pmdn002_02_01)
                    RETURNING l_success,g_pmdn_d[l_ac1].pmdn002_02_01_desc
               #產品特徵的基本檢查  
               IF g_pmdn_d[l_ac1].pmdn002_02_01 IS NOT NULL THEN
                  IF NOT s_feature_check(g_pmdn_d[l_ac1].pmdn001_02_01,g_pmdn_d[l_ac1].pmdn002_02_01) THEN
                     LET g_pmdn_d[l_ac1].pmdn002_02_01 = l_pmdn_t.pmdn002_02_01
                     CALL s_feature_description(g_pmdn_d[l_ac1].pmdn001_02_01,g_pmdn_d[l_ac1].pmdn002_02_01)
                          RETURNING l_success,g_pmdn_d[l_ac1].pmdn002_02_01_desc
                     NEXT FIELD pmdn002_02_01
                  END IF
               END IF
               IF NOT cl_null(g_pmdn_d[l_ac1].pmdn002_02_01) THEN
                  IF g_pmdn_d[l_ac1].pmdn002_02_01 != l_pmdn_t.pmdn002_02_01 OR
                     l_pmdn_t.pmdn002_02_01 IS NULL THEN
                     #2.呼叫產品特徵檢核應用元件，檢核輸入的產品特徵值是否合理
                     #3.當請採勾稽時，採購料號+採購產品特徵與請購料號+請購產品特徵不一樣時，必須檢核是否與請購料號+
                     #  請購產品特徵有替代關係，若沒有則不允許修改

                  END IF
               END IF
            END IF 
            
            #採購單位檢查 
            IF NOT cl_null(g_pmdn_d[l_ac1].pmdn006_02_01) THEN
               IF g_pmdn_d[l_ac1].pmdn006_02_01 != l_pmdn_t.pmdn006_02_01 OR
                  l_pmdn_t.pmdn006_02_01 IS NULL THEN
                  CALL apmp490_02_unit_chk(g_pmdn_d[l_ac1].pmdn006_02_01)

                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     
                     LET g_errparam.extend = ''
                     #160318-00005#35  By 07900 --add-str
                    LET g_errparam.replace[1] ='aooi250'
                    LET g_errparam.replace[2] = cl_get_progname("aooi250",g_lang,"2")
                    LET g_errparam.exeprog ='aooi250'
                    #160318-00005#35  By 07900 --add-end
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD pmdn006_02_01
                  END IF

                  IF NOT cl_null(g_pmdn_d[l_ac1].pmdn007_02_01) THEN
                     CALL apmp490_02_unit_round(g_pmdn_d[l_ac1].pmdn006_02_01,g_pmdn_d[l_ac1].pmdn007_02_01)
                          RETURNING g_pmdn_d[l_ac1].pmdn007_02_01
                     DISPLAY BY NAME g_pmdn_d[l_ac1].pmdn007_02_01

                     #若參數有使用計價單位時，則輸入[C:需求數量]時則應自動推算計價數量，
                     #[C:計價數量]=[C:需求數量]*[C:單位]與[C:計價單位]換算率 
                     IF cl_get_para(g_enterprise,g_site,'S-BAS-0019') = "Y" THEN  #體參數使用採購計價單位
                        CALL apmp490_02_convert_qty(g_pmdn_d[l_ac1].pmdn001_02_01,
                                                    g_pmdn_d[l_ac1].pmdn006_02_01,
                                                    g_pmdn_d[l_ac1].pmdn010_02_01,
                                                    g_pmdn_d[l_ac1].pmdn007_02_01)
                             RETURNING g_pmdn_d[l_ac1].pmdn011_02_01
                        IF NOT cl_null(g_pmdn_d[l_ac1].pmdn011_02_01) THEN
                           CALL apmp490_02_unit_round(g_pmdn_d[l_ac1].pmdn010_02_01,g_pmdn_d[l_ac1].pmdn011_02_01)
                                RETURNING g_pmdn_d[l_ac1].pmdn011_02_01
                           DISPLAY BY NAME g_pmdn_d[l_ac1].pmdn011_02_01
                        END IF
                     END IF
                  END IF
               END IF
            END IF

            CALL s_desc_get_unit_desc(g_pmdn_d[l_ac1].pmdn006_02_01)
                 RETURNING g_pmdn_d[l_ac1].pmdn006_02_01_desc

            #採購數量的檢查 
            IF NOT cl_null(g_pmdn_d[l_ac1].pmdn007_02_01) THEN
               IF g_pmdn_d[l_ac1].pmdn007_02_01 <= 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ade-00016'   #數量不可小於等於0  
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD pmdn007_02_01
               END IF

               LET l_qty = g_pmdn_d[l_ac1].pmdn007_02_01
               IF g_pmdn_d[l_ac1].pmdb007_02_01 != g_pmdn_d[l_ac1].pmdn006_02_01 THEN
                  CALL apmp490_02_convert_qty(g_pmdn_d[l_ac1].pmdb004_02_01,g_pmdn_d[l_ac1].pmdn006_02_01,
                                              g_pmdn_d[l_ac1].pmdb007_02_01,l_qty)
                       RETURNING l_qty
               END IF

               #如果採購數量乘上轉換率後，超過未轉採購量的數量，就算錯 
               IF l_qty > g_pmdn_d[l_ac1].qty_02_01 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'apm-00699'     #數量不可大於未轉採購量！  
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()

                  NEXT FIELD pmdn007_02_01
               END IF

               CALL apmp490_02_unit_round(g_pmdn_d[l_ac1].pmdn006_02_01,g_pmdn_d[l_ac1].pmdn007_02_01)
                    RETURNING g_pmdn_d[l_ac1].pmdn007_02_01
               DISPLAY BY NAME g_pmdn_d[l_ac1].pmdn007_02_01 
               
               IF cl_get_para(g_enterprise,g_site,'S-BAS-0028') = 'Y' THEN
                  IF NOT cl_null(g_pmdn_d[l_ac1].pmdn001_02_01) AND
                     NOT cl_null(g_pmdn_d[l_ac1].pmdn006_02_01) AND
                     NOT cl_null(g_pmdn_d[l_ac1].pmdn008_02_01) THEN
                     CALL apmp490_02_convert_qty(g_pmdn_d[l_ac1].pmdn001_02_01,g_pmdn_d[l_ac1].pmdn006_02_01,
                                                 g_pmdn_d[l_ac1].pmdn008_02_01,g_pmdn_d[l_ac1].pmdn007_02_01)
                          RETURNING g_pmdn_d[l_ac1].pmdn009_02_01
                     IF NOT cl_null(g_pmdn_d[l_ac1].pmdn009_02_01) THEN
                        CALL apmp490_02_unit_round(g_pmdn_d[l_ac1].pmdn008_02_01,g_pmdn_d[l_ac1].pmdn009_02_01)
                             RETURNING g_pmdn_d[l_ac1].pmdn009_02_01
                        DISPLAY BY NAME g_pmdn_d[l_ac1].pmdn009_02_01
                     END IF

                  END IF
               END IF

               #若參數有使用計價單位時，則輸入[C:需求數量]時則應自動推算計價數量，
               #[C:計價數量]=[C:需求數量]*[C:單位]與[C:計價單位]換算率 
               IF cl_get_para(g_enterprise,g_site,'S-BAS-0019') = "Y" THEN  #體參數使用採購計價單位
                  CALL apmp490_02_convert_qty(g_pmdn_d[l_ac1].pmdn001_02_01,g_pmdn_d[l_ac1].pmdn006_02_01,
                                              g_pmdn_d[l_ac1].pmdn010_02_01,g_pmdn_d[l_ac1].pmdn007_02_01)
                       RETURNING g_pmdn_d[l_ac1].pmdn011_02_01
                  IF NOT cl_null(g_pmdn_d[l_ac1].pmdn011_02_01) THEN
                     CALL apmp490_02_unit_round(g_pmdn_d[l_ac1].pmdn010_02_01,g_pmdn_d[l_ac1].pmdn011_02_01)
                          RETURNING g_pmdn_d[l_ac1].pmdn011_02_01
                     DISPLAY BY NAME g_pmdn_d[l_ac1].pmdn011_02_01
                  END IF
               END IF

            END IF 

            #計價單位的檢查 
            IF NOT cl_null(g_pmdn_d[l_ac1].pmdn010_02_01) THEN
                CALL apmp490_02_unit_chk(g_pmdn_d[l_ac1].pmdn010_02_01)
                IF NOT cl_null(g_errno) THEN
                   INITIALIZE g_errparam TO NULL
                     LET g_errparam.code   = g_errno
                     LET g_errparam.extend = ''
                     #160318-00005#35  By 07900 --add-str
                    LET g_errparam.replace[1] ='aooi250'
                    LET g_errparam.replace[2] = cl_get_progname("aooi250",g_lang,"2")
                    LET g_errparam.exeprog ='aooi250'
                    #160318-00005#35  By 07900 --add-end
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()

                     NEXT FIELD pmdn010_02_01
                END IF

                IF NOT cl_null(g_pmdn_d[l_ac1].pmdn011_02_01) THEN
                   CALL apmp490_02_unit_round(g_pmdn_d[l_ac1].pmdn010_02_01,g_pmdn_d[l_ac1].pmdn011_02_01)
                        RETURNING g_pmdn_d[l_ac1].pmdn011_02_01
                   DISPLAY BY NAME g_pmdn_d[l_ac1].pmdn011_02_01
                END IF
            END IF 
            
            CALL s_desc_get_unit_desc(g_pmdn_d[l_ac1].pmdn010_02_01)
                 RETURNING g_pmdn_d[l_ac1].pmdn010_02_01_desc

            #計價數量的檢查 
            IF NOT cl_null(g_pmdn_d[l_ac1].pmdn011_02_01) THEN
               IF g_pmdn_d[l_ac1].pmdn011_02_01 <= 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code   = 'ade-00016'   #數量不可小於等於0  
                  LET g_errparam.extend = ''
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()

                  NEXT FIELD pmdn011_02_01
               END IF

               LET l_qty = g_pmdn_d[l_ac1].pmdn011_02_01
               IF g_pmdn_d[l_ac1].pmdb007_02_01 != g_pmdn_d[l_ac1].pmdn010_02_01 THEN
                  CALL apmp490_02_convert_qty(g_pmdn_d[l_ac1].pmdb004_02_01,g_pmdn_d[l_ac1].pmdn010_02_01,
                                              g_pmdn_d[l_ac1].pmdb007_02_01,l_qty)
                       RETURNING l_qty
               END IF 
               
               #如果採購數量乘上轉換率後，超過未轉採購量的數量，就算錯 
               IF l_qty > g_pmdn_d[l_ac1].qty_02_01 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'apm-00699'     #數量不可大於未轉採購量！  
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()

                  NEXT FIELD pmdn011_02_01
               END IF

               IF NOT cl_null(g_pmdn_d[l_ac1].pmdn010_02_01) THEN
                  CALL apmp490_02_unit_round(g_pmdn_d[l_ac1].pmdn010_02_01,g_pmdn_d[l_ac1].pmdn011_02_01)
                       RETURNING g_pmdn_d[l_ac1].pmdn011_02_01
                  DISPLAY BY NAME g_pmdn_d[l_ac1].pmdn011_02_01
               END IF
            END IF
            
            UPDATE p490_02_pmdn_t SET pmdl004 = g_pmdn_d[l_ac1].pmdl004_02_01,
                                      pmdn001 = g_pmdn_d[l_ac1].pmdn001_02_01,
                                      pmdn002 = g_pmdn_d[l_ac1].pmdn002_02_01,
                                      pmdn006 = g_pmdn_d[l_ac1].pmdn006_02_01,
                                      pmdn007 = g_pmdn_d[l_ac1].pmdn007_02_01,
                                      pmdn008 = g_pmdn_d[l_ac1].pmdn008_02_01,
                                      pmdn009 = g_pmdn_d[l_ac1].pmdn009_02_01,
                                      pmdn010 = g_pmdn_d[l_ac1].pmdn010_02_01,
                                      pmdn011 = g_pmdn_d[l_ac1].pmdn011_02_01,
                                      pmdn058 = g_pmdn_d[l_ac1].pmdn058_02_01
             WHERE NVL(pmdl004,' ') = NVL(l_pmdn_t.pmdl004_02_01,' ')
               AND pmdb004 = g_pmdn_d[l_ac1].pmdb004_02_01
               AND pmdb005 = g_pmdn_d[l_ac1].pmdb005_02_01
               AND pmdn014 = g_pmdn_d[l_ac1].pmdn014_02_01                    #因為有費用料件
               AND NVL(pmdn050,' ') = NVL(g_pmdn_d[l_ac1].pmdn050_02_01,' ')  #所以要多考慮備註 
               AND NVL(ooff013,' ') = NVL(g_pmdn_d[l_ac1].ooff013_02_01,' ')  #161031-00025#6
               AND NVL(pmdl025,' ') = NVL(g_pmdn_d[l_ac1].pmdl025_02_01,' ')
               AND NVL(pmdl026,' ') = NVL(g_pmdn_d[l_ac1].pmdl026_02_01,' ')
               AND NVL(pmdn058,' ') = NVL(l_pmdn_t.pmdn058_02_01,' ')
               AND NVL(pmdn036,' ') = NVL(l_pmdn_t.pmdn036_02_01,' ')
               AND NVL(pmdn037,' ') = NVL(l_pmdn_t.pmdn037_02_01,' ')
               AND NVL(pmdn038,' ') = NVL(l_pmdn_t.pmdn038_02_01,' ')
               #160801-00004#3--s
               AND NVL(pmdn028,' ') = NVL(l_pmdn_t.pmdn028_02_01,' ')
               AND NVL(pmdn029,' ') = NVL(l_pmdn_t.pmdn029_02_01,' ')
               AND NVL(pmdn053,' ') = NVL(l_pmdn_t.pmdn053_02_01,' ')
               #160801-00004#3--e  
               AND NVL(pmdbdocno,' ') = NVL(g_pmdn_d[l_ac1].pmdbdocno_02_01,' ')
               AND NVL(pmdbseq,'0') = NVL(g_pmdn_d[l_ac1].pmdbseq_02_01,'0')

            EXIT DIALOG 
            
         #151118-00029#1 20160112 add by ming -----(S) 
         ON ACTION cancel 
            LET g_pmdn_d[l_ac1].* = l_pmdn_t.* 
            EXIT DIALOG 
         #151118-00029#1 20160112 add by ming -----(E) 
            
         BEFORE DELETE
            IF NOT cl_ask_del_detail() THEN
               CANCEL DELETE
            END IF

            DELETE FROM p490_02_pmdn_t
             WHERE NVL(pmdl004,' ') = NVL(l_pmdn_t.pmdl004_02_01,' ')
               AND pmdb004 = g_pmdn_d[l_ac1].pmdb004_02_01
               AND pmdb005 = g_pmdn_d[l_ac1].pmdb005_02_01
               AND pmdn014 = g_pmdn_d[l_ac1].pmdn014_02_01                    #因為有費用料件
               AND NVL(pmdn050,' ') = NVL(g_pmdn_d[l_ac1].pmdn050_02_01,' ')  #所以要多考慮備註  
               AND NVL(ooff013,' ') = NVL(g_pmdn_d[l_ac1].ooff013_02_01,' ')  #161031-00025#6
               AND NVL(pmdl025,' ') = NVL(g_pmdn_d[l_ac1].pmdl025_02_01,' ')
               AND NVL(pmdl026,' ') = NVL(g_pmdn_d[l_ac1].pmdl026_02_01,' ')
               AND NVL(pmdn058,' ') = NVL(l_pmdn_t.pmdn058_02_01,' ')
               AND NVL(pmdn036,' ') = NVL(l_pmdn_t.pmdn036_02_01,' ')
               AND NVL(pmdn037,' ') = NVL(l_pmdn_t.pmdn037_02_01,' ')
               AND NVL(pmdn038,' ') = NVL(l_pmdn_t.pmdn038_02_01,' ')
               #160801-00004#3--s
               AND NVL(pmdn028,' ') = NVL(l_pmdn_t.pmdn028_02_01,' ')
               AND NVL(pmdn029,' ') = NVL(l_pmdn_t.pmdn029_02_01,' ')
               AND NVL(pmdn053,' ') = NVL(l_pmdn_t.pmdn053_02_01,' ')
               #160801-00004#3--e  
               AND NVL(pmdbdocno,' ') = NVL(g_pmdn_d[l_ac1].pmdbdocno_02_01,' ')
               AND NVL(pmdbseq,'0') = NVL(g_pmdn_d[l_ac1].pmdbseq_02_01,'0')

      END INPUT

      ON ACTION EXIT
         LET g_pmdn_d[l_ac1].* = l_pmdn_t.*
         EXIT DIALOG

      ON ACTION close
         EXIT DIALOG
   END DIALOG
END FUNCTION

################################################################################
# Descriptions...: 刪除所選擇的資料
# Memo...........:
# Usage..........: CALL apmp490_02_del_data()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/10/20 By ming
# Modify.........:
################################################################################
PUBLIC FUNCTION apmp490_02_del_data()
   DEFINE l_sql     STRING
   DEFINE l_ac1     LIKE type_t.num5
   DEFINE l_success LIKE type_t.num5   #170123-00050#1 add
   DEFINE l_wc      STRING             #170123-00050#1 add  

   IF g_appoint_idx <= 0 THEN
      RETURN
   END IF

   DELETE FROM p490_02_pmdn_t
    WHERE NVL(pmdl004,' ') = NVL(g_pmdn_d[g_appoint_idx].pmdl004_02_01,' ')
      AND pmdb004 = g_pmdn_d[g_appoint_idx].pmdb004_02_01
      AND pmdb005 = g_pmdn_d[g_appoint_idx].pmdb005_02_01
      AND pmdn014 = g_pmdn_d[g_appoint_idx].pmdn014_02_01                    #因為有費用料件
      AND NVL(pmdn050,' ') = NVL(g_pmdn_d[g_appoint_idx].pmdn050_02_01,' ')  #所以要多考慮備註 
      AND NVL(ooff013,' ') = NVL(g_pmdn_d[g_appoint_idx].ooff013_02_01,' ')  #161031-00025#6
      AND NVL(pmdl025,' ') = NVL(g_pmdn_d[g_appoint_idx].pmdl025_02_01,' ')
      AND NVL(pmdl026,' ') = NVL(g_pmdn_d[g_appoint_idx].pmdl026_02_01,' ')
      AND NVL(pmdn058,' ') = NVL(g_pmdn_d[g_appoint_idx].pmdn058_02_01,' ')
      AND NVL(pmdn036,' ') = NVL(g_pmdn_d[g_appoint_idx].pmdn036_02_01,' ')
      AND NVL(pmdn037,' ') = NVL(g_pmdn_d[g_appoint_idx].pmdn037_02_01,' ')
      AND NVL(pmdn038,' ') = NVL(g_pmdn_d[g_appoint_idx].pmdn038_02_01,' ')
      #160801-00004#3--s
      AND NVL(pmdn028,' ') = NVL(g_pmdn_d[g_appoint_idx].pmdn028_02_01,' ')
      AND NVL(pmdn029,' ') = NVL(g_pmdn_d[g_appoint_idx].pmdn029_02_01,' ')
      AND NVL(pmdn053,' ') = NVL(g_pmdn_d[g_appoint_idx].pmdn053_02_01,' ')
      #160801-00004#3--e  
      AND NVL(pmdbdocno,' ') = NVL(g_pmdn_d[g_appoint_idx].pmdbdocno_02_01,' ')
      AND NVL(pmdbseq,'0') = NVL(g_pmdn_d[g_appoint_idx].pmdbseq_02_01,'0')

   LET l_sql = "SELECT pmdb014,pmdl004,'',pmdb004,'','',pmdb005,'',pmdb007,'',",
               "       qty,pmdn014,pmdn001,'','',pmdn002,'',pmdn006,'',",
               "       pmdn007,pmdn008,'',pmdn009,pmdn010,'',pmdn011,",
               "       pmdl025,'','',pmdl026,'','',pmdn058,'',",
               "       pmdn036,'',pmdn037,'',pmdn038,'',",
               "       pmdn028,'',pmdn029,'',pmdn053,",  #160801-00004#3	
               #161031-00025#6-s-mod
#               "       pmdn050,pmdbdocno,pmdbseq,pmdbent,pmdbsite ",
               "       pmdn050,ooff013,ooff014,pmdbdocno,pmdbseq,pmdbent,pmdbsite ",
               #161031-00025#6-e-mod
               "  FROM p490_02_pmdn_t "
   
   PREPARE apmp490_02_del_data_b_fill_prep FROM l_sql
   DECLARE apmp490_02_del_data_b_fill_curs CURSOR FOR apmp490_02_del_data_b_fill_prep 
   
   CALL g_pmdn_d.clear()      #上方單身清空  
   LET l_ac1 = 1
   FOREACH apmp490_02_del_data_b_fill_curs INTO g_pmdn_d[l_ac1].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      #170123-00050#1 add  --begin--
      #把上方b_fill里抓说明等栏位的逻辑同步到这边
      
      #取得供应商说明
      SELECT pmaal004 INTO g_pmdn_d[l_ac1].pmaal004_02_01
        FROM pmaal_t
       WHERE pmaalent = g_enterprise
         AND pmaal001 = g_pmdn_d[l_ac1].pmdl004_02_01
         AND pmaal002 = g_dlang
       
      #取得料号品名规格       
      CALL apmp490_02_get_imaal(g_pmdn_d[l_ac1].pmdb004_02_01)
           RETURNING g_pmdn_d[l_ac1].imaal003_02_01_1,g_pmdn_d[l_ac1].imaal004_02_01_1

      CALL apmp490_02_get_imaal(g_pmdn_d[l_ac1].pmdn001_02_01)
           RETURNING g_pmdn_d[l_ac1].imaal003_02_01_2,g_pmdn_d[l_ac1].imaal004_02_01_2
           
      #取得產品特徵說明
      CALL s_feature_description(g_pmdn_d[l_ac1].pmdb004_02_01,g_pmdn_d[l_ac1].pmdb005_02_01)
           RETURNING l_success,g_pmdn_d[l_ac1].pmdb005_02_01_desc
      CALL s_feature_description(g_pmdn_d[l_ac1].pmdn001_02_01,g_pmdn_d[l_ac1].pmdn002_02_01)
           RETURNING l_success,g_pmdn_d[l_ac1].pmdn002_02_01_desc
      
      #取得請購單位說明
      CALL s_desc_get_unit_desc(g_pmdn_d[l_ac1].pmdb007_02_01)
           RETURNING g_pmdn_d[l_ac1].pmdb007_02_01_desc
           
      #取得採購單位說明
      CALL s_desc_get_unit_desc(g_pmdn_d[l_ac1].pmdn006_02_01)
           RETURNING g_pmdn_d[l_ac1].pmdn006_02_01_desc

      #取得參考單位說明
      CALL s_desc_get_unit_desc(g_pmdn_d[l_ac1].pmdn008_02_01)
           RETURNING g_pmdn_d[l_ac1].pmdn008_02_01_desc

      #取得計價單位說明
      CALL s_desc_get_unit_desc(g_pmdn_d[l_ac1].pmdn010_02_01)
           RETURNING g_pmdn_d[l_ac1].pmdn010_02_01_desc

      #取得專案編號說明
      CALL s_desc_get_project_desc(g_pmdn_d[l_ac1].pmdn036_02_01)
           RETURNING g_pmdn_d[l_ac1].pmdn036_02_01_desc

      #取得WBS編號說明
      CALL s_desc_get_wbs_desc(g_pmdn_d[l_ac1].pmdn036_02_01,g_pmdn_d[l_ac1].pmdn037_02_01)
           RETURNING g_pmdn_d[l_ac1].pmdn037_02_01_desc

      #取得活動編號說明
      CALL s_desc_get_activity_desc(g_pmdn_d[l_ac1].pmdn036_02_01,g_pmdn_d[l_ac1].pmdn038_02_01)
           RETURNING g_pmdn_d[l_ac1].pmdn038_02_01_desc
           
      #送貨地址
      IF cl_null(g_pmdn_d[l_ac1].pmdl025_02_01) THEN
         CALL apmp490_02_get_pmdl025_pmdl026('3') RETURNING g_pmdn_d[l_ac1].pmdl025_02_01
      END IF

      IF NOT cl_null(g_pmdn_d[l_ac1].pmdl025_02_01) THEN
         CALL s_apmp490_get_address('3',g_pmdn_d[l_ac1].pmdl025_02_01)
              RETURNING g_pmdn_d[l_ac1].pmdl025_02_01_desc,g_pmdn_d[l_ac1].pmdl025_02_01_oofb017
      END IF

      #帳款地址
      IF cl_null(g_pmdn_d[l_ac1].pmdl026_02_01) THEN
         CALL apmp490_02_get_pmdl025_pmdl026('5') RETURNING g_pmdn_d[l_ac1].pmdl026_02_01
      END IF

      IF NOT cl_null(g_pmdn_d[l_ac1].pmdl026_02_01) THEN
         CALL s_apmp490_get_address('5',g_pmdn_d[l_ac1].pmdl026_02_01)
              RETURNING g_pmdn_d[l_ac1].pmdl026_02_01_desc,g_pmdn_d[l_ac1].pmdl026_02_01_oofb017
      END IF
      
      #库位储位
      CALL s_desc_get_stock_desc(g_pmdn_d[l_ac1].pmdbsite_02_01,g_pmdn_d[l_ac1].pmdn028_02_01)
           RETURNING g_pmdn_d[l_ac1].pmdn028_02_01_desc

      CALL s_desc_get_locator_desc(g_pmdn_d[l_ac1].pmdbsite_02_01,g_pmdn_d[l_ac1].pmdn028_02_01,g_pmdn_d[l_ac1].pmdn029_02_01)
           RETURNING g_pmdn_d[l_ac1].pmdn029_02_01_desc

      #170123-00050#1 add  --end--
      
      LET l_ac1 = l_ac1 + 1
   END FOREACH

   CALL g_pmdn_d.deleteElement(l_ac1)
   LET l_ac1 = l_ac1 - 1

   IF l_ac1 < g_appoint_idx THEN
      LET g_appoint_idx = l_ac1
   END IF
   
   #170123-00050#1 add  --begin--
   SELECT ADD_MONTHS(g_today,-g_mm) INTO g_date FROM DUAL

   LET l_wc = "pmdldocdt BETWEEN '",g_date,"' AND '",g_today,"' "
   CALL apmp490_02_b_fill_02(l_wc)
   LET l_wc = "pmdsdocdt BETWEEN '",g_date,"' AND '",g_today,"' "
   CALL apmp490_02_b_fill_03(l_wc)
   LET l_wc = "qcbadocdt BETWEEN '",g_date,"' AND '",g_today,"' "
   CALL apmp490_02_b_fill_04(l_wc)
   #170123-00050#1 add  --end--
   
END FUNCTION

################################################################################
# Descriptions...: #160908-00029#1
# Memo...........:
# Date & Author..: 
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp490_02_pmdn007_chk(p_pmdldocno,p_pmdnseq,p_pmdn001,p_pmdn002,p_pmdn004,p_pmdn005,p_pmdn006,p_pmdn007)
DEFINE p_pmdldocno    LIKE pmdl_t.pmdldocno
DEFINE p_pmdnseq      LIKE pmdn_t.pmdnseq
DEFINE p_pmdn007      LIKE pmdn_t.pmdn007
DEFINE r_success      LIKE type_t.num5
DEFINE l_pmdp003      LIKE pmdp_t.pmdp003
DEFINE l_pmdp004      LIKE pmdp_t.pmdp004
DEFINE l_pmdb006      LIKE pmdb_t.pmdb006
DEFINE l_pmdb049      LIKE pmdb_t.pmdb049
DEFINE l_pmdn007      LIKE pmdn_t.pmdn007
DEFINE p_pmdn001      LIKE pmdn_t.pmdn001
DEFINE p_pmdn006      LIKE pmdn_t.pmdn006
DEFINE l_imaf143      LIKE imaf_t.imaf143  #採購單位
DEFINE l_imaf145      LIKE imaf_t.imaf145  #採購單位批量
DEFINE l_imaf146      LIKE imaf_t.imaf146  #採購最小數量
DEFINE l_imaf147      LIKE imaf_t.imaf147  #單位批量控管方式
DEFINE l_success      LIKE type_t.num5
DEFINE l_qty          LIKE pmdb_t.pmdb006  #數量
DEFINE l_mod          LIKE type_t.num10
DEFINE l_num          LIKE type_t.num10
DEFINE l_qty1         LIKE pmdb_t.pmdb006  #數量
DEFINE l_qty2         LIKE pmdb_t.pmdb006  #差異數量
DEFINE l_sum          LIKE pmdb_t.pmdb006  #最大可採購數量
DEFINE l_pmdb006_1    LIKE pmdb_t.pmdb006
DEFINE l_pmdb049_1    LIKE pmdb_t.pmdb049
DEFINE l_pmdn007_1    LIKE pmdn_t.pmdn007
DEFINE l_ooba002      LIKE ooba_t.ooba002
DEFINE l_type         LIKE type_t.chr1
DEFINE l_rate         LIKE type_t.num5
DEFINE l_pmdp024      LIKE pmdp_t.pmdp024
DEFINE l_sum1         LIKE pmdb_t.pmdb006
DEFINE l_n_qty        LIKE type_t.num10    
DEFINE l_msg          STRING               
DEFINE l_min_qty      LIKE pmdb_t.pmdb006
DEFINE r_pmdn007      LIKE pmdn_t.pmdn007
DEFINE l_max          LIKE pmdn_t.pmdn007
DEFINE l_qty3         LIKE pmdb_t.pmdb006  #數量
DEFINE l_pmdp012      LIKE pmdp_t.pmdp012
DEFINE l_pmdp007      LIKE pmdp_t.pmdp007
DEFINE l_pmdp008      LIKE pmdp_t.pmdp008
DEFINE l_pmdp009      LIKE pmdp_t.pmdp009
DEFINE l_pmdp010      LIKE pmdp_t.pmdp010
DEFINE l_pmdp011      LIKE pmdp_t.pmdp011
DEFINE l_pmdp023      LIKE pmdp_t.pmdp023
DEFINE l_pmdn014      LIKE pmdn_t.pmdn014
DEFINE l_pmdn006      LIKE pmdn_t.pmdn006
DEFINE p_pmdn002      LIKE pmdn_t.pmdn002 
DEFINE p_pmdn004      LIKE pmdn_t.pmdn004 
DEFINE p_pmdn005      LIKE pmdn_t.pmdn005 
DEFINE l_pmdp022      LIKE pmdp_t.pmdp022
DEFINE l_slip         LIKE pmda_t.pmdadocno
DEFINE l_flag         LIKE type_t.num5     
DEFINE l_pmdp005      LIKE pmdp_t.pmdp005
DEFINE l_pmdl005      LIKE pmdl_t.pmdl005


   LET r_success = TRUE
   LET r_pmdn007 = p_pmdn007
   
   #檢查料件編號是否符合條件

   #一般採購單    
   SELECT imaf143,imaf145,imaf146,imaf147 
     INTO l_imaf143,l_imaf145,l_imaf146,l_imaf147
     FROM imaf_t 
   WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = p_pmdn001
   IF SQLCA.SQLCODE = 100 THEN
    SELECT imaf143,imaf145,imaf146,imaf147 INTO l_imaf143,l_imaf145,l_imaf146,l_imaf147
      FROM imaf_t WHERE imafent = g_enterprise AND imafsite = "ALL" AND imaf001 = p_pmdn001
   END IF
   
   LET l_qty = p_pmdn007
   #需求單位與採購不一致時，需換算成採購單位對應的數量進行計算
   IF NOT cl_null(l_imaf143) THEN
      IF l_imaf143 <> p_pmdn006 AND (NOT cl_null(l_imaf143)) THEN
         CALL s_aooi250_convert_qty(p_pmdn001,p_pmdn006,l_imaf143,p_pmdn007)
              RETURNING l_success,l_qty
      END IF
    
      CALL s_aooi250_take_decimals(l_imaf143,l_qty) RETURNING l_success,l_qty
      IF NOT cl_null(l_imaf145) THEN
         CALL s_aooi250_take_decimals(l_imaf143,l_imaf145) RETURNING l_success,l_imaf145
      END IF
      IF NOT cl_null(l_imaf146) THEN
         CALL s_aooi250_take_decimals(l_imaf143,l_imaf146) RETURNING l_success,l_imaf146
      END IF    
   END IF
   
   IF NOT cl_null(l_imaf146) THEN
      IF l_imaf146 > l_qty THEN
         LET l_min_qty = l_imaf146
      ELSE 
         LET l_min_qty = l_qty
      END IF
   END IF 
   
   IF NOT cl_null(l_imaf145) AND l_imaf145 != 0 THEN
      LET l_n_qty = l_min_qty / l_imaf145
      IF l_min_qty != l_imaf145 * l_n_qty THEN
         IF l_min_qty > l_imaf145 * l_n_qty THEN
             LET l_qty1 = l_imaf145 * (l_n_qty + 1)
         ELSE
             LET l_qty1 = l_imaf145 * l_n_qty
         END IF
      ELSE
         LET l_qty1 = l_imaf145 * l_n_qty
      END IF
   ELSE
      LET l_qty1 = l_min_qty
   END IF
   
   IF l_qty < l_qty1 THEN
      CALL s_aooi250_convert_qty(p_pmdn001,l_imaf143,p_pmdn006,l_qty1)
           RETURNING l_success,l_qty3
      #警示
      IF l_imaf147 MATCHES '[1]' THEN
         LET l_msg = cl_getmsg('apm-00600',g_lang),l_qty3 USING '---,---,---,--&.&&&'
         IF cl_ask_promp(l_msg) THEN
            LET l_qty = l_qty1
         END IF
      END IF
      #嚴格控制
      IF l_imaf147 MATCHES '[2]' THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'apm-00711'
         LET g_errparam.extend = p_pmdn001
         LET g_errparam.replace[1] = l_qty3
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET l_qty = l_qty1
      END IF
   END IF
   
   IF l_imaf143 <> p_pmdn006 AND (NOT cl_null(l_imaf143)) THEN
      CALL s_aooi250_convert_qty(p_pmdn001,l_imaf143,p_pmdn006,l_qty)
           RETURNING l_success,r_pmdn007
   ELSE
      LET r_pmdn007 = l_qty
   END IF
   
   RETURN r_success,r_pmdn007
END FUNCTION

################################################################################
# Descriptions...: 根据据点取得送货地址和账款地址
# Memo...........:
# Date & Author..: 2016/12/15 By wuxja
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp490_02_get_pmdl025_pmdl026(p_oofb008)
DEFINE p_oofb008         LIKE oofb_t.oofb008
DEFINE l_oofa001         LIKE oofa_t.oofa001
DEFINE l_oofb001         LIKE oofb_t.oofb001
DEFINE l_oofb019         LIKE oofb_t.oofb019
   
   SELECT oofa001 INTO l_oofa001 FROM oofa_t
    WHERE oofaent = g_enterprise
      AND oofa002 = '1'
      AND oofa003 = g_site
   #先抓主要地址
   SELECT oofb001,oofb019 INTO l_oofb001,l_oofb019 FROM  oofb_t   
    WHERE oofbent = g_enterprise 
      AND oofb002 = l_oofa001 AND oofb008 = p_oofb008
      AND oofb010 = 'Y' AND oofbstus = 'Y'
   #抓不到就抓第一笔
   IF cl_null(l_oofb001) THEN
      DECLARE apmp490_02_get_pmdl025_pmdl026_cs CURSOR FOR
         SELECT oofb001,oofb019
           FROM oofb_t
          WHERE oofbent = g_enterprise
            AND oofb002 = l_oofa001
            AND oofb008 = p_oofb008   #聯絡地址
            AND oofbstus = 'Y'  #有效資料
          ORDER BY oofb001
      FOREACH apmp490_02_get_pmdl025_pmdl026_cs INTO l_oofb001,l_oofb019
         IF NOT cl_null(l_oofb001) THEN
            EXIT FOREACH
         END IF
      END FOREACH
   END IF
   
   RETURN l_oofb019
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apmp490_02_set_required_b(p_ac)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........: #161006-00018#21
################################################################################
PRIVATE FUNCTION apmp490_02_set_required_b(p_ac)
DEFINE  p_ac        LIKE type_t.num10
DEFINE  l_inaa007   LIKE inaa_t.inaa007

   IF p_ac <> 0 THEN  
      IF NOT cl_null(g_pmdn_d[p_ac].pmdn028_02_01) THEN
         SELECT inaa007 INTO l_inaa007 FROM inaa_t 
          WHERE inaaent = g_enterprise
            AND inaasite = g_site
            AND inaa001 = g_pmdn_d[p_ac].pmdn028_02_01 
         IF l_inaa007 <> '5' THEN
            CALL cl_set_comp_required("pmdn029_02_01",TRUE)
         END IF         
      END IF
   END IF
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apmp490_02_set_no_required_b(p_ac)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........: #161006-00018#21
################################################################################
PRIVATE FUNCTION apmp490_02_set_no_required_b(p_ac)
DEFINE  p_ac     LIKE type_t.num10
   CALL cl_set_comp_required("pmdn029_02_01",FALSE)
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apmp490_02_pmdn029_chk(p_ac)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........: #161006-00018#22
################################################################################
PRIVATE FUNCTION apmp490_02_pmdn029_chk(p_ac)
DEFINE  p_ac       LIKE type_t.num10
DEFINE  r_success  LIKE type_t.num5

   LET r_success = TRUE
   IF NOT cl_null(g_pmdn_d[p_ac].pmdn029_02_01) THEN 
      #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
      INITIALIZE g_chkparam.* TO NULL
      
      #設定g_chkparam.*的參數
      LET g_chkparam.arg1 = g_site
      LET g_chkparam.arg2 = g_pmdn_d[p_ac].pmdn028_02_01
      LET g_chkparam.arg3 = g_pmdn_d[p_ac].pmdn029_02_01
    
      #呼叫檢查存在並帶值的library
      IF NOT cl_chk_exist("v_inab002_1") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   RETURN r_success   

END FUNCTION

 
{</section>}
 
