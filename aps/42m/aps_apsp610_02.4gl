#該程式未解開Section, 採用最新樣板產出!
{<section id="apsp610_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0011(2016-10-14 14:48:27), PR版次:0011(2017-02-13 17:00:15)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000039
#+ Filename...: apsp610_02
#+ Description: APS產生採購單作業_分配處理
#+ Creator....: 05384(2016-01-22 11:31:56)
#+ Modifier...: 07024 -SD/PR- 07024
 
{</section>}
 
{<section id="apsp610_02.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"
#160318-00025#1   2016/04/06  By 07675       將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160512-00016#5   2016/06/01  By ming        增加欄位pspc062保稅否 
#160601-00032#3   2016/06/13  By ming        增加欄位 庫存管理特徵 
#160623-00033#1   2016/06/27  By ming        在apsp611中，apsp610_02_ins_pspc吃不到變數g_apsp610_02_input.scb02 
#                                            所以要增加傳入參數判斷是否匯總 
#160823-00015#1   2016/09/29  By dorislai    pmao_t改成抓pmat_t
#160825-00037#3   2016/10/14  By drosiali    1.畫面加上選項:將需求來源訂單放到庫存管理特徵 2.分配總匯方式為不匯總才能選擇
#161107-00031#1   2016/11/16  By shiun       依比例分配採購數量取位問題
#170104-00066#1  2017/01/04 By Rainy         筆數相關變數由num5放大至num10
#170109-00063#1   2017/01/24  By dorislai    1.修正供應商分配選3.依廠商分配，產生分配資料再往下一步時，出現沒有底稿的錯誤-pspc045重複寫
#                                            2.修正供應商分配選1.依料件主檔，產生的分配數量不正確的問題
#170125-00006#1   2017/02/13  By dorislai    修正第二步的供應商，與第三步的供應商，數量不相同(原因：寫入tmp時，多加了2個tmp裡面沒有define的變數)

#end add-point
#add-point:填寫註解說明(客製用) name="main.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="main.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
#add-point:增加匯入變數檔 name="global.inc"
GLOBALS "../../aps/4gl/apsp610_01.inc"
GLOBALS "../../aps/4gl/apsp610_02.inc"
#end add-point
 
{</section>}
 
{<section id="apsp610_02.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
 TYPE type_g_pspc_d RECORD
                              pmdb014_02_01         LIKE pmdb_t.pmdb014,     #供應商選擇 
                              pmdl004_02_01         LIKE pmdl_t.pmdl004,     #供應商編號  
                              pmaal004_02_01        LIKE pmaal_t.pmaal004,   #供應商名稱 
                              pspc050_02_01         LIKE pspc_t.pspc050,     #料件編號  
                              imaal003_02_01_1      LIKE imaal_t.imaal003,   #品名  
                              imaal004_02_01_1      LIKE imaal_t.imaal004,   #規格  
                              pspc051_02_01         LIKE pspc_t.pspc051,     #產品特徵   
                              pspc051_02_01_desc    LIKE type_t.chr500,      #產品特徵說明  
                              #160512-00016#5 20160601 add by ming -----(S) 
                              pspc062_02_01         LIKE pspc_t.pspc062,     #保稅否 
                              #160512-00016#5 20160601 add by ming -----(E) 
                              pspc014_02_01         LIKE pspc_t.pspc014,     #單位  
                              pspc014_02_01_desc    LIKE type_t.chr80,       #單位說明 
                              qty_02_01             LIKE pmdb_t.pmdb006,     #未轉採購量  
                              pspc045_02_01         LIKE pspc_t.pspc045,     #到庫日期  
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
                              pmdn058_02_01_desc    LIKE type_t.chr500,      #預算科目說明 
                              pmdn036_02_01         LIKE pmdn_t.pmdn036,     #專案編號 
                              pmdn036_02_01_desc    LIKE type_t.chr500,      #專案編號說明 
                              pmdn037_02_01         LIKE pmdn_t.pmdn037,     #WBS 
                              pmdn037_02_01_desc    LIKE type_t.chr500,      #WBS說明 
                              pmdn038_02_01         LIKE pmdn_t.pmdn038,     #活動編號 
                              pmdn038_02_01_desc    LIKE type_t.chr500,      #活動編號說明 
                              pmdn050_02_01         LIKE pmdn_t.pmdn050,     #備註  
                              pmdbdocno_02_01       LIKE pmdb_t.pmdbdocno,   #請購單號 
                              pmdbseq_02_01         LIKE pmdb_t.pmdbseq,     #請購項次 
                              pmdn053_02_01         LIKE pmdn_t.pmdn053      #庫存管理特徵  #160601-00032#3 20160613 add 
                           END RECORD
DEFINE g_pspc_d            DYNAMIC ARRAY OF type_g_pspc_d
DEFINE g_pspc_d_t          type_g_pspc_d
#DEFINE l_ac                LIKE type_t.num5   #170104-00066#1 mark by rainy
DEFINE l_ac                LIKE type_t.num10   #170104-00066#1 add by rainy

DEFINE g_ref_fields        DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields        DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列  

#170104-00066#1 (B)  17/01/05 modify by rainy 
#DEFINE g_rec_b             LIKE type_t.num5
#DEFINE g_detail_idx        LIKE type_t.num5
DEFINE g_rec_b             LIKE type_t.num10
DEFINE g_detail_idx        LIKE type_t.num10
#170104-00066#1 (E)  17/01/05 modify by rainy 
DEFINE g_apsp610_02_pmdn_d DYNAMIC ARRAY OF RECORD
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
DEFINE g_apsp610_02_pmds_d DYNAMIC ARRAY OF RECORD
                              pmds009_02_03       LIKE pmds_t.pmds009,      #送貨供應商  
                              pmaal004_02_03      LIKE pmaal_t.pmaal004,    #供應商名稱 
                              pmdsdocno_02_03     LIKE pmds_t.pmdsdocno,    #單據單號  
                              pmdo013_02_03       LIKE pmdo_t.pmdo013,      #到庫日期  
                              pmdsdocdt_02_03     LIKE pmds_t.pmdsdocdt,    #單據日期  
                              stus_02_03          LIKE type_t.chr20,        #狀態  
                              diff_day_02_03      LIKE type_t.num10         #差異天數  
                           END RECORD 
DEFINE g_apsp610_02_qcba_d DYNAMIC ARRAY OF RECORD
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
DEFINE g_apsp610_02_pmdn_color_d DYNAMIC ARRAY OF RECORD
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
 
{<section id="apsp610_02.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="apsp610_02.other_dialog" >}

DIALOG apsp610_02_input01()
   DEFINE l_sql     STRING
   DEFINE l_sql1    STRING
   DEFINE l_sql2    STRING
   DEFINE l_success LIKE type_t.num5
   DEFINE l_wc      STRING

   INPUT BY NAME g_apsp610_02_input.scb01,g_apsp610_02_input.scb02,
                 g_apsp610_02_input.chk1, #160825-00037#3-add
                 g_apsp610_02_input.bt01,g_apsp610_02_input.ed01,
                 g_apsp610_02_input.scb03
                 ATTRIBUTE(WITHOUT DEFAULTS)

      BEFORE INPUT
         CALL apsp610_02_set_entry('a')
         CALL apsp610_02_set_no_entry('a')

      AFTER INPUT

      ON CHANGE scb01
         CALL apsp610_02_set_entry('a')
         CALL apsp610_02_set_no_entry('a')

      AFTER FIELD bt01
        CALL apsp610_02_bt01_ref(g_apsp610_02_input.bt01) RETURNING g_apsp610_02_input.bt01_desc
        DISPLAY BY NAME g_apsp610_02_input.bt01_desc

        IF NOT cl_null(g_apsp610_02_input.bt01) THEN
           IF NOT apsp610_02_pmdl004_chk(g_apsp610_02_input.bt01) THEN
              
              NEXT FIELD CURRENT 
           END IF

        END IF

      AFTER FIELD ed01
         IF NOT cl_null(g_apsp610_02_input.ed01) THEN
            IF g_apsp610_02_input.ed01 <= 0 THEN    #必輸不可空白，數量需>0  
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'ade-00016'    #數量不可小於等於0
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
           
               NEXT FIELD CURRENT
            END IF
         END IF
      
      #160825-00037#3-s-add
      ON CHANGE scb02
         IF g_apsp610_02_input.scb02 MATCHES "[12]" THEN
            LET g_apsp610_02_input.chk1 = 'N'
            DISPLAY BY NAME g_apsp610_02_input.chk1
         END IF
         CALL apsp610_02_set_entry('')
         CALL apsp610_02_set_no_entry('')
      #160825-00037#3-e-add
      
      ON CHANGE scb03
         #當「參考資料期間」改變的時候 要重新找符合期間的資料  
         CASE g_apsp610_02_input.scb03
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
         CALL apsp610_02_b_fill_02(l_wc)
         LET l_wc = "pmdsdocdt BETWEEN '",g_date,"' AND '",g_today,"' "
         CALL apsp610_02_b_fill_03(l_wc)
         LET l_wc = "qcbadocdt BETWEEN '",g_date,"' AND '",g_today,"' "
         CALL apsp610_02_b_fill_04(l_wc)

      ON ACTION controlp INFIELD bt01
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'i'
         LET g_qryparam.reqry = FALSE

         LET g_qryparam.default1 = g_apsp610_02_input.bt01

         LET g_qryparam.where = "1=1 "

         #統一使用s_control_get_supplier_sql()回傳的sql丟入where條件即可 
         CALL s_control_get_supplier_sql('4',g_site,g_user,g_dept,g_apsp610_01_input.pmdldocno)
              RETURNING l_success,l_sql
         IF l_success THEN
            LET g_qryparam.where = l_sql
         END IF

         CALL q_pmaa001_3()

         LET g_apsp610_02_input.bt01 = g_qryparam.return1
         DISPLAY g_apsp610_02_input.bt01 TO bt01

         NEXT FIELD bt01

   END INPUT
END DIALOG

DIALOG apsp610_02_display01()
   DEFINE l_wc     STRING

   DISPLAY ARRAY g_pspc_d TO s_apsp610_02_detail1.* ATTRIBUTE(COUNT=g_d_cnt_p61002_01)
      BEFORE DISPLAY
         CALL FGL_SET_ARR_CURR(g_d_idx_p61002_01)
         #ming 欄位變色 參考apmt410 
         CALL DIALOG.setCellAttributes(g_apsp610_02_pmdn_color_d)
         #單身不連動, 所以進入單身時, 要重新顯示單身筆數
         #DISPLAY g_d_idx_i35001, g_d_cnt_i35001 TO FORMONLY.idx, FORMONLY.cnt 

      BEFORE ROW
         LET g_d_idx_p61002_01 = DIALOG.getCurrentRow("s_apsp610_02_detail1")
         # 點的當筆放入g_appoint_idx中, 可讓雙擊直接進入指定筆
         LET g_appoint_idx = g_d_idx_p61002_01

         SELECT ADD_MONTHS(g_today,-g_mm) INTO g_date FROM DUAL

         LET l_wc = "pmdldocdt BETWEEN '",g_date,"' AND '",g_today,"' "
         CALL apsp610_02_b_fill_02(l_wc)
         LET l_wc = "pmdsdocdt BETWEEN '",g_date,"' AND '",g_today,"' "
         CALL apsp610_02_b_fill_03(l_wc)
         LET l_wc = "qcbadocdt BETWEEN '",g_date,"' AND '",g_today,"' "
         CALL apsp610_02_b_fill_04(l_wc)


   END DISPLAY
END DIALOG

DIALOG apsp610_02_display02()
   DISPLAY ARRAY g_apsp610_02_pmdn_d TO s_apsp610_02_detail2.* ATTRIBUTE(COUNT=g_d_cnt_p61002_02)
      BEFORE DISPLAY
         CALL FGL_SET_ARR_CURR(g_d_idx_p61002_02)
         #單身不連動, 所以進入單身時, 要重新顯示單身筆數
         #DISPLAY g_d_idx_i35001, g_d_cnt_i35001 TO FORMONLY.idx, FORMONLY.cnt 

      BEFORE ROW
         LET g_d_idx_p61002_02 = DIALOG.getCurrentRow("s_apsp610_02_detail2")
         # 點的當筆放入g_appoint_idx中, 可讓雙擊直接進入指定筆
         LET g_appoint_idx = g_d_idx_p61002_02
   END DISPLAY
END DIALOG

DIALOG apsp610_02_display03()
   DISPLAY ARRAY g_apsp610_02_pmds_d TO s_apsp610_02_detail3.* ATTRIBUTE(COUNT=g_d_cnt_p61002_03)
      BEFORE DISPLAY
         CALL FGL_SET_ARR_CURR(g_d_idx_p61002_03)
         #單身不連動, 所以進入單身時, 要重新顯示單身筆數
         #DISPLAY g_d_idx_i35001, g_d_cnt_i35001 TO FORMONLY.idx, FORMONLY.cnt 

      BEFORE ROW
         LET g_d_idx_p61002_03 = DIALOG.getCurrentRow("s_apsp610_02_detail3")
         # 點的當筆放入g_appoint_idx中, 可讓雙擊直接進入指定筆
         LET g_appoint_idx = g_d_idx_p61002_03
   END DISPLAY
END DIALOG

DIALOG apsp610_02_display04()
   DISPLAY ARRAY g_apsp610_02_qcba_d TO s_apsp610_02_detail4.* ATTRIBUTE(COUNT=g_d_cnt_p61002_04)
      BEFORE DISPLAY
         CALL FGL_SET_ARR_CURR(g_d_idx_p61002_04)
         #單身不連動, 所以進入單身時, 要重新顯示單身筆數      

      BEFORE ROW
         LET g_d_idx_p61002_04 = DIALOG.getCurrentRow("s_apsp610_02_detail4")
         # 點的當筆放入g_appoint_idx中, 可讓雙擊直接進入指定筆
         LET g_appoint_idx = g_d_idx_p61002_04
   END DISPLAY
END DIALOG

 
{</section>}
 
{<section id="apsp610_02.other_function" readonly="Y" >}

PUBLIC FUNCTION apsp610_02(--)
   #add-point:input段變數傳入

   #end add-point
   )
   {
   DEFINE l_ac_t          LIKE type_t.num5        #未取消的ARRAY CNT
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否
   DEFINE l_count         LIKE type_t.num5
   DEFINE l_insert        LIKE type_t.num5
   DEFINE p_cmd           LIKE type_t.chr5
   #add-point:input段define

   #end add-point

   #畫面開啟 (identifier)
   OPEN WINDOW w_apsp610_02 WITH FORM cl_ap_formpath("apm","apsp610_02")

   #瀏覽頁簽資料初始化
   CALL cl_ui_init()

   LET g_qryparam.state = "i"
   LET p_cmd = 'a'

   #輸入前處理
   #add-point:單頭前置處理

   #end add-point

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #輸入開始
      INPUT BY NAME g_apaa_m.apaa001,g_apaa_m.apaa002 ATTRIBUTE(WITHOUT DEFAULTS)

         #自訂ACTION
         #add-point:單頭前置處理

         #end add-point

         #自訂ACTION(master_input)


         BEFORE INPUT
            #add-point:單頭輸入前處理

            #end add-point

         #---------------------------<  Master  >---------------------------
         #----<<apaa001>>----
         #此段落由子樣板a02產生
         AFTER FIELD apaa001

            #add-point:AFTER FIELD apaa001
            IF NOT cl_null(g_apaa_m.apaa001) THEN
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg2 = '參數2'
               #160318-00025#1--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "abm-00079:sub-01302|apmm100|",cl_get_progname("apmm100",g_lang,"2"),"|:EXEPROGapmm100"
               #160318-00025#1--add--end
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_apaa001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF


            END IF
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_apaa_m.apaa_t.apaa001
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_apaa_m.apaa001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_apaa_m.apaa001_desc

            #此段落由子樣板a05產生
            IF  NOT cl_null(g_apaa_m.apaa001) AND NOT cl_null(g_apaa_m.apaa002) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_apaa_m.apaa001 != g_apaa001_t  OR g_apaa_m.apaa002 != g_apaa002_t )) THEN
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM apaa_t WHERE "||"apaaent = '" ||g_enterprise|| "' AND apaasite = '" ||g_site|| "' AND "||"apaa001 = '"||g_apaa_m.apaa001 ||"' AND "|| "apaa002 = '"||g_apaa_m.apaa002 ||"'",'std-00004',0) THEN
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD apaa001
            #add-point:BEFORE FIELD apaa001

            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE apaa001
            #add-point:ON CHANGE apaa001

            #END add-point

         #----<<apaa001_desc>>----
         #----<<apaa002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD apaa002
            #add-point:BEFORE FIELD apaa002

            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD apaa002

            #add-point:AFTER FIELD apaa002
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_apaa_m.apaa001) AND NOT cl_null(g_apaa_m.apaa002) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_apaa_m.apaa001 != g_apaa001_t  OR g_apaa_m.apaa002 != g_apaa002_t )) THEN
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM apaa_t WHERE "||"apaaent = '" ||g_enterprise|| "' AND apaasite = '" ||g_site|| "' AND "||"apaa001 = '"||g_apaa_m.apaa001 ||"' AND "|| "apaa002 = '"||g_apaa_m.apaa002 ||"'",'std-00004',0) THEN
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE apaa002
            #add-point:ON CHANGE apaa002

            #END add-point

 #欄位檢查
         #---------------------------<  Master  >---------------------------
         #----<<apaa001>>----
         #Ctrlp:input.c.apaa001
         ON ACTION controlp INFIELD apaa001
            #add-point:ON ACTION controlp INFIELD apaa001
            #此段落由子樣板a07產生
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_apaa_m.apaa001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #


            CALL q_pmaa001_1()                                #呼叫開窗

            LET g_apaa_m.apaa001 = g_qryparam.return1

            DISPLAY g_apaa_m.apaa001 TO apaa001              #

            NEXT FIELD apaa001                          #返回原欄位


            #END add-point

         #----<<apaa001_desc>>----
         #----<<apaa002>>----
         #Ctrlp:input.c.apaa002
#         ON ACTION controlp INFIELD apaa002
            #add-point:ON ACTION controlp INFIELD apaa002

            #END add-point

 #欄位開窗

         AFTER INPUT
            #add-point:單頭輸入後處理

            #end add-point

      END INPUT

      #add-point:自定義input

      #end add-point

      #公用action
      ON ACTION accept
         ACCEPT DIALOG

      ON ACTION cancel
         LET INT_FLAG = TRUE
         EXIT DIALOG

      ON ACTION close
         LET INT_FLAG = TRUE
         EXIT DIALOG

      ON ACTION exit
         LET INT_FLAG = TRUE
         EXIT DIALOG

      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
   END DIALOG

   #add-point:畫面關閉前

   #end add-point

   #畫面關閉
   CLOSE WINDOW w_apsp610_02

   #add-point:input段after input

   #end add-point
}
END FUNCTION

################################################################################
# Descriptions...: 資料初始設定
# Memo...........:
# Usage..........: CALL apsp610_02_init()
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_02_init()
   DEFINE l_msg     STRING 
 
   WHENEVER ERROR CONTINUE 

   #設定ComboBox的選項 

   #增加選項 
   LET l_msg = cl_getmsg("apm-00469",g_lang),",",         #1.依料件主檔設定   
               cl_getmsg("apm-00470",g_lang),",",         #2.主要供應商，無限量  
               cl_getmsg("apm-00471",g_lang),",",         #3.依廠商分配  
               cl_getmsg("apm-00472",g_lang),",",         #4.主要供應商分配優先，餘量分配  
               cl_getmsg("apm-00473",g_lang),",",         #5.指定單一供應商  
               cl_getmsg("apm-01039",g_lang)              #6.預設取價條件之最低價供應商 
   CALL cl_set_combo_items("scb01","1,2,3,4,5,6",l_msg)

   #增加選項3.不匯總 
   LET l_msg = cl_getmsg("apm-00474",g_lang),",",         #1.依料件進行匯總  
               cl_getmsg("apm-00475",g_lang),",",         #2.依料件+需求日期進行匯總  
               cl_getmsg("apm-01108",g_lang)              #3.不匯總  
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
   LET g_apsp610_02_input.scb01 = 1
   LET g_apsp610_02_input.scb02 = 1
   LET g_apsp610_02_input.scb03 = 3

   CASE g_apsp610_02_input.scb03
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
      CALL cl_set_comp_visible("pspc051_02_01,pspc051_02_01_desc",FALSE)
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
   
   #使用以下程式碼，以保證其畫面為「整數」 
   #CALL cl_set_comp_format("pmdn007_02_01",'---,---,---,--&')
   #CALL cl_set_comp_format("pmdn007_02_02",'---,---,---,--&')
   #CALL cl_set_comp_format("qcba017_02_04",'---,---,---,--&')
   #CALL cl_set_comp_format("qcba023_02_04",'---,---,---,--&')
   
   LET g_apsp610_02_input.chk1 = 'N'  #160825-00037#3-add
   
   CALL g_pspc_d.clear()      #上方單身清空  
   CALL g_apsp610_02_pmdn_d.clear()
   CALL g_apsp610_02_pmds_d.clear()
   CALL g_apsp610_02_qcba_d.clear()
END FUNCTION

################################################################################
# Descriptions...: 畫面欄位開關設定
# Memo...........:
# Usage..........: CALL apsp610_02_set_entry(p_cmd)
# Input parameter: p_cmd:模式
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_02_set_entry(p_cmd)
   DEFINE p_cmd LIKE type_t.chr1

   WHENEVER ERROR CONTINUE 

   CALL cl_set_comp_entry("ed01",TRUE) 
   CALL cl_set_comp_entry("bt01",TRUE)
   CALL cl_set_comp_entry("chk1",TRUE)  #160825-00037#3-add
   
END FUNCTION

################################################################################
# Descriptions...: 畫面欄位開關設定
# Memo...........:
# Usage..........: CALL apsp610_02_set_no_entry(p_cmd)
# Input parameter: p_cmd:模式
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_02_set_no_entry(p_cmd)
   DEFINE p_cmd LIKE type_t.chr1

   WHENEVER ERROR CONTINUE 

   IF g_apsp610_02_input.scb01 <> 4 THEN
      CALL cl_set_comp_entry("ed01",FALSE)
   END IF 
   
   IF g_apsp610_02_input.scb01 <> '1' AND g_apsp610_02_input.scb01 <> '5' THEN
      CALL cl_set_comp_entry("bt01",FALSE)
   END IF
   
   #160825-00037#3-s-add
   IF g_apsp610_02_input.scb02 MATCHES '[12]' THEN
      CALL cl_set_comp_entry("chk1",FALSE)
   END IF
   #160825-00037#3-e-add
END FUNCTION

