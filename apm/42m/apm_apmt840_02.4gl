#該程式未解開Section, 採用最新樣板產出!
{<section id="apmt840_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0014(2016-07-08 14:16:08), PR版次:0014(2016-11-28 17:42:47)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000059
#+ Filename...: apmt840_02
#+ Description: 自動產生單身
#+ Creator....: 02003(2015-06-28 20:28:30)
#+ Modifier...: 06189 -SD/PR- 00700
 
{</section>}
 
{<section id="apmt840_02.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"
#160318-00005#38  2016/03/29 By 07900   重复错误讯息修改
#160318-00025#52  2016/04/27 By 07673   將重複內容的錯誤訊息置換為公用錯誤訊息
#add by geza 20160707 #160708-00002#1   所属品类能够多选开窗，按照品类过滤资料，数量后面增加单位栏位，根据商品主档设置来确定是否可以修改。  
#161104-00002#11  2016/11/10 By Rainy  將程式中 *寫法改掉
#161128-00058#1   2016/11/28  By Rainy   調整161104-00002#11漏掉的SELECT * 寫法
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
 
{<section id="apmt840_02.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
 TYPE type_g_rtdx_d RECORD
       sel LIKE type_t.chr500,
       star001  LIKE star_t.star001,
       star004  LIKE star_t.star004,
       starsite LIKE star_t.starsite,
       l_imaz003 LIKE type_t.chr500,       
       rtdx001 LIKE rtdx_t.rtdx001, 
       rtdx001_desc LIKE type_t.chr500,
       rtdx001_desc_desc LIKE type_t.chr500,   
       deba002   LIKE deba_t.deba002,   #150616-00035#82   add by yangxf        
       rtdx002 LIKE rtdx_t.rtdx002, 
       l_pmdb212 LIKE pmdb_t.pmdb212,
       l_imaz006 LIKE imaz_t.imaz006,   #補貨規格說明   #150710-00016#5 150713 by sakura add        
       rtdx004 LIKE rtdx_t.rtdx004, 
       rtdx004_desc LIKE type_t.chr500,    
       l_pmdb006 LIKE pmdb_t.pmdb006, 
       rtdx034   LIKE rtdx_t.rtdx034,   #进价          #add by geza 20160707 #160708-00002#1
       l_pmdb007 LIKE pmdb_t.pmdb007, 
       pmdb007_desc LIKE type_t.chr500, 
       rtdx044 LIKE rtdx_t.rtdx044,
       rtdx044_desc LIKE type_t.chr500,   
       l_pmdb252 LIKE pmdb_t.pmdb252, 
       l_pmdb259 LIKE pmdb_t.pmdb259
       END RECORD
 
 
 
#模組變數(Module Variables)
DEFINE g_rtdx_d          DYNAMIC ARRAY OF type_g_rtdx_d #單身變數
DEFINE g_rtdx_d_t        type_g_rtdx_d                  #單身備份
DEFINE g_rtdx_d_o        type_g_rtdx_d                  #單身備份
DEFINE g_rtdx_d_mask_o   DYNAMIC ARRAY OF type_g_rtdx_d #單身變數
DEFINE g_rtdx_d_mask_n   DYNAMIC ARRAY OF type_g_rtdx_d #單身變數
 
 
DEFINE g_rec_b              LIKE type_t.num5 
DEFINE g_wc                 STRING      
DEFINE g_wc2                STRING
DEFINE g_sql                STRING
DEFINE g_forupd_sql         STRING                        #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_t.num5
DEFINE g_cnt                LIKE type_t.num10    
DEFINE l_ac                 LIKE type_t.num10             #目前處理的ARRAY CNT 
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_temp_idx           LIKE type_t.num10             #單身 所在筆數(暫存用)
DEFINE g_detail_idx         LIKE type_t.num10             #單身 所在筆數(所有資料)
DEFINE g_detail_cnt         LIKE type_t.num10             #單身 總筆數(所有資料)
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_chk                BOOLEAN
DEFINE g_aw                 STRING                        #確定當下點擊的單身
DEFINE g_log1               STRING                        #log用
DEFINE g_log2               STRING                        #log用
 
#多table用wc
DEFINE g_wc_table           STRING
#end add-point
 
{</section>}
 
{<section id="apmt840_02.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_where_sql           STRING
DEFINE g_pmdasite            LIKE pmda_t.pmdasite    #要貨組織
DEFINE g_pmdadocdt           LIKE pmda_t.pmdadocdt   #要貨日期
DEFINE g_pmdadocno           LIKE pmda_t.pmdadocno   #要貨單號
#161104-00002#11 161110 By rainy mod---(S) 
 #調整*寫法    
#DEFINE g_pmdl                RECORD LIKE pmdl_t.*
DEFINE g_pmdl RECORD  #採購單頭檔
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
       pmdl205 LIKE pmdl_t.pmdl205, #採購最終有效日
       pmdl206 LIKE pmdl_t.pmdl206, #長效期訂單否
       pmdl207 LIKE pmdl_t.pmdl207, #所屬品類
       pmdl208 LIKE pmdl_t.pmdl208  #電子採購單號
END RECORD
#161104-00002#11 161110 By rainy mod---(E) 
DEFINE l_imaa009             LIKE imaa_t.imaa009     #所屬品類
DEFINE imaa009_desc          LIKE type_t.chr100      #品類說明
#DEFINE g_success             LIKE type_t.num5
#end add-point
 
{</section>}
 
{<section id="apmt840_02.other_dialog" >}

 
{</section>}
 
{<section id="apmt840_02.other_function" readonly="Y" >}

PUBLIC FUNCTION apmt840_02(--)
   #add-point:main段變數傳入
   p_pmdldocno,
   p_pmdldocdt,
   p_pmdlsite
   #end add-point
   )
   #add-point:main段define
   DEFINE p_pmdldocdt     LIKE pmdl_t.pmdldocdt   #要貨日期
   DEFINE p_pmdldocno     LIKE pmdl_t.pmdldocno   #要貨單號
   DEFINE p_pmdlsite      LIKE pmdl_t.pmdlsite    #要貨組織
   #end add-point
   #add-point:main段define(客製用)

   #end add-point

   IF cl_null(p_pmdldocno) THEN
      RETURN
   END IF

   CREATE TEMP TABLE apmt840_02_tmp (
       sel           VARCHAR(1),            #選擇
       starsite      VARCHAR(10),        #门店
       star001       VARCHAR(20),         #协议编号
       star004       VARCHAR(20),         #合同编号
       rtdx001       VARCHAR(40),         #商品編號
       rtdx002       VARCHAR(40),         #商品主條碼
       pmdn006       VARCHAR(10),         #要貨單位
       pmdn007       DECIMAL(20,6),         #要貨數量
       imaz003       VARCHAR(40),         #補貨條碼
       imaz006       VARCHAR(80),         #補貨規格說明   #150710-00016#5 150713 by sakura add
       deba002       DATE,         #销售日期       #150616-00035#3 add by yangxf
       rtdx004       VARCHAR(10),         #包裝單位
       pmdn202       DECIMAL(20,6),         #要貨包裝數量
       rtdx034       DECIMAL(20,6),         #进价          #add by geza 20160707 #160708-00002#1
       rtdx044       VARCHAR(10),         #庫位編號
       pmdn206       DECIMAL(20,6),         #現有庫存
       pmdn209       DECIMAL(20,6),         #週平均銷量
       pmdn210       DECIMAL(20,6),         #前一週銷量
       pmdn211       DECIMAL(20,6),         #前二週銷量
       pmdn212       DECIMAL(20,6),         #前三週銷量
       pmdn213       DECIMAL(20,6),         #前四週銷量
       pmdn207       DECIMAL(20,6),         #要貨在途量  
       rtdx028       VARCHAR(10),         #採購中心
       rtdx029       VARCHAR(10));        #配送中心
  
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log

   #畫面開啟 (identifier)
   OPEN WINDOW w_apmt840_02 WITH FORM cl_ap_formpath("apm","apmt840_02")

   #瀏覽頁簽資料初始化
   CALL cl_ui_init()

   #程式初始化
   CALL apmt840_02_init()
   LET g_pmdasite = p_pmdlsite
   LET g_pmdadocdt = p_pmdldocdt
   LET g_pmdadocno = p_pmdldocno

   CALL apmt840_02_get_pmda()
   CALL apmt840_02_input()

   #畫面關閉
   CLOSE WINDOW w_apmt840_02




   #add-point:離開前
   DROP TABLE apmt840_02_tmp
   #end add-point
   #RETURN g_success
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt840_02_input()
DEFINE l_cnt        LIKE type_t.num5
DEFINE l_success    LIKE type_t.num5
DEFINE l_where      STRING
DEFINE l_sql        STRING
DEFINE l_sys        LIKE type_t.num5   
DEFINE l_n          LIKE type_t.num5
DEFINE li_idx       LIKE type_t.num10
DEFINE l_rtdx034       LIKE rtdx_t.rtdx034 #add by geza 20160707 #160708-00002#1
DEFINE l_stan024   LIKE stan_t.stan024 #add by geza 20160707 #160708-00002#1 
   CLEAR FORM
   CALL g_rtdx_d.clear()

   INITIALIZE g_wc TO NULL

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      #mark by geza 20160707 #160708-00002#1(S)
#      INPUT BY NAME l_imaa009 ATTRIBUTE(WITHOUT DEFAULTS) 
#         
#         
#         BEFORE INPUT
#            LET l_imaa009 = g_pmdl.pmdl207
#            DISPLAY l_imaa009 TO l_imaa009
#            
#         AFTER FIELD l_imaa009
#            LET imaa009_desc = ''
#            DISPLAY BY NAME imaa009_desc    
#            IF NOT cl_null(l_imaa009) THEN                            
#               INITIALIZE g_chkparam.* TO NULL
#               LET g_chkparam.arg1 = l_imaa009
#               CALL cl_get_para(g_enterprise,g_site,'E-CIR-0001') RETURNING l_sys
#               LET g_chkparam.arg2 = l_sys
#               LET g_errshow = TRUE   #160318-00025#51
#               LET g_chkparam.err_str[1] = "ast-00215:sub-01302|arti202|",cl_get_progname("arti202",g_lang,"2"),"|:EXEPROGarti202"    #160318-00025#52   
#               #呼叫檢查存在並帶值的library
#               IF NOT cl_chk_exist("v_rtax001_2") THEN
#                  LET l_imaa009 = ''
#                  #檢查失敗時後續處理
#                  NEXT FIELD CURRENT
#               END IF
#               
#               IF NOT cl_null(g_pmdl.pmdl003) THEN
#                  #檢查是否屬於arti204設置的部門品類
#                  LET l_n = 0
#                  SELECT COUNT(*) INTO l_n FROM rtaz_t
#                   WHERE rtazent = g_enterprise
#                     AND rtaz001 = g_prog
#                     AND rtazstus = 'Y'
#                  IF l_n > 0 THEN
#                     #當rtaz_t設定該程式代號 代表 該程式受arti204的控管
#                     SELECT COUNT(*) INTO l_n FROM rtay_t
#                      WHERE rtayent = g_enterprise
#                        AND rtay001 = g_pmdl.pmdl003
#                        AND rtay002 = l_imaa009
#                        AND rtaystus = 'Y'
#                     IF l_n < 1 THEN
#                        INITIALIZE g_errparam TO NULL
#                        LET g_errparam.code = 'apr-00357'
#                        LET g_errparam.extend = ''
#                        LET g_errparam.popup = TRUE
#                        CALL cl_err()                  
#                        LET l_imaa009 = ''
#                        NEXT FIELD CURRENT
#                     END IF
#                  END IF
#               END IF
#            END IF         
#            
#            CALL s_desc_get_rtaxl003_desc(l_imaa009) RETURNING imaa009_desc
#            DISPLAY BY NAME imaa009_desc          
#
#         BEFORE FIELD l_imaa009
#            IF NOT cl_null(l_imaa009) THEN
#               NEXT FIELD NEXT
#            END IF
#
#         #----<<l_imaa009>>----
#         #Ctrlp:construct.c.limaa009
#         ON ACTION controlp INFIELD l_imaa009
#            INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'i'
#            LET g_qryparam.reqry = FALSE
#            LET g_qryparam.default1 = l_imaa009             #給予default值
#			   CALL cl_get_para(g_enterprise,g_site,'E-CIR-0001') RETURNING l_sys #取得品類層級
#            LET g_qryparam.arg1 = l_sys #
#
#            SELECT COUNT(*) INTO l_n
#              FROM rtaz_t
#             WHERE rtazent = g_enterprise
#               AND rtaz001 = g_prog
#               AND rtazstus = 'Y'
#            IF l_n > 0 THEN
#               LET g_qryparam.where = " rtax001 IN (SELECT rtay002 FROM rtay_t WHERE rtayent = ",g_enterprise," ",
#                                      "                AND rtay001 = '",g_pmdl.pmdl003,"' AND rtaystus = 'Y') "
#            END IF
#            CALL q_rtax001_3()                  #呼叫開窗
#            LET l_imaa009 = g_qryparam.return1
#            DISPLAY BY NAME l_imaa009
#            CALL s_desc_get_rtaxl003_desc(l_imaa009) RETURNING imaa009_desc
#            DISPLAY BY NAME imaa009_desc              
#            NEXT FIELD l_imaa009                     #返回原欄位
#                    
#      END INPUT
      #mark by geza 20160707 #160708-00002#1(E)
      
      CONSTRUCT BY NAME g_wc ON starsite,l_imaa009  #add by geza 20160707 #160708-00002#1
         BEFORE CONSTRUCT 
            DISPLAY g_pmdasite TO starsite
         #一般欄位開窗相關處理
         #---------------------------<  Master  >---------------------------
         ON ACTION controlp INFIELD starsite
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmdlsite',g_pmdl.pmdlsite,'i')
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO starsite  #顯示到畫面上
            NEXT FIELD starsite                     #返回原欄位
         #add by geza 20160707 #160708-00002#1(S)   
         ON ACTION controlp INFIELD l_imaa009
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = l_imaa009             #給予default值
			   CALL cl_get_para(g_enterprise,g_site,'E-CIR-0001') RETURNING l_sys #取得品類層級
            LET g_qryparam.arg1 = l_sys #
            LET g_qryparam.where = " EXISTS (SELECT 1 FROM staq_t,star_t WHERE staqent = ",g_enterprise," AND staq001 = star004 
                                             AND staq003 = rtax001 AND starent = staqent AND star003 = '",g_pmdl.pmdl004,"' )"
            SELECT COUNT(*) INTO l_n
              FROM rtaz_t
             WHERE rtazent = g_enterprise
               AND rtaz001 = g_prog
               AND rtazstus = 'Y'
            IF l_n > 0 THEN
               LET g_qryparam.where = g_qryparam.where," AND rtax001 IN (SELECT rtay002 FROM rtay_t WHERE rtayent = ",g_enterprise," ",
                                      "                AND rtay001 = '",g_pmdl.pmdl003,"' AND rtaystus = 'Y') "
            END IF
            CALL q_rtax001_3()                  #呼叫開窗
            DISPLAY g_qryparam.return1 TO l_imaa009  #顯示到畫面上
            NEXT FIELD l_imaa009       
         #add by geza 20160707 #160708-00002#1(E)         
      END CONSTRUCT
      
      INPUT ARRAY g_rtdx_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = FALSE, 
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
         
         BEFORE INPUT
            CALL apmt840_02_b_fill()           
            LET g_rec_b = g_rtdx_d.getLength()
            DISPLAY "g_rec_b:",g_rec_b
            
         BEFORE ROW
            LET l_ac = ARR_CURR()
            LET g_rtdx_d_t.* = g_rtdx_d[l_ac].*
            LET g_rtdx_d_o.* = g_rtdx_d[l_ac].*  
            CALL apmt840_02_set_entry_b("a")
            CALL apmt840_02_set_no_entry_b("a")

         #add by geza 20160707 #160708-00002#1(S)
         BEFORE FIELD rtdx034
            #add by geza 20160707 #160708-00002#1(S)          
            SELECT stan024 INTO l_stan024
              FROM stan_t
             WHERE stanent = g_enterprise
               AND stan001 = g_rtdx_d[l_ac].star004
            IF l_stan024 = 'N' THEN
               NEXT FIELD sel
            END IF               
            #add by geza 20160707 #160708-00002#1(E)
         AFTER FIELD rtdx034
            IF NOT cl_ap_chk_range(g_rtdx_d[l_ac].rtdx034,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD rtdx034
            END IF             
            
            IF NOT cl_null(g_rtdx_d[l_ac].rtdx034) THEN
               #抓出单价
               LET l_rtdx034 =''
               SELECT stas011 INTO l_rtdx034
                 FROM stas_t,star_t
                WHERE stasent = g_enterprise
                  AND starent = stasent
                  AND starsite = stassite
                  AND star001 = stas001
                  AND stas001 = g_rtdx_d[l_ac].star001
                  AND g_pmdl.pmdldocdt BETWEEN stas026 AND stas027
                  AND stas003 = g_rtdx_d[l_ac].rtdx001
                  AND starstus = 'Y'          
                  AND stassite = g_rtdx_d[l_ac].starsite
               IF l_rtdx034 IS  NULL THEN
                  SELECT stas010 INTO l_rtdx034
                    FROM stas_t,star_t
                   WHERE stasent = g_enterprise
                     AND starent = stasent
                     AND starsite = stassite
                     AND star001 = stas001
                     AND stas001 = g_rtdx_d[l_ac].star001
                     AND stas003 = g_rtdx_d[l_ac].rtdx001
                     AND starstus = 'Y'          
                     AND stassite = g_rtdx_d[l_ac].starsite
               END IF
               #單價容差率控卡
               IF NOT s_apm_price_get_stan025_chk(g_rtdx_d[l_ac].star004,g_rtdx_d[l_ac].rtdx034,l_rtdx034) THEN
                  NEXT FIELD CURRENT 
               ELSE
                  #更新临时表价格
                  UPDATE apmt840_02_tmp
                     SET rtdx034 = g_rtdx_d[l_ac].rtdx034
                   WHERE rtdx001 = g_rtdx_d[l_ac].rtdx001                  
               END IF 
            END IF
         #add by geza 20160707 #160708-00002#1(E)
         #要貨包裝數量
         AFTER FIELD l_pmdb212
            IF NOT cl_ap_chk_range(g_rtdx_d[l_ac].l_pmdb212,"0","0","","","azz-00079",1) THEN
               NEXT FIELD l_pmdb212
            END IF             
            
            IF NOT cl_null(g_rtdx_d[l_ac].l_pmdb212) THEN
               IF g_rtdx_d[l_ac].l_pmdb212 != g_rtdx_d_o.l_pmdb212 OR cl_null(g_rtdx_d_o.l_pmdb212) THEN                         
                  #150903-00007#1 150903 by sakura mark&add(S)
                  #CALL apmt840_02_num_change()
                  IF NOT apmt840_02_num_change() THEN
                     NEXT FIELD l_pmdb212
                  END IF
                  #150903-00007#1 150903 by sakura mark&add(E)
               END IF
            END IF
            CALL apmt840_02_pmdb006_upd()  
            LET g_rtdx_d_o.l_pmdb212 = g_rtdx_d[l_ac].l_pmdb212
            LET g_rtdx_d_o.l_pmdb006 = g_rtdx_d[l_ac].l_pmdb006
#            CALL apmt840_02_set_entry_b("a")
#            CALL apmt840_02_set_no_entry_b("a")
         
         #要貨數量
         AFTER FIELD l_pmdb006
            IF NOT cl_ap_chk_range(g_rtdx_d[l_ac].l_pmdb006,"0","0","","","azz-00079",1) THEN
               NEXT FIELD l_pmdb006
            END IF                 
            
            IF NOT cl_null(g_rtdx_d[l_ac].l_pmdb006) THEN
               IF g_rtdx_d[l_ac].l_pmdb006 != g_rtdx_d_o.l_pmdb006 OR cl_null(g_rtdx_d_o.l_pmdb006) THEN          
                  #150903-00007#1 150903 by sakura mark&add(S)
                  #CALL apmt840_02_num_change()
                  IF NOT apmt840_02_num_change() THEN
                     NEXT FIELD l_pmdb006
                  END IF                  
                  #150903-00007#1 150903 by sakura mark&add(E)
               END IF
            END IF
            CALL apmt840_02_pmdb006_upd()                
            LET g_rtdx_d_o.l_pmdb212 = g_rtdx_d[l_ac].l_pmdb212
            LET g_rtdx_d_o.l_pmdb006 = g_rtdx_d[l_ac].l_pmdb006
#            CALL apmt840_02_set_entry_b("a")
#            CALL apmt840_02_set_no_entry_b("a")

         ON CHANGE sel
            UPDATE apmt840_02_tmp
               SET sel = g_rtdx_d[l_ac].sel
             WHERE rtdx001 = g_rtdx_d[l_ac].rtdx001
            CALL apmt840_02_set_entry_b("a")
            CALL apmt840_02_set_no_entry_b("a")        
            
         ON ROW CHANGE
            CALL apmt840_02_pmdb006_upd()            
            
      END INPUT
      
      ON ACTION data_ok
         #查詢資料
         CALL apmt840_02_gen_rtdx()      
                  
      ON ACTION check_all
         #採購明細單身全選
         CALL apmt840_02_check_all() 
      
      ON ACTION check_no_all
         #採購明細單身全不選
         CALL apmt840_02_check_no_all()
         
      ON ACTION gen_pmdb
         ##產生要貨明細單身
         
         IF g_rec_b > 0 THEN                             
             LET g_success = FALSE         
             FOR li_idx = 1 TO g_rtdx_d.getLength()
                IF g_rtdx_d[li_idx].sel = "Y" THEN
                   IF cl_null(g_rtdx_d[li_idx].l_pmdb212) THEN  
                      NEXT FIELD l_pmdb212
                   END IF
                   IF cl_null(g_rtdx_d[li_idx].l_pmdb006) THEN
                      NEXT FIELD l_pmdb006
                   END IF
                   LET g_success = TRUE
                END IF
             END FOR            
             IF NOT g_success THEN 
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = '-400'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err() 
                NEXT FIELD sel                
             END IF 
             LET g_success = TRUE
             IF NOT apmt840_02_gen_detail() THEN
                IF NOT cl_ask_confirm('apm-00284') THEN #產生失敗，是否繼續
                   LET g_success = FALSE                 
                   RETURN
                END IF
             ELSE
                IF cl_ask_confirm('apm-00285') THEN #產生成功，是否繼續
                   CALL g_rtdx_d.clear()
                   DELETE FROM apmt840_02_tmp
                   IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = SQLCA.sqlcode
                      LET g_errparam.extend = 'Del apmt840_02_tmp'
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                   END IF                   
                   CALL apmt840_02_gen_rtdx() 
                   IF g_rec_b != 0 THEN    #160803-00019#1 Add By Ken 160803 修正  全部產生明細後重新查詢無資料時在 set_no_entry_b會閃退問題
                      CALL apmt840_02_set_entry_b("a")
                      CALL apmt840_02_set_no_entry_b("a")  
                   END IF                  #160803-00019#1 Add By Ken 160803 
                   NEXT FIELD sel 
                ELSE
                   LET INT_FLAG = TRUE 
                   EXIT DIALOG
                END IF
             END IF
         ELSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'apm-00292'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()      
         END IF
          
      ON ACTION accept
         ##產生要貨明細單身
         IF g_rec_b > 0 THEN           
             LET g_success = FALSE   
             FOR li_idx = 1 TO g_rtdx_d.getLength()
                IF g_rtdx_d[li_idx].sel = "Y" THEN
                   IF cl_null(g_rtdx_d[li_idx].l_pmdb212) THEN  
                      NEXT FIELD l_pmdb212
                   END IF
                   IF cl_null(g_rtdx_d[li_idx].l_pmdb006) THEN
                      NEXT FIELD l_pmdb006
                   END IF
                   LET g_success = TRUE
                END IF
             END FOR            
             IF NOT g_success THEN 
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = '-400'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err() 
                NEXT FIELD sel                
             END IF 
             LET g_success = TRUE
             IF NOT apmt840_02_gen_detail() THEN
                IF NOT cl_ask_confirm('apm-00284') THEN #產生失敗，是否繼續
                   LET g_success = FALSE                 
                   RETURN
                END IF
             ELSE
                IF cl_ask_confirm('apm-00285') THEN #產生成功，是否繼續
                   CALL g_rtdx_d.clear()
                   DELETE FROM apmt840_02_tmp
                   IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = SQLCA.sqlcode
                      LET g_errparam.extend = 'Del apmt840_02_tmp'
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                   END IF
                   CALL apmt840_02_gen_rtdx() 
                   CALL apmt840_02_set_entry_b("a")
                   CALL apmt840_02_set_no_entry_b("a")                                       
                   NEXT FIELD sel 
                ELSE
                   LET INT_FLAG = TRUE 
                   EXIT DIALOG
                END IF
             END IF
         ELSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'apm-00292'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()      
         END IF
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
   
   IF INT_FLAG THEN
      RETURN
   END IF
END FUNCTION

PRIVATE FUNCTION apmt840_02_b_fill()
DEFINE l_sql          STRING
DEFINE l_success      LIKE type_t.num5

    CALL g_rtdx_d.clear()
    LET l_ac = 1
    
    LET l_sql = "SELECT sel,         star001,      star004,   ",
                "       starsite,    imaz003,      rtdx001,   ",
                "       t1.imaal003, t1.imaal004,  deba002,      ",          #rtdx002                      #add by yangxf deba002
                "       pmdn202,     imaz006,     rtdx004,     t3.oocal003, ",   #150710-00016#5 150713 by sakura add imaz006
                "       pmdn007,     rtdx034,     pmdn006,     t2.oocal003, ",   #add by geza 20160707 #160708-00002#1 add rtdx034
                "       rtdx044,     t6.inayl003, pmdn206,    ",
                "       pmdn209     ",               
                "  FROM apmt840_02_tmp ",
                "  LEFT OUTER JOIN imaal_t t1 ON t1.imaalent = ",g_enterprise,
                "                            AND t1.imaal001 = rtdx001",
                "                            AND t1.imaal002 = '",g_dlang,"'",
                "  LEFT OUTER JOIN oocal_t t2 ON t2.oocalent = ",g_enterprise,
                "                            AND t2.oocal001 = pmdn006",
                "                            AND t2.oocal002 = '",g_dlang,"'",
                "  LEFT OUTER JOIN oocal_t t3 ON t3.oocalent = ",g_enterprise,
                "                            AND t3.oocal001 = rtdx004",
                "                            AND t3.oocal002 = '",g_dlang,"'",
                "  LEFT OUTER JOIN inayl_t t6 ON t6.inaylent = ",g_enterprise,
                "                            AND t6.inayl001 = rtdx044",
                "                            AND t6.inayl002 = '",g_dlang,"'",
                "  ORDER BY rtdx001,star001,star004,starsite "
    PREPARE apmt840_02_rtdx_pb FROM l_sql
    DECLARE apmt840_02_rtdx_cs CURSOR FOR apmt840_02_rtdx_pb
    FOREACH apmt840_02_rtdx_cs
       INTO g_rtdx_d[l_ac].sel,                  g_rtdx_d[l_ac].star001,             g_rtdx_d[l_ac].star004,                   
            g_rtdx_d[l_ac].starsite,             g_rtdx_d[l_ac].l_imaz003,           g_rtdx_d[l_ac].rtdx001,      
            g_rtdx_d[l_ac].rtdx001_desc,         g_rtdx_d[l_ac].rtdx001_desc_desc,   g_rtdx_d[l_ac].deba002, #g_rtdx_d[l_ac].rtdx002,   #add by yangxf g_rtdx_d[l_ac].deba002   
            g_rtdx_d[l_ac].l_pmdb212,            g_rtdx_d[l_ac].l_imaz006,    #150710-00016#5 150713 by sakura add imaz006           
            g_rtdx_d[l_ac].rtdx004,              g_rtdx_d[l_ac].rtdx004_desc,        g_rtdx_d[l_ac].l_pmdb006,            
            g_rtdx_d[l_ac].rtdx034,              g_rtdx_d[l_ac].l_pmdb007,           g_rtdx_d[l_ac].pmdb007_desc,   #add by geza 20160707 #160708-00002#1 add rtdx034                        
            g_rtdx_d[l_ac].rtdx044,              g_rtdx_d[l_ac].rtdx044_desc,        g_rtdx_d[l_ac].l_pmdb252,
            g_rtdx_d[l_ac].l_pmdb259              
                        
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = "Foreach apmt840_02_rtdx_cs"
          LET g_errparam.popup = TRUE
          CALL cl_err()
          EXIT FOREACH
       END IF
             
       LET l_ac = l_ac + 1
       IF l_ac > g_max_rec AND g_error_show = 1 THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code =  9035
          LET g_errparam.extend =  ''
          LET g_errparam.popup = TRUE
          CALL cl_err()
          EXIT FOREACH
       END IF
    END FOREACH
    
    CALL g_rtdx_d.deleteElement(g_rtdx_d.getLength()) 
    LET l_ac = g_rtdx_d.getLength()    
    
END FUNCTION

PRIVATE FUNCTION apmt840_02_init()

   CALL g_rtdx_d.clear()
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()
   LET g_error_show = 1

END FUNCTION

PRIVATE FUNCTION apmt840_02_set_entry_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1

   CALL cl_set_comp_entry("l_pmdb006,l_pmdb212",TRUE)   
   CALL cl_set_comp_entry("rtdx034",TRUE)  #add by geza 20160707 #160708-00002#1 
END FUNCTION

PRIVATE FUNCTION apmt840_02_set_no_entry_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1
   DEFINE l_stan024   LIKE stan_t.stan024 #add by geza 20160707 #160708-00002#1 
   IF l_ac > 0 THEN   #160601-00016#1 160601 by sakura add
      IF g_rtdx_d[l_ac].sel ='N' THEN
         CALL cl_set_comp_entry("l_pmdb006,l_pmdb212",FALSE) 
      END IF
   END IF   #160601-00016#1 160601 by sakura add
#   IF NOT cl_null(g_rtdx_d[l_ac].l_pmdb006) THEN
#      CALL cl_set_comp_entry("l_pmdb212",FALSE) 
#   END IF
   #add by geza 20160707 #160708-00002#1(S)
   #合約:採購價格允許人工修改 = 'N',單價不可以維護
   SELECT stan024 INTO l_stan024
     FROM stan_t
    WHERE stanent = g_enterprise
      AND stan001 = g_rtdx_d[l_ac].star004    
   IF l_stan024 = 'N' THEN
      CALL cl_set_comp_entry("rtdx034",FALSE)  #單價
   END IF
   #add by geza 20160707 #160708-00002#1(S)  
   #end add-point

END FUNCTION

################################################################################
# Descriptions...: 產生要貨單明細相關語法
# Memo...........:
# Usage..........: CALL apmt840_02_gen_detail_pre()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/05/27 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt840_02_gen_detail_pre()
DEFINE l_sql     STRING

   LET l_sql = "SELECT rtdx001,  rtdx002,  pmdn006,  pmdn007, ",
               "       imaz003,  imaz006,  rtdx004,  pmdn202,  rtdx044, ",   #150710-00016#5 150713 by sakura add imaz006
               "       pmdn206,  pmdn209,  pmdn210,  pmdn211, ",
               "       pmdn212,  pmdn213,  pmdn207,  rtdx028, ",
               "       rtdx029,  star001,  starsite, rtdx034 ", #add by geza 20160707 #160708-00002#1
               "  FROM apmt840_02_tmp  ",
               " WHERE sel='Y' "
   PREPARE apmt840_02_sel_pre FROM l_sql
   DECLARE apmt840_02_sel_cs CURSOR FOR apmt840_02_sel_pre
   
   #項次
   LET l_sql = "SELECT COALESCE(MAX(pmdnseq),0)+1",
               "  FROM pmdn_t",
               " WHERE pmdnent = ",g_enterprise,
               "   AND pmdndocno = '",g_pmdadocno,"'"
   PREPARE apmt840_02_pmdbseq FROM l_sql
   
   #結算方式、採購員
   LET l_sql = "SELECT DISTINCT star006,stas009",
               "  FROM stan_t,star_t,stas_t",
               " WHERE starent = stasent",
               "   AND starsite = stassite ",
               "   AND star001 = stas001",
               "   AND stanent = starent",
               "   AND stan001 = star004",
               "   AND stanent = ",g_enterprise,
               "   AND starsite = ? ", 
               "   AND stas003 = ?",
               "   AND star003 = ?",
               "   AND starstus = 'Y'",
               #"   AND '",g_pmdl.pmdldocdt,"' BETWEEN stan017 AND stan018"   #160104-00014#1 20160105 mark by beckxie
               "   AND '",g_pmdl.pmdldocdt,"' BETWEEN stas018 AND stas019"    #160104-00014#1 20160105  add by beckxie
   PREPARE apmt840_02_get_star FROM l_sql
   
   #採購方式
   LET l_sql = "SELECT rtdx003",
               "  FROM rtdx_t",
               " WHERE rtdxent = ",g_enterprise,
               "   AND rtdxsite = ?",
               "   AND rtdx001 = ?"
   PREPARE apmt840_02_get_rtdx FROM l_sql
END FUNCTION

################################################################################
# Descriptions...: 產生要貨單明細資料
# Memo...........:
# Usage..........: CALL apmt840_02_gen_detail()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/05/27 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt840_02_gen_detail()
DEFINE l_i              LIKE type_t.num5
DEFINE l_rtdx            RECORD
       rtdx001           LIKE rtdx_t.rtdx001,     #商品編號
       rtdx002           LIKE rtdx_t.rtdx002,     #商品主條碼
       pmdb007           LIKE pmdb_t.pmdb007,     #要貨單位
       pmdb006           LIKE pmdb_t.pmdb006,     #要貨數量 
       imaz003           LIKE imaz_t.imaz003,     #補貨條碼
       imaz006           LIKE imaz_t.imaz006,     #補貨規格說明   #150710-00016#5 150713 by sakura add
       rtdx004           LIKE rtdx_t.rtdx004,     #包裝單位
       pmdb212           LIKE pmdb_t.pmdb212,     #要貨包裝數量
       rtdx044           LIKE rtdx_t.rtdx044,     #庫位  
       pmdb252           LIKE pmdb_t.pmdb252,     #現有庫存
       pmdb259           LIKE pmdb_t.pmdb259,     #週平均銷量
       pmdb254           LIKE pmdb_t.pmdb254,     #前一週銷量
       pmdb255           LIKE pmdb_t.pmdb255,     #前二週銷量
       pmdb256           LIKE pmdb_t.pmdb256,     #前三週銷量
       pmdb257           LIKE pmdb_t.pmdb257,     #前四週銷量
       pmdb258           LIKE pmdb_t.pmdb258,     #要貨在途量
       rtdx028           LIKE rtdx_t.rtdx028,     #採購中心
       rtdx029           LIKE rtdx_t.rtdx029,     #配迗中心
       star001           LIKE star_t.star001,     #協議編號
       starsite          LIKE star_t.starsite,    #門店編號
       rtdx034           LIKE rtdx_t.rtdx034      #进价          #add by geza 20160707 #160708-00002#1
                         END RECORD
DEFINE l_pmdn           RECORD
       pmdnseq LIKE pmdn_t.pmdnseq, 
       pmdnsite LIKE pmdn_t.pmdnsite, 
       pmdn200 LIKE pmdn_t.pmdn200, 
       pmdn001 LIKE pmdn_t.pmdn001,
       pmdn002 LIKE pmdn_t.pmdn002,
       pmdn016 LIKE pmdn_t.pmdn016,
       pmdn017 LIKE pmdn_t.pmdn017,
       pmdn227 LIKE pmdn_t.pmdn227,   #補貨規格說明#150710-00016#5 150713 by sakura add       
       pmdn201 LIKE pmdn_t.pmdn201,
       pmdn202 LIKE pmdn_t.pmdn202, 
       pmdn006 LIKE pmdn_t.pmdn006,
       pmdn007 LIKE pmdn_t.pmdn007, 
       pmdn226 LIKE pmdn_t.pmdn226, 
       pmdn008 LIKE pmdn_t.pmdn008,
       pmdn009 LIKE pmdn_t.pmdn009, 
       pmdn010 LIKE pmdn_t.pmdn010,
       pmdn011 LIKE pmdn_t.pmdn011, 
       pmdn015 LIKE pmdn_t.pmdn015, 
       pmdn043 LIKE pmdn_t.pmdn043, 
       pmdn046 LIKE pmdn_t.pmdn046, 
       pmdn048 LIKE pmdn_t.pmdn048, 
       pmdn047 LIKE pmdn_t.pmdn047, 
       pmdnunit LIKE pmdn_t.pmdnunit,
       pmdn225 LIKE pmdn_t.pmdn225,
       pmdn203 LIKE pmdn_t.pmdn203,
       pmdn025 LIKE pmdn_t.pmdn025,
       pmdn028 LIKE pmdn_t.pmdn028,
       pmdn029 LIKE pmdn_t.pmdn029,
       pmdn030 LIKE pmdn_t.pmdn030, 
       pmdn053 LIKE pmdn_t.pmdn053, 
       pmdnorga LIKE pmdn_t.pmdnorga,
       pmdn026 LIKE pmdn_t.pmdn026,
       pmdn024 LIKE pmdn_t.pmdn024, 
       pmdn014 LIKE pmdn_t.pmdn014, 
       pmdn012 LIKE pmdn_t.pmdn012, 
       pmdn013 LIKE pmdn_t.pmdn013, 
       pmdn022 LIKE pmdn_t.pmdn022, 
       pmdn023 LIKE pmdn_t.pmdn023,
       pmdn045 LIKE pmdn_t.pmdn045, 
       pmdn206 LIKE pmdn_t.pmdn206, 
       pmdn207 LIKE pmdn_t.pmdn207, 
       pmdn208 LIKE pmdn_t.pmdn208, 
       pmdn209 LIKE pmdn_t.pmdn209, 
       pmdn210 LIKE pmdn_t.pmdn210, 
       pmdn211 LIKE pmdn_t.pmdn211, 
       pmdn212 LIKE pmdn_t.pmdn212, 
       pmdn213 LIKE pmdn_t.pmdn213, 
       pmdn019 LIKE pmdn_t.pmdn019, 
       pmdn020 LIKE pmdn_t.pmdn020, 
       pmdn224 LIKE pmdn_t.pmdn224, 
       pmdn052 LIKE pmdn_t.pmdn052, 
       pmdn049 LIKE pmdn_t.pmdn049,
       pmdn051 LIKE pmdn_t.pmdn051,
       pmdn205 LIKE pmdn_t.pmdn205,
       pmdn214 LIKE pmdn_t.pmdn214,
       pmdn215 LIKE pmdn_t.pmdn215, 
       pmdn216 LIKE pmdn_t.pmdn216, 
       pmdn217 LIKE pmdn_t.pmdn217,
       pmdn218 LIKE pmdn_t.pmdn218, 
       pmdn219 LIKE pmdn_t.pmdn219, 
       pmdn220 LIKE pmdn_t.pmdn220,
       pmdn221 LIKE pmdn_t.pmdn221,
       pmdn222 LIKE pmdn_t.pmdn222, 
       pmdn223 LIKE pmdn_t.pmdn223, 
       pmdn050 LIKE pmdn_t.pmdn050
                        END RECORD
DEFINE r_success   LIKE type_t.num5
DEFINE l_success   LIKE type_t.num5
DEFINE l_rtka010   LIKE rtka_t.rtka010    #訂單有效期
DEFINE l_ooef001   LIKE ooef_t.ooef001
DEFINE l_errno     LIKE type_t.chr20
DEFINE l_pmdn228   LIKE pmdn_t.pmdn228 #品類編號 #151202-00010#2 s983961--add

   LET r_success = TRUE
   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   
   CALL apmt840_02_gen_detail_pre()
   
   FOREACH apmt840_02_sel_cs
      INTO l_rtdx.rtdx001,  l_rtdx.rtdx002, l_rtdx.pmdb007, l_rtdx.pmdb006,
           l_rtdx.imaz003,  l_rtdx.imaz006, l_rtdx.rtdx004, l_rtdx.pmdb212, l_rtdx.rtdx044,
           l_rtdx.pmdb252,  l_rtdx.pmdb259, l_rtdx.pmdb254, l_rtdx.pmdb255,
           l_rtdx.pmdb256,  l_rtdx.pmdb257, l_rtdx.pmdb258, l_rtdx.rtdx028,
           l_rtdx.rtdx029,  l_rtdx.star001, l_rtdx.starsite,l_rtdx.rtdx034  #add by geza 20160707 #160708-00002#1
               
           
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "Foreach apmt840_02_sel_cs"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      INITIALIZE l_pmdn.* TO NULL
      LET l_pmdn.pmdnsite = l_rtdx.starsite
      LET l_pmdn.pmdn001 = l_rtdx.rtdx001
      SELECT imaa005 INTO l_pmdn.pmdn002 
        FROM imaa_t 
       WHERE imaaent = g_enterprise 
         AND imaa001 = l_pmdn.pmdn001
      IF cl_null(l_pmdn.pmdn002) THEN 
         LET l_pmdn.pmdn002 = ' '
      END IF
      CALL s_apmt840_get_rtax009(l_pmdn.pmdn001)
      RETURNING l_pmdn.pmdn052
      #項次
      EXECUTE apmt840_02_pmdbseq INTO l_pmdn.pmdnseq               
      LET l_pmdn.pmdn009 = "0"
      LET l_pmdn.pmdn043 = "0"
      LET l_pmdn.pmdn046 = "0"
      LET l_pmdn.pmdn048 = "0"
      LET l_pmdn.pmdn047 = "0"
      LET l_pmdn.pmdn024 = "N"
      LET l_pmdn.pmdn022 = "Y"
      LET l_pmdn.pmdn045 = "1"
      LET l_pmdn.pmdn200 = l_rtdx.rtdx002
      LET l_pmdn.pmdn206 = "0"
      LET l_pmdn.pmdn207 = "0"
      LET l_pmdn.pmdn208 = "0"
      LET l_pmdn.pmdn209 = "0"
      LET l_pmdn.pmdn210 = "0"
      LET l_pmdn.pmdn211 = "0"
      LET l_pmdn.pmdn212 = "0"
      LET l_pmdn.pmdn213 = "0"
      LET l_pmdn.pmdn019 = "1"
      LET l_pmdn.pmdn020 = "1"
      LET l_pmdn.pmdn224 = g_pmdl.pmdl205
      LET l_pmdn.pmdn222 = g_pmdl.pmdl200
      LET l_pmdn.pmdn223 = g_pmdl.pmdl204
      #收貨組織
      IF cl_null(g_pmdl.pmdlunit) THEN
         #先確認收貨組織在aooi500設定是可以的
         CALL s_aooi500_chk(g_prog,'pmdnunit',g_pmdl.pmdlsite,g_pmdl.pmdlsite)
            RETURNING l_success,l_errno
         IF l_success AND s_apmt840_02_chk_pmdnunit() THEN
            LET l_pmdn.pmdnunit = g_pmdl.pmdlsite
         END IF
      ELSE
         LET l_pmdn.pmdnunit = g_pmdl.pmdlunit
      END IF
      LET l_pmdn.pmdn225 = l_pmdn.pmdnunit
      #收貨部門
      IF NOT cl_null(g_pmdl.pmdl029) THEN
         LET l_pmdn.pmdn203 = g_pmdl.pmdl029
      END IF
      #收貨地址碼
      IF NOT cl_null(g_pmdl.pmdl025) THEN
         LET l_pmdn.pmdn025 = g_pmdl.pmdl025
      END IF        
      #到庫日期
      CALL s_apmt840_get_date('1',g_pmdl.pmdldocdt,l_pmdn.pmdnunit,g_pmdl.pmdl004)
         RETURNING l_pmdn.pmdn014,l_rtka010
      IF s_apmt840_get_pmdb033(g_pmdl.pmdldocno,l_pmdn.pmdnseq) THEN
         IF l_pmdn.pmdn014 < g_today THEN
            LET l_pmdn.pmdn020 = '2'
         ELSE
            LET l_pmdn.pmdn020 = '1'
         END IF
      END IF
   
      #到廠日期，交貨日期 = 到庫日期
      LET l_pmdn.pmdn012 = l_pmdn.pmdn014
      LET l_pmdn.pmdn013 = l_pmdn.pmdn014
      #代送商
      IF NOT cl_null(g_pmdl.pmdl022) THEN
         LET l_pmdn.pmdn023 = g_pmdl.pmdl022
      END IF
      
      #要貨組織
      LET l_pmdn.pmdn205 = g_pmdl.pmdlsite
      
      #採購渠道
      IF NOT cl_null(g_pmdl.pmdl023) THEN
         LET l_pmdn.pmdn214 = g_pmdl.pmdl023
         CALL s_apmt840_get_oojd004(l_pmdn.pmdn214) RETURNING l_pmdn.pmdn215
      END IF
      
      #部分交貨
      IF g_pmdl.pmdl206 = 'Y' THEN
         LET l_pmdn.pmdn022 = 'Y'
      ELSE
         SELECT pmab099 INTO l_pmdn.pmdn022
           FROM pmab_t
          WHERE pmabent = g_enterprise
            AND pmabsite = 'ALL'
            AND pmab001 = g_pmdl.pmdl004
      END IF
      
      #採購中心
      #當單頭有指定採購中心時，單身採購中心預設為採購配送中心
      IF NOT cl_null(g_pmdl.pmdl200) THEN
         LET l_pmdn.pmdn223 = g_pmdl.pmdl200
      ELSE 
         LET l_pmdn.pmdn223 = l_rtdx.rtdx028
      END IF
      
      #結算方式、採購員
      EXECUTE apmt840_02_get_star USING l_pmdn.pmdnsite,l_pmdn.pmdn001,g_pmdl.pmdl004
         INTO l_pmdn.pmdn217,l_pmdn.pmdn220
         
      #經營方式
      EXECUTE apmt840_02_get_rtdx USING l_pmdn.pmdnsite,l_pmdn.pmdn001
         INTO l_pmdn.pmdn216
      #補貨規格說明
      LET l_pmdn.pmdn227 = l_rtdx.imaz006   #150710-00016#5 150713 by sakura add      
      LET l_pmdn.pmdn201 = l_rtdx.rtdx004   #包装单位
      #取協議資訊
      CALL s_apmt840_get_pact(l_pmdn.pmdn222,g_pmdl.pmdl015,g_pmdl.pmdl004,
                              g_pmdl.pmdldocdt,l_pmdn.pmdn001,l_pmdn.pmdnsite)
        RETURNING l_pmdn.pmdnorga,l_pmdn.pmdn006,
                  l_pmdn.pmdn010, l_pmdn.pmdn043,
                  l_pmdn.pmdn016, l_pmdn.pmdn017,
                  l_pmdn.pmdn216, l_pmdn.pmdn217,
                  l_pmdn.pmdn218, l_pmdn.pmdn219,
                  l_pmdn.pmdn220, l_pmdn.pmdn221
      #單價 = 取出價格
      #LET l_pmdn.pmdn015 = l_pmdn.pmdn043  #mark by geza 20160707 #160708-00002#1
      LET l_pmdn.pmdn015 = l_rtdx.rtdx034  #add by geza 20160707 #160708-00002#1
      #帳款地址預設
      CALL s_apmt840_main_addr('5',l_pmdn.pmdnorga) RETURNING l_pmdn.pmdn026
      
      LET l_pmdn.pmdn206 = l_rtdx.pmdb252    #可用庫存量
      LET l_pmdn.pmdn207 = l_rtdx.pmdb258    #採購在途量
      LET l_pmdn.pmdn209 = l_rtdx.pmdb259    #週平均銷量
      LET l_pmdn.pmdn210 = l_rtdx.pmdb254    #前一週銷量
      LET l_pmdn.pmdn211 = l_rtdx.pmdb255    #前二週銷量
      LET l_pmdn.pmdn212 = l_rtdx.pmdb256    #前三週銷量
      LET l_pmdn.pmdn213 = l_rtdx.pmdb257    #前四週銷量
      LET l_pmdn.pmdn006 = l_rtdx.pmdb007    #采购单位
      LET l_pmdn.pmdn007 = l_rtdx.pmdb006    #采购数量
      LET l_pmdn.pmdn202 = l_rtdx.pmdb212    #包装数量
      LET l_pmdn.pmdn008 = l_pmdn.pmdn006    #参考单位
      LET l_pmdn.pmdn009 = l_pmdn.pmdn007    #參考數量
      #計算計價數量
      IF NOT cl_null(l_pmdn.pmdn010) THEN
         CALL s_aooi250_convert_qty(l_pmdn.pmdn001,l_pmdn.pmdn006,l_pmdn.pmdn010,l_pmdn.pmdn007)
            RETURNING l_success,l_pmdn.pmdn011
         #150903-00007#1 150903 by sakura add(S)
         IF l_success = FALSE THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'apm-00998'   #商品%1，採購單位%2與計價單位%3轉換數量失敗！   
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = l_pmdn.pmdn001
            LET g_errparam.replace[2] = l_pmdn.pmdn006
            LET g_errparam.replace[3] = l_pmdn.pmdn010
            CALL cl_err()
            
            CONTINUE FOREACH
         END IF
         #150903-00007#1 150903 by sakura add(E)         
      END IF
      LET l_ooef001 = ''
      IF g_pmdl.pmdl203 = '3' THEN
         LET l_ooef001 = l_pmdn.pmdn223
      ELSE
         LET l_ooef001 = l_pmdn.pmdn222
      END IF
      #mark by geza 20160613(S)
      #收货库位
#      CALL s_apmi830_inv_scope_def(l_pmdn.pmdnunit,l_pmdn.pmdn001,g_pmdl.pmdl203,l_ooef001)
#         RETURNING l_pmdn.pmdn028
      #mark by geza 20160613(E)
      #add by geza 20160613(S)
      #收货库位
      CALL s_apmt860_warehouse_default(l_pmdn.pmdnunit,l_pmdn.pmdn001)
         RETURNING l_pmdn.pmdn028
      #add by geza 20160613(E)
      LET l_pmdn.pmdn053 = ' '
      #取得未稅金額、稅額、含稅金額
      CALL s_apmt840_get_amount(g_pmdl.pmdldocno,l_pmdn.pmdnseq,g_pmdl.pmdlsite,g_pmdl.pmdl015,l_pmdn.pmdn007,l_pmdn.pmdn015,l_pmdn.pmdn016)
       RETURNING l_pmdn.pmdn046,l_pmdn.pmdn048,l_pmdn.pmdn047
      
      #151202-00010#2 s983961--add(s)       
      #品類編號 
      SELECT imaa009 INTO l_pmdn228
        FROM imaa_t
       WHERE imaaent = g_enterprise
         AND imaa001 = l_pmdn.pmdn001
      #151202-00010#2 s983961--add(e) 
      
      INSERT INTO pmdn_t
                  (pmdnent,
                   pmdndocno,pmdnseq,
                   pmdnsite,pmdn200,pmdn001,
                   pmdn002,pmdn016,pmdn017,
                   pmdn201,pmdn202,pmdn006,
                   pmdn007,pmdn226,pmdn008,
                   pmdn009,pmdn010,pmdn011,
                   pmdn015,pmdn043,pmdn046,
                   pmdn048,pmdn047,pmdnunit,
                   pmdn225,pmdn203,pmdn025,
                   pmdn028,pmdn029,pmdn030,
                   pmdn053,pmdnorga,pmdn026,
                   pmdn024,pmdn014,pmdn012,
                   pmdn013,pmdn022,pmdn023,
                   pmdn045,pmdn206,pmdn207,
                   pmdn208,pmdn209,pmdn210,
                   pmdn211,pmdn212,pmdn213,
                   pmdn019,pmdn020,pmdn224,
                   pmdn052,pmdn049,pmdn051,
                   pmdn205,pmdn214,pmdn215,
                   pmdn216,pmdn217,pmdn218,
                   pmdn219,pmdn220,pmdn221,
                   pmdn222,pmdn223,pmdn050,
                   pmdn227,pmdn228)   #150710-00016#5 150713 by sakura add  #151202-00010#2 s983961--add pmdn228
            VALUES(g_enterprise,
                   g_pmdl.pmdldocno,l_pmdn.pmdnseq,
                   l_pmdn.pmdnsite,l_pmdn.pmdn200,l_pmdn.pmdn001, 
                   l_pmdn.pmdn002,l_pmdn.pmdn016,l_pmdn.pmdn017, 
                   l_pmdn.pmdn201,l_pmdn.pmdn202,l_pmdn.pmdn006, 
                   l_pmdn.pmdn007,l_pmdn.pmdn226,l_pmdn.pmdn008, 
                   l_pmdn.pmdn009,l_pmdn.pmdn010,l_pmdn.pmdn011, 
                   l_pmdn.pmdn015,l_pmdn.pmdn043,l_pmdn.pmdn046, 
                   l_pmdn.pmdn048,l_pmdn.pmdn047,l_pmdn.pmdnunit, 
                   l_pmdn.pmdn225,l_pmdn.pmdn203,l_pmdn.pmdn025, 
                   l_pmdn.pmdn028,l_pmdn.pmdn029,l_pmdn.pmdn030, 
                   l_pmdn.pmdn053,l_pmdn.pmdnorga,l_pmdn.pmdn026, 
                   l_pmdn.pmdn024,l_pmdn.pmdn014,l_pmdn.pmdn012, 
                   l_pmdn.pmdn013,l_pmdn.pmdn022,l_pmdn.pmdn023, 
                   l_pmdn.pmdn045,l_pmdn.pmdn206,l_pmdn.pmdn207, 
                   l_pmdn.pmdn208,l_pmdn.pmdn209,l_pmdn.pmdn210, 
                   l_pmdn.pmdn211,l_pmdn.pmdn212,l_pmdn.pmdn213, 
                   l_pmdn.pmdn019,l_pmdn.pmdn020,l_pmdn.pmdn224, 
                   l_pmdn.pmdn052,l_pmdn.pmdn049,l_pmdn.pmdn051, 
                   l_pmdn.pmdn205,l_pmdn.pmdn214,l_pmdn.pmdn215, 
                   l_pmdn.pmdn216,l_pmdn.pmdn217,l_pmdn.pmdn218, 
                   l_pmdn.pmdn219,l_pmdn.pmdn220,l_pmdn.pmdn221, 
                   l_pmdn.pmdn222,l_pmdn.pmdn223,l_pmdn.pmdn050,
                   l_pmdn.pmdn227,l_pmdn228)   #150710-00016#5 150713 by sakura add  #151202-00010#2 s983961--add l_pmdn228
           
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "Ins pmdn_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      IF l_pmdn.pmdn024 = 'N' THEN
         CALL s_apmt840_gen_pmdq(g_pmdl.pmdldocno,l_pmdn.pmdnseq) RETURNING l_success
         IF NOT l_success THEN 
            LET r_success = FALSE
            EXIT FOREACH
         END IF 
      END IF
      CALL s_apmt840_gen_pmdo(g_pmdl.pmdldocno,l_pmdn.pmdnseq) RETURNING l_success
      IF NOT l_success THEN 
         LET r_success = FALSE
         EXIT FOREACH
      END IF 
      INITIALIZE l_pmdn.* TO NULL
      INITIALIZE l_rtdx.* TO NULL
   END FOREACH
   
   IF r_success THEN
      CALL s_transaction_end('Y',0)
   ELSE
      CALL s_transaction_end('N',0)
   END IF
   CALL cl_err_collect_show()
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 單頭相關條件SQL語法
# Memo...........:
# Usage..........: CALL apmt840_02_get_pmda()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/05/28 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt840_02_get_pmda()
DEFINE l_sys     LIKE type_t.num5 

   INITIALIZE g_pmdl.* TO NULL
  #161104-00002#11 --(B) 16/11/28 modify by rainy將*展開  
   #SELECT * INTO g_pmdl.*
   SELECT pmdlent,  pmdlsite, pmdlunit, pmdldocno,pmdldocdt,
          pmdl001,  pmdl002,  pmdl003,  pmdl004,  pmdl005,
          pmdl006,  pmdl007,  pmdl008,  pmdl009,  pmdl010,
          pmdl011,  pmdl012,  pmdl013,  pmdl015,  pmdl016,
          pmdl017,  pmdl018,  pmdl019,  pmdl020,  pmdl021,
          pmdl022,  pmdl023,  pmdl024,  pmdl025,  pmdl026,
          pmdl027,  pmdl028,  pmdl029,  pmdl030,  pmdl031,
          pmdl032,  pmdl033,  pmdl040,  pmdl041,  pmdl042,
          pmdl043,  pmdl044,  pmdl046,  pmdl047,  pmdl048,
          pmdl049,  pmdl050,  pmdl051,  pmdl052,  pmdl053,
          pmdl054,  pmdl055,  pmdl200,  pmdl201,  pmdl202,
          pmdl203,  pmdl204,  pmdl900,  pmdl999,  pmdlownid,
          pmdlowndp,pmdlcrtid,pmdlcrtdp,pmdlcrtdt,pmdlmodid,
          pmdlmoddt,pmdlcnfid,pmdlcnfdt,pmdlpstid,pmdlpstdt,
          pmdlstus, pmdlud001,pmdlud002,pmdlud003,pmdlud004,
          pmdlud005,pmdlud006,pmdlud007,pmdlud008,pmdlud009,
          pmdlud010,pmdlud011,pmdlud012,pmdlud013,pmdlud014,
          pmdlud015,pmdlud016,pmdlud017,pmdlud018,pmdlud019,
          pmdlud020,pmdlud021,pmdlud022,pmdlud023,pmdlud024,
          pmdlud025,pmdlud026,pmdlud027,pmdlud028,pmdlud029,
          pmdlud030,pmdl205,  pmdl206,  pmdl207,  pmdl208 
   INTO g_pmdl.pmdlent,  g_pmdl.pmdlsite, g_pmdl.pmdlunit, g_pmdl.pmdldocno,g_pmdl.pmdldocdt,
        g_pmdl.pmdl001,  g_pmdl.pmdl002,  g_pmdl.pmdl003,  g_pmdl.pmdl004,  g_pmdl.pmdl005,
        g_pmdl.pmdl006,  g_pmdl.pmdl007,  g_pmdl.pmdl008,  g_pmdl.pmdl009,  g_pmdl.pmdl010,
        g_pmdl.pmdl011,  g_pmdl.pmdl012,  g_pmdl.pmdl013,  g_pmdl.pmdl015,  g_pmdl.pmdl016,
        g_pmdl.pmdl017,  g_pmdl.pmdl018,  g_pmdl.pmdl019,  g_pmdl.pmdl020,  g_pmdl.pmdl021,
        g_pmdl.pmdl022,  g_pmdl.pmdl023,  g_pmdl.pmdl024,  g_pmdl.pmdl025,  g_pmdl.pmdl026,
        g_pmdl.pmdl027,  g_pmdl.pmdl028,  g_pmdl.pmdl029,  g_pmdl.pmdl030,  g_pmdl.pmdl031,
        g_pmdl.pmdl032,  g_pmdl.pmdl033,  g_pmdl.pmdl040,  g_pmdl.pmdl041,  g_pmdl.pmdl042,
        g_pmdl.pmdl043,  g_pmdl.pmdl044,  g_pmdl.pmdl046,  g_pmdl.pmdl047,  g_pmdl.pmdl048,
        g_pmdl.pmdl049,  g_pmdl.pmdl050,  g_pmdl.pmdl051,  g_pmdl.pmdl052,  g_pmdl.pmdl053,
        g_pmdl.pmdl054,  g_pmdl.pmdl055,  g_pmdl.pmdl200,  g_pmdl.pmdl201,  g_pmdl.pmdl202,
        g_pmdl.pmdl203,  g_pmdl.pmdl204,  g_pmdl.pmdl900,  g_pmdl.pmdl999,  g_pmdl.pmdlownid,
        g_pmdl.pmdlowndp,g_pmdl.pmdlcrtid,g_pmdl.pmdlcrtdp,g_pmdl.pmdlcrtdt,g_pmdl.pmdlmodid,
        g_pmdl.pmdlmoddt,g_pmdl.pmdlcnfid,g_pmdl.pmdlcnfdt,g_pmdl.pmdlpstid,g_pmdl.pmdlpstdt,
        g_pmdl.pmdlstus, g_pmdl.pmdlud001,g_pmdl.pmdlud002,g_pmdl.pmdlud003,g_pmdl.pmdlud004,
        g_pmdl.pmdlud005,g_pmdl.pmdlud006,g_pmdl.pmdlud007,g_pmdl.pmdlud008,g_pmdl.pmdlud009,
        g_pmdl.pmdlud010,g_pmdl.pmdlud011,g_pmdl.pmdlud012,g_pmdl.pmdlud013,g_pmdl.pmdlud014,
        g_pmdl.pmdlud015,g_pmdl.pmdlud016,g_pmdl.pmdlud017,g_pmdl.pmdlud018,g_pmdl.pmdlud019,
        g_pmdl.pmdlud020,g_pmdl.pmdlud021,g_pmdl.pmdlud022,g_pmdl.pmdlud023,g_pmdl.pmdlud024,
        g_pmdl.pmdlud025,g_pmdl.pmdlud026,g_pmdl.pmdlud027,g_pmdl.pmdlud028,g_pmdl.pmdlud029,
        g_pmdl.pmdlud030,g_pmdl.pmdl205,  g_pmdl.pmdl206,  g_pmdl.pmdl207,  g_pmdl.pmdl208 
  #161104-00002#11 --(E)  
     FROM pmdl_t
    WHERE pmdlent = g_enterprise
      AND pmdldocno = g_pmdadocno

   #品類設定加上部門過濾該作業可使用的商品
   LET g_where_sql = s_arti204_control_where(g_prog,g_pmdl.pmdl003,'1')
   
   #採購方式
   IF NOT cl_null(g_pmdl.pmdl203) THEN
      LET g_where_sql = g_where_sql," AND rtdx027 = '",g_pmdl.pmdl203,"'"
   END IF
   
   #採購中心
   IF NOT cl_null(g_pmdl.pmdl200) THEN
      LET g_where_sql = g_where_sql," AND rtdx028 = '",g_pmdl.pmdl200,"'"
   END IF
   
   #配送中心
   IF NOT cl_null(g_pmdl.pmdl204) THEN
      LET g_where_sql = g_where_sql," AND rtdx029 = '",g_pmdl.pmdl204,"'"
   END IF
END FUNCTION

################################################################################
# Descriptions...: 按查詢後把資料寫到tmp
# Memo...........:
# Usage..........: CALL apmt840_02_gen_rtdx()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/05/27 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt840_02_gen_rtdx()
DEFINE l_sql             STRING
DEFINE l_where_sql       STRING
DEFINE l_success         LIKE type_t.num5
DEFINE l_ooba002         LIKE ooba_t.ooba002
DEFINE l_sys             LIKE type_t.num5 
DEFINE l_pmdbsite        LIKE pmdb_t.pmdbsite
DEFINE l_pmdn007         LIKE pmdn_t.pmdn007
DEFINE l_imaa104         LIKE imaa_t.imaa104
DEFINE l_deba002         LIKE deba_t.deba002
DEFINE l_rtdx            RECORD
       rtdx001           LIKE rtdx_t.rtdx001,     #商品編號
       rtdx002           LIKE rtdx_t.rtdx002,     #
       imaz003           LIKE imaz_t.imaz003,
       imaz006           LIKE imaz_t.imaz006,    #補貨規格說明   #150710-00016#5 150713 by sakura add
       rtdx004           LIKE rtdx_t.rtdx004,
       pmdn206           LIKE pmdn_t.pmdn206,    #現有庫存
       pmdn209           LIKE pmdn_t.pmdn209,    #週平均銷量
       pmdn210           LIKE pmdn_t.pmdn210,    #前一週銷量
       pmdn211           LIKE pmdn_t.pmdn211,    #前二週銷量
       pmdn212           LIKE pmdn_t.pmdn212,    #前三週銷量
       pmdn213           LIKE pmdn_t.pmdn213,    #前四週銷量
       pmdn207           LIKE pmdn_t.pmdn207     #要貨在途量
                         END RECORD
DEFINE l_where_sql2     STRING                #add by yangxf
DEFINE l_n              LIKE type_t.num5      #add by yangxf
#150710-00016#5 150713 by sakura add(S)                         
DEFINE l_imaz006        LIKE imaz_t.imaz006   #補貨規格說明
DEFINE l_imaz004        LIKE imaz_t.imaz004   #補貨單位
DEFINE l_imaz002        LIKE imaz_t.imaz002   #補貨規格
DEFINE l_rtdx002        LIKE rtdx_t.rtdx002   #主條碼
#150710-00016#5 150713 by sakura add(E)
DEFINE l_where_sql1     STRING                #add by geza 20160707 #160708-00002#1
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   
   DELETE FROM apmt840_02_tmp
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'Del apmt840_02_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   LET l_where_sql = ''
   LET l_where_sql1 = ''                     #add by geza 20160707 #160708-00002#1  
   #所屬品類
   #mark by geza 20160707 #160708-00002#1(S)
#   IF NOT cl_null(l_imaa009) THEN
#      LET l_sys = 0
#      CALL cl_get_para(g_enterprise,g_site,'E-CIR-0001') RETURNING l_sys
#      LET l_where_sql = " AND imaa009 IN (SELECT DISTINCT rtax001",
#                                    "                FROM rtax_t ",
#                                    "               WHERE rtaxent =",g_enterprise,
#                                    "                 AND rtax004 >= ",l_sys,
#                                    "                 AND rtaxstus = 'Y'",
#                                    "               START WITH rtax003 = '",l_imaa009,"'",
#                                    "             CONNECT BY NOCYCLE PRIOR rtax001 = rtax003 ",
#                                    "     UNION ",
#                                    "    SELECT DISTINCT rtax001",
#                                    "               FROM rtax_t ",
#                                    "              WHERE rtaxent =",g_enterprise,
#                                    "                AND rtax004 = ",l_sys,
#                                    "                AND rtax005 = 0 ",
#                                    "                AND rtaxstus = 'Y' ",
#                                    "                AND rtax001 = '",l_imaa009,"' )"                                    
#   END IF
   #mark by geza 20160707 #160708-00002#1(E)  
   #add by geza 20160707 #160708-00002#1(S)
   LET g_wc = cl_replace_str(g_wc,"l_imaa009","rtaw001")
   LET l_sys = 0
   CALL cl_get_para(g_enterprise,g_site,'E-CIR-0001') RETURNING l_sys
   IF g_wc.getIndexOf("rtaw001",1) > 0 THEN

      #LET l_where_sql = " EXISTS (SELECT 1 FROM rtaw_t WHERE rtawent  = ",g_enterprise," AND rtaw002 = imaa009 AND rtaw001 = rtax001 AND rtaw003 = '",l_sys,"')"                                 
   END IF
   LET l_n = 0
   SELECT COUNT(*) INTO l_n
     FROM rtaz_t
    WHERE rtazent = g_enterprise
      AND rtaz001 = g_prog
      AND rtazstus = 'Y'
   IF l_n > 0 THEN
      LET l_where_sql1 = " AND rtaw001 IN (SELECT rtay002 FROM rtay_t WHERE rtayent = ",g_enterprise," ",
                             "                AND rtay001 = '",g_pmdl.pmdl003,"' AND rtaystus = 'Y') "
   END IF
   #add by geza 20160707 #160708-00002#1(E)    
#add by yangxf ---start----#添加商品周期管控
   LET l_n = 0
   #作业限定生命周期设定
   SELECT COUNT(*) 
     INTO l_n
     FROM rtdc_t
    WHERE rtdcent = g_enterprise 
      AND rtdc001 = g_prog 
      AND rtdc002 = '1'
   IF l_n > 0 THEN 
      LET l_where_sql2 = " AND rtdx001 IN(SELECT stas003 FROM star_t,stas_t,rtdc_t ",
                         "             WHERE stasent = starent ",
                         "               AND stasent = ",g_enterprise, 
                         "               AND stas001 = star001 ",
                         "               AND starstus = 'Y' ",
                         "               AND star003 = '",g_pmdl.pmdl004,"'",
                         "               AND '",g_pmdadocdt,"' between stas018 AND stas019 ",
                         "               AND stasent = stasent ",
                         "               AND stas028 = rtdc003 ",
                         "               AND rtdc001 = '",g_prog,"'", 
                         "               AND rtdc002 = '1') "
   END IF 
#add by yangxf ----end----

   LET l_sql = "INSERT INTO apmt840_02_tmp(sel,       star001,       star004,      starsite,",       
               "                           rtdx001,   rtdx002,       pmdn006, ",
               "                           pmdn007,   imaz003,       imaz006,       rtdx004,       pmdn202, ",   #150710-00016#5 150713 by sakura add imaz006
               "                           rtdx034,   rtdx044,   pmdn206,       pmdn209,       rtdx028, ",       #add by geza 20160707 #160708-00002#1 rtdx034
               "                           rtdx029 ) ",
               "SELECT DISTINCT 'N',       star001,   star004,      starsite, ",       
               "                 rtdx001,  rtdx002,   imaa104, ",
               "                 0,        rtdx002,   ''    ,      rtdx004,      0,       ",
               "                 (CASE WHEN ( '",g_pmdl.pmdldocdt,"' >= stas026 AND '",g_pmdl.pmdldocdt,"' <= stas027 ) THEN stas011 ELSE stas010 END),rtdx044,  0,         0,            rtdx028, ",   #add by geza 20160707 #160708-00002#1 stas010,stas011
               "                 rtdx029 ",
               "  FROM rtdx_t,imaa_t,stan_t,star_t,stas_t,ooef_t,rtaw_t ", #add by geza 20160707 #160708-00002#1 add rtaw_t
               " WHERE rtdxent = imaaent ",
               "   AND rtdx001  = imaa001 ",
               "   AND rtdxsite = ooef001 ",
               "   AND rtdxent  =",g_enterprise,
               "   AND rtdxsite = '",g_pmdasite,"'",
               "   AND rtdxstus ='Y' ",
               "   AND imaastus ='Y' ",
               "   AND imaa009 = rtaw002 AND imaaent = rtawent AND rtaw003 = '",l_sys,"' ", #add by geza 20160707 #160708-00002#1
               "   AND starsite = rtdxsite ",
               "   AND imaa001 = rtdx001 ",
               "   AND stanent = rtdxent ",
               "   AND stan001 = star004 AND stanent = starent ",
               "   AND starent = stasent AND star001 = stas001 AND starstus = 'Y' ",
               "   AND starsite = stassite ",  #150930-00013#1 Add By Ken 151006
               #"   AND stas003 = rtdx001 AND star003 = '",g_pmdl.pmdl004,"' AND '",g_pmdadocdt,"' between stan017 AND stan018 ",   #160104-00014#1 20160105 mark by beckxie
               "   AND stas003 = rtdx001 AND star003 = '",g_pmdl.pmdl004,"' AND '",g_pmdadocdt,"' BETWEEN stas018 AND stas019 ",    #160104-00014#1 20160105  add by beckxie
               "   AND NOT EXISTS (SELECT 1 FROM pmdn_t WHERE pmdnent = ",g_enterprise,
               "   AND pmdndocno = '",g_pmdl.pmdldocno,"' AND rtdx001 = pmdn001)"                  
   LET l_sql = l_sql ," AND ",g_wc
   LET l_sql = l_sql ," AND ",g_where_sql
   LET l_sql = l_sql ,l_where_sql,l_where_sql2,l_where_sql1   #add by geza 20160707 #160708-00002#1 add l_where_sql1
   LET l_sql = l_sql ," AND ",s_aooi500_q_where(g_prog,'pmdlsite',g_pmdl.pmdlsite,'i')
   #150930-00013#1 Add By Ken 151006(S)  #取得單頭稅別的稅別應用 如稅別應用為1:正常稅率的話 單身的商品需過濾稅別也一致的商品
   IF s_apmt840_get_oodb011(g_pmdl.pmdlsite,g_pmdl.pmdl011) = '1' THEN
      LET l_sql = l_sql ," AND stas020 = '",g_pmdl.pmdl011,"'" 
   END IF
   #150930-00013#1 Add By Ken 151006(E)   
   LET l_sql = l_sql ," ORDER BY rtdx001,star001,star004,starsite  "   

   PREPARE apmt840_02_ins_tmp FROM l_sql
   EXECUTE apmt840_02_ins_tmp
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'Ins apmt840_02_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   
   #營運據點
   LET l_pmdbsite = g_pmdasite 
   
   CALL cl_get_para(g_enterprise,g_pmdasite,'S-CIR-1001') RETURNING l_sys  
      
   LET l_sql = "SELECT DISTINCT rtdx001,rtdx002",
               "  FROM apmt840_02_tmp"
   PREPARE apmt830_sel_imaz_pre FROM l_sql
   DECLARE apmt830_sel_imaz_cs CURSOR FOR apmt830_sel_imaz_pre
   FOREACH apmt830_sel_imaz_cs INTO l_rtdx.rtdx001,l_rtdx.rtdx002
       
      #150710-00016#5 150713 by sakura add(S)
      #取補貨資料
      LET l_imaz002 = cl_get_para(g_enterprise,g_pmdasite,'S-CIR-1002')
      LET l_imaz004 = ''
      LET l_imaz006 = ''
      SELECT imaz004,imaz006 INTO l_imaz004,l_imaz006
        FROM imaz_t
       WHERE imazent = g_enterprise
         AND imaz001 = l_rtdx.rtdx001
         AND imaz002 = l_imaz002
      #取主條碼
      SELECT rtdx002 INTO l_rtdx002
        FROM rtdx_t
       WHERE rtdxent  = g_enterprise
         AND rtdxsite = g_pmdasite
         AND rtdx001  = l_rtdx.rtdx001
      LET l_rtdx.imaz003 = l_rtdx002
      #單據上的包裝帶位直接帶該商品補貨規格的單位，同時顯示補貨規格說明
      #1.依參數補貨規格設定，抓取商品主檔中的補貨規格的補貨單位->包裝單位及補貨規格說明
      #2.如依門店補貨規格參數抓取不到該商品的補貨規格時，則直接抓取該商品的主條碼的包裝單位當作單據的包裝單位，補貨規格放空白
      LET l_rtdx.rtdx004 = ''
      LET l_rtdx.imaz006 = ''
      IF NOT cl_null(l_imaz004) THEN
         LET l_rtdx.rtdx004 = l_imaz004      
         LET l_rtdx.imaz006 = l_imaz006
      ELSE
         #取得商品主條碼裡的包裝單位
         SELECT imay004 INTO l_rtdx.rtdx004
           FROM imay_t
          WHERE imayent = g_enterprise
            AND imay003 = l_rtdx.imaz003
      END IF      
      #150710-00016#5 150713 by sakura add(E)
      
      #150710-00016#5 150713 by sakura mark(S)
      #補貨條碼、包裝單位       
      #SELECT imaz003,imaz004 INTO l_rtdx.imaz003,l_rtdx.rtdx004
      #  FROM imaz_t
      # WHERE imazent = g_enterprise
      #   AND imaz001 = l_rtdx.rtdx001
      #150710-00016#5 150713 by sakura mark(E)

      IF NOT cl_null(l_rtdx.imaz003) THEN
         UPDATE apmt840_02_tmp
            SET imaz003 = l_rtdx.imaz003,
                rtdx004 = l_rtdx.rtdx004,
                imaz006 = l_rtdx.imaz006   #150710-00016#5 150713 by sakura add
          WHERE rtdx001 = l_rtdx.rtdx001
            AND rtdx002 = l_rtdx.rtdx002
      END IF
      
      #可用庫存量
      CALL s_apmt840_sum_inag008(l_pmdbsite,l_rtdx.rtdx001,' ') 
         RETURNING l_rtdx.pmdn206

      #前一週銷量
      CALL s_daily_sale(l_pmdbsite,g_pmdadocdt,1,7,l_rtdx.rtdx001,' ')
         RETURNING l_rtdx.pmdn210
      
      #前二週銷量
      CALL s_daily_sale(l_pmdbsite,g_pmdadocdt,8,14,l_rtdx.rtdx001,' ')
         RETURNING l_rtdx.pmdn211
         
      #前三週銷量
      CALL s_daily_sale(l_pmdbsite,g_pmdadocdt,15,21,l_rtdx.rtdx001,' ')
         RETURNING l_rtdx.pmdn212
         
      #前四周銷量
      CALL s_daily_sale(l_pmdbsite,g_pmdadocdt,22,28,l_rtdx.rtdx001,' ')
         RETURNING l_rtdx.pmdn213
      
      #要貨在途量
      CALL s_apmt830_sum_pmdb258(l_pmdbsite,l_rtdx.rtdx001,' ')
         RETURNING l_rtdx.pmdn207
      
      #週平均銷量
      LET l_rtdx.pmdn209 = (l_rtdx.pmdn210 + l_rtdx.pmdn211 + l_rtdx.pmdn212 + l_rtdx.pmdn213)/4
           
      #获取采购单位
      SELECT imaa104 INTO l_imaa104
        FROM imaa_t 
       WHERE imaaent = g_enterprise
         AND imaa001 = l_rtdx.rtdx001
      #當收貨數量為空，由要貨包裝數量轉換成要貨數量
      CALL s_aooi250_convert_qty(l_rtdx.rtdx001,l_rtdx.rtdx004,l_imaa104,1)
            RETURNING l_success,l_pmdn007
      #add by yangxf ---start----
      LET l_deba002 = ''
      SELECT MAX(deba002) INTO l_deba002
        FROM deba_t
       WHERE debaent = g_enterprise
         AND debasite = g_pmdasite
         AND deba009 = l_rtdx.rtdx001
      #add by yangxf ---end-----   
      UPDATE apmt840_02_tmp
         SET pmdn206 = l_rtdx.pmdn206,
             pmdn210 = l_rtdx.pmdn210,
             pmdn211 = l_rtdx.pmdn211,
             pmdn212 = l_rtdx.pmdn212,
             pmdn213 = l_rtdx.pmdn213,
             pmdn207 = l_rtdx.pmdn207,
             pmdn209 = l_rtdx.pmdn209,
             pmdn007 = l_pmdn007,
             deba002 = l_deba002,       #add by yangxf 
             pmdn202 = 1
       WHERE rtdx001 = l_rtdx.rtdx001
         AND rtdx002 = l_rtdx.rtdx002   
   END FOREACH
   
   CALL apmt840_02_b_fill()
   
   LET g_rec_b = g_rtdx_d.getLength()
   IF g_rec_b = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-01321'  #apm-00294   #160318-00005#38  By 07900--mod
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
END FUNCTION

################################################################################
# Descriptions...: 全選
# Memo...........:
# Usage..........: CALL apmt840_02_check_all()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/05/27 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt840_02_check_all()
   UPDATE apmt840_02_tmp SET sel = 'Y'
   CALL apmt840_02_set_entry_b("a")
   CALL apmt840_02_set_no_entry_b("a")    
   CALL apmt840_02_b_fill()
END FUNCTION

################################################################################
# Descriptions...: 全不選
# Memo...........:
# Usage..........: CALL apmt840_02_check_no_all()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/05/27 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt840_02_check_no_all()
   UPDATE apmt840_02_tmp SET sel = 'N'
   CALL apmt840_02_set_entry_b("a")
   CALL apmt840_02_set_no_entry_b("a")    
   CALL apmt840_02_b_fill()
END FUNCTION

################################################################################
# Descriptions...: 單位間的轉換數量
# Memo...........: 當要貨數量為空，由要貨包裝數量轉換成要貨數量及計價數量
#                : 當要貨數量有值，由要貨數量轉換成要貨包裝數量及計價數量
# Usage..........: CALL apmt840_02_num_change()
# Input parameter: 無
# Return code....: r_success  True/False
# Date & Author..: 2015/05/27 By Ken
# Modify.........: 2015/09/07 By sakura
################################################################################
PRIVATE FUNCTION apmt840_02_num_change()
DEFINE r_success        LIKE type_t.num5   #150903-00007#1 150903 by sakura add
DEFINE l_success        LIKE type_t.num5

   LET r_success = TRUE   #150903-00007#1 150903 by sakura add
   
   #當要貨包裝單位或要貨單位都為空，表示無法轉換
   IF cl_null(g_rtdx_d[l_ac].l_pmdb007) OR cl_null(g_rtdx_d[l_ac].rtdx004) THEN
       #150903-00007#1 150903 by sakura mark&add(S)
       #RETURN
       LET r_success = FALSE
       RETURN r_success
       #150903-00007#1 150903 by sakura mark&add(S)
   END IF

#   #當要貨數量為空
#   IF cl_null(g_rtdx_d[l_ac].l_pmdb006) THEN
#      #當要貨包裝數量為空
#      IF cl_null(g_rtdx_d[l_ac].l_pmdb212) THEN
#         RETURN
#      ELSE
#         #當收貨數量為空，由要貨包裝數量轉換成要貨數量
#         CALL s_aooi250_convert_qty(g_rtdx_d[l_ac].rtdx001,g_rtdx_d[l_ac].rtdx004,g_rtdx_d[l_ac].l_pmdb007,g_rtdx_d[l_ac].l_pmdb212)
#            RETURNING l_success,g_rtdx_d[l_ac].l_pmdb006
#      END IF
#   ELSE
#      #當要貨數量有值，由要貨數量轉換成要貨包裝數量
#      CALL s_aooi250_convert_qty(g_rtdx_d[l_ac].rtdx001,g_rtdx_d[l_ac].l_pmdb007,g_rtdx_d[l_ac].rtdx004,g_rtdx_d[l_ac].l_pmdb006)
#         RETURNING l_success,g_rtdx_d[l_ac].l_pmdb212
#   END IF
    CASE 
       WHEN INFIELD(l_pmdb212)
          CALL s_aooi250_convert_qty(g_rtdx_d[l_ac].rtdx001,g_rtdx_d[l_ac].rtdx004,g_rtdx_d[l_ac].l_pmdb007,g_rtdx_d[l_ac].l_pmdb212)
               RETURNING l_success,g_rtdx_d[l_ac].l_pmdb006
          #150903-00007#1 150903 by sakura add(S)
          IF l_success = FALSE THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
          #150903-00007#1 150903 by sakura add(E)                              
       WHEN INFIELD(l_pmdb006)
          CALL s_aooi250_convert_qty(g_rtdx_d[l_ac].rtdx001,g_rtdx_d[l_ac].l_pmdb007,g_rtdx_d[l_ac].rtdx004,g_rtdx_d[l_ac].l_pmdb006)
               RETURNING l_success,g_rtdx_d[l_ac].l_pmdb212
          #150903-00007#1 150903 by sakura add(S)
          IF l_success = FALSE THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
          #150903-00007#1 150903 by sakura add(E)            
    END CASE
    RETURN r_success   #150903-00007#1 150903 by sakura add
END FUNCTION

################################################################################
# Descriptions...: 更新tmp中的要貨數量、要貨包裝數量
# Memo...........:
# Usage..........: CALL apmt840_02_pmdb006_upd()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/05/29 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt840_02_pmdb006_upd()
   UPDATE apmt840_02_tmp 
      SET pmdn007 = g_rtdx_d[l_ac].l_pmdb006,
          pmdn202 = g_rtdx_d[l_ac].l_pmdb212
    WHERE rtdx001 = g_rtdx_d[l_ac].rtdx001
      AND star001 = g_rtdx_d[l_ac].star001
      AND star004 = g_rtdx_d[l_ac].star004
      AND starsite = g_rtdx_d[l_ac].starsite
END FUNCTION

################################################################################

################################################################################
PRIVATE FUNCTION s_apmt840_02_chk_pmdnunit()
DEFINE r_success            LIKE type_t.num5
DEFINE l_cnt                LIKE type_t.num5

   LET r_success = TRUE
   
   LET l_cnt = 0
   SELECT COUNT(ooef001) INTO l_cnt
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_pmdl.pmdlsite
      AND ooef211 = 'Y'
      
   IF l_cnt = 0 THEN
      LET r_success = FALSE
      RETURN r_success
   ELSE
      RETURN r_success
   END IF
END FUNCTION

 
{</section>}
 
