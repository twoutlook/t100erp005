#該程式未解開Section, 採用最新樣板產出!
{<section id="apsp610_03.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0014(2016-07-15 11:06:09), PR版次:0014(2017-01-13 18:29:52)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000037
#+ Filename...: apsp610_03
#+ Description: APS產生採購單作業_採購調整
#+ Creator....: 05384(2016-01-22 11:32:58)
#+ Modifier...: 06814 -SD/PR- 05423
 
{</section>}
 
{<section id="apsp610_03.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"
#160318-00025#1   2016/04/06  By 07675       將重複內容的錯誤訊息置換為公用錯誤訊息(r.v） 
#160512-00016#5   2016/06/01  By ming        增加欄位pspc062保稅否 
#160601-00032#3   2016/06/13  By ming        增加欄位 庫存管理特徵 
#160621-00003#3   2016/07/28  By 06814       通路改為非必輸
#160727-00019#15 2016/08/03 By 08742   系统中定义的临时表名称超过15码在执行时会出错,所以需要将系统中定义的临时表长度超过15码的全部改掉	 	
#                                      Mod   p610_01_lock_b_t -->p610_tmp01
#                                      Mod   p610_03_pmdn_rel_t -->p610_tmp02
#                                      Mod   p610_03_pmdp_rel_t -->p610_tmp03
#160902-00048#1   2016/09/05  By dorislai 修正SQL少ent的問題
#160823-00010#1   2016/09/10  By dorislai    採購單產生後，回寫已轉數量(pspc061)
#160825-00037#3   2016/10/14  By drosiali    步驟二，選擇要需求來源訂單放到庫存管理特徵的才把來源訂單放到庫存管理特徵(pmdn053)
#161109-00085#14  2016/11/15  By 08993       整批調整系統星號寫法
#161109-00085#61  2016/11/25  By 08171       整批調整系統星號寫法
#170104-00066#1   2017/01/04  By Rainy       筆數相關變數由num5放大至num10
#161221-00064#23  2017/01/10  By zhujing     增加pmao000(1-采购，2-销售),用于区分axmi120和apmi120数据显示
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
GLOBALS "../../aps/4gl/apsp610_03.inc"
#end add-point
 
{</section>}
 
{<section id="apsp610_03.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
 TYPE type_g_pmdl_d RECORD
                              pmdl004_03_01         LIKE pmdl_t.pmdl004,     #供應商   
                              pmaal004_03_01        LIKE pmaal_t.pmaal004,   #供應商名稱 
                              pmdl009_03_01         LIKE pmdl_t.pmdl009,     #付款條件   
                              ooibl004_03_01        LIKE ooibl_t.ooibl004,   #付款條件說明
                              pmdl010_03_01         LIKE pmdl_t.pmdl010,     #交易條件   
                              oocql004_03_01        LIKE oocql_t.oocql004,   #交易條件說明
                              pmdl011_03_01         LIKE pmdl_t.pmdl011,     #稅別    
                              pmdl011_03_01_desc    LIKE type_t.chr80,       #稅別說明
                              pmdl012_03_01         LIKE pmdl_t.pmdl012,     #稅率   
                              pmdl013_03_01         LIKE pmdl_t.pmdl013,     #含稅否  
                              pmdl015_03_01         LIKE pmdl_t.pmdl015,     #幣別    
                              ooail003_03_01        LIKE ooail_t.ooail003,   #幣別說明
                              pmdl016_03_01         LIKE pmdl_t.pmdl016,     #匯率   
                              pmdl017_03_01         LIKE pmdl_t.pmdl017,     #取價方式   
                              pmaml003_03_01        LIKE pmaml_t.pmaml003,   #取價方式說明
                              pmdl023_03_01         LIKE pmdl_t.pmdl023,     #採購通路  
                              pmdl054_03_01         LIKE pmdl_t.pmdl054,     #內外購 
                              pmdl033_03_01         LIKE pmdl_t.pmdl033,     #發票類型
                              pmdl055_03_01         LIKE pmdl_t.pmdl055,     #匯率計算基礎 
                              pmdl025_03_01         LIKE pmdl_t.pmdl025,     #送貨地址 
                              pmdl025_03_01_desc    LIKE type_t.chr500,      # 
                              pmdl025_03_01_oofb017 LIKE oofb_t.oofb017,     # 
                              pmdl026_03_01         LIKE pmdl_t.pmdl026,     #帳款地址 
                              pmdl026_03_01_desc    LIKE type_t.chr500,      # 
                              pmdl026_03_01_oofb017 LIKE oofb_t.oofb017      #  
                           END RECORD
DEFINE g_pmdl_d            DYNAMIC ARRAY OF type_g_pmdl_d
DEFINE g_pmdl_d_t          type_g_pmdl_d 
DEFINE g_pmdl_d_o          type_g_pmdl_d
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

 TYPE type_g_pmdn_d RECORD
                              pmdnseq_03_02      LIKE pmdn_t.pmdnseq,     #項次  
                              pmdn001_03_02      LIKE pmdn_t.pmdn001,     #採購料號  
                              imaal003_03_02     LIKE imaal_t.imaal003,   #品名 
                              imaal004_03_02     LIKE imaal_t.imaal004,   #規格  
                              pmdn002_03_02      LIKE pmdn_t.pmdn002,     #採購產品特徵   
                              pmdn002_03_02_desc LIKE type_t.chr80,       #產品特徵說明 
                              #160512-00016#5 20160601 add by ming -----(S) 
                              pmdn021_03_02      LIKE pmdn_t.pmdn021,     #保稅 
                              #160512-00016#5 20160601 add by ming -----(E) 
                              pmdn006_03_02      LIKE pmdn_t.pmdn006,     #採購單位   
                              pmdn006_03_02_desc LIKE type_t.chr80,       #單位說明
                              pmdn007_03_02      LIKE pmdn_t.pmdn007,     #採購數量  
                              pmdn008_03_02      LIKE pmdn_t.pmdn008,     #參考單位 
                              pmdn008_03_02_desc LIKE type_t.chr80,       #單位說明 
                              pmdn009_03_02      LIKE pmdn_t.pmdn009,     #參考數量 
                              pmdn010_03_02      LIKE pmdn_t.pmdn010,     #計價單位  
                              pmdn010_03_02_desc LIKE type_t.chr80,       #單位說明 
                              pmdn011_03_02      LIKE pmdn_t.pmdn011,     #計價數量  
                              pmdn012_03_02      LIKE pmdn_t.pmdn012,     #交貨日期  
                              pmdn013_03_02      LIKE pmdn_t.pmdn013,     #到廠日期  
                              pmdn014_03_02      LIKE pmdn_t.pmdn014,     #到庫日期  
                              pmdn015_03_02      LIKE pmdn_t.pmdn015,     #單價  
                              pmdn043_03_02      LIKE pmdn_t.pmdn043,     #取出價格  
                              pmdn044_03_02      LIKE pmdn_t.pmdn044,     #價差比 
                              pmdn040_03_02      LIKE pmdn_t.pmdn040,     #取價來源 
                              pmdn058_03_02      LIKE pmdn_t.pmdn058,     #預算科目 
                              pmdn058_03_02_desc LIKE type_t.chr500,      #預算科目說明  
                              pmdn036_03_02      LIKE pmdn_t.pmdn036,     #專案編號 
                              pmdn036_03_02_desc LIKE type_t.chr500,      #專案編號說明 
                              pmdn037_03_02      LIKE pmdn_t.pmdn037,     #WBS 
                              pmdn037_03_02_desc LIKE type_t.chr500,      #WBS說明 
                              pmdn038_03_02      LIKE pmdn_t.pmdn038,     #活動編號 
                              pmdn038_03_02_desc LIKE type_t.chr500,      #活動編號說明 
                              pmdn050_03_02      LIKE pmdn_t.pmdn050,     #備註  
                              pmdbdocno_03_02    LIKE pmdb_t.pmdbdocno,   #請購單號 
                              pmdbseq_03_02      LIKE pmdb_t.pmdbseq,     #請購項次 
                              #160601-00032#3 20160613 add by ming -----(S) 
                              pmdn053_03_02      LIKE pmdn_t.pmdn053,     #庫存管理特徵  
                              #160601-00032#3 20160613 add by ming -----(E) 
                              pmdl004_03_02      LIKE pmdl_t.pmdl004,     #供應商資料  
                              pmdn001_03_02_key  LIKE pmdn_t.pmdn001,
                              pmdn002_03_02_key  LIKE pmdn_t.pmdn002,
                              pmdn006_03_02_key  LIKE pmdn_t.pmdn006,
                              pmdn008_03_02_key  LIKE pmdn_t.pmdn008,
                              pmdn010_03_02_key  LIKE pmdn_t.pmdn010
                           END RECORD
DEFINE g_pmdn_d            DYNAMIC ARRAY OF type_g_pmdn_d
DEFINE g_pmdn_d_t          type_g_pmdn_d 
DEFINE g_pmdn_d_o          type_g_pmdn_d

 TYPE type_g_pmdp_d RECORD                      
                              pmdpseq_03_03      LIKE pmdp_t.pmdpseq,     #項次  
                              pmdpseq1_03_03     LIKE pmdp_t.pmdpseq1,    #項序  
                              pmdp001_03_03      LIKE pmdp_t.pmdp001,     #料號  
                              imaal003_03_03_1   LIKE imaal_t.imaal003,   #品名
                              imaal004_03_03_1   LIKE imaal_t.imaal004,   #規格 
                              pspc004_03_03      LIKE pspc_t.pspc004,     #來源單號  
                              pmdp004_03_03      LIKE pmdp_t.pmdp004,     #來源項次    
                              pmdp007_03_03      LIKE pmdp_t.pmdp007,     #請購料號  
                              imaal003_03_03_2   LIKE imaal_t.imaal003,   #品名
                              imaal004_03_03_2   LIKE imaal_t.imaal004,   #規格 
                              pmdp008_03_03      LIKE pmdp_t.pmdp008,     #請購產品特徵  
                              pmdp008_03_03_desc LIKE type_t.chr80,       #產品特徵說明                              
                              pmdp021_03_03      LIKE pmdp_t.pmdp021,     #沖銷順序  
                              pmdp022_03_03      LIKE pmdp_t.pmdp022,     #需求單位  
                              pmdp023_03_03      LIKE pmdp_t.pmdp023,     #需求數量  
                              pmdp024_03_03      LIKE pmdp_t.pmdp024,     #折合採購量  
                              pspc045_03_03      LIKE pspc_t.pspc045,     #需求日期 
                              pmdb033_03_03      LIKE pmdb_t.pmdb033,     #緊急度 
                              pmdl004_03_03      LIKE pmdl_t.pmdl003      #供應商 
                           END RECORD
DEFINE g_pmdp_d            DYNAMIC ARRAY OF type_g_pmdp_d
DEFINE g_pmdp_d_t          type_g_pmdp_d 

 TYPE type_g_pmdo_d RECORD
                              pmdoseq_03_04      LIKE pmdo_t.pmdoseq,     #項次  
                              pmdoseq1_03_04     LIKE pmdo_t.pmdoseq1,    #項序  
                              pmdo001_03_04      LIKE pmdo_t.pmdo001,     #採購料號  
                              imaal003_03_04     LIKE imaal_t.imaal003,   #品名 
                              imaal004_03_04     LIKE imaal_t.imaal004,   #規格 
                              pmdo002_03_04      LIKE pmdo_t.pmdo002,     #採購產品特徵  
                              pmdo002_03_04_desc LIKE type_t.chr80,       #產品特徵說明  
                              pmdo004_03_04      LIKE pmdo_t.pmdo004,     #採購單位  
                              pmdo005_03_04      LIKE pmdo_t.pmdo005,     #採購數量  
                              pmdoseq2_03_04     LIKE pmdo_t.pmdoseq2,    #分批序 
                              pmdo006_03_04      LIKE pmdo_t.pmdo006,     #分批採購數量 
                              pmdo009_03_04      LIKE pmdo_t.pmdo009,     #交期類型 
                              pmdo011_03_04      LIKE pmdo_t.pmdo011,     #交貨日期  
                              pmdo012_03_04      LIKE pmdo_t.pmdo012,     #到廠日期  
                              pmdo013_03_04      LIKE pmdo_t.pmdo013      #到庫日期  
                           END RECORD
DEFINE g_pmdo_d            DYNAMIC ARRAY OF type_g_pmdo_d
DEFINE g_pmdo_d_t          type_g_pmdo_d
DEFINE g_result_str        LIKE type_t.chr1000        #執行結果 

DEFINE g_ooef008           LIKE ooef_t.ooef008
DEFINE g_ooef009           LIKE ooef_t.ooef009
DEFINE g_ooef019           LIKE ooef_t.ooef019
#end add-point
 
{</section>}
 
{<section id="apsp610_03.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="apsp610_03.other_dialog" >}

DIALOG apsp610_03_input01()
   DEFINE l_wc     STRING

   INPUT BY NAME g_apsp610_03_input.sscb01
                 ATTRIBUTE(WITHOUT DEFAULTS)
      BEFORE INPUT

      ON CHANGE sscb01
         #重新產生單身的資料  
         CALL apsp610_03_create_data()

         #下方單身的資料填充 
         IF cl_null(g_d_idx_p61003_01) OR g_d_idx_p61003_01 = 0 THEN
            LET g_d_idx_p61003_01 = 1
         END IF
         LET l_wc = " pmdl004 = '",g_pmdl_d[g_d_idx_p61003_01].pmdl004_03_01,"' ",
                    " AND NVL(pmdl025,' ') = NVL('",g_pmdl_d[g_d_idx_p61003_01].pmdl025_03_01,"',' ') ",
                    " AND NVL(pmdl026,' ') = NVL('",g_pmdl_d[g_d_idx_p61003_01].pmdl026_03_01,"',' ') "
         CALL apsp610_03_b_fill02(l_wc)
         CALL apsp610_03_b_fill03(l_wc)
         CALL apsp610_03_b_fill04(l_wc)

   END INPUT
END DIALOG

DIALOG apsp610_03_display01()
   DEFINE l_wc     STRING

   DISPLAY ARRAY g_pmdl_d TO s_apsp610_03_detail1.* ATTRIBUTE(COUNT=g_d_cnt_p61003_01)
      BEFORE DISPLAY
         CALL FGL_SET_ARR_CURR(g_d_idx_p61003_01)

      BEFORE ROW
         LET g_d_idx_p61003_01 = DIALOG.getCurrentRow("s_apsp610_03_detail1")
         LET g_appoint_idx = g_d_idx_p61003_01
         LET l_wc = " pmdl004 = '",g_pmdl_d[g_d_idx_p61003_01].pmdl004_03_01,"' ",
                    " AND NVL(pmdl025,' ') = NVL('",g_pmdl_d[g_d_idx_p61003_01].pmdl025_03_01,"',' ') ",
                    " AND NVL(pmdl026,' ') = NVL('",g_pmdl_d[g_d_idx_p61003_01].pmdl026_03_01,"',' ') "
         CALL apsp610_03_b_fill02(l_wc)
         CALL apsp610_03_b_fill03(l_wc)
         CALL apsp610_03_b_fill04(l_wc)

      ON ACTION apsp610_03_modify_detail1
         CALL apsp610_03_input02()
   END DISPLAY
END DIALOG

DIALOG apsp610_03_display02()
   DISPLAY ARRAY g_pmdn_d TO s_apsp610_03_detail2.* ATTRIBUTE(COUNT=g_d_cnt_p61003_02)
      BEFORE DISPLAY
         CALL FGL_SET_ARR_CURR(g_d_idx_p61003_02)

      BEFORE ROW
         LET g_d_idx_p61003_02 = DIALOG.getCurrentRow("s_apsp610_03_detail2")
         LET g_appoint_idx = g_d_idx_p61003_02

      ON ACTION apsp610_03_modify_detail2
         CALL apsp610_03_input03()
   END DISPLAY
END DIALOG

DIALOG apsp610_03_display03()
   DISPLAY ARRAY g_pmdp_d TO s_apsp610_03_detail3.* ATTRIBUTE(COUNT=g_d_cnt_p61003_03)
      BEFORE DISPLAY
         CALL FGL_SET_ARR_CURR(g_d_idx_p61003_03)

      BEFORE ROW
         LET g_d_idx_p61003_03 = DIALOG.getCurrentRow("s_apsp610_03_detail3")
         LET g_appoint_idx = g_d_idx_p61003_03

      ON ACTION apsp610_03_modify_detail3
         CALL apsp610_03_input04()
   END DISPLAY
END DIALOG

DIALOG apsp610_03_display04()
   DISPLAY ARRAY g_pmdo_d TO s_apsp610_03_detail4.* ATTRIBUTE(COUNT=g_d_cnt_p61003_04)
      BEFORE DISPLAY
         CALL FGL_SET_ARR_CURR(g_d_idx_p61003_04)

      BEFORE ROW
         LET g_d_idx_p61003_04 = DIALOG.getCurrentRow("s_apsp610_03_detail4")
         LET g_appoint_idx = g_d_idx_p61003_04

      #---------------(S) 
      #此單身不可維護 
      #ON ACTION apsp610_03_modify_detail4 
      #   CALL apsp610_03_input05() 
      #---------------(E) 
   END DISPLAY
END DIALOG

 
{</section>}
 
{<section id="apsp610_03.other_function" readonly="Y" >}

PUBLIC FUNCTION apsp610_03(--)
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
   OPEN WINDOW w_apsp610_03 WITH FORM cl_ap_formpath("apm","apsp610_03")

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
            LET g_ref_fields[1] = g_apaa_m.apaa001
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
   CLOSE WINDOW w_apsp610_03

   #add-point:input段after input

   #end add-point
}
END FUNCTION

################################################################################
# Descriptions...: 畫面初始化設定
# Memo...........:
# Usage..........: CALL apsp610_03_init()
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_03_init()
   
   WHENEVER ERROR CONTINUE 
   
   CALL cl_set_combo_scc('sscb01','2059')
   CALL cl_set_combo_scc("pmdb033_03_03","2036")       #緊急度  
   
   CALL cl_set_combo_scc("pmdl055_03_01","2086") 
   CALL cl_set_combo_scc("pmdl054_03_01","2087") 
   
   CALL cl_set_combo_scc("pmdo009_03_04","2057") 
   
   CALL cl_set_combo_scc("pmdn040_03_02","2016")       #取價來源  

   LET g_apsp610_03_input.sscb01 = '2'

   #不使用產品特徵，則將產品特徵及說明隱藏 
   IF cl_get_para(g_enterprise,g_site,"S-BAS-0036") = 'N' THEN
      CALL cl_set_comp_visible("pmdn002_03_02,pmdn002_03_02_desc",FALSE)
      CALL cl_set_comp_visible("pmdp008_03_03,pmdp008_03_03_desc",FALSE)
      CALL cl_set_comp_visible("pmdo002_03_04,pmdo002_03_04_desc",FALSE)
   END IF 
   
   #取得據點參數，若不使用參考單位時，則參考單位、數量需隱藏，不可維護 
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0028') = 'N' THEN
      CALL cl_set_comp_visible("pmdn008_03_02,pmdn008_03_02_desc,pmdn009_03_02",FALSE)
   END IF

   #取得據點參數，若不使用計價單位時，則計價單位、數量需隱藏，不可維護 
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0019') = 'N' THEN
      CALL cl_set_comp_visible("pmdn010_03_02,pmdn010_03_02_desc,pmdn011_03_02",FALSE)
   END IF 
   
   #依請購單拆分 
   LET g_apsp610_03_input.p610_03_chk01 = 'N'
   IF g_apsp610_02_input.scb02 = '3' THEN
      #如果第二步的匯總方式設定為「3.不匯總」時，就是依請購單拆分  
      LET g_apsp610_03_input.p610_03_chk01 = 'Y'
   END IF
   DISPLAY BY NAME g_apsp610_03_input.p610_03_chk01

   CALL apsp610_03_set_entry()
   CALL apsp610_03_set_no_entry()   
   CALL g_pmdl_d.clear()
   CALL g_pmdn_d.clear()
   CALL g_pmdp_d.clear()
   CALL g_pmdo_d.clear()  
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsp610_03_input02()
#                  RETURNING 回传参数
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........: 
################################################################################
PUBLIC FUNCTION apsp610_03_input02()
   DEFINE l_wc           STRING
   #DEFINE l_ac1          LIKE type_t.num5     #170104-00066#1 17/01/05 mark by rainy 
   DEFINE l_ac1          LIKE type_t.num10     #170104-00066#1 17/01/05 add by rainy 
   DEFINE l_ooef016      LIKE ooef_t.ooef016 
   DEFINE l_ooef019      LIKE ooef_t.ooef019  
   DEFINE l_success      LIKE type_t.num5 
   DEFINE l_sql          STRING
   DEFINE l_pmdnseq      LIKE pmdn_t.pmdnseq
   DEFINE l_pmdn011      LIKE pmdn_t.pmdn011 
   DEFINE l_pmdn015      LIKE pmdn_t.pmdn015
   DEFINE l_pmdn046      LIKE pmdn_t.pmdn046
   DEFINE l_pmdn047      LIKE pmdn_t.pmdn047
   DEFINE l_pmdn048      LIKE pmdn_t.pmdn048 
   DEFINE l_errno        LIKE type_t.chr10 
   DEFINE l_str          STRING 
   DEFINE l_msg1         LIKE gzze_t.gzze003   #160621-00003#3 20160629 add by beckxie
   
   WHENEVER ERROR CONTINUE 
   
   #獲得當前營運據點的所屬稅區
   LET l_ooef019 = ''
   SELECT ooef019 INTO l_ooef019
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
      
   #160621-00003#3 20160629 add by beckxie---S
   SELECT gzze003 INTO l_msg1 FROM gzze_t WHERE gzze001 = 'aoo-00309' 
      AND gzze002 = g_dlang     
   #160621-00003#3 20160629 add by beckxie---E
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      INPUT ARRAY g_pmdl_d FROM s_apsp610_03_detail1.*
            ATTRIBUTE(COUNT = g_d_cnt_p61003_01,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                      INSERT ROW = FALSE,
                      DELETE ROW = FALSE,
                      APPEND ROW = FALSE)
         BEFORE INPUT
      
         BEFORE ROW
            LET g_d_idx_p61003_01 = DIALOG.getCurrentRow("s_apsp610_03_detail1")
      
            LET g_appoint_idx = g_d_idx_p61003_01
      
            LET l_wc = " pmdl004 = '",g_pmdl_d[g_d_idx_p61003_01].pmdl004_03_01,"' ",
                       " AND NVL(pmdl025,' ') = NVL('",g_pmdl_d[g_d_idx_p61003_01].pmdl025_03_01,"',' ') ",
                       " AND NVL(pmdl026,' ') = NVL('",g_pmdl_d[g_d_idx_p61003_01].pmdl026_03_01,"',' ') "
                       
            CALL apsp610_03_b_fill02(l_wc)
            CALL apsp610_03_b_fill03(l_wc)
            CALL apsp610_03_b_fill04(l_wc)
      
            LET l_ac1 = ARR_CURR() 
            
            #151118-00029#1 20160112 add -----(S) 
            #記錄舊值 
            LET g_pmdl_d_t.* = g_pmdl_d[l_ac1].*
            LET g_pmdl_d_o.* = g_pmdl_d[l_ac1].*
            #151118-00029#1 20160112 add -----(E) 
            
         AFTER FIELD pmdl009_03_01               #付款條件    
            LET g_pmdl_d[l_ac1].ooibl004_03_01 = ' '
            CALL apsp610_03_pmdl009_ref(g_pmdl_d[l_ac1].pmdl009_03_01)
                 RETURNING g_pmdl_d[l_ac1].ooibl004_03_01
                 
            IF NOT cl_null(g_pmdl_d[l_ac1].pmdl009_03_01) THEN
               CALL apsp610_03_pmdl009_chk(g_pmdl_d[l_ac1].pmdl004_03_01,g_pmdl_d[l_ac1].pmdl009_03_01)
               IF NOT cl_null(g_errno) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = g_errno
                  LET g_errparam.popup  = TRUE
                  CALL cl_err() 
                  
                  LET g_pmdl_d[l_ac1].ooibl004_03_01 = ' '
                  CALL apsp610_03_pmdl009_ref(g_pmdl_d[l_ac1].pmdl009_03_01)
                       RETURNING g_pmdl_d[l_ac1].ooibl004_03_01
      
                  NEXT FIELD CURRENT
               END IF
            END IF
            
            CALL apsp610_03_pmdl009_ref(g_pmdl_d[l_ac1].pmdl009_03_01)
                 RETURNING g_pmdl_d[l_ac1].ooibl004_03_01
      
         AFTER FIELD pmdl010_03_01               #交易條件  
            LET g_pmdl_d[l_ac1].oocql004_03_01 = ' '
            CALL apsp610_03_pmdl010_ref(g_pmdl_d[l_ac1].pmdl010_03_01)
                 RETURNING g_pmdl_d[l_ac1].oocql004_03_01 
                 
            IF NOT cl_null(g_pmdl_d[l_ac1].pmdl010_03_01) THEN
               CALL s_azzi650_chk_exist('238',g_pmdl_d[l_ac1].pmdl010_03_01)
                    RETURNING l_success
               IF NOT l_success THEN
                  NEXT FIELD CURRENT
               END IF
            END IF 
            
            CALL apsp610_03_pmdl010_ref(g_pmdl_d[l_ac1].pmdl010_03_01)
                 RETURNING g_pmdl_d[l_ac1].oocql004_03_01
      
         AFTER FIELD pmdl011_03_01                #稅別  
            LET g_pmdl_d[l_ac1].pmdl011_03_01_desc = ' '
            CALL apsp610_03_pmdl011_ref(g_pmdl_d[l_ac1].pmdl011_03_01)
                 RETURNING g_pmdl_d[l_ac1].pmdl011_03_01_desc 
                 
            IF NOT cl_null(g_pmdl_d[l_ac1].pmdl011_03_01) THEN
               CALL apsp610_03_pmdl011_chk(g_pmdl_d[l_ac1].pmdl011_03_01)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = g_errno
                  #160318-00005#41 --s add
                  CASE g_errno
                     WHEN 'sub-01302'
                        LET g_errparam.replace[1] = 'aooi610'
                        LET g_errparam.replace[2] = cl_get_progname('aooi610',g_lang,"2")
                        LET g_errparam.exeprog = 'aooi610'
                  END CASE
                  #160318-00005#41 --e add
                  LET g_errparam.popup  = TRUE
                  CALL cl_err() 
                  
                  LET g_pmdl_d[l_ac1].pmdl011_03_01_desc = ' '
                  CALL apsp610_03_pmdl011_ref(g_pmdl_d[l_ac1].pmdl011_03_01)
                       RETURNING g_pmdl_d[l_ac1].pmdl011_03_01_desc
      
                  NEXT FIELD CURRENT
               END IF
      
               #如果有值的話，就要帶出稅率、單價含稅否  
               SELECT oodb006,oodb005 INTO g_pmdl_d[l_ac1].pmdl012_03_01,
                                           g_pmdl_d[l_ac1].pmdl013_03_01
                 FROM oodb_t,ooef_t 
                WHERE ooefent = oodbent
                  AND ooef001 = g_site
                  AND ooef019 = oodb001
                  AND oodbent = g_enterprise
                  AND oodb002 = g_pmdl_d[l_ac1].pmdl011_03_01
      
            END IF
            
            CALL apsp610_03_pmdl011_ref(g_pmdl_d[l_ac1].pmdl011_03_01)
                 RETURNING g_pmdl_d[l_ac1].pmdl011_03_01_desc
      
         AFTER FIELD pmdl015_03_01         #幣別   
            LET g_pmdl_d[l_ac1].ooail003_03_01 = ' '
            CALL apsp610_03_pmdl015_ref(g_pmdl_d[l_ac1].pmdl015_03_01)
                 RETURNING g_pmdl_d[l_ac1].ooail003_03_01 
                 
            IF NOT cl_null(g_pmdl_d[l_ac1].pmdl015_03_01) THEN
               CALL apsp610_03_pmdl015_chk(g_pmdl_d[l_ac1].pmdl015_03_01)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = g_errno
                  #160318-00005#41 --s add
                  CASE g_errno
                     WHEN 'sub-01302'
                        LET g_errparam.replace[1] = 'aooi150'
                        LET g_errparam.replace[2] = cl_get_progname('aooi150',g_lang,"2")
                        LET g_errparam.exeprog = 'aooi150'
                  END CASE
                  #160318-00005#41 --e add

                  LET g_errparam.popup  = TRUE
                  CALL cl_err()  
                  
                  LET g_pmdl_d[l_ac1].ooail003_03_01 = ' '
                  CALL apsp610_03_pmdl015_ref(g_pmdl_d[l_ac1].pmdl015_03_01)
                       RETURNING g_pmdl_d[l_ac1].ooail003_03_01
      
                  NEXT FIELD CURRENT
               END IF
      
               #ooef016:主幣別編號 
               SELECT ooef016 INTO l_ooef016
                 FROM ooef_t
                WHERE ooefent = g_enterprise
                  AND ooef001 = g_site
               #取匯率 
               CALL s_apmp490_get_exrate(g_pmdl_d[l_ac1].pmdl015_03_01,l_ooef016,g_pmdl_d[l_ac1].pmdl054_03_01)
                    RETURNING g_pmdl_d[l_ac1].pmdl016_03_01 
      
            END IF
            
            CALL apsp610_03_pmdl015_ref(g_pmdl_d[l_ac1].pmdl015_03_01)
                 RETURNING g_pmdl_d[l_ac1].ooail003_03_01
      
         AFTER FIELD pmdl017_03_01          #取價方式   
            CALL apsp610_03_pmdl017_ref(g_pmdl_d[l_ac1].pmdl017_03_01)
                 RETURNING g_pmdl_d[l_ac1].pmaml003_03_01
                 
            IF NOT cl_null(g_pmdl_d[l_ac1].pmdl017_03_01) THEN
               CALL apsp610_03_pmdl017_chk(g_pmdl_d[l_ac1].pmdl017_03_01)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  #160318-00005#41 --s add
                  CASE g_errno
                     WHEN 'sub-01302'
                        LET g_errparam.replace[1] = 'apmi130'
                        LET g_errparam.replace[2] = cl_get_progname('apmi130',g_lang,"2")
                        LET g_errparam.exeprog = 'apmi130'
                  END CASE
                  #160318-00005#41 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err() 
                  
                  LET g_pmdl_d[l_ac1].pmaml003_03_01 = ' '
                  CALL apsp610_03_pmdl017_ref(g_pmdl_d[l_ac1].pmdl017_03_01)
                       RETURNING g_pmdl_d[l_ac1].pmaml003_03_01
      
                  NEXT FIELD CURRENT
               END IF
            END IF  
            
            CALL apsp610_03_pmdl017_ref(g_pmdl_d[l_ac1].pmdl017_03_01)
                 RETURNING g_pmdl_d[l_ac1].pmaml003_03_01
            
         AFTER FIELD pmdl023_03_01          #採購通路 
            IF NOT cl_null(g_pmdl_d[l_ac1].pmdl023_03_01) THEN

               #160621-00003#3 20160627 mark by beckxie---S
               #CALL s_apmp490_oocq_chk('275',g_pmdl_d[l_ac1].pmdl023_03_01)
               #     RETURNING l_errno
               #IF NOT cl_null(l_errno) THEN
               #   #160321-00016#41 s983961--mark(s)
               #   #INITIALIZE g_errparam TO NULL
               #   #LET g_errparam.extend = ''
               #   #LET g_errparam.code   = l_errno                  
               #   #LET g_errparam.popup  = TRUE
               #   #LET g_errparam.replace[1] = s_apmp490_get_gzaal_desc('275')
               #   #LET g_errparam.replace[2] = g_pmdl_d[l_ac1].pmdl023_03_01
               #   #CALL cl_err()
               #   #NEXT FIELD CURRENT
               #   #160321-00016#41 s983961--mark(e)
               #   #160321-00016#41 s983961--add(s)
               #   IF l_errno = 'apm-01037' THEN
               #      INITIALIZE g_errparam TO NULL
               #      LET g_errparam.extend = ''
               #      LET g_errparam.code   = l_errno                  
               #      LET g_errparam.popup  = TRUE
               #      LET g_errparam.replace[1] = s_apmp490_get_gzaal_desc('275')
               #      LET g_errparam.replace[2] = g_pmdl_d[l_ac1].pmdl023_03_01
               #      CALL cl_err()
               #      NEXT FIELD CURRENT
               #   ELSE
               #      INITIALIZE g_errparam TO NULL
               #      LET g_errparam.extend = ''
               #      LET g_errparam.code   = l_errno                  
               #      LET g_errparam.popup  = TRUE                    
               #      LET g_errparam.replace[1] ='apmi012'
               #      LET g_errparam.replace[2] = cl_get_progname('apmi012',g_lang,"2")
               #      LET g_errparam.exeprog ='apmi012'
               #      CALL cl_err()
               #      NEXT FIELD CURRENT      
               #   END IF 
               #   #160321-00016#41 s983961--add(e)                  
               #END IF
               #160621-00003#3 20160627 mark by beckxie---E
               #160621-00003#3 20160627 add by beckxie---S
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_pmdl_d[l_ac1].pmdl023_03_01
               LET g_chkparam.arg2 = '2'
               LET g_chkparam.err_str[1] = "aoo-00299|",l_msg1
               IF NOT cl_chk_exist("v_oojd001") THEN
                  NEXT FIELD CURRENT   
               END IF
               #160621-00003#3 20160627 add by beckxie---E
            END IF 
            
         AFTER FIELD pmdl033_03_01          #發票類型 
            IF NOT cl_null(g_pmdl_d[l_ac1].pmdl033_03_01) THEN
               CALL apsp610_03_pmdl033_chk(l_ooef019,g_pmdl_d[l_ac1].pmdl033_03_01)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code   = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
      
                  NEXT FIELD CURRENT
               END IF
            END IF
      
         ON ROW CHANGE
            UPDATE p610_03_pmdl_t SET pmdl009 = g_pmdl_d[l_ac1].pmdl009_03_01,
                                      pmdl010 = g_pmdl_d[l_ac1].pmdl010_03_01,
                                      pmdl011 = g_pmdl_d[l_ac1].pmdl011_03_01,
                                      pmdl012 = g_pmdl_d[l_ac1].pmdl012_03_01,
                                      pmdl013 = g_pmdl_d[l_ac1].pmdl013_03_01,
                                      pmdl015 = g_pmdl_d[l_ac1].pmdl015_03_01,
                                      pmdl016 = g_pmdl_d[l_ac1].pmdl016_03_01,
                                      pmdl017 = g_pmdl_d[l_ac1].pmdl017_03_01, 
                                      pmdl023 = g_pmdl_d[l_ac1].pmdl023_03_01,
                                      pmdl054 = g_pmdl_d[l_ac1].pmdl054_03_01, 
                                      pmdl033 = g_pmdl_d[l_ac1].pmdl033_03_01,
                                      pmdl055 = g_pmdl_d[l_ac1].pmdl055_03_01
             WHERE pmdl004 = g_pmdl_d[l_ac1].pmdl004_03_01 
               AND NVL(pmdl025,' ') = NVL(g_pmdl_d[l_ac1].pmdl025_03_01,' ')
               AND NVL(pmdl026,' ') = NVL(g_pmdl_d[l_ac1].pmdl026_03_01,' ')
             
            #單身的一些資料也應該被修正 
            LET l_sql = "SELECT pmdnseq,pmdn011,pmdn015 ", 
                        "  FROM p610_tmp02 ",          #160727-00019#15 Mod   p610_03_pmdn_rel_t -->p610_tmp02
                        " WHERE pmdl004 = '",g_pmdl_d[l_ac1].pmdl004_03_01,"' ",
                        " ORDER BY pmdnseq "
            PREPARE p610_03_upd_pmdn_rel_prep1 FROM l_sql
            DECLARE p610_03_upd_pmdn_rel_curs1 CURSOR FOR p610_03_upd_pmdn_rel_prep1
            FOREACH p610_03_upd_pmdn_rel_curs1 INTO l_pmdnseq,l_pmdn011,l_pmdn015 
               CALL s_apmt500_get_amount(g_apsp610_01_input.pmdldocno,l_pmdnseq,g_pmdl_d[l_ac1].pmdl015_03_01,
                                         l_pmdn011,l_pmdn015,g_pmdl_d[l_ac1].pmdl011_03_01)
                    RETURNING l_pmdn046,l_pmdn048,l_pmdn047
               #因為s_apmt500_get_amount會呼叫稅別元件(s_tax)，其中會產生xrcd的資料，所以要做刪除的動作 
               DELETE FROM xrcd_t WHERE xrcdent = g_enterprise
                                    #AND xrcdld  = l_ooef017   #因為這裡只有單別，應該是不會有其他相同的資料  
                                    AND xrcddocno = g_apsp610_01_input.pmdldocno
                                    AND xrcdseq   = l_pmdnseq
                                    AND xrcdseq2  = '0'
               UPDATE p610_tmp02 SET pmdn046 = l_pmdn046,          #160727-00019#15 Mod   p610_03_pmdn_rel_t -->p610_tmp02
                                             pmdn047 = l_pmdn047,
                                             pmdn048 = l_pmdn048
                WHERE pmdl004 = g_pmdl_d[l_ac1].pmdl004_03_01 
                  AND NVL(pmdl025,' ') = NVL(g_pmdl_d[l_ac1].pmdl025_03_01,' ')
                  AND NVL(pmdl026,' ') = NVL(g_pmdl_d[l_ac1].pmdl026_03_01,' ')
                  AND pmdnseq = l_pmdnseq
            END FOREACH
            
            CALL apsp610_03_gen_pmdq()
                        
            #並重產pmdo 
            CALL apsp610_03_gen_pmdo()
            LET l_wc = " pmdl004 = '",g_pmdl_d[l_ac1].pmdl004_03_01,"' ",
                       " AND NVL(pmdl025,' ') = NVL('",g_pmdl_d[l_ac1].pmdl025_03_01,"',' ') ",
                       " AND NVL(pmdl026,' ') = NVL('",g_pmdl_d[l_ac1].pmdl026_03_01,"',' ') "
            CALL apsp610_03_b_fill04(l_wc)
      
         ON ACTION controlp INFIELD pmdl009_03_01
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdl_d[l_ac1].pmdl009_03_01
      
            #給予arg
            LET g_qryparam.arg1 = g_pmdl_d[l_ac1].pmdl004_03_01
            CALL q_pmad002_2()                                            #呼叫開窗
            LET g_pmdl_d[l_ac1].pmdl009_03_01 = g_qryparam.return1
            DISPLAY g_pmdl_d[l_ac1].pmdl009_03_01 TO pmdl009_03_01 
            CALL apsp610_03_pmdl009_ref(g_pmdl_d[l_ac1].pmdl009_03_01)
                 RETURNING g_pmdl_d[l_ac1].ooibl004_03_01
            NEXT FIELD pmdl009_03_01                                      #返回原欄位
      
         ON ACTION controlp INFIELD pmdl010_03_01
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
      
            LET g_qryparam.default1 = g_pmdl_d[l_ac1].pmdl010_03_01       #給予default值
            LET g_qryparam.default2 = ""                                  #g_pmdl_m.oocq010 #參考欄位七
      
            #給予arg
            LET g_qryparam.arg1 = "238" #
      
            CALL q_oocq002()                                              #呼叫開窗
            LET g_pmdl_d[l_ac1].pmdl010_03_01 = g_qryparam.return1        #將開窗取得的值回傳到變數
            DISPLAY g_pmdl_d[l_ac1].pmdl010_03_01 TO pmdl010_03_01        #顯示到畫面上 
            CALL apsp610_03_pmdl010_ref(g_pmdl_d[l_ac1].pmdl010_03_01)
                 RETURNING g_pmdl_d[l_ac1].oocql004_03_01
            NEXT FIELD pmdl010_03_01                                      #返回原欄位
      
         ON ACTION controlp INFIELD pmdl011_03_01
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
      
            LET g_qryparam.default1 = g_pmdl_d[l_ac1].pmdl011_03_01       #給予default值
      
            CALL q_oodb002_2()                                            #呼叫開窗
            LET g_pmdl_d[l_ac1].pmdl011_03_01 = g_qryparam.return1        #將開窗取得的值回傳到變數
            DISPLAY g_pmdl_d[l_ac1].pmdl011_03_01 TO pmdl011_03_01        #顯示到畫面上 
            CALL apsp610_03_pmdl011_ref(g_pmdl_d[l_ac1].pmdl011_03_01)
                 RETURNING g_pmdl_d[l_ac1].pmdl011_03_01_desc
            NEXT FIELD pmdl011_03_01                                      #返回原欄位  
      
         ON ACTION controlp INFIELD pmdl015_03_01
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdl_d[l_ac1].pmdl015_03_01             #給予default值
      
            LET g_qryparam.arg1 = g_site #
      
            CALL q_ooaj002_1()                                                  #呼叫開窗
            LET g_pmdl_d[l_ac1].pmdl015_03_01 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_pmdl_d[l_ac1].pmdl015_03_01 TO pmdl015_03_01              #顯示到畫面上 
            CALL apsp610_03_pmdl015_ref(g_pmdl_d[l_ac1].pmdl015_03_01)
                 RETURNING g_pmdl_d[l_ac1].ooail003_03_01
            NEXT FIELD pmdl015_03_01                                            #返回原欄位 
      
         ON ACTION controlp INFIELD pmdl017_03_01
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
      
            LET g_qryparam.default1 = g_pmdl_d[l_ac1].pmdl017_03_01             #給予default值
      
            CALL q_pmam001()                                                    #呼叫開窗
            LET g_pmdl_d[l_ac1].pmdl017_03_01 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_pmdl_d[l_ac1].pmdl017_03_01 TO pmdl017_03_01              #顯示到畫面上 
            CALL apsp610_03_pmdl017_ref(g_pmdl_d[l_ac1].pmdl017_03_01)
                 RETURNING g_pmdl_d[l_ac1].pmaml003_03_01
            NEXT FIELD pmdl017_03_01                                            #返回原欄位  
         
         ON ACTION controlp INFIELD pmdl023_03_01
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
      
            LET g_qryparam.default1 = g_pmdl_d[l_ac1].pmdl023_03_01
      
            #160621-00003#3 20160627 modify by beckxie---S
			   #LET g_qryparam.arg1 = "275"
            #CALL q_oocq002()                           #呼叫開窗
            LET g_qryparam.arg1 = '2'
            CALL q_oojd001_1()
            #160621-00003#3 20160627 modify by beckxie---E
            LET g_pmdl_d[l_ac1].pmdl023_03_01 = g_qryparam.return1
            DISPLAY g_pmdl_d[l_ac1].pmdl023_03_01 TO pmdl023_03_01
            NEXT FIELD pmdl023_03_01 
            
         ON ACTION controlp INFIELD pmdl033_03_01
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
      
            LET g_qryparam.default1 = g_pmdl_d[l_ac1].pmdl033_03_01
      
            LET g_qryparam.arg1 = l_ooef019
            LET g_qryparam.arg2 = '1'
      
            CALL q_isac002_1()
            LET g_pmdl_d[l_ac1].pmdl033_03_01 = g_qryparam.return1
            DISPLAY g_pmdl_d[l_ac1].pmdl033_03_01 TO pmdl033_03_01
            NEXT FIELD pmdl033_03_01
      
         ON ACTION accept 
         
            #付款條件檢查 
            LET g_pmdl_d[l_ac1].ooibl004_03_01 = ' '
            CALL apsp610_03_pmdl009_ref(g_pmdl_d[l_ac1].pmdl009_03_01)
                 RETURNING g_pmdl_d[l_ac1].ooibl004_03_01
            IF NOT cl_null(g_pmdl_d[l_ac1].pmdl009_03_01) THEN
               CALL apsp610_03_pmdl009_chk(g_pmdl_d[l_ac1].pmdl004_03_01,g_pmdl_d[l_ac1].pmdl009_03_01)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_pmdl_d[l_ac1].ooibl004_03_01 = ' '
                  CALL apsp610_03_pmdl009_ref(g_pmdl_d[l_ac1].pmdl009_03_01)
                       RETURNING g_pmdl_d[l_ac1].ooibl004_03_01

                  NEXT FIELD pmdl009_03_01
               END IF
            END IF

            CALL apsp610_03_pmdl009_ref(g_pmdl_d[l_ac1].pmdl009_03_01)
                 RETURNING g_pmdl_d[l_ac1].ooibl004_03_01

            #交易條件檢查 
            LET g_pmdl_d[l_ac1].oocql004_03_01 = ' ' 
            CALL apsp610_03_pmdl010_ref(g_pmdl_d[l_ac1].pmdl010_03_01)
                 RETURNING g_pmdl_d[l_ac1].oocql004_03_01

            IF NOT cl_null(g_pmdl_d[l_ac1].pmdl010_03_01) THEN
               CALL s_azzi650_chk_exist('238',g_pmdl_d[l_ac1].pmdl010_03_01)
                    RETURNING l_success
               IF NOT l_success THEN
                  NEXT FIELD pmdl010_03_01
               END IF
            END IF

            CALL apsp610_03_pmdl010_ref(g_pmdl_d[l_ac1].pmdl010_03_01)
                 RETURNING g_pmdl_d[l_ac1].oocql004_03_01

            #稅別檢查 
            LET g_pmdl_d[l_ac1].pmdl011_03_01_desc = ' '
            CALL apsp610_03_pmdl011_ref(g_pmdl_d[l_ac1].pmdl011_03_01)
                 RETURNING g_pmdl_d[l_ac1].pmdl011_03_01_desc

            IF NOT cl_null(g_pmdl_d[l_ac1].pmdl011_03_01) THEN
               CALL apsp610_03_pmdl011_chk(g_pmdl_d[l_ac1].pmdl011_03_01)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  #160318-00005#41 --s add
                  CASE g_errno
                     WHEN 'sub-01302'
                        LET g_errparam.replace[1] = 'aooi610'
                        LET g_errparam.replace[2] = cl_get_progname('aooi610',g_lang,"2")
                        LET g_errparam.exeprog = 'aooi610'
                  END CASE
                  #160318-00005#41 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_pmdl_d[l_ac1].pmdl011_03_01_desc = ' ' 
                  CALL apsp610_03_pmdl011_ref(g_pmdl_d[l_ac1].pmdl011_03_01)
                       RETURNING g_pmdl_d[l_ac1].pmdl011_03_01_desc

                  NEXT FIELD pmdl011_03_01
               END IF

               #如果有值的話，就要帶出稅率、單價含稅否  
               SELECT oodb006,oodb005 INTO g_pmdl_d[l_ac1].pmdl012_03_01,
                                           g_pmdl_d[l_ac1].pmdl013_03_01
                 FROM oodb_t,ooef_t
                WHERE ooefent = oodbent
                  AND ooef001 = g_site
                  AND ooef019 = oodb001
                  AND oodbent = g_enterprise
                  AND oodb002 = g_pmdl_d[l_ac1].pmdl011_03_01

            END IF

            CALL apsp610_03_pmdl011_ref(g_pmdl_d[l_ac1].pmdl011_03_01)
                 RETURNING g_pmdl_d[l_ac1].pmdl011_03_01_desc

            #幣別檢查 
            LET g_pmdl_d[l_ac1].ooail003_03_01 = ' '
            CALL apsp610_03_pmdl015_ref(g_pmdl_d[l_ac1].pmdl015_03_01)
                 RETURNING g_pmdl_d[l_ac1].ooail003_03_01

            IF NOT cl_null(g_pmdl_d[l_ac1].pmdl015_03_01) THEN
               CALL apsp610_03_pmdl015_chk(g_pmdl_d[l_ac1].pmdl015_03_01) 
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = g_errno
                  #160318-00005#41 --s add
                  CASE g_errno
                     WHEN 'sub-01302'
                        LET g_errparam.replace[1] = 'aooi150'
                        LET g_errparam.replace[2] = cl_get_progname('aooi150',g_lang,"2")
                        LET g_errparam.exeprog = 'aooi150'
                  END CASE
                  #160318-00005#41 --e add

                  LET g_errparam.popup  = TRUE
                  CALL cl_err()

                  LET g_pmdl_d[l_ac1].ooail003_03_01 = ' '
                  CALL apsp610_03_pmdl015_ref(g_pmdl_d[l_ac1].pmdl015_03_01)
                       RETURNING g_pmdl_d[l_ac1].ooail003_03_01

                  NEXT FIELD pmdl051_03_01
               END IF

               #ooef016:主幣別編號 
               SELECT ooef016 INTO l_ooef016
                 FROM ooef_t
                WHERE ooefent = g_enterprise
                  AND ooef001 = g_site
               #取匯率 
               CALL s_apmp490_get_exrate(g_pmdl_d[l_ac1].pmdl015_03_01,l_ooef016,g_pmdl_d[l_ac1].pmdl054_03_01)
                    RETURNING g_pmdl_d[l_ac1].pmdl016_03_01

            END IF

            CALL apsp610_03_pmdl015_ref(g_pmdl_d[l_ac1].pmdl015_03_01)
                 RETURNING g_pmdl_d[l_ac1].ooail003_03_01

            #取價方式檢查  
            CALL apsp610_03_pmdl017_ref(g_pmdl_d[l_ac1].pmdl017_03_01)
                 RETURNING g_pmdl_d[l_ac1].pmaml003_03_01
            IF NOT cl_null(g_pmdl_d[l_ac1].pmdl017_03_01) THEN
               CALL apsp610_03_pmdl017_chk(g_pmdl_d[l_ac1].pmdl017_03_01)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = g_errno
                  #160318-00005#41 --s add
                  CASE g_errno
                     WHEN 'sub-01302'
                        LET g_errparam.replace[1] = 'apmi130'
                        LET g_errparam.replace[2] = cl_get_progname('apmi130',g_lang,"2")
                        LET g_errparam.exeprog = 'apmi130'
                  END CASE
                  #160318-00005#41 --e add
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()

                  LET g_pmdl_d[l_ac1].pmaml003_03_01 = ' '
                  CALL apsp610_03_pmdl017_ref(g_pmdl_d[l_ac1].pmdl017_03_01)
                       RETURNING g_pmdl_d[l_ac1].pmaml003_03_01

                  NEXT FIELD pmdl017_03_01
               END IF
            END IF

            CALL apsp610_03_pmdl017_ref(g_pmdl_d[l_ac1].pmdl017_03_01)
                 RETURNING g_pmdl_d[l_ac1].pmaml003_03_01

            #採購通路檢查  
            IF NOT cl_null(g_pmdl_d[l_ac1].pmdl023_03_01) THEN
               #160621-00003#3 20160627 mark by beckxie---S
               #CALL s_apmp490_oocq_chk('275',g_pmdl_d[l_ac1].pmdl023_03_01)
               #     RETURNING l_errno
               #IF NOT cl_null(l_errno) THEN
               #   #INITIALIZE g_errparam TO NULL
               #   #LET g_errparam.extend = ''
               #   #LET g_errparam.code   = g_errno
               #   #LET g_errparam.popup  = TRUE
               #   #LET g_errparam.replace[1] = s_apmp490_get_gzaal_desc('275')
               #   #LET g_errparam.replace[2] = g_pmdl_d[l_ac1].pmdl023_03_01
               #   #CALL cl_err()
               #   #NEXT FIELD pmdl023_03_01
               #   #160321-00016#41 s983961--add(s)
               #   IF l_errno = 'apm-01037' THEN
               #      INITIALIZE g_errparam TO NULL
               #      LET g_errparam.extend = ''
               #      LET g_errparam.code   = l_errno                  
               #      LET g_errparam.popup  = TRUE
               #      LET g_errparam.replace[1] = s_apmp490_get_gzaal_desc('275')
               #      LET g_errparam.replace[2] = g_pmdl_d[l_ac1].pmdl023_03_01
               #      CALL cl_err()
               #      NEXT FIELD pmdl023_03_01
               #   ELSE
               #      INITIALIZE g_errparam TO NULL
               #      LET g_errparam.extend = ''
               #      LET g_errparam.code   = l_errno                  
               #      LET g_errparam.popup  = TRUE                    
               #      LET g_errparam.replace[1] ='apmi012'
               #      LET g_errparam.replace[2] = cl_get_progname('apmi012',g_lang,"2")
               #      LET g_errparam.exeprog ='apmi012'
               #      CALL cl_err()
               #      NEXT FIELD pmdl023_03_01      
               #   END IF 
               #   #160321-00016#41 s983961--add(e)    
               #END IF
               #160621-00003#3 20160627 mark by beckxie---E
               #160621-00003#3 20160627 add by beckxie---S
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_pmdl_d[l_ac1].pmdl023_03_01
               LET g_chkparam.arg2 = '2'
               LET g_chkparam.err_str[1] = "aoo-00299|",l_msg1
               IF NOT cl_chk_exist("v_oojd001") THEN
                  NEXT FIELD CURRENT   
               END IF
               #160621-00003#3 20160627 add by beckxie---E
            END IF

            #發票類型檢查 
            IF NOT cl_null(g_pmdl_d[l_ac1].pmdl033_03_01) THEN
               CALL apsp610_03_pmdl033_chk(l_ooef019,g_pmdl_d[l_ac1].pmdl033_03_01)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code   = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()

                  NEXT FIELD pmdl033_03_01
               END IF
            END IF 
         
            UPDATE p610_03_pmdl_t SET pmdl009 = g_pmdl_d[l_ac1].pmdl009_03_01,
                                      pmdl010 = g_pmdl_d[l_ac1].pmdl010_03_01,
                                      pmdl011 = g_pmdl_d[l_ac1].pmdl011_03_01,
                                      pmdl012 = g_pmdl_d[l_ac1].pmdl012_03_01,
                                      pmdl013 = g_pmdl_d[l_ac1].pmdl013_03_01,
                                      pmdl015 = g_pmdl_d[l_ac1].pmdl015_03_01,
                                      pmdl016 = g_pmdl_d[l_ac1].pmdl016_03_01,
                                      pmdl017 = g_pmdl_d[l_ac1].pmdl017_03_01, 
                                      pmdl023 = g_pmdl_d[l_ac1].pmdl023_03_01,
                                      pmdl054 = g_pmdl_d[l_ac1].pmdl054_03_01, 
                                      pmdl033 = g_pmdl_d[l_ac1].pmdl033_03_01,
                                      pmdl055 = g_pmdl_d[l_ac1].pmdl055_03_01
             WHERE pmdl004 = g_pmdl_d[l_ac1].pmdl004_03_01  
               AND NVL(pmdl025,' ') = NVL(g_pmdl_d[l_ac1].pmdl025_03_01,' ')
               AND NVL(pmdl026,' ') = NVL(g_pmdl_d[l_ac1].pmdl026_03_01,' ') 
            
            #單身的一些資料也應該被修正 
            LET l_sql = "SELECT pmdnseq,pmdn011,pmdn015 ",
                        "  FROM p610_tmp02 ",               #160727-00019#15 Mod   p610_03_pmdn_rel_t -->p610_tmp02
                        " WHERE pmdl004 = '",g_pmdl_d[l_ac1].pmdl004_03_01,"' ", 
                        "   AND NVL(pmdl025,' ') = NVL('",g_pmdl_d[l_ac1].pmdl025_03_01,"',' ') ",
                        "   AND NVL(pmdl026,' ') = NVL('",g_pmdl_d[l_ac1].pmdl026_03_01,"',' ') ",
                        " ORDER BY pmdnseq "
            PREPARE p610_03_upd_pmdn_rel_prep2 FROM l_sql
            DECLARE p610_03_upd_pmdn_rel_curs2 CURSOR FOR p610_03_upd_pmdn_rel_prep2
            FOREACH p610_03_upd_pmdn_rel_curs2 INTO l_pmdnseq,l_pmdn011,l_pmdn015
               CALL s_apmt500_get_amount(g_apsp610_01_input.pmdldocno,l_pmdnseq,g_pmdl_d[l_ac1].pmdl015_03_01,
                                         l_pmdn011,l_pmdn015,g_pmdl_d[l_ac1].pmdl011_03_01)
                    RETURNING l_pmdn046,l_pmdn048,l_pmdn047
               #因為s_apmt500_get_amount會呼叫稅別元件(s_tax)，其中會產生xrcd的資料，所以要做刪除的動作 
               DELETE FROM xrcd_t WHERE xrcdent = g_enterprise
                                    AND xrcddocno = g_apsp610_01_input.pmdldocno
                                    AND xrcdseq   = l_pmdnseq
                                    AND xrcdseq2  = '0'
               UPDATE p610_tmp02 SET pmdn046 = l_pmdn046,           #160727-00019#15 Mod   p610_03_pmdn_rel_t -->p610_tmp02
                                             pmdn047 = l_pmdn047,
                                             pmdn048 = l_pmdn048
                WHERE pmdl004 = g_pmdl_d[l_ac1].pmdl004_03_01
                  AND pmdnseq = l_pmdnseq
            END FOREACH 
            
            CALL apsp610_03_gen_pmdq() 
            
            #並重產pmdo 
            CALL apsp610_03_gen_pmdo()
            LET l_wc = " pmdl004 = '",g_pmdl_d[l_ac1].pmdl004_03_01,"' ",
                       " AND NVL(pmdl025,' ') = NVL('",g_pmdl_d[l_ac1].pmdl025_03_01,"',' ') ",
                       " AND NVL(pmdl026,' ') = NVL('",g_pmdl_d[l_ac1].pmdl026_03_01,"',' ') "
            CALL apsp610_03_b_fill04(l_wc)
            
            EXIT DIALOG
      
         ON ACTION cancel 
            LET g_pmdl_d[l_ac1].* = g_pmdl_d_t.*
            EXIT DIALOG
      END INPUT 
   
   END DIALOG
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsp610_03_b_fill01(p_wc)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_03_b_fill01(p_wc)
   DEFINE p_wc     STRING
   DEFINE l_sql    STRING
   #DEFINE l_cnt    LIKE type_t.num5    #170104-00066#1 17/01/05 mark by rainy 
   DEFINE l_cnt    LIKE type_t.num10    #170104-00066#1 17/01/05 add by rainy 
   DEFINE l_wc     STRING 
   DEFINE l_oofa001 LIKE oofa_t.oofa001
   DEFINE l_success LIKE type_t.num5
   
   WHENEVER ERROR CONTINUE 

   CALL g_pmdl_d.clear()

   LET l_sql = "SELECT pmdl004,'',pmdl009,'',pmdl010,'',pmdl011,'', ",
               "       pmdl012,pmdl013,pmdl015,'',pmdl016,pmdl017,'', ",
               "       pmdl023,pmdl054,pmdl033,pmdl055, ",
               "       pmdl025,'','',pmdl026,'','' ",
               "  FROM p610_03_pmdl_t ",
               " WHERE ",p_wc
   PREPARE apsp610_03_b_fill01_prep FROM l_sql
   DECLARE apsp610_03_b_fill01_curs CURSOR FOR apsp610_03_b_fill01_prep

   LET l_cnt = 1
   #FOREACH apsp610_03_b_fill01_curs INTO g_pmdl_d[l_cnt].* #161109-00085#61 mark
   #161109-00085#61 --s add
   FOREACH apsp610_03_b_fill01_curs INTO g_pmdl_d[l_cnt].pmdl004_03_01,g_pmdl_d[l_cnt].pmaal004_03_01,g_pmdl_d[l_cnt].pmdl009_03_01,g_pmdl_d[l_cnt].ooibl004_03_01,g_pmdl_d[l_cnt].pmdl010_03_01,
                                         g_pmdl_d[l_cnt].oocql004_03_01,g_pmdl_d[l_cnt].pmdl011_03_01,g_pmdl_d[l_cnt].pmdl011_03_01_desc,g_pmdl_d[l_cnt].pmdl012_03_01,g_pmdl_d[l_cnt].pmdl013_03_01,         
                                         g_pmdl_d[l_cnt].pmdl015_03_01,g_pmdl_d[l_cnt].ooail003_03_01,g_pmdl_d[l_cnt].pmdl016_03_01,g_pmdl_d[l_cnt].pmdl017_03_01,g_pmdl_d[l_cnt].pmaml003_03_01,        
                                         g_pmdl_d[l_cnt].pmdl023_03_01,g_pmdl_d[l_cnt].pmdl054_03_01,g_pmdl_d[l_cnt].pmdl033_03_01,g_pmdl_d[l_cnt].pmdl055_03_01,g_pmdl_d[l_cnt].pmdl025_03_01,         
                                         g_pmdl_d[l_cnt].pmdl025_03_01_desc,g_pmdl_d[l_cnt].pmdl025_03_01_oofb017,g_pmdl_d[l_cnt].pmdl026_03_01,g_pmdl_d[l_cnt].pmdl026_03_01_desc,g_pmdl_d[l_cnt].pmdl026_03_01_oofb017 
   #161109-00085#61 --e add
      IF STATUS THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = STATUS
         LET g_errparam.extend = 'foreach'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      CALL apsp610_03_get_pmaal004(g_pmdl_d[l_cnt].pmdl004_03_01)
           RETURNING g_pmdl_d[l_cnt].pmaal004_03_01 
           
      CALL apsp610_03_pmdl009_ref(g_pmdl_d[l_cnt].pmdl009_03_01)
           RETURNING g_pmdl_d[l_cnt].ooibl004_03_01

      CALL apsp610_03_pmdl010_ref(g_pmdl_d[l_cnt].pmdl010_03_01)
           RETURNING g_pmdl_d[l_cnt].oocql004_03_01

      CALL apsp610_03_pmdl011_ref(g_pmdl_d[l_cnt].pmdl011_03_01)
           RETURNING g_pmdl_d[l_cnt].pmdl011_03_01_desc

      CALL apsp610_03_pmdl015_ref(g_pmdl_d[l_cnt].pmdl015_03_01)
           RETURNING g_pmdl_d[l_cnt].ooail003_03_01

      CALL apsp610_03_pmdl017_ref(g_pmdl_d[l_cnt].pmdl017_03_01)
           RETURNING g_pmdl_d[l_cnt].pmaml003_03_01 
           
      #送貨地址 
      IF NOT cl_null(g_pmdl_d[l_cnt].pmdl025_03_01) THEN
         CALL s_apmp490_get_address('3',g_pmdl_d[l_cnt].pmdl025_03_01)
              RETURNING g_pmdl_d[l_cnt].pmdl025_03_01_desc,g_pmdl_d[l_cnt].pmdl025_03_01_oofb017
      END IF

      #帳款地址 
      IF NOT cl_null(g_pmdl_d[l_cnt].pmdl026_03_01) THEN
         CALL s_apmp490_get_address('5',g_pmdl_d[l_cnt].pmdl026_03_01)
              RETURNING g_pmdl_d[l_cnt].pmdl026_03_01_desc,g_pmdl_d[l_cnt].pmdl026_03_01_oofb017
      END IF

      LET l_cnt = l_cnt + 1

   END FOREACH

   CALL g_pmdl_d.deleteElement(l_cnt) 
   
   LET l_cnt = l_cnt - 1

   IF l_cnt >=1 THEN
      LET l_wc = " pmdl004 = '",g_pmdl_d[1].pmdl004_03_01,"' ",
                 " AND NVL(pmdl025,' ') = NVL('",g_pmdl_d[1].pmdl025_03_01,"',' ') ",
                 " AND NVL(pmdl026,' ') = NVL('",g_pmdl_d[1].pmdl026_03_01,"',' ') "
      CALL apsp610_03_b_fill02(l_wc)
      CALL apsp610_03_b_fill03(l_wc)
      CALL apsp610_03_b_fill04(l_wc)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 建立temp table 
# Memo...........:
# Usage..........: CALL apsp610_03_create_temp_table()
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_03_create_temp_table()
   
   WHENEVER ERROR CONTINUE 
   
   CREATE TEMP TABLE p610_03_pmdl_t(
      pmdl004        LIKE pmdl_t.pmdl004,    #供應商  
      pmdl009        LIKE pmdl_t.pmdl009,    #付款條件  
      pmdl010        LIKE pmdl_t.pmdl010,    #交易條件  
      pmdl011        LIKE pmdl_t.pmdl011,    #稅別  
      pmdl012        LIKE pmdl_t.pmdl012,    #稅率   
      pmdl013        LIKE pmdl_t.pmdl013,    #含稅否   
      pmdl015        LIKE pmdl_t.pmdl015,    #幣別   
      pmdl016        LIKE pmdl_t.pmdl016,    #匯率   
      pmdl017        LIKE pmdl_t.pmdl017,    #取價方式  
      pmdl023        LIKE pmdl_t.pmdl023,    #採購通路 
      pmdl054        LIKE pmdl_t.pmdl054,    #內外購  
      pmdl033        LIKE pmdl_t.pmdl033,    #發票類型 
      pmdl055        LIKE pmdl_t.pmdl055,    #匯率計算基礎 
      pmdl025        LIKE pmdl_t.pmdl025,    #送貨地址          
      pmdl026        LIKE pmdl_t.pmdl026,    #帳款地址          
      pmal002        LIKE pmal_t.pmal002     #控制組編號  
   )

   CREATE TEMP TABLE p610_03_pmdn_t(
      pmdn001        LIKE pmdn_t.pmdn001,    #採購料號  #pmdnseq        LIKE pmdn_t.pmdnseq,    #項次           #應該不需要項次資料   
      pmdn002        LIKE pmdn_t.pmdn002,    #採購產品特徵  
      pmdn021        LIKE pmdn_t.pmdn021,    #保稅    #160512-00016#5 20160601 add 
      pmdn006        LIKE pmdn_t.pmdn006,    #採購單位   
      pmdn007        LIKE pmdn_t.pmdn007,    #採購數量  
      pmdn008        LIKE pmdn_t.pmdn008,    #參考單位 
      pmdn009        LIKE pmdn_t.pmdn009,    #參考數量 
      pmdn010        LIKE pmdn_t.pmdn010,    #計價單位 
      pmdn011        LIKE pmdn_t.pmdn011,    #計價數量  
      pmdn014        LIKE pmdn_t.pmdn014,    #到庫日期  #pmdn015        LIKE pmdn_t.pmdn015,    #單價 
      pmdl004        LIKE pmdl_t.pmdl004,    #供應商(用來與單頭關聯的) 
      pmdl025        LIKE pmdl_t.pmdl025,    #送貨地址(與單頭關聯)       
      pmdl026        LIKE pmdl_t.pmdl026,    #帳款地址(與單頭關聯)       
      pmdb004        LIKE pmdb_t.pmdb004,    #請購料號(用來回找請購資料的) 
      pmdb005        LIKE pmdb_t.pmdb005,    #產品特徵(用來回找請購資料的)   
      pmdn050        LIKE pmdn_t.pmdn050,     #備註     
      pmdbdocno      LIKE pmdb_t.pmdbdocno,  #請購單號     
      pmdbseq        LIKE pmdb_t.pmdbseq,    #請購項次     
      pmdn053        LIKE pmdn_t.pmdn053     #庫存管理特徵   #160601-00032#3 20160613 add 
   )
   
   CREATE TEMP TABLE p610_03_pmdp_t(
      pmdp001        LIKE pmdp_t.pmdp001,    #採購料號          
      pmdp003        LIKE pmdp_t.pmdp003,    #請購單號                     #pmdpseq1       LIKE pmdp_t.pmdpseq1,   #項序          #應>
      pmdp004        LIKE pmdp_t.pmdp004,    #請購項次 
      pmdp007        LIKE pmdp_t.pmdp007,    #請購料號 
      pmdp008        LIKE pmdp_t.pmdp008,    #請購產品特徵                 #pmdp021        LIKE pmdp_t.pmdp021,    #沖銷順序 
      pmdp022        LIKE pmdp_t.pmdp022,    #需求單位 
      pmdp023        LIKE pmdp_t.pmdp023,    #需求數量 
      pmdb030        LIKE pmdb_t.pmdb030,    #需求日期 
      pmdb033        LIKE pmdb_t.pmdb033,    #緊急度                       #pmdp024        LIKE pmdp_t.pmdp024,    #折合採購量 
      pmdb049        LIKE pmdb_t.pmdb049     #已分配數量 
   )
      #pmdl004        LIKE pmdl_t.pmdl004     #供應商(用來與單頭關聯的)  
      
   CREATE TEMP TABLE p610_03_pmdo_t(
      pmdoseq        LIKE pmdo_t.pmdoseq,
      pmdoseq1       LIKE pmdo_t.pmdoseq1,
      pmdo001        LIKE pmdo_t.pmdo001,
      pmdo002        LIKE pmdo_t.pmdo002,
      pmdo004        LIKE pmdo_t.pmdo004,
      pmdo005        LIKE pmdo_t.pmdo005,
      pmdo011        LIKE pmdo_t.pmdo011,
      pmdo012        LIKE pmdo_t.pmdo012,
      pmdo013        LIKE pmdo_t.pmdo013,
      pmdl004        LIKE pmdl_t.pmdl004,   #供應商(用來與單頭關聯的)   
      pmdl025        LIKE pmdl_t.pmdl025,    #送貨地址(與單頭關聯)        
      pmdl026        LIKE pmdl_t.pmdl026,    #帳款地址(與單頭關聯)       
      pmdoent        LIKE pmdo_t.pmdoent,
      pmdosite       LIKE pmdo_t.pmdosite,
      pmdoseq2       LIKE pmdo_t.pmdoseq2,
      pmdo003        LIKE pmdo_t.pmdo003,
      pmdo006        LIKE pmdo_t.pmdo006,
      pmdo007        LIKE pmdo_t.pmdo007,
      pmdo008        LIKE pmdo_t.pmdo008,
      pmdo009        LIKE pmdo_t.pmdo009,
      pmdo010        LIKE pmdo_t.pmdo010,
      pmdo014        LIKE pmdo_t.pmdo014,
      pmdo015        LIKE pmdo_t.pmdo015,
      pmdo016        LIKE pmdo_t.pmdo016,
      pmdo017        LIKE pmdo_t.pmdo017,
      pmdo019        LIKE pmdo_t.pmdo019,
      pmdo020        LIKE pmdo_t.pmdo020,
      pmdo021        LIKE pmdo_t.pmdo021,
      pmdo022        LIKE pmdo_t.pmdo022,
      pmdo023        LIKE pmdo_t.pmdo023,
      pmdo024        LIKE pmdo_t.pmdo024, 
      pmdo025        LIKE pmdo_t.pmdo025,
      pmdo026        LIKE pmdo_t.pmdo026,
      pmdo027        LIKE pmdo_t.pmdo027,
      pmdo028        LIKE pmdo_t.pmdo028,
      pmdo029        LIKE pmdo_t.pmdo029,
      pmdo030        LIKE pmdo_t.pmdo030,
      pmdo031        LIKE pmdo_t.pmdo031,
      pmdo032        LIKE pmdo_t.pmdo032,
      pmdo033        LIKE pmdo_t.pmdo033,
      pmdo034        LIKE pmdo_t.pmdo034
   )

   CREATE TEMP TABLE p610_03_pmdq_t(
      pmdqent        LIKE pmdq_t.pmdqent,   #企業編號   
      pmdqsite       LIKE pmdq_t.pmdqsite,  #營運據點  
      pmdqseq        LIKE pmdq_t.pmdqseq,   #採購項次  
      pmdqseq2       LIKE pmdq_t.pmdqseq2,  #分批序  
      pmdq002        LIKE pmdq_t.pmdq002,   #分批數量  
      pmdq003        LIKE pmdq_t.pmdq003,   #交貨日期  
      pmdq004        LIKE pmdq_t.pmdq004,   #到廠日期  
      pmdq005        LIKE pmdq_t.pmdq005,   #到庫日期  
      pmdq006        LIKE pmdq_t.pmdq006,   #收貨時段  
      pmdq007        LIKE pmdq_t.pmdq007,   #MRP凍結否  
      pmdl004        LIKE pmdl_t.pmdl004,   #供應商(用來與單頭關聯的) 
      pmdl025        LIKE pmdl_t.pmdl025,   #送貨地址     
      pmdl026        LIKE pmdl_t.pmdl026    #帳款地址     
   )

   #----------------------------------------------------  
   
   CREATE TEMP TABLE p610_tmp02(              #160727-00019#15 Mod   p610_03_pmdn_rel_t -->p610_tmp02
      pmdnseq        LIKE pmdn_t.pmdnseq,    #項次  
      pmdn001        LIKE pmdn_t.pmdn001,    #採購料號  
      pmdn002        LIKE pmdn_t.pmdn002,    #採購產品特徵  
      pmdn006        LIKE pmdn_t.pmdn006,    #採購單位   
      pmdn007        LIKE pmdn_t.pmdn007,    #採購數量  
      pmdn010        LIKE pmdn_t.pmdn010,    #計價單位 
      pmdn011        LIKE pmdn_t.pmdn011,    #計價數量  
      pmdn012        LIKE pmdn_t.pmdn012,    #交貨日期 
      pmdn013        LIKE pmdn_t.pmdn013,    #到廠日期 
      pmdn014        LIKE pmdn_t.pmdn014,    #到庫日期 
      pmdn015        LIKE pmdn_t.pmdn015,    #單價 
      pmdl004        LIKE pmdl_t.pmdl004,    #供應商(用來與單頭關聯的) 
      pmdl025        LIKE pmdl_t.pmdl025,    #送貨地址(用來與單頭關聯的)    
      pmdl026        LIKE pmdl_t.pmdl026,    #帳款地址(用來與單頭關聯的)    
      pmdn003        LIKE pmdn_t.pmdn003,    #包裝容器  
      pmdn008        LIKE pmdn_t.pmdn008,    #參考單位  
      pmdn009        LIKE pmdn_t.pmdn009,    #參考數量  
      pmdn019        LIKE pmdn_t.pmdn019,    #子件特性  
      pmdn020        LIKE pmdn_t.pmdn020,    #緊急度  
      pmdn021        LIKE pmdn_t.pmdn021,    #保稅  
      pmdn022        LIKE pmdn_t.pmdn022,    #部分交貨  
      pmdn024        LIKE pmdn_t.pmdn024,    #多交期  
      pmdn027        LIKE pmdn_t.pmdn027,    #供應商料號  
      pmdn028        LIKE pmdn_t.pmdn028,    #收貨庫位  
      pmdn029        LIKE pmdn_t.pmdn029,    #收貨儲位  
      pmdn032        LIKE pmdn_t.pmdn032,    #取貨模式  
      pmdn033        LIKE pmdn_t.pmdn033,    #備品率  
      pmdn035        LIKE pmdn_t.pmdn035,    #價格核決  
      pmdn036        LIKE pmdn_t.pmdn036,    #專案編號     
      pmdn037        LIKE pmdn_t.pmdn037,    #WBS   
      pmdn038        LIKE pmdn_t.pmdn038,    #活動編號     
      pmdn040        LIKE pmdn_t.pmdn040,    #取價來源  
      pmdn041        LIKE pmdn_t.pmdn041,    #價格參考單號     
      pmdn042        LIKE pmdn_t.pmdn042,    #價格參考項次     
      pmdn043        LIKE pmdn_t.pmdn043,    #取出單價 
      pmdn044        LIKE pmdn_t.pmdn044,    #價差比 
      pmdn045        LIKE pmdn_t.pmdn045,    #行狀態  
      pmdn046        LIKE pmdn_t.pmdn046,    #未稅金額   
      pmdn047        LIKE pmdn_t.pmdn047,    #含稅金額  
      pmdn048        LIKE pmdn_t.pmdn048,    #稅額  
      pmdn050        LIKE pmdn_t.pmdn050,    #備註        
      pmdbdocno      LIKE pmdb_t.pmdbdocno,  #請購單號    
      pmdbseq        LIKE pmdb_t.pmdbseq,    #請購項次    
      pmdn053        LIKE pmdn_t.pmdn053,    #庫存管理特徵    #160601-00032#3 20160613 add 
      pmdn058        LIKE pmdn_t.pmdn058,    #預算科目
      pmdnunit       LIKE pmdn_t.pmdnunit,   #收貨據點  
      pmdnorga       LIKE pmdn_t.pmdnorga    #付款據點  
   )

   CREATE TEMP TABLE p610_tmp03(             #160727-00019#15 Mod   p610_03_pmdp_rel_t -->p610_tmp03
      pmdpseq        LIKE pmdp_t.pmdpseq,    #項次          
      pmdpseq1       LIKE pmdp_t.pmdpseq1,   #項序          
      pmdp001        LIKE pmdp_t.pmdp001,    #料號          
      pspc004        LIKE pspc_t.pspc004,    #來源單號 
      pmdp004        LIKE pmdp_t.pmdp004,    #來源項次 
      pmdp007        LIKE pmdp_t.pmdp007,    #請購料號 
      pmdp008        LIKE pmdp_t.pmdp008,    #請購產品特徵 
      pmdp021        LIKE pmdp_t.pmdp021,    #沖銷順序 
      pmdp022        LIKE pmdp_t.pmdp022,    #需求單位 
      pmdp023        LIKE pmdp_t.pmdp023,    #需求數量 
      pmdp024        LIKE pmdp_t.pmdp024,    #折合採購量 
      pspc045        LIKE pspc_t.pspc045,    #需求日期 
      pmdb033        LIKE pmdb_t.pmdb033,    #緊急度 
      max_pmdp023    LIKE pmdp_t.pmdp023,    #最大數量   20141017 add  
      pmdl004        LIKE pmdl_t.pmdl004,    #供應商(用來與單頭關聯的)  
      pmdl025        LIKE pmdl_t.pmdl025,    #送貨地址(用來與單頭關聯的)     
      pmdl026        LIKE pmdl_t.pmdl026,    #帳款地址(用來與單頭關聯的)     
      pmdb050        LIKE pmdb_t.pmdb050     #請購備註(為了費用料件)   
   )
END FUNCTION

################################################################################
# Descriptions...: 刪除temp table 
# Memo...........:
# Usage..........: CALL apsp610_03_drop_temp_table()
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_03_drop_temp_table()
   
   WHENEVER ERROR CONTINUE 
   
   DROP TABLE p610_03_pmdl_t;
   DROP TABLE p610_03_pmdn_t;
   DROP TABLE p610_03_pmdp_t;
   DROP TABLE p610_03_pmdo_t;
   DROP TABLE p610_03_pmdq_t;

   #--------------------------------------------------- 
   DROP TABLE p610_tmp02;       #160727-00019#15 Mod   p610_03_pmdn_rel_t -->p610_tmp02
   DROP TABLE p610_tmp03;       #160727-00019#15 Mod   p610_03_pmdp_rel_t -->p610_tmp03
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsp610_03_input03()
#                  RETURNING 回传参数
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........: 
################################################################################
PUBLIC FUNCTION apsp610_03_input03()
  #DEFINE l_ac1         LIKE type_t.num5     #170104-00066#1 17/01/05 mark by rainy 
   DEFINE l_ac1         LIKE type_t.num10     #170104-00066#1 17/01/05 add by rainy 
   DEFINE l_sql         STRING
   DEFINE l_sql1        STRING
   DEFINE l_sql2        STRING
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_imaf173     LIKE imaf_t.imaf173
   DEFINE l_imaf174     LIKE imaf_t.imaf174 
   DEFINE l_pmdpseq1    LIKE pmdp_t.pmdpseq1 
   DEFINE l_max_pmdp023 LIKE pmdp_t.pmdp023  
   DEFINE l_qty_t       LIKE pmdp_t.pmdp023       
   DEFINE l_qty_w       LIKE pmdp_t.pmdp023 
   DEFINE l_pmdn007     LIKE pmdn_t.pmdn007  
   DEFINE l_wc          STRING
   DEFINE l_pmdn046     LIKE pmdn_t.pmdn046
   DEFINE l_pmdn047     LIKE pmdn_t.pmdn047
   DEFINE l_pmdn048     LIKE pmdn_t.pmdn048
   DEFINE l_errno       LIKE type_t.chr10
   DEFINE l_flag        LIKE type_t.num5 
   
   WHENEVER ERROR CONTINUE 
   
   IF g_pmdl_d.getLength() > 0 AND (g_d_idx_p61003_01 = 0 OR cl_null(g_d_idx_p61003_01)) THEN
      LET g_d_idx_p61003_01 = 1
   END IF
   
   DIALOG ATTRIBUTES(UNBUFFERED)
      INPUT ARRAY g_pmdn_d FROM s_apsp610_03_detail2.*
            ATTRIBUTE(COUNT = g_d_cnt_p61003_02,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                      INSERT ROW = FALSE,
                      DELETE ROW = FALSE,
                      APPEND ROW = FALSE)
         BEFORE INPUT

         BEFORE ROW
            LET g_d_idx_p61003_02 = DIALOG.getCurrentRow("s_apsp610_03_detail2")
   
            LET g_appoint_idx = g_d_idx_p61003_02

            LET l_ac1 = ARR_CURR()  
            #記錄舊值 
            LET g_pmdn_d_t.* = g_pmdn_d[l_ac1].*
            LET g_pmdn_d_o.* = g_pmdn_d[l_ac1].* 
         
            CALL apsp610_03_set_entry_b(l_ac1)
            CALL apsp610_03_set_no_entry_b(l_ac1)

   
         AFTER FIELD pmdn001_03_02     #採購料號  
            CALL apsp610_03_get_imaal(g_pmdn_d[l_ac1].pmdn001_03_02)
                 RETURNING g_pmdn_d[l_ac1].imaal003_03_02,g_pmdn_d[l_ac1].imaal004_03_02
            DISPLAY BY NAME g_pmdn_d[l_ac1].imaal003_03_02,g_pmdn_d[l_ac1].imaal004_03_02
   
            IF NOT cl_null(g_pmdn_d[l_ac1].pmdn001_03_02) THEN
               IF NOT apsp610_03_pmdn001_chk(g_pmdn_d[l_ac1].pmdn001_03_02,
                                             g_pmdn_d[l_ac1].pmdnseq_03_02,
                                             g_pmdn_d[l_ac1].pmdl004_03_02,
                                             g_pmdn_d[l_ac1].pmdn002_03_02) THEN
                  LET g_pmdn_d[l_ac1].pmdn001_03_02 = g_pmdn_d_o.pmdn001_03_02 
                  NEXT FIELD CURRENT
               END IF
            END IF 
            
            CALL apsp610_03_set_entry_b(l_ac1)
            CALL apsp610_03_set_no_entry_b(l_ac1) 
            
            LET g_pmdn_d_o.pmdn001_03_02 = g_pmdn_d[l_ac1].pmdn001_03_02 
            
         AFTER FIELD pmdn002_03_02     #採購產品特徵  
            #取得產品特徵說明  
            CALL s_feature_description(g_pmdn_d[l_ac1].pmdn001_03_02,g_pmdn_d[l_ac1].pmdn002_03_02)
                 RETURNING l_success,g_pmdn_d[l_ac1].pmdn002_03_02_desc 
            DISPLAY BY NAME g_pmdn_d[l_ac1].pmdn002_03_02_desc
            IF g_pmdn_d[l_ac1].pmdn002_03_02 IS NOT NULL THEN
               IF NOT s_feature_check(g_pmdn_d[l_ac1].pmdn001_03_02,g_pmdn_d[l_ac1].pmdn002_03_02) THEN
   
                  NEXT FIELD CURRENT
               END IF
            ELSE
               LET g_pmdn_d[l_ac1].pmdn002_03_02 = ' '
            END IF
   
         AFTER FIELD pmdn006_03_02     #採購單位  
            IF NOT cl_null(g_pmdn_d[l_ac1].pmdn006_03_02) THEN
               CALL apsp610_03_unit_chk(g_pmdn_d[l_ac1].pmdn006_03_02)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  #160318-00005#41 --s add
                  CASE g_errno
                     WHEN 'sub-01302'
                        LET g_errparam.replace[1] = 'aooi250'
                        LET g_errparam.replace[2] = cl_get_progname('aooi250',g_lang,"2")
                        LET g_errparam.exeprog = 'aooi250'
                  END CASE
                  #160318-00005#41 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
   
                  NEXT FIELD CURRENT
               END IF
   
               IF NOT cl_null(g_pmdn_d[l_ac1].pmdn007_03_02) THEN
                  CALL apsp610_03_unit_round(g_pmdn_d[l_ac1].pmdn006_03_02,
                                             g_pmdn_d[l_ac1].pmdn007_03_02)
                       RETURNING g_pmdn_d[l_ac1].pmdn007_03_02 
                  DISPLAY BY NAME g_pmdn_d[l_ac1].pmdn007_03_02
               END IF
               
               #參考單位 
               IF cl_get_para(g_enterprise,g_site,'S-BAS-0028') = 'Y' THEN
                  IF cl_null(g_pmdn_d[l_ac1].pmdn008_03_02) THEN
                     LET g_pmdn_d[l_ac1].pmdn008_03_02 = g_pmdn_d[l_ac1].pmdn006_03_02
                     CALL s_desc_get_unit_desc(g_pmdn_d[l_ac1].pmdn008_03_02)
                          RETURNING g_pmdn_d[l_ac1].pmdn008_03_02_desc 
                     DISPLAY BY NAME g_pmdn_d[l_ac1].pmdn008_03_02_desc
                  END IF
                  LET g_pmdn_d[l_ac1].pmdn009_03_02 = g_pmdn_d[l_ac1].pmdn007_03_02
                  IF g_pmdn_d[l_ac1].pmdn006_03_02 != g_pmdn_d[l_ac1].pmdn008_03_02 THEN
                     CALL apsp610_03_convert_qty(g_pmdn_d[l_ac1].pmdn001_03_02,g_pmdn_d[l_ac1].pmdn006_03_02,
                                                 g_pmdn_d[l_ac1].pmdn008_03_02,g_pmdn_d[l_ac1].pmdn009_03_02)
                          RETURNING g_pmdn_d[l_ac1].pmdn009_03_02
                  END IF
                  IF NOT cl_null(g_pmdn_d[l_ac1].pmdn009_03_02) THEN
                     CALL apsp610_03_unit_round(g_pmdn_d[l_ac1].pmdn008_03_02,
                                                g_pmdn_d[l_ac1].pmdn009_03_02)
                          RETURNING g_pmdn_d[l_ac1].pmdn009_03_02 
                     DISPLAY BY NAME g_pmdn_d[l_ac1].pmdn009_03_02
                  END IF
               END IF 
            
               #計價單位 
               IF cl_get_para(g_enterprise,g_site,'S-BAS-0019') = 'Y' THEN
                  IF cl_null(g_pmdn_d[l_ac1].pmdn010_03_02) THEN
                     LET g_pmdn_d[l_ac1].pmdn010_03_02 = g_pmdn_d[l_ac1].pmdn006_03_02
                     CALL s_desc_get_unit_desc(g_pmdn_d[l_ac1].pmdn010_03_02)
                          RETURNING g_pmdn_d[l_ac1].pmdn010_03_02_desc 
                     DISPLAY BY NAME g_pmdn_d[l_ac1].pmdn010_03_02_desc
                  END IF
                  LET g_pmdn_d[l_ac1].pmdn011_03_02 = g_pmdn_d[l_ac1].pmdn007_03_02
                  IF g_pmdn_d[l_ac1].pmdn006_03_02 != g_pmdn_d[l_ac1].pmdn010_03_02 THEN
                     CALL apsp610_03_convert_qty(g_pmdn_d[l_ac1].pmdn001_03_02,g_pmdn_d[l_ac1].pmdn006_03_02,
                                                 g_pmdn_d[l_ac1].pmdn010_03_02,g_pmdn_d[l_ac1].pmdn011_03_02)
                          RETURNING g_pmdn_d[l_ac1].pmdn011_03_02
                  END IF
                  IF NOT cl_null(g_pmdn_d[l_ac1].pmdn011_03_02) THEN
                     CALL apsp610_03_unit_round(g_pmdn_d[l_ac1].pmdn010_03_02,
                                                g_pmdn_d[l_ac1].pmdn011_03_02)
                          RETURNING g_pmdn_d[l_ac1].pmdn011_03_02
                  END IF
                  DISPLAY BY NAME g_pmdn_d[l_ac1].pmdn011_03_02
               END IF
            END IF 
         
            CALL s_desc_get_unit_desc(g_pmdn_d[l_ac1].pmdn006_03_02)
                 RETURNING g_pmdn_d[l_ac1].pmdn006_03_02_desc 
            DISPLAY BY NAME g_pmdn_d[l_ac1].pmdn006_03_02_desc
         

         AFTER FIELD pmdn007_03_02     #採購數量  
            IF NOT cl_null(g_pmdn_d[l_ac1].pmdn007_03_02) THEN
               IF g_pmdn_d[l_ac1].pmdn007_03_02 <= 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ade-00016'      #不可小於等於0    
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
       
                  NEXT FIELD CURRENT
               END IF 
               
               #檢查數量是否超過需求數量 
               LET l_pmdn007 = 0
               #防欄位被改變，所以要用不會被改變的回串 
               SELECT SUM(pmdn007) INTO l_pmdn007
                 FROM p610_02_pmdn_t
                WHERE pmdl004 = g_pmdl_d[g_d_idx_p61003_01].pmdl004_03_01              #供應商  
                  AND pmdn001 = g_pmdn_d[l_ac1].pmdn001_03_02_key                      #料件編號  
                  AND pmdn002 = g_pmdn_d[l_ac1].pmdn002_03_02_key                      #產品特徵  
                  AND pmdn006 = g_pmdn_d[l_ac1].pmdn006_03_02_key                      #採購單位   
                  AND NVL(pmdn008,' ') = NVL(g_pmdn_d[l_ac1].pmdn008_03_02_key,' ')    #參考單位 
                  AND NVL(pmdn010,' ') = NVL(g_pmdn_d[l_ac1].pmdn010_03_02_key,' ')    #計價單位   
                  AND NVL(pmdn050,' ') = NVL(g_pmdn_d[l_ac1].pmdn050_03_02,' ')        #備註
                  AND NVL(pmdbdocno,' ') = NVL(g_pmdn_d[l_ac1].pmdbdocno_03_02,' ')    #請購單號
                  AND NVL(pmdbseq,'0')   = NVL(g_pmdn_d[l_ac1].pmdbseq_03_02,'0')      #請購項次  
               IF g_pmdn_d[l_ac1].pmdn007_03_02 > l_pmdn007 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'apm-00699'     #數量不可大於未轉採購量！  
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
   
                  NEXT FIELD CURRENT
               END IF
   
               CALL apsp610_03_unit_round(g_pmdn_d[l_ac1].pmdn006_03_02,
                                          g_pmdn_d[l_ac1].pmdn007_03_02)
                    RETURNING g_pmdn_d[l_ac1].pmdn007_03_02 
               DISPLAY BY NAME g_pmdn_d[l_ac1].pmdn007_03_02
               
               IF g_d_idx_p61003_01 <=0 THEN 
                  LET g_d_idx_p61003_01 = 1 
               END IF 
               LET l_qty_t = g_pmdn_d[l_ac1].pmdn007_03_02 
               LET l_sql = "SELECT pmdpseq1,max_pmdp023 ",  
                           "  FROM p610_tmp03 ",      #160727-00019#15 Mod   p610_03_pmdp_rel_t -->p610_tmp03
                           " WHERE pmdl004 = '",g_pmdl_d[g_d_idx_p61003_01].pmdl004_03_01,"' ",   
                           "   AND pmdpseq = '",g_pmdn_d[l_ac1].pmdnseq_03_02,"' ",    
                           " ORDER BY pmdpseq1 "  
               PREPARE apsp610_03_reset_pmdp_prep FROM l_sql 
               DECLARE apsp610_03_reset_pmdp_curs CURSOR WITH HOLD FOR apsp610_03_reset_pmdp_prep 
               FOREACH apsp610_03_reset_pmdp_curs INTO l_pmdpseq1,l_max_pmdp023 
                  LET l_qty_w = 0 
                  IF l_qty_t >= l_max_pmdp023 THEN 
                     LET l_qty_w = l_max_pmdp023 
                     LET l_qty_t = l_qty_t - l_max_pmdp023 
                  ELSE 
                     LET l_qty_w = l_qty_t 
                     LET l_qty_t = 0 
                  END IF 

                  UPDATE p610_tmp03 SET pmdp023 = l_qty_w,          #160727-00019#15 Mod   p610_03_pmdp_rel_t -->p610_tmp03
                                                pmdp024 = l_qty_w  
                   WHERE pmdl004 = g_pmdl_d[g_d_idx_p61003_01].pmdl004_03_01 
                     AND NVL(pmdl025,' ') = NVL(g_pmdl_d[g_d_idx_p61003_01].pmdl025_03_01,' ')
                     AND NVL(pmdl026,' ') = NVL(g_pmdl_d[g_d_idx_p61003_01].pmdl026_03_01,' ')
                     AND pmdpseq = g_pmdn_d[l_ac1].pmdnseq_03_02 
                     AND pmdpseq1 = l_pmdpseq1  
               END FOREACH            
               
               IF NOT cl_null(g_pmdn_d[l_ac1].pmdn006_03_02) THEN
                  #參考單位 
                  IF cl_get_para(g_enterprise,g_site,'S-BAS-0028') = 'Y' THEN
                     IF NOT cl_null(g_pmdn_d[l_ac1].pmdn001_03_02) AND 
                        NOT cl_null(g_pmdn_d[l_ac1].pmdn006_03_02) AND 
                        NOT cl_null(g_pmdn_d[l_ac1].pmdn008_03_02) THEN
                        CALL apsp610_03_convert_qty(g_pmdn_d[l_ac1].pmdn001_03_02, 
                                                    g_pmdn_d[l_ac1].pmdn006_03_02,
                                                    g_pmdn_d[l_ac1].pmdn008_03_02, 
                                                    g_pmdn_d[l_ac1].pmdn007_03_02)
                             RETURNING g_pmdn_d[l_ac1].pmdn009_03_02
                        IF NOT cl_null(g_pmdn_d[l_ac1].pmdn011_03_02) THEN
                           CALL apsp610_03_unit_round(g_pmdn_d[l_ac1].pmdn008_03_02,
                                                      g_pmdn_d[l_ac1].pmdn009_03_02)
                                RETURNING g_pmdn_d[l_ac1].pmdn009_03_02
                        END IF 
                        DISPLAY BY NAME g_pmdn_d[l_ac1].pmdn009_03_02
                     END IF
                  END IF 
               
                  #計價單位 
                  IF cl_get_para(g_enterprise,g_site,'S-BAS-0019') = 'Y' THEN
                     IF NOT cl_null(g_pmdn_d[l_ac1].pmdn010_03_02) THEN
                        CALL apsp610_03_convert_qty(g_pmdn_d[l_ac1].pmdn001_03_02, 
                                                    g_pmdn_d[l_ac1].pmdn006_03_02,
                                                    g_pmdn_d[l_ac1].pmdn010_03_02, 
                                                    g_pmdn_d[l_ac1].pmdn007_03_02)
                             RETURNING g_pmdn_d[l_ac1].pmdn011_03_02
                        IF NOT cl_null(g_pmdn_d[l_ac1].pmdn011_03_02) THEN
                           CALL apsp610_03_unit_round(g_pmdn_d[l_ac1].pmdn010_03_02,
                                                      g_pmdn_d[l_ac1].pmdn011_03_02)
                                RETURNING g_pmdn_d[l_ac1].pmdn011_03_02
                        END IF
                        DISPLAY BY NAME g_pmdn_d[l_ac1].pmdn011_03_02
                     END IF
                  END IF
               END IF
            END IF  
            
         AFTER FIELD pmdn008_03_02     #參考單位 
            IF NOT cl_null(g_pmdn_d[l_ac1].pmdn008_03_02) THEN
               CALL apsp610_03_unit_chk(g_pmdn_d[l_ac1].pmdn008_03_02)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = g_errno
                  #160318-00005#41 --s add
                  CASE g_errno
                     WHEN 'sub-01302'
                        LET g_errparam.replace[1] = 'aooi250'
                        LET g_errparam.replace[2] = cl_get_progname('aooi250',g_lang,"2")
                        LET g_errparam.exeprog = 'aooi250'
                  END CASE
                  #160318-00005#41 --e add
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
   
                  NEXT FIELD CURRENT
               END IF
               
               LET g_pmdn_d[l_ac1].pmdn009_03_02 = g_pmdn_d[l_ac1].pmdn007_03_02
               IF g_pmdn_d[l_ac1].pmdn006_03_02 != g_pmdn_d[l_ac1].pmdn008_03_02 THEN
                  CALL apsp610_03_convert_qty(g_pmdn_d[l_ac1].pmdn001_03_02,g_pmdn_d[l_ac1].pmdn006_03_02,
                                              g_pmdn_d[l_ac1].pmdn008_03_02,g_pmdn_d[l_ac1].pmdn009_03_02)
                       RETURNING g_pmdn_d[l_ac1].pmdn009_03_02
               END IF
               
               IF NOT cl_null(g_pmdn_d[l_ac1].pmdn009_03_02) THEN
                  CALL apsp610_03_unit_round(g_pmdn_d[l_ac1].pmdn008_03_02,
                                             g_pmdn_d[l_ac1].pmdn009_03_02)
                       RETURNING g_pmdn_d[l_ac1].pmdn009_03_02 
                  DISPLAY BY NAME g_pmdn_d[l_ac1].pmdn009_03_02
               END IF
            END IF
   
            CALL s_desc_get_unit_desc(g_pmdn_d[l_ac1].pmdn008_03_02)
                 RETURNING g_pmdn_d[l_ac1].pmdn008_03_02_desc 
            DISPLAY BY NAME g_pmdn_d[l_ac1].pmdn008_03_02_desc

         AFTER FIELD pmdn009_03_02     #參考數量 
            IF NOT cl_null(g_pmdn_d[l_ac1].pmdn009_03_02) THEN
               IF g_pmdn_d[l_ac1].pmdn009_03_02 <= 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'ade-00016'   #不可小於等於0
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
   
                  NEXT FIELD CURRENT
               END IF
   
               IF NOT cl_null(g_pmdn_d[l_ac1].pmdn008_03_02) THEN
                  CALL apsp610_03_unit_round(g_pmdn_d[l_ac1].pmdn008_03_02,
                                             g_pmdn_d[l_ac1].pmdn009_03_02)
                       RETURNING g_pmdn_d[l_ac1].pmdn009_03_02 
                  DISPLAY BY NAME g_pmdn_d[l_ac1].pmdn009_03_02
               END IF
            END IF
         
         AFTER FIELD pmdn010_03_02     #計價單位    
            IF NOT cl_null(g_pmdn_d[l_ac1].pmdn010_03_02) THEN
               CALL apsp610_03_unit_chk(g_pmdn_d[l_ac1].pmdn010_03_02)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  #160318-00005#41 --s add
                  CASE g_errno
                     WHEN 'sub-01302'
                        LET g_errparam.replace[1] = 'aooi250'
                        LET g_errparam.replace[2] = cl_get_progname('aooi250',g_lang,"2")
                        LET g_errparam.exeprog = 'aooi250'
                  END CASE
                  #160318-00005#41 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
   
                  NEXT FIELD CURRENT
               END IF 
               
               LET g_pmdn_d[l_ac1].pmdn011_03_02 = g_pmdn_d[l_ac1].pmdn007_03_02
               IF g_pmdn_d[l_ac1].pmdn006_03_02 != g_pmdn_d[l_ac1].pmdn010_03_02 THEN
                  CALL apsp610_03_convert_qty(g_pmdn_d[l_ac1].pmdn001_03_02,g_pmdn_d[l_ac1].pmdn006_03_02,
                                              g_pmdn_d[l_ac1].pmdn010_03_02,g_pmdn_d[l_ac1].pmdn011_03_02)
                       RETURNING g_pmdn_d[l_ac1].pmdn011_03_02
               END IF
   
               IF NOT cl_null(g_pmdn_d[l_ac1].pmdn011_03_02) THEN
                  CALL apsp610_03_unit_round(g_pmdn_d[l_ac1].pmdn010_03_02,
                                             g_pmdn_d[l_ac1].pmdn011_03_02)
                       RETURNING g_pmdn_d[l_ac1].pmdn011_03_02 
                  DISPLAY BY NAME g_pmdn_d[l_ac1].pmdn011_03_02
               END IF
            END IF 
            
            CALL s_desc_get_unit_desc(g_pmdn_d[l_ac1].pmdn010_03_02)
                 RETURNING g_pmdn_d[l_ac1].pmdn010_03_02_desc 
            DISPLAY BY NAME g_pmdn_d[l_ac1].pmdn010_03_02_desc
   
         AFTER FIELD pmdn011_03_02     #計價數量 
            IF NOT cl_null(g_pmdn_d[l_ac1].pmdn011_03_02) THEN
               IF g_pmdn_d[l_ac1].pmdn011_03_02 <= 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ade-00016'     #不可小於等於0  
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
       
                  NEXT FIELD CURRENT
               END IF
   
               IF NOT cl_null(g_pmdn_d[l_ac1].pmdn010_03_02) THEN
                  CALL apsp610_03_unit_round(g_pmdn_d[l_ac1].pmdn010_03_02,
                                             g_pmdn_d[l_ac1].pmdn011_03_02)
                       RETURNING g_pmdn_d[l_ac1].pmdn011_03_02 
                  DISPLAY BY NAME g_pmdn_d[l_ac1].pmdn011_03_02
               END IF
            END IF 
            
         AFTER FIELD pmdn012_03_02     #交貨日期  
            IF NOT cl_null(g_pmdn_d[l_ac1].pmdn012_03_02) AND
              (g_pmdn_d[l_ac1].pmdn012_03_02 != g_pmdn_d_o.pmdn012_03_02 OR cl_null(g_pmdn_d_o.pmdn012_03_02)) THEN
               #取得aimm214的到廠前置時間與入庫前置時間 
               LET l_imaf173 = 0       #採購到廠前置時間  
               LET l_imaf174 = 0       #採購入庫前置時間  
               CALL s_apmp490_get_imaf173_imaf174(g_pmdn_d[l_ac1].pmdn001_03_02)
                    RETURNING l_imaf173,l_imaf174

               SELECT ooef008,ooef009 INTO g_ooef008,g_ooef009
                 FROM ooef_t
                WHERE ooefent = g_enterprise
                  AND ooef001 = g_site

               #1.輸入交貨日期後需自動計算到廠日期，公式為交貨日期+[T:料件據點進銷存檔].[C:到廠前置時間]
               #2.輸入交貨日期後需自動計算到庫日期，公式為到廠日期+[T:料件據點進銷存檔].[C:到庫前置時間]
               IF (NOT cl_null(l_imaf173)) AND l_imaf173 <> 0 THEN
                  CALL s_date_get_work_date(g_site,g_ooef008,g_ooef009,g_pmdn_d[l_ac1].pmdn012_03_02,0,l_imaf173)
                       RETURNING g_pmdn_d[l_ac1].pmdn013_03_02
               ELSE
                  LET g_pmdn_d[l_ac1].pmdn013_03_02 = g_pmdn_d[l_ac1].pmdn012_03_02
               END IF 
               
               IF (NOT cl_null(l_imaf174)) AND l_imaf174 <> 0 THEN
                  CALL s_date_get_work_date(g_site,g_ooef008,g_ooef009,g_pmdn_d[l_ac1].pmdn013_03_02,0,l_imaf174)
                       RETURNING g_pmdn_d[l_ac1].pmdn014_03_02
               ELSE
                  LET g_pmdn_d[l_ac1].pmdn014_03_02 = g_pmdn_d[l_ac1].pmdn013_03_02
               END IF

               LET g_pmdn_d_o.pmdn013_03_02 = g_pmdn_d[l_ac1].pmdn013_03_02
               LET g_pmdn_d_o.pmdn014_03_02 = g_pmdn_d[l_ac1].pmdn014_03_02

               #memo -----(S) 
               #因為此單身沒有緊急度欄位 
               #所以此處略過計算 
               #memo -----(E) 
            END IF

            LET g_pmdn_d_o.pmdn012_03_02 = g_pmdn_d[l_ac1].pmdn012_03_02
         
         AFTER FIELD pmdn013_03_02     
            IF NOT cl_null(g_pmdn_d[l_ac1].pmdn013_03_02) AND
               (g_pmdn_d[l_ac1].pmdn013_03_02 != g_pmdn_d_o.pmdn013_03_02 OR cl_null(g_pmdn_d_o.pmdn013_03_02)) THEN
               #取得到廠前置時間與入庫前置時間 
               LET l_imaf173 = 0       #採購到廠前置時間  
               LET l_imaf174 = 0       #採購入庫前置時間   
               CALL s_apmp490_get_imaf173_imaf174(g_pmdn_d[l_ac1].pmdn001_03_02)
                    RETURNING l_imaf173,l_imaf174

               SELECT ooef008,ooef009 INTO g_ooef008,g_ooef009
                 FROM ooef_t
                WHERE ooefent = g_enterprise
                  AND ooef001 = g_site

               IF NOT cl_null(g_pmdn_d[l_ac1].pmdn012_03_02) THEN
                  IF g_pmdn_d[l_ac1].pmdn013_03_02 < g_pmdn_d[l_ac1].pmdn012_03_02 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apm-00267'     #到廠日期不可小於交貨日期！  
                     LET g_errparam.extend = g_pmdn_d[l_ac1].pmdn013_03_02
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  #若交貨日期為NULL時，輸入到廠日期後需自動計算交貨日期，公式為到廠日期-[T:料件據點進銷存檔].[C:到廠前置時間]
                  IF (NOT cl_null(l_imaf173)) AND l_imaf173 <> 0 THEN
                     CALL s_date_get_work_date(g_site,g_ooef008,g_ooef009,g_pmdn_d[l_ac1].pmdn013_03_02,0,(l_imaf173*(-1)))
                          RETURNING g_pmdn_d[l_ac1].pmdn012_03_02
                  ELSE
                     LET g_pmdn_d[l_ac1].pmdn012_03_02 = g_pmdn_d[l_ac1].pmdn013_03_02
                  END IF
               END IF 
               
               #2.輸入到廠日期後需自動計算到庫日期，公式為到廠日期+[T:料件據點進銷存檔].[C:到庫前置時間]
               IF (NOT cl_null(l_imaf174)) AND l_imaf174 <> 0 THEN
                  CALL s_date_get_work_date(g_site,g_ooef008,g_ooef009,g_pmdn_d[l_ac1].pmdn013_03_02,0,l_imaf174)
                       RETURNING g_pmdn_d[l_ac1].pmdn014_03_02
               ELSE
                  LET g_pmdn_d[l_ac1].pmdn014_03_02 = g_pmdn_d[l_ac1].pmdn013_03_02
               END IF

               LET g_pmdn_d_o.pmdn012_03_02 = g_pmdn_d[l_ac1].pmdn012_03_02
               LET g_pmdn_d_o.pmdn014_03_02 = g_pmdn_d[l_ac1].pmdn014_03_02
            END IF

            LET g_pmdn_d_o.pmdn013_03_02 = g_pmdn_d[l_ac1].pmdn013_03_02

         AFTER FIELD pmdn014_03_02     #到庫日期  
            
            IF NOT cl_null(g_pmdn_d[l_ac1].pmdn014_03_02) AND
               (g_pmdn_d[l_ac1].pmdn014_03_02 != g_pmdn_d_o.pmdn014_03_02 OR cl_null(g_pmdn_d_o.pmdn014_03_02)) THEN
               #取得到廠前置時間與入庫前置時間  
               LET l_imaf173 = 0       #採購到廠前置時間  
               LET l_imaf174 = 0       #採購入庫前置時間   
               CALL s_apmp490_get_imaf173_imaf174(g_pmdn_d[l_ac1].pmdn001_03_02)
                    RETURNING l_imaf173,l_imaf174

               SELECT ooef008,ooef009 INTO g_ooef008,g_ooef009
                 FROM ooef_t
                WHERE ooefent = g_enterprise
                  AND ooef001 = g_site

               IF NOT cl_null(g_pmdn_d[l_ac1].pmdn013_03_02) THEN
                  IF g_pmdn_d[l_ac1].pmdn014_03_02 < g_pmdn_d[l_ac1].pmdn013_03_02 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = g_pmdn_d[l_ac1].pmdn014_03_02
                     LET g_errparam.code   = 'apm-00271'     #到庫日期不可小於到廠日期！  
                     LET g_errparam.popup  = TRUE
                     CALL cl_err() 
                     
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  #若到廠日期為NULL時，輸入到庫日期後需自動計算到廠日期，公式為到庫日期-[T:料件據點進銷存檔].[C:到庫前置時間]
                  IF (NOT cl_null(l_imaf174)) AND l_imaf174 <> 0 THEN
                     CALL s_date_get_work_date(g_site,g_ooef008,g_ooef009,g_pmdn_d[l_ac1].pmdn014_03_02,0,(l_imaf174*(-1)))
                          RETURNING g_pmdn_d[l_ac1].pmdn013_03_02
                  ELSE
                     LET g_pmdn_d[l_ac].pmdn013_03_02 = g_pmdn_d[l_ac1].pmdn014_03_02
                  END IF
               END IF
               IF NOT cl_null(g_pmdn_d[l_ac1].pmdn012_03_02) THEN
                  IF g_pmdn_d[l_ac1].pmdn014_03_02 < g_pmdn_d[l_ac1].pmdn012_03_02 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apm-00272'      #到庫日期不可小於交貨日期  
                     LET g_errparam.extend = g_pmdn_d[l_ac1].pmdn014_03_02
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  #若交貨日期為NULL時，輸入到庫日期後需自動計算交貨日期，公式為到廠日期-[T:料件據點進銷存檔].[C:到廠前置時間]
                  IF (NOT cl_null(l_imaf173)) AND l_imaf173 <> 0 THEN
                     CALL s_date_get_work_date(g_site,g_ooef008,g_ooef009,g_pmdn_d[l_ac1].pmdn013_03_02,0,(l_imaf173*(-1)))
                          RETURNING g_pmdn_d[l_ac1].pmdn012_03_02
                  ELSE
                     LET g_pmdn_d[l_ac1].pmdn012_03_02 = g_pmdn_d[l_ac1].pmdn013_03_02
                  END IF
               END IF 
               
            END IF

            LET g_pmdn_d_o.pmdn014_03_02 = g_pmdn_d[l_ac1].pmdn014_03_02
            
         AFTER FIELD pmdn015_03_02     #單價  
            IF NOT cl_null(g_pmdn_d[l_ac1].pmdn015_03_02) THEN 
               IF g_pmdn_d[l_ac1].pmdn015_03_02 != g_pmdn_d_o.pmdn015_03_02 OR
                  cl_null(g_pmdn_d_o.pmdn015_03_02) THEN
                  IF g_pmdn_d[l_ac1].pmdn015_03_02 <= 0 THEN
                     INITIALIZE g_errparam TO NULL
                      LET g_errparam.extend = ''
                      LET g_errparam.code    = 'agl-00042'     #單價不可小於0  
                      LET g_errparam.popup   = TRUE
                      CALL cl_err()
                  
                     NEXT FIELD CURRENT
                  END IF 
                  
                  #依取價方式設置的單價修改控管方式檢核修改後單價的合理性 
                  LET l_errno = ''
                  #pmdl017：取價方式 
                  #pmdn015：單價 
                  #pmdn043：取出價格 
                  #pmdn040：取價來源 
                  #pmdl015：幣別     
                  #pmdn001：料件編號   
                  #pmdn010：計價單位 
                  IF NOT (cl_null(g_pmdl_d[g_d_idx_p61003_01].pmdl017_03_01) OR cl_null(g_pmdn_d[l_ac1].pmdn015_03_02) OR
                          cl_null(g_pmdn_d[l_ac1].pmdn043_03_02)             OR cl_null(g_pmdn_d[l_ac1].pmdn040_03_02) OR
                          cl_null(g_pmdl_d[g_d_idx_p61003_01].pmdl015_03_01) OR cl_null(g_pmdn_d[l_ac1].pmdn001_03_02) OR
                          cl_null(g_pmdn_d[l_ac1].pmdn010_03_02)) THEN
                          CALL s_purchase_price_check(g_pmdl_d[g_d_idx_p61003_01].pmdl017_03_01,
                                                      g_pmdn_d[l_ac1].pmdn015_03_02,
                                                      g_pmdn_d[l_ac1].pmdn043_03_02,
                                                      g_pmdn_d[l_ac1].pmdn040_03_02,
                                                      g_pmdl_d[g_d_idx_p61003_01].pmdl015_03_01,
                                                      g_pmdn_d[l_ac1].pmdn001_03_02,
                                                      g_pmdn_d[l_ac1].pmdn002_03_02,
                                                      g_pmdn_d[l_ac1].pmdn010_03_02)
                               RETURNING l_flag,l_errno
                     IF NOT l_flag THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ''
                        LET g_errparam.code   = l_errno
                        LET g_errparam.popup  = TRUE
                        CALL cl_err() 
                        NEXT FIELD CURRENT
                     END IF
   
                     #呼叫幣別取位應用元件對單價做取位(依單頭幣別做取位基準) 
                     CALL s_curr_round(g_site,g_pmdl_d[g_d_idx_p61003_01].pmdl015_03_01,
                                       g_pmdn_d[l_ac1].pmdn015_03_02,'1')
                          RETURNING g_pmdn_d[l_ac1].pmdn015_03_02
   
                     #計算價差比  
                     IF g_pmdn_d[l_ac1].pmdn043_03_02 <> 0 AND
                        g_pmdn_d[l_ac1].pmdn043_03_02 <> g_pmdn_d[l_ac1].pmdn015_03_02 THEN
                        LET g_pmdn_d[l_ac1].pmdn044_03_02 = ((g_pmdn_d[l_ac1].pmdn015_03_02 - g_pmdn_d[l_ac1].pmdn043_03_02) /
                                                             g_pmdn_d[l_ac1].pmdn043_03_02) * 100
                     END IF
                  END IF
               END IF
            END IF  
            
            LET g_pmdn_d_o.pmdn015_03_02 = g_pmdn_d[l_ac1].pmdn015_03_02
            
         ON ROW CHANGE
            IF cl_null(g_d_idx_p61003_01) OR g_d_idx_p61003_01 = 0 THEN
               LET g_d_idx_p61003_01 = 1
            END IF
            
            CALL s_apmt500_get_amount(g_apsp610_01_input.pmdldocno,'0',g_pmdl_d[g_d_idx_p61003_01].pmdl015_03_01,
                                      g_pmdn_d[l_ac1].pmdn011_03_02,g_pmdn_d[l_ac1].pmdn015_03_02,
                                      g_pmdl_d[g_d_idx_p61003_01].pmdl011_03_01)
                 RETURNING l_pmdn046,l_pmdn048,l_pmdn047

            #因為s_apmt500_get_amount會呼叫稅別元件(s_tax)，其中會產生xrcd的資料，所以要做刪除的動作 
            DELETE FROM xrcd_t WHERE xrcdent = g_enterprise
                                 #AND xrcdld  = l_ooef017   #因為這裡只有單別，應該是不會有其他相同的資料  
                                 AND xrcddocno = g_apsp610_01_input.pmdldocno
                                 AND xrcdseq   = '0'
                                 AND xrcdseq2  = '0'

            UPDATE  p610_tmp02 SET pmdn001 = g_pmdn_d[l_ac1].pmdn001_03_02,            #160727-00019#15 Mod   p610_03_pmdn_rel_t -->p610_tmp02
                                   pmdn002 = g_pmdn_d[l_ac1].pmdn002_03_02,
                                   pmdn006 = g_pmdn_d[l_ac1].pmdn006_03_02,
                                   pmdn007 = g_pmdn_d[l_ac1].pmdn007_03_02,
                                   pmdn008 = g_pmdn_d[l_ac1].pmdn008_03_02,
                                   pmdn009 = g_pmdn_d[l_ac1].pmdn009_03_02,
                                   pmdn010 = g_pmdn_d[l_ac1].pmdn010_03_02,
                                   pmdn011 = g_pmdn_d[l_ac1].pmdn011_03_02,
                                   pmdn012 = g_pmdn_d[l_ac1].pmdn012_03_02,
                                   pmdn013 = g_pmdn_d[l_ac1].pmdn013_03_02,
                                   pmdn014 = g_pmdn_d[l_ac1].pmdn014_03_02,
                                   pmdn015 = g_pmdn_d[l_ac1].pmdn015_03_02,
                                   pmdn046 = l_pmdn046,
                                   pmdn047 = l_pmdn047,
                                   pmdn048 = l_pmdn048
             WHERE pmdl004 = g_pmdl_d[g_d_idx_p61003_01].pmdl004_03_01 
               AND NVL(pmdl025,' ') = NVL(g_pmdl_d[g_d_idx_p61003_01].pmdl025_03_01,' ')
               AND NVL(pmdl026,' ') = NVL(g_pmdl_d[g_d_idx_p61003_01].pmdl026_03_01,' ')
               AND pmdnseq = g_pmdn_d[l_ac1].pmdnseq_03_02 
            
            CALL apsp610_03_gen_pmdq()
            
            #應該重產pmdo，並b_fill 
            CALL apsp610_03_gen_pmdo()
            LET l_wc = " pmdl004 = '",g_pmdl_d[g_d_idx_p61003_01].pmdl004_03_01,"' ",
                       " AND NVL(pmdl025,' ') = NVL('",g_pmdl_d[g_d_idx_p61003_01].pmdl025_03_01,"',' ') ",
                       " AND NVL(pmdl026,' ') = NVL('",g_pmdl_d[g_d_idx_p61003_01].pmdl026_03_01,"',' ') "
            CALL apsp610_03_b_fill04(l_wc)
            
         ON ACTION controlp INFIELD pmdn001_03_02
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmdn_d[l_ac1].pmdn001_03_02             #給予default值

            LET g_qryparam.WHERE = "1=1 "

            LET l_sql = ''
            CALL s_control_get_item_sql('4',g_site,g_user,g_dept,g_apsp610_01_input.pmdldocno)
                 RETURNING l_success,l_sql
            IF l_success THEN
               LET g_qryparam.where = g_qryparam.where," AND ",l_sql
            END IF 
            
            IF cl_get_doc_para(g_enterprise,g_site,g_apsp610_01_input.pmdldocno,'D-BAS-0096') = "Y" THEN
               LET g_qryparam.where = g_qryparam.where,
                                      " AND imaf001 IN (SELECT bmea008 ",
                                      "                   FROM bmea_t ",
                                      "                  WHERE bmeaent = '",g_enterprise,"' ",
                                      "                    AND bmeasite = '",g_site,"' ",
                                      "                    AND bmea003  = '",g_pmdn_d[l_ac1].pmdn001_03_02,"' ",
                                      "                    AND bmea007 = '2' ",
                                      "                    AND bmea009<= '",g_today,"' ",
                                      "                    AND (bmea010 > '",g_today,"'  OR bmea010 IS NULL ) ",
                                      "                     ) "

            END IF

            CALL q_imaf001_15()                                                   #呼叫開窗 
            LET g_pmdn_d[l_ac1].pmdn001_03_02 = g_qryparam.return1              #將開窗取得的值回傳到變數 
            DISPLAY g_pmdn_d[l_ac1].pmdn001_03_02 TO pmdn001_03_02              #顯示到畫面上

            NEXT FIELD pmdn001_03_02                                            #返回原欄位 
         ON ACTION controlp INFIELD pmdn002_03_02
   
         ON ACTION controlp INFIELD pmdn006_03_02
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmdn_d[l_ac1].pmdn006_03_02             #給予default值

            #給予arg

            CALL q_ooca001_1()                                                  #呼叫開窗

            LET g_pmdn_d[l_ac1].pmdn006_03_02 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmdn_d[l_ac1].pmdn006_03_02 TO pmdn006_03_02              #顯示到畫面上
            CALL s_desc_get_unit_desc(g_pmdn_d[l_ac1].pmdn006_03_02)
                 RETURNING g_pmdn_d[l_ac1].pmdn006_03_02_desc
            DISPLAY BY NAME g_pmdn_d[l_ac1].pmdn006_03_02_desc
            NEXT FIELD pmdn006_03_02                                            #返回原欄位 
         
         ON ACTION controlp INFIELD pmdn008_03_02
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdn_d[l_ac1].pmdn008_03_02
       
            CALL q_ooca001_1()
            LET g_pmdn_d[l_ac1].pmdn008_03_02 = g_qryparam.return1
            DISPLAY g_pmdn_d[l_ac1].pmdn008_03_02 TO pmdn008_03_02
            CALL s_desc_get_unit_desc(g_pmdn_d[l_ac1].pmdn008_03_02)
                 RETURNING g_pmdn_d[l_ac1].pmdn008_03_02_desc
            DISPLAY BY NAME g_pmdn_d[l_ac1].pmdn008_03_02_desc
            NEXT FIELD pmdn008_03_02
       
         ON ACTION controlp INFIELD pmdn010_03_02
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
       
            LET g_qryparam.default1 = g_pmdn_d[l_ac1].pmdn010_03_02             #給予default值
       
            CALL q_ooca001_1()                                                  #呼叫開窗 
            LET g_pmdn_d[l_ac1].pmdn010_03_02 = g_qryparam.return1              #將開窗取得的值回傳到變數
       
            DISPLAY g_pmdn_d[l_ac1].pmdn010_03_02 TO pmdn010_03_02              #顯示到畫面上
            CALL s_desc_get_unit_desc(g_pmdn_d[l_ac1].pmdn010_03_02)
                 RETURNING g_pmdn_d[l_ac1].pmdn010_03_02 
            DISPLAY BY NAME g_pmdn_d[l_ac1].pmdn010_03_02_desc
            NEXT FIELD pmdn010_03_02                                            #返回原欄位 
       
         ON ACTION accept
            IF cl_null(g_d_idx_p61003_01) OR g_d_idx_p61003_01 = 0 THEN
               LET g_d_idx_p61003_01 = 1
            END IF
       
            #欄位檢查 
            #採購料號檢查 
            CALL apsp610_03_get_imaal(g_pmdn_d[l_ac1].pmdn001_03_02)
                 RETURNING g_pmdn_d[l_ac1].imaal003_03_02,g_pmdn_d[l_ac1].imaal004_03_02
            DISPLAY BY NAME g_pmdn_d[l_ac1].imaal003_03_02,g_pmdn_d[l_ac1].imaal004_03_02
            IF NOT cl_null(g_pmdn_d[l_ac1].pmdn001_03_02) THEN
               IF NOT apsp610_03_pmdn001_chk(g_pmdn_d[l_ac1].pmdn001_03_02,
                                             g_pmdn_d[l_ac1].pmdnseq_03_02,
                                             g_pmdn_d[l_ac1].pmdl004_03_02,
                                             g_pmdn_d[l_ac1].pmdn002_03_02) THEN
                  LET g_pmdn_d[l_ac1].pmdn001_03_02 = g_pmdn_d_o.pmdn001_03_02 
                  NEXT FIELD pmdn001_03_02
               END IF
            END IF
       
            CALL apsp610_03_set_entry_b(l_ac1)
            CALL apsp610_03_set_no_entry_b(l_ac1)

            #採購產品特徵  
            IF NOT cl_null(g_pmdn_d[l_ac1].pmdn002_03_02) THEN
               #取得產品特徵說明  
               CALL s_feature_description(g_pmdn_d[l_ac1].pmdn001_03_02,g_pmdn_d[l_ac1].pmdn002_03_02)
                    RETURNING l_success,g_pmdn_d[l_ac1].pmdn002_03_02_desc
               DISPLAY BY NAME g_pmdn_d[l_ac1].pmdn002_03_02_desc 
               IF g_pmdn_d[l_ac1].pmdn002_03_02 IS NOT NULL THEN
                  IF NOT s_feature_check(g_pmdn_d[l_ac1].pmdn001_03_02,g_pmdn_d[l_ac1].pmdn002_03_02) THEN
   
                     NEXT FIELD pmdn002_03_02
                  END IF
               ELSE
                  LET g_pmdn_d[l_ac1].pmdn002_03_02 = ' '
               END IF
            END IF
   
            #採購單位檢查 
            IF NOT cl_null(g_pmdn_d[l_ac1].pmdn006_03_02) THEN
               CALL apsp610_03_unit_chk(g_pmdn_d[l_ac1].pmdn006_03_02)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  #160318-00005#41 --s add
                  CASE g_errno
                     WHEN 'sub-01302'
                        LET g_errparam.replace[1] = 'aooi250'
                        LET g_errparam.replace[2] = cl_get_progname('aooi250',g_lang,"2")
                        LET g_errparam.exeprog = 'aooi250'
                  END CASE
                  #160318-00005#41 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
   
                  NEXT FIELD pmdn006_03_02
               END IF
   
               IF NOT cl_null(g_pmdn_d[l_ac1].pmdn007_03_02) THEN
                  CALL apsp610_03_unit_round(g_pmdn_d[l_ac1].pmdn006_03_02,
                                             g_pmdn_d[l_ac1].pmdn007_03_02)
                       RETURNING g_pmdn_d[l_ac1].pmdn007_03_02
               DISPLAY BY NAME g_pmdn_d[l_ac1].pmdn007_03_02
               END IF 
               #參考單位 
               IF cl_get_para(g_enterprise,g_site,'S-BAS-0028') = 'Y' THEN
                  IF cl_null(g_pmdn_d[l_ac1].pmdn008_03_02) THEN
                     LET g_pmdn_d[l_ac1].pmdn008_03_02 = g_pmdn_d[l_ac1].pmdn006_03_02
                     CALL s_desc_get_unit_desc(g_pmdn_d[l_ac1].pmdn008_03_02)
                          RETURNING g_pmdn_d[l_ac1].pmdn008_03_02_desc
                     DISPLAY BY NAME g_pmdn_d[l_ac1].pmdn008_03_02_desc
                  END IF
                  LET g_pmdn_d[l_ac1].pmdn009_03_02 = g_pmdn_d[l_ac1].pmdn007_03_02
                  IF g_pmdn_d[l_ac1].pmdn006_03_02 != g_pmdn_d[l_ac1].pmdn008_03_02 THEN
                     CALL apsp610_03_convert_qty(g_pmdn_d[l_ac1].pmdn001_03_02,g_pmdn_d[l_ac1].pmdn006_03_02,
                                                 g_pmdn_d[l_ac1].pmdn008_03_02,g_pmdn_d[l_ac1].pmdn009_03_02)
                          RETURNING g_pmdn_d[l_ac1].pmdn009_03_02
                  END IF
                  IF NOT cl_null(g_pmdn_d[l_ac1].pmdn009_03_02) THEN
                     CALL apsp610_03_unit_round(g_pmdn_d[l_ac1].pmdn008_03_02,
                                                g_pmdn_d[l_ac1].pmdn009_03_02)
                          RETURNING g_pmdn_d[l_ac1].pmdn009_03_02
                     DISPLAY BY NAME g_pmdn_d[l_ac1].pmdn009_03_02
                  END IF
               END IF

               #計價單位 
               IF cl_get_para(g_enterprise,g_site,'S-BAS-0019') = 'Y' THEN
                  IF cl_null(g_pmdn_d[l_ac1].pmdn010_03_02) THEN
                     LET g_pmdn_d[l_ac1].pmdn010_03_02 = g_pmdn_d[l_ac1].pmdn006_03_02 
                     CALL s_desc_get_unit_desc(g_pmdn_d[l_ac1].pmdn010_03_02)
                          RETURNING g_pmdn_d[l_ac1].pmdn010_03_02_desc
                     DISPLAY BY NAME g_pmdn_d[l_ac1].pmdn010_03_02_desc
                  END IF
                  LET g_pmdn_d[l_ac1].pmdn011_03_02 = g_pmdn_d[l_ac1].pmdn007_03_02
                  IF g_pmdn_d[l_ac1].pmdn006_03_02 != g_pmdn_d[l_ac1].pmdn010_03_02 THEN
                     CALL apsp610_03_convert_qty(g_pmdn_d[l_ac1].pmdn001_03_02,g_pmdn_d[l_ac1].pmdn006_03_02,
                                                 g_pmdn_d[l_ac1].pmdn010_03_02,g_pmdn_d[l_ac1].pmdn011_03_02)
                          RETURNING g_pmdn_d[l_ac1].pmdn011_03_02
                  END IF
                  IF NOT cl_null(g_pmdn_d[l_ac1].pmdn011_03_02) THEN
                     CALL apsp610_03_unit_round(g_pmdn_d[l_ac1].pmdn010_03_02,
                                                g_pmdn_d[l_ac1].pmdn011_03_02)
                          RETURNING g_pmdn_d[l_ac1].pmdn011_03_02
                  END IF
                  DISPLAY BY NAME g_pmdn_d[l_ac1].pmdn011_03_02
               END IF
            END IF

            CALL s_desc_get_unit_desc(g_pmdn_d[l_ac1].pmdn006_03_02)
                 RETURNING g_pmdn_d[l_ac1].pmdn006_03_02_desc
            DISPLAY BY NAME g_pmdn_d[l_ac1].pmdn006_03_02_desc

            #採購數量檢查 
            IF NOT cl_null(g_pmdn_d[l_ac1].pmdn007_03_02) THEN
               IF g_pmdn_d[l_ac1].pmdn007_03_02 <= 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ade-00016'      #不可小於等於0    
                  LET g_errparam.extend = '' 
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
   
                  NEXT FIELD pmdn007_03_02
               END IF

               #檢查數量是否超過需求數量 
               LET l_pmdn007 = 0
               #防欄位被改變，所以要用不會被改變的回串 
               SELECT SUM(pmdn007) INTO l_pmdn007
                 FROM p610_02_pmdn_t
                WHERE pmdl004 = g_pmdl_d[g_d_idx_p61003_01].pmdl004_03_01              #供應商  
                  AND pmdn001 = g_pmdn_d[l_ac1].pmdn001_03_02_key                      #料件編號  
                  AND pmdn002 = g_pmdn_d[l_ac1].pmdn002_03_02_key                      #產品特徵  
                  AND pmdn006 = g_pmdn_d[l_ac1].pmdn006_03_02_key                      #採購單位   
                  AND NVL(pmdn008,' ') = NVL(g_pmdn_d[l_ac1].pmdn008_03_02_key,' ')    #參考單位 
                  AND NVL(pmdn010,' ') = NVL(g_pmdn_d[l_ac1].pmdn010_03_02_key,' ')    #計價單位   
                  AND NVL(pmdn050,' ') = NVL(g_pmdn_d[l_ac1].pmdn050_03_02,' ')        #備註 
                  AND NVL(pmdbdocno,' ') = NVL(g_pmdn_d[l_ac1].pmdbdocno_03_02,' ')    #請購單號 
                  AND NVL(pmdbseq,'0') = NVL(g_pmdn_d[l_ac1].pmdbseq_03_02,'0')        #請購項次 
                  AND NVL(pmdn053,' ') = NVL(g_pmdn_d[l_ac1].pmdn053_03_02,' ')        #庫存管理特徵  #160601-00032#3 20160613 add 
               IF g_pmdn_d[l_ac1].pmdn007_03_02 > l_pmdn007 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'apm-00699'     #數量不可大於未轉採購量！  
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()

                  NEXT FIELD pmdn007_03_02
               END IF 
               CALL apsp610_03_unit_round(g_pmdn_d[l_ac1].pmdn006_03_02,
                                          g_pmdn_d[l_ac1].pmdn007_03_02)
                    RETURNING g_pmdn_d[l_ac1].pmdn007_03_02
               DISPLAY BY NAME g_pmdn_d[l_ac1].pmdn007_03_02

               IF g_d_idx_p61003_01 <=0 THEN
                  LET g_d_idx_p61003_01 = 1
               END IF
               LET l_qty_t = g_pmdn_d[l_ac1].pmdn007_03_02
               LET l_sql = "SELECT pmdpseq1,max_pmdp023 ",
                           "  FROM p610_tmp03 ",       #160727-00019#15 Mod   p610_03_pmdp_rel_t -->p610_tmp03
                           " WHERE pmdl004 = '",g_pmdl_d[g_d_idx_p61003_01].pmdl004_03_01,"' ", 
                           "   AND NVL(pmdl025,' ') = NVL('",g_pmdl_d[g_d_idx_p61003_01].pmdl025_03_01,"',' ') ",
                           "   AND NVL(pmdl026,' ') = NVL('",g_pmdl_d[g_d_idx_p61003_01].pmdl026_03_01,"',' ') ",
                           "   AND pmdpseq = '",g_pmdn_d[l_ac1].pmdnseq_03_02,"' ",
                           " ORDER BY pmdpseq1 "
               PREPARE apsp610_03_reset_pmdp_prep1 FROM l_sql
               DECLARE apsp610_03_reset_pmdp_curs1 CURSOR WITH HOLD FOR apsp610_03_reset_pmdp_prep1
               FOREACH apsp610_03_reset_pmdp_curs1 INTO l_pmdpseq1,l_max_pmdp023
                  LET l_qty_w = 0
                  IF l_qty_t >= l_max_pmdp023 THEN
                     LET l_qty_w = l_max_pmdp023
                     LET l_qty_t = l_qty_t - l_max_pmdp023
                  ELSE
                     LET l_qty_w = l_qty_t
                     LET l_qty_t = 0
                  END IF 
                  UPDATE p610_tmp03 SET pmdp023 = l_qty_w,        #160727-00019#15 Mod   p610_03_pmdp_rel_t -->p610_tmp03
                                                pmdp024 = l_qty_w
                   WHERE pmdl004 = g_pmdl_d[g_d_idx_p61003_01].pmdl004_03_01
                     AND pmdpseq = g_pmdn_d[l_ac1].pmdnseq_03_02
                     AND pmdpseq1 = l_pmdpseq1
               END FOREACH

               IF NOT cl_null(g_pmdn_d[l_ac1].pmdn006_03_02) THEN
                  #參考單位 
                  IF cl_get_para(g_enterprise,g_site,'S-BAS-0028') = 'Y' THEN
                     IF NOT cl_null(g_pmdn_d[l_ac1].pmdn001_03_02) AND
                        NOT cl_null(g_pmdn_d[l_ac1].pmdn006_03_02) AND
                        NOT cl_null(g_pmdn_d[l_ac1].pmdn008_03_02) THEN
                        CALL apsp610_03_convert_qty(g_pmdn_d[l_ac1].pmdn001_03_02,
                                                    g_pmdn_d[l_ac1].pmdn006_03_02,
                                                    g_pmdn_d[l_ac1].pmdn008_03_02,
                                                    g_pmdn_d[l_ac1].pmdn007_03_02)
                             RETURNING g_pmdn_d[l_ac1].pmdn009_03_02
                        IF NOT cl_null(g_pmdn_d[l_ac1].pmdn011_03_02) THEN
                           CALL apsp610_03_unit_round(g_pmdn_d[l_ac1].pmdn008_03_02,
                                                      g_pmdn_d[l_ac1].pmdn009_03_02)
                                RETURNING g_pmdn_d[l_ac1].pmdn009_03_02
                        END IF
                        DISPLAY BY NAME g_pmdn_d[l_ac1].pmdn009_03_02
                     END IF
                  END IF 
                  #計價單位 
                  IF cl_get_para(g_enterprise,g_site,'S-BAS-0019') = 'Y' THEN
                     IF NOT cl_null(g_pmdn_d[l_ac1].pmdn010_03_02) THEN
                        CALL apsp610_03_convert_qty(g_pmdn_d[l_ac1].pmdn001_03_02,
                                                    g_pmdn_d[l_ac1].pmdn006_03_02,
                                                    g_pmdn_d[l_ac1].pmdn010_03_02,
                                                    g_pmdn_d[l_ac1].pmdn007_03_02)
                             RETURNING g_pmdn_d[l_ac1].pmdn011_03_02
                        IF NOT cl_null(g_pmdn_d[l_ac1].pmdn011_03_02) THEN
                           CALL apsp610_03_unit_round(g_pmdn_d[l_ac1].pmdn010_03_02,
                                                      g_pmdn_d[l_ac1].pmdn011_03_02)
                                RETURNING g_pmdn_d[l_ac1].pmdn011_03_02
                        END IF
                        DISPLAY BY NAME g_pmdn_d[l_ac1].pmdn011_03_02
                     END IF
                  END IF
               END IF
            END IF

            #參考單位不可輸入 所以不做檢查   
            #參考數量不可輸入 所以不做檢查 

            #計價單位檢查 
            IF NOT cl_null(g_pmdn_d[l_ac1].pmdn010_03_02) THEN
               CALL apsp610_03_unit_chk(g_pmdn_d[l_ac1].pmdn010_03_02)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = '' 
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD pmdn010_03_02
               END IF

               LET g_pmdn_d[l_ac1].pmdn011_03_02 = g_pmdn_d[l_ac1].pmdn007_03_02
               IF g_pmdn_d[l_ac1].pmdn006_03_02 != g_pmdn_d[l_ac1].pmdn010_03_02 THEN
                  CALL apsp610_03_convert_qty(g_pmdn_d[l_ac1].pmdn001_03_02,g_pmdn_d[l_ac1].pmdn006_03_02,
                                              g_pmdn_d[l_ac1].pmdn010_03_02,g_pmdn_d[l_ac1].pmdn011_03_02)
                       RETURNING g_pmdn_d[l_ac1].pmdn011_03_02
               END IF

               IF NOT cl_null(g_pmdn_d[l_ac1].pmdn011_03_02) THEN
                  CALL apsp610_03_unit_round(g_pmdn_d[l_ac1].pmdn010_03_02,
                                             g_pmdn_d[l_ac1].pmdn011_03_02)
                       RETURNING g_pmdn_d[l_ac1].pmdn011_03_02
                  DISPLAY BY NAME g_pmdn_d[l_ac1].pmdn011_03_02
               END IF
            END IF

            CALL s_desc_get_unit_desc(g_pmdn_d[l_ac1].pmdn010_03_02)
                 RETURNING g_pmdn_d[l_ac1].pmdn010_03_02_desc
            DISPLAY BY NAME g_pmdn_d[l_ac1].pmdn010_03_02_desc

            #計價數量檢查 
            IF NOT cl_null(g_pmdn_d[l_ac1].pmdn011_03_02) THEN
               IF g_pmdn_d[l_ac1].pmdn011_03_02 <= 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.code = 'ade-00016'     #不可小於等於0  
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD pmdn011_03_02
               END IF
   
               IF NOT cl_null(g_pmdn_d[l_ac1].pmdn010_03_02) THEN
                  CALL apsp610_03_unit_round(g_pmdn_d[l_ac1].pmdn010_03_02,
                                             g_pmdn_d[l_ac1].pmdn011_03_02)
                       RETURNING g_pmdn_d[l_ac1].pmdn011_03_02
                  DISPLAY BY NAME g_pmdn_d[l_ac1].pmdn011_03_02
               END IF
            END IF

            #交貨日期檢查 
            IF NOT cl_null(g_pmdn_d[l_ac1].pmdn012_03_02) AND
               (g_pmdn_d[l_ac1].pmdn012_03_02 != g_pmdn_d_o.pmdn012_03_02 OR
                cl_null(g_pmdn_d_o.pmdn012_03_02)) THEN
               LET l_imaf173 = 0       #採購到廠前置時間  
               LET l_imaf174 = 0       #採購入庫前置時間   
               CALL s_apmp490_get_imaf173_imaf174(g_pmdn_d[l_ac1].pmdn001_03_02)
                    RETURNING l_imaf173,l_imaf174

               SELECT ooef008,ooef009 INTO g_ooef008,g_ooef009
                 FROM ooef_t
                WHERE ooefent = g_enterprise
                  AND ooef001 = g_site

               #1.輸入交貨日期後需自動計算到廠日期，公式為交貨日期+[T:料件據點進銷存檔].[C:到廠前置時間]
               #2.輸入交貨日期後需自動計算到庫日期，公式為到廠日期+[T:料件據點進銷存檔].[C:到庫前置時間]
               IF (NOT cl_null(l_imaf173)) AND l_imaf173 <> 0 THEN
                  CALL s_date_get_work_date(g_site,g_ooef008,g_ooef009,g_pmdn_d[l_ac1].pmdn012_03_02,0,l_imaf173)
                       RETURNING g_pmdn_d[l_ac1].pmdn013_03_02
               ELSE
                  LET g_pmdn_d[l_ac1].pmdn013_03_02 = g_pmdn_d[l_ac1].pmdn012_03_02
               END IF

               IF (NOT cl_null(l_imaf174)) AND l_imaf174 <> 0 THEN
                  CALL s_date_get_work_date(g_site,g_ooef008,g_ooef009,g_pmdn_d[l_ac1].pmdn013_03_02,0,l_imaf174)
                       RETURNING g_pmdn_d[l_ac1].pmdn014_03_02
               ELSE
                  LET g_pmdn_d[l_ac1].pmdn014_03_02 = g_pmdn_d[l_ac1].pmdn013_03_02
               END IF 
               
               LET g_pmdn_d_o.pmdn013_03_02 = g_pmdn_d[l_ac1].pmdn013_03_02
               LET g_pmdn_d_o.pmdn014_03_02 = g_pmdn_d[l_ac1].pmdn014_03_02
            END IF

            LET g_pmdn_d_o.pmdn012_03_02 = g_pmdn_d[l_ac1].pmdn012_03_02

            IF NOT cl_null(g_pmdn_d[l_ac1].pmdn013_03_02) AND
               (g_pmdn_d[l_ac1].pmdn013_03_02 != g_pmdn_d_o.pmdn013_03_02 OR cl_null(g_pmdn_d_o.pmdn013_03_02)) THEN
               LET l_imaf173 = 0       #採購到廠前置時間  
               LET l_imaf174 = 0       #採購入庫前置時間   
               CALL s_apmp490_get_imaf173_imaf174(g_pmdn_d[l_ac1].pmdn001_03_02)
                    RETURNING l_imaf173,l_imaf174

               SELECT ooef008,ooef009 INTO g_ooef008,g_ooef009
                 FROM ooef_t
                WHERE ooefent = g_enterprise
                  AND ooef001 = g_site

               IF NOT cl_null(g_pmdn_d[l_ac1].pmdn012_03_02) THEN
                  IF g_pmdn_d[l_ac1].pmdn013_03_02 < g_pmdn_d[l_ac1].pmdn012_03_02 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = g_pmdn_d[l_ac1].pmdn013_03_02
                     LET g_errparam.code   = 'apm-00267'     #到廠日期不可小於交貨日期！  
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()

                     NEXT FIELD pmdn012_03_02
                  END IF
               ELSE
                  #若交貨日期為NULL時，輸入到廠日期後需自動計算交貨日期，公式為到廠日期-[T:料件據點進銷存檔].[C:到廠前置時間] 
                  IF (NOT cl_null(l_imaf173)) AND l_imaf173 <> 0 THEN
                     CALL s_date_get_work_date(g_site,g_ooef008,g_ooef009,g_pmdn_d[l_ac1].pmdn013_03_02,0,(l_imaf173*(-1)))
                          RETURNING g_pmdn_d[l_ac1].pmdn012_03_02
                  ELSE
                     LET g_pmdn_d[l_ac1].pmdn012_03_02 = g_pmdn_d[l_ac1].pmdn013_03_02
                  END IF
               END IF 
               
               #2.輸入到廠日期後需自動計算到庫日期，公式為到廠日期+[T:料件據點進銷存檔].[C:到庫前置時間]
               IF (NOT cl_null(l_imaf174)) AND l_imaf174 <> 0 THEN
                  CALL s_date_get_work_date(g_site,g_ooef008,g_ooef009,g_pmdn_d[l_ac1].pmdn013_03_02,0,l_imaf174)
                       RETURNING g_pmdn_d[l_ac1].pmdn014_03_02
               ELSE
                  LET g_pmdn_d[l_ac1].pmdn014_03_02 = g_pmdn_d[l_ac1].pmdn013_03_02
               END IF

               LET g_pmdn_d_o.pmdn012_03_02 = g_pmdn_d[l_ac1].pmdn012_03_02
               LET g_pmdn_d_o.pmdn014_03_02 = g_pmdn_d[l_ac1].pmdn014_03_02
            END IF

            LET g_pmdn_d_o.pmdn013_03_02 = g_pmdn_d[l_ac1].pmdn013_03_02

            IF NOT cl_null(g_pmdn_d[l_ac1].pmdn014_03_02) AND
               (g_pmdn_d[l_ac1].pmdn014_03_02 != g_pmdn_d_o.pmdn014_03_02 OR cl_null(g_pmdn_d_o.pmdn014_03_02)) THEN
               LET l_imaf173 = 0       #採購到廠前置時間  
               LET l_imaf174 = 0       #採購入庫前置時間     
               CALL s_apmp490_get_imaf173_imaf174(g_pmdn_d[l_ac1].pmdn001_03_02)
                    RETURNING l_imaf173,l_imaf174

               SELECT ooef008,ooef009 INTO g_ooef008,g_ooef009
                 FROM ooef_t
                WHERE ooefent = g_enterprise
                  AND ooef001 = g_site

               IF NOT cl_null(g_pmdn_d[l_ac1].pmdn013_03_02) THEN
                  IF g_pmdn_d[l_ac1].pmdn014_03_02 < g_pmdn_d[l_ac1].pmdn013_03_02 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = g_pmdn_d[l_ac1].pmdn014_03_02
                     LET g_errparam.code   = 'apm-00271'     #到庫日期不可小於到廠日期！  
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()

                     NEXT FIELD pmdn013_03_02
                  END IF
               ELSE
                  #若到廠日期為NULL時，輸入到庫日期後需自動計算到廠日期，公式為到庫日期-[T:料件據點進銷存檔].[C:到庫前置時間]
                  IF (NOT cl_null(l_imaf174)) AND l_imaf174 <> 0 THEN
                     CALL s_date_get_work_date(g_site,g_ooef008,g_ooef009,g_pmdn_d[l_ac1].pmdn014_03_02,0,(l_imaf174*(-1)))
                          RETURNING g_pmdn_d[l_ac1].pmdn013_03_02
                  ELSE
                     LET g_pmdn_d[l_ac].pmdn013_03_02 = g_pmdn_d[l_ac1].pmdn014_03_02
                  END IF
               END IF 
               
               IF NOT cl_null(g_pmdn_d[l_ac1].pmdn012_03_02) THEN
                  IF g_pmdn_d[l_ac1].pmdn014_03_02 < g_pmdn_d[l_ac1].pmdn012_03_02 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = g_pmdn_d[l_ac1].pmdn014_03_02
                     LET g_errparam.code   = 'apm-00272'      #到庫日期不可小於交貨日期  
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()

                     NEXT FIELD pmdn012_03_02
                  END IF
               ELSE
                  #若交貨日期為NULL時，輸入到庫日期後需自動計算交貨日期，公式為到廠日期-[T:料件據點進銷存檔].[C:到廠前置時間]
                  IF (NOT cl_null(l_imaf173)) AND l_imaf173 <> 0 THEN
                     CALL s_date_get_work_date(g_site,g_ooef008,g_ooef009,g_pmdn_d[l_ac1].pmdn013_03_02,0,(l_imaf173*(-1)))
                          RETURNING g_pmdn_d[l_ac1].pmdn012_03_02
                  ELSE
                     LET g_pmdn_d[l_ac1].pmdn012_03_02 = g_pmdn_d[l_ac1].pmdn013_03_02
                  END IF
               END IF

               LET g_pmdn_d_o.pmdn012_03_02 = g_pmdn_d[l_ac1].pmdn012_03_02
               LET g_pmdn_d_o.pmdn013_03_02 = g_pmdn_d[l_ac1].pmdn013_03_02
            END IF

            LET g_pmdn_d_o.pmdn014_03_02 = g_pmdn_d[l_ac1].pmdn014_03_02

            IF cl_null(g_pmdn_d[l_ac1].pmdn012_03_02) THEN
               NEXT FIELD pmdn012_03_02
            END IF
            IF cl_null(g_pmdn_d[l_ac1].pmdn013_03_02) THEN
               NEXT FIELD pmdn013_03_02
            END IF
            IF cl_null(g_pmdn_d[l_ac1].pmdn014_03_02) THEN
               NEXT FIELD pmdn014_03_02
            END IF

            #單價檢查 
            IF NOT cl_null(g_pmdn_d[l_ac1].pmdn015_03_02) THEN
               IF g_pmdn_d[l_ac1].pmdn015_03_02 != g_pmdn_d_o.pmdn015_03_02 OR
                  cl_null(g_pmdn_d_o.pmdn015_03_02) THEN
                  IF g_pmdn_d[l_ac1].pmdn015_03_02 <= 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = '' 
                     LET g_errparam.code   = 'agl-00042'     #單價不可小於0  
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()

                     NEXT FIELD pmdn015_03_02
                  END IF
 
                  #依取價方式設置的單價修改控管方式檢核修改後單價的合理性 
                  LET l_errno = ''
                  #pmdl017：取價方式 
                  #pmdn015：單價 
                  #pmdn043：取出價格 
                  #pmdn040：取價來源 
                  #pmdl015：幣別     
                  #pmdn001：料件編號   
                  #pmdn010：計價單位 
                  IF NOT (cl_null(g_pmdl_d[g_d_idx_p61003_01].pmdl017_03_01) OR cl_null(g_pmdn_d[l_ac1].pmdn015_03_02) OR
                          cl_null(g_pmdn_d[l_ac1].pmdn043_03_02)             OR cl_null(g_pmdn_d[l_ac1].pmdn040_03_02) OR
                          cl_null(g_pmdl_d[g_d_idx_p61003_01].pmdl015_03_01) OR cl_null(g_pmdn_d[l_ac1].pmdn001_03_02) OR
                          cl_null(g_pmdn_d[l_ac1].pmdn010_03_02)) THEN
                          CALL s_purchase_price_check(g_pmdl_d[g_d_idx_p61003_01].pmdl017_03_01,
                                                      g_pmdn_d[l_ac1].pmdn015_03_02,
                                                      g_pmdn_d[l_ac1].pmdn043_03_02,
                                                      g_pmdn_d[l_ac1].pmdn040_03_02,
                                                      g_pmdl_d[g_d_idx_p61003_01].pmdl015_03_01,
                                                      g_pmdn_d[l_ac1].pmdn001_03_02,
                                                      g_pmdn_d[l_ac1].pmdn002_03_02, 
                                                      g_pmdn_d[l_ac1].pmdn010_03_02)
                               RETURNING l_flag,l_errno
                     IF NOT l_flag THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ''
                        LET g_errparam.code   = l_errno
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        NEXT FIELD pmdn015_03_02
                     END IF

                     #呼叫幣別取位應用元件對單價做取位(依單頭幣別做取位基準) 
                     CALL s_curr_round(g_site,g_pmdl_d[g_d_idx_p61003_01].pmdl015_03_01,
                                       g_pmdn_d[l_ac1].pmdn015_03_02,'1')
                          RETURNING g_pmdn_d[l_ac1].pmdn015_03_02

                     #計算價差比  
                     IF g_pmdn_d[l_ac1].pmdn043_03_02 <> 0 AND
                        g_pmdn_d[l_ac1].pmdn043_03_02 <> g_pmdn_d[l_ac1].pmdn015_03_02 THEN
                        LET g_pmdn_d[l_ac1].pmdn044_03_02 = ((g_pmdn_d[l_ac1].pmdn015_03_02 - g_pmdn_d[l_ac1].pmdn043_03_02) /
                                                             g_pmdn_d[l_ac1].pmdn043_03_02) * 100
                     END IF
                  END IF
               END IF
            END IF

            CALL s_apmt500_get_amount(g_apsp610_01_input.pmdldocno,'0', 
                                      g_pmdl_d[g_d_idx_p61003_01].pmdl015_03_01,
                                      g_pmdn_d[l_ac1].pmdn011_03_02,g_pmdn_d[l_ac1].pmdn015_03_02,
                                      g_pmdl_d[g_d_idx_p61003_01].pmdl011_03_01)
                 RETURNING l_pmdn046,l_pmdn048,l_pmdn047

            #因為s_apmt500_get_amount會呼叫稅別元件(s_tax)，其中會產生xrcd的資料，所以要做刪除的動作 
            DELETE FROM xrcd_t WHERE xrcdent = g_enterprise
                                 #AND xrcdld  = l_ooef017   #因為這裡只有單別，應該是不會有其他相同的資料  
                                 AND xrcddocno = g_apsp610_01_input.pmdldocno
                                 AND xrcdseq   = '0'
                                 AND xrcdseq2  = '0'

            UPDATE p610_tmp02 SET pmdn001 = g_pmdn_d[l_ac1].pmdn001_03_02,         #160727-00019#15 Mod   p610_03_pmdn_rel_t -->p610_tmp02
                                  pmdn002 = g_pmdn_d[l_ac1].pmdn002_03_02,
                                  pmdn006 = g_pmdn_d[l_ac1].pmdn006_03_02,
                                  pmdn007 = g_pmdn_d[l_ac1].pmdn007_03_02,
                                  pmdn008 = g_pmdn_d[l_ac1].pmdn008_03_02,
                                  pmdn009 = g_pmdn_d[l_ac1].pmdn009_03_02,
                                  pmdn010 = g_pmdn_d[l_ac1].pmdn010_03_02,
                                  pmdn011 = g_pmdn_d[l_ac1].pmdn011_03_02,
                                  pmdn012 = g_pmdn_d[l_ac1].pmdn012_03_02,
                                  pmdn013 = g_pmdn_d[l_ac1].pmdn013_03_02,
                                  pmdn014 = g_pmdn_d[l_ac1].pmdn014_03_02,
                                  pmdn015 = g_pmdn_d[l_ac1].pmdn015_03_02,
                                  pmdn046 = l_pmdn046,
                                  pmdn047 = l_pmdn047, 
                                  pmdn048 = l_pmdn048
             WHERE pmdl004 = g_pmdl_d[g_d_idx_p61003_01].pmdl004_03_01 
               AND NVL(pmdl025,' ') = NVL(g_pmdl_d[g_d_idx_p61003_01].pmdl025_03_01,' ')
               AND NVL(pmdl026,' ') = NVL(g_pmdl_d[g_d_idx_p61003_01].pmdl026_03_01,' ')
               AND pmdnseq = g_pmdn_d[l_ac1].pmdnseq_03_02

            CALL apsp610_03_gen_pmdq()

            #應該重產pmdo，並b_fill 
            CALL apsp610_03_gen_pmdo()
            LET l_wc = " pmdl004 = '",g_pmdl_d[g_d_idx_p61003_01].pmdl004_03_01,"' ",
                       " AND NVL(pmdl025,' ') = NVL('",g_pmdl_d[g_d_idx_p61003_01].pmdl025_03_01,"',' ') ",
                       " AND NVL(pmdl026,' ') = NVL('",g_pmdl_d[g_d_idx_p61003_01].pmdl026_03_01,"',' ') "
            CALL apsp610_03_b_fill04(l_wc)
         
            EXIT DIALOG 
         
         ON ACTION cancel 
            LET l_wc = " pmdl004 = '",g_pmdl_d[g_d_idx_p61003_01].pmdl004_03_01,"' ",
                       " AND NVL(pmdl025,' ') = NVL('",g_pmdl_d[g_d_idx_p61003_01].pmdl025_03_01,"',' ') ",
                       " AND NVL(pmdl026,' ') = NVL('",g_pmdl_d[g_d_idx_p61003_01].pmdl026_03_01,"',' ') "
            CALL apsp610_03_b_fill02(l_wc)
            CALL apsp610_03_b_fill03(l_wc)
            CALL apsp610_03_b_fill04(l_wc)
            EXIT DIALOG 

      END INPUT
   
   END DIALOG 
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsp610_03_b_fill02(p_wc)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........: 160512-00016#5  2016/06/01 By ming 增加保稅否
################################################################################
PUBLIC FUNCTION apsp610_03_b_fill02(p_wc)
   DEFINE p_wc      STRING
   DEFINE l_sql     STRING
   #DEFINE l_cnt    LIKE type_t.num5    #170104-00066#1 17/01/05 mark by rainy 
   DEFINE l_cnt    LIKE type_t.num10    #170104-00066#1 17/01/05 add by rainy 
   DEFINE l_success LIKE type_t.num5 
   
   WHENEVER ERROR CONTINUE 

   CALL g_pmdn_d.CLEAR()

   #160601-00032#3 20160613 modify by ming -----(S) 
   ##160512-00016#5 20160601 modify by ming -----(S) 
   ##LET l_sql = "SELECT pmdnseq,pmdn001,'','',pmdn002,'',pmdn006,'',pmdn007,pmdn008,'',pmdn009, ",
   ##            "       pmdn010,'',pmdn011,pmdn012,pmdn013,pmdn014,pmdn015,pmdn043,pmdn044,pmdn040, ",
   ##            "       pmdn058,'', ",
   ##            "       pmdn036,(SELECT pjbal003 FROM pjbal_t ",
   ##            "                 WHERE pjbalent = '",g_enterprise,"' ",
   ##            "                   AND pjbal001 = pmdn036 ",
   ##            "                   AND pjbal002 = '",g_dlang,"'), ",
   ##            "       pmdn037,(SELECT pjbbl004 FROM pjbbl_t ",
   ##            "                 WHERE pjbblent = '",g_enterprise,"' ",
   ##            "                   AND pjbbl001 = pmdn036 ",
   ##            "                   AND pjbbl002 = pmdn037 ",
   ##            "                   AND pjbbl003 = '",g_dlang,"'), ",
   ##            "       pmdn038,(SELECT pjbml004 FROM pjbml_t ",
   ##            "                 WHERE pjbmlent = '",g_enterprise,"' ",
   ##            "                   AND pjbml001 = pmdn036 ",
   ##            "                   AND pjbml002 = pmdn038 ",
   ##            "                   AND pjbml003 = '",g_dlang,"'), ",
   ##            "       pmdn050,pmdbdocno,pmdbseq,pmdl004,'','','','','' ",
   ##            "  FROM p610_03_pmdn_rel_t ",
   ##            " WHERE ",p_wc,
   ##            " ORDER BY pmdnseq " 
   #LET l_sql = "SELECT pmdnseq,pmdn001,'','',pmdn002,'',pmdn021,pmdn006,'',pmdn007,pmdn008,'',pmdn009, ",
   #            "       pmdn010,'',pmdn011,pmdn012,pmdn013,pmdn014,pmdn015,pmdn043,pmdn044,pmdn040, ",
   #            "       pmdn058,'', ",
   #            "       pmdn036,(SELECT pjbal003 FROM pjbal_t ",
   #            "                 WHERE pjbalent = '",g_enterprise,"' ",
   #            "                   AND pjbal001 = pmdn036 ",
   #            "                   AND pjbal002 = '",g_dlang,"'), ",
   #            "       pmdn037,(SELECT pjbbl004 FROM pjbbl_t ",
   #            "                 WHERE pjbblent = '",g_enterprise,"' ",
   #            "                   AND pjbbl001 = pmdn036 ",
   #            "                   AND pjbbl002 = pmdn037 ",
   #            "                   AND pjbbl003 = '",g_dlang,"'), ",
   #            "       pmdn038,(SELECT pjbml004 FROM pjbml_t ",
   #            "                 WHERE pjbmlent = '",g_enterprise,"' ",
   #            "                   AND pjbml001 = pmdn036 ",
   #            "                   AND pjbml002 = pmdn038 ",
   #            "                   AND pjbml003 = '",g_dlang,"'), ",
   #            "       pmdn050,pmdbdocno,pmdbseq,pmdl004,'','','','','' ",
   #            "  FROM p610_03_pmdn_rel_t ",
   #            " WHERE ",p_wc,
   #            " ORDER BY pmdnseq " 
   ##160512-00016#5 20160601 modify by ming -----(E) 
   LET l_sql = "SELECT pmdnseq,pmdn001,'','',pmdn002,'',pmdn021,pmdn006,'',pmdn007,pmdn008,'',pmdn009, ",
               "       pmdn010,'',pmdn011,pmdn012,pmdn013,pmdn014,pmdn015,pmdn043,pmdn044,pmdn040, ",
               "       pmdn058,'', ",
               "       pmdn036,(SELECT pjbal003 FROM pjbal_t ",
               "                 WHERE pjbalent = '",g_enterprise,"' ",
               "                   AND pjbal001 = pmdn036 ",
               "                   AND pjbal002 = '",g_dlang,"'), ",
               "       pmdn037,(SELECT pjbbl004 FROM pjbbl_t ",
               "                 WHERE pjbblent = '",g_enterprise,"' ",
               "                   AND pjbbl001 = pmdn036 ",
               "                   AND pjbbl002 = pmdn037 ",
               "                   AND pjbbl003 = '",g_dlang,"'), ",
               "       pmdn038,(SELECT pjbml004 FROM pjbml_t ",
               "                 WHERE pjbmlent = '",g_enterprise,"' ",
               "                   AND pjbml001 = pmdn036 ",
               "                   AND pjbml002 = pmdn038 ",
               "                   AND pjbml003 = '",g_dlang,"'), ",
               "       pmdn050,pmdbdocno,pmdbseq,pmdn053,pmdl004,'','','','','' ",
               "  FROM p610_tmp02 ",          #160727-00019#15 Mod   p610_03_pmdn_rel_t -->p610_tmp02
               " WHERE ",p_wc,
               " ORDER BY pmdnseq " 
   #160601-00032#3 20160613 modify by ming -----(E) 

   PREPARE apsp610_03_b_fill02_prep FROM l_sql
   DECLARE apsp610_03_b_fill02_curs CURSOR FOR apsp610_03_b_fill02_prep

   LET l_cnt = 1
   #FOREACH apsp610_03_b_fill02_curs INTO g_pmdn_d[l_cnt].* #161109-00085#61 mark
   #161109-00085#61 --s add
   FOREACH apsp610_03_b_fill02_curs INTO g_pmdn_d[l_cnt].pmdnseq_03_02,g_pmdn_d[l_cnt].pmdn001_03_02,g_pmdn_d[l_cnt].imaal003_03_02,g_pmdn_d[l_cnt].imaal004_03_02,g_pmdn_d[l_cnt].pmdn002_03_02,
                                         g_pmdn_d[l_cnt].pmdn002_03_02_desc,g_pmdn_d[l_cnt].pmdn021_03_02,g_pmdn_d[l_cnt].pmdn006_03_02,g_pmdn_d[l_cnt].pmdn006_03_02_desc,g_pmdn_d[l_cnt].pmdn007_03_02,      
                                         g_pmdn_d[l_cnt].pmdn008_03_02,g_pmdn_d[l_cnt].pmdn008_03_02_desc,g_pmdn_d[l_cnt].pmdn009_03_02,g_pmdn_d[l_cnt].pmdn010_03_02,g_pmdn_d[l_cnt].pmdn010_03_02_desc, 
                                         g_pmdn_d[l_cnt].pmdn011_03_02,g_pmdn_d[l_cnt].pmdn012_03_02,g_pmdn_d[l_cnt].pmdn013_03_02,g_pmdn_d[l_cnt].pmdn014_03_02,g_pmdn_d[l_cnt].pmdn015_03_02,      
                                         g_pmdn_d[l_cnt].pmdn043_03_02,g_pmdn_d[l_cnt].pmdn044_03_02,g_pmdn_d[l_cnt].pmdn040_03_02,g_pmdn_d[l_cnt].pmdn058_03_02,g_pmdn_d[l_cnt].pmdn058_03_02_desc, 
                                         g_pmdn_d[l_cnt].pmdn036_03_02,g_pmdn_d[l_cnt].pmdn036_03_02_desc,g_pmdn_d[l_cnt].pmdn037_03_02,g_pmdn_d[l_cnt].pmdn037_03_02_desc,g_pmdn_d[l_cnt].pmdn038_03_02,      
                                         g_pmdn_d[l_cnt].pmdn038_03_02_desc,g_pmdn_d[l_cnt].pmdn050_03_02,g_pmdn_d[l_cnt].pmdbdocno_03_02,g_pmdn_d[l_cnt].pmdbseq_03_02,g_pmdn_d[l_cnt].pmdn053_03_02,     
                                         g_pmdn_d[l_cnt].pmdl004_03_02,g_pmdn_d[l_cnt].pmdn001_03_02_key,g_pmdn_d[l_cnt].pmdn002_03_02_key,g_pmdn_d[l_cnt].pmdn006_03_02_key,g_pmdn_d[l_cnt].pmdn008_03_02_key,
                                         g_pmdn_d[l_cnt].pmdn010_03_02_key
   #161109-00085#61 --e add
      IF STATUS THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = STATUS
         LET g_errparam.extend = 'foreach'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      #LET g_pmdn_d[l_cnt].pmdnseq_03_02 = l_cnt 
      
      #回串資料的key值 
      LET g_pmdn_d[l_cnt].pmdn001_03_02_key = g_pmdn_d[l_cnt].pmdn001_03_02
      LET g_pmdn_d[l_cnt].pmdn002_03_02_key = g_pmdn_d[l_cnt].pmdn002_03_02
      LET g_pmdn_d[l_cnt].pmdn006_03_02_key = g_pmdn_d[l_cnt].pmdn006_03_02
      LET g_pmdn_d[l_cnt].pmdn008_03_02_key = g_pmdn_d[l_cnt].pmdn008_03_02
      LET g_pmdn_d[l_cnt].pmdn010_03_02_key = g_pmdn_d[l_cnt].pmdn010_03_02 

      SELECT imaal003,imaal004 INTO g_pmdn_d[l_cnt].imaal003_03_02,
                                    g_pmdn_d[l_cnt].imaal004_03_02
        FROM imaal_t
       WHERE imaalent = g_enterprise
         AND imaal001 = g_pmdn_d[l_cnt].pmdn001_03_02 
         AND imaal002 = g_dlang 
         
      #取得產品特徵說明 
      CALL s_feature_description(g_pmdn_d[l_cnt].pmdn001_03_02,g_pmdn_d[l_cnt].pmdn002_03_02)
           RETURNING l_success,g_pmdn_d[l_cnt].pmdn002_03_02_desc 
           
      #取得單位說明 
      CALL s_desc_get_unit_desc(g_pmdn_d[l_cnt].pmdn006_03_02)
           RETURNING g_pmdn_d[l_cnt].pmdn006_03_02_desc

      CALL s_desc_get_unit_desc(g_pmdn_d[l_cnt].pmdn008_03_02)
           RETURNING g_pmdn_d[l_cnt].pmdn008_03_02_desc

      CALL s_desc_get_unit_desc(g_pmdn_d[l_cnt].pmdn010_03_02)
           RETURNING g_pmdn_d[l_cnt].pmdn010_03_02_desc

      LET l_cnt = l_cnt + 1
   END FOREACH

   CALL g_pmdn_d.deleteElement(l_cnt)
   LET l_cnt = l_cnt - 1
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsp610_03_input04()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_03_input04()
  #DEFINE l_ac1     LIKE type_t.num5     #170104-00066#1 17/01/05 mark by rainy 
   DEFINE l_ac1     LIKE type_t.num10     #170104-00066#1 17/01/05 add by rainy 
   DEFINE l_cnt     LIKE type_t.num5 
   
   WHENEVER ERROR CONTINUE 

   INPUT ARRAY g_pmdp_d FROM s_apsp610_03_detail3.*
         ATTRIBUTE(COUNT = g_d_cnt_p61003_03,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                   INSERT ROW = FALSE,
                   DELETE ROW = FALSE,
                   APPEND ROW = FALSE)
      BEFORE INPUT

      BEFORE ROW
         LET g_d_idx_p61003_03 = DIALOG.getCurrentRow("s_apsp610_03_detail3")

         LET g_appoint_idx = g_d_idx_p61003_03

         LET l_ac1 = ARR_CURR()
         LET g_pmdp_d_t.* = g_pmdp_d[l_ac1].* 
      AFTER FIELD pmdp021_03_03
         IF NOT cl_null(g_pmdp_d[l_ac1].pmdp021_03_03) THEN
            IF g_pmdp_d[l_ac1].pmdp021_03_03 <= 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'ade-00016'   #不可小於等於0  
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
     
               NEXT FIELD CURRENT
            END IF

            IF g_pmdp_d[l_ac1].pmdp021_03_03 != g_pmdp_d_t.pmdp021_03_03 OR g_pmdp_d_t.pmdp021_03_03 IS NULL THEN
               #檢查 同一單據中 同一採購項次的順序不可重覆 
               LET l_cnt = 0
               SELECT COUNT(*) INTO l_cnt
                 FROM p610_tmp03           #160727-00019#15 Mod   p610_03_pmdp_rel_t -->p610_tmp03
                WHERE pmdl004 = g_pmdp_d[l_ac1].pmdl004_03_03   #供應商  
                  AND pmdp021 = g_pmdp_d[l_ac1].pmdp021_03_03   #採購料件編號  
                  AND pmdp001 = g_pmdp_d[l_ac1].pmdp001_03_03   #產品特徵  
                  AND pmdp022 = g_pmdp_d[l_ac1].pmdp022_03_03   #計價單位  
                  AND pmdpseq = g_pmdp_d[l_ac1].pmdpseq_03_03   #是相同項次的話，指向的pmdn010也是一樣的 

               IF l_cnt > 0 THEN
                  INITIALIZE g_errparam TO NULL
                  #相同的採購料號+採購產品特徵+採購單位+計價單位的沖銷順序不可重複！  
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'sub-00333' 
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
   
                  NEXT FIELD CURRENT
               END IF
            END IF

         END IF 
      ON ROW CHANGE
         UPDATE p610_tmp03 SET pmdp021 = g_pmdp_d[l_ac1].pmdp021_03_03           #160727-00019#15 Mod   p610_03_pmdp_rel_t -->p610_tmp03
          WHERE pmdl004  = g_pmdl_d[g_d_idx_p61003_01].pmdl004_03_01 
            AND NVL(pmdl025,' ') = NVL(g_pmdl_d[g_d_idx_p61003_01].pmdl025_03_01,' ')
            AND NVL(pmdl026,' ') = NVL(g_pmdl_d[g_d_idx_p61003_01].pmdl026_03_01,' ')
            AND pmdpseq  = g_pmdp_d[l_ac1].pmdpseq_03_03
            AND pmdpseq1 = g_pmdp_d[l_ac1].pmdpseq1_03_03

   END INPUT
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsp610_03_b_fill03(p_wc)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_03_b_fill03(p_wc)
   DEFINE p_wc      STRING
   DEFINE l_sql     STRING
   #DEFINE l_cnt    LIKE type_t.num5    #170104-00066#1 17/01/05 mark by rainy 
   DEFINE l_cnt    LIKE type_t.num10    #170104-00066#1 17/01/05 add by rainy 
   DEFINE l_success LIKE type_t.num5 
   
   WHENEVER ERROR CONTINUE 

   CALL g_pmdp_d.clear()

   LET l_sql = "SELECT pmdpseq,pmdpseq1,pmdp001,'','',pspc004,pmdp004,pmdp007,'','',pmdp008,'',",
               "       pmdp021,pmdp022,pmdp023,pmdp024,pspc045,pmdb033,pmdl004 ",
               "  FROM p610_tmp03 ",            #160727-00019#15 Mod   p610_03_pmdp_rel_t -->p610_tmp03
               " WHERE ",p_wc,
               " ORDER BY pmdpseq,pmdpseq1 "

   PREPARE apsp610_03_b_fill03_prep FROM l_sql
   DECLARE apsp610_03_b_fill03_curs CURSOR FOR apsp610_03_b_fill03_prep

   LET l_cnt = 1
   #FOREACH apsp610_03_b_fill03_curs INTO g_pmdp_d[l_cnt].* #161109-00085#61 mark
   #161109-00085#61 --s add
   FOREACH apsp610_03_b_fill03_curs INTO g_pmdp_d[l_cnt].pmdpseq_03_03,g_pmdp_d[l_cnt].pmdpseq1_03_03,g_pmdp_d[l_cnt].pmdp001_03_03,g_pmdp_d[l_cnt].imaal003_03_03_1,g_pmdp_d[l_cnt].imaal004_03_03_1,  
                                         g_pmdp_d[l_cnt].pspc004_03_03,g_pmdp_d[l_cnt].pmdp004_03_03,g_pmdp_d[l_cnt].pmdp007_03_03,g_pmdp_d[l_cnt].imaal003_03_03_2,g_pmdp_d[l_cnt].imaal004_03_03_2,  
                                         g_pmdp_d[l_cnt].pmdp008_03_03,g_pmdp_d[l_cnt].pmdp008_03_03_desc,g_pmdp_d[l_cnt].pmdp021_03_03,g_pmdp_d[l_cnt].pmdp022_03_03,g_pmdp_d[l_cnt].pmdp023_03_03,     
                                         g_pmdp_d[l_cnt].pmdp024_03_03,g_pmdp_d[l_cnt].pspc045_03_03,g_pmdp_d[l_cnt].pmdb033_03_03,g_pmdp_d[l_cnt].pmdl004_03_03
   #161109-00085#61 --e add
      IF STATUS THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.code   = STATUS
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      SELECT imaal003,imaal004 INTO g_pmdp_d[l_cnt].imaal003_03_03_1,
                                    g_pmdp_d[l_cnt].imaal004_03_03_1
        FROM imaal_t
       WHERE imaalent = g_enterprise
         AND imaal001 = g_pmdp_d[l_cnt].pmdp001_03_03
         AND imaal002 = g_dlang 
      SELECT imaal003,imaal004 INTO g_pmdp_d[l_cnt].imaal003_03_03_2,
                                    g_pmdp_d[l_cnt].imaal004_03_03_2
        FROM imaal_t
       WHERE imaalent = g_enterprise
         AND imaal001 = g_pmdp_d[l_cnt].pmdp007_03_03
         AND imaal002 = g_dlang 
      
      #取得產品特徵說明 
      CALL s_feature_description(g_pmdp_d[l_cnt].pmdp007_03_03,g_pmdp_d[l_cnt].pmdp008_03_03)
           RETURNING l_success,g_pmdp_d[l_cnt].pmdp008_03_03_desc

      LET l_cnt = l_cnt + 1
   END FOREACH

   CALL g_pmdp_d.deleteElement(l_cnt)
   LET l_cnt = l_cnt - 1
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsp610_03_b_fill04(p_wc)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_03_b_fill04(p_wc)
   DEFINE p_wc      STRING
   DEFINE l_sql     STRING
   #DEFINE l_cnt    LIKE type_t.num5    #170104-00066#1 17/01/05 mark by rainy 
   DEFINE l_cnt    LIKE type_t.num10    #170104-00066#1 17/01/05 add by rainy 
   DEFINE l_success LIKE type_t.num5 
   
   WHENEVER ERROR CONTINUE 

   CALL g_pmdo_d.clear()

   LET l_sql = "SELECT pmdoseq,pmdoseq1,pmdo001,'','',pmdo002,'',pmdo004,pmdo005,",
               "       pmdoseq2,pmdo006,pmdo009,pmdo011,pmdo012,pmdo013 ",
               "  FROM p610_03_pmdo_t ",
               " WHERE ",p_wc,
               " ORDER BY pmdoseq,pmdoseq1,pmdoseq2 "
   PREPARE apsp610_03_b_fill04_prep FROM l_sql
   DECLARE apsp610_03_b_fill04_curs CURSOR FOR apsp610_03_b_fill04_prep

   LET l_cnt = 1
   #FOREACH apsp610_03_b_fill04_curs INTO g_pmdo_d[l_cnt].* #161109-00085#61 mark
   #161109-00085#61 --s add
   FOREACH apsp610_03_b_fill04_curs INTO g_pmdo_d[l_cnt].pmdoseq_03_04,g_pmdo_d[l_cnt].pmdoseq1_03_04,g_pmdo_d[l_cnt].pmdo001_03_04,g_pmdo_d[l_cnt].imaal003_03_04,g_pmdo_d[l_cnt].imaal004_03_04,
                                         g_pmdo_d[l_cnt].pmdo002_03_04,g_pmdo_d[l_cnt].pmdo002_03_04_desc,g_pmdo_d[l_cnt].pmdo004_03_04,g_pmdo_d[l_cnt].pmdo005_03_04,g_pmdo_d[l_cnt].pmdoseq2_03_04,    
                                         g_pmdo_d[l_cnt].pmdo006_03_04,g_pmdo_d[l_cnt].pmdo009_03_04,g_pmdo_d[l_cnt].pmdo011_03_04,g_pmdo_d[l_cnt].pmdo012_03_04,g_pmdo_d[l_cnt].pmdo013_03_04     
   #161109-00085#61 --e add
      IF STATUS THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = STATUS
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      SELECT imaal003,imaal004 INTO g_pmdo_d[l_cnt].imaal003_03_04,
                                    g_pmdo_d[l_cnt].imaal004_03_04
        FROM imaal_t
       WHERE imaalent = g_enterprise
         AND imaal001 = g_pmdo_d[l_cnt].pmdo001_03_04
         AND imaal002 = g_dlang 
      
      #取得產品特徵說明 
      CALL s_feature_description(g_pmdo_d[l_cnt].pmdo001_03_04,g_pmdo_d[l_cnt].pmdo002_03_04)
           RETURNING l_success,g_pmdo_d[l_cnt].pmdo002_03_04_desc      
      
      LET l_cnt = l_cnt + 1
   END FOREACH

   CALL g_pmdo_d.deleteElement(l_cnt)
   LET l_cnt = l_cnt - 1
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsp610_03_ins_pmdl(p_pmdldocno)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........: 
################################################################################
PUBLIC FUNCTION apsp610_03_ins_pmdl(p_pmdldocno)
   DEFINE p_pmdldocno  LIKE pmdl_t.pmdldocno
   DEFINE l_sql        STRING
   DEFINE l_pmdl_tmp   type_g_pmdl_d
   #mod--161109-00085#14 By 08993--(s)
#   DEFINE l_pmdl       RECORD LIKE  pmdl_t.*   #mark--161109-00085#14 By 08993--(s)
   DEFINE l_pmdl RECORD  #採購單頭檔
          pmdlent LIKE pmdl_t.pmdlent, #企業編號
          pmdlsite LIKE pmdl_t.pmdlsite, #營運據點
          pmdlunit LIKE pmdl_t.pmdlunit, #應用組織
          pmdldocno LIKE pmdl_t.pmdldocno, #採購單號
          pmdldocdt LIKE pmdl_t.pmdldocdt, #採購日期
          pmdl001 LIKE pmdl_t.pmdl001, #版次
          pmdl002 LIKE pmdl_t.pmdl002, #採購人員
          pmdl003 LIKE pmdl_t.pmdl003, #採購部門
          pmdl004 LIKE pmdl_t.pmdl004, #供應商編號
          pmdl005 LIKE pmdl_t.pmdl005, #採購性質
          pmdl006 LIKE pmdl_t.pmdl006, #多角性質
          pmdl007 LIKE pmdl_t.pmdl007, #資料來源類型
          pmdl008 LIKE pmdl_t.pmdl008, #來源單號
          pmdl009 LIKE pmdl_t.pmdl009, #付款條件
          pmdl010 LIKE pmdl_t.pmdl010, #交易條件
          pmdl011 LIKE pmdl_t.pmdl011, #稅別
          pmdl012 LIKE pmdl_t.pmdl012, #稅率
          pmdl013 LIKE pmdl_t.pmdl013, #單價含稅否
          pmdl015 LIKE pmdl_t.pmdl015, #幣別
          pmdl016 LIKE pmdl_t.pmdl016, #匯率
          pmdl017 LIKE pmdl_t.pmdl017, #取價方式
          pmdl018 LIKE pmdl_t.pmdl018, #付款優惠條件
          pmdl019 LIKE pmdl_t.pmdl019, #納入APS計算
          pmdl020 LIKE pmdl_t.pmdl020, #運送方式
          pmdl021 LIKE pmdl_t.pmdl021, #付款供應商
          pmdl022 LIKE pmdl_t.pmdl022, #送貨供應商
          pmdl023 LIKE pmdl_t.pmdl023, #採購分類一
          pmdl024 LIKE pmdl_t.pmdl024, #採購分類二
          pmdl025 LIKE pmdl_t.pmdl025, #送貨地址
          pmdl026 LIKE pmdl_t.pmdl026, #帳款地址
          pmdl027 LIKE pmdl_t.pmdl027, #供應商連絡人
          pmdl028 LIKE pmdl_t.pmdl028, #一次性交易對象識別碼
          pmdl029 LIKE pmdl_t.pmdl029, #收貨部門
          pmdl030 LIKE pmdl_t.pmdl030, #多角貿易已拋轉
          pmdl031 LIKE pmdl_t.pmdl031, #多角序號
          pmdl032 LIKE pmdl_t.pmdl032, #最終客戶
          pmdl033 LIKE pmdl_t.pmdl033, #發票類型
          pmdl040 LIKE pmdl_t.pmdl040, #採購總未稅金額
          pmdl041 LIKE pmdl_t.pmdl041, #採購總含稅金額
          pmdl042 LIKE pmdl_t.pmdl042, #採購總稅額
          pmdl043 LIKE pmdl_t.pmdl043, #留置原因
          pmdl044 LIKE pmdl_t.pmdl044, #備註
          pmdl046 LIKE pmdl_t.pmdl046, #預付款發票開立方式
          pmdl047 LIKE pmdl_t.pmdl047, #物流結案
          pmdl048 LIKE pmdl_t.pmdl048, #帳流結案
          pmdl049 LIKE pmdl_t.pmdl049, #金流結案
          pmdl050 LIKE pmdl_t.pmdl050, #多角最終站否
          pmdl051 LIKE pmdl_t.pmdl051, #多角流程編號
          pmdl052 LIKE pmdl_t.pmdl052, #最終供應商
          pmdl053 LIKE pmdl_t.pmdl053, #兩角目的據點
          pmdl054 LIKE pmdl_t.pmdl054, #內外購
          pmdl055 LIKE pmdl_t.pmdl055, #匯率計算基準
          pmdl200 LIKE pmdl_t.pmdl200, #採購中心
          pmdl201 LIKE pmdl_t.pmdl201, #聯絡電話
          pmdl202 LIKE pmdl_t.pmdl202, #傳真號碼
          pmdl203 LIKE pmdl_t.pmdl203, #採購方式
          pmdl204 LIKE pmdl_t.pmdl204, #配送中心
          pmdl900 LIKE pmdl_t.pmdl900, #保留欄位str
          pmdl999 LIKE pmdl_t.pmdl999, #保留欄位end
          pmdlownid LIKE pmdl_t.pmdlownid, #資料所有者
          pmdlowndp LIKE pmdl_t.pmdlowndp, #資料所屬部門
          pmdlcrtid LIKE pmdl_t.pmdlcrtid, #資料建立者
          pmdlcrtdp LIKE pmdl_t.pmdlcrtdp, #資料建立部門
          pmdlcrtdt LIKE pmdl_t.pmdlcrtdt, #資料創建日
          pmdlmodid LIKE pmdl_t.pmdlmodid, #資料修改者
          pmdlmoddt LIKE pmdl_t.pmdlmoddt, #最近修改日
          pmdlcnfid LIKE pmdl_t.pmdlcnfid, #資料確認者
          pmdlcnfdt LIKE pmdl_t.pmdlcnfdt, #資料確認日
          pmdlpstid LIKE pmdl_t.pmdlpstid, #資料過帳者
          pmdlpstdt LIKE pmdl_t.pmdlpstdt, #資料過帳日
          pmdlstus LIKE pmdl_t.pmdlstus, #狀態碼
          #161109-00085#61 --s add
          pmdlud001 LIKE pmdl_t.pmdlud001, #自定義欄位(文字)001
          pmdlud002 LIKE pmdl_t.pmdlud002, #自定義欄位(文字)002
          pmdlud003 LIKE pmdl_t.pmdlud003, #自定義欄位(文字)003
          pmdlud004 LIKE pmdl_t.pmdlud004, #自定義欄位(文字)004
          pmdlud005 LIKE pmdl_t.pmdlud005, #自定義欄位(文字)005
          pmdlud006 LIKE pmdl_t.pmdlud006, #自定義欄位(文字)006
          pmdlud007 LIKE pmdl_t.pmdlud007, #自定義欄位(文字)007
          pmdlud008 LIKE pmdl_t.pmdlud008, #自定義欄位(文字)008
          pmdlud009 LIKE pmdl_t.pmdlud009, #自定義欄位(文字)009
          pmdlud010 LIKE pmdl_t.pmdlud010, #自定義欄位(文字)010
          pmdlud011 LIKE pmdl_t.pmdlud011, #自定義欄位(數字)011
          pmdlud012 LIKE pmdl_t.pmdlud012, #自定義欄位(數字)012
          pmdlud013 LIKE pmdl_t.pmdlud013, #自定義欄位(數字)013
          pmdlud014 LIKE pmdl_t.pmdlud014, #自定義欄位(數字)014
          pmdlud015 LIKE pmdl_t.pmdlud015, #自定義欄位(數字)015
          pmdlud016 LIKE pmdl_t.pmdlud016, #自定義欄位(數字)016
          pmdlud017 LIKE pmdl_t.pmdlud017, #自定義欄位(數字)017
          pmdlud018 LIKE pmdl_t.pmdlud018, #自定義欄位(數字)018
          pmdlud019 LIKE pmdl_t.pmdlud019, #自定義欄位(數字)019
          pmdlud020 LIKE pmdl_t.pmdlud020, #自定義欄位(數字)020
          pmdlud021 LIKE pmdl_t.pmdlud021, #自定義欄位(日期時間)021
          pmdlud022 LIKE pmdl_t.pmdlud022, #自定義欄位(日期時間)022
          pmdlud023 LIKE pmdl_t.pmdlud023, #自定義欄位(日期時間)023
          pmdlud024 LIKE pmdl_t.pmdlud024, #自定義欄位(日期時間)024
          pmdlud025 LIKE pmdl_t.pmdlud025, #自定義欄位(日期時間)025
          pmdlud026 LIKE pmdl_t.pmdlud026, #自定義欄位(日期時間)026
          pmdlud027 LIKE pmdl_t.pmdlud027, #自定義欄位(日期時間)027
          pmdlud028 LIKE pmdl_t.pmdlud028, #自定義欄位(日期時間)028
          pmdlud029 LIKE pmdl_t.pmdlud029, #自定義欄位(日期時間)029
          pmdlud030 LIKE pmdl_t.pmdlud030, #自定義欄位(日期時間)030
          #161109-00085#61 --e add
          pmdl205 LIKE pmdl_t.pmdl205, #採購最終有效日
          pmdl206 LIKE pmdl_t.pmdl206, #長效期訂單否
          pmdl207 LIKE pmdl_t.pmdl207, #所屬品類
          pmdl208 LIKE pmdl_t.pmdl208  #電子採購單號
   END RECORD
   #mod--161109-00085#14 By 08993--(e)  
   DEFINE l_desc       LIKE type_t.chr80
   DEFINE l_ooef019    LIKE ooef_t.ooef019
   DEFINE l_oofa001    LIKE oofa_t.oofa001
   DEFINE l_pmaa004    LIKE pmaa_t.pmaa004
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_keyno      LIKE type_t.num10
   DEFINE l_errno      LIKE type_t.chr10          #錯誤訊息代碼 
   DEFINE l_ooef016    LIKE ooef_t.ooef016
   DEFINE l_pmal002    LIKE pmal_t.pmal002        #控制組編號  
   DEFINE l_pmdlcrtdt  LIKE pmdl_t.pmdlcrtdt  
   DEFINE l_pmdl028    LIKE pmdl_t.pmdl028        #一次性交易識別碼 
   DEFINE l_str        STRING  
   DEFINE l_pmdl040    LIKE pmdl_t.pmdl040        #採購總未稅金額  
   DEFINE l_pmdl041    LIKE pmdl_t.pmdl041        #採購總含稅金額  
   DEFINE l_pmdl042    LIKE pmdl_t.pmdl042        #採購總稅額  
   DEFINE l_pmdbdocno  LIKE pmdb_t.pmdbdocno
   DEFINE l_pmdbseq    LIKE pmdb_t.pmdbseq
   DEFINE l_t500_qty   LIKE pmdp_t.pmdp024
   DEFINE l_pmdb006    LIKE pmdb_t.pmdb006
   DEFINE l_pmdb049    LIKE pmdb_t.pmdb049
   DEFINE l_pmdndocno  LIKE pmdn_t.pmdndocno
   DEFINE l_pmdnseq    LIKE pmdn_t.pmdnseq
   DEFINE l_pmdn001    LIKE pmdn_t.pmdn001
   DEFINE l_msg1         LIKE gzze_t.gzze003   #160621-00003#3 20160629 add by beckxie

   WHENEVER ERROR CONTINUE 

   LET g_result_str = ''

   LET l_oofa001 = ''                             #聯絡對象識別碼  
   SELECT oofa001 INTO l_oofa001
     FROM oofa_t
    WHERE oofaent = g_enterprise
      AND oofa002 = '1'
      AND oofa003 = g_site 
   #160621-00003#3 20160629 add by beckxie---S
   SELECT gzze003 INTO l_msg1 FROM gzze_t WHERE gzze001 = 'aoo-00309' 
      AND gzze002 = g_dlang     
   #160621-00003#3 20160629 add by beckxie---E
   #獲得當前營運據點的所屬稅區
   LET l_ooef019 = ''
   SELECT ooef019 INTO l_ooef019
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
   
   LET l_sql = "SELECT pmdl004,'',pmdl009,'',pmdl010,'',pmdl011,'', ",
               "       pmdl012,pmdl013,pmdl015,'',pmdl016,pmdl017,'', ",
               "       pmdl023,pmdl054,pmdl033,pmdl055, ", 
               "       pmdl025,'','',pmdl026,'','',  ",
               "       pmal002 ",
               "  FROM p610_03_pmdl_t "
   PREPARE apsp610_03_ins_pmdl_prep FROM l_sql
   DECLARE apsp610_03_ins_pmdl_curs CURSOR WITH HOLD FOR apsp610_03_ins_pmdl_prep

   INITIALIZE l_pmdl_tmp.* TO NULL
   INITIALIZE l_pmdl.* TO NULL

   #訊息收集 
   CALL cl_err_collect_init()

   LET l_keyno = 1
   LET l_pmal002 = '' 
   #FOREACH apsp610_03_ins_pmdl_curs INTO l_pmdl_tmp.*,l_pmal002 #161109-00085#61 mark
   #161109-00085#61 --s add
   FOREACH apsp610_03_ins_pmdl_curs INTO l_pmdl_tmp.pmdl004_03_01,l_pmdl_tmp.pmaal004_03_01,l_pmdl_tmp.pmdl009_03_01,l_pmdl_tmp.ooibl004_03_01,l_pmdl_tmp.pmdl010_03_01,
                                         l_pmdl_tmp.oocql004_03_01,l_pmdl_tmp.pmdl011_03_01,l_pmdl_tmp.pmdl011_03_01_desc,l_pmdl_tmp.pmdl012_03_01,l_pmdl_tmp.pmdl013_03_01,         
                                         l_pmdl_tmp.pmdl015_03_01,l_pmdl_tmp.ooail003_03_01,l_pmdl_tmp.pmdl016_03_01,l_pmdl_tmp.pmdl017_03_01,l_pmdl_tmp.pmaml003_03_01,        
                                         l_pmdl_tmp.pmdl023_03_01,l_pmdl_tmp.pmdl054_03_01,l_pmdl_tmp.pmdl033_03_01,l_pmdl_tmp.pmdl055_03_01,l_pmdl_tmp.pmdl025_03_01,         
                                         l_pmdl_tmp.pmdl025_03_01_desc,l_pmdl_tmp.pmdl025_03_01_oofb017,l_pmdl_tmp.pmdl026_03_01,l_pmdl_tmp.pmdl026_03_01_desc,l_pmdl_tmp.pmdl026_03_01_oofb017, 
                                         l_pmal002
   #161109-00085#61 --e add
      IF STATUS THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.code   = STATUS
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      CALL s_transaction_begin()
      LET g_success = 'Y'
      LET g_result_str = ''

      #畫面的欄位檢查  
      IF cl_null(l_pmdl_tmp.pmdl009_03_01) THEN
         LET l_errno = 'apm-00530'          #付款條件不可為空   
         LET g_result_str = g_result_str,",",cl_getmsg(l_errno,g_lang)
         LET g_success = 'N'
      END IF
      IF cl_null(l_pmdl_tmp.pmdl010_03_01) THEN
         LET l_errno = 'apm-00531'          #交易條件不可為空 
         LET g_result_str = g_result_str,",",cl_getmsg(l_errno,g_lang)
         LET g_success = 'N'
      END IF
      IF cl_null(l_pmdl_tmp.pmdl011_03_01) THEN
         LET l_errno = 'amm-00211'          #稅別欄位不可為空！ 
         LET g_result_str = g_result_str,",",cl_getmsg(l_errno,g_lang)
         LET g_success = 'N'
      END IF 
      IF cl_null(l_pmdl_tmp.pmdl015_03_01) THEN
         LET l_errno = 'amm-00164'          #幣別不可為空！ 
         LET g_result_str = g_result_str,",",cl_getmsg(l_errno,g_lang)
         LET g_success = 'N'
      END IF
      IF cl_null(l_pmdl_tmp.pmdl017_03_01) THEN
         LET l_errno = 'asf-00226'          #取價方式不可為空! 
         LET g_result_str = g_result_str,",",cl_getmsg(l_errno,g_lang)
         LET g_success = 'N'
      END IF 
      #160621-00003#3 20160728 mark by beckxie---S
      #IF cl_null(l_pmdl_tmp.pmdl023_03_01) THEN
      #   LET l_errno = 'apm-00574'           #採購通路不可為空! 
      #   LET g_result_str = g_result_str,",",cl_getmsg(l_errno,g_lang)
      #   LET g_success = 'N'
      #END IF
      #160621-00003#3 20160728 mark by beckxie---E
      IF cl_null(l_pmdl_tmp.pmdl054_03_01) THEN
         LET l_errno = 'apm-00575'           #內外購不可為空! 
         LET g_result_str = g_result_str,",",cl_getmsg(l_errno,g_lang)
         LET g_success = 'N'
      END IF
      IF cl_null(l_pmdl_tmp.pmdl033_03_01) THEN
         LET l_errno = 'apm-00576'           #發票類型不可為空! 
         LET g_result_str = g_result_str,",",cl_getmsg(l_errno,g_lang)
         LET g_success = 'N'
      END IF
      IF cl_null(l_pmdl_tmp.pmdl055_03_01) THEN
         LET l_errno = 'apm-00577'           #匯率計算基礎不可為空! 
         LET g_result_str = g_result_str,",",cl_getmsg(l_errno,g_lang)
         LET g_success = 'N'
      END IF

      #公用欄位給值 
      LET l_pmdl.pmdlownid = g_user
      LET l_pmdl.pmdlowndp = g_grup
      LET l_pmdl.pmdlcrtid = g_user
      LET l_pmdl.pmdlcrtdp = g_grup
      LET l_pmdl.pmdlcrtdt = cl_get_current()
      LET l_pmdl.pmdlmodid = ''
      LET l_pmdl.pmdlmoddt = ''

      #一般欄位給值  
      LET l_pmdl.pmdl001 = "0"
      LET l_pmdl.pmdlstus = "N"
      LET l_pmdl.pmdl005 = "1"
      LET l_pmdl.pmdl006 = "1"
#      LET l_pmdl.pmdl007 = "1"
      LET l_pmdl.pmdl013 = "N"
      LET l_pmdl.pmdl019 = "Y"
      LET l_pmdl.pmdl030 = "N"
      LET l_pmdl.pmdl040 = "0" 
      LET l_pmdl.pmdl041 = "0"
      LET l_pmdl.pmdl042 = "0"
      LET l_pmdl.pmdl047 = "N"
      LET l_pmdl.pmdl048 = "N"
      LET l_pmdl.pmdl049 = "N"
      LET l_pmdl.pmdl046 = "1"

      LET l_pmdl.pmdlsite  = g_site
      LET l_pmdl.pmdldocdt = g_today   #採購人員 
      LET l_pmdl.pmdl002   = g_user
      LET l_pmdl.pmdl003   = g_dept    #採購部門

      LET l_pmdl.pmdldocno = p_pmdldocno
      #取得欄位預設值
      CALL apsp610_03_get_col_default(l_pmdl.*) RETURNING l_pmdl.* 
      
      #after field pmdl002    #採購人員   
      #如果第一步有勾選的話，就會產生此採購人員的單據 
      IF g_apsp610_01_input.cb01 = 'Y' THEN
         LET l_pmdl.pmdl002 = g_apsp610_01_input.imaf142
      END IF
      IF NOT cl_null(l_pmdl.pmdl002) THEN
         CALL apsp610_03_chk_ooag(l_pmdl.pmdl002)
         IF NOT cl_null(g_errno) THEN
            LET l_errno = g_errno
            LET g_result_str = g_result_str,",",cl_getmsg(l_errno,g_lang)
            LET g_success = 'N'
         ELSE
            #如果檢查成功後 則依人員帶出部門編號  
            SELECT ooag003 INTO l_pmdl.pmdl003
              FROM ooag_t
             WHERE ooagent = g_enterprise
               AND ooag001 = l_pmdl.pmdl002
         END IF
      END IF

      #after field pmdl004    #供應商編號   
      LET l_pmdl.pmdl004 = l_pmdl_tmp.pmdl004_03_01
      IF NOT cl_null(l_pmdl.pmdl004) THEN 
      
         #防user在產生資料前把供應商取消確認 
         IF NOT apsp610_03_pmdl004_chk(l_pmdl.pmdl004) THEN
            LET l_errno = g_errno
            LET g_result_str = g_result_str,",",cl_getmsg(l_errno,g_lang)
            LET g_success = 'N'
         END IF
         
         #如果供應商有修改 根據供應商帶值  
         CALL apsp610_03_pmdl004_def(l_pmdl.*) RETURNING l_pmdl.* 
        
      END IF

      #after field pmdl003     #採購部門  
      IF NOT cl_null(l_pmdl.pmdl003) THEN
         CALL apsp610_03_pmdl003_chk(l_pmdl.pmdl003,l_pmdl.pmdldocdt)
         IF NOT cl_null(g_errno) THEN
            LET l_errno = g_errno
            LET g_result_str = g_result_str,",",cl_getmsg(l_errno,g_lang)
            LET g_success = 'N'
         END IF
      END IF

      #來源一定是請購單  
      LET l_pmdl.pmdl007 = '5'

      #after field pmdl008         #來源單號  
      #因為此作業為匯總作業 所以不寫來源單號 

      #after field pmdl027         #供應商連絡人  
      IF NOT cl_null(l_pmdl.pmdl027) THEN
         CALL apsp610_03_pmdl027_chk(l_pmdl.pmdl004,l_pmdl.pmdl027)
         IF NOT cl_null(g_errno) THEN
            LET l_errno = g_errno
            LET g_result_str = g_result_str,",",cl_getmsg(l_errno,g_lang)
            LET g_success = 'N'
         END IF
      END IF 
      #after field pmdl009         #付款條件   
      LET l_pmdl.pmdl009 = l_pmdl_tmp.pmdl009_03_01
      IF NOT cl_null(l_pmdl.pmdl009) THEN
         CALL apsp610_03_pmdl009_chk(l_pmdl.pmdl004,l_pmdl.pmdl009)
         IF NOT cl_null(g_errno) THEN
            LET l_errno = g_errno
            LET g_result_str = g_result_str,",",cl_getmsg(l_errno,g_lang)
            LET g_success = 'N'
         END IF
      END IF

      #after field pmdl010              #交易條件  
      LET l_pmdl.pmdl010 = l_pmdl_tmp.pmdl010_03_01
      IF NOT cl_null(l_pmdl.pmdl010) THEN
         LET l_errno = ''
         CALL s_apmp490_oocq_chk('238',l_pmdl.pmdl010) RETURNING l_errno
         IF NOT cl_null(l_errno) THEN   
            #160321-00016#41 s983961--mod(s)
            #LET l_str = s_apmp490_get_gzaal_desc('238'),"|",l_pmdl.pmdl010
            #LET g_result_str = g_result_str,",",cl_getmsg_parm(l_errno,g_lang,l_str)
            #LET g_success = 'N'
            IF l_errno = 'apm-01037' THEN 
               LET l_str = s_apmp490_get_gzaal_desc('238'),"|",l_pmdl.pmdl010
               LET g_result_str = g_result_str,",",cl_getmsg_parm(l_errno,g_lang,l_str)
               LET g_success = 'N'
            ELSE 
               LET l_str = 'apmi012',"|",cl_get_progname('apmi012',g_lang,"2")
               LET g_result_str = g_result_str,",",cl_getmsg_parm(l_errno,g_lang,l_str)
               LET g_success = 'N'    
            END IF               
            #160321-00016#41 s983961--mod(e)
         END IF
      END IF

      #after field pmdl011               #稅別  
      LET l_pmdl.pmdl011 = l_pmdl_tmp.pmdl011_03_01
      IF NOT cl_null(l_pmdl.pmdl011) THEN
         CALL apsp610_03_pmdl011_chk(l_pmdl.pmdl011)
         IF NOT cl_null(g_errno) THEN
            LET l_errno = g_errno
            LET g_result_str = g_result_str,",",cl_getmsg(l_errno,g_lang)
            LET g_success = 'N' 
         ELSE
            SELECT oodb006,oodb005 INTO l_pmdl.pmdl012,l_pmdl.pmdl013
              FROM oodb_t,ooef_t
             WHERE ooefent = oodbent
               AND ooef001 = g_site
               AND ooef019 = oodb001
               AND oodbent = g_enterprise
               AND oodb002 = l_pmdl.pmdl011
         END IF
      END IF

      #after field pmdl033          #發票類型  
      LET l_pmdl.pmdl033 = l_pmdl_tmp.pmdl033_03_01
      IF NOT cl_null(l_pmdl.pmdl033) THEN
         CALL apsp610_03_pmdl033_chk(l_ooef019,l_pmdl.pmdl033)
         IF NOT cl_null(g_errno) THEN
            LET l_errno = g_errno
            LET g_result_str = g_result_str,",",cl_getmsg(l_errno,g_lang)
            LET g_success = 'N'
         END IF
      END IF

      #after field pmdl015     #幣別   
      LET l_pmdl.pmdl015 = l_pmdl_tmp.pmdl015_03_01
      IF NOT cl_null(l_pmdl.pmdl015) THEN
         CALL apsp610_03_pmdl015_chk(l_pmdl.pmdl015)

         IF NOT cl_null(g_errno) THEN
            LET l_errno = g_errno
            LET g_result_str = g_result_str,",",cl_getmsg(l_errno,g_lang)
            LET g_success = 'N' 
         ELSE
            #取得匯率 
            SELECT ooef016 INTO l_ooef016
              FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_site
            CALL s_apmp490_get_exrate(l_pmdl.pmdl015,l_ooef016,l_pmdl_tmp.pmdl054_03_01)
                 RETURNING l_pmdl.pmdl016
         END IF
      END IF

      #after field pmdl017          #取價方式   
      LET l_pmdl.pmdl017 = l_pmdl_tmp.pmdl017_03_01
      IF NOT cl_null(l_pmdl.pmdl017) THEN
         CALL apsp610_03_pmdl017_chk(l_pmdl.pmdl017)
         IF NOT cl_null(g_errno) THEN
            LET l_errno = g_errno
            LET g_result_str = g_result_str,",",cl_getmsg(l_errno,g_lang)
            LET g_success = 'N'
         END IF
      END IF

      #after field pmdl018         #付款優惠條件    
      IF NOT cl_null(l_pmdl.pmdl018) THEN
         CALL apsp610_03_pmdl018_chk(l_pmdl.pmdl018)
         IF NOT cl_null(g_errno) THEN
            LET l_errno = g_errno
            LET g_result_str = g_result_str,",",cl_getmsg(l_errno,g_lang)
            LET g_success = 'N'
         END IF 
      END IF

      #after field pmdl043             #留置原因    
      #不考慮留置原因 

      #after field pmdl020            #運送方式    
      IF NOT cl_null(l_pmdl.pmdl020) THEN
         CALL apsp610_03_pmdl020_chk(l_pmdl.pmdl020)

         IF NOT cl_null(g_errno) THEN
            LET l_errno = g_errno
            LET g_result_str = g_result_str,",",cl_getmsg(l_errno,g_lang)
            LET g_success = 'N'
         END IF
      END IF
      IF NOT cl_null(l_pmdl_tmp.pmdl025_03_01) THEN 
         LET l_pmdl.pmdl025 = l_pmdl_tmp.pmdl025_03_01
      END IF 
      #after field pmdl025     #送貨地址   
      IF NOT cl_null(l_pmdl.pmdl025) THEN
         CALL apsp610_03_pmdl025_chk(l_oofa001,l_pmdl.pmdl025)
         IF NOT cl_null(g_errno) THEN
            LET l_errno = g_errno
            LET g_result_str = g_result_str,",",cl_getmsg(l_errno,g_lang)
            LET g_success = 'N'
         END IF
      END IF 
      
      IF NOT cl_null(l_pmdl_tmp.pmdl026_03_01) THEN 
         LET l_pmdl.pmdl026 = l_pmdl_tmp.pmdl026_03_01
      END IF 
      #after field pmdl026     #帳款地址   
      IF NOT cl_null(l_pmdl.pmdl026) THEN
         CALL apsp610_03_pmdl026_chk(l_oofa001,l_pmdl.pmdl026)
         IF NOT cl_null(g_errno) THEN
            LET l_errno = g_errno
            LET g_result_str = g_result_str,",",cl_getmsg(l_errno,g_lang)
            LET g_success = 'N'
         END IF
      END IF

      #after field pmdl029       #收貨部門  
      IF NOT cl_null(l_pmdl.pmdl029) THEN
         CALL apsp610_03_pmdl003_chk(l_pmdl.pmdl029,l_pmdl.pmdldocdt)
         IF NOT cl_null(g_errno) THEN
            LET l_errno = g_errno
            LET g_result_str = g_result_str,",",cl_getmsg(l_errno,g_lang)
            LET g_success = 'N'
         END IF
      END IF

      #預設付款供應商與送貨供應商會與採購單供應商相同 
      #after field pmdl021        #付款供應商   
      LET l_pmdl.pmdl021 = l_pmdl.pmdl004

      #after field pmdl022        #送貨供應商  
      LET l_pmdl.pmdl022 = l_pmdl.pmdl004
      #after field pmdl032        #最終客戶   
      IF NOT cl_null(l_pmdl.pmdl032) THEN
         CALL apsp610_03_pmdl032_chk(l_pmdl.pmdl032)
         IF NOT cl_null(g_errno) THEN
            LET l_errno = g_errno
            LET g_result_str = g_result_str,",",cl_getmsg(l_errno,g_lang)
            LET g_success = 'N'
         END IF
      END IF

      #after field pmdl023         #採購分類一   
      IF NOT cl_null(l_pmdl_tmp.pmdl023_03_01) THEN 
         LET l_pmdl.pmdl023 = l_pmdl_tmp.pmdl023_03_01
      END IF 
      IF NOT cl_null(l_pmdl.pmdl023) THEN
         #160621-00003#3 20160627 mark by beckxie---S
         #CALL s_apmp490_oocq_chk('275',l_pmdl.pmdl023) RETURNING l_errno  
         #IF NOT cl_null(l_errno) THEN
         #   #160321-00016#41 s983961--mod(s)
         #   #LET l_str = s_apmp490_get_gzaal_desc('275'),"|",l_pmdl.pmdl023
         #   #LET g_result_str = g_result_str,",",cl_getmsg_parm(l_errno,g_lang,l_str)
         #   #LET g_success = 'N'
         #   IF l_errno = 'apm-01037' THEN 
         #      LET l_str = s_apmp490_get_gzaal_desc('275'),"|",l_pmdl.pmdl023
         #      LET g_result_str = g_result_str,",",cl_getmsg_parm(l_errno,g_lang,l_str)
         #      LET g_success = 'N'
         #   ELSE 
         #      LET l_str = 'apmi012',"|",cl_get_progname('apmi012',g_lang,"2")
         #      LET g_result_str = g_result_str,",",cl_getmsg_parm(l_errno,g_lang,l_str)
         #      LET g_success = 'N'    
         #   END IF               
         #   #160321-00016#41 s983961--mod(e)
         #END IF
         #160621-00003#3 20160627 mark by beckxie---E
         #160621-00003#3 20160627 add by beckxie---S
         INITIALIZE g_chkparam.* TO NULL
         LET g_chkparam.arg1 = l_pmdl.pmdl023
         LET g_chkparam.arg2 = '2'
         LET g_chkparam.err_str[1] = "aoo-00299|",l_msg1
         IF NOT cl_chk_exist("v_oojd001") THEN
            LET g_success = 'N'
         END IF
         #160621-00003#3 20160627 add by beckxie---E
      END IF

      #after field pmdl024         #採購分類二   
      IF NOT cl_null(l_pmdl.pmdl024) THEN
         CALL s_apmp490_oocq_chk('264',l_pmdl.pmdl024) RETURNING l_errno
         IF NOT cl_null(l_errno) THEN
            #160321-00016#41 s983961--mod(s)  
            #LET l_str = s_apmp490_get_gzaal_desc('264'),"|",l_pmdl.pmdl024
            #LET g_result_str = g_result_str,",",cl_getmsg_parm(l_errno,g_lang,l_str)
            #LET g_success = 'N'
            IF l_errno = 'apm-01037' THEN 
               LET l_str = s_apmp490_get_gzaal_desc('264'),"|",l_pmdl.pmdl024
               LET g_result_str = g_result_str,",",cl_getmsg_parm(l_errno,g_lang,l_str)
               LET g_success = 'N'
            ELSE 
               LET l_str = 'apmi012',"|",cl_get_progname('apmi012',g_lang,"2")
               LET g_result_str = g_result_str,",",cl_getmsg_parm(l_errno,g_lang,l_str)
               LET g_success = 'N'    
            END IF               
            #160321-00016#41 s983961--mod(e)
         END IF
      END IF 
      
      LET l_pmdl.pmdl054 = l_pmdl_tmp.pmdl054_03_01
      LET l_pmdl.pmdl055 = l_pmdl_tmp.pmdl055_03_01
      
      CALL s_aooi200_gen_docno(g_site,l_pmdl.pmdldocno,l_pmdl.pmdldocdt,'apmt500') 
           RETURNING l_success,l_pmdl.pmdldocno
      IF NOT l_success THEN
         LET g_success = 'N'
         LET l_errno = 'apm-00003'
         LET g_result_str = g_result_str,",",cl_getmsg(l_errno,g_lang)
      END IF

      IF g_success = 'Y' THEN
         LET l_pmdlcrtdt = cl_get_current() 
         INSERT INTO pmdl_t(pmdlent  ,pmdlsite ,pmdldocno,pmdldocdt,pmdl001  ,pmdl002,
                            pmdl003  ,pmdl004  ,pmdl005  ,pmdl006  ,pmdl007  ,pmdl008,
                            pmdl009  ,pmdl010  ,pmdl011  ,pmdl012  ,pmdl013  ,pmdl015,
                            pmdl016  ,pmdl017  ,pmdl018  ,pmdl019  ,pmdl020  ,pmdl021,
                            pmdl022  ,pmdl023  ,pmdl024  ,pmdl025  ,pmdl026  ,pmdl027,
                            pmdl028  ,pmdl029  ,pmdl030  ,pmdl031  ,pmdl032  ,pmdl033,
                            pmdl040  ,pmdl041  ,pmdl042  ,pmdl043  ,pmdl044  ,pmdl046,
                            pmdl047  ,pmdl048  ,pmdl049  ,pmdl050  ,pmdl051  ,pmdl052,
                            pmdl053  ,pmdl054  ,pmdl055  ,pmdlownid,pmdlowndp,pmdlcrtid,
                            pmdlcrtdp,pmdlcrtdt,pmdlmodid,pmdlmoddt,pmdlcnfid,pmdlcnfdt,
                            pmdlpstid,pmdlpstdt,pmdlstus)
                     VALUES(g_enterprise  ,g_site        ,l_pmdl.pmdldocno,l_pmdl.pmdldocdt,
                            l_pmdl.pmdl001,l_pmdl.pmdl002,l_pmdl.pmdl003  ,l_pmdl.pmdl004  ,
                            l_pmdl.pmdl005,l_pmdl.pmdl006,l_pmdl.pmdl007  ,l_pmdl.pmdl008  ,
                            l_pmdl.pmdl009,l_pmdl.pmdl010,l_pmdl.pmdl011  ,l_pmdl.pmdl012  ,
                            l_pmdl.pmdl013,l_pmdl.pmdl015,l_pmdl.pmdl016  ,l_pmdl.pmdl017  ,
                            l_pmdl.pmdl018,l_pmdl.pmdl019,l_pmdl.pmdl020  ,l_pmdl.pmdl021  ,
                            l_pmdl.pmdl022,l_pmdl.pmdl023,l_pmdl.pmdl024  ,l_pmdl.pmdl025  ,
                            l_pmdl.pmdl026,l_pmdl.pmdl027,l_pmdl.pmdl028  ,l_pmdl.pmdl029  ,
                            l_pmdl.pmdl030,l_pmdl.pmdl031,l_pmdl.pmdl032  ,l_pmdl.pmdl033  ,
                            l_pmdl.pmdl040,l_pmdl.pmdl041,l_pmdl.pmdl042  ,l_pmdl.pmdl043  ,
                            l_pmdl.pmdl044,l_pmdl.pmdl046,l_pmdl.pmdl047  ,l_pmdl.pmdl048  , 
                            l_pmdl.pmdl049,l_pmdl.pmdl050,l_pmdl.pmdl051  ,l_pmdl.pmdl052  ,
                            l_pmdl.pmdl053,l_pmdl.pmdl054,l_pmdl.pmdl055  ,g_user          ,
                            g_dept        ,g_user        ,g_dept          ,l_pmdlcrtdt     ,
                            '','','','','','','N')
      END IF

      #因為不論是否有產生成功 都要有單身資料可以看 要跑兩次  
      CALL apsp610_03_ins_pmdn(l_keyno,l_pmdl_tmp.pmdl004_03_01,
                               l_pmdl_tmp.pmdl025_03_01,
                               l_pmdl_tmp.pmdl026_03_01,
                               l_pmdl.pmdldocno,l_pmal002)
      CALL apsp610_03_ins_pmdp(l_keyno,l_pmdl_tmp.pmdl004_03_01,
                               l_pmdl_tmp.pmdl025_03_01,
                               l_pmdl_tmp.pmdl026_03_01,
                               l_pmdl.pmdldocno)
      CALL apsp610_03_ins_pmdq(l_keyno,l_pmdl_tmp.pmdl004_03_01,
                               l_pmdl_tmp.pmdl025_03_01,
                               l_pmdl_tmp.pmdl026_03_01,
                               l_pmdl.pmdldocno)
      CALL apsp610_03_ins_pmdo(l_keyno,l_pmdl_tmp.pmdl004_03_01,
                               l_pmdl_tmp.pmdl025_03_01,
                               l_pmdl_tmp.pmdl026_03_01,
                               l_pmdl.pmdldocno)
      #檢查剛才產生的單據資料是否正確，如果不正確的話就不產生此採購單 
      LET l_sql = "SELECT pmdp003,pmdp004 ",
                  "  FROM pmdp_t ",
                  " WHERE pmdpent   = '",g_enterprise,"' ",
                  "   AND pmdpdocno = '",l_pmdl.pmdldocno,"' ",
                  " GROUP BY pmdp003,pmdp004 ",
                  " ORDER BY pmdp003,pmdp004 "
      PREPARE apsp610_03_get_t500_qty_prep FROM l_sql
      DECLARE apsp610_03_get_t500_qty_curs CURSOR FOR apsp610_03_get_t500_qty_prep

      FOREACH apsp610_03_get_t500_qty_curs INTO l_pmdbdocno,l_pmdbseq

         LET l_t500_qty = ''
         SELECT SUM(pmdp024) INTO l_t500_qty
           FROM pmdp_t
          WHERE pmdpent = g_enterprise
            AND pmdp003 = l_pmdbdocno
            AND pmdp004 = l_pmdbseq
            
         IF cl_null(l_t500_qty) THEN 
            LET l_t500_qty = 0 
         END IF 

         LET l_pmdb006 = ''
         LET l_pmdb049 = ''
         SELECT pmdb006,pmdb049 INTO l_pmdb006,l_pmdb049
           FROM pmdb_t
          WHERE pmdbent   = g_enterprise
            AND pmdbdocno = l_pmdbdocno 
            AND pmdbseq   = l_pmdbseq

         IF cl_null(l_pmdb006) THEN 
            LET l_pmdb006 = 0 
         END IF 
         IF cl_null(l_pmdb049) THEN 
            LET l_pmdb049 = 0 
         END IF 

         IF l_pmdb006 - l_pmdb049 != l_pmdb006 - l_t500_qty THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = ''
            LET g_errparam.code   = 'apm-01038'     
            #請購單號：%1，項次：%2，更新的已轉採購量與採購數量不符，請檢查！  
            LET g_errparam.popup  = TRUE
            LET g_errparam.replace[1] = l_pmdbdocno
            LET g_errparam.replace[2] = l_pmdbseq

            CALL cl_err()
            LET g_success = 'N'
         END IF
      END FOREACH
      
      #檢查多交期的數量是否符合採購數量 
      #如果不符合則報錯 
      LET l_sql = "SELECT pmdndocno,pmdnseq,pmdn001 ",
                  "  FROM pmdn_t ",
                  " WHERE pmdnent   = '",g_enterprise,"' ",
                  "   AND pmdndocno = '",l_pmdl.pmdldocno,"' ",
                  "   AND pmdn007 <> (SELECT SUM(NVL(pmdo006,0)) ",
                  "                     FROM pmdo_t ",
                  "                    WHERE pmdoent = pmdnent ",
                  "                      AND pmdodocno = pmdndocno ",
                  "                      AND pmdoseq   = pmdnseq) "
      PREPARE apsp610_03_chk_multi_date_prep FROM l_sql
      DECLARE apsp610_03_chk_multi_date_curs CURSOR FOR apsp610_03_chk_multi_date_prep

      FOREACH apsp610_03_chk_multi_date_curs INTO l_pmdndocno,l_pmdnseq,l_pmdn001
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend     = 'chk pmdo_t_prep'
         LET g_errparam.code       = 'apm-01050'     #第%1筆採購單的採購數量與多交期數量不符，請檢查！  
         LET g_errparam.popup      = TRUE
         LET g_errparam.replace[1] = l_keyno
         CALL cl_err()

         LET g_success = 'N'
      END FOREACH

      IF g_success = 'Y' THEN 
         #更新回寫單頭的採購總未稅金額、採購總含稅金額、總稅額 
         LET l_pmdl040 = 0
         LET l_pmdl041 = 0
         LET l_pmdl042 = 0
         SELECT SUM(pmdn046),SUM(pmdn047),SUM(pmdn048)
           INTO l_pmdl040,l_pmdl041,l_pmdl042
           FROM pmdn_t
          WHERE pmdnent   = g_enterprise
            AND pmdnsite  = g_site
            AND pmdndocno = l_pmdl.pmdldocno
         IF cl_null(l_pmdl040) THEN LET l_pmdl040 = 0 END IF
         IF cl_null(l_pmdl041) THEN LET l_pmdl041 = 0 END IF
         IF cl_null(l_pmdl042) THEN LET l_pmdl042 = 0 END IF
         UPDATE pmdl_t SET pmdl040 = l_pmdl040,
                           pmdl041 = l_pmdl041,
                           pmdl042 = l_pmdl042
          WHERE pmdlent   = g_enterprise
            AND pmdlsite  = g_site
            AND pmdldocno = l_pmdl.pmdldocno
            
         CALL s_transaction_end('Y','0')
         LET g_result_str = cl_getmsg('apm-00538',g_lang)        #建立成功   
         
         #因為apmi004_01會破壞transaction，所以要移到最後再用update的 
         #若輸入供應商的法人類型為'2:一次性交易'或是'4:內部員工'時，則自動串apmi004_01
         #維護一次性交易對項基本資料，維護完基本資料後會回傳一個一次性交易對象識別碼，
         #將識別碼值預設給pmdl028欄位
         LET l_pmaa004 = ''
         SELECT pmaa004 INTO l_pmaa004
           FROM pmaa_t
          WHERE pmaaent = g_enterprise
            AND pmaa001 = l_pmdl.pmdl004
         LET l_pmdl028 = ''
         IF l_pmaa004 = '2' THEN   #一次性交易對象
            CALL apmi004_01('1','',l_pmdl.pmdl004,l_pmdl.pmdldocno) RETURNING l_pmdl028
         END IF
         IF l_pmaa004 = '4' THEN   #內部員工
            CALL apmi004_01('2','',l_pmdl.pmdl004,l_pmdl.pmdldocno) RETURNING l_pmdl028
         END IF

         UPDATE pmdl_t SET pmdl028 = l_pmdl028
          WHERE pmdlent   = g_enterprise
            AND pmdlsite  = g_site
            AND pmdldocno = l_pmdl.pmdldocno
         
      ELSE
         CALL s_transaction_end('N','0')
         #因為執行失敗 所以不給予單號 
         LET l_pmdl.pmdldocno = '' 
         LET l_str = g_result_str
         LET g_result_str = l_str.subString(3,l_str.getLength())
      END IF

      #不論如何都應該寫入temp table 然後顯示結果是成功或錯誤 
      INSERT INTO p610_04_pmdl_t VALUES(l_keyno,l_pmdl.pmdldocno,l_pmdl.pmdl004,l_pmdl.pmdl009,
                                        l_pmdl.pmdl010,l_pmdl.pmdl011,l_pmdl.pmdl012,
                                        l_pmdl.pmdl013,l_pmdl.pmdl015,l_pmdl.pmdl016,
                                        l_pmdl.pmdl017,g_result_str)
      CALL apsp610_03_pmdn_b_fill(l_keyno,l_pmdl_tmp.pmdl004_03_01,
                                  l_pmdl_tmp.pmdl025_03_01,
                                  l_pmdl_tmp.pmdl026_03_01,
                                  l_pmdl.pmdldocno)
      CALL apsp610_03_pmdp_b_fill(l_keyno,l_pmdl_tmp.pmdl004_03_01,
                                  l_pmdl_tmp.pmdl025_03_01,
                                  l_pmdl_tmp.pmdl026_03_01,
                                  l_pmdl.pmdldocno)
      CALL apsp610_03_pmdo_b_fill(l_keyno,l_pmdl_tmp.pmdl004_03_01,
                                  l_pmdl_tmp.pmdl025_03_01,
                                  l_pmdl_tmp.pmdl026_03_01,
                                  l_pmdl.pmdldocno)
      LET l_keyno = l_keyno + 1

   END FOREACH 
   
   CALL cl_err_collect_show()
 
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsp610_03_get_oofb019(p_site)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_03_get_oofb019(p_site)
   DEFINE p_site     LIKE ooef_t.ooef001
   DEFINE l_oofa001  LIKE oofa_t.oofa001
   DEFINE r_oofb019  LIKE oofb_t.oofb019
   DEFINE r_oofb011  LIKE oofb_t.oofb011 
   
   WHENEVER ERROR CONTINUE 

   LET r_oofb019 = ''
   LET r_oofb011 = ''

   #獲取當前營運據點的聯絡對象識別碼
   LET l_oofa001 = ''
   SELECT oofa001 INTO l_oofa001
     FROM oofa_t
    WHERE oofaent = g_enterprise
      AND oofa002 = '1'
      AND oofa003 = p_site

   IF NOT cl_null(l_oofa001) THEN
      #主要出貨地址
         SELECT oofb019,oofb011 INTO r_oofb019,r_oofb011
           FROM oofb_t
          WHERE oofbent = g_enterprise
            AND oofb002 = l_oofa001
            AND oofb002 = '3'
            AND oofb010 = 'Y'
         #若沒有勾選主要的
         IF cl_null(r_oofb019) THEN
            SELECT oofb019,oofb011 INTO r_oofb019,r_oofb011
              FROM oofb_t
             WHERE oofbent = g_enterprise 
               AND oofb002 = l_oofa001
               AND oofb002 = '3'
               AND rownum = 1
         END IF
         #呼叫地址組合應用元件 
   END IF
   RETURN r_oofb019,r_oofb011
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsp610_03_get_col_default(p_pmdl)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_03_get_col_default(p_pmdl)

   #mod--161109-00085#14 By 08993--(s)
#   DEFINE p_pmdl       RECORD LIKE  pmdl_t.*   #mark--161109-00085#14 By 08993--(s)
   DEFINE p_pmdl RECORD  #採購單頭檔
          pmdlent LIKE pmdl_t.pmdlent, #企業編號
          pmdlsite LIKE pmdl_t.pmdlsite, #營運據點
          pmdlunit LIKE pmdl_t.pmdlunit, #應用組織
          pmdldocno LIKE pmdl_t.pmdldocno, #採購單號
          pmdldocdt LIKE pmdl_t.pmdldocdt, #採購日期
          pmdl001 LIKE pmdl_t.pmdl001, #版次
          pmdl002 LIKE pmdl_t.pmdl002, #採購人員
          pmdl003 LIKE pmdl_t.pmdl003, #採購部門
          pmdl004 LIKE pmdl_t.pmdl004, #供應商編號
          pmdl005 LIKE pmdl_t.pmdl005, #採購性質
          pmdl006 LIKE pmdl_t.pmdl006, #多角性質
          pmdl007 LIKE pmdl_t.pmdl007, #資料來源類型
          pmdl008 LIKE pmdl_t.pmdl008, #來源單號
          pmdl009 LIKE pmdl_t.pmdl009, #付款條件
          pmdl010 LIKE pmdl_t.pmdl010, #交易條件
          pmdl011 LIKE pmdl_t.pmdl011, #稅別
          pmdl012 LIKE pmdl_t.pmdl012, #稅率
          pmdl013 LIKE pmdl_t.pmdl013, #單價含稅否
          pmdl015 LIKE pmdl_t.pmdl015, #幣別
          pmdl016 LIKE pmdl_t.pmdl016, #匯率
          pmdl017 LIKE pmdl_t.pmdl017, #取價方式
          pmdl018 LIKE pmdl_t.pmdl018, #付款優惠條件
          pmdl019 LIKE pmdl_t.pmdl019, #納入APS計算
          pmdl020 LIKE pmdl_t.pmdl020, #運送方式
          pmdl021 LIKE pmdl_t.pmdl021, #付款供應商
          pmdl022 LIKE pmdl_t.pmdl022, #送貨供應商
          pmdl023 LIKE pmdl_t.pmdl023, #採購分類一
          pmdl024 LIKE pmdl_t.pmdl024, #採購分類二
          pmdl025 LIKE pmdl_t.pmdl025, #送貨地址
          pmdl026 LIKE pmdl_t.pmdl026, #帳款地址
          pmdl027 LIKE pmdl_t.pmdl027, #供應商連絡人
          pmdl028 LIKE pmdl_t.pmdl028, #一次性交易對象識別碼
          pmdl029 LIKE pmdl_t.pmdl029, #收貨部門
          pmdl030 LIKE pmdl_t.pmdl030, #多角貿易已拋轉
          pmdl031 LIKE pmdl_t.pmdl031, #多角序號
          pmdl032 LIKE pmdl_t.pmdl032, #最終客戶
          pmdl033 LIKE pmdl_t.pmdl033, #發票類型
          pmdl040 LIKE pmdl_t.pmdl040, #採購總未稅金額
          pmdl041 LIKE pmdl_t.pmdl041, #採購總含稅金額
          pmdl042 LIKE pmdl_t.pmdl042, #採購總稅額
          pmdl043 LIKE pmdl_t.pmdl043, #留置原因
          pmdl044 LIKE pmdl_t.pmdl044, #備註
          pmdl046 LIKE pmdl_t.pmdl046, #預付款發票開立方式
          pmdl047 LIKE pmdl_t.pmdl047, #物流結案
          pmdl048 LIKE pmdl_t.pmdl048, #帳流結案
          pmdl049 LIKE pmdl_t.pmdl049, #金流結案
          pmdl050 LIKE pmdl_t.pmdl050, #多角最終站否
          pmdl051 LIKE pmdl_t.pmdl051, #多角流程編號
          pmdl052 LIKE pmdl_t.pmdl052, #最終供應商
          pmdl053 LIKE pmdl_t.pmdl053, #兩角目的據點
          pmdl054 LIKE pmdl_t.pmdl054, #內外購
          pmdl055 LIKE pmdl_t.pmdl055, #匯率計算基準
          pmdl200 LIKE pmdl_t.pmdl200, #採購中心
          pmdl201 LIKE pmdl_t.pmdl201, #聯絡電話
          pmdl202 LIKE pmdl_t.pmdl202, #傳真號碼
          pmdl203 LIKE pmdl_t.pmdl203, #採購方式
          pmdl204 LIKE pmdl_t.pmdl204, #配送中心
          pmdl900 LIKE pmdl_t.pmdl900, #保留欄位str
          pmdl999 LIKE pmdl_t.pmdl999, #保留欄位end
          pmdlownid LIKE pmdl_t.pmdlownid, #資料所有者
          pmdlowndp LIKE pmdl_t.pmdlowndp, #資料所屬部門
          pmdlcrtid LIKE pmdl_t.pmdlcrtid, #資料建立者
          pmdlcrtdp LIKE pmdl_t.pmdlcrtdp, #資料建立部門
          pmdlcrtdt LIKE pmdl_t.pmdlcrtdt, #資料創建日
          pmdlmodid LIKE pmdl_t.pmdlmodid, #資料修改者
          pmdlmoddt LIKE pmdl_t.pmdlmoddt, #最近修改日
          pmdlcnfid LIKE pmdl_t.pmdlcnfid, #資料確認者
          pmdlcnfdt LIKE pmdl_t.pmdlcnfdt, #資料確認日
          pmdlpstid LIKE pmdl_t.pmdlpstid, #資料過帳者
          pmdlpstdt LIKE pmdl_t.pmdlpstdt, #資料過帳日
          pmdlstus LIKE pmdl_t.pmdlstus, #狀態碼
          #161109-00085#61 --s add
          pmdlud001 LIKE pmdl_t.pmdlud001, #自定義欄位(文字)001
          pmdlud002 LIKE pmdl_t.pmdlud002, #自定義欄位(文字)002
          pmdlud003 LIKE pmdl_t.pmdlud003, #自定義欄位(文字)003
          pmdlud004 LIKE pmdl_t.pmdlud004, #自定義欄位(文字)004
          pmdlud005 LIKE pmdl_t.pmdlud005, #自定義欄位(文字)005
          pmdlud006 LIKE pmdl_t.pmdlud006, #自定義欄位(文字)006
          pmdlud007 LIKE pmdl_t.pmdlud007, #自定義欄位(文字)007
          pmdlud008 LIKE pmdl_t.pmdlud008, #自定義欄位(文字)008
          pmdlud009 LIKE pmdl_t.pmdlud009, #自定義欄位(文字)009
          pmdlud010 LIKE pmdl_t.pmdlud010, #自定義欄位(文字)010
          pmdlud011 LIKE pmdl_t.pmdlud011, #自定義欄位(數字)011
          pmdlud012 LIKE pmdl_t.pmdlud012, #自定義欄位(數字)012
          pmdlud013 LIKE pmdl_t.pmdlud013, #自定義欄位(數字)013
          pmdlud014 LIKE pmdl_t.pmdlud014, #自定義欄位(數字)014
          pmdlud015 LIKE pmdl_t.pmdlud015, #自定義欄位(數字)015
          pmdlud016 LIKE pmdl_t.pmdlud016, #自定義欄位(數字)016
          pmdlud017 LIKE pmdl_t.pmdlud017, #自定義欄位(數字)017
          pmdlud018 LIKE pmdl_t.pmdlud018, #自定義欄位(數字)018
          pmdlud019 LIKE pmdl_t.pmdlud019, #自定義欄位(數字)019
          pmdlud020 LIKE pmdl_t.pmdlud020, #自定義欄位(數字)020
          pmdlud021 LIKE pmdl_t.pmdlud021, #自定義欄位(日期時間)021
          pmdlud022 LIKE pmdl_t.pmdlud022, #自定義欄位(日期時間)022
          pmdlud023 LIKE pmdl_t.pmdlud023, #自定義欄位(日期時間)023
          pmdlud024 LIKE pmdl_t.pmdlud024, #自定義欄位(日期時間)024
          pmdlud025 LIKE pmdl_t.pmdlud025, #自定義欄位(日期時間)025
          pmdlud026 LIKE pmdl_t.pmdlud026, #自定義欄位(日期時間)026
          pmdlud027 LIKE pmdl_t.pmdlud027, #自定義欄位(日期時間)027
          pmdlud028 LIKE pmdl_t.pmdlud028, #自定義欄位(日期時間)028
          pmdlud029 LIKE pmdl_t.pmdlud029, #自定義欄位(日期時間)029
          pmdlud030 LIKE pmdl_t.pmdlud030, #自定義欄位(日期時間)030
          #161109-00085#61 --e add
          pmdl205 LIKE pmdl_t.pmdl205, #採購最終有效日
          pmdl206 LIKE pmdl_t.pmdl206, #長效期訂單否
          pmdl207 LIKE pmdl_t.pmdl207, #所屬品類
          pmdl208 LIKE pmdl_t.pmdl208  #電子採購單號
   END RECORD
   #mod--161109-00085#14 By 08993--(e)
  
#mod--161109-00085#14 By 08993--(s)
#   DEFINE r_pmdl       RECORD LIKE  pmdl_t.*   #mark--161109-00085#14 By 08993--(s)
   DEFINE r_pmdl RECORD  #採購單頭檔
          pmdlent LIKE pmdl_t.pmdlent, #企業編號
          pmdlsite LIKE pmdl_t.pmdlsite, #營運據點
          pmdlunit LIKE pmdl_t.pmdlunit, #應用組織
          pmdldocno LIKE pmdl_t.pmdldocno, #採購單號
          pmdldocdt LIKE pmdl_t.pmdldocdt, #採購日期
          pmdl001 LIKE pmdl_t.pmdl001, #版次
          pmdl002 LIKE pmdl_t.pmdl002, #採購人員
          pmdl003 LIKE pmdl_t.pmdl003, #採購部門
          pmdl004 LIKE pmdl_t.pmdl004, #供應商編號
          pmdl005 LIKE pmdl_t.pmdl005, #採購性質
          pmdl006 LIKE pmdl_t.pmdl006, #多角性質
          pmdl007 LIKE pmdl_t.pmdl007, #資料來源類型
          pmdl008 LIKE pmdl_t.pmdl008, #來源單號
          pmdl009 LIKE pmdl_t.pmdl009, #付款條件
          pmdl010 LIKE pmdl_t.pmdl010, #交易條件
          pmdl011 LIKE pmdl_t.pmdl011, #稅別
          pmdl012 LIKE pmdl_t.pmdl012, #稅率
          pmdl013 LIKE pmdl_t.pmdl013, #單價含稅否
          pmdl015 LIKE pmdl_t.pmdl015, #幣別
          pmdl016 LIKE pmdl_t.pmdl016, #匯率
          pmdl017 LIKE pmdl_t.pmdl017, #取價方式
          pmdl018 LIKE pmdl_t.pmdl018, #付款優惠條件
          pmdl019 LIKE pmdl_t.pmdl019, #納入APS計算
          pmdl020 LIKE pmdl_t.pmdl020, #運送方式
          pmdl021 LIKE pmdl_t.pmdl021, #付款供應商
          pmdl022 LIKE pmdl_t.pmdl022, #送貨供應商
          pmdl023 LIKE pmdl_t.pmdl023, #採購分類一
          pmdl024 LIKE pmdl_t.pmdl024, #採購分類二
          pmdl025 LIKE pmdl_t.pmdl025, #送貨地址
          pmdl026 LIKE pmdl_t.pmdl026, #帳款地址
          pmdl027 LIKE pmdl_t.pmdl027, #供應商連絡人
          pmdl028 LIKE pmdl_t.pmdl028, #一次性交易對象識別碼
          pmdl029 LIKE pmdl_t.pmdl029, #收貨部門
          pmdl030 LIKE pmdl_t.pmdl030, #多角貿易已拋轉
          pmdl031 LIKE pmdl_t.pmdl031, #多角序號
          pmdl032 LIKE pmdl_t.pmdl032, #最終客戶
          pmdl033 LIKE pmdl_t.pmdl033, #發票類型
          pmdl040 LIKE pmdl_t.pmdl040, #採購總未稅金額
          pmdl041 LIKE pmdl_t.pmdl041, #採購總含稅金額
          pmdl042 LIKE pmdl_t.pmdl042, #採購總稅額
          pmdl043 LIKE pmdl_t.pmdl043, #留置原因
          pmdl044 LIKE pmdl_t.pmdl044, #備註
          pmdl046 LIKE pmdl_t.pmdl046, #預付款發票開立方式
          pmdl047 LIKE pmdl_t.pmdl047, #物流結案
          pmdl048 LIKE pmdl_t.pmdl048, #帳流結案
          pmdl049 LIKE pmdl_t.pmdl049, #金流結案
          pmdl050 LIKE pmdl_t.pmdl050, #多角最終站否
          pmdl051 LIKE pmdl_t.pmdl051, #多角流程編號
          pmdl052 LIKE pmdl_t.pmdl052, #最終供應商
          pmdl053 LIKE pmdl_t.pmdl053, #兩角目的據點
          pmdl054 LIKE pmdl_t.pmdl054, #內外購
          pmdl055 LIKE pmdl_t.pmdl055, #匯率計算基準
          pmdl200 LIKE pmdl_t.pmdl200, #採購中心
          pmdl201 LIKE pmdl_t.pmdl201, #聯絡電話
          pmdl202 LIKE pmdl_t.pmdl202, #傳真號碼
          pmdl203 LIKE pmdl_t.pmdl203, #採購方式
          pmdl204 LIKE pmdl_t.pmdl204, #配送中心
          pmdl900 LIKE pmdl_t.pmdl900, #保留欄位str
          pmdl999 LIKE pmdl_t.pmdl999, #保留欄位end
          pmdlownid LIKE pmdl_t.pmdlownid, #資料所有者
          pmdlowndp LIKE pmdl_t.pmdlowndp, #資料所屬部門
          pmdlcrtid LIKE pmdl_t.pmdlcrtid, #資料建立者
          pmdlcrtdp LIKE pmdl_t.pmdlcrtdp, #資料建立部門
          pmdlcrtdt LIKE pmdl_t.pmdlcrtdt, #資料創建日
          pmdlmodid LIKE pmdl_t.pmdlmodid, #資料修改者
          pmdlmoddt LIKE pmdl_t.pmdlmoddt, #最近修改日
          pmdlcnfid LIKE pmdl_t.pmdlcnfid, #資料確認者
          pmdlcnfdt LIKE pmdl_t.pmdlcnfdt, #資料確認日
          pmdlpstid LIKE pmdl_t.pmdlpstid, #資料過帳者
          pmdlpstdt LIKE pmdl_t.pmdlpstdt, #資料過帳日
          pmdlstus LIKE pmdl_t.pmdlstus, #狀態碼
          #161109-00085#61 --s add
          pmdlud001 LIKE pmdl_t.pmdlud001, #自定義欄位(文字)001
          pmdlud002 LIKE pmdl_t.pmdlud002, #自定義欄位(文字)002
          pmdlud003 LIKE pmdl_t.pmdlud003, #自定義欄位(文字)003
          pmdlud004 LIKE pmdl_t.pmdlud004, #自定義欄位(文字)004
          pmdlud005 LIKE pmdl_t.pmdlud005, #自定義欄位(文字)005
          pmdlud006 LIKE pmdl_t.pmdlud006, #自定義欄位(文字)006
          pmdlud007 LIKE pmdl_t.pmdlud007, #自定義欄位(文字)007
          pmdlud008 LIKE pmdl_t.pmdlud008, #自定義欄位(文字)008
          pmdlud009 LIKE pmdl_t.pmdlud009, #自定義欄位(文字)009
          pmdlud010 LIKE pmdl_t.pmdlud010, #自定義欄位(文字)010
          pmdlud011 LIKE pmdl_t.pmdlud011, #自定義欄位(數字)011
          pmdlud012 LIKE pmdl_t.pmdlud012, #自定義欄位(數字)012
          pmdlud013 LIKE pmdl_t.pmdlud013, #自定義欄位(數字)013
          pmdlud014 LIKE pmdl_t.pmdlud014, #自定義欄位(數字)014
          pmdlud015 LIKE pmdl_t.pmdlud015, #自定義欄位(數字)015
          pmdlud016 LIKE pmdl_t.pmdlud016, #自定義欄位(數字)016
          pmdlud017 LIKE pmdl_t.pmdlud017, #自定義欄位(數字)017
          pmdlud018 LIKE pmdl_t.pmdlud018, #自定義欄位(數字)018
          pmdlud019 LIKE pmdl_t.pmdlud019, #自定義欄位(數字)019
          pmdlud020 LIKE pmdl_t.pmdlud020, #自定義欄位(數字)020
          pmdlud021 LIKE pmdl_t.pmdlud021, #自定義欄位(日期時間)021
          pmdlud022 LIKE pmdl_t.pmdlud022, #自定義欄位(日期時間)022
          pmdlud023 LIKE pmdl_t.pmdlud023, #自定義欄位(日期時間)023
          pmdlud024 LIKE pmdl_t.pmdlud024, #自定義欄位(日期時間)024
          pmdlud025 LIKE pmdl_t.pmdlud025, #自定義欄位(日期時間)025
          pmdlud026 LIKE pmdl_t.pmdlud026, #自定義欄位(日期時間)026
          pmdlud027 LIKE pmdl_t.pmdlud027, #自定義欄位(日期時間)027
          pmdlud028 LIKE pmdl_t.pmdlud028, #自定義欄位(日期時間)028
          pmdlud029 LIKE pmdl_t.pmdlud029, #自定義欄位(日期時間)029
          pmdlud030 LIKE pmdl_t.pmdlud030, #自定義欄位(日期時間)030
          #161109-00085#61 --e add
          pmdl205 LIKE pmdl_t.pmdl205, #採購最終有效日
          pmdl206 LIKE pmdl_t.pmdl206, #長效期訂單否
          pmdl207 LIKE pmdl_t.pmdl207, #所屬品類
          pmdl208 LIKE pmdl_t.pmdl208  #電子採購單號
   END RECORD
   #mod--161109-00085#14 By 08993--(e)     
   WHENEVER ERROR CONTINUE 

   LET r_pmdl.* = p_pmdl.*

   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdldocdt',r_pmdl.pmdldocdt)
        RETURNING r_pmdl.pmdldocdt
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl001',r_pmdl.pmdl001)
        RETURNING r_pmdl.pmdl001
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl002',r_pmdl.pmdl002)
        RETURNING r_pmdl.pmdl002
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl003',r_pmdl.pmdl003)
        RETURNING r_pmdl.pmdl003
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl004',r_pmdl.pmdl004)
        RETURNING r_pmdl.pmdl004
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl005',r_pmdl.pmdl005)
        RETURNING r_pmdl.pmdl005
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl006',r_pmdl.pmdl006)
        RETURNING r_pmdl.pmdl006
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl007',r_pmdl.pmdl007)
        RETURNING r_pmdl.pmdl007
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl008',r_pmdl.pmdl008)
        RETURNING r_pmdl.pmdl008
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl009',r_pmdl.pmdl009)
        RETURNING r_pmdl.pmdl009
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl010',r_pmdl.pmdl010)
        RETURNING r_pmdl.pmdl010 
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl011',r_pmdl.pmdl011)
        RETURNING r_pmdl.pmdl011
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl012',r_pmdl.pmdl012)
        RETURNING r_pmdl.pmdl012
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl013',r_pmdl.pmdl013)
        RETURNING r_pmdl.pmdl013
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl015',r_pmdl.pmdl015)
        RETURNING r_pmdl.pmdl015
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl016',r_pmdl.pmdl016)
        RETURNING r_pmdl.pmdl016
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl017',r_pmdl.pmdl017)
        RETURNING r_pmdl.pmdl017
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl018',r_pmdl.pmdl018)
        RETURNING r_pmdl.pmdl018
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl019',r_pmdl.pmdl019)
        RETURNING r_pmdl.pmdl019
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl020',r_pmdl.pmdl020)
        RETURNING r_pmdl.pmdl020
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl021',r_pmdl.pmdl021)
        RETURNING r_pmdl.pmdl021
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl022',r_pmdl.pmdl022)
        RETURNING r_pmdl.pmdl022
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl023',r_pmdl.pmdl023)
        RETURNING r_pmdl.pmdl023
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl024',r_pmdl.pmdl024)
        RETURNING r_pmdl.pmdl024
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl025',r_pmdl.pmdl025)
        RETURNING r_pmdl.pmdl025 
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl026',r_pmdl.pmdl026)
        RETURNING r_pmdl.pmdl026
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl027',r_pmdl.pmdl027)
        RETURNING r_pmdl.pmdl027
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl028',r_pmdl.pmdl028)
        RETURNING r_pmdl.pmdl028
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl029',r_pmdl.pmdl029)
        RETURNING r_pmdl.pmdl029
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl030',r_pmdl.pmdl030)
        RETURNING r_pmdl.pmdl030
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl031',r_pmdl.pmdl031)
        RETURNING r_pmdl.pmdl031
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl032',r_pmdl.pmdl032)
        RETURNING r_pmdl.pmdl032
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl033',r_pmdl.pmdl033)
        RETURNING r_pmdl.pmdl033
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl040',r_pmdl.pmdl040)
        RETURNING r_pmdl.pmdl040
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl041',r_pmdl.pmdl041)
        RETURNING r_pmdl.pmdl041
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl042',r_pmdl.pmdl042)
        RETURNING r_pmdl.pmdl042
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl043',r_pmdl.pmdl043)
        RETURNING r_pmdl.pmdl043
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl044',r_pmdl.pmdl044)
        RETURNING r_pmdl.pmdl044
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl046',r_pmdl.pmdl046)
        RETURNING r_pmdl.pmdl046         
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl047',r_pmdl.pmdl047)
        RETURNING r_pmdl.pmdl047
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl048',r_pmdl.pmdl048)
        RETURNING r_pmdl.pmdl048
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl049',r_pmdl.pmdl049)
        RETURNING r_pmdl.pmdl049
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl050',r_pmdl.pmdl050)
        RETURNING r_pmdl.pmdl050
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl051',r_pmdl.pmdl051)
        RETURNING r_pmdl.pmdl051
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl052',r_pmdl.pmdl052)
        RETURNING r_pmdl.pmdl052
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl053',r_pmdl.pmdl053)
        RETURNING r_pmdl.pmdl053
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl054',r_pmdl.pmdl054)
        RETURNING r_pmdl.pmdl054
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl055',r_pmdl.pmdl055)
        RETURNING r_pmdl.pmdl055
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl200',r_pmdl.pmdl200)
        RETURNING r_pmdl.pmdl200
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl201',r_pmdl.pmdl201)
        RETURNING r_pmdl.pmdl201
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl202',r_pmdl.pmdl202)
        RETURNING r_pmdl.pmdl202
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl203',r_pmdl.pmdl203)
        RETURNING r_pmdl.pmdl203
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl204',r_pmdl.pmdl204)
        RETURNING r_pmdl.pmdl204
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl900',r_pmdl.pmdl900) 
        RETURNING r_pmdl.pmdl900
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl999',r_pmdl.pmdl999)
        RETURNING r_pmdl.pmdl999
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl205',r_pmdl.pmdl205)
        RETURNING r_pmdl.pmdl205
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl206',r_pmdl.pmdl206)
        RETURNING r_pmdl.pmdl206
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl207',r_pmdl.pmdl207)
        RETURNING r_pmdl.pmdl207

   RETURN r_pmdl.*
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsp610_03_chk_ooag(p_pmdl002)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_03_chk_ooag(p_pmdl002)
   DEFINE p_pmdl002     LIKE pmdl_t.pmdl002
   DEFINE l_ooagstus    LIKE ooag_t.ooagstus 
   
   WHENEVER ERROR CONTINUE 

   LET g_errno = ''
   LET l_ooagstus = ''
   SELECT ooagstus INTO l_ooagstus
     FROM ooag_t
    WHERE ooagent = g_enterprise 
      AND ooag001 = p_pmdl002

   CASE
      WHEN SQLCA.sqlcode = 100   LET g_errno = 'aim-00069'    #輸入的資料不存在於 [員工資料檔] 中!  
      WHEN l_ooagstus != 'Y'     LET g_errno = 'sub-01302'    #輸入的資料無效！ 
      OTHERWISE                  LET g_errno = SQLCA.sqlcode USING '------'
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsp610_03_pmdl004_chk(p_pmdl004)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_03_pmdl004_chk(p_pmdl004)
   DEFINE p_pmdl004     LIKE pmdl_t.pmdl004
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_flag        LIKE type_t.num5
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_pmaastus    LIKE pmaa_t.pmaastus 
   
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
         WHEN SQLCA.sqlcode = 100    LET g_errno = 'apm-00024'    #輸入的資料不存在於交易  
         WHEN l_pmaastus <> 'Y'      LET g_errno = 'apm-00200'    #輸入的資料未確認或已無效！ 
         OTHERWISE                   LET g_errno = SQLCA.sqlcode USING '------'
      END CASE

      IF NOT cl_null(g_errno) THEN
         LET r_success = FALSE
         RETURN
      END IF 
   END IF

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsp610_03_pmdl004_def(p_pmdl)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_03_pmdl004_def(p_pmdl)

   #mod--161109-00085#14 By 08993--(s)
#   DEFINE p_pmdl       RECORD LIKE  pmdl_t.*   #mark--161109-00085#14 By 08993--(s)
   DEFINE p_pmdl RECORD  #採購單頭檔
          pmdlent LIKE pmdl_t.pmdlent, #企業編號
          pmdlsite LIKE pmdl_t.pmdlsite, #營運據點
          pmdlunit LIKE pmdl_t.pmdlunit, #應用組織
          pmdldocno LIKE pmdl_t.pmdldocno, #採購單號
          pmdldocdt LIKE pmdl_t.pmdldocdt, #採購日期
          pmdl001 LIKE pmdl_t.pmdl001, #版次
          pmdl002 LIKE pmdl_t.pmdl002, #採購人員
          pmdl003 LIKE pmdl_t.pmdl003, #採購部門
          pmdl004 LIKE pmdl_t.pmdl004, #供應商編號
          pmdl005 LIKE pmdl_t.pmdl005, #採購性質
          pmdl006 LIKE pmdl_t.pmdl006, #多角性質
          pmdl007 LIKE pmdl_t.pmdl007, #資料來源類型
          pmdl008 LIKE pmdl_t.pmdl008, #來源單號
          pmdl009 LIKE pmdl_t.pmdl009, #付款條件
          pmdl010 LIKE pmdl_t.pmdl010, #交易條件
          pmdl011 LIKE pmdl_t.pmdl011, #稅別
          pmdl012 LIKE pmdl_t.pmdl012, #稅率
          pmdl013 LIKE pmdl_t.pmdl013, #單價含稅否
          pmdl015 LIKE pmdl_t.pmdl015, #幣別
          pmdl016 LIKE pmdl_t.pmdl016, #匯率
          pmdl017 LIKE pmdl_t.pmdl017, #取價方式
          pmdl018 LIKE pmdl_t.pmdl018, #付款優惠條件
          pmdl019 LIKE pmdl_t.pmdl019, #納入APS計算
          pmdl020 LIKE pmdl_t.pmdl020, #運送方式
          pmdl021 LIKE pmdl_t.pmdl021, #付款供應商
          pmdl022 LIKE pmdl_t.pmdl022, #送貨供應商
          pmdl023 LIKE pmdl_t.pmdl023, #採購分類一
          pmdl024 LIKE pmdl_t.pmdl024, #採購分類二
          pmdl025 LIKE pmdl_t.pmdl025, #送貨地址
          pmdl026 LIKE pmdl_t.pmdl026, #帳款地址
          pmdl027 LIKE pmdl_t.pmdl027, #供應商連絡人
          pmdl028 LIKE pmdl_t.pmdl028, #一次性交易對象識別碼
          pmdl029 LIKE pmdl_t.pmdl029, #收貨部門
          pmdl030 LIKE pmdl_t.pmdl030, #多角貿易已拋轉
          pmdl031 LIKE pmdl_t.pmdl031, #多角序號
          pmdl032 LIKE pmdl_t.pmdl032, #最終客戶
          pmdl033 LIKE pmdl_t.pmdl033, #發票類型
          pmdl040 LIKE pmdl_t.pmdl040, #採購總未稅金額
          pmdl041 LIKE pmdl_t.pmdl041, #採購總含稅金額
          pmdl042 LIKE pmdl_t.pmdl042, #採購總稅額
          pmdl043 LIKE pmdl_t.pmdl043, #留置原因
          pmdl044 LIKE pmdl_t.pmdl044, #備註
          pmdl046 LIKE pmdl_t.pmdl046, #預付款發票開立方式
          pmdl047 LIKE pmdl_t.pmdl047, #物流結案
          pmdl048 LIKE pmdl_t.pmdl048, #帳流結案
          pmdl049 LIKE pmdl_t.pmdl049, #金流結案
          pmdl050 LIKE pmdl_t.pmdl050, #多角最終站否
          pmdl051 LIKE pmdl_t.pmdl051, #多角流程編號
          pmdl052 LIKE pmdl_t.pmdl052, #最終供應商
          pmdl053 LIKE pmdl_t.pmdl053, #兩角目的據點
          pmdl054 LIKE pmdl_t.pmdl054, #內外購
          pmdl055 LIKE pmdl_t.pmdl055, #匯率計算基準
          pmdl200 LIKE pmdl_t.pmdl200, #採購中心
          pmdl201 LIKE pmdl_t.pmdl201, #聯絡電話
          pmdl202 LIKE pmdl_t.pmdl202, #傳真號碼
          pmdl203 LIKE pmdl_t.pmdl203, #採購方式
          pmdl204 LIKE pmdl_t.pmdl204, #配送中心
          pmdl900 LIKE pmdl_t.pmdl900, #保留欄位str
          pmdl999 LIKE pmdl_t.pmdl999, #保留欄位end
          pmdlownid LIKE pmdl_t.pmdlownid, #資料所有者
          pmdlowndp LIKE pmdl_t.pmdlowndp, #資料所屬部門
          pmdlcrtid LIKE pmdl_t.pmdlcrtid, #資料建立者
          pmdlcrtdp LIKE pmdl_t.pmdlcrtdp, #資料建立部門
          pmdlcrtdt LIKE pmdl_t.pmdlcrtdt, #資料創建日
          pmdlmodid LIKE pmdl_t.pmdlmodid, #資料修改者
          pmdlmoddt LIKE pmdl_t.pmdlmoddt, #最近修改日
          pmdlcnfid LIKE pmdl_t.pmdlcnfid, #資料確認者
          pmdlcnfdt LIKE pmdl_t.pmdlcnfdt, #資料確認日
          pmdlpstid LIKE pmdl_t.pmdlpstid, #資料過帳者
          pmdlpstdt LIKE pmdl_t.pmdlpstdt, #資料過帳日
          pmdlstus LIKE pmdl_t.pmdlstus, #狀態碼
          #161109-00085#61 --s add
          pmdlud001 LIKE pmdl_t.pmdlud001, #自定義欄位(文字)001
          pmdlud002 LIKE pmdl_t.pmdlud002, #自定義欄位(文字)002
          pmdlud003 LIKE pmdl_t.pmdlud003, #自定義欄位(文字)003
          pmdlud004 LIKE pmdl_t.pmdlud004, #自定義欄位(文字)004
          pmdlud005 LIKE pmdl_t.pmdlud005, #自定義欄位(文字)005
          pmdlud006 LIKE pmdl_t.pmdlud006, #自定義欄位(文字)006
          pmdlud007 LIKE pmdl_t.pmdlud007, #自定義欄位(文字)007
          pmdlud008 LIKE pmdl_t.pmdlud008, #自定義欄位(文字)008
          pmdlud009 LIKE pmdl_t.pmdlud009, #自定義欄位(文字)009
          pmdlud010 LIKE pmdl_t.pmdlud010, #自定義欄位(文字)010
          pmdlud011 LIKE pmdl_t.pmdlud011, #自定義欄位(數字)011
          pmdlud012 LIKE pmdl_t.pmdlud012, #自定義欄位(數字)012
          pmdlud013 LIKE pmdl_t.pmdlud013, #自定義欄位(數字)013
          pmdlud014 LIKE pmdl_t.pmdlud014, #自定義欄位(數字)014
          pmdlud015 LIKE pmdl_t.pmdlud015, #自定義欄位(數字)015
          pmdlud016 LIKE pmdl_t.pmdlud016, #自定義欄位(數字)016
          pmdlud017 LIKE pmdl_t.pmdlud017, #自定義欄位(數字)017
          pmdlud018 LIKE pmdl_t.pmdlud018, #自定義欄位(數字)018
          pmdlud019 LIKE pmdl_t.pmdlud019, #自定義欄位(數字)019
          pmdlud020 LIKE pmdl_t.pmdlud020, #自定義欄位(數字)020
          pmdlud021 LIKE pmdl_t.pmdlud021, #自定義欄位(日期時間)021
          pmdlud022 LIKE pmdl_t.pmdlud022, #自定義欄位(日期時間)022
          pmdlud023 LIKE pmdl_t.pmdlud023, #自定義欄位(日期時間)023
          pmdlud024 LIKE pmdl_t.pmdlud024, #自定義欄位(日期時間)024
          pmdlud025 LIKE pmdl_t.pmdlud025, #自定義欄位(日期時間)025
          pmdlud026 LIKE pmdl_t.pmdlud026, #自定義欄位(日期時間)026
          pmdlud027 LIKE pmdl_t.pmdlud027, #自定義欄位(日期時間)027
          pmdlud028 LIKE pmdl_t.pmdlud028, #自定義欄位(日期時間)028
          pmdlud029 LIKE pmdl_t.pmdlud029, #自定義欄位(日期時間)029
          pmdlud030 LIKE pmdl_t.pmdlud030, #自定義欄位(日期時間)030
          #161109-00085#61 --e add
          pmdl205 LIKE pmdl_t.pmdl205, #採購最終有效日
          pmdl206 LIKE pmdl_t.pmdl206, #長效期訂單否
          pmdl207 LIKE pmdl_t.pmdl207, #所屬品類
          pmdl208 LIKE pmdl_t.pmdl208  #電子採購單號
   END RECORD
   #mod--161109-00085#14 By 08993--(e)
   #mod--161109-00085#14 By 08993--(s)
#   DEFINE r_pmdl       RECORD LIKE  pmdl_t.*   #mark--161109-00085#14 By 08993--(s)
   DEFINE r_pmdl RECORD  #採購單頭檔
          pmdlent LIKE pmdl_t.pmdlent, #企業編號
          pmdlsite LIKE pmdl_t.pmdlsite, #營運據點
          pmdlunit LIKE pmdl_t.pmdlunit, #應用組織
          pmdldocno LIKE pmdl_t.pmdldocno, #採購單號
          pmdldocdt LIKE pmdl_t.pmdldocdt, #採購日期
          pmdl001 LIKE pmdl_t.pmdl001, #版次
          pmdl002 LIKE pmdl_t.pmdl002, #採購人員
          pmdl003 LIKE pmdl_t.pmdl003, #採購部門
          pmdl004 LIKE pmdl_t.pmdl004, #供應商編號
          pmdl005 LIKE pmdl_t.pmdl005, #採購性質
          pmdl006 LIKE pmdl_t.pmdl006, #多角性質
          pmdl007 LIKE pmdl_t.pmdl007, #資料來源類型
          pmdl008 LIKE pmdl_t.pmdl008, #來源單號
          pmdl009 LIKE pmdl_t.pmdl009, #付款條件
          pmdl010 LIKE pmdl_t.pmdl010, #交易條件
          pmdl011 LIKE pmdl_t.pmdl011, #稅別
          pmdl012 LIKE pmdl_t.pmdl012, #稅率
          pmdl013 LIKE pmdl_t.pmdl013, #單價含稅否
          pmdl015 LIKE pmdl_t.pmdl015, #幣別
          pmdl016 LIKE pmdl_t.pmdl016, #匯率
          pmdl017 LIKE pmdl_t.pmdl017, #取價方式
          pmdl018 LIKE pmdl_t.pmdl018, #付款優惠條件
          pmdl019 LIKE pmdl_t.pmdl019, #納入APS計算
          pmdl020 LIKE pmdl_t.pmdl020, #運送方式
          pmdl021 LIKE pmdl_t.pmdl021, #付款供應商
          pmdl022 LIKE pmdl_t.pmdl022, #送貨供應商
          pmdl023 LIKE pmdl_t.pmdl023, #採購分類一
          pmdl024 LIKE pmdl_t.pmdl024, #採購分類二
          pmdl025 LIKE pmdl_t.pmdl025, #送貨地址
          pmdl026 LIKE pmdl_t.pmdl026, #帳款地址
          pmdl027 LIKE pmdl_t.pmdl027, #供應商連絡人
          pmdl028 LIKE pmdl_t.pmdl028, #一次性交易對象識別碼
          pmdl029 LIKE pmdl_t.pmdl029, #收貨部門
          pmdl030 LIKE pmdl_t.pmdl030, #多角貿易已拋轉
          pmdl031 LIKE pmdl_t.pmdl031, #多角序號
          pmdl032 LIKE pmdl_t.pmdl032, #最終客戶
          pmdl033 LIKE pmdl_t.pmdl033, #發票類型
          pmdl040 LIKE pmdl_t.pmdl040, #採購總未稅金額
          pmdl041 LIKE pmdl_t.pmdl041, #採購總含稅金額
          pmdl042 LIKE pmdl_t.pmdl042, #採購總稅額
          pmdl043 LIKE pmdl_t.pmdl043, #留置原因
          pmdl044 LIKE pmdl_t.pmdl044, #備註
          pmdl046 LIKE pmdl_t.pmdl046, #預付款發票開立方式
          pmdl047 LIKE pmdl_t.pmdl047, #物流結案
          pmdl048 LIKE pmdl_t.pmdl048, #帳流結案
          pmdl049 LIKE pmdl_t.pmdl049, #金流結案
          pmdl050 LIKE pmdl_t.pmdl050, #多角最終站否
          pmdl051 LIKE pmdl_t.pmdl051, #多角流程編號
          pmdl052 LIKE pmdl_t.pmdl052, #最終供應商
          pmdl053 LIKE pmdl_t.pmdl053, #兩角目的據點
          pmdl054 LIKE pmdl_t.pmdl054, #內外購
          pmdl055 LIKE pmdl_t.pmdl055, #匯率計算基準
          pmdl200 LIKE pmdl_t.pmdl200, #採購中心
          pmdl201 LIKE pmdl_t.pmdl201, #聯絡電話
          pmdl202 LIKE pmdl_t.pmdl202, #傳真號碼
          pmdl203 LIKE pmdl_t.pmdl203, #採購方式
          pmdl204 LIKE pmdl_t.pmdl204, #配送中心
          pmdl900 LIKE pmdl_t.pmdl900, #保留欄位str
          pmdl999 LIKE pmdl_t.pmdl999, #保留欄位end
          pmdlownid LIKE pmdl_t.pmdlownid, #資料所有者
          pmdlowndp LIKE pmdl_t.pmdlowndp, #資料所屬部門
          pmdlcrtid LIKE pmdl_t.pmdlcrtid, #資料建立者
          pmdlcrtdp LIKE pmdl_t.pmdlcrtdp, #資料建立部門
          pmdlcrtdt LIKE pmdl_t.pmdlcrtdt, #資料創建日
          pmdlmodid LIKE pmdl_t.pmdlmodid, #資料修改者
          pmdlmoddt LIKE pmdl_t.pmdlmoddt, #最近修改日
          pmdlcnfid LIKE pmdl_t.pmdlcnfid, #資料確認者
          pmdlcnfdt LIKE pmdl_t.pmdlcnfdt, #資料確認日
          pmdlpstid LIKE pmdl_t.pmdlpstid, #資料過帳者
          pmdlpstdt LIKE pmdl_t.pmdlpstdt, #資料過帳日
          pmdlstus LIKE pmdl_t.pmdlstus, #狀態碼
          #161109-00085#61 --s add
          pmdlud001 LIKE pmdl_t.pmdlud001, #自定義欄位(文字)001
          pmdlud002 LIKE pmdl_t.pmdlud002, #自定義欄位(文字)002
          pmdlud003 LIKE pmdl_t.pmdlud003, #自定義欄位(文字)003
          pmdlud004 LIKE pmdl_t.pmdlud004, #自定義欄位(文字)004
          pmdlud005 LIKE pmdl_t.pmdlud005, #自定義欄位(文字)005
          pmdlud006 LIKE pmdl_t.pmdlud006, #自定義欄位(文字)006
          pmdlud007 LIKE pmdl_t.pmdlud007, #自定義欄位(文字)007
          pmdlud008 LIKE pmdl_t.pmdlud008, #自定義欄位(文字)008
          pmdlud009 LIKE pmdl_t.pmdlud009, #自定義欄位(文字)009
          pmdlud010 LIKE pmdl_t.pmdlud010, #自定義欄位(文字)010
          pmdlud011 LIKE pmdl_t.pmdlud011, #自定義欄位(數字)011
          pmdlud012 LIKE pmdl_t.pmdlud012, #自定義欄位(數字)012
          pmdlud013 LIKE pmdl_t.pmdlud013, #自定義欄位(數字)013
          pmdlud014 LIKE pmdl_t.pmdlud014, #自定義欄位(數字)014
          pmdlud015 LIKE pmdl_t.pmdlud015, #自定義欄位(數字)015
          pmdlud016 LIKE pmdl_t.pmdlud016, #自定義欄位(數字)016
          pmdlud017 LIKE pmdl_t.pmdlud017, #自定義欄位(數字)017
          pmdlud018 LIKE pmdl_t.pmdlud018, #自定義欄位(數字)018
          pmdlud019 LIKE pmdl_t.pmdlud019, #自定義欄位(數字)019
          pmdlud020 LIKE pmdl_t.pmdlud020, #自定義欄位(數字)020
          pmdlud021 LIKE pmdl_t.pmdlud021, #自定義欄位(日期時間)021
          pmdlud022 LIKE pmdl_t.pmdlud022, #自定義欄位(日期時間)022
          pmdlud023 LIKE pmdl_t.pmdlud023, #自定義欄位(日期時間)023
          pmdlud024 LIKE pmdl_t.pmdlud024, #自定義欄位(日期時間)024
          pmdlud025 LIKE pmdl_t.pmdlud025, #自定義欄位(日期時間)025
          pmdlud026 LIKE pmdl_t.pmdlud026, #自定義欄位(日期時間)026
          pmdlud027 LIKE pmdl_t.pmdlud027, #自定義欄位(日期時間)027
          pmdlud028 LIKE pmdl_t.pmdlud028, #自定義欄位(日期時間)028
          pmdlud029 LIKE pmdl_t.pmdlud029, #自定義欄位(日期時間)029
          pmdlud030 LIKE pmdl_t.pmdlud030, #自定義欄位(日期時間)030
          #161109-00085#61 --e add
          pmdl205 LIKE pmdl_t.pmdl205, #採購最終有效日
          pmdl206 LIKE pmdl_t.pmdl206, #長效期訂單否
          pmdl207 LIKE pmdl_t.pmdl207, #所屬品類
          pmdl208 LIKE pmdl_t.pmdl208  #電子採購單號
   END RECORD
   #mod--161109-00085#14 By 08993--(e)
   DEFINE l_n         LIKE type_t.num5
   DEFINE l_ooef016   LIKE ooef_t.ooef016
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_controlno LIKE ooha_t.ooha001 
   
   WHENEVER ERROR CONTINUE 

   LET r_pmdl.* = p_pmdl.*

   LET l_n = 0

   #抓取交易對象夥伴關係檔且交易類型為"1:收/付款對象"的交易對象顯示在採購單上的
   #[C:帳款供應商]，若有設置多筆收/付款交易對象時，則取有勾選主要的交易對象那一個，
   #若沒有設交易對象夥伴關係檔且交易類型為"1:收/付款對象"的交易對象時，則[C:帳款供應商]預設採購供應商
   LET r_pmdl.pmdl021 = ''
   SELECT pmac002 INTO r_pmdl.pmdl021
     FROM pmac_t
    WHERE pmacent  = g_enterprise
      AND pmac001  = r_pmdl.pmdl004
      AND pmac003  = '1'
      AND pmacstus = 'Y'
      AND pmac004  = 'Y' 
   IF cl_null(r_pmdl.pmdl021) THEN
      SELECT pmac002 INTO r_pmdl.pmdl021
        FROM pmac_t
       WHERE pmacent  = g_enterprise
         AND pmac001  = r_pmdl.pmdl004
         AND pmac003  = '1'
         AND pmacstus = 'Y'
         AND rownum  = 1
      IF cl_null(r_pmdl.pmdl021) THEN
         LET r_pmdl.pmdl021 = r_pmdl.pmdl004
      END IF
   END IF

   #抓取交易對象夥伴關係檔且交易類型為"2:出貨對象"的交易對象顯示在採購單上的[C:送貨供應商]，
   #若有設置多筆出貨交易對象時，則取有勾選主要的交易對象那一個，
   #若沒有設交易對象夥伴關係檔且交易類型為"2:出貨對象"的交易對象時，則[C:送貨供應商]預設採購供應商
   LET r_pmdl.pmdl022 = ''
   SELECT pmac002 INTO r_pmdl.pmdl022
     FROM pmac_t
    WHERE pmacent  = g_enterprise
      AND pmac001  = r_pmdl.pmdl004
      AND pmac003  = '2'
      AND pmacstus = 'Y'
      AND pmac004  = 'Y' 
   IF cl_null(r_pmdl.pmdl022) THEN
      SELECT pmac002 INTO r_pmdl.pmdl022
        FROM pmac_t
       WHERE pmacent  = g_enterprise
         AND pmac001  = r_pmdl.pmdl004
         AND pmac003  = '2'
         AND pmacstus = 'Y'
         AND rownum  = 1
      IF cl_null(r_pmdl.pmdl022) THEN
         LET r_pmdl.pmdl022 = r_pmdl.pmdl004
      END IF
   END IF

   #抓取交易對象聯絡人明細檔的聯絡對像識別碼顯示在採購單上的[C:供應商連絡人]，
   #若有設置多個聯絡人時，則取有勾選主要聯絡人的那一個
   LET r_pmdl.pmdl027 = ''
   SELECT pmaj002 INTO r_pmdl.pmdl027
     FROM pmaj_t
    WHERE pmajent  = g_enterprise
      AND pmaj001  = r_pmdl.pmdl004
      AND pmajstus = 'Y'
      AND pmaj004  = 'Y' 
   IF cl_null(r_pmdl.pmdl022) THEN
      SELECT pmaj002 INTO r_pmdl.pmdl027
        FROM pmaj_t
       WHERE pmajent  = g_enterprise
         AND pmaj001  = r_pmdl.pmdl004
         AND pmajstus = 'Y'
         AND pmaj004  = 'Y'
         AND rownum   = 1
   END IF

   RETURN r_pmdl.*
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsp610_03_pmdl003_chk(p_pmdl003,p_pmdldocdt)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_03_pmdl003_chk(p_pmdl003,p_pmdldocdt)
   DEFINE p_pmdl003     LIKE pmdl_t.pmdl003
   DEFINE p_pmdldocdt   LIKE pmdl_t.pmdldocdt
   DEFINE l_ooegstus    LIKE ooeg_t.ooegstus
   DEFINE l_ooeg006     LIKE ooeg_t.ooeg006
   DEFINE l_ooeg007     LIKE ooeg_t.ooeg007 
   
   WHENEVER ERROR CONTINUE 

   LET g_errno    = ''
   LET l_ooegstus = ''
   LET l_ooeg006  = ''
   LET l_ooeg007  = ''

   SELECT ooeg006,ooeg007,ooegstus INTO l_ooeg006,l_ooeg007,l_ooegstus
     FROM ooeg_t
    WHERE ooeg001 = p_pmdl003
      AND ooegent = g_enterprise

   CASE
      WHEN SQLCA.sqlcode = 100     LET g_errno = 'aoo-00008'     #輸入的資料不存在部門  
      WHEN l_ooegstus <> 'Y'       LET g_errno = 'sub-01302'     #輸入的資料無效！ 
      WHEN l_ooeg006 > p_pmdldocdt LET g_errno = 'aoo-00201'     #輸入的資料不存在日期範圍內的 部門資料檔 中！  
      WHEN (l_ooeg007 IS NOT NULL AND l_ooeg007 <= p_pmdldocdt)
         LET g_errno = 'aoo-00201'     #輸入的資料不存在[日期範圍內的部門資料檔]中！
      OTHERWISE
         LET g_errno = SQLCA.sqlcode USING '------'
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsp610_03_pmdl027_chk(p_pmdl004,p_pmdl027)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_03_pmdl027_chk(p_pmdl004,p_pmdl027)
   DEFINE p_pmdl004     LIKE pmdl_t.pmdl004
   DEFINE p_pmdl027     LIKE pmdl_t.pmdl027
   DEFINE l_pmajstus    LIKE pmaj_t.pmajstus 
   
   WHENEVER ERROR CONTINUE 

   LET g_errno = ''
   LET l_pmajstus = ''

   SELECT pmajstus INTO l_pmajstus
     FROM pmaj_t
    WHERE pmajent = g_enterprise
      AND pmaj001 = p_pmdl004
      AND pmaj002 = p_pmdl027

   CASE
      WHEN SQLCA.sqlcode = 100     LET g_errno = 'apm-00256'    #輸入的資料不存在  
      WHEN l_pmajstus <> 'Y'       LET g_errno = 'sub-01302'    #輸入的資料無效！ 
      OTHERWISE                    LET g_errno = SQLCA.sqlcode USING '------'
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsp610_03_pmdl009_chk(p_pmdl004,p_pmdl009)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_03_pmdl009_chk(p_pmdl004,p_pmdl009)
   DEFINE p_pmdl004     LIKE pmdl_t.pmdl004
   DEFINE p_pmdl009     LIKE pmdl_t.pmdl009
   DEFINE l_pmad003     LIKE pmad_t.pmad003
   DEFINE l_pmadstus    LIKE pmad_t.pmadstus 
   
   WHENEVER ERROR CONTINUE 

   LET g_errno = ''
   LET l_pmad003 = ''
   LET l_pmadstus = ''

   SELECT pmad003,l_pmadstus INTO l_pmad003,l_pmadstus
     FROM pmad_t
    WHERE pmadent = g_enterprise
      AND pmad001 = p_pmdl004
      AND pmad002 = p_pmdl009

   CASE
      WHEN SQLCA.sqlcode = 100      LET g_errno = 'apm-00231' #輸入資料不存在付款條件檔中！  
      WHEN l_pmad003 <> '1'         LET g_errno = 'apm-00224' #該供應商未設定允許付款條件(即輸入的資料類型pmad003<>'1',付款條件)！ 
      WHEN l_pmadstus <> 'Y'        LET g_errno = 'apm-00230' #輸入的資料在當前供應商中的允許付款條件中無效！  
      OTHERWISE                     LET g_errno = SQLCA.sqlcode USING '------'
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsp610_03_pmdl011_chk(p_pmdl011)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_03_pmdl011_chk(p_pmdl011)
   DEFINE p_pmdl011     LIKE pmdl_t.pmdl011
   DEFINE l_oodbstus    LIKE oodb_t.oodbstus 
   
   WHENEVER ERROR CONTINUE 

   LET g_errno = ''
   LET l_oodbstus = ''

   SELECT oodbstus INTO l_oodbstus
     FROM ooef_t,oodb_t
    WHERE oodbent = g_enterprise
      AND oodb001 = ooef019
      AND ooefent = g_enterprise
      AND ooef001 = g_site
      AND oodb002 = p_pmdl011

   CASE
      WHEN SQLCA.sqlcode = 100       LET g_errno = 'aoo-00222'      #輸入的資料不存在與 稅別基本資料檔 中！  
      WHEN l_oodbstus <> 'Y'         LET g_errno = 'sub-01302'      #輸入資料無效！  
      OTHERWISE                      LET g_errno = SQLCA.sqlcode USING '------'
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsp610_03_pmdl033_chk(p_ooef019,p_pmdl033)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_03_pmdl033_chk(p_ooef019,p_pmdl033)
   DEFINE p_ooef019     LIKE ooef_t.ooef019
   DEFINE p_pmdl033     LIKE pmdl_t.pmdl033
   DEFINE l_isac003     LIKE isac_t.isac003
   DEFINE l_isacstus    LIKE isac_t.isacstus 
   
   WHENEVER ERROR CONTINUE 

   LET g_errno    = ''
   LET l_isac003  = ''
   LET l_isacstus = ''

   SELECT isac003,isacstus INTO l_isac003,l_isacstus
     FROM isac_t
    WHERE isacent = g_enterprise
      AND isac001 = p_ooef019
      AND isac002 = p_pmdl033

   CASE
      WHEN SQLCA.sqlcode = 100      LET g_errno = 'ais-00021'
      WHEN l_isacstus <> 'Y'        LET g_errno = 'ais-00022'     #輸入的資料在[發票類型維護檔]中無效,請檢查！ 
      WHEN l_isac003 <> '1'         LET g_errno = 'ais-00058'     #輸入資料的發票歸屬進銷項不為 1:進項發票！ 
      OTHERWISE                     LET g_errno = SQLCA.sqlcode USING '------'
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsp610_03_pmdl015_chk(p_pmdl015)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_03_pmdl015_chk(p_pmdl015)
   DEFINE p_pmdl015     LIKE pmdl_t.pmdl015
   DEFINE l_ooajstus    LIKE ooaj_t.ooajstus 
   
   WHENEVER ERROR CONTINUE 

   LET g_errno    = ''
   LET l_ooajstus = ''

   SELECT ooajstus INTO l_ooajstus
     FROM ooef_t,ooaj_t
    WHERE ooefent = ooajent
      AND ooefent = g_enterprise
      AND ooef001 = g_site
      AND ooef014 = ooaj001
      AND ooaj002 = p_pmdl015

   CASE
      WHEN SQLCA.sqlcode = 100      LET g_errno = 'aoo-00175'       #輸入的資料不存在於 使用幣別設定檔 中！  
      WHEN l_ooajstus <> 'Y'        LET g_errno = 'sub-01302'       #輸入的資料無效！  
      OTHERWISE                     LET g_errno = SQLCA.sqlcode USING '------'
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsp610_03_pmdl017_chk(p_pmdl017)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_03_pmdl017_chk(p_pmdl017)
   DEFINE p_pmdl017      LIKE pmdl_t.pmdl017
   DEFINE l_pmamstus     LIKE pmam_t.pmamstus 
   
   WHENEVER ERROR CONTINUE 

   LET g_errno    = ''
   LET l_pmamstus = ''

   SELECT pmamstus INTO l_pmamstus
     FROM pmam_t
    WHERE pmament = g_enterprise
      AND pmam001 = p_pmdl017

   CASE
      WHEN SQLCA.sqlcode = 100     LET g_errno = 'apm-00209'         #輸入的資料不存在於 採購取價方式單頭檔 中！  
      WHEN l_pmamstus <> 'Y'       LET g_errno = 'sub-01302'         #輸入的資料無效！  
      OTHERWISE                    LET g_errno = SQLCA.sqlcode USING '------'
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsp610_03_pmdl018_chk(p_pmdl018)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_03_pmdl018_chk(p_pmdl018)
   DEFINE p_pmdl018      LIKE pmdl_t.pmdl018
   DEFINE l_ooid002      LIKE ooid_t.ooid002
   DEFINE l_ooidstus     LIKE ooid_t.ooidstus 
   
   WHENEVER ERROR CONTINUE 

   LET g_errno    = ''
   LET l_ooid002  = ''
   LET l_ooidstus = ''

   SELECT ooid002,ooidstus INTO l_ooid002,l_ooidstus
     FROM ooid_t
    WHERE ooident = g_enterprise
      AND ooid001 = p_pmdl018

   CASE
      WHEN SQLCA.sqlcode = 100    LET g_errno = 'aoo-00193'     #輸入資料不存在[繳款優惠條件設定檔]中！
      WHEN l_ooidstus <> 'Y'      LET g_errno = 'sub-01302'     #輸入的資料無效！
      WHEN l_ooid002 = '2'        LET g_errno = 'apm-00262'     #輸入的優惠條件不適用於付款條件！
      OTHERWISE                   LET g_errno = SQLCA.sqlcode USING '------'
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsp610_03_pmdl020_chk(p_pmdl020)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_03_pmdl020_chk(p_pmdl020)
   DEFINE p_pmdl020     LIKE pmdl_t.pmdl020
   DEFINE l_oocqstus    LIKE oocq_t.oocqstus 
   
   WHENEVER ERROR CONTINUE 

   LET g_errno    = ''
   LET l_oocqstus = ''

   SELECT oocqstus INTO l_oocqstus
     FROM oocq_t
    WHERE oocqent = g_enterprise
      AND oocq001 = '263'
      AND oocq002 = p_pmdl020

   CASE
      WHEN SQLCA.sqlcode = 100     LET g_errno = 'axm-00037'     #輸入的資料不存在於[運輸方式基本資料檔]中！
      WHEN l_oocqstus <> 'Y'       LET g_errno = 'axm-00038'     #此筆資料已無效！
      OTHERWISE                    LET g_errno = SQLCA.sqlcode USING '------'
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsp610_03_pmdl025_chk(p_oofa001,p_pmdl025)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_03_pmdl025_chk(p_oofa001,p_pmdl025)
   DEFINE p_oofa001     LIKE oofa_t.oofa001
   DEFINE p_pmdl025     LIKE pmdl_t.pmdl025
   DEFINE l_oofbstus    LIKE oofb_t.oofbstus
   DEFINE l_oofb008     LIKE oofb_t.oofb008 
   
   WHENEVER ERROR CONTINUE 

   LET g_errno    = ''
   LET l_oofbstus = ''
   LET l_oofb008  = ''

   SELECT oofbstus,oofb008 INTO l_oofbstus,l_oofb008
     FROM oofb_t
    WHERE oofbent = g_enterprise
      AND oofb002 = p_oofa001
      AND oofb019 = p_pmdl025

   CASE
      WHEN SQLCA.sqlcode = 100     LET g_errno = 'apm-00214'     #輸入的資料不存在於[聯絡地址檔]中！
      WHEN l_oofbstus <> 'Y'       LET g_errno = 'sub-01302'     #輸入的資料無效！
      WHEN l_oofb008 <> '3'        LET g_errno = 'apm-00269'     #輸入的類別地址不為[3.出貨地址]！
      OTHERWISE                    LET g_errno = SQLCA.sqlcode USING '------'
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsp610_03_pmdl026_chk(p_oofa001,p_pmdl026)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_03_pmdl026_chk(p_oofa001,p_pmdl026)
   DEFINE p_oofa001     LIKE oofa_t.oofa001
   DEFINE p_pmdl026     LIKE pmdl_t.pmdl026
   DEFINE l_oofbstus    LIKE oofb_t.oofbstus
   DEFINE l_oofb008     LIKE oofb_t.oofb008 
   
   WHENEVER ERROR CONTINUE 

   LET g_errno = ''
   LET l_oofbstus = ''
   LET l_oofb008 = ''

   SELECT oofbstus,oofb008 INTO l_oofbstus,l_oofb008
     FROM oofb_t
    WHERE oofbent = g_enterprise
      AND oofb002 = p_oofa001
      AND oofb019 = p_pmdl026

   CASE
      WHEN SQLCA.sqlcode = 100    LET g_errno = 'apm-00214'     #輸入的資料不存在於[聯絡地址檔]中！
      WHEN l_oofbstus <> 'Y'      LET g_errno = 'sub-01302'     #輸入的資料無效！
      WHEN l_oofb008 <> '5'       LET g_errno = 'apm-00270'     #輸入的類別地址不為[5.發票地址]！
      OTHERWISE                   LET g_errno = SQLCA.sqlcode USING '------'
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsp610_03_pmdl032_chk(p_pmdl032)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_03_pmdl032_chk(p_pmdl032)
   DEFINE p_pmdl032     LIKE pmdl_t.pmdl032
   DEFINE l_pmaastus    LIKE pmaa_t.pmaastus 
   
   WHENEVER ERROR CONTINUE 

   LET g_errno = ''
   LET l_pmaastus = ''

   SELECT pmaastus INTO l_pmaastus
     FROM pmaa_t
    WHERE pmaa001 = p_pmdl032
      AND pmaaent = g_enterprise
      AND (pmaa002 = '2' OR pmaa002 = '3')

   CASE
      WHEN SQLCA.sqlcode = 100      LET g_errno = 'apm-00026'     #輸入的資料不存在於交易對象類別為[2:客戶]或者[3:交易對象]的交易資料檔中！
      WHEN l_pmaastus <> 'Y'        LET g_errno = 'sub-01302'     #輸入的資料未確認或已無效！
      OTHERWISE                     LET g_errno = SQLCA.sqlcode USING '------'
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsp610_03_ins_pmdn(p_keyno,p_pmdl004,p_pmdldocno,p_pmal002)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........: 160512-00016#5  2016/06/01 by ming 加入保稅
################################################################################
PUBLIC FUNCTION apsp610_03_ins_pmdn(p_keyno,p_pmdl004,p_pmdl025,p_pmdl026,p_pmdldocno,p_pmal002)
   DEFINE p_keyno     LIKE type_t.num10
   DEFINE p_pmdl004   LIKE pmdl_t.pmdl004 
   DEFINE p_pmdl025   LIKE pmdl_t.pmdl025
   DEFINE p_pmdl026   LIKE pmdl_t.pmdl026
   DEFINE p_pmdldocno LIKE pmdl_t.pmdldocno
   DEFINE p_pmal002   LIKE pmal_t.pmal002
   DEFINE l_sql       STRING
   DEFINE l_pmdn_tmp  type_g_pmdn_d
   #mod--161109-00085#14 By 08993--(s)
#   DEFINE l_pmdn      RECORD LIKE pmdn_t.*   #mark--161109-00085#14 By 08993--(s) 
   DEFINE l_pmdn RECORD  #採購單身明細檔
          pmdnent LIKE pmdn_t.pmdnent, #企業編號
          pmdnsite LIKE pmdn_t.pmdnsite, #營運據點
          pmdnunit LIKE pmdn_t.pmdnunit, #應用組織
          pmdndocno LIKE pmdn_t.pmdndocno, #採購單號
          pmdnseq LIKE pmdn_t.pmdnseq, #項次
          pmdn001 LIKE pmdn_t.pmdn001, #料件編號
          pmdn002 LIKE pmdn_t.pmdn002, #產品特徵
          pmdn003 LIKE pmdn_t.pmdn003, #包裝容器
          pmdn004 LIKE pmdn_t.pmdn004, #作業編號
          pmdn005 LIKE pmdn_t.pmdn005, #作業序
          pmdn006 LIKE pmdn_t.pmdn006, #採購單位
          pmdn007 LIKE pmdn_t.pmdn007, #採購數量
          pmdn008 LIKE pmdn_t.pmdn008, #參考單位
          pmdn009 LIKE pmdn_t.pmdn009, #參考數量
          pmdn010 LIKE pmdn_t.pmdn010, #計價單位
          pmdn011 LIKE pmdn_t.pmdn011, #計價數量
          pmdn012 LIKE pmdn_t.pmdn012, #出貨日期
          pmdn013 LIKE pmdn_t.pmdn013, #到廠日期
          pmdn014 LIKE pmdn_t.pmdn014, #到庫日期
          pmdn015 LIKE pmdn_t.pmdn015, #單價
          pmdn016 LIKE pmdn_t.pmdn016, #稅別
          pmdn017 LIKE pmdn_t.pmdn017, #稅率
          pmdn019 LIKE pmdn_t.pmdn019, #子件特性
          pmdn020 LIKE pmdn_t.pmdn020, #緊急度
          pmdn021 LIKE pmdn_t.pmdn021, #保稅
          pmdn022 LIKE pmdn_t.pmdn022, #部分交貨
          pmdnorga LIKE pmdn_t.pmdnorga, #付款據點
          pmdn023 LIKE pmdn_t.pmdn023, #送貨供應商
          pmdn024 LIKE pmdn_t.pmdn024, #多交期
          pmdn025 LIKE pmdn_t.pmdn025, #收貨地址編號
          pmdn026 LIKE pmdn_t.pmdn026, #帳款地址編號
          pmdn027 LIKE pmdn_t.pmdn027, #供應商料號
          pmdn028 LIKE pmdn_t.pmdn028, #收貨庫位
          pmdn029 LIKE pmdn_t.pmdn029, #收貨儲位
          pmdn030 LIKE pmdn_t.pmdn030, #收貨批號
          pmdn031 LIKE pmdn_t.pmdn031, #運輸方式
          pmdn032 LIKE pmdn_t.pmdn032, #取貨模式
          pmdn033 LIKE pmdn_t.pmdn033, #備品率
          pmdn034 LIKE pmdn_t.pmdn034, #no use
          pmdn035 LIKE pmdn_t.pmdn035, #價格核決
          pmdn036 LIKE pmdn_t.pmdn036, #專案編號
          pmdn037 LIKE pmdn_t.pmdn037, #WBS編號
          pmdn038 LIKE pmdn_t.pmdn038, #活動編號
          pmdn039 LIKE pmdn_t.pmdn039, #費用原因
          pmdn040 LIKE pmdn_t.pmdn040, #取價來源
          pmdn041 LIKE pmdn_t.pmdn041, #價格參考單號
          pmdn042 LIKE pmdn_t.pmdn042, #價格參考項次
          pmdn043 LIKE pmdn_t.pmdn043, #取出價格
          pmdn044 LIKE pmdn_t.pmdn044, #價差比
          pmdn045 LIKE pmdn_t.pmdn045, #行狀態
          pmdn046 LIKE pmdn_t.pmdn046, #未稅金額
          pmdn047 LIKE pmdn_t.pmdn047, #含稅金額
          pmdn048 LIKE pmdn_t.pmdn048, #稅額
          pmdn049 LIKE pmdn_t.pmdn049, #理由碼
          pmdn050 LIKE pmdn_t.pmdn050, #備註
          pmdn051 LIKE pmdn_t.pmdn051, #留置/結案理由碼
          pmdn052 LIKE pmdn_t.pmdn052, #檢驗否
          pmdn053 LIKE pmdn_t.pmdn053, #庫存管理特徵
          pmdn200 LIKE pmdn_t.pmdn200, #商品條碼
          pmdn201 LIKE pmdn_t.pmdn201, #包裝單位
          pmdn202 LIKE pmdn_t.pmdn202, #包裝數量
          pmdn203 LIKE pmdn_t.pmdn203, #收貨部門
          pmdn204 LIKE pmdn_t.pmdn204, #No Use
          pmdn205 LIKE pmdn_t.pmdn205, #要貨組織
          pmdn206 LIKE pmdn_t.pmdn206, #庫存量
          pmdn207 LIKE pmdn_t.pmdn207, #採購在途量
          pmdn208 LIKE pmdn_t.pmdn208, #前日銷售量
          pmdn209 LIKE pmdn_t.pmdn209, #上月銷量
          pmdn210 LIKE pmdn_t.pmdn210, #第一週銷量
          pmdn211 LIKE pmdn_t.pmdn211, #第二週銷量
          pmdn212 LIKE pmdn_t.pmdn212, #第三週銷量
          pmdn213 LIKE pmdn_t.pmdn213, #第四週銷量
          pmdn214 LIKE pmdn_t.pmdn214, #採購通路
          pmdn215 LIKE pmdn_t.pmdn215, #通路性質
          pmdn216 LIKE pmdn_t.pmdn216, #經營方式
          pmdn217 LIKE pmdn_t.pmdn217, #結算方式
          pmdn218 LIKE pmdn_t.pmdn218, #合約編號
          pmdn219 LIKE pmdn_t.pmdn219, #協議編號
          pmdn220 LIKE pmdn_t.pmdn220, #採購人員
          pmdn221 LIKE pmdn_t.pmdn221, #採購部門
          pmdn222 LIKE pmdn_t.pmdn222, #採購中心
          pmdn223 LIKE pmdn_t.pmdn223, #配送中心
          pmdn224 LIKE pmdn_t.pmdn224, #採購失效日
          pmdn900 LIKE pmdn_t.pmdn900, #保留欄位str
          pmdn999 LIKE pmdn_t.pmdn999, #保留欄位end
          #161109-00085#61 --s add
          pmdnud001 LIKE pmdn_t.pmdnud001, #自定義欄位(文字)001
          pmdnud002 LIKE pmdn_t.pmdnud002, #自定義欄位(文字)002
          pmdnud003 LIKE pmdn_t.pmdnud003, #自定義欄位(文字)003
          pmdnud004 LIKE pmdn_t.pmdnud004, #自定義欄位(文字)004
          pmdnud005 LIKE pmdn_t.pmdnud005, #自定義欄位(文字)005
          pmdnud006 LIKE pmdn_t.pmdnud006, #自定義欄位(文字)006
          pmdnud007 LIKE pmdn_t.pmdnud007, #自定義欄位(文字)007
          pmdnud008 LIKE pmdn_t.pmdnud008, #自定義欄位(文字)008
          pmdnud009 LIKE pmdn_t.pmdnud009, #自定義欄位(文字)009
          pmdnud010 LIKE pmdn_t.pmdnud010, #自定義欄位(文字)010
          pmdnud011 LIKE pmdn_t.pmdnud011, #自定義欄位(數字)011
          pmdnud012 LIKE pmdn_t.pmdnud012, #自定義欄位(數字)012
          pmdnud013 LIKE pmdn_t.pmdnud013, #自定義欄位(數字)013
          pmdnud014 LIKE pmdn_t.pmdnud014, #自定義欄位(數字)014
          pmdnud015 LIKE pmdn_t.pmdnud015, #自定義欄位(數字)015
          pmdnud016 LIKE pmdn_t.pmdnud016, #自定義欄位(數字)016
          pmdnud017 LIKE pmdn_t.pmdnud017, #自定義欄位(數字)017
          pmdnud018 LIKE pmdn_t.pmdnud018, #自定義欄位(數字)018
          pmdnud019 LIKE pmdn_t.pmdnud019, #自定義欄位(數字)019
          pmdnud020 LIKE pmdn_t.pmdnud020, #自定義欄位(數字)020
          pmdnud021 LIKE pmdn_t.pmdnud021, #自定義欄位(日期時間)021
          pmdnud022 LIKE pmdn_t.pmdnud022, #自定義欄位(日期時間)022
          pmdnud023 LIKE pmdn_t.pmdnud023, #自定義欄位(日期時間)023
          pmdnud024 LIKE pmdn_t.pmdnud024, #自定義欄位(日期時間)024
          pmdnud025 LIKE pmdn_t.pmdnud025, #自定義欄位(日期時間)025
          pmdnud026 LIKE pmdn_t.pmdnud026, #自定義欄位(日期時間)026
          pmdnud027 LIKE pmdn_t.pmdnud027, #自定義欄位(日期時間)027
          pmdnud028 LIKE pmdn_t.pmdnud028, #自定義欄位(日期時間)028
          pmdnud029 LIKE pmdn_t.pmdnud029, #自定義欄位(日期時間)029
          pmdnud030 LIKE pmdn_t.pmdnud030, #自定義欄位(日期時間)030
          #161109-00085#61 --e add
          pmdn225 LIKE pmdn_t.pmdn225, #最終收貨組織
          pmdn054 LIKE pmdn_t.pmdn054, #還料數量
          pmdn055 LIKE pmdn_t.pmdn055, #還量參考數量
          pmdn056 LIKE pmdn_t.pmdn056, #還價數量
          pmdn057 LIKE pmdn_t.pmdn057, #還價參考數量
          pmdn226 LIKE pmdn_t.pmdn226, #長效期每次送貨量
          pmdn227 LIKE pmdn_t.pmdn227, #補貨規格說明
          pmdn058 LIKE pmdn_t.pmdn058, #預算科目
          pmdn228 LIKE pmdn_t.pmdn228  #商品品類
   END RECORD
   #mod--161109-00085#14 By 08993--(e)
   DEFINE l_success   LIKE type_t.num5
   #mod--161109-00085#14 By 08993--(s)
#   DEFINE l_pmdl       RECORD LIKE  pmdl_t.*   #mark--161109-00085#14 By 08993--(s) 
    DEFINE l_pmdl RECORD  #採購單頭檔
          pmdlent LIKE pmdl_t.pmdlent, #企業編號
          pmdlsite LIKE pmdl_t.pmdlsite, #營運據點
          pmdlunit LIKE pmdl_t.pmdlunit, #應用組織
          pmdldocno LIKE pmdl_t.pmdldocno, #採購單號
          pmdldocdt LIKE pmdl_t.pmdldocdt, #採購日期
          pmdl001 LIKE pmdl_t.pmdl001, #版次
          pmdl002 LIKE pmdl_t.pmdl002, #採購人員
          pmdl003 LIKE pmdl_t.pmdl003, #採購部門
          pmdl004 LIKE pmdl_t.pmdl004, #供應商編號
          pmdl005 LIKE pmdl_t.pmdl005, #採購性質
          pmdl006 LIKE pmdl_t.pmdl006, #多角性質
          pmdl007 LIKE pmdl_t.pmdl007, #資料來源類型
          pmdl008 LIKE pmdl_t.pmdl008, #來源單號
          pmdl009 LIKE pmdl_t.pmdl009, #付款條件
          pmdl010 LIKE pmdl_t.pmdl010, #交易條件
          pmdl011 LIKE pmdl_t.pmdl011, #稅別
          pmdl012 LIKE pmdl_t.pmdl012, #稅率
          pmdl013 LIKE pmdl_t.pmdl013, #單價含稅否
          pmdl015 LIKE pmdl_t.pmdl015, #幣別
          pmdl016 LIKE pmdl_t.pmdl016, #匯率
          pmdl017 LIKE pmdl_t.pmdl017, #取價方式
          pmdl018 LIKE pmdl_t.pmdl018, #付款優惠條件
          pmdl019 LIKE pmdl_t.pmdl019, #納入APS計算
          pmdl020 LIKE pmdl_t.pmdl020, #運送方式
          pmdl021 LIKE pmdl_t.pmdl021, #付款供應商
          pmdl022 LIKE pmdl_t.pmdl022, #送貨供應商
          pmdl023 LIKE pmdl_t.pmdl023, #採購分類一
          pmdl024 LIKE pmdl_t.pmdl024, #採購分類二
          pmdl025 LIKE pmdl_t.pmdl025, #送貨地址
          pmdl026 LIKE pmdl_t.pmdl026, #帳款地址
          pmdl027 LIKE pmdl_t.pmdl027, #供應商連絡人
          pmdl028 LIKE pmdl_t.pmdl028, #一次性交易對象識別碼
          pmdl029 LIKE pmdl_t.pmdl029, #收貨部門
          pmdl030 LIKE pmdl_t.pmdl030, #多角貿易已拋轉
          pmdl031 LIKE pmdl_t.pmdl031, #多角序號
          pmdl032 LIKE pmdl_t.pmdl032, #最終客戶
          pmdl033 LIKE pmdl_t.pmdl033, #發票類型
          pmdl040 LIKE pmdl_t.pmdl040, #採購總未稅金額
          pmdl041 LIKE pmdl_t.pmdl041, #採購總含稅金額
          pmdl042 LIKE pmdl_t.pmdl042, #採購總稅額
          pmdl043 LIKE pmdl_t.pmdl043, #留置原因
          pmdl044 LIKE pmdl_t.pmdl044, #備註
          pmdl046 LIKE pmdl_t.pmdl046, #預付款發票開立方式
          pmdl047 LIKE pmdl_t.pmdl047, #物流結案
          pmdl048 LIKE pmdl_t.pmdl048, #帳流結案
          pmdl049 LIKE pmdl_t.pmdl049, #金流結案
          pmdl050 LIKE pmdl_t.pmdl050, #多角最終站否
          pmdl051 LIKE pmdl_t.pmdl051, #多角流程編號
          pmdl052 LIKE pmdl_t.pmdl052, #最終供應商
          pmdl053 LIKE pmdl_t.pmdl053, #兩角目的據點
          pmdl054 LIKE pmdl_t.pmdl054, #內外購
          pmdl055 LIKE pmdl_t.pmdl055, #匯率計算基準
          pmdl200 LIKE pmdl_t.pmdl200, #採購中心
          pmdl201 LIKE pmdl_t.pmdl201, #聯絡電話
          pmdl202 LIKE pmdl_t.pmdl202, #傳真號碼
          pmdl203 LIKE pmdl_t.pmdl203, #採購方式
          pmdl204 LIKE pmdl_t.pmdl204, #配送中心
          pmdl900 LIKE pmdl_t.pmdl900, #保留欄位str
          pmdl999 LIKE pmdl_t.pmdl999, #保留欄位end
          pmdlownid LIKE pmdl_t.pmdlownid, #資料所有者
          pmdlowndp LIKE pmdl_t.pmdlowndp, #資料所屬部門
          pmdlcrtid LIKE pmdl_t.pmdlcrtid, #資料建立者
          pmdlcrtdp LIKE pmdl_t.pmdlcrtdp, #資料建立部門
          pmdlcrtdt LIKE pmdl_t.pmdlcrtdt, #資料創建日
          pmdlmodid LIKE pmdl_t.pmdlmodid, #資料修改者
          pmdlmoddt LIKE pmdl_t.pmdlmoddt, #最近修改日
          pmdlcnfid LIKE pmdl_t.pmdlcnfid, #資料確認者
          pmdlcnfdt LIKE pmdl_t.pmdlcnfdt, #資料確認日
          pmdlpstid LIKE pmdl_t.pmdlpstid, #資料過帳者
          pmdlpstdt LIKE pmdl_t.pmdlpstdt, #資料過帳日
          pmdlstus LIKE pmdl_t.pmdlstus, #狀態碼
          #161109-00085#61 --s add
          pmdlud001 LIKE pmdl_t.pmdlud001, #自定義欄位(文字)001
          pmdlud002 LIKE pmdl_t.pmdlud002, #自定義欄位(文字)002
          pmdlud003 LIKE pmdl_t.pmdlud003, #自定義欄位(文字)003
          pmdlud004 LIKE pmdl_t.pmdlud004, #自定義欄位(文字)004
          pmdlud005 LIKE pmdl_t.pmdlud005, #自定義欄位(文字)005
          pmdlud006 LIKE pmdl_t.pmdlud006, #自定義欄位(文字)006
          pmdlud007 LIKE pmdl_t.pmdlud007, #自定義欄位(文字)007
          pmdlud008 LIKE pmdl_t.pmdlud008, #自定義欄位(文字)008
          pmdlud009 LIKE pmdl_t.pmdlud009, #自定義欄位(文字)009
          pmdlud010 LIKE pmdl_t.pmdlud010, #自定義欄位(文字)010
          pmdlud011 LIKE pmdl_t.pmdlud011, #自定義欄位(數字)011
          pmdlud012 LIKE pmdl_t.pmdlud012, #自定義欄位(數字)012
          pmdlud013 LIKE pmdl_t.pmdlud013, #自定義欄位(數字)013
          pmdlud014 LIKE pmdl_t.pmdlud014, #自定義欄位(數字)014
          pmdlud015 LIKE pmdl_t.pmdlud015, #自定義欄位(數字)015
          pmdlud016 LIKE pmdl_t.pmdlud016, #自定義欄位(數字)016
          pmdlud017 LIKE pmdl_t.pmdlud017, #自定義欄位(數字)017
          pmdlud018 LIKE pmdl_t.pmdlud018, #自定義欄位(數字)018
          pmdlud019 LIKE pmdl_t.pmdlud019, #自定義欄位(數字)019
          pmdlud020 LIKE pmdl_t.pmdlud020, #自定義欄位(數字)020
          pmdlud021 LIKE pmdl_t.pmdlud021, #自定義欄位(日期時間)021
          pmdlud022 LIKE pmdl_t.pmdlud022, #自定義欄位(日期時間)022
          pmdlud023 LIKE pmdl_t.pmdlud023, #自定義欄位(日期時間)023
          pmdlud024 LIKE pmdl_t.pmdlud024, #自定義欄位(日期時間)024
          pmdlud025 LIKE pmdl_t.pmdlud025, #自定義欄位(日期時間)025
          pmdlud026 LIKE pmdl_t.pmdlud026, #自定義欄位(日期時間)026
          pmdlud027 LIKE pmdl_t.pmdlud027, #自定義欄位(日期時間)027
          pmdlud028 LIKE pmdl_t.pmdlud028, #自定義欄位(日期時間)028
          pmdlud029 LIKE pmdl_t.pmdlud029, #自定義欄位(日期時間)029
          pmdlud030 LIKE pmdl_t.pmdlud030, #自定義欄位(日期時間)030
          #161109-00085#61 --e add
          pmdl205 LIKE pmdl_t.pmdl205, #採購最終有效日
          pmdl206 LIKE pmdl_t.pmdl206, #長效期訂單否
          pmdl207 LIKE pmdl_t.pmdl207, #所屬品類
          pmdl208 LIKE pmdl_t.pmdl208  #電子採購單號
   END RECORD
   #mod--161109-00085#14 By 08993--(e)   
   DEFINE l_imaf173   LIKE imaf_t.imaf173
   DEFINE l_imaf174   LIKE imaf_t.imaf174
   DEFINE l_pmam004   LIKE pmam_t.pmam004
   DEFINE l_pmam005   LIKE pmam_t.pmam005
   DEFINE l_pmam006   LIKE pmam_t.pmam006
   DEFINE l_flag      LIKE type_t.num5
   DEFINE l_desc      LIKE type_t.chr80
   DEFINE l_errno     LIKE type_t.chr10          #錯誤訊息代碼 

   DEFINE l_pmdn003   LIKE pmdn_t.pmdn003    #包裝容器   
   DEFINE l_pmdn019   LIKE pmdn_t.pmdn019    #子件特性  
   DEFINE l_pmdn020   LIKE pmdn_t.pmdn020    #緊急度  
   #160512-00016#5 20160601 mark -----(S) 
   #DEFINE l_pmdn021   LIKE pmdn_t.pmdn021    #保稅  
   #160512-00016#5 20160601 mark -----(E) 
   DEFINE l_pmdn022   LIKE pmdn_t.pmdn022    #部分交貨  
   DEFINE l_pmdn024   LIKE pmdn_t.pmdn024    #多交期  
   DEFINE l_pmdn027   LIKE pmdn_t.pmdn027    #供應商料號  
   DEFINE l_pmdn028   LIKE pmdn_t.pmdn028    #收貨庫位  
   DEFINE l_pmdn029   LIKE pmdn_t.pmdn029    #收貨儲位 
   DEFINE l_pmdn032   LIKE pmdn_t.pmdn032    #取貨模式 
   DEFINE l_pmdn033   LIKE pmdn_t.pmdn033    #備品率  
   DEFINE l_pmdn035   LIKE pmdn_t.pmdn035    #價格核決 
   DEFINE l_pmdn041   LIKE pmdn_t.pmdn041    #價格來源單號
   DEFINE l_pmdn042   LIKE pmdn_t.pmdn042    #價格來源項次 
   
   DEFINE l_pmdn045   LIKE pmdn_t.pmdn045    #行狀態 
   DEFINE l_pmdn046   LIKE pmdn_t.pmdn046    #未稅金額 
   DEFINE l_pmdn047   LIKE pmdn_t.pmdn047    #含稅金額  
   DEFINE l_pmdn048   LIKE pmdn_t.pmdn048    #稅額 
   DEFINE l_pmdnunit  LIKE pmdn_t.pmdnunit   #收貨據點  
   DEFINE l_pmdnorga  LIKE pmdn_t.pmdnorga   #付款據點  
   DEFINE l_str       STRING  
   
   WHENEVER ERROR CONTINUE 

   INITIALIZE l_pmdl.* TO NULL
   #160902-00048#1-s-mod
   #SELECT * INTO l_pmdl.* FROM pmdl_t WHERE pmdldocno = p_pmdldocno
   #mod--161109-00085#14 By 08993--(s)
#   SELECT * INTO l_pmdl.* FROM pmdl_t WHERE pmdlent = g_enterprise AND pmdldocno = p_pmdldocno   #mark--161109-00085#14 By 08993--(s)
   #161109-00085#61 --s mark
   #SELECT pmdlent,pmdlsite,pmdlunit,pmdldocno,pmdldocdt,pmdl001,pmdl002,pmdl003,pmdl004,pmdl005,pmdl006,pmdl007,pmdl008,
   #       pmdl009,pmdl010,pmdl011,pmdl012,pmdl013,pmdl015,pmdl016,pmdl017,pmdl018,pmdl019,pmdl020,pmdl021,pmdl022,pmdl023,
   #       pmdl024,pmdl025,pmdl026,pmdl027,pmdl028,pmdl029,pmdl030,pmdl031,pmdl032,pmdl033,pmdl040,pmdl041,pmdl042,pmdl043,
   #       pmdl044,pmdl046,pmdl047,pmdl048,pmdl049,pmdl050,pmdl051,pmdl052,pmdl053,pmdl054,pmdl055,pmdl200,pmdl201,pmdl202,
   #       pmdl203,pmdl204,pmdl900,pmdl999,pmdlownid,pmdlowndp,pmdlcrtid,pmdlcrtdp,pmdlcrtdt,pmdlmodid,pmdlmoddt,pmdlcnfid,
   #       pmdlcnfdt,pmdlpstid,pmdlpstdt,pmdlstus,pmdl205,pmdl206,pmdl207,pmdl208 
   #   INTO l_pmdl.pmdlent,l_pmdl.pmdlsite,l_pmdl.pmdlunit,l_pmdl.pmdldocno,l_pmdl.pmdldocdt,l_pmdl.pmdl001,l_pmdl.pmdl002,l_pmdl.pmdl003,l_pmdl.pmdl004,l_pmdl.pmdl005,l_pmdl.pmdl006,l_pmdl.pmdl007,l_pmdl.pmdl008,
   #       l_pmdl.pmdl009,l_pmdl.pmdl010,l_pmdl.pmdl011,l_pmdl.pmdl012,l_pmdl.pmdl013,l_pmdl.pmdl015,l_pmdl.pmdl016,l_pmdl.pmdl017,l_pmdl.pmdl018,l_pmdl.pmdl019,l_pmdl.pmdl020,l_pmdl.pmdl021,l_pmdl.pmdl022,l_pmdl.pmdl023,
   #       l_pmdl.pmdl024,l_pmdl.pmdl025,l_pmdl.pmdl026,l_pmdl.pmdl027,l_pmdl.pmdl028,l_pmdl.pmdl029,l_pmdl.pmdl030,l_pmdl.pmdl031,l_pmdl.pmdl032,l_pmdl.pmdl033,l_pmdl.pmdl040,l_pmdl.pmdl041,l_pmdl.pmdl042,l_pmdl.pmdl043,
   #       l_pmdl.pmdl044,l_pmdl.pmdl046,l_pmdl.pmdl047,l_pmdl.pmdl048,l_pmdl.pmdl049,l_pmdl.pmdl050,l_pmdl.pmdl051,l_pmdl.pmdl052,l_pmdl.pmdl053,l_pmdl.pmdl054,l_pmdl.pmdl055,l_pmdl.pmdl200,l_pmdl.pmdl201,l_pmdl.pmdl202,
   #       l_pmdl.pmdl203,l_pmdl.pmdl204,l_pmdl.pmdl900,l_pmdl.pmdl999,l_pmdl.pmdlownid,l_pmdl.pmdlowndp,l_pmdl.pmdlcrtid,l_pmdl.pmdlcrtdp,l_pmdl.pmdlcrtdt,l_pmdl.pmdlmodid,l_pmdl.pmdlmoddt,l_pmdl.pmdlcnfid,
   #       l_pmdl.pmdlcnfdt,l_pmdl.pmdlpstid,l_pmdl.pmdlpstdt,l_pmdl.pmdlstus,l_pmdl.pmdl205,l_pmdl.pmdl206,l_pmdl.pmdl207,l_pmdl.pmdl208
   #161109-00085#61 --e mark
   #161109-00085#61 --s add
   SELECT pmdlent,pmdlsite,pmdlunit,pmdldocno,pmdldocdt,
          pmdl001,pmdl002,pmdl003,pmdl004,pmdl005,
          pmdl006,pmdl007,pmdl008,pmdl009,pmdl010,
          pmdl011,pmdl012,pmdl013,pmdl015,pmdl016,
          pmdl017,pmdl018,pmdl019,pmdl020,pmdl021,
          pmdl022,pmdl023,pmdl024,pmdl025,pmdl026,
          pmdl027,pmdl028,pmdl029,pmdl030,pmdl031,
          pmdl032,pmdl033,pmdl040,pmdl041,pmdl042,
          pmdl043,pmdl044,pmdl046,pmdl047,pmdl048,
          pmdl049,pmdl050,pmdl051,pmdl052,pmdl053,
          pmdl054,pmdl055,pmdl200,pmdl201,pmdl202,
          pmdl203,pmdl204,pmdl900,pmdl999,pmdlownid,
          pmdlowndp,pmdlcrtid,pmdlcrtdp,pmdlcrtdt,pmdlmodid,
          pmdlmoddt,pmdlcnfid,pmdlcnfdt,pmdlpstid,pmdlpstdt,
          pmdlstus,pmdlud001,pmdlud002,pmdlud003,pmdlud004,
          pmdlud005,pmdlud006,pmdlud007,pmdlud008,pmdlud009,
          pmdlud010,pmdlud011,pmdlud012,pmdlud013,pmdlud014,
          pmdlud015,pmdlud016,pmdlud017,pmdlud018,pmdlud019,
          pmdlud020,pmdlud021,pmdlud022,pmdlud023,pmdlud024,
          pmdlud025,pmdlud026,pmdlud027,pmdlud028,pmdlud029,
          pmdlud030,pmdl205,pmdl206,pmdl207,pmdl208
     INTO l_pmdl.pmdlent,l_pmdl.pmdlsite,l_pmdl.pmdlunit,l_pmdl.pmdldocno,l_pmdl.pmdldocdt,
          l_pmdl.pmdl001,l_pmdl.pmdl002,l_pmdl.pmdl003,l_pmdl.pmdl004,l_pmdl.pmdl005,
          l_pmdl.pmdl006,l_pmdl.pmdl007,l_pmdl.pmdl008,l_pmdl.pmdl009,l_pmdl.pmdl010,
          l_pmdl.pmdl011,l_pmdl.pmdl012,l_pmdl.pmdl013,l_pmdl.pmdl015,l_pmdl.pmdl016,
          l_pmdl.pmdl017,l_pmdl.pmdl018,l_pmdl.pmdl019,l_pmdl.pmdl020,l_pmdl.pmdl021,
          l_pmdl.pmdl022,l_pmdl.pmdl023,l_pmdl.pmdl024,l_pmdl.pmdl025,l_pmdl.pmdl026,
          l_pmdl.pmdl027,l_pmdl.pmdl028,l_pmdl.pmdl029,l_pmdl.pmdl030,l_pmdl.pmdl031,
          l_pmdl.pmdl032,l_pmdl.pmdl033,l_pmdl.pmdl040,l_pmdl.pmdl041,l_pmdl.pmdl042,
          l_pmdl.pmdl043,l_pmdl.pmdl044,l_pmdl.pmdl046,l_pmdl.pmdl047,l_pmdl.pmdl048,
          l_pmdl.pmdl049,l_pmdl.pmdl050,l_pmdl.pmdl051,l_pmdl.pmdl052,l_pmdl.pmdl053,
          l_pmdl.pmdl054,l_pmdl.pmdl055,l_pmdl.pmdl200,l_pmdl.pmdl201,l_pmdl.pmdl202,
          l_pmdl.pmdl203,l_pmdl.pmdl204,l_pmdl.pmdl900,l_pmdl.pmdl999,l_pmdl.pmdlownid,
          l_pmdl.pmdlowndp,l_pmdl.pmdlcrtid,l_pmdl.pmdlcrtdp,l_pmdl.pmdlcrtdt,l_pmdl.pmdlmodid,
          l_pmdl.pmdlmoddt,l_pmdl.pmdlcnfid,l_pmdl.pmdlcnfdt,l_pmdl.pmdlpstid,l_pmdl.pmdlpstdt,
          l_pmdl.pmdlstus,l_pmdl.pmdlud001,l_pmdl.pmdlud002,l_pmdl.pmdlud003,l_pmdl.pmdlud004,
          l_pmdl.pmdlud005,l_pmdl.pmdlud006,l_pmdl.pmdlud007,l_pmdl.pmdlud008,l_pmdl.pmdlud009,
          l_pmdl.pmdlud010,l_pmdl.pmdlud011,l_pmdl.pmdlud012,l_pmdl.pmdlud013,l_pmdl.pmdlud014,
          l_pmdl.pmdlud015,l_pmdl.pmdlud016,l_pmdl.pmdlud017,l_pmdl.pmdlud018,l_pmdl.pmdlud019,
          l_pmdl.pmdlud020,l_pmdl.pmdlud021,l_pmdl.pmdlud022,l_pmdl.pmdlud023,l_pmdl.pmdlud024,
          l_pmdl.pmdlud025,l_pmdl.pmdlud026,l_pmdl.pmdlud027,l_pmdl.pmdlud028,l_pmdl.pmdlud029,
          l_pmdl.pmdlud030,l_pmdl.pmdl205,l_pmdl.pmdl206,l_pmdl.pmdl207,l_pmdl.pmdl208
   #161109-00085#61 --e add
      FROM pmdl_t 
      WHERE pmdlent = g_enterprise AND pmdldocno = p_pmdldocno
   #mod--161109-00085#14 By 08993--(e)
   #160902-00048#1-e-mod

   #160601-00032#3 20160613 modify by ming -----(S) 
   ##160512-00016#5 20160601 modify by ming -----(S) 
   ##LET l_sql = "SELECT pmdnseq,pmdn001,'','',pmdn002,'',pmdn006,'',pmdn007, ",
   ##            "       pmdn008,'',pmdn009,pmdn010,'', ",
   ##            "       pmdn011,pmdn012,pmdn013,pmdn014,pmdn015,pmdn043,pmdn044,pmdn040, ",
   ##            "       pmdn058,'',pmdn036,'',pmdn037,'',pmdn038,'',pmdn050, ",
   ##            "       pmdbdocno,pmdbseq, ",
   ##            "       pmdl004,'','','','','', ",
   ##            "       pmdn003,pmdn019,pmdn020,pmdn021,pmdn022, ",
   ##            "       pmdn024,pmdn027,pmdn028,pmdn029,pmdn032,pmdn033,pmdn035, ",
   ##            "       pmdn041,pmdn042, ",
   ##            "       pmdn045,pmdn046,pmdn047,pmdn048,pmdnunit,pmdnorga ",
   ##            "  FROM p610_03_pmdn_rel_t ",
   ##            " WHERE pmdl004 = '",p_pmdl004,"' ",
   ##            "   AND NVL(pmdl025,' ') = NVL('",p_pmdl025,"',' ') ",
   ##            "   AND NVL(pmdl026,' ') = NVL('",p_pmdl026,"',' ') "
   #LET l_sql = "SELECT pmdnseq,pmdn001,'','',pmdn002,'',pmdn021,pmdn006,'',pmdn007, ",
   #            "       pmdn008,'',pmdn009,pmdn010,'', ",
   #            "       pmdn011,pmdn012,pmdn013,pmdn014,pmdn015,pmdn043,pmdn044,pmdn040, ",
   #            "       pmdn058,'',pmdn036,'',pmdn037,'',pmdn038,'',pmdn050, ",
   #            "       pmdbdocno,pmdbseq, ",
   #            "       pmdl004,'','','','','', ",
   #            "       pmdn003,pmdn019,pmdn020,pmdn022, ",
   #            "       pmdn024,pmdn027,pmdn028,pmdn029,pmdn032,pmdn033,pmdn035, ",
   #            "       pmdn041,pmdn042, ",
   #            "       pmdn045,pmdn046,pmdn047,pmdn048,pmdnunit,pmdnorga ",
   #            "  FROM p610_03_pmdn_rel_t ",
   #            " WHERE pmdl004 = '",p_pmdl004,"' ",
   #            "   AND NVL(pmdl025,' ') = NVL('",p_pmdl025,"',' ') ",
   #            "   AND NVL(pmdl026,' ') = NVL('",p_pmdl026,"',' ') "
   ##160512-00016#5 20160601 modify by ming -----(E) 
   LET l_sql = "SELECT pmdnseq,pmdn001,'','',pmdn002,'',pmdn021,pmdn006,'',pmdn007, ",
               "       pmdn008,'',pmdn009,pmdn010,'', ",
               "       pmdn011,pmdn012,pmdn013,pmdn014,pmdn015,pmdn043,pmdn044,pmdn040, ",
               "       pmdn058,'',pmdn036,'',pmdn037,'',pmdn038,'',pmdn050, ",
               "       pmdbdocno,pmdbseq, ",
               "       pmdn053, ",
               "       pmdl004,'','','','','', ",
               "       pmdn003,pmdn019,pmdn020,pmdn022, ",
               "       pmdn024,pmdn027,pmdn028,pmdn029,pmdn032,pmdn033,pmdn035, ",
               "       pmdn041,pmdn042, ",
               "       pmdn045,pmdn046,pmdn047,pmdn048,pmdnunit,pmdnorga ",
               "  FROM p610_tmp02 ",             #160727-00019#15 Mod   p610_03_pmdn_rel_t -->p610_tmp02
               " WHERE pmdl004 = '",p_pmdl004,"' ",
               "   AND NVL(pmdl025,' ') = NVL('",p_pmdl025,"',' ') ",
               "   AND NVL(pmdl026,' ') = NVL('",p_pmdl026,"',' ') "
   #160601-00032#3 20160613 modify by ming -----(E) 
   PREPARE apsp610_03_ins_pmdn_prep FROM l_sql
   DECLARE apsp610_03_ins_pmdn_curs CURSOR WITH HOLD FOR apsp610_03_ins_pmdn_prep

   INITIALIZE l_pmdn_tmp.* TO NULL
   INITIALIZE l_pmdn.*     TO NULL 
   #160512-00016#5 20160601 modify by ming -----(S) 
   #FOREACH apsp610_03_ins_pmdn_curs INTO l_pmdn_tmp.*,l_pmdn003,l_pmdn019,l_pmdn020,l_pmdn021,
   #                                      l_pmdn022,l_pmdn024,l_pmdn027,l_pmdn028,
   #                                      l_pmdn029,l_pmdn032,l_pmdn033,l_pmdn035, 
   #                                      l_pmdn041,l_pmdn042,
   #                                      l_pmdn045,l_pmdn046,l_pmdn047,
   #                                      l_pmdn048,l_pmdnunit,l_pmdnorga
   #161109-00085#61 --s mark
   #FOREACH apsp610_03_ins_pmdn_curs INTO l_pmdn_tmp.*,l_pmdn003,l_pmdn019,l_pmdn020,
   #                                      l_pmdn022,l_pmdn024,l_pmdn027,l_pmdn028,
   #                                      l_pmdn029,l_pmdn032,l_pmdn033,l_pmdn035, 
   #                                      l_pmdn041,l_pmdn042,
   #                                      l_pmdn045,l_pmdn046,l_pmdn047,
   #                                      l_pmdn048,l_pmdnunit,l_pmdnorga
   #161109-00085#61 --e mark
   #160512-00016#5 20160601 modify by ming -----(E) 
   FOREACH apsp610_03_ins_pmdn_curs INTO l_pmdn_tmp.pmdnseq_03_02,l_pmdn_tmp.pmdn001_03_02,l_pmdn_tmp.imaal003_03_02,l_pmdn_tmp.imaal004_03_02,l_pmdn_tmp.pmdn002_03_02,
                                         l_pmdn_tmp.pmdn002_03_02_desc,l_pmdn_tmp.pmdn021_03_02,l_pmdn_tmp.pmdn006_03_02,l_pmdn_tmp.pmdn006_03_02_desc,l_pmdn_tmp.pmdn007_03_02,      
                                         l_pmdn_tmp.pmdn008_03_02,l_pmdn_tmp.pmdn008_03_02_desc,l_pmdn_tmp.pmdn009_03_02,l_pmdn_tmp.pmdn010_03_02,l_pmdn_tmp.pmdn010_03_02_desc, 
                                         l_pmdn_tmp.pmdn011_03_02,l_pmdn_tmp.pmdn012_03_02,l_pmdn_tmp.pmdn013_03_02,l_pmdn_tmp.pmdn014_03_02,l_pmdn_tmp.pmdn015_03_02,      
                                         l_pmdn_tmp.pmdn043_03_02,l_pmdn_tmp.pmdn044_03_02,l_pmdn_tmp.pmdn040_03_02,l_pmdn_tmp.pmdn058_03_02,l_pmdn_tmp.pmdn058_03_02_desc, 
                                         l_pmdn_tmp.pmdn036_03_02,l_pmdn_tmp.pmdn036_03_02_desc,l_pmdn_tmp.pmdn037_03_02,l_pmdn_tmp.pmdn037_03_02_desc,l_pmdn_tmp.pmdn038_03_02,      
                                         l_pmdn_tmp.pmdn038_03_02_desc,l_pmdn_tmp.pmdn050_03_02,l_pmdn_tmp.pmdbdocno_03_02,l_pmdn_tmp.pmdbseq_03_02,l_pmdn_tmp.pmdn053_03_02,     
                                         l_pmdn_tmp.pmdl004_03_02,l_pmdn_tmp.pmdn001_03_02_key,l_pmdn_tmp.pmdn002_03_02_key,l_pmdn_tmp.pmdn006_03_02_key,l_pmdn_tmp.pmdn008_03_02_key,
                                         l_pmdn_tmp.pmdn010_03_02_key,l_pmdn003,l_pmdn019,l_pmdn020,l_pmdn022,
                                         l_pmdn024,l_pmdn027,l_pmdn028,l_pmdn029,l_pmdn032,
                                         l_pmdn033,l_pmdn035,l_pmdn041,l_pmdn042,l_pmdn045,
                                         l_pmdn046,l_pmdn047,l_pmdn048,l_pmdnunit,l_pmdnorga
      IF STATUS THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.code   = STATUS
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         LET g_success = 'N'
         EXIT FOREACH
      END IF

      #before insert 的預設  
      LET l_pmdn.pmdn024 = "N"         #多交期 
      LET l_pmdn.pmdn045 = "1"         #行狀態 
      LET l_pmdn.pmdn015 = "0"         #單價 
      LET l_pmdn.pmdn019 = "1"         #子件特性 
      LET l_pmdn.pmdn020 = "1"         #緊急度 
      #160512-00016#5 20160601 modify -----(S) 
      #LET l_pmdn.pmdn021 = "N"         #保稅  
      LET l_pmdn.pmdn021 = l_pmdn_tmp.pmdn021_03_02
      #160512-00016#5 20160601 modify -----(E) 
      LET l_pmdn.pmdn022 = "Y"         #部分交貨 

      LET l_pmdn.pmdn032 = "1"         #取貨模式 
      LET l_pmdn.pmdn035 = "1"         #價格核決 
      LET l_pmdn.pmdn040 = "1"         #取價來源

      LET l_pmdn.pmdnsite = g_site
      LET l_pmdn.pmdn002 =  ' '        #產品特徵 

      LET l_pmdn.pmdnunit = g_site     #交貨據點 
      LET l_pmdn.pmdnorga = g_site     #付款據點 
      
      #-----------------------------------------------------
      LET l_pmdn.pmdn016 = l_pmdl.pmdl011     #稅別 
      LET l_pmdn.pmdn017 = l_pmdl.pmdl012     #稅率 
      LET l_pmdn.pmdn023 = l_pmdl.pmdl022     #送貨供應商 
      LET l_pmdn.pmdn031 = l_pmdl.pmdl020     #運輸方式  
      LET l_pmdn.pmdn025 = l_pmdl.pmdl025     #收貨地址代碼 
      LET l_pmdn.pmdn026 = l_pmdl.pmdl026     #帳款地址代碼 

      LET l_pmdn.pmdndocno = p_pmdldocno
      LET l_pmdn.pmdnseq   = l_pmdn_tmp.pmdnseq_03_02
      LET l_pmdn.pmdn001   = l_pmdn_tmp.pmdn001_03_02
      #after field pmdn001 
      CALL apsp610_03_pmdn001_desc(l_pmdl.pmdl004,l_pmdn.*,p_pmal002)
           RETURNING l_pmdn.* 
      
      #參考apmt500_pmdn001_desc() 給預設值 

      LET l_pmdn.pmdn002   = l_pmdn_tmp.pmdn002_03_02

      #after field pmdn004                   
      IF NOT cl_null(l_pmdn.pmdn004) THEN      #作業編號  
         CALL s_apmp490_oocq_chk('221',l_pmdn.pmdn004) RETURNING l_errno

         IF NOT cl_null(l_errno) THEN
            #160321-00016#41 s983961--mod(S)
            #LET l_str = s_apmp490_get_gzaal_desc('221'),"|",l_pmdn.pmdn004
            #LET g_result_str = g_result_str,",",cl_getmsg_parm(l_errno,g_lang,l_str)
            #LET g_success = 'N'
            IF l_errno = 'apm-01037' THEN 
               LET l_str = s_apmp490_get_gzaal_desc('221'),"|",l_pmdn.pmdn004
               LET g_result_str = g_result_str,",",cl_getmsg_parm(l_errno,g_lang,l_str)
               LET g_success = 'N'
            ELSE 
               LET l_str = 'apmi012',"|",cl_get_progname('apmi012',g_lang,"2")
               LET g_result_str = g_result_str,",",cl_getmsg_parm(l_errno,g_lang,l_str)
               LET g_success = 'N'    
            END IF               
            #160321-00016#41 s983961--mod(E)
         END IF
      END IF

      LET l_pmdn.pmdn006   = l_pmdn_tmp.pmdn006_03_02
      #after field pmdn006 
      IF NOT cl_null(l_pmdn.pmdn006) THEN
         CALL apsp610_03_unit_chk(l_pmdn.pmdn006)

         IF NOT cl_null(g_errno) THEN
            LET l_errno = g_errno
            LET g_result_str = g_result_str,",",cl_getmsg(l_errno,g_lang)
            LET g_success = 'N'
         END IF

         IF NOT cl_null(l_pmdn.pmdn007) THEN
            CALL apsp610_03_unit_round(l_pmdn.pmdn006,l_pmdn.pmdn007)
                 RETURNING l_pmdn.pmdn007

            #計算參考數量 
            #系統參數使用參考單位 
            IF cl_get_para(g_enterprise,g_site,'S-BAS-0028') = 'Y' THEN
               IF cl_null(l_pmdn.pmdn008) THEN
                  LET l_pmdn.pmdn008 = l_pmdn.pmdn006
               END IF
               IF cl_null(l_pmdn.pmdn009) THEN
                  #單位換算 
                  CALL apsp610_03_convert_qty(l_pmdn.pmdn001,l_pmdn.pmdn006,
                                              l_pmdn.pmdn008,l_pmdn.pmdn007)
                       RETURNING l_pmdn.pmdn009
               END IF
               IF NOT cl_null(l_pmdn.pmdn009) THEN
                  CALL apsp610_03_unit_round(l_pmdn.pmdn008,l_pmdn.pmdn009)
                       RETURNING l_pmdn.pmdn009
               END IF
            ELSE
               LET l_pmdn.pmdn008 = ''
               LET l_pmdn.pmdn009 = ''
            END IF
 
            #若參數有使用計價單位時，則輸入[C:需求數量]時則應自動推算計價數量，
            #[C:計價數量]=[C:需求數量]*[C:單位]與[C:計價單位]換算率
            IF cl_get_para(g_enterprise,g_site,'S-BAS-0019') = "Y" THEN  #體參數使用採購計價單位
               IF cl_null(l_pmdn.pmdn010) THEN
                  LET l_pmdn.pmdn010 = l_pmdn.pmdn006
               END IF
               IF cl_null(l_pmdn.pmdn011) THEN
                  CALL apsp610_03_convert_qty(l_pmdn.pmdn001,l_pmdn.pmdn006,
                                              l_pmdn.pmdn010,l_pmdn.pmdn007)
                       RETURNING l_pmdn.pmdn011
               END IF
               IF NOT cl_null(l_pmdn.pmdn011) THEN
                  CALL apsp610_03_unit_round(l_pmdn.pmdn010,l_pmdn.pmdn011)
                       RETURNING l_pmdn.pmdn011
               END IF
            ELSE
               LET l_pmdn.pmdn010 = l_pmdn.pmdn006
               LET l_pmdn.pmdn011 = l_pmdn.pmdn007
            END IF
         END IF

      END IF

      LET l_pmdn.pmdn007   = l_pmdn_tmp.pmdn007_03_02
      #after field pmdn007 
      IF NOT cl_null(l_pmdn.pmdn007) THEN
         IF l_pmdn.pmdn007 <= 0 THEN
            LET l_errno = 'ade-00016'        #數量不可小於等於0 
            LET g_result_str = g_result_str,",",cl_getmsg(l_errno,g_lang)
            LET g_success = 'N'
         END IF

         IF NOT cl_null(l_pmdn.pmdn006) THEN
            CALL apsp610_03_unit_round(l_pmdn.pmdn006,l_pmdn.pmdn007)
                 RETURNING l_pmdn.pmdn007

         END IF 
         
         #參考單位 
         IF cl_get_para(g_enterprise,g_site,'S-BAS-0028') = 'Y' THEN
            IF (NOT cl_null(l_pmdn.pmdn008)) AND (cl_null(l_pmdn.pmdn009)) THEN
               CALL apsp610_03_convert_qty(l_pmdn.pmdn001,l_pmdn.pmdn006,
                                           l_pmdn.pmdn008,l_pmdn.pmdn007)
                    RETURNING l_pmdn.pmdn009
               CALL apsp610_03_unit_round(l_pmdn.pmdn008,l_pmdn.pmdn009)
                    RETURNING l_pmdn.pmdn009
            END IF
         END IF

         IF cl_get_para(g_enterprise,g_site,'S-BAS-0019') = "Y" THEN  #體參數使用採購計價單位
            IF (NOT cl_null(l_pmdn.pmdn010)) AND (cl_null(l_pmdn.pmdn011)) THEN
               CALL apsp610_03_convert_qty(l_pmdn.pmdn001,l_pmdn.pmdn006,
                                           l_pmdn.pmdn010,l_pmdn.pmdn007)
                    RETURNING l_pmdn.pmdn011
               CALL apsp610_03_unit_round(l_pmdn.pmdn010,l_pmdn.pmdn011)
                    RETURNING l_pmdn.pmdn011
            END IF
         END IF
      END IF 
      
      #參考單位 
      IF cl_get_para(g_enterprise,g_site,'S-BAS-0028') = 'Y' THEN
         LET l_pmdn.pmdn008 = l_pmdn_tmp.pmdn008_03_02
         LET l_pmdn.pmdn009 = l_pmdn_tmp.pmdn009_03_02
         IF (NOT cl_null(l_pmdn.pmdn008)) AND cl_null(l_pmdn.pmdn009) THEN
            CALL apsp610_03_convert_qty(l_pmdn.pmdn001,l_pmdn.pmdn006,
                                        l_pmdn.pmdn008,l_pmdn.pmdn007)
                 RETURNING l_pmdn.pmdn009
            CALL apsp610_03_unit_round(l_pmdn.pmdn008,l_pmdn.pmdn009)
                 RETURNING l_pmdn.pmdn009
         END IF
      ELSE
         LET l_pmdn.pmdn008 = ''
         LET l_pmdn.pmdn009 = ''
      END IF

      #after field pmdn024   #多交期
      LET l_pmdn.pmdn024 = l_pmdn024 
      
      SELECT ooef008,ooef009 INTO g_ooef008,g_ooef009
        FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = g_site

      LET l_pmdn.pmdn012   = l_pmdn_tmp.pmdn012_03_02
      #after field pmdn012   #出庫日期  
      IF NOT cl_null(l_pmdn.pmdn012) THEN
         LET l_imaf173 = 0   #採購到廠前置時間  
         LET l_imaf174 = 0   #採購入庫前置時間  

         SELECT imaf173,imaf174 INTO l_imaf173,l_imaf174
           FROM imaf_t
          WHERE imafent = g_enterprise
            AND imafsite = g_site
            AND imaf001 = l_pmdn.pmdn001

         #1.輸入交貨日期後需自動計算到廠日期，公式為交貨日期+[T:料件據點進銷存檔].[C:到廠前置時間]
         #2.輸入交貨日期後需自動計算到庫日期，公式為到廠日期+[T:料件據點進銷存檔].[C:到庫前置時間]
         IF (NOT cl_null(l_imaf173)) AND l_imaf173 <> 0 THEN
            CALL s_date_get_work_date(g_site,g_ooef008,g_ooef009,l_pmdn.pmdn012,0,l_imaf173)
                 RETURNING l_pmdn.pmdn013
         ELSE
            LET l_pmdn.pmdn013 = l_pmdn.pmdn012
         END IF

         IF (NOT cl_null(l_imaf174)) AND l_imaf174 <> 0 THEN
            CALL s_date_get_work_date(g_site,g_ooef008,g_ooef009,l_pmdn.pmdn013,0,l_imaf174)
                 RETURNING l_pmdn.pmdn014
         ELSE
            LET l_pmdn.pmdn014 = l_pmdn.pmdn013
         END IF

         #根據到庫日期計算緊急度 
         CALL apsp610_03_pmdn014_to_pmdn020(l_pmdn.pmdn001,l_pmdn.pmdn014) RETURNING l_pmdn.pmdn020 
      END IF

      LET l_pmdn.pmdn013   = l_pmdn_tmp.pmdn013_03_02
      #after field pmdn013 
      LET l_imaf173 = 0
      LET l_imaf174 = 0

      SELECT imaf173,imaf174 INTO l_imaf173,l_imaf174
        FROM imaf_t
       WHERE imafent = g_enterprise
         AND imafsite = g_site
         AND imaf001 = l_pmdn.pmdn001

      IF NOT cl_null(l_pmdn.pmdn013) THEN
         IF NOT cl_null(l_pmdn.pmdn012) THEN
            IF l_pmdn.pmdn013 < l_pmdn.pmdn012 THEN
               LET l_errno = 'apm-00267'          #到廠日期不可小於交貨日期！   
               LET g_result_str = g_result_str,",",cl_getmsg(l_errno,g_lang)
               LET g_success = 'N'
            END IF
         ELSE
            #若交貨日期為NULL時，輸入到廠日期後需自動計算交貨日期，公式為到廠日期-[T:料件據點進銷存檔].[C:到廠前置時間]
            IF (NOT cl_null(l_imaf173)) AND l_imaf173 <> 0 THEN
               CALL s_date_get_work_date(g_site,g_ooef008,g_ooef009,l_pmdn.pmdn013,0,(l_imaf173*(-1)))
                    RETURNING l_pmdn.pmdn012
            ELSE
               LET l_pmdn.pmdn012 = l_pmdn.pmdn013
            END IF
         END IF 
         #2.輸入到廠日期後需自動計算到庫日期，公式為到廠日期+[T:料件據點進銷存檔].[C:到庫前置時間]
         IF (NOT cl_null(l_imaf174)) AND l_imaf174 <> 0 THEN
            CALL s_date_get_work_date(g_site,g_ooef008,g_ooef009,l_pmdn.pmdn013,0,l_imaf174)
                 RETURNING l_pmdn.pmdn014
         ELSE
            LET l_pmdn.pmdn014 = l_pmdn.pmdn013
         END IF

         #根據到庫日期計算緊急度 
         CALL apsp610_03_pmdn014_to_pmdn020(l_pmdn.pmdn001,l_pmdn.pmdn014)
              RETURNING l_pmdn.pmdn020
      END IF

      LET l_pmdn.pmdn014   = l_pmdn_tmp.pmdn014_03_02
      #after field pmdn014 
      IF NOT cl_null(l_pmdn.pmdn014) THEN
         IF NOT cl_null(l_pmdn.pmdn013) THEN
            IF l_pmdn.pmdn014 < l_pmdn.pmdn013 THEN
               LET l_errno = 'apm-00271'         #到庫日期不可小於到廠日期！  
               LET g_result_str = g_result_str,",",cl_getmsg(l_errno,g_lang)
               LET g_success = 'N'
            END IF
         ELSE
            #若到廠日期為NULL時，輸入到庫日期後需自動計算到廠日期，公式為到庫日期-[T:料件據點進銷存檔].[C:到庫前置時間]
            IF (NOT cl_null(l_imaf174)) AND l_imaf174 <> 0 THEN
               CALL s_date_get_work_date(g_site,g_ooef008,g_ooef009,l_pmdn.pmdn014,0,(l_imaf174*(-1)))
                    RETURNING l_pmdn.pmdn013
            ELSE
               LET l_pmdn.pmdn013 = l_pmdn.pmdn014
            END IF 
         END IF

         IF NOT cl_null(l_pmdn.pmdn012) THEN
            IF l_pmdn.pmdn014 < l_pmdn.pmdn012 THEN
               LET l_errno = 'apm-00272'
               LET g_result_str = g_result_str,",",cl_getmsg(l_errno,g_lang)
               LET g_success = 'N'
            END IF
         ELSE
            #若交貨日期為NULL時，輸入到庫日期後需自動計算交貨日期，公式為到廠日期-[T:料件據點進銷存檔].[C:到廠前置時間]
            IF (NOT cl_null(l_imaf173)) AND l_imaf173 <> 0 THEN
               CALL s_date_get_work_date(g_site,g_ooef008,g_ooef009,l_pmdn.pmdn013,0,(l_imaf173*(-1)))
                    RETURNING l_pmdn.pmdn012
            ELSE
               LET l_pmdn.pmdn012 = l_pmdn.pmdn013
            END IF
         END IF

         #根據到庫日期計算緊急度 
         CALL apsp610_03_pmdn014_to_pmdn020(l_pmdn.pmdn001,l_pmdn.pmdn014)
              RETURNING l_pmdn.pmdn020
      END IF

      #計價單位  
      IF cl_get_para(g_enterprise,g_site,'S-BAS-0019') = 'Y' THEN
         LET l_pmdn.pmdn010 = l_pmdn_tmp.pmdn010_03_02
         LET l_pmdn.pmdn011 = l_pmdn_tmp.pmdn011_03_02

         IF NOT cl_null(l_pmdn.pmdn010) THEN
            CALL apsp610_03_unit_chk(l_pmdn.pmdn010)

            IF NOT cl_null(g_errno) THEN
               LET l_errno = g_errno
               LET g_result_str = g_result_str,",",cl_getmsg(l_errno,g_lang)
               LET g_success = 'N'
            END IF
         END IF

         IF cl_null(l_pmdn.pmdn011) THEN
            CALL apsp610_03_convert_qty(l_pmdn.pmdn001,l_pmdn.pmdn006,
                                        l_pmdn.pmdn010,l_pmdn.pmdn007)
                 RETURNING l_pmdn.pmdn011
         ELSE
            IF l_pmdn.pmdn011 <= 0 THEN
               LET l_errno = 'ade-00016'                 #數量不可小於等於0 
               LET g_result_str = g_result_str,",",cl_getmsg(l_errno,g_lang)
               LET g_success = 'N'
            END IF
         END IF 
         
         CALL apsp610_03_unit_round(l_pmdn.pmdn010,l_pmdn.pmdn011)
              RETURNING l_pmdn.pmdn011

      ELSE
         LET l_pmdn.pmdn010 = l_pmdn.pmdn006
         LET l_pmdn.pmdn011 = l_pmdn.pmdn007
      END IF

      LET l_pmdn.pmdn015   = l_pmdn_tmp.pmdn015_03_02
      #after field pmdn015     #單價  
      LET l_pmam004 = ''
      LET l_pmam005 = ''
      LET l_pmam006 = '' 
      IF NOT cl_null(l_pmdn.pmdn015) THEN
         IF l_pmdn.pmdn015 < 0 THEN
            LET l_errno = 'agl-00042'                      #單價不可小於0 
            LET g_result_str = g_result_str,",",cl_getmsg(l_errno,g_lang)
            LET g_success = 'N'
         END IF

         SELECT pmam004,pmam005,pmam006 INTO l_pmam004,l_pmam005,l_pmam006
           FROM pmam_t
          WHERE pmament = g_enterprise
            AND pmam001 = l_pmdl.pmdl027
         IF l_pmam006 <> 'Y' AND l_pmdn.pmdn015 = 0 THEN  #價格不允許為0
            #CALL cl_err(g_pmdn_d[l_ac].pmdn015,'apm-00273',1)
            LET l_errno = 'apm-00273'
            LET g_result_str = g_result_str,",",cl_getmsg(l_errno,g_lang)
            LET g_success = 'N'
         END IF

      END IF

      #after field pmdn016 
      IF NOT cl_null(l_pmdn.pmdn016) THEN
         CALL apsp610_03_pmdl011_chk(l_pmdn.pmdn016)

         IF NOT cl_null(g_errno) THEN
            LET l_errno = g_errno
            LET g_result_str = g_result_str,",",cl_getmsg(l_errno,g_lang) 
            LET g_success = 'N'
         ELSE
            SELECT oodb006 INTO l_pmdn.pmdn017
              FROM oodb_t,ooef_t
             WHERE ooefent = oodbent
               AND ooef001 = g_site
               AND ooef019 = oodb001
               AND oodbent = g_enterprise
               AND oodb002 = l_pmdn.pmdn016

         END IF
      END IF
      
      CALL s_apmt500_get_amount(l_pmdl.pmdldocno,l_pmdn.pmdnseq,l_pmdl.pmdl015,
                                l_pmdn.pmdn011,l_pmdn.pmdn015,l_pmdn.pmdn016)
           RETURNING l_pmdn.pmdn046,l_pmdn.pmdn048,l_pmdn.pmdn047

      #after field pmdn023     #送貨供應商   
      #送貨供應商不檢查 因為apmt500_01也沒檢查 
     #IF NOT cl_null(l_pmdn.pmdn023) THEN 
     #   CALL apsp610_03_pmdn023_chk(l_pmdl.pmdl004,l_pmdn.pmdn023) 

     #   IF NOT cl_null(g_errno) THEN 
     #      LET l_errno = g_errno  
     #      LET g_result_str = g_result_str,",",cl_getmsg(l_errno,g_lang) 
     #      LET g_success = 'N' 
     #   END IF 
     #END IF 

      #after field pmdnunit
      LET l_pmdn.pmdnunit = l_pmdnunit 
      IF NOT cl_null(l_pmdn.pmdnunit) THEN
         CALL apsp610_03_pmdnunit_chk(l_pmdn.pmdnunit)
         IF NOT cl_null(g_errno) THEN
            LET l_errno = g_errno
            LET g_result_str = g_result_str,",",cl_getmsg(l_errno,g_lang)
            LET g_success = 'N'
         END IF

         #檢核輸入的營運據點是否在採購控制組的限制範圍內
         CALL s_control_chk_group('5','4',g_user,g_dept,l_pmdn.pmdnunit ,'','','','') RETURNING l_success,l_flag
         IF NOT l_success THEN     #處理狀態   
            LET g_success = 'N'
         ELSE
            IF NOT l_flag THEN     #是否存在  
               LET l_errno = 'apm-00274'
               LET g_result_str = g_result_str,",",cl_getmsg(l_errno,g_lang)
               LET g_success = 'N'
            END IF
         END IF

         LET l_pmdn.pmdnorga = l_pmdn.pmdnunit
         CALL apsp610_03_get_oofb019(l_pmdn.pmdnunit)   RETURNING l_pmdn.pmdn025,l_desc
         CALL apsp610_03_get_oofb019_5(l_pmdn.pmdnorga) RETURNING l_pmdn.pmdn026,l_desc
      ELSE
         LET l_pmdn.pmdnunit = g_site
      END IF

      #after field pmdnorga
      LET l_pmdn.pmdnorga = l_pmdnorga
      IF NOT cl_null(l_pmdn.pmdnorga) THEN 
         CALL apsp610_03_pmdnunit_chk(l_pmdn.pmdnorga)
         IF NOT cl_null(g_errno) THEN
            LET l_errno = g_errno
            LET g_result_str = g_result_str,",",cl_getmsg(l_errno,g_lang)
            LET g_success = 'N'
         END IF

         CALL apsp610_03_get_oofb019_5(l_pmdn.pmdnorga) RETURNING l_pmdn.pmdn026,l_desc
      ELSE
         LET l_pmdn.pmdnorga = g_site
      END IF

      LET l_pmdn.pmdnent = g_enterprise

      LET l_sql = "SELECT qcap006 FROM qcap_t ",
                  " WHERE qcapent = '",g_enterprise,"' ",
                  "   AND qcapsite = '",g_site,"' ",
                  "   AND qcap001  = '",l_pmdn.pmdn001,"' ",
                  "   AND qcap002  = '",l_pmdl.pmdl004,"' "
      IF l_pmdn.pmdn002 IS NOT NULL THEN
         LET l_sql = l_sql ," AND (qcap005 = '",l_pmdn.pmdn002,"' OR qcap005 = 'ALL' ) "
      END IF
      IF (NOT cl_null(l_pmdn.pmdn004)) AND (NOT cl_null(l_pmdn.pmdn005)) THEN
         LET l_sql = l_sql ," AND (qcap003 = '",l_pmdn.pmdn004,"' OR qcap003 = 'ALL') ",
                            " AND qcap004  = '",l_pmdn.pmdn005,"' "
      END IF

      PREPARE apsp610_03_get_qcap FROM l_sql
      EXECUTE apsp610_03_get_qcap INTO l_pmdn.pmdn052
      FREE apsp610_03_get_qcap 
      
      IF cl_null(l_pmdn.pmdn052) THEN
         SELECT imae114 INTO l_pmdn.pmdn052
           FROM imae_t
          WHERE imaeent  = g_enterprise
            AND imaesite = g_site
            AND imae001  = l_pmdn.pmdn001
      END IF

      IF cl_null(l_pmdn.pmdn052) THEN
         LET l_pmdn.pmdn052 = 'N'
      END IF

      LET l_pmdn.pmdn028 = l_pmdn028 
      LET l_pmdn.pmdn036 = l_pmdn_tmp.pmdn036_03_02
      LET l_pmdn.pmdn037 = l_pmdn_tmp.pmdn037_03_02
      LET l_pmdn.pmdn038 = l_pmdn_tmp.pmdn038_03_02
      
      LET l_pmdn.pmdn040 = l_pmdn_tmp.pmdn040_03_02     #取價方式   
      LET l_pmdn.pmdn041 = l_pmdn041
      LET l_pmdn.pmdn042 = l_pmdn042
      LET l_pmdn.pmdn043 = l_pmdn_tmp.pmdn043_03_02     #取出價格  
      LET l_pmdn.pmdn044 = l_pmdn_tmp.pmdn044_03_02     #價差比 
      
      LET l_pmdn.pmdn050 = l_pmdn_tmp.pmdn050_03_02 
      
      #160601-00032#3 20160613 add by ming -----(S) 
      LET l_pmdn.pmdn053 = l_pmdn_tmp.pmdn053_03_02     #庫存管理特徵 
      #160601-00032#3 20160613 add by ming -----(E) 
      
      LET l_pmdn.pmdn058 = l_pmdn_tmp.pmdn058_03_02     #預算科目 

      #160601-00032#3 20160613 modify by ming -----(S) 
      #INSERT INTO pmdn_t(pmdnent ,pmdnsite,pmdndocno,pmdnseq,pmdn001,
      #                   pmdn002 ,pmdn003 ,pmdn004  ,pmdn005,pmdn006,
      #                   pmdn007 ,pmdn008 ,pmdn009  ,pmdn010,pmdn011,
      #                   pmdn012 ,pmdn013 ,pmdn014  ,pmdn015,pmdn016,
      #                   pmdn017 ,pmdn019 ,pmdn020  ,pmdn021,pmdn022,
      #                   pmdnunit,pmdnorga,pmdn023  ,pmdn024,pmdn025,
      #                   pmdn026 ,pmdn027 ,pmdn028  ,pmdn029,pmdn030,
      #                   pmdn031 ,pmdn032 ,pmdn033  ,pmdn034,pmdn035,
      #                   pmdn036 ,pmdn037 ,pmdn038  ,pmdn039,pmdn040,
      #                   pmdn041 ,pmdn042 ,pmdn043  ,pmdn044,pmdn045,
      #                   pmdn046 ,pmdn047 ,pmdn048  ,pmdn049,pmdn050,
      #                   pmdn051 ,pmdn052 ,pmdn058)
      #            VALUES(l_pmdn.pmdnent,l_pmdn.pmdnsite,l_pmdn.pmdndocno, 
      #                   l_pmdn.pmdnseq,l_pmdn.pmdn001 ,l_pmdn.pmdn002  ,
      #                   l_pmdn.pmdn003,l_pmdn.pmdn004 ,l_pmdn.pmdn005  ,
      #                   l_pmdn.pmdn006,l_pmdn.pmdn007 ,l_pmdn.pmdn008  ,
      #                   l_pmdn.pmdn009,l_pmdn.pmdn010 ,l_pmdn.pmdn011  ,
      #                   l_pmdn.pmdn012,l_pmdn.pmdn013 ,l_pmdn.pmdn014  ,
      #                   l_pmdn.pmdn015,l_pmdn.pmdn016 ,l_pmdn.pmdn017  ,
      #                   l_pmdn.pmdn019,l_pmdn.pmdn020 ,l_pmdn.pmdn021  ,
      #                   l_pmdn.pmdn022,l_pmdn.pmdnunit,l_pmdn.pmdnorga ,
      #                   l_pmdn.pmdn023,l_pmdn.pmdn024 ,l_pmdn.pmdn025  ,
      #                   l_pmdn.pmdn026,l_pmdn.pmdn027 ,l_pmdn.pmdn028  ,
      #                   l_pmdn.pmdn029,l_pmdn.pmdn030 ,l_pmdn.pmdn031  ,
      #                   l_pmdn.pmdn032,l_pmdn.pmdn033 ,l_pmdn.pmdn034  ,
      #                   l_pmdn.pmdn035,l_pmdn.pmdn036 ,l_pmdn.pmdn037  ,
      #                   l_pmdn.pmdn038,l_pmdn.pmdn039 ,l_pmdn.pmdn040  ,
      #                   l_pmdn.pmdn041,l_pmdn.pmdn042 ,l_pmdn.pmdn043  ,
      #                   l_pmdn.pmdn044,l_pmdn.pmdn045 ,l_pmdn.pmdn046  ,
      #                   l_pmdn.pmdn047,l_pmdn.pmdn048 ,l_pmdn.pmdn049  ,
      #                   l_pmdn.pmdn050,l_pmdn.pmdn051 ,l_pmdn.pmdn052  , 
      #                   l_pmdn.pmdn058 ) 
      INSERT INTO pmdn_t(pmdnent ,pmdnsite,pmdndocno,pmdnseq,pmdn001,
                         pmdn002 ,pmdn003 ,pmdn004  ,pmdn005,pmdn006,
                         pmdn007 ,pmdn008 ,pmdn009  ,pmdn010,pmdn011,
                         pmdn012 ,pmdn013 ,pmdn014  ,pmdn015,pmdn016,
                         pmdn017 ,pmdn019 ,pmdn020  ,pmdn021,pmdn022,
                         pmdnunit,pmdnorga,pmdn023  ,pmdn024,pmdn025,
                         pmdn026 ,pmdn027 ,pmdn028  ,pmdn029,pmdn030,
                         pmdn031 ,pmdn032 ,pmdn033  ,pmdn034,pmdn035,
                         pmdn036 ,pmdn037 ,pmdn038  ,pmdn039,pmdn040,
                         pmdn041 ,pmdn042 ,pmdn043  ,pmdn044,pmdn045,
                         pmdn046 ,pmdn047 ,pmdn048  ,pmdn049,pmdn050,
                         pmdn051 ,pmdn052 ,pmdn053  ,pmdn058)
                  VALUES(l_pmdn.pmdnent,l_pmdn.pmdnsite,l_pmdn.pmdndocno, 
                         l_pmdn.pmdnseq,l_pmdn.pmdn001 ,l_pmdn.pmdn002  ,
                         l_pmdn.pmdn003,l_pmdn.pmdn004 ,l_pmdn.pmdn005  ,
                         l_pmdn.pmdn006,l_pmdn.pmdn007 ,l_pmdn.pmdn008  ,
                         l_pmdn.pmdn009,l_pmdn.pmdn010 ,l_pmdn.pmdn011  ,
                         l_pmdn.pmdn012,l_pmdn.pmdn013 ,l_pmdn.pmdn014  ,
                         l_pmdn.pmdn015,l_pmdn.pmdn016 ,l_pmdn.pmdn017  ,
                         l_pmdn.pmdn019,l_pmdn.pmdn020 ,l_pmdn.pmdn021  ,
                         l_pmdn.pmdn022,l_pmdn.pmdnunit,l_pmdn.pmdnorga ,
                         l_pmdn.pmdn023,l_pmdn.pmdn024 ,l_pmdn.pmdn025  ,
                         l_pmdn.pmdn026,l_pmdn.pmdn027 ,l_pmdn.pmdn028  ,
                         l_pmdn.pmdn029,l_pmdn.pmdn030 ,l_pmdn.pmdn031  ,
                         l_pmdn.pmdn032,l_pmdn.pmdn033 ,l_pmdn.pmdn034  ,
                         l_pmdn.pmdn035,l_pmdn.pmdn036 ,l_pmdn.pmdn037  ,
                         l_pmdn.pmdn038,l_pmdn.pmdn039 ,l_pmdn.pmdn040  ,
                         l_pmdn.pmdn041,l_pmdn.pmdn042 ,l_pmdn.pmdn043  ,
                         l_pmdn.pmdn044,l_pmdn.pmdn045 ,l_pmdn.pmdn046  ,
                         l_pmdn.pmdn047,l_pmdn.pmdn048 ,l_pmdn.pmdn049  ,
                         l_pmdn.pmdn050,l_pmdn.pmdn051 ,l_pmdn.pmdn052  , 
                         l_pmdn.pmdn053, 
                         l_pmdn.pmdn058 )                    
      #160601-00032#3 20160613 modify by ming -----(S) 
                         
      #需再重新初始化一次，防止當前record的資料帶入的下一筆中(下一筆的某個欄位抓到的资料为空时，会把当前的资料带入，如检验否栏位)
      INITIALIZE l_pmdn_tmp.* TO NULL  
      INITIALIZE l_pmdn.*     TO NULL               
     
   END FOREACH       
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsp610_03_unit_chk(p_unit)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_03_unit_chk(p_unit)
   DEFINE p_unit        LIKE pmdn_t.pmdn006
   DEFINE l_oocastus    LIKE ooca_t.oocastus 
   
   WHENEVER ERROR CONTINUE 

   LET g_errno = ''
   LET l_oocastus = ''

   SELECT oocastus INTO l_oocastus
     FROM ooca_t
    WHERE ooca001 = p_unit
      AND oocaent = g_enterprise

   CASE
      WHEN SQLCA.sqlcode = 100      LET g_errno = 'aim-00004'          #輸入的資料不存在于 單位資料檔 中！  
      WHEN l_oocastus <> 'Y'        LET g_errno = 'sub-01302'          #輸入的資料無效！  
      OTHERWISE                     LET g_errno = SQLCA.sqlcode USING '------'
   END CASE
END FUNCTION

################################################################################
# Descriptions...: #根據單位取位類型對數量進行取位
# Memo...........:
# Usage..........: CALL apsp610_03_unit_round(p_unit,p_qty)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_03_unit_round(p_unit,p_qty)
   DEFINE p_unit        LIKE pmdn_t.pmdn006   #單位  
   DEFINE p_qty         LIKE pmdn_t.pmdn007   #數量  
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_ooca002     LIKE ooca_t.ooca002   #小數位數 
   DEFINE l_ooca004     LIKE ooca_t.ooca004   #捨入類型  
   DEFINE r_qty         LIKE pmdn_t.pmdn007   #數量   
   
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
# Usage..........: CALL apsp610_03_pmdn014_to_pmdn020(p_pmdn001,p_pmdn014)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_03_pmdn014_to_pmdn020(p_pmdn001,p_pmdn014)
   DEFINE p_pmdn001     LIKE pmdn_t.pmdn001
   DEFINE p_pmdn014     LIKE pmdn_t.pmdn014
   DEFINE l_imaf171     LIKE imaf_t.imaf171
   DEFINE l_imaf172     LIKE imaf_t.imaf172
   DEFINE l_imaf173     LIKE imaf_t.imaf173
   DEFINE l_imaf174     LIKE imaf_t.imaf174
   DEFINE l_imaf175     LIKE imaf_t.imaf175
   DEFINE l_time1       LIKE imaf_t.imaf171
   DEFINE l_time2       LIKE imaf_t.imaf171
   DEFINE r_pmdn020     LIKE pmdn_t.pmdn020 
   
   WHENEVER ERROR CONTINUE 

   LET r_pmdn020 = ''

   IF NOT cl_null(p_pmdn014) THEN
      LET l_imaf171 = 0
      LET l_imaf172 = 0
      LET l_imaf173 = 0
      LET l_imaf174 = 0
      LET l_imaf175 = 0
      LET l_time1 = 0
      LET l_time2 = 0

      SELECT imaf171,imaf172,imaf173,imaf174,imaf175
        INTO l_imaf171,l_imaf172,l_imaf173,l_imaf174,l_imaf175
        FROM imaf_t
       WHERE imafent  = g_enterprise
         AND imafsite = g_site
         AND imaf001  = p_pmdn001 

      LET l_time1 = p_pmdn014 - g_today         #到庫日期  - g_today
      LET l_time2 = l_imaf171+l_imaf172+l_imaf173+l_imaf174  #[T:料件據點進銷存檔]設置的(文件+交貨+到廠+入庫)前置天數

      #1.若輸入的到庫日期 - g_today >[T:料件據點進銷存檔]設置的(文件+交貨+到廠+入庫)前置天數時，則[C:緊急度] = '1'(一般)
      IF l_time1 >= l_time2 THEN
         LET r_pmdn020 = '1'
      END IF

      #2.若輸入的到庫日期 - g_today <[T:料件據點進銷存檔]設置的(文件+交貨+到廠+入庫)前置天數，
      #   且到庫日期 - g_today >[T:料件據點進銷存檔].[C:嚴守交期前置時間]時，則[C:緊急度] = '2'(緊急)
      IF l_time1 < l_time2 AND l_time1 >= l_imaf175 THEN
         LET r_pmdn020 = '2'
      END IF

      #3.若輸入的到庫日期 - g_today <[T:料件據點進銷存檔].[C:嚴守交期前置時間]時，則[C:緊急度] = '3'(特急)
      IF l_time1 < l_imaf175 THEN
         LET r_pmdn020 = '3'
      END IF
   END IF

   RETURN r_pmdn020
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsp610_03_pmdn023_chk(p_pmdl004,p_pmdn023)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_03_pmdn023_chk(p_pmdl004,p_pmdn023)
   DEFINE p_pmdl004     LIKE pmdl_t.pmdl004
   DEFINE p_pmdn023     LIKE pmdn_t.pmdn023
   DEFINE l_pmacstus    LIKE pmac_t.pmacstus
   DEFINE l_pmac003     LIKE pmac_t.pmac003 
   
   WHENEVER ERROR CONTINUE 

   LET g_errno = ''
   LET l_pmacstus = ''
   LET l_pmac003 = ''

   SELECT pmac003,pmacstus INTO l_pmac003,l_pmacstus
     FROM pmac_t
    WHERE pmacent = g_enterprise
      AND pmac001 = p_pmdl004
      AND pmac002 = p_pmdn023
      AND pmac003 = '2'

   CASE
      WHEN SQLCA.sqlcode = 100     LET g_errno = 'axr-00048'     #輸入資料不存在交易對象交易夥伴檔中！
      WHEN l_pmacstus <> 'Y'       LET g_errno = 'axm-00049'     #輸入的資料不存在於銷售通路主檔中！
      WHEN l_pmac003 <> '2'        LET g_errno = 'apm-00258'     #輸入資料的交易對象不為[2.出貨對象]！ 
      OTHERWISE                    LET g_errno = SQLCA.sqlcode USING '------'
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsp610_03_create_data()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........: 160512-00016#5  2016/06/01 by ming 加入保稅
################################################################################
PUBLIC FUNCTION apsp610_03_create_data()
   DEFINE l_sql         STRING
   DEFINE l_pmdl004     LIKE pmdl_t.pmdl004 
   DEFINE l_pmdl025     LIKE pmdl_t.pmdl025
   DEFINE l_pmdl026     LIKE pmdl_t.pmdl026
   DEFINE l_pmdn001     LIKE pmdn_t.pmdn001
   DEFINE l_pmdn002     LIKE pmdn_t.pmdn002
   DEFINE l_sum_pmdn007 LIKE pmdn_t.pmdn007 
   DEFINE l_sum_pmdn009 LIKE pmdn_t.pmdn009
   DEFINE l_sum_pmdn011 LIKE pmdn_t.pmdn011

   DEFINE l_pspc050     LIKE pspc_t.pspc050
   DEFINE l_pspc051     LIKE pspc_t.pspc051
   DEFINE l_pspc014     LIKE pspc_t.pspc014
   DEFINE l_pspc045     LIKE pspc_t.pspc045
   DEFINE l_pmdn006     LIKE pmdn_t.pmdn006
   DEFINE l_pmdn007     LIKE pmdn_t.pmdn007 
   DEFINE l_pmdn008     LIKE pmdn_t.pmdn008
   DEFINE l_pmdn009     LIKE pmdn_t.pmdn009
   DEFINE l_pmdn010     LIKE pmdn_t.pmdn010
   DEFINE l_pmdn011     LIKE pmdn_t.pmdn011
   #160512-00016#5 20160601 add by ming -----(S) 
   DEFINE l_pmdn021     LIKE pmdn_t.pmdn021 
   #160512-00016#5 20160601 add by ming -----(E) 
   DEFINE l_pmdn058     LIKE pmdn_t.pmdn058
   DEFINE l_pmdn036     LIKE pmdn_t.pmdn036
   DEFINE l_pmdn037     LIKE pmdn_t.pmdn037
   DEFINE l_pmdn038     LIKE pmdn_t.pmdn038
   DEFINE l_pmdn050     LIKE pmdn_t.pmdn050
   #160601-00032#3 20160613 add by ming -----(S) 
   DEFINE l_pmdn053     LIKE pmdn_t.pmdn053
   #160601-00032#3 20160613 add by ming -----(E) 
   DEFINE l_link_no     LIKE type_t.num10

   DEFINE l_qty1        LIKE pmdn_t.pmdn007
   DEFINE l_qty2        LIKE pmdn_t.pmdn007
   DEFINE l_qty3        LIKE pmdn_t.pmdn007
   DEFINE l_qty_w       LIKE pmdn_t.pmdn007 
   DEFINE l_new_qty_w   LIKE pmdn_t.pmdn007
   DEFINE l_sum_qty     LIKE pmdn_t.pmdn007

   DEFINE l_imaf158     LIKE imaf_t.imaf158
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_pmal002     LIKE pmal_t.pmal002  
   #DEFINE l_n         LIKE type_t.num5    #170104-00066#1 17/01/05 mark by rainy 
   DEFINE l_n          LIKE type_t.num10    #170104-00066#1 17/01/05 add by rainy 
   DEFINE l_pmdbdocno  LIKE pmdb_t.pmdbdocno
   DEFINE l_pspc004     LIKE pspc_t.pspc004
   DEFINE l_pmdbseq     LIKE pmdb_t.pmdbseq
   DEFINE l_pspc034     LIKE pspc_t.pspc034
   DEFINE l_pmdb033     LIKE pmdb_t.pmdb033
   DEFINE l_pmdb014     LIKE pmdb_t.pmdb014
   DEFINE l_pmdb015     LIKE pmdb_t.pmdb015
   DEFINE l_pmdb050     LIKE pmdb_t.pmdb050     #備註  
   
   DEFINE l_pmdl009     LIKE pmdl_t.pmdl009
   DEFINE l_pmdl010     LIKE pmdl_t.pmdl010
   DEFINE l_pmdl011     LIKE pmdl_t.pmdl011
   DEFINE l_pmdl015     LIKE pmdl_t.pmdl015
   DEFINE l_pmdl017     LIKE pmdl_t.pmdl017
   DEFINE l_pmdl023     LIKE pmdl_t.pmdl023
   DEFINE l_pmdl054     LIKE pmdl_t.pmdl054

   #mod--161109-00085#14 By 08993--(s)
#   DEFINE l_pmdn      RECORD LIKE pmdn_t.*   #mark--161109-00085#14 By 08993--(s)
   DEFINE l_pmdn RECORD  #採購單身明細檔
          pmdnent LIKE pmdn_t.pmdnent, #企業編號
          pmdnsite LIKE pmdn_t.pmdnsite, #營運據點
          pmdnunit LIKE pmdn_t.pmdnunit, #應用組織
          pmdndocno LIKE pmdn_t.pmdndocno, #採購單號
          pmdnseq LIKE pmdn_t.pmdnseq, #項次
          pmdn001 LIKE pmdn_t.pmdn001, #料件編號
          pmdn002 LIKE pmdn_t.pmdn002, #產品特徵
          pmdn003 LIKE pmdn_t.pmdn003, #包裝容器
          pmdn004 LIKE pmdn_t.pmdn004, #作業編號
          pmdn005 LIKE pmdn_t.pmdn005, #作業序
          pmdn006 LIKE pmdn_t.pmdn006, #採購單位
          pmdn007 LIKE pmdn_t.pmdn007, #採購數量
          pmdn008 LIKE pmdn_t.pmdn008, #參考單位
          pmdn009 LIKE pmdn_t.pmdn009, #參考數量
          pmdn010 LIKE pmdn_t.pmdn010, #計價單位
          pmdn011 LIKE pmdn_t.pmdn011, #計價數量
          pmdn012 LIKE pmdn_t.pmdn012, #出貨日期
          pmdn013 LIKE pmdn_t.pmdn013, #到廠日期
          pmdn014 LIKE pmdn_t.pmdn014, #到庫日期
          pmdn015 LIKE pmdn_t.pmdn015, #單價
          pmdn016 LIKE pmdn_t.pmdn016, #稅別
          pmdn017 LIKE pmdn_t.pmdn017, #稅率
          pmdn019 LIKE pmdn_t.pmdn019, #子件特性
          pmdn020 LIKE pmdn_t.pmdn020, #緊急度
          pmdn021 LIKE pmdn_t.pmdn021, #保稅
          pmdn022 LIKE pmdn_t.pmdn022, #部分交貨
          pmdnorga LIKE pmdn_t.pmdnorga, #付款據點
          pmdn023 LIKE pmdn_t.pmdn023, #送貨供應商
          pmdn024 LIKE pmdn_t.pmdn024, #多交期
          pmdn025 LIKE pmdn_t.pmdn025, #收貨地址編號
          pmdn026 LIKE pmdn_t.pmdn026, #帳款地址編號
          pmdn027 LIKE pmdn_t.pmdn027, #供應商料號
          pmdn028 LIKE pmdn_t.pmdn028, #收貨庫位
          pmdn029 LIKE pmdn_t.pmdn029, #收貨儲位
          pmdn030 LIKE pmdn_t.pmdn030, #收貨批號
          pmdn031 LIKE pmdn_t.pmdn031, #運輸方式
          pmdn032 LIKE pmdn_t.pmdn032, #取貨模式
          pmdn033 LIKE pmdn_t.pmdn033, #備品率
          pmdn034 LIKE pmdn_t.pmdn034, #no use
          pmdn035 LIKE pmdn_t.pmdn035, #價格核決
          pmdn036 LIKE pmdn_t.pmdn036, #專案編號
          pmdn037 LIKE pmdn_t.pmdn037, #WBS編號
          pmdn038 LIKE pmdn_t.pmdn038, #活動編號
          pmdn039 LIKE pmdn_t.pmdn039, #費用原因
          pmdn040 LIKE pmdn_t.pmdn040, #取價來源
          pmdn041 LIKE pmdn_t.pmdn041, #價格參考單號
          pmdn042 LIKE pmdn_t.pmdn042, #價格參考項次
          pmdn043 LIKE pmdn_t.pmdn043, #取出價格
          pmdn044 LIKE pmdn_t.pmdn044, #價差比
          pmdn045 LIKE pmdn_t.pmdn045, #行狀態
          pmdn046 LIKE pmdn_t.pmdn046, #未稅金額
          pmdn047 LIKE pmdn_t.pmdn047, #含稅金額
          pmdn048 LIKE pmdn_t.pmdn048, #稅額
          pmdn049 LIKE pmdn_t.pmdn049, #理由碼
          pmdn050 LIKE pmdn_t.pmdn050, #備註
          pmdn051 LIKE pmdn_t.pmdn051, #留置/結案理由碼
          pmdn052 LIKE pmdn_t.pmdn052, #檢驗否
          pmdn053 LIKE pmdn_t.pmdn053, #庫存管理特徵
          pmdn200 LIKE pmdn_t.pmdn200, #商品條碼
          pmdn201 LIKE pmdn_t.pmdn201, #包裝單位
          pmdn202 LIKE pmdn_t.pmdn202, #包裝數量
          pmdn203 LIKE pmdn_t.pmdn203, #收貨部門
          pmdn204 LIKE pmdn_t.pmdn204, #No Use
          pmdn205 LIKE pmdn_t.pmdn205, #要貨組織
          pmdn206 LIKE pmdn_t.pmdn206, #庫存量
          pmdn207 LIKE pmdn_t.pmdn207, #採購在途量
          pmdn208 LIKE pmdn_t.pmdn208, #前日銷售量
          pmdn209 LIKE pmdn_t.pmdn209, #上月銷量
          pmdn210 LIKE pmdn_t.pmdn210, #第一週銷量
          pmdn211 LIKE pmdn_t.pmdn211, #第二週銷量
          pmdn212 LIKE pmdn_t.pmdn212, #第三週銷量
          pmdn213 LIKE pmdn_t.pmdn213, #第四週銷量
          pmdn214 LIKE pmdn_t.pmdn214, #採購通路
          pmdn215 LIKE pmdn_t.pmdn215, #通路性質
          pmdn216 LIKE pmdn_t.pmdn216, #經營方式
          pmdn217 LIKE pmdn_t.pmdn217, #結算方式
          pmdn218 LIKE pmdn_t.pmdn218, #合約編號
          pmdn219 LIKE pmdn_t.pmdn219, #協議編號
          pmdn220 LIKE pmdn_t.pmdn220, #採購人員
          pmdn221 LIKE pmdn_t.pmdn221, #採購部門
          pmdn222 LIKE pmdn_t.pmdn222, #採購中心
          pmdn223 LIKE pmdn_t.pmdn223, #配送中心
          pmdn224 LIKE pmdn_t.pmdn224, #採購失效日
          pmdn900 LIKE pmdn_t.pmdn900, #保留欄位str
          pmdn999 LIKE pmdn_t.pmdn999, #保留欄位end
          #161109-00085#61 --s add
          pmdnud001 LIKE pmdn_t.pmdnud001, #自定義欄位(文字)001
          pmdnud002 LIKE pmdn_t.pmdnud002, #自定義欄位(文字)002
          pmdnud003 LIKE pmdn_t.pmdnud003, #自定義欄位(文字)003
          pmdnud004 LIKE pmdn_t.pmdnud004, #自定義欄位(文字)004
          pmdnud005 LIKE pmdn_t.pmdnud005, #自定義欄位(文字)005
          pmdnud006 LIKE pmdn_t.pmdnud006, #自定義欄位(文字)006
          pmdnud007 LIKE pmdn_t.pmdnud007, #自定義欄位(文字)007
          pmdnud008 LIKE pmdn_t.pmdnud008, #自定義欄位(文字)008
          pmdnud009 LIKE pmdn_t.pmdnud009, #自定義欄位(文字)009
          pmdnud010 LIKE pmdn_t.pmdnud010, #自定義欄位(文字)010
          pmdnud011 LIKE pmdn_t.pmdnud011, #自定義欄位(數字)011
          pmdnud012 LIKE pmdn_t.pmdnud012, #自定義欄位(數字)012
          pmdnud013 LIKE pmdn_t.pmdnud013, #自定義欄位(數字)013
          pmdnud014 LIKE pmdn_t.pmdnud014, #自定義欄位(數字)014
          pmdnud015 LIKE pmdn_t.pmdnud015, #自定義欄位(數字)015
          pmdnud016 LIKE pmdn_t.pmdnud016, #自定義欄位(數字)016
          pmdnud017 LIKE pmdn_t.pmdnud017, #自定義欄位(數字)017
          pmdnud018 LIKE pmdn_t.pmdnud018, #自定義欄位(數字)018
          pmdnud019 LIKE pmdn_t.pmdnud019, #自定義欄位(數字)019
          pmdnud020 LIKE pmdn_t.pmdnud020, #自定義欄位(數字)020
          pmdnud021 LIKE pmdn_t.pmdnud021, #自定義欄位(日期時間)021
          pmdnud022 LIKE pmdn_t.pmdnud022, #自定義欄位(日期時間)022
          pmdnud023 LIKE pmdn_t.pmdnud023, #自定義欄位(日期時間)023
          pmdnud024 LIKE pmdn_t.pmdnud024, #自定義欄位(日期時間)024
          pmdnud025 LIKE pmdn_t.pmdnud025, #自定義欄位(日期時間)025
          pmdnud026 LIKE pmdn_t.pmdnud026, #自定義欄位(日期時間)026
          pmdnud027 LIKE pmdn_t.pmdnud027, #自定義欄位(日期時間)027
          pmdnud028 LIKE pmdn_t.pmdnud028, #自定義欄位(日期時間)028
          pmdnud029 LIKE pmdn_t.pmdnud029, #自定義欄位(日期時間)029
          pmdnud030 LIKE pmdn_t.pmdnud030, #自定義欄位(日期時間)030
          #161109-00085#61 --e add
          pmdn225 LIKE pmdn_t.pmdn225, #最終收貨組織
          pmdn054 LIKE pmdn_t.pmdn054, #還料數量
          pmdn055 LIKE pmdn_t.pmdn055, #還量參考數量
          pmdn056 LIKE pmdn_t.pmdn056, #還價數量
          pmdn057 LIKE pmdn_t.pmdn057, #還價參考數量
          pmdn226 LIKE pmdn_t.pmdn226, #長效期每次送貨量
          pmdn227 LIKE pmdn_t.pmdn227, #補貨規格說明
          pmdn058 LIKE pmdn_t.pmdn058, #預算科目
          pmdn228 LIKE pmdn_t.pmdn228  #商品品類
   END RECORD
   #mod--161109-00085#14 By 08993--(e)  
   #mod--161109-00085#14 By 08993--(s)
#   DEFINE l_pmdp        RECORD LIKE pmdp_t.*   #mark--161109-00085#14 By 08993--(s)
   DEFINE l_pmdp RECORD  #採購關聯單據明細檔
          pmdpent LIKE pmdp_t.pmdpent, #企業編號
          pmdpsite LIKE pmdp_t.pmdpsite, #營運據點
          pmdpdocno LIKE pmdp_t.pmdpdocno, #採購單號
          pmdpseq LIKE pmdp_t.pmdpseq, #採購項次
          pmdpseq1 LIKE pmdp_t.pmdpseq1, #項序
          pmdp001 LIKE pmdp_t.pmdp001, #料件編號
          pmdp002 LIKE pmdp_t.pmdp002, #產品特徵
          pmdp003 LIKE pmdp_t.pmdp003, #來源單號
          pmdp004 LIKE pmdp_t.pmdp004, #來源項次
          pmdp005 LIKE pmdp_t.pmdp005, #來源項序
          pmdp006 LIKE pmdp_t.pmdp006, #來源分批序
          pmdp007 LIKE pmdp_t.pmdp007, #來源料號
          pmdp008 LIKE pmdp_t.pmdp008, #來源產品特徵
          pmdp009 LIKE pmdp_t.pmdp009, #來源作業編號
          pmdp010 LIKE pmdp_t.pmdp010, #來源作業序
          pmdp011 LIKE pmdp_t.pmdp011, #來源BOM特性
          pmdp012 LIKE pmdp_t.pmdp012, #來源生產控制組
          pmdp021 LIKE pmdp_t.pmdp021, #沖銷順序
          pmdp022 LIKE pmdp_t.pmdp022, #需求單位
          pmdp023 LIKE pmdp_t.pmdp023, #需求數量
          pmdp024 LIKE pmdp_t.pmdp024, #折合採購量
          pmdp025 LIKE pmdp_t.pmdp025, #已收貨量
          pmdp026 LIKE pmdp_t.pmdp026, #已入庫量
          pmdp900 LIKE pmdp_t.pmdp900, #保留欄位str
         #pmdp999 LIKE pmdp_t.pmdp999  #保留欄位end #161109-00085#61 mark
          #161109-00085#61 --s add
          pmdp999 LIKE pmdp_t.pmdp999, #保留欄位end
          pmdpud001 LIKE pmdp_t.pmdpud001, #自定義欄位(文字)001
          pmdpud002 LIKE pmdp_t.pmdpud002, #自定義欄位(文字)002
          pmdpud003 LIKE pmdp_t.pmdpud003, #自定義欄位(文字)003
          pmdpud004 LIKE pmdp_t.pmdpud004, #自定義欄位(文字)004
          pmdpud005 LIKE pmdp_t.pmdpud005, #自定義欄位(文字)005
          pmdpud006 LIKE pmdp_t.pmdpud006, #自定義欄位(文字)006
          pmdpud007 LIKE pmdp_t.pmdpud007, #自定義欄位(文字)007
          pmdpud008 LIKE pmdp_t.pmdpud008, #自定義欄位(文字)008
          pmdpud009 LIKE pmdp_t.pmdpud009, #自定義欄位(文字)009
          pmdpud010 LIKE pmdp_t.pmdpud010, #自定義欄位(文字)010
          pmdpud011 LIKE pmdp_t.pmdpud011, #自定義欄位(數字)011
          pmdpud012 LIKE pmdp_t.pmdpud012, #自定義欄位(數字)012
          pmdpud013 LIKE pmdp_t.pmdpud013, #自定義欄位(數字)013
          pmdpud014 LIKE pmdp_t.pmdpud014, #自定義欄位(數字)014
          pmdpud015 LIKE pmdp_t.pmdpud015, #自定義欄位(數字)015
          pmdpud016 LIKE pmdp_t.pmdpud016, #自定義欄位(數字)016
          pmdpud017 LIKE pmdp_t.pmdpud017, #自定義欄位(數字)017
          pmdpud018 LIKE pmdp_t.pmdpud018, #自定義欄位(數字)018
          pmdpud019 LIKE pmdp_t.pmdpud019, #自定義欄位(數字)019
          pmdpud020 LIKE pmdp_t.pmdpud020, #自定義欄位(數字)020
          pmdpud021 LIKE pmdp_t.pmdpud021, #自定義欄位(日期時間)021
          pmdpud022 LIKE pmdp_t.pmdpud022, #自定義欄位(日期時間)022
          pmdpud023 LIKE pmdp_t.pmdpud023, #自定義欄位(日期時間)023
          pmdpud024 LIKE pmdp_t.pmdpud024, #自定義欄位(日期時間)024
          pmdpud025 LIKE pmdp_t.pmdpud025, #自定義欄位(日期時間)025
          pmdpud026 LIKE pmdp_t.pmdpud026, #自定義欄位(日期時間)026
          pmdpud027 LIKE pmdp_t.pmdpud027, #自定義欄位(日期時間)027
          pmdpud028 LIKE pmdp_t.pmdpud028, #自定義欄位(日期時間)028
          pmdpud029 LIKE pmdp_t.pmdpud029, #自定義欄位(日期時間)029
          pmdpud030 LIKE pmdp_t.pmdpud030  #自定義欄位(日期時間)030
          #161109-00085#61 --e add
   END RECORD
   #mod--161109-00085#14 By 08993--(e)
   
   
   
   
   DEFINE l_ooba002     LIKE ooba_t.ooba002
   
   WHENEVER ERROR CONTINUE 

   #重新產生前 需先將舊資料刪除 
   DELETE FROM p610_tmp02;       #160727-00019#15 Mod   p610_03_pmdn_rel_t -->p610_tmp02
   DELETE FROM p610_tmp03;       #160727-00019#15 Mod   p610_03_pmdp_rel_t -->p610_tmp03

   IF g_apsp610_03_input.sscb01 = '1' THEN         #依不同交期匯總   
      #160601-00032#3 20160613 modify by ming -----(S) 
      ##160512-00016#5 20160601 modify by ming -----(S) 
      ##LET l_sql = "SELECT pmdl004,pmdl025,pmdl026,pmdn001,pmdn002,pmdn006,SUM(pmdn007), ",
      ##            "       pmdn008,SUM(pmdn009),pmdn010,SUM(pmdn011),pmdn050, ",
      ##            "       pmdn058,pmdn036,pmdn037,pmdn038,pmdbdocno,pmdbseq ",
      ##            "  FROM p610_02_pmdn_t ",
      ##            " GROUP BY pmdl004,pmdl025,pmdl026,pmdn001,pmdn002, ",
      ##            "          pmdn006,pmdn008,pmdn010,pmdn050,pmdn058, ",
      ##            "          pmdn036,pmdn037,pmdn038,pmdbdocno,pmdbseq ",
      ##            " ORDER BY pmdl004,pmdl025,pmdl026,pmdn001,pmdn002, ",
      ##            "          pmdn006,pmdn008,pmdn010,pmdn050,pmdn058, ",
      ##            "          pmdn036,pmdn037,pmdn038,pmdbdocno,pmdbseq "
      #LET l_sql = "SELECT pmdl004,pmdl025,pmdl026,pmdn001,pmdn002,pspc062, ", 
      #            "       pmdn006,SUM(pmdn007), ",
      #            "       pmdn008,SUM(pmdn009),pmdn010,SUM(pmdn011),pmdn050, ",
      #            "       pmdn058,pmdn036,pmdn037,pmdn038,pmdbdocno,pmdbseq ",
      #            "  FROM p610_02_pmdn_t ",
      #            " GROUP BY pmdl004,pmdl025,pmdl026,pmdn001,pmdn002, ",
      #            "          pspc062,",
      #            "          pmdn006,pmdn008,pmdn010,pmdn050,pmdn058, ",
      #            "          pmdn036,pmdn037,pmdn038,pmdbdocno,pmdbseq ",
      #            " ORDER BY pmdl004,pmdl025,pmdl026,pmdn001,pmdn002, ",
      #            "          pspc062,",
      #            "          pmdn006,pmdn008,pmdn010,pmdn050,pmdn058, ",
      #            "          pmdn036,pmdn037,pmdn038,pmdbdocno,pmdbseq "
      ##160512-00016#5 20160601 modify by ming -----(E)  
      LET l_sql = "SELECT pmdl004,pmdl025,pmdl026,pmdn001,pmdn002,pspc062, ",
                  "       pmdn006,SUM(pmdn007), ",
                  "       pmdn008,SUM(pmdn009),pmdn010,SUM(pmdn011),pmdn050, ",
                  "       pmdn058,pmdn036,pmdn037,pmdn038,pmdbdocno,pmdbseq, ",
                  "       pmdn053",
                  "  FROM p610_02_pmdn_t ",
                  " GROUP BY pmdl004,pmdl025,pmdl026,pmdn001,pmdn002, ",
                  "          pspc062,",
                  "          pmdn006,pmdn008,pmdn010,pmdn050,pmdn058, ",
                  "          pmdn036,pmdn037,pmdn038,pmdbdocno,pmdbseq, ",
                  "          pmdn053 ",
                  " ORDER BY pmdl004,pmdl025,pmdl026,pmdn001,pmdn002, ",
                  "          pspc062,",
                  "          pmdn006,pmdn008,pmdn010,pmdn050,pmdn058, ",
                  "          pmdn036,pmdn037,pmdn038,pmdbdocno,pmdbseq, ",
                  "          pmdn053"
      #160601-00032#3 20160613 modify by ming -----(E) 
      
      PREPARE apsp610_03_group_02_pmdn_prep FROM l_sql
      DECLARE apsp610_03_group_02_pmdn_curs CURSOR FOR apsp610_03_group_02_pmdn_prep

      FOREACH apsp610_03_group_02_pmdn_curs INTO l_pmdl004,l_pmdl025,l_pmdl026,
                                                 l_pmdn001,l_pmdn002,
                                                 l_pmdn021,     #160512-00016#5 20160601 add 
                                                 l_pmdn006,l_sum_pmdn007,
                                                 l_pmdn008,l_sum_pmdn009,
                                                 l_pmdn010,l_sum_pmdn011,
                                                 l_pmdn050,l_pmdn058,l_pmdn036,l_pmdn037,l_pmdn038,
                                                 l_pmdbdocno,l_pmdbseq, 
                                                 l_pmdn053     #160601-00032#3 20160613 add 

         IF STATUS THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'foreach:'
            LET g_errparam.code   = STATUS
            LET g_errparam.popup  = TRUE
            CALL cl_err()

            EXIT FOREACH 
         END IF
         
         #160825-00037#3-s-add
         IF g_apsp610_02_input.chk1 = 'N' THEN
            LET l_pmdn053 = ''
         END IF
         #160825-00037#3-e-add
         
         LET l_qty1 = l_sum_pmdn007

         #應該在這裡就實際開始做pmdn的設定 
         INITIALIZE l_pmdn.* TO NULL

         #設定項次 
         SELECT MAX(pmdnseq) + 1 INTO l_pmdn.pmdnseq
           FROM p610_tmp02          #160727-00019#15 Mod   p610_03_pmdn_rel_t -->p610_tmp02
          WHERE pmdl004 = l_pmdl004 
            AND NVL(pmdl025,' ') = NVL(l_pmdl025,' ')
            AND NVL(pmdl026,' ') = NVL(l_pmdl026,' ')
         IF cl_null(l_pmdn.pmdnseq) OR l_pmdn.pmdnseq = 0 THEN
            LET l_pmdn.pmdnseq = 1
         END IF

         LET l_pmdn.pmdn001 = l_pmdn001

         LET l_pmdn.pmdn002 = l_pmdn002

         #因為在第二步時 會有依料號+需求日做匯總 所以相同的料還是會有不同需求日的問題 
         #所以還是要取最小的需求日 

         #計算交貨、到廠、到庫日期
         #  採構匯總策略選擇"1:不同交期匯總取價"時，則取匯總資料中需求日期最早的那一筆，
         #若採構匯總策略選擇"2:不同交期拆解"，則等於匯總的需求日期
         SELECT MIN(pspc045) INTO l_pmdn.pmdn014
           FROM p610_02_pmdn_t
          WHERE pmdn001 = l_pmdn001
            AND NVL(pmdn002,' ') = NVL(l_pmdn002,' ')
            AND pmdn021 = l_pmdn021                #160512-00016#5 20160601 add 
            AND pmdn006 = l_pmdn006 
            AND NVL(pmdn008,' ') = NVL(l_pmdn008,' ')
            AND NVL(pmdn010,' ') = NVL(l_pmdn010,' ')
            AND NVL(pmdn050,' ') = NVL(l_pmdn050,' ') 
            AND NVL(pmdn058,' ') = NVL(l_pmdn058,' ')
            AND NVL(pmdn036,' ') = NVL(l_pmdn036,' ')
            AND NVL(pmdn037,' ') = NVL(l_pmdn037,' ')
            AND NVL(pmdn038,' ') = NVL(l_pmdn038,' ')
            AND NVL(pmdbdocno,' ') = NVL(l_pmdbdocno,' ') 
            AND NVL(pmdbseq,0) = NVL(l_pmdbseq,0)
            AND NVL(pmdn053,' ') = NVL(l_pmdn053,' ')    #160601-00032#3 20160613 add 
            AND pmdl004 = l_pmdl004 
            AND NVL(pmdl025,' ') = NVL(l_pmdl025,' ')
            AND NVL(pmdl026,' ') = NVL(l_pmdl026,' ')

         #若到廠日期為NULL時，輸入到庫日期後需自動計算到廠日期，公式為到庫日期-[T:料件據點進銷存檔].[C:到庫前置時間]
         #若交貨日期為NULL時，輸入到庫日期後需自動計算交貨日期，公式為到廠日期-[T:料件據點進銷存檔].[C:到廠前置時間]
         CALL apsp610_03_date_count(l_pmdn.pmdn001,l_pmdn.pmdn014)
              RETURNING l_pmdn.pmdn013,l_pmdn.pmdn012

         LET l_pmdn.pmdn020 = '1'       #緊急度  
         #根據到庫日期計算緊急度 
         CALL apsp610_03_pmdn014_to_pmdn020(l_pmdn.pmdn001,l_pmdn.pmdn014) RETURNING l_pmdn.pmdn020

         #採購欄位賦初始值
         LET l_pmdn.pmdn019 = '1'    #料件子特性 
         #[C:備品率] = [T:料件進銷存檔].[C:採購備品率]  imaf165
         #[C:參考單位] = [T:料件進銷存檔][C:參考單位]   imaf015
         #若[T:料件進銷存檔].[C:接單拆解方式(採購)]的值為'1:自動CKD'或是'2:自動SKD'時，imaf158
         #則[C:子件特性]的值預設'2:CKD'或是'3:SKD'

         LET l_pmdn.pmdn033 = ''
         LET l_imaf158 = ''
         SELECT imaf158,imaf165,imaf015
           INTO l_imaf158,l_pmdn.pmdn033,l_pmdn.pmdn008
           FROM imaf_t
          WHERE imafent = g_enterprise
            AND imafsite = g_site
            AND imaf001 = l_pmdn.pmdn001

         LET l_pmdn.pmdn006 = l_pmdn006 
         LET l_pmdn.pmdn007 = l_sum_pmdn007
         
         #因為在第二步的時候已經有設定了，所以這裡就直接給值即可 
         LET l_pmdn.pmdn008 = l_pmdn008
         LET l_pmdn.pmdn009 = l_sum_pmdn009

         #pmdn019:子件特性 
         CASE l_imaf158
            WHEN '1'
               LET l_pmdn.pmdn019 = '2'
            WHEN '2'
               LET l_pmdn.pmdn019 = '3'
         END CASE

         #160512-00016#5 20160601 modify by ming -----(S) 
         #LET l_pmdn.pmdn021 = 'N'
         LET l_pmdn.pmdn021 = l_pmdn021 
         #160512-00016#5 20160601 modify by ming -----(E) 
         LET l_pmdn.pmdn022 = 'Y'
         LET l_pmdn.pmdn024 = 'N'    #多交期否  

         LET l_pmdn.pmdn032 = '1'
         LET l_pmdn.pmdn035 = '1'
         LET l_pmdn.pmdn040 = '1'
         LET l_pmdn.pmdn045 = '1'
         LET l_pmdn.pmdn028 = ''
         #150821#150819-00010 by whitney add start
         CALL s_aooi200_get_slip(g_apsp610_01_input.pmdldocno) RETURNING l_success,l_ooba002
         CALL cl_get_doc_para(g_enterprise,g_site,l_ooba002,'D-MFG-0076') RETURNING l_pmdn.pmdn028
         #150821#150819-00010 by whitney add end
         LET l_pmdn.pmdn029 = ''
         LET l_pmdn.pmdn003 = ''

         #取得控制組 
         SELECT pmal002 INTO l_pmal002
           FROM p610_03_pmdl_t
          WHERE pmdl004 = l_pmdl004
         IF NOT cl_null(l_pmal002) THEN
            LET l_n = 0
            SELECT COUNT(*) INTO l_n 
              FROM pmap_t
             WHERE pmapent  = g_enterprise
               AND pmapsite = g_site
               AND pmap001  = l_pmdl004
               AND pmap002  = l_pmal002
               AND pmap003  = l_pmdn.pmdn001
               AND pmap004  = l_pmdn.pmdn002

            #若採購料件有設置'供應商控制組料件預設條件'(apmi121)時，則需將設置的預設條件值預設到採購單對應欄位
            IF l_n > 0 THEN 
               #2015/01/05 採購不再預設庫儲，否則會導致收貨、入庫時無法修改倉儲資料 
               SELECT pmap009pmap012,pmap014,pmap005
                 INTO l_pmdn.pmdnunit,l_pmdn.pmdn025,l_pmdn.pmdn031,l_pmdn.pmdn003
                 FROM pmdp_t
                WHERE pmdpent  = g_enterprise
                  AND pmdpsite = g_site
                  AND pmap001  = l_pmdl004
                  AND pmap002  = l_pmal002
                  AND pmap003  = l_pmdn.pmdn001
                  AND pmap004  = l_pmdn.pmdn002
            END IF
         END IF
         IF cl_null(l_pmal002) OR l_n = 0 THEN
            #沒有設置'供應商控制組料件預設條件'(apmi121)才改抓料件進銷存檔預設的條件
            #2015/01/05 採購不再預設庫儲，否則會導致收貨、入庫時無法修改倉儲資料
            SELECT imaf157
              INTO l_pmdn.pmdn003
              FROM imaf_t
             WHERE imafent  = g_enterprise
               AND imafsite = g_site
               AND imaf001  = l_pmdn.pmdn001 
         END IF

         #若採購料件有設置'交易對象對應料號'(apmi070)有供應商料號時，需將對應的料號抓出顯示在
         #[C:供應商料號]欄位上，若有設置多筆對應料號時以有勾選主要對應料那一筆為預設值
         LET l_pmdn.pmdn027 = ''
         SELECT pmao004 INTO l_pmdn.pmdn027
           FROM pmao_t
          WHERE pmaoent = g_enterprise
            AND pmao001 = l_pmdl004
            AND pmao002 = l_pmdn.pmdn001
            AND pmao003 = l_pmdn.pmdn002
            AND pmao000 = '1'    #161221-00064#23 add
            AND pmao007 = 'Y'

         IF cl_null(l_pmdn.pmdn027) THEN
            SELECT pmao004 INTO l_pmdn.pmdn027
              FROM pmao_t
             WHERE pmaoent = g_enterprise
               AND pmao001 = l_pmdl004
               AND pmao002 = l_pmdn.pmdn001
               AND pmao003 = l_pmdn.pmdn002
               AND pmao000 = '1'    #161221-00064#23 add
               AND rownum  = 1
         END IF

         #調用元件取單價
         LET l_pmdn.pmdn015 = 0 
         
         #取得單頭的資料  
         SELECT pmdl009,pmdl010,pmdl011,pmdl015,pmdl017,pmdl023,pmdl054
           INTO l_pmdl009,l_pmdl010,l_pmdl011,l_pmdl015,l_pmdl017,l_pmdl023,l_pmdl054
           FROM p610_03_pmdl_t
          WHERE pmdl004 = l_pmdl004        
            AND NVL(pmdl025,' ') = NVL(l_pmdl025,' ')
            AND NVL(pmdl026,' ') = NVL(l_pmdl026,' ')

         IF NOT (cl_null(l_pmdl017) OR cl_null(l_pmdl004) OR cl_null(l_pmdn001) OR
                 cl_null(l_pmdl015) OR cl_null(l_pmdl011) OR cl_null(l_pmdl009) OR
                 cl_null(l_pmdl010) OR cl_null(l_pmdl023) OR cl_null(l_pmdn010) OR 
                 cl_null(l_pmdl054) OR cl_null(l_sum_pmdn011) ) THEN
            CALL s_purchase_price_get(l_pmdl017,l_pmdl004,l_pmdn001,l_pmdn002,
                                      l_pmdl015,l_pmdl011,l_pmdl009,l_pmdl010,
                                      l_pmdl023,g_apsp610_01_input.pmdldocno,
                                      g_today,l_pmdn010,l_sum_pmdn011,
                                      g_site,l_pmdl054,'1','apmp490','' )
                 RETURNING l_pmdn.pmdn040,l_pmdn.pmdn015,l_pmdn.pmdn041,l_pmdn.pmdn042

            LET l_pmdn.pmdn043 = l_pmdn.pmdn015

         END IF 
         
         LET l_pmdn.pmdn010 = l_pmdn010
         LET l_pmdn.pmdn011 = l_sum_pmdn011

         LET l_pmdn.pmdn016 = l_pmdl011        #稅別  
         CALL s_apmt500_get_amount(g_apsp610_01_input.pmdldocno,l_pmdn.pmdnseq,l_pmdl015,
                                   l_pmdn.pmdn011,l_pmdn.pmdn015,l_pmdn.pmdn016)
              RETURNING l_pmdn.pmdn046,l_pmdn.pmdn048,l_pmdn.pmdn047

         #因為s_apmt500_get_amount會呼叫稅別元件(s_tax)，其中會產生xrcd的資料，所以要做刪除的動作 
         DELETE FROM xrcd_t WHERE xrcdent = g_enterprise
                              #AND xrcdld  = l_ooef017   #因為這裡只有單別，應該是不會有其他相同的資料  
                              AND xrcddocno = g_apsp610_01_input.pmdldocno
                              AND xrcdseq   = l_pmdn.pmdnseq
                              AND xrcdseq2  = '0' 
                              
         LET l_pmdn.pmdn050 = l_pmdn050          
         #160601-00032#3 20160613 add by ming -----(S) 
         LET l_pmdn.pmdn053 = l_pmdn053          
         #160601-00032#3 20160613 add by ming -----(E) 
         LET l_pmdn.pmdn058 = l_pmdn058
         LET l_pmdn.pmdn036 = l_pmdn036 
         LET l_pmdn.pmdn037 = l_pmdn037 
         LET l_pmdn.pmdn038 = l_pmdn038 
         
         #pmdb004:請購料號 
         #pmdb005:請購產品特徵 
         #pmdb007:請購單位 
         #pmdn014:到庫日  
         #pmdn006:採購單位 
         #pmdn007:採購數量 
         #pmdn010:計價單位 
         #pmdn011:計價數量 
         #link_no:與新請購底稿關聯的key  
         
         #當l_pmdbseq是null時，下方的sql會出現字串轉數值的錯誤 
         IF cl_null(l_pmdbseq) THEN
            LET l_pmdbseq = 0
         END IF
         
         LET l_sql = "SELECT pspc050,pspc051,pspc014,pspc045, ",
                     "       pmdn007,pmdn009,pmdn011,link_no ",
                     "  FROM p610_02_pmdn_t ",
                     " WHERE pmdl004 = '",l_pmdl004,"' ", 
                     "   AND NVL(pmdl025,' ') = NVL('",l_pmdl025,"',' ') ",
                     "   AND NVL(pmdl026,' ') = NVL('",l_pmdl026,"',' ') ",
                     "   AND pmdn001 = '",l_pmdn001,"' ",
                     "   AND pmdn002 = '",l_pmdn002,"' ", 
                     "   AND pspc062 = '",l_pmdn021,"' ",   #160512-00016#5 20160601 add 
                     "   AND pmdn006 = '",l_pmdn006,"' ",
                     "   AND NVL(pmdn008,' ') = NVL('",l_pmdn008,"',' ') ",
                     "   AND NVL(pmdn010,' ') = NVL('",l_pmdn010,"',' ') ",
                     "   AND NVL(pmdn050,' ') = NVL('",l_pmdn050,"',' ') ", 
                     "   AND NVL(pmdn058,' ') = NVL('",l_pmdn058,"',' ') ",
                     "   AND NVL(pmdn036,' ') = NVL('",l_pmdn036,"',' ') ",
                     "   AND NVL(pmdn037,' ') = NVL('",l_pmdn037,"',' ') ",
                     "   AND NVL(pmdn038,' ') = NVL('",l_pmdn038,"',' ') ",
                     "   AND NVL(pmdbdocno,' ') = NVL('",l_pmdbdocno,"',' ') ", 
                     "   AND NVL(pmdbseq,0) = NVL('",l_pmdbseq,"',0) ", 
                     "   AND NVL(pmdn053,' ') = NVL('",l_pmdn053,"',' ') ",  #160601-00032#3 20160613 add 
                     " ORDER BY pspc045 "
         PREPARE apsp610_03_pmdn_prep1 FROM l_sql
         DECLARE apsp610_03_pmdn_curs1 CURSOR FOR apsp610_03_pmdn_prep1

         FOREACH apsp610_03_pmdn_curs1 INTO l_pspc050,l_pspc051,l_pspc014,l_pspc045,
                                            l_pmdn007,l_pmdn009,l_pmdn011,l_link_no
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = 'foreach:'
               LET g_errparam.code   = STATUS
               LET g_errparam.popup  = TRUE
               CALL cl_err()

               EXIT FOREACH
            END IF

            IF l_qty1 > l_pmdn007 THEN
               LET l_qty2 = l_pmdn007 
               LET l_qty1 = l_qty1 - l_qty2
            ELSE
               LET l_qty2 = l_qty1
               LET l_qty1 = 0
            END IF

            #pmdbdocno:請購單號 
            #pmdbseq  :項次 
            #pmdb004  :請購料號 
            #pmdb005  :產品特徵 
            #pmdb007  :單位 
            #pmdb006  :需求數量 
            #qty      :被分配的數量 
            #pmdb033  :緊急度  
            #pmdb014  :供應商選擇 
            #pmdb015  :供應商編號 
            #pmdb050  :備註 
            LET l_sql = "SELECT pspc004,'',pspc050,pspc051,pspc014,",
                        "       pspc034,qty,pspc045,'','','', ",
                        "       '' ",
                        "  FROM p610_02_pspc_t ",
                        " WHERE link_no = '",l_link_no,"' ",
                        " ORDER BY pspc045 "
            PREPARE apsp610_03_pmdb_prep1 FROM l_sql
            DECLARE apsp610_03_pmdb_curs1 CURSOR FOR apsp610_03_pmdb_prep1

            FOREACH apsp610_03_pmdb_curs1 INTO l_pspc004,l_pmdbseq,l_pspc050,
                                               l_pspc051,l_pspc014,l_pspc034,
                                               l_qty3,l_pspc045,l_pmdb033,l_pmdb014,
                                               l_pmdb015,l_pmdb050
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = STATUS
                  LET g_errparam.extend = 'foreach:'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
 
                  EXIT FOREACH
               END IF

               IF l_qty2 > l_qty3 THEN
                  LET l_qty_w = l_qty3
                  LET l_qty2 = l_qty2 - l_qty3
               ELSE
                  LET l_qty_w = l_qty2
                  LET l_qty2 = 0
               END IF 
               
               CALL apsp610_03_convert_qty(l_pspc050,l_pmdn006,l_pspc014,l_qty_w)
                    RETURNING l_new_qty_w

               INITIALIZE l_pmdp.* TO NULL

               LET l_pmdp.pmdpseq = l_pmdn.pmdnseq          #請購關聯單的項次會等於採購單的項次 

               #設定項序 
               LET l_pmdp.pmdpseq1 = ''
               SELECT MAX(pmdpseq1) + 1 INTO l_pmdp.pmdpseq1
                 FROM p610_tmp03            #160727-00019#15 Mod   p610_03_pmdp_rel_t -->p610_tmp03
                WHERE pmdl004 = l_pmdl004
                  AND pmdpseq = l_pmdn.pmdnseq
               IF cl_null(l_pmdp.pmdpseq1) OR l_pmdp.pmdpseq1 = 0 THEN
                  LET l_pmdp.pmdpseq1 = 1
               END IF

               LET l_pmdp.pmdp003 = l_pspc004
               LET l_pmdp.pmdp004 = l_pmdbseq
               LET l_pmdp.pmdp007 = l_pspc050
               LET l_pmdp.pmdp008 = l_pspc051
               
               #設定沖銷順序 
               SELECT MAX(pmdp021) + 1 INTO l_pmdp.pmdp021
                 FROM p610_tmp03         #160727-00019#15 Mod   p610_03_pmdp_rel_t -->p610_tmp03
                WHERE pmdl004 = l_pmdl004
                  AND pmdpseq = l_pmdn.pmdnseq
               IF cl_null(l_pmdp.pmdp021) OR l_pmdp.pmdp021 = 0 THEN
                  LET l_pmdp.pmdp021 = 1
               END IF
               
               LET l_pmdp.pmdp022 = l_pspc014            #單位 
               LET l_pmdp.pmdp023 = l_new_qty_w           #需求數量 
               LET l_pmdp.pmdp024 = l_qty_w               #折合採購量 

               #如果需求日會有不一樣的資料，就是多交期  
               IF l_pspc045 != l_pmdn.pmdn014 THEN
                  LET l_pmdn.pmdn024 = 'Y'
               END IF

               INSERT INTO p610_tmp03(pmdpseq,pmdpseq1,pmdp001,pspc004,           #160727-00019#15 Mod   p610_03_pmdp_rel_t -->p610_tmp03
                                              pmdp004,pmdp007,pmdp008,pmdp021,
                                              pmdp022,pmdp023,pmdp024,pspc045,pmdb033,max_pmdp023,
                                              pmdl004,pmdl025,pmdl026,pmdb050)
                                       VALUES(l_pmdp.pmdpseq,l_pmdp.pmdpseq1,l_pmdn.pmdn001,l_pspc004,
                                              l_pmdp.pmdp004,l_pmdp.pmdp007,l_pmdp.pmdp008,l_pmdp.pmdp021,
                                              l_pmdp.pmdp022,l_pmdp.pmdp023,l_pmdp.pmdp024,l_pspc045,
                                              l_pmdb033,l_qty3,l_pmdl004,l_pmdl025,l_pmdl026,l_pmdb050)

               IF l_qty2 = 0 THEN
                  EXIT FOREACH
               END IF
            END FOREACH

            IF l_qty1 = 0 THEN
               EXIT FOREACH
            END IF

         END FOREACH 
         #寫入採購明細資料中 之後就更新此table 並以此table產生資料即可 

         INSERT INTO p610_tmp02(pmdnseq,pmdn001,pmdn002,pmdn006,pmdn007,           #160727-00019#15 Mod   p610_03_pmdn_rel_t -->p610_tmp02
                                pmdn008,pmdn009,pmdn010,pmdn011,pmdn012,
                                pmdn013,pmdn014,pmdn015,pmdl004,
                                pmdl025,pmdl026,
                                pmdn003,
                                pmdn019,pmdn020,pmdn021,
                                pmdn022,pmdn024,pmdn027,pmdn028,pmdn029,
                                pmdn032,pmdn033,pmdn035,pmdn036,pmdn037,pmdn038,
                                pmdn040,pmdn041,pmdn042,pmdn043,pmdn045,
                                pmdn046,pmdn047,pmdn048,pmdn050,pmdbdocno,pmdbseq,
                                pmdn053,     #160601-00032#3 20160613 add 
                                pmdn058,pmdnunit,pmdnorga)
                         VALUES(l_pmdn.pmdnseq,l_pmdn.pmdn001,l_pmdn.pmdn002,
                                l_pmdn.pmdn006,l_sum_pmdn007,l_pmdn.pmdn008, 
                                l_sum_pmdn009,l_pmdn010,l_sum_pmdn011,l_pmdn.pmdn012,
                                l_pmdn.pmdn013,l_pmdn.pmdn014,l_pmdn.pmdn015,
                                l_pmdl004,
                                l_pmdl025,l_pmdl026,
                                l_pmdn.pmdn003,
                                l_pmdn.pmdn019,l_pmdn.pmdn020,l_pmdn.pmdn021,
                                l_pmdn.pmdn022,l_pmdn.pmdn024,l_pmdn.pmdn027,
                                l_pmdn.pmdn028,l_pmdn.pmdn029,l_pmdn.pmdn032,
                                l_pmdn.pmdn033,l_pmdn.pmdn035,l_pmdn.pmdn036,
                                l_pmdn.pmdn037,l_pmdn.pmdn038,l_pmdn.pmdn040,
                                l_pmdn.pmdn041,l_pmdn.pmdn042,
                                l_pmdn.pmdn043,
                                l_pmdn.pmdn045,l_pmdn.pmdn046,l_pmdn.pmdn047,
                                l_pmdn.pmdn048,l_pmdn.pmdn050,l_pspc004,l_pmdbseq,
                                l_pmdn.pmdn053,     #160601-00032#3 20160613 add 
                                l_pmdn.pmdn058,
                                l_pmdn.pmdnunit,
                                l_pmdn.pmdnorga)
      END FOREACH

   ELSE
      #160601-00032#3 20160613 modify by ming -----(S) 
      ##160512-00016#5 20160601 modify by ming -----(S) 
      ##LET l_sql = "SELECT pmdl004,pmdl025,pmdl026,pmdn001,pmdn002,pmdn006,pmdn007, ",
      ##            "       pmdn008,pmdn009,pmdn010,pmdn011,pmdn050,pmdn058,pmdn036, ",
      ##            "       pmdn037,pmdn038,pmdbdocno,pmdbseq,link_no ",
      ##            "  FROM p610_02_pmdn_t ",
      ##            " ORDER BY pmdl004,pmdl025,pmdl026,pmdn001,pmdn002,pmdn058, ", 
      ##            "          pmdn036,pmdn037,pmdn038,link_no " 
      #LET l_sql = "SELECT pmdl004,pmdl025,pmdl026,pmdn001,pmdn002,pspc062,pmdn006,pmdn007, ",
      #            "       pmdn008,pmdn009,pmdn010,pmdn011,pmdn050,pmdn058,pmdn036, ",
      #            "       pmdn037,pmdn038,pmdbdocno,pmdbseq,link_no ",
      #            "  FROM p610_02_pmdn_t ",
      #            " ORDER BY pmdl004,pmdl025,pmdl026,pmdn001,pmdn002,pspc062,pmdn058, ", 
      #            "          pmdn036,pmdn037,pmdn038,link_no "
      ##160512-00016#5 20160601 modify by ming -----(E) 
      LET l_sql = "SELECT pmdl004,pmdl025,pmdl026,pmdn001,pmdn002,pspc062,pmdn006,pmdn007, ",
                  "       pmdn008,pmdn009,pmdn010,pmdn011,pmdn050,pmdn058,pmdn036, ",
                  "       pmdn037,pmdn038,pmdbdocno,pmdbseq,pmdn053,link_no ",
                  "  FROM p610_02_pmdn_t ",
                  " ORDER BY pmdl004,pmdl025,pmdl026,pmdn001,pmdn002,pspc062,pmdn058, ",
                  "          pmdn036,pmdn037,pmdn038,link_no "
      #160601-00032#3 20160613 modify by ming -----(E) 
      
      PREPARE apsp610_03_pmdn_prep2 FROM l_sql
      DECLARE apsp610_03_pmdn_curs2 CURSOR WITH HOLD FOR apsp610_03_pmdn_prep2 
      #160601-00032#3 20160613 modify by ming -----(S) 
      ##160512-00016#5 20160601 modify by ming -----(S)
      ##FOREACH apsp610_03_pmdn_curs2 INTO l_pmdl004,l_pmdl025,l_pmdl026,l_pmdn001,l_pmdn002,l_pmdn006,
      ##                                   l_pmdn007,l_pmdn008,l_pmdn009,l_pmdn010,
      ##                                   l_pmdn011,l_pmdn050,l_pmdn058,l_pmdn036,
      ##                                   l_pmdn037,l_pmdn038,l_pmdbdocno,l_pmdbseq,l_link_no
      #FOREACH apsp610_03_pmdn_curs2 INTO l_pmdl004,l_pmdl025,l_pmdl026,l_pmdn001,l_pmdn002, 
      #                                   l_pmdn021, 
      #                                   l_pmdn006,
      #                                   l_pmdn007,l_pmdn008,l_pmdn009,l_pmdn010,
      #                                   l_pmdn011,l_pmdn050,l_pmdn058,l_pmdn036,
      #                                   l_pmdn037,l_pmdn038,l_pmdbdocno,l_pmdbseq,l_link_no
      #160512-00016#5 20160601 modify by ming -----(E) 
      FOREACH apsp610_03_pmdn_curs2 INTO l_pmdl004,l_pmdl025,l_pmdl026,l_pmdn001,l_pmdn002,
                                         l_pmdn021,
                                         l_pmdn006,
                                         l_pmdn007,l_pmdn008,l_pmdn009,l_pmdn010,
                                         l_pmdn011,l_pmdn050,l_pmdn058,l_pmdn036,
                                         l_pmdn037,l_pmdn038,l_pmdbdocno,l_pmdbseq,l_pmdn053,l_link_no
      #160601-00032#3 20160613 modify by ming -----(E) 
         IF STATUS THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = STATUS
            LET g_errparam.extend = 'foreach:'
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF
         
         #160825-00037#3-s-add
         IF g_apsp610_02_input.chk1 = 'N' THEN
            LET l_pmdn053 = ''
         END IF
         #160825-00037#3-e-add

         LET l_qty1 = l_pmdn007 
         LET l_qty3 = l_pmdn007

         LET l_sql = "SELECT pspc045,SUM(qty) ",
                     "  FROM p610_02_pspc_t ",
                     " WHERE link_no = '",l_link_no,"' ",
                     " GROUP BY pspc045 ",
                     " ORDER BY pspc045 "
         PREPARE apsp610_03_group_pmdb_prep FROM l_sql
         DECLARE apsp610_03_group_pmdb_curs CURSOR FOR apsp610_03_group_pmdb_prep

         FOREACH apsp610_03_group_pmdb_curs INTO l_pspc045,l_sum_qty
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = 'foreach:'
               LET g_errparam.code   = STATUS
               LET g_errparam.popup  = TRUE
               CALL cl_err()

               EXIT FOREACH
            END IF

            IF l_qty3 > l_sum_qty THEN
               LET l_qty_w = l_sum_qty
               LET l_qty3 = l_qty3 - l_sum_qty
            ELSE
               LET l_qty_w = l_qty3
               LET l_qty3 = 0
            END IF

            #寫pmdn_t  
            INITIALIZE l_pmdn.* TO NULL

            #設定項次 
            SELECT MAX(pmdnseq) + 1 INTO l_pmdn.pmdnseq
              FROM p610_tmp02            #160727-00019#15 Mod   p610_03_pmdn_rel_t -->p610_tmp02
             WHERE pmdl004 = l_pmdl004
            IF cl_null(l_pmdn.pmdnseq) OR l_pmdn.pmdnseq = 0 THEN
               LET l_pmdn.pmdnseq = 1
            END IF

            LET l_pmdn.pmdn001 = l_pmdn001

            LET l_pmdn.pmdn002 = l_pmdn002

            LET l_pmdn.pmdn014 = l_pspc045

            #若到廠日期為NULL時，輸入到庫日期後需自動計算到廠日期，公式為到庫日期-[T:料件據點進銷存檔].[C:到庫前置時間]
            #若交貨日期為NULL時，輸入到庫日期後需自動計算交貨日期，公式為到廠日期-[T:料件據點進銷存檔].[C:到廠前置時間]
            CALL apsp610_03_date_count(l_pmdn.pmdn001,l_pmdn.pmdn014)
                 RETURNING l_pmdn.pmdn013,l_pmdn.pmdn012

            LET l_pmdn.pmdn020 = '1'       #緊急度  
            #根據到庫日期計算緊急度 
            CALL apsp610_03_pmdn014_to_pmdn020(l_pmdn.pmdn001,l_pmdn.pmdn014) RETURNING l_pmdn.pmdn020

            #採購欄位賦初始值
            LET l_pmdn.pmdn019 = '1'    #料件子特性 
            
            LET l_pmdn.pmdn007 = l_qty_w
            
            #[C:備品率] = [T:料件進銷存檔].[C:採購備品率]  imaf165
            #[C:參考單位] = [T:料件進銷存檔][C:參考單位]   imaf015 
            #若[T:料件進銷存檔].[C:接單拆解方式(採購)]的值為'1:自動CKD'或是'2:自動SKD'時，imaf158
            #則[C:子件特性]的值預設'2:CKD'或是'3:SKD'
            
            LET l_pmdn.pmdn033 = ''
            LET l_imaf158 = ''
            SELECT imaf158,imaf165,imaf015
              INTO l_imaf158,l_pmdn.pmdn033,l_pmdn.pmdn008
              FROM imaf_t
             WHERE imafent = g_enterprise
               AND imafsite = g_site
               AND imaf001 = l_pmdn.pmdn001

            LET l_pmdn.pmdn006 = l_pmdn006
            IF cl_get_para(g_enterprise,g_site,'S-BAS-0028') = 'Y' THEN
               #如果有使用參考單位的話，則依單位轉換率做預設 
               LET l_pmdn.pmdn008 = l_pmdn008
               IF (NOT cl_null(l_pmdn.pmdn006)) AND (NOT cl_null(l_pmdn.pmdn008)) THEN
                  CALL apsp610_03_convert_qty(l_pmdn.pmdn001,l_pmdn.pmdn006,
                                              l_pmdn.pmdn008,l_pmdn.pmdn007)
                       RETURNING l_pmdn.pmdn009
               END IF
            ELSE
               LET l_pmdn.pmdn008 = ''
               LET l_pmdn.pmdn009 = ''
            END IF 
            
            IF cl_get_para(g_enterprise,g_site,'S-BAS-0028') = 'Y' THEN 
               LET l_pmdn.pmdn010 = l_pmdn010 
               LET l_pmdn.pmdn011 = l_pmdn011
               IF (NOT cl_null(l_pmdn.pmdn006)) AND (NOT cl_null(l_pmdn.pmdn010)) THEN
                  CALL apsp610_03_convert_qty(l_pmdn.pmdn001,l_pmdn.pmdn006,
                                              l_pmdn.pmdn010,l_pmdn.pmdn007)
                       RETURNING l_pmdn.pmdn011
               END IF
            ELSE
               LET l_pmdn.pmdn010 = l_pmdn.pmdn006
               LET l_pmdn.pmdn011 = l_pmdn.pmdn007
            END IF

            #pmdn019:子件特性 
            CASE l_imaf158
               WHEN '1'
                  LET l_pmdn.pmdn019 = '2'
               WHEN '2'
                  LET l_pmdn.pmdn019 = '3'
            END CASE

            #160512-00016#5 20160601 modify by ming -----(S) 
            #LET l_pmdn.pmdn021 = 'N' 
            LET l_pmdn.pmdn021 = l_pmdn021 
            #160512-00016#5 20160601 modify by ming -----(E) 
            LET l_pmdn.pmdn022 = 'Y'
            LET l_pmdn.pmdn024 = 'N'    #多交期否  

            LET l_pmdn.pmdnunit = g_site
            LET l_pmdn.pmdnorga = g_site

            LET l_pmdn.pmdn032 = '1'
            LET l_pmdn.pmdn035 = '1'
            LET l_pmdn.pmdn040 = '1'
            LET l_pmdn.pmdn045 = '1'
            LET l_pmdn.pmdn028 = ''
            #150821#150819-00010 by whitney add start
            CALL s_aooi200_get_slip(g_apsp610_01_input.pmdldocno) RETURNING l_success,l_ooba002
            CALL cl_get_doc_para(g_enterprise,g_site,l_ooba002,'D-MFG-0076') RETURNING l_pmdn.pmdn028
            #150821#150819-00010 by whitney add end
            LET l_pmdn.pmdn029 = ''
            LET l_pmdn.pmdn003 = ''

            #取得控制組 
            SELECT pmal002 INTO l_pmal002
              FROM p610_03_pmdl_t
             WHERE pmdl004 = l_pmdl004
            IF NOT cl_null(l_pmal002) THEN
               LET l_n = 0
               SELECT COUNT(*) INTO l_n
                 FROM pmap_t
                WHERE pmapent = g_enterprise
                  AND pmapsite = g_site
                  AND pmap001 = l_pmdl004
                  AND pmap002 = l_pmal002
                  AND pmap003 = l_pmdn.pmdn001
                  AND pmap004 = l_pmdn.pmdn002 
               #若採購料件有設置'供應商控制組料件預設條件'(apmi121)時，則需將設置的預設條件值預設到採購單對應欄位
               IF l_n > 0 THEN
                  #2015/01/05 採購不再預設庫儲資料，否則收貨、入庫時會沒辦法修改 
                  SELECT pmap009,pmap012,pmap014,pmap005
                    INTO l_pmdn.pmdnunit,l_pmdn.pmdn025,l_pmdn.pmdn031,l_pmdn.pmdn003
                    FROM pmdp_t
                   WHERE pmdpent = g_enterprise
                     AND pmdpsite = g_site
                     AND pmap001 = l_pmdl004
                     AND pmap002 = l_pmal002
                     AND pmap003 = l_pmdn.pmdn001
                     AND pmap004 = l_pmdn.pmdn002
               END IF
            END IF
            IF cl_null(l_pmal002) OR l_n = 0 THEN
               #沒有設置'供應商控制組料件預設條件'(apmi121)才改抓料件進銷存檔預設的條件 
               #2015/01/05 採購不再預設庫儲資料，否則收貨、入庫時會沒辦法修改 
               SELECT imaf157
                 INTO l_pmdn.pmdn003
                 FROM imaf_t
                WHERE imafent  = g_enterprise
                  AND imafsite = g_site
                  AND imaf001  = l_pmdn.pmdn001
            END IF

            #若採購料件有設置'交易對象對應料號'(apmi070)有供應商料號時，需將對應的料號抓出顯示在
            #[C:供應商料號]欄位上，若有設置多筆對應料號時以有勾選主要對應料那一筆為預設值
            LET l_pmdn.pmdn027 = ''
            SELECT pmao004 INTO l_pmdn.pmdn027
              FROM pmao_t
             WHERE pmaoent = g_enterprise 
               AND pmao001 = l_pmdl004
               AND pmao002 = l_pmdn.pmdn001
               AND pmao003 = l_pmdn.pmdn002
               AND pmao000 = '1'    #161221-00064#23 add
               AND pmao007 = 'Y'

            IF cl_null(l_pmdn.pmdn027) THEN
               SELECT pmao004 INTO l_pmdn.pmdn027
                 FROM pmao_t
                WHERE pmaoent = g_enterprise
                  AND pmao001 = l_pmdl004
                  AND pmao002 = l_pmdn.pmdn001
                  AND pmao003 = l_pmdn.pmdn002
                  AND pmao000 = '1'    #161221-00064#23 add
                  AND rownum  = 1
            END IF

            #調用元件取單價
            LET l_pmdn.pmdn015 = 0 
            
            #取得單頭的資料  
            SELECT pmdl009,pmdl010,pmdl011,pmdl015,pmdl017,pmdl023,pmdl054
              INTO l_pmdl009,l_pmdl010,l_pmdl011,l_pmdl015,l_pmdl017,l_pmdl023,l_pmdl054
              FROM p610_03_pmdl_t
             WHERE pmdl004 = l_pmdl004        #供應商編號  
            IF NOT (cl_null(l_pmdl017) OR cl_null(l_pmdl004) OR cl_null(l_pmdn001) OR
                    cl_null(l_pmdl015) OR cl_null(l_pmdl011) OR cl_null(l_pmdl009) OR
                    cl_null(l_pmdl010) OR cl_null(l_pmdl023) OR cl_null(l_pmdn010) OR
                    cl_null(l_pmdl054) OR cl_null(l_pmdn011) ) THEN
               CALL s_purchase_price_get(l_pmdl017,l_pmdl004,l_pmdn001,l_pmdn002,
                                         l_pmdl015,l_pmdl011,l_pmdl009,l_pmdl010,
                                         l_pmdl023,g_apsp610_01_input.pmdldocno,
                                         g_today,l_pmdn010,l_pmdn011,
                                         g_site,l_pmdl054,'1','apmp490','' )
                    RETURNING l_pmdn.pmdn040,l_pmdn.pmdn015,l_pmdn.pmdn041,l_pmdn.pmdn042

               LET l_pmdn.pmdn043 = l_pmdn.pmdn015

            END IF

            LET l_pmdn.pmdn016 = l_pmdl011        #稅別  
            CALL s_apmt500_get_amount(g_apsp610_01_input.pmdldocno,l_pmdn.pmdnseq,l_pmdl015,
                                      l_pmdn.pmdn011,l_pmdn.pmdn015,l_pmdn.pmdn016)
                 RETURNING l_pmdn.pmdn046,l_pmdn.pmdn048,l_pmdn.pmdn047

            #因為s_apmt500_get_amount會呼叫稅別元件(s_tax)，其中會產生xrcd的資料，所以要做刪除的動作 
            DELETE FROM xrcd_t WHERE xrcdent = g_enterprise
                                 #AND xrcdld  = l_ooef017   #因為這裡只有單別，應該是不會有其他相同的資料  
                                 AND xrcddocno = g_apsp610_01_input.pmdldocno
                                 AND xrcdseq   = l_pmdn.pmdnseq
                                 AND xrcdseq2  = '0' 
                                 
            LET l_pmdn.pmdn050 = l_pmdn050 
            #160601-00032#3 20160613 add by ming -----(S) 
            LET l_pmdn.pmdn053 = l_pmdn053
            #160601-00032#3 20160613 add by ming -----(E) 
            LET l_pmdn.pmdn058 = l_pmdn058
            LET l_pmdn.pmdn036 = l_pmdn036
            LET l_pmdn.pmdn037 = l_pmdn037
            LET l_pmdn.pmdn038 = l_pmdn038

            #寫入採購明細資料中 之後就更新此table 並以此table產生資料即可 

            INSERT INTO p610_tmp02(pmdnseq,pmdn001,pmdn002,pmdn006,pmdn007,           #160727-00019#15 Mod   p610_03_pmdn_rel_t -->p610_tmp02
                                   pmdn010,pmdn011,pmdn012,pmdn013,pmdn014,
                                   pmdn015,pmdl004,
                                   pmdl025,pmdl026,
                                   pmdn003,pmdn008,pmdn009,
                                   pmdn019,pmdn020,pmdn021,pmdn022,pmdn024,
                                   pmdn027,pmdn028,pmdn029,pmdn032,pmdn033,
                                   pmdn035,pmdn036,pmdn037,pmdn038,pmdn040,
                                   pmdn043,pmdn045,pmdn046,pmdn047,
                                   pmdn048,pmdn050,pmdbdocno,pmdbseq, 
                                   pmdn053,     #160601-00032#3 20160613 add 
                                   pmdn058,pmdnunit,pmdnorga)
                            VALUES(l_pmdn.pmdnseq,l_pmdn.pmdn001,l_pmdn.pmdn002,
                                   l_pmdn.pmdn006,l_pmdn.pmdn007,l_pmdn010,
                                   l_pmdn.pmdn011,l_pmdn.pmdn012,
                                   l_pmdn.pmdn013,l_pmdn.pmdn014,l_pmdn.pmdn015,
                                   l_pmdl004,
                                   l_pmdl025,l_pmdl026,
                                   l_pmdn.pmdn003,l_pmdn.pmdn008,l_pmdn.pmdn009,
                                   l_pmdn.pmdn019,l_pmdn.pmdn020,l_pmdn.pmdn021,
                                   l_pmdn.pmdn022,l_pmdn.pmdn024,l_pmdn.pmdn027,
                                   l_pmdn.pmdn028,l_pmdn.pmdn029,l_pmdn.pmdn032, 
                                   l_pmdn.pmdn033,l_pmdn.pmdn035,l_pmdn.pmdn036,
                                   l_pmdn.pmdn037,l_pmdn.pmdn038,l_pmdn.pmdn040,
                                   l_pmdn.pmdn043,
                                   l_pmdn.pmdn045,l_pmdn.pmdn046,l_pmdn.pmdn047,
                                   l_pmdn.pmdn048,l_pmdn.pmdn050,l_pmdbdocno,l_pmdbseq,
                                   l_pmdn.pmdn053,     #160601-00032#3 20160613 add 
                                   l_pmdn.pmdn058,
                                   l_pmdn.pmdnunit,l_pmdn.pmdnorga)

            LET l_sql = "SELECT pspc004,'',pspc050,pspc051,pspc014,",
                        "       pspc034,qty,'','','' ",
                        "  FROM p610_02_pspc_t ",
                        " WHERE link_no = '",l_link_no,"' ",
                        "   AND pspc045 = '",l_pspc045,"' ",
                        " ORDER BY pspc045 "
            PREPARE apsp610_03_pmdb_prep2 FROM l_sql
            DECLARE apsp610_03_pmdb_curs2 CURSOR FOR apsp610_03_pmdb_prep2
            FOREACH apsp610_03_pmdb_curs2 INTO l_pspc004,l_pmdbseq,l_pspc050,
                                               l_pspc051,l_pspc014,l_pspc034,
                                               l_qty2,l_pmdb033,l_pmdb014,
                                               l_pmdb015
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = 'foreach:'
                  LET g_errparam.code   = STATUS
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()

                  EXIT FOREACH
               END IF 
               IF l_qty1 > l_qty2 THEN
                  LET l_qty_w = l_qty2
                  LET l_qty1 = l_qty1 - l_qty2
               ELSE
                  LET l_qty_w = l_qty1
                  LET l_qty1 = 0
               END IF 
               
               CALL apsp610_03_convert_qty(l_pspc050,l_pmdn006,l_pspc014,l_qty_w)
                    RETURNING l_new_qty_w

               INITIALIZE l_pmdp.* TO NULL

               LET l_pmdp.pmdpseq = l_pmdn.pmdnseq          #請購關聯單的項次會等於採購單的項次 

               #設定項序 
               LET l_pmdp.pmdpseq1 = ''
               SELECT MAX(pmdpseq1) + 1 INTO l_pmdp.pmdpseq1
                 FROM p610_tmp03       #160727-00019#15 Mod   p610_03_pmdp_rel_t -->p610_tmp03
                WHERE pmdl004 = l_pmdl004
                  AND pmdpseq = l_pmdn.pmdnseq
               IF cl_null(l_pmdp.pmdpseq1) OR l_pmdp.pmdpseq1 = 0 THEN
                  LET l_pmdp.pmdpseq1 = 1
               END IF

               LET l_pmdp.pmdp003 = l_pspc004
               LET l_pmdp.pmdp004 = l_pmdbseq
               LET l_pmdp.pmdp007 = l_pspc050
               LET l_pmdp.pmdp008 = l_pspc051
               
               #設定沖銷順序 
               SELECT MAX(pmdp021) + 1 INTO l_pmdp.pmdp021
                 FROM p610_tmp03       #160727-00019#15 Mod   p610_03_pmdp_rel_t -->p610_tmp03
                WHERE pmdl004 = l_pmdl004
                  AND pmdpseq = l_pmdn.pmdnseq
               IF cl_null(l_pmdp.pmdp021) OR l_pmdp.pmdp021 = 0 THEN
                  LET l_pmdp.pmdp021 = 1
               END IF
               
               LET l_pmdp.pmdp022 = l_pspc014             #單位  
               LET l_pmdp.pmdp023 = l_new_qty_w           #需求數量 
               LET l_pmdp.pmdp024 = l_qty_w               #折合採購量 
               
               INSERT INTO p610_tmp03(pmdpseq,pmdpseq1,pmdp001,pspc004,         #160727-00019#15 Mod   p610_03_pmdp_rel_t -->p610_tmp03
                                              pmdp004,pmdp007,pmdp008,pmdp021,
                                              pmdp022,pmdp023,pmdp024,pspc045,pmdb033,max_pmdp023,
                                              pmdl004,pmdl025,pmdl026,pmdb050)
                                       VALUES(l_pmdp.pmdpseq,l_pmdp.pmdpseq1,l_pmdn.pmdn001,l_pspc004,
                                              l_pmdp.pmdp004,l_pmdp.pmdp007,l_pmdp.pmdp008,l_pmdp.pmdp021,
                                              l_pmdp.pmdp022,l_pmdp.pmdp023,l_pmdp.pmdp024,l_pspc045,
                                              l_pmdb033,l_pmdn.pmdn007,l_pmdl004,l_pmdl025,l_pmdl026,l_pmdb050)

               IF l_qty1 = 0 THEN
                  EXIT FOREACH
               END IF
            END FOREACH
         END FOREACH

      END FOREACH
   END IF

   #處理多交期  
   CALL apsp610_03_gen_pmdq()

   #新增交期明細資料 
   CALL apsp610_03_gen_pmdo()
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsp610_03_date_count(p_pmdn001,p_pmdn014)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_03_date_count(p_pmdn001,p_pmdn014)
   DEFINE p_pmdn001   LIKE pmdn_t.pmdn001
   DEFINE p_pmdn014   LIKE pmdn_t.pmdn014
   DEFINE r_pmdn013   LIKE pmdn_t.pmdn013
   DEFINE r_pmdn012   LIKE pmdn_t.pmdn012
   DEFINE l_imaf173   LIKE imaf_t.imaf173
   DEFINE l_imaf174   LIKE imaf_t.imaf174 
   
   WHENEVER ERROR CONTINUE 

   LET r_pmdn013 = ''
   LET r_pmdn012 = ''

   LET l_imaf173 = ''
   LET l_imaf174 = ''
   SELECT imaf173,imaf174 INTO l_imaf173,l_imaf174
     FROM imaf_t
    WHERE imafent = g_enterprise
      AND imafsite = g_site
      AND imaf001 = p_pmdn001 
      
   SELECT ooef008,ooef009 INTO g_ooef008,g_ooef009
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site

   #若到廠日期為NULL時，輸入到庫日期後需自動計算到廠日期，公式為到庫日期-[T:料件據點進銷存檔].[C:到庫前置時間]
   IF (NOT cl_null(l_imaf174)) AND l_imaf174 <> 0 THEN
      CALL s_date_get_work_date(g_site,g_ooef008,g_ooef009,p_pmdn014,0,(l_imaf174*(-1)))
           RETURNING r_pmdn013
   ELSE
      LET r_pmdn013 = p_pmdn014
   END IF

   #若交貨日期為NULL時，輸入到庫日期後需自動計算交貨日期，公式為到廠日期-[T:料件據點進銷存檔].[C:到廠前置時間]
   IF (NOT cl_null(l_imaf173)) AND l_imaf173 <> 0 THEN
      CALL s_date_get_work_date(g_site,g_ooef008,g_ooef009,r_pmdn013,0,(l_imaf173*(-1)))
           RETURNING r_pmdn012
   ELSE 
      LET r_pmdn012 = r_pmdn013
   END IF

   RETURN r_pmdn013,r_pmdn012 
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsp610_03_get_pmaal004(p_pmaal001)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_03_get_pmaal004(p_pmaal001)
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
# Usage..........: CALL apsp610_03_ins_pmdp(p_keyno,p_pmdl004,p_pmdldocno)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_03_ins_pmdp(p_keyno,p_pmdl004,p_pmdl025,p_pmdl026,p_pmdldocno)
   DEFINE p_keyno     LIKE type_t.num10
   DEFINE p_pmdl004   LIKE pmdl_t.pmdl004 
   DEFINE p_pmdl025   LIKE pmdl_t.pmdl025
   DEFINE p_pmdl026   LIKE pmdl_t.pmdl026
   DEFINE p_pmdldocno LIKE pmdl_t.pmdldocno
   DEFINE l_sql       STRING
   DEFINE l_pmdp_tmp  type_g_pmdp_d
    #mod--161109-00085#14 By 08993--(s)
#   DEFINE l_pmdp        RECORD LIKE pmdp_t.*   #mark--161109-00085#14 By 08993--(s)
   DEFINE l_pmdp RECORD  #採購關聯單據明細檔
          pmdpent LIKE pmdp_t.pmdpent, #企業編號
          pmdpsite LIKE pmdp_t.pmdpsite, #營運據點
          pmdpdocno LIKE pmdp_t.pmdpdocno, #採購單號
          pmdpseq LIKE pmdp_t.pmdpseq, #採購項次
          pmdpseq1 LIKE pmdp_t.pmdpseq1, #項序
          pmdp001 LIKE pmdp_t.pmdp001, #料件編號
          pmdp002 LIKE pmdp_t.pmdp002, #產品特徵
          pmdp003 LIKE pmdp_t.pmdp003, #來源單號
          pmdp004 LIKE pmdp_t.pmdp004, #來源項次
          pmdp005 LIKE pmdp_t.pmdp005, #來源項序
          pmdp006 LIKE pmdp_t.pmdp006, #來源分批序
          pmdp007 LIKE pmdp_t.pmdp007, #來源料號
          pmdp008 LIKE pmdp_t.pmdp008, #來源產品特徵
          pmdp009 LIKE pmdp_t.pmdp009, #來源作業編號
          pmdp010 LIKE pmdp_t.pmdp010, #來源作業序
          pmdp011 LIKE pmdp_t.pmdp011, #來源BOM特性
          pmdp012 LIKE pmdp_t.pmdp012, #來源生產控制組
          pmdp021 LIKE pmdp_t.pmdp021, #沖銷順序
          pmdp022 LIKE pmdp_t.pmdp022, #需求單位
          pmdp023 LIKE pmdp_t.pmdp023, #需求數量
          pmdp024 LIKE pmdp_t.pmdp024, #折合採購量
          pmdp025 LIKE pmdp_t.pmdp025, #已收貨量
          pmdp026 LIKE pmdp_t.pmdp026, #已入庫量
          pmdp900 LIKE pmdp_t.pmdp900, #保留欄位str
         #pmdp999 LIKE pmdp_t.pmdp999  #保留欄位end #161109-00085#61 mark
          #161109-00085#61 --s add
          pmdp999 LIKE pmdp_t.pmdp999, #保留欄位end
          pmdpud001 LIKE pmdp_t.pmdpud001, #自定義欄位(文字)001
          pmdpud002 LIKE pmdp_t.pmdpud002, #自定義欄位(文字)002
          pmdpud003 LIKE pmdp_t.pmdpud003, #自定義欄位(文字)003
          pmdpud004 LIKE pmdp_t.pmdpud004, #自定義欄位(文字)004
          pmdpud005 LIKE pmdp_t.pmdpud005, #自定義欄位(文字)005
          pmdpud006 LIKE pmdp_t.pmdpud006, #自定義欄位(文字)006
          pmdpud007 LIKE pmdp_t.pmdpud007, #自定義欄位(文字)007
          pmdpud008 LIKE pmdp_t.pmdpud008, #自定義欄位(文字)008
          pmdpud009 LIKE pmdp_t.pmdpud009, #自定義欄位(文字)009
          pmdpud010 LIKE pmdp_t.pmdpud010, #自定義欄位(文字)010
          pmdpud011 LIKE pmdp_t.pmdpud011, #自定義欄位(數字)011
          pmdpud012 LIKE pmdp_t.pmdpud012, #自定義欄位(數字)012
          pmdpud013 LIKE pmdp_t.pmdpud013, #自定義欄位(數字)013
          pmdpud014 LIKE pmdp_t.pmdpud014, #自定義欄位(數字)014
          pmdpud015 LIKE pmdp_t.pmdpud015, #自定義欄位(數字)015
          pmdpud016 LIKE pmdp_t.pmdpud016, #自定義欄位(數字)016
          pmdpud017 LIKE pmdp_t.pmdpud017, #自定義欄位(數字)017
          pmdpud018 LIKE pmdp_t.pmdpud018, #自定義欄位(數字)018
          pmdpud019 LIKE pmdp_t.pmdpud019, #自定義欄位(數字)019
          pmdpud020 LIKE pmdp_t.pmdpud020, #自定義欄位(數字)020
          pmdpud021 LIKE pmdp_t.pmdpud021, #自定義欄位(日期時間)021
          pmdpud022 LIKE pmdp_t.pmdpud022, #自定義欄位(日期時間)022
          pmdpud023 LIKE pmdp_t.pmdpud023, #自定義欄位(日期時間)023
          pmdpud024 LIKE pmdp_t.pmdpud024, #自定義欄位(日期時間)024
          pmdpud025 LIKE pmdp_t.pmdpud025, #自定義欄位(日期時間)025
          pmdpud026 LIKE pmdp_t.pmdpud026, #自定義欄位(日期時間)026
          pmdpud027 LIKE pmdp_t.pmdpud027, #自定義欄位(日期時間)027
          pmdpud028 LIKE pmdp_t.pmdpud028, #自定義欄位(日期時間)028
          pmdpud029 LIKE pmdp_t.pmdpud029, #自定義欄位(日期時間)029
          pmdpud030 LIKE pmdp_t.pmdpud030  #自定義欄位(日期時間)030
          #161109-00085#61 --e add
   END RECORD
   #mod--161109-00085#14 By 08993--(e)
 
   DEFINE l_errno     LIKE type_t.chr10          #錯誤訊息代碼  
   WHENEVER ERROR CONTINUE 
   
   LET l_sql = "SELECT pmdpseq,pmdpseq1,pmdp001,'','',pspc004,pmdp004, ",
               "       pmdp007,'','',pmdp008,'',pmdp021,pmdp022,pmdp023, ",
               "       pmdp024,pspc045,pmdb033 ",
               "  FROM p610_tmp03 ",        #160727-00019#15 Mod   p610_03_pmdp_rel_t -->p610_tmp03
               " WHERE pmdl004 = '",p_pmdl004,"' ",
               "   AND NVL(pmdl025,' ') = NVL('",p_pmdl025,"',' ') ",
               "   AND NVL(pmdl026,' ') = NVL('",p_pmdl026,"',' ') "
   PREPARE apsp610_03_ins_pmdp_prep FROM l_sql
   DECLARE apsp610_03_ins_pmdp_curs CURSOR WITH HOLD FOR apsp610_03_ins_pmdp_prep

   INITIALIZE l_pmdp_tmp.* TO NULL
   INITIALIZE l_pmdp.*     TO NULL

   #FOREACH apsp610_03_ins_pmdp_curs INTO l_pmdp_tmp.* #161109-00085#61 mark
   #161109-00085#61 --s add
   FOREACH apsp610_03_ins_pmdp_curs INTO l_pmdp_tmp.pmdpseq_03_03,l_pmdp_tmp.pmdpseq1_03_03,l_pmdp_tmp.pmdp001_03_03,l_pmdp_tmp.imaal003_03_03_1,l_pmdp_tmp.imaal004_03_03_1,  
                                         l_pmdp_tmp.pspc004_03_03,l_pmdp_tmp.pmdp004_03_03,l_pmdp_tmp.pmdp007_03_03,l_pmdp_tmp.imaal003_03_03_2,l_pmdp_tmp.imaal004_03_03_2,  
                                         l_pmdp_tmp.pmdp008_03_03,l_pmdp_tmp.pmdp008_03_03_desc,l_pmdp_tmp.pmdp021_03_03,l_pmdp_tmp.pmdp022_03_03,l_pmdp_tmp.pmdp023_03_03,     
                                         l_pmdp_tmp.pmdp024_03_03,l_pmdp_tmp.pspc045_03_03,l_pmdp_tmp.pmdb033_03_03,l_pmdp_tmp.pmdl004_03_03
   #161109-00085#61 --e add
      IF STATUS THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = STATUS
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      #before insert 
      LET l_pmdp.pmdpsite = g_site
      LET l_pmdp.pmdp025 = 0
      LET l_pmdp.pmdp026 = 0 
      #-------------------------------------------------
      LET l_pmdp.pmdpdocno = p_pmdldocno
      LET l_pmdp.pmdpseq = l_pmdp_tmp.pmdpseq_03_03
      LET l_pmdp.pmdpseq1 = l_pmdp_tmp.pmdpseq1_03_03
      LET l_pmdp.pmdp001 = l_pmdp_tmp.pmdp001_03_03 
      
      SELECT pmdn002 INTO l_pmdp.pmdp002
        FROM pmdn_t
       WHERE pmdnent   = g_enterprise
         AND pmdndocno = p_pmdldocno
         AND pmdnseq   = l_pmdp.pmdpseq

      LET l_pmdp.pmdp003 = l_pmdp_tmp.pspc004_03_03
      #after field pmdp003 
      LET l_pmdp.pmdp004 = l_pmdp_tmp.pmdp004_03_03
      #after field pmdp004 
      IF NOT cl_null(l_pmdp.pmdp004) THEN
         CALL apsp610_03_pmdp004_chk(p_pmdl004,l_pmdp.pmdp003,l_pmdp.pmdp004)
         IF NOT cl_null(g_errno) THEN
            LET l_errno = g_errno
            LET g_result_str = g_result_str,",",cl_getmsg(l_errno,g_lang)
            LET g_success = 'N'
         END IF
      END IF

      LET l_pmdp.pmdp007 = l_pmdp_tmp.pmdp007_03_03
      LET l_pmdp.pmdp008 = l_pmdp_tmp.pmdp008_03_03 
      LET l_pmdp.pmdp021 = l_pmdp_tmp.pmdp021_03_03
      #after field pmdp021 

      LET l_pmdp.pmdp022 = l_pmdp_tmp.pmdp022_03_03
      LET l_pmdp.pmdp023 = l_pmdp_tmp.pmdp023_03_03
      LET l_pmdp.pmdp024 = l_pmdp_tmp.pmdp024_03_03

      LET l_pmdp.pmdpent = g_enterprise

      INSERT INTO pmdp_t(pmdpent,pmdpsite,pmdpdocno,pmdpseq,pmdpseq1,
                         pmdp001,pmdp002,pmdp003,pmdp004,pmdp005,pmdp006,
                         pmdp007,pmdp008,pmdp009,pmdp010,pmdp011,pmdp012,
                         pmdp021,pmdp022,pmdp023,pmdp024,pmdp025,pmdp026
                        )
                  VALUES(l_pmdp.pmdpent,l_pmdp.pmdpsite,l_pmdp.pmdpdocno,
                         l_pmdp.pmdpseq,l_pmdp.pmdpseq1,l_pmdp.pmdp001,
                         l_pmdp.pmdp002,l_pmdp.pmdp003,l_pmdp.pmdp004,
                         l_pmdp.pmdp005,l_pmdp.pmdp006,l_pmdp.pmdp007,
                         l_pmdp.pmdp008,l_pmdp.pmdp009,l_pmdp.pmdp010,
                         l_pmdp.pmdp011,l_pmdp.pmdp012,l_pmdp.pmdp021,
                         l_pmdp.pmdp022,l_pmdp.pmdp023,l_pmdp.pmdp024,
                         l_pmdp.pmdp025,l_pmdp.pmdp026)

      UPDATE pmdb_t SET pmdb049 = pmdb049 + l_pmdp.pmdp023
       WHERE pmdbent    = g_enterprise
         AND pmdbsite  = g_site
         AND pmdbdocno = l_pmdp.pmdp003
         AND pmdbseq   = l_pmdp.pmdp004

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = l_pmdp.pmdp003,"#",l_pmdp.pmdp004
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         LET g_success = 'N'
      END IF
      #160823-00010#1-s-add 回寫已轉數量
      IF g_success = 'Y' THEN
         UPDATE pspc_t SET pspc061  = COALESCE(pspc061,0) + l_pmdp.pmdp023
          WHERE pspcent  = g_enterprise
            AND pspcsite = g_site
            AND pspc001 = g_apsp610_01_input.psca001
            AND pspc002 = g_p610_pspc002
            AND pspc004 = l_pmdp.pmdp003
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_pmdp.pmdp003,"#",l_pmdp.pmdp004
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
          
            LET g_success = 'N'
         END IF
      END IF
      #160823-00010#1-e-add
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsp610_03_pmdp003_chk(p_pmdp003)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_03_pmdp003_chk(p_pmdp003)
   DEFINE p_pmdp003     LIKE pmdp_t.pmdp003
   DEFINE l_pmdastus    LIKE pmda_t.pmdastus 
   
   WHENEVER ERROR CONTINUE 

   LET l_pmdastus = ''
   LET g_errno = ''

   SELECT pmdastus INTO l_pmdastus
     FROM pmda_t
    WHERE pmdaent   = g_enterprise
      AND pmdasite  = g_site
      AND pmdadocno = p_pmdp003

   CASE
      WHEN SQLCA.sqlcode = 100   LET g_errno = 'apm-00235'     #輸入的請購單號不存在[請購單資料檔]中！
      WHEN l_pmdastus <> 'Y'     LET g_errno = 'apm-00236'     #輸入的請購單號不是已確認狀態！
      OTHERWISE                  LET g_errno = SQLCA.sqlcode USING '------'

   END CASE
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsp610_03_pmdp004_chk(p_pmdl004,p_pmdp003,p_pmdp004)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_03_pmdp004_chk(p_pmdl004,p_pmdp003,p_pmdp004)
   DEFINE p_pmdl004     LIKE pmdl_t.pmdl004
   DEFINE p_pmdp003     LIKE pmdp_t.pmdp003
   DEFINE p_pmdp004     LIKE pmdp_t.pmdp004
   DEFINE l_pmdb049     LIKE pmdb_t.pmdb049
   DEFINE l_pmdb006     LIKE pmdb_t.pmdb006
   DEFINE l_pmdb040     LIKE pmdb_t.pmdb040
   DEFINE l_pmdb014     LIKE pmdb_t.pmdb014
   DEFINE l_pmdb015     LIKE pmdb_t.pmdb015 
   
   WHENEVER ERROR CONTINUE 

   LET g_errno = ''
   LET l_pmdb049 = ''
   LET l_pmdb006 = ''
   LET l_pmdb040 = ''
   LET l_pmdb014 = ''
   LET l_pmdb015 = ''

   SELECT NVL(pmdb049,0),NVL(pmdb006,0),NVL(pmdb040,0),pmdb014,pmdb015
     INTO l_pmdb049,l_pmdb006,l_pmdb040,l_pmdb014,l_pmdb015
     FROM pmdb_t
    WHERE pmdbent   = g_enterprise
      AND pmdbdocno = p_pmdp003
      AND pmdbseq   = p_pmdp004

   CASE
      WHEN SQLCA.sqlcode = 100
         LET g_errno = 'apm-00295'
      WHEN l_pmdb049 >= l_pmdb006 * (1+l_pmdb040/100)      #已轉採購量大於等於需求量   
         LET g_errno = 'apm-00296' 
      WHEN l_pmdb014 = '3' AND l_pmdb015 <> p_pmdl004      #供應商選擇3.指定供應商 而採購單頭的供應商不同 就算錯 
         LET g_errno = 'apm-00297'
      OTHERWISE
         LET g_errno = SQLCA.sqlcode USING '------'
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsp610_03_ins_pmdo(p_keyno,p_pmdl004,p_pmdldocno)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........: 
################################################################################
PUBLIC FUNCTION apsp610_03_ins_pmdo(p_keyno,p_pmdl004,p_pmdl025,p_pmdl026,p_pmdldocno)
   DEFINE p_keyno     LIKE type_t.num10
   DEFINE p_pmdl004   LIKE pmdl_t.pmdl004 
   DEFINE p_pmdl025   LIKE pmdl_t.pmdl025
   DEFINE p_pmdl026   LIKE pmdl_t.pmdl026
   DEFINE p_pmdldocno LIKE pmdl_t.pmdldocno
   DEFINE l_pmdo_tmp  type_g_pmdo_d
   #mod--161109-00085#14 By 08993--(s)
#   DEFINE l_pmdo      RECORD LIKE pmdo_t.*   #mark--161109-00085#14 By 08993--(s)
   DEFINE l_pmdo RECORD  #採購交期明細檔
          pmdoent LIKE pmdo_t.pmdoent, #企業編號
          pmdosite LIKE pmdo_t.pmdosite, #營運據點
          pmdodocno LIKE pmdo_t.pmdodocno, #採購單號
          pmdoseq LIKE pmdo_t.pmdoseq, #採購項次
          pmdoseq1 LIKE pmdo_t.pmdoseq1, #項序
          pmdoseq2 LIKE pmdo_t.pmdoseq2, #分批序
          pmdo001 LIKE pmdo_t.pmdo001, #料件編號
          pmdo002 LIKE pmdo_t.pmdo002, #產品特徵
          pmdo003 LIKE pmdo_t.pmdo003, #子件特性
          pmdo004 LIKE pmdo_t.pmdo004, #採購單位
          pmdo005 LIKE pmdo_t.pmdo005, #採購總數量
          pmdo006 LIKE pmdo_t.pmdo006, #分批採購數量
          pmdo007 LIKE pmdo_t.pmdo007, #摺合主件數量
          pmdo008 LIKE pmdo_t.pmdo008, #QPA
          pmdo009 LIKE pmdo_t.pmdo009, #交期類型
          pmdo010 LIKE pmdo_t.pmdo010, #收貨時段
          pmdo011 LIKE pmdo_t.pmdo011, #出貨日期
          pmdo012 LIKE pmdo_t.pmdo012, #到廠日期
          pmdo013 LIKE pmdo_t.pmdo013, #到庫日期
          pmdo014 LIKE pmdo_t.pmdo014, #MRP交期凍結
          pmdo015 LIKE pmdo_t.pmdo015, #已收貨量
          pmdo016 LIKE pmdo_t.pmdo016, #驗退量
          pmdo017 LIKE pmdo_t.pmdo017, #倉退換貨量
          pmdo019 LIKE pmdo_t.pmdo019, #已入庫量
          pmdo020 LIKE pmdo_t.pmdo020, #VMI請款量
          pmdo021 LIKE pmdo_t.pmdo021, #交貨狀態
          pmdo022 LIKE pmdo_t.pmdo022, #參考價格
          pmdo023 LIKE pmdo_t.pmdo023, #稅別
          pmdo024 LIKE pmdo_t.pmdo024, #稅率
          pmdo025 LIKE pmdo_t.pmdo025, #電子採購單號
          pmdo026 LIKE pmdo_t.pmdo026, #最近修改人員
          pmdo027 LIKE pmdo_t.pmdo027, #最近修改時間
          pmdo028 LIKE pmdo_t.pmdo028, #分批參考單位
          pmdo029 LIKE pmdo_t.pmdo029, #分批參考數量
          pmdo030 LIKE pmdo_t.pmdo030, #分批計價單位
          pmdo031 LIKE pmdo_t.pmdo031, #分批計價數量
          pmdo032 LIKE pmdo_t.pmdo032, #分批未稅金額
          pmdo033 LIKE pmdo_t.pmdo033, #分批含稅金額
          pmdo034 LIKE pmdo_t.pmdo034, #分批稅額
          pmdo035 LIKE pmdo_t.pmdo035, #初始營運據點
          pmdo036 LIKE pmdo_t.pmdo036, #初始來源單號
          pmdo037 LIKE pmdo_t.pmdo037, #初始來源項次
          pmdo038 LIKE pmdo_t.pmdo038, #初始項序
          pmdo039 LIKE pmdo_t.pmdo039, #初始分批序
          pmdo040 LIKE pmdo_t.pmdo040, #倉退量
          pmdo200 LIKE pmdo_t.pmdo200, #分批包裝單位
          pmdo201 LIKE pmdo_t.pmdo201, #分批包裝數量
          pmdo900 LIKE pmdo_t.pmdo900, #保留欄位str
          pmdo999 LIKE pmdo_t.pmdo999, #保留欄位end
          #161109-00085#61 --s add
          pmdoud001 LIKE pmdo_t.pmdoud001, #自定義欄位(文字)001
          pmdoud002 LIKE pmdo_t.pmdoud002, #自定義欄位(文字)002
          pmdoud003 LIKE pmdo_t.pmdoud003, #自定義欄位(文字)003
          pmdoud004 LIKE pmdo_t.pmdoud004, #自定義欄位(文字)004
          pmdoud005 LIKE pmdo_t.pmdoud005, #自定義欄位(文字)005
          pmdoud006 LIKE pmdo_t.pmdoud006, #自定義欄位(文字)006
          pmdoud007 LIKE pmdo_t.pmdoud007, #自定義欄位(文字)007
          pmdoud008 LIKE pmdo_t.pmdoud008, #自定義欄位(文字)008
          pmdoud009 LIKE pmdo_t.pmdoud009, #自定義欄位(文字)009
          pmdoud010 LIKE pmdo_t.pmdoud010, #自定義欄位(文字)010
          pmdoud011 LIKE pmdo_t.pmdoud011, #自定義欄位(數字)011
          pmdoud012 LIKE pmdo_t.pmdoud012, #自定義欄位(數字)012
          pmdoud013 LIKE pmdo_t.pmdoud013, #自定義欄位(數字)013
          pmdoud014 LIKE pmdo_t.pmdoud014, #自定義欄位(數字)014
          pmdoud015 LIKE pmdo_t.pmdoud015, #自定義欄位(數字)015
          pmdoud016 LIKE pmdo_t.pmdoud016, #自定義欄位(數字)016
          pmdoud017 LIKE pmdo_t.pmdoud017, #自定義欄位(數字)017
          pmdoud018 LIKE pmdo_t.pmdoud018, #自定義欄位(數字)018
          pmdoud019 LIKE pmdo_t.pmdoud019, #自定義欄位(數字)019
          pmdoud020 LIKE pmdo_t.pmdoud020, #自定義欄位(數字)020
          pmdoud021 LIKE pmdo_t.pmdoud021, #自定義欄位(日期時間)021
          pmdoud022 LIKE pmdo_t.pmdoud022, #自定義欄位(日期時間)022
          pmdoud023 LIKE pmdo_t.pmdoud023, #自定義欄位(日期時間)023
          pmdoud024 LIKE pmdo_t.pmdoud024, #自定義欄位(日期時間)024
          pmdoud025 LIKE pmdo_t.pmdoud025, #自定義欄位(日期時間)025
          pmdoud026 LIKE pmdo_t.pmdoud026, #自定義欄位(日期時間)026
          pmdoud027 LIKE pmdo_t.pmdoud027, #自定義欄位(日期時間)027
          pmdoud028 LIKE pmdo_t.pmdoud028, #自定義欄位(日期時間)028
          pmdoud029 LIKE pmdo_t.pmdoud029, #自定義欄位(日期時間)029
          pmdoud030 LIKE pmdo_t.pmdoud030, #自定義欄位(日期時間)030
          #161109-00085#61 --e add
          pmdo041 LIKE pmdo_t.pmdo041, #還料數量
          pmdo042 LIKE pmdo_t.pmdo042, #還量參考數量
          pmdo043 LIKE pmdo_t.pmdo043, #還價數量
          pmdo044 LIKE pmdo_t.pmdo044  #還價參考數量
   END RECORD
   #mod--161109-00085#14 By 08993--(e)   
   DEFINE l_sql       STRING

   DEFINE l_pmdoent   LIKE pmdo_t.pmdoent
   DEFINE l_pmdosite  LIKE pmdo_t.pmdosite
   DEFINE l_pmdo003   LIKE pmdo_t.pmdo003
   DEFINE l_pmdo007   LIKE pmdo_t.pmdo007
   DEFINE l_pmdo008   LIKE pmdo_t.pmdo008
   DEFINE l_pmdo009   LIKE pmdo_t.pmdo009
   DEFINE l_pmdo010   LIKE pmdo_t.pmdo010
   DEFINE l_pmdo014   LIKE pmdo_t.pmdo014
   DEFINE l_pmdo015   LIKE pmdo_t.pmdo015
   DEFINE l_pmdo016   LIKE pmdo_t.pmdo016
   DEFINE l_pmdo017   LIKE pmdo_t.pmdo017
   DEFINE l_pmdo019   LIKE pmdo_t.pmdo019
   DEFINE l_pmdo020   LIKE pmdo_t.pmdo020
   DEFINE l_pmdo021   LIKE pmdo_t.pmdo021
   DEFINE l_pmdo022   LIKE pmdo_t.pmdo022
   DEFINE l_pmdo023   LIKE pmdo_t.pmdo023
   DEFINE l_pmdo024   LIKE pmdo_t.pmdo024
   DEFINE l_pmdo025   LIKE pmdo_t.pmdo025
   DEFINE l_pmdo026   LIKE pmdo_t.pmdo026 
   DEFINE l_pmdo027   LIKE pmdo_t.pmdo027
   DEFINE l_pmdo028   LIKE pmdo_t.pmdo028 
   DEFINE l_pmdo029   LIKE pmdo_t.pmdo029 
   DEFINE l_pmdo030   LIKE pmdo_t.pmdo030
   DEFINE l_pmdo031   LIKE pmdo_t.pmdo031
   DEFINE l_pmdo032   LIKE pmdo_t.pmdo032
   DEFINE l_pmdo033   LIKE pmdo_t.pmdo033
   DEFINE l_pmdo034   LIKE pmdo_t.pmdo034 
   #mod--161109-00085#14 By 08993--(s)
#   DEFINE l_pmdl       RECORD LIKE  pmdl_t.*   #mark--161109-00085#14 By 08993--(s)
   DEFINE l_pmdl RECORD  #採購單頭檔
          pmdlent LIKE pmdl_t.pmdlent, #企業編號
          pmdlsite LIKE pmdl_t.pmdlsite, #營運據點
          pmdlunit LIKE pmdl_t.pmdlunit, #應用組織
          pmdldocno LIKE pmdl_t.pmdldocno, #採購單號
          pmdldocdt LIKE pmdl_t.pmdldocdt, #採購日期
          pmdl001 LIKE pmdl_t.pmdl001, #版次
          pmdl002 LIKE pmdl_t.pmdl002, #採購人員
          pmdl003 LIKE pmdl_t.pmdl003, #採購部門
          pmdl004 LIKE pmdl_t.pmdl004, #供應商編號
          pmdl005 LIKE pmdl_t.pmdl005, #採購性質
          pmdl006 LIKE pmdl_t.pmdl006, #多角性質
          pmdl007 LIKE pmdl_t.pmdl007, #資料來源類型
          pmdl008 LIKE pmdl_t.pmdl008, #來源單號
          pmdl009 LIKE pmdl_t.pmdl009, #付款條件
          pmdl010 LIKE pmdl_t.pmdl010, #交易條件
          pmdl011 LIKE pmdl_t.pmdl011, #稅別
          pmdl012 LIKE pmdl_t.pmdl012, #稅率
          pmdl013 LIKE pmdl_t.pmdl013, #單價含稅否
          pmdl015 LIKE pmdl_t.pmdl015, #幣別
          pmdl016 LIKE pmdl_t.pmdl016, #匯率
          pmdl017 LIKE pmdl_t.pmdl017, #取價方式
          pmdl018 LIKE pmdl_t.pmdl018, #付款優惠條件
          pmdl019 LIKE pmdl_t.pmdl019, #納入APS計算
          pmdl020 LIKE pmdl_t.pmdl020, #運送方式
          pmdl021 LIKE pmdl_t.pmdl021, #付款供應商
          pmdl022 LIKE pmdl_t.pmdl022, #送貨供應商
          pmdl023 LIKE pmdl_t.pmdl023, #採購分類一
          pmdl024 LIKE pmdl_t.pmdl024, #採購分類二
          pmdl025 LIKE pmdl_t.pmdl025, #送貨地址
          pmdl026 LIKE pmdl_t.pmdl026, #帳款地址
          pmdl027 LIKE pmdl_t.pmdl027, #供應商連絡人
          pmdl028 LIKE pmdl_t.pmdl028, #一次性交易對象識別碼
          pmdl029 LIKE pmdl_t.pmdl029, #收貨部門
          pmdl030 LIKE pmdl_t.pmdl030, #多角貿易已拋轉
          pmdl031 LIKE pmdl_t.pmdl031, #多角序號
          pmdl032 LIKE pmdl_t.pmdl032, #最終客戶
          pmdl033 LIKE pmdl_t.pmdl033, #發票類型
          pmdl040 LIKE pmdl_t.pmdl040, #採購總未稅金額
          pmdl041 LIKE pmdl_t.pmdl041, #採購總含稅金額
          pmdl042 LIKE pmdl_t.pmdl042, #採購總稅額
          pmdl043 LIKE pmdl_t.pmdl043, #留置原因
          pmdl044 LIKE pmdl_t.pmdl044, #備註
          pmdl046 LIKE pmdl_t.pmdl046, #預付款發票開立方式
          pmdl047 LIKE pmdl_t.pmdl047, #物流結案
          pmdl048 LIKE pmdl_t.pmdl048, #帳流結案
          pmdl049 LIKE pmdl_t.pmdl049, #金流結案
          pmdl050 LIKE pmdl_t.pmdl050, #多角最終站否
          pmdl051 LIKE pmdl_t.pmdl051, #多角流程編號
          pmdl052 LIKE pmdl_t.pmdl052, #最終供應商
          pmdl053 LIKE pmdl_t.pmdl053, #兩角目的據點
          pmdl054 LIKE pmdl_t.pmdl054, #內外購
          pmdl055 LIKE pmdl_t.pmdl055, #匯率計算基準
          pmdl200 LIKE pmdl_t.pmdl200, #採購中心
          pmdl201 LIKE pmdl_t.pmdl201, #聯絡電話
          pmdl202 LIKE pmdl_t.pmdl202, #傳真號碼
          pmdl203 LIKE pmdl_t.pmdl203, #採購方式
          pmdl204 LIKE pmdl_t.pmdl204, #配送中心
          pmdl900 LIKE pmdl_t.pmdl900, #保留欄位str
          pmdl999 LIKE pmdl_t.pmdl999, #保留欄位end
          pmdlownid LIKE pmdl_t.pmdlownid, #資料所有者
          pmdlowndp LIKE pmdl_t.pmdlowndp, #資料所屬部門
          pmdlcrtid LIKE pmdl_t.pmdlcrtid, #資料建立者
          pmdlcrtdp LIKE pmdl_t.pmdlcrtdp, #資料建立部門
          pmdlcrtdt LIKE pmdl_t.pmdlcrtdt, #資料創建日
          pmdlmodid LIKE pmdl_t.pmdlmodid, #資料修改者
          pmdlmoddt LIKE pmdl_t.pmdlmoddt, #最近修改日
          pmdlcnfid LIKE pmdl_t.pmdlcnfid, #資料確認者
          pmdlcnfdt LIKE pmdl_t.pmdlcnfdt, #資料確認日
          pmdlpstid LIKE pmdl_t.pmdlpstid, #資料過帳者
          pmdlpstdt LIKE pmdl_t.pmdlpstdt, #資料過帳日
          pmdlstus LIKE pmdl_t.pmdlstus, #狀態碼
          #161109-00085#61 --s add
          pmdlud001 LIKE pmdl_t.pmdlud001, #自定義欄位(文字)001
          pmdlud002 LIKE pmdl_t.pmdlud002, #自定義欄位(文字)002
          pmdlud003 LIKE pmdl_t.pmdlud003, #自定義欄位(文字)003
          pmdlud004 LIKE pmdl_t.pmdlud004, #自定義欄位(文字)004
          pmdlud005 LIKE pmdl_t.pmdlud005, #自定義欄位(文字)005
          pmdlud006 LIKE pmdl_t.pmdlud006, #自定義欄位(文字)006
          pmdlud007 LIKE pmdl_t.pmdlud007, #自定義欄位(文字)007
          pmdlud008 LIKE pmdl_t.pmdlud008, #自定義欄位(文字)008
          pmdlud009 LIKE pmdl_t.pmdlud009, #自定義欄位(文字)009
          pmdlud010 LIKE pmdl_t.pmdlud010, #自定義欄位(文字)010
          pmdlud011 LIKE pmdl_t.pmdlud011, #自定義欄位(數字)011
          pmdlud012 LIKE pmdl_t.pmdlud012, #自定義欄位(數字)012
          pmdlud013 LIKE pmdl_t.pmdlud013, #自定義欄位(數字)013
          pmdlud014 LIKE pmdl_t.pmdlud014, #自定義欄位(數字)014
          pmdlud015 LIKE pmdl_t.pmdlud015, #自定義欄位(數字)015
          pmdlud016 LIKE pmdl_t.pmdlud016, #自定義欄位(數字)016
          pmdlud017 LIKE pmdl_t.pmdlud017, #自定義欄位(數字)017
          pmdlud018 LIKE pmdl_t.pmdlud018, #自定義欄位(數字)018
          pmdlud019 LIKE pmdl_t.pmdlud019, #自定義欄位(數字)019
          pmdlud020 LIKE pmdl_t.pmdlud020, #自定義欄位(數字)020
          pmdlud021 LIKE pmdl_t.pmdlud021, #自定義欄位(日期時間)021
          pmdlud022 LIKE pmdl_t.pmdlud022, #自定義欄位(日期時間)022
          pmdlud023 LIKE pmdl_t.pmdlud023, #自定義欄位(日期時間)023
          pmdlud024 LIKE pmdl_t.pmdlud024, #自定義欄位(日期時間)024
          pmdlud025 LIKE pmdl_t.pmdlud025, #自定義欄位(日期時間)025
          pmdlud026 LIKE pmdl_t.pmdlud026, #自定義欄位(日期時間)026
          pmdlud027 LIKE pmdl_t.pmdlud027, #自定義欄位(日期時間)027
          pmdlud028 LIKE pmdl_t.pmdlud028, #自定義欄位(日期時間)028
          pmdlud029 LIKE pmdl_t.pmdlud029, #自定義欄位(日期時間)029
          pmdlud030 LIKE pmdl_t.pmdlud030, #自定義欄位(日期時間)030
          #161109-00085#61 --e add
          pmdl205 LIKE pmdl_t.pmdl205, #採購最終有效日
          pmdl206 LIKE pmdl_t.pmdl206, #長效期訂單否
          pmdl207 LIKE pmdl_t.pmdl207, #所屬品類
          pmdl208 LIKE pmdl_t.pmdl208  #電子採購單號
   END RECORD
   #mod--161109-00085#14 By 08993--(e)
   WHENEVER ERROR CONTINUE 

   INITIALIZE l_pmdl.* TO NULL
   #160902-00048#1-s-mod
   #SELECT * INTO l_pmdl.* FROM pmdl_t WHERE pmdldocno = p_pmdldocno
   #mod--161109-00085#14 By 08993--(s)
#   SELECT * INTO l_pmdl.* FROM pmdl_t WHERE pmdlent = g_enterprise AND pmdldocno = p_pmdldocno   #mark--161109-00085#14 By 08993--(s)
   #161109-00085#61 --s mark
   #SELECT pmdlent,pmdlsite,pmdlunit,pmdldocno,pmdldocdt,pmdl001,pmdl002,pmdl003,pmdl004,pmdl005,pmdl006,pmdl007,pmdl008,
   #       pmdl009,pmdl010,pmdl011,pmdl012,pmdl013,pmdl015,pmdl016,pmdl017,pmdl018,pmdl019,pmdl020,pmdl021,pmdl022,pmdl023,
   #       pmdl024,pmdl025,pmdl026,pmdl027,pmdl028,pmdl029,pmdl030,pmdl031,pmdl032,pmdl033,pmdl040,pmdl041,pmdl042,pmdl043,
   #       pmdl044,pmdl046,pmdl047,pmdl048,pmdl049,pmdl050,pmdl051,pmdl052,pmdl053,pmdl054,pmdl055,pmdl200,pmdl201,pmdl202,
   #       pmdl203,pmdl204,pmdl900,pmdl999,pmdlownid,pmdlowndp,pmdlcrtid,pmdlcrtdp,pmdlcrtdt,pmdlmodid,pmdlmoddt,pmdlcnfid,
   #       pmdlcnfdt,pmdlpstid,pmdlpstdt,pmdlstus,pmdl205,pmdl206,pmdl207,pmdl208 
   #   INTO l_pmdl.pmdlent,l_pmdl.pmdlsite,l_pmdl.pmdlunit,l_pmdl.pmdldocno,l_pmdl.pmdldocdt,l_pmdl.pmdl001,l_pmdl.pmdl002,l_pmdl.pmdl003,l_pmdl.pmdl004,l_pmdl.pmdl005,l_pmdl.pmdl006,l_pmdl.pmdl007,l_pmdl.pmdl008,
   #       l_pmdl.pmdl009,l_pmdl.pmdl010,l_pmdl.pmdl011,l_pmdl.pmdl012,l_pmdl.pmdl013,l_pmdl.pmdl015,l_pmdl.pmdl016,l_pmdl.pmdl017,l_pmdl.pmdl018,l_pmdl.pmdl019,l_pmdl.pmdl020,l_pmdl.pmdl021,l_pmdl.pmdl022,l_pmdl.pmdl023,
   #       l_pmdl.pmdl024,l_pmdl.pmdl025,l_pmdl.pmdl026,l_pmdl.pmdl027,l_pmdl.pmdl028,l_pmdl.pmdl029,l_pmdl.pmdl030,l_pmdl.pmdl031,l_pmdl.pmdl032,l_pmdl.pmdl033,l_pmdl.pmdl040,l_pmdl.pmdl041,l_pmdl.pmdl042,l_pmdl.pmdl043,
   #       l_pmdl.pmdl044,l_pmdl.pmdl046,l_pmdl.pmdl047,l_pmdl.pmdl048,l_pmdl.pmdl049,l_pmdl.pmdl050,l_pmdl.pmdl051,l_pmdl.pmdl052,l_pmdl.pmdl053,l_pmdl.pmdl054,l_pmdl.pmdl055,l_pmdl.pmdl200,l_pmdl.pmdl201,l_pmdl.pmdl202,
   #       l_pmdl.pmdl203,l_pmdl.pmdl204,l_pmdl.pmdl900,l_pmdl.pmdl999,l_pmdl.pmdlownid,l_pmdl.pmdlowndp,l_pmdl.pmdlcrtid,l_pmdl.pmdlcrtdp,l_pmdl.pmdlcrtdt,l_pmdl.pmdlmodid,l_pmdl.pmdlmoddt,l_pmdl.pmdlcnfid,
   #       l_pmdl.pmdlcnfdt,l_pmdl.pmdlpstid,l_pmdl.pmdlpstdt,l_pmdl.pmdlstus,l_pmdl.pmdl205,l_pmdl.pmdl206,l_pmdl.pmdl207,l_pmdl.pmdl208
   #161109-00085#61 --e mark
   #161109-00085#61 --s add
    SELECT pmdlent,pmdlsite,pmdlunit,pmdldocno,pmdldocdt,
           pmdl001,pmdl002,pmdl003,pmdl004,pmdl005,
           pmdl006,pmdl007,pmdl008,pmdl009,pmdl010,
           pmdl011,pmdl012,pmdl013,pmdl015,pmdl016,
           pmdl017,pmdl018,pmdl019,pmdl020,pmdl021,
           pmdl022,pmdl023,pmdl024,pmdl025,pmdl026,
           pmdl027,pmdl028,pmdl029,pmdl030,pmdl031,
           pmdl032,pmdl033,pmdl040,pmdl041,pmdl042,
           pmdl043,pmdl044,pmdl046,pmdl047,pmdl048,
           pmdl049,pmdl050,pmdl051,pmdl052,pmdl053,
           pmdl054,pmdl055,pmdl200,pmdl201,pmdl202,
           pmdl203,pmdl204,pmdl900,pmdl999,pmdlownid,
           pmdlowndp,pmdlcrtid,pmdlcrtdp,pmdlcrtdt,pmdlmodid,
           pmdlmoddt,pmdlcnfid,pmdlcnfdt,pmdlpstid,pmdlpstdt,
           pmdlstus,pmdlud001,pmdlud002,pmdlud003,pmdlud004,
           pmdlud005,pmdlud006,pmdlud007,pmdlud008,pmdlud009,
           pmdlud010,pmdlud011,pmdlud012,pmdlud013,pmdlud014,
           pmdlud015,pmdlud016,pmdlud017,pmdlud018,pmdlud019,
           pmdlud020,pmdlud021,pmdlud022,pmdlud023,pmdlud024,
           pmdlud025,pmdlud026,pmdlud027,pmdlud028,pmdlud029,
           pmdlud030,pmdl205,pmdl206,pmdl207,pmdl208
      INTO l_pmdl.pmdlent,l_pmdl.pmdlsite,l_pmdl.pmdlunit,l_pmdl.pmdldocno,l_pmdl.pmdldocdt,
           l_pmdl.pmdl001,l_pmdl.pmdl002,l_pmdl.pmdl003,l_pmdl.pmdl004,l_pmdl.pmdl005,
           l_pmdl.pmdl006,l_pmdl.pmdl007,l_pmdl.pmdl008,l_pmdl.pmdl009,l_pmdl.pmdl010,
           l_pmdl.pmdl011,l_pmdl.pmdl012,l_pmdl.pmdl013,l_pmdl.pmdl015,l_pmdl.pmdl016,
           l_pmdl.pmdl017,l_pmdl.pmdl018,l_pmdl.pmdl019,l_pmdl.pmdl020,l_pmdl.pmdl021,
           l_pmdl.pmdl022,l_pmdl.pmdl023,l_pmdl.pmdl024,l_pmdl.pmdl025,l_pmdl.pmdl026,
           l_pmdl.pmdl027,l_pmdl.pmdl028,l_pmdl.pmdl029,l_pmdl.pmdl030,l_pmdl.pmdl031,
           l_pmdl.pmdl032,l_pmdl.pmdl033,l_pmdl.pmdl040,l_pmdl.pmdl041,l_pmdl.pmdl042,
           l_pmdl.pmdl043,l_pmdl.pmdl044,l_pmdl.pmdl046,l_pmdl.pmdl047,l_pmdl.pmdl048,
           l_pmdl.pmdl049,l_pmdl.pmdl050,l_pmdl.pmdl051,l_pmdl.pmdl052,l_pmdl.pmdl053,
           l_pmdl.pmdl054,l_pmdl.pmdl055,l_pmdl.pmdl200,l_pmdl.pmdl201,l_pmdl.pmdl202,
           l_pmdl.pmdl203,l_pmdl.pmdl204,l_pmdl.pmdl900,l_pmdl.pmdl999,l_pmdl.pmdlownid,
           l_pmdl.pmdlowndp,l_pmdl.pmdlcrtid,l_pmdl.pmdlcrtdp,l_pmdl.pmdlcrtdt,l_pmdl.pmdlmodid,
           l_pmdl.pmdlmoddt,l_pmdl.pmdlcnfid,l_pmdl.pmdlcnfdt,l_pmdl.pmdlpstid,l_pmdl.pmdlpstdt,
           l_pmdl.pmdlstus,l_pmdl.pmdlud001,l_pmdl.pmdlud002,l_pmdl.pmdlud003,l_pmdl.pmdlud004,
           l_pmdl.pmdlud005,l_pmdl.pmdlud006,l_pmdl.pmdlud007,l_pmdl.pmdlud008,l_pmdl.pmdlud009,
           l_pmdl.pmdlud010,l_pmdl.pmdlud011,l_pmdl.pmdlud012,l_pmdl.pmdlud013,l_pmdl.pmdlud014,
           l_pmdl.pmdlud015,l_pmdl.pmdlud016,l_pmdl.pmdlud017,l_pmdl.pmdlud018,l_pmdl.pmdlud019,
           l_pmdl.pmdlud020,l_pmdl.pmdlud021,l_pmdl.pmdlud022,l_pmdl.pmdlud023,l_pmdl.pmdlud024,
           l_pmdl.pmdlud025,l_pmdl.pmdlud026,l_pmdl.pmdlud027,l_pmdl.pmdlud028,l_pmdl.pmdlud029,
           l_pmdl.pmdlud030,l_pmdl.pmdl205,l_pmdl.pmdl206,l_pmdl.pmdl207,l_pmdl.pmdl208 
   #161109-00085#61 --e add
      FROM pmdl_t 
      WHERE pmdlent = g_enterprise AND pmdldocno = p_pmdldocno
   #mod--161109-00085#14 By 08993--(e)
   #160902-00048#1-e-mod

   LET l_sql = "SELECT pmdoseq,pmdoseq1,pmdo001,'','',pmdo002,'',pmdo004,pmdo005, ",
               "       pmdoseq2,pmdo006,pmdo009,pmdo011,pmdo012,pmdo013, ",
               "       pmdoent,pmdosite,pmdo003,pmdo007,pmdo008, ",
               "       pmdo010,pmdo014,pmdo015,pmdo016,pmdo017,pmdo019, ",
               "       pmdo020,pmdo021,pmdo022,pmdo023,pmdo024,pmdo025,pmdo026, ",
               "       pmdo027,pmdo028,pmdo029,pmdo030,pmdo031,pmdo032,pmdo033,pmdo034 ",
               "  FROM p610_03_pmdo_t ",
               " WHERE pmdl004 = '",p_pmdl004,"' ", 
               "   AND NVL(pmdl025,' ') = NVL('",p_pmdl025,"',' ') ",
               "   AND NVL(pmdl026,' ') = NVL('",p_pmdl026,"',' ') "
   PREPARE apsp610_03_ins_pmdo_prep FROM l_sql
   DECLARE apsp610_03_ins_pmdo_curs CURSOR WITH HOLD FOR apsp610_03_ins_pmdo_prep

   INITIALIZE l_pmdo_tmp.* TO NULL
   #161109-00085#61 --s mark
   #FOREACH apsp610_03_ins_pmdo_curs INTO l_pmdo_tmp.*,l_pmdoent,l_pmdosite,
   #                                      l_pmdo003,l_pmdo007,l_pmdo008,
   #                                      l_pmdo010,l_pmdo014,l_pmdo015,
   #                                      l_pmdo016,l_pmdo017,l_pmdo019,l_pmdo020,
   #                                      l_pmdo021,l_pmdo022,l_pmdo023,l_pmdo024,
   #                                      l_pmdo025,l_pmdo026,l_pmdo027,l_pmdo028,
   #                                      l_pmdo029,l_pmdo030,l_pmdo031,l_pmdo032,
   #                                      l_pmdo033,l_pmdo034
   #161109-00085#61 --e mark
   #161109-00085#61 --s add
   FOREACH apsp610_03_ins_pmdo_curs INTO l_pmdo_tmp.pmdoseq_03_04,l_pmdo_tmp.pmdoseq1_03_04,l_pmdo_tmp.pmdo001_03_04,l_pmdo_tmp.imaal003_03_04,l_pmdo_tmp.imaal004_03_04,
                                         l_pmdo_tmp.pmdo002_03_04,l_pmdo_tmp.pmdo002_03_04_desc,l_pmdo_tmp.pmdo004_03_04,l_pmdo_tmp.pmdo005_03_04,l_pmdo_tmp.pmdoseq2_03_04,    
                                         l_pmdo_tmp.pmdo006_03_04,l_pmdo_tmp.pmdo009_03_04,l_pmdo_tmp.pmdo011_03_04,l_pmdo_tmp.pmdo012_03_04,l_pmdo_tmp.pmdo013_03_04,
                                         l_pmdoent,l_pmdosite,l_pmdo003,l_pmdo007,l_pmdo008,
                                         l_pmdo010,l_pmdo014,l_pmdo015,l_pmdo016,l_pmdo017,
                                         l_pmdo019,l_pmdo020,l_pmdo021,l_pmdo022,l_pmdo023,
                                         l_pmdo024,l_pmdo025,l_pmdo026,l_pmdo027,l_pmdo028,
                                         l_pmdo029,l_pmdo030,l_pmdo031,l_pmdo032,l_pmdo033,
                                         l_pmdo034
   #161109-00085#61 --e add
      IF STATUS THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = STATUS
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      INITIALIZE l_pmdo.* TO NULL
      LET l_pmdo.pmdoent   = g_enterprise
      LET l_pmdo.pmdosite  = g_site
      LET l_pmdo.pmdodocno = p_pmdldocno
      LET l_pmdo.pmdoseq   = l_pmdo_tmp.pmdoseq_03_04
      LET l_pmdo.pmdoseq1  = l_pmdo_tmp.pmdoseq1_03_04
      LET l_pmdo.pmdoseq2  = l_pmdo_tmp.pmdoseq2_03_04    #分批序   
      LET l_pmdo.pmdo001   = l_pmdo_tmp.pmdo001_03_04
      LET l_pmdo.pmdo002   = l_pmdo_tmp.pmdo002_03_04
      LET l_pmdo.pmdo003   = l_pmdo003                    #子件特性
      LET l_pmdo.pmdo004   = l_pmdo_tmp.pmdo004_03_04
      LET l_pmdo.pmdo005   = l_pmdo_tmp.pmdo005_03_04
      LET l_pmdo.pmdo006   = l_pmdo_tmp.pmdo006_03_04     #分批採購數量
      LET l_pmdo.pmdo007   = l_pmdo007                    #折合主件數量
      LET l_pmdo.pmdo008   = l_pmdo008                    #QPA 
      LET l_pmdo.pmdo009   = l_pmdo_tmp.pmdo009_03_04     #交期類型 
      LET l_pmdo.pmdo010   = l_pmdo010                    #收貨時段 
      LET l_pmdo.pmdo011   = l_pmdo_tmp.pmdo011_03_04
      LET l_pmdo.pmdo012   = l_pmdo_tmp.pmdo012_03_04
      LET l_pmdo.pmdo013   = l_pmdo_tmp.pmdo013_03_04
      LET l_pmdo.pmdo014   = l_pmdo014                    #MRP交期凍結 
      LET l_pmdo.pmdo015   = l_pmdo015                    #已收貨量 
      LET l_pmdo.pmdo016   = l_pmdo016                    #驗退量 
      LET l_pmdo.pmdo017   = l_pmdo017                    #倉退換貨量 
      LET l_pmdo.pmdo019   = l_pmdo019                    #已入庫量 
      LET l_pmdo.pmdo020   = l_pmdo020                    #VMI請款量  
      LET l_pmdo.pmdo021   = l_pmdo021                    #交貨狀態 
      LET l_pmdo.pmdo022   = l_pmdo022                    #參考價格 
      LET l_pmdo.pmdo023 = l_pmdl.pmdl011               #稅別 
      LET l_pmdo.pmdo024 = l_pmdl.pmdl012               #稅率 
      LET l_pmdo.pmdo025 = l_pmdo025                    #電子採購單號 
      LET l_pmdo.pmdo026 = l_pmdo026                    #最近修改人員 
      LET l_pmdo.pmdo027 = l_pmdo027                    #最近修改時間 
      LET l_pmdo.pmdo028 = l_pmdo028                    #分批參考單位 
      LET l_pmdo.pmdo029 = l_pmdo029                    #分批參考數量 
      LET l_pmdo.pmdo030 = l_pmdo030                    #分批計價單位 
      LET l_pmdo.pmdo031 = l_pmdo031                    #分批計價數量 
      LET l_pmdo.pmdo032 = l_pmdo032                    #分批未稅金額 
      LET l_pmdo.pmdo033 = l_pmdo033                    #分批含稅金額 
      LET l_pmdo.pmdo034 = l_pmdo034                    #分批稅額   
      #LET l_pmdo.pmdo035 = ??                          #初始營運據點 
      #LET l_pmdo.pmdo036 = ??                          #初始來源單號  
      #LET l_pmdo.pmdo037 = ??                          #初始來源項次 
      #LET l_pmdo.pmdo038 = ??                          #初始項序  
      #LET l_pmdo.pmdo039 = ??                          #初始分批序      
      #因為是新產生出來的資料，所以一定會是0 
      LET l_pmdo.pmdo040  = '0'                         #倉退量 
       
       #mod--161109-00085#14 By 08993--(s)
#       INSERT INTO pmdo_t VALUES(l_pmdo.*)   #mark--161109-00085#14 By 08993--(s)
       #161109-00085#61 --s mark
       #INSERT INTO pmdo_t(pmdoent,pmdosite,pmdodocno,pmdoseq,pmdoseq1,pmdoseq2,pmdo001,pmdo002,pmdo003,pmdo004,pmdo005,
       #                   pmdo006,pmdo007,pmdo008,pmdo009,pmdo010,pmdo011,pmdo012,pmdo013,pmdo014,pmdo015,pmdo016,pmdo017,
       #                   pmdo019,pmdo020,pmdo021,pmdo022,pmdo023,pmdo024,pmdo025,pmdo026,pmdo027,pmdo028,pmdo029,pmdo030,
       #                   pmdo031,pmdo032,pmdo033,pmdo034,pmdo035,pmdo036,pmdo037,pmdo038,pmdo039,pmdo040,pmdo200,pmdo201,
       #                   pmdo900,pmdo999,pmdo041,pmdo042,pmdo043,pmdo044) 
       #            VALUES(l_pmdo.pmdoent,l_pmdo.pmdosite,l_pmdo.pmdodocno,l_pmdo.pmdoseq,l_pmdo.pmdoseq1,l_pmdo.pmdoseq2,
       #                   l_pmdo.pmdo001,l_pmdo.pmdo002,l_pmdo.pmdo003,l_pmdo.pmdo004,l_pmdo.pmdo005,l_pmdo.pmdo006,l_pmdo.pmdo007,
       #                   l_pmdo.pmdo008,l_pmdo.pmdo009,l_pmdo.pmdo010,l_pmdo.pmdo011,l_pmdo.pmdo012,l_pmdo.pmdo013,l_pmdo.pmdo014,
       #                   l_pmdo.pmdo015,l_pmdo.pmdo016,l_pmdo.pmdo017,l_pmdo.pmdo019,l_pmdo.pmdo020,l_pmdo.pmdo021,l_pmdo.pmdo022,
       #                   l_pmdo.pmdo023,l_pmdo.pmdo024,l_pmdo.pmdo025,l_pmdo.pmdo026,l_pmdo.pmdo027,l_pmdo.pmdo028,l_pmdo.pmdo029,
       #                   l_pmdo.pmdo030,l_pmdo.pmdo031,l_pmdo.pmdo032,l_pmdo.pmdo033,l_pmdo.pmdo034,l_pmdo.pmdo035,l_pmdo.pmdo036,
       #                   l_pmdo.pmdo037,l_pmdo.pmdo038,l_pmdo.pmdo039,l_pmdo.pmdo040,l_pmdo.pmdo200,l_pmdo.pmdo201,l_pmdo.pmdo900,
       #                   l_pmdo.pmdo999,l_pmdo.pmdo041,l_pmdo.pmdo042,l_pmdo.pmdo043,l_pmdo.pmdo044)
       #mod--161109-00085#14 By 08993--(e)
       #161109-00085#61 --e mark
       #161109-00085#61 --s add
       INSERT INTO pmdo_t(pmdoent,pmdosite,pmdodocno,pmdoseq,pmdoseq1,
                          pmdoseq2,pmdo001,pmdo002,pmdo003,pmdo004,
                          pmdo005,pmdo006,pmdo007,pmdo008,pmdo009,
                          pmdo010,pmdo011,pmdo012,pmdo013,pmdo014,
                          pmdo015,pmdo016,pmdo017,pmdo019,pmdo020,
                          pmdo021,pmdo022,pmdo023,pmdo024,pmdo025,
                          pmdo026,pmdo027,pmdo028,pmdo029,pmdo030,
                          pmdo031,pmdo032,pmdo033,pmdo034,pmdo035,
                          pmdo036,pmdo037,pmdo038,pmdo039,pmdo040,
                          pmdo200,pmdo201,pmdo900,pmdo999,pmdoud001,
                          pmdoud002,pmdoud003,pmdoud004,pmdoud005,pmdoud006,
                          pmdoud007,pmdoud008,pmdoud009,pmdoud010,pmdoud011,
                          pmdoud012,pmdoud013,pmdoud014,pmdoud015,pmdoud016,
                          pmdoud017,pmdoud018,pmdoud019,pmdoud020,pmdoud021,
                          pmdoud022,pmdoud023,pmdoud024,pmdoud025,pmdoud026,
                          pmdoud027,pmdoud028,pmdoud029,pmdoud030,pmdo041,
                          pmdo042,pmdo043,pmdo044)
       VALUES(l_pmdo.pmdoent,l_pmdo.pmdosite,l_pmdo.pmdodocno,l_pmdo.pmdoseq,l_pmdo.pmdoseq1,
              l_pmdo.pmdoseq2,l_pmdo.pmdo001,l_pmdo.pmdo002,l_pmdo.pmdo003,l_pmdo.pmdo004,
              l_pmdo.pmdo005,l_pmdo.pmdo006,l_pmdo.pmdo007,l_pmdo.pmdo008,l_pmdo.pmdo009,
              l_pmdo.pmdo010,l_pmdo.pmdo011,l_pmdo.pmdo012,l_pmdo.pmdo013,l_pmdo.pmdo014,
              l_pmdo.pmdo015,l_pmdo.pmdo016,l_pmdo.pmdo017,l_pmdo.pmdo019,l_pmdo.pmdo020,
              l_pmdo.pmdo021,l_pmdo.pmdo022,l_pmdo.pmdo023,l_pmdo.pmdo024,l_pmdo.pmdo025,
              l_pmdo.pmdo026,l_pmdo.pmdo027,l_pmdo.pmdo028,l_pmdo.pmdo029,l_pmdo.pmdo030,
              l_pmdo.pmdo031,l_pmdo.pmdo032,l_pmdo.pmdo033,l_pmdo.pmdo034,l_pmdo.pmdo035,
              l_pmdo.pmdo036,l_pmdo.pmdo037,l_pmdo.pmdo038,l_pmdo.pmdo039,l_pmdo.pmdo040,
              l_pmdo.pmdo200,l_pmdo.pmdo201,l_pmdo.pmdo900,l_pmdo.pmdo999,l_pmdo.pmdoud001,
              l_pmdo.pmdoud002,l_pmdo.pmdoud003,l_pmdo.pmdoud004,l_pmdo.pmdoud005,l_pmdo.pmdoud006,
              l_pmdo.pmdoud007,l_pmdo.pmdoud008,l_pmdo.pmdoud009,l_pmdo.pmdoud010,l_pmdo.pmdoud011,
              l_pmdo.pmdoud012,l_pmdo.pmdoud013,l_pmdo.pmdoud014,l_pmdo.pmdoud015,l_pmdo.pmdoud016,
              l_pmdo.pmdoud017,l_pmdo.pmdoud018,l_pmdo.pmdoud019,l_pmdo.pmdoud020,l_pmdo.pmdoud021,
              l_pmdo.pmdoud022,l_pmdo.pmdoud023,l_pmdo.pmdoud024,l_pmdo.pmdoud025,l_pmdo.pmdoud026,
              l_pmdo.pmdoud027,l_pmdo.pmdoud028,l_pmdo.pmdoud029,l_pmdo.pmdoud030,l_pmdo.pmdo041,
              l_pmdo.pmdo042,l_pmdo.pmdo043,l_pmdo.pmdo044)
       #161109-00085#61 --e add
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsp610_03_oocq_chk(p_oocq001,p_oocq002)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_03_oocq_chk(p_oocq001,p_oocq002)
   DEFINE p_oocq001     LIKE oocq_t.oocq001
   DEFINE p_oocq002     LIKE oocq_t.oocq002
   DEFINE l_oocqstus    LIKE oocq_t.oocqstus 
   
   WHENEVER ERROR CONTINUE 

   LET g_errno = ''
   LET l_oocqstus = ''

   SELECT oocqstus INTO l_oocqstus
     FROM oocq_t
    WHERE oocqent = g_enterprise
      AND oocq001 = p_oocq001
      AND oocq002 = p_oocq002

   CASE
      WHEN SQLCA.sqlcode = 100     LET g_errno = 'sub-01303'      #輸入的資料不存在於 應用分類碼檔 中！  
      WHEN l_oocqstus <> 'Y'       LET g_errno = 'sub-01302'      #輸入的資料無效！  
      OTHERWISE                    LET g_errno = SQLCA.sqlcode USING '------'
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsp610_03_pmdn001_desc(p_pmdl004,p_pmdn,p_pmal002)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_03_pmdn001_desc(p_pmdl004,p_pmdn,p_pmal002)
   DEFINE p_pmdl004  LIKE pmdl_t.pmdl004
   #mod--161109-00085#14 By 08993--(s)
#   DEFINE p_pmdn      RECORD LIKE pmdn_t.*   #mark--161109-00085#14 By 08993--(s)
   DEFINE p_pmdn RECORD  #採購單身明細檔
          pmdnent LIKE pmdn_t.pmdnent, #企業編號
          pmdnsite LIKE pmdn_t.pmdnsite, #營運據點
          pmdnunit LIKE pmdn_t.pmdnunit, #應用組織
          pmdndocno LIKE pmdn_t.pmdndocno, #採購單號
          pmdnseq LIKE pmdn_t.pmdnseq, #項次
          pmdn001 LIKE pmdn_t.pmdn001, #料件編號
          pmdn002 LIKE pmdn_t.pmdn002, #產品特徵
          pmdn003 LIKE pmdn_t.pmdn003, #包裝容器
          pmdn004 LIKE pmdn_t.pmdn004, #作業編號
          pmdn005 LIKE pmdn_t.pmdn005, #作業序
          pmdn006 LIKE pmdn_t.pmdn006, #採購單位
          pmdn007 LIKE pmdn_t.pmdn007, #採購數量
          pmdn008 LIKE pmdn_t.pmdn008, #參考單位
          pmdn009 LIKE pmdn_t.pmdn009, #參考數量
          pmdn010 LIKE pmdn_t.pmdn010, #計價單位
          pmdn011 LIKE pmdn_t.pmdn011, #計價數量
          pmdn012 LIKE pmdn_t.pmdn012, #出貨日期
          pmdn013 LIKE pmdn_t.pmdn013, #到廠日期
          pmdn014 LIKE pmdn_t.pmdn014, #到庫日期
          pmdn015 LIKE pmdn_t.pmdn015, #單價
          pmdn016 LIKE pmdn_t.pmdn016, #稅別
          pmdn017 LIKE pmdn_t.pmdn017, #稅率
          pmdn019 LIKE pmdn_t.pmdn019, #子件特性
          pmdn020 LIKE pmdn_t.pmdn020, #緊急度
          pmdn021 LIKE pmdn_t.pmdn021, #保稅
          pmdn022 LIKE pmdn_t.pmdn022, #部分交貨
          pmdnorga LIKE pmdn_t.pmdnorga, #付款據點
          pmdn023 LIKE pmdn_t.pmdn023, #送貨供應商
          pmdn024 LIKE pmdn_t.pmdn024, #多交期
          pmdn025 LIKE pmdn_t.pmdn025, #收貨地址編號
          pmdn026 LIKE pmdn_t.pmdn026, #帳款地址編號
          pmdn027 LIKE pmdn_t.pmdn027, #供應商料號
          pmdn028 LIKE pmdn_t.pmdn028, #收貨庫位
          pmdn029 LIKE pmdn_t.pmdn029, #收貨儲位
          pmdn030 LIKE pmdn_t.pmdn030, #收貨批號
          pmdn031 LIKE pmdn_t.pmdn031, #運輸方式
          pmdn032 LIKE pmdn_t.pmdn032, #取貨模式
          pmdn033 LIKE pmdn_t.pmdn033, #備品率
          pmdn034 LIKE pmdn_t.pmdn034, #no use
          pmdn035 LIKE pmdn_t.pmdn035, #價格核決
          pmdn036 LIKE pmdn_t.pmdn036, #專案編號
          pmdn037 LIKE pmdn_t.pmdn037, #WBS編號
          pmdn038 LIKE pmdn_t.pmdn038, #活動編號
          pmdn039 LIKE pmdn_t.pmdn039, #費用原因
          pmdn040 LIKE pmdn_t.pmdn040, #取價來源
          pmdn041 LIKE pmdn_t.pmdn041, #價格參考單號
          pmdn042 LIKE pmdn_t.pmdn042, #價格參考項次
          pmdn043 LIKE pmdn_t.pmdn043, #取出價格
          pmdn044 LIKE pmdn_t.pmdn044, #價差比
          pmdn045 LIKE pmdn_t.pmdn045, #行狀態
          pmdn046 LIKE pmdn_t.pmdn046, #未稅金額
          pmdn047 LIKE pmdn_t.pmdn047, #含稅金額
          pmdn048 LIKE pmdn_t.pmdn048, #稅額
          pmdn049 LIKE pmdn_t.pmdn049, #理由碼
          pmdn050 LIKE pmdn_t.pmdn050, #備註
          pmdn051 LIKE pmdn_t.pmdn051, #留置/結案理由碼
          pmdn052 LIKE pmdn_t.pmdn052, #檢驗否
          pmdn053 LIKE pmdn_t.pmdn053, #庫存管理特徵
          pmdn200 LIKE pmdn_t.pmdn200, #商品條碼
          pmdn201 LIKE pmdn_t.pmdn201, #包裝單位
          pmdn202 LIKE pmdn_t.pmdn202, #包裝數量
          pmdn203 LIKE pmdn_t.pmdn203, #收貨部門
          pmdn204 LIKE pmdn_t.pmdn204, #No Use
          pmdn205 LIKE pmdn_t.pmdn205, #要貨組織
          pmdn206 LIKE pmdn_t.pmdn206, #庫存量
          pmdn207 LIKE pmdn_t.pmdn207, #採購在途量
          pmdn208 LIKE pmdn_t.pmdn208, #前日銷售量
          pmdn209 LIKE pmdn_t.pmdn209, #上月銷量
          pmdn210 LIKE pmdn_t.pmdn210, #第一週銷量
          pmdn211 LIKE pmdn_t.pmdn211, #第二週銷量
          pmdn212 LIKE pmdn_t.pmdn212, #第三週銷量
          pmdn213 LIKE pmdn_t.pmdn213, #第四週銷量
          pmdn214 LIKE pmdn_t.pmdn214, #採購通路
          pmdn215 LIKE pmdn_t.pmdn215, #通路性質
          pmdn216 LIKE pmdn_t.pmdn216, #經營方式
          pmdn217 LIKE pmdn_t.pmdn217, #結算方式
          pmdn218 LIKE pmdn_t.pmdn218, #合約編號
          pmdn219 LIKE pmdn_t.pmdn219, #協議編號
          pmdn220 LIKE pmdn_t.pmdn220, #採購人員
          pmdn221 LIKE pmdn_t.pmdn221, #採購部門
          pmdn222 LIKE pmdn_t.pmdn222, #採購中心
          pmdn223 LIKE pmdn_t.pmdn223, #配送中心
          pmdn224 LIKE pmdn_t.pmdn224, #採購失效日
          pmdn900 LIKE pmdn_t.pmdn900, #保留欄位str
          pmdn999 LIKE pmdn_t.pmdn999, #保留欄位end
          #161109-00085#61 --s add
          pmdnud001 LIKE pmdn_t.pmdnud001, #自定義欄位(文字)001
          pmdnud002 LIKE pmdn_t.pmdnud002, #自定義欄位(文字)002
          pmdnud003 LIKE pmdn_t.pmdnud003, #自定義欄位(文字)003
          pmdnud004 LIKE pmdn_t.pmdnud004, #自定義欄位(文字)004
          pmdnud005 LIKE pmdn_t.pmdnud005, #自定義欄位(文字)005
          pmdnud006 LIKE pmdn_t.pmdnud006, #自定義欄位(文字)006
          pmdnud007 LIKE pmdn_t.pmdnud007, #自定義欄位(文字)007
          pmdnud008 LIKE pmdn_t.pmdnud008, #自定義欄位(文字)008
          pmdnud009 LIKE pmdn_t.pmdnud009, #自定義欄位(文字)009
          pmdnud010 LIKE pmdn_t.pmdnud010, #自定義欄位(文字)010
          pmdnud011 LIKE pmdn_t.pmdnud011, #自定義欄位(數字)011
          pmdnud012 LIKE pmdn_t.pmdnud012, #自定義欄位(數字)012
          pmdnud013 LIKE pmdn_t.pmdnud013, #自定義欄位(數字)013
          pmdnud014 LIKE pmdn_t.pmdnud014, #自定義欄位(數字)014
          pmdnud015 LIKE pmdn_t.pmdnud015, #自定義欄位(數字)015
          pmdnud016 LIKE pmdn_t.pmdnud016, #自定義欄位(數字)016
          pmdnud017 LIKE pmdn_t.pmdnud017, #自定義欄位(數字)017
          pmdnud018 LIKE pmdn_t.pmdnud018, #自定義欄位(數字)018
          pmdnud019 LIKE pmdn_t.pmdnud019, #自定義欄位(數字)019
          pmdnud020 LIKE pmdn_t.pmdnud020, #自定義欄位(數字)020
          pmdnud021 LIKE pmdn_t.pmdnud021, #自定義欄位(日期時間)021
          pmdnud022 LIKE pmdn_t.pmdnud022, #自定義欄位(日期時間)022
          pmdnud023 LIKE pmdn_t.pmdnud023, #自定義欄位(日期時間)023
          pmdnud024 LIKE pmdn_t.pmdnud024, #自定義欄位(日期時間)024
          pmdnud025 LIKE pmdn_t.pmdnud025, #自定義欄位(日期時間)025
          pmdnud026 LIKE pmdn_t.pmdnud026, #自定義欄位(日期時間)026
          pmdnud027 LIKE pmdn_t.pmdnud027, #自定義欄位(日期時間)027
          pmdnud028 LIKE pmdn_t.pmdnud028, #自定義欄位(日期時間)028
          pmdnud029 LIKE pmdn_t.pmdnud029, #自定義欄位(日期時間)029
          pmdnud030 LIKE pmdn_t.pmdnud030, #自定義欄位(日期時間)030
          #161109-00085#61 --e add
          pmdn225 LIKE pmdn_t.pmdn225, #最終收貨組織
          pmdn054 LIKE pmdn_t.pmdn054, #還料數量
          pmdn055 LIKE pmdn_t.pmdn055, #還量參考數量
          pmdn056 LIKE pmdn_t.pmdn056, #還價數量
          pmdn057 LIKE pmdn_t.pmdn057, #還價參考數量
          pmdn226 LIKE pmdn_t.pmdn226, #長效期每次送貨量
          pmdn227 LIKE pmdn_t.pmdn227, #補貨規格說明
          pmdn058 LIKE pmdn_t.pmdn058, #預算科目
          pmdn228 LIKE pmdn_t.pmdn228  #商品品類
   END RECORD
   #mod--161109-00085#14 By 08993--(e)
   
   DEFINE p_pmal002  LIKE pmal_t.pmal002
   #mod--161109-00085#14 By 08993--(s)
#   DEFINE r_pmdn      RECORD LIKE pmdn_t.*   #mark--161109-00085#14 By 08993--(s)
   DEFINE r_pmdn RECORD  #採購單身明細檔
          pmdnent LIKE pmdn_t.pmdnent, #企業編號
          pmdnsite LIKE pmdn_t.pmdnsite, #營運據點
          pmdnunit LIKE pmdn_t.pmdnunit, #應用組織
          pmdndocno LIKE pmdn_t.pmdndocno, #採購單號
          pmdnseq LIKE pmdn_t.pmdnseq, #項次
          pmdn001 LIKE pmdn_t.pmdn001, #料件編號
          pmdn002 LIKE pmdn_t.pmdn002, #產品特徵
          pmdn003 LIKE pmdn_t.pmdn003, #包裝容器
          pmdn004 LIKE pmdn_t.pmdn004, #作業編號
          pmdn005 LIKE pmdn_t.pmdn005, #作業序
          pmdn006 LIKE pmdn_t.pmdn006, #採購單位
          pmdn007 LIKE pmdn_t.pmdn007, #採購數量
          pmdn008 LIKE pmdn_t.pmdn008, #參考單位
          pmdn009 LIKE pmdn_t.pmdn009, #參考數量
          pmdn010 LIKE pmdn_t.pmdn010, #計價單位
          pmdn011 LIKE pmdn_t.pmdn011, #計價數量
          pmdn012 LIKE pmdn_t.pmdn012, #出貨日期
          pmdn013 LIKE pmdn_t.pmdn013, #到廠日期
          pmdn014 LIKE pmdn_t.pmdn014, #到庫日期
          pmdn015 LIKE pmdn_t.pmdn015, #單價
          pmdn016 LIKE pmdn_t.pmdn016, #稅別
          pmdn017 LIKE pmdn_t.pmdn017, #稅率
          pmdn019 LIKE pmdn_t.pmdn019, #子件特性
          pmdn020 LIKE pmdn_t.pmdn020, #緊急度
          pmdn021 LIKE pmdn_t.pmdn021, #保稅
          pmdn022 LIKE pmdn_t.pmdn022, #部分交貨
          pmdnorga LIKE pmdn_t.pmdnorga, #付款據點
          pmdn023 LIKE pmdn_t.pmdn023, #送貨供應商
          pmdn024 LIKE pmdn_t.pmdn024, #多交期
          pmdn025 LIKE pmdn_t.pmdn025, #收貨地址編號
          pmdn026 LIKE pmdn_t.pmdn026, #帳款地址編號
          pmdn027 LIKE pmdn_t.pmdn027, #供應商料號
          pmdn028 LIKE pmdn_t.pmdn028, #收貨庫位
          pmdn029 LIKE pmdn_t.pmdn029, #收貨儲位
          pmdn030 LIKE pmdn_t.pmdn030, #收貨批號
          pmdn031 LIKE pmdn_t.pmdn031, #運輸方式
          pmdn032 LIKE pmdn_t.pmdn032, #取貨模式
          pmdn033 LIKE pmdn_t.pmdn033, #備品率
          pmdn034 LIKE pmdn_t.pmdn034, #no use
          pmdn035 LIKE pmdn_t.pmdn035, #價格核決
          pmdn036 LIKE pmdn_t.pmdn036, #專案編號
          pmdn037 LIKE pmdn_t.pmdn037, #WBS編號
          pmdn038 LIKE pmdn_t.pmdn038, #活動編號
          pmdn039 LIKE pmdn_t.pmdn039, #費用原因
          pmdn040 LIKE pmdn_t.pmdn040, #取價來源
          pmdn041 LIKE pmdn_t.pmdn041, #價格參考單號
          pmdn042 LIKE pmdn_t.pmdn042, #價格參考項次
          pmdn043 LIKE pmdn_t.pmdn043, #取出價格
          pmdn044 LIKE pmdn_t.pmdn044, #價差比
          pmdn045 LIKE pmdn_t.pmdn045, #行狀態
          pmdn046 LIKE pmdn_t.pmdn046, #未稅金額
          pmdn047 LIKE pmdn_t.pmdn047, #含稅金額
          pmdn048 LIKE pmdn_t.pmdn048, #稅額
          pmdn049 LIKE pmdn_t.pmdn049, #理由碼
          pmdn050 LIKE pmdn_t.pmdn050, #備註
          pmdn051 LIKE pmdn_t.pmdn051, #留置/結案理由碼
          pmdn052 LIKE pmdn_t.pmdn052, #檢驗否
          pmdn053 LIKE pmdn_t.pmdn053, #庫存管理特徵
          pmdn200 LIKE pmdn_t.pmdn200, #商品條碼
          pmdn201 LIKE pmdn_t.pmdn201, #包裝單位
          pmdn202 LIKE pmdn_t.pmdn202, #包裝數量
          pmdn203 LIKE pmdn_t.pmdn203, #收貨部門
          pmdn204 LIKE pmdn_t.pmdn204, #No Use
          pmdn205 LIKE pmdn_t.pmdn205, #要貨組織
          pmdn206 LIKE pmdn_t.pmdn206, #庫存量
          pmdn207 LIKE pmdn_t.pmdn207, #採購在途量
          pmdn208 LIKE pmdn_t.pmdn208, #前日銷售量
          pmdn209 LIKE pmdn_t.pmdn209, #上月銷量
          pmdn210 LIKE pmdn_t.pmdn210, #第一週銷量
          pmdn211 LIKE pmdn_t.pmdn211, #第二週銷量
          pmdn212 LIKE pmdn_t.pmdn212, #第三週銷量
          pmdn213 LIKE pmdn_t.pmdn213, #第四週銷量
          pmdn214 LIKE pmdn_t.pmdn214, #採購通路
          pmdn215 LIKE pmdn_t.pmdn215, #通路性質
          pmdn216 LIKE pmdn_t.pmdn216, #經營方式
          pmdn217 LIKE pmdn_t.pmdn217, #結算方式
          pmdn218 LIKE pmdn_t.pmdn218, #合約編號
          pmdn219 LIKE pmdn_t.pmdn219, #協議編號
          pmdn220 LIKE pmdn_t.pmdn220, #採購人員
          pmdn221 LIKE pmdn_t.pmdn221, #採購部門
          pmdn222 LIKE pmdn_t.pmdn222, #採購中心
          pmdn223 LIKE pmdn_t.pmdn223, #配送中心
          pmdn224 LIKE pmdn_t.pmdn224, #採購失效日
          pmdn900 LIKE pmdn_t.pmdn900, #保留欄位str
          pmdn999 LIKE pmdn_t.pmdn999, #保留欄位end
          #161109-00085#61 --s add
          pmdnud001 LIKE pmdn_t.pmdnud001, #自定義欄位(文字)001
          pmdnud002 LIKE pmdn_t.pmdnud002, #自定義欄位(文字)002
          pmdnud003 LIKE pmdn_t.pmdnud003, #自定義欄位(文字)003
          pmdnud004 LIKE pmdn_t.pmdnud004, #自定義欄位(文字)004
          pmdnud005 LIKE pmdn_t.pmdnud005, #自定義欄位(文字)005
          pmdnud006 LIKE pmdn_t.pmdnud006, #自定義欄位(文字)006
          pmdnud007 LIKE pmdn_t.pmdnud007, #自定義欄位(文字)007
          pmdnud008 LIKE pmdn_t.pmdnud008, #自定義欄位(文字)008
          pmdnud009 LIKE pmdn_t.pmdnud009, #自定義欄位(文字)009
          pmdnud010 LIKE pmdn_t.pmdnud010, #自定義欄位(文字)010
          pmdnud011 LIKE pmdn_t.pmdnud011, #自定義欄位(數字)011
          pmdnud012 LIKE pmdn_t.pmdnud012, #自定義欄位(數字)012
          pmdnud013 LIKE pmdn_t.pmdnud013, #自定義欄位(數字)013
          pmdnud014 LIKE pmdn_t.pmdnud014, #自定義欄位(數字)014
          pmdnud015 LIKE pmdn_t.pmdnud015, #自定義欄位(數字)015
          pmdnud016 LIKE pmdn_t.pmdnud016, #自定義欄位(數字)016
          pmdnud017 LIKE pmdn_t.pmdnud017, #自定義欄位(數字)017
          pmdnud018 LIKE pmdn_t.pmdnud018, #自定義欄位(數字)018
          pmdnud019 LIKE pmdn_t.pmdnud019, #自定義欄位(數字)019
          pmdnud020 LIKE pmdn_t.pmdnud020, #自定義欄位(數字)020
          pmdnud021 LIKE pmdn_t.pmdnud021, #自定義欄位(日期時間)021
          pmdnud022 LIKE pmdn_t.pmdnud022, #自定義欄位(日期時間)022
          pmdnud023 LIKE pmdn_t.pmdnud023, #自定義欄位(日期時間)023
          pmdnud024 LIKE pmdn_t.pmdnud024, #自定義欄位(日期時間)024
          pmdnud025 LIKE pmdn_t.pmdnud025, #自定義欄位(日期時間)025
          pmdnud026 LIKE pmdn_t.pmdnud026, #自定義欄位(日期時間)026
          pmdnud027 LIKE pmdn_t.pmdnud027, #自定義欄位(日期時間)027
          pmdnud028 LIKE pmdn_t.pmdnud028, #自定義欄位(日期時間)028
          pmdnud029 LIKE pmdn_t.pmdnud029, #自定義欄位(日期時間)029
          pmdnud030 LIKE pmdn_t.pmdnud030, #自定義欄位(日期時間)030
          #161109-00085#61 --e add
          pmdn225 LIKE pmdn_t.pmdn225, #最終收貨組織
          pmdn054 LIKE pmdn_t.pmdn054, #還料數量
          pmdn055 LIKE pmdn_t.pmdn055, #還量參考數量
          pmdn056 LIKE pmdn_t.pmdn056, #還價數量
          pmdn057 LIKE pmdn_t.pmdn057, #還價參考數量
          pmdn226 LIKE pmdn_t.pmdn226, #長效期每次送貨量
          pmdn227 LIKE pmdn_t.pmdn227, #補貨規格說明
          pmdn058 LIKE pmdn_t.pmdn058, #預算科目
          pmdn228 LIKE pmdn_t.pmdn228  #商品品類
   END RECORD
   #mod--161109-00085#14 By 08993--(e)
 
   DEFINE l_imaf158  LIKE imaf_t.imaf158
   #DEFINE l_n         LIKE type_t.num5    #170104-00066#1 17/01/05 mark by rainy 
   DEFINE l_n          LIKE type_t.num10    #170104-00066#1 17/01/05 add by rainy
   
   WHENEVER ERROR CONTINUE 

   LET r_pmdn.* = p_pmdn.*
   LET l_n = 0

   IF NOT cl_null(p_pmal002) THEN
      SELECT COUNT(*) INTO l_n
        FROM pmap_t
       WHERE pmapent  = g_enterprise
         AND pmapsite = g_site
         AND pmap001  = p_pmdl004
         AND pmap002  = p_pmal002
         AND pmap003  = r_pmdn.pmdn001
         AND pmap004  = r_pmdn.pmdn002
      #若採購料件有設置'供應商控制組料件預設條件'(apmi121)時，則需將設置的預設條件值預設到採購單對應欄位
      IF l_n > 0 THEN
         #2015/01/05 採購不再預設庫儲資料，否則收貨、入庫時會沒辦法修改 
         SELECT pmap009,pmap012,pmap014,pmap005
           INTO r_pmdn.pmdnunit,         #收貨據點 
                r_pmdn.pmdn025,          #收貨地址代碼 
                r_pmdn.pmdn031,          #運輸方式 
                r_pmdn.pmdn003           #包裝容器  
           FROM pmdp_t
          WHERE pmdpent  = g_enterprise
            AND pmapsite = g_site
            AND pmap001  = p_pmdl004
            AND pmap002  = p_pmal002
            AND pmap003  = r_pmdn.pmdn001
            AND pmap004  = r_pmdn.pmdn002
      END IF
   END IF

   IF cl_null(p_pmal002) OR l_n = 0 THEN
      #沒有設置'供應商控制組料件預設條件'(apmi121)才改抓料件進銷存檔預設的條件 
      #2015/01/05 採購不再預設庫儲資料，否則收貨、入庫時會沒辦法修改
      SELECT imaf157
        INTO r_pmdn.pmdn003          #包裝容器 
        FROM imaf_t
       WHERE imafent  = g_enterprise
         AND imafsite = g_site
         AND imaf001  = r_pmdn.pmdn001
   END IF

   #[C:備品率] = [T:料件進銷存檔].[C:採購備品率]  imaf165
   #[C:參考單位] = [T:料件進銷存檔][C:參考單位]   imaf015
   #若[T:料件進銷存檔].[C:接單拆解方式(採購)]的值為'1:自動CKD'或是'2:自動SKD'時，imaf158
   #則[C:子件特性]的值預設'2:CKD'或是'3:SKD'
   LET r_pmdn.pmdn008 = ''      #參考單位  
   LET r_pmdn.pmdn033 = ''      #備品率   
   LET r_pmdn.pmdn019 = '1'     #子件特性   

   LET l_imaf158 = ''
   SELECT imaf158,imaf165,imaf015
     INTO l_imaf158,r_pmdn.pmdn033,r_pmdn.pmdn008
     FROM imaf_t
    WHERE imafent  = g_enterprise
      AND imafsite = g_site
      AND imaf001  = r_pmdn.pmdn001
   CASE l_imaf158
      WHEN '1'
         LET r_pmdn.pmdn019 = '2'
      WHEN '2'
         LET r_pmdn.pmdn019 = '3'
   END CASE

   #整體參數使用採購計價單位時:
   #[C:計價單位]=[T:料件據點進銷存檔].[C:採購計價單位] 
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0019') = "Y" THEN
      SELECT imaf144 INTO r_pmdn.pmdn010
        FROM imaf_t
       WHERE imafent  = g_enterprise
         AND imafsite = g_site
         AND imaf001  = r_pmdn.pmdn001
   END IF

   #若採購料件有設置'交易對象對應料號'(apmi070)有供應商料號時，需將對應的料號抓出顯示在
   #[C:供應商料號]欄位上，若有設置多筆對應料號時以有勾選主要對應料那一筆為預設值
   LET r_pmdn.pmdn027 = ''
   SELECT pmao004 INTO r_pmdn.pmdn027
     FROM pmao_t
    WHERE pmaoent = g_enterprise 
      AND pmao001 = p_pmdl004
      AND pmao002 = r_pmdn.pmdn001
      AND pmao003 = r_pmdn.pmdn002
      AND pmao000 = '1'    #161221-00064#23 add
      AND pmao007 = 'Y'
   IF cl_null(r_pmdn.pmdn027) THEN
      SELECT pmao004 INTO r_pmdn.pmdn027
        FROM pmao_t
       WHERE pmaoent = g_enterprise
         AND pmao001 = p_pmdl004
         AND pmao002 = r_pmdn.pmdn001
         AND pmao003 = r_pmdn.pmdn002
         AND pmao000 = '1'    #161221-00064#23 add
         AND pmao007 = 'Y'
         AND rownum  = 1
   END IF

   RETURN r_pmdn.*
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsp610_03_pmdnunit_chk(p_pmdnunit)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_03_pmdnunit_chk(p_pmdnunit)
   DEFINE p_pmdnunit     LIKE pmdn_t.pmdnunit
   DEFINE l_ooefstus     LIKE ooef_t.ooefstus 
   
   WHENEVER ERROR CONTINUE 

   LET g_errno = ''
   LET l_ooefstus = ''
   SELECT ooefstus INTO l_ooefstus
     FROM ooef_t
    WHERE ooef001 = p_pmdnunit
      AND ooefent = g_enterprise

   CASE
      WHEN SQLCA.sqlcode = 100      LET g_errno = 'aoo-00094'     #輸入的資料不存在[組織基本資料檔]中！
      WHEN l_ooefstus <> 'Y'        LET g_errno = 'sub-01302'     #輸入的資料無效！
      OTHERWISE                     LET g_errno = SQLCA.sqlcode USING '------'
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 根據營運據點獲取該營運據點的發票地址
# Memo...........:
# Usage..........: CALL apsp610_03_get_oofb019_5(p_site)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_03_get_oofb019_5(p_site)
   DEFINE p_site     LIKE ooef_t.ooef001
   DEFINE l_oofa001  LIKE oofa_t.oofa001
   DEFINE r_oofb019  LIKE oofb_t.oofb019
   DEFINE r_oofb011  LIKE oofb_t.oofb011 
   
   WHENEVER ERROR CONTINUE 

   LET r_oofb019 = ''
   LET r_oofb011 = ''

   #獲取當前營運據點的聯絡對象識別碼
   LET l_oofa001 = ''
   SELECT oofa001 INTO l_oofa001
     FROM oofa_t
    WHERE oofaent = g_enterprise
      AND oofa002 = '1'
      AND oofa003 = p_site

   IF NOT cl_null(l_oofa001) THEN
      #主要帳款地址
      SELECT oofb019,oofb011 INTO r_oofb019,r_oofb011
        FROM oofb_t
       WHERE oofbent = g_enterprise
         AND oofb002 = l_oofa001
         AND oofb002 = '5'
         AND oofb010 = 'Y'
      #若沒有勾選主要的
      IF cl_null(r_oofb019) THEN
         SELECT oofb019,oofb011 INTO r_oofb019,r_oofb011
           FROM oofb_t
          WHERE oofbent = g_enterprise
            AND oofb002 = l_oofa001 
            AND oofb002 = '5'
            AND rownum = 1
      END IF
      #呼叫地址組合應用元件

   END IF
   RETURN r_oofb019,r_oofb011
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsp610_03_gen_pmdq()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........: 
################################################################################
PUBLIC FUNCTION apsp610_03_gen_pmdq()
   DEFINE l_sql           STRING
   #mod--161109-00085#14 By 08993--(s)
#   DEFINE l_pmdq          RECORD LIKE pmdq_t.*   #mark--161109-00085#14 By 08993--(s)
   DEFINE l_pmdq RECORD  #採購多交期匯總檔
          pmdqent LIKE pmdq_t.pmdqent, #企業編號
          pmdqsite LIKE pmdq_t.pmdqsite, #營運據點
          pmdqdocno LIKE pmdq_t.pmdqdocno, #採購單號
          pmdqseq LIKE pmdq_t.pmdqseq, #採購項次
          pmdqseq2 LIKE pmdq_t.pmdqseq2, #分批序
          pmdq002 LIKE pmdq_t.pmdq002, #分批數量
          pmdq003 LIKE pmdq_t.pmdq003, #交貨日期
          pmdq004 LIKE pmdq_t.pmdq004, #到廠日期
          pmdq005 LIKE pmdq_t.pmdq005, #到庫日期
          pmdq006 LIKE pmdq_t.pmdq006, #收貨時段
          pmdq007 LIKE pmdq_t.pmdq007, #MRP凍結否
          pmdq008 LIKE pmdq_t.pmdq008, #交期類型
          pmdq201 LIKE pmdq_t.pmdq201, #分批包裝單位
          pmdq202 LIKE pmdq_t.pmdq202, #分批包裝數量
          pmdq900 LIKE pmdq_t.pmdq900, #保留欄位str
          #pmdq999 LIKE pmdq_t.pmdq999  #保留欄位end #161109-00085#61 mark
          #161109-00085#61 --s add
          pmdq999 LIKE pmdq_t.pmdq999, #保留欄位end
          pmdqud001 LIKE pmdq_t.pmdqud001, #自定義欄位(文字)001
          pmdqud002 LIKE pmdq_t.pmdqud002, #自定義欄位(文字)002
          pmdqud003 LIKE pmdq_t.pmdqud003, #自定義欄位(文字)003
          pmdqud004 LIKE pmdq_t.pmdqud004, #自定義欄位(文字)004
          pmdqud005 LIKE pmdq_t.pmdqud005, #自定義欄位(文字)005
          pmdqud006 LIKE pmdq_t.pmdqud006, #自定義欄位(文字)006
          pmdqud007 LIKE pmdq_t.pmdqud007, #自定義欄位(文字)007
          pmdqud008 LIKE pmdq_t.pmdqud008, #自定義欄位(文字)008
          pmdqud009 LIKE pmdq_t.pmdqud009, #自定義欄位(文字)009
          pmdqud010 LIKE pmdq_t.pmdqud010, #自定義欄位(文字)010
          pmdqud011 LIKE pmdq_t.pmdqud011, #自定義欄位(數字)011
          pmdqud012 LIKE pmdq_t.pmdqud012, #自定義欄位(數字)012
          pmdqud013 LIKE pmdq_t.pmdqud013, #自定義欄位(數字)013
          pmdqud014 LIKE pmdq_t.pmdqud014, #自定義欄位(數字)014
          pmdqud015 LIKE pmdq_t.pmdqud015, #自定義欄位(數字)015
          pmdqud016 LIKE pmdq_t.pmdqud016, #自定義欄位(數字)016
          pmdqud017 LIKE pmdq_t.pmdqud017, #自定義欄位(數字)017
          pmdqud018 LIKE pmdq_t.pmdqud018, #自定義欄位(數字)018
          pmdqud019 LIKE pmdq_t.pmdqud019, #自定義欄位(數字)019
          pmdqud020 LIKE pmdq_t.pmdqud020, #自定義欄位(數字)020
          pmdqud021 LIKE pmdq_t.pmdqud021, #自定義欄位(日期時間)021
          pmdqud022 LIKE pmdq_t.pmdqud022, #自定義欄位(日期時間)022
          pmdqud023 LIKE pmdq_t.pmdqud023, #自定義欄位(日期時間)023
          pmdqud024 LIKE pmdq_t.pmdqud024, #自定義欄位(日期時間)024
          pmdqud025 LIKE pmdq_t.pmdqud025, #自定義欄位(日期時間)025
          pmdqud026 LIKE pmdq_t.pmdqud026, #自定義欄位(日期時間)026
          pmdqud027 LIKE pmdq_t.pmdqud027, #自定義欄位(日期時間)027
          pmdqud028 LIKE pmdq_t.pmdqud028, #自定義欄位(日期時間)028
          pmdqud029 LIKE pmdq_t.pmdqud029, #自定義欄位(日期時間)029
          pmdqud030 LIKE pmdq_t.pmdqud030  #自定義欄位(日期時間)030
          #161109-00085#61 --e add
   END RECORD
   #mod--161109-00085#14 By 08993--(e)
   
   
   
   #mod--161109-00085#14 By 08993--(s)
#   DEFINE l_pmdn      RECORD LIKE pmdn_t.*   #mark--161109-00085#14 By 08993--(s)
   DEFINE l_pmdn RECORD  #採購單身明細檔
          pmdnent LIKE pmdn_t.pmdnent, #企業編號
          pmdnsite LIKE pmdn_t.pmdnsite, #營運據點
          pmdnunit LIKE pmdn_t.pmdnunit, #應用組織
          pmdndocno LIKE pmdn_t.pmdndocno, #採購單號
          pmdnseq LIKE pmdn_t.pmdnseq, #項次
          pmdn001 LIKE pmdn_t.pmdn001, #料件編號
          pmdn002 LIKE pmdn_t.pmdn002, #產品特徵
          pmdn003 LIKE pmdn_t.pmdn003, #包裝容器
          pmdn004 LIKE pmdn_t.pmdn004, #作業編號
          pmdn005 LIKE pmdn_t.pmdn005, #作業序
          pmdn006 LIKE pmdn_t.pmdn006, #採購單位
          pmdn007 LIKE pmdn_t.pmdn007, #採購數量
          pmdn008 LIKE pmdn_t.pmdn008, #參考單位
          pmdn009 LIKE pmdn_t.pmdn009, #參考數量
          pmdn010 LIKE pmdn_t.pmdn010, #計價單位
          pmdn011 LIKE pmdn_t.pmdn011, #計價數量
          pmdn012 LIKE pmdn_t.pmdn012, #出貨日期
          pmdn013 LIKE pmdn_t.pmdn013, #到廠日期
          pmdn014 LIKE pmdn_t.pmdn014, #到庫日期
          pmdn015 LIKE pmdn_t.pmdn015, #單價
          pmdn016 LIKE pmdn_t.pmdn016, #稅別
          pmdn017 LIKE pmdn_t.pmdn017, #稅率
          pmdn019 LIKE pmdn_t.pmdn019, #子件特性
          pmdn020 LIKE pmdn_t.pmdn020, #緊急度
          pmdn021 LIKE pmdn_t.pmdn021, #保稅
          pmdn022 LIKE pmdn_t.pmdn022, #部分交貨
          pmdnorga LIKE pmdn_t.pmdnorga, #付款據點
          pmdn023 LIKE pmdn_t.pmdn023, #送貨供應商
          pmdn024 LIKE pmdn_t.pmdn024, #多交期
          pmdn025 LIKE pmdn_t.pmdn025, #收貨地址編號
          pmdn026 LIKE pmdn_t.pmdn026, #帳款地址編號
          pmdn027 LIKE pmdn_t.pmdn027, #供應商料號
          pmdn028 LIKE pmdn_t.pmdn028, #收貨庫位
          pmdn029 LIKE pmdn_t.pmdn029, #收貨儲位
          pmdn030 LIKE pmdn_t.pmdn030, #收貨批號
          pmdn031 LIKE pmdn_t.pmdn031, #運輸方式
          pmdn032 LIKE pmdn_t.pmdn032, #取貨模式
          pmdn033 LIKE pmdn_t.pmdn033, #備品率
          pmdn034 LIKE pmdn_t.pmdn034, #no use
          pmdn035 LIKE pmdn_t.pmdn035, #價格核決
          pmdn036 LIKE pmdn_t.pmdn036, #專案編號
          pmdn037 LIKE pmdn_t.pmdn037, #WBS編號
          pmdn038 LIKE pmdn_t.pmdn038, #活動編號
          pmdn039 LIKE pmdn_t.pmdn039, #費用原因
          pmdn040 LIKE pmdn_t.pmdn040, #取價來源
          pmdn041 LIKE pmdn_t.pmdn041, #價格參考單號
          pmdn042 LIKE pmdn_t.pmdn042, #價格參考項次
          pmdn043 LIKE pmdn_t.pmdn043, #取出價格
          pmdn044 LIKE pmdn_t.pmdn044, #價差比
          pmdn045 LIKE pmdn_t.pmdn045, #行狀態
          pmdn046 LIKE pmdn_t.pmdn046, #未稅金額
          pmdn047 LIKE pmdn_t.pmdn047, #含稅金額
          pmdn048 LIKE pmdn_t.pmdn048, #稅額
          pmdn049 LIKE pmdn_t.pmdn049, #理由碼
          pmdn050 LIKE pmdn_t.pmdn050, #備註
          pmdn051 LIKE pmdn_t.pmdn051, #留置/結案理由碼
          pmdn052 LIKE pmdn_t.pmdn052, #檢驗否
          pmdn053 LIKE pmdn_t.pmdn053, #庫存管理特徵
          pmdn200 LIKE pmdn_t.pmdn200, #商品條碼
          pmdn201 LIKE pmdn_t.pmdn201, #包裝單位
          pmdn202 LIKE pmdn_t.pmdn202, #包裝數量
          pmdn203 LIKE pmdn_t.pmdn203, #收貨部門
          pmdn204 LIKE pmdn_t.pmdn204, #No Use
          pmdn205 LIKE pmdn_t.pmdn205, #要貨組織
          pmdn206 LIKE pmdn_t.pmdn206, #庫存量
          pmdn207 LIKE pmdn_t.pmdn207, #採購在途量
          pmdn208 LIKE pmdn_t.pmdn208, #前日銷售量
          pmdn209 LIKE pmdn_t.pmdn209, #上月銷量
          pmdn210 LIKE pmdn_t.pmdn210, #第一週銷量
          pmdn211 LIKE pmdn_t.pmdn211, #第二週銷量
          pmdn212 LIKE pmdn_t.pmdn212, #第三週銷量
          pmdn213 LIKE pmdn_t.pmdn213, #第四週銷量
          pmdn214 LIKE pmdn_t.pmdn214, #採購通路
          pmdn215 LIKE pmdn_t.pmdn215, #通路性質
          pmdn216 LIKE pmdn_t.pmdn216, #經營方式
          pmdn217 LIKE pmdn_t.pmdn217, #結算方式
          pmdn218 LIKE pmdn_t.pmdn218, #合約編號
          pmdn219 LIKE pmdn_t.pmdn219, #協議編號
          pmdn220 LIKE pmdn_t.pmdn220, #採購人員
          pmdn221 LIKE pmdn_t.pmdn221, #採購部門
          pmdn222 LIKE pmdn_t.pmdn222, #採購中心
          pmdn223 LIKE pmdn_t.pmdn223, #配送中心
          pmdn224 LIKE pmdn_t.pmdn224, #採購失效日
          pmdn900 LIKE pmdn_t.pmdn900, #保留欄位str
          pmdn999 LIKE pmdn_t.pmdn999, #保留欄位end
          #161109-00085#61 --s add
          pmdnud001 LIKE pmdn_t.pmdnud001, #自定義欄位(文字)001
          pmdnud002 LIKE pmdn_t.pmdnud002, #自定義欄位(文字)002
          pmdnud003 LIKE pmdn_t.pmdnud003, #自定義欄位(文字)003
          pmdnud004 LIKE pmdn_t.pmdnud004, #自定義欄位(文字)004
          pmdnud005 LIKE pmdn_t.pmdnud005, #自定義欄位(文字)005
          pmdnud006 LIKE pmdn_t.pmdnud006, #自定義欄位(文字)006
          pmdnud007 LIKE pmdn_t.pmdnud007, #自定義欄位(文字)007
          pmdnud008 LIKE pmdn_t.pmdnud008, #自定義欄位(文字)008
          pmdnud009 LIKE pmdn_t.pmdnud009, #自定義欄位(文字)009
          pmdnud010 LIKE pmdn_t.pmdnud010, #自定義欄位(文字)010
          pmdnud011 LIKE pmdn_t.pmdnud011, #自定義欄位(數字)011
          pmdnud012 LIKE pmdn_t.pmdnud012, #自定義欄位(數字)012
          pmdnud013 LIKE pmdn_t.pmdnud013, #自定義欄位(數字)013
          pmdnud014 LIKE pmdn_t.pmdnud014, #自定義欄位(數字)014
          pmdnud015 LIKE pmdn_t.pmdnud015, #自定義欄位(數字)015
          pmdnud016 LIKE pmdn_t.pmdnud016, #自定義欄位(數字)016
          pmdnud017 LIKE pmdn_t.pmdnud017, #自定義欄位(數字)017
          pmdnud018 LIKE pmdn_t.pmdnud018, #自定義欄位(數字)018
          pmdnud019 LIKE pmdn_t.pmdnud019, #自定義欄位(數字)019
          pmdnud020 LIKE pmdn_t.pmdnud020, #自定義欄位(數字)020
          pmdnud021 LIKE pmdn_t.pmdnud021, #自定義欄位(日期時間)021
          pmdnud022 LIKE pmdn_t.pmdnud022, #自定義欄位(日期時間)022
          pmdnud023 LIKE pmdn_t.pmdnud023, #自定義欄位(日期時間)023
          pmdnud024 LIKE pmdn_t.pmdnud024, #自定義欄位(日期時間)024
          pmdnud025 LIKE pmdn_t.pmdnud025, #自定義欄位(日期時間)025
          pmdnud026 LIKE pmdn_t.pmdnud026, #自定義欄位(日期時間)026
          pmdnud027 LIKE pmdn_t.pmdnud027, #自定義欄位(日期時間)027
          pmdnud028 LIKE pmdn_t.pmdnud028, #自定義欄位(日期時間)028
          pmdnud029 LIKE pmdn_t.pmdnud029, #自定義欄位(日期時間)029
          pmdnud030 LIKE pmdn_t.pmdnud030, #自定義欄位(日期時間)030
          #161109-00085#61 --e add
          pmdn225 LIKE pmdn_t.pmdn225, #最終收貨組織
          pmdn054 LIKE pmdn_t.pmdn054, #還料數量
          pmdn055 LIKE pmdn_t.pmdn055, #還量參考數量
          pmdn056 LIKE pmdn_t.pmdn056, #還價數量
          pmdn057 LIKE pmdn_t.pmdn057, #還價參考數量
          pmdn226 LIKE pmdn_t.pmdn226, #長效期每次送貨量
          pmdn227 LIKE pmdn_t.pmdn227, #補貨規格說明
          pmdn058 LIKE pmdn_t.pmdn058, #預算科目
          pmdn228 LIKE pmdn_t.pmdn228  #商品品類
   END RECORD   
   #mod--161109-00085#14 By 08993--(e)
   DEFINE l_pmdl004       LIKE pmdl_t.pmdl004 
   DEFINE l_pmdl025       LIKE pmdl_t.pmdl025
   DEFINE l_pmdl026       LIKE pmdl_t.pmdl026
   DEFINE l_pmdq005       LIKE pmdq_t.pmdq005
   DEFINE l_pmdq002       LIKE pmdq_t.pmdq002  
   DEFINE l_total_qty     LIKE pmdn_t.pmdn007     #採購總數量  
   DEFINE l_qty01         LIKE pmdq_t.pmdq002     #分批數量  
   
   WHENEVER ERROR CONTINUE 
   
   DELETE FROM p610_03_pmdq_t;

   LET l_sql = "SELECT pmdnseq,pmdn001,pmdn002,pmdn006,pmdn007,pmdn010, ",
               "       pmdn011,pmdn012,pmdn014,pmdn015,pmdl004, ",
               "       pmdl025,pmdl026, ",
               "       pmdn003, ",
               "       pmdn008,pmdn009,pmdn019,pmdn020,pmdn021,pmdn022, ",
               "       pmdn024,pmdn027,pmdn028,pmdn029,pmdn032,pmdn033, ",
               "       pmdn035,pmdn040,pmdn045,pmdn046,pmdn047,pmdn048, ",
               "       pmdn050,pmdnunit,pmdnorga ",
               "  FROM p610_tmp02 ",             #160727-00019#15 Mod   p610_03_pmdn_rel_t -->p610_tmp02
               " WHERE pmdn024 = 'Y' ",          #只要處理多交期的資料  
               " ORDER BY pmdl004,pmdnseq "
   PREPARE apsp610_03_ins_pmdq_prep1 FROM l_sql
   DECLARE apsp610_03_ins_pmdq_curs1 CURSOR WITH HOLD FOR apsp610_03_ins_pmdq_prep1

   INITIALIZE l_pmdn.* TO NULL
   FOREACH apsp610_03_ins_pmdq_curs1 INTO l_pmdn.pmdnseq,l_pmdn.pmdn001,l_pmdn.pmdn002,
                                          l_pmdn.pmdn006,l_pmdn.pmdn007,l_pmdn.pmdn010,
                                          l_pmdn.pmdn011,l_pmdn.pmdn012,l_pmdn.pmdn014,
                                          l_pmdn.pmdn015,l_pmdl004,
                                          l_pmdl025,l_pmdl026,
                                          l_pmdn.pmdn003,l_pmdn.pmdn008,l_pmdn.pmdn009,
                                          l_pmdn.pmdn019,l_pmdn.pmdn020,l_pmdn.pmdn021,
                                          l_pmdn.pmdn022,l_pmdn.pmdn024,l_pmdn.pmdn027,
                                          l_pmdn.pmdn028,l_pmdn.pmdn029,l_pmdn.pmdn032, 
                                          l_pmdn.pmdn033,l_pmdn.pmdn035,l_pmdn.pmdn040,
                                          l_pmdn.pmdn045,l_pmdn.pmdn046,l_pmdn.pmdn047,
                                          l_pmdn.pmdn048,l_pmdn.pmdn050,l_pmdn.pmdnunit,
                                          l_pmdn.pmdnorga
      IF STATUS THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = STATUS
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      LET l_sql = "SELECT pspc045,SUM(pmdp023) ",
                  "  FROM p610_tmp03 ",         #160727-00019#15 Mod   p610_03_pmdp_rel_t -->p610_tmp03
                  " WHERE pmdl004 = '",l_pmdl004,"' ", 
                  "   AND NVL(pmdl025,' ') = NVL('",l_pmdl025,"',' ') ",
                  "   AND NVL(pmdl026,' ') = NVL('",l_pmdl026,"',' ') ",
                  "   AND pmdp001 = '",l_pmdn.pmdn001,"' ",
                  "   AND NVL(pmdb050,' ') = NVL('",l_pmdn.pmdn050,"',' ') ",
                  " GROUP BY pspc045 ",
                  " ORDER BY pspc045 "
      PREPARE apsp610_03_ins_pmdq_prep2 FROM l_sql
      DECLARE apsp610_03_ins_pmdq_curs2 CURSOR WITH HOLD FOR apsp610_03_ins_pmdq_prep2

      LET l_total_qty = l_pmdn.pmdn007

      FOREACH apsp610_03_ins_pmdq_curs2 INTO l_pmdq005,l_qty01
         IF STATUS THEN
            INITIALIZE g_errparam TO NULL
         LET g_errparam.code = STATUS
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

            EXIT FOREACH
         END IF

         INITIALIZE l_pmdq.* TO NULL 
         
         #檢查數量是否有超過總數量，若有則不再產生多交期資料  
         IF l_total_qty <= l_qty01 THEN
            LET l_pmdq002   = l_total_qty
            LET l_total_qty = 0
         ELSE
            LET l_pmdq002   = l_qty01
            LET l_total_qty = l_total_qty - l_pmdq002
         END IF

         LET l_pmdq.pmdq005 = l_pmdq005
         LET l_pmdq.pmdq002 = l_pmdq002

         LET l_pmdq.pmdqent = g_enterprise
         LET l_pmdq.pmdqsite = g_site 
         LET l_pmdq.pmdqseq = l_pmdn.pmdnseq

         #分批序加1 
         SELECT MAX(pmdqseq2) + 1 INTO l_pmdq.pmdqseq2
           FROM p610_03_pmdq_t
          WHERE pmdl004 = l_pmdl004
            AND pmdqseq = l_pmdn.pmdnseq
         IF cl_null(l_pmdq.pmdqseq2) OR l_pmdq.pmdqseq2 = 0 THEN
            LET l_pmdq.pmdqseq2 = 1
         END IF

         #到庫日期後需自動計算到廠日期，公式為到庫日期-[T:料件據點進銷存檔].[C:到庫前置時間]
         #交貨日期後需自動計算交貨日期，公式為到廠日期-[T:料件據點進銷存檔].[C:到廠前置時間]
         CALL apsp610_03_date_count(l_pmdn.pmdn001,l_pmdq.pmdq005)
              RETURNING l_pmdq.pmdq004,l_pmdq.pmdq003

         LET l_pmdq.pmdq006 = ''
         LET l_pmdq.pmdq007 = 'N'

         INSERT INTO p610_03_pmdq_t(pmdqent,pmdqsite,pmdqseq,pmdqseq2,pmdq002,
                                    pmdq003,pmdq004,pmdq005,pmdq006,pmdq007,
                                    pmdl004,pmdl025,pmdl026)
                             VALUES(l_pmdq.pmdqent,l_pmdq.pmdqsite,l_pmdq.pmdqseq,
                                    l_pmdq.pmdqseq2,l_pmdq.pmdq002,l_pmdq.pmdq003,
                                    l_pmdq.pmdq004,l_pmdq.pmdq005,l_pmdq.pmdq006,
                                    l_pmdq.pmdq007,l_pmdl004,l_pmdl025,l_pmdl026)
         
         IF l_total_qty <= 0 THEN
            EXIT FOREACH
         END IF
      END FOREACH

   END FOREACH 

END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsp610_03_gen_pmdo()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_03_gen_pmdo()
   DEFINE l_sql      STRING
   #mod--161109-00085#14 By 08993--(s)
#   DEFINE l_pmdn      RECORD LIKE pmdn_t.*   #mark--161109-00085#14 By 08993--(s)
   DEFINE l_pmdn RECORD  #採購單身明細檔
          pmdnent LIKE pmdn_t.pmdnent, #企業編號
          pmdnsite LIKE pmdn_t.pmdnsite, #營運據點
          pmdnunit LIKE pmdn_t.pmdnunit, #應用組織
          pmdndocno LIKE pmdn_t.pmdndocno, #採購單號
          pmdnseq LIKE pmdn_t.pmdnseq, #項次
          pmdn001 LIKE pmdn_t.pmdn001, #料件編號
          pmdn002 LIKE pmdn_t.pmdn002, #產品特徵
          pmdn003 LIKE pmdn_t.pmdn003, #包裝容器
          pmdn004 LIKE pmdn_t.pmdn004, #作業編號
          pmdn005 LIKE pmdn_t.pmdn005, #作業序
          pmdn006 LIKE pmdn_t.pmdn006, #採購單位
          pmdn007 LIKE pmdn_t.pmdn007, #採購數量
          pmdn008 LIKE pmdn_t.pmdn008, #參考單位
          pmdn009 LIKE pmdn_t.pmdn009, #參考數量
          pmdn010 LIKE pmdn_t.pmdn010, #計價單位
          pmdn011 LIKE pmdn_t.pmdn011, #計價數量
          pmdn012 LIKE pmdn_t.pmdn012, #出貨日期
          pmdn013 LIKE pmdn_t.pmdn013, #到廠日期
          pmdn014 LIKE pmdn_t.pmdn014, #到庫日期
          pmdn015 LIKE pmdn_t.pmdn015, #單價
          pmdn016 LIKE pmdn_t.pmdn016, #稅別
          pmdn017 LIKE pmdn_t.pmdn017, #稅率
          pmdn019 LIKE pmdn_t.pmdn019, #子件特性
          pmdn020 LIKE pmdn_t.pmdn020, #緊急度
          pmdn021 LIKE pmdn_t.pmdn021, #保稅
          pmdn022 LIKE pmdn_t.pmdn022, #部分交貨
          pmdnorga LIKE pmdn_t.pmdnorga, #付款據點
          pmdn023 LIKE pmdn_t.pmdn023, #送貨供應商
          pmdn024 LIKE pmdn_t.pmdn024, #多交期
          pmdn025 LIKE pmdn_t.pmdn025, #收貨地址編號
          pmdn026 LIKE pmdn_t.pmdn026, #帳款地址編號
          pmdn027 LIKE pmdn_t.pmdn027, #供應商料號
          pmdn028 LIKE pmdn_t.pmdn028, #收貨庫位
          pmdn029 LIKE pmdn_t.pmdn029, #收貨儲位
          pmdn030 LIKE pmdn_t.pmdn030, #收貨批號
          pmdn031 LIKE pmdn_t.pmdn031, #運輸方式
          pmdn032 LIKE pmdn_t.pmdn032, #取貨模式
          pmdn033 LIKE pmdn_t.pmdn033, #備品率
          pmdn034 LIKE pmdn_t.pmdn034, #no use
          pmdn035 LIKE pmdn_t.pmdn035, #價格核決
          pmdn036 LIKE pmdn_t.pmdn036, #專案編號
          pmdn037 LIKE pmdn_t.pmdn037, #WBS編號
          pmdn038 LIKE pmdn_t.pmdn038, #活動編號
          pmdn039 LIKE pmdn_t.pmdn039, #費用原因
          pmdn040 LIKE pmdn_t.pmdn040, #取價來源
          pmdn041 LIKE pmdn_t.pmdn041, #價格參考單號
          pmdn042 LIKE pmdn_t.pmdn042, #價格參考項次
          pmdn043 LIKE pmdn_t.pmdn043, #取出價格
          pmdn044 LIKE pmdn_t.pmdn044, #價差比
          pmdn045 LIKE pmdn_t.pmdn045, #行狀態
          pmdn046 LIKE pmdn_t.pmdn046, #未稅金額
          pmdn047 LIKE pmdn_t.pmdn047, #含稅金額
          pmdn048 LIKE pmdn_t.pmdn048, #稅額
          pmdn049 LIKE pmdn_t.pmdn049, #理由碼
          pmdn050 LIKE pmdn_t.pmdn050, #備註
          pmdn051 LIKE pmdn_t.pmdn051, #留置/結案理由碼
          pmdn052 LIKE pmdn_t.pmdn052, #檢驗否
          pmdn053 LIKE pmdn_t.pmdn053, #庫存管理特徵
          pmdn200 LIKE pmdn_t.pmdn200, #商品條碼
          pmdn201 LIKE pmdn_t.pmdn201, #包裝單位
          pmdn202 LIKE pmdn_t.pmdn202, #包裝數量
          pmdn203 LIKE pmdn_t.pmdn203, #收貨部門
          pmdn204 LIKE pmdn_t.pmdn204, #No Use
          pmdn205 LIKE pmdn_t.pmdn205, #要貨組織
          pmdn206 LIKE pmdn_t.pmdn206, #庫存量
          pmdn207 LIKE pmdn_t.pmdn207, #採購在途量
          pmdn208 LIKE pmdn_t.pmdn208, #前日銷售量
          pmdn209 LIKE pmdn_t.pmdn209, #上月銷量
          pmdn210 LIKE pmdn_t.pmdn210, #第一週銷量
          pmdn211 LIKE pmdn_t.pmdn211, #第二週銷量
          pmdn212 LIKE pmdn_t.pmdn212, #第三週銷量
          pmdn213 LIKE pmdn_t.pmdn213, #第四週銷量
          pmdn214 LIKE pmdn_t.pmdn214, #採購通路
          pmdn215 LIKE pmdn_t.pmdn215, #通路性質
          pmdn216 LIKE pmdn_t.pmdn216, #經營方式
          pmdn217 LIKE pmdn_t.pmdn217, #結算方式
          pmdn218 LIKE pmdn_t.pmdn218, #合約編號
          pmdn219 LIKE pmdn_t.pmdn219, #協議編號
          pmdn220 LIKE pmdn_t.pmdn220, #採購人員
          pmdn221 LIKE pmdn_t.pmdn221, #採購部門
          pmdn222 LIKE pmdn_t.pmdn222, #採購中心
          pmdn223 LIKE pmdn_t.pmdn223, #配送中心
          pmdn224 LIKE pmdn_t.pmdn224, #採購失效日
          pmdn900 LIKE pmdn_t.pmdn900, #保留欄位str
          pmdn999 LIKE pmdn_t.pmdn999, #保留欄位end
          #161109-00085#61 --s add
          pmdnud001 LIKE pmdn_t.pmdnud001, #自定義欄位(文字)001
          pmdnud002 LIKE pmdn_t.pmdnud002, #自定義欄位(文字)002
          pmdnud003 LIKE pmdn_t.pmdnud003, #自定義欄位(文字)003
          pmdnud004 LIKE pmdn_t.pmdnud004, #自定義欄位(文字)004
          pmdnud005 LIKE pmdn_t.pmdnud005, #自定義欄位(文字)005
          pmdnud006 LIKE pmdn_t.pmdnud006, #自定義欄位(文字)006
          pmdnud007 LIKE pmdn_t.pmdnud007, #自定義欄位(文字)007
          pmdnud008 LIKE pmdn_t.pmdnud008, #自定義欄位(文字)008
          pmdnud009 LIKE pmdn_t.pmdnud009, #自定義欄位(文字)009
          pmdnud010 LIKE pmdn_t.pmdnud010, #自定義欄位(文字)010
          pmdnud011 LIKE pmdn_t.pmdnud011, #自定義欄位(數字)011
          pmdnud012 LIKE pmdn_t.pmdnud012, #自定義欄位(數字)012
          pmdnud013 LIKE pmdn_t.pmdnud013, #自定義欄位(數字)013
          pmdnud014 LIKE pmdn_t.pmdnud014, #自定義欄位(數字)014
          pmdnud015 LIKE pmdn_t.pmdnud015, #自定義欄位(數字)015
          pmdnud016 LIKE pmdn_t.pmdnud016, #自定義欄位(數字)016
          pmdnud017 LIKE pmdn_t.pmdnud017, #自定義欄位(數字)017
          pmdnud018 LIKE pmdn_t.pmdnud018, #自定義欄位(數字)018
          pmdnud019 LIKE pmdn_t.pmdnud019, #自定義欄位(數字)019
          pmdnud020 LIKE pmdn_t.pmdnud020, #自定義欄位(數字)020
          pmdnud021 LIKE pmdn_t.pmdnud021, #自定義欄位(日期時間)021
          pmdnud022 LIKE pmdn_t.pmdnud022, #自定義欄位(日期時間)022
          pmdnud023 LIKE pmdn_t.pmdnud023, #自定義欄位(日期時間)023
          pmdnud024 LIKE pmdn_t.pmdnud024, #自定義欄位(日期時間)024
          pmdnud025 LIKE pmdn_t.pmdnud025, #自定義欄位(日期時間)025
          pmdnud026 LIKE pmdn_t.pmdnud026, #自定義欄位(日期時間)026
          pmdnud027 LIKE pmdn_t.pmdnud027, #自定義欄位(日期時間)027
          pmdnud028 LIKE pmdn_t.pmdnud028, #自定義欄位(日期時間)028
          pmdnud029 LIKE pmdn_t.pmdnud029, #自定義欄位(日期時間)029
          pmdnud030 LIKE pmdn_t.pmdnud030, #自定義欄位(日期時間)030
          #161109-00085#61 --e add
          pmdn225 LIKE pmdn_t.pmdn225, #最終收貨組織
          pmdn054 LIKE pmdn_t.pmdn054, #還料數量
          pmdn055 LIKE pmdn_t.pmdn055, #還量參考數量
          pmdn056 LIKE pmdn_t.pmdn056, #還價數量
          pmdn057 LIKE pmdn_t.pmdn057, #還價參考數量
          pmdn226 LIKE pmdn_t.pmdn226, #長效期每次送貨量
          pmdn227 LIKE pmdn_t.pmdn227, #補貨規格說明
          pmdn058 LIKE pmdn_t.pmdn058, #預算科目
          pmdn228 LIKE pmdn_t.pmdn228  #商品品類
   END RECORD
   #mod--161109-00085#14 By 08993--(e)  
   DEFINE l_pmdl004  LIKE pmdl_t.pmdl004 
   DEFINE l_pmdl025  LIKE pmdl_t.pmdl025
   DEFINE l_pmdl026  LIKE pmdl_t.pmdl026
   
   WHENEVER ERROR CONTINUE 

   DELETE FROM p610_03_pmdo_t;

   LET l_sql = "SELECT pmdnseq,pmdn001,pmdn002,pmdn006,pmdn007,pmdn010,pmdn011, ",
               "       pmdn012,pmdn013,pmdn014,pmdn015,pmdn003,pmdn008,pmdn009, ",
               "       pmdn019,pmdn020,pmdn021,pmdn022,pmdn024,pmdn027,pmdn028, ",
               "       pmdn029,pmdn032,pmdn033,pmdn035,pmdn040,pmdn045,pmdn046, ",
               "       pmdn047,pmdn048,pmdn050,pmdnunit,pmdnorga,pmdl004, ",
               "       pmdl025,pmdl026 ",
               "  FROM p610_tmp02 ",           #160727-00019#15 Mod   p610_03_pmdn_rel_t -->p610_tmp02
               " ORDER BY pmdl004,pmdnseq "
   PREPARE apsp610_03_gen_pmdo_from_pmdn_prep FROM l_sql
   DECLARE apsp610_03_gen_pmdo_from_pmdn_curs CURSOR FOR apsp610_03_gen_pmdo_from_pmdn_prep

   FOREACH apsp610_03_gen_pmdo_from_pmdn_curs INTO l_pmdn.pmdnseq,l_pmdn.pmdn001,l_pmdn.pmdn002,
                                                   l_pmdn.pmdn006,l_pmdn.pmdn007,l_pmdn.pmdn010,
                                                   l_pmdn.pmdn011,l_pmdn.pmdn012,l_pmdn.pmdn013,
                                                   l_pmdn.pmdn014,l_pmdn.pmdn015,l_pmdn.pmdn003,
                                                   l_pmdn.pmdn008,l_pmdn.pmdn009,l_pmdn.pmdn019,
                                                   l_pmdn.pmdn020,l_pmdn.pmdn021,l_pmdn.pmdn022,
                                                   l_pmdn.pmdn024,l_pmdn.pmdn027,l_pmdn.pmdn028,
                                                   l_pmdn.pmdn029,l_pmdn.pmdn032,l_pmdn.pmdn033,
                                                   l_pmdn.pmdn035,l_pmdn.pmdn040,l_pmdn.pmdn045,
                                                   l_pmdn.pmdn046,l_pmdn.pmdn047,l_pmdn.pmdn048, 
                                                   l_pmdn.pmdn050,
                                                   l_pmdn.pmdnunit,l_pmdn.pmdnorga,l_pmdl004, 
                                                   l_pmdl025,l_pmdl026
      IF STATUS THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.code   = STATUS
         LET g_errparam.popup  = TRUE
         CALL cl_err()
 
         EXIT FOREACH
      END IF

      #判斷若子件特性為'2:CKD'時需依據採購單號料展BOM取得最底階原物料清單與組成用量

      #判斷若子件特性為'3:SKD'時需開窗詢問展BOM階數，依據採購單號料與展階接數展BOM取得該階的半成品清單與組成用量

      #判斷若該採購單明細是未勾選多交期    
      IF l_pmdn.pmdn024 = 'N' THEN
         #若子件特性不是'2:CKD'或是'3:SKD'時，則直接依據採購單明細(pmdn_t)產生一筆交期明細資料
         IF l_pmdn.pmdn019 NOT MATCHES '[23]' THEN
            CALL apsp610_03_ins_pmdo_1(l_pmdn.*,l_pmdl004,l_pmdl025,l_pmdl026)
         END IF

         #若子件特性為'2:CKD'或是'3SKD'時則需依據取得的物料清單產生多筆的交期明細資料(pmdn_t) 產生一筆交期明細資料
         IF l_pmdn.pmdn019 MATCHES '[23]' THEN
            #取原物料清單和半成品清單FUNCTION還未完成
            #CALL apsp610_03_ins_pmdo_2(l_pmdn.*,l_pmdl004) 
         END IF
      END IF

      #判斷若該採購單明細是勾選多交期
      IF l_pmdn.pmdn024 = 'Y' THEN
         #若子件特性不是'2:CKD'或是'3:SKD'時，則子件特性不是'2:CKD'或是'3:SKD'時，則需依據交期匯總明細(pmdq_t)產生多筆交期明細資料
         IF l_pmdn.pmdn019 NOT MATCHES '[23]' THEN
            CALL apsp610_03_ins_pmdo_3(l_pmdn.*,l_pmdl004,l_pmdl025,l_pmdl026)
         END IF
         #若子件特性為'2:CKD'或是'3SKD'時 
         #則需依據取得的物料清單再搭配交期匯總明細(pmdq_t)產生多筆的交期明細資料(pmdn_t)產生多筆交期明細資料
         IF l_pmdn.pmdn019 MATCHES '[23]' THEN 
            #CALL apsp610_03_ins_pmdo_4(l_pmdn.*,l_pmdl004) 
         END IF

      END IF

   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsp610_03_ins_pmdo_1(p_pmdn,p_pmdl004)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_03_ins_pmdo_1(p_pmdn,p_pmdl004,p_pmdl025,p_pmdl026)

   #mod--161109-00085#14 By 08993--(s)
#   DEFINE p_pmdn      RECORD LIKE pmdn_t.*   #mark--161109-00085#14 By 08993--(s)
   DEFINE p_pmdn RECORD  #採購單身明細檔
          pmdnent LIKE pmdn_t.pmdnent, #企業編號
          pmdnsite LIKE pmdn_t.pmdnsite, #營運據點
          pmdnunit LIKE pmdn_t.pmdnunit, #應用組織
          pmdndocno LIKE pmdn_t.pmdndocno, #採購單號
          pmdnseq LIKE pmdn_t.pmdnseq, #項次
          pmdn001 LIKE pmdn_t.pmdn001, #料件編號
          pmdn002 LIKE pmdn_t.pmdn002, #產品特徵
          pmdn003 LIKE pmdn_t.pmdn003, #包裝容器
          pmdn004 LIKE pmdn_t.pmdn004, #作業編號
          pmdn005 LIKE pmdn_t.pmdn005, #作業序
          pmdn006 LIKE pmdn_t.pmdn006, #採購單位
          pmdn007 LIKE pmdn_t.pmdn007, #採購數量
          pmdn008 LIKE pmdn_t.pmdn008, #參考單位
          pmdn009 LIKE pmdn_t.pmdn009, #參考數量
          pmdn010 LIKE pmdn_t.pmdn010, #計價單位
          pmdn011 LIKE pmdn_t.pmdn011, #計價數量
          pmdn012 LIKE pmdn_t.pmdn012, #出貨日期
          pmdn013 LIKE pmdn_t.pmdn013, #到廠日期
          pmdn014 LIKE pmdn_t.pmdn014, #到庫日期
          pmdn015 LIKE pmdn_t.pmdn015, #單價
          pmdn016 LIKE pmdn_t.pmdn016, #稅別
          pmdn017 LIKE pmdn_t.pmdn017, #稅率
          pmdn019 LIKE pmdn_t.pmdn019, #子件特性
          pmdn020 LIKE pmdn_t.pmdn020, #緊急度
          pmdn021 LIKE pmdn_t.pmdn021, #保稅
          pmdn022 LIKE pmdn_t.pmdn022, #部分交貨
          pmdnorga LIKE pmdn_t.pmdnorga, #付款據點
          pmdn023 LIKE pmdn_t.pmdn023, #送貨供應商
          pmdn024 LIKE pmdn_t.pmdn024, #多交期
          pmdn025 LIKE pmdn_t.pmdn025, #收貨地址編號
          pmdn026 LIKE pmdn_t.pmdn026, #帳款地址編號
          pmdn027 LIKE pmdn_t.pmdn027, #供應商料號
          pmdn028 LIKE pmdn_t.pmdn028, #收貨庫位
          pmdn029 LIKE pmdn_t.pmdn029, #收貨儲位
          pmdn030 LIKE pmdn_t.pmdn030, #收貨批號
          pmdn031 LIKE pmdn_t.pmdn031, #運輸方式
          pmdn032 LIKE pmdn_t.pmdn032, #取貨模式
          pmdn033 LIKE pmdn_t.pmdn033, #備品率
          pmdn034 LIKE pmdn_t.pmdn034, #no use
          pmdn035 LIKE pmdn_t.pmdn035, #價格核決
          pmdn036 LIKE pmdn_t.pmdn036, #專案編號
          pmdn037 LIKE pmdn_t.pmdn037, #WBS編號
          pmdn038 LIKE pmdn_t.pmdn038, #活動編號
          pmdn039 LIKE pmdn_t.pmdn039, #費用原因
          pmdn040 LIKE pmdn_t.pmdn040, #取價來源
          pmdn041 LIKE pmdn_t.pmdn041, #價格參考單號
          pmdn042 LIKE pmdn_t.pmdn042, #價格參考項次
          pmdn043 LIKE pmdn_t.pmdn043, #取出價格
          pmdn044 LIKE pmdn_t.pmdn044, #價差比
          pmdn045 LIKE pmdn_t.pmdn045, #行狀態
          pmdn046 LIKE pmdn_t.pmdn046, #未稅金額
          pmdn047 LIKE pmdn_t.pmdn047, #含稅金額
          pmdn048 LIKE pmdn_t.pmdn048, #稅額
          pmdn049 LIKE pmdn_t.pmdn049, #理由碼
          pmdn050 LIKE pmdn_t.pmdn050, #備註
          pmdn051 LIKE pmdn_t.pmdn051, #留置/結案理由碼
          pmdn052 LIKE pmdn_t.pmdn052, #檢驗否
          pmdn053 LIKE pmdn_t.pmdn053, #庫存管理特徵
          pmdn200 LIKE pmdn_t.pmdn200, #商品條碼
          pmdn201 LIKE pmdn_t.pmdn201, #包裝單位
          pmdn202 LIKE pmdn_t.pmdn202, #包裝數量
          pmdn203 LIKE pmdn_t.pmdn203, #收貨部門
          pmdn204 LIKE pmdn_t.pmdn204, #No Use
          pmdn205 LIKE pmdn_t.pmdn205, #要貨組織
          pmdn206 LIKE pmdn_t.pmdn206, #庫存量
          pmdn207 LIKE pmdn_t.pmdn207, #採購在途量
          pmdn208 LIKE pmdn_t.pmdn208, #前日銷售量
          pmdn209 LIKE pmdn_t.pmdn209, #上月銷量
          pmdn210 LIKE pmdn_t.pmdn210, #第一週銷量
          pmdn211 LIKE pmdn_t.pmdn211, #第二週銷量
          pmdn212 LIKE pmdn_t.pmdn212, #第三週銷量
          pmdn213 LIKE pmdn_t.pmdn213, #第四週銷量
          pmdn214 LIKE pmdn_t.pmdn214, #採購通路
          pmdn215 LIKE pmdn_t.pmdn215, #通路性質
          pmdn216 LIKE pmdn_t.pmdn216, #經營方式
          pmdn217 LIKE pmdn_t.pmdn217, #結算方式
          pmdn218 LIKE pmdn_t.pmdn218, #合約編號
          pmdn219 LIKE pmdn_t.pmdn219, #協議編號
          pmdn220 LIKE pmdn_t.pmdn220, #採購人員
          pmdn221 LIKE pmdn_t.pmdn221, #採購部門
          pmdn222 LIKE pmdn_t.pmdn222, #採購中心
          pmdn223 LIKE pmdn_t.pmdn223, #配送中心
          pmdn224 LIKE pmdn_t.pmdn224, #採購失效日
          pmdn900 LIKE pmdn_t.pmdn900, #保留欄位str
          pmdn999 LIKE pmdn_t.pmdn999, #保留欄位end
          #161109-00085#61 --s add
          pmdnud001 LIKE pmdn_t.pmdnud001, #自定義欄位(文字)001
          pmdnud002 LIKE pmdn_t.pmdnud002, #自定義欄位(文字)002
          pmdnud003 LIKE pmdn_t.pmdnud003, #自定義欄位(文字)003
          pmdnud004 LIKE pmdn_t.pmdnud004, #自定義欄位(文字)004
          pmdnud005 LIKE pmdn_t.pmdnud005, #自定義欄位(文字)005
          pmdnud006 LIKE pmdn_t.pmdnud006, #自定義欄位(文字)006
          pmdnud007 LIKE pmdn_t.pmdnud007, #自定義欄位(文字)007
          pmdnud008 LIKE pmdn_t.pmdnud008, #自定義欄位(文字)008
          pmdnud009 LIKE pmdn_t.pmdnud009, #自定義欄位(文字)009
          pmdnud010 LIKE pmdn_t.pmdnud010, #自定義欄位(文字)010
          pmdnud011 LIKE pmdn_t.pmdnud011, #自定義欄位(數字)011
          pmdnud012 LIKE pmdn_t.pmdnud012, #自定義欄位(數字)012
          pmdnud013 LIKE pmdn_t.pmdnud013, #自定義欄位(數字)013
          pmdnud014 LIKE pmdn_t.pmdnud014, #自定義欄位(數字)014
          pmdnud015 LIKE pmdn_t.pmdnud015, #自定義欄位(數字)015
          pmdnud016 LIKE pmdn_t.pmdnud016, #自定義欄位(數字)016
          pmdnud017 LIKE pmdn_t.pmdnud017, #自定義欄位(數字)017
          pmdnud018 LIKE pmdn_t.pmdnud018, #自定義欄位(數字)018
          pmdnud019 LIKE pmdn_t.pmdnud019, #自定義欄位(數字)019
          pmdnud020 LIKE pmdn_t.pmdnud020, #自定義欄位(數字)020
          pmdnud021 LIKE pmdn_t.pmdnud021, #自定義欄位(日期時間)021
          pmdnud022 LIKE pmdn_t.pmdnud022, #自定義欄位(日期時間)022
          pmdnud023 LIKE pmdn_t.pmdnud023, #自定義欄位(日期時間)023
          pmdnud024 LIKE pmdn_t.pmdnud024, #自定義欄位(日期時間)024
          pmdnud025 LIKE pmdn_t.pmdnud025, #自定義欄位(日期時間)025
          pmdnud026 LIKE pmdn_t.pmdnud026, #自定義欄位(日期時間)026
          pmdnud027 LIKE pmdn_t.pmdnud027, #自定義欄位(日期時間)027
          pmdnud028 LIKE pmdn_t.pmdnud028, #自定義欄位(日期時間)028
          pmdnud029 LIKE pmdn_t.pmdnud029, #自定義欄位(日期時間)029
          pmdnud030 LIKE pmdn_t.pmdnud030, #自定義欄位(日期時間)030
          #161109-00085#61 --e add
          pmdn225 LIKE pmdn_t.pmdn225, #最終收貨組織
          pmdn054 LIKE pmdn_t.pmdn054, #還料數量
          pmdn055 LIKE pmdn_t.pmdn055, #還量參考數量
          pmdn056 LIKE pmdn_t.pmdn056, #還價數量
          pmdn057 LIKE pmdn_t.pmdn057, #還價參考數量
          pmdn226 LIKE pmdn_t.pmdn226, #長效期每次送貨量
          pmdn227 LIKE pmdn_t.pmdn227, #補貨規格說明
          pmdn058 LIKE pmdn_t.pmdn058, #預算科目
          pmdn228 LIKE pmdn_t.pmdn228  #商品品類
   END RECORD
   #mod--161109-00085#14 By 08993--(e)  
   DEFINE p_pmdl004  LIKE pmdl_t.pmdl004 
   DEFINE p_pmdl025  LIKE pmdl_t.pmdl025
   DEFINE p_pmdl026  LIKE pmdl_t.pmdl026
   #mod--161109-00085#14 By 08993--(s)
#   DEFINE l_pmdo      RECORD LIKE pmdo_t.*   #mark--161109-00085#14 By 08993--(s)
   DEFINE l_pmdo RECORD  #採購交期明細檔
          pmdoent LIKE pmdo_t.pmdoent, #企業編號
          pmdosite LIKE pmdo_t.pmdosite, #營運據點
          pmdodocno LIKE pmdo_t.pmdodocno, #採購單號
          pmdoseq LIKE pmdo_t.pmdoseq, #採購項次
          pmdoseq1 LIKE pmdo_t.pmdoseq1, #項序
          pmdoseq2 LIKE pmdo_t.pmdoseq2, #分批序
          pmdo001 LIKE pmdo_t.pmdo001, #料件編號
          pmdo002 LIKE pmdo_t.pmdo002, #產品特徵
          pmdo003 LIKE pmdo_t.pmdo003, #子件特性
          pmdo004 LIKE pmdo_t.pmdo004, #採購單位
          pmdo005 LIKE pmdo_t.pmdo005, #採購總數量
          pmdo006 LIKE pmdo_t.pmdo006, #分批採購數量
          pmdo007 LIKE pmdo_t.pmdo007, #摺合主件數量
          pmdo008 LIKE pmdo_t.pmdo008, #QPA
          pmdo009 LIKE pmdo_t.pmdo009, #交期類型
          pmdo010 LIKE pmdo_t.pmdo010, #收貨時段
          pmdo011 LIKE pmdo_t.pmdo011, #出貨日期
          pmdo012 LIKE pmdo_t.pmdo012, #到廠日期
          pmdo013 LIKE pmdo_t.pmdo013, #到庫日期
          pmdo014 LIKE pmdo_t.pmdo014, #MRP交期凍結
          pmdo015 LIKE pmdo_t.pmdo015, #已收貨量
          pmdo016 LIKE pmdo_t.pmdo016, #驗退量
          pmdo017 LIKE pmdo_t.pmdo017, #倉退換貨量
          pmdo019 LIKE pmdo_t.pmdo019, #已入庫量
          pmdo020 LIKE pmdo_t.pmdo020, #VMI請款量
          pmdo021 LIKE pmdo_t.pmdo021, #交貨狀態
          pmdo022 LIKE pmdo_t.pmdo022, #參考價格
          pmdo023 LIKE pmdo_t.pmdo023, #稅別
          pmdo024 LIKE pmdo_t.pmdo024, #稅率
          pmdo025 LIKE pmdo_t.pmdo025, #電子採購單號
          pmdo026 LIKE pmdo_t.pmdo026, #最近修改人員
          pmdo027 LIKE pmdo_t.pmdo027, #最近修改時間
          pmdo028 LIKE pmdo_t.pmdo028, #分批參考單位
          pmdo029 LIKE pmdo_t.pmdo029, #分批參考數量
          pmdo030 LIKE pmdo_t.pmdo030, #分批計價單位
          pmdo031 LIKE pmdo_t.pmdo031, #分批計價數量
          pmdo032 LIKE pmdo_t.pmdo032, #分批未稅金額
          pmdo033 LIKE pmdo_t.pmdo033, #分批含稅金額
          pmdo034 LIKE pmdo_t.pmdo034, #分批稅額
          pmdo035 LIKE pmdo_t.pmdo035, #初始營運據點
          pmdo036 LIKE pmdo_t.pmdo036, #初始來源單號
          pmdo037 LIKE pmdo_t.pmdo037, #初始來源項次
          pmdo038 LIKE pmdo_t.pmdo038, #初始項序
          pmdo039 LIKE pmdo_t.pmdo039, #初始分批序
          pmdo040 LIKE pmdo_t.pmdo040, #倉退量
          pmdo200 LIKE pmdo_t.pmdo200, #分批包裝單位
          pmdo201 LIKE pmdo_t.pmdo201, #分批包裝數量
          pmdo900 LIKE pmdo_t.pmdo900, #保留欄位str
          pmdo999 LIKE pmdo_t.pmdo999, #保留欄位end
          #161109-00085#61 --s add
          pmdoud001 LIKE pmdo_t.pmdoud001, #自定義欄位(文字)001
          pmdoud002 LIKE pmdo_t.pmdoud002, #自定義欄位(文字)002
          pmdoud003 LIKE pmdo_t.pmdoud003, #自定義欄位(文字)003
          pmdoud004 LIKE pmdo_t.pmdoud004, #自定義欄位(文字)004
          pmdoud005 LIKE pmdo_t.pmdoud005, #自定義欄位(文字)005
          pmdoud006 LIKE pmdo_t.pmdoud006, #自定義欄位(文字)006
          pmdoud007 LIKE pmdo_t.pmdoud007, #自定義欄位(文字)007
          pmdoud008 LIKE pmdo_t.pmdoud008, #自定義欄位(文字)008
          pmdoud009 LIKE pmdo_t.pmdoud009, #自定義欄位(文字)009
          pmdoud010 LIKE pmdo_t.pmdoud010, #自定義欄位(文字)010
          pmdoud011 LIKE pmdo_t.pmdoud011, #自定義欄位(數字)011
          pmdoud012 LIKE pmdo_t.pmdoud012, #自定義欄位(數字)012
          pmdoud013 LIKE pmdo_t.pmdoud013, #自定義欄位(數字)013
          pmdoud014 LIKE pmdo_t.pmdoud014, #自定義欄位(數字)014
          pmdoud015 LIKE pmdo_t.pmdoud015, #自定義欄位(數字)015
          pmdoud016 LIKE pmdo_t.pmdoud016, #自定義欄位(數字)016
          pmdoud017 LIKE pmdo_t.pmdoud017, #自定義欄位(數字)017
          pmdoud018 LIKE pmdo_t.pmdoud018, #自定義欄位(數字)018
          pmdoud019 LIKE pmdo_t.pmdoud019, #自定義欄位(數字)019
          pmdoud020 LIKE pmdo_t.pmdoud020, #自定義欄位(數字)020
          pmdoud021 LIKE pmdo_t.pmdoud021, #自定義欄位(日期時間)021
          pmdoud022 LIKE pmdo_t.pmdoud022, #自定義欄位(日期時間)022
          pmdoud023 LIKE pmdo_t.pmdoud023, #自定義欄位(日期時間)023
          pmdoud024 LIKE pmdo_t.pmdoud024, #自定義欄位(日期時間)024
          pmdoud025 LIKE pmdo_t.pmdoud025, #自定義欄位(日期時間)025
          pmdoud026 LIKE pmdo_t.pmdoud026, #自定義欄位(日期時間)026
          pmdoud027 LIKE pmdo_t.pmdoud027, #自定義欄位(日期時間)027
          pmdoud028 LIKE pmdo_t.pmdoud028, #自定義欄位(日期時間)028
          pmdoud029 LIKE pmdo_t.pmdoud029, #自定義欄位(日期時間)029
          pmdoud030 LIKE pmdo_t.pmdoud030, #自定義欄位(日期時間)030
          #161109-00085#61 --e add
          pmdo041 LIKE pmdo_t.pmdo041, #還料數量
          pmdo042 LIKE pmdo_t.pmdo042, #還量參考數量
          pmdo043 LIKE pmdo_t.pmdo043, #還價數量
          pmdo044 LIKE pmdo_t.pmdo044  #還價參考數量
   END RECORD
   #mod--161109-00085#14 By 08993--(e)   
   WHENEVER ERROR CONTINUE 

   INITIALIZE l_pmdo.* TO NULL

   LET l_pmdo.pmdoent = g_enterprise
   LET l_pmdo.pmdosite = g_site
   LET l_pmdo.pmdoseq = p_pmdn.pmdnseq

   SELECT MAX(pmdoseq1) + 1 INTO l_pmdo.pmdoseq1
     FROM p610_03_pmdo_t
    WHERE pmdoent = g_enterprise
      AND pmdl004 = p_pmdl004 
      AND NVL(pmdl025,' ') = NVL(p_pmdl025,' ')
      AND NVL(pmdl026,' ') = NVL(p_pmdl026,' ')
      AND pmdoseq = l_pmdo.pmdoseq
   IF cl_null(l_pmdo.pmdoseq1) OR l_pmdo.pmdoseq1 = 0 THEN
      LET l_pmdo.pmdoseq1 = 1
   END IF

   LET l_pmdo.pmdoseq2 = 1              #分批序
   LET l_pmdo.pmdo001 = p_pmdn.pmdn001  #料件編號
   LET l_pmdo.pmdo002 = p_pmdn.pmdn002  #產品特徵
   LET l_pmdo.pmdo003 = p_pmdn.pmdn019  #子件特性
   LET l_pmdo.pmdo004 = p_pmdn.pmdn006  #採購單位
   LET l_pmdo.pmdo005 = p_pmdn.pmdn007  #採購總量
   LET l_pmdo.pmdo006 = p_pmdn.pmdn007  #分批採購量
   LET l_pmdo.pmdo007 = p_pmdn.pmdn007  #折核主件數量
   LET l_pmdo.pmdo008 = 1               #QPA
   LET l_pmdo.pmdo009 = '1'             #交期類型 
   LET l_pmdo.pmdo010 = ''              #出貨時段
   LET l_pmdo.pmdo011 = p_pmdn.pmdn012  #出貨日期
   LET l_pmdo.pmdo012 = p_pmdn.pmdn013  #到廠日期
   LET l_pmdo.pmdo013 = p_pmdn.pmdn014  #到庫日期
   LET l_pmdo.pmdo014 = 'N'             #MRP凍結否
   LET l_pmdo.pmdo015 = 0               #已收貨量
   LET l_pmdo.pmdo016 = 0               #驗退量
   LET l_pmdo.pmdo017 = 0               #倉退換貨量 
   LET l_pmdo.pmdo019 = 0               #已入庫量
   LET l_pmdo.pmdo020 = 0               #VMI請款量
   LET l_pmdo.pmdo021 = '2'             #出貨狀態
   LET l_pmdo.pmdo022 = p_pmdn.pmdn015  #參考價格
   LET l_pmdo.pmdo023 = p_pmdn.pmdn016  #稅別(#呼叫應取稅別應用元件取得該品項的稅別與稅率)
   LET l_pmdo.pmdo024 = p_pmdn.pmdn017  #稅率(#呼叫應取稅別應用元件取得該品項的稅別與稅率)
   LET l_pmdo.pmdo025 = ''
   LET l_pmdo.pmdo026 = g_user          #最近修改人員
   LET l_pmdo.pmdo027 = g_today         #最近修改日
   LET l_pmdo.pmdo028 = p_pmdn.pmdn008  #分批參考單位
   LET l_pmdo.pmdo029 = p_pmdn.pmdn009  #分批參考數量
   LET l_pmdo.pmdo030 = p_pmdn.pmdn010  #計價單位
   LET l_pmdo.pmdo031 = p_pmdn.pmdn011  #計價數量
   LET l_pmdo.pmdo032 = p_pmdn.pmdn046  #分批未稅金額(呼叫計算含未稅金額應用元件計算取得) 
   LET l_pmdo.pmdo033 = p_pmdn.pmdn047  #分批含稅金額(呼叫計算含未稅金額應用元件計算取得)
   LET l_pmdo.pmdo034 = p_pmdn.pmdn048  #分批稅金額(呼叫計算含未稅金額應用元件計算取得)

   INSERT INTO p610_03_pmdo_t(pmdoent,pmdoseq,pmdoseq1,pmdoseq2,pmdosite,pmdo001,pmdo002,
                              pmdo003,pmdo004,pmdo005,pmdo006,pmdo007,pmdo008,pmdo009,
                              pmdo010,pmdo011,pmdo012,pmdo013,pmdo014,pmdo015,pmdo016,
                              pmdo017,pmdo019,pmdo020,pmdo021,pmdo022,pmdo023,pmdo024,
                              pmdo025,pmdo026,pmdo027,pmdo028,pmdo029,pmdo030,pmdo031,
                              pmdo032,pmdo033,pmdo034,pmdl004,pmdl025,pmdl026)
                       VALUES(l_pmdo.pmdoent,l_pmdo.pmdoseq,l_pmdo.pmdoseq1,l_pmdo.pmdoseq2,
                              l_pmdo.pmdosite,l_pmdo.pmdo001,l_pmdo.pmdo002,l_pmdo.pmdo003,
                              l_pmdo.pmdo004,l_pmdo.pmdo005,l_pmdo.pmdo006,l_pmdo.pmdo007,
                              l_pmdo.pmdo008,l_pmdo.pmdo009,l_pmdo.pmdo010,l_pmdo.pmdo011,
                              l_pmdo.pmdo012,l_pmdo.pmdo013,l_pmdo.pmdo014,l_pmdo.pmdo015,
                              l_pmdo.pmdo016,l_pmdo.pmdo017,l_pmdo.pmdo019,l_pmdo.pmdo020,
                              l_pmdo.pmdo021,l_pmdo.pmdo022,l_pmdo.pmdo023,l_pmdo.pmdo024,
                              l_pmdo.pmdo025,l_pmdo.pmdo026,l_pmdo.pmdo027,l_pmdo.pmdo028,
                              l_pmdo.pmdo029,l_pmdo.pmdo030,l_pmdo.pmdo031,l_pmdo.pmdo032,
                              l_pmdo.pmdo033,l_pmdo.pmdo034,p_pmdl004,p_pmdl025,p_pmdl026)

   #若該採購單明細有設置備品率時，應自動在產生一筆備品的交期明細資料
   IF NOT cl_null(p_pmdn.pmdn033) AND p_pmdn.pmdn033 <> 0 THEN
      SELECT MAX(pmdoseq1)+1 INTO l_pmdo.pmdoseq1
        FROM p610_03_pmdo_t
       WHERE pmdoent = g_enterprise
         AND pmdl004 = p_pmdl004
         AND pmdoseq = l_pmdo.pmdoseq
      IF cl_null(l_pmdo.pmdoseq1) OR l_pmdo.pmdoseq1 = 0 THEN
         LET l_pmdo.pmdoseq1 = 1
      END IF

      LET l_pmdo.pmdo003 = '6'        #子件特性
      LET l_pmdo.pmdo005 = p_pmdn.pmdn007 * (p_pmdn.pmdn033/100)  #採購總量
      LET l_pmdo.pmdo006 = p_pmdn.pmdn007 * (p_pmdn.pmdn033/100)  #分批採購量
      LET l_pmdo.pmdo022 = 0          #參考價格
      LET l_pmdo.pmdo032 = 0          #分批未稅金額 
      LET l_pmdo.pmdo033 = 0          #分批含稅金額
      LET l_pmdo.pmdo034 = 0          #分批稅金額 

      INSERT INTO p610_03_pmdo_t(pmdoent,pmdoseq,pmdoseq1,pmdoseq2,pmdosite,pmdo001,pmdo002,
                                 pmdo003,pmdo004,pmdo005,pmdo006,pmdo007,pmdo008,pmdo009,
                                 pmdo010,pmdo011,pmdo012,pmdo013,pmdo014,pmdo015,pmdo016,
                                 pmdo017,pmdo019,pmdo020,pmdo021,pmdo022,pmdo023,pmdo024,
                                 pmdo025,pmdo026,pmdo027,pmdo028,pmdo029,pmdo030,pmdo031,
                                 pmdo032,pmdo033,pmdo034,pmdl004,pmdl025,pmdl026)
                          VALUES(l_pmdo.pmdoent,l_pmdo.pmdoseq,l_pmdo.pmdoseq1,l_pmdo.pmdoseq2,
                                 l_pmdo.pmdosite,l_pmdo.pmdo001,l_pmdo.pmdo002,l_pmdo.pmdo003,
                                 l_pmdo.pmdo004,l_pmdo.pmdo005,l_pmdo.pmdo006,l_pmdo.pmdo007,
                                 l_pmdo.pmdo008,l_pmdo.pmdo009,l_pmdo.pmdo010,l_pmdo.pmdo011,
                                 l_pmdo.pmdo012,l_pmdo.pmdo013,l_pmdo.pmdo014,l_pmdo.pmdo015,
                                 l_pmdo.pmdo016,l_pmdo.pmdo017,l_pmdo.pmdo019,l_pmdo.pmdo020,
                                 l_pmdo.pmdo021,l_pmdo.pmdo022,l_pmdo.pmdo023,l_pmdo.pmdo024,
                                 l_pmdo.pmdo025,l_pmdo.pmdo026,l_pmdo.pmdo027,l_pmdo.pmdo028,
                                 l_pmdo.pmdo029,l_pmdo.pmdo030,l_pmdo.pmdo031,l_pmdo.pmdo032,
                                 l_pmdo.pmdo033,l_pmdo.pmdo034,p_pmdl004,p_pmdl025,p_pmdl026)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsp610_03_ins_pmdo_2(p_pmdn,p_pmdl004)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_03_ins_pmdo_2(p_pmdn,p_pmdl004)

   #mod--161109-00085#14 By 08993--(s)
#   DEFINE p_pmdn      RECORD LIKE pmdn_t.*   #mark--161109-00085#14 By 08993--(s)
   DEFINE p_pmdn RECORD  #採購單身明細檔
          pmdnent LIKE pmdn_t.pmdnent, #企業編號
          pmdnsite LIKE pmdn_t.pmdnsite, #營運據點
          pmdnunit LIKE pmdn_t.pmdnunit, #應用組織
          pmdndocno LIKE pmdn_t.pmdndocno, #採購單號
          pmdnseq LIKE pmdn_t.pmdnseq, #項次
          pmdn001 LIKE pmdn_t.pmdn001, #料件編號
          pmdn002 LIKE pmdn_t.pmdn002, #產品特徵
          pmdn003 LIKE pmdn_t.pmdn003, #包裝容器
          pmdn004 LIKE pmdn_t.pmdn004, #作業編號
          pmdn005 LIKE pmdn_t.pmdn005, #作業序
          pmdn006 LIKE pmdn_t.pmdn006, #採購單位
          pmdn007 LIKE pmdn_t.pmdn007, #採購數量
          pmdn008 LIKE pmdn_t.pmdn008, #參考單位
          pmdn009 LIKE pmdn_t.pmdn009, #參考數量
          pmdn010 LIKE pmdn_t.pmdn010, #計價單位
          pmdn011 LIKE pmdn_t.pmdn011, #計價數量
          pmdn012 LIKE pmdn_t.pmdn012, #出貨日期
          pmdn013 LIKE pmdn_t.pmdn013, #到廠日期
          pmdn014 LIKE pmdn_t.pmdn014, #到庫日期
          pmdn015 LIKE pmdn_t.pmdn015, #單價
          pmdn016 LIKE pmdn_t.pmdn016, #稅別
          pmdn017 LIKE pmdn_t.pmdn017, #稅率
          pmdn019 LIKE pmdn_t.pmdn019, #子件特性
          pmdn020 LIKE pmdn_t.pmdn020, #緊急度
          pmdn021 LIKE pmdn_t.pmdn021, #保稅
          pmdn022 LIKE pmdn_t.pmdn022, #部分交貨
          pmdnorga LIKE pmdn_t.pmdnorga, #付款據點
          pmdn023 LIKE pmdn_t.pmdn023, #送貨供應商
          pmdn024 LIKE pmdn_t.pmdn024, #多交期
          pmdn025 LIKE pmdn_t.pmdn025, #收貨地址編號
          pmdn026 LIKE pmdn_t.pmdn026, #帳款地址編號
          pmdn027 LIKE pmdn_t.pmdn027, #供應商料號
          pmdn028 LIKE pmdn_t.pmdn028, #收貨庫位
          pmdn029 LIKE pmdn_t.pmdn029, #收貨儲位
          pmdn030 LIKE pmdn_t.pmdn030, #收貨批號
          pmdn031 LIKE pmdn_t.pmdn031, #運輸方式
          pmdn032 LIKE pmdn_t.pmdn032, #取貨模式
          pmdn033 LIKE pmdn_t.pmdn033, #備品率
          pmdn034 LIKE pmdn_t.pmdn034, #no use
          pmdn035 LIKE pmdn_t.pmdn035, #價格核決
          pmdn036 LIKE pmdn_t.pmdn036, #專案編號
          pmdn037 LIKE pmdn_t.pmdn037, #WBS編號
          pmdn038 LIKE pmdn_t.pmdn038, #活動編號
          pmdn039 LIKE pmdn_t.pmdn039, #費用原因
          pmdn040 LIKE pmdn_t.pmdn040, #取價來源
          pmdn041 LIKE pmdn_t.pmdn041, #價格參考單號
          pmdn042 LIKE pmdn_t.pmdn042, #價格參考項次
          pmdn043 LIKE pmdn_t.pmdn043, #取出價格
          pmdn044 LIKE pmdn_t.pmdn044, #價差比
          pmdn045 LIKE pmdn_t.pmdn045, #行狀態
          pmdn046 LIKE pmdn_t.pmdn046, #未稅金額
          pmdn047 LIKE pmdn_t.pmdn047, #含稅金額
          pmdn048 LIKE pmdn_t.pmdn048, #稅額
          pmdn049 LIKE pmdn_t.pmdn049, #理由碼
          pmdn050 LIKE pmdn_t.pmdn050, #備註
          pmdn051 LIKE pmdn_t.pmdn051, #留置/結案理由碼
          pmdn052 LIKE pmdn_t.pmdn052, #檢驗否
          pmdn053 LIKE pmdn_t.pmdn053, #庫存管理特徵
          pmdn200 LIKE pmdn_t.pmdn200, #商品條碼
          pmdn201 LIKE pmdn_t.pmdn201, #包裝單位
          pmdn202 LIKE pmdn_t.pmdn202, #包裝數量
          pmdn203 LIKE pmdn_t.pmdn203, #收貨部門
          pmdn204 LIKE pmdn_t.pmdn204, #No Use
          pmdn205 LIKE pmdn_t.pmdn205, #要貨組織
          pmdn206 LIKE pmdn_t.pmdn206, #庫存量
          pmdn207 LIKE pmdn_t.pmdn207, #採購在途量
          pmdn208 LIKE pmdn_t.pmdn208, #前日銷售量
          pmdn209 LIKE pmdn_t.pmdn209, #上月銷量
          pmdn210 LIKE pmdn_t.pmdn210, #第一週銷量
          pmdn211 LIKE pmdn_t.pmdn211, #第二週銷量
          pmdn212 LIKE pmdn_t.pmdn212, #第三週銷量
          pmdn213 LIKE pmdn_t.pmdn213, #第四週銷量
          pmdn214 LIKE pmdn_t.pmdn214, #採購通路
          pmdn215 LIKE pmdn_t.pmdn215, #通路性質
          pmdn216 LIKE pmdn_t.pmdn216, #經營方式
          pmdn217 LIKE pmdn_t.pmdn217, #結算方式
          pmdn218 LIKE pmdn_t.pmdn218, #合約編號
          pmdn219 LIKE pmdn_t.pmdn219, #協議編號
          pmdn220 LIKE pmdn_t.pmdn220, #採購人員
          pmdn221 LIKE pmdn_t.pmdn221, #採購部門
          pmdn222 LIKE pmdn_t.pmdn222, #採購中心
          pmdn223 LIKE pmdn_t.pmdn223, #配送中心
          pmdn224 LIKE pmdn_t.pmdn224, #採購失效日
          pmdn900 LIKE pmdn_t.pmdn900, #保留欄位str
          pmdn999 LIKE pmdn_t.pmdn999, #保留欄位end
          #161109-00085#61 --s add
          pmdnud001 LIKE pmdn_t.pmdnud001, #自定義欄位(文字)001
          pmdnud002 LIKE pmdn_t.pmdnud002, #自定義欄位(文字)002
          pmdnud003 LIKE pmdn_t.pmdnud003, #自定義欄位(文字)003
          pmdnud004 LIKE pmdn_t.pmdnud004, #自定義欄位(文字)004
          pmdnud005 LIKE pmdn_t.pmdnud005, #自定義欄位(文字)005
          pmdnud006 LIKE pmdn_t.pmdnud006, #自定義欄位(文字)006
          pmdnud007 LIKE pmdn_t.pmdnud007, #自定義欄位(文字)007
          pmdnud008 LIKE pmdn_t.pmdnud008, #自定義欄位(文字)008
          pmdnud009 LIKE pmdn_t.pmdnud009, #自定義欄位(文字)009
          pmdnud010 LIKE pmdn_t.pmdnud010, #自定義欄位(文字)010
          pmdnud011 LIKE pmdn_t.pmdnud011, #自定義欄位(數字)011
          pmdnud012 LIKE pmdn_t.pmdnud012, #自定義欄位(數字)012
          pmdnud013 LIKE pmdn_t.pmdnud013, #自定義欄位(數字)013
          pmdnud014 LIKE pmdn_t.pmdnud014, #自定義欄位(數字)014
          pmdnud015 LIKE pmdn_t.pmdnud015, #自定義欄位(數字)015
          pmdnud016 LIKE pmdn_t.pmdnud016, #自定義欄位(數字)016
          pmdnud017 LIKE pmdn_t.pmdnud017, #自定義欄位(數字)017
          pmdnud018 LIKE pmdn_t.pmdnud018, #自定義欄位(數字)018
          pmdnud019 LIKE pmdn_t.pmdnud019, #自定義欄位(數字)019
          pmdnud020 LIKE pmdn_t.pmdnud020, #自定義欄位(數字)020
          pmdnud021 LIKE pmdn_t.pmdnud021, #自定義欄位(日期時間)021
          pmdnud022 LIKE pmdn_t.pmdnud022, #自定義欄位(日期時間)022
          pmdnud023 LIKE pmdn_t.pmdnud023, #自定義欄位(日期時間)023
          pmdnud024 LIKE pmdn_t.pmdnud024, #自定義欄位(日期時間)024
          pmdnud025 LIKE pmdn_t.pmdnud025, #自定義欄位(日期時間)025
          pmdnud026 LIKE pmdn_t.pmdnud026, #自定義欄位(日期時間)026
          pmdnud027 LIKE pmdn_t.pmdnud027, #自定義欄位(日期時間)027
          pmdnud028 LIKE pmdn_t.pmdnud028, #自定義欄位(日期時間)028
          pmdnud029 LIKE pmdn_t.pmdnud029, #自定義欄位(日期時間)029
          pmdnud030 LIKE pmdn_t.pmdnud030, #自定義欄位(日期時間)030
          #161109-00085#61 --e add
          pmdn225 LIKE pmdn_t.pmdn225, #最終收貨組織
          pmdn054 LIKE pmdn_t.pmdn054, #還料數量
          pmdn055 LIKE pmdn_t.pmdn055, #還量參考數量
          pmdn056 LIKE pmdn_t.pmdn056, #還價數量
          pmdn057 LIKE pmdn_t.pmdn057, #還價參考數量
          pmdn226 LIKE pmdn_t.pmdn226, #長效期每次送貨量
          pmdn227 LIKE pmdn_t.pmdn227, #補貨規格說明
          pmdn058 LIKE pmdn_t.pmdn058, #預算科目
          pmdn228 LIKE pmdn_t.pmdn228  #商品品類
   END RECORD
   #mod--161109-00085#14 By 08993--(e)  
   DEFINE p_pmdl004  LIKE pmdl_t.pmdl004
   #mod--161109-00085#14 By 08993--(s)
#   DEFINE l_pmdo      RECORD LIKE pmdo_t.*   #mark--161109-00085#14 By 08993--(s)
   DEFINE l_pmdo RECORD  #採購交期明細檔
          pmdoent LIKE pmdo_t.pmdoent, #企業編號
          pmdosite LIKE pmdo_t.pmdosite, #營運據點
          pmdodocno LIKE pmdo_t.pmdodocno, #採購單號
          pmdoseq LIKE pmdo_t.pmdoseq, #採購項次
          pmdoseq1 LIKE pmdo_t.pmdoseq1, #項序
          pmdoseq2 LIKE pmdo_t.pmdoseq2, #分批序
          pmdo001 LIKE pmdo_t.pmdo001, #料件編號
          pmdo002 LIKE pmdo_t.pmdo002, #產品特徵
          pmdo003 LIKE pmdo_t.pmdo003, #子件特性
          pmdo004 LIKE pmdo_t.pmdo004, #採購單位
          pmdo005 LIKE pmdo_t.pmdo005, #採購總數量
          pmdo006 LIKE pmdo_t.pmdo006, #分批採購數量
          pmdo007 LIKE pmdo_t.pmdo007, #摺合主件數量
          pmdo008 LIKE pmdo_t.pmdo008, #QPA
          pmdo009 LIKE pmdo_t.pmdo009, #交期類型
          pmdo010 LIKE pmdo_t.pmdo010, #收貨時段
          pmdo011 LIKE pmdo_t.pmdo011, #出貨日期
          pmdo012 LIKE pmdo_t.pmdo012, #到廠日期
          pmdo013 LIKE pmdo_t.pmdo013, #到庫日期
          pmdo014 LIKE pmdo_t.pmdo014, #MRP交期凍結
          pmdo015 LIKE pmdo_t.pmdo015, #已收貨量
          pmdo016 LIKE pmdo_t.pmdo016, #驗退量
          pmdo017 LIKE pmdo_t.pmdo017, #倉退換貨量
          pmdo019 LIKE pmdo_t.pmdo019, #已入庫量
          pmdo020 LIKE pmdo_t.pmdo020, #VMI請款量
          pmdo021 LIKE pmdo_t.pmdo021, #交貨狀態
          pmdo022 LIKE pmdo_t.pmdo022, #參考價格
          pmdo023 LIKE pmdo_t.pmdo023, #稅別
          pmdo024 LIKE pmdo_t.pmdo024, #稅率
          pmdo025 LIKE pmdo_t.pmdo025, #電子採購單號
          pmdo026 LIKE pmdo_t.pmdo026, #最近修改人員
          pmdo027 LIKE pmdo_t.pmdo027, #最近修改時間
          pmdo028 LIKE pmdo_t.pmdo028, #分批參考單位
          pmdo029 LIKE pmdo_t.pmdo029, #分批參考數量
          pmdo030 LIKE pmdo_t.pmdo030, #分批計價單位
          pmdo031 LIKE pmdo_t.pmdo031, #分批計價數量
          pmdo032 LIKE pmdo_t.pmdo032, #分批未稅金額
          pmdo033 LIKE pmdo_t.pmdo033, #分批含稅金額
          pmdo034 LIKE pmdo_t.pmdo034, #分批稅額
          pmdo035 LIKE pmdo_t.pmdo035, #初始營運據點
          pmdo036 LIKE pmdo_t.pmdo036, #初始來源單號
          pmdo037 LIKE pmdo_t.pmdo037, #初始來源項次
          pmdo038 LIKE pmdo_t.pmdo038, #初始項序
          pmdo039 LIKE pmdo_t.pmdo039, #初始分批序
          pmdo040 LIKE pmdo_t.pmdo040, #倉退量
          pmdo200 LIKE pmdo_t.pmdo200, #分批包裝單位
          pmdo201 LIKE pmdo_t.pmdo201, #分批包裝數量
          pmdo900 LIKE pmdo_t.pmdo900, #保留欄位str
          pmdo999 LIKE pmdo_t.pmdo999, #保留欄位end
          #161109-00085#61 --s add
          pmdoud001 LIKE pmdo_t.pmdoud001, #自定義欄位(文字)001
          pmdoud002 LIKE pmdo_t.pmdoud002, #自定義欄位(文字)002
          pmdoud003 LIKE pmdo_t.pmdoud003, #自定義欄位(文字)003
          pmdoud004 LIKE pmdo_t.pmdoud004, #自定義欄位(文字)004
          pmdoud005 LIKE pmdo_t.pmdoud005, #自定義欄位(文字)005
          pmdoud006 LIKE pmdo_t.pmdoud006, #自定義欄位(文字)006
          pmdoud007 LIKE pmdo_t.pmdoud007, #自定義欄位(文字)007
          pmdoud008 LIKE pmdo_t.pmdoud008, #自定義欄位(文字)008
          pmdoud009 LIKE pmdo_t.pmdoud009, #自定義欄位(文字)009
          pmdoud010 LIKE pmdo_t.pmdoud010, #自定義欄位(文字)010
          pmdoud011 LIKE pmdo_t.pmdoud011, #自定義欄位(數字)011
          pmdoud012 LIKE pmdo_t.pmdoud012, #自定義欄位(數字)012
          pmdoud013 LIKE pmdo_t.pmdoud013, #自定義欄位(數字)013
          pmdoud014 LIKE pmdo_t.pmdoud014, #自定義欄位(數字)014
          pmdoud015 LIKE pmdo_t.pmdoud015, #自定義欄位(數字)015
          pmdoud016 LIKE pmdo_t.pmdoud016, #自定義欄位(數字)016
          pmdoud017 LIKE pmdo_t.pmdoud017, #自定義欄位(數字)017
          pmdoud018 LIKE pmdo_t.pmdoud018, #自定義欄位(數字)018
          pmdoud019 LIKE pmdo_t.pmdoud019, #自定義欄位(數字)019
          pmdoud020 LIKE pmdo_t.pmdoud020, #自定義欄位(數字)020
          pmdoud021 LIKE pmdo_t.pmdoud021, #自定義欄位(日期時間)021
          pmdoud022 LIKE pmdo_t.pmdoud022, #自定義欄位(日期時間)022
          pmdoud023 LIKE pmdo_t.pmdoud023, #自定義欄位(日期時間)023
          pmdoud024 LIKE pmdo_t.pmdoud024, #自定義欄位(日期時間)024
          pmdoud025 LIKE pmdo_t.pmdoud025, #自定義欄位(日期時間)025
          pmdoud026 LIKE pmdo_t.pmdoud026, #自定義欄位(日期時間)026
          pmdoud027 LIKE pmdo_t.pmdoud027, #自定義欄位(日期時間)027
          pmdoud028 LIKE pmdo_t.pmdoud028, #自定義欄位(日期時間)028
          pmdoud029 LIKE pmdo_t.pmdoud029, #自定義欄位(日期時間)029
          pmdoud030 LIKE pmdo_t.pmdoud030, #自定義欄位(日期時間)030
          #161109-00085#61 --e add
          pmdo041 LIKE pmdo_t.pmdo041, #還料數量
          pmdo042 LIKE pmdo_t.pmdo042, #還量參考數量
          pmdo043 LIKE pmdo_t.pmdo043, #還價數量
          pmdo044 LIKE pmdo_t.pmdo044  #還價參考數量
   END RECORD  
   #mod--161109-00085#14 By 08993--(e) 
   
   WHENEVER ERROR CONTINUE 

   INITIALIZE l_pmdo.* TO NULL

   LET l_pmdo.pmdoent = g_enterprise
   LET l_pmdo.pmdosite = g_site
   LET l_pmdo.pmdoseq = p_pmdn.pmdnseq

   SELECT MAX(pmdoseq1)+1 INTO l_pmdo.pmdoseq1
     FROM p610_03_pmdo_t
    WHERE pmdoent = g_enterprise
      AND pmdl004 = p_pmdl004
      AND pmdoseq = l_pmdo.pmdoseq
   IF cl_null(l_pmdo.pmdoseq1) OR l_pmdo.pmdoseq1 = 0 THEN
      LET l_pmdo.pmdoseq1 = 1
   END IF
   LET l_pmdo.pmdoseq2 = 1              #分批序
   #LET l_pmdo.pmdo001 = 原物料料號       #料件編號
   #LET l_pmdo.pmdo002 = 原物料料號產品特徵  #產品特徵
   LET l_pmdo.pmdo003 = p_pmdn.pmdn019  #子件特性
   #LET l_pmdo.pmdo004 = 原物料BOM單位    #採購單位
   #LET l_pmdo.pmdo005 = pmdn007*取得的QPA  #採購總量 
   #LET l_pmdo.pmdo006 = pmdn007*取得的QPA  #分批採購量
   LET l_pmdo.pmdo007 = p_pmdn.pmdn007  #折核主件數量
   #LET l_pmdo.pmdo008 = 取得的QPA        #QPA
   LET l_pmdo.pmdo009 = '1'             #交期類型
   LET l_pmdo.pmdo010 = ''              #出貨時段 
   LET l_pmdo.pmdo011 = p_pmdn.pmdn012  #出貨日期
   LET l_pmdo.pmdo012 = p_pmdn.pmdn013  #到廠日期
   LET l_pmdo.pmdo013 = p_pmdn.pmdn014  #到庫日期
   LET l_pmdo.pmdo014 = 'N'             #MRP凍結否
   LET l_pmdo.pmdo015 = 0               #已收貨量
   LET l_pmdo.pmdo016 = 0               #驗退量
   LET l_pmdo.pmdo017 = 0               #倉退換貨量
   LET l_pmdo.pmdo019 = 0               #已入庫量
   LET l_pmdo.pmdo020 = 0               #VMI請款量
   LET l_pmdo.pmdo021 = '2'             #出貨狀態
   #LET l_pmdo.pmdo022 = 由主件單價(pmdn015)依據據點參數設置的推算比率計算  #參考價格
   LET l_pmdo.pmdo023 = p_pmdn.pmdn016  #稅別(#呼叫應取稅別應用元件取得該品項的稅別與稅率)
   LET l_pmdo.pmdo024 = p_pmdn.pmdn017  #稅率(#呼叫應取稅別應用元件取得該品項的稅別與稅率)
   LET l_pmdo.pmdo026 = g_user          #最近修改人員
   LET l_pmdo.pmdo027 = g_today         #最近修改日
   LET l_pmdo.pmdo028 = p_pmdn.pmdn008  #分批參考單位
   LET l_pmdo.pmdo029 = p_pmdn.pmdn009  #分批參考數量
   LET l_pmdo.pmdo030 = p_pmdn.pmdn010  #計價單位
   LET l_pmdo.pmdo031 = p_pmdn.pmdn011  #計價數量
   LET l_pmdo.pmdo032 = p_pmdn.pmdn046  #分批未稅金額(呼叫計算含未稅金額應用元件計算取得) 
   LET l_pmdo.pmdo033 = p_pmdn.pmdn047  #分批含稅金額(呼叫計算含未稅金額應用元件計算取得)
   LET l_pmdo.pmdo034 = p_pmdn.pmdn048  #分批稅金額(呼叫計算含未稅金額應用元件計算取得) 

   INSERT INTO p610_03_pmdo_t(pmdoent,pmdoseq,pmdoseq1,pmdoseq2,pmdosite,pmdo001,pmdo002,
                              pmdo003,pmdo004,pmdo005,pmdo006,pmdo007,pmdo008,pmdo009,
                              pmdo010,pmdo011,pmdo012,pmdo013,pmdo014,pmdo015,pmdo016,
                              pmdo017,pmdo019,pmdo020,pmdo021,pmdo022,pmdo023,pmdo024,
                              pmdo025,pmdo026,pmdo027,pmdo028,pmdo029,pmdo030,pmdo031,
                              pmdo032,pmdo033,pmdo034,pmdl004)
                       VALUES(l_pmdo.pmdoent,l_pmdo.pmdoseq,l_pmdo.pmdoseq1,l_pmdo.pmdoseq2, 
                              l_pmdo.pmdosite,l_pmdo.pmdo001,l_pmdo.pmdo002,l_pmdo.pmdo003,
                              l_pmdo.pmdo004,l_pmdo.pmdo005,l_pmdo.pmdo006,l_pmdo.pmdo007,
                              l_pmdo.pmdo008,l_pmdo.pmdo009,l_pmdo.pmdo010,l_pmdo.pmdo011,
                              l_pmdo.pmdo012,l_pmdo.pmdo013,l_pmdo.pmdo014,l_pmdo.pmdo015,
                              l_pmdo.pmdo016,l_pmdo.pmdo017,l_pmdo.pmdo019,l_pmdo.pmdo020,
                              l_pmdo.pmdo021,l_pmdo.pmdo022,l_pmdo.pmdo023,l_pmdo.pmdo024,
                              l_pmdo.pmdo025,l_pmdo.pmdo026,l_pmdo.pmdo027,l_pmdo.pmdo028,
                              l_pmdo.pmdo029,l_pmdo.pmdo030,l_pmdo.pmdo031,l_pmdo.pmdo032,
                              l_pmdo.pmdo033,l_pmdo.pmdo034,p_pmdl004)
   #若該採購單明細有設置備品率時，應自動在產生一筆備品的交期明細資料
   IF NOT cl_null(p_pmdn.pmdn033) AND p_pmdn.pmdn033 <> 0 THEN
      SELECT MAX(pmdoseq1)+1 INTO l_pmdo.pmdoseq1
        FROM p610_03_pmdo_t
       WHERE pmdoent = g_enterprise
         AND pmdl004 = p_pmdl004
         AND pmdoseq = l_pmdo.pmdoseq
      IF cl_null(l_pmdo.pmdoseq1) OR l_pmdo.pmdoseq1 = 0 THEN
         LET l_pmdo.pmdoseq1 = 1
      END IF

      LET l_pmdo.pmdo003 = '6'        #子件特性
      #LET l_pmdo.pmdo005 = pmdn007*(l_pmdn.pmdn033/100)*取得的QPA  #採購總量
      #LET l_pmdo.pmdo006 = pmdn007*(l_pmdn.pmdn033/100)*取得的QPA  #分批採購量
      LET l_pmdo.pmdo022 = 0          #參考價格
      LET l_pmdo.pmdo032 = 0          #分批未稅金額 
      LET l_pmdo.pmdo033 = 0          #分批含稅金額
      LET l_pmdo.pmdo034 = 0          #分批稅金額
      INSERT INTO p610_03_pmdo_t(pmdoent,pmdoseq,pmdoseq1,pmdoseq2,pmdosite,pmdo001,pmdo002,
                                 pmdo003,pmdo004,pmdo005,pmdo006,pmdo007,pmdo008,pmdo009,
                                 pmdo010,pmdo011,pmdo012,pmdo013,pmdo014,pmdo015,pmdo016, 
                                 pmdo017,pmdo019,pmdo020,pmdo021,pmdo022,pmdo023,pmdo024,
                                 pmdo025,pmdo026,pmdo027,pmdo028,pmdo029,pmdo030,pmdo031,
                                 pmdo032,pmdo033,pmdo034,pmdl004)
                          VALUES(l_pmdo.pmdoent,l_pmdo.pmdoseq,l_pmdo.pmdoseq1,l_pmdo.pmdoseq2,
                                 l_pmdo.pmdosite,l_pmdo.pmdo001,l_pmdo.pmdo002,l_pmdo.pmdo003,
                                 l_pmdo.pmdo004,l_pmdo.pmdo005,l_pmdo.pmdo006,l_pmdo.pmdo007,
                                 l_pmdo.pmdo008,l_pmdo.pmdo009,l_pmdo.pmdo010,l_pmdo.pmdo011,
                                 l_pmdo.pmdo012,l_pmdo.pmdo013,l_pmdo.pmdo014,l_pmdo.pmdo015,
                                 l_pmdo.pmdo016,l_pmdo.pmdo017,l_pmdo.pmdo019,l_pmdo.pmdo020,
                                 l_pmdo.pmdo021,l_pmdo.pmdo022,l_pmdo.pmdo023,l_pmdo.pmdo024,
                                 l_pmdo.pmdo025,l_pmdo.pmdo026,l_pmdo.pmdo027,l_pmdo.pmdo028,
                                 l_pmdo.pmdo029,l_pmdo.pmdo030,l_pmdo.pmdo031,l_pmdo.pmdo032,
                                 l_pmdo.pmdo033,l_pmdo.pmdo034,p_pmdl004)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsp610_03_ins_pmdo_3(p_pmdn,p_pmdl004)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_03_ins_pmdo_3(p_pmdn,p_pmdl004,p_pmdl025,p_pmdl026)

   #mod--161109-00085#14 By 08993--(s)
#   DEFINE p_pmdn      RECORD LIKE pmdn_t.*   #mark--161109-00085#14 By 08993--(s)
   DEFINE p_pmdn RECORD  #採購單身明細檔
          pmdnent LIKE pmdn_t.pmdnent, #企業編號
          pmdnsite LIKE pmdn_t.pmdnsite, #營運據點
          pmdnunit LIKE pmdn_t.pmdnunit, #應用組織
          pmdndocno LIKE pmdn_t.pmdndocno, #採購單號
          pmdnseq LIKE pmdn_t.pmdnseq, #項次
          pmdn001 LIKE pmdn_t.pmdn001, #料件編號
          pmdn002 LIKE pmdn_t.pmdn002, #產品特徵
          pmdn003 LIKE pmdn_t.pmdn003, #包裝容器
          pmdn004 LIKE pmdn_t.pmdn004, #作業編號
          pmdn005 LIKE pmdn_t.pmdn005, #作業序
          pmdn006 LIKE pmdn_t.pmdn006, #採購單位
          pmdn007 LIKE pmdn_t.pmdn007, #採購數量
          pmdn008 LIKE pmdn_t.pmdn008, #參考單位
          pmdn009 LIKE pmdn_t.pmdn009, #參考數量
          pmdn010 LIKE pmdn_t.pmdn010, #計價單位
          pmdn011 LIKE pmdn_t.pmdn011, #計價數量
          pmdn012 LIKE pmdn_t.pmdn012, #出貨日期
          pmdn013 LIKE pmdn_t.pmdn013, #到廠日期
          pmdn014 LIKE pmdn_t.pmdn014, #到庫日期
          pmdn015 LIKE pmdn_t.pmdn015, #單價
          pmdn016 LIKE pmdn_t.pmdn016, #稅別
          pmdn017 LIKE pmdn_t.pmdn017, #稅率
          pmdn019 LIKE pmdn_t.pmdn019, #子件特性
          pmdn020 LIKE pmdn_t.pmdn020, #緊急度
          pmdn021 LIKE pmdn_t.pmdn021, #保稅
          pmdn022 LIKE pmdn_t.pmdn022, #部分交貨
          pmdnorga LIKE pmdn_t.pmdnorga, #付款據點
          pmdn023 LIKE pmdn_t.pmdn023, #送貨供應商
          pmdn024 LIKE pmdn_t.pmdn024, #多交期
          pmdn025 LIKE pmdn_t.pmdn025, #收貨地址編號
          pmdn026 LIKE pmdn_t.pmdn026, #帳款地址編號
          pmdn027 LIKE pmdn_t.pmdn027, #供應商料號
          pmdn028 LIKE pmdn_t.pmdn028, #收貨庫位
          pmdn029 LIKE pmdn_t.pmdn029, #收貨儲位
          pmdn030 LIKE pmdn_t.pmdn030, #收貨批號
          pmdn031 LIKE pmdn_t.pmdn031, #運輸方式
          pmdn032 LIKE pmdn_t.pmdn032, #取貨模式
          pmdn033 LIKE pmdn_t.pmdn033, #備品率
          pmdn034 LIKE pmdn_t.pmdn034, #no use
          pmdn035 LIKE pmdn_t.pmdn035, #價格核決
          pmdn036 LIKE pmdn_t.pmdn036, #專案編號
          pmdn037 LIKE pmdn_t.pmdn037, #WBS編號
          pmdn038 LIKE pmdn_t.pmdn038, #活動編號
          pmdn039 LIKE pmdn_t.pmdn039, #費用原因
          pmdn040 LIKE pmdn_t.pmdn040, #取價來源
          pmdn041 LIKE pmdn_t.pmdn041, #價格參考單號
          pmdn042 LIKE pmdn_t.pmdn042, #價格參考項次
          pmdn043 LIKE pmdn_t.pmdn043, #取出價格
          pmdn044 LIKE pmdn_t.pmdn044, #價差比
          pmdn045 LIKE pmdn_t.pmdn045, #行狀態
          pmdn046 LIKE pmdn_t.pmdn046, #未稅金額
          pmdn047 LIKE pmdn_t.pmdn047, #含稅金額
          pmdn048 LIKE pmdn_t.pmdn048, #稅額
          pmdn049 LIKE pmdn_t.pmdn049, #理由碼
          pmdn050 LIKE pmdn_t.pmdn050, #備註
          pmdn051 LIKE pmdn_t.pmdn051, #留置/結案理由碼
          pmdn052 LIKE pmdn_t.pmdn052, #檢驗否
          pmdn053 LIKE pmdn_t.pmdn053, #庫存管理特徵
          pmdn200 LIKE pmdn_t.pmdn200, #商品條碼
          pmdn201 LIKE pmdn_t.pmdn201, #包裝單位
          pmdn202 LIKE pmdn_t.pmdn202, #包裝數量
          pmdn203 LIKE pmdn_t.pmdn203, #收貨部門
          pmdn204 LIKE pmdn_t.pmdn204, #No Use
          pmdn205 LIKE pmdn_t.pmdn205, #要貨組織
          pmdn206 LIKE pmdn_t.pmdn206, #庫存量
          pmdn207 LIKE pmdn_t.pmdn207, #採購在途量
          pmdn208 LIKE pmdn_t.pmdn208, #前日銷售量
          pmdn209 LIKE pmdn_t.pmdn209, #上月銷量
          pmdn210 LIKE pmdn_t.pmdn210, #第一週銷量
          pmdn211 LIKE pmdn_t.pmdn211, #第二週銷量
          pmdn212 LIKE pmdn_t.pmdn212, #第三週銷量
          pmdn213 LIKE pmdn_t.pmdn213, #第四週銷量
          pmdn214 LIKE pmdn_t.pmdn214, #採購通路
          pmdn215 LIKE pmdn_t.pmdn215, #通路性質
          pmdn216 LIKE pmdn_t.pmdn216, #經營方式
          pmdn217 LIKE pmdn_t.pmdn217, #結算方式
          pmdn218 LIKE pmdn_t.pmdn218, #合約編號
          pmdn219 LIKE pmdn_t.pmdn219, #協議編號
          pmdn220 LIKE pmdn_t.pmdn220, #採購人員
          pmdn221 LIKE pmdn_t.pmdn221, #採購部門
          pmdn222 LIKE pmdn_t.pmdn222, #採購中心
          pmdn223 LIKE pmdn_t.pmdn223, #配送中心
          pmdn224 LIKE pmdn_t.pmdn224, #採購失效日
          pmdn900 LIKE pmdn_t.pmdn900, #保留欄位str
          pmdn999 LIKE pmdn_t.pmdn999, #保留欄位end
          #161109-00085#61 --s add
          pmdnud001 LIKE pmdn_t.pmdnud001, #自定義欄位(文字)001
          pmdnud002 LIKE pmdn_t.pmdnud002, #自定義欄位(文字)002
          pmdnud003 LIKE pmdn_t.pmdnud003, #自定義欄位(文字)003
          pmdnud004 LIKE pmdn_t.pmdnud004, #自定義欄位(文字)004
          pmdnud005 LIKE pmdn_t.pmdnud005, #自定義欄位(文字)005
          pmdnud006 LIKE pmdn_t.pmdnud006, #自定義欄位(文字)006
          pmdnud007 LIKE pmdn_t.pmdnud007, #自定義欄位(文字)007
          pmdnud008 LIKE pmdn_t.pmdnud008, #自定義欄位(文字)008
          pmdnud009 LIKE pmdn_t.pmdnud009, #自定義欄位(文字)009
          pmdnud010 LIKE pmdn_t.pmdnud010, #自定義欄位(文字)010
          pmdnud011 LIKE pmdn_t.pmdnud011, #自定義欄位(數字)011
          pmdnud012 LIKE pmdn_t.pmdnud012, #自定義欄位(數字)012
          pmdnud013 LIKE pmdn_t.pmdnud013, #自定義欄位(數字)013
          pmdnud014 LIKE pmdn_t.pmdnud014, #自定義欄位(數字)014
          pmdnud015 LIKE pmdn_t.pmdnud015, #自定義欄位(數字)015
          pmdnud016 LIKE pmdn_t.pmdnud016, #自定義欄位(數字)016
          pmdnud017 LIKE pmdn_t.pmdnud017, #自定義欄位(數字)017
          pmdnud018 LIKE pmdn_t.pmdnud018, #自定義欄位(數字)018
          pmdnud019 LIKE pmdn_t.pmdnud019, #自定義欄位(數字)019
          pmdnud020 LIKE pmdn_t.pmdnud020, #自定義欄位(數字)020
          pmdnud021 LIKE pmdn_t.pmdnud021, #自定義欄位(日期時間)021
          pmdnud022 LIKE pmdn_t.pmdnud022, #自定義欄位(日期時間)022
          pmdnud023 LIKE pmdn_t.pmdnud023, #自定義欄位(日期時間)023
          pmdnud024 LIKE pmdn_t.pmdnud024, #自定義欄位(日期時間)024
          pmdnud025 LIKE pmdn_t.pmdnud025, #自定義欄位(日期時間)025
          pmdnud026 LIKE pmdn_t.pmdnud026, #自定義欄位(日期時間)026
          pmdnud027 LIKE pmdn_t.pmdnud027, #自定義欄位(日期時間)027
          pmdnud028 LIKE pmdn_t.pmdnud028, #自定義欄位(日期時間)028
          pmdnud029 LIKE pmdn_t.pmdnud029, #自定義欄位(日期時間)029
          pmdnud030 LIKE pmdn_t.pmdnud030, #自定義欄位(日期時間)030
          #161109-00085#61 --e add
          pmdn225 LIKE pmdn_t.pmdn225, #最終收貨組織
          pmdn054 LIKE pmdn_t.pmdn054, #還料數量
          pmdn055 LIKE pmdn_t.pmdn055, #還量參考數量
          pmdn056 LIKE pmdn_t.pmdn056, #還價數量
          pmdn057 LIKE pmdn_t.pmdn057, #還價參考數量
          pmdn226 LIKE pmdn_t.pmdn226, #長效期每次送貨量
          pmdn227 LIKE pmdn_t.pmdn227, #補貨規格說明
          pmdn058 LIKE pmdn_t.pmdn058, #預算科目
          pmdn228 LIKE pmdn_t.pmdn228  #商品品類
   END RECORD  
   #mod--161109-00085#14 By 08993--(e)
   DEFINE p_pmdl004  LIKE pmdl_t.pmdl004 
   DEFINE p_pmdl025  LIKE pmdl_t.pmdl025
   DEFINE p_pmdl026  LIKE pmdl_t.pmdl026
   #mod--161109-00085#14 By 08993--(s)
#   DEFINE l_pmdo      RECORD LIKE pmdo_t.*   #mark--161109-00085#14 By 08993--(s)
   #161109-00085#61 --s mark
   DEFINE l_pmdo RECORD  #採購交期明細檔
          pmdoent LIKE pmdo_t.pmdoent, #企業編號
          pmdosite LIKE pmdo_t.pmdosite, #營運據點
          pmdodocno LIKE pmdo_t.pmdodocno, #採購單號
          pmdoseq LIKE pmdo_t.pmdoseq, #採購項次
          pmdoseq1 LIKE pmdo_t.pmdoseq1, #項序
          pmdoseq2 LIKE pmdo_t.pmdoseq2, #分批序
          pmdo001 LIKE pmdo_t.pmdo001, #料件編號
          pmdo002 LIKE pmdo_t.pmdo002, #產品特徵
          pmdo003 LIKE pmdo_t.pmdo003, #子件特性
          pmdo004 LIKE pmdo_t.pmdo004, #採購單位
          pmdo005 LIKE pmdo_t.pmdo005, #採購總數量
          pmdo006 LIKE pmdo_t.pmdo006, #分批採購數量
          pmdo007 LIKE pmdo_t.pmdo007, #摺合主件數量
          pmdo008 LIKE pmdo_t.pmdo008, #QPA
          pmdo009 LIKE pmdo_t.pmdo009, #交期類型
          pmdo010 LIKE pmdo_t.pmdo010, #收貨時段
          pmdo011 LIKE pmdo_t.pmdo011, #出貨日期
          pmdo012 LIKE pmdo_t.pmdo012, #到廠日期
          pmdo013 LIKE pmdo_t.pmdo013, #到庫日期
          pmdo014 LIKE pmdo_t.pmdo014, #MRP交期凍結
          pmdo015 LIKE pmdo_t.pmdo015, #已收貨量
          pmdo016 LIKE pmdo_t.pmdo016, #驗退量
          pmdo017 LIKE pmdo_t.pmdo017, #倉退換貨量
          pmdo019 LIKE pmdo_t.pmdo019, #已入庫量
          pmdo020 LIKE pmdo_t.pmdo020, #VMI請款量
          pmdo021 LIKE pmdo_t.pmdo021, #交貨狀態
          pmdo022 LIKE pmdo_t.pmdo022, #參考價格
          pmdo023 LIKE pmdo_t.pmdo023, #稅別
          pmdo024 LIKE pmdo_t.pmdo024, #稅率
          pmdo025 LIKE pmdo_t.pmdo025, #電子採購單號
          pmdo026 LIKE pmdo_t.pmdo026, #最近修改人員
          pmdo027 LIKE pmdo_t.pmdo027, #最近修改時間
          pmdo028 LIKE pmdo_t.pmdo028, #分批參考單位
          pmdo029 LIKE pmdo_t.pmdo029, #分批參考數量
          pmdo030 LIKE pmdo_t.pmdo030, #分批計價單位
          pmdo031 LIKE pmdo_t.pmdo031, #分批計價數量
          pmdo032 LIKE pmdo_t.pmdo032, #分批未稅金額
          pmdo033 LIKE pmdo_t.pmdo033, #分批含稅金額
          pmdo034 LIKE pmdo_t.pmdo034, #分批稅額
          pmdo035 LIKE pmdo_t.pmdo035, #初始營運據點
          pmdo036 LIKE pmdo_t.pmdo036, #初始來源單號
          pmdo037 LIKE pmdo_t.pmdo037, #初始來源項次
          pmdo038 LIKE pmdo_t.pmdo038, #初始項序
          pmdo039 LIKE pmdo_t.pmdo039, #初始分批序
          pmdo040 LIKE pmdo_t.pmdo040, #倉退量
          pmdo200 LIKE pmdo_t.pmdo200, #分批包裝單位
          pmdo201 LIKE pmdo_t.pmdo201, #分批包裝數量
          pmdo900 LIKE pmdo_t.pmdo900, #保留欄位str
          pmdo999 LIKE pmdo_t.pmdo999, #保留欄位end
          #161109-00085#61 --s add
          pmdoud001 LIKE pmdo_t.pmdoud001, #自定義欄位(文字)001
          pmdoud002 LIKE pmdo_t.pmdoud002, #自定義欄位(文字)002
          pmdoud003 LIKE pmdo_t.pmdoud003, #自定義欄位(文字)003
          pmdoud004 LIKE pmdo_t.pmdoud004, #自定義欄位(文字)004
          pmdoud005 LIKE pmdo_t.pmdoud005, #自定義欄位(文字)005
          pmdoud006 LIKE pmdo_t.pmdoud006, #自定義欄位(文字)006
          pmdoud007 LIKE pmdo_t.pmdoud007, #自定義欄位(文字)007
          pmdoud008 LIKE pmdo_t.pmdoud008, #自定義欄位(文字)008
          pmdoud009 LIKE pmdo_t.pmdoud009, #自定義欄位(文字)009
          pmdoud010 LIKE pmdo_t.pmdoud010, #自定義欄位(文字)010
          pmdoud011 LIKE pmdo_t.pmdoud011, #自定義欄位(數字)011
          pmdoud012 LIKE pmdo_t.pmdoud012, #自定義欄位(數字)012
          pmdoud013 LIKE pmdo_t.pmdoud013, #自定義欄位(數字)013
          pmdoud014 LIKE pmdo_t.pmdoud014, #自定義欄位(數字)014
          pmdoud015 LIKE pmdo_t.pmdoud015, #自定義欄位(數字)015
          pmdoud016 LIKE pmdo_t.pmdoud016, #自定義欄位(數字)016
          pmdoud017 LIKE pmdo_t.pmdoud017, #自定義欄位(數字)017
          pmdoud018 LIKE pmdo_t.pmdoud018, #自定義欄位(數字)018
          pmdoud019 LIKE pmdo_t.pmdoud019, #自定義欄位(數字)019
          pmdoud020 LIKE pmdo_t.pmdoud020, #自定義欄位(數字)020
          pmdoud021 LIKE pmdo_t.pmdoud021, #自定義欄位(日期時間)021
          pmdoud022 LIKE pmdo_t.pmdoud022, #自定義欄位(日期時間)022
          pmdoud023 LIKE pmdo_t.pmdoud023, #自定義欄位(日期時間)023
          pmdoud024 LIKE pmdo_t.pmdoud024, #自定義欄位(日期時間)024
          pmdoud025 LIKE pmdo_t.pmdoud025, #自定義欄位(日期時間)025
          pmdoud026 LIKE pmdo_t.pmdoud026, #自定義欄位(日期時間)026
          pmdoud027 LIKE pmdo_t.pmdoud027, #自定義欄位(日期時間)027
          pmdoud028 LIKE pmdo_t.pmdoud028, #自定義欄位(日期時間)028
          pmdoud029 LIKE pmdo_t.pmdoud029, #自定義欄位(日期時間)029
          pmdoud030 LIKE pmdo_t.pmdoud030, #自定義欄位(日期時間)030
          #161109-00085#61 --e add
          pmdo041 LIKE pmdo_t.pmdo041, #還料數量
          pmdo042 LIKE pmdo_t.pmdo042, #還量參考數量
          pmdo043 LIKE pmdo_t.pmdo043, #還價數量
          pmdo044 LIKE pmdo_t.pmdo044  #還價參考數量
   END RECORD
   #161109-00085#61 --e mark
   #mod--161109-00085#14 By 08993--(e)  
   #mod--161109-00085#14 By 08993--(s)
#   DEFINE l_pmdq          RECORD LIKE pmdq_t.*   #mark--161109-00085#14 By 08993--(s)
   DEFINE l_pmdq RECORD  #採購多交期匯總檔
          pmdqent LIKE pmdq_t.pmdqent, #企業編號
          pmdqsite LIKE pmdq_t.pmdqsite, #營運據點
          pmdqdocno LIKE pmdq_t.pmdqdocno, #採購單號
          pmdqseq LIKE pmdq_t.pmdqseq, #採購項次
          pmdqseq2 LIKE pmdq_t.pmdqseq2, #分批序
          pmdq002 LIKE pmdq_t.pmdq002, #分批數量
          pmdq003 LIKE pmdq_t.pmdq003, #交貨日期
          pmdq004 LIKE pmdq_t.pmdq004, #到廠日期
          pmdq005 LIKE pmdq_t.pmdq005, #到庫日期
          pmdq006 LIKE pmdq_t.pmdq006, #收貨時段
          pmdq007 LIKE pmdq_t.pmdq007, #MRP凍結否
          pmdq008 LIKE pmdq_t.pmdq008, #交期類型
          pmdq201 LIKE pmdq_t.pmdq201, #分批包裝單位
          pmdq202 LIKE pmdq_t.pmdq202, #分批包裝數量
          pmdq900 LIKE pmdq_t.pmdq900, #保留欄位str
         #pmdq999 LIKE pmdq_t.pmdq999  #保留欄位end #161109-00085#61 mark
          #161109-00085#61 --s add
          pmdq999 LIKE pmdq_t.pmdq999, #保留欄位end
          pmdqud001 LIKE pmdq_t.pmdqud001, #自定義欄位(文字)001
          pmdqud002 LIKE pmdq_t.pmdqud002, #自定義欄位(文字)002
          pmdqud003 LIKE pmdq_t.pmdqud003, #自定義欄位(文字)003
          pmdqud004 LIKE pmdq_t.pmdqud004, #自定義欄位(文字)004
          pmdqud005 LIKE pmdq_t.pmdqud005, #自定義欄位(文字)005
          pmdqud006 LIKE pmdq_t.pmdqud006, #自定義欄位(文字)006
          pmdqud007 LIKE pmdq_t.pmdqud007, #自定義欄位(文字)007
          pmdqud008 LIKE pmdq_t.pmdqud008, #自定義欄位(文字)008
          pmdqud009 LIKE pmdq_t.pmdqud009, #自定義欄位(文字)009
          pmdqud010 LIKE pmdq_t.pmdqud010, #自定義欄位(文字)010
          pmdqud011 LIKE pmdq_t.pmdqud011, #自定義欄位(數字)011
          pmdqud012 LIKE pmdq_t.pmdqud012, #自定義欄位(數字)012
          pmdqud013 LIKE pmdq_t.pmdqud013, #自定義欄位(數字)013
          pmdqud014 LIKE pmdq_t.pmdqud014, #自定義欄位(數字)014
          pmdqud015 LIKE pmdq_t.pmdqud015, #自定義欄位(數字)015
          pmdqud016 LIKE pmdq_t.pmdqud016, #自定義欄位(數字)016
          pmdqud017 LIKE pmdq_t.pmdqud017, #自定義欄位(數字)017
          pmdqud018 LIKE pmdq_t.pmdqud018, #自定義欄位(數字)018
          pmdqud019 LIKE pmdq_t.pmdqud019, #自定義欄位(數字)019
          pmdqud020 LIKE pmdq_t.pmdqud020, #自定義欄位(數字)020
          pmdqud021 LIKE pmdq_t.pmdqud021, #自定義欄位(日期時間)021
          pmdqud022 LIKE pmdq_t.pmdqud022, #自定義欄位(日期時間)022
          pmdqud023 LIKE pmdq_t.pmdqud023, #自定義欄位(日期時間)023
          pmdqud024 LIKE pmdq_t.pmdqud024, #自定義欄位(日期時間)024
          pmdqud025 LIKE pmdq_t.pmdqud025, #自定義欄位(日期時間)025
          pmdqud026 LIKE pmdq_t.pmdqud026, #自定義欄位(日期時間)026
          pmdqud027 LIKE pmdq_t.pmdqud027, #自定義欄位(日期時間)027
          pmdqud028 LIKE pmdq_t.pmdqud028, #自定義欄位(日期時間)028
          pmdqud029 LIKE pmdq_t.pmdqud029, #自定義欄位(日期時間)029
          pmdqud030 LIKE pmdq_t.pmdqud030  #自定義欄位(日期時間)030
          #161109-00085#61 --e add
   END RECORD
   #mod--161109-00085#14 By 08993--(e)    
   WHENEVER ERROR CONTINUE 

   INITIALIZE l_pmdo.* TO NULL
   INITIALIZE l_pmdq.* TO NULL

   LET l_pmdo.pmdoent = g_enterprise
   LET l_pmdo.pmdosite = g_site
   LET l_pmdo.pmdoseq = p_pmdn.pmdnseq

   SELECT MAX(pmdoseq1)+1 INTO l_pmdo.pmdoseq1
     FROM p610_03_pmdo_t
    WHERE pmdoent = g_enterprise
      AND pmdl004 = p_pmdl004 
      AND NVL(pmdl025,' ') = NVL(p_pmdl025,' ')
      AND NVL(pmdl026,' ') = NVL(p_pmdl026,' ')
      AND pmdoseq = l_pmdo.pmdoseq
   IF cl_null(l_pmdo.pmdoseq1) OR l_pmdo.pmdoseq1 = 0 THEN
      LET l_pmdo.pmdoseq1 = 1
   END IF

   #LET l_pmdo.pmdoseq2 = 1              #分批序
   LET l_pmdo.pmdo001 = p_pmdn.pmdn001  #料件編號
   LET l_pmdo.pmdo002 = p_pmdn.pmdn002  #產品特徵
   LET l_pmdo.pmdo003 = p_pmdn.pmdn019  #子件特性
   LET l_pmdo.pmdo004 = p_pmdn.pmdn006  #採購單位
   LET l_pmdo.pmdo005 = p_pmdn.pmdn007  #採購總量
   #LET l_pmdo.pmdo006 = l_pmdn.pmdn007  #分批採購量
   #LET l_pmdo.pmdo007 = l_pmdn.pmdn007  #折核主件數量 
   LET l_pmdo.pmdo008 = 1               #QPA
   LET l_pmdo.pmdo009 = '1'             #交期類型
   #LET l_pmdo.pmdo010 = ''              #出貨時段
   #LET l_pmdo.pmdo011 = l_pmdn.pmdn012  #出貨日期
   #LET l_pmdo.pmdo012 = l_pmdn.pmdn013  #到廠日期
   #LET l_pmdo.pmdo013 = l_pmdn.pmdn014  #到庫日期
   #LET l_pmdo.pmdo014 = 'N'             #MRP凍結否
   LET l_pmdo.pmdo015 = 0               #已收貨量
   LET l_pmdo.pmdo016 = 0               #驗退量
   LET l_pmdo.pmdo017 = 0               #倉退換貨量
   LET l_pmdo.pmdo019 = 0               #已入庫量
   LET l_pmdo.pmdo020 = 0               #VMI請款量
   LET l_pmdo.pmdo021 = '2'             #出貨狀態
   LET l_pmdo.pmdo022 = p_pmdn.pmdn015  #參考價格
   LET l_pmdo.pmdo023 = p_pmdn.pmdn016  #稅別(#呼叫應取稅別應用元件取得該品項的稅別與稅率)
   LET l_pmdo.pmdo024 = p_pmdn.pmdn017  #稅率(#呼叫應取稅別應用元件取得該品項的稅別與稅率)
   LET l_pmdo.pmdo026 = g_user          #最近修改人員
   LET l_pmdo.pmdo027 = g_today         #最近修改日
   LET l_pmdo.pmdo028 = p_pmdn.pmdn008  #分批參考單位
   LET l_pmdo.pmdo029 = p_pmdn.pmdn009  #分批參考數量
   LET l_pmdo.pmdo030 = p_pmdn.pmdn010  #計價單位
   #LET l_pmdo.pmdo031 = p_pmdn.pmdn011  #計價數量 
   #LET l_pmdo.pmdo032 = l_pmdn.pmdn046  #分批未稅金額(呼叫計算含未稅金額應用元件計算取得) 
   #LET l_pmdo.pmdo033 = l_pmdn.pmdn047  #分批含稅金額(呼叫計算含未稅金額應用元件計算取得)
   #LET l_pmdo.pmdo034 = l_pmdn.pmdn048  #分批稅金額(呼叫計算含未稅金額應用元件計算取得)


   DECLARE apsp610_03_pmdq_cs CURSOR FOR SELECT pmdqent,pmdqsite,'',pmdqseq,pmdqseq2,
                                                pmdq002,pmdq003,pmdq004,pmdq005,pmdq006,
                                                pmdq007
                                           FROM p610_03_pmdq_t
                                          WHERE pmdqent   = g_enterprise
                                            AND pmdqseq   = p_pmdn.pmdnseq
                                            AND pmdl004   = p_pmdl004
                                            AND NVL(pmdl025,' ') = NVL(p_pmdl025,' ')
                                            AND NVL(pmdl026,' ') = NVL(p_pmdl026,' ')
   #FOREACH apsp610_03_pmdq_cs INTO l_pmdq.* #161109-00085#61 mark
   FOREACH apsp610_03_pmdq_cs INTO l_pmdq.pmdqent,l_pmdq.pmdqsite,l_pmdq.pmdqdocno,l_pmdq.pmdqseq,l_pmdq.pmdqseq2,
                                   l_pmdq.pmdq002,l_pmdq.pmdq003,l_pmdq.pmdq004,l_pmdq.pmdq005,l_pmdq.pmdq006,
                                   l_pmdq.pmdq007
      LET l_pmdo.pmdoseq2 = l_pmdq.pmdqseq2 #分批序
      LET l_pmdo.pmdo006 = l_pmdq.pmdq002   #分批採購量 
      
      #取得分批計價數量 
      CALL apsp610_03_convert_qty(l_pmdo.pmdo001,l_pmdo.pmdo004,
                                  l_pmdo.pmdo030,l_pmdo.pmdo006)
           RETURNING l_pmdo.pmdo031
      
      LET l_pmdo.pmdo007 = l_pmdq.pmdq002   #折核主件數量
      LET l_pmdo.pmdo010 = l_pmdq.pmdq006   #出貨時段
      LET l_pmdo.pmdo011 = l_pmdq.pmdq003   #出貨日期
      LET l_pmdo.pmdo012 = l_pmdq.pmdq004   #到廠日期
      LET l_pmdo.pmdo013 = l_pmdq.pmdq005   #到庫日期
      LET l_pmdo.pmdo014 = l_pmdq.pmdq007   #MRP凍結否

      #計算金額 分批數量/總數量 * 金額
      LET l_pmdo.pmdo032 = l_pmdo.pmdo007 / l_pmdo.pmdo005 * p_pmdn.pmdn046  #分批未稅金額
      LET l_pmdo.pmdo033 = l_pmdo.pmdo007 / l_pmdo.pmdo005 * p_pmdn.pmdn047  #分批含稅金額
      LET l_pmdo.pmdo034 = l_pmdo.pmdo007 / l_pmdo.pmdo005 * p_pmdn.pmdn048  #分批稅金額

      INSERT INTO p610_03_pmdo_t(pmdoent,pmdoseq,pmdoseq1,pmdoseq2,pmdosite,pmdo001,pmdo002,
                                 pmdo003,pmdo004,pmdo005,pmdo006,pmdo007,pmdo008,pmdo009,
                                 pmdo010,pmdo011,pmdo012,pmdo013,pmdo014,pmdo015,pmdo016,
                                 pmdo017,pmdo019,pmdo020,pmdo021,pmdo022,pmdo023,pmdo024,
                                 pmdo025,pmdo026,pmdo027,pmdo028,pmdo029,pmdo030,pmdo031,
                                 pmdo032,pmdo033,pmdo034,pmdl004,pmdl025,pmdl026)
                          VALUES(l_pmdo.pmdoent,l_pmdo.pmdoseq,l_pmdo.pmdoseq1,l_pmdo.pmdoseq2,
                                 l_pmdo.pmdosite,l_pmdo.pmdo001,l_pmdo.pmdo002,l_pmdo.pmdo003,
                                 l_pmdo.pmdo004,l_pmdo.pmdo005,l_pmdo.pmdo006,l_pmdo.pmdo007,
                                 l_pmdo.pmdo008,l_pmdo.pmdo009,l_pmdo.pmdo010,l_pmdo.pmdo011,
                                 l_pmdo.pmdo012,l_pmdo.pmdo013,l_pmdo.pmdo014,l_pmdo.pmdo015,
                                 l_pmdo.pmdo016,l_pmdo.pmdo017,l_pmdo.pmdo019,l_pmdo.pmdo020,
                                 l_pmdo.pmdo021,l_pmdo.pmdo022,l_pmdo.pmdo023,l_pmdo.pmdo024,
                                 l_pmdo.pmdo025,l_pmdo.pmdo026,l_pmdo.pmdo027,l_pmdo.pmdo028,
                                 l_pmdo.pmdo029,l_pmdo.pmdo030,l_pmdo.pmdo031,l_pmdo.pmdo032,
                                 l_pmdo.pmdo033,l_pmdo.pmdo034,p_pmdl004,p_pmdl025,p_pmdl026)
      #若該採購單明細有設置備品率時，應自動在產生筆各交期的備品明細資料
      IF NOT cl_null(p_pmdn.pmdn033) AND p_pmdn.pmdn033 <> 0 THEN
         SELECT MAX(pmdoseq1)+1 INTO l_pmdo.pmdoseq1
           FROM p610_03_pmdo_t
          WHERE pmdoent = g_enterprise
            AND pmdl004 = p_pmdl004 
            AND NVL(pmdl025,' ') = NVL(p_pmdl025,' ')
            AND NVL(pmdl026,' ') = NVL(p_pmdl026,' ')
            AND pmdoseq = l_pmdo.pmdoseq
         IF cl_null(l_pmdo.pmdoseq1) OR l_pmdo.pmdoseq1 = 0 THEN
            LET l_pmdo.pmdoseq1 = 1
         END IF

         LET l_pmdo.pmdo003 = '6'        #子件特性
         LET l_pmdo.pmdo005 = p_pmdn.pmdn007 * (p_pmdn.pmdn033/100)  #採購總量
         LET l_pmdo.pmdo006 = l_pmdq.pmdq002 * (p_pmdn.pmdn033/100)  #分批採購量
         LET l_pmdo.pmdo007 = l_pmdq.pmdq002 * (p_pmdn.pmdn033/100)  #折核主件數量 
         LET l_pmdo.pmdo022 = 0          #參考價格
         LET l_pmdo.pmdo032 = 0          #分批未稅金額 
         LET l_pmdo.pmdo033 = 0          #分批含稅金額
         LET l_pmdo.pmdo034 = 0          #分批稅金額
         INSERT INTO p610_03_pmdo_t(pmdoent,pmdoseq,pmdoseq1,pmdoseq2,pmdosite,pmdo001,pmdo002,
                                    pmdo003,pmdo004,pmdo005,pmdo006,pmdo007,pmdo008,pmdo009,
                                    pmdo010,pmdo011,pmdo012,pmdo013,pmdo014,pmdo015,pmdo016,
                                    pmdo017,pmdo019,pmdo020,pmdo021,pmdo022,pmdo023,pmdo024,
                                    pmdo025,pmdo026,pmdo027,pmdo028,pmdo029,pmdo030,pmdo031,
                                    pmdo032,pmdo033,pmdo034,pmdl004,pmdl025,pmdl026)
                             VALUES(l_pmdo.pmdoent,l_pmdo.pmdoseq,l_pmdo.pmdoseq1,l_pmdo.pmdoseq2,
                                    l_pmdo.pmdosite,l_pmdo.pmdo001,l_pmdo.pmdo002,l_pmdo.pmdo003,
                                    l_pmdo.pmdo004,l_pmdo.pmdo005,l_pmdo.pmdo006,l_pmdo.pmdo007,
                                    l_pmdo.pmdo008,l_pmdo.pmdo009,l_pmdo.pmdo010,l_pmdo.pmdo011,
                                    l_pmdo.pmdo012,l_pmdo.pmdo013,l_pmdo.pmdo014,l_pmdo.pmdo015,
                                    l_pmdo.pmdo016,l_pmdo.pmdo017,l_pmdo.pmdo019,l_pmdo.pmdo020,
                                    l_pmdo.pmdo021,l_pmdo.pmdo022,l_pmdo.pmdo023,l_pmdo.pmdo024,
                                    l_pmdo.pmdo025,l_pmdo.pmdo026,l_pmdo.pmdo027,l_pmdo.pmdo028,
                                    l_pmdo.pmdo029,l_pmdo.pmdo030,l_pmdo.pmdo031,l_pmdo.pmdo032,
                                    l_pmdo.pmdo033,l_pmdo.pmdo034,p_pmdl004,p_pmdl025,p_pmdl026)
      END IF
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsp610_03_ins_pmdo_4(p_pmdn,p_pmdl004)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_03_ins_pmdo_4(p_pmdn,p_pmdl004)

   #mod--161109-00085#14 By 08993--(s)
#   DEFINE p_pmdn      RECORD LIKE pmdn_t.*   #mark--161109-00085#14 By 08993--(s)
   DEFINE p_pmdn RECORD  #採購單身明細檔
          pmdnent LIKE pmdn_t.pmdnent, #企業編號
          pmdnsite LIKE pmdn_t.pmdnsite, #營運據點
          pmdnunit LIKE pmdn_t.pmdnunit, #應用組織
          pmdndocno LIKE pmdn_t.pmdndocno, #採購單號
          pmdnseq LIKE pmdn_t.pmdnseq, #項次
          pmdn001 LIKE pmdn_t.pmdn001, #料件編號
          pmdn002 LIKE pmdn_t.pmdn002, #產品特徵
          pmdn003 LIKE pmdn_t.pmdn003, #包裝容器
          pmdn004 LIKE pmdn_t.pmdn004, #作業編號
          pmdn005 LIKE pmdn_t.pmdn005, #作業序
          pmdn006 LIKE pmdn_t.pmdn006, #採購單位
          pmdn007 LIKE pmdn_t.pmdn007, #採購數量
          pmdn008 LIKE pmdn_t.pmdn008, #參考單位
          pmdn009 LIKE pmdn_t.pmdn009, #參考數量
          pmdn010 LIKE pmdn_t.pmdn010, #計價單位
          pmdn011 LIKE pmdn_t.pmdn011, #計價數量
          pmdn012 LIKE pmdn_t.pmdn012, #出貨日期
          pmdn013 LIKE pmdn_t.pmdn013, #到廠日期
          pmdn014 LIKE pmdn_t.pmdn014, #到庫日期
          pmdn015 LIKE pmdn_t.pmdn015, #單價
          pmdn016 LIKE pmdn_t.pmdn016, #稅別
          pmdn017 LIKE pmdn_t.pmdn017, #稅率
          pmdn019 LIKE pmdn_t.pmdn019, #子件特性
          pmdn020 LIKE pmdn_t.pmdn020, #緊急度
          pmdn021 LIKE pmdn_t.pmdn021, #保稅
          pmdn022 LIKE pmdn_t.pmdn022, #部分交貨
          pmdnorga LIKE pmdn_t.pmdnorga, #付款據點
          pmdn023 LIKE pmdn_t.pmdn023, #送貨供應商
          pmdn024 LIKE pmdn_t.pmdn024, #多交期
          pmdn025 LIKE pmdn_t.pmdn025, #收貨地址編號
          pmdn026 LIKE pmdn_t.pmdn026, #帳款地址編號
          pmdn027 LIKE pmdn_t.pmdn027, #供應商料號
          pmdn028 LIKE pmdn_t.pmdn028, #收貨庫位
          pmdn029 LIKE pmdn_t.pmdn029, #收貨儲位
          pmdn030 LIKE pmdn_t.pmdn030, #收貨批號
          pmdn031 LIKE pmdn_t.pmdn031, #運輸方式
          pmdn032 LIKE pmdn_t.pmdn032, #取貨模式
          pmdn033 LIKE pmdn_t.pmdn033, #備品率
          pmdn034 LIKE pmdn_t.pmdn034, #no use
          pmdn035 LIKE pmdn_t.pmdn035, #價格核決
          pmdn036 LIKE pmdn_t.pmdn036, #專案編號
          pmdn037 LIKE pmdn_t.pmdn037, #WBS編號
          pmdn038 LIKE pmdn_t.pmdn038, #活動編號
          pmdn039 LIKE pmdn_t.pmdn039, #費用原因
          pmdn040 LIKE pmdn_t.pmdn040, #取價來源
          pmdn041 LIKE pmdn_t.pmdn041, #價格參考單號
          pmdn042 LIKE pmdn_t.pmdn042, #價格參考項次
          pmdn043 LIKE pmdn_t.pmdn043, #取出價格
          pmdn044 LIKE pmdn_t.pmdn044, #價差比
          pmdn045 LIKE pmdn_t.pmdn045, #行狀態
          pmdn046 LIKE pmdn_t.pmdn046, #未稅金額
          pmdn047 LIKE pmdn_t.pmdn047, #含稅金額
          pmdn048 LIKE pmdn_t.pmdn048, #稅額
          pmdn049 LIKE pmdn_t.pmdn049, #理由碼
          pmdn050 LIKE pmdn_t.pmdn050, #備註
          pmdn051 LIKE pmdn_t.pmdn051, #留置/結案理由碼
          pmdn052 LIKE pmdn_t.pmdn052, #檢驗否
          pmdn053 LIKE pmdn_t.pmdn053, #庫存管理特徵
          pmdn200 LIKE pmdn_t.pmdn200, #商品條碼
          pmdn201 LIKE pmdn_t.pmdn201, #包裝單位
          pmdn202 LIKE pmdn_t.pmdn202, #包裝數量
          pmdn203 LIKE pmdn_t.pmdn203, #收貨部門
          pmdn204 LIKE pmdn_t.pmdn204, #No Use
          pmdn205 LIKE pmdn_t.pmdn205, #要貨組織
          pmdn206 LIKE pmdn_t.pmdn206, #庫存量
          pmdn207 LIKE pmdn_t.pmdn207, #採購在途量
          pmdn208 LIKE pmdn_t.pmdn208, #前日銷售量
          pmdn209 LIKE pmdn_t.pmdn209, #上月銷量
          pmdn210 LIKE pmdn_t.pmdn210, #第一週銷量
          pmdn211 LIKE pmdn_t.pmdn211, #第二週銷量
          pmdn212 LIKE pmdn_t.pmdn212, #第三週銷量
          pmdn213 LIKE pmdn_t.pmdn213, #第四週銷量
          pmdn214 LIKE pmdn_t.pmdn214, #採購通路
          pmdn215 LIKE pmdn_t.pmdn215, #通路性質
          pmdn216 LIKE pmdn_t.pmdn216, #經營方式
          pmdn217 LIKE pmdn_t.pmdn217, #結算方式
          pmdn218 LIKE pmdn_t.pmdn218, #合約編號
          pmdn219 LIKE pmdn_t.pmdn219, #協議編號
          pmdn220 LIKE pmdn_t.pmdn220, #採購人員
          pmdn221 LIKE pmdn_t.pmdn221, #採購部門
          pmdn222 LIKE pmdn_t.pmdn222, #採購中心
          pmdn223 LIKE pmdn_t.pmdn223, #配送中心
          pmdn224 LIKE pmdn_t.pmdn224, #採購失效日
          pmdn900 LIKE pmdn_t.pmdn900, #保留欄位str
          pmdn999 LIKE pmdn_t.pmdn999, #保留欄位end
          #161109-00085#61 --s add
          pmdnud001 LIKE pmdn_t.pmdnud001, #自定義欄位(文字)001
          pmdnud002 LIKE pmdn_t.pmdnud002, #自定義欄位(文字)002
          pmdnud003 LIKE pmdn_t.pmdnud003, #自定義欄位(文字)003
          pmdnud004 LIKE pmdn_t.pmdnud004, #自定義欄位(文字)004
          pmdnud005 LIKE pmdn_t.pmdnud005, #自定義欄位(文字)005
          pmdnud006 LIKE pmdn_t.pmdnud006, #自定義欄位(文字)006
          pmdnud007 LIKE pmdn_t.pmdnud007, #自定義欄位(文字)007
          pmdnud008 LIKE pmdn_t.pmdnud008, #自定義欄位(文字)008
          pmdnud009 LIKE pmdn_t.pmdnud009, #自定義欄位(文字)009
          pmdnud010 LIKE pmdn_t.pmdnud010, #自定義欄位(文字)010
          pmdnud011 LIKE pmdn_t.pmdnud011, #自定義欄位(數字)011
          pmdnud012 LIKE pmdn_t.pmdnud012, #自定義欄位(數字)012
          pmdnud013 LIKE pmdn_t.pmdnud013, #自定義欄位(數字)013
          pmdnud014 LIKE pmdn_t.pmdnud014, #自定義欄位(數字)014
          pmdnud015 LIKE pmdn_t.pmdnud015, #自定義欄位(數字)015
          pmdnud016 LIKE pmdn_t.pmdnud016, #自定義欄位(數字)016
          pmdnud017 LIKE pmdn_t.pmdnud017, #自定義欄位(數字)017
          pmdnud018 LIKE pmdn_t.pmdnud018, #自定義欄位(數字)018
          pmdnud019 LIKE pmdn_t.pmdnud019, #自定義欄位(數字)019
          pmdnud020 LIKE pmdn_t.pmdnud020, #自定義欄位(數字)020
          pmdnud021 LIKE pmdn_t.pmdnud021, #自定義欄位(日期時間)021
          pmdnud022 LIKE pmdn_t.pmdnud022, #自定義欄位(日期時間)022
          pmdnud023 LIKE pmdn_t.pmdnud023, #自定義欄位(日期時間)023
          pmdnud024 LIKE pmdn_t.pmdnud024, #自定義欄位(日期時間)024
          pmdnud025 LIKE pmdn_t.pmdnud025, #自定義欄位(日期時間)025
          pmdnud026 LIKE pmdn_t.pmdnud026, #自定義欄位(日期時間)026
          pmdnud027 LIKE pmdn_t.pmdnud027, #自定義欄位(日期時間)027
          pmdnud028 LIKE pmdn_t.pmdnud028, #自定義欄位(日期時間)028
          pmdnud029 LIKE pmdn_t.pmdnud029, #自定義欄位(日期時間)029
          pmdnud030 LIKE pmdn_t.pmdnud030, #自定義欄位(日期時間)030
          #161109-00085#61 --e add
          pmdn225 LIKE pmdn_t.pmdn225, #最終收貨組織
          pmdn054 LIKE pmdn_t.pmdn054, #還料數量
          pmdn055 LIKE pmdn_t.pmdn055, #還量參考數量
          pmdn056 LIKE pmdn_t.pmdn056, #還價數量
          pmdn057 LIKE pmdn_t.pmdn057, #還價參考數量
          pmdn226 LIKE pmdn_t.pmdn226, #長效期每次送貨量
          pmdn227 LIKE pmdn_t.pmdn227, #補貨規格說明
          pmdn058 LIKE pmdn_t.pmdn058, #預算科目
          pmdn228 LIKE pmdn_t.pmdn228  #商品品類
   END RECORD
   #mod--161109-00085#14 By 08993--(e)  
   DEFINE p_pmdl004  LIKE pmdl_t.pmdl004
   #mod--161109-00085#14 By 08993--(s)
#   DEFINE l_pmdo      RECORD LIKE pmdo_t.*   #mark--161109-00085#14 By 08993--(s)
   DEFINE l_pmdo RECORD  #採購交期明細檔
          pmdoent LIKE pmdo_t.pmdoent, #企業編號
          pmdosite LIKE pmdo_t.pmdosite, #營運據點
          pmdodocno LIKE pmdo_t.pmdodocno, #採購單號
          pmdoseq LIKE pmdo_t.pmdoseq, #採購項次
          pmdoseq1 LIKE pmdo_t.pmdoseq1, #項序
          pmdoseq2 LIKE pmdo_t.pmdoseq2, #分批序
          pmdo001 LIKE pmdo_t.pmdo001, #料件編號
          pmdo002 LIKE pmdo_t.pmdo002, #產品特徵
          pmdo003 LIKE pmdo_t.pmdo003, #子件特性
          pmdo004 LIKE pmdo_t.pmdo004, #採購單位
          pmdo005 LIKE pmdo_t.pmdo005, #採購總數量
          pmdo006 LIKE pmdo_t.pmdo006, #分批採購數量
          pmdo007 LIKE pmdo_t.pmdo007, #摺合主件數量
          pmdo008 LIKE pmdo_t.pmdo008, #QPA
          pmdo009 LIKE pmdo_t.pmdo009, #交期類型
          pmdo010 LIKE pmdo_t.pmdo010, #收貨時段
          pmdo011 LIKE pmdo_t.pmdo011, #出貨日期
          pmdo012 LIKE pmdo_t.pmdo012, #到廠日期
          pmdo013 LIKE pmdo_t.pmdo013, #到庫日期
          pmdo014 LIKE pmdo_t.pmdo014, #MRP交期凍結
          pmdo015 LIKE pmdo_t.pmdo015, #已收貨量
          pmdo016 LIKE pmdo_t.pmdo016, #驗退量
          pmdo017 LIKE pmdo_t.pmdo017, #倉退換貨量
          pmdo019 LIKE pmdo_t.pmdo019, #已入庫量
          pmdo020 LIKE pmdo_t.pmdo020, #VMI請款量
          pmdo021 LIKE pmdo_t.pmdo021, #交貨狀態
          pmdo022 LIKE pmdo_t.pmdo022, #參考價格
          pmdo023 LIKE pmdo_t.pmdo023, #稅別
          pmdo024 LIKE pmdo_t.pmdo024, #稅率
          pmdo025 LIKE pmdo_t.pmdo025, #電子採購單號
          pmdo026 LIKE pmdo_t.pmdo026, #最近修改人員
          pmdo027 LIKE pmdo_t.pmdo027, #最近修改時間
          pmdo028 LIKE pmdo_t.pmdo028, #分批參考單位
          pmdo029 LIKE pmdo_t.pmdo029, #分批參考數量
          pmdo030 LIKE pmdo_t.pmdo030, #分批計價單位
          pmdo031 LIKE pmdo_t.pmdo031, #分批計價數量
          pmdo032 LIKE pmdo_t.pmdo032, #分批未稅金額
          pmdo033 LIKE pmdo_t.pmdo033, #分批含稅金額
          pmdo034 LIKE pmdo_t.pmdo034, #分批稅額
          pmdo035 LIKE pmdo_t.pmdo035, #初始營運據點
          pmdo036 LIKE pmdo_t.pmdo036, #初始來源單號
          pmdo037 LIKE pmdo_t.pmdo037, #初始來源項次
          pmdo038 LIKE pmdo_t.pmdo038, #初始項序
          pmdo039 LIKE pmdo_t.pmdo039, #初始分批序
          pmdo040 LIKE pmdo_t.pmdo040, #倉退量
          pmdo200 LIKE pmdo_t.pmdo200, #分批包裝單位
          pmdo201 LIKE pmdo_t.pmdo201, #分批包裝數量
          pmdo900 LIKE pmdo_t.pmdo900, #保留欄位str
          pmdo999 LIKE pmdo_t.pmdo999, #保留欄位end
          #161109-00085#61 --s add
          pmdoud001 LIKE pmdo_t.pmdoud001, #自定義欄位(文字)001
          pmdoud002 LIKE pmdo_t.pmdoud002, #自定義欄位(文字)002
          pmdoud003 LIKE pmdo_t.pmdoud003, #自定義欄位(文字)003
          pmdoud004 LIKE pmdo_t.pmdoud004, #自定義欄位(文字)004
          pmdoud005 LIKE pmdo_t.pmdoud005, #自定義欄位(文字)005
          pmdoud006 LIKE pmdo_t.pmdoud006, #自定義欄位(文字)006
          pmdoud007 LIKE pmdo_t.pmdoud007, #自定義欄位(文字)007
          pmdoud008 LIKE pmdo_t.pmdoud008, #自定義欄位(文字)008
          pmdoud009 LIKE pmdo_t.pmdoud009, #自定義欄位(文字)009
          pmdoud010 LIKE pmdo_t.pmdoud010, #自定義欄位(文字)010
          pmdoud011 LIKE pmdo_t.pmdoud011, #自定義欄位(數字)011
          pmdoud012 LIKE pmdo_t.pmdoud012, #自定義欄位(數字)012
          pmdoud013 LIKE pmdo_t.pmdoud013, #自定義欄位(數字)013
          pmdoud014 LIKE pmdo_t.pmdoud014, #自定義欄位(數字)014
          pmdoud015 LIKE pmdo_t.pmdoud015, #自定義欄位(數字)015
          pmdoud016 LIKE pmdo_t.pmdoud016, #自定義欄位(數字)016
          pmdoud017 LIKE pmdo_t.pmdoud017, #自定義欄位(數字)017
          pmdoud018 LIKE pmdo_t.pmdoud018, #自定義欄位(數字)018
          pmdoud019 LIKE pmdo_t.pmdoud019, #自定義欄位(數字)019
          pmdoud020 LIKE pmdo_t.pmdoud020, #自定義欄位(數字)020
          pmdoud021 LIKE pmdo_t.pmdoud021, #自定義欄位(日期時間)021
          pmdoud022 LIKE pmdo_t.pmdoud022, #自定義欄位(日期時間)022
          pmdoud023 LIKE pmdo_t.pmdoud023, #自定義欄位(日期時間)023
          pmdoud024 LIKE pmdo_t.pmdoud024, #自定義欄位(日期時間)024
          pmdoud025 LIKE pmdo_t.pmdoud025, #自定義欄位(日期時間)025
          pmdoud026 LIKE pmdo_t.pmdoud026, #自定義欄位(日期時間)026
          pmdoud027 LIKE pmdo_t.pmdoud027, #自定義欄位(日期時間)027
          pmdoud028 LIKE pmdo_t.pmdoud028, #自定義欄位(日期時間)028
          pmdoud029 LIKE pmdo_t.pmdoud029, #自定義欄位(日期時間)029
          pmdoud030 LIKE pmdo_t.pmdoud030, #自定義欄位(日期時間)030
          #161109-00085#61 --e add
          pmdo041 LIKE pmdo_t.pmdo041, #還料數量
          pmdo042 LIKE pmdo_t.pmdo042, #還量參考數量
          pmdo043 LIKE pmdo_t.pmdo043, #還價數量
          pmdo044 LIKE pmdo_t.pmdo044  #還價參考數量
   END RECORD
   #mod--161109-00085#14 By 08993--(e)
   #mod--161109-00085#14 By 08993--(s)
#   DEFINE l_pmdq          RECORD LIKE pmdq_t.*   #mark--161109-00085#14 By 08993--(s)
   DEFINE l_pmdq RECORD  #採購多交期匯總檔
          pmdqent LIKE pmdq_t.pmdqent, #企業編號
          pmdqsite LIKE pmdq_t.pmdqsite, #營運據點
          pmdqdocno LIKE pmdq_t.pmdqdocno, #採購單號
          pmdqseq LIKE pmdq_t.pmdqseq, #採購項次
          pmdqseq2 LIKE pmdq_t.pmdqseq2, #分批序
          pmdq002 LIKE pmdq_t.pmdq002, #分批數量
          pmdq003 LIKE pmdq_t.pmdq003, #交貨日期
          pmdq004 LIKE pmdq_t.pmdq004, #到廠日期
          pmdq005 LIKE pmdq_t.pmdq005, #到庫日期
          pmdq006 LIKE pmdq_t.pmdq006, #收貨時段
          pmdq007 LIKE pmdq_t.pmdq007, #MRP凍結否
          pmdq008 LIKE pmdq_t.pmdq008, #交期類型
          pmdq201 LIKE pmdq_t.pmdq201, #分批包裝單位
          pmdq202 LIKE pmdq_t.pmdq202, #分批包裝數量
          pmdq900 LIKE pmdq_t.pmdq900, #保留欄位str
         #pmdq999 LIKE pmdq_t.pmdq999  #保留欄位end #161109-00085#61 mark
          #161109-00085#61 --s add
          pmdq999 LIKE pmdq_t.pmdq999, #保留欄位end
          pmdqud001 LIKE pmdq_t.pmdqud001, #自定義欄位(文字)001
          pmdqud002 LIKE pmdq_t.pmdqud002, #自定義欄位(文字)002
          pmdqud003 LIKE pmdq_t.pmdqud003, #自定義欄位(文字)003
          pmdqud004 LIKE pmdq_t.pmdqud004, #自定義欄位(文字)004
          pmdqud005 LIKE pmdq_t.pmdqud005, #自定義欄位(文字)005
          pmdqud006 LIKE pmdq_t.pmdqud006, #自定義欄位(文字)006
          pmdqud007 LIKE pmdq_t.pmdqud007, #自定義欄位(文字)007
          pmdqud008 LIKE pmdq_t.pmdqud008, #自定義欄位(文字)008
          pmdqud009 LIKE pmdq_t.pmdqud009, #自定義欄位(文字)009
          pmdqud010 LIKE pmdq_t.pmdqud010, #自定義欄位(文字)010
          pmdqud011 LIKE pmdq_t.pmdqud011, #自定義欄位(數字)011
          pmdqud012 LIKE pmdq_t.pmdqud012, #自定義欄位(數字)012
          pmdqud013 LIKE pmdq_t.pmdqud013, #自定義欄位(數字)013
          pmdqud014 LIKE pmdq_t.pmdqud014, #自定義欄位(數字)014
          pmdqud015 LIKE pmdq_t.pmdqud015, #自定義欄位(數字)015
          pmdqud016 LIKE pmdq_t.pmdqud016, #自定義欄位(數字)016
          pmdqud017 LIKE pmdq_t.pmdqud017, #自定義欄位(數字)017
          pmdqud018 LIKE pmdq_t.pmdqud018, #自定義欄位(數字)018
          pmdqud019 LIKE pmdq_t.pmdqud019, #自定義欄位(數字)019
          pmdqud020 LIKE pmdq_t.pmdqud020, #自定義欄位(數字)020
          pmdqud021 LIKE pmdq_t.pmdqud021, #自定義欄位(日期時間)021
          pmdqud022 LIKE pmdq_t.pmdqud022, #自定義欄位(日期時間)022
          pmdqud023 LIKE pmdq_t.pmdqud023, #自定義欄位(日期時間)023
          pmdqud024 LIKE pmdq_t.pmdqud024, #自定義欄位(日期時間)024
          pmdqud025 LIKE pmdq_t.pmdqud025, #自定義欄位(日期時間)025
          pmdqud026 LIKE pmdq_t.pmdqud026, #自定義欄位(日期時間)026
          pmdqud027 LIKE pmdq_t.pmdqud027, #自定義欄位(日期時間)027
          pmdqud028 LIKE pmdq_t.pmdqud028, #自定義欄位(日期時間)028
          pmdqud029 LIKE pmdq_t.pmdqud029, #自定義欄位(日期時間)029
          pmdqud030 LIKE pmdq_t.pmdqud030  #自定義欄位(日期時間)030
          #161109-00085#61 --e add
   END RECORD 
   #mod--161109-00085#14 By 08993--(e) 
   
   WHENEVER ERROR CONTINUE 

   INITIALIZE l_pmdo.* TO NULL
   INITIALIZE l_pmdq.* TO NULL

   LET l_pmdo.pmdoent  = g_enterprise
   LET l_pmdo.pmdosite = g_site
   LET l_pmdo.pmdoseq  = p_pmdn.pmdnseq

   SELECT MAX(pmdoseq1)+1 INTO l_pmdo.pmdoseq1
     FROM p610_03_pmdo_t
    WHERE pmdoent = g_enterprise
      AND pmdl004 = p_pmdl004
      AND pmdoseq = l_pmdo.pmdoseq
   IF cl_null(l_pmdo.pmdoseq1) OR l_pmdo.pmdoseq1 = 0 THEN
      LET l_pmdo.pmdoseq1 = 1
   END IF
   #LET l_pmdo.pmdoseq2 = 1              #分批序
   #LET l_pmdo.pmdo001 = 原物料料號       #料件編號
   #LET l_pmdo.pmdo002 = 原物料料號產品特徵  #產品特徵
   LET l_pmdo.pmdo003 = p_pmdn.pmdn019  #子件特性
   #LET l_pmdo.pmdo004 = 原物料BOM單位    #採購單位
   #LET l_pmdo.pmdo005 = pmdn007*取得的QPA  #採購總量
   #LET l_pmdo.pmdo006 = pmdn007*取得的QPA  #分批採購量
   #LET l_pmdo.pmdo007 = l_pmdn.pmdn007  #折核主件數量
   #LET l_pmdo.pmdo008 = 取得的QPA        #QPA 
   LET l_pmdo.pmdo009 = '1'             #交期類型
   #LET l_pmdo.pmdo010 = ''              #出貨時段
   #LET l_pmdo.pmdo011 = l_pmdn.pmdn012  #出貨日期
   #LET l_pmdo.pmdo012 = l_pmdn.pmdn013  #到廠日期
   #LET l_pmdo.pmdo013 = l_pmdn.pmdn014  #到庫日期
   #LET l_pmdo.pmdo014 = 'N'             #MRP凍結否
   LET l_pmdo.pmdo015 = 0               #已收貨量
   LET l_pmdo.pmdo016 = 0               #驗退量
   LET l_pmdo.pmdo017 = 0               #倉退換貨量
   LET l_pmdo.pmdo019 = 0               #已入庫量
   LET l_pmdo.pmdo020 = 0               #VMI請款量
   LET l_pmdo.pmdo021 = '2'             #出貨狀態
   #LET l_pmdo.pmdo022 = 由主件單價(pmdn015)依據據點參數設置的推算比率計算  #參考價格
   LET l_pmdo.pmdo023 = p_pmdn.pmdn016  #稅別(#呼叫應取稅別應用元件取得該品項的稅別與稅率)
   LET l_pmdo.pmdo024 = p_pmdn.pmdn017  #稅率(#呼叫應取稅別應用元件取得該品項的稅別與稅率)
   LET l_pmdo.pmdo026 = g_user          #最近修改人員
   LET l_pmdo.pmdo027 = g_today         #最近修改日
   LET l_pmdo.pmdo028 = p_pmdn.pmdn008  #分批參考單位
   LET l_pmdo.pmdo029 = p_pmdn.pmdn009  #分批參考數量
   LET l_pmdo.pmdo030 = p_pmdn.pmdn010  #計價單位
   LET l_pmdo.pmdo031 = p_pmdn.pmdn011  #計價數量 
   #LET l_pmdo.pmdo032 = l_pmdn.pmdn046  #分批未稅金額(呼叫計算含未稅金額應用元件計算取得) 
   #LET l_pmdo.pmdo033 = l_pmdn.pmdn047  #分批含稅金額(呼叫計算含未稅金額應用元件計算取得)
   #LET l_pmdo.pmdo034 = l_pmdn.pmdn048  #分批稅金額(呼叫計算含未稅金額應用元件計算取得)

   #mod--161109-00085#14 By 08993--(s)
   #mark--161109-00085#14 By 08993--(s)
#   DECLARE apsp610_03_pmdq_cs2 CURSOR FOR SELECT *   
#                                            FROM pmdq_t
#                                           WHERE pmdqent = g_enterprise
#                                             AND pmdqdocno = p_pmdn.pmdndocno
#                                             AND pmdqseq = p_pmdn.pmdnseq
   #mark--161109-00085#14 By 08993--(e)
   #161109-00085#61 --s mark
   #DECLARE apsp610_03_pmdq_cs2 CURSOR FOR SELECT pmdqent,pmdqsite,pmdqdocno,pmdqseq,pmdqseq2,pmdq002,pmdq003,pmdq004,pmdq005,pmdq006,pmdq007,
   #                                              pmdq008,pmdq201,pmdq202,pmdq900,pmdq999
   #161109-00085#61 --e mark
   #161109-00085#61 --s add
   DECLARE apsp610_03_pmdq_cs2 CURSOR FOR SELECT pmdqent,pmdqsite,pmdqdocno,pmdqseq,pmdqseq2,
                                                 pmdq002,pmdq003,pmdq004,pmdq005,pmdq006,
                                                 pmdq007,pmdq008,pmdq201,pmdq202,pmdq900,
                                                 pmdq999,pmdqud001,pmdqud002,pmdqud003,pmdqud004,
                                                 pmdqud005,pmdqud006,pmdqud007,pmdqud008,pmdqud009,
                                                 pmdqud010,pmdqud011,pmdqud012,pmdqud013,pmdqud014,
                                                 pmdqud015,pmdqud016,pmdqud017,pmdqud018,pmdqud019,
                                                 pmdqud020,pmdqud021,pmdqud022,pmdqud023,pmdqud024,
                                                 pmdqud025,pmdqud026,pmdqud027,pmdqud028,pmdqud029,
                                                 pmdqud030
   #161109-00085#61 --e add
                                            FROM pmdq_t
                                           WHERE pmdqent = g_enterprise
                                             AND pmdqdocno = p_pmdn.pmdndocno
                                             AND pmdqseq = p_pmdn.pmdnseq 
   #mod--161109-00085#14 By 08993--(e)                                         
   #FOREACH apsp610_03_pmdq_cs2 INTO l_pmdq.* #161109-00085#61 mark
   #161109-00085#61 --s add
   FOREACH apsp610_03_pmdq_cs2 INTO l_pmdq.pmdqent,l_pmdq.pmdqsite,l_pmdq.pmdqdocno,l_pmdq.pmdqseq,l_pmdq.pmdqseq2,
                                    l_pmdq.pmdq002,l_pmdq.pmdq003,l_pmdq.pmdq004,l_pmdq.pmdq005,l_pmdq.pmdq006,
                                    l_pmdq.pmdq007,l_pmdq.pmdq008,l_pmdq.pmdq201,l_pmdq.pmdq202,l_pmdq.pmdq900,
                                    l_pmdq.pmdq999,l_pmdq.pmdqud001,l_pmdq.pmdqud002,l_pmdq.pmdqud003,l_pmdq.pmdqud004,
                                    l_pmdq.pmdqud005,l_pmdq.pmdqud006,l_pmdq.pmdqud007,l_pmdq.pmdqud008,l_pmdq.pmdqud009,
                                    l_pmdq.pmdqud010,l_pmdq.pmdqud011,l_pmdq.pmdqud012,l_pmdq.pmdqud013,l_pmdq.pmdqud014,
                                    l_pmdq.pmdqud015,l_pmdq.pmdqud016,l_pmdq.pmdqud017,l_pmdq.pmdqud018,l_pmdq.pmdqud019,
                                    l_pmdq.pmdqud020,l_pmdq.pmdqud021,l_pmdq.pmdqud022,l_pmdq.pmdqud023,l_pmdq.pmdqud024,
                                    l_pmdq.pmdqud025,l_pmdq.pmdqud026,l_pmdq.pmdqud027,l_pmdq.pmdqud028,l_pmdq.pmdqud029,
                                    l_pmdq.pmdqud030
   #161109-00085#61 --e add
      LET l_pmdo.pmdoseq2 = l_pmdq.pmdqseq2 #分批序
      #LET l_pmdo.pmdo006 = l_pmdq.pmdq002 * 取得的QPA   #分批採購量
      LET l_pmdo.pmdo007 = l_pmdq.pmdq002   #折核主件數量
      LET l_pmdo.pmdo010 = l_pmdq.pmdq006   #出貨時段
      LET l_pmdo.pmdo011 = l_pmdq.pmdq003   #出貨日期
      LET l_pmdo.pmdo012 = l_pmdq.pmdq004   #到廠日期
      LET l_pmdo.pmdo013 = l_pmdq.pmdq005   #到庫日期
      LET l_pmdo.pmdo014 = l_pmdq.pmdq007   #MRP凍結否

      #計算金額 分批數量/總數量 * 金額
      LET l_pmdo.pmdo032 = l_pmdq.pmdq002 / l_pmdo.pmdo005 * p_pmdn.pmdn046  #分批未稅金額
      LET l_pmdo.pmdo033 = l_pmdq.pmdq002 / l_pmdo.pmdo005 * p_pmdn.pmdn047  #分批含稅金額
      LET l_pmdo.pmdo034 = l_pmdq.pmdq002 / l_pmdo.pmdo005 * p_pmdn.pmdn048  #分批稅金額 
      INSERT INTO p610_03_pmdo_t(pmdoent,pmdoseq,pmdoseq1,pmdoseq2,pmdosite,pmdo001,pmdo002,
                                 pmdo003,pmdo004,pmdo005,pmdo006,pmdo007,pmdo008,pmdo009,
                                 pmdo010,pmdo011,pmdo012,pmdo013,pmdo014,pmdo015,pmdo016,
                                 pmdo017,pmdo019,pmdo020,pmdo021,pmdo022,pmdo023,pmdo024,
                                 pmdo025,pmdo026,pmdo027,pmdo028,pmdo029,pmdo030,pmdo031,
                                 pmdo032,pmdo033,pmdo034,pmdl004)
                          VALUES(l_pmdo.pmdoent,l_pmdo.pmdoseq,l_pmdo.pmdoseq1,l_pmdo.pmdoseq2,
                                 l_pmdo.pmdosite,l_pmdo.pmdo001,l_pmdo.pmdo002,l_pmdo.pmdo003,
                                 l_pmdo.pmdo004,l_pmdo.pmdo005,l_pmdo.pmdo006,l_pmdo.pmdo007,
                                 l_pmdo.pmdo008,l_pmdo.pmdo009,l_pmdo.pmdo010,l_pmdo.pmdo011,
                                 l_pmdo.pmdo012,l_pmdo.pmdo013,l_pmdo.pmdo014,l_pmdo.pmdo015,
                                 l_pmdo.pmdo016,l_pmdo.pmdo017,l_pmdo.pmdo019,l_pmdo.pmdo020,
                                 l_pmdo.pmdo021,l_pmdo.pmdo022,l_pmdo.pmdo023,l_pmdo.pmdo024,
                                 l_pmdo.pmdo025,l_pmdo.pmdo026,l_pmdo.pmdo027,l_pmdo.pmdo028,
                                 l_pmdo.pmdo029,l_pmdo.pmdo030,l_pmdo.pmdo031,l_pmdo.pmdo032,
                                 l_pmdo.pmdo033,l_pmdo.pmdo034,p_pmdl004) 
      #若該採購單明細有設置備品率時，應自動在產生一筆備品的交期明細資料
      IF NOT cl_null(p_pmdn.pmdn033) AND p_pmdn.pmdn033 <> 0 THEN
         SELECT MAX(pmdoseq1)+1 INTO l_pmdo.pmdoseq1
           FROM p610_03_pmdo_t
          WHERE pmdoent = g_enterprise
            AND pmdl004 = p_pmdl004
            AND pmdoseq = l_pmdo.pmdoseq
         IF cl_null(l_pmdo.pmdoseq1) OR l_pmdo.pmdoseq1 = 0 THEN
            LET l_pmdo.pmdoseq1 = 1
         END IF

         LET l_pmdo.pmdo003 = '6'        #子件特性
         #LET l_pmdo.pmdo005 = pmdn007*(l_pmdn.pmdn033/100)*取得的QPA  #採購總量
         #LET l_pmdo.pmdo006 = pmdq002*(l_pmdn.pmdn033/100)*取得的QPA  #分批採購量
         LET l_pmdo.pmdo007 = l_pmdq.pmdq002 * p_pmdn.pmdn033  #折核主件數量
         LET l_pmdo.pmdo022 = 0          #參考價格
         LET l_pmdo.pmdo032 = 0          #分批未稅金額 
         LET l_pmdo.pmdo033 = 0          #分批含稅金額
         LET l_pmdo.pmdo034 = 0          #分批稅金額
         INSERT INTO p610_03_pmdo_t(pmdoent,pmdoseq,pmdoseq1,pmdoseq2,pmdosite,pmdo001,pmdo002,
                                    pmdo003,pmdo004,pmdo005,pmdo006,pmdo007,pmdo008,pmdo009,
                                    pmdo010,pmdo011,pmdo012,pmdo013,pmdo014,pmdo015,pmdo016,
                                    pmdo017,pmdo019,pmdo020,pmdo021,pmdo022,pmdo023,pmdo024,
                                    pmdo025,pmdo026,pmdo027,pmdo028,pmdo029,pmdo030,pmdo031,
                                    pmdo032,pmdo033,pmdo034,pmdl004)
                             VALUES(l_pmdo.pmdoent,l_pmdo.pmdoseq,l_pmdo.pmdoseq1,l_pmdo.pmdoseq2,
                                    l_pmdo.pmdosite,l_pmdo.pmdo001,l_pmdo.pmdo002,l_pmdo.pmdo003,
                                    l_pmdo.pmdo004,l_pmdo.pmdo005,l_pmdo.pmdo006,l_pmdo.pmdo007,
                                    l_pmdo.pmdo008,l_pmdo.pmdo009,l_pmdo.pmdo010,l_pmdo.pmdo011,
                                    l_pmdo.pmdo012,l_pmdo.pmdo013,l_pmdo.pmdo014,l_pmdo.pmdo015, 
                                    l_pmdo.pmdo016,l_pmdo.pmdo017,l_pmdo.pmdo019,l_pmdo.pmdo020,
                                    l_pmdo.pmdo021,l_pmdo.pmdo022,l_pmdo.pmdo023,l_pmdo.pmdo024,
                                    l_pmdo.pmdo025,l_pmdo.pmdo026,l_pmdo.pmdo027,l_pmdo.pmdo028,
                                    l_pmdo.pmdo029,l_pmdo.pmdo030,l_pmdo.pmdo031,l_pmdo.pmdo032,
                                    l_pmdo.pmdo033,l_pmdo.pmdo034,p_pmdl004)


      END IF
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsp610_03_get_imaal(p_imaal001)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_03_get_imaal(p_imaal001)
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
# Usage..........: CALL apsp610_03_pmdn001_chk(p_pmdn001,p_pmdnseq,p_pmdl004,p_pmdn002)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_03_pmdn001_chk(p_pmdn001,p_pmdnseq,p_pmdl004,p_pmdn002)
   DEFINE p_pmdn001     LIKE pmdn_t.pmdn001
   DEFINE p_pmdnseq     LIKE pmdn_t.pmdnseq
   DEFINE p_pmdl004     LIKE pmdl_t.pmdl004 
   DEFINE p_pmdn002     LIKE pmdn_t.pmdn002

   DEFINE l_pmdp007     LIKE pmdp_t.pmdp007 
   DEFINE l_pmdp008     LIKE pmdp_t.pmdp008
   DEFINE l_flag        LIKE type_t.num5
   DEFINE l_success     LIKE type_t.num5
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

      #整合檢查 
      CALL s_control_check_item(p_pmdn001,'4',g_site,g_user,g_dept,g_apsp610_01_input.pmdldocno)
           RETURNING l_success
      IF NOT l_success THEN
         LET r_success = l_success
         RETURN r_success
      END IF

      #若單據別設置是要作請採勾稽時，則修改料號時必須檢核是否與"關聯單據明細"中的來源料號有替代關係
      IF cl_get_doc_para(g_enterprise,g_site,g_apsp610_01_input.pmdldocno,'D-BAS-0061') = "Y" THEN 
         DECLARE apsp610_03_pmdp007_curs CURSOR FOR SELECT DISTINCT pmdp007,pmdp008
                                                      FROM p610_tmp03       #160727-00019#15 Mod   p610_03_pmdp_rel_t -->p610_tmp03
                                                     WHERE pmdl004 = p_pmdl004
                                                       AND pmdpseq = p_pmdnseq
         FOREACH apsp610_03_pmdp007_curs INTO l_pmdp007,l_pmdp008
            IF l_pmdp007 <> p_pmdn001 THEN
               #add by lixiang 2015/07/16----s------
               #請採購替代是否依據BOM替代資料
               #選Y時，代表請購轉採購時可以依據BOM替代資料進行採購料的替代
               #若選N，則是依據apmi131採購替代原則的設定進行採購料的替代
               IF cl_get_doc_para(g_enterprise,g_site,g_apsp610_01_input.pmdldocno,'D-BAS-0096') = "Y" THEN
                  IF NOT s_apmt500_chk_bom_replace(l_pmdp007,p_pmdn001,p_pmdn002) THEN
                     LET r_success = FALSE
                     RETURN r_success
                  END IF
               ELSE      
               #add by lixiang 2015/07/16----e------
                  IF NOT s_pmaq_chk_replacement(p_pmdl004,l_pmdp007,p_pmdn001,'2',l_pmdp008,p_pmdn002) THEN
                     LET r_success = FALSE
                     RETURN r_success
                  END IF
               END IF
            END IF
         END FOREACH
      END IF

   END IF
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsp610_03_pmdn_b_fill(p_keyno,p_pmdl004,p_pmdldocno)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........: 160512-00016#5  2016/06/01 by ming 加入保稅
################################################################################
PUBLIC FUNCTION apsp610_03_pmdn_b_fill(p_keyno,p_pmdl004,p_pmdl025,p_pmdl026,p_pmdldocno)
   DEFINE p_keyno     LIKE type_t.num10
   DEFINE p_pmdl004   LIKE pmdl_t.pmdl004 
   DEFINE p_pmdl025   LIKE pmdl_t.pmdl025
   DEFINE p_pmdl026   LIKE pmdl_t.pmdl026
   DEFINE p_pmdldocno LIKE pmdl_t.pmdldocno
   DEFINE l_sql       STRING
   DEFINE l_pmdn_tmp  type_g_pmdn_d 
   
   WHENEVER ERROR CONTINUE 

   #160601-00032#3 20160613 modify by ming -----(S) 
   ##160512-00016#5 20160601 modify by ming -----(S) 
   ##LET l_sql = "SELECT pmdnseq,pmdn001,pmdn002,pmdn006,pmdn007, ",
   ##            "       pmdn008,pmdn009,pmdn010,pmdn011,pmdn012,pmdn013, ",
   ##            "       pmdn014,pmdn015,pmdn050 ",
   ##            "  FROM p610_03_pmdn_rel_t ",
   ##            " WHERE pmdl004 = '",p_pmdl004,"' ",
   ##            "   AND NVL(pmdl025,' ') = NVL('",p_pmdl025,"',' ') ",
   ##            "   AND NVL(pmdl026,' ') = NVL('",p_pmdl026,"',' ') " 
   #LET l_sql = "SELECT pmdnseq,pmdn001,pmdn002,pmdn021,pmdn006,pmdn007, ",
   #            "       pmdn008,pmdn009,pmdn010,pmdn011,pmdn012,pmdn013, ",
   #            "       pmdn014,pmdn015,pmdn050 ",
   #            "  FROM p610_03_pmdn_rel_t ",
   #            " WHERE pmdl004 = '",p_pmdl004,"' ",
   #            "   AND NVL(pmdl025,' ') = NVL('",p_pmdl025,"',' ') ",
   #            "   AND NVL(pmdl026,' ') = NVL('",p_pmdl026,"',' ') " 
   ##160512-00016#5 20160601 modify by ming -----(E) 
   LET l_sql = "SELECT pmdnseq,pmdn001,pmdn002,pmdn021,pmdn006,pmdn007, ",
               "       pmdn008,pmdn009,pmdn010,pmdn011,pmdn012,pmdn013, ",
               "       pmdn014,pmdn015,pmdn050,pmdn053 ",
               "  FROM p610_tmp02 ",         #160727-00019#15 Mod   p610_03_pmdn_rel_t -->p610_tmp02
               " WHERE pmdl004 = '",p_pmdl004,"' ",
               "   AND NVL(pmdl025,' ') = NVL('",p_pmdl025,"',' ') ",
               "   AND NVL(pmdl026,' ') = NVL('",p_pmdl026,"',' ') "
   #160601-00032#3 20160613 modify by ming -----(E) 
   PREPARE apsp610_03_pmdn_b_fill_prep FROM l_sql
   DECLARE apsp610_03_pmdn_b_fill_curs CURSOR WITH HOLD FOR apsp610_03_pmdn_b_fill_prep

   INITIALIZE l_pmdn_tmp.* TO NULL
   #160601-00032#3 20160613 modify by ming -----(S) 
   ##160512-00016#5 20160601 modify by ming -----(S) 
   ##FOREACH apsp610_03_pmdn_b_fill_curs INTO l_pmdn_tmp.pmdnseq_03_02,l_pmdn_tmp.pmdn001_03_02,
   ##                                         l_pmdn_tmp.pmdn002_03_02,l_pmdn_tmp.pmdn006_03_02,
   ##                                         l_pmdn_tmp.pmdn007_03_02,l_pmdn_tmp.pmdn008_03_02,
   ##                                         l_pmdn_tmp.pmdn009_03_02,l_pmdn_tmp.pmdn010_03_02,
   ##                                         l_pmdn_tmp.pmdn011_03_02,l_pmdn_tmp.pmdn012_03_02,
   ##                                         l_pmdn_tmp.pmdn013_03_02,l_pmdn_tmp.pmdn014_03_02,
   ##                                         l_pmdn_tmp.pmdn015_03_02,l_pmdn_tmp.pmdn050_03_02 
   #FOREACH apsp610_03_pmdn_b_fill_curs INTO l_pmdn_tmp.pmdnseq_03_02,l_pmdn_tmp.pmdn001_03_02,
   #                                         l_pmdn_tmp.pmdn002_03_02, 
   #                                         l_pmdn_tmp.pmdn021_03_02, 
   #                                         l_pmdn_tmp.pmdn006_03_02,
   #                                         l_pmdn_tmp.pmdn007_03_02,l_pmdn_tmp.pmdn008_03_02,
   #                                         l_pmdn_tmp.pmdn009_03_02,l_pmdn_tmp.pmdn010_03_02,
   #                                         l_pmdn_tmp.pmdn011_03_02,l_pmdn_tmp.pmdn012_03_02,
   #                                         l_pmdn_tmp.pmdn013_03_02,l_pmdn_tmp.pmdn014_03_02,
   #                                         l_pmdn_tmp.pmdn015_03_02,l_pmdn_tmp.pmdn050_03_02 
   ##160512-00016#5 20160601 modify by ming -----(E) 
   FOREACH apsp610_03_pmdn_b_fill_curs INTO l_pmdn_tmp.pmdnseq_03_02,l_pmdn_tmp.pmdn001_03_02,
                                            l_pmdn_tmp.pmdn002_03_02,
                                            l_pmdn_tmp.pmdn021_03_02,
                                            l_pmdn_tmp.pmdn006_03_02,
                                            l_pmdn_tmp.pmdn007_03_02,l_pmdn_tmp.pmdn008_03_02,
                                            l_pmdn_tmp.pmdn009_03_02,l_pmdn_tmp.pmdn010_03_02,
                                            l_pmdn_tmp.pmdn011_03_02,l_pmdn_tmp.pmdn012_03_02,
                                            l_pmdn_tmp.pmdn013_03_02,l_pmdn_tmp.pmdn014_03_02,
                                            l_pmdn_tmp.pmdn015_03_02,l_pmdn_tmp.pmdn050_03_02,
                                            l_pmdn_tmp.pmdn053_03_02
   #160601-00032#3 20160613 modify by ming -----(E) 
      IF STATUS THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.code   = STATUS
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      #160601-00032#3 20160613 modify by ming -----(S) 
      ##160512-00016#5 20160601 modify by ming -----(S) 
      ##INSERT INTO p610_04_pmdn_t VALUES(p_keyno,p_pmdldocno,l_pmdn_tmp.pmdnseq_03_02,
      ##                                  l_pmdn_tmp.pmdn001_03_02,l_pmdn_tmp.pmdn002_03_02,
      ##                                  l_pmdn_tmp.pmdn006_03_02,l_pmdn_tmp.pmdn007_03_02,
      ##                                  l_pmdn_tmp.pmdn008_03_02,l_pmdn_tmp.pmdn009_03_02,
      ##                                  l_pmdn_tmp.pmdn010_03_02,l_pmdn_tmp.pmdn011_03_02,
      ##                                  l_pmdn_tmp.pmdn012_03_02,l_pmdn_tmp.pmdn013_03_02,
      ##                                  l_pmdn_tmp.pmdn014_03_02,l_pmdn_tmp.pmdn015_03_02,
      ##                                  l_pmdn_tmp.pmdn050_03_02) 
      #INSERT INTO p610_04_pmdn_t VALUES(p_keyno,p_pmdldocno,l_pmdn_tmp.pmdnseq_03_02,
      #                                  l_pmdn_tmp.pmdn001_03_02,l_pmdn_tmp.pmdn002_03_02,
      #                                  l_pmdn_tmp.pmdn021_03_02, 
      #                                  l_pmdn_tmp.pmdn006_03_02,
      #                                  l_pmdn_tmp.pmdn007_03_02,
      #                                  l_pmdn_tmp.pmdn008_03_02,l_pmdn_tmp.pmdn009_03_02,
      #                                  l_pmdn_tmp.pmdn010_03_02,l_pmdn_tmp.pmdn011_03_02,
      #                                  l_pmdn_tmp.pmdn012_03_02,l_pmdn_tmp.pmdn013_03_02,
      #                                  l_pmdn_tmp.pmdn014_03_02,l_pmdn_tmp.pmdn015_03_02,
      #                                  l_pmdn_tmp.pmdn050_03_02) 
      ##160512-00016#5 20160601 modify by ming -----(E) 
      INSERT INTO p610_04_pmdn_t VALUES(p_keyno,p_pmdldocno,l_pmdn_tmp.pmdnseq_03_02,
                                        l_pmdn_tmp.pmdn001_03_02,l_pmdn_tmp.pmdn002_03_02,
                                        l_pmdn_tmp.pmdn021_03_02,
                                        l_pmdn_tmp.pmdn006_03_02,
                                        l_pmdn_tmp.pmdn007_03_02,
                                        l_pmdn_tmp.pmdn008_03_02,l_pmdn_tmp.pmdn009_03_02,
                                        l_pmdn_tmp.pmdn010_03_02,l_pmdn_tmp.pmdn011_03_02,
                                        l_pmdn_tmp.pmdn012_03_02,l_pmdn_tmp.pmdn013_03_02,
                                        l_pmdn_tmp.pmdn014_03_02,l_pmdn_tmp.pmdn015_03_02,
                                        l_pmdn_tmp.pmdn050_03_02,l_pmdn_tmp.pmdn053_03_02)
      #160601-00032#3 20160613 modify by ming -----(E) 
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsp610_03_ins_pmdq(p_keyno,p_pmdl004,p_pmdldocno)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_03_ins_pmdq(p_keyno,p_pmdl004,p_pmdl025,p_pmdl026,p_pmdldocno)
   DEFINE p_keyno     LIKE type_t.num10
   DEFINE p_pmdl004   LIKE pmdl_t.pmdl004 
   DEFINE p_pmdl025   LIKE pmdl_t.pmdl025
   DEFINE p_pmdl026   LIKE pmdl_t.pmdl026
   DEFINE p_pmdldocno LIKE pmdl_t.pmdldocno
   DEFINE l_sql       STRING
   #mod--161109-00085#14 By 08993--(s)
#   DEFINE l_pmdq          RECORD LIKE pmdq_t.*   #mark--161109-00085#14 By 08993--(s)
   DEFINE l_pmdq RECORD  #採購多交期匯總檔
          pmdqent LIKE pmdq_t.pmdqent, #企業編號
          pmdqsite LIKE pmdq_t.pmdqsite, #營運據點
          pmdqdocno LIKE pmdq_t.pmdqdocno, #採購單號
          pmdqseq LIKE pmdq_t.pmdqseq, #採購項次
          pmdqseq2 LIKE pmdq_t.pmdqseq2, #分批序
          pmdq002 LIKE pmdq_t.pmdq002, #分批數量
          pmdq003 LIKE pmdq_t.pmdq003, #交貨日期
          pmdq004 LIKE pmdq_t.pmdq004, #到廠日期
          pmdq005 LIKE pmdq_t.pmdq005, #到庫日期
          pmdq006 LIKE pmdq_t.pmdq006, #收貨時段
          pmdq007 LIKE pmdq_t.pmdq007, #MRP凍結否
          pmdq008 LIKE pmdq_t.pmdq008, #交期類型
          pmdq201 LIKE pmdq_t.pmdq201, #分批包裝單位
          pmdq202 LIKE pmdq_t.pmdq202, #分批包裝數量
          pmdq900 LIKE pmdq_t.pmdq900, #保留欄位str
         #pmdq999 LIKE pmdq_t.pmdq999  #保留欄位end #161109-00085#61 mark
          #161109-00085#61 --s add
          pmdq999 LIKE pmdq_t.pmdq999, #保留欄位end
          pmdqud001 LIKE pmdq_t.pmdqud001, #自定義欄位(文字)001
          pmdqud002 LIKE pmdq_t.pmdqud002, #自定義欄位(文字)002
          pmdqud003 LIKE pmdq_t.pmdqud003, #自定義欄位(文字)003
          pmdqud004 LIKE pmdq_t.pmdqud004, #自定義欄位(文字)004
          pmdqud005 LIKE pmdq_t.pmdqud005, #自定義欄位(文字)005
          pmdqud006 LIKE pmdq_t.pmdqud006, #自定義欄位(文字)006
          pmdqud007 LIKE pmdq_t.pmdqud007, #自定義欄位(文字)007
          pmdqud008 LIKE pmdq_t.pmdqud008, #自定義欄位(文字)008
          pmdqud009 LIKE pmdq_t.pmdqud009, #自定義欄位(文字)009
          pmdqud010 LIKE pmdq_t.pmdqud010, #自定義欄位(文字)010
          pmdqud011 LIKE pmdq_t.pmdqud011, #自定義欄位(數字)011
          pmdqud012 LIKE pmdq_t.pmdqud012, #自定義欄位(數字)012
          pmdqud013 LIKE pmdq_t.pmdqud013, #自定義欄位(數字)013
          pmdqud014 LIKE pmdq_t.pmdqud014, #自定義欄位(數字)014
          pmdqud015 LIKE pmdq_t.pmdqud015, #自定義欄位(數字)015
          pmdqud016 LIKE pmdq_t.pmdqud016, #自定義欄位(數字)016
          pmdqud017 LIKE pmdq_t.pmdqud017, #自定義欄位(數字)017
          pmdqud018 LIKE pmdq_t.pmdqud018, #自定義欄位(數字)018
          pmdqud019 LIKE pmdq_t.pmdqud019, #自定義欄位(數字)019
          pmdqud020 LIKE pmdq_t.pmdqud020, #自定義欄位(數字)020
          pmdqud021 LIKE pmdq_t.pmdqud021, #自定義欄位(日期時間)021
          pmdqud022 LIKE pmdq_t.pmdqud022, #自定義欄位(日期時間)022
          pmdqud023 LIKE pmdq_t.pmdqud023, #自定義欄位(日期時間)023
          pmdqud024 LIKE pmdq_t.pmdqud024, #自定義欄位(日期時間)024
          pmdqud025 LIKE pmdq_t.pmdqud025, #自定義欄位(日期時間)025
          pmdqud026 LIKE pmdq_t.pmdqud026, #自定義欄位(日期時間)026
          pmdqud027 LIKE pmdq_t.pmdqud027, #自定義欄位(日期時間)027
          pmdqud028 LIKE pmdq_t.pmdqud028, #自定義欄位(日期時間)028
          pmdqud029 LIKE pmdq_t.pmdqud029, #自定義欄位(日期時間)029
          pmdqud030 LIKE pmdq_t.pmdqud030  #自定義欄位(日期時間)030
          #161109-00085#61 --e add
   END RECORD  
   #mod--161109-00085#14 By 08993--(e) 
   
   WHENEVER ERROR CONTINUE 

   LET l_sql = "SELECT pmdqent,pmdqsite,pmdqseq,pmdqseq2,pmdq002,pmdq003, ",
               "       pmdq004,pmdq005,pmdq006,pmdq007 ",
               "  FROM p610_03_pmdq_t ",
               " WHERE pmdl004 = '",p_pmdl004,"' ", 
               "   AND NVL(pmdl025,' ') = NVL('",p_pmdl025,"',' ') ",
               "   AND NVL(pmdl026,' ') = NVL('",p_pmdl026,"',' ') ",
               " ORDER BY pmdqseq "

   PREPARE apsp610_03_ins_pmdq_prep FROM l_sql
   DECLARE apsp610_03_ins_pmdq_curs CURSOR WITH HOLD FOR apsp610_03_ins_pmdq_prep

   INITIALIZE l_pmdq.* TO NULL

   FOREACH apsp610_03_ins_pmdq_curs INTO l_pmdq.pmdqent,l_pmdq.pmdqsite,l_pmdq.pmdqseq,
                                         l_pmdq.pmdqseq2,l_pmdq.pmdq002,l_pmdq.pmdq003,
                                         l_pmdq.pmdq004,l_pmdq.pmdq005,l_pmdq.pmdq006,
                                         l_pmdq.pmdq007
      IF STATUS THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.code   = STATUS
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      LET l_pmdq.pmdqdocno = p_pmdldocno

      #mod--161109-00085#14 By 08993--(s)
#      INSERT INTO pmdq_t VALUES(l_pmdq.*)   #mark--161109-00085#14 By 08993--(s)
      #161109-00085#61 --s mark
      #INSERT INTO pmdq_t(pmdqent,pmdqsite,pmdqdocno,pmdqseq,pmdqseq2,pmdq002,pmdq003,pmdq004,pmdq005,pmdq006,pmdq007,
      #                   pmdq008,pmdq201,pmdq202,pmdq900,pmdq999) 
      #            VALUES(l_pmdq.pmdqent,l_pmdq.pmdqsite,l_pmdq.pmdqdocno,l_pmdq.pmdqseq,l_pmdq.pmdqseq2,l_pmdq.pmdq002,
      #                   l_pmdq.pmdq003,l_pmdq.pmdq004,l_pmdq.pmdq005,l_pmdq.pmdq006,l_pmdq.pmdq007,l_pmdq.pmdq008,l_pmdq.pmdq201,
      #                   l_pmdq.pmdq202,l_pmdq.pmdq900,l_pmdq.pmdq999)
      #161109-00085#61 --e mark
      #mod--161109-00085#14 By 08993--(e)
      #161109-00085#61 --s add
      INSERT INTO pmdq_t(pmdqent,pmdqsite,pmdqdocno,pmdqseq,pmdqseq2,
                         pmdq002,pmdq003,pmdq004,pmdq005,pmdq006,
                         pmdq007,pmdq008,pmdq201,pmdq202,pmdq900,
                         pmdq999,pmdqud001,pmdqud002,pmdqud003,pmdqud004,
                         pmdqud005,pmdqud006,pmdqud007,pmdqud008,pmdqud009,
                         pmdqud010,pmdqud011,pmdqud012,pmdqud013,pmdqud014,
                         pmdqud015,pmdqud016,pmdqud017,pmdqud018,pmdqud019,
                         pmdqud020,pmdqud021,pmdqud022,pmdqud023,pmdqud024,
                         pmdqud025,pmdqud026,pmdqud027,pmdqud028,pmdqud029,
                         pmdqud030)
      VALUES(l_pmdq.pmdqent,l_pmdq.pmdqsite,l_pmdq.pmdqdocno,l_pmdq.pmdqseq,l_pmdq.pmdqseq2,
             l_pmdq.pmdq002,l_pmdq.pmdq003,l_pmdq.pmdq004,l_pmdq.pmdq005,l_pmdq.pmdq006,
             l_pmdq.pmdq007,l_pmdq.pmdq008,l_pmdq.pmdq201,l_pmdq.pmdq202,l_pmdq.pmdq900,
             l_pmdq.pmdq999,l_pmdq.pmdqud001,l_pmdq.pmdqud002,l_pmdq.pmdqud003,l_pmdq.pmdqud004,
             l_pmdq.pmdqud005,l_pmdq.pmdqud006,l_pmdq.pmdqud007,l_pmdq.pmdqud008,l_pmdq.pmdqud009,
             l_pmdq.pmdqud010,l_pmdq.pmdqud011,l_pmdq.pmdqud012,l_pmdq.pmdqud013,l_pmdq.pmdqud014,
             l_pmdq.pmdqud015,l_pmdq.pmdqud016,l_pmdq.pmdqud017,l_pmdq.pmdqud018,l_pmdq.pmdqud019,
             l_pmdq.pmdqud020,l_pmdq.pmdqud021,l_pmdq.pmdqud022,l_pmdq.pmdqud023,l_pmdq.pmdqud024,
             l_pmdq.pmdqud025,l_pmdq.pmdqud026,l_pmdq.pmdqud027,l_pmdq.pmdqud028,l_pmdq.pmdqud029,
             l_pmdq.pmdqud030)
      #161109-00085#61 --e add
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsp610_03_pmdp_b_fill(p_keyno,p_pmdl004,p_pmdldocno)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_03_pmdp_b_fill(p_keyno,p_pmdl004,p_pmdl025,p_pmdl026,p_pmdldocno)
   DEFINE p_keyno     LIKE type_t.num10
   DEFINE p_pmdl004   LIKE pmdl_t.pmdl004
   DEFINE p_pmdl025   LIKE pmdl_t.pmdl025
   DEFINE p_pmdl026   LIKE pmdl_t.pmdl026
   DEFINE p_pmdldocno LIKE pmdl_t.pmdldocno
   DEFINE l_sql       STRING
   DEFINE l_pmdp_tmp  type_g_pmdp_d 
   
   WHENEVER ERROR CONTINUE 

   LET l_sql = "SELECT pmdpseq,pmdpseq1,pmdp001,'','',pspc004,pmdp004, ",
               "       pmdp007,'','',pmdp008,'',pmdp021,pmdp022,pmdp023, ",
               "       pmdp024,pspc045,pmdb033 ",
               "  FROM p610_tmp03 ",     #160727-00019#15 Mod   p610_03_pmdp_rel_t -->p610_tmp03
               " WHERE pmdl004 = '",p_pmdl004,"' ", 
               "   AND NVL(pmdl025,' ') = NVL('",p_pmdl025,"',' ') ",
               "   AND NVL(pmdl026,' ') = NVL('",p_pmdl026,"',' ') "
   PREPARE apsp610_03_pmdp_b_fill_prep FROM l_sql
   DECLARE apsp610_03_pmdp_b_fill_curs CURSOR WITH HOLD FOR apsp610_03_pmdp_b_fill_prep

   INITIALIZE l_pmdp_tmp.* TO NULL

   #FOREACH apsp610_03_pmdp_b_fill_curs INTO l_pmdp_tmp.* #161109-00085#61 mark
   #161109-00085#61 --s add
   FOREACH apsp610_03_pmdp_b_fill_curs INTO l_pmdp_tmp.pmdpseq_03_03,l_pmdp_tmp.pmdpseq1_03_03,l_pmdp_tmp.pmdp001_03_03,l_pmdp_tmp.imaal003_03_03_1,l_pmdp_tmp.imaal004_03_03_1,  
                                            l_pmdp_tmp.pspc004_03_03,l_pmdp_tmp.pmdp004_03_03,l_pmdp_tmp.pmdp007_03_03,l_pmdp_tmp.imaal003_03_03_2,l_pmdp_tmp.imaal004_03_03_2,  
                                            l_pmdp_tmp.pmdp008_03_03,l_pmdp_tmp.pmdp008_03_03_desc,l_pmdp_tmp.pmdp021_03_03,l_pmdp_tmp.pmdp022_03_03,l_pmdp_tmp.pmdp023_03_03,     
                                            l_pmdp_tmp.pmdp024_03_03,l_pmdp_tmp.pspc045_03_03,l_pmdp_tmp.pmdb033_03_03,l_pmdp_tmp.pmdl004_03_03
   #161109-00085#61 --e add
      IF STATUS THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.code   = STATUS
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      INSERT INTO p610_04_pmdp_t VALUES(p_keyno,p_pmdldocno,l_pmdp_tmp.pmdpseq_03_03,
                                        l_pmdp_tmp.pmdpseq1_03_03,l_pmdp_tmp.pmdp001_03_03,
                                        l_pmdp_tmp.pspc004_03_03,l_pmdp_tmp.pmdp004_03_03,
                                        l_pmdp_tmp.pmdp007_03_03,l_pmdp_tmp.pmdp008_03_03,
                                        l_pmdp_tmp.pmdp021_03_03,l_pmdp_tmp.pmdp022_03_03,
                                        l_pmdp_tmp.pmdp023_03_03,l_pmdp_tmp.pmdp024_03_03)
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsp610_03_pmdo_b_fill(p_keyno,p_pmdl004,p_pmdldocno)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_03_pmdo_b_fill(p_keyno,p_pmdl004,p_pmdl025,p_pmdl026,p_pmdldocno)
   DEFINE p_keyno     LIKE type_t.num10
   DEFINE p_pmdl004   LIKE pmdl_t.pmdl004 
   DEFINE p_pmdl025   LIKE pmdl_t.pmdl025
   DEFINE p_pmdl026   LIKE pmdl_t.pmdl026
   DEFINE p_pmdldocno LIKE pmdl_t.pmdldocno
   DEFINE l_sql       STRING
   DEFINE l_pmdo_tmp  type_g_pmdo_d 
   
   WHENEVER ERROR CONTINUE 

   LET l_sql = "SELECT pmdoseq,pmdoseq1,pmdo001,'','',pmdo002,'',pmdo004,pmdo005, ",
               "       pmdoseq2,pmdo006,pmdo009,pmdo011,pmdo012,pmdo013  ",
               "  FROM p610_03_pmdo_t ",
               " WHERE pmdl004 = '",p_pmdl004,"' ", 
               "   AND NVL(pmdl025,' ') = NVL('",p_pmdl025,"',' ') ",
               "   AND NVL(pmdl026,' ') = NVL('",p_pmdl026,"',' ') "
   PREPARE apsp610_03_pmdo_b_fill_prep FROM l_sql
   DECLARE apsp610_03_pmdo_b_fill_curs CURSOR WITH HOLD FOR apsp610_03_pmdo_b_fill_prep

   INITIALIZE l_pmdo_tmp.* TO NULL

   #FOREACH apsp610_03_pmdo_b_fill_curs INTO l_pmdo_tmp.* #161109-00085#61 mark
   #161109-00085#61 --s add
   FOREACH apsp610_03_pmdo_b_fill_curs INTO l_pmdo_tmp.pmdoseq_03_04,l_pmdo_tmp.pmdoseq1_03_04,l_pmdo_tmp.pmdo001_03_04,l_pmdo_tmp.imaal003_03_04,l_pmdo_tmp.imaal004_03_04,
                                            l_pmdo_tmp.pmdo002_03_04,l_pmdo_tmp.pmdo002_03_04_desc,l_pmdo_tmp.pmdo004_03_04,l_pmdo_tmp.pmdo005_03_04,l_pmdo_tmp.pmdoseq2_03_04,    
                                            l_pmdo_tmp.pmdo006_03_04,l_pmdo_tmp.pmdo009_03_04,l_pmdo_tmp.pmdo011_03_04,l_pmdo_tmp.pmdo012_03_04,l_pmdo_tmp.pmdo013_03_04
   #161109-00085#61 --e add
      IF STATUS THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = STATUS
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      INSERT INTO p610_04_pmdo_t VALUES(p_keyno,p_pmdldocno,l_pmdo_tmp.pmdoseq_03_04,
                                        l_pmdo_tmp.pmdoseq1_03_04,l_pmdo_tmp.pmdo001_03_04,
                                        l_pmdo_tmp.pmdo002_03_04,l_pmdo_tmp.pmdo004_03_04,
                                        l_pmdo_tmp.pmdo005_03_04,l_pmdo_tmp.pmdoseq2_03_04,
                                        l_pmdo_tmp.pmdo006_03_04,l_pmdo_tmp.pmdo011_03_04,
                                        l_pmdo_tmp.pmdo012_03_04,l_pmdo_tmp.pmdo013_03_04)
   END FOREACH
END FUNCTION

PUBLIC FUNCTION apsp610_03_pmdl009_ref(p_ooibl002)
   DEFINE p_ooibl002     LIKE ooibl_t.ooibl002
   DEFINE r_ooibl004     LIKE ooibl_t.ooibl004 
   
   WHENEVER ERROR CONTINUE 

   LET r_ooibl004 = ''
   SELECT ooibl004 INTO r_ooibl004
     FROM ooibl_t
    WHERE ooiblent = g_enterprise
      AND ooibl002 = p_ooibl002
      AND ooibl003 = g_dlang

   RETURN r_ooibl004
END FUNCTION

PUBLIC FUNCTION apsp610_03_pmdl010_ref(p_oocql002)
   DEFINE p_oocql002     LIKE oocql_t.oocql002
   DEFINE r_oocql004     LIKE oocql_t.oocql004 
   
   WHENEVER ERROR CONTINUE 

   LET r_oocql004 = ''
   SELECT oocql004 INTO r_oocql004
     FROM oocql_t
    WHERE oocqlent = g_enterprise
      AND oocql001 = '238'
      AND oocql002 = p_oocql002
      AND oocql003 = g_dlang

   RETURN r_oocql004
END FUNCTION

PUBLIC FUNCTION apsp610_03_pmdl011_ref(p_pmdl011)
   DEFINE p_pmdl011     LIKE pmdl_t.pmdl011
   DEFINE r_oodbl004    LIKE oodbl_t.oodbl004 
   
   WHENEVER ERROR CONTINUE 

   #獲得當前營運據點的所屬稅區
   LET g_ooef019 = ''
   SELECT ooef019 INTO g_ooef019
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site

   LET r_oodbl004 = ''
   CALL s_desc_get_tax_desc(g_ooef019,p_pmdl011) RETURNING r_oodbl004
   RETURN r_oodbl004
END FUNCTION

PUBLIC FUNCTION apsp610_03_pmdl015_ref(p_ooail001)
   DEFINE p_ooail001     LIKE ooail_t.ooail001
   DEFINE r_ooail003     LIKE ooail_t.ooail003 
   
   WHENEVER ERROR CONTINUE 

   LET r_ooail003 = ''
   SELECT ooail003 INTO r_ooail003
     FROM ooail_t
    WHERE ooailent = g_enterprise
      AND ooail001 = p_ooail001
      AND ooail002 = g_dlang

   RETURN r_ooail003
END FUNCTION

PUBLIC FUNCTION apsp610_03_pmdl017_ref(p_pmaml001)
   DEFINE p_pmaml001     LIKE pmaml_t.pmaml001
   DEFINE r_pmaml003     LIKE pmaml_t.pmaml003 
   
   WHENEVER ERROR CONTINUE 

   LET r_pmaml003 = ''
   SELECT pmaml003 INTO r_pmaml003
     FROM pmaml_t
    WHERE pmamlent = g_enterprise
      AND pmaml001 = p_pmaml001
      AND pmaml002 = g_dlang

   RETURN r_pmaml003
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsp610_03_set_entry_b(p_ac)
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_03_set_entry_b(p_ac)
  #DEFINE p_ac        LIKE type_t.num5     #170104-00066#1 17/01/05 mark by rainy 
   DEFINE p_ac        LIKE type_t.num10     #170104-00066#1 17/01/05 add by rainy 
   
   WHENEVER ERROR CONTINUE 

   CALL cl_set_comp_entry("pmdn002_03_02",TRUE)
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsp610_03_set_no_entry_b(p_ac)
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_03_set_no_entry_b(p_ac)
  #DEFINE p_ac          LIKE type_t.num5     #170104-00066#1 17/01/05 mark by rainy 
   DEFINE p_ac          LIKE type_t.num10     #170104-00066#1 17/01/05 add by rainy 
   DEFINE l_imaa005     LIKE imaa_t.imaa005 
   
   WHENEVER ERROR CONTINUE 

   #料件不使用產品特徵時，產品特徵欄位不可錄入 
   LET l_imaa005 = ''
   SELECT imaa005 INTO l_imaa005
     FROM imaa_t
    WHERE imaaent = g_enterprise
      AND imaa001 = g_pmdn_d[p_ac].pmdn001_03_02
   IF cl_null(l_imaa005) THEN
      CALL cl_set_comp_entry('pmdn002_03_02',FALSE)
      LET g_pmdn_d[p_ac].pmdn002_03_02 = ' '
   ELSE
      IF cl_null(g_pmdn_d[p_ac].pmdn002_03_02) THEN
         LET g_pmdn_d[p_ac].pmdn002_03_02 = ''
      END IF
   END IF
END FUNCTION

################################################################################
# Descriptions...: 單位轉換，統一寫在一個function之中，以後如果再有aimi190改aooi250的這種情況就不必改很多地方 
# Memo...........:
# Usage..........: CALL apsp610_03_convert_qty(p_imaa001,p_from_unit,p_to_unit,p_qty)
#                  RETURNING r_qty
# Input parameter: p_imaa001  ：料號 
#                : p_from_unit：來源單位 
#                : p_to_unit  ：目的單位 
#                : p_qty      ：數量 
# Return code....: r_qty      ：要回傳的結果 
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_03_convert_qty(p_imaa001,p_from_unit,p_to_unit,p_qty)
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
      LET g_errparam.code = 'sub-00015'     #沒有設定%1與%2的單位轉換資料
      LET g_errparam.extend = p_imaa001
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = p_from_unit
      LET g_errparam.replace[2] = p_to_unit
      CALL cl_err()
   END IF

   RETURN r_qty
END FUNCTION

################################################################################
# Descriptions...: 設定欄位開關
# Memo...........:
# Usage..........: CALL apsp610_03_set_entry()
# Date & Author..: 2016/01/22 By shiun 
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_03_set_entry()
   
   WHENEVER ERROR CONTINUE

   CALL cl_set_comp_entry("sscb01",TRUE)
   
END FUNCTION

################################################################################
# Descriptions...: 設定欄位開關
# Memo...........:
# Usage..........: CALL apsp610_03_set_no_entry()
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_03_set_no_entry()
   
   WHENEVER ERROR CONTINUE

   IF g_apsp610_02_input.scb02 = '3' THEN
      CALL cl_set_comp_entry("sscb01",FALSE)
   END IF
END FUNCTION

 
{</section>}
 