################################################################################
# Descriptions...: 上方單身資料填充
# Memo...........:
# Usage..........: CALL apsp610_02_b_fill_01(p_wc)
# Input parameter: p_wc
# Date & Author..: 2016/01/22 By shiun
# Modify.........: 160512-00016#5  2016/06/01 by ming 
################################################################################
PUBLIC FUNCTION apsp610_02_b_fill_01(p_wc)
   DEFINE p_wc     STRING
   DEFINE l_sql    STRING
   #DEFINE l_ac1    LIKE type_t.num5     #170104-00066#1 17/01/05 mark by rainy 
   DEFINE l_ac1    LIKE type_t.num10     #170104-00066#1 17/01/05 add by rainy 
   DEFINE l_success LIKE type_t.num5
   DEFINE l_rate    LIKE inaj_t.inaj014
   DEFINE l_pspc_d  type_g_pspc_d
   DEFINE l_imaf152 LIKE imaf_t.imaf152 
   DEFINE l_wc      STRING  
   DEFINE l_oofa001 LIKE oofa_t.oofa001


   WHENEVER ERROR CONTINUE 

   IF g_apsp610_02_input.scb01 = '4' THEN        #主要供應商分配優先，餘量分配  
      IF cl_null(g_apsp610_02_input.ed01) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ''
         LET g_errparam.code   = 'apm-00695'     #主要供應商分配優先，餘量分配時，主供應商分配限量不可為空！   
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         RETURN
      END IF

      IF g_apsp610_02_input.ed01 <= 0 THEN    #必輸不可空白，數量需>0  
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ''
         LET g_errparam.code   = 'ade-00016' #數量不可小於等於0   
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         RETURN
      END IF
   END IF 
   
   IF g_apsp610_02_input.scb01 = '5' THEN        #指定單一供應商  
      IF cl_null(g_apsp610_02_input.bt01) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ''
         LET g_errparam.code   = 'art-00282'     #供應商欄位不可為空！  
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         RETURN
      END IF

      #檢查供應商 
      IF NOT apsp610_02_pmdl004_chk(g_apsp610_02_input.bt01) THEN
         RETURN
      END IF

      #顯示供應商名稱說明 
      CALL apsp610_02_bt01_ref(g_apsp610_02_input.bt01) RETURNING g_apsp610_02_input.bt01_desc
      DISPLAY BY NAME g_apsp610_02_input.bt01_desc
   END IF 
   
   IF NOT cl_null(g_apsp610_02_input.bt01) THEN
      IF NOT apsp610_02_pmdl004_chk(g_apsp610_02_input.bt01) THEN
         RETURN
      END IF
   END IF


   DELETE FROM p610_02_pmdn_t;
   DELETE FROM p610_02_pspc_t;

   UPDATE p610_01_pspc_t SET applied_qty = '0'

   CALL g_pspc_d.clear()

   CASE g_apsp610_02_input.scb02     #匯總方式  
      WHEN '1'     #依料件進行匯總  
         #160601-00032#3 20160613 modify by ming -----(S) 
         ##160512-00016#5 20160601 modify by ming -----(S) 
         ##LET l_sql = "SELECT '',t1.pspc012,'',t0.pspc050,'','',t0.pspc051,'',t0.pspc014,'',SUM(t0.qty),",
         ##            "       '','','','','','','','','','','','','','','', ",
         ##            "       '','','','','','', ",   #地址
         ##            "       '','', ",
         ##            "       '','','','','','', ",
         ##            "       '','','' ",
         ##            "  FROM p610_01_pspc_t t0 ",
         ##            "  LEFT OUTER JOIN pspc_t t1 ON t1.pspcent = '",g_enterprise,"' AND t1.pspc001 = t0.pspc001 AND t1.pspc002 = t0.pspc002 AND t1.pspc004 = t0.pspc004 ",
         ##            " ,imaf_t ",
         ##            " WHERE imafent = '",g_enterprise,"' ",
         ##            "   AND imafsite = '",g_site,"' ",
         ##            "   AND imaf001 = t0.pspc050 ", 
         ##            " GROUP BY t0.pspc050,t0.pspc051,t0.pspc014,t1.pspc012 ",
         ##            " ORDER BY pspc050,pspc051 " 
         #LET l_sql = "SELECT '',t1.pspc012,'',t0.pspc050,'','',t0.pspc051,'',t0.pspc062,t0.pspc014,'',SUM(t0.qty),",
         #            "       '','','','','','','','','','','','','','','', ",
         #            "       '','','','','','', ",   #地址
         #            "       '','', ",
         #            "       '','','','','','', ",
         #            "       '','','' ",
         #            "  FROM p610_01_pspc_t t0 ",
         #            "  LEFT OUTER JOIN pspc_t t1 ON t1.pspcent = '",g_enterprise,"' AND t1.pspc001 = t0.pspc001 AND t1.pspc002 = t0.pspc002 AND t1.pspc004 = t0.pspc004 ",
         #            " ,imaf_t ",
         #            " WHERE imafent = '",g_enterprise,"' ",
         #            "   AND imafsite = '",g_site,"' ",
         #            "   AND imaf001 = t0.pspc050 ", 
         #            " GROUP BY t0.pspc050,t0.pspc051,t0.pspc062,t0.pspc014,t1.pspc012 ",
         #            " ORDER BY pspc050,pspc051 " 
         ##160512-00016#5 20160601 modify by ming -----(E) 
         LET l_sql = "SELECT '',t1.pspc012,'',t0.pspc050,'','',t0.pspc051,'',t0.pspc062,t0.pspc014,'',SUM(t0.qty),",
                     "       '','','','','','','','','','','','','','','', ",
                     "       '','','','','','', ",   #地址
                     "       '','', ",
                     "       '','','','','','', ",
                     "       '','','','' ",
                     "  FROM p610_01_pspc_t t0 ",
                     "  LEFT OUTER JOIN pspc_t t1 ON t1.pspcent = '",g_enterprise,"' AND t1.pspc001 = t0.pspc001 AND t1.pspc002 = t0.pspc002 AND t1.pspc004 = t0.pspc004 ",
                     " ,imaf_t ",
                     " WHERE imafent = '",g_enterprise,"' ",
                     "   AND imafsite = '",g_site,"' ",
                     "   AND imaf001 = t0.pspc050 ", 
                     " GROUP BY t0.pspc050,t0.pspc051,t0.pspc062,t0.pspc014,t1.pspc012 ",
                     " ORDER BY pspc050,pspc051 " 
         #160601-00032#3 20160613 modify by ming -----(E) 
      WHEN '2'     #依料件+需求日進行匯總  
         #160601-00032#3 20160613 modify by ming -----(S) 
         ##160512-00016#5 20160601 modify by ming -----(S) 
         ##LET l_sql = "SELECT '',t1.pspc012,'',t0.pspc050,'','',t0.pspc051,'',t0.pspc014,'',SUM(t0.qty),",
         ##            "       t0.pspc045,'','','','','','','','','','','','','','', ",
         ##            "       '','','','','','', ",   #地址
         ##            "       '','', ",
         ##            "       '','','','','','', ",
         ##            "       '','','' ",
         ##            "  FROM p610_01_pspc_t t0 ",
         ##            "  LEFT OUTER JOIN pspc_t t1 ON t1.pspcent = '",g_enterprise,"' AND t1.pspc001 = t0.pspc001 AND t1.pspc002 = t0.pspc002 AND t1.pspc004 = t0.pspc004 ",
         ##            " ,imaf_t ",
         ##            " WHERE imafent = '",g_enterprise,"' ",
         ##            "   AND imafsite = '",g_site,"' ",
         ##            "   AND imaf001 = t0.pspc050 ",
         ##            " GROUP BY t0.pspc050,t0.pspc051,t0.pspc014,t0.pspc045,t1.pspc012 ",
         ##            " ORDER BY pspc050,pspc051 " 
         #LET l_sql = "SELECT '',t1.pspc012,'',t0.pspc050,'','',t0.pspc051,'',t0.pspc062,t0.pspc014,'',SUM(t0.qty),",
         #            "       t0.pspc045,'','','','','','','','','','','','','','', ",
         #            "       '','','','','','', ",   #地址
         #            "       '','', ",
         #            "       '','','','','','', ",
         #            "       '','','' ",
         #            "  FROM p610_01_pspc_t t0 ",
         #            "  LEFT OUTER JOIN pspc_t t1 ON t1.pspcent = '",g_enterprise,"' AND t1.pspc001 = t0.pspc001 AND t1.pspc002 = t0.pspc002 AND t1.pspc004 = t0.pspc004 ",
         #            " ,imaf_t ",
         #            " WHERE imafent = '",g_enterprise,"' ",
         #            "   AND imafsite = '",g_site,"' ",
         #            "   AND imaf001 = t0.pspc050 ",
         #            " GROUP BY t0.pspc050,t0.pspc051,t0.pspc062,t0.pspc014,t0.pspc045,t1.pspc012 ",
         #            " ORDER BY pspc050,pspc051 "
         ##160512-00016#5 20160601 modify by ming -----(E) 
         LET l_sql = "SELECT '',t1.pspc012,'',t0.pspc050,'','',t0.pspc051,'',t0.pspc062,t0.pspc014,'',SUM(t0.qty),",
                     "       t0.pspc045,'','','','','','','','','','','','','','', ",
                     "       '','','','','','', ",   #地址
                     "       '','', ",
                     "       '','','','','','', ",
                     "       '','','','' ",
                     "  FROM p610_01_pspc_t t0 ",
                     "  LEFT OUTER JOIN pspc_t t1 ON t1.pspcent = '",g_enterprise,"' AND t1.pspc001 = t0.pspc001 AND t1.pspc002 = t0.pspc002 AND t1.pspc004 = t0.pspc004 ",
                     " ,imaf_t ",
                     " WHERE imafent = '",g_enterprise,"' ",
                     "   AND imafsite = '",g_site,"' ",
                     "   AND imaf001 = t0.pspc050 ",
                     " GROUP BY t0.pspc050,t0.pspc051,t0.pspc062,t0.pspc014,t0.pspc045,t1.pspc012 ",
                     " ORDER BY pspc050,pspc051 "
         #160601-00032#3 20160613 modify by ming -----(E) 
      WHEN '3'     #不匯總  
         #160601-00032#3 20160613 modify by ming -----(S) 
         ##160512-00016#5 20160601 modify by ming -----(S) 
         ##LET l_sql = "SELECT '',t1.pspc012,'',t0.pspc050,'','',t0.pspc051,'',t0.pspc014,'',t0.qty,",
         ##            "       t0.pspc045,'','','','','','','','','','','','','','', ",
         ##            "       '','','','','','', ",   #地址
         ##            "       '','', ",
         ##            "       '','','','','','', ",
         ##            "       '',t0.pspc004,'' ",
         ##            "  FROM p610_01_pspc_t t0 ",
         ##            "  LEFT OUTER JOIN pspc_t t1 ON t1.pspcent = '",g_enterprise,"' AND t1.pspc001 = t0.pspc001 AND t1.pspc002 = t0.pspc002 AND t1.pspc004 = t0.pspc004 ",
         ##            " ,imaf_t ",
         ##            " WHERE imafent = '",g_enterprise,"' ",
         ##            "   AND imafsite = '",g_site,"' ",
         ##            "   AND imaf001 = t0.pspc050 ",
         ##            " ORDER BY pspc050,pspc051 " 
         #LET l_sql = "SELECT '',t1.pspc012,'',t0.pspc050,'','',t0.pspc051,'',t0.pspc062,t0.pspc014,'',t0.qty,",
         #            "       t0.pspc045,'','','','','','','','','','','','','','', ",
         #            "       '','','','','','', ",   #地址
         #            "       '','', ",
         #            "       '','','','','','', ",
         #            "       '',t0.pspc004,'' ",
         #            "  FROM p610_01_pspc_t t0 ",
         #            "  LEFT OUTER JOIN pspc_t t1 ON t1.pspcent = '",g_enterprise,"' AND t1.pspc001 = t0.pspc001 AND t1.pspc002 = t0.pspc002 AND t1.pspc004 = t0.pspc004 ",
         #            " ,imaf_t ",
         #            " WHERE imafent = '",g_enterprise,"' ",
         #            "   AND imafsite = '",g_site,"' ",
         #            "   AND imaf001 = t0.pspc050 ",
         #            " ORDER BY pspc050,pspc051 "
         ##160512-00016#5 20160601 modify by ming -----(E) 
         LET l_sql = "SELECT '',t1.pspc012,'',t0.pspc050,'','',t0.pspc051,'',t0.pspc062,t0.pspc014,'',t0.qty,",
                     "       t0.pspc045,'','','','','','','','','','','','','','', ",
                     "       '','','','','','', ",   #地址
                     "       '','', ",
                     "       '','','','','','', ",
                     "       '',t0.pspc004,'',t0.pspc018 ",
                     "  FROM p610_01_pspc_t t0 ",
                     "  LEFT OUTER JOIN pspc_t t1 ON t1.pspcent = '",g_enterprise,"' AND t1.pspc001 = t0.pspc001 AND t1.pspc002 = t0.pspc002 AND t1.pspc004 = t0.pspc004 ",
                     " ,imaf_t ",
                     " WHERE imafent = '",g_enterprise,"' ",
                     "   AND imafsite = '",g_site,"' ",
                     "   AND imaf001 = t0.pspc050 ",
                     " ORDER BY pspc050,pspc051 "
         #160601-00032#3 20160613 modify by ming -----(E) 
   END CASE
   
   PREPARE apsp610_02_group_prep FROM l_sql
   DECLARE apsp610_02_group_curs CURSOR FOR apsp610_02_group_prep

   LET l_ac1 = 1 
   
   #錯誤訊息收集 
   CALL cl_err_collect_init()

   FOREACH apsp610_02_group_curs INTO l_pspc_d.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      IF g_apsp610_02_input.scb02 = '1' THEN               #依料件進行匯總的話  
         SELECT MIN(pspc045) INTO l_pspc_d.pspc045_02_01   #如果需求日有不同的話  
           FROM p610_01_pspc_t                             #就以最小的為主  
          WHERE pspc050 = l_pspc_d.pspc050_02_01
      END IF

      LET l_pspc_d.pmdn001_02_01 = l_pspc_d.pspc050_02_01  #料件編號  
      LET l_pspc_d.pmdn002_02_01 = l_pspc_d.pspc051_02_01  #產品特徵    
      
      #取得產品特徵說明 
      CALL s_feature_description(l_pspc_d.pspc050_02_01,l_pspc_d.pspc051_02_01)
           RETURNING l_success,l_pspc_d.pspc051_02_01_desc
      CALL s_feature_description(l_pspc_d.pmdn001_02_01,l_pspc_d.pmdn002_02_01)
           RETURNING l_success,l_pspc_d.pmdn002_02_01_desc

      #取得料件的採購單位 
      SELECT imaf143 INTO l_pspc_d.pmdn006_02_01
        FROM imaf_t
       WHERE imafent  = g_enterprise
         AND imafsite = g_site
         AND imaf001  = l_pspc_d.pmdn001_02_01

      IF cl_null(l_pspc_d.pmdn006_02_01) THEN
         LET l_pspc_d.pmdn006_02_01 = l_pspc_d.pspc014_02_01
      END IF

      LET l_pspc_d.pmdn007_02_01 = l_pspc_d.qty_02_01
      IF l_pspc_d.pspc014_02_01 != l_pspc_d.pmdn006_02_01 THEN
         #單位轉換 
         CALL apsp610_02_convert_qty(l_pspc_d.pspc050_02_01,     #料號  
                                     l_pspc_d.pspc014_02_01,     #來源單位  
                                     l_pspc_d.pmdn006_02_01,     #目的單位  
                                     l_pspc_d.pmdn007_02_01)     #數量  
              RETURNING l_pspc_d.pmdn007_02_01
      END IF
      
      #參考單位 
      IF cl_get_para(g_enterprise,g_site,'S-BAS-0028') = 'Y' THEN
         SELECT imaf015 INTO l_pspc_d.pmdn008_02_01
           FROM imaf_t
          WHERE imafent  = g_enterprise
            AND imafsite = g_site
            AND imaf001  = l_pspc_d.pspc050_02_01
         IF (NOT cl_null(l_pspc_d.pmdn008_02_01)) AND
            (NOT cl_null(l_pspc_d.pmdn001_02_01)) AND
            (NOT cl_null(l_pspc_d.pmdn006_02_01)) THEN
            CALL apsp610_02_convert_qty(l_pspc_d.pmdn001_02_01,l_pspc_d.pmdn006_02_01,
                                        l_pspc_d.pmdn008_02_01,l_pspc_d.pmdn007_02_01)
                 RETURNING l_pspc_d.pmdn009_02_01
            IF NOT cl_null(l_pspc_d.pmdn009_02_01) THEN
               CALL apsp610_02_unit_round(l_pspc_d.pmdn008_02_01,l_pspc_d.pmdn009_02_01)
                    RETURNING l_pspc_d.pmdn009_02_01
            END IF
         END IF
      END IF

      #如果aoos020中，設定使用採購計價單位 
      IF cl_get_para(g_enterprise,g_site,'S-BAS-0019') = "Y" THEN
         #取料件的預設採購計價單位 
         SELECT imaf144 INTO l_pspc_d.pmdn010_02_01
           FROM imaf_t
          WHERE imafent = g_enterprise
            AND imafsite = g_site
            AND imaf001 = l_pspc_d.pspc050_02_01 

         IF cl_null(l_pspc_d.pmdn010_02_01) THEN
            LET l_pspc_d.pmdn010_02_01 = l_pspc_d.pmdn006_02_01
         END IF

         CALL apsp610_02_convert_qty(l_pspc_d.pspc050_02_01,l_pspc_d.pmdn006_02_01,
                                     l_pspc_d.pmdn010_02_01,l_pspc_d.pmdn007_02_01)
              RETURNING l_pspc_d.pmdn011_02_01
      ELSE
         #[C:計價單位] = 採購料號主檔的預設採購計價單位，若不使用採購計價單位時則此欄位=採購單位
         #[C:計價數量] = 採購數量*(採購單位與計價單位換算率)，若不使用採購計價單位時則此欄位=採購數量
         LET l_pspc_d.pmdn010_02_01 = l_pspc_d.pmdn006_02_01
         LET l_pspc_d.pmdn011_02_01 = l_pspc_d.pmdn007_02_01
      END IF

      CALL apsp610_02_get_imaal(l_pspc_d.pspc050_02_01)
           RETURNING l_pspc_d.imaal003_02_01_1,l_pspc_d.imaal004_02_01_1

      CALL apsp610_02_get_imaal(l_pspc_d.pmdn001_02_01)
           RETURNING l_pspc_d.imaal003_02_01_2,l_pspc_d.imaal004_02_01_2 
           
      #取得請購單位說明 
      CALL s_desc_get_unit_desc(l_pspc_d.pspc014_02_01)
           RETURNING l_pspc_d.pspc014_02_01_desc

      #取得採購單位說明 
      CALL s_desc_get_unit_desc(l_pspc_d.pmdn006_02_01)
           RETURNING l_pspc_d.pmdn006_02_01_desc

      #取得參考單位說明 
      CALL s_desc_get_unit_desc(l_pspc_d.pmdn008_02_01)
           RETURNING l_pspc_d.pmdn008_02_01_desc

      #取得計價單位說明 
      CALL s_desc_get_unit_desc(l_pspc_d.pmdn010_02_01)
           RETURNING l_pspc_d.pmdn010_02_01_desc 
           
      #取得專案編號說明 
      CALL s_desc_get_project_desc(l_pspc_d.pmdn036_02_01)
           RETURNING l_pspc_d.pmdn036_02_01_desc

      #取得WBS編號說明 
      CALL s_desc_get_wbs_desc(l_pspc_d.pmdn036_02_01,l_pspc_d.pmdn037_02_01)
           RETURNING l_pspc_d.pmdn037_02_01_desc

      #取得活動編號說明 
      CALL s_desc_get_activity_desc(l_pspc_d.pmdn036_02_01,l_pspc_d.pmdn038_02_01)
           RETURNING l_pspc_d.pmdn038_02_01_desc


      #送貨地址 
      IF NOT cl_null(l_pspc_d.pmdl025_02_01) THEN
         CALL s_apmp490_get_address('3',l_pspc_d.pmdl025_02_01)
              RETURNING l_pspc_d.pmdl025_02_01_desc,l_pspc_d.pmdl025_02_01_oofb017
      END IF

      #帳款地址 
      IF NOT cl_null(l_pspc_d.pmdl026_02_01) THEN
         CALL s_apmp490_get_address('5',l_pspc_d.pmdl026_02_01)
              RETURNING l_pspc_d.pmdl026_02_01_desc,l_pspc_d.pmdl026_02_01_oofb017
      END IF

      SELECT pmaal004 INTO l_pspc_d.pmaal004_02_01
        FROM pmaal_t
       WHERE pmaalent = g_enterprise
         AND pmaal001 = l_pspc_d.pmdl004_02_01
         AND pmaal002 = g_dlang 

      #資料已經做完基本的分群了 
      #接下來要處理分配 
      #收集訊息 showmsg 
      CASE g_apsp610_02_input.scb01
         WHEN '1'     #依料件主檔設定  
            LET l_imaf152 = ''
            SELECT imaf152 INTO l_imaf152
              FROM imaf_t
             WHERE imafent = g_enterprise
               AND imafsite = g_site
               AND imaf001 = l_pspc_d.pspc050_02_01

            #因為imaf152有可能為空 所以如果無資料的話就預設為0.主要供應商，無限量 
            IF cl_null(l_imaf152) THEN
               LET l_imaf152 = '0'
            END IF

            CASE l_imaf152
               WHEN '0'    #主要供應商，無限量  
                  #160623-00033#1 20160627 modify -----(S) 
                  #CALL apsp610_02_allot_0(l_pspc_d.*) 
                  CALL apsp610_02_allot_0(l_pspc_d.*,g_apsp610_02_input.scb02)
                  #160623-00033#1 20160627 modify -----(E) 
                  
               WHEN '1'    #依廠商分配  
                  #如果有指定供應商的話就無條件走主要供應商無限量的分配方式 
#                  IF l_pspc_d.pmdb014_02_01 != '3' THEN
                     #依廠商分配(apmi070) 
                     #160623-00033#1 20160627 modify -----(S) 
                     #CALL apsp610_02_allot_1(l_pspc_d.*)
                     CALL apsp610_02_allot_1(l_pspc_d.*,g_apsp610_02_input.scb02)
                     #160623-00033#1 20160627 modify -----(E) 
#                  ELSE
#                     #主要供應商，無限量 
#                     CALL apsp610_02_allot_0(l_pspc_d.*)
#                  END IF
                  
               WHEN '2'    #主要供應商分配優先，餘量分配  
#                  IF l_pspc_d.pmdb014_02_01 != '3' THEN
                     #主要供應商分配優先，餘量分配 
                     #160623-00033#1 20160627 modify -----(S) 
                     #CALL apsp610_02_allot_2(l_pspc_d.*)
                     CALL apsp610_02_allot_2(l_pspc_d.*,g_apsp610_02_input.scb02)
                     #160623-00033#1 20160627 modify -----(E) 
#                  ELSE
#                     #主要供應商，無限量 
#                     CALL apsp610_02_allot_0(l_pspc_d.*)
#                  END IF
                  
               WHEN '3'    #指定單一供應商  
#                  IF l_pspc_d.pmdb014_02_01 != '3' THEN
                     #指定單一供應商 
                     #160623-00033#1 20160627 modify -----(S) 
                     #CALL apsp610_02_allot_3(l_pspc_d.*)
                     CALL apsp610_02_allot_3(l_pspc_d.*,g_apsp610_02_input.scb02)
                     #160623-00033#1 20160627 modify -----(E) 
#                  ELSE
#                     #主要供應商，無限量 
#                     CALL apsp610_02_allot_0(l_pspc_d.*)
#                  END IF
                  
            END CASE
            
         WHEN '2'     #主要供應商，無限量  
            #160623-00033#1 20160627 modify -----(S) 
            #CALL apsp610_02_allot_0(l_pspc_d.*) 
            CALL apsp610_02_allot_0(l_pspc_d.*,g_apsp610_02_input.scb02) 
            #160623-00033#1 20160627 modify -----(E) 
            
         WHEN '3'     #依廠商分配  
#            IF l_pspc_d.pmdb014_02_01 != '3' THEN
               #依廠商分配 
               #160623-00033#1 20160627 modify -----(S) 
               #CALL apsp610_02_allot_1(l_pspc_d.*)
               CALL apsp610_02_allot_1(l_pspc_d.*,g_apsp610_02_input.scb02)
               #160623-00033#1 20160627 modify -----(E) 
#            ELSE
#               #主要供應商，無限量 
#               CALL apsp610_02_allot_0(l_pspc_d.*)
#            END IF
            
         WHEN '4'     #主要供應商分配優先，餘量分配  
#            IF l_pspc_d.pmdb014_02_01 != '3' THEN
               #主要供應商分配優先，餘量分配 
               #160623-00033#1 20160627 modify -----(S) 
               #CALL apsp610_02_allot_2(l_pspc_d.*)
               CALL apsp610_02_allot_2(l_pspc_d.*,g_apsp610_02_input.scb02)
               #160623-00033#1 20160627 modify -----(E)  
#            ELSE
#               #主要供應商，無限量 
#               CALL apsp610_02_allot_0(l_pspc_d.*)
#            END IF
            
         WHEN '5'     #指定單一供應商  
#            IF l_pspc_d.pmdb014_02_01 != '3' THEN
#               #指定單一供應商 
               #160623-00033#1 20160627 modify -----(S) 
               #CALL apsp610_02_allot_3(l_pspc_d.*)
               CALL apsp610_02_allot_3(l_pspc_d.*,g_apsp610_02_input.scb02)
               #160623-00033#1 20160627 modify -----(E) 
#            ELSE
#               #主要供應商，無限量 
#               CALL apsp610_02_allot_0(l_pspc_d.*)
#            END IF

         WHEN '6'     #預設取價條件之最低價供應商 
#            IF l_pspc_d.pmdb014_02_01 != '3' THEN 
               #160623-00033#1 20160627 modify -----(S) 
               #CALL apsp610_02_allot_4(l_pspc_d.*)
               CALL apsp610_02_allot_4(l_pspc_d.*,g_apsp610_02_input.scb02)
               #160623-00033#1 20160627 modify -----(E) 
#            ELSE 
#               #主要供應商，無限量 
#               CALL apsp610_02_allot_0(l_pspc_d.*)
#            END IF 
            
      END CASE

   END FOREACH 
   
   CALL cl_err_collect_show() 

   SELECT ADD_MONTHS(g_today,-g_mm) INTO g_date FROM DUAL

   LET l_wc = "pmdldocdt BETWEEN '",g_date,"' AND '",g_today,"' "
   CALL apsp610_02_b_fill_02(l_wc)
   LET l_wc = "pmdsdocdt BETWEEN '",g_date,"' AND '",g_today,"' "
   CALL apsp610_02_b_fill_03(l_wc)
   LET l_wc = "qcbadocdt BETWEEN '",g_date,"' AND '",g_today,"' "
   CALL apsp610_02_b_fill_04(l_wc)
END FUNCTION

################################################################################
# Descriptions...: 最近採購資料填充
# Memo...........:
# Usage..........: apsp610_02_b_fill_02(p_wc)
# Input parameter: p_wc
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_02_b_fill_02(p_wc)
   DEFINE p_wc     STRING
   DEFINE l_sql    STRING   
   #DEFINE l_ac1    LIKE type_t.num5     #170104-00066#1 17/01/05 mark by rainy 
   DEFINE l_ac1    LIKE type_t.num10     #170104-00066#1 17/01/05 add by rainy 

   WHENEVER ERROR CONTINUE 

   IF g_d_idx_p61002_01 = 0 THEN
      LET g_d_idx_p61002_01 = 1
   END IF

   CALL g_apsp610_02_pmdn_d.clear()

   LET l_sql = "SELECT pmdl004,'',pmdldocno,pmdldocdt,pmdl009, ",
               "       pmdl010,pmdl011,pmdl012,pmdl013,pmdl015, ",
               "       pmdl016,pmdn007,pmdn015,pmdn040 ",
               "  FROM pmdl_t,pmdn_t ",
               " WHERE pmdlent   = pmdnent ",
               "   AND pmdlsite  = pmdnsite ",
               "   AND pmdldocno = pmdndocno ",
               "   AND pmdlent   = '",g_enterprise,"' ",
               "   AND pmdlsite  = '",g_site,"' ",
               "   AND pmdn001   = '",g_pspc_d[g_d_idx_p61002_01].pspc050_02_01,"' ",
               "   AND ",p_wc

   PREPARE apsp610_02_b_fill_prep01 FROM l_sql
   DECLARE apsp610_02_b_fill_curs01 CURSOR FOR apsp610_02_b_fill_prep01 

   LET l_ac1 = 1
   FOREACH apsp610_02_b_fill_curs01 INTO g_apsp610_02_pmdn_d[l_ac1].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      #取得供應商名稱 
      CALL apsp610_02_get_pmaal004(g_apsp610_02_pmdn_d[l_ac1].pmdl004_02_02)
           RETURNING g_apsp610_02_pmdn_d[l_ac1].pmaal004_02_02

      LET l_ac1 = l_ac1 + 1

      IF l_ac1 > g_max_rec THEN
         EXIT FOREACH
      END IF

   END FOREACH

   CALL g_apsp610_02_pmdn_d.deleteElement(l_ac1)
   LET l_ac1 = l_ac1 - 1
END FUNCTION

################################################################################
# Descriptions...: 最近收貨資料填充
# Memo...........:
# Usage..........: CALL apsp610_02_b_fill_03(p_wc)
# Input parameter: p_wc
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_02_b_fill_03(p_wc)
   DEFINE p_wc     STRING
   DEFINE l_sql    STRING
   #DEFINE l_ac1    LIKE type_t.num5     #170104-00066#1 17/01/05 mark by rainy 
   DEFINE l_ac1    LIKE type_t.num10     #170104-00066#1 17/01/05 add by rainy 

   WHENEVER ERROR CONTINUE 

   IF g_d_idx_p61002_01 = 0 THEN
      LET g_d_idx_p61002_01 = 1
   END IF

   CALL g_apsp610_02_pmds_d.clear()

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
               "   AND pmdt006   = '",g_pspc_d[g_d_idx_p61002_01].pspc050_02_01,"' ",
               "   AND ",p_wc

   PREPARE apsp610_02_b_fill_prep02 FROM l_sql
   DECLARE apsp610_02_b_fill_curs02 CURSOR FOR apsp610_02_b_fill_prep02

   LET l_ac1 = 1 
   FOREACH apsp610_02_b_fill_curs02 INTO g_apsp610_02_pmds_d[l_ac1].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      #取得供應商名稱 
      CALL apsp610_02_get_pmaal004(g_apsp610_02_pmds_d[l_ac1].pmds009_02_03)
           RETURNING g_apsp610_02_pmds_d[l_ac1].pmaal004_02_03 
           
      LET g_apsp610_02_pmds_d[l_ac1].diff_day_02_03 = g_apsp610_02_pmds_d[l_ac1].pmdsdocdt_02_03 -
                                                      g_apsp610_02_pmds_d[l_ac1].pmdo013_02_03

      CASE
         #採購交貨日期 > 收貨日期 
         WHEN g_apsp610_02_pmds_d[l_ac1].pmdo013_02_03 > g_apsp610_02_pmds_d[l_ac1].pmdsdocdt_02_03
            LET g_apsp610_02_pmds_d[l_ac1].stus_02_03 = cl_getmsg("apm-00696",g_lang)     #提前交貨 

         #採購交貨日期 = 收貨日期 
         WHEN g_apsp610_02_pmds_d[l_ac1].pmdo013_02_03 = g_apsp610_02_pmds_d[l_ac1].pmdsdocdt_02_03
            LET g_apsp610_02_pmds_d[l_ac1].stus_02_03 = cl_getmsg("apm-00697",g_lang)     #正常交貨 

         #採購交貨日期 < 收貨日期 
         WHEN g_apsp610_02_pmds_d[l_ac1].pmdo013_02_03 < g_apsp610_02_pmds_d[l_ac1].pmdsdocdt_02_03
            LET g_apsp610_02_pmds_d[l_ac1].stus_02_03 = cl_getmsg("apm-00698",g_lang)     #延誤交貨 

         OTHERWISE
            EXIT CASE
      END CASE

      LET l_ac1 = l_ac1 + 1

      IF l_ac1 > g_max_rec THEN
         EXIT FOREACH
      END IF

   END FOREACH

   CALL g_apsp610_02_pmds_d.deleteElement(l_ac1)
   LET l_ac1 = l_ac1 - 1
END FUNCTION

