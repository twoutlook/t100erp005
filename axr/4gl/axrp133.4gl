#該程式未解開Section, 採用最新樣板產出!
{<section id="axrp133.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0023(2016-09-23 15:21:21), PR版次:0023(2017-01-12 14:29:40)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000133
#+ Filename...: axrp133
#+ Description: 出貨應收批次立帳作業
#+ Creator....: 01727(2014-10-16 14:20:15)
#+ Modifier...: 07900 -SD/PR- 08532
 
{</section>}
 
{<section id="axrp133.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#20150201#1                  By 01727     為了規避多用戶並行執行程序導致出貨/銷退單重複拋磚應收,對拋轉邏輯進行修改：
#                                         取得符合條件的資料集後,在FOREACH中每一筆資料單獨走一次事物
#                                         在事物中,先將取得的出貨/銷退單鎖住,然後再進行拋轉前的欄位複製
#                                         最後再插入應收表之前，再次判斷出貨單/銷退單的可用性
#                                         在拋轉應收結束後無論成功否放開出貨單/銷退單資料
#                                         最後將失敗的資料和成功的資料用資料匯總報錯出來
#150316-00013#1              By 01727     直接沖帳段可用金額的取得,需要再扣除已沖帳未審核的金額
#150309-00036#1   2015/04/01 By 01727     銷退單立帳條件sql統一:
#                                         1.統一加入 AND xmdk000 IN ('1','2','3','6')
#                                         2.銷退單條件增加排除xmdk082
#                                         OR (xmdk000 = 6 AND xmdk082<>'5') )
#150317-00001#3   2015/04/07 By 01727     1.單身:xrcb051 = xmdl003 出货单项次对应之订单号串xmda002
#                           　               xrcb010 = xmdl003 出货单项次对应之订单号串xmda003
#                                         2.單頭:1)非业务人员 AND 非业务部门汇总时
#                                              xrca014 = pmab081 WHERE pmabsite = glaacomp(axmm202)
#20150408 150317-00001#3                  暂时还原，等讨论后再做调整xrca015 = pmab109 WHERE pmabsite = glaacomp(axmm202)
#                                         2)业务人员汇总时
#                                           xrca014 = xmdl003 出货单项次对应之订单号串xmda002  group 拆单后写到 xrca014 
#                                           xrca015 = pmab109 where pmabsite = 帐套所属法人 (xrmm202) 
#                                         3)业务部门汇总时
#                                           业务人员xrca014 = pmab081 where pmabsite = 帐套所属法人(axmm202)
#                                           业务部门xrca015 = xmdl003 出货单项次对应之订单号串xmda003 group 拆单后写到 xrca015
#150515-00013#3               By 01727    檢查， 若為本位幣立帳者，本幣金額=原幣金額， 本幣不要重算s_tax
#150807-00010#1   2015/08/10  By Belle    若為axmt600的金額折讓xrcb021取理由碼的會科
#150828-00001#2   2015/10/23  By 01727    axrt3* 的程式 xrcb005 存品名加規格, 中間以 '/' 區間
#151013-00019#7   2015/10/28  By Reanna   銷退方式改1&4都要先用理由碼取會科
#151102-00007#1   2015/11/02  By yangtt   生成后，单据编号栏位会显示“xmdk007='FJB01'
#150203-00010#6   2015/11/20  By 01727    立帳時,如果輸入立帳日期,那麼應該限定出貨/銷退單扣帳日期小於等於立帳日期
#151125-00006#1   2015/12/05  By 06862    生成單據后立即審核，立即拋轉傳票
#151231-00010#9   2016/03/04  By 02599    增加控制组权限控管
#160120-00011#3   2016/03/23  By 02114    1.取用 s_get_item_acc時, 須增加補足可傳入的參數值 
#                                         (1). AXR:取用s_get_item_acc時, 須增加補足可傳入的參數值 
#                                         p_kind   採購分群  :  取單頭的 【銷售分類xrca058】 
#                                         p_trade  交易通路  :  傳入渠道, 取單身的【渠道xrcb034】 
#                                         p_site   營運據點  :  不變 #                  
#                                         p_ware   倉庫別    :  取來源單號的庫別欄位, 即出貨/銷退單的【庫別xmdl014】;  無對應來源單號者，則以空白傳入。
#160318-00005#51 2016/03/23  By 07959     將重複內容的錯誤訊息置換為公用錯誤訊息
#160325-00023#1  2016/03/29  By Hans      單別流程-預設單別修改 根據aooi210設置之流程修改單別合理性
#160318-00025#42 2016/04/25  By pengxin   將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160505-00005#1  2016/05/06  By 01531     取法人據點之交易對象檔,若取不到法人據點時, 取 據點代碼='ALL'
#160715-00017#1  2016/07/18  by 01727     根据SCC码2077确定出貨/簽收/銷退單據性質中可以立应收账款的单据性质 (gzcb003 = 'Y')
#                                         根据SCC码2088确定销退单据可以应收的销退方式 (gzcb003 = 'Y')
#160727-00019#5   2016/07/28 By 08734     将axrp131_xmdk_tmp ——> axrp131_tmp01
#160727-00019#33  2016/08/11 By 08742     系统中定义的临时表名称超过15码在执行时会出错,所以需要将系统中定义的临时表长度超过15码的全部改掉
#                                         Mod axrp133_xmdk_tmp --> axrp133_tmp01
#160731-00372#1   2016/08/16 By 07900     客户开窗不要开供应商
#160811-00009#4   2016/08/22 By 01531     账务中心/法人/账套权限控管
#160905-00007#3   2016/09/05 By zhujing   调整系统中无ENT的SQL条件增加ent
#160913-00017#9   2016/09/22 By 07900     AXR模组调整交易客商开窗
#160905-00031#1   2016/09/23 By 01727     延續 160707-00023#1 處理加內外銷條件QBE 結關日(外銷條件時)立帳日期,外銷時取結關日
#160802-00007#1   2016/09/26 By 01727     一次性交易對象識別碼(pmaa004=2)功能應用
#161021-00050#2   2016/10/24 By 08729     處理組織開窗
#161025-00017#1   2016/10/26 By 01531     出货单axmt500的销售渠道xmda023需带入应收单身的渠道xrcb034  
#161026-00013#1   2016/10/26 By 06821     組織類型與職能開窗調整
#161111-00049#6   2016/11/24 By 01727    控制组权限修改
#161128-00061#3   2016/12/01 by 02481    标准程式定义采用宣告模式,弃用.*写法
#170112-00002#1   2017/01/12  By 08532    將axrp131、axrp133中的l_amount定義調整為 LIKE xmdl_t.xmdl022
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_schedule
#add-point:增加匯入項目 name="global.import"
 
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../cfg/top_schedule.inc"
GLOBALS
   DEFINE gwin_curr2  ui.Window
   DEFINE gfrm_curr2  ui.Form
   DEFINE gi_hiden_asign       LIKE type_t.num5
   DEFINE gi_hiden_exec        LIKE type_t.num5
   DEFINE gi_hiden_spec        LIKE type_t.num5
   DEFINE gi_hiden_exec_end    LIKE type_t.num5
   DEFINE g_chk_jobid          LIKE type_t.num5
END GLOBALS
 
PRIVATE TYPE type_parameter RECORD
   #add-point:自定背景執行須傳遞的參數(Module Variable) name="global.parameter"
   
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       xrcasite LIKE xrca_t.xrcasite, 
   xrcasite_desc LIKE type_t.chr80, 
   xrcald LIKE xrca_t.xrcald, 
   xrcald_desc LIKE type_t.chr80, 
   b_style LIKE type_t.chr500, 
   xrcadocno LIKE xrca_t.xrcadocno, 
   xrca007 LIKE xrca_t.xrca007, 
   xrcadocdt LIKE xrca_t.xrcadocdt, 
   b_check1 LIKE type_t.chr500, 
   b_check4 LIKE type_t.chr500, 
   b_check2 LIKE type_t.chr500, 
   b_check5 LIKE type_t.chr500, 
   b_check3 LIKE type_t.chr500, 
   b_check6 LIKE type_t.chr500, 
   b_comb1 LIKE type_t.chr500, 
   xmdk042 LIKE xmdk_t.xmdk042, 
   xmdk032 LIKE xmdk_t.xmdk032, 
   b_comb2 LIKE type_t.chr500, 
   xmdk007 LIKE xmdk_t.xmdk007, 
   xmdk001 LIKE xmdk_t.xmdk001, 
   xmdk000 LIKE xmdk_t.xmdk000, 
   xmdkdocno LIKE xmdk_t.xmdkdocno, 
   xmdk003 LIKE xmdk_t.xmdk003, 
   xmdk004 LIKE xmdk_t.xmdk004, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
#20150201#1 By zhangwei Add ---(S)---
TYPE type_xmdk RECORD
   order       LIKE type_t.chr200,
   xmdldocno   LIKE xmdl_t.xmdldocno,
   xmdlseq     LIKE xmdl_t.xmdlseq,
   xrcb007     LIKE xrcb_t.xrcb007,
   xmdk047     LIKE xmdk_t.xmdk047   #160802-00007#1 Add
       END RECORD
DEFINE g_xmdk_d DYNAMIC ARRAY OF type_xmdk
#20150201#1 By zhangwei Add ---(E)---

DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
#161128-00061#3-----modify--begin----------
#DEFINE g_glaa           RECORD LIKE glaa_t.*
#DEFINE g_xrca           RECORD LIKE xrca_t.*
#DEFINE g_xrcb           RECORD LIKE xrcb_t.*
DEFINE g_xrca RECORD  #應收憑單單頭
       xrcaent LIKE xrca_t.xrcaent, #企業編號
       xrcaownid LIKE xrca_t.xrcaownid, #資料所有者
       xrcaowndp LIKE xrca_t.xrcaowndp, #資料所屬部門
       xrcacrtid LIKE xrca_t.xrcacrtid, #資料建立者
       xrcacrtdp LIKE xrca_t.xrcacrtdp, #資料建立部門
       xrcacrtdt LIKE xrca_t.xrcacrtdt, #資料創建日
       xrcamodid LIKE xrca_t.xrcamodid, #資料修改者
       xrcamoddt LIKE xrca_t.xrcamoddt, #最近修改日
       xrcacnfid LIKE xrca_t.xrcacnfid, #資料確認者
       xrcacnfdt LIKE xrca_t.xrcacnfdt, #資料確認日
       xrcapstid LIKE xrca_t.xrcapstid, #資料過帳者
       xrcapstdt LIKE xrca_t.xrcapstdt, #資料過帳日
       xrcastus LIKE xrca_t.xrcastus, #狀態碼
       xrcacomp LIKE xrca_t.xrcacomp, #法人
       xrcald LIKE xrca_t.xrcald, #帳套
       xrcadocno LIKE xrca_t.xrcadocno, #應收帳款單號碼
       xrcadocdt LIKE xrca_t.xrcadocdt, #帳款日期
       xrca001 LIKE xrca_t.xrca001, #帳款單性質
       xrcasite LIKE xrca_t.xrcasite, #帳務中心
       xrca003 LIKE xrca_t.xrca003, #帳務人員
       xrca004 LIKE xrca_t.xrca004, #帳款客戶編號
       xrca005 LIKE xrca_t.xrca005, #收款客戶
       xrca006 LIKE xrca_t.xrca006, #客戶分類
       xrca007 LIKE xrca_t.xrca007, #帳款類別
       xrca008 LIKE xrca_t.xrca008, #收款條件編號
       xrca009 LIKE xrca_t.xrca009, #應收款日/應扣抵日
       xrca010 LIKE xrca_t.xrca010, #容許票據到期日
       xrca011 LIKE xrca_t.xrca011, #稅別
       xrca012 LIKE xrca_t.xrca012, #稅率
       xrca013 LIKE xrca_t.xrca013, #含稅否
       xrca014 LIKE xrca_t.xrca014, #人員編號
       xrca015 LIKE xrca_t.xrca015, #部門編號
       xrca016 LIKE xrca_t.xrca016, #來源作業類型
       xrca017 LIKE xrca_t.xrca017, #產生方式
       xrca018 LIKE xrca_t.xrca018, #來源參考單號
       xrca019 LIKE xrca_t.xrca019, #系統產生對應單號(待抵帳款-預收)
       xrca020 LIKE xrca_t.xrca020, #信用狀申請流程否
       xrca021 LIKE xrca_t.xrca021, #商業發票號碼(IV no.)
       xrca022 LIKE xrca_t.xrca022, #出口報單號碼
       xrca023 LIKE xrca_t.xrca023, #發票客戶編號
       xrca024 LIKE xrca_t.xrca024, #發票客戶統一編號
       xrca025 LIKE xrca_t.xrca025, #發票客戶全名
       xrca026 LIKE xrca_t.xrca026, #發票客戶地址
       xrca028 LIKE xrca_t.xrca028, #發票類型
       xrca029 LIKE xrca_t.xrca029, #發票匯率
       xrca030 LIKE xrca_t.xrca030, #發票應開未稅金額
       xrca031 LIKE xrca_t.xrca031, #發票應開稅額
       xrca032 LIKE xrca_t.xrca032, #發票應開含稅金額
       xrca033 LIKE xrca_t.xrca033, #專案編號
       xrca034 LIKE xrca_t.xrca034, #責任中心
       xrca035 LIKE xrca_t.xrca035, #應收(借方)科目編號
       xrca036 LIKE xrca_t.xrca036, #收入(貸方)科目編號
       xrca037 LIKE xrca_t.xrca037, #分錄傳票產生否
       xrca038 LIKE xrca_t.xrca038, #拋轉傳票號碼
       xrca039 LIKE xrca_t.xrca039, #會計檢核附件份數
       xrca040 LIKE xrca_t.xrca040, #留置否
       xrca041 LIKE xrca_t.xrca041, #留置理由碼
       xrca042 LIKE xrca_t.xrca042, #留置設定日期
       xrca043 LIKE xrca_t.xrca043, #留置解除日期
       xrca044 LIKE xrca_t.xrca044, #留置原幣金額
       xrca045 LIKE xrca_t.xrca045, #留置說明
       xrca046 LIKE xrca_t.xrca046, #關係人否
       xrca047 LIKE xrca_t.xrca047, #多角序號
       xrca048 LIKE xrca_t.xrca048, #集團代收/代付單號
       xrca049 LIKE xrca_t.xrca049, #來源營運中心編號
       xrca050 LIKE xrca_t.xrca050, #交易原始單據份數
       xrca051 LIKE xrca_t.xrca051, #作廢理由碼
       xrca052 LIKE xrca_t.xrca052, #列印次數
       xrca053 LIKE xrca_t.xrca053, #備註
       xrca054 LIKE xrca_t.xrca054, #多帳期設定
       xrca055 LIKE xrca_t.xrca055, #繳款優惠條件
       xrca056 LIKE xrca_t.xrca056, #會計檢核附件狀態
       xrca057 LIKE xrca_t.xrca057, #交易對象識別碼
       xrca058 LIKE xrca_t.xrca058, #銷售分類
       xrca059 LIKE xrca_t.xrca059, #預算編號
       xrca060 LIKE xrca_t.xrca060, #發票開立原則
       xrca061 LIKE xrca_t.xrca061, #預計開立發票日期
       xrca062 LIKE xrca_t.xrca062, #多角性質
       xrca063 LIKE xrca_t.xrca063, #整帳批序號
       xrca064 LIKE xrca_t.xrca064, #訂金序次
       xrca065 LIKE xrca_t.xrca065, #發票編號
       xrca066 LIKE xrca_t.xrca066, #發票號碼
       xrca100 LIKE xrca_t.xrca100, #交易原幣別
       xrca101 LIKE xrca_t.xrca101, #原幣匯率
       xrca103 LIKE xrca_t.xrca103, #原幣未稅金額
       xrca104 LIKE xrca_t.xrca104, #原幣稅額
       xrca106 LIKE xrca_t.xrca106, #原幣直接折抵合計金額
       xrca107 LIKE xrca_t.xrca107, #原幣直接沖帳(調整)合計金額
       xrca108 LIKE xrca_t.xrca108, #原幣應收金額
       xrca113 LIKE xrca_t.xrca113, #本幣未稅金額
       xrca114 LIKE xrca_t.xrca114, #本幣稅額
       xrca116 LIKE xrca_t.xrca116, #本幣直接沖帳(調整)合計金額
       xrca117 LIKE xrca_t.xrca117, #本幣直接沖帳(調整)合計金額
       xrca118 LIKE xrca_t.xrca118, #本幣應收金額
       xrca120 LIKE xrca_t.xrca120, #本位幣二幣別
       xrca121 LIKE xrca_t.xrca121, #本位幣二匯率
       xrca123 LIKE xrca_t.xrca123, #本位幣二未稅金額
       xrca124 LIKE xrca_t.xrca124, #本位幣二稅額
       xrca126 LIKE xrca_t.xrca126, #本位幣二直接折抵合計金額
       xrca127 LIKE xrca_t.xrca127, #本位幣二直接沖帳(調整)合計金額
       xrca128 LIKE xrca_t.xrca128, #本位幣二應收金額
       xrca130 LIKE xrca_t.xrca130, #本位幣三幣別
       xrca131 LIKE xrca_t.xrca131, #本位幣三匯率
       xrca133 LIKE xrca_t.xrca133, #本位幣三未稅金額
       xrca134 LIKE xrca_t.xrca134, #本位幣三稅額
       xrca136 LIKE xrca_t.xrca136, #本位幣三直接折抵合計金額
       xrca137 LIKE xrca_t.xrca137, #本位幣三直接沖帳(調整)合計金額
       xrca138 LIKE xrca_t.xrca138  #本位幣三應收金額
END RECORD

DEFINE g_xrcb RECORD  #應收憑單單身
       xrcbent LIKE xrcb_t.xrcbent, #企業編號
       xrcbld LIKE xrcb_t.xrcbld, #帳套
       xrcbdocno LIKE xrcb_t.xrcbdocno, #單號
       xrcbseq LIKE xrcb_t.xrcbseq, #項次
       xrcbsite LIKE xrcb_t.xrcbsite, #營運據點
       xrcborga LIKE xrcb_t.xrcborga, #帳務來源SITE
       xrcb001 LIKE xrcb_t.xrcb001, #來源類型
       xrcb002 LIKE xrcb_t.xrcb002, #來源業務單據號碼
       xrcb003 LIKE xrcb_t.xrcb003, #來源業務單據項次
       xrcb004 LIKE xrcb_t.xrcb004, #產品編號
       xrcb005 LIKE xrcb_t.xrcb005, #品名規格
       xrcb006 LIKE xrcb_t.xrcb006, #單位
       xrcb007 LIKE xrcb_t.xrcb007, #計價數量
       xrcb008 LIKE xrcb_t.xrcb008, #參考單據號碼
       xrcb009 LIKE xrcb_t.xrcb009, #參考單號項次
       xrcblegl LIKE xrcb_t.xrcblegl, #核算組織
       xrcb010 LIKE xrcb_t.xrcb010, #業務部門
       xrcb011 LIKE xrcb_t.xrcb011, #責任中心
       xrcb012 LIKE xrcb_t.xrcb012, #產品類別
       xrcb013 LIKE xrcb_t.xrcb013, #發票帳否(搭贈/備品/樣品)
       xrcb014 LIKE xrcb_t.xrcb014, #理由碼
       xrcb015 LIKE xrcb_t.xrcb015, #專案編號
       xrcb016 LIKE xrcb_t.xrcb016, #WBS編號
       xrcb017 LIKE xrcb_t.xrcb017, #預算細項
       xrcb018 LIKE xrcb_t.xrcb018, #商戶編號
       xrcb019 LIKE xrcb_t.xrcb019, #開票性質
       xrcb020 LIKE xrcb_t.xrcb020, #稅別
       xrcb021 LIKE xrcb_t.xrcb021, #收入會計科目
       xrcb022 LIKE xrcb_t.xrcb022, #正負值
       xrcb023 LIKE xrcb_t.xrcb023, #沖暫估單否
       xrcb024 LIKE xrcb_t.xrcb024, #區域
       xrcb025 LIKE xrcb_t.xrcb025, #傳票號碼
       xrcb026 LIKE xrcb_t.xrcb026, #傳票項次
       xrcb027 LIKE xrcb_t.xrcb027, #發票編號
       xrcb028 LIKE xrcb_t.xrcb028, #發票號碼
       xrcb029 LIKE xrcb_t.xrcb029, #應收帳款科目
       xrcb030 LIKE xrcb_t.xrcb030, #已開發票數量
       xrcb031 LIKE xrcb_t.xrcb031, #收款條件編號
       xrcb032 LIKE xrcb_t.xrcb032, #訂金序次
       xrcb033 LIKE xrcb_t.xrcb033, #經營方式
       xrcb034 LIKE xrcb_t.xrcb034, #通路
       xrcb035 LIKE xrcb_t.xrcb035, #品牌
       xrcb036 LIKE xrcb_t.xrcb036, #客群
       xrcb037 LIKE xrcb_t.xrcb037, #自由核算項一
       xrcb038 LIKE xrcb_t.xrcb038, #自由核算項二
       xrcb039 LIKE xrcb_t.xrcb039, #自由核算項三
       xrcb040 LIKE xrcb_t.xrcb040, #自由核算項四
       xrcb041 LIKE xrcb_t.xrcb041, #自由核算項五
       xrcb042 LIKE xrcb_t.xrcb042, #自由核算項六
       xrcb043 LIKE xrcb_t.xrcb043, #自由核算項七
       xrcb044 LIKE xrcb_t.xrcb044, #自由核算項八
       xrcb045 LIKE xrcb_t.xrcb045, #自由核算項九
       xrcb046 LIKE xrcb_t.xrcb046, #自由核算項十
       xrcb047 LIKE xrcb_t.xrcb047, #摘要
       xrcb048 LIKE xrcb_t.xrcb048, #客戶訂購單號
       xrcb049 LIKE xrcb_t.xrcb049, #開票單號
       xrcb050 LIKE xrcb_t.xrcb050, #開票項次
       xrcb051 LIKE xrcb_t.xrcb051, #業務人員
       xrcb100 LIKE xrcb_t.xrcb100, #交易原幣
       xrcb101 LIKE xrcb_t.xrcb101, #交易原幣單價
       xrcb102 LIKE xrcb_t.xrcb102, #交易匯率
       xrcb103 LIKE xrcb_t.xrcb103, #交易原幣未稅金額
       xrcb104 LIKE xrcb_t.xrcb104, #交易原幣稅額
       xrcb105 LIKE xrcb_t.xrcb105, #交易原幣含稅金額
       xrcb106 LIKE xrcb_t.xrcb106, #交易原幣調整差異金額
       xrcb111 LIKE xrcb_t.xrcb111, #本幣單價
       xrcb113 LIKE xrcb_t.xrcb113, #本幣未稅金額
       xrcb114 LIKE xrcb_t.xrcb114, #本幣稅額
       xrcb115 LIKE xrcb_t.xrcb115, #本幣含稅金額
       xrcb116 LIKE xrcb_t.xrcb116, #本幣調整差異金額
       xrcb117 LIKE xrcb_t.xrcb117, #已開發票金額(未稅)
       xrcb118 LIKE xrcb_t.xrcb118, #應開發票未稅金額
       xrcb119 LIKE xrcb_t.xrcb119, #應開發票含稅金額
       xrcb121 LIKE xrcb_t.xrcb121, #本位幣二匯率
       xrcb123 LIKE xrcb_t.xrcb123, #本位幣二未稅金額
       xrcb124 LIKE xrcb_t.xrcb124, #本位幣二稅額
       xrcb125 LIKE xrcb_t.xrcb125, #本位幣二含稅金額
       xrcb126 LIKE xrcb_t.xrcb126, #本位幣二調整差異金額
       xrcb131 LIKE xrcb_t.xrcb131, #本位幣三匯率
       xrcb133 LIKE xrcb_t.xrcb133, #本位幣三未稅金額
       xrcb134 LIKE xrcb_t.xrcb134, #本位幣三稅額
       xrcb135 LIKE xrcb_t.xrcb135, #本位幣三含稅金額
       xrcb136 LIKE xrcb_t.xrcb136, #本位幣三調整差異金額
       xrcb052 LIKE xrcb_t.xrcb052, #款別編號
       xrcb053 LIKE xrcb_t.xrcb053, #帳款對象
       xrcb054 LIKE xrcb_t.xrcb054, #收款對象
       xrcb055 LIKE xrcb_t.xrcb055, #收現金額(流通)
       xrcb056 LIKE xrcb_t.xrcb056, #應收金額(流通)
       xrcb057 LIKE xrcb_t.xrcb057, #扣款金額(流通)
       xrcb058 LIKE xrcb_t.xrcb058, #預收科目
       xrcb059 LIKE xrcb_t.xrcb059, #代收銀科目
       xrcb060 LIKE xrcb_t.xrcb060, #月份類型
       xrcb107 LIKE xrcb_t.xrcb107  #出貨單單價
       END RECORD

DEFINE g_glaa RECORD  #帳套資料檔
       glaaent LIKE glaa_t.glaaent, #企業編號
       glaaownid LIKE glaa_t.glaaownid, #資料所有者
       glaaowndp LIKE glaa_t.glaaowndp, #資料所屬部門
       glaacrtid LIKE glaa_t.glaacrtid, #資料建立者
       glaacrtdp LIKE glaa_t.glaacrtdp, #資料建立部門
       glaacrtdt LIKE glaa_t.glaacrtdt, #資料創建日
       glaamodid LIKE glaa_t.glaamodid, #資料修改者
       glaamoddt LIKE glaa_t.glaamoddt, #最近修改日
       glaastus LIKE glaa_t.glaastus, #狀態碼
       glaald LIKE glaa_t.glaald, #帳套編號
       glaacomp LIKE glaa_t.glaacomp, #歸屬法人
       glaa001 LIKE glaa_t.glaa001, #使用幣別
       glaa002 LIKE glaa_t.glaa002, #匯率參照表號
       glaa003 LIKE glaa_t.glaa003, #會計週期參照表號
       glaa004 LIKE glaa_t.glaa004, #會計科目參照表號
       glaa005 LIKE glaa_t.glaa005, #現金變動參照表號
       glaa006 LIKE glaa_t.glaa006, #月結方式
       glaa007 LIKE glaa_t.glaa007, #年結方式
       glaa008 LIKE glaa_t.glaa008, #平行記帳否
       glaa009 LIKE glaa_t.glaa009, #傳票登入方式
       glaa010 LIKE glaa_t.glaa010, #現行年度
       glaa011 LIKE glaa_t.glaa011, #現行期別
       glaa012 LIKE glaa_t.glaa012, #最後過帳日期
       glaa013 LIKE glaa_t.glaa013, #關帳日期
       glaa014 LIKE glaa_t.glaa014, #主帳套
       glaa015 LIKE glaa_t.glaa015, #啟用本位幣二
       glaa016 LIKE glaa_t.glaa016, #本位幣二
       glaa017 LIKE glaa_t.glaa017, #本位幣二換算基準
       glaa018 LIKE glaa_t.glaa018, #本位幣二匯率採用
       glaa019 LIKE glaa_t.glaa019, #啟用本位幣三
       glaa020 LIKE glaa_t.glaa020, #本位幣三
       glaa021 LIKE glaa_t.glaa021, #本位幣三換算基準
       glaa022 LIKE glaa_t.glaa022, #本位幣三匯率採用
       glaa023 LIKE glaa_t.glaa023, #次帳套帳務產生時機
       glaa024 LIKE glaa_t.glaa024, #單據別參照表號
       glaa025 LIKE glaa_t.glaa025, #本位幣一匯率採用
       glaa026 LIKE glaa_t.glaa026, #幣別參照表號
       glaa100 LIKE glaa_t.glaa100, #傳票輸入時自動按缺號產生
       glaa101 LIKE glaa_t.glaa101, #傳票總號輸入時機
       glaa102 LIKE glaa_t.glaa102, #傳票成立時,借貸不平衡的處理方式
       glaa103 LIKE glaa_t.glaa103, #未列印的傳票可否進行過帳
       glaa111 LIKE glaa_t.glaa111, #應計調整單別
       glaa112 LIKE glaa_t.glaa112, #期末結轉單別
       glaa113 LIKE glaa_t.glaa113, #年底結轉單別
       glaa120 LIKE glaa_t.glaa120, #成本計算類型
       glaa121 LIKE glaa_t.glaa121, #子模組啟用分錄底稿
       glaa122 LIKE glaa_t.glaa122, #總帳可維護資金異動明細
       glaa027 LIKE glaa_t.glaa027, #單據據點編號
       glaa130 LIKE glaa_t.glaa130, #合併帳套否
       glaa131 LIKE glaa_t.glaa131, #分層合併
       glaa132 LIKE glaa_t.glaa132, #平均匯率計算方式
       glaa133 LIKE glaa_t.glaa133, #非T100公司匯入餘額類型
       glaa134 LIKE glaa_t.glaa134, #合併科目轉換依據異動碼設定值
       glaa135 LIKE glaa_t.glaa135, #現流表間接法群組參照表號
       glaa136 LIKE glaa_t.glaa136, #應收帳款核銷限定己立帳傳票
       glaa137 LIKE glaa_t.glaa137, #應付帳款核銷限定已立帳傳票
       glaa138 LIKE glaa_t.glaa138, #合併報表編制期別
       glaa139 LIKE glaa_t.glaa139, #遞延收入(負債)管理產生否
       glaa140 LIKE glaa_t.glaa140, #無原出貨單的遞延負債減項者,是否仍立遞延收入管理?
       glaa123 LIKE glaa_t.glaa123, #應收帳款核銷可維護資金異動明細
       glaa124 LIKE glaa_t.glaa124, #應付帳款核銷可維護資金異動明細
       glaa028 LIKE glaa_t.glaa028  #匯率來源
       END RECORD
#161128-00061#3-----modify--end----------


#150210-00011(1)--20150330--add--
DEFINE g_glav002        LIKE glav_t.glav002
DEFINE g_glav005        LIKE glav_t.glav005
DEFINE g_sdate_s        LIKE glav_t.glav004
DEFINE g_sdate_e        LIKE glav_t.glav004
DEFINE g_glav006        LIKE glav_t.glav006
DEFINE g_glav007        LIKE glav_t.glav007
DEFINE g_pdate_s        LIKE glav_t.glav004
DEFINE g_pdate_e        LIKE glav_t.glav004
DEFINE g_wdate_s        LIKE glav_t.glav004
DEFINE g_wdate_e        LIKE glav_t.glav004
#150210-00011(1)--20150330--add--
DEFINE g_sql_ctrl       STRING   #151231-00010#9 add
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axrp133.main" >}
MAIN
   #add-point:main段define (客製用) name="main.define_customerization"
   
   #end add-point 
   DEFINE ls_js    STRING
   DEFINE lc_param type_parameter  
   #add-point:main段define name="main.define"
   DEFINE l_success         LIKE type_t.num5   #20150422 add lujh
   #end add-point 
  
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("axr","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   #20150422--add--str--lujh
   CALL axrp133_def()   
   CALL s_fin_create_account_center_tmp()
   CALL s_voucher_cre_ar_tmp_table() RETURNING l_success    #2014/12/4
   CALL s_axrt300_create_tmp()
   CALL s_axrp133_create_success_tmp() RETURNING l_success
   #20150422--add--end--lujh
   #151125-00006#1---add---s
   CALL s_pre_voucher_cre_tmp_table() RETURNING l_success 
   CALL s_fin_continue_no_tmp() 
   #151125-00006#1---add---e
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL axrp133_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axrp133 WITH FORM cl_ap_formpath("axr",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL axrp133_init()
 
      #進入選單 Menu (="N")
      CALL axrp133_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_axrp133
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="axrp133.init" >}
#+ 初始化作業
PRIVATE FUNCTION axrp133_init()
 
   #add-point:init段define (客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:ui_dialog段define name="init.define"
   DEFINE l_success         LIKE type_t.num5
   #end add-point
 
   LET g_error_show = 1
   LET gwin_curr2 = ui.Window.getCurrent()
   LET gfrm_curr2 = gwin_curr2.getForm()
   CALL cl_schedule_import_4fd()
   CALL cl_set_combo_scc("gzpa003","75")
   IF cl_get_para(g_enterprise,"","E-SYS-0005") = "N" THEN
       CALL cl_set_comp_visible("scheduling_page,history_page",FALSE)
   END IF 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc_part('xmdk000','2077','1,2,3,6')
   #20150422--mark--str--lujh
   #CALL s_fin_create_account_center_tmp()
   #CALL s_voucher_cre_ar_tmp_table() RETURNING l_success    #2014/12/4
   #CALL s_axrt300_create_tmp()
   #20150422--mark--end--lujh
   CALL cl_set_combo_scc('b_comb1','9951')    #151012-00014#1 add lujh
   #151231-00010#9--add--str--
   LET g_sql_ctrl = NULL
   CALL s_control_get_customer_sql('2',g_site,g_user,g_dept,'') RETURNING g_sub_success,g_sql_ctrl
   #151231-00010#9--add--end
   CALL cl_set_combo_scc("xmdk042","2085")   #160905-00031#1 Add
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axrp133.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axrp133_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_success         LIKE type_t.chr1
   DEFINE l_s               LIKE type_t.num5
   DEFINE l_ooef004         LIKE ooef_t.ooef004
   DEFINE l_ooef019         LIKE ooef_t.ooef019
   #150210-00011(1)--20150330--add--
   DEFINE  l_flag1          LIKE type_t.chr1       
   DEFINE  l_errno          LIKE type_t.chr100
   #150210-00011(1)--20150330--add--
   DEFINE l_where           STRING                #160325-00023#1
   DEFINE  ls_scc           STRINg   #160715-00017#1 Add
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   INITIALIZE g_master.* TO NULL
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.xrcasite,g_master.xrcald,g_master.b_style,g_master.xrcadocno,g_master.xrca007, 
             g_master.xrcadocdt,g_master.b_check1,g_master.b_check4,g_master.b_check2,g_master.b_check5, 
             g_master.b_check3,g_master.b_check6,g_master.b_comb1,g_master.xmdk042,g_master.xmdk032, 
             g_master.b_comb2 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               CALL axrp133_def()
               #160905-00031#1 Add  ---(S)---
               IF g_master.xmdk042 = '1' THEN
                  CALL cl_set_comp_visible('xmdk032',FALSE)
               ELSE
                  CALL cl_set_comp_visible('xmdk032',TRUE)
               END IF
               #160905-00031#1 Add  ---(E)---
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcasite
            
            #add-point:AFTER FIELD xrcasite name="input.a.xrcasite"
            IF NOT cl_null(g_master.xrcasite) THEN
               #161021-00050#2-add(s)
               CALL s_fin_account_center_with_ld_chk(g_master.xrcasite,g_master.xrcald,g_user,'3','N','',g_today) RETURNING l_success,g_errno
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_master.xrcasite
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.xrcasite = ''
                     LET g_master.xrcald = ''
                     LET g_master.xrcasite_desc = ''
                     LET g_master.xrcald_desc = ''
                     DISPLAY BY NAME g_master.xrcasite,g_master.xrcasite_desc
                     DISPLAY BY NAME g_master.xrcald,g_master.xrcald_desc
                     NEXT FIELD CURRENT
                  END IF
               #161021-00050#2-add(e)  
               CALL s_axrt300_site_geared_ld(g_master.xrcasite,g_master.xrcald,g_user,g_today,'site')
                  RETURNING l_success,g_master.xrcasite,g_master.xrcasite_desc,g_master.xrcald,g_master.xrcald_desc
               DISPLAY BY NAME g_master.xrcasite,g_master.xrcasite_desc
               DISPLAY BY NAME g_master.xrcald,g_master.xrcald_desc
               IF NOT l_success THEN NEXT FIELD CURRENT END IF
               CALL s_axrt300_date_chk(g_master.xrcasite,g_master.xrcadocdt) RETURNING l_success
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "axr-00299"
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err() 
                  NEXT FIELD CURRENT
               END IF
            ELSE
               LET g_master.xrcasite_desc = ''
            END IF
           #161128-00061#3-----modify--begin----------
           #SELECT * INTO g_glaa.* 
            SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
                   glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
                   glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
                   glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
                   glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
                   glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
           #161128-00061#3-----modify--end----------
            FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_master.xrcald
            DISPLAY BY NAME g_master.xrcasite,g_master.xrcasite_desc
            DISPLAY BY NAME g_master.xrcald,g_master.xrcald_desc
            #161111-00049#6 Add  ---(S)---
            CALL s_control_get_customer_sql_pmab('4',g_site,g_user,g_dept,'',g_glaa.glaacomp)
               RETURNING g_sub_success,g_sql_ctrl
            #161111-00049#6 Add  ---(E)---

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcasite
            #add-point:BEFORE FIELD xrcasite name="input.b.xrcasite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcasite
            #add-point:ON CHANGE xrcasite name="input.g.xrcasite"
            IF 1=2 THEN
               DISPLAY 'test'
            END IF
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcald
            
            #add-point:AFTER FIELD xrcald name="input.a.xrcald"
            IF NOT cl_null(g_master.xrcald) THEN 
               CALL s_axrt300_site_geared_ld(g_master.xrcasite,g_master.xrcald,g_user,g_today,'ld')
                  RETURNING l_success,g_master.xrcasite,g_master.xrcasite_desc,g_master.xrcald,g_master.xrcald_desc
               DISPLAY BY NAME g_master.xrcasite,g_master.xrcasite_desc
               DISPLAY BY NAME g_master.xrcald,g_master.xrcald_desc
               IF NOT l_success THEN
                  #161128-00061#3-----modify--begin----------
                  #SELECT * INTO g_glaa.* 
                   SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
                          glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
                          glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
                          glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
                          glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
                          glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
                  #161128-00061#3-----modify--end---------- 
                  FROM FROM glaa_t WHERE glaaent = g_enterprise AND glaald  = g_master.xrcald
                  NEXT FIELD CURRENT
               END IF
            ELSE
               LET g_master.xrcald_desc = ''
            END IF
           #161128-00061#3-----modify--begin----------
           #SELECT * INTO g_glaa.* 
            SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
                   glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
                   glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
                   glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
                   glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
                   glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
           #161128-00061#3-----modify--end----------
            FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_master.xrcald
            DISPLAY BY NAME g_master.xrcasite,g_master.xrcasite_desc
            DISPLAY BY NAME g_master.xrcald,g_master.xrcald_desc
            #161111-00049#6 Add  ---(S)---
            CALL s_control_get_customer_sql_pmab('4',g_site,g_user,g_dept,'',g_glaa.glaacomp)
               RETURNING g_sub_success,g_sql_ctrl
            #161111-00049#6 Add  ---(E)---

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcald
            #add-point:BEFORE FIELD xrcald name="input.b.xrcald"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcald
            #add-point:ON CHANGE xrcald name="input.g.xrcald"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_style
            #add-point:BEFORE FIELD b_style name="input.b.b_style"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_style
            
            #add-point:AFTER FIELD b_style name="input.a.b_style"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE b_style
            #add-point:ON CHANGE b_style name="input.g.b_style"
            IF NOT cl_null(g_master.b_style) THEN
               IF g_master.b_style = 'axrt340' THEN
                  LET g_master.b_check1 = 'N'
                  LET g_master.b_check2 = 'N'
                  LET g_master.b_check3 = 'N'
                  LET g_master.b_check4 = 'N'
                  LET g_master.b_check5 = 'N'
                  LET g_master.b_check6 = 'N'
                  CALL cl_set_comp_entry('b_check1,b_check2,b_check3,b_check4,b_check5,b_check6',FALSE)
               ELSE
                  LET g_master.b_check1 = 'Y'
                  CALL cl_set_comp_entry('b_check1,b_check2,b_check3,b_check4,b_check5,b_check6',TRUE)
               END IF
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcadocno
            #add-point:BEFORE FIELD xrcadocno name="input.b.xrcadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcadocno
            
            #add-point:AFTER FIELD xrcadocno name="input.a.xrcadocno"
            IF NOT cl_null(g_master.xrcadocno) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_glaa.glaa024
               LET g_chkparam.arg2 = g_master.xrcadocno
               IF NOT s_aooi200_fin_chk_slip(g_glaa.glaald,g_glaa.glaa024,g_master.xrcadocno,g_master.b_style) THEN
                  LET g_master.xrcadocno = ''
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcadocno
            #add-point:ON CHANGE xrcadocno name="input.g.xrcadocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca007
            #add-point:BEFORE FIELD xrca007 name="input.b.xrca007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca007
            
            #add-point:AFTER FIELD xrca007 name="input.a.xrca007"
            IF NOT cl_null(g_master.xrca007) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_master.xrca007
               #160318-00025#42  2016/04/25  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "aoo-00200:sub-01302|axri012|",cl_get_progname("axri012",g_lang,"2"),"|:EXEPROGaxri012"
               #160318-00025#42  2016/04/25  by pengxin  add(E)
               IF NOT cl_chk_exist("v_oocq002_3111") THEN
                  LET g_master.xrca007 = ''
                  NEXT FIELD CURRENT
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca007
            #add-point:ON CHANGE xrca007 name="input.g.xrca007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcadocdt
            #add-point:BEFORE FIELD xrcadocdt name="input.b.xrcadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcadocdt
            
            #add-point:AFTER FIELD xrcadocdt name="input.a.xrcadocdt"
            IF NOT cl_null(g_master.xrcadocdt) THEN
               CALL s_axrt300_date_chk(g_master.xrcasite,g_master.xrcadocdt) RETURNING l_success
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "axr-00299"
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err() 
                  NEXT FIELD CURRENT
               END IF
               #150210-00011(1)--20150330--add--
               CALL s_get_accdate(g_glaa.glaa003,g_master.xrcadocdt,'','') 
               RETURNING l_flag1,l_errno,g_glav002,g_glav005,g_sdate_s,g_sdate_e,
                         g_glav006,g_pdate_s,g_pdate_e,g_glav007,g_wdate_s,g_wdate_e
               #150210-00011(1)--20150330--add--
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcadocdt
            #add-point:ON CHANGE xrcadocdt name="input.g.xrcadocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_check1
            #add-point:BEFORE FIELD b_check1 name="input.b.b_check1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_check1
            
            #add-point:AFTER FIELD b_check1 name="input.a.b_check1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE b_check1
            #add-point:ON CHANGE b_check1 name="input.g.b_check1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_check4
            #add-point:BEFORE FIELD b_check4 name="input.b.b_check4"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_check4
            
            #add-point:AFTER FIELD b_check4 name="input.a.b_check4"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE b_check4
            #add-point:ON CHANGE b_check4 name="input.g.b_check4"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_check2
            #add-point:BEFORE FIELD b_check2 name="input.b.b_check2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_check2
            
            #add-point:AFTER FIELD b_check2 name="input.a.b_check2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE b_check2
            #add-point:ON CHANGE b_check2 name="input.g.b_check2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_check5
            #add-point:BEFORE FIELD b_check5 name="input.b.b_check5"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_check5
            
            #add-point:AFTER FIELD b_check5 name="input.a.b_check5"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE b_check5
            #add-point:ON CHANGE b_check5 name="input.g.b_check5"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_check3
            #add-point:BEFORE FIELD b_check3 name="input.b.b_check3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_check3
            
            #add-point:AFTER FIELD b_check3 name="input.a.b_check3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE b_check3
            #add-point:ON CHANGE b_check3 name="input.g.b_check3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_check6
            #add-point:BEFORE FIELD b_check6 name="input.b.b_check6"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_check6
            
            #add-point:AFTER FIELD b_check6 name="input.a.b_check6"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE b_check6
            #add-point:ON CHANGE b_check6 name="input.g.b_check6"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_comb1
            #add-point:BEFORE FIELD b_comb1 name="input.b.b_comb1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_comb1
            
            #add-point:AFTER FIELD b_comb1 name="input.a.b_comb1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE b_comb1
            #add-point:ON CHANGE b_comb1 name="input.g.b_comb1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdk042
            #add-point:BEFORE FIELD xmdk042 name="input.b.xmdk042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdk042
            
            #add-point:AFTER FIELD xmdk042 name="input.a.xmdk042"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdk042
            #add-point:ON CHANGE xmdk042 name="input.g.xmdk042"
            #160905-00031#1 Add  ---(S)---
            IF NOT cl_null(g_master.xmdk042) THEN
               IF g_master.xmdk042 = '1' THEN
                  CALL cl_set_comp_visible('xmdk032',FALSE)
               ELSE
                  CALL cl_set_comp_visible('xmdk032',TRUE)
               END IF
            END IF
            #160905-00031#1 Add  ---(E)---
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdk032
            #add-point:BEFORE FIELD xmdk032 name="input.b.xmdk032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdk032
            
            #add-point:AFTER FIELD xmdk032 name="input.a.xmdk032"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdk032
            #add-point:ON CHANGE xmdk032 name="input.g.xmdk032"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_comb2
            #add-point:BEFORE FIELD b_comb2 name="input.b.b_comb2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_comb2
            
            #add-point:AFTER FIELD b_comb2 name="input.a.b_comb2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE b_comb2
            #add-point:ON CHANGE b_comb2 name="input.g.b_comb2"
            IF NOT cl_null(g_master.b_comb2) THEN  #2015/01/23
               IF g_master.b_comb2 = '1' THEN
                  CALL cl_set_comp_required('xrcadocdt',FALSE)
               ELSE
                  CALL cl_set_comp_required('xrcadocdt',TRUE)
               END IF
            END IF
            #END add-point 
 
 
 
                     #Ctrlp:input.c.xrcasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcasite
            #add-point:ON ACTION controlp INFIELD xrcasite name="input.c.xrcasite"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.xrcasite             #給予default值
            #LET g_qryparam.where = " ooef201 = 'Y' " #160811-00009#4 

            #給予arg

            #CALL q_ooef001()                                        #呼叫開窗   #161021-00050#2 mark
            LET g_qryparam.where = " ooefstus = 'Y' "                           #161021-00050#2 add
            CALL q_ooef001_46()                                                 #161021-00050#2 add
            LET g_master.xrcasite = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL s_axrt300_xrca_ref('xrcasite',g_master.xrcasite,'','') RETURNING l_success,g_master.xrcasite_desc
            IF NOT cl_null(g_master.xrcasite) THEN
               CALL s_axrt300_site_geared_ld(g_master.xrcasite,g_master.xrcald,g_user,g_today,'site')
                  RETURNING l_success,g_master.xrcasite,g_master.xrcasite_desc,g_master.xrcald,g_master.xrcald_desc
               #161128-00061#3-----modify--begin----------
               #SELECT * INTO g_glaa.* 
                SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
                       glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
                       glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
                       glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
                       glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
                       glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
               #161128-00061#3-----modify--end----------
               FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_master.xrcald
            END IF
            DISPLAY BY NAME g_master.xrcasite,g_master.xrcasite_desc
            DISPLAY BY NAME g_master.xrcald,g_master.xrcald_desc
            DISPLAY BY NAME g_master.xrcasite,g_master.xrcasite_desc
            NEXT FIELD xrcasite

            #END add-point
 
 
         #Ctrlp:input.c.xrcald
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcald
            #add-point:ON ACTION controlp INFIELD xrcald name="input.c.xrcald"
            CALL s_fin_create_account_center_tmp()   
            #取得帳務組織下所屬成員
            CALL s_fin_account_center_sons_query('3',g_master.xrcasite,g_today,'1')
            #取得帳務組織下所屬成員之帳別   
            CALL s_fin_account_center_comp_str() RETURNING ls_wc
            #將取回的字串轉換為SQL條件
            CALL axrp133_get_ooef001_wc(ls_wc) RETURNING ls_wc  
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.xrcald             #給予default值
#160811-00009#4 mod s---            
#            IF NOT cl_null(ls_wc) AND ls_wc <> '(\'\')' THEN
#               LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN ",ls_wc,""
#            ELSE
#               LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y')"
#            END IF
              LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN ",ls_wc,""
#160811-00009#4 mod e---
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            CALL  q_authorised_ld()                                  #呼叫開窗
            LET g_master.xrcald = g_qryparam.return1       #將開窗取得的值回傳到變數
            IF NOT cl_null(g_master.xrcald) THEN
               CALL s_axrt300_site_geared_ld(g_master.xrcasite,g_master.xrcald,g_user,g_today,'ld')
                  RETURNING l_success,g_master.xrcasite,g_master.xrcasite_desc,g_master.xrcald,g_master.xrcald_desc
               #161128-00061#3-----modify--begin----------
               #SELECT * INTO g_glaa.* 
                SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
                       glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
                       glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
                       glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
                       glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
                       glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
               #161128-00061#3-----modify--end----------
               FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_master.xrcald
            END IF
            DISPLAY BY NAME g_master.xrcald,g_master.xrcald_desc
            NEXT FIELD xrcald                              #返回原欄位  

            #END add-point
 
 
         #Ctrlp:input.c.b_style
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_style
            #add-point:ON ACTION controlp INFIELD b_style name="input.c.b_style"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrcadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcadocno
            #add-point:ON ACTION controlp INFIELD xrcadocno name="input.c.xrcadocno"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.xrcadocno             #給予default值

            #給予arg
            SELECT ooef004 INTO l_ooef004 from ooef_t where ooefent = g_enterprise AND ooef001 = g_glaa.glaacomp
            LET g_qryparam.arg1 = g_glaa.glaa024
            LET g_qryparam.arg2 = g_master.b_style

            CALL q_ooba002_1()                                #呼叫開窗


            LET g_master.xrcadocno = g_qryparam.return1              

            DISPLAY g_master.xrcadocno TO xrcadocno              #

            NEXT FIELD xrcadocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xrca007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca007
            #add-point:ON ACTION controlp INFIELD xrca007 name="input.c.xrca007"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.xrca007             #給予default值
            LET g_qryparam.default2 = "" #g_master.oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "3111" #
            LET g_qryparam.where= " oocq002 IN (SELECT glab002 FROM glab_t WHERE glab001 = '13' AND glabld = '",g_master.xrcald,"' AND glabent = ",g_enterprise,")" #161111-00049#6
            
            CALL q_oocq002()                                #呼叫開窗

            LET g_master.xrca007 = g_qryparam.return1              
            #LET g_master.oocq002 = g_qryparam.return2 
            DISPLAY g_master.xrca007 TO xrca007              #
            #DISPLAY g_master.oocq002 TO oocq002 #應用分類碼
            NEXT FIELD xrca007                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xrcadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcadocdt
            #add-point:ON ACTION controlp INFIELD xrcadocdt name="input.c.xrcadocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.b_check1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_check1
            #add-point:ON ACTION controlp INFIELD b_check1 name="input.c.b_check1"
            
            #END add-point
 
 
         #Ctrlp:input.c.b_check4
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_check4
            #add-point:ON ACTION controlp INFIELD b_check4 name="input.c.b_check4"
            
            #END add-point
 
 
         #Ctrlp:input.c.b_check2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_check2
            #add-point:ON ACTION controlp INFIELD b_check2 name="input.c.b_check2"
            
            #END add-point
 
 
         #Ctrlp:input.c.b_check5
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_check5
            #add-point:ON ACTION controlp INFIELD b_check5 name="input.c.b_check5"
            
            #END add-point
 
 
         #Ctrlp:input.c.b_check3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_check3
            #add-point:ON ACTION controlp INFIELD b_check3 name="input.c.b_check3"
            
            #END add-point
 
 
         #Ctrlp:input.c.b_check6
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_check6
            #add-point:ON ACTION controlp INFIELD b_check6 name="input.c.b_check6"
            
            #END add-point
 
 
         #Ctrlp:input.c.b_comb1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_comb1
            #add-point:ON ACTION controlp INFIELD b_comb1 name="input.c.b_comb1"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmdk042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdk042
            #add-point:ON ACTION controlp INFIELD xmdk042 name="input.c.xmdk042"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmdk032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdk032
            #add-point:ON ACTION controlp INFIELD xmdk032 name="input.c.xmdk032"
            
            #END add-point
 
 
         #Ctrlp:input.c.b_comb2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_comb2
            #add-point:ON ACTION controlp INFIELD b_comb2 name="input.c.b_comb2"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON xmdk007,xmdk001,xmdk000,xmdkdocno,xmdk003,xmdk004
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.xmdk007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdk007
            #add-point:ON ACTION controlp INFIELD xmdk007 name="construct.c.xmdk007"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #151231-00010#9--add--str--
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_sql_ctrl
            END IF
            #151231-00010#9--add--end
             #160731-00372#1   2016/08/15  By 07900 --s--
            IF cl_null(g_qryparam.where) THEN
               LET g_qryparam.where =" (pmaa002 ='2' OR pmaa002='3')"
            ELSE 
               LET g_qryparam.where =" (pmaa002 ='2' OR pmaa002='3') AND ",g_qryparam.where            
            END IF 
            #160731-00372#1   2016/08/15  By 07900 --e--
            # CALL q_pmaa001()   #160913-00017#9  mark                  #呼叫開窗
            #160913-00017#9--ADD(S)--
            LET g_qryparam.arg1="('2','3')"
            CALL q_pmaa001_1()
            #160913-00017#9--ADD(E)-
            DISPLAY g_qryparam.return1 TO xmdk007  #顯示到畫面上
            NEXT FIELD xmdk007                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdk007
            #add-point:BEFORE FIELD xmdk007 name="construct.b.xmdk007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdk007
            
            #add-point:AFTER FIELD xmdk007 name="construct.a.xmdk007"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdk001
            #add-point:BEFORE FIELD xmdk001 name="construct.b.xmdk001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdk001
            
            #add-point:AFTER FIELD xmdk001 name="construct.a.xmdk001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdk001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdk001
            #add-point:ON ACTION controlp INFIELD xmdk001 name="construct.c.xmdk001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdk000
            #add-point:BEFORE FIELD xmdk000 name="construct.b.xmdk000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdk000
            
            #add-point:AFTER FIELD xmdk000 name="construct.a.xmdk000"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdk000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdk000
            #add-point:ON ACTION controlp INFIELD xmdk000 name="construct.c.xmdk000"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xmdkdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdkdocno
            #add-point:ON ACTION controlp INFIELD xmdkdocno name="construct.c.xmdkdocno"
            #取得aooi210所設置之前置單別的合理性where 條件 
            CALL s_aooi210_get_check_sql(g_master.xrcasite,'',g_master.xrcadocno,'4','','xmdkdocno') RETURNING g_sub_success,l_where   #160325-00023#1
            IF NOT cl_null(g_master.xrcadocdt) THEN   #160905-00031#1 Add
               CALL s_fin_account_center_sons_query('3',g_master.xrcasite,g_master.xrcadocdt,'1')
            #160905-00031#1 Add  ---(S)---
            ELSE
               CALL s_fin_account_center_sons_query('3',g_master.xrcasite,g_today,'1')
            END IF
            #160905-00031#1 Add  ---(E)---
            CALL s_fin_account_center_sons_str()RETURNING ls_wc
            IF cl_null(ls_wc) THEN LET ls_wc = g_master.xrcasite END IF
            CALL axrp133_get_ooef001_wc(ls_wc)RETURNING ls_wc

            #14/12/23
            CALL s_axrt300_sel_ld(g_master.xrcald) RETURNING l_success,l_s
           #160715-00017#1 Add  ---(S)---
            CALL s_axrp133_get_scc('xmdk000','2077') RETURNING ls_scc
            IF g_master.b_style = 'axrt300' THEN
               LET ls_scc = ls_scc," AND xmdk000 IN ('1','2','3','4')"
            ELSE
               LET ls_scc = ls_scc," AND xmdk000 IN ('5','6')"
            END IF
           #160715-00017#1 Add  ---(E)---

            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1  = l_s
            LET g_qryparam.arg2  = ls_wc
            #150210-00011(1)--20150330--add--
            IF NOT cl_null(g_master.xrcadocdt) THEN 
              #LET g_qryparam.WHERE = " xmdk001 BETWEEN '",g_pdate_s,"' AND '",g_pdate_e,"'" #150203-00010#6 Mark
               LET g_qryparam.WHERE = " xmdk001 <= '",g_master.xrcadocdt,"'"                 #150203-00010#6 Add
            #160905-00031#1 Add  ---(S)---
            ELSE
               LET g_qryparam.WHERE = " 1=1"
            #160905-00031#1 Add  ---(E)---
            END IF               
            #150210-00011(1)--20150330--add--
            #151231-00010#9--add--str--
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where," AND EXISTS (SELECT 1 FROM pmaa_t ",
                                                       "              WHERE pmaaent = ",g_enterprise,
                                                       "                AND ",g_sql_ctrl,
                                                       "                AND pmaa001 = xmdk007 )"
            END IF
            #151231-00010#9--add--end
            LET g_qryparam.where = g_qryparam.where," AND ",l_where,       #160325-00023#1              
                                                    " AND ",ls_scc,        #160715-00017#1 Add 
                                                    " AND xmdk042 = '",g_master.xmdk042,"'"   #160905-00031#1 Add
            CALL q_xmdl_10()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdkdocno  #顯示到畫面上
            NEXT FIELD xmdkdocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdkdocno
            #add-point:BEFORE FIELD xmdkdocno name="construct.b.xmdkdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdkdocno
            
            #add-point:AFTER FIELD xmdkdocno name="construct.a.xmdkdocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdk003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdk003
            #add-point:ON ACTION controlp INFIELD xmdk003 name="construct.c.xmdk003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdk003  #顯示到畫面上
            NEXT FIELD xmdk003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdk003
            #add-point:BEFORE FIELD xmdk003 name="construct.b.xmdk003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdk003
            
            #add-point:AFTER FIELD xmdk003 name="construct.a.xmdk003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdk004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdk004
            #add-point:ON ACTION controlp INFIELD xmdk004 name="construct.c.xmdk004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001_13()                    #呼叫開窗  #161026-00013#1 mark
            CALL q_ooeg001_4()                                #161026-00013#1 add    
            DISPLAY g_qryparam.return1 TO xmdk004  #顯示到畫面上
            NEXT FIELD xmdk004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdk004
            #add-point:BEFORE FIELD xmdk004 name="construct.b.xmdk004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdk004
            
            #add-point:AFTER FIELD xmdk004 name="construct.a.xmdk004"
            
            #END add-point
            
 
 
 
            
            #add-point:其他管控 name="cs.other"
            
            #end add-point
            
         END CONSTRUCT
 
 
 
      
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
 
         SUBDIALOG lib_cl_schedule.cl_schedule_setting
         SUBDIALOG lib_cl_schedule.cl_schedule_setting_exec_call
         SUBDIALOG lib_cl_schedule.cl_schedule_select_show_history
         SUBDIALOG lib_cl_schedule.cl_schedule_show_history
 
         BEFORE DIALOG
            LET l_dialog = ui.DIALOG.getCurrent()
            CALL axrp133_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
           #DISPLAY g_master.wc TO xmdkdocno  #151102-00007#1 mark
            #end add-point
 
         ON ACTION batch_execute
            LET g_action_choice = "batch_execute"
            ACCEPT DIALOG
 
         #add-point:ui_dialog段before_qbeclear name="ui_dialog.before_qbeclear"
         
         #end add-point
 
         ON ACTION qbeclear         
            CLEAR FORM
            INITIALIZE g_master.* TO NULL   #畫面變數清空
            INITIALIZE lc_param.* TO NULL   #傳遞參數變數清空
            #add-point:ui_dialog段qbeclear name="ui_dialog.qbeclear"
            INITIALIZE g_master.* TO NULL
            CALL axrp133_def()
            #160905-00031#1 Add  ---(S)---
            IF g_master.xmdk042 = '1' THEN
               CALL cl_set_comp_visible('xmdk032',FALSE)
            ELSE
               CALL cl_set_comp_visible('xmdk032',TRUE)
            END IF
            #160905-00031#1 Add  ---(E)---
            #end add-point
 
         ON ACTION history_fill
            CALL cl_schedule_history_fill()
 
         ON ACTION close
            LET INT_FLAG = TRUE
            EXIT DIALOG
         
         ON ACTION exit
            LET INT_FLAG = TRUE
            EXIT DIALOG
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         
         #end add-point
 
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM   
         INITIALIZE g_master.* TO NULL
         LET g_wc  = ' 1=2'
         LET g_action_choice = ""
         CALL axrp133_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      #160905-00031#1 Add  ---(S)---
      IF NOT INT_FLAG  THEN
         IF cl_null(g_master.xrcald)    THEN CONTINUE WHILE END IF
         IF cl_null(g_master.xrcasite)  THEN CONTINUE WHILE END IF
         IF cl_null(g_master.xrcadocno) THEN CONTINUE WHILE END IF
         IF cl_null(g_master.xmdk032) AND g_master.xmdk042 = '2' THEN CONTINUE WHILE END IF
      END IF
      #160905-00031#1 Add  ---(E)---
      #end add-point
 
      LET ls_js = util.JSON.stringify(lc_param)  #r類使用g_master/p類使用lc_param
 
      IF INT_FLAG THEN
         LET INT_FLAG = FALSE
         EXIT WHILE
      ELSE
         IF g_chk_jobid THEN 
            LET g_jobid = g_schedule.gzpa001
         ELSE 
            LET g_jobid = cl_schedule_get_jobid(g_prog)
         END IF 
 
         #依照指定模式執行報表列印
         CASE 
            WHEN g_schedule.gzpa003 = "0"
                 CALL axrp133_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = axrp133_transfer_argv(ls_js)
                 CALL cl_cmdrun(ls_js)
 
            WHEN g_schedule.gzpa003 = "2"
                 CALL cl_schedule_update_data(g_jobid,ls_js)
 
            WHEN g_schedule.gzpa003 = "3"
                 CALL cl_schedule_update_data(g_jobid,ls_js)
         END CASE  
 
         IF g_schedule.gzpa003 = "2" OR g_schedule.gzpa003 = "3" THEN 
            CALL cl_ask_confirm3("std-00014","") #設定完成
         END IF    
         LET g_schedule.gzpa003 = "0" #預設一開始 立即於前景執行
 
         #add-point:ui_dialog段after schedule name="process.after_schedule"
         
         #end add-point
 
         #欄位初始資訊 
         CALL cl_schedule_init_info("all",g_schedule.gzpa003) 
         LET gi_hiden_asign = FALSE 
         LET gi_hiden_exec = FALSE 
         LET gi_hiden_spec = FALSE 
         LET gi_hiden_exec_end = FALSE 
         CALL cl_schedule_hidden()
      END IF
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="axrp133.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION axrp133_transfer_argv(ls_js)
 
   #add-point:transfer_agrv段define (客製用) name="transfer_agrv.define_customerization"
   
   #end add-point
   DEFINE ls_js       STRING
   DEFINE la_cmdrun   RECORD
             prog       STRING,
             actionid   STRING,
             background LIKE type_t.chr1,
             param      DYNAMIC ARRAY OF STRING
                  END RECORD
   DEFINE la_param    type_parameter
   #add-point:transfer_agrv段define name="transfer_agrv.define"
   
   #end add-point
 
   LET la_cmdrun.prog = g_prog
   LET la_cmdrun.background = "Y"
   LET la_cmdrun.param[1] = ls_js
 
   #add-point:transfer.argv段程式內容 name="transfer.argv.define"
   
   #end add-point
 
   RETURN util.JSON.stringify( la_cmdrun )
END FUNCTION
 
{</section>}
 
{<section id="axrp133.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION axrp133_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_gzzd005         LIKE gzzd_t.gzzd005
   #20150422--add--str--lujh
   DEFINE l_success         LIKE type_t.num5
   DEFINE l_tot_success     LIKE type_t.num5
   DEFINE l_start_no        LIKE xrca_t.xrcadocno
   DEFINE l_end_no          LIKE xrca_t.xrcadocno
   #20150422--add--end--lujh
   DEFINE l_where       STRING     #160325-00023#1
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   #執行步驟:
   #STEP1.取得符合條件的出貨單據
   #STEP2.產生應收單據
   LET li_count = 2
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      CALL cl_progress_bar_no_window(li_count)
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE axrp133_process_cs CURSOR FROM ls_sql
#  FOREACH axrp133_process_cs INTO
   #add-point:process段process name="process.process"
   
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"

      #錯誤訊息匯總初始化
      CALL cl_err_collect_init()
      LET g_success    = 'Y'
      LET g_totsuccess = 'Y'

      SELECT gzzd005 INTO l_gzzd005 FROM gzzd_t
       WHERE gzzd001 = 'axrp133' AND gzzd002 = g_lang AND gzzdstus = 'Y' AND gzzd003 = 'step1'
      CALL cl_progress_no_window_ing(l_gzzd005)
      #CALL axrp133_get_data()  #20150422 mark lujh
      
      #20150422--add--str--lujh
      CALL s_axrp133_create_tmp() RETURNING l_success
      
      #160325-00023#1 ---s---
      CALL s_aooi210_get_check_sql(g_master.xrcasite,'',g_master.xrcadocno,'4','','xmdkdocno') RETURNING g_sub_success,l_where   
      LET g_master.wc = g_master.wc CLIPPED," AND ",l_where 
      #160325-00023#1 ---e---

      #160905-00031#1 Add ---(S)---
       LET g_master.wc = g_master.wc CLIPPED," AND xmdk042 = '",g_master.xmdk042,"'" 
      #160905-00031#1 Add ---(E)---

      CALL s_axrp133_get_data(g_master.wc,g_master.xrcald,g_master.xrcasite,g_master.xrcadocdt,g_master.b_style,
                              g_master.b_comb1,g_master.b_comb2)
      RETURNING g_xmdk_d
      #20150422--add--end--lujh

      IF g_success = 'N' THEN
         CALL cl_err_collect_show()
         DROP TABLE axrp133_tmp01          #160727-00019#33  mod axrp133_xmdk_tmp --> axrp133_tmp01
         #清空進度條
         DISPLAY '' ,0 TO stagenow,stagecomplete
         DROP TABLE axrp131_tmp01                  #160727-00019#5   2016/07/28  By 08734    将axrp131_xmdk_tmp ——> axrp131_tmp01
         RETURN
         RETURN
      END IF

      CALL s_axrt300_create_tmp()

      CALL s_transaction_begin()

      SELECT gzzd005 INTO l_gzzd005 FROM gzzd_t
       WHERE gzzd001 = 'axrp133' AND gzzd002 = g_lang AND gzzdstus = 'Y' AND gzzd003 = 'step2'
      CALL cl_progress_no_window_ing(l_gzzd005)
      #CALL axrp133_get_ar()  #20150422 mark lujh
      
      #160905-00031#1 Add  ---(S)---
      IF g_master.xmdk042 = '2' THEN
         LET g_master.xrcadocdt = g_master.xmdk032
      END IF
      #160905-00031#1 Add  ---(E)---

      #20150422--add--str--lujh
      CALL s_axrp133_get_ar(g_master.xrcald,g_master.xrcadocno,g_master.xrcadocdt,g_master.b_style,
                            g_master.xrcasite,g_master.xrca007,g_master.b_comb1,g_master.b_comb2,
                            g_master.b_check1,g_master.b_check2,g_master.b_check3,
                            g_master.b_check4,g_master.b_check5,g_master.b_check6,g_xmdk_d,'')
      RETURNING l_tot_success,l_start_no,l_end_no
      
      IF l_tot_success AND NOT cl_null(l_start_no) THEN #全部資料都正確
         CALL cl_err_collect_show()
      ELSE
         CALL cl_err_collect_show()
      END IF
      #20150422--add--end--lujh

      DROP TABLE axrp133_tmp01             #160727-00019#33  mod axrp133_xmdk_tmp --> axrp133_tmp01

      IF g_success = 'N' THEN
         #清空進度條
         DISPLAY '' ,0 TO stagenow,stagecomplete
      END IF

      RETURN

      #end add-point
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
      #20150422--add--str--lujh
      #錯誤訊息匯總初始化
      CALL cl_err_collect_init()
      LET g_success    = 'Y'
      LET g_totsuccess = 'Y'

      CALL axrp133_get_data()

      IF g_success = 'N' THEN
         CALL cl_err_collect_show()
         DROP TABLE axrp133_tmp01               #160727-00019#33  mod axrp133_xmdk_tmp --> axrp133_tmp01                   
         #清空進度條
         DISPLAY '' ,0 TO stagenow,stagecomplete
         DROP TABLE axrp131_tmp01                 #160727-00019#5   2016/07/28  By 08734    将axrp131_xmdk_tmp ——> axrp131_tmp01
         RETURN
         RETURN
      END IF

      CALL s_axrt300_create_tmp()

      CALL s_transaction_begin()

      SELECT gzzd005 INTO l_gzzd005 FROM gzzd_t
       WHERE gzzd001 = 'axrp133' AND gzzd002 = g_lang AND gzzdstus = 'Y' AND gzzd003 = 'step2'
      CALL cl_progress_no_window_ing(l_gzzd005)
      CALL axrp133_get_ar()

      DROP TABLE axrp133_tmp01          #160727-00019#33  mod axrp133_xmdk_tmp --> axrp133_tmp01  

      IF g_success = 'N' THEN
         #清空進度條
         DISPLAY '' ,0 TO stagenow,stagecomplete
      END IF
          
      RETURN
      #20150422--add--end--lujh
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL axrp133_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="axrp133.get_buffer" >}
PRIVATE FUNCTION axrp133_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.xrcasite = p_dialog.getFieldBuffer('xrcasite')
   LET g_master.xrcald = p_dialog.getFieldBuffer('xrcald')
   LET g_master.b_style = p_dialog.getFieldBuffer('b_style')
   LET g_master.xrcadocno = p_dialog.getFieldBuffer('xrcadocno')
   LET g_master.xrca007 = p_dialog.getFieldBuffer('xrca007')
   LET g_master.xrcadocdt = p_dialog.getFieldBuffer('xrcadocdt')
   LET g_master.b_check1 = p_dialog.getFieldBuffer('b_check1')
   LET g_master.b_check4 = p_dialog.getFieldBuffer('b_check4')
   LET g_master.b_check2 = p_dialog.getFieldBuffer('b_check2')
   LET g_master.b_check5 = p_dialog.getFieldBuffer('b_check5')
   LET g_master.b_check3 = p_dialog.getFieldBuffer('b_check3')
   LET g_master.b_check6 = p_dialog.getFieldBuffer('b_check6')
   LET g_master.b_comb1 = p_dialog.getFieldBuffer('b_comb1')
   LET g_master.xmdk042 = p_dialog.getFieldBuffer('xmdk042')
   LET g_master.xmdk032 = p_dialog.getFieldBuffer('xmdk032')
   LET g_master.b_comb2 = p_dialog.getFieldBuffer('b_comb2')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axrp133.msgcentre_notify" >}
PRIVATE FUNCTION axrp133_msgcentre_notify()
 
   #add-point:process段define (客製用) name="msgcentre_notify.define_customerization"
   
   #end add-point
   DEFINE lc_state LIKE type_t.chr5
   #add-point:process段define name="msgcentre_notify.define"
   
   #end add-point
 
   INITIALIZE g_msgparam TO NULL
 
   #action-id與狀態填寫
   LET g_msgparam.state = "process"
 
   #add-point:msgcentre其他通知 name="msg_centre.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="axrp133.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 給帳務中心、帳套賦默認值
# Memo...........:
# Usage..........: CALL axrp133_def()
#                  RETURNING ---
# Input parameter: ---
# Return code....: ---
# Date & Author..: 2014/10/09 By zhangweib
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp133_def()
   DEFINE l_sql         STRING
   DEFINE l_xrcasite    LIKE xrca_t.xrcasite
   DEFINE l_xrcacomp    LIKE xrca_t.xrcacomp
   DEFINE l_success     LIKE type_t.chr1
   DEFINE l_cnt         LIKE type_t.num5
   DEFINE l_ooefl003    LIKE ooefl_t.ooefl003
   #150210-00011(1)--20150330--add--
   DEFINE l_flag1       LIKE type_t.chr1
   DEFINE l_errno       LIKE type_t.chr100
   #150210-00011(1)--20150330--add--
   DEFINE l_sfin2009    LIKE type_t.chr10    #151012-00014#1 add lujh
   
   #20150422--add--str--lujh
   IF NOT cl_null(g_argv[1]) AND NOT cl_null(g_argv[2]) THEN
      LET g_bgjob            = g_argv[1]    #背景执行
      LET g_master.xrcasite  = g_argv[2]    #账务中心
      LET g_master.xrcald    = g_argv[3]    #账套
      LET g_master.b_style   = g_argv[4]    #立账依据
      LET g_master.xrcadocno = g_argv[5]    #应收单别
      LET g_master.xrca007   = g_argv[6]    #账款类别
      LET g_master.xrcadocdt = g_argv[7]    #立账日期
      LET g_master.b_comb1   = g_argv[8]    #汇率基准
      LET g_master.b_check1  = g_argv[9]    #订金待抵
      LET g_master.b_check2  = g_argv[10]   #销退待抵
      LET g_master.b_check3  = g_argv[11]   #预收待抵
      LET g_master.b_check4  = g_argv[12]   #杂项待抵
      LET g_master.b_check5  = g_argv[13]   #溢收待抵
      LET g_master.b_check6  = g_argv[14]   #押金待抵
      LET g_master.b_comb2   = g_argv[15]   #汇总条件
      LET g_master.wc = " xmdkdocno = '",g_argv[16],"'"  #单据编号字串 
      LET g_master.xmdk042   = g_argv[17]   #内外销   160905-00031#1 Add
      LET g_master.xmdk032   = g_argv[18]   #结关日   160905-00031#1 Add
   ELSE
   #20150422--add--end--lujh
      IF cl_null(g_master.xrcasite) OR cl_null(g_master.xrcald) THEN
         #帳務中心
         #取得預設的帳務中心,因新增階段的時候,並不會知道site,所以以登入人員做為依據
         CALL s_fin_get_account_center('',g_user,'3',g_today) RETURNING l_success,g_master.xrcasite,g_errno
         #該帳務中心與帳別無法勾稽到,以登入人員g_user取得預設帳別/法人
         CALL s_fin_orga_get_comp_ld(g_master.xrcasite) RETURNING l_success,g_errno,l_xrcacomp,g_master.xrcald   
      
         #若取不出資料,則不預設帳別
         IF NOT l_success THEN
            LET g_master.xrcald   = ''
         END IF
      
         CALL s_axrt300_xrca_ref('xrcald',g_master.xrcald,'','') RETURNING l_success,g_master.xrcald_desc
         #161128-00061#3-----modify--begin----------
         #SELECT * INTO g_glaa.* 
          SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
                 glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
                 glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
                 glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
                 glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
                 glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
         #161128-00061#3-----modify--end----------
         FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_master.xrcald
         CALL s_axrt300_xrca_ref('xrcasite',g_master.xrcasite,'','') RETURNING l_success,g_master.xrcasite_desc
         DISPLAY BY NAME g_master.xrcasite,g_master.xrcasite_desc,g_master.xrcald,g_master.xrcald_desc
      END IF
      
      IF cl_null(g_master.xrcadocdt) THEN LET g_master.xrcadocdt = g_today END IF
      
      IF cl_null(g_master.b_style)  THEN LET g_master.b_style = 'axrt300'  END IF
      #IF cl_null(g_master.b_comb1)  THEN LET g_master.b_comb1 = '1'  END IF   #151012-00014#1 mark lujh
      #160905-00031#1 Mark ---(S)---
      #151012-00014#1--add--str--lujh
     #CALL cl_get_para(g_enterprise,g_glaa.glaacomp,'S-FIN-2009') RETURNING l_sfin2009   
     #IF l_sfin2009 = '1' THEN LET g_master.b_comb1 = '2' END IF
     #IF l_sfin2009 = '2' THEN LET g_master.b_comb1 = '3' END IF
      #151012-00014#1--add--end--lujh
      #160905-00031#1 Mark ---(E)---
      IF cl_null(g_master.b_comb1)  THEN LET g_master.b_comb1 = '1'  END IF   #160905-00031#1 Add
      
      IF cl_null(g_master.b_comb2)  THEN LET g_master.b_comb2 = '1'  END IF
      IF cl_null(g_master.b_check1) THEN LET g_master.b_check1 = 'Y' END IF
      IF cl_null(g_master.b_check2) THEN LET g_master.b_check2 = 'N' END IF
      IF cl_null(g_master.b_check3) THEN LET g_master.b_check3 = 'N' END IF
      IF cl_null(g_master.b_check4) THEN LET g_master.b_check4 = 'N' END IF
      IF cl_null(g_master.b_check5) THEN LET g_master.b_check5 = 'N' END IF
      IF cl_null(g_master.b_check6) THEN LET g_master.b_check6 = 'N' END IF
      #160905-00031#1 Add  ---(S)---
      IF cl_null(g_master.xmdk042)  THEN LET g_master.xmdk042  = '1' END IF
      #160905-00031#1 Add  ---(E)---
   END IF   #20150422--add--str--lujh
   DISPLAY BY NAME g_master.xrcadocdt,g_master.b_style,g_master.b_comb1,g_master.b_comb2,
                   g_master.b_check1,g_master.b_check2,g_master.b_check3,
                   g_master.b_check4,g_master.b_check5,g_master.b_check6

   #161111-00049#6 Add  ---(S)---
   #161128-00061#3-----modify--begin----------
   #SELECT * INTO g_glaa.* 
    SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
           glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
           glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
           glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
           glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
           glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
   #161128-00061#3-----modify--end----------
   FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_master.xrcald
   CALL s_control_get_customer_sql_pmab('4',g_site,g_user,g_dept,'',g_glaa.glaacomp)
      RETURNING g_sub_success,g_sql_ctrl
   #161111-00049#6 Add  ---(E)---

   #150210-00011(1)--20150330--add--
   CALL s_get_accdate(g_glaa.glaa003,g_master.xrcadocdt,'','') 
   RETURNING l_flag1,l_errno,g_glav002,g_glav005,g_sdate_s,g_sdate_e,
             g_glav006,g_pdate_s,g_pdate_e,g_glav007,g_wdate_s,g_wdate_e
   #150210-00011(1)--20150330--add--
END FUNCTION
################################################################################
# Descriptions...: 建立臨時表
# Memo...........:
# Usage..........: CALL axrp133_create_tmp()
#                  RETURNING r_success
# Input parameter: 
# Return code....: 
# Date & Author..: 2014/10/17 By zhangweib
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp133_create_tmp()
   DEFINE r_success         LIKE type_t.chr1

   LET r_success = 'Y'

   DROP TABLE axrp133_tmp01;                #160727-00019#33  mod axrp133_xmdk_tmp --> axrp133_tmp01  
   CREATE TEMP TABLE axrp133_tmp01 (        #160727-00019#33  mod axrp133_xmdk_tmp --> axrp133_tmp01  
      xmdldocno     LIKE xmdl_t.xmdldocno,
      xmdlseq       LIKE xmdl_t.xmdlseq,
      xmdk000       LIKE xmdk_t.xmdk000,
      xmdk003       LIKE xmdk_t.xmdk003,
      xmdk004       LIKE xmdk_t.xmdk004,
      xmdk007       LIKE xmdk_t.xmdk007,
      xmdk008       LIKE xmdk_t.xmdk008,
      xmdk010       LIKE xmdk_t.xmdk010,
      xmdk014       LIKE xmdk_t.xmdk014,
      xmdk016       LIKE xmdk_t.xmdk016,
      xmdk017       LIKE xmdk_t.xmdk017,
      xmdk031       LIKE xmdk_t.xmdk031,
      xrcb007       LIKE xrcb_t.xrcb007
   );

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
#   DROP TABLE axrp133_success_tmp;
#   CREATE TEMP TABLE axrp133_success_tmp (
#      docno         LIKE xrca_t.xrcadocno,
#      amt           LIKE xrca_t.xrca108,
#      gzze001       LIKE gzze_t.gzze001,
#      gzze003       LIKE gzze_t.gzze003,
#      success       LIKE type_t.chr1
#   );
#   
#   IF SQLCA.sqlcode THEN
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = SQLCA.sqlcode
#      LET g_errparam.extend = 'create'
#      LET g_errparam.popup = TRUE
#      CALL cl_err()
#   
#      RETURN r_success
#   END IF
   
   RETURN r_success

END FUNCTION

################################################################################
# Descriptions...: 獲取符合條件的出貨單據資料
# Memo...........:
# Usage..........: CALL axrp133_get_data()
#                  RETURNING ---
# Input parameter: ---
# Return code....: ---
# Date & Author..: 2014/10/09 By zhangweib
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp133_get_data()
   DEFINE l_success     LIKE type_t.chr1
   DEFINE l_count       LIKE type_t.num5
   DEFINE l_origin_str  STRING
   DEFINE l_wc          STRING
   DEFINE l_xmdk        RECORD
          xmdkdocno     LIKE xmdk_t.xmdkdocno,
          xmdlseq       LIKE xmdl_t.xmdlseq,
          xmdk000       LIKE xmdk_t.xmdk000,
          xmdk003       LIKE xmdk_t.xmdk003,
          xmdk004       LIKE xmdk_t.xmdk004,
          xmdk007       LIKE xmdk_t.xmdk007,
          xmdk008       LIKE xmdk_t.xmdk008,
          xmdk010       LIKE xmdk_t.xmdk010,
          xmdk014       LIKE xmdk_t.xmdk014,
          xmdk016       LIKE xmdk_t.xmdk016,
          xmdk017       LIKE xmdk_t.xmdk017,
          xmdk031       LIKE xmdk_t.xmdk031,
          xrcb007       LIKE xrcb_t.xrcb007
                        END RECORD
   DEFINE l_s           LIKE type_t.chr1
   DEFINE l_ac          LIKE type_t.num5
   DEFINE l_mm          LIKE type_t.chr2
   DEFINE l_str         STRING
   DEFINE l_orders      STRING
   DEFINE l_order       LIKE type_t.chr200
   DEFINE l_flag        LIKE type_t.chr1
   DEFINE l_sql         STRING
   DEFINE l_glaacomp    LIKE glaa_t.glaacomp  #150317-00001#3 Add
   DEFINE l_xmdl003     LIKE xmdl_t.xmdl003   #150317-00001#3 Add
   DEFINE l_where       STRING     #160325-00023#1

   IF cl_null(g_master.wc) THEN LET g_master.wc = " 1=1" END IF

   CALL s_axrt300_sel_ld(g_master.xrcald) RETURNING l_success,l_s
   
   SELECT glaacomp INTO l_glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_master.xrcald   #150317-00001#3 Add
   
   #CALL s_fin_account_center_sons_query('3',g_master.xrcasite,g_master.xrcadocdt,'')
   CALL s_fin_account_center_sons_query('3',l_glaacomp,g_master.xrcadocdt,'')
   CALL s_fin_account_center_sons_str()RETURNING l_origin_str
   IF cl_null(l_origin_str) THEN LET l_origin_str = g_master.xrcasite END IF
   CALL axrp133_get_ooef001_wc(l_origin_str)RETURNING l_origin_str

   

   LET g_success = 'Y'
   IF MONTH(g_master.xrcadocdt) > 9 THEN
      LET l_mm = MONTH(g_master.xrcadocdt)
   ELSE
      LET l_mm = '0',MONTH(g_master.xrcadocdt)
   END IF

   LET l_wc = ""
   IF g_master.b_style = 'axrt300' THEN
      LET l_wc = " AND xmdk000 <> 6 AND xmdk002 = '1'"
   ELSE
      LET l_wc = " AND xmdk000 = 6"
   END IF

   LET g_sql = "SELECT xmdkdocno,xmdlseq,xmdk000,xmdk003,xmdk004,xmdk007,xmdk008,xmdk010,      ",
               "       xmdk014,xmdk016,xmdk017,xmdk031,xrcb007                                 ",
               "  FROM (SELECT xmdkdocno,xmdlseq,xmdk000,xmdk003,xmdk004,xmdk007,xmdk008,      ",
               "               xmdk010,xmdk014,xmdk016,xmdk017,xmdk031,                        ",
               "               CASE WHEN '",l_s,"' = '1' THEN                                  ",
               "                       CASE WHEN xmdl022 IS NULL THEN 0 ELSE xmdl022 END       ",
               "                     - CASE WHEN xmdl038 IS NULL THEN 0 ELSE xmdl038 END       ",
               "                    WHEN '",l_s,"' = '2' THEN                                  ",
               "                       CASE WHEN xmdl022 IS NULL THEN 0 ELSE xmdl022 END       ",
               "                     - CASE WHEN xmdl039 IS NULL THEN 0 ELSE xmdl039 END       ",
               "                    WHEN '",l_s,"' = '3' THEN                                  ",
               "                       CASE WHEN xmdl022 IS NULL THEN 0 ELSE xmdl022 END       ",
               "                     - CASE WHEN xmdl040 IS NULL THEN 0 ELSE xmdl040 END       ",
               "               END xrcb007                                                     ",
               "          FROM xmdk_t, xmdl_t                                                  ",
               "         WHERE     xmdkdocno = xmdldocno      AND xmdkent = xmdlent            ",
               "               AND xmdl087 = 'Y'              AND xmdkent = '",g_enterprise,"' ",
               "               AND xmdkstus = 'S'                                              ",
               "               AND xmdk000 IN ('1','2','3','6')                                ",
               "               AND ((xmdk000 <> 6 AND xmdk002 = '1') OR (xmdk000 = '6' AND xmdk082 <> 5))",
               "               AND ", g_master.wc  CLIPPED,
               "               AND TO_CHAR(xmdk001,'MM') = '",l_mm,"'",l_wc,
               "               AND xmdlsite IN ",l_origin_str,"                                ",
               "               )                                                               ",
               " WHERE     xrcb007 > 0                                                         "
        
   PREPARE axrp133_prep FROM g_sql
   DECLARE axrp133_curs CURSOR FOR axrp133_prep

   CALL axrp133_create_tmp() RETURNING l_success


   FOREACH axrp133_curs INTO l_xmdk.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET g_success = 'N'
         EXIT FOREACH
      END IF

     #150317-00001#3 Add  ---(S)---
     #SELECT pmab081,pmab109 INTO l_xmdk.xmdk003,l_xmdk.xmdk004 FROM pmab_t
     # WHERE pmabent = g_enterprise
     #   AND pmab001 = l_xmdk.xmdk007
     #   AND pmabsite = l_glaacomp
     #SELECT xmdl003 INTO l_xmdl003 FROM xmdl_t WHERE xmdlent = g_enterprise
     #   AND xmdldocno = l_xmdk.xmdkdocno
     #   AND xmdlseq = l_xmdk.xmdlseq
     #CASE
     #   WHEN g_master.b_comb2 = '3'   #依業務人員匯總
     #      SELECT xmda002 INTO l_xmdk.xmdk003
     #        FROM xmda_t WHERE xmdaent = g_enterprise AND xmdadocno = l_xmdl003
     #   WHEN g_master.b_comb2 = '4'   #依業務部門匯總
     #      SELECT xmda003 INTO l_xmdk.xmdk004
     #        FROM xmda_t WHERE xmdaent = g_enterprise AND xmdadocno = l_xmdl003
     #END CASE
     #150317-00001#3 Add  ---(E)---

      IF cl_null(l_xmdk.xmdk003) THEN LET l_xmdk.xmdk003 = ' ' END IF
      IF cl_null(l_xmdk.xmdk004) THEN LET l_xmdk.xmdk004 = ' ' END IF
      IF cl_null(l_xmdk.xmdk007) THEN LET l_xmdk.xmdk007 = ' ' END IF
      IF cl_null(l_xmdk.xmdk008) THEN LET l_xmdk.xmdk008 = ' ' END IF
      IF cl_null(l_xmdk.xmdk010) THEN LET l_xmdk.xmdk010 = ' ' END IF
      IF cl_null(l_xmdk.xmdk014) THEN LET l_xmdk.xmdk014 = ' ' END IF
      IF cl_null(l_xmdk.xmdk016) THEN LET l_xmdk.xmdk016 = ' ' END IF
      IF cl_null(l_xmdk.xmdk017) THEN LET l_xmdk.xmdk017 = ' ' END IF

      INSERT INTO axrp133_tmp01 VALUES (l_xmdk.*)           #160727-00019#33  mod axrp133_xmdk_tmp --> axrp133_tmp01

   END FOREACH

   IF g_success = 'Y' THEN
      SELECT COUNT(*) INTO l_count FROM axrp133_tmp01        #160727-00019#33  mod axrp133_xmdk_tmp --> axrp133_tmp01
      IF l_count = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'ins temp table:'
#         LET g_errparam.code   = 'axm-00276'   #160318-00005#51  mark
         LET g_errparam.code   = 'sub-01321'    #160318-00005#51  add
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         
         #请检查来源单据是否需自立应收
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ''
         LET g_errparam.code   = 'axr-00321'
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         
         #请检查来源单据是否已过账
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ''
         LET g_errparam.code   = 'axr-00322'
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         
         #请检查来源单据是否为单据性质为[1:一般订单]的出货单或者销退单
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ''
         LET g_errparam.code   = 'axr-00323'
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         
         #请检查来源单据是否存在
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ''
         LET g_errparam.code   = 'axr-00324'
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         
         #请检查来源单据的扣账日期是否与立账日期在同一月份
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ''
         LET g_errparam.code   = 'axr-00325'
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         
         #请检查来源单据的营运据点是否在此账务中心的管辖范围内
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ''
         LET g_errparam.code   = 'axr-00326'
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         
         #请检查来源单据的计价数量是否已全部立账
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ''
         LET g_errparam.code   = 'axr-00327'
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         
         LET g_success = 'N'
         RETURN
      END IF
   END IF

   #20150201#1 By zhangwei Add  ---(S)---
   CALL s_axrt300_sel_ld(g_master.xrcald) RETURNING l_success,l_s
   CALL cl_get_para(g_enterprise,g_glaa.glaacomp,'S-FIN-1002') RETURNING l_flag

   CASE
      WHEN g_master.b_comb2 = '1'
         LET l_str   = "xmdldocno"
         LET l_orders= "xmdldocno"
      WHEN g_master.b_comb2 = '2'
         LET l_str   = "xmdk031||xmdk007||xmdk008||xmdk016||xmdk014"
         LET l_orders= "xmdk031,xmdk007,xmdk008,xmdk016,xmdk014"
         IF l_flag != '3' THEN
            LET l_str   = l_str,   "||xmdk010"
            LET l_orders= l_orders,",xmdk010"
         END IF
         IF g_master.b_comb1 = '1' THEN
            LET l_str   = l_str,   "||xmdk017"
            LET l_orders= l_orders,",xmdk017"
         END IF
      WHEN g_master.b_comb2 = '3'
         LET l_str   = "xmdk031||xmdk007||xmdk008||xmdk016||xmdk014||xmdk003||xmdk004"
         LET l_orders= "xmdk031,xmdk007,xmdk008,xmdk016,xmdk014,xmdk003,xmdk004"
         IF l_flag != '3' THEN
            LET l_str   = l_str,   "||xmdk010"
            LET l_orders= l_orders,",xmdk010"
         END IF
         IF g_master.b_comb1 = '1' THEN
            LET l_str   = l_str,   "||xmdk017"
            LET l_orders= l_orders,",xmdk017"
         END IF
      WHEN g_master.b_comb2 = '4'
         LET l_str   = "xmdk031||xmdk007||xmdk008||xmdk016||xmdk014||xmdk003||xmdk004"
         LET l_orders= "xmdk031,xmdk007,xmdk008,xmdk016,xmdk014,xmdk003,xmdk004"
         IF l_flag != '3' THEN
            LET l_str   = l_str,   "||xmdk010"
            LET l_orders= l_orders,",xmdk010"
         END IF
         IF g_master.b_comb1 = '1' THEN
            LET l_str   = l_str,   "||xmdk017"
            LET l_orders= l_orders,",xmdk017"
         END IF
   END CASE
   LET l_str = l_str,"||CASE WHEN xmdk000 = 6 THEN 2 ELSE 1 END"
   LET l_orders= l_orders,",CASE WHEN xmdk000 = 6 THEN 2 ELSE 1 END"

   LET l_sql = "SELECT ",l_str,",xmdldocno,xmdlseq,xrcb007 FROM axrp133_tmp01",      #160727-00019#33  mod axrp133_xmdk_tmp --> axrp133_tmp01
               " ORDER BY ",l_orders,",xmdldocno,xmdlseq"
   PREPARE axrp133_ar_prep1 FROM l_sql
   DECLARE axrp133_ar_curs1 CURSOR FOR axrp133_ar_prep1

   CALL g_xmdk_d.clear()
   LET l_ac = 1

   FOREACH axrp133_ar_curs1 INTO g_xmdk_d[l_ac].*
      LET l_ac = l_ac + 1
   END FOREACH
   CALL g_xmdk_d.deleteElement(l_ac)
   LET l_ac = l_ac - 1
   #20150201#1 By zhangwei Add  ---(S)---

END FUNCTION

################################################################################
# Descriptions...: 產生應收單據
# Memo...........:
# Usage..........: CALL axrp133_get_ar()
#                  RETURNING ---
# Input parameter: ---
# Return code....: ---
# Date & Author..: 2014/10/09 By zhangweib
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp133_get_ar()
   DEFINE l_sql         STRING
   DEFINE l_str         STRING
   DEFINE l_orders      STRING
   DEFINE l_order       LIKE type_t.chr200
   DEFINE l_order_t     LIKE type_t.chr200
  #DEFINE l_xmdldocno   LIKE xmdl_t.xmdldocno   #20150201#1 By zhangwei Mark
  #DEFINE l_xmdlseq     LIKE xmdl_t.xmdlseq     #20150201#1 By zhangwei Mark
  #DEFINE l_xrcb007     LIKE xrcb_t.xrcb007     #20150201#1 By zhangwei Mark
    #161128-00061#3-----modify--begin----------
   #DEFINE l_xmdk        RECORD LIKE xmdk_t.*
   #DEFINE l_xmdl        RECORD LIKE xmdl_t.*
   DEFINE l_xmdk RECORD  #出貨/簽收/銷退單單頭檔
       xmdkent LIKE xmdk_t.xmdkent, #企業編號
       xmdksite LIKE xmdk_t.xmdksite, #營運據點
       xmdkunit LIKE xmdk_t.xmdkunit, #應用組織
       xmdkdocno LIKE xmdk_t.xmdkdocno, #單據單號
       xmdkdocdt LIKE xmdk_t.xmdkdocdt, #單據日期
       xmdk000 LIKE xmdk_t.xmdk000, #單據性質
       xmdk001 LIKE xmdk_t.xmdk001, #扣帳日期
       xmdk002 LIKE xmdk_t.xmdk002, #出貨性質
       xmdk003 LIKE xmdk_t.xmdk003, #業務人員
       xmdk004 LIKE xmdk_t.xmdk004, #業務部門
       xmdk005 LIKE xmdk_t.xmdk005, #出通/出貨單號
       xmdk006 LIKE xmdk_t.xmdk006, #訂單單號
       xmdk007 LIKE xmdk_t.xmdk007, #訂單客戶
       xmdk008 LIKE xmdk_t.xmdk008, #收款客戶
       xmdk009 LIKE xmdk_t.xmdk009, #收貨客戶
       xmdk010 LIKE xmdk_t.xmdk010, #收款條件
       xmdk011 LIKE xmdk_t.xmdk011, #交易條件
       xmdk012 LIKE xmdk_t.xmdk012, #稅別
       xmdk013 LIKE xmdk_t.xmdk013, #稅率
       xmdk014 LIKE xmdk_t.xmdk014, #單價含稅否
       xmdk015 LIKE xmdk_t.xmdk015, #發票類型
       xmdk016 LIKE xmdk_t.xmdk016, #幣別
       xmdk017 LIKE xmdk_t.xmdk017, #匯率
       xmdk018 LIKE xmdk_t.xmdk018, #取價方式
       xmdk019 LIKE xmdk_t.xmdk019, #優惠條件
       xmdk020 LIKE xmdk_t.xmdk020, #送貨供應商
       xmdk021 LIKE xmdk_t.xmdk021, #送貨地址
       xmdk022 LIKE xmdk_t.xmdk022, #運輸方式
       xmdk023 LIKE xmdk_t.xmdk023, #交運起點
       xmdk024 LIKE xmdk_t.xmdk024, #交運終點
       xmdk025 LIKE xmdk_t.xmdk025, #航次/航班/車號
       xmdk026 LIKE xmdk_t.xmdk026, #起運日期
       xmdk027 LIKE xmdk_t.xmdk027, #嘜頭編號
       xmdk028 LIKE xmdk_t.xmdk028, #包裝單製作
       xmdk029 LIKE xmdk_t.xmdk029, #Invoice製作
       xmdk030 LIKE xmdk_t.xmdk030, #銷售通路
       xmdk031 LIKE xmdk_t.xmdk031, #銷售分類
       xmdk032 LIKE xmdk_t.xmdk032, #結關日期
       xmdk033 LIKE xmdk_t.xmdk033, #額外品名規格
       xmdk034 LIKE xmdk_t.xmdk034, #留置原因
       xmdk035 LIKE xmdk_t.xmdk035, #多角序號
       xmdk036 LIKE xmdk_t.xmdk036, #整合單號
       xmdk037 LIKE xmdk_t.xmdk037, #發票號碼
       xmdk038 LIKE xmdk_t.xmdk038, #運輸狀態
       xmdk039 LIKE xmdk_t.xmdk039, #在途成本庫位
       xmdk040 LIKE xmdk_t.xmdk040, #在途非成本庫位
       xmdk041 LIKE xmdk_t.xmdk041, #發票編號
       xmdk042 LIKE xmdk_t.xmdk042, #內外銷
       xmdk043 LIKE xmdk_t.xmdk043, #匯率計算基準
       xmdk044 LIKE xmdk_t.xmdk044, #多角流程編號
       xmdk045 LIKE xmdk_t.xmdk045, #多角性質
       xmdk051 LIKE xmdk_t.xmdk051, #總未稅金額
       xmdk052 LIKE xmdk_t.xmdk052, #總含稅金額
       xmdk053 LIKE xmdk_t.xmdk053, #總稅額
       xmdk054 LIKE xmdk_t.xmdk054, #備註
       xmdk055 LIKE xmdk_t.xmdk055, #客戶收貨日
       xmdk081 LIKE xmdk_t.xmdk081, #對應的簽收單號
       xmdk082 LIKE xmdk_t.xmdk082, #銷退方式
       xmdk083 LIKE xmdk_t.xmdk083, #多角貿易已拋轉
       xmdk084 LIKE xmdk_t.xmdk084, #折讓證明單開立否
       xmdk200 LIKE xmdk_t.xmdk200, #調貨經銷商編號
       xmdk201 LIKE xmdk_t.xmdk201, #代送商編號
       xmdk202 LIKE xmdk_t.xmdk202, #發票客戶
       xmdk203 LIKE xmdk_t.xmdk203, #促銷方案編號
       xmdk204 LIKE xmdk_t.xmdk204, #整單折扣
       xmdk205 LIKE xmdk_t.xmdk205, #送貨站點編號
       xmdk206 LIKE xmdk_t.xmdk206, #運輸路線編號
       xmdk207 LIKE xmdk_t.xmdk207, #銷售組織
       xmdk208 LIKE xmdk_t.xmdk208, #調貨出貨單號
       xmdk209 LIKE xmdk_t.xmdk209, #No Use
       xmdk210 LIKE xmdk_t.xmdk210, #No Use
       xmdk211 LIKE xmdk_t.xmdk211, #No Use
       xmdk212 LIKE xmdk_t.xmdk212, #No Use
       xmdk213 LIKE xmdk_t.xmdk213, #本幣含稅總金額
       xmdk214 LIKE xmdk_t.xmdk214, #收款完成否
       xmdkownid LIKE xmdk_t.xmdkownid, #資料所屬者
       xmdkowndp LIKE xmdk_t.xmdkowndp, #資料所有部門
       xmdkcrtid LIKE xmdk_t.xmdkcrtid, #資料建立者
       xmdkcrtdp LIKE xmdk_t.xmdkcrtdp, #資料建立部門
       xmdkcrtdt LIKE xmdk_t.xmdkcrtdt, #資料創建日
       xmdkmodid LIKE xmdk_t.xmdkmodid, #資料修改者
       xmdkmoddt LIKE xmdk_t.xmdkmoddt, #最近修改日
       xmdkcnfid LIKE xmdk_t.xmdkcnfid, #資料確認者
       xmdkcnfdt LIKE xmdk_t.xmdkcnfdt, #資料確認日
       xmdkpstid LIKE xmdk_t.xmdkpstid, #資料過帳者
       xmdkpstdt LIKE xmdk_t.xmdkpstdt, #資料過帳日
       xmdkstus LIKE xmdk_t.xmdkstus, #狀態碼
       xmdk085 LIKE xmdk_t.xmdk085, #資料來源(銷退)
       xmdk086 LIKE xmdk_t.xmdk086, #來源單號(銷退)
       xmdk046 LIKE xmdk_t.xmdk046, #整合來源
       xmdk087 LIKE xmdk_t.xmdk087, #出貨走發票倉調撥
       xmdk047 LIKE xmdk_t.xmdk047, #一次性交易對象識別碼
       xmdk088 LIKE xmdk_t.xmdk088, #來源類型
       xmdk089 LIKE xmdk_t.xmdk089  #來源單號
       END RECORD
   DEFINE l_xmdl RECORD  #出貨/簽收/銷退單單身明細檔
       xmdlent LIKE xmdl_t.xmdlent, #企業編號
       xmdlsite LIKE xmdl_t.xmdlsite, #營運據點
       xmdldocno LIKE xmdl_t.xmdldocno, #單據編號
       xmdlseq LIKE xmdl_t.xmdlseq, #項次
       xmdl001 LIKE xmdl_t.xmdl001, #出通單號
       xmdl002 LIKE xmdl_t.xmdl002, #出通項次
       xmdl003 LIKE xmdl_t.xmdl003, #訂單單號
       xmdl004 LIKE xmdl_t.xmdl004, #訂單項次
       xmdl005 LIKE xmdl_t.xmdl005, #訂單項序
       xmdl006 LIKE xmdl_t.xmdl006, #訂單分批序
       xmdl007 LIKE xmdl_t.xmdl007, #子件特性
       xmdl008 LIKE xmdl_t.xmdl008, #料件編號
       xmdl009 LIKE xmdl_t.xmdl009, #產品特徵
       xmdl010 LIKE xmdl_t.xmdl010, #包裝容器
       xmdl011 LIKE xmdl_t.xmdl011, #作業編號
       xmdl012 LIKE xmdl_t.xmdl012, #作業序
       xmdl013 LIKE xmdl_t.xmdl013, #多庫儲批出貨
       xmdl014 LIKE xmdl_t.xmdl014, #庫位
       xmdl015 LIKE xmdl_t.xmdl015, #儲位
       xmdl016 LIKE xmdl_t.xmdl016, #批號
       xmdl017 LIKE xmdl_t.xmdl017, #出貨單位
       xmdl018 LIKE xmdl_t.xmdl018, #數量
       xmdl019 LIKE xmdl_t.xmdl019, #參考單位
       xmdl020 LIKE xmdl_t.xmdl020, #參考數量
       xmdl021 LIKE xmdl_t.xmdl021, #計價單位
       xmdl022 LIKE xmdl_t.xmdl022, #計價數量
       xmdl023 LIKE xmdl_t.xmdl023, #檢驗否
       xmdl024 LIKE xmdl_t.xmdl024, #單價
       xmdl025 LIKE xmdl_t.xmdl025, #稅別
       xmdl026 LIKE xmdl_t.xmdl026, #稅率
       xmdl027 LIKE xmdl_t.xmdl027, #未稅金額
       xmdl028 LIKE xmdl_t.xmdl028, #含稅金額
       xmdl029 LIKE xmdl_t.xmdl029, #稅額
       xmdl030 LIKE xmdl_t.xmdl030, #專案編號
       xmdl031 LIKE xmdl_t.xmdl031, #WBS編號
       xmdl032 LIKE xmdl_t.xmdl032, #活動編號
       xmdl033 LIKE xmdl_t.xmdl033, #客戶料號
       xmdl034 LIKE xmdl_t.xmdl034, #QPA
       xmdl035 LIKE xmdl_t.xmdl035, #已簽收量
       xmdl036 LIKE xmdl_t.xmdl036, #已簽退量
       xmdl037 LIKE xmdl_t.xmdl037, #已銷退量
       xmdl038 LIKE xmdl_t.xmdl038, #主帳套已立帳數量
       xmdl039 LIKE xmdl_t.xmdl039, #帳套二已立帳數量
       xmdl040 LIKE xmdl_t.xmdl040, #帳套三已立帳數量
       xmdl041 LIKE xmdl_t.xmdl041, #保稅否
       xmdl042 LIKE xmdl_t.xmdl042, #取價來源
       xmdl043 LIKE xmdl_t.xmdl043, #價格來源參考單號
       xmdl044 LIKE xmdl_t.xmdl044, #價格來源參考項次
       xmdl045 LIKE xmdl_t.xmdl045, #取出價格
       xmdl046 LIKE xmdl_t.xmdl046, #價差比
       xmdl047 LIKE xmdl_t.xmdl047, #已開發票數量
       xmdl048 LIKE xmdl_t.xmdl048, #發票編號
       xmdl049 LIKE xmdl_t.xmdl049, #發票號碼
       xmdl050 LIKE xmdl_t.xmdl050, #理由碼
       xmdl051 LIKE xmdl_t.xmdl051, #備註
       xmdl052 LIKE xmdl_t.xmdl052, #庫存管理特徵
       xmdl053 LIKE xmdl_t.xmdl053, #主帳套暫估數量
       xmdl054 LIKE xmdl_t.xmdl054, #帳套二暫估數量
       xmdl055 LIKE xmdl_t.xmdl055, #帳套三暫估數量
       xmdl081 LIKE xmdl_t.xmdl081, #簽退數量(簽收、簽退單使用)
       xmdl082 LIKE xmdl_t.xmdl082, #簽退參考數量(簽收、簽退單使用)
       xmdl083 LIKE xmdl_t.xmdl083, #簽退計價數量(簽收、簽退單使用)
       xmdl084 LIKE xmdl_t.xmdl084, #簽退理由碼(簽收、簽退單使用)
       xmdl085 LIKE xmdl_t.xmdl085, #訂單開立據點
       xmdl086 LIKE xmdl_t.xmdl086, #訂單多角性質
       xmdl087 LIKE xmdl_t.xmdl087, #需自立應收否
       xmdl088 LIKE xmdl_t.xmdl088, #多角流程編號
       xmdl089 LIKE xmdl_t.xmdl089, #QC單號
       xmdl090 LIKE xmdl_t.xmdl090, #判定項次
       xmdl091 LIKE xmdl_t.xmdl091, #判定結果
       xmdl092 LIKE xmdl_t.xmdl092, #借貨還量數量
       xmdl093 LIKE xmdl_t.xmdl093, #借貨還量參考數量
       xmdl200 LIKE xmdl_t.xmdl200, #銷售通路
       xmdl201 LIKE xmdl_t.xmdl201, #產品組編碼
       xmdl202 LIKE xmdl_t.xmdl202, #銷售範圍編碼
       xmdl203 LIKE xmdl_t.xmdl203, #銷售辦公室
       xmdl204 LIKE xmdl_t.xmdl204, #出貨包裝單位
       xmdl205 LIKE xmdl_t.xmdl205, #出貨包裝數量
       xmdl206 LIKE xmdl_t.xmdl206, #簽退包裝數量
       xmdl207 LIKE xmdl_t.xmdl207, #庫存鎖定等級
       xmdl208 LIKE xmdl_t.xmdl208, #標準價
       xmdl209 LIKE xmdl_t.xmdl209, #促銷價
       xmdl210 LIKE xmdl_t.xmdl210, #交易價
       xmdl211 LIKE xmdl_t.xmdl211, #折價金額
       xmdl212 LIKE xmdl_t.xmdl212, #銷售組織
       xmdl213 LIKE xmdl_t.xmdl213, #銷售人員
       xmdl214 LIKE xmdl_t.xmdl214, #銷售部門
       xmdl215 LIKE xmdl_t.xmdl215, #合約編號
       xmdl216 LIKE xmdl_t.xmdl216, #經營方式
       xmdl217 LIKE xmdl_t.xmdl217, #結算類型
       xmdl218 LIKE xmdl_t.xmdl218, #結算方式
       xmdl219 LIKE xmdl_t.xmdl219, #交易類型
       xmdl220 LIKE xmdl_t.xmdl220, #寄銷已核銷數量
       xmdl222 LIKE xmdl_t.xmdl222, #地區編號
       xmdl223 LIKE xmdl_t.xmdl223, #縣市編號
       xmdl224 LIKE xmdl_t.xmdl224, #省區編號
       xmdl225 LIKE xmdl_t.xmdl225, #區域編號
       xmdl226 LIKE xmdl_t.xmdl226, #商品條碼
       xmdlunit LIKE xmdl_t.xmdlunit, #應用組織
       xmdlorga LIKE xmdl_t.xmdlorga, #帳務組織
       xmdl056 LIKE xmdl_t.xmdl056, #檢驗合格量
       xmdl094 LIKE xmdl_t.xmdl094, #來源單號(銷退)
       xmdl095 LIKE xmdl_t.xmdl095, #項次(銷退)
       xmdl227 LIKE xmdl_t.xmdl227, #現金折扣單號
       xmdl228 LIKE xmdl_t.xmdl228, #現金折扣單項次
       xmdl057 LIKE xmdl_t.xmdl057, #有效日期
       xmdl058 LIKE xmdl_t.xmdl058, #製造日期
       xmdl096 LIKE xmdl_t.xmdl096, #來源項次
       xmdl059 LIKE xmdl_t.xmdl059, #客戶退貨量
       xmdl060 LIKE xmdl_t.xmdl060  #放行狀態
       END RECORD

   #161128-00061#3-----modify--end----------
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_xrca001     LIKE xrca_t.xrca001
   DEFINE l_xmdk000     LIKE xmdk_t.xmdk000
   DEFINE l_ooba002     LIKE ooba_t.ooba002
   DEFINE l_xrcadocno   LIKE xrca_t.xrcadocno
   DEFINE l_xrca        RECORD
          xrca005       LIKE xrca_t.xrca005,
          xrca006       LIKE xrca_t.xrca006,
          xrca007       LIKE xrca_t.xrca007,
          xrca008       LIKE xrca_t.xrca008,
          xrca009       LIKE xrca_t.xrca009,
          xrca010       LIKE xrca_t.xrca010,
          xrca011       LIKE xrca_t.xrca011,
          xrca012       LIKE xrca_t.xrca012,
          xrca013       LIKE xrca_t.xrca013,
          xrca014       LIKE xrca_t.xrca014,
          xrca015       LIKE xrca_t.xrca015,
          xrca046       LIKE xrca_t.xrca046,
          xrca058       LIKE xrca_t.xrca058,
          xrca061       LIKE xrca_t.xrca061,
          xrca100       LIKE xrca_t.xrca100,
          xrca101       LIKE xrca_t.xrca101,
          xrca121       LIKE xrca_t.xrca121,
          xrca131       LIKE xrca_t.xrca131
                        END RECORD
DEFINE r_xrca           RECORD
          xrca103          LIKE xrca_t.xrca103,
          xrca104          LIKE xrca_t.xrca104,
          xrca108          LIKE xrca_t.xrca108,
          xrca113          LIKE xrca_t.xrca113,
          xrca114          LIKE xrca_t.xrca114,
          xrca118          LIKE xrca_t.xrca118,
          xrca123          LIKE xrca_t.xrca123,
          xrca128          LIKE xrca_t.xrca124,
          xrca124          LIKE xrca_t.xrca128,
          xrca133          LIKE xrca_t.xrca133,
          xrca134          LIKE xrca_t.xrca134,
          xrca138          LIKE xrca_t.xrca138
                         END RECORD
   DEFINE l_oodbl004     LIKE oodbl_t.oodbl004
   DEFINE l_oodb011      LIKE oodb_t.oodb011
   DEFINE l_prog         LIKE gzza_t.gzza001
   DEFINE l_cnt          LIKE type_t.num5
   DEFINE l_s            LIKE type_t.chr1
   DEFINE l_xrca034      LIKE xrca_t.xrca034
   DEFINE l_xrca035      LIKE xrca_t.xrca035
   DEFINE l_xrca036      LIKE xrca_t.xrca036
   DEFINE l_xrcb005      LIKE xrcb_t.xrcb005
   DEFINE l_xrcb103      LIKE xrcb_t.xrcb103
   DEFINE l_xrcb105      LIKE xrcb_t.xrcb105
   
  # DEFINE t_xrcb         RECORD LIKE xrcb_t.* #161128-00061#3--mark
   DEFINE l_oodb005      LIKE oodb_t.oodb005
   DEFINE l_xmdlnum      LIKE xmdl_t.xmdl038
   DEFINE l_flag         LIKE type_t.chr1
   DEFINE l_xrcd009      LIKE xrcd_t.xrcd009
   DEFINE l_sfin2012     LIKE type_t.chr1
   DEFINE l_start_no     LIKE xrca_t.xrcadocno   #14/12/23
   DEFINE l_end_no       LIKE xrca_t.xrcadocno   #14/12/23
   DEFINE l_end_no_t     LIKE xrca_t.xrcadocno   #20150201  BY zhangwei
#   DEFINE l_amount       LIKE type_t.num5        #20150201  BY zhangwei    #170102-00002#1 mark
   DEFINE l_amount       LIKE xmdl_t.xmdl022                                #170102-00002#1 add
   DEFINE l_doc_success  LIKE type_t.num5        #20150201  BY zhangwei
   DEFINE l_tot_success  LIKE type_t.num5        #20150201  BY zhangwei
   DEFINE li_idx         LIKE type_t.num5        #20150201  BY zhangwei
   DEFINE l_xrcb002      LIKE xrcb_t.xrcb002     #20150201  BY zhangwei
   DEFINE l_xrcb003      LIKE xrcb_t.xrcb003     #20150201  BY zhangwei
   DEFINE l_xrcb007      LIKE xrcb_t.xrcb007     #20150201  BY zhangwei
   DEFINE l_dfin0030     LIKE type_t.chr1        #20150201  BY zhangwei
   DEFINE l_glaacomp     LIKE glaa_t.glaacomp    #150317-00001#3 Add
   DEFINE l_xmdl003      LIKE xmdl_t.xmdl003     #150317-00001#3 Add 
   #151125-00006#1----add--s
   DEFINE  l_slip_success   LIKE type_t.num5
   DEFINE  l_conf_success   LIKE type_t.num5
   DEFINE  l_dfin0031       LIKE type_t.chr1
   DEFINE  l_dfin0032       LIKE type_t.chr1
   DEFINE  l_gl_slip        LIKE ooba_t.ooba002 
   #151125-00006#1----add--e

   #STEP1.依照匯總條件將出貨單資料匯總、排序
   #STEP2.將資料插入xrca_t
   #STEP3.將出貨單資料插入xrcb_t、xrcd_t
   #STEP4.将单身金额回写至单头
   #STEP5.產生多帳期資料

   #160905-00031#1 Add  ---(S)---
   IF g_master.xmdk042 = '2' THEN
      LET g_master.xrcadocdt = g_master.xmdk032
   END IF
   #160905-00031#1 Add  ---(E)---

   CALL s_fin_get_doc_para(g_master.xrcald,g_glaa.glaacomp,g_master.xrcadocno,'D-FIN-0030') RETURNING l_dfin0030
   CALL s_axrt300_sel_ld(g_master.xrcald) RETURNING l_success,l_s
   CALL cl_get_para(g_enterprise,g_glaa.glaacomp,'S-FIN-1002') RETURNING l_flag
   SELECT glaacomp INTO l_glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_master.xrcald   #150317-00001#3 Add

  #20150201#1 By zhangwei Mark ---(S)---
  #CASE
  #   WHEN g_master.b_comb2 = '1'
  #      LET l_str   = "xmdldocno"
  #      LET l_orders= "xmdldocno"
  #   WHEN g_master.b_comb2 = '2'
  #      LET l_str   = "xmdk031||xmdk007||xmdk008||xmdk016||xmdk014"
  #      LET l_orders= "xmdk031,xmdk007,xmdk008,xmdk016,xmdk014"
  #      IF l_flag != '3' THEN
  #         LET l_str   = l_str,   "||xmdk010"
  #         LET l_orders= l_orders,",xmdk010"
  #      END IF
  #      IF g_master.b_comb1 = '1' THEN
  #         LET l_str   = l_str,   "||xmdk017"
  #         LET l_orders= l_orders,",xmdk017"
  #      END IF
  #   WHEN g_master.b_comb2 = '3'
  #      LET l_str   = "xmdk031||xmdk007||xmdk008||xmdk016||xmdk014||xmdk003"
  #      LET l_orders= "xmdk031,xmdk007,xmdk008,xmdk016,xmdk014,xmdk003"
  #      IF l_flag != '3' THEN
  #         LET l_str   = l_str,   "||xmdk010"
  #         LET l_orders= l_orders,",xmdk010"
  #      END IF
  #      IF g_master.b_comb1 = '1' THEN
  #         LET l_str   = l_str,   "||xmdk017"
  #         LET l_orders= l_orders,",xmdk017"
  #      END IF
  #   WHEN g_master.b_comb2 = '4'
  #      LET l_str   = "xmdk031||xmdk007||xmdk008||xmdk016||xmdk014||xmdk004"
  #      LET l_orders= "xmdk031,xmdk007,xmdk008,xmdk016,xmdk014,xmdk004"
  #      IF l_flag != '3' THEN
  #         LET l_str   = l_str,   "||xmdk010"
  #         LET l_orders= l_orders,",xmdk010"
  #      END IF
  #      IF g_master.b_comb1 = '1' THEN
  #         LET l_str   = l_str,   "||xmdk017"
  #         LET l_orders= l_orders,",xmdk017"
  #      END IF
  #END CASE
  #LET l_str = l_str,"||CASE WHEN xmdk000 = 6 THEN 2 ELSE 1 END"
  #LET l_orders= l_orders,",CASE WHEN xmdk000 = 6 THEN 2 ELSE 1 END"
  #
  #LET l_sql = "SELECT ",l_str,",xmdldocno,xmdlseq,xrcb007 FROM axrp133_xmdk_tmp",
  #            " ORDER BY xmdldocno,xmdlseq,",l_orders
  #PREPARE axrp133_ar_prep FROM l_sql
  #DECLARE axrp133_ar_curs CURSOR FOR axrp133_ar_prep
  #20150201#1 By zhangwei Mark ---(S)---

   #20150201#1   By zhangwei Add ---(S)---
   LET l_sql = "SELECT xmdkdocno,xmdkent FROM xmdk_t WHERE xmdkent = ? AND xmdkdocno = ? FOR UPDATE"
   LET l_sql = cl_sql_forupd(l_sql)                #轉換不同資料庫語法
   LET l_sql = cl_sql_add_mask(l_sql)              #遮蔽特定資料
   DECLARE axrp133_cl CURSOR FROM l_sql            # LOCK CURSOR

   CASE
      WHEN l_s = 1
       LET l_sql = "SELECT xmdl022 - xmdl038 FROM xmdl_t WHERE xmdlent = '",g_enterprise,"' AND xmdldocno = ? AND xmdlseq = ?"
      WHEN l_s = 2
       LET l_sql = "SELECT xmdl022 - xmdl039 FROM xmdl_t WHERE xmdlent = '",g_enterprise,"' AND xmdldocno = ? AND xmdlseq = ?"
      WHEN l_s = 3
       LET l_sql = "SELECT xmdl022 - xmdl040 FROM xmdl_t WHERE xmdlent = '",g_enterprise,"' AND xmdldocno = ? AND xmdlseq = ?"
   END CASE
   PREPARE axrp133_amount FROM l_sql

   LET l_sql = "SELECT xrcb002,xrcb003,xrcb007 FROM xrcb_t WHERE xrcbent = '",g_enterprise,"' AND xrcbld = '",g_master.xrcald,"' AND xrcbdocno = ?"
   PREPARE axrp133_bak_prep FROM l_sql
   DECLARE axrp133_bak_curs CURSOR FOR axrp133_bak_prep

   #20150201#1   By zhangwei Add ---(E)---

  #LET g_success = 'Y'   #20150201#1 By zhangwei Mark
   LET l_doc_success = TRUE   #20150201#1 By zhangwei Add
   LET l_tot_success = TRUE   #20150201#1 By zhangwei Add
   LET l_start_no = NULL   #20150201#1 By zhangwei Add
   LET l_end_no = NULL   #20150201#1 By zhangwei Add
   INITIALIZE g_xrca TO NULL
   INITIALIZE g_xrcb TO NULL

  #20150201#1 By zhangwei Mark ---(S)---
  #FOREACH axrp133_ar_curs INTO l_order,l_xmdldocno,l_xmdlseq,l_xrcb007
  #   IF SQLCA.sqlcode THEN
  #      INITIALIZE g_errparam TO NULL
  #      LET g_errparam.extend = 'foreach:'
  #      LET g_errparam.code   = SQLCA.sqlcode
  #      LET g_errparam.popup  = TRUE
  #      CALL cl_err()
  #      LET g_success = 'N'
  #      EXIT FOREACH
  #   END IF
  #20150201#1 By zhangwei Mark ---(E)---
   FOR li_idx = 1 TO g_xmdk_d.getLength()   #20150201#1 By zhangwei Add

      IF NOT cl_null(l_order_t) AND l_order_t <> g_xmdk_d[li_idx].order THEN
         #20150201#1 By zhangwei Add ---(S)---
         IF l_doc_success THEN
            IF cl_null(l_start_no) THEN
               LET l_start_no = g_xrca.xrcadocno
            END IF
            LET l_end_no = g_xrca.xrcadocno
            CLOSE axrp133_cl
            CALL s_transaction_end('Y',1)
         ELSE
            LET l_tot_success = FALSE
            CLOSE axrp133_cl
            CALL s_transaction_end('N',1)
         END IF
         LET l_doc_success = TRUE
         #20150201#1 By zhangwei Add ---(E)---
      END IF

      IF cl_null(l_order_t) OR l_order_t <> g_xmdk_d[li_idx].order THEN
      CALL s_transaction_begin()  #20150201#1   By zhangwei 每一筆資料單獨走一次事物
      END IF

      #20150201#1   By zhangwei Add ---(S)---
      OPEN axrp133_cl USING g_enterprise,g_xmdk_d[li_idx].xmdldocno
      IF STATUS THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "OPEN xmdk_cl:"   #20150201 ~~~
         LET g_errparam.code   =  STATUS 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()

         CLOSE axrp133_cl
         CALL s_transaction_end('N','0')
         CONTINUE FOR
      END IF

      LET l_amount = 0
      EXECUTE axrp133_amount USING g_xmdk_d[li_idx].xmdldocno,g_xmdk_d[li_idx].xmdlseq INTO l_amount
      IF cl_null(l_amount) THEN LET l_amount = 0 END IF
      IF l_amount = 0 THEN
         LET g_errparam.extend = "OPEN xmdk_cl:"   #20150201 ~~~
         LET g_errparam.code   =  STATUS 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()

         CALL s_transaction_end('N','0')
         CONTINUE FOR
      END IF
      #20150201#1   By zhangwei Add ---(S)---
 
      #161128-00061#3-----modify--begin----------
      #SELECT * INTO l_xmdk.* 
      SELECT xmdkent,xmdksite,xmdkunit,xmdkdocno,xmdkdocdt,xmdk000,xmdk001,xmdk002,xmdk003,xmdk004,
             xmdk005,xmdk006,xmdk007,xmdk008,xmdk009,xmdk010,xmdk011,xmdk012,xmdk013,xmdk014,xmdk015,
             xmdk016,xmdk017,xmdk018,xmdk019,xmdk020,xmdk021,xmdk022,xmdk023,xmdk024,xmdk025,xmdk026,
             xmdk027,xmdk028,xmdk029,xmdk030,xmdk031,xmdk032,xmdk033,xmdk034,xmdk035,xmdk036,xmdk037,
             xmdk038,xmdk039,xmdk040,xmdk041,xmdk042,xmdk043,xmdk044,xmdk045,xmdk051,xmdk052,xmdk053,
             xmdk054,xmdk055,xmdk081,xmdk082,xmdk083,xmdk084,xmdk200,xmdk201,xmdk202,xmdk203,xmdk204,
             xmdk205,xmdk206,xmdk207,xmdk208,xmdk209,xmdk210,xmdk211,xmdk212,xmdk213,xmdk214,xmdkownid,
             xmdkowndp,xmdkcrtid,xmdkcrtdp,xmdkcrtdt,xmdkmodid,xmdkmoddt,xmdkcnfid,xmdkcnfdt,xmdkpstid,
             xmdkpstdt,xmdkstus,xmdk085,xmdk086,xmdk046,xmdk087,xmdk047,xmdk088,xmdk089 INTO l_xmdk.* 
      #161128-00061#3-----modify--end----------
      FROM xmdk_t WHERE xmdkent = g_enterprise AND xmdkdocno = g_xmdk_d[li_idx].xmdldocno  #20150201#1 By zhangwei Mod l_xmdldocno ---> g_xmdk_d[li_idx].xmdldocno
      
      #161128-00061#3-----modify--begin----------
      #SELECT * INTO l_xmdl.* 
      SELECT xmdlent,xmdlsite,xmdldocno,xmdlseq,xmdl001,xmdl002,xmdl003,xmdl004,xmdl005,
             xmdl006,xmdl007,xmdl008,xmdl009,xmdl010,xmdl011,xmdl012,xmdl013,xmdl014,xmdl015,
             xmdl016,xmdl017,xmdl018,xmdl019,xmdl020,xmdl021,xmdl022,xmdl023,xmdl024,xmdl025,
             xmdl026,xmdl027,xmdl028,xmdl029,xmdl030,xmdl031,xmdl032,xmdl033,xmdl034,xmdl035,
             xmdl036,xmdl037,xmdl038,xmdl039,xmdl040,xmdl041,xmdl042,xmdl043,xmdl044,xmdl045,
             xmdl046,xmdl047,xmdl048,xmdl049,xmdl050,xmdl051,xmdl052,xmdl053,xmdl054,xmdl055,
             xmdl081,xmdl082,xmdl083,xmdl084,xmdl085,xmdl086,xmdl087,xmdl088,xmdl089,xmdl090,
             xmdl091,xmdl092,xmdl093,xmdl200,xmdl201,xmdl202,xmdl203,xmdl204,xmdl205,xmdl206,
             xmdl207,xmdl208,xmdl209,xmdl210,xmdl211,xmdl212,xmdl213,xmdl214,xmdl215,xmdl216,
             xmdl217,xmdl218,xmdl219,xmdl220,xmdl222,xmdl223,xmdl224,xmdl225,xmdl226,xmdlunit,
             xmdlorga,xmdl056,xmdl094,xmdl095,xmdl227,xmdl228,xmdl057,xmdl058,xmdl096,xmdl059,xmdl060 INTO l_xmdl.*
      #161128-00061#3-----modify--end----------   
      FROM xmdl_t WHERE xmdlent = g_enterprise AND xmdldocno = g_xmdk_d[li_idx].xmdldocno AND xmdlseq = g_xmdk_d[li_idx].xmdlseq   #20150201#1 By zhangwei Mod l_xmdldocno ---> g_xmdk_d[li_idx].xmdldocno   l_xmdlseq ---> g_xmdk_d[li_idx].xmdlseq

      IF cl_null(l_order_t) OR l_order_t <> g_xmdk_d[li_idx].order THEN   #20150201#1 By zhangwei Mod l_order ---> g_xmdk_d[li_idx].order
         CALL s_aooi200_fin_gen_docno(g_master.xrcald,g_glaa.glaa024,g_glaa.glaa003,g_master.xrcadocno,g_master.xrcadocdt,g_master.b_style)
            RETURNING l_success,l_xrcadocno
            IF NOT l_success THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = g_master.xrcadocno
               LET g_errparam.code   = 'aap-00187'
               LET g_errparam.popup  = TRUE
               CALL cl_err()
              #LET g_success = 'N'         #20150201#1 By zhangwei Mark
               LET l_doc_success = FALSE   #20150201#1 By zhangwei Add
            END IF
         IF g_master.b_style = 'axrt300' THEN
            LET l_prog = '11'
            LET l_xrca001 = '12'
         ELSE
            LET l_prog = '21'
            LET l_xrca001 = '22'
         END IF

         IF NOT cl_null(g_xrca.xrcadocno) THEN   #前一筆應收單據單身完全產生,繼續產生直接沖帳、多帳期，回寫應收單據單頭金額
            SELECT ABS(SUM(xrcb103 * xrcb022)),ABS(SUM(xrcb104 * xrcb022)),ABS(SUM(xrcb113 * xrcb022)),ABS(SUM(xrcb114 * xrcb022)),
                   ABS(SUM(xrcb123 * xrcb022)),ABS(SUM(xrcb124 * xrcb022)),ABS(SUM(xrcb133 * xrcb022)),ABS(SUM(xrcb134 * xrcb022)) 
              INTO g_xrca.xrca103,g_xrca.xrca104,g_xrca.xrca113,g_xrca.xrca114, 
                   g_xrca.xrca123,g_xrca.xrca124,g_xrca.xrca133,g_xrca.xrca134     
              FROM xrcb_t
             WHERE xrcbent = g_enterprise AND xrcbld = g_xrca.xrcald AND xrcbdocno = g_xrca.xrcadocno
            IF cl_null(g_xrca.xrca103) THEN LET g_xrca.xrca103 = 0 END IF 
            IF cl_null(g_xrca.xrca104) THEN LET g_xrca.xrca104 = 0 END IF 
            IF cl_null(g_xrca.xrca113) THEN LET g_xrca.xrca113 = 0 END IF 
            IF cl_null(g_xrca.xrca114) THEN LET g_xrca.xrca114 = 0 END IF
            IF cl_null(g_xrca.xrca123) THEN LET g_xrca.xrca123 = 0 END IF 
            IF cl_null(g_xrca.xrca124) THEN LET g_xrca.xrca124 = 0 END IF
            IF cl_null(g_xrca.xrca133) THEN LET g_xrca.xrca133 = 0 END IF 
            IF cl_null(g_xrca.xrca134) THEN LET g_xrca.xrca134 = 0 END IF
            UPDATE xrca_t SET (xrca103,xrca104,xrca113,xrca114,xrca123,xrca124,xrca133,xrca134) = (g_xrca.xrca103,g_xrca.xrca104,g_xrca.xrca113,g_xrca.xrca114,g_xrca.xrca123,g_xrca.xrca124,g_xrca.xrca133,g_xrca.xrca134) 
             WHERE xrcaent = g_enterprise AND xrcald = g_xrca.xrcald AND xrcadocno = g_xrca.xrcadocno
           #產生直接沖帳
            CALL axrp133_ins_xrce()

            #產生多帳期
            CALL s_axrt300_installments(g_xrca.xrcald,g_xrca.xrcadocno) RETURNING l_success
            IF NOT l_success THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = g_master.xrcadocno
               LET g_errparam.code   = 'aap-00092'
               LET g_errparam.popup  = TRUE
               CALL cl_err()
              #LET g_success = 'N'         #20150201#1 By zhangwei Mark
               LET l_doc_success = FALSE   #20150201#1 By zhangwei Add
            END IF
            IF g_glaa.glaa121 = 'Y' THEN
               CALL s_pre_voucher_ins('AR','R10',g_glaa.glaald,g_xrca.xrcadocno,g_xrca.xrcadocdt,'1') RETURNING l_success
               IF NOT l_success THEN
                 #LET g_success = 'N'         #20150201#1 By zhangwei Mark
                  LET l_doc_success = FALSE   #20150201#1 By zhangwei Add
               END IF
            END IF
            
            #20150422--add--str--lujh
            #INSERT INTO axrp133_success_tmp VALUES(g_xrca.xrcadocno,)
            #20150422--add--end--lujh
         END IF

         INITIALIZE g_xrca TO NULL

         LET g_xrca.xrcaent   = g_enterprise
         LET g_xrca.xrcaownid = g_user
         LET g_xrca.xrcaowndp = g_dept
         LET g_xrca.xrcacrtid = g_user
         LET g_xrca.xrcacrtdp = g_dept
         LET g_xrca.xrcacrtdt = g_today
         LET g_xrca.xrcastus  = 'N'
         LET g_xrca.xrcacomp  = g_glaa.glaacomp
         LET g_xrca.xrcald    = g_master.xrcald
         LET g_xrca.xrcadocno = l_xrcadocno
         LET g_xrca.xrcadocdt = g_master.xrcadocdt
         LET g_xrca.xrca001   = l_xrca001
         LET g_xrca.xrcasite  = g_master.xrcasite
         LET g_xrca.xrca003   = g_user
         LET g_xrca.xrca004   = l_xmdk.xmdk008
         CALL axrp133_xrca004_ref(l_xmdk.xmdk016) RETURNING l_xrca.*
         LET g_xrca.xrca005   = l_xrca.xrca005
         LET g_xrca.xrca006   = l_xrca.xrca006
         IF NOT cl_null(g_master.xrca007) THEN
            LET g_xrca.xrca007 = g_master.xrca007
         ELSE
            LET g_xrca.xrca007   = l_xrca.xrca007
         END IF

         SELECT glab005 INTO l_xrca035 FROM glab_t 
          WHERE glabld = g_master.xrcald 
            AND glabent = g_enterprise
            AND glab002 = g_xrca.xrca007   # 帳款類別
            AND glab001 = '13'             # 應收帳務類型科目設定
            AND glab003 = '8304_01'

         SELECT glab005 INTO l_xrca036 FROM glab_t 
          WHERE glabld = g_master.xrcald 
            AND glabent = g_enterprise
            AND glab002 = g_xrca.xrca007   # 帳款類別
            AND glab001 = '13'             # 應收帳務類型科目設定
            AND glab003 = '8304_21'

         SELECT glab005 INTO l_xrcd009 FROM glab_t 
          WHERE glabld = g_master.xrcald 
            AND glabent = g_enterprise
            AND glab002 = g_xrca.xrca007   # 帳款類別
            AND glab001 = '13'             # 應收帳務類型科目設定
            AND glab003 = '8304_29'

         SELECT ooeg004 INTO l_xrca034 FROM ooeg_t WHERE ooegent = g_enterprise AND ooeg001 = l_xrca.xrca015

         LET g_xrca.xrca008 = l_xmdk.xmdk010

         #應收日期/票據到期日
         CALL s_fin_date_ar_receivable(g_xrca.xrcasite,g_xrca.xrca004,g_xrca.xrca008,g_xrca.xrcadocdt,
           g_xrca.xrcadocdt,g_xrca.xrcadocdt,'') RETURNING l_success,g_xrca.xrca009,g_xrca.xrca010
   
         LET g_xrca.xrca011 = l_xmdk.xmdk012

         CALL s_tax_chk(g_glaa.glaacomp,g_xrca.xrca011)
            RETURNING l_success,l_oodbl004,l_xrca.xrca013,l_xrca.xrca012,l_oodb011
         IF NOT l_success THEN
           #LET g_success = 'N'         #20150201#1 By zhangwei Mark
            LET l_doc_success = FALSE   #20150201#1 By zhangwei Add
         END IF
         LET g_xrca.xrca012   = l_xrca.xrca012
         LET g_xrca.xrca013   = l_xrca.xrca013
        #150317-00001#3 Mark ---(S)---
         CASE
            WHEN g_master.b_comb2 = '1'
               LET g_xrca.xrca014   = l_xmdk.xmdk003
               LET g_xrca.xrca015   = l_xmdk.xmdk004
            WHEN g_master.b_comb2 = '2'
               LET g_xrca.xrca014   = l_xrca.xrca014
               LET g_xrca.xrca015   = l_xrca.xrca015
            WHEN g_master.b_comb2 = '3'
               LET g_xrca.xrca014   = l_xmdk.xmdk003
               LET g_xrca.xrca015   = l_xmdk.xmdk004
            WHEN g_master.b_comb2 = '4'
               LET g_xrca.xrca014   = l_xmdk.xmdk003
               LET g_xrca.xrca015   = l_xmdk.xmdk004
         END CASE
        #150317-00001#3 Mark ---(E)---
        #150317-00001#3 Add  ---(S)---
        #SELECT pmab081,pmab109 INTO g_xrca.xrca014,g_xrca.xrca015 FROM pmab_t
        # WHERE pmabent = g_enterprise
        #   AND pmab001 = l_xmdk.xmdk007
        #   AND pmabsite = l_glaacomp
        #SELECT xmdl003 INTO l_xmdl003 FROM xmdl_t WHERE xmdlent = g_enterprise
        #   AND xmdldocno = l_xmdk.xmdkdocno
        #   AND xmdlseq = l_xmdl.xmdlseq
        #CASE
        #   WHEN g_master.b_comb2 = '3'   #依業務人員匯總
        #      SELECT xmda002 INTO g_xrca.xrca014
        #        FROM xmda_t WHERE xmdaent = g_enterprise AND xmdadocno = l_xmdl003
        #   WHEN g_master.b_comb2 = '4'   #依業務部門匯總
        #      SELECT xmda003 INTO g_xrca.xrca015
        #        FROM xmda_t WHERE xmdaent = g_enterprise AND xmdadocno = l_xmdl003
        #END CASE
        #150317-00001#3 Add  ---(E)---

         LET g_xrca.xrca016   = l_prog
         LET g_xrca.xrca017   = 0
         IF g_master.b_comb2 = '1' THEN
            LET g_xrca.xrca018   = l_xmdk.xmdkdocno
         ELSE
            LET g_xrca.xrca018   = ''
         END IF
         LET g_xrca.xrca019   = ''
         LET g_xrca.xrca020   = 'N'
         LET g_xrca.xrca021   = ''
         LET g_xrca.xrca022   = ''
         LET g_xrca.xrca023   = ''
         LET g_xrca.xrca024   = ''
         LET g_xrca.xrca025   = ''
         LET g_xrca.xrca026   = ''
         LET g_xrca.xrca028   = ''
         LET g_xrca.xrca029   = ''
         LET g_xrca.xrca030   = 0
         LET g_xrca.xrca031   = 0
         LET g_xrca.xrca032   = 0
         LET g_xrca.xrca033   = ''
         LET g_xrca.xrca034   = l_xrca034
         LET g_xrca.xrca035   = l_xrca035
         LET g_xrca.xrca036   = l_xrca036
         CALL s_aooi200_fin_get_slip(g_master.xrcadocno) RETURNING l_success,l_ooba002
         CALL s_fin_get_doc_para(g_xrca.xrcald,g_xrca.xrcacomp,l_ooba002,'D-FIN-0030') RETURNING g_xrca.xrca037
         IF cl_null(g_xrca.xrca037) THEN LET g_xrca.xrca037   = 'N' END IF
         LET g_xrca.xrca038   = ''
         LET g_xrca.xrca039   = 0
         LET g_xrca.xrca040   = 'N'
         LET g_xrca.xrca041   = ''
         LET g_xrca.xrca042   = ''
         LET g_xrca.xrca043   = ''
         LET g_xrca.xrca044   = 0
         LET g_xrca.xrca045   = ''
         LET g_xrca.xrca046   = l_xrca.xrca046
         LET g_xrca.xrca047   = ''
         LET g_xrca.xrca048   = ''
         LET g_xrca.xrca049   = ''
         LET g_xrca.xrca050   = ''
         LET g_xrca.xrca051   = ''
         LET g_xrca.xrca052   = 0
         LET g_xrca.xrca053   = ''
         CALL cl_get_para(g_enterprise,g_glaa.glaacomp,'S-FIN-2012') RETURNING l_sfin2012
         IF l_sfin2012 <> 1 THEN
            SELECT ooib025 INTO g_xrca.xrca054 FROM ooib_t WHERE ooibent = g_enterprise
               AND ooib002 = g_xrca.xrca008
         END IF
         LET g_xrca.xrca055   = ''
         LET g_xrca.xrca056   = ''
         LET g_xrca.xrca057   = ''
         LET g_xrca.xrca058   = l_xmdk.xmdk031
         LET g_xrca.xrca059   = ''
         LET g_xrca.xrca060   = 1
         LET g_xrca.xrca061   = l_xrca.xrca061
         LET g_xrca.xrca062   = '1'
         LET g_xrca.xrca063   = ''
         LET g_xrca.xrca100   = l_xmdk.xmdk016
         IF g_master.b_comb1 = 1 THEN
            LET g_xrca.xrca101 = l_xmdk.xmdk017
         ELSE
            LET g_xrca.xrca101 = l_xrca.xrca101
         END IF
         #151012-00014#1--mark--str--lujh
         #CASE g_master.b_comb1
         #   WHEN '2'  #依立帳日匯率(aooi160)
         #       CALL s_aooi160_get_exrate('2',g_master.xrcald,g_xrca.xrcadocdt,g_xrca.xrca100,g_glaa.glaa001,0,g_glaa.glaa025)
         #            RETURNING g_xrca.xrca101
         #   WHEN '3'  #依立帳日月平均匯率(aooi170)
         #       CALL s_aooi160_get_exrate_avg('2',g_master.xrcald,g_xrca.xrcadocdt,g_xrca.xrca100,g_glaa.glaa001,0,g_glaa.glaa025)
         #            RETURNING g_sub_success,g_errno,g_xrca.xrca101
         #END CASE
         #151012-00014#1--mark--end--lujh

         LET g_xrca.xrca103   = 0
         LET g_xrca.xrca104   = 0
         LET g_xrca.xrca106   = 0
         LET g_xrca.xrca107   = 0
         LET g_xrca.xrca108   = 0
         LET g_xrca.xrca113   = 0
         LET g_xrca.xrca114   = 0
         LET g_xrca.xrca116   = 0
         LET g_xrca.xrca117   = 0
         LET g_xrca.xrca118   = 0
         LET g_xrca.xrca120   = g_glaa.glaa016
         LET g_xrca.xrca121   = l_xrca.xrca121
         LET g_xrca.xrca123   = 0
         LET g_xrca.xrca124   = 0
         LET g_xrca.xrca126   = 0
         LET g_xrca.xrca127   = 0
         LET g_xrca.xrca128   = 0
         LET g_xrca.xrca130   = g_glaa.glaa020
         LET g_xrca.xrca131   = l_xrca.xrca131
         LET g_xrca.xrca133   = 0
         LET g_xrca.xrca134   = 0
         LET g_xrca.xrca136   = 0
         LET g_xrca.xrca137   = 0
         LET g_xrca.xrca138   = 0

        #20150201#1 By zhangwei Mark ---(S)---
        ##14/12/23
        #IF cl_null(l_start_no) THEN
        #   LET l_start_no = g_xrca.xrcadocno
        #END IF
        #LET l_end_no = g_xrca.xrcadocno
        ##14/12/23
        #20150201#1 By zhangwei Mark ---(E)---

        #161128-00061#3-----modify--begin----------
        #INSERT INTO xrca_t VALUES (g_xrca.*)
        INSERT INTO xrca_t (xrcaent,xrcaownid,xrcaowndp,xrcacrtid,xrcacrtdp,xrcacrtdt,xrcamodid,xrcamoddt,
                            xrcacnfid,xrcacnfdt,xrcapstid,xrcapstdt,xrcastus,xrcacomp,xrcald,xrcadocno,
                            xrcadocdt,xrca001,xrcasite,xrca003,xrca004,xrca005,xrca006,xrca007,xrca008,
                            xrca009,xrca010,xrca011,xrca012,xrca013,xrca014,xrca015,xrca016,xrca017,
                            xrca018,xrca019,xrca020,xrca021,xrca022,xrca023,xrca024,xrca025,xrca026,
                            xrca028,xrca029,xrca030,xrca031,xrca032,xrca033,xrca034,xrca035,xrca036,
                            xrca037,xrca038,xrca039,xrca040,xrca041,xrca042,xrca043,xrca044,xrca045,
                            xrca046,xrca047,xrca048,xrca049,xrca050,xrca051,xrca052,xrca053,xrca054,
                            xrca055,xrca056,xrca057,xrca058,xrca059,xrca060,xrca061,xrca062,xrca063,
                            xrca064,xrca065,xrca066,xrca100,xrca101,xrca103,xrca104,xrca106,xrca107,
                            xrca108,xrca113,xrca114,xrca116,xrca117,xrca118,xrca120,xrca121,xrca123,
                            xrca124,xrca126,xrca127,xrca128,xrca130,xrca131,xrca133,xrca134,xrca136,
                            xrca137,xrca138)
         VALUES (g_xrca.xrcaent,g_xrca.xrcaownid,g_xrca.xrcaowndp,g_xrca.xrcacrtid,g_xrca.xrcacrtdp,g_xrca.xrcacrtdt,g_xrca.xrcamodid,g_xrca.xrcamoddt,
                 g_xrca.xrcacnfid,g_xrca.xrcacnfdt,g_xrca.xrcapstid,g_xrca.xrcapstdt,g_xrca.xrcastus,g_xrca.xrcacomp,g_xrca.xrcald,g_xrca.xrcadocno,
                 g_xrca.xrcadocdt,g_xrca.xrca001,g_xrca.xrcasite,g_xrca.xrca003,g_xrca.xrca004,g_xrca.xrca005,g_xrca.xrca006,g_xrca.xrca007,g_xrca.xrca008,
                 g_xrca.xrca009,g_xrca.xrca010,g_xrca.xrca011,g_xrca.xrca012,g_xrca.xrca013,g_xrca.xrca014,g_xrca.xrca015,g_xrca.xrca016,g_xrca.xrca017,
                 g_xrca.xrca018,g_xrca.xrca019,g_xrca.xrca020,g_xrca.xrca021,g_xrca.xrca022,g_xrca.xrca023,g_xrca.xrca024,g_xrca.xrca025,g_xrca.xrca026,
                 g_xrca.xrca028,g_xrca.xrca029,g_xrca.xrca030,g_xrca.xrca031,g_xrca.xrca032,g_xrca.xrca033,g_xrca.xrca034,g_xrca.xrca035,g_xrca.xrca036,
                 g_xrca.xrca037,g_xrca.xrca038,g_xrca.xrca039,g_xrca.xrca040,g_xrca.xrca041,g_xrca.xrca042,g_xrca.xrca043,g_xrca.xrca044,g_xrca.xrca045,
                 g_xrca.xrca046,g_xrca.xrca047,g_xrca.xrca048,g_xrca.xrca049,g_xrca.xrca050,g_xrca.xrca051,g_xrca.xrca052,g_xrca.xrca053,g_xrca.xrca054,
                 g_xrca.xrca055,g_xrca.xrca056,g_xrca.xrca057,g_xrca.xrca058,g_xrca.xrca059,g_xrca.xrca060,g_xrca.xrca061,g_xrca.xrca062,g_xrca.xrca063,
                 g_xrca.xrca064,g_xrca.xrca065,g_xrca.xrca066,g_xrca.xrca100,g_xrca.xrca101,g_xrca.xrca103,g_xrca.xrca104,g_xrca.xrca106,g_xrca.xrca107,
                 g_xrca.xrca108,g_xrca.xrca113,g_xrca.xrca114,g_xrca.xrca116,g_xrca.xrca117,g_xrca.xrca118,g_xrca.xrca120,g_xrca.xrca121,g_xrca.xrca123,
                 g_xrca.xrca124,g_xrca.xrca126,g_xrca.xrca127,g_xrca.xrca128,g_xrca.xrca130,g_xrca.xrca131,g_xrca.xrca133,g_xrca.xrca134,g_xrca.xrca136,
                 g_xrca.xrca137,g_xrca.xrca138)
        #161128-00061#3-----modify--end----------
         IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = g_master.xrcadocno
            LET g_errparam.code   = 'aap-00187'
            LET g_errparam.popup  = TRUE
            CALL cl_err()
           #LET g_success = 'N'         #20150201#1 By zhangwei Mark
            LET l_doc_success = FALSE   #20150201#1 By zhangwei Add
         END IF

         LET g_xrcb.xrcbseq = 0

      END IF

     #150828-00001#2 Mark ---(S)---
     #SELECT imaal003 INTO l_xrcb005 FROM imaal_t
     # WHERE imaalent = g_enterprise AND imaal002 = g_lang
     #   AND imaal001 = l_xmdl.xmdl008
     #150828-00001#2 Mark ---(E)---

      CALL s_axrt300_get_xrcb005(l_xmdl.xmdl008) RETURNING l_xrcb005   #150828-00001#2 Add

      SELECT xmdk000 INTO l_xmdk000 FROM xmdk_t WHERE xmdkent = g_enterprise
         AND xmdkdocno = g_xmdk_d[li_idx].xmdldocno ##20150201#1 By zhangwei Mod l_xmdldocno ---> g_xmdk_d[li_idx].xmdldocno
      IF l_xmdk000 = '6' THEN
         LET l_prog = '21'
      ELSE
         LET l_prog = '11'
      END IF

      LET g_xrcb.xrcbent = g_enterprise
      LET g_xrcb.xrcbld  = g_master.xrcald
      LET g_xrcb.xrcbdocno = g_xrca.xrcadocno
      LET g_xrcb.xrcbseq = g_xrcb.xrcbseq + 1
      LET g_xrcb.xrcbsite= g_master.xrcasite
      LET g_xrcb.xrcborga=l_xmdk.xmdksite
      LET g_xrcb.xrcb001 = l_prog
      LET g_xrcb.xrcb002 = l_xmdl.xmdldocno
      LET g_xrcb.xrcb003 = l_xmdl.xmdlseq
      LET g_xrcb.xrcb004 = l_xmdl.xmdl008
      LET g_xrcb.xrcb005 = l_xrcb005
      LET g_xrcb.xrcb006 = l_xmdl.xmdl017
      LET g_xrcb.xrcb007 = g_xmdk_d[li_idx].xrcb007   #20150201#1 By zhangwei Mod l_xrcb007 ---> g_xmdk_d[li_idx].xrcb007
      LET g_xrcb.xrcb008 = l_xmdl.xmdl003
      LET g_xrcb.xrcb009 = l_xmdl.xmdl004
      LET g_xrcb.xrcblegl= g_xrca.xrcacomp
      LET g_xrcb.xrcb051 = l_xmdk.xmdk003   #150317-00001#3   Mark
      LET g_xrcb.xrcb010 = l_xmdk.xmdk004   #150317-00001#3   Mark
     #150317-00001#3 Add  ---(S)---
     #LET g_xrcb.xrcb051 = NULL
     #LET g_xrcb.xrcb010 = NULL
     #SELECT xmda002,xmda003 INTO g_xrcb.xrcb051,g_xrcb.xrcb010
     #  FROM xmda_t WHERE xmdaent = g_enterprise AND xmdadocno = l_xmdl.xmdl003
     #IF cl_null(g_xrcb.xrcb051) THEN
     #   LET g_xrcb.xrcb051 = l_xmdk.xmdk003
     #END IF
     #IF cl_null(g_xrcb.xrcb010) THEN
     #   LET g_xrcb.xrcb010 = l_xmdk.xmdk004
     #END IF
     #150317-00001#3 Add  ---(E)---
      LET g_xrcb.xrcb011 = g_xrca.xrca034
      SELECT imaa009 INTO g_xrcb.xrcb012 FROM imaa_t WHERE imaaent = g_enterprise
       AND imaa001 = g_xrcb.xrcb004
      LET g_xrcb.xrcb013 = ''
      LET g_xrcb.xrcb014 = ''
      LET g_xrcb.xrcb015 = ''
      LET g_xrcb.xrcb016 = ''
      LET g_xrcb.xrcb017 = ''
      LET g_xrcb.xrcb018 = ''
      LET g_xrcb.xrcb019 = ''
      LET g_xrcb.xrcb020 = l_xmdl.xmdl025
     #IF NOT cl_null(g_master.xrca011) THEN
     #   LET g_xrcb.xrcb020 = g_master.xrca011
     #END IF
      #150807-00010#1
     #IF l_xmdk.xmdk082 = '4' THEN                          #151013-00019#7 mark
      IF l_xmdk.xmdk082 = '1' OR l_xmdk.xmdk082 = '4' THEN  #151013-00019#7
         CALL s_fin_dept_reasons_with_ld_get_account(l_xmdk.xmdk004,'310',l_xmdl.xmdl050,g_xrca.xrcald,'@2@11',g_xrca.xrcadocdt)
              RETURNING g_sub_success,g_xrcb.xrcb021,g_errno
         IF cl_null(g_xrcb.xrcb021) THEN
            CALL s_fin_get_account(g_xrca.xrcald,'13',g_xrca.xrca007,'8304_04') RETURNING g_sub_success,g_xrcb.xrcb021,g_errno
         END IF
      END IF
      #150807-00010#1
      IF cl_null(g_xrcb.xrcb021) THEN  #150807-00010#1
         CALL s_axrt300_item_acc(g_xrca.xrcald,g_xrcb.xrcbdocno,g_xrcb.xrcbseq,g_xrca.xrca036,g_xrcb.xrcb004)   #160120-00011#3 add g_xrcb.xrcbdocno,g_xrcb.xrcbseq lujh
            RETURNING g_xrcb.xrcb021
      END IF                           #150807-00010#1
      IF l_prog = '11' THEN LET g_xrcb.xrcb022 = 1 ELSE LET g_xrcb.xrcb022 =-1 END IF
      LET g_xrcb.xrcb024 = ''
      LET g_xrcb.xrcb025 = ''
      LET g_xrcb.xrcb026 = ''
      LET g_xrcb.xrcb027 = l_xmdl.xmdl048
      LET g_xrcb.xrcb028 = l_xmdl.xmdl049
      LET g_xrcb.xrcb029 = g_xrca.xrca035
      LET g_xrcb.xrcb030 = 0
      LET g_xrcb.xrcb031 = l_xmdk.xmdk010
      IF cl_null(g_xrcb.xrcb031) THEN
         LET g_xrcb.xrcb031 = g_xrca.xrca008
      END IF
      LET g_xrcb.xrcb100 = g_xrca.xrca100
      LET g_xrcb.xrcb101 = l_xmdl.xmdl024
      CALL s_axrt300_exrate(g_glaa.glaa002,g_xrca.xrcadocdt,g_xrca.xrca100,g_glaa.glaa001,g_xrcb.xrcb101,g_xrca.xrca101,g_glaa.glaacomp)
         RETURNING l_success,g_xrcb.xrcb111
      CALL s_tax_ins(g_xrca.xrcadocno,g_xrcb.xrcbseq,0,g_glaa.glaacomp,
                     g_xrcb.xrcb101 * g_xrcb.xrcb007,g_xrcb.xrcb020,
                     g_xrcb.xrcb007,g_xrcb.xrcb100,g_xrca.xrca101,g_xrca.xrcald,g_xrca.xrca121,g_xrca.xrca131)
         RETURNING g_xrcb.xrcb103,g_xrcb.xrcb104,g_xrcb.xrcb105,
                   g_xrcb.xrcb113,g_xrcb.xrcb114,g_xrcb.xrcb115,
                   g_xrcb.xrcb123,g_xrcb.xrcb124,g_xrcb.xrcb125,
                   g_xrcb.xrcb133,g_xrcb.xrcb134,g_xrcb.xrcb135
      UPDATE xrcd_t SET xrcd009 = l_xrcd009
       WHERE xrcd009 IS NULL
         AND xrcdent = g_enterprise
         AND xrcddocno = g_xrca.xrcadocno
         AND xrcdld = g_xrca.xrcald
      CALL s_tax_chk(g_glaa.glaacomp,g_xrcb.xrcb020)
         RETURNING l_success,l_oodbl004,l_oodb005,l_xrca.xrca012,l_oodb011
      IF NOT l_success THEN
        #LET g_success = 'N'         #20150201#1 By zhangwei Mark
         LET l_doc_success = FALSE   #20150201#1 By zhangwei Add
      END IF
      IF l_oodb005 = 'Y' THEN
         LET g_xrcb.xrcb113 = g_xrcb.xrcb115 - g_xrcb.xrcb114
         LET g_xrcb.xrcb123 = g_xrcb.xrcb125 - g_xrcb.xrcb124
         LET g_xrcb.xrcb133 = g_xrcb.xrcb135 - g_xrcb.xrcb134
      ELSE
         LET g_xrcb.xrcb115 = g_xrcb.xrcb113 + g_xrcb.xrcb114
         LET g_xrcb.xrcb125 = g_xrcb.xrcb123 + g_xrcb.xrcb124
         LET g_xrcb.xrcb135 = g_xrcb.xrcb133 + g_xrcb.xrcb134
      END IF
      LET g_xrcb.xrcb106 = 0
      LET g_xrcb.xrcb116 = 0
      LET g_xrcb.xrcb117 = 0
      LET g_xrcb.xrcb118 = g_xrcb.xrcb113
      LET g_xrcb.xrcb119 = g_xrcb.xrcb115
      LET g_xrcb.xrcb126 = 0
      LET g_xrcb.xrcb136 = 0

     #150515-00013#3 Add  ---(S)---
      IF g_xrca.xrca100 = g_glaa.glaa001 THEN
         LET g_xrcb.xrcb113 = g_xrcb.xrcb103
         LET g_xrcb.xrcb114 = g_xrcb.xrcb104
         LET g_xrcb.xrcb115 = g_xrcb.xrcb105
         UPDATE xrcd_t SET xrcd113 = xrcd103,
                           xrcd114 = xrcd104,
                           xrcd115 = xrcd105
          WHERE xrcdent = g_enterprise
            AND xrcddocno = g_xrca.xrcadocno
            AND xrcdld = g_xrca.xrcald
      END IF
     #150515-00013#3 Add  ---(E)---
      LET g_xrcb.xrcb034 = l_xmdk.xmdk030 #161025-00017#1 add
      #161128-00061#3-----modify--begin----------
      #INSERT INTO xrcb_t VALUES (g_xrcb.*)
      INSERT INTO xrcb_t (xrcbent,xrcbld,xrcbdocno,xrcbseq,xrcbsite,xrcborga,xrcb001,xrcb002,xrcb003,xrcb004,
                         xrcb005,xrcb006,xrcb007,xrcb008,xrcb009,xrcblegl,xrcb010,xrcb011,xrcb012,xrcb013,
                         xrcb014,xrcb015,xrcb016,xrcb017,xrcb018,xrcb019,xrcb020,xrcb021,xrcb022,xrcb023,
                         xrcb024,xrcb025,xrcb026,xrcb027,xrcb028,xrcb029,xrcb030,xrcb031,xrcb032,xrcb033,
                         xrcb034,xrcb035,xrcb036,xrcb037,xrcb038,xrcb039,xrcb040,xrcb041,xrcb042,xrcb043,
                         xrcb044,xrcb045,xrcb046,xrcb047,xrcb048,xrcb049,xrcb050,xrcb051,xrcb100,xrcb101,
                         xrcb102,xrcb103,xrcb104,xrcb105,xrcb106,xrcb111,xrcb113,xrcb114,xrcb115,xrcb116,
                         xrcb117,xrcb118,xrcb119,xrcb121,xrcb123,xrcb124,xrcb125,xrcb126,xrcb131,xrcb133,
                         xrcb134,xrcb135,xrcb136,xrcb052,xrcb053,xrcb054,xrcb055,xrcb056,xrcb057,xrcb058,
                         xrcb059,xrcb060,xrcb107)
      VALUES (g_xrcb.xrcbent,g_xrcb.xrcbld,g_xrcb.xrcbdocno,g_xrcb.xrcbseq,g_xrcb.xrcbsite,g_xrcb.xrcborga,g_xrcb.xrcb001,g_xrcb.xrcb002,g_xrcb.xrcb003,g_xrcb.xrcb004,
              g_xrcb.xrcb005,g_xrcb.xrcb006,g_xrcb.xrcb007,g_xrcb.xrcb008,g_xrcb.xrcb009,g_xrcb.xrcblegl,g_xrcb.xrcb010,g_xrcb.xrcb011,g_xrcb.xrcb012,g_xrcb.xrcb013,
              g_xrcb.xrcb014,g_xrcb.xrcb015,g_xrcb.xrcb016,g_xrcb.xrcb017,g_xrcb.xrcb018,g_xrcb.xrcb019,g_xrcb.xrcb020,g_xrcb.xrcb021,g_xrcb.xrcb022,g_xrcb.xrcb023,
              g_xrcb.xrcb024,g_xrcb.xrcb025,g_xrcb.xrcb026,g_xrcb.xrcb027,g_xrcb.xrcb028,g_xrcb.xrcb029,g_xrcb.xrcb030,g_xrcb.xrcb031,g_xrcb.xrcb032,g_xrcb.xrcb033,
              g_xrcb.xrcb034,g_xrcb.xrcb035,g_xrcb.xrcb036,g_xrcb.xrcb037,g_xrcb.xrcb038,g_xrcb.xrcb039,g_xrcb.xrcb040,g_xrcb.xrcb041,g_xrcb.xrcb042,g_xrcb.xrcb043,
              g_xrcb.xrcb044,g_xrcb.xrcb045,g_xrcb.xrcb046,g_xrcb.xrcb047,g_xrcb.xrcb048,g_xrcb.xrcb049,g_xrcb.xrcb050,g_xrcb.xrcb051,g_xrcb.xrcb100,g_xrcb.xrcb101,
              g_xrcb.xrcb102,g_xrcb.xrcb103,g_xrcb.xrcb104,g_xrcb.xrcb105,g_xrcb.xrcb106,g_xrcb.xrcb111,g_xrcb.xrcb113,g_xrcb.xrcb114,g_xrcb.xrcb115,g_xrcb.xrcb116,
              g_xrcb.xrcb117,g_xrcb.xrcb118,g_xrcb.xrcb119,g_xrcb.xrcb121,g_xrcb.xrcb123,g_xrcb.xrcb124,g_xrcb.xrcb125,g_xrcb.xrcb126,g_xrcb.xrcb131,g_xrcb.xrcb133,
              g_xrcb.xrcb134,g_xrcb.xrcb135,g_xrcb.xrcb136,g_xrcb.xrcb052,g_xrcb.xrcb053,g_xrcb.xrcb054,g_xrcb.xrcb055,g_xrcb.xrcb056,g_xrcb.xrcb057,g_xrcb.xrcb058,
              g_xrcb.xrcb059,g_xrcb.xrcb060,g_xrcb.xrcb107)
     #161128-00061#3-----modify--end----------
      IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = g_master.xrcadocno
         LET g_errparam.code   = 'aap-00187'
         LET g_errparam.popup  = TRUE
         CALL cl_err()
        #LET g_success = 'N'         #20150201#1 By zhangwei Mark
         LET l_doc_success = FALSE   #20150201#1 By zhangwei Add
      END IF
      CALL s_axrp130_ins_xrcf(g_xrcb.xrcbld,g_xrcb.xrcbdocno,g_xrcb.xrcbseq,'Y') RETURNING g_xrcb.xrcb023
      UPDATE xrcb_t SET xrcb023 = g_xrcb.xrcb023
       WHERE xrcbent = g_enterprise
         AND xrcbld = g_xrcb.xrcbld
         AND xrcbdocno = g_xrcb.xrcbdocno
      LET l_xrcb103 = l_xrcb103 - g_xrcb.xrcb103
      LET l_xrcb105 = l_xrcb105 - g_xrcb.xrcb105
      CASE
         WHEN l_s = '1'
            SELECT xmdl038 INTO l_xmdlnum FROM xmdl_t
             WHERE xmdldocno = g_xrcb.xrcb002
               AND xmdlseq = g_xrcb.xrcb003
               AND xmdlent = g_enterprise
               
            IF cl_null(l_xmdlnum) THEN LET l_xmdlnum=0 END IF
            UPDATE xmdl_t SET xmdl038 = l_xmdlnum + g_xrcb.xrcb007
             WHERE xmdldocno = g_xrcb.xrcb002
               AND xmdlseq = g_xrcb.xrcb003
               AND xmdlent = g_enterprise
         WHEN l_s = '2'
            SELECT xmdl039 INTO l_xmdlnum FROM xmdl_t
             WHERE xmdldocno = g_xrcb.xrcb002
               AND xmdlseq = g_xrcb.xrcb003
               AND xmdlent = g_enterprise
               
            IF cl_null(l_xmdlnum) THEN LET l_xmdlnum=0 END IF
            UPDATE xmdl_t SET xmdl039 = l_xmdlnum + g_xrcb.xrcb007
             WHERE xmdldocno = g_xrcb.xrcb002
               AND xmdlseq = g_xrcb.xrcb003
               AND xmdlent = g_enterprise
         WHEN l_s = '3'
            SELECT xmdl040 INTO l_xmdlnum FROM xmdl_t
             WHERE xmdldocno = g_xrcb.xrcb002
               AND xmdlseq = g_xrcb.xrcb003
               AND xmdlent = g_enterprise
               
            IF cl_null(l_xmdlnum) THEN LET l_xmdlnum=0 END IF
            UPDATE xmdl_t SET xmdl040 = l_xmdlnum + g_xrcb.xrcb007
             WHERE xmdldocno = g_xrcb.xrcb002
               AND xmdlseq = g_xrcb.xrcb003
               AND xmdlent = g_enterprise
      END CASE
      LET l_order_t = g_xmdk_d[li_idx].order   #20150201#1 By zhangwei Mod l_order --->g_xmdk_d[li_idx].order

      #20150201#1 By zhangwei Add ---(S)---
     #IF l_doc_success THEN
     #   IF cl_null(l_start_no) THEN
     #      LET l_start_no = g_xrca.xrcadocno
     #   END IF
     #   LET l_end_no = g_xrca.xrcadocno
     #   CLOSE axrp133_cl
     #   CALL s_transaction_end('Y',1)
     #ELSE
     #   LET l_tot_success = FALSE
     #   CLOSE axrp133_cl
     #   CALL s_transaction_end('N',1)
     #END IF
     #LET l_doc_success = TRUE
      #20150201#1 By zhangwei Add ---(E)---

   END FOR   #20150201#1 BY zhangwei Mod FOREACH ---> FOR

   #因為是換成了FOREACH中單筆資料走事物,所以最後一筆的產生多帳期會寫彈頭失敗的話,需要删除已经commit的資料
  #IF l_doc_success THEN   #20150201#1 By zhangwei Add
  #   CALL s_transaction_begin()  #20150201#1   By zhangwei Add
      LET l_cnt = 0 
      SELECT COUNT(*) INTO l_cnt FROM xrcb_t
       WHERE xrcbent = g_enterprise AND xrcbld = g_xrca.xrcald AND xrcbdocno = g_xrca.xrcadocno 
      IF l_cnt > 0 THEN  
         SELECT ABS(SUM(xrcb103 * xrcb022)),ABS(SUM(xrcb104 * xrcb022)),ABS(SUM(xrcb113 * xrcb022)),ABS(SUM(xrcb114 * xrcb022)),
                ABS(SUM(xrcb123 * xrcb022)),ABS(SUM(xrcb124 * xrcb022)),ABS(SUM(xrcb133 * xrcb022)),ABS(SUM(xrcb134 * xrcb022))  
           INTO g_xrca.xrca103,g_xrca.xrca104,g_xrca.xrca113,g_xrca.xrca114, 
                g_xrca.xrca123,g_xrca.xrca124,g_xrca.xrca133,g_xrca.xrca134     
           FROM xrcb_t
          WHERE xrcbent = g_enterprise AND xrcbld = g_xrca.xrcald AND xrcbdocno = g_xrca.xrcadocno
         IF cl_null(g_xrca.xrca103) THEN LET g_xrca.xrca103 = 0 END IF 
         IF cl_null(g_xrca.xrca104) THEN LET g_xrca.xrca104 = 0 END IF 
         IF cl_null(g_xrca.xrca113) THEN LET g_xrca.xrca113 = 0 END IF 
         IF cl_null(g_xrca.xrca114) THEN LET g_xrca.xrca114 = 0 END IF
         IF cl_null(g_xrca.xrca123) THEN LET g_xrca.xrca123 = 0 END IF 
         IF cl_null(g_xrca.xrca124) THEN LET g_xrca.xrca124 = 0 END IF
         IF cl_null(g_xrca.xrca133) THEN LET g_xrca.xrca133 = 0 END IF 
         IF cl_null(g_xrca.xrca134) THEN LET g_xrca.xrca134 = 0 END IF
         UPDATE xrca_t SET (xrca103,xrca104,xrca113,xrca114,xrca123,xrca124,xrca133,xrca134) = (g_xrca.xrca103,g_xrca.xrca104,g_xrca.xrca113,g_xrca.xrca114,g_xrca.xrca123,g_xrca.xrca124,g_xrca.xrca133,g_xrca.xrca134) 
          WHERE xrcaent = g_enterprise AND xrcald = g_xrca.xrcald AND xrcadocno = g_xrca.xrcadocno
         IF SQLCA.SQLCODE THEN
           #LEt g_success = 'N'         #20150201#1 By zhangwei Mark
            LET l_doc_success = FALSE   #20150201#1 By zhangwei Add
         END IF
         CALL axrp133_ins_xrce()
         CALL s_axrt300_installments(g_xrca.xrcald,g_xrca.xrcadocno) RETURNING l_success 
         IF NOT l_success THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = g_master.xrcadocno
            LET g_errparam.code   = 'aap-00187'
            LET g_errparam.popup  = TRUE
            CALL cl_err()
           #LET g_success = 'N'         #20150201#1 By zhangwei Mark
            LET l_doc_success = FALSE   #20150201#1 By zhangwei Add
         END IF
      END IF
      IF g_glaa.glaa121 = 'Y' AND l_dfin0030 = 'Y' THEN
         CALL s_pre_voucher_ins('AR','R10',g_glaa.glaald,g_xrca.xrcadocno,g_xrca.xrcadocdt,'1') RETURNING l_success
         IF NOT l_success THEN
           #LET g_success = 'N'         #20150201#1 By zhangwei Mark
            LET l_doc_success = FALSE   #20150201#1 By zhangwei Add
         END IF
      END IF
      
      #151125-00006#1---add---s  执行立即审核功能
      LET l_conf_success = NULL
      CALL s_aooi200_fin_get_slip(g_xrca.xrcadocno) RETURNING l_slip_success,l_ooba002
      CALL s_fin_get_doc_para(g_xrca.xrcald,g_xrca.xrcacomp,l_ooba002,'D-FIN-0031') RETURNING l_dfin0031
  
      IF NOT cl_null(l_dfin0031) AND l_dfin0031 MATCHES '[Yy]' THEN 
         CALL s_axrp133_immediately_conf(g_xrca.xrcald,g_xrca.xrcadocno) RETURNING l_conf_success
      END IF 
      
      #151125-00006#1---add---e
      
      #20150201#1 By zhangwei Add ---(S)---
      #IF l_doc_success THEN  #151125-00006#1 mark by aiqq
      IF l_doc_success AND ( (not cl_null(l_conf_success) AND l_conf_success) OR cl_null(l_conf_success) ) THEN    #151125-00006#1 add by aiqq  
         IF cl_null(l_start_no) THEN
            LET l_start_no = g_xrca.xrcadocno
         END IF
         LET l_end_no = g_xrca.xrcadocno
         CLOSE axrp133_cl
         CALL s_transaction_end('Y',1)
      ELSE
         LET l_tot_success = FALSE
         CLOSE axrp133_cl
         CALL s_transaction_end('N',1)
      END IF
      
      #151125-00006#1---add---s  #执行立即抛砖总账传票
      CALL s_fin_get_doc_para(g_xrca.xrcald,g_xrca.xrcacomp,l_ooba002,'D-FIN-0032') RETURNING l_dfin0032
      CALL s_fin_get_doc_para(g_xrca.xrcald,g_xrca.xrcacomp,l_ooba002,'D-FIN-2002') RETURNING l_gl_slip
      IF l_doc_success THEN
         IF NOT cl_null(l_gl_slip) THEN 
            IF NOT cl_null(l_dfin0032) AND l_dfin0032 MATCHES '[Yy]' THEN           
                   CALL s_axrp133_immediately_gen(g_xrca.xrcald,g_xrca.xrcadocno,g_xrca.xrcasite,g_xrca.xrcadocdt,l_gl_slip)
            END IF 
          ELSE
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "" 
            LET g_errparam.code   = "axr-00987" 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
         END IF
       END IF 
      #151125-00006#1---add---e
      
      LET l_doc_success = TRUE
      #20150201#1 By zhangwei Add ---(E)---
      

      
{
      #20150201#1 By zhangwei Add ---(S)---
      IF NOT l_doc_success THEN

         IF g_glaa.glaa121 = 'Y' AND l_dfin0030 = 'Y' THEN
            CALL s_pre_voucher_del('AR','R10',g_xrca.xrcald,g_xrca.xrcadocno) RETURNING l_success
         END IF

         FOREACH axrp133_bak_curs USING g_xrca.xrcadocno INTO l_xrcb002,l_xrcb003,l_xrcb007
            CASE
               WHEN l_s = '1'
                  UPDATE xmdl_t SET xmdl038 = xmdl038 - l_xrcb007
                   WHERE xmdldocno = l_xrcb002
                     AND xmdlseq = l_xrcb003
                     AND xmdlent = g_enterprise
               WHEN l_s = '2'
                  UPDATE xmdl_t SET xmdl039 = xmdl039 - l_xrcb007
                   WHERE xmdldocno = l_xrcb002
                     AND xmdlseq = l_xrcb003
                     AND xmdlent = g_enterprise
               WHEN l_s = '3'
                  UPDATE xmdl_t SET xmdl040 = xmdl040 - l_xrcb007
                   WHERE xmdldocno = l_xrcb002
                     AND xmdlseq = l_xrcb003
                     AND xmdlent = g_enterprise
            END CASE
         END FOREACH
         DELETE FROM xrca_t WHERE xrcadocno = g_xrca.xrcadocno AND xrcaent = g_enterprise
         DELETE FROM xrcb_t WHERE xrcbdocno = g_xrca.xrcadocno AND xrcbent = g_enterprise
         DELETE FROM xrcd_t WHERE xrcddocno = g_xrca.xrcadocno AND xrcdent = g_enterprise
         DELETE FROM xrce_t WHERE xrcedocno = g_xrca.xrcadocno AND xrceent = g_enterprise
         DELETE FROM xrde_t WHERE xrdedocno = g_xrca.xrcadocno AND xrdeent = g_enterprise
         DELETE FROM xrcf_t WHERE xrcfdocno = g_xrca.xrcadocno AND xrcfent = g_enterprise
      END IF
      CALL s_transaction_end('Y',1)
      #20150201#1 By zhangwei Add ---(E)---
   END IF   #20150201#1 By zhangwei Add
}
  #20150201#1 By zhangwei Mark ---(S)---
  #IF g_success = 'N' THEN
  #   CALL s_transaction_end('N',1)
  #   CALL cl_err_collect_show()
  #   RETURN
  #ELSE
  #   CALL s_transaction_end('Y',1)
  #   INITIALIZE g_errparam TO NULL
  #   LET g_errparam.code = 'asf-00251'
  #   LET g_errparam.replace[1] = l_start_no
  #   LET g_errparam.replace[2] = l_end_no
  #   LET g_errparam.extend = ''
  #   LET g_errparam.popup = TRUE
  #   CALL cl_err()
  #
  #   CALL cl_err_collect_show()
  #   CALL s_transaction_end('Y',1)
  #END IF
  #20150201#1 By zhangwei Mark ---(E)---
  #20150201#1 By zhangwei Add ---(S)---
   IF NOT cl_null(l_start_no) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00251'
      LET g_errparam.replace[1] = l_start_no
      LET g_errparam.replace[2] = l_end_no
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF
   IF l_tot_success AND NOT cl_null(l_start_no) THEN #全部資料都正確
      CALL cl_err_collect_show()
   ELSE
      CALL cl_err_collect_show()
   END IF
  #20150201#1 By zhangwei Add ---(E)---

END FUNCTION
################################################################################
# Descriptions...: sub產生的數據集轉換
# Memo...........: DSCNJ,DSCTP,DSCTC --> ('DSCNJ','DSCTP','DSCTC')
# Usage..........: CALL axrp133_get_ooef001_wc(p_wc)
#                  RETURNING r_wc
# Input parameter: p_wc           sub产生的数据集
# Return code....: r_wc           SQ可用的数据集
# Date & Author..: 2014/10/17 By zhangweib
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp133_get_ooef001_wc(p_wc)
   DEFINE p_wc       STRING
   DEFINE r_wc       STRING
   DEFINE tok        base.StringTokenizer
   DEFINE l_str      STRING

   LET tok = base.StringTokenizer.create(p_wc,",")
   WHILE tok.hasMoreTokens()
      IF cl_null(l_str) THEN
         LET l_str = tok.nextToken()
      ELSE
         LET l_str = l_str,"','",tok.nextToken()
      END IF      
   END WHILE   
   LET r_wc = "('",l_str,"')"
   
   RETURN r_wc

END FUNCTION
################################################################################
# Descriptions...: 產生直接沖帳資料
# Memo...........:
# Usage..........: CALL axrp133_ins_xrce()
#                  RETURNING ---
# Input parameter: 
# Return code....: 
# Date & Author..: 2014/10/17 By zhangweib
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp133_ins_xrce()
   DEFINE l_count             LIKE type_t.num5
   DEFINE l_seq               LIKE type_t.num5
   DEFINE l_xrccdocno         LIKE xrcc_t.xrccdocno
   DEFINE l_xrccseq           LIKE xrcc_t.xrccseq
   DEFINE l_xrcc001           LIKE xrcc_t.xrcc001
   DEFINE l_xrca060           LIKE xrca_t.xrca060
   DEFINE l_xrca103           LIKE xrca_t.xrca103
   DEFINE l_xrca113           LIKE xrca_t.xrca113
   #161128-00061#3-----modify--begin----------
  # DEFINE l_xrca              RECORD LIKE xrca_t.*
  # DEFINE l_xrcb              RECORD LIKE xrcb_t.*
  # DEFINE l_xrcc              RECORD LIKE xrcc_t.*
  # DEFINE l_xrce              RECORD LIKE xrce_t.*
   DEFINE l_xrca RECORD  #應收憑單單頭
       xrcaent LIKE xrca_t.xrcaent, #企業編號
       xrcaownid LIKE xrca_t.xrcaownid, #資料所有者
       xrcaowndp LIKE xrca_t.xrcaowndp, #資料所屬部門
       xrcacrtid LIKE xrca_t.xrcacrtid, #資料建立者
       xrcacrtdp LIKE xrca_t.xrcacrtdp, #資料建立部門
       xrcacrtdt LIKE xrca_t.xrcacrtdt, #資料創建日
       xrcamodid LIKE xrca_t.xrcamodid, #資料修改者
       xrcamoddt LIKE xrca_t.xrcamoddt, #最近修改日
       xrcacnfid LIKE xrca_t.xrcacnfid, #資料確認者
       xrcacnfdt LIKE xrca_t.xrcacnfdt, #資料確認日
       xrcapstid LIKE xrca_t.xrcapstid, #資料過帳者
       xrcapstdt LIKE xrca_t.xrcapstdt, #資料過帳日
       xrcastus LIKE xrca_t.xrcastus, #狀態碼
       xrcacomp LIKE xrca_t.xrcacomp, #法人
       xrcald LIKE xrca_t.xrcald, #帳套
       xrcadocno LIKE xrca_t.xrcadocno, #應收帳款單號碼
       xrcadocdt LIKE xrca_t.xrcadocdt, #帳款日期
       xrca001 LIKE xrca_t.xrca001, #帳款單性質
       xrcasite LIKE xrca_t.xrcasite, #帳務中心
       xrca003 LIKE xrca_t.xrca003, #帳務人員
       xrca004 LIKE xrca_t.xrca004, #帳款客戶編號
       xrca005 LIKE xrca_t.xrca005, #收款客戶
       xrca006 LIKE xrca_t.xrca006, #客戶分類
       xrca007 LIKE xrca_t.xrca007, #帳款類別
       xrca008 LIKE xrca_t.xrca008, #收款條件編號
       xrca009 LIKE xrca_t.xrca009, #應收款日/應扣抵日
       xrca010 LIKE xrca_t.xrca010, #容許票據到期日
       xrca011 LIKE xrca_t.xrca011, #稅別
       xrca012 LIKE xrca_t.xrca012, #稅率
       xrca013 LIKE xrca_t.xrca013, #含稅否
       xrca014 LIKE xrca_t.xrca014, #人員編號
       xrca015 LIKE xrca_t.xrca015, #部門編號
       xrca016 LIKE xrca_t.xrca016, #來源作業類型
       xrca017 LIKE xrca_t.xrca017, #產生方式
       xrca018 LIKE xrca_t.xrca018, #來源參考單號
       xrca019 LIKE xrca_t.xrca019, #系統產生對應單號(待抵帳款-預收)
       xrca020 LIKE xrca_t.xrca020, #信用狀申請流程否
       xrca021 LIKE xrca_t.xrca021, #商業發票號碼(IV no.)
       xrca022 LIKE xrca_t.xrca022, #出口報單號碼
       xrca023 LIKE xrca_t.xrca023, #發票客戶編號
       xrca024 LIKE xrca_t.xrca024, #發票客戶統一編號
       xrca025 LIKE xrca_t.xrca025, #發票客戶全名
       xrca026 LIKE xrca_t.xrca026, #發票客戶地址
       xrca028 LIKE xrca_t.xrca028, #發票類型
       xrca029 LIKE xrca_t.xrca029, #發票匯率
       xrca030 LIKE xrca_t.xrca030, #發票應開未稅金額
       xrca031 LIKE xrca_t.xrca031, #發票應開稅額
       xrca032 LIKE xrca_t.xrca032, #發票應開含稅金額
       xrca033 LIKE xrca_t.xrca033, #專案編號
       xrca034 LIKE xrca_t.xrca034, #責任中心
       xrca035 LIKE xrca_t.xrca035, #應收(借方)科目編號
       xrca036 LIKE xrca_t.xrca036, #收入(貸方)科目編號
       xrca037 LIKE xrca_t.xrca037, #分錄傳票產生否
       xrca038 LIKE xrca_t.xrca038, #拋轉傳票號碼
       xrca039 LIKE xrca_t.xrca039, #會計檢核附件份數
       xrca040 LIKE xrca_t.xrca040, #留置否
       xrca041 LIKE xrca_t.xrca041, #留置理由碼
       xrca042 LIKE xrca_t.xrca042, #留置設定日期
       xrca043 LIKE xrca_t.xrca043, #留置解除日期
       xrca044 LIKE xrca_t.xrca044, #留置原幣金額
       xrca045 LIKE xrca_t.xrca045, #留置說明
       xrca046 LIKE xrca_t.xrca046, #關係人否
       xrca047 LIKE xrca_t.xrca047, #多角序號
       xrca048 LIKE xrca_t.xrca048, #集團代收/代付單號
       xrca049 LIKE xrca_t.xrca049, #來源營運中心編號
       xrca050 LIKE xrca_t.xrca050, #交易原始單據份數
       xrca051 LIKE xrca_t.xrca051, #作廢理由碼
       xrca052 LIKE xrca_t.xrca052, #列印次數
       xrca053 LIKE xrca_t.xrca053, #備註
       xrca054 LIKE xrca_t.xrca054, #多帳期設定
       xrca055 LIKE xrca_t.xrca055, #繳款優惠條件
       xrca056 LIKE xrca_t.xrca056, #會計檢核附件狀態
       xrca057 LIKE xrca_t.xrca057, #交易對象識別碼
       xrca058 LIKE xrca_t.xrca058, #銷售分類
       xrca059 LIKE xrca_t.xrca059, #預算編號
       xrca060 LIKE xrca_t.xrca060, #發票開立原則
       xrca061 LIKE xrca_t.xrca061, #預計開立發票日期
       xrca062 LIKE xrca_t.xrca062, #多角性質
       xrca063 LIKE xrca_t.xrca063, #整帳批序號
       xrca064 LIKE xrca_t.xrca064, #訂金序次
       xrca065 LIKE xrca_t.xrca065, #發票編號
       xrca066 LIKE xrca_t.xrca066, #發票號碼
       xrca100 LIKE xrca_t.xrca100, #交易原幣別
       xrca101 LIKE xrca_t.xrca101, #原幣匯率
       xrca103 LIKE xrca_t.xrca103, #原幣未稅金額
       xrca104 LIKE xrca_t.xrca104, #原幣稅額
       xrca106 LIKE xrca_t.xrca106, #原幣直接折抵合計金額
       xrca107 LIKE xrca_t.xrca107, #原幣直接沖帳(調整)合計金額
       xrca108 LIKE xrca_t.xrca108, #原幣應收金額
       xrca113 LIKE xrca_t.xrca113, #本幣未稅金額
       xrca114 LIKE xrca_t.xrca114, #本幣稅額
       xrca116 LIKE xrca_t.xrca116, #本幣直接沖帳(調整)合計金額
       xrca117 LIKE xrca_t.xrca117, #本幣直接沖帳(調整)合計金額
       xrca118 LIKE xrca_t.xrca118, #本幣應收金額
       xrca120 LIKE xrca_t.xrca120, #本位幣二幣別
       xrca121 LIKE xrca_t.xrca121, #本位幣二匯率
       xrca123 LIKE xrca_t.xrca123, #本位幣二未稅金額
       xrca124 LIKE xrca_t.xrca124, #本位幣二稅額
       xrca126 LIKE xrca_t.xrca126, #本位幣二直接折抵合計金額
       xrca127 LIKE xrca_t.xrca127, #本位幣二直接沖帳(調整)合計金額
       xrca128 LIKE xrca_t.xrca128, #本位幣二應收金額
       xrca130 LIKE xrca_t.xrca130, #本位幣三幣別
       xrca131 LIKE xrca_t.xrca131, #本位幣三匯率
       xrca133 LIKE xrca_t.xrca133, #本位幣三未稅金額
       xrca134 LIKE xrca_t.xrca134, #本位幣三稅額
       xrca136 LIKE xrca_t.xrca136, #本位幣三直接折抵合計金額
       xrca137 LIKE xrca_t.xrca137, #本位幣三直接沖帳(調整)合計金額
       xrca138 LIKE xrca_t.xrca138 #本位幣三應收金額
       END RECORD
   DEFINE l_xrcb RECORD  #應收憑單單身
       xrcbent LIKE xrcb_t.xrcbent, #企業編號
       xrcbld LIKE xrcb_t.xrcbld, #帳套
       xrcbdocno LIKE xrcb_t.xrcbdocno, #單號
       xrcbseq LIKE xrcb_t.xrcbseq, #項次
       xrcbsite LIKE xrcb_t.xrcbsite, #營運據點
       xrcborga LIKE xrcb_t.xrcborga, #帳務來源SITE
       xrcb001 LIKE xrcb_t.xrcb001, #來源類型
       xrcb002 LIKE xrcb_t.xrcb002, #來源業務單據號碼
       xrcb003 LIKE xrcb_t.xrcb003, #來源業務單據項次
       xrcb004 LIKE xrcb_t.xrcb004, #產品編號
       xrcb005 LIKE xrcb_t.xrcb005, #品名規格
       xrcb006 LIKE xrcb_t.xrcb006, #單位
       xrcb007 LIKE xrcb_t.xrcb007, #計價數量
       xrcb008 LIKE xrcb_t.xrcb008, #參考單據號碼
       xrcb009 LIKE xrcb_t.xrcb009, #參考單號項次
       xrcblegl LIKE xrcb_t.xrcblegl, #核算組織
       xrcb010 LIKE xrcb_t.xrcb010, #業務部門
       xrcb011 LIKE xrcb_t.xrcb011, #責任中心
       xrcb012 LIKE xrcb_t.xrcb012, #產品類別
       xrcb013 LIKE xrcb_t.xrcb013, #發票帳否(搭贈/備品/樣品)
       xrcb014 LIKE xrcb_t.xrcb014, #理由碼
       xrcb015 LIKE xrcb_t.xrcb015, #專案編號
       xrcb016 LIKE xrcb_t.xrcb016, #WBS編號
       xrcb017 LIKE xrcb_t.xrcb017, #預算細項
       xrcb018 LIKE xrcb_t.xrcb018, #商戶編號
       xrcb019 LIKE xrcb_t.xrcb019, #開票性質
       xrcb020 LIKE xrcb_t.xrcb020, #稅別
       xrcb021 LIKE xrcb_t.xrcb021, #收入會計科目
       xrcb022 LIKE xrcb_t.xrcb022, #正負值
       xrcb023 LIKE xrcb_t.xrcb023, #沖暫估單否
       xrcb024 LIKE xrcb_t.xrcb024, #區域
       xrcb025 LIKE xrcb_t.xrcb025, #傳票號碼
       xrcb026 LIKE xrcb_t.xrcb026, #傳票項次
       xrcb027 LIKE xrcb_t.xrcb027, #發票編號
       xrcb028 LIKE xrcb_t.xrcb028, #發票號碼
       xrcb029 LIKE xrcb_t.xrcb029, #應收帳款科目
       xrcb030 LIKE xrcb_t.xrcb030, #已開發票數量
       xrcb031 LIKE xrcb_t.xrcb031, #收款條件編號
       xrcb032 LIKE xrcb_t.xrcb032, #訂金序次
       xrcb033 LIKE xrcb_t.xrcb033, #經營方式
       xrcb034 LIKE xrcb_t.xrcb034, #通路
       xrcb035 LIKE xrcb_t.xrcb035, #品牌
       xrcb036 LIKE xrcb_t.xrcb036, #客群
       xrcb037 LIKE xrcb_t.xrcb037, #自由核算項一
       xrcb038 LIKE xrcb_t.xrcb038, #自由核算項二
       xrcb039 LIKE xrcb_t.xrcb039, #自由核算項三
       xrcb040 LIKE xrcb_t.xrcb040, #自由核算項四
       xrcb041 LIKE xrcb_t.xrcb041, #自由核算項五
       xrcb042 LIKE xrcb_t.xrcb042, #自由核算項六
       xrcb043 LIKE xrcb_t.xrcb043, #自由核算項七
       xrcb044 LIKE xrcb_t.xrcb044, #自由核算項八
       xrcb045 LIKE xrcb_t.xrcb045, #自由核算項九
       xrcb046 LIKE xrcb_t.xrcb046, #自由核算項十
       xrcb047 LIKE xrcb_t.xrcb047, #摘要
       xrcb048 LIKE xrcb_t.xrcb048, #客戶訂購單號
       xrcb049 LIKE xrcb_t.xrcb049, #開票單號
       xrcb050 LIKE xrcb_t.xrcb050, #開票項次
       xrcb051 LIKE xrcb_t.xrcb051, #業務人員
       xrcb100 LIKE xrcb_t.xrcb100, #交易原幣
       xrcb101 LIKE xrcb_t.xrcb101, #交易原幣單價
       xrcb102 LIKE xrcb_t.xrcb102, #交易匯率
       xrcb103 LIKE xrcb_t.xrcb103, #交易原幣未稅金額
       xrcb104 LIKE xrcb_t.xrcb104, #交易原幣稅額
       xrcb105 LIKE xrcb_t.xrcb105, #交易原幣含稅金額
       xrcb106 LIKE xrcb_t.xrcb106, #交易原幣調整差異金額
       xrcb111 LIKE xrcb_t.xrcb111, #本幣單價
       xrcb113 LIKE xrcb_t.xrcb113, #本幣未稅金額
       xrcb114 LIKE xrcb_t.xrcb114, #本幣稅額
       xrcb115 LIKE xrcb_t.xrcb115, #本幣含稅金額
       xrcb116 LIKE xrcb_t.xrcb116, #本幣調整差異金額
       xrcb117 LIKE xrcb_t.xrcb117, #已開發票金額(未稅)
       xrcb118 LIKE xrcb_t.xrcb118, #應開發票未稅金額
       xrcb119 LIKE xrcb_t.xrcb119, #應開發票含稅金額
       xrcb121 LIKE xrcb_t.xrcb121, #本位幣二匯率
       xrcb123 LIKE xrcb_t.xrcb123, #本位幣二未稅金額
       xrcb124 LIKE xrcb_t.xrcb124, #本位幣二稅額
       xrcb125 LIKE xrcb_t.xrcb125, #本位幣二含稅金額
       xrcb126 LIKE xrcb_t.xrcb126, #本位幣二調整差異金額
       xrcb131 LIKE xrcb_t.xrcb131, #本位幣三匯率
       xrcb133 LIKE xrcb_t.xrcb133, #本位幣三未稅金額
       xrcb134 LIKE xrcb_t.xrcb134, #本位幣三稅額
       xrcb135 LIKE xrcb_t.xrcb135, #本位幣三含稅金額
       xrcb136 LIKE xrcb_t.xrcb136, #本位幣三調整差異金額
       xrcb052 LIKE xrcb_t.xrcb052, #款別編號
       xrcb053 LIKE xrcb_t.xrcb053, #帳款對象
       xrcb054 LIKE xrcb_t.xrcb054, #收款對象
       xrcb055 LIKE xrcb_t.xrcb055, #收現金額(流通)
       xrcb056 LIKE xrcb_t.xrcb056, #應收金額(流通)
       xrcb057 LIKE xrcb_t.xrcb057, #扣款金額(流通)
       xrcb058 LIKE xrcb_t.xrcb058, #預收科目
       xrcb059 LIKE xrcb_t.xrcb059, #代收銀科目
       xrcb060 LIKE xrcb_t.xrcb060, #月份類型
       xrcb107 LIKE xrcb_t.xrcb107  #出貨單單價
       END RECORD

   DEFINE l_xrcc RECORD  #多帳期明細
       xrccent LIKE xrcc_t.xrccent, #企業編號
       xrccld LIKE xrcc_t.xrccld, #帳套
       xrcccomp LIKE xrcc_t.xrcccomp, #法人
       xrccdocno LIKE xrcc_t.xrccdocno, #應收帳款單號碼
       xrccseq LIKE xrcc_t.xrccseq, #項次
       xrcc001 LIKE xrcc_t.xrcc001, #期別
       xrcc002 LIKE xrcc_t.xrcc002, #應收收款類別
       xrcc003 LIKE xrcc_t.xrcc003, #應收款日
       xrcc004 LIKE xrcc_t.xrcc004, #容許票據到期日
       xrcc005 LIKE xrcc_t.xrcc005, #帳款起算日
       xrcc006 LIKE xrcc_t.xrcc006, #正負值
       xrcclegl LIKE xrcc_t.xrcclegl, #核算組織
       xrcc008 LIKE xrcc_t.xrcc008, #發票編號
       xrcc009 LIKE xrcc_t.xrcc009, #發票號碼
       xrccsite LIKE xrcc_t.xrccsite, #帳務中心
       xrcc010 LIKE xrcc_t.xrcc010, #發票日期
       xrcc011 LIKE xrcc_t.xrcc011, #出貨單據日期
       xrcc012 LIKE xrcc_t.xrcc012, #立帳日期
       xrcc013 LIKE xrcc_t.xrcc013, #交易認定日期
       xrcc014 LIKE xrcc_t.xrcc014, #出入庫扣帳日期
       xrcc100 LIKE xrcc_t.xrcc100, #交易原幣別
       xrcc101 LIKE xrcc_t.xrcc101, #原幣匯率
       xrcc102 LIKE xrcc_t.xrcc102, #原幣重估後匯率
       xrcc103 LIKE xrcc_t.xrcc103, #重評價調整數
       xrcc104 LIKE xrcc_t.xrcc104, #No Use
       xrcc105 LIKE xrcc_t.xrcc105, #No Use
       xrcc106 LIKE xrcc_t.xrcc106, #No Use
       xrcc107 LIKE xrcc_t.xrcc107, #No Use
       xrcc108 LIKE xrcc_t.xrcc108, #原幣應收金額
       xrcc109 LIKE xrcc_t.xrcc109, #原幣收款沖帳金額
       xrcc113 LIKE xrcc_t.xrcc113, #本幣重評價調整數
       xrcc114 LIKE xrcc_t.xrcc114, #No Use
       xrcc115 LIKE xrcc_t.xrcc115, #No Use
       xrcc116 LIKE xrcc_t.xrcc116, #No Use
       xrcc117 LIKE xrcc_t.xrcc117, #No Use
       xrcc118 LIKE xrcc_t.xrcc118, #本幣應收金額
       xrcc119 LIKE xrcc_t.xrcc119, #本幣收款沖帳金額
       xrcc120 LIKE xrcc_t.xrcc120, #本位幣二幣別
       xrcc121 LIKE xrcc_t.xrcc121, #本位幣二匯率
       xrcc122 LIKE xrcc_t.xrcc122, #本位幣二重估後匯率
       xrcc123 LIKE xrcc_t.xrcc123, #本位幣二重評價調整數
       xrcc124 LIKE xrcc_t.xrcc124, #No Use
       xrcc125 LIKE xrcc_t.xrcc125, #No Use
       xrcc126 LIKE xrcc_t.xrcc126, #No Use
       xrcc127 LIKE xrcc_t.xrcc127, #No Use
       xrcc128 LIKE xrcc_t.xrcc128, #本位幣二應收金額
       xrcc129 LIKE xrcc_t.xrcc129, #本位幣二收款沖帳金額
       xrcc130 LIKE xrcc_t.xrcc130, #本位幣三幣別
       xrcc131 LIKE xrcc_t.xrcc131, #本位幣三匯率
       xrcc132 LIKE xrcc_t.xrcc132, #本位幣三重估後匯率
       xrcc133 LIKE xrcc_t.xrcc133, #本位幣三重評價調整數
       xrcc134 LIKE xrcc_t.xrcc134, #No Use
       xrcc135 LIKE xrcc_t.xrcc135, #No Use
       xrcc136 LIKE xrcc_t.xrcc136, #No Use
       xrcc137 LIKE xrcc_t.xrcc137, #No Use
       xrcc138 LIKE xrcc_t.xrcc138, #本位幣三應收金額
       xrcc139 LIKE xrcc_t.xrcc139, #本位幣三收款沖帳金額
       xrcc015 LIKE xrcc_t.xrcc015, #收款條件
       xrcc016 LIKE xrcc_t.xrcc016, #帳款類型
       xrcc017 LIKE xrcc_t.xrcc017  #訂單單號
       END RECORD

   DEFINE l_xrce RECORD  #應收沖銷明細檔
       xrceent LIKE xrce_t.xrceent, #企業編號
       xrcecomp LIKE xrce_t.xrcecomp, #法人
       xrceld LIKE xrce_t.xrceld, #帳套
       xrcedocno LIKE xrce_t.xrcedocno, #沖銷單單號
       xrceseq LIKE xrce_t.xrceseq, #項次
       xrcelegl LIKE xrce_t.xrcelegl, #no use
       xrcesite LIKE xrce_t.xrcesite, #帳務中心
       xrceorga LIKE xrce_t.xrceorga, #帳務歸屬組織
       xrce001 LIKE xrce_t.xrce001, #來源作業
       xrce002 LIKE xrce_t.xrce002, #沖銷類型
       xrce003 LIKE xrce_t.xrce003, #沖銷帳款單單號
       xrce004 LIKE xrce_t.xrce004, #沖銷帳款單項次
       xrce005 LIKE xrce_t.xrce005, #沖銷帳款單帳期
       xrce006 LIKE xrce_t.xrce006, #no use
       xrce007 LIKE xrce_t.xrce007, #no use
       xrce008 LIKE xrce_t.xrce008, #no use
       xrce009 LIKE xrce_t.xrce009, #no use
       xrce010 LIKE xrce_t.xrce010, #摘要說明
       xrce011 LIKE xrce_t.xrce011, #no use
       xrce012 LIKE xrce_t.xrce012, #no use
       xrce013 LIKE xrce_t.xrce013, #no use
       xrce014 LIKE xrce_t.xrce014, #no use
       xrce015 LIKE xrce_t.xrce015, #沖銷加減項
       xrce016 LIKE xrce_t.xrce016, #沖銷科目
       xrce017 LIKE xrce_t.xrce017, #業務人員
       xrce018 LIKE xrce_t.xrce018, #業務部門
       xrce019 LIKE xrce_t.xrce019, #責任中心
       xrce020 LIKE xrce_t.xrce020, #產品類別
       xrce021 LIKE xrce_t.xrce021, #no use
       xrce022 LIKE xrce_t.xrce022, #專案編號
       xrce023 LIKE xrce_t.xrce023, #WBS編號
       xrce024 LIKE xrce_t.xrce024, #第二參考單號
       xrce025 LIKE xrce_t.xrce025, #第二參考單號項次
       xrce026 LIKE xrce_t.xrce026, #no use
       xrce027 LIKE xrce_t.xrce027, #應稅折抵否
       xrce028 LIKE xrce_t.xrce028, #產生方式
       xrce029 LIKE xrce_t.xrce029, #傳票號碼
       xrce030 LIKE xrce_t.xrce030, #傳票項次
       xrce035 LIKE xrce_t.xrce035, #區域
       xrce036 LIKE xrce_t.xrce036, #客戶分類
       xrce037 LIKE xrce_t.xrce037, #no use
       xrce038 LIKE xrce_t.xrce038, #對象
       xrce039 LIKE xrce_t.xrce039, #經營方式
       xrce040 LIKE xrce_t.xrce040, #通路
       xrce041 LIKE xrce_t.xrce041, #品牌
       xrce042 LIKE xrce_t.xrce042, #自由核算項一
       xrce043 LIKE xrce_t.xrce043, #自由核算項二
       xrce044 LIKE xrce_t.xrce044, #自由核算項三
       xrce045 LIKE xrce_t.xrce045, #自由核算項四
       xrce046 LIKE xrce_t.xrce046, #自由核算項五
       xrce047 LIKE xrce_t.xrce047, #自由核算項六
       xrce048 LIKE xrce_t.xrce048, #自由核算項七
       xrce049 LIKE xrce_t.xrce049, #自由核算項八
       xrce050 LIKE xrce_t.xrce050, #自由核算項九
       xrce051 LIKE xrce_t.xrce051, #自由核算項十
       xrce053 LIKE xrce_t.xrce053, #發票編號
       xrce054 LIKE xrce_t.xrce054, #發票號碼
       xrce100 LIKE xrce_t.xrce100, #幣別
       xrce101 LIKE xrce_t.xrce101, #匯率
       xrce104 LIKE xrce_t.xrce104, #原幣應稅折抵稅額
       xrce109 LIKE xrce_t.xrce109, #原幣沖帳金額
       xrce114 LIKE xrce_t.xrce114, #本幣應稅折抵稅額
       xrce119 LIKE xrce_t.xrce119, #本幣沖帳金額
       xrce120 LIKE xrce_t.xrce120, #本位幣二幣別
       xrce121 LIKE xrce_t.xrce121, #本位幣二匯率
       xrce124 LIKE xrce_t.xrce124, #本位幣二應稅折抵稅額
       xrce129 LIKE xrce_t.xrce129, #本位幣二沖帳金額
       xrce130 LIKE xrce_t.xrce130, #本位幣二幣別
       xrce131 LIKE xrce_t.xrce131, #本位幣三匯率
       xrce134 LIKE xrce_t.xrce134, #本位幣三應稅折抵稅額
       xrce139 LIKE xrce_t.xrce139, #本位幣三沖帳金額
       xrce055 LIKE xrce_t.xrce055, #費用編號
       xrce056 LIKE xrce_t.xrce056, #方向
       xrce057 LIKE xrce_t.xrce057, #預收待抵單號
       xrce058 LIKE xrce_t.xrce058, #應付單號
       xrce103 LIKE xrce_t.xrce103, #未稅原幣沖銷額
       xrce113 LIKE xrce_t.xrce113, #未稅本幣沖銷額
       xrce123 LIKE xrce_t.xrce123, #本位幣二未稅沖銷額
       xrce133 LIKE xrce_t.xrce133, #本位幣三未稅沖銷額
       xrce059 LIKE xrce_t.xrce059  #預收單號
       END RECORD

   #161128-00061#3-----modify--end---------
   DEFINE l_sql               STRING
   DEFINE ls_wc               STRING
   DEFINE l_wc1               STRING
   DEFINE l_ooef014           LIKE ooef_t.ooef014
   DEFINE l_ooaj004           LIKE ooaj_t.ooaj004
   DEFINE l_xrca100           LIKE xrca_t.xrca100
   DEFINE l_success           LIKE type_t.num5
   DEFINE l_errno             LIKE type_t.chr10
   #150316-00013#1 By 01727 Add  ---(S)---
   DEFINE l_glaacomp          LIKE glaa_t.glaacomp
   DEFINE l_sfin1002          LIKE type_t.chr1
   DEFINE l_xrce109           LIKE xrce_t.xrce109
   DEFINE l_xrce119           LIKE xrce_t.xrce119
   DEFINE l_xrce129           LIKE xrce_t.xrce129
   DEFINE l_xrce139           LIKE xrce_t.xrce139
   #150316-00013#1 By 01727 Add  ---(E)---
      
   SELECT ooef014 INTO l_ooef014 FROM ooef_t
    WHERE ooefent = g_enterprise AND ooef001 = g_glaa.glaacomp
      
   #1.取基础币种的金额精度--若有传入p_amount时,返回的是金额,非汇率
   CALL s_curr_sel_ooaj004(l_ooef014,g_glaa.glaa001)
        RETURNING l_ooaj004

   #STEP1:若發票單身有"27:其他待抵單"則先沖銷其他待抵單
   #STEP2:依據"自動沖銷"的勾選項,彙整待抵單

   #勾選訂金待抵:自動沖同一帳款客戶,同一收款客戶 帳款單性質=21 之訂金待抵
   #勾選銷退待抵:自動沖同一帳款客戶,同一收款客戶 帳款單性質=22 之銷退待抵
   #勾選預收待抵:自動沖同一帳款客戶,同一收款客戶 帳款單性質=23 之预收待抵
   #勾選其他待抵:自動沖同一帳款客戶,同一收款客戶 帳款單性質=29 之其他扣抵
   #勾選溢收待抵:自動沖同一帳款客戶,同一收款客戶 帳款單性質=24 之溢收待抵
   #勾選押金待抵:自動沖同一帳款客戶,同一收款客戶 帳款單性質=25 之押金待抵

   IF g_master.b_style = 'axrt340' THEN RETURN END IF

   #150316-00013#1 By 01727 Add  ---(S)---
   SELECT glaacomp INTO l_glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_master.xrcald
   CALL cl_get_para(g_enterprise,l_glaacomp,'S-FIN-1002') RETURNING l_sfin1002
   #150316-00013#1 By 01727 Add  ---(E)---

   LET ls_wc = " xrca004 = '",g_xrca.xrca004,"' AND xrca005 = '",g_xrca.xrca005,"' "
   LET l_count = 0
   IF g_master.b_check1 = 'Y' THEN
      IF NOT cl_null(l_wc1) THEN LET l_wc1 = l_wc1,"','" END IF
      LET l_wc1 = l_wc1,"21"
   ELSE
      LET l_count = l_count + 1
   END IF

   IF g_master.b_check2 = 'Y' THEN
      IF NOT cl_null(l_wc1) THEN LET l_wc1 = l_wc1,"','" END IF
      LET l_wc1 = l_wc1,"22"
   ELSE
      LET l_count = l_count + 1
   END IF
   IF g_master.b_check3 = 'Y' THEN
      IF NOT cl_null(l_wc1) THEN LET l_wc1 = l_wc1,"','" END IF
      LET l_wc1 = l_wc1,"23"
   ELSE
      LET l_count = l_count + 1
   END IF
   IF g_master.b_check4 = 'Y' THEN
      IF NOT cl_null(l_wc1) THEN LET l_wc1 = l_wc1,"','" END IF
      LET l_wc1 = l_wc1,"29"
   ELSE
      LET l_count = l_count + 1
   END IF
   IF g_master.b_check5 = 'Y' THEN
      IF NOT cl_null(l_wc1) THEN LET l_wc1 = l_wc1,"','" END IF
      LET l_wc1 = l_wc1,"24"
   ELSE
      LET l_count = l_count + 1
   END IF
   IF g_master.b_check6 = 'Y' THEN
      IF NOT cl_null(l_wc1) THEN LET l_wc1 = l_wc1,"','" END IF
      LET l_wc1 = l_wc1,"25"
   ELSE
      LET l_count = l_count + 1
   END IF
   IF l_count < 6 THEN LET ls_wc = ls_wc," AND xrca001 IN ('",l_wc1,"')" ELSE RETURN END IF

   LET l_sql = "(SELECT xrccdocno,xrccseq,xrcc001,1 flag,xrcadocdt,CASE WHEN xrca100 = '",g_xrca.xrca100,"' THEN 1 ELSE 2 END flag1 FROM xrcc_t,xrca_t       ",
               " WHERE xrccld = '",g_master.xrcald,"'                                               ",
               "   AND xrcc108 - xrcc109 > 0                                                        ",
               "   AND xrccent = xrcaent AND xrccdocno = xrcadocno AND xrccld = xrcald              ",
               "   AND EXISTS (SELECT 1 FROM isag_t WHERE isagent = '",g_enterprise,"'              ",
               "                  AND isag001 = '26' AND isagcomp = '",g_xrca.xrcacomp,"'           ",
               "                  AND isag002 = xrccdocno AND isag003 = xrccseq                     ",
               "                  AND isagdocno IN ( SELECT DISTINCT xrcb002 FROM xrcb_t            ",
               "                                      WHERE xrcbent = '",g_enterprise,"'            ",
               "                                        AND xrcbdocno = '",g_xrca.xrcadocno,"'      ",
               "                                        AND xrcbld = '",g_xrca.xrcald,"'          ))"

   LET l_sql = l_sql," UNION "

   LET l_sql = l_sql,"SELECT xrccdocno,xrccseq,xrcc001,2 flag,xrcadocdt,CASE WHEN xrca100 = '",g_xrca.xrca100,"' THEN 1 ELSE 2 END flag1 FROM xrcc_t,xrca_t  ",
               " WHERE xrccent = xrcaent AND xrccdocno = xrcadocno AND xrccld = xrcald              ",
               "   AND xrccld = '",g_master.xrcald,"'                                               ",
               "   AND xrcc108 - xrcc109 > 0                                                        ",
               "   AND xrcadocdt <= '",g_master.xrcadocdt,"'                                        ",
               "   AND ",ls_wc,") ORDER BY flag ASC,flag1 ASC,xrcadocdt"
   PREPARE axrp132_xrce_prep FROM l_sql
   DECLARE axrp132_xrce_curs CURSOR FOR axrp132_xrce_prep

   LET l_xrce.xrceseq = 0
   LET l_xrca103 = g_xrca.xrca103 + g_xrca.xrca104
   LET l_xrca113 = g_xrca.xrca113 + g_xrca.xrca114

   FOREACH axrp132_xrce_curs INTO l_xrccdocno,l_xrccseq,l_xrcc001
      IF l_xrca103 = 0 THEN EXIT FOREACH END IF
     #161128-00061#3-----modify--begin----------
     # SELECT * INTO l_xrca.* FROM xrca_t WHERE xrcaent = g_enterprise
     #    AND xrcadocno = l_xrccdocno AND xrcald = g_master.xrcald
     #   
     # SELECT * INTO l_xrcb.* FROM xrcb_t WHERE xrcbent = g_enterprise
     #    AND xrcbdocno = l_xrccdocno AND xrcbseq = l_xrccseq AND xrcbld = g_master.xrcald
     #    
     # SELECT * INTO l_xrcc.* FROM xrcc_t WHERE xrccent = g_enterprise
     #    AND xrccdocno = l_xrccdocno AND xrccseq = l_xrccseq AND xrcc001 = l_xrcc001 AND xrccld = g_master.xrcald
     
       SELECT xrcaent,xrcaownid,xrcaowndp,xrcacrtid,xrcacrtdp,xrcacrtdt,xrcamodid,xrcamoddt,xrcacnfid,
              xrcacnfdt,xrcapstid,xrcapstdt,xrcastus,xrcacomp,xrcald,xrcadocno,xrcadocdt,xrca001,
              xrcasite,xrca003,xrca004,xrca005,xrca006,xrca007,xrca008,xrca009,xrca010,xrca011,
              xrca012,xrca013,xrca014,xrca015,xrca016,xrca017,xrca018,xrca019,xrca020,xrca021,
              xrca022,xrca023,xrca024,xrca025,xrca026,xrca028,xrca029,xrca030,xrca031,xrca032,
              xrca033,xrca034,xrca035,xrca036,xrca037,xrca038,xrca039,xrca040,xrca041,xrca042,
              xrca043,xrca044,xrca045,xrca046,xrca047,xrca048,xrca049,xrca050,xrca051,xrca052,
              xrca053,xrca054,xrca055,xrca056,xrca057,xrca058,xrca059,xrca060,xrca061,xrca062,
              xrca063,xrca064,xrca065,xrca066,xrca100,xrca101,xrca103,xrca104,xrca106,xrca107,
              xrca108,xrca113,xrca114,xrca116,xrca117,xrca118,xrca120,xrca121,xrca123,xrca124,
              xrca126,xrca127,xrca128,xrca130,xrca131,xrca133,xrca134,xrca136,xrca137,xrca138 
              INTO l_xrca.* FROM xrca_t WHERE xrcaent = g_enterprise
          AND xrcadocno = l_xrccdocno AND xrcald = g_master.xrcald
         
       SELECT xrcbent,xrcbld,xrcbdocno,xrcbseq,xrcbsite,xrcborga,xrcb001,xrcb002,xrcb003,xrcb004,
              xrcb005,xrcb006,xrcb007,xrcb008,xrcb009,xrcblegl,xrcb010,xrcb011,xrcb012,xrcb013,xrcb014,
              xrcb015,xrcb016,xrcb017,xrcb018,xrcb019,xrcb020,xrcb021,xrcb022,xrcb023,xrcb024,xrcb025,
              xrcb026,xrcb027,xrcb028,xrcb029,xrcb030,xrcb031,xrcb032,xrcb033,xrcb034,xrcb035,xrcb036,
              xrcb037,xrcb038,xrcb039,xrcb040,xrcb041,xrcb042,xrcb043,xrcb044,xrcb045,xrcb046,xrcb047,
              xrcb048,xrcb049,xrcb050,xrcb051,xrcb100,xrcb101,xrcb102,xrcb103,xrcb104,xrcb105,xrcb106,
              xrcb111,xrcb113,xrcb114,xrcb115,xrcb116,xrcb117,xrcb118,xrcb119,xrcb121,xrcb123,xrcb124,
              xrcb125,xrcb126,xrcb131,xrcb133,xrcb134,xrcb135,xrcb136,xrcb052,xrcb053,xrcb054,xrcb055,
              xrcb056,xrcb057,xrcb058,xrcb059,xrcb060,xrcb107 INTO l_xrcb.* FROM xrcb_t WHERE xrcbent = g_enterprise
          AND xrcbdocno = l_xrccdocno AND xrcbseq = l_xrccseq AND xrcbld = g_master.xrcald
          
       SELECT xrccent,xrccld,xrcccomp,xrccdocno,xrccseq,xrcc001,xrcc002,xrcc003,xrcc004,xrcc005,
              xrcc006,xrcclegl,xrcc008,xrcc009,xrccsite,xrcc010,xrcc011,xrcc012,xrcc013,xrcc014,
              xrcc100,xrcc101,xrcc102,xrcc103,xrcc104,xrcc105,xrcc106,xrcc107,xrcc108,xrcc109,
              xrcc113,xrcc114,xrcc115,xrcc116,xrcc117,xrcc118,xrcc119,xrcc120,xrcc121,xrcc122,
              xrcc123,xrcc124,xrcc125,xrcc126,xrcc127,xrcc128,xrcc129,xrcc130,xrcc131,xrcc132,
              xrcc133,xrcc134,xrcc135,xrcc136,xrcc137,xrcc138,xrcc139,xrcc015,xrcc016,xrcc017 
              INTO l_xrcc.* FROM xrcc_t WHERE xrccent = g_enterprise
          AND xrccdocno = l_xrccdocno AND xrccseq = l_xrccseq AND xrcc001 = l_xrcc001 AND xrccld = g_master.xrcald
     #161128-00061#3-----modify--end----------

      #150316-00013#1 By 01727 Add  ---(S)---
      #待抵單的可用餘額=xrcc108 - xrcc109 - 已沖帳但未確認金額
      #即等同於 xrcc108 - SUM(xrce109)
      LET l_xrce109 = 0    LET l_xrce119 = 0   LET l_xrce129 = 0   LET l_xrce139 = 0
      IF l_sfin1002 = '1' THEN
         SELECT SUM(xrce109),SUM(xrce119),SUM(xrce129),SUM(xrce139)
           INTO l_xrce109,l_xrce119,l_xrce129,l_xrce139
           FROM xrce_t
          WHERE xrceent = g_enterprise       AND xrceld  = g_master.xrcald
            AND xrce003 = l_xrcc.xrccdocno   AND xrce004 = l_xrcc.xrccseq
      ELSE
         SELECT SUM(xrce109),SUM(xrce119),SUM(xrce129),SUM(xrce139)
           INTO l_xrce109,l_xrce119,l_xrce129,l_xrce139
           FROM xrce_t
          WHERE xrceent = g_enterprise       AND xrceld  = g_master.xrcald
            AND xrce003 = l_xrcc.xrccdocno   AND xrce004 = l_xrcc.xrccseq
            AND xrce005 = l_xrcc.xrcc001
      END IF
      IF cl_null(l_xrce109) THEN LET l_xrce109 = 0 END IF
      IF cl_null(l_xrce119) THEN LET l_xrce119 = 0 END IF
      IF cl_null(l_xrce129) THEN LET l_xrce129 = 0 END IF
      IF cl_null(l_xrce139) THEN LET l_xrce139 = 0 END IF
      LET l_xrcc.xrcc109 = l_xrce109
      LET l_xrcc.xrcc119 = l_xrce119
      LET l_xrcc.xrcc129 = l_xrce129
      LET l_xrcc.xrcc139 = l_xrce139
      #150316-00013#1 By 01727 Add  ---(E)---
      LET l_xrce.xrceent = g_enterprise
      LET l_xrce.xrcecomp= g_glaa.glaacomp
      LET l_xrce.xrceld  = g_master.xrcald
      LET l_xrce.xrcedocno=g_xrca.xrcadocno
      LET l_xrce.xrceseq = l_xrce.xrceseq + 1
      LET l_xrce.xrcelegl= l_xrcc.xrcclegl
      LET l_xrce.xrcesite= l_xrcc.xrccsite
      LET l_xrce.xrceorga= l_xrcc.xrccsite
      LET l_xrce.xrce001 = 'axrt340'
      LET l_xrce.xrce002 = '31'
      LET l_xrce.xrce003 = l_xrcc.xrccdocno
      LET l_xrce.xrce004 = l_xrccseq
      LET l_xrce.xrce005 = l_xrcc.xrcc001
      LET l_xrce.xrce006 = ''
      LET l_xrce.xrce008 = ''
      LET l_xrce.xrce009 = ''
      LET l_xrce.xrce010 = ''
      LET l_xrce.xrce011 = ''
      LET l_xrce.xrce012 = ''
      LET l_xrce.xrce013 = ''
      LET l_xrce.xrce014 = ''
      LET l_xrce.xrce015 = 'D'
      LET l_xrce.xrce016 = l_xrca.xrca035
      LET l_xrce.xrce017 = l_xrca.xrca014
      LET l_xrce.xrce018 = l_xrcb.xrcb010
      LET l_xrce.xrce019 = l_xrcb.xrcb011
      LET l_xrce.xrce020 = l_xrcb.xrcb012
      LET l_xrce.xrce021 = l_xrcb.xrcb017
      LET l_xrce.xrce022 = l_xrcb.xrcb015
      LET l_xrce.xrce023 = l_xrcb.xrcb016
      LET l_xrce.xrce024 = l_xrcb.xrcb002
      LET l_xrce.xrce025 = l_xrcb.xrcb003
      LET l_xrce.xrce026 = ''
     #150316-00013#1 By 01727 Mark ---(S)---
     #SELECT xrca060 INTO l_xrca060 FROM xrca_t
     # WHERE xrcald = g_master.xrcald
     #   AND xrca019 = l_xrce.xrce003
     #150316-00013#1 By 01727 Mark ---(S)---
     #150316-00013#1 By 01727 Add  ---(S)---
      SELECT xrca060 INTO l_xrca060 FROM xrca_t
       WHERE xrcald = g_master.xrcald
         AND xrcadocno = l_xrce.xrce003
         AND xrcaent = g_enterprise
     #150316-00013#1 By 01727 Add  ---(S)---
      IF l_xrca060 = '2' THEN
         LET l_xrce.xrce027 = 'Y'
      ELSE
         LET l_xrce.xrce027 = 'N'
      END IF
      LET l_xrce.xrce028 = ''
      LET l_xrce.xrce029 = ''
      LET l_xrce.xrce030 = ''
      LET l_xrce.xrce035 = ''
      LET l_xrce.xrce036 = ''
      LET l_xrce.xrce037 = ''
      LET l_xrce.xrce038 = ''
      LET l_xrce.xrce104 = 0
      LET l_xrce.xrce114 = 0
      LET l_xrce.xrce124 = 0
      LET l_xrce.xrce134 = 0
      LET l_xrce.xrce100 = l_xrcc.xrcc100
      LET l_xrce.xrce101 = l_xrcc.xrcc102
      LET l_xrce.xrce120 = l_xrcc.xrcc120
      LET l_xrce.xrce121 = l_xrcc.xrcc122
      LET l_xrce.xrce130 = l_xrcc.xrcc130
      LET l_xrce.xrce131 = l_xrcc.xrcc132

      IF g_xrca.xrca100 = l_xrca.xrca100 THEN
         IF l_xrca103 > l_xrcc.xrcc108 - l_xrcc.xrcc109 THEN
            LET l_xrce.xrce007 = l_xrcc.xrcc108 - l_xrcc.xrcc109
            LET l_xrce.xrce109 = l_xrcc.xrcc108 - l_xrcc.xrcc109
            LET l_xrce.xrce119 = l_xrcc.xrcc118 - l_xrcc.xrcc119
            LET l_xrce.xrce129 = l_xrcc.xrcc128 - l_xrcc.xrcc129
            LET l_xrce.xrce139 = l_xrcc.xrcc138 - l_xrcc.xrcc139
            LET l_xrca103 = l_xrca103 - l_xrcc.xrcc108 - l_xrcc.xrcc109
            LET l_xrca113 = l_xrca113 - l_xrcc.xrcc118 - l_xrcc.xrcc119
         ELSE
            LET l_xrce.xrce007 = l_xrca103
            LET l_xrce.xrce109 = l_xrca103
            LET l_xrce.xrce119 = l_xrca103 * l_xrcc.xrcc101
            LET l_xrce.xrce129 = l_xrca103 * l_xrcc.xrcc121
            LET l_xrce.xrce139 = l_xrca103 * l_xrcc.xrcc131
            LET l_xrca103 = 0
            LET l_xrca113 = l_xrca113 - l_xrca103 * l_xrcc.xrcc101
            IF l_xrca113 < 0 THEN LET l_xrca113 = 0 END IF
         END IF
      ELSE
         IF l_xrca113 > l_xrcc.xrcc118 - l_xrcc.xrcc119 THEN
            LET l_xrce.xrce007 = l_xrcc.xrcc108 - l_xrcc.xrcc109
            LET l_xrce.xrce109 = l_xrcc.xrcc108 - l_xrcc.xrcc109
            LET l_xrce.xrce119 = l_xrcc.xrcc118 - l_xrcc.xrcc119
            LET l_xrce.xrce129 = l_xrcc.xrcc128 - l_xrcc.xrcc129
            LET l_xrce.xrce139 = l_xrcc.xrcc138 - l_xrcc.xrcc139
            LET l_xrca113 = l_xrca113 - l_xrcc.xrcc118 - l_xrcc.xrcc119
            LET l_xrca103 = l_xrca113 / g_xrca.xrca101
         ELSE
            LET l_xrce.xrce007 = l_xrca113 / l_xrcc.xrcc101
            LET l_xrce.xrce007 = s_num_round('1',l_xrce.xrce007,l_ooaj004)
            LET l_xrce.xrce109 = l_xrce.xrce007
            LET l_xrce.xrce119 = l_xrca113
            LET l_xrce.xrce129 = l_xrce.xrce109 * l_xrcc.xrcc121
            LET l_xrce.xrce139 = l_xrce.xrce109 * l_xrcc.xrcc131
            LET l_xrca113 = 0
            LET l_xrca103 = 0
         END IF
      END IF

      #161128-00061#3-----modify--begin----------
      #INSERT INTO xrce_t VALUES (l_xrce.*)
      INSERT INTO xrce_t (xrceent,xrcecomp,xrceld,xrcedocno,xrceseq,xrcelegl,xrcesite,xrceorga,
                          xrce001,xrce002,xrce003,xrce004,xrce005,xrce006,xrce007,xrce008,xrce009,
                          xrce010,xrce011,xrce012,xrce013,xrce014,xrce015,xrce016,xrce017,xrce018,
                          xrce019,xrce020,xrce021,xrce022,xrce023,xrce024,xrce025,xrce026,xrce027,
                          xrce028,xrce029,xrce030,xrce035,xrce036,xrce037,xrce038,xrce039,xrce040,
                          xrce041,xrce042,xrce043,xrce044,xrce045,xrce046,xrce047,xrce048,xrce049,
                          xrce050,xrce051,xrce053,xrce054,xrce100,xrce101,xrce104,xrce109,xrce114,
                          xrce119,xrce120,xrce121,xrce124,xrce129,xrce130,xrce131,xrce134,xrce139,
                          xrce055,xrce056,xrce057,xrce058,xrce103,xrce113,xrce123,xrce133,xrce059)
       VALUES (l_xrce.xrceent,l_xrce.xrcecomp,l_xrce.xrceld,l_xrce.xrcedocno,l_xrce.xrceseq,l_xrce.xrcelegl,l_xrce.xrcesite,l_xrce.xrceorga,
               l_xrce.xrce001,l_xrce.xrce002,l_xrce.xrce003,l_xrce.xrce004,l_xrce.xrce005,l_xrce.xrce006,l_xrce.xrce007,l_xrce.xrce008,l_xrce.xrce009,
               l_xrce.xrce010,l_xrce.xrce011,l_xrce.xrce012,l_xrce.xrce013,l_xrce.xrce014,l_xrce.xrce015,l_xrce.xrce016,l_xrce.xrce017,l_xrce.xrce018,
               l_xrce.xrce019,l_xrce.xrce020,l_xrce.xrce021,l_xrce.xrce022,l_xrce.xrce023,l_xrce.xrce024,l_xrce.xrce025,l_xrce.xrce026,l_xrce.xrce027,
               l_xrce.xrce028,l_xrce.xrce029,l_xrce.xrce030,l_xrce.xrce035,l_xrce.xrce036,l_xrce.xrce037,l_xrce.xrce038,l_xrce.xrce039,l_xrce.xrce040,
               l_xrce.xrce041,l_xrce.xrce042,l_xrce.xrce043,l_xrce.xrce044,l_xrce.xrce045,l_xrce.xrce046,l_xrce.xrce047,l_xrce.xrce048,l_xrce.xrce049,
               l_xrce.xrce050,l_xrce.xrce051,l_xrce.xrce053,l_xrce.xrce054,l_xrce.xrce100,l_xrce.xrce101,l_xrce.xrce104,l_xrce.xrce109,l_xrce.xrce114,
               l_xrce.xrce119,l_xrce.xrce120,l_xrce.xrce121,l_xrce.xrce124,l_xrce.xrce129,l_xrce.xrce130,l_xrce.xrce131,l_xrce.xrce134,l_xrce.xrce139,
               l_xrce.xrce055,l_xrce.xrce056,l_xrce.xrce057,l_xrce.xrce058,l_xrce.xrce103,l_xrce.xrce113,l_xrce.xrce123,l_xrce.xrce133,l_xrce.xrce059)
      #161128-00061#3-----modify--end----------
      IF SQLCA.sqlcode THEN
         LET g_success = 'N' RETURN
      END IF

   END FOREACH

   LET l_xrce.xrce109 = 0
   LET l_xrce.xrce119 = 0
   LET l_xrce.xrce129 = 0
   LET l_xrce.xrce139 = 0

  #150316-00013#1 By 01727 Mark ---(S)---
  #SELECT SUM(xrce119 * CASE WHEN xrce015 = 'D' THEN 1 ELSE -1 END)
  #  INTO l_xrce.xrce119 FROM xrce_t WHERE xrceent = g_enterprise
  #   AND xrcedocno = g_xrca.xrcadocno AND xrceld = g_xrca.xrcald
  #IF cl_null(l_xrce.xrce119) THEN LET l_xrce.xrce119 = 0 END IF
  #CALL s_curr_round_ld('1',g_xrca.xrcald,g_xrca.xrca100,l_xrce.xrce119 / g_xrca.xrca101,2)
  #   RETURNING l_success,l_errno,l_xrce.xrce109
  #
  #IF g_glaa.glaa015 = 'Y' THEN
  #   IF g_glaa.glaa017 = '1' THEN
  #      LET l_xrce.xrce129 = l_xrce.xrce109 * g_xrca.xrca121
  #   ELSE
  #      LET l_xrce.xrce129 = l_xrce.xrce119 * g_xrca.xrca121
  #   END IF
  #END IF
  #IF g_glaa.glaa019 = 'Y' THEN
  #   IF g_glaa.glaa021 = '1' THEN
  #      LET l_xrce.xrce139 = l_xrce.xrce109 * g_xrca.xrca131
  #   ELSE
  #      LET l_xrce.xrce139 = l_xrce.xrce119 * g_xrca.xrca131
  #   END IF
  #END IF
  #UPDATE xrca_t SET xrca107 = l_xrce.xrce109,
  #                  xrca117 = l_xrce.xrce119,
  #                  xrca127 = l_xrce.xrce129,
  #                  xrca137 = l_xrce.xrce139
  # WHERE xrcaent = g_enterprise
  #   AND xrcadocno = g_xrca.xrcadocno
  #   AND xrcald = g_xrca.xrcald
  #150316-00013#1 By 01727 Mark ---(E)---
  #150316-00013#1 By 01727 Add  ---(S)---
  #非應稅折抵存入xrca107
   SELECT SUM(xrce119 * CASE WHEN xrce015 = 'D' THEN 1 ELSE -1 END)
     INTO l_xrce.xrce119 FROM xrce_t WHERE xrceent = g_enterprise
      AND xrcedocno = g_xrca.xrcadocno AND xrceld = g_xrca.xrcald
      AND xrce027 = 'N'
   IF cl_null(l_xrce.xrce119) THEN LET l_xrce.xrce119 = 0 END IF
   CALL s_curr_round_ld('1',g_xrca.xrcald,g_xrca.xrca100,l_xrce.xrce119 / g_xrca.xrca101,2)
      RETURNING l_success,l_errno,l_xrce.xrce109
   
   IF g_glaa.glaa015 = 'Y' THEN
      IF g_glaa.glaa017 = '1' THEN
         LET l_xrce.xrce129 = l_xrce.xrce109 * g_xrca.xrca121
      ELSE
         LET l_xrce.xrce129 = l_xrce.xrce119 * g_xrca.xrca121
      END IF
   END IF
   IF g_glaa.glaa019 = 'Y' THEN
      IF g_glaa.glaa021 = '1' THEN
         LET l_xrce.xrce139 = l_xrce.xrce109 * g_xrca.xrca131
      ELSE
         LET l_xrce.xrce139 = l_xrce.xrce119 * g_xrca.xrca131
      END IF
   END IF
   UPDATE xrca_t SET xrca107 = l_xrce.xrce109,
                     xrca117 = l_xrce.xrce119,
                     xrca127 = l_xrce.xrce129,
                     xrca137 = l_xrce.xrce139
    WHERE xrcaent = g_enterprise
      AND xrcadocno = g_xrca.xrcadocno
      AND xrcald = g_xrca.xrcald
  #應稅折抵存入xrca106
   LET l_xrce.xrce109 = 0
   LET l_xrce.xrce119 = 0
   LET l_xrce.xrce129 = 0
   LET l_xrce.xrce139 = 0
   SELECT SUM(xrce119 * CASE WHEN xrce015 = 'D' THEN 1 ELSE -1 END)
     INTO l_xrce.xrce119 FROM xrce_t WHERE xrceent = g_enterprise
      AND xrcedocno = g_xrca.xrcadocno AND xrceld = g_xrca.xrcald
      AND xrce027 = 'Y'
   IF cl_null(l_xrce.xrce119) THEN LET l_xrce.xrce119 = 0 END IF
   CALL s_curr_round_ld('1',g_xrca.xrcald,g_xrca.xrca100,l_xrce.xrce119 / g_xrca.xrca101,2)
      RETURNING l_success,l_errno,l_xrce.xrce109
   
   IF g_glaa.glaa015 = 'Y' THEN
      IF g_glaa.glaa017 = '1' THEN
         LET l_xrce.xrce129 = l_xrce.xrce109 * g_xrca.xrca121
      ELSE
         LET l_xrce.xrce129 = l_xrce.xrce119 * g_xrca.xrca121
      END IF
   END IF
   IF g_glaa.glaa019 = 'Y' THEN
      IF g_glaa.glaa021 = '1' THEN
         LET l_xrce.xrce139 = l_xrce.xrce109 * g_xrca.xrca131
      ELSE
         LET l_xrce.xrce139 = l_xrce.xrce119 * g_xrca.xrca131
      END IF
   END IF
   UPDATE xrca_t SET xrca106 = l_xrce.xrce109,
                     xrca116 = l_xrce.xrce119,
                     xrca126 = l_xrce.xrce129,
                     xrca136 = l_xrce.xrce139
    WHERE xrcaent = g_enterprise
      AND xrcadocno = g_xrca.xrcadocno
      AND xrcald = g_xrca.xrcald
  #150316-00013#1 By 01727 Add  ---(E)---

END FUNCTION
################################################################################
# Descriptions...: 依據客戶編號獲取默認值
# Memo...........:
# Usage..........: CALL axrp133_xrca004_ref()
#                  RETURNING r_xrca.*
# Input parameter: 
# Return code....: r_xrca         返回默认值
# Date & Author..: 2014/10/17 By zhangweib
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp133_xrca004_ref(p_xrca100)
DEFINE p_xrca100      LIKE xrca_t.xrca100
DEFINE l_site         LIKE xrca_t.xrcasite
DEFINE l_ooba002      LIKE ooba_t.ooba002
DEFINE l_success      LIKE type_t.num5
DEFINE l_pmab085      LIKE pmab_t.pmab085
DEFINE l_oodbl004     LIKE oodbl_t.oodbl004
DEFINE l_oodb011      LIKE oodb_t.oodb011
#161128-00061#3-----modify--begin----------
#DEFINE l_ooib         RECORD LIKE ooib_t.*
DEFINE l_ooib RECORD  #收付款條件主檔
       ooibent LIKE ooib_t.ooibent, #企業編號
       ooibownid LIKE ooib_t.ooibownid, #資料所有者
       ooibowndp LIKE ooib_t.ooibowndp, #資料所屬部門
       ooibcrtid LIKE ooib_t.ooibcrtid, #資料建立者
       ooibcrtdp LIKE ooib_t.ooibcrtdp, #資料建立部門
       ooibcrtdt LIKE ooib_t.ooibcrtdt, #資料創建日
       ooibmodid LIKE ooib_t.ooibmodid, #資料修改者
       ooibmoddt LIKE ooib_t.ooibmoddt, #最近修改日
       ooibstus LIKE ooib_t.ooibstus, #狀態碼
       ooib001 LIKE ooib_t.ooib001, #收款/付款
       ooib002 LIKE ooib_t.ooib002, #收付款條件編號
       ooib004 LIKE ooib_t.ooib004, #款別性質
       ooib005 LIKE ooib_t.ooib005, #慣用繳款優惠條件
       ooib006 LIKE ooib_t.ooib006, #訂金收取否
       ooib007 LIKE ooib_t.ooib007, #現付交易否
       ooib011 LIKE ooib_t.ooib011, #應收付款起算基準
       ooib012 LIKE ooib_t.ooib012, #應收付款日加(季)
       ooib013 LIKE ooib_t.ooib013, #應收付款日加(月)
       ooib014 LIKE ooib_t.ooib014, #應收付款日加(日)
       ooib021 LIKE ooib_t.ooib021, #帳款兌現起算基準
       ooib022 LIKE ooib_t.ooib022, #帳款兌現日加(季)
       ooib023 LIKE ooib_t.ooib023, #帳款兌現日加(月)
       ooib024 LIKE ooib_t.ooib024, #帳款兌現日加(日)
       ooib025 LIKE ooib_t.ooib025, #慣用多帳期類型　
       ooib026 LIKE ooib_t.ooib026  #尾款性質
       END RECORD
#161128-00061#3-----modify--end----------
DEFINE r_xrca         RECORD
          xrca005     LIKE xrca_t.xrca005,
          xrca006     LIKE xrca_t.xrca006,
          xrca007     LIKE xrca_t.xrca007,
          xrca008     LIKE xrca_t.xrca008,
          xrca009     LIKE xrca_t.xrca009,
          xrca010     LIKE xrca_t.xrca010,
          xrca011     LIKE xrca_t.xrca011,
          xrca012     LIKE xrca_t.xrca012,
          xrca013     LIKE xrca_t.xrca013,
          xrca014     LIKE xrca_t.xrca014,
          xrca015     LIKE xrca_t.xrca015,
          xrca046     LIKE xrca_t.xrca046,
          xrca058     LIKE xrca_t.xrca058,
          xrca061     LIKE xrca_t.xrca061,
          xrca100     LIKE xrca_t.xrca100,
          xrca101     LIKE xrca_t.xrca101,
          xrca121     LIKE xrca_t.xrca121,
          xrca131     LIKE xrca_t.xrca131
                      END RECORD
DEFINE l_pmab057      LIKE pmab_t.pmab057
#151012-00014#1--add--str--lujh
DEFINE ls_js          STRING
DEFINE lc_param       RECORD
       apca004        LIKE apca_t.apca004,
       sfin2009       LIKE type_t.chr1     
                      END RECORD
#151012-00014#1--add--end--lujh
DEFINE l_cnt      LIKE type_t.num5      #160505-00005#1
DEFINE l_xrcacomp LIKE xrca_t.xrcacomp  #160505-00005#1

   #新增/修改帳款對象後,依帳款對象更新客戶慣用資料
   
   ################################################
   #      STEP1-7 欄位取用原則:
   #      依帳務人員所屬 site  取出該客戶的相關欄位
   #      若取不到時再取 xrcacomp =pmabsite  為條件取  
   ################################################  

   #160505-00005#1# add--str--
   #检查是否抛转据点，若没则抓取pmabsite=ALL的相关栏位资料
   LET l_cnt = 0
   LET l_xrcacomp = NULL
   SELECT COUNT(*) INTO l_cnt FROM pmab_t WHERE pmabent = g_enterprise AND pmabsite = g_xrca.xrcacomp AND pmab001 = g_xrca.xrca004
   IF l_cnt = 0 THEN 
      LET l_xrcacomp = "ALL" 
   ELSE
      LET l_xrcacomp = g_xrca.xrcacomp   
   END IF
   #160505-00005#1# add--end--

   SELECT DISTINCT ooag004 INTO l_site
     FROM ooag_t
    WHERE ooag001 = g_user AND ooagstus ='Y' 
      AND ooagent = g_enterprise #160905-00007#3 add
   
   #STEP1.獲取交易對象簡稱
   
   #STEP2.帶出主要應收條件
   SELECT pmab087 INTO r_xrca.xrca008 FROM pmab_t
    WHERE pmabent = g_enterprise AND pmabsite = l_xrcacomp AND pmab001 = g_xrca.xrca004  #160505-00005#1# g_xrca.xrcacomp--->l_xrcacomp
   
   #應收日期/票據到期日
  #161128-00061#3-----modify--begin----------
  #SELECT * INTO l_ooib.* 
   SELECT ooibent,ooibownid,ooibowndp,ooibcrtid,ooibcrtdp,ooibcrtdt,ooibmodid,ooibmoddt,ooibstus,
          ooib001,ooib002,ooib004,ooib005,ooib006,ooib007,ooib011,ooib012,ooib013,ooib014,ooib021,
          ooib022,ooib023,ooib024,ooib025,ooib026 INTO l_ooib.* 
  #161128-00061#3-----modify--end----------
   FROM ooib_t WHERE ooibent = g_enterprise AND ooib001 = '2' AND ooib002 = r_xrca.xrca008
   CALL s_fin_date_ar_receivable(g_xrca.xrcasite,g_xrca.xrca004,r_xrca.xrca008,g_xrca.xrcadocdt,
     g_xrca.xrcadocdt,g_xrca.xrcadocdt,'') RETURNING l_success,r_xrca.xrca009,r_xrca.xrca010
   
   #STEP3.帳款類別
   SELECT pmab105 INTO r_xrca.xrca007 FROM pmab_t
    WHERE pmabent = g_enterprise AND pmabsite = l_xrcacomp AND pmab001 = g_xrca.xrca004 #160505-00005#1# g_xrca.xrcacomp--->l_xrcacomp
   
   #STEP4.業務人員/業務部門
   SELECT pmab081 INTO r_xrca.xrca014 FROM pmab_t
    WHERE pmabent = g_enterprise AND pmabsite = l_xrcacomp AND pmab001 = g_xrca.xrca004  #160505-00005#1# g_xrca.xrcacomp--->l_xrcacomp
   SELECT ooag003 INTO r_xrca.xrca015 FROM ooag_t
    WHERE ooagent = g_enterprise AND ooag001 = r_xrca.xrca014
   
   #STEP5.稅別/含稅否/稅率
   SELECT pmab084 INTO r_xrca.xrca011 FROM pmab_t
    WHERE pmabent = g_enterprise AND pmabsite = l_xrcacomp AND pmab001 = g_xrca.xrca004  #160505-00005#1# g_xrca.xrcacomp--->l_xrcacomp  
   CALL s_tax_chk(g_glaa.glaacomp,r_xrca.xrca011) RETURNING l_success,l_oodbl004,r_xrca.xrca013,r_xrca.xrca012,l_oodb011
   
   #STEP6.慣用幣別/匯率
  #LET r_xrca.xrca100 = g_glaa.glaa001    #150518-00044#5--mark
   LET r_xrca.xrca100 = p_xrca100         #150518-00044#5
   
   #計算各個本位筆匯率
   #150518-00044#5--(S)
   CALL s_apmm101_sel_pmab(l_xrcacomp,g_xrca.xrca004,'pmab057') RETURNING l_success,g_errno,l_pmab057 #160505-00005#1# g_xrca.xrcacomp--->l_xrcacomp
   CASE l_pmab057
        WHEN '1'
            CALL cl_get_para(g_enterprise,g_xrca.xrcacomp,'S-BAS-0010') RETURNING g_glaa.glaa025
        WHEN '2'
            CALL cl_get_para(g_enterprise,g_xrca.xrcacomp,'S-BAS-0011') RETURNING g_glaa.glaa025
   END CASE
   
   #150518-00044#5--(E)
   
   #151012-00014#1--mark--str--lujh
   #CASE g_master.b_comb1
   #   WHEN '2'  #依立帳日匯率(aooi160)
   #       CALL s_aooi160_get_exrate('2',g_master.xrcald,g_xrca.xrcadocdt,r_xrca.xrca100,g_glaa.glaa001,0,g_glaa.glaa025)
   #            RETURNING r_xrca.xrca101
   #   WHEN '3'  #依立帳日月平均匯率(aooi170)
   #       CALL s_aooi160_get_exrate_avg('2',g_master.xrcald,g_xrca.xrcadocdt,r_xrca.xrca100,g_glaa.glaa001,0,g_glaa.glaa025)
   #            RETURNING g_sub_success,g_errno,r_xrca.xrca101
   #END CASE
   #151012-00014#1--mark--end--lujh
   
   #151012-00014#1--add--str--lujh
   LET lc_param.apca004 = g_xrca.xrca004  
   LET lc_param.sfin2009 = g_master.b_comb1     #汇率基准   
   LET ls_js = util.JSON.stringify(lc_param)
   CALL s_fin_get_curr_rate(g_xrca.xrcacomp,g_master.xrcald,g_xrca.xrcadocdt,r_xrca.xrca100,ls_js)
      RETURNING r_xrca.xrca101,r_xrca.xrca121,r_xrca.xrca131
   #151012-00014#1--add--end--lujh

  #CALL s_axrt300_get_exrate(g_xrca.xrcadocdt,g_xrca.xrcald,g_xrca.xrcacomp,r_xrca.xrca100)
  #   RETURNING l_success,r_xrca.xrca101,r_xrca.xrca121,r_xrca.xrca131
   
   #STEP7.預開發票日
   SELECT pmab083 INTO l_pmab085 FROM pmab_t
    WHERE pmabent = g_enterprise AND pmabsite = l_xrcacomp AND pmab001 = g_xrca.xrca004 #160505-00005#1# g_xrca.xrcacomp--->l_xrcacomp

   IF NOT cl_null(l_pmab085) THEN
      IF l_pmab085 = '30' THEN
         #月結彙總開立發票
         IF MONTH(g_xrca.xrcadocdt) = 12 THEN
            #立帳日期為12月份,則依照條件開立發票日為12月31號
            LET r_xrca.xrca061 = MDY(12,31,YEAR(g_xrca.xrcadocdt))
         ELSE
            #立帳日期的下一個月減一天
            LET r_xrca.xrca061 = MDY(MONTH(g_xrca.xrcadocdt) + 1,1,YEAR(g_xrca.xrcadocdt)) - 1
         END IF
      ELSE
         LET r_xrca.xrca061 = g_xrca.xrcadocdt
      END IF
   END IF

   #SETP8.收款客戶   
   SELECT pmac002 INTO r_xrca.xrca005 FROM pmac_t
    WHERE pmacent = g_enterprise AND pmac001 = g_xrca.xrca004 
      AND pmac003 = '1' AND pmac004 = 'Y' AND pmacstus = 'Y'
   IF SQLCA.sqlcode = 100 THEN
      LET r_xrca.xrca005 = g_xrca.xrca004
   END IF
      
   #SETP9.關係人   
   SELECT pmaa047 INTO r_xrca.xrca046 FROM pmaa_t
    WHERE pmaaent = g_enterprise AND pmaa001 = g_xrca.xrca004     

   #SETP10.慣用銷售分類取
   SELECT pmab089 INTO r_xrca.xrca058 FROM pmab_t
    WHERE pmabent = g_enterprise AND pmabsite = l_xrcacomp AND pmab001 = g_xrca.xrca004  #160505-00005#1# l_site--->l_xrcacomp
   
   #SETP11.客戶分類
   SELECT pmaa090 INTO r_xrca.xrca006 FROM pmaa_t
    WHERE pmaaent = g_enterprise AND pmaa001 = g_xrca.xrca004 

   RETURN r_xrca.*

END FUNCTION
################################################################################
# Descriptions...: 將直接收款中應稅折抵的資料回攤至單身
# Memo...........:
# Usage..........: CALL axrp133_upd_xrcb()
#                  RETURNING ---
# Input parameter: 
# Return code....: 
# Date & Author..: 2014/10/17 By zhangweib
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp133_upd_xrcb()
   DEFINE l_sql         STRING
   DEFINE l_xrca108     LIKE xrca_t.xrca108
   DEFINE l_xrca118     LIKE xrca_t.xrca118
   DEFINE l_xrca128     LIKE xrca_t.xrca128
   DEFINE l_xrca138     LIKE xrca_t.xrca138
   DEFINE l_xrca108_o   LIKE xrca_t.xrca108
   DEFINE l_xrca118_o   LIKE xrca_t.xrca118
   DEFINE l_xrca128_o   LIKE xrca_t.xrca128
   DEFINE l_xrca138_o   LIKE xrca_t.xrca138
   DEFINE l_xrca108_v   LIKE xrca_t.xrca108
   DEFINE l_xrca118_v   LIKE xrca_t.xrca118
   DEFINE l_xrca128_v   LIKE xrca_t.xrca128
   DEFINE l_xrca138_v   LIKE xrca_t.xrca138
   DEFINE l_amt         LIKE xrcb_t.xrcb105
   DEFINE l_xrcbdocno   LIKE xrcb_t.xrcbdocno
   DEFINE l_xrcbseq     LIKE xrcb_t.xrcbseq
   DEFINE l_xrcb105     LIKE xrcb_t.xrcb105
   DEFINE l_count       LIKE type_t.num5

   SELECT COUNT(*) INTO l_count FROM xrce_t WHERE xrceent = g_enterprise
      AND xrcedocno = g_xrca.xrcadocno AND xrceld = g_master.xrcald
      AND xrce027 = 'Y'

   IF l_count = 0 THEN RETURN END IF

   SELECT SUM(xrca108),SUM(xrca118),SUM(xrca128),SUM(xrca138)
     INTO l_xrca108,l_xrca118,l_xrca128,l_xrca138
     FROM xrca_t
    WHERE xrcald = g_master.xrcald
      AND xrcaent = g_enterprise #160905-00007#3 add
      AND xrca019 IN (SELECT xrcadocno FROM xrca_t,xrce_t
                       WHERE xrcaent = xrceent AND xrcald = xrceld AND xrcadocno = xrce003
                         AND xrcaent = g_enterprise   #160905-00007#3 add
                         AND xrcedocno = g_xrca.xrcadocno AND xrceld = g_master.xrcald AND xrce027 = 'Y')

   LET l_xrca108_o = l_xrca108
   LET l_xrca118_o = l_xrca118
   LET l_xrca128_o = l_xrca128
   LET l_xrca138_o = l_xrca138

   SELECT SUM(xrcb105) INTO l_amt FROM xrcb_t
    WHERE xrcbent = g_enterprise AND xrcbdocno = g_xrca.xrcadocno AND xrcbld = g_master.xrcald

   LET l_sql = "SELECT xrcbdocno,xrcbseq,xrcb105/",l_amt," FROM xrcb_t ",
               " WHERE xrcbent = '",g_enterprise,"' AND xrcbdocno = '",g_xrca.xrcadocno,"' AND xrcbld = '",g_master.xrcald,"'",
               " ORDER BY xrcb105 ASC"
   PREPARE axrp133_xrce_prep3 FROM l_sql
   DECLARE axrp133_xrce_curs3 CURSOR FOR axrp133_xrce_prep3

   LET l_xrca108_v = 0
   LET l_xrca118_v = 0
   LET l_xrca128_v = 0
   LET l_xrca138_v = 0

   FOREACH axrp133_xrce_curs3 INTO l_xrcbdocno,l_xrcbseq,l_xrcb105
      LET l_xrca108_o = s_curr_round(g_xrca.xrcacomp,g_xrca.xrca100,l_xrca108 * l_xrcb105,2)
      LET l_xrca118_o = s_curr_round(g_xrca.xrcacomp,g_glaa.glaa001,l_xrca118 * l_xrcb105,2)
      LET l_xrca128_o = s_curr_round(g_xrca.xrcacomp,g_glaa.glaa016,l_xrca128 * l_xrcb105,2)
      LET l_xrca138_o = s_curr_round(g_xrca.xrcacomp,g_glaa.glaa020,l_xrca138 * l_xrcb105,2)

      UPDATE xrcb_t SET xrcb106 = l_xrca108_o,
                        xrcb116 = l_xrca118_o,
                        xrcb126 = l_xrca128_o,
                        xrcb136 = l_xrca138_o
       WHERE xrcbent = g_enterprise AND xrcbdocno = l_xrcbdocno AND xrcbld = g_master.xrcald AND xrcbseq = l_xrcbseq

      LET l_xrca108_v = l_xrca108_v + l_xrca108_o
      LET l_xrca118_v = l_xrca118_v + l_xrca118_o
      LET l_xrca128_v = l_xrca128_v + l_xrca128_o
      LET l_xrca138_v = l_xrca138_v + l_xrca138_o

   END FOREACH

   LET l_xrca108 = l_xrca108 - l_xrca108_v
   LET l_xrca118 = l_xrca118 - l_xrca118_v
   LET l_xrca128 = l_xrca128 - l_xrca128_v
   LET l_xrca138 = l_xrca138 - l_xrca138_v

   UPDATE xrcb_t SET xrcb106 = xrcb106 + l_xrca108,
                     xrcb116 = xrcb116 + l_xrca118,
                     xrcb126 = xrcb126 + l_xrca128,
                     xrcb136 = xrcb136 + l_xrca138
    WHERE xrcbent = g_enterprise AND xrcbdocno = l_xrcbdocno AND xrcbld = g_master.xrcald AND xrcbseq = l_xrcbseq


END FUNCTION

################################################################################
# Descriptions...: 取得默認會計科目
# Memo...........:
# Usage..........: CALL axrp133_get_glab(p_glabld,p_glab001,p_glab002,p_glab003)
#                  RETURNING r_glab005
# Input parameter: p_glabld       帳套
#                : p_glab001      設定類型
#                : p_glab002      分類碼
#                : p_glab003      分類碼值
# Return code....: r_glab005      會計科目
# Date & Author..: 2014/10/17 By zhangweib
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp133_get_glab(p_glabld,p_glab001,p_glab002,p_glab003)
   DEFINE p_glabld         LIKE glab_t.glabld
   DEFINE p_glab001        LIKE glab_t.glab001
   DEFINE p_glab002        LIKE glab_t.glab002
   DEFINE p_glab003        LIKE glab_t.glab003
   
   DEFINE r_glab005        LIKE glab_t.glab005

   SELECT glab005 INTO r_glab005 FROM glab_t
    WHERE glabent = g_enterprise AND glabld = p_glabld AND glab001 = p_glab001 AND glab002 = p_glab002 AND glab003 = p_glab003

   RETURN r_glab005

END FUNCTION

#end add-point
 
{</section>}
 
