#該程式未解開Section, 採用最新樣板產出!
{<section id="apsp610_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0010(2016-06-01 10:15:12), PR版次:0010(2017-02-13 17:00:46)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000033
#+ Filename...: apsp610_01
#+ Description: APS產生採購單作業_選擇範圍
#+ Creator....: 05384(2016-01-22 11:31:15)
#+ Modifier...: 03079 -SD/PR- 07024
 
{</section>}
 
{<section id="apsp610_01.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"
#160318-00025#1   2016/04/06  By 07675       將重複內容的錯誤訊息置換為公用錯誤訊息(r.v） 
#160512-00016#5   2016/06/01  By ming        增加欄位pspc062 保稅否 
#160606-00006#1   2016/06/14  By ming        判斷p610_01_pspc_t是否重覆，使用pspc001,pspc002,pspc004即可
#160608-00013#3   2016/06/21  By ming        執行process時，先檢查有無新版本，有的話，跳出錯誤訊息「該APS版本：%1已有新一版本資料，請重新查詢後再進行處理」
#160727-00019#15 2016/08/03 By 08742   系统中定义的临时表名称超过15码在执行时会出错,所以需要将系统中定义的临时表长度超过15码的全部改掉	 	
#                                      Mod   p610_01_lock_b_t -->p610_tmp01
#160823-00010#1   2016/09/08  By dorislai    條件多過濾：已轉數量pspc061 >= 建議數量pspc034
#161109-00085#61  2016/11/29  By 08171       整批調整系統星號寫法
#170104-00066#1  2017/01/04 By Rainy   筆數相關變數由num5放大至num10
#170203-00016#1   2017/02/13  By dorislai    修正寫入底稿中已有資料，但沒有顯示出來的問題
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
GLOBALS "../../aps/4gl/apsp610_01.inc"
#end add-point
 
{</section>}
 
{<section id="apsp610_01.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
 TYPE type_g_pspc_d RECORD
                              sel_01             LIKE type_t.chr1,          #選擇  
                              pspc050_01         LIKE pspc_t.pspc050,       #料件編號
                              pspc050_01_desc    LIKE imaal_t.imaal003,     #品名 
                              pspc050_01_desc_1  LIKE imaal_t.imaal004,     #規格 
                              pspc051_01         LIKE pspc_t.pspc051,       #產品特徵  
                              pspc051_01_desc    LIKE type_t.chr500,        #產品特徵說明   
                              #160512-00016#5 20160601 add by ming -----(S) 
                              pspc062_01         LIKE pspc_t.pspc062,       #保稅否 
                              #160512-00016#5 20160601 add by ming -----(E) 
                              imaa009_01         LIKE imaa_t.imaa009,       #產品分類
                              imaa009_01_desc    LIKE rtaxl_t.rtaxl003,     #說明
                              imaf141_01         LIKE imaf_t.imaf141,       #採購分群
                              imaf141_01_desc    LIKE oocql_t.oocql004,     #說明
                              pspc034_01         LIKE pspc_t.pspc034,       #建議採購量
                              qty_01             LIKE pspc_t.pspc034,       #本次採購數量=建議採購量(pspc034)-已轉數量(pspc061)
                              imaf143_01         LIKE imaf_t.imaf143,       #採購單位
                              imaf143_01_desc    LIKE oocal_t.oocal003,     #說明
                              pspc014_01         LIKE pspc_t.pspc014,       #單位
                              pspc014_01_desc    LIKE oocal_t.oocal003,     #說明
                              pspc010_01         LIKE pspc_t.pspc010,       #行動日
                              pspc045_01         LIKE pspc_t.pspc045,       #需求日
                              pspc018_01         LIKE pspc_t.pspc018,       #需求單號
                              imaf142_01         LIKE imaf_t.imaf142,       #採購員
                              imaf142_01_desc    LIKE ooag_t.ooag011,       #全名
                              imae012_01         LIKE imae_t.imae012,       #計畫員
                              imae012_01_desc    LIKE ooag_t.ooag011,       #全名
                              pspc061_01         LIKE pspc_t.pspc061,       #已轉數量
                              pspc055_01         LIKE pspc_t.pspc055,       #產生單號
                              pspc056_01         LIKE pspc_t.pspc056,       #項次
                              pspc004_01         LIKE pspc_t.pspc004,       #APS虛擬單號
                              pspc001_01         LIKE pspc_t.pspc001,       #APS版本
                              pspc001_01_desc    LIKE pscal_t.pscal003,     #說明
                              pspc002_01         LIKE pspc_t.pspc002,       #執行日期時間
                              imaf016_01         LIKE imaf_t.imaf016,       #生命週期狀態
                              imaf016_01_desc    LIKE oocql_t.oocql004,     #說明
                              bmif009_01         LIKE bmif_t.bmif009,       #承認狀態
                              bmif009_01_desc    LIKE oocql_t.oocql004,     #說明
                              bmif012_01         LIKE bmif_t.bmif012        #承認文號
                           END RECORD
DEFINE g_pspc_d            DYNAMIC ARRAY OF type_g_pspc_d
DEFINE g_pspc_d_t          type_g_pspc_d 
#DEFINE l_ac                LIKE type_t.num5   #170104-00066#1 17/01/05 mark by rainy
DEFINE l_ac                LIKE type_t.num10   #170104-00066#1 17/01/04 add by rainy
DEFINE g_ref_fields        DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields        DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列 
#170104-00066#1 (B)  17/01/05 modify by rainy 
#DEFINE g_rec_b             LIKE type_t.num5
#DEFINE g_detail_idx        LIKE type_t.num5
DEFINE g_rec_b             LIKE type_t.num10
DEFINE g_detail_idx        LIKE type_t.num10
#170104-00066#1 (E)  17/01/05 modify by rainy 
#end add-point
 
{</section>}
 
{<section id="apsp610_01.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="apsp610_01.other_dialog" >}

DIALOG apsp610_01_input01()
   DEFINE l_flag     LIKE type_t.num5
   DEFINE l_success  LIKE type_t.num5 
   DEFINE l_ooef004  LIKE ooef_t.ooef004        #單據別參照表號 
   DEFINE l_budget_t LIKE type_t.chr1
   

   INPUT BY NAME g_apsp610_01_input.psca001,g_apsp610_01_input.pmdldocno,
                 g_apsp610_01_input.imaf142,g_apsp610_01_input.cb01
                 ATTRIBUTE(WITHOUT DEFAULTS)
      BEFORE INPUT

      AFTER INPUT

      AFTER FIELD psca001
         IF NOT cl_null(g_apsp610_01_input.psca001) THEN 
            INITIALIZE g_chkparam.* TO NULL
            LET g_chkparam.arg1 = g_apsp610_01_input.psca001
            #160318-00025#1--add--str
            LET g_errshow = TRUE 
            LET g_chkparam.err_str[1] = "aps-00074:sub-01302|apsi002|",cl_get_progname("apsi002",g_lang,"2"),"|:EXEPROGapsi002"
            #160318-00025#1--add--end
            IF cl_chk_exist("v_psca001") THEN
               CALL apsp610_01_aps_desc(g_apsp610_01_input.psca001) RETURNING g_apsp610_01_input.psca001_desc
               DISPLAY BY NAME g_apsp610_01_input.psca001_desc
            ELSE
               LET g_apsp610_01_input.psca001_desc = ''
               DISPLAY BY NAME g_apsp610_01_input.psca001_desc
               NEXT FIELD CURRENT
            END IF
         END IF
      
      AFTER FIELD pmdldocno
         #利用aooi200的元件取得說明 
         CALL s_aooi200_get_slip_desc(g_apsp610_01_input.pmdldocno)
              RETURNING g_apsp610_01_input.pmdldocno_desc
         DISPLAY BY NAME g_apsp610_01_input.pmdldocno_desc

         IF NOT cl_null(g_apsp610_01_input.pmdldocno) THEN
            #檢核輸入的單據別是否可以被key人員對應的控制組使用,'4' 為採購控制組類型
            CALL s_control_chk_doc('1',g_apsp610_01_input.pmdldocno,'4',g_user,g_dept,'','')
                 RETURNING l_success,l_flag
            IF l_success THEN
               IF NOT l_flag THEN
                  NEXT FIELD CURRENT
               END IF
            ELSE
               NEXT FIELD CURRENT 
            END IF

            IF NOT s_aooi200_chk_slip(g_site,'',g_apsp610_01_input.pmdldocno,'apmt500') THEN
               CALL s_aooi200_get_slip_desc(g_apsp610_01_input.pmdldocno)
                    RETURNING g_apsp610_01_input.pmdldocno_desc
               DISPLAY BY NAME g_apsp610_01_input.pmdldocno_desc
               NEXT FIELD CURRENT
            END IF
         END IF
         
         #判斷此user是否有控制組，如果有存在多組控制組，就開窗讓user挑選 
         LET g_controlno = ''
         CALL s_control_get_group('4',g_user,g_dept) RETURNING l_success,g_controlno 
         
         #取單別參數，此單別是否走預算控制 
         LET l_budget_t = g_budget_control
         CALL cl_get_doc_para(g_enterprise,g_site,g_apsp610_01_input.pmdldocno,'D-FIN-5002')
              RETURNING g_budget_control
         
         IF g_budget_control != l_budget_t AND NOT cl_null(l_budget_t) THEN
            #新的單別是不走預算控制的，所以應該刪掉底稿中的資料 
            #訊息要換  此單別不做預算控制，是否選擇此單別並且刪除底稿資料？   
            IF cl_ask_confirm_parm("adz-00165","") THEN   #請問是否要刪除底稿資料？ 
               CALL apsp610_01_del_tmp()
               CALL apsp610_01_b_fill_tmp(' 1=1')
            ELSE
               LET g_budget_control = l_budget_t
               LET g_apsp610_01_input.pmdldocno = g_pmdldocno_t
            END IF
         END IF

#         IF NOT cl_null(g_apsp610_01_input.pmdldocno) THEN 
#            CALL apsp610_01_get_col_default()   #取得欄位預設值  
#         END IF 
         
         LET g_pmdldocno_t = g_apsp610_01_input.pmdldocno

      AFTER FIELD imaf142
         CALL apsp610_01_imaf142_ref(g_apsp610_01_input.imaf142)
              RETURNING g_apsp610_01_input.imaf142_desc
         DISPLAY BY NAME g_apsp610_01_input.imaf142_desc

         IF NOT cl_null(g_apsp610_01_input.imaf142) THEN
            INITIALIZE g_chkparam.* TO NULL
            LET g_chkparam.arg1 = g_apsp610_01_input.imaf142
            #160318-00025#1--add--str
            LET g_errshow = TRUE 
            LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
            #160318-00025#1--add--end
            IF NOT cl_chk_exist("v_ooag001") THEN
               NEXT FIELD CURRENT
            END IF

         END IF

         CALL apsp610_01_imaf142_ref(g_apsp610_01_input.imaf142)
              RETURNING g_apsp610_01_input.imaf142_desc
         DISPLAY BY NAME g_apsp610_01_input.imaf142_desc 
         
      ON ACTION controlp INFIELD psca001
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = "i"
         LET g_qryparam.reqry = FALSE
         CALL q_psca001()
         LET g_apsp610_01_input.psca001 = g_qryparam.return1
         CALL apsp610_01_aps_desc(g_apsp610_01_input.psca001) RETURNING g_apsp610_01_input.psca001_desc
         DISPLAY BY NAME g_apsp610_01_input.psca001_desc
         DISPLAY g_apsp610_01_input.psca001  TO psca001
         NEXT FIELD psca001
      
      ON ACTION controlp INFIELD pmdldocno
         #開窗i段
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'i'
         LET g_qryparam.reqry = FALSE

         LET g_qryparam.default1 = g_apsp610_01_input.pmdldocno         #給予default值

         #給予arg
         LET l_ooef004 = ''             #單據別參照表號 
         SELECT ooef004 INTO l_ooef004
           FROM ooef_t
          WHERE ooefent = g_enterprise
            AND ooef001 = g_site
         LET g_qryparam.arg1 = l_ooef004
         LET g_qryparam.arg2 = 'apmt500'

         CALL q_ooba002_1()                                             #呼叫開窗

         LET g_apsp610_01_input.pmdldocno = g_qryparam.return1          #將開窗取得的值回傳到變數
         DISPLAY g_apsp610_01_input.pmdldocno TO pmdldocno              #顯示到畫面上
         CALL s_aooi200_get_slip_desc(g_apsp610_01_input.pmdldocno)
              RETURNING g_apsp610_01_input.pmdldocno_desc
         DISPLAY BY NAME g_apsp610_01_input.pmdldocno_desc

         NEXT FIELD pmdldocno                                           #返回原欄位 

      ON ACTION controlp INFIELD imaf142
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'i'
         LET g_qryparam.reqry = FALSE

         LET g_qryparam.default1 = g_apsp610_01_input.imaf142           #給予default值

         CALL q_ooag001()                                               #呼叫開窗 
         LET g_apsp610_01_input.imaf142 = g_qryparam.return1            #將開窗取得的值回傳到變數
         DISPLAY g_apsp610_01_input.imaf142 TO imaf142                  #顯示到畫面上
         CALL apsp610_01_imaf142_ref(g_apsp610_01_input.imaf142)
              RETURNING g_apsp610_01_input.imaf142_desc
         DISPLAY BY NAME g_apsp610_01_input.imaf142_desc

         NEXT FIELD imaf142                                             #返回原欄位 

   END INPUT
END DIALOG

DIALOG apsp610_01_construct()
   DEFINE l_sql     STRING
   DEFINE l_success LIKE type_t.num5

   CONSTRUCT BY NAME g_apsp610_01_wc ON imae012,pspc050,pspc010,pspc045,imaa009,imaf141

      ON ACTION controlp INFIELD imae012
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_ooag001()
         DISPLAY g_qryparam.return1 TO imae012
         NEXT FIELD imae012                   #返回原欄位 

      ON ACTION controlp INFIELD pspc050
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_imaf001()
         DISPLAY g_qryparam.return1 TO pspc050
         NEXT FIELD pspc050                  #返回原欄位 
         
      ON ACTION controlp INFIELD imaa009
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_rtax001()
         DISPLAY g_qryparam.return1 TO imaa009
         NEXT FIELD imaa009

      ON ACTION controlp INFIELD imaf141
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_imce141()
         DISPLAY g_qryparam.return1 TO imaf141
         NEXT FIELD imaf141
   END CONSTRUCT 
END DIALOG

DIALOG apsp610_01_display()
   #修改成可直接勾選 不必再點擊進入 但上方dialog function還是保留 以免日後規格變更
   DISPLAY ARRAY g_pspc_d TO s_apsp610_01_detail1.* ATTRIBUTE(COUNT=g_d_cnt_p61001)
      BEFORE DISPLAY
         CALL FGL_SET_ARR_CURR(g_d_idx_p61001)
         #單身不連動, 所以進入單身時, 要重新顯示單身筆數
         #DISPLAY g_d_idx_i35001, g_d_cnt_i35001 TO FORMONLY.idx, FORMONLY.cnt 
   
         BEFORE ROW
         LET g_d_idx_p61001 = DIALOG.getCurrentRow("s_apsp610_01_detail1")
         #DISPLAY g_d_idx_p61001 TO FORMONLY.idx
         # 點的當筆放入g_appoint_idx中, 可讓雙擊直接進入指定筆
         LET g_appoint_idx = g_d_idx_p61001
   END DISPLAY
END DIALOG

DIALOG apsp610_01_body_input()
   #DEFINE l_ac1     LIKE type_t.num5  #170104-00066#1 17/01/05 mark by rainy
   DEFINE l_ac1     LIKE type_t.num10  #170104-00066#1 17/01/05 add by rainy

   INPUT ARRAY g_pspc_d FROM s_apsp610_01_detail1.*
         ATTRIBUTE(COUNT = g_d_cnt_p61001,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                   INSERT ROW = FALSE,
                   DELETE ROW = FALSE,
                   APPEND ROW = FALSE)
      BEFORE INPUT

      BEFORE ROW
         LET l_ac1 = ARR_CURR()

      ON CHANGE sel_01
         DISPLAY BY NAME g_pspc_d[l_ac1].sel_01

   END INPUT
END DIALOG

 
{</section>}
 
{<section id="apsp610_01.other_function" readonly="Y" >}

PUBLIC FUNCTION apsp610_01(--)

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
   OPEN WINDOW w_apsp610_01 WITH FORM cl_ap_formpath("apm","apsp610_01")

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
   CLOSE WINDOW w_apsp610_01

   #add-point:input段after input

   #end add-point
}
END FUNCTION

################################################################################
# Descriptions...: 依construct條件填充單身資料
# Memo...........:
# Usage..........: CALL apsp610_01_b_fill(p_wc)
# Input parameter: p_wc
# Date & Author..: 2016/01/22 By shiun
# Modify.........: 160512-00016#5  2016/06/01 by ming 增加欄位pspc062 保稅否
################################################################################
PUBLIC FUNCTION apsp610_01_b_fill(p_wc)
   DEFINE p_wc      STRING
   DEFINE l_sql     STRING
   #DEFINE l_ac1     LIKE type_t.num5   #170104-00066#1 mark by rainy
   DEFINE l_ac1     LIKE type_t.num10   #170104-00066#1 add by rainy
   DEFINE l_pspc_d  type_g_pspc_d
   #DEFINE l_count   LIKE type_t.num5   #170104-00066#1 mark by rainy
   DEFINE l_count   LIKE type_t.num10   #170104-00066#1 add by rainy
   DEFINE l_success LIKE type_t.num5 
   DEFINE l_pmdb049 LIKE pmdb_t.pmdb049
   DEFINE l_pmdp024 LIKE pmdp_t.pmdp024
   DEFINE l_imaa004 LIKE imaa_t.imaa004     #料件類別  
   DEFINE l_oofa001 LIKE oofa_t.oofa001
   DEFINE l_errno   LIKE gzze_t.gzze001
   DEFINE l_bgaf016 LIKE bgaf_t.bgaf016
   DEFINE l_pmdb053 LIKE pmdb_t.pmdb053
   DEFINE l_pmdb053_desc LIKE type_t.chr80
   DEFINE l_code_s_bas_0036 LIKE type_t.chr80     #是否使用產品特徵  
   DEFINE l_code_d_bas_0098 LIKE type_t.chr80     #是否帶入來源單據短備註 
   DEFINE l_pmdbdocno       LIKE pmdb_t.pmdbdocno #請購單號 
   DEFINE l_pmdbseq         LIKE pmdb_t.pmdbseq   #請購項次 
   DEFINE l_cnt             LIKE type_t.num5
   DEFINE l_bmif011         LIKE bmif_t.bmif011
   DEFINE l_pmdp023         LIKE pmdp_t.pmdp023
   DEFINE l_pspc004         LIKE pspc_t.pspc004
   
   WHENEVER ERROR CONTINUE 
   
   #如果沒有輸入單別的話就不用做  
   IF cl_null(g_apsp610_01_input.pmdldocno) THEN
      RETURN
   END IF 
   
   #取得此據點是否使用產品特徵的參數設定值 
   CALL cl_get_para(g_enterprise,g_site,'S-BAS-0036') RETURNING l_code_s_bas_0036

   #取得此單別是否帶入來源單據的短備註 
   CALL cl_get_doc_para(g_enterprise,g_site,g_apsp610_01_input.pmdldocno,'D-BAS-0098')
        RETURNING l_code_d_bas_0098


   IF cl_null(p_wc) THEN
      LET p_wc = ' 1=1'
   END IF
   
   #160608-00013#3 20160621 add by ming -----(S)   
   LET g_p610_pspc002 = ''
   SELECT MAX(pspc002) INTO g_p610_pspc002 
     FROM pspc_t 
    WHERE pspcent  = g_enterprise
      AND pspcsite = g_site
      AND pspc001  = g_apsp610_01_input.psca001 
   #160608-00013#3 20160621 add by ming -----(E) 
      
   LET l_sql = " SELECT 'N',pspc050,imaal003,imaal004,pspc051,'',",
               "        COALESCE(pspc062,'N'), ",     #160512-00016#5 20160601 add 
               "        imaa009,rtaxl003,",
               "        imaf141,(SELECT oocql004 FROM oocql_t ",
               "                  WHERE oocqlent = '",g_enterprise,"' ",
               "                    AND oocql001 = '203' ",
               "                    AND oocql002 = imaf141 ",
               "                    AND oocql003 = '",g_dlang,"'),",
               "        NVL(pspc034,0),(NVL(pspc034,0)-NVL(pspc061,0)), ",
               "        imaf143,(SELECT oocal003 FROM oocal_t ",
               "                  WHERE oocalent = '",g_enterprise,"' ",
               "                    AND oocal001 = imaf143 ",
               "                    AND oocal002 = '",g_dlang,"'), ",
               "        pspc014,(SELECT oocal003 FROM oocal_t ",
               "                  WHERE oocalent = '",g_enterprise,"' ",
               "                    AND oocal001 = pspc014 ",
               "                    AND oocal002 = '",g_dlang,"'),",
               "        pspc010,pspc045,pspc018,",
               "        imaf142,(SELECT ooag011 FROM ooag_t ",
               "                  WHERE ooagent = '",g_enterprise,"' ",
               "                    AND ooag001 = imaf142), ",
               "        imae012,(SELECT ooag011 FROM ooag_t ",
               "                  WHERE ooagent = '",g_enterprise,"' ",
               "                    AND ooag001 = imae012),",
               "        NVL(pspc061,0),pspc055,pspc056,pspc004,pspc001,pscal003,pspc002,",
               "        imaf016,(SELECT oocql004 FROM oocql_t ",
               "                  WHERE oocqlent = '",g_enterprise,"' ",
               "                    AND oocql001 = '210' ",
               "                    AND oocql002 = imaf016 ",
               "                    AND oocql003 = '",g_dlang,"'),'','','',pspc004 ",
               "   FROM pspc_t ",
               "        LEFT OUTER JOIN imae_t ON imaeent = pspcent AND imaesite = pspcsite AND imae001 = pspc050 ",
               "        LEFT OUTER JOIN imaf_t ON imafent = pspcent AND imafsite = pspcsite AND imaf001 = pspc050 ",
               "        LEFT OUTER JOIN imaa_t ON imaaent = pspcent AND imaa001 = pspc050 ",
               "        LEFT OUTER JOIN imaal_t ON imaalent = pspcent AND imaal001 = pspc050 AND imaal002 = '",g_dlang,"'",
               "        LEFT OUTER JOIN pscal_t ON pscalent = pspcent AND pscal001 = pspc001 AND pscal002 = '",g_dlang,"'",
               "        LEFT OUTER JOIN rtaxl_t ON rtaxlent = pspcent AND rtaxl001 = imaa009 AND rtaxl002 = '",g_dlang,"'",
               "  WHERE pspcent = ? ",
               "    AND pspcsite = '",g_site,"' ",
               "    AND pspc001 = '",g_apsp610_01_input.psca001,"' ",
               #160608-00013#3 20160621 modify by ming -----(S) 
               #"    AND pspc002 = (SELECT MAX(pspc002) FROM pspc_t WHERE pspcent = ",g_enterprise," AND pspcsite = '",g_site,"' AND pspc001 = '",g_apsp610_01_input.psca001,"') ",
               "     AND pspc002 = '",g_p610_pspc002,"' ", 
               #160608-00013#3 20160621 modify by ming -----(E) 
               "    AND NVL(pspc061,0) < NVL(pspc034,0) ",  #160823-00010#1-add
               "    AND pspc007 = '1' ",
               "    AND ",p_wc CLIPPED,
               "  ORDER BY pspc050 "


   IF NOT cl_null(g_apsp610_01_input.imaf142) THEN
      LET l_sql = l_sql, " AND imaf142 = '",g_apsp610_01_input.imaf142,"' "
   END IF

   PREPARE apsp610_01_prep FROM l_sql
   DECLARE apsp610_01_curs CURSOR FOR apsp610_01_prep

   CALL g_pspc_d.clear()

   LET l_ac1 = 1
   INITIALIZE l_pspc_d.* TO NULL

   #FOREACH apsp610_01_curs USING g_enterprise INTO l_pspc_d.*,l_pspc004 #161109-00085#61 mark
   #161109-00085#61 --s add
   FOREACH apsp610_01_curs USING g_enterprise INTO l_pspc_d.sel_01,l_pspc_d.pspc050_01,l_pspc_d.pspc050_01_desc,l_pspc_d.pspc050_01_desc_1,l_pspc_d.pspc051_01,
                                                   l_pspc_d.pspc051_01_desc,l_pspc_d.pspc062_01,l_pspc_d.imaa009_01,l_pspc_d.imaa009_01_desc,l_pspc_d.imaf141_01,         
                                                   l_pspc_d.imaf141_01_desc,l_pspc_d.pspc034_01,l_pspc_d.qty_01,l_pspc_d.imaf143_01,l_pspc_d.imaf143_01_desc,    
                                                   l_pspc_d.pspc014_01,l_pspc_d.pspc014_01_desc,l_pspc_d.pspc010_01,l_pspc_d.pspc045_01,l_pspc_d.pspc018_01,        
                                                   l_pspc_d.imaf142_01,l_pspc_d.imaf142_01_desc,l_pspc_d.imae012_01,l_pspc_d.imae012_01_desc,l_pspc_d.pspc061_01,         
                                                   l_pspc_d.pspc055_01,l_pspc_d.pspc056_01,l_pspc_d.pspc004_01,l_pspc_d.pspc001_01,l_pspc_d.pspc001_01_desc,    
                                                   l_pspc_d.pspc002_01,l_pspc_d.imaf016_01,l_pspc_d.imaf016_01_desc,l_pspc_d.bmif009_01,l_pspc_d.bmif009_01_desc,    
                                                   l_pspc_d.bmif012_01,l_pspc004
   #161109-00085#61 --e add
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
#      #檢查請購單的資料是否已經被lock 
#      LET l_pmdbdocno = '' 
#      LET l_pmdbseq   = '' 
#      LET l_sql = "SELECT pmdbdocno,pmdbseq ", 
#                  "  FROM pmdb_t ", 
#                  " WHERE pmdbent   = '",g_enterprise,"' ", 
#                  "   AND pmdbdocno = '",l_pmdb_d.pmdbdocno_01,"' ", 
#                  "   AND pmdbseq   = '",l_pmdb_d.pmdbseq_01,"' ", 
#                  "   FOR UPDATE SKIP LOCKED " 
#      PREPARE apsp610_01_chk_locked_prep FROM l_sql 
#      EXECUTE apsp610_01_chk_locked_prep INTO l_pmdbdocno,l_pmdbseq 
#      IF cl_null(l_pmdbdocno) AND cl_null(l_pmdbseq) THEN 
#         CONTINUE FOREACH 
#      END IF 
      #檢查是否有產生採購單
      LET l_pmdp023 = 0
      SELECT SUM(pmdp023) INTO l_pmdp023
        FROM pmdl_t,pmdp_t
       WHERE pmdlent = pmdlent
         AND pmdldocno = pmdpdocno
         AND pmdlstus <> 'X'
         AND pmdp003 = l_pspc004
      IF l_pmdp023 >= l_pspc_d.qty_01 THEN
         CONTINUE FOREACH
      END IF
      
      #檢查此資料是否已經存在請購底稿之中了，如果已經存在了，那就不再顯示 
      LET l_count = 0
      #160606-00006#1 20160614 modify by ming -----(S) 
      #直接使用pspc001,pspc002,pspc004檢查即可
      #SELECT COUNT(*) INTO l_count
      #  FROM p610_01_pspc_t
      # WHERE NVL(pspc050,' ') = NVL(l_pspc_d.pspc050_01,' ')
      #   AND NVL(pspc051,' ') = NVL(l_pspc_d.pspc051_01,' ')
      #   AND NVL(pspc034,'0') = NVL(l_pspc_d.pspc034_01,'0')
      #   AND NVL(pspc014,' ') = NVL(l_pspc_d.pspc014_01,' ')
      #   AND pspc010 = l_pspc_d.pspc010_01
      #   AND pspc045 = l_pspc_d.pspc045_01
      #   AND pspc018 = l_pspc_d.pspc018_01
      #   AND NVL(pspc061,'0') = NVL(l_pspc_d.pspc061_01,'0')
      SELECT COUNT(*) INTO l_count
        FROM p610_01_pspc_t
       WHERE pspc001 = l_pspc_d.pspc001_01 
         AND pspc002 = l_pspc_d.pspc002_01 
         AND pspc004 = l_pspc_d.pspc004_01 
       
      #160606-00006#1 20160614 modify by ming -----(E) 


      IF l_count > 0 THEN
         INITIALIZE l_pspc_d.* TO NULL
         CONTINUE FOREACH
      END IF

      #做採購料件的基本檢查  
      #雖然第一頁都是請購單的資料，而第二頁還可以修改採購料件 
      #但是那是有做替代才可以換 所以大多數請購料都會等於採購料 
      #故在此就要先做檢查  
      IF NOT apsp610_01_pmdn001_chk(l_pspc_d.pspc050_01) THEN
         CONTINUE FOREACH
      END IF

      IF l_code_s_bas_0036 =  'N' THEN
         LET l_pspc_d.pspc051_01 = ' '
      END IF
      #取得產品特徵說明 
      #如果產品特徵有值，才呼叫function，以增進效能 
      IF NOT cl_null(l_pspc_d.pspc051_01) THEN
         CALL s_feature_description(l_pspc_d.pspc050_01,l_pspc_d.pspc051_01)
              RETURNING l_success,l_pspc_d.pspc051_01_desc
      END IF
           
      LET l_imaa004 = ''     #料件類別 
      SELECT imaa004 INTO l_imaa004
        FROM imaa_t
       WHERE imaaent = g_enterprise
         AND imaa001 = l_pspc_d.pspc050_01
         
      #因為飛毛腿認為一般料件也應保留備註  
      #所以此部分就不再以先前的規格為主 
      #IF l_imaa004 != 'E' THEN     #如果不是費用料件的話 備註就應被合併清掉不出現  
      #   LET l_pmdb_d.pmdb050_01 = ''
      #END IF
      #20150116 mark -----------------------------------(E) 
      
      #因為有客戶認為只有費用性料件才需要保留備註 
      #其他情況就由單別的參數設定來決定是否保留備註  
#      IF l_imaa004 != 'E' THEN     #如果不是費用料件的時候，才需要考慮單別參數的設定是否保留  
#         IF l_code_d_bas_0098 != 'Y' OR cl_null(l_code_d_bas_0098) THEN
#            #如果不是費用料件，且單別參數設定為不保留時 
#            #備註就應該被合併清掉不出現 
#            LET l_pspc_d.pspc050_01 = ''
#         END IF
#      END IF
      
      
      #取得abmt410的承認資料 
      #先取得最後承認日期 
      LET l_bmif011 = ''
      SELECT MAX(bmif011) INTO l_bmif011
        FROM bmif_t
       WHERE bmifent = g_enterprise
         AND bmif001 = l_pspc_d.pspc050_01

      #檢查最後的日期是否有多筆以上 有的話要找最後修改的 才是真正的最後日期 
      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt
        FROM bmif_t
       WHERE bmifent = g_enterprise
         AND bmif001 = l_pspc_d.pspc050_01
         AND bmif011 = l_bmif011

      LET l_sql = "SELECT bmif009,bmif012 ",
                  "  FROM bmif_t ",
                  " WHERE bmifent = '",g_enterprise,"' ",
                  "   AND bmif001 = '",l_pspc_d.pspc050_01,"' ", 
                  "   AND bmif011 = '",l_bmif011,"' "
      IF l_cnt > 1 THEN
         LET l_sql = l_sql ," AND bmifmoddt = (SELECT MAX(bmifmoddt) ",
                            "                    FROM bmif_t ",
                            "                   WHERE bmifent = '",g_enterprise,"' ",
                            "                     AND bmif001 = '",l_pspc_d.pspc050_01,"' ",
                            "                     AND bmif011 = '",l_bmif011,"' ) "
      END IF

      PREPARE apsp610_get_bmif_prep FROM l_sql
      EXECUTE apsp610_get_bmif_prep INTO l_pspc_d.bmif009_01,
                                         l_pspc_d.bmif012_01  
      #承認狀態 
      CALL s_desc_get_acc_desc('1116',l_pspc_d.bmif009_01) RETURNING l_pspc_d.bmif009_01_desc 
      
      #產品特徵
      CALL s_feature_description(l_pspc_d.pspc050_01,l_pspc_d.pspc051_01)
           RETURNING l_success,l_pspc_d.pspc051_01_desc
           
      LET g_pspc_d[l_ac1].* = l_pspc_d.*

      LET l_ac1 = l_ac1 + 1
      INITIALIZE l_pspc_d.* TO NULL

      IF l_ac1 > g_max_rec THEN
         #CALL cl_err('',9035,0) 
         EXIT FOREACH
      END IF
   END FOREACH

   #CALL g_pmdb_d.deleteElement(g_pmdb_d.getLength()) 
   #LET g_rec_b = l_ac1 - 1 
   LET g_rec_b = l_ac1

  #DISPLAY g_rec_b TO FORMONLY.cnt
  ##將總筆數, 目前筆數指定到共用變數中
  #IF g_rec_b > 0 THEN
  #   LET g_d_idx_i35001 = 1
  #ELSE
  #   LET g_d_idx_i35001 = 0
  #END IF
  #LET g_d_cnt_i35001 = g_rec_b
  #CLOSE b_fill_curs
  #FREE aooi350_01_pb
END FUNCTION

################################################################################
# Descriptions...: 建立請購底稿的temp table 
# Memo...........:
# Usage..........: CALL apsp610_01_create_temp_table()
# Date & Author..: 2016/01/22 By shiun
# Modify.........: 160512-00016#5 2016/06/01 by ming 增加欄位pspc062保稅否
################################################################################
PUBLIC FUNCTION apsp610_01_create_temp_table()

   WHENEVER ERROR CONTINUE 

   CREATE TEMP TABLE p610_01_pspc_t(
      pspc050         LIKE pspc_t.pspc050,       #料件編號
      pspc051         LIKE pspc_t.pspc051,       #產品特徵  
      pspc062         LIKE pspc_t.pspc062,       #保稅否     #160512-00016#5 20160601 add 
      imaa009         LIKE imaa_t.imaa009,       #產品分類
      imaf141         LIKE imaf_t.imaf141,       #採購分群
      pspc034         LIKE pspc_t.pspc034,       #建議採購量
      qty             LIKE pspc_t.pspc034,       #本次採購數量=建議採購量(pspc034)-已轉數量(pspc061)
      imaf143         LIKE imaf_t.imaf143,       #採購單位
      pspc014         LIKE pspc_t.pspc014,       #單位
      pspc010         LIKE pspc_t.pspc010,       #行動日
      pspc045         LIKE pspc_t.pspc045,       #需求日
      pspc018         LIKE pspc_t.pspc018,       #需求單號
      imaf142         LIKE imaf_t.imaf142,       #採購員
      imae012         LIKE imae_t.imae012,       #計畫員
      pspc061         LIKE pspc_t.pspc061,       #已轉數量
      pspc055         LIKE pspc_t.pspc055,       #產生單號
      pspc056         LIKE pspc_t.pspc056,       #項次
      pspc004         LIKE pspc_t.pspc004,       #APS虛擬單號
      pspc001         LIKE pspc_t.pspc001,       #APS版本
      pspc002         LIKE pspc_t.pspc002,       #執行日期時間
      imaf016         LIKE imaf_t.imaf016,       #生命週期狀態
      bmif009         LIKE bmif_t.bmif009,       #承認狀態
      bmif012         LIKE bmif_t.bmif012,       #承認文號
      applied_qty     LIKE pspc_t.pspc034)        #已分配數量   

   CREATE TEMP TABLE p610_tmp01(           #160727-00019#15 Mod   p610_01_lock_b_t -->p610_tmp01
      pspc001         LIKE pspc_t.pspc001,       #APS版本
      pspc002         LIKE pspc_t.pspc002,       #執行日期時間
      pspc004         LIKE pspc_t.pspc004        #APS虛擬單號
   )

END FUNCTION

################################################################################
# Descriptions...: 將選取的資料寫入請購底稿
# Memo...........:
# Usage..........: CALL apsp610_01_save()
# Date & Author..: 2016/01/22 By shiun
# Modify.........: 160512-00016#5 2016/06/01 by ming 增加欄位pspc062保稅否
################################################################################
PUBLIC FUNCTION apsp610_01_save()
   DEFINE l_i         LIKE type_t.num10     #170104-00066#1 num5->num10  17/01/05 mod by rainy 
   DEFINE l_cnt       LIKE type_t.num10     #170104-00066#1 num5->num10  17/01/05 mod by rainy
   DEFINE l_flag      LIKE type_t.chr1 
   DEFINE l_sql       STRING
   DEFINE l_pmdbdocno LIKE pmdb_t.pmdbdocno
   DEFINE l_pmdbseq   LIKE pmdb_t.pmdbseq
   DEFINE l_where     STRING

   WHENEVER ERROR CONTINUE 

   #用來判斷是否有資料被寫入 
   LET l_flag = 'N'

   #如果畫面上沒有資料的話，就不必實做寫入底稿的動作 
   IF g_pspc_d.getLength() = 0 THEN
      RETURN
   END IF

   FOR l_i = 1 TO g_pspc_d.getLength()
      #只要單身中的資料沒有被勾選，就直接下一筆 
      IF g_pspc_d[l_i].sel_01 = 'N' THEN
         CONTINUE FOR
      END IF

      #檢查此請購單資料是否已經存在底稿之前  
      #已經存在底稿的就不用重覆寫入 
      LET l_cnt = 0
      #160606-00006#1 20160614 modify by ming -----(S) 
      #SELECT COUNT(*) INTO l_cnt
      #  FROM p610_01_pspc_t
      # WHERE pspc050 = g_pspc_d[l_i].pspc050_01
      #   AND pspc051 = g_pspc_d[l_i].pspc051_01
      #   AND pspc034 = g_pspc_d[l_i].pspc034_01
      #   AND pspc014 = g_pspc_d[l_i].pspc014_01
      #   AND pspc010 = g_pspc_d[l_i].pspc010_01
      #   AND pspc045 = g_pspc_d[l_i].pspc045_01
      #   AND pspc018 = g_pspc_d[l_i].pspc018_01
      SELECT COUNT(*) INTO l_cnt
        FROM p610_01_pspc_t
       WHERE pspc001 = g_pspc_d[l_i].pspc001_01 
         AND pspc002 = g_pspc_d[l_i].pspc002_01 
         AND pspc004 = g_pspc_d[l_i].pspc004_01 
      #160606-00006#1 20160614 modify by ming -----(E) 
      IF l_cnt > 0 THEN
         CONTINUE FOR
      END IF

      #160512-00016#5 20160601 modify by ming -----(S) 
      #INSERT INTO p610_01_pspc_t(pspc050,pspc051,imaa009,imaf141,pspc034,qty,imaf143,pspc014,
      #                           pspc010,pspc045,pspc018,imaf142,imae012,pspc061,pspc055,pspc056,
      #                           pspc004,pspc001,pspc002,imaf016,bmif009,bmif012,applied_qty)
      #                    VALUES(g_pspc_d[l_i].pspc050_01,g_pspc_d[l_i].pspc051_01,g_pspc_d[l_i].imaa009_01,
      #                           g_pspc_d[l_i].imaf141_01,g_pspc_d[l_i].pspc034_01,g_pspc_d[l_i].qty_01,
      #                           g_pspc_d[l_i].imaf143_01,g_pspc_d[l_i].pspc014_01,g_pspc_d[l_i].pspc010_01,
      #                           g_pspc_d[l_i].pspc045_01,g_pspc_d[l_i].pspc018_01,g_pspc_d[l_i].imaf142_01,
      #                           g_pspc_d[l_i].imae012_01,g_pspc_d[l_i].pspc061_01,g_pspc_d[l_i].pspc055_01,
      #                           g_pspc_d[l_i].pspc056_01,g_pspc_d[l_i].pspc004_01,g_pspc_d[l_i].pspc001_01,
      #                           g_pspc_d[l_i].pspc002_01,g_pspc_d[l_i].imaf016_01,g_pspc_d[l_i].bmif009_01,
      #                           g_pspc_d[l_i].bmif012_01,'0')
      INSERT INTO p610_01_pspc_t(pspc050,pspc051,pspc062,imaa009,imaf141,pspc034,qty,imaf143,pspc014,
                                 pspc010,pspc045,pspc018,imaf142,imae012,pspc061,pspc055,pspc056,
                                 pspc004,pspc001,pspc002,imaf016,bmif009,bmif012,applied_qty)
                          VALUES(g_pspc_d[l_i].pspc050_01,g_pspc_d[l_i].pspc051_01,
                                 g_pspc_d[l_i].pspc062_01, 
                                 g_pspc_d[l_i].imaa009_01,
                                 g_pspc_d[l_i].imaf141_01,g_pspc_d[l_i].pspc034_01,g_pspc_d[l_i].qty_01,
                                 g_pspc_d[l_i].imaf143_01,g_pspc_d[l_i].pspc014_01,g_pspc_d[l_i].pspc010_01,
                                 g_pspc_d[l_i].pspc045_01,g_pspc_d[l_i].pspc018_01,g_pspc_d[l_i].imaf142_01,
                                 g_pspc_d[l_i].imae012_01,g_pspc_d[l_i].pspc061_01,g_pspc_d[l_i].pspc055_01,
                                 g_pspc_d[l_i].pspc056_01,g_pspc_d[l_i].pspc004_01,g_pspc_d[l_i].pspc001_01,
                                 g_pspc_d[l_i].pspc002_01,g_pspc_d[l_i].imaf016_01,g_pspc_d[l_i].bmif009_01,
                                 g_pspc_d[l_i].bmif012_01,'0')
      #160512-00016#5 20160601 modify by ming -----(E) 
      LET l_flag = 'Y'
   END FOR  

   #有資料寫入 要提示 user資料寫入底稿成功 
   IF l_flag = 'Y' THEN
      CALL cl_ask_pressanykey("aps-00183")   #APS底稿寫入成功  
   END IF
END FUNCTION

################################################################################
# Descriptions...: 刪除temp table 
# Memo...........:
# Usage..........: CALL apsp610_01_drop_temp_table()
# Date & Author..: 2016/01/22 By shiun
# Modify.........: 
################################################################################
PUBLIC FUNCTION apsp610_01_drop_temp_table()
   WHENEVER ERROR CONTINUE 

   DROP TABLE p610_01_pspc_t; 
   
   DROP TABLE p610_tmp01;         #160727-00019#15 Mod   p610_01_lock_b_t -->p610_tmp01
END FUNCTION

PUBLIC FUNCTION apsp610_01_imaf142_ref(p_imaf142)
   DEFINE p_imaf142      LIKE imaf_t.imaf142
   DEFINE r_imaf142_desc LIKE oofa_t.oofa011

   WHENEVER ERROR CONTINUE 

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_imaf142
   CALL ap_ref_array2(g_ref_fields,
                      "SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ",
                      "")
        RETURNING g_rtn_fields
   LET r_imaf142_desc = '', g_rtn_fields[1] , ''
   RETURN r_imaf142_desc
END FUNCTION

################################################################################
# Descriptions...: 頁面初始化設定
# Memo...........:
# Usage..........: CALL apsp610_01_init()
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_01_init()
   WHENEVER ERROR CONTINUE 


   #畫面預設值 
   LET g_apsp610_01_input.cb01 = 'Y'

   LET g_imae012 = ''
   LET g_pspc050 = ''
   LET g_pspc010 = ''
   LET g_pspc045 = ''
   LET g_imaa009 = ''
   LET g_imaf141 = '' 
   
   #不使用產品特徵，則將產品特徵及說明隱藏 
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'N' THEN
      CALL cl_set_comp_visible("pspc051_01,pspc051_01_desc",FALSE)
   END IF 
   
   #CALL cl_set_comp_format("pmdb006_01",'---,---,---,--&')
   
   CALL g_pspc_d.clear()
END FUNCTION

################################################################################
# Descriptions...: 以單別取得欄位預設值 
# Memo...........:
# Usage..........: CALL apsp610_01_get_col_default()
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_01_get_col_default()
   
#   WHENEVER ERROR CONTINUE 
#   
#   #以單別取得欄位預設值 
#   #目前無作用 
#
#   INITIALIZE g_apsp610_01_pmdl.* TO NULL
#
#   CALL s_aooi200_get_doc_default(g_site,'1',g_apsp610_01_input.pmdldocno,'pmdldocdt',g_apsp610_01_pmdl.pmdldocdt)
#        RETURNING g_apsp610_01_pmdl.pmdldocdt
#   CALL s_aooi200_get_doc_default(g_site,'1',g_apsp610_01_input.pmdldocno,'pmdl001',g_apsp610_01_pmdl.pmdl001)
#        RETURNING g_apsp610_01_pmdl.pmdl001
#   CALL s_aooi200_get_doc_default(g_site,'1',g_apsp610_01_input.pmdldocno,'pmdl002',g_apsp610_01_pmdl.pmdl002)
#        RETURNING g_apsp610_01_pmdl.pmdl002
#   CALL s_aooi200_get_doc_default(g_site,'1',g_apsp610_01_input.pmdldocno,'pmdl003',g_apsp610_01_pmdl.pmdl003)
#        RETURNING g_apsp610_01_pmdl.pmdl003
#   CALL s_aooi200_get_doc_default(g_site,'1',g_apsp610_01_input.pmdldocno,'pmdl004',g_apsp610_01_pmdl.pmdl004)
#        RETURNING g_apsp610_01_pmdl.pmdl004
#   CALL s_aooi200_get_doc_default(g_site,'1',g_apsp610_01_input.pmdldocno,'pmdl005',g_apsp610_01_pmdl.pmdl005)
#        RETURNING g_apsp610_01_pmdl.pmdl005
#   CALL s_aooi200_get_doc_default(g_site,'1',g_apsp610_01_input.pmdldocno,'pmdl006',g_apsp610_01_pmdl.pmdl006)
#        RETURNING g_apsp610_01_pmdl.pmdl006
#   CALL s_aooi200_get_doc_default(g_site,'1',g_apsp610_01_input.pmdldocno,'pmdl007',g_apsp610_01_pmdl.pmdl007)
#        RETURNING g_apsp610_01_pmdl.pmdl007
#   CALL s_aooi200_get_doc_default(g_site,'1',g_apsp610_01_input.pmdldocno,'pmdl008',g_apsp610_01_pmdl.pmdl008)
#        RETURNING g_apsp610_01_pmdl.pmdl008
#   CALL s_aooi200_get_doc_default(g_site,'1',g_apsp610_01_input.pmdldocno,'pmdl009',g_apsp610_01_pmdl.pmdl009)
#        RETURNING g_apsp610_01_pmdl.pmdl009
#   CALL s_aooi200_get_doc_default(g_site,'1',g_apsp610_01_input.pmdldocno,'pmdl010',g_apsp610_01_pmdl.pmdl010)
#        RETURNING g_apsp610_01_pmdl.pmdl010
#   CALL s_aooi200_get_doc_default(g_site,'1',g_apsp610_01_input.pmdldocno,'pmdl011',g_apsp610_01_pmdl.pmdl011)
#        RETURNING g_apsp610_01_pmdl.pmdl011
#   CALL s_aooi200_get_doc_default(g_site,'1',g_apsp610_01_input.pmdldocno,'pmdl012',g_apsp610_01_pmdl.pmdl012)
#        RETURNING g_apsp610_01_pmdl.pmdl012
#   CALL s_aooi200_get_doc_default(g_site,'1',g_apsp610_01_input.pmdldocno,'pmdl013',g_apsp610_01_pmdl.pmdl013)
#        RETURNING g_apsp610_01_pmdl.pmdl013
#   CALL s_aooi200_get_doc_default(g_site,'1',g_apsp610_01_input.pmdldocno,'pmdl015',g_apsp610_01_pmdl.pmdl015)
#        RETURNING g_apsp610_01_pmdl.pmdl015
#   CALL s_aooi200_get_doc_default(g_site,'1',g_apsp610_01_input.pmdldocno,'pmdl016',g_apsp610_01_pmdl.pmdl016)
#        RETURNING g_apsp610_01_pmdl.pmdl016
#   CALL s_aooi200_get_doc_default(g_site,'1',g_apsp610_01_input.pmdldocno,'pmdl017',g_apsp610_01_pmdl.pmdl017)
#        RETURNING g_apsp610_01_pmdl.pmdl017
#   CALL s_aooi200_get_doc_default(g_site,'1',g_apsp610_01_input.pmdldocno,'pmdl018',g_apsp610_01_pmdl.pmdl018)
#        RETURNING g_apsp610_01_pmdl.pmdl018
#   CALL s_aooi200_get_doc_default(g_site,'1',g_apsp610_01_input.pmdldocno,'pmdl019',g_apsp610_01_pmdl.pmdl019)
#        RETURNING g_apsp610_01_pmdl.pmdl019
#   CALL s_aooi200_get_doc_default(g_site,'1',g_apsp610_01_input.pmdldocno,'pmdl020',g_apsp610_01_pmdl.pmdl020)
#        RETURNING g_apsp610_01_pmdl.pmdl020
#   CALL s_aooi200_get_doc_default(g_site,'1',g_apsp610_01_input.pmdldocno,'pmdl021',g_apsp610_01_pmdl.pmdl021)
#        RETURNING g_apsp610_01_pmdl.pmdl021
#   CALL s_aooi200_get_doc_default(g_site,'1',g_apsp610_01_input.pmdldocno,'pmdl022',g_apsp610_01_pmdl.pmdl022)
#        RETURNING g_apsp610_01_pmdl.pmdl022
#   CALL s_aooi200_get_doc_default(g_site,'1',g_apsp610_01_input.pmdldocno,'pmdl023',g_apsp610_01_pmdl.pmdl023)
#        RETURNING g_apsp610_01_pmdl.pmdl023
#   CALL s_aooi200_get_doc_default(g_site,'1',g_apsp610_01_input.pmdldocno,'pmdl024',g_apsp610_01_pmdl.pmdl024)
#        RETURNING g_apsp610_01_pmdl.pmdl024
#   CALL s_aooi200_get_doc_default(g_site,'1',g_apsp610_01_input.pmdldocno,'pmdl025',g_apsp610_01_pmdl.pmdl025)
#        RETURNING g_apsp610_01_pmdl.pmdl025
#   CALL s_aooi200_get_doc_default(g_site,'1',g_apsp610_01_input.pmdldocno,'pmdl026',g_apsp610_01_pmdl.pmdl026)
#        RETURNING g_apsp610_01_pmdl.pmdl026 
#   CALL s_aooi200_get_doc_default(g_site,'1',g_apsp610_01_input.pmdldocno,'pmdl027',g_apsp610_01_pmdl.pmdl027)
#        RETURNING g_apsp610_01_pmdl.pmdl027
#   CALL s_aooi200_get_doc_default(g_site,'1',g_apsp610_01_input.pmdldocno,'pmdl028',g_apsp610_01_pmdl.pmdl028)
#        RETURNING g_apsp610_01_pmdl.pmdl028
#   CALL s_aooi200_get_doc_default(g_site,'1',g_apsp610_01_input.pmdldocno,'pmdl029',g_apsp610_01_pmdl.pmdl029)
#        RETURNING g_apsp610_01_pmdl.pmdl029
#   CALL s_aooi200_get_doc_default(g_site,'1',g_apsp610_01_input.pmdldocno,'pmdl030',g_apsp610_01_pmdl.pmdl030)
#        RETURNING g_apsp610_01_pmdl.pmdl030
#   CALL s_aooi200_get_doc_default(g_site,'1',g_apsp610_01_input.pmdldocno,'pmdl031',g_apsp610_01_pmdl.pmdl031)
#        RETURNING g_apsp610_01_pmdl.pmdl031
#   CALL s_aooi200_get_doc_default(g_site,'1',g_apsp610_01_input.pmdldocno,'pmdl032',g_apsp610_01_pmdl.pmdl032)
#        RETURNING g_apsp610_01_pmdl.pmdl032
#   CALL s_aooi200_get_doc_default(g_site,'1',g_apsp610_01_input.pmdldocno,'pmdl033',g_apsp610_01_pmdl.pmdl033)
#        RETURNING g_apsp610_01_pmdl.pmdl033
#   CALL s_aooi200_get_doc_default(g_site,'1',g_apsp610_01_input.pmdldocno,'pmdl040',g_apsp610_01_pmdl.pmdl040)
#        RETURNING g_apsp610_01_pmdl.pmdl040
#   CALL s_aooi200_get_doc_default(g_site,'1',g_apsp610_01_input.pmdldocno,'pmdl041',g_apsp610_01_pmdl.pmdl041)
#        RETURNING g_apsp610_01_pmdl.pmdl041
#   CALL s_aooi200_get_doc_default(g_site,'1',g_apsp610_01_input.pmdldocno,'pmdl042',g_apsp610_01_pmdl.pmdl042)
#        RETURNING g_apsp610_01_pmdl.pmdl042
#   CALL s_aooi200_get_doc_default(g_site,'1',g_apsp610_01_input.pmdldocno,'pmdl043',g_apsp610_01_pmdl.pmdl043)
#        RETURNING g_apsp610_01_pmdl.pmdl043
#   CALL s_aooi200_get_doc_default(g_site,'1',g_apsp610_01_input.pmdldocno,'pmdl044',g_apsp610_01_pmdl.pmdl044)
#        RETURNING g_apsp610_01_pmdl.pmdl044
#   CALL s_aooi200_get_doc_default(g_site,'1',g_apsp610_01_input.pmdldocno,'pmdl046',g_apsp610_01_pmdl.pmdl046)
#        RETURNING g_apsp610_01_pmdl.pmdl046 
#        
#   CALL s_aooi200_get_doc_default(g_site,'1',g_apsp610_01_input.pmdldocno,'pmdl047',g_apsp610_01_pmdl.pmdl047)
#        RETURNING g_apsp610_01_pmdl.pmdl047
#   CALL s_aooi200_get_doc_default(g_site,'1',g_apsp610_01_input.pmdldocno,'pmdl048',g_apsp610_01_pmdl.pmdl048)
#        RETURNING g_apsp610_01_pmdl.pmdl048
#   CALL s_aooi200_get_doc_default(g_site,'1',g_apsp610_01_input.pmdldocno,'pmdl049',g_apsp610_01_pmdl.pmdl049)
#        RETURNING g_apsp610_01_pmdl.pmdl049
#   CALL s_aooi200_get_doc_default(g_site,'1',g_apsp610_01_input.pmdldocno,'pmdl050',g_apsp610_01_pmdl.pmdl050)
#        RETURNING g_apsp610_01_pmdl.pmdl050
#   CALL s_aooi200_get_doc_default(g_site,'1',g_apsp610_01_input.pmdldocno,'pmdl051',g_apsp610_01_pmdl.pmdl051)
#        RETURNING g_apsp610_01_pmdl.pmdl051
#   CALL s_aooi200_get_doc_default(g_site,'1',g_apsp610_01_input.pmdldocno,'pmdl052',g_apsp610_01_pmdl.pmdl052)
#        RETURNING g_apsp610_01_pmdl.pmdl052
#   CALL s_aooi200_get_doc_default(g_site,'1',g_apsp610_01_input.pmdldocno,'pmdl053',g_apsp610_01_pmdl.pmdl053)
#        RETURNING g_apsp610_01_pmdl.pmdl053
#   CALL s_aooi200_get_doc_default(g_site,'1',g_apsp610_01_input.pmdldocno,'pmdl054',g_apsp610_01_pmdl.pmdl054)
#        RETURNING g_apsp610_01_pmdl.pmdl054
#   CALL s_aooi200_get_doc_default(g_site,'1',g_apsp610_01_input.pmdldocno,'pmdl055',g_apsp610_01_pmdl.pmdl055)
#        RETURNING g_apsp610_01_pmdl.pmdl055
#   CALL s_aooi200_get_doc_default(g_site,'1',g_apsp610_01_input.pmdldocno,'pmdl200',g_apsp610_01_pmdl.pmdl200)
#        RETURNING g_apsp610_01_pmdl.pmdl200
#   CALL s_aooi200_get_doc_default(g_site,'1',g_apsp610_01_input.pmdldocno,'pmdl201',g_apsp610_01_pmdl.pmdl201)
#        RETURNING g_apsp610_01_pmdl.pmdl201
#   CALL s_aooi200_get_doc_default(g_site,'1',g_apsp610_01_input.pmdldocno,'pmdl202',g_apsp610_01_pmdl.pmdl202)
#        RETURNING g_apsp610_01_pmdl.pmdl202
#   CALL s_aooi200_get_doc_default(g_site,'1',g_apsp610_01_input.pmdldocno,'pmdl203',g_apsp610_01_pmdl.pmdl203)
#        RETURNING g_apsp610_01_pmdl.pmdl203
#   CALL s_aooi200_get_doc_default(g_site,'1',g_apsp610_01_input.pmdldocno,'pmdl204',g_apsp610_01_pmdl.pmdl204)
#        RETURNING g_apsp610_01_pmdl.pmdl204 
#   CALL s_aooi200_get_doc_default(g_site,'1',g_apsp610_01_input.pmdldocno,'pmdl900',g_apsp610_01_pmdl.pmdl900)
#        RETURNING g_apsp610_01_pmdl.pmdl900
#   CALL s_aooi200_get_doc_default(g_site,'1',g_apsp610_01_input.pmdldocno,'pmdl999',g_apsp610_01_pmdl.pmdl999)
#        RETURNING g_apsp610_01_pmdl.pmdl999
#   CALL s_aooi200_get_doc_default(g_site,'1',g_apsp610_01_input.pmdldocno,'pmdl205',g_apsp610_01_pmdl.pmdl205)
#        RETURNING g_apsp610_01_pmdl.pmdl205
#   CALL s_aooi200_get_doc_default(g_site,'1',g_apsp610_01_input.pmdldocno,'pmdl206',g_apsp610_01_pmdl.pmdl206)
#        RETURNING g_apsp610_01_pmdl.pmdl206
#   CALL s_aooi200_get_doc_default(g_site,'1',g_apsp610_01_input.pmdldocno,'pmdl207',g_apsp610_01_pmdl.pmdl207)
#        RETURNING g_apsp610_01_pmdl.pmdl207
#
#   CALL cl_set_comp_entry("pmdl009_03_01,pmdl010_03_01,pmdl011_03_01,pmdl015_03_01",TRUE)
#   CALL cl_set_comp_entry("pmdl017_03_01,pmdl023_03_01,pmdl054_03_01,pmdl033_03_01,pmdl055_03_01",TRUE)
#
#   IF NOT s_apmp490_set_fields_entry(g_apsp610_01_input.pmdldocno,'pmdl009') THEN
#      CALL cl_set_comp_entry("pmdl009_03_01",FALSE)
#   END IF
#   IF NOT s_apmp490_set_fields_entry(g_apsp610_01_input.pmdldocno,'pmdl010') THEN
#      CALL cl_set_comp_entry("pmdl010_03_01",FALSE)
#   END IF
#   IF NOT s_apmp490_set_fields_entry(g_apsp610_01_input.pmdldocno,'pmdl011') THEN
#      CALL cl_set_comp_entry("pmdl011_03_01",FALSE)
#   END IF
#   IF NOT s_apmp490_set_fields_entry(g_apsp610_01_input.pmdldocno,'pmdl015') THEN
#      CALL cl_set_comp_entry("pmdl015_03_01",FALSE)
#   END IF
#   IF NOT s_apmp490_set_fields_entry(g_apsp610_01_input.pmdldocno,'pmdl017') THEN
#      CALL cl_set_comp_entry("pmdl017_03_01",FALSE)
#   END IF 
#   IF NOT s_apmp490_set_fields_entry(g_apsp610_01_input.pmdldocno,'pmdl023') THEN
#      CALL cl_set_comp_entry("pmdl023_03_01",FALSE)
#   END IF
#   IF NOT s_apmp490_set_fields_entry(g_apsp610_01_input.pmdldocno,'pmdl054') THEN
#      CALL cl_set_comp_entry("pmdl054_03_01",FALSE)
#   END IF
#   IF NOT s_apmp490_set_fields_entry(g_apsp610_01_input.pmdldocno,'pmdl033') THEN
#      CALL cl_set_comp_entry("pmdl033_03_01",FALSE)
#   END IF
#   IF NOT s_apmp490_set_fields_entry(g_apsp610_01_input.pmdldocno,'pmdl055') THEN
#      CALL cl_set_comp_entry("pmdl055_03_01",FALSE)
#   END IF
#
END FUNCTION

################################################################################
# Descriptions...: 料件檢查
# Memo...........:
# Usage..........: CALL apsp610_01_pmdn001_chk(p_pmdn001)
# Input parameter: p_pmdn001：料號
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_01_pmdn001_chk(p_pmdn001)
   DEFINE p_pmdn001     LIKE pmdn_t.pmdn001
   DEFINE l_flag        LIKE type_t.num5
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_ooba002     LIKE ooba_t.ooba002
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_imaastus    LIKE imaa_t.imaastus

   WHENEVER ERROR CONTINUE 

   LET r_success = TRUE
   LET g_errno = ''

   IF NOT cl_null(p_pmdn001) THEN
      #參考v_imaa001的檢查  

      LET l_imaastus = ''
      SELECT imaastus INTO l_imaastus
        FROM imaa_t
       WHERE imaaent = g_enterprise
         AND imaa001 = p_pmdn001

      CASE
         WHEN SQLCA.sqlcode = 100     LET g_errno = 'aim-00001'     #輸入的資料不存在料件主檔中  
         WHEN l_imaastus <> 'Y'       LET g_errno = 'aim-00101'     #輸入的資料狀態不是已確認！ 
         OTHERWISE                    LET g_errno = SQLCA.sqlcode USING '------'
      END CASE 
      
      #如果有錯誤訊息的話就回去 
      IF NOT cl_null(g_errno) THEN
         LET r_success = FALSE
         RETURN r_success
      END IF

      #參考v_imaf001_1 
      LET l_imaastus = ''
      SELECT imaastus INTO l_imaastus
        FROM imaf_t,imaa_t
       WHERE imafent = imaaent
         AND imaf001 = imaa001
         AND imafent = g_enterprise
         AND imafsite = g_site
         AND imaf001 = p_pmdn001

      CASE
         WHEN SQLCA.sqlcode = 100      LET g_errno = 'aim-00066'
         WHEN l_imaastus <> 'Y'        LET g_errno = 'aim-00101'    #輸入的資料狀態不是已確認！ 
         OTHERWISE                     LET g_errno = SQLCA.sqlcode USING '------'
      END CASE

      #如果有錯誤訊息就跳回去  
      IF NOT cl_null(g_errno) THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      #判斷輸入的料件編號是否在控制組限制的產品範圍內，若不在限制內則不允許請購此料 
      CALL s_control_chk_group('3','4',g_user,g_dept,p_pmdn001,'','','','')
           RETURNING l_success,l_flag
      IF NOT l_success THEN      #處理狀態  
         LET r_success = FALSE
         RETURN r_success
      ELSE
         IF NOT l_flag THEN      #是否存在
            LET g_errno = 'apm-00265'           #該料件編號不在當前人員和部門的採購控制組限制的產品範圍內！ 
            LET r_success = FALSE
            RETURN r_success
         END IF
      END IF

      #檢核輸入的料件的生命週期是否在單據別限制範圍內，若不在限制內則不允許請購此料
      CALL s_control_chk_doc('4',g_apsp610_01_input.pmdldocno,p_pmdn001,'','','','')
           RETURNING l_success,l_flag
      IF NOT l_success THEN      #處理狀態  
         LET r_success = FALSE
         RETURN r_success
      ELSE
         IF NOT l_flag THEN      #是否存在
            LET g_errno = 'ain-00015'       #輸入的料件的生命週期不在單據別限制範圍內！  
            LET r_success = FALSE
            RETURN r_success
         END IF
      END IF 
      
      #檢核輸入的料件的產品分類是否在單據別限制範圍內，若不在限制內則不允許請購此料
      CALL s_control_chk_doc('5',g_apsp610_01_input.pmdldocno,p_pmdn001,'','','','')
           RETURNING l_success,l_flag
      IF NOT l_success THEN      #處理狀態  
         LET r_success = FALSE
         RETURN r_success
      ELSE
         IF NOT l_flag THEN      #是否存在
            LET r_success = FALSE
            RETURN r_success
         END IF
      END IF

   END IF

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 反向選取
# Memo...........:
# Usage..........: CALL apsp610_01_change_sel()
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_01_change_sel()
   DEFINE l_i     LIKE type_t.num10    #170104-00066#1 num5->num10  17/01/05 mod by rainy

   WHENEVER ERROR CONTINUE 

   FOR l_i = 1 TO g_pspc_d.getLength()
      IF g_pspc_d[l_i].sel_01 = 'Y' THEN
         LET g_pspc_d[l_i].sel_01 = 'N'
      ELSE
         LET g_pspc_d[l_i].sel_01 = 'Y'
      END IF
   END FOR
END FUNCTION

################################################################################
# Descriptions...: 進入單身選取資料
# Memo...........:
# Usage..........: CALL apsp610_01_data_check()
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_01_data_check()
 
   #DEFINE l_ac1     LIKE type_t.num5   #170104-00066#1 mark by rainy
   DEFINE l_ac1     LIKE type_t.num10   #170104-00066#1 add by rainy
   
   WHENEVER ERROR CONTINUE 

   INPUT ARRAY g_pspc_d FROM s_apsp610_01_detail1.*
         ATTRIBUTE(COUNT = g_d_cnt_p61001,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                   INSERT ROW = FALSE,
                   DELETE ROW = FALSE,
                   APPEND ROW = FALSE)
      BEFORE INPUT

      BEFORE ROW
         LET l_ac1 = ARR_CURR()

      ON CHANGE sel_01
         DISPLAY BY NAME g_pspc_d[l_ac1].sel_01

      ON ACTION CLOSE
         EXIT INPUT

      ON ACTION EXIT
         EXIT INPUT
   END INPUT
END FUNCTION

################################################################################
# Descriptions...: 請購底稿資料檢視
# Memo...........:
# Usage..........: CALL apsp610_01_b_fill_tmp(p_wc)
# Input parameter: p_wc
# Date & Author..: 2016/01/22 By shiun
# Modify.........: 160512-00016#5 2016/06/01 by ming 增加pspc062保稅否
################################################################################
PUBLIC FUNCTION apsp610_01_b_fill_tmp(p_wc)
   DEFINE p_wc     STRING
   DEFINE l_sql    STRING
   DEFINE l_cnt    LIKE type_t.num10      #170104-00066#1 num5->num10  17/01/05 mod by rainy
   DEFINE l_oofa001     LIKE oofa_t.oofa001
   DEFINE l_success     LIKE type_t.num5

   WHENEVER ERROR CONTINUE 

   IF cl_null(p_wc) THEN
      LET p_wc = ' 1=1'
   END IF
   
   LET l_sql = " SELECT 'N',pspc050,imaal003,imaal004,pspc051,'',",
               "        COALESCE(pspc062,'N'), ",      #160512-00016#5 20160601 add 
               "        imaa009,(SELECT rtaxl003 FROM rtaxl_t ",
               "                  WHERE rtaxlent = '",g_enterprise,"' ",
               "                    AND rtaxl001 = imaa009 ",
               "                    AND rtaxl002 = '",g_dlang,"'),",
               "        imaf141,(SELECT oocql004 FROM oocql_t ",
               "                  WHERE oocqlent = '",g_enterprise,"' ",
               "                    AND oocql001 = '203' ",
               "                    AND oocql002 = imaf141 ",
               "                    AND oocql003 = '",g_dlang,"'),",
               "        pspc034,qty,imaf143,(SELECT oocal003 FROM oocal_t ",
               "                              WHERE oocalent = '",g_enterprise,"' ",
               "                                AND oocal001 = imaf143 ",
               "                                AND oocal002 = '",g_dlang,"'), ",
               "        pspc014,(SELECT oocal003 FROM oocal_t ",
               "                  WHERE oocalent = '",g_enterprise,"' ",
               "                    AND oocal001 = pspc014 ",
               "                    AND oocal002 = '",g_dlang,"'),",
               "        pspc010,pspc045,pspc018,imaf142,(SELECT ooag011 FROM ooag_t ",
               "                                          WHERE ooagent = '",g_enterprise,"' ",
               "                                            AND ooag001 = imaf142), ",
               "        imae012,(SELECT ooag011 FROM ooag_t ",
               "                  WHERE ooagent = '",g_enterprise,"' ",
               "                    AND ooag001 = imae012),",
               "        pspc061,pspc055,pspc056,pspc004,pspc001,(SELECT pscal003 FROM pscal_t ",
               "                                                  WHERE pscalent = '",g_enterprise,"' ",
               "                                                    AND pscal001 = pspc001 ",
               "                                                    AND pscal002 = '",g_dlang,"'), ",
               "        pspc002,imaf016,(SELECT oocql004 FROM oocql_t ",
               "                          WHERE oocqlent = '",g_enterprise,"' ",
               "                            AND oocql001 = '210' ",
               "                            AND oocql002 = imaf016 ",
               "                            AND oocql003 = '",g_dlang,"'),",
               "        bmif009,(SELECT oocql004 FROM oocql_t ",
               "                  WHERE oocqlent = '",g_enterprise,"' ",
               "                    AND oocql001 = '1116' ",
               "                    AND oocql002 = bmif009 ",
               "                    AND oocql003 = '",g_dlang,"'),bmif012 ",
               "   FROM p610_01_pspc_t ",
               "   LEFT OUTER JOIN imaal_t ON imaalent = '",g_enterprise,"' AND imaal001 = pspc050 AND imaal002 = '",g_dlang,"'",
               "  WHERE ",p_wc CLIPPED,
               "  ORDER BY pspc050 "
   PREPARE p610_01_tmp_prep FROM l_sql
   DECLARE p610_01_tmp_curs CURSOR FOR p610_01_tmp_prep

   CALL g_pspc_d.clear()

   LET l_cnt = 1
   #170203-00016#1-s-mod 拿掉USING g_enterprise
   ##FOREACH p610_01_tmp_curs INTO g_pspc_d[l_cnt].* #161109-00085#61 mark
   ##161109-00085#61 --s add
   #FOREACH p610_01_tmp_curs USING g_enterprise INTO g_pspc_d[l_cnt].sel_01,g_pspc_d[l_cnt].pspc050_01,g_pspc_d[l_cnt].pspc050_01_desc,g_pspc_d[l_cnt].pspc050_01_desc_1,g_pspc_d[l_cnt].pspc051_01,
   #                                                 g_pspc_d[l_cnt].pspc051_01_desc,g_pspc_d[l_cnt].pspc062_01,g_pspc_d[l_cnt].imaa009_01,g_pspc_d[l_cnt].imaa009_01_desc,g_pspc_d[l_cnt].imaf141_01,         
   #                                                 g_pspc_d[l_cnt].imaf141_01_desc,g_pspc_d[l_cnt].pspc034_01,g_pspc_d[l_cnt].qty_01,g_pspc_d[l_cnt].imaf143_01,g_pspc_d[l_cnt].imaf143_01_desc,    
   #                                                 g_pspc_d[l_cnt].pspc014_01,g_pspc_d[l_cnt].pspc014_01_desc,g_pspc_d[l_cnt].pspc010_01,g_pspc_d[l_cnt].pspc045_01,g_pspc_d[l_cnt].pspc018_01,        
   #                                                 g_pspc_d[l_cnt].imaf142_01,g_pspc_d[l_cnt].imaf142_01_desc,g_pspc_d[l_cnt].imae012_01,g_pspc_d[l_cnt].imae012_01_desc,g_pspc_d[l_cnt].pspc061_01,         
   #                                                 g_pspc_d[l_cnt].pspc055_01,g_pspc_d[l_cnt].pspc056_01,g_pspc_d[l_cnt].pspc004_01,g_pspc_d[l_cnt].pspc001_01,g_pspc_d[l_cnt].pspc001_01_desc,    
   #                                                 g_pspc_d[l_cnt].pspc002_01,g_pspc_d[l_cnt].imaf016_01,g_pspc_d[l_cnt].imaf016_01_desc,g_pspc_d[l_cnt].bmif009_01,g_pspc_d[l_cnt].bmif009_01_desc,    
   #                                                 g_pspc_d[l_cnt].bmif012_01
   ##161109-00085#61 --e add
   FOREACH p610_01_tmp_curs INTO g_pspc_d[l_cnt].sel_01,g_pspc_d[l_cnt].pspc050_01,g_pspc_d[l_cnt].pspc050_01_desc,g_pspc_d[l_cnt].pspc050_01_desc_1,g_pspc_d[l_cnt].pspc051_01,
                                 g_pspc_d[l_cnt].pspc051_01_desc,g_pspc_d[l_cnt].pspc062_01,g_pspc_d[l_cnt].imaa009_01,g_pspc_d[l_cnt].imaa009_01_desc,g_pspc_d[l_cnt].imaf141_01,         
                                 g_pspc_d[l_cnt].imaf141_01_desc,g_pspc_d[l_cnt].pspc034_01,g_pspc_d[l_cnt].qty_01,g_pspc_d[l_cnt].imaf143_01,g_pspc_d[l_cnt].imaf143_01_desc,    
                                 g_pspc_d[l_cnt].pspc014_01,g_pspc_d[l_cnt].pspc014_01_desc,g_pspc_d[l_cnt].pspc010_01,g_pspc_d[l_cnt].pspc045_01,g_pspc_d[l_cnt].pspc018_01,        
                                 g_pspc_d[l_cnt].imaf142_01,g_pspc_d[l_cnt].imaf142_01_desc,g_pspc_d[l_cnt].imae012_01,g_pspc_d[l_cnt].imae012_01_desc,g_pspc_d[l_cnt].pspc061_01,         
                                 g_pspc_d[l_cnt].pspc055_01,g_pspc_d[l_cnt].pspc056_01,g_pspc_d[l_cnt].pspc004_01,g_pspc_d[l_cnt].pspc001_01,g_pspc_d[l_cnt].pspc001_01_desc,    
                                 g_pspc_d[l_cnt].pspc002_01,g_pspc_d[l_cnt].imaf016_01,g_pspc_d[l_cnt].imaf016_01_desc,g_pspc_d[l_cnt].bmif009_01,g_pspc_d[l_cnt].bmif009_01_desc,    
                                 g_pspc_d[l_cnt].bmif012_01
   #170203-00016#1-e-mod
      IF STATUS THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = STATUS
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      IF NOT cl_null(g_pspc_d[l_cnt].pspc051_01) THEN
         CALL s_feature_description(g_pspc_d[l_cnt].pspc050_01,g_pspc_d[l_cnt].pspc051_01)
              RETURNING l_success,g_pspc_d[l_cnt].pspc051_01_desc
      END IF

      LET l_cnt = l_cnt + 1

      IF l_cnt > g_max_rec THEN
         EXIT FOREACH
      END IF

   END FOREACH

   CALL g_pspc_d.deleteElement(l_cnt)
   LET l_cnt = l_cnt - 1
END FUNCTION

################################################################################
# Descriptions...: 刪除請購底稿資料
# Memo...........:
# Usage..........: CALL apsp610_01_del_tmp()
# Date & Author..: 2016/01/22 By shiun
# Modify.........: 160512-00016#5  2016/06/01 by ming 增加欄位pspc062保稅否
################################################################################
PUBLIC FUNCTION apsp610_01_del_tmp()
   DEFINE l_i     LIKE type_t.num10     #170104-00066#1 num5->num10  17/01/05 mod by rainy
   DEFINE l_cnt   LIKE type_t.num5

   WHENEVER ERROR CONTINUE 

   FOR l_i = 1 TO g_pspc_d.getLength()
      IF g_pspc_d[l_i].sel_01 = 'Y' THEN
         #160606-00006#1 20160614 modify by ming -----(S) 
         #DELETE FROM p610_01_pspc_t
         # WHERE pspc050 = g_pspc_d[l_i].pspc050_01
         #   AND pspc051 = g_pspc_d[l_i].pspc051_01
         #   AND pspc062 = g_pspc_d[l_i].pspc062_01     #160512-00016#5 20160601 add 
         #   AND pspc034 = g_pspc_d[l_i].pspc034_01
         #   AND pspc014 = g_pspc_d[l_i].pspc014_01
         #   AND pspc010 = g_pspc_d[l_i].pspc010_01
         #   AND pspc045 = g_pspc_d[l_i].pspc045_01
         #   AND pspc018 = g_pspc_d[l_i].pspc018_01
         #   AND pspc061 = g_pspc_d[l_i].pspc061_01
         DELETE FROM p610_01_pspc_t
          WHERE pspc001 = g_pspc_d[l_i].pspc001_01 
            AND pspc002 = g_pspc_d[l_i].pspc002_01 
            AND pspc004 = g_pspc_d[l_i].pspc004_01 
         #160606-00006#1 20160614 modify by ming -----(E) 
      END IF
   END FOR
END FUNCTION

################################################################################
# Descriptions...: 執行全選或全不選功能
# Memo...........:
# Usage..........: CALL apsp610_01_sel_all(p_flag)
# Input parameter: p_flag：Y(全選)/N(全不選
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_01_sel_all(p_flag)
   DEFINE p_flag  LIKE type_t.chr1 
   DEFINE l_i     LIKE type_t.num5

   WHENEVER ERROR CONTINUE 

   FOR l_i = 1 TO g_pspc_d.getLength()
      LET g_pspc_d[l_i].sel_01 = p_flag 
   END FOR
END FUNCTION

################################################################################
# Descriptions...: 設定右方button的顯示與隱藏
# Memo...........:
# Usage..........: CALL apsp610_01_set_act_visible(p_mode)
# Input parameter: p_mode：i(輸入)/d(檢視底稿)
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp610_01_set_act_visible(p_mode)
  DEFINE p_mode     LIKE type_t.chr1 
  
  WHENEVER ERROR CONTINUE 
  
  CALL cl_set_comp_visible("sel_all",FALSE) 
  CALL cl_set_comp_visible("change_sel",FALSE) 
  CALL cl_set_comp_visible("see_pspc_tmp",FALSE) 
  CALL cl_set_comp_visible("del_pspc_tmp",FALSE) 
  CALL cl_set_comp_visible("sel_mode",FALSE) 
  
  CASE p_mode 
     WHEN 'i' 
        CALL cl_set_comp_visible("sel_all",TRUE)
        CALL cl_set_comp_visible("nosel_all",TRUE)
        CALL cl_set_comp_visible("change_sel",TRUE)
        CALL cl_set_comp_visible("see_pspc_tmp",TRUE)
     WHEN 'd'  
        #檢視底稿模式，也要加入全選/全不選 
        CALL cl_set_comp_visible("sel_all",TRUE)
        CALL cl_set_comp_visible("nosel_all",TRUE)
        CALL cl_set_comp_visible("del_pspc_tmp",TRUE)
        CALL cl_set_comp_visible("sel_mode",TRUE)
  END  CASE 
END FUNCTION

################################################################################
# Descriptions...: 科目預算的處理
# Memo...........:
# Usage..........: CALL apsp610_01_detail_abg(p_pmdadocno,p_pmdbseq,p_type)
#                  RETURNING r_success,r_errno,r_bgaf016,r_bgae001,r_bgae001_desc
# Input parameter: p_pmdadocno    單號 
#                  p_pmdbseq      項次 
#                : p_type         1.預算項目開窗
#                                 2.預算項目檢核
#                                 3.預算項目說明
#                                 4.檢核金額
# Return code....: r_success      TRUE/FALSE
#                : r_errno        錯誤訊息
#                : r_bgaf016      錯誤處理方式
#                : r_bgae001      預算項目
#                : r_bgae001_desc 說明
# Date & Author..: 2016/01/22 By shiun
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp610_01_detail_abg(p_pmdadocno,p_pmdbseq,p_type)
   DEFINE p_pmdadocno    LIKE pmda_t.pmdadocno
   DEFINE p_pmdbseq      LIKE pmdb_t.pmdbseq
   DEFINE p_type         LIKE type_t.chr10
#   DEFINE r_success      LIKE type_t.num5
#   DEFINE r_errno        LIKE gzze_t.gzze001
#   DEFINE r_bgaf016      LIKE bgaf_t.bgaf016
#   DEFINE r_bgae001      LIKE bgae_t.bgae001
#   DEFINE r_bgae001_desc LIKE type_t.chr80
#   DEFINE l_success      LIKE type_t.num5
#   DEFINE l_slip         LIKE pmda_t.pmdadocno
#   DEFINE l_imaa009      LIKE imaa_t.imaa009
#   DEFINE l_tran         RECORD
#                            act              LIKE type_t.chr10,   #[1].chr 動作
#                            site             LIKE ooef_t.ooef001, #[2].chr 預算組織
#                            dat              LIKE type_t.dat,     #[3].dat 日期
#                            bgae001          LIKE bgae_t.bgae001, #[4].chr 預算項目
#                            bgbd013          LIKE bgbd_t.bgbd013, #[5].chr 部門
#                            bgbd014          LIKE bgbd_t.bgbd014, #[6].chr 利潤成本中心
#                            bgbd015          LIKE bgbd_t.bgbd015, #[7].chr 區域
#                            bgbd016          LIKE bgbd_t.bgbd016, #[8].chr 交易客商
#                            bgbd017          LIKE bgbd_t.bgbd017, #[9].chr 收款客商
#                            bgbd018          LIKE bgbd_t.bgbd018, #[10].chr 客群
#                            bgbd019          LIKE bgbd_t.bgbd019, #[11].chr 產品類別
#                            bgbd020          LIKE bgbd_t.bgbd020, #[12].chr 人員
#                            bgbd021          LIKE bgbd_t.bgbd021, #[13].chr 專案
#                            bgbd022          LIKE bgbd_t.bgbd022, #[14].chr WBS
#                            bgbd023          LIKE bgbd_t.bgbd023, #[15].chr 經營方式
#                            bgbd024          LIKE bgbd_t.bgbd024, #[16].chr 自由核算項一
#                            bgbd025          LIKE bgbd_t.bgbd025, #[17].chr 自由核算項二
#                            bgbd026          LIKE bgbd_t.bgbd026, #[18].chr 自由核算項三 
#                            bgbd027          LIKE bgbd_t.bgbd027, #[19].chr 自由核算項四
#                            bgbd028          LIKE bgbd_t.bgbd028, #[20].chr 自由核算項五
#                            bgbd029          LIKE bgbd_t.bgbd029, #[21].chr 自由核算項六
#                            bgbd030          LIKE bgbd_t.bgbd030, #[22].chr 自由核算項七
#                            bgbd031          LIKE bgbd_t.bgbd031, #[23].chr 自由核算項八
#                            bgbd032          LIKE bgbd_t.bgbd032, #[24].chr 自由核算項九
#                            bgbd033          LIKE bgbd_t.bgbd033, #[25].chr 自由核算項十
#                            bgbd042          LIKE bgbd_t.bgbd042, #[26].chr 渠道
#                            bgbd043          LIKE bgbd_t.bgbd043, #[27].chr 品牌
#                            used036          LIKE bgbd_t.bgbd036, #[28].chr 使用程式
#                            used037          LIKE bgbd_t.bgbd037, #[29].chr 使用單號 
#                            used038          LIKE bgbd_t.bgbd038, #[30].chr 使用項次
#                            sour036          LIKE bgbd_t.bgbd036, #[31].chr 轉出程式
#                            sour037          LIKE bgbd_t.bgbd037, #[32].chr 轉出單號
#                            sour038          LIKE bgbd_t.bgbd038, #[33].chr 轉出項次
#                            curr             LIKE ooai_t.ooai001, #[34].chr 幣別
#                            account          LIKE type_t.num20_6 #[35].chr 金額
#                         END RECORD
#   DEFINE ls_js          STRING
#   DEFINE l_pmda         RECORD LIKE pmda_t.*
#   DEFINE l_pmdb         RECORD LIKE pmdb_t.*
#
#   LET r_success      = TRUE
#   LET r_errno        = ''
#   LET r_bgaf016      = ''
#   LET r_bgae001      = ''
#   LET r_bgae001_desc = ''
#
#   INITIALIZE l_pmda.* TO NULL 
#   SELECT * INTO l_pmda.*
#     FROM pmda_t
#    WHERE pmdaent   = g_enterprise
#      AND pmdadocno = p_pmdadocno
#
#   INITIALIZE l_pmdb.* TO NULL
#   SELECT * INTO l_pmdb.*
#     FROM pmdb_t
#    WHERE pmdbent   = g_enterprise
#      AND pmdbdocno = p_pmdadocno
#      AND pmdbseq   = p_pmdbseq
#
#   CALL s_aooi200_get_slip(p_pmdadocno)
#        RETURNING l_success,l_slip
#   IF cl_get_doc_para(g_enterprise,g_site,l_slip,'D-FIN-5002') = 'N' THEN
#      RETURN r_success,r_errno,r_bgaf016,r_bgae001,r_bgae001_desc
#   END IF
#
#   SELECT imaa009 INTO l_imaa009
#     FROM imaa_t
#    WHERE imaaent = g_enterprise
#      AND imaa001 = l_pmdb.pmdb004
#
#   INITIALIZE l_tran.* TO NULL
#   LET l_tran.site = g_site
#   LET l_tran.dat  = l_pmda.pmdadocdt
#   LET l_tran.bgae001 = l_pmdb.pmdb053
#   LET l_tran.bgbd013 = l_pmda.pmda003
#   LET l_tran.bgbd016 = l_pmdb.pmdb015
#   LET l_tran.bgbd019 = l_imaa009 
#   LET l_tran.bgbd020 = l_pmda.pmda002
#   LET l_tran.bgbd021 = l_pmdb.pmdb034
#   LET l_tran.bgbd022 = l_pmdb.pmdb035
#   LET l_tran.used036 = 'apmt400'
#   LET l_tran.used037 = p_pmdadocno
#   LET l_tran.used038 = p_pmdbseq
#   LET l_tran.curr    = l_pmda.pmda005
#   LET l_tran.account = l_pmdb.pmdb020
#
#   LET ls_js = util.JSON.stringify(l_tran)
#
#   #1.預算項目開窗
#   #2.預算項目檢核
#   #3.預算項目說明
#   #4.檢核金額
#

#   #為了客戶客製，暫時mark 此功能 
#   CASE p_type
#      WHEN '1'
#           CALL s_abg_bgae001_query2(ls_js)
#                RETURNING r_bgae001
#
#           LET l_tran.bgae001 = r_bgae001
#           LET ls_js = util.JSON.stringify(l_tran) 
#           CALL s_abg_bgae001_desc2(ls_js)
#                RETURNING r_bgae001_desc
#      WHEN '2'
#           CALL s_abg_bgae001_chk2(ls_js)
#                RETURNING r_success,r_errno
#           IF r_success THEN
#              CALL s_abg_bgae001_desc2(ls_js)
#                   RETURNING r_bgae001_desc
#           END IF
#      WHEN '3'
#           CALL s_abg_bgae001_desc2(ls_js)
#                RETURNING r_bgae001_desc
#      WHEN '4'
#           CALL s_abg_bg_used_chk(ls_js)
#                RETURNING r_success,r_errno,r_bgaf016
#   END CASE
#
#   RETURN r_success,r_errno,r_bgaf016,r_bgae001,r_bgae001_desc
   
END FUNCTION

PRIVATE FUNCTION apsp610_01_aps_desc(p_aps)
   DEFINE p_aps  LIKE psca_t.psca001
   DEFINE r_desc LIKE type_t.chr80
   
   SELECT pscal003 INTO r_desc
     FROM pscal_t
    WHERE pscalent = g_enterprise
      AND pscalsite = g_site
      AND pscal001 = p_aps
      AND pscal002 = g_dlang
   RETURN r_desc
END FUNCTION

 
{</section>}
 