################################################################################
# Descriptions...: 最近檢驗資料填充
# Memo...........:
# Usage..........: CALL apsp610_02_b_fill_04(p_wc)
# Input parameter: p_wc
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_02_b_fill_04(p_wc)
   DEFINE p_wc     STRING
   DEFINE l_sql    STRING  
  #DEFINE l_ac1    LIKE type_t.num5     #170104-00066#1 17/01/05 mark by rainy 
   DEFINE l_ac1    LIKE type_t.num10     #170104-00066#1 17/01/05 add by rainy 

   WHENEVER ERROR CONTINUE 

   IF g_d_idx_p61002_01 = 0 THEN
      LET g_d_idx_p61002_01 = 1
   END IF

   CALL g_apsp610_02_qcba_d.clear()

   LET l_sql = "SELECT qcba005,'',qcbadocno,qcba014,'',qcba018,qcba019, ",
               "       qcba017,qcba022,qcba023 ",
               "  FROM qcba_t ",
               " WHERE qcbaent  = '",g_enterprise,"' ",
               "   AND qcbasite = '",g_site,"' ",
               "   AND qcba010  = '",g_pspc_d[g_d_idx_p61002_01].pspc050_02_01,"' ",
               "   AND ",p_wc

   PREPARE apsp610_02_b_fill_prep03 FROM l_sql
   DECLARE apsp610_02_b_fill_curs03 CURSOR FOR apsp610_02_b_fill_prep03

   LET l_ac1 = 1
   FOREACH apsp610_02_b_fill_curs03 INTO g_apsp610_02_qcba_d[l_ac1].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      #取得供應商名稱 
      CALL apsp610_02_get_pmaal004(g_apsp610_02_qcba_d[l_ac1].qcba005_02_04)
           RETURNING g_apsp610_02_qcba_d[l_ac1].pmaal004_02_04 
           
      #取得檢驗水準 
      SELECT imae116 INTO g_apsp610_02_qcba_d[l_ac1].imae116_02_04
        FROM imaa_t LEFT OUTER JOIN imae_t ON imaeent  = imaaent
                                          AND imaesite = g_site
                                          AND imae001  = imaa001
       WHERE imaaent = g_enterprise
         AND imaa001 = g_pspc_d[g_d_idx_p61002_01].pspc050_02_01

      LET l_ac1 = l_ac1 + 1

      IF l_ac1 > g_max_rec THEN
         EXIT FOREACH
      END IF

   END FOREACH

   CALL g_apsp610_02_qcba_d.deleteElement(l_ac1)
   LET l_ac1 = l_ac1 - 1
END FUNCTION

################################################################################
# Descriptions...: 主要供應商，無限量
# Memo...........:
# Usage..........: CALL apsp610_02_allot_0(p_pspc_d,p_scb02)
# Input parameter: p_pspc_d:整個pspc_file 
#                  p_scb02:匯總方式
# Date & Author..: 2016/01/22 By shiun
# Modify.........: 160512-00016#5  2016/06/01 by ming 增加pspc062保稅否
#                  160623-00033#1  2016/06/27 by ming 增加參數
################################################################################
PUBLIC FUNCTION apsp610_02_allot_0(p_pspc_d,p_scb02)
   DEFINE p_pspc_d         type_g_pspc_d
   DEFINE p_scb02          LIKE type_t.chr10    #160623-00033#1 20160627 add 
   #DEFINE l_ac1    LIKE type_t.num5     #170104-00066#1 17/01/05 mark by rainy 
   DEFINE l_ac1    LIKE type_t.num10     #170104-00066#1 17/01/05 add by rainy 
   DEFINE l_success        LIKE type_t.num5

   WHENEVER ERROR CONTINUE 

   LET l_ac1 = g_pspc_d.getLength() + 1

   LET g_pspc_d[l_ac1].* = p_pspc_d.*

   #如果沒有主要供應商的話  整列顏色變紅色 並且要有錯誤訊息  

   IF g_pspc_d[l_ac1].pmdb014_02_01 != '3' OR cl_null(g_pspc_d[l_ac1].pmdb014_02_01) THEN
      SELECT imaf153 INTO g_pspc_d[l_ac1].pmdl004_02_01
        FROM imaf_t
       WHERE imafent = g_enterprise
         AND imafsite = g_site
         AND imaf001 = p_pspc_d.pspc050_02_01

      #取得供應商簡稱 
      CALL apsp610_02_get_pmaal004(g_pspc_d[l_ac1].pmdl004_02_01)
           RETURNING g_pspc_d[l_ac1].pmaal004_02_01
   END IF
   
   #160623-00033#1 20160627 modify -----(S) 
   ##160601-00032#3 20160614 modify by ming -----(S) 
   ##增加匯總的條件欄位 
   ##CALL apsp610_02_ins_pspc(l_ac1,g_pspc_d[l_ac1].pspc050_02_01,
   ##                         g_pspc_d[l_ac1].pspc051_02_01,
   ##                         g_pspc_d[l_ac1].qty_02_01)
   ##     RETURNING l_success
   #CALL apsp610_02_ins_pspc(l_ac1,g_pspc_d[l_ac1].pspc050_02_01,
   #                         g_pspc_d[l_ac1].pspc051_02_01,
   #                         g_pspc_d[l_ac1].pmdn053_02_01, 
   #                         g_pspc_d[l_ac1].qty_02_01)
   #     RETURNING l_success
   ##160601-00032#3 20160614 modify by ming -----(E) 
   CALL apsp610_02_ins_pspc(l_ac1,g_pspc_d[l_ac1].pspc050_02_01,
                            g_pspc_d[l_ac1].pspc051_02_01,
                            g_pspc_d[l_ac1].pmdn053_02_01, 
                            g_pspc_d[l_ac1].qty_02_01,p_scb02)
        RETURNING l_success
   #160623-00033#1 20160627 modify -----(E) 

   IF l_success THEN 
      #160601-00032#3 20160613 modify by ming -----(S) 
      ##160512-00016#5 20160601 modify by ming -----(S) 
      ##INSERT INTO p610_02_pmdn_t(pmdb014,pmdl004,pmdl025,pmdl026,pmdn058,
      ##                           pmdn036,pmdn037,pmdn038,
      ##                           pspc050,pspc051,pspc014,qty,
      ##                           pspc045,pmdn001,pmdn002,pmdn006,pmdn007,
      ##                           pmdn008,pmdn009,pmdn010,
      ##                           pmdn011,pmdn050,pmdbdocno,pmdbseq,link_no)
      ##                    VALUES(g_pspc_d[l_ac1].pmdb014_02_01,g_pspc_d[l_ac1].pmdl004_02_01,
      ##                           g_pspc_d[l_ac1].pmdl025_02_01,g_pspc_d[l_ac1].pmdl026_02_01,
      ##                           g_pspc_d[l_ac1].pmdn058_02_01,
      ##                           g_pspc_d[l_ac1].pmdn036_02_01,g_pspc_d[l_ac1].pmdn037_02_01,
      ##                           g_pspc_d[l_ac1].pmdn038_02_01,
      ##                           g_pspc_d[l_ac1].pspc050_02_01,
      ##                           g_pspc_d[l_ac1].pspc051_02_01,g_pspc_d[l_ac1].pspc014_02_01,
      ##                           g_pspc_d[l_ac1].qty_02_01    ,g_pspc_d[l_ac1].pspc045_02_01,
      ##                           g_pspc_d[l_ac1].pmdn001_02_01,g_pspc_d[l_ac1].pmdn002_02_01, 
      ##                           g_pspc_d[l_ac1].pmdn006_02_01,g_pspc_d[l_ac1].pmdn007_02_01,
      ##                           g_pspc_d[l_ac1].pmdn008_02_01,g_pspc_d[l_ac1].pmdn009_02_01,
      ##                           g_pspc_d[l_ac1].pmdn010_02_01,g_pspc_d[l_ac1].pmdn011_02_01,
      ##                           g_pspc_d[l_ac1].pmdn050_02_01,
      ##                           g_pspc_d[l_ac1].pmdbdocno_02_01,g_pspc_d[l_ac1].pmdbseq_02_01,
      ##                           l_ac1) 
      #INSERT INTO p610_02_pmdn_t(pmdb014,pmdl004,pmdl025,pmdl026,pmdn058,
      #                           pmdn036,pmdn037,pmdn038,
      #                           pspc050,pspc051,pspc062,pspc014,qty,
      #                           pspc045,pmdn001,pmdn002,pmdn006,pmdn007,
      #                           pmdn008,pmdn009,pmdn010,
      #                           pmdn011,pmdn050,pmdbdocno,pmdbseq,link_no)
      #                    VALUES(g_pspc_d[l_ac1].pmdb014_02_01,g_pspc_d[l_ac1].pmdl004_02_01,
      #                           g_pspc_d[l_ac1].pmdl025_02_01,g_pspc_d[l_ac1].pmdl026_02_01,
      #                           g_pspc_d[l_ac1].pmdn058_02_01,
      #                           g_pspc_d[l_ac1].pmdn036_02_01,g_pspc_d[l_ac1].pmdn037_02_01,
      #                           g_pspc_d[l_ac1].pmdn038_02_01,
      #                           g_pspc_d[l_ac1].pspc050_02_01,
      #                           g_pspc_d[l_ac1].pspc051_02_01,
      #                           g_pspc_d[l_ac1].pspc062_02_01,
      #                           g_pspc_d[l_ac1].pspc014_02_01,
      #                           g_pspc_d[l_ac1].qty_02_01    ,g_pspc_d[l_ac1].pspc045_02_01,
      #                           g_pspc_d[l_ac1].pmdn001_02_01,g_pspc_d[l_ac1].pmdn002_02_01, 
      #                           g_pspc_d[l_ac1].pmdn006_02_01,g_pspc_d[l_ac1].pmdn007_02_01,
      #                           g_pspc_d[l_ac1].pmdn008_02_01,g_pspc_d[l_ac1].pmdn009_02_01,
      #                           g_pspc_d[l_ac1].pmdn010_02_01,g_pspc_d[l_ac1].pmdn011_02_01,
      #                           g_pspc_d[l_ac1].pmdn050_02_01,
      #                           g_pspc_d[l_ac1].pmdbdocno_02_01,g_pspc_d[l_ac1].pmdbseq_02_01,
      #                           l_ac1)
      ##160512-00016#5 20160601 modify by ming -----(E) 
      INSERT INTO p610_02_pmdn_t(pmdb014,pmdl004,pmdl025,pmdl026,pmdn058,
                                 pmdn036,pmdn037,pmdn038,
                                 pspc050,pspc051,pspc062,pspc014,qty,
                                 pspc045,pmdn001,pmdn002,pmdn006,pmdn007,
                                 pmdn008,pmdn009,pmdn010,
                                 pmdn011,pmdn050,pmdbdocno,pmdbseq,pmdn053,link_no)
                          VALUES(g_pspc_d[l_ac1].pmdb014_02_01,g_pspc_d[l_ac1].pmdl004_02_01,
                                 g_pspc_d[l_ac1].pmdl025_02_01,g_pspc_d[l_ac1].pmdl026_02_01,
                                 g_pspc_d[l_ac1].pmdn058_02_01,
                                 g_pspc_d[l_ac1].pmdn036_02_01,g_pspc_d[l_ac1].pmdn037_02_01,
                                 g_pspc_d[l_ac1].pmdn038_02_01,
                                 g_pspc_d[l_ac1].pspc050_02_01,
                                 g_pspc_d[l_ac1].pspc051_02_01,
                                 g_pspc_d[l_ac1].pspc062_02_01,
                                 g_pspc_d[l_ac1].pspc014_02_01,
                                 g_pspc_d[l_ac1].qty_02_01    ,g_pspc_d[l_ac1].pspc045_02_01,
                                 g_pspc_d[l_ac1].pmdn001_02_01,g_pspc_d[l_ac1].pmdn002_02_01, 
                                 g_pspc_d[l_ac1].pmdn006_02_01,g_pspc_d[l_ac1].pmdn007_02_01,
                                 g_pspc_d[l_ac1].pmdn008_02_01,g_pspc_d[l_ac1].pmdn009_02_01,
                                 g_pspc_d[l_ac1].pmdn010_02_01,g_pspc_d[l_ac1].pmdn011_02_01,
                                 g_pspc_d[l_ac1].pmdn050_02_01,
                                 g_pspc_d[l_ac1].pmdbdocno_02_01,g_pspc_d[l_ac1].pmdbseq_02_01,
                                 g_pspc_d[l_ac1].pmdn053_02_01, 
                                 l_ac1)
      #160601-00032#3 20160613 modify by ming -----(E) 
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 依廠商分配
# Memo...........:
# Usage..........: CALL apsp610_02_allot_1(p_pspc_d,p_scb02)
# Input parameter: p_pspc_d:整個pspc_file 
#                : p_scb02:匯總方式
# Date & Author..: 2016/01/22 By shiun
# Modify.........: 160512-00016#5  2016/06/01 by ming 增加欄位pspc062保稅否
#                  160623-00033#1  2016/06/27 by ming 增加參數
################################################################################
PUBLIC FUNCTION apsp610_02_allot_1(p_pspc_d,p_scb02)
   DEFINE p_pspc_d         type_g_pspc_d
   DEFINE p_scb02          LIKE type_t.chr10   #160623-00033#1 20160627 add 
   #DEFINE l_ac1    LIKE type_t.num5     #170104-00066#1 17/01/05 mark by rainy 
   DEFINE l_ac1    LIKE type_t.num10     #170104-00066#1 17/01/05 add by rainy 
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
   #160823-00015#1-s-mod
   #SELECT SUM(pmao008) INTO l_pmao008_sum
   #  FROM pmao_t
   # WHERE pmaoent = g_enterprise
   #   AND pmao002 = p_pspc_d.pspc050_02_01                    #料件編號  
   #   AND NVL(pmao003,' ') = NVL(p_pspc_d.pspc051_02_01,' ')  #產品特徵 
   SELECT SUM(pmat004) INTO l_pmao008_sum
     FROM pmat_t
    WHERE pmatent  = g_enterprise
      AND pmatsite = g_site
      AND pmat002 = p_pspc_d.pspc050_02_01                    #料件編號  
      AND NVL(pmat003,' ') = NVL(p_pspc_d.pspc051_02_01,' ')  #產品特徵 
      AND pmatstus = 'Y'
   #160823-00015#1-e-mod
   
   IF cl_null(l_pmao008_sum) THEN
      LET l_pmao008_sum = 0
   END IF

   #l_pamo008_sum有沒有可能真的會是0 是0的話應該要算錯   
   IF l_pmao008_sum = 0 THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ''
      LET g_errparam.code   = 'apm-00969'     #料件編號%1之分配比率總合不可為0！ 
      LET g_errparam.popup  = TRUE
      LET g_errparam.replace[1] = p_pspc_d.pspc050_02_01
      CALL cl_err()
      RETURN 
   END IF 

   #再看供應商可分配多少比率 
   #160823-00015#1-s-add
   #LET l_sql = "SELECT pmao001,pmao008 ",
   #            "  FROM pmao_t ",
   #            " WHERE pmaoent = '",g_enterprise,"' ",
   #            "   AND pmao002 = '",p_pspc_d.pspc050_02_01,"' ",
   #            "   AND NVL(pmao003,' ') = NVL('",p_pspc_d.pspc051_02_01,"',' ') ",
   LET l_sql = "SELECT pmat001,pmat004 ",
               "  FROM pmat_t ",
               " WHERE pmatent = '",g_enterprise,"' ",
               "   AND pmatsite = '",g_site,"' ",
               "   AND pmat002 = '",p_pspc_d.pspc050_02_01,"' ",
               "   AND NVL(pmat003,' ') = NVL('",p_pspc_d.pspc051_02_01,"',' ') ",
               "   AND pmatstus = 'Y' "
   #160823-00015#1-s-add            
   PREPARE apsp610_02_pmao_prep_1 FROM l_sql
   DECLARE apsp610_02_pmao_curs_1 CURSOR FOR apsp610_02_pmao_prep_1

   LET l_ac1 = g_pspc_d.getLength() + 1

   FOREACH apsp610_02_pmao_curs_1 INTO l_pmao001,l_pmao008
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      LET g_pspc_d[l_ac1].* = p_pspc_d.*
      
      LET g_pspc_d[l_ac1].pmdl004_02_01 = l_pmao001 
      #取得供應商簡稱 
      CALL apsp610_02_get_pmaal004(g_pspc_d[l_ac1].pmdl004_02_01)
           RETURNING g_pspc_d[l_ac1].pmaal004_02_01
      LET g_pspc_d[l_ac1].pmdn007_02_01 = p_pspc_d.pmdn007_02_01 * l_pmao008 / l_pmao008_sum 
      #161107-00031#1-add-s
      CALL s_aooi250_take_decimals(g_pspc_d[l_ac1].pmdn006_02_01,g_pspc_d[l_ac1].pmdn007_02_01)
           RETURNING l_success,g_pspc_d[l_ac1].pmdn007_02_01
      #161107-00031#1-add-e
      
      #參考單位與數量 
      IF cl_get_para(g_enterprise,g_site,'S-BAS-0028') = 'Y' THEN
         SELECT imaf015 INTO g_pspc_d[l_ac1].pmdn008_02_01
           FROM imaf_t
          WHERE imafent  = g_enterprise
            AND imafsite = g_site
            AND imaf001  = g_pspc_d[l_ac1].pspc050_02_01
         IF (NOT cl_null(g_pspc_d[l_ac1].pmdn008_02_01)) AND
            (NOT cl_null(g_pspc_d[l_ac1].pmdn001_02_01)) AND
            (NOT cl_null(g_pspc_d[l_ac1].pmdn006_02_01)) THEN
            CALL apsp610_02_convert_qty(g_pspc_d[l_ac1].pmdn001_02_01,g_pspc_d[l_ac1].pmdn006_02_01,
                                        g_pspc_d[l_ac1].pmdn008_02_01,g_pspc_d[l_ac1].pmdn007_02_01)
                 RETURNING g_pspc_d[l_ac1].pmdn009_02_01
            IF NOT cl_null(g_pspc_d[l_ac1].pmdn009_02_01) THEN
               CALL apsp610_02_unit_round(g_pspc_d[l_ac1].pmdn008_02_01,g_pspc_d[l_ac1].pmdn009_02_01)
                    RETURNING g_pspc_d[l_ac1].pmdn009_02_01
            END IF
         END IF
      END IF
      
      IF cl_get_para(g_enterprise,g_site,'S-BAS-0019') = 'Y' THEN
         #取料件的預設採購計價單位 
         SELECT imaf144 INTO g_pspc_d[l_ac1].pmdn010_02_01
           FROM imaf_t
          WHERE imafent  = g_enterprise
            AND imafsite = g_site
            AND imaf001  = g_pspc_d[l_ac1].pspc050_02_01

         IF cl_null(g_pspc_d[l_ac1].pmdn010_02_01) THEN
            LET g_pspc_d[l_ac1].pmdn010_02_01 = g_pspc_d[l_ac1].pmdn006_02_01
         END IF

         CALL apsp610_02_convert_qty(g_pspc_d[l_ac1].pspc050_02_01,g_pspc_d[l_ac1].pmdn006_02_01,
                                     g_pspc_d[l_ac1].pmdn010_02_01,g_pspc_d[l_ac1].pmdn007_02_01)
              RETURNING g_pspc_d[l_ac1].pmdn011_02_01
      ELSE
         #[C:計價單位] = 採購料號主檔的預設採購計價單位，若不使用採購計價單位時則此欄位=採購單位
         #[C:計價數量] = 採購數量*(採購單位與計價單位換算率)，若不使用採購計價單位時則此欄位=採購數量
         LET g_pspc_d[l_ac1].pmdn010_02_01 = g_pspc_d[l_ac1].pmdn006_02_01
         LET g_pspc_d[l_ac1].pmdn011_02_01 = g_pspc_d[l_ac1].pmdn007_02_01
      END IF

      #160623-00033#1 20160627 modify -----(S) 
      ##160601-00032#3 20160614 modify by ming -----(S) 
      ##CALL apsp610_02_ins_pspc(l_ac1,g_pspc_d[l_ac1].pspc050_02_01,
      ##                         g_pspc_d[l_ac1].pspc051_02_01,
      ##                         g_pspc_d[l_ac1].pmdn007_02_01)
      ##     RETURNING l_success
      #CALL apsp610_02_ins_pspc(l_ac1,g_pspc_d[l_ac1].pspc050_02_01,
      #                         g_pspc_d[l_ac1].pspc051_02_01,
      #                         g_pspc_d[l_ac1].pmdn053_02_01, 
      #                         g_pspc_d[l_ac1].pmdn007_02_01)
      #     RETURNING l_success
      ##160601-00032#3 20160614 modify by ming -----(E) 
      CALL apsp610_02_ins_pspc(l_ac1,g_pspc_d[l_ac1].pspc050_02_01,
                               g_pspc_d[l_ac1].pspc051_02_01,
                               g_pspc_d[l_ac1].pmdn053_02_01, 
                               g_pspc_d[l_ac1].pmdn007_02_01,p_scb02)
           RETURNING l_success
      #160623-00033#1 20160627 modify -----(E) 
      
      IF l_success THEN 
         #160601-00032#3 20160613 modify by ming -----(S) 
         ##160512-00016#5 20160601 modify by ming -----(S) 
         ##INSERT INTO p610_02_pmdn_t(pspc045,pmdl004,pmdl025,pmdl026,pmdn058,
         ##                           pmdn036,pmdn037,pmdn038,
         ##                           pspc050,pspc051,pspc014,qty,
         ##                           pspc045,pmdn001,pmdn002,pmdn006,pmdn007,
         ##                           pmdn008,pmdn009,pmdn010,
         ##                           pmdn011,
         ##                           pmdn050,pmdbdocno,pmdbseq,link_no)
         ##                    VALUES(g_pspc_d[l_ac1].pspc045_02_01,g_pspc_d[l_ac1].pmdl004_02_01,
         ##                           g_pspc_d[l_ac1].pmdl025_02_01,g_pspc_d[l_ac1].pmdl026_02_01,
         ##                           g_pspc_d[l_ac1].pmdn058_02_01,
         ##                           g_pspc_d[l_ac1].pmdn036_02_01,g_pspc_d[l_ac1].pmdn037_02_01,
         ##                           g_pspc_d[l_ac1].pmdn038_02_01,
         ##                           g_pspc_d[l_ac1].pspc050_02_01,
         ##                           g_pspc_d[l_ac1].pspc051_02_01,g_pspc_d[l_ac1].pspc014_02_01,
         ##                           g_pspc_d[l_ac1].qty_02_01    ,g_pspc_d[l_ac1].pspc045_02_01,
         ##                           g_pspc_d[l_ac1].pmdn001_02_01,g_pspc_d[l_ac1].pmdn002_02_01, 
         ##                           g_pspc_d[l_ac1].pmdn006_02_01,g_pspc_d[l_ac1].pmdn007_02_01,
         ##                           g_pspc_d[l_ac1].pmdn008_02_01,g_pspc_d[l_ac1].pmdn009_02_01,
         ##                           g_pspc_d[l_ac1].pmdn010_02_01,g_pspc_d[l_ac1].pmdn011_02_01,
         ##                           g_pspc_d[l_ac1].pmdn050_02_01,
         ##                           g_pspc_d[l_ac1].pmdbdocno_02_01,g_pspc_d[l_ac1].pmdbseq_02_01,
         ##                           l_ac1) 
         #INSERT INTO p610_02_pmdn_t(pspc045,pmdl004,pmdl025,pmdl026,pmdn058,
         #                           pmdn036,pmdn037,pmdn038,
         #                           pspc050,pspc051,pspc062,pspc014,qty,
         #                           pspc045,pmdn001,pmdn002,pmdn006,pmdn007,
         #                           pmdn008,pmdn009,pmdn010,
         #                           pmdn011,
         #                           pmdn050,pmdbdocno,pmdbseq,link_no)
         #                    VALUES(g_pspc_d[l_ac1].pspc045_02_01,g_pspc_d[l_ac1].pmdl004_02_01,
         #                           g_pspc_d[l_ac1].pmdl025_02_01,g_pspc_d[l_ac1].pmdl026_02_01,
         #                           g_pspc_d[l_ac1].pmdn058_02_01,
         #                           g_pspc_d[l_ac1].pmdn036_02_01,g_pspc_d[l_ac1].pmdn037_02_01,
         #                           g_pspc_d[l_ac1].pmdn038_02_01,
         #                           g_pspc_d[l_ac1].pspc050_02_01,
         #                           g_pspc_d[l_ac1].pspc051_02_01, 
         #                           g_pspc_d[l_ac1].pspc062_02_01, 
         #                           g_pspc_d[l_ac1].pspc014_02_01,
         #                           g_pspc_d[l_ac1].qty_02_01    ,g_pspc_d[l_ac1].pspc045_02_01,
         #                           g_pspc_d[l_ac1].pmdn001_02_01,g_pspc_d[l_ac1].pmdn002_02_01, 
         #                           g_pspc_d[l_ac1].pmdn006_02_01,g_pspc_d[l_ac1].pmdn007_02_01,
         #                           g_pspc_d[l_ac1].pmdn008_02_01,g_pspc_d[l_ac1].pmdn009_02_01,
         #                           g_pspc_d[l_ac1].pmdn010_02_01,g_pspc_d[l_ac1].pmdn011_02_01,
         #                           g_pspc_d[l_ac1].pmdn050_02_01,
         #                           g_pspc_d[l_ac1].pmdbdocno_02_01,g_pspc_d[l_ac1].pmdbseq_02_01,
         #                           l_ac1)
         ##160512-00016#5 20160601 modify by ming -----(E) 
         INSERT INTO p610_02_pmdn_t(pspc045,pmdl004,pmdl025,pmdl026,pmdn058,
                                    pmdn036,pmdn037,pmdn038,
                                    pspc050,pspc051,pspc062,pspc014,qty,
                                    #pspc045,pmdn001,pmdn002,pmdn006,pmdn007,  #170109-00063#1-s-mod-pspc045
                                    pmdn001,pmdn002,pmdn006,pmdn007,           #170109-00063#1-e-mod-pspc045
                                    pmdn008,pmdn009,pmdn010,
                                    pmdn011,
                                    pmdn050,pmdbdocno,pmdbseq,pmdn053,link_no)
                             VALUES(g_pspc_d[l_ac1].pspc045_02_01,g_pspc_d[l_ac1].pmdl004_02_01,
                                    g_pspc_d[l_ac1].pmdl025_02_01,g_pspc_d[l_ac1].pmdl026_02_01,
                                    g_pspc_d[l_ac1].pmdn058_02_01,
                                    g_pspc_d[l_ac1].pmdn036_02_01,g_pspc_d[l_ac1].pmdn037_02_01,
                                    g_pspc_d[l_ac1].pmdn038_02_01,
                                    g_pspc_d[l_ac1].pspc050_02_01,
                                    g_pspc_d[l_ac1].pspc051_02_01, 
                                    g_pspc_d[l_ac1].pspc062_02_01, 
                                    g_pspc_d[l_ac1].pspc014_02_01,
                                    #g_pspc_d[l_ac1].qty_02_01    ,g_pspc_d[l_ac1].pspc045_02_01,  #170109-00063#1-s-mod-pspc045
                                    g_pspc_d[l_ac1].qty_02_01,                                     #170109-00063#1-e-mod-pspc045
                                    g_pspc_d[l_ac1].pmdn001_02_01,g_pspc_d[l_ac1].pmdn002_02_01, 
                                    g_pspc_d[l_ac1].pmdn006_02_01,g_pspc_d[l_ac1].pmdn007_02_01,
                                    g_pspc_d[l_ac1].pmdn008_02_01,g_pspc_d[l_ac1].pmdn009_02_01,
                                    g_pspc_d[l_ac1].pmdn010_02_01,g_pspc_d[l_ac1].pmdn011_02_01,
                                    g_pspc_d[l_ac1].pmdn050_02_01,
                                    g_pspc_d[l_ac1].pmdbdocno_02_01,g_pspc_d[l_ac1].pmdbseq_02_01,
                                    g_pspc_d[l_ac1].pmdn053_02_01, 
                                    l_ac1)
         #160601-00032#3 20160613 modify by ming -----(E) 
         LET l_ac1 = l_ac1 + 1 
      END IF      

   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 主要供應商分配優先，餘量分配
