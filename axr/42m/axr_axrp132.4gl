#該程式未解開Section, 採用最新樣板產出!
{<section id="axrp132.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0039(2016-09-20 15:02:57), PR版次:0039(2017-01-12 10:33:57)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000172
#+ Filename...: axrp132
#+ Description: 發票批次立帳作業
#+ Creator....: 01727(2014-10-13 10:29:12)
#+ Modifier...: 01727 -SD/PR- 02114
 
{</section>}
 
{<section id="axrp132.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#20150201#1                   By zhangwei 為了規避多用戶並行執行程序導致出貨/銷退單重複拋磚應收,對拋轉邏輯進行修改：
#                                         取得符合條件的資料集後,在FOREACH中每一筆資料單獨走一次事物
#                                         在事物中,先將取得的出貨/銷退單鎖住,然後再進行拋轉前的欄位複製
#                                         最後再插入應收表之前，再次判斷出貨單/銷退單的可用性
#                                         在拋轉應收結束後無論成功否放開出貨單/銷退單資料
#                                         最後將失敗的資料和成功的資料用資料匯總報錯出來
#150316-00013#1               By 01727    直接沖帳段可用金額的取得,需要再扣除已沖帳未審核的金額
#150515-00013#3               By 01727    檢查， 若為本位幣立帳者，本幣金額=原幣金額， 本幣不要重算s_tax
#150603-00046#1               By Reanna   增加aist310呼叫接收的變數
#150518-00039#4               By albireo  增加aisp320呼叫階收的參數
#150807-00010#1   2015/08/10  By Belle    若為axmt600的金額折讓xrcb021取理由碼的會科
#1508170001       2015/08/17  By Belle    Kris:axrp132  折襄單時, 應取銷貨退回的會科
#150904-00006#3   150907      By albireo  商用發票號碼欄位帶入
#150918-00001#7   150922      By albireo  商用發票號碼有值的時候代表是外銷 把單頭發票號碼也用商用發票號碼取代
#150828-00001#2   2015/10/23  By 01727    axrt3* 的程式 xrcb005 存品名加規格, 中間以 '/' 區間
#151013-00019#7   2015/10/28  By Reanna   銷退方式改1&4都要先用理由碼取會科
#150615-00017#2   2015/10/30  By 01727    對帳單已立應收帳款單的判斷, 取對帳單主檔的"應收單號"判斷。
#151125-00006#1   2015/12/05  By 06862    生成后單據后立即審核，立即拋轉傳票
#151214-00018#1   2015/12/14  By 01727    AXR 應取 aist310 單身形成不再重計稅額
#151130-00015#3   2015/12/29  By 01727    訂金沖銷依aoos020 參數 S-FIN-2020  是否依單核銷訂金 則只能沖同一張訂單之訂金
#160125-00005#4   2016/01/27  By 01727    axrp132/ axrp133 取消以單頭稅別為 group 的條件,若依單據彙總則取單據稅別, 
#                                         其他彙總條件則 xrca 單頭稅別帶交易對象慣用稅別
#151231-00010#9   2016/03/04  By 02599    增加控制组权限控管
#150518-00046#5   2016/03/09  By Jessy    增加aisp340呼叫接收的程式段
#160317-00018#1   2016/03/18  By 01727    1.axrp132转axrt300,axrt300单身的来源组织应该取aist310单身的来源组织，目前是取的法人
#                                         2.多账期xrcc,发票号码没有抓进来(isat004)
#                                         3.未回写aist310 应收单号
#160120-00011#3   2016/03/23  By 02114    1.取用 s_get_item_acc時, 須增加補足可傳入的參數值 
#                                         (1). AXR:取用s_get_item_acc時, 須增加補足可傳入的參數值 
#                                         p_kind   採購分群  :  取單頭的 【銷售分類xrca058】 
#                                         p_trade  交易通路  :  傳入渠道, 取單身的【渠道xrcb034】 
#                                         p_site   營運據點  :  不變 #                  
#                                         p_ware   倉庫別    :  取來源單號的庫別欄位, 即出貨/銷退單的【庫別xmdl014】;  無對應來源單號者，則以空白傳入。
#160318-00005#51  2016/03/23  By 07959    將重複內容的錯誤訊息置換為公用錯誤訊息
#160325-00023#1   2016/03/29  By Hans     單別流程-預設單別修改 根據aooi210設置之流程修改單別合理性
#160318-00025#42  2016/04/25  By pengxin  將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160505-00005#1   2016/05/06  By 01531    取法人據點之交易對象檔,若取不到法人據點時, 取 據點代碼='ALL'
#160511-00016#1   2016/05/11  By 01531    生成的单据单身冲暂估否为空
#160415-00010#1   2016/05/18  By albireo  有在發票歷程檔中有效發票才撈出的控制
#160426-00013#1   2016/05/30  By Reanna   增加訂金發票流程
#160620-00010#3   2016/06/21  By 06821    對帳來源若選2.雜項發票,應收單別開立應為axrt330,QBE單號開窗條件組入,自動沖銷選項皆不勾選
#151008-00009#8   2016/06/23  By 03538    有設定對應的遞延類型,則要產生遞延收入檔,並且影響分錄底稿
#160727-00019#5   2016/07/28  By 08734    将axrp132_isaf_tmp ——> axrp132_tmp01
#160727-00019#5   2016/07/28  By 08734    将axrp131_xmdk_tmp ——> axrp131_tmp01
#160810-00015#1   2016/08/10  By 01727    应该在写入单身xrcb之前给xrcb023赋值,然后在产生xrcb资料之后产生多帐期
#160810-00043#1   2016/08/15  By 01727    在整批复制xrcd资料是,要给账套栏位复制
#160731-00372#1   2016/08/16  By 07900    客户开窗不要开供应商
#160811-00009#4   2016/08/19  By 01531    账务中心/法人/账套权限控管
#160830-00047#1   2016/08/30  BY 01727    axrp13*抛转应收单据没有给单身xrcb102默认值
#160826-00004#1   2016/09/01  By 00768    事务中有进行临时表的drop等异动导致事务破坏，导致数据的异常
#160905-00007#3   2016/09/05  By zhujing  调整系统中无ENT的SQL条件增加ent
#160909-00084#1   2016/09/12  By 01727    将146主机修改的内容追回产中
#160914-00013#1   2016/09/20  By 01727    匯率選項預設為:依原單匯率, 並隱藏
#160920-00004#1   2016/09/21  By 01727    axrp132自动产生到axrt300的冲暂估信息明细有多笔，通过整批删除/整批产生就OK了
#160913-00017#7   2016/09/22  By 07900    AXR模组调整交易客商开窗
#160802-00007#1   2016/09/26  By 01727    一次性交易對象識別碼(pmaa004=2)功能應用
#160912-00034#1   2016/09/28  By 02114    aist310转应收到axrt300时项目编号、WBS没有生成
#160921-00018#1   2016/10/10  By 01727    计算应收款日和票到期日日期使用错误
#160920-00013#1   2016/10/11  By 08171    1.新增對帳來源 5.雜項待抵SCC 9715
#                                         2.發票類型則為 aisi030 進銷項為4:銷項折讓證明單資料
#                                         3.應收帳款串查為 axrt341
#                                         axrp132 當對帳來源為 5.雜項待抵時產生到 axrt341,xrca001 為 29,其他維持原對應關係
#161014-00046#1   2016/10/17  By Reanna   處理銷退單依照不同銷退方式抓取axri011的會科
#161021-00050#2   2016/10/24  By 08729    處理組織開窗
#161025-00017#1   2016/10/26  By 01531    出货单axmt540的销售渠道xmdk030需带入应收单身的渠道xrcb034 
#160922-00055#2   2016/11/08  By 06821    aist310整單操作產生應收帳款時,請將對帳來源作為 axrp132 對帳來源預設值
#161110-00009#1   2016/11/18  By 01727    axrp132抛转至axrt310时,来源记录12
#161117-00043#1   2016/11/18  By 01727    執行axrp132時,產生axrt300,其發票號碼的欄位帶的是aist310商用發票的值
#161118-00026#1   2016/11/22  By 01727    1.若透過 aist310 整單操作呼叫 axrp132 時,單別開窗無資料問題處理
#                                         2.對帳來源為 1.出貨發票時,整單操作呼叫 axrp132 時自動沖銷選項的訂金待抵不可自動打勾. 應開放人為決定
#                                         3.若 aist310 為出貨發票時, 單身對應的 27待抵單 若有微調金額,請以微調後的金額作為產生 axrt300 的直接沖帳金額
#161111-00049#6   2016/11/24  By 01727    控制组权限修改
#161114-00028#1   2016/11/30  By 01727    新增单身时,每次科目赋值之前都需要清空科目编号的值
#161128-00061#3   2016/12/01  by 02481    标准程式定义采用宣告模式,弃用.*写法
#161205-00014#1   2016/12/05  By Reanna   axrt300的商用發票號碼應放aist310上的商用發票號碼
#161219-00031#1   2016/12/19  By 02114    没有发票号码时,就用IV号（商业发票)
#170112-00010#1   2017/01/12  By 02114    axrp132不同ent下有相同单据,产生到axrt330时会把所有ent下的单据都产生到axrt330单身
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
        progflag         LIKE gzza_t.gzza001, #150518-00046#5 add 傳入程式代號
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
   l_isaf001 LIKE type_t.chr1, 
   xrcadocno LIKE xrca_t.xrcadocno, 
   xrca007 LIKE xrca_t.xrca007, 
   xrcadocdt LIKE xrca_t.xrcadocdt, 
   b_check1 LIKE type_t.chr500, 
   b_check4 LIKE type_t.chr500, 
   b_check2 LIKE type_t.chr500, 
   b_check5 LIKE type_t.chr500, 
   b_check3 LIKE type_t.chr500, 
   b_check6 LIKE type_t.chr500, 
   l_chkisat LIKE type_t.chr1, 
   b_comb2 LIKE type_t.chr500, 
   b_comb1 LIKE type_t.chr500, 
   isafdocno LIKE isaf_t.isafdocno, 
   fflabel_desc LIKE type_t.chr80, 
   isaf002 LIKE isaf_t.isaf002, 
   isaf010 LIKE isaf_t.isaf010, 
   isaf003 LIKE isaf_t.isaf003, 
   isaf011 LIKE isaf_t.isaf011, 
   isaf055 LIKE isaf_t.isaf055, 
   isaf014 LIKE isaf_t.isaf014, 
   isaf004 LIKE isaf_t.isaf004, 
   isaf016 LIKE isaf_t.isaf016, 
   isaf057 LIKE isaf_t.isaf057, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
#20150201#1 By zhangwei Add ---(S)---
TYPE type_isaf_d        RECORD
        order              LIKE type_t.chr200,
        isafdocno          LIKE isaf_t.isafdocno,
        isafcomp           LIKE isaf_t.isafcomp,
        isagseq            LIKE isag_t.isagseq
                        END RECORD
DEFINE g_isaf_d DYNAMIC ARRAY OF type_isaf_d
#20150201#1 By zhangwei Add ---(E)---
DEFINE g_ref_fields     DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars       DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields     DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
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
DEFINE g_sql_ctrl       STRING              #151231-00010#9 add
DEFINE g_progflag       LIKE gzza_t.gzza001 #150518-00046#5 程式代號
#160426-00013#1 add ------
DEFINE g_sfin2022       LIKE type_t.chr10
DEFINE g_end_prog       LIKE gzza_t.gzza001
#160426-00013#1 add end---
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axrp132.main" >}
MAIN
   #add-point:main段define (客製用) name="main.define_customerization"
   
   #end add-point 
   DEFINE ls_js    STRING
   DEFINE lc_param type_parameter  
   #add-point:main段define name="main.define"
 
   #end add-point 
  
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("axr","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   #test json ---
   #LET g_argv[01] = "{\"xrcasite\":\"DSCTP\",\"xrcald\":\"02\",\"l_isaf001\":\"1\",\"xrcadocno\":\"30B\",\"xrca007\":\"AR01\",\"xrcadocdt\":\"2016-07-22\",\"b_check1\":\"N\",\"b_check4\":\"N\",\"b_check2\":\"N\",\"b_check5\":\"N\",\"b_check3\":\"N\",\"b_check6\":\"N\",\"b_comb1\":\"1\",\"b_comb2\":\"1\",\"wc\":\" isafdocno = 'CTP-V01-201607000001'\"}"
   #LET g_bgjob = "Y" 
   #test json ---
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
 
      #end add-point
      CALL axrp132_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axrp132 WITH FORM cl_ap_formpath("axr",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL axrp132_init()
 
      #進入選單 Menu (="N")
      CALL axrp132_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_axrp132
   END IF
 
   #add-point:作業離開前 name="main.exit"
 
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="axrp132.init" >}
#+ 初始化作業
PRIVATE FUNCTION axrp132_init()
 
   #add-point:init段define (客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:ui_dialog段define name="init.define"
   DEFINE l_success      LIKE type_t.num5
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
   CALL s_fin_create_account_center_tmp()
   CALL s_voucher_cre_ar_tmp_table() RETURNING l_success
   #151125-00006#1---add---s
   CALL s_pre_voucher_cre_tmp_table() RETURNING l_success 
   CALL s_fin_continue_no_tmp() 
   #151125-00006#1---add---e
   CALL cl_set_combo_scc('b_comb1','9951')    #151012-00014#1 add lujh
   #151231-00010#9--add--str--
   LET g_sql_ctrl = NULL
   CALL s_control_get_customer_sql('2',g_site,g_user,g_dept,'') RETURNING g_sub_success,g_sql_ctrl
   #151231-00010#9--add--end
   CALL cl_set_combo_scc('l_isaf001','9715') #160426-00013#1
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axrp132.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axrp132_ui_dialog()
 
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
   DEFINE l_ooef004         LIKE ooef_t.ooef004
   DEFINE l_ooef019         LIKE ooef_t.ooef019
   DEFINE l_s               LIKE type_t.num5
   
   #150210-00011(1)--20150330--add--
   DEFINE  l_flag1          LIKE type_t.chr1       
   DEFINE  l_errno          LIKE type_t.chr100
   #150210-00011(1)--20150330--add--
   DEFINE  l_ooba002        LIKE type_t.chr10     #151209-00023#1 add lujh
   DEFINE l_where           STRING                #160325-00023#1
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   INITIALIZE g_master.* TO NULL
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.xrcasite,g_master.xrcald,g_master.b_style,g_master.l_isaf001,g_master.xrcadocno, 
             g_master.xrca007,g_master.xrcadocdt,g_master.b_check1,g_master.b_check4,g_master.b_check2, 
             g_master.b_check5,g_master.b_check3,g_master.b_check6,g_master.l_chkisat,g_master.b_comb2, 
             g_master.b_comb1 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               CALL axrp132_def()
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
               #161111-00049#6 Add  ---(S)---
               CALL s_control_get_customer_sql_pmab('4',g_site,g_user,g_dept,'',g_glaa.glaacomp)
                  RETURNING g_sub_success,g_sql_ctrl
               #161111-00049#6 Add  ---(E)---
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
               #IF g_master.b_style = 'axrt340' THEN #160920-00013#1 mark
               IF g_master.b_style = 'axrt340' OR g_master.b_style = 'axrt341' THEN #160920-00013#1 add
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
               LET g_master.xrcadocno = ''
               DISPLAY BY NAME g_master.xrcadocno
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_isaf001
            #add-point:BEFORE FIELD l_isaf001 name="input.b.l_isaf001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_isaf001
            
            #add-point:AFTER FIELD l_isaf001 name="input.a.l_isaf001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_isaf001
            #add-point:ON CHANGE l_isaf001 name="input.g.l_isaf001"
            #160426-00013#1 add ------
            IF NOT cl_null(g_master.l_isaf001) THEN
               #IF g_master.l_isaf001 MATCHES '[34]' THEN #3:訂金發票/4:待抵銷退            #160620-00010#3 mark
               #IF g_master.l_isaf001 MATCHES '[234]' THEN #2:雜項發票/3:訂金發票/4:待抵銷退  #160620-00010#3 add
               IF g_master.l_isaf001 MATCHES '[2345]' THEN #2:雜項發票/3:訂金發票/4:待抵銷退/5:雜項代抵  #160920-00013#1 add
                  LET g_master.b_check1 = 'N'
                  LET g_master.b_check2 = 'N'
                  LET g_master.b_check3 = 'N'
                  LET g_master.b_check4 = 'N'
                  LET g_master.b_check5 = 'N'
                  LET g_master.b_check6 = 'N'
                  CALL cl_set_comp_entry('b_check1,b_check2,b_check3,b_check4,b_check5,b_check6',FALSE)
                  #160620-00010#3 --s add
                  IF g_master.l_isaf001 = '2' THEN
                     CALL cl_set_comp_entry('b_check1,b_check2,b_check3,b_check4,b_check5,b_check6',TRUE)
                  END IF
                  #160620-00010#3 --e add
               ELSE
                  LET g_master.b_check1 = 'Y'
                  CALL cl_set_comp_entry('b_check1,b_check2,b_check3,b_check4,b_check5,b_check6',TRUE)
               END IF
               LET g_master.xrcadocno = ''
               DISPLAY BY NAME g_master.xrcadocno
               CASE g_master.l_isaf001
                  WHEN '1' #1:出貨發票
                     LET g_end_prog = 'axrt300'
                  #160620-00010#3 --s add
                  WHEN '2' #1:雜項發票
                     LET g_end_prog = 'axrt330'
                  #160620-00010#3 --e add
                  WHEN '3' #3:訂金發票
                     LET g_sfin2022 = cl_get_para(g_enterprise,g_glaa.glaacomp,'S-FIN-2022')
                     IF g_sfin2022 = '01' THEN
                        #01:認列收入
                        LET g_end_prog = 'axrt300'
                     ELSE
                        #02:認列預收
                        LET g_end_prog = 'axrt310'
                     END IF
                  WHEN '4' #4:待抵銷退
                     LET g_end_prog = 'axrt340'
                  WHEN '5' #5:雜項待抵           #160920-00013#1 add
                     LET g_end_prog = 'axrt341' #160920-00013#1 add
               END CASE
            END IF
            #160426-00013#1 add end---
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
              #IF NOT s_aooi200_fin_chk_slip(g_glaa.glaald,g_glaa.glaa024,g_master.xrcadocno,g_master.b_style) THEN #160426-00013#1 mark
               IF NOT s_aooi200_fin_chk_slip(g_glaa.glaald,g_glaa.glaa024,g_master.xrcadocno,g_end_prog) THEN       #160426-00013#1
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
         BEFORE FIELD l_chkisat
            #add-point:BEFORE FIELD l_chkisat name="input.b.l_chkisat"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_chkisat
            
            #add-point:AFTER FIELD l_chkisat name="input.a.l_chkisat"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_chkisat
            #add-point:ON CHANGE l_chkisat name="input.g.l_chkisat"
            
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

            #CALL q_ooef001()                                        #呼叫開窗    #161021-00050#2 mark
            LET g_qryparam.where = " ooefstus = 'Y' "                            #161021-00050#2 add
            CALL q_ooef001_46()                                                  #161021-00050#2 add
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
            CALL axrp132_get_ooef001_wc(ls_wc) RETURNING ls_wc  
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.xrcald             #給予default值
#160811-00009#4 mod s---               
#               IF NOT cl_null(ls_wc) AND ls_wc <> '(\'\')' THEN
#                  LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN ",ls_wc,""
#               ELSE
#                  LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y')"
#               END IF
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
 
 
         #Ctrlp:input.c.l_isaf001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_isaf001
            #add-point:ON ACTION controlp INFIELD l_isaf001 name="input.c.l_isaf001"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrcadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcadocno
            #add-point:ON ACTION controlp INFIELD xrcadocno name="input.c.xrcadocno"
            #應收單別
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.xrcadocno
            SELECT ooef004 INTO l_ooef004 from ooef_t where ooefent = g_enterprise AND ooef001 = g_glaa.glaacomp
            LET g_qryparam.arg1 = g_glaa.glaa024
            #LET g_qryparam.arg2 = g_master.b_style  #160426-00013#1 mark
            LET g_qryparam.arg2 = g_end_prog         #160426-00013#1
            CALL q_ooba002_1()
            LET g_master.xrcadocno = g_qryparam.return1
            DISPLAY g_master.xrcadocno TO xrcadocno
            NEXT FIELD xrcadocno
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
 
 
         #Ctrlp:input.c.l_chkisat
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_chkisat
            #add-point:ON ACTION controlp INFIELD l_chkisat name="input.c.l_chkisat"
            
            #END add-point
 
 
         #Ctrlp:input.c.b_comb2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_comb2
            #add-point:ON ACTION controlp INFIELD b_comb2 name="input.c.b_comb2"
            
            #END add-point
 
 
         #Ctrlp:input.c.b_comb1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_comb1
            #add-point:ON ACTION controlp INFIELD b_comb1 name="input.c.b_comb1"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON isafdocno,isaf002,isaf010,isaf003,isaf011,isaf055,isaf014, 
             isaf004,isaf016,isaf057
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.isafdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isafdocno
            #add-point:ON ACTION controlp INFIELD isafdocno name="construct.c.isafdocno"
            #開票單號
            #開窗c段
            #取得aooi210所設置之前置單別的合理性where 條件
            CALL s_aooi210_get_check_sql(g_master.xrcasite,'',g_master.xrcadocno,'4','','isafdocno') RETURNING g_sub_success,l_where   #160325-00023#1            
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #160426-00013#1 mark ------
            #IF g_master.b_style = 'axrt300' THEN
            #   LET g_qryparam.where = " isafcomp = '",g_glaa.glaacomp,"' AND isaf056 = '1' ",   #151209-00023#1 remove isafstus = 'Y' AND lujh
            #  #150615-00017#2 Add  ---(S)---
            #   "   AND NOT EXISTS (SELECT 1 FROM xrca_t,xrcb_t WHERE xrcaent = '",g_enterprise,"' AND xrcaent = xrcbent ",
            #   "                      AND xrcadocno = xrcbdocno AND xrcald = xrcbld AND xrca001 = '17' ",
            #   "                      AND xrcastus <> 'X' AND xrcb049 = isafdocno)"
            #  #150615-00017#2 Add  ---(E)---
            #ELSE
            #   LET g_qryparam.where = " isafcomp = '",g_glaa.glaacomp,"' AND isaf056 = '2' ",   #151209-00023#1 remove isafstus = 'Y' AND lujh
            #  #150615-00017#2 Add  ---(S)---
            #   "   AND NOT EXISTS (SELECT 1 FROM xrca_t,xrcb_t WHERE xrcaent = '",g_enterprise,"' AND xrcaent = xrcbent ",
            #   "                      AND xrcadocno = xrcbdocno AND xrcald = xrcbld AND xrca001 = '17' ",
            #   "                      AND xrcastus <> 'X' AND xrcb049 = isafdocno)"
            #  #150615-00017#2 Add  ---(E)---
            #END IF
            #160426-00013#1 mark end---
            #160426-00013#1 add ------
            CASE
               WHEN g_end_prog = 'axrt300' AND g_master.l_isaf001 = '1'
                  LET g_qryparam.where = " isafcomp = '",g_glaa.glaacomp,"' AND isaf001 <> '3' AND isaf056 = '1' ",
                  "   AND NOT EXISTS (SELECT 1 FROM xrca_t,xrcb_t WHERE xrcaent = '",g_enterprise,"' AND xrcaent = xrcbent ",
                  "                      AND xrcadocno = xrcbdocno AND xrcald = xrcbld AND xrca001 = '17' ",
                  "                      AND xrcastus <> 'X' AND xrcb049 = isafdocno)"
               #160620-00010#3 --s add
               WHEN g_end_prog = 'axrt330'
                  LET g_qryparam.where = " isafcomp = '",g_glaa.glaacomp,"' AND isaf001 = '2' AND isaf056 = '1' ",
                  "   AND NOT EXISTS (SELECT 1 FROM xrca_t,xrcb_t WHERE xrcaent = '",g_enterprise,"' AND xrcaent = xrcbent ",
                  "                      AND xrcadocno = xrcbdocno AND xrcald = xrcbld AND xrca001 = '19' ",
                  "                      AND xrcastus <> 'X' AND xrcb049 = isafdocno)"  
               #160620-00010#3 --e add
               WHEN g_end_prog = 'axrt300' AND g_master.l_isaf001 = '3'
                  LET g_qryparam.where = " isafcomp = '",g_glaa.glaacomp,"' AND isaf001 = '3' AND isaf056 = '1' ",
                  "   AND NOT EXISTS (SELECT 1 FROM xrca_t,xrcb_t WHERE xrcaent = '",g_enterprise,"' AND xrcaent = xrcbent ",
                  "                      AND xrcadocno = xrcbdocno AND xrcald = xrcbld AND xrca001 = '17' ",
                  "                      AND xrcastus <> 'X' AND xrcb049 = isafdocno)"
               WHEN g_end_prog = 'axrt310'
                  LET g_qryparam.where = " isafcomp = '",g_glaa.glaacomp,"' AND isaf001 = '3' AND isaf056 = '1' ",
                  "   AND NOT EXISTS (SELECT 1 FROM xrca_t,xrcb_t WHERE xrcaent = '",g_enterprise,"' AND xrcaent = xrcbent ",
                  "                      AND xrcadocno = xrcbdocno AND xrcald = xrcbld AND xrca001 = '11' ",
                  "                      AND xrcastus <> 'X' AND xrcb049 = isafdocno)"
               WHEN g_end_prog = 'axrt340'
                  #LET g_qryparam.where = " isafcomp = '",g_glaa.glaacomp,"' AND isaf056 = '2' ", #160920-00013#1 mark
                  LET g_qryparam.where = " isafcomp = '",g_glaa.glaacomp,"' AND isaf001 ='4' AND isaf056 = '2' ", #160920-00013#1 add
                  "   AND NOT EXISTS (SELECT 1 FROM xrca_t,xrcb_t WHERE xrcaent = '",g_enterprise,"' AND xrcaent = xrcbent ",
                  "                      AND xrcadocno = xrcbdocno AND xrcald = xrcbld AND xrca001 = '17' ",
                  "                      AND xrcastus <> 'X' AND xrcb049 = isafdocno)"
               #160920-00013#1 --s add
               WHEN g_end_prog = 'axrt341'
                  LET g_qryparam.where = " isafcomp = '",g_glaa.glaacomp,"' AND isaf001 = '5' AND isaf056 = '2' ",
                  "   AND NOT EXISTS (SELECT 1 FROM xrca_t,xrcb_t WHERE xrcaent = '",g_enterprise,"' AND xrcaent = xrcbent ",
                  "                      AND xrcadocno = xrcbdocno AND xrcald = xrcbld AND xrca001 = '17' ",
                  "                      AND xrcastus <> 'X' AND xrcb049 = isafdocno)"
               #160920-00013#1 --e add
            END CASE
            #160426-00013#1 add end---
            #151209-00023#1--add--str--lujh
            LET l_ooba002 = ''
            LET l_ooba002 = cl_get_para(g_enterprise,g_glaa.glaacomp,'S-FIN-1003')
            IF l_ooba002 <> '3' THEN
               LET g_qryparam.where = g_qryparam.where," AND isafstus = 'Y' "
            ELSE
               LET g_qryparam.where = g_qryparam.where," AND isafstus = 'S' "
            END IF
            #151209-00023#1--add--str--lujh
            CALL s_axrt300_sel_ld(g_master.xrcald) RETURNING l_success,l_s
            CASE
               WHEN l_s = 1
                  LET g_qryparam.where = g_qryparam.where," AND isaf035 IS NULL"
               WHEN l_s = 2
                  LET g_qryparam.where = g_qryparam.where," AND isaf048 IS NULL"
               WHEN l_s = 3
                  LET g_qryparam.where = g_qryparam.where," AND isaf049 IS NULL"
            END CASE
            LET g_qryparam.where = g_qryparam.where," AND isafdocdt BETWEEN '",g_pdate_s,"' AND '",g_pdate_e,"'"  #150210-00011(1)--20150330--add-- 
            #151231-00010#9--add--str--
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where," AND EXISTS (SELECT 1 FROM pmaa_t ",
                                                       "              WHERE pmaaent = ",g_enterprise,
                                                       "                AND ",g_sql_ctrl,
                                                       "                AND pmaaent = isafent",
                                                       "                AND pmaa001 = isaf002 )"
            END IF
            #151231-00010#9--add--end
            #160415-00010#1-----s
            IF g_master.l_chkisat = 'Y' THEN
               LET g_qryparam.where = g_qryparam.where," AND EXISTS(SELECT 1 FROM isat_t",
                                                       "             WHERE isatent = isafent",
                                                       "               AND isatcomp = isafcomp",
                                                       "               AND isatdocno = isafdocno",
                                                       "               AND isat025 IN ('11','21')",
                                                       "           )"
            END IF
            #160415-00010#1-----e
            LET g_qryparam.where = g_qryparam.where," AND ",l_where #160325-00023#1
            CALL q_isafdocno()
            DISPLAY g_qryparam.return1 TO isafdocno
            NEXT FIELD isafdocno
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isafdocno
            #add-point:BEFORE FIELD isafdocno name="construct.b.isafdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isafdocno
            
            #add-point:AFTER FIELD isafdocno name="construct.a.isafdocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.isaf002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaf002
            #add-point:ON ACTION controlp INFIELD isaf002 name="construct.c.isaf002"
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
             # CALL q_pmaa001()   #160913-00017#7  mark                  #呼叫開窗
            #160913-00017#7--ADD(S)--
            LET g_qryparam.arg1="('2','3')"
            CALL q_pmaa001_1()
            #160913-00017#7--ADD(E)--
            DISPLAY g_qryparam.return1 TO isaf002
            NEXT FIELD isaf002
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaf002
            #add-point:BEFORE FIELD isaf002 name="construct.b.isaf002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaf002
            
            #add-point:AFTER FIELD isaf002 name="construct.a.isaf002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaf010
            #add-point:BEFORE FIELD isaf010 name="construct.b.isaf010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaf010
            
            #add-point:AFTER FIELD isaf010 name="construct.a.isaf010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.isaf010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaf010
            #add-point:ON ACTION controlp INFIELD isaf010 name="construct.c.isaf010"
            
            #END add-point
 
 
         #Ctrlp:construct.c.isaf003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaf003
            #add-point:ON ACTION controlp INFIELD isaf003 name="construct.c.isaf003"
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
             # CALL q_pmaa001()   #160913-00017#7  mark                  #呼叫開窗
            #160913-00017#7--ADD(S)--
            LET g_qryparam.arg1="('2','3')"
            CALL q_pmaa001_1()
            #160913-00017#7--ADD(E)--
            DISPLAY g_qryparam.return1 TO isaf003  #顯示到畫面上
            NEXT FIELD isaf003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaf003
            #add-point:BEFORE FIELD isaf003 name="construct.b.isaf003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaf003
            
            #add-point:AFTER FIELD isaf003 name="construct.a.isaf003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaf011
            #add-point:BEFORE FIELD isaf011 name="construct.b.isaf011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaf011
            
            #add-point:AFTER FIELD isaf011 name="construct.a.isaf011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.isaf011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaf011
            #add-point:ON ACTION controlp INFIELD isaf011 name="construct.c.isaf011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaf055
            #add-point:BEFORE FIELD isaf055 name="construct.b.isaf055"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaf055
            
            #add-point:AFTER FIELD isaf055 name="construct.a.isaf055"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.isaf055
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaf055
            #add-point:ON ACTION controlp INFIELD isaf055 name="construct.c.isaf055"
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
             # CALL q_pmaa001()   #160913-00017#7  mark                  #呼叫開窗
            #160913-00017#7--ADD(S)--
            LET g_qryparam.arg1="('2','3')"
            CALL q_pmaa001_1()
            #160913-00017#7--ADD(E)--
            DISPLAY g_qryparam.return1 TO isaf055      #顯示到畫面上

            NEXT FIELD isaf055                         #返回原欄位

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaf014
            #add-point:BEFORE FIELD isaf014 name="construct.b.isaf014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaf014
            
            #add-point:AFTER FIELD isaf014 name="construct.a.isaf014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.isaf014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaf014
            #add-point:ON ACTION controlp INFIELD isaf014 name="construct.c.isaf014"
            
            #END add-point
 
 
         #Ctrlp:construct.c.isaf004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaf004
            #add-point:ON ACTION controlp INFIELD isaf004 name="construct.c.isaf004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()                       #呼叫開窗  #161021-00050#2 mark
            CALL q_ooeg001_4()                                #161021-00050#2 add   
            DISPLAY g_qryparam.return1 TO isaf004  #顯示到畫面上
            NEXT FIELD isaf004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaf004
            #add-point:BEFORE FIELD isaf004 name="construct.b.isaf004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaf004
            
            #add-point:AFTER FIELD isaf004 name="construct.a.isaf004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.isaf016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaf016
            #add-point:ON ACTION controlp INFIELD isaf016 name="construct.c.isaf016"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oodb002_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO isaf016  #顯示到畫面上
            NEXT FIELD isaf016                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaf016
            #add-point:BEFORE FIELD isaf016 name="construct.b.isaf016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaf016
            
            #add-point:AFTER FIELD isaf016 name="construct.a.isaf016"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaf057
            #add-point:BEFORE FIELD isaf057 name="construct.b.isaf057"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaf057
            
            #add-point:AFTER FIELD isaf057 name="construct.a.isaf057"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.isaf057
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaf057
            #add-point:ON ACTION controlp INFIELD isaf057 name="construct.c.isaf057"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO isaf057  #顯示到畫面上

            NEXT FIELD isaf057                     #返回原欄位

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
            CALL axrp132_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
            
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
            CALL axrp132_def()
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
         CALL axrp132_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
 
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
                 CALL axrp132_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = axrp132_transfer_argv(ls_js)
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
 
{<section id="axrp132.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION axrp132_transfer_argv(ls_js)
 
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
 
{<section id="axrp132.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION axrp132_process(ls_js)
 
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
   #150518-00039#4-----s
   DEFINE l_gettran    type_master
   DEFINE l_bgjob      LIKE type_t.chr1
   #150518-00039#4-----e
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   LET g_progflag = lc_param.progflag  #150518-00046#5 add
   IF cl_null(g_progflag) THEN LET g_progflag = 'axrp132' END IF #160317-00018#1 Add
   DISPLAY 'ls_js:',ls_js
   
   
   #150518-00039#4-----s
   CALL util.JSON.parse(ls_js,l_gettran)

   IF NOT cl_null(l_gettran.xrcasite) THEN
      DISPLAY 'l_getran.xrcasite:',l_gettran.xrcasite
      DISPLAY 'ls_js:',ls_js
      LET g_master.* = l_gettran.*
      CALL s_fin_create_account_center_tmp()
      CALL s_voucher_cre_ar_tmp_table() RETURNING g_sub_success 
      
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
      CALL s_get_accdate(g_glaa.glaa003,g_master.xrcadocdt,'','') 
               RETURNING g_sub_success,g_errno,g_glav002,g_glav005,g_sdate_s,g_sdate_e,
                         g_glav006,g_pdate_s,g_pdate_e,g_glav007,g_wdate_s,g_wdate_e
      #160426-00013#1-s
      CASE g_master.l_isaf001
         WHEN '1' #1:出貨發票
            LET g_end_prog = 'axrt300'
         WHEN '2' #2:雜項發票           #160620-00010#3 add
            LET g_end_prog = 'axrt330' #160620-00010#3 add
         WHEN '3' #3:訂金發票
            LET g_sfin2022 = cl_get_para(g_enterprise,g_glaa.glaacomp,'S-FIN-2022')
            IF g_sfin2022 = '01' THEN
               #01:認列收入
               LET g_end_prog = 'axrt300'
            ELSE
               #02:認列預收
               LET g_end_prog = 'axrt310'
            END IF
         WHEN '4' #4:待抵銷退
            LET g_end_prog = 'axrt340'
         WHEN '5' #5:雜項待抵           #160920-00013#1 add
            LET g_end_prog = 'axrt341' #160920-00013#1 add
      END CASE
      #160426-00013#1-e
   END IF
   #150518-00039#4-----e 
    
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
#  DECLARE axrp132_process_cs CURSOR FROM ls_sql
#  FOREACH axrp132_process_cs INTO
   #add-point:process段process name="process.process"
   CALL cl_err_collect_init()
   LET g_success    = 'Y'
   LET g_totsuccess = 'Y'
   
   IF g_bgjob <> "Y"  THEN
      SELECT gzzd005 INTO l_gzzd005 FROM gzzd_t
       WHERE gzzd001 = 'axrp132' AND gzzd002 = g_lang AND gzzdstus = 'Y' AND gzzd003 = 'step1'
      CALL cl_progress_no_window_ing(l_gzzd005)
   END IF
   
   CALL axrp132_get_data()
   IF g_success = 'N' THEN
      CALL cl_err_collect_show()
      DROP TABLE axrp132_tmp01         #160727-00019#5   2016/07/28  By 08734    将axrp132_isaf_tmp ——> axrp132_tmp01
      #清空進度條
      IF g_bgjob <> "Y" AND cl_null(l_gettran.xrcasite) THEN
         DISPLAY '' ,0 TO stagenow,stagecomplete
      END IF
      DROP TABLE axrp131_tmp01    #160727-00019#5   2016/07/28  By 08734    将axrp131_xmdk_tmp ——> axrp131_tmp01
      RETURN
   END IF
   
   CALL s_axrt300_create_tmp()
    
   CALL s_transaction_begin()
   
   IF g_bgjob <> "Y" THEN
      SELECT gzzd005 INTO l_gzzd005 FROM gzzd_t
       WHERE gzzd001 = 'axrp132' AND gzzd002 = g_lang AND gzzdstus = 'Y' AND gzzd003 = 'step2'
      CALL cl_progress_no_window_ing(l_gzzd005)
   END IF
   
   CALL axrp132_get_ar()
   
   DROP TABLE axrp132_tmp01            #160727-00019#5   2016/07/28  By 08734    将axrp132_isaf_tmp ——> axrp132_tmp01
   
   IF g_success = 'N' THEN
      IF g_bgjob <> "Y" THEN
         #清空進度條
         DISPLAY '' ,0 TO stagenow,stagecomplete
      END IF
      RETURN
   END IF
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
 
      #end add-point
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
      
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL axrp132_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="axrp132.get_buffer" >}
PRIVATE FUNCTION axrp132_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.xrcasite = p_dialog.getFieldBuffer('xrcasite')
   LET g_master.xrcald = p_dialog.getFieldBuffer('xrcald')
   LET g_master.b_style = p_dialog.getFieldBuffer('b_style')
   LET g_master.l_isaf001 = p_dialog.getFieldBuffer('l_isaf001')
   LET g_master.xrcadocno = p_dialog.getFieldBuffer('xrcadocno')
   LET g_master.xrca007 = p_dialog.getFieldBuffer('xrca007')
   LET g_master.xrcadocdt = p_dialog.getFieldBuffer('xrcadocdt')
   LET g_master.b_check1 = p_dialog.getFieldBuffer('b_check1')
   LET g_master.b_check4 = p_dialog.getFieldBuffer('b_check4')
   LET g_master.b_check2 = p_dialog.getFieldBuffer('b_check2')
   LET g_master.b_check5 = p_dialog.getFieldBuffer('b_check5')
   LET g_master.b_check3 = p_dialog.getFieldBuffer('b_check3')
   LET g_master.b_check6 = p_dialog.getFieldBuffer('b_check6')
   LET g_master.l_chkisat = p_dialog.getFieldBuffer('l_chkisat')
   LET g_master.b_comb2 = p_dialog.getFieldBuffer('b_comb2')
   LET g_master.b_comb1 = p_dialog.getFieldBuffer('b_comb1')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axrp132.msgcentre_notify" >}
PRIVATE FUNCTION axrp132_msgcentre_notify()
 
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
 
{<section id="axrp132.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 給帳務中心、帳套賦默認值
# Memo...........:
# Usage..........: CALL axrp132_def()
#                  RETURNING ---
# Input parameter: ---
# Return code....: ---
# Date & Author..: 2014/10/09 By zhangweib
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp132_def()
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
   
   #150603-00046#1 add ------
   IF NOT cl_null(g_argv[1]) AND NOT cl_null(g_argv[2]) THEN
      LET g_master.xrcasite  = g_argv[1]
      LET g_master.isafdocno = g_argv[2]
      #160922-00055#2 --s add
      IF NOT cl_null(g_argv[3]) THEN
         LET g_master.l_isaf001 = g_argv[3]
         DISPLAY BY NAME g_master.l_isaf001
      END IF      
      #160922-00055#2 --e add
      LET g_master.wc = "isafdocno='",g_master.isafdocno,"'" 
      DISPLAY g_master.isafdocno TO isafdocno
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
   ELSE
   #150603-00046#1 add end---
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
   END IF #150603-00046#1

   IF cl_null(g_master.xrcadocdt) THEN LET g_master.xrcadocdt = g_today END IF

   IF cl_null(g_master.b_style)  THEN LET g_master.b_style = 'axrt300'  END IF
   #IF cl_null(g_master.b_comb1)  THEN LET g_master.b_comb1 = '1'  END IF    #151012-00014#1 mark lujh
   #160914-00013#1 Mark ---(S)---
  ##151012-00014#1--add--str--lujh
  #CALL cl_get_para(g_enterprise,g_glaa.glaacomp,'S-FIN-2009') RETURNING l_sfin2009   
  #IF l_sfin2009 = '1' THEN LET g_master.b_comb1 = '2' END IF
  #IF l_sfin2009 = '2' THEN LET g_master.b_comb1 = '3' END IF
  ##151012-00014#1--add--end--lujh
   #160914-00013#1 Mark ---(E)---
   IF cl_null(g_master.b_comb1)  THEN LET g_master.b_comb1 = '1'  END IF   #160914-00013#1 Add
   CALL cl_set_comp_visible("lbl_comb1,b_comb1",FALSE)   #160914-00013#1 Add

   IF cl_null(g_master.b_comb2)  THEN LET g_master.b_comb2 = '1'  END IF
  #IF cl_null(g_master.b_check1) THEN LET g_master.b_check1 = 'Y' END IF   #161118-00026#1 Mark   
  #161118-00026#1 Add  ---(S)---
   IF cl_null(g_master.b_check1) AND cl_null(g_argv[1]) THEN LET g_master.b_check1 = 'Y' ELSE LET g_master.b_check1 = 'N' END IF
  #161118-00026#1 Add  ---(E)---
   IF cl_null(g_master.b_check2) THEN LET g_master.b_check2 = 'N' END IF
   IF cl_null(g_master.b_check3) THEN LET g_master.b_check3 = 'N' END IF
   IF cl_null(g_master.b_check4) THEN LET g_master.b_check4 = 'N' END IF
   IF cl_null(g_master.b_check5) THEN LET g_master.b_check5 = 'N' END IF
   IF cl_null(g_master.b_check6) THEN LET g_master.b_check6 = 'N' END IF
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
   
   LET g_master.l_chkisat = 'Y'   #160415-00010#1 add
   
   #160426-00013#1 add ------
   #預設對帳來源=1:出貨發票
   IF cl_null(g_master.l_isaf001) THEN
      LET g_master.l_isaf001 = '1'
      LET g_end_prog = 'axrt300'
      DISPLAY BY NAME g_master.l_isaf001
   END IF
   #160426-00013#1 add end---
   #161118-00026#1 Add  ---(S)---
   CASE g_master.l_isaf001
      WHEN '1' #1:出貨發票
         LET g_end_prog = 'axrt300'
      #160620-00010#3 --s add
      WHEN '2' #1:雜項發票
         LET g_end_prog = 'axrt330'
      #160620-00010#3 --e add
      WHEN '3' #3:訂金發票
         LET g_sfin2022 = cl_get_para(g_enterprise,g_glaa.glaacomp,'S-FIN-2022')
         IF g_sfin2022 = '01' THEN
            #01:認列收入
            LET g_end_prog = 'axrt300'
         ELSE
            #02:認列預收
            LET g_end_prog = 'axrt310'
         END IF
      WHEN '4' #4:待抵銷退
         LET g_end_prog = 'axrt340'
      WHEN '5' #5:雜項待抵
         LET g_end_prog = 'axrt341'
   END CASE
   DISPLAY BY NAME g_master.l_isaf001
   #161118-00026#1 Add  ---(E)---
END FUNCTION

################################################################################
# Descriptions...: 建立臨時表
# Memo...........:
# Usage..........: CALL axrp132_create_tmp()
#                  RETURNING r_success
# Input parameter: 
# Return code....: 
# Date & Author..: 2014/10/17 By zhangweib
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp132_create_tmp()
   DEFINE r_success         LIKE type_t.chr1

   LET r_success = 'Y'

   DROP TABLE axrp132_tmp01;                #160727-00019#5   2016/07/28  By 08734    将axrp132_isaf_tmp ——> axrp132_tmp01
   CREATE TEMP TABLE axrp132_tmp01 (        #160727-00019#5   2016/07/28  By 08734    将axrp132_isaf_tmp ——> axrp132_tmp01
      isagdocno       VARCHAR(20),
      isagcomp        VARCHAR(10),
      isagseq         INTEGER,
      isaf002         VARCHAR(10),
      isaf003         VARCHAR(10),
      isaf055         VARCHAR(10),
      isaf016         VARCHAR(10),
      isaf100         VARCHAR(10),
      isaf058         VARCHAR(10),
      isaf057         VARCHAR(20),
      isaf004         VARCHAR(10),
      isaf067         VARCHAR(20)     #160802-00007#1 Add
   );

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = 'N'  #160826-00004#1 add
      RETURN r_success
   END IF

   #160826-00004#1--add
   DROP TABLE axrp132_detail
   SELECT * FROM xrcd_t
    WHERE xrcdent   = 1
      AND xrcddocno = 'x'
      AND xrcdseq   = 0
   INTO TEMP axrp132_detail
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create axrp132_detail'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = 'N'
      RETURN r_success
   END IF
   #160826-00004#1--add
      
   RETURN r_success

END FUNCTION

################################################################################
# Descriptions...: 獲取符合條件的出貨單據資料
# Memo...........:
# Usage..........: CALL axrp132_get_data()
#                  RETURNING ---
# Input parameter: ---
# Return code....: ---
# Date & Author..: 2014/10/09 By zhangweib
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp132_get_data()
   DEFINE l_success     LIKE type_t.chr1
   DEFINE l_count       LIKE type_t.num5
   DEFINE ls_wc         STRING
   DEFINE ls_wc2        STRING
   DEFINE ls_wc3        STRING                #151209-00023#1 add lujh
   DEFINE l_ooba002     LIKE type_t.chr10     #151209-00023#1 add lujh
   DEFINE l_origin_str  STRING
   DEFINE l_isaf        RECORD
         isagdocno      LIKE isag_t.isagdocno,
         isagcomp       LIKE isag_t.isagcomp,
         isagseq        LIKE isag_t.isagseq,
         isaf002        LIKE isaf_t.isaf002,
         isaf003        LIKE isaf_t.isaf003,
         isaf055        LIKE isaf_t.isaf055,
         isaf016        LIKE isaf_t.isaf016,
         isaf100        LIKE isaf_t.isaf100,
         isaf058        LIKE isaf_t.isaf058,
         isaf057        LIKE isaf_t.isaf057,
         isaf004        LIKE isaf_t.isaf004,
         isaf067        LIKE isaf_t.isaf067   #160802-00007#1 Add
                        END RECORD
   DEFINE l_s           LIKE type_t.chr1
   DEFINE l_sql         STRING
   DEFINE l_str         STRING
   DEFINE l_orders      STRING
   DEFINE l_ac          LIKE type_t.num5
   DEFINE l_flag         LIKE type_t.chr1
   DEFINE l_where       STRING     #160325-00023#1
   
   IF cl_null(g_master.wc) THEN LET g_master.wc = " 1=1" END IF
   
   CALL s_axrt300_sel_ld(g_master.xrcald) RETURNING l_success,l_s

  #150615-00017#2 Mark ---(S)---
  #CASE
  #   WHEN l_s = 1
  #      LET ls_wc = " isaf035 IS NULL"
  #   WHEN l_s = 2
  #      LET ls_wc = " isaf048 IS NULL"
  #   WHEN l_s = 3
  #      LET ls_wc = " isaf049 IS NULL"
  #END CASE
   LET ls_wc = " 1=1"     #151214-00018#1   Add
  #150615-00017#2 Mark ---(E)---

  #150615-00017#2 Mark ---(S)---  對帳單根據帳套所屬法人限定範圍,無需用到帳務中心下屬組織Tree
  #CALL s_fin_account_center_sons_query('3',g_master.xrcasite,g_today,'')
  #CALL s_fin_account_center_sons_str()RETURNING l_origin_str
  #IF cl_null(l_origin_str) THEN LET l_origin_str = g_master.xrcasite END IF
  #CALL axrp132_get_ooef001_wc(l_origin_str)RETURNING l_origin_str
  #150615-00017#2 Mark ---(E)---

   LET g_success = 'Y'

   # 可立帳數量:
   # 如果是从发票开立那只产生应收，也要根据发票对应的出货单＋项次的出货数量－已立非暂估立账数量 (amt_a)，
   # 然后根据该数量和发票开立数量(amt_b)比较，
   # 如果amt_a小于amt_b，则amt_a产生AR,如果大于则按amt_b立AR
   # 即比较发票可开立数量和出货单可开立数量比较，使用较小的一个数量立应收
   #160426-00013#1 mark ------
   #IF g_master.b_style = 'axrt300' THEN
   #   LET ls_wc2 = " AND isaf056 = '1'"
   #ELSE
   #   LET ls_wc2 = " AND isaf056 = '2'"
   #END IF
   #160426-00013#1 mark end---
   #160426-00013#1 add ------
   CASE
      WHEN g_end_prog = 'axrt300' AND g_master.l_isaf001 = '1'
         LET ls_wc2 = " AND isaf001 <> '3' AND isaf056 = '1'"
      WHEN g_end_prog = 'axrt330'                            #160620-00010#3 add
         LET ls_wc2 = " AND isaf001 = '2' AND isaf056 = '1'" #160620-00010#3 add
      WHEN g_end_prog = 'axrt310' OR (g_end_prog = 'axrt300' AND g_master.l_isaf001 = '3')
         LET ls_wc2 = " AND isaf001 = '3' AND isaf056 = '1'"
      WHEN g_end_prog = 'axrt340'
         LET ls_wc2 = " AND isaf056 = '2'"
      WHEN g_end_prog = 'axrt341'           #160920-00013#1 add
         LET ls_wc2 = " AND isaf056 = '2'"  #160920-00013#1 add
   END CASE
   #160426-00013#1 add end---
   
   #151209-00023#1--add--str--lujh
   LET l_ooba002 = ''
   LET l_ooba002 = cl_get_para(g_enterprise,g_glaa.glaacomp,'S-FIN-1003')
   IF l_ooba002 <> '3' THEN 
      LET ls_wc3 = " AND isafstus = 'Y' "
   ELSE
      LET ls_wc3 = " AND isafstus = 'S' "
   END IF
   #151209-00023#1--add--str--lujh

   LET g_sql = "SELECT isagdocno,isagcomp,isagseq,isaf002,isaf003,isaf055,isaf016,isaf100,isaf058,isaf057,isaf004,isaf067 ",   #160802-00007#1 Add isaf067
               "  FROM isaf_t,isag_t",
               " WHERE isafent = isagent AND isafcomp = isagcomp AND isafdocno = isagdocno AND ",ls_wc,
               "   AND isafent = ",g_enterprise,    #170112-00010#1 add lujh
               "   AND ",g_master.wc,
               "   AND isafcomp = '",g_glaa.glaacomp,"' ",ls_wc2,ls_wc3,     #151209-00023#1 add ls_wc3 lujh
              #150615-00017#2 Add  ---(S)---
               "   AND NOT EXISTS (SELECT 1 FROM xrca_t,xrcb_t WHERE xrcaent = '",g_enterprise,"' AND xrcaent = xrcbent ",
               "                      AND xrcadocno = xrcbdocno AND xrcald = xrcbld AND xrca001 = '17' ",
               "                      AND xrcastus <> 'X' AND xrcb049 = isafdocno)",   
              #150615-00017#2 Add  ---(E)---
               "   AND isafdocdt BETWEEN '",g_pdate_s,"' AND '",g_pdate_e,"'"    #150210-00011(1)--20150330--add--
#               " ORDER BY isafdocdt,isafdocno,isagseq"    #151231-00010#9 mark
   #160325-00023#1 ---s---
   CALL s_aooi210_get_check_sql(g_master.xrcasite,'',g_master.xrcadocno,'4','','isagdocno') RETURNING g_sub_success,l_where   
   LET g_sql = g_sql CLIPPED," AND ",l_where 
   #160325-00023#1 ---e---
   
   #151231-00010#9--add--str--
   IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
      LET g_sql = g_sql,"   AND EXISTS (SELECT 1 FROM pmaa_t ",
                        "                WHERE pmaaent = ",g_enterprise,
                        "                  AND ",g_sql_ctrl,
                        "                  AND pmaaent = isafent ",
                        "                  AND pmaa001 = isaf003 )"
   END IF
#160415-00010#1-----s
   IF g_master.l_chkisat = 'Y' THEN
      LET g_sql = g_sql," AND EXISTS(",
                                     " SELECT 1 FROM isat_t          ",
                                     "  WHERE isatent = isafent ",
                                     "    AND isatcomp = isafcomp    ",
                                     "    AND isatdocno = isafdocno  ",
                                     "    AND isat025 IN ('11','21') ",
                                    ")"
   END IF
#160415-00010#1-----e
   
   LET g_sql = g_sql," ORDER BY isafdocdt,isafdocno,isagseq"
   #151231-00010#9--add--end
   PREPARE axrp132_prep FROM g_sql
   DECLARE axrp132_curs CURSOR FOR axrp132_prep
   CALL axrp132_create_tmp() RETURNING l_success
   #160826-00004#1 add--s
   IF l_success = 'N' THEN
      LET g_success = 'N'
      RETURN
   END IF
   #160826-00004#1 add--e
   FOREACH axrp132_curs INTO l_isaf.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET g_success = 'N'
         EXIT FOREACH
      END IF
      INSERT INTO axrp132_tmp01 VALUES (l_isaf.*)         #160727-00019#5   2016/07/28  By 08734    将axrp132_isaf_tmp ——> axrp132_tmp01
   END FOREACH
   
   IF g_success = 'Y' THEN
      SELECT COUNT(*) INTO l_count FROM axrp132_tmp01     #160727-00019#5   2016/07/28  By 08734    将axrp132_isaf_tmp ——> axrp132_tmp01
      IF l_count = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'ins temp table:'
#         LET g_errparam.code   = 'axm-00276'   #160318-00005#51  mark
         LET g_errparam.code   = 'sub-01321'    #160318-00005#51  add
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET g_success = 'N'
      END IF
   END IF

  #20150201#1 By zhangwei Add  ---(S)---
  #LET l_str   = "isaf002||isaf003||isaf055||isaf016||isaf100"   #160125-00005#4 Mark
  #LET l_orders= "isaf002,isaf003,isaf055,isaf016,isaf100"       #160125-00005#4 Mark
   LET l_str   = "isaf002||isaf003||isaf055||isaf100"   #160125-00005#4 Add
   LET l_orders= "isaf002,isaf003,isaf055,isaf100"       #160125-00005#4 Add
   #160802-00007#1 Add  ---(S)---
   IF g_master.b_comb2 <> '1' THEN
      LET l_str   = l_str,   "||isaf067"
      LET l_orders= l_orders,",isaf067"
   END IF
   #160802-00007#1 Add  ---(S)---
   CASE
      WHEN g_master.b_comb2 = '1'
         LET l_str   = "isagdocno docno"
         LET l_orders= "docno"
      WHEN g_master.b_comb2 = '3'
         LET l_str   = l_str,   "||isaf057"
         LET l_orders= l_orders,",isaf057"
         IF l_flag != 3 THEN
            LET l_str   = l_str,   "||isaf058"
            LET l_orders= l_orders,",isaf058"
         END IF
      WHEN g_master.b_comb2 = '4'
         LET l_str   = l_str,   "||isaf004"
         LET l_orders= l_orders,",isaf004"
   END CASE
   LET l_sql = "SELECT ",l_str,",isagdocno,isagcomp,isagseq FROM axrp132_tmp01",         #160727-00019#5   2016/07/28  By 08734    将axrp132_isaf_tmp ——> axrp132_tmp01
               " ORDER BY isagdocno,isagseq,",l_orders
   PREPARE axrp132_ar_prep FROM l_sql
   DECLARE axrp132_ar_curs CURSOR FOR axrp132_ar_prep
   LET l_ac = 1
   FOREACH axrp132_ar_curs INTO g_isaf_d[l_ac].*
      LET l_ac = l_ac + 1
   END FOREACH
   CALL g_isaf_d.deleteElement(l_ac)
   LET l_ac = l_ac - 1
  #20150201#1 By zhangwei Add  ---(E)---

END FUNCTION

################################################################################
# Descriptions...: 產生應收單據
# Memo...........:
# Usage..........: CALL axrp132_get_ar()
#                  RETURNING ---
# Input parameter: ---
# Return code....: ---
# Date & Author..: 2014/10/09 By zhangweib
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp132_get_ar()
   DEFINE l_sql         STRING
   DEFINE l_str         STRING
   DEFINE l_orders      STRING
  #DEFINE l_order       LIKE type_t.chr200   #20150201#1 By zhangwei Mark
   DEFINE l_order_t     LIKE type_t.chr200
   #161128-00061#3-----modify--begin----------
   #DEFINE l_isaf        RECORD LIKE isaf_t.*
   #DEFINE l_isag        RECORD LIKE isag_t.*
   DEFINE l_isaf RECORD  #銷項發票主檔
       isafent LIKE isaf_t.isafent, #企業編碼
       isafsite LIKE isaf_t.isafsite, #帳務組織
       isafcomp LIKE isaf_t.isafcomp, #法人
       isafdocno LIKE isaf_t.isafdocno, #開票單號
       isafdocdt LIKE isaf_t.isafdocdt, #輸入日期
       isaf001 LIKE isaf_t.isaf001, #發票來源
       isaf002 LIKE isaf_t.isaf002, #發票客戶
       isaf003 LIKE isaf_t.isaf003, #帳款客戶
       isaf004 LIKE isaf_t.isaf004, #業務組織
       isaf005 LIKE isaf_t.isaf005, #開票人員
       isaf006 LIKE isaf_t.isaf006, #開票部門
       isaf007 LIKE isaf_t.isaf007, #扣帳日期
       isaf008 LIKE isaf_t.isaf008, #發票類型
       isaf009 LIKE isaf_t.isaf009, #電子發票否
       isaf010 LIKE isaf_t.isaf010, #發票編號
       isaf011 LIKE isaf_t.isaf011, #發票號碼
       isaf012 LIKE isaf_t.isaf012, #發票檢查碼
       isaf013 LIKE isaf_t.isaf013, #發票防偽隨機碼
       isaf014 LIKE isaf_t.isaf014, #發票日期
       isaf015 LIKE isaf_t.isaf015, #發票時間
       isaf016 LIKE isaf_t.isaf016, #稅別
       isaf017 LIKE isaf_t.isaf017, #含稅否
       isaf018 LIKE isaf_t.isaf018, #稅率
       isaf019 LIKE isaf_t.isaf019, #申報格式
       isaf020 LIKE isaf_t.isaf020, #發票號碼迄號
       isaf021 LIKE isaf_t.isaf021, #購貨方名稱
       isaf022 LIKE isaf_t.isaf022, #購貨方統一編號
       isaf023 LIKE isaf_t.isaf023, #購貨方地址
       isaf024 LIKE isaf_t.isaf024, #購貨方電話
       isaf025 LIKE isaf_t.isaf025, #購貨方開戶銀行
       isaf026 LIKE isaf_t.isaf026, #購貨方帳戶編碼
       isaf027 LIKE isaf_t.isaf027, #銷貨方名稱
       isaf028 LIKE isaf_t.isaf028, #銷方統一編號
       isaf029 LIKE isaf_t.isaf029, #銷貨方地址
       isaf030 LIKE isaf_t.isaf030, #銷貨方電話
       isaf031 LIKE isaf_t.isaf031, #銷貨方開戶銀行
       isaf032 LIKE isaf_t.isaf032, #銷貨方帳號
       isaf033 LIKE isaf_t.isaf033, #POS機號
       isaf034 LIKE isaf_t.isaf034, #POS單號
       isaf035 LIKE isaf_t.isaf035, #應收單號
       isaf036 LIKE isaf_t.isaf036, #發票異動狀態
       isaf037 LIKE isaf_t.isaf037, #異動理由碼
       isaf038 LIKE isaf_t.isaf038, #異動備註
       isaf039 LIKE isaf_t.isaf039, #異動日期
       isaf040 LIKE isaf_t.isaf040, #異動時間
       isaf041 LIKE isaf_t.isaf041, #異動人員
       isaf042 LIKE isaf_t.isaf042, #專案作廢核准文號
       isaf043 LIKE isaf_t.isaf043, #通關方式註記
       isaf044 LIKE isaf_t.isaf044, #列印次數
       isaf045 LIKE isaf_t.isaf045, #支付工具卡號1
       isaf046 LIKE isaf_t.isaf046, #支付工具卡號2
       isaf047 LIKE isaf_t.isaf047, #支付工具卡號3
       isaf048 LIKE isaf_t.isaf048, #輔助帳二應收單號
       isaf049 LIKE isaf_t.isaf049, #輔助帳三應收單號
       isaf050 LIKE isaf_t.isaf050, #產生方式
       isaf051 LIKE isaf_t.isaf051, #發票簿號
       isaf052 LIKE isaf_t.isaf052, #發票簿號對應的營運據點
       isaf053 LIKE isaf_t.isaf053, #發票聯數
       isaf054 LIKE isaf_t.isaf054, #課稅別
       isaf055 LIKE isaf_t.isaf055, #收款客戶
       isaf056 LIKE isaf_t.isaf056, #發票性質
       isaf057 LIKE isaf_t.isaf057, #業務人員
       isaf058 LIKE isaf_t.isaf058, #收款條件
       isaf100 LIKE isaf_t.isaf100, #幣別
       isaf101 LIKE isaf_t.isaf101, #匯率
       isaf103 LIKE isaf_t.isaf103, #發票原幣未稅金額
       isaf104 LIKE isaf_t.isaf104, #發票原幣稅額
       isaf105 LIKE isaf_t.isaf105, #發票原幣含稅金額
       isaf106 LIKE isaf_t.isaf106, #發票原幣留抵稅額
       isaf107 LIKE isaf_t.isaf107, #發票原幣已折金額
       isaf108 LIKE isaf_t.isaf108, #發票原幣已折稅額
       isaf113 LIKE isaf_t.isaf113, #發票本幣未稅金額
       isaf114 LIKE isaf_t.isaf114, #發票本幣稅額
       isaf115 LIKE isaf_t.isaf115, #發票本幣含稅金額
       isaf116 LIKE isaf_t.isaf116, #發票本幣留抵稅額
       isaf117 LIKE isaf_t.isaf117, #發票本幣已折金額
       isaf118 LIKE isaf_t.isaf118, #發票本幣已折稅額
       isaf119 LIKE isaf_t.isaf119, #帳款應稅金額
       isaf120 LIKE isaf_t.isaf120, #帳款零稅金額
       isaf121 LIKE isaf_t.isaf121, #帳款免稅金額
       isaf122 LIKE isaf_t.isaf122, #禮券已開發票金額
       isaf123 LIKE isaf_t.isaf123, #禮券已開發票稅額
       isaf124 LIKE isaf_t.isaf124, #已開發票留抵稅額
       isaf201 LIKE isaf_t.isaf201, #愛心碼
       isaf202 LIKE isaf_t.isaf202, #載具類別號碼
       isaf203 LIKE isaf_t.isaf203, #載具顯碼 ID
       isaf204 LIKE isaf_t.isaf204, #載具隱碼 ID
       isaf205 LIKE isaf_t.isaf205, #電子發票匯出狀態
       isaf206 LIKE isaf_t.isaf206, #電子發票匯出序號
       isaf207 LIKE isaf_t.isaf207, #電子發票領取方式
       isaf208 LIKE isaf_t.isaf208, #申報年度
       isaf209 LIKE isaf_t.isaf209, #申報月份
       isaf210 LIKE isaf_t.isaf210, #申報據點
       isafstus LIKE isaf_t.isafstus, #狀態碼
       isafownid LIKE isaf_t.isafownid, #資料所有者
       isafowndp LIKE isaf_t.isafowndp, #資料所有部門
       isafcrtid LIKE isaf_t.isafcrtid, #資料建立者
       isafcrtdp LIKE isaf_t.isafcrtdp, #資料建立部門
       isafcrtdt LIKE isaf_t.isafcrtdt, #資料創建日
       isafmodid LIKE isaf_t.isafmodid, #資料修改者
       isafmoddt LIKE isaf_t.isafmoddt, #最近修改日
       isafcnfid LIKE isaf_t.isafcnfid, #資料確認者
       isafcnfdt LIKE isaf_t.isafcnfdt, #資料確認日
       isaf059 LIKE isaf_t.isaf059, #適用零稅率規定
       isaf060 LIKE isaf_t.isaf060, #通關方式
       isaf061 LIKE isaf_t.isaf061, #非經海關證明文件名稱
       isaf062 LIKE isaf_t.isaf062, #非經海關證明文件號碼
       isaf063 LIKE isaf_t.isaf063, #經由海關出口報單類別
       isaf064 LIKE isaf_t.isaf064, #出口報單號碼
       isaf065 LIKE isaf_t.isaf065, #輸出或結匯日期
       isaf066 LIKE isaf_t.isaf066, #商業發票號碼(IV no.)
       isaf067 LIKE isaf_t.isaf067  #一次性交易對象
       END RECORD
   DEFINE l_isag RECORD  #銷項發票來源明細檔
       isagent LIKE isag_t.isagent, #企業編號
       isagcomp LIKE isag_t.isagcomp, #法人
       isagdocno LIKE isag_t.isagdocno, #開票單號
       isagseq LIKE isag_t.isagseq, #項次
       isagorga LIKE isag_t.isagorga, #來源組織
       isag001 LIKE isag_t.isag001, #來源類型
       isag002 LIKE isag_t.isag002, #來源單號
       isag003 LIKE isag_t.isag003, #來源項次
       isag004 LIKE isag_t.isag004, #發票數量
       isag005 LIKE isag_t.isag005, #發票單位
       isag006 LIKE isag_t.isag006, #稅別
       isag007 LIKE isag_t.isag007, #含稅否
       isag008 LIKE isag_t.isag008, #稅率
       isag009 LIKE isag_t.isag009, #料號
       isag010 LIKE isag_t.isag010, #品名
       isag011 LIKE isag_t.isag011, #期別
       isag012 LIKE isag_t.isag012, #收款條件
       isag013 LIKE isag_t.isag013, #原始發票編號
       isag014 LIKE isag_t.isag014, #原始發票號碼
       isag015 LIKE isag_t.isag015, #正負值
       isag016 LIKE isag_t.isag016, #客戶料號
       isag017 LIKE isag_t.isag017, #客戶品名
       isag101 LIKE isag_t.isag101, #原幣單價
       isag103 LIKE isag_t.isag103, #原幣未稅金額
       isag104 LIKE isag_t.isag104, #原幣稅額
       isag105 LIKE isag_t.isag105, #原幣稅後金額
       isag106 LIKE isag_t.isag106, #訂金發票已被攤未稅額
       isag113 LIKE isag_t.isag113, #本幣未稅金額
       isag114 LIKE isag_t.isag114, #本幣稅額
       isag115 LIKE isag_t.isag115, #本幣稅後金額
       isag116 LIKE isag_t.isag116, #原幣已收金額
       isag117 LIKE isag_t.isag117, #本幣已收金額
       isag126 LIKE isag_t.isag126, #輔助帳二原幣已收金額　
       isag127 LIKE isag_t.isag127, #輔助帳二本幣已收金額　
       isag128 LIKE isag_t.isag128, #輔助帳二應收單號
       isag136 LIKE isag_t.isag136, #輔助帳三原幣已收金額　
       isag137 LIKE isag_t.isag137, #輔助帳二本幣已收金額　
       isag138 LIKE isag_t.isag138, #輔助帳三應收單號
       isag018 LIKE isag_t.isag018  #訂金已開發票
       END RECORD

   #161128-00061#3-----modify--end----------
   #DEFINE l_success     LIKE type_t.chr1    #160511-00016#1 
   DEFINE l_xrca001     LIKE xrca_t.xrca001
   DEFINE l_slip        LIKE xrca_t.xrcadocno
   DEFINE l_xrcadocno   LIKE xrca_t.xrcadocno
  #DEFINE l_isafdocno   LIKE isaf_t.isafdocno   #20150201#1 By zhangwei Mark
  #DEFINE l_isafcomp    LIKE isaf_t.isafcomp   #20150201#1 By zhangwei Mark
  #DEFINE l_isagseq     LIKE isag_t.isagseq   #20150201#1 By zhangwei Mark
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
   DEFINE l_cnt          LIKE xrcb_t.xrcbseq
   DEFINE l_s            LIKE type_t.chr1
   DEFINE l_xrca034      LIKE xrca_t.xrca034
   DEFINE l_xrca035      LIKE xrca_t.xrca035
   DEFINE l_xrca036      LIKE xrca_t.xrca036
   DEFINE l_xrcb005      LIKE xrcb_t.xrcb005
   DEFINE l_xrcb103      LIKE xrcb_t.xrcb103
   DEFINE l_xrcb105      LIKE xrcb_t.xrcb105
   DEFINE l_oodb005      LIKE oodb_t.oodb005
   DEFINE l_flag         LIKE type_t.chr1
   DEFINE l_xmdk000      LIKE xmdk_t.xmdk000
   DEFINE l_xmdl003      LIKE xmdl_t.xmdl003
   DEFINE l_xmdl004      LIKE xmdl_t.xmdl004
   DEFINE l_xrcb022      LIKE xrcb_t.xrcb022
   DEFINE l_count        LIKE type_t.num5
   DEFINE l_xmdlnum      LIKE xmdl_t.xmdl038
   DEFINE l_xrcd009      LIKE xrcd_t.xrcd009
   DEFINE l_ooba002      LIKE ooba_t.ooba002
   DEFINE l_sfin2012     LIKE type_t.chr1
   DEFINE l_start_no     LIKE xrca_t.xrcadocno   #20150201  BY zhangwei
   DEFINE l_end_no       LIKE xrca_t.xrcadocno   #20150201  BY zhangwei
   DEFINE l_end_no_t     LIKE xrca_t.xrcadocno   #20150201  BY zhangwei
  #DEFINE l_amount       LIKE type_t.num5        #20150201  BY zhangwei #150605 mark By Reanna
   DEFINE l_amount       LIKE xmdl_t.xmdl022     #150605    By Reanna
   DEFINE l_doc_success  LIKE type_t.num5        #20150201  BY zhangwei
   DEFINE l_tot_success  LIKE type_t.num5        #20150201  BY zhangwei
   DEFINE li_idx         LIKE type_t.num5        #20150201  BY zhangwei
   DEFINE l_xrcb002      LIKE xrcb_t.xrcb002     #20150201  BY zhangwei
   DEFINE l_xrcb003      LIKE xrcb_t.xrcb003     #20150201  BY zhangwei
   DEFINE l_xrcb007      LIKE xrcb_t.xrcb007     #20150201  BY zhangwei
   DEFINE l_dfin0030     LIKE type_t.chr1        #20150201  BY zhangwei
   DEFINE l_xmdk004      LIKE xmdk_t.xmdk004     #150807-00010#1
   DEFINE l_xmdk082      LIKE xmdk_t.xmdk082     #150807-00010#1
   DEFINE l_xmdl050      LIKE xmdl_t.xmdl050     #150807-00010#1
   #151125-00006#1----add--s
   DEFINE  l_slip_success   LIKE type_t.num5
   DEFINE  l_conf_success   LIKE type_t.num5
   DEFINE  l_dfin0031       LIKE type_t.chr1
   DEFINE  l_dfin0032       LIKE type_t.chr1
   DEFINE  l_gl_slip        LIKE ooba_t.ooba002 
   #151125-00006#1----add--e
   #151130-00015#3 Add  ---(S)---
   DEFINE la_param          RECORD
          prog              STRING,
          param             DYNAMIC ARRAY OF STRING,
          p_style           LIKE type_t.chr10,       #類型 axrt300 axrt340
          p_check           STRING,                  #160426-00013#1 add,
          p_isafdocno       LIKE isaf_t.isafdocno    #160426-00013#1
                            END RECORD
   DEFINE ls_js             STRING
   #151130-00015#3 Add  ---(E)---
   #151008-00009#8--s
   DEFINE lc_param          RECORD
          xrcasite          LIKE xrca_t.xrcasite,     
          xrcald            LIKE xrca_t.xrcald,       
          xrcacomp          LIKE xrca_t.xrcacomp,     
          xrcadocno         LIKE xrca_t.xrcadocno,    
          xrcadocdt         LIKE xrca_t.xrcadocdt,    
          xrca001           LIKE xrca_t.xrca001,      
          xrca003           LIKE xrca_t.xrca003,   
          xrca004           LIKE xrca_t.xrca004,      
          xrca005           LIKE xrca_t.xrca005,      
          xrca058           LIKE xrca_t.xrca058,      
          xrca100           LIKE xrca_t.xrca100,      
          xrca101           LIKE xrca_t.xrca101,      
          xrca121           LIKE xrca_t.xrca121,      
          xrca131           LIKE xrca_t.xrca131,      
          xrcbseq           LIKE xrcb_t.xrcbseq,      
          xrcb002           LIKE xrcb_t.xrcb002,    
          xrcb003           LIKE xrcb_t.xrcb003,    
          xrcb004           LIKE xrcb_t.xrcb004,   
          xrcb008           LIKE xrcb_t.xrcb008,    
          xrcb009           LIKE xrcb_t.xrcb009,    
          xrcb010           LIKE xrcb_t.xrcb010,      
          xrcb011           LIKE xrcb_t.xrcb011,      
          xrcb012           LIKE xrcb_t.xrcb012,      
          xrcb015           LIKE xrcb_t.xrcb015,      
          xrcb016           LIKE xrcb_t.xrcb016,      
          xrcb021           LIKE xrcb_t.xrcb021,
          xrcb024           LIKE xrcb_t.xrcb024,      
          xrcb033           LIKE xrcb_t.xrcb033,      
          xrcb034           LIKE xrcb_t.xrcb034,      
          xrcb035           LIKE xrcb_t.xrcb035,      
          xrcb036           LIKE xrcb_t.xrcb036,      
          xrcb037           LIKE xrcb_t.xrcb037,      
          xrcb038           LIKE xrcb_t.xrcb038,      
          xrcb039           LIKE xrcb_t.xrcb039,      
          xrcb040           LIKE xrcb_t.xrcb040,      
          xrcb041           LIKE xrcb_t.xrcb041,      
          xrcb042           LIKE xrcb_t.xrcb042,      
          xrcb043           LIKE xrcb_t.xrcb043,      
          xrcb044           LIKE xrcb_t.xrcb044,      
          xrcb045           LIKE xrcb_t.xrcb045,      
          xrcb046           LIKE xrcb_t.xrcb046,      
          xrcb047           LIKE xrcb_t.xrcb047,      
          xrcb051           LIKE xrcb_t.xrcb051,      
          xrcb103           LIKE xrcb_t.xrcb103,      
          xrcb113           LIKE xrcb_t.xrcb113,      
          xrcb123           LIKE xrcb_t.xrcb123,      
          xrcb133           LIKE xrcb_t.xrcb133,
          type1             LIKE type_t.chr1       #異動類型(xreq003)          
                        END RECORD
   #151008-00009#8--e
   DEFINE l_rmaa005         LIKE rmaa_t.rmaa005 #150518-00046#5 add
   DEFINE l_success         LIKE type_t.num5    #160511-00016#1 add
   
   #STEP1.依照匯總條件將出貨單資料匯總、排序
   #STEP2.將資料插入xrca_t
   #STEP3.將出貨單資料插入xrcb_t、xrcd_t
   #STEP4.将单身金额回写至单头
   #STEP5.產生多帳期資料

   CALL s_fin_get_doc_para(g_master.xrcald,g_glaa.glaacomp,g_master.xrcadocno,'D-FIN-0030') RETURNING l_dfin0030
   CALL s_axrt300_sel_ld(g_master.xrcald) RETURNING l_success,l_s
   CALL cl_get_para(g_enterprise,g_glaa.glaacomp,'S-FIN-1002') RETURNING l_flag

  #20150201#1 By zhangwei Mark ---(S)---
  #LET l_str   = "isaf002||isaf003||isaf055||isaf016||isaf100"
  #LET l_orders= "isaf002,isaf003,isaf055,isaf016,isaf100"
  #CASE
  #   WHEN g_master.b_comb2 = '1'
  #      LET l_str   = "isagdocno docno"
  #      LET l_orders= "docno"
  #   WHEN g_master.b_comb2 = '3'
  #      LET l_str   = l_str,   "||isaf057"
  #      LET l_orders= l_orders,",isaf057"
  #      IF l_flag != 3 THEN
  #         LET l_str   = l_str,   "||isaf058"
  #         LET l_orders= l_orders,",isaf058"
  #      END IF
  #   WHEN g_master.b_comb2 = '4'
  #      LET l_str   = l_str,   "||isaf004"
  #      LET l_orders= l_orders,",isaf004"
  #END CASE
  #
  #LET l_sql = "SELECT ",l_str,",isagdocno,isagcomp,isagseq FROM axrp132_tmp01",      #160727-00019#5   2016/07/28  By 08734    将axrp132_isaf_tmp ——> axrp132_tmp01
  #            " ORDER BY isagdocno,isagseq,",l_orders
  #PREPARE axrp132_ar_prep FROM l_sql
  #DECLARE axrp132_ar_curs CURSOR FOR axrp132_ar_prep
  #20150201#1 By zhangwei Mark ---(E)---

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
   PREPARE axrp132_bak_prep FROM l_sql
   DECLARE axrp132_bak_curs CURSOR FOR axrp132_bak_prep

   #20150201#1   By zhangwei Add ---(E)---

  #LET g_success = 'Y'        #20150201#1 By zhangwei Mark
   LET l_doc_success = TRUE   #20150201#1 By zhangwei Add
   LET l_tot_success = TRUE   #20150201#1 By zhangwei Add
   LET l_start_no = NULL      #20150201#1 By zhangwei Add
   LET l_end_no = NULL        #20150201#1 By zhangwei Add
   INITIALIZE g_xrca TO NULL
   INITIALIZE g_xrcb TO NULL

  #20150201#1 By zhangwei Mark ---(S)---
  #FOREACH axrp132_ar_curs INTO l_order,,l_isafcomp,l_isagseq
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
  
  #20150201#1   By zhangwei Add ---(S)---
   FOR li_idx = 1 TO g_isaf_d.getLength()

      CALL s_transaction_begin()  #每一筆資料單獨走一次事物
      
      IF g_progflag = 'aisp340' THEN  #150518-00046#5 add
         OPEN axrp133_cl USING g_enterprise,g_isaf_d[li_idx].isafdocno
         IF STATUS THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "OPEN isaf_cl:"   #20150201 ~~~
            LET g_errparam.code   =  STATUS 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
         
            CLOSE axrp133_cl
            CALL s_transaction_end('N','0')
            CONTINUE FOR
         END IF
      END IF    #150518-00046#5 add

      #161128-00061#3-----modify--begin----------
      #SELECT * INTO l_isaf.* 
      SELECT isafent,isafsite,isafcomp,isafdocno,isafdocdt,isaf001,isaf002,isaf003,isaf004,
             isaf005,isaf006,isaf007,isaf008,isaf009,isaf010,isaf011,isaf012,isaf013,isaf014,
             isaf015,isaf016,isaf017,isaf018,isaf019,isaf020,isaf021,isaf022,isaf023,isaf024,
             isaf025,isaf026,isaf027,isaf028,isaf029,isaf030,isaf031,isaf032,isaf033,isaf034,
             isaf035,isaf036,isaf037,isaf038,isaf039,isaf040,isaf041,isaf042,isaf043,isaf044,
             isaf045,isaf046,isaf047,isaf048,isaf049,isaf050,isaf051,isaf052,isaf053,isaf054,
             isaf055,isaf056,isaf057,isaf058,isaf100,isaf101,isaf103,isaf104,isaf105,isaf106,
             isaf107,isaf108,isaf113,isaf114,isaf115,isaf116,isaf117,isaf118,isaf119,isaf120,
             isaf121,isaf122,isaf123,isaf124,isaf201,isaf202,isaf203,isaf204,isaf205,isaf206,
             isaf207,isaf208,isaf209,isaf210,isafstus,isafownid,isafowndp,isafcrtid,isafcrtdp,
             isafcrtdt,isafmodid,isafmoddt,isafcnfid,isafcnfdt,isaf059,isaf060,isaf061,isaf062,
             isaf063,isaf064,isaf065,isaf066,isaf067 INTO l_isaf.* 
      #161128-00061#3-----modify--end----------
      FROM isaf_t WHERE isafent = g_enterprise AND isafdocno = g_isaf_d[li_idx].isafdocno AND isafcomp = g_isaf_d[li_idx].isafcomp   #20150201#1 By zhangwei Mod  ---> g_isaf_d[li_idx].isafdocno  l_isafcomp ---> g_isaf_d[li_idx].isafcomp
      
      #161128-00061#3-----modify--begin----------
      #SELECT * INTO l_isag.* 
      SELECT isagent,isagcomp,isagdocno,isagseq,isagorga,isag001,isag002,isag003,isag004,isag005,isag006,
             isag007,isag008,isag009,isag010,isag011,isag012,isag013,isag014,isag015,isag016,isag017,
             isag101,isag103,isag104,isag105,isag106,isag113,isag114,isag115,isag116,isag117,isag126,
             isag127,isag128,isag136,isag137,isag138,isag018 INTO l_isag.* 
      #161128-00061#3-----modify--end----------
      FROM isag_t WHERE isagent = g_enterprise AND isagdocno = g_isaf_d[li_idx].isafdocno AND isagcomp = g_isaf_d[li_idx].isafcomp AND isagseq = g_isaf_d[li_idx].isagseq   #20150201#1 By zhangwei Mod  ---> g_isaf_d[li_idx].isafdocno  l_isafcomp ---> g_isaf_d[li_idx].isafcomp l_isagseq ---> 

      IF g_master.b_comb2 = '1' AND cl_null(g_master.xrcadocdt) THEN
         LET g_master.xrcadocdt = l_isaf.isafdocdt
      END IF

      IF (l_isag.isag001 = '11' OR l_isag.isag001 = '21') THEN
         LET l_amount = 0
         EXECUTE axrp133_amount USING l_isag.isag002,l_isag.isag003 INTO l_amount
         IF cl_null(l_amount) THEN LET l_amount = 0 END IF
         IF l_amount = 0 THEN
            LET g_errparam.extend = "OPEN isaf_cl:"   #20150201 ~~~
            LET g_errparam.code   =  STATUS 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            CALL s_transaction_end('N','0')
            CONTINUE FOR
         END IF
      END IF
      #20150201#1   By zhangwei Add ---(S)---
      
      #160426-00013#1-s
      #若來源類型為27:其他待抵單，則直接產生到直接沖帳去
      IF l_isag.isag001 = '27' THEN
         CONTINUE FOR
      END IF
      #160426-00013#1-e
      
      DISPLAY "g_end_prog:",g_end_prog
      IF cl_null(l_order_t) OR l_order_t <> g_isaf_d[li_idx].order THEN   #20150201#1 By zhangwei Mod l_order ---> g_isaf_d[li_idx].order
         #CALL s_aooi200_fin_gen_docno(g_master.xrcald,g_glaa.glaa024,g_glaa.glaa003,g_master.xrcadocno,g_master.xrcadocdt,g_master.b_style) #160426-00013#1 mark
         CALL s_aooi200_fin_gen_docno(g_master.xrcald,g_glaa.glaa024,g_glaa.glaa003,g_master.xrcadocno,g_master.xrcadocdt,g_end_prog)        #160426-00013#1
              RETURNING l_success,l_xrcadocno
         IF l_success = FALSE OR l_success = 'N' THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = g_master.xrcadocno
            LET g_errparam.code   = 'aap-00187'
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            #LET g_success = 'N'        #20150201#1 By zhangwei Mark
            LET l_doc_success = FALSE   #20150201#1 By zhangwei Add
         END IF
         #IF g_master.b_style = 'axrt300' THEN LET l_xrca001 = '17' ELSE LET l_xrca001 = '22' END IF #160426-00013#1 mark
         #160426-00013#1 add ------
         CASE
            WHEN g_end_prog = 'axrt300'
               LET l_xrca001 = '17' #17:發票應收單
            WHEN g_end_prog = 'axrt330'             #160620-00010#3 add
               LET l_xrca001 = '19' #19:其他應收單   #160620-00010#3 add
            WHEN g_end_prog = 'axrt310'
               LET l_xrca001 = '11' #11:訂金預收單
            WHEN g_end_prog = 'axrt340'
               LET l_xrca001 = '22' #22:銷退待抵單
            WHEN g_end_prog = 'axrt341'             #160920-00013#1 add
               LET l_xrca001 = '29' #29:其他扣抵單   #160920-00013#1 add
         END CASE
         #160426-00013#1 add end---

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
            #回寫單頭金額
            UPDATE xrca_t SET (xrca103,xrca104,xrca113,xrca114,xrca123,xrca124,xrca133,xrca134) = (g_xrca.xrca103,g_xrca.xrca104,g_xrca.xrca113,g_xrca.xrca114,g_xrca.xrca123,g_xrca.xrca124,g_xrca.xrca133,g_xrca.xrca134) 
             WHERE xrcaent = g_enterprise AND xrcald = g_xrca.xrcald AND xrcadocno = g_xrca.xrcadocno
            #單身如果有多筆發票則更新單頭發票號碼為'MULTI'
            LET l_count = 0
            SELECT COUNT(DISTINCT xrcb027||xrcb028) INTO l_count FROM xrcb_t WHERE xrcbent = g_enterprise
               AND xrcbdocno = g_xrca.xrcadocno AND xrcbld = g_xrca.xrcald
            IF cl_null(l_count) THEN LET l_count = 0 END IF
            IF l_count > 1 THEN
               UPDATE xrca_t SET xrca066 = 'MULTI'
                WHERE xrcaent = g_enterprise AND xrcald = g_xrca.xrcald AND xrcadocno = g_xrca.xrcadocno
            END IF
            #如果單身資料多來源/多單據則令單頭來源類型、來源單號為空
            LET l_count = 0
            CASE
               WHEN l_s = 1
                  SELECT COUNT(DISTINCT isafdocno) INTO l_count FROM isaf_t WHERE isafent = g_enterprise
                     AND isaf035 = g_xrca.xrcadocno
               WHEN l_s = 2
                  SELECT COUNT(DISTINCT isafdocno) INTO l_count FROM isaf_t WHERE isafent = g_enterprise
                     AND isaf048 = g_xrca.xrcadocno
               WHEN l_s = 3
                  SELECT COUNT(DISTINCT isafdocno) INTO l_count FROM isaf_t WHERE isafent = g_enterprise
                     AND isaf049 = g_xrca.xrcadocno
            END CASE
            IF cl_null(l_count) THEN LET l_count = 0 END IF
            IF l_count > 1 THEN
               UPDATE xrca_t SET xrca018 = ''
                WHERE xrcaent = g_enterprise AND xrcald = g_xrca.xrcald AND xrcadocno = g_xrca.xrcadocno
            END IF
           #LET l_count = 0
           #SELECT COUNT(DISTINCT xrcb001) INTO l_count FROM xrcb_t WHERE xrcbent = g_enterprise
           #   AND xrcbdocno = g_xrca.xrcadocno AND xrcbld = g_xrca.xrcald
           #   AND xrcb001 NOT IN ('19','29')
           #IF cl_null(l_count) THEN LET l_count = 0 END IF
           #IF l_count > 1 THEN
           #   UPDATE xrca_t SET xrca016 = ''
           #    WHERE xrcaent = g_enterprise AND xrcald = g_xrca.xrcald AND xrcadocno = g_xrca.xrcadocno
           #END IF
            #產生直接沖帳
           #151130-00015#3 Mod  ---(S)---
           #CALL axrp132_ins_xrce()
            #LET la_param.p_style = g_master.b_style #160426-00013#1 mark
            LET la_param.p_style = g_end_prog        #160426-00013#1
            LET la_param.p_check = g_master.b_check1,g_master.b_check2,g_master.b_check3,g_master.b_check4,g_master.b_check5,g_master.b_check6
            LET la_param.p_isafdocno = g_isaf_d[li_idx].isafdocno   #160426-00013#1
            LET ls_js = util.JSON.stringify(la_param)
            CALL s_axrp133_ins_xrce(g_xrca.xrcadocno,g_xrca.xrcald,ls_js)
           #151130-00015#3 Mod  ---(E)---

            #產生多帳期
            CALL s_axrt300_installments(g_xrca.xrcald,g_xrca.xrcadocno) RETURNING l_success
            IF l_success = FALSE OR l_success = 'N' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = g_master.xrcadocno
               LET g_errparam.code   = 'aap-00092'
               LET g_errparam.popup  = TRUE
               CALL cl_err()
              #LET g_success = 'N'         #20150201#1 By zhangwei Mark
               LET l_doc_success = FALSE   #20150201#1 By zhangwei Add
            END IF

            #20150201#1 By zhangwei Add ---(S)---
            IF g_glaa.glaa121 = 'Y' AND l_dfin0030 = 'Y' THEN
               CALL s_pre_voucher_ins('AR','R10',g_glaa.glaald,g_xrca.xrcadocno,g_xrca.xrcadocdt,'1') RETURNING l_success
               IF NOT l_success THEN
                  LET l_doc_success = FALSE
               END IF
            END IF
            #20150201#1 By zhangwei Add ---(E)---

            #151125-00006#1---add---s  执行立即审核功能
            CALL s_aooi200_fin_get_slip(g_xrca.xrcadocno) RETURNING l_slip_success,l_ooba002
            CALL s_fin_get_doc_para(g_xrca.xrcald,g_xrca.xrcacomp,l_ooba002,'D-FIN-0031') RETURNING l_dfin0031
  
            IF NOT cl_null(l_dfin0031) AND l_dfin0031 MATCHES '[Yy]' THEN 
               CALL s_axrp133_immediately_conf(g_xrca.xrcald,g_xrca.xrcadocno) RETURNING l_conf_success
               IF NOT l_conf_success THEN 
                  LET l_doc_success = FALSE
               END IF 
            END IF 
            #151125-00006#1---add---e

            #20150201#1 By zhangwei Add ---(S)---
            IF l_doc_success THEN  
           #IF l_doc_success AND ( (not cl_null(l_conf_success) AND l_conf_success) OR cl_null(l_conf_success) ) THEN    #151125-00006#1 add by aiqq
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

         END IF

         INITIALIZE g_xrca TO NULL

         LET g_xrca.xrcaent   = g_enterprise
         LET g_xrca.xrcaownid = g_user
         LET g_xrca.xrcaowndp = g_dept
         LET g_xrca.xrcacrtid = g_user
         LET g_xrca.xrcacrtdp = g_dept
         LET g_xrca.xrcacrtdt = cl_get_current()   #albireo 150716  g_today >>>> cl_get_current()
         
         LET g_xrca.xrcastus  = 'N'
         LET g_xrca.xrcacomp  = g_glaa.glaacomp
         LET g_xrca.xrcald    = g_master.xrcald
         LET g_xrca.xrcadocno = l_xrcadocno
         LET g_xrca.xrcadocdt = g_master.xrcadocdt
         LET g_xrca.xrca001   = l_xrca001
         LET g_xrca.xrcasite  = g_master.xrcasite
         LET g_xrca.xrca003   = g_user
         LET g_xrca.xrca004   = l_isaf.isaf003
         CALL axrp132_xrca004_ref(l_isaf.isaf100) RETURNING l_xrca.*
         LET g_xrca.xrca005   = l_isaf.isaf055
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
         #160909-00084#1 Add  ---(S)---
         IF l_isaf.isaf001 = '3' AND g_sfin2022 = '02' THEN
            SELECT glab005 INTO l_xrca036 FROM glab_t 
             WHERE glabld = g_master.xrcald 
               AND glabent = g_enterprise
               AND glab002 = g_xrca.xrca007   # 帳款類別
               AND glab001 = '13'             # 應收帳務類型科目設定
               AND glab003 = '8304_22'
         ELSE
         #160909-00084#1 Add  ---(E)---
            SELECT glab005 INTO l_xrca036 FROM glab_t 
             WHERE glabld = g_master.xrcald 
               AND glabent = g_enterprise
               AND glab002 = g_xrca.xrca007   # 帳款類別
               AND glab001 = '13'             # 應收帳務類型科目設定
               AND glab003 = '8304_21'
         END IF   #160909-00084#1 Add
         #1508170001--Kris:axrp132  折襄單時, 應取銷貨退回的會科
         #IF g_master.b_style = 'axrt340' THEN  #160426-00013#1 mark
         IF g_end_prog = 'axrt340' THEN         #160426-00013#1
            #161014-00046#1 -s
            LET l_xmdk082 = ''
            SELECT xmdk082 INTO l_xmdk082
              FROM xmdk_t
             WHERE xmdkent   = g_enterprise
               AND xmdkdocno = l_isag.isag002
            CASE
               WHEN l_xmdk082 = '4' #axmt600銷退方式=4:銷貨折讓(純金額折價)時抓axri011的帳款折讓科目
                  CALL s_fin_get_account(g_xrca.xrcald,'13',g_xrca.xrca007,'8304_05') RETURNING g_sub_success,l_xrca036,g_errno
               OTHERWISE  #其他銷退方式都抓銷貨退回科目
            #161014-00046#1 -e
                  CALL s_fin_get_account(g_xrca.xrcald,'13',g_xrca.xrca007,'8304_04') RETURNING g_sub_success,l_xrca036,g_errno
            END CASE  #161014-00046#1
         END IF
         #160920-00013#1 --s  add
         IF g_end_prog = 'axrt341' THEN           
            #CALL s_fin_get_account(g_xrca.xrcald,'13',g_xrca.xrca007,'8304_29') RETURNING g_sub_success,l_xrca036,g_errno
            SELECT glab005 INTO l_xrca036 FROM glab_t 
             WHERE glabld = g_master.xrcald 
               AND glabent = g_enterprise
               AND glab002 = g_xrca.xrca007   # 帳款類別
               AND glab001 = '13'             # 應收帳務類型科目設定
               AND glab003 = '8304_05'
         END IF
         #160920-00013#1 --e  add
         SELECT glab005 INTO l_xrcd009 FROM glab_t 
          WHERE glabld = g_master.xrcald 
            AND glabent = g_enterprise
            AND glab002 = g_xrca.xrca007   # 帳款類別
            AND glab001 = '13'             # 應收帳務類型科目設定
            AND glab003 = '8304_29'

         SELECT ooeg004 INTO l_xrca034 FROM ooeg_t WHERE ooegent = g_enterprise AND ooeg001 = l_xrca.xrca015

         LET g_xrca.xrca008   = l_isag.isag012

         #應收日期/票據到期日
         #160921-00018#1 Mark ---(S)---
        #CALL s_fin_date_ar_receivable(g_xrca.xrcasite,g_xrca.xrca004,g_xrca.xrca008,g_xrca.xrcadocdt,
        #  g_xrca.xrcadocdt,g_xrca.xrcadocdt,'') RETURNING l_success,g_xrca.xrca009,g_xrca.xrca010
         #160921-00018#1 Mark ---(E)---
         #160921-00018#1 Add  ---(S)---
         CALL s_fin_date_ar_receivable(g_xrca.xrcasite,g_xrca.xrca004,g_xrca.xrca008,g_xrca.xrcadocdt,
           l_isaf.isafdocdt,g_xrca.xrcadocdt,g_xrca.xrcadocdt) RETURNING l_success,g_xrca.xrca009,g_xrca.xrca010
         #160921-00018#1 Add  ---(E)---


         IF g_master.b_comb2 = '1' THEN   #160125-00005#4 Add
            LET g_xrca.xrca011   = l_isaf.isaf016
        #160125-00005#4 Add  ---(S)---
         ELSE
            LET g_xrca.xrca011 = l_xrca.xrca011
         END IF
        #160125-00005#4 Add  ---(E)---

         CALL s_tax_chk(g_glaa.glaacomp,g_xrca.xrca011)
            RETURNING l_success,l_oodbl004,l_xrca.xrca013,l_xrca.xrca012,l_oodb011

         LET g_xrca.xrca012   = l_xrca.xrca012
         LET g_xrca.xrca013   = l_xrca.xrca013
         CASE
            WHEN g_master.b_comb2 = '1'
               LET g_xrca.xrca014   = l_isaf.isaf057
               LET g_xrca.xrca015   = l_isaf.isaf004
            WHEN g_master.b_comb2 = '2'
               LET g_xrca.xrca014   = l_xrca.xrca014
               LET g_xrca.xrca015   = l_xrca.xrca015
            WHEN g_master.b_comb2 = '3'
               LET g_xrca.xrca014   = l_xrca.xrca014
               LET g_xrca.xrca015   = ''
            WHEN g_master.b_comb2 = '4'
               LET g_xrca.xrca014   = l_xrca.xrca014
               LET g_xrca.xrca015   = ''
         END CASE
         #160426-00013#1 mark ------
         #IF g_master.b_style = 'axrt300' THEN
         #   LET g_xrca.xrca016   = '12'
         #ELSE
         #   LET g_xrca.xrca016   = '22'
         #END IF
         #160426-00013#1 mark end---
         #160426-00013#1 add ------
         CASE
            WHEN g_end_prog = 'axrt300'
               IF l_isaf.isaf001 = '3' THEN #訂金發票
                  LET g_xrca.xrca016 = '10'
               ELSE
                  LET g_xrca.xrca016 = '12'
               END IF
            WHEN g_end_prog = 'axrt330'    #160620-00010#3 add
               LET g_xrca.xrca016 = '12'   #160620-00010#3 add 12:銷項發票
            WHEN g_end_prog = 'axrt310'
               LET g_xrca.xrca016 = '12'   #161110-00009#1 Mod 10 --> 12
            WHEN g_end_prog = 'axrt340'
               LET g_xrca.xrca016 = '22'
            WHEN g_end_prog = 'axrt341'  #160920-00013#1 add
               LET g_xrca.xrca016 = '29' #160920-00013#1 add
         END CASE
         #160426-00013#1 add end---
         LET g_xrca.xrca017   = 0
         IF g_master.b_comb2 = '1' THEN
            LET g_xrca.xrca018   = l_isaf.isafdocno
         ELSE
            LET g_xrca.xrca018   = ''
         END IF
         LET g_xrca.xrca019   = ''
         LET g_xrca.xrca020   = 'N'
         #LET g_xrca.xrca021   = ''
         #150904-00006#3-----s
         #商用發票號碼
         #LET g_xrca.xrca021 = l_isaf.isaf011   #161117-00043#1 Mod isaf066 --> isaf011 #161205-00014#1 mark
         LET g_xrca.xrca021 = l_isaf.isaf066    #161205-00014#1 add
         #150904-00006#3-----e
         LET g_xrca.xrca022   = ''
         LET g_xrca.xrca023   = l_isaf.isaf002
         LET g_xrca.xrca024   = ''
         LET g_xrca.xrca025   = l_isaf.isaf021
         LET g_xrca.xrca026   = ''
         LET g_xrca.xrca028   = l_isaf.isaf008
         LET g_xrca.xrca029   = l_isaf.isaf101
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
         LET g_xrca.xrca054   = ''
         CALL cl_get_para(g_enterprise,g_glaa.glaacomp,'S-FIN-2012') RETURNING l_sfin2012
         IF l_sfin2012 <> 1 THEN
            SELECT ooib025 INTO g_xrca.xrca054 FROM ooib_t WHERE ooibent = g_enterprise
               AND ooib002 = g_xrca.xrca008
         END IF
         LET g_xrca.xrca055   = ''
         LET g_xrca.xrca056   = ''
         LET g_xrca.xrca057   = ''
         SELECT xmdk031 INTO g_xrca.xrca058 FROM xmdk_t WHERE xmdkdocno = l_isag.isag002
            AND xmdkent = g_enterprise
            
         #150518-00046#5 --s add
         IF g_progflag = 'aisp340' THEN
            SELECT rmaa005 INTO l_rmaa005
              FROM rmaa_t
             WHERE rmaaent = g_enterprise
               AND rmaadocno IN (SELECT DISTINCT rmdb001 FROM rmda_t,rmdb_t
                                  WHERE rmdaent = g_enterprise
                                    AND rmdadocno =  l_isag.isag002
                                    AND rmdbseq =  l_isag.isag003
                                    AND rmdaent = rmdbent 
                                    AND rmdadocno = rmdbdocno
                                    AND rmdastus = 'S')
                                    
            SELECT xmdk031 INTO g_xrca.xrca058 FROM xmdk_t 
             WHERE xmdkent = g_enterprise AND xmdkdocno = l_rmaa005                      

            IF cl_null(g_xrca.xrca058) THEN
               SELECT pmab089 INTO g_xrca.xrca058 
                 FROM pmab_t
                WHERE pmabent = g_enterprise
                  AND pmabsite = l_isaf.isafsite
                  AND pmab001 = l_isaf.isaf003
                  AND pmabstus = 'Y'
            END IF
         END IF
         #150518-00046#5 --e add

         LET g_xrca.xrca059   = ''
         LET g_xrca.xrca060   = 2
         LET g_xrca.xrca061   = l_xrca.xrca061
         LET g_xrca.xrca062   = '1'
         LET g_xrca.xrca063   = ''
         LET g_xrca.xrca065   = l_isaf.isaf010
         #150918-00001#7-----s
         #IF NOT cl_null(g_xrca.xrca021)THEN   #161219-00031#1 mark lujh
         IF cl_null(l_isaf.isaf011) THEN       #161219-00031#1 add lujh
            LET g_xrca.xrca066   = g_xrca.xrca021
         ELSE
            LET g_xrca.xrca065   = l_isaf.isaf010   #161219-00031#1 add lujh
            LET g_xrca.xrca066   = l_isaf.isaf011
         END IF
         #150918-00001#7-----e
         LET g_xrca.xrca100   = l_isaf.isaf100
         IF g_master.b_comb1 = 1 THEN
            LET g_xrca.xrca101 = l_isaf.isaf101
         ELSE
            LET g_xrca.xrca101 = l_xrca.xrca101
         END IF
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
         LET g_xrca.xrca057   = l_isaf.isaf067   #160802-00007#1 Add
         
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
      
      SELECT xmdl003,xmdl004 INTO l_xmdl003,l_xmdl004 FROM xmdl_t
       WHERE xmdldocno = l_isag.isag002
         AND xmdlseq = l_isag.isag003
         AND xmdlent = g_enterprise

      LET g_xrcb.xrcbent = g_enterprise
      LET g_xrcb.xrcbld  = g_master.xrcald
      LET g_xrcb.xrcbdocno = g_xrca.xrcadocno
      LET g_xrcb.xrcbseq = g_xrcb.xrcbseq + 1
      LET g_xrcb.xrcbsite= g_master.xrcasite
      LET g_xrcb.xrcborga= l_isaf.isafcomp   #160317-00018#1 Mark
      LET g_xrcb.xrcborga= l_isag.isagorga   #160317-00018#1 Add
      LET g_xrcb.xrcb001 = l_isag.isag001
      
      #150518-00046#5 --s add
      IF g_progflag = 'aisp340' THEN
         LET g_xrcb.xrcb001 = "1D"
      END IF
      #150518-00046#5 --e add

      LET g_xrcb.xrcb002 = l_isag.isag002
      LET g_xrcb.xrcb003 = l_isag.isag003
      LET g_xrcb.xrcb004 = l_isag.isag009
     #LET g_xrcb.xrcb005 = l_isag.isag010                                   #150828-00001#2 Mark
      CALL s_axrt300_get_xrcb005(g_xrcb.xrcb004) RETURNING g_xrcb.xrcb005   #150828-00001#2 Add
      #161110-00009#1 Add  ---(S)---
      IF cl_null(g_xrcb.xrcb005) THEN
         LET g_xrcb.xrcb005 = l_isag.isag010
      END IF
      #161110-00009#1 Add  ---(E)---
      LET g_xrcb.xrcb006 = l_isag.isag005
      LET g_xrcb.xrcb007 = l_isag.isag004
      LET g_xrcb.xrcb008 = l_xmdl003
      LET g_xrcb.xrcb009 = l_xmdl004
      
      #150518-00046#5 --s add
      IF g_progflag = 'aisp340' THEN
         SELECT rmdb001,rmdb002 INTO g_xrcb.xrcb008,g_xrcb.xrcb009 
           FROM rmda_t,rmdb_t
          WHERE rmdaent = g_enterprise
            AND rmdadocno =  l_isag.isag002
            AND rmdbseq =  l_isag.isag003
            AND rmdaent = rmdbent 
            AND rmdadocno = rmdbdocno
            AND rmdastus = 'S'
      END IF
      #150518-00046#5 --e add
      
      LET g_xrcb.xrcblegl= g_xrca.xrcacomp
      LET g_xrcb.xrcb010 = l_isaf.isaf004
      LET g_xrcb.xrcb011 = g_xrca.xrca034
      SELECT imaa009 INTO g_xrcb.xrcb012 FROM imaa_t WHERE imaaent = g_enterprise
       AND imaa001 = g_xrcb.xrcb004
      LET g_xrcb.xrcb013 = ''
      LET g_xrcb.xrcb014 = ''
      LET g_xrcb.xrcb015 = ''
      LET g_xrcb.xrcb016 = ''
      #160912-00034#1--add--str--lujh
      SELECT xmdl030,xmdl031 
        INTO g_xrcb.xrcb015,g_xrcb.xrcb016
        FROM xmdl_t
       WHERE xmdlent = g_enterprise
         AND xmdldocno = g_xrcb.xrcb002
         AND xmdlseq = g_xrcb.xrcb003
      #160912-00034#1--add--end--lujh
      LET g_xrcb.xrcb017 = ''
      LET g_xrcb.xrcb018 = ''
      LET g_xrcb.xrcb019 = ''
      LET g_xrcb.xrcb020 = l_isag.isag006
      LET g_xrcb.xrcb021 = ''   #161114-00028#1 Add
      #1508170001--Kris:axrp132  折襄單時, 應取銷貨退回的會科
      #IF g_master.b_style = 'axrt340' THEN  #160426-00013#1 mark
      IF g_end_prog = 'axrt340' THEN         #160426-00013#1   
         CALL s_fin_get_account(g_xrca.xrcald,'13',g_xrca.xrca007,'8304_04') RETURNING g_sub_success,g_xrcb.xrcb021,g_errno
      END IF
      #160920-00013#1 --s  add
      IF g_end_prog = 'axrt341' THEN           
         #CALL s_fin_get_account(g_xrca.xrcald,'13',g_xrca.xrca007,'8304_29') RETURNING g_sub_success,l_xrca036,g_errno
         SELECT glab005 INTO l_xrca036 FROM glab_t 
          WHERE glabld = g_master.xrcald 
            AND glabent = g_enterprise
            AND glab002 = g_xrca.xrca007   # 帳款類別
            AND glab001 = '13'             # 應收帳務類型科目設定
            AND glab003 = '8304_05'
      END IF
      #160920-00013#1 --e  add
      #150807-00010#1 --(S)
      IF g_xrcb.xrcb001 = '21' THEN
         LET l_xmdk082 = ''
         SELECT xmdk004,xmdk082
           INTO l_xmdk004,l_xmdk082
           FROM xmdk_t
          WHERE xmdkent   = g_enterprise
            AND xmdkdocno = g_xrcb.xrcb002
        #IF l_xmdk082 = '4' THEN                    #151013-00019#7 mark
         IF l_xmdk082 = '1' OR l_xmdk082 = '4' THEN #151013-00019#7
            SELECT xmdl050 INTO l_xmdl050
              FROM xmdl_t
             WHERE xmdlent = g_enterprise
               AND xmdldocno = g_xrcb.xrcb002 AND xmdlseq = g_xrcb.xrcb003
            CALL s_fin_dept_reasons_with_ld_get_account(l_xmdk004,'310',l_xmdl050,g_xrca.xrcald,'@2@11',g_xrca.xrcadocdt)
                 RETURNING g_sub_success,g_xrcb.xrcb021,g_errno
         END IF
         IF cl_null(g_xrcb.xrcb021) THEN
            CALL s_fin_get_account(g_xrca.xrcald,'13',g_xrca.xrca007,'8304_04') RETURNING g_sub_success,g_xrcb.xrcb021,g_errno
         END IF
      END IF
      #150807-00010#1 --(E)
      IF cl_null(g_xrcb.xrcb021) THEN  #150807-00010#1 
         CALL s_axrt300_item_acc(g_xrca.xrcald,g_xrcb.xrcbdocno,g_xrcb.xrcbseq,g_xrca.xrca036,g_xrcb.xrcb004)   #160120-00011#3 add g_xrcb.xrcbdocno,g_xrcb.xrcbseq lujh
            RETURNING g_xrcb.xrcb021
      END IF
      #160909-00084#1 Add  ---(S)---
      IF l_isaf.isaf001 = '3' AND g_sfin2022 = '02' THEN
         SELECT glab005 INTO g_xrcb.xrcb021 FROM glab_t 
          WHERE glabld = g_master.xrcald 
            AND glabent = g_enterprise
            AND glab002 = g_xrca.xrca007   # 帳款類別
            AND glab001 = '13'             # 應收帳務類型科目設定
            AND glab003 = '8304_22'
      END IF
      #160909-00084#1 Add  ---(E)---            #150807-00010#1 
      LET g_xrcb.xrcb022 = l_isag.isag015
      LET g_xrcb.xrcb024 = ''
      LET g_xrcb.xrcb025 = ''
      LET g_xrcb.xrcb026 = ''

      #albireo 151005-----s
      #kris:不論內外銷  銷退單身發票與aist310單身相同   
      #                出貨與單頭同
      IF l_isaf.isaf056 = '2' THEN
         LET g_xrcb.xrcb027 = l_isag.isag013
         LET g_xrcb.xrcb028 = l_isag.isag014         
      ELSE
         LET g_xrcb.xrcb027 = l_isaf.isaf010
         LET g_xrcb.xrcb028 = l_isaf.isaf011
      END IF
      #albireo 151005-----e
      LET g_xrcb.xrcb029 = g_xrca.xrca035
      LET g_xrcb.xrcb030 = 0
      LET g_xrcb.xrcb031 = l_isag.isag012
      #150518-00046#5 --s add
      IF g_progflag = 'aisp340' THEN
         #RMA單號
         SELECT rmdb001 INTO g_xrcb.xrcb048 
           FROM rmda_t,rmdb_t
            WHERE rmdaent = g_enterprise 
              AND rmdadocno = g_xrcb.xrcb002 
              AND rmdbseq   = g_xrcb.xrcb003
              AND rmda007   = g_xrca.xrca004
              AND rmda008   = g_xrca.xrca004
              AND rmdaent = rmdbent 
              AND rmdadocno = rmdbdocno 
      END IF
      #150518-00046#5 --e add
      LET g_xrcb.xrcb049 = l_isag.isagdocno
      LET g_xrcb.xrcb050 = l_isag.isagseq
      IF cl_null(g_xrcb.xrcb031) THEN
         LET g_xrcb.xrcb031 = g_xrca.xrca008
      END IF
      LET g_xrcb.xrcb051 = l_isaf.isaf057
      LET g_xrcb.xrcb100 = g_xrca.xrca100
      LET g_xrcb.xrcb101 = l_isag.isag101
      LET g_xrcb.xrcb111 = g_xrcb.xrcb101 * g_xrcb.xrcb020
      CALL s_axrt300_exrate(g_glaa.glaa002,g_xrca.xrcadocdt,g_xrca.xrca100,g_glaa.glaa001,g_xrcb.xrcb101,g_xrca.xrca101,g_glaa.glaacomp)
         RETURNING l_success,g_xrcb.xrcb111
     #IF l_success = 'N' THEN LET g_success = 'N' END IF
     #151214-00018#1 Mark ---(S)---
     #CALL s_tax_ins(g_xrca.xrcadocno,g_xrcb.xrcbseq,0,g_glaa.glaacomp,
     #               g_xrcb.xrcb101 * g_xrcb.xrcb007,g_xrcb.xrcb020,
     #               g_xrcb.xrcb007,g_xrcb.xrcb100,g_xrca.xrca101,g_xrca.xrcald,g_xrca.xrca121,g_xrca.xrca131)
     #   RETURNING g_xrcb.xrcb103,g_xrcb.xrcb104,g_xrcb.xrcb105,
     #             g_xrcb.xrcb113,g_xrcb.xrcb114,g_xrcb.xrcb115,
     #             g_xrcb.xrcb123,g_xrcb.xrcb124,g_xrcb.xrcb125,
     #             g_xrcb.xrcb133,g_xrcb.xrcb134,g_xrcb.xrcb135
     #151214-00018#1 Mark ---(E)---
     #151214-00018#1 Add  ---(S)---

      #DROP TABLE axrp132_detail
      DELETE FROM axrp132_detail  #160826-00004#1 mod

      INSERT INTO axrp132_detail  #160826-00004#1 add
      SELECT * FROM xrcd_t WHERE xrcdent = g_enterprise
         AND xrcddocno = l_isag.isagdocno
         AND xrcdseq = l_isag.isagseq
      #INTO TEMP axrp132_detail #160826-00004#1 mark

      UPDATE axrp132_detail SET xrcddocno = g_xrca.xrcadocno,xrcdseq = g_xrcb.xrcbseq,
                                xrcdld = g_xrca.xrcald   #160810-00043#1 Add

      INSERT INTO xrcd_t SELECT * FROM axrp132_detail

      LET g_xrcb.xrcb103 = l_isag.isag103
      LET g_xrcb.xrcb104 = l_isag.isag104
      LET g_xrcb.xrcb105 = l_isag.isag105
      LET g_xrcb.xrcb113 = l_isag.isag113
      LET g_xrcb.xrcb114 = l_isag.isag114
      LET g_xrcb.xrcb115 = l_isag.isag115
      IF g_glaa.glaa015 = 'Y' THEN
         IF g_glaa.glaa017 = '1' THEN
            LET g_xrcb.xrcb123 = g_xrcb.xrcb103 * g_xrca.xrca121
            LET g_xrcb.xrcb124 = g_xrcb.xrcb104 * g_xrca.xrca121
            LET g_xrcb.xrcb125 = g_xrcb.xrcb105 * g_xrca.xrca121
         ELSE
            LET g_xrcb.xrcb123 = g_xrcb.xrcb113 * g_xrca.xrca121
            LET g_xrcb.xrcb124 = g_xrcb.xrcb114 * g_xrca.xrca121
            LET g_xrcb.xrcb125 = g_xrcb.xrcb115 * g_xrca.xrca121
         END IF
      END IF
      IF g_glaa.glaa019 = 'Y' THEN
         IF g_glaa.glaa021 = '1' THEN
            LET g_xrcb.xrcb133 = g_xrcb.xrcb103 * g_xrca.xrca121
            LET g_xrcb.xrcb134 = g_xrcb.xrcb104 * g_xrca.xrca121
            LET g_xrcb.xrcb135 = g_xrcb.xrcb105 * g_xrca.xrca121
         ELSE
            LET g_xrcb.xrcb133 = g_xrcb.xrcb113 * g_xrca.xrca121
            LET g_xrcb.xrcb134 = g_xrcb.xrcb114 * g_xrca.xrca121
            LET g_xrcb.xrcb135 = g_xrcb.xrcb115 * g_xrca.xrca121
         END IF
      END IF
     #151214-00018#1 Add  ---(E)---  
      UPDATE xrcd_t SET xrcd009 = l_xrcd009
       WHERE xrcd009 IS NULL
         AND xrcdent = g_enterprise
         AND xrcddocno = g_xrca.xrcadocno
         AND xrcdld = g_xrca.xrcald
      CALL s_tax_chk(g_glaa.glaacomp,g_xrcb.xrcb020)
         RETURNING l_success,l_oodbl004,l_oodb005,l_xrca.xrca012,l_oodb011
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
      LET g_xrcb.xrcb102 = g_xrca.xrca101   #160830-00047#1 Add

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
      
     #160810-00015#1 Add  ---(S)---
      #判斷有無暫估
      CALL s_axrp130_estimate_chk(g_xrcb.xrcbld,g_xrca.xrcadocdt,g_xrca.xrca004,g_xrca.xrca100,g_xrcb.xrcb001,g_xrcb.xrcb002,g_xrcb.xrcb003) RETURNING l_success
      IF NOT l_success THEN      
         LET g_xrcb.xrcb023 = 'N'
      ELSE
         LET g_xrcb.xrcb023 = 'Y'
      END IF
     #160810-00015#1 Add  ---(E)---

     #161025-00017#1 add s---
     IF g_xrcb.xrcb001 = '21' OR g_xrcb.xrcb001 = '11' THEN #销退单，出货单
        SELECT xmdk030 INTO g_xrcb.xrcb034
          FROM xmdk_t
         WHERE xmdkent   = g_enterprise
           AND xmdkdocno = g_xrcb.xrcb002        
     END IF
     IF g_xrcb.xrcb001 = '10' THEN  #订单
        SELECT xmda023 INTO g_xrcb.xrcb034
          FROM xmda_t
         WHERE xmdaent   = g_enterprise
           AND xmdadocno = g_xrcb.xrcb002     
     END IF
     #161025-00017#1 add e---

     #LET g_xrcb.xrcb023 = 'N'   #151008-00009#8 mark   #160426-00013#1
     
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
     #160920-00004#1 Add  ---(S)---
      DELETE FROM xrcf_t WHERE xrcfent = g_enterprise AND xrcfdocno = g_xrcb.xrcbdocno AND xrcfld = g_xrcb.xrcbld
      CALL s_axrp130_ins_xrcf(g_xrcb.xrcbld,g_xrcb.xrcbdocno,'','0') RETURNING l_success 
     #160920-00004#1 Add  ---(E)---  
     #151008-00009#8 remark--(S)
      #160426-00013#1 mark ------
      #160511-00016#1 mod--str--
      #CALL s_axrp130_ins_xrcf(g_xrcb.xrcbld,g_xrcb.xrcbdocno,g_xrcb.xrcbseq,'Y') RETURNING g_xrcb.xrcb023
     #CALL s_axrp130_ins_xrcf(g_xrcb.xrcbld,g_xrcb.xrcbdocno,g_xrcb.xrcbseq,'0') RETURNING l_success   #160920-00004#1 Mark
     #160810-00015#1 Mark ---(S)---
     # IF l_success THEN
     #     LET g_xrcb.xrcb023 = 'Y'
     # ELSE
     #     LET g_xrcb.xrcb023 = 'N'
     # END IF
     # #151008-00009#8--s
     # #判斷有無暫估
     # CALL s_axrp130_estimate_chk(g_xrcb.xrcbld,g_xrca.xrcadocdt,g_xrca.xrca004,g_xrca.xrca100,g_xrcb.xrcb001,g_xrcb.xrcb002,g_xrcb.xrcb003) RETURNING l_success
     # IF NOT l_success THEN      
     #    LET g_xrcb.xrcb023 = 'N'
     # END IF
     # #151008-00009#8--e
     # #160511-00016#1 mod--end--
     # UPDATE xrcb_t SET xrcb023 = g_xrcb.xrcb023
     #  WHERE xrcbent = g_enterprise
     #    AND xrcbld = g_xrcb.xrcbld
     #    AND xrcbdocno = g_xrcb.xrcbdocno
     #    AND xrcbseq = g_xrcb.xrcbseq
     #160810-00015#1 Mark ---(E)---
      #160426-00013#1 mark end---
     #151008-00009#8 remark--(E)
     #151008-00009#8 mark--(S)     
     ##160426-00013#1 add ------
     ##先判斷有無暫估，有再沖，若沖完再update
     #CALL s_axrp130_estimate_chk(g_xrcb.xrcbld,g_xrca.xrcadocdt,g_xrca.xrca004,g_xrca.xrca100,g_xrcb.xrcb001,g_xrcb.xrcb002,g_xrcb.xrcb003) RETURNING l_success
     #IF l_success THEN
     #   CALL s_axrp130_ins_xrcf(g_xrcb.xrcbld,g_xrcb.xrcbdocno,g_xrcb.xrcbseq,'0') RETURNING l_success
     #   IF l_success THEN
     #      LET g_xrcb.xrcb023 = 'Y'
     #      UPDATE xrcb_t SET xrcb023 = g_xrcb.xrcb023
     #       WHERE xrcbent = g_enterprise
     #         AND xrcbld = g_xrcb.xrcbld
     #         AND xrcbdocno = g_xrcb.xrcbdocno
     #         AND xrcbseq = g_xrcb.xrcbseq
     #   END IF
     #END IF
     ##160426-00013#1 add end---
     #151008-00009#8 mark--(E)
      
      LET l_xrcb103 = l_xrcb103 - g_xrcb.xrcb103
      LET l_xrcb105 = l_xrcb105 - g_xrcb.xrcb105
      
      #151008-00009#8--s
      #有作沖暫估時,不處理遞延寫入;因為在立暫估的時候已經處理
      IF g_xrcb.xrcb023 = 'N' THEN
         LET lc_param.xrcasite  = g_xrca.xrcasite
         LET lc_param.xrcald    = g_xrca.xrcald
         LET lc_param.xrcacomp  = g_xrca.xrcacomp
         LET lc_param.xrcadocno = g_xrca.xrcadocno
         LET lc_param.xrcadocdt = g_xrca.xrcadocdt
         LET lc_param.xrca001   = g_xrca.xrca001
         LET lc_param.xrca003   = g_xrca.xrca003
         LET lc_param.xrca004   = g_xrca.xrca004
         LET lc_param.xrca005   = g_xrca.xrca005
         LET lc_param.xrca058   = g_xrca.xrca058
         LET lc_param.xrca100   = g_xrca.xrca100
         LET lc_param.xrca101   = g_xrca.xrca101
         LET lc_param.xrca121   = g_xrca.xrca121
         LET lc_param.xrca131   = g_xrca.xrca131
         LET lc_param.xrcbseq   = g_xrcb.xrcbseq
         LET lc_param.xrcb002   = g_xrcb.xrcb002
         LET lc_param.xrcb003   = g_xrcb.xrcb003
         LET lc_param.xrcb004   = g_xrcb.xrcb004
         LET lc_param.xrcb008   = g_xrcb.xrcb008
         LET lc_param.xrcb009   = g_xrcb.xrcb009
         LET lc_param.xrcb010   = g_xrcb.xrcb010
         LET lc_param.xrcb011   = g_xrcb.xrcb011
         LET lc_param.xrcb012   = g_xrcb.xrcb012
         LET lc_param.xrcb015   = g_xrcb.xrcb015
         LET lc_param.xrcb016   = g_xrcb.xrcb016
         LET lc_param.xrcb021   = g_xrcb.xrcb021
         LET lc_param.xrcb024   = g_xrcb.xrcb024
         LET lc_param.xrcb033   = g_xrcb.xrcb033
         LET lc_param.xrcb034   = g_xrcb.xrcb034
         LET lc_param.xrcb035   = g_xrcb.xrcb035
         LET lc_param.xrcb036   = g_xrcb.xrcb036
         LET lc_param.xrcb037   = g_xrcb.xrcb037
         LET lc_param.xrcb038   = g_xrcb.xrcb038
         LET lc_param.xrcb039   = g_xrcb.xrcb039
         LET lc_param.xrcb040   = g_xrcb.xrcb040
         LET lc_param.xrcb041   = g_xrcb.xrcb041
         LET lc_param.xrcb042   = g_xrcb.xrcb042
         LET lc_param.xrcb043   = g_xrcb.xrcb043
         LET lc_param.xrcb044   = g_xrcb.xrcb044
         LET lc_param.xrcb045   = g_xrcb.xrcb045
         LET lc_param.xrcb046   = g_xrcb.xrcb046
         LET lc_param.xrcb047   = g_xrcb.xrcb047
         LET lc_param.xrcb051   = g_xrcb.xrcb051
         LET lc_param.xrcb103   = g_xrcb.xrcb103
         LET lc_param.xrcb113   = g_xrcb.xrcb113
         LET lc_param.xrcb123   = g_xrcb.xrcb123
         LET lc_param.xrcb133   = g_xrcb.xrcb133     
         LET lc_param.type1     = '1'
         LET ls_js = util.JSON.stringify(lc_param)       
         #寫入遞延檔
         CALL s_axrt470_ins_deferred(ls_js) RETURNING g_sub_success
         IF NOT g_sub_success THEN
            LET l_doc_success = FALSE
         END IF
      END IF
      #151008-00009#8--e
      CASE
         WHEN l_s = '1'
            UPDATE isaf_t SET isaf035 = g_xrca.xrcadocno
             WHERE isafdocno=l_isaf.isafdocno
              #AND isafcomp= g_xrca.xrcacomp   #160317-00018#1 Mark
               AND isafcomp= l_isaf.isafcomp   #160317-00018#1 Add
               AND isafent = g_enterprise
               
            IF NOT g_progflag = 'aisp340' THEN #150518-00046#5 add   
               SELECT xmdl038 INTO l_xmdlnum FROM xmdl_t
                WHERE xmdldocno = g_xrcb.xrcb002
                  AND xmdlseq = g_xrcb.xrcb003
                  AND xmdlent = g_enterprise
                  
               IF cl_null(l_xmdlnum) THEN LET l_xmdlnum=0 END IF
               UPDATE xmdl_t SET xmdl038 = l_xmdlnum + g_xrcb.xrcb007
                WHERE xmdldocno = g_xrcb.xrcb002
                  AND xmdlseq = g_xrcb.xrcb003
                  AND xmdlent = g_enterprise
            END IF #150518-00046#5 add
            
         WHEN l_s = '2'
            UPDATE isaf_t SET isaf048 = g_xrca.xrcadocno
             WHERE isafdocno=l_isaf.isafdocno
              #AND isafcomp= g_xrca.xrcacomp   #160317-00018#1 Mark
               AND isafcomp= l_isaf.isafcomp   #160317-00018#1 Add
               AND isafent = g_enterprise
               
            IF NOT g_progflag = 'aisp340' THEN #150518-00046#5 add  
               SELECT xmdl039 INTO l_xmdlnum FROM xmdl_t
                WHERE xmdldocno = g_xrcb.xrcb002
                  AND xmdlseq = g_xrcb.xrcb003
                  AND xmdlent = g_enterprise
                  
               IF cl_null(l_xmdlnum) THEN LET l_xmdlnum=0 END IF
               UPDATE xmdl_t SET xmdl039 = l_xmdlnum + g_xrcb.xrcb007
                WHERE xmdldocno = g_xrcb.xrcb002
                  AND xmdlseq = g_xrcb.xrcb003
                  AND xmdlent = g_enterprise
            END IF #150518-00046#5 add
            
         WHEN l_s = '3'
            UPDATE isaf_t SET isaf049 = g_xrca.xrcadocno
             WHERE isafdocno=l_isaf.isafdocno
              #AND isafcomp= g_xrca.xrcacomp   #160317-00018#1 Mark
               AND isafcomp= l_isaf.isafcomp   #160317-00018#1 Add
               AND isafent = g_enterprise
               
            IF NOT g_progflag = 'aisp340' THEN #150518-00046#5 add  
               SELECT xmdl040 INTO l_xmdlnum FROM xmdl_t
                WHERE xmdldocno = g_xrcb.xrcb002
                  AND xmdlseq = g_xrcb.xrcb003
                  AND xmdlent = g_enterprise
                  
               IF cl_null(l_xmdlnum) THEN LET l_xmdlnum=0 END IF
               UPDATE xmdl_t SET xmdl040 = l_xmdlnum + g_xrcb.xrcb007
                WHERE xmdldocno = g_xrcb.xrcb002
                  AND xmdlseq = g_xrcb.xrcb003
                  AND xmdlent = g_enterprise
            END IF #150518-00046#5 add
      END CASE
      
      LET l_order_t = g_isaf_d[li_idx].order   #20150201#1 By zhangwei Mod l_order ---> g_isaf_d[li_idx].order

   END FOR   #20150201#1 BY zhangwei Mod FOREACH ---> FOR

   #因為是換成了FOREACH中單筆資料走事物,所以最後一筆的產生多帳期會寫彈頭失敗的話,需要删除已经commit的資料
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
      #回寫單頭金額
      UPDATE xrca_t SET (xrca103,xrca104,xrca113,xrca114,xrca123,xrca124,xrca133,xrca134) = (g_xrca.xrca103,g_xrca.xrca104,g_xrca.xrca113,g_xrca.xrca114,g_xrca.xrca123,g_xrca.xrca124,g_xrca.xrca133,g_xrca.xrca134) 
       WHERE xrcaent = g_enterprise AND xrcald = g_xrca.xrcald AND xrcadocno = g_xrca.xrcadocno
      IF SQLCA.SQLCODE THEN
        #LET g_success = 'N'         #20150201#1 By zhangwei Mark
         LET l_doc_success = FALSE   #20150201#1 By zhangwei Add
      END IF
      LET l_count = 0
      #單身如果有多筆發票則更新單頭發票號碼為'MULTI'
      SELECT COUNT(DISTINCT xrcb027||xrcb028) INTO l_count FROM xrcb_t WHERE xrcbent = g_enterprise
         AND xrcbdocno = g_xrca.xrcadocno AND xrcbld = g_xrca.xrcald
      IF cl_null(l_count) THEN LET l_count = 0 END IF
      IF l_count > 1 THEN
         UPDATE xrca_t SET xrca066 = 'MULTI'
          WHERE xrcaent = g_enterprise AND xrcald = g_xrca.xrcald AND xrcadocno = g_xrca.xrcadocno
      END IF
      #如果單身資料多來源/多單據則令單頭來源類型、來源單號為空
      LET l_count = 0
      CASE
         WHEN l_s = 1
            SELECT COUNT(DISTINCT isafdocno) INTO l_count FROM isaf_t WHERE isafent = g_enterprise
               AND isaf035 = g_xrca.xrcadocno
         WHEN l_s = 2
            SELECT COUNT(DISTINCT isafdocno) INTO l_count FROM isaf_t WHERE isafent = g_enterprise
               AND isaf048 = g_xrca.xrcadocno
         WHEN l_s = 3
            SELECT COUNT(DISTINCT isafdocno) INTO l_count FROM isaf_t WHERE isafent = g_enterprise
               AND isaf049 = g_xrca.xrcadocno
      END CASE
      IF cl_null(l_count) THEN LET l_count = 0 END IF
      IF l_count > 1 THEN
         UPDATE xrca_t SET xrca018 = ''
          WHERE xrcaent = g_enterprise AND xrcald = g_xrca.xrcald AND xrcadocno = g_xrca.xrcadocno
      END IF
     #LET l_count = 0
     #SELECT COUNT(DISTINCT xrcb001) INTO l_count FROM xrcb_t WHERE xrcbent = g_enterprise
     #   AND xrcbdocno = g_xrca.xrcadocno AND xrcbld = g_xrca.xrcald
     #   AND xrcb001 NOT IN ('19','29')
     #IF cl_null(l_count) THEN LET l_count = 0 END IF
     #IF l_count > 1 THEN
     #   UPDATE xrca_t SET xrca016 = ''
     #    WHERE xrcaent = g_enterprise AND xrcald = g_xrca.xrcald AND xrcadocno = g_xrca.xrcadocno
     #END IF
     #151130-00015#3 Mod  ---(S)---
     #CALL axrp132_ins_xrce()
      #LET la_param.p_style = g_master.b_style #160426-00013#1 mark
      LET la_param.p_style = g_end_prog        #160426-00013#1
      LET la_param.p_check = g_master.b_check1,g_master.b_check2,g_master.b_check3,g_master.b_check4,g_master.b_check5,g_master.b_check6
      LET la_param.p_isafdocno = g_isaf_d[li_idx-1].isafdocno   #160426-00013#1
      LET ls_js = util.JSON.stringify(la_param)
      CALL s_axrp133_ins_xrce(g_xrca.xrcadocno,g_xrca.xrcald,ls_js)
     #151130-00015#3 Mod  ---(E)---
      CALL s_axrt300_installments(g_xrca.xrcald,g_xrca.xrcadocno) RETURNING l_success 
      IF l_success = FALSE OR l_success = 'N' THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = g_master.xrcadocno
         LET g_errparam.code   = 'aap-00187'
         LET g_errparam.popup  = TRUE
         CALL cl_err()
        #LET g_success = 'N'         #20150201#1 By zhangwei Mark
         LET l_doc_success = FALSE   #20150201#1 By zhangwei Add
      END IF
   END IF
   #20150201#1 By zhangwei Add ---(S)---
   IF g_glaa.glaa121 = 'Y' AND l_dfin0030 = 'Y' THEN
      CALL s_pre_voucher_ins('AR','R10',g_glaa.glaald,g_xrca.xrcadocno,g_xrca.xrcadocdt,'1') RETURNING l_success
      IF NOT l_success THEN
         LET l_doc_success = FALSE
      END IF
   END IF
   #20150201#1 By zhangwei Add ---(E)---

   #151125-00006#1---add---s  执行立即审核功能
   CALL s_aooi200_fin_get_slip(g_xrca.xrcadocno) RETURNING l_slip_success,l_ooba002
   CALL s_fin_get_doc_para(g_xrca.xrcald,g_xrca.xrcacomp,l_ooba002,'D-FIN-0031') RETURNING l_dfin0031
   
   IF NOT cl_null(l_dfin0031) AND l_dfin0031 MATCHES '[Yy]' THEN 
      CALL s_axrp133_immediately_conf(g_xrca.xrcald,g_xrca.xrcadocno) RETURNING l_conf_success
      IF NOT l_conf_success THEN 
         LET l_doc_success = FALSE
      END IF 
   END IF 
   #151125-00006#1---add---e
   
   #20150201#1 By zhangwei Add ---(S)---
   IF l_doc_success THEN  
  #IF l_doc_success AND ( (not cl_null(l_conf_success) AND l_conf_success) OR cl_null(l_conf_success) ) THEN    #151125-00006#1 add by aiqq
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
# Usage..........: CALL axrp132_get_ooef001_wc(p_wc)
#                  RETURNING r_wc
# Input parameter: p_wc           sub产生的数据集
# Return code....: r_wc           SQ可用的数据集
# Date & Author..: 2014/10/17 By zhangweib
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp132_get_ooef001_wc(p_wc)
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
# Usage..........: CALL axrp132_ins_xrce()
#                  RETURNING ---
# Input parameter: 
# Return code....: 
# Date & Author..: 2014/10/17 By zhangweib
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp132_ins_xrce()
 # DEFINE l_count             LIKE type_t.num5
 # DEFINE l_seq               LIKE type_t.num5
 # DEFINE l_xrccdocno         LIKE xrcc_t.xrccdocno
 # DEFINE l_xrccseq           LIKE xrcc_t.xrccseq
 # DEFINE l_xrcc001           LIKE xrcc_t.xrcc001
 # DEFINE l_xrca060           LIKE xrca_t.xrca060
 # DEFINE l_xrca103           LIKE xrca_t.xrca103
 # DEFINE l_xrca113           LIKE xrca_t.xrca113
 # DEFINE l_xrca              RECORD LIKE xrca_t.*
 # DEFINE l_xrcb              RECORD LIKE xrcb_t.*
 # DEFINE l_xrcc              RECORD LIKE xrcc_t.*
 # DEFINE l_xrce              RECORD LIKE xrce_t.*
 # DEFINE l_sql               STRING
 # DEFINE ls_wc               STRING
 # DEFINE l_wc1               STRING
 # DEFINE l_ooef014           LIKE ooef_t.ooef014
 # DEFINE l_ooaj004           LIKE ooaj_t.ooaj004
 # DEFINE l_xrca100           LIKE xrca_t.xrca100
 # DEFINE l_success           LIKE type_t.num5
 # DEFINE l_errno             LIKE type_t.chr10
 # #150316-00013#1 By 01727 Add  ---(S)---
 # DEFINE l_glaacomp          LIKE glaa_t.glaacomp
 # DEFINE l_sfin1002          LIKE type_t.chr1
 # DEFINE l_xrce109           LIKE xrce_t.xrce109
 # DEFINE l_xrce119           LIKE xrce_t.xrce119
 # DEFINE l_xrce129           LIKE xrce_t.xrce129
 # DEFINE l_xrce139           LIKE xrce_t.xrce139
 # #150316-00013#1 By 01727 Add  ---(E)---
 #    
 # #151130-00015#3 Mark  ---(S)---
 # #函數作廢,改用CALL s_axrp133_ins_xrce(p_xrcadocno,p_xrcald,ls_js)
 # #151130-00015#3 Mark  ---(E)---
 #
 # SELECT ooef014 INTO l_ooef014 FROM ooef_t
 #  WHERE ooefent = g_enterprise AND ooef001 = g_glaa.glaacomp
 #    
 # #1.取基础币种的金额精度--若有传入p_amount时,返回的是金额,非汇率
 # CALL s_curr_sel_ooaj004(l_ooef014,g_glaa.glaa001)
 #      RETURNING l_ooaj004
 #
 # #STEP1:若發票單身有"27:其他待抵單"則先沖銷其他待抵單
 # #STEP2:依據"自動沖銷"的勾選項,彙整待抵單
 #
 # #勾選訂金待抵:自動沖同一帳款客戶,同一收款客戶 帳款單性質=21 之訂金待抵
 # #勾選銷退待抵:自動沖同一帳款客戶,同一收款客戶 帳款單性質=22 之銷退待抵
 # #勾選預收待抵:自動沖同一帳款客戶,同一收款客戶 帳款單性質=23 之预收待抵
 # #勾選其他待抵:自動沖同一帳款客戶,同一收款客戶 帳款單性質=29 之其他扣抵
 # #勾選溢收待抵:自動沖同一帳款客戶,同一收款客戶 帳款單性質=24 之溢收待抵
 # #勾選押金待抵:自動沖同一帳款客戶,同一收款客戶 帳款單性質=25 之押金待抵
 #
 # IF g_master.b_style = 'axrt340' THEN RETURN END IF
 #
 # #150316-00013#1 By 01727 Add  ---(S)---
 # SELECT glaacomp INTO l_glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_master.xrcald
 # CALL cl_get_para(g_enterprise,l_glaacomp,'S-FIN-1002') RETURNING l_sfin1002
 # #150316-00013#1 By 01727 Add  ---(E)---
 #
 # LET ls_wc = " xrca004 = '",g_xrca.xrca004,"' AND xrca005 = '",g_xrca.xrca005,"' "
 # LET l_count = 0
 # IF g_master.b_check1 = 'Y' THEN
 #    IF NOT cl_null(l_wc1) THEN LET l_wc1 = l_wc1,"','" END IF
 #    LET l_wc1 = l_wc1,"21"
 # ELSE
 #    LET l_count = l_count + 1
 # END IF
 #
 # IF g_master.b_check2 = 'Y' THEN
 #    IF NOT cl_null(l_wc1) THEN LET l_wc1 = l_wc1,"','" END IF
 #    LET l_wc1 = l_wc1,"22"
 # ELSE
 #    LET l_count = l_count + 1
 # END IF
 # IF g_master.b_check3 = 'Y' THEN
 #    IF NOT cl_null(l_wc1) THEN LET l_wc1 = l_wc1,"','" END IF
 #    LET l_wc1 = l_wc1,"23"
 # ELSE
 #    LET l_count = l_count + 1
 # END IF
 # IF g_master.b_check4 = 'Y' THEN
 #    IF NOT cl_null(l_wc1) THEN LET l_wc1 = l_wc1,"','" END IF
 #    LET l_wc1 = l_wc1,"29"
 # ELSE
 #    LET l_count = l_count + 1
 # END IF
 # IF g_master.b_check5 = 'Y' THEN
 #    IF NOT cl_null(l_wc1) THEN LET l_wc1 = l_wc1,"','" END IF
 #    LET l_wc1 = l_wc1,"24"
 # ELSE
 #    LET l_count = l_count + 1
 # END IF
 # IF g_master.b_check6 = 'Y' THEN
 #    IF NOT cl_null(l_wc1) THEN LET l_wc1 = l_wc1,"','" END IF
 #    LET l_wc1 = l_wc1,"25"
 # ELSE
 #    LET l_count = l_count + 1
 # END IF
 # IF l_count < 6 THEN LET ls_wc = ls_wc," AND xrca001 IN ('",l_wc1,"')" ELSE RETURN END IF
 #
 # LET l_sql = "(SELECT xrccdocno,xrccseq,xrcc001,1 flag,xrcadocdt,CASE WHEN xrca100 = '",g_xrca.xrca100,"' THEN 1 ELSE 2 END flag1 FROM xrcc_t,xrca_t       ",
 #             " WHERE xrccld = '",g_master.xrcald,"'                                               ",
 #             "   AND xrcc108 - xrcc109 > 0                                                        ",
 #             "   AND xrccent = xrcaent AND xrccdocno = xrcadocno AND xrccld = xrcald              ",
 #             "   AND EXISTS (SELECT 1 FROM isag_t WHERE isagent = '",g_enterprise,"'              ",
 #             "                  AND isag001 = '26' AND isagcomp = '",g_xrca.xrcacomp,"'           ",
 #             "                  AND isag002 = xrccdocno AND isag003 = xrccseq                     ",
 #             "                  AND isagdocno IN ( SELECT DISTINCT xrcb002 FROM xrcb_t            ",
 #             "                                      WHERE xrcbent = '",g_enterprise,"'            ",
 #             "                                        AND xrcbdocno = '",g_xrca.xrcadocno,"'      ",
 #             "                                        AND xrcbld = '",g_xrca.xrcald,"'          ))"
 #
 # LET l_sql = l_sql," UNION "
 #
 # LET l_sql = l_sql,"SELECT xrccdocno,xrccseq,xrcc001,2 flag,xrcadocdt,CASE WHEN xrca100 = '",g_xrca.xrca100,"' THEN 1 ELSE 2 END flag1 FROM xrcc_t,xrca_t  ",
 #             " WHERE xrccent = xrcaent AND xrccdocno = xrcadocno AND xrccld = xrcald              ",
 #             "   AND xrccld = '",g_master.xrcald,"'                                               ",
 #             "   AND xrcc108 - xrcc109 > 0                                                        ",
 #             "   AND xrcadocdt <= '",g_master.xrcadocdt,"'                                        ",
 #             "   AND ",ls_wc,") ORDER BY flag ASC,flag1 ASC,xrcadocdt"
 # PREPARE axrp132_xrce_prep FROM l_sql
 # DECLARE axrp132_xrce_curs CURSOR FOR axrp132_xrce_prep
 #
 # LET l_xrce.xrceseq = 0
 # LET l_xrca103 = g_xrca.xrca103 + g_xrca.xrca104
 # LET l_xrca113 = g_xrca.xrca113 + g_xrca.xrca114
 #
 # FOREACH axrp132_xrce_curs INTO l_xrccdocno,l_xrccseq,l_xrcc001
 #    IF l_xrca103 = 0 THEN EXIT FOREACH END IF
 #    SELECT * INTO l_xrca.* FROM xrca_t WHERE xrcaent = g_enterprise
 #       AND xrcadocno = l_xrccdocno AND xrcald = g_master.xrcald
 #    SELECT * INTO l_xrcb.* FROM xrcb_t WHERE xrcbent = g_enterprise
 #       AND xrcbdocno = l_xrccdocno AND xrcbseq = l_xrccseq AND xrcbld = g_master.xrcald
 #    SELECT * INTO l_xrcc.* FROM xrcc_t WHERE xrccent = g_enterprise
 #       AND xrccdocno = l_xrccdocno AND xrccseq = l_xrccseq AND xrcc001 = l_xrcc001 AND xrccld = g_master.xrcald
 #
 #    #150316-00013#1 By 01727 Add  ---(S)---
 #    #待抵單的可用餘額=xrcc108 - xrcc109 - 已沖帳但未確認金額
 #    #即等同於 xrcc108 - SUM(xrce109)
 #    LET l_xrce109 = 0    LET l_xrce119 = 0   LET l_xrce129 = 0   LET l_xrce139 = 0
 #    IF l_sfin1002 = '1' THEN
 #       SELECT SUM(xrce109),SUM(xrce119),SUM(xrce129),SUM(xrce139)
 #         INTO l_xrce109,l_xrce119,l_xrce129,l_xrce139
 #         FROM xrce_t
 #        WHERE xrceent = g_enterprise       AND xrceld  = g_master.xrcald
 #          AND xrce003 = l_xrcc.xrccdocno   AND xrce004 = l_xrcc.xrccseq
 #    ELSE
 #       SELECT SUM(xrce109),SUM(xrce119),SUM(xrce129),SUM(xrce139)
 #         INTO l_xrce109,l_xrce119,l_xrce129,l_xrce139
 #         FROM xrce_t
 #        WHERE xrceent = g_enterprise       AND xrceld  = g_master.xrcald
 #          AND xrce003 = l_xrcc.xrccdocno   AND xrce004 = l_xrcc.xrccseq
 #          AND xrce005 = l_xrcc.xrcc001
 #    END IF
 #    IF cl_null(l_xrce109) THEN LET l_xrce109 = 0 END IF
 #    IF cl_null(l_xrce119) THEN LET l_xrce119 = 0 END IF
 #    IF cl_null(l_xrce129) THEN LET l_xrce129 = 0 END IF
 #    IF cl_null(l_xrce139) THEN LET l_xrce139 = 0 END IF
 #    LET l_xrcc.xrcc109 = l_xrce109
 #    LET l_xrcc.xrcc119 = l_xrce119
 #    LET l_xrcc.xrcc129 = l_xrce129
 #    LET l_xrcc.xrcc139 = l_xrce139
 #    #150615-00017#2 Add  ---(S)---
 #    IF l_xrcc.xrcc108 - l_xrcc.xrcc109 = 0 THEN
 #       CONTINUE FOREACH
 #    END IF
 #    #150615-00017#2 Add  ---(E)---
 #    #150316-00013#1 By 01727 Add  ---(E)---
 #    LET l_xrce.xrceent = g_enterprise
 #    LET l_xrce.xrcecomp= g_glaa.glaacomp
 #    LET l_xrce.xrceld  = g_master.xrcald
 #    LET l_xrce.xrcedocno=g_xrca.xrcadocno
 #    LET l_xrce.xrceseq = l_xrce.xrceseq + 1
 #    LET l_xrce.xrcelegl= l_xrcc.xrcclegl
 #    LET l_xrce.xrcesite= l_xrcc.xrccsite
 #    LET l_xrce.xrceorga= l_xrcc.xrcclegl
 #    LET l_xrce.xrce001 = 'axrt340'
 #    LET l_xrce.xrce002 = '31'
 #    LET l_xrce.xrce003 = l_xrcc.xrccdocno
 #    LET l_xrce.xrce004 = l_xrccseq
 #    LET l_xrce.xrce005 = l_xrcc.xrcc001
 #    LET l_xrce.xrce006 = ''
 #    LET l_xrce.xrce008 = l_xrcc.xrccdocno
 #    LET l_xrce.xrce009 = ''
 #    LET l_xrce.xrce010 = ''
 #    LET l_xrce.xrce011 = ''
 #    LET l_xrce.xrce012 = ''
 #    LET l_xrce.xrce013 = ''
 #    LET l_xrce.xrce014 = ''
 #    LET l_xrce.xrce015 = 'D'
 #    LET l_xrce.xrce016 = l_xrca.xrca035
 #    LET l_xrce.xrce017 = l_xrca.xrca014
 #    LET l_xrce.xrce018 = l_xrcb.xrcb010
 #    LET l_xrce.xrce019 = l_xrcb.xrcb011
 #    LET l_xrce.xrce020 = l_xrcb.xrcb012
 #    LET l_xrce.xrce021 = l_xrcb.xrcb017
 #    LET l_xrce.xrce022 = l_xrcb.xrcb015
 #    LET l_xrce.xrce023 = l_xrcb.xrcb016
 #    LET l_xrce.xrce024 = l_xrcb.xrcb002
 #    LET l_xrce.xrce025 = l_xrcb.xrcb003
 #    LET l_xrce.xrce026 = ''
 #   #150316-00013#1 By 01727 Mark ---(S)---
 #   #SELECT xrca060 INTO l_xrca060 FROM xrca_t
 #   # WHERE xrcald = g_master.xrcald
 #   #   AND xrca019 = l_xrce.xrce003
 #   #150316-00013#1 By 01727 Mark ---(S)---
 #   #150316-00013#1 By 01727 Add  ---(S)---
 #    SELECT xrca060 INTO l_xrca060 FROM xrca_t
 #     WHERE xrcald = g_master.xrcald
 #       AND xrcadocno = l_xrce.xrce003
 #       AND xrcaent = g_enterprise
 #   #150316-00013#1 By 01727 Add  ---(S)---
 #    IF l_xrca060 = '2' THEN
 #       LET l_xrce.xrce027 = 'Y'
 #    ELSE
 #       LET l_xrce.xrce027 = 'N'
 #    END IF
 #    LET l_xrce.xrce028 = ''
 #    LET l_xrce.xrce029 = ''
 #    LET l_xrce.xrce030 = ''
 #    LET l_xrce.xrce035 = ''
 #    LET l_xrce.xrce036 = ''
 #    LET l_xrce.xrce037 = ''
 #    LET l_xrce.xrce038 = ''
 #    LET l_xrce.xrce104 = 0
 #    LET l_xrce.xrce114 = 0
 #    LET l_xrce.xrce124 = 0
 #    LET l_xrce.xrce134 = 0
 #    LET l_xrce.xrce100 = l_xrcc.xrcc100
 #    LET l_xrce.xrce101 = l_xrcc.xrcc102
 #    LET l_xrce.xrce120 = l_xrcc.xrcc120
 #    LET l_xrce.xrce121 = l_xrcc.xrcc122
 #    LET l_xrce.xrce130 = l_xrcc.xrcc130
 #    LET l_xrce.xrce131 = l_xrcc.xrcc132
 #
 #    IF g_xrca.xrca100 = l_xrca.xrca100 THEN
 #       IF l_xrca103 > l_xrcc.xrcc108 - l_xrcc.xrcc109 THEN
 #          LET l_xrce.xrce007 = l_xrcc.xrcc108 - l_xrcc.xrcc109
 #          LET l_xrce.xrce109 = l_xrcc.xrcc108 - l_xrcc.xrcc109
 #          LET l_xrce.xrce119 = l_xrcc.xrcc118 - l_xrcc.xrcc119
 #          LET l_xrce.xrce129 = l_xrcc.xrcc128 - l_xrcc.xrcc129
 #          LET l_xrce.xrce139 = l_xrcc.xrcc138 - l_xrcc.xrcc139
 #          LET l_xrca103 = l_xrca103 - l_xrcc.xrcc108 - l_xrcc.xrcc109
 #          LET l_xrca113 = l_xrca113 - l_xrcc.xrcc118 - l_xrcc.xrcc119
 #       ELSE
 #          LET l_xrce.xrce007 = l_xrca103
 #          LET l_xrce.xrce109 = l_xrca103
 #          LET l_xrce.xrce119 = l_xrca103 * l_xrcc.xrcc101
 #          LET l_xrce.xrce129 = l_xrca103 * l_xrcc.xrcc121
 #          LET l_xrce.xrce139 = l_xrca103 * l_xrcc.xrcc131
 #          LET l_xrca103 = 0
 #          LET l_xrca113 = l_xrca113 - l_xrca103 * l_xrcc.xrcc101
 #          IF l_xrca113 < 0 THEN LET l_xrca113 = 0 END IF
 #       END IF
 #    ELSE
 #       IF l_xrca113 > l_xrcc.xrcc118 - l_xrcc.xrcc119 THEN
 #          LET l_xrce.xrce007 = l_xrcc.xrcc108 - l_xrcc.xrcc109
 #          LET l_xrce.xrce109 = l_xrcc.xrcc108 - l_xrcc.xrcc109
 #          LET l_xrce.xrce119 = l_xrcc.xrcc118 - l_xrcc.xrcc119
 #          LET l_xrce.xrce129 = l_xrcc.xrcc128 - l_xrcc.xrcc129
 #          LET l_xrce.xrce139 = l_xrcc.xrcc138 - l_xrcc.xrcc139
 #          LET l_xrca113 = l_xrca113 - l_xrcc.xrcc118 - l_xrcc.xrcc119
 #          LET l_xrca103 = l_xrca113 / g_xrca.xrca101
 #       ELSE
 #          LET l_xrce.xrce007 = l_xrca113 / l_xrcc.xrcc101
 #          LET l_xrce.xrce007 = s_num_round('1',l_xrce.xrce007,l_ooaj004)
 #          LET l_xrce.xrce109 = l_xrce.xrce007
 #          LET l_xrce.xrce119 = l_xrca113
 #          LET l_xrce.xrce129 = l_xrce.xrce109 * l_xrcc.xrcc121
 #          LET l_xrce.xrce139 = l_xrce.xrce109 * l_xrcc.xrcc131
 #          LET l_xrca113 = 0
 #          LET l_xrca103 = 0
 #       END IF
 #    END IF
 #
 #    INSERT INTO xrce_t VALUES (l_xrce.*)
 #    IF SQLCA.sqlcode THEN
 #       LET g_success = 'N' RETURN
 #    END IF
 #
 # END FOREACH
 #
 # LET l_xrce.xrce109 = 0
 # LET l_xrce.xrce119 = 0
 # LET l_xrce.xrce129 = 0
 # LET l_xrce.xrce139 = 0
 #
 ##150316-00013#1 By 01727 Mark ---(S)---
 ##SELECT SUM(xrce119 * CASE WHEN xrce015 = 'D' THEN 1 ELSE -1 END)
 ##  INTO l_xrce.xrce119 FROM xrce_t WHERE xrceent = g_enterprise
 ##   AND xrcedocno = g_xrca.xrcadocno AND xrceld = g_xrca.xrcald
 ##IF cl_null(l_xrce.xrce119) THEN LET l_xrce.xrce119 = 0 END IF
 ##CALL s_curr_round_ld('1',g_xrca.xrcald,g_xrca.xrca100,l_xrce.xrce119 / g_xrca.xrca101,2)
 ##   RETURNING l_success,l_errno,l_xrce.xrce109
 ##
 ##IF g_glaa.glaa015 = 'Y' THEN
 ##   IF g_glaa.glaa017 = '1' THEN
 ##      LET l_xrce.xrce129 = l_xrce.xrce109 * g_xrca.xrca121
 ##   ELSE
 ##      LET l_xrce.xrce129 = l_xrce.xrce119 * g_xrca.xrca121
 ##   END IF
 ##END IF
 ##IF g_glaa.glaa019 = 'Y' THEN
 ##   IF g_glaa.glaa021 = '1' THEN
 ##      LET l_xrce.xrce139 = l_xrce.xrce109 * g_xrca.xrca131
 ##   ELSE
 ##      LET l_xrce.xrce139 = l_xrce.xrce119 * g_xrca.xrca131
 ##   END IF
 ##END IF
 ##UPDATE xrca_t SET xrca107 = l_xrce.xrce109,
 ##                  xrca117 = l_xrce.xrce119,
 ##                  xrca127 = l_xrce.xrce129,
 ##                  xrca137 = l_xrce.xrce139
 ## WHERE xrcaent = g_enterprise
 ##   AND xrcadocno = g_xrca.xrcadocno
 ##   AND xrcald = g_xrca.xrcald
 ##150316-00013#1 By 01727 Mark ---(E)---
 ##150316-00013#1 By 01727 Add  ---(S)---
 ##非應稅折抵存入xrca107
 # SELECT SUM(xrce119 * CASE WHEN xrce015 = 'D' THEN 1 ELSE -1 END)
 #   INTO l_xrce.xrce119 FROM xrce_t WHERE xrceent = g_enterprise
 #    AND xrcedocno = g_xrca.xrcadocno AND xrceld = g_xrca.xrcald
 #    AND xrce027 = 'N'
 # IF cl_null(l_xrce.xrce119) THEN LET l_xrce.xrce119 = 0 END IF
 # CALL s_curr_round_ld('1',g_xrca.xrcald,g_xrca.xrca100,l_xrce.xrce119 / g_xrca.xrca101,2)
 #    RETURNING l_success,l_errno,l_xrce.xrce109
 # 
 # IF g_glaa.glaa015 = 'Y' THEN
 #    IF g_glaa.glaa017 = '1' THEN
 #       LET l_xrce.xrce129 = l_xrce.xrce109 * g_xrca.xrca121
 #    ELSE
 #       LET l_xrce.xrce129 = l_xrce.xrce119 * g_xrca.xrca121
 #    END IF
 # END IF
 # IF g_glaa.glaa019 = 'Y' THEN
 #    IF g_glaa.glaa021 = '1' THEN
 #       LET l_xrce.xrce139 = l_xrce.xrce109 * g_xrca.xrca131
 #    ELSE
 #       LET l_xrce.xrce139 = l_xrce.xrce119 * g_xrca.xrca131
 #    END IF
 # END IF
 # UPDATE xrca_t SET xrca107 = l_xrce.xrce109,
 #                   xrca117 = l_xrce.xrce119,
 #                   xrca127 = l_xrce.xrce129,
 #                   xrca137 = l_xrce.xrce139
 #  WHERE xrcaent = g_enterprise
 #    AND xrcadocno = g_xrca.xrcadocno
 #    AND xrcald = g_xrca.xrcald
 ##應稅折抵存入xrca106
 # LET l_xrce.xrce109 = 0
 # LET l_xrce.xrce119 = 0
 # LET l_xrce.xrce129 = 0
 # LET l_xrce.xrce139 = 0
 # SELECT SUM(xrce119 * CASE WHEN xrce015 = 'D' THEN 1 ELSE -1 END)
 #   INTO l_xrce.xrce119 FROM xrce_t WHERE xrceent = g_enterprise
 #    AND xrcedocno = g_xrca.xrcadocno AND xrceld = g_xrca.xrcald
 #    AND xrce027 = 'Y'
 # IF cl_null(l_xrce.xrce119) THEN LET l_xrce.xrce119 = 0 END IF
 # CALL s_curr_round_ld('1',g_xrca.xrcald,g_xrca.xrca100,l_xrce.xrce119 / g_xrca.xrca101,2)
 #    RETURNING l_success,l_errno,l_xrce.xrce109
 # 
 # IF g_glaa.glaa015 = 'Y' THEN
 #    IF g_glaa.glaa017 = '1' THEN
 #       LET l_xrce.xrce129 = l_xrce.xrce109 * g_xrca.xrca121
 #    ELSE
 #       LET l_xrce.xrce129 = l_xrce.xrce119 * g_xrca.xrca121
 #    END IF
 # END IF
 # IF g_glaa.glaa019 = 'Y' THEN
 #    IF g_glaa.glaa021 = '1' THEN
 #       LET l_xrce.xrce139 = l_xrce.xrce109 * g_xrca.xrca131
 #    ELSE
 #       LET l_xrce.xrce139 = l_xrce.xrce119 * g_xrca.xrca131
 #    END IF
 # END IF
 # UPDATE xrca_t SET xrca106 = l_xrce.xrce109,
 #                   xrca116 = l_xrce.xrce119,
 #                   xrca126 = l_xrce.xrce129,
 #                   xrca136 = l_xrce.xrce139
 #  WHERE xrcaent = g_enterprise
 #    AND xrcadocno = g_xrca.xrcadocno
 #    AND xrcald = g_xrca.xrcald
 ##150316-00013#1 By 01727 Add  ---(E)---
 #
END FUNCTION
################################################################################
# Descriptions...: 依據客戶編號獲取默認值
# Memo...........:
# Usage..........: CALL axrp132_xrca004_ref()
#                  RETURNING r_xrca.*
# Input parameter: 
# Return code....: r_xrca         返回默认值
# Date & Author..: 2014/10/17 By zhangweib
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp132_xrca004_ref(p_isaf100)
DEFINE l_site         LIKE xrca_t.xrcasite
DEFINE l_ooba002      LIKE ooba_t.ooba002
DEFINE l_success      LIKE type_t.num5
DEFINE l_pmab085      LIKE pmab_t.pmab085
DEFINE l_oodbl004     LIKE oodbl_t.oodbl004
DEFINE l_oodb011      LIKE oodb_t.oodb011
#DEFINE l_ooib         RECORD LIKE ooib_t.* #161128-00061#3--mark
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
#150518-00044#5
DEFINE p_isaf100     LIKE isaf_t.isaf100
DEFINE ls_js         STRING
DEFINE lc_param      RECORD
         apca004     LIKE apca_t.apca004,
         sfin2009    LIKE type_t.chr1     #151012-00014#1 add lujh
                 END RECORD
#150518-00044#5
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
    WHERE pmabent = g_enterprise AND pmabsite = l_xrcacomp AND pmab001 = g_xrca.xrca004 #160505-00005#1# g_xrca.xrcacomp--->l_xrcacomp

   #STEP3.帳款類別
   SELECT pmab105 INTO r_xrca.xrca007 FROM pmab_t
    WHERE pmabent = g_enterprise AND pmabsite = l_xrcacomp AND pmab001 = g_xrca.xrca004 #160505-00005#1# g_xrca.xrcacomp--->l_xrcacomp
   
   #STEP4.業務人員/業務部門
   SELECT pmab081 INTO r_xrca.xrca014 FROM pmab_t
    WHERE pmabent = g_enterprise AND pmabsite = l_xrcacomp AND pmab001 = g_xrca.xrca004 #160505-00005#1# g_xrca.xrcacomp--->l_xrcacomp
   SELECT ooag003 INTO r_xrca.xrca015 FROM ooag_t
    WHERE ooagent = g_enterprise AND ooag001 = r_xrca.xrca014
   
   #STEP5.稅別/含稅否/稅率
   SELECT pmab084 INTO r_xrca.xrca011 FROM pmab_t
    WHERE pmabent = g_enterprise AND pmabsite = l_xrcacomp AND pmab001 = g_xrca.xrca004 #160505-00005#1# g_xrca.xrcacomp--->l_xrcacomp  
   IF NOT cl_null(r_xrca.xrca011) THEN
      CALL s_tax_chk(g_glaa.glaacomp,r_xrca.xrca011)
         RETURNING l_success,l_oodbl004,r_xrca.xrca013,r_xrca.xrca012,l_oodb011
   END IF
   
   #STEP6.慣用幣別/匯率
   LET r_xrca.xrca100 = p_isaf100
  #LET r_xrca.xrca100 = g_glaa.glaa001
   #計算各個本位筆匯率
   
  #CALL s_axrt300_get_exrate(g_xrca.xrcadocdt,g_xrca.xrcald,g_xrca.xrcacomp,r_xrca.xrca100)
  #   RETURNING l_success,r_xrca.xrca101,r_xrca.xrca121,r_xrca.xrca131
   #150518-00044#5--(S)
   LET lc_param.apca004 = g_xrca.xrca004
   LET lc_param.sfin2009 = g_master.b_comb1     #汇率基准   #151012-00014#1 add lujh
   LET ls_js = util.JSON.stringify(lc_param)
   #150518-00044#5--(E)
   CALL s_fin_get_curr_rate(g_xrca.xrcacomp,g_xrca.xrcald,g_xrca.xrcadocdt,r_xrca.xrca100,ls_js)    #150518-00044#5
      RETURNING r_xrca.xrca101,r_xrca.xrca121,r_xrca.xrca131
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
    WHERE pmabent = g_enterprise AND pmabsite = l_xrcacomp AND pmab001 = g_xrca.xrca004 #160505-00005#1# l_site--->l_xrcacomp
   
   #SETP11.客戶分類
   SELECT pmab090 INTO r_xrca.xrca006 FROM pmab_t
    WHERE pmabent = g_enterprise AND pmabsite = l_xrcacomp AND pmab001 = g_xrca.xrca004    #160505-00005#1# l_site--->l_xrcacomp

   RETURN r_xrca.*

END FUNCTION

################################################################################
# Descriptions...: 取得默認會計科目
# Memo...........:
# Usage..........: CALL axrp131_get_glab(p_glabld,p_glab001,p_glab002,p_glab003)
#                  RETURNING r_glab005
# Input parameter: p_glabld       帳套
#                : p_glab001      設定類型
#                : p_glab002      分類碼
#                : p_glab003      分類碼值
# Return code....: r_glab005      會計科目
# Date & Author..: 2014/10/17 By zhangweib
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp131_get_glab(p_glabld,p_glab001,p_glab002,p_glab003)
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
 