# Memo...........:
# Usage..........: CALLapsp610_02_allot_2(p_pspc_d,p_scb02)
# Input parameter: p_pspc_d:整個pspc_file 
#                : p_scb02:匯總方式
# Date & Author..: 2016/01/22 By shiun
# Modify.........: 160512-00016#5  2016/06/01 by ming 增加欄位pspc062保稅否
#                : 160623-00033#1  2016/06/27 by ming 增加參數
################################################################################
PUBLIC FUNCTION apsp610_02_allot_2(p_pspc_d,p_scb02)
   DEFINE p_pspc_d         type_g_pspc_d
   DEFINE p_scb02          LIKE type_t.chr10     #160623-00033#1 20160627 add 
   #DEFINE l_ac1    LIKE type_t.num5     #170104-00066#1 17/01/05 mark by rainy 
   DEFINE l_ac1    LIKE type_t.num10     #170104-00066#1 17/01/05 add by rainy 
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
    WHERE imafent = g_enterprise
      AND imafsite = g_site
      AND imaf001 = p_pspc_d.pspc050_02_01
   
   #分配限量的值從何而來 如果不是依料件主檔而來的話 則從畫面上設定
   IF g_apsp610_02_input.scb02 = '1' THEN    #依料件主檔設定   
      LET l_max_qty = l_imaf154
   ELSE
      LET l_max_qty = g_apsp610_02_input.ed01
   END IF

   LET l_ac1 = g_pspc_d.getLength() + 1
   LET g_pspc_d[l_ac1].* = p_pspc_d.* 
   
   IF NOT cl_null(g_pspc_d[l_ac1].pmdl004_02_01) THEN
      LET l_imaf153 = g_pspc_d[l_ac1].pmdl004_02_01
   END IF 
   
   #第一筆資料的供應商應該是料件的主要供應商 
   LET g_pspc_d[l_ac1].pmdl004_02_01 = l_imaf153
   #取得供應商簡稱 
   CALL apsp610_02_get_pmaal004(g_pspc_d[l_ac1].pmdl004_02_01)
        RETURNING g_pspc_d[l_ac1].pmaal004_02_01
   
   #如果採購數量是200 分配限量是120 則把採購數量修改為120 
   #否則則不改變 
   IF g_pspc_d[l_ac1].pmdn007_02_01 > l_max_qty THEN
      LET g_pspc_d[l_ac1].pmdn007_02_01 = l_max_qty
      LET p_pspc_d.pmdn007_02_01 = p_pspc_d.pmdn007_02_01 - l_max_qty
   END IF 
   
   #重新計算參考單位與數量 
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0028') = 'Y' THEN
      SELECT imaf015 INTO g_pspc_d[l_ac1].pmdn008_02_01
        FROM imaf_t
       WHERE imafent  = g_enterprise
         AND imafsite = g_site
         AND imaf001 = g_pspc_d[l_ac1].pspc050_02_01
      IF (NOT cl_null(g_pspc_d[l_ac1].pmdn008_02_01)) AND
         (NOT cl_null(g_pspc_d[l_ac1].pmdn001_02_01)) AND
         (NOT cl_null(g_pspc_d[l_ac1].pmdn006_02_01)) THEN
         CALL apsp610_02_convert_qty(g_pspc_d[l_ac1].pmdn001_02_01,g_pspc_d[l_ac1].pmdn006_02_01,
                                     g_pspc_d[l_ac1].pmdn008_02_01,g_pspc_d[l_ac1].pmdn007_02_01)
              RETURNING g_pspc_d[l_ac1].pmdn009_02_01
         IF NOT cl_null(g_pspc_d[l_ac1].pmdn009_02_01) THEN
            CALL apsp610_02_unit_round(g_pspc_d[l_ac1].pmdn008_02_01,g_pspc_d[l_ac1].pmdn009_02_01)
                 RETURNING g_pspc_d[l_ac1].pmdn009_02_01
         END IF
      END IF
   END IF
   
   #需要重新計算計價數量 
   #如果aoos020中，設定使用採購計價單位 
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0019') = "Y" THEN
      #取料件的預設採購計價單位 
      SELECT imaf144 INTO g_pspc_d[l_ac1].pmdn010_02_01
        FROM imaf_t
       WHERE imafent = g_enterprise
         AND imafsite = g_site
         AND imaf001 = g_pspc_d[l_ac1].pspc050_02_01

      IF cl_null(g_pspc_d[l_ac1].pmdn010_02_01) THEN
         LET g_pspc_d[l_ac1].pmdn010_02_01 = g_pspc_d[l_ac1].pmdn006_02_01
      END IF

      CALL apsp610_02_convert_qty(g_pspc_d[l_ac1].pspc050_02_01,g_pspc_d[l_ac1].pmdn006_02_01,
                                  g_pspc_d[l_ac1].pmdn010_02_01,g_pspc_d[l_ac1].pmdn007_02_01)
           RETURNING g_pspc_d[l_ac1].pmdn011_02_01
   ELSE
      #[C:計價單位] = 採購料號主檔的預設採購計價單位，若不使用採購計價單位時則此欄位=採購單位
      #[C:計價數量] = 採購數量*(採購單位與計價單位換算率)，若不使用採購計價單位時則此欄位=採購數量
      LET g_pspc_d[l_ac1].pmdn010_02_01 = g_pspc_d[l_ac1].pmdn006_02_01
      LET g_pspc_d[l_ac1].pmdn011_02_01 = g_pspc_d[l_ac1].pmdn007_02_01
   END IF 
   
   #170109-00063#1-s-mod 傳當下的數量進去才對
   ##160623-00033#1 20160627 modify -----(S) 
   ###160601-00032#3 20160614 modify by ming -----(S) 
   ###CALL apsp610_02_ins_pspc(l_ac1,g_pspc_d[l_ac1].pspc050_02_01,
   ###                         g_pspc_d[l_ac1].pspc051_02_01,
   ###                         g_pspc_d[l_ac1].qty_02_01)
   ###     RETURNING l_success
   ##CALL apsp610_02_ins_pspc(l_ac1,g_pspc_d[l_ac1].pspc050_02_01,
   ##                         g_pspc_d[l_ac1].pspc051_02_01,
   ##                         g_pspc_d[l_ac1].pmdn053_02_01, 
   ##                         g_pspc_d[l_ac1].qty_02_01)
   ##     RETURNING l_success
   ###160601-00032#3 20160614 modify by ming -----(E) 
   #CALL apsp610_02_ins_pspc(l_ac1,g_pspc_d[l_ac1].pspc050_02_01,
   #                         g_pspc_d[l_ac1].pspc051_02_01,
   #                         g_pspc_d[l_ac1].pmdn053_02_01, 
   #                         g_pspc_d[l_ac1].qty_02_01,p_scb02)
   #     RETURNING l_success
   ##160623-00033#1 20160627 modify -----(E) 
   CALL apsp610_02_ins_pspc(l_ac1,g_pspc_d[l_ac1].pspc050_02_01,
                            g_pspc_d[l_ac1].pspc051_02_01,
                            g_pspc_d[l_ac1].pmdn053_02_01, 
                            g_pspc_d[l_ac1].pmdn011_02_01,p_scb02)
        RETURNING l_success
   #170109-00063#1-e-mod
   IF l_success THEN 
      #160601-00032#3 20160613 modify by ming -----(S) 
      ##160512-00016#5 20160601 modify by ming -----(S) 
      ##INSERT INTO p610_02_pmdn_t(pmdb014,pmdl004,pmdl025,pmdl026,pmdn058,
      ##                           pmdn036,pmdn037,pmdn038,
      ##                           pspc050,pspc051,pspc014,qty,
      ##                           pspc045,pmdn001,pmdn002,pmdn006,pmdn007,
      ##                           pmdn008,pmdn009,pmdn010,
      ##                           pmdn011,
      ##                           pmdn050,pmdbdocno,pmdbseq,link_no)
      ##                    VALUES(g_pspc_d[l_ac1].pmdb014_02_01,g_pspc_d[l_ac1].pmdl004_02_01,
      ##                           g_pspc_d[l_ac1].pmdl025_02_01,g_pspc_d[l_ac1].pmdl026_02_01,
      ##                           g_pspc_d[l_ac1].pmdn058_02_01,
      ##                           g_pspc_d[l_ac1].pmdn036_02_01,g_pspc_d[l_ac1].pmdn037_02_01,
      ##                           g_pspc_d[l_ac1].pmdn038_02_01,
      ##                           g_pspc_d[l_ac1].pspc050_02_01,
      ##                           g_pspc_d[l_ac1].pspc051_02_01,g_pspc_d[l_ac1].pspc014_02_01,
      ##                           g_pspc_d[l_ac1].qty_02_01    ,g_pspc_d[l_ac1].pspc045_02_01,
      ##                           g_pspc_d[l_ac1].pmdn001_02_01,g_pspc_d[l_ac1].pmdn002_02_01, 
      ##                           g_pspc_d[l_ac1].pmdn006_02_01,g_pspc_d[l_ac1].pmdn007_02_01,
      ##                           g_pspc_d[l_ac1].pmdn008_02_01,g_pspc_d[l_ac1].pmdn009_02_01,
      ##                           g_pspc_d[l_ac1].pmdn010_02_01,g_pspc_d[l_ac1].pmdn011_02_01,
      ##                           g_pspc_d[l_ac1].pmdn050_02_01,
      ##                           g_pspc_d[l_ac1].pmdbdocno_02_01,g_pspc_d[l_ac1].pmdbseq_02_01,
      ##                           l_ac1)
      #INSERT INTO p610_02_pmdn_t(pmdb014,pmdl004,pmdl025,pmdl026,pmdn058,
      #                           pmdn036,pmdn037,pmdn038,
      #                           pspc050,pspc051,pspc062,pspc014,qty,
      #                           pspc045,pmdn001,pmdn002,pmdn006,pmdn007,
      #                           pmdn008,pmdn009,pmdn010,
      #                           pmdn011,
      #                           pmdn050,pmdbdocno,pmdbseq,link_no)
      #                    VALUES(g_pspc_d[l_ac1].pmdb014_02_01,g_pspc_d[l_ac1].pmdl004_02_01,
      #                           g_pspc_d[l_ac1].pmdl025_02_01,g_pspc_d[l_ac1].pmdl026_02_01,
      #                           g_pspc_d[l_ac1].pmdn058_02_01,
      #                           g_pspc_d[l_ac1].pmdn036_02_01,g_pspc_d[l_ac1].pmdn037_02_01,
      #                           g_pspc_d[l_ac1].pmdn038_02_01,
      #                           g_pspc_d[l_ac1].pspc050_02_01,
      #                           g_pspc_d[l_ac1].pspc051_02_01,
      #                           g_pspc_d[l_ac1].pspc062_02_01, 
      #                           g_pspc_d[l_ac1].pspc014_02_01,
      #                           g_pspc_d[l_ac1].qty_02_01    ,g_pspc_d[l_ac1].pspc045_02_01,
      #                           g_pspc_d[l_ac1].pmdn001_02_01,g_pspc_d[l_ac1].pmdn002_02_01, 
      #                           g_pspc_d[l_ac1].pmdn006_02_01,g_pspc_d[l_ac1].pmdn007_02_01,
      #                           g_pspc_d[l_ac1].pmdn008_02_01,g_pspc_d[l_ac1].pmdn009_02_01,
      #                           g_pspc_d[l_ac1].pmdn010_02_01,g_pspc_d[l_ac1].pmdn011_02_01,
      #                           g_pspc_d[l_ac1].pmdn050_02_01,
      #                           g_pspc_d[l_ac1].pmdbdocno_02_01,g_pspc_d[l_ac1].pmdbseq_02_01,
      #                           l_ac1)
      ##160512-00016#5 20160601 modify by ming -----(E) 
      INSERT INTO p610_02_pmdn_t(pmdb014,pmdl004,pmdl025,pmdl026,pmdn058,
                                 pmdn036,pmdn037,pmdn038,
                                 pspc050,pspc051,pspc062,pspc014,qty,
                                 pspc045,pmdn001,pmdn002,pmdn006,pmdn007,
                                 pmdn008,pmdn009,pmdn010,
                                 pmdn011,
                                 pmdn050,pmdbdocno,pmdbseq,pmdn053,link_no)
                          VALUES(g_pspc_d[l_ac1].pmdb014_02_01,g_pspc_d[l_ac1].pmdl004_02_01,
                                 g_pspc_d[l_ac1].pmdl025_02_01,g_pspc_d[l_ac1].pmdl026_02_01,
                                 g_pspc_d[l_ac1].pmdn058_02_01,
                                 g_pspc_d[l_ac1].pmdn036_02_01,g_pspc_d[l_ac1].pmdn037_02_01,
                                 g_pspc_d[l_ac1].pmdn038_02_01,
                                 g_pspc_d[l_ac1].pspc050_02_01,
                                 g_pspc_d[l_ac1].pspc051_02_01,
                                 g_pspc_d[l_ac1].pspc062_02_01, 
                                 g_pspc_d[l_ac1].pspc014_02_01,
                                 g_pspc_d[l_ac1].qty_02_01    ,g_pspc_d[l_ac1].pspc045_02_01,
                                 g_pspc_d[l_ac1].pmdn001_02_01,g_pspc_d[l_ac1].pmdn002_02_01, 
                                 g_pspc_d[l_ac1].pmdn006_02_01,g_pspc_d[l_ac1].pmdn007_02_01,
                                 g_pspc_d[l_ac1].pmdn008_02_01,g_pspc_d[l_ac1].pmdn009_02_01,
                                 g_pspc_d[l_ac1].pmdn010_02_01,g_pspc_d[l_ac1].pmdn011_02_01,
                                 g_pspc_d[l_ac1].pmdn050_02_01,
                                 g_pspc_d[l_ac1].pmdbdocno_02_01,g_pspc_d[l_ac1].pmdbseq_02_01,
                                 g_pspc_d[l_ac1].pmdn053_02_01, 
                                 l_ac1)
      #160601-00032#3 20160613 modify by ming -----(E) 
      LET l_ac1 = l_ac1 + 1
   END IF

   LET l_pmao008_sum = 0
   #160823-00015#1-s-mod
   #SELECT SUM(pmao008) INTO l_pmao008_sum
   #  FROM pmao_t
   # WHERE pmaoent = g_enterprise
   #   AND pmao002 = p_pspc_d.pspc050_02_01
   #   AND NVL(pmao003,' ') = NVL(p_pspc_d.pspc051_02_01,' ')
   #   AND pmao001 <> l_imaf153
   SELECT SUM(pmat004) INTO l_pmao008_sum
     FROM pmat_t
    WHERE pmatent  = g_enterprise
      AND pmatsite = g_site
      AND pmat002  = p_pspc_d.pspc050_02_01
      AND NVL(pmat003,' ') = NVL(p_pspc_d.pspc051_02_01,' ')
      AND pmat001 <> l_imaf153
      AND pmatstus = 'Y'
   #160823-00015#1-e-mod
   
   IF cl_null(l_pmao008_sum) THEN
      LET l_pmao008_sum = 0
   END IF

   IF l_pmao008_sum = 0 THEN  
      RETURN 
   END IF 
   
   #160823-00015#1-s-add
   #LET l_sql = "SELECT pmao001,pmao008 ",
   #            "  FROM pmao_t ",
   #            " WHERE pmaoent = '",g_enterprise,"' ",
   #            "   AND pmao002 = '",p_pspc_d.pspc050_02_01,"' ",
   #            "   AND NVL(pmao003,' ') = NVL('",p_pspc_d.pspc051_02_01,"',' ') ",
   #            "   AND pmao001 <> '",l_imaf153,"' "
   LET l_sql = "SELECT pmat001,pmat004 ",
               "  FROM pmat_t ",
               " WHERE pmatent = '",g_enterprise,"' ",
               "   AND pmatsite = '",g_site,"' ",
               "   AND pmat002 = '",p_pspc_d.pspc050_02_01,"' ",
               "   AND NVL(pmat003,' ') = NVL('",p_pspc_d.pspc051_02_01,"',' ') ",
               "   AND pmat001 <> '",l_imaf153,"' ",
               "   AND pmatstus = 'Y' "
   #160823-00015#1-e-add   
   PREPARE apsp610_02_pmao_prep_2 FROM l_sql
   DECLARE apsp610_02_pmao_curs_2 CURSOR FOR apsp610_02_pmao_prep_2 
   
   FOREACH apsp610_02_pmao_curs_2 INTO l_pmao001,l_pmao008
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      LET g_pspc_d[l_ac1].* = p_pspc_d.*
      LET g_pspc_d[l_ac1].pmdl004_02_01 = l_pmao001 
      #取得供應商簡稱 
      CALL apsp610_02_get_pmaal004(g_pspc_d[l_ac1].pmdl004_02_01)
           RETURNING g_pspc_d[l_ac1].pmaal004_02_01
      LET g_pspc_d[l_ac1].pmdn007_02_01 = p_pspc_d.pmdn007_02_01 * l_pmao008 / l_pmao008_sum  
      #161107-00031#1-add-s
      CALL s_aooi250_take_decimals(g_pspc_d[l_ac1].pmdn006_02_01,g_pspc_d[l_ac1].pmdn007_02_01)
           RETURNING l_success,g_pspc_d[l_ac1].pmdn007_02_01
      #161107-00031#1-add-e
      
      #重新計算參考單位與數量 
      IF cl_get_para(g_enterprise,g_site,'S-BAS-0028') = 'Y' THEN
         SELECT imaf015 INTO g_pspc_d[l_ac1].pmdn008_02_01
           FROM imaf_t
          WHERE imafent  = g_enterprise
            AND imafsite = g_site
            AND imaf001  = g_pspc_d[l_ac1].pspc050_02_01
         IF (NOT cl_null(g_pspc_d[l_ac1].pmdn008_02_01)) AND
            (NOT cl_null(g_pspc_d[l_ac1].pmdn001_02_01)) AND
            (NOT cl_null(g_pspc_d[l_ac1].pmdn006_02_01)) THEN
            CALL apsp610_02_convert_qty(g_pspc_d[l_ac1].pmdn001_02_01,g_pspc_d[l_ac1].pmdn006_02_01,
                                        g_pspc_d[l_ac1].pmdn008_02_01,g_pspc_d[l_ac1].pmdn007_02_01)
                 RETURNING g_pspc_d[l_ac1].pmdn009_02_01
            IF NOT cl_null(g_pspc_d[l_ac1].pmdn009_02_01) THEN
               CALL apsp610_02_unit_round(g_pspc_d[l_ac1].pmdn008_02_01,g_pspc_d[l_ac1].pmdn009_02_01)
                    RETURNING g_pspc_d[l_ac1].pmdn009_02_01
            END IF
         END IF
      END IF
      
      #需要重新計算計價數量 
      #如果aoos020中，設定使用採購計價單位 
      IF cl_get_para(g_enterprise,g_site,'S-BAS-0019') = "Y" THEN
         #取料件的預設採購計價單位 
         SELECT imaf144 INTO g_pspc_d[l_ac1].pmdn010_02_01
           FROM imaf_t
          WHERE imafent = g_enterprise
            AND imafsite = g_site
            AND imaf001 = g_pspc_d[l_ac1].pspc050_02_01

         IF cl_null(g_pspc_d[l_ac1].pmdn010_02_01) THEN
            LET g_pspc_d[l_ac1].pmdn010_02_01 = g_pspc_d[l_ac1].pmdn006_02_01
         END IF

         CALL apsp610_02_convert_qty(g_pspc_d[l_ac1].pspc050_02_01,g_pspc_d[l_ac1].pmdn006_02_01,
                                     g_pspc_d[l_ac1].pmdn010_02_01,g_pspc_d[l_ac1].pmdn007_02_01)
              RETURNING g_pspc_d[l_ac1].pmdn011_02_01
      ELSE
         #[C:計價單位] = 採購料號主檔的預設採購計價單位，若不使用採購計價單位時則此欄位=採購單位
         #[C:計價數量] = 採購數量*(採購單位與計價單位換算率)，若不使用採購計價單位時則此欄位=採購數量
         LET g_pspc_d[l_ac1].pmdn010_02_01 = g_pspc_d[l_ac1].pmdn006_02_01
         LET g_pspc_d[l_ac1].pmdn011_02_01 = g_pspc_d[l_ac1].pmdn007_02_01
      END IF
      
      #170109-00063#1-s-mod  傳當下的數量進去才對
      ##160623-00033#1 20160627 modify -----(S) 
      ###160601-00032#3 20160614 modify by ming -----(S) 
      ###CALL apsp610_02_ins_pspc(l_ac1,g_pspc_d[l_ac1].pspc050_02_01,
      ###                         g_pspc_d[l_ac1].pspc051_02_01,
      ###                         g_pspc_d[l_ac1].qty_02_01)
      ###     RETURNING l_success 
      ##CALL apsp610_02_ins_pspc(l_ac1,g_pspc_d[l_ac1].pspc050_02_01,
      ##                         g_pspc_d[l_ac1].pspc051_02_01, 
      ##                         g_pspc_d[l_ac1].pmdn053_02_01, 
      ##                         g_pspc_d[l_ac1].qty_02_01)
      ##     RETURNING l_success      
      ###160601-00032#3 20160614 modify by ming -----(E) 
      #CALL apsp610_02_ins_pspc(l_ac1,g_pspc_d[l_ac1].pspc050_02_01,
      #                         g_pspc_d[l_ac1].pspc051_02_01, 
      #                         g_pspc_d[l_ac1].pmdn053_02_01, 
      #                         g_pspc_d[l_ac1].qty_02_01,p_scb02)
      #     RETURNING l_success      
      ##160623-00033#1 20160627 modify -----(E) 
      CALL apsp610_02_ins_pspc(l_ac1,g_pspc_d[l_ac1].pspc050_02_01,
                               g_pspc_d[l_ac1].pspc051_02_01, 
                               g_pspc_d[l_ac1].pmdn053_02_01, 
                               g_pspc_d[l_ac1].pmdn007_02_01,p_scb02)
           RETURNING l_success  
      #170109-00063#1-e-mod
      IF l_success THEN  
         #160601-00032#3 20160613 modify by ming -----(S) 
         ##160512-00016#5 20160601 modiby by ming -----(S) 
         ##INSERT INTO p610_02_pmdn_t(pmdb014,pmdl004,pmdl025,pmdl026,pmdn058,
         ##                           pmdn036,pmdn037,pmdn038,
         ##                           pspc050,pspc051,pspc014,qty,
         ##                           pspc045,pmdn001,pmdn002,pmdn006,pmdn007,
         ##                           pmdn008,pmdn009,pmdn010,
         ##                           pmdn011,
         ##                           pmdn050,pmdbent,pmdbsite,pmdbdocno,pmdbseq,link_no)
         ##                    VALUES(g_pspc_d[l_ac1].pmdb014_02_01,g_pspc_d[l_ac1].pmdl004_02_01,
         ##                           g_pspc_d[l_ac1].pmdl025_02_01,g_pspc_d[l_ac1].pmdl026_02_01,
         ##                           g_pspc_d[l_ac1].pmdn058_02_01,
         ##                           g_pspc_d[l_ac1].pmdn036_02_01,g_pspc_d[l_ac1].pmdn037_02_01,
         ##                           g_pspc_d[l_ac1].pmdn038_02_01,
         ##                           g_pspc_d[l_ac1].pspc050_02_01,
         ##                           g_pspc_d[l_ac1].pspc051_02_01,g_pspc_d[l_ac1].pspc014_02_01,
         ##                           g_pspc_d[l_ac1].qty_02_01    ,g_pspc_d[l_ac1].pspc045_02_01,
         ##                           g_pspc_d[l_ac1].pmdn001_02_01,g_pspc_d[l_ac1].pmdn002_02_01, 
         ##                           g_pspc_d[l_ac1].pmdn006_02_01,g_pspc_d[l_ac1].pmdn007_02_01,
         ##                           g_pspc_d[l_ac1].pmdn008_02_01,g_pspc_d[l_ac1].pmdn009_02_01,
         ##                           g_pspc_d[l_ac1].pmdn010_02_01,g_pspc_d[l_ac1].pmdn011_02_01,
         ##                           g_pspc_d[l_ac1].pmdn050_02_01,
         ##                           g_pspc_d[l_ac1].pmdbdocno_02_01,g_pspc_d[l_ac1].pmdbseq_02_01,
         ##                           l_ac1)  
         #INSERT INTO p610_02_pmdn_t(pmdb014,pmdl004,pmdl025,pmdl026,pmdn058,
         #                           pmdn036,pmdn037,pmdn038,
         #                           pspc050,pspc051,pspc062,pspc014,qty,
         #                           pspc045,pmdn001,pmdn002,pmdn006,pmdn007,
         #                           pmdn008,pmdn009,pmdn010,
         #                           pmdn011,
         #                           pmdn050,pmdbent,pmdbsite,pmdbdocno,pmdbseq,link_no)
         #                    VALUES(g_pspc_d[l_ac1].pmdb014_02_01,g_pspc_d[l_ac1].pmdl004_02_01,
         #                           g_pspc_d[l_ac1].pmdl025_02_01,g_pspc_d[l_ac1].pmdl026_02_01,
         #                           g_pspc_d[l_ac1].pmdn058_02_01,
         #                           g_pspc_d[l_ac1].pmdn036_02_01,g_pspc_d[l_ac1].pmdn037_02_01,
         #                           g_pspc_d[l_ac1].pmdn038_02_01,
         #                           g_pspc_d[l_ac1].pspc050_02_01,
         #                           g_pspc_d[l_ac1].pspc051_02_01,
         #                           g_pspc_d[l_ac1].pspc062_02_01, 
         #                           g_pspc_d[l_ac1].pspc014_02_01,
         #                           g_pspc_d[l_ac1].qty_02_01    ,g_pspc_d[l_ac1].pspc045_02_01,
         #                           g_pspc_d[l_ac1].pmdn001_02_01,g_pspc_d[l_ac1].pmdn002_02_01, 
         #                           g_pspc_d[l_ac1].pmdn006_02_01,g_pspc_d[l_ac1].pmdn007_02_01,
         #                           g_pspc_d[l_ac1].pmdn008_02_01,g_pspc_d[l_ac1].pmdn009_02_01,
         #                           g_pspc_d[l_ac1].pmdn010_02_01,g_pspc_d[l_ac1].pmdn011_02_01,
         #                           g_pspc_d[l_ac1].pmdn050_02_01,
         #                           g_pspc_d[l_ac1].pmdbdocno_02_01,g_pspc_d[l_ac1].pmdbseq_02_01,
         #                           l_ac1) 
         ##160512-00016#5 20160601 modiby by ming -----(E) 
         INSERT INTO p610_02_pmdn_t(pmdb014,pmdl004,pmdl025,pmdl026,pmdn058,
                                    pmdn036,pmdn037,pmdn038,
                                    pspc050,pspc051,pspc062,pspc014,qty,
                                    pspc045,pmdn001,pmdn002,pmdn006,pmdn007,
                                    pmdn008,pmdn009,pmdn010,
                                    pmdn011,
                                    #pmdn050,pmdbent,pmdbsite,pmdbdocno,pmdbseq,pmdn053,link_no) #170125-00006#1-s-mod 拿掉pmdbent,pmdbsite(多的)
                                    pmdn050,pmdbdocno,pmdbseq,pmdn053,link_no)                   #170125-00006#1-e-mod
                             VALUES(g_pspc_d[l_ac1].pmdb014_02_01,g_pspc_d[l_ac1].pmdl004_02_01,
                                    g_pspc_d[l_ac1].pmdl025_02_01,g_pspc_d[l_ac1].pmdl026_02_01,
                                    g_pspc_d[l_ac1].pmdn058_02_01,
                                    g_pspc_d[l_ac1].pmdn036_02_01,g_pspc_d[l_ac1].pmdn037_02_01,
                                    g_pspc_d[l_ac1].pmdn038_02_01,
                                    g_pspc_d[l_ac1].pspc050_02_01,
                                    g_pspc_d[l_ac1].pspc051_02_01,
                                    g_pspc_d[l_ac1].pspc062_02_01, 
                                    g_pspc_d[l_ac1].pspc014_02_01,
                                    g_pspc_d[l_ac1].qty_02_01    ,g_pspc_d[l_ac1].pspc045_02_01,
                                    g_pspc_d[l_ac1].pmdn001_02_01,g_pspc_d[l_ac1].pmdn002_02_01, 
                                    g_pspc_d[l_ac1].pmdn006_02_01,g_pspc_d[l_ac1].pmdn007_02_01,
                                    g_pspc_d[l_ac1].pmdn008_02_01,g_pspc_d[l_ac1].pmdn009_02_01,
                                    g_pspc_d[l_ac1].pmdn010_02_01,g_pspc_d[l_ac1].pmdn011_02_01,
                                    g_pspc_d[l_ac1].pmdn050_02_01,
                                    g_pspc_d[l_ac1].pmdbdocno_02_01,g_pspc_d[l_ac1].pmdbseq_02_01,
                                    g_pspc_d[l_ac1].pmdn053_02_01, 
                                    l_ac1) 
         #160601-00032#3 20160613 modify by ming -----(E) 
         LET l_ac1 = l_ac1 + 1
      END IF
      
   END FOREACH

END FUNCTION

################################################################################
# Descriptions...: 指定單一供應商
# Memo...........:
# Usage..........: CALL apsp610_02_allot_3(p_pspc_d,p_scb02)
# Input parameter: p_pspc_d:整個pspc_file
#                : p_scb02:匯總方式
# Date & Author..: 2016/01/22 By shiun
# Modify.........: 160512-00016#5  2016/06/01 by ming 增加欄位pspc062保稅否
#                  160623-00033#1  2016/06/27 by ming 增加參數
################################################################################
PUBLIC FUNCTION apsp610_02_allot_3(p_pspc_d,p_scb02)
   DEFINE p_pspc_d         type_g_pspc_d
   DEFINE p_scb02          LIKE type_t.chr10    #160623-00033#1 20160627 add 
   #DEFINE l_ac1    LIKE type_t.num5     #170104-00066#1 17/01/05 mark by rainy 
   DEFINE l_ac1    LIKE type_t.num10     #170104-00066#1 17/01/05 add by rainy 
   DEFINE l_success        LIKE type_t.num5

   WHENEVER ERROR CONTINUE 

   LET l_ac1 = g_pspc_d.getLength() + 1
   LET g_pspc_d[l_ac1].* = p_pspc_d.*

   LET g_pspc_d[l_ac1].pmdl004_02_01 = g_apsp610_02_input.bt01 
   
   #取得供應商簡稱 
   CALL apsp610_02_get_pmaal004(g_pspc_d[l_ac1].pmdl004_02_01)
        RETURNING g_pspc_d[l_ac1].pmaal004_02_01

   #160623-00033#1 20160627 modify -----(S) 
   ##160601-00032#3 20160614 modify by ming -----(S) 
   ##CALL apsp610_02_ins_pspc(l_ac1,g_pspc_d[l_ac1].pspc050_02_01,
   ##                         g_pspc_d[l_ac1].pspc051_02_01,
   ##                         g_pspc_d[l_ac1].qty_02_01)
   ##     RETURNING l_success
   #CALL apsp610_02_ins_pspc(l_ac1,g_pspc_d[l_ac1].pspc050_02_01,
   #                         g_pspc_d[l_ac1].pspc051_02_01, 
   #                         g_pspc_d[l_ac1].pmdn053_02_01, 
   #                         g_pspc_d[l_ac1].qty_02_01)
   #     RETURNING l_success
   ##160601-00032#3 20160614 modify by ming -----(E) 
   CALL apsp610_02_ins_pspc(l_ac1,g_pspc_d[l_ac1].pspc050_02_01,
                            g_pspc_d[l_ac1].pspc051_02_01, 
                            g_pspc_d[l_ac1].pmdn053_02_01, 
                            g_pspc_d[l_ac1].qty_02_01,p_scb02)
        RETURNING l_success
   #160623-00033#1 20160627 modify -----(E) 

   IF l_success THEN 
      #160601-00032#3 20160613 modify by ming -----(S) 
      ##160512-00016#5 20160601 modify by ming -----(S) 
      ##INSERT INTO p610_02_pmdn_t(pmdb014,pmdl004,pmdl025,pmdl026,pmdn058,
      ##                           pmdn036,pmdn037,pmdn038,
      ##                           pspc050,pspc051,pspc014,qty,
      ##                           pspc045,pmdn001,pmdn002,pmdn006,pmdn007,
      ##                           pmdn008,pmdn009,pmdn010,
      ##                           pmdn011,
      ##                           pmdn050,pmdbdocno,pmdbseq,link_no)
      ##                    VALUES(g_pspc_d[l_ac1].pmdb014_02_01,g_pspc_d[l_ac1].pmdl004_02_01,
      ##                           g_pspc_d[l_ac1].pmdl025_02_01,g_pspc_d[l_ac1].pmdl026_02_01,
      ##                           g_pspc_d[l_ac1].pmdn058_02_01,
      ##                           g_pspc_d[l_ac1].pmdn036_02_01,g_pspc_d[l_ac1].pmdn037_02_01,
      ##                           g_pspc_d[l_ac1].pmdn038_02_01,
      ##                           g_pspc_d[l_ac1].pspc050_02_01,
      ##                           g_pspc_d[l_ac1].pspc051_02_01,g_pspc_d[l_ac1].pspc014_02_01,
      ##                           g_pspc_d[l_ac1].qty_02_01    ,g_pspc_d[l_ac1].pspc045_02_01,
      ##                           g_pspc_d[l_ac1].pmdn001_02_01,g_pspc_d[l_ac1].pmdn002_02_01, 
      ##                           g_pspc_d[l_ac1].pmdn006_02_01,g_pspc_d[l_ac1].pmdn007_02_01,
      ##                           g_pspc_d[l_ac1].pmdn008_02_01,g_pspc_d[l_ac1].pmdn009_02_01,
      ##                           g_pspc_d[l_ac1].pmdn010_02_01,g_pspc_d[l_ac1].pmdn011_02_01,
      ##                           g_pspc_d[l_ac1].pmdn050_02_01,
      ##                           g_pspc_d[l_ac1].pmdbdocno_02_01,g_pspc_d[l_ac1].pmdbseq_02_01,
      ##                           l_ac1)
      #INSERT INTO p610_02_pmdn_t(pmdb014,pmdl004,pmdl025,pmdl026,pmdn058,
      #                           pmdn036,pmdn037,pmdn038,
      #                           pspc050,pspc051,pspc062,pspc014,qty,
      #                           pspc045,pmdn001,pmdn002,pmdn006,pmdn007,
      #                           pmdn008,pmdn009,pmdn010,
      #                           pmdn011,
      #                           pmdn050,pmdbdocno,pmdbseq,link_no)
      #                    VALUES(g_pspc_d[l_ac1].pmdb014_02_01,g_pspc_d[l_ac1].pmdl004_02_01,
      #                           g_pspc_d[l_ac1].pmdl025_02_01,g_pspc_d[l_ac1].pmdl026_02_01,
      #                           g_pspc_d[l_ac1].pmdn058_02_01,
      #                           g_pspc_d[l_ac1].pmdn036_02_01,g_pspc_d[l_ac1].pmdn037_02_01,
      #                           g_pspc_d[l_ac1].pmdn038_02_01,
      #                           g_pspc_d[l_ac1].pspc050_02_01,
      #                           g_pspc_d[l_ac1].pspc051_02_01,
      #                           g_pspc_d[l_ac1].pspc062_02_01, 
      #                           g_pspc_d[l_ac1].pspc014_02_01,
      #                           g_pspc_d[l_ac1].qty_02_01    ,g_pspc_d[l_ac1].pspc045_02_01,
      #                           g_pspc_d[l_ac1].pmdn001_02_01,g_pspc_d[l_ac1].pmdn002_02_01, 
      #                           g_pspc_d[l_ac1].pmdn006_02_01,g_pspc_d[l_ac1].pmdn007_02_01,
      #                           g_pspc_d[l_ac1].pmdn008_02_01,g_pspc_d[l_ac1].pmdn009_02_01,
      #                           g_pspc_d[l_ac1].pmdn010_02_01,g_pspc_d[l_ac1].pmdn011_02_01,
      #                           g_pspc_d[l_ac1].pmdn050_02_01,
      #                           g_pspc_d[l_ac1].pmdbdocno_02_01,g_pspc_d[l_ac1].pmdbseq_02_01,
      #                           l_ac1)
      ##160512-00016#5 20160601 modify by ming -----(E) 
      INSERT INTO p610_02_pmdn_t(pmdb014,pmdl004,pmdl025,pmdl026,pmdn058,
                                 pmdn036,pmdn037,pmdn038,
                                 pspc050,pspc051,pspc062,pspc014,qty,
                                 pspc045,pmdn001,pmdn002,pmdn006,pmdn007,
                                 pmdn008,pmdn009,pmdn010,
                                 pmdn011,
                                 pmdn050,pmdbdocno,pmdbseq,pmdn053,link_no)
                          VALUES(g_pspc_d[l_ac1].pmdb014_02_01,g_pspc_d[l_ac1].pmdl004_02_01,
                                 g_pspc_d[l_ac1].pmdl025_02_01,g_pspc_d[l_ac1].pmdl026_02_01,
                                 g_pspc_d[l_ac1].pmdn058_02_01,
                                 g_pspc_d[l_ac1].pmdn036_02_01,g_pspc_d[l_ac1].pmdn037_02_01,
                                 g_pspc_d[l_ac1].pmdn038_02_01,
                                 g_pspc_d[l_ac1].pspc050_02_01,
                                 g_pspc_d[l_ac1].pspc051_02_01,
                                 g_pspc_d[l_ac1].pspc062_02_01, 
                                 g_pspc_d[l_ac1].pspc014_02_01,
                                 g_pspc_d[l_ac1].qty_02_01    ,g_pspc_d[l_ac1].pspc045_02_01,
                                 g_pspc_d[l_ac1].pmdn001_02_01,g_pspc_d[l_ac1].pmdn002_02_01, 
                                 g_pspc_d[l_ac1].pmdn006_02_01,g_pspc_d[l_ac1].pmdn007_02_01,
                                 g_pspc_d[l_ac1].pmdn008_02_01,g_pspc_d[l_ac1].pmdn009_02_01,
                                 g_pspc_d[l_ac1].pmdn010_02_01,g_pspc_d[l_ac1].pmdn011_02_01,
                                 g_pspc_d[l_ac1].pmdn050_02_01,
                                 g_pspc_d[l_ac1].pmdbdocno_02_01,g_pspc_d[l_ac1].pmdbseq_02_01,
                                 g_pspc_d[l_ac1].pmdn053_02_01, 
                                 l_ac1)
      #160601-00032#3 20160613 modify by ming -----(E) 
   END IF

END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsp610_02_allot_4(p_pspc_d,p_scb02)
# Input parameter: p_pspc_d:整個pspc_file
#                : p_scb02:匯總方式
# Date & Author..: 2016/01/22 By shiun
# Modify.........: 160512-00016#5  2016/06/01 by ming 增加欄位pspc062保稅否
#                  160623-00033#1  2016/06/27 by ming 增加參數
################################################################################
PUBLIC FUNCTION apsp610_02_allot_4(p_pspc_d,p_scb02)
   DEFINE p_pspc_d         type_g_pspc_d
   DEFINE p_scb02          LIKE type_t.chr10     #160623-00033#1 20160627 add 
   #DEFINE l_ac1    LIKE type_t.num5     #170104-00066#1 17/01/05 mark by rainy 
   DEFINE l_ac1    LIKE type_t.num10     #170104-00066#1 17/01/05 add by rainy 
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

   LET l_ac1 = g_pspc_d.getLength() + 1

   LET g_pspc_d[l_ac1].* = p_pspc_d.*

   #清空temp table的資料 
   DELETE FROM p610_02_tmp01_t; 
   #找apmi125與apmi070的供應商資料 
   #160823-00015#1-s-add pmao_t改抓pmat_t
   #LET l_sql = "SELECT DISTINCT pmar001,pmab033,pmab034,pmab037,pmab039,pmab053, ",
   #            "                pmab054,pmab057,0 ",
   #            "  FROM pmar_t LEFT JOIN pmab_t ON pmabent  = '",g_enterprise,"' ",
   #            "                              AND pmabsite = '",g_site,"' ",
   #            "                              AND pmab001  = pmar001 ",
   #            " WHERE pmarent  = '",g_enterprise,"' ",
   #            "   AND pmarsite = '",g_site,"' ",
   #            "   AND pmar002  = '",g_pspc_d[l_ac1].pspc050_02_01,"' ",
   #            " UNION ",
   #            "SELECT DISTINCT pmao001,pmab033,pmab034,pmab037,pmab039,pmab053, ",
   #            "                pmab054,pmab057,0 ",
   #            "  FROM pmao_t LEFT JOIN pmab_t ON pmabent  = '",g_enterprise,"' ",
   #            "                              AND pmabsite = '",g_site,"' ",
   #            "                              AND pmab001  = pmao001 ",
   #            " WHERE pmaoent = '",g_enterprise,"' ",
   #            "   AND pmao002 = '",g_pspc_d[l_ac1].pspc050_02_01,"' "
   LET l_sql = "SELECT DISTINCT pmar001,pmab033,pmab034,pmab037,pmab039,pmab053, ",
               "                pmab054,pmab057,0 ",
               "  FROM pmar_t LEFT JOIN pmab_t ON pmabent  = '",g_enterprise,"' ",
               "                              AND pmabsite = '",g_site,"' ",
               "                              AND pmab001  = pmar001 ",
               " WHERE pmarent  = '",g_enterprise,"' ",
               "   AND pmarsite = '",g_site,"' ",
               "   AND pmar002  = '",g_pspc_d[l_ac1].pspc050_02_01,"' ",
               " UNION ",
               "SELECT DISTINCT pmat001,pmab033,pmab034,pmab037,pmab039,pmab053, ",
               "                pmab054,pmab057,0 ",
               "  FROM pmat_t LEFT JOIN pmab_t ON pmabent  = '",g_enterprise,"' ",
               "                              AND pmabsite = '",g_site,"' ",
               "                              AND pmab001  = pmat001 ",
               " WHERE pmatent = '",g_enterprise,"' ",
               "   AND pmatsite = '",g_site,"' ",
               "   AND pmat002 = '",g_pspc_d[l_ac1].pspc050_02_01,"' ",
               "   AND pmatstus = 'Y' "
   #160823-00015#1-e-add
   
   PREPARE apsp610_02_get_supply_data_prep FROM l_sql
   DECLARE apsp610_02_get_supply_data_curs CURSOR FOR apsp610_02_get_supply_data_prep

   INITIALIZE l_supply.* TO NULL
   FOREACH apsp610_02_get_supply_data_curs INTO l_supply.pmab001,l_supply.pmab033,
                                                l_supply.pmab034,l_supply.pmab037,
                                                l_supply.pmab039,l_supply.pmab053,
                                                l_supply.pmab054,l_supply.pmab057, 
                                                l_supply.price

      IF NOT (cl_null(l_supply.pmab054) OR cl_null(l_supply.pmab001) OR
              cl_null(g_pspc_d[l_ac1].pspc050_02_01) OR
              cl_null(l_supply.pmab033) OR cl_null(l_supply.pmab034) OR
              cl_null(l_supply.pmab037) OR cl_null(l_supply.pmab053) OR
              cl_null(l_supply.pmab039) OR cl_null(l_supply.pmab057) OR
              cl_null(g_pspc_d[l_ac1].pmdn010_02_01) OR
              cl_null(g_pspc_d[l_ac1].pmdn011_02_01) ) THEN
         CALL s_purchase_price_get(l_supply.pmab054,l_supply.pmab001,
                                   g_pspc_d[l_ac1].pspc050_02_01,
                                   g_pspc_d[l_ac1].pspc051_02_01,
                                   l_supply.pmab033,l_supply.pmab034,l_supply.pmab037,
                                   l_supply.pmab053,l_supply.pmab039,
                                   g_apsp610_01_input.pmdldocno,g_today,
                                   g_pspc_d[l_ac1].pmdn010_02_01,
                                   g_pspc_d[l_ac1].pmdn011_02_01,
                                   g_site,l_supply.pmab057,'1','apmp490','')
              RETURNING l_pmdn040,l_pmdn015,l_pmdn041,l_pmdn042

         LET l_supply.price = l_pmdn015
      END IF

      #取不到單價的供應商需要排除掉 
      IF cl_null(l_supply.price) OR l_supply.price <= 0 THEN
         CONTINUE FOREACH
      END IF 
      
      INSERT INTO p610_02_tmp01_t VALUES(l_supply.pmab001,l_supply.price)

   END FOREACH

   SELECT pmab001 INTO g_pspc_d[l_ac1].pmdl004_02_01
     FROM p610_02_tmp01_t
    WHERE price = (SELECT MIN(price)
                     FROM p610_02_tmp01_t)



   #取得供應商簡稱 
   CALL apsp610_02_get_pmaal004(g_pspc_d[l_ac1].pmdl004_02_01)
        RETURNING g_pspc_d[l_ac1].pmaal004_02_01

   #160623-00033#1 20160627 modify -----(S) 
   ##160601-00032#3 20160614 modify by ming -----(S) 
   ##CALL apsp610_02_ins_pspc(l_ac1,g_pspc_d[l_ac1].pspc050_02_01,
   ##                         g_pspc_d[l_ac1].pspc051_02_01,
   ##                         g_pspc_d[l_ac1].qty_02_01)
   ##     RETURNING l_success
   #CALL apsp610_02_ins_pspc(l_ac1,g_pspc_d[l_ac1].pspc050_02_01,
   #                         g_pspc_d[l_ac1].pspc051_02_01, 
   #                         g_pspc_d[l_ac1].pmdn053_02_01, 
   #                         g_pspc_d[l_ac1].qty_02_01)
   #     RETURNING l_success     
   ##160601-00032#3 20160614 modify by ming -----(E) 
   CALL apsp610_02_ins_pspc(l_ac1,g_pspc_d[l_ac1].pspc050_02_01,
                            g_pspc_d[l_ac1].pspc051_02_01, 
                            g_pspc_d[l_ac1].pmdn053_02_01, 
                            g_pspc_d[l_ac1].qty_02_01,p_scb02)
        RETURNING l_success     
   #160623-00033#1 20160627 modify -----(E) 

   IF l_success THEN  
      #160601-00032#3 20160613 modify by ming -----(S) 
      ##160512-00016#5 20160601 modify by ming -----(S) 
      ##INSERT INTO p610_02_pmdn_t(pmdb014,pmdl004,pmdl025,pmdl026,pmdn058,
      ##                           pmdn036,pmdn037,pmdn038,
      ##                           pspc050,pspc051,pspc014,qty,
      ##                           pspc045,pmdn001,pmdn002,pmdn006,pmdn007,
      ##                           pmdn008,pmdn009,pmdn010,
      ##                           pmdn011,
      ##                           pmdn050,pmdbdocno,pmdbseq,link_no)
      ##                    VALUES(g_pspc_d[l_ac1].pmdb014_02_01,g_pspc_d[l_ac1].pmdl004_02_01,
      ##                           g_pspc_d[l_ac1].pmdl025_02_01,g_pspc_d[l_ac1].pmdl026_02_01,
      ##                           g_pspc_d[l_ac1].pmdn058_02_01,
      ##                           g_pspc_d[l_ac1].pmdn036_02_01,g_pspc_d[l_ac1].pmdn037_02_01,
      ##                           g_pspc_d[l_ac1].pmdn038_02_01,
      ##                           g_pspc_d[l_ac1].pspc050_02_01,
      ##                           g_pspc_d[l_ac1].pspc051_02_01,g_pspc_d[l_ac1].pspc014_02_01,
      ##                           g_pspc_d[l_ac1].qty_02_01    ,g_pspc_d[l_ac1].pspc045_02_01,
      ##                           g_pspc_d[l_ac1].pmdn001_02_01,g_pspc_d[l_ac1].pmdn002_02_01,
      ##                           g_pspc_d[l_ac1].pmdn006_02_01,g_pspc_d[l_ac1].pmdn007_02_01,
      ##                           g_pspc_d[l_ac1].pmdn008_02_01,g_pspc_d[l_ac1].pmdn009_02_01,
      ##                           g_pspc_d[l_ac1].pmdn010_02_01,g_pspc_d[l_ac1].pmdn011_02_01,
      ##                           g_pspc_d[l_ac1].pmdn050_02_01,
      ##                           g_pspc_d[l_ac1].pmdbdocno_02_01,g_pspc_d[l_ac1].pmdbseq_02_01,
      ##                           l_ac1) 
      #INSERT INTO p610_02_pmdn_t(pmdb014,pmdl004,pmdl025,pmdl026,pmdn058,
      #                           pmdn036,pmdn037,pmdn038,
      #                           pspc050,pspc051,pspc062,pspc014,qty,
      #                           pspc045,pmdn001,pmdn002,pmdn006,pmdn007,
      #                           pmdn008,pmdn009,pmdn010,
      #                           pmdn011,
      #                           pmdn050,pmdbdocno,pmdbseq,link_no)
      #                    VALUES(g_pspc_d[l_ac1].pmdb014_02_01,g_pspc_d[l_ac1].pmdl004_02_01,
      #                           g_pspc_d[l_ac1].pmdl025_02_01,g_pspc_d[l_ac1].pmdl026_02_01,
      #                           g_pspc_d[l_ac1].pmdn058_02_01,
      #                           g_pspc_d[l_ac1].pmdn036_02_01,g_pspc_d[l_ac1].pmdn037_02_01,
      #                           g_pspc_d[l_ac1].pmdn038_02_01,
      #                           g_pspc_d[l_ac1].pspc050_02_01,
      #                           g_pspc_d[l_ac1].pspc051_02_01, 
      #                           g_pspc_d[l_ac1].pspc062_02_01, 
      #                           g_pspc_d[l_ac1].pspc014_02_01,
      #                           g_pspc_d[l_ac1].qty_02_01    ,g_pspc_d[l_ac1].pspc045_02_01,
      #                           g_pspc_d[l_ac1].pmdn001_02_01,g_pspc_d[l_ac1].pmdn002_02_01,
      #                           g_pspc_d[l_ac1].pmdn006_02_01,g_pspc_d[l_ac1].pmdn007_02_01,
      #                           g_pspc_d[l_ac1].pmdn008_02_01,g_pspc_d[l_ac1].pmdn009_02_01,
      #                           g_pspc_d[l_ac1].pmdn010_02_01,g_pspc_d[l_ac1].pmdn011_02_01,
      #                           g_pspc_d[l_ac1].pmdn050_02_01,
      #                           g_pspc_d[l_ac1].pmdbdocno_02_01,g_pspc_d[l_ac1].pmdbseq_02_01,
      #                           l_ac1) 
      ##160512-00016#5 20160601 modify by ming -----(E) 
      INSERT INTO p610_02_pmdn_t(pmdb014,pmdl004,pmdl025,pmdl026,pmdn058,
                                 pmdn036,pmdn037,pmdn038,
                                 pspc050,pspc051,pspc062,pspc014,qty,
                                 pspc045,pmdn001,pmdn002,pmdn006,pmdn007,
                                 pmdn008,pmdn009,pmdn010,
                                 pmdn011,
                                 pmdn050,pmdbdocno,pmdbseq,pmdn053,link_no)
                          VALUES(g_pspc_d[l_ac1].pmdb014_02_01,g_pspc_d[l_ac1].pmdl004_02_01,
                                 g_pspc_d[l_ac1].pmdl025_02_01,g_pspc_d[l_ac1].pmdl026_02_01,
                                 g_pspc_d[l_ac1].pmdn058_02_01,
                                 g_pspc_d[l_ac1].pmdn036_02_01,g_pspc_d[l_ac1].pmdn037_02_01,
                                 g_pspc_d[l_ac1].pmdn038_02_01,
                                 g_pspc_d[l_ac1].pspc050_02_01,
                                 g_pspc_d[l_ac1].pspc051_02_01, 
                                 g_pspc_d[l_ac1].pspc062_02_01, 
                                 g_pspc_d[l_ac1].pspc014_02_01,
                                 g_pspc_d[l_ac1].qty_02_01    ,g_pspc_d[l_ac1].pspc045_02_01,
                                 g_pspc_d[l_ac1].pmdn001_02_01,g_pspc_d[l_ac1].pmdn002_02_01,
                                 g_pspc_d[l_ac1].pmdn006_02_01,g_pspc_d[l_ac1].pmdn007_02_01,
                                 g_pspc_d[l_ac1].pmdn008_02_01,g_pspc_d[l_ac1].pmdn009_02_01,
                                 g_pspc_d[l_ac1].pmdn010_02_01,g_pspc_d[l_ac1].pmdn011_02_01,
                                 g_pspc_d[l_ac1].pmdn050_02_01,
                                 g_pspc_d[l_ac1].pmdbdocno_02_01,g_pspc_d[l_ac1].pmdbseq_02_01, 
                                 g_pspc_d[l_ac1].pmdn053_02_01, 
                                 l_ac1) 
      #160601-00032#3 20160613 modify by ming -----(E) 
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 設定欄位變色
# Memo...........:
# Usage..........: CALL apsp610_02_pmdn_set_color(p_ac)
# Input parameter: p_ac
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_02_pmdn_set_color(p_ac)
   #DEFINE p_ac     LIKE type_t.num5     #170104-00066#1 17/01/05 mark by rainy 
   DEFINE p_ac     LIKE type_t.num10     #170104-00066#1 17/01/05 add by rainy 

   WHENEVER ERROR CONTINUE 

   LET g_apsp610_02_pmdn_color_d[p_ac].pmdl004 = 'red'
   LET g_apsp610_02_pmdn_color_d[p_ac].pmdb004 = 'red'
   LET g_apsp610_02_pmdn_color_d[p_ac].pmdb005 = 'red'
   LET g_apsp610_02_pmdn_color_d[p_ac].pmdb007 = 'red'
   LET g_apsp610_02_pmdn_color_d[p_ac].qty     = 'red'
   LET g_apsp610_02_pmdn_color_d[p_ac].pmdn014 = 'red'
   LET g_apsp610_02_pmdn_color_d[p_ac].pmdn001 = 'red'
   LET g_apsp610_02_pmdn_color_d[p_ac].pmdn002 = 'red'
   LET g_apsp610_02_pmdn_color_d[p_ac].pmdn006 = 'red'
   LET g_apsp610_02_pmdn_color_d[p_ac].pmdn007 = 'red'
   LET g_apsp610_02_pmdn_color_d[p_ac].pmdn010 = 'red'
   LET g_apsp610_02_pmdn_color_d[p_ac].pmdn011 = 'red'
   LET g_apsp610_02_pmdn_color_d[p_ac].pmdbent = 'red'
   LET g_apsp610_02_pmdn_color_d[p_ac].pmdbsite = 'red'
END FUNCTION

################################################################################
# Descriptions...: 建立temp table 
# Memo...........:
# Usage..........: CALL apsp610_02_create_temp_table()
# Date & Author..: 2016/01/22 By shiun
# Modify.........: 160512-00016#5  2016/06/01 by ming 增加欄位pspc062保稅否
################################################################################
PUBLIC FUNCTION apsp610_02_create_temp_table()

   WHENEVER ERROR CONTINUE 

   CREATE TEMP TABLE p610_02_pmdn_t( 
      pmdb014         VARCHAR(10),           #供應商選擇  
      pmdl004         VARCHAR(10),           #供應商  
      pmdl025         VARCHAR(10),           #送貨地址       
      pmdl026         VARCHAR(10),           #帳款地址       
      pmdn058         VARCHAR(24),           #預算科目 
      pmdn036         VARCHAR(20),           #專案編號    
      pmdn037         VARCHAR(30),           #WBS 
      pmdn038         VARCHAR(30),           #活動編號    
      pspc050         VARCHAR(40),           #請購料號  
      pspc051         VARCHAR(256),           #請購產品特徵  
      pspc062         VARCHAR(1),           #保稅否 #160512-00016#5 20160601 add 
      pspc014         VARCHAR(10),           #請購單位  
      qty             DECIMAL(20,6),           #未轉採購量  
      pspc045         DATE,           #到庫日期  
      pmdn001         VARCHAR(40),           #採購料號  
      pmdn002         VARCHAR(256),           #採購產品特徵  
      pmdn006         VARCHAR(10),           #採購單位  
      pmdn007         DECIMAL(20,6),           #採購數量  
      pmdn008         VARCHAR(10),           #參考單位 
      pmdn009         DECIMAL(20,6),           #參考數量 
      pmdn010         VARCHAR(10),           #計價單位  
      pmdn011         DECIMAL(20,6),           #計價數量  
      pmdn050         VARCHAR(255),           #備註   
      pmdbdocno       VARCHAR(20),         #請購單號
      pmdbseq         INTEGER,           #請購項次 
      pmdn053         VARCHAR(30),           #庫存管理特徵    #160601-00032#3 20160613 add 
      link_no         INTEGER     #序號   
   ) 
   
   #新請購底稿資料  
   CREATE TEMP TABLE p610_02_pspc_t(
      link_no          INTEGER,             #序號 用來與採購底稿關聯的 
      pspc050          VARCHAR(40),            #料件編號
      pspc051          VARCHAR(256),            #產品特徵  
      pspc062          VARCHAR(1),            #保稅否     #160512-00016#5 20160601 add 
      imaa009          VARCHAR(10),            #產品分類
      imaf141          VARCHAR(10),            #採購分群
      pspc034          DECIMAL(20,6),            #建議採購量
      qty              DECIMAL(20,6),            #本次採購數量=建議採購量(pspc034)-已轉數量(pspc061)
      imaf143          VARCHAR(10),            #採購單位
      pspc014          VARCHAR(10),            #單位
      pspc010          DATE,            #行動日
      pspc045          DATE,            #需求日
      pspc018          VARCHAR(40),            #需求單號
      imaf142          VARCHAR(20),            #採購員
      imae012          VARCHAR(20),            #計畫員
      pspc061          DECIMAL(20,6),            #已轉數量
      pspc055          VARCHAR(40),            #產生單號
      pspc056          INTEGER,            #項次
      pspc004          VARCHAR(40),            #APS虛擬單號
      pspc001          VARCHAR(10),            #APS版本
      pspc002          VARCHAR(20),            #執行日期時間
      imaf016          VARCHAR(10),            #生命週期狀態
      bmif009          VARCHAR(10),            #承認狀態
      bmif012          VARCHAR(80)     #承認文號
   ) 
   
   #最低價供應商的暫存表   
   CREATE TEMP TABLE p610_02_tmp01_t(
      pmab001         VARCHAR(10),           #供應商代號 
      price           DECIMAL(20,6)     #單價 
   ) 
   
END FUNCTION

################################################################################
# Descriptions...: 刪除temp table 
# Memo...........:
# Usage..........: CALL apsp610_02_drop_temp_table()
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_02_drop_temp_table()
   
   WHENEVER ERROR CONTINUE 
   
   DROP TABLE p610_02_pmdn_t;
   DROP TABLE p610_02_pspc_t;
   #最低價供應商的暫存表   
   DROP TABLE p610_02_tmp01_t;
END FUNCTION

################################################################################
# Descriptions...: 建立第三頁所需的單頭資料
# Memo...........:
# Usage..........: CALL apsp610_02_ins_pmdl_t()
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_02_ins_pmdl_t()
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
   DELETE FROM p610_03_pmdl_t;

   LET l_sql = "SELECT pmdl004,pmdl025,pmdl026 ",
               "  FROM p610_02_pmdn_t ",
               " GROUP BY pmdl004,pmdl025,pmdl026 "
   PREPARE apsp610_02_ins_pmdl_prep FROM l_sql
   DECLARE apsp610_02_ins_pmdl_curs CURSOR FOR apsp610_02_ins_pmdl_prep 
   
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
   PREPARE apsp610_02_get_pmal_prep FROM l_sql
   DECLARE apsp610_02_get_pmal_curs CURSOR FOR apsp610_02_get_pmal_prep

   FOREACH apsp610_02_ins_pmdl_curs INTO l_pmdl004,l_pmdl025,l_pmdl026,l_pmdn058
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
#      LET l_pmdl_ins.pmdl009 = g_apsp610_01_pmdl.pmdl009     #付款條件 
#      LET l_pmdl_ins.pmdl010 = g_apsp610_01_pmdl.pmdl010     #交易條件 
#      LET l_pmdl_ins.pmdl011 = g_apsp610_01_pmdl.pmdl011     #稅別 
#      LET l_pmdl_ins.pmdl012 = g_apsp610_01_pmdl.pmdl012     #稅率 
#      LET l_pmdl_ins.pmdl013 = g_apsp610_01_pmdl.pmdl013     #單價含稅否 
#      LET l_pmdl_ins.pmdl015 = g_apsp610_01_pmdl.pmdl015     #幣別 
#      LET l_pmdl_ins.pmdl016 = g_apsp610_01_pmdl.pmdl016     #匯率 
#      LET l_pmdl_ins.pmdl017 = g_apsp610_01_pmdl.pmdl017     #取價方式 
#      LET l_pmdl_ins.pmdl023 = g_apsp610_01_pmdl.pmdl023     #採購通路 
#      LET l_pmdl_ins.pmdl054 = g_apsp610_01_pmdl.pmdl054     #內外購 
#      LET l_pmdl_ins.pmdl033 = g_apsp610_01_pmdl.pmdl033     #發票類型 
#      LET l_pmdl_ins.pmdl055 = g_apsp610_01_pmdl.pmdl055     #匯率計算基礎 


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

      FOREACH apsp610_02_get_pmal_curs USING l_pmdl004
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

      INSERT INTO p610_03_pmdl_t(pmdl004,pmdl009,pmdl010,pmdl011,pmdl012,
                                 pmdl013,pmdl015,pmdl016,pmdl017,pmdl023,
                                 pmdl054,pmdl033,pmdl055,pmal002,pmdl025,pmdl026)
                          VALUES(l_pmdl_ins.*)
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 第二步進入第三步前的基本檢查
# Memo...........:
# Usage..........: CALL apsp610_02_basic_chk()
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_02_basic_chk()
   DEFINE l_sql     STRING
   DEFINE l_pmdl004 LIKE pmdl_t.pmdl004   #供應商   
   DEFINE l_pspc050 LIKE pspc_t.pspc050   #請購料號   
   DEFINE l_pspc045 LIKE pspc_t.pspc045   #到庫日期   
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

   LET l_sql = "SELECT pmdl004,pspc050,pspc045,pmdn001,pmdn002, ",
               "       pmdn006,pmdn007,pmdn008,pmdn009,pmdn010, ",
               "       pmdn011,pmdn050 ",
               "  FROM p610_02_pmdn_t "
   PREPARE apsp610_02_basic_chk_prep FROM l_sql
   DECLARE apsp610_02_basic_chk_curs CURSOR FOR apsp610_02_basic_chk_prep

   LET r_success = 'Y'
   CALL cl_err_collect_init()

   LET l_msg = '' 
   
   FOREACH apsp610_02_basic_chk_curs INTO l_pmdl004,l_pspc050,l_pspc045,l_pmdn001,l_pmdn002,
                                          l_pmdn006,l_pmdn007,l_pmdn008,l_pmdn009,l_pmdn010,
                                          l_pmdn011,l_pmdn050
      IF STATUS THEN
         CALL cl_errmsg('','','foreach',STATUS,1)
         LET r_success = 'N'
         EXIT FOREACH
      END IF

      LET l_msg = l_pspc050,";",l_pspc045

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
         IF NOT apsp610_02_pmdl004_chk(l_pmdl004) THEN
            LET r_success = 'N'
         END IF
      END IF

   END FOREACH

   #修改錯誤訊息的顯示方式 
   CALL cl_err_collect_show()
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 供應商基本檢查
# Memo...........:
# Usage..........: CALL apsp610_02_pmdl004_chk(p_pmdl004)
#                  RETURNING r_success
# Input parameter: p_pmdl004：供應商編號
# Return code....: r_success：true/false
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_02_pmdl004_chk(p_pmdl004)
   DEFINE p_pmdl004     LIKE pmdl_t.pmdl004

   DEFINE l_success    LIKE type_t.num5
   DEFINE l_flag       LIKE type_t.num5
   DEFINE r_success    LIKE type_t.num5

   DEFINE l_pmaastus   LIKE pmaa_t.pmaastus 
   
   WHENEVER ERROR CONTINUE 

   LET r_success = TRUE
   LET g_errno = ''

   IF NOT cl_null(p_pmdl004) THEN
      LET l_pmaastus = ''
      SELECT pmaastus INTO l_pmaastus
        FROM pmaa_t
       WHERE pmaa001 = p_pmdl004
         AND pmaaent = g_enterprise
         AND (pmaa002 = '1' OR pmaa002 = '3')

      CASE
         WHEN SQLCA.sqlcode = 100    LET g_errno = 'apm-00024'      #輸入的資料不存在於交易  
         WHEN l_pmaastus <> 'Y'      LET g_errno = 'apm-00200'      #輸入的資料未確認或已無效！ 
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
      CALL s_control_check_supplier(p_pmdl004,'4',g_site,g_user,g_dept,g_apsp610_01_input.pmdldocno)
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
# Usage..........: apsp610_02_pmdn001_chk(p_pmdn001,p_pmdb004,p_pmdl004,p_pmdn002,p_pmdb005)
#                  RETURNING r_success
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: r_success
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_02_pmdn001_chk(p_pmdn001,p_pmdb004,p_pmdl004,p_pmdn002,p_pmdb005)
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
      CALL s_control_check_item(p_pmdn001,'4',g_site,g_user,g_dept,g_apsp610_01_input.pmdldocno)
           RETURNING l_success
      IF NOT l_success THEN
         LET r_success = l_success
         RETURN r_success
      END IF

      #若單據別設置是要作請採勾稽時，則修改料號時必須檢核是否與"關聯單據明細"中的來源料號有替代關係
      IF cl_get_doc_para(g_enterprise,g_site,g_apsp610_01_input.pmdldocno,'D-BAS-0061') = "Y" THEN
         IF p_pmdb004 <> p_pmdn001 THEN
            #add by lixiang 2015/07/16----s------
            #請採購替代是否依據BOM替代資料
            #選Y時，代表請購轉採購時可以依據BOM替代資料進行採購料的替代
            #若選N，則是依據apmi131採購替代原則的設定進行採購料的替代
            IF cl_get_doc_para(g_enterprise,g_site,g_apsp610_01_input.pmdldocno,'D-BAS-0096') = "Y" THEN
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
# Usage..........: CALL apsp610_02_set_entry_b(p_ac)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_02_set_entry_b(p_ac)
   #DEFINE p_ac     LIKE type_t.num5     #170104-00066#1 17/01/05 mark by rainy 
   DEFINE p_ac     LIKE type_t.num10     #170104-00066#1 17/01/05 add by rainy 
   
   WHENEVER ERROR CONTINUE 
   
   #下面兩行cl_set_comp_entry現在已經存在，未來一年之中如果沒有再使用到 
   #可於2016年底移除 
  #CALL cl_set_comp_entry("pmdm001,pmdm002,pmdm003,pmdm004,pmdm005,pmdm006",TRUE)
  #CALL cl_set_comp_entry("pmdn002,pmdn008,pmdn012,pmdn013,pmdn014",TRUE)  
  
  CALL cl_set_comp_entry("pmdn002_02_01",TRUE)
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsp610_02_set_no_entry_b(p_ac)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_02_set_no_entry_b(p_ac)
   #DEFINE p_ac     LIKE type_t.num5     #170104-00066#1 17/01/05 mark by rainy 
   DEFINE p_ac     LIKE type_t.num10     #170104-00066#1 17/01/05 add by rainy 
   DEFINE l_imaa005     LIKE imaa_t.imaa005 
   
   WHENEVER ERROR CONTINUE 
   
   #以下註解的程式碼現在已經存在，如果未來一年之內都沒有修改 
   #預計在2016年底移除 
   
  #DEFINE l_imaa005   LIKE imaa_t.imaa005
  #DEFINE l_imaf015   LIKE imaf_t.imaf015

  #IF (NOT cl_null(g_pmdn6_d_t.pmdm007)) AND (g_pmdn6_d_t.pmdm008> 0 OR g_pmdn6_d_t.pmdm009 > 0) THEN
  #   CALL cl_set_comp_entry("pmdm001,pmdm002,pmdm003,pmdm004,pmdm005,pmdm006",FALSE)
  #END IF

  ##料件不使用產品特徵時，產品特徵欄位不可錄入
  #LET l_imaa005 = ''
  #SELECT imaa005 INTO l_imaa005 FROM imaa_t WHERE imaaent = g_enterprise AND imaa001 = g_pspc_d[l_ac].pmdn001
  #IF cl_null(l_imaa005) THEN
  #   CALL cl_set_comp_entry("pmdn002",FALSE)
  #   LET g_pspc_d[l_ac].pmdn002 = ' '
  #ELSE
  #   IF cl_null(g_pspc_d[l_ac].pmdn002) THEN
  #      LET g_pspc_d[l_ac].pmdn002 = ''
  #   END IF
  #END IF

  ##當料件主檔設置要做參考單位管理時，則參考單位允許輸入，不允許空白
  #LET l_imaf015 = ''
  #SELECT imaf015 INTO l_imaf015 FROM imaf_t WHERE imafent = g_enterprise AND imaf001 = g_pspc_d[l_ac].pmdn001 AND imafsite = g_site
  #IF cl_null(l_imaf015) THEN
  #   CALL cl_set_comp_entry("pmdn008",FALSE)
  #   LET g_pspc_d[l_ac].pmdn008 = ''
  #   LET g_pspc_d[l_ac].pmdn008_desc = ''
  #   LET g_pspc_d[l_ac].pmdn009 = ''
  #END IF

  #IF g_pspc_d[l_ac].pmdn024 = 'Y' THEN 
  #   CALL cl_set_comp_entry("pmdn012,pmdn013,pmdn014",FALSE)
  #   LET g_pspc_d[l_ac].pmdn012 = ''
  #   LET g_pspc_d[l_ac].pmdn013 = ''
  #   LET g_pspc_d[l_ac].pmdn014 = '' 
  
  #料件不使用產品特徵時，產品特徵欄位不可錄入
   LET l_imaa005 = ''
   SELECT imaa005 INTO l_imaa005
     FROM imaa_t
    WHERE imaaent = g_enterprise
      AND imaa001 = g_pspc_d[p_ac].pmdn001_02_01
   IF cl_null(l_imaa005) THEN
      CALL cl_set_comp_entry("pmdn002_02_01",FALSE)
      LET g_pspc_d[p_ac].pmdn002_02_01 = ' '
   ELSE
      IF cl_null(g_pspc_d[p_ac].pmdn002_02_01) THEN
         LET g_pspc_d[p_ac].pmdn002_02_01 = ''
      END IF
   END IF
  #END IF 
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsp610_02_unit_chk(p_pmdn006)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_02_unit_chk(p_pmdn006)
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
      WHEN l_oocastus <> 'Y'      LET g_errno = 'sub-01302'     #輸入的資料無效或未確認!!!
      OTHERWISE                   LET g_errno = SQLCA.sqlcode USING '------'
   END CASE
END FUNCTION

################################################################################
# Descriptions...: #根據單位取位類型對數量進行取位
# Memo...........:
# Usage..........: CALL apsp610_02_unit_round(p_unit,p_qty)
#                  RETURNING 回传参数
# Input parameter: p_unit：單位
#                : p_qty ：數量
# Return code....: r_qty ：數量
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_02_unit_round(p_unit,p_qty)
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
# Usage..........: CALL apsp610_02_default()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_02_default()
   
   WHENEVER ERROR CONTINUE 
   
   LET g_apsp610_02_input.scb01 = 1
   LET g_apsp610_02_input.bt01 = ''
   LET g_apsp610_02_input.ed01 = ''
   LET g_apsp610_02_input.scb02 = 1
   LET g_apsp610_02_input.scb03 = 3

   CASE g_apsp610_02_input.scb03
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

   CALL g_pspc_d.clear()
   CALL g_apsp610_02_pmdn_d.clear()
   CALL g_apsp610_02_pmds_d.clear()
   CALL g_apsp610_02_qcba_d.clear()
END FUNCTION

PUBLIC FUNCTION apsp610_02_bt01_ref(p_pmdl004)
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
# Usage..........: CALL apsp610_02_get_imaal(p_imaal001)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_02_get_imaal(p_imaal001)
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
# Usage..........: CALL apsp610_02_get_pmaal004(p_pmaal001)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_02_get_pmaal004(p_pmaal001)
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
# Usage..........: CALL apsp610_02_ins_pspc(p_link_no,p_pspc050,p_pspc051,p_pspc018,p_qty)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........: 160512-00016#5  2016/06/01 by ming 增加欄位pspc062保稅否
#                  160601-00032#3  2016/06/14 By ming 增加匯總的欄位條件pspc018(pmdn053)
################################################################################
PUBLIC FUNCTION apsp610_02_ins_pspc(p_link_no,p_pspc050,p_pspc051,p_pspc018,p_qty,p_scb02)
   DEFINE p_link_no     LIKE type_t.num10
   DEFINE p_pspc050     LIKE pspc_t.pspc050
   DEFINE p_pspc051     LIKE pspc_t.pspc051 
   #160601-00032#3 20160614 add by ming -----(S) 
   DEFINE p_pspc018     LIKE pspc_t.pspc018 
   #160601-00032#3 20160614 add by ming -----(E) 
   DEFINE p_qty         LIKE pmdb_t.pmdb006
   DEFINE p_scb02       LIKE type_t.chr10     #160623-00033#1 20160627 add 
   DEFINE l_sql         STRING
   DEFINE l_pspc050     LIKE pspc_t.pspc050
   DEFINE l_pspc051     LIKE pspc_t.pspc051 
   #160512-00016#5 20160601 add by ming -----(S) 
   DEFINE l_pspc062     LIKE pspc_t.pspc062   
   #160512-00016#5 20160601 add by ming -----(E) 
   DEFINE l_imaa009     LIKE imaa_t.imaa009
   DEFINE l_imaf141     LIKE imaf_t.imaf141
   DEFINE l_pspc034     LIKE pspc_t.pspc034
   DEFINE l_qty         LIKE pspc_t.pspc034
   DEFINE l_imaf143     LIKE imaf_t.imaf143
   DEFINE l_pspc014     LIKE pspc_t.pspc014
   DEFINE l_pspc010     LIKE pspc_t.pspc010
   DEFINE l_pspc045     LIKE pspc_t.pspc045
   DEFINE l_pspc018     LIKE pspc_t.pspc018
   DEFINE l_imaf142     LIKE imaf_t.imaf142
   DEFINE l_imae012     LIKE imae_t.imae012
   DEFINE l_pspc061     LIKE pspc_t.pspc061
   DEFINE l_pspc055     LIKE pspc_t.pspc055
   DEFINE l_pspc056     LIKE pspc_t.pspc056
   DEFINE l_pspc004     LIKE pspc_t.pspc004
   DEFINE l_pspc001     LIKE pspc_t.pspc001
   DEFINE l_pspc002     LIKE pspc_t.pspc002
   DEFINE l_imaf016     LIKE imaf_t.imaf016
   DEFINE l_bmif009     LIKE bmif_t.bmif009
   DEFINE l_bmif012     LIKE bmif_t.bmif012
   DEFINE l_applied_qty LIKE pspc_t.pspc034
   DEFINE l_qty_w       LIKE pmdb_t.pmdb006 
   DEFINE r_success     LIKE type_t.num5      #回傳結果   

   
   WHENEVER ERROR CONTINUE 
   
   #由此function做分配的檢查 
   #如果已分配完畢 就不可產生分配的資料 
   LET r_success = FALSE

   #160512-00016#5 20160601 modify by ming -----(S) 
   #LET l_sql = "SELECT pspc050,pspc051,imaa009,imaf141,pspc034,qty, ",
   #            "       imaf143,pspc014,pspc010,pspc045,pspc018,imaf142, ",
   #            "       imae012,pspc061,pspc055,pspc056,pspc004,pspc001, ",
   #            "       pspc002,imaf016,bmif009,bmif012,applied_qty",
   #            "  FROM p610_01_pspc_t ",
   #            " WHERE pspc050 = '",p_pspc050,"' ",
   #            "   AND pspc051 = '",p_pspc051,"' "#,
   LET l_sql = "SELECT pspc050,pspc051,pspc062,imaa009,imaf141,pspc034,qty, ",
               "       imaf143,pspc014,pspc010,pspc045,pspc018,imaf142, ",
               "       imae012,pspc061,pspc055,pspc056,pspc004,pspc001, ",
               "       pspc002,imaf016,bmif009,bmif012,applied_qty",
               "  FROM p610_01_pspc_t ",
               " WHERE pspc050 = '",p_pspc050,"' ",
               "   AND pspc051 = '",p_pspc051,"' "
   #160512-00016#5 20160601 modify by ming -----(E) 
   
   #160623-00033#1 20160627 modify -----(S) 
   ##160601-00032#3 20160614 add by ming -----(S) 
   #IF g_apsp610_02_input.scb02 = '3' THEN 
   #   LET l_sql = l_sql, " AND NVL(pspc018,' ') = NVL('",p_pspc018,"',' ') " 
   #END IF 
   ##160601-00032#3 20160614 add by ming -----(E) 
   IF p_scb02 = '3' THEN 
      LET l_sql = l_sql, " AND NVL(pspc018,' ') = NVL('",p_pspc018,"',' ') " 
   END IF 
   #160623-00033#1 20160627 modify -----(E) 
   
   LET l_sql = l_sql," ORDER BY pspc045 "
   
   PREPARE p610_02_ins_02_pmdb_prep FROM l_sql
   DECLARE p610_02_ins_02_pmdb_curs CURSOR WITH HOLD FOR p610_02_ins_02_pmdb_prep 
   
   #160512-00016#5  20160601 modify by ming ------(S) 
   #FOREACH p610_02_ins_02_pmdb_curs INTO l_pspc050,l_pspc051,l_imaa009,l_imaf141,l_pspc034,l_qty,
   #                                      l_imaf143,l_pspc014,l_pspc010,l_pspc045,l_pspc018,l_imaf142,
   #                                      l_imae012,l_pspc061,l_pspc055,l_pspc056,l_pspc004,l_pspc001,
   #                                      l_pspc002,l_imaf016,l_bmif009,l_bmif012,l_applied_qty
   FOREACH p610_02_ins_02_pmdb_curs INTO l_pspc050,l_pspc051,l_pspc062,l_imaa009,l_imaf141,l_pspc034,l_qty,
                                         l_imaf143,l_pspc014,l_pspc010,l_pspc045,l_pspc018,l_imaf142,
                                         l_imae012,l_pspc061,l_pspc055,l_pspc056,l_pspc004,l_pspc001,
                                         l_pspc002,l_imaf016,l_bmif009,l_bmif012,l_applied_qty
   #160512-00016#5  20160601 modify by ming ------(E) 
   
   
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

      #160512-00016#5 20160601 modify by ming -----(S) 
      #INSERT INTO p610_02_pspc_t(link_no,pspc050,pspc051,imaa009,imaf141,pspc034,
      #                           qty,imaf143,pspc014,pspc010,pspc045,pspc018,
      #                           imaf142,imae012,pspc061,pspc055,pspc056,pspc004,
      #                           pspc001,pspc002,imaf016,bmif009,bmif012)
      #                    VALUES(p_link_no,l_pspc050,l_pspc051,l_imaa009,l_imaf141,
      #                           l_pspc034,l_qty,l_imaf143,l_pspc014,l_pspc010,
      #                           l_pspc045,l_pspc018,l_imaf142,l_imae012,l_pspc061,
      #                           l_pspc055,l_pspc056,l_pspc004,l_pspc001,l_pspc002,
      #                           l_imaf016,l_bmif009,l_bmif012)
      INSERT INTO p610_02_pspc_t(link_no,pspc050,pspc051,pspc062,imaa009,imaf141,pspc034,
                                 qty,imaf143,pspc014,pspc010,pspc045,pspc018,
                                 imaf142,imae012,pspc061,pspc055,pspc056,pspc004,
                                 pspc001,pspc002,imaf016,bmif009,bmif012)
                          VALUES(p_link_no,l_pspc050,l_pspc051,l_pspc062,l_imaa009,l_imaf141,
                                 l_pspc034,l_qty,l_imaf143,l_pspc014,l_pspc010,
                                 l_pspc045,l_pspc018,l_imaf142,l_imae012,l_pspc061,
                                 l_pspc055,l_pspc056,l_pspc004,l_pspc001,l_pspc002,
                                 l_imaf016,l_bmif009,l_bmif012)
      #160512-00016#5 20160601 modify by ming -----(E)

      #更新已分配的數量 
      UPDATE p610_01_pspc_t SET applied_qty = applied_qty + l_qty_w
       WHERE pspc050 = l_pspc050
         AND pspc051 = l_pspc051 
         AND pspc062 = l_pspc062     #160512-00016#5 20160601 add 
         AND pspc001 = l_pspc001     #160601-00032#3 20160614 add 
         AND pspc002 = l_pspc002     #160601-00032#3 20160614 add 
         AND pspc004 = l_pspc004     #160601-00032#3 20160614 add 

      IF p_qty <=0 THEN
         EXIT FOREACH
      END IF
   END FOREACH 
   
   RETURN r_success
   
END FUNCTION

################################################################################
# Descriptions...: 單位轉換，統一寫在一個function之中，以後如果再有aimi190改aooi250的這種情況就不必改很多地方 
# Memo...........:
# Usage..........: CALL apsp610_02_convert_qty(p_imaa001,p_from_unit,p_to_unit,p_qty)
#                  RETURNING r_qty
# Input parameter: p_imaa001  ：料號 
#                : p_from_unit：來源單位 
#                : p_to_unit  ：目的單位 
#                : p_qty      ：數量 
# Return code....: r_qty      ：要回傳的結果 
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_02_convert_qty(p_imaa001,p_from_unit,p_to_unit,p_qty)
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
# Usage..........: CALL apsp610_02_b()
# Date & Author..: 2016/01/22 By shiun
# Modify.........: 
################################################################################
PUBLIC FUNCTION apsp610_02_b()
  #DEFINE l_ac1    LIKE type_t.num5     #170104-00066#1 17/01/05 mark by rainy 
   DEFINE l_ac1    LIKE type_t.num10     #170104-00066#1 17/01/05 add by rainy 
   DEFINE l_sql     STRING
   DEFINE l_success LIKE type_t.num5
   DEFINE l_pmdn_t  type_g_pspc_d
   DEFINE l_rate    LIKE inaj_t.inaj014 
   DEFINE l_qty     LIKE pmdn_t.pmdn007       #用來記錄單位換算後的數量  
   DEFINE l_imaa005 LIKE imaa_t.imaa005
   
   WHENEVER ERROR CONTINUE 

   DIALOG ATTRIBUTES(UNBUFFERED)
      INPUT ARRAY g_pspc_d FROM s_apsp610_02_detail1.*
            ATTRIBUTE(COUNT = g_d_cnt_p61002_01,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                      INSERT ROW = FALSE,
                      DELETE ROW = TRUE,
                      APPEND ROW = FALSE)
         BEFORE INPUT

         BEFORE ROW
            LET l_ac1 = ARR_CURR()
            LET l_pmdn_t.* = g_pspc_d[l_ac1].*

            CALL apsp610_02_set_entry_b(l_ac1)
            CALL apsp610_02_set_no_entry_b(l_ac1)

         AFTER FIELD pmdl004_02_01   #供應商編號   
            CALL apsp610_02_get_pmaal004(g_pspc_d[l_ac1].pmdl004_02_01)
                 RETURNING g_pspc_d[l_ac1].pmaal004_02_01
            DISPLAY BY NAME g_pspc_d[l_ac1].pmaal004_02_01 

            IF NOT cl_null(g_pspc_d[l_ac1].pmdl004_02_01) THEN
               IF g_pspc_d[l_ac1].pmdl004_02_01 != l_pmdn_t.pmdl004_02_01 OR
                  l_pmdn_t.pmdl004_02_01 IS NULL THEN
                  IF g_pspc_d[l_ac1].pmdb014_02_01 = '3' THEN
                     LET g_pspc_d[l_ac1].pmdl004_02_01 = l_pmdn_t.pmdl004_02_01
                     CALL apsp610_02_get_pmaal004(g_pspc_d[l_ac1].pmdl004_02_01)
                          RETURNING g_pspc_d[l_ac1].pmaal004_02_01
                     DISPLAY BY NAME g_pspc_d[l_ac1].pmaal004_02_01
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apm-00537'     #請購單已指定供應商，不可修改！ 
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
      
                     NEXT FIELD CURRENT
                  END IF

                  IF NOT apsp610_02_pmdl004_chk(g_pspc_d[l_ac1].pmdl004_02_01) THEN

                     NEXT FIELD CURRENT
                  END IF

               END IF
            END IF 

         AFTER FIELD pmdn001_02_01   #採購料件編號  
            CALL apsp610_02_get_imaal(g_pspc_d[l_ac1].pmdn001_02_01)
                 RETURNING g_pspc_d[l_ac1].imaal003_02_01_2,g_pspc_d[l_ac1].imaal004_02_01_2
            DISPLAY BY NAME g_pspc_d[l_ac1].imaal003_02_01_2,g_pspc_d[l_ac1].imaal004_02_01_2

            IF NOT cl_null(g_pspc_d[l_ac1].pmdn001_02_01) THEN
               IF g_pspc_d[l_ac1].pmdn001_02_01 != l_pmdn_t.pmdn001_02_01 OR
                  l_pmdn_t.pmdn001_02_01 IS NULL THEN
                  IF NOT apsp610_02_pmdn001_chk(g_pspc_d[l_ac1].pmdn001_02_01,
                                                g_pspc_d[l_ac1].pspc050_02_01,
                                                g_pspc_d[l_ac1].pmdl004_02_01,
                                                g_pspc_d[l_ac1].pmdn002_02_01,
                                                g_pspc_d[l_ac1].pspc050_02_01) THEN

                     NEXT FIELD CURRENT
                  END IF

               END IF
            END IF

            CALL apsp610_02_set_entry_b(l_ac1)
            CALL apsp610_02_set_no_entry_b(l_ac1)

         AFTER FIELD pmdn002_02_01   #產品特徵  
            #如果產品特徵沒有輸入的話，要設定為一個空白 
            IF cl_null(g_pspc_d[l_ac1].pmdn002_02_01) THEN
               LET g_pspc_d[l_ac1].pmdn002_02_01 = ' '
            END IF
            
            #取得產品特徵說明 
            CALL s_feature_description(g_pspc_d[l_ac1].pmdn001_02_01,g_pspc_d[l_ac1].pmdn002_02_01)
                 RETURNING l_success,g_pspc_d[l_ac1].pmdn002_02_01_desc
            #產品特徵的基本檢查  
            IF NOT cl_null(g_pspc_d[l_ac1].pmdn002_02_01) THEN
               IF NOT s_feature_check(g_pspc_d[l_ac1].pmdn001_02_01,g_pspc_d[l_ac1].pmdn002_02_01) THEN
                  LET g_pspc_d[l_ac1].pmdn002_02_01 = l_pmdn_t.pmdn002_02_01
                  CALL s_feature_description(g_pspc_d[l_ac1].pmdn001_02_01,g_pspc_d[l_ac1].pmdn002_02_01)
                       RETURNING l_success,g_pspc_d[l_ac1].pmdn002_02_01_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
         
            IF NOT cl_null(g_pspc_d[l_ac1].pmdn002_02_01) THEN
               IF g_pspc_d[l_ac1].pmdn002_02_01 != l_pmdn_t.pmdn002_02_01 OR
                  l_pmdn_t.pmdn002_02_01 IS NULL THEN
                  #2.呼叫產品特徵檢核應用元件，檢核輸入的產品特徵值是否合理
                  #3.當請採勾稽時，採購料號+採購產品特徵與請購料號+請購產品特徵不一樣時，必須檢核是否與請購料號+
                  #  請購產品特徵有替代關係，若沒有則不允許修改

               END IF
            END IF 

         AFTER FIELD pmdn006_02_01   #採購單位  
            IF NOT cl_null(g_pspc_d[l_ac1].pmdn006_02_01) THEN
               IF g_pspc_d[l_ac1].pmdn006_02_01 != l_pmdn_t.pmdn006_02_01 OR
                  l_pmdn_t.pmdn006_02_01 IS NULL THEN
                  CALL apsp610_02_unit_chk(g_pspc_d[l_ac1].pmdn006_02_01)

                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     #160318-00005#41 --s add
                     IF g_errno = 'sub-01302' THEN
                        LET g_errparam.replace[1] = 'aooi250'
                        LET g_errparam.replace[2] = cl_get_progname('aooi250',g_lang,"2")
                        LET g_errparam.exeprog = 'aooi250'
                     END IF
                     #160318-00005#41 --s add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD CURRENT
                  END IF 
                  
                  #單位改變後,數量要重新推算 
                  CALL apsp610_02_convert_qty(g_pspc_d[l_ac1].pspc050_02_01,     #料號  
                                              g_pspc_d[l_ac1].pspc014_02_01,     #來源單位  
                                              g_pspc_d[l_ac1].pmdn006_02_01,     #目的單位  
                                              g_pspc_d[l_ac1].pmdn007_02_01)     #數量  
                       RETURNING g_pspc_d[l_ac1].pmdn007_02_01


                  IF NOT cl_null(g_pspc_d[l_ac1].pmdn007_02_01) THEN
                     CALL apsp610_02_unit_round(g_pspc_d[l_ac1].pmdn006_02_01,g_pspc_d[l_ac1].pmdn007_02_01)
                          RETURNING g_pspc_d[l_ac1].pmdn007_02_01
                     DISPLAY BY NAME g_pspc_d[l_ac1].pmdn007_02_01

                     #若參數有使用計價單位時，則輸入[C:需求數量]時則應自動推算計價數量，
                     #[C:計價數量]=[C:需求數量]*[C:單位]與[C:計價單位]換算率
                     IF cl_get_para(g_enterprise,g_site,'S-BAS-0019') = "Y" THEN  #體參數使用採購計價單位
                        CALL apsp610_02_convert_qty(g_pspc_d[l_ac1].pmdn001_02_01,
                                                    g_pspc_d[l_ac1].pmdn006_02_01,
                                                    g_pspc_d[l_ac1].pmdn010_02_01,
                                                    g_pspc_d[l_ac1].pmdn007_02_01)
                             RETURNING g_pspc_d[l_ac1].pmdn011_02_01
                        IF NOT cl_null(g_pspc_d[l_ac1].pmdn011_02_01) THEN
                           CALL apsp610_02_unit_round(g_pspc_d[l_ac1].pmdn010_02_01,g_pspc_d[l_ac1].pmdn011_02_01)
                                RETURNING g_pspc_d[l_ac1].pmdn011_02_01
                           DISPLAY BY NAME g_pspc_d[l_ac1].pmdn011_02_01
                        END IF
                     END IF
                  END IF 
               END IF
            END IF 
            
            CALL s_desc_get_unit_desc(g_pspc_d[l_ac1].pmdn006_02_01)
                 RETURNING g_pspc_d[l_ac1].pmdn006_02_01_desc

         AFTER FIELD pmdn007_02_01   #採購數量  
            IF NOT cl_null(g_pspc_d[l_ac1].pmdn007_02_01) THEN
               IF g_pspc_d[l_ac1].pmdn007_02_01 <= 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ade-00016'   #數量不可小於等於0  
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
   
                  NEXT FIELD CURRENT
               END IF 
               
               LET l_qty = g_pspc_d[l_ac1].pmdn007_02_01
               IF g_pspc_d[l_ac1].pspc014_02_01 != g_pspc_d[l_ac1].pmdn006_02_01 THEN
                  CALL apsp610_02_convert_qty(g_pspc_d[l_ac1].pspc050_02_01,g_pspc_d[l_ac1].pmdn006_02_01,
                                              g_pspc_d[l_ac1].pspc014_02_01,l_qty)
                       RETURNING l_qty
               END IF

               #如果採購數量乘上轉換率後，超過未轉採購量的數量，就算錯 
               IF l_qty > g_pspc_d[l_ac1].qty_02_01 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'apm-00699'     #數量不可大於未轉採購量！  
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()

                  NEXT FIELD CURRENT
               END IF

               CALL apsp610_02_unit_round(g_pspc_d[l_ac1].pmdn006_02_01,g_pspc_d[l_ac1].pmdn007_02_01)
                    RETURNING g_pspc_d[l_ac1].pmdn007_02_01
               DISPLAY BY NAME g_pspc_d[l_ac1].pmdn007_02_01

               IF cl_get_para(g_enterprise,g_site,'S-BAS-0028') = 'Y' THEN
                  IF NOT cl_null(g_pspc_d[l_ac1].pmdn001_02_01) AND
                     NOT cl_null(g_pspc_d[l_ac1].pmdn006_02_01) AND
                     NOT cl_null(g_pspc_d[l_ac1].pmdn008_02_01) THEN
                     CALL apsp610_02_convert_qty(g_pspc_d[l_ac1].pmdn001_02_01,g_pspc_d[l_ac1].pmdn006_02_01,
                                                 g_pspc_d[l_ac1].pmdn008_02_01,g_pspc_d[l_ac1].pmdn007_02_01)
                          RETURNING g_pspc_d[l_ac1].pmdn009_02_01
                     IF NOT cl_null(g_pspc_d[l_ac1].pmdn009_02_01) THEN
                        CALL apsp610_02_unit_round(g_pspc_d[l_ac1].pmdn008_02_01,g_pspc_d[l_ac1].pmdn009_02_01)
                             RETURNING g_pspc_d[l_ac1].pmdn009_02_01
                        DISPLAY BY NAME g_pspc_d[l_ac1].pmdn009_02_01
                     END IF

                  END IF
               END IF

               #若參數有使用計價單位時，則輸入[C:需求數量]時則應自動推算計價數量，
               #[C:計價數量]=[C:需求數量]*[C:單位]與[C:計價單位]換算率 
               IF cl_get_para(g_enterprise,g_site,'S-BAS-0019') = "Y" THEN  #體參數使用採購計價單位
                  CALL apsp610_02_convert_qty(g_pspc_d[l_ac1].pmdn001_02_01,g_pspc_d[l_ac1].pmdn006_02_01,
                                              g_pspc_d[l_ac1].pmdn010_02_01,g_pspc_d[l_ac1].pmdn007_02_01)
                       RETURNING g_pspc_d[l_ac1].pmdn011_02_01
                  IF NOT cl_null(g_pspc_d[l_ac1].pmdn011_02_01) THEN
                     CALL apsp610_02_unit_round(g_pspc_d[l_ac1].pmdn010_02_01,g_pspc_d[l_ac1].pmdn011_02_01)
                          RETURNING g_pspc_d[l_ac1].pmdn011_02_01
                     DISPLAY BY NAME g_pspc_d[l_ac1].pmdn011_02_01
                  END IF
               END IF

            END IF 
            
         AFTER FIELD pmdn008_02_01   #參考單位 
            IF NOT cl_null(g_pspc_d[l_ac1].pmdn008_02_01) THEN
               CALL apsp610_02_unit_chk(g_pspc_d[l_ac1].pmdn008_02_01)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = g_errno
                  #160318-00005#41 --s add
                  IF g_errno = 'sub-01302' THEN
                     LET g_errparam.replace[1] = 'aooi250'
                     LET g_errparam.replace[2] = cl_get_progname('aooi250',g_lang,"2")
                     LET g_errparam.exeprog = 'aooi250'
                  END IF
                  #160318-00005#41 --s add
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()

                  NEXT FIELD CURRENT
               END IF

               #計算參考數量 
               IF (NOT cl_null(g_pspc_d[l_ac1].pmdn006_02_01)) AND 
                  (NOT cl_null(g_pspc_d[l_ac1].pmdn007_02_01)) THEN
                  CALL apsp610_02_convert_qty(g_pspc_d[l_ac1].pmdn001_02_01,g_pspc_d[l_ac1].pmdn006_02_01,
                                              g_pspc_d[l_ac1].pmdn008_02_01,g_pspc_d[l_ac1].pmdn007_02_01)
                       RETURNING g_pspc_d[l_ac1].pmdn009_02_01
               END IF

               IF NOT cl_null(g_pspc_d[l_ac1].pmdn009_02_01) THEN
                  CALL apsp610_02_unit_round(g_pspc_d[l_ac1].pmdn008_02_01,g_pspc_d[l_ac1].pmdn009_02_01)
                       RETURNING g_pspc_d[l_ac1].pmdn009_02_01
               END IF
            END IF  
            
            CALL s_desc_get_unit_desc(g_pspc_d[l_ac1].pmdn008_02_01)
                 RETURNING g_pspc_d[l_ac1].pmdn008_02_01_desc
            
         AFTER FIELD pmdn009_02_01   #參考數量 
            IF NOT cl_null(g_pspc_d[l_ac1].pmdn009_02_01) THEN
               IF g_pspc_d[l_ac1].pmdn009_02_01 <= 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'ade-00016' #數量不可小於等於0  
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()

                  NEXT FIELD CURRENT
               END IF

               #檢查數量是否有超過採購數量 
               LET l_qty = g_pspc_d[l_ac1].pmdn009_02_01
               IF g_pspc_d[l_ac1].pspc014_02_01 != g_pspc_d[l_ac1].pmdn008_02_01 THEN
                  CALL apsp610_02_convert_qty(g_pspc_d[l_ac1].pspc050_02_01,g_pspc_d[l_ac1].pmdn008_02_01,
                                              g_pspc_d[l_ac1].pspc014_02_01,l_qty)
                       RETURNING l_qty
               END IF

               #如果數量乘上轉換率後，超過未轉採購量，就算錯 
               IF l_qty > g_pspc_d[l_ac1].qty_02_01 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'apm-00699'    #數量不可大於未轉採購量！  
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()

                  NEXT FIELD CURRENT
               END IF

               IF NOT cl_null(g_pspc_d[l_ac1].pmdn008_02_01) THEN
                  CALL apsp610_02_unit_round(g_pspc_d[l_ac1].pmdn008_02_01,g_pspc_d[l_ac1].pmdn009_02_01)
                       RETURNING g_pspc_d[l_ac1].pmdn009_02_01
                  DISPLAY BY NAME g_pspc_d[l_ac1].pmdn009_02_01
               END IF
            END IF

         AFTER FIELD pmdn010_02_01   #計價單位  
            IF NOT cl_null(g_pspc_d[l_ac1].pmdn010_02_01) THEN
                CALL apsp610_02_unit_chk(g_pspc_d[l_ac1].pmdn010_02_01)
                IF NOT cl_null(g_errno) THEN
                   INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     #160318-00005#41 --s add
                     IF g_errno = 'sub-01302' THEN
                        LET g_errparam.replace[1] = 'aooi250'
                        LET g_errparam.replace[2] = cl_get_progname('aooi250',g_lang,"2")
                        LET g_errparam.exeprog = 'aooi250'
                     END IF
                     #160318-00005#41 --s add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                   NEXT FIELD CURRENT
                END IF 
                
                #單位改變後,數量要重新推算 
                CALL apsp610_02_convert_qty(g_pspc_d[l_ac1].pspc050_02_01,     #料號  
                                            g_pspc_d[l_ac1].pspc014_02_01,     #來源單位  
                                            g_pspc_d[l_ac1].pmdn010_02_01,     #目的單位  
                                            g_pspc_d[l_ac1].pmdn007_02_01)     #數量  
                     RETURNING g_pspc_d[l_ac1].pmdn011_02_01


                IF NOT cl_null(g_pspc_d[l_ac1].pmdn011_02_01) THEN
                   CALL apsp610_02_unit_round(g_pspc_d[l_ac1].pmdn010_02_01,g_pspc_d[l_ac1].pmdn011_02_01)
                        RETURNING g_pspc_d[l_ac1].pmdn011_02_01
                   DISPLAY BY NAME g_pspc_d[l_ac1].pmdn011_02_01
                END IF
            END IF 
            
            CALL s_desc_get_unit_desc(g_pspc_d[l_ac1].pmdn010_02_01)
                 RETURNING g_pspc_d[l_ac1].pmdn010_02_01_desc

         AFTER FIELD pmdn011_02_01   #計價數量   
            IF NOT cl_null(g_pspc_d[l_ac1].pmdn011_02_01) THEN
               IF g_pspc_d[l_ac1].pmdn011_02_01 <= 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ade-00016'   #數量不可小於等於0  
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
     
                  NEXT FIELD CURRENT
               END IF 
               
               LET l_qty = g_pspc_d[l_ac1].pmdn011_02_01
               IF g_pspc_d[l_ac1].pspc014_02_01 != g_pspc_d[l_ac1].pmdn010_02_01 THEN
                  CALL apsp610_02_convert_qty(g_pspc_d[l_ac1].pspc050_02_01,g_pspc_d[l_ac1].pmdn010_02_01,
                                              g_pspc_d[l_ac1].pspc014_02_01,l_qty)
                       RETURNING l_qty
               END IF

               #如果採購數量乘上轉換率後，超過未轉採購量的數量，就算錯 
               IF l_qty > g_pspc_d[l_ac1].qty_02_01 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'apm-00699'     #數量不可大於未轉採購量！  
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()

                  NEXT FIELD CURRENT
               END IF

               IF NOT cl_null(g_pspc_d[l_ac1].pmdn010_02_01) THEN
                  CALL apsp610_02_unit_round(g_pspc_d[l_ac1].pmdn010_02_01,g_pspc_d[l_ac1].pmdn011_02_01)
                       RETURNING g_pspc_d[l_ac1].pmdn011_02_01
                  DISPLAY BY NAME g_pspc_d[l_ac1].pmdn011_02_01
               END IF
            END IF 

         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_pspc_d[l_ac1].* = l_pmdn_t.*
               EXIT DIALOG
            END IF

            UPDATE p610_02_pmdn_t SET pmdl004 = g_pspc_d[l_ac1].pmdl004_02_01,
                                      pmdn001 = g_pspc_d[l_ac1].pmdn001_02_01,
                                      pmdn002 = g_pspc_d[l_ac1].pmdn002_02_01,
                                      pmdn006 = g_pspc_d[l_ac1].pmdn006_02_01,
                                      pmdn007 = g_pspc_d[l_ac1].pmdn007_02_01,
                                      pmdn008 = g_pspc_d[l_ac1].pmdn008_02_01,
                                      pmdn009 = g_pspc_d[l_ac1].pmdn009_02_01,
                                      pmdn010 = g_pspc_d[l_ac1].pmdn010_02_01,
                                      pmdn011 = g_pspc_d[l_ac1].pmdn011_02_01,
                                      pmdn058 = g_pspc_d[l_ac1].pmdn058_02_01
             WHERE NVL(pmdl004,' ') = NVL(l_pmdn_t.pmdl004_02_01,' ')
               AND pspc050 = g_pspc_d[l_ac1].pspc050_02_01
               AND pspc051 = g_pspc_d[l_ac1].pspc051_02_01
               AND pspc062 = g_pspc_d[l_ac1].pspc062_02_01     #160512-00016#5 20160601 add 
               AND pspc045 = g_pspc_d[l_ac1].pspc045_02_01                   #因為會有費用料件的問題 
               AND NVL(pmdn050,' ') = NVL(g_pspc_d[l_ac1].pmdn050_02_01,' ') #所以要多考慮備註 
               AND NVL(pmdl025,' ') = NVL(g_pspc_d[l_ac1].pmdl025_02_01,' ')
               AND NVL(pmdl026,' ') = NVL(g_pspc_d[l_ac1].pmdl026_02_01,' ')
               AND NVL(pmdn058,' ') = NVL(l_pmdn_t.pmdn058_02_01,' ')
               AND NVL(pmdn036,' ') = NVL(l_pmdn_t.pmdn036_02_01,' ')
               AND NVL(pmdn037,' ') = NVL(l_pmdn_t.pmdn037_02_01,' ')
               AND NVL(pmdn038,' ') = NVL(l_pmdn_t.pmdn038_02_01,' ')
               AND NVL(pmdbdocno,' ') = NVL(g_pspc_d[l_ac1].pmdbdocno_02_01,' ')
               AND NVL(pmdbseq,'0') = NVL(g_pspc_d[l_ac1].pmdbseq_02_01,'0') 
               AND NVL(pmdn053,' ') = NVL(g_pspc_d[l_ac1].pmdn053_02_01,' ') #160601-00032#3 20160613 add 

         ON ACTION controlp INFIELD pmdl004_02_01       #供應商編號 
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pspc_d[l_ac1].pmdl004_02_01

            LET g_qryparam.where = "1=1 "

            #統一使用s_control_get_supplier_sql()回傳的sql丟入where條件即可 
            CALL s_control_get_supplier_sql('4',g_site,g_user,g_dept,g_apsp610_01_input.pmdldocno)
                 RETURNING l_success,l_sql
            IF l_success THEN
               LET g_qryparam.where = l_sql
            END IF

            CALL q_pmaa001_3()

            LET g_pspc_d[l_ac1].pmdl004_02_01 = g_qryparam.return1 
            DISPLAY g_pspc_d[l_ac1].pmdl004_02_01 TO pmdl004_02_01

            NEXT FIELD pmdl004_02_01

         ON ACTION controlp INFIELD pmdn001_02_01         #採購料號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pspc_d[l_ac1].pmdn001_02_01

            LET g_qryparam.WHERE = "1=1 "

            #呼叫s_control_get_item_sql取得where  
            CALL s_control_get_item_sql('4',g_site,g_user,g_dept,g_apsp610_01_input.pmdldocno)
                 RETURNING l_success,l_sql
            IF l_success THEN
               LET g_qryparam.where = l_sql
            END IF 
            
            IF cl_get_doc_para(g_enterprise,g_site,g_apsp610_01_input.pmdldocno,'D-BAS-0096') = "Y" THEN
               LET g_qryparam.where = g_qryparam.where,
                                      " AND imaf001 IN (SELECT bmea008 ",
                                      "                   FROM bmea_t ",
                                      "                  WHERE bmeaent = '",g_enterprise,"' ",
                                      "                    AND bmeasite = '",g_site,"' ",
                                      "                    AND bmea003  = '",g_pspc_d[l_ac1].pmdn001_02_01,"' ",
                                      "                    AND bmea007 = '2' ",
                                      "                    AND bmea009<= '",g_today,"' ",
                                      "                    AND (bmea010 > '",g_today,"'  OR bmea010 IS NULL ) ",
                                      "                     ) "

            END IF
            
            CALL q_imaf001_15()                                #呼叫開窗  
            LET g_pspc_d[l_ac1].pmdn001_02_01 = g_qryparam.return1

            DISPLAY g_pspc_d[l_ac1].pmdn001_02_01 TO pmdn001_02_01

            NEXT FIELD pmdn001_02_01

         ON ACTION controlp INFIELD pmdn002_02_01 
            #取得產品特徵組別 
            LET l_imaa005 = '' 
            SELECT imaa005 INTO l_imaa005 
              FROM imaa_t 
             WHERE imaaent = g_enterprise 
               AND imaa001 = g_pspc_d[l_ac1].pmdn001_02_01 
         
            IF NOT cl_null(l_imaa005) THEN 
               CALL s_feature_single(g_pspc_d[l_ac1].pmdn001_02_01, 
                                     g_pspc_d[l_ac1].pmdn002_02_01, 
                                     g_site,' ') 
                    RETURNING l_success,g_pspc_d[l_ac1].pmdn002_02_01 
               CALL s_feature_description(g_pspc_d[l_ac1].pmdn001_02_01, 
                                          g_pspc_d[l_ac1].pmdn002_02_01) 
                    RETURNING l_success,g_pspc_d[l_ac1].pmdn002_02_01_desc 
               DISPLAY BY NAME g_pspc_d[l_ac1].pmdn002_02_01, 
                               g_pspc_d[l_ac1].pmdn002_02_01_desc 
            END IF 
        
         ON ACTION controlp INFIELD pmdn006_02_01
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pspc_d[l_ac1].pmdn006_02_01             #給予default值
            CALL q_ooca001_1()                                                  #呼叫開窗
            LET g_pspc_d[l_ac1].pmdn006_02_01 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_pspc_d[l_ac1].pmdn006_02_01 TO pmdn006_02_01              #顯示到畫面上 
            CALL s_desc_get_unit_desc(g_pspc_d[l_ac1].pmdn006_02_01)
                 RETURNING g_pspc_d[l_ac1].pmdn006_02_01_desc
            DISPLAY BY NAME g_pspc_d[l_ac1].pmdn006_02_01_desc
            NEXT FIELD pmdn006_02_01                                            #返回原欄位
            
         ON ACTION controlp INFIELD pmdn008_02_01
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pspc_d[l_ac1].pmdn008_02_01             #給予default值  
            CALL q_ooca001_1()                                                  #呼叫開窗 
            LET g_pspc_d[l_ac1].pmdn008_02_01 = g_qryparam.return1              #將開窗取得的值回傳到變數上 
            DISPLAY g_pspc_d[l_ac1].pmdn008_02_01 TO pmdn008_02_01              #顯示到畫面上 
            CALL s_desc_get_unit_desc(g_pspc_d[l_ac1].pmdn008_02_01)
                 RETURNING g_pspc_d[l_ac1].pmdn008_02_01_desc
            DISPLAY BY NAME g_pspc_d[l_ac1].pmdn008_02_01_desc
            NEXT FIELD pmdn008_02_01                                            #返回原欄位 

         ON ACTION controlp INFIELD pmdn010_02_01
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pspc_d[l_ac1].pmdn010_02_01             #給予default值
            CALL q_ooca001_1()                                                  #呼叫開窗
            LET g_pspc_d[l_ac1].pmdn010_02_01 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_pspc_d[l_ac1].pmdn010_02_01 TO pmdn010_02_01              #顯示到畫面上 
            CALL s_desc_get_unit_desc(g_pspc_d[l_ac1].pmdn010_02_01)
                 RETURNING g_pspc_d[l_ac1].pmdn010_02_01_desc
            DISPLAY BY NAME g_pspc_d[l_ac1].pmdn010_02_01_desc
            NEXT FIELD pmdn010_02_01                                            #返回原欄位  
            
         ON ACTION accept 
            #供應商檢查 
            CALL apsp610_02_get_pmaal004(g_pspc_d[l_ac1].pmdl004_02_01)
                 RETURNING g_pspc_d[l_ac1].pmaal004_02_01
            DISPLAY BY NAME g_pspc_d[l_ac1].pmaal004_02_01
            IF NOT cl_null(g_pspc_d[l_ac1].pmdl004_02_01) THEN
               IF g_pspc_d[l_ac1].pmdl004_02_01 != l_pmdn_t.pmdl004_02_01 OR
                  l_pmdn_t.pmdl004_02_01 IS NULL THEN
                  IF g_pspc_d[l_ac1].pmdb014_02_01 = '3' THEN
                     LET g_pspc_d[l_ac1].pmdl004_02_01 = l_pmdn_t.pmdl004_02_01
                     CALL apsp610_02_get_pmaal004(g_pspc_d[l_ac1].pmdl004_02_01)
                          RETURNING g_pspc_d[l_ac1].pmaal004_02_01
                     DISPLAY BY NAME g_pspc_d[l_ac1].pmaal004_02_01
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apm-00537'     #請購單已指定供應商，不可修改！ 
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD xmdl004_02_01
                  END IF

                  IF NOT apsp610_02_pmdl004_chk(g_pspc_d[l_ac1].pmdl004_02_01) THEN

                     NEXT FIELD xmdl004_02_01
                  END IF

               END IF
            END IF
            
            #採購料號檢查 
            CALL apsp610_02_get_imaal(g_pspc_d[l_ac1].pmdn001_02_01)
                 RETURNING g_pspc_d[l_ac1].imaal003_02_01_2,g_pspc_d[l_ac1].imaal004_02_01_2
            DISPLAY BY NAME g_pspc_d[l_ac1].imaal003_02_01_2,g_pspc_d[l_ac1].imaal004_02_01_2
            IF NOT cl_null(g_pspc_d[l_ac1].pmdn001_02_01) THEN
               IF g_pspc_d[l_ac1].pmdn001_02_01 != l_pmdn_t.pmdn001_02_01 OR
                  l_pmdn_t.pmdn001_02_01 IS NULL THEN
                  IF NOT apsp610_02_pmdn001_chk(g_pspc_d[l_ac1].pmdn001_02_01,
                                                g_pspc_d[l_ac1].pspc050_02_01,
                                                g_pspc_d[l_ac1].pmdl004_02_01,
                                                g_pspc_d[l_ac1].pmdn002_02_01,
                                                g_pspc_d[l_ac1].pspc050_02_01) THEN

                     NEXT FIELD pmdn001_02_01
                  END IF

               END IF
            END IF

            CALL apsp610_02_set_entry_b(l_ac1)
            CALL apsp610_02_set_no_entry_b(l_ac1) 
            
            #產品特徵檢查 
            #如果產品特徵沒有輸入的話，要設定為一個空白 
            IF cl_null(g_pspc_d[l_ac1].pmdn002_02_01) THEN
               LET g_pspc_d[l_ac1].pmdn002_02_01 = ' '
            ELSE
               #取得產品特徵說明 
               CALL s_feature_description(g_pspc_d[l_ac1].pmdn001_02_01,g_pspc_d[l_ac1].pmdn002_02_01)
                    RETURNING l_success,g_pspc_d[l_ac1].pmdn002_02_01_desc
               #產品特徵的基本檢查  
               IF g_pspc_d[l_ac1].pmdn002_02_01 IS NOT NULL THEN
                  IF NOT s_feature_check(g_pspc_d[l_ac1].pmdn001_02_01,g_pspc_d[l_ac1].pmdn002_02_01) THEN
                     LET g_pspc_d[l_ac1].pmdn002_02_01 = l_pmdn_t.pmdn002_02_01
                     CALL s_feature_description(g_pspc_d[l_ac1].pmdn001_02_01,g_pspc_d[l_ac1].pmdn002_02_01)
                          RETURNING l_success,g_pspc_d[l_ac1].pmdn002_02_01_desc
                     NEXT FIELD pmdn002_02_01
                  END IF
               END IF
               IF NOT cl_null(g_pspc_d[l_ac1].pmdn002_02_01) THEN
                  IF g_pspc_d[l_ac1].pmdn002_02_01 != l_pmdn_t.pmdn002_02_01 OR
                     l_pmdn_t.pmdn002_02_01 IS NULL THEN
                     #2.呼叫產品特徵檢核應用元件，檢核輸入的產品特徵值是否合理
                     #3.當請採勾稽時，採購料號+採購產品特徵與請購料號+請購產品特徵不一樣時，必須檢核是否與請購料號+
                     #  請購產品特徵有替代關係，若沒有則不允許修改

                  END IF
               END IF
            END IF 
            
            #採購單位檢查 
            IF NOT cl_null(g_pspc_d[l_ac1].pmdn006_02_01) THEN
               IF g_pspc_d[l_ac1].pmdn006_02_01 != l_pmdn_t.pmdn006_02_01 OR
                  l_pmdn_t.pmdn006_02_01 IS NULL THEN
                  CALL apsp610_02_unit_chk(g_pspc_d[l_ac1].pmdn006_02_01)

                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     #160318-00005#41 --s add
                     IF g_errno = 'sub-01302' THEN
                        LET g_errparam.replace[1] = 'aooi250'
                        LET g_errparam.replace[2] = cl_get_progname('aooi250',g_lang,"2")
                        LET g_errparam.exeprog = 'aooi250'
                     END IF
                     #160318-00005#41 --s add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD pmdn006_02_01
                  END IF

                  IF NOT cl_null(g_pspc_d[l_ac1].pmdn007_02_01) THEN
                     CALL apsp610_02_unit_round(g_pspc_d[l_ac1].pmdn006_02_01,g_pspc_d[l_ac1].pmdn007_02_01)
                          RETURNING g_pspc_d[l_ac1].pmdn007_02_01
                     DISPLAY BY NAME g_pspc_d[l_ac1].pmdn007_02_01

                     #若參數有使用計價單位時，則輸入[C:需求數量]時則應自動推算計價數量，
                     #[C:計價數量]=[C:需求數量]*[C:單位]與[C:計價單位]換算率 
                     IF cl_get_para(g_enterprise,g_site,'S-BAS-0019') = "Y" THEN  #體參數使用採購計價單位
                        CALL apsp610_02_convert_qty(g_pspc_d[l_ac1].pmdn001_02_01,
                                                    g_pspc_d[l_ac1].pmdn006_02_01,
                                                    g_pspc_d[l_ac1].pmdn010_02_01,
                                                    g_pspc_d[l_ac1].pmdn007_02_01)
                             RETURNING g_pspc_d[l_ac1].pmdn011_02_01
                        IF NOT cl_null(g_pspc_d[l_ac1].pmdn011_02_01) THEN
                           CALL apsp610_02_unit_round(g_pspc_d[l_ac1].pmdn010_02_01,g_pspc_d[l_ac1].pmdn011_02_01)
                                RETURNING g_pspc_d[l_ac1].pmdn011_02_01
                           DISPLAY BY NAME g_pspc_d[l_ac1].pmdn011_02_01
                        END IF
                     END IF
                  END IF
               END IF
            END IF

            CALL s_desc_get_unit_desc(g_pspc_d[l_ac1].pmdn006_02_01)
                 RETURNING g_pspc_d[l_ac1].pmdn006_02_01_desc

            #採購數量的檢查 
            IF NOT cl_null(g_pspc_d[l_ac1].pmdn007_02_01) THEN
               IF g_pspc_d[l_ac1].pmdn007_02_01 <= 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ade-00016'   #數量不可小於等於0  
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD pmdn007_02_01
               END IF

               LET l_qty = g_pspc_d[l_ac1].pmdn007_02_01
               IF g_pspc_d[l_ac1].pspc014_02_01 != g_pspc_d[l_ac1].pmdn006_02_01 THEN
                  CALL apsp610_02_convert_qty(g_pspc_d[l_ac1].pspc050_02_01,g_pspc_d[l_ac1].pmdn006_02_01,
                                              g_pspc_d[l_ac1].pspc014_02_01,l_qty)
                       RETURNING l_qty
               END IF

               #如果採購數量乘上轉換率後，超過未轉採購量的數量，就算錯 
               IF l_qty > g_pspc_d[l_ac1].qty_02_01 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'apm-00699'     #數量不可大於未轉採購量！  
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()

                  NEXT FIELD pmdn007_02_01
               END IF

               CALL apsp610_02_unit_round(g_pspc_d[l_ac1].pmdn006_02_01,g_pspc_d[l_ac1].pmdn007_02_01)
                    RETURNING g_pspc_d[l_ac1].pmdn007_02_01
               DISPLAY BY NAME g_pspc_d[l_ac1].pmdn007_02_01 
               
               IF cl_get_para(g_enterprise,g_site,'S-BAS-0028') = 'Y' THEN
                  IF NOT cl_null(g_pspc_d[l_ac1].pmdn001_02_01) AND
                     NOT cl_null(g_pspc_d[l_ac1].pmdn006_02_01) AND
                     NOT cl_null(g_pspc_d[l_ac1].pmdn008_02_01) THEN
                     CALL apsp610_02_convert_qty(g_pspc_d[l_ac1].pmdn001_02_01,g_pspc_d[l_ac1].pmdn006_02_01,
                                                 g_pspc_d[l_ac1].pmdn008_02_01,g_pspc_d[l_ac1].pmdn007_02_01)
                          RETURNING g_pspc_d[l_ac1].pmdn009_02_01
                     IF NOT cl_null(g_pspc_d[l_ac1].pmdn009_02_01) THEN
                        CALL apsp610_02_unit_round(g_pspc_d[l_ac1].pmdn008_02_01,g_pspc_d[l_ac1].pmdn009_02_01)
                             RETURNING g_pspc_d[l_ac1].pmdn009_02_01
                        DISPLAY BY NAME g_pspc_d[l_ac1].pmdn009_02_01
                     END IF

                  END IF
               END IF

               #若參數有使用計價單位時，則輸入[C:需求數量]時則應自動推算計價數量，
               #[C:計價數量]=[C:需求數量]*[C:單位]與[C:計價單位]換算率 
               IF cl_get_para(g_enterprise,g_site,'S-BAS-0019') = "Y" THEN  #體參數使用採購計價單位
                  CALL apsp610_02_convert_qty(g_pspc_d[l_ac1].pmdn001_02_01,g_pspc_d[l_ac1].pmdn006_02_01,
                                              g_pspc_d[l_ac1].pmdn010_02_01,g_pspc_d[l_ac1].pmdn007_02_01)
                       RETURNING g_pspc_d[l_ac1].pmdn011_02_01
                  IF NOT cl_null(g_pspc_d[l_ac1].pmdn011_02_01) THEN
                     CALL apsp610_02_unit_round(g_pspc_d[l_ac1].pmdn010_02_01,g_pspc_d[l_ac1].pmdn011_02_01)
                          RETURNING g_pspc_d[l_ac1].pmdn011_02_01
                     DISPLAY BY NAME g_pspc_d[l_ac1].pmdn011_02_01
                  END IF
               END IF

            END IF 
            #參考單位不可輸入 所以這裡不寫入檢查 
            #參考數量不可輸入 所以這裡不寫入檢查 

            #計價單位的檢查 
            IF NOT cl_null(g_pspc_d[l_ac1].pmdn010_02_01) THEN
                CALL apsp610_02_unit_chk(g_pspc_d[l_ac1].pmdn010_02_01)
                IF NOT cl_null(g_errno) THEN
                   INITIALIZE g_errparam TO NULL
                     LET g_errparam.code   = g_errno
                     LET g_errparam.extend = ''
                     #160318-00005#41 --s add
                     IF g_errno = 'sub-01302' THEN
                        LET g_errparam.replace[1] = 'aooi250'
                        LET g_errparam.replace[2] = cl_get_progname('aooi250',g_lang,"2")
                        LET g_errparam.exeprog = 'aooi250'
                     END IF
                     #160318-00005#41 --s add
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()

                     NEXT FIELD pmdn010_02_01
                END IF

                IF NOT cl_null(g_pspc_d[l_ac1].pmdn011_02_01) THEN
                   CALL apsp610_02_unit_round(g_pspc_d[l_ac1].pmdn010_02_01,g_pspc_d[l_ac1].pmdn011_02_01)
                        RETURNING g_pspc_d[l_ac1].pmdn011_02_01
                   DISPLAY BY NAME g_pspc_d[l_ac1].pmdn011_02_01
                END IF
            END IF 
            
            CALL s_desc_get_unit_desc(g_pspc_d[l_ac1].pmdn010_02_01)
                 RETURNING g_pspc_d[l_ac1].pmdn010_02_01_desc

            #計價數量的檢查 
            IF NOT cl_null(g_pspc_d[l_ac1].pmdn011_02_01) THEN
               IF g_pspc_d[l_ac1].pmdn011_02_01 <= 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code   = 'ade-00016'   #數量不可小於等於0  
                  LET g_errparam.extend = ''
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()

                  NEXT FIELD pmdn011_02_01
               END IF

               LET l_qty = g_pspc_d[l_ac1].pmdn011_02_01
               IF g_pspc_d[l_ac1].pspc014_02_01 != g_pspc_d[l_ac1].pmdn010_02_01 THEN
                  CALL apsp610_02_convert_qty(g_pspc_d[l_ac1].pspc050_02_01,g_pspc_d[l_ac1].pmdn010_02_01,
                                              g_pspc_d[l_ac1].pspc014_02_01,l_qty)
                       RETURNING l_qty
               END IF 
               
               #如果採購數量乘上轉換率後，超過未轉採購量的數量，就算錯 
               IF l_qty > g_pspc_d[l_ac1].qty_02_01 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'apm-00699'     #數量不可大於未轉採購量！  
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()

                  NEXT FIELD pmdn011_02_01
               END IF

               IF NOT cl_null(g_pspc_d[l_ac1].pmdn010_02_01) THEN
                  CALL apsp610_02_unit_round(g_pspc_d[l_ac1].pmdn010_02_01,g_pspc_d[l_ac1].pmdn011_02_01)
                       RETURNING g_pspc_d[l_ac1].pmdn011_02_01
                  DISPLAY BY NAME g_pspc_d[l_ac1].pmdn011_02_01
               END IF
            END IF
            
            UPDATE p610_02_pmdn_t SET pmdl004 = g_pspc_d[l_ac1].pmdl004_02_01,
                                      pmdn001 = g_pspc_d[l_ac1].pmdn001_02_01,
                                      pmdn002 = g_pspc_d[l_ac1].pmdn002_02_01,
                                      pmdn006 = g_pspc_d[l_ac1].pmdn006_02_01,
                                      pmdn007 = g_pspc_d[l_ac1].pmdn007_02_01,
                                      pmdn008 = g_pspc_d[l_ac1].pmdn008_02_01,
                                      pmdn009 = g_pspc_d[l_ac1].pmdn009_02_01,
                                      pmdn010 = g_pspc_d[l_ac1].pmdn010_02_01,
                                      pmdn011 = g_pspc_d[l_ac1].pmdn011_02_01,
                                      pmdn058 = g_pspc_d[l_ac1].pmdn058_02_01
             WHERE NVL(pmdl004,' ') = NVL(l_pmdn_t.pmdl004_02_01,' ')
               AND pspc050 = g_pspc_d[l_ac1].pspc050_02_01
               AND pspc051 = g_pspc_d[l_ac1].pspc051_02_01 
               AND pspc062 = g_pspc_d[l_ac1].pspc062_02_01         #160512-00016#5 20160601 add 
               AND pspc045 = g_pspc_d[l_ac1].pspc045_02_01                    #因為有費用料件
               AND NVL(pmdn050,' ') = NVL(g_pspc_d[l_ac1].pmdn050_02_01,' ')  #所以要多考慮備註 
               AND NVL(pmdl025,' ') = NVL(g_pspc_d[l_ac1].pmdl025_02_01,' ')
               AND NVL(pmdl026,' ') = NVL(g_pspc_d[l_ac1].pmdl026_02_01,' ')
               AND NVL(pmdn058,' ') = NVL(l_pmdn_t.pmdn058_02_01,' ')
               AND NVL(pmdn036,' ') = NVL(l_pmdn_t.pmdn036_02_01,' ')
               AND NVL(pmdn037,' ') = NVL(l_pmdn_t.pmdn037_02_01,' ')
               AND NVL(pmdn038,' ') = NVL(l_pmdn_t.pmdn038_02_01,' ')
               AND NVL(pmdbdocno,' ') = NVL(g_pspc_d[l_ac1].pmdbdocno_02_01,' ')
               AND NVL(pmdbseq,'0') = NVL(g_pspc_d[l_ac1].pmdbseq_02_01,'0') 
               AND NVL(pmdn053,' ') = NVL(g_pspc_d[l_ac1].pmdn053_02_01,' ') #160601-00032#3 20160613 add 

            EXIT DIALOG 
            
         ON ACTION cancel 
            LET g_pspc_d[l_ac1].* = l_pmdn_t.* 
            EXIT DIALOG 
         BEFORE DELETE
            IF NOT cl_ask_del_detail() THEN
               CANCEL DELETE
            END IF

            DELETE FROM p610_02_pmdn_t
             WHERE NVL(pmdl004,' ') = NVL(l_pmdn_t.pmdl004_02_01,' ')
               AND pmdb004 = g_pspc_d[l_ac1].pspc050_02_01
               AND pmdb005 = g_pspc_d[l_ac1].pspc051_02_01
               AND pmdn014 = g_pspc_d[l_ac1].pspc045_02_01                    #因為有費用料件
               AND NVL(pmdn050,' ') = NVL(g_pspc_d[l_ac1].pmdn050_02_01,' ')  #所以要多考慮備註  
               AND NVL(pmdl025,' ') = NVL(g_pspc_d[l_ac1].pmdl025_02_01,' ')
               AND NVL(pmdl026,' ') = NVL(g_pspc_d[l_ac1].pmdl026_02_01,' ')
               AND NVL(pmdn058,' ') = NVL(l_pmdn_t.pmdn058_02_01,' ')
               AND NVL(pmdn036,' ') = NVL(l_pmdn_t.pmdn036_02_01,' ')
               AND NVL(pmdn037,' ') = NVL(l_pmdn_t.pmdn037_02_01,' ')
               AND NVL(pmdn038,' ') = NVL(l_pmdn_t.pmdn038_02_01,' ')
               AND NVL(pmdbdocno,' ') = NVL(g_pspc_d[l_ac1].pmdbdocno_02_01,' ')
               AND NVL(pmdbseq,'0') = NVL(g_pspc_d[l_ac1].pmdbseq_02_01,'0') 
               AND NVL(pmdn053,' ') = NVL(g_pspc_d[l_ac1].pmdn053_02_01,' ') #160601-00032#3 20160613 add 

      END INPUT

      ON ACTION EXIT
         LET g_pspc_d[l_ac1].* = l_pmdn_t.*
         EXIT DIALOG

      ON ACTION close
         EXIT DIALOG
   END DIALOG
END FUNCTION

################################################################################
# Descriptions...: 刪除所選擇的資料
# Memo...........:
# Usage..........: CALL apsp610_02_del_data()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........: 160512-00016#5  2016/06/01 by ming 增加欄位pspc062 保稅否
################################################################################
PUBLIC FUNCTION apsp610_02_del_data()
   DEFINE l_sql     STRING
  #DEFINE l_ac1     LIKE type_t.num5     #170104-00066#1 17/01/05 mark by rainy 
   DEFINE l_ac1     LIKE type_t.num10     #170104-00066#1 17/01/05 add by rainy 
   DEFINE l_success LIKE type_t.num5
   
   IF g_appoint_idx <= 0 THEN
      RETURN
   END IF
   
   
   DELETE FROM p610_02_pmdn_t
    WHERE NVL(pmdl004,' ') = NVL(g_pspc_d[g_appoint_idx].pmdl004_02_01,' ')
      AND pspc050 = g_pspc_d[g_appoint_idx].pspc050_02_01
      AND pspc051 = g_pspc_d[g_appoint_idx].pspc051_02_01
      AND pspc062 = g_pspc_d[g_appoint_idx].pspc062_02_01  #160512-00016#5 20160601 add 
      AND pspc045 = g_pspc_d[g_appoint_idx].pspc045_02_01                  
      AND NVL(qty,'0') = NVL(g_pspc_d[g_appoint_idx].qty_02_01,'0')
      AND NVL(pmdn050,' ') = NVL(g_pspc_d[g_appoint_idx].pmdn050_02_01,' ') 
      AND NVL(pmdl025,' ') = NVL(g_pspc_d[g_appoint_idx].pmdl025_02_01,' ')
      AND NVL(pmdl026,' ') = NVL(g_pspc_d[g_appoint_idx].pmdl026_02_01,' ')
      AND NVL(pmdn058,' ') = NVL(g_pspc_d[g_appoint_idx].pmdn058_02_01,' ')
      AND NVL(pmdn036,' ') = NVL(g_pspc_d[g_appoint_idx].pmdn036_02_01,' ')
      AND NVL(pmdn037,' ') = NVL(g_pspc_d[g_appoint_idx].pmdn037_02_01,' ')
      AND NVL(pmdn038,' ') = NVL(g_pspc_d[g_appoint_idx].pmdn038_02_01,' ')
      AND NVL(pmdbdocno,' ') = NVL(g_pspc_d[g_appoint_idx].pmdbdocno_02_01,' ')
      AND NVL(pmdbseq,'0') = NVL(g_pspc_d[g_appoint_idx].pmdbseq_02_01,'0') 
      AND NVL(pmdn053,' ') = NVL(g_pspc_d[g_appoint_idx].pmdn053_02_01,' ') #160601-00032#3 20160613 add 
   
   #160601-00032#3 20160613 modify by ming -----(S) 
   ##160512-00016#5 20160601 modify by ming -----(S) 
   ##LET l_sql = "SELECT pmdb014,pmdl004,'',pspc050,'','',pspc051,'',pspc014,'', ",
   ##            "       qty,pspc045,pmdn001,'','',pmdn002,'',pmdn006,'',",
   ##            "       pmdn007,pmdn008,'',pmdn009,pmdn010,'',pmdn011,",
   ##            "       pmdl025,'','',pmdl026,'','',pmdn058,'',",
   ##            "       pmdn036,'',pmdn037,'',pmdn038,'',pmdn050,pmdbdocno,pmdbseq ",#,pmdbent,pmdbsite ",
   ##            "  FROM p610_02_pmdn_t "
   #LET l_sql = "SELECT pmdb014,pmdl004,'',pspc050,'','',pspc051,'',pspc062,pspc014,'', ",
   #            "       qty,pspc045,pmdn001,'','',pmdn002,'',pmdn006,'',",
   #            "       pmdn007,pmdn008,'',pmdn009,pmdn010,'',pmdn011,",
   #            "       pmdl025,'','',pmdl026,'','',pmdn058,'',",
   #            "       pmdn036,'',pmdn037,'',pmdn038,'',pmdn050,pmdbdocno,pmdbseq ", 
   #            "  FROM p610_02_pmdn_t "
   ##160512-00016#5 20160601 modify by ming -----(E) 
   LET l_sql = "SELECT pmdb014,pmdl004,'',pspc050,'','',pspc051,'',pspc062,pspc014,'', ",
               "       qty,pspc045,pmdn001,'','',pmdn002,'',pmdn006,'',",
               "       pmdn007,pmdn008,'',pmdn009,pmdn010,'',pmdn011,",
               "       pmdl025,'','',pmdl026,'','',pmdn058,'',",
               "       pmdn036,'',pmdn037,'',pmdn038,'',pmdn050,pmdbdocno,pmdbseq,pmdn053 ", 
               "  FROM p610_02_pmdn_t "
   #160601-00032#3 20160613 modify by ming -----(E) 
   
   PREPARE apsp610_02_del_data_b_fill_prep FROM l_sql
   DECLARE apsp610_02_del_data_b_fill_curs CURSOR FOR apsp610_02_del_data_b_fill_prep 
   
   CALL g_pspc_d.clear()      #上方單身清空  
   LET l_ac1 = 1
   FOREACH apsp610_02_del_data_b_fill_curs INTO g_pspc_d[l_ac1].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      #取得產品特徵說明 
      CALL s_feature_description(g_pspc_d[l_ac1].pspc050_02_01,g_pspc_d[l_ac1].pspc051_02_01)
           RETURNING l_success,g_pspc_d[l_ac1].pspc051_02_01_desc
      CALL s_feature_description(g_pspc_d[l_ac1].pmdn001_02_01,g_pspc_d[l_ac1].pmdn002_02_01)
           RETURNING l_success,g_pspc_d[l_ac1].pmdn002_02_01_desc
      
      CALL apsp610_02_get_imaal(g_pspc_d[l_ac1].pspc050_02_01)
           RETURNING g_pspc_d[l_ac1].imaal003_02_01_1,g_pspc_d[l_ac1].imaal004_02_01_1

      CALL apsp610_02_get_imaal(g_pspc_d[l_ac1].pmdn001_02_01)
           RETURNING g_pspc_d[l_ac1].imaal003_02_01_2,g_pspc_d[l_ac1].imaal004_02_01_2 
           
      #取得請購單位說明 
      CALL s_desc_get_unit_desc(g_pspc_d[l_ac1].pspc014_02_01)
           RETURNING g_pspc_d[l_ac1].pspc014_02_01_desc

      #取得採購單位說明 
      CALL s_desc_get_unit_desc(g_pspc_d[l_ac1].pmdn006_02_01)
           RETURNING g_pspc_d[l_ac1].pmdn006_02_01_desc

      #取得參考單位說明 
      CALL s_desc_get_unit_desc(g_pspc_d[l_ac1].pmdn008_02_01)
           RETURNING g_pspc_d[l_ac1].pmdn008_02_01_desc

      #取得計價單位說明 
      CALL s_desc_get_unit_desc(g_pspc_d[l_ac1].pmdn010_02_01)
           RETURNING g_pspc_d[l_ac1].pmdn010_02_01_desc 
           
      #取得專案編號說明 
      CALL s_desc_get_project_desc(g_pspc_d[l_ac1].pmdn036_02_01)
           RETURNING g_pspc_d[l_ac1].pmdn036_02_01_desc

      #取得WBS編號說明 
      CALL s_desc_get_wbs_desc(g_pspc_d[l_ac1].pmdn036_02_01,g_pspc_d[l_ac1].pmdn037_02_01)
           RETURNING g_pspc_d[l_ac1].pmdn037_02_01_desc

      #取得活動編號說明 
      CALL s_desc_get_activity_desc(g_pspc_d[l_ac1].pmdn036_02_01,g_pspc_d[l_ac1].pmdn038_02_01)
           RETURNING g_pspc_d[l_ac1].pmdn038_02_01_desc


      #送貨地址 
      IF NOT cl_null(g_pspc_d[l_ac1].pmdl025_02_01) THEN
         CALL s_apmp490_get_address('3',g_pspc_d[l_ac1].pmdl025_02_01)
              RETURNING g_pspc_d[l_ac1].pmdl025_02_01_desc,g_pspc_d[l_ac1].pmdl025_02_01_oofb017
      END IF

      #帳款地址 
      IF NOT cl_null(g_pspc_d[l_ac1].pmdl026_02_01) THEN
         CALL s_apmp490_get_address('5',g_pspc_d[l_ac1].pmdl026_02_01)
              RETURNING g_pspc_d[l_ac1].pmdl026_02_01_desc,g_pspc_d[l_ac1].pmdl026_02_01_oofb017
      END IF

      SELECT pmaal004 INTO g_pspc_d[l_ac1].pmaal004_02_01
        FROM pmaal_t
       WHERE pmaalent = g_enterprise
         AND pmaal001 = g_pspc_d[l_ac1].pmdl004_02_01
         AND pmaal002 = g_dlang 

      LET l_ac1 = l_ac1 + 1

   END FOREACH

   CALL g_pspc_d.deleteElement(l_ac1)
   LET l_ac1 = l_ac1 - 1

   IF l_ac1 < g_appoint_idx THEN
      LET g_appoint_idx = l_ac1
   END IF
   
END FUNCTION

 
{</section>}
 
